ScreenWin = class()

function ScreenWin:init(x)
    -- you can accept and set parameters here
    self.frame = 0
end

function ScreenWin:tick()
    --self.frame = self.frame + 1
    --if self.frame > 100 then
        --changeScreen(ScreenGame())
    --end
end

function ScreenWin:draw()
    sprite("Dropbox:winscreen", WIDTH/2, HEIGHT/2)
end

function ScreenWin:touched(touch)
    if touch.y < HEIGHT/5 then
        changeScreen(ScreenTitle())
    end
end
