Monster = class()

--Initialize Monster
function Monster:init(reid, pos)
    -- set reid
    self.reid = reid
    -- monster position
    self.position = pos
    -- monster health
    self.health = 20
    -- is dead?
    self.dead = false
    -- shake amount for when hit
    self.shakeAmount = 0
    -- opacity for death
    self.opacity = 255
    -- "aggression radius" to determine when to attack reid
    self.aggressionRadius = 200
    -- knock velocity for when hit
    self.knockVel = vec2(0,0)
    -- invulnerability
    self.invulnDuration = 0
    --size
    self.size = vec2(50,50)
    -- The radius in which BoBo can be hit 
    MonsterHitRadius = 60
    -- set hit radius (the radius in which a monster uses to attack)
    self.hitRadius = MonsterHitRadius
    -- adds to the world monster count
    monsterCount = monsterCount + 1
end

--AI to move to Reid
function Monster:moveToReid()
    -- create line between monster and reid
    line = self.reid.position - self.position
    -- normalize math
    line = line:normalize()
    --set position to follow line @ speed
    self.position = self.position + line * 2
end

--AI to move away from Reid
function Monster:moveAwayFromReid(amount)
    -- create line between monster and reid
    line = self.position - self.reid.position
    -- normalize math
    line = line:normalize()
    -- set knockback
    self.knockVel = self.knockVel + line * amount
end

-- Shake when damaged
function Monster:shake()
    self.shakeAmount = 3
end

--Draw Monster
function Monster:draw()
    -- set monster hit radius
    self.hitRadius = MonsterHitRadius
    --set invulnerability
    self.invulnDuration = math.max(self.invulnDuration - 1/60, 0)
    -- if dead draw death animation
    if self.dead then
        pushStyle()
        
        pushMatrix()
        
        translate(self.position.x, self.position.y + -20)
        scale(1,-1)
        tint(190*self.opacity/255,self.opacity)
        sprite("Dropbox:bobo", 0,0, 60)
        popMatrix()
        
        self.opacity = self.opacity * 0.98

        popStyle()
        
        
    else
        --get distance to reid
        distToReid = self.reid.position:dist(self.position)
        -- if distance to reid is less than the monsters hit radius, and invulnerability is off
        if distToReid < self.hitRadius and self.invulnDuration == 0 then
            -- damage hero
            self.reid:applyDamageFromPoint(self.position, 10)
        end
        
        -- apply damage from reid
        damage = self.reid:damageAtPoint(self.reid, self)
        -- if damage isn't 0 and invulnerability is off
        if damage > 0 and self.invulnDuration == 0 then
            -- move away from reid
            self:moveAwayFromReid(damage)
            -- apply health damage
            self.health = self.health - damage
            -- set invulnerability
            self.invulnDuration = 0.5
            -- shake animation
            self:shake()
            -- if health is depleted set dead to true
            if self.health <= 0 then
                self.dead = true
                -- add to total player points
                playerPoints = playerPoints + 1
                -- add to world monster count
                monsterCount = monsterCount - 1
            end
        end
        
        self:moveToReid()
        
        -- reposition based on knockback velocity
        self.position = self.position + self.knockVel
        self.knockVel = self.knockVel * 0.7

        pushStyle()
        
        -- set invulnerability tint
        tintForInvulnDuration(self.invulnDuration)
        -- shake shake shake!!
        shake = vec2(math.random() * self.shakeAmount, math.random() * self.shakeAmount)
        -- draw enemy
        sprite("Dropbox:bobo", self.position.x + shake.x, self.position.y + 35 + shake.y, 60) 
        
        popStyle()
    end
    --set shake amount
    self.shakeAmount = self.shakeAmount * 0.582
end

function Monster:touched(touch)
end
