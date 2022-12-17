--Version: 15595
local ni = ...

local GetSpellTabInfo = ni.client.get_function("GetSpellTabInfo")

local spells = {
   --Elemental Combat
   BindElemental = {id = 76780, name = ni.spell.info(76780)},
   CalloftheAncestors = {id = 66843, name = ni.spell.info(66843)},
   CalloftheElements = {id = 66842, name = ni.spell.info(66842)},
   CalloftheSpirits = {id = 66844, name = ni.spell.info(66844)},
   ChainLightning = {id = 421, name = ni.spell.info(421)},
   EarthShock = {id = 8042, name = ni.spell.info(8042)},
   EarthbindTotem = {id = 2484, name = ni.spell.info(2484)},
   FireElementalTotem = {id = 2894, name = ni.spell.info(2894)},
   FireNova = {id = 1535, name = ni.spell.info(1535)},
   FlameShock = {id = 8050, name = ni.spell.info(8050)},
   FrostShock = {id = 8056, name = ni.spell.info(8056)},
   LavaBurst = {id = 51505, name = ni.spell.info(51505)},
   LightningBolt = {id = 403, name = ni.spell.info(403)},
   MagmaTotem = {id = 8190, name = ni.spell.info(8190)},
   Purge = {id = 370, name = ni.spell.info(370)},
   SearingTotem = {id = 3599, name = ni.spell.info(3599)},
   StoneclawTotem = {id = 5730, name = ni.spell.info(5730)},
   WindShear = {id = 57994, name = ni.spell.info(57994)},
   Hex = {id = 51514, name = ni.spell.info(51514)},
   SpiritwalkersGrace = {id = 79206, name = ni.spell.info(79206)},
   --Enhancement
   AstralRecall = {id = 556, name = ni.spell.info(556)},
   Bloodlust = {id = 2825, name = ni.spell.info(2825)},
   EarthElementalTotem = {id = 2062, name = ni.spell.info(2062)},
   ElementalResistanceTotem = {id = 8184, name = ni.spell.info(8184)},
   FarSight = {id = 6196, name = ni.spell.info(6196)},
   FlametongueTotem = {id = 8227, name = ni.spell.info(8227)},
   FlametongueWeapon = {id = 8024, name = ni.spell.info(8024)},
   FrostbrandWeapon = {id = 8033, name = ni.spell.info(8033)},
   GhostWolf = {id = 2645, name = ni.spell.info(2645)},
   GroundingTotem = {id = 8177, name = ni.spell.info(8177)},
   LightningShield = {id = 324, name = ni.spell.info(324)},
   PrimalStrike = {id = 73899, name = ni.spell.info(73899)},
   StoneskinTotem = {id = 8071, name = ni.spell.info(8071)},
   StrengthofEarthTotem = {id = 8075, name = ni.spell.info(8075)},
   WaterBreathing = {id = 131, name = ni.spell.info(131)},
   WaterWalking = {id = 546, name = ni.spell.info(546)},
   WindfuryTotem = {id = 8512, name = ni.spell.info(8512)},
   WindfuryWeapon = {id = 8232, name = ni.spell.info(8232)},
   WrathofAirTotem = {id = 3738, name = ni.spell.info(3738)},
   RockbiterWeapon = {id = 8017, name = ni.spell.info(8017)},
   UnleashElements = {id = 73680, name = ni.spell.info(73680)},
   --Restoration
   AncestralSpirit = {id = 2008, name = ni.spell.info(2008)},
   ChainHeal = {id = 1064, name = ni.spell.info(1064)},
   CleanseSpirit = {id = 51886, name = ni.spell.info(51886)},
   EarthShield = {id = 974, name = ni.spell.info(974)},
   EarthlivingWeapon = {id = 51730, name = ni.spell.info(51730)},
   GreaterHealingWave = {id = 77472, name = ni.spell.info(77472)},
   HealingStreamTotem = {id = 5394, name = ni.spell.info(5394)},
   HealingSurge = {id = 8004, name = ni.spell.info(8004)},
   HealingWave = {id = 331, name = ni.spell.info(331)},
   ManaSpringTotem = {id = 5675, name = ni.spell.info(5675)},
   ManaTideTotem = {id = 16190, name = ni.spell.info(16190)},
   Meditation = {id = 95862, name = ni.spell.info(95862)},
   NaturesSwiftness = {id = 16188, name = ni.spell.info(16188)},
   Purification = {id = 16213, name = ni.spell.info(16213)},
   Reincarnation = {id = 20608, name = ni.spell.info(20608)},
   Riptide = {id = 61295, name = ni.spell.info(61295)},
   SpiritLinkTotem = {id = 98008, name = ni.spell.info(98008)},
   TotemicRecall = {id = 36936, name = ni.spell.info(36936)},
   TremorTotem = {id = 8143, name = ni.spell.info(8143)},
   WaterShield = {id = 52127, name = ni.spell.info(52127)},
   TotemofTranquilMind = {id = 87718, name = ni.spell.info(87718)},
   HealingRain = {id = 73920, name = ni.spell.info(73920)}
}

