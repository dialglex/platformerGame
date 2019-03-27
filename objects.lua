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

	object.hitboxX = 0
	object.hitboxY = 0
	object.hitboxWidth = object.width
	object.hitboxHeight = object.height

	function object:act(index)
		object.index = index
		if object.near and object.nearCounter < 0.9 then
			object.nearCounter = object.nearCounter + 0.1
		elseif object.near == false and object.nearCounter > 0.1 then
			object.nearCounter = object.nearCounter - 0.1
		end

		if object.type == "teleporter" then
			if blocked or (bossLevel and enemyCounter == 0) then
				object.active = true
			else
				object.active = false
			end
		end
	end

	function object:draw() end

	return object
end