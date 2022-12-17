-------------------
-- Mount functions
local ni = ...

ni.mount = {}

-- Localizations
local IsMounted = ni.client.get_function("IsMounted")
local GetNumCompanions = ni.client.get_function("GetNumCompanions")
local GetCompanionInfo = ni.client.get_function("GetCompanionInfo")
local mount = "MOUNT"

--[[--
Dismounts the player if the player was mounted.
]]
function ni.mount.dismount()
   return ni.client.call_protected("Dismount")
end

--[[--
Summons the mount by slot
]]
function ni.mount.summon(slot)
   return ni.client.call_protected("CallCompanion", mount, slot)
end

--[[--
Returns if the player is mounted
 
Returns:
- **is_mounted** `boolean`
]]
function ni.mount.is_mounted()
   return IsMounted()
end

--[[--
Returns the number of mounts you have.
 
Returns:
- **mounts** `number`
]]
function ni.mount.count()
   return GetNumCompanions(mount)
end

--[[--
Gets the mount information
 
Parameters:
- **slot** `number`
 
Returns:
- **...**
 
Notes:
Wrapper for GetCompanionInfo. See that for appropriate documentation.
creatureID, creatureName, creatureSpellID, icon, issummoned, mountTypeID
@param slot
]]
function ni.mount.info(slot)
   return GetCompanionInfo(mount, slot)
end

--[[--
Table keys:
- **slot** `number`
- **id** `number`
- **name** `string`
- **spell_id** `number`
- **summoned** `boolean`
@table mounts
]]

--[[--
Returns a table of all player mounts
 
Returns:
- [`mounts table`](#mounts)
]]
function ni.mount.mounts()
   local mounts = {}
   for i = 1, ni.mount.count() do
      local creatureID, creatureName, creatureSpellID, _, issummoned = ni.mount.info(i)
      mounts[i] = {
         slot = i,
         id = creatureID,
         name = creatureName,
         spell_id = creatureSpellID,
         summoned = issummoned == 1
      }
   end
   return mounts
end