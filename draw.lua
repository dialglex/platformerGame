function getImages()
	emptyBar = love.graphics.newImage("images/ui/newWeapon/emptyBar.png")
	barOutline = love.graphics.newImage("images/ui/newWeapon/barOutline.png")
	greenBar = love.graphics.newImage("images/ui/newWeapon/greenBar.png")
	greenBarAA = love.graphics.newImage("images/ui/newWeapon/greenBarAA.png")
	greenConnecter = love.graphics.newImage("images/ui/newWeapon/greenConnecter.png")
	orangeBar = love.graphics.newImage("images/ui/newWeapon/orangeBar.png")
	orangeBarAA = love.graphics.newImage("images/ui/newWeapon/orangeBarAA.png")
	orangeConnecter = love.graphics.newImage("images/ui/newWeapon/orangeConnecter.png")
	redBar = love.graphics.newImage("images/ui/newWeapon/redBar.png")
	redBarAA = love.graphics.newImage("images/ui/newWeapon/redBarAA.png")
	redConnecter = love.graphics.newImage("images/ui/newWeapon/redConnecter.png")
	whiteBar = love.graphics.newImage("images/ui/newWeapon/whiteBar.png")
	greyBar = love.graphics.newImage("images/ui/newWeapon/greyBar.png")
	statIcons = love.graphics.newImage("images/ui/statIcons.png")

	damageBarCanvas = love.graphics.newCanvas(emptyBar:getWidth(), emptyBar:getHeight())
	speedBarCanvas = love.graphics.newCanvas(emptyBar:getWidth(), emptyBar:getHeight())
	knockbackBarCanvas = love.graphics.newCanvas(emptyBar:getWidth(), emptyBar:getHeight())

	lowResolutionBackground = love.graphics.newImage("images/backgrounds/lowResolutionBackground.png")
	screenBorder = love.graphics.newImage("images/backgrounds/border.png")
	lowResolutionBackgroundCanvas = love.graphics.newCanvas(7680, 4320) -- make this better when I can be bothered.
	screenBorderCanvas = love.graphics.newCanvas(screenBorder:getWidth(), screenBorder:getHeight())
	screenCanvas = love.graphics.newCanvas(512, 302)
	maskedScreenCanvas = love.graphics.newCanvas(512, 302)
	backgroundImageCanvas = love.graphics.newCanvas(512, 302)
	textCanvas = love.graphics.newCanvas(1920, 1080)
	transitionCanvas = love.graphics.newCanvas(480, 270)
	getFonts()
	--white = 0.973, 0.973, 0.973 (248, 248, 248)
	--black = 0.063, 0.118, 0.161 (16, 30, 41)
end

function getFonts()
	textFont1 = love.graphics.newImageFont("fonts/4x4TextFont1.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]'{}|/~$@^_<>") --bugs out with \
	textFont1Light = love.graphics.newImageFont("fonts/4x4TextFont1Light.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]'{}|/~$@^_<>") --bugs out with \
	textFont1Dark = love.graphics.newImageFont("fonts/4x4TextFont1Dark.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]'{}|/~$@^_<>") --bugs out with \
	boldFont2 = love.graphics.newImageFont("fonts/6x10BoldFont2.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]'{}|/~$@^_<>") --bugs out with \
	titleFont2 = love.graphics.newImageFont("fonts/9x15TitleFont2.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]'{}|/~$@^_<>") --bugs out with \
	
	textFont = textFont1
	signFont = boldFont2
	winFont = love.graphics.newFont("fonts/ubuntu/Ubuntu-Bold.ttf", 50*scale)
	winOutlineFont = love.graphics.newFont("fonts/ubuntu/Ubuntu-Bold.ttf", 53*scale)
end

function drawFadeScreen()
	love.graphics.setCanvas(transitionCanvas)
	love.graphics.clear()
	love.graphics.setColor(0.063, 0.118, 0.161, transitionCounter)
	love.graphics.rectangle("fill", 0, 0, 1920, 1080)
	love.graphics.setColor(255, 255, 255)
	if fadeIn then
		transitionFrozen = true
		transitionCounter = transitionCounter + 0.075
	else
		transitionFrozen = false
		transitionCounter = transitionCounter - 0.075
	end

	if transitionCounter >= 1 and fadeIn then
		fadeIn = false
	elseif transitionCounter <= 0 and fadeIn == false then
		transitioningScreen = false
		transitionCounter = 0
		fadeIn = true
	end
	love.graphics.setCanvas()
