local _G = getfenv()
local L = ArchiTotemLocale
local version = GetAddOnMetadata("ArchiTotem", "Version")
local author = GetAddOnMetadata("ArchiTotem", "Author")

local _, class = UnitClass("player")
local CLOCK_UPDATE_RATE = 0.1
ArchiTotemCasted = nil
ArchiTotemCastedTotem = nil
ArchiTotemCastedElement = nil
ArchiTotemCastedButton = nil
ArchiTotemActiveTotem = {}

local totemElements = { "Earth", "Fire", "Water", "Air", "Totemic" }

local ArchiTotemPopout = {
    -- Earth Totems
    "ArchiTotemButton_Earth2",
    "ArchiTotemButton_Earth3",
    "ArchiTotemButton_Earth4",
    "ArchiTotemButton_Earth5",

    -- Fire Totems
    "ArchiTotemButton_Fire2",
    "ArchiTotemButton_Fire3",
    "ArchiTotemButton_Fire4",
    "ArchiTotemButton_Fire5",

    -- Water Totems
    "ArchiTotemButton_Water2",
    "ArchiTotemButton_Water3",
    "ArchiTotemButton_Water4",
    "ArchiTotemButton_Water5",

    -- Air Totems
    "ArchiTotemButton_Air2",
    "ArchiTotemButton_Air3",
    "ArchiTotemButton_Air4",
    "ArchiTotemButton_Air5",
    "ArchiTotemButton_Air6",
    "ArchiTotemButton_Air7",

    -- Totemic Totem
    "ArchiTotemButton_Totemic1",
}

local ArchiTotem_TotemicMasteryTotems = {
    "Strength of Earth Totem",
    "Tremor Totem",
    "Flametongue Totem",
    "Frost Resistance Totem",
    "Mana Spring Totem",
    "Fire Resistance Totem",
    "Poison Cleansing Totem",
    "Disease Cleansing Totem",
    "Healing Stream Totem",
    "Tranquil Air Totem",
    "Grounding Totem",
    "Windfury Totem",
    "Grace of Air Totem",
    "Nature Resistance Totem",
    "Windwall Totem",
    "Sentry Totem",
}

if not ArchiTotem_Options then
    ArchiTotem_Options = {
        Ear = {
            max = 5,
            shown = 1
        },
        Fir = {
            max = 5,
            shown = 1
        },
        Wat = {
            max = 5,
            shown = 1
        },
        Air = {
            max = 7,
            shown = 1
        },
        Tot = {
            max = 1,
            shown = 1
        },
        Appearance = {
            direction = "up",
            scale = 1,
            allonmouseover = false,
            bottomoncast = true,
            shownumericcooldowns = true,
            showtooltips = true
        },
        Order = {
            first = "Earth",
            second = "Fire",
            third = "Water",
            forth = "Air",
            fifth = "Totemic"
        },
        Debug = false
    }
end

local earthTotems = {
    {
        button = "ArchiTotemButton_Earth1",
        icon = "Interface\\Icons\\Spell_Nature_StrengthOfEarthTotem02",
        name = "Earthbind Totem",
        duration = 45,
        cooldown = 15,
        buff = false
    },
    {
        button = "ArchiTotemButton_Earth2",
        icon = "Interface\\Icons\\Spell_Nature_TremorTotem",
        name = "Tremor Totem",
        duration = 120,
        cooldown = 0,
        buff = false
    },
    {
        button = "ArchiTotemButton_Earth3",
        icon = "Interface\\Icons\\Spell_Nature_EarthBindTotem",
        name = "Strength of Earth Totem",
        duration = 120,
        cooldown = 0,
        buff = true
    },
    {
        button = "ArchiTotemButton_Earth4",
        icon = "Interface\\Icons\\Spell_Nature_StoneSkinTotem",
        name = "Stoneskin Totem",
        duration = 120,
        cooldown = 0,
        buff = true
    },
    {
        button = "ArchiTotemButton_Earth5",
        icon = "Interface\\Icons\\Spell_Nature_StoneClawTotem",
        name = "Stoneclaw Totem",
        duration = 15,
        cooldown = 30,
        buff = false
    }
}

local fireTotems = {
    {
        button = "ArchiTotemButton_Fire1",
        icon = "Interface\\Icons\\Spell_Fire_SearingTotem",
        name = "Searing Totem",
        duration = 55,
        cooldown = 0,
        buff = false
    },
    {
        button = "ArchiTotemButton_Fire2",
        icon = "Interface\\Icons\\Spell_Fire_SealOfFire",
        name = "Fire Nova Totem",
        duration = 5,
        cooldown = 15,
        buff = false
    },
    {
        button = "ArchiTotemButton_Fire3",
        icon = "Interface\\Icons\\Spell_Fire_SelfDestruct",
        name = "Magma Totem",
        duration = 20,
        cooldown = 0,
        buff = false
    },
    {
        button = "ArchiTotemButton_Fire4",
        icon = "Interface\\Icons\\Spell_FrostResistanceTotem_01",
        name = "Frost Resistance Totem",
        duration = 120,
        cooldown = 0,
        buff = true
    },
    {
        button = "ArchiTotemButton_Fire5",
        icon = "Interface\\Icons\\Spell_Nature_GuardianWard",
        name = "Flametongue Totem",
        duration = 120,
        cooldown = 0,
        buff = true
    }
}

