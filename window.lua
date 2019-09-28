function windowSetup()
	xWindowSize, yWindowSize = love.window.getDesktopDimensions(1)
	love.window.setMode(xWindowSize, yWindowSize, {fullscreen = fullscreenOn, vsync = vSyncOn, centered = true})
	windowAspectRatio = xWindowSize / yWindowSize
	scale = getScale()

	love.graphics.setDefaultFilter("nearest", "nearest")

	love.window.setTitle("Platformer Game")

	gameIconImage = love.graphics.newImage("images/ui/gameIcon.png")
	gameIconCanvas = love.graphics.newCanvas(16, 16)
	love.graphics.setCanvas(gameIconCanvas)
	love.graphics.draw(gameIconImage)
	love.graphics.setCanvas()
	gameIconImageData = gameIconCanvas:newImageData()
	love.window.setIcon(gameIconImageData)

	love.mouse.setGrabbed(false)
	love.mouse.setVisible(false)
end

function getScale()
	for i = 1, 9 do
		if xWindowSize >= 480 * i then
			scale = i
		end
	end
	return scale
end

function resizeWindow(x, y)
	love.window.setMode(xWindowSize, yWindowSize, {fullscreen = fullscreenOn, vsync = vSyncOn, centered = true})
	xWindowSize, yWindowSize = x, y
	canvasLayers = setupCanvases(actors)
	backgroundCanvas = canvasLayers[1]
	foregroundCanvas = canvasLayers[2]
	
	scale = getScale()
	getFonts()
	cursorType()
end

function resolution()
	roundedWindowAspectRatio = math.floor(windowAspectRatio*10)
	if roundedWindowAspectRatio == 17 then -- 16/9
		if keyPress["1"] then
			resizeWindow(1024, 576)
		end
		if keyPress["2"] then
			resizeWindow(1152, 648)
		end
		if keyPress["3"] then
			resizeWindow(1280, 720)
		end
		if keyPress["4"] then
			resizeWindow(1366, 768)
		end
		if keyPress["5"] then
			resizeWindow(1600, 900)
		end
		if keyPress["6"] then
			resizeWindow(1920, 1080)
		end
		if keyPress["7"] then
			resizeWindow(2560, 1440)
		end
		if keyPress["8"] then
			resizeWindow(3840, 2160)
		end
		if keyPress["9"] then
			resizeWindow(7680, 4320)
		end
	elseif roundedWindowAspectRatio == 13 then -- 4/3
		if keyPress["1"] then
			resizeWindow(640, 480)
		end
		if keyPress["2"] then
			resizeWindow(800, 600)
		end
		if keyPress["3"] then
			resizeWindow(960, 720)
		end
		if keyPress["4"] then
			resizeWindow(1024, 768)
		end
		if keyPress["5"] then
			resizeWindow(1280, 960)
		end
		if keyPress["6"] then
			resizeWindow(1400, 1050)
		end
		if keyPress["7"] then
			resizeWindow(1440, 1080)
		end
		if keyPress["8"] then
			resizeWindow(1600, 1200)
		end
		if keyPress["9"] then
			resizeWindow(1856, 1392)
		end
	end

	if keyPress["f11"] then
		local fullscreen = not love.window.getFullscreen()
		love.window.setFullscreen(fullscreen)
	end

	if xWindowSize ~= love.graphics.getWidth() or yWindowSize ~= love.graphics.getHeight() then
		xWindowSize, yWindowSize = love.graphics.getDimensions()
		scale = getScale()
		getImages()
	end
end

function windowCheck()
	-- if pressInputs.close then
	-- 	love.event.quit()
	-- end
end