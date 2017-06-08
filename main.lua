function love.draw()
	-- redraw the paddles
	love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", pad1x, pad1y, 25, 200)
    love.graphics.rectangle("fill", pad2x, pad2y, 25, 200)
    love.graphics.circle("fill", ballx, bally, 50, 100)
    love.graphics.print(p1score, 100, 10)
    love.graphics.print(p2score, width - 100, 10)

    if not (winner == "") then
		if winner == "p2" then
			love.graphics.printf("Player 2 Wins!!", width/2 - 100, 10, 200, "center")
		else
			love.graphics.printf("Player 1 Wins!!", width/2 - 100, 10, 200, "center")
		end
	end
end

function love.update(dt)
	-- calculate paddle locations from velocity, not over border
	if winner == "" then
		if pad1y < (height - 200) and velocityPad1 > 0 then
			pad1y = pad1y + velocityPad1
		elseif pad1y > 0 and velocityPad1 < 0 then
			pad1y = pad1y + velocityPad1 
		end
		if pad2y < (height - 200) and velocityPad2 > 0 then
			pad2y = pad2y + velocityPad2
		elseif pad2y > 0 and velocityPad2 <0 then
			pad2y = pad2y + velocityPad2
		end

		-- if the ball colides with wall or paddle, reverse corresponding velocity
		if bally <= 25 or bally >= height - 25 then
			velocityBally = velocityBally * -1
		end

		if ballx - 25 <= 25 and (bally + 25 >= pad1y and bally - 25 <= pad1y + 200) then
			velocityBallx = velocityBallx * -1
		end

		if ballx + 25 >= width - 25 and (bally + 25 >= pad2y and bally - 25 <= pad2y + 200) then
			velocityBallx = velocityBallx * -1
		end

		-- update ball location from velocity
		ballx = ballx + velocityBallx
		bally = bally + velocityBally

		-- determine if the ball is over the line, increment score, reset
		if ballx - 25 >= width then		
			p1score = p1score + 1
			if p1score >= 10 then
				winner = "p1"
				finish()
			else
				reset()
			end
		elseif ballx + 25 <= 0 then
			p2score = p2score + 1
			if p2score >= 10 then
				winner = "p2"
				finish()
			else
				reset()
			end
		end
	end
end

function reset()
	velocityBallx = velocityBallx * -1

	-- initialize the location of the ball
	ballx = width / 2
	bally = height / 2

	-- initialize velocity of each paddle
	velocityPad1 = 0
	velocityPad2 = 0

	-- initialize location of 1st paddle, top left corner
	pad1x = 0
	pad1y = height/2 - 100

	-- initialize location of 2nd paddle, bottom right corner
	pad2x = width - 25
	pad2y = height/2 - 100
end

function finish(player)
	velocityBallx = 0

	-- initialize the location of the ball
	ballx = width / 2
	bally = height / 2

	-- initialize velocity of each paddle
	velocityPad1 = 0
	velocityPad2 = 0

	-- initialize location of 1st paddle, top left corner
	pad1x = 0
	pad1y = height/2 - 100

	-- initialize location of 2nd paddle, bottom right corner
	pad2x = width - 25
	pad2y = height/2 - 100
end

function love.load()
	-- initialize winner
	winner = ""

	-- grab the height and width of the window, plus flags
	width, height, flags = love.window.getMode()

	-- initialize score
	p1score = 0
	p2score = 0

	-- initialize velocity of the ball
	velocityBallx = 7
	velocityBally = 7

	-- initialize the location of the ball
	ballx = width / 2
	bally = height / 2

	-- initialize velocity of each paddle
	velocityPad1 = 0
	velocityPad2 = 0

	-- initialize location of 1st paddle, top left corner
	pad1x = 0
	pad1y = height/2 - 100

	-- initialize location of 2nd paddle, bottom right corner
	pad2x = width - 25
	pad2y = height/2 - 100

	-- draw the initial paddles and ball
	love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", pad1x, pad1y, 25, 200)
    love.graphics.rectangle("fill", pad2x, pad2y, 25, 200)
    love.graphics.circle("fill", ballx, bally, 50, 100)

    -- draw the score 
    love.graphics.print(p1score, 100, 10)
    love.graphics.print(p2score, width - 100, 10)
end

function love.keypressed(key)
	if key == 'w' then
		velocityPad1 = -5
	elseif key == 's' then
		velocityPad1 = 5
	elseif key == 'i' then
		velocityPad2 = -5
	elseif key == 'k' then
		velocityPad2 = 5
	end
end

function love.keyreleased(key)
	if key == 'w' and not love.keyboard.isDown("s") then 
		velocityPad1 = 0
	elseif key == 's' and not love.keyboard.isDown("w") then 
		velocityPad1 = 0
	elseif key == 'i' and not love.keyboard.isDown("k") then 
		velocityPad2 = 0
	elseif key == 'k'and not love.keyboard.isDown("i")  then 
		velocityPad2 = 0	
	end
end