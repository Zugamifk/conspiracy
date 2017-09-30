local Draw= {}

function Draw.FramedBox(rect, style, isfocused)
	Draw.Box(rect, style.colors.background)
	if style.drawOutline then
		local color = focused and style.colors.focusoutline
			or style.colors.outline
		love.graphics.setLineStyle(style.linestyle)
		love.graphics.setLineWidth(style.linewidth)
		Draw.Box(rect, color, true)
	end
end

function Draw.Box(rect, color, line)
	local w = rect.width
	local h = rect.height
	local x = rect.x
	local y = rect.y
	local style = "fill"

	love.graphics.setColor(color)
	if line then
		style = "line"
	end
	love.graphics.rectangle(style, x,y,w,h)
end

function Draw.Circle(circle, color, line)
	local r = circle.r
	local x = circle.x
	local y = circle.y
	local style = "fill"

	love.graphics.setColor(color)
	if line then
		style = "line"
	end
	love.graphics.circle(style, x,y,r)
end


function Draw.Text(rect, text, style)
	love.graphics.setColor(style.colors.text)
	love.graphics.print(text, rect.x, rect.y)
end

return Draw
