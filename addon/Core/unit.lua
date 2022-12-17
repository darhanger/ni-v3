-------------------
-- Unit functions for ni
local ni = ...

ni.unit = {}

-- Localizations to avoid hooks from servers
local UnitExists = ni.client.get_function("UnitExists")
local UnitThreatSituation = ni.client.get_function("UnitThreatSituation")
local UnitGUID = ni.client.get_function("UnitGUID")
local UnitHealth = ni.client.get_function("UnitHealth")
local UnitHealthMax = ni.client.get_function("UnitHealthMax")
local UnitCastingInfo = ni.client.get_function("UnitCastingInfo")
local UnitChannelInfo = ni.client.get_function("UnitChannelInfo")
local UnitIsDeadOrGhost = ni.client.get_function("UnitIsDeadOrGhost")
local UnitCanAttack = ni.client.get_function("UnitCanAttack")
local UnitBuff = ni.client.get_function("UnitBuff")
local UnitDebuff = ni.client.get_function("UnitDebuff")
local UnitCanAssist = ni.client.get_function("UnitCanAssist")
local UnitClass = ni.client.get_function("UnitClass")
local UnitName = ni.client.get_function("UnitName")
local GetUnitSpeed = ni.client.get_function("GetUnitSpeed")
local UnitInVehicle = ni.client.get_function("UnitInVehicle")
local GetComboPoints = ni.client.get_function("GetComboPoints")
local UnitAffectingCombat = ni.client.get_function("UnitAffectingCombat")
local UnitIsUnit = ni.client.get_function("UnitIsUnit")
local UnitClassification = ni.client.get_function("UnitClassification")
local select = ni.client.get_function("select")

--[[--
Table keys:
- **name** `string`
- **ID** `number`
@table aura
]]

--[[--
Gets the auras on the specified target.
 
Parameters:
- **target** `string`
 
Returns:
- **auras** `aura table`
@param target string
]]
function ni.unit.auras(target)
   return ni.backend.Auras(target) or {}
end

--[[--
Gets the best location that meets the criteria passed.
 
Parameters:
- **target** `string`
- **distance** `number`
- **radius** `number`
- **score** `number`
- **callback** `function`
- **friendly** `boolean`
- **height_max** `number`
- **max_distance** `number`
 
Returns:
- **x** `number`
- **y** `number`
- **z** `number`
@param target string
@param distance number
@param radius number
@param[opt] score number
@param[opt] callback function
@param[opt] friendly boolean
@param[opt] height_max number
@param[opt] max_distance number
]]
function ni.unit.best_location(target, distance, radius, score, callback, friendly, height_max, max_distance)
   return ni.backend.BestLocation(target, distance, radius, score, callback, friendly, height_max, max_distance)
end

--[[--
Wrapper for best_location for friendly target
 
Parameters:
- **target** `string`
- **distance** `number`
- **radius** `number`
- **score** `number`
- **callback** `function`
- **height_max** `number`
- **max_distance** `number`
 
Returns:
- **x** `number`
- **y** `number`
- **z** `number`
@param target string
@param distance number
@param radius number
@param[opt] score number
@param[opt] callback function
@param[opt] height_max number
@param[opt] max_distance number
]]
function ni.unit.best_helpful_location(target, distance, radius, score, callback, height_max, max_distance)
   return ni.backend.BestLocation(target, distance, radius, score, callback, true, height_max, max_distance)
end

--[[--
Wrapper for best_location for enemy target
 
Parameters:
- **target** `string`
- **distance** `number`
- **radius** `number`
- **score** `number`
- **callback** `function`
- **height_max** `number`
- **max_distance** `number`
 
Returns:
- **x** `number`
- **y** `number`
- **z** `number`
@param target string
@param distance number
@param radius number
@param[opt] score number
@param[opt] callback function
@param[opt] height_max number
@param[opt] max_distance number
]]
function ni.unit.best_damage_location(target, distance, radius, score, callback, height_max, max_distance)
   return ni.backend.BestLocation(target, distance, radius, score, callback, false, height_max, max_distance)
end

