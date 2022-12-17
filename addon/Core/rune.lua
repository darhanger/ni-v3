-------------------
-- Rune functions
local ni = ...

ni.rune = {}

-- Localizations
local GetRuneCooldown = ni.client.get_function("GetRuneCooldown")
local GetRuneType = ni.client.get_function("GetRuneType")

--[[--
Returns the rune cooldown information for selected rune index.
 
Parameters:
- **index** `number`
 
Returns:
- **start** `number`
- **duration** `number`
- **enabled** `number`
@param index number
]]
function ni.rune.cooldown(index)
   return GetRuneCooldown(index)
end

--[[--
Gets the rune type by index
 
Parameters:
- **index** `number`
 
Returns:
- **rune_type** `number`
@param index number
]]
function ni.rune.type(index)
   return GetRuneType(index)
end

--[[--
Checks if a rune index is currently on cooldown
 
Parameters:
- **index** `number`
 
Returns:
- **on_cooldown** `boolean`
@param index number
]]
function ni.rune.on_cooldown(index)
   local start, duration = ni.rune.cooldown(index)
   if start == 0 then
      return false
   end
   if ni.client.get_time() - start > duration then
      return false
   end
   return true
end