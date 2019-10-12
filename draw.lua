function getImages()
	getTileImages()
	getUiImages()
	getNpcImages()
	getWeaponImages()
	getAccessoryImages()
	getDustImages()
	getShaders()

	coin1Sprite = love.graphics.newImage("images/items/coin1.png")
	coin2Sprite = love.graphics.newImage("images/items/coin2.png")
	coin3Sprite =love.graphics.newImage("images/items/coin3.png")

	damageBarCanvas = love.graphics.newCanvas(emptyBar:getWidth(), emptyBar:getHeight())
	speedBarCanvas = love.graphics.newCanvas(emptyBar:getWidth(), emptyBar:getHeight())
	knockbackBarCanvas = love.graphics.newCanvas(emptyBar:getWidth(), emptyBar:getHeight())

	lowResolutionBackground = love.graphics.newImage("images/backgrounds/lowResolutionBackground.png")
	screenBorder = love.graphics.newImage("images/backgrounds/border.png")
	lowResolutionBackgroundCanvas = love.graphics.newCanvas(7680, 4320)
	screenBorderCanvas = love.graphics.newCanvas(screenBorder:getWidth(), screenBorder:getHeight())
	screenCanvas = love.graphics.newCanvas(512, 302)
	maskedScreenCanvas = love.graphics.newCanvas(512, 302)
	backgroundImageCanvas = love.graphics.newCanvas(512, 302)
	debugCanvas = love.graphics.newCanvas(512, 302)
	textCanvas = love.graphics.newCanvas(1920, 1080)
	transitionCanvas = love.graphics.newCanvas(480, 270)
	getFonts()

	--white = 0.973, 0.973, 0.973 (248, 248, 248)
	--black = 0.063, 0.118, 0.161 (16, 30, 41)
end

function getShaders()
	convertColorShader = love.graphics.newShader[[
		vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
		{
			vec4 pixel = Texel(texture, texture_coords ); //This is the current pixel color
			if (pixel.a == 1)
			{
				return color;
			}
			else
			{
				return vec4(0, 0, 0, 0);
			}
		}
	]]

	keepWhiteConvertColorShader = love.graphics.newShader[[
		vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
		{
			vec4 pixel = Texel(texture, texture_coords ); //This is the current pixel color
			if (pixel.r == 0.9725490196 && pixel.g == 0.9725490196 && pixel.b == 0.9725490196)
			{
				return pixel;
			}
			else if (pixel.a == 1)
			{
				return color;
			}
			else
			{
				return vec4(0, 0, 0, 0);
			}
		}
	]]
end

function getFonts()
	textFont1 = love.graphics.newImageFont("fonts/4x4TextFont1.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]'{}|/~$@^_<>") --bugs out with \
	textFont1Light = love.graphics.newImageFont("fonts/4x4TextFont1Light.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]'{}|/~$@^_<>") --bugs out with \
	textFont1Dark = love.graphics.newImageFont("fonts/4x4TextFont1Dark.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]'{}|/~$@^_<>") --bugs out with \
	textFont1Pink = love.graphics.newImageFont("fonts/4x4TextFont1Pink.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]'{}|/~$@^_<>") --bugs out with \
	boldFont2 = love.graphics.newImageFont("fonts/6x10BoldFont2.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]'{}|/~$@^_<>") --bugs out with \
	boldFont2Pink = love.graphics.newImageFont("fonts/6x10BoldFont2.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]'{}|/~$@^_<>") --bugs out with \
	titleFont2 = love.graphics.newImageFont("fonts/9x15TitleFont2.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]'{}|/~$@^_<>") --bugs out with \
	
	textFont = textFont1
	signFont = boldFont2
	winFont = love.graphics.newFont("fonts/ubuntu/Ubuntu-Bold.ttf", 50*scale)
	winOutlineFont = love.graphics.newFont("fonts/ubuntu/Ubuntu-Bold.ttf", 53*scale)
end

function getQuads(spritesheet, frames)
	local quads = {}
	local spritesheetWidth = spritesheet:getWidth()
	local spritesheetHeight = spritesheet:getHeight()
	local width = spritesheetWidth/frames
	local height = spritesheetHeight
	for i = 1, frames do
		table.insert(quads, love.graphics.newQuad(width*(i - 1), 0, width, height, spritesheetWidth, spritesheetHeight))
	end
	return quads
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

	if transitionCounter >= 1 and fadeIn then -- switching it once it reaches full blackness
		fadeIn = false
	elseif transitionCounter <= 0 and fadeIn == false then -- finishing and resetting it
		transitioningScreen = false
		transitionCounter = 0
		fadeIn = true
	end
	love.graphics.setCanvas()
