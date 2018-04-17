function newTile(tileX, tileY, tileWidth, tileHeight, mapX, mapY, tileQuad, tileset, tileCollidable)

	local tile = {}
	tile.x = mapX
	tile.y = mapY - (tileHeight - 16)
	tile.width = tileWidth
	tile.height = tileHeight
	tile.collidable = tileCollidable
	tile.quad = tileQuad
	tile.actor = "tile"

	tile.spritesheet = tileset
	tile.canvas = love.graphics.newCanvas(tile.spritesheet:getDimensions())

	function tile:act() end

	function tile:draw()
        love.graphics.setCanvas(tile.canvas)
        love.graphics.clear()

        love.graphics.setBackgroundColor(0, 0, 0, 0)

        love.graphics.draw(tile.spritesheet, tile.quad)
    end

    return tile
end