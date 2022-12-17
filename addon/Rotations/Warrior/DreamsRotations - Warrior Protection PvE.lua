--------------------------------
-- DreamsRotation - Warrior Protection PvE
-- Version - 1.0.0
-- Author - Dreams
--------------------------------
-- Changelog
-- 1.0.0 Initial release
--------------------------------
local ni = ...

local items = {
    settingsfile = "DreamsRotations - Warrior Protection PvE.json",
    {
        type = "title",
        text = "|cff00ccffDreamsRotations |cffffffff- Warrior Protection PvE - |cff888888v1.0.0",
    },
    {
        type = "separator",
    },
    {
        type = "title",
        text = "|cff00ccffMain Settings",
    },
    {
        type = "separator",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(2764)) .. ":26:26\124t Auto Target",
        tooltip = "Auto Target the closest enemy around you",
        enabled = true,
        key = "autotarget",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(674)) .. ":26:26\124t Auto Attack",
        tooltip = "Auto Attack the target",
        enabled = true,
        key = "autoattack",
    },
    {
        type = "separator",
    },
    {
        type = "title",
        text = "|cff00ccffRotation Settings",
    },
    {
        type = "separator",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(47440)) .. ":26:26\124t Commanding Shout",
        tooltip = "Cast Commanding Shout",
        enabled = true,
        key = "commandingshout",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(57823)) .. ":26:26\124t Revenge",
        tooltip = "Cast Revenge",
        enabled = true,
        key = "revenge",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(47488)) .. ":26:26\124t Shield Slam",
        tooltip = "Cast Shield Slam",
        enabled = true,
        key = "shieldslam",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(47465)) .. ":26:26\124t Rend",
        tooltip = "Cast Rend",
        enabled = true,
        key = "rend",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(47498)) .. ":26:26\124t Devastate",
        tooltip = "Cast Devastate",
        enabled = true,
        key = "devastate",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(72)) .. ":26:26\124t Shield Bash",
        tooltip = "Cast Shield Bash if target casting a spell",
        enabled = true,
        key = "shieldbash",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(57755)) .. ":26:26\124t Heroic Throw",
        tooltip = "Cast Heroic Throw",
        enabled = true,
        key = "heroicthrow",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(47502)) .. ":26:26\124t Thunder Clap",
        tooltip = "Cast Thunder Clap",
        enabled = true,
        key = "thunderclap",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(47450)) .. ":26:26\124t Heroic Strike when you have %RAGE or more",
        tooltip = "Cast Heroic Strike if have rage percentage or more",
        enabled = true,
        value = 60,
        key = "heroicstrike",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(46968)) .. ":26:26\124t Shockwave if the amount or more enemies are in range",
        tooltip = "Cast Shockwave if the amount or more enemies are in range",
        enabled = true,
        value = 2,
        key = "shockwave",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(47520)) .. ":26:26\124t Cleave when you have %RAGE or more",
        tooltip = "Cast Cleave if more than 1 enemies are in range and if you have rage percentage or more",
        enabled = true,
        value = 40,
        key = "cleave",
    },
    {
        type = "separator",
    },
    {
        type = "title",
        text = "|cff00ccffCooldown Settings",
    },
    {
        type = "separator",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(12975)) .. ":26:26\124t Last Stand when you have HP% or less",
        tooltip = "Cast Last Stand if have health % or less",
        enabled = true,
        value = 60,
        key = "laststand",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(2565)) .. ":26:26\124t Shield Block when you have HP% or less",
        tooltip = "Cast Shield Block if have health percentage or less",
        enabled = true,
        value = 90,
        key = "shieldblock",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(871)) .. ":26:26\124t Shield Wall when you have HP% or less",
        tooltip = "Cast Shield Wall if you have health percentage or less",
        enabled = true,
        value = 40,
        key = "shieldwall",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(55694)) .. ":26:26\124t Enraged Regeneration when you have HP% or less",
        tooltip = "Cast Enraged Regeneration if you have health percentage or less",
        enabled = true,
        value = 60,
        key = "enragedregeneration",
    },
}

