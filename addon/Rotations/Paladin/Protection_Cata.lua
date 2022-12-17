--Version: 15595
local ni = ...

local queue = {
   "Pause",
   "Cache",
   "GCD", --All Spells on GCD need to be
   "WordofGlory",
   "RighteousFury",
   "Auras",
   "Seals",
   "HammerofWrath",
   "AvengersShield",
   "Consecration",
   "HolyWrath",
   "CrusaderStrike",
   "Judgement",
   "AutoAttack"
}

local spells = {
--General
AutoAttack = {id = 6603, name = ni.spell.info(6603)},
--Holy
HolyLight = {id = 635, name = ni.spell.info(635)},
WordofGlory = {id = 85673, name = ni.spell.info(85673)},
Redemption = {id = 7328, name = ni.spell.info(7328)},
FlashofLight = {id = 19750, name = ni.spell.info(19750)},
LayonHands = {id = 633, name = ni.spell.info(633)},
Exorcism = {id = 879, name = ni.spell.info(879)},
Consecration = {id = 26573, name = ni.spell.info(26573)},
HolyWrath = {id = 2812, name = ni.spell.info(2812)},
SealofInsight = {id = 20165, name = ni.spell.info(20165)},
Cleanse = {id = 4987, name = ni.spell.info(4987)},
ConcentrationAura = {id = 19746, name = ni.spell.info(19746)},
DivinePlea = {id = 54428, name = ni.spell.info(54428)},
DivineLight = {id = 82326, name = ni.spell.info(82326)},
TurnEvil = {id = 10326, name = ni.spell.info(10326)},
HolyRadiance = {id = 82327, name = ni.spell.info(82327)},
--Protection
AvengersShield = {id = 31935, name = ni.spell.info(31935)},
DevotionAura = {id = 465, name = ni.spell.info(465)},
JudgementsoftheWise = {id = 31878, name = ni.spell.info(31878)},
SealofRighteousness = {id = 20154, name = ni.spell.info(20154)},
TouchedbytheLight = {id = 53592, name = ni.spell.info(53592)},
Vengeance = {id = 84839, name = ni.spell.info(84839)},
Parry = {id = 82242, name = ni.spell.info(82242)},
RighteousFury = {id = 25780, name = ni.spell.info(25780)},
HammerofJustice = {id = 853, name = ni.spell.info(853)},
HandofReckoning = {id = 62124, name = ni.spell.info(62124)},
HandofProtection = {id = 1022, name = ni.spell.info(1022)},
BlessingofKings = {id = 20217, name = ni.spell.info(20217)},
DivineProtection = {id = 498, name = ni.spell.info(498)},
RighteousDefense = {id = 31789, name = ni.spell.info(31789)},
DivineShield = {id = 642, name = ni.spell.info(642)},
HandofFreedom = {id = 1044, name = ni.spell.info(1044)},
SealofJustice = {id = 20164, name = ni.spell.info(20164)},
HandofSalvation = {id = 1038, name = ni.spell.info(1038)},
ResistanceAura = {id = 19891, name = ni.spell.info(19891)},
HandofSacrifice = {id = 6940, name = ni.spell.info(6940)},
GuardianofAncientKings = {id = 86150, name = ni.spell.info(86150)},
--Retribution
CrusaderStrike = {id = 35395, name = ni.spell.info(35395)},
Judgement = {id = 20271, name = ni.spell.info(20271)},
RetributionAura = {id = 7294, name = ni.spell.info(7294)},
SealofTruth = {id = 31801, name = ni.spell.info(31801)},
HammerofWrath = {id = 24275, name = ni.spell.info(24275)},
Rebuke = {id = 96231, name = ni.spell.info(96231)},
BlessingofMight = {id = 19740, name = ni.spell.info(19740)},
CrusaderAura = {id = 32223, name = ni.spell.info(32223)},
AvengingWrath = {id = 31884, name = ni.spell.info(31884)},
Inquisition = {id = 84963, name = ni.spell.info(84963)},
}


local enables = {}
local values = {
   ["WordofGlory"] = 40,
}
local inputs = {}
local menus = {
   ["Auras"] = spells.DevotionAura.name,
	["Blessing"] = spells.BlessingofMight.name,
   ["Seals"] = spells.SealofRighteousness.name,
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
   settingsfile = ni.player.guid().."_prot_pala_cata.json",
   callback = GUICallback,
   {
		type = "combobox",
      text = "Auras",
		menu = {
         {selected = (menus["Auras"] == spells.ConcentrationAura.name), text = spells.ConcentrationAura.name},
         {selected = (menus["Auras"] == spells.CrusaderAura.name), text = spells.CrusaderAura.name},
         {selected = (menus["Auras"] == spells.DevotionAura.name), text = spells.DevotionAura.name},
         {selected = (menus["Auras"] == spells.ResistanceAura.name), text = spells.ResistanceAura.name},
         {selected = (menus["Auras"] == spells.RetributionAura.name), text = spells.RetributionAura.name},
		},
		key = "Seals"
	},
   {
		type = "combobox",
      text = "Blessings",
		menu = {
			{selected = (menus["Blessing"] == spells.BlessingofMight.name), text = spells.BlessingofMight.name},
         {selected = (menus["Blessing"] == spells.BlessingofKings.name), text = spells.BlessingofKings.name},
		},
		key = "Blessing"
	},
   {
		type = "combobox",
      text = "Seals",
		menu = {
         {selected = (menus["Seals"] == spells.SealofInsight.name), text = spells.SealofInsight.name},
         {selected = (menus["Seals"] == spells.SealofJustice.name), text = spells.SealofJustice.name},
			{selected = (menus["Seals"] == spells.SealofRighteousness.name), text = spells.SealofRighteousness.name},
         {selected = (menus["Seals"] == spells.SealofTruth.name), text = spells.SealofTruth.name},
		},
		key = "Seals"
	},
   {type = "label", text = "Prot Pala by Nuok"},
}

