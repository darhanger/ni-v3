--Version: 18414
local ni = ...

local queue = {
   "Pause",
   "NimbleBrew",
   "StanceoftheSturdyOx",
   "LegacyoftheEmperor",
   "PurifyingBrew",
   "ElusiveBrew",
   "Guard",
   "TouchofDeath",
   "KegSmash",
   "BreathofFire",
   "BlackoutKick",
   "TigerPalm",
   "ExpelHarm",
   "SpinningCraneKick",
   "ChiWave",
   "Jab",
   "TigerPalmFiller",
   "AutoAttack"
}

local spells = {
   --General icon = select(2, GetSpellTabInfo(1))
   AutoAttack = {id = 6603, name = ni.spell.info(6603)},
   --Brewmaster icon = select(2, GetSpellTabInfo(2))
   BlackoutKick = {id = 100784, name = ni.spell.info(100784)},
   BreathofFire = {id = 115181, name = ni.spell.info(115181)},
   ChiWave = {id = 115098, name = ni.spell.info(115098)},
   Clash = {id = 122057, name = ni.spell.info(122057)},
   Detox = {id = 115450, name = ni.spell.info(115450)},
   Disable = {id = 116095, name = ni.spell.info(116095)},
   DizzyingHaze = {id = 115180, name = ni.spell.info(115180)},
   ElusiveBrew = {id = 115308, name = ni.spell.info(115308)},
   ExpelHarm = {id = 115072, name = ni.spell.info(115072)},
   FortifyingBrew = {id = 115203, name = ni.spell.info(115203)},
   Guard = {id = 115295, name = ni.spell.info(115295)},
   Jab = {id = 100780, name = ni.spell.info(100780)},
   KegSmash = {id = 121253, name = ni.spell.info(121253)},
   LegacyoftheEmperor = {id = 115921, name = ni.spell.info(115921)},
   NimbleBrew = {id = 137562, name = ni.spell.info(137562)},
   Provoke = {id = 115546, name = ni.spell.info(115546)},
   Resuscitate = {id = 115178, name = ni.spell.info(115178)},
   Roll = {id = 109132, name = ni.spell.info(109132)},
   SpearHandStrike = {id = 116705, name = ni.spell.info(116705)},
   StanceoftheFierceTiger = {id = 103985, name = ni.spell.info(103985)},
   StanceoftheSturdyOx = {id = 115069, name = ni.spell.info(115069)},
   TigerPalm = {id = 100787, name = ni.spell.info(100787)},
   TouchofDeath = {id = 115080, name = ni.spell.info(115080)},
   ZenPilgrimage = {id = 126892, name = ni.spell.info(126892)},
   BrewingElusiveBrew = {id = 128938, name = ni.spell.info(128938)},
   BrewmasterTraining = {id = 117967, name = ni.spell.info(117967)},
   Celerity = {id = 115173, name = ni.spell.info(115173)},
   DualWield = {id = 124146, name = ni.spell.info(124146)},
   FightingStyle = {id = 115074, name = ni.spell.info(115074)},
   Parry = {id = 116812, name = ni.spell.info(116812)},
   SwiftReflexes = {id = 124334, name = ni.spell.info(124334)},
   Vengeance = {id = 120267, name = ni.spell.info(120267)},
   WayoftheMonk = {id = 120277, name = ni.spell.info(120277)},
   Paralysis = {id = 115078, name = ni.spell.info(115078)},
   DesperateMeasures = {id = 126060, name = ni.spell.info(126060)},
   SpinningCraneKick = {id = 101546, name = ni.spell.info(101546)},
   AvertHarm = {id = 115213, name = ni.spell.info(115213)},
   LeatherSpecialization = {id = 120225, name = ni.spell.info(120225)},
   CracklingJadeLightning = {id = 117952, name = ni.spell.info(117952)},
   GiftoftheOx = {id = 124502, name = ni.spell.info(124502)},
   HealingSphere = {id = 115460, name = ni.spell.info(115460)},
   GrappleWeapon = {id = 117368, name = ni.spell.info(117368)},
   SummonBlackOxStatue = {id = 115315, name = ni.spell.info(115315)},
   PurifyingBrew = {id = 119582, name = ni.spell.info(119582)},
   MasteryElusiveBrawler = {id = 117906, name = ni.spell.info(117906)},
   ZenMeditation = {id = 115176, name = ni.spell.info(115176)},
   Transcendence = {id = 101643, name = ni.spell.info(101643)},
   TranscendenceTransfer = {id = 119996, name = ni.spell.info(119996)}
}

