button = class("button")

local buttonSound = love.audio.newSource("assets/sfx/buttonClick.mp3", "static")

function button:initialize(text, x, y, width, height, execute, canEnter)
	self.text = text
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.execute = execute

	self.mouseOver = false

	self.canEnter = canEnter or false

end

function button:update(dt)
	local mouseX, mouseY = love.mouse.getPosition()

	if mouseX > self.x and mouseX < self.x + self.width and mouseY > self.y and mouseY < self.y + self.height then 
		self.mouseOver = true
	else
		self.mouseOver = false
	end
end

function button:draw()
	love.graphics.setLineWidth(game.scale)
	love.graphics.setLineStyle("rough")

	love.graphics.setColor(216/255, 133/255, 95/255)
	love.graphics.rectangle("line", self.x + game.scale/2, self.y + game.scale/2, self.width - game.scale, self.height - game.scale)
	love.graphics.setColor(1, 217/255, 142/255)
	love.graphics.rectangle("fill", self.x + game.scale, self.y + game.scale, self.width - 2 * game.scale, self.height - 2 *game.scale)

	if self.mouseOver then 
		love.graphics.setColor(0,0,0, 0.6)
		love.graphics.rectangle("fill", self.x + game.scale, self.y + game.scale, self.width - 2 * game.scale, self.height - 2 *game.scale)
	end
	love.graphics.setColor(0,0,0)

	love.graphics.print(self.text, self.x + self.width / 2 - game.font:getWidth(self.text) / 2, self.y + self.height / 2 - game.font:getHeight(self.text) / 2)
	love.graphics.setColor(1,1,1)
end	

function button:click()
	buttonSound:play()
	self:execute()
end

function createOKButton(popup, execute)
	local width = game.font:getWidth("OK") + 6 * game.scale
	popup:addButton(button:new("OK", game.width / 2 - width / 2, popup.y + 9 * game.scale, width, 5 * game.scale, execute, true))
end

