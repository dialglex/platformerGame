require("player")
require("tiles")
require("collision")

function love.load()

	xWindowSize, yWindowSize = love.window.getDesktopDimensions(1)

	love.window.setMode(xWindowSize, yWindowSize, {display = 1, centered = true}) --fullscreen = true})
	love.window.setTitle("Platformer Base")
	love.mouse.setVisible(false)
	love.mouse.setGrabbed(true)
	--love.graphics.setBackgroundColor(255, 255, 255) -- White
	--love.graphics.setBackgroundColor(16, 30, 41) -- Black
	--love.graphics.setBackgroundColor(125, 125, 125) -- Grey
	love.graphics.setBackgroundColor(146, 244, 255) -- Blue
	background = love.graphics.newImage("images/backgrounds/grassland.png")
	love.graphics.setDefaultFilter("nearest", "nearest")
	screenCanvas = love.graphics.newCanvas(xWindowSize, yWindowSize)

	hitboxes = {}

	for i = 1, 4 do
		if xWindowSize >= 480 * i and yWindowSize >= 270 * i then
			scale = i
		end
	end

	chosenMap = require("levels/RPG/grassland/introduction3")

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
							local blockQuad = nil -- investigate LATTERELORFLOSON

							local tileX = tileID % (tilesetData.imagewidth / tilesetData.tilewidth)
							local tileY = math.floor(tileID / (tilesetData.imageheight / tilesetData.tileheight))

                			local blockQuad = love.graphics.newQuad(tileX * tilesetData.tilewidth, tileY * tilesetData.tileheight, tilesetData.tilewidth, tilesetData.tileheight, tilesetData.imagewidth, tilesetData.imageheight)

							if layer.name == "player" then
                				table.insert(actors, newPlayer(mapX * 16, mapY * 16))
                			else
                				local tile = tilesetData.tiles[tileID+1]
                				table.insert(actors, newTile(tileX, tileY, tilesetData.tilewidth, tilesetData.tileheight, mapX * 16, mapY * 16, blockQuad, tileset, tile.properties["collidable"]))
                			end
						end
					end
				end
			end
		end
	end
end

function love.update()
	xWindowSize, yWindowSize = love.graphics.getDimensions()

	hitboxes = {}
	for _, actor in ipairs(actors) do
        actor:act()
    end
end

function love.draw()
	love.graphics.setCanvas(screenCanvas)
	love.graphics.clear()

	love.graphics.draw(background)

	for _, actor in ipairs(actors) do
		actor:draw()
		love.graphics.setCanvas(screenCanvas)
        love.graphics.draw(actor.canvas, math.floor(actor.x), math.floor(actor.y))
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