local waterTotems = {
    {
        button = "ArchiTotemButton_Water1",
        icon = "Interface\\Icons\\Spell_Nature_ManaRegenTotem",
        name = "Mana Spring Totem",
        duration = 60,
        cooldown = 0,
        buff = true
    },
    {
        button = "ArchiTotemButton_Water2",
        icon = "Interface\\Icons\\Spell_FireResistanceTotem_01",
        name = "Fire Resistance Totem",
        duration = 120,
        cooldown = 0,
        buff = true
    },
    {
        button = "ArchiTotemButton_Water3",
        icon = "Interface\\Icons\\Spell_Nature_PoisonCleansingTotem",
        name = "Poison Cleansing Totem",
        duration = 120,
        cooldown = 0,
        buff = false
    },
    {
        button = "ArchiTotemButton_Water4",
        icon = "Interface\\Icons\\Spell_Nature_DiseaseCleansingTotem",
        name = "Disease Cleansing Totem",
        duration = 120,
        cooldown = 0,
        buff = false
    },
    {
        button = "ArchiTotemButton_Water5",
        icon = "Interface\\Icons\\INV_Spear_04",
        name = "Healing Stream Totem",
        duration = 60,
        cooldown = 0,
        buff = true
    }
}

local airTotems = {
    {
        button = "ArchiTotemButton_Air1",
        icon = "Interface\\Icons\\Spell_Nature_Brilliance",
        name = "Tranquil Air Totem",
        duration = 120,
        cooldown = 0,
        buff = true
    },
    {
        button = "ArchiTotemButton_Air2",
        icon = "Interface\\Icons\\Spell_Nature_GroundingTotem",
        name = "Grounding Totem",
        duration = 45,
        cooldown = 15,
        buff = true
    },
    {
        button = "ArchiTotemButton_Air3",
        icon = "Interface\\Icons\\Spell_Nature_Windfury",
        name = "Windfury Totem",
        duration = 120,
        cooldown = 0,
        buff = true
    },
    {
        button = "ArchiTotemButton_Air4",
        icon = "Interface\\Icons\\Spell_Nature_InvisibilityTotem",
        name = "Grace of Air Totem",
        duration = 120,
        cooldown = 0,
        buff = true
    },
    {
        button = "ArchiTotemButton_Air5",
        icon = "Interface\\Icons\\Spell_Nature_NatureResistanceTotem",
        name = "Nature Resistance Totem",
        duration = 120,
        cooldown = 0,
        buff = true
    },
    {
        button = "ArchiTotemButton_Air6",
        icon = "Interface\\Icons\\Spell_Nature_EarthBind",
        name = "Windwall Totem",
        duration = 120,
        cooldown = 0,
        buff = true
    },
    {
        button = "ArchiTotemButton_Air7",
        icon = "Interface\\Icons\\Spell_Nature_RemoveCurse",
        name = "Sentry Totem",
        duration = 300,
        cooldown = 0,
        buff = true
    }
}

local totemicTotems = {
    {
        button = "ArchiTotemButton_Totemic1",
        icon = "Interface\\Icons\\Spell_Shaman_TotemRecall",
        name = "Totemic Recall",
        duration = 0,
        cooldown = 6,
        buff = false
    }
}


function ArchiTotem_Print(msg, type)
    local colorCode = {
        ["error"] = "|CFFFF0000",
        ["debug"] = "|CFF0000CD",
        ["default"] = "|CFF20B2AA"
    }

    local prefix = colorCode[type or "default"] .. "[ArchiTotem] "
    DEFAULT_CHAT_FRAME:AddMessage(prefix .. msg)
end

function ArchiTotem_Noop()
end

function ArchiTotem_CheckTalents()
    -- 1=Elemental, 2=Enhancement, 3=Restoration
    local restorationTab = 3
    -- Talent indexes start at the first tier and increment left to right.
    -- Alternatively, could loop over talents and check for the 3rd column of the 3rd tier as of v1.18
    local totemicMasteryIndex = 8 -- Talent indexes start at the first tier and increment left to right

    -- Check for Totemic Mastery that boosts duration by 20%
    local name, iconPath, tier, column, currentRank, currentRank = GetTalentInfo(restorationTab, totemicMasteryIndex)
    if name and string.lower(name) == "totemic mastery" then
        if (currentRank > 0) then
            return true
        end
    else
        ArchiTotem_Print("Warning: Expected 'Totemic Mastery' at talent index " ..
            totemicMasteryIndex .. ", but found " .. (name or "nil"))
        return false
    end
end

