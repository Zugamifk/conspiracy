local Commands = Class{
    booltable = {
        on = true,
        off = false,

        enabled = true,
        disabled = false
    }
}

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

function Commands.GetBoolForArg(arg)
    if arg == "false" then
        return false
    elseif arg == "true" then
        return true
    else
        return Commands.booltable[arg]
    end
end

return Commands
