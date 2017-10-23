local ScrollView = Class({
	type = "ScrollView"
},
UI.Element)

function ScrollView:Create()
	self:base()
	self.options = {
			startsfrom = "top", -- also, "bottom"
			direction = "down"
		}
	self.scrollposition = 0
	self.contents = {}
	self.visiblecontents = {}
	self.contentsheight = 0
	self.scrollheight = 0

	-- local scrollbar = UI.Selectable(Rect.Zero())
	-- local scrollmousestart = 0
	-- local scrollpositionstart = 0
	-- function scrollbar.onMouseDown()
	-- 	_,scrollmousestart =love.mouse.getPosition()
	-- 	scrollpositionstart = scrollview.scrollposition
	-- end
	-- function scrollbar.onDrag()
	-- 	local _,my = love.mouse.getPosition()
	-- 	self.scrollposition = scrollpositionstart+(my-scrollmousestart)/self.scrollheight
	-- 	self.scrollposition = math.clamp(self.scrollposition,0,1)
	-- end
	-- self.scrollbar = scrollbar
end

function ScrollView:Draw(style)
	--draw frame
	UI.Draw.FramedBox(self.rect, style)

	-- this stencil is for objects in viewport
	-- UI.BeginMask(self.rect)
	--
	-- for _,o in ipairs(self.visiblecontents) do
	-- 	o:Draw(style)
	-- end
	--
	-- self.scrollbar:Draw(style)
	--
	-- UI.EndMask()

end

function ScrollView:OnRebuild(rect, style)
	-- self.visiblecontents = {} -- clear visible contents table
	--
	-- -- find position to start drawing
	-- local yposition = 0
	-- local viewporty = self.scrollposition
	-- 	* math.max(self.contentsheight - self.rect.height, 0)
	-- local startposition = yposition
	-- if self.options.startsfrom == "bottom" then
	-- 	startposition = math.max(0, self.rect.height - self.contentsheight)
	-- end
	--
	-- local len = self:ContentsLength()
	-- for i,o in ipairs(self.contents) do
	-- 	if self.options.direction == "up" then
	-- 		o = self.contents[len - i + 1]
	-- 	end
	-- 	-- rebuild objects that fit in the viewport
	-- 	if yposition + o.rect.height >= viewporty then
	-- 		local r = o.rect:Copy()
	-- 		r.y =  self.rect.y + startposition + yposition - viewporty
	-- 		r.x = self.rect.x
	-- 		r.width = self.rect.width
	-- 		self.visiblecontents[#self.visiblecontents+1] = o
	-- 		o.object:Rebuild(rect, style)
	-- 	end
	-- 	yposition = yposition + o.rect.height
	-- 	if yposition >= viewporty + self.rect.height then
	-- 		break
	-- 	end
	-- end
	--
	-- -- rebuild the scroll bar
	-- local scrollbarheight = self.rect.height-style.scrollbarpadding*2
	-- if scrollbarheight < self.contentsheight then
	-- 	local scrollbarsize = math.max(
	-- 		style.scrollbarminheight,
	-- 		2*scrollbarheight/self.contentsheight
	-- 	)
	-- 	local scrollbary = style.scrollbarpadding +
	-- 		self.scrollposition * (scrollbarheight-scrollbarsize)
	-- 	self.scrollbar:Rebuild(Rect(
	-- 		rect.x + rect.width - style.scrollbarpadding - style.scrollbarwidth,
	-- 		rect.y + scrollbary,
	-- 		style.scrollbarwidth,
	-- 		scrollbarsize
	-- 	),
	-- 	style)
	-- end
	-- self.scrollheight = rect.height - style.scrollbarpadding*2 - self.scrollbar.rect.height
end

function ScrollView:AddObject(object, rect, position)
	position = position or #self.contents+1
	local newObject = {
		object = object,
		rect = rect
	}
	self.contentsheight = self.contentsheight + rect.height
	table.insert(self.contents, position, newObject)
end

function ScrollView:GetObject(index)
	return self.contents[index] and self.contents[index].object or nil
end

function ScrollView:RemoveObject(index)
	table.remove(self.contents, index)
end

function ScrollView:ContentsLength()
	return #self.contents
end

function ScrollView:GetSelectables()
	return self.scrollbar
end

return ScrollView
