local ni, tab = ...

local current_creatures = ni.player.get_creature_tracking()
local update_creatures
local creature_settings = {
   [1] = {
      name = "None",
      value = 0,
      callback = function(checked)
         if checked then
            current_creatures = 0
         end
         update_creatures()
      end
   },
   [2] = {
      name = "All",
      value = -1,
      offset = 49,
      callback = function(checked)
         if checked then
            current_creatures = -1
         else
            current_creatures = 0
         end
         update_creatures()
      end
   },
   [3] = {
      name = "Beasts",
      value = 0x1,
      callback = function(checked)
         if checked then
            current_creatures = ni.utilities.set_bit(current_creatures, 0x1)
         else
            current_creatures = ni.utilities.clear_bit(current_creatures, 0x1)
         end
         update_creatures()
      end
   },
   [4] = {
      name = "Dragons",
      value = 0x2,
      offset = 35,
      callback = function(checked)
         if checked then
            current_creatures = ni.utilities.set_bit(current_creatures, 0x2)
         else
            current_creatures = ni.utilities.clear_bit(current_creatures, 0x2)
         end
         update_creatures()
      end
   },
   [5] = {
      name = "Demons",
      value = 0x4,
      callback = function(checked)
         if checked then
            current_creatures = ni.utilities.set_bit(current_creatures, 0x4)
         else
            current_creatures = ni.utilities.clear_bit(current_creatures, 0x4)
         end
         update_creatures()
      end
   },
   [6] = {
      name = "Elementals",
      value = 0x8,
      offset = 35,
      callback = function(checked)
         if checked then
            current_creatures = ni.utilities.set_bit(current_creatures, 0x8)
         else
            current_creatures = ni.utilities.clear_bit(current_creatures, 0x8)
         end
         update_creatures()
      end
   },
   [7] = {
      name = "Giants",
      value = 0x10,
      callback = function(checked)
         if checked then
            current_creatures = ni.utilities.set_bit(current_creatures, 0x10)
         else
            current_creatures = ni.utilities.clear_bit(current_creatures, 0x10)
         end
         update_creatures()
      end
   },
   [8] = {
      name = "Undead",
      value = 0x20,
      offset = 35,
      callback = function(checked)
         if checked then
            current_creatures = ni.utilities.set_bit(current_creatures, 0x20)
         else
            current_creatures = ni.utilities.clear_bit(current_creatures, 0x20)
         end
         update_creatures()
      end
   },
   [9] = {
      name = "Humanoid",
      value = 0x40,
      callback = function(checked)
         if checked then
            current_creatures = ni.utilities.set_bit(current_creatures, 0x40)
         else
            current_creatures = ni.utilities.clear_bit(current_creatures, 0x40)
         end
         update_creatures()
      end
   },
   [10] = {
      name = "Critters",
      value = 0x80,
      offset = 21,
      callback = function(checked)
         if checked then
            current_creatures = ni.utilities.set_bit(current_creatures, 0x80)
         else
            current_creatures = ni.utilities.clear_bit(current_creatures, 0x80)
         end
         update_creatures()
      end
   },
   [11] = {
      name = "Machines",
      value = 0x100,
      callback = function(checked)
         if checked then
            current_creatures = ni.utilities.set_bit(current_creatures, 0x100)
         else
            current_creatures = ni.utilities.clear_bit(current_creatures, 0x100)
         end
         update_creatures()
      end
   },
   [12] = {
      name = "Slimes",
      value = 0x200,
      offset = 21,
      callback = function(checked)
         if checked then
            current_creatures = ni.utilities.set_bit(current_creatures, 0x200)
         else
            current_creatures = ni.utilities.clear_bit(current_creatures, 0x200)
         end
         update_creatures()
      end
   },
   [13] = {
      name = "Totem",
      value = 0x400,
      callback = function(checked)
         if checked then
            current_creatures = ni.utilities.set_bit(current_creatures, 0x400)
         else
            current_creatures = ni.utilities.clear_bit(current_creatures, 0x400)
         end
         update_creatures()
      end
   },
   [14] = {
      name = "Non-combat Pet",
      value = 0x800,
      offset = 42,
      callback = function(checked)
         if checked then
            current_creatures = ni.utilities.set_bit(current_creatures, 0x800)
         else
            current_creatures = ni.utilities.clear_bit(current_creatures, 0x800)
         end
         update_creatures()
      end
   },
   [15] = {
      name = "Gas Cloud",
      value = 0x1000,
      callback = function(checked)
         if checked then
            current_creatures = ni.utilities.set_bit(current_creatures, 0x1000)
         else
            current_creatures = ni.utilities.clear_bit(current_creatures, 0x1000)
         end
         update_creatures()
      end
   }
}

-- Doing it this way because we made the function local above
update_creatures = function()
   for k, v in ni.table.ipairs(creature_settings) do
      if current_creatures == -1 and v.value ~= 0 then
         v.element.Checked = true
      elseif current_creatures == 0 and v.value == 0 then
         v.element.Checked = true
      elseif v.value ~=-1 and ni.utilities.has_bit(current_creatures, v.value) then
         v.element.Checked = true
      else
         v.element.Checked = false
      end
   end
   ni.player.set_creature_tracking(current_creatures)
end

for key, value in ni.table.ipairs(creature_settings) do
   local box = ni.ui.checkbox(tab, key % 2 == 0)
   box.Text = value.name
   if value.offset then
      box.OffsetX = value.offset
   end
   if value.name == "None" or value.name == "All" then
      box.Checked = current_creatures == value.value
   else
      box.Checked = ni.utilities.has_bit(current_creatures, value.value)
   end
   box.Callback = value.callback
   value.element = box
end