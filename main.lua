require("player")
require("tiles")
require("collision")

function love.load()
	xWindowSize, yWindowSize = love.window.getDesktopDimensions(1)

	love.window.setMode(xWindowSize, yWindowSize, {display = 1, centered = true})
	windowAspectRatio = xWindowSize / yWindowSize
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.window.setTitle("Platformer Base")

	scale = getScale()
	loadingImage = love.graphics.newImage("images/HUD/loading.png")
	loadingCanvas = love.graphics.newCanvas(xWindowSize, yWindowSize)
	love.graphics.setCanvas(loadingCanvas)
	love.graphics.draw(loadingImage)
	love.graphics.setCanvas()
	love.graphics.draw(loadingCanvas, (xWindowSize - (480 * scale)) / 2, (yWindowSize - (270 * scale)) / 2, 0, scale, scale)
	love.graphics.present()

	love.mouse.setGrabbed(true)
	love.mouse.setVisible(false)

	gameIconImage = love.graphics.newImage("images/HUD/gameIcon.png")
	gameIconCanvas = love.graphics.newCanvas(16, 16)
	love.graphics.setCanvas(gameIconCanvas)
	love.graphics.draw(gameIconImage)
	love.graphics.setCanvas()
	gameIconImageData = gameIconCanvas:newImageData()
	love.window.setIcon(gameIconImageData)

	--love.graphics.setBackgroundColor(255, 255, 255) -- White
	--love.graphics.setBackgroundColor(16, 30, 41) -- Black
	--love.graphics.setBackgroundColor(125, 125, 125) -- Grey
	love.graphics.setBackgroundColor(146, 244, 255) -- Blue
	lowResolutionBackground = love.graphics.newImage("images/backgrounds/lowResolutionBackground.png")
	background = love.graphics.newImage("images/backgrounds/grassland.png")
	screenCanvas = love.graphics.newCanvas(xWindowSize, yWindowSize)
	backgroundCanvas = love.graphics.newCanvas(7680, 4320)

	keyPress = {}
	keyDown = {}
	hitboxes = {}
	debug = false

	resolution()
	setupLevel(require("levels/RPG/grassland/introduction3"))
end

function getScale()
	for i = 1, 9 do
		if xWindowSize >= 480 * i then
			scale = i
		end
	end
	return scale
end

function resolution()
	xWindowSize, yWindowSize = love.graphics.getDimensions()
	if windowAspectRatio == 16 / 9 then
		if keyPress["1"] then
			love.window.setMode(1024, 576, {display = 1, centered = true})
		end
		if keyPress["2"] then
			love.window.setMode(1152, 648, {display = 1, centered = true})
		end
		if keyPress["3"] then
			love.window.setMode(1280, 720, {display = 1, centered = true})
		end
		if keyPress["4"] then
			love.window.setMode(1366, 768, {display = 1, centered = true})
		end
		if keyPress["5"] then
			love.window.setMode(1600, 900, {display = 1, centered = true})
		end
		if keyPress["6"] then
			love.window.setMode(1920, 1080, {display = 1, centered = true})
		end
		if keyPress["7"] then
			love.window.setMode(2560, 1440, {display = 1, centered = true})
		end
		if keyPress["8"] then
			love.window.setMode(3840, 2160, {display = 1, centered = true})
		end
		if keyPress["9"] then
			love.window.setMode(7680, 4320, {display = 1, centered = true})
		end
	elseif windowAspectRatio == 4 / 3 then
		if keyPress["1"] then
			love.window.setMode(640, 480, {display = 1, centered = true})
		end
		if keyPress["2"] then
			love.window.setMode(800, 600, {display = 1, centered = true})
		end
		if keyPress["3"] then
			love.window.setMode(960, 720, {display = 1, centered = true})
		end
		if keyPress["4"] then
			love.window.setMode(1024, 768, {display = 1, centered = true})
		end
		if keyPress["5"] then
			love.window.setMode(1280, 960, {display = 1, centered = true})
		end
		if keyPress["6"] then
			love.window.setMode(1400, 1050, {display = 1, centered = true})
		end
		if keyPress["7"] then
			love.window.setMode(1440, 1080, {display = 1, centered = true})
		end
		if keyPress["8"] then
			love.window.setMode(1600, 1200, {display = 1, centered = true})
		end
		if keyPress["9"] then
			love.window.setMode(1856, 1392, {display = 1, centered = true})
		end
	end

	if keyPress["f11"] then
		local fullscreen = not love.window.getFullscreen()
		love.window.setFullscreen(fullscreen)
	end

	print(getScale())
