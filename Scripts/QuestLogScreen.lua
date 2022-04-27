function UseQuestLog( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenQuestLogScreen()
	UseableOn({ Id = usee.ObjectId })
end

function OpenQuestLogScreen( args )
	ResetKeywords()
	local screen = DeepCopyTable( ScreenData.QuestLog )
	screen.Components = {}
	ScreenAnchors.QuestLogScreen = screen
	local components = screen.Components
	screen.CloseAnimation = "QuestLogOut"

	OnScreenOpened({ Flag = screen.Name, PersistCombatUI = true })
	FreezePlayerUnit()
	EnableShopGamepadCursor()
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 8 })
	SetConfigOption({ Name = "FreeFormSelectSuccessDistanceStep", Value = 8 })
	SetConfigOption({ Name = "FreeFormSelectRepeatDelay", Value = 0.6 })
	SetConfigOption({ Name = "FreeFormSelectRepeatInterval", Value = 0.1 })

	components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })
	components.ShopBackgroundSplatter = CreateScreenComponent({ Name = "LevelUpBackground", Group = "Combat_Menu" })
	components.ShopBackground = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })

	SetAnimation({ DestinationId = components.ShopBackground.Id, Name = "QuestLogIn", OffsetY = 0 })

	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 4 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.090, 0.055, 0.157, 0.8} })

	PlaySound({ Name = "/SFX/Menu Sounds/FatedListOpen" })

	wait(0.2)

	-- Title
	CreateTextBox(MergeTables({ Id = components.ShopBackground.Id, Text = "QuestLogScreen_Title", FontSize = 34, OffsetX = 0, OffsetY = -460, Color = Color.White, Font = "SpectralSCLightTitling", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" }, LocalizationData.QuestLogScreen.TitleText))
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "QuestLogScreen_Flavor", FontSize = 15, OffsetX = 0, OffsetY = -410, Width = 840, Color = {120, 120, 120, 255}, Font = "CrimsonTextItalic", ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2}, Justification = "Center" })

	-- Description Box
	components.DescriptionBox = CreateScreenComponent({ Name = "BlankObstacle", X = 795, Y = 300, Group = "Combat_Menu" })

	-- Close button
	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Scale = 0.7, Group = "Combat_Menu" })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = -6, OffsetY = 456 })
	components.CloseButton.OnPressedFunctionName = "CloseQuestLogScreen"
	components.CloseButton.ControlHotkey = "Cancel"

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	screen.Components.ScrollUp = CreateScreenComponent({ Name = "ButtonCodexUp", X = 430, Y = screen.ItemStartY - screen.EntryYSpacer + 1, Scale = 1.0, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
	screen.Components.ScrollUp.OnPressedFunctionName = "QuestLogScrollUp"
	screen.Components.ScrollUp.ControlHotkey = "MenuLeft"

	screen.Components.ScrollDown = CreateScreenComponent({ Name = "ButtonCodexDown", X = 430, Y = screen.ItemStartY + ( (screen.EntryYSpacer - 1) * screen.ItemsPerPage + 10), Scale = 1.0, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
	screen.Components.ScrollDown.OnPressedFunctionName = "QuestLogScrollDown"
	screen.Components.ScrollDown.ControlHotkey = "MenuRight"

	local readyToCashOutQuests = {}
	local incompleteQuests = {}
	local cashedOutQuests = {}

	for k, questName in ipairs( QuestOrderData ) do
		local questData = QuestData[questName]
		if GameState.QuestStatus[questData.Name] == "CashedOut" then
			table.insert( cashedOutQuests, questData )
		elseif IsGameStateEligible( CurrentRun, questData, questData.UnlockGameStateRequirements ) then
			if IsGameStateEligible( CurrentRun, questData, questData.CompleteGameStateRequirements ) then
				table.insert( readyToCashOutQuests, questData )
			else
				table.insert( incompleteQuests, questData )
			end
		end
	end

	screen.NumItems = 0
	local anyNew = false
	local anyToCashOut = 0

	for k, questData in ipairs( readyToCashOutQuests ) do

		-- QuestButton
		screen.NumItems = screen.NumItems + 1
		local questButtonKey = "QuestButton"..screen.NumItems
		components[questButtonKey] = CreateScreenComponent({ Name = "ButtonQuestLogEntry", Scale = 1, X = itemLocationX, Y = itemLocationY, Group = "Combat_Menu" })
		components[questButtonKey].OnPressedFunctionName = "CashOutQuest"
		components[questButtonKey].OnMouseOverFunctionName = "MouseOverQuest"
		components[questButtonKey].OnMouseOffFunctionName = "MouseOffQuest"
		components[questButtonKey].Data = questData
		components[questButtonKey].Index = screen.NumItems
		AttachLua({ Id = components[questButtonKey].Id, Table = components[questButtonKey] })

		local newButtonKey = "NewIcon"..screen.NumItems
		if not GameState.QuestsViewed[questData.Name] then
			-- New icon
			anyNew = true
			components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
			SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "QuestLogNewQuest" })
			Attach({ Id = components[newButtonKey].Id, DestinationId = components[questButtonKey].Id, OffsetX = 0, OffsetY = 0 })
		end

		CreateTextBox(MergeTables({ Id = components[questButtonKey].Id,
			Text = questData.Name,
			Color = {245, 200, 47, 255},
			FontSize = 22,
			OffsetX = -10, OffsetY = 0,
			Width = 330,
			Font = "AlegreyaSansSCBold",
			OutlineThickness = 0,
			OutlineColor = {255, 205, 52, 255},
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
			Justification = "Right",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
			}, LocalizationData.QuestLogScreen.QuestName))
		Flash({ Id = components[questButtonKey].Id, Speed = 0.8, MinFraction = 0.0, MaxFraction = 0.7, Color = Color.White })

		itemLocationY = itemLocationY + screen.EntryYSpacer

		anyToCashOut = anyToCashOut + 1

	end

	for k, questData in ipairs( incompleteQuests ) do

		-- QuestButton
		screen.NumItems = screen.NumItems + 1
		local questButtonKey = "QuestButton"..screen.NumItems
		components[questButtonKey] = CreateScreenComponent({ Name = "ButtonQuestLogEntry", Scale = 1, X = itemLocationX, Y = itemLocationY, Group = "Combat_Menu" })
		components[questButtonKey].OnMouseOverFunctionName = "MouseOverQuest"
		components[questButtonKey].OnMouseOffFunctionName = "MouseOffQuest"
		components[questButtonKey].Data = questData
		components[questButtonKey].Index = screen.NumItems
		AttachLua({ Id = components[questButtonKey].Id, Table = components[questButtonKey] })

		local newButtonKey = "NewIcon"..screen.NumItems
		if not GameState.QuestsViewed[questData.Name] then
			-- New icon
			anyNew = true
			components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
			SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "QuestLogNewQuest" })
			Attach({ Id = components[newButtonKey].Id, DestinationId = components[questButtonKey].Id, OffsetX = 0, OffsetY = 0 })
		end

		CreateTextBox(MergeTables({ Id = components[questButtonKey].Id,
			Text = questData.Name,
			Color = {215, 215, 215, 255},
			FontSize = 22,
			OffsetX = -10, OffsetY = 0,
			Font = "AlegreyaSansSCBold",
			OutlineThickness = 0,
			OutlineColor = {0,0,0,0.5},
			ShadowBlur = 0, ShadowColor = {0,0,0,0.7}, ShadowOffset={0, 2},
			Justification = "Right",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
			}, LocalizationData.QuestLogScreen.QuestName))

		itemLocationY = itemLocationY + screen.EntryYSpacer

	end

	for k, questData in ipairs( cashedOutQuests ) do

		-- QuestButton
		screen.NumItems = screen.NumItems + 1
		local questButtonKey = "QuestButton"..screen.NumItems
		components[questButtonKey] = CreateScreenComponent({ Name = "ButtonQuestLogEntry", Scale = 1, X = itemLocationX, Y = itemLocationY, Group = "Combat_Menu" })
		components[questButtonKey].OnMouseOverFunctionName = "MouseOverQuest"
		components[questButtonKey].OnMouseOffFunctionName = "MouseOffQuest"
		components[questButtonKey].Data = questData
		components[questButtonKey].Index = screen.NumItems
		AttachLua({ Id = components[questButtonKey].Id, Table = components[questButtonKey] })

		CreateTextBox(MergeTables({ Id = components[questButtonKey].Id,
			Text = questData.Name,
			Color = Color.Black,
			FontSize = 22,
			OffsetX = -10, OffsetY = 0,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
			Justification = "Right",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
			}, LocalizationData.QuestLogScreen.QuestName))

		itemLocationY = itemLocationY + screen.EntryYSpacer

	end

	if anyToCashOut == 1 then
		thread( PlayVoiceLines, HeroVoiceLines.OpenedQuestLogSingleQuestCompleteVoiceLines, true )
	elseif anyToCashOut > 1 then
		thread( PlayVoiceLines, HeroVoiceLines.OpenedQuestLogMultiQuestsCompleteVoiceLines, true )
	elseif anyNew then
		thread( PlayVoiceLines, HeroVoiceLines.OpenedQuestLogNewQuestsAddedVoiceLines, true )
	else
		thread( PlayVoiceLines, HeroVoiceLines.OpenedQuestLogVoiceLines, true )
	end

	QuestLogUpdateVisibility( screen )
	MouseOffQuest()

	wait(0.1)
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })

	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )

