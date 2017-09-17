-- required in UI.lua
local StatusBar = Class()

function StatusBar.Create(defaultText)
	local statusbar = {
		text = defaultText or ""
	}
	return statusbar
end

function StatusBar:SetText(text)
	self.text = text
end

function StatusBar:Draw(rect, style)	
	local verticalPadding = 5
	-- correct height for stlye
	rect.y = rect.height
	rect.height = style.lineHeight + verticalPadding * 2
	rect.y = rect.y - rect.height
	
	UI.Box(rect, style)
	
	rect.y = rect.y + verticalPadding
	rect.x = rect.x + style.horizontalPadding
	UI.Text(rect, self.text, style)
end

return StatusBar