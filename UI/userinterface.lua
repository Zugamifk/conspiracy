local model = require "UI/userinterfacemodel"
local view = require "UI/userinterfaceview"
local control = require "UI/userinterfacecontrol"
local UserInterface = Class()

function UserInterface:Create()
	self.model = model()
	self.view = view(self.model)
	self.control = control(self.model)

	local main = UI.Window()
	self.control:AddWindow("main", main)
end

function UserInterface:Draw()
	-- self.model:GetWindow("main").rect = rect
	self.view:Draw()
end

function UserInterface:UpdateEvents(events)
	self.control:UpdateEvents(events)
end

function UserInterface:Update()
	local rect = Rect(0,0,love.graphics.getDimensions())
	self.control:Rebuild(rect)
end

function UserInterface:SetWindowActive(name, enabled)
	self.control:SetWindowActive(name, enabled)
end

function UserInterface:AddObjectToMainWindow(object, rect)
	local main = self.model:GetWindow("main", rect)
	main:AddObject(object)
end

return UserInterface
