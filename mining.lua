local tArgs = {...}
if tArgs == nil then
    return
end
local Length = tonumber(tArgs[1])
local Width = tonumber(tArgs[2])
local Height = tonumber(tArgs[3])
local HalfW = math.floor((Width - 1)/2)
local currentL = 0
local currentH = 0
local i = 0
local r = 0
local s = 0
local minfuel = 200
local currentFuel = 0
local input
local currentItem = {}
local sanity
local isblock = true
local fuelItems = {}
    
function getitems()
    i = 0
    for i = 0, 16 do
        if sanity == true then
        sanity = turtle.suck()
        sleep(0.5)
        else
         i = 16
        end
    end
end

function dumpInv()
turtle.turnLeft()
for i = 1, 16 do
    turtle.select(i)
    currentItem = turtle.getItemDetail()
    if currentItem ~= nil and currentItem.name ~= fuelItems then
        turtle.drop()
    else end
    end
end

function dumpExFuel()
    getitems()
    for i = 1, 16 do
        turtle.select(i)
        currentItem = turtle.getItemDetail()
        if currentItem ~= nil and currentItem == fuelItems then
            turtle.refuel(All)
        else end
        end
    for i = 1, 16 do
        turtle.select(i)
        currentItem = turtle.getItemDetail()
            if currentItem == fuelItems then
            turtle.drop()
            else end           
    end
end

function offload()
local d = currentL
print("Low on fuel! Dumping cargo and grabbing more!")
turtle.turnLeft()
turtle.turnLeft()
while d > 0 do
    turtle.forward()
end
turtle.turnLeft()

dumpExFuel()
turtle.turnLeft()
dumpInv()
turtle.turnRight()
if currentFuel > minfuel then
while d < currentL do
    turtle.forward()
end
else
    print("No Fuel! Please add fuel and restart program!")
    sanity = 1
    
end
end

function checkFuel()
    currentFuel = turtle.getFuelLevel()
    turtle.select(16)
    currentItem = turtle.getItemDetail()
    if currentFuel <= minfuel or currentItem ~= nil then
        offload()
    else end
    end

function digSafe()
    isblock = true
    while isblock == true do
    turtle.dig()
    sleep(0.25)
    isblock = turtle.detect()
    end
end



function iFWD()
    while currentL < Length do
        sanity = 0
    checkFuel()
    if sanity == 1 then
        currentL = Length
    end
    turtle.select(1)
    digSafe()
    turtle.forward()
    turtle.turnLeft()
    iSide()
    turtle.turnRight()
    turtle.turnRight()
    s = 1
    iSide()
    s = 0
    turtle.turnLeft()
    iElev()
    currentL = currentL + 1
    end
    
end

    

function iSide()
    i = 0
    if currentH == Height-1 and r == 1 then
        i = i + 1
    end
    while i < HalfW do

        digSafe()
        turtle.forward()
        i = i + 1
    end
    if s == 0 and HalfW < (Width-1)/2 then
        digSafe()
    end
    if currentH == Height-1 and r == 1 then
        i = i - 1
    end
    while i > 0 do
        turtle.back()
        i = i - 1
    end
end

function iElev()
    currentH = 1
    while currentH < Height do
        turtle.digUp()
        turtle.up()
        turtle.turnLeft()
        iSide()
        turtle.turnRight()
        turtle.turnRight()
        s = 1
        iSide()
        s = 0
        turtle.turnLeft()
        currentH = currentH + 1
    end
    while currentH > 1 do
        turtle.down()
        currentH = currentH - 1
    end
end

term.clear()
term.setCursorPos(1,1)
print("Beginning Tunneling Program")
numbers()
sleep(1)
print("Depth input reads "..Length.." meters")
sleep(0.5)
print("Width input reads " ..Width.." meters")
sleep(0.5)
print("Height input reads " ..Height.." meters")

print("Half Width is ",HalfW)
if Width >= 3 and Height >=3 then
    sleep(2)
    print("It looks like your tunnel is decent sized. Round the corners?")
    input = read()
    if input == "yes" then
        print("Rounding Corners")
        r = 1
    else
        print("not rounding corners")
        r = 0
    end
else
end

print("Variable confirmation complete. Checking fuel and necessities.")
for i = 1, 16 do
    turtle.select(i)
    currentItem = turtle.getItemDetail()
    if currentItem ~= nil and currentItem.name == "minecraft:chest" then
    
        turtle.turnLeft()
        turtle.place()
        turtle.turnRight()
        turtle.turnRight()
        turtle.place()
        turtle.turnLeft()
    else
    end
end
lastfuel = turtle.getFuelLevel()
if lastfuel < minfuel then
    for i = 1, 16 do
        turtle.select(i)
        currentItem = turtle.getItemDetail()
        if currentItem ~= nil and currentItem ~= fuelItems then
        turtle.refuel()
        if true then
            table.insert(fuelItems, 1, currentItem)
        else
        end
        else
        turtle.refuel(All)
        end
    end
else
end
turtle.turnRight()
for i = 1, 16 do
    turtle.select(i)
    local currentItem = turtle.getItemDetail()
    if currentItem ~= nil and currentItem.name == fuelItems then
        turtle.drop()
    else
    end
end
turtle.turnLeft()
dumpInv()
turtle.turnRight()
print("Launch Checks Complete. Beginning tunnel bore.")
turtle.select(1)
iFWD()
for i = Length, 1, -1 do
    turtle.back()
end
if sanity == 0 then
term.clear()
term.setCursorPos(1,1)
print("MISSION ACCOMPLISHED!")
end