--[[--
Gets the combat reach for the specified target.
 
Parameters:
- **target** `string`
 
Returns:
- **combat_reach** `number`
@param target string
]]
function ni.unit.combat_reach(target)
   return ni.backend.CombatReach(target)
end

--[[--
Checks if the unit exists.
 
Parameters:
- **target** `string`
 
Returns:
- **exists** `boolean`
@param target string
]]
function ni.unit.exists(target)
   return UnitExists(target)
end

--[[--
Gets the targets guid
 
Parameters:
- **target** `string`
 
Returns:
- **guid** `string`
@param target string
]]
function ni.unit.guid(target)
   return UnitGUID(target)
end

--[[--
Gets the short guid
 
Parameters:
- **target** `string`
 
Returns:
- **short_guid** `string`
@param target string
]]
function ni.unit.short_guid(target)
   local guid = ni.unit.guid(target)
   return guid and string.sub(guid, -5, -1) or nil
end

--[[--
Gets the targets current health
 
Parameters:
- **target** `string`
 
Returns:
- **health** `number`
@param target string
]]
function ni.unit.health(target)
   return UnitHealth(target)
end

--[[--
Gets the targets max health
 
Parameters:
- **target** `string`
 
Returns:
- **max_health** `number`
@param target string
]]
function ni.unit.health_max(target)
   return UnitHealthMax(target)
end

--[[--
Gets the targets health deficit
 
Parameters:
- **target** `string`
 
Returns:
- **deficit** `number`
@param target string
]]
function ni.unit.health_deficit(target)
   return ni.unit.health_max(target) - ni.unit.health(target)
end

--[[--
Gets the targets health percent
 
Parameters:
- **target** `string`
 
Returns:
- **health_percent** `number`
@param target string
]]
function ni.unit.health_percent(target)
   return 100 * ni.unit.health(target) / ni.unit.health_max(target)
end

