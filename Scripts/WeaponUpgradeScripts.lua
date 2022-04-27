function ShowWeaponUpgradeScreen( args )

	local textOffsetX = -50

	OnScreenOpened( { Flag = "WeaponUpgradeScreen", PersistCombatUI = true } )
	FreezePlayerUnit("WeaponUpgradeScreen" )
	EnableShopGamepadCursor()

	local weaponName = args.WeaponName

	ScreenAnchors.WeaponUpgradeScreen = { Components = {}, Name = "WeaponUpgradeScreen", OpenedEquippedIndex = GetEquippedWeaponTraitIndex( weaponName ) }
	local components = ScreenAnchors.WeaponUpgradeScreen.Components
	EnableShopGamepadCursor( ScreenAnchors.WeaponUpgradeScreen.Name )

	components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })
	components.ShopBackground = CreateScreenComponent({ Name = "WeaponSelectPanelBox", Group = "Combat_Menu_TraitTray_Backing", X = ScreenCenterX, Y = ScreenHeight/2 - 18})
	components.WeaponImage = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu_TraitTray", X = 335, Y = 435 })
	DebugAssert({ Condition = GetWeaponAspectImage( weaponName ) ~= nil, Text = "No weapon image available for " .. weaponName .. " index " .. GetEquippedWeaponTraitIndex( weaponName )})
	SetAnimation({ DestinationId = components.WeaponImage.Id, Name = GetWeaponAspectImage( weaponName )})

	SetAlpha({ Id = components.WeaponImage.Id, Fraction = 0 })
	SetThingProperty({ Property = "Ambient", Value = 0.0, DestinationId = components.WeaponImage.Id })


	-- CreateTextBox({ Id = components.ShopBackground.Id, Text = "WeaponUpgradeScreen_Header", FontSize = 24, OffsetX = -500, OffsetY = -380, Color = Color.White, Font = "AlegreyaSansSCRegular", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })
	CreateTextBox({ Id = components.ShopBackground.Id, Text = weaponName.."_Full", FontSize = 38, OffsetX = 0, OffsetY = -480, Color = Color.White, Font = "SpectralSCLightTitling", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })
	CreateTextBox({ Id = components.ShopBackground.Id, Text = weaponName.."_Full", UseDescription = true, FontSize = 20, Width = 620, OffsetX = 0, OffsetY = -406, Color = {0.643, 0.635, 0.482, 1.0}, Font = "CrimsonTextItalic", ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2}, Justification = "Center" })
	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 10 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.090, 0.055, 0.157, 0.6} })
	wait(0.5)
	local timesCleared = "NoClears"
	local clearTimeText = "NoClearTime"
	local heatClearText = "NoHeatClear"
	local weaponKills = "NoWeaponKills"
	local weaponSelectPanelRightString = "WeaponSelectPanel_Right"

	if GameState.TimesClearedWeapon and GameState.TimesClearedWeapon[weaponName] then
		timesCleared = GameState.TimesClearedWeapon[weaponName]
	end
	if GameState.WeaponRecordsClearTime and GameState.WeaponRecordsClearTime[weaponName] then
		clearTimeText = GetTimerString( GameState.WeaponRecordsClearTime[weaponName])
	end

	if GameState.WeaponRecordsShrinePoints and GameState.WeaponRecordsShrinePoints[weaponName] and GameState.WeaponRecordsShrinePoints[weaponName] > 0 then
		heatClearText = GameState.WeaponRecordsShrinePoints[weaponName]
	else
		weaponSelectPanelRightString = "WeaponSelectPanel_Right_Alt"
	end

	if GameState.WeaponKills and GameState.WeaponKills[weaponName] then
		weaponKills = GameState.WeaponKills[weaponName]
	end

	SetAlpha({ Id = components.WeaponImage.Id, Fraction = 1 })
	local ruScale = 0.75
	local deScale = 0.8
	local cnScale = 0.8
	local plScale = 0.8
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "WeaponSelectPanel_Title", FontSize = 25, Width = 340, OffsetX = -625, OffsetY = 174, Color = {0.749, 0.749, 0.749, 1.0}, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center", VerticalJustification = "Top", LineSpacingBottom = -5,
		LangPlScaleModifier = plScale
	})
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "WeaponSelectPanel_Left", FontSize = 20, Width = 340, OffsetX = -795, OffsetY = 230, Color = {0.749, 0.749, 0.749, 1.0}, Font = "AlegreyaSansSCRegular", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Left", VerticalJustification = "Top", LineSpacingBottom = -5,

			LangRuScaleModifier = ruScale,
			LangDeScaleModifier = deScale,
			LangCnScaleModifier = cnScale,
			LangPlScaleModifier = plScale,
			})
	CreateTextBox({ Id = components.ShopBackground.Id, Text = weaponSelectPanelRightString, FontSize = 20, Width = 340, OffsetX = -485, OffsetY = 230, Color = {0.749, 0.749, 0.749, 1.0}, Font = "AlegreyaSansSCRegular", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Right", VerticalJustification = "Top",
		LineSpacingBottom = -5,
		LangRuScaleModifier = ruScale,
		LangDeScaleModifier = deScale,
		LangCnScaleModifier = cnScale,
		LangPlScaleModifier = plScale,
		LuaKey = "TempTextData",
		LuaValue =
		{
			TimesCleared = timesCleared,
			RecordClearTime = clearTimeText,
			RecordShrinePoints = heatClearText,
			WeaponKills = weaponKills,
		}})

	components.CurrentKeys = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
	CreateTextBox({ Id = components.CurrentKeys.Id,
		Text = "MetaUpgrade_Available_SuperKeys",
		FontSize = 24,
		Width = 0,
		OffsetX = 500,
		OffsetY = -400,
		Color = Color.White,
		Font = "AlegreyaSansSCRegular",
		ShadowBlur = 0,
		ShadowColor = {0,0,0,1},
		ShadowOffset={0, 2},
		Justification = "Right",
		LuaKey = "TempTextData",
		LuaValue = { Amount = tostring(GameState.Resources.SuperLockKeys)}
	})

	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoud" })

	thread( PlayVoiceLines, GlobalVoiceLines.OpenedWeaponUpgradeMenuVoiceLines, true )

	for itemIndex, itemData in pairs( WeaponUpgradeData[weaponName] ) do
		local purchaseButtonKey = "PurchaseButton"..itemIndex
		local animationName = "BoonSlot" .. itemIndex .. "_WeaponSelect"
		if IsBuyWeaponUpgradeDisabled( weaponName, itemIndex ) and IsUpgradeWeaponUpgradeDisabled( weaponName, itemIndex ) then
			animationName = "BoonSlot4_WeaponSelect"
		end
		components[purchaseButtonKey] = CreateScreenComponent({ Name = animationName, Group = "Combat_Menu_TraitTray", X = ScreenCenterX + 40, Y = 20 + itemIndex * 220})
		SetScaleX({ Id = components[purchaseButtonKey].Id, Fraction = 1 })
		SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = 700})

		-- Upgrade description
		local itemName = "UnknownUpgrade"
		local itemIcon = "WeaponUpgrade_Unknown"
		local traitData = {}
		if itemData.DisableBuy then
			itemName = itemData.LockedUpgradeId or "UnknownUpgrade"
			itemIcon = "WeaponUpgrade_Unknown"
		elseif itemData.GameStateRequirements and ( not IsGameStateEligible(CurrentRun, itemData.GameStateRequirements) or IsGameStateEligible(CurrentRun, itemData.GameStateRequirements) and not GameState.SeenWeaponUnlocks[weaponName..itemIndex]) then
			itemName = "UnknownLockedAspect"
			itemIcon = "WeaponUpgrade_Unknown"

			if IsGameStateEligible(CurrentRun, itemData.GameStateRequirements) and not GameState.SeenWeaponUnlocks[weaponName..itemIndex] then
				thread( WeaponAspectRevealPresentation, components, itemData.TraitName, purchaseButtonKey)
				GameState.SeenWeaponUnlocks[weaponName..itemIndex] = true
			end
		elseif itemData.TraitName == nil then
			if itemData.RequiredInvestmentTraitName then
				itemName = itemData.RequiredInvestmentTraitName
				itemIcon = TraitData[itemName].Icon .. "_Large"
				if GetWeaponUpgradeLevel(weaponName, itemIndex) > 0  then
					traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemName, Rarity = GetRarityKey(GetWeaponUpgradeLevel( weaponName, itemIndex ))})
					SetTraitTextData( traitData )
				else
					itemName = itemData.UpgradeUnequippedId
				end
			else
				itemName = itemData.UpgradeUnequippedId or "NothingEquipped"
				itemIcon = "WeaponUpgrade_Unknown"
			end
		else
			itemName = itemData.TraitName
			itemIcon = TraitData[itemName].Icon .. "_Large"
			traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemName, Rarity = GetRarityKey(GetWeaponUpgradeLevel( weaponName, itemIndex ))})
			SetTraitTextData( traitData )

			if itemData.MaxedTraitDescription and IsWeaponUpgradeUnlocked( weaponName, itemIndex ) and not CanUpgradeWeaponUpgrade( weaponName, itemIndex ) then
				itemName = itemData.MaxedTraitDescription
			end
		end

		components[purchaseButtonKey.."Icon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
		Attach({ Id = components[purchaseButtonKey.."Icon"].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = 365 - 750, OffsetY = 0 })
		SetAnimation({ DestinationId = components[purchaseButtonKey.."Icon"].Id, Name = itemIcon })
		if itemIcon ~= "WeaponUpgrade_Unknown" then
			SetScale({ Id = components[purchaseButtonKey.."Icon"].Id, Fraction = 1.0 })
		end

		CreateTextBoxWithFormat(MergeTables({ Id = components[purchaseButtonKey].Id,
			Text = itemName,
			OffsetX = 465 - 700 + textOffsetX, OffsetY = -35,
			Width = 665,
			Justification = "Left",
			VerticalJustification = "Top",
			LineSpacingBottom = 5,
			UseDescription = true,
			Format = "BaseFormat",
			VariableAutoFormat = "BoldFormatGraft",
			TextSymbolScale = 0.8,
			LuaKey = "TooltipData",
			LuaValue = traitData,
		}, LocalizationData.WeaponUpgradeScripts.WeaponDescription))

		if traitData and traitData.LimitedTime then
			CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = "SeasonalItem", Color = Color.Transparent })
		end

		components[purchaseButtonKey.."Frame"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
		Attach({ Id = components[purchaseButtonKey.."Frame"].Id, DestinationId = components[purchaseButtonKey.."Icon"].Id, OffsetX = 0, OffsetY = 0 })
		SetAnimation({ DestinationId = components[purchaseButtonKey.."Frame"].Id, Name = "Frame_Boon_Menu_Enchantment" })
		SetScale({ Id = components[purchaseButtonKey.."Frame"].Id, Fraction = 1.0 })

		components[purchaseButtonKey].OnPressedFunctionName = "HandleWeaponUpgradeSelection"
		components[purchaseButtonKey].UpgradeButtonKey = purchaseButtonKey .. "Upgrade"
		components[purchaseButtonKey].WeaponName = weaponName
		components[purchaseButtonKey].Data = itemData
		components[purchaseButtonKey].Index = itemIndex

		components[purchaseButtonKey.."Subtitle"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
		Attach({ Id = components[purchaseButtonKey.."Subtitle"].Id, DestinationId = components[purchaseButtonKey.."Icon"].Id, OffsetX = 710, OffsetY = 33 })
		CreateTextBox({ Id = components[purchaseButtonKey.."Subtitle"].Id,
			FontSize = 24,
			Width = 0,
			OffsetX =  0,
			OffsetY = 0,
			Color = Color.White,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0,
			ShadowColor = {0,0,0,1},
			ShadowOffset={0, 2},
			Justification = "Right",
			LuaKey = "TempTextData",
			LuaValue = { Amount = GetNextWeaponUpgradeKeyCost( weaponName, itemIndex )}})

		components[purchaseButtonKey .. "Title"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
		Attach({ Id = components[purchaseButtonKey.."Title"].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = textOffsetX, OffsetY = 0 })

		CreateTextBox(MergeTables({ Id = components[purchaseButtonKey .. "Title"].Id,
			Text = itemName,
			FontSize = 25,
			OffsetX = 465 - 700, OffsetY = -78,
			Width = 615,
			Color = Color.White,
			Font = "AlegreyaSansSCBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Left",
			VerticalJustification = "Top"
		}, LocalizationData.WeaponUpgradeScripts.WeaponDisplayName))

		components[purchaseButtonKey .. "Level"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
		Attach({ Id = components[purchaseButtonKey.."Level"].Id, DestinationId = components[purchaseButtonKey.."Title"].Id, OffsetX = 0, OffsetY = -75 })

		CreateTextBox({ Id = components[purchaseButtonKey .. "Level"].Id,
			FontSize = 25,
			OffsetX = 400, OffsetY = 0,
			Width = 615,
			Color = Color.White,
			Font = "AlegreyaSansSCBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Right",
			VerticalJustification = "Top",
			LuaKey = "TempTextData",
			LuaValue = { Amount = GetWeaponUpgradeLevel(weaponName, itemIndex )}})

		-- LOCK Icons
		local lockIconKey = "LockIcon"..itemIndex
		components[lockIconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = 0, Group = "Combat_Menu_TraitTray" })
		Attach({ Id = components[lockIconKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = 365 - 753, OffsetY = -5 })
		if not IsWeaponUpgradeUnlocked( weaponName, itemIndex ) then
			SetColor({ Id = components[purchaseButtonKey.."Icon"].Id, Color = Color.DarkSlateGray })
			SetAnimation({ Name = "LockedKeepsakeIcon", DestinationId = components[lockIconKey].Id, Scale = 1.0 })
		end

		if IsWeaponUpgradeEquipped( weaponName, itemIndex ) then
			SetAnimation({ Name = "EquippedIcon", DestinationId = components[purchaseButtonKey.."Subtitle"].Id })
			TeleportCursor({ OffsetX = ScreenCenterX + 40, OffsetY = 20 + itemIndex * 220, ForceUseCheck = true })
		end

		if not IsUpgradeWeaponUpgradeDisabled( weaponName, itemIndex ) then
			if IsWeaponUpgradeUnlocked( weaponName, itemIndex ) then
				components[purchaseButtonKey .. "Upgrade" ] = CreateScreenComponent({ Name = "WeaponLevelUpArrowRight", Scale = 1.0, Group = "Combat_Menu_TraitTray" })
			else
				components[purchaseButtonKey .. "Upgrade" ] = CreateScreenComponent({ Name = "WeaponUnlockRight", Scale = 1.0, Group = "Combat_Menu_TraitTray" })
			end
			Attach({ Id = components[purchaseButtonKey .. "Upgrade"].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = 440, OffsetY = -5})
			components[purchaseButtonKey.. "Upgrade"].OnPressedFunctionName = "HandleUpgradeWeaponUpgradeSelection"
			components[purchaseButtonKey.. "Upgrade"].WeaponName = weaponName
			components[purchaseButtonKey.. "Upgrade"].Data = itemData
			components[purchaseButtonKey.. "Upgrade"].Index = itemIndex
			components[purchaseButtonKey.. "Upgrade"].Name = itemName
			components[purchaseButtonKey.."KeyCost"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
			Attach({ Id = components[purchaseButtonKey.."KeyCost"].Id, DestinationId = components[purchaseButtonKey.."Upgrade"].Id, OffsetX = 0, OffsetY = 0 })
			local text = "MetaUpgrade_Locked_SuperKeys"
			local color = Color.White
			if not CanUpgradeWeaponUpgrade( weaponName, itemIndex ) then
				text = "Blank"
				SetColor({ Id = components[purchaseButtonKey.."KeyCost"].Id, Color = Color.DarkSlateGray })
				UseableOff({ Id = components[purchaseButtonKey .. "Upgrade"].Id })
			end
			if not HasResource("SuperLockKeys", GetNextWeaponUpgradeKeyCost( weaponName, itemIndex )) then
				color = Color.CostUnaffordable
			end
			SetInteractProperty({ DestinationId = components[purchaseButtonKey.."Upgrade"].Id, Property = "TooltipOffsetX", Value = 260})
			SetInteractProperty({ DestinationId = components[purchaseButtonKey.."Upgrade"].Id, Property = "TooltipOffsetY", Value = 5})
			CreateTextBox({ Id = components[purchaseButtonKey.. "Upgrade"].Id, 
				Text = itemName,
				FontSize = 1,
				UseDescription = true,
				OffsetX = 1000, OffsetY = 0,
				Justification = "LEFT",
				Color = Color.Transparent,
				LuaKey = "TooltipData",
				LuaValue = traitData,
				ScaleTarget = 0.01,
				ScaleDuration = 0,
			})
			CreateTextBox({ Id = components[purchaseButtonKey.."KeyCost"].Id,
				Text = text,
				FontSize = 24,
				Width = 0,
				OffsetX = -4,
				OffsetY = 30,
				Color = color,
				Font = "AlegreyaSansSCBold",
				ShadowBlur = 0,
				ShadowColor = {0,0,0,1},
				ShadowOffset={0, 2},
				Justification = "Center",
				LuaKey = "TempTextData",
				LuaValue = { Amount = GetNextWeaponUpgradeKeyCost( weaponName, itemIndex ) } })

			if not CanUpgradeWeaponUpgrade( weaponName, itemIndex ) then
				ModifyTextBox({ Id = components[purchaseButtonKey.."Level"].Id, Text = "UI_TraitLevel_Max" })
			elseif GetWeaponUpgradeLevel(weaponName, itemIndex ) > 0 then
				ModifyTextBox({ Id = components[purchaseButtonKey.."Level"].Id, Text = "UI_TraitLevel", LuaKey = "TempTextData", LuaValue = { Amount = GetWeaponUpgradeLevel(weaponName, itemIndex )} })
			end
		end

		wait(0.02)
	end

	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Scale = 0.7, Group = "Combat_Menu_TraitTray_Overlay" })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = 0 , OffsetY = 515 })
	components.CloseButton.OnPressedFunctionName = "CloseWeaponUpgradeScreen"
	components.CloseButton.ControlHotkey = "Cancel"

	ScreenAnchors.WeaponUpgradeScreen.KeepOpen = true
	ScreenAnchors.WeaponUpgradeScreen.CanClose = true
	thread( HandleWASDInput, ScreenAnchors.WeaponUpgradeScreen )
	HandleScreenInput( ScreenAnchors.WeaponUpgradeScreen )
end

function UpdateWeaponUpgradeButtons( weaponName, lastEquippedIndex )
	local components = ScreenAnchors.WeaponUpgradeScreen.Components
	for itemIndex, itemData in pairs( WeaponUpgradeData[weaponName] ) do
		local purchaseButtonKey = "PurchaseButton"..itemIndex

		if not IsUpgradeWeaponUpgradeDisabled( weaponName, itemIndex ) and not IsBuyWeaponUpgradeDisabled( weaponName, itemIndex ) then
			if not CanUpgradeWeaponUpgrade( weaponName, itemIndex ) then
				ModifyTextBox({ Id = components[purchaseButtonKey.."KeyCost"].Id, Text = "Blank" })
				SetColor({ Id = components[purchaseButtonKey.."KeyCost"].Id, Color = Color.DarkSlateGray })
				UseableOff({ Id = components[purchaseButtonKey .. "Upgrade"].Id })
			else
				ModifyTextBox({ Id = components[purchaseButtonKey.."KeyCost"].Id,
					Text = "MetaUpgrade_Locked_SuperKeys",
					LuaKey = "TempTextData",
					LuaValue = { Amount = GetNextWeaponUpgradeKeyCost( weaponName, itemIndex )}})
				if not HasResource("SuperLockKeys", GetNextWeaponUpgradeKeyCost( weaponName, itemIndex )) then
					ModifyTextBox({ Id = components[purchaseButtonKey.."KeyCost"].Id, ColorTarget = Color.CostUnaffordable, ColorDuration = 0.25 })
				end
			end
		end

		local traitData = {}
		if not IsBuyWeaponUpgradeDisabled( weaponName, itemIndex ) then
			if itemData.RequiredInvestmentTraitName then
				itemName = itemData.RequiredInvestmentTraitName
				if GetWeaponUpgradeLevel(weaponName, itemIndex) > 0  then
					traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemName, Rarity = GetRarityKey(GetWeaponUpgradeLevel( weaponName, itemIndex ))})
					SetTraitTextData( traitData )
				end
			end
			if itemData.TraitName then
				traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.TraitName, Rarity = GetRarityKey(GetWeaponUpgradeLevel( weaponName, itemIndex )) })
				SetTraitTextData( traitData )
			end

			if traitData.Name then
				ModifyTextBox({ Id = components[purchaseButtonKey].Id, UseDescription = true, Text = traitData.Name, LuaKey = "TooltipData", LuaValue = traitData, ExcludeText = "SeasonalItem" })
			end
		end

		if not CanUpgradeWeaponUpgrade( weaponName, itemIndex ) then
			if IsWeaponUpgradeMaxed( weaponName, itemIndex ) then
				ModifyTextBox({ Id = components[purchaseButtonKey.."Level"].Id, Text = "UI_TraitLevel_Max" })
			end
		elseif GetWeaponUpgradeLevel(weaponName, itemIndex ) > 0 then
			ModifyTextBox({ Id = components[purchaseButtonKey.."Level"].Id, Text = "UI_TraitLevel", LuaKey = "TempTextData", LuaValue = { Amount = GetWeaponUpgradeLevel(weaponName, itemIndex )} })
		end

		if IsWeaponUpgradeEquipped( weaponName, itemIndex ) then
			if itemIndex ~= lastEquippedIndex then

				SetAnimation({ Name = "EquippedIcon", DestinationId = components[purchaseButtonKey.."Subtitle"].Id })
				PlaySound({ Name = WeaponUpgradeData[weaponName][itemIndex].EquipSound or "/Leftovers/SFX/PerfectTiming" })
				thread( PlayVoiceLines, GlobalVoiceLines.SwitchedWeaponUpgradeVoiceLines, true )
			end
		else
			SetAnimation({ Name = "Blank", DestinationId = components[purchaseButtonKey.."Subtitle"].Id })
			ModifyTextBox({ Id = components[purchaseButtonKey.."Subtitle"].Id, Text = "Blank" })
		end
	end
