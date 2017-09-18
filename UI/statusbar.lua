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
	local verticalpadding = 5
	-- correct height for stlye
	rect.y = rect.y + rect.height
	rect.height = style.lineheight + verticalpadding * 2
	rect.y = rect.y - rect.height
	
	UI.Draw.FramedBox(rect, style)
	
	rect.y = rect.y + verticalpadding
	rect.x = rect.x + style.horizontalpadding
	UI.Draw.Text(rect, self.text, style)
end

return StatusBar