local Editor = Namespace{

    Model = "Animation/Editor/model",
    View = "Animation/Editor/view",
    Control = "Animation/Editor/control",

}

Editor:AddNames{
        NodeEditor = "Animation/Editor/nodeeditor",
        KeyFrameEditor = "Animation/Editor/keyframeeditor",
        Window = "Animation/Editor/window"
}
return Editor