end

function screenShake()
	if shakeLength > 0 then
		if shakeType == "short" then
			shakeAmount = (shakeLength/maxShakeLength)*maxShakeAmount
			shakeLength = shakeLength - 1
		elseif shakeType == "long" then
			shakeAmount = shakeAmount - shakeAmount/shakeLength
			shakeLength = shakeLength - 1
		end
		if shakeAmount > 16 then
			shakeX = math.random(-16, 16)
			shakeY = math.random(-16, 16)
		else
			shakeX = math.random(-shakeAmount + math.random(), shakeAmount - math.random())
			shakeY = math.random(-shakeAmount + math.random(), shakeAmount - math.random())
		end
		if gamepad ~= nil then
			gamepad:setVibration(1, 1)
		end
	else
		shakeLength = 0
		shakeAmount = 0
		maxShakeLength = 0
		maxShakeAmount = 0
		shakeX = 0
		shakeY = 0
		if gamepad ~= nil then
			gamepad:setVibration()
		end
	end
end

function convertOpacity(canvas, alpha)
	love.graphics.setCanvas()
	local imageData = canvas:newImageData()
	for x = 1, imageData:getWidth() do
		for y = 1, imageData:getHeight() do
			-- Pixel coordinates range from 0 to image width - 1 / height - 1.
			r, g, b, a = imageData:getPixel(x-1, y-1)
			if a > 0 then
				imageData:setPixel(x-1, y-1, r, g, b, alpha)
			end
		end
	end
	love.graphics.setCanvas(canvas)
	return love.graphics.newImage(imageData)
end

function convertColor(canvas, r1, g1, b1, a1, image)
	if image ~= nil then
		canvas = love.graphics.newCanvas(image:getWidth(), image:getHeight())
		love.graphics.setCanvas(canvas)
		love.graphics.draw(image)
	end

	love.graphics.setCanvas()
	local imageData = canvas:newImageData()
	local width = imageData:getWidth()
	local height = imageData:getHeight()
	local string = ""

	for y1 = 1, height do
		for x1 = 1, width do
			local pixel = {}
			pixel.x = x1 - 1
			pixel.y = y1 - 1

			r2, g2, b2, a2 = imageData:getPixel(pixel.x, pixel.y)
			if a2 > 0 then
				string = string.."X"
				imageData:setPixel(pixel.x, pixel.y, r1, g1, b1, a1)
			else
				string = string.." "
			end
		end
		string = string.."\n"
	end

	love.graphics.setCanvas(canvas)
	return love.graphics.newImage(imageData)
end

