local UserInterfaceModel = Class()

function UserInterfaceModel:Create(rect)
	self.selectables = {} -- objects that can recieve input
	self.windows = {} -- dictionary of windows, for lookup
	self.orphans = {} -- objects not in windows

	-- root node for the ui, all windows are its children
	self.root = UI.Element(UI.AnchoredRect(
		rect,
		UI.AnchoredRect.presets.stretch.centremid
	))

	-- the current viewport of the root, used for rebuilding the ui
	self.viewrect = UI.AnchoredRect(rect)

	self.focus = nil -- object currently under cursor
	self.inputfocus = nil -- last object clicked on

	self.style = UI.Style()
end

function UserInterfaceModel:GetWindow(name)
	return self.windows[name]
end
return UserInterfaceModel
