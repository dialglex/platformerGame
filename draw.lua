function getImages()
	lowResolutionBackground = love.graphics.newImage("images/backgrounds/lowResolutionBackground.png")
	textfont = love.graphics.newImageFont("images/fonts/textFont.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!/-+/():;%&`'{}|~$@^_<>") --bugs out with \
	screenCanvas = love.graphics.newCanvas(480, 272)
	lowResolutionBackgroundCanvas = love.graphics.newCanvas(7680, 4320)
end

function drawScreen()
	love.graphics.draw(backgroundImage)

	love.graphics.draw(backgroundCanvas)
	for _, actor in ipairs(actors) do
		actor:draw()
		love.graphics.setCanvas(screenCanvas)
		if actor.actor == "player" then
        	love.graphics.draw(actor.canvas, actor:getX() - 3, actor:getY() - 1)
        end
    end
    love.graphics.draw(foregroundCanvas)
end

function drawDebug()
	if debug then
    	for i, string in ipairs(debugStrings) do
    		love.graphics.print(string, 2, (i - 1) * 12)
    	end
    end

    --draw hitboxes
    if love.keyboard.isDown("z") then
        for _, hitbox in ipairs(hitboxes) do
            x, y, w, h = unpack(hitbox)
            love.graphics.setColor(255, 0, 0, 160)
            love.graphics.rectangle("fill", x, y, w, h)
        end
        love.graphics.setColor(255, 255, 255)
    end
end

function drawFPS()
	if not debug then
		love.graphics.setFont(textfont)
		love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 4, 4)
	end
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
	love.graphics.draw(screenCanvas, (xWindowSize - (480 * scale)) / 2, (yWindowSize - (270 * scale)) / 2, 0, scale, scale)
end