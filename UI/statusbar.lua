-- required in UI.lua
local StatusBar = Class({
	type = "Status Bar"
},
UI.Element)

function StatusBar:Create(defaultText)
	self:base()
	self.text = defaultText or ""
	self.buttons = {}
end

function StatusBar:SetText(text)
	self.text = text
end

function StatusBar:Draw(style)

	UI.Draw.FramedBox(self.rect, style)
	UI.Draw.Text(self.rect, self.text, style)

	for i,b in ipairs(self.buttons) do
		b:Draw(style)
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