end

function GetEquippedWeaponTraitIndex( weaponName )
	if not GameState.LastWeaponUpgradeData[weaponName] then
		return 1
	end
	return GameState.LastWeaponUpgradeData[weaponName].Index
end

function GetWeaponUpgradeLevel( weaponName, itemIndex )
	if weaponName == nil then
		return 0
	end
	if IsBuyWeaponUpgradeDisabled( weaponName, itemIndex ) or IsUpgradeWeaponUpgradeDisabled( weaponName, itemIndex ) then
		return 0
	end
	local nextIndex = 0
	if GameState.WeaponUnlocks[weaponName] and GameState.WeaponUnlocks[weaponName][itemIndex] then
		nextIndex = GameState.WeaponUnlocks[weaponName][itemIndex]
	end
	return nextIndex
end

function CanUpgradeWeaponUpgrade( weaponName, itemIndex )

	if IsBuyWeaponUpgradeDisabled( weaponName, itemIndex ) or IsUpgradeWeaponUpgradeDisabled( weaponName, itemIndex ) then
		return false
	end
	local nextIndex = GetWeaponUpgradeLevel( weaponName, itemIndex ) + 1

	if nextIndex > WeaponUpgradeData[weaponName][itemIndex].MaxUpgradeLevel then
		return false
	end
	return true
