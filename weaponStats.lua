function getWeaponStats(weapon)
    local stats = {}

    if weapon == "cobaltBroadsword" then
        weaponType = "sword"
        iconSprite = love.graphics.newImage("images/weapons/swords/cobaltBroadsword/cobaltBroadswordIcon.png")
        startupSprite = love.graphics.newImage("images/weapons/swords/cobaltBroadsword/cobaltBroadswordStartup.png")
        slashSprite = love.graphics.newImage("images/weapons/swords/cobaltBroadsword/cobaltBroadswordSlash.png")
        endSprite = love.graphics.newImage("images/weapons/swords/cobaltBroadsword/cobaltBroadswordEnd.png")
        sheathSprite = love.graphics.newImage("images/weapons/swords/cobaltBroadsword/cobaltBroadswordSheath.png")
        width = slashSprite:getWidth()
        height = slashSprite:getHeight()
        damage = 1
        knockback = 1.8
        startupLag = 8
        slashDuration = 5
        endLag = 18
        xOffset = 5
        yOffset = -14
        directionLocked = true
        movementReduction = 1.5
    elseif weapon == "demonBroadsword" then
        weaponType = "sword"
        iconSprite = love.graphics.newImage("images/weapons/swords/demonBroadsword/demonBroadswordIcon.png")
        startupSprite = love.graphics.newImage("images/weapons/swords/demonBroadsword/demonBroadswordStartup.png")
        slashSprite = love.graphics.newImage("images/weapons/swords/demonBroadsword/demonBroadswordSlash.png")
        endSprite = love.graphics.newImage("images/weapons/swords/demonBroadsword/demonBroadswordEnd.png")
        sheathSprite = love.graphics.newImage("images/weapons/swords/demonBroadsword/demonBroadswordSheath.png")
        iconSprite = love.graphics.newImage("images/weapons/swords/demonBroadsword/demonBroadswordIcon.png")
        width = slashSprite:getWidth()
        height = slashSprite:getHeight()
        damage = 0.5
        knockback = 1.2
        startupLag = 5
        slashDuration = 2
        endLag = 12
        xOffset = 5
        yOffset = -14
        directionLocked = true
        movementReduction = 1.25
    end



    if weapon == "woodenBow" then
        weaponType = "bow"
        iconSprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowIcon.png")
        startupSprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBow2.png")
        slashSprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBow2.png")
        endSprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBow2.png")
        sheathSprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBow3.png")
        iconSprite = love.graphics.newImage("images/weapons/bows/woodenBow/woodenBowIcon.png")
        width = slashSprite:getWidth()
        height = slashSprite:getHeight()
        damage = 0
        knockback = 0.25
        startupLag = 3
        slashDuration = 6
        endLag = 12
        xOffset = 2
        yOffset = -2
        directionLocked = true
        movementReduction = 1.75
    end



    if weapon == "woodenArrow" then
        weaponType = "projectile"
        iconSprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrowIcon.png")
        startupSprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow3.png")
        slashSprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow3.png")
        endSprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow3.png")
        sheathSprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow1.png")
        iconSprite = love.graphics.newImage("images/weapons/bows/woodenArrow/woodenArrow2.png")
        width = slashSprite:getWidth()
        height = slashSprite:getHeight()
        damage = 1
        knockback = 0.25
        startupLag = 0
        slashDuration = 0
        endLag = 0
        xOffset = 0
        yOffset = 0
        directionLocked = true
        movementReduction = 0
        pierce = 1
    end

    table.insert(stats, weapon)
    table.insert(stats, weaponType)
    table.insert(stats, iconSprite)
    table.insert(stats, startupSprite)
    table.insert(stats, slashSprite)
    table.insert(stats, endSprite)
    table.insert(stats, sheathSprite)
    table.insert(stats, iconSprite)
    table.insert(stats, width)
    table.insert(stats, height)
    table.insert(stats, damage)
    table.insert(stats, knockback)
    table.insert(stats, startupLag)
    table.insert(stats, slashDuration)
    table.insert(stats, endLag)
    table.insert(stats, xOffset)
    table.insert(stats, yOffset)
    table.insert(stats, directionLocked)
    table.insert(stats, movementReduction)
    table.insert(stats, pierce)

    return stats
end