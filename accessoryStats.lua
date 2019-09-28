function returnAccessoryList()
	local accessoryList = {"gumBoots", -- 1
						   "magicFeather", -- 2
						   "magicFungus", -- 3
						   "lifeFruit", -- 4
						   "thorns", -- 5
						   -- "", -- 6
						   "poisonLength", -- 7
						   "poisonDamage", -- 8
						   "poisonVial", -- 9
						   "virus"} -- 10
						   -- "", -- 11
						   -- ""} -- 12
	return accessoryList
end

function getAccessoryStats(accessory)
	if accessory == "gumBoots" then
		return {
			iconSprite = love.graphics.newImage("images/accessories/gumBoots.png"),
			text = "Increases movement speed and jump height.",
			damage = 1,
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
	elseif accessory == "magicFeather" then
		return {
			iconSprite = love.graphics.newImage("images/accessories/feather.png"),
			text = "Adds an extra jump.",
			damage = 1,
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
			iconSprite = love.graphics.newImage("images/accessories/magicFungus.png"),
			text = "Increases max health by 1.5x.",
			damage = 1,
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
			iconSprite = love.graphics.newImage("images/accessories/lifeFruit.png"),
			text = "Killing an enemy restores a small amount of health.",
			damage = 1,
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
	elseif accessory == "thorns" then
		return {
			iconSprite = love.graphics.newImage("images/accessories/debugSquare.png"),
			text = "Being hit damages the enemy.",
			damage = 1,
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
	elseif accessory == "poisonLength" then
		return {
			iconSprite = love.graphics.newImage("images/accessories/debugSquare.png"),
			text = "Poison lasts 1.5x longer.",
			damage = 1,
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
	elseif accessory == "poisonDamage" then
		return {
			iconSprite = love.graphics.newImage("images/accessories/debugSquare.png"),
			text = "Poisoned enemies take 1.5x damage.",
			damage = 1,
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
			iconSprite = love.graphics.newImage("images/accessories/poisonVial.png"),
			text = "All attacks inflict poison for 1s.",
			damage = 1,
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
	elseif accessory == "virus" then
		return {
			iconSprite = love.graphics.newImage("images/accessories/debugSquare.png"),
			text = "Poison spreads on contact.",
			damage = 1,
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