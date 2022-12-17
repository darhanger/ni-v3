-------------------
-- Object functions for ni
local ni = ...

ni.object = {}

local build = ni.client.build()


--[[--
Checks if the given object is within game memory
 
Parameters:
- **object** `string`
 
Returns:
- **exists** `boolean`
@param object string
]]
function ni.object.exists(object)
   return ni.backend.ObjectExists(object)
end

--[[--
Gets the objects type.
 
Parameters:
- **object** `string`
 
Returns:
- **type** `number`
@param object string
]]
function ni.object.type(object)
   local _, _, _, type = ni.backend.ObjectInfo(object)
   return type
end

--[[--
Gets if the object is a item
 
Parameters:
- **object** `string`
 
Returns:
- **is_item** `boolean`
@param object string
]]
function ni.object.is_item(object)
   return ni.object.type(object) == 1
end

--[[--
Gets if the object is a container
 
Parameters:
- **object** `string`
 
Returns:
- **is_container** `boolean`
@param object string
]]
function ni.object.is_container(object)
   return ni.object.type(object) == 2
end

--[[--
Gets if the object is a unit
 
Parameters:
- **object** `string`
 
Returns:
- **is_unit** `boolean`
@param object string
]]
function ni.object.is_unit(object)
   return ni.object.type(object) == 3
end

--[[--
Gets if the object is a player
 
Parameters:
- **object** `string`
 
Returns:
- **is_player** `boolean`
@param object string
]]
function ni.object.is_player(object)
   return ni.object.type(object) == 4
end

--[[--
Gets if the object is a game object
 
Parameters:
- **object** `string`
 
Returns:
- **is_game_object** `boolean`
@param object string
]]
function ni.object.is_game_object(object)
   return ni.object.type(object) == 5
end

--[[--
Gets if the object is a dynamic object
 
Parameters:
- **object** `string`
 
Returns:
- **is_dynamic_object** `boolean`
@param object string
]]
function ni.object.is_dynamic_object(object)
   return ni.object.type(object) == 6
end

--[[--
Gets if the object is a corpse object
 
Parameters:
- **object** `string`
 
Returns:
- **is_corpse** `boolean`
@param object string
]]
function ni.object.is_corpse(object)
   return ni.object.type(object) == 7
end

--[[--
Gets if the object is a Ai Group
 
Parameters:
- **object** `string`
 
Returns:
- **is_corpse** `boolean`
@param object string
]]
function ni.object.is_ai_group(object)
   return ni.object.type(object) == 8
end

--[[--
Gets if the object is a Area Trigger
 
Parameters:
- **object** `string`
 
Returns:
- **is_corpse** `boolean`
@param object string
]]
function ni.object.is_area_trigger(object)
   return ni.object.type(object) == 9
end

--[[--
Gets the object location information
 
Parameters:
- **token** `string`
 
Returns:
- **x** `number`
- **y** `number`
- **z** `number`
@param token string
]]
function ni.object.location(token)
   -- If you pass a unit/player it will return more.
   -- Doing this for sanity just so only 3 returns happen.
   local x, y, z = ni.backend.ObjectInfo(token)
   return x, y, z
end

--[[--
Gets the GUID of the objects creator.
 
Parameters:
- **object** `string`
 
Returns:
- **guid** `string`
@param object string
]]
function ni.object.creator(object)
   return ni.backend.ObjectCreator(object)
end

--[[--
Gets the objects pointer
 
Parameters:
- **object** `string`
 
Returns:
- **pointer** `number`
- **hex_pointer** `string`
@param object string
]]
function ni.object.pointer(object)
   return ni.backend.ObjectPointer(object)
end

--[[--
Gets the objects transport guid
 
Parameters:
- **object** `string`
 
Returns:
- **guid** `string`
@param object string
]]
function ni.object.transport(object)
   return ni.backend.ObjectTransport(object)
end

--[[--
Gets the object descriptor value for the given index
 
Parameters:
- **object** `string`
- **index** `number`
 
Returns:
- **descriptor** `number`
@param object string
@param index number
]]
function ni.object.descriptor(object, index)
   return ni.backend.ObjectDescriptor(object, index)
end

--[[--
Gets the object display id
 
Parameters:
- **object** `string`
 
Returns:
- **display_id** `number`
@param object string
]]
function ni.object.display_id(object)
   if build == 12340 then
      return ni.object.descriptor(object, 3)
   end
   if build >= 15595 then
      return ni.object.descriptor(object, 5)
   end
   return -1
end