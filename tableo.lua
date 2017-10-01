-- table operations
-- e :: element of a table
-- k :: key to a table
-- t :: table
-- Mt :: monad containing a table

local NIL = {}
local op = {
    __operating = true,
    worker = {}
}

-- Mt or t? -> Mt
local function makeprocessobject(t)
    if type(t) == "table" then
        if t.__operating then
            return t
        else
            return op.result(function() return t end)
        end
    else
    --    return proc.result(t)
    end
end

-- (() -> t) -> Mt
function op.result(t)
    return setmetatable(
    {
        table = t
    },
    {
        __index = op,
        __call = t
    }
    )
end

-- Mt -> (t -> Mt) -> Mt
function op.bind(t,f)
    t = makeprocessobject(t)
    return f(t.table)
end

-- Mt -> (k -> e -> e) -> Mt
function op.map(t,f)
    return t:bind(
        function(a)
            return op.result(
                function()
                    local e = a()
                    for k,v in pairs(e) do
                        e[k] = f(k,v)
                    end
                    return e
                end
            )
        end
    )
end

-- Mt -> (e -> e) -> Mt
function op.filter(t,f)
    return t:bind(
        function(a)
            return op.result(
                function()
                    local e = a()
                    local r = {}
                    for k,v in pairs(e) do
                        if f(v) then
                            r[k] = v
                        end
                    end
                    return r
                end
            )
        end
    )
end

-- forms a union between tables based on keys
-- in the case of a collision, will use pick function or favor b
-- Mt -> Mt -> (e->e->e) -> Mt
function op.union(a,b, pick)
    pick = pick or function(x,y)
        return y
    end
    return a:bind(
        function(t)
            return b:bind(
                function(u)
                    return op.result(
                        function()
                            local tt = t()
                            local tu = u()
                            --console:Log(a:tostring())

                            for k,v in pairs(tt) do
                                if tu[k] then
                                    v = pick(v,tu[k])
                                end
                                tu[k] = v
                            end

                            return tu
                        end
                    )
                end
            )
        end
    )
end

-- forms an intersection between tables based on keys
-- will use pick function or favor b
-- Mt -> Mt -> (e->e->e) -> Mt
function op.intersection(a,b, pick)
    pick = pick or function(x,y)
        return y
    end
    return a:bind(
        function(t)
            return b:bind(
                function(u)
                    return op.result(
                        function()
                            local tt = t()
                            local tu = u()
                            local tr = {}
                            --console:Log(a:tostring())

                            for k,v in pairs(tt) do
                                if tu[k] then
                                    v = pick(v,tu[k])
                                    tr[k] = v
                                end
                            end

                            return tr
                        end
                    )
                end
            )
        end
    )
end

-- return a table containing the keys of the table as elements
-- Mt -> Mt
function op.keys(t)
    return t:bind(
        function(a)
            return op.result(
                function()
                    local e = a()
                    for k,v in pairs(e) do
                        e[k] = k
                    end
                    return e
                end
            )
        end
    )
end

-- put all table values into index keys
-- Ma -> Mb
function op.index(t)
    return t:bind(
        function(a)
            return op.result(
                function()
                    local e = a()
                    local i = 1
                    local r = {}
                    for k,v in pairs(e) do
                        -- console:Log(k..": "..v)
                        r[i] = v
                        i = i + 1
                    end
                    return r
                end
            )
        end
    )
end

-- aggregate a table's key value pairs
-- Mt -> (k -> e -> x -> x) -> x -> x
function op.fold(t, f, s)
    for k,v in pairs(t()) do
        s = f(k,v,s)
    end
    return s
end

-- operate over a function's key value pairs
function op.foreach(t,f)
    for k,v in pairs(t()) do
        f(k,v)
    end
end

-- copy a table
-- Mt -> Mu
function op.copy(t)
    local c = {}
    for k,v in pairs(t()) do
        c[k] = v
    end
    return makeprocessobject(c)
end

-- Mt -> string
function op.tostringverbose(mt)
    local t = mt()
    local results = {"op.tostring "..tostring(t).."\n"}
    for k,v in pairs(t) do
        results[#results+1] =
            string.format("\t%s\t: %s\n", tostring(k), tostring(v))
    end
    return table.concat(results)
end

-- Mt -> string
function op.tostring(mt)
    return table.concat(
        mt:copy():map(function(k,v)return tostring(v).." " end)
        :index()())
end

tableo = {}
setmetatable(tableo,
    {
        __index=function(t,k)
            local f = op[k]
            if type(f) == "function" then
                return function(...)
                    local n = select("#", ...)
                    for i=1,n do
                         local arg = select(i,...)
                         if type(arg) == "table" then
                             arg = makeprocessobject(arg)
                         end
                         op.worker[i] = arg
                    end
                    op.worker.n = n
                    return f(unpack(op.worker,1,op.worker.n))
                end
            else
                return f
            end
        end
    }
)

function tableo.test()
    local t = {"a", "A", "good", "BAD"}
    local u = {"b", "B", s="happy", d="SAD"}

    local tm = tableo.map(t, function(i,s) return s:upper() end)
    local tf = tableo.map(tm, function(i,s) return s:upper() == s end)
    local tu = tableo.union(t,u)
    local tk = tableo.keys(t)

    local su = tableo.tostring(u)
    --local st = tu:tostring()
--    local sv = tu:tostringverbose()
	console:Log(su)
end
