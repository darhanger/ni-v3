-------------------
-- Item functions
local ni = ...

ni.item = {}

-- Localizations
local GetItemSpell = ni.client.get_function("GetItemSpell")
local GetItemCount = ni.client.get_function("GetItemCount")
local GetItemInfo = ni.client.get_function("GetItemInfo")
local GetItemCooldown = ni.client.get_function("GetItemCooldown")
local IsEquippableItem = ni.client.get_function("IsEquippableItem")
local type = ni.client.get_function("type")

--[[--
Gets the item information
 
Parameters:
- **item** `string or number`
 
Returns:
- **...**
 
Notes:
Wrapper for GetItemInfo. See that for appropriate documentation.
@param item
]]
function ni.item.info(item)
   return GetItemInfo(item)
end

--[[--
Checks if an item has a cast ability
 
Parameters:
- **item** `number or string`
 
Returns:
- **spell_name** `string`
- **spell_id** `number`
@param item
]]
function ni.item.spell(item)
   return GetItemSpell(item)
end

--[[--
Gets the items charges
 
Parameters:
- **item** `number`
 
Returns:
- **charges** `number`
@param item
]]
function ni.item.charges(item)
   return GetItemCount(item, false, true)
end

--[[--
Gets the item count for an item
 
Parameters:
- **item** `number or string`
 
Returns:
- **count** `number`
@param item number 
]]
function ni.item.count(item)
   return GetItemCount(item, false, false)
end

--[[--
Checks if the item is in the players bags.
 
Parameters:
- **item** `number or string`
 
Returns:
- **has_item** `boolean`
@param item number
]]
function ni.item.is_present(item)
   return ni.item.count(item) > 0
end

--[[--
Uses the item in the players bags
 
Parameters:
- **item** `number or string`
- **target** `string`
@param item
@param[opt] target string
]]
function ni.item.use(item, target)
   if type(item) == "number" then
      item = ni.item.info(item)
   end
   return ni.client.call_protected("UseItemByName", item, target)
end

--[[--
Gets the cooldown information of an item
 
Parameters:
- **item** `number`
 
Returns:
- **start_time** `number`
- **duration** `number`
- **enabled** `number`
@param item number
]]
function ni.item.cooldown(item)
   return GetItemCooldown(item)
end

--[[--
Gets the cooldown time remaining of an item
 
Parameters:
- **item** `number`
 
Returns:
- **cooldown** `number`
@param item number
]]
function ni.item.cooldown_remaining(item)
   local start, duration, enabled = ni.item.cooldown(item)
   if start > 0 and duration > 0 then
      return start + duration - ni.client.get_time()
   end
   return 0
end

--[[--
Checks if an item is equippable
 
Parameters:
- **item** `string or number`
 
Returns:
- **is_equippable** `boolean`
@param item
]]
function ni.item.is_equippable(item)
   return IsEquippableItem(item) ~= nil
end
