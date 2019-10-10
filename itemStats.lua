function getItemStats(item)
	if item == "weaponShopItem" then
		local random = getRandomWeapon()
		local stats = getWeaponStats(random)
		local sprite = stats.iconSprite
		return {
			itemType = "shop",
			randomWeapon = stats,
			accessoryName = "weapon",
			sprite = stats.iconSprite,
			width = sprite:getWidth(),
			height = sprite:getHeight(),
			randomName = random
		}
	elseif item == "accessoryShopItem" then
		local random = getRandomAccessory()
		local stats = getAccessoryStats(random)
		local sprite = stats.iconSprite
		return {
			itemType = "shop",
			randomAccessory = stats,
			accessoryName = "accessory",
			sprite = stats.iconSprite,
			width = sprite:getWidth(),
			height = sprite:getHeight(),
			randomName = random
		}
	elseif item == "weaponChestItem" then
		local random = getRandomWeapon()
		local stats = getWeaponStats(random)
		local sprite = stats.iconSprite
		return {
			itemType = "chest",
			randomWeapon = stats,
			accessoryName = "weapon",
			sprite = stats.iconSprite,
			width = sprite:getWidth(),
			height = sprite:getHeight(),
			randomName = random
		}
	elseif item == "accessoryChestItem" then
		local random = getRandomAccessory()
		local stats = getAccessoryStats(random)
		local sprite = stats.iconSprite
		return {
			itemType = "chest",
			randomAccessory = stats,
			accessoryName = "accessory",
			sprite = stats.iconSprite,
			width = sprite:getWidth(),
			height = sprite:getHeight(),
			randomName = random
		}
	elseif item == "coin" then
		local random = math.random(3)
		local sprite
		if random == 1 then
			sprite = coin1Sprite
		elseif random == 2 then
			sprite = coin2Sprite
		elseif random == 3 then
			sprite = coin3Sprite
		end
		return {
			itemType = "coin",
			sprite = sprite,
			width = sprite:getWidth(),
			height = sprite:getHeight(),
		}
	end
end