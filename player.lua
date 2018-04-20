function newPlayer(playerX, playerY)
    local player = {}
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
    player.xAcceleration = 0.5
    player.xDeceleration = 0.15
    player.xTerminalVelocity = 1.65
    player.jumpAcceleration = 6
    player.fallAcceleration = 0.225
    player.yTerminalVelocity = 8
    player.directon = "right"
    player.grounded = true
    player.actor = "player"

    player.runCounter = 0
    player.runQuadSection = 0
    player.jumpCounter = 0
    player.jumpQuadSection = 0
    player.idleCounter = 0
    player.idleQuadSection = 0

    player.idleLeftSpritesheet = love.graphics.newImage("images/player/playerIdleLeftSpritesheet.png")
    player.idleRightSpritesheet = love.graphics.newImage("images/player/playerIdleRightSpritesheet.png")
    player.runLeftSpritesheet = love.graphics.newImage("images/player/playerRunLeftSpritesheet.png")
    player.runRightSpritesheet = love.graphics.newImage("images/player/playerRunRightSpritesheet.png")
    player.jumpLeftSpritesheet = love.graphics.newImage("images/player/playerJumpLeftSpritesheet.png")
    player.jumpRightSpritesheet = love.graphics.newImage("images/player/playerJumpRightSpritesheet.png")

    player.dustLeftSpritesheet = love.graphics.newImage("images/player/playerDustLeftSpritesheet.png")
    player.dustRightSpritesheet = love.graphics.newImage("images/player/playerDustRightSpritesheet.png")
    player.dustJumpSpritesheet = love.graphics.newImage("images/player/playerDustJumpSpritesheet.png")

	player.canvas = love.graphics.newCanvas(21, 26)

    function player:getX()
        return math.floor(player.x + 0.5)
    end

    function player:getY()
        return math.floor(player.y + 0.5)
    end

    function player:act()
        player:checkGrounded()
		player:physics()
        if player.grounded then
            player:jump()
        else
            player:airPhysics()
        end
        player:xMovement()
        player:animations()

        debugPrint("player.x: " .. player.x)
        debugPrint("player.y: " .. player.y)
        debugPrint("player.xVelocity: " .. player.xVelocity)
        debugPrint("player.yVelocity: " .. player.yVelocity)
        debugPrint("player.grounded: " .. tostring(player.grounded))
    end

   	function player:jump()
        if keyPress["space"] and player.grounded then
            player.grounded = false
            player.y = player.y - 1
            player.yVelocity = - player.jumpAcceleration + player.fallAcceleration
        end
    end

    function player:checkGrounded()
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
            for _, actor in ipairs(getCollidingActors(player:getX() - 32, player:getY(), 32, player.height)) do -- 32 = 2*16 tile width
                local newXMovement = (actor.x + actor.hitboxX) + actor.hitboxWidth - player.x
                if newXMovement > minXMovement then
                    minXMovement = newXMovement
                end
            end
        else
          --collision to the right
            for _, actor in ipairs(getCollidingActors(player:getX() + player.width, player:getY(), 32, player.height)) do
                local newXMovement = (actor.x + actor.hitboxX) - (player.x + player.width)
                if newXMovement < minXMovement then
                    minXMovement = newXMovement
                end
            end
        end
        player.x = player.x + minXMovement
    end

    function player:airPhysics()
        player.yVelocity = player.yVelocity + player.fallAcceleration

        local minYMovement = player.yVelocity
        if minYMovement > 0 then
            --collision below player
            for _, actor in ipairs(getCollidingActors(player:getX(), player:getY() + player.height, player.width, 32)) do
                local newYMovement = (actor.y + actor.hitboxY) - (player.y + player.height)
                if newYMovement < player.yVelocity then
                    minYMovement = newYMovement
                end
            end
        else
            --collision above player
            for _, actor in ipairs(getCollidingActors(player:getX(), player:getY() - 32, player.width, 32)) do
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

        player.y = player.y + minYMovement
    end

	function player:xMovement()
        if love.keyboard.isDown("left") then
            if player.xVelocity > - player.xTerminalVelocity then
                player.xVelocity = player.xVelocity - player.xAcceleration
            end
            player.direction = "left"
        elseif love.keyboard.isDown("right") then
            if player.xVelocity < player.xTerminalVelocity then
                player.xVelocity = player.xVelocity + player.xAcceleration
            end
            player.direction = "right" 	 
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
        if player.grounded then
            if player.xVelocity == 0 then
                if player.idleCounter >= 15 then
                    player.idleQuadSection = player.idleQuadSection + 21
                    player.idleCounter = 0
                end
                if player.idleQuadSection >= 63 then
                    player.idleQuadSection = 0
                    player.idleCounter = 0
                end
                player.idleCounter = player.idleCounter + 1
            else
                if player.runCounter >= 6 then
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
            if player.jumpCounter >= 5 and player.jumpQuadSection < 42 then
                player.jumpQuadSection = player.jumpQuadSection + 21
                player.jumpCounter = 0
            end
            player.jumpCounter = player.jumpCounter + 1
        end
    end

    function player:draw()
        love.graphics.setCanvas(player.canvas)
        love.graphics.clear()
    
        love.graphics.setBackgroundColor(0, 0, 0, 0)

        if player.direction == "left" then
            if player.grounded then
                if player.xVelocity == 0 then
                    player.Spritesheet = player.idleLeftSpritesheet
                    player.Quad = love.graphics.newQuad(player.idleQuadSection, 0, 21, 26, 63, 26)
                else
                    player.Spritesheet = player.runLeftSpritesheet
                    player.Quad = love.graphics.newQuad(player.runQuadSection, 0, 21, 26, 168, 26)
                end
            else
                player.Spritesheet = player.jumpLeftSpritesheet
                player.Quad = love.graphics.newQuad(player.jumpQuadSection, 0, 21, 26, 63, 26)
            end
        else
            if player.grounded then
                if player.xVelocity == 0 then
                    player.Spritesheet = player.idleRightSpritesheet
                    player.Quad = love.graphics.newQuad(player.idleQuadSection, 0, 21, 26, 63, 26)
                else
                    player.Spritesheet = player.runRightSpritesheet
                    player.Quad = love.graphics.newQuad(player.runQuadSection, 0, 21, 26, 168, 26)
                end
            else
                player.Spritesheet = player.jumpRightSpritesheet
                player.Quad = love.graphics.newQuad(player.jumpQuadSection, 0, 21, 26, 63, 26)
            end
        end
        love.graphics.draw(player.Spritesheet, player.Quad)
    end

    return player
end