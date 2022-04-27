function UseMusicPlayer( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	local screen = OpenMusicPlayerScreen()
	UseableOn({ Id = usee.ObjectId })
	GhostAdminSessionCompletePresentation( usee, screen )
end

function OpenMusicPlayerScreen( args )

	local screen = { Components = {} }
	local components = screen.Components
	screen.Name = "MusicPlayer"
	screen.CloseAnimation = "MusicPlayerBackground_Out"

	OnScreenOpened({ Flag = screen.Name, PersistCombatUI = true })
	FreezePlayerUnit()
	EnableShopGamepadCursor()
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = true })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 32 })
	SetConfigOption({ Name = "FreeFormSelectSuccessDistanceStep", Value = 15 })

	screen.SubjectName = "MetaUpgrades"
	components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })
	components.ShopBackgroundSplatter = CreateScreenComponent({ Name = "LevelUpBackground", Group = "Combat_Menu" })
	components.ShopBackground = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })

	SetAnimation({ DestinationId = components.ShopBackground.Id, Name = "MusicPlayerBackground_In" })

	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 4 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.090, 0.055, 0.157, 0.8} })

	PlaySound({ Name = "/Leftovers/Menu Sounds/InfoPanelInURSA" })

	thread( PlayVoiceLines, GlobalVoiceLines.OpenedMusicPlayerMenuVoiceLines, true )

	-- wait for mirror animation before creating level up screen components
	wait(0.2)

	-- Title
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "MusicPlayerScreen_Title", FontSize = 34, OffsetX = 0, OffsetY = -430, Color = Color.White, Font = "SpectralSCLightTitling", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "MusicPlayerScreen_Flavor", FontSize = 15, OffsetX = 0, OffsetY = -380, Width = 840, Color = Color.Black, Font = "CrimsonTextItalic", ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2}, Justification = "Center" })

	-- Close button
	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Scale = 0.7, Group = "Combat_Menu" })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = -6, OffsetY = 456 })
	components.CloseButton.OnPressedFunctionName = "CloseMusicPlayerScreen"
	components.CloseButton.ControlHotkey = "Cancel"

	screen.TrackButtons = {}

	local startY = 220
	local ySpacing = 52
	local maxY = 900
	local columnX = 450

	local itemLocationX = ScreenCenterX - 140
	local itemLocationY = startY


	local firstUseable = false
	for k, trackName in ipairs( MusicPlayerTrackOrderData ) do

		local trackData = MusicPlayerTrackData[trackName]

		local itemBackingKey = "Backing"..k
		components[itemBackingKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX, Y = itemLocationY, Group = "Combat_Menu" })

		local graphicKey = "Graphic"..k
		components[graphicKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX, Y = itemLocationY, Scale = 0.7, Group = "Combat_Menu" })
		Attach({ Id = components[graphicKey].Id, DestinationId = components[itemBackingKey].Id, OffsetX = -265 - 30, OffsetY = -30 })

		if not GameState.Cosmetics[trackData.Name] then
			CreateTextBox(MergeTables({ Id = components[itemBackingKey].Id,
				Text = trackData.LockedTextId or string.gsub( trackData.Name, "/", "" ),
				FontSize = 26,
				OffsetX = -250, OffsetY = 0,
				Color = {0.498, 0.459, 0.408, 1.0},
				Font = "AlegreyaSansSCExtraBold",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Left" },LocalizationData.MusicPlayerScreen.LabelText))
		else

			if not GameState.MusicTracksViewed[trackData.Name] then

				-- New button
				local newButtonKey = "New button"..k
				components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
				SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "MusicPlayerNewTrack" })
				Attach({ Id = components[newButtonKey].Id, DestinationId = components[itemBackingKey].Id, OffsetX = -350, OffsetY = 0 })

				GameState.MusicTracksViewed[trackData.Name] = true
			end

			-- Play button
			local playButtonKey = "PlayButton"..k
			components[playButtonKey] = CreateScreenComponent({ Name = "ButtonPlayMusic", Scale = 0.5, Group = "Combat_Menu" })
			Attach({ Id = components[playButtonKey].Id, DestinationId = components[itemBackingKey].Id, OffsetX = -290, OffsetY = 0 })
			components[playButtonKey].OnPressedFunctionName = "HandleTrackButtonInput"
			components[playButtonKey].Data = trackData
			AttachLua({ Id = components[playButtonKey].Id, Table = trackData })
			screen.TrackButtons[k] = components[playButtonKey]

			if MusicName == trackData.Name and not MusicPlayerTrackPaused then
				SetAnimation({ DestinationId = components[playButtonKey].Id, Name = "MusicPlayerPauseButton" })
				SetInteractProperty({ DestinationId = components[playButtonKey].Id, Property = "HighlightOffAnimation", Value = "MusicPlayerPauseButton" })
				SetInteractProperty({ DestinationId = components[playButtonKey].Id, Property = "HighlightOnAnimation", Value = "MusicPlayerPauseButton_Highlight" })
			end

			CreateTextBox(MergeTables({ Id = components[playButtonKey].Id,
				Text = GetMusicTrackTitle( trackData.Name ),
				FontSize = 26,
				OffsetX = 40, OffsetY = 0,
				Color = {0.173, 0.149, 0.114, 1.0},
				Font = "AlegreyaSansSCExtraBold",
				LangDeScaleModifier = 0.75,
				LangRuScaleModifier = 0.9,
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Left"
				},LocalizationData.MusicPlayerScreen.LabelText))

			if not firstUseable then
				TeleportCursor({ OffsetX = itemLocationX - 290, OffsetY = itemLocationY, ForceUseCheck = true })
				firstUseable = true
			end
		end
		itemLocationY = itemLocationY + ySpacing
		if itemLocationY > maxY then
			itemLocationY = startY
			itemLocationX = itemLocationX + columnX
		end
	end

	-- Play/Pause button
	--components.PlayButton = CreateScreenComponent({ Name = "ButtonPlayMusic", Scale = 1.0, Group = "Combat_Menu" })
	--Attach({ Id = components.PlayButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = 0, OffsetY = 340 })
	--components.PlayButton.OnPressedFunctionName = "HandlePlayButtonInput"

	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )

