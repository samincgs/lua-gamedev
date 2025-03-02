function love.load()
    wf = require 'libraries/windfield/windfield'
    -- first created a new World for all the physics objects
    local gravityY = 500
    world = wf.newWorld(0, gravityY, false) -- parameters: gravityX, gravityY, sleepMode

    world:addCollisionClass('Platform')
    world:addCollisionClass('Player') --[[{ignores = {'Platform'}}]]
    world:addCollisionClass('Danger')

     -- Physics object that contains information about of all funtions of the Love physics Body, Fixture and Shape parameters: x,y, width, height, table with collision class
    player = world:newRectangleCollider(360, 100, 80, 80, {collision_class='Player'})
    player:setFixedRotation(true)
    player.speed = 240

    platform = world:newRectangleCollider(250, 400, 300, 100, {collision_class='Platform'})
    platform:setType('static')

    dangerZone = world:newRectangleCollider(0, 550, 800, 50, {collision_class='Danger'})
    dangerZone:setType('static')

end

function love.update(dt)
    world:update(dt)

    if player.body then
        local px, py = player:getPosition()
        if love.keyboard.isDown('right') then
            player:setX(px + player.speed * dt)
        end
        if love.keyboard.isDown('left') then
            player:setX(px - player.speed * dt)
        end

        if player:enter('Danger') then
            player:destroy()
        end
    end
end

function love.draw()
    world:draw()
end

function love.keypressed(key) 
    if key == 'up' then
        player:applyLinearImpulse(0, -5000)
    end
end