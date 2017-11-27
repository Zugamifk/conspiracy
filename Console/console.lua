Console = Namespace{
    OldConsole = require "Console/console_old",
	OldControl = require "Console/consolecontrol",
    Commands = require "Console/commands",
    Model = require "Console/model",
    View = require "Console/view",
	Control = require "Console/control"
}

function Console.Initialize(uicontroller)
    local model = Console.Model()
	local view = Console.View(
        UI.AnchoredRect(Rect(600,25,200,400)), model)

    local commands = Console.Commands()
    local control = Console.Control(model, commands)

    view.onSubmit = function(text)
        control:OnSubmit(text)
    end
    view.onClose = function(v)
        uicontroller:SetWindowActive("console", false)
    end

	uicontroller:AddWindow("console", view.window)
--    uicontroller:SetWindowActive("console", true)

    Console.current = {
        model = model,
        view = view,
        control = control,
        commands = commands,
        uicontrol = uicontroller
    }
    Console.InitCommands(Console.current)
end

function Console.InitCommands(csl)
    local cmd = csl.commands
    local ctrl = csl.control
    local uicontrol = csl.uicontrol
    -- log command
    cmd:AddCommand(
        "log",
        function(message)
            ctrl:Log(message)
        end
    )

    -- set windows active
    cmd:AddCommand(
        "win",
        function(name, enabled)
            if not name or name == "" then
                ctrl:Log("must provide name of window to open!")
                return
            end
            if name == "log" then
                if enabled then
                    console.enabled = Console.Commands.GetBoolForArg(enabled)
                else
                    console.enabled = not console.enabled
                end
                return
            end
            local window = uicontrol.ui:GetWindow(name)
            if not window then
                ctrl:Log("no window named "..name.."!")
                return
            end
            local newenabled = not window.enabled
            if enabled then
                local a = Console.Commands.GetBoolForArg(enabled)
                if type(a) == "boolean" then
                    newenabled = a
                end
            end
            uicontrol:SetWindowActive(name, newenabled)
        end
    )
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