local enables = {
	["RiptideTank"] = true,
	["HealingSurgeTank"] = true,
	["OnlyCombat"] = false,
	["ChainHealHP"] = true,
	["MultiTotem"] = true,
	["CleanseSpirit"] = false,
	["TotemicRecall"] = true,
	["HealingSurge"] = true,
	["HealingWave"] = true,
	["GreaterHealingWave"] = true
}
local values = {
	["RiptideTank"] = 92,
	["HealingSurgeTank"] = 85,
	["RiptideHP"] = 92,
	["HealingSurgeHP"] = 70,
	["HealingWaveHP"] = 86,
	["ChainHealHP"] = 75,
	["GreaterHealingWave"] = 60,
	["TotemicRecall"] = 30
}
local inputs = {}
local menus = {
	["EarthShieldTar"] = 1,
	["Callofthe"] = 1
}

local function GUICallback(key, item_type, value)
   ni.utilities.log("GUICallback " .. key..item_type..tostring(value))
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

local Callofthe = {
	Elements = 1,
	Ancestors = 2,
	Spirits = 3
}

local ui = {
	settingsfile = "RestroCata.json",
	callback = GUICallback,
	{type = "title", text = GetSpellTabInfo(4)},
	{type = "separator"},
	{type = "title", text = "Earth Shield Target"},
	{
		type = "combobox",
		menu = {
			{selected = (menus["EarthShieldTar"] == 1), value = 1, text = "Main Tank"},
			{selected = (menus["EarthShieldTar"] == 2), value = 2, text = "Off Tank"},
			{selected = (menus["EarthShieldTar"] == 2), value = 3, text = "Focus"}
		},
		key = "EarthShieldTar"
	},
	{type = "separator"},
	{type = "title", text = "Tank Heal"},
	{
		type = "checkbox",
		text = "Riptide Tank HP",
		value = values["RiptideTank"],
		enabled = enables["RiptideTank"],
		key = "RiptideTank"
	},
   {
		type = "slider",
		value = values["RiptideTank"],
      min =  0,
      max = 100,
		key = "RiptideTank"
	},
	{
		type = "checkbox",
		text = "Healing Surge Tank HP",
		enabled = enables["HealingSurgeTank"],
		key = "HealingSurgeTank"
	},
   {
		type = "slider",
		value = values["HealingSurgeTank"],
      min =  0,
      max = 100,
		key = "HealingSurgeTank"
	},
	{type = "separator"},
	{type = "title", text = "Heals"},
	{
		type = "checkbox",
		text = "Riptide HP",
		value = values["RiptideHP"],
		key = "RiptideHP"
	},
   {
		type = "slider",
		value = values["RiptideHP"],
      min =  0,
      max = 100,
		key = "RiptideHP"
	},
	{
		type = "checkbox",
		text = "Healing Surge HP",
		enabled = enables["HealingSurge"],
		key = "HealingSurgeHP"
	},
   {
		type = "slider",
		value = values["HealingSurgeHP"],
      min =  0,
      max = 100,
		key = "HealingSurgeHP"
	},
	{
		type = "checkbox",
		text = "Healing Wave HP",
		enabled = enables["HealingWave"],
		key = "HealingWaveHP"
	},
   {
		type = "slider",
		value = values["HealingWaveHP"],
      min =  0,
      max = 100,
		key = "HealingWaveHP"
	},
	{
		type = "checkbox",
		text = "Greater Healin gWave HP",
		value = values["GreaterHealingWave"],
		enabled = enables["GreaterHealingWave"],
		key = "GreaterHealingWave"
	},
   {
		type = "slider",
		value = values["GreaterHealingWave"],
      min =  0,
      max = 100,
		key = "GreaterHealingWave"
	},
	{
		type = "checkbox",
		text = "Chain Heal HP",
		enabled = enables["ChainHealHP"],
		key = "ChainHealHP"
	},
   {
		type = "slider",
		value = values["ChainHealHP"],
      min =  0,
      max = 100,
		key = "ChainHealHP"
	},
	{
		type = "checkbox",
		text = "Cleanse Spirit",
		enabled = enables["CleanseSpirit"],
		key = "CleanseSpirit"
	},
	{type = "separator"},
	{type = "title", text = "Totems"},
	{
		type = "checkbox",
		text = "Use Call of the Totems",
		enabled = enables["MultiTotem"],
		key = "MultiTotem"
	},
	{type = "title", text = "Call Totem Set"},
	{
		type = "combobox",
		menu = {
			{
				selected = (menus["Callofthe"] == Callofthe.Elements),
				value = Callofthe.Elements,
				text = spells.CalloftheElements.name
			},
			{
				selected = (menus["Callofthe"] == Callofthe.Ancestors),
				value = Callofthe.Ancestors,
				text =  spells.CalloftheAncestors.name
			},
			{
				selected = (menus["Callofthe"] == Callofthe.Spirits),
				value = Callofthe.Ancestors,
				text = spells.CalloftheSpirits.name
			}
		},
		key = "Callofthe"
	},
	{
		type = "checkbox",
		text = spells.TotemicRecall.name,
		enabled = enables["TotemicRecall"],
		key = "TotemicRecall"
	},
   {
		type = "slider",
		value = values["TotemicRecall"],
      min =  0,
      max = 60,
		key = "TotemicRecall"
	},
}

