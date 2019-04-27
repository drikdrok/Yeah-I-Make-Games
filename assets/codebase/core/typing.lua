typing = class("typing") 

function typing:initialize()
	self.words = require("assets/codebase/misc/words")
	self.keys = require("assets/codebase/misc/keys")

	self.keySounds = {}
	for i=1, 19 do
		table.insert(self.keySounds, love.audio.newSource("assets/sfx/key"..i..".mp3", "static"))
	end

	self:reset()
end

function typing:update(dt)
	if self.wordTyped == self.wordToType then -- Finish word
		self.wordTyped = ""
		self.wordToType = self.futureWordsToType[1]
		table.remove(self.futureWordsToType, 1)
		table.insert(self.futureWordsToType, self.words[math.random(1, #self.words)])

		game.progress = game.progress + 1
		game:addMotivation(1)
		game:newFloatingNumber("+1")
	end
end

function typing:draw()
	love.graphics.setColor(1,1,1)
	love.graphics.print(self.wordToType, game:findMiddle(self.wordToType), 13 * game.scale)

	for i,v in pairs(self.futureWordsToType) do
		love.graphics.setColor(1,1,1, 1-i/4)

		love.graphics.print(v, game:findMiddle(v), (13 + 2.2*i) * game.scale)
	end

	for i = 1, self.wordTyped:len() do
		local color = {1,0,0}
		if self.wordTyped:sub(i, i) == self.wordToType:sub(i, i) then 
			color = {0,1,0}
		end

		love.graphics.setColor(color)
		local x = game:findMiddle(self.wordToType) + game.font:getWidth(self.wordToType:sub(1, i-1))
		love.graphics.print(self.wordToType:sub(i, i), x, 13 * game.scale)
	end

--	love.graphics.print(self.wordTyped, game.width / 2 - game.font:getWidth(self.wordToType) / 2, 13 * game.scale)
	love.graphics.setColor(1,1,1)
end


function typing:keypressed(key)
	if self.keys[key] and self.wordTyped:len() < self.wordToType:len() then 
		self.wordTyped = self.wordTyped..key
		self.keySounds[math.random(1, #self.keySounds)]:play()
	end

	if key == "backspace" then 
		self.wordTyped = self.wordTyped:sub(1, -2)
		self.keySounds[math.random(1, #self.keySounds)]:play()
	end
end	

function typing:reset()
	self.futureWordsToType = {self.words[math.random(1, #self.words)], self.words[math.random(1, #self.words)], self.words[math.random(1, #self.words)]}
	self.wordToType = self.words[math.random(1, #self.words)]
	self.wordTyped = ""
end	