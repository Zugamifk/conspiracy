-- a :: an iterator
-- Ma :: a procedure on the iterator. can also be used as an iterator

local NIL = {}
local proc = {
    __processing = true -- flag for if we need to wrap a table or iterator
}

-- makes a generator of iterators for processing
local function makeiter(t)
    local k = nil
    return function()
        local nk,r = next(t,k)
        k = nk
        return r
    end
end

-- table -> Ma
local function makeprocessobject(t)
    if type(t) == "table" then
        if t.__processing then
            return t
        else
            return proc.result(makeiter(t))
        end
    else
        return proc.result(t)
    end
end
-- generates an iterator wrapped in a monad, can be called like a normal iterator
-- a -> Ma
function proc.result(a)
    return setmetatable(
    {iter = a},
    {
        __call = a,
        __index = proc
    })
end

-- generates a null iterator no matter what it's given
-- a
function proc.zero()

end

-- empty monad
-- Ma
function proc.empty()
    return proc.result(proc.zero)
end

-- Ma -> (a->Ma) -> Ma
function proc.bind(a, f)
    a = makeprocessobject(a)
    return f(a.iter)
end

-- Ma -> f -> Ma
function proc.map(a, f)
    return proc.bind(a,
        function(b)
            return proc.result(
                function()
                    local c = b()
                    if c ~= nil then
                        return f(c)
                    end
                end
            )
        end
    )
end

-- Ma -> f-> Ma
function proc.filter(a,f)
    return proc.bind(a,
        function(b)
            return proc.result(
                function()
                    local c = b()
                    while c ~= nil and not f(c) do
                        c = b()
                    end
                    return c
                end
            )
        end
    )
end

-- Ma -> Ma -> Ma
function proc.concat(a,b)
    return proc.bind(a,
        function(aa)
            return proc.bind(b,
                function(bb)
                    return proc.result(
                        function()
                            local c = aa and aa()
                            if c ~= nil then
                                return c
                            else
                                aa = nil
                                return bb()
                            end
                        end
                    )
                end
            )
        end
    )
end

-- Ma -> f -> x -> Ma (singleton)
function proc.fold(a, f, s)
    return proc.bind(a,
        function (aa)
            return proc.result(
                function()
                    for b in aa do
                        s = f(s,b)
                    end
                    return s
                end
            )
        end
    )
end

-- Ma(Ma) -> Ma
function proc.flatten(a)
    return proc.bind(a,
        function(aa)
            local i = aa()
            if i then return
                proc.concat(i, proc.flatten(aa))
            else
                return proc.empty()
            end
        end
    )
end

-- Ma -> Ma -> Ma
function proc.zip(a,b,f)
    f = f or function(x,y)
        return {x,y}
    end
    return proc.bind(a,
        function(aa)
            return proc.bind(b,
                function(bb)
                    return proc.result(
                        function()
                            local aaa = aa and aa()
                            local bbb = bb and bb()
                            if aaa~= nil or bbb~=nil then
                                if aaa == nil then
                                    aa = nil
                                end
                                if bbb == nil then
                                    bb = nil
                                end
                                return f(aaa,bbb)
                            end
                        end
                    )
                end
            )
        end
    )
end

-- Ma -> bool
function proc.any(a, f)
    f = f or function(x) return x end
    return a:fold(
        function(a,s)
            return f(a) or s
        end,
        false)()
end

-- Ma -> bool
function proc.all(a,f)
    f = f or function(x) return x end
    return a:fold(
        function(a,s)
            return f(a) and s
        end,
        true)()
end

-- ... -> Ma
function proc.varargs(...)
    local n = select("#",...)
    local i = 1
    local t = {...}
    return proc.result(
        function()
            if i <= n then
                local a = t[i]
                i = i + 1
                return a or NIL
            end
        end)
end

-- Ma -> Ma -> Maa (??)
function proc.zipiter(a,b)
    return proc.zip(a,b,
        function(aa,bb)
            return aa,bb
        end
    )
end

-- t -> Ma
function proc.keys(t)
    local k = nil
    return proc.result(
        function()
            local nk,_ = next(t,k)
            k = nk
            return k
        end
    )
end

-- Ma -> table
function proc.totable(a)
    local t = {}
    local i = 1
    --console:Log("a: "..tostring(a))
    for v in a do
        if v == NIL then
            v = nil
        end
        t[i] = v
        i = i + 1
    --    console:Log("v: "..tostring(v))
    end
    return t
end

tablep = {}
setmetatable(tablep, {__index=proc})

function tablep.Test()
    local tpt = {"a", "A", "good", "BAD"}
    local ttt = {"b", "B", "happy", "SAD"}
	local tpr = tablep.flatten({tpt,ttt})
        :filter(function(a) return a == a:lower() end)
        :map(function(a) return "-"..a.."_" end)
    local t = tablep.keys(tpt)
    local tpi = makeprocessobject(tpt)
    local rt = t:totable()
	console:Log(table.concat(rt))
end
