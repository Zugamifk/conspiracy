WangTiles = Class()

function WangTiles:Create(wang)
	self.wang = wang

	local c1 = {80,100,88}
	local c2 = {137,133,95}
	local c3 = {195,186,83}
	local c4 = {232,147,83}
	local c5 = {63,56,46}

	wang:AddRule(
		WangTiles.GetDrawFunction(c1,c2,c1,c1),
		1,2,1,1
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c2,c1,c1,c1),
		2,1,1,1
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c2,c2,c3,c1),
		2,2,3,1
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c1,c1,c3,c3),
		1,1,3,3
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c2,c2,c1,c3),
		2,2,1,3
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c2,c4,c4,c3),
		2,4,4,3
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c4,c4,c4),
		4,4,4,4
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c4,c5,c4),
		4,4,5,4
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c4,c4,c5),
		4,4,4,5
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c2,c3,c4),
		4,2,3,4
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c4,c3,c4),
		4,4,3,4
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c4,c3,c5),
		4,4,3,5
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c3,c4,c5,c5),
		3,4,5,5
	)
	wang:AddRule(
		WangTiles.GetDrawFunction(c4,c3,c5,c5),
		4,3,5,5
	)
end

function WangTiles.GetDrawFunction(l,r,t,b)
	return function(context)
		local w = context.width
		local h = context.height
		local x = context.x
		local y = context.y
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
