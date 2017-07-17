ConsoleControl = {
}

ConsoleControl.mt = {
	__index = ConsoleControl
}

function ConsoleControl.Create(console)
	local cc = {
		console = console,
		focused = false,
		mouseAction = nil
	}
	return setmetatable(cc, ConsoleControl.mt)
end

function ConsoleControl:Update(events)
	if events["`"] and events["`"].event == "pressed" then
		console.enabled = not console.enabled
	end
	
	if events.mousebutton then
		local e = events.mousebutton.event
		local v = self.console.view
		if e.buttonEvent ~= "released" and (self.focused or (e.x < v.width+5 and e.y < v.height+5)) then  
			self.focused = true
			self:HandleClick(e)
			-- use mouse event
			events.mousebutton.used = true
		else
			self.focused = false
			self.mouseAction = nil
		end
	end
end

function ConsoleControl:HandleClick(event)
	local v = self.console.view
	console:Log(event.buttonEvent)
	if event.button == 1 and event.buttonEvent == "held" then
		if self.mouseAction then 
			self:mouseAction(event)
		else
			if event.x > v.width - 5 and event.x < v.width + 5 then
				self.mouseAction = self.ResizeX
			end
			if event.y > v.height - 5 and event.y < v.height + 5 then
				self.mouseAction = self.ResizeY
			end
		end
	end
end

function ConsoleControl:ResizeX(event)
	self.console.view.width = event.x
end

function ConsoleControl:ResizeY(event)
	self.console.view.height = event.y
end