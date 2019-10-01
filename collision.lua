function AABB(x1, y1, width1, height1, x2, y2, width2, height2)
	local xCheck = x1 + width1 > x2 and x1 < x2 + width2
	local yCheck = y1 + height1 > y2 and y1 < y2 + height2
	return xCheck and yCheck
end

function checkCollision(x, y, width, height, platform, playerCollision)
	-- table.insert(hitboxes, {x, y, width, height})
	for _, actor in ipairs(tiles) do
		if (actor.collidable) or (playerCollision == false and platform and actor.platform) or (playerCollision and platform and actor.platform and player.yVelocity >= 0 and downInputs.down ~= true) then
			if AABB(x, y, width, height, actor.x + actor.hitboxX, actor.y + actor.hitboxY, actor.hitboxWidth, actor.hitboxHeight) then
				return true
			end
		end
	end
	return false
end

function getCollidingActors(x, y, width, height, collidable, platform, drawHitboxes, checkTiles, checkNpcs, checkObjects, checkItems, checkPlayer, largeHitboxes, sizeReduction)
	local collides = {}
	-- if drawHitboxes then
	-- 	table.insert(hitboxes, {x, y, width, height})
	-- end

	if largeHitboxes ~= true and sizeReduction == nil then
		sizeReduction = 0
	end

	if checkTiles then
		if collidable then
			for _, actor in ipairs(collidableTiles) do
				if largeHitboxes then
					if AABB(x, y, width, height, actor.x, actor.y, actor.width, actor.height) then
						table.insert(collides, actor)
					end
				else
					if AABB(x, y, width, height, actor.x + actor.hitboxX + sizeReduction, actor.y + actor.hitboxY + sizeReduction, actor.hitboxWidth - sizeReduction*2, actor.hitboxHeight - sizeReduction*2) then
						table.insert(collides, actor)
					end
				end
			end
		else
			for _, actor in ipairs(nonCollidableTiles) do
				if largeHitboxes then
					if AABB(x, y, width, height, actor.x, actor.y, actor.width, actor.height) then
						table.insert(collides, actor)
					end
				else
					if AABB(x, y, width, height, actor.x + actor.hitboxX + sizeReduction, actor.y + actor.hitboxY + sizeReduction, actor.hitboxWidth - sizeReduction*2, actor.hitboxHeight - sizeReduction*2) then
						table.insert(collides, actor)
					end
				end
			end
		end
		if platform then
			for _, actor in ipairs(platformTiles) do
				if largeHitboxes then
					if AABB(x, y, width, height, actor.x, actor.y, actor.width, actor.height) then
						table.insert(collides, actor)
					end
				else
					if AABB(x, y, width, height, actor.x + actor.hitboxX + sizeReduction, actor.y + actor.hitboxY + sizeReduction, actor.hitboxWidth - sizeReduction*2, actor.hitboxHeight - sizeReduction*2) then
						table.insert(collides, actor)
					end
				end
			end
		end
	end

	if checkNpcs then
		for _, actor in ipairs(npcs) do
			if actor.attacking then
				if actor.direction == "left" then
					if AABB(x, y, width, height, actor.x + (actor.attackWidth - actor.attackHitboxWidth - actor.attackHitboxX), actor.y + actor.attackHitboxY, actor.attackHitboxWidth, actor.attackHitboxHeight) then
						table.insert(collides, actor)
					end
				else
					if AABB(x, y, width, height, actor.x + actor.attackHitboxX, actor.y + actor.attackHitboxY, actor.attackHitboxWidth, actor.attackHitboxHeight) then
						table.insert(collides, actor)
					end
				end
			else
				if actor.direction == "left" then
					if AABB(x, y, width, height, actor.x + (actor.width - actor.hitboxWidth - actor.hitboxX), actor.y + actor.hitboxY, actor.hitboxWidth, actor.hitboxHeight) then
						table.insert(collides, actor)
					end
				else
					if AABB(x, y, width, height, actor.x + actor.hitboxX, actor.y + actor.hitboxY, actor.hitboxWidth, actor.hitboxHeight) then
						table.insert(collides, actor)
					end
				end
			end
		end
	end

	if checkObjects then
		for _, actor in ipairs(objects) do
			if AABB(x, y, width, height, actor.x + actor.hitboxX, actor.y + actor.hitboxY, actor.hitboxWidth, actor.hitboxHeight) then
				table.insert(collides, actor)
			end
		end
	end

	if checkItems then
		for _, actor in ipairs(items) do
			if AABB(x, y, width, height, actor.x + actor.hitboxX, actor.y + actor.hitboxY, actor.hitboxWidth, actor.hitboxHeight) then
				table.insert(collides, actor)
			end
		end
	end

	if checkPlayer then
		if AABB(x, y, width, height, player.x + player.hitboxX, player.y + player.hitboxY, player.hitboxWidth, player.hitboxHeight) then
			table.insert(collides, player)
		end
	end

	return collides
end