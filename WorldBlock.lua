WorldBlock = class()

-- enumerate block types
FLOOR = 0
WALL = 1

-- init with type and position
function WorldBlock:init(type,x,y)
    -- type
    self.type = type
    -- size
    self.size = vec2(100, 90)
    --position
    self.position = vec2(x,y)
    -- tint?
    self.tint = color(255,255,255,255)
    -- get actual position as a vec2
    self.actualPosition = vec2(self.position.x * self.size.x - 20, self.position.y * self.size.y)
end

-- determine if there is a collision
function WorldBlock:isColliding(point)
    -- lower left
    ll = self.actualPosition - self.size * 0.5
    --upper right
    ur = self.actualPosition + self.size * 0.5
    
    -- return true if the point comes within bounds of block
    if point.x > ll.x and point.x < ur.x and
       point.y > ll.y and point.y < ur.y then
        return true
    end
    --otherwise return false
    return false
end

-- draw block
function WorldBlock:draw()

    -- depending on type of block, draw the appropriate block
    if self.type == FLOOR then
        sprite("Dropbox:skyblock", self.actualPosition.x, self.actualPosition.y)
    elseif self.type == WALL then
        sprite("Dropbox:cloudblock", self.actualPosition.x, self.actualPosition.y)
    end
end

function WorldBlock:touched(touch)
end
