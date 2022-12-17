--Version: 12340
local ni = ...

local spells = {
   --General
   AutoAttack = {id = 6603, name = ni.spell.info(6603)},
   Block = {id = 107, name = ni.spell.info(107)},
   ColdWeatherFlying = {id = 54197, name = ni.spell.info(54197)},
   Cultivation = {id = 20552, name = ni.spell.info(20552)},
   Dodge = {id = 81, name = ni.spell.info(81)},
   Endurance = {id = 20550, name = ni.spell.info(20550)},
   NatureResistance = {id = 20551, name = ni.spell.info(20551)},
   Parry = {id = 3127, name = ni.spell.info(3127)},
   SealofCorruption = {id = 53736, name = ni.spell.info(53736)},
   WarStomp = {id = 20549, name = ni.spell.info(20549)},
   --Holy
   BlessingofWisdom = {id = 48936, name = ni.spell.info(48936)},
   Cleanse = {id = 4987, name = ni.spell.info(4987)},
   ConcentrationAura = {id = 19746, name = ni.spell.info(19746)},
   Consecration = {id = 48819, name = ni.spell.info(48819)},
   DivinePlea = {id = 54428, name = ni.spell.info(54428)},
   Exorcism = {id = 48801, name = ni.spell.info(48801)},
   FlashofLight = {id = 48785, name = ni.spell.info(48785)},
   GreaterBlessingofWisdom = {id = 48938, name = ni.spell.info(48938)},
   HolyLight = {id = 48782, name = ni.spell.info(48782)},
   HolyWrath = {id = 48817, name = ni.spell.info(48817)},
   LayonHands = {id = 48788, name = ni.spell.info(48788)},
   Purify = {id = 1152, name = ni.spell.info(1152)},
   Redemption = {id = 48950, name = ni.spell.info(48950)},
   SacredShield = {id = 53601, name = ni.spell.info(53601)},
   SealofLight = {id = 20165, name = ni.spell.info(20165)},
   SealofRighteousness = {id = 21084, name = ni.spell.info(21084)},
   SealofWisdom = {id = 20166, name = ni.spell.info(20166)},
   SenseUndead = {id = 5502, name = ni.spell.info(5502)},
   TurnEvil = {id = 10326, name = ni.spell.info(10326)},
   --Protection
   AvengersShield = {id = 48827, name = ni.spell.info(48827)},
   BlessingofKings = {id = 20217, name = ni.spell.info(20217)},
   BlessingofSanctuary = {id = 20911, name = ni.spell.info(20911)},
   DevotionAura = {id = 48942, name = ni.spell.info(48942)},
   DivineIntervention = {id = 19752, name = ni.spell.info(19752)},
   DivineProtection = {id = 498, name = ni.spell.info(498)},
   DivineSacrifice = {id = 64205, name = ni.spell.info(64205)},
   DivineShield = {id = 642, name = ni.spell.info(642)},
   FireResistanceAura = {id = 48947, name = ni.spell.info(48947)},
   FrostResistanceAura = {id = 48945, name = ni.spell.info(48945)},
   GreaterBlessingofKings = {id = 25898, name = ni.spell.info(25898)},
   GreaterBlessingofSanctuary = {id = 25899, name = ni.spell.info(25899)},
   HammerofJustice = {id = 10308, name = ni.spell.info(10308)},
   HammeroftheRighteous = {id = 53595, name = ni.spell.info(53595)},
   HandofFreedom = {id = 1044, name = ni.spell.info(1044)},
   HandofProtection = {id = 10278, name = ni.spell.info(10278)},
   HandofReckoning = {id = 62124, name = ni.spell.info(62124)},
   HandofSacrifice = {id = 6940, name = ni.spell.info(6940)},
   HandofSalvation = {id = 1038, name = ni.spell.info(1038)},
   HolyShield = {id = 48952, name = ni.spell.info(48952)},
   RighteousDefense = {id = 31789, name = ni.spell.info(31789)},
   RighteousFury = {id = 25780, name = ni.spell.info(25780)},
   SealofJustice = {id = 20164, name = ni.spell.info(20164)},
   ShadowResistanceAura = {id = 48943, name = ni.spell.info(48943)},
   ShieldofRighteousness = {id = 61411, name = ni.spell.info(61411)},
   SpiritualAttunement = {id = 33776, name = ni.spell.info(33776)},
   --Retribution
   AvengingWrath = {id = 31884, name = ni.spell.info(31884)},
   BlessingofMight = {id = 48932, name = ni.spell.info(48932)},
   CrusaderAura = {id = 32223, name = ni.spell.info(32223)},
   GreaterBlessingofMight = {id = 48934, name = ni.spell.info(48934)},
   HammerofWrath = {id = 48806, name = ni.spell.info(48806)},
   JudgementofJustice = {id = 53407, name = ni.spell.info(53407)},
   JudgementofLight = {id = 20271, name = ni.spell.info(20271)},
   JudgementofWisdom = {id = 53408, name = ni.spell.info(53408)},
   RetributionAura = {id = 54043, name = ni.spell.info(54043)}
}

