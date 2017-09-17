UI = Namespace{
	Events = require "UI/events",
	Controller = require "UI/controller",
	
	Colors = require "UI/colors",
	Style = require "UI/style",
	
	StatusBar = require "UI/statusbar",
	Window = require "UI/window"
}

function UI.Box(rect, style, focused)
	focused = focused or false
	
	local w = rect.width
	local h = rect.height
	local x = rect.x
	local y = rect.y
	
	love.graphics.setColor(style.colors.background)
	love.graphics.rectangle("fill", x,y,w,h)
	
	if style.drawOutline then 
		local color = focused and style.colors.focusoutline
			or style.colors.outline
		love.graphics.setColor(color)
		love.graphics.rectangle("line", x,y,w,h)
	end
end

function UI.Text(rect, text, style)
	love.graphics.setColor(style.colors.text)
	love.graphics.print(text, rect.x, rect.y)
end