function giveOutline(image, color)
	r1, g1, b1, a1 = unpack(color)
	local colorImage = convertColor(nil, r1, g1, b1, a1, image)
	local canvas = love.graphics.newCanvas(image:getWidth()+2, image:getHeight()+2)

	local imageDataCanvas = love.graphics.newCanvas(image:getWidth() + 2, image:getHeight() + 2)
	love.graphics.setCanvas(imageDataCanvas)
	love.graphics.draw(image, 1, 1)
	love.graphics.setCanvas()
	local oldImageData = imageDataCanvas:newImageData()
	local width = oldImageData:getWidth()
	local height = oldImageData:getHeight()
	local newImageData = love.image.newImageData(width, height)
	local pixels = {}

	love.graphics.setCanvas(canvas)
	love.graphics.draw(colorImage, 1, 1+1)
	love.graphics.draw(colorImage, 1, 1-1)
	love.graphics.draw(colorImage, 1+1, 1)
	love.graphics.draw(colorImage, 1-1, 1)


	for y1 = 1, height do
		for x1 = 1, width do
			local pixel = {}
			pixel.x = x1 - 1
			pixel.y = y1 - 1
			for y2 = 1, height do
				for x2 = 1, width do
					_, _, _, a2 = oldImageData:getPixel(pixel.x, pixel.y)
					if a2 == 0 then
						if x2 - 1 == pixel.x + 1 and y2 - 1 == pixel.y + 1 then
							_, _, _, a3 = oldImageData:getPixel(pixel.x + 1, pixel.y + 1)
							if a3 > 0 then
								_, _, _, aRight = oldImageData:getPixel(pixel.x + 2, pixel.y + 1)
								_, _, _, aDown = oldImageData:getPixel(pixel.x + 1, pixel.y + 2)
								if aRight > 0 and aDown > 0 then
									_, _, _, aLeft = oldImageData:getPixel(pixel.x + 1, pixel.y)
									_, _, _, aRight = oldImageData:getPixel(pixel.x + 2, pixel.y)
									_, _, _, aUp = oldImageData:getPixel(pixel.x, pixel.y + 1)
									_, _, _, aDown = oldImageData:getPixel(pixel.x, pixel.y + 2)
									if aLeft == 0 and aRight == 0 and aUp == 0 and aDown == 0 then
										newImageData:setPixel(pixel.x, pixel.y, r1, g1, b1, a1)
									end
								end
							end
						elseif x2 - 1 == pixel.x - 1 and y2 - 1 == pixel.y - 1 then
							_, _, _, a3 = oldImageData:getPixel(pixel.x - 1, pixel.y - 1)
							if a3 > 0 then
								_, _, _, aLeft = oldImageData:getPixel(pixel.x - 2, pixel.y - 1)
								_, _, _, aUp = oldImageData:getPixel(pixel.x - 1, pixel.y - 2)
								if aLeft > 0 and aUp > 0 then
									_, _, _, aRight = oldImageData:getPixel(pixel.x - 1, pixel.y)
									_, _, _, aLeft = oldImageData:getPixel(pixel.x - 2, pixel.y)
									_, _, _, aDown = oldImageData:getPixel(pixel.x, pixel.y - 1)
									_, _, _, aUp = oldImageData:getPixel(pixel.x, pixel.y - 2)
									if aLeft == 0 and aRight == 0 and aUp == 0 and aDown == 0 then
										newImageData:setPixel(pixel.x, pixel.y, r1, g1, b1, a1)
									end
								end
							end
						elseif x2 - 1 == pixel.x - 1 and y2 - 1 == pixel.y + 1 then
							_, _, _, a3 = oldImageData:getPixel(pixel.x - 1, pixel.y + 1)
							if a3 > 0 then
								_, _, _, aLeft = oldImageData:getPixel(pixel.x - 2, pixel.y + 1)
								_, _, _, aDown = oldImageData:getPixel(pixel.x - 1, pixel.y + 2)
								if aLeft > 0 and aDown > 0 then
									_, _, _, aRight = oldImageData:getPixel(pixel.x - 1, pixel.y)
									_, _, _, aLeft = oldImageData:getPixel(pixel.x - 2, pixel.y)
									_, _, _, aUp = oldImageData:getPixel(pixel.x, pixel.y + 1)
									_, _, _, aDown = oldImageData:getPixel(pixel.x, pixel.y + 2)
									if aLeft == 0 and aRight == 0 and aUp == 0 and aDown == 0 then
										newImageData:setPixel(pixel.x, pixel.y, r1, g1, b1, a1)
									end
								end
							end
						elseif x2 - 1 == pixel.x + 1 and y2 - 1 == pixel.y - 1 then
							_, _, _, a3 = oldImageData:getPixel(pixel.x + 1, pixel.y - 1)
							if a3 > 0 then
								_, _, _, aRight = oldImageData:getPixel(pixel.x + 2, pixel.y - 1)
								_, _, _, aUp = oldImageData:getPixel(pixel.x + 1, pixel.y - 2)
								if aRight > 0 and aUp > 0 then
									_, _, _, aLeft = oldImageData:getPixel(pixel.x + 1, pixel.y)
									_, _, _, aRight = oldImageData:getPixel(pixel.x + 2, pixel.y)
									_, _, _, aDown = oldImageData:getPixel(pixel.x, pixel.y - 1)
									_, _, _, aUp = oldImageData:getPixel(pixel.x, pixel.y - 2)
									if aLeft == 0 and aRight == 0 and aUp == 0 and aDown == 0 then
										newImageData:setPixel(pixel.x, pixel.y, r1, g1, b1, a1)
									end
								end
							end
						end
					end
					-- Pixel coordinates range from 0 to image width - 1 / height - 1.
				end
			end
		end
	end

	local corners = love.graphics.newImage(newImageData)
	love.graphics.draw(corners)
	love.graphics.draw(image, 1, 1)
	love.graphics.setCanvas()

	return canvas
