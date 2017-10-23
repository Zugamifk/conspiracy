local Window = Class()

function Window:Create(rect)
	self.rect = nil
	self.focused = false
	self.objects = {}

	self.dragoffset = {x=0,y=0}

	self.selectables = {}

	self.enabled = false -- if true, is visible and active

	if rect then
		self.rect = rect:Copy()
	end
end

function Window:AddObject(object, rect)
	self.objects[#self.objects+1] = object
	object.rect = rect
end

function Window:Draw(style)
	UI.Draw.FramedBox(self.rect, style, self.focused)
	for i,o in ipairs(self.objects) do
		o:Draw(style)
	end
end

function Window:Focus(isfocused)
	self.focused = isfocused
	local x,y = love.mouse.getPosition()
	self.dragoffset = vec2(
		self.rect.x - x,
		self.rect.y - y
	)
end

function Window:MouseDown()
	local x,y = love.mouse.getPosition()
	self.dragoffset = vec2(
		self.rect.x - x,
		self.rect.y - y
	)
end

function Window:Drag()
	local x,y = love.mouse.getPosition()
	self.rect:Translate(vec2(x,y)+self.dragoffset)
	console:Log(self.rect)
end

function Window:SetActive(enabled)
	self.enabled = enabled
	if enabled then
		self:RefreshSelectablesCache()
	end
end

function Window:RefreshSelectablesCache()
	local i =1
	for _,o in ipairs(self.objects) do
		if o.GetSelectables then
			local selectables = o:GetSelectables()
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
	--console:Log("refreshed selectables: now "..#self.selectables)
end

-- rebuild rects and reposition object, regenrate graphics
function Window:Rebuild(rect, style)
	self.rect:Rebuild(rect)
	self:RefreshSelectablesCache()
	for _,o in ipairs(self.objects) do
		o:Rebuild(self.rect, style)
	end
end

return Window
