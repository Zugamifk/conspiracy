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

function Wang:AddRule(func, id, l,r,t,b)
	self.rules[id] = {l=l,r=r,t=t,b=b, func=func}
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
	if #worker > 0 then 
		return worker[math.random(#worker)] 
	end
end

function Wang:Clear()
	self.rules = {}
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
