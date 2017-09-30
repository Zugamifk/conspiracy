local Control = Class()

function Control:Create(console, commands)
    self.console = console
    self.commands = commands
end

function Control:OnSubmit(text)

    self:Log(text)

    local tokens = {}
    local command = ""
    for token in string.gmatch(text, "[^%s]+") do
        if command == "" then
            command = token
        else
            tokens[#tokens+1] = token
        end
    end

    if command ~= "" then
        self:DoCommand(command, unpack(tokens))
    end
end

function Control:DoCommand(command, ...)
    self.commands:DoCommand(command, ...)
end

function Control:Log(message)
    local m = self.console
    m.entries[m.currentindex] = message
	m.currentindex = m.currentindex + 1
    if m.currentindex > m.max then
        m.currentindex = 1
    end
end

return Control
