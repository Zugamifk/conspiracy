Class = {
	type = "Class"
}

-- constructor to make a new instance
function Class.__call(class,...)

	-- set metatable
	local mt = {
		__index = class-- index class for methods and static values
	}

	-- construct new instance
	local result = setmetatable({}, mt)

	-- initialize result
	if class.Create then
		result:Create(...)
	end

	return result
end

-- class metatable
Class.mt = {}

-- for making a new class
function Class.mt.__call(t,class,base)
	-- new class table
	class = class or {}
	local mt = {
		__call = t.__call, -- calling the table will call the above constructor
	}
	-- copy the base class if given
	if base then
		for k,v in pairs(base) do
			if k == "Create" then
				class.base = v
			else
				class[k] = v
			end
		end
	end
	return setmetatable(class, mt)
end

setmetatable(Class, Class.mt)
