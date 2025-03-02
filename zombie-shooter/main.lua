function love.load()
    math.randomseed(os.time())


    images = {}
    
    images.player = love.graphics.newImage('images/player.png')
    images.zombie = love.graphics.newImage('images/zombie.png')
    images.background = love.graphics.newImage('images/background.png')
    images.bullet = love.graphics.newImage('images/bullet.png')
    
    player = {}

    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player.speed = 220
    player.rotation = 0

    zombies = {}
    bullets = {}

    gameState = 1
    myFont = love.graphics.newFont(30)

    zombieSpawnTime = 2
    zombieTimer = zombieSpawnTime 

end

function love.update(dt)
    if gameState == 2 then
        if love.keyboard.isDown('d') then
            if player.x + images.player:getWidth() / 2 < love.graphics.getWidth() then
                player.x = player.x + player.speed * dt
            end
        end
        if love.keyboard.isDown('a') then
            if player.x - images.player:getWidth() / 2 > 0 then
                player.x = player.x - player.speed * dt
            end
        end
        if love.keyboard.isDown('s') then
            if player.y + images.player:getHeight() / 2 < love.graphics.getHeight() then
                player.y = player.y + player.speed * dt
            end
        end
        if love.keyboard.isDown('w') then
            if player.y - images.player:getHeight() / 2 > 0 then
                player.y = player.y - player.speed * dt
            end
        end
    end

    for i, z in ipairs(zombies) do
        local zombieToPlayerAngle = getAngle(z.x, z.y, player.x, player.y)
        z.x = z.x + math.cos(zombieToPlayerAngle) * z.speed * dt 
        z.y = z.y + math.sin(zombieToPlayerAngle) * z.speed * dt 
        local zombieToPlayerDistance = getDistance(z.x, z.y, player.x, player.y)
        if zombieToPlayerDistance < 30 then
            for i,z in ipairs(zombies) do 
                zombies[i] = nil
                gameState = 1
                player.x = love.graphics.getWidth() / 2
                player.y = love.graphics.getHeight() / 2
            end
        end
    end

    for i,b in ipairs(bullets) do 
        b.x = b.x + math.cos(b.direction) * b.speed * dt
        b.y = b.y + math.sin(b.direction) * b.speed * dt
        if b.x > love.graphics.getWidth() or b.x < 0 or b.y > love.graphics.getHeight() or b.y < 0 then -- check if bullets goes out of the screen
            b.dead = true
        end
        for j, z in ipairs(zombies) do
            local bulletToZombieDistance = getDistance(b.x, b.y, z.x, z.y)
            if bulletToZombieDistance < 20 then
                b.dead = true
                z.dead = true
            end
        end
    end

    --  go through loop in reverse order so we can remove during iteration
    for i=#bullets, 1, -1 do
        local b = bullets[i]
        if b.dead then
            table.remove(bullets, i)
        end
    end

    for i=#zombies, 1, -1 do
        local z = zombies[i]
        if z.dead then
            table.remove(zombies, i)
        end
    end

    if gameState == 2 then
        zombieTimer = zombieTimer - dt
        if zombieTimer <= 0 then
            spawnZombie()
            zombieSpawnTime = zombieSpawnTime * 0.95
            zombieTimer = zombieSpawnTime
        end
    end

end



function love.draw()
    love.graphics.draw(images.background)

    if gameState == 1 then
        love.graphics.setFont(myFont)
        love.graphics.printf('Click anywhere to begin!', 0, 50, love.graphics.getWidth(), 'center')
    end

    player.rotation = getAngle(player.x, player.y, love.mouse.getX(), love.mouse.getY())
    love.graphics.draw(images.player, player.x, player.y, player.rotation, nil, nil, images.player:getWidth() / 2, images.player:getHeight() / 2)

    for i,z in ipairs(zombies) do
        z.rotation = getAngle(z.x, z.y, player.x, player.y)
        love.graphics.draw(images.zombie, z.x, z.y, z.rotation, nil, nil, images.zombie:getWidth() / 2, images.zombie:getHeight() / 2)
    end

    for i,b in ipairs(bullets) do
        love.graphics.draw(images.bullet, b.x, b.y, nil, 0.5, 0.5, images.bullet:getWidth() / 2, images.bullet:getHeight() / 2)
    end

    

end

function love.mousepressed(x, y, button, istouch, presses)
    if gameState == 2 and button == 1 then
        spawnBullet()
    end
    if gameState == 1 and button == 1 then
        zombieTimer = zombieSpawnTime 
        zombieSpawnTime = 2
        gameState = 2
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
    zombie.x = 0
    zombie.y = 0
    zombie.speed = 200
    zombie.rotation = 0
    zombie.dead = false

    local side = math.random(1, 4) -- 1 = left 2 = up 3 = right 4 = down
    local spawnOffset = 30

    if side == 1 then
        zombie.x = -spawnOffset
        zombie.y = math.random(0, love.graphics.getHeight())
    elseif side == 2 then
        zombie.x = math.random(0, love.graphics.getWidth())
        zombie.y = -spawnOffset
    elseif side == 3 then
        zombie.x = love.graphics.getWidth() + spawnOffset
        zombie.y = math.random(0, love.graphics.getHeight())
    elseif side == 4 then
        zombie.x = math.random(0, love.graphics.getWidth())
        zombie.y = love.graphics.getHeight() + spawnOffset
    end
    
    table.insert(zombies, zombie)
end

function spawnBullet()
    bullet = {}
    bullet.x = player.x
    bullet.y = player.y
    bullet.speed = 500
    bullet.direction = getAngle(bullet.x, bullet.y, love.mouse.getX(), love.mouse.getY())
    bullet.dead = false

    table.insert(bullets, bullet)
end