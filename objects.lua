function newObject(objectX, objectY, objectWidth, objectHeight, objectType, objectData, objectActive)
	local object = {}
	object.x = objectX
	object.y = objectY
	object.width = objectWidth
	object.height = objectHeight
	object.type = objectType
	object.data = objectData
	object.active = objectActive
	object.near = false
	object.nearCounter = 0
	object.actor = "object"
	object.used = false

	object.hitboxX = 0
	object.hitboxY = 0
	object.hitboxWidth = object.width
	object.hitboxHeight = object.height

	if object.type == "chest" then
		if object.x < (16+480+16)/2 then
			object.side = "left"
		else
			object.side = "right"
		end
	end

	function object:act(index)
		object.index = index
		if object.near and object.nearCounter < 0.9 then
			object.nearCounter = object.nearCounter + 0.1
		elseif object.near == false and object.nearCounter > 0.1 then
			object.nearCounter = object.nearCounter - 0.1
		end

		if object.type == "teleporter" then
			if blocked or (bossLevel and enemyCounter == 0) then
				if blocked and (bossLevel and enemy == 0) == false then
					object.active = true
				end
				-- object.active = true -- uncomment to unlock level 2
			else
				object.active = false
			end
		end

		if object.type == "chest" then
			if object.used or (bossLevel and enemyCounter > 0) then
				object.active = false
			else
				object.active = true
			end
		end
	end

	function object:draw() end

	return object
end