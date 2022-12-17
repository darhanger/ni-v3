--Version: 12340
local ni = ...

local spells = {
   --General
   AutoAttack = {id = 6603, name = ni.spell.info(6603)},
   AxeSpecialization = {id = 20574, name = ni.spell.info(20574)},
   BloodFury = {id = 33697, name = ni.spell.info(33697)},
   ColdWeatherFlying = {id = 54197, name = ni.spell.info(54197)},
   Command = {id = 20575, name = ni.spell.info(20575)},
   Dodge = {id = 81, name = ni.spell.info(81)},
   DualWield = {id = 674, name = ni.spell.info(674)},
   Hardiness = {id = 20573, name = ni.spell.info(20573)},
   Parry = {id = 3127, name = ni.spell.info(3127)},
   Throw = {id = 2764, name = ni.spell.info(2764)},
   --Beast Mastery
   AspectoftheBeast = {id = 13161, name = ni.spell.info(13161)},
   AspectoftheCheetah = {id = 5118, name = ni.spell.info(5118)},
   AspectoftheDragonhawk = {id = 61847, name = ni.spell.info(61847)},
   AspectoftheHawk = {id = 27044, name = ni.spell.info(27044)},
   AspectoftheMonkey = {id = 13163, name = ni.spell.info(13163)},
   AspectofthePack = {id = 13159, name = ni.spell.info(13159)},
   AspectoftheViper = {id = 34074, name = ni.spell.info(34074)},
   AspectoftheWild = {id = 49071, name = ni.spell.info(49071)},
   BeastLore = {id = 1462, name = ni.spell.info(1462)},
   BestialWrath = {id = 19574, name = ni.spell.info(19574)},
   CallPet = {id = 883, name = ni.spell.info(883)},
   CallStabledPet = {id = 62757, name = ni.spell.info(62757)},
   DismissPet = {id = 2641, name = ni.spell.info(2641)},
   EagleEye = {id = 6197, name = ni.spell.info(6197)},
   EyesoftheBeast = {id = 1002, name = ni.spell.info(1002)},
   FeedPet = {id = 6991, name = ni.spell.info(6991)},
   Intimidation = {id = 19577, name = ni.spell.info(19577)},
   KillCommand = {id = 34026, name = ni.spell.info(34026)},
   MastersCall = {id = 53271, name = ni.spell.info(53271)},
   MendPet = {id = 48990, name = ni.spell.info(48990)},
   RevivePet = {id = 982, name = ni.spell.info(982)},
   ScareBeast = {id = 14327, name = ni.spell.info(14327)},
   TameBeast = {id = 1515, name = ni.spell.info(1515)},
   --Marksmanship
   ArcaneShot = {id = 49045, name = ni.spell.info(49045)},
   AutoShot = {id = 75, name = ni.spell.info(75)},
   ConcussiveShot = {id = 5116, name = ni.spell.info(5116)},
   DistractingShot = {id = 20736, name = ni.spell.info(20736)},
   Flare = {id = 1543, name = ni.spell.info(1543)},
   HuntersMark = {id = 53338, name = ni.spell.info(53338)},
   KillShot = {id = 61006, name = ni.spell.info(61006)},
   MultiShot = {id = 49048, name = ni.spell.info(49048)},
   RapidFire = {id = 3045, name = ni.spell.info(3045)},
   ScorpidSting = {id = 3043, name = ni.spell.info(3043)},
   SerpentSting = {id = 49001, name = ni.spell.info(49001)},
   SteadyShot = {id = 49052, name = ni.spell.info(49052)},
   TranquilizingShot = {id = 19801, name = ni.spell.info(19801)},
   ViperSting = {id = 3034, name = ni.spell.info(3034)},
   Volley = {id = 58434, name = ni.spell.info(58434)},
   --Survival
   Deterrence = {id = 19263, name = ni.spell.info(19263)},
   Disengage = {id = 781, name = ni.spell.info(781)},
   ExplosiveTrap = {id = 49067, name = ni.spell.info(49067)},
   FeignDeath = {id = 5384, name = ni.spell.info(5384)},
   FreezingArrow = {id = 60192, name = ni.spell.info(60192)},
   FreezingTrap = {id = 14311, name = ni.spell.info(14311)},
   FrostTrap = {id = 13809, name = ni.spell.info(13809)},
   ImmolationTrap = {id = 49056, name = ni.spell.info(49056)},
   Misdirection = {id = 34477, name = ni.spell.info(34477)},
   MongooseBite = {id = 53339, name = ni.spell.info(53339)},
   RaptorStrike = {id = 48996, name = ni.spell.info(48996)},
   SnakeTrap = {id = 34600, name = ni.spell.info(34600)},
   TrackBeasts = {id = 1494, name = ni.spell.info(1494)},
   TrackDemons = {id = 19878, name = ni.spell.info(19878)},
   TrackDragonkin = {id = 19879, name = ni.spell.info(19879)},
   TrackElementals = {id = 19880, name = ni.spell.info(19880)},
   TrackGiants = {id = 19882, name = ni.spell.info(19882)},
   TrackHidden = {id = 19885, name = ni.spell.info(19885)},
   TrackHumanoids = {id = 19883, name = ni.spell.info(19883)},
   TrackUndead = {id = 19884, name = ni.spell.info(19884)},
   WingClip = {id = 2974, name = ni.spell.info(2974)},
   --Pet
   Avoidance = {id = 65220, name = ni.spell.info(65220)},
   Bite = {id = 52474, name = ni.spell.info(52474)},
   Bloodthirsty = {id = 53186, name = ni.spell.info(53186)},
   BoarsSpeed = {id = 19596, name = ni.spell.info(19596)},
   Cower = {id = 1742, name = ni.spell.info(1742)},
   CullingtheHerd = {id = 61680, name = ni.spell.info(61680)},
   GreatStamina = {id = 61686, name = ni.spell.info(61686)},
   Growl = {id = 61676, name = ni.spell.info(61676)},
   LavaBreath = {id = 58611, name = ni.spell.info(58611)},
   NaturalArmor = {id = 61689, name = ni.spell.info(61689)},
   Rabid = {id = 53401, name = ni.spell.info(53401)},
   SharkAttack = {id = 62759, name = ni.spell.info(62759)},
   SpidersBite = {id = 53203, name = ni.spell.info(53203)},
   SpikedCollar = {id = 53182, name = ni.spell.info(53182)}
}

