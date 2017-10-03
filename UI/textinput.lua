local TextInput = Class()

function TextInput:Create()
    self.text = UI.Text()
    self.rect = Rect.Zero()
    self.onSubmit = nil -- callback
end

function TextInput:AddText(text)
    self.text:SetText(self.text.text..text)
end

function TextInput:Draw(style)
    UI.Draw.FramedBox(self.rect, style)
    self.text:Draw(style)
end

function TextInput:Rebuild(rect, style)
    self.text:Rebuild(rect, style)
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
