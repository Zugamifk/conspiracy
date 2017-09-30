Camera = Class()

function Camera.Create(x,y,w,h, size)
	local c = {
		x = x,
		y = y,
		width = w,
		height = h,
		size = size
	}
	return c
end

function Camera:Draw(board)
	local s = self.size
	local context = function(x,y)
		local cx,cy = self:WorldToScreenPosition(x,y)
		return CameraContext(cx,cy,s,s)
	end

	local wx,wy = self:ScreenToWorldPosition(0, 0)
	local tiles = board:GetTiles(
		wx,
		wy,
		self.width/s+1,
		self.height/s+1)

	love.graphics.setColor(
		255,255,255
	)

	for tile,x,y in tiles do
		local cxt = context(x, y)

		-- how do it drawed tiles
		TileGraphics.Draw(cxt, tile)

		if tile.selected then
			local w = cxt.width
			local h = cxt.height
			local x = cxt.x
			local y = cxt.y
			love.graphics.rectangle("line", x, y, w, h)
		end
	end
	tiles = board:GetTiles(
		wx,
		wy,
		self.width/s+1,
		self.height/s+1)
	for tile, x, y in tiles do
		local cxt = context(x, y)
		for _,o in ipairs(tile.objects) do
			o:Draw(cxt)
		end
	end

	ui:Draw(Rect(0,0,self.width, self.height))
end

function Camera:WorldToScreenPosition(x,y)
	return (x-1)*self.size-self.x, (y-1)*self.size-self.y
end

function Camera:ScreenToWorldPosition(x,y)
	return (x + self.x)/self.size +1, (y + self.y)/self.size +1
end

function Camera:ToString()
	return "Camera:\n\tx: "..self.x.."\n\ty: "..self.y.."\n\tw: "..self.width.."\n\th: "..self.width.."\n\ts: "..self.size
end
