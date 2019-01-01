function newUi(name, sprite1, sprite2, sprite3, data)
	local ui = {}
	ui.name = name
	ui.sprite = love.graphics.newImage("images/ui/"..name.."/"..name..".png")
	ui.width = ui.sprite:getWidth()
	ui.height = ui.sprite:getHeight()
	ui.x = 480/2 - ui.width/2
	ui.y = 270/2 - ui.height/2
	ui.canvas = love.graphics.newCanvas(ui.width, ui.height)
	ui.remove = false
	ui.firstFrame = true
	ui.actor = "ui"

	if ui.name == "newWeapon" then
		ui.weapon1Selected = false
		ui.weapon2Selected = false
		ui.spriteLeft = love.graphics.newImage("images/ui/newWeapon/newWeaponLeft.png")
		ui.spriteRight = love.graphics.newImage("images/ui/newWeapon/newWeaponRight.png")
		ui.weaponSprite1 = sprite1
		ui.weaponSprite1Canvas = giveOutline(ui.weaponSprite1, {1, 1, 1, 1})
		ui.weaponSprite2 = sprite2
		ui.weaponSprite2Canvas = giveOutline(ui.weaponSprite2, {1, 1, 1, 1})
		ui.newWeaponSprite = sprite3
		ui.newWeaponSpriteCanvas = giveOutline(ui.newWeaponSprite, {1, 1, 1, 1})
		ui.newWeapon = data
	elseif ui.name == "inventory" then
		ui.healthBarSprite = love.graphics.newImage("images/ui/inventory/healthBar.png")
		ui.healthBarCanvas = love.graphics.newCanvas(115*(player.hp/player.maxHp), ui.healthBarSprite:getHeight())
		if player.xp > 0 then
			ui.xpBarSprite = love.graphics.newImage("images/ui/inventory/xpBar.png")
		    ui.xpBarCanvas = love.graphics.newCanvas(115*(player.xp/player.nextLevelXp), ui.xpBarSprite:getHeight())
		end
	end
	
	function ui:act(index)
		if ui.name == "newWeapon" then
			uiFrozen = true
			if pressInputs.left then
				ui.weapon1Selected = true
				ui.weapon2Selected = false
			elseif pressInputs.right then
				ui.weapon2Selected = true
				ui.weapon1Selected = false
			end

			if pressInputs.attack1 then
				player.equippedWeapon1 = ui.newWeapon
				ui.remove = true
			elseif pressInputs.attack2 then
				player.equippedWeapon2 = ui.newWeapon
				ui.remove = true
			end

			if pressInputs.interact then
				if ui.weapon1Selected then
					player.equippedWeapon1 = ui.newWeapon
					ui.remove = true
				elseif ui.weapon2Selected then
					player.equippedWeapon2 = ui.newWeapon
					ui.remove = true
				end
			end

			if ui.weapon1Selected then
				ui.sprite = ui.spriteLeft
			elseif ui.weapon2Selected then
				ui.sprite = ui.spriteRight
			end
		elseif ui.name == "inventory" then
			uiFrozen = true
		end

		if pressInputs.close and ui.firstFrame == false then
			ui.remove = true
		end

		if ui.remove then
			uiFrozen = false
			table.remove(actors, index)
		end

		ui.firstFrame = false
	end

    function ui:getX()
        return math.floor(ui.x + 0.5)
    end

    function ui:getY()
        return math.floor(ui.y + 0.5)
    end

	function ui:returnStatString(statType, stat)
		if statType == "speed" then
			if stat < 6 then
				return "speedy"
			elseif stat < 12 then
				return "very fast"
			elseif stat < 18 then
				return "fast"
			elseif stat < 24 then
				return "average"
			elseif stat < 30 then
				return "slow"
			else
				return "very slow"
			end
		elseif statType == "knockback" then
			if stat == 0 then
				return "none"
			elseif stat < 0.4 then
				return "very low"
			elseif stat < 0.8 then
	        	return "low"
	        elseif stat < 1.2 then
	        	return "average"
	        elseif stat < 1.6 then
	        	return "high"
	        elseif stat < 2 then
	        	return "very high"
	        else
	        	return "humongous"
	        end
		end
	end

	function ui:draw()
        love.graphics.setCanvas(ui.canvas)
        love.graphics.clear()
        love.graphics.setBackgroundColor(0, 0, 0, 0)

        if ui.name == "newWeapon" then
        	love.graphics.setCanvas(ui.canvas)
	        love.graphics.clear()

	        love.graphics.setBackgroundColor(0, 0, 0, 0)

	        love.graphics.draw(ui.sprite)
	        love.graphics.draw(ui.weaponSprite1Canvas, 6, 104)
	        love.graphics.draw(ui.newWeaponSpriteCanvas, 58, 104)
	        love.graphics.draw(ui.weaponSprite2Canvas, 110, 104)

	        local name1, type1, _, _, _, _, _, _, width1, height1, damage1, knockbackStrength1,
	        	startupLag1, slashDuration1, endLag1, _, _, _, movementReduction1, pierce1 = unpack(getWeaponStats(ui.newWeapon))

	        if ui.weapon1Selected then
	        	name2, type2, _, _, _, _, _, _, width2, height2, damage2, knockbackStrength2,
	        		startupLag2, slashDuration2, endLag2, _, _, _, movementReduction2, pierce2 = unpack(getWeaponStats(player.equippedWeapon1))
	        elseif ui.weapon2Selected then
	        	name2, type2, _, _, _, _, _, _, width2, height2, damage2, knockbackStrength2,
	        		startupLag2, slashDuration2, endLag2, _, _, _, movementReduction2, pierce2 = unpack(getWeaponStats(player.equippedWeapon2))
	    	end

	        local damage = tostring(damage1)
	        local speed = ui:returnStatString("speed", startupLag1 + endLag1)
	        local knockback = ui:returnStatString("knockback", knockbackStrength1)

	        love.graphics.setFont(boldFont2)
	        if ui.weapon1Selected or ui.weapon2Selected then
		        if damage1 > damage2 then
			        love.graphics.setFont(boldFont2Green)
		        elseif damage1 < damage2 then
		        	love.graphics.setFont(boldFont2Red)
			    end
			end
	        love.graphics.printf(damage, 52, 57, 1000)

	        love.graphics.setFont(boldFont2)
	        if ui.weapon1Selected or ui.weapon2Selected then
		        if startupLag1 + endLag1 > startupLag2 + endLag2 then
		        	love.graphics.setFont(boldFont2Red)
		        elseif startupLag1 + endLag1 < startupLag2 + endLag2 then
		        	love.graphics.setFont(boldFont2Green)
			    end
			end
	        love.graphics.printf(speed, 52, 71, 1000)
	        
	        love.graphics.setFont(boldFont2)
	        if ui.weapon1Selected or ui.weapon2Selected then
		        if knockbackStrength1 > knockbackStrength2 then
		        	love.graphics.setFont(boldFont2Green)
		        elseif knockbackStrength1 < knockbackStrength2 then
		        	love.graphics.setFont(boldFont2Red)
			    end
			end
	        love.graphics.printf(knockback, 52, 85, 1000)
	    elseif ui.name == "inventory" then
	    	love.graphics.setCanvas(ui.healthBarCanvas)
	    	for i = 0, 2 do
		    	love.graphics.draw(ui.healthBarSprite, ui.healthBarSprite:getWidth()*i)
	    	end
	    	if player.xp > 0 then
		    	love.graphics.setCanvas(ui.xpBarCanvas)
		    	for i = 0, 7 do
		    		love.graphics.draw(ui.xpBarSprite, ui.xpBarSprite:getWidth()*i)
		    	end
		    end

	    	love.graphics.setCanvas(ui.canvas)
	        love.graphics.clear()
	        love.graphics.setBackgroundColor(0, 0, 0, 0)

	    	love.graphics.draw(ui.sprite)
	    	love.graphics.draw(ui.healthBarCanvas, 45, 22)
	    	if player.xp > 0 then
		    	love.graphics.draw(ui.xpBarCanvas, 45, 43)
		    end

	        love.graphics.setFont(boldFont2)
		    love.graphics.printf("1", 30, 63, 1000)
	        love.graphics.printf("fast", 30, 77, 1000)
	        love.graphics.printf("very high", 30, 91, 1000)
	    end
        
        love.graphics.setColor(1, 1, 1, 1)
    end

    return ui
end