local enables = {
   ["PetAttack"] = true
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
   settingsfile = ni.player.guid() .. "_Beast_Master_Wrath.json",
   callback = GUICallback,
   {type = "label", text = "BM Hunter by Nuok"},
   {type = "checkbox", text = "Pet Attack", enabled = enables["PetAttack"], key = "PetAttack"},

}

local t, p, pet = "target", "player", "playerpet"

local cache = {
   mana = 0,
   moving = true,
   targets = {},
   target_count = 0,
   has_pet = ni.pet.exists() and ni.unit.hp(pet) > 0
}

local queue = {
   "Pause",
   "Cache",
   "WaitForCast",
   "AspectoftheDragonhawk",
   "AspectoftheViper",
   "MendPet",
   "PauseTarget",
   "PetAttack",
   "Misdirection",
   "KillCommand",
   "BestialWrath",
   "GCD",
   "KillShot",
   "MultiShot",
   "SerpentSting",
   "ArcaneShot",
   "SteadyShot"
}

local abilities = {
   ["Pause"] = function()
      if ni.mount.is_mounted() or ni.player.is_dead_or_ghost() then
         return true
      end
   end,
   ["PauseTarget"] = function()
      if
         ni.mount.is_mounted() or ni.player.is_dead_or_ghost() or not ni.unit.exists(t) or ni.unit.is_dead_or_ghost(t) or
            not ni.player.can_attack(t)
       then
         return true
      end
   end,
   ["PetAttack"] = function ()
      if enables["PetAttack"] and cache.has_pet and not ni.unit.unit_is_unit(t, pet..t) then
         ni.pet.attack()
      end
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
   ["Cache"] = function()
      cache.mana = ni.player.power_percent("mana")
      cache.moving = ni.player.is_moving()
      cache.targets = ni.unit.enemies_in_range(t, 10)
      cache.target_count = ni.table.length(cache.targets)
      cache.has_pet = ni.pet.exists()
   end,
   ["KillCommand"] = function ()
      if ni.spell.available(spells.KillCommand.name) then
         ni.spell.delay_cast(spells.KillCommand.name, p, 0.2)
      end
   end,
   ["BestialWrath"] = function ()
      if ni.spell.available(spells.BestialWrath.name) then
         ni.spell.delay_cast(spells.BestialWrath.name, p, 0.2)
      end
   end,
   ["KillShot"] = function ()
      if ni.spell.is_usable(spells.KillShot.name) and ni.spell.valid(spells.KillCommand.name, t, true, true) then
         ni.spell.cast(spells.KillShot.name, t)
         return true
      end
   end,
   ["MultiShot"] = function ()
      if cache.target_count > 1 and ni.spell.valid(spells.MultiShot.name, t, true, true) then
         ni.spell.cast(spells.MultiShot.name, t)
         return true
      end
   end,
   ["SerpentSting"] = function ()
      if ni.unit.debuff_remaining(t, spells.SerpentSting.name, p) < 2 and ni.spell.valid(spells.SerpentSting.name, t, true, true) then
         ni.spell.cast(spells.SerpentSting.name, t)
         return true
      end
   end,
   ["SteadyShot"] = function ()
      if not cache.moving and ni.spell.valid(spells.SteadyShot.name, t, true, true) then
         ni.spell.cast(spells.SteadyShot.name, t)
         return true
      end
   end,
   ["ArcaneShot"] = function ()
      if ni.spell.valid(spells.ArcaneShot.name, t, true, true) then
         ni.spell.cast(spells.ArcaneShot.name, t)
         return true
      end
   end,
   ["AspectoftheDragonhawk"] = function ()
      if cache.mana > 80 and not ni.player.buff(spells.AspectoftheDragonhawk.name) then
         ni.spell.delay_cast(spells.AspectoftheDragonhawk.name, p, 1)
      end
   end,
   ["AspectoftheViper"] = function ()
      if cache.mana < 20 and not ni.player.buff(spells.AspectoftheViper.name) then
         ni.spell.delay_cast(spells.AspectoftheViper.name, p, 1)
      end
   end,
   ["Misdirection"] = function ()
      if cache.has_pet then
         if ni.spell.valid(spells.Misdirection.name, pet, false, true, true) then
            ni.spell.cast(spells.Misdirection.name, pet)
            return true
         end
      end
   end,
   ["MendPet"] = function ()
      if cache.has_pet then
         if ni.unit.hp(pet) < 70 and not ni.unit.buff(pet, spells.MendPet.name) and ni.spell.valid(spells.MendPet.name, pet, false, true, true) then
            ni.spell.cast(spells.MendPet.name, pet)
            return true
         end
      end
   end
}

ni.profile.new("Beast_Master_Wrath", queue, abilities, ui)