end

function GetNextWeaponUpgradeKeyCost( weaponName, itemIndex )
	local nextIndex = GetWeaponUpgradeLevel( weaponName, itemIndex ) + 1
	if WeaponUpgradeData[weaponName][itemIndex].Costs and WeaponUpgradeData[weaponName][itemIndex].Costs[nextIndex] then
		return WeaponUpgradeData[weaponName][itemIndex].Costs[nextIndex]
	else
		return nextIndex
	end
end

function IsWeaponUpgradeEquipped( weaponName, itemIndex )
	if IsBuyWeaponUpgradeDisabled( weaponName, itemIndex ) then
		return false
	end
	if not GameState.LastWeaponUpgradeData[weaponName] then
		return itemIndex == 1
	end
	return GameState.LastWeaponUpgradeData[weaponName].Index == itemIndex
end

function IsWeaponUpgradeUnlocked( weaponName, index )
	if WeaponUpgradeData[weaponName][index].StartsUnlocked then
		return true
	end

	if not GameState.WeaponUnlocks[weaponName] then
		return false
	end
	return GameState.WeaponUnlocks[weaponName][index] ~= nil and GameState.WeaponUnlocks[weaponName][index] ~= 0
end

function IsWeaponUpgradeMaxed( weaponName, index )

	if IsBuyWeaponUpgradeDisabled( weaponName, index ) then
		return false
	end
	if not GameState.WeaponUnlocks then
		return false
	end
	if not GameState.WeaponUnlocks[weaponName] then
		return false
	end
	if GameState.WeaponUnlocks[weaponName][index] ~= 5 then
		return false
	end

	return true
