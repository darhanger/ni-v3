-------------------
-- Memory functions for ni
local ni = ...

ni.memory = {}

--[[--
Gets the games base address.
 
Returns:
- **pointer** `number`
- **hex_pointer** `string`
]]
ni.memory.base_adress = function ()
   return ni.backend.BaseAddress()
end

--[[--
Reads client memory with the specified type.
 
Parameters:
- **type** `string`
- **address** `number`
- **...** `number

 
Returns:
- **value** `type`
 
@param target string
]]
ni.memory.read = function(type, adress, ...)
   return ni.backend.Read(type, adress, ...)
end

--[[--
Gets the pointer for an object.
 
Parameters:
- **target ** `string`
 
Returns:
- **pointer** `number`
- **hex_pointer** `string`
 
@param target string
]]
ni.memory.pointer = function (target)
   return ni.backend.ObjectPointer(target)
end

