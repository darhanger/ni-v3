-------------------
-- World functions for ni
local ni = ...

ni.world = {}

--[[--
Calculates the distance between two 2D points
 
Parameters:
- **x1** `number`
- **y1** `number`
- **x2** `number`
- **y2** `number`
 
Returns:
- **distance** `number`
@param x1 number
@param y1 number
@param x2 number
@param y2 number
]]
function ni.world.get_2d_distance(x1, y1, x2, y2)
   return ni.backend.GetDistance(x1, y1, x2, y2)
end

--[[--
Calculates the distance between two 3D points
 
Parameters:
- **x1** `number`
- **y1** `number`
- **z1** `number`
- **x2** `number`
- **y2** `number`
- **z2** `number`
 
Returns:
- **distance** `number`
@param x1 number
@param y1 number
@param z1 number
@param x2 number
@param y2 number
@param z2 number
]]
function ni.world.get_3d_distance(x1, y1, z1, x2, y2, z2)
   return ni.backend.GetDistance(x1, y1, z1, x2, y2, z2)
end

--[[--
Performs a trace line between points to check if line of sight is present.
 
Parameters:
- **x1** `number`
- **y1** `number`
- **z1** `number`
- **x2** `number`
- **y2** `number`
- **z2** `number`
- **hit_flags** `number`
 
Returns:
- **success** `boolean`
- **intersection_x** `number`
- **intersection_y** `number`
- **intersection_z** `number`
@param x1 number
@param y1 number
@param z1 number
@param x2 number
@param y2 number
@param z2 number
@param[opt] hit_flags number
]]
function ni.world.trace_line(x1, y1, z1, x2, y2, z2, hit_flags)
   return ni.backend.LoS(x1, y1, z1, x2, y2, z2, hit_flags)
end

--[[--
Gets the xyz coordinates to screen coordinates
 
Parameters:
- **x** `number`
- **y** `number`
- **z** `number`
@param x number
@param y number
@param z number
]]
function ni.world.to_screen(x, y, z)
   return ni.backend.WorldToScreen(x, y, z)
end