function ArchiTotem_GetAdjustedDuration(baseDuration, totemName)
    local function checkTotemForMastery(totemName)
        for _, v in ipairs(ArchiTotem_TotemicMasteryTotems) do
            if v == totemName then
                return true
            end
        end
        return false
    end

    if checkTotemForMastery(totemName) then
        if ArchiTotem_CheckTalents() then
            return math.floor(baseDuration * 1.2)
        else
            return baseDuration
        end
    end

    return baseDuration
end

function ArchiTotem_OnLoad()
    if class == "SHAMAN" then
        -- Register for drag events
        this:RegisterForDrag("RightButton")

        -- Disable drag events for popout buttons
        for _, popout in ipairs(ArchiTotemPopout) do
            _G[popout]:SetScript("OnDragStart", nil)
            _G[popout]:SetScript("OnDragStop", nil)
        end

        -- Register for events
        this:RegisterEvent("VARIABLES_LOADED")
        this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF")
        this:RegisterEvent("SPELLCAST_STOP")
        this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
        this:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER")
        this:RegisterEvent("PLAYER_AURAS_CHANGED")
        this:RegisterEvent("PLAYER_DEAD")
        this:RegisterEvent("CHARACTER_POINTS_CHANGED")
        this:RegisterEvent("PLAYER_TALENT_UPDATE")

        -- Register slash commands
        SLASH_ARCHITOTEM1 = "/architotem"
        SLASH_ARCHITOTEM2 = "/at"
        SlashCmdList["ARCHITOTEM"] = ArchiTotem_Command

        -- Display load message
        DEFAULT_CHAT_FRAME:AddMessage("|CFF20B2AAArchiTotem|r by " ..
            author .. " " .. L["ver."] .. " " .. version .. " " .. L["loaded"] .. ".")
    else
        -- Unregister events and hide the frame if not a Shaman
        this:UnregisterAllEvents()
        ArchiTotemFrame:Hide()
    end
end

function ArchiTotem_UpdateCooldown(buttonName, duration)
    local cooldownFrame = _G[buttonName .. "Cooldown"]

    if cooldownFrame then
        -- Ensure a minimum duration of 1.5 seconds
        duration = max(duration, 1.5)

        -- Set the cooldown timer
        CooldownFrame_SetTimer(cooldownFrame, GetTime(), duration, 1)
    else
        if ArchiTotem_Options["Debug"] then
            ArchiTotem_Print("+++++" .. buttonName .. " NOT FOUND")
        end
    end
end

function ArchiTotem_ActiveTotem()
    -- Set the active totem
    local currentTime = GetTime()
    ArchiTotemActiveTotem[ArchiTotemCastedElement] = ArchiTotemCastedTotem
    ArchiTotemActiveTotem[ArchiTotemCastedElement].casted = currentTime
    ArchiTotem_TotemData[ArchiTotemCastedButton].cooldownstarted = currentTime

    ArchiTotem_UpdateAllCooldowns()

    -- Handle bottom-on-cast appearance option
    if ArchiTotem_Options["Appearance"].bottomoncast then
        local buttonNumber = tonumber(string.sub(ArchiTotemCastedButton, -1))

        if buttonNumber > 1 then
            local baseButtonName = string.sub(ArchiTotemCastedButton, 1, -2) -- Extract base button name

            for i = buttonNumber, 2, -1 do
                -- Switch the buttons
                local topButton = baseButtonName .. i
                local bottomButton = baseButtonName .. (i - 1)

                ArchiTotem_Switch(topButton, bottomButton)

                -- Set cooldown timer for top button if not started
                if not ArchiTotem_TotemData[topButton].cooldownstarted then
                    CooldownFrame_SetTimer(_G[topButton .. "Cooldown"], GetTime(), 1.5, 1)
                end
            end

            -- Set cooldown for the bottom button
            local bottomButton = baseButtonName .. 1
            local duration = ArchiTotem_TotemData[bottomButton].cooldown
            duration = (duration == 0) and 1.5 or duration -- Default to 1.5 if duration is 0
            CooldownFrame_SetTimer(_G[bottomButton .. "Cooldown"], GetTime(), duration, 1)
        end
    end

    -- Clear the casted variables
    ArchiTotemCasted = nil
    ArchiTotemCastedTotem = nil
    ArchiTotemCastedButton = nil
end

