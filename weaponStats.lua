function returnWeaponList()
	local weaponList = {"cobaltBroadsword",
						"demonBroadsword",
						"woodenBow"}
	return weaponList
end

function getWeaponStats(weapon)
	local stats = {}

	weaponType = nil
	iconSprite = nil
	startupSprite = nil
	slash1Sprite = nil
	slash2Sprite = nil
	endSprite = nil
	width = nil
	height = nil
	damage = nil
	knockback = nil
	startupLag = nil
	slashDuration = nil
	endLag = nil
	xOffset = nil
	yOffset = nil
	directionLocked = nil
	movementReduction = nil
	pierce = nil
	projectile = nil

	if weapon == "defaultSword" then
		weaponType = "sword"
		iconSprite = love.graphics.newImage("images/weapons/swords/defaultSword/defaultSwordIcon.png") -- max size: 31x31px
		startupSprite = love.graphics.newImage("images/weapons/swords/defaultSword/defaultSwordStartup.png")
		slash1Sprite = love.graphics.newImage("images/weapons/swords/defaultSword/defaultSwordSlash1.png")
		slash2Sprite = love.graphics.newImage("images/weapons/swords/defaultSword/defaultSwordSlash2.png")
		endSprite = love.graphics.newImage("images/weapons/swords/defaultSword/defaultSwordEnd.png")
		width = slash1Sprite:getWidth()
		height = slash1Sprite:getHeight()
		damage = 50 -- min: 0, max: 100
		knockback = 2.5 -- min: 0, max: 5
		startupLag = 6 -- min: 0, max: 60
		slashDuration = 4 -- min: 0, max: 60
		endLag = 20 -- min: 0, max: 60
		screenShakeAmount = 6
		screenShakeLength = 4
		screenFreezeLength = 4
		xOffset = 0
		yOffset = 0
		directionLocked = true
		movementReduction = 1.5 -- min: 1
		pierce = 0
		projectile = ""
	elseif weapon == "cobaltBroadsword" then
		weaponType = "sword"
		iconSprite = love.graphics.newImage("images/weapons/swords/cobaltBroadsword/cobaltBroadswordIcon.png")
		startupSprite = love.graphics.newImage("images/weapons/swords/cobaltBroadsword/cobaltBroadswordStartup.png")
		slash1Sprite = love.graphics.newImage("images/weapons/swords/cobaltBroadsword/cobaltBroadswordSlash.png")
		slash2Sprite = love.graphics.newImage("images/weapons/swords/cobaltBroadsword/cobaltBroadswordSlash.png")
		endSprite = love.graphics.newImage("images/weapons/swords/cobaltBroadsword/cobaltBroadswordEnd.png")
		width = slash1Sprite:getWidth()
		height = slash1Sprite:getHeight()
		damage = 50
		knockback = 2.5
		startupLag = 6
		slashDuration = 4
		endLag = 20
		screenShakeAmount = 8
		screenShakeLength = 4
		screenFreezeLength = 3
		xOffset = 5
		yOffset = -15
		directionLocked = true
		movementReduction = 1.5
		pierce = 0
		projectile = ""
	elseif weapon == "demonBroadsword" then
		weaponType = "sword"
		iconSprite = love.graphics.newImage("images/weapons/swords/demonBroadsword/demonBroadswordIcon.png")
		startupSprite = love.graphics.newImage("images/weapons/swords/demonBroadsword/demonBroadswordStartup.png")
		slash1Sprite = love.graphics.newImage("images/weapons/swords/demonBroadsword/demonBroadswordSlash1.png")
		slash2Sprite = love.graphics.newImage("images/weapons/swords/demonBroadsword/demonBroadswordSlash2.png")
		endSprite = love.graphics.newImage("images/weapons/swords/demonBroadsword/demonBroadswordEnd.png")
		width = slash1Sprite:getWidth()
		height = slash1Sprite:getHeight()
		damage = 30
		knockback = 2
		startupLag = 5
		slashDuration = 2
		endLag = 13
		screenShakeAmount = 6
		screenShakeLength = 3
		screenFreezeLength = 2
		xOffset = 5
		yOffset = -15
		directionLocked = true
		movementReduction = 1.5
		pierce = 0
		projectile = ""
	end



	if weapon == "woodenBow" then
		weaponType = "bow"
		iconSprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowIcon.png")
		startupSprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBow2.png")
		slash1Sprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBow2.png")
		slash2Sprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBow2.png")
		endSprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBow2.png")
		width = slash1Sprite:getWidth()
		height = slash1Sprite:getHeight()
		damage = 20
		knockback = 1
		startupLag = 3
		slashDuration = 5
		screenShakeAmount = 0
		screenShakeLength = 0
		screenFreezeLength = 0
		endLag = 7
		xOffset = 2
		yOffset = -2
		directionLocked = true
		movementReduction = 2
		pierce = 0
		projectile = "woodenArrow"
	end

	if weapon == "woodenArrow" then
		weaponType = "projectile"
		iconSprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrowIcon.png")
		startupSprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow3.png")
		slash1Sprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow3.png")
		slash2Sprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow3.png")
		endSprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow3.png")
		width = slash1Sprite:getWidth()
		height = slash1Sprite:getHeight()
		damage = 20
		knockback = 1
		startupLag = 0
		slashDuration = 0
		endLag = 0
		screenShakeAmount = 6
		screenShakeLength = 3
		screenFreezeLength = 2
		xOffset = 0
		yOffset = 0
		directionLocked = true
		movementReduction = 0
		pierce = 1
		projectile = ""
	end

	table.insert(stats, weapon)
	table.insert(stats, weaponType)
	table.insert(stats, iconSprite)
	table.insert(stats, startupSprite)
	table.insert(stats, slash1Sprite)
	table.insert(stats, slash2Sprite)
	table.insert(stats, endSprite)
	table.insert(stats, width)
	table.insert(stats, height)
	table.insert(stats, damage)
	table.insert(stats, knockback)
	table.insert(stats, startupLag)
	table.insert(stats, slashDuration)
	table.insert(stats, endLag)
	table.insert(stats, screenShakeAmount)
	table.insert(stats, screenShakeLength)
	table.insert(stats, screenFreezeLength)
	table.insert(stats, xOffset)
	table.insert(stats, yOffset)
	table.insert(stats, directionLocked)
	table.insert(stats, movementReduction)
	table.insert(stats, pierce)
	table.insert(stats, projectile)

	return stats
end