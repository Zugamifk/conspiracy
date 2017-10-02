local UserInterfaceModel = Class()

function UserInterfaceModel:Create(rect)
	self.selectables = {} -- objects that can recieve input
	self.windows = {}

	self.focus = nil -- object currently undder cursor
	self.inputfocus = nil -- last object clicked on
end

function UserInterfaceModel:GetWindow(name)
	return self.windows[name]
end
return UserInterfaceModel
