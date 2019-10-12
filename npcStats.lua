function getNpcImages()
	acornMoveRightSpritesheet = love.graphics.newImage("images/npcs/enemy/acorn/acornMoveRightSpritesheet.png")
	acornMoveLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/acorn/acornMoveLeftSpritesheet.png")
	acornMoveQuads = getQuads(acornMoveRightSpritesheet, 6)
	acornAttackRightSpritesheet = love.graphics.newImage("images/npcs/enemy/acorn/acornAttackRightSpritesheet.png")
	acornAttackLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/acorn/acornAttackLeftSpritesheet.png")
	acornAttackQuads = getQuads(acornAttackRightSpritesheet, 11)
	acornHoverRightSpritesheet = love.graphics.newImage("images/npcs/enemy/acorn/acornHoverRightSpritesheet.png")
	acornHoverLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/acorn/acornHoverLeftSpritesheet.png")
	acornHoverQuads = getQuads(acornHoverRightSpritesheet, 2)

	mushroomMonsterMoveRightSpritesheet = love.graphics.newImage("images/npcs/enemy/mushroomMonster/mushroomMonsterMoveRightSpritesheet.png")
	mushroomMonsterMoveLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/mushroomMonster/mushroomMonsterMoveLeftSpritesheet.png")
	mushroomMonsterMoveQuads = getQuads(mushroomMonsterMoveRightSpritesheet, 5)
	mushroomMonsterAttackRightSpritesheet = love.graphics.newImage("images/npcs/enemy/mushroomMonster/mushroomMonsterAttackRightSpritesheet.png")
	mushroomMonsterAttackLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/mushroomMonster/mushroomMonsterAttackLeftSpritesheet.png")
	mushroomMonsterAttackQuads = getQuads(mushroomMonsterAttackRightSpritesheet, 10)
	poisonCloudSpritesheet = love.graphics.newImage("images/npcs/enemy/mushroomMonster/poisonCloud.png")
	poisonCloudQuads = getQuads(poisonCloudSpritesheet, 18)

	upPlantIdleSpritesheet = love.graphics.newImage("images/npcs/enemy/plant/upPlantIdleSpritesheet.png")
	downPlantIdleSpritesheet = love.graphics.newImage("images/npcs/enemy/plant/downPlantIdleSpritesheet.png")
	plantIdleQuads = getQuads(upPlantIdleSpritesheet, 6)
	upPlantAttackSpritesheet = love.graphics.newImage("images/npcs/enemy/plant/upPlantAttackSpritesheet.png")
	downPlantAttackSpritesheet = love.graphics.newImage("images/npcs/enemy/plant/downPlantAttackSpritesheet.png")
	plantAttackQuads = getQuads(upPlantAttackSpritesheet, 12)
	plantProjectileSpritesheet = love.graphics.newImage("images/npcs/enemy/plant/plantProjectile.png")
	plantProjectileQuads = getQuads(plantProjectileSpritesheet, 3)

	fuzzyMoveRightSpritesheet = love.graphics.newImage("images/npcs/enemy/fuzzy/fuzzyMoveRightSpritesheet.png")
	fuzzyMoveLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/fuzzy/fuzzyMoveLeftSpritesheet.png")
	fuzzyMoveQuads = getQuads(fuzzyMoveRightSpritesheet, 6)
	fuzzyAttackRightSpritesheet = love.graphics.newImage("images/npcs/enemy/fuzzy/fuzzyAttackRightSpritesheet.png")
	fuzzyAttackLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/fuzzy/fuzzyAttackLeftSpritesheet.png")
	fuzzyAttackQuads = getQuads(fuzzyAttackRightSpritesheet, 6)

	acornKingMoveRightSpritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornKingMoveRightSpritesheet.png")
	acornKingMoveLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornKingMoveLeftSpritesheet.png")
	acornKingMoveQuads = getQuads(acornKingMoveRightSpritesheet, 6)
	acornKingAttackRightSpritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornKingAttackRightSpritesheet.png")
	acornKingAttackLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornKingAttackLeftSpritesheet.png")
	acornKingAttackQuads = getQuads(acornKingAttackRightSpritesheet, 15)
	acornProjectileRotation1Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile1.png")
	acornProjectileRotation2Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile2.png")
	acornProjectileRotation3Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile3.png")
	acornProjectileRotation4Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile4.png")
	acornProjectileRotation5Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile5.png")
	acornProjectileRotation6Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile6.png")
	acornProjectileRotation7Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile7.png")
	acornProjectileRotation8Spritesheet = love.graphics.newImage("images/npcs/enemy/acornKing/acornProjectile8.png")
	acornProjectileQuads = getQuads(acornProjectileRotation1Spritesheet, 3)

	moonflyMoveRightSpritesheet = love.graphics.newImage("images/npcs/enemy/moonfly/moonflyMoveRightSpritesheet.png")
	moonflyMoveLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/moonfly/moonflyMoveLeftSpritesheet.png")
	moonflyMoveQuads = getQuads(moonflyMoveRightSpritesheet, 3)
	moonflyAttackRightSpritesheet = love.graphics.newImage("images/npcs/enemy/moonfly/moonflyAttackRightSpritesheet.png")
	moonflyAttackLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/moonfly/moonflyAttackLeftSpritesheet.png")
	moonflyAttackQuads = getQuads(moonflyAttackRightSpritesheet, 5)
	moonflyDiveRightSpritesheet = love.graphics.newImage("images/npcs/enemy/moonfly/moonflyDiveRightSpritesheet.png")
	moonflyDiveLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/moonfly/moonflyDiveLeftSpritesheet.png")
	moonflyDiveQuads = getQuads(moonflyDiveRightSpritesheet, 2)
	moonflyStuckRightSpritesheet = love.graphics.newImage("images/npcs/enemy/moonfly/moonflyStuckRightSpritesheet.png")
	moonflyStuckLeftSpritesheet = love.graphics.newImage("images/npcs/enemy/moonfly/moonflyStuckLeftSpritesheet.png")
	moonflyStuckQuads = getQuads(moonflyStuckRightSpritesheet, 2)
