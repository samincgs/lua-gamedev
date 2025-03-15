function love.load()
    require('libraries')

    love.window.setMode(1000, 768)
    cam = cameraFile()

    require('world')
    require('sprites')
    require('player')
    require('enemy')

    platforms = {}
    flagX = 0
    flagY = 0
    
    saveData = {}
    saveData.currentLevel = 'level1'

    loadMap(saveData.currentLevel)

end

function love.update(dt)
    world:update(dt)
    gameMap:update(dt)
    player:update(dt)
    updateEnemies(dt)

    cam:lookAt(player:getX(), love.graphics.getHeight() / 2)

    local colliders = world:queryCircleArea(flagX, flagY, 10, {'Player'})
    if #colliders > 0 then
        if saveData.currentLevel == 'level1' then
            loadMap('level2')
        elseif saveData.currentLevel == 'level2' then
            loadMap('level1')
        end
    end
    
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

    if key == 'r' then
        loadMap('level2')
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

function loadMap(mapId)
    destroyAll()
    player:setPosition(300, 100)
    saveData.currentLevel = mapId
    gameMap = sti('maps/' .. saveData.currentLevel .. '.lua')

    for i, obj in pairs(gameMap.layers['Platforms'].objects) do
        loadPlatform(obj.x, obj.y, obj.width, obj.height)
    end

    for i, obj in pairs(gameMap.layers['Enemies'].objects) do
        spawnEnemy(obj.x, obj.y)
    end

    for i, obj in pairs(gameMap.layers['Flag'].objects) do
        flagX = obj.x
        flagY = obj.y
    end

end

function loadPlatform(x, y, width, height)
    if width > 0 and height > 0 then
        local platform = world:newRectangleCollider(x, y, width, height, {collision_class='Platform'})
        platform:setType('static')
        table.insert(platforms, platform)
    end
end

function destroyAll()

    local i = #platforms
    while i > -1 do
        if platforms[i] ~= nil then
            platforms[i]:destroy()
        end
        table.remove(platforms, i)
        i = i - 1
    end

    local i = #enemies
    while i > -1 do
        if enemies[i] ~= nil then
            enemies[i]:destroy()
        end
        table.remove(enemies, i)
        i = i - 1
    end

    flagX = 0
    flagY = 0

end