--[[--
Shorthand function for health_percent.

See [ni.unit.health_percent](#ni.unit.health_percent (target))
@param target string
]]
function ni.unit.hp(target)
   return ni.unit.health_percent(target)
end

--[[--
Gets the information of the specified target
 
Parameters:
- **target** `string`
 
Returns:
- **x** `number`
- **y** `number`
- **z** `number`
- **type** `number`
- **target** `string`
- **height** `number`
@param target string
]]
function ni.unit.info(target)
   return ni.backend.ObjectInfo(target)
end

--[[--
Gets the units target
 
Parameters:
- **target** `string`
 
Returns:
- **guid** `string`
@param target string
]]
function ni.unit.target(target)
   local _, _, _, _, guid = ni.unit.info(target)
   return guid
end

--[[--
Gets the units height
 
Parameters:
- **target** `string`
 
Returns:
- **height** `number`
@param target string
]]
function ni.unit.height(target)
   local _, _, _, _, _, height = ni.unit.info(target)
   return height
end

--[[--
Gets the location of the specified target.
 
Parameters:
- **target** `string`
 
Returns:
- **x** `number`
- **y** `number`
- **z** `number`
@param target string
]]
function ni.unit.location(target)
   return ni.object.location(target)
end

--[[--
Gets the the class of the unit, Locale-independent
 
Parameters:
- **target** `string`
 
Returns:
- **class_name** `string`
@param target string
]]
ni.unit.class = function(target)
   local _, class_name = UnitClass(target)
   return class_name
end

--[[--
Gets the the name of the unit
 
Parameters:
- **target** `string`
 
Returns:
- **class_name** `string`
@param target string
]]
ni.unit.name = function(target)
   return UnitName(target)
end

--[[--
Checks if one target is facing another.
 
Parameters:
- **target_a** `string`
- **target_b** `string`
- **field_of_view** `number`
 
Returns:
- **facing** `boolean`
@param target_a string
@param target_b string
@param[opt] field_of_view number
]]
function ni.unit.is_facing(target_a, target_b, field_of_view)
   return ni.backend.IsFacing(target_a, target_b, field_of_view)
end

--[[--
Checks if one target is behind another.
 
Parameters:
- **target_a** `string`
- **target_b** `string`
 
Returns:
- **behind** `boolean`
@param target_a string
@param target_b string
]]
function ni.unit.is_behind(target_a, target_b)
   return ni.backend.IsBehind(target_a, target_b)
end

--[[--
Checks if a target has a specific aura id or name.
 
Parameters:
- **target** `string`
- **aura** `number or string`
 
Returns:
- **has_aura** `boolean`
@param target string
@param aura
]]
function ni.unit.has_aura(target, aura)
   return ni.backend.HasAura(target, aura) or false
end

--[[--
Gets the distance between two targets.
 
Parameters:
- **target_a** `string`
- **target_b** `string`
 
Returns:
- **distance** `number`
@param target_a string
@param target_b string
]]
function ni.unit.distance(target_a, target_b)
   return ni.backend.GetDistance(target_a, target_b)
end

--[[--
Gets the distance between two targets based on 3 vectors
 
Parameters:
- **target_a** `string`
- **target_b** `string`
 
Returns:
- **distance** `number`
@param target_a string
@param target_b string
]]
function ni.unit.distance_3d(target_a, target_b)
   local x1, y1, z1 = ni.unit.location(target_a)
   local x2, y2, z2 = ni.unit.location(target_b)
   return ni.world.get_3d_distance(x1, y1, z1, x2, y2, z2)
end

--[[--
Gets the GUID of the units creator.
 
Parameters:
- **target** `string`
 
Returns:
- **guid** `string`
@param target string
]]
function ni.unit.creator(target)
   return ni.object.creator(target)
end

--[[--
Gets the units dynamic flags.
 
Parameters:
- **target** `string`
 
Returns:
- **flags** `boolean`
 
Notes:
This function will return 9 different values which are all booleans for the
dynamic flags 1 - 9. (Dynamic flag titles may be different for expansions)
I was being lazy, and didn't want to type out the 9 different returns.
@param target string
]]
function ni.unit.dynamic_flags(target)
   return ni.backend.UnitDynamicFlags(target)
end

--[[--
Checks if the unit is not lootable
 
Parameters:
- **target** `string`
 
Returns:
- **is_lootable** `boolean`
@param target string
]]
function ni.unit.is_lootable(target)
   return select(2, ni.unit.dynamic_flags(target)) or false
end

--[[--
Gets the units flags.
 
Parameters:
- **target** `string`
 
Returns:
- **flags** `boolean`
 
Notes:
This function will return 32 different values which are all booleans for the
dynamic flags 1 - 32. (Flag titles may be different for expansions)
I was being lazy, and didn't want to type out the 32 different returns.
@param target string
]]
function ni.unit.flags(target)
   return ni.backend.UnitFlags(target)
end

--[[--
Checks if the unit can perform action
 
Parameters:
- **target** `string`
 
Returns:
- **can_perform_action** `boolean`
@param target string
]]
function ni.unit.can_perform_action(target)
   return select(1, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is not attackable
 
Parameters:
- **target** `string`
 
Returns:
- **is_not_attackable** `boolean`
@param target string
]]
function ni.unit.is_not_attackable(target)
   return select(2, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is player controlled
 
Parameters:
- **target** `string`
 
Returns:
- **is_player_controlled** `boolean`
@param target string
]]
function ni.unit.is_player_controlled(target)
   return select(4, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is preparation
 
Parameters:
- **target** `string`
 
Returns:
- **is_preparation** `boolean`
@param target string
]]
function ni.unit.is_preparation(target)
   return select(6, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is looting
 
Parameters:
- **target** `string`
 
Returns:
- **is_looting** `boolean`
@param target string
]]
function ni.unit.is_looting(target)
   return select(11, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is pet in combat
 
Parameters:
- **target** `string`
 
Returns:
- **is_pet_in_combat** `boolean`
@param target string
]]
function ni.unit.is_pet_in_combat(target)
   return select(12, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is pvp flagged
 
Parameters:
- **target** `string`
 
Returns:
- **is_pvp_flagged** `boolean`
@param target string
]]
function ni.unit.is_pvp_flagged(target)
   return select(13, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is silenced
 
Parameters:
- **target** `string`
 
Returns:
- **is_silenced** `boolean`
@param target string
]]
function ni.unit.is_silenced(target)
   return select(14, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is pacified
 
Parameters:
- **target** `string`
 
Returns:
- **is_pacified** `boolean`
@param target string
]]
function ni.unit.is_pacified(target)
   return select(18, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is stunned
 
Parameters:
- **target** `string`
 
Returns:
- **is_stunned** `boolean`
@param target string
]]
function ni.unit.is_stunned(target)
   return select(19, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is disarmed
 
Parameters:
- **target** `string`
 
Returns:
- **is_disarmed** `boolean`
@param target string
]]
function ni.unit.is_disarmed(target)
   return select(22, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is confused
 
Parameters:
- **target** `string`
 
Returns:
- **is_confused** `boolean`
@param target string
]]
function ni.unit.is_confused(target)
   return select(23, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is fleeing
 
Parameters:
- **target** `string`
 
Returns:
- **is_fleeing** `boolean`
@param target string
]]
function ni.unit.is_fleeing(target)
   return select(24, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is possessed
 
Parameters:
- **target** `string`
 
Returns:
- **is_possessed** `boolean`
@param target string
]]
function ni.unit.is_possessed(target)
   return select(25, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is not selectable
 
Parameters:
- **target** `string`
 
Returns:
- **is_not_selectable** `boolean`
@param target string
]]
function ni.unit.is_not_selectable(target)
   return select(26, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is skinnable
 
Parameters:
- **target** `string`
 
Returns:
- **is_skinnable** `boolean`
@param target string
]]
function ni.unit.is_skinnable(target)
   return select(27, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is mounted
 
Parameters:
- **target** `string`
 
Returns:
- **is_mounted** `boolean`
@param target string
]]
function ni.unit.is_mounted(target)
   return select(28, ni.unit.flags(target)) or false
