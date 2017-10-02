local A = {}
function A.arg(a,s)
    assert(s(a))
end

function A.strongfunc(f, a)
    return function(...)
        local n = select("#", ...)
        for i=1,n do
            local arg = select(i, ...)
            local asrt = a[i]
            if asrt then
                asrt(arg)
            end
        end
        f(...)
    end
end

function A.asserttype(arg, typename)
    assert(type(arg) == typename,
end

function A.type(t)
    return function(arg)
        A.asserttype(arg, t)
    end
end

A.number = A.type"number"
A.string = A.type"string"
A.table = A.type"table"
A.boolean = A.type"boolean"
A["nil"] = A.type"nil"
A["function"] = A.type"function"
A.userdata = A.type"userdata"
A.thread = A.type"thread"


function A.tabletypes(types)
    return function(t)
        for a,b in tablep.zipiter(t,types) do
            A.type(b)(a)
        end
        return t
    end
end

function A.tablekeys(keys)
    return function(t)
        tableo.foreach(keys,
            function(_,k)
                assert(t[k], "table missing key \'"..tostring(k).."\'!")
            end
        )
        return t
    end
end

function A.typedef(elements)
    return function(t)
        for k,v in pairs(t) do

        end
    end
end

function A.strongtable(t, a, ta)
    a = a or {}
    local mt = {}
    mt.__newindex = function(t,k,v)
        local argassert = a[k]
        if argassert then
            argassert(v)
        end
        rawset(t, k, v)
        if ta then
            ta (t)
        end
    end
    return setmetatable(t, mt)
end

function A.test()
    local t = {1,"a",{},true, bed = "sss"}
    local a = {"number", "string", "table", "boolean", bed = "string"}
    local k = {"bed"}
    local b = a
    --b[2] = "nil"
    local kt = A.tabletypes(a)
    local kk = A.tablekeys(k)
    kk(kt(t))

    local pr = function (str)
        assert(type(str) == "string", "FAILED TO ASSERT ARGS!")
    end

    local af = A.strongfunc(pr, {A.string})
    af("s")

    local at = A.strongtable({}, {x=A.string})
    at.x = "success"
end
return A
