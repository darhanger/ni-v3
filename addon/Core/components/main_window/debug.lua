local ni, tab = ...

local build = ni.client.build()
local GetNumSpellTabs = ni.client.get_function("GetNumSpellTabs")
if not GetNumSpellTabs then
   ni.backend.Error("Unable to get GetNumSpellTabs")
end
local GetSpellTabInfo = ni.client.get_function("GetSpellTabInfo")
if not GetSpellTabInfo then
   ni.backend.Error("Unable to get GetSpellTabInfo")
end
local GetSpellBookItemInfo = ni.client.get_function("GetSpellBookItemInfo")
if not GetSpellBookItemInfo and build > 12340 then
   ni.backend.Error("Unable to get GetSpellBookItemInfo")
end
local GetFlyoutInfo = ni.client.get_function("GetFlyoutInfo")
--local GetFlyoutSlotInfo = ni.client.get_function("GetFlyoutSlotInfo") --Crashing WoW!

local GetSpellName = ni.client.get_function("GetSpellName")
if not GetSpellName and build == 12340 then
   ni.backend.Error("Unable to get GetSpellName")
end
local GetGlyphSocketInfo = ni.client.get_function("GetGlyphSocketInfo")
local GetNumGlyphSockets = ni.client.get_function("GetNumGlyphSockets")

local function stripname(name)
   name = string.gsub(name, "%s+", "")
   name = string.gsub(name, "'", "")
   name = string.gsub(name, "-", "")
   name = string.gsub(name, ":", "")
   name = string.gsub(name, ",", "")
   return name
end


local dump_ni = ni.ui.button(tab)
dump_ni.Text = "Ni Dump"
dump_ni.Callback = function()
   local string_dump = "Ni\n"
   local buffs = ni
   for index, value in ni.table.pairs(buffs) do
      local b = "["..index.."] "
      for i, v in ni.table.pairs(value) do
         b = b .. tostring(v).. ", "
         if type(v) == "table" then
            b = b .. "\n --Table: "
            for i2, v2 in ni.table.pairs(v) do
               b = b .. tostring(v2).. ", "
               if type(v2) == "table" then
                  b = b .. "\n   **Table: "
                  for i3, v3 in ni.table.pairs(v2) do
                     b = b .. tostring(v3).. ", "
                  end
               end
            end
         end
      end
      b = b.."\n"
      string_dump = string_dump..b
   end
   ni.utilities.log(string_dump)
end

ni.ui.separator(tab)

local function object_type(type)
   if type == 0 then
      return "Object"
   elseif type == 1 then
      return "Item"
   elseif type == 2 then
      return "Container"
   elseif type == 3 then
      return "Unit"
   elseif type == 4 then
      return "Player"
   elseif type == 5 then
      return "GameObject"
   elseif type == 6 then
      return "DynamicObject"
   elseif type == 7 then
      return "Corpse"
   elseif type == 8 then
      return "AiGroup"
   elseif type == 9 then
      return "AreaTrigger"
   end
end

local object_button = ni.ui.button(tab)
object_button.Text = "Dump All"
object_button.Callback = function()
   local string_dump = "Objects Dump\n"
   for k, v in ni.table.opairs(ni.objects) do
      string_dump = string_dump .. string.format("[%s] type = %s, guid = %s, name = %s, display_id = %s\n", k, object_type(v.type), v.guid, v.name, ni.object.display_id(k))
   end
   ni.utilities.log(string_dump)
end

local game_objects = ni.ui.button(tab)
game_objects.Text = "Dump Game Objects"
game_objects.Callback = function()
   local string_dump = "Objects Dump\n"
   local objects = ni.objects
   for k, v in ni.table.opairs(objects) do
      local distance = ni.player.distanceV3(k)
      if v.type == 5 and distance <= 100 then
         string_dump = string_dump .. string.format("[%s] name = %s, display_id = %s, distance = %s\n", k, v.name, ni.object.display_id(k), distance)
         for i = 1, 0x8 do
            local d = ni.object.descriptor(k, i)
            if d ~= nil then
               string_dump = string_dump .. string.format("Descriptor %s: %s\n", i, d)
            end
         end
         string_dump = string_dump .. "\n"
      end
   end
   ni.utilities.log(string_dump)
end

ni.ui.separator(tab)

local enemies_button = ni.ui.button(tab)
enemies_button.Text = "Dump Enemies Player 100"
enemies_button.Callback = function()
   local enemies = ni.unit.enemies_in_range("player", 100)
   local string_dump = "Enemies Dump\n"
   string_dump = string_dump .. string.format("Found %s targets \n", ni.table.length(enemies))
   for k, v in ni.table.opairs(enemies) do
      string_dump =
         string_dump ..
         string.format("[%s] type = %s, guid = %s, name = %s, distance = %s\n", k, v.type, v.guid, v.name, v.distance)
   end
   ni.utilities.log(string_dump)
