Namespace = {
	type = "namespace"
}

Namespace.mt = {}

function Namespace.mt.__call(t,namespace)
	namespace = namespace or {}
	local mt = {
		__call = t.__call,
		__index = t
	}
	return setmetatable(namespace, mt)
end

function Namespace:AddNames(t)
	for n,c in pairs(t) do
		if self[n] then
			error ("name "..n.." already exists in the table! can not load "..c)
		end
		self[n] = require(c)
	end
end

setmetatable(Namespace, Namespace.mt)
