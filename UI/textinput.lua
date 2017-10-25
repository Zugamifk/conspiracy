local TextInput = Class(
{
    type = "TextInput"
},
UI.Element)

function TextInput:Create()
    self:base()
    self.text = UI.Text()
    self.text.rect = UI.AnchoredRect(
        Rect(2,-2,0,0),
        UI.AnchoredRect.presets.stretch.full)
    self.onSubmit = nil -- callback
end

function TextInput:AddText(text)
    self.text:SetText(self.text.text..text)
end

function TextInput:Draw(style)
    UI.Draw.FramedBox(self.rect, style)
    self.text:Draw(style)
end

function TextInput:Submit()
    console:Log("submit text")
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
