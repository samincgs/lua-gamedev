function love.load()
    love.mouse.setVisible(false)

    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50

    score = 0
    timer = 0

    gameFont = love.graphics.newFont(40)

    images = {}
    images.sky = love.graphics.newImage('/images/sky.png')
    images.target = love.graphics.newImage('/images/target.png')
    images.crosshair = love.graphics.newImage('/images/crosshair.png')

    gameState = 1 -- 1 -> main menu 2--> game

end


function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    else
        timer = 0
        gameState = 1
    end
end
 

function love.draw()
    love.graphics.draw(images.sky)

    if gameState == 1 then
        love.graphics.printf('Click anywhere to begin!', 0, 250, love.graphics.getWidth(), 'center')
    elseif gameState == 2 then
        love.graphics.draw(images.target, target.x - target.radius, target.y - target.radius)
    end
    
    love.graphics.draw(images.crosshair, love.mouse.getX() - images.crosshair:getWidth() / 2, love.mouse.getY() - images.crosshair:getHeight() / 2)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print('Score: ' .. score, 5, 5)
    love.graphics.print('Timer: ' .. math.ceil(math.abs(timer)), 300, 5)
end

function love.mousepressed(x, y, button, istouch, presses)
    if gameState == 2 then
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if button == 1 then
            if mouseToTarget < target.radius then
                score = score + 1
                target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
                target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
            else
                score = score - 1
            end
        elseif button == 2 then
            if mouseToTarget < target.radius then
                score = score + 2
                target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
                target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
            else
                score = score - 1
                timer = timer - 1
            end
        end
    end
    if button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
        score = 0
    end
 end

 function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
 end