end

function setupLevel(chosenMap)
	actors = {}
	for _, layer in ipairs(chosenMap.layers) do
		for _, tilesetData in ipairs(chosenMap.tilesets) do
			local tileset = love.graphics.newImage(string.sub(tilesetData.image, 10))
			if layer.name == tilesetData.name then
				for mapX = 0, layer.width - 1 do
					for mapY = 0, layer.height - 1 do
						local blockID = layer.data[1 + mapX + mapY*layer.width]
						if blockID ~= 0 then
							local tileID = blockID - tilesetData.firstgid

							local tileX = tileID % (tilesetData.imagewidth / tilesetData.tilewidth)
							local tileY = math.floor(tileID / (tilesetData.imageheight / tilesetData.tileheight))

                			local blockQuad = love.graphics.newQuad(tileX * tilesetData.tilewidth, tileY * tilesetData.tileheight, tilesetData.tilewidth, tilesetData.tileheight, tilesetData.imagewidth, tilesetData.imageheight)

							if layer.name == "player" then
                				table.insert(actors, newPlayer(mapX * 16, (mapY * 16) - 8))
                			else
                				local tile = tilesetData.tiles[tileID+1]
                				if tile.properties["collidable"] then
                					local tileHitbox = tile.objectGroup.objects[1]
                					table.insert(actors, newTile(tileX, tileY, tilesetData.tilewidth, tilesetData.tileheight, mapX * 16, mapY * 16,
                						blockQuad, tileset, tile.properties["collidable"], tileHitbox.x, tileHitbox.y, tileHitbox.width, tileHitbox.height))
                				else
                					table.insert(actors, newTile(tileX, tileY, tilesetData.tilewidth, tilesetData.tileheight, mapX * 16, mapY * 16,
                						blockQuad, tileset, tile.properties["collidable"]))
                				end
                			end
						end
					end
				end
			end
		end
	end
end

-- if something awful happens like, keypresses are changing in the middle of love.update then just cry or something.
-- never do
-- *   if keyPress["space"] == false then
-- *   if keyPress["space"] == true then
-- instead use
-- *   if keyPress["space"] then
function love.keypressed(key, _, _)
	keyPress[key] = true
	keyDown[key] = true
end

function love.keyreleased(key, _, _)
	keyPress[key] = false
	keyDown[key] = false
end

function love.update()
	resolution()
	if scale <= 1 then
		cursor = love.mouse.newCursor("images/HUD/cursor1.png")
	elseif scale <= 2 then
		cursor = love.mouse.newCursor("images/HUD/cursor2.png")
	elseif scale <= 3 then
		cursor = love.mouse.newCursor("images/HUD/cursor3.png")
	elseif scale <= 4 then
		cursor = love.mouse.newCursor("images/HUD/cursor4.png")
	end
	love.mouse.setCursor(cursor)

	if keyPress["escape"] then
		love.window.close()
	end

	if keyPress["d"] then
		debug = not debug
		keyPress = {}
	elseif not debug or (debug and keyPress["f"]) then
		gameLogic()
    	keyPress = {}
    end
end

function gameLogic()
	hitboxes = {}
	debugStrings = {"debug"}
	for _, actor in ipairs(actors) do
		actor:act()
	end
end

function debugPrint(string)
	table.insert(debugStrings, string)
end

function love.draw()
	love.graphics.setCanvas(backgroundCanvas)
	love.graphics.draw(lowResolutionBackground)
	love.graphics.setCanvas()
	love.graphics.draw(backgroundCanvas, 0, 0, 0, scale, scale)

	love.graphics.setCanvas(screenCanvas)

	love.graphics.clear()
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

	love.graphics.setCanvas()
	love.graphics.draw(screenCanvas, (xWindowSize - (480 * scale)) / 2, (yWindowSize - (270 * scale)) / 2, 0, scale, scale)
end