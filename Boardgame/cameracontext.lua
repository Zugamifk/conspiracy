local CameraContext = Class()

function CameraContext:Create(x,y,w,h)
	self.rect = Rect(x,y,w,h)
end

function CameraContext:Copy()
	return CameraContext(self.x, self.y, self.width, self.height)
end

return CameraContext
