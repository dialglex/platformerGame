function newPlayer(playerX, playerY)
    player = {}
    player.previousX = playerX
    player.previousY = playerY
    player.x = playerX
    player.y = playerY
    player.width = 15
    player.height = 24

    player.hitboxX = player.x
    player.hitboxY = player.y
    player.hitboxWidth = 15
    player.hitboxHeight = 24

    player.xVelocity = 0
    player.yVelocity = 0
    player.previousYVelocity = 0
    player.xAcceleration = 0.5
    player.xDeceleration = 0.15
    player.xTerminalVelocity = 1.80
    player.jumpAcceleration = 4.25
    player.fallAcceleration = 0.225
    player.yTerminalVelocity = 8
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

    player.hit = false
    player.hitLength = 5
    player.hitCounter = 0
    player.invincible = false
    player.invincibilityLength = 60
    player.invincibilityCounter = 0
    player.hp = 3
    player.maxHp = player.hp
    player.knockbackRestistance = 1
    player.weaponOut = false
    player.equippedWeapon1 = "woodenBow"
    player.equippedWeapon2 = "demonBroadsword"

    player.level = 1
    player.xp = 5
    player.nextLevelXp = 5
    player.baseDamage = 0

    player.sheathX = 0
    player.sheathY = 0
    player.sheathXOffset = 0
    player.sheathYOffset = 0

    player.jumpHoldDuration = 0.15 * 60
    player.jumpHoldCounter = 0
    player.jumpAble = true
    player.jumpAbleDuration = 0.03 * 60
    player.jumpAbleCounter = 0

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
        player:checkGrounded()
        player:combatLogic()
        player:checkBoss()
        player:ladder()
        if player:isDead() == false then
            player:openInventory()
            if player.jumpAble then
                player:jump()
            end
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
        player:mapTransition()

        debugPrint("player.x: " .. player.x)
        debugPrint("player.y: " .. player.y)
        debugPrint("player.xVelocity: " .. player.xVelocity)
        debugPrint("player.yVelocity: " .. player.yVelocity)
        
        debugPrint("Player level: "..player.level)
        debugPrint("Player xp: "..player.xp.." / "..player.nextLevelXp)
        debugPrint("Player hp: "..player.hp.." / "..player.maxHp)
        debugPrint("Player base damage: "..player.baseDamage)

        debugPrint("player.jumpAble"..tostring(player.jumpAble))
    end

    function player:openInventory()
        if pressInputs.close then
            table.insert(actors, newUi("inventory"))
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

        if player.hit then
            player.hitCounter = player.hitCounter - 1
        end

        if player.hitCounter <= 0 then
            player.hit = false
        end

        if (pressInputs.attack1 or pressInputs.attack2) and player.weaponOut == false and player:isDead() == false then
            if pressInputs.attack1 then
                player.attackWeapon = player.equippedWeapon1
            else
                player.attackWeapon = player.equippedWeapon2
            end

            local weaponName, weaponType, iconSprite, startupSprite, slashSprite, endSprite, sheathSprite, iconSprite, weaponWidth, weaponHeight, weaponDamage,
                weaponKnockbackStrength, weaponStartupLag, weaponSlashDuration, weaponEndLag, weaponXOffset,
                weaponYOffset, directionLocked, movementReduction, pierce = unpack(getWeaponStats(player.attackWeapon))
            
            local weaponDuration = weaponStartupLag + weaponSlashDuration + weaponEndLag

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
                table.insert(actors, newWeapon(actors[getTableLength(actors)+1], weaponName, weaponType, player.x + player.width/2 - weaponWidth/2 - weaponXOffset,
                    player.y + player.height/2 - weaponHeight/2 - weaponYOffset, weaponDamage,
                    weaponKnockbackStrength, weaponStartupLag, weaponSlashDuration, weaponEndLag,
                    weaponDuration, iconSprite, startupSprite, slashSprite, endSprite, sheathSprite, weaponXOffset,
                    weaponYOffset, directionLocked, movementReduction, pierce, shootDirection))
            else
                table.insert(actors, newWeapon(actors[getTableLength(actors)+1], weaponName, weaponType, player.x + player.width/2 - weaponWidth/2 + weaponXOffset,
                    player.y + player.height/2 - weaponHeight/2 + weaponYOffset, weaponDamage,
                    weaponKnockbackStrength, weaponStartupLag, weaponSlashDuration, weaponEndLag,
                    weaponDuration, iconSprite, startupSprite, slashSprite, endSprite, sheathSprite, weaponXOffset,
                    weaponYOffset, directionLocked, movementReduction, pierce, shootDirection))
            end
            player.currentWeapon = actors[getTableLength(actors)]
            player.lastUsedWeapon = player.currentWeapon

            player.currentWeapon.damage = player.currentWeapon.damage + player.baseDamage

            player.xTerminalVelocity = player.xTerminalVelocity / player.currentWeapon.movementReduction
            player.xAcceleration = player.xAcceleration / player.currentWeapon.movementReduction
            player.weaponOut = true
        end

        if player.weaponOut then
            if player.currentWeapon.durationCounter+1 >= player.currentWeapon.duration then 
                player.weaponOut = false
                player.xTerminalVelocity = player.xTerminalVelocity * player.currentWeapon.movementReduction
                player.xAcceleration = player.xAcceleration * player.currentWeapon.movementReduction
            end
        end
    end

    function player:checkBoss()
        blocked = true
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
            win = true
        end
    end

    function player:xpGain(amount)
        player.xp = player.xp + amount
        while player.xp >= player.nextLevelXp do
            player.level = player.level + 1
            player.xp = player.xp - player.nextLevelXp
            player.nextLevelXp = player.nextLevelXp*1.35 + player.level*1.75

            player.hpPercentage = player.hp/player.maxHp
            player.maxHp = player.maxHp + player.level*0.5
            player.hp = player.maxHp * player.hpPercentage
            player.baseDamage = player.level/2 - 0.5
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
        for index, actor in ipairs(actors) do
            if actor.actor == "npc" then
                table.remove(actors, index)
            end
        end

        currentMap = allMaps[map]
        actors = currentMap.actors

        playerExists = false
        for _, actor in ipairs(actors) do
            if actor.actor == "player" then
                playerExists = true
            end
        end

        currentMonsterDifficulty = monsterDifficulty
        difficultyToAdd = 0
        for i, npcSpawn in ipairs(currentMap.npcSpawns) do
            local randomNumber = math.random(0, 100)
            npcSpawnClone = deepTableClone(npcSpawn)
            if randomNumber < monsterDifficulty + 40 and npcSpawnClone.boss == false then
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
                difficultyToAdd = difficultyToAdd - 5
            elseif npcSpawnClone.boss then
                table.insert(actors, npcSpawnClone)
            else
                difficultyToAdd = difficultyToAdd + 2.5
            end
        end
        monsterDifficulty = monsterDifficulty + difficultyToAdd + 5

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
    end

    function isSuitableMap()
        if (string.gsub(currentMapDirectory, ".lua", "", 1)) == randomMap then
            return false
        end

        for i, e in ipairs(mapsUsed) do
            print(e)
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

        mapsToCheck = {unpack(allGrasslandMaps)}
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
        if blockTopLeft then
            local quad = love.graphics.newQuad(32, 0, 16, 16, 80, 80)
            table.insert(actors, newTile("corruption", 16, 16, 4*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 5*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 6*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 7*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 8*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
        end
        if blockTopMiddle then
            local quad = love.graphics.newQuad(32, 0, 16, 16, 80, 80)
            table.insert(actors, newTile("corruption", 16, 16, 12*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 13*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 14*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 15*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 16*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 17*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
        end
        if blockTopRight then
            local quad = love.graphics.newQuad(32, 0, 16, 16, 80, 80)
            table.insert(actors, newTile("corruption", 16, 16, 21*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 22*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 23*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 24*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 25*16, 0, quad, image, true, true, false, true, 0, 0, 16, 16))
        end
        if blockBottomLeft then
            local quad = love.graphics.newQuad(32, 0, 16, 16, 80, 80)
            table.insert(actors, newTile("corruption", 16, 16, 4*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 5*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 6*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 7*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 8*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
        end
        if blockBottomMiddle then
            local quad = love.graphics.newQuad(32, 0, 16, 16, 80, 80)
            table.insert(actors, newTile("corruption", 16, 16, 12*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 13*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 14*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 15*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 16*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 17*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
        end
        if blockBottomRight then
            local quad = love.graphics.newQuad(32, 0, 16, 16, 80, 80)
            table.insert(actors, newTile("corruption", 16, 16, 21*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 22*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 23*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 24*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 25*16, 16*16, quad, image, true, true, false, true, 0, 0, 16, 16))
        end
        if blockLeftTop then
            local quad = love.graphics.newQuad(0, 32, 16, 16, 80, 80)
            table.insert(actors, newTile("corruption", 16, 16, 0, 1*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 0, 2*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 0, 3*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 0, 4*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 0, 5*16, quad, image, true, true, false, true, 0, 0, 16, 16))
        end
        if blockLeftMiddle then
            local quad = love.graphics.newQuad(0, 32, 16, 16, 80, 80)
            table.insert(actors, newTile("corruption", 16, 16, 0, 6*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 0, 7*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 0, 8*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 0, 9*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 0, 10*16, quad, image, true, true, false, true, 0, 0, 16, 16))
        end
        if blockLeftBottom then
            local quad = love.graphics.newQuad(0, 32, 16, 16, 80, 80)
            table.insert(actors, newTile("corruption", 16, 16, 0, 11*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 0, 12*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 0, 13*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 0, 14*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 0, 15*16, quad, image, true, true, false, true, 0, 0, 16, 16))
        end
        if blockRightTop then
            local quad = love.graphics.newQuad(0, 32, 16, 16, 80, 80)
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 1*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 2*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 3*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 4*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 5*16, quad, image, true, true, false, true, 0, 0, 16, 16))
        end
        if blockRightMiddle then
            local quad = love.graphics.newQuad(0, 32, 16, 16, 80, 80)
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 6*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 7*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 8*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 9*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 10*16, quad, image, true, true, false, true, 0, 0, 16, 16))
        end
        if blockRightBottom then
            local quad = love.graphics.newQuad(0, 32, 16, 16, 80, 80)
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 11*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 12*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 13*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 14*16, quad, image, true, true, false, true, 0, 0, 16, 16))
            table.insert(actors, newTile("corruption", 16, 16, 29*16, 15*16, quad, image, true, true, false, true, 0, 0, 16, 16))
        end
        backgroundCanvas, foregroundCanvas = unpack(setupCanvases(actors))
    end

    function player:mapTransition()
        if player.x + player.width <= 0 then
            transitioningScreen = true
            if fadeIn == false then
                player:findRandomMap()
                player.x = 480 - player.width - 16
                player.y = player.previousY
            end
        elseif player.x >= 480 then
            transitioningScreen = true
            if fadeIn == false then
                player:findRandomMap()
                player.x = 0+16
                player.y = player.previousY
            end
        end

        if player.y + player.height <= 0 then
            transitioningScreen = true
            if fadeIn == false then
                player:findRandomMap()
                player.x = player.previousX
                player.y = 270 - player.height - 16
            end
        elseif player.y >= 270 then
            transitioningScreen = true
            if fadeIn == false then
                player:findRandomMap()
                player.x = player.previousX
                player.y = 0 + 16
            end
        end
    end

    function player:resetWeapon()
        if player.weaponOut then
            table.insert(actors, player.currentWeapon)
        end
    end

    function player:jump()
        -- this is running
        if pressInputs.jump then
            -- This isn't running.
            player.grounded = false
            player.jumpAble = false
            player.y = player.y - 1
            player.yVelocity = - player.jumpAcceleration
        end
    end

    function player:checkGrounded()
        player.transitioning = false
        player.oldGrounded = player.grounded
        if checkCollision(player:getX(), player:getY() + player.height, player.width, 1) then
            player.grounded = true
            player.jumpHoldCounter = 0
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
                end
            end
        else
          --collision to the right
            for _, actor in ipairs(getCollidingActors(player:getX() + player.width, player:getY(), 32, player.height, true, false, true, true, false, false)) do
                local newXMovement = (actor.x + actor.hitboxX) - (player.x + player.width)
                if newXMovement < minXMovement then
                    minXMovement = newXMovement
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

        debugPrint("player.offLadderFirstFrame: "..tostring(player.offLadderFirstFrame))
        if player.isDead() == false then
            for _, actor in ipairs(getCollidingActors(player:getX(), player:getY(), player.width, player.height, false, false, true, false, true, true, true)) do
                if actor.actor == "item" then
                    if actor.type == "heart" then
                        if player.hp < player.maxHp then
                            actor.remove = true
                            player.hp = player.hp + 1
                        end
                    elseif actor.type == "weapon" then
                        if pressInputs.interact then
                            local _, _, sprite1 = unpack(getWeaponStats(player.equippedWeapon1))
                            local _, _, sprite2 = unpack(getWeaponStats(player.equippedWeapon2))
                            local sprite3 = actor.sprite
                            local newWeapon = actor.name
                            table.insert(actors, newUi("newWeapon", sprite1, sprite2, sprite3, newWeapon))
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
                            interactSound:play()
                            player:newPlayer(actor.data)
                            break
                        end
                    elseif actor.type == "teleporter" then
                        if pressInputs.interact and actor.active then
                            bossLevel = true
                            player:newPlayer("maps/maps/grassland/boss")
                            for _, actor in ipairs(actors) do
                                if actor.name == "teleporter" then
                                    player.x = actor:getX() + player.width/2
                                    player.y = actor:getY() - player.height/2
                                end
                            end
                        end
                    end
                elseif actor.actor == "npc" then
                    if actor.enemy then
                        if player.invincible == false and player:isDead() == false then
                            player.hp = player.hp - actor.damage
                            player.knockbackAngle = math.atan2((player.y + player.height/2) - (actor.y + actor.height/2), (player.x + player.width/2) - (actor.x + actor.width/2))
                            player.knockbackDx = math.cos(player.knockbackAngle)
                            player.knockbackDy = math.sin(player.knockbackAngle)
                            if player:isDead() == false then
                                player.invincible = true
                                player.invincibilityCounter = player.invincibilityLength
                                player.xVelocity = player.knockbackDx*actor.knockbackStrength
                                if player.yVelocity < 0 then
                                    player.yVelocity = player.knockbackDy*actor.knockbackStrength
                                else
                                    player.yVelocity = player.knockbackDy*actor.knockbackStrength/2
                                end
                            else
                                player.xVelocity = player.knockbackDx*actor.knockbackStrength*1.5
                                if player.yVelocity < 0 then
                                    player.yVelocity = player.knockbackDy*actor.knockbackStrength*1.5
                                else
                                    player.yVelocity = player.knockbackDy*actor.knockbackStrength*1.5/2
                                end
                                player.xTerminalVelocity = player.xTerminalVelocity + actor.knockbackStrength / 10
                            end
                            actor.hitPlayer = true
                            actor.hitPlayerCounter = actor.hitPlayerLength
                            player.hit = true
                            player.hitCounter = player.hitLength
                        end
                    end
                end
            end
        end

        behindWall = false
        for _, actor in ipairs(getCollidingActors(player:getX(), player:getY(), player.width, player.height, false, false, false, true, false, false)) do
            if actor.name == "dirtBg" then
                behindWall = true
            end
        end

        if behindWall then
            if mainMusicVolume < 0.25 then
                mainMusicVolume = mainMusicVolume + 0.01
            end
            if menuMusicVolume > 0 then
                menuMusicVolume = menuMusicVolume - 0.01
            end
        else
            if menuMusicVolume < 0.25 then
                menuMusicVolume = menuMusicVolume + 0.01
            end
            if mainMusicVolume > 0 then
                mainMusicVolume = mainMusicVolume - 0.01
            end
        end
        mainMusic:setVolume(mainMusicVolume)
        menuMusic:setVolume(menuMusicVolume)
        bossMusic:setVolume(bossMusicVolume)

        if player.grounded then
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
                if newYMovement < player.yVelocity then
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
                if newYMovement > player.yVelocity then
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
            player.jumpAble = false
            player.jumpAbleCounter = 0
        end

        player.jumpHoldCounter = player.jumpHoldCounter + 1
        if downInputs.jump and player.jumpHoldCounter <= player.jumpHoldDuration then
            player.yVelocity = player.previousYVelocity
        end

        player.y = player.y + minYMovement
    end

	function player:xMovement()
        if pressInputs.ability then
            if player.xTerminalVelocity == 5 then
                player.xTerminalVelocity = 1.8
            elseif player.xTerminalVelocity == 1.8 then
                player.xTerminalVelocity = 5
            end

            player.hp = 100
            player.maxHp = player.hp
        end

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

    function player:animations()
        player.runDust = false
        if player.xVelocity == 0 then
            player.runQuadSection = 0
        end

        if player.onLadder then
            player.sheathXOffset = 1
            if player.climbQuadSection == 0 or player.climbQuadSection == 2*21 then
                player.sheathYOffset = 0
                if player.climbQuadSection == 0 then
                    player.sheathXOffset = 1
                elseif player.climbQuadSection == 2*21 then
                    player.sheathXOffset = 1
                end
            elseif player.climbQuadSection == 1*21 or player.climbQuadSection == 3*21 then
                player.sheathYOffset = 2
                if player.climbQuadSection == 1*21 then
                    player.sheathXOffset = 2
                elseif player.climbQuadSection == 3*21 then
                    player.sheathXOffset = 0
                end
            end

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
            if player.runQuadSection == 0 or player.runQuadSection == 4*21 then
                player.sheathYOffset = 1
                if player.runQuadSection == 0 then
                    if player.direction == "left" then
                        player.sheathXOffset = 7
                    else
                        player.sheathXOffset = -4
                    end
                else
                    if player.direction == "left" then
                        player.sheathXOffset = 7
                    else
                        player.sheathXOffset = -4
                    end
                end
            elseif player.runQuadSection == 1*21 or player.runQuadSection == 3*21 or player.runQuadSection == 5*21 or player.runQuadSection == 7*21 then
                player.sheathYOffset = 0
                if player.runQuadSection == 1*21 or player.runQuadSection == 3*21 then
                    if player.direction == "left" then
                        player.sheathXOffset = 6
                    else
                        player.sheathXOffset = -3
                    end
                else
                    if player.direction == "left" then
                        player.sheathXOffset = 5
                    else
                        player.sheathXOffset = -2
                    end
                end
            elseif player.runQuadSection == 2*21 or player.runQuadSection == 6*21 then
                player.sheathYOffset = -2
                if player.runQuadSection == 2*21 then
                    if player.direction == "left" then
                        player.sheathXOffset = 6
                    else
                        player.sheathXOffset = -3
                    end
                else
                    if player.direction == "left" then
                        player.sheathXOffset = 5
                    else
                        player.sheathXOffset = -2
                    end
                end
            end
            
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
            player.jumpCounter = 0
            player.jumpQuadSection = 0
        else
            if player.direction == "left" then
                player.sheathXOffset = 6
            else
                player.sheathXOffset = -3
            end
            
            if player.jumpCounter >= 5 and player.jumpQuadSection < 42 then
                player.jumpQuadSection = player.jumpQuadSection + 21
                player.jumpCounter = 0
            end
            player.jumpCounter = player.jumpCounter + 1
        end
        player.sheathX = player.getX() + player.sheathXOffset
        player.sheathY = player:getY() + player.sheathYOffset
    end

    function player:dust()
        if player.xVelocity ~= 0 and player.grounded and player.runDust then
            table.insert(actors, newDust(player.x, player.y, "run", player.direction, player.tileBelow))
        end
        if player.oldGrounded ~= player.grounded then
            if player.jumpAble == false or player.oldGrounded == false then
                if player.oldGrounded then
                    table.insert(actors, newDust(player.x, player.previousY, "jump", player.direction, player.tileBelow))
                else
                    table.insert(actors, newDust(player.x, player.y, "land", player.direction, player.tileBelow))
                end
            end
            player.transitioning = true
        end
        player.oldGrounded = player.grounded
    end

    function player:draw()
        if player:isDead() then
            player.width = 24
            player.height = 11-3
            if player.direction == "left" then
                player.canvas = love.graphics.newCanvas(player.deadLeftSpritesheet:getWidth(), player.deadLeftSpritesheet:getHeight())
            else
               player.canvas = love.graphics.newCanvas(player.deadRightSpritesheet:getWidth(), player.deadRightSpritesheet:getHeight())
            end 
        end

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
                player.quad = love.graphics.newQuad(player.jumpQuadSection, 0, 21, 26, 63, 26)
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
                player.quad = love.graphics.newQuad(player.jumpQuadSection, 0, 21, 26, 63, 26)
            end
            if player:isDead() then
                player.spritesheet = player.deadRightSpritesheet
                player.quad = love.graphics.newQuad(0, 0, 24, 11, 24, 11)
            end
        end


        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(player.spritesheet, player.quad)

        if player.hit then
            player.image = convertColor(player.canvas, 1, 1, 1, 1)
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