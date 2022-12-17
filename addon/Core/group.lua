-------------------
-- Group functions for ni
local ni = ...

local build = ni.client.build()
local UnitGroupRolesAssigned = ni.client.get_function("UnitGroupRolesAssigned")
--Removed in Mop
local GetNumRaidMembers = ni.client.get_function("GetNumRaidMembers")
local GetNumPartyMembers = ni.client.get_function("GetNumPartyMembers")
--Added in MoP
local IsInRaid = ni.client.get_function("IsInRaid")
local GetNumGroupMembers = ni.client.get_function("GetNumGroupMembers")


ni.group = {}

--[[--
Gets the the assigned role in a group formed via dungon finder or set manually
 
Parameters:
- **target** `string`
 
Returns:
- **role** `string`
 
Notes:
Role can return TANK, HEALER, DAMAGER, NONE
@param target string
]]
ni.group.roles_assigned = function(target)
   return UnitGroupRolesAssigned(target)
end

--[[
Check to see if a group member is a tank
 
Parameters:
- **target** `string`
 
Returns:
- **is_tank** `boolean`
@param target string
]]
ni.group.is_tank = function(target)
   local class = ni.unit.class(target)
   if class == "WARRIOR" and ni.unit.has_aura(target, 71) then
      return true;
   elseif class == "DRUID" and (ni.unit.buff(target, 9634, "EXACT") or ni.unit.buff(target, 5487, "EXACT"))	then
      return true;
   elseif class == "PALADIN" and ni.unit.buff(target, 25780) then
      return true;
   elseif ni.unit.has_aura(target, 57340) then
      return true;
   elseif ni.group.roles_assigned(target) == "TANK" then
      return true;
   end
   return false
end

--[[
Check to see if a group member is in range
 
Parameters:
- **target** `string`
- **distance** `number`
 
Returns:
- **in_range** `boolean`
@param target string
@param distance number
]]
ni.group.in_range = function(target, distance)
   return ni.object.exists(target) and ni.player.distance(target) <= distance
end

--[[
Check to see if the player is in a raid group
 
Returns:
- **in_raid** `boolean`
]]
ni.group.in_raid = function ()
   if build == 18414 then
      return IsInRaid()
   end
   return GetNumRaidMembers() > 0
end

--[[
Get the number of members in the players raid or party
 
Returns:
- **size** `number`
]]
ni.group.size = function ()
   if build == 18414 then
      return GetNumGroupMembers()
   end
   if ni.group.in_raid() then
      return GetNumRaidMembers()
   end
   return GetNumPartyMembers()
end