function CheckCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end


function CheckCollisionWithWalls(dt)
  player.TouchingWall = false

  for WallIndex,WallValue in ipairs(walls) do
    if CheckCollision(WallValue.x,WallValue.y,WallValue.width,WallValue.height,player.x,player.y,player.width,player.height) then
        player.x = player.LastX
        player.TouchingWall = true
    end
  end
end



function CheckCollisionWithBottomOfWall()
  player.TouchingBottomWall = false
  for BottomWallIndex,BottomWallValue in ipairs(BottomOfWalls) do
    if CheckCollision(BottomWallValue.x,BottomWallValue.y,BottomWallValue.width,BottomWallValue.height,player.x,player.y,player.width,player.height) then
            player.y = player.LastY
            player.TouchingBottomWall = true
        end
    end
end

function CheckCollisionWithFloors( ... )
  player.TouchingGround = false
  player.InAir = true

  for FloorIndex,FloorPosition in ipairs(floors) do
    if CheckCollision(FloorPosition.x,FloorPosition.y,FloorPosition.width,FloorPosition.height, player.x,player.y,player.width,player.height) then
      player.y = player.LastY
      player.InAir = false
      player.TouchingGround = true
        end
    end
end

function CheckCollisionWithSpringTraps()
  player.TouchingSpring = false

  for SprintTrapIndex1, SpringTrapValue1 in ipairs(SpringTraps) do
    if CheckCollision(SpringTrapValue1.x,SpringTrapValue1.y,SpringTrapValue1.width,SpringTrapValue1.height,player.x,player.y,player.width,player.height) then
      player.TouchingSpring = true
      player.JumpingOnSpring = true
        end
    end
end

-- not implemented yet
function CheckCollisionWithCheckPoints()
  for CheckPointIndex3, CheckPointValue3 in ipairs(CheckPoints) do
    if CheckCollision(CheckPointValue3.x,CheckPointValue3.y,CheckPointValue3.width,CheckPointValue3.height,player.x,player.y,player.width,player.height) then
      player.LastCheckPointY = CheckPointValue3.y
      player.LastCheckPointX = CheckPointValue3.x
    end
  end
end


function CheckCollisionWithVoid()
  for voidIndex2,voidIndexValue2 in ipairs(Voids) do
      if CheckCollision(voidIndexValue2.x,voidIndexValue2.y,voidIndexValue2.width,voidIndexValue2.height,player.x,player.y,player.width,player.height) then
        player.y = player.LastCheckPointY
        player.x = player.LastCheckPointX
        end
    end
end

--Collision funtions for bullets

function BulletCollision(dt)
    for BulletIndex = #TableOfBullets,1,-1 do
      local Bullet = TableOfBullets[BulletIndex]
        for WallIndex,WallValue in ipairs(walls) do
          if CheckCollision(Bullet.x,Bullet.y,Bullet.width,Bullet.height,WallValue.x,WallValue.y,WallValue.width,WallValue.height) then
              table.remove(TableOfBullets,BulletIndex)
            end
        end

        for FloorIndex,FloorValue in ipairs(floors) do
          if CheckCollision(Bullet.x,Bullet.y,Bullet.width,Bullet.height,FloorValue.x,FloorValue.y,FloorValue.width,FloorValue.height) then
              table.remove(TableOfBullets,BulletIndex)
            end
        end
        for BottomWallIndex,BottomWallValue in ipairs(BottomOfWalls) do
          if CheckCollision(Bullet.x,Bullet.y,Bullet.width,Bullet.height,BottomWallValue.x,BottomWallValue.y,BottomWallValue.width,BottomWallValue.height) then
            table.remove(TableOfBullets,BulletIndex)
            end
        end
    end
end

--
function EnemyCollision(dt)

  --Functions for the bug Soldier enemy
  for _,v in ipairs(BugSoldierTable) do
    v.InAir = true
    if CheckCollision(v.x,v.y,v.LineOfSightW,v.LineOfSightH,player.x,player.y,player.width,player.height) then
      v.detectsPlayer = true
    end
    for _,wall in ipairs(walls) do
      if CheckCollision(v.x,v.y,v.width,v.height,wall.x,wall.y,wall.width,wall.height) then
        v.x = v.LastX
      end
    end

    for _,floor in ipairs(floors) do
      if CheckCollision(floor.x,floor.y,floor.width,floor.height,v.x,v.y,v.width,v.height) then
        v.y = v.LastY
        v.InAir = false
      end
    end

    --Check Collisio with player // and lose some health
    if CheckCollision(v.x,v.y,v.width,v.height,player.x,player.y,player.width,player.height) then
      player.health = player.health - v.damage * dt / 10
    end
  end
end
--Check Collision With Menus