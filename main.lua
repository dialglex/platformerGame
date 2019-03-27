saveData = require("saveData")
function love.load()
	math.randomseed(os.time())	     

	local luaFiles = love.filesystem.getDirectoryItems("")
	for _, file in ipairs(luaFiles) do
		if string.sub(file, -3) == "lua" then 
			require(string.gsub(file, ".lua", "", 1))
		end
	end

	loadSaveData()
	windowSetup()
	drawLoadingScreen()
	debug = false
	frameStep = false
	debugStrings = {"debug"}
	transitionFrozen = false
	uiFrozen = false
	muted = true
	fadeIn = true
	chestOpening = false
	transitionCounter = 0
	win = false
	local randomNumber = math.random(2)
	if randomNumber == 1 then
		shopItemType = "weapon"
	else
		-- shopItemType = "accessory"
		shopItemType = "weapon"
	end

	local mainDirectory = "maps/maps"
	local folderEntities = love.filesystem.getDirectoryItems(mainDirectory)
	allMaps = {}
	allGrasslandOverworldMaps = {}
	allGrasslandCaveMaps = {}
	allGrasslandShopMaps = {}

	allDesertOverworldMaps = {}
	allDesertCaveMaps = {}
	allDesertShopMaps = {}

	for _, folder in ipairs(folderEntities) do
		folderDirectory = (mainDirectory.."/"..folder)
		mapEntities = love.filesystem.getDirectoryItems(folderDirectory)
		for _, map in ipairs(mapEntities) do
			mapDirectory = (folderDirectory.."/"..map)
			if string.sub(mapDirectory, -3) == "lua" then
				requireMap = require(string.gsub(mapDirectory, ".lua", "", 1))
				allMaps[string.gsub(mapDirectory, ".lua", "", 1)] = loadMap(requireMap, nil, mapDirectory)
				if string.match(string.gsub(mapDirectory, ".lua", "", 1), "maps/maps/grassland") then
					if string.find(mapDirectory, "containsCave") then
						table.insert(allGrasslandCaveMaps, (string.gsub(mapDirectory, ".lua", "", 1)))
					elseif string.find(mapDirectory, "containsShop") then
						table.insert(allGrasslandShopMaps, (string.gsub(mapDirectory, ".lua", "", 1)))
					else
						table.insert(allGrasslandOverworldMaps, (string.gsub(mapDirectory, ".lua", "", 1)))
					end
				elseif string.match(string.gsub(mapDirectory, ".lua", "", 1), "maps/maps/desert") then
					if string.find(mapDirectory, "containsCave") then
						table.insert(allDesertCaveMaps, (string.gsub(mapDirectory, ".lua", "", 1)))
					elseif string.find(mapDirectory, "containsShop") then
						table.insert(allDesertShopMaps, (string.gsub(mapDirectory, ".lua", "", 1)))
					else
						table.insert(allDesertOverworldMaps, (string.gsub(mapDirectory, ".lua", "", 1)))
					end
				end
			end
		end
	end
	randomMaps = true

	levelName = "grassland"
	currentMap = allMaps["maps/maps/grassland/1"]

	actors = currentMap.actors
	table.insert(actors, newUi("menu"))

	backgroundImage = currentMap.backgroundImage
	backgroundCanvas = currentMap.backgroundCanvas
	foregroundCanvas = currentMap.foregroundCanvas
	currentMapDirectory = currentMap.currentMapDirectory

	topLeft = currentMap.topLeft
	topMiddle = currentMap.topMiddle
	topRight = currentMap.topRight
	bottomLeft = currentMap.bottomLeft
	bottomMiddle = currentMap.bottomMiddle
	bottomRight = currentMap.bottomRight
	leftTop = currentMap.leftTop
	leftMiddle = currentMap.leftMiddle
	leftBottom = currentMap.leftBottom
	rightTop = currentMap.rightTop
	rightMiddle = currentMap.rightMiddle
	rightBottom = currentMap.rightBottom

	blockTopLeft = false
	blockTopMiddle = false
	blockTopRight = false
	blockBottomLeft = false
	blockBottomMiddle = false
	blockBottomRight = false
	blockLeftTop = false
	blockLeftMiddle = false
	blockLeftBottom = false
	blockRightTop = false
	blockRightMiddle = false
	blockRightBottom = false

	-- blockTopLeft = true
	-- blockTopMiddle = true
	-- blockTopRight = true
	-- blockBottomLeft = true
	-- blockBottomMiddle = true
	-- blockBottomRight = true
	-- blockLeftTop = true
	-- blockLeftMiddle = true
	-- blockLeftBottom = true
	-- blockRightTop = true
	-- blockRightMiddle = true
	-- blockRightBottom = true

	bossLevel = false
	mapNumber = 0
	spawnRate = 0
	mapsUsed = {}

	getActors(actors)

	findGamepads()
	frame = 0
	keyPress = {}
	keyDown = {}
	buttonPress = {}
	buttonDown = {}
	lastInputType = "keyboard"
	hitboxes = {}
	debugStrings = {"debug"}
	monsterDifficulty = 20
	currentMonsterDifficulty = 0
	shakeLength = 0
	shakeAmount = 0
	shakeX = 0
	shakeY = 0
	shakeType = ""
	purple = 0
	newPurple = 0

	getImages()
	getAudio()
	cursorType()