end

--[[--
Checks if the unit is immune
 
Parameters:
- **target** `string`
 
Returns:
- **is_immune** `boolean`
@param target string
]]
function ni.unit.is_immune(target)
   return select(32, ni.unit.flags(target)) or false
end

--[[--
Gets the units creature type.
 
Parameters:
- **target** `string`
 
Returns:
- **creature_type** `number`
@param target string
]]
function ni.unit.type(target)
   return ni.backend.CreatureType(target) or 0
end

--[[--
Checks if the unit is a totem
 
Parameters:
- **target** `string`
 
Returns:
- **is_totem** `boolean`
@param target string
]]
function ni.unit.is_totem(target)
   return ni.unit.type(target) == 11
end

--[[--
Checks if the unit is a undead
 
Parameters:
- **target** `string`
 
Returns:
- **is_undead** `boolean`
@param target string
]]
function ni.unit.is_undead(target)
   return ni.unit.type(target) == 6
end

--[[--
Checks if the unit is in a vehicle
 
Parameters:
- **target** `string`
 
Returns:
- **in_vehicle** `boolean`
@param target string
]]
function ni.unit.in_vehicle(target)
   return UnitInVehicle(target) == 1
end

--[[--
Returns the amount of current combo points.
 
Parameters:
- **target_a** `string`
- **target_b** `string`
 
Returns:
- **combo_points** `number`
@param target_a string
@param target_b string
]]
function ni.unit.combo_points(target_a, target_b)
   return GetComboPoints(target_a, target_b)
end

--[[--
Checks if the unit is a demon
 
Parameters:
- **target** `string`
 
Returns:
- **is_demon** `boolean`
@param target string
]]
function ni.unit.is_demon(target)
   return ni.unit.type(target) == 3
end

--[[--
Checks the units threat to a target
 
Parameters:
- **target_a** `string`
- **target_b** `string`
 
Returns:
- **threat** `number`
@param target_a string
@param target_b string
]]
function ni.unit.threat(target_a, target_b)
   local threat = UnitThreatSituation(target_a, target_b)
   return threat or -1
end

