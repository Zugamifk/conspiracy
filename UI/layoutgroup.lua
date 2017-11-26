local LayoutGroup = Class({
    type = "Layout Group"
},
UI.Element)

function LayoutGroup:Create(orientation)
    self:base(UI.AnchoredRect(Rect.Zero(), UI.AnchoredRect.presets.stretch.full))
    self.orientation = orientation
    self.spacing = 0 -- space between ojbects
    self.minpadding = 0 -- space from start edge
    self.maxpadding = 0 -- space from end edge
    self.stretchtofit = false
end

function LayoutGroup:PrepareRebuild(rect, style)
    local n = #self.children

    if n == 0 then return end

    if not self.stretchtofit then
        if self.orientation == "horizontal" then
            local x = self.minpadding
            for i,c in ipairs(self.children) do
                c.rect.offset.x =x
                x = x + c.rect.width + self.spacing
            end
        elseif self.orientation == "vertical" then
            local y = self.minpadding
            for i,c in ipairs(self.children) do
                c.rect.offset.y = y
                y = y + c.rect.height + self.spacing
            end
        end
    else
        local div = 1/n
        if self.orientation == "horizontal" then
            local x = self.minpadding
            for i,c in ipairs(self.children) do
                c.rect.anchormin.x =x
                c.rect.anchormax.x =x + div
                x = x + div
            end
        elseif self.orientation == "vertical" then
            local y = self.minpadding
            for i,c in ipairs(self.children) do
                c.rect.anchormin.y =y
                c.rect.anchormax.y =y + div
                y = y + div
            end
        end
    end
end

function LayoutGroup:AddObject(child)
    self:AddChild(child)
end

return LayoutGroup
