popup = class("popup")

function popup:initialize(text, x, y)
	self.text = text 

	self.x = x
	self.y = y

	self.image = love.graphics.newImage("assets/gfx/ui/losePanel.png")

	self.buttons = {}
end

function popup:update(dt)
	for i,v in pairs(self.buttons) do
		v:update()
	end	
end

function popup:draw()
	love.graphics.draw(self.image, self.x, self.y, 0, game.scale)
	love.graphics.setColor(0,0,0)
	love.graphics.printf(self.text, self.x + 2 * game.scale, self.y + 2 * game.scale, self.image:getWidth() * game.scale - 4 * game.scale, "left")
	love.graphics.setColor(1,1,1)
	
	for i,v in pairs(self.buttons) do
		v:draw()
	end
end

function popup:addButton(button)
	table.insert(self.buttons, button)
end

function popup:mousepressed(button)
	if button == 1 then
		for i,v in pairs(self.buttons) do
			if v.mouseOver then 
				v:click()
			end
		end	
	end
end

function popup:keypressed(key)
	if key == "return" then 
		for i,v in pairs(self.buttons) do
			if v.canEnter then 
				v:click()
			end
		end
	end
end