end

function CashOutQuest( screen, button )

	local questData = button.Data
	if questData.CompleteGameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, questData, questData.CompleteGameStateRequirements ) then
		QuestIncompletePresentation( button )
		return
	end

	if GameState.QuestStatus[button.Data.Name] ~= "CashedOut" then
		AddResource( button.Data.RewardResourceName, button.Data.RewardResourceAmount, "Quest" )
		GameState.QuestStatus[button.Data.Name] = "CashedOut"
		QuestCashedOutPresentation( screen, button )
	end

	StopFlashing({ Id = button.Id })
	ModifyTextBox({ Id = button.Id, Color = Color.Black })
	ModifyTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id, AffectText = "QuestLogReward", Color = Color.Gray })
	ModifyTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id, AffectText = "QuestLog_CashOutHint", FadeTarget = 0 })

end

function CloseQuestLogScreen( screen, button )

	DisableShopGamepadCursor()
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16 })
	SetConfigOption({ Name = "FreeFormSelectSuccessDistanceStep", Value = 8 })
	SetConfigOption({ Name = "FreeFormSelectRepeatDelay", Value = 0.0 })
	SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = screen.CloseAnimation })
	PlaySound({ Name = "/SFX/Menu Sounds/FatedListClose" })
	CloseScreen( GetAllIds( screen.Components ), 0.1 )
	UnfreezePlayerUnit()
	screen.KeepOpen = false
	OnScreenClosed({ Flag = screen.Name })
	thread( CheckProgressAchievements )
