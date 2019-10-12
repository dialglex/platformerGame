function returnWeaponList()
	local weaponList = {"mushroomSword",
						"grassBlade",
						"treeSword",
						"flowerSword",
						"thornSword",
						"stoneSword",

						"mushroomBow",
						"thornBow",
						"leafBow",
						"beeBow",
						"acornBow",
						"featherBow"}
	return weaponList
end

function getWeaponImages()
	woodenSwordIcon = love.graphics.newImage("images/weapons/swords/woodenSword/woodenSwordIcon.png")
	woodenSwordSpritesheet = love.graphics.newImage("images/weapons/swords/woodenSword/woodenSword.png")
	woodenSwordQuads = getQuads(woodenSwordSpritesheet, 4)

	mushroomSwordIcon = love.graphics.newImage("images/weapons/swords/mushroomSword/mushroomSwordIcon.png")
	mushroomSwordSpritesheet = love.graphics.newImage("images/weapons/swords/mushroomSword/mushroomSword.png")
	mushroomSwordQuads = getQuads(mushroomSwordSpritesheet, 4)

	grassBladeIcon = love.graphics.newImage("images/weapons/swords/grassBlade/grassBladeIcon.png")
	grassBladeSpritesheet = love.graphics.newImage("images/weapons/swords/grassBlade/grassBlade.png")
	grassBladeQuads = getQuads(grassBladeSpritesheet, 4)

	treeSwordIcon = love.graphics.newImage("images/weapons/swords/treeSword/treeSwordIcon.png")
	treeSwordSpritesheet = love.graphics.newImage("images/weapons/swords/treeSword/treeSword.png")
	treeSwordQuads = getQuads(treeSwordSpritesheet, 4)

	flowerSwordIcon = love.graphics.newImage("images/weapons/swords/flowerSword/flowerSwordIcon.png")
	flowerSwordSpritesheet = love.graphics.newImage("images/weapons/swords/flowerSword/flowerSword.png")
	flowerSwordQuads = getQuads(flowerSwordSpritesheet, 4)

	thornSwordIcon = love.graphics.newImage("images/weapons/swords/thornSword/thornSwordIcon.png")
	thornSwordSpritesheet = love.graphics.newImage("images/weapons/swords/thornSword/thornSword.png")
	thornSwordQuads = getQuads(thornSwordSpritesheet, 4)

	stoneSwordIcon = love.graphics.newImage("images/weapons/swords/stoneSword/stoneSwordIcon.png")
	stoneSwordSpritesheet = love.graphics.newImage("images/weapons/swords/stoneSword/stoneSword.png")
	stoneSwordQuads = getQuads(stoneSwordSpritesheet, 4)

	woodenBowIcon = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowIcon.png")
	woodenBowSideSpritesheet = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowSide.png")
	woodenBowUpSpritesheet = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowUp.png")
	woodenBowSideQuads = getQuads(woodenBowSideSpritesheet, 4)
	woodenBowUpQuads = getQuads(woodenBowUpSpritesheet, 4)

	woodenArrowIcon = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrowIcon.png")
	woodenArrowSpritesheet = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow.png")
	woodenArrowQuads = getQuads(woodenArrowSpritesheet, 5)

	mushroomBowIcon = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowIcon.png")
	mushroomBowSideSpritesheet = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowSide.png")
	mushroomBowUpSpritesheet = love.graphics.newImage("images/weapons/bows/mushroomBow/mushroomBowUp.png")
	mushroomBowSideQuads = getQuads(mushroomBowSideSpritesheet, 4)
	mushroomBowUpQuads = getQuads(mushroomBowUpSpritesheet, 4)

	mushroomArrowIcon = love.graphics.newImage("images/weapons/bows/mushroomArrow/mushroomArrowIcon.png")
	mushroomArrowSpritesheet = love.graphics.newImage("images/weapons/bows/mushroomArrow/mushroomArrow.png")
	mushroomArrowQuads = getQuads(mushroomArrowSpritesheet, 5)

	thornBowIcon = love.graphics.newImage("images/weapons/bows/thornBow/thornBowIcon.png")
	thornBowSideSpritesheet = love.graphics.newImage("images/weapons/bows/thornBow/thornBowSide.png")
	thornBowUpSpritesheet = love.graphics.newImage("images/weapons/bows/thornBow/thornBowUp.png")
	thornBowSideQuads = getQuads(thornBowSideSpritesheet, 4)
	thornBowUpQuads = getQuads(thornBowUpSpritesheet, 4)

	thornArrowIcon = love.graphics.newImage("images/weapons/bows/thornArrow/thornArrowIcon.png")
	thornArrowSpritesheet = love.graphics.newImage("images/weapons/bows/thornArrow/thornArrow.png")
	thornArrowQuads = getQuads(thornArrowSpritesheet, 5)

	leafBowIcon = love.graphics.newImage("images/weapons/bows/leafBow/leafBowIcon.png")
	leafBowSideSpritesheet = love.graphics.newImage("images/weapons/bows/leafBow/leafBowSide.png")
	leafBowUpSpritesheet = love.graphics.newImage("images/weapons/bows/leafBow/leafBowUp.png")
	leafBowSideQuads = getQuads(leafBowSideSpritesheet, 4)
	leafBowUpQuads = getQuads(leafBowUpSpritesheet, 4)

	leafArrowIcon = love.graphics.newImage("images/weapons/bows/leafArrow/leafArrowIcon.png")
	leafArrowSpritesheet = love.graphics.newImage("images/weapons/bows/leafArrow/leafArrow.png")
	leafArrowQuads = getQuads(leafArrowSpritesheet, 5)

	beeBowIcon = love.graphics.newImage("images/weapons/bows/beeBow/beeBowIcon.png")
	beeBowSideSpritesheet = love.graphics.newImage("images/weapons/bows/beeBow/beeBowSide.png")
	beeBowUpSpritesheet = love.graphics.newImage("images/weapons/bows/beeBow/beeBowUp.png")
	beeBowSideQuads = getQuads(beeBowSideSpritesheet, 4)
	beeBowUpQuads = getQuads(beeBowUpSpritesheet, 4)

	beeArrowIcon = love.graphics.newImage("images/weapons/bows/beeArrow/beeArrowIcon.png")
	beeArrowSpritesheet = love.graphics.newImage("images/weapons/bows/beeArrow/beeArrow.png")
	beeArrowQuads = getQuads(beeArrowSpritesheet, 5)

	acornBowIcon = love.graphics.newImage("images/weapons/bows/acornBow/acornBowIcon.png")
	acornBowSideSpritesheet = love.graphics.newImage("images/weapons/bows/acornBow/acornBowSide.png")
	acornBowUpSpritesheet = love.graphics.newImage("images/weapons/bows/acornBow/acornBowUp.png")
	acornBowSideQuads = getQuads(acornBowSideSpritesheet, 4)
	acornBowUpQuads = getQuads(acornBowUpSpritesheet, 4)

	acornArrowIcon = love.graphics.newImage("images/weapons/bows/acornArrow/acornArrowIcon.png")
	acornArrowSpritesheet = love.graphics.newImage("images/weapons/bows/acornArrow/acornArrow.png")
	acornArrowQuads = getQuads(acornArrowSpritesheet, 5)

	featherBowIcon = love.graphics.newImage("images/weapons/bows/featherBow/featherBowIcon.png")
	featherBowSideSpritesheet = love.graphics.newImage("images/weapons/bows/featherBow/featherBowSide.png")
	featherBowUpSpritesheet = love.graphics.newImage("images/weapons/bows/featherBow/featherBowUp.png")
	featherBowSideQuads = getQuads(featherBowSideSpritesheet, 4)
	featherBowUpQuads = getQuads(featherBowUpSpritesheet, 4)

	featherArrowIcon = love.graphics.newImage("images/weapons/bows/featherArrow/featherArrowIcon.png")
	featherArrowSpritesheet = love.graphics.newImage("images/weapons/bows/featherArrow/featherArrow.png")
	featherArrowQuads = getQuads(featherArrowSpritesheet, 5)

	poisonDartProjectileSprite = love.graphics.newImage("images/weapons/poisonDart.png")
