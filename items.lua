function newItem(name, x, y, stats)
	local item = {}
	item.name = name
	item.width = stats.width
	item.height = stats.height
	item.type = stats.itemType
	if item.type == "shop" then
		item.x = x
		item.y = y - (item.height - 16)
	else
		item.x = x
		item.y = y
	end
	item.hitboxX = 0
	item.hitboxY = 0
	item.hitboxWidth = item.width
	item.hitboxHeight = item.height

	item.near = false
	item.nearCounter = 0
	item.remove = false
	item.actor = "item"
	item.counter = 0

	item.sprite = stats.sprite
	item.canvas = love.graphics.newCanvas(item.width+2, item.height+2)
	item.xVelocity = 0
	item.yVelocity = 0
	item.xAcceleration = 0
	item.yAcceleration = 0
	if item.type == "chest" then
		item.price = 0
		item.randomName = stats.randomName
		item.spriteCanvas = giveOutline(item.sprite, {248/255, 248/255, 248/255}, true)
		item.yVelocity = -1
		item.yAcceleration = 0.1
	elseif item.type == "shop" then
		local basePrice = 100
		local priceMin = basePrice-(0.2*basePrice)
		local priceMax = basePrice+(0.2*basePrice)
		item.basePrice = math.floor(math.random(priceMin, priceMax) + 0.5)
		item.randomName = stats.randomName
		item.spriteCanvas = giveOutline(item.sprite, {248/255, 248/255, 248/255}, true)
	elseif item.type == "coin" then
		local angle = math.random(0, 2*math.pi)
		local dx = math.cos(angle)
		local dy = math.sin(angle)
		item.xVelocity = 2*dx
		item.yVelocity = 2*dy
		item.xAcceleration = 0.025
		item.yAcceleration = 0.025
		item.spriteCanvas = giveOutline(item.sprite, {248/255, 248/255, 248/255})
	end

	function item:act(index)
		if item.type == "coin" then
			local angle = math.atan2((player.y + player.height/2 + player.yVelocity) - (item.y + item.height/2), (player.x + player.width/2 + player.xVelocity) - (item.x + item.width/2))
			local dx = math.cos(angle)
			local dy = math.sin(angle)

			item.xAcceleration = item.xAcceleration*1.1
			item.yAcceleration = item.yAcceleration*1.1
			item.xVelocity = item.xVelocity + item.xAcceleration*dx
			item.yVelocity = item.yVelocity + item.yAcceleration*dy

			item.x = item.x + item.xVelocity
			item.y = item.y + item.yVelocity

			if item.xVelocity > 25 or item.yVelocity > 25 then
				player.money = player.money + 1
				item.remove = true
			end

			if item.counter == 5 then
				table.insert(actors, newDust(item.x + item.width/2, item.y + item.height/2, "particle"))
				item.counter = 0
			end
		elseif item.type == "shop" then
			if levelName == "grassland" then
				item.price = math.floor(item.basePrice*1 + 0.5)
			elseif levelName == "desert" then
				item.price = math.floor(item.basePrice*1.25 + 0.5)
			elseif levelName == "slime" then
				item.price = math.floor(item.basePrice*1.5 + 0.5)
			elseif levelName == "magma" then
				item.price = math.floor(item.basePrice*1.75 + 0.5)
			elseif levelName == "corruption" then
				item.price = math.floor(item.basePrice*2 + 0.5)
			end
		elseif item.type == "chest" then
			if item.yVelocity <= 0 then
				item.yVelocity = item.yVelocity + item.yAcceleration
				item.y = item.y + item.yVelocity
			end
		end

		if item.type == "shop" or item.type == "chest" then
			if item.near and item.nearCounter < 0.9 then
				item.nearCounter = item.nearCounter + 0.1
			elseif item.near == false and item.nearCounter > 0.1 then
				item.nearCounter = item.nearCounter - 0.1
			end
		end

		if item.remove then
			coinSound:stop()
			coinSound:play()
			table.remove(actors, index)
		end

		item.counter = item.counter + 1
	end

	function item:getX()
		return math.floor(item.x + 0.5)
	end

	function item:getY()
		return math.floor(item.y + 0.5)
	end

	function item:draw()
		love.graphics.setCanvas(item.canvas)
		love.graphics.clear()

		love.graphics.draw(item.spriteCanvas)
	end

	return item
end