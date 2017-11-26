local KeyFrame = Class()

function KeyFrame:Create()
    self.skeleton = Graph.Graph() -- a graph
end

function KeyFrame:AddNode(x,y)
    local node = Animation.Node(x,y)
    self.skeleton:AddVertex(node)
    console:Log("added node at "..x..", "..y)
end

function KeyFrame:HasNode(n)
    return self.skeleton:HasVertex(n)
end

function KeyFrame:MoveNode(n, pos)
    n.position = pos
end

function KeyFrame:Connect(a,b)
    self.skeleton:Connect(a,b)
end

function KeyFrame:Disconnect(a,b)
    self.skeleton:Disconnect(a,b)
end

function KeyFrame:Nodes()
    return pairs(self.skeleton.vertices)
end

function KeyFrame:Connections()
    return pairs(self.skeleton.edges)
end

return KeyFrame
