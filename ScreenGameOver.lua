ScreenGameOver = class()

function ScreenGameOver:init()
    self.frame = 0
end

function ScreenGameOver:tick()
    -- old code for changing the screen on a timer. might come in handy later
    --self.frame = self.frame + 1
    --if self.frame > 100 then
        --changeScreen(ScreenTitle())
    --end
end

function ScreenGameOver:draw()
    sprite("Dropbox:gameoverscreen", WIDTH/2, HEIGHT/2)
    fill(255,255,255,255)
    fontSize(30)
    text("You killed " .. playerPoints .. " BoBos", WIDTH/2, 30)
end

function ScreenGameOver:touched(touch)
    if touch.y < HEIGHT/5 then
        changeScreen(ScreenTitle())
    end
end