local KeyFrameEditor = Class({
    type = "Key Frame Editor"
},
UI.Element)

function KeyFrameEditor:Create()
    self:base()
    self.focused = false
    self.selectable = UI.Selectable(nil,{
        onMouseUp = callback(self, KeyFrameEditor.MouseUp)
    })
    self:AddChild(self.selectable)

    self.position = vec2(0,0)
    self.rectorigin = vec2(0,0) -- position in rect space

    self.keyframe = nil -- current keyframe being edited
    self.selectednode = nil -- current selected node

    self.nodeeditors = {}

    -- callbacks
    -- called when clicking the background
    self.onSelectedField = nil -- function(pos)
    -- called when dragging a node
    self.onMoveNode = nil -- function(node, pos)
    -- called when two nodes are connected
    self.onConnectNodes = nil
end

function KeyFrameEditor:Draw(style)
    UI.Draw.FramedBox(self.rect, style, self.focused)

    UI.BeginMask(self.rect)

    local min = self:RectToKeyFrameSpace(vec2(0,0))
    local max = self:RectToKeyFrameSpace(self.rect:GetSize())
    local origin = self.rect:Centre()
    local linespace = self.rect.height/3

    -- background grid
    local ry = self.rect.y
    local rx = self.rect.x
    love.graphics.setColor(style.colors.line1)
    for x = math.floor(min.x), math.ceil(max.x) do
        local lx = x*linespace
        love.graphics.line(
            origin.x+lx,
            ry,
            origin.x+lx,
            ry+self.rect.height)
    end
    for y = math.floor(min.y), math.ceil(max.y) do
        local ly = y*linespace
        love.graphics.line(
            rx,
            origin.y+ly,
            rx+self.rect.width,
            origin.y+ly)
    end



    -- new connection line
    if self.selectednode then
        local pos = self.selectednode.rect:GetPosition() +
            self.selectednode.rect:GetSize()/2
        love.graphics.line(pos.x,pos.y,love.mouse.getPosition())
    end

    -- connectiond
    for e in self.keyframe:Connections() do
        local a = e.a.rect:GetPosition()
        local b = e.b.rect:GetPosition()
        love.graphics.line(a.x,a.y,b.x,b.y)
    end

    -- nodes
    for n in self.keyframe:Nodes() do
        local ne = self.nodeeditors[n]
        if ne then
            ne:Draw(style)
        end
    end

    UI.EndMask()

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
            self:RemoveNodeEditor(n)
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
function KeyFrameEditor:RectToKeyFrameSpace(vec)
    local xi, yi = vec.x/self.rect.width, vec.y/self.rect.height
    local asp = self.rect.height/self.rect.width
    return vec2(
        (xi*2-1)/asp + self.position.x,
        (yi*2-1) + self.position.y
    )
end

-- transform a position in keyframe space to a position in the rect
function KeyFrameEditor:KeyFrameToRectSpace(vec)
    local asp = self.rect.height/self.rect.width
    local xi, yi = (vec.x)*asp, vec.y
    return vec2(
        (xi+1)/2 * self.rect.width,
        (yi+1)/2 * self.rect.height
    )
end

-- add a new editor for a node
function KeyFrameEditor:AddNodeEditor(node)
    console:Log("added node editor")
    local editor = Animation.Editor.NodeEditor(node)
    function editor.onMoveNode(node, pos)
        pos = vec2(love.mouse.getPosition())-self.selectable.rect:GetPosition()
        if self.onMoveNode then
            pos = self:RectToKeyFrameSpace(pos)
            self.onMoveNode(node.node, pos)
        end
    end
    function editor.onSelectedNode(node,button)
        console:Log("selected! "..button)
        if button == 1 then
            if self.selectednode and self.selectednode ~= editor then
                self:ConnectNodes(editor, self.selectednode)
            end
            console:Log("selected for fake!")
        elseif button == 2 then
            console:Log("selected for real!")
            self.selectednode = editor
        end
    end
    self.nodeeditors[node] = editor
    self:AddChild(editor)
end

function KeyFrameEditor:RemoveNodeEditor(editor)
    self:RemoveChild(editor)
    self.nodeeditors[editor.node] = nil
end

function KeyFrameEditor:ConnectNodes(a,b)
    if self.onConnectNodes then
        self.onConnectNodes(a,b)
    end
end

-- event when clicking in the field
function KeyFrameEditor:MouseUp(pos, button)
    console:Log(pos)
    if button == 1 then
        if self.selectednode == nil then
            pos = self:RectToKeyFrameSpace(pos)
            if self.onSelectedField then
                self.onSelectedField(pos)
            end
        else
            self.selectednode = nil
        end
    end
end

function KeyFrameEditor:PrepareRebuild(rect,style)
    for n, e in pairs(self.nodeeditors) do
        local np = self:KeyFrameToRectSpace(e.node.position)
        e.rect.offset = np - e.rect:GetSize()/2
    --    console:Log(tostring(np).." <- "..tostring(e.node.position))
    end
end

-- get all selectable objects in this editor
function KeyFrameEditor:GetSelectables()
    local results =
        tablep.map(
            self.nodeeditors,
            function(ne) return ne:GetSelectables() end)
        :flatten()
        :concat({self.selectable})
        :totable()
--    console:Log("returning "..#results.." results")
    return results
end

return KeyFrameEditor
