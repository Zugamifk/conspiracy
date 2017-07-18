Tile = Class()

function Tile.Create()
	local t = {
		objects = {}
	}
	return t
end

function Tile:AddObject(object)
	table.insert(self.objects, object)
	object.tile = self
end

function Tile:RemoveObject(object)
	for i,o in ipairs(self.objects) do
		if o == object then
			table.remove(self.objects, i)
			break
		end
	end
	object.tile = nil
end