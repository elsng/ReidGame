PowerUpHandler = class()

function PowerUpHandler:init(reid)
    powerUpList = {
        {["type"]=1, ["name"]="cuteLook", ["param"]="movementSpeed",  ["amount"]=10, ["properName"]="Cute Look", ["properParam"]="Movement Speed" },
        {["type"]=2, ["name"]="sexyDance", ["param"]="attackPower",  ["amount"]=5, ["properName"]="Sexy Dance", ["properParam"]="Attack Power" },
        {["type"]=3, ["name"]="toot", ["param"]="movementSpeed",  ["amount"]=20, ["properName"]="Toot", ["properParam"]="Movement Speed" },
        {["type"]=4, ["name"]="kiss", ["param"]="health",  ["amount"]=10, ["properName"]="Kiss", ["properParam"]="Health" },
    }
    self.reid = reid

end
-- this function just returns the count of objects in a list item... because lua doesn't have .count for some reason
function powerupLength(list)
    local count = 0
    for _ in pairs(list) do 
        count = count + 1 
    end
    return count
end

function PowerUpHandler:handlePowerup(reid)

    -- create powerup based on random
    randomNumber = math.floor(math.random(1,powerupLength(powerUpList)))

    --cute Look
    if randomNumber == 1 then
        powerupName = powerUpList[randomNumber]["name"]
        power = PowerUp(powerUpList[randomNumber]["param"],powerUpList[randomNumber]["amount"])
        reid.currentPowerupName = powerupName
    --sexy dance
    elseif randomNumber == 2 then
        powerupName = powerUpList[randomNumber]["name"]
        power = PowerUp(powerUpList[randomNumber]["param"],powerUpList[randomNumber]["amount"])
        reid.currentPowerupName = powerupName
    -- toot
    elseif randomNumber == 3 then
        powerupName = powerUpList[randomNumber]["name"]
        power = PowerUp(powerUpList[randomNumber]["param"],powerUpList[randomNumber]["amount"])
        reid.currentPowerupName = powerupName
    -- kiss
    elseif randomNumber == 4 then
        powerupName = powerUpList[randomNumber]["name"]
        power = PowerUp(powerUpList[randomNumber]["param"],powerUpList[randomNumber]["amount"])
        reid.currentPowerupName = powerupName
    end
    reid:applyPowerup(power)
    
    gameText.messageText = "Sweetie used " .. powerUpList[randomNumber]["properName"] .. ". " .. powerUpList[randomNumber]["properParam"] .. " was increased!"
end

function PowerUpHandler:killPowerup(reid)
    --kill powerup and reset reid to normal attack and movement power
    self.reid.attackPower = 10
    self.reid.movementSpeed = 20
    self.reid.currentPowerupName = ""
end

function PowerUpHandler:draw()
    -- Codea does not automatically call this method
end

function PowerUpHandler:touched(touch)
    -- Codea does not automatically call this method
end
