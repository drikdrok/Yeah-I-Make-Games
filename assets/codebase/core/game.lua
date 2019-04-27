game = class("key")

function game:initialize()
	--Images
	self.backgroundImage = love.graphics.newImage("assets/gfx/sprites/background.png")
	self.computerImage = love.graphics.newImage("assets/gfx/sprites/computer.png")

	self.handsImages = {
		love.graphics.newImage("assets/gfx/sprites/hands1.png"),
		love.graphics.newImage("assets/gfx/sprites/hands2.png")
	}

	self.panelImage = love.graphics.newImage("assets/gfx/ui/panel.png")

	self.phonesImages = {
		love.graphics.newImage("assets/gfx/sprites/phone1.png"),
		love.graphics.newImage("assets/gfx/sprites/phone2.png")
	}
	self.phoneImage = 1
	self.phoneState = 0

	--Sounds
	self.vibrateSound = love.audio.newSource("assets/sfx/vibration.mp3", "static")



	self.width = love.graphics.getWidth()
	self.height = love.graphics.getHeight()

	self.scale = love.graphics.getWidth() / 100

	self.fonts = {}
	self.font = 0
	self:fontSize(1.7 * self.scale)

	self.stages = require("assets/codebase/misc/stages")
	

	self:reset()
end

function game:update(dt)
	if self.state == "playing" then 
		typing:update(dt)

		if self.progress > 10 then
			self.progress = 0
			self.stage = self.stage + 1
			self:addMotivation(1.5)

			if self.stage == 8 then  -- Finish game
				self.state = "popup"
				self.popup = popup:new("After years of blood, sweat and tears, you have finished a game. You thought you were gonna be happy now. Yet the cycle starts anew...", game.width / 2 - 48 * self.scale / 2, game.height / 2 - 16 * self.scale / 2)
				createOKButton(self.popup, function()


					self.state = "paused"
					self.popup = "none"
					typing:reset()
					self.floatingNumbers = {}

					if self.stage > self.bestStage then -- Best game
						self.bestStage = self.stage
						self.bestGame = self.gameNumber
					end

					self.motivation = 10
					self.motivationbar:setProgress(10)
					self.gameNumber = self.gameNumber + 1
					self.stage = 1
					self.progress =  0
					self.progressProgressbar:setProgress(0)
				end)

			end
		end

		self.motivation = self.motivation - (1 * self.difficulty + self.stage / 10) * dt

		if self.motivation < 0 then  --Lose motivation, start new game
			self.popup = popup:new("You lost motivation for your project, and started on a new idea!", game.width / 2 - 48 * self.scale / 2, game.height / 2 - 16 * self.scale / 2)
			createOKButton(self.popup, function ()
					self.state = "paused"
					self.popup = "none"
					typing:reset()
					self.floatingNumbers = {}

					if self.stage > self.bestStage then -- Best game
						self.bestStage = self.stage
						self.bestGame = self.gameNumber
					end

					self.motivation = 10
					self.motivationbar:setProgress(10)
					self.gameNumber = self.gameNumber + 1
					self.stage = 1
					self.progress =  0
					self.progressProgressbar:setProgress(0)

				end)

			self.state = "popup"
			self.motivation = 0
		end	


		self.progressProgressbar:setProgress(self.progress)
		self.motivationbar:setProgress(self.motivation)

		self.timer = self.timer + dt
		if self.timer >= 1 then
			self.timer = 0
			if math.random(1, 25) == 2 then -- Phone Event
				self.state = "popup"
				self.popup = phoneEvents[math.random(1, #phoneEvents)]()
				self.phoneImage = 2
				self.phoneState = 1
				self.vibrateSound:play()
			end
		end
	elseif self.state == "popup" then 
		self.popup:update()

		self.timer = self.timer + dt
		if self.timer > 0.3 then 
			self.timer = 0 
			if self.phoneState > 0 then 
				self.phoneState = self.phoneState + 1 -- Phone vibration
				if self.phoneState == 2 then
					self.phoneImage = 1
				elseif self.phoneState == 3 then 
					self.phoneImage = 2
				elseif self.phoneState == 4 then 
					self.phoneImage = 1
					self.phoneState = 0
				end
			end
		end

	elseif self.state == "menu" then 
		menu:update()
	end

	for i,v in pairs(self.floatingNumbers) do
		v.y = v.y - self.scale * dt
		v.lifetime = v.lifetime - dt
		if v.lifetime < 0 then 
			self.floatingNumbers[v.id] = nil
		end
	end
end

function game:draw()
	love.graphics.draw(self.backgroundImage, 0, -10 * self.scale, 0, self.scale)
	love.graphics.draw(self.computerImage, self.width / 2 - self.computerImage:getWidth() * self.scale / 2, 11 * self.scale, 0, self.scale)
	love.graphics.draw(self.handsImages[self.handsImage], self.width / 2 - self.handsImages[self.handsImage]:getWidth() / 2 - 6 * self.scale, 38 * self.scale - 5, 0, self.scale)
	love.graphics.draw(self.phonesImages[self.phoneImage], 63 * self.scale, 34 * self.scale, 0, self.scale)

	if self.state == "paused" then 
		love.graphics.print("Begin!", self:findMiddle("Begin!"), 5 * self.scale)
	end

	--Panel
	if self.state ~= "menu" then 
		love.graphics.draw(self.panelImage, 2 * self.scale, 2 * self.scale, 0, self.scale)
		love.graphics.setColor(0,0,0)

		local x = 3.5 * self.scale
		love.graphics.print("Game #"..self.gameNumber, x, 3 * self.scale)
		love.graphics.print("Stage: "..self.stages[self.stage], x, 6* self.scale)
		love.graphics.print("Progress", x, 9 * self.scale)
		love.graphics.print("Motivation", x, 17 * self.scale)

		if self.bestGame > 0 then 
			love.graphics.print("Best Game: #"..self.bestGame, x, 24 * self.scale)
			love.graphics.printf("Reached "..self.stages[self.bestStage], x, 27 * self.scale, 19 * self.scale, "left")
		end
		self.progressProgressbar:draw()
		self.motivationbar:draw()


		typing:draw()
	end


	for i,v in pairs(self.floatingNumbers) do
		love.graphics.setColor(1,1,1, v.lifetime)
		love.graphics.print(v.text, v.x, v.y)
	end

	love.graphics.setColor(1,1,1)


	if self.state == "popup" then 
		self.popup:draw()
	end

	if self.state == "menu" then 
		menu:draw()
	end	
end

function game:keypressed(key)
	if self.state == "playing" or self.state == "paused" then 
		if self.handsImage == 1 then 
			self.handsImage = 2
		else
			self.handsImage = 1
		end

		typing:keypressed(key)

		if self.state == "paused" then
			self.state = "playing"
		end

		if key == "escape" then 
			game.state = "popup"
			game.popup = popup:new("Exit to main menu? All progress will be lost!", self.width / 2 - 48 * self.scale / 2, self.height / 2 - 16 * game.scale / 2)
		
			local x = game.width / 2

			local buttonWidth = game.font:getWidth("Yes") + 5 * game.scale
			local buttonHeight = game.font:getHeight("No") + 3 * game.scale
			local button1X = x - buttonWidth - 2 * game.scale
			local button2X = x + 2 * game.scale

			self.popup:addButton(button:new("Yes", button1X, 28 * self.scale, buttonWidth, buttonHeight, function()
				self.state = "menu"
				self.popup = "none"
			end))

			self.popup:addButton(button:new("No", button2X, 28 * self.scale, buttonWidth, buttonHeight, function()
				self.state = "paused"
				self.popup = "none"
			end))
		end


	elseif self.state == "popup" then 
		self.popup:keypressed(key)
	end
end

function game:mousepressed(button)
	if self.state == "popup" then 
		self.popup:mousepressed(button)
	elseif self.state == "menu" then
		menu:mousepressed(button)
	end
end	

function game:fontSize(size)
	local font
	local size = math.floor(size)
	if self.fonts[size] then 
		font = self.fonts[size]
	else
		font = love.graphics.newFont("assets/gfx/fonts/pixelmix.ttf", size)
		self.fonts[size] = font
	end
	self.font = font
	love.graphics.setFont(font)
end

function game:findMiddle(text)
	return self.width / 2 - self.font:getWidth(text) / 2
end

function game:newFloatingNumber(number)
	table.insert(self.floatingNumbers, 
		{
			text = number, 
			x = self:findMiddle("hello") + math.random(-10 * self.scale, 10 * self.scale), 
			y = 8 * self.scale,
			lifetime = 2,
			id = #self.floatingNumbers+1
		})
end	

function game:addMotivation(motivation)
	self.motivation = self.motivation + motivation
	if self.motivation > 10 then
		self.motivation = 10
	end
end

function game:reset()
	self.handsImage = 1

	self.gameNumber = 1

	self.state = "menu"

	self.popup = "none"

	self.stage = 1
	self.bestGame = 0
	self.bestStage = 0

	self.progress = 0
	self.progressProgressbar = progressbar:new(3.5 * self.scale, 12 * self.scale) --progressProgressbar lol
	self.motivation = 10
	self.motivationbar = progressbar:new(3.5 * self.scale, 20 * self.scale)

	self.timer = 0

	self.difficulty = 1

	self.floatingNumbers = {}
end