local t, p = "target", "player"
local cache = {
	targets = nil,
   target_count = 0,
   holy_power = 0,
   hp = 100
}


local abilities = {
   ["Pause"] = function()
      if ni.mount.is_mounted() or ni.player.is_dead_or_ghost() or not ni.unit.exists(t) or ni.unit.is_dead_or_ghost(t) or
            not ni.player.can_attack(t)
       then
         return true
      end
   end,
   ["GCD"] = function ()
      if ni.spell.on_gcd() then
         return true
      end
   end,
   ["Cache"] = function()
		cache.targets = ni.player.enemies_in_range(8)
      cache.target_count = ni.table.length(cache.targets)
      cache.holy_power = ni.player.power(9)
      cache.hp = ni.player.hp()
	end,
   ["AutoAttack"] = function()
      if not ni.spell.is_current(spells.AutoAttack.id) and ni.player.in_melee(t) then
         ni.spell.cast(spells.AutoAttack.id)
      end
   end,
   ["Judgement"] = function()
      if ni.spell.valid(spells.Judgement.id, t, true, true) then
         ni.spell.cast(spells.Judgement.id, t)
         return true
      end
   end,
   ["CrusaderStrike"] = function()
      if ni.spell.valid(spells.CrusaderStrike.id, t, true, true) then
         ni.spell.cast(spells.CrusaderStrike.id, t)
         return true
      end
   end,
   ["Seals"] = function ()
      if menus["Seals"] == spells.SealofInsight.name and ni.spell.available(spells.SealofInsight.name) and not ni.player.buff(spells.SealofInsight.id) then
         ni.spell.cast(spells.SealofInsight.name)
         return true
      elseif menus["Seals"] == spells.SealofJustice.name and ni.spell.available(spells.SealofJustice.name) and not ni.player.buff(spells.SealofJustice.id) then
         ni.spell.cast(spells.SealofJustice.name)
         return true
      elseif menus["Seals"] == spells.SealofRighteousness.name and ni.spell.available(spells.SealofRighteousness.name) and not ni.player.buff(spells.SealofRighteousness.id) then
         ni.spell.cast(spells.SealofRighteousness.name)
         return true
      elseif menus["Seals"] == spells.SealofTruth.name and ni.spell.available(spells.SealofTruth.name) and not ni.player.buff(spells.SealofTruth.id) then
         ni.spell.cast(spells.SealofTruth.name)
         return true
      end
   end,
   ["Auras"] = function ()
      if menus["Auras"] == spells.ConcentrationAura.name and ni.spell.available(spells.ConcentrationAura.name) and not ni.player.buff(spells.ConcentrationAura.id) then
         ni.spell.cast(spells.ConcentrationAura.name)
         return true
      elseif menus["Auras"] == spells.CrusaderAura.name and ni.spell.available(spells.CrusaderAura.name) and not ni.player.buff(spells.CrusaderAura.id) then
         ni.spell.cast(spells.CrusaderAura.name)
         return true
      elseif menus["Auras"] == spells.DevotionAura.name and ni.spell.available(spells.DevotionAura.name) and not ni.player.buff(spells.DevotionAura.id) then
         ni.spell.cast(spells.DevotionAura.name)
         return true
      elseif menus["Auras"] == spells.ResistanceAura.name and ni.spell.available(spells.ResistanceAura.name) and not ni.player.buff(spells.ResistanceAura.id) then
         ni.spell.cast(spells.ResistanceAura.name)
         return true
      elseif menus["Auras"] == spells.RetributionAura.name and ni.spell.available(spells.RetributionAura.name) and not ni.player.buff(spells.RetributionAura.id) then
         ni.spell.cast(spells.RetributionAura.name)
         return true
      end
   end,
   ["AvengersShield"] = function ()
      if ni.spell.valid(spells.AvengersShield.id, t, true, true) then
         ni.spell.cast(spells.AvengersShield.id, t)
         return true
      end
   end,
   ["WordofGlory"] = function ()
      if cache.holy_power >= 3 and cache.hp < values["WordofGlory"] and ni.spell.available(spells.WordofGlory.name) then
         ni.spell.cast(spells.WordofGlory.name)
         return true
      end
   end,
   ["RighteousFury"] = function ()
      if ni.spell.available(spells.RighteousFury.name) and not ni.player.buff(spells.RighteousFury.name) then
         ni.spell.cast(spells.RighteousFury.name)
         return true
      end
   end,
   ["Consecration"] = function ()
      if ni.spell.available(spells.Consecration.name) and cache.target_count >= 1 then
         ni.spell.cast(spells.Consecration.name)
         return true
      end
   end,
   ["HammerofWrath"] = function ()
      if ni.spell.is_usable(spells.HammerofWrath.name) and ni.spell.valid(spells.HammerofWrath.name, t, true, true) then
         ni.spell.cast(spells.HammerofWrath.name, t)
         return true
      end
   end,
   ["HolyWrath"] = function ()
      if ni.spell.available(spells.HolyWrath.name) and cache.target_count >= 1 then
         ni.spell.cast(spells.HolyWrath.name)
         return true
      end
   end
}
ni.profile.new("Protection_Cata", queue, abilities, ui)