--[[--
Checks if two units are in line of sight of each other.
 
Parameters:
- **target_a** `string`
- **target_b** `string`
- **hit_flags** `number`
 
Returns:
- **success** `boolean`
- **intersection_x** `number`
- **intersection_y** `number`
- **intersection_z** `number`
@param target_a string
@param target_b string
@param[opt] hit_flags number
]]
function ni.unit.los(target_a, target_b, hit_flags)
   return ni.backend.LoS(target_a, target_b, hit_flags)
end

--[[--
Gets the units pointer
 
Parameters:
- **target** `string`
 
Returns:
- **pointer** `number`
- **hex_pointer** `string`
@param target string
]]
function ni.unit.pointer(target)
   return ni.object.pointer(target)
end

--[[--
Gets the units transport guid
 
Parameters:
- **target** `string`
 
Returns:
- **guid** `string`
@param target string
]]
function ni.unit.transport(target)
   return ni.object.transport(target)
end

--[[--
Gets the units facing in radians
 
Parameters:
- **target** `string`
 
Returns:
- **direction** `number`
@param target string
]]
function ni.unit.facing(target)
   return ni.backend.ObjectFacing(target)
end

--[[--
Gets the unit descriptor value for the given index
 
Parameters:
- **target** `string`
- **index** `number`
 
Returns:
- **descriptor** `number`
@param target string
@param index number
]]
function ni.unit.descriptor(target, index)
   return ni.object.descriptor(target, index)
end

--[[--
Gets the melee range between two units
 
Parameters:
- **target_a** `string`
- **target_b** `string`
 
Returns:
- **range** `number`
@param target_a string
@param target_b string
]]
function ni.unit.melee_range(target_a, target_b)
   local combat_reach_a = ni.unit.combat_reach(target_a)
   local combat_reach_b = ni.unit.combat_reach(target_b)
   return math.max(5.0, combat_reach_a + combat_reach_b + (4 / 3))
end

--[[--
Checks if unit is in melee range of another target
 
Parameters:
- **target_a** `string`
- **target_b** `string`
 
Returns:
- **in_melee** `boolean`
@param target_a string
@param target_b string
]]
function ni.unit.in_melee(target_a, target_b)
   local distance = ni.unit.distance(target_a, target_b)
   if not distance then
      return false
   end
   return distance < ni.unit.melee_range(target_a, target_b)
end

--[[--
Checks if unit is moving
 
Parameters:
- **target** `string`
 
Returns:
- **is_moving** `boolean`
@param target string
]]
function ni.unit.is_moving(target)
   return GetUnitSpeed(target) ~= 0
end

--[[--
Returns the classification of the specified unit (e.g., "elite" or "worldboss")

Parameters: 
- **target** `string`
 
Returns:
- **classification** `string`
@param target string
]]
function ni.unit.classification(target)
   return UnitClassification(target)
end


--[[--
Checks if the target is a raid boss

Parameters: 
- **target** `string`
 
Returns:
- **is_boss** `boolean`
@param target string
]]
function ni.unit.is_boss(target)
   return ni.unit.classification(target) == "worldboss"
end

--[[--
Checks if unit is in combat
 
Parameters:
- **target** `string`
 
Returns:
- **affecting_combat** `boolean`
@param target string
]]
function ni.unit.affecting_combat(target)
   return UnitAffectingCombat(target) == 1
end

--[[
True if the specified units are the same unit.
 
Parameters:
- **target_a** `string`
- **target_b** `string`
 
Returns:
- **is_same** `boolean`
@param target_a string
@param target_b string
]]
function ni.unit.unit_is_unit(target_a, target_b)
   return UnitIsUnit(target_a, target_b) == 1
end

--[[--
Gets the casting information for the specified target
 
Parameters:
- **target** `string`
 
Returns:
- **...**
 
Notes:
See the returns for UnitCastingInfo
@param target string
]]
function ni.unit.casting(target)
   return UnitCastingInfo(target)
end

--[[--
Gets if the target is casting currently
 
Parameters:
- **target**
 
Returns:
- **casting** `boolean`
@param target string
]]
function ni.unit.is_casting(target)
   return ni.unit.casting(target) and true or false
end

