local Character = Class()

function Character:Create()
	self.speed = 5 -- tiles per second
	self.timer = 0 -- for timing
	self.tile = nil
end

function Character:Draw(context)
	assets:Draw("character", 1, context)
	if self.path then
		pathfinding:DebugDraw(context, self.path)
	end
end

function Character:Update(dt)
	self.timer = self.timer + dt
	if self.path then
		if self.timer > 1/self.speed then
			self.timer = self.timer - 1/self.speed
			local n = #self.path
			local d = self.path[n]
			board:MoveObject(self, d)
			self.path[n] = nil
			if #self.path == 0 then
				self.path = nil
			end
		end
	end
end
 return Character
