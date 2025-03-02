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
    bullets = {}

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

    for i, z in ipairs(zombies) do
        local zombieToPlayerAngle = getAngle(z.x, z.y, player.x, player.y)
        z.x = z.x + math.cos(zombieToPlayerAngle) * z.speed * dt 
        z.y = z.y + math.sin(zombieToPlayerAngle) * z.speed * dt 
        local zombieToPlayerDistance = getDistance(z.x, z.y, player.x, player.y)
        if zombieToPlayerDistance < 30 then
            for i,z in ipairs(zombies) do 
                zombies[i] = nil
            end
        end
    end

    for i,b in ipairs(bullets) do 
        b.x = b.x + math.cos(b.direction) * b.speed * dt
        b.y = b.y + math.sin(b.direction) * b.speed * dt
    end



end

function love.draw()
    love.graphics.draw(images.background)

    player.rotation = getAngle(player.x, player.y, love.mouse.getX(), love.mouse.getY())
    love.graphics.draw(images.player, player.x, player.y, player.rotation, nil, nil, images.player:getWidth() / 2, images.player:getHeight() / 2)

    for i,z in ipairs(zombies) do
        z.rotation = getAngle(z.x, z.y, player.x, player.y)
        love.graphics.draw(images.zombie, z.x, z.y, z.rotation, nil, nil, images.zombie:getWidth() / 2, images.zombie:getHeight() / 2)
    end

    for i,b in ipairs(bullets) do
        love.graphics.draw(images.bullet, b.x, b.y, b.direction, nil, nil, images.zombie:getWidth() / 2, images.zombie:getHeight() / 2)
    end

    love.graphics.print(#bullets)

end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        spawnBullet()
    end
end

function love.keypressed(key)
    if key == 'space' then
        spawnZombie()
    end
end

function getAngle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end

function getDistance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function spawnZombie()
    local zombie = {}
    zombie.x = math.random(0, love.graphics.getWidth())
    zombie.y = math.random(0, love.graphics.getHeight())
    zombie.speed = 100
    zombie.rotation = 0

    table.insert(zombies, zombie)
end

function spawnBullet()
    bullet = {}
    bullet.x = player.x
    bullet.y = player.y
    bullet.speed = 500
    bullet.direction = getAngle(bullet.x, bullet.y, love.mouse.getX(), love.mouse.getY())

    table.insert(bullets, bullet)
end