--[[--
@local
Helper function to avoid the calculations being typed twice.
 
Parameters:
- **start_time** `number`
- **end_time** `number`
 
Returns:
- **percent_complete** `number`
@param start_time number
@param end_time number
]]
local function calculate_percentage(start_time, end_time)
   if not start_time or not end_time then
      return 0
   end
   local time_since_start = (ni.client.get_time() * 1000 - start_time) / 1000
   local time = end_time - start_time - ni.client.latency()
   return time_since_start / time * 100000
end

--[[--
Gets the targets casting percentage completed
 
Parameters:
- **target** `string`
 
Returns:
- **percent_complete** `number`
@param target string
]]
function ni.unit.casting_percent(target)
   local _, _, _, _, start_time, end_time = ni.unit.casting(target)
   return calculate_percentage(start_time, end_time)
end

--[[--
Gets the channel information for the specified target
 
Parameters:
- **target** `string`
 
Returns:
- **...**
 
Notes:
See the returns for UnitChannelInfo
@param target string
]]
function ni.unit.channel(target)
   return UnitChannelInfo(target)
end

--[[--
Gets if the target is channeling currently
 
Parameters:
- **target**
 
Returns:
- **channeling** `boolean`
@param target string
]]
function ni.unit.is_channeling(target)
   return ni.unit.channel(target) and true or false
end

--[[--
Gets the targets channel percentage completed
 
Parameters:
- **target** `string`
 
Returns:
- **percent_complete** `number`
@param target string
]]
function ni.unit.channel_percent(target)
   local _, _, _, _, start_time, end_time = ni.unit.channel(target)
   return calculate_percentage(start_time, end_time)
end

--[[--
Gets if the target is dead or a ghost
 
Parameters:
- **target** `string`
 
Returns:
- **is_dead_or_ghost** `boolean`
@param target string
]]
function ni.unit.is_dead_or_ghost(target)
   return UnitIsDeadOrGhost(target)
end

--[[--
Checks to see if target_a can attack target_b
 
Parameters:
- **target_a** `string`
- **target_b** `string`
 
Returns:
- **unit_can_attack** `boolean`
@param target_a string
@param target_b string
]]
function ni.unit.can_attack(target_a, target_b)
   return UnitCanAttack(target_a, target_b)
end

--[[--
Checks to see if target_a can assist target_b
 
Parameters:
- **target_a** `string`
- **target_b** `string`
 
Returns:
- **unit_can_attack** `boolean`
@param target_a string
@param target_b string
]]
function ni.unit.can_assist(target_a, target_b)
   return UnitCanAssist(target_a, target_b)
end

--[[--
Gets the current power value for a unit
 
Parmeters:
- **target** `string`
- **power_type** `string or number`
 
Returns:
- **current**
@param target string
@param[opt] power_type
]]
function ni.unit.power(target, power_type)
   return ni.power.current(target, power_type)
end

--[[--
Gets the max power value for a unit
 
Parameters:
- **target** `string`
- **power_type** `string or number`
 
Returns:
- **max**
@param target string
@param[opt] power_type
]]
function ni.unit.power_max(target, power_type)
   return ni.power.max(target, power_type)
end

--[[--
Gets the power percentage for a unit
 
Parameters:
- **target** `string`
- **power_type** `string or number`
 
Returns:
- **percent**
@param target string
@param[opt] power_type
]]
function ni.unit.power_percent(target, power_type)
   return ni.power.percent(target, power_type)
end

--[[--
Gets the power deficit for a unit
 
Parameters:
- **target** `string`
- **power_type** `string or number`
 
Returns:
- **deficit** `number`
@param target
@param[opt] power_type
]]
function ni.unit.power_deficit(target, power_type)
   return ni.power.deficit(target, power_type)
end

