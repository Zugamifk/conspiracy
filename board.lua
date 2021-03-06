Board = Class({
	width = 100,
	height = 100,
	selection = nil -- current selected board object
})

--todo: optimize for big boards
function Board:Create()
	local b = self
	b.tiles = {}
	for x = 1,Board.width do
		b.tiles[x] = {}
		for y = 1,Board.height do
			b.tiles[x][y] = Tile(x,y)
		end
	end
	b.tiles[25][25]:AddObject(Character())
end

function Board:GetTile(x,y)
	x = math.floor(x)
	y = math.floor(y)
	if not self.tiles[x] then
		return nil
	else
		return self.tiles[x][y]
	end
end

function Board:GetTiles(x,y,w,h)
	x = x or 1
	y = y or 1
	w = w or self.width
	h = h or self.height
	local xi = math.floor(x)
	local yi = math.floor(y)
	xi = math.max(xi,1)
	yi = math.max(yi,1)
	w = math.ceil(x+w)-xi
	h = math.ceil(y+h)-yi
	local x0 = xi
	local X = math.min(xi+w, self.width)
	local Y = math.min(yi+h, self.height)
	return function()
		if xi < X and yi < Y then
			local t = self:GetTile(xi,yi)
			local rx = xi
			local ry = yi
			xi = xi + 1
			if xi == X then
				xi = x0
				yi = yi + 1
			end
			return t, rx, ry
		end
	end
end

function Board:GetSurrounding(x,y,r)
	local xi = math.floor(x-r)
	local yi = math.floor(y-r)
	xi = math.max(xi,1)
	yi = math.max(yi,1)
	w = math.ceil(x+r)-xi
	h = math.ceil(y+r)-yi
	local x0 = xi
	local X = math.min(xi+w, self.width)
	local Y = math.min(yi+h, self.height)
	--console:Log("GetTiles: x "..x..", y "..y..", w "..w..", h "..h)
	return function()
		if xi < X and yi < Y then
			local t = self:GetTile(xi,yi)
			local rx = xi
			local ry = yi
			xi = xi + 1
			if xi == X then
				xi = x0
				yi = yi + 1
			end
			return t, rx, ry
		end
	end
end

function Board:MoveObject(object, destination)
	object.tile:RemoveObject(object)
	destination:AddObject(object)
end