end

function love.update(dt)
	pressInputs = getPressInputs()
	downInputs = getDownInputs()
	windowCheck()
	resolution()

	if not debug then
		frameStep = false
	elseif pressInputs.frame then
		frameStep = true
	end

	if pressInputs.debug then
		debug = not debug
		keyPress = {}
		buttonPress = {}
	elseif not (debug and frameStep and not pressInputs.frame) and transitionFrozen == false and uiFrozen == false then
		gameLogic()
		keyPress = {}
		buttonPress = {}
	else
		getActors(actors)
		hitboxes = {}
		for index, actor in ipairs(actors) do
			if actor.actor == "ui" then
				actor:act(index)
			end
		end
		frame = frame + 1
		keyPress = {}
		buttonPress = {}
	end
	
	updateVolume()
	mute()
	if pressInputs.restart then
		mainMusic:stop()
		menuMusic:stop()
		bossMusic:stop()
		actors = {}
		love.load()
	end
end

function debugPrint(string)
	table.insert(debugStrings, string)
end

function gameLogic()
	getActors(actors)
	hitboxes = {}
	debugStrings = {"debug"}
	for index, actor in ipairs(actors) do
		actor:act(index)
	end
	debugPrint("Frame: " .. tostring(frame))
	debugPrint("Scale: " .. tostring(scale))
	frame = frame + 1
end

function getActors(actors)
	tiles = {}
	npcs = {}
	objects = {}
	dusts = {}
	weapons = {}
	items = {}
	uis = {}
	for _, actor in ipairs(actors) do
		if actor.actor == "tile" then
			table.insert(tiles, actor)
			if actor.name == "teleporter" or actor.name == "chest" then
				actor:draw()
				love.graphics.setCanvas()
			end
		elseif actor.actor == "npc" then
			table.insert(npcs, actor)
		elseif actor.actor == "object" then
			table.insert(objects, actor)
		elseif actor.actor == "dust" then
			table.insert(dusts, actor)
		elseif actor.actor == "weapon" then
			table.insert(weapons, actor)
		elseif actor.actor == "item" then
			table.insert(items, actor)
		elseif actor.actor == "ui" then
			table.insert(uis, actor)
		end
	end
end

function love.draw()
	setScreenCanvas()
	drawScreen()
	drawDebug()
	drawFPS()
	drawScreenCanvas()
end

function loadSaveData()
	fullscreenOn = false
	vSyncOn = true
	shake = 1
	musicVolume = 0.5
	sfxVolume = 0.5

	local settings = saveData.load("settings")
	if settings ~= nil then
		if settings.fullscreen == 1 then
			fullscreenOn = true
		else
			fullscreenOn = false
		end
		if settings.vSync == 1 then
			vSyncOn = true
		else
			vSyncOn = false
		end
		shake = settings.shake
		musicVolume = settings.musicVolume
		sfxVolume = settings.sfxVolume
	end
end

function isInTable(element, table)
	for i, e in ipairs(table) do
		if e == element then
			return true
		end
	end
	return false
end

function getTableLength(table)
	length = 0
	for i, e in ipairs(table) do
		length = length + 1
	end
	return length
end

function getRandomElement(table)
	return table[math.random(#table)]
end

function deepTableClone(original)
	local originalType = type(orig)
	local copy
	if originalType == "table" then
		copy = {}
		for originalKey, originalValue in next, original, nil do
			copy[deepTableClone(originalKey)] = deepTableClone(originalValue)
		end
		setmetatable(copy, deepTableClone(getmetatable(original)))
	else -- number, string, boolean, etc
		copy = original
	end
	return copy
end

function camelToTitle(string)
	capitalAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	local list = {}
	for letter in string:gmatch"." do
		if string.find(capitalAlphabet, letter) then
			table.insert(list, " ")
		end
		table.insert(list, letter)
	end

	local string = ""
	for i, e in ipairs(list) do
		if i == 1 then
			string = string..e:upper()
		else
			string = string..e
		end
	end

	return string
end