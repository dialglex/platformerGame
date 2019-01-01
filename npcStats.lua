function getNpcStats(npc)
	local stats = {}
	if npc == "moonfly" then
		actor = npc
    	ai = "flying"
        sprite = love.graphics.newImage("images/npcs/enemy/moonfly/moonflySpritesheet.png")
        animationSpeed = 5 -- lower is faster
        animationFrames = 9
        width = sprite:getWidth() / animationFrames
        height = sprite:getHeight()
        damage = 1
        hp = 2
        knockbackStrength = 5
        knockbackResistance = 1 
        xAcceleration = 0.035
        xTerminalVelocity = 1
        enemy = true
        xp = 1
        boss = false
        projectile = false
    elseif npc == "oldMan" then
        actor = npc
        ai = "walking"
        sprite = love.graphics.newImage("images/npcs/friendly/oldMan/oldManIdleRightSpritesheet.png")
        animationSpeed = 10 -- lower is faster
        animationFrames = 2
        width = sprite:getWidth() / animationFrames
        height = sprite:getHeight()
        damage = 1
        hp = 3
        knockbackStrength = 5
        knockbackResistance = 1
        xAcceleration = 0.05
        xTerminalVelocity = 1
        enemy = false
        xp = 2
        boss = false
        projectile = false
    elseif npc == "blueSlime" then
        actor = npc
        ai = "walking"
        sprite = love.graphics.newImage("images/npcs/enemy/blueSlime/blueSlimeWalkRightSpritesheet.png")
        animationSpeed = 5 -- lower is faster
        animationFrames = 6
        width = sprite:getWidth() / animationFrames
        height = sprite:getHeight()
        damage = 1
        hp = 3
        knockbackStrength = 2.5
        knockbackResistance = 0.5
        xAcceleration = 0.05
        xTerminalVelocity = 0.75
        enemy = true
        xp = 3
        boss = false
        projectile = false
    elseif npc == "smiley" then
        actor = npc
        ai = "boss"
        sprite = love.graphics.newImage("images/npcs/enemy/smiley/smileySpritesheet.png")
        animationSpeed = 5 -- lower is faster
        animationFrames = 1
        width = sprite:getWidth() / animationFrames
        height = sprite:getHeight()
        damage = 1
        hp = 10
        knockbackStrength = 5
        knockbackResistance = 10
        xAcceleration = 0.035
        xTerminalVelocity = 0.5
        enemy = true
        xp = 20
        boss = true
        projectile = false
    elseif npc == "smileyProjectile" then
        actor = npc
        ai = "projectile"
        sprite = love.graphics.newImage("images/npcs/enemy/smiley/smileyProjectile.png")
        animationSpeed = 5 -- lower is faster
        animationFrames = 1
        width = sprite:getWidth() / animationFrames
        height = sprite:getHeight()
        damage = 1
        hp = 1
        knockbackStrength = 1
        knockbackResistance = 1
        xAcceleration = 1
        xTerminalVelocity = 1
        enemy = true
        xp = 0
        boss = false
        projectile = true
    end

    table.insert(stats, actor)
	table.insert(stats, ai)
	table.insert(stats, sprite)
	table.insert(stats, animationSpeed)
	table.insert(stats, animationFrames)
	table.insert(stats, width)
	table.insert(stats, height)
    table.insert(stats, damage)
	table.insert(stats, hp)
	table.insert(stats, knockbackStrength)
	table.insert(stats, knockbackResistance)
	table.insert(stats, xAcceleration)
	table.insert(stats, xTerminalVelocity)
    table.insert(stats, enemy)
    table.insert(stats, xp)
    table.insert(stats, boss)
    table.insert(stats, projectile)

	return stats
end