local Model = Class()

function Model.Create()
    local model = {
        keyframe = nil
    }

    return model
end

function Model:SetKeyFrame(keyframe)
    self.keyframe = keyframe
end

return Model
