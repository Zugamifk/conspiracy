local View = Class()

function View:Create(rect, model)
    local window = UI.Window(rect)
    self.model = model
    self.window = window
    self.keyframeeditor = nil

    -- verticl layout for window
    local layout = UI.LayoutGroup("vertical")
    layout.rect:SetAnchorOffsets(10,nil,-10,nil)
    layout.minpadding = 10
    layout.spacing = 10

    -- keyframe editor pane
    local kfe = Animation.Editor.KeyFrameEditor()
    local kfr = UI.AnchoredRect(
        Rect(0,0,0,250),
        UI.AnchoredRect.presets.stretch.top)
    kfe.rect = kfr
    layout:AddObject(kfe)

    local buttons = UI.LayoutGroup("horizontal")
    UI.AnchoredRect.presets.stretch.top(buttons.rect)
    buttons.rect.padding.y = 16

    local addbutton = UI.Button("Add")
    UI.AnchoredRect.presets.stretch.left(addbutton.rect)
    addbutton.rect.padding.x = 100
    buttons:AddObject(addbutton)

    layout:AddObject(buttons)

    local textbox = UI.TextBox("Textbox")
    textbox.rect = UI.AnchoredRect(
        Rect(0,0,0,128),
        UI.AnchoredRect.presets.stretch.top
    )
    layout:AddObject(textbox)

    window:AddObject(layout)
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

function View:SetOnConnectedNodes(callback)
    self.keyframeeditor.onConnectNodes = callback
end

return View
