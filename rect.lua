Rect = Class()
	
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