end

function IsBuyWeaponUpgradeDisabled( weaponName, index )
	if WeaponUpgradeData[weaponName][index].DisableBuy then
		return true
	end
	if WeaponUpgradeData[weaponName][index].GameStateRequirements and not IsGameStateEligible( CurrentRun, WeaponUpgradeData[weaponName][index].GameStateRequirements) then
		return true
	end
	return false
end

function IsUpgradeWeaponUpgradeDisabled( weaponName, index )
	if WeaponUpgradeData[weaponName][index].DisableUpgrade then
		return true
	end
	if WeaponUpgradeData[weaponName][index].GameStateRequirements and not IsGameStateEligible(CurrentRun, WeaponUpgradeData[weaponName][index].GameStateRequirements) then
		return true
	end
	return false
end

function GetNumUnlockedWeaponUpgrades()
	local numUpgrades = 0
	for weaponName, weaponUpgradeData in pairs( WeaponUpgradeData ) do
		for index in pairs( weaponUpgradeData ) do
			if IsWeaponUpgradeUnlocked( weaponName, index ) and not WeaponUpgradeData[weaponName][index].StartsUnlocked then
				numUpgrades = numUpgrades + 1
			end
		end
	end
	return numUpgrades
end

function GetNumMaxedWeaponUpgrades()
	local numUpgrades = 0
	for weaponName, weaponUpgradeData in pairs( WeaponUpgradeData ) do
		for index in pairs( weaponUpgradeData ) do
			if IsWeaponUpgradeMaxed( weaponName, index ) then
				numUpgrades = numUpgrades + 1
			end
		end
	end
	return numUpgrades