end

function drawProgressBar(bar, actor, progressionBarWidth, progressionBarHeight, progressionBarOffset, progressionBarOpacity, onActor, progressionBarX, progressionBarY)
	if bar == "health" then
		local xOffset = 0
		local yOffset = 0
		if actor.attacking then
			xOffset = -actor.attackXOffset
			yOffset = -actor.attackYOffset
		end
		if onActor and actor.hp > 0 then
			--black border
			love.graphics.setColor(0, 0, 0, progressionBarOpacity)
			love.graphics.rectangle("fill", actor.x + actor.width/2 - progressionBarWidth/2 - 1 + xOffset, actor.y - progressionBarOffset - 1,
				progressionBarWidth + 2, progressionBarHeight + 2)
			--color inside
			love.graphics.setColor(1-actor.hp/actor.maxHp, actor.hp/actor.maxHp - 0.1, 0, progressionBarOpacity)
			love.graphics.rectangle("fill", actor.x + actor.width/2 - progressionBarWidth/2 + xOffset, actor.y - progressionBarOffset,
				actor.hp/actor.maxHp*progressionBarWidth, progressionBarHeight)
		elseif onActor == false then
			--black border
			love.graphics.setColor(0, 0, 0, progressionBarOpacity)
			love.graphics.rectangle("fill", progressionBarX, progressionBarY, progressionBarWidth, progressionBarHeight, 3, 3)
			if actor.hp > 0 then
				--color inside
				love.graphics.setColor(1-actor.hp/actor.maxHp, actor.hp/actor.maxHp, 0, progressionBarOpacity)
				love.graphics.rectangle("fill", progressionBarX+1*2, progressionBarY+1*2, actor.hp/actor.maxHp*progressionBarWidth-2*2, progressionBarHeight-2*2, 3, 3)
			end
			--color highlight
			love.graphics.setColor(1, 1, 0.5+(actor.hp/actor.maxHp)*0.35, progressionBarOpacity*(actor.hp/actor.maxHp))
			love.graphics.rectangle("fill", progressionBarX+1*2, progressionBarY+4, (progressionBarWidth)*actor.hp/actor.maxHp - 2*2, (progressionBarHeight-2*2)/3)
		end
	end
	love.graphics.setColor(1, 1, 1, 1)
end

