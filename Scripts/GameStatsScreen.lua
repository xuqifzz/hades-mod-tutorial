function ShowGameStatsScreen()

	local screen = DeepCopyTable( ScreenData.GameStats )
	screen.Components = {}
	local components = screen.Components

	OnScreenOpened({ Flag = screen.Name, PersistCombatUI = true })
	FreezePlayerUnit()
	EnableShopGamepadCursor()
	ToggleControl({ Names = { "AdvancedTooltip" }, Enabled = false })

	local components = screen.Components

	components.Blackout = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_UI_Backing", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = components.Blackout.Id, Fraction = 10 })
	SetColor({ Id = components.Blackout.Id, Color = Color.Black })
	SetAlpha({ Id = components.Blackout.Id, Fraction = 0 })
	SetAlpha({ Id = components.Blackout.Id, Fraction = 0.6, Duration = 0.5 })

	components.ShopBackground = CreateScreenComponent({ Name = "EndPanelBox", Group = "Combat_Menu", X = ScreenCenterX, Y = ScreenCenterY - 30 })
	SetAnimation({ DestinationId = components.ShopBackground.Id, Name = "Box_FullScreen" })

	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Group = "Combat_Menu_TraitTray", Scale = 0.7 })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = 0, OffsetY = 480 })
	components.CloseButton.OnPressedFunctionName = "CloseGameStatsScreen"
	components.CloseButton.ControlHotkey = "Cancel"

	local categoryTitleX = screen.CategoryStartX
	for filterIndex, filterName in ipairs( screen.TraitFilters ) do
		screen.Components["Category"..filterName] = CreateScreenComponent({ Name = "ButtonGhostAdminTab", X = categoryTitleX, Y = screen.CategoryStartY, Scale = 1.0, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
		screen.Components["Category"..filterName].OnPressedFunctionName = "GameStatsSelectCategory"
		screen.Components["Category"..filterName].Category = filterName
		CreateTextBox(MergeTables({ Id = screen.Components["Category"..filterName].Id,
			Text = filterName,
			FontSize = 16,
			Color = Color.CodexTitleUnselected,
			Font = "AlegreyaSansSCBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Center"
		}, LocalizationData.GameStatsScreen.Nav))
		categoryTitleX = categoryTitleX + screen.CategorySpacingX
	end

	screen.Components.ScrollUp = CreateScreenComponent({ Name = "ButtonCodexUp", X = screen.CategoryStartX, Y = screen.CategoryStartY + 80, Scale = 0.75, Group = "Combat_Menu" })
	screen.Components.ScrollUp.OnPressedFunctionName = "GameStatsScrollUp"
	screen.Components.ScrollUp.ControlHotkey = "MenuUp"

	screen.Components.ScrollDown = CreateScreenComponent({ Name = "ButtonContractorDown", X = screen.CategoryStartX, Y = screen.CategoryStartY + 720, Scale = 0.75, Group = "Combat_Menu" })
	screen.Components.ScrollDown.OnPressedFunctionName = "GameStatsScrollDown"
	screen.Components.ScrollDown.ControlHotkey = "MenuDown"

	screen.Components.ScrollLeft = CreateScreenComponent({ Name = "ButtonCodexLeft", X = ScreenCenterX - 999, Y = 260, Scale = 0.75, Group = "Combat_Menu" })
	screen.Components.ScrollLeft.OnPressedFunctionName = "GameStatsPrevCategory"
	screen.Components.ScrollLeft.ControlHotkeys = { "MenuLeft", "Left" }
	SetAlpha({ Id = screen.Components.ScrollLeft.Id, Fraction = 0.01 })
	SetInteractProperty({ DestinationId = screen.Components.ScrollLeft.Id, Property = "FreeFormSelectable", Value = false })

	screen.Components.ScrollRight = CreateScreenComponent({ Name = "ButtonCodexRight", X = ScreenCenterX + 999, Y = 260, Scale = 0.75, Group = "Combat_Menu" })
	screen.Components.ScrollRight.OnPressedFunctionName = "GameStatsNextCategory"
	screen.Components.ScrollRight.ControlHotkeys = { "MenuRight", "Right" }
	SetAlpha({ Id = screen.Components.ScrollRight.Id, Fraction = 0.01 })
	SetInteractProperty({ DestinationId = screen.Components.ScrollRight.Id, Property = "FreeFormSelectable", Value = false })

	-- Title
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = "GameStatsScreen_Title",
		FontSize = 32,
		Font = "SpectralSCLightTitling",
		OffsetX = 0, OffsetY = -370,
		Color = Color.White,
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3}, Justification = "Center",
		LangFrScaleModifier = 0.9,
		LangEsScaleModifier = 0.85,
		LangPlScaleModifier = 0.75,
		})
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = "GameStatsScreen_Subtitle",
		FontSize = 15,
		OffsetX = 0, OffsetY = 420,
		Width = 840,
		Color = Color.SubTitle,
		Font = "CrimsonTextItalic",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 1},
		Justification = "Center"
		})

	CreateTextBox(MergeTables({ Id = components.ShopBackground.Id,
		Text = "GameStatsScreen_Usage",
		FontSize = 19,
		OffsetX = -240, OffsetY = -210,
		Color = Color.White,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Left" },
		LocalizationData.GameStatsScreen.WeaponTextHeader))

	-- Headers

	components.HeaderAnchor = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = screen.CategoryStartX, Y = screen.CategoryStartY + 80 })
	local columnHeaders = screen.WeaponColumnHeaders
	for k, header in ipairs( screen.WeaponColumnHeaders ) do
		CreateTextBox(MergeTables({ Id = components.HeaderAnchor.Id,
			Text = header.Text,
			FontSize = 19,
			OffsetX = header.OffsetX, OffsetY = 0,
			Color = Color.White,
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = header.Justification },
			LocalizationData.GameStatsScreen.WeaponTextHeader))
	end

	screen.RunIndex = #GameState.RunHistory + 1

	screen.CurrentFilter = screen.TraitFilters[1]
	ShowWeaponStats( screen )
	GameStatsUpdateVisibility( screen )
	GameStatsScreenOpenPresentation( screen )
	wait( 0.01 )

	HandleScreenInput( screen )

