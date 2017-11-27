local vec2 = {
    type = "vec2"
}
local mt = {}

function vec2:length()
    return math.sqrt(self.x*self.x + self.y*self.y)
end

function mt:__call(x,y)
    local v = {x=x,y=y or x}
    return setmetatable(v, mt)
end

mt.__index = vec2

function mt:__newindex(k, v)
    -- no new assignments
end

function mt:__tostring()
    return "vec2 ("..tostring(self.x)..", "..tostring(self.y)..")"
end

function mt:__unm()
    return vec2(-self.x, -self.y)
end

function mt:__add(b)
    if type(b) == "table" then
        return vec2(self.x+b.x, self.y+b.y)
    else
        return vec2(self.x+b, self.y+b)
    end
end

function mt:__sub(b)
    if type(b) == "table" then
        return vec2(self.x-b.x, self.y-b.y)
    else
        return vec2(self.x-b, self.y-b)
    end
end

function mt:__mul(b)
    if type(b) == "table" then
        return vec2(self.x*b.x, self.y*b.y)
    else
        return vec2(self.x*b, self.y*b)
    end
end

function mt:__div(b)
    if type(b) == "table" then
        return vec2(self.x/b.x, self.y/b.y)
    else
        return vec2(self.x/b, self.y/b)
    end
end

return setmetatable(vec2, mt)
