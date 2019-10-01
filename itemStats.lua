function getItemStats(item)
	if item == "weaponShopItem" then
		local random = getRandomElement(returnWeaponList())
		local weapon = getWeaponStats(random)
		local sprite = weapon.iconSprite
		return {
			itemType = "shop",
			randomAccessory = accessory,
			accessoryName = "weapon",
			sprite = weapon.iconSprite,
			width = sprite:getWidth(),
			height = sprite:getHeight(),
			randomName = random
		}
	elseif item == "accessoryShopItem" then
		local random = getRandomElement(returnAccessoryList())
		local accessory = getAccessoryStats(random)
		local sprite = accessory.iconSprite
		return {
			itemType = "shop",
			randomAccessory = accessory,
			accessoryName = "accessory",
			sprite = accessory.iconSprite,
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