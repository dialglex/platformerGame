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
	player.baseXTerminalVelocity = 2
	player.baseJumpAcceleration = 3.9
	player.baseFallAcceleration = 0.25
	player.baseYTerminalVelocity = 8

	player.jumps = 1
	player.jumpsLeft = player.jumps
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
	player.downPlatform = false

	player.frozen = false
	player.hit = false
	player.invincible = false
	player.invincibilityLength = 60
	player.invincibilityCounter = 0
	player.hp = 100
	player.maxHp = player.hp
	player.baseMaxHp = player.hp
	player.previousHp = player.hp
	player.knockbackRestistance = 1
	player.weaponOut = false
	player.equippedWeapon1 = "woodenSword"
	player.equippedWeapon2 = "woodenBow"
	player.accessories = {}
	player.money = 1000

	player.idleCounter = 0
	player.idleQuads = {}
	player.idleFrames = 4
	player.idleFrame = 1

	player.runCounter = 0
	player.runQuads = {}
	player.runFrames = 8
	player.runFrame = 1

	player.jumpCounter = 0
	player.jumpQuads = {}
	player.jumpFrames = 5
	player.jumpFrame = 1

	player.landing = false
	player.landCounter = 0
	player.landQuads = {}
	player.runLandQuads = {}
	player.landFrames = 3
	player.landFrame = 1

	player.climbCounter = 0
	player.climbQuads = {}
	player.climbFrames = 4
	player.climbFrame = 1

	player.attackQuads = {}
	player.attackFrames = 3
	player.attackFrame = 1

	player.bowQuads = {}
	player.bowFrames = 2
	player.bowFrame = 1

	player.deadQuad = love.graphics.newQuad(0, 0, 24, 11, 24, 11)

	player.idleLeftSpritesheet = love.graphics.newImage("images/player/playerIdleLeftSpritesheet.png")
	player.idleRightSpritesheet = love.graphics.newImage("images/player/playerIdleRightSpritesheet.png")
	local spritesheetWidth = player.idleRightSpritesheet:getWidth()
	local spritesheetHeight = player.idleRightSpritesheet:getHeight()
	local width = spritesheetWidth/player.idleFrames
	local height = spritesheetHeight
	for i = 1, player.idleFrames do
		table.insert(player.idleQuads, love.graphics.newQuad(width*(i - 1), 0, width, height, spritesheetWidth, spritesheetHeight))
	end

	player.runLeftSpritesheet = love.graphics.newImage("images/player/playerRunLeftSpritesheet.png")
	player.runRightSpritesheet = love.graphics.newImage("images/player/playerRunRightSpritesheet.png")
	local spritesheetWidth = player.runRightSpritesheet:getWidth()
	local spritesheetHeight = player.runRightSpritesheet:getHeight()
	local width = spritesheetWidth/player.runFrames
	local height = spritesheetHeight
	for i = 1, player.runFrames do
		table.insert(player.runQuads, love.graphics.newQuad(width*(i - 1), 0, width, height, spritesheetWidth, spritesheetHeight))
	end

	player.jumpLeftSpritesheet = love.graphics.newImage("images/player/playerJumpLeftSpritesheet.png")
	player.jumpRightSpritesheet = love.graphics.newImage("images/player/playerJumpRightSpritesheet.png")
	local spritesheetWidth = player.jumpRightSpritesheet:getWidth()
	local spritesheetHeight = player.jumpRightSpritesheet:getHeight()
	local width = spritesheetWidth/player.jumpFrames
	local height = spritesheetHeight
	for i = 1, player.jumpFrames do
		table.insert(player.jumpQuads, love.graphics.newQuad(width*(i - 1), 0, width, height, spritesheetWidth, spritesheetHeight))
	end

	player.landLeftSpritesheet = love.graphics.newImage("images/player/playerLandLeftSpritesheet.png")
	player.landRightSpritesheet = love.graphics.newImage("images/player/playerLandRightSpritesheet.png")
	local spritesheetWidth = player.landRightSpritesheet:getWidth()
	local spritesheetHeight = player.landRightSpritesheet:getHeight()
	local width = spritesheetWidth/player.landFrames
	local height = spritesheetHeight
	for i = 1, player.landFrames do
		table.insert(player.landQuads, love.graphics.newQuad(width*(i - 1), 0, width, height, spritesheetWidth, spritesheetHeight))
	end
	player.runLandLeftSpritesheet = love.graphics.newImage("images/player/playerRunLandLeftSpritesheet.png")
	player.runLandRightSpritesheet = love.graphics.newImage("images/player/playerRunLandRightSpritesheet.png")
	local spritesheetWidth = player.runLandRightSpritesheet:getWidth()
	local spritesheetHeight = player.runLandRightSpritesheet:getHeight()
	local width = spritesheetWidth/player.landFrames
	local height = spritesheetHeight
	for i = 1, player.landFrames do
		table.insert(player.runLandQuads, love.graphics.newQuad(width*(i - 1), 0, width, height, spritesheetWidth, spritesheetHeight))
	end

	player.climbSpritesheet = love.graphics.newImage("images/player/playerClimbSpritesheet.png")
	local spritesheetWidth = player.climbSpritesheet:getWidth()
	local spritesheetHeight = player.climbSpritesheet:getHeight()
	local width = spritesheetWidth/player.climbFrames
	local height = spritesheetHeight
	for i = 1, player.climbFrames do
		table.insert(player.climbQuads, love.graphics.newQuad(width*(i - 1), 0, width, height, spritesheetWidth, spritesheetHeight))
	end

	player.attackLeftSpritesheet = love.graphics.newImage("images/player/playerAttackLeftSpritesheet.png")
	player.attackRightSpritesheet = love.graphics.newImage("images/player/playerAttackRightSpritesheet.png")
	player.attackLeftArmSpritesheet = love.graphics.newImage("images/player/playerAttackLeftArmSpritesheet.png")
	player.attackRightArmSpritesheet = love.graphics.newImage("images/player/playerAttackRightArmSpritesheet.png")
	local spritesheetWidth = player.attackRightSpritesheet:getWidth()
	local spritesheetHeight = player.attackRightSpritesheet:getHeight()
	local width = spritesheetWidth/player.attackFrames
	local height = spritesheetHeight
	for i = 1, player.attackFrames do
		table.insert(player.attackQuads, love.graphics.newQuad(width*(i - 1), 0, width, height, spritesheetWidth, spritesheetHeight))
	end

	player.bowLeftSpritesheet = love.graphics.newImage("images/player/playerBowLeftSpritesheet.png")
	player.bowRightSpritesheet = love.graphics.newImage("images/player/playerBowRightSpritesheet.png")
	player.bowLeftArmSpritesheet = love.graphics.newImage("images/player/playerBowLeftArmSpritesheet.png")
	player.bowRightArmSpritesheet = love.graphics.newImage("images/player/playerBowRightArmSpritesheet.png")

	player.bowUpLeftSpritesheet = love.graphics.newImage("images/player/playerBowUpLeftSpritesheet.png")
	player.bowUpRightSpritesheet = love.graphics.newImage("images/player/playerBowUpRightSpritesheet.png")
	player.bowUpLeftArmSpritesheet = love.graphics.newImage("images/player/playerBowUpLeftArmSpritesheet.png")
	player.bowUpRightArmSpritesheet = love.graphics.newImage("images/player/playerBowUpRightArmSpritesheet.png")

	player.bowDownLeftSpritesheet = love.graphics.newImage("images/player/playerBowDownLeftSpritesheet.png")
	player.bowDownRightSpritesheet = love.graphics.newImage("images/player/playerBowDownRightSpritesheet.png")
	player.bowDownLeftArmSpritesheet = love.graphics.newImage("images/player/playerBowDownLeftArmSpritesheet.png")
	player.bowDownRightArmSpritesheet = love.graphics.newImage("images/player/playerBowDownRightArmSpritesheet.png")

	local spritesheetWidth = player.bowRightSpritesheet:getWidth()
	local spritesheetHeight = player.bowRightSpritesheet:getHeight()
	local width = spritesheetWidth/player.bowFrames
	local height = spritesheetHeight
	for i = 1, player.bowFrames do
		table.insert(player.bowQuads, love.graphics.newQuad(width*(i - 1), 0, width, height, spritesheetWidth, spritesheetHeight))
	end

	player.deadLeftSpritesheet = love.graphics.newImage("images/player/playerDeadLeftSpritesheet.png")
	player.deadRightSpritesheet = love.graphics.newImage("images/player/playerDeadRightSpritesheet.png")

	player.canvas = love.graphics.newCanvas(21, 26)

	function player:getX()
		return math.floor(player.x + 0.5)
	end

	function player:getY()
		return math.floor(player.y + 0.5)
	end

	function player:act(index)
		player:mapTransition()
		player:checkGrounded()
		player:checkBoss()
		if player.frozen == false and chestOpening == false then
			player.previousX = player.x
			player.previousY = player.y
			player:statChanges()
			player:combatLogic()
			player:ladder()
			player:openUi()
			if player.onLadder == false then
				player:physics()
				player:xMovement()
				if player.grounded == false then
					player:airPhysics()
				end
			else
				player:airPhysics()
			end
			if player:isDead() == false then
				if player.jumpAble and player.jumpsLeft > 0 then
					player:jump()
				end
				if player.invincible == false then
					player:hitCollision()
				end
			end
			player:animations()
			player:dust()
		elseif player.frozen then
			if fadeIn == false and player.mapToEnter ~= nil then
				player:newMap(player.mapToEnter)
				for _, actor in ipairs(actors) do
					if actor.type == "door" then
						player.yVelocity = 0
						if mapNumber == 2 or mapNumber == 4 then -- cave
							player.y = actor.y + 17
						elseif mapNumber == 3 then -- shop
							player.y = actor.y + 2
						end
					end
				end
				player.mapToEnter = nil
				player.frozen = false
			end
		end

		debugPrint("player.x: " .. player.x)
		debugPrint("player.y: " .. player.y)
		debugPrint("player.xVelocity: " .. player.xVelocity)
		debugPrint("player.yVelocity: " .. player.yVelocity)
		debugPrint("player.jumps: " .. player.jumps)
		debugPrint("player.jumpsLeft: " .. player.jumpsLeft)
		debugPrint("player.jumpAble: " .. tostring(player.jumpAble))
		
		debugPrint("spawnRate: "..spawnRate)
		debugPrint("mapNumber: "..mapNumber)
	end

	function player:statChanges()
		player.damageBuff = 1
		player.knockbackBuff = 1
		player.xTerminalVelocityBuff = 1
		player.xAccelerationBuff = 1
		player.xDecelerationBuff = 1
		player.yTerminalVelocityBuff = 1
		player.jumpAccelerationBuff = 1
		player.fallAccelerationBuff = 1
		player.maxHpBuff = 1
		player.poisonDurationBuff = 1
		player.burnDurationBuff = 1
		player.jumps = 1

		for i, accessory in ipairs(player.accessories) do
			local stats = getAccessoryStats(accessory)
			player.damageBuff = player.damageBuff*stats.damage
			player.knockbackBuff = player.knockbackBuff*stats.knockback
			player.xTerminalVelocityBuff = player.xTerminalVelocityBuff*stats.xTerminalVelocity
			player.xAccelerationBuff = player.xAccelerationBuff*stats.xAcceleration
			player.xDecelerationBuff = player.xDecelerationBuff*stats.xDeceleration
			player.yTerminalVelocityBuff = player.yTerminalVelocityBuff*stats.yTerminalVelocity
			player.jumpAccelerationBuff = player.jumpAccelerationBuff*stats.jumpAcceleration
			player.fallAccelerationBuff = player.fallAccelerationBuff*stats.fallAcceleration
			player.maxHpBuff = player.maxHpBuff*stats.maxHp
			player.poisonDurationBuff = player.poisonDurationBuff*stats.poisonDuration
			player.burnDurationBuff = player.burnDurationBuff*stats.burnDuration
			player.jumps = player.jumps + stats.jumps
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
		player.maxHp = player.baseMaxHp*player.maxHpBuff
	end

	function player:openUi()
		if pressInputs.inventory and player:isDead() == false then
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

		if (pressInputs.attack1 or pressInputs.attack2) and player.weaponOut == false and player:isDead() == false and player.onLadder == false then
			if pressInputs.attack1 then
				player.attackWeapon = player.equippedWeapon1
			else
				player.attackWeapon = player.equippedWeapon2
			end

			local stats = getWeaponStats(player.attackWeapon)
			stats.direction = player.direction

			table.insert(actors, newWeapon(actors[getTableLength(actors)+1], 0, 0, nil, stats))
			player.currentWeapon = actors[getTableLength(actors)]
			player.lastUsedWeapon = player.currentWeapon
			player.weaponOut = true
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
				player.jumpsLeft = player.jumps
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

	function player:newMap(map, door)
		currentMap = allMaps[map]
		actors = currentMap.actors

		if mapNumber == 0 then -- starting map
			spawnRate = 0
		elseif mapNumber == 1 then
			spawnRate = 25
		elseif mapNumber == 2 then -- cave
			spawnRate = 30 -- 55 in cave
		elseif mapNumber == 3 then -- shop
			spawnRate = 40
		elseif mapNumber == 4 then -- cave
			spawnRate = 45 -- 70 in cave
		elseif mapNumber == 5 then
			spawnRate = 55
		elseif mapNumber == 6 then
			spawnRate = 60
		end

		if indoor then
			spawnRate = spawnRate + 25
		end

		if isInTable(player, actors) == false then
			table.insert(actors, player)
		end

		if currentMap.explored == false then
			for i, npcSpawn in ipairs(currentMap.npcSpawns) do
				local randomNumber = math.random(0, 100)
				local npcSpawnClone = deepTableClone(npcSpawn)
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

		if door ~= false then
			backgroundCanvas, foregroundCanvas = unpack(setupCanvases(actors))
		end
	end

	function isSuitableMap(randomMap)
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
		if newTopLeft and bottomLeft and player.y >= 286 and player.x >= 6*16 - 16 and player.x + player.width <= 9*16 + 16 then
			blockTopLeft = true
			blockBottomLeft = true
			suitableMap = true
		elseif newTopMiddle and bottomMiddle and player.y >= 286 and player.x >= 14*16 - 16 and player.x + player.width <= 18*16 + 16 then -- do this
			blockTopMiddle = true
			blockBottomMiddle = true
			suitableMap = true
		elseif newTopRight and bottomRight and player.y >= 286 and player.x >= 23*16 - 16 and player.x + player.width <= 26*16 + 16 then
			blockTopRight = true
			blockBottomRight = true
			suitableMap = true
		elseif newBottomLeft and topLeft and player.y + player.height <= 16 and player.x >= 6*16 - 16 and player.x + player.width <= 9*16 + 16 then
			blockBottomLeft = true
			blockTopLeft = true
			suitableMap = true
		elseif newBottomMiddle and topMiddle and player.y + player.height <= 16 and player.x >= 14*16 - 16 and player.x + player.width <= 18*16 + 16 then
			blockBottomMiddle = true
			blockTopMiddle = true
			suitableMap = true
		elseif newBottomRight and topRight and player.y + player.height <= 16 and player.x >= 23*16 - 16 and player.x + player.width <= 26*16 + 16 then
			blockBottomRight = true
			blockTopRight = true
			suitableMap = true
		elseif newLeftTop and rightTop and player.x >= 496 and player.y >= 3*16 - 16 and player.y + player.height <= 6*16 + 16 then
			blockLeftTop = true
			blockRightTop = true
			suitableMap = true
		elseif newLeftMiddle and rightMiddle and player.x >= 496 and player.y >= 8*16 - 16 and player.y + player.height <= 11*16 + 16 then
			blockLeftMiddle = true
			blockRightMiddle = true
			suitableMap = true
		elseif newLeftBottom and rightBottom and player.x >= 496 and player.y >= 13*16 - 16 and player.y + player.height <= 16*16 + 16 then
			blockLeftBottom = true
			blockRightBottom = true
			suitableMap = true
		elseif newRightTop and leftTop and player.x + player.width <= 16 and player.y >= 3*16 - 16 and player.y + player.height <= 6*16 + 16 then
			blockRightTop = true
			blockLeftTop = true
			suitableMap = true
		elseif newRightMiddle and leftMiddle and player.x + player.width <= 16 and player.y >= 8*16 - 16 and player.y + player.height <= 11*16 + 16 then
			blockRightMiddle = true
			blockLeftMiddle = true
			suitableMap = true
		elseif newRightBottom and leftBottom and player.x + player.width <= 16 and player.y >= 13*16 - 16 and player.y + player.height <= 16*16 + 16 then
			blockRightBottom = true
			blockLeftBottom = true
			suitableMap = true
		end

		return suitableMap
	end

	function player:findRandomMap()
		for i, item in ipairs(items) do
			if item.type == "coin" then
				player.money = player.money + 1
			end
		end
		table.insert(mapsUsed, (string.gsub(currentMapDirectory, ".lua", "", 1)))
		mapNumber = mapNumber + 1
		local mapsToCheck = {}

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
		local randomMap = mapsToCheck[randomNumber]

		local suitableMap = false
		suitableMap = isSuitableMap(randomMap)

		local i = 0
		-- print(i .. "  mapNumber: " .. tostring(mapNumber) .. "  randomMap: " .. randomMap)
		while suitableMap == false do
			local randomNumber = math.random(1, getTableLength(mapsToCheck))
			randomMap = mapsToCheck[randomNumber]

			if isSuitableMap(randomMap) then
				suitableMap = true
			end
			-- print(i .. "  mapNumber: " .. tostring(mapNumber) .. "  randomMap: " .. randomMap)
			i = i + 1
		end

		player:newMap(randomMap, false)

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
		if player.x + player.width <= 16 then
			transitioningScreen = true
			if fadeIn == false then
				player:findRandomMap()
				player.x = 496 - player.width - 16
				player.y = player.previousY
			end
		elseif player.x >= 496 then
			transitioningScreen = true
			if fadeIn == false then
				player:findRandomMap()
				player.x = 16 + 16
				player.y = player.previousY
			end
		end

		if player.y + player.height <= 16 then
			transitioningScreen = true
			if fadeIn == false then
				player:findRandomMap()
				player.x = player.previousX
				player.y = 286 - player.height - 16
			end
		elseif player.y >= 286 then
			transitioningScreen = true
			if fadeIn == false then
				player:findRandomMap()
				player.x = player.previousX
				player.y = 16 + 16
			end
		end

		if transitioningScreen then
			player.frozen = true
			if fadeIn == false and transitionCounter <= 1 - 0.075 then
				player.frozen = false
			end
		else
			player.frozen = false
		end
	end

	function player:resetWeapon()
		if player.weaponOut then
			table.insert(actors, player.currentWeapon)
		end
	end

	function player:jump()
		if pressInputs.jump and player.downPlatform == false then
			player.grounded = false
			player.y = player.y - 1
			player.jumpHoldCounter = 0
			player.yVelocity = - player.jumpAcceleration * (player.jumpsLeft + (1 - player.jumpsLeft/player.jumps))/player.jumps
			player.jumpsLeft = player.jumpsLeft - 1

			if player.jumpsLeft <= 0 then
				player.jumpAble = false
			end
			table.insert(actors, newDust(player.x + player.width/2, player.y + player.height, "jump", player.direction, player.tileBelow))
		end
	end

	function player:checkGrounded()
		player.transitioning = false
		player.oldGrounded = player.grounded
		if checkCollision(player:getX(), player:getY() + player.height, player.width, 1, true, true) then
			if player.grounded == false then
				if player.yVelocity > 2 then
					player.landFrame = 1
				elseif player.yVelocity > 1 then
					player.landFrame = 2
				else
					player.landFrame = 3
				end
				player.landing = true
			end
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
		elseif minXMovement > 0 then
		  --collision to the right
			for _, actor in ipairs(getCollidingActors(player:getX() + player.width, player:getY(), 32, player.height, true, false, true, true, false, false)) do
				local newXMovement = (actor.x + actor.hitboxX) - (player.x + player.width)
				if newXMovement < minXMovement then
					minXMovement = newXMovement
					player.xVelocity = 0
				end
			end
		end

		player.tileBelow = ""
		for _, actor in ipairs(getCollidingActors(player:getX(), player:getY() + player.height, player.width, 16, true, false, false, true, false, false)) do
			player.tileBelow = actor.name
		end

		for _, actor in ipairs(objects) do
			actor.near = false
		end

		for _, actor in ipairs(shopItems) do
			actor.near = false
		end

		if player.isDead() == false then
			for _, actor in ipairs(getCollidingActors(player:getX(), player:getY(), player.width, player.height, false, false, false, false, false, true, true, false, false, false)) do
				if actor.actor == "item" then
					if actor.type == "shop" then
						actor.near = true
						if pressInputs.interact and player.money >= actor.price then
							if actor.name == "weaponShopItem" then
								local weapon = getWeaponStats(actor.randomName)
								table.insert(actors, newUi("newWeapon", weapon.name, weapon.iconSprite))
							elseif actor.name == "accessoryShopItem" then
								table.insert(player.accessories, actor.randomName)
							end
							player.money = player.money - actor.price
							actor.remove = true
						end
					elseif actor.type == "coin" then
						player.money = player.money + 1
						actor.remove = true
					end
				elseif actor.actor == "object" then
					actor.near = true
					if actor.type == "ladder" then
						if pressInputs.interact and player.onLadder == false and player.offLadderFirstFrame == false then
							interactSound:play()
							player.x = actor.x
							player.xVelocity = 0
							player.jumpLeft = player.jumps
							player.onLadder = true
						end
						player.offLadderFirstFrame = false
					elseif actor.type == "door" then
						if pressInputs.interact and transitioningScreen == false then
							transitioningScreen = true
							player.frozen = true
							player.mapToEnter = actor.data
							
							indoor = not indoor
							interactSound:play()
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
								player:newMap("maps/maps/"..levelName.."/1")
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
								player:newMap("maps/maps/"..levelName.."/boss")
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

		if player.grounded then
			player.jumpsLeft = player.jumps
			player.jumpAble = true
		end

		if player.onLadder == false then
			player.x = player.x + minXMovement
		end
	end

	function player:airPhysics()
		local platformBlocked = false
		player.downPlatform = false
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
					if downInputs.down and downInputs.jump and actor.platform then
						player.downPlatform = true
					else
						if actor.platform == false then
							platformBlocked = true
						end
						minYMovement = newYMovement
					end
				end
			end
		elseif minYMovement < 0 then
			--collision above player
			for _, actor in ipairs(getCollidingActors(player:getX(), player:getY() - 32, player.width, 32, true, false, false, true, false, false)) do
				local newYMovement = (actor.y + actor.hitboxY) + actor.hitboxHeight - player.y
				if newYMovement > minYMovement then
					minYMovement = newYMovement
					player.yVelocity = 0
				end
			end
		end

		if platformBlocked then
			player.downPlatform = false
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
		for _, actor in ipairs(npcs) do
			if (((actor.attacking and actor.ai ~= "diving") or actor.diving) and isInTable(actor.attackAnimationFrame, actor.attackHitFrames)) or actor.projectile or actor.name == "fuzzy" then -- if able to hit
				if player.invincible == false and player:isDead() == false and (actor.damage > 0 or actor.knockbackStrength > 0) then
					if AABB(player.x, player.y, player.width, player.height, actor.x, actor.y, actor.attackWidth, actor.attackHeight) then -- if npc is in range of player
						imageData = actor.canvas:newImageData()
						local npcAlreadyHit = false
						for x = 1, imageData:getWidth() do
							if npcAlreadyHit then
								break
							end
							for y = 1, imageData:getHeight() do
								if npcAlreadyHit then
									break
								end
								red, green, blue, alpha = imageData:getPixel(x-1, y-1)
								if red == 248/255 and green == 248/255 and blue == 248/255 or (actor.projectile) then
									for _, _ in ipairs(getCollidingActors(actor:getX() + x-1, actor:getY() + y-1, 1, 1, false, false, false, false, false, false, false, true)) do -- checks player
										if player.invincible == false and player:isDead() == false and (actor.damage > 0 or actor.knockbackStrength > 0) then
											npcAlreadyHit = true
											player.previousHp = player.hp
											player.hp = player.hp - actor.damage
											player.knockbackAngle = math.atan2((player.y + player.height/2) - (actor.y + actor.attackHeight/2), (player.x + player.width/2) - (actor.x + actor.attackWidth/2))
											player.knockbackDx = math.cos(player.knockbackAngle)
											player.knockbackDy = math.sin(player.knockbackAngle)
											player.hit = true
											actor.hitPlayer = true
											if shakeLength < actor.screenShakeLength then
												shakeLength = actor.screenShakeLength
											end
											maxShakeLength = shakeLength
											if shakeAmount < actor.screenShakeAmount then
												shakeAmount = actor.screenShakeAmount
											end
											maxShakeAmount = shakeAmount
											if screenFreeze < actor.screenFreezeLength then
												screenFreeze = actor.screenFreezeLength
											end

											if actor.projectile == false then
												if isInTable("ballOfThorns", player.accessories) then
													actor.hit = true
													actor.previousHp = actor.hp
													actor.lastDamagedTimer = 0
													actor.lastHitTimer = 0
													actor.hp = actor.hp - 30
													if actor.hp < 0 then
														actor.hp = 0
													end
												end
											end

											if actor.name == "fuzzy" then
												actor.attacking = true
												actor.attackDirection = actor.direction
											end
											if player:isDead() == false then
												if actor.damage > 0 and actor.ai ~= "cloud" then
													player.invincible = true
													player.invincibilityCounter = player.invincibilityLength
												end
												if actor.knockbackStrength > 0 then
													player.xVelocity = player.knockbackDx*actor.knockbackStrength
													if player.yVelocity < 0 then
														player.yVelocity = player.knockbackDy*actor.knockbackStrength
													else
														player.yVelocity = player.knockbackDy*actor.knockbackStrength
													end
												end
												purple = targetPurple + 1
											else
												player.hp = 0
												if actor.knockbackStrength > 0 then
													player.xVelocity = player.knockbackDx*actor.knockbackStrength*2
													if player.yVelocity < 0 then
														player.yVelocity = player.knockbackDy*actor.knockbackStrength*2
													else
														player.yVelocity = player.knockbackDy*actor.knockbackStrength*2
													end
												end
												purple = targetPurple + 2
											end
										end
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
			player.runFrame = 1
		end

		if player.onLadder then
			if player.yVelocity ~= 0 then
				if player.climbCounter >= 10 then
					player.climbFrame = player.climbFrame + 1
					player.climbCounter = 0
				end

				if player.climbFrame == player.climbFrames + 1 then
					player.climbCounter = 0
					player.climbFrame = 1
				end
				player.climbCounter = player.climbCounter + 1
			end
		elseif player.grounded then
			if player.landing then
				if (player.landCounter >= 4 and player.xVelocity == 0) or (player.landCounter >= 6 and player.xVelocity ~= 0) then
					player.landFrame = player.landFrame + 1
					player.landCounter = 0
				end
				if player.landFrame == player.landFrames + 1 then
					player.landFrame = 1
					player.landCounter = 0
					player.landing = false

					player.idleFrame = 1
					player.idleCounter = 0
					player.runFrame = 3
					player.runCounter = 0
				end
				player.landCounter = player.landCounter + 1
			end

			if player.xVelocity == 0 then
				player.runFrame = 1
				player.runCounter = 0

				if player.idleCounter >= 15 then
					player.idleFrame = player.idleFrame + 1
					player.idleCounter = 0
				end
				if player.idleFrame == player.idleFrames + 1 then
					player.idleFrame = 1
					player.idleCounter = 0
				end
				player.idleCounter = player.idleCounter + 1
			else
				player.idleFrame = 1
				player.idleCounter = 0
				
				if player.runCounter >= 6 then
					if player.runFrame == 1 or player.runFrame == 5 then
						player.runDust = true
					end
					player.runFrame = player.runFrame + 1
					player.runCounter = 0
				end
				if player.runFrame == player.runFrames + 1 then
					player.runFrame = 1
					player.runCounter = 0
				end
				player.runCounter = player.runCounter + 1
			end
			player.jumpFrame = 1
		else
			player.idleFrame = 1
			player.idleCounter = 0
			player.runFrame = 1
			player.runCounter = 0
			player.landFrame = 1
			player.landCounter = 0
			player.landing = false
					
			if player.yVelocity < -3 then
				player.jumpFrame = 1
			elseif player.yVelocity < -2 then
				player.jumpFrame = 2
			elseif player.yVelocity > 2 then
				player.jumpFrame = 4
			elseif player.yVelocity > 3 then
				player.jumpFrame = 5
			else
				player.jumpFrame = 3
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
			table.insert(actors, newDust(player.x + player.width/2 + player.xVelocity, player.y + player.height + player.yVelocity, "run", player.direction, player.tileBelow))
		end
		if player.oldGrounded ~= player.grounded then
			if player.oldGrounded == false then
				table.insert(actors, newDust(player.x + player.width/2, player.y + player.height, "land", player.direction, player.tileBelow))
			end
			player.transitioning = true
		end
		player.oldGrounded = player.grounded
	end

	function player:draw()
		love.graphics.setCanvas(player.canvas)
		love.graphics.clear()
	
		if player.onLadder then
			player.spritesheet = player.climbSpritesheet
			player.quad = player.climbQuads[player.climbFrame]
		elseif player.weaponOut then
			if player.currentWeapon.type == "sword" then
				if player.currentWeapon.direction == "left" then
					player.spritesheet = player.attackLeftSpritesheet
				else
					player.spritesheet = player.attackRightSpritesheet
				end

				if player.currentWeapon.state == "startup" then
					player.quad = player.attackQuads[1]
				elseif player.currentWeapon.state == "slash" then
					player.quad = player.attackQuads[2]
				else
					player.quad = player.attackQuads[3]
				end
			elseif player.currentWeapon.type == "bow" then
				if player.currentWeapon.direction == "left" then
					if player.currentWeapon.shootDirection == "up" then
						player.spritesheet = player.bowUpLeftSpritesheet
					elseif player.currentWeapon.shootDirection == "down" then
						player.spritesheet = player.bowDownLeftSpritesheet
					else
						player.spritesheet = player.bowLeftSpritesheet
					end
				else
					if player.currentWeapon.shootDirection == "up" then
						player.spritesheet = player.bowUpRightSpritesheet
					elseif player.currentWeapon.shootDirection == "down" then
						player.spritesheet = player.bowDownRightSpritesheet
					else
						player.spritesheet = player.bowRightSpritesheet
					end
				end

				if player.currentWeapon.state == "end" then
					player.quad = player.bowQuads[2]
				else
					player.quad = player.bowQuads[1]
				end
			end
		elseif player.direction == "left" then
			if player.grounded then
				if player.xVelocity == 0 then
					if player.landing then
						player.spritesheet = player.landLeftSpritesheet
						player.quad = player.landQuads[player.landFrame]
					else
						player.spritesheet = player.idleLeftSpritesheet
						player.quad = player.idleQuads[player.idleFrame]
					end
				else
					if player.landing then
						player.spritesheet = player.runLandLeftSpritesheet
						player.quad = player.runLandQuads[player.landFrame]
					else
						player.spritesheet = player.runLeftSpritesheet
						player.quad = player.runQuads[player.runFrame]
					end
				end
			else
				player.spritesheet = player.jumpLeftSpritesheet
				player.quad = player.jumpQuads[player.jumpFrame]
			end
			if player:isDead() then
				player.spritesheet = player.deadLeftSpritesheet
				player.quad = player.deadQuad
			end
		else
			if player.grounded then
				if player.xVelocity == 0 then
					if player.landing then
						player.spritesheet = player.landRightSpritesheet
						player.quad = player.landQuads[player.landFrame]
					else
						player.spritesheet = player.idleRightSpritesheet
						player.quad = player.idleQuads[player.idleFrame]
					end
				else
					if player.landing then
						player.spritesheet = player.runLandRightSpritesheet
						player.quad = player.runLandQuads[player.landFrame]
					else
						player.spritesheet = player.runRightSpritesheet
						player.quad = player.runQuads[player.runFrame]
					end
				end
			else
				player.spritesheet = player.jumpRightSpritesheet
				player.quad = player.jumpQuads[player.jumpFrame]
			end
			if player:isDead() then
				player.spritesheet = player.deadRightSpritesheet
				player.quad = player.deadQuad
			end
		end

		if player.hit then
			love.graphics.setColor(0, 0, 0, 1)
		end
		if player.invincible and player.invincibilityCounter % 2 == 0 then
			love.graphics.setColor(1, 1, 1, 0.75)
		end
		
		love.graphics.draw(player.spritesheet, player.quad)

		if player.invincible and player.invincibilityCounter % 2 ~= 0 then
			love.graphics.clear()
			love.graphics.setShader(convertColorShader)
			love.graphics.setColor(1, 1, 1, 0.25)
			love.graphics.draw(player.spritesheet, player.quad)
			love.graphics.setShader()
		end

		love.graphics.setColor(1, 1, 1, 1)
	end

	return player
end