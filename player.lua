function newPlayer(playerX, playerY)
    local player = {}
    player.x = playerX
    player.y = playerY
    player.width = 15
    player.height = 24
    player.xVelocity = 0
    player.yVelocity = 0
    player.xAcceleration = 0.1
    player.xTerminalVelocity = 2
    player.jumpAcceleration = 6
    player.fallAcceleration = 0.25
    player.yTerminalVelocity = 8
    player.directon = "right"
    player.walking = false
    player.grounded = true
    player.actor = "player"

    player.spritesheet = love.graphics.newImage("images/player/player.png")
	player.canvas = love.graphics.newCanvas(20, 26)

    function player:act()
        player:checkGrounded()
		player:physics()
        if player.grounded then
            player:jump()
        else
            player:airPhysics()
        end
        player:xMovement()

        debugPrint("player.xVelocity: " .. player.xVelocity)
        debugPrint("player.yVelocity: " .. player.yVelocity)
        debugPrint("player.grounded: " .. tostring(player.grounded))
    end

   	function player:jump(key, _, _)
        if keyPress["space"] and player.grounded then
            player.grounded = false
            player.y = player.y - 1
            player.yVelocity = - player.jumpAcceleration + player.fallAcceleration
        end
    end

    function player:checkGrounded()
        if checkCollision(player.x, player.y + player.height, player.width, 1) then
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
            for _, actor in ipairs(getCollidingActors(player.x - 32, player.y, 32, player.height)) do -- 32 = 2*16 tile width
                local newXMovement = actor.x + actor.width - player.x
                if newXMovement > minXMovement then
                    minXMovement = newXMovement
                end
            end
        else
          --collision to the right
            for _, actor in ipairs(getCollidingActors(player.x + player.width, player.y, 32, player.height)) do
                local newXMovement = actor.x - (player.x + player.width)
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
            for _, actor in ipairs(getCollidingActors(player.x, player.y + player.height, player.width, 32)) do
                local newYMovement = actor.y - (player.y + player.height)
                if newYMovement < player.yVelocity then
                    minYMovement = newYMovement
                end
            end
        else
            --collision above player
            for _, actor in ipairs(getCollidingActors(player.x, player.y - 32, player.width, 32)) do
                local newYMovement = actor.y + actor.height - player.y
                if newYMovement > player.yVelocity then
                    minYMovement = newYMovement
                    player.yVelocity = 0
                end
            end
        end

        if player.yVelocity >= player.yTerminalVelocity then
            player.yVelocity = player.yTerminalVelocity
        end

        player.y = math.floor(player.y + minYMovement)
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
             	player.xVelocity = player.xVelocity - player.xAcceleration
             	if player.xVelocity < player.xAcceleration then
               		player.xVelocity = 0
             	end
            elseif player.xVelocity < 0 then
            	player.xVelocity = player.xVelocity + player.xAcceleration
             	if player.xVelocity > - player.xAcceleration then
              		player.xVelocity = 0
             	end
            end
        end
    end

    function player:draw()
        love.graphics.setCanvas(player.canvas)
        love.graphics.clear()
    
        love.graphics.setBackgroundColor(0, 0, 0, 0)
        love.graphics.draw(player.spritesheet)
    end

    return player
end