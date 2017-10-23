local Button = Class()

function Button:Create(text)
    local tb = self

    local text = UI.Text(text)
    text.rect = UI.AnchoredRect(Rect(2,-2,0,0), UI.AnchoredRect.presets.stretch.full)
    tb.text = text

    local selectable = UI.Selectable()
    selectable.rect = UI.AnchoredRect(Rect.Zero(), UI.AnchoredRect.presets.stretch.full)
    tb.selectable = selectable
end

function Button:Draw(style)
    UI.Draw.Box(self.selectable.rect, self:GetColor(style))
    self.text:Draw(style)
end

function Button:Rebuild(rect, style)
    self.rect:Rebuild(rect)
    self.selectable:Rebuild(self.rect, style)
    self.text:Rebuild(self.rect, style)
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
