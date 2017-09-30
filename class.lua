Class = {
	type = "Class"
}

-- constructor to make a new instance
function Class.__call(class,...)
	-- set metatable
	local mt = {
		__index = class -- index class for methods and static values
	}
	-- construct new instance
	local result = setmetatable({}, mt)

	-- initialize base class object if needed
	if class.base then
		result.base = class.base()
	end

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
		__index = base -- if base is given, missing indexes in the table will lookup the base class
	}
	-- set the base class if given
	class.base = base
	return setmetatable(class, mt)
end

setmetatable(Class, Class.mt)
