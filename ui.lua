function newUi(name, data1, data2)
	local ui = {}
	ui.name = name
	ui.sprite = love.graphics.newImage("images/ui/"..name.."/"..name..".png")
	ui.width = ui.sprite:getWidth()
	ui.height = ui.sprite:getHeight()
	ui.x = 480/2 - ui.width/2
	ui.y = 270/2 - ui.height/2
	ui.canvas = love.graphics.newCanvas(ui.width, ui.height)
	ui.remove = false
	ui.control = true
	ui.firstFrame = true
	ui.actor = "ui"
	if ui.name == "menu" then
		ui.selected = "play"
		ui.playSprite = love.graphics.newImage("images/ui/menu/menuPlay.png")
		ui.optionsSprite = love.graphics.newImage("images/ui/menu/menuOptions.png")
		ui.quitSprite = love.graphics.newImage("images/ui/menu/menuQuit.png")
	elseif ui.name == "inventory" then
		ui.inventoryAccessory1 = love.graphics.newImage("images/ui/inventory/inventoryAccessory1.png")
		ui.inventoryAccessory2 = love.graphics.newImage("images/ui/inventory/inventoryAccessory2.png")
		ui.inventoryAccessory3 = love.graphics.newImage("images/ui/inventory/inventoryAccessory3.png")
		ui.inventoryAccessory4 = love.graphics.newImage("images/ui/inventory/inventoryAccessory4.png")
		ui.inventoryAccessory5 = love.graphics.newImage("images/ui/inventory/inventoryAccessory5.png")
		ui.inventoryAccessory6 = love.graphics.newImage("images/ui/inventory/inventoryAccessory6.png")
		ui.inventoryAccessory7 = love.graphics.newImage("images/ui/inventory/inventoryAccessory7.png")
		ui.inventoryAccessory8 = love.graphics.newImage("images/ui/inventory/inventoryAccessory8.png")
		ui.inventoryAccessory9 = love.graphics.newImage("images/ui/inventory/inventoryAccessory9.png")
		ui.inventoryAccessory10 = love.graphics.newImage("images/ui/inventory/inventoryAccessory10.png")
		ui.inventoryAccessory11 = love.graphics.newImage("images/ui/inventory/inventoryAccessory11.png")
		ui.inventoryAccessory12 = love.graphics.newImage("images/ui/inventory/inventoryAccessory12.png")
		ui.inventoryAccessory13 = love.graphics.newImage("images/ui/inventory/inventoryAccessory13.png")

		ui.healthBarSprite = love.graphics.newImage("images/ui/inventory/healthBar.png")
		ui.healthBarCanvas = love.graphics.newCanvas(113*(player.hp/player.maxHp), ui.healthBarSprite:getHeight())

		ui.healthBarOutline1 = love.graphics.newImage("images/ui/inventory/healthBarOutline1.png")
		ui.healthBarOutline2 = love.graphics.newImage("images/ui/inventory/healthBarOutline2.png")
		ui.healthBarOutlineCanvas = love.graphics.newCanvas(113*(player.hp/player.maxHp) + 2, ui.healthBarOutline1:getHeight() + 4)
		ui.healthBarAA = love.graphics.newImage("images/ui/inventory/healthBarAA.png")

		ui.emptyBar = love.graphics.newImage("images/ui/inventory/emptyBar.png")
		ui.barOutline = love.graphics.newImage("images/ui/inventory/barOutline.png")
		ui.greenBar = love.graphics.newImage("images/ui/inventory/greenBar.png")
		ui.greenBarAA = love.graphics.newImage("images/ui/inventory/greenBarAA.png")
		ui.orangeBar = love.graphics.newImage("images/ui/inventory/orangeBar.png")
		ui.orangeBarAA = love.graphics.newImage("images/ui/inventory/orangeBarAA.png")
		ui.redBar = love.graphics.newImage("images/ui/inventory/redBar.png")
		ui.redBarAA = love.graphics.newImage("images/ui/inventory/redBarAA.png")
		ui.weapon1DamageBarCanvas = love.graphics.newCanvas(ui.emptyBar:getWidth(), ui.emptyBar:getHeight())
		ui.weapon1SpeedBarCanvas = love.graphics.newCanvas(ui.emptyBar:getWidth(), ui.emptyBar:getHeight())
		ui.weapon1KnockbackBarCanvas = love.graphics.newCanvas(ui.emptyBar:getWidth(), ui.emptyBar:getHeight())
		ui.weapon2DamageBarCanvas = love.graphics.newCanvas(ui.emptyBar:getWidth(), ui.emptyBar:getHeight())
		ui.weapon2SpeedBarCanvas = love.graphics.newCanvas(ui.emptyBar:getWidth(), ui.emptyBar:getHeight())
		ui.weapon2KnockbackBarCanvas = love.graphics.newCanvas(ui.emptyBar:getWidth(), ui.emptyBar:getHeight())

		local _, _, weaponSprite1 = unpack(getWeaponStats(player.equippedWeapon1))
		local _, _, weaponSprite2 = unpack(getWeaponStats(player.equippedWeapon2))
		ui.weaponSprite1Canvas = giveOutline(weaponSprite1, {0.973, 0.973, 0.973})
		ui.weaponSprite2Canvas = giveOutline(weaponSprite2, {0.973, 0.973, 0.973})

		ui.accessoryCanvases = {}
		ui.accessoryCount = 0
		for i, accessory in ipairs(player.accessories) do
			local _, accessoryImage = unpack(getAccessoryStats(accessory))
			local accessoryCanvas = giveOutline(accessoryImage, {0.973, 0.973, 0.973})
			table.insert(ui.accessoryCanvases, accessoryCanvas)
			ui.accessoryCount = ui.accessoryCount + 1
		end
		if ui.accessoryCount > 0 then
			ui.accessoryNumberSelected = 1
		else
			ui.accessoryNumberSelected = 0
		end
	elseif ui.name == "newWeapon" then
		ui.weapon1Selected = false
		ui.weapon2Selected = false
		ui.spriteLeft = love.graphics.newImage("images/ui/newWeapon/newWeaponLeft.png")
		ui.spriteRight = love.graphics.newImage("images/ui/newWeapon/newWeaponRight.png")

		local _, _, weaponSprite1 = unpack(getWeaponStats(player.equippedWeapon1))
		local _, _, weaponSprite2 = unpack(getWeaponStats(player.equippedWeapon2))
		ui.weaponSprite1Canvas = giveOutline(weaponSprite1, {0.973, 0.973, 0.973})
		ui.weaponSprite2Canvas = giveOutline(weaponSprite2, {0.973, 0.973, 0.973})

		ui.emptyBar = love.graphics.newImage("images/ui/newWeapon/emptyBar.png")
		ui.barOutline = love.graphics.newImage("images/ui/newWeapon/barOutline.png")
		ui.greenBar = love.graphics.newImage("images/ui/newWeapon/greenBar.png")
		ui.greenBarAA = love.graphics.newImage("images/ui/newWeapon/greenBarAA.png")
		ui.greenConnecter = love.graphics.newImage("images/ui/newWeapon/greenConnecter.png")
		ui.orangeBar = love.graphics.newImage("images/ui/newWeapon/orangeBar.png")
		ui.orangeBarAA = love.graphics.newImage("images/ui/newWeapon/orangeBarAA.png")
		ui.orangeConnecter = love.graphics.newImage("images/ui/newWeapon/orangeConnecter.png")
		ui.redBar = love.graphics.newImage("images/ui/newWeapon/redBar.png")
		ui.redBarAA = love.graphics.newImage("images/ui/newWeapon/redBarAA.png")
		ui.redConnecter = love.graphics.newImage("images/ui/newWeapon/redConnecter.png")
		ui.whiteBar = love.graphics.newImage("images/ui/newWeapon/whiteBar.png")
		ui.greyBar = love.graphics.newImage("images/ui/newWeapon/greyBar.png")
		ui.damageBarCanvas = love.graphics.newCanvas(ui.emptyBar:getWidth(), ui.emptyBar:getHeight())
		ui.speedBarCanvas = love.graphics.newCanvas(ui.emptyBar:getWidth(), ui.emptyBar:getHeight())
		ui.knockbackBarCanvas = love.graphics.newCanvas(ui.emptyBar:getWidth(), ui.emptyBar:getHeight())

		ui.newWeaponName = data1
		ui.newWeaponSprite = data2
		ui.newWeaponSpriteCanvas = giveOutline(ui.newWeaponSprite, {0.973, 0.973, 0.973})
	elseif ui.name == "options" then
		if data ~= nil then
			ui.selected = data1
		else
			ui.selected = "video"
		end
		ui.videoSprite = love.graphics.newImage("images/ui/options/optionsVideo.png")
		ui.audioSprite = love.graphics.newImage("images/ui/options/optionsAudio.png")
		ui.controlsSprite = love.graphics.newImage("images/ui/options/optionsControls.png")
		ui.menuSprite = love.graphics.newImage("images/ui/options/optionsMenu.png")
	elseif ui.name == "audio" then
		ui.selected = "music"
		ui.musicSprite = love.graphics.newImage("images/ui/audio/audioMusic.png")
		ui.sfxSprite = love.graphics.newImage("images/ui/audio/audioSfx.png")
		ui.volumeBar = love.graphics.newImage("images/ui/audio/volumeBar.png")
		ui.emptyVolumeBar = love.graphics.newImage("images/ui/audio/emptyVolumeBar.png")
		ui.volumeBarOutline = love.graphics.newImage("images/ui/audio/volumeBarOutline.png")
		ui.volumeBarAA = love.graphics.newImage("images/ui/audio/volumeBarAA.png")
		ui.musicVolumeBarCanvas = love.graphics.newCanvas(ui.volumeBar:getWidth(), ui.volumeBar:getHeight())
		ui.sfxVolumeBarCanvas = love.graphics.newCanvas(ui.volumeBar:getWidth(), ui.volumeBar:getHeight())
	elseif ui.name == "video" then
		ui.selected = "fullscreen"
		ui.fullscreenSprite = love.graphics.newImage("images/ui/video/videoFullscreen.png")
		ui.vSyncSprite = love.graphics.newImage("images/ui/video/videoVSync.png")
		ui.shakeSprite = love.graphics.newImage("images/ui/video/videoShake.png")
		ui.checkBoxOff = love.graphics.newImage("images/ui/video/checkBoxOff.png")
		ui.checkBoxOn = love.graphics.newImage("images/ui/video/checkBoxOn.png")
		ui.bar = love.graphics.newImage("images/ui/video/bar.png")
		ui.emptyBar = love.graphics.newImage("images/ui/video/emptyBar.png")
		ui.barOutline = love.graphics.newImage("images/ui/video/barOutline.png")
		ui.barAA = love.graphics.newImage("images/ui/video/barAA.png")
		ui.barCanvas = love.graphics.newCanvas(ui.bar:getWidth(), ui.bar:getHeight())
	end
	
	function ui:act(index)
		if getTableLength(uis) < 2 then
			ui.control = true
		end
		
		if ui.control then
			if ui.name == "menu" then
				uiFrozen = true
				menuScreen = true
				if pressInputs.up or pressInputs.down then
					menuMoveSound:play()
				end

				if pressInputs.confirm then
					menuConfirmSound:play()
				end

				if ui.selected == "play" then
					if pressInputs.up then
						ui.selected = "quit"
					elseif pressInputs.down then
						ui.selected = "options"
					end

					if pressInputs.confirm then
						menuScreen = false
						ui.remove = true
					end
					
					ui.sprite = ui.playSprite
				elseif ui.selected == "options" then
					if pressInputs.up then
						ui.selected = "play"
					elseif pressInputs.down then
						ui.selected = "quit"
					end

					if pressInputs.confirm then
						ui.control = false
						table.insert(actors, newUi("options"))
					end
					
					ui.sprite = ui.optionsSprite
				elseif ui.selected == "quit" then
					if pressInputs.up then
						ui.selected = "options"
					elseif pressInputs.down then
						ui.selected = "play"
					end

					if pressInputs.confirm then
						local settings = {}
						if fullscreenOn then
							settings.fullscreen = 1
						else
							settings.fullscreen = 0
						end
						if vSyncOn then
							settings.vSync = 1
						else
							settings.vSync = 0
						end
						settings.shake = shake
						settings.musicVolume = musicVolume
						settings.sfxVolume = sfxVolume

						saveData.save(settings, "settings")
						love.event.quit()
					end
					
					ui.sprite = ui.quitSprite
				end
			elseif ui.name == "inventory" then
				uiFrozen = true
				if (pressInputs.back or pressInputs.inventory) and ui.firstFrame == false then
					menuBackSound:play()
					ui.remove = true
				end

				if pressInputs.left and ui.accessoryNumberSelected > 1 then
					ui.accessoryNumberSelected = ui.accessoryNumberSelected - 1
				elseif pressInputs.right and ui.accessoryNumberSelected < 13 and ui.accessoryNumberSelected + 1 <= ui.accessoryCount then
					ui.accessoryNumberSelected = ui.accessoryNumberSelected + 1
				elseif pressInputs.up and ui.accessoryNumberSelected > 7 then
					ui.accessoryNumberSelected = ui.accessoryNumberSelected - 7
				elseif pressInputs.down and ui.accessoryNumberSelected < 7 and ui.accessoryNumberSelected + 7 <= ui.accessoryCount then
					ui.accessoryNumberSelected = ui.accessoryNumberSelected + 7
				end
			elseif ui.name == "newWeapon" then
				uiFrozen = true

				if pressInputs.left then
					if ui.weapon1Selected ~= true then
						menuMoveSound:play()
					end
					ui.weapon1Selected = true
					ui.weapon2Selected = false
				elseif pressInputs.right then
					if ui.weapon2Selected ~= true then
						menuMoveSound:play()
					end
					ui.weapon2Selected = true
					ui.weapon1Selected = false
				end

				if pressInputs.attack1 then
					menuConfirmSound:play()
					player.equippedWeapon1 = ui.newWeaponName
					ui.remove = true
				elseif pressInputs.attack2 then
					menuConfirmSound:play()
					player.equippedWeapon2 = ui.newWeaponName
					ui.remove = true
				end

				if pressInputs.confirm then
					if ui.weapon1Selected then
						menuConfirmSound:play()
						player.equippedWeapon1 = ui.newWeaponName
						ui.remove = true
					elseif ui.weapon2Selected then
						menuConfirmSound:play()
						player.equippedWeapon2 = ui.newWeaponName
						ui.remove = true
					end
				end

				if ui.weapon1Selected then
					ui.sprite = ui.spriteLeft
				elseif ui.weapon2Selected then
					ui.sprite = ui.spriteRight
				end

				if pressInputs.back and ui.firstFrame == false then
					menuBackSound:play()
					ui.remove = true
				end
			elseif ui.name == "options" then
				uiFrozen = true
				if pressInputs.up or pressInputs.down then
					menuMoveSound:play()
				end

				if pressInputs.confirm then
					menuConfirmSound:play()
				end

				if ui.selected == "video" then
					if pressInputs.up then
						ui.selected = "menu"
					elseif pressInputs.down then
						ui.selected = "audio"
					end

					if pressInputs.confirm and ui.firstFrame == false then
						ui.remove = true
						table.insert(actors, newUi("video"))
					end
					
					ui.sprite = ui.videoSprite
				elseif ui.selected == "audio" then
					if pressInputs.up then
						ui.selected = "video"
					elseif pressInputs.down then
						ui.selected = "controls"
					end

					if pressInputs.confirm and ui.firstFrame == false then
						ui.remove = true
						table.insert(actors, newUi("audio"))
					end

					ui.sprite = ui.audioSprite
				elseif ui.selected == "controls" then
					if pressInputs.up then
						ui.selected = "audio"
					elseif pressInputs.down then
						ui.selected = "menu"
					end
					ui.sprite = ui.controlsSprite
				elseif ui.selected == "menu" then
					if pressInputs.up then
						ui.selected = "controls"
					elseif pressInputs.down then
						ui.selected = "video"
					end

					if pressInputs.confirm then
						ui.remove = true
						if menuScreen == false and ui.firstFrame == false then
							table.insert(actors, newUi("menu"))
						end
					end

					ui.sprite = ui.menuSprite
				end
				if pressInputs.back and ui.firstFrame == false then
					menuBackSound:play()
					ui.remove = true
				end
			elseif ui.name == "audio" then
				uiFrozen = true
				if pressInputs.up or pressInputs.down then
					menuMoveSound:play()
				end

				if ui.selected == "music" then
					if pressInputs.up then
						ui.selected = "sfx"
					elseif pressInputs.down then
						ui.selected = "sfx"
					end

					if downInputs.left then
						if musicVolume > 0 then
							musicVolume = musicVolume - 0.01
						end
					elseif downInputs.right then
						if musicVolume < 1 then
							musicVolume = musicVolume + 0.01
						end
					end
					
					ui.sprite = ui.musicSprite
				elseif ui.selected == "sfx" then
					if pressInputs.up then
						ui.selected = "music"
					elseif pressInputs.down then
						ui.selected = "music"
					end

					if downInputs.left then
						if sfxVolume > 0 then
							sfxVolume = sfxVolume - 0.01
						end
					elseif downInputs.right then
						if sfxVolume < 1 then
							sfxVolume = sfxVolume + 0.01
						end
					end
					
					ui.sprite = ui.sfxSprite
				end

				if pressInputs.back and ui.firstFrame == false then
					menuBackSound:play()
					table.insert(actors, newUi("options", "audio"))
					ui.remove = true
				end
			elseif ui.name == "video" then
				uiFrozen = true
				if pressInputs.up or pressInputs.down then
					menuMoveSound:play()
				end

				if ui.selected == "fullscreen" then
					if pressInputs.up then
						ui.selected = "shake"
					elseif pressInputs.down then
						ui.selected = "vSync"
					end

					if pressInputs.confirm and ui.firstFrame == false then
						fullscreenOn = not fullscreenOn
					end
					
					ui.sprite = ui.fullscreenSprite
				elseif ui.selected == "vSync" then
					if pressInputs.up then
						ui.selected = "fullscreen"
					elseif pressInputs.down then
						ui.selected = "shake"
					end

					if pressInputs.confirm and ui.firstFrame == false then
						vSyncOn = not vSyncOn
					end
					
					ui.sprite = ui.vSyncSprite
				elseif ui.selected == "shake" then
					if pressInputs.up then
						ui.selected = "vSync"
					elseif pressInputs.down then
						ui.selected = "fullscreen"
					end

					if downInputs.left then
						if shake > 0 then
							shake = shake - 0.01
						end
					elseif downInputs.right then
						if shake < 1 then
							shake = shake + 0.01
						end
					end
					
					ui.sprite = ui.shakeSprite
				end

				if pressInputs.confirm and ui.firstFrame == false and (ui.selected == "fullscreen" or ui.selected == "vSync") then
					love.window.setMode(xWindowSize, yWindowSize, {fullscreen = fullscreenOn, vsync = vSyncOn, centered = true})
					canvasLayers = setupCanvases(actors)
					backgroundCanvas = canvasLayers[1]
					foregroundCanvas = canvasLayers[2]
				end

				if pressInputs.back and ui.firstFrame == false then
					menuBackSound:play()
					table.insert(actors, newUi("options", "video"))
					ui.remove = true
				end
			end
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

	function ui:drawBar(number1, number2) -- numbers must be between 0 and 1
		love.graphics.draw(ui.emptyBar, 0, 0)

		if number2 == nil then
			if number1*ui.emptyBar:getWidth() < ui.emptyBar:getWidth()*1/3 then
				love.graphics.draw(ui.redBar, number1*ui.emptyBar:getWidth() - ui.emptyBar:getWidth(), 0)
				if number1*ui.emptyBar:getWidth() > 5 then
					love.graphics.draw(ui.redBarAA, 2, 2)
				end
			elseif number1*ui.emptyBar:getWidth() < ui.emptyBar:getWidth()*2/3 then
				love.graphics.draw(ui.orangeBar, number1*ui.emptyBar:getWidth() - ui.emptyBar:getWidth(), 0)
				if number1*ui.emptyBar:getWidth() > 5 then
					love.graphics.draw(ui.orangeBarAA, 2, 2)
				end
			else
				love.graphics.draw(ui.greenBar, number1*ui.emptyBar:getWidth() - ui.emptyBar:getWidth(), 0)
				if number1*ui.emptyBar:getWidth() > 5 then
					love.graphics.draw(ui.greenBarAA, 2, 2)
				end
			end
			if number1*ui.emptyBar:getWidth() > 2 then
				love.graphics.draw(ui.barOutline, 0, 0)
			end
		else
			if number1 > number2 then
				love.graphics.draw(ui.whiteBar, number1*ui.emptyBar:getWidth() - ui.emptyBar:getWidth(), 0)
				if number2*ui.emptyBar:getWidth() < ui.emptyBar:getWidth()*1/3 then
					love.graphics.draw(ui.redBar, number2*ui.emptyBar:getWidth() - ui.emptyBar:getWidth(), 0)
					if number2*ui.emptyBar:getWidth() > 5 then
						love.graphics.draw(ui.redBarAA, 2, 2)
					end
					if number1 ~= number2 then
						love.graphics.draw(ui.redConnecter, number2*ui.emptyBar:getWidth() - 3, 0)
					end
				elseif number2*ui.emptyBar:getWidth() < ui.emptyBar:getWidth()*2/3 then
					love.graphics.draw(ui.orangeBar, number2*ui.emptyBar:getWidth() - ui.emptyBar:getWidth(), 0)
					if number2*ui.emptyBar:getWidth() > 5 then
						love.graphics.draw(ui.orangeBarAA, 2, 2)
					end
					if number1 ~= number2 then
						love.graphics.draw(ui.orangeConnecter, number2*ui.emptyBar:getWidth() - 3, 0)
					end
				else
					love.graphics.draw(ui.greenBar, number2*ui.emptyBar:getWidth() - ui.emptyBar:getWidth(), 0)
					if number2*ui.emptyBar:getWidth() > 5 then
						love.graphics.draw(ui.greenBarAA, 2, 2)
					end
					if number1 ~= number2 then
						love.graphics.draw(ui.greenConnecter, number2*ui.emptyBar:getWidth() - 3, 0)
					end
				end
			else
				love.graphics.draw(ui.greyBar, number2*ui.emptyBar:getWidth() - ui.emptyBar:getWidth(), 0)
				if number1*ui.emptyBar:getWidth() < ui.emptyBar:getWidth()*1/3 then
					love.graphics.draw(ui.redBar, number1*ui.emptyBar:getWidth() - ui.emptyBar:getWidth(), 0)
					if number1*ui.emptyBar:getWidth() > 5 then
						love.graphics.draw(ui.redBarAA, 2, 2)
					end
					if number1 ~= number2 then
						love.graphics.draw(ui.redConnecter, number1*ui.emptyBar:getWidth() - 3, 0)
					end
				elseif number1*ui.emptyBar:getWidth() < ui.emptyBar:getWidth()*2/3 then
					love.graphics.draw(ui.orangeBar, number1*ui.emptyBar:getWidth() - ui.emptyBar:getWidth(), 0)
					if number1*ui.emptyBar:getWidth() > 5 then
						love.graphics.draw(ui.orangeBarAA, 2, 2)
					end
					if number1 ~= number2 then
						love.graphics.draw(ui.orangeConnecter, number1*ui.emptyBar:getWidth() - 3, 0)
					end
				else
					love.graphics.draw(ui.greenBar, number1*ui.emptyBar:getWidth() - ui.emptyBar:getWidth(), 0)
					if number1*ui.emptyBar:getWidth() > 5 then
						love.graphics.draw(ui.greenBarAA, 2, 2)
					end
					if number1 ~= number2 then
						love.graphics.draw(ui.greenConnecter, number1*ui.emptyBar:getWidth() - 3, 0)
					end
				end
			end
			
			if number2*ui.emptyBar:getWidth() > 2 then
				love.graphics.draw(ui.barOutline, 0, 0)
			end
		end
	end

	function ui:draw()
		if ui.name == "menu" then
			love.graphics.setCanvas(ui.canvas)
			love.graphics.clear()

			love.graphics.setBackgroundColor(0, 0, 0, 0)

			love.graphics.draw(ui.sprite)
		elseif ui.name == "inventory" then
			local name1, type1, _, _, _, _, _, width1, height1, damage1, knockback1, startupLag1,
				slashDuration1, endLag1, _, _, _, movementReduction1, pierce1 = unpack(getWeaponStats(player.equippedWeapon1))
			local name2, type2, _, _, _, _, _, width2, height2, damage2, knockback2, startupLag2,
				slashDuration2, endLag2, _, _, _, movementReduction2, pierce2 = unpack(getWeaponStats(player.equippedWeapon2))
			local speed1 = 60 - (startupLag1 + slashDuration1 + endLag1)
			local speed2 = 60 - (startupLag2 + slashDuration2 + endLag2)

			love.graphics.setCanvas(ui.weapon1DamageBarCanvas)
			love.graphics.clear()
			ui:drawBar(damage1/100)
			love.graphics.setCanvas(ui.weapon1SpeedBarCanvas)
			love.graphics.clear()
			ui:drawBar(speed1/60)
			love.graphics.setCanvas(ui.weapon1KnockbackBarCanvas)
			love.graphics.clear()
			ui:drawBar(knockback1/5)

			love.graphics.setCanvas(ui.weapon2DamageBarCanvas)
			love.graphics.clear()
			ui:drawBar(damage2/100)
			love.graphics.setCanvas(ui.weapon2SpeedBarCanvas)
			love.graphics.clear()
			ui:drawBar(speed2/60)
			love.graphics.setCanvas(ui.weapon2KnockbackBarCanvas)
			love.graphics.clear()
			ui:drawBar(knockback2/5)


			love.graphics.setCanvas(ui.healthBarCanvas)
			for i = 0, 2 do
				love.graphics.draw(ui.healthBarSprite, ui.healthBarSprite:getWidth()*i)
			end

			love.graphics.setCanvas(ui.healthBarOutlineCanvas)
			love.graphics.draw(ui.healthBarOutline1)
			love.graphics.draw(ui.healthBarAA, 2, 2)
			love.graphics.draw(ui.healthBarAA, ui.healthBarCanvas:getWidth() - 1 + 2, 2)
			love.graphics.setCanvas()

			love.graphics.setCanvas(ui.canvas)
			love.graphics.clear()
			love.graphics.setBackgroundColor(0, 0, 0, 0)
			love.graphics.draw(ui.weapon1DamageBarCanvas, 29, 67)
			love.graphics.draw(ui.weapon1SpeedBarCanvas, 29, 81)
			love.graphics.draw(ui.weapon1KnockbackBarCanvas, 29, 95)
			love.graphics.draw(ui.weapon2DamageBarCanvas, 127, 67)
			love.graphics.draw(ui.weapon2SpeedBarCanvas, 127, 81)
			love.graphics.draw(ui.weapon2KnockbackBarCanvas, 127, 95)
			if ui.accessoryNumberSelected == 1 then
				love.graphics.draw(ui.inventoryAccessory1)
			elseif ui.accessoryNumberSelected == 2 then
				love.graphics.draw(ui.inventoryAccessory2)
			elseif ui.accessoryNumberSelected == 3 then
				love.graphics.draw(ui.inventoryAccessory3)
			elseif ui.accessoryNumberSelected == 4 then
				love.graphics.draw(ui.inventoryAccessory4)
			elseif ui.accessoryNumberSelected == 5 then
				love.graphics.draw(ui.inventoryAccessory5)
			elseif ui.accessoryNumberSelected == 6 then
				love.graphics.draw(ui.inventoryAccessory6)
			elseif ui.accessoryNumberSelected == 7 then
				love.graphics.draw(ui.inventoryAccessory7)
			elseif ui.accessoryNumberSelected == 8 then
				love.graphics.draw(ui.inventoryAccessory8)
			elseif ui.accessoryNumberSelected == 9 then
				love.graphics.draw(ui.inventoryAccessory9)
			elseif ui.accessoryNumberSelected == 10 then
				love.graphics.draw(ui.inventoryAccessory10)
			elseif ui.accessoryNumberSelected == 11 then
				love.graphics.draw(ui.inventoryAccessory11)
			elseif ui.accessoryNumberSelected == 12 then
				love.graphics.draw(ui.inventoryAccessory12)
			elseif ui.accessoryNumberSelected == 13 then
				love.graphics.draw(ui.inventoryAccessory13)
			else
				love.graphics.draw(ui.sprite)
			end
			love.graphics.draw(ui.healthBarCanvas, 45, 24)
			love.graphics.draw(ui.healthBarOutlineCanvas, 45 - 2, 24 - 2)
			love.graphics.draw(ui.healthBarOutline2, 45 - 2 + ui.healthBarOutlineCanvas:getWidth(), 24 - 2)
			love.graphics.draw(ui.weaponSprite1Canvas, 6, 6)
			love.graphics.draw(ui.weaponSprite2Canvas, 164, 6)
			love.graphics.setFont(textFont1)
			love.graphics.printf(camelToTitle(name1), 10, 47, 1000)
			love.graphics.printf(camelToTitle(name2), 108, 47, 1000)
			love.graphics.printf("1 - " .. camelToTitle(levelName), 81, 9, 1000)

			local selectedAccessoryName = player.accessories[ui.accessoryNumberSelected]
			if selectedAccessoryName ~= nil then
				local accessoryName, iconImage, accessoryType, text, xAcceleration, xDeceleration, xTerminalVelocity, jumpAcceleration, fallAcceleration,
					yTerminalVelocity = unpack(getAccessoryStats(selectedAccessoryName))
				love.graphics.printf(camelToTitle(selectedAccessoryName), 10, 118, 1000)
				love.graphics.setFont(textFont1Light)
				love.graphics.printf(text, 10, 127, 1000)
			end
			for i, accessoryCanvas in ipairs(ui.accessoryCanvases) do
				love.graphics.draw(accessoryCanvas, 6 + (i-1)*28, 144)
			end
			
			love.graphics.setFont(boldFont2)
			love.graphics.printf(tostring(player.money), 95, 204, 1000)

		elseif ui.name == "newWeapon" then
			local name1, type1, _, _, _, _, _, width1, height1, damage1, knockback1, startupLag1,
				slashDuration1, endLag1, _, _, _, movementReduction1, pierce1 = unpack(getWeaponStats(ui.newWeaponName))
			if ui.weapon1Selected then
				name2, type2, _, _, _, _, _, width2, height2, damage2, knockback2, startupLag2,
					slashDuration2, endLag2, _, _, _, movementReduction2, pierce2 = unpack(getWeaponStats(player.equippedWeapon1))
				speed2 = 60 - (startupLag2 + slashDuration2 + endLag2)
			elseif ui.weapon2Selected then
				name2, type2, _, _, _, _, _, width2, height2, damage2, knockback2, startupLag2,
					slashDuration2, endLag2, _, _, _, movementReduction2, pierce2 = unpack(getWeaponStats(player.equippedWeapon2))
				speed2 = 60 - (startupLag2 + slashDuration2 + endLag2)
			end
			local speed1 = 60 - (startupLag1 + slashDuration1 + endLag1)
			
			if ui.weapon1Selected or ui.weapon2Selected then
				love.graphics.setCanvas(ui.damageBarCanvas)
				love.graphics.clear()
				ui:drawBar(damage1/100, damage2/100)
				love.graphics.setCanvas(ui.speedBarCanvas)
				love.graphics.clear()
				ui:drawBar(speed1/60, speed2/60)
				love.graphics.setCanvas(ui.knockbackBarCanvas)
				love.graphics.clear()
				ui:drawBar(knockback1/5, knockback2/5)
			else
				love.graphics.setCanvas(ui.damageBarCanvas)
				love.graphics.clear()
				ui:drawBar(damage1/100)
				love.graphics.setCanvas(ui.speedBarCanvas)
				love.graphics.clear()
				ui:drawBar(speed1/60)
				love.graphics.setCanvas(ui.knockbackBarCanvas)
				love.graphics.clear()
				ui:drawBar(knockback1/5)
			end

			love.graphics.setCanvas(ui.canvas)
			love.graphics.clear()
			love.graphics.setBackgroundColor(0, 0, 0, 0)
			love.graphics.draw(ui.damageBarCanvas, 47, 57)
			love.graphics.draw(ui.speedBarCanvas, 47, 71)
			love.graphics.draw(ui.knockbackBarCanvas, 47, 85)
			love.graphics.draw(ui.sprite)
			love.graphics.draw(ui.weaponSprite1Canvas, 6, 104)
			love.graphics.draw(ui.newWeaponSpriteCanvas, 58, 104)
			love.graphics.draw(ui.weaponSprite2Canvas, 110, 104)
		elseif ui.name == "options" then
			love.graphics.setCanvas(ui.canvas)
			love.graphics.clear()

			love.graphics.setBackgroundColor(0, 0, 0, 0)

			love.graphics.draw(ui.sprite)
		elseif ui.name == "audio" then
			love.graphics.setCanvas(ui.musicVolumeBarCanvas)
			love.graphics.clear()
			love.graphics.draw(ui.emptyVolumeBar, 0, 0)
			love.graphics.draw(ui.volumeBar, musicVolume*ui.volumeBar:getWidth() - ui.volumeBar:getWidth(), 0)
			if musicVolume*ui.volumeBar:getWidth() > 2 then
				love.graphics.draw(ui.volumeBarOutline, 0, 0)
			end
			if musicVolume*ui.volumeBar:getWidth() > 5 then
				love.graphics.draw(ui.volumeBarAA, 2, 2)
			end
			love.graphics.setCanvas(ui.sfxVolumeBarCanvas)
			love.graphics.clear()
			love.graphics.draw(ui.emptyVolumeBar, 0, 0)
			love.graphics.draw(ui.volumeBar, sfxVolume*ui.volumeBar:getWidth() - ui.volumeBar:getWidth(), 0)
			if sfxVolume*ui.volumeBar:getWidth() > 2 then
				love.graphics.draw(ui.volumeBarOutline, 0, 0)
			end
			if sfxVolume*ui.volumeBar:getWidth() > 5 then
				love.graphics.draw(ui.volumeBarAA, 2, 2)
			end

			love.graphics.setCanvas(ui.canvas)
			love.graphics.clear()
			love.graphics.setBackgroundColor(0, 0, 0, 0)

			love.graphics.draw(ui.musicVolumeBarCanvas, 56, 37)
			love.graphics.draw(ui.sfxVolumeBarCanvas, 56, 58)
			love.graphics.draw(ui.sprite)
		elseif ui.name == "video" then
			love.graphics.setCanvas(ui.barCanvas)
			love.graphics.clear()
			love.graphics.draw(ui.emptyBar, 0, 0)
			love.graphics.draw(ui.bar, shake*ui.bar:getWidth() - ui.bar:getWidth(), 0)
			if shake*ui.bar:getWidth() > 2 then
				love.graphics.draw(ui.barOutline, 0, 0)
			end
			if shake*ui.bar:getWidth() > 5 then
				love.graphics.draw(ui.barAA, 2, 2)
			end

			love.graphics.setCanvas(ui.canvas)
			love.graphics.clear()

			if fullscreenOn then
				love.graphics.draw(ui.checkBoxOn, 95, 36)
			else
				love.graphics.draw(ui.checkBoxOff, 95, 36)
			end

			if vSyncOn then
				love.graphics.draw(ui.checkBoxOn, 95, 57)
			else
				love.graphics.draw(ui.checkBoxOff, 95, 57)
			end
			love.graphics.setBackgroundColor(0, 0, 0, 0)

			love.graphics.draw(ui.barCanvas, 56, 79)
			love.graphics.draw(ui.sprite)
		end

		love.graphics.setColor(1, 1, 1, 1)
	end

	return ui
end