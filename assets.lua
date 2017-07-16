Assets = {}

Assets.mt = {
	__index = Assets
}

function Assets.Create()
	local a = {}
	return setmetatable(a, Assets.mt)
end

function Assets:Load() 
	local image = love.graphics.newImage("/Art/city.png")
	image:setFilter("nearest", "nearest")
	local w, h = image:getDimensions()
	local sprites = {}
	sprites[1] = love.graphics.newQuad(0,0,16,16, w, h)
	assets.ground = {
		image = image,
		sprites = sprites,
		width = w, 
		height = h
	}
end

function Assets:GetImage(name)
	
	local img = self[name]
	
	-- not found
	if not img then return nil end
	
	return img
end

function Assets:Draw(name, index, context)
	local w = context.width
	local h = context.height
	local x = context.x
	local y = context.y
	local img = self:GetImage(name)
	if type(img) == "table" then
		local q = img.sprites[index]
		local _,_,qw,qh = q:getViewport()
		local sw = w/qw
		local sh = h/qh
		love.graphics.draw(img.image, img.sprites[1], x, y, 0, sw, sh)
	else
		love.graphics.draw(img, x, y)
	end
end