function love.load()
    images = {}
    
    images.player = love.graphics.newImage('images/player.png')
    images.zombie = love.graphics.newImage('images/zombie.png')
    images.background = love.graphics.newImage('images/background.png')
    images.bullet = love.graphics.newImage('images/bullet.png')
    
    player = {}

    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player.speed = 180
    player.rotation = 0

    zombies = {}

end


function love.update(dt)
    if love.keyboard.isDown('d') then
        player.x = player.x + player.speed * dt
    end
    if love.keyboard.isDown('a') then
        player.x = player.x - player.speed * dt
    end
    if love.keyboard.isDown('s') then
        player.y = player.y + player.speed * dt
    end
    if love.keyboard.isDown('w') then
        player.y = player.y - player.speed * dt
    end


end

function love.draw()
    love.graphics.draw(images.background)

    player.rotation = getAngle(player.x, player.y, love.mouse.getX(), love.mouse.getY())
    love.graphics.draw(images.player, player.x, player.y, player.rotation, nil, nil, images.player:getWidth() / 2, images.player:getHeight() / 2)

    for i,z in ipairs(zombies) do
        love.graphics.draw(images.zombie, z.x, z.y)
    end
end

function getAngle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end

function love.keypressed(key)
    if key == 'space' then
        spawnZombie()
    end
end

function spawnZombie()
    local zombie = {}
    zombie.x = math.random(0, love.graphics.getWidth())
    zombie.y = math.random(0, love.graphics.getHeight())
    zombie.speed = 100

    table.insert(zombies, zombie)

end