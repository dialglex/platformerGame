 function newWeapon(index, x, y, shootDirection, stats)
	local weapon = {}
	
	weapon.index = index
	
	weapon.damage = stats.damage
	weapon.speed = stats.speed
	weapon.startupLag = math.floor(1/4*(100-weapon.speed)/2 + 0.5)
	weapon.endLag = math.floor(3/4*(100-weapon.speed)/2 + 0.5)
	weapon.knockback = stats.knockback
	weapon.status = stats.status
	weapon.statusDuration = stats.statusDuration
	weapon.screenShakeLength = math.floor((50 + weapon.damage)/15 + 0.5)
	weapon.screenShakeAmount = math.floor((50 + weapon.damage)/30 + 0.5)
	weapon.screenFreezeLength = math.floor((50 + weapon.damage)/30 + 0.5)
	weapon.pierce = stats.pierce
	weapon.projectile = stats.projectile
	weapon.direction = stats.direction
	if shootDirection == nil then
		weapon.shootDirection = stats.shootDirection
	else
		weapon.shootDirection = shootDirection
	end

	weapon.state = "startup"
	weapon.frozen = false

	weapon.name = stats.name
	weapon.type = stats.weaponType

	weapon.iconSprite = stats.iconSprite
	weapon.spritesheet = stats.spritesheet
	weapon.quads = stats.quads
	
	if weapon.type == "sword" then
		weapon.slashDuration = 4
		weapon.xOffset = stats.xOffset
		weapon.yOffset = stats.yOffset
		weapon.frames = 4
	elseif weapon.type == "projectile" then
		weapon.slashDuration = 1
		if weapon.name == "poisonDart" then
			weapon.frames = 1
		else
			weapon.frames = 5
		end
	elseif weapon.type == "bow" then
		weapon.slashDuration = 1
		weapon.sideXOffset = stats.sideXOffset
		weapon.sideYOffset = stats.sideYOffset
		weapon.upXOffset = stats.upXOffset
		weapon.upYOffset = stats.upYOffset
		weapon.downXOffset = stats.downXOffset
		weapon.downYOffset = stats.downYOffset
		weapon.frames = 4
	end
	weapon.duration = weapon.startupLag + weapon.slashDuration + weapon.endLag
	weapon.durationCounter = 0

	weapon.width = weapon.spritesheet:getWidth()/weapon.frames
	weapon.height = weapon.spritesheet:getHeight()
	weapon.canvas = love.graphics.newCanvas(weapon.width, weapon.height)
	weapon.x = x
	weapon.y = y
	weapon.currentXOffset = 0
	weapon.currentYOffset = 0
	
	if weapon.type == "projectile" then
		weapon.xAcceleration = 0
		weapon.yAcceleration = stats.yAcceleration
		if weapon.shootDirection == "left" then
			if weapon.name == "poisonDart" then
				weapon.xVelocity = -stats.velocity
				weapon.yVelocity = 0
			else
				weapon.xVelocity = -math.sqrt(stats.velocity^2 + 1.5^2)
				weapon.yVelocity = -1.5
			end
		elseif weapon.shootDirection == "right" then
			if weapon.name == "poisonDart" then
				weapon.xVelocity = stats.velocity
				weapon.yVelocity = 0
			else
				weapon.xVelocity = math.sqrt(stats.velocity^2 + 1.5^2)
				weapon.yVelocity = -1.5
			end
		elseif weapon.shootDirection == "up" then
			weapon.xVelocity = 0
			weapon.yVelocity = -stats.velocity
		elseif weapon.shootDirection == "down" then
			weapon.xVelocity = 0
			weapon.yVelocity = stats.velocity
		end
		if weapon.quads ~= nil then
			weapon.currentQuad = weapon.quads[1]
		end
	end
	weapon.movementReduction = stats.movementReduction

	weapon.actor = "weapon"
	weapon.enemiesHit = {}

	function weapon:getX()
		return math.floor(weapon.x + 0.5)
	end

	function weapon:getY()
		return math.floor(weapon.y + 0.5)
	end

	function weapon:act(index)
		if weapon.frozen == false then
			weapon.index = index
			weapon:effects()
			weapon:collision()
			weapon:movement()
			weapon:collision()
			weapon:changeStates()
			if (weapon.type == "sword" and weapon.state == "slash") or weapon.type == "projectile" then
				weapon:hitCollision()
			end
			weapon:destroy()
		end
	end

	function weapon:collision()
		if weapon.type == "projectile" then
			if weapon.x < 0 or weapon.x > 16 + 480 + 16 or weapon.y < 0 or weapon.y > 16 + 270 + 16 then
				weapon.remove = true
			end

			for _, actor in ipairs(getCollidingActors(weapon.x + weapon.width/2 - weapon.width/8, weapon.y + weapon.height/2 - weapon.height/8, weapon.width/4, weapon.height/4, true, false, true, true, false, false, false, false, false, 1)) do
				thudSound:stop()
				thudSound:play()
				if shakeLength < weapon.screenShakeLength/3 then
					shakeLength = weapon.screenShakeLength/3
				end
				maxShakeLength = shakeLength
				if shakeAmount < weapon.screenShakeAmount/3 then
					shakeAmount = weapon.screenShakeAmount/3
				end
				maxShakeAmount = shakeAmount
				weapon.frozen = true
			end
		end
	end

	function weapon:effects()
		if weapon.durationCounter == weapon.startupLag and weapon.type == "bow" then
			local stats = getWeaponStats(weapon.projectile)
			stats.duration = 1

			local width = stats.spritesheet:getWidth()/5
			local height = stats.spritesheet:getHeight()
			local x = player.x + player.width/2 - width/2
			local y = player.y + player.height/2 - height/2

			table.insert(actors, newWeapon(actors[#actors + 1], x, y, weapon.shootDirection, stats))
		end
	end

	function weapon:changeStates()
		weapon.durationCounter = weapon.durationCounter + 1

		if weapon.durationCounter < weapon.startupLag then
			weapon.state = "startup"
		elseif weapon.durationCounter <= (weapon.slashDuration + weapon.startupLag) then
			if weapon.state ~= "slash" and weapon.type ~= "projectile" then
				if isInTable("poisonDart", player.accessories) then
					local stats = getWeaponStats("poisonDart")
					stats.duration = 1

					local width = stats.spritesheet:getWidth()
					local height = stats.spritesheet:getHeight()
					local x = player.x + player.width/2 - width/2
					local y = player.y + player.height/2 - height/2

					table.insert(actors, newWeapon(actors[#actors + 1], x, y, weapon.direction, stats))
				end

				if weapon.type == "sword" then
					swingSound:stop()
					swingSound:play()
				elseif weapon.type == "bow" then
					shootSound:stop()
					shootSound:play()
				end

				if shakeLength < weapon.screenShakeLength/3 then
					shakeLength = weapon.screenShakeLength/3
				end
				maxShakeLength = shakeLength
				if shakeAmount < weapon.screenShakeAmount/3 then
					shakeAmount = weapon.screenShakeAmount/3
				end
				maxShakeAmount = shakeAmount
			end
			weapon.state = "slash"
		else
			weapon.state = "end"
		end

		if weapon.type == "projectile" and weapon.quads ~= nil then
			weapon.angle = math.atan2(weapon.yVelocity, weapon.xVelocity)
			if weapon.angle < 0 then
				weapon.angle = weapon.angle*-1
			end

			local corrospondingAngle = 0
			if weapon.angle < math.pi/2 then
				corrospondingAngle = weapon.angle -- top right quadrant
			elseif weapon.angle < math.pi then
				corrospondingAngle = math.pi - weapon.angle-- top left quadrant
			elseif weapon.angle < math.pi + math.pi/2 then
				corrospondingAngle = weapon.angle - math.pi -- bottom left quadrant
			else
				corrospondingAngle = 2*math.pi - weapon.angle -- bottom right quadrant
			end

			local section = math.pi/16
			if corrospondingAngle < section then
				weapon.currentQuad = weapon.quads[5]
			elseif corrospondingAngle < section*3 then
				weapon.currentQuad = weapon.quads[4]
			elseif corrospondingAngle < section*5 then
				weapon.currentQuad = weapon.quads[3]
			elseif corrospondingAngle < section*7 then
				weapon.currentQuad = weapon.quads[2]
			elseif corrospondingAngle < section*9 then
				weapon.currentQuad = weapon.quads[1]
			end
		end
	end

	function weapon:movement()
		if weapon.type == "sword" then
			weapon.x = player.x + player.width/2 - weapon.width/2
			weapon.y = player.y + player.height/2 - weapon.height/2
			weapon.currentYOffset = weapon.yOffset
			if weapon.direction == "left" then
				weapon.currentXOffset = -weapon.xOffset
			else
				weapon.currentXOffset = weapon.xOffset
			end
		elseif weapon.type == "bow" then
			weapon.x = player.x + player.width/2 - weapon.width/2
			weapon.y = player.y + player.height/2 - weapon.height/2
			if weapon.shootDirection == "up" then
				if weapon.direction == "left" then
					currentXOffset = -weapon.upXOffset
				else
					currentXOffset = weapon.upXOffset
				end
				weapon.currentYOffset = weapon.upYOffset
			elseif weapon.shootDirection == "down" then
				if weapon.direction == "left" then
					weapon.currentXOffset = -weapon.downXOffset
				else
					weapon.currentXOffset = weapon.downXOffset
				end
				weapon.currentYOffset = weapon.downYOffset
			elseif weapon.shootDirection == "left" then
				weapon.currentXOffset = -weapon.sideXOffset
				weapon.currentYOffset = weapon.sideYOffset
			elseif weapon.shootDirection == "right" then
				weapon.currentXOffset = weapon.sideXOffset
				weapon.currentYOffset = weapon.sideYOffset
			end
		elseif weapon.type == "projectile" then
			weapon.xVelocity = weapon.xVelocity + weapon.xAcceleration
			weapon.yVelocity = weapon.yVelocity + weapon.yAcceleration
			weapon.x = weapon.x + weapon.xVelocity
			weapon.y = weapon.y + weapon.yVelocity
			local velocity = math.sqrt(weapon.xVelocity^2 + weapon.yVelocity^2)
			if (velocity > stats.velocity) then
				local fraction = stats.velocity/velocity
				weapon.xVelocity = weapon.xVelocity*fraction
				weapon.yVelocity = weapon.yVelocity*fraction
			end
			
			local absoluteVelocity = math.abs(velocity)
			if absoluteVelocity >= 3 then
				for _, actor in ipairs(getCollidingActors(weapon.x + weapon.width/2 - 75/2, weapon.y + weapon.height/2 - 75/2, 75, 75, false, false, true, false, true)) do
					if actor.ai ~= "projectile" then
						local currentAngle = math.atan2(weapon.yVelocity, weapon.xVelocity)
						local newAngle = math.atan2((actor.y + actor.height/2) - (weapon.y + weapon.height/2), (actor.x + actor.width/2) - (weapon.x + weapon.width/2))
						local dx = math.cos(newAngle)
						local dy = math.sin(newAngle)
						-- if current weapon trajectory is similar to trajectory of weapon needed to hit enemy
						if newAngle > currentAngle - 0.4 and newAngle < currentAngle + 0.4 then
							weapon.xVelocity = weapon.xVelocity + absoluteVelocity/stats.velocity*dx
							weapon.yVelocity = weapon.yVelocity + absoluteVelocity/stats.velocity*dy
							break
						end
					end
				end
			end
		end

		weapon.x = weapon.x + weapon.currentXOffset
		weapon.y = weapon.y + weapon.currentYOffset
	end

	function weapon:destroy()
		if weapon.remove or weapon.durationCounter >= weapon.duration and weapon.type ~= "projectile" then
			table.remove(actors, weapon.index)
			if weapon.type ~= "projectile" then
				player.weaponOut = false
			end
		end
	end

	function weapon:hitCollision()
		love.graphics.setCanvas()
		local imageData = weapon.canvas:newImageData()

		local npcsInRange = {}
		for _, actor in ipairs(getCollidingActors(weapon.x, weapon.y, weapon.width, weapon.height, false, false, true, false, true, false, false, false, false)) do
			table.insert(npcsInRange, actor)
		end

		local weaponHit = false
		local width = imageData:getWidth()
		local height = imageData:getHeight()
		for i, actor in ipairs(npcsInRange) do
			for x = 1, width do
				for y = 1, height do
					-- pixel coordinates range from 0 to image width - 1 / height - 1.
					red, green, blue, alpha = imageData:getPixel(x-1, y-1)
					if alpha > 0 and (weapon.type == "projectile" or (red == 248/255 and green == 248/255 and blue == 248/255)) then
						local npcX
						local npcY
						local npcWidth
						local npcHeight
						if actor.attacking then
							if actor.direction == "left" then
								npcX = actor.x + (actor.attackWidth - actor.attackHitboxWidth - actor.attackHitboxX)
							else
								npcX = actor.x + actor.attackHitboxX
							end
							npcY = actor.y + actor.attackHitboxY
							npcWidth = actor.attackHitboxWidth
							npcHeight = actor.attackHitboxHeight
						else
							if actor.direction == "left" then
								npcX = actor.x + (actor.width - actor.hitboxWidth - actor.hitboxX)
							else
								npcX = actor.x + actor.hitboxX
							end
							npcY = actor.y + actor.hitboxY
							npcWidth = actor.hitboxWidth
							npcHeight = actor.hitboxHeight
						end

						if AABB(weapon.x + x-1, weapon.y + y-1, 1, 1, npcX, npcY, npcWidth, npcHeight) then
							if actor.enemy and actor.projectile == false then
								if isInTable(actor.uuid, weapon.enemiesHit) == false then
									if actor.invincibility == 0 then
										hitSound:stop()
										hitSound:play()
										weaponHit = true
										actor.hit = true
										actor.lastHitTimer = 0

										if weapon.damage > 0 then
											actor.previousHp = actor.hp
											if isInTable("corrosiveSubstance", player.accessories) and actor.poison > 0 then
												actor.hp = actor.hp - weapon.damage*player.damageBuff*1.5
											else
												actor.hp = actor.hp - weapon.damage*player.damageBuff
											end
											actor.lastDamagedTimer = 0
											actor.lastHitTimer = 0

											if actor.hp < 0 then
												actor.hp = 0
											end
										end

										if weapon.type == "projectile" then
											weapon.pierce = weapon.pierce - 1
											if weapon.pierce == 0 then
												weapon.remove = true
											end
										end

										if weapon.knockback > 0 then
											actor.knockedBack = true

											actor.knockbackAngle = math.atan2((player.y + player.height/2) - (actor.y + actor.height/2), (player.x + player.width/2) - (actor.x + actor.width/2))
											
											actor.knockbackDx = math.cos(actor.knockbackAngle)
											actor.knockbackDy = math.sin(actor.knockbackAngle)
											actor.xVelocity = -actor.knockbackDx*weapon.knockback/30*player.knockbackBuff/actor.knockbackResistance
											if actor.ai ~= "flying" and actor.ai ~= "diving" then
												actor.yVelocity = actor.knockbackDy*weapon.knockback/30*player.knockbackBuff/actor.knockbackResistance
											end
										end
										
										for i, accessory in ipairs(player.accessories) do
											local stats = getAccessoryStats(accessory)
											if stats.status == "poison" and actor.poison < stats.statusDuration then
												actor.poison = stats.statusDuration*player.poisonDurationBuff
												actor.lastPoisonDuration = actor.poison
											elseif stats.status == "burn" and actor.burn < stats.statusDuration then
												actor.burn = stats.statusDuration*player.burnDurationBuff
												actor.lastBurnDuration = actor.burn
											end
										end
										
										if weapon.status == "poison" and actor.poison < weapon.statusDuration then
											actor.poison = weapon.statusDuration*player.poisonDurationBuff
											actor.lastPoisonDuration = actor.poison
										elseif weapon.status == "burn" and actor.burn < weapon.statusDuration then
											actor.burn = weapon.statusDuration*player.burnDurationBuff
											actor.lastBurnDuration = actor.burn
										end

										if shakeLength < weapon.screenShakeLength then
											shakeLength = weapon.screenShakeLength
										end
										maxShakeLength = shakeLength
										if shakeAmount < weapon.screenShakeAmount then
											shakeAmount = weapon.screenShakeAmount
										end
										maxShakeAmount = shakeAmount
										if screenFreeze < weapon.screenFreezeLength then
											screenFreeze = weapon.screenFreezeLength
										end

										table.insert(weapon.enemiesHit, actor.uuid)
									end
								end
							end
						end
					end
				end
			end
		end
	end

	function weapon:draw()
		love.graphics.setCanvas(weapon.canvas)
		love.graphics.clear()

		if weapon.type == "sword" then
			local swordFrame
			if weapon.state == "startup" then
				swordFrame = 1
			elseif weapon.state == "slash" then
				if weapon.durationCounter > (weapon.startupLag + weapon.slashDuration/2) then
					swordFrame = 3
				else
					swordFrame = 2
				end
			else
				swordFrame = 4
			end

			if weapon.direction == "left" then
				love.graphics.draw(weapon.spritesheet, weapon.quads[swordFrame], 0, 0, 0, -1, 1, weapon.width)
				weapon.armOverlaySpritesheet = player.attackLeftArmSpritesheet
			else
				love.graphics.draw(weapon.spritesheet, weapon.quads[swordFrame])
				weapon.armOverlaySpritesheet = player.attackRightArmSpritesheet
			end

		elseif weapon.type == "bow" then
			local bowFrame
			if weapon.durationCounter <= weapon.startupLag then
				bowFrame = 1
			elseif weapon.durationCounter <= weapon.startupLag + weapon.slashDuration + weapon.endLag*1/4 then
				bowFrame = 2
			elseif weapon.durationCounter <= weapon.startupLag + weapon.slashDuration + weapon.endLag*2/4 then
				bowFrame = 3
			else
				bowFrame = 4
			end
			
			if weapon.shootDirection == "up" then
				love.graphics.draw(weapon.spritesheet, weapon.quads[bowFrame])
				if weapon.direction == "left" then
					weapon.armOverlaySpritesheet = player.bowUpLeftArmSpritesheet
				else
					weapon.armOverlaySpritesheet = player.bowUpRightArmSpritesheet
				end
			elseif weapon.shootDirection == "left" then
				love.graphics.draw(weapon.spritesheet, weapon.quads[bowFrame], 0, 0, 0, -1, 1, weapon.width)
				weapon.armOverlaySpritesheet = player.bowLeftArmSpritesheet
			elseif weapon.shootDirection == "right" then
				love.graphics.draw(weapon.spritesheet, weapon.quads[bowFrame])
				weapon.armOverlaySpritesheet = player.bowRightArmSpritesheet
			elseif weapon.shootDirection == "down" then
				love.graphics.draw(weapon.spritesheet, weapon.quads[bowFrame], 0, 0, 0, 1, -1, 0, weapon.width)
				if weapon.direction == "left" then
					weapon.armOverlaySpritesheet = player.bowDownLeftArmSpritesheet
				else
					weapon.armOverlaySpritesheet = player.bowDownRightArmSpritesheet
				end
			end
		else
			local width
			local height
			local xScale
			local yScale
			if weapon.xVelocity > 0 then
				xScale = 1
				width = 0
			else
				xScale = -1
				width = weapon.width
			end

			if weapon.yVelocity < 0 then
				yScale = 1
				height = 0
			else
				yScale = -1
				height = weapon.height
			end
			if weapon.quads ~= nil then
				love.graphics.draw(weapon.spritesheet, weapon.currentQuad, 0, 0, 0, xScale, yScale, width, height)
			else
				love.graphics.draw(weapon.spritesheet, 0, 0, 0, xScale, yScale, width, height)
			end
		end
		love.graphics.setColor(1, 1, 1, 1)
	end

	return weapon
end