function ArchiTotem_OnEvent(event, arg1)
    if event == "VARIABLES_LOADED" then
        ArchiTotem_Setup()
        ArchiTotem_ClearAllCooldowns()
        ArchiTotem_UpdateTextures()
        ArchiTotem_UpdateShown()
        ArchiTotem_SetDirection(ArchiTotem_Options["Appearance"].direction)
        ArchiTotem_SetScale(ArchiTotem_Options["Appearance"].scale)
        ArchiTotem_Order(ArchiTotem_Options["Order"].first, ArchiTotem_Options["Order"].second,
            ArchiTotem_Options["Order"].third, ArchiTotem_Options["Order"].forth)
    elseif event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER" then
        ArchiTotemCasted = 0
    elseif event == "SPELLCAST_STOP" then
        if ArchiTotemCasted == 1 then
            ArchiTotem_ActiveTotem()
        end
    elseif event == "CHAT_MSG_SPELL_SELF_BUFF" then
        local _, _, castedTotem, _ = string.find(arg1, "You cast (.*) Totem.")
        local _, _, totemicRecall, _ = string.find(arg1, "from (%w+) Recall.")
        if castedTotem ~= nil then
            local totemCastedName = castedTotem .. " Totem"
            for totem in ArchiTotem_TotemData do
                if totemCastedName == ArchiTotem_TotemData[totem].name then
                    ArchiTotemCasted = 1
                    ArchiTotemCastedTotem = ArchiTotem_TotemData[totem]
                    ArchiTotemCastedElement = string.sub(totem, 18, -2)
                    ArchiTotemCastedButton = totem
                    ArchiTotem_ActiveTotem()
                end
            end
        end
        if totemicRecall ~= nil then
            for k, _ in ArchiTotemActiveTotem do
                if k ~= nil and k ~= "Totemic" then
                    _G[k .. "DurationText"]:Hide()
                end
            end
            ArchiTotemActiveTotem = {}
        end
    elseif event == "PLAYER_AURAS_CHANGED" then
        local outOfRange = {}
        local playerBuffs = {}

        -- Gather active player buff textures
        for i = 0, 31 do
            local buffId, _ = GetPlayerBuff(i, "HELPFUL|HARMFUL|PASSIVE")
            if buffId >= 0 then
                local texture = GetPlayerBuffTexture(buffId)
                playerBuffs[texture] = true
            else
                break
            end
        end

        -- Check if any active totem matches a player buff
        for _, totem in pairs(ArchiTotemActiveTotem) do
            if playerBuffs[totem.icon] then
                outOfRange[totem.name] = false
            else
                outOfRange[totem.name] = true
            end
        end

        -- Process each active totem
        for k, totem in pairs(ArchiTotemActiveTotem) do
            for _, data in pairs(ArchiTotem_TotemData) do
                if k ~= nil and totem.duration > 0 and data.name == totem.name then
                    if outOfRange[totem.name] and totem.buff then
                        _G[k .. "DurationText"]:SetTextColor(1, 0, 0)
                    else
                        _G[k .. "DurationText"]:SetTextColor(1, 1, 1)
                    end
                    break
                end
            end
        end
    elseif event == "PLAYER_DEAD" then
        for totemName, _ in pairs(ArchiTotemActiveTotem) do
            if totemName and totemName ~= "Totemic" then
                local durationText = _G[totemName .. "DurationText"]
                if durationText then
                    durationText:Hide()
                end
            end
        end
        -- Clear active totems
        ArchiTotemActiveTotem = {}
    elseif event == "CHARACTER_POINTS_CHANGED" or event == "PLAYER_TALENT_UPDATE" then
        ArchiTotem_Setup()
    end
end

function ArchiTotem_OnDragStart()
    if IsControlKeyDown() then
        ArchiTotemFrame:StartMoving()
    end
end

function ArchiTotem_OnDragStop()
    ArchiTotemFrame:StopMovingOrSizing()
end

function ArchiTotem_OnEnter()
    -- When entering a button, show all totems of that element
    if ArchiTotem_Options["Appearance"].allonmouseover == true then
        for _, v in totemElements do
            -- For all the elements
            local threeLetterElement = string.sub(v, 1, 3)
            -- Get the 3 first letters of the element
            for i = 1, ArchiTotem_Options[threeLetterElement].max do
                -- For all buttons of that element
                _G["ArchiTotemButton_" .. v .. i]:Show()
            end
        end
    else
        local totemElement = string.sub(this:GetName(), 1, -2)
        -- ArchiTotemButton_Earth, ArchiTotemButton_Fire..
        local maxOfElement = string.sub(this:GetName(), 18, 20)
        -- Get the 3 first letters of the element: "Ear", "Fir"..
        for i = 2, ArchiTotem_Options[maxOfElement].max do
            -- For all buttons
            local button = _G[totemElement .. i]
            if button then
                button:Show()
            end
        end
    end

    if ArchiTotem_Options["Appearance"].showtooltips == true then
        if ArchiTotem_TotemData[this:GetName()] then
            local tooltipspellID = ArchiTotem_GetSpellId(ArchiTotem_TotemData[this:GetName()].name)
            if tooltipspellID > 0 then
                GameTooltip_SetDefaultAnchor(GameTooltip, this)
                GameTooltip:SetSpell(tooltipspellID, SpellBookFrame.bookType)
            end
        end
    end
end

function ArchiTotem_GetSpellId(spell)
    local localizeSpell = L[spell]
    local spellID = 0
    for id = 1, 200 do
        local spellName, _ = GetSpellName(id, BOOKTYPE_SPELL)
        if spellName and string.find(spellName, localizeSpell) then
            spellID = id
        end
    end
    return spellID
end

function ArchiTotem_OnLeave()
    -- When leaving a button, hide all totems that are to be hidden
    ArchiTotem_UpdateShown()
end

