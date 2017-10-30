local Console = Class{
	traceback = true
}

function Console:Create()
	self.log = {}
	self.size = 1000
	self.head = 1
	self.lineHeight = 15
	if Console.traceback then
		self.lineHeight = 30
	end
	self.enabled = true
	self.view = {
		width = 300,
		height = 500,
		statsHeight = 30
	}
end

function Console:Log(message)
	message = tostring(message)
	if self.traceback then
		local info = debug.getinfo(2, "Sn")
		self.log[self.head] =  info.source.." -> "
			..(info.name or "INTERNAL")
			.."\tline "..info.linedefined
			.."\n\t"..message
	else
		self.log[self.head] = message
	end
	self.head = self.head + 1
	if self.head > self.size then
		self.head = 1
	end
end

function Console:GetMessage(index)
	index = self.head-1-index
	while index > self.size do
		index = index - self.size
	end
	return self.log[index]
end

function Console:DrawStats(x,y,w,h)
	love.graphics.setColor(123,194,200,255)
	love.graphics.print("FPS: "..love.timer.getFPS().."\tAverage Delta: "..love.timer.getAverageDelta(), x+5, y+15)
end

function Console:Draw()
	if self.enabled then
		local view = self.view
		local x = 0
		local y = 0
		local w = view.width
		local h = view.height

		love.graphics.setColor(17,21,32,180)
		love.graphics.rectangle("fill", x,y,w,h)
		love.graphics.setColor(154,85,70,255)
		love.graphics.rectangle("line", x,y,w,h)

		self:DrawStats(x,y,w,view.statsHeight)
		y = y + view.statsHeight
		h = h - view.statsHeight

		love.graphics.stencil(
			function()
				love.graphics.rectangle("fill", x+5,y+5,w-10,h-10)
			end,
			"replace",
			1)
		love.graphics.setStencilTest("greater", 0)
		love.graphics.setColor(139,138,118,255)
		local lineNum = h/self.lineHeight
		for i=0,lineNum-1 do
			local msg = self:GetMessage(i)
			if msg then
				love.graphics.print(msg,x + 15, y+h-15-(i+1)*self.lineHeight)
			end
		end
		love.graphics.setStencilTest()
	end
end

return Console
