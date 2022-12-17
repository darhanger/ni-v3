-------------------
-- Objects functions for ni
local ni = ...

ni.objects = {}

--[[--
@local
Enumeration callback for getting the objects
 
Parameters:
- **t** `number`
- **g** `string`
- **n** `string`
@param t
@param g
@param n
]]
local function enumerate(t, g, n)
   local enumeration_table = {type = t, guid = g, name = n}
   ni.objects[g] = enumeration_table
end

local time_since_last = 0

--[[--
Updates the objects table on call.
]]
function ni.objects.update(elapsed)
   time_since_last = time_since_last + elapsed
   if not ni.in_game then
      ni.table.owipe(ni.objects)
      return
   end

   if time_since_last > (ni.settings.main.latency / 1000) then
      for k, v in ni.table.opairs(ni.objects) do
         if not ni.object.exists(k) then
            ni.objects[k] = nil
         end
      end
      ni.backend.GetObjects(enumerate)
      time_since_last = 0
   end
end