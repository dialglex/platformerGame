function getImages()
	lowResolutionBackground = love.graphics.newImage("images/backgrounds/lowResolutionBackground.png")
	screenCanvas = love.graphics.newCanvas(480, 270)
	textCanvas = love.graphics.newCanvas(1920, 1080)
	hdCanvas = love.graphics.newCanvas(1920, 1080)
	lowResolutionBackgroundCanvas = love.graphics.newCanvas(7680, 4320)
	transitionCanvas = love.graphics.newCanvas(480, 270)
	getFonts()
	--white = 0.973, 0.973, 0.973 (248, 248, 248)
	--black = 0.063, 0.118, 0.161 (16, 30, 41)
end

function getFonts()
	textFont1 = love.graphics.newImageFont("fonts/4x4TextFont1.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!/-+/():;%&`'{}|~$@^_<>") --bugs out with \
	titleFont0 = love.graphics.newImageFont("fonts/9x15TitleFont0.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!/-+/():;%&`'{}|~$@^_<>") --bugs out with \
	titleFont2 = love.graphics.newImageFont("fonts/9x15TitleFont2.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!/-+/():;%&`'{}|~$@^_<>") --bugs out with \
	boldFont0 = love.graphics.newImageFont("fonts/6x10BoldFont0.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!/-+/():;%&`'{}|~$@^_<>") --bugs out with \
	boldFont1 = love.graphics.newImageFont("fonts/6x10BoldFont1.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!/-+/():;%&`'{}|~$@^_<>") --bugs out with \
	boldFont2 = love.graphics.newImageFont("fonts/6x10BoldFont2.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!/-+/():;%&`'{}|~$@^_<>") --bugs out with \
	boldFont2Green = love.graphics.newImageFont("fonts/6x10BoldFont2Green.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!/-+/():;%&`'{}|~$@^_<>") --bugs out with \
	boldFont2Red = love.graphics.newImageFont("fonts/6x10BoldFont2Red.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!/-+/():;%&`'{}|~$@^_<>") --bugs out with \
	
	textFont = textFont1
	signFont = love.graphics.newFont("fonts/ubuntu/Ubuntu-Medium.ttf", 11*scale)
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
		transitionCounter = transitionCounter + 0.1
	else
		transitionFrozen = false
		transitionCounter = transitionCounter - 0.1
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

    -- print(string)

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
	    if onActor and actor.hp > 0 then
		    --black border
		    love.graphics.setColor(0, 0, 0, progressionBarOpacity)
		    love.graphics.rectangle("fill", actor.x + actor.width/2 - progressionBarWidth/2 - 1, actor.y - progressionBarOffset - 1,
		        progressionBarWidth + 2, progressionBarHeight + 2)
		    --color inside
		    love.graphics.setColor(1-actor.hp/actor.maxHp, actor.hp/actor.maxHp - 0.1, 0, progressionBarOpacity)
		    love.graphics.rectangle("fill", actor.x + actor.width/2 - progressionBarWidth/2, actor.y - progressionBarOffset,
		        actor.hp/actor.maxHp*progressionBarWidth, progressionBarHeight)
		    --color highlight
		    -- love.graphics.setColor(1, 1, 0.5+(actor.hp/actor.maxHp)*0.35, progressionBarOpacity*(actor.hp/actor.maxHp))
		    -- love.graphics.rectangle("fill", actor.x + actor.width/2 - progressionBarWidth/2, actor.y - progressionBarOffset + 1,
		  		-- progressionBarWidth, progressionBarHeight*(1/3))
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
			
			--text
			-- love.graphics.setColor(1, 1, 1)
			-- love.graphics.setFont(progressionBarFont)
			-- local progressionBarText = (tostring(actor.hp).."/"..tostring(actor.maxHp))
			-- local wrapWidth, wrapText = signFont:getWrap(progressionBarText, 300*scale)
			-- local textHeight = progressionBarFont:getHeight()
			-- love.graphics.print(progressionBarText, progressionBarX + progressionBarWidth/2 - wrapWidth/2, progressionBarY + (progressionBarHeight-textHeight)/2 + 1)
		end
	elseif bar == "level" then
		if onActor and actor.hp > 0 then
		    --black border
		    love.graphics.setColor(0, 0, 0, progressionBarOpacity)
		    love.graphics.rectangle("fill", actor.x + actor.width/2 - progressionBarWidth/2 - 1, actor.y - progressionBarOffset - 1,
		        progressionBarWidth + 2, progressionBarHeight + 2)
		    --color inside
		    love.graphics.setColor(0, 1, 1, progressionBarOpacity)
		    love.graphics.rectangle("fill", actor.x + actor.width/2 - progressionBarWidth/2, actor.y - progressionBarOffset,
		        actor.xp/actor.nextLevelXp *progressionBarWidth, progressionBarHeight)
		end
	end
    love.graphics.setColor(1, 1, 1, 1)
end

