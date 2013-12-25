Reidskie = class()

--Initialize Reidskie
function Reidskie:init()
    --Reidskie's position
    self.position = vec2(0,0)
    --Reidskie's size
    self.size = 60
    -- Reidskie's Health
    self.health = 50
    --Reidskie's attack strength
    self.attackPower = 10
    --Reidskie's movement speed
    self.movementSpeed = 20
    --Reidskie's invulnerability when hit
    self.invulnDuration = 0
    --the velocity at which Reidskie gets knocked back when hit
    self.knockVel = vec2(0,0)
    
    self.currentPowerupName = ""
    
    -- Attack duration
    self.powerupDuration = 0.3
    -- Current Time
    self.powerupCurrentTime = 0
    -- end time, which is a combination of current and duration
    self.powerupEndTime = self.powerupCurrentTime + self.powerupDuration

    --just a parameter that watches for Reid's health
    --parameter.watch("ReidskieHealth")
end

--
--
-- REIDSKIE MOVEMENT
--
--

function Reidskie:move(dir)
    --self.movementSpeed = 20
    -- new position vec2 which takes a point, adds whichever direction it's moving multiplied by speed
    newPos = self.position + dir * self.movementSpeed
    -- reposition if knockVel is more than 0 (see below)
    newPos = newPos + self.knockVel
    --if Reidskie is not moving:
    if(self.currentAttack == nil) then
        --set sprite to "back" if the newPos.x is less than the old x position
        if(self.position.x > newPos.x) then
            sprite("Dropbox:reidskie-back", self.position.x + 5, self.position.y + 25, self.size + 20)
        --set sprite to forward if the opposite
        elseif(self.position.x < newPos.x) then
            sprite("Dropbox:reidskie-forward", self.position.x + 5, self.position.y + 25, self.size + 20)
        --otherwise set the sprite to normal
        elseif (self.invulnDuration > 0) then
            sprite("Dropbox:reidskie-hit", self.position.x + 5, self.position.y + 25, self.size + 20)
        else
            sprite("Dropbox:reidskie-normal", self.position.x + 5, self.position.y + 25, self.size + 20)        
        end
    end
    -- detect if sprite is colliding with the world
    if world:isColliding(newPos) then
        -- hit wall, do nothing
    -- otherwise, set new position
    else
        self.position = newPos
    end
    
    --set knock velocity easing
    self.knockVel = self.knockVel * 0.7
    
end

--
--
-- REIDSKIE COMBAT
--
--

--When Reidskie attacks!
function Reidskie:attack()
    --with Reidskie is not currently attacking
    if self.currentAttack == nil then
        --play sound
        sound(SOUND_SHOOT, 195)
        -- call ReidskieAttack method using self as hero and attackpower
        self.currentAttack = ReidskieAttack(self,self.attackPower)
    end
end

--When Reidskie gets hit
function Reidskie:applyDamageFromPoint(point, damage)
    --if not invulnerable
    if self.invulnDuration == 0 then
        --apply damage to health
        self.health = math.max(self.health - damage, 0)
        --determine a line between Reidskie and the damaging point (enemy)
        line = self.position - point
        --normalize the math
        line = line:normalize()
        --set invulnerability duration
        self.invulnDuration = 0.5
        --set knock velocity, initial knock velocity plus direction (line) plus speed
        self.knockVel = self.knockVel + line * 20
        
    end
end

--apply damage at point
function Reidskie:damageAtPoint(reidAttack, enemy)
    --reidPosition = reid
    reid = reidAttack
    enemyPosition = enemy
    
    --print(enemy.position)
   
    -- if currently attacking
    if self.currentAttack then
         distToEnemy = self.currentAttack.bullet.position:dist(enemyPosition.position)
         --hit range
         if distToEnemy <= 50 then
             return 10
        end
    end
    
    return 0
end

-- apply powerup to Reidskie
function Reidskie:applyPowerup(powerup)
    
    paramString = powerup.param
    
    -- handle bonuses
    if paramString == "movementSpeed" then
        self.movementSpeed = self.movementSpeed + powerup.amount
    elseif paramString == "attackPower" then
        self.attackPower = self.attackPower + powerup.amount
    elseif paramString == "health" then
        self.health = self.health + powerup.amount
    end
end

--
--
-- REIDSKIE STATUS
--
--

--When Reidskie is dead :(
function Reidskie:isDead()
    -- return health as 0
    return self.health == 0
end

-- Draw Reidskie dead
function Reidskie:drawDead()
    changeScreen(ScreenGameOver())
end

-- Reidskie draw
function Reidskie:draw()
    -- set invulnarability
    self.invulnDuration = math.max(self.invulnDuration - 1/60, 0)
    -- set movement based on gyroscope plus easing
    moveVec = vec2(Gravity.x, Gravity.y) + vec2(0,0.6)
    
    --move
    self:move(moveVec)

    pushStyle()
    
    --if attacking, draw attacking
    if self.currentAttack then
        self.currentAttack:draw()
        --when attacking finishes, set current attack to nil
        if self.currentAttack:isDone() then
            self.currentAttack = nil
        end    
    end
    
    --apply tint for invulnarability
    tintForInvulnDuration(self.invulnDuration)
    
    popStyle()
    
    --set health
    ReidskieHealth = self.health
end

-- When touched
function Reidskie:touched(touch)
    -- call attack if touch has ended
    if touch.state == ENDED then
        self:attack()
    end
end
