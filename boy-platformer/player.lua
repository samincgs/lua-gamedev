playerStartX = 360
playerStartY = 200

player = world:newRectangleCollider(playerStartX, playerStartY, 40, 100, {collision_class='Player'})
player:setFixedRotation(true)
player.speed = 260
player.animation = animations.idle
player.isMoving = false
player.grounded = true
player.direction = 1

function player:update(dt)
    if player.body then
        player.isMoving = false
        local px, py = player:getPosition()
        local colliders = world:queryRectangleArea(px - 20, py + 50, 40, 4, {'Platform'})
        if #colliders > 0 then
            player.grounded = true
        else
            player.grounded = false
        end

        if love.keyboard.isDown('right') then
            player:setX(px + player.speed * dt)
            player.isMoving = true
            player.direction = 1
        end
        if love.keyboard.isDown('left') then
            player:setX(px - player.speed * dt)
            player.isMoving = true
            player.direction = -1
        end

        if player:enter('Danger') then
            player:setPosition(playerStartX, playerStartY)
        end
    end

    if player.grounded then
        if player.isMoving then
            player.animation = animations.run
        else
            player.animation = animations.idle
        end
    else
        player.animation = animations.jump
    end

    player.animation:update(dt)
end

function player:draw() 
    player.animation:draw(sprites.playerSheet, player:getX(), player:getY(), nil, 0.25 * player.direction, 0.25, 130, 300)
end

function player:jump()
    if player.grounded then
        player:applyLinearImpulse(0, -3000)
    end
end