sprites = {}
animations = {}

sprites.playerSheet = love.graphics.newImage('images/playerSheet.png')

local columns = 15
local rows = 3
local grid = anim8.newGrid(sprites.playerSheet:getWidth() / columns, sprites.playerSheet:getHeight() / rows, sprites.playerSheet:getWidth(), sprites.playerSheet:getHeight())


animations.idle = anim8.newAnimation(grid('1-15', 1), 0.05)
animations.jump = anim8.newAnimation(grid('1-7', 2), 0.05)
animations.run = anim8.newAnimation(grid('1-15', 3), 0.05)