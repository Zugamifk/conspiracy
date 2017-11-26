local Control = Class()

function Control:Create(model)
    self.model = model
end

function Control:AddNodeToKeyFrame(pos)
    console:Log("Adding node at "..tostring(pos))
    self.model.keyframe:AddNode(pos.x, pos.y)
end

function Control:ConnectNodes(a,b)
    console:Log("Connecting nodes")
    self.model.keyframe:Connect(a,b)
end

function Control:MoveNode(node, pos)
    console:Log("node position is now "..tostring(pos))
    self.model.keyframe:MoveNode(node, pos)
end

return Control