function ArchiTotem_OnClick()
    -- When clicking a button, you either want to move it up or down, or cast the totem
    if IsAltKeyDown() then
        local underTotemNumber = string.sub(this:GetName(), -1, -1) - 1
        -- Number of the totem below the one you clicked
        local underTotem = string.sub(this:GetName(), 1, -2) .. underTotemNumber
        -- Earth1, Fire1..
        if underTotemNumber > 0 then
            -- If the totem you clicked isn't the bottom one
            ArchiTotem_Switch(this:GetName(), underTotem)
            -- Switch them (the clicked and the one below)
        end
    elseif IsControlKeyDown() then
        local overTotemNumber = string.sub(this:GetName(), -1, -1) + 1
        -- Number of the totem over the one you clicked
        local overTotem = string.sub(this:GetName(), 1, -2) .. overTotemNumber
        -- Earth3, Fire2..
        local maxOfElement = string.sub(this:GetName(), 18, 20)
        -- Get the 3 first letters of the element: "Ear", "Fir"..
        if overTotemNumber < ArchiTotem_Options[maxOfElement].max + 1 then
            -- If there is a totem over the one you clicked
            ArchiTotem_Switch(this:GetName(), overTotem)
            -- Switch them (the clicked and the one above)
        end
    else
        ArchiTotem_CastTotem()
    end
end

function ArchiTotem_CastTotem()
    -- Initialize casting state and store relevant information
    ArchiTotemCasted = 1
    ArchiTotemCastedButton = this:GetName()
    ArchiTotemCastedTotem = ArchiTotem_TotemData[ArchiTotemCastedButton]
    ArchiTotemCastedElement = string.sub(ArchiTotemCastedButton, 18, -2)

    if not ArchiTotemCastedTotem.casted then
        -- Initialize the cast time if it hasn't been set
        ArchiTotemCastedTotem.casted = GetTime() - ArchiTotemCastedTotem.cooldown
    end

    -- Ensure cooldown is at least 1.5 seconds
    local cooldown = ArchiTotemCastedTotem.cooldown or 1.5
    if cooldown < 1.5 then
        cooldown = 1.5
    end

    -- Localize the spell name
    local localizedSpell = L[ArchiTotemCastedTotem.name]
    if not localizedSpell then
        print("Error: Spell not localized")
        return
    end

    -- Cast the totem
    CastSpellByName(localizedSpell)

    -- Handle Totemic Recall cleanup
    if localizedSpell == "Totemic Recall" then
        for totemName, _ in pairs(ArchiTotemActiveTotem) do
            if totemName and totemName ~= "Totemic" then
                local durationText = _G[totemName .. "DurationText"]
                if durationText then
                    durationText:Hide()
                end
            end
        end
        -- Clear active totems
        ArchiTotemActiveTotem = {}
    end
end

function ArchiTotem_Switch(arg1, arg2)
    -- Swap the data of two totems and update their textures and cooldowns
    -- Swap the totem data
    ArchiTotem_TotemData[arg1], ArchiTotem_TotemData[arg2] =
        ArchiTotem_TotemData[arg2], ArchiTotem_TotemData[arg1]

    -- Hide cooldown text and background for both totems
    for _, arg in ipairs({ arg1, arg2 }) do
        local cooldownText = _G[arg .. "CooldownText"]
        local cooldownBg = _G[arg .. "CooldownBg"]
        if cooldownText then cooldownText:Hide() end
        if cooldownBg then cooldownBg:Hide() end
    end

    -- Update cooldown frames for each totem
    for _, arg in ipairs({ arg1, arg2 }) do
        local totemData = ArchiTotem_TotemData[arg]
        local spellID = ArchiTotem_GetSpellId(totemData.name)

        if spellID and spellID ~= 0 then
            local _, duration = GetSpellCooldown(spellID, BOOKTYPE_SPELL)
            local cooldownFrame = _G[arg .. "Cooldown"]
            if cooldownFrame then
                CooldownFrame_SetTimer(cooldownFrame, totemData.casted, duration, 1)
            end
        end
    end

    -- Refresh totem textures
    ArchiTotem_UpdateTextures()
end

function ArchiTotem_ClearAllCooldowns()
    -- Clear all the cooldowns of the totems, or strange things may happen when loggin in
    for k, v in ArchiTotem_TotemData do
        v.cooldownstarted = nil
    end
end

function ArchiTotem_UpdateTextures()
    -- Set the textures of all buttons
    for k, v in totemElements do
        -- For all the elements
        local threeLetterElement = string.sub(v, 1, 3)
        -- Get the 3 first letters of the element
        for i = 1, ArchiTotem_Options[threeLetterElement].max do
            -- For all buttons of that element
            _G["ArchiTotemButton_" .. v .. i .. "Texture"]:SetTexture(ArchiTotem_TotemData
                ["ArchiTotemButton_" .. v .. i].icon)
            -- Set the texture
        end
    end
end

