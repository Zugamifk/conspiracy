local Button = Class()

function Button:Create(text)
    local tb = self

    local text = UI.Text(text)
    tb.text = text

    local selectable = UI.Selectable()
    tb.selectable = selectable
end

function Button:Draw(style)
    UI.Draw.Box(self.selectable.rect, self:GetColor(style))
    self.text:Draw(style)
end

function Button:Rebuild(rect, style)
    self.selectable:Rebuild(rect, style)

    local ty = rect.y + rect.height / 2 - style.lineheight/2 +2
    rect.y = ty
    local tx = rect.x + 2
    rect.x = tx
    self.text:Rebuild(rect, style)
end

function Button:GetColor(style)
	local c = style.colors.button
	return c[self.selectable.state]
end

function Button:SetOnClick(onclick)
    self.selectable.onMouseUp = onclick
    self.selectable.onSubmit = onclick
end

function Button:GetSelectables()
    return {self.selectable}
end

return Button
