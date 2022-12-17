--Version: 12340
local ni = ...

local queue =
{
   "in_vechical",
   "cache",
   "Revivify",
   "target_check",
   "FlameShield",
   "FlameSpike"
}

local FlameSpike = 1
local EngulfinFlames = 2
local Revivify = 3
local LifeBurst = 4
local FlameShield = 5

local enables ={
   ["Revivify"] = true,
   ["RevivifyOOC"] = true,
}
local values = {}
local menus = {}

local function GUICallback(key, item_type, value)
   ni.utilities.log("GUICallback " .. key .. " " .. item_type .. " " .. tostring(value) .. " ")
   if item_type == "enabled" then
      enables[key] = value
   elseif item_type == "value" then
      values[key] = value
   elseif item_type == "menu" then
      menus[key] = value
   end
end

local ui = {
   settingsfile = "aces_high.json",
   callback = GUICallback,
   {type = "label", text = "Aces High - Nuok"},
   {type = "separator"},
   {
      type = "checkbox",
      text = "Revivify",
      enabled = enables["Revivify"],
      key = "Revivify"
   },
   {
      type = "checkbox",
      text = "Revivify Out Of Combat",
      enabled = enables["RevivifyOOC"],
      key = "RevivifyOOC"
   },
}

local cache = {
   combo = 0,
   energy = 0
}

local abilities = {
   ["in_vechical"] = function ()
      if not ni.player.in_vehicle() then
        return true
      end
   end,
   ["cache"] = function ()
      cache.combo = ni.unit.combo_points("vehicle", "target")
      cache.energy = ni.power.current("vehicle", 3)
   end,
   ["Revivify"] = function ()
      local combat = ni.unit.affecting_combat("target")
      if enables["Revivify"] or (enables["RevivifyOOC"] and not combat) then
         if cache.energy > 10 and
         (ni.unit.buff_stacks("vehicle", 57090) < 5 or
         ni.unit.buff_remaining("vehicle", 57090) < 1.5)
         and ni.pet.action_cooldown(Revivify) == 0 then
             ni.pet.cast_action(Revivify)
             return true
         end
      end
   end,
   ["target_check"] = function ()
      if not ni.unit.target("vehicle") or not ni.unit.can_attack("vehicle", "target") then
         return true
      end
   end,
   ["FlameShield"] = function ()
      if cache.combo == 5 and cache.energy >= 25 and
      ni.pet.action_cooldown(FlameShield) == 0 and
      not ni.unit.buff("vehicle", 57108) then
         ni.pet.cast_action(FlameShield)
         return true
      end
   end,
   ["FlameSpike"] = function ()
      if cache.energy > 35 and ni.pet.action_cooldown(FlameSpike) == 0 and ni.player.distance("target") < 60 then
         ni.pet.cast_action(FlameSpike)
         return true
      end
   end
}

ni.profile.new("Aces_High", queue, abilities, ui)
