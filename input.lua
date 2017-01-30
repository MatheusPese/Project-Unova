--TODO: fix touchscreen bugs

function inputsload()
touchUpLeft, touchDownLeft = false

end
function inputs( dt )
 
  --Touchscreen Stuff--
  local touches = love.touch.getTouches( )

  for i, id in ipairs(touches) do

    love.graphics.print( i, 0, 15*i )
    local touchX,touchY = love.touch.getPosition(id) --Get touch position

    if touchX < windowX*.5  then
      if touchY > windowY*.5 then         --If screen Input UP LEFT is pressed, do stuff
        posY = posY + 100 * velocity * dt
        touchUpLeft = true

        function love.touchpressed(id, x, y, dx, dy, pressure)
          touchNumber = 1
        end

        if velocity <= 4.9 then           --Change velocity if it isn't biguer than 5
          velocity= velocity + 20 * dt
        end
      else
         touchUpLeft = false
      end

      if touchY < windowY*.5 then         --If screen Input DOWN LEFT is pressed, do stuff
        posY = posY - 100 * velocity * dt
        touchDownLeft = true
        function love.touchpressed(id, x, y, dx, dy, pressure)
          touchNumber = 1
        end

        if velocity < 5 then              --Change velocity if it isn't biguer than 5
          velocity= velocity + 20 * dt
        end
      else
         touchDownLeft = false
      end
    end


    function love.touchreleased(id, x, y, dx, dy, pressure)
      touchNumber = 0
    end

  end
   
   

  --Keyboard stuff--
  if love.keyboard.isDown( "up" ) then   --If key "up" is pressed, do stuff
    posY = posY - 100 * velocity * dt

    if velocity < 5 then                 --Change velocity if it isn't biguer than 5
      velocity= velocity + 20 * dt
    end
  end

  if love.keyboard.isDown( "down" ) then --If key "down" is pressed, do stuff
    posY = posY + 100 * velocity * dt

    if velocity < 5 then                 --Change velocity if it isn't biguer than 5
      velocity= velocity + 20 * dt
    end
  end

  --If no key is pressed, do stuff
  if love.keyboard.isDown( "up" ) == false and touchUpLeft == false  and  love.keyboard.isDown( "down" ) == false and touchDownLeft == false then
    velocity = 1
  end
end