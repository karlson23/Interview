local Bullet = {}
Bullet.__index = Bullet

Bullet.new = function(self,rectangleLine,x,y,rotation,width,height,image,damage,speed)
	local self = {}

	self.x = x

	self.y = y 

	self.rotation = rotation

	self.width = width

	self.height = height

	self.image = image -- Add love.graphics.newImage() later , no images yet

	self.rectangleLine = rectangleLine -- Wether Collision box be line or filled

	self.damage = damage

	self.speed = speed

	--Go to bullet
	self.DirectionX = DirectionX 
	self.DirectionY = DirectionY
	
	self.BulletAngle = math.atan2(mouse.yW - self.y,mouse.xW - self.x)
	self.cos = math.cos(self.BulletAngle)
	self.sin = math.sin(self.BulletAngle)
	return setmetatable(self,Bullet)
end

Bullet.draw = function(self)
	love.graphics.draw(self.image,self.x,self.y,self.rotation)
	love.graphics.rectangle(self.rectangleLine,self.x,self.y,self.width,self.height)
end

return Bullet