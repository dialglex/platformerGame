require("player")
require("tiles")
require("collision")
require("window")
require("input")
require("setup")
require("draw")
require("dust")
require("require")

function love.load()
	windowSetup()
	drawLoadingScreen()

	keyPress = {}
	keyDown = {}
	hitboxes = {}
	debug = false
	debugStrings = {"debug"}

	luaLevels = require.tree('levels/RPG')
	--setupLevel(luaLevels.grassland.introduction1)
	setupLevel("levels/RPG/grassland/introduction1")
	getImages()
	cursorType()
end

function love.update()
	windowCheck()
	resolution()

	if not debug then
		frameStep = false
	elseif keyPress["f"] then
		frameStep = true
	end

	if keyPress["d"] then
		debug = not debug
		keyPress = {}
	elseif not (debug and frameStep and not keyPress["f"]) then
		gameLogic()
    	keyPress = {}
    end
end

function debugPrint(string)
	table.insert(debugStrings, string)
end

function gameLogic()
	hitboxes = {}
	debugStrings = {"debug"}
	for index, actor in ipairs(actors) do
		actor:act(index)
	end
end

function love.draw()
	setScreenCanvas()
	drawScreen()
	drawDebug()
	drawFPS()
	drawScreenCanvas()
end