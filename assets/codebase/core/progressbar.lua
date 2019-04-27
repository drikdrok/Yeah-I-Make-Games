progressbar = class("progressbar")

function progressbar:initialize(x, y)
	self.x = x
	self.y = y

	self.image = love.graphics.newImage("assets/gfx/ui/progressbar.png")


	self.progress = 0
end

function progressbar:update(dt)

end

function progressbar:draw()
	love.graphics.setColor(1,1,1)
	love.graphics.draw(self.image, self.x, self.y, 0, game.scale)
	love.graphics.setColor(0,1,0)
	love.graphics.rectangle("fill", self.x + game.scale, self.y + game.scale, self.progress * game.scale, game.scale)
end

function progressbar:setProgress(progress)
	self.progress = progress
end