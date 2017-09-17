local Colors = {}

Colors.default = {
	background = { 17,21,32,180 },
	outline = {154,85,70,255},
	focusoutline = {174,125,90,255},
	
	text = {123,194,200,255}
}

function Colors.NewSet(colors)
	return setmetatable(colors, {__index = Colors.default})
end

return Colors