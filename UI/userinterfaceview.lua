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
    for _,o in ipairs(self.ui.orphans) do
        o:Draw(self.ui.style)
    end
end

return UserInterfaceView