end

function ShowWeaponStats( screen )

	local components = screen.Components

	Destroy({ Ids = screen.IconIds })

	ModifyTextBox({ Id = components["Category"..screen.CurrentFilter].Id, Color = Color.White })

	local lineSpacingLarge = 55
	local lineSpacingSmall = GetLocalizedValue(35, screen.LangLineSpacingSmall)

	local mainFontSize = 19
	local titleColor = Color.White
	local dataColor = {0.702, 0.620, 0.345, 1.0}
	local newRecordColor = {1.000, 0.894, 0.231, 1.0}

	screen.IconIds = {}
	screen.NumItems = 0

	local weaponStats = {}
	local totalUseCount = 0
	local highestUseCount = 0
	for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
		weaponStats[weaponName] = {}
		weaponStats[weaponName].UseCount = GetNumRunsWithWeapon( weaponName )
		highestUseCount = math.max( highestUseCount, weaponStats[weaponName].UseCount )
		totalUseCount = totalUseCount + weaponStats[weaponName].UseCount
		weaponStats[weaponName].FastestClearTime = GetFastestRunClearTimeWithWeapon( CurrentRun, weaponName )
		weaponStats[weaponName].HighestShrinePoints = GetHighestShrinePointRunClearWithWeapon( CurrentRun, weaponName )
	end

	local offsetX = screen.TraitColumnStartX
	local offsetY = screen.TraitColumnStartY
	local startOffsetY = offsetY

	local columnHeaders = screen.WeaponColumnHeaders

	for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do

		offsetY = offsetY + ( lineSpacingSmall * 1.1 )

		local weaponNameFont = "AlegreyaSansSCRegular"
		local weaponText = weaponName
		if not IsWeaponUnlocked( weaponName ) then
			weaponText = "MysteryUpgrade"
		end

		local iconKey = "Icon"..weaponName
		components[iconKey] = CreateScreenComponent({ Name = "BiomeMap"..weaponName, Group = "Combat_Menu", Scale = 0.5 })
		local component = components[iconKey]
		Attach({ Id = component.Id, DestinationId = components.ShopBackground.Id, OffsetX = offsetX, OffsetY = offsetY })
		table.insert( screen.IconIds, component.Id )

		local columnNum = 1
		CreateTextBox(MergeTables({ Id = component.Id,
			Text = weaponText,
			FontSize = mainFontSize,
			OffsetX = 30, OffsetY = 0,
			Color = {0.569, 0.557, 0.533, 1.0},
			Font = weaponNameFont,
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = columnHeaders[columnNum].Justification },
			LocalizationData.GameStatsScreen.WeaponText))

		columnNum = columnNum + 1
		CreateTextBox({ Id = component.Id,
			Text = weaponStats[weaponName].UseCount,
			FontSize = mainFontSize,
			OffsetX = 300, OffsetY = 0,
			Color = dataColor,
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = columnHeaders[columnNum].Justification })

		columnNum = columnNum + 1
		local usageRate = weaponStats[weaponName].UseCount / highestUseCount
		local usageBar = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
		SetAnimation({ Name = "BarGraphBar", DestinationId = usageBar.Id })
		components["UsageBar"..weaponName] = usageBar
		Attach({ Id = usageBar.Id, DestinationId = component.Id, OffsetX = 310, OffsetY = 0 })
		SetScaleX({ Id = usageBar.Id, Fraction = usageRate, Duration = 0.0 })
		table.insert( screen.IconIds, usageBar.Id )

		columnNum = columnNum + 1
		local weaponClears = GetNumRunsClearedWithWeapon( weaponName )
		CreateTextBox({ Id = component.Id,
			Text = weaponClears,
			FontSize = mainFontSize,
			OffsetX = 760, OffsetY = 0,
			Color = dataColor,
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = columnHeaders[columnNum].Justification })

		columnNum = columnNum + 1
		local clearTimeColor = Color.Green
		for otherWeaponName, otherWeaponStats in pairs( weaponStats ) do
			if weaponStats[weaponName].FastestClearTime == nil or (otherWeaponName ~= weaponName and (otherWeaponStats.FastestClearTime or 999999) < weaponStats[weaponName].FastestClearTime) then
				-- Not the fastest clear
				clearTimeColor = dataColor
				break
			end
		end
		if weaponStats[weaponName].FastestClearTime ~= nil then
			CreateTextBox({ Id = component.Id,
				Text = GetTimerString( weaponStats[weaponName].FastestClearTime, 2 ),
				FontSize = mainFontSize,
				OffsetX = 950, OffsetY = 0,
				Color = clearTimeColor,
				Font = "AlegreyaSansSCExtraBold",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = columnHeaders[columnNum].Justification })
		end

		columnNum = columnNum + 1
		local shrinePointsColor = Color.Green
		for otherWeaponName, otherWeaponStats in pairs( weaponStats ) do
			if otherWeaponName ~= weaponName and otherWeaponStats.HighestShrinePoints > weaponStats[weaponName].HighestShrinePoints then
				-- Not the highest ShrinePoints
				shrinePointsColor = dataColor
				break
			end
		end
		if weaponStats[weaponName].HighestShrinePoints > 0 then
			CreateTextBox({ Id = component.Id,
				Text = weaponStats[weaponName].HighestShrinePoints or 0,
				FontSize = mainFontSize,
				OffsetX = 1100, OffsetY = 0,
				Color = shrinePointsColor,
				Font = "AlegreyaSansSCExtraBold",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = columnHeaders[columnNum].Justification })
			end

	end
