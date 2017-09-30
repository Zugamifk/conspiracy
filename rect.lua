Rect = Class{
	type = "Rect"
}

function Rect.Create(x,y,w,h)
	if type(x) == "table" then
		return x
	else
		return {x=x,y=y,width=w,height=h}
	end
end

function Rect:Contains(x,y)
	if type(x) =="table" then
		return self.x <= x.x and
			self.x + self.width >= x.x and
			self.y <= x.y and
			self.y + self.height >= x.y
	else
		return self.x <= x and
			self.x + self.width >= x and
			self.y <= y and
			self.y + self.height >= y
	end
end

function Rect:Copy()
	return Rect(self.x, self.y, self.width, self.height)
end

function Rect:Max()
	return vec2(self.x+self.width, self.y+self.height)
end

function Rect:Position()
	return vec2(self.x, self.y)
end

function Rect:Min()
	return vec2(self.x, self.y)
end

function Rect:Size()
	return vec2(self.width, self.height)
end

function Rect:Centre()
	return vec2(self.x+self.width/2, self.y+self.height/2)
end

function Rect:SetPositionByCentre(pos, y)
	local x = pos
	if type(pos) == "table" then
		x = pos.x
		y = pos.y
	end
	local c = self:Centre()
	local dx = x-c.x
	local dy = y-c.y
	self.x = self.x + dx
	self.y = self.y + dy
end

function Rect.Zero()
	return Rect(0,0,0,0)
end
