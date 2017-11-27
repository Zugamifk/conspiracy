local Character = Class()

function Character:Create()
	self.speed = 1 -- tiles per second
    self.position = vec2(4,0)

end

function Character:Draw()
    love.graphics.setColor(241,226,203,255)
	love.graphics.circle("fill", self.position.x,self.position.y, 0.5, 6)
end

function Character:Update()

end

function Character:Move(x,y)
    self.position.x = self.position.x + x
    self.position.y = self.position.y + y
end

return Character
