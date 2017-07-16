Tile = {
}

Tile.mt = {
	__index = Tile
}

function Tile.Create()
	local t = {}

	return setmetatable(t, Tile.mt)
end