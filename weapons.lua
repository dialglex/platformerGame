 function newWeapon(index, x, y, shootDirection, stats)
	local weapon = {}
	
	weapon.index = index
	
	weapon.damage = stats.damage
	weapon.knockback = stats.knockback
	weapon.status = stats.status
	weapon.statusDuration = stats.statusDuration
	weapon.startupLag = stats.startupLag
	weapon.slashDuration = stats.slashDuration
	weapon.endLag = stats.endLag
	weapon.duration = stats.duration
	weapon.screenShakeAmount = stats.screenShakeAmount
	weapon.screenShakeLength = stats.screenShakeLength
	weapon.screenFreezeLength = stats.screenFreezeLength
	weapon.pierce = stats.pierce
	weapon.projectile = stats.projectile
	weapon.shootDirection = shootDirection

	weapon.durationCounter = 0
	weapon.state = "startup"
	weapon.frozen = false

	weapon.name = stats.name
	weapon.type = stats.weaponType

	weapon.iconSprite = stats.iconSprite
	if weapon.startupLag > 0 then
		weapon.startupSprite = stats.startupSprite
	end
	weapon.slash1Sprite = stats.slash1Sprite
	weapon.slash2Sprite = stats.slash2Sprite
	if weapon.endLag > 0 then
		weapon.endSprite = stats.endSprite
	end

	weapon.width = weapon.slash1Sprite:getWidth()
	weapon.height = weapon.slash1Sprite:getHeight()
	weapon.canvas = love.graphics.newCanvas(weapon.width, weapon.height)

	if weapon.type == "sword" then
		weapon.xOffset = stats.xOffset
		weapon.yOffset = stats.yOffset
	elseif weapon.type == "projectile" then
		weapon.sprite1 = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."1.png")
		weapon.sprite2 = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."2.png")
		weapon.sprite3 = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."3.png")
		weapon.sprite4 = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."4.png")
		weapon.sprite5 = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."5.png")
		weapon.currentSprite = weapon.sprite1
	elseif weapon.type == "bow" then
		weapon.upSprite = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."Up.png")
		weapon.sideSprite = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."Side.png")
		if weapon.shootDirection == "up" or weapon.shootDirection == "down" then
			weapon.width = weapon.sideSprite:getHeight()
			weapon.height = weapon.upSprite:getHeight()
			weapon.canvas = love.graphics.newCanvas(weapon.width, weapon.height)
		elseif weapon.shootDirection == "left" or weapon.shootDirection == "right" then
			weapon.width = weapon.upSprite:getHeight()
			weapon.height = weapon.sideSprite:getHeight()
			weapon.canvas = love.graphics.newCanvas(weapon.width, weapon.height)
		end
		weapon.sideXOffset = stats.sideXOffset
		weapon.sideYOffset = stats.sideYOffset
		weapon.upXOffset = stats.upXOffset
		weapon.upYOffset = stats.upYOffset
		weapon.downXOffset = stats.downXOffset
		weapon.downYOffset = stats.downYOffset
	end
	weapon.x = x
	weapon.y = y

	weapon.directionLocked = stats.directionLocked
	if weapon.directionLocked then
		if player.weaponOut then
			weapon.direction = player.currentWeapon.direction
		else
			weapon.direction = player.direction
		end
	end
	
	weapon.xAcceleration = 0
	weapon.yAcceleration = 0.2
	if weapon.type == "projectile" then
		if weapon.shootDirection == "left" then
			weapon.xVelocity = -math.sqrt(stats.velocity^2 + 1.5^2)
			weapon.yVelocity = -1.5
		elseif weapon.shootDirection == "right" then
			weapon.xVelocity = math.sqrt(stats.velocity^2 + 1.5^2)
			weapon.yVelocity = -1.5
		elseif weapon.shootDirection == "up" then
			weapon.xVelocity = 0
			weapon.yVelocity = -stats.velocity
		elseif weapon.shootDirection == "down" then
			weapon.xVelocity = 0
			weapon.yVelocity = stats.velocity
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
			for _, actor in ipairs(getCollidingActors(weapon.x + weapon.width/2 - weapon.width/8, weapon.y + weapon.height/2 - weapon.height/8, weapon.width/4, weapon.height/4, true, false, true, true, false, false, false, false, false, 1)) do
				if shakeLength < weapon.screenShakeLength/2 then
					shakeLength = weapon.screenShakeLength/2
				end
				maxShakeLength = shakeLength
				if shakeAmount < weapon.screenShakeAmount/2 then
					shakeAmount = weapon.screenShakeAmount/2
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

			local sprite
			if weapon.shootDirection == "up" or weapon.shootDirection == "down" then
				sprite = love.graphics.newImage("images/weapons/bows/"..stats.name.."/"..stats.name.."1.png")
			elseif weapon.shootDirection == "left" or weapon.shootDirection == "right" then
				sprite = love.graphics.newImage("images/weapons/bows/"..stats.name.."/"..stats.name.."5.png")
			end

			local width = sprite:getWidth()
			local height = sprite:getHeight()
			local x = player.x + player.width/2 - width/2
			local y = player.y + player.height/2 - height/2

			table.insert(actors, newWeapon(actors[getTableLength(actors)+1], x, y, weapon.shootDirection, stats))
		end
	end

	function weapon:changeStates()
		weapon.durationCounter = weapon.durationCounter + 1

		if weapon.durationCounter < weapon.startupLag then
			weapon.state = "startup"
		elseif weapon.durationCounter <= (weapon.slashDuration + weapon.startupLag) then
			if weapon.state ~= "slash" then
				if shakeLength < weapon.screenShakeLength/2 then
					shakeLength = weapon.screenShakeLength/2
				end
				maxShakeLength = shakeLength
				if shakeAmount < weapon.screenShakeAmount/2 then
					shakeAmount = weapon.screenShakeAmount/2
				end
				maxShakeAmount = shakeAmount
			end
			weapon.state = "slash"
		else
			weapon.state = "end"
		end

		if weapon.type == "projectile" then
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
				weapon.currentSprite = weapon.sprite5
			elseif corrospondingAngle < section*3 then
				weapon.currentSprite = weapon.sprite4
			elseif corrospondingAngle < section*5 then
				weapon.currentSprite = weapon.sprite3
			elseif corrospondingAngle < section*7 then
				weapon.currentSprite = weapon.sprite2
			elseif corrospondingAngle < section*9 then
				weapon.currentSprite = weapon.sprite1
			end

			weapon.oldWidth = weapon.width
			weapon.oldHeight = weapon.height
			weapon.width = weapon.currentSprite:getWidth()
			weapon.height = weapon.currentSprite:getHeight()
			if weapon.oldWidth ~= weapon.width or weapon.oldHeight ~= weapon.height then
				weapon.canvas = love.graphics.newCanvas(weapon.width, weapon.height)
			end
		end
	end

	function weapon:movement()
		if weapon.directionLocked  == false then
			weapon.direction = player.direction
		end

		if weapon.type == "sword" then
			weapon.x = player.x + player.width/2 - weapon.width/2
			weapon.y = player.y + player.height/2 - weapon.height/2 + weapon.yOffset
			if weapon.direction == "left" then
				weapon.x = weapon.x - weapon.xOffset
			else
				weapon.x = weapon.x + weapon.xOffset
			end
		elseif weapon.type == "bow" then
			weapon.x = player.x + player.width/2 - weapon.width/2
			weapon.y = player.y + player.height/2 - weapon.height/2
			if weapon.shootDirection == "up" then
				if player.direction == "left" then
					weapon.x = weapon.x - weapon.upXOffset
				else
					weapon.x = weapon.x + weapon.upXOffset
				end
				weapon.y = weapon.y + weapon.upYOffset
			elseif weapon.shootDirection == "down" then
				if player.direction == "left" then
					weapon.x = weapon.x - weapon.downXOffset
				else
					weapon.x = weapon.x + weapon.downXOffset
				end
				weapon.y = weapon.y + weapon.downYOffset
			elseif weapon.shootDirection == "left" then
				weapon.x = weapon.x - weapon.sideXOffset
				weapon.y = weapon.y + weapon.sideYOffset
			elseif weapon.shootDirection == "right" then
				weapon.x = weapon.x + weapon.sideXOffset
				weapon.y = weapon.y + weapon.sideYOffset
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
	end

	function weapon:destroy()
		if weapon.durationCounter >= weapon.duration and weapon.type ~= "projectile" then
			table.remove(actors, weapon.index)
		end
	end

	function weapon:hitCollision()
		love.graphics.setCanvas()
		local imageData = weapon.canvas:newImageData()
		-- local blockedPixels = {}
		-- for x = 1, imageData:getWidth() do
		-- 	for y = 1, imageData:getHeight() do
		-- 		-- pixel coordinates range from 0 to image width - 1 / height - 1.
		-- 		red, green, blue, alpha = imageData:getPixel(x-1, y-1)
		-- 		if alpha > 0 then
		-- 			for _, actor in ipairs(getCollidingActors(weapon:getX() + x-1, weapon:getY() + y-1, 1, 1, true, false, false, true)) do
		-- 				if actor.y + actor.hitboxY + actor.hitboxHeight <= player.y then
		-- 					table.insert(blockedPixels, {x, y, "up"})
		-- 				end
		-- 				if actor.y + actor.hitboxY >= player.y + player.height then
		-- 					table.insert(blockedPixels, {x, y, "down"})
		-- 				end
		-- 				if actor.x + actor.hitboxX + actor.hitboxWidth <= player.x then
		-- 					table.insert(blockedPixels, {x, y, "left"})
		-- 				end
		-- 				if actor.x + actor.hitboxX >= player.x + player.width then
		-- 					table.insert(blockedPixels, {x, y, "right"})
		-- 				end
		-- 			end
		-- 		end
		-- 	end
		-- end

		for x = 1, imageData:getWidth() do
			for y = 1, imageData:getHeight() do
				-- pixel coordinates range from 0 to image width - 1 / height - 1.
				red, green, blue, alpha = imageData:getPixel(x-1, y-1)
				if alpha > 0 then
					-- local blocked = false
					-- for _, pixel in ipairs(blockedPixels) do
					-- 	if pixel[3] == "above" then
					-- 		if pixel[1] == x and y <= pixel[2] then
					-- 			blocked = true
					-- 		end
					-- 	elseif pixel[3] == "below" then
					-- 		if pixel[1] == x and y >= pixel[2] then
					-- 			blocked = true
					-- 		end
					-- 	elseif pixel[3] == "left" then
					-- 		if pixel[2] == y and x <= pixel[1] then
					-- 			blocked = true
					-- 		end
					-- 	elseif pixel[3] == "right" then
					-- 		if pixel[2] == y and x >= pixel[1] then
					-- 			blocked = true
					-- 		end
					-- 	end
					-- end

					-- if blocked == false then

					for _, actor in ipairs(getCollidingActors(weapon:getX() + x-1, weapon:getY() + y-1, 1, 1, false, false, true, false, true, false, false, false, true)) do
						if actor.enemy and actor.projectile == false then
							if isInTable(actor.uuid, weapon.enemiesHit) == false then
								if actor.invincibility == 0 then
									actor.hit = true
									actor.lastHitTimer = 0

									if weapon.damage > 0 then
										actor.previousHp = actor.hp
										if isInTable("poisonDamage", player.accessories) and actor.poison > 0 then
											actor.hp = actor.hp - weapon.damage*player.damageBuff*1.5
										else
											actor.hp = actor.hp - weapon.damage*player.damageBuff
										end
										actor.lastDamagedTimer = 0
										actor.lastHitTimer = 0

										if actor.hp < 0 then
											actor.hp = 0
										end
										if weapon.type == "projectile" then
											weapon.pierce = weapon.pierce - 1
											if weapon.pierce == 0 then
												table.remove(actors, weapon.index)
											end
										end
									end

									if weapon.knockback > 0 then
										actor.knockedBack = true

										actor.knockbackAngle = math.atan2((player.y + player.height/2) - (actor.y + actor.height/2), (player.x + player.width/2) - (actor.x + actor.width/2))
										
										actor.knockbackDx = math.cos(actor.knockbackAngle)
										actor.knockbackDy = math.sin(actor.knockbackAngle)
										actor.xVelocity = -actor.knockbackDx*weapon.knockback/actor.knockbackResistance
										if actor.ai == "walking" then
											actor.yVelocity = actor.knockbackDy*weapon.knockback/actor.knockbackResistance
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

	function weapon:draw()
		love.graphics.setCanvas(weapon.canvas)
		love.graphics.clear()

		if weapon.type == "sword" then
			if weapon.direction == "left" then
				if weapon.state == "startup" then
					love.graphics.draw(weapon.startupSprite, 0, 0, 0, -1, 1, weapon.width)
				elseif weapon.state == "slash" then
					if weapon.durationCounter > (weapon.startupLag + weapon.slashDuration/2) then
						love.graphics.draw(weapon.slash2Sprite, 0, 0, 0, -1, 1, weapon.width)
					else
						love.graphics.draw(weapon.slash1Sprite, 0, 0, 0, -1, 1, weapon.width)
					end
				else
					love.graphics.draw(weapon.endSprite, 0, 0, 0, -1, 1, weapon.width)
				end
			else
				if weapon.state == "startup" then
					love.graphics.draw(weapon.startupSprite)
				elseif weapon.state == "slash" then
					if weapon.durationCounter > (weapon.startupLag + weapon.slashDuration/2) then
						love.graphics.draw(weapon.slash2Sprite)
					else
						love.graphics.draw(weapon.slash1Sprite)
					end
				else
					love.graphics.draw(weapon.endSprite)
				end
			end
		elseif weapon.type == "bow" then
			local bowFrame
			local quad
			if weapon.durationCounter <= weapon.startupLag then
				bowFrame = 0
			elseif weapon.durationCounter <= weapon.startupLag + weapon.slashDuration + weapon.endLag*1/4 then
				bowFrame = 1
			elseif weapon.durationCounter <= weapon.startupLag + weapon.slashDuration + weapon.endLag*2/4 then
				bowFrame = 2
			else
				bowFrame = 3
			end

			quad = love.graphics.newQuad(bowFrame*weapon.width, 0, weapon.width, weapon.height, weapon.width*4, weapon.height)
			
			if weapon.shootDirection == "up" then
				love.graphics.draw(weapon.upSprite, quad)
			elseif weapon.shootDirection == "left" then
				love.graphics.draw(weapon.sideSprite, quad, 0, 0, 0, -1, 1, weapon.width)
			elseif weapon.shootDirection == "right" then
				love.graphics.draw(weapon.sideSprite, quad)
			elseif weapon.shootDirection == "down" then
				love.graphics.draw(weapon.upSprite, quad, 0, 0, 0, 1, -1, 0, weapon.width)
			end
		else
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

			love.graphics.draw(weapon.currentSprite, 0, 0, 0, xScale, yScale, width, height)
		end
		love.graphics.setColor(1, 1, 1, 1)
	end

	return weapon
end