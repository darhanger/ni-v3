--------------------------------
-- DreamsRotations - Druid Restoration PvE
-- Version - 1.0.1
-- Author - Dreams
--------------------------------
-- Changelog
-- 1.0.0 Initial release
-- 1.0.1 Adjust Mana Cooldown and Mana Potion
--------------------------------
local ni = ...

local items = {
    settingsfile = "DreamsRotations - Druid Restoration PvE.json",
    {
        type = "entry",
        text = "|cff00ccffDreamsRotations |cffffffff- Druid Restoration PvE - |cff888888v1.0.1",
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
        text = "\124T" .. select(3, GetSpellInfo(33891)) .. ":26:26\124t Tree of Life",
        tooltip = "Cast Tree of Life",
        enabled = true,
        key = "treeoflife",
    },
    {
        type = "entry",
        text = "\124T" .. GetItemIcon(33448) .. ":26:26\124t Runic Mana Potion if you are MP% or less",
        tooltip = "Use Runic Mana Potion if you at or below mana percentage",
        enabled = true,
        value = 10,
        key = "runicmanapotion",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(29166)) .. ":26:26\124t Innervate if you are %MP or less",
        tooltip = "Cast Innervate if you at or below mana percentage",
        enabled = true,
        value = 60,
        key = "innervate",
    },
    {
        type = "entry",
        text = "\124T" .. GetItemIcon(54589) .. ":26:26\124t Glowing Twilight Scale if 4 or more allys are HP% or less",
        tooltip = "Use Glowing Twilight Scale if 4 or more allys are HP% or less",
        enabled = true,
        value = 60,
        key = "glowingtwilightscale",
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
        text = "\124T" .. select(3, GetSpellInfo(53251)) .. ":26:26\124t Wild Growth if you or ally are HP% or less",
        tooltip = "Cast Wild Growth if you or ally are at or below health percentage",
        enabled = true,
        value = 90,
        key = "wildgrowth",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(18562)) .. ":26:26\124t Swiftmend if you or ally are HP% or less",
        tooltip = "Cast Swiftmend if you or ally are at or below health percentage",
        enabled = true,
        value = 60,
        key = "swiftmend",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(50464)) .. ":26:26\124t Nourish if you or ally are HP% or less",
        tooltip = "Cast Nourish if you or ally are at or below health percentage",
        enabled = true,
        value = 60,
        key = "nourish",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(48441)) .. ":26:26\124t Rejuvenation if you or ally are HP% or less (Low HP)",
        tooltip = "Cast Rejuvenation if you or ally are at or below health percentage",
        enabled = true,
        value = 80,
        key = "rejuvenationlowhp",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(48441)) .. ":26:26\124t Rejuvenation (Raid)",
        tooltip = "Cast Rejuvenation on all raid member",
        enabled = true,
        key = "rejuvenationraid",
    },
    {
        type = "separator",
    },
    {
        type = "title",
        text = "|cff00ccffTank Settings (High Priority)",
    },
    {
        type = "separator",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(48441)) .. ":26:26\124t Rejuvenation",
        tooltip = "Cast Rejuvenation on tank",
        enabled = true,
        key = "rejuvenationtank",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(48451)) .. ":26:26\124t Lifebloom",
        tooltip = "Cast Lifebloom on tank, only cast when you have clearcasting buff",
        enabled = true,
        key = "lifebloomtank",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(48443)) .. ":26:26\124t Regrowth",
        tooltip = "Cast Regrowth and keeps buff active on tank",
        enabled = true,
        key = "regrowthtank",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(18562)) .. ":26:26\124t Swiftmend if Tank is HP% or less",
        tooltip = "Cast Swiftmend if tank is at or below health percentage",
        enabled = true,
        value = 60,
        key = "swiftmendtank",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(50464)) .. ":26:26\124t Nourish if Tank is HP% or less",
        tooltip = "Cast Nourish if tank is at or below health percentage",
        enabled = true,
        value = 80,
        key = "nourishtank",
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
    ni.GUI.AddFrame("DreamsRotations - Druid Restoration PvE", items);
end

local function onunload()
    ni.GUI.DestroyFrame("DreamsRotations - Druid Restoration PvE");
end

local spell = {
    treeoflife = GetSpellInfo(33891),
    regrowth = GetSpellInfo(48443),
    nourish = GetSpellInfo(50464),
    rejuvenation = GetSpellInfo(48441),
    lifebloom = GetSpellInfo(48451),
    wildgrowth = GetSpellInfo(53251),
    innervate = GetSpellInfo(29166),
    clearcasting = GetSpellInfo(16870),
    swiftmend = GetSpellInfo(18562),
}

local item = {
    food = GetSpellInfo(45548),
    drink = GetSpellInfo(57073),
    runicmanapotion = GetItemInfo(33448),
}

local queue = {
    "Tree of Life",
    "Pause Rotation",
    "Innervate",
    "Runic Mana Potion",
    "Glowing Twilight Scale",
    "Swiftmend (Tank)",
    "Swiftmend",
    "Lifebloom (Tank)",
    "Wild Growth",
    "Rejuvenation (Tank)",
    "Nourish (Tank)",
    "Nourish",
    "Rejuvenation (Low HP)",
    "Regrowth (Tank)",
    "Rejuvenation (Raid)",
}

