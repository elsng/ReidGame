ReidskieBullet = class()

function ReidskieBullet:init(reid)
    -- you can accept and set parameters here
    self.duration = 0.6
    -- Current Time
    self.currentTime = 0
    -- end time, which is a combination of current and duration
    self.endTime = self.currentTime + self.duration
    
    self.reid = reid
    self.position = vec2(self.reid.position.x,self.reid.position.y)
    
    self.size = reid.attackPower * 8
end

function ReidskieBullet:draw()
    --self.currentTime = self.currentTime + 1/30
    --attackTime = (self.currentTime)/self.duration 
    -- Codea does not automatically call this method
    --self.position.y = self.reid.position.y
    
    if self.position.x < WIDTH then
        self.position.x = self.position.x + 6 * 10
        sprite("Dropbox:bullet", self.position.x, self.position.y, self.size)
        self:returnPos()
    end
end

function ReidskieBullet:returnPos()
    return vec2(self.position.x, self.position.y)
end

function ReidskieBullet:touched(touch)
    -- Codea does not automatically call this method
end
