local ni = ...

local build = ni.client.build()

ni.profiles = {}
ni.profiles.class = {}
ni.profiles.generic = {}

--[[
Populates ni.profile.class and ni.profile.generic from the rotation directory
]]
function ni.profiles.get_profiles()
   local class = ni.player.class():lower()
   local contents = ni.io.get_folders("addon\\Rotations\\") or {}
   for i = 1, #contents do
      if string.match(contents[i]:lower(), class) then
         local entries = ni.io.get_entries(contents[i]) or {}
            for e = 1, #entries do
               local version = 0
               ni.backend.ParseFile(
                  entries[e].path,
                  function(content)
                     version = tonumber(string.match(content, "--Version:%s*(%d[,.%d]*)"))
                  end
               )
               if entries[e].extension == ".lua" or entries[e].extension == ".enc" then
                  ni.profiles.class[entries[e].stem] =
                  {
                     version = version,
                     stem = entries[e].stem,
                     extension= entries[e].extension,
                     filename = entries[e].filename,
                     path = entries[e].path
                  }
               end
            end
      end
      if string.match(contents[i], "Generic") then
         local entries = ni.io.get_entries(contents[i]) or {}
         for e = 1, #entries do
            if entries[e].extension == ".lua" or entries[e].extension == ".enc" then
               local version = 0
               ni.backend.ParseFile(
                  entries[e].path,
                  function(content)
                     version = tonumber(string.match(content, "--Version:%s*(%d[,.%d]*)"))
                  end
               )
               if entries[e].extension == ".lua" or entries[e].extension == ".enc" then
                  ni.profiles.generic[entries[e].stem] =
                  {
                     version = version,
                     stem = entries[e].stem,
                     extension= entries[e].extension,
                     filename = entries[e].filename,
                     path = entries[e].path
                  }
               end
            end
         end
      end
   end
end

--[[
Loads all the profiles that match the current build version into memory
]]
function ni.profiles.load_all()
   for k, v in ni.table.opairs(ni.profiles.class) do
      if v.version == build then
         local _, error = ni.io.load_entry(v)
         if error then
            ni.client.error(error)
         end
      end
   end
   for k, v in ni.table.opairs(ni.profiles.generic) do
      if v.version == build then
         ni.utilities.log(tostring(k))
         local _, error = ni.io.load_entry(v)
         if error then
            ni.client.error(error)
         end
      end
   end
end
