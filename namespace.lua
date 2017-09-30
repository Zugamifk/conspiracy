Namespace = {
	type = "namespace"
}

Namespace.mt = {}

function Namespace.mt.__call(t,namespace)
	local ns = {}
	local mt = {
		__call = t.__call,
		__index = t
	}
	Namespace.AddNames(ns, namespace)
	return setmetatable(ns, mt)
end

function Namespace:AddNames(t)
	for n,c in pairs(t) do
		if self[n] then
			error ("name "..n.." already exists in the table! can not load "..c)
		end
		if type(c) == "string" then
			self[n] = require(c)
		else
			self[n] = c
		end
	end
end

setmetatable(Namespace, Namespace.mt)
