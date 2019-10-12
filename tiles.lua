function getTileImages()
	corruption1Spritesheet = love.graphics.newImage("images/tiles/corruption/corruption1.png")
	corruption2Spritesheet = love.graphics.newImage("images/tiles/corruption/corruption2.png")
	corruption3Spritesheet = love.graphics.newImage("images/tiles/corruption/corruption3.png")
	corruption4Spritesheet = love.graphics.newImage("images/tiles/corruption/corruption4.png")

	teleporterOffSprite = love.graphics.newImage("images/tiles/teleporter/teleporterOff.png")
	teleporterOnSpritesheet = love.graphics.newImage("images/tiles/teleporter/teleporterOn.png")

	weaponChestOpenSprite = love.graphics.newImage("images/tiles/chest/weaponChestOpen.png")
	weaponChestClosedSprite = love.graphics.newImage("images/tiles/chest/weaponChestClosed.png")
	weaponChestOpeningSpritesheet = love.graphics.newImage("images/tiles/chest/weaponChestOpening.png")

	accessoryChestOpenSprite = love.graphics.newImage("images/tiles/chest/accessoryChestOpen.png")
	accessoryChestClosedSprite = love.graphics.newImage("images/tiles/chest/accessoryChestClosed.png")
	accessoryChestOpeningSpritesheet = love.graphics.newImage("images/tiles/chest/accessoryChestOpening.png")
end

function newTile(tileName, tileWidth, tileHeight, x, y, tileQuad, tileset, tileCollidable, tileBackground, tilePlatform, tileActive, hitboxX, hitboxY, hitboxWidth, hitboxHeight)
	local tile = {}
	tile.name = tileName
	tile.x = x
	tile.y = y - (tileHeight - 16)
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
	tile.frame = 1
	tile.spritesheet = tileset
	tile.counter = 0

	if tile.name == "teleporter" then
		tile.quads = {}
		tile.frames = 6
		for i = 1, tile.frames do
			table.insert(tile.quads, love.graphics.newQuad(tile.width*(i - 1), 0, tile.width, tile.height, teleporterOnSpritesheet:getWidth(), teleporterOnSpritesheet:getHeight()))
		end
	end

	if tile.name == "chest" then
		if tile.x < (16+480+16)/2 then
			tile.side = "left"
		else
			tile.side = "right"
		end
		tile.opening = false
		tile.quads = {}
		tile.frames = 27
		for i = 1, tile.frames do
			table.insert(tile.quads, love.graphics.newQuad(tile.width*(i - 1), 0, tile.width, tile.height, weaponChestOpeningSpritesheet:getWidth(), weaponChestOpeningSpritesheet:getHeight()))
		end
	end

	function tile:act(index)
		tile.index = index

		if tile.name == "corruption" then
			if tile.counter < 1*6 then
				tile.spritesheet = corruption1Spritesheet
			elseif tile.counter < 2*6 then
				tile.spritesheet = corruption2Spritesheet
			elseif tile.counter < 3*6 then
				tile.spritesheet = corruption3Spritesheet
			else
				tile.spritesheet = corruption4Spritesheet
			end
		elseif tile.name == "teleporter" then
			if blocked then
				tile.active = true
			end

			if bossLevel then
				if enemyCounter == 0 then
					-- tile.active = true -- uncomment to unlock level 2
				else
					tile.active = false
				end
			end

			if tile.name == "teleporter" and tile.active then
				tile.animationCounter = tile.animationCounter + 1
				if tile.animationCounter > 6 then
					tile.frame = tile.frame + 1
					tile.animationCounter = 0
					if tile.frame > tile.frames then
						tile.frame = 1
					end
				end
				tile.spritesheet = teleporterOnSpritesheet
				tile.quad = tile.quads[tile.frame]
			else
				tile.spritesheet = teleporterOffSprite
			end
		elseif tile.name == "chest" then
			if bossLevel and enemyCounter > 0 then
				tile.active = false
			else
				tile.active = true
			end

			if mapNumber == 2 then
				tile.chestType = firstChestType
			elseif mapNumber == 4 then
				tile.chestType = secondChestType
			else
				if tile.side == "left" then
					tile.chestType = firstChestType
				else
					tile.chestType = secondChestType
				end
			end

			if tile.active then
				local chestOpened = false
				if tile.side == "left" and currentMap.leftChestOpened or tile.side == "right" and currentMap.rightChestOpened then
					chestOpened = true
				end

				if chestOpened then
					if tile.frame < tile.frames then
						tile.opening = true
						tile.animationCounter = tile.animationCounter + 1
						if tile.animationCounter > 2 then
							tile.frame = tile.frame + 1
							tile.animationCounter = 0
							if tile.frame == 8 then
								local itemType = tile.chestType .. "ChestItem"
								local itemStats = getItemStats(itemType)
								tile.item = newItem(itemType, math.floor(tile.x + tile.width/2 - itemStats.width/2 - 1 + 0.5), math.floor(tile.y + tile.height - itemStats.height/2 - 1 - 23 + 0.5), itemStats)
								table.insert(actors, tile.item)
							elseif tile.frame == 16 then
								if shakeLength < 2 then
									shakeLength = 2
								end
								maxShakeLength = shakeLength
								if shakeAmount < 3 then
									shakeAmount = 3
								end
								maxShakeAmount = shakeAmount
							elseif tile.frame == 20 then
								if shakeLength < 1 then
									shakeLength = 1
								end
								maxShakeLength = shakeLength
								if shakeAmount < 1 then
									shakeAmount = 1
								end
								maxShakeAmount = shakeAmount
							elseif tile.frame == 25 + 1 then
								if tile.item.remove == false then
									tile.frame = 25
								end
							end
						end
						if tile.chestType == "weapon" then
							tile.spritesheet = weaponChestOpeningSpritesheet
						else
							tile.spritesheet = accessoryChestOpeningSpritesheet
						end
						tile.quad = tile.quads[tile.frame]
					else
						tile.opening = false
						if tile.chestType == "weapon" then
							tile.spritesheet = weaponChestOpenSprite
						else
							tile.spritesheet = accessoryChestOpenSprite
						end
					end
				else
					if tile.chestType == "weapon" then
						tile.spritesheet = weaponChestClosedSprite
					else
						tile.spritesheet = accessoryChestClosedSprite
					end

					if tile.counter == 60 then
						table.insert(actors, newDust(tile.x + math.random(0 + 6, tile.width - 6), tile.y + math.random(20 + 4, tile.height - 4), "sparkle"))
						tile.counter = 0
					end
				end
			end
		end
		tile.counter = tile.counter + 1
	end

	function tile:getX()
		return math.floor(tile.x + 0.5)
	end

	function tile:getY()
		return math.floor(tile.y + 0.5)
	end

	return tile
end