function ArchiTotem_UpdateShown()
    -- Show buttons that should be shown, hide buttons that should be hidden
    for k, v in totemElements do
        -- For all the elements
        local threeLetterElement = string.sub(v, 1, 3)
        -- Get the 3 first letters of the element
        for i = 1, ArchiTotem_Options[threeLetterElement].max do
            -- For all buttons of that element
            if i <= ArchiTotem_Options[threeLetterElement].shown then
                _G["ArchiTotemButton_" .. v .. i]:Show()
            else
                _G["ArchiTotemButton_" .. v .. i]:Hide()
            end
        end
    end
end

function ArchiTotem_UpdateAllCooldowns()
    for k, v in ArchiTotem_TotemData do
        -- Handles the cooldowns of all totems
        if v.casted == nil then v.casted = GetTime() - v.cooldown end
        local duration = 1.5
        if GetTime() > (v.casted + v.cooldown) then
            if ArchiTotemCastedButton == k then duration = v.cooldown else duration = 1.5 end
            ArchiTotem_UpdateCooldown(k, duration)
        end
    end
end

function ArchiTotem_SetDirection(dir)
    -- Set the direction for totems to pop up when hovering
    ArchiTotem_Options["Appearance"].direction = dir

    -- Define anchor points and duration text offsets
    local anchor1, anchor2, offset
    if dir == "down" then
        anchor1, anchor2, offset = "TOPLEFT", "BOTTOMLEFT", 26
    elseif dir == "up" then
        anchor1, anchor2, offset = "BOTTOMLEFT", "TOPLEFT", -26
    else
        print("Error: Invalid direction. Must be 'up' or 'down'.")
        return
    end

    -- Update duration text positions
    local durationTexts = {
        EarthDurationText = ArchiTotemButton_Earth1,
        FireDurationText = ArchiTotemButton_Fire1,
        WaterDurationText = ArchiTotemButton_Water1,
        AirDurationText = ArchiTotemButton_Air1,
    }

    for text, button in pairs(durationTexts) do
        _G[text]:SetPoint("CENTER", button, "CENTER", 0, offset)
    end

    -- Adjust the anchor points for all totem buttons
    for _, element in ipairs(totemElements) do
        local elementKey = string.sub(element, 1, 3) -- Get the 3-letter element key
        local maxButtons = ArchiTotem_Options[elementKey].max

        for i = 2, maxButtons do
            local currentButton = _G["ArchiTotemButton_" .. element .. i]
            local previousButton = _G["ArchiTotemButton_" .. element .. (i - 1)]
            if currentButton and previousButton then
                currentButton:ClearAllPoints()
                currentButton:SetPoint(anchor1, previousButton, anchor2)
            end
        end
    end
end

function ArchiTotem_Order(first, second, third, forth)
    -- Ensure all elements are provided
    if not first or not second or not third or not forth then
        return ArchiTotem_Print(L["Elements must be written in English!"] .. " <Earth, Fire, Water, Air>", "error")
    end

    -- Helper function to format the element name
    local function formatElement(element)
        return "ArchiTotemButton_" .. strupper(string.sub(element, 1, 1)) .. string.sub(element, 2) .. "1"
    end

    -- Get button names
    local buttons = {
        formatElement(first),
        formatElement(second),
        formatElement(third),
        formatElement(forth),
        "ArchiTotemButton_Totemic1",
    }

    -- Save the order in options
    ArchiTotem_Options["Order"] = {
        first = strupper(string.sub(first, 1, 1)) .. string.sub(first, 2),
        second = strupper(string.sub(second, 1, 1)) .. string.sub(second, 2),
        third = strupper(string.sub(third, 1, 1)) .. string.sub(third, 2),
        forth = strupper(string.sub(forth, 1, 1)) .. string.sub(forth, 2),
        fifth = "ArchiTotemButton_Totemic1",
    }

    -- Set button anchors dynamically
    for i, button in ipairs(buttons) do
        local currentButton = _G[button]
        if currentButton then
            currentButton:ClearAllPoints()
            if i == 1 then
                -- Anchor the first button to the center of the frame
                currentButton:SetPoint("CENTER", ArchiTotemFrame, "CENTER")
            else
                -- Anchor subsequent buttons to the previous button
                currentButton:SetPoint("BOTTOMLEFT", _G[buttons[i - 1]], "BOTTOMRIGHT")
            end
        end
    end
end

function ArchiTotem_SetScale(scale)
    -- Sets the scale of the entire ArchiTotem frame
    ArchiTotem_Options["Appearance"].scale = scale
    -- Save the scale
    for k, v in totemElements do
        -- For all the elements
        local threeLetterElement = string.sub(v, 1, 3)
        -- Get the 3 first letters of the element
        for i = 1, ArchiTotem_Options[threeLetterElement].max do
            -- For all buttons of that element
            _G["ArchiTotemButton_" .. v .. i]:SetScale(scale)
            -- Set the scale
        end
    end
end

