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
	if weapon == "defaultSword" then
		local sprite = love.graphics.newImage("images/weapons/swords/defaultSword/defaultSwordSlash1.png")
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/defaultSword/defaultSwordIcon.png"), -- max size: 31x31px
			startupSprite = love.graphics.newImage("images/weapons/swords/defaultSword/defaultSwordStartup.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/swords/defaultSword/defaultSwordSlash2.png"),
			endSprite = love.graphics.newImage("images/weapons/swords/defaultSword/defaultSwordEnd.png"),
			damage = 50, -- min: 0, max: 100
			knockback = 2, -- min: 0, max: 4
			status =  "",
			statusDuration = 0,
			startupLag = 6, -- min: 0, max: 60
			slashDuration = 4, -- min: 0, max: 60
			endLag = 20, -- min: 0, max: 60
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
		local sprite = love.graphics.newImage("images/weapons/swords/woodenSword/woodenSwordSlash1.png")
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/woodenSword/woodenSwordIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/swords/woodenSword/woodenSwordStartup.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/swords/woodenSword/woodenSwordSlash2.png"),
			endSprite = love.graphics.newImage("images/weapons/swords/woodenSword/woodenSwordEnd.png"),
			damage = 25,
			knockback = 1.5,
			status =  "",
			statusDuration = 0,
			startupLag = 4,
			slashDuration = 3,
			endLag = 13,
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
		local sprite = love.graphics.newImage("images/weapons/swords/mushroomSword/mushroomSwordSlash1.png")
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/mushroomSword/mushroomSwordIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/swords/mushroomSword/mushroomSwordStartup.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/swords/mushroomSword/mushroomSwordSlash2.png"),
			endSprite = love.graphics.newImage("images/weapons/swords/mushroomSword/mushroomSwordEnd.png"),
			damage = 25,
			knockback = 3.5,
			status =  "", 
			statusDuration = 0,
			startupLag = 4,
			slashDuration = 3,
			endLag = 16,
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
		local sprite = love.graphics.newImage("images/weapons/swords/grassBlade/grassBladeSlash1.png")
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/grassBlade/grassBladeIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/swords/grassBlade/grassBladeStartup.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/swords/grassBlade/grassBladeSlash2.png"),
			endSprite = love.graphics.newImage("images/weapons/swords/grassBlade/grassBladeEnd.png"),
			damage = 50,
			knockback = 2,
			status =  "", 
			statusDuration = 0,
			startupLag = 6,
			slashDuration = 3,
			endLag = 18,
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
		local sprite = love.graphics.newImage("images/weapons/swords/treeSword/treeSwordSlash1.png")
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/treeSword/treeSwordIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/swords/treeSword/treeSwordStartup.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/swords/treeSword/treeSwordSlash2.png"),
			endSprite = love.graphics.newImage("images/weapons/swords/treeSword/treeSwordEnd.png"),
			damage = 25,
			knockback = 1.5,
			status =  "", 
			statusDuration = 0,
			startupLag = 3,
			slashDuration = 3,
			endLag = 10,
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
		local sprite = love.graphics.newImage("images/weapons/swords/flowerSword/flowerSwordSlash1.png")
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/flowerSword/flowerSwordIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/swords/flowerSword/flowerSwordStartup.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/swords/flowerSword/flowerSwordSlash2.png"),
			endSprite = love.graphics.newImage("images/weapons/swords/flowerSword/flowerSwordEnd.png"),
			damage = 35,
			knockback = 2,
			status =  "", 
			statusDuration = 0,
			startupLag = 4,
			slashDuration = 3,
			endLag = 14,
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
		local sprite = love.graphics.newImage("images/weapons/swords/thornSword/thornSwordSlash1.png")
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = love.graphics.newImage("images/weapons/swords/thornSword/thornSwordIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/swords/thornSword/thornSwordStartup.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/swords/thornSword/thornSwordSlash2.png"),
			endSprite = love.graphics.newImage("images/weapons/swords/thornSword/thornSwordEnd.png"),
			damage = 25, -- 25 DoT
			knockback = 1.5,
			status = "poison", 
			statusDuration = 60*2.5,
			startupLag = 5,
			slashDuration = 3,
			endLag = 16,
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
		local sprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowSide.png")
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowSide.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowSide.png"),
			endSprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowSide.png"),
			damage = 15,
			knockback = 0.5,
			status = "", 
			statusDuration = 0,
			startupLag = 7,
			slashDuration = 1,
			endLag = 16,
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
		local sprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow3.png")
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrowIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow3.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow3.png"),
			endSprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow3.png"),
			damage = 15,
			knockback = 0.5,
			status = "", 
			statusDuration = 0,
			startupLag = 0,
			slashDuration = 0,
			endLag = 0,
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
		local sprite = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowSide.png")
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowSide.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowSide.png"),
			endSprite = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowSide.png"),
			damage = 15,
			knockback = 3,
			status = "", 
			statusDuration = 0,
			startupLag = 7,
			slashDuration = 1,
			endLag = 16,
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
		local sprite = love.graphics.newImage("images/weapons/bows/mushroomArrow/mushroomArrow3.png")
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = love.graphics.newImage("images/weapons/bows/mushroomArrow/mushroomArrowIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/bows/mushroomArrow/mushroomArrow3.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/bows/mushroomArrow/mushroomArrow3.png"),
			endSprite = love.graphics.newImage("images/weapons/bows/mushroomArrow/mushroomArrow3.png"),
			damage = 15,
			knockback = 3,
			status = "", 
			statusDuration = 0,
			startupLag = 0,
			slashDuration = 0,
			endLag = 0,
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
		local sprite = love.graphics.newImage("images/weapons/bows/thornBow/thornBowSide.png")
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = love.graphics.newImage("images/weapons/bows/thornBow/thornBowIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/bows/thornBow/thornBowSide.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/bows/thornBow/thornBowSide.png"),
			endSprite = love.graphics.newImage("images/weapons/bows/thornBow/thornBowSide.png"),
			damage = 15, -- 15 DoT
			knockback = 0.5,
			status = "poison", 
			statusDuration = 60*3,
			startupLag = 8,
			slashDuration = 1,
			endLag = 18,
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
		local sprite = love.graphics.newImage("images/weapons/bows/thornArrow/thornArrow3.png")
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = love.graphics.newImage("images/weapons/bows/thornArrow/thornArrowIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/bows/thornArrow/thornArrow3.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/bows/thornArrow/thornArrow3.png"),
			endSprite = love.graphics.newImage("images/weapons/bows/thornArrow/thornArrow3.png"),
			damage = 15, -- 15 DoT
			knockback = 0.5,
			status = "poison", 
			statusDuration = 60*1.5,
			startupLag = 0,
			slashDuration = 0,
			endLag = 0,
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
		local sprite = love.graphics.newImage("images/weapons/bows/leafBow/leafBowSide.png")
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = love.graphics.newImage("images/weapons/bows/leafBow/leafBowIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/bows/leafBow/leafBowSide.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/bows/leafBow/leafBowSide.png"),
			endSprite = love.graphics.newImage("images/weapons/bows/leafBow/leafBowSide.png"),
			damage = 20,
			knockback = 0.75,
			status = "", 
			statusDuration = 0,
			startupLag = 6,
			slashDuration = 1,
			endLag = 14,
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
		local sprite = love.graphics.newImage("images/weapons/bows/leafArrow/leafArrow3.png")
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = love.graphics.newImage("images/weapons/bows/leafArrow/leafArrowIcon.png"),
			startupSprite = love.graphics.newImage("images/weapons/bows/leafArrow/leafArrow3.png"),
			slash1Sprite = sprite,
			slash2Sprite = love.graphics.newImage("images/weapons/bows/leafArrow/leafArrow3.png"),
			endSprite = love.graphics.newImage("images/weapons/bows/leafArrow/leafArrow3.png"),
			damage = 20,
			knockback = 0.75,
			status = "", 
			statusDuration = 0,
			startupLag = 0,
			slashDuration = 0,
			endLag = 0,
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