function drawScreen()
	textToDraw = {}

	player:draw()

	for _, actor in ipairs(npcs) do
		actor:draw()
	end

	for _, actor in ipairs(dusts) do
		actor:draw()
	end

	for _, actor in ipairs(weapons) do
		actor:draw()
	end

	for _, actor in ipairs(items) do
		actor:draw()
	end

	for _, actor in ipairs(uis) do
		actor:draw()
	end
	love.graphics.setCanvas(backgroundImageCanvas)
	love.graphics.draw(backgroundImage, -16, -16)
	
	love.graphics.setCanvas(screenCanvas)
	love.graphics.draw(backgroundCanvas)

	for _, actor in ipairs(tiles) do
		if actor.name == "teleporter" then
			if actor.active or bossLevel then
				love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
			end
		elseif actor.name == "chest" then
			love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
		end
	end	

	for _, actor in ipairs(objects) do
		if actor.nearCounter > 0.1 and actor.active then
			love.graphics.setColor(0.973, 0.973, 0.973, actor.nearCounter)
			love.graphics.setLineStyle("rough")
			love.graphics.setLineWidth(2)
			love.graphics.rectangle("line", actor.x, actor.y, actor.width, actor.height, 3)
			love.graphics.setFont(signFont)
			if actor.type == "sign" and uiFrozen == false then
				wrapWidth, wrapText = signFont:getWrap(actor.data, 300)
				textHeight = signFont:getHeight()
				textLines = #wrapText
				textX = actor.x - (wrapWidth) + (actor.width/2) + wrapWidth / 2
				textY = actor.y - textHeight*textLines

				love.graphics.setColor(0.063, 0.118, 0.161, actor.nearCounter / 2)
				love.graphics.rectangle("fill", textX - 4, textY - 2, wrapWidth + 7, textLines*textHeight + 4, 3)
				love.graphics.setColor(0.973, 0.973, 0.973, actor.nearCounter)
				love.graphics.printf(actor.data, textX, textY, wrapWidth, "center")
			end
		end
	end
	love.graphics.setColor(1, 1, 1)

	for _, actor in ipairs(weapons) do
		love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
	end

	for _, actor in ipairs(items) do
		love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
	end

	love.graphics.draw(player.canvas, player:getX() - 3, player:getY() - 2)

	for _, actor in ipairs(dusts) do
		love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
	end

	for _, actor in ipairs(npcs) do
		if actor.background then
			love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
		end
	end

	love.graphics.draw(foregroundCanvas)

	for _, actor in ipairs(npcs) do
		if actor.background == false then
			love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
		end
	end

	for _, actor in ipairs(npcs) do
		drawProgressBar("health", actor, 20 + 0.05*actor.maxHp, 5, 5, actor.healthBarOpacity, true)
	end
	drawProgressBar("health", player, 20 + 0.05*player.hp, 5, -player.height-1, 1, true)

	for _, actor in ipairs(items) do
		if actor.type == "shop" and uiFrozen == false then
			love.graphics.setFont(signFont)
			if actor.nearCounter > 0.1 then
				local wrapWidth, wrapText = signFont:getWrap(camelToTitle(actor.randomName), 300)
				local textHeight = signFont:getHeight()
				local textX = (actor.x + actor.width/2) - wrapWidth/2 + 1
				local textY = actor.y - textHeight - 3

				if actor.name == "weaponShopItem" then
					local name, weaponType, _, _, _, _, _, width, height, damage, knockback, startupLag,
						slashDuration, endLag, _, _, _, movementReduction, pierce = unpack(getWeaponStats(actor.randomName))
					local speed = 60 - (startupLag + slashDuration + endLag)

					love.graphics.setCanvas(damageBarCanvas)
					love.graphics.clear()
					drawBar(damage/100)
					love.graphics.setCanvas(speedBarCanvas)
					love.graphics.clear()
					drawBar(speed/60)
					love.graphics.setCanvas(knockbackBarCanvas)
					love.graphics.clear()
					drawBar(knockback/5)

					barX = (actor.x + actor.width/2) - emptyBar:getWidth()/2 + (5 + 12)/2
					barY = textY - emptyBar:getHeight() - 2
					love.graphics.setCanvas(screenCanvas)

					love.graphics.setColor(0.063, 0.118, 0.161, actor.nearCounter / 2)
					if emptyBar:getWidth() > wrapWidth then
						love.graphics.rectangle("fill", barX - 4 - 5 - 12, textY - 28 - emptyBar:getHeight() - 5, emptyBar:getWidth() + 5 + 12 + 7, 28 + emptyBar:getHeight() + textHeight + 5, 3)
					else
						love.graphics.rectangle("fill", textX - 4, textY - 28 - emptyBar:getHeight() - 5, wrapWidth + 7, 28 + emptyBar:getHeight() + textHeight + 5, 3)
					end
					love.graphics.setColor(0.973, 0.973, 0.973, actor.nearCounter)
					love.graphics.printf(camelToTitle(actor.randomName), textX, textY, wrapWidth, "center")
					
					love.graphics.draw(statIcons, math.floor(barX - 5 - 12), math.floor(barY - 28))
					love.graphics.draw(damageBarCanvas, barX, barY - 28)
					love.graphics.draw(speedBarCanvas, barX, barY - 14)
					love.graphics.draw(knockbackBarCanvas, barX, barY)
				else
					local accessoryName, iconImage, accessoryType, text, xAcceleration, xDeceleration, xTerminalVelocity, jumpAcceleration, fallAcceleration,
						yTerminalVelocity = unpack(getAccessoryStats(actor.randomName))
					local itemWrapWidth, itemWrapText = textFont:getWrap(text, 300)
					local itemTextHeight = textFont:getHeight()
					local itemTextX = (actor.x + actor.width/2) - itemWrapWidth/2 + 1
					local itemTextY = textY - itemTextHeight - 2

					love.graphics.setFont(signFont)
					love.graphics.setColor(0.063, 0.118, 0.161, actor.nearCounter / 2)
					if itemWrapWidth > wrapWidth then
						love.graphics.rectangle("fill", itemTextX - 4, itemTextY - 3, itemWrapWidth + 7, itemTextHeight + textHeight + 5, 3)
					else
						love.graphics.rectangle("fill", textX - 4, itemTextY - 3, wrapWidth + 7, itemTextHeight + textHeight + 5, 3)
					end
					love.graphics.setColor(0.973, 0.973, 0.973, actor.nearCounter)
					love.graphics.printf(camelToTitle(actor.randomName), textX, textY, wrapWidth, "center")

					love.graphics.setFont(textFont)
					love.graphics.setColor(0.973, 0.973, 0.973, actor.nearCounter)
					love.graphics.printf(text, itemTextX, itemTextY, itemWrapWidth, "center")
				end
			end
			love.graphics.setFont(signFont)
			local wrapWidth, wrapText = signFont:getWrap("$"..tostring(actor.price), 300)
			local textHeight = signFont:getHeight()
			local textX = (actor.x + actor.width/2) - wrapWidth/2 + 1
			local textY = (actor.y + actor.height) + 2

			love.graphics.setColor(0.063, 0.118, 0.161, 0.5)
			love.graphics.rectangle("fill", textX - 4, textY - 2, wrapWidth + 7, textHeight + 4, 3)
			love.graphics.setColor(0.973, 0.973, 0.973)
			love.graphics.printf("$"..tostring(actor.price), textX, textY, wrapWidth, "center")
		end
	end
	love.graphics.setColor(1, 1, 1)

	for _, actor in ipairs(uis) do
		love.graphics.draw(actor.canvas, actor:getX() + 16, actor:getY() + 16)
	end

	if player.isDead() then
		wrapWidth, wrapText = winOutlineFont:getWrap("YOU DIED", 10000)
		textHeight = winOutlineFont:getHeight()
		textLines = #wrapText
		textX = 480/2*scale - wrapWidth/2
		textY = 270/2*scale - textHeight/2
		table.insert(textToDraw, {"YOU DIED", winOutlineFont, textX, textY, 10000, nil, {0.063, 0.118, 0.161, 0.4}})
		wrapWidth, wrapText = winFont:getWrap("YOU DIED", 10000)
		textHeight = winFont:getHeight()
		textLines = #wrapText
		textX = 480/2*scale - wrapWidth/2
		textY = 270/2*scale - textHeight/2
		table.insert(textToDraw, {"YOU DIED", winFont, textX, textY, 10000, nil, {0.973, 0.973, 0.973}})
	end

	if win then
		wrapWidth, wrapText = winOutlineFont:getWrap("YOU WIN", 1000)
		textHeight = winOutlineFont:getHeight()
		textLines = #wrapText
		textX = 480/2*scale - wrapWidth/2
		textY = 270/2*scale - textHeight/2
		table.insert(textToDraw, {"YOU WIN", winOutlineFont, textX, textY, 1000, nil, {0.063, 0.118, 0.161, 0.4}})
		wrapWidth, wrapText = winFont:getWrap("YOU WIN", 1000)
		textHeight = winFont:getHeight()
		textLines = #wrapText
		textX = 480/2*scale - wrapWidth/2
		textY = 270/2*scale - textHeight/2
		table.insert(textToDraw, {"YOU WIN", winFont, textX, textY, 1000, nil, {0.973, 0.973, 0.973}})
	end
	
	newPurple = 1-(player.hp/player.maxHp)
	if newPurple > purple then
		purple = purple + 0.05
	end

	love.graphics.setColor(0.39, 0.27, 0.55, purple/10)
	love.graphics.rectangle("fill", 0, 0, 506, 296)
	love.graphics.setColor(1, 1, 1)
	drawTextCanvas()
	screenShake()
	if transitioningScreen then
		drawFadeScreen()
	end
