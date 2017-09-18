local Graph = Class()

function Graph.Create()
	return {
		samples = 100,
		lines = {}
	}
end

function Graph:Draw(rect,style)
	local w = rect.width
	local h = rect.height
	local x = rect.x
	local y = rect.y
	
	love.graphics.setColor(style.colors.background)
	love.graphics.rectangle("fill", x,y,w,h)
	
	local centre = rect.y + rect.height/2
	love.graphics.line(rect.x, centre, rect.x+rect.width,centre)
	for _,l in ipairs(self.lines) do
		local xmax = l.rect.x+l.rect.width
		local xscale = rect.width/l.rect.width
		local yscale = rect.height/l.rect.height
		local points = {}
		for x = l.rect.x,xmax, l.step do
			local y = -l.f(x)
			y = math.max(math.min(y, l.rect.y+l.rect.height),l.rect.y)
			table.insert(points, rect.x + (x-l.rect.x)*xscale)
			table.insert(points, y*yscale+centre)
		end
		love.graphics.setColor(l.color or style.colors.line0)
		love.graphics.line(points)
	end
end

function Graph:AddLine(color, f, xmin, xmax, ymin, ymax)
		 step = (xmax-xmin)/self.samples
	if not ymin or not ymax then
		ymin = 1000000
		ymax = -1000000
		for x = xmin,xmax, step do
			ymin = math.min(ymin, f(x))
			ymax = math.max(ymax, f(x))
		end
	end
	self.lines[#self.lines+1] = {f=f,color=color,rect=Rect(xmin,ymin, xmax-xmin,ymax-ymin),step=step}
end

return Graph