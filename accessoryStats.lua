function returnAccessoryList()
	local accessoryList = {"gumBoots", -- 1
						   "arcaneFeather", -- 2
						   "magicFungus", -- 3
						   "lifeFruit", -- 4
						   "ballOfThorns", -- 5
						   "squishyMushroom", -- 6
						   "anti-antidote", -- 7
						   "corrosiveSubstance", -- 8
						   "poisonVial", -- 9
						   "viralPoison", -- 10
						   "stickyOoze", -- 11
						   "boilingToxin"} -- 12
	return accessoryList
end

function getAccessoryImages()
	gumBootsSprite = love.graphics.newImage("images/accessories/gumBoots.png")
	arcaneFeatherSprite = love.graphics.newImage("images/accessories/arcaneFeather.png")
	magicFungusSprite = love.graphics.newImage("images/accessories/magicFungus.png")
	lifeFruitSprite = love.graphics.newImage("images/accessories/lifeFruit.png")
	ballOfThornsSprite = love.graphics.newImage("images/accessories/ballOfThorns.png")
	squishyMushroomSprite = love.graphics.newImage("images/accessories/squishyMushroom.png")
	antiAntidoteSprite = love.graphics.newImage("images/accessories/antiAntidote.png")
	corrosiveSubstanceSprite = love.graphics.newImage("images/accessories/debugSquare.png")
	poisonVialSprite = love.graphics.newImage("images/accessories/poisonVial.png")
	viralPoisonSprite = love.graphics.newImage("images/accessories/viralPoison.png")
	stickyOozeSprite = love.graphics.newImage("images/accessories/stickyOoze.png")
	boilingToxinSprite = love.graphics.newImage("images/accessories/debugSquare.png")
end

