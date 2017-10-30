local TitleBar = Class({
    type = "TitleBar"
},
UI.Element)

function TitleBar:Create(title)
    self:base()
    self.title = title
    self.buttons = {}

    local title = UI.Text(title)
    local tr = UI.AnchoredRect(Rect(5,2,0,16), UI.AnchoredRect.presets.stretch.centrehorz)
    title.rect = tr
    self:AddChild(title)
    self.text = title
end

function TitleBar:Draw(style)
    UI.Draw.Box(self.rect, style.colors.titlebar)

    self.text:Draw(style)

    for i,b in ipairs(self.buttons) do
        b:Draw(style)
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
    self:AddChild(button)
end

function TitleBar:GetSelectables()
    return tablep.map(self.buttons, function(b) return b:GetSelectables()[1] end):totable()
end

return TitleBar
