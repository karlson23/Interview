local Enemys = require 'enemyClass'
BugSoldierTable = {}

function SpawnEnemy()
	--This function would make an enemy for every BugSoldierSpawnPoint , 
	--note single spawn only but will be planning on adding EnemySpawnPoint multiple functions and table
	--Summon Bug soldiers
	for _, v in ipairs(BugSoldierEnemySpawnPointTable) do
		local BugSoldier = Enemys:new('line',v.x,v.y,0,50,50,50,50,50,'line',100,100,100) -- No damage yet
		table.insert(BugSoldierTable,BugSoldier)
	end
end

function UpdateEnemy(dt)
	--Bug Soldier Update 

	for _, v in ipairs(BugSoldierTable) do
		v.LastX = v.x
		v.LastY = v.y
		if v.detectsPlayer and v.canMove then
			local angle = math.atan2(player.y - v.y,player.x - v.x) 
			local sin = math.sin(angle)
			local cos = math.cos(angle)

			v.x = v.x + v.speed * cos * dt

			v.IsMoving = true
		end
		--Enemy Falls
		if v.InAir and v.canMove then
			v.y = v.y + v.Yfriction * dt
		end
	end
end	

function DrawEnemy()
	--Draw Bug soldier
	for _,v in ipairs(BugSoldierTable) do 
		love.graphics.rectangle(v.rectangleLine,v.x,v.y,v.width,v.height)
		love.graphics.rectangle(v.LineOfSightRectangleLine,v.x,v.y,v.LineOfSightW,v.LineOfSightH)
	end
end