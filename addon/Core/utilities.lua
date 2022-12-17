-------------------
-- Utility functions for ni
local ni = ...

ni.utilities = {}

--[[--
Gets the HWID for the current users computer base64 encoded.
 
Returns:
- **hwid** `string`
]]
function ni.utilities.get_hwid()
   return ni.backend.GetHWID()
end

--[[--
Sets the seed for the random generator.
 
Parameters:
- **seed** `number`
@param seed number
]]
function ni.utilities.randomseed(seed)
   ni.backend.RandSeed(seed)
end

--[[--
Generates a random number.
 
Parameters:
- **l** `number`
- **u** `number`
 
Returns:
- **value** `number`
 
Notes:
When called without arguments, the number returned is between 0 and 1.
When called with 1 argument (n), the range is between 1 and n.
When called with 2 arguments (l, u), the range is between l and u.
@param[opt] l number
@param[opt] u number
]]
function ni.utilities.random(l, u)
   return ni.backend.Rand(l, u)
end

--[[--
Gets a random point within range of specified location based off the offset (or random if none specified)
 
Parameters:
- **x** `number`
- **y** `number`
- **offset** `number`
 
Returns:
- **new_x** `number`
- **new_y** `number`
@param x number
@param y number
@param[opt] offset
]]
function ni.utilities.randomize_point(x, y, offset)
   offset = offset or 1
   local r = offset * ni.utilities.random()
   local theta = ni.utilities.random() * 360
   local new_x = x + r * cos(theta)
   local new_y = y + r * sin(theta)
   return new_x, new_y
end

--[[--
Logs a message to the lua log file
 
Parameters:
- **message** `string`
@param message string
]]
function ni.utilities.log(message)
   ni.backend.Log(message)
end

--[[--
Checks if a bit is set on an integer
 
Parameters:
- **item** `number`
- **bit** `number`
 
Returns:
- **has_bit** `boolean`
@param item number
@param bit number
]]
function ni.utilities.has_bit(item, bit)
   return item % (bit + bit) >= bit
end

--[[--
Sets the bit of an integer
 
Parameters:
- **item** `number`
- **bit** `number`
 
Returns:
- **value** `number`
@param item number
@param bit number
]]
function ni.utilities.set_bit(item, bit)
   return ni.utilities.has_bit(item, bit) and item or item + bit
end

--[[--
Clears the bit from an integer
 
Parameters:
- **item** `number`
- **bit** `number`
 
Returns:
- **value** `number`
@param item number
@param bit number
]]
function ni.utilities.clear_bit(item, bit)
   return ni.utilities.has_bit(item, bit) and item - bit or item
end

--[[--
Encodes a lua table to a json string
 
Parameters:
- **table** `table`
 
Returns:
- **json** `string`
- **error** `string`
 
Notes:
Can return nil on the json string if there is an error.
@param table
]]
function ni.utilities.to_json(table)
   return ni.backend.ToJson(table)
end

--[[--
Decodes a json string to a lua table
 
Parameters:
- **json** `string`
 
Returns:
- **table** `table`
- **error** `string`
 
Notes:
Can return nil if the string is improperly formed.
@param json
]]
function ni.utilities.from_json(json)
   return ni.backend.FromJson(json)
end