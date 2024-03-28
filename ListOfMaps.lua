local Map = require 'MapClass'

walls = {}
BouncyWalls = {}
BottomOfWalls = {}
floors = {}
SpringTraps = {}

BugSoldierEnemySpawnPointTable = {}
local MainWorld = Map:new(0,0,0,0,0,'Map Folders/MainWorld.lua')

if MainWorld.image.layers['walls'] then -- This Access the walls from tiled and Implements them into the game
    for WallIndex,WallPosition in ipairs(MainWorld.image.layers['walls'].objects) do --Load All the Objects from LevelOnePart1 most of our objects are in there.
	      	local wallObj = {x = WallPosition.x,y = WallPosition.y,width =WallPosition.width,height = WallPosition.height}
	      	table.insert(walls,wallObj)
      	end
  	end

if MainWorld.image.layers['Floors'] then
	for FloorIndex,FloorValue in ipairs(MainWorld.image.layers['Floors'].objects) do
  			local FloorObj = {x = FloorValue.x, y = FloorValue.y, width = FloorValue.width, height = FloorValue.height}
  			table.insert(floors,FloorObj)
  	end
end

 	if MainWorld.image.layers['BottomOfWall'] then
  		for BottomOfWallIndex,BottomOfWallValue in ipairs(MainWorld.image.layers['BottomOfWall'].objects) do
  			local BottomOfWallObj = {x = BottomOfWallValue.x,y = BottomOfWallValue.y,width = BottomOfWallValue.width,height = BottomOfWallValue.height}
  			table.insert(BottomOfWalls,BottomOfWallObj)
   end
end

if MainWorld.image.layers['BouncyWall'] then
	for BouncyWallIndex, BouncyWallValue in ipairs(MainWorld.image.layers['BouncyWall'].objects) do
		local BouncyWallObj = {x = BouncyWallValue.x,y = BouncyWallValue.y,width = BouncyWallValue.width,height = BouncyWallValue.height}
		table.insert(BouncyWalls,BouncyWallObj)
	end
end

if MainWorld.image.layers['SpringTrap'] then
	for SpringTrapIndex, SpringTrapValue in ipairs(MainWorld.image.layers['SpringTrap'].objects) do
		local SpringTrapObj = {x = SpringTrapValue.x,y = SpringTrapValue.y,width = SpringTrapValue.width, height = SpringTrapValue.height}
		table.insert(SpringTraps,SpringTrapObj)
	end
end

if MainWorld.image.layers['BugSoldierEnemySpawnPoint'] then
	for _, v in ipairs(MainWorld.image.layers['BugSoldierEnemySpawnPoint'].objects) do
		local BugSoldierEnemySpawnPoint = {x = v.x,y = v.y,width = v.width, height = v.height}
		table.insert(BugSoldierEnemySpawnPointTable,BugSoldierEnemySpawnPoint)
	end
end

function DrawMaps()
	love.graphics.push()
	MainWorld.image:drawLayer(MainWorld.image.layers['Background'])
	MainWorld.image:drawLayer(MainWorld.image.layers['Tile Layer 1'])
	MainWorld.image:drawLayer(MainWorld.image.layers['ForeGround'])
	love.graphics.pop()
end