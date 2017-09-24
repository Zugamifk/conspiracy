local Controller = Class()

function Controller.Create(ui)
	return {
		ui = ui,
		focus = nil,
		inputfocus = nil
	}
end

function Controller:UpdateEvents(events)
	--toggle console
	if events["`"] and events["`"].event == "pressed" then
		console.enabled = not console.enabled
	end

	-- get input focus
	local f = nil --this might not work
	local mx,my = love.mouse.getPosition()
	-- find a selectable
	for i,s in ipairs(self.ui.selectables) do
		if s.rect:Contains(mx,my) then
			f = s
			break
		end
	end
	-- find a window
	if not f then
		for i,s in ipairs(self.ui.windows) do
			if s.rect:Contains(mx,my) then
				f = s
				break
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
				if not self.inputfocus.focused then
					self.inputfocus = nil
				end
			end
		end
		if events.textinput and self.inputfocus.textinput then
			self.inputfocus.textinput(events.textinput.event)
		end
		if events["return"] and events["return"].event == "pressed" then
			self.inputfocus:Submit()
		end
	end
end

function Controller:Focus(object)
	if self.focus then
		self.focus:Focus(false)
	end
	self.focus = object
	self.ui.statusbar.text = "focus "..tostring(object)
	if object then
		object:Focus(true)
	end
end

return Controller
