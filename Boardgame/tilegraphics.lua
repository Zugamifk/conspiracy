local TileGraphics = {

}

function TileGraphics.Init(board)

	local wang = Wang()
	local getDraw = function(id)
		return function(context)
			assets:Draw("ground", id, context)
		end
	end

	wang:AddRule(
		getDraw(1),
		1,1,1,1,
		100
	)
	wang:AddRule(
		getDraw(2),
		1,1,2,2,
		10
	)
	wang:AddRule(
		getDraw(3),
		2,2,1,1,
		10
	)
	wang:AddRule(
		getDraw(4),
		2,2,1,1,
		10
	)
	wang:AddRule(
		getDraw(5),
		2,1,2,1,
		10
	)
	wang:AddRule(
		getDraw(6),
		1,2,1,2,
		10
	)
	wang:AddRule(
		getDraw(7),
		2,1,1,2,
		10
	)
	wang:AddRule(
		getDraw(8),
		1,2,2,1,
		10
	)
	wang:AddRule(
		getDraw(9),
		2,2,2,2
	)
	wang:AddRule(
		getDraw(10),
		2,2,2,1
	)
	wang:AddRule(
		getDraw(11),
		2,1,2,2
	)
	wang:AddRule(
		getDraw(12),
		2,2,1,2
	)
	wang:AddRule(
		getDraw(13),
		1,2,2,2
	)
	wang:AddRule(
		getDraw(14),
		2,1,1,1,
		5
	)
	wang:AddRule(
		getDraw(15),
		1,1,2,1,
		5
	)
	wang:AddRule(
		getDraw(16),
		1,1,1,2,
		5
	)

	wang:Generate(board)
	TileGraphics.wang = wang
end

-- Draw: draws a tile
-- context: contains information about where and how to draw the tile
-- drawer: object that draws the tile
function TileGraphics.Draw(context, tile)
	local w = context.width
	local h = context.height
	local x = context.x
	local y = context.y

	TileGraphics.wang:Draw(context, tile)
	-- if w > 25 and h > 15 then
		-- love.graphics.setColor(0,0,0,255)
		-- love.graphics.print(math.floor(tile.heat), x+5, y+3)
	-- end
end

return TileGraphics
