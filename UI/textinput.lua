local TextInput = Class()

function TextInput.Create()
    local textinput = {
        text = UI.Text(),
        rect = Rect.Zero(),
        onSubmit = nil -- callback
    }

    return textinput
end

function TextInput:AddText(text)
    self.text:SetText(self.text.text..text)
end

function TextInput:Draw(rect, style)
    UI.Draw.FramedBox(rect, style)
    self.text:Draw(rect, style)
    self.rect = rect
end

function TextInput:Submit()
    if self.onSubmit then
        self.onSubmit()
    end
end

function TextInput:TextInput(text)
    self:AddText(text)
end

function TextInput:GetSelectables()
    return {self}
end

return TextInput
