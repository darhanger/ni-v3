--------------------------------
-- DreamsRotations - Rogue Combat PvE
-- Version - 1.0.7
-- Author - Dreams
--------------------------------
-- Changelog
-- 1.0.0 Initial release
-- 1.0.1 Changed priority of Rupture and Slice And Dice (High Rupture priority)
-- 1.0.2 Added Tricks of the Trade on Focus Target
-- 1.0.3 Added Auto Target
-- 1.0.4 Added GUI
-- 1.0.5 Improved overall rotation
-- 1.0.6 Added Poisons
-- 1.0.7 Added Racials
--------------------------------
local ni = ...

local items = {
    settingsfile = "DreamsRotations - Rogue Combat PvE.json",
    {
        type = "entry",
        text = "|cff00ccffDreamsRotations |cffffffff- Rogue Combat PvE - |cff888888v1.0.7",
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
        text = "\124T" .. GetItemIcon(43233) .. ":26:26\124t Apply Poisons on weapons",
        tooltip = "Apply Instant Poison on your Mainhand and Deadly Poison on your Offhand",
        enabled = true,
        key = "poisons",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(57934)) .. ":26:26\124t Tricks of the Trade on Focus",
        tooltip = "Cast Tricks of the Trade on your focus target be sure too have your focus on main tank or on a other rogue",
        enabled = true,
        key = "tricksofthetrade",
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
        text = "\124T" .. select(3, GetSpellInfo(48638)) .. ":26:26\124t Sinister Strike",
        tooltip = "Cast Sinister Strike",
        enabled = true,
        key = "sinisterstrike",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(51690)) .. ":26:26\124t Killing Spree",
        tooltip = "Cast Killing Spree (Boss Only)",
        key = "killingspree",
        enabled = true,
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(13877)) .. ":26:26\124t Blade Flurry",
        tooltip = "Cast Blade Flurry (Boss Only)",
        enabled = true,
        key = "bladeflurry",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(13750)) .. ":26:26\124t Adrenaline Rush",
        tooltip = "Cast Adrenaline Rush (Boss Only)",
        enabled = true,
        key = "adrenalinerush",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(6774)) .. ":26:26\124t Slice and Dice at or more combopoints",
        tooltip = "Cast Slice and Dice if you have at or more combopoints",
        enabled = true,
        value = 2,
        key = "sliceanddice",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(48672)) .. ":26:26\124t Rupture at or more combopoints",
        tooltip = "Cast Rupture if you have at or more combopoints",
        enabled = true,
        value = 4,
        key = "rupture",
    },
    {
        type = "entry",
        text = "\124T" .. select(3, GetSpellInfo(48668)) .. ":26:26\124t Eviscerate at or more combopoints",
        tooltip = "Cast Eviscerate if you have at or more combopoints",
        enabled = true,
        value = 4,
        key = "eviscerate",
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
    ni.GUI.AddFrame("DreamsRotations - Rogue Combat PvE", items);
end

local function onunload()
    ni.GUI.DestroyFrame("DreamsRotations - Rogue Combat PvE");
end

local spell = {
    startattack = GetSpellInfo(6603),
    tricksofthetrade = GetSpellInfo(57934),
    killingspree = GetSpellInfo(51690),
    bladeflurry = GetSpellInfo(13877),
    adrenalinerush = GetSpellInfo(13750),
    sliceanddice = GetSpellInfo(6774),
    rupture = GetSpellInfo(48672),
    eviscerate = GetSpellInfo(48668),
    sinisterstrike = GetSpellInfo(48638),
}

local item = {
    food = GetSpellInfo(45548),
    drink = GetSpellInfo(57073),
    instantpoison = GetItemInfo(43231),
    deadlypoison = GetItemInfo(43233),
}

local queue = {
    "Poisons",
    "Pause Rotation",
    "Auto Target",
    "Start Attack",
    "Tricks of the Trade",
    "Hyperspeed Accelerators",
    "Slice and Dice",
    "Rupture",
    "Killing Spree",
    "Blade Flurry",
    "Adrenaline Rush",
    "Eviscerate",
    "Sinister Strike",
}

local abilities = {
    ["Poisons"] = function()
        local _, enabled = GetSetting("poisons")
        if enabled then
            local mainHand,_,_,offHand,_,_ = GetWeaponEnchantInfo()

            if PoisonCastTime and GetTime() - PoisonCastTime > 4 then
                PoisonCastTime = nil
            end

            if not UnitAffectingCombat("player")
            and not PoisonCastTime then
                PoisonCastTime = GetTime()

                if not mainHand
                and ni.player.hasitem(item.instantpoison) then
                    ni.player.useitem(item.instantpoison)
                    ni.player.useinventoryitem(16)
                end

                if not offHand
                and ni.player.hasitem(item.deadlypoison) then
                    ni.player.useitem(item.deadlypoison)
                    ni.player.useinventoryitem(17)
                end
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

    ["Start Attack"] = function()
        if ni.unit.exists("target")
        and UnitCanAttack("player", "target")
        and not UnitIsDeadOrGhost("target")
        and UnitAffectingCombat("player")
        and not IsCurrentSpell(spell.startattack) then
            ni.spell.cast(spell.startattack)
            return true;
        end
    end,

    ["Tricks of the Trade"] = function()
        local _, enabled = GetSetting("tricksofthetrade")
        if enabled then
            if ni.spell.available(spell.tricksofthetrade)
            and ni.spell.valid("focus", spell.tricksofthetrade, false, true, true)
            and ni.unit.exists("focus") then
                ni.spell.cast(spell.tricksofthetrade, "focus")
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

    ["Killing Spree"] = function()
        local _, enabled = GetSetting("killingspree")
        if enabled then
            if ni.spell.available(spell.killingspree)
            and ni.unit.isboss("target")
            and ni.unit.buff("player", spell.sliceanddice)
            and ni.player.power() < 60 then
                ni.spell.cast(spell.killingspree, "target")
                return true;
            end
        end
    end,

    ["Blade Flurry"] = function()
        local _, enabled = GetSetting("bladeflurry")
        if enabled then
            if ni.spell.available(spell.bladeflurry)
            and ni.unit.isboss("target")
            and ni.unit.buff("player", spell.sliceanddice) then
                ni.spell.cast(spell.bladeflurry)
                return true;
            end
        end
    end,

    ["Adrenaline Rush"] = function()
        local _, enabled = GetSetting("adrenalinerush")
        if enabled then
            if ni.spell.available(spell.adrenalinerush)
            and ni.unit.isboss("target")
            and ni.unit.buff("player", spell.sliceanddice)
            and ni.player.power() < 40 then
                ni.spell.cast(spell.adrenalinerush)
                return true;
            end
        end
    end,

    ["Slice and Dice"] = function()
        local value, enabled = GetSetting("sliceanddice")
        if enabled then
            if ni.spell.available(spell.sliceanddice)
            and GetComboPoints("player", "target") >= value
            and ni.unit.buffremaining("player", spell.sliceanddice, "player") <= 2 then
                ni.spell.cast(spell.sliceanddice)
                return true;
            end
        end
    end,

    ["Rupture"] = function()
        local value, enabled = GetSetting("rupture")
        if enabled then
            if ni.spell.available(spell.rupture)
            and ni.spell.valid("target", spell.rupture, true, true)
            and GetComboPoints("player", "target") >= value
            and not ni.unit.debuff("target", spell.rupture, "player") then
                ni.spell.cast(spell.rupture, "target")
                return true;
            end
        end
    end,

    ["Eviscerate"] = function()
        local value, enabled = GetSetting("eviscerate")
        if enabled then
            if ni.spell.available(spell.eviscerate)
            and ni.spell.valid("target", spell.eviscerate, true, true)
            and GetComboPoints("player", "target") >= value then
                ni.spell.cast(spell.eviscerate, "target")
                return true;
            end
        end
    end,

    ["Sinister Strike"] = function()
        local _, enabled = GetSetting("sinisterstrike")
        if enabled then
            if ni.spell.available(spell.sinisterstrike)
            and ni.spell.valid("target", spell.sinisterstrike, true, true) then
                ni.spell.cast(spell.sinisterstrike, "target")
                return true;
            end
        end
    end,
}
ni.bootstrap.profile("DreamsRotations - Rogue Combat PvE", queue, abilities, onload, onunload)
