-------------------
-- Gear functions
local ni = ...

ni.gear = {}

-- Localizations
local GetInventoryItemID = ni.client.get_function("GetInventoryItemID")
local GetWeaponEnchantInfo = ni.client.get_function("GetWeaponEnchantInfo")


--[[--
Uses the inventory item by slot id.
 
Parameters:
- **slot** `number`
@param slot
]]
function ni.gear.use(slot)
   return ni.client.call_protected("UseInventoryItem", slot)
end

--[[--
Gets the inventory slot item id.
 
Parameters:
- **slot** `number`
 
Returns:
- **id** `number`
@param slot number
]]
function ni.gear.id(slot)
   return GetInventoryItemID("player", slot)
end

--[[--
Checks if an item ID is equipped
 
Parameters:
- **id** `number`
 
Returns:
- **is_equipped** `boolean`
@param id number
]]
function ni.gear.is_equipped(id)
   for i = 1, 19 do
      if ni.gear.id(i) == id then
         return true
      end
   end
   return false
end

--[[--
Checks if the equipped item is has a spell
 
Parameters:
- **slot** `number`
 
Returns:
- **spell_name** `string`
- **spell_id** `number`
@param slot number
]]
function ni.gear.spell(slot)
   local id = ni.gear.id(slot)
   return ni.item.spell(id)
end

--[[--
Gets the cooldown of an item equipped
 
Parameters:
- **slot** `number`
 
Returns:
- **start_time** `number`
- **duration** `number`
- **enabled** `number`
@param slot number
]]
function ni.gear.cooldown(slot)
   local id = ni.gear.id(slot)
   if not ni.item.spell(id) then
      return 0, 0, 0
   end
   return ni.item.cooldown(id)
end

--[[--
Gets the cooldown time remaining for an item equipped
 
Parameters:
- **slot** `number`
 
Returns:
- **remaining** `number`
@param slot number
]]
function ni.gear.cooldown_remaining(slot)
   local id = ni.gear.id(slot)
   return ni.item.cooldown_remaining(id)
end

--[[--
Returns information about the player's current temporary enchants
]]
function ni.gear.weapon_enchant_info()
   return GetWeaponEnchantInfo()
end