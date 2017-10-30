local Text = Class({
	type = "Text"
},
UI.Element)

function Text:Create(text)
	self:base()
	self.text = text or ""
	self.rect = nil
end

function Text:Draw(style)
	UI.Draw.Text(self.rect, self.text, style)
end

function Text:SetText(str)
	self.text = str
end

return Text
