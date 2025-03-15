function love.load()
    anim8 = require 'libraries/anim8/anim8'
    wf = require 'libraries/windfield'

    

    sprites = {}
    sprites.playerSheet = love.graphics.newImage('images/playerSheet.png')

    local columns = 15
    local rows = 3
    local grid = anim8.newGrid(sprites.playerSheet:getWidth() / columns, sprites.playerSheet:getHeight() / rows, sprites.playerSheet:getWidth(), sprites.playerSheet:getHeight())

    animations = {}
    animations.idle = anim8.newAnimation(grid('1-15', 1), 0.05)
    animations.jump = anim8.newAnimation(grid('1-7', 2), 0.05)
    animations.run = anim8.newAnimation(grid('1-15', 3), 0.05)


    -- first created a new World for all the physics objects
    local gravityY = 500
    world = wf.newWorld(0, gravityY, false) -- parameters: gravityX, gravityY, sleepMode
    world:setQueryDebugDrawing(true) -- for debugging

    world:addCollisionClass('Platform')
    world:addCollisionClass('Player') --[[{ignores = {'Platform'}}]]
    world:addCollisionClass('Danger')

    require('player')

    platform = world:newRectangleCollider(250, 400, 300, 100, {collision_class='Platform'})
    platform:setType('static')

    dangerZone = world:newRectangleCollider(0, 550, 800, 50, {collision_class='Danger'})
    dangerZone:setType('static')

end

function love.update(dt)
    world:update(dt)
    player:update(dt)
    
end

function love.draw()
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