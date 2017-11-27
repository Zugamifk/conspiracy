local mat2 = {
    type = "mat2"
}

function mat2.Identity()
    return mat2(1,0,0,1)
end

local mt = {}

function mt:__call(e00,e01,e10,e11)
    local t
    if type(e00)=="table" then
        -- passed table as arg
        t = e00
    else
        -- allow single value constructor
        e01 = e01 or e00
        e10 = e10 or e00
        e11 = e11 or e00
        t = {e00,e01,e10,e11}
    end
    return setmetatable(t, mt)
end

function mt:__tostring()
    return "mat2 [["..tostring(self.e00)..", "..tostring(self.e01)..
        "]["..tostring(self.e10)..", "..tostring(self.e11).."]"
end

function mt:__unm()
    return mat2(
        -self.e00,
        -self.e01,
        -self.e10,
        -self.e11
    )
end

function mt:__add(b)
    if type(b) == "number" then
        return mat2(
            self.e00+b,
            self.e01+b,
            self.e10+b,
            self.e11+b
        )
    else
        return mat2(
            self.e00+b.e00,
            self.e01+b.e01,
            self.e10+b.e10,
            self.e11+b.e11
        )
    end
end

function mt:__sub(b)
    if type(b) == "number" then
        return mat2(
            self.e00-b,
            self.e01-b,
            self.e10-b,
            self.e11-b
        )
    else
        return mat2(
            self.e00-b.e00,
            self.e01-b.e01,
            self.e10-b.e10,
            self.e11-b.e11
        )
    end
end

function mt:__mul(b)
    if type(b) == "number" then
        return mat2(
            self.e00*b,
            self.e01*b,
            self.e10*b,
            self.e11*b
        )
    elseif b.type == "vec2" then
        return vec2(
            self.e00*b.x+self.e01*b.y,
            self.e10*b.x+self.e11*b.y
        )
    else
        return vec2(
            self.e00*b.e00+self.e01*b.e10,
            self.e00*b.e01+self.e01*b.e11,
            self.e10*b.e00+self.e11*b.e10,
            self.e10*b.e01+self.e11*b.e11
        )
    end
end

return mat2
