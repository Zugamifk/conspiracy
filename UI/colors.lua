local Colors = {}

Colors.default = {
	background = { 17,21,32,180 },
	outline = {154,85,70,255},
	focusoutline = {174,125,90,255},
	
	selectable = {
		normal = {161,226,38,255},
		hover = {255,209,25,255},
		selected = {255,0,123,255},
		disabled = {30,178,237,255}
	},
	
	text = {123,194,200,255},

	line0 = {145,37,52,255},
	line1 = {89,27,40,255},
	line2 = {154,176,6,255}
}

function Colors.NewSet(colors)
	return setmetatable(colors, {__index = Colors.default})
end

return Colors