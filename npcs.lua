function newNpc(npcName, npcWidth, npcHeight, mapX, mapY, npcSpritesheet, npcEnemy, npcAi, npcXAcceleration, npcXTerminalVelocity, npcAnimationSpeed, npcAnimationFrames, npcHp, npcKnockbackStrength, npcKnockbackResistance, npcDamage, npcXp, npcBoss, npcProjectile, npcXVelocity, npcYVelocity)
    local npc = {}
    npc.uuid = math.random(2^128)
    npc.name = npcName
    npc.width = npcWidth
    npc.height = npcHeight
    npc.x = mapX
    npc.y = mapY - (npc.height - 16)
    npc.actor = "npc"

    npc.hitboxX = 0
    npc.hitboxY = 0
    npc.hitboxWidth = npc.width
    npc.hitboxHeight = npc.height

    npc.enemy = npcEnemy
    npc.ai = npcAi
    if npcXVelocity == nil then
        npc.xVelocity = 0
    else
        npc.xVelocity = npcXVelocity
    end

    if npcYVelocity == nil then
        npc.yVelocity = 0
    else
        npc.yVelocity = npcYVelocity
    end

    npc.xAcceleration = npcXAcceleration
    npc.yAcceleration = 0.2
    npc.xTerminalVelocity = npcXTerminalVelocity
    npc.yTerminalVelocity = 8
    npc.previousXVelocity = 0

    npc.accelerating = false
    npc.sineRadians = 0

    npc.hitPlayer = false
    npc.hitPlayerCounter = 0
    npc.hitPlayerLength = 5
    npc.hit = false
    npc.hitCounter = 0
    npc.hitLength = 5
    npc.grounded = false

    npc.damage = npcDamage
    npc.hp = npcHp
    npc.maxHp = npc.hp
    npc.knockbackStrength = npcKnockbackStrength
    npc.knockbackResistance = npcKnockbackResistance

    npc.xpMin = npcXp-(0.2*npcXp)
    npc.xpMax = npcXp+(0.2*npcXp)
    npc.xp = math.random(100*npc.xpMin, 100*npc.xpMax)/100
    npc.boss = npcBoss
    npc.projectile = npcProjectile
    npc.projectileCounter = 0

    npc.knockedBack = false
    npc.healthBarDuration = 100
    npc.healthBarFadeDuration = 25
    npc.healthBarOpacity = 0
    npc.lastHitTimer = npc.healthBarDuration + npc.healthBarFadeDuration

    npc.baseSpritesheet = npcSpritesheet
    npc.animationSpeed = npcAnimationSpeed -- lower is faster
    npc.animationFrames = npcAnimationFrames
    npc.frame = 0
    npc.frameCounter = 0
    if npc.ai == "flying" or npc.ai == "sine" or npc.ai == "boss" or npc.ai == "projectile" then
        npc.flyingSpritesheet = npc.baseSpritesheet
    elseif npc.ai == "walking" then
        if npc.enemy == false then
            npc.idleRightSpritesheet = npc.baseSpritesheet
            npc.idleLeftSpritesheet = love.graphics.newImage("images/npcs/friendly/"..npc.name.."/"..npc.name.."IdleLeftSpritesheet.png")
            npc.walkLeftSpritesheet = love.graphics.newImage("images/npcs/friendly/"..npc.name.."/"..npc.name.."WalkLeftSpritesheet.png")
            npc.walkRightSpritesheet = love.graphics.newImage("images/npcs/friendly/"..npc.name.."/"..npc.name.."WalkRightSpritesheet.png")
        else
            npc.walkRightSpritesheet = npc.baseSpritesheet
            npc.walkLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."WalkLeftSpritesheet.png")
            npc.idleRightSpritesheet = npc.baseSpritesheet
            npc.idleLeftSpritesheet = npc.baseSpritesheet
        end
    end
    npc.walkCounter = 0
    npc.walkQuadSection = 0
    npc.jumpCounter = 0
    npc.jumpQuadSection = 0
    npc.idleCounter = 0
    npc.idleQuadSection = 0

    npc.xPlayerDistance = 0
    npc.yPlayerDistance = 0
    npc.playerDistance = 0
    

    local randomNumber = math.random(0,1)
    if randomNumber == 0 then
        npc.looking = "left"
        npc.direction = "left"
    else
        npc.looking = "right"
        npc.direction = "right"
    end

    npc.canvas = love.graphics.newCanvas(npc.width, npc.height)

    function npc:act(index)
        npc.index = index
        npc:combatLogic(index)
        npc:movement()
        if npc.ai == "flying" then
            npc:physics()
            npc:flyingAi()
        elseif npc.ai == "walking" then
            npc:checkGrounded()
            npc:physics()
            npc:airPhysics()
            npc:walkingAi()
        elseif npc.ai == "sine" then
            npc:airPhysics()
            npc:physics()
            npc:sineAi()
        elseif npc.ai == "boss" then
            npc:airPhysics()
            npc:physics()
            npc:bossAi()
        elseif npc.ai == "projectile" then
            npc:projectileAi()
        end
        npc:animation()

        debugPrint(npc.name..": npc.projectile = "..tostring(npc.projectile))
    end

    function npc:checkGrounded()
        if checkCollision(npc:getX(), npc:getY() + npc.height, npc.width, 1) then
            npc.grounded = true
            npc.yVelocity = 0
        else
            npc.grounded = false
        end
    end

    function npc:combatLogic(npcIndex)
        npc.lastHitTimer = npc.lastHitTimer + 1
        npc.projectileCounter = npc.projectileCounter + 1

        if npc.hitPlayer then
            npc.hitPlayerCounter = npc.hitPlayerCounter - 1
        end

        if npc.hitPlayerCounter <= 0 then
            npc.hitPlayer = false
        end

        if npc.hit then
            npc.hitCounter = npc.hitCounter - 1
        end

        if npc.hitCounter <= 0 then
            npc.hit = false
        end

        if npc.hp <= 0 or npc.x < 0-npc.width or npc.x > 480+npc.width then
            player:xpGain(npc.xp)
            local itemType, sprite, width, height = unpack(getItemStats("heart"))
            table.insert(actors, newItem("heart", npc.x, npc.y, itemType, sprite, width, height))
            local itemType, sprite, width, height = unpack(getItemStats("cobaltBroadsword"))
            table.insert(actors, newItem("cobaltBroadsword", npc.x, npc.y, itemType, sprite, width, height))
            table.remove(actors, npcIndex)
        end
    end

    function npc:physics()
        npc.tileLeft = ""
        npc.tileRight = ""
        npc.tileBottomLeft = ""
        npc.tileBottomRight = ""

        npc.previousXVelocity = npc.xVelocity
        local minXMovement = npc.xVelocity
        if minXMovement < 0 then
            --collision to the left
            for _, actor in ipairs(getCollidingActors(npc:getX() - 32, npc:getY(), 32, npc.height, true, false, true, true, false, false)) do -- 32 = 2*16 tile width
                local newXMovement = (actor.x + actor.hitboxX) + actor.hitboxWidth - npc.x
                if newXMovement > minXMovement then
                    minXMovement = newXMovement
                end
            end
        else
          --collision to the right
            for _, actor in ipairs(getCollidingActors(npc:getX() + npc.width, npc:getY(), 32, npc.height, true, false, true, true, false, false)) do
                local newXMovement = (actor.x + actor.hitboxX) - (npc.x + npc.width)
                if newXMovement < minXMovement then
                    minXMovement = newXMovement
                end
            end
        end

        npc.x = npc.x + minXMovement
    end

    function npc:airPhysics()
        npc.previousYVelocity = npc.yVelocity
        local minYMovement = npc.yVelocity
        if minYMovement > 0 then
            --collision below npc
            for _, actor in ipairs(getCollidingActors(npc:getX(), npc:getY() + npc.height, npc.width, 32, true, true, false, true, false, false)) do
                local newYMovement = (actor.y + actor.hitboxY) - (npc.y + npc.height)
                if newYMovement < npc.yVelocity then
                    minYMovement = newYMovement
                end
            end
        else
            --collision above npc
            for _, actor in ipairs(getCollidingActors(npc:getX(), npc:getY() - 32, npc.width, 32, true, false, false, true, false, false)) do
                local newYMovement = (actor.y + actor.hitboxY) + actor.hitboxHeight - npc.y
                if newYMovement > npc.yVelocity then
                    minYMovement = newYMovement
                    npc.yVelocity = 0
                end
            end
        end

        if npc.yVelocity >= npc.yTerminalVelocity then
            npc.yVelocity = npc.yTerminalVelocity
        end

        npc.y = npc.y + minYMovement
    end


    function npc:walkingAi()
        for _, actor in ipairs(getCollidingActors(npc:getX() - 8, npc:getY(), 8, npc.height, true, false, false, true, false, false)) do
            if actor.collidable then
                npc.tileLeft = actor.name
            end
        end

        for _, actor in ipairs(getCollidingActors(npc:getX() + npc.width, npc:getY(), 8, npc.height, true, false, false, true, false, false)) do
            if actor.collidable then
                npc.tileRight = actor.name
            end
        end

        for _, actor in ipairs(getCollidingActors(npc:getX() - 8, npc:getY() + npc.height, 8, 1, true, true, false, true, false, false)) do
            if actor.collidable or actor.platform then
                npc.tileBottomLeft = actor.name
            end
        end

        for _, actor in ipairs(getCollidingActors(npc:getX() + npc.width, npc:getY() + npc.height, 8, 1, true, true, false, true, false, false)) do
            if actor.collidable or actor.platform then
                npc.tileBottomRight = actor.name
            end
        end

        if npc.x >= 480-npc.width-8 or npc.tileRight ~= "" then
            npc.direction = "left"
        elseif npc.x <= npc.width-8 or npc.tileLeft ~= "" then
            npc.direction = "right"
        end

        if npc.direction == "right" and npc.tileBottomRight == "" then
            npc.direction = "left"
        elseif npc.direction == "left" and npc.tileBottomLeft == "" then
            npc.direction = "right"
        end

        if npc.xVelocity > 0 then
            npc.looking = "right"
        elseif npc.xVelocity < 0 then
            npc.looking = "left"
        end

        if npc.enemy == false and npc.playerDistance > 25 or npc.enemy then
            npc.accelerating = true
        else
            if npc.xPlayerDistance < 0 then
                npc.looking = "left"
            else
                npc.looking = "right"
            end
            npc.accelerating = false
        end

        if npc.accelerating then
            if npc.direction == "left" then
                if npc.xVelocity > -npc.xTerminalVelocity then
                    npc.xVelocity = npc.xVelocity - npc.xAcceleration
                end
            else
                if npc.xVelocity < npc.xTerminalVelocity then
                    npc.xVelocity = npc.xVelocity + npc.xAcceleration
                end
            end

            if npc.xVelocity > npc.xTerminalVelocity then
                npc.xVelocity = npc.xVelocity - npc.xAcceleration
            elseif npc.xVelocity < -npc.xTerminalVelocity then
                npc.xVelocity = npc.xVelocity + npc.xAcceleration
            end
        else
            if npc.xVelocity > 0 then
                npc.xVelocity = npc.xVelocity - npc.xAcceleration
            elseif npc.xVelocity < 0 then
                npc.xVelocity = npc.xVelocity + npc.xAcceleration
            end
        end

        if npc.yVelocity > -npc.yTerminalVelocity and npc.grounded == false then
            npc.yVelocity = npc.yVelocity + npc.yAcceleration
        end
    end

    function npc:flyingAi()
        for _, actor in ipairs(getCollidingActors(npc:getX() - 8, npc:getY()-2, 8, npc.height+2*2, true, false, false, true, false, false)) do
            if actor.collidable then
                npc.tileLeft = actor.name
            end
        end

        for _, actor in ipairs(getCollidingActors(npc:getX() + npc.width, npc:getY()-2, 8, npc.height+2*2, true, false, false, true, false, false)) do
            if actor.collidable then
                npc.tileRight = actor.name
            end
        end

        if npc.x >= 480-npc.width-8 or npc.tileRight ~= "" then
            npc.direction = "left"
        elseif npc.x <= npc.width-8 or npc.tileLeft ~= "" then
            npc.direction = "right"
        end

        if npc.direction == "left" then
            if npc.xVelocity > -npc.xTerminalVelocity then
                npc.xVelocity = npc.xVelocity - npc.xAcceleration
            end
        else
            if npc.xVelocity < npc.xTerminalVelocity then
                npc.xVelocity = npc.xVelocity + npc.xAcceleration
            end
        end

        if npc.xVelocity > npc.xTerminalVelocity then
            npc.xVelocity = npc.xVelocity - npc.xAcceleration
        elseif npc.xVelocity < -npc.xTerminalVelocity then
            npc.xVelocity = npc.xVelocity + npc.xAcceleration
        end
    end

    function npc:sineAi()
        npc.sineRadians = npc.sineRadians + 0.05
        npc.yVelocity = math.sin(npc.sineRadians)*1.5
    end

    function npc:bossAi()
        if npc.hp/npc.maxHp > 2/3 then
            npc.yVelocity = 0
            npc.xTerminalVelocity = 1.75
        elseif npc.hp/npc.maxHp > 1/3 then
            npc:sineAi()
            npc.xTerminalVelocity = 1
        else
            npc:sineAi()
            npc.xTerminalVelocity = 1.5
            if npc.projectileCounter > 20 then
                local npcStats = getNpcStats("smileyProjectile")
                local actor, ai, sprite, animationSpeed, animationFrames, width, height, damage, hp, knockbackStrength, knockbackResistance, xAcceleration, xTerminalVelocity, enemy, xp, boss, projectile = unpack(npcStats)
                
                local projectileAngle = math.atan2(npc.yVelocity, npc.xVelocity)
                local projectileDx = math.cos(projectileAngle)
                local projectileDy = math.sin(projectileAngle)
                table.insert(actors, newNpc(actor, width, height, npc.x + npc.width/2 - width/2, npc.y + npc.height/2 - height/2, sprite, enemy, ai, xAcceleration, xTerminalVelocity, animationSpeed, animationFrames, hp, knockbackStrength, knockbackResistance, damage, xp, boss, projectile, projectileDx*3, projectileDy*3))
                npc.projectileCounter = 0
            end
        end
        npc:flyingAi()
    end

    function npc:projectileAi()
        npc.x = npc.x + npc.xVelocity
        npc.y = npc.y + npc.yVelocity
    end


    
    function npc:movement()
        if (npc.direction == "left" and npc.xVelocity < npc.xTerminalVelocity) or (npc.direction == "right" and npc.xVelocity > -npc.xTerminalVelocity) then
            npc.knockedBack = false
        end

        if npc.knockedBack == false and ((npc.previousXVelocity > 0 and npc.xVelocity < 0) or (npc.previousXVelocity < 0 and npc.xVelocity > 0)) then
            npc.xVelocity = 0
        end

        if npc.enemy == false then
            npc.xPlayerDistance = player.x-npc.x
            npc.playerDistance = math.sqrt(npc.xPlayerDistance^2 + npc.yPlayerDistance^2)
        end
    end

    function npc:animation()
        npc.healthBarOpacity = npc.lastHitTimer/npc.healthBarDuration
        if npc.lastHitTimer < npc.healthBarDuration then
            npc.healthBarOpacity = 1
        else
            npc.healthBarOpacity = 0
            if npc.lastHitTimer < npc.healthBarDuration + npc.healthBarFadeDuration then
                npc.healthBarOpacity = 1 - (npc.lastHitTimer - npc.healthBarDuration)/npc.healthBarFadeDuration
            end
        end
        if npc.ai == "flying" then
            if npc.frameCounter >= npc.animationSpeed then
                npc.frame = npc.frame + 1
                npc.frameCounter = 0
                npc.frameQuad = love.graphics.newQuad((npc.frame-1)*npc.width, 0, npc.width, npc.height, npc.width*npc.animationFrames, npc.height)
            end

            if npc.frame >= npc.animationFrames then
                npc.frame = 0
                npc.frameCounter = 0
            end

    		npc.frameCounter = npc.frameCounter + 1
        elseif npc.ai == "walking" then
            if npc.xVelocity == 0 then
                if npc.idleCounter >= npc.animationSpeed then
                    npc.idleQuadSection = npc.idleQuadSection + npc.width
                    npc.idleCounter = 0
                end
                if npc.idleQuadSection >= npc.width*npc.animationFrames then
                    npc.idleQuadSection = 0
                    npc.idleCounter = 0
                end
                npc.idleCounter = npc.idleCounter + 1
            else
                if npc.walkCounter >= npc.animationSpeed then
                    npc.walkQuadSection = npc.walkQuadSection + npc.width
                    npc.walkCounter = 0
                end
                if npc.walkQuadSection >= npc.width*npc.animationFrames then
                    npc.walkQuadSection = 0
                    npc.walkCounter = 0
                end
                npc.walkCounter = npc.walkCounter + 1
            end
        end
	end

    function npc:getX()
        return math.floor(npc.x + 0.5)
    end

    function npc:getY()
        return math.floor(npc.y + 0.5)
    end

	function npc:draw()
        love.graphics.setCanvas(npc.canvas)
        love.graphics.clear()

        love.graphics.setBackgroundColor(0, 0, 0, 0)

        if npc.ai == "flying" or npc.ai == "sine" or npc.ai == "boss" or npc.ai == "projectile" then
            npc.spritesheet = npc.flyingSpritesheet
            npc.quad = npc.frameQuad
        elseif npc.ai == "walking" then
            if npc.looking == "left" then
                if npc.xVelocity == 0 then
                    npc.spritesheet = npc.idleLeftSpritesheet
                    npc.quad = love.graphics.newQuad(npc.idleQuadSection, 0, npc.width, npc.height, npc.width*npc.animationFrames, npc.height)
                else
                    npc.spritesheet = npc.walkLeftSpritesheet
                    npc.quad = love.graphics.newQuad(npc.walkQuadSection, 0, npc.width, npc.height, npc.width*npc.animationFrames, npc.height)
                end
            else
                if npc.xVelocity == 0 then
                    npc.spritesheet = npc.idleRightSpritesheet
                    npc.quad = love.graphics.newQuad(npc.idleQuadSection, 0, npc.width, npc.height, npc.width*npc.animationFrames, npc.height)
                else
                    npc.spritesheet = npc.walkRightSpritesheet
                    npc.quad = love.graphics.newQuad(npc.walkQuadSection, 0, npc.width, npc.height, npc.width*npc.animationFrames, npc.height)
                end
            end
        end
        love.graphics.draw(npc.spritesheet, npc.quad)

        if npc.hitPlayer then
            npc.image = convertColor(npc.canvas, 0, 0, 0, 1)
            love.graphics.clear()
            love.graphics.draw(npc.image)
        end

        if npc.hit then
            npc.image = convertColor(npc.canvas, 1, 1, 1, 1)
            love.graphics.clear()
            love.graphics.draw(npc.image)
        end
    end

    return npc
end