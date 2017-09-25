local Button = Class()

function Button.Create(text)
    local tb = {
    }

    local text = UI.Text(text)
    tb.text = text

    local selectable = UI.Selectable()
    tb.selectable = selectable

    return tb
end

function Button:Draw(rect, style)
    self.selectable:Draw(rect, style)
    local ty = rect.y + rect.height / 2 - style.lineheight/2 +2
    rect.y = ty
    local tx = rect.x + 2
    rect.x = tx
    self.text:Draw(rect, style)
    self.selectable.rect = rect
end

function Button:SetOnClick(onclick)
    self.selectable.onMouseUp = onclick
    self.selectable.onSubmit = onclick
end

function Button:GetSelectables()
    return self.selectable
end

return Button
