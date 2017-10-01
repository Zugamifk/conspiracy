local A = {}
function A.arg(a,s)
    assert(s(a))
end

function A.func(f, a)
    return function(...)
        n = select("#", ...)
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

function A.type(t)
    return function(arg)
        assert(type(arg) == t,
            "TYPE MISMATCH: expected "..t..", got "..type(arg))
    end
end

A.types = {
    number = A.type"number",
    string = A.type"string",
    table = A.type"table",
    bool = A.type"boolean",
    null = A.type"nil",
    func = A.type"function",
    userdata = A.type"userdata",
    thread = A.type"thread"
}

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

function A.test()
    local t = {1,"a",{},true, bed = "sss"}
    local a = {"number", "string", "table", "boolean", "string"}
    local k = {"bed"}
    local b = a
    --b[2] = "nil"
    local kt = A.tabletypes(a)
    local kk = A.tablekeys(k)
    kk(kt(t))

    local pr = function (str)
        assert(type(str) == "string", "FAILED TO ASSERT ARGS!")
    end

    local af = A.func(pr, {A.types.string})
    af(5)
end
return A
