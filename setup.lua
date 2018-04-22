function loading()
	loadingImage = love.graphics.newImage("images/HUD/loading.png")
	loadingCanvas = love.graphics.newCanvas(xWindowSize, yWindowSize)
	love.graphics.setCanvas(loadingCanvas)
	love.graphics.draw(loadingImage)
	love.graphics.setCanvas()
	love.graphics.draw(loadingCanvas, (xWindowSize - (480 * scale)) / 2, (yWindowSize - (270 * scale)) / 2, 0, scale, scale)
	love.graphics.present()
end

function setupLevel(chosenMap)
	actors = {}
	for _, layer in ipairs(chosenMap.layers) do
		for _, tilesetData in ipairs(chosenMap.tilesets) do
			local tileset = love.graphics.newImage(string.sub(tilesetData.image, 10))
			if layer.name == tilesetData.name then
				for mapX = 0, layer.width - 1 do
					for mapY = 0, layer.height - 1 do
						local blockID = layer.data[1 + mapX + mapY*layer.width]
						if blockID ~= 0 then
							local tileID = blockID - tilesetData.firstgid

							local tileX = tileID % (tilesetData.imagewidth / tilesetData.tilewidth)
							local tileY = math.floor(tileID / (tilesetData.imageheight / tilesetData.tileheight))

                			local blockQuad = love.graphics.newQuad(tileX * tilesetData.tilewidth, tileY * tilesetData.tileheight, tilesetData.tilewidth, tilesetData.tileheight, tilesetData.imagewidth, tilesetData.imageheight)

							if layer.name == "player" then
                				table.insert(actors, newPlayer(mapX * 16, (mapY * 16) - 8))
                			else
                				local tile = tilesetData.tiles[tileID+1]
                				if tile.properties["collidable"] then
                					local tileHitbox = tile.objectGroup.objects[1]
                					table.insert(actors, newTile(tileX, tileY, tilesetData.tilewidth, tilesetData.tileheight, mapX * 16, mapY * 16,
                						blockQuad, tileset, tile.properties["collidable"], tileHitbox.x, tileHitbox.y, tileHitbox.width, tileHitbox.height))
                				else
                					table.insert(actors, newTile(tileX, tileY, tilesetData.tilewidth, tilesetData.tileheight, mapX * 16, mapY * 16,
                						blockQuad, tileset, tile.properties["collidable"]))
                				end
                			end
						end
					end
				end
			end
		end
	end
end