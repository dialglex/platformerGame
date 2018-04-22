function getImages()
	lowResolutionBackground = love.graphics.newImage("images/backgrounds/lowResolutionBackground.png")
	background = love.graphics.newImage(string.sub(chosenMap.properties["background"], 10))
	screenCanvas = love.graphics.newCanvas(xWindowSize, yWindowSize)
	backgroundCanvas = love.graphics.newCanvas(7680, 4320)
end

function drawScreen()
	love.graphics.draw(background)

	for _, actor in ipairs(actors) do
		actor:draw()
		love.graphics.setCanvas(screenCanvas)
		if actor.actor == "player" then
        	love.graphics.draw(actor.canvas, actor:getX() - 3, actor:getY() - 1)
        else
        	love.graphics.draw(actor.canvas, actor:getX(), actor:getY())
        end
    end
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

function setScreenCanvas()
	love.graphics.setCanvas(backgroundCanvas)
	love.graphics.draw(lowResolutionBackground)
	love.graphics.setCanvas()
	love.graphics.draw(backgroundCanvas, 0, 0, 0, scale, scale)

	love.graphics.setCanvas(screenCanvas)

	love.graphics.clear()
end

function drawScreenCanvas()
	love.graphics.setCanvas()
	love.graphics.draw(screenCanvas, (xWindowSize - (480 * scale)) / 2, (yWindowSize - (270 * scale)) / 2, 0, scale, scale)
end