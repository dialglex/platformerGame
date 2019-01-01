function newDust(playerX, playerY, playerAction, playerDirection, playerTileBelow)
	local dust = {}
	dust.x = playerX - 6
    dust.y = playerY + 16
    dust.action = playerAction
    dust.direction = playerDirection
    dust.tileBelow = playerTileBelow
    dust.counter = 0
    dust.quadSection = 0
    dust.actor = "dust"

	if dust.action == "run" then
        if dust.direction == "left" then
            if dust.tileBelow == "grass" then
                dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustLeavesSpritesheet.png")
                dust.frames = 24
                dust.speed = 3
                runGrassSound:play()
            elseif dust.tileBelow == "ice" then
                dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustSnowSpritesheet.png")
                dust.frames = 8
                dust.speed = 2
                runGrassSound:play()
            else
                dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustRunLeftSpritesheet.png")
                dust.x = dust.x + 15
                dust.frames = 3
                dust.speed = 3
                runNeutralSound:play()
            end
        else
            if dust.tileBelow == "grass" then
                dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustLeavesSpritesheet.png")
                dust.frames = 24
                dust.speed = 3
                runGrassSound:play()
            elseif dust.tileBelow == "ice" then
                dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustSnowSpritesheet.png")
                dust.frames = 8
                dust.speed = 2
                runGrassSound:play()
            else
                dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustRunRightSpritesheet.png")
                dust.frames = 3
                dust.speed = 3
                runNeutralSound:play()
            end
        end
    elseif dust.action == "jump" then
        if dust.tileBelow == "grass" then
            dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustLeavesSpritesheet.png")
            dust.frames = 24
            dust.speed = 3
            dust.y = dust.y - 4
            jumpNeutralSound:play()
        elseif dust.tileBelow == "ice" then
            dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustSnowSpritesheet.png")
            dust.frames = 8
            dust.speed = 2
            dust.y = dust.y - 2
            jumpNeutralSound:play()
        else
            dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustJumpSpritesheet.png")
            dust.frames = 3
            dust.speed = 3
            jumpNeutralSound:play()
        end
    elseif dust.action == "land" then
        if dust.tileBelow == "grass" then
            dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustLeavesSpritesheet.png")
            dust.frames = 24
            dust.speed = 3
            dust.y = dust.y - 7
            landGrassSound:play()
        elseif dust.tileBelow == "ice" then
            dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustSnowSpritesheet.png")
            dust.frames = 8
            dust.speed = 2
            dust.y = dust.y - 4
            landGrassSound:play()
        else
            dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustLandSpritesheet.png")
            dust.frames = 8
            dust.speed = 2
            landNeutralSound:play()
        end
    end

    dust.width = dust.spritesheet:getWidth() / dust.frames
    dust.height = dust.spritesheet:getHeight()
	dust.canvas = love.graphics.newCanvas(dust.width, dust.height)

	function dust:act(index)
        dust.index = index
        if dust.counter >= dust.speed then
            dust.quadSection = dust.quadSection + dust.width
            dust.counter = 0
        end
        if dust.quadSection >= dust.spritesheet:getWidth() then
            table.remove(actors, index)
        end
        dust.counter = dust.counter + 1
    end

    function dust:getX()
        return math.floor(dust.x + 0.5)
    end

    function dust:getY()
        return math.floor(dust.y + 0.5)
    end

	function dust:draw()
        love.graphics.setCanvas(dust.canvas)
        love.graphics.clear()

        love.graphics.setBackgroundColor(0, 0, 0, 0)

        dust.quad = love.graphics.newQuad(dust.quadSection, 0, dust.width, dust.height, dust.spritesheet:getWidth(), dust.spritesheet:getHeight())
        love.graphics.draw(dust.spritesheet, dust.quad)
    end

    return dust
end