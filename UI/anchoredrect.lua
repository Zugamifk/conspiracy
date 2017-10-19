local AnchoredRect = Class({
    type = "AnchoredRect"
}, Rect)

function AnchoredRect:Create(rect, preset)
    if rect then
        self:base(rect.x, rect.y, rect.width, rect.height)
    else
        self:base(0,0,0,0)
    end

    -- position of top left corner of the rect
   self.worldposition = vec2(0)

    if preset then
        preset(self)
    else
        -- normalized positions of rect anchors, relative to parent rect
        self.anchormin = vec2(0)
        -- normalized positions of rect anchors, relative to parent rect
        self.anchormax = vec2(0)
        -- offset of the rect, vector from centre of anchors to pivot
        self.offset = self:GetPosition()
         -- centre of rotation, scaling and offsets
        self.pivot = vec2(0)
         -- size of rect relative to anchors
        self.padding = self:GetSize()
    end

end

function AnchoredRect:Rebuild(rect)
    local sz = rect:GetSize()
    local minpx = sz*self.anchormin
    local maxpx = sz*self.anchormax
    local minds = - self.padding * self.pivot
    local maxds = self.padding * (vec2(1)-self.pivot)
    local min = minpx + minds + self.offset
    local max = maxpx + maxds + self.offset
    --console:Log(tostring(minpx))

    self:SetMin(rect.worldposition + min)
    self:SetMax(rect.worldposition + max)

    self.worldposition = rect.worldposition + self:GetPosition()
end

function AnchoredRect.Test()
    local ar = UI.AnchoredRect(Rect(0,0,100,110))
    local pr = Rect(0,0,100,110)
    local p = UI.AnchoredRect(pr)
    ar:Rebuild(p)
end

function AnchoredRect:Copy()
    local copy = AnchoredRect(self)
    copy.anchormin = self.anchormin
    copy.anchormax = self.anchormax
    copy.offset = self.offset
    copy.pivot = self.pivot
    copy.padding = self.padding
    copy.worldposition = self.worldposition
    return copy
end


AnchoredRect.presets = {
    centre = function(a, p)
        a.anchormin = vec2(0.5)
        a.anchormax = vec2(0.5)
        a.offset = vec2(0)
        a.pivot = vec2(0.5)
        a.padding = vec2(0)
    end,
    stretch = {
        top = function(a)
            a.anchormin = vec2(0,0)
            a.anchormax = vec2(1,0)
            a.offset = vec2(0, a.height/2)
            a.pivot = vec2(0.5)
            a.padding = vec2(0,a.height)
        end,
        centrehorz = function(a)
            a.anchormin = vec2(0,0.5)
            a.anchormax = vec2(1,0.5)
            a.offset = vec2(0, a.height/2)
            a.pivot = vec2(0.5)
            a.padding = vec2(0,a.height)
        end
    }
}

return AnchoredRect