end

function ShowTraitStats( screen )

	Destroy({ Ids = screen.IconIds })

	local components = screen.Components
	ModifyTextBox({ Id = components["Category"..screen.CurrentFilter].Id, Color = Color.White })

	local columnHeaders = screen.WeaponColumnHeaders

	local lineSpacingLarge = 55
	local lineSpacingSmall = GetLocalizedValue(35, screen.LangLineSpacingSmall)

	local mainFontSize = 19
	local titleColor = Color.White
	local dataColor = {0.702, 0.620, 0.345, 1.0}
	local newRecordColor = {1.000, 0.894, 0.231, 1.0}

	local traitStats = {}
	local totalTraitCache = {}
	local runsWithTraits = 0
	if CurrentRun.TraitCache ~= nil then
		runsWithTraits = runsWithTraits + 1
		for traitName, count in pairs( CurrentRun.TraitCache ) do
			traitStats[traitName] = traitStats[traitName] or {}
			totalTraitCache[traitName] = (totalTraitCache[traitName] or 0) + 1
			if CurrentRun.Cleared then
				traitStats[traitName].NumClears = (traitStats[traitName].NumClears or 0) + 1
				if CurrentRun.GameplayTime ~= nil and CurrentRun.GameplayTime < (traitStats[traitName].FastestClearTime or 999999) then
					traitStats[traitName].FastestClearTime =  CurrentRun.GameplayTime
				end
				if CurrentRun.ShrinePointsCache ~= nil and CurrentRun.ShrinePointsCache > (traitStats[traitName].HighestShrinePoints or 0) then
					traitStats[traitName].HighestShrinePoints =  CurrentRun.ShrinePointsCache
				end
			end
		end
	end
	for runIndex, run in ipairs( GameState.RunHistory ) do
		if run.TraitCache ~= nil then
			runsWithTraits = runsWithTraits + 1
			for traitName, count in pairs( run.TraitCache ) do
				traitStats[traitName] = traitStats[traitName] or {}
				totalTraitCache[traitName] = (totalTraitCache[traitName] or 0) + 1
				if run.Cleared then
					traitStats[traitName].NumClears = (traitStats[traitName].NumClears or 0) + 1
					if run.GameplayTime ~= nil and run.GameplayTime < (traitStats[traitName].FastestClearTime or 999999) then
						traitStats[traitName].FastestClearTime =  run.GameplayTime
					end
					if run.ShrinePointsCache ~= nil and run.ShrinePointsCache > (traitStats[traitName].HighestShrinePoints or 0) then
						traitStats[traitName].HighestShrinePoints =  run.ShrinePointsCache
					end
				end
			end
		end
	end

	local sortedTraits = {}
	local highestTraitCount = 0
	for traitName, count in pairs( totalTraitCache ) do
		table.insert( sortedTraits, { Name = traitName, Count = count } )
		if PassesTraitFilter( screen.CurrentFilter, traitName ) then
			highestTraitCount = math.max( highestTraitCount, count )
		end
	end
	table.sort( sortedTraits, RunHistoryTraitSort )

	screen.IconIds = {}

	local offsetX = screen.TraitColumnStartX
	local offsetY = screen.TraitColumnStartY
	local startOffsetY = offsetY
	local columnCount = 0
	screen.NumItems = 0

	for k, sortedTrait in ipairs( sortedTraits ) do
		if PassesTraitFilter( screen.CurrentFilter, sortedTrait.Name ) then
			screen.NumItems = screen.NumItems + 1
			local columnNum = 1
			if screen.NumItems > screen.ScrollOffset and screen.NumItems <= screen.ScrollOffset + GetLocalizedValue(screen.ItemsPerPage, screen.LangItemsPerPage) then
				offsetY = offsetY + (lineSpacingSmall * 1.1)

				local traitData = TraitData[sortedTrait.Name]
				local iconKey = "Icon"..traitData.Name
				components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Scale = 0.5 })
				local component = components[iconKey]
				SetAnimation({ DestinationId = component.Id, Name = traitData.Icon.."_Small" })
				Attach({ Id = component.Id, DestinationId = components.ShopBackground.Id, OffsetX = offsetX, OffsetY = offsetY })
				table.insert( screen.IconIds, component.Id )

				local traitText = "RunHistoryScreen_Trait"
				CreateTextBox(MergeTables({ Id = component.Id,
					Text = traitText,
					LuaKey = "TempTextData",
					LuaValue = { Name = sortedTrait.Name },
					FontSize = 20,
					OffsetX = 30, OffsetY = 0,
					Color = {0.569, 0.557, 0.533, 1.0},
					Font = "AlegreyaSansSCRegular",
					ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					Width = 250,
					Justification = "Left" },
					LocalizationData.GameStatsScreen.BoonText))

				columnNum = columnNum + 1
				CreateTextBox({ Id = component.Id,
					Text = sortedTrait.Count,
					FontSize = mainFontSize,
					OffsetX = 300, OffsetY = 0,
					Color = dataColor,
					Font = "AlegreyaSansSCExtraBold",
					ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					Justification = "Right" })

				columnNum = columnNum + 1
				local usageRate = sortedTrait.Count / highestTraitCount
				local usageBar = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
				SetAnimation({ Name = "BarGraphBar", DestinationId = usageBar.Id })
				components["UsageBar"..sortedTrait.Name] = usageBar
				Attach({ Id = usageBar.Id, DestinationId = component.Id, OffsetX = 310, OffsetY = 0 })
				SetScaleX({ Id = usageBar.Id, Fraction = usageRate, Duration = 0.0 })
				table.insert( screen.IconIds, usageBar.Id )
				
				columnNum = columnNum + 1
				if traitStats[traitData.Name].NumClears ~= nil then
					CreateTextBox({ Id = component.Id,
						Text = traitStats[traitData.Name].NumClears,
						FontSize = mainFontSize,
						OffsetX = 760, OffsetY = 0,
						Color = dataColor,
						Font = "AlegreyaSansSCExtraBold",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
						Justification = columnHeaders[columnNum].Justification })
				end

				columnNum = columnNum + 1
				local clearTimeColor = Color.Green
				for otherTraitName, otherTraitStats in pairs( traitStats ) do
					if traitStats[traitData.Name].FastestClearTime == nil or (otherTraitName ~= traitData.Name and (otherTraitStats.FastestClearTime or 999999) < traitStats[traitData.Name].FastestClearTime) then
						-- Not the fastest clear
						clearTimeColor = dataColor
						break
					end
				end
				if traitStats[traitData.Name].FastestClearTime ~= nil then
					CreateTextBox({ Id = component.Id,
						Text = GetTimerString( traitStats[traitData.Name].FastestClearTime, 2 ),
						FontSize = mainFontSize,
						OffsetX = 950, OffsetY = 0,
						Color = clearTimeColor,
						Font = "AlegreyaSansSCExtraBold",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
						Justification = columnHeaders[columnNum].Justification })
				end

				columnNum = columnNum + 1
				local shrinePointsColor = Color.Green
				for otherTraitName, otherTraitStats in pairs( traitStats ) do
					if otherTraitName ~= traitData.Name and (otherTraitStats.HighestShrinePoints or 0) > (traitStats[traitData.Name].HighestShrinePoints or 0) then
						-- Not the highest ShrinePoints
						shrinePointsColor = dataColor
						break
					end
				end
				if traitStats[traitData.Name].HighestShrinePoints ~= nil then
					CreateTextBox({ Id = component.Id,
						Text = traitStats[traitData.Name].HighestShrinePoints,
						FontSize = mainFontSize,
						OffsetX = 1100, OffsetY = 0,
						Color = shrinePointsColor,
						Font = "AlegreyaSansSCExtraBold",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
						Justification = columnHeaders[columnNum].Justification })
					end

			end
		end
	end

