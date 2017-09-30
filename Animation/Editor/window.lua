local Window = Class()

function Window.Create(rect, ui)
        local editor = Animation.Editor
        local window = {
            rect = rect,
            model = nil
        }

        local model = editor.Model()
        local keyframe = Animation.KeyFrame()
        model:SetKeyFrame(keyframe)
        window.model = model

        local view = editor.View(rect, model)
        view.keyframeeditor:SetKeyFrame(keyframe)

        ui:AddWindow("animation", view.window)

        local control = editor.Control(model)

        view:SetOnClickKeyFrameEditorField(
            function(pos)
                control:AddNodeToKeyFrame(pos)
                view:Refresh()
                view.window:RefreshSelecablesCache()
            end
        )

        view:SetOnMoveKeyFrameNode(
            function(node, pos)
                control:MoveNode(node, pos)
            end
        )
        --view.window.enabled = true

        return window
end

return Window
