Class = {
	type = "Class"
}

Class.__index = Class

function Class.__call(t,...)
	local result = t
	if t.Create then
		result = t.Create(...)
	end
	local mt = {}
	if t.mt then
		mt = t.mt
	else 
		mt.__index = t
	end
	return setmetatable(result, mt)
end

Class.mt = {}

function Class.mt.__call(t,class)
	class = class or {}
	local mt = {
		__call = t.__call
	}
	return setmetatable(class, mt)
end

setmetatable(Class, Class.mt)