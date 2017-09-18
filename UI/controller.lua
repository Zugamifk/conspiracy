local Controller = Class()

function Controller.Create(ui)
	return {
		ui = ui,
		focus = nil,
		inputfocus = nil
	}
end

function Controller:UpdateEvents(events)
	if events["`"] and events["`"].event == "pressed" then
		console.enabled = not console.enabled
	end
	
	if not self.inputfocus then 
		local f = nil --this might not work
		local mx,my = love.mouse.getPosition()
		for i,s in ipairs(self.ui.selectables) do
			if s.rect:Contains(mx,my) then
				f = s
				break
			end
		end
		if f ~= self.focus then
			self:Focus(f)
		end
	end
	
	if self.focus and events.mousebutton then
		local e = events.mousebutton.event
		if e.buttonevent == "pressed" then
			if self.focus.MouseDown then 
				self.focus:MouseDown()
			end
			self.inputfocus = self.focus
		elseif e.buttonevent == "held" and self.focus.Drag then
			self.focus:Drag()
		elseif e.buttonevent == "released" then
			if self.focus.MouseUp then 
				self.focus:MouseUp()
			end
			self.inputfocus = nil
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