end

function UnlockOrIncreaseWeaponUpgrade( screen, weaponName, index )
	local unlockWeapon = false
	if not GameState.WeaponUnlocks[weaponName] then
		GameState.WeaponUnlocks[weaponName] = {}
	end
	if not GameState.WeaponUnlocks[weaponName][index] then
		GameState.WeaponUnlocks[weaponName][index] = 0
		unlockWeapon = true
	end
	GameState.WeaponUnlocks[weaponName][index] = GameState.WeaponUnlocks[weaponName][index] + 1
	if IsWeaponUpgradeEquipped( weaponName, index) or unlockWeapon then
		SelectWeaponUpgrade( screen, weaponName, index )
	end

	GameState.LastInteractedWeaponUpgrade = { WeaponName = weaponName, ItemIndex = index }
	CheckAchievement({ Name = "ActUnlockedAllAspects" })

	if IsScreenOpen( "WeaponUpgradeScreen" ) then
		local purchaseButtonKey = "PurchaseButton"..index
		SetColor({ Id = ScreenAnchors.WeaponUpgradeScreen.Components[purchaseButtonKey.."Icon"].Id, Color = Color.White, })
		ScreenAnchors.WeaponUpgradeScreen.HasChanges = true

		ModifyTextBox({
			Id = ScreenAnchors.WeaponUpgradeScreen.Components.CurrentKeys.Id,
			Text = "MetaUpgrade_Available_SuperKeys",
			LuaKey = "TempTextData",
			LuaValue = { Amount = tostring(GameState.Resources.SuperLockKeys)}
		})

		if unlockWeapon then
			local components = ScreenAnchors.WeaponUpgradeScreen.Components
			local upgradeComponent = CreateScreenComponent({ Name = "WeaponLevelUpArrowRight", Scale = 1.0, Group = "Combat_Menu_TraitTray" })
			Attach({ Id = upgradeComponent.Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = 440, OffsetY = -5})
			upgradeComponent.OnPressedFunctionName = "HandleUpgradeWeaponUpgradeSelection"
			upgradeComponent.WeaponName = components[purchaseButtonKey .. "Upgrade" ].WeaponName
			upgradeComponent.Data = components[purchaseButtonKey .. "Upgrade" ].Data
			upgradeComponent.Index = components[purchaseButtonKey .. "Upgrade" ].Index
			local traitData = {}
			if upgradeComponent.Data.TraitName then
				traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = upgradeComponent.Data.TraitName, Rarity = GetRarityKey(GetWeaponUpgradeLevel( weaponName, index )) })
				SetTraitTextData( traitData )
			end

			SetInteractProperty({ DestinationId = upgradeComponent.Id, Property = "TooltipOffsetX", Value = 260})
			SetInteractProperty({ DestinationId = upgradeComponent.Id, Property = "TooltipOffsetY", Value = 5})
			CreateTextBox({ Id = upgradeComponent.Id, Text = components[purchaseButtonKey .. "Upgrade" ].Name,
				FontSize = 1,
				UseDescription = true,
				OffsetX = 1000, OffsetY = 0,
				Justification = "LEFT",
				Color = Color.Transparent,
				LuaKey = "TooltipData",
				LuaValue = traitData,
				ScaleTarget = 0.01,
				ScaleDuration = 0,
			})

			Attach({ Id = components[purchaseButtonKey.."KeyCost"].Id, DestinationId = upgradeComponent.Id, OffsetX = 0, OffsetY = 0 })

			Destroy({ Id = components[purchaseButtonKey .. "Upgrade" ].Id })
			components[purchaseButtonKey .. "Upgrade" ] = upgradeComponent

			PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3" })
			thread( PlayVoiceLines, GlobalVoiceLines.WeaponUpgradePurchasedVoiceLines, true )
		end
	end
end

function SelectWeaponUpgrade( screen, weaponName, itemIndex )

	local upgradeData = WeaponUpgradeData[weaponName][1]
	if GameState.LastWeaponUpgradeData and GameState.LastWeaponUpgradeData[weaponName] ~= nil then
		-- unequip trait
		RemoveTrait( CurrentRun.Hero, GetWeaponUpgradeTrait(weaponName, GameState.LastWeaponUpgradeData[weaponName].Index) )
		
		upgradeData = WeaponUpgradeData[weaponName][GameState.LastWeaponUpgradeData[weaponName].Index]
	end

	if upgradeData ~= nil and upgradeData.UnequipFunctionName and _G[upgradeData.UnequipFunctionName] then
		_G[upgradeData.UnequipFunctionName]( CurrentRun.Hero )
	end

	UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })
	local weaponSetNames = WeaponSets.HeroWeaponSets[weaponName]
	if weaponSetNames ~= nil then
		for k, linkedWeaponName in ipairs( weaponSetNames ) do
			UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName })
		end
	end

	EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })

	if weaponSetNames ~= nil then
		for k, linkedWeaponName in ipairs( weaponSetNames ) do
			EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName })
		end
	end

	--equip trait
	GameState.LastWeaponUpgradeData[weaponName] = { Index = itemIndex }
	EquipWeaponUpgrade( existingHero, { SkipTraitHighlight = true })
	GameState.LastInteractedWeaponUpgrade = { WeaponName = weaponName, ItemIndex = itemIndex }
	if weaponName == "GunWeapon" then
		thread( UpdateGunUI )
	end

	if IsScreenOpen( "WeaponUpgradeScreen" ) then
		thread( SwitchWeaponImage, ScreenAnchors.WeaponUpgradeScreen.Components.WeaponImage.Id, GetWeaponAspectImage( weaponName ))
		ScreenAnchors.WeaponUpgradeScreen.ChangedEquipment = itemIndex ~= ScreenAnchors.WeaponUpgradeScreen.OpenedEquippedIndex
	end

	screen.AspectChanged = true

end

