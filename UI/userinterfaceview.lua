local UserInterfaceView = Class()

function UserInterfaceView:Create(ui)
    self.ui = ui
end

function UserInterfaceView:Draw()
	-- draw windows
	for k,s in pairs(self.ui.windows) do
		if s.enabled then
			s:Draw(self.ui.style)
		end
	end
end

return UserInterfaceView
