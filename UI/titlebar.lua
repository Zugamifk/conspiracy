local TitleBar = Class()

function TitleBar:Create(title)
    self.title = title
    self.buttons = {}

    local title = UI.Text(title)
    self.text = title
end

function TitleBar:Draw(style)
    UI.Draw.Box(self.rect, style.colors.titlebar)

    self.text:Draw(style)
    
    for i,b in ipairs(self.buttons) do
        b:Draw(style)
    end
end

function TitleBar:Rebuild(rect, style)
    self.rect = rect:Copy()
    local tr = rect
    local tpos = tr.y + tr.height / 2 - style.lineheight/2 +2
    tr.y = tpos
    self.text:Rebuild(tr)

    local br = tr:Copy()
    local buttonwidth = self.rect.height - 4
    br.x = br.x + br.width - buttonwidth - 2
    br.y = self.rect.y + 2
    br.height = buttonwidth
    br.width = buttonwidth
    for i,b in ipairs(self.buttons) do
        br = br:Copy()
        b:Rebuild(br, style)
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
