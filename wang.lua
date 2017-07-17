Wang = {
}

Wang.mt = {
	__index = Wang
}

function Wang.Create()
	local w = {}
	w.rules = {}
	return setmetatable(w, Wang.mt)
end

function Wang:AddRule(func, l,r,t,b, weight)
	weight = weight or 1
	self.rules[#self.rules+1] = {l=l,r=r,t=t,b=b, func=func, weight = weight}
end

function Wang:GetRule(l,r,t,b)
	local worker = {}
	for id,rule in ipairs(self.rules) do
		if 	(not l or not rule.l or rule.l == l) and
			(not r or not rule.r or rule.r == r) and
			(not t or not rule.t or rule.t == t) and
			(not b or not rule.b or rule.b == b) then
			table.insert(worker, rule)
		end
	end
			--console:Log(#worker)
	if #worker > 0 then 
		local weights = {}
		for i,v in ipairs(worker) do
			local wi = (i-1)*2+1
			weights[wi] = 1
			weights[wi+1] = v.weight
		end
		local d = Distribution.CreateWeightedDistribution(weights)
		local i = d.distribution(math.random())
		--console:Log(i)
		return worker[i] 
	end
end

function Wang:Clear()
	self.rules = {}
end

function Wang:Draw(context, tile)
	local w = context.width
	local h = context.height
	local x = context.x
	local y = context.y
	if tile.wang then 
		tile.wang.func(context)
	end
end

function Wang:Generate(board)
	local errors = 0
	local resetRadius = 2
	local w = board.width
	local h = board.height
	console:Log("hi!")
	for iters = 1,10 do
		for x = 1,w do
			for y = 1,h do
				if not board.tiles[x][y].wang then 
					local l = x > 1 and board.tiles[x-1][y].wang and board.tiles[x-1][y].wang.r or nil
					local r = x < w and board.tiles[x+1][y].wang and board.tiles[x+1][y].wang.l or nil
					local t = y > 1 and board.tiles[x][y-1].wang and board.tiles[x][y-1].wang.b or nil
					local b = y < h and board.tiles[x][y+1].wang and board.tiles[x][y+1].wang.t or nil
					local rule = self:GetRule(l,r,t,b)
					if rule then 
						board.tiles[x][y].wang = rule
					else
						errors = errors + 1
					end
				end
			end
		end
		if iters < 10 and errors > 0 then 
			for x = 1,w do
				for y = 1,h do
					if not board.tiles[x][y].wang then
						for t in board:GetSurrounding(x,y,resetRadius) do
							t.wang = nil
						end
					end
				end
			end
			errors = 0
		else
			break
		end
	end
end

function Wang.Test()
	local wang = Wang.Create()
	local log = function(msg) 
		return function() console:Log(msg) end 
	end
	
	-- trivial rule
	wang:AddRule(
			log("No sides!"),
			1
	)
	local f = wang:GetRule()
	assert(f, "FAIL! Rule mismatch when testing \'trivial\' with GetRule()")
	f()
	
	local f = wang:GetRule(1)
	assert(f, "FAIL! Rule mismatch when testing \'trivial\' GetRule(1)")
	f()
	
	wang:Clear()
	assert(#wang.rules == 0, "failed to clear!")
	
	-- left
	wang:AddRule(
		log("Left side!"),
		1,
		1
	)
	local f = wang:GetRule(1)
	assert(f, "FAIL! Rule mismatch when testing \'left\' with GetRule(1)")
	f()
	
	local f = wang:GetRule(1,1)
	assert(f, "FAIL! Rule mismatch when testing \'left\' with GetRule(1,1)")
	f()
	
	local f = wang:GetRule()
	assert(f, "FAIL! Rule mismatch when testing \'left\' with GetRule()")
	f()
	
	local f = wang:GetRule(2)
	assert(not f, "FAIL! Rule mismatch when testing \'left\' with GetRule(2)")
	log("GetRule(2) == nil")()
	
	wang:Clear()
	assert(#wang.rules == 0, "failed to clear!")
	
	-- two sides
		wang:AddRule(
		log("Two sides!"),
		1,
		1,nil,1
	)
	local f = wang:GetRule(1,nil,1)
	assert(f, "FAIL! Rule mismatch when testing \'left\' with GetRule(1,nil,1)")
	f()
	local f = wang:GetRule(1,1,1)
	assert(f, "FAIL! Rule mismatch when testing \'left\' with GetRule(1,1,1)")
	f()
	local f = wang:GetRule(1)
	assert(f, "FAIL! Rule mismatch when testing \'left\' with GetRule(1)")
	f()
	local f = wang:GetRule(nil,nil,1)
	assert(f, "FAIL! Rule mismatch when testing \'left\' with GetRule(nil,nil,1)")
	f()
	
	local f = wang:GetRule(2)
	assert(not f, "FAIL! Rule mismatch when testing \'left\' with GetRule(2)")
	log("GetRule(2) == nil")()
	local f = wang:GetRule(nil,nil,2)
	assert(not f, "FAIL! Rule mismatch when testing \'left\' with GetRule(nil,nil,2)")
	log("GetRule(nil,nil,2) == nil")()
	local f = wang:GetRule(1,nil,2)
	assert(not f, "FAIL! Rule mismatch when testing \'left\' with GetRule(1,nil,2)")
	log("GetRule(1,nil,2) == nil")()
	local f = wang:GetRule(2,nil,2)
	assert(not f, "FAIL! Rule mismatch when testing \'left\' with GetRule(2,nil,2)")
	log("GetRule(2,nil,2) == nil")()
	
end
