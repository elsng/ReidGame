ScreenGame = class()

function ScreenGame:init()
    -- self.game = MyGame()
    seed = math.random(5000)
    math.randomseed(seed)
    
    --create an instance of Reidskie
    reid = Reidskie()
    poweruphandler = PowerUpHandler(reid)
    sweetie = Sweetie(reid,reid.position)
    -- set initial position to the middle of the screen
    reid.position = vec2(WIDTH/2,HEIGHT/2)   
    
    playerPoints = 0
    lootCollected = 0
    
    lootCount = 0
    monsterCount = 0
    --parameter.watch("lootCollected")
    -- create an instance of world, initialized with reid
    world = World(reid,11,9)
    --add reid to world
    reid.world = world
    
    gameText = GameMessage()
    
    countdownTimer = 300
    
    self.frame = 0
end

function ScreenGame:tick()
    --self.game:tick()
end

function ScreenGame:draw()
    --background color
    background(0)
    
    --fix offset
    translate(-70, -60)
    
    --draw world
    world:draw()
    
    --draw sweetie!!
    sweetie:draw()
    
    --draw reid
    if reid:isDead() then
        reid:drawDead()
    else
        reid:draw()
        if lootCollected == 2 then
            poweruphandler:handlePowerup(reid)
            --start powerupactive timer
            powerupIsActive = true
            self.frame = countdownTimer
            --reset loot collected
            lootCollected = 0
        end
    end
    
    if powerupIsActive == true then
        if self.frame == 0 then
            poweruphandler:killPowerup(reid)
            self.frame = countdownTimer
            powerupIsActive = false
        elseif self.frame <= countdownTimer and self.frame >= 0 then
            -- decreases activepowerup timer
            self.frame = self.frame - 1
        end
    end

    if monsterCount <= 3 then
        world:spawnMonster()
    end

    if lootCount <= 4 then
        world:spawnLoot()
    end

    --draw game text
    gameText:draw()
    
    --HEALTH text
    fontSize(20)
    fill(155,155,155,255)
    text("HEALTH", WIDTH/1.4, HEIGHT/5)
    --draw player health
    if reid.health % 10 == 0 then
        hitPoints = reid.health/10 - 1
        for h=0, hitPoints do
            sprite("Dropbox:heart", WIDTH/1.3 + 23*h , HEIGHT/5 , 20, 20)
        end
    end

    if playerPoints == 20 then
        changeScreen(ScreenWin())
    end

end

function ScreenGame:touched(touch)
    if touch.state == ENDED then
        reid:attack()
    end
end