local UserInterfaceView = Class()

function UserInterfaceView:Create(model)
    self.model = model
	self.style = UI.Style()
end

function UserInterfaceView:Draw(rect)
	local w = rect.width
	local h = rect.height
	local x = rect.x
	local y = rect.y
	-- draw windows
	for k,s in pairs(self.model.windows) do
		if s.enabled then
			s:Draw(rect, self.style)
		end
	end
end

return UserInterfaceView
