function returnWeaponList()
	local weaponList = {"mushroomSword",
						"grassBlade",
						"treeSword",
						"flowerSword",
						"thornSword",
						-- sword
						"mushroomBow",
						"thornBow",
						"leafBow"}
						-- bow
						-- bow
						-- bow
	return weaponList
end

function getWeaponStats(weapon)
	local shootDirection
	if player ~= nil then
		shootDirection = player.direction
		if downInputs.up then
			shootDirection = "up"
		elseif downInputs.down then
			shootDirection = "down"
		elseif downInputs.left then
			shootDirection = "left"
		elseif downInputs.right then
			shootDirection = "right"
		end
	end

	if weapon == "defaultSword" then
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/defaultSword/defaultSwordIcon.png"), -- max size: 31x31px
			spritesheet = love.graphics.newImage("images/weapons/swords/defaultSword/defaultSword.png"),
			damage = 50, -- min: 0, max: 100
			knockback = 2, -- min: 0, max: 4
			status =  "",
			statusDuration = 0,
			startupLag = 6, -- min: 0, max: 60
			slashDuration = 4, -- min: 0, max: 60
			endLag = 20, -- min: 0, max: 60
			shootDirection = shootDirection,
			screenShakeAmount = 6,
			screenShakeLength = 4,
			screenFreezeLength = 3,
			xOffset = 0,
			yOffset = 0,
			directionLocked = true,
			movementReduction = 1.5, -- min: 1
			pierce = 0,
			projectile = ""
		}
	end

	if weapon == "woodenSword" then
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/woodenSword/woodenSwordIcon.png"),
			spritesheet = love.graphics.newImage("images/weapons/swords/woodenSword/woodenSword.png"),
			damage = 25,
			knockback = 1.5,
			status =  "",
			statusDuration = 0,
			startupLag = 4,
			slashDuration = 3,
			endLag = 13,
			shootDirection = shootDirection,
			screenShakeAmount = 5,
			screenShakeLength = 3,
			screenFreezeLength = 3,
			xOffset = 1,
			yOffset = -7,
			directionLocked = true,
			movementReduction = 1.4,
			pierce = 0,
			projectile = ""
		}
	end

	if weapon == "mushroomSword" then
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/mushroomSword/mushroomSwordIcon.png"),
			spritesheet = love.graphics.newImage("images/weapons/swords/mushroomSword/mushroomSword.png"),
			damage = 25,
			knockback = 3.5,
			status =  "", 
			statusDuration = 0,
			startupLag = 4,
			slashDuration = 3,
			endLag = 16,
			shootDirection = shootDirection,
			screenShakeAmount = 4,
			screenShakeLength = 3,
			screenFreezeLength = 3,
			xOffset = 1,
			yOffset = -7,
			directionLocked = true,
			movementReduction = 1.3,
			pierce = 0,
			projectile = ""
		}
	end

	if weapon == "grassBlade" then
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/grassBlade/grassBladeIcon.png"),
			spritesheet = love.graphics.newImage("images/weapons/swords/grassBlade/grassBlade.png"),
			damage = 50,
			knockback = 2,
			status =  "", 
			statusDuration = 0,
			startupLag = 6,
			slashDuration = 3,
			endLag = 18,
			shootDirection = shootDirection,
			screenShakeAmount = 7,
			screenShakeLength = 4,
			screenFreezeLength = 4,
			xOffset = 0,
			yOffset = -7,
			directionLocked = true,
			movementReduction = 1.6,
			pierce = 0,
			projectile = ""
		}
	end

	if weapon == "treeSword" then
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/treeSword/treeSwordIcon.png"),
			spritesheet = love.graphics.newImage("images/weapons/swords/treeSword/treeSword.png"),
			damage = 25,
			knockback = 1.5,
			status =  "", 
			statusDuration = 0,
			startupLag = 3,
			slashDuration = 3,
			endLag = 10,
			shootDirection = shootDirection,
			screenShakeAmount = 5,
			screenShakeLength = 3,
			screenFreezeLength = 3,
			xOffset = 0,
			yOffset = -7,
			directionLocked = true,
			movementReduction = 1.2,
			pierce = 0,
			projectile = ""
		}
	end

	if weapon == "flowerSword" then
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/flowerSword/flowerSwordIcon.png"),
			spritesheet = love.graphics.newImage("images/weapons/swords/flowerSword/flowerSword.png"),
			damage = 35,
			knockback = 2,
			status =  "", 
			statusDuration = 0,
			startupLag = 4,
			slashDuration = 3,
			endLag = 14,
			shootDirection = shootDirection,
			screenShakeAmount = 6,
			screenShakeLength = 4,
			screenFreezeLength = 4,
			xOffset = 2,
			yOffset = -5,
			directionLocked = true,
			movementReduction = 1.4,
			pierce = 0,
			projectile = ""
		}
	end

	if weapon == "thornSword" then
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/thornSword/thornSwordIcon.png"),
			spritesheet = love.graphics.newImage("images/weapons/swords/thornSword/thornSword.png"),
			damage = 25, -- 25 DoT
			knockback = 1.5,
			status = "poison", 
			statusDuration = 60*2.5,
			startupLag = 5,
			slashDuration = 3,
			endLag = 16,
			shootDirection = shootDirection,
			screenShakeAmount = 6,
			screenShakeLength = 4,
			screenFreezeLength = 4,
			xOffset = 2,
			yOffset = -6,
			directionLocked = true,
			movementReduction = 1.4,
			pierce = 0,
			projectile = ""
		}
	end



	if weapon == "woodenBow" then
		local spritesheet
		if shootDirection == "left" or shootDirection == "right" then
			spritesheet = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowSide.png")
		else
			spritesheet = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowUp.png")
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowIcon.png"),
			spritesheet = spritesheet,
			damage = 15,
			knockback = 0.5,
			status = "", 
			statusDuration = 0,
			startupLag = 7,
			slashDuration = 1,
			endLag = 16,
			shootDirection = shootDirection,
			screenShakeAmount = 0,
			screenShakeLength = 0,
			screenFreezeLength = 0,
			sideXOffset = 5.5,
			sideYOffset = -1,
			upXOffset = 1,
			upYOffset = -5,
			downXOffset = 1,
			downYOffset = 8,
			directionLocked = true,
			movementReduction = 2,
			pierce = 0,
			projectile = "woodenArrow"
		}
	elseif weapon == "woodenArrow" then
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrowIcon.png"),
			spritesheet = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow.png"),
			damage = 15,
			knockback = 0.5,
			status = "", 
			statusDuration = 0,
			startupLag = 0,
			slashDuration = 0,
			endLag = 0,
			shootDirection = shootDirection,
			screenShakeAmount = 4,
			screenShakeLength = 2,
			screenFreezeLength = 2,
			directionLocked = true,
			movementReduction = 0,
			velocity = 6,
			pierce = 1,
			projectile = ""
		}
	end

	if weapon == "mushroomBow" then
		local spritesheet
		if shootDirection == "left" or shootDirection == "right" then
			spritesheet = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowSide.png")
		else
			spritesheet = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowUp.png")
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowIcon.png"),
			spritesheet = spritesheet,
			damage = 15,
			knockback = 3,
			status = "", 
			statusDuration = 0,
			startupLag = 7,
			slashDuration = 1,
			endLag = 16,
			shootDirection = shootDirection,
			screenShakeAmount = 0,
			screenShakeLength = 0,
			screenFreezeLength = 0,
			sideXOffset = 5.5,
			sideYOffset = -1,
			upXOffset = 1,
			upYOffset = -5,
			downXOffset = 1,
			downYOffset = 8,
			directionLocked = true,
			movementReduction = 2,
			pierce = 0,
			projectile = "mushroomArrow"
		}
	elseif weapon == "mushroomArrow" then
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = love.graphics.newImage("images/weapons/bows/mushroomArrow/mushroomArrowIcon.png"),
			spritesheet = love.graphics.newImage("images/weapons/bows/mushroomArrow/mushroomArrow.png"),
			damage = 15,
			knockback = 3,
			status = "", 
			statusDuration = 0,
			startupLag = 0,
			slashDuration = 0,
			endLag = 0,
			shootDirection = shootDirection,
			screenShakeAmount = 4,
			screenShakeLength = 2,
			screenFreezeLength = 2,
			directionLocked = true,
			movementReduction = 0,
			velocity = 5.5,
			pierce = 1,
			projectile = ""
		}
	end

	if weapon == "thornBow" then
		local spritesheet
		if shootDirection == "left" or shootDirection == "right" then
			spritesheet = love.graphics.newImage("images/weapons/bows/thornBow/thornBowSide.png")
		else
			spritesheet = love.graphics.newImage("images/weapons/bows/thornBow/thornBowUp.png")
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = love.graphics.newImage("images/weapons/bows/thornBow/thornBowIcon.png"),
			spritesheet = spritesheet,
			damage = 15, -- 15 DoT
			knockback = 0.5,
			status = "poison", 
			statusDuration = 60*3,
			startupLag = 8,
			slashDuration = 1,
			endLag = 18,
			shootDirection = shootDirection,
			screenShakeAmount = 0,
			screenShakeLength = 0,
			screenFreezeLength = 0,
			sideXOffset = 5.5,
			sideYOffset = -1,
			upXOffset = 1,
			upYOffset = -5,
			downXOffset = 1,
			downYOffset = 8,
			directionLocked = true,
			movementReduction = 2.5,
			pierce = 0,
			projectile = "thornArrow"
		}
	elseif weapon == "thornArrow" then
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = love.graphics.newImage("images/weapons/bows/thornArrow/thornArrowIcon.png"),
			spritesheet = love.graphics.newImage("images/weapons/bows/thornArrow/thornArrow.png"),
			damage = 15, -- 15 DoT
			knockback = 0.5,
			status = "poison", 
			statusDuration = 60*1.5,
			startupLag = 0,
			slashDuration = 0,
			endLag = 0,
			shootDirection = shootDirection,
			screenShakeAmount = 4,
			screenShakeLength = 2,
			screenFreezeLength = 2,
			directionLocked = true,
			movementReduction = 0,
			velocity = 6.5,
			pierce = 1,
			projectile = ""
		}
	end

	if weapon == "leafBow" then
		local spritesheet
		if shootDirection == "left" or shootDirection == "right" then
			spritesheet = love.graphics.newImage("images/weapons/bows/leafBow/leafBowSide.png")
		else
			spritesheet = love.graphics.newImage("images/weapons/bows/leafBow/leafBowUp.png")
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = love.graphics.newImage("images/weapons/bows/leafBow/leafBowIcon.png"),
			spritesheet = spritesheet,
			damage = 20,
			knockback = 0.75,
			status = "", 
			statusDuration = 0,
			startupLag = 6,
			slashDuration = 1,
			endLag = 14,
			shootDirection = shootDirection,
			screenShakeAmount = 0,
			screenShakeLength = 0,
			screenFreezeLength = 0,
			sideXOffset = 5.5,
			sideYOffset = -1,
			upXOffset = 1,
			upYOffset = -5,
			downXOffset = 1,
			downYOffset = 8,
			directionLocked = true,
			movementReduction = 1.5,
			pierce = 0,
			projectile = "leafArrow"
		}
	elseif weapon == "leafArrow" then
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = love.graphics.newImage("images/weapons/bows/leafArrow/leafArrowIcon.png"),
			spritesheet = love.graphics.newImage("images/weapons/bows/leafArrow/leafArrow.png"),
			damage = 20,
			knockback = 0.75,
			status = "", 
			statusDuration = 0,
			startupLag = 0,
			slashDuration = 0,
			endLag = 0,
			shootDirection = shootDirection,
			screenShakeAmount = 4,
			screenShakeLength = 2,
			screenFreezeLength = 2,
			directionLocked = true,
			movementReduction = 0,
			velocity = 7,
			pierce = 1,
			projectile = ""
		}
	end
end