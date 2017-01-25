function Debug(ItemVar, ItemName, k)
    love.graphics.print(ItemName .. ": " .. ItemVar, 0, 15*k)
end

function _Sine(k, l, position)
	local _x1 = -80 - l*2 + k*2
	local _y1 = position +30 + 10 * math.sin(k/2)
	--love.graphics.points(_x1, _y1)
	love.graphics.draw(particle, _x1, _y1)
end

function line(x0, y0, x1, y1)
  deltax = x1 - x0
  deltay = y1 - y0
  deltaerr = math.abs(deltay / deltax)    --// Assume deltax != 0 (line is not vertical),
           -- note that this division needs to be done in a way that preserves the fractional part
  _error = deltaerr - 0.5
  y = y0
     for x=x0, x1, 1  do
        love.graphics.points(x,y)
		 _error = _error + deltaerr
		if _error >= 0.5 then
              y = y + 1
              _error = _error - 1.0
		end
	 end
end