local cache = {
   moving = ni.player.is_moving(),
   members = {},
   group_size = 0,
   tanks = {}
}

local function SortByHP(x, y)
	return x.health_percent < y.health_percent
end

local queue = {
   "Pause",
   "Cache",
   "GCD", --All Spells on GCD need to be
   "WaterShield",
   "EarthlivingWeapon",
}

local abilities = {
   ["Pause"] = function()
      if ni.mount.is_mounted() or ni.player.is_dead_or_ghost() then
         return true
      end
   end,
   ["Cache"] = function()
      cache.moving = ni.player.is_moving()
      if cache.group_size ~= ni.group.size() then
         ni.table.owipe(cache.members)
         ni.table.owipe(cache.tanks)
         for index, value in ni.table.opairs(ni.members) do
            if ni.group.in_range(index, 39) and value.los() then
               cache.members[index] = value
               if ni.group.is_tank(index) then
                  cache.tanks[index] = value
               end
            end
         end
         cache.members = ni.members
         cache.group_size = ni.group.size()
      end
      table.sort(cache.members, SortByHP)
   end,
   ["GCD"] = function()
      if ni.spell.on_gcd() then
         return true
      end
   end,
   ["WaterShield"] = function()
      if ni.spell.available(spells.WaterShield.id) and not ni.player.buff(spells.WaterShield.id) then
         ni.spell.cast(spells.WaterShield.id)
         return true
      end
   end,
   ["EarthlivingWeapon"] = function()
      if ni.spell.available(spells.EarthlivingWeapon.id) and not ni.gear.weapon_enchant_info() then
         ni.spell.cast(spells.EarthlivingWeapon.id)
         return true
      end
   end,
}
ni.profile.new("Restoration_Cata", queue, abilities, ui)