end

function MouseOverQuest( button )

	ModifyTextBox({ Id = button.Id, ScaleTarget = 1.05, ScaleDuration = 0.2 })

	-- Remove previous description
	DestroyTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id })

	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu" })

	CreateTextBox(MergeTables({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
		Text = button.Data.Name,
		UseDescription = true,
		FontSize = 22,
		OffsetX = 0, OffsetY = 45,
		Color = {161,161,161,255},
		Width = 700,
		Height = 800,
		Font = "AlegreyaSansRegular",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
		Justification = "Left",
		VerticalJustification = "Top",
		LineSpacingBottom = 9,
	}, LocalizationData.QuestLogScreen.QuestDescription))

	-- Reward
	local rewardColor = {245, 200, 47, 255}
	if GameState.QuestStatus[button.Data.Name] == "CashedOut" then
		rewardColor = Color.Gray
	else
		if IsGameStateEligible( CurrentRun, button.Data, button.Data.CompleteGameStateRequirements ) then
			-- Hint
			CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
				Text = "QuestLog_CashOutHint",
				FontSize = 22,
				OffsetX = 250, OffsetY = 185,
				Color = rewardColor,
				Font = "AlegreyaSansSCRegular",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				Justification = "Left" })
		end
	end

	local textSymbolScale = 0.9

	local resourceData = ResourceData[button.Data.RewardResourceName]
	CreateTextBox(MergeTables({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
		Text = "QuestLogReward",
		FontSize = 26,
		OffsetX = 0, OffsetY = 185,
		Color = rewardColor,
		TextSymbolScale = textSymbolScale,
		Font = "AlegreyaSansSCRegular",
		LuaKey = "TempTextData",
		LuaValue = { Icon = resourceData.IconPath, Amount = button.Data.RewardResourceAmount },
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
		Justification = "Left" }, LocalizationData.QuestLogScreen.QuestLogRewardText))

	-- Title
	CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
		Text = button.Data.Name,
		FontSize = 34,
		OffsetX = 0, OffsetY = 10,
		Color = Color.White,
		TextSymbolScale = textSymbolScale,
		Font = "AlegreyaSansSCExtraBold",
		LuaKey = "TempTextData",
		LuaValue = { Icon = resourceData.IconPath, Amount = button.Data.RewardResourceAmount },
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
		Justification = "Left" })

	local newButtonKey = "NewIcon"..button.Index
	if ScreenAnchors.QuestLogScreen.Components[newButtonKey] ~= nil then
		SetAlpha({ Id = ScreenAnchors.QuestLogScreen.Components[newButtonKey].Id, Fraction = 0, Duration = 0.2 })
	end
	GameState.QuestsViewed[button.Data.Name] = true

	ShowQuestProgress( button.Data )
