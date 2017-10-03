local AnchoredRect = Class(nil, Rect)

function AnchoredRect:Create(rect)
    self.rect = rect or rect.Zero()
    self.anchors = Rect.Unit()
    self.pivot = vec2(0.5)
    self.offsets = vec2(0)
    self.worldposition = vec2(0)
    self.base = self.rect
end

function AnchoredRect:Rebuild(rect)
    local min = rect:GetSize()*self.anchors:GetMin()
        - self.offsets * self.pivot
    local max = rect:GetSize()*self.anchors:GetMax() + self.offsets * (vec2(1)-self.pivot)

    self.rect:SetMin(min)
    self.rect:SetMax(max)

    self.worldposition = rect.worldposition + self:GetPosition()
end

function AnchoredRect:SetAnchors(min, max)
    self.anchors:SetMin(min)
    self.anchors:SetMax(max)
end

function AnchoredRect.Test()
    local ar = UI.AnchoredRect(Rect(0,0,100,110))
    local pr = Rect(0,0,100,110)
    local p = UI.AnchoredRect(pr)
    ar:Rebuild(p)
end

return AnchoredRect
