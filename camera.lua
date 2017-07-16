require "tilegraphics"
Camera = {}

function Camera.Create(x,y,w,h, size)
	local c = {
		x = x,
		y = y,
		width = w,
		height = h,
		size = size
	}
	return setmetatable(c, {__index = Camera})
end

function Camera:Draw(board)
	
	local s = self.size
	local context = function(x,y) 
		local cx,cy = self:WorldToScreenPosition(x,y)
		return {
			x=cx,
			y=cy,
			width = s,
			height = s
		}
	end
	
	local wx,wy = self:ScreenToWorldPosition(0, 0)
	local tiles = board:GetTiles(
		wx,
		wy,		
		self.width/s+1, 
		self.height/s+1)
		
	for tile,x,y in tiles do
		local cxt = context(x, y)
		cxt.layer = "terrain"
		
		-- how do it drawed tiles
		wangtiles:Draw(cxt, tile)
		
		if tile.selected then
			love.graphics.setColor(
				255,255,255
				)
			love.graphics.rectangle("line", x, y, w, h)
		end
	end
	-- tiles = world:GetTiles(
		-- wx,
		-- wy,		
		-- self.width/s+1, 
		-- self.height/s+1)
	-- for tile, x, y in tiles do
		-- local cxt = context(x, y)
		-- for _,o in ipairs(tile.objects) do
			-- o:Draw(cxt)
		-- end
	-- end
	
	-- cxt = context(50,50)
	-- Wizard:Draw(cxt)
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