end

local enemies_button_target = ni.ui.button(tab)
enemies_button_target.Text = "Dump Enemies Target 20"
enemies_button_target.Callback = function()
   local enemies = ni.unit.enemies_in_range("target", 20)
   local string_dump = "Enemies Dump Target\n"
   string_dump = string_dump .. string.format("Found %s targets \n", ni.table.length(enemies))
   for k, v in ni.table.opairs(enemies) do
      string_dump =
         string_dump ..
         string.format("[%s] type = %s, guid = %s, name = %s, distance = %s\n", k, v.type, v.guid, v.name, v.distance)
   end
   ni.utilities.log(string_dump)
end

local friends_button = ni.ui.button(tab)
friends_button.Text = "Dump Friends"
friends_button.Callback = function()
   local friends = ni.unit.friends_in_range("player", 100)
   local string_dump = "Friends Dump\n"
   for k, v in ni.table.opairs(friends) do
      string_dump =
         string_dump ..
         string.format("[%s] type = %s, guid = %s, name = %s, distance = %s\n", k, v.type, v.guid, v.name, v.distance)
   end
   ni.utilities.log(string_dump)
end

local party_button = ni.ui.button(tab)
party_button.Text = "Dump Party Members"
party_button.Callback = function()
   local party = ni.members
   local string_dump = "Party Dump\n"
   for k, v in ni.table.opairs(party) do
      string_dump =
         string_dump ..
         string.format(
            "[%s] %s, health_percent = %s\n",
            k,
            v.name(),
            v.health_percent())
   end
   ni.utilities.log(string_dump)
end

local pet_button = ni.ui.button(tab)
pet_button.Text = "Dump Pet"
pet_button.Callback = function()
   local has_pet = ni.pet.exists()
   local string_dump = "Pet Dump\n"
   if not has_pet then
      string_dump = string_dump.."No pet found"
   else
      string_dump = string_dump.."Pet found\n"
      for i = 1, 10 do
         local name = ni.pet.action_info(i)
         if name then
            string_dump = string_dump.. string.format("local %s = %s", stripname(name), i)
         end
         string_dump = string_dump .. "\n"
      end
   end
   ni.utilities.log(string_dump)
end

ni.ui.separator(tab)

local unit_flags = ni.ui.button(tab)
unit_flags.Text = "UnitFlags Player"
unit_flags.Callback = function()
   local string_dump = "ni.unit.flags Player\n"
   local flags = {ni.unit.flags("player")}
   for k, v in ni.table.pairs(flags) do
      string_dump = string_dump .. string.format("Flag %s: %s\n", k, tostring(flags[v]))
   end
   ni.utilities.log(string_dump)
end

local unit_flags_target = ni.ui.button(tab)
unit_flags_target.Text = "UnitFlags Target"
unit_flags_target.Callback = function()
   local t = ni.unit.name("target")
   local string_dump = string.format("ni.unit.flags %s\n", t)
   local flags = {ni.unit.flags("target")}
   for k, v in ni.table.pairs(flags) do
      string_dump = string_dump .. string.format("Flag %s: %s\n", k, tostring(flags[v]))
   end
   ni.utilities.log(string_dump)
end

local playerDynamicFlags = ni.ui.button(tab)
playerDynamicFlags.Text = "UnitDynamicFlags Player"
playerDynamicFlags.Callback = function()
   local string_dump = "ni.unit.dynamic_flags Player\n"
   local flags = {ni.unit.dynamic_flags("player")}
   for k, v in ni.table.pairs(flags) do
      string_dump = string_dump .. string.format("Flag %s: %s\n", k, tostring(flags[v]))
   end
   ni.utilities.log(string_dump)
end

local UnitDynamicFlags = ni.ui.button(tab)
UnitDynamicFlags.Text = "UnitDynamicFlags Target"
UnitDynamicFlags.Callback = function()
   local t = ni.unit.name("target")
   local string_dump = string.format("ni.unit.dynamic_flags %s\n", t)
   local flags = {ni.unit.dynamic_flags("target")}
   for k, v in ni.table.pairs(flags) do
      string_dump = string_dump .. string.format("Flag %s: %s\n", k, tostring(flags[v]))
   end
   ni.utilities.log(string_dump)
end

local descriptor = ni.ui.button(tab)
descriptor.Text = "Descriptor Target"
descriptor.Callback = function()
   local t = ni.unit.name("target")
   local string_dump = string.format("ni.object.descriptor %s\n", t)
   for i = 1, 30 do
      local d = ni.object.descriptor("target", i)
      if d ~= nil then
         string_dump = string_dump .. string.format("%s: %s\n", i, d)
      end
   end
   ni.utilities.log(string_dump)
