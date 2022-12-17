local ni = ...

ni.settings = {}

local base_path = ni.backend.GetBaseFolder()

ni.settings.path = base_path .. "addon\\settings\\"


--[[--
Saves the settings table to dest as a json file
 
Parameters:
- **table** `table`
- **file** `string`
 
Returns:
- **saved** `boolean`
@param file string
@param content string
]]
function ni.settings.save(file, table)
   local json, jerror = ni.utilities.to_json(table)
   if jerror then
      ni.client.error(jerror)
   end
   if ni.io.save_content(file, json) then
      ni.utilities.log("ni.settings.save "..file .. json)
      return true
   end
   return false
end

--[[--
Loads the settings json file as a table
 
Parameters:
- **file** `string`
 
Returns:
- **table** `table`
@param file string
]]
function ni.settings.load(file)
   local content, cerr = ni.io.get_content(file)
   if cerr then
      ni.client.error(cerr)
   end
   if content then
      local json, jerror = ni.utilities.from_json(content)
      if jerror then
         ni.client.error(jerror)
      end
      local print_settings = "ni.settings.load ".. file .."\n"
      for k, v in ni.table.pairs(json) do
        print_settings = print_settings .. "["..k.."] = " .. tostring(v).."\n"
        if type(v) == "table" then
            for k2, v2 in ni.table.pairs(v) do
               print_settings = print_settings .. "   ["..k2.."] = " .. tostring(v2).."\n"
               if type(v2) == "table" then
                  for k3, v3 in ni.table.pairs(v2) do
                     print_settings = print_settings .. "      ["..k3.."] = " .. tostring(v3).."\n"
                  end
               end
            end
         end
      end
      ni.utilities.log(print_settings)
      return json
   end
end

--[[--
Default main settings
]]
ni.settings.main = {
   latency = 200,
   debug_tab = false,
   keys ={
      toggle = "F10",
      primary = "F1",
      secondary = "F2",
      generic = "F3",
   },
   profiles = {
      primary = {
         name = "None",
         enabled = false
      },
      secondary = {
         name = "None",
         enabled = false
      },
      generic = {
         name = "None",
         enabled = false
      },
   }
}

ni.settings.profile = {}
