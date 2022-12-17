-------------------
-- Player functions for ni
local ni = ...

ni.player = {}

-- Localized functions
local setmetatable = ni.client.get_function("setmetatable")
local rawset = ni.client.get_function("rawset")
local GetGlyphSocketInfo = ni.client.get_function("GetGlyphSocketInfo")
local GetNumGlyphSockets = ni.client.get_function("GetNumGlyphSockets")
local GetShapeshiftFormID = ni.client.get_function("GetShapeshiftFormID")
local IsOutdoors = ni.client.get_function("IsOutdoors")
local IsFlyableArea = ni.client.get_function("IsFlyableArea")
local build = ni.client.build()


--[[--
Moves the player to the token or coordinates.
 
Parameters:
- **target** `token|guid`
 
Or
- **x** `number`
- **y** `number`
- **z** `number`
@param ...
]]
function ni.player.move_to(...)
   return ni.backend.MoveTo(...)
end

--[[--
Clicks at the location of the target, or coordinates.
 
Parameters:
- **target** `token|guid`
 
Or
- **x** `number`
- **y** `number`
- **z** `number`
@param ...
]]
function ni.player.click_at(...)
   return ni.backend.ClickAt(...)
end

--[[--
Gets the current map information for the player.
 
Returns:
- **map_id** `number`
- **tile_x** `number`
- **tile_y** `number`
]]
function ni.player.get_map_info()
   return ni.backend.GetMapInfo()
end

--[[--
Turns the player to a target, or away from it.
 
Parameters:
- **target** `token|guid`
- **away** `boolean`
@param target string
@param[opt] away boolean
]]
function ni.player.look_at(target, away)
   return ni.backend.LookAt(target, away)
end

--[[--
Stops the players movement.
]]
function ni.player.stop_moving()
   return ni.backend.StopMoving()
end

--[[--
Sets the player creature tracking value.
 
Parameters:
- **value** `number`
@param value
]]
function ni.player.set_creature_tracking(value)
   return ni.backend.SetCreatureTracking(value)
end

--[[--
Gets the player creature tracking value.
 
Returns:
- **value** `number`
]]
function ni.player.get_creature_tracking()
   return ni.backend.GetCreatureTracking()
end

--[[--
Sets the player resource tracking value.
 
Parameters:
- **value** `number`
@param value
]]
function ni.player.set_resource_tracking(value)
   return ni.backend.SetResourceTracking(value)
end

--[[--
Gets the player resource tracking value.
 
Returns:
- **value** `number`
]]
function ni.player.get_resource_tracking()
   return ni.backend.GetResourceTracking()
end

--[[--
Sets the players target to the token passed
 
Parameters:
- **target** `string`
@param target string
]]
function ni.player.target(target)
   return ni.client.call_protected("TargetUnit", target)
end

--[[--
Interacts with the token passed
 
Parameters:
- **target** `string`
@param target string
]]
function ni.player.interact(target)
   return ni.client.call_protected("InteractUnit", target)
end

--[[--
Checks if the player has the current glyph
 
Parameters:
- **id** `number`
 
Returns:
- **has_glyph** `boolean`
@param id number
]]
function ni.player.has_glyph(id)
   for slot = 1, GetNumGlyphSockets() do
      local enabled, glyph_id
      if build >= 15595 then
         enabled, _, _, glyph_id = GetGlyphSocketInfo(slot)
      else
         enabled, _, glyph_id = GetGlyphSocketInfo(slot)
      end
      if enabled and glyph_id == id then
         return true
      end
   end
   return false
end

--[[--
Gets the current shapeshift form id
 
Returns:
- **form_id** `number`
@param id number
]]
function ni.player.shapeshift_form_id()
    return GetShapeshiftFormID()
end

--[[--
Returns whether the player's character is currently outdoors.
 
Returns:
- **is_outdoors** `boolean`
]]
function ni.player.is_outdoors()
   return IsOutdoors() == 1
end

--[[--
Checks whether the player's current location is classified as being a flyable area.
 
Returns:
- **in_flyable_area** `boolean`
]]
function ni.player.in_flyable_area()
   return IsFlyableArea() == 1
end

--[[--
Canceles a specific buff on the player
 
Parameters:
- **spell** `string`
- **filter** `string`
@param spell string
@param filter[opt] string
]]
function ni.player.cancel_buff(spell, filter)
   return ni.client.call_protected("CancelUnitBuff", "player", spell, filter)
end

-- Set ni.players metatable to allow unit functions.
setmetatable(ni.player, {
   __index = function(table, key)
      if ni.unit[key] then
         rawset(table, key, function(...)
            return ni.unit[key]("player", ...)
         end)
         return table[key]
      end
   end
})