local Window = Class()

function Window.Create(rect)
	return {
		rect = rect,
		focused = false,
		objects = {},

		dragoffset = {x=0,y=0},

		selectables = {},

		enabled = false -- if true, is visible and active
	}
end

function Window:AddObject(object, rect)
	if not rect then
		rect = self.rect:Copy()
		rect.x = 0
		rect.y = 0
	end
	self.objects[#self.objects+1] = {object = object, rect = rect}
	if object.GetSelectables then
		local selectables = object:GetSelectables()
		if selectables then
			for _,s in ipairs(selectables) do
				self.selectables[#self.selectables+1] = s
			end
		end
	end
end

function Window:Draw(_,style)
	UI.Draw.FramedBox(self.rect, style, self.focused)
	for i,o in ipairs(self.objects) do
		local rect = o.rect:Copy()
		rect.x = rect.x + self.rect.x
		rect.y = rect.y+self.rect.y
		o.object:Draw(rect, style)
	end
end

function Window:Focus(isfocused)
	self.focused = isfocused
	local x,y = love.mouse.getPosition()
	self.dragoffset = {
		x = self.rect.x - x,
		y = self.rect.y - y
	}
end

function Window:MouseDown()
	local x,y = love.mouse.getPosition()
	self.dragoffset = {
		x = self.rect.x - x,
		y = self.rect.y - y
	}
end

function Window:Drag()
	local x,y = love.mouse.getPosition()
	self.rect.x = x+self.dragoffset.x
	self.rect.y = y+self.dragoffset.y
end

function Window:SetActive(enabled)
	self.enabled = enabled
end
return Window
