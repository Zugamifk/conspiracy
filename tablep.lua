-- a :: an iterator
-- Ma :: a procedure on the iterator. can also be used as an iterator

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

-- Ma -> (a->Ma) -> Ma
function proc.bind(a, f)
    a = makeprocessobject(a)
    return f(a.iter)
end

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

function proc.totable(a)
    local t = {}
    local i = 1
    --console:Log("a: "..tostring(a))
    for v in a do
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
	local tpr = tablep.concat(tpt,ttt)
        :filter(function(a) return a == a:lower() end)
        :map(function(a) return "-"..a.."_" end)
    local tpi = makeprocessobject(tpt)
    local rt = tpr:totable()
	console:Log(table.concat(rt))
end
