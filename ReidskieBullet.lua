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
    -- only draw the bullet if it's within the canvas
    if self.position.x < WIDTH then
        self.position.x = self.position.x + 6 * 10
        sprite("Dropbox:bullet", self.position.x, self.position.y, self.size)
        -- returns the position of the bullet for use in hit detection
        self:returnPos()
    end
end

function ReidskieBullet:returnPos()
    return vec2(self.position.x, self.position.y)
end

function ReidskieBullet:touched(touch)
    -- Codea does not automatically call this method
end
