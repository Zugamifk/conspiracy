local Selectable = Class()

function Selectable:Create(rect, callbacks)
	self.state = "normal"
	self.focused = false
	self.dragoffset = vec2(0,0)

	if callbacks then
		Selectable.SetCallbacks(self, callbacks)
	end
end

function Selectable:SetCallbacks(callbacks)
	for e,f in pairs(callbacks) do
		self[e] = f
		console:Log("set "..e)
	end
end

function Selectable:GetColor(style)
	local c = style.colors.selectable
	return c[self.state]
end

function Selectable:Draw(style, drawf)
	drawf = drawf or UI.Draw.Box
	local color = self:GetColor(style)
	drawf(self.rect,color)
end

function Selectable:Rebuild(rect, style)
	self.rect:Rebuild(rect)
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
	self.dragoffset = vec2(
		x-self.rect.x,
		y-self.rect.y
	)
	self.state = "selected"
	console:Log("selected "..tostring(self))
	if self.onMouseDown then
		self.onMouseDown(self.dragoffset)
	end
end

function Selectable:MouseUp()
	self:Focus(self.focused)
	if self.onMouseUp then
		self.onMouseUp(self.dragoffset)
	end
end

function Selectable:Drag()
	local x,y = love.mouse.getPosition()
	self.dragoffset = vec2(
		x-self.rect.x,
		y-self.rect.y
	)
	if self.onDrag then
		self.onDrag(self.dragoffset)
	end
end

function Selectable:Submit()
	if self.onSubmit then
		self.onSubmit()
	end
end

return Selectable
