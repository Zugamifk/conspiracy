local View = Class()

function View:Create(rect, model)
    local window = UI.Window(rect)
    self.model = model
    self.window = window
    self.keyframeeditor = nil


    local kfe = Animation.Editor.KeyFrameEditor()
    local kfr = rect:Copy()
    kfr.x = 10
    kfr.width = kfr.width - 20
    kfr.y = 10
    kfr.height = math.min(kfr.height - 200, 150)
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
