Console = Namespace{
    OldConsole = require "Console/console_old",
	OldControl = require "Console/consolecontrol",
    Commands = require "Console/commands",
    Model = require "Console/model",
    View = require "Console/view",
	Control = require "Console/control"
}

function Console.Initialize(userinterface)
    local model = Console.Model()
	local view = Console.View(Rect(250,25,200,400), model)

    local commands = Console.Commands()
    local control = Console.Control(model, commands)
    commands:AddCommand(
        "log",
        function(message)
            control:Log(message)
        end
    )
    view.onSubmit = function(text)
        control:OnSubmit(text)
    end

	userinterface:AddWindow(view.window)

    Console.current = {
        model = model,
        view = view,
        control = control,
        commands = commands
    }
end

function Console.Update(dt)
    if Console.current then
        local c = Console.current
        local v = c.view
        if v then
            v:Update(dt)
        end
    end
end
