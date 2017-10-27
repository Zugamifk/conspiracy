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
	-- normalized value to determine position of scrollbar
	self.scrollposition = 0
	-- all the contents of the scrollview, visible or otherwise
	self.contents = {}
	-- total height of all contents
	self.contentsheight = 0

	-- create scrollbar object
	local scrollbar = UI.Selectable()
	scrollbar.rect = UI.AnchoredRect(Rect.Zero(), UI.AnchoredRect.presets.topright)

	-- set parents for scrollbar
	local scrollrect = UI.AnchoredRect(Rect(0,0,10,0), UI.AnchoredRect.presets.stretch.rightvert)
	local scrollbarroot = UI.Element(scrollrect)
--	scrollbarroot:AddChild(scrollbar)
	self:AddChild(scrollbar)

	-- crate locals for storing use in callbacks
	local scrollmousestart = 0
	local scrollpositionstart = 0

	-- record current mouse y position and current scroll position
	function scrollbar.onMouseDown()
		_,scrollmousestart =love.mouse.getPosition()
		scrollpositionstart = self.scrollposition
	end

	-- calcaulate new scroll position
	function scrollbar.onDrag()
		local _,my = love.mouse.getPosition()
		self.scrollposition = scrollpositionstart+(my-scrollmousestart)/scrollbarroot.rect.height
		self.scrollposition = math.clamp(self.scrollposition,0,1)
	end

	self.scrollbar = scrollbar

end

function ScrollView:Draw(style)
	--draw frame
	UI.Draw.FramedBox(self.rect, style)

	-- this stencil is for objects in viewport
	--UI.BeginMask(self.rect)

	for _,o in ipairs(self.children) do
		o:Draw(style)
	end

	self.scrollbar:Draw(style)

	--UI.EndMask()

end

function ScrollView:PrepareRebuild(rect, style)
	-- rebuild the scroll bar
	local scrollbarheight = self.rect.height
	-- if contents taller than viewport, draw the scrollbar
	if scrollbarheight < self.contentsheight then
		-- calculate scrollbar size
		local scrollbarsize = math.max(
			style.scrollbarminheight,
			scrollbarheight/self.contentsheight
		)
		local sdiff = (1-scrollbarsize)
		local srect = self.scrollbar.rect
		srect.anchormin = vec2(
			srect.anchormin.x,
			self.scrollposition * sdiff
		)
		srect.anchormax = vec2(
			srect.anchormax.x,
			scrollbarsize + self.scrollposition * sdiff
		)
		srect.padding = vec2(
			style.scrollbarwidth,
			0
		)
		--console:Log(tostring(srect))
	end

	self.children = {} -- clear visible contents table

	-- find position to start drawing
	local yposition = 0
	local viewporty = self.scrollposition
		* math.max(self.contentsheight - self.rect.height, 0)
	local startposition = yposition
	if self.options.startsfrom == "bottom" then
		startposition = math.max(0, self.rect.height - self.contentsheight)
	end

	local len = self:ContentsLength()
	for i,o in ipairs(self.contents) do
		if self.options.direction == "up" then
			o = self.contents[len - i + 1]
		end
		-- collect objects that fit in the viewport
		if yposition + o.rect.height >= viewporty then
			self:AddChild(o)
			o.rect.offset.y = yposition
		end
		yposition = yposition + o.rect.height
		if yposition >= viewporty + self.rect.height then
			break
		end
	end
end

function ScrollView:AddObject(object, position)
	position = position or #self.contents+1
	self.contentsheight = self.contentsheight + object.rect.height
	table.insert(self.contents, position, object)
end

function ScrollView:GetObject(index)
	return self.contents[index] or nil
end

function ScrollView:RemoveObject(index)
	table.remove(self.contents, index)
end

function ScrollView:ContentsLength()
	return #self.contents
end

function ScrollView:GetSelectables()
	return {self.scrollbar}
end

return ScrollView
