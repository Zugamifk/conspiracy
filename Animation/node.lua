local Node = Class()

function Node.Create(x,y)
    local node = {
        position = vec2(
            x or 0,
            y or 0
        ),
        connections = {}
    }

    return node
end

return Node
