Personality = Class()

function Personality.Create()
	local p = {
		opinions = {}, -- concepts and our favourability 
		memories = {}, -- events and things we remember
		identity = {}, -- who we think we are
		traits = {}, -- biological and psychological things
		currentState = {}, -- mood, thoughts, desires
	}
	return p
end