ScreenWin = class()

function ScreenWin:init()
    self.frame = 0
end

function ScreenWin:tick()
    -- old code for changing the screen on a timer. might come in handy later
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
