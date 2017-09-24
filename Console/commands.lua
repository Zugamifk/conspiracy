local Commands = Class()

function Commands.Create()
    local commands = {
        commands = {}
    }

    return commands
end

function Commands:AddCommand(name, f)
    local command = {
        procedure = f
    }
    self.commands[name] = command
end

function Commands:DoCommand(name, ...)
    name = string.lower(name)
    if self.commands[name] then
        self.commands[name].procedure(...)
    end
end

return Commands
