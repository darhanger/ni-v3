-------------------
-- Table functions for ni
local ni = ...

ni.table = {}

local type = ni.client.get_function("type")

--[[--
Gets the next key/value pair from a table.
 
Parameters:
- **table** `table`
- **key**
 
Returns:
- **key**
- **value**
@param table
@param key
]]
function ni.table.next(table, key)
   return ni.backend.Next(table, key)
end

--[[--
Implementation of pairs.
 
Parameters:
- **table** `table`
 
Returns:
- **key**
- **value**
@param table table
]]
function ni.table.pairs(table)
   local function iterator(table, k)
      local v
      k, v = ni.table.next(table, k)
      -- Explicitly checking it's not nil, because it could be false
      if v ~= nil then
         return k, v
      end
   end
   return iterator, table, nil
end

--[[--
Implementation of ipairs.
 
Parameters:
- **table** `table`
 
Returns:
- **key** `number`
- **value**
@param table table
]]
function ni.table.ipairs(table)
   local function iterator(table, i)
      i = i + 1
      local v = table[i]
      -- Explicitly checking it's not nil, because it could be false
      if v ~= nil then
         return i, v
      end
   end
   return iterator, table, 0
end

--[[--
Implementation of pairs iterator for the objects table.
 
Parameters:
- **table** `table`
 
Returns:
- **key** `number`
- **value**
@param table table
]]
function ni.table.opairs(table)
   local function iterator(t, k)
      local v
      repeat
         k, v = ni.table.next(t, k)
         if type(k) == "string" and type(v) == "table" then
            return k, v
         end
      until not k
   end
   return iterator, table, nil
end

--[[--
Checks if a table contains a key.
 
Parameters:
- **table** `table`
- **key** `table`
 
Returns:
- **contains** `boolean`
@param table table
@param key
]]
function ni.table.contains_key(table, key)
   return table[key] ~= nil
end

--[[--
Checks if a table contains a value.
 
Returns:
- **contains** `boolean`
@param table table
@param value
]]
function ni.table.contains_value(table, value)
   for _, v in ni.table.pairs(table) do
      if v == value then
         return true
      end
   end
   return false
end

--[[--
Gets the tables length
 
Returns:
- **length** `number`
@param table table
]]
function ni.table.length(table)
   local count = 0
   for _ in ni.table.pairs(table) do count = count + 1 end
   return count
end

--[[--
Wipes a table
 
Parameters:
- **table** `table`
@param table table
]]
function ni.table.wipe(table)
   for k, v in ni.table.pairs(table) do
      table[k] = nil
   end
end

--[[--
Wipes a object table
 
Parameters:
- **table** `table`
@param table table
]]
function ni.table.owipe(table)
   for k, v in ni.table.opairs(table) do
      table[k] = nil
   end
end