end

function PassesTraitFilter( filterName, traitName )

	local traitData = TraitData[traitName]
	if traitData == nil then
		return false
	end
	if traitData.Icon == nil then
		return false
	end

	if filterName == "GameStats_All" then
		return true
	end

	if filterName == "GameStats_RoomRewards" then
		if not traitData.IsWeaponEnchantment and traitData.Slot ~= "Keepsake" and traitData.Slot ~= "Assist" then
			return true
		end
	end

	if filterName == "GameStats_Boons" then
		if IsGodTrait( traitData.Name, { ForShop = true }) then
			return true
		end
	end

	if filterName == "GameStats_WeaponUpgrades" then
		if traitData.Frame == "Hammer" then
			return true
		end
	end

	if filterName == "GameStats_Aspects" then
		if traitData.IsWeaponEnchantment then
			return true
		end
	end

	if filterName == "GameStats_Keepsakes" then
		if traitData.Slot == "Keepsake" or traitData.Slot == "Assist" then
			return true
		end
	end

	return false

end

function GameStatsNextCategory( screen, button )
	local nextCategoryIndex = GetKey( screen.TraitFilters, screen.CurrentFilter ) + 1
	if nextCategoryIndex > #screen.TraitFilters then
		nextCategoryIndex = 1
	end
	screen.ScrollOffset = 0
	ModifyTextBox({ Id = screen.Components["Category"..screen.CurrentFilter].Id, Color = Color.CodexTitleUnselected })
	screen.CurrentFilter = screen.TraitFilters[nextCategoryIndex]
	if screen.CurrentFilter == "GameStats_Weapons" then
		ShowWeaponStats( screen )
	else
		ShowTraitStats( screen )
	end
	GameStatsUpdateVisibility( screen )
	GameStatsScreenShowCategoryPresentation( screen )
