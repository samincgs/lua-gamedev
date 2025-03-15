-- first created a new World for all the physics objects
local gravityY = 500
world = wf.newWorld(0, gravityY, false) -- parameters: gravityX, gravityY, sleepMode
world:setQueryDebugDrawing(true) -- for debugging

world:addCollisionClass('Platform')
world:addCollisionClass('Player') --[[{ignores = {'Platform'}}]]
world:addCollisionClass('Danger')

-- dangerZone = world:newRectangleCollider(0, 550, 800, 50, {collision_class='Danger'})
-- dangerZone:setType('static')