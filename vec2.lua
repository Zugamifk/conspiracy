local vec2 = {}
local mt = {}

function mt:__call(x,y)
    local v = {x=x,y=y}
    return setmetatable(v, mt)
end


mt.__index = vec2

function mt:__newindex(k, v)
    -- no new assignments
end

function mt:__tostring()
    return "vec2 ("..self.x..", "..self.y..")"
end

function mt:__unm()
    return vec2(-self.x, -self.y)
end

function mt:__add(b)
    return vec2(self.x+b.x, self.y+b.y)
end

function mt:__sub(b)
    return vec2(self.x-b.x, self.y-b.y)
end

function mt:__mul(b)
    return vec2(self.x*b, self.y*b)
end

function mt:__div(b)
    return vec2(self.x/b, self.y/b)
end

return setmetatable(vec2, mt)
