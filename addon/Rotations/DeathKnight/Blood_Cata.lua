--Version: 15595
local ni = ...

local queue = {
   "Pause",
   "Cache",
   "VampiricBlood",
   "RuneTap",
   "MindFreeze",
   "GCD", --All Spells on GCD need to be
   "BloodPresence",
   "BoneShield",
   "DeathandDecay",
   "Pestilence",
   "Outbreak",
   "IcyTouch",
   "PlagueStrike",
   "DeathStrike",
   "HeartStrike",
   "BloodStrike",
   "RuneStrike",
   "DeathCoil",
   "AutoAttack"
}

local spells = {
   --General icon = select(2, GetSpellTabInfo(1))
  AutoAttack = {id = 6603, name = ni.spell.info(6603)},
--Blood icon = select(2, GetSpellTabInfo(2))
  BloodPresence = {id = 48263, name = ni.spell.info(48263)},
  BloodRites = {id = 50034, name = ni.spell.info(50034)},
  BloodStrike = {id = 45902, name = ni.spell.info(45902)},
  BoneShield = {id = 49222, name = ni.spell.info(49222)},
  DeathStrike = {id = 49998, name = ni.spell.info(49998)},
  HeartStrike = {id = 55050, name = ni.spell.info(55050)},
  Parry = {id = 82246, name = ni.spell.info(82246)},
  Pestilence = {id = 50842, name = ni.spell.info(50842)},
  RuneTap = {id = 48982, name = ni.spell.info(48982)},
  VampiricBlood = {id = 55233, name = ni.spell.info(55233)},
  Vengeance = {id = 93099, name = ni.spell.info(93099)},
  VeteranoftheThirdWar = {id = 50029, name = ni.spell.info(50029)},
  BloodBoil = {id = 48721, name = ni.spell.info(48721)},
  Strangulate = {id = 47476, name = ni.spell.info(47476)},
  BloodTap = {id = 45529, name = ni.spell.info(45529)},
  DarkCommand = {id = 56222, name = ni.spell.info(56222)},
  DeathPact = {id = 48743, name = ni.spell.info(48743)},
  DarkSimulacrum = {id = 77606, name = ni.spell.info(77606)},
--Frost icon = select(2, GetSpellTabInfo(3))
  FrostFever = {id = 59921, name = ni.spell.info(59921)},
  FrostPresence = {id = 48266, name = ni.spell.info(48266)},
  IcyTouch = {id = 45477, name = ni.spell.info(45477)},
  RunicFocus = {id = 61455, name = ni.spell.info(61455)},
  MindFreeze = {id = 47528, name = ni.spell.info(47528)},
  ChainsofIce = {id = 45524, name = ni.spell.info(45524)},
  Obliterate = {id = 49020, name = ni.spell.info(49020)},
  PathofFrost = {id = 3714, name = ni.spell.info(3714)},
  IceboundFortitude = {id = 48792, name = ni.spell.info(48792)},
  FesteringStrike = {id = 85948, name = ni.spell.info(85948)},
  HornofWinter = {id = 57330, name = ni.spell.info(57330)},
  RuneStrike = {id = 56815, name = ni.spell.info(56815)},
  RunicEmpowerment = {id = 81229, name = ni.spell.info(81229)},
  EmpowerRuneWeapon = {id = 47568, name = ni.spell.info(47568)},
--Unholy icon = select(2, GetSpellTabInfo(4))
  BloodPlague = {id = 59879, name = ni.spell.info(59879)},
  DeathCoil = {id = 47541, name = ni.spell.info(47541)},
  DeathGrip = {id = 49576, name = ni.spell.info(49576)},
  PlagueStrike = {id = 45462, name = ni.spell.info(45462)},
  RaiseDead = {id = 46584, name = ni.spell.info(46584)},
  DeathandDecay = {id = 43265, name = ni.spell.info(43265)},
  AntiMagicShell = {id = 48707, name = ni.spell.info(48707)},
  UnholyPresence = {id = 48265, name = ni.spell.info(48265)},
  RaiseAlly = {id = 61999, name = ni.spell.info(61999)},
  ArmyoftheDead = {id = 42650, name = ni.spell.info(42650)},
  Outbreak = {id = 77575, name = ni.spell.info(77575)},
  NecroticStrike = {id = 73975, name = ni.spell.info(73975)},
}

