Distribution = Class()

function Distribution:Create()
end

function Distribution.CreateWeightedDistribution(...)
	local self = Distribution()
	local arg = {...}
	if #arg == 1 and type(arg[1]) == "table" then
		arg = arg[1]
	end
	local intervals = {}
	local sum = 0
	local length = 0
	for i=1,#arg/2 do
		local ai = (i-1)*2+1
		local step = arg[ai]
		local weight = arg[ai+1]
		table.insert(intervals, {step=step, weight = weight})
		sum = sum + weight
		length = length + step
	end
	self.weight = sum
	self.length= length
	self.distribution = function(x)
		local step = 0
		for i,int in ipairs(intervals) do
			step = step + int.weight/self.weight
			if x < step then
				return i
			end
		end
	end
	return self
end
