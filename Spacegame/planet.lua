local Planet = Class({
    minforce = 1
})

function Planet:Create(position, radius, mass)
    self.position = position or vec2(0)
    self.radius = radius or 100
    self.mass = mass or 100000
end

function Planet:Draw()
    love.graphics.setColor(86,150,237, 255)
    local pos = self.position
    love.graphics.circle("fill", pos.x, pos.y, self.radius, 128)
end

function Planet:GetPhysicsShape()
    return love.physics.newCircleShape(self.radius)
end

function Planet:GetMaxGravityDistance()
    return math.sqrt(self.mass/self.minforce)
end

return Planet
