--------------------------------
-- DreamsRotations - Shaman Restoration PvE
-- Version - 1.0.5
-- Author - Dreams
--------------------------------
-- Changelog
-- 1.0.0 Initial release
-- 1.0.1 Added Glowing Twilight Scale
-- 1.0.2 Added Tank priority
-- 1.0.3 Added Auto Totems
-- 1.0.4 Added Runic Mana Potion
-- 1.0.5 Adjust Mana Cooldown and Mana Potion
--------------------------------
local ni = ...

local items = {
    settingsfile = "DreamsRotations - Shaman Restoration PvE.json",
    {
        type = "entry",
        text = "|cff00ccffDreamsRotations |cffffffff- Shaman Restoration PvE - |cff888888v1.0.5",
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
        text = "\124T" .. select(3, GetSpellInfo(57960)) .. ":26:26\124t Water Shield",
        tooltip = "Cast Water Shield",
        enabled = true,
        key = "watershield",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(51994)) .. ":26:26\124t Earthliving Weapon",
        tooltip = "Cast Earthliving Weapon",
        enabled = true,
        key = "earthlivingweapon",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(66842)) .. ":26:26\124t Call of the Elements",
        tooltip = "Cast Call of the Elements if you have no Totems, be sure you have Wrath of Air Totem selected in Call of the Elements",
        enabled = true,
        key = "calloftheelements",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(16190)) .. ":26:26\124t Mana Tide Totem if you are MP% or less",
        tooltip = "Cast Mana Tide Totem if you at or below mana percentage",
        enabled = true,
        value = 60,
        key = "manatidetotem",
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
        text = "\124T" .. select(3, GetSpellInfo(49276)) .. ":26:26\124t Lesser Healing Wave if you or ally are HP% or less",
        tooltip = "Cast Lesser Healing Wave if you or ally is at or below health percentage",
        enabled = true,
        value = 80,
        key = "lesserhealingwave",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(49273)) .. ":26:26\124t Healing Wave if you or ally are HP% or less",
        tooltip = "Cast Healing Wave if you or ally is at or below health percentage",
        enabled = true,
        value = 60,
        key = "healingwave",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(61301)) .. ":26:26\124t Riptide if you or ally are HP% or less",
        tooltip = "Cast Riptide if you or ally is at or below health percentage",
        enabled = true,
        value = 80,
        key = "riptide",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(55459)) .. ":26:26\124t Chain Heal if 3 or more allys are HP% or less",
        tooltip = "Cast Chain Heal if 3 or more allys are at or below health percentage",
        enabled = true,
        value = 90,
        key = "chainheal",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(16188)) .. ":26:26\124t Nature's Swiftness if you or ally are HP% or less",
        tooltip = "Cast Nature's Swiftness if you or ally is at or below health percentage",
        enabled = true,
        value = 40,
        key = "naturesswiftness",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(55198)) .. ":26:26\124t Tidal Force if 4 or more allys are HP% or less",
        tooltip = "Cast Tidal Force if 4 or more allys are at or below health percentage",
        enabled = true,
        value = 60,
        key = "tidalforce",
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
        text = "\124T" .. select(3, GetSpellInfo(49276)) .. ":26:26\124t Lesser Healing Wave if Tank is at HP% or less",
        tooltip = "Cast Lesser Healing Wave if Tank is at or below health percentage",
        enabled = true,
        value = 80,
        key = "lesserhealingwavetank",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(49273)) .. ":26:26\124t Healing Wave if Tank is at HP% or less",
        tooltip = "Cast Healing Wave if Tank is at or below health percentage",
        enabled = true,
        value = 60,
        key = "healingwavetank",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(49284)) .. ":26:26\124t Earth Shield on Focus",
        tooltip = "Cast Earth Shield on focus, remember too have the main tank as focus target",
        enabled = true,
        key = "earthshield",
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
    ni.GUI.AddFrame("DreamsRotations - Shaman Restoration PvE", items);
end

local function onunload()
    ni.GUI.DestroyFrame("DreamsRotations - Shaman Restoration PvE");
end

local spell = {
    healingwave = GetSpellInfo(49273),
    lesserhealingwave = GetSpellInfo(49276),
    chainheal = GetSpellInfo(55459),
    earthshield = GetSpellInfo(49284),
    manatidetotem = GetSpellInfo(16190),
    riptide = GetSpellInfo(61301),
    watershield = GetSpellInfo(57960),
    naturesswiftness = GetSpellInfo(16188),
    tidalforce = GetSpellInfo(55198),
    earthlivingweapon = GetSpellInfo(51994),
    calloftheelements = GetSpellInfo(66842),
    wrathofairtotem = GetSpellInfo(2895),
}

local item = {
    food = GetSpellInfo(45548),
    drink = GetSpellInfo(57073),
    runicmanapotion = GetItemInfo(33448),
}