end

function screenShake()
	if shakeLength > 0 then
		shakeAmount = (shakeLength/maxShakeLength)*maxShakeAmount
		shakeLength = shakeLength - 1
		if shakeAmount > 16 then
			shakeX = math.random(-16, 16)
			shakeY = math.random(-16, 16)
		else
			shakeX = math.random(-shakeAmount, shakeAmount)
			shakeY = math.random(-shakeAmount, shakeAmount)
		end
		if lastInputType == "gamepad" then
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

function giveOutline(image, color, sharp)
	r1, g1, b1, a1 = unpack(color)
	local canvas = love.graphics.newCanvas(image:getWidth()+2, image:getHeight()+2)

	love.graphics.setCanvas(canvas)
	love.graphics.setShader(convertColorShader)
	love.graphics.setColor(r1, g1, b1, a1)
	love.graphics.draw(image, 1, 1+1)
	love.graphics.draw(image, 1, 1-1)
	love.graphics.draw(image, 1+1, 1)
	love.graphics.draw(image, 1-1, 1)
	love.graphics.setShader()

	if sharp then
		local imageDataCanvas = love.graphics.newCanvas(image:getWidth() + 2, image:getHeight() + 2)
		love.graphics.setCanvas(imageDataCanvas)
		love.graphics.draw(image, 1, 1)
		love.graphics.setCanvas()
		local oldImageData = imageDataCanvas:newImageData()
		local width = oldImageData:getWidth()
		local height = oldImageData:getHeight()
		local newImageData = love.image.newImageData(width, height)
		local pixels = {}
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
					end
				end
			end
		end
		love.graphics.setCanvas(canvas)
		local corners = love.graphics.newImage(newImageData)
		love.graphics.draw(corners)
	end

	love.graphics.draw(image, 1, 1)
	love.graphics.setCanvas()

	return canvas
end

