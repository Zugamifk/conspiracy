-- required in UI.lua
local Style = Class()

function Style.Create() 
	local style = {
		-- decoration
		drawOutline = true,
		
		-- scales
		lineHeight = 16,
		verticalPadding = 10,
		horizontalPadding = 10,
		
		-- colors
		colors = UI.Colors.default
	}
	return style
end

return Style