local function aura_handler(target, aura, filter, func)
   local aura_name = aura
   if type(aura) == "number" then
      aura_name = ni.spell.info(aura)
   end
   if not filter then
      return func(target, aura_name)
   else
      if strfind(strupper(filter), "EXACT") then
         local caster = strfind(strupper(filter), "PLAYER")
         local i = 1
         local name, _, _, _, _, _, _, aura_caster, _, _, aura_id = func(t, i)
         while name do
            if not caster or aura_caster == "player" then
               if aura_id and aura_id == aura then
                  return func(t, i)
               end
            end
            i = i + 1
            name, _, _, _, _, _, _, aura_caster, _, _, aura_id = func(t, i)
         end
      else
         return func(target, aura_name, nil, filter)
      end
   end
end

--[[--
Gets information about the buff on a unit
 
Parameters:
- **target** `string`
- **buff** `number or string`
- **filter** `string`
 
Returns:
- **...**
 
Notes:
See the returns for UnitBuff as this is a wrapper for that.
@param target string
@param buff
@param[opt] filter
]]
function ni.unit.buff(target, buff, filter)
   return aura_handler(target, buff, filter, UnitBuff)
end

--[[--
Get unit buff remaining 
 
Parameters:
- **target** `string`
- **buff** `number or string`
- **filter** `string`
 
Returns:
- **buff_remaining** `number`
@param target string
@param buff
@param[opt] filter string
]]
function ni.unit.buff_remaining(target, buff, filter)
  	local expires = select(7, ni.unit.buff(target, buff, filter))
	if expires then
		return expires - ni.client.get_time() 
	else
		return 0
	end
end

--[[--
Get unit buff stacks 
 
Parameters:
- **target** `string`
- **buff** `number or string`
- **filter** `string`
 
Returns:
- **buff_stacks** `number`
@param target string
@param buff
@param[opt] filter string
]]
function ni.unit.buff_stacks(target, buff, filter)
  	local stacks = select(4, ni.unit.buff(target, buff, filter))
	if stacks then
		return stacks
	else
		return 0
	end
end

--[[--
Gets information about the debuff on a unit
 
Parameters:
- **target** `string`
- **debuff** `number or string`
- **filter** `string`
 
Returns:
- **...**
 
Notes:
See the returns for UnitDebuff as this is a wrapper for that.
@param target string
@param debuff
@param[opt] filter
]]
function ni.unit.debuff(target, debuff, filter)
   return aura_handler(target, debuff, filter, UnitDebuff)
end

--[[--
Get unit debuff remaining 
 
Parameters:
- **target** `string`
- **debuff** `number or string`
- **filter** `string`
 
Returns:
- **debuff_remaining** `number`
@param target string
@param debuff
@param[opt] filter string
]]
function ni.unit.debuff_remaining(target, debuff, filter)
   local expires = select(7, ni.unit.debuff(target, debuff, filter))
	if expires then
		return expires - ni.client.get_time()
	else
		return 0
	end
end

--[[--
Get unit debuff stacks 
 
Parameters:
- **target** `string`
- **debuff** `number or string`
- **filter** `string`
 
Returns:
- **buff_stacks** `number`
@param target string
@param debuff
@param[opt] filter string
]]
function ni.unit.debuff_stacks(target, debuff, filter)
   local stacks = select(4, ni.unit.debuff(target, debuff, filter))
	if stacks then
		return stacks
	else
		return 0
	end
end

--[[--
Gets information about the buff on a unit by specific buff index.
 
Parameters:
- **target** `string`
- **index** `number`
 
Returns:
- **...**
 
Notes:
See the returns for UnitBuff as this is a wrapper for that.
@param target string
@param index number
]]
function ni.unit.index_buff(target, index)
   return UnitBuff(target, index)
end

--[[--
Gets information about the debuff on a unit by specific debuff index
 
Parameters:
- **target** `string`
- **index** `number`
 
Returns:
- **...**
 
Notes:
See the returns for UnitDebuff as this is a wrapper for that.
@param target string
@param index number
]]
function ni.unit.index_debuff(target, index)
   return UnitDebuff(target, index)
end

--[[--
Gets a table of buffs on a target
 
Parameters:
- **target** `string`
 
Returns:
- **buffs** `table`
 
Notes:
See the returns for UnitBuff as this is a wrapper for that.
@param target string
]]
function ni.unit.buffs(target)
   local buffs, i = {}, 1
   local name, rank, icon, count, buffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = ni.unit.index_buff(target, i)
   while name do
      buffs[i] = {name, rank, icon, count, buffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId}
      i = i + 1;
      name, rank, icon, count, buffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = ni.unit.index_buff(target, i)
   end
   return buffs
