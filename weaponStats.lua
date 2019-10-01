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

function getWeaponImages()
	woodenSwordIcon = love.graphics.newImage("images/weapons/swords/woodenSword/woodenSwordIcon.png")
	woodenSwordSpritesheet = love.graphics.newImage("images/weapons/swords/woodenSword/woodenSword.png")

	mushroomSwordIcon = love.graphics.newImage("images/weapons/swords/mushroomSword/mushroomSwordIcon.png")
	mushroomSwordSpritesheet = love.graphics.newImage("images/weapons/swords/mushroomSword/mushroomSword.png")

	grassBladeIcon = love.graphics.newImage("images/weapons/swords/grassBlade/grassBladeIcon.png")
	grassBladeSpritesheet = love.graphics.newImage("images/weapons/swords/grassBlade/grassBlade.png")

	treeSwordIcon = love.graphics.newImage("images/weapons/swords/treeSword/treeSwordIcon.png")
	treeSwordSpritesheet = love.graphics.newImage("images/weapons/swords/treeSword/treeSword.png")

	flowerSwordIcon = love.graphics.newImage("images/weapons/swords/flowerSword/flowerSwordIcon.png")
	flowerSwordSpritesheet = love.graphics.newImage("images/weapons/swords/flowerSword/flowerSword.png")

	thornSwordIcon = love.graphics.newImage("images/weapons/swords/thornSword/thornSwordIcon.png")
	thornSwordSpritesheet = love.graphics.newImage("images/weapons/swords/thornSword/thornSword.png")


	woodenBowIcon = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowIcon.png")
	woodenBowSideSpritesheet = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowSide.png")
	woodenBowUpSpritesheet = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowUp.png")

	woodenArrowIcon = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrowIcon.png")
	woodenArrowSpritesheet = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow.png")

	mushroomBowIcon = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowIcon.png")
	mushroomBowSideSpritesheet = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowSide.png")
	mushroomBowUpSpritesheet = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowUp.png")

	mushroomArrowIcon = love.graphics.newImage("images/weapons/bows/mushroomArrow/mushroomArrowIcon.png")
	mushroomArrowSpritesheet = love.graphics.newImage("images/weapons/bows/mushroomArrow/mushroomArrow.png")

	thornBowIcon = love.graphics.newImage("images/weapons/bows/thornBow/thornBowIcon.png")
	thornBowSideSpritesheet = love.graphics.newImage("images/weapons/bows/thornBow/thornBowSide.png")
	thornBowUpSpritesheet = love.graphics.newImage("images/weapons/bows/thornBow/thornBowUp.png")

	thornArrowIcon = love.graphics.newImage("images/weapons/bows/thornArrow/thornArrowIcon.png")
	thornArrowSpritesheet = love.graphics.newImage("images/weapons/bows/thornArrow/thornArrow.png")

	leafBowIcon = love.graphics.newImage("images/weapons/bows/leafBow/leafBowIcon.png")
	leafBowSideSpritesheet = love.graphics.newImage("images/weapons/bows/leafBow/leafBowSide.png")
	leafBowUpSpritesheet = love.graphics.newImage("images/weapons/bows/leafBow/leafBowUp.png")

	leafArrowIcon = love.graphics.newImage("images/weapons/bows/leafArrow/leafArrowIcon.png")
	leafArrowSpritesheet = love.graphics.newImage("images/weapons/bows/leafArrow/leafArrow.png")
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
			iconSprite = defaultSwordIcon, -- max size: 31x31px
			spritesheet = defaultSwordSpritesheet,
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
			iconSprite = woodenSwordIcon,
			spritesheet = woodenSwordSpritesheet,
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
			iconSprite = mushroomSwordIcon,
			spritesheet = mushroomSwordSpritesheet,
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
			iconSprite = grassBladeIcon,
			spritesheet = grassBladeSpritesheet,
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
			iconSprite = treeSwordIcon,
			spritesheet = treeSwordSpritesheet,
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
			iconSprite = flowerSwordIcon,
			spritesheet = flowerSwordSpritesheet,
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
			iconSprite = thornSwordIcon,
			spritesheet = thornSwordSpritesheet,
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
			spritesheet = woodenBowSideSpritesheet
		else
			spritesheet = woodenBowUpSpritesheet
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = woodenBowIcon,
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
			iconSprite = woodenArrowIcon,
			spritesheet = woodenArrowSpritesheet,
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
			spritesheet = mushroomBowSideSpritesheet
		else
			spritesheet = mushroomBowUpSpritesheet
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = mushroomBowIcon,
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
			iconSprite = mushroomArrowIcon,
			spritesheet = mushroomArrowSpritesheet,
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
			spritesheet = thornBowSideSpritesheet
		else
			spritesheet = thornBowUpSpritesheet
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = thornBowIcon,
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
			iconSprite = thornArrowIcon,
			spritesheet = thornArrowSpritesheet,
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
			spritesheet = leafBowSideSpritesheet
		else
			spritesheet = leafBowUpSpritesheet
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = leafBowIcon,
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
			iconSprite = leafArrowIcon,
			spritesheet = leafArrowSpritesheet,
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