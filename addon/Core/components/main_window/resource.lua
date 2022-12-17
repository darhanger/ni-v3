local ni, tab = ...

local current_resources = ni.player.get_resource_tracking()
local update_resources
local resource_settings = {
   [1] = {
      name = "None",
      value = 0,
      callback = function(checked)
         if checked then
            current_resources = 0
         end
         update_resources()
      end
   },
   [2] = {
      name = "All",
      value = -1,
      offset = 49,
      callback = function(checked)
         if checked then
            current_resources = -1
         else
            current_resources = 0
         end
         update_resources()
      end
   },
   [3] = {
      name = "Lockpicking",
      value = 0x1,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x1)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x1)
         end
         update_resources()
      end
   },
   [4] = {
      name = "Herbs",
      value = 0x2,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x2)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x2)
         end
         update_resources()
      end
   },
   [5] = {
      name = "Minerals",
      value = 0x4,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x4)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x4)
         end
         update_resources()
      end
   },
   [6] = {
      name = "Disarm Traps",
      value = 0x8,
      offset = 21,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x8)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x8)
         end
         update_resources()
      end
   },
   [7] = {
      name = "Open",
      value = 0x10,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x10)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x10)
         end
         update_resources()
      end
   },
   [8] = {
      name = "Treasure",
      value = 0x20,
      offset = 49,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x20)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x20)
         end
         update_resources()
      end
   },
   [10] = {
      name = "Calcified Elven Gems",
      value = 0x40,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x40)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x40)
         end
         update_resources()
      end
   },
   [9] = {
      name = "Close Track",
      value = 0x80,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x80)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x80)
         end
         update_resources()
      end
   },
   [11] = {
      name = "Quick Open",
      value = 0x200,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x200)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x200)
         end
         update_resources()
      end
   },
   [12] = {
      name = "Quick Close",
      value = 0x400,
      offset = 7,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x400)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x400)
         end
         update_resources()
      end
   },
   [13] = {
      name = "Arm Trap",
      value = 0x100,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x100)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x100)
         end
         update_resources()
      end
   },
   [14] = {
      name = "Open Tinkering",
      value = 0x800,
      offset = 21,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x800)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x800)
         end
         update_resources()
      end
   },
   [15] = {
      name = "Blasting",
      value = 0x8000,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x8000)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x8000)
         end
         update_resources()
      end
   },
   [16] = {
      name = "Open Attacking",
      value = 0x2000,
      offset = 21,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x2000)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x2000)
         end
         update_resources()
      end
   },
   [17] = {
      name = "Gahzridian",
      value = 0x4000,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x4000)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x4000)
         end
         update_resources()
      end
   },
   [18] = {
      name = "Open Kneeling",
      value = 0x1000,
      offset = 7,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x1000)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x1000)
         end
         update_resources()
      end
   },
   [19] = {
      name = "PvP Open",
      value = 0x10000,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x10000)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x10000)
         end
         update_resources()
      end
   },
   [20] = {
      name = "PvP Close",
      value = 0x20000,
      offset = 21,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x20000)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x20000)
         end
         update_resources()
      end
   },
   [21] = {
      name = "Fishing",
      value = 0x40000,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x40000)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x40000)
         end
         update_resources()
      end
   },
   [22] = {
      name = "Inscription",
      value = 0x80000,
      offset = 28,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x80000)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x80000)
         end
         update_resources()
      end
   },
   [23] = {
      name = "Open from vehicle",
      value = 0x100000,
      callback = function(checked)
         if checked then
            current_resources = ni.utilities.set_bit(current_resources, 0x100000)
         else
            current_resources = ni.utilities.clear_bit(current_resources, 0x100000)
         end
         update_resources()
      end
   }
}

-- Doing it this way because we made the function local above
update_resources = function()
   for k, v in ni.table.ipairs(resource_settings) do
      if current_resources == -1 and v.value ~= 0 then
         v.element.Checked = true
      elseif current_resources == 0 and v.value == 0 then
         v.element.Checked = true
      elseif v.value ~=-1 and ni.utilities.has_bit(current_resources, v.value) then
         v.element.Checked = true
      else
         v.element.Checked = false
      end
   end
   ni.player.set_resource_tracking(current_resources)
end

for key, value in ni.table.ipairs(resource_settings) do
   local box = ni.ui.checkbox(tab, key % 2 == 0)
   box.Text = value.name
   if value.offset then
      box.OffsetX = value.offset
   end
   if value.name == "None" or value.name == "All" then
      box.Checked = current_resources == value.value
   else
      box.Checked = ni.utilities.has_bit(current_resources, value.value)
   end
   box.Callback = value.callback
   value.element = box
end