Animate = class()
 
function Animate:init(frames, delay)
    self.frames = frames -- table of sprite names
    self.currentFrame = 1 -- the current frame
    self.frameDelay = delay -- how many iterations of main draw loop before changing frame
    self.count = 1 -- keeps track of iterations passed 
end
 
function Animate:draw(x, y)
    -- Increment the counter
    self.count = self.count + 1
    -- Check if frame should be updated
    if self.count > self.frameDelay then
        -- Reset count and increment current frame
        self.count = 1
        self.currentFrame = self.currentFrame + 1
        -- Check if we've reached the last frame
        if self.currentFrame > table.maxn(self.frames) then
            -- Back to first frame
            self.currentFrame = 1
        end
    end
    -- Draw correct frame
    sprite(self.frames[self.currentFrame], x, y) 
end
 
-- For the parameter
function Animate:setFrameDelay(newDelay)
    self.frameDelay = newDelay
end