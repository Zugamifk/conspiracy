local Selectable = Class()

function Selectable.Create(rect)
	return {
		state = "normal",
		rect = rect or Rect.Zero(),
		focused = false,
		dragoffset = {x=0,y=0}
	}
end

function Selectable:GetColor(style)
	local c = style.colors.selectable
	return c[self.state]
end

function Selectable:Draw(rect, style, drawf)
	drawf = drawf or UI.Draw.Box
	local color = self:GetColor(style)
	drawf(rect,color)
	self.rect = rect
end

function Selectable:Focus(isfocused)
	self.focused = isfocused
	if isfocused then
		self.state = "hover"
	else
		self.state = "normal"
	end
	console:Log("Focused "..tostring(self))
end

function Selectable:MouseDown()
	local x,y = love.mouse.getPosition()
	self.dragoffset = {
		x = x-self.rect.x,
		y = y-self.rect.y
	}
	self.state = "selected"
	console:Log("selected "..tostring(self))
	if self.onMouseDown then
		self:onMouseDown(self.dragoffset)
	end
end

function Selectable:MouseUp()
	self:Focus(self.focused)
	if self.onMouseUp then
		self:onMouseUp(self.dragoffset)
	end
end

function Selectable:Drag()
	local x,y = love.mouse.getPosition()
	self.dragoffset = {
		x = x-self.rect.x,
		y = x-self.rect.y
	}
	if self.onDrag then
		self:onDrag(self.dragoffset)
	end
end

function Selectable:Submit()
	if self.onSubmit then
		self:onSubmit()
	end
end

return Selectable
