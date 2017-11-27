local ShipControl = Class()

function ShipControl:Create(ship)
    self.ship = ship
end

function ShipControl:UpdateEvents(events)

end

function ShipControl:Draw()
    local mx, my = love.mouse.getPosition()
    local ship = self.ship
    love.graphics.setColor(240,163,41,175)
    local lp = ship.position
    love.graphics.line(lp.x,lp.y,mx,my)
end

return ShipControl