end

function getWeaponStats(weapon)
	local shootDirection
	if player ~= nil then
		shootDirection = player.direction
		if downInputs.up then
			shootDirection = "up"
		elseif downInputs.down then
			shootDirection = "down"
		end
	end

	if weapon == "woodenSword" then
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = woodenSwordIcon,
			spritesheet = woodenSwordSpritesheet,
			quads = woodenSwordQuads,
			damage = 20,
			speed = 50,
			knockback = 30,
			status =  "",
			statusDuration = 0,
			shootDirection = shootDirection,
			xOffset = 1,
			yOffset = -7,
			movementReduction = 1.5,
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
			quads = mushroomSwordQuads,
			damage = 15, -- 15 DoT
			speed = 60,
			knockback = 80,
			status =  "poison", 
			statusDuration = 60*1.5,
			shootDirection = shootDirection,
			xOffset = 1,
			yOffset = -7,
			movementReduction = 1.25,
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
			quads = grassBladeQuads,
			damage = 50,
			speed = 40,
			knockback = 60,
			status =  "", 
			statusDuration = 0,
			shootDirection = shootDirection,
			xOffset = 0,
			yOffset = -7,
			movementReduction = 1.75,
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
			quads = treeSwordQuads,
			damage = 30,
			speed = 70,
			knockback = 40,
			status =  "", 
			statusDuration = 0,
			shootDirection = shootDirection,
			xOffset = 0,
			yOffset = -7,
			movementReduction = 1.25,
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
			quads = flowerSwordQuads,
			damage = 40,
			speed = 60,
			knockback = 50,
			status =  "", 
			statusDuration = 0,
			shootDirection = shootDirection,
			xOffset = 2,
			yOffset = -5,
			movementReduction = 1.5,
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
			quads = thornSwordQuads,
			damage = 25, -- 25 DoT
			speed = 50,
			knockback = 50,
			status = "poison", 
			statusDuration = 60*2.5,
			shootDirection = shootDirection,
			xOffset = 2,
			yOffset = -6,
			movementReduction = 1.5,
			pierce = 0,
			projectile = ""
		}
	end

	if weapon == "stoneSword" then
		return {
			name = weapon,
			weaponType = "sword",
			iconSprite = stoneSwordIcon,
			spritesheet = stoneSwordSpritesheet,
			quads = stoneSwordQuads,
			damage = 60,
			speed = 30,
			knockback = 70,
			status =  "", 
			statusDuration = 0,
			shootDirection = shootDirection,
			xOffset = 0,
			yOffset = -7,
			movementReduction = 1.75,
			pierce = 0,
			projectile = ""
		}
	end



	if weapon == "woodenBow" then
		local spritesheet
		local quads
		if shootDirection == "left" or shootDirection == "right" then
			spritesheet = woodenBowSideSpritesheet
			quads = woodenBowSideQuads
		else
			spritesheet = woodenBowUpSpritesheet
			quads = woodenBowUpQuads
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = woodenBowIcon,
			spritesheet = spritesheet,
			quads = quads,
			damage = 10,
			speed = 50,
			knockback = 10,
			status = "", 
			statusDuration = 0,
			shootDirection = shootDirection,
			sideXOffset = 5.5,
			sideYOffset = -1,
			upXOffset = 1,
			upYOffset = -5,
			downXOffset = 1,
			downYOffset = 8,
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
			quads = woodenArrowQuads,
			damage = 10,
			speed = 0,
			knockback = 10,
			status = "", 
			statusDuration = 0,
			shootDirection = shootDirection,
			movementReduction = 0,
			velocity = 6,
			yAcceleration = 0.2,
			pierce = 1,
			projectile = ""
		}
	end

	if weapon == "mushroomBow" then
		local spritesheet
		local quads
		if shootDirection == "left" or shootDirection == "right" then
			spritesheet = mushroomBowSideSpritesheet
			quads = mushroomBowSideQuads
		else
			spritesheet = mushroomBowUpSpritesheet
			quads = mushroomBowUpQuads
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = mushroomBowIcon,
			spritesheet = spritesheet,
			quads = quads,
			damage = 5, -- 5 DoT
			speed = 60,
			knockback = 60,
			status = "poison", 
			statusDuration = 60*0.5,
			shootDirection = shootDirection,
			sideXOffset = 5.5,
			sideYOffset = -1,
			upXOffset = 1,
			upYOffset = -5,
			downXOffset = 1,
			downYOffset = 8,
			movementReduction = 1.75,
			pierce = 0,
			projectile = "mushroomArrow"
		}
	elseif weapon == "mushroomArrow" then
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = mushroomArrowIcon,
			spritesheet = mushroomArrowSpritesheet,
			quads = mushroomArrowQuads,
			damage = 5, -- 5 DoT
			speed = 0,
			knockback = 60,
			status = "poison", 
			statusDuration = 60*0.5,
			shootDirection = shootDirection,
			movementReduction = 0,
			velocity = 5.5,
			yAcceleration = 0.2,
			pierce = 1,
			projectile = ""
		}
	end

	if weapon == "thornBow" then
		local spritesheet
		local quads
		if shootDirection == "left" or shootDirection == "right" then
			spritesheet = thornBowSideSpritesheet
			quads = thornBowSideQuads
		else
			spritesheet = thornBowUpSpritesheet
			quads = thornBowUpQuads
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = thornBowIcon,
			spritesheet = spritesheet,
			quads = quads,
			damage = 15, -- 15 DoT
			speed = 50,
			knockback = 20,
			status = "poison", 
			statusDuration = 60*1.5,
			shootDirection = shootDirection,
			sideXOffset = 5.5,
			sideYOffset = -1,
			upXOffset = 1,
			upYOffset = -5,
			downXOffset = 1,
			downYOffset = 8,
			movementReduction = 2.25,
			pierce = 0,
			projectile = "thornArrow"
		}
	elseif weapon == "thornArrow" then
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = thornArrowIcon,
			spritesheet = thornArrowSpritesheet,
			quads = thornArrowQuads,
			damage = 15, -- 15 DoT
			speed = 0,
			knockback = 20,
			status = "poison", 
			statusDuration = 60*1.5,
			shootDirection = shootDirection,
			movementReduction = 0,
			velocity = 6,
			yAcceleration = 0.2,
			pierce = 1,
			projectile = ""
		}
	end

	if weapon == "leafBow" then
		local spritesheet
		local quads
		if shootDirection == "left" or shootDirection == "right" then
			spritesheet = leafBowSideSpritesheet
			quads = leafBowSideQuads
		else
			spritesheet = leafBowUpSpritesheet
			quads = leafBowUpQuads
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = leafBowIcon,
			spritesheet = spritesheet,
			quads = quads,
			damage = 10,
			speed = 70,
			knockback = 15,
			status = "", 
			statusDuration = 0,
			shootDirection = shootDirection,
			sideXOffset = 5.5,
			sideYOffset = -1,
			upXOffset = 1,
			upYOffset = -5,
			downXOffset = 1,
			downYOffset = 8,
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
			quads = leafArrowQuads,
			damage = 10,
			speed = 0,
			knockback = 15,
			status = "", 
			statusDuration = 0,
			shootDirection = shootDirection,
			movementReduction = 0,
			velocity = 7,
			yAcceleration = 0.15,
			pierce = 1,
			projectile = ""
		}
	end

	if weapon == "beeBow" then
		local spritesheet
		local quads
		if shootDirection == "left" or shootDirection == "right" then
			spritesheet = beeBowSideSpritesheet
			quads = beeBowSideQuads
		else
			spritesheet = beeBowUpSpritesheet
			quads = beeBowUpQuads
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = beeBowIcon,
			spritesheet = spritesheet,
			quads = quads,
			damage = 15,
			speed = 60,
			knockback = 15,
			status = "", 
			statusDuration = 0,
			shootDirection = shootDirection,
			sideXOffset = 5.5,
			sideYOffset = -1,
			upXOffset = 1,
			upYOffset = -5,
			downXOffset = 1,
			downYOffset = 8,
			movementReduction = 1.75,
			pierce = 0,
			projectile = "beeArrow"
		}
	elseif weapon == "beeArrow" then
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = beeArrowIcon,
			spritesheet = beeArrowSpritesheet,
			quads = beeArrowQuads,
			damage = 15,
			speed = 0,
			knockback = 15,
			status = "", 
			statusDuration = 0,
			shootDirection = shootDirection,
			movementReduction = 0,
			velocity = 6.5,
			yAcceleration = 0.15,
			pierce = 1,
			projectile = ""
		}
	end

	if weapon == "acornBow" then
		local spritesheet
		local quads
		if shootDirection == "left" or shootDirection == "right" then
			spritesheet = acornBowSideSpritesheet
			quads = acornBowSideQuads
		else
			spritesheet = acornBowUpSpritesheet
			quads = acornBowUpQuads
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = acornBowIcon,
			spritesheet = spritesheet,
			quads = quads,
			damage = 25,
			speed = 40,
			knockback = 25,
			status = "",
			statusDuration = 0,
			shootDirection = shootDirection,
			sideXOffset = 5.5,
			sideYOffset = -1,
			upXOffset = 1,
			upYOffset = -5,
			downXOffset = 1,
			downYOffset = 8,
			movementReduction = 2,
			pierce = 0,
			projectile = "acornArrow"
		}
	elseif weapon == "acornArrow" then
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = acornArrowIcon,
			spritesheet = acornArrowSpritesheet,
			quads = acornArrowQuads,
			damage = 25,
			speed = 0,
			knockback = 25,
			status = "", 
			statusDuration = 0,
			shootDirection = shootDirection,
			
			movementReduction = 0,
			velocity = 6,
			yAcceleration = 0.25,
			pierce = 1,
			projectile = ""
		}
	end

	if weapon == "featherBow" then
		local spritesheet
		local quads
		if shootDirection == "left" or shootDirection == "right" then
			spritesheet = featherBowSideSpritesheet
			quads = featherBowSideQuads
		else
			spritesheet = featherBowUpSpritesheet
			quads = featherBowUpQuads
		end
		return {
			name = weapon,
			weaponType = "bow",
			iconSprite = featherBowIcon,
			spritesheet = spritesheet,
			quads = quads,
			damage = 20,
			speed = 50,
			knockback = 10,
			status = "",
			statusDuration = 0,
			shootDirection = shootDirection,
			sideXOffset = 5.5,
			sideYOffset = -1,
			upXOffset = 1,
			upYOffset = -5,
			downXOffset = 1,
			downYOffset = 8,
			movementReduction = 1.5,
			pierce = 0,
			projectile = "featherArrow"
		}
	elseif weapon == "featherArrow" then
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = featherArrowIcon,
			spritesheet = featherArrowSpritesheet,
			quads = featherArrowQuads,
			damage = 20,
			speed = 0,
			knockback = 10,
			status = "", 
			statusDuration = 0,
			shootDirection = shootDirection,
			movementReduction = 0,
			velocity = 7,
			yAcceleration = 0.1,
			pierce = 1,
			projectile = ""
		}
	end

	if weapon == "poisonDart" then
		return {
			name = weapon,
			weaponType = "projectile",
			iconSprite = poisonDartProjectileSprite,
			spritesheet = poisonDartProjectileSprite,
			quads = nil,
			damage = 0,
			speed = 0,
			knockback = 0,
			status = "poison", 
			statusDuration = 60*1,
			shootDirection = shootDirection,
			movementReduction = 0,
			velocity = 8,
			yAcceleration = 0,
			pierce = 1,
			projectile = ""
		}
	end
end