local Model = Class()

function Model:Create()
    self.keyframe = nil
end

function Model:SetKeyFrame(keyframe)
    self.keyframe = keyframe
end

return Model