function drawScreen()
    textToDraw = {}
	love.graphics.draw(backgroundImage)
	love.graphics.draw(backgroundCanvas)

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

	love.graphics.setCanvas(hdCanvas)
	love.graphics.clear()
	love.graphics.setCanvas()
	for _, actor in ipairs(objects) do
    	if actor.nearCounter > 0.1 and actor.active then
    		love.graphics.setColor(0.973, 0.973, 0.973, actor.nearCounter)
			love.graphics.setLineStyle("rough")
			love.graphics.setLineWidth(2)
			love.graphics.setCanvas(screenCanvas)
			love.graphics.rectangle("line", actor.x, actor.y, actor.width, actor.height, 3)
			love.graphics.setFont(signFont)
			if actor.type == "sign" then
				wrapWidth, wrapText = signFont:getWrap(actor.data, 300*scale)
				textHeight = signFont:getHeight()
				textLines = #wrapText
				--get height of text
				textX = actor.x*scale - (wrapWidth) + (actor.width/2)*scale + wrapWidth / 2
				textY = actor.y*scale - textHeight*textLines - 6
		 		if textX < 0 then
					textX = 5*scale
				end
				love.graphics.setColor(0.063, 0.118, 0.161, actor.nearCounter / 2)
				love.graphics.setCanvas(hdCanvas)
				love.graphics.rectangle("fill", textX - 3*scale, textY - 1*scale, wrapWidth + 6*scale, textLines*textHeight + 3*scale, 4*scale)
				table.insert(textToDraw, {actor.data, signFont, textX, textY, wrapWidth, "center", {0.973, 0.973, 0.973, actor.nearCounter}})
			end
		end
	end
	love.graphics.setCanvas(screenCanvas)
	love.graphics.setColor(1, 1, 1, 1)

 	for _, actor in ipairs(tiles) do
		if actor.name == "teleporter" then
			if actor.active or bossLevel then
				love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
			end
		end
	end

 	for _, actor in ipairs(weapons) do
 		love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
 	end

 	if player.onLadder then
	 	love.graphics.draw(player.canvas, player:getX() - 3, player:getY() - 2)
 	end
 	if player.weaponOut == false then
 		if player.lastUsedWeapon ~= nil then
 			if player.direction == "left" then
				love.graphics.draw(player.lastUsedWeapon.sheathSprite, player.sheathX, player.sheathY)
			else
				love.graphics.draw(player.lastUsedWeapon.sheathSprite, player.sheathX, player.sheathY, 0, -1, 1, player.lastUsedWeapon.sheathSprite:getWidth())
			end
		end
 	end


 	if player.onLadder == false then
	 	love.graphics.draw(player.canvas, player:getX() - 3, player:getY() - 2)
 	end

 	for _, actor in ipairs(items) do
 		love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
 	end

 	for _, actor in ipairs(dusts) do
 		love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
 	end

    for _, actor in ipairs(npcs) do
    	love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
    	drawProgressBar("health", actor, 15+2*actor.maxHp, 5, 5, actor.healthBarOpacity, true)
    end

    love.graphics.draw(foregroundCanvas)


    drawProgressBar("health", player, 15 + 1*player.hp, 5, -player.height-1, 1, true)
    drawProgressBar("level", player, 15 + 1*player.level, 3, -player.height-1-6, 1, true)
	--drawProgressBar(player, 80 + 10*player.maxHp, 17, nil, 1, false, 480/2 - (80 + 10*player.maxHp)/2, 270-30)
 	
 	for _, actor in ipairs(uis) do
 		love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
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
	
    purple = 0
    if blockTopLeft then
		purple = purple + 1
	end
	if blockTopMiddle then
		purple = purple + 1
	end
	if blockTopRight then
		purple = purple + 1
	end
	if blockLeftTop then
		purple = purple + 1
	end
	if blockLeftMiddle then
		purple = purple + 1
	end
	if blockLeftBottom then
		purple = purple + 1
	end

	love.graphics.setColor(0.39, 0.27, 0.55, purple/35) -- 100, 70, 141 (purple)
	love.graphics.rectangle("fill", 0, 0, 480, 270)
	love.graphics.setColor(1, 1, 1)
    drawTextCanvas()


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

    --draw player hitboxes
    if downInputs.hitboxes then
        for _, hitbox in ipairs(hitboxes) do
            x, y, w, h = unpack(hitbox)
            love.graphics.setColor(1, 0, 0, 0.6)
            love.graphics.rectangle("fill", x, y, w, h)
        end

        love.graphics.setColor(0, 1, 0, 0.6)
        love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    end
    love.graphics.setColor(1, 1, 1, 1)

	if debug then
	    love.graphics.setColor(1, 1, 1)
    	for i, string in ipairs(debugStrings) do
    		love.graphics.setFont(textFont)
    		love.graphics.print(string, 2, (i - 1) * 12)
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

function setScreenCanvas()
	love.graphics.setCanvas(lowResolutionBackgroundCanvas)
	love.graphics.draw(lowResolutionBackground)
	love.graphics.setCanvas()
	love.graphics.draw(lowResolutionBackgroundCanvas, 0, 0, 0, scale, scale)

	love.graphics.setCanvas(screenCanvas)

	love.graphics.clear()
end

function drawScreenCanvas()
	love.graphics.setCanvas()
	love.graphics.draw(screenCanvas, math.floor((xWindowSize - (480 * scale)) / 2), math.floor((yWindowSize - (270 * scale)) / 2), 0, scale, scale)
    love.graphics.draw(hdCanvas, math.floor((xWindowSize - 480 * scale) / 2), math.floor((yWindowSize - 270 * scale) / 2))
    love.graphics.draw(textCanvas, math.floor((xWindowSize - 480 * scale) / 2), math.floor((yWindowSize - 270 * scale) / 2))
    love.graphics.draw(transitionCanvas, math.floor((xWindowSize - (480 * scale)) / 2), math.floor((yWindowSize - (270 * scale)) / 2), 0, scale, scale)
end