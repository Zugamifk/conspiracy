Camera = Class()

function Camera:Create(x,y,w,h, size)
	self.rect = Rect(x,y,w,h)
	self.size = size
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
		self.rect.width/s+1,
		self.rect.height/s+1)

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
		self.rect.width/s+1,
		self.rect.height/s+1)
	for tile, x, y in tiles do
		local cxt = context(x, y)
		for _,o in ipairs(tile.objects) do
			o:Draw(cxt)
		end
	end
end

function Camera:WorldToScreenPosition(x,y)
	return (x-1)*self.size-self.rect.x, (y-1)*self.size-self.rect.y
end

function Camera:ScreenToWorldPosition(x,y)
	return (x + self.rect.x)/self.size +1, (y + self.rect.y)/self.size +1
end

function Camera:ToString()
	return "Camera:\n\tx: "..self.rect.x.."\n\ty: "..self.rect.y.."\n\tw: "..self.rect.width.."\n\th: "..self.rect.height.."\n\ts: "..self.size
end
