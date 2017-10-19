local Text = Class()

function Text:Create(text)
	self.text = text or ""
end

function Text:Draw(style)
	UI.Draw.Text(self.rect, self.text, style)
end

function Text:Rebuild(rect)
	self.rect:Rebuild(rect)
end

function Text:SetText(str)
	self.text = str
end

return Text
