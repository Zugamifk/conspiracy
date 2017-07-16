TileGraphics = {}

-- Draw: draws a tile
-- context: contains information about where and how to draw the tile
-- drawer: object that draws the tile
function TileGraphics.Draw(context, tile)
	local w = context.width
	local h = context.height
	local x = context.x
	local y = context.y

	love.graphics.setColor(
		x%256,y%256,100
		)
	love.graphics.rectangle("fill", x, y, w, h)
	
	if tile.selected then
		love.graphics.setColor(
			255,255,255
			)
		love.graphics.rectangle("line", x, y, w, h)
	end
	-- if w > 25 and h > 15 then
		-- love.graphics.setColor(0,0,0,255)
		-- love.graphics.print(math.floor(tile.heat), x+5, y+3)
	-- end
end