local enables = {
   ["SacredShield"] = true
}
local values = {}
local inputs = {}
local menus = {
   ["Blessing"] = spells.BlessingofKings.name,
   ["Seals"] = spells.SealofWisdom.name,
   ["Auras"] = spells.DevotionAura.name,
   ["Judgement"] = spells.JudgementofWisdom.name
}

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

local ui = {
   settingsfile = ni.player.guid() .. "_prot_pala_wrath.json",
   callback = GUICallback,
   {type = "label", text = "Auras"},
   {
      type = "combobox",
      menu = {
         {selected = (menus["Auras"] == spells.CrusaderAura.name), text = spells.CrusaderAura.name},
         {selected = (menus["Auras"] == spells.ConcentrationAura.name), text = spells.ConcentrationAura.name},
         {selected = (menus["Auras"] == spells.DevotionAura.name), text = spells.DevotionAura.name},
         {selected = (menus["Auras"] == spells.RetributionAura.name), text = spells.RetributionAura.name},
         {selected = (menus["Auras"] == spells.FireResistanceAura.name), text = spells.FireResistanceAura.name},
         {selected = (menus["Auras"] == spells.FrostResistanceAura.name), text = spells.FrostResistanceAura.name},
         {selected = (menus["Auras"] == spells.ShadowResistanceAura.name), text = spells.ShadowResistanceAura.name}
      },
      key = "Auras"
   },
   {type = "label", text = "Blessings"},
   {
      type = "combobox",
      menu = {
         {selected = (menus["Blessing"] == spells.BlessingofMight.name), text = spells.BlessingofMight.name},
         {selected = (menus["Blessing"] == spells.BlessingofKings.name), text = spells.BlessingofKings.name},
         {selected = (menus["Blessing"] == spells.BlessingofSanctuary.name), text = spells.BlessingofSanctuary.name},
         {selected = (menus["Blessing"] == spells.BlessingofWisdom.name), text = spells.BlessingofWisdom.name}
      },
      key = "Blessing"
   },
   {type = "label", text = "Judgement"},
   {
      type = "combobox",
      menu = {
         {selected = (menus["Judgement"] == spells.JudgementofJustice.name), text = spells.JudgementofJustice.name},
         {selected = (menus["Judgement"] == spells.JudgementofLight.name), text = spells.JudgementofLight.name},
         {selected = (menus["Judgement"] == spells.JudgementofWisdom.name), text = spells.JudgementofWisdom.name}
      },
      key = "Judgement"
   },
   {type = "label", text = "Seals"},
   {
      type = "combobox",
      menu = {
         {selected = (menus["Seals"] == spells.SealofCorruption.name), text = spells.SealofCorruption.name},
         {selected = (menus["Seals"] == spells.SealofJustice.name), text = spells.SealofJustice.name},
         {selected = (menus["Seals"] == spells.SealofLight.name), text = spells.SealofLight.name},
         {selected = (menus["Seals"] == spells.SealofRighteousness.name), text = spells.SealofRighteousness.name},
         {selected = (menus["Seals"] == spells.SealofWisdom.name), text = spells.SealofWisdom.name}
      },
      key = "Seals"
   },
   {type = "checkbox", text = spells.SacredShield.name, enabled = enables["SacredShield"], key = "SacredShield"},
   {type = "label", text = "Prot Pala by Nuok"}
}

