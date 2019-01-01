 function newWeapon(weaponIndex, weaponName, weaponType, weaponX, weaponY, weaponDamage, weaponKnockbackStrength, weaponStartupLag, weaponSlashDuration, weaponEndLag, weaponDuration, weaponIconSprite, weaponStartupSprite, weaponSlashSprite, weaponEndSprite, weaponSheathSprite, weaponXOffset, weaponYOffset, weaponDirectionLocked, weaponMovementReduction, weaponPierce, weaponShootDirection)
	local weapon = {}

	weapon.index = weaponIndex
	
	weapon.damage = weaponDamage
	weapon.knockbackStrength = weaponKnockbackStrength
	weapon.startupLag = weaponStartupLag
	weapon.slashDuration = weaponSlashDuration
	weapon.endLag = weaponEndLag
	weapon.duration = weaponDuration
	weapon.pierce = weaponPierce
	weapon.shootDirection = weaponShootDirection

	weapon.durationCounter = 0
	weapon.state = "startup"

	weapon.name = weaponName
	weapon.type = weaponType

	weapon.iconSprite = weaponIconSprite
	if weapon.startupLag > 0 then
		weapon.startupSprite = weaponStartupSprite
	end
	weapon.slashSprite = weaponSlashSprite
	if weapon.endLag > 0 then
		weapon.endSprite = weaponEndSprite
	end

	weapon.width = weapon.slashSprite:getWidth()
	weapon.height = weapon.slashSprite:getHeight()
	weapon.canvas = love.graphics.newCanvas(weapon.width, weapon.height)

	if weapon.type == "projectile" then
		weapon.sprite1 = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."1.png")
		weapon.sprite2 = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."2.png")
		weapon.sprite3 = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."3.png")
		weapon.sprite4 = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."4.png")
		weapon.sprite5 = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."5.png")
		weapon.currentSprite = weapon.sprite1
	elseif weapon.type == "bow" then
		weapon.sprite1 = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."1.png")
		weapon.sprite2 = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."2.png")
		weapon.sprite3 = love.graphics.newImage("images/weapons/bows/"..weapon.name.."/"..weapon.name.."3.png")
		if weapon.shootDirection == "up" or weapon.shootDirection == "down" then
			weapon.width = weapon.sprite1:getWidth()
			weapon.height = weapon.sprite1:getHeight()
	    	weapon.canvas = love.graphics.newCanvas(weapon.width, weapon.height)
	    elseif weapon.shootDirection == "upLeft" or weapon.shootDirection == "upRight" or weapon.shootDirection == "downLeft" or weapon.shootDirection == "downRight"then
	    	weapon.width = weapon.sprite2:getWidth()
			weapon.height = weapon.sprite2:getHeight()
	    	weapon.canvas = love.graphics.newCanvas(weapon.width, weapon.height)
	    elseif weapon.shootDirection == "left" or weapon.shootDirection == "right" then
	    	weapon.width = weapon.sprite3:getWidth()
			weapon.height = weapon.sprite3:getHeight()
	    	weapon.canvas = love.graphics.newCanvas(weapon.width, weapon.height)
	    end
	    debugPrint(weapon.shootDirection)
	end
	weapon.sheathSprite = weaponSheathSprite
	weapon.x = weaponX
	weapon.y = weaponY
	weapon.xOffset = weaponXOffset
	weapon.yOffset = weaponYOffset

	weapon.directionLocked = weaponDirectionLocked
	if weapon.directionLocked then
		if player.weaponOut then
			weapon.direction = player.currentWeapon.direction
		else
			weapon.direction = player.direction
		end
	end
	
	if weapon.shootDirection == "left" then
    	weapon.xVelocity = -6
    	weapon.xAcceleration = 0.05
    	weapon.yVelocity = -1
		weapon.yAcceleration = 0.15
    elseif weapon.shootDirection == "right" then
    	weapon.xVelocity = 6
    	weapon.xAcceleration = -0.05
    	weapon.yVelocity = -1
		weapon.yAcceleration = 0.15
    elseif weapon.shootDirection == "up" then
    	weapon.xVelocity = 0
    	weapon.xAcceleration = 0
    	weapon.yVelocity = -6
		weapon.yAcceleration = 0.2
    elseif weapon.shootDirection == "down" then
    	weapon.xVelocity = 0
    	weapon.xAcceleration = 0
    	weapon.yVelocity = 6
		weapon.yAcceleration = 0.1
    elseif weapon.shootDirection == "upLeft" then
    	weapon.xVelocity = -5
    	weapon.xAcceleration = 0.05
    	weapon.yVelocity = -5
		weapon.yAcceleration = 0.2
	elseif weapon.shootDirection == "upRight" then
    	weapon.xVelocity = 5
    	weapon.xAcceleration = -0.05
    	weapon.yVelocity = -5
		weapon.yAcceleration = 0.2
	elseif weapon.shootDirection == "downLeft" then
    	weapon.xVelocity = -5
    	weapon.xAcceleration = 0.05
    	weapon.yVelocity = 5
		weapon.yAcceleration = 0.1
	elseif weapon.shootDirection == "downRight" then
    	weapon.xVelocity = 5
    	weapon.xAcceleration = -0.05
    	weapon.yVelocity = 5
		weapon.yAcceleration = 0.1
	end

	weapon.xVelocity = weapon.xVelocity + player.xVelocity/2
	weapon.yVelocity = weapon.yVelocity + player.yVelocity/2

	weapon.frozen = false
	weapon.movementReduction = weaponMovementReduction

	weapon.actor = "weapon"

	weapon.enemiesHit = {}

	function weapon:getX()
        return math.floor(weapon.x + 0.5)
    end

    function weapon:getY()
        return math.floor(weapon.y + 0.5)
    end

	function weapon:act(index)
		weapon.index = index
		if weapon.frozen == false then
			weapon:effects()
			weapon:movement()
			weapon:collision()
			weapon:changeStates()
			if weapon.state == "slash" or weapon.type == "projectile" then
				weapon:hitCollision()
			end
			weapon:destroy()
		end
	end

	function weapon:collision()
		if weapon.type == "projectile" then
			for _, actor in ipairs(getCollidingActors(weapon.x + weapon.width/4, weapon.y + weapon.height/4, weapon.width/2, weapon.height/2, true, false, true, true, false, false)) do
				weapon.frozen = true
			end
		end
	end

	function weapon:effects()
		if weapon.durationCounter == (weapon.slashDuration + weapon.startupLag) and weapon.type == "bow" then
			local weaponName, weaponType, iconSprite, startupSprite, slashSprite, endSprite, sheathSprite, iconSprite, weaponWidth, weaponHeight, weaponDamage,
                weaponKnockbackStrength, weaponStartupLag, weaponSlashDuration, weaponEndLag, weaponXOffset,
                weaponYOffset, directionLocked, movementReduction, pierce = unpack(getWeaponStats("woodenArrow"))
            local weaponDuration = weaponStartupLag + weaponSlashDuration + weaponEndLag

            if weapon.shootDirection == "up" then
            	sprite = love.graphics.newImage("images/weapons/bows/"..weaponName.."/"..weaponName.."1.png")
		    elseif weapon.shootDirection == "upLeft" then
		    	sprite = love.graphics.newImage("images/weapons/bows/"..weaponName.."/"..weaponName.."3.png")
		    elseif weapon.shootDirection == "upRight" then
            	sprite = love.graphics.newImage("images/weapons/bows/"..weaponName.."/"..weaponName.."3.png")
		    elseif weapon.shootDirection == "left" then
            	sprite = love.graphics.newImage("images/weapons/bows/"..weaponName.."/"..weaponName.."5.png")
		    elseif weapon.shootDirection == "right" then
            	sprite = love.graphics.newImage("images/weapons/bows/"..weaponName.."/"..weaponName.."5.png")
		    elseif weapon.shootDirection == "downLeft" then
            	sprite = love.graphics.newImage("images/weapons/bows/"..weaponName.."/"..weaponName.."3.png")
		    elseif weapon.shootDirection == "downRight" then
            	sprite = love.graphics.newImage("images/weapons/bows/"..weaponName.."/"..weaponName.."3.png")
		    elseif weapon.shootDirection == "down" then
            	sprite = love.graphics.newImage("images/weapons/bows/"..weaponName.."/"..weaponName.."1.png")
		    end

        	local width = sprite:getWidth()
        	local height = sprite:getHeight()
    		local x = weapon.x + weapon.width/2 - width/2
    		local y = weapon.y + weapon.height/2 - height/2

            table.insert(actors, newWeapon(actors[getTableLength(actors)+1], weaponName, weaponType, x, y, weaponDamage,
                weaponKnockbackStrength, weaponStartupLag, weaponSlashDuration, weaponEndLag,
                weaponDuration, iconSprite, startupSprite, slashSprite, endSprite, sheathSprite, weaponXOffset,
                weaponYOffset, directionLocked, movementReduction, pierce, weapon.shootDirection))
		end
	end

	function weapon:changeStates()
		weapon.durationCounter = weapon.durationCounter + 1

		if weapon.durationCounter < weapon.startupLag then
			weapon.state = "startup"
		elseif weapon.durationCounter <= (weapon.slashDuration + weapon.startupLag) then
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
			if weapon.direction == "left" then
	            weapon.x = player.x + player.width/2 - weapon.width/2 - weapon.xOffset
	        else
	        	weapon.x = player.x + player.width/2 - weapon.width/2 + weapon.xOffset
	        end
            weapon.y = player.y + player.height/2 - weapon.height/2 + weapon.yOffset
        elseif weapon.type == "bow" then
        	weapon.x = player.x + player.width/2 - weapon.width/2
        	weapon.y = player.y + player.height/2 - weapon.height/2
        	if weapon.shootDirection == "up" then
        		weapon.y = weapon.y + weapon.yOffset*5
		    elseif weapon.shootDirection == "upLeft" then
		    	weapon.x = weapon.x - weapon.xOffset*2
        		weapon.y = weapon.y + weapon.yOffset*2
		    elseif weapon.shootDirection == "upRight" then
		    	weapon.x = weapon.x + weapon.xOffset*2
        		weapon.y = weapon.y + weapon.yOffset*2
		    elseif weapon.shootDirection == "left" then
		    	weapon.x = weapon.x - weapon.xOffset*4
		    elseif weapon.shootDirection == "right" then
		    	weapon.x = weapon.x + weapon.xOffset*4
		    elseif weapon.shootDirection == "downLeft" then
		    	weapon.x = weapon.x - weapon.xOffset*2
        		weapon.y = weapon.y - weapon.yOffset*2
		    elseif weapon.shootDirection == "downRight" then
		    	weapon.x = weapon.x + weapon.xOffset*2
        		weapon.y = weapon.y - weapon.yOffset*2
		    elseif weapon.shootDirection == "down" then
        		weapon.y = weapon.y - weapon.yOffset*4
		    end
	    elseif weapon.type == "projectile" then
	    	weapon.xVelocity = weapon.xVelocity + weapon.xAcceleration
	    	weapon.yVelocity = weapon.yVelocity + weapon.yAcceleration
	    	weapon.x = weapon.x + weapon.xVelocity
	    	weapon.y = weapon.y + weapon.yVelocity
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
		for x = 1, imageData:getWidth() do
		    for y = 1, imageData:getHeight() do
		        -- Pixel coordinates range from 0 to image width - 1 / height - 1.
		        red, green, blue, alpha = imageData:getPixel(x-1, y-1)
		        if alpha > 0 then
					for _, actor in ipairs(getCollidingActors(weapon:getX() + x-1, weapon:getY() + y-1, 1, 1, false, false, true, false, true, false)) do
						if actor.actor == "npc" then
							if actor.enemy and actor.projectile == false then
								if isInTable(actor.uuid, weapon.enemiesHit) == false then
									if weapon.damage > 0 then
										actor.hp = actor.hp - weapon.damage
										actor.hit = true
										actor.hitCounter = actor.hitLength
				                    	actor.lastHitTimer = 0
				                    	if weapon.type == "projectile" then
											weapon.pierce = weapon.pierce - 1
											if weapon.pierce == 0 then
												table.remove(actors, weapon.index)
											end
				                    	end
				                    end

				                    if weapon.knockbackStrength > 0 then
				                       	actor.knockedBack = true

										actor.knockbackAngle = math.atan2((player.y + player.height/2) - (actor.y + actor.height/2), (player.x + player.width/2) - (actor.x + actor.width/2))
				                        
				                        actor.knockbackDx = math.cos(actor.knockbackAngle)
				                        actor.knockbackDy = math.sin(actor.knockbackAngle)
				                    	actor.xVelocity = -actor.knockbackDx*weapon.knockbackStrength/actor.knockbackResistance
				                    	if actor.ai == "walking" then
				                            actor.yVelocity = actor.knockbackDy*weapon.knockbackStrength/actor.knockbackResistance
				                        end
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
	        		love.graphics.draw(weapon.slashSprite, 0, 0, 0, -1, 1, weapon.width)
	        	else
	        		love.graphics.draw(weapon.endSprite, 0, 0, 0, -1, 1, weapon.width)
	        	end
	        else
	        	if weapon.state == "startup" then
	        		love.graphics.draw(weapon.startupSprite)
	        	elseif weapon.state == "slash" then
	        		love.graphics.draw(weapon.slashSprite)
	        	else
	        		love.graphics.draw(weapon.endSprite)
	        	end
	        end
	    elseif weapon.type == "bow" then
	    	if weapon.shootDirection == "up" then
		    	love.graphics.draw(weapon.sprite1)
		    elseif weapon.shootDirection == "upLeft" then
		    	love.graphics.draw(weapon.sprite2, 0, 0, 0, -1, 1, weapon.width)
		    elseif weapon.shootDirection == "upRight" then
		    	love.graphics.draw(weapon.sprite2)
		    elseif weapon.shootDirection == "left" then
		    	love.graphics.draw(weapon.sprite3, 0, 0, 0, -1, 1, weapon.width)
		    elseif weapon.shootDirection == "right" then
		    	love.graphics.draw(weapon.sprite3, 0, 0, 0, 1, -1, 0, weapon.height)
		    elseif weapon.shootDirection == "downLeft" then
		    	love.graphics.draw(weapon.sprite2, 0, 0, 0, -1, -1, weapon.width, weapon.height)
		    elseif weapon.shootDirection == "downRight" then
		    	love.graphics.draw(weapon.sprite2, 0, 0, 0, 1, -1, 0, weapon.height)
		    elseif weapon.shootDirection == "down" then
		    	love.graphics.draw(weapon.sprite1, 0, 0, 0, 1, -1, 0, weapon.height)
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