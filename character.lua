Character = Class()

function Character.Create()
	local cc = {
		speed = 1, -- tiles per second
		timer = 0, -- for timing
		tile = nil
	}
	return cc
end

function Character:Draw(context)
	assets:Draw("character", 1, context)
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