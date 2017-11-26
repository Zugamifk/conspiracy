local Window = Class({
	type = "Window"
},
UI.Element)

function Window:Create(rect)
	self:base()
	self.focused = false
	self.objects = {}

	self.dragoffset = {x=0,y=0}

	self.selectables = {}

	self.enabled = false -- if true, is visible and active

	-- options
	-- can teh window be dragged?
	self.draggable = true

	-- should we draw the frame of the window?
	self.drawframe = true

	-- should the window itself take input events?
	self.canfocus = true

	if rect then
		self.rect = rect:Copy()
	end
end

function Window:AddObject(object, rect)
	if rect then
		object.rect = rect
	end
	self:AddChild(object)
end

function Window:Draw(style)
	if self.drawframe then
		UI.Draw.FramedBox(self.rect, style, self.focused)
	end
	for i,o in ipairs(self.children) do
		o:Draw(style)
	end
end

function Window:Focus(isfocused)
	self.focused = isfocused
end

function Window:MouseDown(button)
	if button == 1 then
		local x,y = love.mouse.getPosition()
		self.dragoffset = vec2(
			self.rect.x - x,
			self.rect.y - y
		)
	end
end

function Window:Drag(button)
	if button == 1 then
		if self.draggable then
			local x,y = love.mouse.getPosition()
			self.rect:Translate(vec2(x,y)+self.dragoffset)
			console:Log(self.rect)
		end
	end
end

function Window:SetActive(enabled)
	self.enabled = enabled
	if enabled then
		self:RefreshSelectablesCache()
	end
end

function Window:RefreshSelectablesCache()
	local i =1
	for _,o in ipairs(self.children) do
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

-- collect selectables
function Window:OnRebuild(rect, style)
	self:RefreshSelectablesCache()
end

return Window