local function GetSetting(name)
    for k, v in ipairs(items) do
        if v.type == "entry"
        and v.key ~= nil
        and v.key == name then
            return v.value, v.enabled
        end
    end
end

local function onload()
    ni.GUI.AddFrame("DreamsRotations - Warrior Protection PvE", items);
end

local function onunload()
    ni.GUI.DestroyFrame("DreamsRotations - Warrior Protection PvE");
end

local spell = {
    autoattack = GetSpellInfo(6603),
    revenge = GetSpellInfo(57823),
    shieldslam = GetSpellInfo(47488),
    shieldblock = GetSpellInfo(2565),
    shieldbash = GetSpellInfo(72),
    rend = GetSpellInfo(47465),
    cleave = GetSpellInfo(47520),
    devastate = GetSpellInfo(47498),
    heroicstrike = GetSpellInfo(47450),
    heroicthrow = GetSpellInfo(57755),
    thunderclap = GetSpellInfo(47502),
    shieldwall = GetSpellInfo(871),
    laststand = GetSpellInfo(12975),
    shockwave = GetSpellInfo(46968),
    commandingshout = GetSpellInfo(47440),
    enragedregeneration = GetSpellInfo(55694),
}

local item = {
    food = GetSpellInfo(45548),
    drink = GetSpellInfo(57073),
}

