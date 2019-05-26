function getNpcStats(npc)
	local stats = {}

	if npc == "acorn" then
		name = npc
		ai = "walking"
		spritesheet = love.graphics.newImage("images/npcs/enemy/acorn/acornMoveRightSpritesheet.png")
		animationSpeed = 5 -- lower is faster
		animationFrames = 6
		width = spritesheet:getWidth() / animationFrames
		height = spritesheet:getHeight()
		attackAnimationFrames = 11
		attackXOffset = -5
		attackYOffset = 0
		attackHitFrames = {3}
		attackCooldownLength = 20
		attackDistance = 4
		damage = 25
		hp = 90
		knockbackStrength = 2.5
		knockbackResistance = 1.5
		screenShakeAmount = 8
		screenShakeLength = 6
		screenFreezeLength = 4
		xAcceleration = 0.05
		xTerminalVelocity = 0.75
		enemy = true
		money = 20
		boss = false
		projectile = false
		background = true
	end

	if npc == "mushroomMonster" then
		name = npc
		ai = "mushroomMonster"
		spritesheet = love.graphics.newImage("images/npcs/enemy/mushroomMonster/mushroomMonsterMoveRightSpritesheet.png")
		animationSpeed = 7 -- lower is faster
		animationFrames = 5
		width = spritesheet:getWidth() / animationFrames
		height = spritesheet:getHeight()
		attackAnimationFrames = 10
		attackXOffset = 0
		attackYOffset = 0
		attackHitFrames = {6}
		attackCooldownLength = 50
		attackDistance = 2
		damage = 0
		hp = 60
		knockbackStrength = 2.5
		knockbackResistance = 1.5
		screenShakeAmount = 8
		screenShakeLength = 6
		screenFreezeLength = 4
		xAcceleration = 0.05
		xTerminalVelocity = 0.75
		enemy = true
		money = 20
		boss = false
		projectile = false
		background = true
	elseif npc == "poisonCloud" then
		name = npc
		ai = "cloud"
		spritesheet = love.graphics.newImage("images/npcs/enemy/mushroomMonster/poisonCloud.png")
		animationSpeed = 7 -- lower is faster
		animationFrames = 1
		width = spritesheet:getWidth() / animationFrames
		height = spritesheet:getHeight()
		attackAnimationFrames = 1
		attackXOffset = 0
		attackYOffset = 0
		attackHitFrames = {}
		attackCooldownLength = 1
		attackDistance = 1
		damage = 0.5
		hp = 1
		knockbackStrength = 0
		knockbackResistance = 1
		screenShakeAmount = 1
		screenShakeLength = 1
		screenFreezeLength = 0
		xAcceleration = 0
		xTerminalVelocity = 0
		enemy = true
		money = 0
		boss = false
		projectile = true
		background = false
	end

	if npc == "moonfly" then
		name = npc
		ai = "diving"
		spritesheet = love.graphics.newImage("images/npcs/enemy/moonfly/moonflyMoveRightSpritesheet.png")
		animationSpeed = 5 -- lower is faster
		animationFrames = 3
		width = spritesheet:getWidth() / animationFrames
		height = spritesheet:getHeight()
		attackAnimationFrames = 5
		attackXOffset = 0
		attackYOffset = 0
		attackHitFrames = {0, 1}
		attackCooldownLength = 1
		attackDistance = 1
		damage = 25
		hp = 40
		knockbackStrength = 5
		knockbackResistance = 1
		screenShakeAmount = 0
		screenShakeLength = 0
		screenFreezeLength = 0
		xAcceleration = 0.05
		xTerminalVelocity = 1
		enemy = true
		money = 10
		boss = false
		projectile = false
		background = true
	end

	if npc == "upPlant" then
		name = npc
		ai = "shootTurret"
		spritesheet = love.graphics.newImage("images/npcs/enemy/plant/upPlantIdleSpritesheet.png")
		animationSpeed = 5 -- lower is faster
		animationFrames = 6
		width = spritesheet:getWidth() / animationFrames
		height = spritesheet:getHeight()
		attackAnimationFrames = 12
		attackXOffset = 0
		attackYOffset = -4
		attackHitFrames = {7}
		attackCooldownLength = 0
		attackDistance = 0
		damage = 0
		hp = 90
		knockbackStrength = 0
		knockbackResistance = 0
		screenShakeAmount = 0
		screenShakeLength = 0
		screenFreezeLength = 0
		xAcceleration = 0
		xTerminalVelocity = 0
		enemy = true
		money = 20
		boss = false
		projectile = false
		background = false
	elseif npc == "downPlant" then
		name = npc
		ai = "shootTurret"
		spritesheet = love.graphics.newImage("images/npcs/enemy/plant/downPlantIdleSpritesheet.png")
		animationSpeed = 5 -- lower is faster
		animationFrames = 6
		width = spritesheet:getWidth() / animationFrames
		height = spritesheet:getHeight()
		attackAnimationFrames = 12
		attackXOffset = 0
		attackYOffset = -4
		attackHitFrames = {7}
		attackCooldownLength = 0
		attackDistance = 0
		damage = 0
		hp = 90
		knockbackStrength = 0
		knockbackResistance = 0
		screenShakeAmount = 0
		screenShakeLength = 0
		screenFreezeLength = 0
		xAcceleration = 0
		xTerminalVelocity = 0
		enemy = true
		money = 20
		boss = false
		projectile = false
		background = false
	elseif npc == "plantProjectile" then
		background = false
		name = npc
		ai = "projectile"
		spritesheet = love.graphics.newImage("images/npcs/enemy/plant/plantProjectile.png")
		animationSpeed = 6 -- lower is faster
		animationFrames = 2
		width = spritesheet:getWidth() / animationFrames
		height = spritesheet:getHeight()
		attackAnimationFrames = 1
		attackXOffset = 0
		attackYOffset = 0
		attackHitFrames = {}
		attackCooldownLength = 1
		attackDistance = 1
		damage = 20
		hp = 1
		knockbackStrength = 1
		knockbackResistance = 1
		screenShakeAmount = 4
		screenShakeLength = 3
		screenFreezeLength = 3
		xAcceleration = 1
		xTerminalVelocity = 1
		enemy = true
		money = 0
		boss = false
		projectile = true
		background = true
	end

	if npc == "treeMonster" then
		name = npc
		ai = "treeMonster"
		spritesheet = love.graphics.newImage("images/npcs/enemy/treeMonster/treeMonsterMoveRightSpritesheet.png")
		animationSpeed = 5 -- lower is faster
		animationFrames = 1
		width = spritesheet:getWidth() / animationFrames
		height = spritesheet:getHeight()
		attackAnimationFrames = 1
		attackXOffset = 0
		attackYOffset = 0
		attackHitFrames = {}
		attackCooldownLength = 1
		attackDistance = 1
		damage = 25
		hp = 250
		knockbackStrength = 5
		knockbackResistance = 10
		screenShakeAmount = 10
		screenShakeLength = 7
		screenFreezeLength = 6
		xAcceleration = 0.035
		xTerminalVelocity = 0.5
		enemy = true
		money = 100
		boss = true
		projectile = false
		background = true
	end

	if npc == "smiley" then
		name = npc
		ai = "boss"
		spritesheet = love.graphics.newImage("images/npcs/enemy/smiley/smileySpritesheet.png")
		animationSpeed = 5 -- lower is faster
		animationFrames = 1
		width = spritesheet:getWidth() / animationFrames
		height = spritesheet:getHeight()
		attackAnimationFrames = 1
		attackXOffset = 0
		attackYOffset = 0
		attackHitFrames = {}
		attackCooldownLength = 1
		attackDistance = 1
		damage = 25
		hp = 250
		knockbackStrength = 5
		knockbackResistance = 10
		screenShakeAmount = 10
		screenShakeLength = 7
		screenFreezeLength = 6
		xAcceleration = 0.035
		xTerminalVelocity = 0.5
		enemy = true
		money = 100
		boss = true
		projectile = false
		background = true
	elseif npc == "smileyProjectile" then
		name = npc
		ai = "projectile"
		spritesheet = love.graphics.newImage("images/npcs/enemy/smiley/smileyProjectile.png")
		animationSpeed = 1 -- lower is faster
		animationFrames = 1
		width = spritesheet:getWidth() / animationFrames
		height = spritesheet:getHeight()
		attackAnimationFrames = 1
		attackXOffset = 0
		attackYOffset = 0
		attackHitFrames = {}
		attackCooldownLength = 1
		attackDistance = 1
		damage = 1
		hp = 1
		knockbackStrength = 1
		knockbackResistance = 1
		screenShakeAmount = 4
		screenShakeLength = 3
		screenFreezeLength = 3
		xAcceleration = 1
		xTerminalVelocity = 1
		enemy = true
		money = 0
		boss = false
		projectile = true
		background = true
	end

	table.insert(stats, name)
	table.insert(stats, ai)
	table.insert(stats, spritesheet)
	table.insert(stats, animationSpeed)
	table.insert(stats, animationFrames)
	table.insert(stats, width)
	table.insert(stats, height)
	table.insert(stats, attackAnimationFrames)
	table.insert(stats, attackXOffset)
	table.insert(stats, attackYOffset)
	table.insert(stats, attackHitFrames)
	table.insert(stats, attackCooldownLength)
	table.insert(stats, attackDistance)
	table.insert(stats, damage)
	table.insert(stats, hp)
	table.insert(stats, knockbackStrength)
	table.insert(stats, knockbackResistance)
	table.insert(stats, screenShakeAmount)
	table.insert(stats, screenShakeLength)
	table.insert(stats, screenFreezeLength)
	table.insert(stats, xAcceleration)
	table.insert(stats, xTerminalVelocity)
	table.insert(stats, enemy)
	table.insert(stats, money)
	table.insert(stats, boss)
	table.insert(stats, projectile)
	table.insert(stats, background)

	return stats
end