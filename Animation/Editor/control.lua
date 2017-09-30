local Control = Class()

function Control.Create(model)
    local control = {
        model = model
    }

    return control
end

function Control:AddNodeToKeyFrame(pos)
    self.model.keyframe:AddNode(pos.x, pos.y)
end

return Control
