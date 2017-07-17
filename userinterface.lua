UserInterface = Class()

function UserInterface.Create()
	local ui = {
		style = {
			box = function(cxt)
				local w = cxt.width
				local h = cxt.height
				local x = cxt.x
				local y = cxt.y
				love.graphics.setColor(17,21,32,180)
				love.graphics.rectangle("fill", x,y,w,h)
				love.graphics.setColor(154,85,70,255)
				love.graphics.rectangle("line", x,y,w,h)
			end
		}
	}
	return setmetatable(ui, UserInterface.mt)
end

function UserInterface:Draw(context)
	local w = context.width
	local h = context.height
	local x = context.x
	local y = context.y
	if self.selected then
		local selectedContext = context:Copy()
		selectedContext.x = w - 300
		selectedContext.width = 290
		selectedContext.y = h - 200
		selectedContext.height = 190
		self.style.box(selectedContext)
		selectedContext.x = selectedContext.x + 10
		selectedContext.width = 32
		selectedContext.y = selectedContext.y + 10
		selectedContext.height = 32
		
		love.graphics.setColor(
			255,255,255
		)
		if self.selected.Draw then
			self.selected:Draw(selectedContext)
		else
			love.graphics.rectangle("fill", unpack(selectedContext))
		end
	end
end

function UserInterface:SelectObject(object)
	self.selected = object
end