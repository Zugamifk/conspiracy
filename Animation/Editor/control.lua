local Control = Class()

function Control.Create(model)
    local control = {
        model = model
    }

    return control
end

function Control:AddNodeToKeyFrame(pos)
    console:Log("Adding node at "..tostring(pos))
    self.model.keyframe:AddNode(pos.x, pos.y)
end

function Control:MoveNode(node, pos)
    console:Log("node position is now "..tostring(pos))
    self.model.keyframe:MoveNode(node, pos)
end

return Control
