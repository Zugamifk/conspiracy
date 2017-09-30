local Window = Class()

function Window:Create(rect, ui)
        local editor = Animation.Editor

        self.rect = rect
        self.model = nil

        local model = editor.Model()
        local keyframe = Animation.KeyFrame()
        model:SetKeyFrame(keyframe)
        self.model = model

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
end

return Window
