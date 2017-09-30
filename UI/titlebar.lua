local TitleBar = Class()

function TitleBar:Create(title)
    self.title = title
    self.buttons = {}

    local title = UI.Text(title)
    self.text = title
end

function TitleBar:Draw(rect, style)
    UI.Draw.Box(rect, style.colors.titlebar)
    local br = rect:Copy()
    local tpos = rect.y + rect.height / 2 - style.lineheight/2 +2
    br.y = tpos
    self.text:Draw(br, style)

    br = br:Copy()
    local buttonwidth = rect.height - 4
    br.x = br.x + br.width - buttonwidth - 2
    br.y = rect.y + 2
    br.height = buttonwidth
    br.width = buttonwidth
    for i,b in ipairs(self.buttons) do
        b:Draw(br, style)
        br = br:Copy()
        br.x = br.x - buttonwidth - 2
    end
end

function TitleBar:AddButton(text, onclick)
    local button = UI.Button(text)
    button:SetOnClick(onclick)
    self.buttons[#self.buttons+1] = button
end

function TitleBar:GetSelectables()
    return tablep.map(self.buttons, function(b) return b:GetSelectables()[1] end):totable()
end

return TitleBar
