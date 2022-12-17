local ni, core = ...

-- Localize string creation for main folder as it'll be used a few times
local window_folder = core .. "components\\main_window\\"
local build = ni.client.build()

ni.window = ni.ui.window("ni", false)
if ni.window then
   local label = ni.ui.label(ni.window)
   label.Text = "Version: " .. ni.__version
   ni.ui.separator(ni.window)
   local tab_manager = ni.ui.tab_manager(ni.window)
   local main_tab = tab_manager:AddTab("Main")
   local main_tab_manager = ni.ui.tab_manager(main_tab)
   local profile_tab = tab_manager:AddTab("Profile Settings")
   local profile_tab_manager = ni.ui.tab_manager(profile_tab)
   local active_ui ={}
   do
      -- Setup the main window portion
      local selector_tab = main_tab_manager:AddTab("Selector")
      do
         local label = ni.ui.label(selector_tab)
         label.Text = "Primary Profile"
         label.Centered = true
         local combo = ni.ui.combobox(selector_tab)
         combo.Text = "##primary"
         combo.Selected = "None"
         combo:Add("None")
         for k, v in ni.table.opairs(ni.profiles.class) do
            if v.version == build then
               if ni.settings.main.profiles.primary.name == k then
                  combo.Selected = k
                  if ni.profile[k].has_ui then
                     if ni.profile[k].has_ui then
                        local tab = profile_tab_manager:AddTab(k)
                        ni.profile[k].generate_ui(tab)
                        active_ui[k] = true
                     end
                  end
               end
               combo:Add(k)
            end
         end
         combo.Callback = function(selected)
            ni.settings.main.profiles.primary.name = selected
            ni.settings.save(ni.settings.main_path, ni.settings.main)
            if selected ~= "None" and ni.profile[selected].has_ui  then
               if not ni.table.contains_key(active_ui, selected) then
                  local tab = profile_tab_manager:AddTab(selected)
                  ni.profile[selected].generate_ui(tab)
                  active_ui[selected] = true
               end
            end
         end
      end
      do
         local label = ni.ui.label(selector_tab)
         label.Text = "Secondary Profile"
         label.Centered = true
         local combo = ni.ui.combobox(selector_tab)
         combo.Text = "##secondary"
         combo.Selected = "None"
         combo:Add("None")
         for k, v in ni.table.opairs(ni.profiles.class) do
            if v.version == build then
               if ni.settings.main.profiles.secondary.name == k then
                  combo.Selected = k
               end
               combo:Add(k)
            end
            combo.Callback = function(selected)
               ni.settings.main.profiles.secondary.name = selected
               ni.settings.save(ni.settings.main_path, ni.settings.main)
               if selected ~= "None" and ni.profile[selected].has_ui  then
                  if not ni.table.contains_key(active_ui, selected) then
                     local tab = profile_tab_manager:AddTab(selected)
                     ni.profile[selected].generate_ui(tab)
                     active_ui[selected] = true
                  end
               end
            end
         end
         do
            local label = ni.ui.label(selector_tab)
            label.Text = "Generic Profile"
            label.Centered = true
            local combo = ni.ui.combobox(selector_tab)
            combo.Text = "##generic"
            combo.Selected = "None"
            combo:Add("None")
            for k, v in ni.table.opairs(ni.profiles.generic) do
               if v.version == build then
                  if ni.settings.main.profiles.generic.name == k then
                     combo.Selected = k
                     if ni.profile[k].has_ui then
                        if ni.profile[k].has_ui then
                           local tab = profile_tab_manager:AddTab(k)
                           ni.profile[k].generate_ui(tab)
                           active_ui[k] = true
                        end
                     end
                  end
                  combo:Add(k)
               end
            end
            combo.Callback = function(selected)
               ni.settings.main.profiles.generic.name = selected
               ni.settings.save(ni.settings.main_path, ni.settings.main)
               if selected ~= "None" and ni.profile[selected].has_ui  then
                  if not ni.table.contains_key(active_ui, selected) then
                     local tab = profile_tab_manager:AddTab(selected)
                     ni.profile[selected].generate_ui(tab)
                     active_ui[selected] = true
                  end
               end
            end
         end
      end
      do
         local settings_tab = main_tab_manager:AddTab("Main Settings")
         do
            local function_keys = {}
            for i = 1, 12 do
               function_keys[i] = string.format("F%d", i)
            end
            local latency_label = ni.ui.label(settings_tab)
            latency_label.Text = "Latency"
            latency_label.Centered = true
            local latency_slider = ni.ui.slider(settings_tab)
            latency_slider.Min = 20
            latency_slider.Max = 1000
            latency_slider.Value = ni.settings.main.latency
            latency_slider.Width = -1
            latency_slider.Text = "##latency"
            latency_slider.Callback = function(value)
               ni.settings.main.latency = value
               ni.settings.save(ni.settings.main_path, ni.settings.main)
            end
            ni.ui.separator(settings_tab)
            local key_label = ni.ui.label(settings_tab)
            key_label.Text = "Toggle Keys"
            key_label.Centered = true
            -- Helper function to avoid typing all this 3 times
            local function setup_toggles(label_text, combo_text, x_offset, combo_selected, combo_items, combo_callback)
               local label = ni.ui.label(settings_tab)
               label.Text = label_text
               label.OffsetY = 3
               local combo = ni.ui.combobox(settings_tab, true)
               combo.Text = combo_text
               combo.OffsetY = -3
               if x_offset then
                  combo.OffsetX = x_offset
               end
               combo.Selected = combo_selected
               for i = 1, #combo_items do
                  combo:Add(combo_items[i])
               end
               combo.Callback = combo_callback
            end
            setup_toggles(
               "UI Toggle:",
               "##uitoggle",
               49,
               ni.settings.main.keys.toggle,
               function_keys,
               function(selected)
                  ni.settings.main.keys.toggle = selected
                  ni.settings.save(ni.settings.main_path, ni.settings.main)
               end
            )
            setup_toggles(
               "Primary Toggle:",
               "##primarytoggle",
               14,
               ni.settings.main.keys.primary,
               function_keys,
               function(selected)
                  ni.settings.main.keys.primary = selected
                  ni.settings.save(ni.settings.main_path, ni.settings.main)
               end
            )
            setup_toggles(
               "Secondary Toggle:",
               "##secondarytoggle",
               nil,
               ni.settings.main.keys.secondary,
               function_keys,
               function(selected)
                  ni.settings.main.keys.secondary = selected
                  ni.settings.save(ni.settings.main_path, ni.settings.main)
               end
            )
            setup_toggles(
               "Generic Toggle:",
               "##generictoggle",
               14,
               ni.settings.main.keys.generic,
               function_keys,
               function(selected)
                  ni.settings.main.keys.generic = selected
                  ni.settings.save(ni.settings.main_path, ni.settings.main)
               end
            )
         end
      end

      local tracker_tab = tab_manager:AddTab("Tracker")
      do
         -- Set up the tracking tabs
         local tracker_tab_manager = ni.ui.tab_manager(tracker_tab)
         do
            local resource_tab = tracker_tab_manager:AddTab("Resources")
            local resource_file = window_folder .. "resource.lua"
            local func,
               err = ni.io.load_buffer(resource_file, string.format("@%s", resource_file))
            if err then
               ni.backend.Error(err)
            end
            func(ni, resource_tab)
         end
         do
            local creature_tab = tracker_tab_manager:AddTab("Creatures")
            local creature_file = window_folder .. "creature.lua"
            local func,
               err = ni.io.load_buffer(creature_file, string.format("@%s", creature_file))
            if err then
               ni.backend.Error(err)
            end
            func(ni, creature_tab)
         end
      end
      if ni.settings.main.debug_tab then
         local debug_tab = tab_manager:AddTab("Debug")
         do
            local debug_file = window_folder .. "debug.lua"
            local func,
               err = ni.io.load_buffer(debug_file, string.format("@%s", debug_file))
            if err then
               ni.backend.Error(err)
            end
            func(ni, debug_tab)
         end
      end

      -- Create the callback for toggling the window open and close
      ni.input.register_callback(
         "ni-main",
         function()
            if ni.input.key_down(ni.settings.main.keys.toggle) then
               ni.window.Open = not ni.window.Open
               return true
            end
            if ni.input.key_down(ni.settings.main.keys.primary) then
               if ni.settings.main.profiles.primary.name ~= "none" and ni.settings.main.profiles.primary.name ~= "None" then
                  ni.settings.main.profiles.primary.enabled = not ni.settings.main.profiles.primary.enabled
                  if ni.settings.main.profiles.primary.enabled then
                     ni.update.register_callback(
                        ni.settings.main.profiles.primary.name,
                        ni.profile[ni.settings.main.profiles.primary.name].execute
                     )
                     ni.utilities.log(ni.settings.main.profiles.primary.name.. " Started")
                  else
                     ni.update.unregister_callback(ni.settings.main.profiles.primary.name)
                     ni.utilities.log(ni.settings.main.profiles.primary.name.. " Stopped")
                  end
                  return true
               end
            end
            if ni.input.key_down(ni.settings.main.keys.secondary) then
               if
                  ni.settings.main.profiles.secondary.name ~= "none" and
                     ni.settings.main.profiles.secondary.name ~= "None"
                then
                  ni.settings.main.profiles.secondary.enabled = not ni.settings.main.profiles.secondary.enabled
                  if ni.settings.main.profiles.secondary.enabled then
                     ni.update.register_callback(
                        ni.settings.main.profiles.secondary.name,
                        ni.profile[ni.settings.main.profiles.secondary.name].execute
                     )
                     ni.utilities.log(ni.settings.main.profiles.secondary.name.. " Started")
                  else
                     ni.update.unregister_callback(ni.settings.main.profiles.secondary.name)
                     ni.utilities.log(ni.settings.main.profiles.secondary.name.. " Stopped")
                  end
                  return true
               end
            end
            if ni.input.key_down(ni.settings.main.keys.generic) then
               if ni.settings.main.profiles.generic.name ~= "none" and ni.settings.main.profiles.generic.name ~= "None" then
                  ni.settings.main.profiles.generic.enabled = not ni.settings.main.profiles.generic.enabled
                  if ni.settings.main.profiles.generic.enabled then
                     ni.update.register_callback(
                        ni.settings.main.profiles.generic.name,
                        ni.profile[ni.settings.main.profiles.generic.name].execute
                     )
                     ni.utilities.log(ni.settings.main.profiles.generic.name.. " Started")
                  else
                     ni.update.unregister_callback(ni.settings.main.profiles.generic.name)
                     ni.utilities.log(ni.settings.main.profiles.generic.name.. " Stopped")
                  end
                  return true
               end
            end
            return false
         end
      )
   end
end
