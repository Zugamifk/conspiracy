local UserInterfaceControl = Class()

function UserInterfaceControl:Create(ui)
	self.ui = ui
end

function UserInterfaceControl:UpdateEvents(events)
	-- get input focus
	local f = nil --this might not work
	local mx,my = love.mouse.getPosition()
	-- find a selectable
	for k,sl in pairs(self.ui.selectables) do
		for i,s in ipairs(sl) do
			if s.rect:Contains(mx,my) then
				f = s
				break
			end
		end
	end
	-- find a window
	if not f then
		for k,s in pairs(self.ui.windows) do
			if s.enabled then
				if s.rect:Contains(mx,my) then
					f = s
					break
				end
			end
		end
	end
	-- switch focus
	if f ~= self.ui.focus then
		self:Focus(f)
	end
	-- update input focus if mouse button was pressed
	if events.mousebutton and
		events.mousebutton.event.buttonevent == "pressed" then
		self.ui.inputfocus = f;
	end

	local ifoc = self.ui.inputfocus
	-- input events
	if ifoc then
		if events.mousebutton then
			local e = events.mousebutton.event
			if e.buttonevent == "pressed" then
				if ifoc.MouseDown then
					ifoc:MouseDown()
				end
			elseif e.buttonevent == "held" and ifoc.Drag then
				ifoc:Drag()
			elseif e.buttonevent == "released" then
				if ifoc.MouseUp then
					ifoc:MouseUp()
				end
				if self.inputfocus ~= self.focus then
					self.inputfocus = nil
				end
			end
		end
		if events.textinput and ifoc.TextInput then
			ifoc:TextInput(events.textinput.event)
		end
		if events["return"] and events["return"].event == "pressed" then
			if ifoc.Submit then
				ifoc:Submit()
			end
		end
	end
end

function UserInterfaceControl:Rebuild()
	self.ui.root:Rebuild(self.ui.viewrect, self.ui.style)
end

function UserInterfaceControl:Focus(object)
	if self.ui.focus and self.ui.focus.Focus then
		self.ui.focus:Focus(false)
	end
	self.ui.focus = object
	if object and object.Focus then
		object:Focus(true)
	end
end

function UserInterfaceControl:SetWindowActive(name, enabled)
	local window = self.ui.windows[name]
	if not window then
		console:Log("No window named "..name.." exists!")
		return
	end

	if type(enabled) ~= "boolean" then
		enabled = not window.enabled
	end

	window:SetActive(enabled)

	if enabled then
		window:Rebuild(self.ui.viewrect, self.ui.style)
		self.ui.selectables[name] = window.selectables
	else
		self.ui.selectables[name] = nil
		for i,s in ipairs(window.selectables) do
			if s == self.ui.focus then
				self:Focus(nil)
			end
			if s == self.ui.inputfocus then
				self.ui.inputfocus = nil
			end
		end
	end
end

function UserInterfaceControl:AddWindow(name, window)
	self.ui.windows[name] = window
	self.ui.root:AddChild(window)
end
return UserInterfaceControl
