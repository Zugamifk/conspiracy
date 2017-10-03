Class = {
	type = "Class"
}

-- constructor to make a new instance
function Class.__call(class,...)
	local function instancebase(t,k)
		local v = rawget(t,k)
		if v~= nil then
			return v
		end
		local b = rawget(t,"base")
		if b then
			return instancebase(b,k)
		end
	end
	-- set metatable
	local mt = {
		__index = function(t,k) -- index class for methods and static values
			local base = instancebase(t,k)
			if base~=nil then
				return base
			end

			return class[k]
		end
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
		__index = base -- if base is given, missing indexes in the table will lookup the base class
	}
	-- set the base class if given
	class.base = base
	return setmetatable(class, mt)
end

setmetatable(Class, Class.mt)
