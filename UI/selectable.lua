local Selectable = Class(
{
	type = "Selectable"
},
UI.Element)

function Selectable:Create(rect, callbacks)
	self:base()
	self.state = "normal"
	self.focused = false
	self.dragoffset = vec2(0,0)
	self.rect = rect or UI.AnchoredRect(Rect.Zero(), UI.AnchoredRect.presets.stretch.full)

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

function Selectable:Focus(isfocused)
	self.focused = isfocused
	if isfocused then
		self.state = "hover"
	else
		self.state = "normal"
	end
	console:Log("Focused "..tostring(self))
end

function Selectable:MouseDown(button)
	local x,y = love.mouse.getPosition()
	self.dragoffset = vec2(
		x-self.rect.x,
		y-self.rect.y
	)
	self.state = "selected"
	console:Log("selected "..tostring(self))
	if self.onMouseDown then
		self.onMouseDown(self.dragoffset, button)
	end
end

function Selectable:MouseUp(button)
	self:Focus(self.focused)
	if self.onMouseUp then
		self.onMouseUp(self.dragoffset, button)
	end
end

function Selectable:Drag(button)
	local x,y = love.mouse.getPosition()
	self.dragoffset = vec2(
		x-self.rect.x,
		y-self.rect.y
	)
	if self.onDrag then
		self.onDrag(self.dragoffset, button)
	end
end

function Selectable:Submit(button)
	if self.onSubmit then
		self.onSubmit(button)
	end
end

return Selectable
