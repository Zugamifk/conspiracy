Rect = Class{
	type = "Rect"
}

function Rect:Create(x,y,w,h)
	if type(x) == "table" then
		self.x = x.x
		self.y = x.y
		self.width = x.width
		self.height = x.height
	else
		self.x = x
		self.y = y
		self.width = w
		self.height = h
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

function Rect:GetMax()
	return vec2(self.x+self.width, self.y+self.height)
end

function Rect:SetMax(max)
	self.width = max.x - self.x
	self.height = max.y - self.y
end

function Rect:GetPosition()
	return vec2(self.x, self.y)
end

function Rect:SetPosition(pos)
	self.x = pos.x
	self.y = pos.y
end

function Rect:GetMin()
	return vec2(self.x, self.y)
end

function Rect:SetMin(min)
	local dx,dy = min.x-self.x, min.y-self.y
	self.x = min.x
	self.y = min.y
	self.width = self.width - dx
	self.height = self.height - dy
end

function Rect:GetSize()
	return vec2(self.width, self.height)
end

function Rect:SetSize(size)
	self.width = size.x
	self.height = size.y
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

function Rect.Unit()
	return Rect(0,0,1,1)
end

function Rect:ToString()
	return string.format("rect: (x:%d y:%d w:%d h:%d)",self.x, self.y, self.width, self.height)
end
