Input = {
	events = {},
	newevents = {}
}

function Input:GenerateEvent(scancode, event)
	self.newevents[scancode] = {event=event}
end

function Input:DoEvents(context)
	local ne = {}
	for k,e in pairs(self.events) do
		if 	not e.used
		 then
			ne[k] = e
		end
	end
	context:UpdateEvents(ne)
end

function Input:Update()
	local count = 0
	for k,e in pairs(self.events) do
		count = count +1
		e.used = false
		if k == "mousebutton" then
			if love.mouse.isDown(e.event.button) then
				e.event.buttonevent = "held"
				e.event.x, e.event.y = love.mouse.getPosition()
			else
				self.events[k] = nil
			end
		elseif love.keyboard.isDown(k) then
			e.event = "held"
		else
			self.events[k] = nil
		end
	end
	for k,e in pairs(self.newevents) do
		self.events[k] = e
	end

	self.newevents = {}
	--if count > 0 then
	--	console:Log(Input)
	--end
end

function Input:ToString()
	local result = "Input: "
	for k,e in pairs(self.events) do
		result = result.."\n\t\""..k.."\""--.."\t"..e.event
	end
	return result
end

setmetatable(Input, {__tostring = Input.ToString})
