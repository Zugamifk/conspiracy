Circle = Class{
	type = "Circle"
}

function Circle:Create(x,y,r)
    self.x=x
    self.y=y
    self.radius = r
end

function Circle:Contains(x,y)
	if type(x) =="table" then
        local dx, dy = x.x-self.x, x.y-self.x
		return dx*dx+dy*dx < r* r
	else
        local dx, dy = x-self.x, y-self.x
        return dx*dx+dy*dx < r* r
	end
end

function Circle:Copy()
	return Circle(self.x, self.y, self.radius)
end

function Circle.Zero()
	return Circle(0,0,0)
end
