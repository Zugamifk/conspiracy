UserInterface = Class()

function UserInterface.Create()
	local ui = {
		style = UI.Style(),
		statusbar = UI.StatusBar("Hello, World!"),
		
		selectables = { -- objects that can recieve input
			UI.Window(Rect(400,25,300,175))
		}
	}

	return setmetatable(ui, UserInterface.mt)
end

function UserInterface:Draw(rect)
	local w = rect.width
	local h = rect.height
	local x = rect.x
	local y = rect.y
	if self.selected then
		local selectedrect = rect:Copy()
		selectedrect.x = w - 300
		selectedrect.width = 290
		selectedrect.y = h - 200
		selectedrect.height = 190
		UI.Box(selectedrect, self.style)
		selectedrect.x = selectedrect.x + 10
		selectedrect.width = 32
		selectedrect.y = selectedrect.y + 10
		selectedrect.height = 32
		
		love.graphics.setColor(
			255,255,255
		)
		if self.selected.Draw then
			self.selected:Draw(selectedrect)
		else
			love.graphics.rectangle("fill", unpack(selectedrect))
		end
	end
	
	for i,s in ipairs(self.selectables) do
		s:Draw(rect, self.style)
	end
	
	self.statusbar:Draw(rect, self.style)
end

function UserInterface:SelectObject(object)
	self.selected = object
end