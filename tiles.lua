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

	if tile.name == "chest" then
		if secondChestType == nil then
			local randomNumber = math.random(2)
			if randomNumber == 1 then
				tile.chestType = "weapon"
				secondChestType = "accessory"
			else
				tile.chestType = "accessory"
				secondChestType = "weapon"
			end
		else
			tile.chestType = secondChestType
		end
	end

	tile.spritesheet = tileset
	tile.canvas = love.graphics.newCanvas(tile.width, tile.height)

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
			if currentMap.chestOpened then
				if tile.spritesheetNumber < 26 then
					chestOpening = true
					tile.animationCounter = tile.animationCounter + 1
					if tile.animationCounter > 2 then
						tile.spritesheetNumber = tile.spritesheetNumber + 1
						tile.animationCounter = 0
						if tile.spritesheetNumber == 26 then
							if tile.chestType == "weapon" then
								local randomWeapon = getRandomElement(returnWeaponList())
								local weaponName, _, iconSprite = unpack(getWeaponStats(randomWeapon))
								table.insert(actors, newUi("newWeapon", weaponName, iconSprite))
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
			end
		end
	end

	function tile:getX()
		return math.floor(tile.x + 0.5)
	end

	function tile:getY()
		return math.floor(tile.y + 0.5)
	end

	function tile:draw()
		if (tile.active or bossLevel and tile.name == "teleporter") or tile.name ~= "teleporter" then
			love.graphics.setCanvas(tile.canvas)
			love.graphics.clear()

			love.graphics.setBackgroundColor(0, 0, 0, 0)

			if tile.name == "teleporter" or tile.name == "chest" then
				love.graphics.draw(tile.spritesheet)
			else
				love.graphics.draw(tile.spritesheet, tile.quad)
			end

			love.graphics.setColor(1, 1, 1, 1)
		end
	end

	return tile
end