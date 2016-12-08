local f = require("functions")

--# Load Event
function love.load()
  love.graphics.setBackgroundColor( 100, 130, 110 ) --Setting background color.
  windowX,windowY = love.graphics.getDimensions()
  player = love.graphics.newImage("player.love")  --The "player.love" and the "enemy.love" is equivalent to a png file, wich for some reason did't work in a mobile version.
  enemy = love.graphics.newImage("enemy.love")
  player = love.graphics.newImage("player.png")
  enemy = love.graphics.newImage("enemy.png")

  posX =windowX*.1
  posY = windowY*.5
  velocity = 1
end

--# Draw Event
function love.draw()

  --Debug info
  Debug(velocity, "Velocity", 0)
  Debug(tostring(fullscreen_), "FullScreen", 1)

  love.graphics.draw(player, posX, posY) --Draw player
  love.graphics.draw(enemy, (windowX*.9), windowY*.5) --Draw Enemy
end

--# Update Event
function love.update( dt )
  fullscreen_, fulltype = love.window.getFullscreen() --Get Fullscreen Status


  function love.keypressed(key)
    if key == "f11" then
      love.window.setFullscreen(not fullscreen_)   --Set fullscreen status
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

        if velocity < 5 then   --Change velocity if it isn't biguer than 5
          velocity= velocity + 20 * dt
        end
      end

      if touchY < windowY*.5 then --If screen Input DOWN LEFT is pressed, do stuff
        posY = posY - 100 * velocity * dt

        if velocity < 5 then   --Change velocity if it isn't biguer than 5
          velocity= velocity + 20 * dt
        end
      end
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
  if love.keyboard.isDown("up")==false and love.keyboard.isDown( "down" )==false then
    velocity = 1
  end
end
