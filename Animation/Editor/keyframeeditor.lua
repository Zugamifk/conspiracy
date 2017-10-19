local KeyFrameEditor = Class()

function KeyFrameEditor:Create()
    self.focused = false
    self.selectable = UI.Selectable(nil,{
        onMouseUp = callback(self, KeyFrameEditor.MouseUp)
    })

    self.position = vec2(0,0)
    self.rectorigin = vec2(0,0) -- position in rect space

    self.keyframe = nil -- current keyframe being edited
    self.selectednode = nil -- current selected node

    self.nodeeditors = {}

    -- callbacks
    self.onSelectedField = nil -- function(pos)
    self.onMoveNode = nil -- function(node, pos)
end

function KeyFrameEditor:Draw(rect, style)
    UI.Draw.FramedBox(rect, style, self.focused)

    UI.BeginMask(rect)

    local linespace = 50
    local min = self:RectToKeyFrameSpace(rect, vec2(0,0))
    local max = self:RectToKeyFrameSpace(rect, vec2(rect.width, rect.height))
    local origin = rect:Centre()

    -- background grid
    love.graphics.setColor(style.colors.line1)
    for x = math.floor(min.x), math.ceil(max.x) do
        love.graphics.line(
            origin.x+x*linespace,
            rect.y,
            origin.x+x*linespace,
            rect.y+rect.height)
    end
    for y = math.floor(min.y), math.ceil(max.y) do
        love.graphics.line(
            rect.x,
            origin.y+y*linespace,
            rect.x+rect.width,
            origin.y+y*linespace)
    end

    -- nodes
    for n in self.keyframe:Nodes() do
        local ne = self.nodeeditors[n]
        if ne then
            local ner = rect:Copy()
            ner.width = 16
            ner.height = 16
            ner:SetPositionByCentre(
                rect:Position() + self:KeyFrameToRectSpace(rect, n.position))
            ne:Draw(ner, style)
        end
    end

    UI.EndMask()

    self.selectable.rect = rect:Copy()
    self.rectorigin = origin
end

-- set current keyframe and reinitialize
function KeyFrameEditor:SetKeyFrame(keyframe)
    self.keyframe = keyframe
    self:RefreshKeyFrame()
end

-- reinitialize editor with current keyframe
function KeyFrameEditor:RefreshKeyFrame()
    console:Log("refreshing keyframe")
    for n, e in pairs(self.nodeeditors) do
        if not self.keyframe:HasNode(n) then
            self.nodeeditors[n] = nil
        end
    end
    if self.keyframe then
        for n in self.keyframe:Nodes() do
            if not self.nodeeditors[n] then
                self:AddNodeEditor(n)
            end
        end
    end
end

-- transform a position in the rect to a position in keyframe space
function KeyFrameEditor:RectToKeyFrameSpace(rect, vec)
    local xi, yi = vec.x/rect.width, vec.y/rect.height
    local asp = rect.height/rect.width
    return vec2(
        (xi*2-1)/asp + self.position.x,
        (yi*2-1) + self.position.y
    )
end

-- transform a position in keyframe space to a position in the rect
function KeyFrameEditor:KeyFrameToRectSpace(rect, vec)
    local asp = rect.height/rect.width
    local xi, yi = (vec.x-self.position.x)*asp, vec.y-self.position.y
    return vec2(
        (xi+1)/2 * rect.width,
        (yi+1)/2 * rect.height
    )
end

-- add a new editor for a node
function KeyFrameEditor:AddNodeEditor(node)
    console:Log("added node editor")
    local editor = Animation.Editor.NodeEditor(node)
    function editor.onMoveNode(node, pos)
        pos = vec2(love.mouse.getPosition())-self.selectable.rect:Position()
        if self.onMoveNode then
            pos = self:RectToKeyFrameSpace(self.selectable.rect, pos)
            self.onMoveNode(node.node, pos)
        end
    end
    self.nodeeditors[node] = editor
end

-- event when selecting a node
function KeyFrameEditor:SelectNode(node)
    self.selectednode = node
end

-- event when dragging in the field
function KeyFrameEditor:Drag(pos)
    self.position = self.position + pos
end

-- event when clicking in the field
function KeyFrameEditor:MouseUp(pos)
    if self.selectednode == nil then
        pos = self:RectToKeyFrameSpace(self.selectable.rect, pos)
        if self.onSelectedField then
            self.onSelectedField(pos)
        end
    else
        self.selectednode = nil
    end
end

-- get all selectable objects in this editor
function KeyFrameEditor:GetSelectables()
    local results =
        tablep.map(
            self.nodeeditors,
            function(ne) return ne:GetSelectables() end)
        :fold()
        :concat({self.selectable})
        :totable()
--    console:Log("returning "..#results.." results")
    return results
end

return KeyFrameEditor
