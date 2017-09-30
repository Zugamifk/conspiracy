local NodeEditor = Class()

function NodeEditor:Create(node)
    self.focused = false
    self.selectable = nil
    self.circle = Circle()
    self.node = node

    self.selectable = nil

    -- callbacks
    self.onSelectedNode = nil -- function(self)
    self.onMoveNode = nil -- function(self, pos)

    local callbacks = {
        onMouseUp = callback(self, NodeEditor.MouseUp),
        onDrag = callback(self, NodeEditor.Drag)
    }
    local sel = UI.Selectable(nil, callbacks)
    self.selectable = sel
end

function NodeEditor:Draw(rect, style)
    local centre = rect:Centre()
    local r = math.min(rect.width, rect.height)/2
    self.circle.x = centre.x
    self.circle.y = centre.y
    self.circle.r = r
    local c = self.selectable:GetColor(style)
    UI.Draw.Circle(self.circle, c)

    -- refactor out
    self.selectable.rect = rect:Copy()
end

function NodeEditor:SetNode(node)
    self.node = node
end

function NodeEditor:Drag(pos)
    if self.onMoveNode then
        console:Log("dragged node to "..tostring(pos))
        self:onMoveNode(pos)
    end
end

function NodeEditor:MouseUp()
    if self.onSelectedNode then
        self:onSelectedNode()
    end
end

function NodeEditor:GetSelectables()
    return {self.selectable}
end

return NodeEditor
