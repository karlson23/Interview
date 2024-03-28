local Player = require 'playerClass'
local Bullets = require 'BulletClass'




player = Player:new(500,200,0,10,10, nil,150,5)

TableOfBullets = {}


function PlayerMoves(dt)
	cam:lookAt(player.x,player.y)
	cam:zoomTo(3)


	player.LastX = player.x
	player.LastY = player.y
	--Player Hits spring
	if player.JumpingOnSpring and player.canMove then
		player.SpringTimer = player.SpringTimer + player.SpringAdd * dt
		player.y = player.y - player.SpringYAdd * dt
	end

	if player.SpringTimer > player.SpringTime or player.TouchingBottomWall then
		player.SpringTimer = 0
		player.JumpingOnSpring = false
	end
	--Normal move mechanic
	
	
	if love.keyboard.isDown('d') and player.canMove and player.canWalk and not player.BouncingOnWall then
		player.x = player.x + player.Xvelocity * dt
		player.MovingLeft = false
		player.MovingRight = true
	end

	if love.keyboard.isDown('a') and player.canMove and player.canWalk and not player.BouncingOnWall  then

		player.x = player.x - player.Xvelocity * dt 
		player.MovingRight = false
		player.MovingLeft = true

	end


	-- player jumps
	if love.keyboard.isDown('space') and player.canMove and player.canJump and player.TouchingGround and player.canJump and not player.TouchingBottomWall and not player.InAir then
		player.JumpMeter = 0
		player.isJumping = true
	end

	if player.isJumping and love.keyboard.isDown('space') and player.JumpMeter < player.JumpMaxHeight and player.canMove and not player.TouchingBottomWall then
		player.canJump = false
		player.JumpMeter = player.JumpMeter + player.jumpAdd * dt
		player.y = player.y - player.Yvelocity * dt
	else
		player.isJumping = false
		player.canJump = true
	end


	--Player falls when in air or other stuff
	if player.canMove and player.InAir and not player.isJumping and not player.isTouchingGround and not player.Dashing and not player.BouncingOnWall and not player.JumpingOnSpring  then
		player.y = player.y + player.Yfriction * dt 
	end
end

function playerShoots()
	local Bullet = Bullets:new('line',player.x, player.y,0,5,5,nil,50,500)
	table.insert(TableOfBullets,Bullet)
	
end

function UpdateBullets(dt)
	for _,bulletValue in ipairs(TableOfBullets) do
		bulletValue.x = bulletValue.x + bulletValue.speed * bulletValue.cos * dt 
		bulletValue.y = bulletValue.y + bulletValue.speed * bulletValue.sin * dt 
	end
end


function DrawBullets()
	for BulletTableIndex,BulletTableValue in ipairs(TableOfBullets) do
		love.graphics.rectangle(BulletTableValue.rectangleLine,BulletTableValue.x,BulletTableValue.y,BulletTableValue.width,BulletTableValue.height)
	end
end

function DrawPlayer()
	--PLayer health
	love.graphics.print(math.floor(player.health),player.x + 1,player.y - 25)
	player:draw()
end




--Mechanics I side lined // some of them fully works but im gonna not implement them rn
function testing()

	-- Player Dashes // Using Moving Right or Moving Left would ensure that even if player lets go of 'A' or 'D' the player still dashes // nvm this causes some difficult things with the player.bouncing on wall
	--//This code works // Dash I meant.
	if love.mouse.isDown('1') and love.keyboard.isDown('d') and player.canMove and player.canDash  and not player.TouchingBouncyWall or love.mouse.isDown('1') and love.keyboard.isDown('a') and player.canMove and player.canDash and not player.TouchingBouncyWall  then
		player.DashTimer = 0 
		player.Dashing = true
	end


	if player.Dashing and love.keyboard.isDown('d') and player.canMove and not player.TouchingWall and player.CanDashRight  then
		player.NotDashing = false
		player.canDash = false
		player.CanDashLeft = false
		player.DashTimer = player.DashTimer + player.DashAdd * dt
		player.x = player.x + player.DashSpeed * dt 

	elseif player.Dashing and love.keyboard.isDown('a') and player.canMove and not player.TouchingWall and player.CanDashLeft  then
		player.NotDashing = false
		player.canDash = false
		player.CanDashRight = false
		player.DashTimer = player.DashTimer + player.DashAdd * dt
		player.x = player.x - player.DashSpeed * dt 
	else
		player.NotDashing = true
	end

	if player.DashTimer > player.DashTime or player.TouchingWall or player.TouchingBouncyWall or player.NotDashing  then
		player.DashTimer = player.DashTimer + player.DashAdd * dt 
		player.Dashing = false
	end

	if player.DashTimer > 4  then
		player.canDash = true
		player.CanDashRight = true
		player.CanDashLeft = true
	end

end


function sidelined()
	if not player.MovingLeft and not player.MovingRight then -- If player isnt moving set velocity to 0
		player.Xvelocity = 0 
	end

	if love.keyboard.isDown('d') and player.MovingLeft and not player.MovingRight and not player.isJumpingonWall and not player.BouncingOnWall and not player.JumpingOnSpring  then
		player.Xvelocity = 0 
	end

	if love.keyboard.isDown('a') and player.MovingRight and not player.MovingLeft and not player.isJumpingonWall and not player.BouncingOnWall and not player.JumpingOnSpring 	then
		player.Xvelocity = 0 
	end
		
	
	--this part would be responsible for what happens after player lets go of keys while moving

	--Slippery feeling
	if player.MovingRight and player.canMove and player.Xvelocity > 0 and not player.BouncingOnWall and player.canWalk then
		player.Xvelocity = player.Xvelocity - player.Xfriction * dt
		player.x = player.x + player.Xvelocity * dt
	end

	if player.MovingLeft and player.canMove and player.Xvelocity > 0 and not player.BouncingOnWall and player.canWalk then
		player.Xvelocity = player.Xvelocity - player.Xfriction * dt 
		player.x = player.x - player.Xvelocity * dt
	end

	--Max speed
	if player.Xvelocity > player.MaxSpeed then
		player.Xvelocity = player.MaxSpeed
	end 


	

	-- player Bounce of a wall 

	

	if player.BouncingOnWall and player.MovingRight and not player.MovingLeft and not player.BouncingLeft  then
		player.canBounceOnWall = false
		player.BouncingRight = true
		player.Xvelocity = 0
		player.wallBounceTimer = player.wallBounceTimer + player.wallBounceTimerAdd * dt
		player.y = player.y - player.wallBounceSpeedY * dt
		player.x = player.x - player.wallBounceSpeed * dt
	end

	if player.BouncingOnWall and player.MovingLeft and not player.MovingRight and not player.BouncingRight then
		player.canBounceOnWall = false
		player.BouchingLeft = true
		player.Xvelocity = 0
		player.wallBounceTimer = player.wallBounceTimer + player.wallBounceTimerAdd * dt
		player.y = player.y - player.wallBounceSpeedY * dt
		player.x = player.x + player.wallBounceSpeed * dt
	end

	if player.wallBounceTimer > player.wallBounceTime  then
		player.BouncingOnWall = false
		player.canBounceOnWall = true
		player.BouncingRight = false
		player.BouncingLeft = false 
	end

	
end