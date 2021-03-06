local model = require "UI/userinterfacemodel"
local view = require "UI/userinterfaceview"
local control = require "UI/userinterfacecontrol"
local UserInterface = Class()

function UserInterface:Create()
	local rect = Rect(0,0,love.graphics.getDimensions())
	local anchoredrect = UI.AnchoredRect(rect)
	self.model = model(anchoredrect)
	self.view = view(self.model)
	self.control = control(self.model)

	local main = UI.Window(UI.AnchoredRect(nil, UI.AnchoredRect.presets.stretch.full))
	main.draggable = false
	main.drawframe = false
	main.canfocus = false
	self.control:AddWindow("main", main)
	self:SetWindowActive("main", true)

	self.control:Rebuild()
end

function UserInterface:Draw()
	-- self.model:GetWindow("main").rect = rect
	self.view:Draw()
end

function UserInterface:UpdateEvents(events)
	self.control:UpdateEvents(events)
end

function UserInterface:Update()
	self.control:Rebuild()
end

function UserInterface:SetWindowActive(name, enabled)
	self.control:SetWindowActive(name, enabled)
end

function UserInterface:AddObjectToRoot(object)
	self.model.windows.main:AddObject(object)
end

return UserInterface
