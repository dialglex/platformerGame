function newTile(tileName, tileWidth, tileHeight, mapX, mapY, tileQuad, tileset, tileCollidable, tileBackground, tilePlatform, tileActive, hitboxX, hitboxY, hitboxWidth, hitboxHeight)
	local tile = {}
	tile.name = tileName
	tile.x = mapX
	tile.y = mapY - (tileHeight - 16)
	tile.width = tileWidth
	tile.height = tileHeight
	tile.collidable = tileCollidable
	tile.background = tileBackground
	tile.platform = tilePlatform
	tile.active = tileActive
	tile.quad = tileQuad
	tile.actor = "tile"

	if tile.collidable then
		tile.hitboxX = hitboxX
		tile.hitboxY = hitboxY
		tile.hitboxWidth = hitboxWidth
		tile.hitboxHeight = hitboxHeight
	else
		tile.hitboxX = 0
		tile.hitboxY = 0
		tile.hitboxWidth = 16
		tile.hitboxHeight = 16
	end

	if tile.platform then
		tile.hitboxHeight = 1
	end

	tile.animationCounter = 0
	tile.spritesheetNumber = 1

	tile.spritesheet = tileset
	tile.canvas = love.graphics.newCanvas(tile.width, tile.height)

	function tile:act(index)
		tile.index = index
		if blocked then
			tile.active = true
		end

		if bossLevel then
			tile.active = false
		end

		if tile.name == "teleporter" and tile.active and noEnemies then
			tile.animationCounter = tile.animationCounter + 1
			if tile.animationCounter > 6 then
				tile.spritesheetNumber = tile.spritesheetNumber + 1
				tile.animationCounter = 0
				if tile.spritesheetNumber > 6 then
					tile.spritesheetNumber = 1
				end
			end
			tile.spritesheet = love.graphics.newImage("images/tiles/teleporter/teleporterOn"..tile.spritesheetNumber..".png")
		end
	end

    function tile:getX()
        return math.floor(tile.x + 0.5)
    end

    function tile:getY()
        return math.floor(tile.y + 0.5)
    end

	function tile:draw()
		if tile.active or bossLevel then
	        love.graphics.setCanvas(tile.canvas)
	        love.graphics.clear()

	        love.graphics.setBackgroundColor(0, 0, 0, 0)

	        love.graphics.draw(tile.spritesheet, tile.quad)
	        
	        love.graphics.setColor(1, 1, 1, 1)
	    end
    end

    return tile
end