function newItem(itemName, mapX, mapY, itemType, sprite, width, height, randomItemName)
	local item = {}
	item.name = itemName
	item.width = width
	item.height = height
	item.x = mapX
	item.y = mapY - (item.height - 16)
	item.hitboxX = 0
	item.hitboxY = 0
	item.hitboxWidth = item.width
	item.hitboxHeight = item.height

	item.near = false
	item.nearCounter = 0
	item.remove = false
	item.actor = "item"
	item.type = itemType

	item.basePrice = 10
	item.priceMin = item.basePrice-(0.2*item.basePrice)
	item.priceMax = item.basePrice+(0.2*item.basePrice)
	item.basePrice = math.floor(math.random(100*item.priceMin, 100*item.priceMax)/100 + 0.5)

	if item.type == "shop" then
		item.randomName = randomItemName
	end

	item.sprite = sprite
	item.spriteCanvas = giveOutline(item.sprite, {0.973, 0.973, 0.973})
	item.canvas = love.graphics.newCanvas(item.width+2, item.height+2)

	function item:act(index)
		item.price = math.floor(item.basePrice*(mapNumber*0.2) + 0.5)

		if item.near and item.nearCounter < 0.9 then
			item.nearCounter = item.nearCounter + 0.1
		elseif item.near == false and item.nearCounter > 0.1 then
			item.nearCounter = item.nearCounter - 0.1
		end

		if item.remove then
			table.remove(actors, index)
		end
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

		love.graphics.setBackgroundColor(0, 0, 0, 0)

		love.graphics.draw(item.spriteCanvas)
		
		love.graphics.setColor(1, 1, 1, 1)
	end

	return item
end