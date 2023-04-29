-------------------
-- Pet functions for ni
local ni = ...

ni.pet = {}

local GetPetActionInfo = ni.client.get_function("GetPetActionInfo")
local GetPetActionCooldown = ni.client.get_function("GetPetActionCooldown")
local GetPetHappiness = ni.client.get_function("GetPetHappiness")
local IsPetAttackActive = ni.client.get_function("IsPetAttackActive")

--[[--
Get the pet action info on the bar by index
 
Parameters:
- **index** `number`
 
Returns:
- **name** `string`
- **subtext** `string`
- **texture** `string`
- **is_token** `boolean`
- **is_active** `boolean`
- **auto_cast_allowed** `boolean`
- **auto_cast_enabled ** `boolean`
@param index number
]]
function ni.pet.action_info(index)
   return GetPetActionInfo(index)
end

--[[--
Cooldown information for the pet action  index
 
Parameters:
- **index** `number`
 
Returns:
- **start_time** `number`
- **duration** `number`
- **enable ** `boolean`
@param index number
]]
function ni.pet.action_cooldown(index)
   return GetPetActionCooldown(index)
end

--[[--
Checks if the pet exists.
 
Returns:
- **has_pet ** `boolean`
]]
function ni.pet.exists()
   return ni.unit.exists("playerpet") and ni.unit.guid("playerpet")
end

--[[--
Cast the corresponding pet skill by index or name

Parameters:
- **spell** `string or number`
- **target** `string`
@param spell
@param[opt] target string
]]
function ni.pet.cast_action(...)
   local action, target = ...
   if type(action) == "string" then
      for i = 1, 10 do
         local name = ni.pet.action_info(i)
         if (name == action) then
            return ni.client.call_protected("CastPetAction", action, target)
         end
      end
   else
      return ni.client.call_protected("CastPetAction", ...)
   end
end

--[[--
Instruct your pet to attack your target.
]]
function ni.pet.attack(target)
   return ni.client.call_protected("PetAttack", target)
end

--[[--
Guid of your pets target, nil if none
 
Returns:
- **guid ** `string`
]]
function ni.pet.current_target()
   return ni.unit.guid("playerpettarget")
end

--[[--
Guid of your pet, nil if none
 
Returns:
- **guid ** `string`
]]
function ni.pet.guid()
   return ni.unit.guid("pet")
end

--[[--
Happiness of your pet, nil if none
 
Returns:
- **happiness ** `int`
]]
function ni.pet.happiness()
   return GetPetHappiness()
end

--[[--
Returns is pet attack active
 
Returns:
- **attack_active ** `boolean`
]]
function ni.pet.is_attack_active()
   return IsPetAttackActive()
end

--[[--
Is your pet in valid state to function
 
Returns:
- **is_valid ** `boolean`
]]
function ni.pet.is_valid()
   if ni.unit.exists("pet") and not ni.unit.is_dead_or_ghost("pet") and not ni.unit.is_silenced("pet") and
      not ni.unit.is_pacified("pet") and not ni.unit.is_stunned("pet") and not ni.unit.is_fleeing("pet") then
      return true
   end
   return false
end

