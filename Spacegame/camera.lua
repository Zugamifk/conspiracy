local Camera = Class()

function Camera:Create(pos, scale)

    self.rect = Rect.Zero()
    self.position = pos
    self.scale = scale
    local w,h = love.graphics.getDimensions()
    self.aspectRatio = w/h

    self.minscale = 0.2
    self.maxscale = 1000

    self.movespeed = 0.01

    self.dirty = false
    self:Rebuild()
end

function Camera:Rebuild()
    local w,h = love.graphics.getDimensions()
    self.aspectRatio = w/h
    local ctr = self.position
    local r = self.rect
    r.x = ctr.x-self.scale
    r.y = ctr.y-self.scale/self.aspectRatio
    r.w = self.scale*2
    r.h = self.scale*2 / self.aspectRatio
    self.dirty = false
end

function Camera:Draw(objects)
    local w,h = love.graphics.getDimensions()
    love.graphics.push()
    love.graphics.translate(w/2,h/2)
    love.graphics.scale(w/self.rect.w,h/self.rect.h)
    love.graphics.translate(-self.position.x, -self.position.y)

    for _,o in ipairs(objects) do
        o:Draw()
    end

    love.graphics.pop()
end

function Camera:Update()
    if self.dirty then
        self:Rebuild()
    end
end


function Camera:UpdateEvents(events)

	if events.mousewheelY then
		self:Scale(math.sign(events.mousewheelY.event))
	end
	-- if events.mousebutton then
	-- 	local e = events.mousebutton.event
	-- 	-- get position on board
	-- 	local px, py = self.camera:ScreenToWorldPosition(e.x, e.y)
	-- 	-- generate new event
	-- 	Input:GenerateEvent("boardinput", {x=px, y = py, mouse = e})
	-- 	-- clear mouse event
	-- 	events.mousebutton.used = true
	-- end
end

function Camera:SetScale(scale)
    if scale > self.maxscale then
        scale = self.maxscale
    elseif scale < self.minscale then
        scale = self.minscale
    end
    console:Log(scale)
    self.scale = scale
    self.dirty = true
end

function Camera:SetPosition(x,y)
    self.position.x = x
    self.position.y = y
    self.dirty = true
end

function Camera:Scale(direction)
    if direction > 0 then
        self.scale = self.scale * 2
    else
        self.scale = self.scale / 2
    end
    console:Log(self.scale)
    self.dirty = true
end

function Camera:Move(x,y)
    self.position.x = self.position.x + x
    self.position.y = self.position.y + y
    self.dirty = true
end

return Camera
