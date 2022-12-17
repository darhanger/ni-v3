--Version: 12340
local ni = ...

local spells = {
--General
  AutoAttack = {id = 6603, name = ni.spell.info(6603)},
--Arms
  BattleStance = {id = 2457, name = ni.spell.info(2457)},
  Charge = {id = 11578, name = ni.spell.info(11578)},
  Hamstring = {id = 1715, name = ni.spell.info(1715)},
  HeroicStrike = {id = 29707, name = ni.spell.info(29707)},
  MockingBlow = {id = 694, name = ni.spell.info(694)},
  Overpower = {id = 7384, name = ni.spell.info(7384)},
  Rend = {id = 25208, name = ni.spell.info(25208)},
  Retaliation = {id = 20230, name = ni.spell.info(20230)},
  ThunderClap = {id = 25264, name = ni.spell.info(25264)},
--Fury
  BattleShout = {id = 25289, name = ni.spell.info(25289)},
  BerserkerRage = {id = 18499, name = ni.spell.info(18499)},
  ChallengingShout = {id = 1161, name = ni.spell.info(1161)},
  Cleave = {id = 25231, name = ni.spell.info(25231)},
  CommandingShout = {id = 469, name = ni.spell.info(469)},
  DemoralizingShout = {id = 25202, name = ni.spell.info(25202)},
  Execute = {id = 25234, name = ni.spell.info(25234)},
  Intercept = {id = 20252, name = ni.spell.info(20252)},
  IntimidatingShout = {id = 5246, name = ni.spell.info(5246)},
  Pummel = {id = 6552, name = ni.spell.info(6552)},
  Recklessness = {id = 1719, name = ni.spell.info(1719)},
  Slam = {id = 25241, name = ni.spell.info(25241)},
  VictoryRush = {id = 34428, name = ni.spell.info(34428)},
  Whirlwind = {id = 1680, name = ni.spell.info(1680)},
--Protection
  Bloodrage = {id = 2687, name = ni.spell.info(2687)},
  ConcussionBlow = {id = 12809, name = ni.spell.info(12809)},
  DefensiveStance = {id = 71, name = ni.spell.info(71)},
  Devastate = {id = 30016, name = ni.spell.info(30016)},
  Disarm = {id = 676, name = ni.spell.info(676)},
  LastStand = {id = 12975, name = ni.spell.info(12975)},
  Revenge = {id = 25269, name = ni.spell.info(25269)},
  ShieldBash = {id = 72, name = ni.spell.info(72)},
  ShieldBlock = {id = 2565, name = ni.spell.info(2565)},
  ShieldSlam = {id = 25258, name = ni.spell.info(25258)},
  ShieldWall = {id = 871, name = ni.spell.info(871)},
  Shockwave = {id = 46968, name = ni.spell.info(46968)},
  SpellReflection = {id = 23920, name = ni.spell.info(23920)},
  StanceMastery = {id = 12678, name = ni.spell.info(12678)},
  SunderArmor = {id = 7386, name = ni.spell.info(7386)},
  Taunt = {id = 355, name = ni.spell.info(355)},
  Vigilance = {id = 50720, name = ni.spell.info(50720)},
}

local queue = {
   "Pause",
   "Cache",
   "ShieldBlock",
   "HeroicStrike",
   "Cleave",
   "GCD",
   "ShieldSlam",
   "Revenge",
   "ThunderClap",
   "Rend",
   "Devastate"
}

local t, p = "target", "player"
local cache = {
	targets = nil,
   target_count = 0,
   rage = 0
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
		cache.targets = ni.player.enemies_in_range(9)
      cache.target_count = ni.table.length(cache.targets)
      cache.rage = ni.player.power(1)
	end,
   ["ShieldSlam"] = function()
      if ni.spell.valid(spells.ShieldSlam.name, t) then
         ni.spell.cast(spells.ShieldSlam.name, t)
         return true
      end
   end,
   ["ShieldBlock"] = function()
      if ni.spell.available(spells.ShieldBlock.name) and ni.player.hp() < 90 then
         ni.spell.cast(spells.ShieldBlock.name)
         return true
      end
   end,
   ["Revenge"] = function()
      if ni.spell.available(spells.Revenge.name) and ni.spell.is_usable(spells.Revenge.name) then
         ni.spell.cast(spells.Revenge.name, t)
         return true
      end
   end,
   ["Devastate"] = function()
      if ni.spell.valid(spells.Devastate.name, t) and cache.rage > 30 then
         ni.spell.cast(spells.Devastate.name, t)
         return true
      end
   end,
   ["Rend"] = function()
      if ni.spell.valid(spells.Rend.name, t) and not ni.unit.debuff(t, spells.Rend.name, p) then
         ni.spell.cast(spells.Rend.name, t)
         return true
      end
   end,
   ["ThunderClap"] = function()
      if ni.spell.available(spells.ThunderClap.name) and cache.target_count >= 2 then
         ni.spell.cast(spells.ThunderClap.name)
         return true
      end
   end,
   ["HeroicStrike"] = function()
      if ni.spell.valid(spells.HeroicStrike.name, t, true, true) and
      not ni.spell.is_current(spells.HeroicStrike.name) and
      cache.rage > 60 and
      cache.target_count < 2 then
         ni.spell.cast(spells.HeroicStrike.name, t)
      end
   end,
   ["Cleave"] = function()
      if ni.spell.valid(spells.Cleave.name, t, true, true) and
      not ni.spell.is_current(spells.Cleave.name) and
      cache.rage > 60 and
      cache.target_count > 1 then
         ni.spell.cast(spells.Cleave.name, t)
      end
   end,
}
ni.profile.new("Protection_Wrath", queue, abilities)