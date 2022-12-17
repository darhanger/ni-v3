--------------------------------
-- DreamsRotations - Mage Arcane PvE
-- Version - 1.0.4
-- Author - Dreams
--------------------------------
-- Changelog
-- 1.0.0 Initial release
-- 1.0.1 Added Auto Target
-- 1.0.2 Added GUI
-- 1.0.3 Improved overall rotation
-- 1.0.4 Added Racials
--------------------------------
local ni = ...

local items = {
    settingsfile = "DreamsRotations - Mage Arcane PvE.json",
    {
        type = "entry",
        text = "|cff00ccffDreamsRotations |cffffffff- Arcane Mage PvE - |cff888888v1.0.4",
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
        text = "\124T" .. select(3, GetSpellInfo(43046)) .. ":26:26\124t Molten Armor",
        tooltip = "Cast Molten Armor if not active",
        enabled = true,
        key = "moltenarmor",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(43002)) .. ":26:26\124t Arcane Brilliance",
        tooltip = "Cast Arcane Brilliance if not active",
        enabled = true,
        key = "arcanebrilliance",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(42985)) .. ":26:26\124t Conjure Mana Gem",
        tooltip = "Cast Conjure Mana Gem if you have no mana sapphire left",
        enabled = true,
        key = "conjuremanagem",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(42985)) .. ":26:26\124t Mana Sapphire if you have MP% or less",
        tooltip = "Use Mana Sapphire if you at or below mana percentage",
        enabled = true,
        value = 85,
        key = "manasapphire",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(12051)) .. ":26:26\124t Evocation if you have MP% or less",
        tooltip = "Cast Evocation if you at or below mana percentage",
        enabled = true,
        value = 20,
        key = "evocation",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(54758)) .. ":26:26\124t Engineer Glove Enchant (Hyperspeed Accelerators)",
        tooltip = "Cast Engineer Glove Enchant (Boss Only)",
        enabled = true,
        key = "hyperspeedaccelerators",
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
        text = "\124T" .. select(3, GetSpellInfo(42897)) .. ":26:26\124t Arcane Blast",
        tooltip = "Cast Arcane Blast",
        enabled = true,
        key = "arcaneblast",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(12472)) .. ":26:26\124t Icy Veins if at or more Arcane Blast stacks",
        tooltip = "Cast Icy Veins if you at or more Arcane Blast Stacks (Boss Only)",
        enabled = true,
        value = 3,
        key = "icyveins",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(55342)) .. ":26:26\124t Mirror Image if at or more Arcane Blast stacks",
        tooltip = "Cast Mirror Image if you at or more Arcane Blast Stacks (Boss Only)",
        enabled = true,
        value = 3,
        key = "mirrorimage",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(12042)) .. ":26:26\124t Arcane Power if at or more Arcane Blast stacks",
        tooltip = "Cast Arcane Power if you at or more Arcane Blast Stacks (Boss Only)",
        enabled = true,
        value = 3,
        key = "arcanepower",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(12043)) .. ":26:26\124t Presence of Mind if at or more Arcane Blast stacks",
        tooltip = "Cast Presence of Mind if you at or more Arcane Blast Stacks (Boss Only)",
        enabled = true,
        value = 1,
        key = "presenceofmind",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(42846)) .. ":26:26\124t Arcane Missiles if at or more Arcane Blast stacks",
        tooltip = "Cast Arcane Missiles if you at or more Arcane Blast Stacks",
        enabled = true,
        value = 4,
        key = "arcanemissiles",
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
    ni.GUI.AddFrame("DreamsRotations - Mage Arcane PvE", items);
end

local function onunload()
    ni.GUI.DestroyFrame("DreamsRotations - Mage Arcane PvE");
end

local spell = {
    moltenarmor = GetSpellInfo(43046),
    arcanebrilliance = GetSpellInfo(43002),
    conjuremanagem = GetSpellInfo(42985),
    evocation = GetSpellInfo(12051),
    icyveins = GetSpellInfo(12472),
    mirrorimage = GetSpellInfo(55342),
    arcanepower = GetSpellInfo(12042),
    presenceofmind = GetSpellInfo(12043),
    arcanemissiles = GetSpellInfo(42846),
    arcanemissilesbuff = GetSpellInfo(44401),
    arcaneblast = GetSpellInfo(42897),
    arcaneblaststacks = GetSpellInfo(36032),
}

local item = {
    manasapphire = GetItemInfo(33312),
    arcanepowder = GetItemInfo(17020),
    food = GetSpellInfo(45548),
    drink = GetSpellInfo(57073),
}

local queue = {
    "Molten Armor",
    "Arcane Brilliance",
    "Conjure Mana Gem",
    "Pause Rotation",
    "Auto Target",
    "Mana Sapphire",
    "Evocation",
    "Arcane Power",
    "Icy Veins",
    "Mirror Image",
    "Presence of Mind",
    "Hyperspeed Accelerators",
    "Arcane Missiles",
    "Arcane Blast",
}