function ArchiTotem_OnUpdate(arg1)
    -- Called on the OnUpdate event, deals with the timers
    this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + arg1

    if this.TimeSinceLastUpdate > CLOCK_UPDATE_RATE then
        for k, v in ArchiTotemActiveTotem do
            -- Handles the duration of the active totems
            if GetTime() > (v.casted + v.duration) and v.duration > 0 then
                v = nil
                _G[k .. "DurationText"]:Hide()
            else
                local seconds = string.format("%.0f", (v.duration + (v.casted - GetTime())))
                local minutes = string.format("0%.0f", ((seconds - mod(seconds, 60)) / 60))
                local seconds = mod(seconds, 60)
                if v.duration > 0 then
                    _G[k .. "DurationText"]:Show()
                end
                if seconds < 10 then
                    seconds = string.format("0%.0f", seconds)
                else
                    seconds = string.format("%.0f", seconds)
                end
                if v.duration > 0 then
                    _G[k .. "DurationText"]:SetText(minutes .. ":" .. seconds)
                end
            end
        end
        for k, v in ArchiTotem_TotemData do
            -- Handles the cooldowns of all totems
            if ArchiTotem_Options["Appearance"].shownumericcooldowns == true then
                if v.cooldownstarted == nil then
                else
                    if GetTime() > (v.cooldownstarted + v.cooldown) then
                        _G[k .. "CooldownText"]:Hide()
                        _G[k .. "CooldownBg"]:Hide()
                        v.cooldownstarted = nil
                    else
                        _G[k .. "CooldownBg"]:Show()
                        _G[k .. "CooldownText"]:Show()
                        local seconds = string.format("%.0f", (v.cooldown + (v.cooldownstarted - GetTime())))
                        local minutes = string.format("%.0f", ((seconds - mod(seconds, 60)) / 60))
                        local seconds = mod(seconds, 60)
                        if minutes ~= "0" then
                            _G[k .. "CooldownText"]:SetText(minutes .. ":" .. seconds)
                        else
                            _G[k .. "CooldownText"]:SetText(seconds)
                        end
                    end
                end
            end
        end
        this.TimeSinceLastUpdate = 0
    end
end

function ArchiTotem_Setup()
    ArchiTotem_TotemData = {}

    local function addTotemData(button, icon, name, duration, cooldown, buff)
        ArchiTotem_TotemData[button] = {
            icon = icon,
            name = name,
            duration = duration,
            cooldown = cooldown,
            cooldownstarted = nil,
            casted = nil,
            buff = buff
        }
    end

    -- Combine all totem data into a single table for processing
    local allTotems = {
        { group = "earthTotems",   data = earthTotems },
        { group = "fireTotems",    data = fireTotems },
        { group = "waterTotems",   data = waterTotems },
        { group = "airTotems",     data = airTotems },
        { group = "totemicTotems", data = totemicTotems },
    }

    -- Iterate over all totems and add their data
    for _, totemGroup in ipairs(allTotems) do
        for _, totem in ipairs(totemGroup.data) do
            local adjustedDuration = ArchiTotem_GetAdjustedDuration(totem.duration, totem.name)
            addTotemData(totem.button, totem.icon, totem.name, adjustedDuration, totem.cooldown, totem.buff)
        end
    end
end

