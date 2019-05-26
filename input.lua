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

function stickPressed(gamepad, direction, stickX, stickY, oldStickX, oldStickY)
	if direction == "left" and stickX < -controllerDeadzone/2 and oldStickX >= -controllerDeadzone/2 then
		return true
	elseif direction == "right" and stickX > controllerDeadzone/2 and oldStickX <= controllerDeadzone/2 then
		return true
	elseif direction == "up" and stickY < -controllerDeadzone/2 and oldStickY >= -controllerDeadzone/2 then
		return true
	elseif direction == "down" and stickY > controllerDeadzone/2 and oldStickY <= controllerDeadzone/2 then
		return true
	end
	return false
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
	controllerDeadzone = 0.35
	gamepadAmount = 0
	gamepads = love.joystick.getJoysticks()
	xboxControllers = {}
	proControllers = {}
	for i, e in ipairs(gamepads) do
		love.joystick.setGamepadMapping(e:getGUID(), "triggerleft", "button", 5)
		love.joystick.setGamepadMapping(e:getGUID(), "triggerright", "button", 6)
		love.joystick.setGamepadMapping(e:getGUID(), "leftshoulder", "button", 8)
		love.joystick.setGamepadMapping(e:getGUID(), "rightshoulder", "button", 3)
		love.joystick.setGamepadMapping(e:getGUID(), "rightx", "axis", 6)
		love.joystick.setGamepadMapping(e:getGUID(), "righty", "axis", 3)
		love.joystick.setGamepadMapping(e:getGUID(), "leftx", "axis", 1)
		love.joystick.setGamepadMapping(e:getGUID(), "lefty", "axis", 2)
		gamepadAmount = gamepadAmount + 1
		local name = e:getName()
		if name == "Pro Controller" then
			table.insert(proControllers, e)
		elseif name == "XInput Controller #1" then
			table.insert(xboxControllers, e)
		end
	end
	gamepad = xboxControllers[1]
end

function getPressInputs()
	local inputs = {}

	if #xboxControllers == 0 then
		inputs.confirm = keyPress["space"] or keyPress["return"]
		inputs.back = keyPress["escape"]

		inputs.jump = keyPress["space"]
		inputs.left = keyPress["left"]
		inputs.right = keyPress["right"]
		inputs.up = keyPress["up"]
		inputs.down = keyPress["down"]
		inputs.attack1 = keyPress["z"]
		inputs.attack2 = keyPress["x"]
		inputs.interact = keyPress["e"]
		inputs.inventory = keyPress["tab"]
		inputs.options = keyPress["escape"]

		inputs.restart = keyPress["r"]
		inputs.pause = keyPress["p"]
		
		inputs.ability = keyPress["q"]
		inputs.debug = keyPress["d"]
		inputs.frame = keyPress["f"]
		inputs.hitboxes = keyPress[""]
	else
		for i, e in ipairs(xboxControllers) do
			stickX = gamepad:getGamepadAxis("leftx")
			stickY = gamepad:getGamepadAxis("lefty")

			inputs.confirm = keyPress["space"] or keyPress["z"] or buttonPress["b"] or buttonPress["a"]
			inputs.back = keyPress["escape"] or keyPress["x"] or buttonPress["start"] or buttonPress["x"]

			inputs.jump = keyPress["space"] or buttonPress["b"]
			inputs.left = keyPress["left"] or stickPressed(e, "left", stickX, stickY, oldStickX, oldStickY)
			inputs.right = keyPress["right"] or stickPressed(e, "right", stickX, stickY, oldStickX, oldStickY)
			inputs.up = keyPress["up"] or stickPressed(e, "up", stickX, stickY, oldStickX, oldStickY)
			inputs.down = keyPress["down"] or stickPressed(e, "down", stickX, stickY, oldStickX, oldStickY)
			inputs.attack1 = keyPress["z"] or buttonPress["a"]
			inputs.attack2 = keyPress["x"] or buttonPress["x"]
			inputs.interact = keyPress["e"] or buttonPress["y"]
			inputs.inventory = keyPress["tab"] or buttonPress["select"]
			inputs.options = keyPress["escape"] or buttonPress["start"]

			inputs.restart = keyPress["r"]
			inputs.pause = keyPress["p"]

			inputs.ability = keyPress["q"]
			inputs.debug = keyPress["d"]
			inputs.frame = keyPress["f"]
			inputs.hitboxes = keyPress[""]

			oldStickX = stickX
			oldStickY = stickY
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

	if #xboxControllers == 0 then
		inputs.confirm = keyDown["space"] or keyDown["return"]
		inputs.back = keyDown["escape"]

		inputs.jump = keyDown["space"]
		inputs.left = keyDown["left"]
		inputs.right = keyDown["right"]
		inputs.up = keyDown["up"]
		inputs.down = keyDown["down"]
		inputs.attack1 = keyDown["z"]
		inputs.attack2 = keyDown["x"]
		inputs.interact = keyDown["e"]
		inputs.inventory = keyDown["tab"]
		inputs.options = keyDown["escape"]

		inputs.restart = keyDown["r"]
		inputs.pause = keyDown["p"]
		
		inputs.ability = keyDown["q"]
		inputs.debug = keyDown["d"]
		inputs.frame = keyDown["f"]
		inputs.hitboxes = keyDown[""]
	else
		for i, e in ipairs(xboxControllers) do
			inputs.confirm = keyDown["space"] or keyDown["z"] or buttonDown["b"] or buttonDown["a"]
			inputs.back = keyDown["escape"] or keyDown["x"] or buttonDown["start"] or buttonDown["x"]

			inputs.jump = keyDown["space"] or buttonDown["b"]
			inputs.left = keyDown["left"] or e:getGamepadAxis("leftx") < -controllerDeadzone
			inputs.right = keyDown["right"] or e:getGamepadAxis("leftx") > controllerDeadzone
			inputs.up = keyDown["up"] or e:getGamepadAxis("lefty") < -controllerDeadzone
			inputs.down = keyDown["down"] or e:getGamepadAxis("lefty") > controllerDeadzone
			inputs.attack1 = keyDown["z"] or buttonDown["a"]
			inputs.attack2 = keyDown["x"] or buttonDown["x"]
			inputs.interact = keyDown["e"] or buttonDown["y"]
			inputs.inventory = keyDown["tab"] or buttonDown["select"]
			inputs.options = keyDown["escape"] or buttonDown["start"]

			inputs.restart = keyDown["r"]
			inputs.pause = keyDown["p"]

			inputs.ability = keyDown["q"]
			inputs.debug = keyDown["d"]
			inputs.frame = keyDown["f"]
			inputs.hitboxes = keyDown[""]
			
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