Tile = {
}

Tile.mt = {
	__index = Tile
}

function Tile.Create()
	local t = {
		objects = {}
	}
	return setmetatable(t, Tile.mt)
end