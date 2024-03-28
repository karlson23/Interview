local Map = {}
Map.__index = Map

Map.new = function(self,x,y,r,w,h,image)
	local self = {}
	self.x = x 
	self.y = y 
	self.r = r
	self.w = w 
	self.h = h 

	self.image = sti(image)

	return setmetatable(self,Map)
end

Map.draw = function(self)
	self.image:draw(self.x,self.y,self.w,self.h)
end


return Map