end

function drawTextCanvas()
	love.graphics.setCanvas(textCanvas)
	love.graphics.clear()
	for i, e in ipairs(textToDraw) do
		text, font, x, y, wrap, style, color = unpack(e)
		love.graphics.setFont(font)
		love.graphics.setColor(unpack(color))
		if style ~= nil then
			love.graphics.printf(text, x, y, wrap, style)
		else
			love.graphics.printf(text, x, y, wrap)
		end
	end
	love.graphics.setCanvas()
end

function drawDebug()
	--draw tile hitboxes
	love.graphics.setCanvas(screenCanvas)
	for _, actor in ipairs(tiles) do
		if debug and actor.collidable then
			love.graphics.setColor(0, 0, 1, 0.8)
			love.graphics.rectangle("fill", actor.hitboxX + actor.x, actor.hitboxY + actor.y, actor.hitboxWidth, actor.hitboxHeight)
		elseif debug then
			love.graphics.setColor(1, 0, 1, 0.1)
			love.graphics.rectangle("fill", actor.hitboxX + actor.x, actor.hitboxY + actor.y, actor.hitboxWidth, actor.hitboxHeight)
		end
	end
	love.graphics.setColor(1, 1, 1, 1)

	if debug then
		for _, hitbox in ipairs(hitboxes) do
			x, y, w, h = unpack(hitbox)
			love.graphics.setColor(1, 0, 0, 0.6)
			love.graphics.rectangle("fill", x, y, w, h)
		end
		love.graphics.setColor(0, 1, 0, 0.6)
		love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.setColor(1, 1, 1)

		for i, string in ipairs(debugStrings) do
			love.graphics.setFont(textFont)
			love.graphics.print(string, 2 + 16, (i - 1) * 12 + 16)
		end
	end
	love.graphics.setCanvas()
