local Object = Class()

function Object:Create()
    self.vertices = {}
    self.edges = {}
end

function Object:AddVertex(v)
    self.vertices[v] = v
end

function Object:HasVertex(v)
    return self.vertices[v] ~= nil
end

function Object:Connect(a,b)
    local edge = Graph.Edge(a,b)
    self.edges[edge] = edge
    return edge
end

function Object:GetEdge(a,b)
    return self:GetConnected():Filter(function(e) return e[b] end):Single()
end

function Object:Disconnect(a,b)
    return table.remove(self.edges, self:GetEdge(a,b))
end

function Object:GetConnected(v)
    return tablep.Filter(self.edges, function(e) return e[v] end)
end

return Object
