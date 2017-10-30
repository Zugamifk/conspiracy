local A = {}

-- assert a function on an arg
-- a: the argument to test
-- s: a function returning a boolean and optionally a message on fail
function A.arg(a,s)
    assert(s(a))
end

-- composes a function with a function that intercepts the call and runs asserts
-- on the arguments given to the call. calls the function as normal
-- f: the funciton to wrap
-- a: an index set of functions of the type A -> () which should be asserts
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

-- asserts that a value has a given type or will throw an error
function A.asserttype(arg, typename)
    assert(type(arg) == typename,
        "TYPE MISMATCH: expected "..typename..", got "..type(arg))
end

-- curry asserttype
function A.type(t)
    return function(arg)
        A.asserttype(arg, t)
    end
end

-- a bunch of predefined A.type functions
A.number = A.type"number"
A.string = A.type"string"
A.table = A.type"table"
A.boolean = A.type"boolean"
A["nil"] = A.type"nil"
A.null = A.type"nil"
A.func = A.type"function"
A["function"] = A.type"function"
A.userdata = A.type"userdata"
A.thread = A.type"thread"

-- get a function that will assert a table's values are of a certain type
function A.tabletypes(types)
    return function(t)
        for a,b in tablep.zipiter(t,types) do
            A.type(b)(a)
        end
        return t
    end
end

-- get a function that asserts that a table contains certain keys
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

-- function that tests a table's elements based on the key-value pairs of elements
-- the key will eb the key looked up in t, the value is either a string
-- representation of the required type or a function that will do a test of some
-- kind
function A.typedef(elements)
    return function(t)
        for k,v in pairs(elements) do
            if type(v)=="string" then
                A[v](t[k])
            elseif type(v) == "function" then
                v(t[k])
            end
        end
    end
end

-- protected a table so that adding new keys to it will assert tests on the value
-- and optionally the table itself afterwards
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

-- check a class's 'type' values
function A.classtype(ctype)
    return function(t)
        assert(t.type == ctype,
            string.format(
                "CLASS TYPE MISMATCH: expected %s, got %s",
                ctype, tostring(t.type)))
    end
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
