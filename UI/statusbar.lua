-- required in UI.lua
local StatusBar = Class()

function StatusBar:Create(defaultText)
	self.text = defaultText or ""
	self.buttons = {}
end

function StatusBar:SetText(text)
	self.text = text
end

function StatusBar:Draw(rect, style)
	local verticalpadding = 5
	local rx0 = rect.x

	-- correct height for stlye
	rect.y = rect.y + rect.height
	rect.height = style.lineheight + verticalpadding * 2
	rect.y = rect.y - rect.height

	UI.Draw.FramedBox(rect, style)
	local ry0 = rect.y

	rect.y = rect.y + verticalpadding
	rect.x = rect.x + style.horizontalpadding
	UI.Draw.Text(rect, self.text, style)

	local br = rect:Copy()
	local buttonwidth = rect.height - verticalpadding*2
	br.x = rx0 + br.width - buttonwidth - verticalpadding
	br.y = ry0 + verticalpadding
	br.height = buttonwidth
	br.width = buttonwidth
	for i,b in ipairs(self.buttons) do
		b:Draw(br, style)
		br.x = br.x - buttonwidth - verticalpadding
	end
end

function StatusBar:AddButton(text, onclick)
    local button = UI.Button(text)
    button:SetOnClick(onclick)
    self.buttons[#self.buttons+1] = button
end

function StatusBar:GetSelectables()
    return tablep.map(self.buttons, function(b) return b:GetSelectables()[1] end):totable()
end

return StatusBar
