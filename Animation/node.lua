local Node = Class()

function Node:Create(x,y)
    self.position = vec2(
        x or 0,
        y or 0
    )
    self.connections = {}
end

return Node