function getAccessoryStats(accessory)
	if accessory == "gumBoots" then
		return {
			iconSprite = gumBootsSprite,
			text = "Increases movement speed and jump height.",
			damage = 1,
			knockback = 1,
			xAcceleration = 1.2,
			xDeceleration = 1.2,
			xTerminalVelocity = 1.2,
			jumpAcceleration = 1.2,
			fallAcceleration = 1,
			yTerminalVelocity = 1,
			jumps = 0,
			maxHp = 1,
			status = "",
			statusDuration = 0,
			poisonDuration = 1,
			burnDuration = 1
		}
	elseif accessory == "arcaneFeather" then
		return {
			iconSprite = arcaneFeatherSprite,
			text = "Adds an extra jump.",
			damage = 1,
			knockback = 1,
			xAcceleration = 1,
			xDeceleration = 1,
			xTerminalVelocity = 1,
			jumpAcceleration = 1,
			fallAcceleration = 1,
			yTerminalVelocity = 1,
			jumps = 1,
			maxHp = 1,
			status = "",
			statusDuration = 0,
			poisonDuration = 1,
			burnDuration = 1
		}
	elseif accessory == "magicFungus" then
		return {
			iconSprite = magicFungusSprite,
			text = "Increases max health by 1.5x.",
			damage = 1,
			knockback = 1,
			xAcceleration = 1,
			xDeceleration = 1,
			xTerminalVelocity = 1,
			jumpAcceleration = 1,
			fallAcceleration = 1,
			yTerminalVelocity = 1,
			jumps = 0,
			maxHp = 1.5,
			status = "",
			statusDuration = 0,
			poisonDuration = 1,
			burnDuration = 1
		}
	elseif accessory == "lifeFruit" then
		return {
			iconSprite = lifeFruitSprite,
			text = "Killing an enemy restores a small amount of health.",
			damage = 1,
			knockback = 1,
			xAcceleration = 1,
			xDeceleration = 1,
			xTerminalVelocity = 1,
			jumpAcceleration = 1,
			fallAcceleration = 1,
			yTerminalVelocity = 1,
			jumps = 0,
			maxHp = 1,
			status = "",
			statusDuration = 0,
			poisonDuration = 1,
			burnDuration = 1
		}
	elseif accessory == "ballOfThorns" then
		return {
			iconSprite = ballOfThornsSprite,
			text = "Being hit damages the enemy.",
			damage = 1,
			knockback = 1,
			xAcceleration = 1,
			xDeceleration = 1,
			xTerminalVelocity = 1,
			jumpAcceleration = 1,
			fallAcceleration = 1,
			yTerminalVelocity = 1,
			jumps = 0,
			maxHp = 1,
			status = "",
			statusDuration = 0,
			poisonDuration = 1,
			burnDuration = 1
		}
	elseif accessory == "squishyMushroom" then
		return {
			iconSprite = squishyMushroomSprite,
			text = "Increases knockback by 1.5x",
			damage = 1,
			knockback = 1,
			xAcceleration = 1,
			xDeceleration = 1,
			xTerminalVelocity = 1,
			jumpAcceleration = 1,
			fallAcceleration = 1,
			yTerminalVelocity = 1,
			jumps = 0,
			maxHp = 1,
			status = "",
			statusDuration = 0,
			poisonDuration = 1,
			burnDuration = 1
		}
	elseif accessory == "anti-antidote" then
		return {
			iconSprite = antiAntidoteSprite,
			text = "Poison lasts 1.5x longer.",
			damage = 1,
			knockback = 1,
			xAcceleration = 1,
			xDeceleration = 1,
			xTerminalVelocity = 1,
			jumpAcceleration = 1,
			fallAcceleration = 1,
			yTerminalVelocity = 1,
			jumps = 0,
			maxHp = 1,
			status = "",
			statusDuration = 0,
			poisonDuration = 1.5,
			burnDuration = 1
		}
	elseif accessory == "corrosiveSubstance" then
		return {
			iconSprite = corrosiveSubstanceSprite,
			text = "Enemies take 1.5x more damage while poisoned.",
			damage = 1,
			knockback = 1,
			xAcceleration = 1,
			xDeceleration = 1,
			xTerminalVelocity = 1,
			jumpAcceleration = 1,
			fallAcceleration = 1,
			yTerminalVelocity = 1,
			jumps = 0,
			maxHp = 1,
			status = "",
			statusDuration = 0,
			poisonDuration = 1,
			burnDuration = 1
		}
	elseif accessory == "poisonVial" then
		return {
			iconSprite = poisonVialSprite,
			text = "All attacks inflict poison for 1s.",
			damage = 1,
			knockback = 1,
			xAcceleration = 1,
			xDeceleration = 1,
			xTerminalVelocity = 1,
			jumpAcceleration = 1,
			fallAcceleration = 1,
			yTerminalVelocity = 1,
			jumps = 0,
			maxHp = 1,
			status = "poison",
			statusDuration = 60*1,
			poisonDuration = 1,
			poisonDuration = 1,
			burnDuration = 1
		}
	elseif accessory == "viralPoison" then
		return {
			iconSprite = viralPoisonSprite,
			text = "Poison spreads on contact.",
			damage = 1,
			knockback = 1,
			xAcceleration = 1,
			xDeceleration = 1,
			xTerminalVelocity = 1,
			jumpAcceleration = 1,
			fallAcceleration = 1,
			yTerminalVelocity = 1,
			jumps = 0,
			maxHp = 1,
			status = "",
			statusDuration = 0,
			poisonDuration = 1,
			burnDuration = 1
		}
	elseif accessory == "stickyOoze" then
		return {
			iconSprite = stickyOozeSprite,
			text = "Poisoned enemies are 2x slower.",
			damage = 1,
			knockback = 1,
			xAcceleration = 1,
			xDeceleration = 1,
			xTerminalVelocity = 1,
			jumpAcceleration = 1,
			fallAcceleration = 1,
			yTerminalVelocity = 1,
			jumps = 0,
			maxHp = 1,
			status = "",
			statusDuration = 0,
			poisonDuration = 1,
			burnDuration = 1
		}
	elseif accessory == "boilingToxin" then
		return {
			iconSprite = boilingToxinSprite,
			text = "Poisoned enemies explode on death, damaging nearby enemies.",
			damage = 1,
			knockback = 1,
			xAcceleration = 1,
			xDeceleration = 1,
			xTerminalVelocity = 1,
			jumpAcceleration = 1,
			fallAcceleration = 1,
			yTerminalVelocity = 1,
			jumps = 0,
			maxHp = 1,
			status = "",
			statusDuration = 0,
			poisonDuration = 1,
			burnDuration = 1
		}
	end
end