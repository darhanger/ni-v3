--------------------------------
-- DreamsRotations - Shaman Elementar PvE
-- Version - 1.0.0
-- Author - Dreams
--------------------------------
-- Changelog
-- 1.0.0 Initial release
--------------------------------
local ni = ...

local items = {
    settingsfile = "DreamsRotations - Shaman Elementar PvE.json",
    {
        type = "entry",
        text = "|cff00ccffDreamsRotations |cffffffff- Shaman Elementar PvE - |cff888888v1.0.0",
        tooltip = "Note: IF YOU PAYED FOR THAT PROFILE YOU GOT SCAMMED, THEY FREE. Contact me at Discord: Dreams#5270 ",
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
        text = "\124T" .. select(3, GetSpellInfo(57960)) .. ":26:26\124t Water Shield",
        tooltip = "Cast Water Shield",
        enabled = true,
        key = "watershield",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(58790)) .. ":26:26\124t Flametongue Weapon",
        tooltip = "Cast Flametongue Weapon",
        enabled = true,
        key = "flametongueweapon",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(66842)) .. ":26:26\124t Call of the Elements",
        tooltip = "Cast Call of the Elements if you have no Totems, be sure you have Wrath of Air Totem selected in Call of the Elements",
        enabled = true,
        key = "calloftheelements",
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
        text = "\124T" .. select(3, GetSpellInfo(49233)) .. ":26:26\124t Flame Shock",
        tooltip = "Cast Flame Shock",
        enabled = true,
        key = "flameshock",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(60043)) .. ":26:26\124t Lava Burst",
        tooltip = "Cast Lava Burst",
        enabled = true,
        key = "lavaburst",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(49271)) .. ":26:26\124t Chain Lightning",
        tooltip = "Cast Chain Lightning",
        enabled = true,
        key = "chainlightning",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(49238)) .. ":26:26\124t Lightning Bolt",
        tooltip = "Cast Lightning Bolt",
        enabled = true,
        key = "lightningbolt",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(16166)) .. ":26:26\124t Elemental Mastery",
        tooltip = "Cast Elemental Mastery (Boss Only)",
        enabled = true,
        key = "elementalmastery",
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
    ni.GUI.AddFrame("DreamsRotations - Shaman Elementar PvE", items);
end

local function onunload()
    ni.GUI.DestroyFrame("DreamsRotations - Shaman Elementar PvE");
end

local spell = {
    flameshock = GetSpellInfo(49233),
    lavaburst = GetSpellInfo(60043),
    chainlightning = GetSpellInfo(49271),
    lightningbolt = GetSpellInfo(49238),
    elementalmastery = GetSpellInfo(16166),
    calloftheelements = GetSpellInfo(66842),
    wrathofairtotem = GetSpellInfo(2895),
    flametongueweapon = GetSpellInfo(58790),
}

local item = {
    food = GetSpellInfo(45548),
    drink = GetSpellInfo(57073),
}

local queue = {
    "Water Shield",
    "Flametongue Weapon",
    "Pause Rotation",
    "Auto Target",
    "Call of the Elements",
    "Flame Shock",
    "Elemental Mastery",
    "Lava Burst",
    "Chain Lightning",
    "Lightning Bolt",
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

    ["Water Shield"] = function()
        local _, enabled = GetSetting("watershield")
        if enabled then
            if ni.spell.available(spell.watershield)
            and not ni.unit.buff("player", spell.watershield) then
                ni.spell.cast(spell.watershield)
                return true;
            end
        end
    end,

    ["Flametongue Weapon"] = function()
        local _, enabled = GetSetting("flametongueweapon")
        if enabled then
            local mainhand,_,_,_,_,_ = GetWeaponEnchantInfo()

            if not mainhand
            and ni.spell.available(spell.flametongueweapon) then
                ni.spell.cast(spell.flametongueweapon)
                return true;
            end
        end
    end,

    ["Call of the Elements"] = function()
        local _, enabled = GetSetting("calloftheelements")
        if enabled then
            if ni.spell.available(spell.calloftheelements)
            and not ni.unit.buff("player", spell.wrathofairtotem) then
                ni.spell.cast(spell.calloftheelements)
                return true;
            end
        end
    end,

    ["Flame Shock"] = function()
        local _, enabled = GetSetting("flameshock")
        if enabled then
            if ni.spell.available(spell.flameshock)
            and ni.spell.valid("target", spell.flameshock, true, true)
            and not ni.unit.debuff("target", spell.flameshock, "player") then
                ni.spell.cast(spell.flameshock, "target")
                return true;
            end
        end
    end,

    ["Elemental Mastery"] = function()
        local _, enabled = GetSetting("elementalmastery")
        if enabled then
            if ni.spell.available(spell.elementalmastery)
            and ni.unit.isboss("target") then
                ni.spell.cast(spell.elementalmastery)
                return true;
            end
        end
    end,

    ["Lava Burst"] = function()
        local _, enabled = GetSetting("lavaburst")
        if enabled then
            if ni.spell.available(spell.lavaburst)
            and ni.spell.valid("target", spell.lavaburst, true, true) then
                ni.spell.cast(spell.lavaburst, "target")
                return true;
            end
        end
    end,

    ["Lightning Bolt"] = function()
        local _, enabled = GetSetting("lightningbolt")
        if enabled then
            if ni.spell.available(spell.lightningbolt)
            and ni.spell.valid("target", spell.lightningbolt, true, true) then
                ni.spell.cast(spell.lightningbolt, "target")
                return true;
            end
        end
    end,

    ["Chain Lightning"] = function()
        local _, enabled = GetSetting("chainlightning")
        if enabled then
            if ni.spell.available(spell.chainlightning)
            and ni.spell.valid("target", spell.chainlightning, true, true) then
                ni.spell.cast(spell.chainlightning, "target")
                return true;
            end
        end
    end,
}
ni.bootstrap.profile("DreamsRotations - Shaman Elementar PvE", queue, abilities, onload, onunload)
