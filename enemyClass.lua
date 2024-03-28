local Enemy = {}
Enemy.__index = Enemy

Enemy.new = function(self,rectangleLine,x,y,rotation,width,height,damage,health,speed,LineOfSightRectangleLine,LineOfSightW,LineOfSightH,Yfriction)
	local self = {}
	self.x = x
	self.y = y 

	self.LastX = self.x 
	self.LastY = self.y
	self.rotation = rotation
	self.width = width
	self.height = height

	--Collision rectangle line
	self.rectangleLine = rectangleLine
	--Stats
	self.damage = damage
	self.health = health
	self.speed = speed

	self.Yfriction = Yfriction

	self.detectsPlayer = false

	self.LineOfSightRectangleLine = LineOfSightRectangleLine
	self.LineOfSightW = LineOfSightW
	self.LineOfSightH = LineOfSightH
	--Can Do stuff
	self.canMove = true

	--Is happening
	self.InAir = true
	self.IsMoving = false
	--Math // Self.angle is the thing thats gets the player position
	self.angle = math.atan2(player.y - self.y,player.x - self.x) 
	self.sin = math.sin(self.angle)
	self.cos = math.cos(self.angle)

	return setmetatable(self,Enemy)
end

Enemy.draw = function(self)
	love.graphics.rectangle(self.rectangleLine,self.x,self.y,self.width,self.height)
end

return Enemy