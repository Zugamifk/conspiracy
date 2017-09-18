local Text = Class()

function Text.Create(text)
	return {
		text = text
	}
end

function Text:Draw(rect, style)
	UI.Draw.Text(rect, self.text, style)
end

function Text:SetText(str)
	self.text = str
end

return Text