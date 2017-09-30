local Edge = Class()

function Edge.Create(a,b)
    local edge = {
        a = a,
        b = b
    }
    return edge
end

return Edge
