sprites = {}
animations = {}

sprites.playerSheet = love.graphics.newImage('images/playerSheet.png')
sprites.enemySheet = love.graphics.newImage('images/enemySheet.png')
sprites.background = love.graphics.newImage('images/background.png')

local playerCol = 15
local playerRow = 3
local grid = anim8.newGrid(sprites.playerSheet:getWidth() / playerCol, sprites.playerSheet:getHeight() / playerRow, sprites.playerSheet:getWidth(), sprites.playerSheet:getHeight())
local enemyGrid = anim8.newGrid(sprites.enemySheet:getWidth() / 2, sprites.enemySheet:getHeight(), sprites.enemySheet:getWidth(), sprites.enemySheet:getHeight())


animations.idle = anim8.newAnimation(grid('1-15', 1), 0.05)
animations.jump = anim8.newAnimation(grid('1-7', 2), 0.05)
animations.run = anim8.newAnimation(grid('1-15', 3), 0.05)

animations.enemy = anim8.newAnimation(enemyGrid('1-2', 1), 0.03)