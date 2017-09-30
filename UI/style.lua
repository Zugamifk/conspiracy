-- required in UI.lua
local Style = Class()

function Style:Create()
	-- decoration
	self.drawOutline = true
	self.linestyle = "rough"

	-- scales
	self.linewidth = 1
	self.lineheight = 16
	self.verticalpadding = 10
	self.horizontalpadding = 10

	--scrollbars
	self.scrollbarwidth = 5
	self.scrollbarminheight = 25
	self.scrollbarpadding = 3

	-- colors
	self.colors = UI.Colors.default
end

return Style
