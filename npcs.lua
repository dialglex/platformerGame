function newNpc(x, y, xVelocity, yVelocity, stats, invincibility)
	local npc = {}
	npc.uuid = math.random(2^128)
	npc.name = stats.name
	npc.ai = stats.ai
	npc.actor = "npc"

	npc.xVelocity = xVelocity
	npc.yVelocity = yVelocity
	npc.xAcceleration = stats.xAcceleration
	npc.xTerminalVelocity = stats.xTerminalVelocity
	npc.yAcceleration = stats.yAcceleration
	npc.yTerminalVelocity = stats.yTerminalVelocity
	npc.previousXVelocity = 0
	npc.sineRadians = 0

	npc.baseXAcceleration = stats.xAcceleration
	npc.baseXTerminalVelocity = stats.xTerminalVelocity
	npc.baseYAcceleration = stats.yAcceleration
	npc.baseYTerminalVelocity = stats.yTerminalVelocity

	npc.hitPlayer = false
	npc.hit = false
	npc.grounded = false
	npc.remove = false
	npc.counter = 0
	npc.projectile = stats.projectile
	npc.projectileCounter = 0
	npc.enemy = stats.enemy
	npc.boss = stats.boss
	npc.damage = stats.damage
	npc.hp = stats.hp
	npc.maxHp = npc.hp
	npc.previousHp = npc.hp
	npc.knockbackStrength = stats.knockback
	npc.knockbackResistance = stats.knockbackResistance
	npc.screenShakeAmount = stats.screenShakeAmount
	npc.screenShakeLength = stats.screenShakeLength
	npc.screenFreezeLength = stats.screenFreezeLength
	npc.poison = 0
	npc.poisonCounter = 0
	npc.lastPoisonDuration = 0
	npc.burn = 0
	npc.burnCounter = 0
	npc.lastBurnDuration = 0
	npc.background = stats.background

	local moneyMin = stats.money-(0.2*stats.money)
	local moneyMax = stats.money+(0.2*stats.money)
	npc.money = math.floor(math.random(100*moneyMin, 100*moneyMax)/100 + 0.5)

	npc.knockedBack = false
	npc.healthBarDuration = 100
	npc.healthBarFadeDuration = 25
	npc.healthBarOpacity = 0
	npc.lastHitTimer = 0
	npc.lastDamagedTimer = npc.healthBarDuration + npc.healthBarFadeDuration

	npc.animationSpeed = stats.animationSpeed
	npc.attackAnimationSpeed = stats.attackAnimationSpeed
	npc.animationFrames = stats.animationFrames
	npc.attackAnimationFrames = stats.attackAnimationFrames
	npc.frame = 0
	npc.frameCounter = 0
	npc.baseSpritesheet = stats.spritesheet
	npc.width = npc.baseSpritesheet:getWidth() / npc.animationFrames
	npc.height = npc.baseSpritesheet:getHeight()
	npc.x = x
	npc.y = y - (npc.height - 16)
	if npc.ai == "walking" or npc.ai == "mushroomMonster" or npc.ai == "acornKing" then
		npc.moveRightSpritesheet = npc.baseSpritesheet
		npc.moveLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."MoveLeftSpritesheet.png")
		npc.attackRightSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."AttackRightSpritesheet.png")
		npc.attackLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/"..npc.name.."/"..npc.name.."AttackLeftSpritesheet.png")
		if npc.name == "acorn" then
			npc.hoverRightSpritesheet = love.graphics.newImage("images/npcs/enemy/acorn/acornHoverRightSpritesheet.png")
			npc.hoverLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/acorn/acornHoverLeftSpritesheet.png")
		end
		npc.attackWidth = npc.attackRightSpritesheet:getWidth() / npc.attackAnimationFrames
		npc.attackHeight = npc.attackRightSpritesheet:getHeight()
	elseif npc.ai == "flying" then
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
	elseif npc.ai == "projectile" or npc.ai == "cloud" then
		if npc.name == "acornProjectile" then
			npc.rotation1Spritesheet = npc.baseSpritesheet
			npc.rotation2Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile2.png")
			npc.rotation3Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile3.png")
			npc.rotation4Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile4.png")
			npc.rotation5Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile5.png")
			npc.rotation6Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile6.png")
			npc.rotation7Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile7.png")
			npc.rotation8Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile8.png")
		end
		npc.attackWidth = 1
		npc.attackHeight = 1
	end
	npc.rotation = 1
	npc.hitboxX = stats.hitboxX
	npc.hitboxY = stats.hitboxY
	npc.hitboxWidth = stats.hitboxWidth
	npc.hitboxHeight = stats.hitboxHeight

	npc.attackHitboxX = stats.attackHitboxX
	npc.attackHitboxY = stats.attackHitboxY
	npc.attackHitboxWidth = stats.attackHitboxWidth
	npc.attackHitboxHeight = stats.attackHitboxHeight

	npc.attacking = false
	npc.attackCooldown = 0
	npc.attackCooldownLength = stats.attackCooldownLength
	if npc.name == "fuzzy" then
		npc.leftAttackXOffset = 0
		npc.rightAttackXOffset = 0
	else
		npc.leftAttackXOffset = (npc.width - npc.hitboxWidth - npc.hitboxX) - (npc.attackWidth - npc.attackHitboxWidth - npc.attackHitboxX)
		npc.rightAttackXOffset = (npc.hitboxX + npc.hitboxWidth) - (npc.attackHitboxWidth + npc.attackHitboxX)
	end
	npc.attackYOffset = stats.attackYOffset
	npc.attackHitFrames = stats.attackHitFrames
	npc.attackDistance = stats.attackDistance
	npc.wallDistance = stats.wallDistance
	npc.towardsPlayer = stats.towardsPlayer
	npc.canTurn = true
	npc.diving = false
	npc.stuck = false
	npc.canMove = false
	npc.wallCollision = false
	npc.moveForward = 0
	npc.lastTurnCounter = 10
	npc.idle = false
	if invincibility ~= nil then
		npc.invincibility = invincibility
	else
		npc.invincibility = 0
	end

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
	npc.hoverCounter = 0
	npc.hoverQuadSection = 0

	npc.xPlayerDistance = 0
	npc.yPlayerDistance = 0
	npc.playerDistance = 0

	-- local randomNumber = math.random(2)
	local randomNumber = 1
	if randomNumber == 1 then
		npc.direction = "left"
	else
		npc.direction = "right"
	end

	npc.diveWidth = 18
	npc.diveHeight = 15
	npc.stuckWidth = 18
	npc.stuckHeight = 13
	npc.hoverWidth = 28
	npc.hoverHeight = 25

	npc.canvas = love.graphics.newCanvas(npc.width, npc.height)
	npc.movementCanvas = love.graphics.newCanvas(npc.width, npc.height)
	npc.attackCanvas = love.graphics.newCanvas(npc.attackWidth, npc.attackHeight)
	npc.diveCanvas = love.graphics.newCanvas(npc.diveWidth, npc.diveHeight)
	npc.stuckCanvas = love.graphics.newCanvas(npc.stuckWidth, npc.stuckHeight)
	npc.hoverCanvas = love.graphics.newCanvas(npc.hoverWidth, npc.hoverHeight)

	function npc:act(index)
		npc.index = index
		if chestOpening == false then
			npc.counter = npc.counter + 1
			npc:combatLogic(index)
			npc:movement()
			if npc.ai == "diving" then
				npc:divingAi()
				npc:flyingAi()
				if npc.diving == false and npc.stuck == false then
					npc:physics()
				end
			elseif npc.ai == "flying" then
				npc:flyingAi()
				npc:physics()
			elseif npc.ai == "walking" then
				npc:checkGrounded()
				npc:physics()
				npc:airPhysics()
				npc:walkingAi() -- its in walkingAi
			elseif npc.ai == "acornKing" then
				npc:checkGrounded()
				npc:physics()
				npc:airPhysics()
				npc:acornKingAi()
			elseif npc.ai == "mushroomMonster" then
				npc:checkGrounded()
				npc:physics()
				npc:airPhysics()
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
			elseif npc.ai == "projectile" then
				npc:projectileAi()
			elseif npc.ai == "cloud" then
				npc:cloudAi()
			end
			npc:animation()
		end
	end

	function npc:checkGrounded()
		if npc.attacking then
			if npc.direction == "left" then
				if checkCollision(npc:getX() + (npc.attackWidth - npc.attackHitboxWidth - npc.attackHitboxX), npc:getY() + npc.attackHitboxY + npc.attackHitboxHeight, npc.attackHitboxWidth, 1, true, false) then
					npc.grounded = true
					npc.yVelocity = 0
				else
					npc.grounded = false
				end
			elseif npc.direction == "right" then
				if checkCollision(npc:getX() + npc.attackHitboxX, npc:getY() + npc.attackHitboxY + npc.attackHitboxHeight, npc.attackHitboxWidth, 1, true, false) then
					npc.grounded = true
					npc.yVelocity = 0
				else
					npc.grounded = false
				end
			end
		else
			if npc.direction == "left" then
				if checkCollision(npc:getX() + (npc.width - npc.hitboxWidth - npc.hitboxX), npc:getY() + npc.hitboxY + npc.hitboxHeight, npc.hitboxWidth, 1, true, false) then
					npc.grounded = true
					npc.yVelocity = 0
				else
					npc.grounded = false
				end
			elseif npc.direction == "right" then
				if checkCollision(npc:getX() + npc.hitboxX, npc:getY() + npc.hitboxY + npc.hitboxHeight, npc.hitboxWidth, 1, true, false) then
					npc.grounded = true
					npc.yVelocity = 0
				else
					npc.grounded = false
				end
			end
		end
	end

	function npc:combatLogic(npcIndex)
		if npc.invincibility > 0 then
			npc.invincibility = npc.invincibility - 1
		end

		if npc.hit == false and npc.lastHitTimer > 1 then
			if npc.poison > 0 or npc.burn > 0 then
				npc.previousHp = npc.hp
				npc.lastDamagedTimer = 0
			end
			
			if npc.poison > 0 then
				if isInTable("poisonDamage", player.accessories) and npc.poison > 0 then
					npc.hp = npc.hp - 1/6*player.damageBuff*1.5
				else
					npc.hp = npc.hp - 1/6*player.damageBuff
				end
				npc.poison = npc.poison - 1
			end
			if npc.burn > 0 then
				if isInTable("poisonDamage", player.accessories) and npc.poison > 0 then
					npc.hp = npc.hp - 1/3*player.damageBuff*1.5
				else
					npc.hp = npc.hp - 1/3*player.damageBuff
				end
				npc.burn = npc.burn - 1
			end
		end

		if (npc.hp <= 0 and npc.hit == false) or npc.x < 0 - npc.width or npc.x > 480 + npc.width then
			npc.remove = true
		end

		if npc.remove then
			if npc.projectile == false then
				if npc.boss then
					for i, npc in ipairs(npcs) do
						if npc.enemy then
							npc.remove = true
						end
					end
					white = 1.2
					player.hp = player.maxHp
				end

				for i = 1, npc.money do
					local stats = getItemStats("coin")
					table.insert(actors, newItem("coin", npc.x + npc.width/2, npc.y + npc.height/2, stats))
				end

				if isInTable("lifeFruit", player.accessories) then
					player.hp = player.hp + 5
				end

				local x
				local y
				if npc.attacking then
					if npc.direction == "left" then
						x = npc.x + (npc.attackWidth - npc.attackHitboxWidth - npc.attackHitboxX) + npc.attackHitboxWidth/2
					else
						x = npc.x + npc.attackHitboxX + npc.attackHitboxWidth/2
					end
					y = npc.y + npc.attackHitboxY + npc.attackHitboxHeight/2
				else
					if npc.direction == "left" then
						x = npc.x + (npc.width - npc.hitboxWidth - npc.hitboxX) + npc.hitboxWidth/2
					else
						x = npc.x + npc.hitboxX + npc.hitboxWidth/2
					end
					y = npc.y + npc.hitboxY + npc.hitboxHeight/2
				end

				if npc.width*npc.height <= 20^2 then -- 16 - from 0 to 20
					table.insert(actors, newDust(x, y, "die1"))
				elseif npc.width*npc.height <= 28^2 then -- 24 - from 20 to 28
					table.insert(actors, newDust(x, y, "die2"))
				else -- 32 - from 28 to infinity
					table.insert(actors, newDust(x, y, "die3"))
				end
			else
				if npc.name ~= "poisonCloud" then
					table.insert(actors, newDust(npc.x + npc.width/2, npc.y + npc.height/2, "dirtImpact"))
				end
			end

			table.remove(actors, npcIndex)
		end

		if npc.poison > 0 and isInTable("virus", player.accessories) then
			for _, actor in ipairs(getCollidingActors(npc:getX(), npc:getY(), npc.width, npc.height, false, false, false, false, true, false, false, false)) do
				if actor ~= npc and actor.projectile == false then
					actor.poison = npc.lastPoisonDuration
					actor.lastPoisonDuration = actor.poison
				end
			end
		end

		npc.lastHitTimer = npc.lastHitTimer + 1
		npc.lastDamagedTimer = npc.lastDamagedTimer + 1
		npc.projectileCounter = npc.projectileCounter + 1
	end

	function npc:physics()
		npc.wallCollision = false
		npc.previousXVelocity = npc.xVelocity
		local minXMovement = npc.xVelocity
		if minXMovement < 0 then
			--collision to the left
			if npc.attacking then
				for _, actor in ipairs(getCollidingActors(npc:getX() - 32 + (npc.attackWidth - npc.attackHitboxWidth - npc.attackHitboxX), npc:getY() + npc.attackHitboxY, 32, npc.attackHitboxHeight, true, false, true, true, false, false)) do -- 32 = 2*16 tile width
					local newXMovement = (actor.x + actor.hitboxX) + actor.hitboxWidth - (npc.x + (npc.attackWidth - npc.attackHitboxWidth - npc.attackHitboxX))
					if newXMovement > minXMovement then
						minXMovement = newXMovement
						npc.xVelocity = 0
						npc.wallCollision = true
					end
				end
			else
				for _, actor in ipairs(getCollidingActors(npc:getX() - 32 + (npc.width - npc.hitboxWidth - npc.hitboxX), npc:getY() + npc.hitboxY, 32, npc.hitboxHeight, true, false, true, true, false, false)) do -- 32 = 2*16 tile width
					local newXMovement = (actor.x + actor.hitboxX) + actor.hitboxWidth - (npc.x + (npc.width - npc.hitboxWidth - npc.hitboxX))
					if newXMovement > minXMovement then
						minXMovement = newXMovement
						npc.xVelocity = 0
						npc.wallCollision = true
					end
				end
			end
		elseif minXMovement > 0 then
		  --collision to the right
			if npc.attacking then
				for _, actor in ipairs(getCollidingActors(npc:getX() + npc.attackHitboxX + npc.attackHitboxWidth, npc:getY() + npc.attackHitboxY, 32, npc.attackHitboxHeight, true, false, true, true, false, false)) do
					local newXMovement = (actor.x + actor.hitboxX) - (npc.x + npc.attackHitboxX + npc.attackHitboxWidth)
					if newXMovement < minXMovement then
						minXMovement = newXMovement
						npc.xVelocity = 0
						npc.wallCollision = true
					end
				end
			else
				for _, actor in ipairs(getCollidingActors(npc:getX() + npc.hitboxX + npc.hitboxWidth, npc:getY() + npc.hitboxY, 32, npc.hitboxHeight, true, false, true, true, false, false)) do
					local newXMovement = (actor.x + actor.hitboxX) - (npc.x + npc.hitboxX + npc.hitboxWidth)
					if newXMovement < minXMovement then
						minXMovement = newXMovement
						npc.xVelocity = 0
						npc.wallCollision = true
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
				for _, actor in ipairs(getCollidingActors(npc:getX() + (npc.attackWidth - npc.attackHitboxWidth - npc.attackHitboxX), npc:getY() + npc.attackHitboxY + npc.attackHitboxHeight, npc.attackHitboxWidth, 32, true, true, true, true, false, false)) do
					local newYMovement = (actor.y + actor.hitboxY) - (npc.y + npc.attackHitboxY + npc.attackHitboxHeight)
					if newYMovement < npc.yVelocity then
						minYMovement = newYMovement
					end
				end
			else
				for _, actor in ipairs(getCollidingActors(npc:getX() + (npc.width - npc.hitboxWidth - npc.hitboxX), npc:getY() + npc.attackHitboxY + npc.attackHitboxHeight, npc.hitboxWidth, 32, true, true, true, true, false, false)) do
					local newYMovement = (actor.y + actor.hitboxY) - (npc.y + npc.hitboxY + npc.hitboxHeight)
					if newYMovement < npc.yVelocity then
						minYMovement = newYMovement
					end
				end
			end
		elseif minYMovement < 0 then
			--collision above npc
			if npc.attacking then
				for _, actor in ipairs(getCollidingActors(npc:getX() + npc.attackHitboxX, npc:getY() + npc.attackHitboxY - 32, npc.attackHitboxWidth, 32, true, false, true, true, false, false)) do
					local newYMovement = (actor.y + actor.hitboxY) + actor.hitboxHeight - npc.y
					if newYMovement > npc.yVelocity then
						minYMovement = newYMovement
						npc.yVelocity = 0
					end
				end
			else
				for _, actor in ipairs(getCollidingActors(npc:getX() + npc.hitboxX, npc:getY() + npc.hitboxY - 32, npc.hitboxWidth, 32, true, false, true, true, false, false)) do
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
		npc.tileLeft = ""
		npc.tileRight = ""
		npc.tileBottomLeft = ""
		npc.tileBottomRight = ""
		npc.playerLeft = false
		npc.playerRight = false
		npc.canMove = false
		-- local wallDistance = npc.wallDistance*math.abs(npc.xVelocity)/npc.xTerminalVelocity + 1
		local wallDistance = npc.wallDistance

		local extraHitDistance
		if npc.name == "acornKing" then
			extraHitDistance = 5
		elseif npc.name == "acorn" then
			extraHitDistance = 1
		else
			extraHitDistance = 0
		end

		if npc.attacking == false then
			npc.attackDirection = ""

			if npc.direction == "left" then
				for _, actor in ipairs(getCollidingActors(npc:getX() + (npc.width - npc.hitboxWidth - npc.hitboxX) - npc.attackDistance, npc:getY() + npc.hitboxY, npc.attackDistance + extraHitDistance, npc.hitboxHeight, false, false, false, false, false, false, false, true)) do
					npc.playerLeft = true
				end
				for _, actor in ipairs(getCollidingActors(npc:getX() + (npc.width - npc.hitboxWidth - npc.hitboxX) - wallDistance, npc:getY() + npc.hitboxY, wallDistance, npc.hitboxHeight, true, false, false, true, false, false)) do
					if actor.collidable then
						npc.tileLeft = actor.name
					end
				end
				for _, actor in ipairs(getCollidingActors(npc:getX() + (npc.width - npc.hitboxWidth - npc.hitboxX) - wallDistance, npc:getY() + npc.hitboxY + npc.hitboxHeight, wallDistance, 1, true, true, false, true, false, false, false, false, true)) do
					if actor.collidable or actor.platform then
						npc.tileBottomLeft = actor.name
					end
				end
			elseif npc.direction == "right" then
				for _, actor in ipairs(getCollidingActors(npc:getX() + npc.hitboxX + npc.hitboxWidth - extraHitDistance, npc:getY() + npc.hitboxY, npc.attackDistance + extraHitDistance, npc.hitboxHeight, false, false, false, false, false, false, false, true)) do
					npc.playerRight = true
				end
				for _, actor in ipairs(getCollidingActors(npc:getX() + npc.hitboxX + npc.hitboxWidth, npc:getY() + npc.hitboxY, wallDistance, npc.hitboxHeight, true, false, false, true, false, false)) do
					if actor.collidable then
						npc.tileRight = actor.name
					end
				end
				for _, actor in ipairs(getCollidingActors(npc:getX() + npc.hitboxX + npc.hitboxWidth, npc:getY() + npc.hitboxY + npc.hitboxHeight, wallDistance, 1, true, true, false, true, false, false, false, false, true)) do
					if actor.collidable or actor.platform then
						npc.tileBottomRight = actor.name
					end
				end
			end

			if npc.idle then
				npc.canMove = false
			else
				local frameNumber = npc.moveQuadSection/npc.width
				if npc.ai == "mushroomMonster" then
					npc.canMove = (frameNumber == 0 or frameNumber == 1)
				elseif npc.ai == "acornKing" then
					npc.canMove = (frameNumber == 0 or frameNumber == 2 or frameNumber == 3 or frameNumber == 5)
				else
					npc.canMove = true
				end
			end

			if npc.idle == false then
				if npc.moveForward == 0 then
					if npc.yVelocity == 0 and (npc.playerLeft or npc.playerRight) and npc.attackCooldown == 0 then
						npc.attacking = true
						if npc.playerLeft then
							npc.attackDirection = "left"
							npc.x = npc.x + npc.leftAttackXOffset
						elseif npc.playerRight then
							npc.attackDirection = "right"
							npc.x = npc.x + npc.rightAttackXOffset
						end
						npc.y = npc.y + npc.attackYOffset

						if npc.ai == "acornKing" then
							if npc.attackDirection == "left" then
								npc.xVelocity = 1.8
							elseif npc.attackDirection == "right" then
								npc.xVelocity = -1.8
							end
						end
					else
						if npc.towardsPlayer then
							if npc.canTurn and npc.canMove == false then
								if npc.direction == "right" and player.x < npc.x + npc.hitboxX + npc.hitboxWidth then
									npc.direction = "left"
									npc.x = npc.x + (npc.hitboxX - (npc.width - npc.hitboxWidth - npc.hitboxX))
									npc.canTurn = false
								elseif npc.direction == "left" and player.x + player.width > npc.x + npc.hitboxX then
									npc.direction = "right"
									npc.x = npc.x - (npc.hitboxX - (npc.width - npc.hitboxWidth - npc.hitboxX))
									npc.canTurn = false
								end
							end
						else
							if npc.direction == "right" and npc.grounded and (npc.x >= 480-npc.width-8 or npc.tileRight ~= "" or npc.tileBottomRight == "") then
								npc.direction = "left"
								npc.x = npc.x + (npc.hitboxX - (npc.width - npc.hitboxWidth - npc.hitboxX))
								-- if npc.tileRight ~= "" and npc.lastTurnCounter < 10 then
								-- 	npc.idle = true
								-- end
								npc.lastTurnCounter = 0
							elseif npc.direction == "left" and npc.grounded and (npc.x <= npc.width-8 or npc.tileLeft ~= "" or npc.tileBottomLeft == "") then
								npc.direction = "right"
								npc.x = npc.x - (npc.hitboxX - (npc.width - npc.hitboxWidth - npc.hitboxX))
								-- if npc.tileLeft ~= "" and npc.lastTurnCounter < 10 then
								-- 	npc.idle = true
								-- end
								npc.lastTurnCounter = 0
							end
						end
					end
				elseif npc.moveForward > 0 then
					npc.moveForward = npc.moveForward - 1
				end
			end
		end

		if npc.attackCooldown > 0 then
			npc.attackCooldown = npc.attackCooldown - 1
		end

		if npc.attacking == false and npc.canMove then
			npc.canTurn = true
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
				if npc.xVelocity < 0 then
					npc.xVelocity = 0
				end
			elseif npc.xVelocity < 0 then
				npc.xVelocity = npc.xVelocity + npc.xAcceleration
				if npc.xVelocity > 0 then
					npc.xVelocity = 0
				end
			end
		end

		if npc.yVelocity ~= 0 then
			npc.xTerminalVelocity = npc.baseXTerminalVelocity / 2
		else
			npc.xTerminalVelocity = npc.baseXTerminalVelocity
		end

		if npc.grounded == false then
			npc.yVelocity = npc.yVelocity + npc.yAcceleration
		end

		npc.lastTurnCounter = npc.lastTurnCounter + 1
	end

	function npc:mushroomMonsterAi()
		npc:walkingAi()
		if npc.attacking then
			if isInTable(npc.attackQuadSection/npc.attackWidth, npc.attackHitFrames) and npc.projectileShot == false then
				local stats = getNpcStats("poisonCloud")
				local y = npc.y + npc.height - stats.spritesheet:getHeight()/2
				local x
				if npc.direction == "left" then
					x = npc.x + ((npc.width - npc.hitboxWidth - npc.hitboxX) + npc.hitboxWidth/2) - (stats.spritesheet:getWidth()/stats.animationFrames)/2
				elseif npc.direction == "right" then
					x = npc.x + (npc.hitboxX + npc.hitboxWidth/2) - (stats.spritesheet:getWidth()/stats.animationFrames)/2
				end
				table.insert(actors, newNpc(x, y, 0, 0, stats))
				npc.projectileShot = true

				if npc.direction == "left" then
					npc.direction = "right"
				else
					npc.direction = "left"
				end
			end
		else
			npc.projectileShot = false
		end
	end

	function npc:acornKingAi()
		npc:walkingAi()
		if (npc.lastDamagedTimer == 1) and ((npc.previousHp/npc.maxHp > 0.9 and npc.hp/npc.maxHp <= 0.9) or (npc.previousHp/npc.maxHp > 0.7 and npc.hp/npc.maxHp <= 0.7) or (npc.previousHp/npc.maxHp > 0.5 and npc.hp/npc.maxHp <= 0.5) or (npc.previousHp/npc.maxHp > 0.3 and npc.hp/npc.maxHp <= 0.3) or (npc.previousHp/npc.maxHp > 0.1 and npc.hp/npc.maxHp <= 0.1)) then
			local stats = getNpcStats("acorn")
			local y = npc.y + npc.height/2 - stats.spritesheet:getHeight()/2
			local x
			if npc.direction == "left" then
				x = npc.x + ((npc.width - npc.hitboxWidth - npc.hitboxX) + npc.hitboxWidth/2) - (stats.spritesheet:getWidth()/stats.animationFrames)/2
			elseif npc.direction == "right" then
				x = npc.x + (npc.hitboxX + npc.hitboxWidth/2) - (stats.spritesheet:getWidth()/stats.animationFrames)/2
			end

			table.insert(actors, newNpc(x, y, -2 - 0.5 + math.random(), -3.5 - 0.5 + math.random(), stats, 60)) -- left
			table.insert(actors, newNpc(x, y, 2 - 0.5 + math.random(), -3.5 - 0.5 + math.random(), stats, 60)) -- right
			if npc.hp/npc.maxHp <= 0.5 then
				table.insert(actors, newNpc(x, y, -0.5 + math.random(), -3.5 - 0.5 + math.random(), stats, 60)) -- middle
			end
		end

		if npc.attacking == false then
			if npc.counter == 60*4 then
				local stats = getNpcStats("acornProjectile")
				local y = npc.y + npc.height/2 - stats.spritesheet:getHeight()/2
				local x
				if npc.direction == "left" then
					x = npc.x + ((npc.width - npc.hitboxWidth - npc.hitboxX) + npc.hitboxWidth/2) - (stats.spritesheet:getWidth()/stats.animationFrames)/2
				elseif npc.direction == "right" then
					x = npc.x + (npc.hitboxX + npc.hitboxWidth/2) - (stats.spritesheet:getWidth()/stats.animationFrames)/2
				end
				table.insert(actors, newNpc(x, y, -1.5 - 0.5 + math.random(), -3 - 0.5 + math.random(), stats)) -- left
				table.insert(actors, newNpc(x, y, 1.5 - 0.5 + math.random(), -3 - 0.5 + math.random(), stats)) -- right
				if npc.hp/npc.maxHp <= 0.5 then
					table.insert(actors, newNpc(x, y, -0.5 + math.random(), -3 - 0.5 + math.random(), stats)) -- middle
				end
				npc.counter = 0
			end
		else
			npc.counter = npc.counter - 1 -- timer will not increase when attacking
			if npc.wallCollision then
				npc.moveForward = 60
			end
		end

		local speedIncrease = (2 + (1 - npc.hp/npc.maxHp))/2
		npc.xAcceleration = npc.baseXAcceleration * speedIncrease
		npc.xTerminalVelocity = npc.baseXTerminalVelocity * speedIncrease
	end

	function npc:cloudAi()
		if npc.counter == npc.animationFrames*npc.animationSpeed then
			npc.remove = true
		end
	end

	function npc:shootTurretAi()
		if npc.attackCooldown > 0 then
			npc.attackCooldown = npc.attackCooldown - 1
		end

		local stats = getNpcStats("plantProjectile")
		local y
		local x
		if npc.direction == "left" then
			x = npc.x + ((npc.attackWidth - npc.attackHitboxWidth - npc.attackHitboxX) + npc.hitboxWidth/2) - (stats.spritesheet:getWidth()/stats.animationFrames)/2
		elseif npc.direction == "right" then
			x = npc.x + (npc.attackHitboxX + npc.attackHitboxWidth/2) - (stats.spritesheet:getWidth()/stats.animationFrames)/2
		end

		if npc.name == "upPlant" then
			-- if centre of player is to the right of the left of the npc AND centre of player is to the left of the right of the npc
			if player.x + player.width/2 > npc.x and player.x + player.width/2 < npc.x + npc.attackWidth and player.y < npc.y and npc.attackCooldown == 0 and npc.attacking == false then
				if checkCollision(npc.x, player.y + player.height, npc.attackWidth, npc.y - player.y - player.height, false, false) == false then
					npc.attacking = true
					npc.projectileShot = false
					if npc.direction == "left" then
						npc.x = npc.x + npc.leftAttackXOffset
					elseif npc.direction == "right" then
						npc.x = npc.x + npc.rightAttackXOffset
					end
					npc.y = npc.y + npc.attackYOffset
				end
			end

			if npc.attacking then
				if isInTable(npc.attackQuadSection/npc.attackWidth, npc.attackHitFrames) and npc.projectileShot == false then
					y = npc.y + (npc.attackHitboxY + npc.attackHeight/2) - stats.spritesheet:getHeight()
					table.insert(actors, newNpc(x, y, 0, -2.5, stats))
					npc.projectileShot = true
				end
			end
		elseif npc.name == "downPlant" then
			if player.x + player.width/2 > npc.x and player.x + player.width/2 < npc.x + npc.attackWidth and player.y > npc.y and npc.attackCooldown == 0 and npc.attacking == false then
				if checkCollision(npc.x, npc.y + npc.height, npc.attackWidth, player.y - npc.y - npc.height, false, false) == false then
					npc.attacking = true
					npc.projectileShot = false
					if npc.direction == "left" then
						npc.x = npc.x + npc.leftAttackXOffset
					elseif npc.direction == "right" then
						npc.x = npc.x + npc.rightAttackXOffset
					end
					npc.y = npc.y + npc.attackYOffset
				end
			end

			if npc.attacking then
				if isInTable(npc.attackQuadSection/npc.attackWidth, npc.attackHitFrames) and npc.projectileShot == false then
					y = npc.y + (npc.attackHitboxY + npc.attackHeight/2)
					table.insert(actors, newNpc(x, y, 0, 2.5, stats))
					npc.projectileShot = true
				end
			end
		end
	end

	function npc:divingAi()
		if player.x + player.width/2 > npc.x and player.x + player.width/2 < npc.x + npc.attackWidth and player.y > npc.y and npc.attackCooldown == 0 and npc.attacking == false then
			if checkCollision(npc.x, npc.y + npc.height, npc.attackWidth, player.y - npc.y - npc.height, false, false) == false then
				npc.attacking = true
			end
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
		npc.tileLeft = ""
		npc.tileRight = ""
		local wallDistance = npc.wallDistance
		if npc.direction == "left" then
			for _, actor in ipairs(getCollidingActors(npc:getX() + (npc.width - npc.hitboxWidth - npc.hitboxX) - wallDistance, npc:getY() + npc.hitboxY, wallDistance, npc.hitboxHeight, true, false, false, true, false, false)) do
				if actor.collidable then
					npc.tileLeft = actor.name
				end
			end

			if npc.x <= npc.width or npc.tileLeft ~= "" then
				npc.direction = "right"
			end
		elseif npc.direction == "right" then
			for _, actor in ipairs(getCollidingActors(npc:getX() + npc.hitboxX + npc.hitboxWidth, npc:getY() + npc.hitboxY, wallDistance, npc.hitboxHeight, true, false, false, true, false, false)) do
				if actor.collidable then
					npc.tileRight = actor.name
				end
			end

			if npc.x >= 480 - npc.width or npc.tileRight ~= "" then
				npc.direction = "left"
			end
		end

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
				-- local name, ai, spritesheet, animationSpeed, animationFrames, width, height, attackAnimationFrames, attackXOffset,
				-- 	attackYOffset, attackHitFrames, attackCooldownLength, attackDistance, damage, hp, knockback, knockbackResistance,
				-- 	screenShakeAmount, screenShakeLength, screenFreezeLength, xAcceleration, xTerminalVelocity, enemy, money, boss,
				-- 	projectile, background = unpack(getNpcStats("smileyProjectile"))
				-- local projectileAngle = math.atan2(npc.yVelocity, npc.xVelocity)
				-- local projectileDx = math.cos(projectileAngle)
				-- local projectileDy = math.sin(projectileAngle)

				-- table.insert(actors, newNpc(name, ai, npc.x + npc.width/2 - width/2, npc.y + npc.height/2 - height/2, spritesheet, animationSpeed,
				-- 	animationFrames, width, height, attackAnimationFrames, attackXOffset, attackYOffset, attackHitFrames, attackCooldownLength, attackDistance,
				-- 	damage, hp, knockback, knockbackResistance, screenShakeAmount, screenShakeLength, screenFreezeLength, xAcceleration, xTerminalVelocity,
				-- 	enemy, money, boss, projectile, background, projectileDx*3, projectileDy*3))
				-- npc.projectileCounter = 0
			end
		end
		npc:flyingAi()
	end

	function npc:projectileAi()
		for _, actor in ipairs(getCollidingActors(npc.x + npc.width/4, npc.y + npc.height/4, npc.width/2, npc.height/2, true, false, false, true, false, false)) do
			if actor.collidable then
				npc.remove = true
			end
		end

		npc.xVelocity = npc.xVelocity + npc.xAcceleration
		npc.yVelocity = npc.yVelocity + npc.yAcceleration
		npc.x = npc.x + npc.xVelocity
		npc.y = npc.y + npc.yVelocity
	end

	function npc:movement()
		if (npc.direction == "left" and npc.xVelocity < npc.xTerminalVelocity) or (npc.direction == "right" and npc.xVelocity > -npc.xTerminalVelocity) then
			npc.knockedBack = false
		end

		npc.xPlayerDistance = player.x-npc.x
		npc.yPlayerDistance = player.y-npc.y
		npc.playerDistance = math.sqrt(npc.xPlayerDistance^2 + npc.yPlayerDistance^2)
	end

	function npc:animation()
		if npc.poison > 0 then
			if npc.poisonCounter >= 6*6/2 then
				if npc.attacking then
					if npc.direction == "left" then
						table.insert(actors, newDust(npc.x + math.random(npc.attackWidth - npc.attackHitboxWidth - npc.attackHitboxX + 4, (npc.attackWidth - npc.attackHitboxWidth - npc.attackHitboxX) + npc.attackHitboxWidth - 4), npc.y + math.random(npc.attackHitboxY + 4, npc.attackHitboxY + npc.attackHitboxHeight - 4), "poison"))
					else
						table.insert(actors, newDust(npc.x + math.random(npc.attackHitboxX + 4, npc.attackHitboxWidth + npc.attackHitboxX - 4), npc.y + math.random(npc.attackHitboxY + 4, npc.attackHitboxY + npc.attackHitboxHeight - 4), "poison"))
					end
				else
					if npc.direction == "left" then
						table.insert(actors, newDust(npc.x + math.random(npc.width - npc.hitboxWidth - npc.hitboxX + 4, (npc.width - npc.hitboxWidth - npc.hitboxX) + npc.hitboxWidth - 4), npc.y + math.random(npc.hitboxY + 4, npc.hitboxY + npc.hitboxHeight - 4), "poison"))
					else
						table.insert(actors, newDust(npc.x + math.random(npc.hitboxX + 4, npc.hitboxWidth + npc.hitboxX - 4), npc.y + math.random(npc.hitboxY + 4, npc.hitboxY + npc.hitboxHeight - 4), "poison"))
					end
				end
				npc.poisonCounter = 0
			end
			npc.poisonCounter = npc.poisonCounter + 1
		else
			npc.poisonCounter = 6*6/2
		end

		if npc.burn > 0 then
			if npc.burnCounter >= 6*6/2 then
				if npc.attacking then
					if npc.direction == "left" then
						table.insert(actors, newDust(npc.x + math.random(npc.attackWidth - npc.attackHitboxWidth - npc.attackHitboxX + 4, (npc.attackWidth - npc.attackHitboxWidth - npc.attackHitboxX) + npc.attackHitboxWidth - 4), npc.y + math.random(npc.attackHitboxY + 4, npc.attackHitboxY + npc.attackHitboxHeight - 4), "flame"))
					else
						table.insert(actors, newDust(npc.x + math.random(npc.attackHitboxX + 4, npc.attackHitboxWidth + npc.attackHitboxX - 4), npc.y + math.random(npc.attackHitboxY + 4, npc.attackHitboxY + npc.attackHitboxHeight - 4), "flame"))
					end
				else
					if npc.direction == "left" then
						table.insert(actors, newDust(npc.x + math.random(npc.width - npc.hitboxWidth - npc.hitboxX + 4, (npc.width - npc.hitboxWidth - npc.hitboxX) + npc.hitboxWidth - 4), npc.y + math.random(npc.hitboxY + 4, npc.hitboxY + npc.hitboxHeight - 4), "flame"))
					else
						table.insert(actors, newDust(npc.x + math.random(npc.hitboxX + 4, npc.hitboxWidth + npc.hitboxX - 4), npc.y + math.random(npc.hitboxY + 4, npc.hitboxY + npc.hitboxHeight - 4), "flame"))
					end
				end
				npc.burnCounter = 0
			end
			npc.burnCounter = npc.burnCounter + 1
		else
			npc.burnCounter = 6*6/2
		end

		npc.healthBarOpacity = npc.lastDamagedTimer/npc.healthBarDuration
		if npc.lastDamagedTimer < npc.healthBarDuration or npc.poison > 0 or npc.burn > 0 then
			npc.healthBarOpacity = 1
		else
			npc.healthBarOpacity = 0
			if npc.lastDamagedTimer < npc.healthBarDuration + npc.healthBarFadeDuration then
				npc.healthBarOpacity = 1 - (npc.lastDamagedTimer - npc.healthBarDuration)/npc.healthBarFadeDuration
			end
		end

		if npc.attacking then
			npc.idleCounter = 0
			npc.idleQuadSection = 0
		else
			npc.attackCounter = 0
			npc.attackQuadSection = 0
		end

		if npc.ai == "projectile" or npc.ai == "cloud" then
			if npc.frameCounter >= npc.animationSpeed then
				npc.frame = npc.frame + 1
				npc.frameCounter = 0
				npc.frameQuad = love.graphics.newQuad((npc.frame-1)*npc.width, 0, npc.width, npc.height, npc.width*npc.animationFrames, npc.height)
			end

			if npc.frame >= npc.animationFrames then
				npc.frame = 0
				npc.frameCounter = 0
			end

			if npc.name == "acornProjectile" then
				if npc.counter == 6 then
					npc.rotation = npc.rotation + 1
					if npc.rotation == 9 then
						npc.rotation = 1
					end
					npc.counter = 0
				end
			end

			npc.frameCounter = npc.frameCounter + 1
		elseif npc.ai == "shootTurret" then
			if npc.attacking then
				if npc.attackCounter >= npc.attackAnimationSpeed then
					npc.attackQuadSection = npc.attackQuadSection + npc.attackWidth
					npc.attackCounter = 0
				end
				if npc.attackQuadSection >= npc.attackWidth*npc.attackAnimationFrames then
					npc.attacking = false
					npc.attackCounter = 0
					npc.attackQuadSection = 0
					npc.attackCooldown = npc.attackCooldownLength
					if npc.direction == "left" then
						npc.x = npc.x - npc.leftAttackXOffset
					elseif npc.direction == "right" then
						npc.x = npc.x - npc.rightAttackXOffset
					end
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
		elseif npc.ai == "walking" or npc.ai == "acornKing" or npc.ai == "mushroomMonster" or npc.ai == "flying" or npc.ai == "diving" then
			if npc.attacking then
				if npc.attackCounter >= npc.attackAnimationSpeed then
					npc.attackQuadSection = npc.attackQuadSection + npc.attackWidth
					npc.attackCounter = 0
					if npc.ai == "acornKing" then
						local frameNumber = npc.attackQuadSection/npc.attackWidth
						if frameNumber == 4 then
							if shakeLength < npc.screenShakeLength/2 then
								shakeLength = npc.screenShakeLength/2
							end
							maxShakeLength = shakeLength
							if shakeAmount < npc.screenShakeAmount/2 then
								shakeAmount = shakeAmount + npc.screenShakeAmount/2
							end
							maxShakeAmount = shakeAmount
						end
					end
				end
				if npc.attackQuadSection >= npc.attackWidth*npc.attackAnimationFrames then
					npc.attacking = false
					npc.attackCounter = 0
					npc.attackQuadSection = 0
					npc.attackCooldown = npc.attackCooldownLength
					if npc.ai ~= "flying" then
						if npc.direction == "left" then
							npc.x = npc.x - npc.leftAttackXOffset
						elseif npc.direction == "right" then
							npc.x = npc.x - npc.rightAttackXOffset
						end
					end
					npc.y = npc.y - npc.attackYOffset
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
				elseif npc.yVelocity ~= 0 and npc.name == "acorn" then
					if npc.hoverCounter >= npc.animationSpeed then
						npc.hoverQuadSection = npc.hoverQuadSection + 28
						npc.hoverCounter = 0
					end
					if npc.hoverQuadSection >= 28*2 then
						npc.hoverQuadSection = 0
						npc.hoverCounter = 0
					end
					npc.hoverCounter = npc.hoverCounter + 1
				else
					if npc.moveCounter >= npc.animationSpeed then
						npc.moveQuadSection = npc.moveQuadSection + npc.width
						npc.moveCounter = 0
						if npc.ai == "acornKing" then
							local frameNumber = npc.moveQuadSection/npc.width
							if frameNumber == 1 or frameNumber == 4 then
								if shakeLength < npc.screenShakeLength then
									shakeLength = npc.screenShakeLength/4
								end
								maxShakeLength = shakeLength
								if shakeAmount < npc.screenShakeAmount/4 then
									shakeAmount = npc.screenShakeAmount/4
								end
								maxShakeAmount = shakeAmount
							end
						end
					end
					if npc.moveQuadSection >= npc.width*npc.animationFrames then
						npc.moveQuadSection = 0
						npc.moveCounter = 0
					end
					npc.moveCounter = npc.moveCounter + 1
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
		elseif npc.yVelocity ~= 0 and npc.name == "acorn" then
			npc.canvas = npc.hoverCanvas
		else
			npc.canvas = npc.movementCanvas
		end
		love.graphics.setCanvas(npc.canvas)
		love.graphics.clear()
		love.graphics.setBackgroundColor(0, 0, 0, 0)

		if npc.ai == "sine" or npc.ai == "smiley" or npc.ai == "projectile" or npc.ai == "cloud" then
			if npc.rotation == 1 then
				npc.spritesheet = npc.baseSpritesheet
			elseif npc.rotation == 2 then
				npc.spritesheet = npc.rotation2Spritesheet
			elseif npc.rotation == 3 then
				npc.spritesheet = npc.rotation3Spritesheet
			elseif npc.rotation == 4 then
				npc.spritesheet = npc.rotation4Spritesheet
			elseif npc.rotation == 5 then
				npc.spritesheet = npc.rotation5Spritesheet
			elseif npc.rotation == 6 then
				npc.spritesheet = npc.rotation6Spritesheet
			elseif npc.rotation == 7 then
				npc.spritesheet = npc.rotation7Spritesheet
			elseif npc.rotation == 8 then
				npc.spritesheet = npc.rotation8Spritesheet
			end

			npc.quad = npc.frameQuad
		elseif npc.ai == "walking" or npc.ai == "acornKing" or npc.ai == "mushroomMonster" or npc.ai == "flying" or npc.ai == "diving" then
			if npc.attacking then
				if npc.attackDirection == "left" then
					npc.spritesheet = npc.attackLeftSpritesheet
					npc.quad = love.graphics.newQuad(npc.attackQuadSection, 0, npc.attackWidth, npc.attackHeight, npc.attackWidth*npc.attackAnimationFrames, npc.attackHeight)
				else
					npc.spritesheet = npc.attackRightSpritesheet
					npc.quad = love.graphics.newQuad(npc.attackQuadSection, 0, npc.attackWidth, npc.attackHeight, npc.attackWidth*npc.attackAnimationFrames, npc.attackHeight)
				end

				if npc.ai == "diving" then
					if npc.direction == "left" then
						npc.spritesheet = npc.attackLeftSpritesheet
						npc.quad = love.graphics.newQuad(npc.attackQuadSection, 0, npc.attackWidth, npc.attackHeight, npc.attackWidth*npc.attackAnimationFrames, npc.attackHeight)
					else
						npc.spritesheet = npc.attackRightSpritesheet
						npc.quad = love.graphics.newQuad(npc.attackQuadSection, 0, npc.attackWidth, npc.attackHeight, npc.attackWidth*npc.attackAnimationFrames, npc.attackHeight)
					end
				end
			else
				if npc.diving then
					if npc.direction == "left" then
						npc.spritesheet = npc.diveLeftSpritesheet
						npc.quad = love.graphics.newQuad(npc.diveQuadSection, 0, npc.diveWidth, npc.diveHeight, npc.diveWidth*2, npc.diveHeight)
					else
						npc.spritesheet = npc.diveRightSpritesheet
						npc.quad = love.graphics.newQuad(npc.diveQuadSection, 0, npc.diveWidth, npc.diveHeight, npc.diveWidth*2, npc.diveHeight)
					end
				elseif npc.stuck then
					if npc.direction == "left" then
						npc.spritesheet = npc.stuckLeftSpritesheet
						npc.quad = love.graphics.newQuad(npc.stuckQuadSection, 0, npc.stuckWidth, npc.stuckHeight, npc.stuckWidth*2, npc.stuckHeight)
					else
						npc.spritesheet = npc.stuckRightSpritesheet
						npc.quad = love.graphics.newQuad(npc.stuckQuadSection, 0, npc.stuckWidth, npc.stuckHeight, npc.stuckWidth*2, npc.stuckHeight)
					end
				elseif npc.yVelocity ~= 0 and npc.name == "acorn" then
					if npc.direction == "left" then
						npc.spritesheet = npc.hoverLeftSpritesheet
						npc.quad = love.graphics.newQuad(npc.hoverQuadSection, 0, npc.hoverWidth, npc.hoverHeight, npc.hoverWidth*2, npc.hoverHeight)
					else
						npc.spritesheet = npc.hoverRightSpritesheet
						npc.quad = love.graphics.newQuad(npc.hoverQuadSection, 0, npc.hoverWidth, npc.hoverHeight, npc.hoverWidth*2, npc.hoverHeight)
					end
				else
					if npc.direction == "left" then
						npc.spritesheet = npc.moveLeftSpritesheet
						npc.quad = love.graphics.newQuad(npc.moveQuadSection, 0, npc.width, npc.height, npc.width*npc.animationFrames, npc.height)
					else
						npc.spritesheet = npc.moveRightSpritesheet
						npc.quad = love.graphics.newQuad(npc.moveQuadSection, 0, npc.width, npc.height, npc.width*npc.animationFrames, npc.height)
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
		if npc.poison > 0 then
			npc.image = convertColor(npc.canvas, 0.5, 0, 0.75, 0.5, nil, true)
			love.graphics.draw(npc.image)
		end

		if npc.burn > 0 then
			npc.image = convertColor(npc.canvas, 0.75, 0.5, 0, 0.5, nil, true)
			love.graphics.draw(npc.image)
		end

		if npc.hit then
			npc.image = convertColor(npc.canvas, 0.063, 0.118, 0.161, 1, nil, true)
			love.graphics.draw(npc.image)
		end
	end

	return npc
end