local View = Class()

function View:Create(rect, model)
    local window = UI.Window(rect)
    self.model = model
    self.window = window
    self.keyframeeditor = nil


    local kfe = Animation.Editor.KeyFrameEditor()
    local kfr = UI.AnchoredRect(
        Rect(0,10,0,250),
        UI.AnchoredRect.presets.stretch.top)
    kfr:SetAnchorOffsets(10,nil,-10,nil)
    window:AddObject(kfe,kfr)
    self.keyframeeditor = kfe
end

function View:Refresh()
    self.keyframeeditor:RefreshKeyFrame()
end

function View:SetOnClickKeyFrameEditorField(callback)
    self.keyframeeditor.onSelectedField = callback
end

function View:SetOnMoveKeyFrameNode(callback)
    self.keyframeeditor.onMoveNode = callback
end

return View
