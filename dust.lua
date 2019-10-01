function getDustImages()
	sparkle1Spritesheet = love.graphics.newImage("images/dust/sparkle1.png")
	sparkle2Spritesheet = love.graphics.newImage("images/dust/sparkle2.png")

	particle1Spritesheet = love.graphics.newImage("images/dust/particle1.png")
	particle2Spritesheet = love.graphics.newImage("images/dust/particle2.png")

	dirtImpactSpritesheet = love.graphics.newImage("images/dust/dirtImpact.png")

	die1Spritesheet = love.graphics.newImage("images/dust/die1.png")
	die2Spritesheet = love.graphics.newImage("images/dust/die2.png")
	die3Spritesheet = love.graphics.newImage("images/dust/die3.png")

	poison1Spritesheet = love.graphics.newImage("images/dust/poison1.png")
	poison2Spritesheet = love.graphics.newImage("images/dust/poison2.png")

	flame1Spritesheet = love.graphics.newImage("images/dust/flame1.png")
	flame2Spritesheet = love.graphics.newImage("images/dust/flame2.png")

	jumpSpritesheet = love.graphics.newImage("images/dust/player/jump.png")
	landSpritesheet = love.graphics.newImage("images/dust/player/land.png")
	runRightSpritesheet = love.graphics.newImage("images/dust/player/runRight.png")
	runLeftSpritesheet = love.graphics.newImage("images/dust/player/runLeft.png")

	grassJumpSpritesheet = love.graphics.newImage("images/dust/player/grassJump.png")
	grassLandSpritesheet = love.graphics.newImage("images/dust/player/grassLand.png")
	grassRunRightSpritesheet = love.graphics.newImage("images/dust/player/grassRunRight.png")
	grassRunLeftSpritesheet = love.graphics.newImage("images/dust/player/grassRunLeft.png")
end

function newDust(x, y, action, direction, tileBelow)
	local dust = {}
	dust.x = x
	dust.y = y
	dust.action = action
	dust.direction = direction
	dust.tileBelow = tileBelow
	dust.counter = 0
	dust.frame = 1
	dust.quads = {}
	dust.actor = "dust"

	if dust.action == "sparkle" then
		local number = math.random(2)
		if number == 1 then
			dust.spritesheet = sparkle1Spritesheet
			dust.frames = 3
			dust.speed = 6
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		else
			dust.spritesheet = sparkle2Spritesheet
			dust.frames = 4
			dust.speed = 6
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		end	
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = false
	elseif dust.action == "particle" then
		local number = math.random(2)
		if number == 1 then
			dust.spritesheet = particle1Spritesheet
			dust.frames = 1
			dust.speed = 4
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		else
			dust.spritesheet = particle2Spritesheet
			dust.frames = 2
			dust.speed = 4
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		end	
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = false
	elseif dust.action == "dirtImpact" then
		dust.spritesheet = dirtImpactSpritesheet
		dust.frames = 5
		dust.speed = 4
		dust.width = dust.spritesheet:getWidth() / dust.frames
		dust.height = dust.spritesheet:getHeight()
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = true
	elseif dust.action == "die1" then
		dust.spritesheet = die1Spritesheet
		dust.frames = 6
		dust.speed = 4
		dust.width = dust.spritesheet:getWidth() / dust.frames
		dust.height = dust.spritesheet:getHeight()
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = false
	elseif dust.action == "die2" then
		dust.spritesheet = die2Spritesheet
		dust.frames = 6
		dust.speed = 4
		dust.width = dust.spritesheet:getWidth() / dust.frames
		dust.height = dust.spritesheet:getHeight()
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = false
	elseif dust.action == "die3" then
		dust.spritesheet = die3Spritesheet
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
			dust.spritesheet = poison1Spritesheet
			dust.frames = 8
			dust.speed = 6
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		else
			dust.spritesheet = poison2Spritesheet
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
			dust.spritesheet = flame1Spritesheet
			dust.frames = 5
			dust.speed = 6
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		else
			dust.spritesheet = flame2Spritesheet
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
				dust.spritesheet = grassRunLeftSpritesheet
				dust.frames = 4
				dust.speed = 4
				dust.width = dust.spritesheet:getWidth() / dust.frames
				dust.height = dust.spritesheet:getHeight()
				dust.x = dust.x + dust.width
				dust.y = dust.y + 0
				dust.background = true
				runGrassSound:play()
			else
				dust.spritesheet = runLeftSpritesheet
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
				dust.spritesheet = grassRunRightSpritesheet
				dust.frames = 4
				dust.speed = 4
				dust.width = dust.spritesheet:getWidth() / dust.frames
				dust.height = dust.spritesheet:getHeight()
				dust.x = dust.x + 0
				dust.y = dust.y + 0
				dust.background = true
				runGrassSound:play()
			else
				dust.spritesheet = runRightSpritesheet
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
			dust.spritesheet = grassJumpSpritesheet
			dust.frames = 4
			dust.speed = 4
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
			dust.x = dust.x + dust.width/2
			dust.y = dust.y + 0
			dust.background = true
			jumpNeutralSound:play()
		else
			dust.spritesheet = jumpSpritesheet
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
			dust.spritesheet = grassLandSpritesheet
			dust.frames = 4
			dust.speed = 4
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
			dust.x = dust.x + dust.width/2
			dust.y = dust.y + 0
			dust.background = true
			landGrassSound:play()
		else
			dust.spritesheet = landSpritesheet
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

	if dust.frames > 1 then
		for i = 1, dust.frames do
			table.insert(dust.quads, love.graphics.newQuad(dust.width*(i - 1), 0, dust.width, dust.height, dust.spritesheet:getWidth(), dust.spritesheet:getHeight()))
		end
	end

	dust.x = dust.x - dust.width
	dust.y = dust.y - dust.height
	dust.canvas = love.graphics.newCanvas(dust.width, dust.height)

	function dust:act(index)
		dust.index = index
		if dust.counter == dust.speed then
			if dust.frame == dust.frames then
				table.remove(actors, index)
			else
				dust.frame = dust.frame + 1
			end
			dust.counter = 0
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

		if dust.frames > 1 then
			love.graphics.draw(dust.spritesheet, dust.quads[dust.frame])
		else
			love.graphics.draw(dust.spritesheet)
		end
	end

	return dust
end