end

--[[--
Gets a table of buffs on a target
 
Parameters:
- **target** `string`
 
Returns:
- **buffs** `table`
 
Notes:
See the returns for UnitBuff as this is a wrapper for that.
@param target string
]]
function ni.unit.debuffs(target)
   local buffs, i = {}, 1
   local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = ni.unit.index_debuff(target, i)
   while name do
      buffs[i] = {name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId}
      i = i + 1;
      name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = ni.unit.index_debuff(target, i)
   end
   return buffs
end

--[[--
Table keys:
- **guid** `string`
- **type** `number`
- **name** `string`
- **distance** `number`
@table in_range
]]


--[[--
@local
Helper function to avoid typing things multiple times, and helps understand they do similiar things
 
Parameters:
- **target** `string`
- **distance** `number`
- **func** `function`
 
Returns:
- **in_range** `table`
@param target string
@param distance number
@param func function
]]
local function in_range_helper(target, distance, func)
   local in_range = {}
   target = ni.unit.guid(target) or target
   if not target then
      return in_range
   end
   for k, v in ni.table.opairs(ni.objects) do
      if k ~= target and (v.type == 3 or v.type == 4) and func(k) and not ni.unit.is_dead_or_ghost(k) then
         local d = ni.unit.distance_3d(target, k)
         if d and d < distance then
            in_range[k] = {
               guid = k,
               type = v.type,
               name = v.name,
               distance = d,
            }
         end
      end
   end
   return in_range
end

--[[--
Gets a table of enemy units of a target within the given range
 
Parameters:
- **target** `string`
- **distance** `number`
 
Returns:
- **in_range** `table`
@param target string
@param distance number
]]
function ni.unit.enemies_in_range(target, distance)
   return in_range_helper(target, distance, ni.player.can_attack)
end

--[[--
Gets a table of friendly units of a target within the given range
 
Parameters:
- **target** `string`
- **distance** `number`
 
Returns:
- **in_range** `table`
@param target string
@param distance number
]]
function ni.unit.friends_in_range(target, distance)
   return in_range_helper(target, distance, ni.player.can_assist)
end

--[[
Check if a unit cast can be interupted by the player
 
Parameters:
- **target** `string`
- **interupt_percent** `number`
 
Returns:
- **can_interupt** `boolean`
- **interruptable_spell** `string`
@param target string
@param interupt_percent number
]]
function ni.unit.can_interupt(target, interupt_percent)
   if not ni.player.can_attack(target) then
      return false, nil
   end
   local cast_name, _, _, _, cast_start, cast_end, _, _, cast_not_interruptable = ni.unit.casting(target)
	local channel_name, _, _, _, channel_start, channel_end, _, channel_not_interruptable = ni.unit.channel(target)
   if cast_name ~= nil and not cast_not_interruptable then
      local completed_percent = calculate_percentage(cast_start, cast_end)
      if completed_percent > interupt_percent then
         return true, cast_name
      end
      return false, cast_name
   end
   if channel_name ~= nil and not channel_not_interruptable then
      local completed_percent = calculate_percentage(channel_start, channel_end)
      if completed_percent > interupt_percent then
         return true, channel_name
      end
      return false, channel_name
   end
   return false, nil
end

--[[
Check if a unit cast is not interruptable
 
Parameters:
- **target** `string`
 
Returns:
- **not_interruptable** `boolean`
@param target string
]]
function ni.unit.cast_not_interruptable(target)
   local cast_name, _, _, _, _, _, _, _, cast_not_interruptable = ni.unit.casting(target)
	local channel_name, _, _, _, _, _, _, channel_not_interruptable = ni.unit.channel(target)
   if cast_name ~= nil and cast_not_interruptable then
      return true
   end
   if channel_name ~= nil and channel_not_interruptable then
      return true
   end
   return false
end