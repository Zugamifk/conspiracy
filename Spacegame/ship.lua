local Ship = Class()

function Ship:Create()
    self.position = vec2(0)
    self.angle = 0
    self.size = vec2(12,6)
    self.objects = {} -- objects on the ship
end

function Ship:Draw()
    love.graphics.setColor(66,60,98,255)
    local pos = self.position
    local sz = self.size
    love.graphics.push()
    local dx = sz.x/2
    local dy = sz.y/2
    love.graphics.translate(pos.x, pos.y)
    love.graphics.translate(-dx, -dy)
    love.graphics.rotate(self.angle)
    love.graphics.translate(dx, dy)

    love.graphics.rectangle("fill", -sz.x/2, -sz.y/2, sz.x, sz.y)

    for _,o in ipairs(self.objects) do
        o:Draw()
    end
    love.graphics.pop()
end

function Ship:UpdatePhysics(info)
    self.position = vec2(info.body:getPosition())
    self.angle = info.body:getAngle()
end

function Ship:GetPhysicsShape()
    local sz = self.size
    local shape = love.physics.newRectangleShape(sz.x, sz.y)
    return shape
end

function Ship:AddObject(obj)
    self.objects[#self.objects+1] = obj
end

return Ship
