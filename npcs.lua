function newNpc(npcName, npcAi, x, y, spritesheet, animationSpeed, animationFrames, width, height, attackAnimationFrames, attackXOffset, attackYOffset, attackHitFrames, attackCooldownLength, attackDistance, damage, hp, knockback, knockbackResistance, screenShakeAmount, screenShakeLength, screenFreezeLength, xAcceleration, xTerminalVelocity, enemy, money, boss, projectile, background, xVelocity, yVelocity)
	local npc = {}
	npc.uuid = math.random(2^128)
	npc.name = npcName
	npc.ai = npcAi
	npc.width = width
	npc.height = height
	npc.x = x
	npc.y = y - (npc.height - 16)
	npc.actor = "npc"

	npc.hitboxX = 0
	npc.hitboxY = 0
	npc.hitboxWidth = npc.width
	npc.hitboxHeight = npc.height

	npc.enemy = enemy
	if xVelocity == nil then
		npc.xVelocity = 0
	else
		npc.xVelocity = xVelocity
	end

	if yVelocity == nil then
		npc.yVelocity = 0
	else
		npc.yVelocity = yVelocity
	end

	npc.xAcceleration = xAcceleration
	npc.yAcceleration = 0.2
	npc.xTerminalVelocity = xTerminalVelocity
	npc.yTerminalVelocity = 8
	npc.previousXVelocity = 0

	npc.accelerating = false
	npc.sineRadians = 0

	npc.frozen = false
	npc.frozenCounter = 0
	npc.hitPlayer = false
	npc.hitPlayerCounter = 0
	npc.hitPlayerLength = 5
	npc.hit = false
	npc.hitLength = 0
	npc.grounded = false
	npc.remove = false
	npc.counter = 0

	npc.damage = damage
	npc.hp = hp
	npc.maxHp = npc.hp
	npc.knockbackStrength = knockback
	npc.knockbackResistance = knockbackResistance
	npc.screenShakeAmount = screenShakeAmount
	npc.screenShakeLength = screenShakeLength
	npc.screenFreezeLength = screenFreezeLength

	npc.moneyMin = money-(0.2*money)
	npc.moneyMax = money+(0.2*money)
	npc.money = math.floor(math.random(100*npc.moneyMin, 100*npc.moneyMax)/100 + 0.5)
	npc.boss = boss
	npc.projectile = projectile
	npc.projectileCounter = 0
	npc.background = background

	npc.knockedBack = false
	npc.healthBarDuration = 100
	npc.healthBarFadeDuration = 25
	npc.healthBarOpacity = 0
	npc.lastHitTimer = npc.healthBarDuration + npc.healthBarFadeDuration

	npc.animationSpeed = animationSpeed -- lower is faster
	npc.attackAnimationSpeed = animationSpeed
	npc.animationFrames = animationFrames
	npc.attackAnimationFrames = attackAnimationFrames
	npc.frame = 0
	npc.frameCounter = 0
	npc.baseSpritesheet = spritesheet

	if npc.ai == "walking" or npc.ai == "mushroomMonster" then
		npc.moveRightSpritesheet = npc.baseSpritesheet
		npc.moveLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."MoveLeftSpritesheet.png")
		npc.attackRightSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."AttackRightSpritesheet.png")
		npc.attackLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."AttackLeftSpritesheet.png")
		npc.attackWidth = npc.attackRightSpritesheet:getWidth() / npc.attackAnimationFrames
		npc.attackHeight = npc.attackRightSpritesheet:getHeight()
	elseif npc.ai == "diving" then
		npc.moveRightSpritesheet = npc.baseSpritesheet
		npc.moveLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."MoveLeftSpritesheet.png")
		npc.attackRightSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."AttackRightSpritesheet.png")
		npc.attackLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."AttackLeftSpritesheet.png")
		npc.diveRightSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."DiveRightSpritesheet.png")
		npc.diveLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."DiveLeftSpritesheet.png")
		npc.stuckRightSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."StuckRightSpritesheet.png")
		npc.stuckLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."StuckLeftSpritesheet.png")
		npc.attackWidth = npc.attackRightSpritesheet:getWidth() / npc.attackAnimationFrames
		npc.attackHeight = npc.attackRightSpritesheet:getHeight()
	elseif npc.ai == "shootTurret" then
		npc.idleSpritesheet = npc.baseSpritesheet
		npc.attackSpritesheet = love.graphics.newImage("images/npcs/enemy/plant/"..npc.name.."AttackSpritesheet.png")
		npc.attackWidth = npc.attackSpritesheet:getWidth() / npc.attackAnimationFrames
		npc.attackHeight = npc.attackSpritesheet:getHeight()
	elseif npc.ai == "smiley" then
		npc.attackWidth = 1
		npc.attackHeight = 1
	elseif npc.ai == "treeMonster" then
		npc.moveRightSpritesheet = npc.baseSpritesheet
		npc.moveLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."MoveLeftSpritesheet.png")
		npc.attackRightSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."MoveRightSpritesheet.png")
		npc.attackLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."MoveLeftSpritesheet.png")
		npc.attackWidth = 1
		npc.attackHeight = 1
	elseif npc.ai == "projectile" or npc.ai == "cloud" then
		npc.attackWidth = 1
		npc.attackHeight = 1
	end

	npc.attacking = false
	npc.attackCooldown = 0
	npc.attackCooldownLength = attackCooldownLength
	npc.attackXOffset = attackXOffset
	npc.attackYOffset = attackYOffset
	npc.attackHitFrames = attackHitFrames
	npc.attackDistance = attackDistance
	npc.diving = false
	npc.stuck = false

	npc.moveCounter = 0
	npc.moveQuadSection = 0
	npc.idleCounter = 0
	npc.idleQuadSection = 0
	npc.attackCounter = 0
	npc.attackQuadSection = 0
	npc.diveCounter = 0
	npc.diveQuadSection = 0
	npc.stuckCounter = 0
	npc.stuckQuadSection = 0

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

	npc.diveWidth = 18
	npc.diveHeight = 15
	npc.stuckWidth = 18
	npc.stuckHeight = 13

	npc.canvas = love.graphics.newCanvas(npc.width, npc.height)
	npc.movementCanvas = love.graphics.newCanvas(npc.width, npc.height)
	npc.attackCanvas = love.graphics.newCanvas(npc.attackWidth, npc.attackHeight)
	npc.diveCanvas = love.graphics.newCanvas(npc.diveWidth, npc.diveHeight)
	npc.stuckCanvas = love.graphics.newCanvas(npc.stuckWidth, npc.stuckHeight)

	function npc:act(index)
		npc.index = index
		if npc.frozen == false and chestOpening == false then
			npc:combatLogic(index)
			npc:movement()
			if npc.ai == "diving" then
				npc:divingAi()
				npc:flyingAi()
				if npc.diving == false and npc.stuck == false then
					npc:physics()
				end
			elseif npc.ai == "walking" then
				npc:checkGrounded()
				npc:physics()
				npc:airPhysics()
				npc:walkingAi()
			elseif npc.ai == "mushroomMonster" then
				npc:checkGrounded()
				npc:physics()
				npc:airPhysics()
				npc:walkingAi()
				npc:mushroomMonsterAi()
			elseif npc.ai == "shootTurret" then
				npc:shootTurretAi()
			elseif npc.ai == "sine" then
				npc:airPhysics()
				npc:physics()
				npc:sineAi()
			elseif npc.ai == "smiley" then
				npc:airPhysics()
				npc:physics()
				npc:smileyAi()
			elseif npc.ai == "treeMonster" then
				npc:physics()
				npc:walkingAi()
			elseif npc.ai == "projectile" then
				npc:projectileAi()
			elseif npc.ai == "cloud" then
				npc:cloudAi()
			end
			npc:animation()
		else
			if npc.frozenCounter > 0 then
				npc.frozenCounter = npc.frozenCounter - 1
			elseif npc.frozenCounter == 0 then
				npc.frozen = false
			end
		end
	end

	function npc:checkGrounded()
		if npc.attacking then
			if checkCollision(npc:getX() - npc.attackXOffset, npc:getY() - npc.attackYOffset + npc.height, npc.width, 1) then
				npc.grounded = true
				npc.yVelocity = 0
			else
				npc.grounded = false
			end
		else
			if checkCollision(npc:getX(), npc:getY() + npc.height, npc.width, 1) then
				npc.grounded = true
				npc.yVelocity = 0
			else
				npc.grounded = false
			end
		end
	end

	function npc:combatLogic(npcIndex)
		npc.lastHitTimer = npc.lastHitTimer + 1
		npc.projectileCounter = npc.projectileCounter + 1

		if (npc.hp <= 0 and npc.hit == false) or npc.x < 0-npc.width or npc.x > 480+npc.width then
			player.money = player.money + npc.money
			npc.remove = true
		end

		if npc.remove then
			table.remove(actors, npcIndex)
		end
	end

	function npc:physics()
		npc.tileLeft = ""
		npc.tileRight = ""
		npc.tileBottomLeft = ""
		npc.tileBottomRight = ""
		npc.playerLeft = false
		npc.playerRight = false

		npc.previousXVelocity = npc.xVelocity
		local minXMovement = npc.xVelocity

		if minXMovement < 0 then
			--collision to the left
			if npc.attacking then
				for _, actor in ipairs(getCollidingActors(npc:getX() - 32 - npc.attackXOffset, npc:getY() - npc.attackYOffset, 32, npc.height, true, false, true, true, false, false)) do -- 32 = 2*16 tile width
					local newXMovement = (actor.x + actor.hitboxX) + actor.hitboxWidth - npc.x - npc.attackXOffset
					if newXMovement > minXMovement then
						minXMovement = newXMovement
					end
				end
			else
				for _, actor in ipairs(getCollidingActors(npc:getX() - 32, npc:getY(), 32, npc.height, true, false, true, true, false, false)) do -- 32 = 2*16 tile width
					local newXMovement = (actor.x + actor.hitboxX) + actor.hitboxWidth - npc.x
					if newXMovement > minXMovement then
						minXMovement = newXMovement
					end
				end
			end
		else
		  --collision to the right
			if npc.attacking then
				for _, actor in ipairs(getCollidingActors(npc:getX() + npc.width - npc.attackXOffset, npc:getY() - npc.attackYOffset, 32, npc.height, true, false, true, true, false, false)) do
					local newXMovement = (actor.x + actor.hitboxX) - (npc.x + npc.width - npc.attackXOffset)
					if newXMovement < minXMovement then
						minXMovement = newXMovement
					end
				end
			else
				for _, actor in ipairs(getCollidingActors(npc:getX() + npc.width, npc:getY(), 32, npc.height, true, false, true, true, false, false)) do
					local newXMovement = (actor.x + actor.hitboxX) - (npc.x + npc.width)
					if newXMovement < minXMovement then
						minXMovement = newXMovement
					end
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
			if npc.attacking then
				for _, actor in ipairs(getCollidingActors(npc:getX() - npc.attackXOffset, npc:getY() - npc.attackYOffset + npc.height, npc.width, 32, true, true, false, true, false, false)) do
					local newYMovement = (actor.y + actor.hitboxY) - (npc.y + npc.height)
					if newYMovement < npc.yVelocity then
						minYMovement = newYMovement
					end
				end
			else
				for _, actor in ipairs(getCollidingActors(npc:getX(), npc:getY() + npc.height, npc.width, 32, true, true, false, true, false, false)) do
					local newYMovement = (actor.y + actor.hitboxY) - (npc.y + npc.height)
					if newYMovement < npc.yVelocity then
						minYMovement = newYMovement
					end
				end
			end
		else
			--collision above npc
			if npc.attacking then
				for _, actor in ipairs(getCollidingActors(npc:getX() - npc.attackXOffset, npc:getY() - npc.attackYOffset - 32, npc.width, 32, true, false, false, true, false, false)) do
					local newYMovement = (actor.y + actor.hitboxY) + actor.hitboxHeight - npc.y
					if newYMovement > npc.yVelocity then
						minYMovement = newYMovement
						npc.yVelocity = 0
					end
				end
			else
				for _, actor in ipairs(getCollidingActors(npc:getX(), npc:getY() - 32, npc.width, 32, true, false, false, true, false, false)) do
					local newYMovement = (actor.y + actor.hitboxY) + actor.hitboxHeight - npc.y
					if newYMovement > npc.yVelocity then
						minYMovement = newYMovement
						npc.yVelocity = 0
					end
				end
			end
		end

		if npc.yVelocity >= npc.yTerminalVelocity then
			npc.yVelocity = npc.yTerminalVelocity
		end

		npc.y = npc.y + minYMovement
	end

	function npc:walkingAi()
		for _, actor in ipairs(getCollidingActors(npc:getX() - 4, npc:getY(), 4, npc.height, true, false, false, true, false, false)) do
			if actor.collidable then
				npc.tileLeft = actor.name
			end
		end

		for _, actor in ipairs(getCollidingActors(npc:getX() + npc.width, npc:getY(), 4, npc.height, true, false, false, true, false, false)) do
			if actor.collidable then
				npc.tileRight = actor.name
			end
		end

		for _, actor in ipairs(getCollidingActors(npc:getX() - npc.attackDistance, npc:getY(), npc.attackDistance, npc.height, false, false, false, false, false, false, false, true)) do
			npc.playerLeft = true
		end

		for _, actor in ipairs(getCollidingActors(npc:getX() + npc.width, npc:getY(), npc.attackDistance, npc.height, false, false, false, false, false, false, false, true)) do
			npc.playerRight = true
		end

		for _, actor in ipairs(getCollidingActors(npc:getX() - 4, npc:getY() + npc.height, 4, 1, true, true, false, true, false, false)) do
			if actor.collidable or actor.platform then
				npc.tileBottomLeft = actor.name
			end
		end

		for _, actor in ipairs(getCollidingActors(npc:getX() + npc.width, npc:getY() + npc.height, 4, 1, true, true, false, true, false, false)) do
			if actor.collidable or actor.platform then
				npc.tileBottomRight = actor.name
			end
		end

		if npc.x >= 480-npc.width-8 or npc.tileRight ~= "" or (npc.direction == "right" and npc.tileBottomRight == "") then
			npc.direction = "left"
		elseif npc.x <= npc.width-8 or npc.tileLeft ~= "" or (npc.direction == "left" and npc.tileBottomLeft == "") then
			npc.direction = "right"
		end
		npc.looking = npc.direction

		if ((npc.playerLeft and npc.looking == "left") or (npc.playerRight and npc.looking == "right")) and npc.attackCooldown == 0 and npc.attacking == false then
			npc.attacking = true
			npc.x = npc.x + npc.attackXOffset
			npc.y = npc.y + npc.attackYOffset
			if npc.playerLeft then
				npc.attackDirection = "left"
			elseif npc.playerRight then
				npc.attackDirection = "right"
			end
		end

		if npc.attackCooldown > 0 then
			npc.attackCooldown = npc.attackCooldown - 1
		end

		if npc.attacking then
			npc.accelerating = false
		else
			npc.accelerating = true
		end

		local canMove = false
		if npc.ai == "mushroomMonster" then
			canMove = (npc.moveQuadSection/npc.width == 0 or npc.moveQuadSection/npc.width == 1)
		else
			canMove = true
		end
		if (npc.playerLeft and npc.looking == "left") == false and (npc.playerRight and npc.looking == "right") == false and npc.attacking == false and canMove then
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

	function npc:mushroomMonsterAi()
		if npc.attacking then
			if isInTable(npc.attackQuadSection/npc.attackWidth, npc.attackHitFrames) and npc.projectileShot == false then
				local name, ai, spritesheet, animationSpeed, animationFrames, width, height, attackAnimationFrames, attackXOffset,
					attackYOffset, attackHitFrames, attackCooldownLength, attackDistance, damage, hp, knockback, knockbackResistance,
					screenShakeAmount, screenShakeLength, screenFreezeLength, xAcceleration, xTerminalVelocity, enemy, money, boss,
					projectile, background = unpack(getNpcStats("poisonCloud"))

				table.insert(actors, newNpc(name, ai, npc.x + npc.attackWidth/2 - width/2, npc.y + npc.attackHeight/2 - height/2, spritesheet, animationSpeed, animationFrames, width, height,
					attackAnimationFrames, attackXOffset, attackYOffset, attackHitFrames, attackCooldownLength, attackDistance,	damage,
					hp, knockback, knockbackResistance, screenShakeAmount, screenShakeLength, screenFreezeLength, xAcceleration,
					xTerminalVelocity, enemy, money, boss, projectile, background, 0, 0))
				npc.projectileShot = true
			end
		else
			npc.projectileShot = false
		end
	end

	function npc:cloudAi()
		npc.counter = npc.counter + 1
		if npc.counter == 120 then
			npc.remove = true
		end
	end

	function npc:shootTurretAi()
		if npc.attackCooldown > 0 then
			npc.attackCooldown = npc.attackCooldown - 1
		end

		if npc.name == "upPlant" then
			if player.x + player.width/2 > npc.x and player.x + player.width/2 < npc.x + npc.attackWidth and player.y < npc.y and npc.attackCooldown == 0 and npc.attacking == false then
				if checkCollision(npc.x, npc.y, width, height) then
					npc.attacking = true
					npc.projectileShot = false
					npc.x = npc.x + npc.attackXOffset
					npc.y = npc.y + npc.attackYOffset
				end
			end

			if npc.attacking then
				if isInTable(npc.attackQuadSection/npc.attackWidth, npc.attackHitFrames) and npc.projectileShot == false then
					local name, ai, spritesheet, animationSpeed, animationFrames, width, height, attackAnimationFrames, attackXOffset,
						attackYOffset, attackHitFrames, attackCooldownLength, attackDistance, damage, hp, knockback, knockbackResistance,
						screenShakeAmount, screenShakeLength, screenFreezeLength, xAcceleration, xTerminalVelocity, enemy, money, boss,
						projectile, background = unpack(getNpcStats("plantProjectile"))

					table.insert(actors, newNpc(name, ai, npc.x + npc.width/2 - width/2, npc.y - height/2, spritesheet, animationSpeed,
						animationFrames, width, height, attackAnimationFrames, attackXOffset, attackYOffset, attackHitFrames, attackCooldownLength, attackDistance,
						damage, hp, knockback, knockbackResistance, screenShakeAmount, screenShakeLength, screenFreezeLength, xAcceleration, xTerminalVelocity,
						enemy, money, boss, projectile, background, 0, -2.5))
					npc.projectileShot = true
				end
			end
		elseif npc.name == "downPlant" then
			if player.x + player.width/2 > npc.x and player.x + player.width/2 < npc.x + npc.attackWidth and player.y > npc.y and npc.attackCooldown == 0 and npc.attacking == false then
				npc.attacking = true
				npc.projectileShot = false
				npc.x = npc.x + npc.attackXOffset
				npc.y = npc.y + npc.attackYOffset
			end

			if npc.attacking then
				if isInTable(npc.attackQuadSection/npc.attackWidth, npc.attackHitFrames) and npc.projectileShot == false then
					local name, ai, spritesheet, animationSpeed, animationFrames, width, height, attackAnimationFrames, attackXOffset,
						attackYOffset, attackHitFrames, attackCooldownLength, attackDistance, damage, hp, knockback, knockbackResistance,
						screenShakeAmount, screenShakeLength, screenFreezeLength, xAcceleration, xTerminalVelocity, enemy, money, boss,
						projectile, background = unpack(getNpcStats("plantProjectile"))

					table.insert(actors, newNpc(name, ai, npc.x + npc.width/2 - width/2, npc.y + npc.height - height/2, spritesheet, animationSpeed,
						animationFrames, width, height, attackAnimationFrames, attackXOffset, attackYOffset, attackHitFrames, attackCooldownLength, attackDistance,
						damage, hp, knockback, knockbackResistance, screenShakeAmount, screenShakeLength, screenFreezeLength, xAcceleration, xTerminalVelocity,
						enemy, money, boss, projectile, background, 0, 2.5))
					npc.projectileShot = true
				end
			end
		end
	end

	function npc:divingAi()
		if player.x + player.width/2 > npc.x and player.x + player.width/2 < npc.x + npc.attackWidth and player.y > npc.y and npc.attackCooldown == 0 and npc.attacking == false then
			npc.attacking = true
		end

		if npc.diving then
			for _, actor in ipairs(getCollidingActors(npc:getX(), npc:getY(), npc.width, npc.height, true, false, false, true, false, false)) do
				npc.y = actor.y - 10
				npc.stuck = true
				npc.diving = false
			end

			if npc.stuck == false then
				npc.xVelocity = 0
				npc.yVelocity = npc.yVelocity + 0.1
				npc.y = npc.y + npc.yVelocity
			end
		else
			npc.yVelocity = 0
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

		if npc.x >= 480 - npc.width - 12 or npc.tileRight ~= "" then
			npc.direction = "left"
		elseif npc.x <= npc.width - 12 or npc.tileLeft ~= "" then
			npc.direction = "right"
		end
		npc.looking = npc.direction

		if npc.attacking or npc.diving or npc.stuck then
			if npc.xVelocity > npc.xAcceleration then
				npc.xVelocity = npc.xVelocity - npc.xAcceleration
			elseif npc.xVelocity < -npc.xAcceleration then
				npc.xVelocity = npc.xVelocity + npc.xAcceleration
			else
				npc.xVelocity = 0
			end
		elseif npc.direction == "left" then
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

	function npc:smileyAi()
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
				local name, ai, spritesheet, animationSpeed, animationFrames, width, height, attackAnimationFrames, attackXOffset,
					attackYOffset, attackHitFrames, attackCooldownLength, attackDistance, damage, hp, knockback, knockbackResistance,
					screenShakeAmount, screenShakeLength, screenFreezeLength, xAcceleration, xTerminalVelocity, enemy, money, boss,
					projectile, background = unpack(getNpcStats("smileyProjectile"))
				local projectileAngle = math.atan2(npc.yVelocity, npc.xVelocity)
				local projectileDx = math.cos(projectileAngle)
				local projectileDy = math.sin(projectileAngle)

				table.insert(actors, newNpc(name, ai, npc.x + npc.width/2 - width/2, npc.y + npc.height/2 - height/2, spritesheet, animationSpeed,
					animationFrames, width, height, attackAnimationFrames, attackXOffset, attackYOffset, attackHitFrames, attackCooldownLength, attackDistance,
					damage, hp, knockback, knockbackResistance, screenShakeAmount, screenShakeLength, screenFreezeLength, xAcceleration, xTerminalVelocity,
					enemy, money, boss, projectile, background, projectileDx*3, projectileDy*3))
				npc.projectileCounter = 0
			end
		end
		npc:flyingAi()
	end

	function npc:projectileAi()
		for _, actor in ipairs(getCollidingActors(npc:getX(), npc:getY(), npc.width, npc.height, true, false, false, true, false, false)) do
			if actor.collidable then
				npc.remove = true
			end
		end
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

		npc.xPlayerDistance = player.x-npc.x
		npc.yPlayerDistance = player.y-npc.y
		npc.playerDistance = math.sqrt(npc.xPlayerDistance^2 + npc.yPlayerDistance^2)
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

		if npc.ai == "projectile" then
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
		elseif npc.ai == "shootTurret" then
			if npc.attacking then
				if npc.attackCounter >= npc.attackAnimationSpeed then
					npc.attackQuadSection = npc.attackQuadSection + npc.attackWidth
					npc.attackCounter = 0
				end
				if npc.attackQuadSection >= npc.attackWidth*npc.attackAnimationFrames then
					npc.attackQuadSection = 0
					npc.attackCounter = 0
					npc.attacking = false
					npc.attackCooldown = npc.attackCooldownLength
					npc.x = npc.x - npc.attackXOffset
					npc.y = npc.y - npc.attackYOffset
				end
				npc.attackCounter = npc.attackCounter + 1
			else
				if npc.idleCounter >= npc.animationSpeed then
					npc.idleQuadSection = npc.idleQuadSection + npc.width
					npc.idleCounter = 0
				end
				if npc.idleQuadSection >= npc.width*npc.animationFrames then
					npc.idleQuadSection = 0
					npc.idleCounter = 0
				end
				npc.idleCounter = npc.idleCounter + 1
			end
		elseif npc.ai == "walking" or npc.ai == "treeMonster" or npc.ai == "mushroomMonster" or npc.ai == "diving" then
			if npc.attacking then
				if npc.attackCounter >= npc.attackAnimationSpeed then
					npc.attackQuadSection = npc.attackQuadSection + npc.attackWidth
					npc.attackCounter = 0
				end
				if npc.attackQuadSection >= npc.attackWidth*npc.attackAnimationFrames then
					npc.attackQuadSection = 0
					npc.attackCounter = 0
					npc.attackCooldown = npc.attackCooldownLength
					npc.x = npc.x - npc.attackXOffset
					npc.y = npc.y - npc.attackYOffset
					npc.attacking = false
					if npc.ai == "diving" then
						npc.diving = true
					end
				end
				npc.attackCounter = npc.attackCounter + 1

				if npc.ai == "diving" then
					if npc.diveCounter >= npc.animationSpeed then
						npc.diveQuadSection = npc.diveQuadSection + 18
						npc.diveCounter = 0
					end
					if npc.diveQuadSection >= 18*2 then
						npc.diveQuadSection = 0
						npc.diveCounter = 0
					end
					npc.diveCounter = npc.diveCounter + 1
				end
			else
				if npc.moveCounter >= npc.animationSpeed then
					npc.moveQuadSection = npc.moveQuadSection + npc.width
					npc.moveCounter = 0
				end
				if npc.moveQuadSection >= npc.width*npc.animationFrames then
					npc.moveQuadSection = 0
					npc.moveCounter = 0
				end
				npc.moveCounter = npc.moveCounter + 1

				if npc.stuck then
					if npc.stuckCounter >= npc.animationSpeed then
						npc.stuckQuadSection = npc.stuckQuadSection + 18
						npc.stuckCounter = 0
					end
					if npc.stuckQuadSection >= 18*2 then
						npc.stuckQuadSection = 0
						npc.stuckCounter = 0
					end
					npc.stuckCounter = npc.stuckCounter + 1
				end
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
		if npc.diving then
			npc.canvas = npc.diveCanvas
		elseif npc.stuck then
			npc.canvas = npc.stuckCanvas
		elseif npc.attacking then
			npc.canvas = npc.attackCanvas
		else
			npc.canvas = npc.movementCanvas
		end
		love.graphics.setCanvas(npc.canvas)
		love.graphics.clear()
		love.graphics.setBackgroundColor(0, 0, 0, 0)

		if npc.ai == "sine" or npc.ai == "smiley" or npc.ai == "projectile" or npc.ai == "cloud" then
			npc.spritesheet = npc.baseSpritesheet
			npc.quad = npc.frameQuad
		elseif npc.ai == "walking" or npc.ai == "treeMonster" or npc.ai == "mushroomMonster" or npc.ai == "diving" then
			if npc.attacking then
				if npc.attackDirection == "left" then
					npc.spritesheet = npc.attackLeftSpritesheet
					npc.quad = love.graphics.newQuad(npc.attackQuadSection, 0, npc.attackWidth, npc.attackHeight, npc.attackWidth*npc.attackAnimationFrames, npc.attackHeight)
				else
					npc.spritesheet = npc.attackRightSpritesheet
					npc.quad = love.graphics.newQuad(npc.attackQuadSection, 0, npc.attackWidth, npc.attackHeight, npc.attackWidth*npc.attackAnimationFrames, npc.attackHeight)
				end

				if npc.ai == "diving" then
					if npc.looking == "left" then
						npc.spritesheet = npc.attackLeftSpritesheet
						npc.quad = love.graphics.newQuad(npc.attackQuadSection, 0, npc.attackWidth, npc.attackHeight, npc.attackWidth*npc.attackAnimationFrames, npc.attackHeight)
					else
						npc.spritesheet = npc.attackRightSpritesheet
						npc.quad = love.graphics.newQuad(npc.attackQuadSection, 0, npc.attackWidth, npc.attackHeight, npc.attackWidth*npc.attackAnimationFrames, npc.attackHeight)
					end
				end
			else
				if npc.looking == "left" then
					npc.spritesheet = npc.moveLeftSpritesheet
					npc.quad = love.graphics.newQuad(npc.moveQuadSection, 0, npc.width, npc.height, npc.width*npc.animationFrames, npc.height)
				else
					npc.spritesheet = npc.moveRightSpritesheet
					npc.quad = love.graphics.newQuad(npc.moveQuadSection, 0, npc.width, npc.height, npc.width*npc.animationFrames, npc.height)
				end

				if npc.diving then
					if npc.looking == "left" then
						npc.spritesheet = npc.diveLeftSpritesheet
						npc.quad = love.graphics.newQuad(npc.diveQuadSection, 0, npc.diveWidth, npc.diveHeight, npc.diveWidth*2, npc.diveHeight)
					else
						npc.spritesheet = npc.diveRightSpritesheet
						npc.quad = love.graphics.newQuad(npc.diveQuadSection, 0, npc.diveWidth, npc.diveHeight, npc.diveWidth*2, npc.diveHeight)
					end
				elseif npc.stuck then
					if npc.looking == "left" then
						npc.spritesheet = npc.stuckLeftSpritesheet
						npc.quad = love.graphics.newQuad(npc.stuckQuadSection, 0, npc.stuckWidth, npc.stuckHeight, npc.stuckWidth*2, npc.stuckHeight)
					else
						npc.spritesheet = npc.stuckRightSpritesheet
						npc.quad = love.graphics.newQuad(npc.stuckQuadSection, 0, npc.stuckWidth, npc.stuckHeight, npc.stuckWidth*2, npc.stuckHeight)
					end
				end
			end
		elseif npc.ai == "shootTurret" then
			if npc.attacking then
				npc.spritesheet = npc.attackSpritesheet
				npc.quad = love.graphics.newQuad(npc.attackQuadSection, 0, npc.attackWidth, npc.attackHeight, npc.attackWidth*npc.attackAnimationFrames, npc.attackHeight)
			else
				npc.spritesheet = npc.idleSpritesheet
				npc.quad = love.graphics.newQuad(npc.idleQuadSection, 0, npc.width, npc.height, npc.width*npc.animationFrames, npc.height)
			end
		end
		love.graphics.draw(npc.spritesheet, npc.quad)

		if npc.hitPlayer then
			npc.hitPlayerLength = npc.hitPlayerLength - 1
		end
		if npc.hitPlayerCounter <= 0 then
			npc.hitPlayer = false
		end

		if npc.hit then
			npc.hitLength = npc.hitLength - 1
		end
		if npc.hitLength <= 0 then
			npc.hit = false
		end
		if npc.hitPlayer then
			npc.image = convertColor(npc.canvas, 1, 1, 1, 1)
			love.graphics.clear()
			love.graphics.draw(npc.image)
		end

		if npc.hit then
			npc.image = convertColor(npc.canvas, 0, 0, 0, 1)
			love.graphics.clear()
			love.graphics.draw(npc.image)
		end
	end

	return npc
end