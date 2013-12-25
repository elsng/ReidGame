-- supports only Landscape
supportedOrientations(LANDSCAPE_ANY)
-- turn off dev options
DEV_MODE = false
-- we will be managing screens with this
screen = nil

--function to change to a screen
function changeScreen(s)
    screen = s
end

function setup()
	-- remove HUD
    displayMode(FULLSCREEN_NO_BUTTONS)
    -- start with title screen
    changeScreen(ScreenTitle())
end

function draw()
	-- get ticker (if any)
    screen:tick()
    -- draw the screen
    screen:draw()
end

function touched(t)

end