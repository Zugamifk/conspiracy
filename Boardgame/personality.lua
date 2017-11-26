local Personality = Class()

function Personality.Create()
	self.opinions = {} -- concepts and our favourability
	self.memories = {} -- events and things we remember
	self.identity = {} -- who we think we are
	self.traits = {} -- biological and psychological things
	self.currentState = {} -- mood, thoughts, desires
end

return Personality
