function love.keypressed(key, _, _)
	keyPress[key] = true
	keyDown[key] = true
	lastInputType = "keyboard"
end

function love.keyreleased(key, _, _)
	keyPress[key] = false
	keyDown[key] = false
	lastInputType = "keyboard"
end


function love.joystickpressed(gamepad, button)
	buttonPress[getCorrospondingButton(button)] = true
	buttonDown[getCorrospondingButton(button)] = true
	lastInputType = "gamepad"
end

function love.joystickreleased(gamepad, button)
	buttonPress[getCorrospondingButton(button)] = false
	buttonDown[getCorrospondingButton(button)] = false
	lastInputType = "gamepad"
end

function getCorrospondingButton(button)
	if button == 1 then
		return "a"
	elseif button == 2 then
		return "b"
	elseif button == 3 then
		return "x"
	elseif button == 4 then
		return "y"
	elseif button == 5 then
		return "leftShoulder"
	elseif button == 6 then
		return "rightShoulder"
	elseif button == 7 then
		return "select"
	elseif button == 8 then
		return "start"
	elseif button == 9 then
		return "rightStick"
	elseif button == 10 then
		return "leftStick"
	end
end

function findGamepads()
	gamepads = love.joystick.getJoysticks()
	gamepadAmount = 0
	controllerDeadzone = 0.25
	for i, gamepad in ipairs(gamepads) do
		love.joystick.setGamepadMapping(gamepad:getGUID(), "triggerleft", "button", 5)
		love.joystick.setGamepadMapping(gamepad:getGUID(), "triggerright", "button", 6)
		love.joystick.setGamepadMapping(gamepad:getGUID(), "leftshoulder", "button", 8)
		love.joystick.setGamepadMapping(gamepad:getGUID(), "rightshoulder", "button", 3)
		love.joystick.setGamepadMapping(gamepad:getGUID(), "rightx", "axis", 6)
		love.joystick.setGamepadMapping(gamepad:getGUID(), "righty", "axis", 3)
		love.joystick.setGamepadMapping(gamepad:getGUID(), "leftx", "axis", 1)
		love.joystick.setGamepadMapping(gamepad:getGUID(), "lefty", "axis", 2)
		gamepadAmount = gamepadAmount + 1
	end
end

function getPressInputs()
	local inputs = {}

	if gamepadAmount == 0 then
		inputs.jump = keyPress["space"]
		inputs.left = keyPress["left"]
		inputs.right = keyPress["right"]
		inputs.up = keyPress["up"]
		inputs.down = keyPress["down"]
		inputs.attack1 = keyPress["z"]
		inputs.attack2 = keyPress["x"]
		inputs.interact = keyPress["e"]
		inputs.ability = keyPress["q"]
		inputs.debug = keyPress["d"]
		inputs.frame = keyPress["f"]
		inputs.hitboxes = keyPress["tab"]
		inputs.close = keyPress["escape"]
		inputs.restart = keyPress["r"]
		inputs.pause = keyPress["p"]
		inputs.mute = keyPress["m"]
	else
		for i, gamepad in ipairs(gamepads) do
			inputs.jump = keyPress["space"] or buttonPress["a"]
			inputs.left = keyPress["left"] or gamepad:getGamepadAxis("leftx") < -controllerDeadzone
			inputs.right = keyPress["right"] or gamepad:getGamepadAxis("leftx") > controllerDeadzone
			inputs.up = keyPress["up"] or gamepad:getGamepadAxis("lefty") < -controllerDeadzone
			inputs.down = keyPress["down"] or gamepad:getGamepadAxis("lefty") > controllerDeadzone
			inputs.attack1 = keyPress["z"] or buttonPress["b"]
			inputs.attack2 = keyPress["x"] or buttonPress["x"]
			inputs.interact = keyPress["e"] or buttonPress["y"]
			inputs.ability = keyPress["q"] or buttonPress["leftStick"]
			inputs.debug = keyPress["d"] or buttonPress["select"]
			inputs.frame = keyPress["f"] or buttonPress["rightShoulder"]
			inputs.hitboxes = keyPress["tab"]
			inputs.close = keyPress["escape"] or buttonPress["start"]
			inputs.restart = keyPress["r"]
			inputs.pause = keyPress["p"]
			inputs.mute = keyPress["m"]
		end
	end

	if inputs.left and inputs.right then
		inputs.left = false
		inputs.right = false
	end

	if inputs.up and inputs.down then
		inputs.up = false
		inputs.down = false
	end
	
	return inputs
end

function getDownInputs()
	local inputs = {}

	if gamepadAmount == 0 then
		inputs.jump = keyDown["space"]
		inputs.left = keyDown["left"]
		inputs.right = keyDown["right"]
		inputs.up = keyDown["up"]
		inputs.down = keyDown["down"]
		inputs.attack1 = keyDown["z"]
		inputs.attack2 = keyDown["x"]
		inputs.interact = keyDown["e"]
		inputs.ability = keyDown["q"]
		inputs.debug = keyDown["d"]
		inputs.frame = keyDown["f"]
		inputs.hitboxes = keyDown["tab"]
		inputs.close = keyDown["escape"]
		inputs.restart = keyDown["r"]
		inputs.mute = keyPress["m"]
	else
		for i, gamepad in ipairs(gamepads) do
			inputs.jump = keyDown["space"] or buttonDown["a"]
			inputs.left = keyDown["left"] or gamepad:getGamepadAxis("leftx") < -0.6
			inputs.right = keyDown["right"] or gamepad:getGamepadAxis("leftx") > 0.6
			inputs.up = keyDown["up"] or gamepad:getGamepadAxis("lefty") < -0.6
			inputs.down = keyDown["down"] or gamepad:getGamepadAxis("lefty") > 0.6
			inputs.attack1 = keyDown["z"] or buttonDown["b"]
			inputs.attack2 = keyDown["x"] or buttonDown["x"]
			inputs.interact = keyDown["e"] or buttonDown["y"]
			inputs.ability = keyDown["q"] or buttonDown["leftStick"]
			inputs.debug = keyDown["d"] or buttonDown["select"]
			inputs.frame = keyDown["f"] or buttonDown["rightShoulder"]
			inputs.hitboxes = keyDown["tab"] or buttonDown["x"]
			inputs.close = keyDown["escape"] or buttonDown["start"]
			inputs.restart = keyDown["r"]
			inputs.mute = keyPress["m"]
		end
	end
	
	if inputs.left and inputs.right then
		inputs.left = false
		inputs.right = false
	end

	if inputs.up and inputs.down then
		inputs.up = false
		inputs.down = false
	end

	return inputs
end

function cursorType()
	if scale <= 1 then
		cursor = love.mouse.newCursor("images/ui/cursor1.png")
	elseif scale <= 2 then
		cursor = love.mouse.newCursor("images/ui/cursor2.png")
	elseif scale <= 3 then
		cursor = love.mouse.newCursor("images/ui/cursor3.png")
	elseif scale <= 4 then
		cursor = love.mouse.newCursor("images/ui/cursor4.png")
	end
	love.mouse.setCursor(cursor)
end