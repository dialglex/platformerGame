require("player")
require("tiles")
require("collision")
require("window")
require("input")
require("setup")
require("draw")

function love.load()
	windowSetup()
	loading()
	chosenMap = require("levels/RPG/grassland/introduction3")
	getImages()

	keyPress = {}
	keyDown = {}

	hitboxes = {}
	debug = false
	debugStrings = {"debug"}

	setupLevel(chosenMap)
end

function love.update()
	windowCheck()
	resolution()
	cursorType()

	if keyPress["d"] then
		debug = not debug
		keyPress = {}
	elseif not debug or (debug and keyPress["f"]) then
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
	drawScreenCanvas()
end