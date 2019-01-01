function getItemStats(item)
    local stats = {}

    if item == "heart" then
    	itemType = "heart"
    	sprite = love.graphics.newImage("images/items/heart16px.png")
    	width = sprite:getWidth()
        height = sprite:getHeight()
    elseif item == "demonBroadsword" then
        itemType = "weapon"
        sprite = love.graphics.newImage("images/weapons/swords/demonBroadsword/demonBroadswordIcon.png")
        width = sprite:getWidth()
        height = sprite:getHeight()
    elseif item == "cobaltBroadsword" then
        itemType = "weapon"
        sprite = love.graphics.newImage("images/weapons/swords/cobaltBroadsword/cobaltBroadswordIcon.png")
        width = sprite:getWidth()
        height = sprite:getHeight()
    end

    table.insert(stats, itemType)
    table.insert(stats, sprite)
    table.insert(stats, width)
    table.insert(stats, height)

    return stats
end