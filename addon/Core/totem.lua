-------------------
-- Totem functions for ni
local ni = ...

ni.totem = {}

local GetTotemInfo = ni.client.get_function("GetTotemInfo")

local totem_slot = {
	["fire"] = 1,
	["earth"] = 2,
	["water"] = 3,
	["air"] = 4,
}

local totem_unit =
{
   [1] = "totem1",
   [2] = "totem2",
   [3] = "totem3",
   [4] = "totem4",
}

--[[--
Returns information about the totem slot
 
Parameters:
- **slot** `string or number`
 
Returns:
- **has_totem_reagent** `boolean`
- **name** `string`
- **start_time** `number`
- **duration** `number`
- **icon** `string`
@param slot number
]]
function ni.totem.info(slot)
   if type(slot) == "string" then
      slot = totem_slot[slot:lower()]
   end
   return GetTotemInfo(slot)
end

--[[--
Checks if a totem slot is active
 
Parameters:
- **slot** `string or number`
 
Returns:
- **is_active** `boolean`
@param slot number
]]
function ni.totem.is_active(slot)
   local _, _, start_time = ni.totem.info(slot)
   return start_time and start_time ~= 0
end

--[[--
Checks if a totem exisits
 
Parameters:
- **totem** `string or number`
 
Returns:
- **exists** `boolean`
 
Notes:
Can use totem token "totem1" or slot number
@param slot number
]]
function ni.totem.exists(totem)
   if type(totem) == "number" then
      totem = totem_unit[totem]
   end
   return ni.unit.exists(totem)
end

--[[--
Gets the distance between a totem and the target
 
Parameters:
- **totem** `string or number`
- **target** `string`
 
Returns:
- **exists** `boolean`
 
Notes:
Can use totem token "totem1" or slot number
@param slot string
@param target string
]]
function ni.totem.distance(totem, target)
   if type(totem) == "number" then
      totem = totem_unit[totem]
   end
   return ni.unit.distance(totem, target)
end