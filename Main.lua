supportedOrientations(LANDSCAPE_ANY)
DEV_MODE = false
screen = nil

function changeScreen(s)
    screen = s
end

function setup()
    displayMode(FULLSCREEN_NO_BUTTONS)
    changeScreen(ScreenTitle())
end

function draw()
    screen:tick()
    screen:draw()
end

function touched(t)
    if screen.touched ~= nil then
        screen:touched(t)
    end
end