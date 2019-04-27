local x = 45 * game.scale
local y = 15 * game.scale

local buttonY = y + 9 * game.scale

local middleX = game.width / 2 - 48 * game.scale / 2
local middleY = game.height / 2 - 16 * game.scale / 2  

phoneEvents = {
	function()
		local event = popup:new("Your friends invite you to go see a movie. Do you join?", x, y)

		local buttonWidth = game.font:getWidth("Skip") + 6 * game.scale
		local buttonHeight = game.font:getHeight("Skip") + 3 * game.scale
		local button1X = x + buttonWidth 
		local button2X = x + 48 * game.scale - 2 * buttonWidth
		event:addButton(button:new("Join", button1X, buttonY, buttonWidth, buttonHeight,
			function()
				local outcome = math.random(1, 4)
				if outcome == 1 or outcome == 2 then -- Good outcome
					game.popup = goodOutcome(1)
				elseif outcome == 3 then -- Bad Outcome
					game.popup = badOutcome(1)
				else
					game.popup = "none"
					game.state = "paused"
				end
			end))

		event:addButton(button:new("Skip", button2X, buttonY, buttonWidth, buttonHeight,
			function()
				local outcome = math.random(1, 7)
				if outcome == 1 or outcome == 2 then -- Good outcome
					game.popup = goodOutcome(2)
				elseif outcome == 3 then -- Bad Outcome
					game.popup = badOutcome(2)
				else
					game.popup = "none"
					game.state = "paused"
				end
			end))

		return event
	end,

	function()
		local event = popup:new("A new game has been released. Do you buy it?", x, y)

		local buttonWidth = game.font:getWidth("Yes") + 6 * game.scale
		local buttonHeight = game.font:getHeight("Yes") + 3 * game.scale
		local button1X = x + buttonWidth 
		local button2X = x + 48 * game.scale - 2 * buttonWidth
		event:addButton(button:new("Yes", button1X, buttonY, buttonWidth, buttonHeight,
			function()
				local outcome = math.random(1, 4)
				if outcome == 1 or outcome == 2 then -- Good outcome
					game.popup = goodOutcome(3)
				elseif outcome == 3 then -- Bad Outcome
					game.popup = badOutcome(3)
				else
					game.popup = "none"
					game.state = "paused"
				end
			end))

		event:addButton(button:new("No", button2X, buttonY, buttonWidth, buttonHeight,
			function()
				local outcome = math.random(1, 7)
				if outcome == 1 or outcome == 2 then -- Good outcome
					game.popup = goodOutcome(4)
				elseif outcome == 3 then -- Bad Outcome
					game.popup = badOutcome(4)
				else
					game.popup = "none"
					game.state = "paused"
				end
			end))

		return event
	end,

	function()
		local event = popup:new("Your friends invite you to a party. Do you go?", x, y)

		local buttonWidth = game.font:getWidth("Yes") + 6 * game.scale
		local buttonHeight = game.font:getHeight("Yes") + 3 * game.scale
		local button1X = x + buttonWidth 
		local button2X = x + 48 * game.scale - 2 * buttonWidth
		event:addButton(button:new("Yes", button1X, buttonY, buttonWidth, buttonHeight,
			function()
				local outcome = math.random(1, 4)
				if outcome == 1 or outcome == 2 then -- Good outcome
					game.popup = goodOutcome(5)
				elseif outcome == 3 then -- Bad Outcome
					game.popup = badOutcome(5)
				else
					game.popup = "none"
					game.state = "paused"
				end
			end))

		event:addButton(button:new("No", button2X, buttonY, buttonWidth, buttonHeight,
			function()
				local outcome = math.random(1, 7)
				if outcome == 1 or outcome == 2 then -- Good outcome
					game.popup = goodOutcome(5)
				elseif outcome == 3 then -- Bad Outcome
					game.popup = badOutcome(5)
				else
					game.popup = "none"
					game.state = "paused"
				end
			end))

		return event
	end,
}

goodPhoneResponses = {
	"The movie was so inspiring, you gain motivation!",
	"You're very productive in the hours you would have wasted. You gain motivation!",
	"The game is great, and you get a new idea for a mechanic for your game. You gain motivation!",
	"Instead of playing video games, you spend time working on the game. You gain motivation!",
	"You show a friend the game you're working on. He is very impressed! You gain motivation!",
	"You spend your time wisely, working on your game, instead of partying. You gain motivation!",
}

badPhoneResponses = {
	"The movie was so bad, you're left in a bad mood and lose motivation!",
	"You feel like you're missing out, debating if making this game is even worth it. You lose motivation!",
	"The game is so addicting, all you want to do is play it, instead of developing your game. You lose motivation!",
	"All your friends are playing the game, and you feel like you're missing out. You lose motivation!",
	"The following morning you are terribly hungover, you don't have motivation to work!",
	"You see how much fun your friends are having on social media. You feel like you're missing out. You lose motivation!",
}

function goodOutcome(number)
	local outcome = popup:new(goodPhoneResponses[number], middleX, middleY)
	createOKButton(outcome, function() 
		game:addMotivation(1)
		game:newFloatingNumber("+1")	
		
		game.popup = "none"
		game.state = "paused"
	end)

	return outcome
end

function badOutcome(number)
	local outcome = popup:new(badPhoneResponses[number], middleX, middleY)
	createOKButton(outcome, function() 
		game:addMotivation(-1)
		game:newFloatingNumber("-1")	

		game.popup = "none"
		game.state = "paused"
	end)

	return outcome
end
