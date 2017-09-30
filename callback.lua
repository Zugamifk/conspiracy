-- encapsulates a method call with the calling object in a function
-- turns object oriented code into functional code!
local Callback = {}
local mt = {}
function mt:__call(obj, f)
    return function(...)
        f(obj, ...)
    end
end


return setmetatable(Callback, mt)
