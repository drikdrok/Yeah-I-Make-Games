--Beware! Barely any comments in this code. Who has time for commenting in a game jam?
--Made for Nordic Game Jam 2019

love.graphics.setDefaultFilter("nearest", "nearest")
math.randomseed(os.time())
require("assets/codebase/core/require")

function love.load()
	game = game:new()
	typing = typing:new()
	menu = menu:new()


	require("assets/codebase/misc/phoneEvents") -- We have this here because game needs to be initialized
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	game:draw()
end

function love.keypressed(key)
	game:keypressed(key)
end

function love.mousepressed(x, y, button)
	game:mousepressed(button)
end