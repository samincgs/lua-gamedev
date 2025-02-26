
-- variables
message = 5
chicken = 10
output = chicken * 3

message = message - 1

-- if statements
condition = -25

if condition > 0 then
    message = 1
end

if condition < 0 then
    message = -1 
end

-- else and elseifs
if condition > 0 then
    message = 1
elseif condition < -100 then
    message = -1
else
    message = 'no conditions met!'
end

# while loops


function love.draw()
    love.graphics.setFont(love.graphics.newFont(50))
    love.graphics.print(message)
end 


