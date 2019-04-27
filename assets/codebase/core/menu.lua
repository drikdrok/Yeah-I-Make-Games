menu = class("menu")

function menu:initialize()
	local width = game.font:getWidth("New Game") + 16 * game.scale
	self.startButton = button:new("New Game", game.width / 2 - width / 2, 25 * game.scale, width, game.font:getHeight("New Game") + 6 * game.scale, function()
		self.message = ""
	
		game:reset()
		
		game.state = "popup"
		game.popup = popup:new("Select difficulty", game.width / 2 - 48*game.scale / 2, game.height / 2 - 16 * game.scale / 2)		
	
		local x = game.width / 2

		local buttonWidth = game.font:getWidth("Realistic") + 5 * game.scale
		local buttonHeight = game.font:getHeight("Realistic") + 3 * game.scale
		local button1X = x - buttonWidth - 2 * game.scale
		local button2X = x + 2 * game.scale

		game.popup:addButton(button:new("Easy", button1X, 28 * game.scale, buttonWidth, buttonHeight, function()
			game.difficulty = 0.5
			game.state = "paused"
		end))

		game.popup:addButton(button:new("Realistic", button2X, 28 * game.scale, buttonWidth, buttonHeight, function()
			game.difficulty = 1
			game.state = "paused"
		end))

	end)


	self.exitButton = button:new("Quit game", game.width / 2 - width / 2, 35 * game.scale, width, game.font:getHeight("Quit Game") + 6 * game.scale, function()
		self.message = "Don't quit during the showcase!"
		love.event.quit()
	end)


	self.message = ""


end

function menu:update(dt)
	self.startButton:update()
	self.exitButton:update()
end

function menu:draw()
	love.graphics.printf("Christian Schwenger, Nordic Game Jam 2019", 1.5 * game.scale, game.height - game.font:getHeight("Christian Schwenger Nordic Game Jam 2019") - 3 * game.scale, 25 * game.scale, "left")

	game:fontSize(9 * game.scale)
	love.graphics.print("Yeah,", game:findMiddle("Yeah,"), 4 * game.scale)
	game:fontSize(5 * game.scale)
	love.graphics.print("I make games", game:findMiddle("I make games"), 13.5 * game.scale)

	game:fontSize(1.7 * game.scale)
	love.graphics.print(self.message, game:findMiddle(self.message), 45 * game.scale)


	self.startButton:draw()
	self.exitButton:draw()

end

function menu:mousepressed(button)
	if button == 1 then
		if self.startButton.mouseOver then 
			self.startButton:click()
		elseif self.exitButton.mouseOver then 
			self.exitButton:click()
		end
	end
end