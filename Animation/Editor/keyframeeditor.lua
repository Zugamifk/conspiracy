local KeyFrameEditor = Class()

function KeyFrameEditor.Create()
    local kfe = {
        focused = false
    }

    return kfe
end

function KeyFrameEditor:Draw(rect, style)
    UI.Draw.FramedBox(rect, style, self.focused)
end

function KeyFrameEditor:Focus(focused)
    self.focused = focused
end

return KeyFrameEditor