local queue = {
    "Pause Rotation",
    "Commanding Shout",
    "Auto Target",
    "Auto Attack",
    "Enraged Regeneration",
    "Shield Wall",
    "Last Stand",
    "Shield Block",
    "Shield Bash",
    "Cleave",
    "Heroic Strike",
    "Shield Slam",
    "Thunder Clap",
    "Shockwave",
    "Rend",
    "Revenge",
    "Devastate",
    "Heroic Throw",
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
        local _, enabled = GetSetting("autotarget")
        if enabled then
            if UnitAffectingCombat("player")
            and ((ni.unit.exists("target")
            and UnitIsDeadOrGhost("target")
            and not UnitCanAttack("player", "target"))
            or not ni.unit.exists("target")) then
                ni.player.runtext("/targetenemy")
                return true;
            end
        end
	end,

    ["Auto Attack"] = function()
        local _, enabled = GetSetting("autoattack")
        if enabled then
            if ni.unit.exists("target")
            and UnitCanAttack("player", "target")
            and not UnitIsDeadOrGhost("target")
            and UnitAffectingCombat("player")
            and not IsCurrentSpell(spell.autoattack) then
                ni.spell.cast(spell.autoattack)
                return true;
            end
        end
    end,

    ["Commanding Shout"] = function()
        local _, enabled = GetSetting("commandingshout")
        if enabled then
            if ni.spell.available(spell.commandingshout)
            and not ni.unit.buff("player", spell.commandingshout) then
                ni.spell.cast(spell.commandingshout)
                return true;
            end
        end
    end,

    ["Revenge"] = function()
        local _, enabled = GetSetting("revenge")
        if enabled then
            if ni.spell.available(spell.revenge)
            and ni.spell.valid("target", spell.revenge, true, true)
            and IsUsableSpell(spell.revenge) then
                ni.spell.cast(spell.revenge, "target")
                return true;
            end
        end
    end,

    ["Shield Slam"] = function()
        local _, enabled = GetSetting("shieldslam")
        if enabled then
            if ni.spell.available(spell.shieldslam)
            and ni.spell.valid("target", spell.shieldslam, true, true) then
                ni.spell.cast(spell.shieldslam, "target")
                return true;
            end
        end
    end,

    ["Rend"] = function()
        local _, enabled = GetSetting("rend")
        if enabled then
            if ni.spell.available(spell.rend)
            and ni.unit.isboss("target")
            and ni.spell.valid("target", spell.rend, true, true)
            and not ni.unit.debuff("target", spell.rend, "player") then
                ni.spell.cast(spell.rend, "target")
                return true;
            end
        end
    end,

    ["Shield Block"] = function()
        local value, enabled = GetSetting("shieldblock")
        if enabled then
            if ni.spell.available(spell.shieldblock)
            and ni.unit.hp("player") < value then
                ni.spell.cast(spell.shieldblock)
                return true;
            end
        end
    end,

    ["Shield Wall"] = function()
        local value, enabled = GetSetting("shieldwall")
        if enabled then
            if ni.spell.available(spell.shieldwall)
            and ni.unit.hp("player") < value then
                ni.spell.cast(spell.shieldwall)
                return true;
            end
        end
    end,

    ["Enraged Regeneration"] = function()
        local value, enabled = GetSetting("enragedregeneration")
        if enabled then
            if ni.spell.available(spell.enragedregeneration)
            and ni.unit.hp("player") < value then
                ni.spell.cast(spell.enragedregeneration)
                return true;
            end
        end
    end,

    ["Last Stand"] = function()
        local value, enabled = GetSetting("laststand")
        if enabled then
            if ni.spell.available(spell.laststand)
            and ni.unit.hp("player") < value then
                ni.spell.cast(spell.laststand)
                return true;
            end
        end
    end,

    ["Shield Bash"] = function()
        local _, enabled = GetSetting("shieldbash")
        if enabled then
            if ni.spell.available(spell.shieldbash)
            and ni.spell.valid("target", spell.shieldbash, true, true)
            and ni.unit.iscasting("target")
            or ni.unit.ischanneling("target") then
                ni.spell.cast(spell.shieldbash, "target")
                return true;
            end
        end
    end,

    ["Cleave"] = function()
        local value, enabled = GetSetting("cleave")
        if enabled then
            if ni.spell.available(spell.cleave)
            and ni.spell.valid("target", spell.cleave, true, true)
            and #ni.unit.enemiesinrange("target", 10) > 1
            and not IsCurrentSpell(spell.cleave)
            and ni.player.power() > value then
                ni.spell.cast(spell.cleave)
                return true;
            end
        end
    end,

    ["Devastate"] = function()
        local _, enabled = GetSetting("devastate")
        if enabled then
            if ni.spell.available(spell.devastate)
            and ni.spell.valid("target", spell.devastate, true, true) then
                ni.spell.cast(spell.devastate, "target")
                return true;
            end
        end
    end,

    ["Heroic Strike"] = function()
        local value, enabled = GetSetting("heroicstrike")
        if enabled then
            if ni.spell.available(spell.heroicstrike)
            and ni.spell.valid("target", spell.heroicstrike, true, true)
            and not IsCurrentSpell(spell.heroicstrike)
            and ni.player.power() > value
            and #ni.unit.enemiesinrange("target", 10) < 2 then
                ni.spell.cast(spell.heroicstrike)
                return true;
            end
        end
    end,

    ["Heroic Throw"] = function()
        local _, enabled = GetSetting("heroicthrow")
        if enabled then
            if ni.spell.available(spell.heroicthrow)
            and ni.spell.valid("target", spell.heroicthrow, true, true) then
                ni.spell.cast(spell.heroicthrow, "target")
                return true;
            end
        end
    end,

    ["Thunder Clap"] = function()
        local _, enabled = GetSetting("thunderclap")
        if enabled then
            if ni.spell.available(spell.thunderclap)
            and ni.unit.inmelee("player", "target")then
                ni.spell.cast(spell.thunderclap)
                return true;
            end
        end
    end,

    ["Shockwave"] = function()
        local value, enabled = GetSetting("shockwave")
        if enabled then
            if ni.spell.available(spell.shockwave)
            and ni.unit.inmelee("player", "target")
            and #ni.unit.enemiesinrange("target", 10) >= value then
                ni.spell.cast(spell.shockwave)
                return true;
            end
        end
    end,
}
ni.bootstrap.profile("DreamsRotations - Warrior Protection PvE", queue, abilities, onload, onunload)