end

function drawFPS()
	love.graphics.setCanvas(screenCanvas)
	if not debug then
		love.graphics.setFont(textFont)
		-- love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 4, 4)
	end
	love.graphics.setCanvas()
end

function drawBar(number1, number2) -- numbers must be between 0 and 1
	love.graphics.draw(emptyBar, 0, 0)

	if number2 == nil then
		if number1*emptyBar:getWidth() < emptyBar:getWidth()*1/3 then
			love.graphics.draw(redBar, number1*emptyBar:getWidth() - emptyBar:getWidth(), 0)
			if number1*emptyBar:getWidth() > 5 then
				love.graphics.draw(redBarAA, 2, 2)
			end
		elseif number1*emptyBar:getWidth() < emptyBar:getWidth()*2/3 then
			love.graphics.draw(orangeBar, number1*emptyBar:getWidth() - emptyBar:getWidth(), 0)
			if number1*emptyBar:getWidth() > 5 then
				love.graphics.draw(orangeBarAA, 2, 2)
			end
		else
			love.graphics.draw(greenBar, number1*emptyBar:getWidth() - emptyBar:getWidth(), 0)
			if number1*emptyBar:getWidth() > 5 then
				love.graphics.draw(greenBarAA, 2, 2)
			end
		end
		if number1*emptyBar:getWidth() > 2 then
			love.graphics.draw(barOutline, 0, 0)
		end
	else
		if number1 > number2 then
			love.graphics.draw(whiteBar, number1*emptyBar:getWidth() - emptyBar:getWidth(), 0)
			if number2*emptyBar:getWidth() < emptyBar:getWidth()*1/3 then
				love.graphics.draw(redBar, number2*emptyBar:getWidth() - emptyBar:getWidth(), 0)
				if number2*emptyBar:getWidth() > 5 then
					love.graphics.draw(redBarAA, 2, 2)
				end
				if number1 ~= number2 then
					love.graphics.draw(redConnecter, number2*emptyBar:getWidth() - 3, 0)
				end
			elseif number2*emptyBar:getWidth() < emptyBar:getWidth()*2/3 then
				love.graphics.draw(orangeBar, number2*emptyBar:getWidth() - emptyBar:getWidth(), 0)
				if number2*emptyBar:getWidth() > 5 then
					love.graphics.draw(orangeBarAA, 2, 2)
				end
				if number1 ~= number2 then
					love.graphics.draw(orangeConnecter, number2*emptyBar:getWidth() - 3, 0)
				end
			else
				love.graphics.draw(greenBar, number2*emptyBar:getWidth() - emptyBar:getWidth(), 0)
				if number2*emptyBar:getWidth() > 5 then
					love.graphics.draw(greenBarAA, 2, 2)
				end
				if number1 ~= number2 then
					love.graphics.draw(greenConnecter, number2*emptyBar:getWidth() - 3, 0)
				end
			end
		else
			love.graphics.draw(greyBar, number2*emptyBar:getWidth() - emptyBar:getWidth(), 0)
			if number1*emptyBar:getWidth() < emptyBar:getWidth()*1/3 then
				love.graphics.draw(redBar, number1*emptyBar:getWidth() - emptyBar:getWidth(), 0)
				if number1*emptyBar:getWidth() > 5 then
					love.graphics.draw(redBarAA, 2, 2)
				end
				if number1 ~= number2 then
					love.graphics.draw(redConnecter, number1*emptyBar:getWidth() - 3, 0)
				end
			elseif number1*emptyBar:getWidth() < emptyBar:getWidth()*2/3 then
				love.graphics.draw(orangeBar, number1*emptyBar:getWidth() - emptyBar:getWidth(), 0)
				if number1*emptyBar:getWidth() > 5 then
					love.graphics.draw(orangeBarAA, 2, 2)
				end
				if number1 ~= number2 then
					love.graphics.draw(orangeConnecter, number1*emptyBar:getWidth() - 3, 0)
				end
			else
				love.graphics.draw(greenBar, number1*emptyBar:getWidth() - emptyBar:getWidth(), 0)
				if number1*emptyBar:getWidth() > 5 then
					love.graphics.draw(greenBarAA, 2, 2)
				end
				if number1 ~= number2 then
					love.graphics.draw(greenConnecter, number1*emptyBar:getWidth() - 3, 0)
				end
			end
		end
		
		if number2*emptyBar:getWidth() > 2 then
			love.graphics.draw(barOutline, 0, 0)
		end
	end