local queue = {
   "Pause",
   "Cache",
   "WaitForCast",
   "AutoAttack",
   "GCD",
   "Aura",
   "Blessing",
   "DivinePlea",
   "HolyShield",
   "SacredShield",
   "Consecration",
   "Seal",
   "AvengersShield",
   "Judgement",
   "ShieldofRighteousness",
   "HammeroftheRighteous"
}

local t, p = "target", "player"

local cache = {
   targets = nil,
   target_count = 0,
   hp = 100,
   mana = ni.player.power_percent(0)
}

local abilities = {
   ["Pause"] = function()
      if
         ni.mount.is_mounted() or ni.player.is_dead_or_ghost() or not ni.unit.exists(t) or ni.unit.is_dead_or_ghost(t) or
            not ni.player.can_attack(t)
       then
         return true
      end
   end,
   ["Cache"] = function()
      cache.targets = ni.player.enemies_in_range(8)
      cache.target_count = ni.table.length(cache.targets)
      cache.hp = ni.player.hp()
      cache.mana = ni.player.power_percent(0)
   end,
   ["GCD"] = function()
      if ni.spell.on_gcd() then
         return true
      end
   end,
   ["WaitForCast"] = function()
      if ni.player.casting() or ni.player.is_channeling() then
         return true
      end
   end,
   ["AutoAttack"] = function()
      if not ni.spell.is_current(spells.AutoAttack.id) and ni.player.in_melee(t) then
         ni.spell.cast(spells.AutoAttack.id)
      end
   end,
   ["Aura"] = function()
      if menus["Auras"] == spells.DevotionAura.name and not ni.player.buff(spells.DevotionAura.id) and
            ni.spell.available(spells.DevotionAura.id)
       then
         ni.spell.cast(spells.DevotionAura.id)
         return true
      end
      if menus["Auras"] == spells.CrusaderAura.name and not ni.player.buff(spells.CrusaderAura.id) and
            ni.spell.available(spells.CrusaderAura.id)
       then
         ni.spell.cast(spells.CrusaderAura.id)
         return true
      end
      if menus["Auras"] == spells.RetributionAura.name and not ni.player.buff(spells.RetributionAura.id) and
            ni.spell.available(spells.RetributionAura.id)
       then
         ni.spell.cast(spells.RetributionAura.id)
         return true
      end
      if menus["Auras"] == spells.ConcentrationAura.name and not ni.player.buff(spells.ConcentrationAura.id) and
            ni.spell.available(spells.ConcentrationAura.id)
       then
         ni.spell.cast(spells.ConcentrationAura.id)
         return true
      end
      if menus["Auras"] == spells.FireResistanceAura.name and not ni.player.buff(spells.FireResistanceAura.id) and
            ni.spell.available(spells.FireResistanceAura.id)
       then
         ni.spell.cast(spells.FireResistanceAura.id)
         return true
      end
      if menus["Auras"] == spells.FrostResistanceAura.name and not ni.player.buff(spells.FrostResistanceAura.id) and
            ni.spell.available(spells.FrostResistanceAura.id)
       then
         ni.spell.cast(spells.FrostResistanceAura.id)
         return true
      end
      if menus["Auras"] == spells.ShadowResistanceAura.name and not ni.player.buff(spells.ShadowResistanceAura.id) and
            ni.spell.available(spells.ShadowResistanceAura.id)
       then
         ni.spell.cast(spells.ShadowResistanceAura.id)
         return true
      end
   end,
   ["Seal"] = function()
      if
         menus["Seals"] == spells.SealofRighteousness.name and ni.spell.available(spells.SealofRighteousness.name) and
            not ni.player.buff(spells.SealofRighteousness.id)
       then
         ni.spell.cast(spells.SealofRighteousness.name)
         return true
      end
      if
         menus["Seals"] == spells.SealofCorruption.name and ni.spell.available(spells.SealofCorruption.name) and
            not ni.player.buff(spells.SealofCorruption.id)
       then
         ni.spell.cast(spells.SealofCorruption.name)
         return true
      end
      if
         menus["Seals"] == spells.SealofJustice.name and ni.spell.available(spells.SealofJustice.name) and
            not ni.player.buff(spells.SealofJustice.id)
       then
         ni.spell.cast(spells.SealofJustice.name)
         return true
      end
      if
         menus["Seals"] == spells.SealofLight.name and ni.spell.available(spells.SealofLight.name) and
            not ni.player.buff(spells.SealofLight.id)
       then
         ni.spell.cast(spells.SealofLight.name)
         return true
      end
      if
         menus["Seals"] == spells.SealofWisdom.name and ni.spell.available(spells.SealofWisdom.name) and
            not ni.player.buff(spells.SealofWisdom.id)
       then
         ni.spell.cast(spells.SealofWisdom.name)
         return true
      end
   end,
   ["Blessing"] = function()
      if
         menus["Blessing"] == spells.BlessingofMight.name and ni.spell.available(spells.BlessingofMight.name) and
            not ni.player.buff(spells.BlessingofMight.id)
       then
         ni.spell.cast(spells.BlessingofMight.name, p)
         return true
      end
      if
         menus["Blessing"] == spells.BlessingofKings.name and ni.spell.available(spells.BlessingofKings.name) and
            not ni.player.buff(spells.BlessingofKings.id)
       then
         ni.spell.cast(spells.BlessingofKings.name, p)
         return true
      end
      if
         menus["Blessing"] == spells.BlessingofWisdom.name and ni.spell.available(spells.BlessingofWisdom.name) and
            not ni.player.buff(spells.BlessingofWisdom.id)
       then
         ni.spell.cast(spells.BlessingofWisdom.name, p)
         return true
      end
   end,
   ["Judgement"] = function()
      if
         menus["Judgement"] == spells.JudgementofLight.name and
            ni.spell.valid(spells.JudgementofLight.id, t, true, true)
       then
         ni.spell.cast(spells.JudgementofLight.name, t)
         return true
      end
      if
         menus["Judgement"] == spells.JudgementofJustice.name and
            ni.spell.valid(spells.JudgementofJustice.id, t, true, true)
       then
         ni.spell.cast(spells.JudgementofJustice.name, t)
         return true
      end
      if
         menus["Judgement"] == spells.JudgementofWisdom.name and
            ni.spell.valid(spells.JudgementofWisdom.id, t, true, true)
       then
         ni.spell.cast(spells.JudgementofWisdom.name, t)
         return true
      end
   end,
   ["HammeroftheRighteous"] = function()
      if ni.spell.is_usable(spells.HammeroftheRighteous.name) and ni.spell.valid(spells.HammeroftheRighteous.name, t, true, true) then
         ni.spell.cast(spells.HammeroftheRighteous.name, t)
         return true
      end
   end,
   ["Consecration"] = function()
      if cache.target_count > 2 and ni.spell.available(spells.Consecration.name) then
         ni.spell.cast(spells.Consecration.name)
         return true
      end
   end,
   ["AvengersShield"] = function()
      if ni.spell.is_usable(spells.AvengersShield.name) and ni.spell.valid(spells.AvengersShield.name, t, true, true) then
         ni.spell.cast(spells.AvengersShield.name, t)
         return true
      end
   end,
   ["ShieldofRighteousness"] = function()
      if ni.spell.is_usable(spells.ShieldofRighteousness.name) and ni.spell.valid(spells.ShieldofRighteousness.name, t, true, true) then
         ni.spell.cast(spells.ShieldofRighteousness.name, t)
         return true
      end
   end,
   ["DivinePlea"] = function()
      if cache.mana < 25 and ni.spell.available(spells.DivinePlea.name) then
         ni.spell.cast(spells.DivinePlea.name)
         return true
      end
   end,
   ["HolyShield"] = function()
      if
         ni.spell.is_usable(spells.HolyShield.name) and ni.spell.available(spells.HolyShield.name) and
            not ni.player.buff(spells.HolyShield.name)
       then
         ni.spell.cast(spells.HolyShield.name, p)
         return true
      end
   end,
   ["SacredShield"] = function()
      if
         enables["SacredShield"] and ni.spell.is_usable(spells.SacredShield.name) and
            ni.spell.available(spells.SacredShield.name) and
            not ni.player.buff(spells.SacredShield.name)
       then
         ni.spell.cast(spells.SacredShield.name, p)
         return true
      end
   end
}

ni.profile.new("Protection_Wrath", queue, abilities, ui)
