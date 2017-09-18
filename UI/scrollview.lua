local ScrollView = Class()
	
function ScrollView.Create()
	local scrollview = {
		scrollposition = 0,
		contents = {},
		contentsheight = 0,
		scrollheight = 0
	}
	
	local scrollbar = UI.Selectable(Rect.Zero())
	local scrollmousestart = 0
	local scrollpositionstart = 0
	function scrollbar:onMouseDown()
		_,scrollmousestart =love.mouse.getPosition()
		scrollpositionstart = scrollview.scrollposition
	end
	function scrollbar:onDrag()
		local _,my = love.mouse.getPosition()
		scrollview.scrollposition = scrollpositionstart+(my-scrollmousestart)/scrollview.scrollheight
		scrollview.scrollposition = math.clamp(scrollview.scrollposition,0,1)
	end
	scrollview.scrollbar = scrollbar
	return scrollview
end

function ScrollView:Draw(rect, style)
	love.graphics.stencil(
		function()
			love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
		end,
		"replace",
		1)
	love.graphics.setStencilTest("greater", 0)
	UI.Draw.FramedBox(rect, style)
	local yposition = 0
	local viewporty = self.scrollposition * math.max(self.contentsheight - rect.height, 0)
	for i,o in ipairs(self.contents) do
		if yposition >= viewporty then
			local r = o.rect:Copy()
			r.y = yposition - viewporty + rect.y
			r.x = rect.x
			r.width = rect.width
			o.object:Draw(r, style)
		end
		yposition = yposition + o.rect.height
		if yposition >= viewporty + rect.height then
			break
		end
	end
	local scrollbarheight = rect.height-style.scrollbarpadding*2
	if scrollbarheight < self.contentsheight then
		local scrollbarsize = math.max(
			style.scrollbarminheight,
			2*scrollbarheight/self.contentsheight
		)
		local scrollbary = style.scrollbarpadding + 
			self.scrollposition * (scrollbarheight-scrollbarsize)
		self.scrollbar:Draw(Rect(
			rect.x + rect.width - style.scrollbarpadding - style.scrollbarwidth,
			rect.y + scrollbary,
			style.scrollbarwidth,
			scrollbarsize
		),
		style)
	end
	love.graphics.setStencilTest()
	self.scrollheight = rect.height - style.scrollbarpadding*2 - self.scrollbar.rect.height
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
	
return ScrollView