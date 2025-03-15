function love.load()
    love.window.setMode(1000, 768)

    anim8 = require 'libraries/anim8/anim8'
    sti = require 'libraries/Simple-Tiled-Implementation/sti'
    wf = require 'libraries/windfield'


    -- first created a new World for all the physics objects
    local gravityY = 500
    world = wf.newWorld(0, gravityY, false) -- parameters: gravityX, gravityY, sleepMode
    world:setQueryDebugDrawing(true) -- for debugging

    world:addCollisionClass('Platform')
    world:addCollisionClass('Player') --[[{ignores = {'Platform'}}]]
    world:addCollisionClass('Danger')

    require('sprites')
    require('player')

    platform = world:newRectangleCollider(250, 400, 300, 100, {collision_class='Platform'})
    platform:setType('static')

    dangerZone = world:newRectangleCollider(0, 550, 800, 50, {collision_class='Danger'})
    dangerZone:setType('static')

    loadMap()

end

function love.update(dt)
    world:update(dt)
    gameMap:update(dt)
    player:update(dt)
    
end

function love.draw()
    gameMap:drawLayer(gameMap.layers['Tile Layer 1'])
    world:draw()
    player:draw()

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
end