end

function setScreenCanvas()
	love.graphics.draw(lowResolutionBackground)

	love.graphics.setCanvas(screenBorderCanvas)
	love.graphics.draw(screenBorder)
	love.graphics.setCanvas()

	love.graphics.setCanvas(screenCanvas)

	love.graphics.clear()
end

function screenStencil()
	love.graphics.rectangle("fill", 0, 0, 480, 270)
end

function drawScreenCanvas()
	love.graphics.setCanvas{maskedScreenCanvas, stencil = true}
	love.graphics.clear()
	love.graphics.stencil(screenStencil, "replace", 1)
	love.graphics.setStencilTest("greater", 0)
	love.graphics.draw(backgroundImageCanvas, -16, -16)
	love.graphics.draw(screenCanvas, shakeX*shake - 16, shakeY*shake- 16)
	love.graphics.setStencilTest()
	love.graphics.setCanvas()

	love.graphics.draw(maskedScreenCanvas, math.floor((xWindowSize - (480*scale))/2), math.floor((yWindowSize - (270*scale))/2), 0, scale, scale)
	-- love.graphics.draw(backgroundImageCanvas, math.floor((xWindowSize - (480*scale))/2), math.floor((yWindowSize - (270*scale))/2), 0, scale, scale)
	love.graphics.draw(textCanvas, math.floor((xWindowSize - 480*scale)/2), math.floor((yWindowSize - 270*scale)/2))
	love.graphics.draw(transitionCanvas, math.floor((xWindowSize - (480*scale))/2), math.floor((yWindowSize - (270*scale))/2), 0, scale, scale)
	love.graphics.draw(screenBorderCanvas, math.floor((xWindowSize - (480*scale))/2 - 7*scale), math.floor((yWindowSize - (270*scale))/2 - 7*scale), 0, scale, scale)
end