local p,
   t = "player", "target"

local enables = {
   ["ElusiveBrew"] = true,
   ["SummonBlackOxStatue"] = false
}
local values = {
   ["SpinningCraneKick"] = 3,
   ["Guard"] = 90,
   ["ElusiveBrew"] = 10
}
local inputs = {}
local menus = {}
local function GUICallback(key, item_type, value)
   if item_type == "enabled" then
      enables[key] = value
   elseif item_type == "value" then
      values[key] = value
   elseif item_type == "input" then
      inputs[key] = value
   elseif item_type == "menu" then
      menus[key] = value
   end
end
local items = {
   settingsfile = "BrewNuok.xml",
   callback = GUICallback,
   {type = "separator"},
   {type = "title", text = "Brewmaster"},
   {type = "separator"},
   {
      type = "entry",
      text = "Spinning Crane Kick AoE",
      tooltip = "Use Spinning Crane Kick when in range AoE",
      value = values["SpinningCraneKick"],
      key = "SpinningCraneKick"
   },
   {
      type = "entry",
      text = "Guard Hp",
      value = values["Guard"],
      key = "Guard"
   },
   {
      type = "entry",
      text = "Elusive Brew",
      tooltip = "Use Elusive Brew at x stacks",
      value = values["ElusiveBrew"],
      enabled = enables["ElusiveBrew"],
      key = "ElusiveBrew"
   },
   {
      type = "entry",
      text = "Summon Black Ox Statue",
      enabled = enables["SummonBlackOxStatue"],
      key = "SummonBlackOxStatue"
   }
}
local function OnLoad()
end
local function OnUnload()
end

local enemies = {}

local function ActiveEnemies()
   enemies = {}
   enemies = ni.player.enemies_in_range(9)
   for k, v in ni.table.opairs(enemies) do
      if ni.player.threat(v.guid) == -1 then
         table.remove(enemies, k)
      end
   end
   return #enemies
end

local function Valid(id, tar)
   return ni.spell.valid(tar, id, true, true)
end

local Shuffle,
   TigerPower,
   PowerGuard,
   DeathNote,
   ElusiveBrewStacks,
   SanctuaryoftheOx = 115307, 125359, 118636, 121125, 128939, 126119

local LightStagger,
   ModerateStagger,
   HeavyStagger = 124275, 124274, 124273