end

function MouseOffQuest( button )
	if button ~= nil then
		ModifyTextBox({ Id = button.Id, ScaleTarget = 1.0, ScaleDuration = 0.2 })
	end
	DestroyTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id })
	MouseOffQuestPresentation( button )
end

function HasActiveQuestForTrait( name )

	if not GameState.Cosmetics.QuestLog then
		return false
	end

	for k, questName in ipairs( QuestOrderData ) do
		local questData = QuestData[questName]
		if questData.CompleteGameStateRequirements.RequiredTraitsTaken ~= nil and GameState.QuestStatus[questData.Name] ~= "CashedOut" and IsGameStateEligible( CurrentRun, questData, questData.UnlockGameStateRequirements ) then
			if Contains( questData.CompleteGameStateRequirements.RequiredTraitsTaken, name ) then
				return true
			end
		end
	end

	return false

end

function HasActiveQuestForItem( name )

	if not GameState.Cosmetics.QuestLog then
		return false
	end

	for k, questName in ipairs( QuestOrderData ) do
		local questData = QuestData[questName]
		if questData.CompleteGameStateRequirements.RequiredMinItemInteractions ~= nil and GameState.QuestStatus[questData.Name] ~= "CashedOut" and IsGameStateEligible( CurrentRun, questData, questData.UnlockGameStateRequirements ) then
			if questData.CompleteGameStateRequirements.RequiredMinItemInteractions[name] then
				return true
			end
		end
	end

	return false

end

function HasAnyQuestWithStatus( status )

	for k, questName in ipairs( QuestOrderData ) do
		local questData = QuestData[questName]
		if GameState.QuestStatus[questData.Name] == "CashedOut" then
			if status == "CashedOut" then
				return true
			end
		elseif IsGameStateEligible( CurrentRun, questData, questData.UnlockGameStateRequirements ) then
			if IsGameStateEligible( CurrentRun, questData, questData.CompleteGameStateRequirements ) then
				if status == "Complete" then
					return true
				end
			else
				if status == "Incomplete" then
					return true
				end
			end
		end
	end

	return false

end

function HasAllQuestsWithStatus( status )

	for k, questName in ipairs( QuestOrderData ) do
		local questData = QuestData[questName]
		if GameState.QuestStatus[questData.Name] ~= status then
			return false
		end
	end

	return true

end

