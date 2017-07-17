Character = Class()

function Character.Create()
	local cc = {
	}
	return cc
end

function Character:Draw(context)
	assets:Draw("character", 1, context)
end