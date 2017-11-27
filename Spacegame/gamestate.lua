local GameState = Class({
    controlmodes = {
        "character",
        "camera",
        "ship",
    }
})

function GameState:Create()
    self.physics = SpaceGame.Physics()

    self.starfield = SpaceGame.StarField()

    self.planet = SpaceGame.Planet(vec2(200,50))
    self.physics:AddGravityObject(self.planet)

    self.ship = SpaceGame.Ship()
    self.player = SpaceGame.Character()
    self.ship:AddObject(self.player)
    self.physics:AddObject(self.ship)

    self.camera = SpaceGame.Camera(vec2(0),1)
    self.controlmode = 1
    self.controls = {
        SpaceGame.CharacterControl(self.player),
        SpaceGame.FreeCameraControl(self.camera),
        SpaceGame.ShipControl(self.ship)
    }
end

function GameState:Draw()
    self.starfield:Draw()
    self.camera:Draw({self.planet, self.ship, self.physics})
    local ctrl = self.controls[self.controlmode]
    if ctrl then
        ctrl:Draw()
    end
end

function GameState:Update(dt)
    local mode = self:GetControlMode()
    if mode == "character" then
        local pos = self.player.position
        self.camera:SetPosition(pos.x, pos.y)
    end
    self.camera:Update()
    self.physics:Update(dt)
    self.player:Update()
    self.starfield:SetPosition(self.camera.position.x, self.camera.position.y)
end

function GameState:UpdateEvents(events)
    if events.c and events.c.event == "pressed" then
        self:CycleControlMode()
    end
    local ctrl = self.controls[self.controlmode]
    if ctrl then
        ctrl:UpdateEvents(events)
    end
end



-- possible modes:
-- * camera: move and zoom camera
-- * character: move a character, camera follows
-- * ship: move ship, camera follows
function GameState:SetControlMode(mode)
    self.controlmode = mode
end

function GameState:GetControlMode()
    return tostring(self.controlmodes[self.controlmode])
end

function GameState:CycleControlMode()
    local m = self.controlmode
    m = m % #self.controlmodes
    self.controlmode = m+1
    console:Log(self:GetControlMode().." "..tostring(m))
end

return GameState
