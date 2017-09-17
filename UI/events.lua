local Events = Class()

function Events.Create()
	return {
	}
end

function Events:Focus(object)
	love.event.push("UIFocus", object)
end

return Events