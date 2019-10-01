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
	tile.spritesheetNumber = 1
	tile.spritesheet = tileset
	tile.counter = 0

	function tile:act(index)
		tile.index = index
		if tile.name == "teleporter" then
			if blocked then
				tile.active = true
			end

			if bossLevel then
				if enemyCounter == 0 then
					tile.active = true
				else
					tile.active = false
				end
			end

			if tile.name == "teleporter" and tile.active then
				tile.animationCounter = tile.animationCounter + 1
				if tile.animationCounter > 6 then
					tile.spritesheetNumber = tile.spritesheetNumber + 1
					tile.animationCounter = 0
					if tile.spritesheetNumber > 6 then
						tile.spritesheetNumber = 1
					end
				end
				tile.spritesheet = love.graphics.newImage("images/tiles/teleporter/teleporterOn"..tile.spritesheetNumber..".png")
			else
				tile.spritesheet = love.graphics.newImage("images/tiles/teleporter/teleporterOff.png")
			end
		end


		if tile.name == "chest" then
			if mapNumber == 2 then
				tile.chestType = firstChestType
			else
				tile.chestType = secondChestType
			end

			if currentMap.chestOpened then
				if tile.spritesheetNumber < 27 then
					chestOpening = true
					tile.animationCounter = tile.animationCounter + 1
					if tile.animationCounter > 2 then
						tile.spritesheetNumber = tile.spritesheetNumber + 1
						tile.animationCounter = 0
						if tile.spritesheetNumber == 16 then
							if shakeLength < 2 then
								shakeLength = 2
							end
							maxShakeLength = shakeLength
							if shakeAmount < 3 then
								shakeAmount = 3
							end
							maxShakeAmount = shakeAmount
						elseif tile.spritesheetNumber == 20 then
							if shakeLength < 1 then
								shakeLength = 1
							end
							maxShakeLength = shakeLength
							if shakeAmount < 1 then
								shakeAmount = 1
							end
							maxShakeAmount = shakeAmount
						elseif tile.spritesheetNumber == 25 then
							if tile.chestType == "weapon" then
								local randomWeapon = getRandomElement(returnWeaponList())
								local weapon = getWeaponStats(randomWeapon)
								table.insert(actors, newUi("newWeapon", weapon.name, weapon.iconSprite))
							else
								local randomAccessory = getRandomElement(returnAccessoryList())
								table.insert(player.accessories, randomAccessory)
							end
						end
					end
					tile.spritesheet = love.graphics.newImage("images/tiles/chest/"..tile.chestType.."ChestOpening"..tile.spritesheetNumber..".png")
				else
					chestOpening = false
					tile.spritesheet = love.graphics.newImage("images/tiles/chest/"..tile.chestType.."ChestOpen.png")
				end
			else
				tile.spritesheet = love.graphics.newImage("images/tiles/chest/"..tile.chestType.."ChestClosed.png")
				if tile.counter == 60 then
					table.insert(actors, newDust(tile.x + math.random(0 + 6, tile.width - 6), tile.y + math.random(20 + 4, tile.height - 4), "sparkle"))
					tile.counter = 0
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