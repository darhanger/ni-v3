-------------------
-- Power functions
local ni = ...

-- Localizations
local UnitPower = ni.client.get_function("UnitPower")
local UnitPowerMax = ni.client.get_function("UnitPowerMax")
local type = ni.client.get_function("type")

ni.power = {}

--[[--
Power types with there associated numerical value
]]
local power_types = {
   mana = 0,
   rage = 1,
   focus = 2,
   energy = 3,
   combopoints = 4,
   runes = 5,
   runicpower = 6,
   soulshards = 7,
   eclipse = 8,
   holy = 9,
   alternate = 10,
   darkforce = 11,
   chi = 12,
   shadoworbs = 13,
   burningembers = 14,
   demonicfury = 15
}

--[[--
@local
Translates the power type string to number
 
Parameters:
- **power_type** `string`
 
Returns:
- **value** `number`
@param power_type string
]]
local function power_type_to_value(power_type)
   if type(power_type) == "string" then
      return power_types[power_type]
   end
   return power_type
end

--[[--
Returns the power type current value for a target
 
Parameters:
- **target** `string`
- **power_type** `string or number`
 
Returns:
- **current** `number`
@param target string
@param[opt] power_type
]]
function ni.power.current(target, power_type)
   power_type = power_type_to_value(power_type)
   return UnitPower(target, power_type)
end

--[[--
Returns the power type max value for a target
 
Parameters:
- **target** `string`
- **power_type** `string or number`
 
Returns:
- **max** `number`
@param target string
@param[opt] power_type
]]
function ni.power.max(target, power_type)
   power_type = power_type_to_value(power_type)
   return UnitPowerMax(target, power_type)
end

--[[--
Returns the power type value for a target as a percentage
 
Parameters:
- **target** `string`
- **power_type** `string or number`
 
Returns:
- **power_percent** `number`
@param target string
@param[opt] power_type
]]
function ni.power.percent(target, power_type)
   power_type = power_type_to_value(power_type)
   return 100 * ni.power.current(target, power_type) / ni.power.max(target, power_type)
end

--[[--
Returns if the power type is at maximum or full
 
Parameters:
- **target** `string`
- **power_type** `string or number`
 
Returns:
- **is_max** `boolean`
@param target string
@param[opt] power_type
]]
function ni.power.is_max(target, power_type)
   power_type = power_type_to_value(power_type)
   return ni.power.current(target, power_type) == ni.power.max(target, power_type)
end

--[[--
Returns the deficit from the power of a target
 
Parameters:
- **target** `string`
- **power_type** `string or number`
 
Returns:
- **deficit** `number`
@param target string
@param[opt] power_type
]]
function ni.power.deficit(target, power_type)
   power_type = power_type_to_value(power_type)
   return ni.power.max(target, power_type) - ni.power.current(target, power_type)
end