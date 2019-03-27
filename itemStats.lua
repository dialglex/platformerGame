function getItemStats(item)
	local stats = {}

	if item == "weaponShopItem" then
		itemType = "shop"
		local randomWeapon = getRandomElement(returnWeaponList())
		local weaponName, _, iconSprite = unpack(getWeaponStats(randomWeapon))
		sprite = iconSprite
		width = sprite:getWidth()
		height = sprite:getHeight()
		randomItemName = weaponName
	elseif item == "accessoryShopItem" then
		itemType = "shop"
		local randomAccessory = getRandomElement(returnAccessoryList())
		local accessoryName, iconSprite, iconCanvas = unpack(getAccessoryStats(randomAccessory))
		sprite = iconSprite
		width = sprite:getWidth()
		height = sprite:getHeight()
		randomItemName = accessoryName
	end

	table.insert(stats, itemType)
	table.insert(stats, sprite)
	table.insert(stats, width)
	table.insert(stats, height)
	table.insert(stats, randomItemName)

	return stats
end