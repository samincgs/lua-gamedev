
-- variables
message = 5
chicken = 10
output = chicken * 3

-- if statements
message = 0
condition = -25

if condition > 0 then
    message = 1
end

if condition < 0 then
    message = -1 
end

-- else and elseifs
message = 0
condition = -25

if condition > 0 then
    message = 1
elseif condition < -100 then
    message = -1
else
    message = 'no conditions met!'
end

-- while loops
message = 0
test = 0

while message < 10 do
    message = message + 1
    test = test - 5
end

--  for loops
pickle = 0

for i=1, 3, 1 do
    -- pickle = pickle + 10
    pickle = pickle + i
end

-- functions
message = 0

function increaseMessage(i)
    message = message + i
end

increaseMessage(25)

function double(val)
    val = val * 2
    return val
end

message = double(12)

-- local and global variables

message = 0

function getHalf(i)
    local var = i
    var = var / 2
    return var
end

-- tables
-- store sets of related data
testScores = {}

-- three methods
-- 1.
testScores = {95, 87, 98}

-- 2.
testScores = {}
testScores['math'] = 91
testScores[1] = 95
testScores[2] = 87
testScores[3] = 98


-- 3.
testScores = {}

table.insert(testScores, 95) -- table name, value
table.insert(testScores, 87)
table.insert(testScores, 98)

message = testScores[2]

message = 0
for i,s in ipairs(testScores) do -- i is the index, s is the value
    message = message + s
end

-- can give tables their own variables
testScores.subject = 'science'
testScores.average = 0


function love.draw()
    love.graphics.setFont(love.graphics.newFont(50))
    -- love.graphics.print(chicken)
    -- love.graphics.print(message)
    -- love.graphics.print(test)
    -- love.graphics.print(pickle)
    love.graphics.print(message)
end 


