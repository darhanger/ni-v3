--------------------------------
-- DreamsRotations - Mage Fire PvE
-- Version - 1.0.6
-- Author - Dreams
--------------------------------
-- Changelog
-- 1.0.0 Initial release
-- 1.0.1 Added Scorch for crit debuff if you have no warlock, Added Fire Blast while moving
-- 1.0.2 Added Auto Target
-- 1.0.3 Added GUI
-- 1.0.4 Added Winters Chill Debuff
--       More checks for casts and pause function, no spamming or clipping of casts anymore
--       Use CastSpellByID() instead of CastSpellByName() for other localizations
-- 1.0.5 Improved overall rotation
-- 1.0.6 Added Racials
--------------------------------
local ni = ...

local items = {
    settingsfile = "DreamsRotations - Fire Mage PvE.json",
    {
        type = "entry",
        text = "|cff00ccffDreamsRotations |cffffffff- Fire Mage PvE - |cff888888v1.0.6",
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
        text = "\124T" .. select(3, GetSpellInfo(42833)) .. ":26:26\124t Fireball",
        tooltip = "Cast Fireball",
        enabled = true,
        key = "fireball",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(55360)) .. ":26:26\124t Living Bomb",
        tooltip = "Cast Living Bomb",
        enabled = true,
        key = "livingbomb",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(42859)) .. ":26:26\124t Scorch",
        tooltip = "Cast Scorch if no crit debuff is on boss and no warlock or frost mage applies it",
        enabled = true,
        key = "scorch",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(42873)) .. ":26:26\124t Fire Blast",
        tooltip = "Cast Fire Blast while you move",
        enabled = true,
        key = "fireblast",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(42891)) .. ":26:26\124t Pyroblast",
        tooltip = "Cast Pyroblast if you have a Hot Streak buff",
        enabled = true,
        key = "pyroblast",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(55342)) .. ":26:26\124t Mirror Image",
        tooltip = "Cast Mirror Image (Boss Only)",
        enabled = true,
        key = "mirrorimage",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(11129)) .. ":26:26\124t Combustion",
        tooltip = "Cast Combustion (Boss Only)",
        enabled = true,
        key = "combustion",
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
    ni.GUI.AddFrame("DreamsRotations - Mage Fire PvE", items);
end

local function onunload()
    ni.GUI.DestroyFrame("DreamsRotations - Mage Fire PvE");
end

local spell = {
    moltenarmor = GetSpellInfo(43046),
    arcanebrilliance = GetSpellInfo(43002),
    conjuremanagem = GetSpellInfo(42985),
    evocation = GetSpellInfo(12051),
    mirrorimage = GetSpellInfo(55342),
    scorch = GetSpellInfo(42859),
    fireblast = GetSpellInfo(42873),
    livingbomb = GetSpellInfo(55360),
    pyroblast = GetSpellInfo(42891),
    combustion = GetSpellInfo(11129),
    fireball = GetSpellInfo(42833),
    improvedscorch = GetSpellInfo(22959),
    shadowmastery = GetSpellInfo(17800),
    winterschill = GetSpellInfo(12579),
    hotstreak = GetSpellInfo(48108),
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
    "Scorch",
    "Mirror Image",
    "Hyperspeed Accelerators",
    "Combustion",
    "Pyroblast",
    "Fire Blast",
    "Living Bomb",
    "Fireball",
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

    ["Scorch"] = function()
        local _, enabled = GetSetting("scorch")
        if enabled then
            if ni.spell.available(spell.scorch)
            and ni.spell.valid("target", spell.scorch, true, true)
            and not ni.unit.debuff("target", spell.improvedscorch)
            and not ni.unit.debuff("target", spell.shadowmastery)
            and not ni.unit.debuff("target", spell.winterschill)
            and not ni.unit.ismoving("player") then
                ni.spell.delaycast(spell.scorch, "target", 2)
                return true;
            end
        end
    end,

    ["Fire Blast"] = function()
        local _, enabled = GetSetting("fireblast")
        if enabled then
            if ni.spell.available(spell.fireblast)
            and ni.spell.valid("target", spell.fireblast, true, true)
            and ni.unit.ismoving("player") then
                ni.spell.cast(spell.fireblast, "target")
                return true;
            end
        end
    end,

    ["Living Bomb"] = function()
        local _, enabled = GetSetting("livingbomb")
        if enabled then
            if ni.spell.available(spell.livingbomb)
            and ni.spell.valid("target", spell.livingbomb, true, true)
            and not ni.unit.debuff("target", spell.livingbomb, "player") then
                ni.spell.cast(spell.livingbomb, "target")
                return true;
            end
        end
    end,

    ["Pyroblast"] = function()
        local _, enabled = GetSetting("pyroblast")
        if enabled then
            if ni.spell.available(spell.pyroblast)
            and ni.spell.valid("target", spell.pyroblast, true, true)
            and ni.unit.buff("player", spell.hotstreak) then
                ni.spell.cast(spell.pyroblast, "target")
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
        local _, enabled = GetSetting("mirrorimage")
        if enabled then
            if ni.spell.available(spell.mirrorimage)
            and ni.unit.isboss("target") then
                ni.spell.cast(spell.mirrorimage)
                return true;
            end
        end
    end,

    ["Combustion"] = function()
        local _, enabled = GetSetting("combustion")
        if enabled then
            if ni.spell.available(spell.combustion)
            and ni.unit.isboss("target") then
                ni.spell.cast(spell.combustion)
                return true;
            end
        end
    end,

    ["Fireball"] = function()
        local _, enabled = GetSetting("fireball")
        if enabled then
            if ni.spell.available(spell.fireball)
            and ni.spell.valid("target", spell.fireball, true, true)
            and not ni.unit.ismoving("player") then
                ni.spell.cast(spell.fireball, "target")
                return true;
            end
        end
    end,
}
ni.bootstrap.profile("DreamsRotations - Mage Fire PvE", queue, abilities, onload, onunload)
