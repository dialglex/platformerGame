function getItemStats(item)
	if item == "weaponShopItem" then
		local random = getRandomElement(returnWeaponList())
		local weapon = getWeaponStats(random)
		local sprite = weapon.iconSprite
		return {
			itemType = "shop",
			randomAccessory = accessory,
			accessoryName = "weapon",
			iconSprite = sprite,
			width = sprite:getWidth(),
			height = sprite:getHeight(),
			randomItemName = random
		}
	elseif item == "accessoryShopItem" then
		local random = getRandomElement(returnAccessoryList())
		local accessory = getAccessoryStats(random)
		local sprite = accessory.iconSprite
		return {
			itemType = "shop",
			randomAccessory = accessory,
			accessoryName = "accessory",
			iconSprite = sprite,
			width = sprite:getWidth(),
			height = sprite:getHeight(),
			randomItemName = random
		}
	end
end