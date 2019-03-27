function newPlayer(playerX, playerY)
	player = {}
	player.previousX = playerX
	player.previousY = playerY
	player.x = playerX
	player.y = playerY
	player.width = 15
	player.height = 24

	player.hitboxX = 0
	player.hitboxY = 0
	player.hitboxWidth = 15
	player.hitboxHeight = 24

	player.xVelocity = 0
	player.yVelocity = 0
	player.previousYVelocity = 0

	player.xAcceleration = 0
	player.xDeceleration = 0
	player.xTerminalVelocity = 0
	player.jumpAcceleration = 0
	player.fallAcceleration = 0
	player.yTerminalVelocity = 0

	player.baseXAcceleration = 0.5
	player.baseXDeceleration = 0.3
	player.baseXTerminalVelocity = 2.6
	player.baseJumpAcceleration = 3.9
	player.baseFallAcceleration = 0.25
	player.baseYTerminalVelocity = 8

	player.jumps = 3
	player.jumpsLeft = jumps
	player.jumpHoldDuration = 0.175 * 60
	player.jumpHoldCounter = 0
	player.jumpAble = true
	player.jumpAbleDuration = 0.03 * 60
	player.jumpAbleCounter = 0
	-- jump - min: 2 tiles | max: 4 tiles

	player.transitioning = false
	player.direction = "right"
	player.grounded = true
	player.oldGrounded = true
	player.runDust = false
	player.onLadder = false
	player.offLadderFirstFrame = false
	player.actor = "player"
	player.tileAbove = ""
	player.tileBelow = ""
	player.tileLeft = ""
	player.tileRight = ""

	player.frozen = false
	player.frozenCounter = 0
	player.hit = false
	player.hitLength = 0
	player.hitCounter = 0
	player.invincible = false
	player.invincibilityLength = 60
	player.invincibilityCounter = 0
	player.hp = 3
	player.maxHp = player.hp
	player.knockbackRestistance = 1
	player.weaponOut = false
	player.equippedWeapon1 = "demonBroadsword"
	player.equippedWeapon2 = "woodenBow"
	player.accessories = {}--, "coolHat"}

	player.level = 1
	player.money = 0

	player.runCounter = 0
	player.runQuadSection = 0
	player.jumpCounter = 0
	player.jumpQuadSection = 0
	player.idleCounter = 0
	player.idleQuadSection = 0
	player.climbCounter = 0
	player.climbQuadSection = 0

	player.idleLeftSpritesheet = love.graphics.newImage("images/player/playerIdleLeftSpritesheet.png")
	player.idleRightSpritesheet = love.graphics.newImage("images/player/playerIdleRightSpritesheet.png")
	player.runLeftSpritesheet = love.graphics.newImage("images/player/playerRunLeftSpritesheet.png")
	player.runRightSpritesheet = love.graphics.newImage("images/player/playerRunRightSpritesheet.png")
	player.jumpLeftSpritesheet = love.graphics.newImage("images/player/playerJumpLeftSpritesheet.png")
	player.jumpRightSpritesheet = love.graphics.newImage("images/player/playerJumpRightSpritesheet.png")
	player.climbSpritesheet = love.graphics.newImage("images/player/playerClimbSpritesheet.png")
	player.deadLeftSpritesheet = love.graphics.newImage("images/player/playerDeadLeftSpritesheet.png")
	player.deadRightSpritesheet = love.graphics.newImage("images/player/playerDeadRightSpritesheet.png")
	player.attackLeftSpritesheet = love.graphics.newImage("images/player/playerAttackLeftSpritesheet.png")
	player.attackRightSpritesheet = love.graphics.newImage("images/player/playerAttackRightSpritesheet.png")

	player.canvas = love.graphics.newCanvas(21, 26)

	function player:getX()
		return math.floor(player.x + 0.5)
	end

	function player:getY()
		return math.floor(player.y + 0.5)
	end

	function player:act(index)
		player.previousX = player.x
		player.previousY = player.y
		player:mapTransition()
		player:checkGrounded()
		player:checkBoss()
		if player.frozen == false and chestOpening == false then
			player:statChanges()
			player:combatLogic()
			player:ladder()
			if player:isDead() == false then
				player:openUi()
				if player.jumpAble then
					player:jump()
				end
				if player.invincible == false then
					player:hitCollision()
				end
			else
				player.hp = 0
			end
			if player.onLadder == false then
				player:physics()
				player:xMovement()
				if player.grounded == false then
					player:airPhysics()
				end
			else
				player:airPhysics()
			end
			player:animations()
			player:dust()
		elseif player.frozen then
			if player.frozenCounter > 0 then
				player.frozenCounter = player.frozenCounter - 1
			elseif player.frozenCounter == 0 then
				player.frozen = false
			end
		end

		debugPrint("player.x: " .. player.x)
		debugPrint("player.y: " .. player.y)
		debugPrint("player.xVelocity: " .. player.xVelocity)
		debugPrint("player.yVelocity: " .. player.yVelocity)
		debugPrint("player.jumps: " .. player.jumps)
		debugPrint("player.jumpsLeft: " .. player.jumpsLeft)
		
		debugPrint("Player level: "..player.level)
		debugPrint("spawnRate: "..spawnRate)
		debugPrint("mapNumber: "..mapNumber)
	end

	function player:statChanges()
		player.xAccelerationBuff = 1
		player.xDecelerationBuff = 1
		player.xTerminalVelocityBuff = 1
		player.jumpAccelerationBuff = 1
		player.fallAccelerationBuff = 1
		player.yTerminalVelocityBuff = 1
		for i, accessory in ipairs(player.accessories) do
			local accessoryName, iconImage, accessoryType, text, xAcceleration, xDeceleration, xTerminalVelocity, jumpAcceleration, fallAcceleration,
				yTerminalVelocity = unpack(getAccessoryStats(accessory))
			player.xTerminalVelocityBuff = player.xTerminalVelocityBuff*xTerminalVelocity
			player.xAccelerationBuff = player.xAccelerationBuff*xAcceleration
			player.xDecelerationBuff = player.xDecelerationBuff*xDeceleration
			player.yTerminalVelocityBuff = player.yTerminalVelocityBuff*yTerminalVelocity
			player.jumpAccelerationBuff = player.jumpAccelerationBuff*jumpAcceleration
			player.fallAccelerationBuff = player.fallAccelerationBuff*fallAcceleration
		end

		if player.weaponOut then
			player.xTerminalVelocityBuff = player.xTerminalVelocityBuff / player.currentWeapon.movementReduction
			player.xAccelerationBuff = player.xAccelerationBuff / player.currentWeapon.movementReduction
		end

		player.xAcceleration = player.baseXAcceleration*player.xAccelerationBuff
		player.xDeceleration = player.baseXDeceleration*player.xDecelerationBuff
		player.xTerminalVelocity = player.baseXTerminalVelocity*player.xTerminalVelocityBuff
		player.jumpAcceleration = player.baseJumpAcceleration*player.jumpAccelerationBuff
		player.fallAcceleration = player.baseFallAcceleration*player.fallAccelerationBuff
		player.yTerminalVelocity = player.baseYTerminalVelocity*player.yTerminalVelocityBuff
	end

	function player:openUi()
		if pressInputs.inventory then
			menuConfirmSound:play()
			table.insert(actors, newUi("inventory"))
		end

		if pressInputs.options then
			menuConfirmSound:play()
			table.insert(actors, newUi("options"))
		end
	end


	function player:combatLogic()
		if player.hp > player.maxHp then
			player.hp = player.maxHp
		end

		if player.invincible then
			player.invincibilityCounter = player.invincibilityCounter - 1
		end

		if player.invincibilityCounter <= 0 then
			player.invincible = false
		end

		if (pressInputs.attack1 or pressInputs.attack2) and player.weaponOut == false and player:isDead() == false then
			if pressInputs.attack1 then
				player.attackWeapon = player.equippedWeapon1
			else
				player.attackWeapon = player.equippedWeapon2
			end

			local weaponName, weaponType, iconSprite, startupSprite, slash1Sprite, slash2Sprite, endSprite, width, height, damage, knockback, startupLag,
			slashDuration, endLag, screenShakeAmount, screenShakeLength, screenFreezeLength, xOffset, yOffset, directionLocked, movementReduction, pierce,
			projectile = unpack(getWeaponStats(player.attackWeapon))
			local duration = startupLag + slashDuration + endLag

			if downInputs.left then
				shootDirection = "left"
			elseif downInputs.right then
				shootDirection = "right"
			else
				shootDirection = player.direction
			end

			if downInputs.down and downInputs.left then
				shootDirection = "downLeft"
			elseif downInputs.down and downInputs.right then
				shootDirection = "downRight"
			elseif downInputs.down then
				shootDirection = "down"
			end

			if downInputs.up and downInputs.left then
				shootDirection = "upLeft"
			elseif downInputs.up and downInputs.right then
				shootDirection = "upRight"
			elseif downInputs.up then
				shootDirection = "up"
			end

			if player.direction == "left" then
				table.insert(actors, newWeapon(actors[getTableLength(actors)+1], weaponName, weaponType, player.x + player.width/2 - width/2 - xOffset,
					player.y + player.height/2 - height/2 - yOffset, iconSprite, startupSprite, slash1Sprite, slash2Sprite, endSprite, width, height, damage,
					knockback, startupLag, slashDuration, endLag, duration, screenShakeAmount, screenShakeLength, screenFreezeLength, xOffset, yOffset, directionLocked, movementReduction, pierce, projectile, shootDirection))
			else
				table.insert(actors, newWeapon(actors[getTableLength(actors)+1], weaponName, weaponType, player.x + player.width/2 - width/2 + xOffset,
					player.y + player.height/2 - height/2 + yOffset, iconSprite, startupSprite, slash1Sprite, slash2Sprite, endSprite, width, height, damage,
					knockback, startupLag, slashDuration, endLag, duration, screenShakeAmount, screenShakeLength, screenFreezeLength, xOffset, yOffset, directionLocked, movementReduction, pierce, projectile, shootDirection))
			end
			player.currentWeapon = actors[getTableLength(actors)]
			player.lastUsedWeapon = player.currentWeapon
			player.weaponOut = true
		end

		if player.weaponOut and player.currentWeapon.durationCounter+1 >= player.currentWeapon.duration then
			player.weaponOut = false
		end
	end

	function player:checkBoss()
		if bossLevel == false then
			blocked = true
		else
			blocked = false
		end

		if indoor then
			blocked = false
		end

		if blockTopLeft == false and (currentMap.topLeft or currentMap.bottomLeft) then
			blocked = false
		elseif blockTopMiddle == false and (currentMap.topMiddle or currentMap.bottomMiddle) then
			blocked = false
		elseif blockTopRight == false and (currentMap.topRight or currentMap.bottomRight) then
			blocked = false
		elseif blockLeftTop == false and (currentMap.leftTop or currentMap.rightTop) then
			blocked = false
		elseif blockLeftMiddle == false and (currentMap.leftMiddle or currentMap.rightMiddle) then
			blocked = false
		elseif blockLeftBottom == false and (currentMap.leftBottom or currentMap.rightBottom) then
			blocked = false
		end

		enemyCounter = 0
		for i, npc in ipairs(npcs) do
			if npc.enemy and npc.projectile == false then
				enemyCounter = enemyCounter + 1
			end
		end
		noEnemies = false
		if enemyCounter == 0 then
			noEnemies = true
		end

		if bossLevel and enemyCounter == 0 then
			-- win = true
		end
	end

	function player:isDead()
		return player.hp <= 0
	end

	function player:ladder()
		if player.onLadder then
			player.jumpHoldCounter = 0
			if pressInputs.jump or (pressInputs.interact) then
				if lastInputType == "gamepad" then
					pressInputs.interact = false
				end
				player.onLadder = false
				player.jumpAble = true
				player.yVelocity = 0
				player.xVelocity = 0
				interactSound:play()
				player.offLadderFirstFrame = true
			end

			player.ladderAbove = false
			player.ladderBelow = false
			for _, actor in ipairs(getCollidingActors(player:getX(), player:getY() - 16, player.width, 16+8, false, false, false, false, false, true)) do
				if actor.type == "ladder" then
					player.ladderAbove = true
				end
			end
			for _, actor in ipairs(getCollidingActors(player:getX(), player:getY() + player.height-8, player.width, 16, false, false, false, false, false, true)) do
				if actor.type == "ladder" then
					player.ladderBelow = true
				end
			end

			if downInputs.up and player.ladderAbove then
				player.yVelocity = -1.5
			elseif downInputs.down and player.ladderBelow then
				player.yVelocity = 1.5
			else
				player.yVelocity = 0
			end
		end
	end

	function player:newPlayer(map)
		currentMap = allMaps[map]
		actors = currentMap.actors

		playerExists = false
		for _, actor in ipairs(actors) do
			if actor.actor == "player" then
				playerExists = true
			end
		end
		-- very low - 0.5
		-- low - 1
		-- low-medium - 1.5
		-- medium - 2
		-- medium-high - 2.5
		-- high = 3
		-- very high - 3.5
		--                                          shop
		-- level pacing: start -> 1(2) -> 2(0.5) -> 3(1) -> 4(1.5) -> 5(2) -> 6(2.5) -> boss
		--                               cave1(1.5)       cave2(2.5)
		
		if mapNumber == 1 then
			spawnRate = 50
		elseif mapNumber == 2 then
			spawnRate = 25
		elseif mapNumber == 3 then
			spawnRate = 35
		elseif mapNumber == 4 then
			spawnRate = 50
		elseif mapNumber == 5 then
			spawnRate = 75
		else
			spawnRate = 100
		end

		if indoor then
			spawnRate = spawnRate + 25
		end

		if currentMap.explored == false then
			for i, npcSpawn in ipairs(currentMap.npcSpawns) do
				local randomNumber = math.random(0, 100)
				npcSpawnClone = deepTableClone(npcSpawn)
				if randomNumber < spawnRate and npcSpawnClone.boss == false then
					npcExists = false
					for i, actor in ipairs(actors) do
						if actor.actor == "npc" then
							if actor.uuid == npcSpawnClone.uuid then
								npcExists = true
							end
						end
					end
					if npcExists == false then
						table.insert(actors, npcSpawnClone)
					end
				elseif npcSpawnClone.boss then
					table.insert(actors, npcSpawnClone)
				end
			end
			currentMap.explored = true
		end

		if playerExists == false then
			table.insert(actors, player)
		end
		player:resetWeapon()

		backgroundImage = currentMap.backgroundImage
		backgroundCanvas = currentMap.backgroundCanvas
		foregroundCanvas = currentMap.foregroundCanvas
		currentMapDirectory = currentMap.currentMapDirectory

		topLeft = currentMap.topLeft
		topMiddle = currentMap.topMiddle
		topRight = currentMap.topRight
		bottomLeft = currentMap.bottomLeft
		bottomMiddle = currentMap.bottomMiddle
		bottomRight = currentMap.bottomRight
		leftTop = currentMap.leftTop
		leftMiddle = currentMap.leftMiddle
		leftBottom = currentMap.leftBottom
		rightTop = currentMap.rightTop
		rightMiddle = currentMap.rightMiddle
		rightBottom = currentMap.rightBottom

		backgroundCanvas, foregroundCanvas = unpack(setupCanvases(actors))
	end

	function isSuitableMap()
		if (string.gsub(currentMapDirectory, ".lua", "", 1)) == randomMap then
			return false
		end

		if isInTable(randomMap, mapsUsed) then
			return false
		end

		newMap = allMaps[randomMap]
		newTopLeft = newMap.topLeft
		newTopMiddle = newMap.topMiddle
		newTopRight = newMap.topRight
		newBottomLeft = newMap.bottomLeft
		newBottomMiddle = newMap.bottomMiddle
		newBottomRight = newMap.bottomRight
		newLeftTop = newMap.leftTop
		newLeftMiddle = newMap.leftMiddle
		newLeftBottom = newMap.leftBottom
		newRightTop = newMap.rightTop
		newRightMiddle = newMap.rightMiddle
		newRightBottom = newMap.rightBottom

		local suitableMap = false
		if newTopLeft and bottomLeft and player.y >= 270 and player.x < 10*16 then
			blockTopLeft = true
			blockBottomLeft = true
			suitableMap = true
		elseif newTopMiddle and bottomMiddle and player.y >= 270 and player.x > 10*16 and player.x < 20*16 then
			blockTopMiddle = true
			blockBottomMiddle = true
			suitableMap = true
		elseif newTopRight and bottomRight and player.y >= 270 and player.x > 20*16 then
			blockTopRight = true
			blockBottomRight = true
			suitableMap = true
		elseif newBottomLeft and topLeft and player.y + player.height <= 0 and player.x < 10*16 then
			blockBottomLeft = true
			blockTopLeft = true
			suitableMap = true
		elseif newBottomMiddle and topMiddle and player.y + player.height <= 0 and player.x > 10.16 and player.x < 20*16 then
			blockBottomMiddle = true
			blockTopMiddle = true
			suitableMap = true
		elseif newBottomRight and topRight and player.y + player.height <= 0 and player.x > 20*16 then
			blockBottomRight = true
			blockTopRight = true
			suitableMap = true
		elseif newLeftTop and rightTop and player.x >= 480 and player.y < 7*16 then
			blockLeftTop = true
			blockRightTop = true
			suitableMap = true
		elseif newLeftMiddle and rightMiddle and player.x >= 480 and player.y > 7*16 and player.y < 12*16 then
			blockLeftMiddle = true
			blockRightMiddle = true
			suitableMap = true
		elseif newLeftBottom and rightBottom and player.x >= 480 and player.y > 12*16 then
			blockLeftBottom = true
			blockRightBottom = true
			suitableMap = true
		elseif newRightTop and leftTop and player.x + player.width <= 0 and player.y < 7*16 then
			blockRightTop = true
			blockLeftTop = true
			suitableMap = true
		elseif newRightMiddle and leftMiddle and player.x + player.width <= 0 and player.y > 7*16 and player.y < 12*16 then
			blockRightMiddle = true
			blockLeftMiddle = true
			suitableMap = true
		elseif newRightBottom and leftBottom and player.x + player.width <= 0 and player.y > 12*16 then
			blockRightBottom = true
			blockLeftBottom = true
			suitableMap = true
		end

		return suitableMap
	end

	function player:findRandomMap()
		table.insert(mapsUsed, (string.gsub(currentMapDirectory, ".lua", "", 1)))
		mapNumber = mapNumber + 1

		if levelName == "grassland" then
			if mapNumber == 2 or mapNumber == 4 then
				mapsToCheck = {unpack(allGrasslandCaveMaps)}
			elseif mapNumber == 3 then
				mapsToCheck = {unpack(allGrasslandShopMaps)}
			else
				mapsToCheck = {unpack(allGrasslandOverworldMaps)}
			end
		elseif levelName == "desert" then
			if mapNumber == 2 or mapNumber == 4 then
				mapsToCheck = {unpack(allDesertOverworldMaps)}
			elseif mapNumber == 3 then
				mapsToCheck = {unpack(allDesertOverworldMaps)}
			else
				mapsToCheck = {unpack(allDesertOverworldMaps)}
			end
		end

		local randomNumber = math.random(1, getTableLength(mapsToCheck))
		randomMap = mapsToCheck[randomNumber]

		local suitableMap = false
		suitableMap = isSuitableMap()

		while suitableMap == false do
			local randomNumber = math.random(1, getTableLength(mapsToCheck))
			randomMap = mapsToCheck[randomNumber]

			if isSuitableMap() then
				suitableMap = true
			end
		end
		player:newPlayer(randomMap)

		local image = love.graphics.newImage("images/tiles/corruption.png")
		if blockTopLeft and currentMap.topLeft then
			local quad = love.graphics.newQuad(32, 0, 16, 16, 80, 80)
			table.insert(actors, newTile("corruption", 16, 16, 5*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 6*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 7*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 8*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 9*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
		end
		if blockTopMiddle and currentMap.topMiddle then
			local quad = love.graphics.newQuad(32, 0, 16, 16, 80, 80)
			table.insert(actors, newTile("corruption", 16, 16, 13*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 14*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 15*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 17*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 18*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
		end
		if blockTopRight and currentMap.topRight then
			local quad = love.graphics.newQuad(32, 0, 16, 16, 80, 80)
			table.insert(actors, newTile("corruption", 16, 16, 22*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 23*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 24*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 25*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 26*16, 16, quad, image, true, true, false, true, 0, 0, 16, 16))
		end
		if blockBottomLeft and currentMap.bottomLeft then
			local quad = love.graphics.newQuad(32, 0, 16, 16, 80, 80)
			table.insert(actors, newTile("corruption", 16, 16, 5*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 6*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 7*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 8*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 9*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
		end
		if blockBottomMiddle and currentMap.bottomMiddle then
			local quad = love.graphics.newQuad(32, 0, 16, 16, 80, 80)
			table.insert(actors, newTile("corruption", 16, 16, 13*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 14*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 15*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 17*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 18*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
		end
		if blockBottomRight and currentMap.bottomRight then
			local quad = love.graphics.newQuad(32, 0, 16, 16, 80, 80)
			table.insert(actors, newTile("corruption", 16, 16, 22*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 23*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 24*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 25*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 26*16, 17*16, quad, image, true, true, false, true, 0, 0, 16, 16))
		end
		if blockLeftTop and currentMap.leftTop then
			local quad = love.graphics.newQuad(0, 32, 16, 16, 80, 80)
			table.insert(actors, newTile("corruption", 16, 16, 16, 2*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16, 3*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16, 4*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16, 5*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16, 6*16, quad, image, true, true, false, true, 0, 0, 16, 16))
		end
		if blockLeftMiddle and currentMap.leftMiddle then
			local quad = love.graphics.newQuad(0, 32, 16, 16, 80, 80)
			table.insert(actors, newTile("corruption", 16, 16, 16, 7*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16, 8*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16, 9*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16, 10*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16, 11*16, quad, image, true, true, false, true, 0, 0, 16, 16))
		end
		if blockLeftBottom and currentMap.leftBottom then
			local quad = love.graphics.newQuad(0, 32, 16, 16, 80, 80)
			table.insert(actors, newTile("corruption", 16, 16, 16, 12*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16, 13*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16, 14*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16, 15*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
		end
		if blockRightTop and currentMap.rightTop then
			local quad = love.graphics.newQuad(0, 32, 16, 16, 80, 80)
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 2*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 3*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 4*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 5*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 6*16, quad, image, true, true, false, true, 0, 0, 16, 16))
		end
		if blockRightMiddle and currentMap.rightMiddle then
			local quad = love.graphics.newQuad(0, 32, 16, 16, 80, 80)
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 7*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 8*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 9*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 10*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 11*16, quad, image, true, true, false, true, 0, 0, 16, 16))
		end
		if blockRightBottom and currentMap.rightBottom then
			local quad = love.graphics.newQuad(0, 32, 16, 16, 80, 80)
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 12*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 13*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 14*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 15*16, quad, image, true, true, false, true, 0, 0, 16, 16))
			table.insert(actors, newTile("corruption", 16, 16, 30*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
		end
		backgroundCanvas, foregroundCanvas = unpack(setupCanvases(actors))
	end

	function player:mapTransition()
		if player.x + player.width <= 0 then
			transitioningScreen = true
			player.frozen = true
			player.frozenCounter = -1
			if fadeIn == false then
				player:findRandomMap()
				player.frozen = false
				player.frozenCounter = 0
				player.x = 480 - player.width - 16 + 16
				player.y = player.previousY
			end
		elseif player.x >= 480 then
			transitioningScreen = true
			player.frozen = true
			player.frozenCounter = -1
			if fadeIn == false then
				player:findRandomMap()
				player.frozen = false
				player.frozenCounter = 0
				player.x = 0 + 16 + 16
				player.y = player.previousY 
			end
		end

		if player.y + player.height <= 0 then
			transitioningScreen = true
			player.frozen = true
			player.frozenCounter = -1
			if fadeIn == false then
				player:findRandomMap()
				player.frozen = false
				player.frozenCounter = 0
				player.x = player.previousX
				player.y = 270 - player.height - 16 + 16
			end
		elseif player.y >= 270 then
			transitioningScreen = true
			player.frozen = true
			player.frozenCounter = -1
			if fadeIn == false then
				player:findRandomMap()
				player.frozen = false
				player.frozenCounter = 0
				player.x = player.previousX
				player.y = 0 + 16 + 16
			end
		end
	end

	function player:resetWeapon()
		if player.weaponOut then
			table.insert(actors, player.currentWeapon)
		end
	end

	function player:jump()
		if pressInputs.jump then
			player.grounded = false
			player.y = player.y - 1
			player.jumpHoldCounter = 0
			player.yVelocity = - player.jumpAcceleration * (player.jumpsLeft + (1 - player.jumpsLeft/player.jumps))/player.jumps
			player.jumpsLeft = player.jumpsLeft - 1
			if player.jumpsLeft <= 0 then
				player.jumpAble = false
			end
			table.insert(actors, newDust(player.x, player.y, "jump", player.direction, player.tileBelow))
		end
	end

	function player:checkGrounded()
		player.transitioning = false
		player.oldGrounded = player.grounded
		if checkCollision(player:getX(), player:getY() + player.height, player.width, 1) then
			player.grounded = true
			player.yVelocity = 0
		else
			player.grounded = false
		end
	end

	function player:physics()
		local minXMovement = player.xVelocity
		if minXMovement < 0 then
			--collision to the left
			for _, actor in ipairs(getCollidingActors(player:getX() - 32, player:getY(), 32, player.height, true, false, true, true, false, false)) do -- 32 = 2*16 tile width
				local newXMovement = (actor.x + actor.hitboxX) + (actor.hitboxX + actor.hitboxWidth - player.x)
				if newXMovement > minXMovement then
					minXMovement = newXMovement
					player.xVelocity = 0
				end
			end
		else
		  --collision to the right
			for _, actor in ipairs(getCollidingActors(player:getX() + player.width, player:getY(), 32, player.height, true, false, true, true, false, false)) do
				local newXMovement = (actor.x + actor.hitboxX) - (player.x + player.width)
				if newXMovement < minXMovement then
					minXMovement = newXMovement
					player.xVelocity = 0
				end
			end
		end

		player.tileLeft = ""
		player.tileRight = ""
		player.tileBelow = ""
		player.tileAbove = ""

		for _, actor in ipairs(getCollidingActors(player:getX() - 16, player:getY(), 16, player.height, true, false, false, true, false, false)) do
			player.tileLeft = actor.name
		end
		for _, actor in ipairs(getCollidingActors(player:getX() + player.width, player:getY(), 16, player.height, true, false, false, true, false, false)) do
			player.tileRight = actor.name
		end
		for _, actor in ipairs(getCollidingActors(player:getX(), player:getY() + player.height, player.width, 16, true, false, false, true, false, false)) do
			player.tileBelow = actor.name
		end
		for _, actor in ipairs(getCollidingActors(player:getX(), player:getY() - 16, player.width, 16, true, false, false, true, false, false)) do
			player.tileAbove = actor.name
		end

		for _, actor in ipairs(objects) do
			actor.near = false
		end

		for _, actor in ipairs(items) do
			actor.near = false
		end

		if player.isDead() == false then
			for _, actor in ipairs(getCollidingActors(player:getX(), player:getY(), player.width, player.height, false, false, true, false, true, true, true)) do
				if actor.actor == "item" then
					actor.near = true
					if actor.type == "heart" then
						if player.hp < player.maxHp then
							actor.remove = true
							player.hp = player.hp + 1
						end
					elseif actor.type == "shop" then
						if pressInputs.interact and player.money > (10 + mapNumber*3) then
							if actor.name == "weaponShopItem" then
								local weaponName, _, iconSprite = unpack(getWeaponStats(actor.randomName))
								table.insert(actors, newUi("newWeapon", weaponName, iconSprite))
							elseif actor.name == "accessoryShopItem" then
								table.insert(player.accessories, actor.randomName)
							end
							player.money = player.money - actor.price
							actor.remove = true
						end
					end
				elseif actor.actor == "object" then
					actor.near = true
					if actor.type == "ladder" then
						if pressInputs.interact and player.onLadder == false and player.offLadderFirstFrame == false then
							interactSound:play()
							player.x = actor.x
							player.onLadder = true
						end
						player.offLadderFirstFrame = false
					elseif actor.type == "door" then
						if pressInputs.interact then
							if indoor then
								indoor = false
							else
								indoor = true
							end
							interactSound:play()
							player:newPlayer(actor.data)
							break
						end
					elseif actor.type == "chest" then
						if pressInputs.interact and actor.active then
							currentMap.chestOpened = true
							actor.active = false
							player.xVelocity = 0
							player.xAcceleration = 0
							if player.weaponOut then
								table.remove(actors, player.currentWeapon.index)
							end
							player.weaponOut = false
						end
					elseif actor.type == "teleporter" then
						if pressInputs.interact and actor.active then
							if bossLevel and enemyCounter == 0 then
								if levelName == "grassland" then
									levelName = "desert"
								elseif levelName == "desert" then
									levelName = ""
								end
								bossLevel = false
								mapNumber = 0
								spawnRate = 0
								player:newPlayer("maps/maps/"..levelName.."/1")
							else
								bossLevel = true
								blockTopLeft = false
								blockTopMiddle = false
								blockTopRight = false
								blockBottomLeft = false
								blockBottomMiddle = false
								blockBottomRight = false
								blockLeftTop = false
								blockLeftMiddle = false
								blockLeftBottom = false
								blockRightTop = false
								blockRightMiddle = false
								blockRightBottom = false
								player:newPlayer("maps/maps/"..levelName.."/boss")
							end
							
							for _, actor in ipairs(actors) do
								if actor.name == "teleporter" then
									player.x = actor:getX() + player.width/2
									player.y = actor:getY() - player.height/2
								end
							end
						end
					end
				end
			end
		end

		player.behindWall = false
		for _, actor in ipairs(getCollidingActors(player:getX(), player:getY(), player.width, player.height, false, false, false, true, false, false)) do
			if actor.name == "dirtBg" then
				player.behindWall = true
			end
		end

		if player.grounded then
			player.jumpsLeft = player.jumps
			player.jumpAble = true
		end

		player.x = player.x + minXMovement
	end

	function player:airPhysics()
		player.previousYVelocity = player.yVelocity
		if player.onLadder == false then
			player.yVelocity = player.yVelocity + player.fallAcceleration
		end

		local minYMovement = player.yVelocity
		if minYMovement > 0 then
			--collision below player
			for _, actor in ipairs(getCollidingActors(player:getX(), player:getY() + player.height, player.width, 32, true, true, false, true, false, false)) do
				local newYMovement = (actor.y + actor.hitboxY) - (player.y + player.height)
				if newYMovement < minYMovement then
					if downInputs.down and actor.platform then

					else
						minYMovement = newYMovement
					end
				end
			end
		else
			--collision above player
			for _, actor in ipairs(getCollidingActors(player:getX(), player:getY() - 32, player.width, 32, true, false, false, true, false, false)) do
				local newYMovement = (actor.y + actor.hitboxY) + actor.hitboxHeight - player.y
				if newYMovement > minYMovement then
					minYMovement = newYMovement
					player.yVelocity = 0
				end
			end
		end

		if player.yVelocity >= player.yTerminalVelocity then
			player.yVelocity = player.yTerminalVelocity
		end

		if player.jumpAbleCounter <= player.jumpAbleDuration and player.jumpAble then
			player.jumpAbleCounter = player.jumpAbleCounter + 1
		else
			if player.jumpsLeft == player.jumps then -- if the player still has all their jumps
				player.jumpsLeft = player.jumpsLeft - 1
			end
			player.jumpAbleCounter = 0
		end

		player.jumpHoldCounter = player.jumpHoldCounter + 1
		if downInputs.jump and player.jumpHoldCounter <= player.jumpHoldDuration * ((player.jumpsLeft+1) + (1 - (player.jumpsLeft+1)/player.jumps))/player.jumps then
			player.yVelocity = player.previousYVelocity
		end

		player.y = player.y + minYMovement
	end

	function player:xMovement()
		if downInputs.left then
			if player:isDead() == false then
				if player.xVelocity > - player.xTerminalVelocity then
					player.xVelocity = player.xVelocity - player.xAcceleration
				else
					player.xVelocity = - player.xTerminalVelocity
				end
				player.direction = "left"
			end
		elseif downInputs.right then
			if player:isDead() == false then
				if player.xVelocity < player.xTerminalVelocity then
					player.xVelocity = player.xVelocity + player.xAcceleration
				else
					player.xVelocity = player.xTerminalVelocity
				end
				player.direction = "right"
			end
		else
			if player.xVelocity > 0 then
				player.xVelocity = player.xVelocity - player.xDeceleration
				if player.xVelocity < player.xDeceleration then
					player.xVelocity = 0
				end
			elseif player.xVelocity < 0 then
				player.xVelocity = player.xVelocity + player.xDeceleration
				if player.xVelocity > - player.xDeceleration then
					player.xVelocity = 0
				end
			end
		end
	end

	function player:hitCollision()
		love.graphics.setCanvas()
		for _, actor in ipairs(npcs) do
			if (isInTable(actor.attackQuadSection/actor.attackWidth, actor.attackHitFrames) and actor.attacking) or actor.projectile then
				imageData = actor.canvas:newImageData()
				for x = 1, imageData:getWidth() do
					for y = 1, imageData:getHeight() do
						-- Pixel coordinates range from 0 to image width - 1 / height - 1.
						red, green, blue, alpha = imageData:getPixel(x-1, y-1)
						if alpha > 0 then
							for _, _ in ipairs(getCollidingActors(actor:getX() + x-1, actor:getY() + y-1, 1, 1, false, false, false, false, false, false, false, true)) do
								if player.invincible == false and (actor.damage > 0 or actor.knockbackStrength > 0) then
									player.hp = player.hp - actor.damage
									player.knockbackAngle = math.atan2((player.y + player.height/2) - (actor.y + actor.attackHeight/2), (player.x + player.width/2) - (actor.x + actor.attackWidth/2))
									player.knockbackDx = math.cos(player.knockbackAngle)
									player.knockbackDy = math.sin(player.knockbackAngle)
									if player:isDead() == false then
										if actor.damage > 0 then
											player.invincible = true
										end
										player.invincibilityCounter = player.invincibilityLength
										player.xVelocity = player.knockbackDx*actor.knockbackStrength
										if player.yVelocity < 0 then
											player.yVelocity = player.knockbackDy*actor.knockbackStrength
										else
											player.yVelocity = player.knockbackDy*actor.knockbackStrength/2
										end
										if shakeLength < actor.screenShakeLength then
											shakeLength = actor.screenShakeLength
										end
										maxShakeLength = shakeLength
										shakeAmount = shakeAmount + actor.screenShakeAmount
										maxShakeAmount = shakeAmount
										shakeType = "short"
										player.frozen = true
										player.frozenCounter = player.frozenCounter + actor.screenFreezeLength
										player.hit = true
										player.hitLength = player.hitLength + actor.screenFreezeLength
										actor.frozen = true
										actor.frozenCounter = actor.frozenCounter + actor.screenFreezeLength
										actor.hit = true
										actor.hitLength = actor.hitLength + actor.screenFreezeLength
									else
										player.xVelocity = player.knockbackDx*actor.knockbackStrength*1.5
										if player.yVelocity < 0 then
											player.yVelocity = player.knockbackDy*actor.knockbackStrength*1.5
										else
											player.yVelocity = player.knockbackDy*actor.knockbackStrength*1.5/2
										end
										player.xTerminalVelocity = player.xTerminalVelocity + actor.knockbackStrength / 10
										if shakeLength < actor.screenShakeLength*1.5 then
											shakeLength = actor.screenShakeLength*1.5
										end
										maxShakeLength = shakeLength
										shakeAmount = shakeAmount + actor.screenShakeAmount
										maxShakeAmount = shakeAmount
										shakeType = "short"
										player.frozen = true
										player.frozenCounter = player.frozenCounter + actor.screenFreezeLength*1.5
										player.hit = true
										player.hitLength = player.hitLength + actor.screenFreezeLength*1.5
										actor.frozen = true
										actor.frozenCounter = actor.frozenCounter + actor.screenFreezeLength*1.5
										actor.hitPlayer = true
										actor.hitPlayerLength = actor.hitPlayerLength + actor.screenFreezeLength*1.5
									end
								end
							end
						end
					end
				end
			end
		end
	end

	function player:animations()
		player.runDust = false
		if player.xVelocity == 0 then
			player.runQuadSection = 0
		end

		if player.onLadder then
			if player.yVelocity ~= 0 then
				if player.climbCounter >= 10 then
					player.climbQuadSection = player.climbQuadSection + 21
					player.climbCounter = 0
				end

				if player.climbQuadSection >= 84 then
					player.climbCounter = 0
					player.climbQuadSection = 0
				end
				player.climbCounter = player.climbCounter + 1
			end
		elseif player.grounded then
			if player.xVelocity == 0 then
				if player.idleCounter >= 15 then
					player.idleQuadSection = player.idleQuadSection + 21
					player.idleCounter = 0
				end
				if player.idleQuadSection >= 84 then
					player.idleQuadSection = 0
					player.idleCounter = 0
				end
				player.idleCounter = player.idleCounter + 1
			else
				if player.runCounter >= 6 then
					if player.runQuadSection == 0 or player.runQuadSection == 84 then
						player.runDust = true
					end
					player.runQuadSection = player.runQuadSection + 21
					player.runCounter = 0
				end
				if player.runQuadSection >= 168 then
					player.runQuadSection = 0
					player.runCounter = 0
				end
				player.runCounter = player.runCounter + 1
			end
			player.jumpQuadSection = 0
		else            
			if player.yVelocity < -3 then
				player.jumpQuadSection = 0
			elseif player.yVelocity < -2 then
				player.jumpQuadSection = 21
			elseif player.yVelocity > 3 then
				player.jumpQuadSection = 84
			elseif player.yVelocity > 2 then
				player.jumpQuadSection = 63
			else
				player.jumpQuadSection = 42
			end
		end

		if player:isDead() then
			player.width = 24
			player.height = 11-3
			if player.direction == "left" then
				player.canvas = love.graphics.newCanvas(player.deadLeftSpritesheet:getWidth(), player.deadLeftSpritesheet:getHeight())
			else
			   player.canvas = love.graphics.newCanvas(player.deadRightSpritesheet:getWidth(), player.deadRightSpritesheet:getHeight())
			end 
		end
	end

	function player:dust()
		if player.xVelocity ~= 0 and player.grounded and player.runDust then
			table.insert(actors, newDust(player.x + player.xVelocity, player.y + player.yVelocity, "run", player.direction, player.tileBelow))
		end
		if player.oldGrounded ~= player.grounded then
			if player.jumpAble == false or player.oldGrounded == false then
				table.insert(actors, newDust(player.x, player.y, "land", player.direction, player.tileBelow))
			end
			player.transitioning = true
		end
		player.oldGrounded = player.grounded
	end

	function player:draw()
		love.graphics.setCanvas(player.canvas)
		love.graphics.clear()
	
		love.graphics.setBackgroundColor(0, 0, 0, 0)
		if player.onLadder then
			player.spritesheet = player.climbSpritesheet
			player.quad = love.graphics.newQuad(player.climbQuadSection, 0, 21, 26, 84, 26)
		elseif player.weaponOut then
			if player.currentWeapon.direction == "left" then
				player.spritesheet = player.attackLeftSpritesheet
			else
				player.spritesheet = player.attackRightSpritesheet
			end

			if player.currentWeapon.state == "startup" then
				player.quad = love.graphics.newQuad(0, 0, 21, 26, 63, 26)
			elseif player.currentWeapon.state == "slash" then
				player.quad = love.graphics.newQuad(21, 0, 21, 26, 63, 26)
			else
				player.quad = love.graphics.newQuad(42, 0, 21, 26, 63, 26)
			end
		elseif player.direction == "left" then
			if player.grounded then
				if player.xVelocity == 0 then
					player.spritesheet = player.idleLeftSpritesheet
					player.quad = love.graphics.newQuad(player.idleQuadSection, 0, 21, 26, 84, 26)
				else
					player.spritesheet = player.runLeftSpritesheet
					player.quad = love.graphics.newQuad(player.runQuadSection, 0, 21, 26, 168, 26)
				end
			else
				player.spritesheet = player.jumpLeftSpritesheet
				player.quad = love.graphics.newQuad(player.jumpQuadSection, 0, 21, 26, 105, 26)
			end
			if player:isDead() then
				player.spritesheet = player.deadLeftSpritesheet
				player.quad = love.graphics.newQuad(0, 0, 24, 11, 24, 11)
			end
		else
			if player.grounded then
				if player.xVelocity == 0 then
					player.spritesheet = player.idleRightSpritesheet
					player.quad = love.graphics.newQuad(player.idleQuadSection, 0, 21, 26, 84, 26)
				else
					player.spritesheet = player.runRightSpritesheet
					player.quad = love.graphics.newQuad(player.runQuadSection, 0, 21, 26, 168, 26)
				end
			else
				player.spritesheet = player.jumpRightSpritesheet
				player.quad = love.graphics.newQuad(player.jumpQuadSection, 0, 21, 26, 105, 26)
			end
			if player:isDead() then
				player.spritesheet = player.deadRightSpritesheet
				player.quad = love.graphics.newQuad(0, 0, 24, 11, 24, 11)
			end
		end


		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(player.spritesheet, player.quad)

		if player.hit then
			player.hitLength = player.hitLength - 1
		end
		if player.hitLength <= 0 then
			player.hit = false
		end
		if player.hit then
			player.image = convertColor(player.canvas, 0, 0, 0, 1)
			love.graphics.clear()
			love.graphics.draw(player.image)
		elseif player.invincible then
			if player.invincibilityCounter % 2 == 0 then
				player.image = convertOpacity(player.canvas, 0.9)
			else
				player.image = convertColor(player.canvas, 1, 1, 1, 0.3)
			end
			love.graphics.clear()
			love.graphics.draw(player.image)
		end
	end

	return player
end