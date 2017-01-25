local f = require "functions"
local anim8 = require 'anim8'
local HC = require 'HC'

local _Debug = false

--# Load Event
function love.load()
  j=0
  -- add a circle to the scene
  mouse = HC.circle(400,300,20)
  mouse:moveTo(love.mouse.getPosition())

  IsColliding = false
  windowX,windowY = love.graphics.getDimensions()
  posX =windowX*.1
  posY = windowY*.5

  image = love.graphics.newImage('media/1945.png')
  
  local grid64 = anim8.newGrid(64,64, 1024,768,  299,101,   2)
  
  love.graphics.setBackgroundColor( 137, 161, 216) --Setting background color.
  
  -- Objects
  player = anim8.newAnimation(grid64(1,'1-3'), 0.1)
  enemy = love.graphics.newImage("enemy.png")
  particle = love.graphics.newImage("particle.png")
  
  --Colliders
  playerCol = HC.rectangle(posX,posY,64,64)

  
  velocity = 1
end

--# Draw Event
function love.draw()

	j=j+1
    -- Draw Sine Wave
    for i=0, 100, 1*0.2 do
		_Sine(i+j, j, posY)
	end
	
  
  player:draw(image, posX, posY, 1.55) --Draw player
  love.graphics.draw(enemy, (windowX*.9), windowY*.5) --Draw Enemy
  
  
  --Debug info
  if _Debug == true then
      playerCol:draw('line')
      mouse:draw('fill')
	  Debug(velocity, "Velocity", 0)
	  Debug(tostring(fullscreen_), "FullScreen", 1)
	  Debug(tostring(touchNumber), "TouchNumber", 2)
	  Debug(tostring(IsColliding), "IsColliding", 3)
  end
   
    
	--line(0, 600, 100, 400) --Create a line btween two points

end

--# Update Event
function love.update( dt )

  mouse:moveTo(love.mouse.getPosition())
  player:update(dt)
  
 -- check for collisions
 for shape, delta in pairs(HC.collisions(mouse)) do
		playerIsColiding = true;
 end
 
 
  if playerIsColiding == true then
     IsColliding = true;
	 playerIsColiding = false;
 else
	IsColliding = false;

 end
		
	fullscreen_, fulltype = love.window.getFullscreen() --Get Fullscreen Status

  -- Function Keys
  function love.keypressed(key)
    if key == "f11" then
      love.window.setFullscreen(not fullscreen_)   --Set fullscreen status
    end
	if key == "f9" then
	_Debug = not _Debug;
	end
  end

  windowX,windowY = love.graphics.getDimensions() -- Updates the dimensions every frame

  --Touchscreen Stuff

  local touches = love.touch.getTouches()

  for i, id in ipairs(touches) do


    love.graphics.print(i, 0, 15*i)
    local touchX,touchY = love.touch.getPosition(id) --Get touch position

    if touchX < windowX*.5  then
      if touchY > windowY*.5 then --If screen Input UP LEFT is pressed, do stuff
        posY = posY + 100 * velocity * dt

        function love.touchpressed(id, x, y, dx, dy, pressure)
          touchNumber = 1
        end

        if velocity <= 4.9 then   --Change velocity if it isn't biguer than 5
          velocity= velocity + 20 * dt
        end
      end

      if touchY < windowY*.5 then --If screen Input DOWN LEFT is pressed, do stuff
        posY = posY - 100 * velocity * dt

        function love.touchpressed(id, x, y, dx, dy, pressure)
          touchNumber = 1
        end

        if velocity < 5 then   --Change velocity if it isn't biguer than 5
          velocity= velocity + 20 * dt
        end
      end
    end


    function love.touchreleased(id, x, y, dx, dy, pressure)
      touchNumber = 0
    end

  end
   
   

  --Keyboard stuff
  if love.keyboard.isDown( "up" ) then  --If key "up" is pressed, do stuff
    posY = posY - 100 * velocity * dt

    if velocity < 5 then   --Change velocity if it isn't biguer than 5
      velocity= velocity + 20 * dt
    end
  end

  if love.keyboard.isDown( "down" ) then  --If key "down" is pressed, do stuff
    posY = posY + 100 * velocity * dt

    if velocity < 5 then   --Change velocity if it isn't biguer than 5
      velocity= velocity + 20 * dt
    end
  end

  --If no key is pressed, do stuff
  if love.keyboard.isDown("up")==false and love.keyboard.isDown( "down" )==false and (touchNumber == nil or touchNumber == 0) then
    velocity = 1
  end

    
	playerCol:moveTo(posX-32, posY+32)
end
