GameMessage = class()

function GameMessage:init()
    -- you can accept and set parameters here
    self.messageText = ""
    self.position = vec2(WIDTH/1.75, HEIGHT/8)
end

function GameMessage:draw()
    -- Draw window background
    sprite("Dropbox:messagebox", WIDTH/1.75, HEIGHT/8)
    font("Helvetica")
    fontSize(26)
    fill(255,255,255,255)
    text(self.messageText, self.position.x, self.position.y)
end

function GameMessage:touched(touch)
    -- Codea does not automatically call this method
end