end

function GameStatsPrevCategory( screen, button )
	local nextCategoryIndex = GetKey( screen.TraitFilters, screen.CurrentFilter ) - 1
	if nextCategoryIndex < 1 then
		nextCategoryIndex = #screen.TraitFilters
	end
	screen.ScrollOffset = 0
	ModifyTextBox({ Id = screen.Components["Category"..screen.CurrentFilter].Id, Color = Color.CodexTitleUnselected })
	screen.CurrentFilter = screen.TraitFilters[nextCategoryIndex]
	if screen.CurrentFilter == "GameStats_Weapons" then
		ShowWeaponStats( screen )
	else
		ShowTraitStats( screen )
	end
	GameStatsUpdateVisibility( screen )
	GameStatsScreenShowCategoryPresentation( screen )
end

function GameStatsSelectCategory( screen, button )
	screen.ScrollOffset = 0
	ModifyTextBox({ Id = screen.Components["Category"..screen.CurrentFilter].Id, Color = Color.CodexTitleUnselected })
	screen.CurrentFilter = button.Category
	if screen.CurrentFilter == "GameStats_Weapons" then
		ShowWeaponStats( screen )
	else
		ShowTraitStats( screen )
	end
	GameStatsUpdateVisibility( screen )
	GameStatsScreenShowCategoryPresentation( screen )
