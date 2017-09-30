local KeyFrameEditor = Class()

function KeyFrameEditor.Create()
    local kfe = {
        focused = false,
        selectable = UI.Selectable(),

        position = vec2(0,0),

        keyframe = nil,
        nodeeditors = {},


        -- callbacks
        onSelectedField = nil
    }
    function kfe.selectable:onMouseUp(p)
        KeyFrameEditor.MouseUp(kfe, p)
    end
    return kfe
end

function KeyFrameEditor:Draw(rect, style)
    UI.Draw.FramedBox(rect, style, self.focused)

    UI.BeginMask(rect)

    local linespace = 50
    local min = self:RectToKeyFrameSpace(rect, vec2(0,0))
    local max = self:RectToKeyFrameSpace(rect, vec2(rect.width, rect.height))
    local origin = self:KeyFrameToRectSpace(rect, self.position)
    love.graphics.setColor(style.colors.line1)
    for x = math.floor(min.x), math.ceil(max.x) do
        love.graphics.line(rect.x+origin.x+x*linespace, rect.y, rect.x+origin.x+x*linespace, rect.y+rect.height)
    end
    for y = math.floor(min.y), math.ceil(max.y) do
        love.graphics.line(rect.x, rect.y+origin.y+y*linespace, rect.x+rect.width, rect.y+origin.y+y*linespace)
    end
    for n in self.keyframe:Nodes() do
        local ne = self.nodeeditors[n]
        if ne then
        local ner = rect:Copy()
            ner.width = 16
            ner.height = 16
            ner:SetPositionByCentre(rect:Position() + self:KeyFrameToRectSpace(rect, n.position))
            ne:Draw(ner, style)
        end
    end
    UI.EndMask()

    self.selectable.rect = rect:Copy()
end

function KeyFrameEditor:RefreshKeyFrame()
    console:Log("refreshing keyframe")
    for n in self.keyframe:Nodes() do
        if not self.nodeeditors[n] then
            self:AddNodeEditor(n)
        end
    end
end

function KeyFrameEditor:RectToKeyFrameSpace(rect, vec)
    local xi, yi = vec.x/rect.width, vec.y/rect.height
    local asp = rect.height/rect.width
    return vec2(
        (xi*2-1)/asp + self.position.x,
        (yi*2-1) + self.position.y
    )
end

function KeyFrameEditor:KeyFrameToRectSpace(rect, vec)
    local asp = rect.height/rect.width
    local xi, yi = (vec.x-self.position.x)*asp, vec.y-self.position.y
    return vec2(
        (xi+1)/2 * rect.width,
        (yi+1)/2 * rect.height
    )
end

function KeyFrameEditor:AddNodeEditor(node)
    console:Log("added node editor")
    local editor = Animation.Editor.NodeEditor(node)
    self.nodeeditors[node] = editor
end

function KeyFrameEditor:Drag(pos)
    self.position = self.position + pos
end

function KeyFrameEditor:MouseUp(pos)
    pos = self:RectToKeyFrameSpace(self.selectable.rect, pos)
    if self.onSelectedField then
        self.onSelectedField(pos)
    end
end

function KeyFrameEditor:GetSelectables()
    local results =
        tablep.map(
            self.nodeeditors,
            function(ne) return ne:GetSelectables() end)
        :fold()
        :concat({self.selectable})
        :totable()
    console:Log("returning "..#results.." results")
    return results
end

return KeyFrameEditor