function HandleWeaponUpgradeSelection( screen, button )
	local weaponName = button.WeaponName
	local itemData = button.Data
	local itemIndex = button.Index
	local lastEquippedIndex = GetEquippedWeaponTraitIndex( weaponName )

	if IsWeaponUpgradeUnlocked( weaponName, itemIndex ) then
		-- equip weapon upgrade
		if itemIndex ~= lastEquippedIndex then
			SelectWeaponUpgrade( screen, weaponName, itemIndex)
			UpdateWeaponUpgradeButtons( weaponName, lastEquippedIndex )
		end
	elseif IsBuyWeaponUpgradeDisabled( weaponName, itemIndex ) then
		Flash({ Id = button.Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
		PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
		thread( PlayVoiceLines, HeroVoiceLines.InvalidInteractionVoiceLines, true )
	elseif not IsWeaponUpgradeUnlocked(weaponName, itemIndex) and HasResource( "SuperLockKeys", GetNextWeaponUpgradeKeyCost( weaponName, itemIndex ) ) and not IsBuyWeaponUpgradeDisabled( weaponName, itemIndex ) then
		local components = ScreenAnchors.WeaponUpgradeScreen.Components
		Flash({ Id = components[button.UpgradeButtonKey].Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostCantPurchase, ExpireAfterCycle = true })
		PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	else
		Flash({ Id = button.Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
		PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
		if CheckCountInWindow( "TriedUnlock", 1.0, 3 ) then
			thread( PlayVoiceLines, HeroVoiceLines.WeaponUpgradeLockedVoiceLines, true )
		end
	end
end

function HandleUpgradeWeaponUpgradeSelection( screen, button )
	local weaponName = button.WeaponName
	local itemData = button.Data
	local itemIndex = button.Index
	local lastEquippedIndex = GetEquippedWeaponTraitIndex( weaponName )
	GameState.LastInteractedWeaponUpgrade = { WeaponName = weaponName, ItemIndex = itemIndex }

	if CanUpgradeWeaponUpgrade( weaponName, itemIndex ) and HasResource( "SuperLockKeys", GetNextWeaponUpgradeKeyCost( weaponName, itemIndex ) ) and not IsBuyWeaponUpgradeDisabled( weaponName, itemIndex ) then
		SpendResource( "SuperLockKeys", GetNextWeaponUpgradeKeyCost( weaponName, itemIndex ), "WeaponUpgradeUnlock" )
		UnlockOrIncreaseWeaponUpgrade( screen, weaponName, itemIndex )

		Flash({ Id = button.Id, Speed = 1, MinFraction = 1, MaxFraction = 0.0, Color = Color.White, ExpireAfterCycle = true })
		CreateAnimation({ Name = "BoonGet", DestinationId = button.Id, Scale = 1.0, GroupName = "Combat_Menu_TraitTray_Additive", Color = Color.Red, OffsetX = -500 })
		PlaySound({ Name = "/Leftovers/Menu Sounds/TeamWipe2" })
		PlaySound({ Name = "/Leftovers/SFX/AnnouncementThunder" })
		thread( PlayVoiceLines, GlobalVoiceLines.UpgradedWeaponUpgradePurchasedVoiceLines, true )
		SetColor({ Id = ScreenAnchors.WeaponUpgradeScreen.Components["PurchaseButton" ..itemIndex.."Icon"].Id, Color = Color.White })
		SetAnimation({ DestinationId = ScreenAnchors.WeaponUpgradeScreen.Components["LockIcon" .. itemIndex].Id, Name = "LockedIconReleaseWeapon" })
		UpdateWeaponUpgradeButtons( weaponName, lastEquippedIndex )
		ShowNextUpgrade( button )
	elseif CanUpgradeWeaponUpgrade( weaponName, itemIndex ) and not HasResource( "SuperLockKeys", GetNextWeaponUpgradeKeyCost( weaponName, itemIndex ) ) and not IsBuyWeaponUpgradeDisabled( weaponName, itemIndex ) then
		if not IsWeaponUpgradeUnlocked( weaponName, itemIndex ) and CheckCountInWindow( "TriedUnlock", 1.0, 3 ) then
			thread( PlayVoiceLines, HeroVoiceLines.WeaponUpgradeLockedVoiceLines, true )
		elseif CheckCountInWindow( "MaxButtonPress", 1.0, 2 ) then
			thread( PlayVoiceLines, HeroVoiceLines.NotEnoughSuperLockKeysVoiceLines, true )
		end
		Flash({ Id = button.Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
		PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	else
		if not CanUpgradeWeaponUpgrade( weaponName, itemIndex ) and CheckCountInWindow( "MaxButtonPress", 1.0, 2 ) then
			thread( PlayVoiceLines, HeroVoiceLines.InvalidInteractionVoiceLines, true )
		end
		Flash({ Id = button.Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
		PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	end
end

function CloseWeaponUpgradeScreen( screen )
	if ScreenAnchors.WeaponUpgradeScreen == nil or not ScreenAnchors.WeaponUpgradeScreen.CanClose then
		return
	end
	ScreenAnchors.WeaponUpgradeScreen.KeepOpen = false
	ScreenAnchors.WeaponUpgradeScreen.CanClose = false
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

	DisableShopGamepadCursor( ScreenAnchors.WeaponUpgradeScreen.Name )
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16.0 })

	SetAnimation({ DestinationId = ScreenAnchors.WeaponUpgradeScreen.Components.ShopBackground.Id, Name = "WeaponSelectPanelBoxOut" })

	local currentWeaponInSlot = GetEquippedWeapon()
	local weaponData = WeaponData[currentWeaponInSlot]
	local weaponDataOverride = GetWeaponData( CurrentRun.Hero, currentWeaponInSlot )
	local closeAnim = weaponData.PostWeaponUpgradeScreenAnimation
	local closeAngle = weaponData.PostWeaponUpgradeScreenAngle or 290
	local closeFunctionName = weaponData.PostWeaponUpgradeScreenFunctionName
	for k, trait in pairs( CurrentRun.Hero.Traits ) do
		closeAnim = trait.PostWeaponUpgradeScreenAnimation or closeAnim
		closeAngle = trait.PostWeaponUpgradeScreenAngle or closeAngle
		closeFunctionName = trait.PostWeaponUpgradeScreenFunctionName or closeFunctionName
	end
	if closeFunctionName ~= nil and _G[closeFunctionName] ~= nil then
		_G[closeFunctionName]( CurrentRun.Hero )
	end
	if screen.AspectChanged and weaponDataOverride.WeaponBinks ~= nil then
		PreLoadBinks({ Names = weaponDataOverride.WeaponBinks, Cache = "WeaponCache", Reset = true })
		SessionState.NeedWeaponPickupBinkLoad = true
	end
	if closeAnim ~= nil then
		SetGoalAngle({ Id = CurrentRun.Hero.ObjectId, Angle = closeAngle, CompleteAngle = true })
		SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = closeAnim })
	end

	CloseScreen( GetAllIds( ScreenAnchors.WeaponUpgradeScreen.Components ), 0.15 )
	-- check if player equipped a different trait since opening screen
	if ScreenAnchors.WeaponUpgradeScreen.HasChanges or ScreenAnchors.WeaponUpgradeScreen.ChangedEquipment then
		thread( PlayVoiceLines, GlobalVoiceLines.ClosedWeaponUpgradeMenuVoiceLines, false )
		if MapState.WeaponKits ~= nil then
			for kitId, kitData in pairs( MapState.WeaponKits ) do
				if kitData ~= nil and kitData.Name == currentWeaponInSlot then
					StopAnimation({ Name = "WeaponBonusFxBack", DestinationId = kitId })
					if IsWeaponUnused( weaponData.Name ) and GetWeaponKitAnimation( weaponData.Name, "BonusEquipped" ) ~= nil then
						SetAnimation({ Name = GetWeaponKitAnimation( weaponData.Name, "BonusEquipped" ), DestinationId = kitId })
					elseif GetWeaponKitAnimation( weaponData.Name, "Equipped" ) ~= nil then
						SetAnimation({ Name = GetWeaponKitAnimation( weaponData.Name, "Equipped" ), DestinationId = kitId })
					end
				end
			end
		end
	end

	UnfreezePlayerUnit("WeaponUpgradeScreen")
	OnScreenClosed({Flag = "WeaponUpgradeScreen"})
	ScreenAnchors.WeaponUpgradeScreen = nil
	wait( 0.3 )
	CheckAutoObjectiveSets( CurrentRun, "WeaponPickup" )
end

function EquipLastWeaponUpgrade( eventSource, hero )
	local existingHero = CurrentRun.Hero or hero
	EquipWeaponUpgrade( existingHero )
end

function GetEquippedWeapon()
	for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
		if CurrentRun.Hero.Weapons[weaponName] then
			return weaponName
		end
	end
end

function GetWeaponUpgradeTrait( weapon, index )
	if weapon == nil or index == nil then
		return nil
	end
	if WeaponUpgradeData[weapon][index].TraitName then
		return WeaponUpgradeData[weapon][index].TraitName
	elseif  WeaponUpgradeData[weapon][index].RequiredInvestmentTraitName and GetWeaponUpgradeLevel(weapon, index) > 0 then
		return WeaponUpgradeData[weapon][index].RequiredInvestmentTraitName
	end
	return nil
end

function GetWeaponKitAnimation( weaponName, type )
	local referencedTable = WeaponData[weaponName]
	if GetEquippedWeaponTraitIndex( weaponName) > 1 then
		referencedTable = WeaponUpgradeData[weaponName][GameState.LastWeaponUpgradeData[weaponName].Index]
	end
	
	if type == "Equipped" then
		return referencedTable.EquippedKitAnimation
	elseif type == "Unequipped" then
		return referencedTable.UnequippedKitAnimation
	elseif type == "BonusUnequipped" then
		return referencedTable.BonusUnequippedKitAnimation
	elseif type == "BonusEquipped" then
		return referencedTable.BonusEquippedKitAnimation
	end

end

function UnequipWeaponUpgrade()
	local currentWeaponInSlot = GetEquippedWeapon()
	if GameState.LastWeaponUpgradeData[currentWeaponInSlot] ~= nil and GetWeaponUpgradeTrait(currentWeaponInSlot, GameState.LastWeaponUpgradeData[currentWeaponInSlot].Index) then
		if GetWeaponUpgradeTrait(currentWeaponInSlot, GameState.LastWeaponUpgradeData[currentWeaponInSlot].Index) then
			RemoveTrait( CurrentRun.Hero, GetWeaponUpgradeTrait(currentWeaponInSlot, GameState.LastWeaponUpgradeData[currentWeaponInSlot].Index) )

			local upgradeData = WeaponUpgradeData[currentWeaponInSlot][GameState.LastWeaponUpgradeData[currentWeaponInSlot].Index]
			if upgradeData ~= nil and upgradeData.UnequipFunctionName and _G[upgradeData.UnequipFunctionName] then
				_G[upgradeData.UnequipFunctionName]( CurrentRun.Hero )
			end
		end
	end
end

function EquipWeaponUpgrade( hero, args )
	local currentWeaponInSlot = GetEquippedWeapon()
	args = args or {}
	local skipTraitHighlight = args.SkipTraitHighlight or false
	--equip trait
	if GameState.LastWeaponUpgradeData[ currentWeaponInSlot ] and GetWeaponUpgradeTrait(currentWeaponInSlot, GameState.LastWeaponUpgradeData[currentWeaponInSlot].Index) and not HeroHasTrait(GetWeaponUpgradeTrait(currentWeaponInSlot, GameState.LastWeaponUpgradeData[currentWeaponInSlot].Index)) then
		AddTraitToHero({ SkipNewTraitHighlight = skipTraitHighlight, TraitName = GetWeaponUpgradeTrait(currentWeaponInSlot, GameState.LastWeaponUpgradeData[currentWeaponInSlot].Index), Rarity = GetRarityKey(GetWeaponUpgradeLevel(currentWeaponInSlot, GetEquippedWeaponTraitIndex( currentWeaponInSlot ))) })
	end
	GameState.LastInteractedWeaponUpgrade = { WeaponName = currentWeaponInSlot, ItemIndex = GetEquippedWeaponTraitIndex( currentWeaponInSlot ) }
end

function GetWeaponAspectImage( weaponName )
	return WeaponUpgradeData[weaponName][GetEquippedWeaponTraitIndex( weaponName )].Image
end

OnMouseOver{ "WeaponLevelUpArrowRight",
	function( triggerArgs )
		if triggerArgs.triggeredById == nil or not IsScreenOpen("WeaponUpgradeScreen") or ScreenAnchors.WeaponUpgradeScreen == nil then
			return
		end

		local component = nil
		for itemIndex, itemData in pairs( WeaponUpgradeData[GetEquippedWeapon()] ) do
			local purchaseKey = "PurchaseButton"..itemIndex.."Upgrade"
			component = ScreenAnchors.WeaponUpgradeScreen.Components[purchaseKey]
			if component and component.Id == triggerArgs.triggeredById then
				break
			end
		end

		if component == nil then
			return
		end

		ShowNextUpgrade( component )
	end
}

function ShowNextUpgrade( component )
	local itemData = component.Data
	local weaponName = component.WeaponName
	local itemIndex = component.Index
	local traitData = nil
	local parentPurchaseKey = "PurchaseButton" .. itemIndex
	local getWeaponUpgradeLevel = GetWeaponUpgradeLevel( weaponName, itemIndex )

	if IsWeaponUpgradeUnlocked( weaponName, itemIndex ) then
		if CanUpgradeWeaponUpgrade( weaponName, itemIndex ) then
			if itemData.RequiredInvestmentTraitName then
				if GetWeaponUpgradeLevel(weaponName, itemIndex) == 0 then
					itemName = itemData.RequiredInvestmentTraitName
					traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemName, Rarity = GetRarityKey( 1 + getWeaponUpgradeLevel)})
					SetTraitTextData( traitData )
				else
					itemName = itemData.RequiredInvestmentTraitName
					traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemName, Rarity = GetRarityKey( getWeaponUpgradeLevel)})
					local newTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemName, Rarity = GetRarityKey( 1 + getWeaponUpgradeLevel ) })
					SetTraitTextData( traitData, { ReplacementTraitData = newTraitData } )
				end
			end
			if itemData.TraitName then
				traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.TraitName, Rarity = GetRarityKey( getWeaponUpgradeLevel ) })
				local newTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.TraitName, Rarity = GetRarityKey( 1 + getWeaponUpgradeLevel ) })
				SetTraitTextData( traitData, { ReplacementTraitData = newTraitData } )
			end

			if traitData.Name then
				local traitName = traitData.Name .. "_Delta"
				ModifyTextBox({ Id = ScreenAnchors.WeaponUpgradeScreen.Components[parentPurchaseKey].Id, UseDescription = true, Text = traitName, LuaKey = "TooltipData", LuaValue = traitData, ExcludeText = "SeasonalItem" })
				ModifyTextBox({ Id = ScreenAnchors.WeaponUpgradeScreen.Components[parentPurchaseKey.."Level"].Id, Text = "UI_TraitLevel_Upgrade",  LuaKey = "TempTextData", LuaValue = {  OldLevel = getWeaponUpgradeLevel, NewLevel = 1 + getWeaponUpgradeLevel } })
				ModifyTextBox({ Id = ScreenAnchors.WeaponUpgradeScreen.Components[parentPurchaseKey .. "Title"].Id, ColorTarget = Color.UpgradeGreen, ColorDuration = 0.25 })
			end
		else
			DestroyTextBox({ Id = ScreenAnchors.WeaponUpgradeScreen.Components[parentPurchaseKey.."KeyCost"].Id })
			if itemData.MaxedTraitDescription then
				if itemData.TraitName then
					traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.TraitName, Rarity = GetRarityKey( getWeaponUpgradeLevel )})
					SetTraitTextData( traitData, { ReplacementTraitData = newTraitData } )
				end
			
				ModifyTextBox({ Id = ScreenAnchors.WeaponUpgradeScreen.Components[parentPurchaseKey].Id, UseDescription = true, Text = itemData.MaxedTraitDescription , LuaKey = "TooltipData", LuaValue = traitData, ExcludeText = "SeasonalItem" })
			end
		end
	end
