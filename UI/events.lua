local Events = Class()

function Events:Create()
end

function Events:Focus(object)
	love.event.push("UIFocus", object)
end

return Events