end

function getNpcStats(npc)
	if npc == "acorn" then
		return {
			name = npc,
			ai = "walking",
			spritesheet = acornMoveRightSpritesheet,
			animationSpeed = 5, -- lower is faster
			attackAnimationSpeed = 5,
			animationFrames = 6,
			hitboxX = 5,
			hitboxWidth = 16,
			hitboxY = 5,
			hitboxHeight = 20,
			attackHitboxX = 10,
			attackHitboxWidth = 16,
			attackHitboxY = 5,
			attackHitboxHeight = 21,
			attackAnimationFrames = 11,
			attackYOffset = -1,
			attackHitFrames = {4}, -- starts from 1
			attackCooldownLength = 0,
			attackDistance = 4,
			wallDistance = 6,
			hp = 90,
			damage = 15,
			knockback = 2.5,
			knockbackResistance = 1.1,
			screenShakeAmount = 8,
			screenShakeLength = 6,
			screenFreezeLength = 4,
			xAcceleration = 0.05,
			xTerminalVelocity = 0.75,
			yAcceleration = 0.075,
			yTerminalVelocity = 0.6,
			towardsPlayer = false,
			enemy = true,
			money = 8,
			boss = false,
			projectile = false,
			background = true
		}
	end

	if npc == "mushroomMonster" then
		return {
			name = npc,
			ai = "mushroomMonster",
			spritesheet = mushroomMonsterMoveRightSpritesheet,
			animationSpeed = 7, -- lower is faster
			attackAnimationSpeed = 7,
			animationFrames = 5,
			hitboxX = 0,
			hitboxWidth = 27,
			hitboxY = 0,
			hitboxHeight = 23,
			attackHitboxX = 0,
			attackHitboxWidth = 22,
			attackHitboxY = 0,
			attackHitboxHeight = 23,
			attackAnimationFrames = 10,
			attackYOffset = 0,
			attackHitFrames = {7}, -- starts from 1
			attackCooldownLength = 18*5,
			attackDistance = 0,
			wallDistance = 2,
			hp = 70,
			damage = 0,
			knockback = 0,
			knockbackResistance = 0.9,
			screenShakeAmount = 8,
			screenShakeLength = 6,
			screenFreezeLength = 4,
			xAcceleration = 0.05,
			xTerminalVelocity = 0.75,
			yAcceleration = 0.075,
			yTerminalVelocity = 6,
			towardsPlayer = false,
			enemy = true,
			money = 7,
			boss = false,
			projectile = false,
			background = true
		}
	elseif npc == "poisonCloud" then
		return {
			name = npc,
			ai = "cloud",
			spritesheet = poisonCloudSpritesheet,
			animationSpeed = 5, -- lower is faster
			attackAnimationSpeed = 5,
			animationFrames = 18,
			hitboxX = 0,
			hitboxWidth = 48,
			hitboxY = 0,
			hitboxHeight = 48,
			attackHitboxX = 0,
			attackHitboxWidth = 48,
			attackHitboxY = 0,
			attackHitboxHeight = 48,
			attackAnimationFrames = 1,
			attackYOffset = 0,
			attackHitFrames = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}, -- starts from 1
			attackCooldownLength = 0,
			attackDistance = 0,
			wallDistance = 0,
			hp = 1,
			damage = 1/2.75, -- 20 damage total over 11 frames
			knockback = 0,
			knockbackResistance = 1,
			screenShakeAmount = 1,
			screenShakeLength = 1,
			screenFreezeLength = 0,
			xAcceleration = 0,
			xTerminalVelocity = 0,
			yAcceleration = 0,
			yTerminalVelocity = 0,
			towardsPlayer = false,
			enemy = true,
			money = 0,
			boss = false,
			projectile = true,
			background = false
		}
	end

	if npc == "upPlant" then
		return {
			name = npc,
			ai = "shootTurret",
			spritesheet = upPlantIdleSpritesheet,
			animationSpeed = 6, -- lower is faster
			attackAnimationSpeed = 6,
			animationFrames = 6,
			hitboxX = 0,
			hitboxWidth = 32,
			hitboxY = 0,
			hitboxHeight = 21,
			attackHitboxX = 0,
			attackHitboxWidth = 32,
			attackHitboxY = 0,
			attackHitboxHeight = 29,
			attackAnimationFrames = 12,
			attackYOffset = -4,
			attackHitFrames = {8}, -- starts from 1
			attackCooldownLength = 0,
			attackDistance = 0,
			wallDistance = 0,
			hp = 80,
			damage = 0,
			knockback = 0,
			knockbackResistance = 0,
			screenShakeAmount = 0,
			screenShakeLength = 0,
			screenFreezeLength = 0,
			xAcceleration = 0,
			xTerminalVelocity = 0,
			yAcceleration = 0,
			yTerminalVelocity = 0,
			towardsPlayer = false,
			enemy = true,
			money = 8,
			boss = false,
			projectile = false,
			background = false
		}
	elseif npc == "downPlant" then
		return {
			name = npc,
			ai = "shootTurret",
			spritesheet = downPlantIdleSpritesheet,
			animationSpeed = 6, -- lower is faster
			attackAnimationSpeed = 6,
			animationFrames = 6,
			hitboxX = 0,
			hitboxWidth = 32,
			hitboxY = 0,
			hitboxHeight = 21,
			attackHitboxX = 0,
			attackHitboxWidth = 32,
			attackHitboxY = 0,
			attackHitboxHeight = 29,
			attackAnimationFrames = 12,
			attackYOffset = -4,
			attackHitFrames = {8}, -- starts from 1
			attackCooldownLength = 0,
			attackDistance = 0,
			wallDistance = 0,
			hp = 80,
			damage = 0,
			knockback = 0,
			knockbackResistance = 0,
			screenShakeAmount = 0,
			screenShakeLength = 0,
			screenFreezeLength = 0,
			xAcceleration = 0,
			xTerminalVelocity = 0,
			yAcceleration = 0,
			yTerminalVelocity = 0,
			towardsPlayer = false,
			enemy = true,
			money = 8,
			boss = false,
			projectile = false,
			background = false
		}
	elseif npc == "plantProjectile" then
		return {
			name = npc,
			ai = "projectile",
			spritesheet = plantProjectileSpritesheet,
			animationSpeed = 5, -- lower is faster
			attackAnimationSpeed = 5,
			animationFrames = 3,
			hitboxX = 0,
			hitboxWidth = 16,
			hitboxY = 0,
			hitboxHeight = 16,
			attackHitboxX = 0,
			attackHitboxWidth = 16,
			attackHitboxY = 0,
			attackHitboxHeight = 16,
			attackAnimationFrames = 1,
			attackYOffset = 0,
			attackHitFrames = {1, 2, 3}, -- starts from 1
			attackCooldownLength = 0,
			attackDistance = 0,
			wallDistance = 0,
			hp = 1,
			damage = 10,
			knockback = 1,
			knockbackResistance = 1,
			screenShakeAmount = 4,
			screenShakeLength = 3,
			screenFreezeLength = 3,
			xAcceleration = 0,
			xTerminalVelocity = 0,
			yAcceleration = 0,
			yTerminalVelocity = 0,
			towardsPlayer = false,
			enemy = true,
			money = 0,
			boss = false,
			projectile = true,
			background = true
		}
	end

	if npc == "fuzzy" then
		return {
			name = npc,
			ai = "flying",
			spritesheet = fuzzyMoveRightSpritesheet,
			animationSpeed = 4, -- lower is faster
			attackAnimationSpeed = 4,
			animationFrames = 6,
			hitboxX = 4,
			hitboxWidth = 20,
			hitboxY = 3,
			hitboxHeight = 17,
			attackHitboxX = 0,
			attackHitboxWidth = 27,
			attackHitboxY = 0,
			attackHitboxHeight = 23,
			attackAnimationFrames = 6,
			attackYOffset = 0,
			attackHitFrames = {},
			attackCooldownLength = 0,
			attackDistance = 0,
			wallDistance = 6,
			hp = 50,
			damage = 10,
			knockback = 2.5,
			knockbackResistance = 0.8,
			screenShakeAmount = 0,
			screenShakeLength = 0,
			screenFreezeLength = 0,
			xAcceleration = 0.05,
			xTerminalVelocity = 1,
			yAcceleration = 0,
			yTerminalVelocity = 0,
			towardsPlayer = false,
			enemy = true,
			money = 6,
			boss = false,
			projectile = false,
			background = true
		}
	end

	if npc == "acornKing" then
		return {
			name = npc,
			ai = "acornKing",
			spritesheet = acornKingMoveRightSpritesheet,
			animationSpeed = 8, -- lower is faster
			attackAnimationSpeed = 7,
			animationFrames = 6,
			hitboxX = 30,
			hitboxWidth = 38,
			hitboxY = 10,
			hitboxHeight = 44,
			attackHitboxX = 37,
			attackHitboxWidth = 41,
			attackHitboxY = 20,
			attackHitboxHeight = 44,
			attackAnimationFrames = 15,
			attackYOffset = -10,
			attackHitFrames = {6}, -- starts from 1
			attackCooldownLength = 0,
			attackDistance = 16,
			wallDistance = 4,
			hp = 1000,
			damage = 20,
			knockback = 5,
			knockbackResistance = 5,
			screenShakeAmount = 14,
			screenShakeLength = 8,
			screenFreezeLength = 5,
			xAcceleration = 0.15,
			xTerminalVelocity = 0.75,
			yAcceleration = 0.2,
			yTerminalVelocity = 6,
			towardsPlayer = true,
			enemy = true,
			money = 50,
			boss = true,
			projectile = false,
			background = true
		}
	elseif npc == "acornProjectile" then
		return {
			name = npc,
			ai = "projectile",
			spritesheet = acornProjectileRotation1Spritesheet,
			animationSpeed = 5, -- lower is faster
			attackAnimationSpeed = 5,
			animationFrames = 3,
			hitboxX = 0,
			hitboxWidth = 16,
			hitboxY = 0,
			hitboxHeight = 16,
			attackHitboxX = 0,
			attackHitboxWidth = 16,
			attackHitboxY = 0,
			attackHitboxHeight = 16,
			attackAnimationFrames = 1,
			attackYOffset = 0,
			attackHitFrames = {1, 2, 3}, -- starts from 1
			attackCooldownLength = 0,
			attackDistance = 0,
			wallDistance = 0,
			hp = 1,
			damage = 10,
			knockback = 1,
			knockbackResistance = 1,
			screenShakeAmount = 4,
			screenShakeLength = 3,
			screenFreezeLength = 3,
			xAcceleration = 0,
			xTerminalVelocity = 0,
			yAcceleration = 0.075,
			yTerminalVelocity = 0,
			towardsPlayer = false,
			enemy = true,
			money = 0,
			boss = false,
			projectile = true,
			background = true
		}
	end

	if npc == "moonfly" then
		return {
			name = npc,
			ai = "diving",
			spritesheet = moonflyMoveRightSpritesheet,
			animationSpeed = 5, -- lower is faster
			attackAnimationSpeed = 5,
			animationFrames = 3,
			hitboxX = 0,
			hitboxWidth = 18,
			hitboxY = 0,
			hitboxHeight = 14,
			attackHitboxX = 1,
			attackHitboxWidth = 16,
			attackHitboxY = 0,
			attackHitboxHeight = 13,
			-- maybe add seperate hitboxes for diving
			attackAnimationFrames = 5,
			attackYOffset = 0,
			attackHitFrames = {1, 2}, -- starts from 1
			attackCooldownLength = 0,
			attackDistance = 0,
			wallDistance = 10,
			hp = 50,
			damage = 20,
			knockback = 2.5,
			knockbackResistance = 0.8,
			screenShakeAmount = 0,
			screenShakeLength = 0,
			screenFreezeLength = 0,
			xAcceleration = 0.05,
			xTerminalVelocity = 1,
			yAcceleration = 0,
			yTerminalVelocity = 0,
			towardsPlayer = false,
			enemy = true,
			money = 6,
			boss = false,
			projectile = false,
			background = true
		}
	end
end