local abilities = {
    ["Molten Armor"] = function()
        local _, enabled = GetSetting("moltenarmor")
        if enabled then
            if ni.spell.available(spell.moltenarmor)
            and not ni.unit.buff("player", spell.moltenarmor) then
                ni.spell.cast(spell.moltenarmor)
                return true;
            end
        end
    end,

    ["Arcane Brilliance"] = function()
        local _, enabled = GetSetting("arcanebrilliance")
        if enabled then
            if ni.spell.available(spell.arcanebrilliance)
            and not ni.unit.buff("player", spell.arcanebrilliance)
            and ni.player.hasitem(item.arcanepowder) then
                ni.spell.cast(spell.arcanebrilliance)
                return true;
            end
        end
    end,

    ["Conjure Mana Gem"] = function()
        local _, enabled = GetSetting("conjuremanagem")
        if enabled then
            if ni.spell.available(spell.conjuremanagem)
            and not ni.player.hasitem(item.manasapphire)
            and not ni.player.ismoving("player")
            and not UnitAffectingCombat("player") then
                ni.spell.cast(spell.conjuremanagem)
                return true;
            end
        end
    end,

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

    ["Mana Sapphire"] = function()
        local value, enabled = GetSetting("manasapphire")
        if enabled then
            if ni.player.itemcd(item.manasapphire) == 0
            and ni.player.power() < value then
                ni.player.useitem(item.manasapphire)
                return true;
            end
        end
    end,

    ["Evocation"] = function()
        local value, enabled = GetSetting("evocation")
        if enabled then
            if ni.spell.available(spell.evocation)
            and ni.player.power() < value
            and not ni.unit.ismoving("player") then
                ni.spell.cast(spell.evocation)
                return true;
            end
        end
    end,

    ["Hyperspeed Accelerators"] = function()
        local _, enabled = GetSetting("hyperspeedaccelerators")
        if enabled then
            if ni.unit.isboss("target")
            and ni.player.slotcd(10) == 0
            and ni.player.slotcastable(10) then
                ni.player.useinventoryitem(10)
                return true;
            end
        end
    end,

    ["Mirror Image"] = function()
        local value, enabled = GetSetting("mirrorimage")
        if enabled then
            if ni.spell.available(spell.mirrorimage)
            and ni.unit.isboss("target")
            and ni.unit.debuffstacks("player", spell.arcaneblaststacks) >= value then
                ni.spell.cast(spell.mirrorimage)
                return true;
            end
        end
    end,

    ["Icy Veins"] = function()
        local value, enabled = GetSetting("icyveins")
        if enabled then
            if ni.spell.available(spell.icyveins)
            and ni.unit.isboss("target")
            and ni.unit.debuffstacks("player", spell.arcaneblaststacks) >= value then
                ni.spell.cast(spell.icyveins)
                return true;
            end
        end
    end,

    ["Arcane Power"] = function()
        local value, enabled = GetSetting("arcanepower")
        if enabled then
            if ni.spell.available(spell.arcanepower)
            and ni.unit.isboss("target")
            and ni.unit.debuffstacks("player", spell.arcaneblaststacks) >= value then
                ni.spell.cast(spell.arcanepower)
                return true;
            end
        end
    end,

    ["Presence of Mind"] = function()
        local value, enabled = GetSetting("presenceofmind")
        if enabled then
            if ni.spell.available(spell.presenceofmind)
            and ni.unit.isboss("target")
            and ni.unit.debuffstacks("player", spell.arcaneblaststacks) >= value then
                ni.spell.cast(spell.presenceofmind)
                return true;
            end
        end
    end,

    ["Arcane Missiles"] = function()
        local value, enabled = GetSetting("arcanemissiles")
        if enabled then
            if ni.spell.available(spell.arcanemissiles)
            and ni.unit.debuffstacks("player", spell.arcaneblaststacks) == value
            and ni.spell.valid("target", spell.arcanemissiles, true, true)
            and ni.unit.buff("player", spell.arcanemissilesbuff)
            and not ni.unit.ismoving("player") then
                ni.spell.cast(spell.arcanemissiles, "target")
                return true;
            end
        end
    end,

    ["Arcane Blast"] = function()
        local _, enabled = GetSetting("arcaneblast")
        if enabled then
            if ni.spell.available(spell.arcaneblast)
            and ni.spell.valid("target", spell.arcaneblast, true, true)
            and not ni.unit.ismoving("player") then
                ni.spell.cast(spell.arcaneblast, "target")
                return true;
            end
        end
    end,
}
ni.bootstrap.profile("DreamsRotations - Mage Arcane PvE", queue, abilities, onload, onunload)
