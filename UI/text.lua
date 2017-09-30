local Text = Class()

function Text:Create(text)
	self.text = text or ""
end

function Text:Draw(rect, style)
	UI.Draw.Text(rect, self.text, style)
end

function Text:SetText(str)
	self.text = str
end

return Text
