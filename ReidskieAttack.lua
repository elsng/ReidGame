ReidskieAttack = class()

--Initialize ReidskieAttack
function ReidskieAttack:init(reid, power)
    -- Attack duration
    self.duration = 0.6
    -- Current Time
    self.currentTime = 0
    -- end time, which is a combination of current and duration
    self.endTime = self.currentTime + self.duration
    -- requires Reid
    self.reid = reid
    -- sets size of shot
    self.size = reid.size
    -- set blast size
    self.blastSize = 50 + power
    -- current size of the blast
    self.currentSize = self.size
    -- get Reid's position
    self.position = reid.position
    --bullet Positions
    self.bullet = ReidskieBullet(reid)
end

--When ReidskieAttack is done
function ReidskieAttack:isDone()
    return self.currentTime > self.endTime*2
end

--Draw Reidskie attack
function ReidskieAttack:draw()
    self.currentTime = self.currentTime + 1/30
    
    pushStyle()
    
    fill(255,0,0)
    sprite("Dropbox:reidskie-attack", self.reid.position.x + 5, self.reid.position.y + 25, self.size + 30) 
    self.bullet:draw()
    popStyle()
end
