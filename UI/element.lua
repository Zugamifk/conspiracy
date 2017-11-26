local Element = Class{
    type = "UI Base Element"
}

function Element:Create(rect)
    self.rect = rect or UI.AnchoredRect(
        Rect(0,0,100,100),
        UI.AnchoredRect.presets.centremid)

    self.children = {}
end

function Element:AddChild(child)
    self.children[#self.children+1] = child
end

function Element:RemoveChild(child)
    for i,c in ipairs(self.children) do
        if c == child then
            table.remove(self.children, i)
            return
        end
    end
end

function Element:RemoveChildAtIndex(index)
    table.remove(self.children, index)
end

function Element:Clear()
    self.children = {}
end

function Element:ForEach(f, ...)
    self[f](self, ...)
    for _,c in ipairs(self.children) do
        c:ForEach(f, ...)
    end
end

function Element:Rebuild(rect, style)
    if self.PrepareRebuild then
        self:PrepareRebuild(rect, style)
    end

    self.rect:Rebuild(rect)
    for _,c in ipairs(self.children) do
        c:Rebuild(self.rect, style)
    end

    if self.OnRebuild then
        self:OnRebuild(rect, style)
    end
end

function Element:Draw(style)
    for _,c in ipairs(self.children) do
        c:Draw(style)
    end
end

function Element:GetSelectables()
    return tablep.map(
        self.children,
        function (c)
            return c:GetSelectables()
        end)
        :flatten()
        :totable()
end

function Element.test()
    local h = Hierarchy()
    h:AddChild(1)
    h:AddChild(2)
    h:AddChild(3)
    h:AddChild(4)
    assert(#h.children == 4, "Added 4 children: #h.children: 4!="..#h.children)

    h:RemoveChild(2)
    assert(#h.children == 3, "RemoveChild(2) #h.children: 3!="..#h.children)

    h:RemoveChildAtIndex(2)
    assert(#h.children == 2, "RemoveChildAtIndex(2) #h.children: 2!="..#h.children)

    h:AddChild(5)
    assert(#h.children == 3, "AddChild(5) #h.children: 3!="..#h.children)

    h:Clear()
    assert(#h.children == 0, "Clear() #h.children: 0!="..#h.children)

    error("Hierarchy.test success")
end

return Element