end

ni.ui.separator(tab)

local player_auras = ni.ui.button(tab)
player_auras.Text = "Player Buffs"
player_auras.Callback = function()
   local string_dump = "Player Buffs\n"
   local buffs = ni.player.buffs()
   for index, value in ni.table.pairs(buffs) do
      local b = "["..index.."] "
      for i, v in ni.table.pairs(value) do
         b = b .."["..i.."]".. tostring(v).. ", "
      end
      b = b.."\n"
      string_dump = string_dump..b
   end
   ni.utilities.log(string_dump)
end

local player_auras = ni.ui.button(tab)
player_auras.Text = "Player DeBuffs"
player_auras.Callback = function()
   local string_dump = "Player DeBuffs\n"
   local buffs = ni.player.debuffs()
   for index, value in ni.table.pairs(buffs) do
      local b = "["..index.."] "
      for i, v in ni.table.pairs(value) do
         b = b .."["..i.."]".. tostring(v).. ", "
      end
      b = b.."\n"
      string_dump = string_dump..b
   end
   ni.utilities.log(string_dump)
end

local player_auras = ni.ui.button(tab)
player_auras.Text = "Target Buffs"
player_auras.Callback = function()
   local string_dump = "Target Buffs\n"
   local buffs = ni.unit.buffs("target")
   for index, value in ni.table.pairs(buffs) do
      local b = "["..index.."] "
      for i, v in ni.table.pairs(value) do
         b = b .."["..i.."]".. tostring(v).. ", "
      end
      b = b.."\n"
      string_dump = string_dump..b
   end
   ni.utilities.log(string_dump)
end

local player_auras = ni.ui.button(tab)
player_auras.Text = "Target DeBuffs"
player_auras.Callback = function()
   local string_dump = "Target DeBuffs\n"
   local buffs = ni.unit.debuffs("target")
   for index, value in ni.table.pairs(buffs) do
      local b = "["..index.."] "
      for i, v in ni.table.pairs(value) do
         b = b .."["..i.."]".. tostring(v).. ", "
      end
      b = b.."\n"
      string_dump = string_dump..b
   end
   ni.utilities.log(string_dump)
end

ni.ui.separator(tab)

local spell_button = ni.ui.button(tab)
spell_button.Text = "Dump Spell Book"
spell_button.Callback = function()
   ni.utilities.log("Spells Dump")
   local spell_string = "--Version: " .. build .. "\n"
   local pet_string = "--Pet\n"
   local tabs = GetNumSpellTabs()
   for i = 1, tabs do
      local tabname,
         _,
         offset,
         numSpells,
         _,
         offspecID = GetSpellTabInfo(i)
      spell_string = spell_string .. string.format("--%s\n", tabname)
      local tabEnd = offset + numSpells
      local dumped_names = {}
      for j = offset + 1, tabEnd do
         if build == 12340 then
            local spellName, rank = GetSpellName(j, BOOKTYPE_SPELL) --/dump GetSpellName(10, BOOKTYPE_SPELL)
            local spellNamePet, rankPet = GetSpellName(j, BOOKTYPE_PET)
            if spellName and not dumped_names[spellName] then
               local spellId = ni.spell.id(spellName)
               if not spellId then
                  spell_string = spell_string .. string.format("  --Failed to get id for %s (%s)\n", spellName, rank)
               end
               spell_string = spell_string .. string.format("   %s = {id = %s, name = ni.spell.info(%s)},\n",
                     stripname(spellName),
                     spellId,
                     spellId,
                     spellId
                  )
                  dumped_names[spellName] = spellId
            end
            if spellNamePet and not dumped_names[spellNamePet] then
               local spellId = ni.spell.id(spellNamePet)
               if not spellId then
                  pet_string = pet_string .. string.format("  --Failed to get id for %s (%s)\n", spellNamePet, rankPet)
               end
               pet_string = pet_string .. string.format("   %s = {id = %s, name = ni.spell.info(%s)},\n",
                     stripname(spellNamePet),
                     spellId,
                     spellId,
                     spellId
                  )
                  dumped_names[spellNamePet] = spellId
            end
         elseif build > 12340 then
            if offspecID == nil or offspecID == 0 then
               local type,
                  id = GetSpellBookItemInfo(j, "player")
               if type == "FLYOUT" then
                  local _,
                     _,
                     numSlots = GetFlyoutInfo(id)
                  for o = 1, numSlots do
                     local flyoutID = GetFlyoutSlotInfo(id, o)
                     local flyoutname = ni.spell.info(flyoutID)
                     spell_string =
                        spell_string ..
                        string.format(
                           "   %s = {id = %s, name = ni.spell.info(%s)},\n",
                           stripname(flyoutname),
                           flyoutID,
                           flyoutID,
                           flyoutID
                        )
                  end
               end
               if (type == "SPELL" or type == "FUTURESPELL") then
                  local spellname,
                     rank = ni.spell.info(id)
                  if not string.match(rank, "Guild") then
                     if (string.match(rank, "Cat")) then
                        spellname = spellname .. "Cat"
                     end
                     if (string.match(rank, "Bear")) then
                        spellname = spellname .. "Bear"
                     end
                     spell_string =
                        spell_string ..
                        string.format("   %s = {id = %s, name = ni.spell.info(%s)},\n", stripname(spellname), id, id, id)
                  end
               end
            end
         end
      end
   end
   if string.len(pet_string) > 6 then
      spell_string = spell_string ..pet_string
   end
   ni.utilities.log(spell_string)

