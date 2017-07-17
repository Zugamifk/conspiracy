Assets = {}

Assets.mt = {
	__index = Assets
}

function Assets.Create()
	local a = {}
	return setmetatable(a, Assets.mt)
end

function Assets:Load() 
	self:AddSprites("/Art/city.png", "ground", 16,16,16)
	self:AddSprites("/Art/character.png", "character", 1,16,16)
end

function Assets:AddSprites(path, name, count, width, height)
	local image = love.graphics.newImage(path)
	image:setFilter("nearest", "nearest")
	local w, h = image:getDimensions()
	local sprites = {}
	self:AddQuads(sprites, 1, count, 0,0,width,height,w,h)
	assets[name] = {
		image = image,
		sprites = sprites,
		width = w, 
		height = h
	}
end

function Assets:AddQuads(list, index, count, x, y, w, h,iw,ih)
	local x0 = x
	for i=1,count do
		list[index+i-1] = love.graphics.newQuad(x,y,w,h,iw,ih)
		x = x + w
		if x >= iw then 
			x = x0
			y = y + h
		end
		if y >= ih then
			return
		end
	end
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
		love.graphics.draw(img.image, q, x, y, 0, sw, sh)
	else
		love.graphics.draw(img, x, y)
	end
end