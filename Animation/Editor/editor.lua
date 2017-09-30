local function load(file)
    return require ("Animation/Editor/"..file)
end
local Editor = Namespace{

    Model = load"model",
    View = load"view",
    Control = load"control",

}

Editor:AddNames{
        NodeEditor = "Animation/Editor/nodeeditor",
        KeyFrameEditor = "Animation/Editor/keyframeeditor",
        Window = "Animation/Editor/window"
}
return Editor
