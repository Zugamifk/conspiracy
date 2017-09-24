-- required in UI.lua
local Style = Class()

function Style.Create()
	local style = {
		-- decoration
		drawOutline = true,
		linestyle = "rough",

		-- scales
		linewidth = 1,
		lineheight = 16,
		verticalpadding = 10,
		horizontalpadding = 10,

		--scrollbars
		scrollbarwidth = 5,
		scrollbarminheight = 25,
		scrollbarpadding = 3,

		-- colors
		colors = UI.Colors.default
	}
	return style
end

return Style
