function returnAccessoryList()
	local accessoryList = {"boots",
						   "coolHat"}
	return accessoryList
end

function getAccessoryStats(accessory)
	local stats = {}

	if accessory == "boots" then
		iconImage = love.graphics.newImage("images/accessories/boots.png")
		accessoryType = "passive"
		text = "Some cool boots."
		xAcceleration = 1.5
		xDeceleration = 1.5
		xTerminalVelocity = 1.5
		jumpAcceleration = 1
		fallAcceleration = 1
		yTerminalVelocity = 1
	elseif accessory == "coolHat" then
		iconImage = love.graphics.newImage("images/accessories/coolHat.png")
		accessoryType = "passive"
		text = "A cool hat."
		xAcceleration = 1
		xDeceleration = 1
		xTerminalVelocity = 1
		jumpAcceleration = 0.5
		fallAcceleration = 1
		yTerminalVelocity = 1
	end

	table.insert(stats, accessory)
	table.insert(stats, iconImage)
	table.insert(stats, accessoryType)
	table.insert(stats, text)
	table.insert(stats, xAcceleration)
	table.insert(stats, xDeceleration)
	table.insert(stats, xTerminalVelocity)
	table.insert(stats, jumpAcceleration)
	table.insert(stats, fallAcceleration)
	table.insert(stats, yTerminalVelocity)

	return stats
end