function ShowQuestProgress( questData )

	local requirements = questData.CompleteGameStateRequirements

	local index = 1
	local baseOffsetY = 200
	local spacing = questData.Spacing or 30

	local maxEntriesPerColumn = questData.MaxEntriesPerColumn or 12
	local currentColumn = 1
	local columnWidth = 350

	local completeColor = {223,223,223,255}
	local incompleteColor = {94,94,94,255}
	local fontSize = questData.FontSize or 20
	local font = "AlegreyaSansSCRegular"

	local textSymbolScale = 1.0
	local width = 700

	if requirements.RequiredTraitsTaken ~= nil then
		for k, requiredTrait in ipairs( requirements.RequiredTraitsTaken ) do
			local color = completeColor
			local text = "QuestLog_QuestProgressComplete"
			if not GameState.TraitsTaken[requiredTrait] then
				color = incompleteColor
				text = questData.IncompleteName or "QuestLog_QuestProgressIncomplete"
			end
			CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
				Text = text,
				LuaKey = "TempTextData",
				LuaValue = { Requirement = requiredTrait },
				OffsetX = ( currentColumn - 1 ) * columnWidth, OffsetY = baseOffsetY + ( ( index - ( maxEntriesPerColumn * (currentColumn - 1) ) ) * spacing),
				FontSize = fontSize,
				Color = color,
				Font = font,
				Width = width,
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				TextSymbolScale = textSymbolScale,
				Justification = "Left" })
			index = index + 1
			if( index > maxEntriesPerColumn * currentColumn ) then
				currentColumn = currentColumn + 1
			end
		end
	end

	if requirements.RequiredClearedWithMetaUpgrades ~= nil then
		for k, requiredUpgade in ipairs( requirements.RequiredClearedWithMetaUpgrades ) do
			local color = completeColor
			local text = "QuestLog_QuestProgressComplete"
			if (GameState.ClearedWithMetaUpgrades[requiredUpgade] or 0) <= 0 then
				color = incompleteColor
				text = questData.IncompleteName or "QuestLog_QuestProgressIncomplete"
			end
			CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
				Text = text,
				LuaKey = "TempTextData",
				LuaValue = { Requirement = requiredUpgade },
				OffsetX = ( currentColumn - 1 ) * columnWidth, OffsetY = baseOffsetY + ( ( index - ( maxEntriesPerColumn * (currentColumn - 1) ) ) * spacing),
				FontSize = fontSize,
				Color = color,
				Font = font,
				Width = width,
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				TextSymbolScale = textSymbolScale,
				Justification = "Left" })
			index = index + 1
			if( index > maxEntriesPerColumn * currentColumn ) then
				currentColumn = currentColumn + 1
			end
		end
	end

	if requirements.RequiredWeaponsUnlocked ~= nil then
		for k, weaponName in ipairs( requirements.RequiredWeaponsUnlocked ) do
			local color = completeColor
			local text = "QuestLog_QuestProgressComplete"
			if not GameState.WeaponsUnlocked[weaponName] then
				color = incompleteColor
				text = questData.IncompleteName or "QuestLog_QuestProgressIncomplete"
			end
			CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
				Text = text,
				LuaKey = "TempTextData",
				LuaValue = { Requirement = weaponName },
				OffsetX = ( currentColumn - 1 ) * columnWidth, OffsetY = baseOffsetY + ( ( index - ( maxEntriesPerColumn * (currentColumn - 1) ) ) * spacing),
				FontSize = fontSize,
				Color = color,
				Font = font,
				Width = width,
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				TextSymbolScale = textSymbolScale,
				Justification = "Left" })
			index = index + 1
			if( index > maxEntriesPerColumn * currentColumn ) then
				currentColumn = currentColumn + 1
			end
		end
	end

	if requirements.RequiredClearsWithWeapons ~= nil then
		for k, weaponName in ipairs( requirements.RequiredClearsWithWeapons.Names ) do
			local color = completeColor
			local text = "QuestLog_QuestProgressComplete"
			if	( (GameState.TimesClearedWeapon[weaponName] or 0) <= 0 ) or
				( requirements.RequiredClearsWithWeapons.ShrinePoints ~= nil and (GameState.WeaponRecordsShrinePoints[weaponName] or 0) <= requirements.RequiredClearsWithWeapons.ShrinePoints ) or
				( requirements.RequiredClearsWithWeapons.ClearTime ~= nil and (GameState.WeaponRecordsClearTime[weaponName] or 999999) > requirements.RequiredClearsWithWeapons.ClearTime )
				then
				color = incompleteColor
				text = questData.IncompleteName or "QuestLog_QuestProgressIncomplete"
			end
			CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
				Text = text,
				LuaKey = "TempTextData",
				LuaValue = { Requirement = weaponName },
				OffsetX = ( currentColumn - 1 ) * columnWidth, OffsetY = baseOffsetY + ( ( index - ( maxEntriesPerColumn * (currentColumn - 1) ) ) * spacing),
				FontSize = fontSize,
				Color = color,
				Font = font,
				Width = width,
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				TextSymbolScale = textSymbolScale,
				Justification = "Left" })
			index = index + 1
			if( index > maxEntriesPerColumn * currentColumn ) then
				currentColumn = currentColumn + 1
			end
		end
	end

	if requirements.RequiredNumCosmeticsMin ~= nil then
		local currentCount = TableLength( GameState.CosmeticsAdded )
		local color = completeColor
		local text = "QuestLog_ProgressCountComplete"
		if currentCount < requirements.RequiredNumCosmeticsMin then
			color = incompleteColor
			text = questData.IncompleteName or "QuestLog_ProgressCountIncomplete"
		end
		CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
			Text = text,
			LuaKey = "TempTextData",
			LuaValue = { Current = currentCount - 7, Goal = requirements.RequiredNumCosmeticsMin - 7 }, -- Account for starting 7 cosmetics
			OffsetX = ( currentColumn - 1 ) * columnWidth, OffsetY = baseOffsetY + ( ( index - ( maxEntriesPerColumn * (currentColumn - 1) ) ) * spacing),
			FontSize = fontSize * 1.5,
			Color = Color.White,
			Font = font,
			Width = width,
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
			TextSymbolScale = textSymbolScale,
			Justification = "Left" })
		index = index + 1
		if( index > maxEntriesPerColumn * currentColumn ) then
			currentColumn = currentColumn + 1
		end
	end

	if requirements.RequiredCodexEntriesMin ~= nil then
		local currentCount = CalcNumCodexEntriesUnlocked()
		local color = completeColor
		local text = "QuestLog_ProgressCountComplete"
		if currentCount < requirements.RequiredCodexEntriesMin then
			color = incompleteColor
			text = "QuestLog_ProgressCountIncomplete"
		end
		CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
			Text = text,
			LuaKey = "TempTextData",
			LuaValue = { Current = currentCount, Goal = requirements.RequiredCodexEntriesMin },
			OffsetX = ( currentColumn - 1 ) * columnWidth, OffsetY = baseOffsetY + ( ( index - ( maxEntriesPerColumn * (currentColumn - 1) ) ) * spacing),
			FontSize = fontSize * 1.5,
			Color = Color.White,
			Font = font,
			Width = width,
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
			TextSymbolScale = textSymbolScale,
			Justification = "Left" })
		index = index + 1
		if( index > maxEntriesPerColumn * currentColumn ) then
			currentColumn = currentColumn + 1
		end
	end

	if requirements.RequiredMinNPCInteractions ~= nil then
		for k, display in ipairs( questData.DisplayOrder ) do
			local requirement = display.Requirement
			local color = completeColor
			local text = "QuestLog_QuestProgressComplete"
			if GameState.NPCInteractions[requirement] == nil or GameState.NPCInteractions[requirement] < requirements.RequiredMinNPCInteractions[requirement] then
				color = incompleteColor
				text = questData.IncompleteName or "QuestLog_QuestProgressIncomplete"
			end
			CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
				Text = text,
				LuaKey = "TempTextData",
				LuaValue = { Requirement = display.Text },
				OffsetX = ( currentColumn - 1 ) * columnWidth, OffsetY = baseOffsetY + ( ( index - ( maxEntriesPerColumn * (currentColumn - 1) ) ) * spacing),
				FontSize = fontSize,
				Color = color,
				Font = font,
				Width = width,
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				TextSymbolScale = textSymbolScale,
				Justification = "Left" })
			index = index + 1
			if( index > maxEntriesPerColumn * currentColumn ) then
				currentColumn = currentColumn + 1
			end
		end
	end

	if requirements.RequiredPlayed ~= nil then
		for k, voiceLine in pairs( requirements.RequiredPlayed ) do
			local color = completeColor
			local text = "QuestLog_QuestProgressComplete"
			if SpeechRecord[voiceLine] == nil then
				color = incompleteColor
				text = questData.IncompleteName or "QuestLog_QuestProgressIncomplete"
			end
			CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
				Text = text,
				LuaKey = "TempTextData",
				LuaValue = { Requirement = StripForwardSlashes( voiceLine ) },
				OffsetX = ( currentColumn - 1 ) * columnWidth, OffsetY = baseOffsetY + ( ( index - ( maxEntriesPerColumn * (currentColumn - 1) ) ) * spacing),
				FontSize = fontSize,
				Color = color,
				Font = font,
				Width = width,
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				TextSymbolScale = textSymbolScale,
				Justification = "Left" })
			index = index + 1
		end
	end

	if requirements.RequiredTextLines ~= nil then
		for k, textLineSet in pairs( requirements.RequiredTextLines ) do
			local color = completeColor
			local text = "QuestLog_QuestProgressComplete"
			if TextLinesRecord[textLineSet] == nil then
				color = incompleteColor
				text = questData.IncompleteName or "QuestLog_QuestProgressIncomplete"
			end
			CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
				Text = text,
				LuaKey = "TempTextData",
				LuaValue = { Requirement = textLineSet },
				OffsetX = ( currentColumn - 1 ) * columnWidth, OffsetY = baseOffsetY + ( ( index - ( maxEntriesPerColumn * (currentColumn - 1) ) ) * spacing),
				FontSize = fontSize,
				Color = color,
				Font = font,
				Width = width,
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				TextSymbolScale = textSymbolScale,
				Justification = "Left" })
			index = index + 1
		end
	end

	if requirements.RequiredAnyTextLines ~= nil then
		local color = incompleteColor
		local text = questData.IncompleteName or "QuestLog_QuestProgressIncomplete"
		for k, textLineSet in pairs( requirements.RequiredAnyTextLines ) do
			if TextLinesRecord[textLineSet] == nil then
				color = completeColor
				text = "QuestLog_QuestProgressComplete"
				break
			end
		end
		CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
			Text = text,
			LuaKey = "TempTextData",
			LuaValue = { Requirement = textLineSet },
			OffsetX = ( currentColumn - 1 ) * columnWidth, OffsetY = baseOffsetY + ( ( index - ( maxEntriesPerColumn * (currentColumn - 1) ) ) * spacing),
			FontSize = fontSize,
			Color = color,
			Font = font,
			Width = width,
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
			TextSymbolScale = textSymbolScale,
			Justification = "Left" })
		index = index + 1
	end

	if requirements.RequiredKills ~= nil then
		for k, requirement in ipairs( questData.DisplayOrder ) do
			local color = completeColor
			local text = "QuestLog_QuestProgressComplete"
			if GameState.EnemyKills[requirement] == nil or GameState.EnemyKills[requirement] < requirements.RequiredKills[requirement] then
				color = incompleteColor
				text = questData.IncompleteName or "QuestLog_QuestProgressIncomplete"
			end
			CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
				Text = text,
				LuaKey = "TempTextData",
				LuaValue = { Requirement = requirement },
				OffsetX = ( currentColumn - 1 ) * columnWidth, OffsetY = baseOffsetY + ( ( index - ( maxEntriesPerColumn * (currentColumn - 1) ) ) * spacing),
				FontSize = fontSize,
				Color = color,
				Font = font,
				Width = width,
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				TextSymbolScale = textSymbolScale,
				Justification = "Left" })
			index = index + 1
			if( index > maxEntriesPerColumn * currentColumn ) then
				currentColumn = currentColumn + 1
			end
		end
	end

	if requirements.RequiredEliteAttributeKills ~= nil then
		for k, displayEntry in ipairs( questData.DisplayOrder ) do
			local color = completeColor
			local text = "QuestLog_QuestProgressComplete"
			if (GameState.EnemyEliteAttributeKills[displayEntry.Requirement] or 0) < requirements.RequiredEliteAttributeKills[displayEntry.Requirement] then
				color = incompleteColor
				text = questData.IncompleteName or "QuestLog_QuestProgressIncomplete"
			end
			CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
				Text = text,
				LuaKey = "TempTextData",
				LuaValue = { Requirement = displayEntry.Text },
				OffsetX = ( currentColumn - 1 ) * columnWidth, OffsetY = baseOffsetY + ( ( index - ( maxEntriesPerColumn * (currentColumn - 1) ) ) * spacing),
				FontSize = fontSize,
				Color = color,
				Font = font,
				Width = width,
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				TextSymbolScale = textSymbolScale,
				Justification = "Left" })
			index = index + 1
			if( index > maxEntriesPerColumn * currentColumn ) then
				currentColumn = currentColumn + 1
			end
		end
	end

	if requirements.RequiredMinItemInteractions ~= nil then
		for k, display in ipairs( questData.DisplayOrder ) do
			local requirement = display.Requirement
			local color = completeColor
			local text = "QuestLog_QuestProgressComplete"
			if (GameState.ItemInteractions[requirement] or 0) < requirements.RequiredMinItemInteractions[requirement] then
				color = incompleteColor
				text = questData.IncompleteName or "QuestLog_QuestProgressIncomplete"
			end
			CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
				Text = text,
				LuaKey = "TempTextData",
				LuaValue = { Requirement = display.Text or display.Requirement },
				OffsetX = ( currentColumn - 1 ) * columnWidth, OffsetY = baseOffsetY + ( ( index - ( maxEntriesPerColumn * (currentColumn - 1) ) ) * spacing),
				FontSize = fontSize,
				Color = color,
				Font = font,
				Width = width,
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				TextSymbolScale = textSymbolScale,
				Justification = "Left" })
			index = index + 1
			if( index > maxEntriesPerColumn * currentColumn ) then
				currentColumn = currentColumn + 1
			end
		end
	end

