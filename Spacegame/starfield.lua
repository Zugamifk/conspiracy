local StarField = Class()

local shader = "SpaceGame/starfield.glsl"

function StarField:Create()
    self.shader = love.graphics.newShader(shader)
end

function StarField:Draw()
    love.graphics.setColor(255,255,255,255)
    love.graphics.setShader(self.shader)
    local w,h = love.graphics.getDimensions()
    love.graphics.rectangle("fill", 0, 0, w,h)
    love.graphics.setShader()
end

function StarField:SetPosition(x,y)
    self.shader:send("camera", {x,y})
end

return StarField
