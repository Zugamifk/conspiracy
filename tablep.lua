-- a :: function that returns an iterator
-- Ma :: a procedure on the iterator. a fucntion that returns a

local proc = {
    __processing = true -- flag for if we need to wrap a table or iterator
}

-- takes an iterator and a function that takes and iterator and returns a value
-- return a function that returns iterators
local function makea(iter, f)
    return function()
        -- get iterator
        local current = f(iter)
        -- iterator
        return function()
            -- apply filter
            local c = current
            if c then
                current = f(iter)
                return c
            end
        end
    end
end

-- takes an A and a function that takes an iterator and returns values
-- returns a Ma
local function makema(a, f)
    return proc.result(makea(a(), f))
end
-- generates a result
-- type a -> Ma
function proc.result(a)
    return setmetatable(
    {value = a},
    {
        __call = a,
        __index = proc
    })
end


-- generate a computation
-- type Ma -> (a -> Ma) -> Ma
function proc.bind(a, next)
    return next(a.value)
end

-- filter an iterator
-- type Ma -> ( a -> a ) -> Ma
function proc.filter(a, f)
    return a:bind(
        -- a->Ma
        function(b)
            return makema(
                b,
                function(iter)
                    local c = iter()
                    while c and not f(c) do
                        c = iter()
                    end
                    return c
                end
            )
        end
    )
end

function proc.map(a, f)
    return a:bind(
        -- a->Ma
        function(b)
            return makema(
                b,
                function(iter)
                    local c = iter()
                    if c then
                        c = f(c)
                        return c
                    end
                end
            )
        end
    )
end

tablep = {}
setmetatable(proc, {__index=tablep})

-- makes an a generator of iterators for processing
local function makeiterpairs(t)
    return function()
        local k = nil
        return function()
            local nk,r = next(t,k)
            k = nk
            return r
        end
    end
end

local function getiter(a)
    return a()
end

local function gettable(iter)
    local result = {}
    local i = 1
    for r in iter() do
        result[i] = r
        i = i + 1
    end
    return result
end

local function makeprocessobject(t)
    if t.__processing then
        return t
    else
        return proc.result(makeiterpairs(t))
    end
end

function tablep.Filter(t,f)
    t = makeprocessobject(t)
    return t:filter(f)
end

function tablep.Map(t,f)
    t = makeprocessobject(t)
    return t:map(f)
end

function tablep.Identity(t)
--    return gettable(getiter(proc.result(makeiterpairs(t))))
end

function tablep.Test()
    local tpt = {"a", "A", "good", "BAD"}
	local tpr = tablep.Filter(tpt, function(a) return a == a:lower() end)
        :Map(function(a) return "-"..a.."_" end)
    local tpi = tablep.Identity(tpt)
    local rt = gettable(tpr)
	console:Log(table.concat(rt))
end