local abilities = {
   ["Pause"] = function()
      if
         ni.player.is_mounted() or ni.player.is_dead_or_ghost() or not ni.unit.exists(t) or ni.unit.is_dead_or_ghost(t) or
            not ni.player.can_attack(t) or
            ni.player.buff(spells.SpinningCraneKick.id)
       then
         return true
      end
   end,
   ["AutoAttack"] = function()
      if not ni.spell.is_current(spells.AutoAttack.id) and ni.player.in_melee(t) then
         ni.spell.cast(spells.AutoAttack.name)
      end
   end,
   ["StanceoftheSturdyOx"] = function()
      if ni.player.shapeshift_form_id ~= 23 and ni.spell.available(spells.StanceoftheSturdyOx.name) then
         ni.spell.cast(spells.StanceoftheSturdyOx.name)
      end
   end,
   ["KegSmash"] = function()
      if ni.player.power("chi") < 3 and Valid(spells.KegSmash.id, t) then
         ni.spell.cast(spells.KegSmash.id, t)
         return true
      end
   end,
   ["TouchofDeath"] = function()
      if
         ni.player.buff(DeathNote) and Valid(spells.TouchofDeath.id, t)
       then
         ni.spell.cast(spells.TouchofDeath.id, t)
         return true
      end
   end,
   ["TigerPalm"] = function()
      if
         (ni.player.buff_remaining(TigerPower) < 3 or ni.player.buff_remaining(PowerGuard) < 3) and
            ni.player.buff_remaining(Shuffle) > 2 and
            Valid(spells.TigerPalm.id, t)  then
               ni.spell.cast(spells.TigerPalm.id, t)
         return true
      end
   end,
   ["TigerPalmFiller"] = function()
      if Valid(spells.TigerPalm.id, t) then
         ni.spell.cast(spells.TigerPalm.id)
         return true
      end
   end,
   ["BreathofFire"] = function()
      if
         not ni.unit.debuff(t, spells.BreathofFire.name, p) and ni.spell.available(spells.BreathofFire.name) and
            ni.player.is_facing(t, 90) and
            ni.spell.in_range(spells.KegSmash.name, t) and
            ni.unit.debuff(t, spells.DizzyingHaze.name) and
            ni.player.power("chi") >= 3 and
            (ni.player.buff_remaining(Shuffle) > 1.5 or ni.player.hp() > 95)
       then
         ni.spell.cast(spells.BreathofFire.name)
         return true
      end
   end,
   ["BlackoutKick"] = function()
      if
         (ni.player.power("chi") >= 3 or ni.player.buff_remaining(Shuffle) < 2) and
         Valid(spells.BlackoutKick.id, t)
       then
         ni.spell.cast(spells.BlackoutKick.id, t)
         return true
      end
   end,
   ["ChiWave"] = function()
      if Valid(spells.ChiWave.id, t) then
         ni.spell.cast(spells.ChiWave.id, t)
         return true
      end
   end,
   ["Jab"] = function()
      if
         ni.player.power("energy") >= 55 and ni.spell.cooldown_remaining(spells.KegSmash.id) > 1.5 and
         Valid(spells.Jab.id, t)
       then
         ni.spell.cast(spells.Jab.id, t)
         return true
      end
   end,
   ["ExpelHarm"] = function()
      if
         ni.player.hp() < 95 and ni.player.power("energy") >= 50 and ni.spell.available(spells.ExpelHarm.id) and
            ni.spell.in_range(spells.KegSmash.name, t)
       then
         ni.spell.cast(spells.ExpelHarm.name, p)
         return true
      end
   end,
   ["Guard"] = function()
      if
         ni.player.hp() < values["Guard"] and ni.spell.available(spells.Guard.id) and
            ni.spell.in_range(spells.KegSmash.name, t) == 1
       then
         ni.spell.cast(spells.Guard.name)
         return true
      end
   end,
   ["RushingJadeWind"] = function()
      if
         ActiveEnemies() >= 2 and ni.spell.available(spells.RushingJadeWind.id)
       then
         ni.spell.cast(spells.RushingJadeWind.name, p)
         return true
      end
   end,
   ["SpinningCraneKick"] = function()
      if
         ni.spell.available(spells.SpinningCraneKick.id) and ActiveEnemies() >= values["SpinningCraneKick"] and
            ni.player.buff_remaining(Shuffle) > 2
       then
         ni.spell.cast(spells.SpinningCraneKick.name, p)
         return true
      end
   end,
   ["PurifyingBrew"] = function()
      if ni.player.debuff(HeavyStagger) and ni.spell.available(spells.PurifyingBrew.id) then
         ni.spell.cast(spells.PurifyingBrew.name)
      end
   end,
   ["LegacyoftheEmperor"] = function()
      if ni.spell.available(spells.LegacyoftheEmperor.id) and not ni.player.buff(spells.LegacyoftheEmperor.id) then
         ni.spell.cast(spells.LegacyoftheEmperor.name, p)
         return true
      end
   end,
   ["ElusiveBrew"] = function()
      if enables["ElusiveBrew"] then
         if
            ni.spell.available(spells.ElusiveBrew.id) and
               ni.player.buff_stacks(ElusiveBrewStacks) >= values["ElusiveBrew"]
          then
            ni.spell.cast(spells.ElusiveBrew.name, p)
            return true
         end
      end
   end,
   ["NimbleBrew"] = function()
      if
         ni.spell.available(spells.NimbleBrew.id) and not ni.spell.on_cooldown(spells.NimbleBrew.id) and
            (ni.player.is_stunned() or ni.player.is_fleeing())
       then
         ni.spell.cast(spells.NimbleBrew.id)
      end
   end
}
ni.profile.new("Brewmaster_MoP", queue, abilities)
