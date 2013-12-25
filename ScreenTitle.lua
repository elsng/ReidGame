ScreenTitle = class()

function ScreenTitle:init()
    self.frame = 0
end

function ScreenTitle:tick()
    --self.frame = self.frame + 1
    --if self.frame > 100 then
        --changeScreen(ScreenGame())
    --end
end

function ScreenTitle:draw()
    sprite("Dropbox:startscreen", WIDTH/2, HEIGHT/2)
end

function ScreenTitle:touched(touch)
    if touch.y > HEIGHT/2 then
        changeScreen(ScreenGame())
    end
end