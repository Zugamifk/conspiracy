CameraContext = Class()

function CameraContext.Create(x,y,w,h)
	local cc = {
		x=x,
		y=y,
		width = w,
		height = h
	}
	return cc
end

function CameraContext:Copy()
	return CameraContext(self.x, self.y, self.width, self.height)
end