function drawHealthBar(actor, barWidth, barHeight, barOffset, barOpacity, barColor)
	local x
	local y = actor:getY() - barOffset
	if actor.direction == "left" then
		x = actor:getX() + (actor.width - actor.hitboxWidth - actor.hitboxX) + actor.hitboxWidth/2 - barWidth/2
	else
		x = actor:getX() + actor.hitboxX + actor.hitboxWidth/2 - barWidth/2
	end
	if actor.actor == "npc" and actor.attacking then
		if actor.direction == "left" then
			x = x - actor.leftAttackXOffset
		elseif actor.direction == "right" then
			x = x - actor.rightAttackXOffset
		end
		y = y - actor.attackYOffset
	end
	x = math.floor(x)
	y = math.floor(y)

	-- black border
	love.graphics.setColor(0, 0, 0, barOpacity)
	love.graphics.rectangle("fill", x - 1, y - 1, barWidth + 2, barHeight + 2)

	-- white previous hp
	if actor.hit then
		love.graphics.setColor(0.973, 0.973, 0.973, barOpacity)
		love.graphics.rectangle("fill", x, y, actor.previousHp/actor.maxHp*barWidth, barHeight)
	end

	-- color inside
	if barColor == "green" then
		love.graphics.setColor(0.231, 0.741, 0.388, barOpacity)
	elseif barColor == "red" then
		love.graphics.setColor(0.718, 0.255, 0.333, barOpacity)
	end
	love.graphics.rectangle("fill", x, y, actor.hp/actor.maxHp*barWidth, barHeight)

	if barColor == "green" then
		love.graphics.setColor(0.545, 0.894, 0.435, barOpacity)
	elseif barColor == "red" then
		love.graphics.setColor(0.910, 0.365, 0.329, barOpacity)
	end
	love.graphics.rectangle("fill", x, y + 1, actor.hp/actor.maxHp*barWidth, barHeight - 3)
	
	-- status effects
	if actor.actor == "npc" then
		local hpWidth = actor.hp/actor.maxHp
		local damageBuff = 1
		if isInTable("poisonDamage", player.accessories) and actor.poison > 0 then
			damageBuff = 1.5
		end
		local burnWidth = (actor.burn/3*player.damageBuff*damageBuff)/actor.maxHp
		local poisonWidth = (actor.poison/6*player.damageBuff*damageBuff)/actor.maxHp
		local burnX = hpWidth - burnWidth
		local poisonX = hpWidth - burnWidth - poisonWidth
		if poisonWidth + burnWidth > actor.hp/actor.maxHp then
			poisonX = 0
			poisonWidth = actor.hp/actor.maxHp - burnWidth
		end
		
		if burnWidth > hpWidth then
			burnX = 0
			burnWidth = hpWidth
			poisonX = 0
			poisonWidth = 0
		end

		if actor.burn > 0 then
			love.graphics.setColor(0.949, 0.584, 0.275, barOpacity)
			love.graphics.rectangle("fill", x + burnX*barWidth, y, burnWidth*barWidth, barHeight)
			love.graphics.setColor(1, 0.808, 0, barOpacity)
			love.graphics.rectangle("fill", x + burnX*barWidth, y + 1, burnWidth*barWidth, barHeight - 3)
		end

		if actor.poison > 0 then
			love.graphics.setColor(0.392, 0.275, 0.553, barOpacity)
			love.graphics.rectangle("fill", x + poisonX*barWidth, y, poisonWidth*barWidth, barHeight)
			love.graphics.setColor(0.675, 0.333, 0.671, barOpacity)
			love.graphics.rectangle("fill", x + poisonX*barWidth, y + 1, poisonWidth*barWidth, barHeight - 3)
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
		if actor.name == "corruption" then
			love.graphics.draw(actor.spritesheet, actor.quad, actor:getX(), actor:getY())
		elseif actor.name == "teleporter" then
			if actor.active then
				love.graphics.draw(actor.spritesheet, actor.quad, actor:getX(), actor:getY())
			elseif bossLevel then
				love.graphics.draw(actor.spritesheet, actor:getX(), actor:getY())
			end
		elseif actor.name == "chest" then
			if actor.active then
				if actor.opening then
					love.graphics.draw(actor.spritesheet, actor.quad, actor:getX(), actor:getY())
				else
					love.graphics.draw(actor.spritesheet, actor:getX(), actor:getY())
				end
			end
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


	for _, actor in ipairs(items) do
		if actor.type == "shop" or actor.type == "chest" then
			love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
		end
	end

	love.graphics.draw(player.canvas, player:getX() - 3, player:getY() - 2)

	for _, actor in ipairs(weapons) do
		if actor.type == "projectile" then
			love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
		else
			love.graphics.draw(actor.canvas, math.floor(player:getX() + player.width/2 - actor.width/2 + actor.currentXOffset + 0.5), math.floor(player:getY() + player.height/2 - actor.height/2 + actor.currentYOffset + 0.5))
			if player.weaponOut then
				love.graphics.draw(actor.armOverlaySpritesheet, player.quad, player:getX() - 3, player:getY() - 2)
			end
		end
	end
	
	for _, actor in ipairs(dusts) do
		if actor.background then
			love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
		end
	end

	for _, actor in ipairs(npcs) do
		if actor.background then
			love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
		end
	end

	love.graphics.draw(foregroundCanvas)

	for _, actor in ipairs(items) do
		if actor.type == "coin" then
			love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
		end
	end

	for _, actor in ipairs(npcs) do
		if actor.background == false then
			love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
		end
	end

	for _, actor in ipairs(dusts) do
		if actor.background == false then
			love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
		end
	end
	
	for _, actor in ipairs(npcs) do
		drawHealthBar(actor, 15 + 0.1*actor.maxHp, 5, 5, actor.healthBarOpacity, "red")
	end

	if player.hp > 0 then
		drawHealthBar(player, 15 + 0.1*player.maxHp, 5, -player.height-1, 1, "green")
		love.graphics.setFont(textFont1)
		local text = "$"..tostring(player.money)
		local wrapWidth, wrapText = textFont1:getWrap(text, 1000)
		love.graphics.printf(text, player.x + player.width/2 - wrapWidth/2, player.y + player.height + 8, 1000)
	end

	for _, actor in ipairs(items) do
		if (actor.type == "shop" or actor.type == "chest") and uiFrozen == false then
			love.graphics.setFont(signFont)
			if actor.nearCounter > 0.1 then
				local wrapWidth, wrapText = signFont:getWrap(camelToTitle(actor.randomName), 300)
				local textHeight = signFont:getHeight()
				local textX = (actor.x + actor.width/2) - wrapWidth/2 + 1
				local textY = actor.y - textHeight - 3

				if actor.name == "weaponShopItem" or actor.name == "weaponChestItem" then
					local weapon = getWeaponStats(actor.randomName)
					
					love.graphics.setColor(1, 1, 1, 1)
					love.graphics.setFont(textFont1)
					love.graphics.setCanvas(damageBarCanvas)
					love.graphics.clear()
					drawBar(weapon.damage/100)
					love.graphics.printf(weapon.damage, 49, 2, 14, "right")
					love.graphics.setCanvas(speedBarCanvas)
					love.graphics.clear()
					drawBar(weapon.speed/100)
					love.graphics.printf(weapon.speed, 49, 2, 14, "right")
					love.graphics.setCanvas(knockbackBarCanvas)
					love.graphics.clear()
					drawBar(weapon.knockback/100)
					love.graphics.printf(weapon.knockback, 49, 2, 14, "right")

					love.graphics.setFont(signFont)
					barX = (actor.x + actor.width/2) - emptyBar:getWidth()/2 + (5 + 12)/2
					barY = textY - emptyBar:getHeight() - 4
					love.graphics.setCanvas(screenCanvas)

					love.graphics.setColor(0.063, 0.118, 0.161, actor.nearCounter / 2)
					if emptyBar:getWidth() > wrapWidth then
						love.graphics.rectangle("fill", barX - 4 - 5 - 12, textY - 28 - emptyBar:getHeight() - 7, emptyBar:getWidth() + 5 + 12 + 7, 28 + emptyBar:getHeight() + textHeight + 7, 3)
					else
						love.graphics.rectangle("fill", textX - 4, textY - 28 - emptyBar:getHeight() - 7, wrapWidth + 7, 28 + emptyBar:getHeight() + textHeight + 7, 3)
					end
					love.graphics.setColor(0.973, 0.973, 0.973, actor.nearCounter)
					love.graphics.printf(camelToTitle(actor.randomName), textX, textY, wrapWidth, "center")
					
					if weapon.statusDuration > 0 then
						if weapon.status == "poison" then
							love.graphics.draw(poisonIcon, math.floor(barX - 5 - 12), math.floor(barY - 28))
						end
					else
						love.graphics.draw(damageIcon, math.floor(barX - 5 - 12), math.floor(barY - 28))
					end
					love.graphics.draw(speedKnockbackStatIcons, math.floor(barX - 5 - 12), math.floor(barY - 28))
					love.graphics.draw(damageBarCanvas, barX, barY - 28)
					love.graphics.draw(speedBarCanvas, barX, barY - 14)
					love.graphics.draw(knockbackBarCanvas, barX, barY)
				else
					local accessory = getAccessoryStats(actor.randomName)
					local itemWrapWidth, itemWrapText = textFont:getWrap(accessory.text, 300)
					local itemTextHeight = textFont:getHeight()
					local itemTextX = (actor.x + actor.width/2) - itemWrapWidth/2 + 1
					local itemTextY = textY - itemTextHeight - 2

					local x
					local width
					if itemWrapWidth > wrapWidth then
						x = itemTextX - 4
						width = itemWrapWidth + 7
					else
						x = textX - 4
						width = wrapWidth + 7
					end

					if x < 16 then
						x = 16
					elseif x + width > 496 then
						x = 496 - width
					end

					if textX < 16 then
						textX = 16 + 2
					elseif textX + wrapWidth > 496 then
						textX = 496 - wrapWidth - 2
					end

					if itemTextX < 16 then
						itemTextX = 16 + 2
					elseif itemTextX + itemWrapWidth > 496 then
						itemTextX = 496 - itemWrapWidth - 2
					end

					love.graphics.setFont(signFont)
					love.graphics.setColor(0.063, 0.118, 0.161, actor.nearCounter / 2)
					love.graphics.rectangle("fill", x, itemTextY - 3, width, itemTextHeight + textHeight + 5, 3)

					love.graphics.setColor(0.973, 0.973, 0.973, actor.nearCounter)
					love.graphics.printf(camelToTitle(actor.randomName), textX, textY, wrapWidth, "center")

					love.graphics.setFont(textFont)
					love.graphics.setColor(0.973, 0.973, 0.973, actor.nearCounter)
					love.graphics.printf(accessory.text, itemTextX, itemTextY, itemWrapWidth, "center")
				end
			end
			if actor.type == "shop" then
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
	
	targetPurple = 1-(player.hp/player.maxHp)
	if purple < targetPurple + 0.05 and purple > targetPurple - 0.05 then
		purple = targetPurple
	elseif targetPurple > purple then
		purple = purple + 0.05
	elseif targetPurple < purple then
		purple = purple - 0.05
	end

	if white > 0 then
		white = white - 0.008
	else
		white = 0
	end

	love.graphics.setColor(0.39, 0.27, 0.55, purple/6)
	love.graphics.rectangle("fill", 0, 0, 506, 296)
	love.graphics.setColor(0.973, 0.973, 0.973, white)
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
	love.graphics.setCanvas(debugCanvas)
	love.graphics.clear()
	if debug then
		love.graphics.setColor(1, 1, 1, 1)
		for _, actor in ipairs(tiles) do
			love.graphics.rectangle("fill", actor.hitboxX + actor.x, actor.hitboxY + actor.y, 1, 1)
			
			if actor.collidable then
				love.graphics.setColor(0, 0, 1, 0.6)
				love.graphics.rectangle("fill", actor.hitboxX + actor.x, actor.hitboxY + actor.y, actor.hitboxWidth, actor.hitboxHeight)
			else
				love.graphics.setColor(1, 0, 1, 0.2)
				love.graphics.rectangle("fill", actor.hitboxX + actor.x, actor.hitboxY + actor.y, actor.hitboxWidth, actor.hitboxHeight)
			end
		end

		love.graphics.setColor(0.75, 1, 0.75, 0.9)
		for _, actor in ipairs(npcs) do
			if actor.attacking then
				if actor.direction == "left" then
					love.graphics.rectangle("fill", actor.x + (actor.attackWidth - actor.attackHitboxWidth - actor.attackHitboxX), actor.y + actor.attackHitboxY, actor.attackHitboxWidth, actor.attackHitboxHeight)
				elseif actor.direction == "right" then
					love.graphics.rectangle("fill", actor.x + actor.attackHitboxX, actor.y + actor.attackHitboxY, actor.attackHitboxWidth, actor.attackHitboxHeight)
				end
			else
				if actor.direction == "left" then
					love.graphics.rectangle("fill", actor.x + (actor.width - actor.hitboxWidth - actor.hitboxX), actor.y + actor.hitboxY, actor.hitboxWidth, actor.hitboxHeight)
				elseif actor.direction == "right" then
					love.graphics.rectangle("fill", actor.x + actor.hitboxX, actor.y + actor.hitboxY, actor.hitboxWidth, actor.hitboxHeight)
				end
			end
		end

		love.graphics.setColor(0.1, 1, 0.25, 0.75)
		for _, hitbox in ipairs(hitboxes) do
			x, y, w, h = unpack(hitbox)
			love.graphics.rectangle("fill", x, y, w, h)
		end

		love.graphics.setColor(1, 0, 0, 0.3)
		love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)

		love.graphics.setColor(1, 1, 1, 1)
		for i, string in ipairs(debugStrings) do
			love.graphics.setFont(textFont)
			love.graphics.print(string, 2 + 16, (i - 1) * 12 + 16)
		end
	else
		love.graphics.setColor(1, 1, 1, 1)
		local hours = math.floor(frame/60/60/60)
		local minutes = math.floor(frame/60/60 - hours*60)
		local seconds = math.floor(frame/60 - hours*60*60 - minutes*60)
		local stringHours = tostring(hours)
		local stringMinutes = tostring(minutes)
		local stringSeconds = tostring(seconds)
		if string.len(stringHours) == 1 then
			stringHours = "0"..stringHours
		end
		if string.len(stringMinutes) == 1 then
			stringMinutes = "0"..stringMinutes
		end
		if string.len(stringSeconds) == 1 then
			stringSeconds = "0"..stringSeconds
		end

		love.graphics.setFont(textFont)
		love.graphics.print("Grassland Demo", 18, 18)
		-- love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 18, 18)
		love.graphics.print(stringHours..":"..stringMinutes..":"..stringSeconds, 18, 30)
		
	end
	love.graphics.setCanvas()
	love.graphics.setColor(1, 1, 1, 1)
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
	love.graphics.draw(textCanvas, math.floor((xWindowSize - 480*scale)/2), math.floor((yWindowSize - 270*scale)/2))
	love.graphics.draw(transitionCanvas, math.floor((xWindowSize - (480*scale))/2), math.floor((yWindowSize - (270*scale))/2), 0, scale, scale)
	love.graphics.draw(screenBorderCanvas, math.floor((xWindowSize - (480*scale))/2 - 7*scale), math.floor((yWindowSize - (270*scale))/2 - 7*scale), 0, scale, scale)
	love.graphics.draw(debugCanvas, math.floor((xWindowSize - (480*scale))/2) - 16*scale, math.floor((yWindowSize - (270*scale))/2) - 16*scale, 0, scale, scale)
end