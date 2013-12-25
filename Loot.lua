Loot = class()

-- initialize loot
function Loot:init(pos)
    -- loot's initial position
    self.position = pos
    -- is it collected?
    self.collected = false
    -- math to change it's position when it gets collected
    self.rise = 0
    -- When created, world's loot counter goes up one
    lootCount = lootCount + 1
    
end

function Loot:collect(point)
    -- get distance between loot's position and a point
    dtg = point:dist(self.position)
    -- if distance is less than 50 (point plus the size of the loot), collect
    if dtg < 50 and not self.collected then
        sound(SOUND_PICKUP, 195)
        self.collected = true
        -- add to lootCollected counter
        lootCollected = lootCollected + 1
        -- subtract from the world loot counter
        lootCount = lootCount - 1
        return true
    end
    
    return false
end

--Draw loot
function Loot:draw()
    sprite("Dropbox:heart", self.position.x, self.position.y + 15 + self.rise, 60, 60)
    --when loot is collected, rise loot out of the canvas
    if self.collected then
        self.rise = self.rise + 15
    end
end

function Loot:touched(touch)
    
end
