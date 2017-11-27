local CharacterControl = Class()

function CharacterControl:Create(character)
    self.character = character
end

function CharacterControl:UpdateEvents(events)
    local char = self.character
    local ms = char.speed
    if events.w then
        char:Move(0,-ms)
    end
    if events.a then
        char:Move(-ms,0)
    end
    if events.s then
        char:Move(0,ms)
    end
    if events.d then
        char:Move(ms,0)
    end
end

function CharacterControl:Draw()

end

return CharacterControl
