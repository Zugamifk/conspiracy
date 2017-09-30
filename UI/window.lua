local Window = Class()

function Window:Create(rect)
	self.rect = rect:Copy()
	self.focused = false
	self.objects = {}

	self.dragoffset = {x=0,y=0}

	self.selectables = {}

	self.enabled = false -- if true, is visible and active
end

function Window:AddObject(object, rect)
	if not rect then
		rect = self.rect:Copy()
		rect.x = 0
		rect.y = 0
	end
	self.objects[#self.objects+1] = {object = object, rect = rect}
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
	if enabled then
		self:RefreshSelecablesCache()
	end
end

function Window:RefreshSelecablesCache()
	local i =1
	for _,o in ipairs(self.objects) do
		if o.object.GetSelectables then
			local selectables = o.object:GetSelectables()
			if selectables then
				for _,s in ipairs(selectables) do
					self.selectables[i] = s
					i = i + 1
				end
			end
		end
	end
	if i < #self.selectables then
		for j = i,#self.selectables do
			self.selectables[j] = nil
		end
	end
	console:Log("refreshed selectables: now "..#self.selectables)
end

return Window
