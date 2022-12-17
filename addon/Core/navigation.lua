-------------------
-- Navigation functions for ni
local ni = ...

ni.navigation = {}

--[[--
Table keys:
- **x** `number`
- **y** `number`
- **z** `number`
@table xyz
]]
--[[--
Gets a path from start to end point with navigation mesh.
 
Parameters:
- **x1** `number`
- **y1** `number`
- **z1** `number`
- **x2** `number`
- **y2** `number`
- **z2** `number`
- **includes** `number`
- **excludes** `number`
 
Returns:
- **path** `xyz table`
@param x1 number
@param y1 number
@param z1 number
@param x2 number
@param y2 number
@param z2 number
@param[opt] includes number
@param[opt] excludes number
]]
function ni.navigation.get_path(x1, y1, z1, x2, y2, z2, includes, excludes)
   return ni.backend.GetPath(x1, y1, z1, x2, y2, z2, includes, excludes)
end

--[[--
Frees the maps loaded in memory.
]]
function ni.navigation.free_maps()
   return ni.backend.FreeMaps()
end

--[[--
Moves the player to the given coordinates.
 
Parameters:
- **x** `number`
- **y** `number`
- **z** `number`
@param x number
@param y number
@param z number
]]
function ni.navigation.move_to(x, y, z)
   return ni.backend.MoveTo(x, y, z)
end

--[[--
Calculates the distance between the player and a point
    
Parameters:
- **x** `number`
- **y** `number`
- **z** `number`
    
Returns:
- **distance** `number`
@param x number
@param y number
@param z number
]]
function ni.navigation.distance_to_point(x, y, z)
   local px, py, pz = ni.player.location()
   return ni.world.get_3d_distance(px, py, pz, x, y, z)
end

-- Static variables when pathing
local current_index = 1
local last_ctm = 0
local current_path_concat = ""
local path_length = 0

--[[--
Follows the path provided
    
Parameters:
- **path** `xyz table`
]]
function ni.navigation.follow_path(path)
   --Compare the current table to the one being passes to see if we need to reset the index
   local concat = table.concat(path)
   if concat ~= current_path_concat then
      current_path_concat = concat
      current_index = 1
      path_length = ni.table.length(path)
   end

   -- Check the point is valid
   local point = path[current_index]
   if not point then
      return false
   end

   -- Distance of player from the current point
   local distance = ni.navigation.distance_to_point(point.x, point.y, point.z)

   -- If the distance is close then we need to cycle the next point
   if distance < 2 then
      if current_index ~= path_length then
         current_index = current_index + 1
      end
      return false
   end

   -- Perform the CTM action
   local time = ni.client.get_time()
   if time - last_ctm > 200 then
      ni.navigation.move_to(point.x, point.y, point.z)
      last_ctm = time
      return true
   end

   return false
end

