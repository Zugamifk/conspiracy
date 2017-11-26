local TextBox = Class(
{
    type = "Text Box"
},
UI.Element)

function TextBox:Create(text)
    self:base()
    self.text = UI.Text(text)
    self.text.rect = UI.AnchoredRect(
        Rect(2,2,0,0),
        UI.AnchoredRect.presets.stretch.full)
    self:AddChild(self.text)
end

function TextBox:AddText(text)
    self.text:SetText(self.text.text..text)
end

function TextBox:SetText(text)
    self.text:SetText(text)
end

function TextBox:Draw(style)
    UI.Draw.FramedBox(self.rect, style)
    self.text:Draw(style)
end

return TextBox
