local Window = Class()

function Window.Create(rect, ui)
        local window = {
            rect = rect
        }

        local model = Animation.Editor.Model()

        window.model = model

        local view = Animation.Editor.View(rect, model)

        ui:AddWindow("animation", view.window)

        --view.window.enabled = true

        return window
end

return Window
