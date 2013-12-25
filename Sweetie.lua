Sweetie = class()

--Initialize Sweetie
function Sweetie:init(reid, pos)
    -- set reid
    self.reid = reid
    -- monster position
    self.position = pos

    --size
    self.size = 60
    -- set hit radius (the radius in which a monster uses to attack)
    self.hitRadius = MonsterHitRadius
    
    animationCuteLook = Animate({"Dropbox:elsie-cute-1",
                           "Dropbox:elsie-cute-2",
                           "Dropbox:elsie-cute-3",
                           "Dropbox:elsie-cute-4",
                           "Dropbox:elsie-cute-3",
                           "Dropbox:elsie-cute-2"},
                            10)
    
    animationSexyDance = Animate({"Dropbox:elsie-dance-1",
                           "Dropbox:elsie-dance-2",
                           "Dropbox:elsie-dance-3",
                           "Dropbox:elsie-dance-4",
                           "Dropbox:elsie-dance-5",
                           "Dropbox:elsie-dance-4",
                           "Dropbox:elsie-dance-3",
                           "Dropbox:elsie-dance-2"},
                            10)
    
    animationToot = Animate({"Dropbox:elsie-toot-1",
                           "Dropbox:elsie-toot-2",
                           "Dropbox:elsie-toot-3",
                           "Dropbox:elsie-toot-4",
                           "Dropbox:elsie-toot-5",
                           "Dropbox:elsie-toot-6",
                           "Dropbox:elsie-toot-7"},
                            10)
                        
    animationKiss = Animate({"Dropbox:elsie-kiss-1",
                           "Dropbox:elsie-kiss-2",
                           "Dropbox:elsie-kiss-3",
                           "Dropbox:elsie-kiss-4",
                           "Dropbox:elsie-kiss-5",
                           "Dropbox:elsie-kiss-6"},
                            10)
end

--AI to move to Reid when Reid is nearby
function Sweetie:moveToReid()
    -- create line between monster and reid
    line = self.reid.position - self.position
    -- normalize math
    line = line:normalize()
    --set position to follow line @ speed
    self.position = self.position + line * 3

    --need some kind of normalizing   
    if self.position.x >= self.reid.position.x and self.position.y >= self.reid.position.y then
        self.position.x = self.reid.position.x - 1
        self.position.y = self.reid.position.y - 1
    end
    
end

--Draw Monster
function Sweetie:draw()
    
    pushStyle()
    
    self:moveToReid()
    
    self:detectPowerup()
    
    popStyle()
    
end

function Sweetie:detectPowerup()
    if reid.currentPowerupName == "cuteLook" then
        animationCuteLook:setFrameDelay(10)
        animationCuteLook:draw(self.position.x - 100, self.position.y - 60, 30) 
    elseif reid.currentPowerupName == "sexyDance" then
        animationSexyDance:setFrameDelay(10)
        animationSexyDance:draw(self.position.x - 100, self.position.y - 60, 30) 
    elseif reid.currentPowerupName == "toot" then
        animationToot:setFrameDelay(10)
        animationToot:draw(self.position.x - 100, self.position.y - 60, 30)
    elseif reid.currentPowerupName == "kiss" then
        animationKiss:setFrameDelay(10)
        animationKiss:draw(self.position.x - 100, self.position.y - 60, 30)
    else
       sprite("Dropbox:elsie-normal", self.position.x - 60, self.position.y - 30, self.size) 
    end
end

function Sweetie:touched(touch)
end
