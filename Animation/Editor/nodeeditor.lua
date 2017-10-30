local NodeEditor = Class({
    type = "Node Editor"
},
UI.Element)

function NodeEditor:Create(node)
    local rect = UI.AnchoredRect(
        Rect(0,0,50,50),
        UI.AnchoredRect.presets.topleft)
    self:base(rect)
    self.focused = false
    self.selectable = nil
    self.circle = Circle()
    self.node = node

    -- callbacks
    self.onSelectedNode = nil -- function(self)
    self.onMoveNode = nil -- function(self, pos)

    local callbacks = {
        onMouseUp = callback(self, NodeEditor.MouseUp),
        onDrag = callback(self, NodeEditor.Drag)
    }
    local sel = UI.Selectable(nil, callbacks)
    self.selectable = sel
    self:AddChild(sel)
end

function NodeEditor:Draw(style)
    local centre = self.rect:Centre()
    local r = math.min(self.rect.width, self.rect.height)/2
    self.circle.x = centre.x
    self.circle.y = centre.y
    self.circle.r = r
    local c = self.selectable:GetColor(style)
    UI.Draw.Circle(self.circle, c)
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
