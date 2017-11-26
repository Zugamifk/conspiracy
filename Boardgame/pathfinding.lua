local PathFinding = Class()

function PathFinding:Create(board)
	self.board = board
end

function PathFinding:Path(start, goal)
	local closed = {}
	local open = {}
	open[start] = true
	local openCount = 1
	local sources = {}
	local pathScores = {}
	pathScores[start] = 0
	local includeScores = {} -- adding new values defaults to infinity
	includeScores[start] = self:Distance(start, goal)
	local current = nil
	local checkNeighbour = function(t)
		if closed[t] then
			return
		end
		if not open[t] then
			open[t] = true
			openCount = openCount + 1
			pathScores[t] = math.huge
			includeScores[t] = math.huge
		end
		local newScore = pathScores[current] + 1
		if newScore > pathScores[t] then
			return
		end
		sources[t] = current
		pathScores[t] = newScore
		includeScores[t] = newScore + self:Distance(t, goal)
	end
	while openCount > 0 do
		for t,_ in pairs(open) do
			if (not current) or includeScores[t] < includeScores[current] then
				current = t
			end
		end
		if current == goal then
			break
		end
		open[current] = nil
		openCount = openCount - 1
		closed[current] = true
		local l = self.board:GetTile(current.x-1,current.y)
		if l then checkNeighbour(l) end
		local r = self.board:GetTile(current.x+1,current.y)
		if r then checkNeighbour(r) end
		local t = self.board:GetTile(current.x,current.y-1)
		if t then checkNeighbour(t) end
		local b = self.board:GetTile(current.x,current.y+1)
		if b then checkNeighbour(b) end
		current = nil
	end
	if current == goal then
		local path = {current}
		while sources[current] do
			current = sources[current]
			table.insert(path, current)
		end
		return path
	end
end

-- manhatten distance
function PathFinding:Distance(start, goal)
	return math.abs(goal.x-start.x) + math.abs(goal.y+start.y)
end

function PathFinding:DebugDraw(context, path)
	if #path < 2 then return end
	local w = context.width
	local h = context.height
	local ox = w/2
	local oy = h/2
	local points = {}
	for _,t in ipairs(path) do
		local tx,ty = camera:WorldToScreenPosition(t.x,t.y)
		table.insert(points, tx+ox)
		table.insert(points, ty+oy)
	end
	love.graphics.line(points)
end

return PathFinding
