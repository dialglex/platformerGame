function newTile(tileX, tileY, tileWidth, tileHeight, mapX, mapY, tileQuad, tileset, tileCollidable, hitboxX, hitboxY, hitboxWidth, hitboxHeight)
	local tile = {}
	tile.x = mapX
	tile.y = mapY - (tileHeight - 16)
	tile.width = tileWidth
	tile.height = tileHeight
	tile.collidable = tileCollidable
	tile.quad = tileQuad
	tile.actor = "tile"

	if tile.collidable then
		tile.hitboxX = hitboxX
		tile.hitboxY = hitboxY
		tile.hitboxWidth = hitboxWidth
		tile.hitboxHeight = hitboxHeight
	end

	tile.spritesheet = tileset
	tile.canvas = love.graphics.newCanvas(tile.width, tile.height)

	function tile:act() end

    function tile:getX()
        return math.floor(tile.x + 0.5)
    end

    function tile:getY()
        return math.floor(tile.y + 0.5)
    end

	function tile:draw()
        love.graphics.setCanvas(tile.canvas)
        love.graphics.clear()

        love.graphics.setBackgroundColor(0, 0, 0, 0)

        love.graphics.draw(tile.spritesheet, tile.quad)
        if debug and tile.collidable then
        	love.graphics.setColor(0, 0, 255, 160)
            love.graphics.rectangle("fill", tile.hitboxX, tile.hitboxY, tile.hitboxWidth, tile.hitboxHeight)
        end
        love.graphics.setColor(255, 255, 255)
    end

    return tile
end