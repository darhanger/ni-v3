--------------------------------
-- DreamsRotations - Retrubution Paladin Leveling
-- Version - 1.0.0
-- Author - Dreams
--------------------------------
-- Changelog
-- 1.0.0 Initial release
--------------------------------
local ni = ...

local items = {
    settingsfile = "DreamsRotations - Retrubution Paladin Leveling.json",
    {
        type = "title",
        text = "|cff00ccffDreamsRotations |cffffffff- Retrubution Paladin Leveling - |cff888888v1.0.0",
    },
}

local function onload()
    ni.GUI.AddFrame("DreamsRotations - Retrubution Paladin Leveling", items);
end

local function onunload()
    ni.GUI.DestroyFrame("DreamsRotations - Retrubution Paladin Leveling");
end

local item = {
    food = GetSpellInfo(45548),
    drink = GetSpellInfo(57073),
}

local queue = {
    "Retribution Aura",
    "Seal of Righteousness",
    "Blessing of Might",
    "Pause Rotation",
    "Auto Target",
    "Auto Attack",
    "Holy Light",
    "Exorcism",
    "Divine Storm",
    "Judgement of Light",
    "Crusader Strike",
    "Consecration",
}

local abilities = {
    ["Pause Rotation"] = function()
        if IsMounted()
        or UnitIsDeadOrGhost("player")
        or UnitIsDeadOrGhost("target")
        or UnitUsingVehicle("player")
        or UnitInVehicle("player")
        or not UnitAffectingCombat("player")
        or ni.unit.ischanneling("player")
        or ni.unit.iscasting("player")
        or ni.unit.buff("player", item.food)
        or ni.unit.buff("player", item.drink) then
            return true;
        end
    end,

    ["Auto Target"] = function()
        if UnitAffectingCombat("player")
        and ((ni.unit.exists("target")
        and UnitIsDeadOrGhost("target")
        and not UnitCanAttack("player", "target"))
        or not ni.unit.exists("target")) then
            ni.player.runtext("/targetenemy")
            return true;
        end
	end,

    ["Auto Attack"] = function()
        if ni.unit.exists("target")
        and UnitCanAttack("player", "target")
        and not UnitIsDeadOrGhost("target")
        and UnitAffectingCombat("player")
        and not IsCurrentSpell(6603) then
            ni.spell.cast(6603)
            return true;
        end
    end,

    ["Judgement of Light"] = function()
        if ni.spell.available("Judgement of Light") then
            ni.spell.cast("Judgement of Light", "target")
            return true;
        end
    end,

    ["Crusader Strike"] = function()
        if ni.spell.available("Crusader Strike")
        and ni.unit.inmelee("player", "target") then
            ni.spell.cast("Crusader Strike", "target")
            return true;
        end
    end,

    ["Divine Storm"] = function()
        if ni.spell.available("Divine Storm")
        and ni.unit.inmelee("player", "target") then
            ni.spell.cast("Divine Storm", "target")
            return true;
        end
    end,

    ["Consecration"] = function()
        if ni.spell.available("Consecration")
        and ni.unit.inmelee("player", "target")
        and ni.player.power() > 40 then
            ni.spell.cast("Consecration")
            return true;
        end
    end,

    ["Retribution Aura"] = function()
        if ni.spell.available("Retribution Aura")
        and not ni.unit.buff("player", "Retribution Aura") then
            ni.spell.cast("Retribution Aura", "player")
            return true;
        end
    end,

    ["Righteous Fury"] = function()
        if ni.spell.available("Righteous Fury")
        and not ni.unit.buff("player", "Righteous Fury") then
            ni.spell.cast("Righteous Fury", "player")
            return true;
        end
    end,

    ["Seal of Righteousness"] = function()
        if ni.spell.available("Seal of Righteousness")
        and not ni.unit.buff("player", "Seal of Righteousness") then
            ni.spell.cast("Seal of Righteousness", "player")
            return true;
        end
    end,

    ["Blessing of Might"] = function()
        if ni.spell.available("Blessing of Might")
        and not ni.unit.buff("player", "Blessing of Might") then
            ni.spell.cast("Blessing of Might", "player")
            return true;
        end
    end,

    ["Exorcism"] = function()
        if ni.spell.available("Exorcism")
        and ni.unit.buff("player", "The Art of War") then
            ni.spell.cast("Exorcism", "target")
            return true;
        end
    end,

    ["Holy Light"] = function()
        for i = 1, #ni.members do
            if ni.members[i].hp < 40
            and ni.spell.available("Holy Light")
            and ni.spell.valid(ni.members[i].unit, "Holy Light", false, true, true)
            and not ni.unit.ismoving("player") then
                ni.spell.cast("Holy Light", ni.members[i].unit)
                return true;
            end
        end
    end,
}
ni.bootstrap.profile("DreamsRotations - Retrubution Paladin Leveling", queue, abilities, onload, onunload)
