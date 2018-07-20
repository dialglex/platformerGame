function newPlayer(playerX, playerY)
    local player = {}
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
    player.directon = "right"
    player.grounded = true
    player.oldGrounded = true
    player.runDust = false
    player.onLadder = false
    player.actor = "player"
    player.tileAbove = ""
    player.tileBelow = ""
    player.tileLeft = ""
    player.tileRight = ""


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

    player.idleLeftSpritesheet = love.graphics.newImage("images/player/playerIdleLeftSpritesheet.png")
    player.idleRightSpritesheet = love.graphics.newImage("images/player/playerIdleRightSpritesheet.png")
    player.runLeftSpritesheet = love.graphics.newImage("images/player/playerRunLeftSpritesheet.png")
    player.runRightSpritesheet = love.graphics.newImage("images/player/playerRunRightSpritesheet.png")
    player.jumpLeftSpritesheet = love.graphics.newImage("images/player/playerJumpLeftSpritesheet.png")
    player.jumpRightSpritesheet = love.graphics.newImage("images/player/playerJumpRightSpritesheet.png")

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
        player:ladder()
        if player.jumpAble then
            player:jump()
        end
        if player.onLadder == false then
            player:physics()
            player:xMovement()
            if player.grounded == false then
                player:airPhysics()
            end
        end
        player:animations()
        player:dust()
        player:levelTransition()

        debugPrint("player.x: " .. player.x)
        debugPrint("player.y: " .. player.y)
        debugPrint("player.xVelocity: " .. player.xVelocity)
        debugPrint("player.yVelocity: " .. player.yVelocity)
        debugPrint("player.grounded: " .. tostring(player.grounded))
        debugPrint("player.oldGrounded: " .. tostring(player.oldGrounded))
        debugPrint("player.transitioning: " .. tostring(player.transitioning))
        debugPrint("player.jumpAble: " .. tostring(player.jumpAble))
        debugPrint("player.runDust: " .. tostring(player.runDust))
    end

    function player:ladder()
        if keyPress["up"] then
            if player.onLadder == false then
                player.onLadder = true
                print("on")
            end
        end

        if true then
            if keyPress["space"] or keyPress["left"] or keyPress["right"] then
                if player.onLadder then
                    player.onLadder = false
                    player.jumpAble = true
                    player.yVelocity = 0
                    print("off")
                end
            end
            if player.onLadder then
                if keyDown["up"] then
                    player.y = player.y - 2
                elseif keyDown["down"] then
                    player.y = player.y + 2
                end
            end
        end
    end

    function player:levelTransition()
        if player.x + player.width <= 0 then
            setupLevel(leftMap, player)
            player.x = 480 - player.width
            player.y = player.previousY
        elseif player.x >= 480 then
            setupLevel(rightMap, player)
            player.x = 0
            player.y = player.previousY
        end

        if player.y + player.height <= 0 then
            setupLevel(topMap, player)
            player.x = player.previousX
            player.y = 270 - player.height
        elseif player.y >= 270 then
            setupLevel(bottomMap, player)
            player.x = player.previousX
            player.y = 0
        end
    end

   	function player:jump()
        if keyPress["space"] then
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

        for _, actor in ipairs(getCollidingActors(player:getX() - 16, player:getY(), 16, player.height)) do
            player.tileLeft = actor.name
        end

        for _, actor in ipairs(getCollidingActors(player:getX() + player.width, player:getY(), 16, player.height)) do
            player.tileRight = actor.name
        end
        for _, actor in ipairs(getCollidingActors(player:getX(), player:getY() + player.height, player.width, 16)) do
            player.tileBelow = actor.name
        end
        for _, actor in ipairs(getCollidingActors(player:getX(), player:getY() - 16, player.width, 16)) do
            player.tileAbove = actor.name
        end

        if player.grounded then
            player.jumpAble = true
        end

        player.x = player.x + minXMovement
    end

    function player:airPhysics()
        player.previousYVelocity = player.yVelocity
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

        if player.jumpAbleCounter <= player.jumpAbleDuration and player.jumpAble then
            player.jumpAbleCounter = player.jumpAbleCounter + 1
        else
            player.jumpAble = false
            player.jumpAbleCounter = 0
        end

        player.jumpHoldCounter = player.jumpHoldCounter + 1
        if keyDown["space"] and player.jumpHoldCounter <= player.jumpHoldDuration then
            player.yVelocity = player.previousYVelocity
        end

        player.y = player.y + minYMovement
    end

	function player:xMovement()
        if love.keyboard.isDown("left") then
            if player.xVelocity > - player.xTerminalVelocity then
                player.xVelocity = player.xVelocity - player.xAcceleration
            else
                player.xVelocity = - player.xTerminalVelocity
            end
            player.direction = "left"
        elseif love.keyboard.isDown("right") then
            if player.xVelocity < player.xTerminalVelocity then
                player.xVelocity = player.xVelocity + player.xAcceleration
            else
                player.xVelocity = player.xTerminalVelocity
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
        player.runDust = false
        if player.xVelocity == 0 then
            player.runQuadSection = 0
        end
        if player.grounded then
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
                    player.Quad = love.graphics.newQuad(player.idleQuadSection, 0, 21, 26, 84, 26)
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
                    player.Quad = love.graphics.newQuad(player.idleQuadSection, 0, 21, 26, 84, 26)
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

    return player
end