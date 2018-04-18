function AABB(x1, y1, width1, height1, x2, y2, width2, height2)
    local xCheck = x1 + width1 > x2 and x1 < x2 + width2
    local yCheck = y1 + height1 > y2 and y1 < y2 + height2
    return xCheck and yCheck
end

function checkCollision(x, y, width, height)
    table.insert(hitboxes, {x, y, width, height})
    for _, actor in ipairs(actors) do
        table.insert(hitboxes, {actor.x, actor.y, actor.width, actor.height})
        if AABB(x, y, width, height, actor.x, actor.y, actor.width, actor.height) and actor.actor ~= "player" and actor.collidable then
            return true
        end
    end
    return false
end

function getCollidingActors(x, y, width, height)
    collides = {}
    table.insert(hitboxes, {x, y, width, height})
    for _, actor in ipairs(actors) do
        if AABB(x, y, width, height, actor.x, actor.y, actor.width, actor.height) and actor.actor ~= "player" and actor.collidable then
            table.insert(collides, actor)
        end
    end
    return collides
end