function ShowRunHistoryScreen()

	local screen = DeepCopyTable( ScreenData.RunHistory )
	screen.Components = {}
	local components = screen.Components

	OnScreenOpened({ Flag = screen.Name, PersistCombatUI = true })
	FreezePlayerUnit()
	EnableShopGamepadCursor()
	ToggleControl({ Names = { "AdvancedTooltip" }, Enabled = false })

	RunHistoryScreenOpenPresentation( screen )

	local components = screen.Components

	components.Blackout = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_UI_Backing", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = components.Blackout.Id, Fraction = 10 })
	SetColor({ Id = components.Blackout.Id, Color = Color.Black })
	SetAlpha({ Id = components.Blackout.Id, Fraction = 0 })
	SetAlpha({ Id = components.Blackout.Id, Fraction = 0.6, Duration = 0.5 })

	components.ShopBackground = CreateScreenComponent({ Name = "EndPanelBox", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY - 30 })
	SetAnimation({ DestinationId = components.ShopBackground.Id, Name = "Box_RunHistoryScreen" })

	components.DynamicTextAnchor = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY - 30 })

	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Group = "Combat_Menu_TraitTray", Scale = 0.7 })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = 0, OffsetY = 520 })
	components.CloseButton.OnPressedFunctionName = "CloseRunHistoryScreen"
	components.CloseButton.ControlHotkey = "Cancel"

	-- Title
	CreateTextBox({ Id = components.CloseButton.Id,
		Text = "RunHistoryScreen_Title",
		FontSize = 32,
		Font = "SpectralSCLightTitling",
		OffsetX = 0, OffsetY = -945,
		Color = Color.White,
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3}, Justification = "Center",
		LangFrScaleModifier = 0.9,
		LangEsScaleModifier = 0.85,
		LangPlScaleModifier = 0.75,
		})
	CreateTextBox({ Id = components.CloseButton.Id,
		Text = "RunHistoryScreen_Subtitle_Old",
		FontSize = 15,
		OffsetX = 0, OffsetY = -905,
		Width = 840,
		Color = Color.SubTitle,
		Font = "CrimsonTextItalic",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 1},
		Justification = "Center"
		})

	screen.Components.ScrollLeft = CreateScreenComponent({ Name = "ButtonRunHistoryLeft", X = ScreenCenterX - 520, Y = 310, Scale = 1.0, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu_Overlay2" })
	screen.Components.ScrollLeft.OnPressedFunctionName = "RunHistoryPrevRun"
	screen.Components.ScrollLeft.ControlHotkeys = { "MenuLeft", "Left", "MenuDown", }
	SetInteractProperty({ DestinationId = screen.Components.ScrollLeft.Id, Property = "FreeFormSelectable", Value = false })

	screen.Components.ScrollRight = CreateScreenComponent({ Name = "ButtonRunHistoryRight", X = ScreenCenterX + 478, Y = 310, Scale = 1.0, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu_Overlay2" })
	screen.Components.ScrollRight.OnPressedFunctionName = "RunHistoryNextRun"
	screen.Components.ScrollRight.ControlHotkeys = { "MenuRight", "Right", "MenuUp" }
	SetInteractProperty({ DestinationId = screen.Components.ScrollRight.Id, Property = "FreeFormSelectable", Value = false })

	screen.RunIndex = #GameState.RunHistory + 1
	RunHistoryUpdateArrows( screen )
	ShowRunHistory( screen, GameState.RunHistory[screen.RunIndex] or CurrentRun, screen.RunIndex, { FirstSetup = true } )
	wait( 0.01 )

	HandleScreenInput( screen )

end

function ShowRunHistory( screen, run, index, args )

	args = args or {}

	local components = screen.Components

	local messageOffsetX = -420
	local statOffsetX = 380

	local offsetY = -385

	local lineSpacingLarge = 52
	local lineSpacingSmall = 32

	local mainFontSize = 19
	local titleColor = Color.White
	local dataColor = {0.702, 0.620, 0.345, 1.0}
	local newRecordColor = {1.000, 0.894, 0.231, 1.0}

	DestroyTextBox({ Id = components.DynamicTextAnchor.Id })
	Destroy({ Ids = screen.IconIds })

	ShowRunHistoryPresentation( screen, run, index )

	-- Number
	offsetY = offsetY + lineSpacingLarge
	if args.FirstSetup then
		CreateTextBox({ Id = components.ShopBackground.Id,
			Text = "RunHistoryScreen_Num",
			FontSize = mainFontSize,
			OffsetX = messageOffsetX, OffsetY = offsetY,
			Color = titleColor,
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Left" })
	end
	CreateTextBox({ Id = components.DynamicTextAnchor.Id,
		Text = "{#UseMoneyFormat}#"..index,
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })

	-- Result
	offsetY = offsetY + lineSpacingSmall
	if args.FirstSetup then
		CreateTextBox({ Id = components.ShopBackground.Id,
			Text = "RunHistoryScreen_Result",
			FontSize = mainFontSize,
			OffsetX = messageOffsetX, OffsetY = offsetY,
			Color = titleColor,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Left" })
	end
	local resultText = "RunHistoryScreen_Cleared"
	if not run.Cleared then
		local roomData = RoomData[run.EndingRoomName]
		if roomData ~= nil then
			resultText = roomData.ResultText
		else
			resultText = "RunHistoryScreen_Missing"
		end
	end
	CreateTextBox({ Id = components.DynamicTextAnchor.Id,
		Text = resultText,
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })

	if run.EasyModeLevel ~= nil then
		CreateTextBox({ Id = components.DynamicTextAnchor.Id,
			Text = "RunClearScreen_EasyModeLevel",
			FontSize = mainFontSize,
			OffsetX = statOffsetX + 40, OffsetY = offsetY,
			Color = Color.Red,
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Left" })
	end

	-- ClearTime
	offsetY = offsetY + lineSpacingSmall
	if args.FirstSetup then
		CreateTextBox({ Id = components.ShopBackground.Id,
			Text = "RunHistoryScreen_Time",
			FontSize = mainFontSize,
			OffsetX = messageOffsetX, OffsetY = offsetY,
			Color = titleColor,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Left" })
	end
	local timerString = "RunHistoryScreen_Missing"
	if run.GameplayTime ~= nil then
		timerString = GetTimerString( run.GameplayTime, 2 )
	end
	CreateTextBox({ Id = components.DynamicTextAnchor.Id,
		Text = timerString,
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })

	offsetY = offsetY + lineSpacingSmall

	-- Weapon
	offsetY = offsetY + lineSpacingLarge
	local weaponNameFont = "AlegreyaSansSCRegular"
	if args.FirstSetup then
		CreateTextBox({ Id = components.ShopBackground.Id,
			Text = "RunHistoryScreen_Weapon",
			FontSize = mainFontSize,
			OffsetX = messageOffsetX, OffsetY = offsetY,
			Color = titleColor,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Left" })
	end
	local weaponText = "RunHistoryScreen_Missing"
	if run.WeaponsCache ~= nil then
		for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
			if run.WeaponsCache[weaponName] then
				weaponText = weaponName
			end
		end
	end
	CreateTextBox({ Id = components.DynamicTextAnchor.Id,
		Text = weaponText,
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })

	-- Aspect
	offsetY = offsetY + lineSpacingSmall
	if args.FirstSetup then
		CreateTextBox({ Id = components.ShopBackground.Id,
			Text = "RunHistoryScreen_Aspect",
			FontSize = mainFontSize,
			OffsetX = messageOffsetX, OffsetY = offsetY,
			Color = titleColor,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Left" })
	end
	local aspectText = "RunHistoryScreen_Missing"
	if run.TraitCache ~= nil then
		for traitName, count in pairs( run.TraitCache ) do
			local traitData = TraitData[traitName]
			if traitData ~= nil and traitData.IsWeaponEnchantment then
				aspectText = traitName
				break
			end
		end
	end
	CreateTextBox({ Id = components.DynamicTextAnchor.Id,
		Text = aspectText,
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })

	-- Keepsake
	offsetY = offsetY + lineSpacingSmall
	if args.FirstSetup then
		CreateTextBox({ Id = components.ShopBackground.Id,
			Text = "RunHistoryScreen_Keepsake",
			FontSize = mainFontSize,
			OffsetX = messageOffsetX, OffsetY = offsetY,
			Color = titleColor,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Left" })
	end
	local keepsakeText = "RunHistoryScreen_Missing"
	if run.EndingKeepsakeName ~= nil then
		keepsakeText = run.EndingKeepsakeName
	elseif run.TraitCache ~= nil then
		for traitName, count in pairs( run.TraitCache ) do
			local traitData = TraitData[traitName]
			if traitData ~= nil and traitData.Slot == "Keepsake" then
				keepsakeText = traitName
				break
			end
		end
	end
	CreateTextBox({ Id = components.DynamicTextAnchor.Id,
		Text = keepsakeText,
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })

	-- Assist
	offsetY = offsetY + lineSpacingSmall
	if args.FirstSetup then
		CreateTextBox({ Id = components.ShopBackground.Id,
			Text = "RunHistoryScreen_Assist",
			FontSize = mainFontSize,
			OffsetX = messageOffsetX, OffsetY = offsetY,
			Color = titleColor,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Left" })
	end
	local assistText = "RunHistoryScreen_Missing"
	if run.TraitCache ~= nil then
		for traitName, count in pairs( run.TraitCache ) do
			local traitData = TraitData[traitName]
			if traitData ~= nil and traitData.Slot == "Assist" then
				assistText = traitName
				break
			end
		end
	end
	CreateTextBox({ Id = components.DynamicTextAnchor.Id,
		Text = assistText,
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })

	-- Traits
	offsetY = offsetY + screen.TraitColumnOffsetY
	if args.FirstSetup then
		CreateTextBox({ Id = components.ShopBackground.Id,
			Text = "RunHistoryScreen_Traits",
			FontSize = mainFontSize * 1.5,
			OffsetX = 0, OffsetY = offsetY - 35,
			Color = titleColor,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
			Justification = "Center" })
	end
	screen.IconIds = {}
	if run.TraitCache ~= nil then
		local offsetX = screen.TraitColumnStartX
		local startOffsetY = offsetY
		local columnCount = 0

		local sortedTraits = {}
		for traitName, count in pairs( run.TraitCache ) do
			table.insert( sortedTraits, { Name = traitName, Count = count } )
		end
		table.sort( sortedTraits, RunHistoryTraitSort )
		local columnIndex = 0
		for k, sortedTrait in pairs( sortedTraits ) do
			local traitData = TraitData[sortedTrait.Name]
			if traitData ~= nil and traitData.Icon ~= nil and not traitData.IsWeaponEnchantment and traitData.Slot ~= "Keepsake" and traitData.Slot ~= "Assist" then
				offsetY = offsetY + (lineSpacingSmall * 1.2)

				local iconKey = "Icon"..traitData.Name
				components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Scale = 0.5 })
				SetAnimation({ DestinationId = components[iconKey].Id , Name = traitData.Icon.."_Small" })
				Attach({ Id = components[iconKey].Id, DestinationId = components.DynamicTextAnchor.Id, OffsetX = offsetX, OffsetY = offsetY })
				table.insert( screen.IconIds, components[iconKey].Id )

				local traitText = "RunHistoryScreen_Trait"
				if sortedTrait.Count > 1 then
					traitText = "RunHistoryScreen_TraitLeveled"
				end

				CreateTextBox({ Id = components.DynamicTextAnchor.Id,
					Text = traitText,
					LuaKey = "TempTextData",
					LuaValue = { Name = sortedTrait.Name, Level = sortedTrait.Count },
					FontSize = 20,
					OffsetX = offsetX + 30, OffsetY = offsetY,
					Color = {0.8, 0.8, 0.8, 1.0},
					Font = weaponNameFont,
					ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					Justification = "Left" })

				columnCount = columnCount + 1
				if columnCount >= screen.TraitsPerColumn then
					offsetX = offsetX + GetLocalizedValue(nil, screen.TraitColumnSpacing)
					offsetY = startOffsetY
					columnCount = 0
					columnIndex = columnIndex + 1
				end
				if columnIndex >= screen.MaxColumns then
					break
				end
			end
		end
	else
		CreateTextBox({ Id = components.DynamicTextAnchor.Id,
			Text = "RunHistoryScreen_Missing",
			FontSize = 20,
			OffsetX = 0, OffsetY = 100,
			Color = {0.569, 0.557, 0.533, 1.0},
			Font = weaponNameFont,
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Center" })
	end

	-- Clear Message
	if run.RunClearMessage ~= nil then
		thread( RunClearMessagePresentation, screen, GameData.RunClearMessageData[run.RunClearMessage.Name], { Delay = 0, Silent = true, OffsetX = 0, OffsetY = -225, ComponentId = components.DynamicTextAnchor.Id } )
	end

	-- MetaUpgrades
	local offsetX = 320
	local offsetY = 900
	run.MetaUpgradeCache = run.MetaUpgradeCache or {}
	if run.ShrinePointsCache ~= nil and run.ShrinePointsCache > 0 then
		components.ShrineUpgradeBacking = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Backing", X = offsetX, Y = offsetY, Scale = 0.5, })
		table.insert( screen.IconIds, components.ShrineUpgradeBacking.Id )
		CreateTextBox({ Id = components.ShrineUpgradeBacking.Id,
			Text = "RunHistory_ActiveShrinePoints",
			FontSize = 22,
			OffsetX = 20, OffsetY = 0,
			Color = titleColor,
			Font = "AlegreyaSansSCBold",
			LuaKey = "TempTextData", LuaValue = { ShrinePointsCache = run.ShrinePointsCache },
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Left" })
		SetAnimation({ DestinationId = components.ShrineUpgradeBacking.Id, Name = "MetaUpgradeTrayBacking" })
		offsetX = offsetX + 190
		for k, upgradeName in ipairs( ShrineUpgradeOrder ) do
			local upgradeData = MetaUpgradeData[upgradeName]
			components["ShrineIcon"..k] = CreateScreenComponent({ Name = "TraitTrayMetaUpgradeIconButton", Group = "Combat_Menu_TraitTray", X = offsetX, Y = offsetY })
			table.insert( screen.IconIds, components["ShrineIcon"..k].Id )
			SetAnimation({ DestinationId = components["ShrineIcon"..k].Id, Name = upgradeData.Icon })
			local numUpgrades = run.MetaUpgradeCache[upgradeName] or 0
			if numUpgrades > 0 then
				local totalStatChange = GetTotalStatChange( upgradeData, numUpgrades )
				local text = GetMetaUpgradeShortTotalText( upgradeData, true, numUpgrades )
				CreateTextBox({
					Id = components["ShrineIcon"..k].Id,
					Text = text,
					LuaKey = "TempTextData",
					LuaValue = { Amount = totalStatChange },
					FontSize = 18,
					OffsetX = 20, OffsetY = 12,
					Color = Color.White,
					Font = "AlegreyaSansSCBold",
					ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0,2},
					Justification = "Center",
					OutlineThickness = 2,
					OutlineColor = {0,0,0,1},
				})
			else
				UseableOff({ Id = components["ShrineIcon"..k].Id })
				SetColor({ Id = components["ShrineIcon"..k].Id, Color = {0.5, 0.55, 0.6, 0.55} })
			end
			offsetX = offsetX + 66
		end
	end
	offsetX = 320
	offsetY = offsetY + 60
	if run.MetaPointsCache ~= nil and run.MetaPointsCache > 0 then
		components.MetaUpgradeBacking = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Backing", X = offsetX, Y = offsetY, Scale = 0.5, })
		table.insert( screen.IconIds, components.MetaUpgradeBacking.Id )
		if run.MetaPointsCache ~= nil then
			CreateTextBox({ Id = components.MetaUpgradeBacking.Id,
				Text = "RunHistory_ActiveMetaPoints",
				FontSize = 22,
				OffsetX = 20, OffsetY = 0,
				Color = titleColor,
				Font = "AlegreyaSansSCBold",
				LuaKey = "TempTextData", LuaValue = { MetaPointsCache = run.MetaPointsCache },
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Left" })
		end
		SetAnimation({ DestinationId = components.MetaUpgradeBacking.Id, Name = "MetaUpgradeTrayBacking" })
		offsetX = offsetX + 190
		for k, upgradePair in ipairs( MetaUpgradeOrder ) do
			local upgradeA = upgradePair[1]
			local upgradeB = upgradePair[2]
			if run.MetaUpgradeCache[upgradeB] ~= nil then
				upgradeName = upgradeB
			else
				upgradeName = upgradeA
			end
			local upgradeData = MetaUpgradeData[upgradeName]
			components["MetaIcon"..k] = CreateScreenComponent({ Name = "TraitTrayMetaUpgradeIconButton", Group = "Combat_Menu_TraitTray", X = offsetX, Y = offsetY })
			table.insert( screen.IconIds, components["MetaIcon"..k].Id )
			SetAnimation({ DestinationId = components["MetaIcon"..k].Id, Name = upgradeData.Icon })
			local numUpgrades = run.MetaUpgradeCache[upgradeName] or 0
			if numUpgrades > 0 then
				local totalStatChange = GetTotalStatChange( upgradeData, numUpgrades )
				local text = GetMetaUpgradeShortTotalText( upgradeData, true, numUpgrades )
				CreateTextBox({
					Id = components["MetaIcon"..k].Id,
					Text = text,
					LuaKey = "TempTextData",
					LuaValue = { Amount = totalStatChange },
					FontSize = 18,
					OffsetX = 20, OffsetY = 12,
					Color = Color.White,
					Font = "AlegreyaSansSCBold",
					ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0,2},
					Justification = "Center",
					OutlineThickness = 2,
					OutlineColor = {0,0,0,1},
				})
			else
				UseableOff({ Id = components["MetaIcon"..k].Id })
				SetColor({ Id = components["MetaIcon"..k].Id, Color = {0.5, 0.55, 0.6, 0.55} })
			end
			offsetX = offsetX + 89
		end
	end

end

function RunHistoryPrevRun( screen, button )
	screen.RunIndex = screen.RunIndex - 1
	if screen.RunIndex < 1 then
		screen.RunIndex = 1
		return
	end
	RunHistoryUpdateArrows( screen, button )
	RunHistorySwitchPresentation( screen, button )
	return ShowRunHistory( screen, GameState.RunHistory[screen.RunIndex] or CurrentRun, screen.RunIndex )
end

function RunHistoryNextRun( screen, button )
	screen.RunIndex = screen.RunIndex + 1
	if screen.RunIndex > #GameState.RunHistory + 1 then
		screen.RunIndex = #GameState.RunHistory + 1
		return
	end
	RunHistoryUpdateArrows( screen, button )
	RunHistorySwitchPresentation( screen, button )
	return ShowRunHistory( screen, GameState.RunHistory[screen.RunIndex] or CurrentRun, screen.RunIndex )
end

function RunHistoryUpdateArrows( screen, button )

	local components = screen.Components
	if screen.RunIndex <= 1 then
		SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 0 })
		UseableOff({ Id = components.ScrollLeft.Id, ForceHighlightOff = true })
	else
		SetAlpha({ Id = components.ScrollLeft.Id, Fraction = 1 })
		UseableOn({ Id = components.ScrollLeft.Id })
	end

	if screen.RunIndex >= #GameState.RunHistory + 1 then
		SetAlpha({ Id = components.ScrollRight.Id, Fraction = 0 })
		UseableOff({ Id = components.ScrollRight.Id, ForceHighlightOff = true })
	else
		SetAlpha({ Id = components.ScrollRight.Id, Fraction = 1 })
		UseableOn({ Id = components.ScrollRight.Id })
	end
end

function CloseRunHistoryScreen( screen, button )
	DisableShopGamepadCursor()
	RunHistoryScreenClosedPresentation( screen, button )
	CloseScreen( GetAllIds( screen.Components ) )
	UnfreezePlayerUnit()
	ToggleControl({ Names = { "AdvancedTooltip" }, Enabled = true })
	screen.KeepOpen = false
	OnScreenClosed({ Flag = screen.Name })
end

function RunHistoryTraitSort( itemA, itemB )
	if itemA.Count ~= itemB.Count then
		return itemA.Count > itemB.Count
	end
	return itemA.Name < itemB.Name
end