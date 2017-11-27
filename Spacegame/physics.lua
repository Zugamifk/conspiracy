local Physics = Class({
    debugdrawshapes = {
        PolygonShape = function(body, shape)
            love.graphics.polygon("line", body:getWorldPoints(shape:getPoints()))
        end,
        CircleShape = function(body, shape)
            local x,y = body:getPosition()
            love.graphics.circle("line", x,y,shape:getRadius())
        end
    }
})

function Physics:Create()
    self.debugdraw = true

    self.world = love.physics.newWorld(0, 0, true)

    -- objects exerting gravity
    self.gravityobjects = {}

    -- objects with physics bodies
    self.objects = {}
end

function Physics:Draw()
    if not self.debugdraw then return end

    love.graphics.setColor(37,215,117, 255)
    for obj,info in pairs(self.gravityobjects) do
        local shape = info.shape
        Physics.debugdrawshapes[shape:type()](info.body, shape)
    end

    love.graphics.setColor(235,61,62, 255)
    for obj,info in pairs(self.objects) do
        local shape = info.shape
        Physics.debugdrawshapes[shape:type()](info.body, shape)
    end
end

function Physics:Update(dt)
    self.world:update(dt)
    for obj,info in pairs(self.objects) do
        obj:UpdatePhysics(info)
        for o,i in pairs(self.gravityobjects) do
            local dir = o.position-obj.position
            local dis = dir:length()
            if dis > 0.10 then
                local norm = dir/dis
                local force = norm * o.mass / (dis*dis)-- * dt
                info.body:applyForce(force.x, force.y)
            end
        end
    end
end

function Physics:AddObject(obj)
    local info = {
        target = obj
    }
    local pos = obj.position
    info.body = love.physics.newBody(
        self.world,
        pos.x,
        pos.y,
        "dynamic"
    )
    info.shape = obj:GetPhysicsShape()
    info.fixture = love.physics.newFixture(info.body, info.shape)

    self.objects[obj] = info
end

function Physics:AddGravityObject(obj)
    local info = {
        target = obj
    }
    local pos = obj.position
    info.body = love.physics.newBody(
        self.world,
        pos.x,
        pos.y,
        "kinematic"
    )
    info.shape = obj:GetPhysicsShape()
    info.radius = love.physics.newCircleShape(
        obj:GetMaxGravityDistance()
    )
    info.fixture = love.physics.newFixture(info.body, info.shape)

    self.gravityobjects[obj] = info
end

return Physics
