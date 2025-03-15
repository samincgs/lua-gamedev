function love.load()
    require('libraries')

    love.window.setMode(1000, 768)
    cam = cameraFile()

    require('world')
    require('sprites')
    require('player')
    require('enemy')

    platforms = {}
    loadMap()

    spawnEnemy(960, 320)

end

function love.update(dt)
    world:update(dt)
    gameMap:update(dt)
    player:update(dt)
    updateEnemies(dt)

    cam:lookAt(player:getX(), love.graphics.getHeight() / 2)
    
end

function love.draw()
    cam:attach()
        gameMap:drawLayer(gameMap.layers['Tile Layer 1'])
        world:draw()
        player:draw()
        drawEnemies()
    cam:detach()
end

function love.keypressed(key) 
    if key == 'up' then
        player:jump()
    end
end

-- function love.mousepressed(x, y, button)
--     if button == 1 then
--         local colliders = world:queryCircleArea(x, y, 200, {'Platform', 'Danger'})
--         for i, c in ipairs(colliders) do
--             c:destroy()
--         end
--     end
-- end

function loadMap()
    gameMap = sti('maps/level1.lua')

    for i, obj in pairs(gameMap.layers['Platforms'].objects) do
        loadPlatform(obj.x, obj.y, obj.width, obj.height)
    end
end

function loadPlatform(x, y, width, height)
    if width > 0 and height > 0 then
        local platform = world:newRectangleCollider(x, y, width, height, {collision_class='Platform'})
        platform:setType('static')
        table.insert(platforms, platform)
    end
end