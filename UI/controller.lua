local Controller = Class()

function Controller:Create(ui)
	self.ui = ui
	self.focus = nil -- object currently undder cursor
	self.inputfocus = nil -- last object clicked on
end

function Controller:UpdateEvents(events)
	if events["`"] and events["`"].event == "pressed" then
		self:SetWindowActive("console")
	end

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
	if f ~= self.focus then
		self:Focus(f)
	end
	-- update input focus if mouse button was pressed
	if events.mousebutton and
		events.mousebutton.event.buttonevent == "pressed" then
		self.inputfocus = f;
	end

	-- input events
	if self.inputfocus then
		if events.mousebutton then
			local e = events.mousebutton.event
			if e.buttonevent == "pressed" then
				if self.inputfocus.MouseDown then
					self.inputfocus:MouseDown()
				end
			elseif e.buttonevent == "held" and self.inputfocus.Drag then
				self.inputfocus:Drag()
			elseif e.buttonevent == "released" then
				if self.inputfocus.MouseUp then
					self.inputfocus:MouseUp()
				end
				if self.inputfocus ~= self.focus then
					self.inputfocus = nil
				end
			end
		end
		if events.textinput and self.inputfocus.TextInput then
			self.inputfocus:TextInput(events.textinput.event)
		end
		if events["return"] and events["return"].event == "pressed" then
			if self.inputfocus.Submit then
				self.inputfocus:Submit()
			end
		end
	end
end

function Controller:Focus(object)
	if self.focus and self.focus.Focus then
		self.focus:Focus(false)
	end
	self.focus = object
	self.ui.statusbar.text = "focus "..tostring(object)
	if object and object.Focus then
		object:Focus(true)
	end
end

function Controller:SetWindowActive(name, enabled)
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
		self.ui.selectables[name] = window.selectables
	else
		self.ui.selectables[name] = nil
		for i,s in ipairs(window.selectables) do
			if s == self.focus then
				self:Focus(nil)
			end
			if s == self.inputfocus then
				self.inputfocus = nil
			end
		end
	end
end

function Controller:AddWindow(name, window)
	self.ui.windows[name] = window
end
return Controller