end

function CheckQuestStatus( args )

	if GameState == nil or not GameState.Cosmetics.QuestLog then
		return
	end

	args = args or {}
	
	local threadName = "CheckQuestsComplete"
	if not args.Silent then
		if SetThreadWait( threadName, 0.3 ) then
			return
		end
		wait( 0.3, threadName )
	end

	local questAdded = false
	local questCompleted = false

	for k, questName in ipairs( QuestOrderData ) do
		local questData = QuestData[questName]
		if GameState.QuestStatus[questData.Name] == nil then
			-- Locked
			if IsGameStateEligible( CurrentRun, questData, questData.UnlockGameStateRequirements ) then
				-- Unlocked
				GameState.QuestStatus[questData.Name] = "Unlocked"
				questAdded = true
			end
			if not args.Silent then
				wait( 0.02, threadName ) -- Distribute workload over frames
			end
		end
		if GameState.QuestStatus[questData.Name] == "Unlocked" then
			if IsGameStateEligible( CurrentRun, questData, questData.CompleteGameStateRequirements ) then
				-- Completed
				GameState.QuestStatus[questData.Name] = "Complete"
				questCompleted = true
			end
			if not args.Silent then
				wait( 0.02, threadName ) -- Distribute workload over frames
			end
		end
	end

	if not args.Silent then
		if questCompleted then
			QuestCompletedPresentation( nil, threadName )
			wait( 0.2, threadName )
		end
		if questAdded then
			QuestAddedPresentation( nil, threadName )
			wait( 0.2, threadName )
		end
	end

