local FreeCameraControl = Class()

function FreeCameraControl:Create(camera)
    self.camera = camera
end

function FreeCameraControl:UpdateEvents(events)
    local cam = self.camera
    local ms = cam.movespeed*cam.scale
    if events.w then
        cam:Move(0,-ms)
    end
    if events.a then
        cam:Move(-ms,0)
    end
    if events.s then
        cam:Move(0,ms)
    end
    if events.d then
        cam:Move(ms,0)
    end
    cam:UpdateEvents(events)
end

function FreeCameraControl:Draw()
    local cam = self.camera
    love.graphics.setColor(229,235,227,255)
    love.graphics.print("zoom: "..cam.scale,5,5)
    love.graphics.print("position: "..tostring(cam.position), 5, 20)
end

return FreeCameraControl
