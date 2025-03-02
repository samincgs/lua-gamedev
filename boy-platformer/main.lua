function love.load()
    wf = require 'libraries/windfield/windfield'
    -- first created a new World for all the physics objects
    local gravityY = 500
    world = wf.newWorld(0, gravityY) -- parameters: gravityX, gravityY

     -- Physics object that contains information about of all funtions of the Love physics Body, Fixture and Shape parameters: x,y, width, height 
    player = world:newRectangleCollider(360, 100, 80, 80)
    platform = world:newRectangleCollider(250, 400, 300, 100)

    platform:setType('static')

end

function love.update(dt)
    world:update(dt)
end

function love.draw()
    world:draw()
end