end

function QuestLogScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.ItemsPerPage
	QuestLogUpdateVisibility( screen )
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.EntryYSpacer), ForceUseCheck = true })
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
end

function QuestLogScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	QuestLogUpdateVisibility( screen )
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
end

function QuestLogUpdateVisibility( screen )

	local components = screen.Components
	for index = 1, screen.NumItems do
		local questButtonKey = "QuestButton"..index
		local newButtonKey = "NewIcon"..index

		local visibleIndex = index - screen.ScrollOffset

		if visibleIndex >= 1 and visibleIndex <= screen.ItemsPerPage then
			-- Page in view
			Teleport({ Id = components[questButtonKey].Id, OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((visibleIndex - 1) * screen.EntryYSpacer) })
			SetAlpha({ Id = components[questButtonKey].Id, Fraction = 1 })
			if components[newButtonKey] ~= nil and not GameState.QuestsViewed[components[questButtonKey].Data.Name] then
				SetAlpha({ Id = components[newButtonKey].Id, Fraction = 1 })
			end
			UseableOn({ Id = components[questButtonKey].Id })
		else
			-- Page out of view
			SetAlpha({ Id = components[questButtonKey].Id, Fraction = 0 })
			if components[newButtonKey] ~= nil then
				SetAlpha({ Id = components[newButtonKey].Id, Fraction = 0 })
			end
			UseableOff({ Id = components[questButtonKey].Id, ForceHighlightOff = true  })
		end
	end

	if screen.ScrollOffset <= 0 then
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0, Duration = 0.1 })
		UseableOff({ Id = components.ScrollUp.Id })
	else
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1, Duration = 0.1 })
		UseableOn({ Id = components.ScrollUp.Id })
	end

	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0, Duration = 0.1 })
		UseableOff({ Id = components.ScrollDown.Id })
	else
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 1, Duration = 0.1 })
		UseableOn({ Id = components.ScrollDown.Id })
	end

end

function ValidateOrderData( dataSet, orderData )
	for itemName, itemData in pairs( dataSet ) do
		if not itemData.DebugOnly and not Contains( orderData, itemName ) then
			DebugAssert({ Text = itemName.." not added to its OrderData" })
		end
	end
end