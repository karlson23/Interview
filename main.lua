

local Camera = require 'Libraries/camera'

cam = Camera()

sti = require 'Libraries/sti'

--mouse
mouse = {}
mouse.x,mouse.y = love.mouse.getPosition() --Mouse in screen
mouse.xW,mouse.yW = cam:mousePosition() --Mouse in game world
mouse.width = 5
mouse.height = 5
mouse.image = nil -- No image yet
require 'ListOfMaps'


require 'playerFunctions'

require 'EnemyFunctions'

require 'CollisionChecker'

function love.mousepressed(x, y, button, istouch)
   if button == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
      playerShoots()
   end
end


function UpdateMouse(dt)
	mouse.x, mouse.y = love.mouse.getPosition()	--Mouse in screen
	mouse.xW,mouse.yW = cam:mousePosition() --Mouse in game world

end

function DrawMouse()
	love.graphics.rectangle('line',mouse.xW - 2,mouse.yW,mouse.width,mouse.height)
end
function love.load( ... )
	SpawnEnemy()
end

function love.update(dt)
	PlayerMoves(dt)
	UpdateMouse(dt)
	CheckCollisionWithWalls(dt)
	CheckCollisionWithFloors(dt)
	CheckCollisionWithBottomOfWall(dt)
	CheckCollisionWithSpringTraps()	
	UpdateEnemy(dt)
	EnemyCollision(dt)
	UpdateBullets(dt)
	BulletCollision(dt)

end

function love.draw()

	cam:attach()
		DrawMaps()
		DrawPlayer()
		DrawMouse()
		DrawEnemy()
		DrawBullets()
	cam:detach()
end