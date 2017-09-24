local View = Class()

function View.Create(rect)
    local window = UI.Window(rect)
    local view = {
        window = window
    }

    local kfe = Animation.Editor.KeyFrameEditor()
    local kfr = rect:Copy()
    kfr.x = 10
    kfr.width = kfr.width - 20
    kfr.y = 10
    kfr.height = math.min(kfr.height - 200, 150)
    window:AddObject(kfe,kfr)
    return view
end

return View
