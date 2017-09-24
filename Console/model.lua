local Model = Class{
    max = 100
}

function Model.Create()
    local model = {
        entries = {},
        currentindex = 1
    }

    return model
end

function Model:Clear()
    self.entries = {}
end

-- get an iterator for entries
function Model:Entries()
    local index = self.currentindex-1
    if index == 0 then
        index = self.max
    end
    return function()
        while index ~= self.currentindex do
            local i = index
            index = index - 1
            if index < 1 then
                index = self.max
            end
            return self.entries[i]
        end
    end
end

return Model
