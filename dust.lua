function newDust(x, y, action, direction, tileBelow)
	local dust = {}
	dust.x = x
	dust.y = y
	dust.action = action
	dust.direction = direction
	dust.tileBelow = tileBelow
	dust.counter = 0
	dust.quadSection = 0
	dust.actor = "dust"

	if dust.action == "sparkles" then
		local number = math.random(2)
		if number == 1 then
			dust.spritesheet = love.graphics.newImage("images/dust/sparkles1.png")
			dust.frames = 3
			dust.speed = 6
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		else
			dust.spritesheet = love.graphics.newImage("images/dust/sparkles2.png")
			dust.frames = 4
			dust.speed = 6
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		end	
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = false
	elseif dust.action == "dirtImpact" then
		dust.spritesheet = love.graphics.newImage("images/dust/dirtImpact.png")
		dust.frames = 5
		dust.speed = 4
		dust.width = dust.spritesheet:getWidth() / dust.frames
		dust.height = dust.spritesheet:getHeight()
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = true
	elseif dust.action == "die1" then
		dust.spritesheet = love.graphics.newImage("images/dust/die1.png")
		dust.frames = 6
		dust.speed = 4
		dust.width = dust.spritesheet:getWidth() / dust.frames
		dust.height = dust.spritesheet:getHeight()
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = false
	elseif dust.action == "die2" then
		dust.spritesheet = love.graphics.newImage("images/dust/die2.png")
		dust.frames = 6
		dust.speed = 4
		dust.width = dust.spritesheet:getWidth() / dust.frames
		dust.height = dust.spritesheet:getHeight()
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = false
	elseif dust.action == "die3" then
		dust.spritesheet = love.graphics.newImage("images/dust/die3.png")
		dust.frames = 6
		dust.speed = 4
		dust.width = dust.spritesheet:getWidth() / dust.frames
		dust.height = dust.spritesheet:getHeight()
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = false
	elseif dust.action == "poison" then
		local number = math.random(2)
		if number == 1 then
			dust.spritesheet = love.graphics.newImage("images/dust/poison1.png")
			dust.frames = 8
			dust.speed = 6
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		else
			dust.spritesheet = love.graphics.newImage("images/dust/poison2.png")
			dust.frames = 7
			dust.speed = 6
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		end	
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = false
	elseif dust.action == "flame" then
		local number = math.random(2)
		if number == 1 then
			dust.spritesheet = love.graphics.newImage("images/dust/flame1.png")
			dust.frames = 5
			dust.speed = 6
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		else
			dust.spritesheet = love.graphics.newImage("images/dust/flame2.png")
			dust.frames = 5
			dust.speed = 6
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		end	
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = false
	elseif dust.action == "run" then
		if dust.direction == "left" then
			if dust.tileBelow == "grass" then
				dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustGrassRunLeftSpritesheet.png")
				dust.frames = 4
				dust.speed = 4
				dust.width = dust.spritesheet:getWidth() / dust.frames
				dust.height = dust.spritesheet:getHeight()
				dust.x = dust.x + dust.width
				dust.y = dust.y + 0
				dust.background = true
				runGrassSound:play()
			else
				dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustRunLeftSpritesheet.png")
				dust.frames = 3
				dust.speed = 3
				dust.width = dust.spritesheet:getWidth() / dust.frames
				dust.height = dust.spritesheet:getHeight()
				dust.x = dust.x + dust.width
				dust.y = dust.y + 0
				dust.background = true
				runNeutralSound:play()
			end
		else
			if dust.tileBelow == "grass" then
				dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustGrassRunRightSpritesheet.png")
				dust.frames = 4
				dust.speed = 4
				dust.width = dust.spritesheet:getWidth() / dust.frames
				dust.height = dust.spritesheet:getHeight()
				dust.x = dust.x + 0
				dust.y = dust.y + 0
				dust.background = true
				runGrassSound:play()
			else
				dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustRunRightSpritesheet.png")
				dust.frames = 3
				dust.speed = 3
				dust.width = dust.spritesheet:getWidth() / dust.frames
				dust.height = dust.spritesheet:getHeight()
				dust.x = dust.x + 0
				dust.y = dust.y + 0
				dust.background = true
				runNeutralSound:play()
			end
		end
	elseif dust.action == "jump" then
		if dust.tileBelow == "grass" then
			dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustGrassJumpSpritesheet.png")
			dust.frames = 4
			dust.speed = 4
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
			dust.x = dust.x + dust.width/2
			dust.y = dust.y + 0
			dust.background = true
			jumpNeutralSound:play()
		else
			dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustJumpSpritesheet.png")
			dust.frames = 3
			dust.speed = 3
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
			dust.x = dust.x + dust.width/2
			dust.y = dust.y + 0
			dust.background = true
			jumpNeutralSound:play()
		end
	elseif dust.action == "land" then
		if dust.tileBelow == "grass" then
			dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustGrassLandSpritesheet.png")
			dust.frames = 4
			dust.speed = 4
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
			dust.x = dust.x + dust.width/2
			dust.y = dust.y + 0
			dust.background = true
			landGrassSound:play()
		else
			dust.spritesheet = love.graphics.newImage("images/dust/player/playerDustLandSpritesheet.png")
			dust.frames = 5
			dust.speed = 3
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
			dust.x = dust.x + dust.width/2
			dust.y = dust.y + 0
			dust.background = true
			landNeutralSound:play()
		end
	end
	dust.x = dust.x - dust.width
	dust.y = dust.y - dust.height
	dust.canvas = love.graphics.newCanvas(dust.width, dust.height)

	function dust:act(index)
		dust.index = index
		if dust.counter >= dust.speed then
			dust.quadSection = dust.quadSection + dust.width
			dust.counter = 0
		end
		if dust.quadSection > dust.spritesheet:getWidth() - dust.width then
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
		if dust.quadSection < dust.spritesheet:getWidth() then
			love.graphics.draw(dust.spritesheet, dust.quad)
		end
	end

	return dust
end