function ArchiTotem_Command(cmd)
    -- /slash commands
    local command = string.lower(cmd)

    local i = 1
    local arg = {}
    local tmparg = nil
    for tmparg in string.gfind(command, "%w+") do
        arg[i] = tmparg
        i = i + 1
    end

    if arg[1] == "set" then
        -- /at set, how many totems an element will show with no mouseover
        if arg[2] == "earth" then
            if tonumber(arg[3]) > 0 and tonumber(arg[3]) <= 5 then
                ArchiTotem_Options["Ear"].shown = tonumber(arg[3])
                ArchiTotem_UpdateShown()
                ArchiTotem_Print(L["Earth totems shown: "] .. arg[3])
            end
        elseif arg[2] == "fire" then
            if tonumber(arg[3]) > 0 and tonumber(arg[3]) <= 5 then
                ArchiTotem_Options["Fir"].shown = tonumber(arg[3])
                ArchiTotem_UpdateShown()
                ArchiTotem_Print(L["Fire totems shown: "] .. arg[3])
            end
        elseif arg[2] == "water" then
            if tonumber(arg[3]) > 0 and tonumber(arg[3]) <= 6 then
                ArchiTotem_Options["Wat"].shown = tonumber(arg[3])
                ArchiTotem_UpdateShown()
                ArchiTotem_Print(L["Water totems shown: "] .. arg[3])
            end
        elseif arg[2] == "air" then
            if tonumber(arg[3]) > 0 and tonumber(arg[3]) <= 7 then
                ArchiTotem_Options["Air"].shown = tonumber(arg[3])
                ArchiTotem_UpdateShown()
                ArchiTotem_Print(L["Air totems shown: "] .. arg[3])
            end
        else
            ArchiTotem_Print(L["Elements must be written in english!"] .. " <Earth, Fire, Water, Air>", "error")
        end
    elseif arg[1] == "direction" then
        -- /at direction, which direction the totems should go on mouseover
        if arg[2] == "down" then
            ArchiTotem_SetDirection("down")
            ArchiTotem_Print(L["Direction set to: Down"])
        elseif arg[2] == "up" then
            ArchiTotem_SetDirection("up")
            ArchiTotem_Print(L["Direction set to: Up"])
        else
            ArchiTotem_Print(L["Direction must be down or up!"], "error")
        end
    elseif arg[1] == "order" then
        -- /at order, which order the totems have, left to right
        ArchiTotem_Order(arg[2], arg[3], arg[4], arg[5])
        if arg[2] and arg[3] and arg[4] and arg[5] and arg[6] then -- check english elements
            ArchiTotem_Print(L["Order set to: "] ..
                arg[2] .. ", " .. arg[3] .. ", " .. arg[4] .. ", " .. arg[5] .. ", " .. arg[6])
        end
    elseif arg[1] == "scale" then
        -- /at scale, what scale the frame has
        if not arg[2] then
            return ArchiTotem_Print(L["Specify scale"], "error")
        elseif type(tonumber(arg[2])) ~= "number" then
            return ArchiTotem_Print(L["Scale must be a number!"], "error")
        end
        if arg[3] then
            ArchiTotem_SetScale(arg[2] .. "." .. arg[3])
            ArchiTotem_Print(L["Scale set to: "] .. arg[2] .. "." .. arg[3])
        else
            ArchiTotem_SetScale(arg[2])
            ArchiTotem_Print(L["Scale set to: "] .. arg[2])
        end
    elseif arg[1] == "showall" then
        -- /at showall, toggle showing of all totems on mouseover
        if ArchiTotem_Options["Appearance"].allonmouseover == false then
            ArchiTotem_Options["Appearance"].allonmouseover = true
            ArchiTotem_Print(L["Showing all totems on mouseover"])
        else
            ArchiTotem_Options["Appearance"].allonmouseover = false
            ArchiTotem_Print(L["Showing only one element on mouseover"])
        end
    elseif arg[1] == "bottomcast" then
        if ArchiTotem_Options["Appearance"].bottomoncast == false then
            ArchiTotem_Options["Appearance"].bottomoncast = true
            ArchiTotem_Print(L["Totems will move the the bottom line when cast"])
        else
            ArchiTotem_Options["Appearance"].bottomoncast = false
            ArchiTotem_Print(L["Totems will stay where they are when cast"])
        end
    elseif arg[1] == "timers" then
        if ArchiTotem_Options["Appearance"].shownumericcooldowns == false then
            ArchiTotem_Options["Appearance"].shownumericcooldowns = true
            ArchiTotem_Print(L["Timers are now turned on"])
        else
            ArchiTotem_Options["Appearance"].shownumericcooldowns = false
            ArchiTotem_Print(L["Timers are now turned off"])
            for k, v in ArchiTotem_TotemData do
                _G[k .. "CooldownText"]:Hide()
                _G[k .. "CooldownBg"]:Hide()
                v.cooldownstarted = nil
            end
            for k, _ in ArchiTotemActiveTotem do
                _G[k .. "DurationText"]:Hide()
            end
        end
    elseif arg[1] == "tooltip" then
        if ArchiTotem_Options["Appearance"].showtooltips == false then
            ArchiTotem_Options["Appearance"].showtooltips = true
            ArchiTotem_Print(L["Tooltips are now turned on"])
        else
            ArchiTotem_Options["Appearance"].showtooltips = false
            ArchiTotem_Print(L["Tooltips are now turned off"])
        end
    elseif arg[1] == "debug" then
        if ArchiTotem_Options["Debug"] == false then
            ArchiTotem_Options["Debug"] = true
            ArchiTotem_Print(L["Debuging are now turned on"])
        else
            ArchiTotem_Options["Debug"] = false
            ArchiTotem_Print(L["Debuging are now turned off"])
        end
    elseif arg[1] == nil then
        ArchiTotem_Print(L["Available commands:"])
        ArchiTotem_Print(L["/at set <earth/fire/water/air> # - Sets the totems shown of that element to #."])
        ArchiTotem_Print(L["/at direction <up/down> - Set the direction totems pop up."])
        ArchiTotem_Print(L
            ["/at order <element 1, element 2, element 3, element 4> - Sets the order of the totems, from left to right."])
        ArchiTotem_Print(L["/at scale # - Sets the scale of ArchiTotem, default is 1."])
        ArchiTotem_Print(L["/at showall - Toggles show all mode, displaying all totems on mouseover."])
        ArchiTotem_Print(L["/at bottomcast - Toggles moving totems to the bottom line when cast"])
        ArchiTotem_Print(L["/at timers - Toggles showing timers"])
        ArchiTotem_Print(L["/at tooltip - Toggles showing tooltips"])
        ArchiTotem_Print(L["/at debug - Toggles debuging"])
        DEFAULT_CHAT_FRAME:AddMessage("\n")
        ArchiTotem_Print(L["Moving the bar:"])
        ArchiTotem_Print(L["Ctrl-RightClick and Drag any of the main buttons"])
        ArchiTotem_Print(L["Ordering totems of same element:"])
        ArchiTotem_Print(L["Ctrl-LeftClick any of the buttons"])
    else
        ArchiTotem_Print(L["Unavailable command. Type /at for help."], "error")
    end
end
