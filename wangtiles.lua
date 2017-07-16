WangTiles = {}

WangTiles.mt = {
	__index = WangTiles
}

function WangTiles.Create(wang)
	local w = {}
	w.wang = wang
	
	local c1 = {80,100,88}
	local c2 = {137,133,95}
	local c3 = {195,186,83}
	local c4 = {232,147,83}
	local c5 = {63,56,46}
	
	wang:AddRule(
		WangTiles.GetDrawFunction(c1,c2,c1,c1),
		1,
		1,2,1,1
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c2,c1,c1,c1),
		2,
		2,1,1,1
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c2,c2,c3,c1),
		3,
		2,2,3,1
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c1,c1,c3,c3),
		4,
		1,1,3,3
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c2,c2,c1,c3),
		5,
		2,2,1,3
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c2,c4,c4,c3),
		6,
		2,4,4,3
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c4,c4,c4),
		7,
		4,4,4,4
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c4,c5,c4),
		8,
		4,4,5,4
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c4,c4,c5),
		9,
		4,4,4,5
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c2,c3,c4),
		10,
		4,2,3,4
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c4,c3,c4),
		11,
		4,4,3,4
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c4,c3,c5),
		12,
		4,4,3,5
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c3,c4,c5,c5),
		13,
		3,4,5,5
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c3,c5,c5),
		14,
		4,3,5,5
	)
	return setmetatable(w, WangTiles.mt)
end

function WangTiles:Draw(context, tile)
	local w = context.width
	local h = context.height
	local x = context.x
	local y = context.y
	if tile.wang then 
		tile.wang.func(x,y,w,h)
	end
end

function WangTiles:Generate(board)
	local errors = 0
	local resetRadius = 2
	for iters = 1,10 do
		for x = 1,100 do
			for y = 1,100 do
				if not board.tiles[x][y].wang then 
					local l = x > 1 and board.tiles[x-1][y].wang and board.tiles[x-1][y].wang.r or nil
					local r = x < 100 and board.tiles[x+1][y].wang and board.tiles[x+1][y].wang.l or nil
					local t = y > 1 and board.tiles[x][y-1].wang and board.tiles[x][y-1].wang.b or nil
					local b = y < 100 and board.tiles[x][y+1].wang and board.tiles[x][y+1].wang.t or nil
					local rule = self.wang:GetRule(l,r,t,b)
					if rule then 
						board.tiles[x][y].wang = rule
					else
						errors = errors + 1
					end
				end
			end
		end
		if iters < 10 and errors > 0 then 
			for x = 1,100 do
				for y = 1,100 do
					if not board.tiles[x][y].wang then
						for t in board:GetSurrounding(x,y,resetRadius) do
							t.wang = nil
						end
					end
				end
			end
			errors = 0
		else
			break
		end
	end
end

function WangTiles.GetDrawFunction(l,r,t,b)
	return function(x,y,w,h)
		local cx = x + w/2
		local cy = y + h/2
		love.graphics.setColor(l)
		love.graphics.polygon("fill", x, y, cx,cy,x,y+h)
		love.graphics.setColor(r)
		love.graphics.polygon("fill", x+w, y, cx,cy,x+w,y+h)
		love.graphics.setColor(t)
		love.graphics.polygon("fill", x, y, cx,cy,x+w,y)
		love.graphics.setColor(b)
		love.graphics.polygon("fill", x, y+h, cx,cy,x+w,y+h)
	end
end