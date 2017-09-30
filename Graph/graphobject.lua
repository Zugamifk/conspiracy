local Graph = Class()

function Graph:Create()
    self.vertices = {}
    self.edges = {}
end

function Graph:AddVertex(v)
    self.vertices[v] = v
end

function Graph:HasVertex(v)
    return self.vertices[v] ~= nil
end

function Graph:Connect(a,b)
    local edge = Graph.Edge(a,b)
    self.edges[edge] = edge
    return edge
end

function Graph:GetEdge(a,b)
    return self:GetConnected():Filter(function(e) return e[b] end):Single()
end

function Graph:Disconnect(a,b)
    return table.remove(self.edges, self:GetEdge(a,b))
end

function Graph:GetConnected(v)
    return tablep.Filter(self.edges, function(e) return e[v] end)
end

return Graph
