CameraContext = Class()

function CameraContext:Create(x,y,w,h)
	self.x=x
	self.y=y
	self.width = w
	self.height = h
end

function CameraContext:Rect()
	return Rect(self.x, self.y, self.width, self.height)
end

function CameraContext:Copy()
	return CameraContext(self.x, self.y, self.width, self.height)
end
