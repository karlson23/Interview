local Player = {}
Player.__index = Player

Player.new = function(self,x,y,rotation,width,height,image,Xvelocity,health)
	local self = {}
	self.x = x 

	self.y = y 

	self.LastX = self.x
	self.LastY = self.y

	self.width = width

	self.height = height

	self.image = image

	--Can do stuff
	self.canMove = true
	
	self.canJump = true
	self.canDash = true
	self.CanDashRight = true
	self.CanDashLeft = true
	self.canBounceOnWall = true
	self.canWalk = true

	self.SpringJump = true

	self.canShoot = true
	--ishappening
	self.TouchingGround = true

	self.TouchingWall = false
	self.TouchingBottomWall = false
	self.MovingRight = false
	self.MovingLeft = false 

	self.isJumping = false

	self.TouchingBouncyWall = false
	self.BouncingOnWall = false
	self.BouncingLeft = false
	self.BouncingRight = false
	self.InAir = false

	self.Dashing = false

	self.NotDashing = false

	self.TouchingSpring = false
	self.JumpingOnSpring = false

	--Player Shooting directions
	self.notShooting = true

	self.ShootingRight = false

	self.ShootingLeft = false

	self.ShootingTop = false

	self.ShootingDown = false

	self.ShootingTopLeft = false

	self.ShootingTopRight = false

	self.ShootingDownRight = false

	self.ShootingDownLeft = false
	--Player stats
	self.Xvelocity = Xvelocity
	self.XAcceleration = XAcceleration
	self.Xfriction = Xfriction

	self.MaxSpeed = 150

	self.Yvelocity = 215
	self.Yacceleration = Yacceleration
	self.LastYVelocity = self.Yvelocity
	self.Yfriction = 200


	self.JumpMaxHeight = 150
	self.JumpMeter = 0
	self.jumpAdd = 250

	self.wallBounceSpeed = 250
	self.wallBounceSpeedY = 275
	self.wallBounceTimer = 0
	self.wallBounceTime = 1 -- How long a player X position gets added or subtracted after bouncing on a wall
	self.wallBounceTimerAdd = 3

	self.DashSpeed = 525
	self.DashTimer = 0
	self.DashTime = 0.170
	
	self.DashAdd = 1

	self.SpringTimer = 0
	self.SpringAdd = 3 -- How much seconds added to spring timer 
	self.SpringTime = 1 -- How much spring effects take place
	self.SpringYAdd = 550 

	self.health = health
	--Bullet stuff

	--checkpoints
	self.LastCheckPointY = nil
    self.LastCheckPointX = nil

	return setmetatable(self,Player)
end

Player.draw = function(self)
	love.graphics.rectangle('line',self.x,self.y,self.width,self.height)
end

return Player