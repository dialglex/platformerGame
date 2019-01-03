function newItem(itemName, mapX, mapY, itemType, sprite, width, height)
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

	item.remove = false
	item.actor = "item"
	item.type = itemType

	item.sprite = sprite
	item.spriteCanvas = giveOutline(item.sprite, {0.973, 0.973, 0.973})
	item.canvas = love.graphics.newCanvas(item.width+2, item.height+2)

	function item:act(index)
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