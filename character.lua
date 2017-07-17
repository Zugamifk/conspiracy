Character = {}

Character.mt = {
	__index = Character
}

function Character.Create()
	local cc = {
	}
	return setmetatable(cc, Character.mt)
end

function Character:Draw(context)
	assets:Draw("character", 1, context)
end