end

function HandleTrackButtonInput( screen, button )
	-- Reset all other buttons
	for k, trackButton in pairs( screen.TrackButtons ) do
		if trackButton ~= button then
			SetAnimation({ DestinationId = trackButton.Id, Name = "MusicPlayerPlayButton" })
			SetInteractProperty({ DestinationId = trackButton.Id, Property = "HighlightOffAnimation", Value = "MusicPlayerPlayButton" })
			SetInteractProperty({ DestinationId = trackButton.Id, Property = "HighlightOnAnimation", Value = "MusicPlayerPlayButton_Highlight" })
		end
	end
	
	PlaySound({ Name = "/Leftovers/Menu Sounds/MenuButtonOn", Id = button.Id })

	-- Kill any MusicianMusic playing
	StopSound({ Id = AmbientMusicId, Duration = 0.3 })
	AmbientMusicId = nil
	AmbientTrackName = nil
	CurrentRun.BlockAmbientMusic = true
	if AmbientMusicSource ~= nil then
		StopAnimation({ DestinationId = AmbientMusicSource.ObjectId, Name = AmbientMusicSource.SingingFx })
	end

	if MusicName == button.Data.Name then
		if MusicPlayerTrackPaused then
			ResumeMusic()
			MusicPlayerTrackPaused = false
			SetAnimation({ DestinationId = button.Id, Name = "MusicPlayerPauseButton_Highlight" })
			SetInteractProperty({ DestinationId = button.Id, Property = "HighlightOffAnimation", Value = "MusicPlayerPauseButton" })
			SetInteractProperty({ DestinationId = button.Id, Property = "HighlightOnAnimation", Value = "MusicPlayerPauseButton_Highlight" })
		else
			PauseMusic()
			MusicPlayerTrackPaused = true
			SetAnimation({ DestinationId = button.Id, Name = "MusicPlayerPlayButton_Highlight" })
			SetInteractProperty({ DestinationId = button.Id, Property = "HighlightOffAnimation", Value = "MusicPlayerPlayButton" })
			SetInteractProperty({ DestinationId = button.Id, Property = "HighlightOnAnimation", Value = "MusicPlayerPlayButton_Highlight" })
		end
	else
		MusicPlayer( button.Data.Name )
		SetMusicSection( 9, MusicId )
		local allStems = { "Guitar", "Drums", "Bass", "Keys", "Vocals", }
		SetSoundCueValue({ Names = allStems, Id = MusicId, Value = 1, Duration = 0.0 })
		MusicActiveStems = allStems
		MusicMutedStems = nil
		MusicPlayerTrackPaused = false

		SetAnimation({ DestinationId = button.Id, Name = "MusicPlayerPauseButton_Highlight" })
		SetInteractProperty({ DestinationId = button.Id, Property = "HighlightOffAnimation", Value = "MusicPlayerPauseButton" })
		SetInteractProperty({ DestinationId = button.Id, Property = "HighlightOnAnimation", Value = "MusicPlayerPauseButton_Highlight" })

		thread( PlayedMusicPlayerTrackPresentation, button.Data.Name )
	end

end

function CloseMusicPlayerScreen( screen, button )

	DisableShopGamepadCursor()
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "FreeFormSelectSuccessDistanceStep", Value = 8 })
	SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = screen.CloseAnimation })
	PlaySound({ Name = "/Leftovers/Menu Sounds/InfoPanelOutURSA" })
	CloseScreen( GetAllIds( screen.Components ), 0.1 )
	UnfreezePlayerUnit()
	screen.KeepOpen = false
	OnScreenClosed({ Flag = screen.Name })

	--[[
	work in progress
	if screen.PointsAddedThisTime > 0 then
		thread( PlayVoiceLines, GlobalVoiceLines.ClosedMusicPlayerMenuVoiceLines, true )
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorCloseWithUpgrade" })
	else
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorCloseNoUpgrade" })
	end
	]]--

end

function GetMusicTrackTitle( name )
	return string.gsub( name, "/", "" )
end
