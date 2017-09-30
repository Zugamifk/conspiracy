local NodeEditor = Class()

function NodeEditor.Create(node)
    local ne = {
        focused = false,
        selectable = UI.Selectable(),
        circle = Circle(),
        node = node,

        -- callbacks
        onSelectedNode = nil,
        onMoveNode = nil
    }
    function ne.selectable:onMouseUp(p)
        NodeEditor.MouseUp(ne, p)
    end
    return ne
end

function NodeEditor:Draw(rect, style)
    local centre = rect:Centre()
    local r = math.min(rect.width, rect.height)/2
    self.circle.x = centre.x
    self.circle.y = centre.y
    self.circle.r = r
    local c = self.selectable:GetColor(style)
    UI.Draw.Circle(self.circle, c)
    self.selectable.rect = rect:Copy()
end

function NodeEditor:SetNode(node)
    self.node = node
end

function NodeEditor:Drag(pos)
    self.position = self.position + pos
end

function NodeEditor:MouseUp(pos)
    if self.onSelectedNode then
        self.onSelectedField(pos)
    end
end

function NodeEditor:GetSelectables()
    return {self.selectable}
end

return NodeEditor