end

local glyph_button = ni.ui.button(tab)
glyph_button.Text = "Dump Glyphs"
glyph_button.Callback = function ()
   local glyph_string = "--Glyphs Dump\n"
   for slot = 1, GetNumGlyphSockets() do
      local enabled, glyph_type, glyph_id
      if build >= 15595 then
         enabled, _, _, glyph_id = GetGlyphSocketInfo(slot)
      else
         enabled, _, glyph_id = GetGlyphSocketInfo(slot)
      end
      if glyph_id and glyph_id ~= 0 then
         local name = ni.spell.info(glyph_id)
         glyph_string = glyph_string .. string.format("local %s = ni.player.has_glyph(%s) \n", stripname(name), glyph_id)
      end
   end
   ni.utilities.log(glyph_string)
end

local mounts_button = ni.ui.button(tab)
mounts_button.Text = "Dump Mounts"
mounts_button.Callback = function ()
   local mounts_string = "--Mounts Dump\n"
   local mounts = ni.mount.mounts()
   for k, v in ni.table.pairs(mounts) do
      mounts_string = mounts_string .. string.format("[%s] %s, summoned = %s,\n", k, v.name, tostring(v.summoned))
   end
   ni.utilities.log(mounts_string)
end

ni.ui.separator(tab)

local Pointer = ni.ui.button(tab)
Pointer.Text = "Memory Pointer Target"
Pointer.Callback = function()
   local t = ni.unit.name("target")
   local string_dump = string.format("ni.memory.pointer %s\n", t)
   local pointer, hex_pointer = ni.memory.pointer("target")
   if pointer then
      string_dump = string_dump .. string.format("point: %s hex_pointer: %s", pointer, hex_pointer)
   end
   ni.utilities.log(string_dump)
end

local type = ni.ui.combobox(tab)
type.Text = "Type"
local types ={
   "bool", --true/false formatted
   "byte", --number formatted
   "string", --string formatted
   "float", --number formatted
   "double", --number formatted
   "int16","short", --number formatted
   "int32","int", --number formatted
   "int64", --string formatted formatted
   "uint16","ushort", --number formatted
   "uint","uint32", --number formatted
   "uint64","GUID" --string formatted
}
for key, value in pairs(types) do
   type:Add(value)
end

local offset = ni.ui.input(tab)
offset.Text = "Offset"

local reader = ni.ui.button(tab)
reader.Text = "Memory Read"
reader.Callback = function()
   local string_dump = string.format("ni.memory.read %s %s\n", type.Value, offset.Value)
   local read = ni.memory.read(type.Value, offset.Value)
   if read then
      string_dump = string_dump .. tostring(read)
   end
   ni.utilities.log(string_dump)
end

ni.ui.separator(tab)

local navigation_target = ni.ui.button(tab)
navigation_target.Text = "navigation target"
navigation_target.Callback = function()
   local x1, y1, z1 = ni.player.location()
   local x2, y2, z2 = ni.unit.location("target")
   local start_x, start_y, start_z = x1, y1, z1
   local path = ni.navigation.get_path(x1, y1, z1, x2, y2, z2)
   local start_distance = ni.world.get_3d_distance(start_x, start_y, start_z, x2, y2, z2)
   local string_dump = string.format("navigation.get_path %s Distance: %s\n", ni.unit.name("target"), start_distance)

   for i, v in ni.table.pairs(path) do
      local distance = ni.world.get_3d_distance(start_x, start_y, start_z, v.x, v.y, v.z)
      string_dump = string_dump .. string.format("[%s]x: %s y: %s z: %s distance: %s\n", i, v.x, v.y, v.z, distance)
      start_x = v.x
      start_y = v.y
      start_z = v.z
   end

   local end_distance = ni.world.get_3d_distance(start_x, start_y, start_z, x2, y2, z2)
   string_dump = string_dump .. string.format("Distance from last to target %s\n", end_distance)
   ni.utilities.log(string_dump)
end