end

OnMouseOff{ "WeaponLevelUpArrowRight",
	function( triggerArgs )
		if IsScreenOpen("WeaponUpgradeScreen") then
			local component = nil
			local parentPurchaseKey = ""
			for itemIndex, itemData in pairs( WeaponUpgradeData[GetEquippedWeapon()] ) do
				local purchaseKey = "PurchaseButton"..itemIndex.."Upgrade"
				component = ScreenAnchors.WeaponUpgradeScreen.Components[purchaseKey]
				if component and component.Id == triggerArgs.triggeredById then
					parentPurchaseKey = "PurchaseButton"..itemIndex
					break
				end
			end

			if component == nil then
				return
			end

			local itemData = component.Data
			local weaponName = component.WeaponName
			local itemIndex = component.Index
			local traitData = nil

			if itemData.TraitName == nil then
				if itemData.RequiredInvestmentTraitName then
					itemName = itemData.RequiredInvestmentTraitName
					itemIcon = TraitData[itemName].Icon .. "_Large"
					if GetWeaponUpgradeLevel(weaponName, itemIndex) > 0 then
						traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemName, Rarity = GetRarityKey(GetWeaponUpgradeLevel( weaponName, itemIndex ))})
						SetTraitTextData( traitData )
					else
						itemName = itemData.UpgradeUnequippedId
					end
				else
					itemName = itemData.UpgradeUnequippedId or "UnknownUpgrade"
					itemIcon = "WeaponUpgrade_Unknown"
				end
			else
				itemName = itemData.TraitName
				itemIcon = TraitData[itemName].Icon .. "_Large"
				traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemName, Rarity = GetRarityKey(GetWeaponUpgradeLevel( weaponName, itemIndex ))})
				SetTraitTextData( traitData )
			end

			if itemData.MaxedTraitDescription and IsWeaponUpgradeUnlocked( weaponName, itemIndex ) and not CanUpgradeWeaponUpgrade( weaponName, itemIndex ) then
				itemName = itemData.MaxedTraitDescription
			elseif traitData ~= nil then
				itemName = traitData.Name
			end
			if ScreenAnchors.WeaponUpgradeScreen.Components[parentPurchaseKey] then
				ModifyTextBox({ Id =  ScreenAnchors.WeaponUpgradeScreen.Components[parentPurchaseKey].Id, UseDescription = true, Text = itemName, LuaKey = "TooltipData", LuaValue = traitData, ExcludeText = "SeasonalItem" })
				if GetWeaponUpgradeLevel( weaponName, itemIndex ) > 0 then
					if not CanUpgradeWeaponUpgrade( weaponName, itemIndex ) then
						ModifyTextBox({ Id = ScreenAnchors.WeaponUpgradeScreen.Components[parentPurchaseKey.."Level"].Id, Text = "UI_TraitLevel_Max" })
					else
						ModifyTextBox({ Id = ScreenAnchors.WeaponUpgradeScreen.Components[parentPurchaseKey.."Level"].Id, Text = "UI_TraitLevel",  LuaKey = "TempTextData", LuaValue = {  Amount = GetWeaponUpgradeLevel( weaponName, itemIndex ) }, ColorTarget = Color.White, ColorDuration = 0.25 })
					end
				else
					ModifyTextBox({ Id = ScreenAnchors.WeaponUpgradeScreen.Components[parentPurchaseKey.."Level"].Id, Text = " ", })
				end
				ModifyTextBox({ Id = ScreenAnchors.WeaponUpgradeScreen.Components[parentPurchaseKey .. "Title"].Id, ColorTarget = Color.White, ColorDuration = 0.25 })
			end
		end
	end
}
