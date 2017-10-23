local TitleBar = Class()

function TitleBar:Create(title)
    self.title = title
    self.buttons = {}

    local title = UI.Text(title)
    local tr = UI.AnchoredRect(Rect(5,2,0,16), UI.AnchoredRect.presets.stretch.centrehorz)
    title.rect = tr
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
    self.rect:Rebuild(rect)
    self.text:Rebuild(self.rect)
    --console:Log("bar: "..self.rect:ToString())
--    console:Log("text: "..self.text.rect:ToString())
    -- local br = tr:Copy()
    -- local buttonwidth = self.rect.height - 4
    -- br.x = br.x + br.width - buttonwidth - 2
    -- br.y = self.rect.y + 2
    -- br.height = buttonwidth
    -- br.width = buttonwidth
    for i,b in ipairs(self.buttons) do
        b:Rebuild(self.rect, style)
    end
end

function TitleBar:AddButton(text, onclick)
    local button = UI.Button(text)
    local w = 12
    local x = 2 + w * (#self.buttons)
    local br = UI.AnchoredRect(Rect(-x,0,w,w), UI.AnchoredRect.presets.centreright)
    button.rect = br
    button:SetOnClick(onclick)
    self.buttons[#self.buttons+1] = button
end

function TitleBar:GetSelectables()
    return tablep.map(self.buttons, function(b) return b:GetSelectables()[1] end):totable()
end

return TitleBar
