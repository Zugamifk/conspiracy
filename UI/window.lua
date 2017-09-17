local Window = Class()

function Window.Create(rect)
	return {
		rect = rect,
		focused = false
	}
end

function Window:Draw(_,style)
	UI.Box(self.rect, style, self.focused)
end

function Window:Focus(isfocused)
	self.focused = isfocused
end

return Window