local queue = {
    "Earth Shield",
    "Water Shield",
    "Earthliving Weapon",
    "Pause Rotation",
    "Mana Tide Totem",
    "Runic Mana Potion",
    "Call of the Elements",
    "Glowing Twilight Scale",
    "Nature's Swiftness",
    "Tidal Force",
    "Riptide",
    "Healing Wave (Tank)",
    "Chain Heal",
    "Healing Wave",
    "Lesser Healing Wave (Tank)",
    "Lesser Healing Wave",
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

    ["Earthliving Weapon"] = function()
        local _, enabled = GetSetting("earthlivingweapon")
        if enabled then
            local mainhand,_,_,_,_,_ = GetWeaponEnchantInfo()

            if not mainhand
            and ni.spell.available(spell.earthlivingweapon) then
                ni.spell.cast(spell.earthlivingweapon)
                return true;
            end
        end
    end,

    ["Healing Wave (Tank)"] = function()
        local value, enabled = GetSetting("healingwavetank")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].istank
                and ni.members[i].hp < value
                and ni.spell.available(spell.healingwave)
                and ni.spell.valid(ni.members[i].unit, spell.healingwave, false, true, true)
                and not ni.unit.ismoving("player") then
                    ni.spell.cast(spell.healingwave, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,

    ["Lesser Healing Wave"] = function()
        local value, enabled = GetSetting("lesserhealingwave")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].hp < value
                and ni.spell.available(spell.lesserhealingwave)
                and ni.spell.valid(ni.members[i].unit, spell.lesserhealingwave, false, true, true)
                and not ni.unit.ismoving("player") then
                    ni.spell.cast(spell.lesserhealingwave, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,

    ["Lesser Healing Wave (Tank)"] = function()
        local value, enabled = GetSetting("lesserhealingwavetank")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].istank
                and ni.members[i].hp < value
                and ni.spell.available(spell.lesserhealingwave)
                and ni.spell.valid(ni.members[i].unit, spell.lesserhealingwave, false, true, true)
                and not ni.unit.ismoving("player") then
                    ni.spell.cast(spell.lesserhealingwave, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,

    ["Healing Wave"] = function()
        local value, enabled = GetSetting("healingwave")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].hp < value
                and ni.spell.available(spell.healingwave)
                and ni.spell.valid(ni.members[i].unit, spell.healingwave, false, true, true)
                and not ni.unit.ismoving("player") then
                    ni.spell.cast(spell.healingwave, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,

    ["Chain Heal"] = function()
        local value, enabled = GetSetting("chainheal")
        if enabled then
            local count = ni.members.below(value);
            for i = 1, #ni.members do
                if count >= 3
                and ni.spell.available(spell.chainheal)
                and ni.spell.valid(ni.members[i].unit, spell.chainheal, false, true, true)
                and not ni.unit.ismoving("player") then
                    ni.spell.cast(spell.chainheal, ni.members[i].unit)
                    return true;
                end
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

    ["Nature's Swiftness"] = function()
        local value, enabled = GetSetting("naturesswiftness")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].hp < value
                and ni.spell.available(spell.naturesswiftness) then
                    ni.spell.cast(spell.naturesswiftness)
                    return true;
                end
            end
        end
    end,

    ["Tidal Force"] = function()
        local value, enabled = GetSetting("tidalforce")
        if enabled then
            local count = ni.members.below(value);
            if count >= 4
            and ni.spell.available(spell.tidalforce)
            and not ni.unit.ismoving("player") then
                ni.spell.cast(spell.tidalforce)
                return true;
            end
        end
    end,

    ["Earth Shield"] = function()
        local _, enabled = GetSetting("earthshield")
        if enabled then
            if ni.spell.available(spell.earthshield)
            and ni.spell.valid("focus", spell.earthshield, false, true, true)
            and ni.unit.exists("focus")
            and not ni.unit.buff("focus", spell.earthshield, "player") then
                ni.spell.cast(spell.earthshield, "focus")
                return true;
            end
        end
    end,

    ["Mana Tide Totem"] = function()
        local value, enabled = GetSetting("manatidetotem")
        if enabled then
            if ni.spell.available(spell.manatidetotem)
            and ni.player.power() < value then
                ni.spell.cast(spell.manatidetotem)
                return true;
            end
        end
    end,

    ["Riptide"] = function()
        local value, enabled = GetSetting("riptide")
        if enabled then
            for i = 1, #ni.members do
                if ni.members[i].hp < value
                and ni.spell.available(spell.riptide)
                and ni.spell.valid(ni.members[i].unit, spell.riptide, false, true, true) then
                    ni.spell.cast(spell.riptide, ni.members[i].unit)
                    return true;
                end
            end
        end
    end,
}
ni.bootstrap.profile("DreamsRotations - Shaman Restoration PvE", queue, abilities, onload, onunload)
