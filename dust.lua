function getDustImages()
	sparkle1Spritesheet = love.graphics.newImage("images/dust/sparkle1.png")
	sparkle1Quads = getQuads(sparkle1Spritesheet, 3)
	sparkle2Spritesheet = love.graphics.newImage("images/dust/sparkle2.png")
	sparkle2Quads = getQuads(sparkle2Spritesheet, 4)

	particle1Spritesheet = love.graphics.newImage("images/dust/particle1.png")
	-- only one frame, doesn't need quads
	particle2Spritesheet = love.graphics.newImage("images/dust/particle2.png")
	particle2Quads = getQuads(particle2Spritesheet, 2)

	dirtImpactSpritesheet = love.graphics.newImage("images/dust/dirtImpact.png")
	dirtImpactQuads = getQuads(dirtImpactSpritesheet, 5)

	die1Spritesheet = love.graphics.newImage("images/dust/die1.png")
	die1Quads = getQuads(die1Spritesheet, 6)
	die2Spritesheet = love.graphics.newImage("images/dust/die2.png")
	die2Quads = getQuads(die2Spritesheet, 6)
	die3Spritesheet = love.graphics.newImage("images/dust/die3.png")
	die3Quads = getQuads(die3Spritesheet, 6)

	poison1Spritesheet = love.graphics.newImage("images/dust/poison1.png")
	poison1Quads = getQuads(poison1Spritesheet, 8)
	poison2Spritesheet = love.graphics.newImage("images/dust/poison2.png")
	poison2Quads = getQuads(poison2Spritesheet, 7)

	flame1Spritesheet = love.graphics.newImage("images/dust/flame1.png")
	flame1Quads = getQuads(flame1Spritesheet, 5)
	flame2Spritesheet = love.graphics.newImage("images/dust/flame2.png")
	flame2Quads = getQuads(flame2Spritesheet, 5)

	jumpSpritesheet = love.graphics.newImage("images/dust/player/jump.png")
	jumpQuads = getQuads(jumpSpritesheet, 3)
	landSpritesheet = love.graphics.newImage("images/dust/player/land.png")
	landQuads = getQuads(landSpritesheet, 5)
	runRightSpritesheet = love.graphics.newImage("images/dust/player/runRight.png")
	runLeftSpritesheet = love.graphics.newImage("images/dust/player/runLeft.png")
	runQuads = getQuads(runRightSpritesheet, 3)

	grassJumpSpritesheet = love.graphics.newImage("images/dust/player/grassJump.png")
	grassJumpQuads = getQuads(grassJumpSpritesheet, 4)
	grassLandSpritesheet = love.graphics.newImage("images/dust/player/grassLand.png")
	grassLandQuads = getQuads(grassLandSpritesheet, 4)
	grassRunRightSpritesheet = love.graphics.newImage("images/dust/player/grassRunRight.png")
	grassRunLeftSpritesheet = love.graphics.newImage("images/dust/player/grassRunLeft.png")
	grassRunQuads = getQuads(grassRunRightSpritesheet, 4)
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
	dust.actor = "dust"

	if dust.action == "sparkle" then
		local number = math.random(2)
		if number == 1 then
			dust.spritesheet = sparkle1Spritesheet
			dust.quads = sparkle1Quads
			dust.frames = 3
			dust.speed = 6
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		else
			dust.spritesheet = sparkle2Spritesheet
			dust.quads = sparkle2Quads
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
			dust.quads = {}
			dust.frames = 1
			dust.speed = 4
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		else
			dust.spritesheet = particle2Spritesheet
			dust.quads = particle2Quads
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
		dust.quads = dirtImpactQuads
		dust.frames = 5
		dust.speed = 4
		dust.width = dust.spritesheet:getWidth() / dust.frames
		dust.height = dust.spritesheet:getHeight()
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = true
	elseif dust.action == "die1" then
		dust.spritesheet = die1Spritesheet
		dust.quads = die1Quads
		dust.frames = 6
		dust.speed = 4
		dust.width = dust.spritesheet:getWidth() / dust.frames
		dust.height = dust.spritesheet:getHeight()
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = false
	elseif dust.action == "die2" then
		dust.spritesheet = die2Spritesheet
		dust.quads = die2Quads
		dust.frames = 6
		dust.speed = 4
		dust.width = dust.spritesheet:getWidth() / dust.frames
		dust.height = dust.spritesheet:getHeight()
		dust.x = dust.x + dust.width/2
		dust.y = dust.y + dust.height/2
		dust.background = false
	elseif dust.action == "die3" then
		dust.spritesheet = die3Spritesheet
		dust.quads = die3Quads
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
			dust.quads = poison1Quads
			dust.frames = 8
			dust.speed = 6
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		else
			dust.spritesheet = poison2Spritesheet
			dust.quads = poison2Quads
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
			dust.quads = flame1Quads
			dust.frames = 5
			dust.speed = 6
			dust.width = dust.spritesheet:getWidth() / dust.frames
			dust.height = dust.spritesheet:getHeight()
		else
			dust.spritesheet = flame2Spritesheet
			dust.quads = flame2Quads
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
				dust.quads = grassRunQuads
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
				dust.quads = runQuads
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
				dust.quads = grassRunQuads
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
				dust.quads = runQuads
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
			dust.quads = grassJumpQuads
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
			dust.quads = jumpQuads
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
			dust.quads = grassLandQuads
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
			dust.quads = landQuads
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