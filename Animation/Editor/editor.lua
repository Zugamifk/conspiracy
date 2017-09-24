local function load(file)
    return require ("Animation/Editor/"..file)
end
local Editor = Namespace{
    Window = load"window",
    Model = load"model",
    View = load"view",

    KeyFrameEditor = load"keyframeeditor"
}
return Editor
