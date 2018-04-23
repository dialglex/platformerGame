require("player")
require("tiles")
require("collision")
require("window")
require("input")
require("setup")
require("draw")

function love.load()
	windowSetup()
	drawLoadingScreen()

	keyPress = {}
	keyDown = {}
	hitboxes = {}
	debug = false
	debugStrings = {"debug"}

	setupLevel("levels/RPG/grassland/end1")
	getImages()
end

function love.update()
	windowCheck()
	resolution()
	--cursorType()

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
	for _, actor in ipairs(actors) do
		actor:act()
	end
end

function love.draw()
	setScreenCanvas()
	drawScreen()
	drawDebug()
	drawFPS()
	drawScreenCanvas()
end