local abilities = {
    ["Pause Rotation"] = function()
        if IsMounted()
        or UnitIsDeadOrGhost("player")
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

    ["Tree of Life"] = function()
        local _, enabled = GetSetting("treeoflife")
        if enabled then
            if ni.spell.available(spell.treeoflife)
            and not ni.unit.buff("player", spell.treeoflife) then
                ni.spell.cast(spell.treeoflife)
                return true;
            end
        end
    end,

    ["Runic Mana Potion"] = function()
        local value, enabled = GetSetting("runicmanapotion")
        if enabled then
            if ni.player.itemcd(item.runicmanapotion) == 0
            and ni.player.power() < value
            and ni.player.hasitem(item.runicmanapotion) then
                ni.player.useitem(item.runicmanapotion)
                return true;
            end
        end
    end,

    ["Glowing Twilight Scale"] = function()
        local value, enabled = GetSetting("glowingtwilightscale")
        if enabled then
            local count = ni.members.below(value);
            if count >= 4
            and ni.player.hasitemequipped(54589)
            and ni.player.itemcd(54589) == 0 then
                ni.player.useitem(54589)
                return true;
            end
        end
    end,

    ["Innervate"] = function()
        local value, enabled = GetSetting("innervate")
        if enabled then
            if ni.spell.available(spell.innervate)
            and ni.player.power() < value then
                ni.spell.cast(spell.innervate, "player")
                return true;
            end
        end
    end,

    ["Swiftmend"] = function()
        local value, enabled = GetSetting("swiftmend")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].hp <= value
                and ni.spell.available(spell.swiftmend)
                and ni.spell.valid(ni.members[i].unit, spell.swiftmend, false, true, true)
                and ni.unit.buff(ni.members[i].unit, spell.rejuvenation, "player") then
                    ni.spell.cast(spell.swiftmend, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,

    ["Swiftmend (Tank)"] = function()
        local value, enabled = GetSetting("swiftmendtank")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].istank
                and ni.members[i].hp < value
                and ni.spell.available(spell.swiftmend)
                and ni.spell.valid(ni.members[i].unit, spell.swiftmend, false, true, true)
                and ni.unit.buff(ni.members[i].unit, spell.rejuvenation, "player") then
                    ni.spell.cast(spell.swiftmend, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,

    ["Lifebloom (Tank)"] = function()
        local _, enabled = GetSetting("lifebloomtank")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].istank
                and ni.spell.available(spell.lifebloom)
                and ni.spell.valid(ni.members[i].unit, spell.lifebloom, false, true, true)
                and ni.unit.buff("player", spell.clearcasting)
                and ni.unit.buffstacks(ni.members[i].unit, spell.lifebloom) <= 3 then
                    ni.spell.cast(spell.lifebloom, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,

    ["Wild Growth"] = function()
        local value, enabled = GetSetting("wildgrowth")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].hp < value
                and ni.spell.available(spell.wildgrowth)
                and ni.spell.valid(ni.members[i].unit, spell.wildgrowth, false, true, true) then
                    ni.spell.cast(spell.wildgrowth, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,

    ["Nourish"] = function()
        local value, enabled = GetSetting("nourish")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].hp < value
                and ni.spell.available(spell.nourish)
                and ni.spell.valid(ni.members[i].unit, spell.nourish, false, true, true)
                and not ni.unit.ismoving("player") then
                    ni.spell.cast(spell.nourish, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,

    ["Nourish (Tank)"] = function()
        local value, enabled = GetSetting("nourishtank")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].istank
                and ni.members[i].hp < value
                and ni.spell.available(spell.nourish)
                and ni.spell.valid(ni.members[i].unit, spell.nourish, false, true, true)
                and not ni.unit.ismoving("player") then
                    ni.spell.cast(spell.nourish, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,

    ["Regrowth (Tank)"] = function()
        local _, enabled = GetSetting("regrowthtank")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].istank
                and ni.spell.available(spell.regrowth)
                and ni.spell.valid(ni.members[i].unit, spell.regrowth, false, true, true)
                and not ni.unit.buff(ni.members[i].unit, spell.regrowth, "player")
                and not ni.unit.ismoving("player") then
                    ni.spell.delaycast(spell.regrowth, ni.members[i].unit, 2.0)
                    return true;
                end
            end
        end
    end,

    ["Rejuvenation (Tank)"] = function()
        local _, enabled = GetSetting("rejuvenationtank")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].istank
                and not ni.unit.buff(ni.members[i].unit, spell.rejuvenation, "player")
                and ni.spell.available(spell.rejuvenation)
                and ni.spell.valid(ni.members[i].unit, spell.rejuvenation, false, true, true) then
                    ni.spell.cast(spell.rejuvenation, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,

    ["Rejuvenation (Low HP)"] = function()
        local value, enabled = GetSetting("rejuvenationlowhp")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].hp < value
                and not ni.unit.buff(ni.members[i].unit, spell.rejuvenation, "player")
                and ni.spell.available(spell.rejuvenation)
                and ni.spell.valid(ni.members[i].unit, spell.rejuvenation, false, true, true) then
                    ni.spell.cast(spell.rejuvenation, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,

    ["Rejuvenation (Raid)"] = function()
        local _, enabled = GetSetting("rejuvenationraid")
        if enabled then
            for i = 1, #ni.members do
                if not ni.unit.buff(ni.members[i].unit, spell.rejuvenation, "player")
                and ni.spell.available(spell.rejuvenation)
                and ni.spell.valid(ni.members[i].unit, spell.rejuvenation, false, true, true) then
                    ni.spell.cast(spell.rejuvenation, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,
}
ni.bootstrap.profile("DreamsRotations - Druid Restoration PvE", queue, abilities, onload, onunload)
