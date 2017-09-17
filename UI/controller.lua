local Controller = Class()

function Controller.Create(ui)
	return {
		ui = ui
	}
end

function Controller:UpdateEvents(events)
	if events["`"] and events["`"].event == "pressed" then
		console.enabled = not console.enabled
	end
	
	if events.mouseposition then
		local f = nil --this might not work
		for i,s in ipairs(self.ui.selectables) do
			if s.rect:Contains(events.mouseposition) then
				f = s
				break
			end
		end
		self:Focus(f)
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