Namespace = {
	type = "namespace"
}

Namespace.mt = {}

function Namespace.mt.__call(t,namespace)
	namespace = namespace or {}
	local mt = {
		__call = t.__call
	}
	return setmetatable(namespace, mt)
end

setmetatable(Namespace, Namespace.mt)