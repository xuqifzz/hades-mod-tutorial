function ShowRunClearScreen()

	PlaySound({ Name = "/Leftovers/Menu Sounds/AscensionConfirm" })

	RecordRunCleared()

	thread( PlayVoiceLines, HeroVoiceLines.RunClearedVoiceLines )

	ScreenAnchors.RunClear = { Components = {} }
	local screen = ScreenAnchors.RunClear
	screen.Name = "RunClear"

	if IsScreenOpen( screen.Name ) then
		return
	end
	OnScreenOpened({ Flag = screen.Name, PersistCombatUI = true })
	FreezePlayerUnit()
	EnableShopGamepadCursor()

	ToggleControl({ Names = { "AdvancedTooltip" }, Enabled = false })
	thread( ShowAdvancedTooltip, { DontDuckAudio = true, DisableTooltips = true, HideCloseButton = true, AutoPin = true, } )

	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelIn" })

	CreateGroup({ Name = "Combat_Menu_Overlay2" })
	InsertGroupInFront({ Name = "Combat_Menu_Overlay2", DestinationName = "Combat_Menu_Overlay" })

	local components = screen.Components

	components.Blackout = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_UI_Backing", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = components.Blackout.Id, Fraction = 10 })
	SetColor({ Id = components.Blackout.Id, Color = Color.Black })
	SetAlpha({ Id = components.Blackout.Id, Fraction = 0 })
	SetAlpha({ Id = components.Blackout.Id, Fraction = 0.6, Duration = 0.5 })

	components.ShopBackground = CreateScreenComponent({ Name = "EndPanelBox", Group = "Combat_Menu_Overlay2", X = ScreenCenterX + 637, Y = ScreenCenterY - 30 })
	for cosmeticName, status in pairs( GameState.Cosmetics ) do
		local cosmeticData = ConditionalItemData[cosmeticName]
		if cosmeticData ~= nil and cosmeticData.RunClearScreenBacking ~= nil then
			SetAnimation({ DestinationId = components.ShopBackground.Id, Name = cosmeticData.RunClearScreenBacking })
			break
		end
	end
	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Group = "Combat_Menu_TraitTray", Scale = 0.7 })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = 3, OffsetY = 480 })
	components.CloseButton.OnPressedFunctionName = "CloseRunClearScreen"
	components.CloseButton.ControlHotkey = "Cancel"

	-- Title
	CreateTextBox(MergeTables({ Id = components.ShopBackground.Id,
		Text = "RunClearScreen_Title",
		FontSize = 32,
		Font = "SpectralSCLightTitling",
		OffsetX = -4, OffsetY = -370,
		Color = Color.White,
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3}, Justification = "Center",
		}, LocalizationData.RunClearScreen.TitleText))

	local messageOffsetX = -255
	local statOffsetX = 100

	local recordTime = GetFastestRunClearTime( CurrentRun )
	local prevRecordShrinePoints = GetHighestShrinePointRunClear()

	local offsetY = -325

	local lineSpacingLarge = 55
	local lineSpacingSmall = 35

	local mainFontSize = 19
	local titleColor = Color.White
	local dataColor = {0.702, 0.620, 0.345, 1.0}
	local newRecordColor = {1.000, 0.894, 0.231, 1.0}

	-- ClearTime
	offsetY = offsetY + lineSpacingLarge
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = "RunClearScreen_ClearTime",
		FontSize = mainFontSize,
		OffsetX = messageOffsetX, OffsetY = offsetY,
		Color = titleColor,
		Font = "AlegreyaSansSCRegular",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Left" })
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = GetTimerString( CurrentRun.GameplayTime, 2 ),
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })
	if CurrentRun.GameplayTime <= recordTime then
		wait(0.03)
		CreateTextBox(MergeTables({ Id = components.ShopBackground.Id,
			Text = "RunClearScreen_NewRecord",
			FontSize = mainFontSize,
			OffsetX = statOffsetX + 20, OffsetY = offsetY,
			Color = newRecordColor,
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Left" }, LocalizationData.RunClearScreen.NewRecordText))
	end

	wait(0.05)

	-- Record Clear Time
	offsetY = offsetY + lineSpacingSmall
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = "RunClearScreen_ClearTimeRecord",
		FontSize = mainFontSize,
		OffsetX = messageOffsetX, OffsetY = offsetY,
		Color = titleColor,
		Font = "AlegreyaSansSCRegular",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Left" })
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = GetTimerString( recordTime, 2 ),
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })

	-- ShrinePoints
	offsetY = offsetY + lineSpacingLarge
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = "RunClearScreen_ShrinePoints",
		FontSize = mainFontSize,
		OffsetX = messageOffsetX, OffsetY = offsetY,
		Color = titleColor,
		Font = "AlegreyaSansSCRegular",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Left" })
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = CurrentRun.ShrinePointsCache,
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })
	if CurrentRun.ShrinePointsCache > prevRecordShrinePoints then
		wait(0.03)
		CreateTextBox(MergeTables({ Id = components.ShopBackground.Id,
			Text = "RunClearScreen_NewRecord",
			FontSize = mainFontSize,
			OffsetX = statOffsetX + 20, OffsetY = offsetY,
			Color = newRecordColor,
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Left" }, LocalizationData.RunClearScreen.NewRecordText))
	end

	wait(0.05)

	-- Record ShrinePoints
	offsetY = offsetY + lineSpacingSmall
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = "RunClearScreen_ShrinePointsRecord",
		FontSize = mainFontSize,
		OffsetX = messageOffsetX, OffsetY = offsetY,
		Color = titleColor,
		Font = "AlegreyaSansSCRegular",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Left" })
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = math.max( CurrentRun.ShrinePointsCache, prevRecordShrinePoints ),
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })

	wait(0.03)

	-- Weapon Clears
	offsetY = offsetY + 90

	local columnHeaders =
	{
		{ OffsetX = 0, Text = "RunClearScreen_Header_Weapon", Justification = "Left", },
		{ OffsetX = 254, Text = "RunClearScreen_Header_Clears", Justification = "Right", },
		{ OffsetX = 384, Text = "RunClearScreen_Header_RecordClearTime", Justification = "Right", },
		{ OffsetX = 496, Text = "RunClearScreen_Header_RecordShrinePoints", Justification = "Right", },
	}

	for k, header in ipairs( columnHeaders ) do
		CreateTextBox(MergeTables({ Id = components.ShopBackground.Id,
				Text = header.Text,
				FontSize = mainFontSize,
				OffsetX = messageOffsetX + header.OffsetX, OffsetY = offsetY,
				Color = Color.White,
				Font = "AlegreyaSansSCExtraBold",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = header.Justification }, LocalizationData.RunClearScreen.ColumnHeader))
	end

	offsetY = offsetY + lineSpacingLarge
	wait(0.05)

	for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do

		local weaponNameFont = "AlegreyaSansSCRegular"
		if CurrentRun.Hero.Weapons[weaponName] then
			-- Currently used weapon
			weaponNameFont = "AlegreyaSansSCExtraBold"
		end

		local weaponText = weaponName
		if not IsWeaponUnlocked( weaponName ) then
			weaponText = "MysteryUpgrade"
		end

		CreateTextBox(MergeTables({ Id = components.ShopBackground.Id,
			Text = weaponText,
			FontSize = mainFontSize,
			OffsetX = messageOffsetX + columnHeaders[1].OffsetX, OffsetY = offsetY,
			Color = {0.569, 0.557, 0.533, 1.0},
			Font = weaponNameFont,
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = columnHeaders[1].Justification }, LocalizationData.RunClearScreen.WeaponText))

		local weaponClears = GetNumRunsClearedWithWeapon( weaponName )
		CreateTextBox(MergeTables({ Id = components.ShopBackground.Id,
			Text = weaponClears,
			FontSize = mainFontSize,
			OffsetX = messageOffsetX + columnHeaders[2].OffsetX, OffsetY = offsetY,
			Color = dataColor,
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = columnHeaders[2].Justification }, LocalizationData.RunClearScreen.WeaponText))

		local weaponTime = GetFastestRunClearTimeWithWeapon( CurrentRun, weaponName )
		if weaponTime ~= nil then
			CreateTextBox(MergeTables({ Id = components.ShopBackground.Id,
				Text = GetTimerString( weaponTime, 2 ),
				FontSize = mainFontSize,
				OffsetX = messageOffsetX + columnHeaders[3].OffsetX, OffsetY = offsetY,
				Color = dataColor,
				Font = "AlegreyaSansSCExtraBold",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = columnHeaders[3].Justification }, LocalizationData.RunClearScreen.WeaponText))
		end

		local weaponShrinePoints = GetHighestShrinePointRunClearWithWeapon( CurrentRun, weaponName )
		if weaponShrinePoints > 0 then
			CreateTextBox(MergeTables({ Id = components.ShopBackground.Id,
				Text = weaponShrinePoints,
				FontSize = mainFontSize,
				OffsetX = messageOffsetX + columnHeaders[4].OffsetX - 10, OffsetY = offsetY,
				Color = dataColor,
				Font = "AlegreyaSansSCExtraBold",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = columnHeaders[4].Justification }, LocalizationData.RunClearScreen.WeaponText))
			end

		offsetY = offsetY + ( lineSpacingSmall * 1.1 )
		wait(0.03)

	end

	wait(0.05)

	-- Total Clears
	offsetY = offsetY + 67
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = "RunClearScreen_TotalClears",
		FontSize = mainFontSize,
		OffsetX = messageOffsetX, OffsetY = offsetY,
		Color = titleColor,
		Font = "AlegreyaSansSCRegular",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Left" })
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = GameState.TimesCleared,
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })

	-- Consecutive Clears
	offsetY = offsetY + lineSpacingSmall
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = "RunClearScreen_ClearStreak",
		FontSize = mainFontSize,
		OffsetX = messageOffsetX, OffsetY = offsetY,
		Color = titleColor,
		Font = "AlegreyaSansSCRegular",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Left" })
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = GameState.ConsecutiveClears,
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })
	if GameState.ConsecutiveClears >= GameState.ConsecutiveClearsRecord then
		wait(0.03)
		CreateTextBox(MergeTables({ Id = components.ShopBackground.Id,
			Text = "RunClearScreen_NewRecord",
			FontSize = mainFontSize,
			OffsetX = statOffsetX + 20, OffsetY = offsetY,
			Color = newRecordColor,
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Left" }, LocalizationData.RunClearScreen.NewRecordText))
	end

	wait(0.05)

	-- Consecutive Clears Record
	offsetY = offsetY + lineSpacingSmall
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = "RunClearScreen_ClearStreakRecord",
		FontSize = mainFontSize,
		OffsetX = messageOffsetX, OffsetY = offsetY,
		Color = titleColor,
		Font = "AlegreyaSansSCRegular",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Left" })
	CreateTextBox({ Id = components.ShopBackground.Id,
		Text = GameState.ConsecutiveClearsRecord,
		FontSize = mainFontSize,
		OffsetX = statOffsetX, OffsetY = offsetY,
		Color = dataColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right" })

	-- Clear Message
	local priorityEligibleMessages = {}
	local eligibleMessages = {}
	for name, message in pairs( GameData.RunClearMessageData ) do
		if IsGameStateEligible( CurrentRun, message.GameStateRequirements ) then
			if message.Priority then
				table.insert( priorityEligibleMessages, message )
			else
				table.insert( eligibleMessages, message )
			end
		end
	end
	local message = nil
	if not IsEmpty( priorityEligibleMessages ) then
		message = GetRandomValue( priorityEligibleMessages )
	else
		message = GetRandomValue( eligibleMessages )
	end
	if message ~= nil then
		CurrentRun.RunClearMessage = message
		RunClearMessagePresentation( screen, message )
	end

	HandleScreenInput( screen )

end

function CloseRunClearScreen( )
	local screen = ScreenAnchors.RunClear
	DisableShopGamepadCursor()
	CloseAdvancedTooltipScreen()
	CloseScreen( GetAllIds( screen.Components ) )
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	UnfreezePlayerUnit()
	ToggleControl({ Names = { "AdvancedTooltip" }, Enabled = true })
	screen.KeepOpen = false
	OnScreenClosed({ Flag = screen.Name })
end