end

function GameStatsUpdateVisibility( screen )
	local components = screen.Components
	if screen.ScrollOffset <= 0 then
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0 })
		UseableOff({ Id = components.ScrollUp.Id, ForceHighlightOff = true })
	else
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1 })
		UseableOn({ Id = components.ScrollUp.Id })
	end

	if screen.ScrollOffset + GetLocalizedValue(screen.ItemsPerPage, screen.LangItemsPerPage) >= screen.NumItems then
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0 })
		UseableOff({ Id = components.ScrollDown.Id, ForceHighlightOff = true })
	else
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 1 })
		UseableOn({ Id = components.ScrollDown.Id })
	end

	TeleportCursor({ OffsetX = screen.CategoryStartX, OffsetY = screen.CategoryStartY + 360 })

end

function CloseGameStatsScreen( screen, button )
	DisableShopGamepadCursor()
	GameStatScreenClosePresentation( screen, button )
	CloseScreen( GetAllIds( screen.Components ) )
	UnfreezePlayerUnit()
	ToggleControl({ Names = { "AdvancedTooltip" }, Enabled = true })
	screen.KeepOpen = false
	OnScreenClosed({ Flag = screen.Name })
end

function WeaponStatsSort( itemA, itemB )
	if itemA.UseCount ~= itemB.UseCount then
		return itemA.UseCount > itemB.UseCount
	end
	return itemA.Name < itemB.Name
end

function GameStatsScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - GetLocalizedValue(screen.ItemsPerPage, screen.LangItemsPerPage)
	ShowTraitStats( screen )
	GameStatsUpdateVisibility( screen )
	GameStatsScreenScrollPresentation( screen )
end

function GameStatsScrollDown( screen, button )
	if screen.ScrollOffset + GetLocalizedValue(screen.ItemsPerPage, screen.LangItemsPerPage) >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + GetLocalizedValue(screen.ItemsPerPage, screen.LangItemsPerPage)
	ShowTraitStats( screen )
	GameStatsUpdateVisibility( screen )
	GameStatsScreenScrollPresentation( screen )
end