local t, p = "target", "player"
local cache = {
	blood_plauge = 0,
	frost_fever = 0,
	targets = nil,
   target_count = 0,
	blood_rune = 0
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
		_, cache.blood_rune = ni.runes.blood.status()
		cache.blood_plauge = ni.unit.debuff_remaining(t, 55078, p)
		cache.frost_fever = ni.unit.debuff_remaining(t, 55095, p)
		cache.targets = ni.unit.enemies_in_range(t, 14)
      cache.target_count = ni.table.length(cache.targets)
	end,
   ["AutoAttack"] = function()
      if not ni.spell.is_current(spells.AutoAttack.id) and ni.player.in_melee(t) then
         ni.spell.cast(spells.AutoAttack.id)
      end
   end,
   ["BloodPresence"] = function()
      if ni.spell.available(spells.BloodPresence.id) and not ni.player.buff(spells.BloodPresence.id) then
         ni.spell.cast(spells.BloodPresence.id)
         return true
      end
   end,
   ["RuneTap"] = function()
      if ni.spell.available(spells.RuneTap.id) and ni.player.hp() <= 30 then
         ni.spell.cast(spells.RuneTap.id)
      end
   end,
   ["VampiricBlood"] = function()
      if ni.spell.available(spells.VampiricBlood.id) and ni.player.hp() <= 30 then
         ni.spell.cast(spells.VampiricBlood.id)
      end
   end,
   ["BoneShield"]= function()
      if ni.spell.available(spells.BoneShield.id) and ni.player.hp() <= 75 then
         ni.spell.cast(spells.BoneShield.id)
         return true
      end
   end,
   ["IcyTouch"] = function()
      if cache.frost_fever < 1.5 and ni.spell.valid(spells.IcyTouch.id, t, true, true) then
         ni.spell.cast(spells.IcyTouch.id, t)
         return true
      end
   end,
   ["PlagueStrike"] = function()
      if cache.blood_plauge < 1.5 and ni.spell.valid(spells.PlagueStrike.id, t, true, true) then
         ni.spell.cast(spells.PlagueStrike.id, t)
         return true
      end
   end,
   ["BloodStrike"] = function()
      if ni.spell.valid(spells.BloodStrike.id, t, true, true) and not ni.spell.known(spells.HeartStrike.id) then
         ni.spell.cast(spells.BloodStrike.id, t)
         return true
      end
   end,
   ["Outbreak"] = function()
      if cache.blood_plauge < 2 and cache.frost_fever < 2 and ni.spell.valid(spells.Outbreak.id, t, true, true) then
         ni.spell.cast(spells.Outbreak.id, t)
         return true
      end
   end,
   ["HeartStrike"] = function()
      if ni.spell.valid(spells.HeartStrike.id, t, true, true) then
         ni.spell.cast(spells.HeartStrike.id, t)
         return true
      end
   end,
   ["DeathStrike"] = function()
      if ni.spell.valid(spells.DeathStrike.id, t, true, true) then
         ni.spell.cast(spells.DeathStrike.id, t)
         return true
      end
   end,
   ["DeathCoil"] = function()
      if ni.player.power(6) > 80 and ni.spell.valid(spells.DeathCoil.id, t, true, true) then
         ni.spell.cast(spells.DeathCoil.id, t)
         return true
      end
   end,
   ["RuneStrike"] = function()
      if ni.spell.valid(spells.RuneStrike.id, t, true, true) then
         ni.spell.cast(spells.RuneStrike.id, t)
         return true
      end
   end,
   ["Pestilence"] = function()
      local cast = false
      if cache.blood_plauge > 1 and cache.frost_fever > 1 and cache.target_count >= 2 and
      ni.spell.valid(spells.Pestilence.id, t, true, true) then
         for guid in ni.table.opairs(cache.targets) do
            if ni.unit.debuff_remaining(guid, 55078, p) < 2 or ni.unit.debuff_remaining(guid, 55078, p) < 2 then
               cast = true
            end
         end
      end
      if cast then
         ni.spell.cast(spells.Pestilence.id, t)
         return true
      end
   end,
   ["DeathandDecay"] = function()
      if ni.spell.available(spells.DeathandDecay.id) and cache.target_count >= 2 and ni.spell.in_range(spells.DeathCoil.id, t) then
         ni.spell.cast_on(spells.DeathandDecay.id, t, 1)
         return true
      end
   end,
   ["MindFreeze"] = function()
      if ni.unit.can_interupt(t, 30) and ni.spell.valid(spells.MindFreeze.id, t, true, true) then
         ni.spell.cast(spells.MindFreeze.id, t)
         return true
      end
   end
}
ni.profile.new("Blood_Cata", queue, abilities)
