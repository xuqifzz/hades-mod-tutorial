OnUsed{ "GiftRack",
	function( triggerArgs )
		if CurrentRun.CurrentRoom.BlockKeepsakeMenu and not CanFreeSwapKeepsakes() then
			CannotUseRackPresentation( triggerArgs.triggeredById)
			return
		end

		PlayInteractAnimation( triggerArgs.triggeredById )
		StartUpAwardMenu( triggerArgs.TriggeredByTable )
	end
}

function UpdateGiftRackShineStatus()
	if ScreenAnchors.AwardMenuSparkleId ~= nil then
		Destroy({ Id = ScreenAnchors.AwardMenuSparkleId })
	end
	local id = GetIdsByType({ Name = "GiftRack" })[1]
	if id ~= nil and HasNewTraits() and not CurrentRun.CurrentRoom.BlockKeepsakeMenu then
		ScreenAnchors.AwardMenuSparkleId = SpawnObstacle({ Name = "BlankObstacle", Group = "FX_Standing"})
		SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = ScreenAnchors.AwardMenuSparkleId })
		Attach({ Id = ScreenAnchors.AwardMenuSparkleId, DestinationId = id })
		SetAnimation({ Name = "GiftRackGlean", DestinationId = ScreenAnchors.AwardMenuSparkleId })
	end
end

function EquipLastAssistTrait( eventSource, hero )
	local existingHero = CurrentRun.Hero or hero
	if GameState.LastAssistTrait ~= nil then
		EquipAssist( existingHero, GameState.LastAssistTrait )
	end
end

function RemoveLastAssistTrait( eventSource )
	if GameState.LastAssistTrait ~= nil then
		UnequipAssist( CurrentRun.Hero, GameState.LastAssistTrait )
	end
end
function EquipLastAwardTrait( eventSource, hero )
	local existingHero = CurrentRun.Hero or hero
	if GameState.LastAwardTrait ~= nil then
		EquipKeepsake( existingHero, GameState.LastAwardTrait )
	end
end

function RemoveLastAwardTrait( eventSource )
	if GameState.LastAwardTrait ~= nil then
		UnequipKeepsake( CurrentRun.Hero, GameState.LastAwardTrait )
	end
end

function HasNewTraits()
	for npcName, giftData in pairs(GameState.Gift) do
		for s = 1, GetMaxGiftLevel( npcName ) do
			local data = GetGiftLevelData( npcName, s )
			if data ~= nil then
				local new = Contains(GameState.Gift[npcName].NewTraits, data.Gift)
				if new then
					return true
				end
			end
		end
	end
	return false
end

function IsKeepsakeUnlocked( traitName )
	for npcName, giftData in pairs(GameState.Gift) do
		for s = 1, GetMaxGiftLevel( npcName ) do
			local data = GetGiftLevelData( npcName, s )
			if data ~= nil and data.Gift and data.Gift == traitName and s <= GetGiftLevel(npcName) then
				return true	
			end
		end
	end
	return false
end

function GetAvailableKeepsakeTraits()
	local gifts = {}
	for npcName, giftData in pairs(GameState.Gift) do
		for s = 1, GetMaxGiftLevel( npcName ) do
			local data = GetGiftLevelData( npcName, s )
			if data ~= nil and data.Gift and TraitData[data.Gift].Slot == "Keepsake" then
				local new = Contains(GameState.Gift[npcName].NewTraits, data.Gift)
				table.insert(gifts, { New = new, Gift = data.Gift, Level = s, NPC = npcName, Unlocked = (s <= GetGiftLevel(npcName)) })
			end
		end
	end
	table.sort( gifts, AwardMenuSort )
	return gifts
end

function GetAllAssistTraits()
	local gifts = {}
	for npcName, giftData in pairs(GameState.Gift) do
		if GiftData[npcName] and GiftData[npcName].Maximum then
			for s = 1, GiftData[npcName].Maximum do
				local data = GetGiftLevelData( npcName, s )
				if data ~= nil and data.Gift and TraitData[data.Gift].Slot == "Assist" then
					local new = Contains(GameState.Gift[npcName].NewTraits, data.Gift)
					table.insert(gifts, { New = new, Gift = data.Gift, Level = s, NPC = npcName, Unlocked = (s <= GetGiftLevel(npcName)) })
				end
			end
		end
	end
	table.sort( gifts, AwardMenuSort )
	return gifts
end

function AwardMenuSort( itemA, itemB )
	if GiftOrderingReverseLookup[itemA.Gift] and GiftOrderingReverseLookup[itemB.Gift] then
		return GiftOrderingReverseLookup[itemA.Gift] < GiftOrderingReverseLookup[itemB.Gift]
	end

	if itemA.NPC ~= itemB.NPC then
		return itemA.NPC < itemB.NPC
	end

	return itemA.Level < itemB.Level
end

function StartUpAwardMenu( awardMenuObject )
	UIData.AwardMenu.AvailableKeepsakeTraits = GetAvailableKeepsakeTraits()
	UIData.AwardMenu.AvailableAssistTraits = GetAllAssistTraits()
	CurrentRun.CurrentRoom.AwardMenuObject = awardMenuObject
	ShowAwardMenu()

	if GameState.LastAwardTrait ~= nil then
		thread(MarkObjectiveComplete, "GiftRackPrompt")
	end
end

function ShowAwardMenu()
	if IsScreenOpen("AwardMenu") then
		return
	end

	OnScreenOpened({Flag = "AwardMenu", PersistCombatUI = true })
	FreezePlayerUnit()
	EnableShopGamepadCursor()
	HideCombatUI("AwardMenu")
	SetConfigOption({ Name = "FreeFormSelecSearchFromId", Value = 0 })
	SetConfigOption({ Name = "FreeFormSelectRepeatDelay", Value = 0.6 })
	SetConfigOption({ Name = "FreeFormSelectRepeatInterval", Value = 0.1 })

	ScreenAnchors.AwardMenuScreen = { Components = {}, UpgradeButtons = {} }
	local components = ScreenAnchors.AwardMenuScreen.Components

	components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })
	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 4 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.15, 0.15, 0.15, 0.85} })

	components.ShopBackground = CreateScreenComponent({ Name = "AwardMenuBackground", Group = "Combat_Menu", OffsetX = 0, OffsetY = 190 })

	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Scale = 0.7, Group = "Combat_Menu" })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = 0, OffsetY = 500 })
	components.CloseButton.OnPressedFunctionName = "CloseUpgradeScreen"
	components.CloseButton.ControlHotkey = "Cancel"

	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ChestOpen" })

	-- Title
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "AwardMenu_Title", FontSize = 40, OffsetX = 0, OffsetY = -460, Color = Color.White, Font = "SpectralSCLightTitling", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "AwardMenu_SubTitle", FontSize = 18, OffsetX = 0, OffsetY = -410, Width = 840, Color = Color.SubTitle, Font = "CrimsonTextItalic", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })
	-- CreateTextBox({ Id = components.ShopBackground.Id, Text = "AwardMenu_Hint", FontSize = 14, OffsetX = 0, OffsetY = 420, Width = 840, Color = Color.Gray, Font = "CrimsonTextBoldItalic", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })

	components.EquipSubtitle = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = 850, Group = "Combat_Menu" })
	CreateTextBox({ Id = components.EquipSubtitle.Id, Text = "OemQuestion", FontSize = 24, OffsetX = 600, OffsetY = 100, Width = 840, Color = Color.LightSlateGray, Font = "AlegreyaSansRegular", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })

	-- Description box
	local descriptionStartX = 1325
	local descriptionStartY = 75
	local descriptionTextOffsetX = 0
	local descriptionTextOffsetY = 185
	components.CurrentLevel = CreateScreenComponent({ Name = "BlankObstacle", X = descriptionStartX, Y = descriptionStartY + 340, Group = "Combat_Menu" })
	CreateTextBox({ Id = components.CurrentLevel.Id, OffsetX = descriptionTextOffsetX, OffsetY = descriptionTextOffsetY,
		FontSize = 24,
		Width = 450,
		Justification = "Left",
		VerticalJustification = "Top",
		LineSpacingBottom = 8,
		Font = "AlegreyaSansSCBold",
		Format = "BaseFormat",
		VariableAutoFormat = "BoldFormatGraft",
	})
	local levelProgressYOffset = 380
	
	local lang = GetLanguage({})
	if lang == "ja" then
		levelProgressYOffset = levelProgressYOffset + 18
	end
	components.LevelProgress = CreateScreenComponent({ Name = "BlankObstacle", X = descriptionStartX, Y = descriptionStartY + levelProgressYOffset, Group = "Combat_Menu" })
	CreateTextBox({ Id = components.LevelProgress.Id, OffsetX = descriptionTextOffsetX, OffsetY = descriptionTextOffsetY,
		Width = 450,
		FontSize = 18,
		Justification = "Left",
		VerticalJustification = "Top",
		LineSpacingBottom = 8,
		Font = "AlegreyaSansRegular",
		Format = "BaseFormat",
		VariableAutoFormat = "BoldFormatGraft",
	})
	components.InfoBackground = CreateScreenComponent({ Name = "BlankObstacle", X = descriptionStartX, Y = descriptionStartY, Group = "Combat_Menu" })
	SetScaleY({ Id = components.InfoBackground.Id, Fraction = 1.4 })
	CreateTextBox({ Id = components.InfoBackground.Id, OffsetX = descriptionTextOffsetX, OffsetY = descriptionTextOffsetY,
		FontSize = 36,
		Color = Color.Title2,
		Font = "AlegreyaSansSCBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 4},
		Justification = "Left",
		LangFrScaleModifier = 0.8,
		LangItScaleModifier = 0.8,
		LangDeScaleModifier = 0.8,
		LangEsScaleModifier = 0.8,
		LangPtBrScaleModifier = 0.8,
		LangKoScaleModifier = 0.8,
		LangRuScaleModifier = 0.65,
		LangPlScaleModifier = 0.75,
	})
	components.Sticker = CreateScreenComponent({ Name = "BlankObstacle", X = descriptionStartX + 230, Y = descriptionStartY + GetLocalizedValue(720, { { Code = "ja", Value = 740 }, }), Group = "Combat_Menu_Additive" })
	
	components.InfoBackgroundDescription = CreateScreenComponent({ Name = "BlankObstacle", X = descriptionStartX, Y = descriptionStartY, Group = "Combat_Menu" })
	CreateTextBox({ Id = components.InfoBackgroundDescription.Id, FontSize = 18, OffsetX = descriptionTextOffsetX, OffsetY = descriptionTextOffsetY + 40, Color = Color.DefaultText,
		Width = 485,
		Justification = "Left",
		VerticalJustification = "Top",
		LineSpacingBottom = 6,
		UseDescription = true,
		Font = "AlegreyaSansRegular",
		Format = "BaseFormat",
		VariableAutoFormat = "BoldFormatGraft", UseDescription = true,
		LangKoScaleModifier = 0.875, 
	})

	ScreenAnchors.AwardMenuScreen.LastTrait = GameState.LastAwardTrait
	ScreenAnchors.AwardMenuScreen.LastAssist = GameState.LastAssistTrait

	local spacerX = 118
	local spacerY = 165
	local startX = 405
	local startY = 280
	local rowMax = 10
	local rowMin = math.ceil(rowMax/2)
	UIData.AwardMenu.HasUnlocked = false
	UIData.AwardMenu.HasNew = false
	UIData.AwardMenu.FirstUsable = false
	UIData.AwardMenu.NewLegendary = false
	UIData.AwardMenu.FirstNewLegendary = true
	for itemIndex, upgradeData in ipairs(UIData.AwardMenu.AvailableKeepsakeTraits) do
		local localx = 0
		local localy = 0
		localx = startX - spacerX * rowMin/2 + ((itemIndex - 1) % rowMax + 0.5) * spacerX
		localy = startY + math.floor( (itemIndex - 1) / rowMax)* 2 * (spacerY / 2)

		if TraitData[upgradeData.Gift].Slot == "Assist" then
			localy = localy + 180
		end
		CreateKeepsakeIcon( components, { Index = itemIndex, UpgradeData = upgradeData, X = localx, Y = localy })
	end
	for itemIndex, upgradeData in ipairs(UIData.AwardMenu.AvailableAssistTraits) do
		if not upgradeData.New or GameState.Flags.FirstNewLegendary then
			UIData.AwardMenu.FirstNewLegendary = false
		elseif upgradeData.New then
			UIData.AwardMenu.NewLegendary = true
		end
	end
	-- Assist trait modifications
	spacerX = 198
	startX = 0
	startY = startY + 2 * spacerY + 230
	local createdKeepsakes = 0
	local hasUnlockedKeepsakes = false
	for itemIndex, upgradeData in ipairs(UIData.AwardMenu.AvailableAssistTraits) do
		local localx = 0
		local localy = 0
		localx = startX + itemIndex  * spacerX
		localy = startY
		createdKeepsakes = createdKeepsakes + 1
		if upgradeData.Unlocked then
			CreateKeepsakeIcon( components, { Index = itemIndex, UpgradeData = upgradeData, X = localx, Y = localy - 20, RankOffsetY = 100, AddUpgradeButton = true, KeyAppend = "Legendary" })
			hasUnlockedKeepsakes = true
		else
			components["Locked"..itemIndex] = CreateScreenComponent({ Name = "LegendaryKeepsakeLockedButton", X = localx, Y = localy + 10, Group = "Combat_Menu" })
			components["Locked"..itemIndex].TitleTextBoxId = components.InfoBackground.Id
			components["Locked"..itemIndex].DescriptionTextBoxId = components.InfoBackgroundDescription.Id
			components["Locked"..itemIndex].CurrentLevelId = components.CurrentLevel.Id
			components["Locked"..itemIndex].LevelProgressId = components.LevelProgress.Id
			ScreenAnchors.AwardMenuScreen[components["Locked"..itemIndex].Id] = components["Locked"..itemIndex]
		end
	end
	for itemIndex = createdKeepsakes + 1, 6 do
		local localx = 0
		local localy = 0
		localx = startX + itemIndex  * spacerX
		localy = startY
		components["Locked"..itemIndex] = CreateScreenComponent({ Name = "LegendaryKeepsakeLockedButton", X = localx, Y = localy + 10, Group = "Combat_Menu" })
		components["Locked"..itemIndex].TitleTextBoxId = components.InfoBackground.Id
		components["Locked"..itemIndex].DescriptionTextBoxId = components.InfoBackgroundDescription.Id
		components["Locked"..itemIndex].CurrentLevelId = components.CurrentLevel.Id
		components["Locked"..itemIndex].LevelProgressId = components.LevelProgress.Id
		components["Locked"..itemIndex].Unavailable = true
		ScreenAnchors.AwardMenuScreen[components["Locked"..itemIndex].Id] = components["Locked"..itemIndex]
	end

	if GameState.LifetimeResourcesGained.SuperGiftPoints ~= nil and GameState.LifetimeResourcesGained.SuperGiftPoints > 0 and hasUnlockedKeepsakes then
		components.CurrentKeys = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
		CreateTextBox({ Id = components.CurrentKeys.Id,
			Text = "Available_SuperGiftPoints",
			FontSize = 24,
			OffsetX = 330,
			OffsetY = 135,
			Color = Color.White,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0,
			ShadowColor = {0,0,0,1},
			ShadowOffset={0, 2},
			Justification = "Right",
			LuaKey = "TempTextData",
			LuaValue = { Amount = tostring(GameState.Resources.SuperGiftPoints)}
		})
	end

	if not 	UIData.AwardMenu.HasUnlocked then
		if components["UpgradeToggle1"] ~= nil then
			SetCursorFrame( components["UpgradeToggle1"] )
			TeleportCursor({ OffsetX = startX - spacerX * rowMin/2, OffsetY = startY})
		end
		thread( PlayVoiceLines, GlobalVoiceLines.AwardMenuEmptyVoiceLines, false )
	elseif UIData.AwardMenu.FirstNewLegendary then
		thread( PlayVoiceLines, GlobalVoiceLines.AwardMenuNewLegendaryVoiceLines, false )
		GameState.Flags.FirstNewLegendary = true
	elseif UIData.AwardMenu.NewLegendary then
		thread( PlayVoiceLines, GlobalVoiceLines.AwardMenuNewAvailableVoiceLines, false )
	elseif UIData.AwardMenu.HasNew then
		thread( PlayVoiceLines, GlobalVoiceLines.AwardMenuNewAvailableVoiceLines, false )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.OpenedAwardMenuVoiceLines, false )
	end

	ScreenAnchors.AwardMenuScreen.KeepOpen = true
	thread( HandleWASDInput, ScreenAnchors.AwardMenuScreen )
	HandleScreenInput( ScreenAnchors.AwardMenuScreen )

end

function CreateKeepsakeIcon( components, args )
	args = args or {}
	local screen = args.Screen
	local localx = args.X
	local localy = args.Y
	local rankOffsetY = args.RankOffsetY or 70
	local itemIndex = args.Index
	local upgradeData = args.UpgradeData
	local keyAppend = args.KeyAppend or ""
	local scale = args.Scale or 0.75


	local buttonKey = "UpgradeToggle"..itemIndex..keyAppend
	components[buttonKey.."Frame"] = CreateScreenComponent({ Name = "BlankObstacle", X = localx, Y = localy + 10, Group = "Combat_Menu" })
	SetAnimation({ DestinationId = components[buttonKey.."Frame"].Id , Name = "Keepsake_BackingMenu" })
	SetScale({ Id = components[buttonKey.."Frame"].Id, Fraction = scale })

	components[buttonKey] = CreateScreenComponent({ Name = "RadioButton", Scale = UIData.AwardMenu.BaseIconScale, X = localx, Y = localy, Group = "Combat_Menu" })
	components[buttonKey].TitleTextBoxId = components.InfoBackground.Id
	components[buttonKey].DescriptionTextBoxId = components.InfoBackgroundDescription.Id
	components[buttonKey].CurrentLevelId = components.CurrentLevel.Id
	components[buttonKey].LevelProgressId = components.LevelProgress.Id
	components[buttonKey].Data = upgradeData
	components[buttonKey].ButtonKey = buttonKey
	components[buttonKey].FrameId = components[buttonKey.."Frame"].Id

	local traitName = upgradeData.Gift

	local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = GetRarityKey(GetKeepsakeLevel( traitName )) })
	ExtractValues( CurrentRun.Hero, traitData, traitData )
	components[buttonKey].TraitData = traitData

	if not upgradeData.Unlocked then
		SetColor({ Id = components[buttonKey].Id, Color = Color.DarkSlateGray })
	else
		UIData.AwardMenu.HasUnlocked = true
		components[buttonKey.."Bar"] = CreateScreenComponent({ Name = "KeepsakeBar", X = localx, Y = localy + 80, Group = "Combat_Menu" })
		components[buttonKey.."Rank"] = CreateScreenComponent({ Name = "KeepsakeRank" .. GetKeepsakeLevel( traitData.Name ), X = localx, Y = localy + rankOffsetY, Group = "Combat_Menu" })
		components[buttonKey.."BarFill"] = CreateScreenComponent({ Name = "KeepsakeBarFill", X = localx, Y = localy + 80, Group = "Combat_Menu" })
		SetAnimationFrameTarget({ Name = "KeepsakeBarFill", Fraction = GetKeepsakeProgress( traitData.Name ), DestinationId = components[buttonKey.."BarFill"].Id, Instant = true })
		SetAlpha({ Id = components[buttonKey.."Bar"].Id, Fraction = 0, Duration = 0 })
		SetAlpha({ Id = components[buttonKey.."BarFill"].Id, Fraction = 0, Duration = 0 })
	end

	if traitData.Slot == "Keepsake" and IsGameStateEligible( CurrentRun, GiftData[upgradeData.NPC].MaxedRequirement ) then
		components[buttonKey.."Sticker"] = CreateScreenComponent({ Name = "BlankObstacle", X = localx + 37, Y = localy - 40, Group = "Combat_Menu_TraitTray" })
		SetAnimation({ Name = GiftData[upgradeData.NPC].MaxedIcon, DestinationId = components[buttonKey.."Sticker"].Id })
		SetAnimation({ DestinationId = components[buttonKey.."Frame"].Id , Name = "Keepsake_BackingMenu_StickerShadow" })
	end

	components[buttonKey].OnPressedFunctionName = "HandleUpgradeToggle"
	ScreenAnchors.AwardMenuScreen[components[buttonKey].Id] = components[buttonKey]
	if TraitData[upgradeData.Gift].Icon and upgradeData.Unlocked then

		local icon = TraitData[upgradeData.Gift].InRackIcon or TraitData[upgradeData.Gift].Icon
		SetAnimation({ DestinationId = components[buttonKey].Id, Name = icon })
		if not CanFreeSwapKeepsakes() and ( Contains(CurrentRun.BlockedKeepsakes, upgradeData.Gift) or ( HeroSlotFilled("Shout") and not HeroHasTrait("HadesShoutTrait") and upgradeData.Gift == "HadesShoutKeepsake" ) or ( GameState.LastAssistTrait ~= nil and TraitData[upgradeData.Gift].Slot == "Assist" and upgradeData.Gift ~= ScreenAnchors.AwardMenuScreen.LastAssist )) then
			components[buttonKey.."Lock"] = CreateScreenComponent({ Name = "BlankObstacle", X = localx, Y = localy, Group = "Combat_Menu" })
			SetAnimation({ DestinationId = components[buttonKey.."Lock"].Id , Name = "LockedKeepsakeIcon" })
			SetColor({ Id = components[buttonKey].Id, Color = Color.DarkSlateGray })
			if components[buttonKey.."Sticker"] then
				SetColor({ Id = components[buttonKey.."Sticker"].Id, Color = Color.SlateGray })
			end
			components[buttonKey].OnPressedFunctionName = "BlockedKeepsakePresentation"
			components[buttonKey].Blocked = true
		elseif not UIData.AwardMenu.FirstUsable and ScreenAnchors.AwardMenuScreen.LastTrait == nil and ScreenAnchors.AwardMenuScreen.LastAssist == nil then
			SetCursorFrame( components[buttonKey] )
			DebugPrint({Text = " cursor frame 2" })
			TeleportCursor({ OffsetX = localx, OffsetY = localy, ForceUseCheck = true })
			UIData.AwardMenu.FirstUsable  = true
		elseif ScreenAnchors.AwardMenuScreen.LastTrait == upgradeData.Gift or ScreenAnchors.AwardMenuScreen.LastAssist == upgradeData.Gift then
			SetSelectedFrame( components[buttonKey] )
			SetCursorFrame( components[buttonKey] )
			TeleportCursor({ OffsetX = localx, OffsetY = localy, ForceUseCheck = true })
		end
	else
		SetAnimation({ DestinationId = components[buttonKey].Id, Name = "Keepsake_Unknown" })
	end

	if upgradeData.New then
		UIData.AwardMenu.HasNew = true
		CreateTextBox({ Id = components[buttonKey].Id, Text = "NewGiftPrefix", OffsetX = 0, OffsetY = -50,
			FontSize = 18,
			Color = {255, 235, 128, 255},
			Font = "AlegreyaSansSCBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
			OutlineThickness = 12, OutlineColor = {0,0,0,1},
			Justification = "Center",
		})
	end

	if args.AddUpgradeButton and upgradeData.Unlocked then
		components[buttonKey.."Upgrade"] = CreateScreenComponent({ Name = "AssistUpgradeButton", Group = "Combat_Menu_TraitTray", X = ScreenCenterX + 40, Y = 220, Scale = 0.5})
		Attach({ Id = components[buttonKey.."Upgrade"].Id, DestinationId = components[buttonKey].Id, OffsetX = 0, OffsetY = 160 })
		components[buttonKey.."Upgrade"].OnPressedFunctionName = "UpgradeAssistKeepsake"
		components[buttonKey.."Upgrade"].GiftName = traitData.Name
		components[buttonKey.."Upgrade"].Data = traitData
		components[buttonKey.."Upgrade"].ParentButton = components[buttonKey]

		table.insert( ScreenAnchors.AwardMenuScreen.UpgradeButtons, components[buttonKey.."Upgrade"] )

		local text = ResourceData.SuperGiftPoints.RequirementText
		local fontSize = 32
		if IsKeepsakeMaxed( traitData.Name ) then
			UseableOff({ Id = components[buttonKey.."Upgrade"].Id })
		else
			local color = Color.White
			if not HasResource( "SuperGiftPoints", GetAssistKeepsakeUpgradeCost( traitData.Name )) then
				color = Color.Red
			end

			CreateTextBox({ Id = components[buttonKey.."Upgrade"].Id, Text = text, TextSymbolScale = 0.7, FontSize = fontSize, Font = "AlegreyaSansSCBold", OffsetX = 35, OffsetY = 0, Color = color, LuaKey = "TempTextData", LuaValue = { Amount = GetAssistKeepsakeUpgradeCost( traitData.Name )}})
		end
		ScreenAnchors.AwardMenuScreen[components[buttonKey.."Upgrade"].Id] = components[buttonKey.."Upgrade"]
	end
end

OnMouseOver{ "AssistUpgradeButton",
	function( triggerArgs )
		if triggerArgs.triggeredById == nil or not IsScreenOpen("AwardMenu") or ScreenAnchors.AwardMenuScreen == nil then
			return
		end
		local button = ScreenAnchors.AwardMenuScreen[triggerArgs.triggeredById]
		SetCursorFrame( button.ParentButton )

		local traitName = button.ParentButton.TraitData
		if traitName then
			local traitData = button.ParentButton.TraitData
			local traitName = traitData.Name
			local newTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = GetRarityKey(GetKeepsakeLevel( traitData.Name ) + 1 )})
			SetTraitTextData( traitData, { ReplacementTraitData = newTraitData } )
			ModifyTextBox({ Id = button.ParentButton.DescriptionTextBoxId, Text = traitData.Name .. "_Delta", UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData })
			local text = "UnEquipped_Subtitle"
			if GameState.LastAssistTrait == traitName then
				text = "AssistTraitUpgrade_Subtitle"
			end
			ModifyTextBox({ Id = ScreenAnchors.AwardMenuScreen.Components.EquipSubtitle.Id, Text = text, ColorTarget = Color.White, ColorDuration = 0 })
		end
	end
}

OnMouseOff{ "AssistUpgradeButton",
	function( triggerArgs )
		DestroyCursorFrame( )
	end
}

OnMouseOver{ "LegendaryKeepsakeLockedButton",
	function( triggerArgs )
		if triggerArgs.triggeredById == nil or not IsScreenOpen("AwardMenu") or ScreenAnchors.AwardMenuScreen == nil then
			return
		end
		if ScreenAnchors.AwardMenuScreen.Components and ScreenAnchors.AwardMenuScreen.Components.Sticker then
			SetAnimation({Name = "Blank", DestinationId = ScreenAnchors.AwardMenuScreen.Components.Sticker.Id })
		end
		SetLegendaryFrame( triggerArgs.triggeredById )
	end
}

OnMouseOff{ "LegendaryKeepsakeLockedButton",
	function( triggerArgs )
		DestroyCursorFrame( )
	end
}
OnMouseOver{ "RadioButton",
	function( triggerArgs )
		if triggerArgs.triggeredById == nil or not IsScreenOpen("AwardMenu") or ScreenAnchors.AwardMenuScreen == nil or ScreenAnchors.AwardMenuScreen[triggerArgs.triggeredById] == nil then
			return
		end
		local button = ScreenAnchors.AwardMenuScreen[triggerArgs.triggeredById]
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuToggleKeepsakes", Id = button.TitleTextBoxId })
		SetCursorFrame( button )
	end
}

OnMouseOff{ "RadioButton",
	function( triggerArgs )
		if IsScreenOpen("AwardMenu") then		
			local components = ScreenAnchors.AwardMenuScreen.Components
			local button = ScreenAnchors.AwardMenuScreen[triggerArgs.triggeredById]
			if not button.Blocked then
				DestroyCursorFrame( )
				SetScale({ Id = button.Id, Fraction = UIData.AwardMenu.BaseIconScale, Duration = 0.1, EaseIn = 0, EaseOut = 1 })
			end
			if button.Data.Unlocked then
				SetAlpha({ Id = components[button.ButtonKey.."Bar"].Id, Fraction = 0, Duration = 0.3 })
				SetAlpha({ Id = components[button.ButtonKey.."BarFill"].Id, Fraction = 0, Duration = 0.1 })
			end
		end
	end
}

function SetCursorFrame( button )
	local components = ScreenAnchors.AwardMenuScreen.Components
	if ScreenAnchors.AwardMenuScreen.HoverFrame == nil then
		ScreenAnchors.AwardMenuScreen.HoverFrame = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_Additive" })
		-- SetScale({ Id = ScreenAnchors.AwardMenuScreen.HoverFrame, Fraction = 1.4})
	end
	
	Teleport({ Id = ScreenAnchors.AwardMenuScreen.HoverFrame, DestinationId = button.Id})
	if TraitData[button.Data.Gift].Slot == "Assist" then
		SetAnimation({ Name = "LegendaryAwardMenuCursorHighlight", DestinationId = ScreenAnchors.AwardMenuScreen.HoverFrame })
		SetAnimation({ Name = "Blank", DestinationId = components.Sticker.Id })
		
	else
		SetAnimation({ Name = "AwardMenuCursorHighlight", DestinationId = ScreenAnchors.AwardMenuScreen.HoverFrame })
		if IsGameStateEligible( CurrentRun, GiftData[button.Data.NPC].MaxedRequirement ) then
			SetAnimation({ Name = GiftData[button.Data.NPC].MaxedSticker, DestinationId = components.Sticker.Id })
		else
			SetAnimation({Name = "Blank", DestinationId = components.Sticker.Id })
		end

	end
	if not button.Data.Unlocked then
		ModifyTextBox({ Id = button.TitleTextBoxId, Text = "UnknownAward" })
		ModifyTextBox({ Id = button.DescriptionTextBoxId, Text = "UnknownAward", UseDescription = true })
		-- This should call Textbox.Clear instead of setting to a blank string
		ModifyTextBox({ Id = components.EquipSubtitle.Id, Text = " " })
		ModifyTextBox({ Id = button.CurrentLevelId, Text = " " })
		ModifyTextBox({ Id = button.LevelProgressId, Text = " " })
	else
		local traitData = button.TraitData
		local showKeepsakePreview = true

		local traitTooltip = GetTraitTooltip(traitData, { UnequippedKeepsakePreview = showKeepsakePreview, InKeepsakePreview = true })
		ModifyTextBox({ Id = button.TitleTextBoxId, Text = traitTooltip })

		ModifyTextBox({ Id = button.DescriptionTextBoxId, Text = traitTooltip, UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData })
		if traitData.Slot == "Assist" then
			ModifyTextBox({ Id = button.CurrentLevelId, Text = "LegendaryKeepsake_Level_"..GetKeepsakeLevel(button.TraitData.Name), LuaKey = "TempTextData", LuaValue = { Level = GetKeepsakeLevel(button.TraitData.Name) }})
		else
			ModifyTextBox({ Id = button.CurrentLevelId, Text = "Keepsake_Level_"..GetKeepsakeLevel(button.TraitData.Name), LuaKey = "TempTextData", LuaValue = { Level = GetKeepsakeLevel(button.TraitData.Name) }})
		end
		if IsKeepsakeMaxed( button.TraitData.Name ) then
			ModifyTextBox({ Id = button.LevelProgressId, Text = "Keepsake_Level_Progress_Max" })
		else
			if button.TraitData.KeepsakeRarityGameStateRequirements then
				if not IsKeepsakeMaxed( button.TraitData.Name ) then
					ModifyTextBox({ Id = button.LevelProgressId, Text = "Legendary_Keepsake_Level_Progress", LuaKey = "TempTextData", LuaValue = { NPCName = button.Data.NPC }})
				else
					ModifyTextBox({ Id = button.LevelProgressId, Text = "Keepsake_Level_Progress_Max" })
				end
			else
				ModifyTextBox({ Id = button.LevelProgressId, Text = "Keepsake_Level_Progress", LuaKey = "TempTextData", LuaValue = { Chambers = GetKeepsakeChambersToNextLevel(button.TraitData.Name) }})
			end
		end

		if button.Blocked then
			if ( HeroSlotFilled("Shout") and not HeroHasTrait("HadesShoutTrait") and traitData.Name == "HadesShoutKeepsake" ) then
				ModifyTextBox({ Id = components.EquipSubtitle.Id, Text = "Hades_Keepsake_Blocked_Subtitle", Color = Color.LightSlateGray })
			else
				ModifyTextBox({ Id = components.EquipSubtitle.Id, Text = "Keepsake_Blocked_Subtitle", Color = Color.LightSlateGray })
			end
		else
			SetScale({ Id = button.Id, Fraction = UIData.AwardMenu.HoverIconScale, Duration = 0.1, EaseIn = 0, EaseOut = 1 })
			local upgradeName = button.Data.Gift
			if GameState.LastAwardTrait ~= upgradeName and GameState.LastAssistTrait ~= upgradeName then
				ModifyTextBox({ Id = components.EquipSubtitle.Id, Text = "UnEquipped_Subtitle", ColorTarget = Color.White, ColorDuration = 0 })
			else
				ModifyTextBox({ Id = components.EquipSubtitle.Id, Text = "Equipped_Subtitle", ColorTarget = Color.Gold, ColorDuration = 0 })
			end
			DestroyTextBox({ Id = button.Id })

			RemoveValue(GameState.Gift[button.Data.NPC].NewTraits, upgradeName)
		end
		if button and button.ButtonKey and components[button.ButtonKey.."Bar"] and TraitData[button.Data.Gift].Slot ~= "Assist" then
			SetAlpha({ Id = components[button.ButtonKey.."Bar"].Id, Fraction = 1, Duration = 0.1 })
			SetAlpha({ Id = components[button.ButtonKey.."BarFill"].Id, Fraction = 1, Duration = 0.3 })
		end
	end
	
	if ScreenAnchors.AwardMenuScreen.OpenedToButtonKey 
		and ScreenAnchors.AwardMenuScreen.OpenedToButtonKey ~= button.ButtonKey 
		and TraitData[button.Data.Gift].Slot ~= "Assist" 
		and components[ScreenAnchors.AwardMenuScreen.OpenedToButtonKey.."Bar"] 
		and components[ScreenAnchors.AwardMenuScreen.OpenedToButtonKey.."BarFill"]then

		SetAlpha({ Id = components[ScreenAnchors.AwardMenuScreen.OpenedToButtonKey.."Bar"].Id, Fraction = 0, Duration = 0.1 })
		SetAlpha({ Id = components[ScreenAnchors.AwardMenuScreen.OpenedToButtonKey.."BarFill"].Id, Fraction = 0, Duration = 0.3 })
	end
	if TraitData[button.Data.Gift].Slot ~= "Assist" then
		ScreenAnchors.AwardMenuScreen.OpenedToButtonKey = button.ButtonKey
	end
end

function DestroyCursorFrame()
	if ScreenAnchors.AwardMenuScreen ~= nil then
		Destroy({ Id = ScreenAnchors.AwardMenuScreen.HoverFrame })
		ScreenAnchors.AwardMenuScreen.HoverFrame = nil
	end
end

function SetLegendaryFrame( id )

	if ScreenAnchors.AwardMenuScreen.HoverFrame == nil then
		ScreenAnchors.AwardMenuScreen.HoverFrame = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_Additive" })
	end
	Teleport({ Id = ScreenAnchors.AwardMenuScreen.HoverFrame, DestinationId = id, OffsetY = - 30})
	SetAnimation({ Name = "LegendaryAwardMenuCursorHighlight", DestinationId = ScreenAnchors.AwardMenuScreen.HoverFrame })
	local components = ScreenAnchors.AwardMenuScreen.Components
	local button = ScreenAnchors.AwardMenuScreen[id]

	local text = "UnknownLegendaryAward"
	if not UIData.AwardMenu.FirstNewLegendary then
		text = "UnknownLegendaryAward_Hidden"
	end
	if button.Unavailable then
		if not UIData.AwardMenu.FirstNewLegendary then
			text = "UnknownLegendaryAward_Locked_Hidden"
		else
			text = "UnknownLegendaryAward_Locked"
		end
	end
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuToggleKeepsakes", Id = button.TitleTextBoxId })
	ModifyTextBox({ Id = button.TitleTextBoxId, Text = text })
	ModifyTextBox({ Id = button.DescriptionTextBoxId, Text = text, UseDescription = true })
		-- This should call Textbox.Clear instead of setting to a blank string
	ModifyTextBox({ Id = components.EquipSubtitle.Id, Text = " " })
	ModifyTextBox({ Id = button.CurrentLevelId, Text = " " })
	ModifyTextBox({ Id = button.LevelProgressId, Text = " " })
end

function SetSelectedFrame( button )
	local frameKey = "SelectedFrame"
	local selectedFramedAnimation = UIData.AwardMenu.NormalSelectionFrame
	if TraitData[button.Data.Gift].Slot == "Assist" then
		frameKey = "SelectedAssistFrame"
		selectedFramedAnimation = UIData.AwardMenu.LegendarySelectionFrame
	end

	if ScreenAnchors.AwardMenuScreen[frameKey] == nil then
		ScreenAnchors.AwardMenuScreen[frameKey] = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu" })
	end
	SetAnimation({ Name = selectedFramedAnimation, DestinationId = ScreenAnchors.AwardMenuScreen[frameKey] })
	Teleport({ Id = ScreenAnchors.AwardMenuScreen[frameKey], DestinationId = button.Id})
end

function DestroySelectedFrame()
	Destroy({ Id = ScreenAnchors.AwardMenuScreen.SelectedFrame })
	Destroy({ Id = ScreenAnchors.AwardMenuScreen.SelectedAssistFrame})
	ScreenAnchors.AwardMenuScreen.SelectedFrame = nil
	ScreenAnchors.AwardMenuScreen.SelectedAssistFrame = nil
end

function CanFreeSwapKeepsakes()
	return ( CurrentDeathAreaRoom ~= nil and CurrentDeathAreaRoom.KeepsakeFreeSwap ) or CurrentRun.CurrentRoom.KeepsakeFreeSwap
end

function CloseUpgradeScreen( screen, button )
	SetConfigOption({ Name = "FreeFormSelectRepeatDelay", Value = 0.0 })
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CabinetClose" })
	if ScreenAnchors.AwardMenuScreen.LastAssist ~= GameState.LastAssistTrait then
		UnequipAssist( CurrentRun.Hero, ScreenAnchors.AwardMenuScreen.LastAssist)
		EquipAssist( CurrentRun.Hero, GameState.LastAssistTrait )
	end

	if ScreenAnchors.AwardMenuScreen.LastTrait ~= GameState.LastAwardTrait then
		UnequipKeepsake( CurrentRun.Hero, ScreenAnchors.AwardMenuScreen.LastTrait )
		EquipKeepsake( CurrentRun.Hero, GameState.LastAwardTrait )

		if not CanFreeSwapKeepsakes() then
			if CurrentRun.BlockedKeepsakes == nil then
				CurrentRun.BlockedKeepsakes = {}
			end
			CurrentRun.CurrentRoom.BlockKeepsakeMenu = true
			table.insert(CurrentRun.BlockedKeepsakes, ScreenAnchors.AwardMenuScreen.LastTrait )

			if GameState.LastAwardTrait == "BonusMoneyTrait" then
				AddMoney( GetTotalHeroTraitValue( "BonusMoney" ), "Bonus Money Keepsake" )
			end

			if CurrentRun.CurrentRoom.AwardMenuObject then
				CurrentRun.CurrentRoom.AwardMenuObject.UseText = "UseLockedGiftRack"
				SetAnimation({ Name = "GiftRackClosed", DestinationId = CurrentRun.CurrentRoom.AwardMenuObject.ObjectId })
				PlaySound({ Name = RoomData.BaseRoom.LockedUseSound, Id = CurrentRun.CurrentRoom.AwardMenuObject.ObjectId })
			end
		end
		thread( PlayVoiceLines, GlobalVoiceLines.AwardSelectedVoiceLines, false )
	end

	DestroySelectedFrame()
	DestroyCursorFrame()
	DisableShopGamepadCursor()
	OnScreenClosed({Flag = "AwardMenu"})

	CloseScreen ( GetAllIds( screen.Components ), 0.15 )
	ScreenAnchors.AwardMenuScreen = nil

	UnfreezePlayerUnit()
	screen.KeepOpen = false
	ShowCombatUI("AwardMenu")
	UpdateGiftRackShineStatus()
end

function HandleUpgradeToggle( screen, button, textOverride )
	local upgradeName = button.Data.Gift
	local upgradeData = TraitData[upgradeName]
	local buttonId = button.Id
	local components = screen.Components
	if not button.Data.Unlocked then
		return
	end
	local changed = false
	if upgradeData.Slot == "Assist" and GameState.LastAssistTrait ~= upgradeName then
		GameState.LastAssistTrait = upgradeName
		changed = true
		CheckAchievement({ Name = "AchFoundSummon" })
	elseif upgradeData.Slot == "Keepsake" and GameState.LastAwardTrait ~= upgradeName then
		GameState.LastAwardTrait = upgradeName
		changed = true
	end

	if changed then
		SetSelectedFrame( button )
		ModifyTextBox({ Id = ScreenAnchors.AwardMenuScreen.Components.EquipSubtitle.Id, Text = textOverride or "Equipped_Subtitle", ColorTarget = Color.White, ColorDuration = 0.0, ScaleTarget = 1.4, ScaleDuration = 0.1 })
		ModifyTextBox({ Id = ScreenAnchors.AwardMenuScreen.Components.EquipSubtitle.Id, Text = textOverride or "Equipped_Subtitle", ColorTarget = Color.Gold, ColorDuration = 0.35, ScaleTarget = 1, ScaleDuration = 0.25, Delay = 0.1 })
		PlaySound({ Name = upgradeData.EquipSound or "/Leftovers/Menu Sounds/TalismanPowderDownLEGENDARY" })
		RemoveValue( GameState.Gift[button.Data.NPC].NewTraits, upgradeName )

	end
end
function GetAssistKeepsakeLevel( giftName )
	local level = 1
	if GameState.AssistUnlocks and GameState.AssistUnlocks[giftName] then
		level = GameState.AssistUnlocks[giftName] + 1
	end
	return level
end

function GetAssistKeepsakeUpgradeCost( giftName )
	local currentLevel = 1
	local costTable = AssistUpgradeData[ giftName ]
	if GameState.AssistUnlocks and GameState.AssistUnlocks[giftName] then
		currentLevel = GameState.AssistUnlocks[giftName] + 1
	end
	 return costTable.Costs[currentLevel]
end

function UpgradeAssistKeepsake( screen, button )
	if button.ParentButton.Blocked then
		return
	end

	local giftName = button.GiftName
	if GameState.LastAssistTrait ~= giftName then
		HandleUpgradeToggle( screen, button.ParentButton, "AssistTraitUpgrade_Subtitle")
		return
	end
	local cost = GetAssistKeepsakeUpgradeCost( giftName )
	local components = ScreenAnchors.AwardMenuScreen.Components
	SetCursorFrame( button.ParentButton )
	HandleUpgradeToggle( screen, button.ParentButton )
	-- check for maximum
	if HasResource( "SuperGiftPoints", cost ) and GetAssistKeepsakeLevel(giftName) < 5 then
		IncrementTableValue( GameState.AssistUnlocks, button.GiftName )
		SpendResource( "SuperGiftPoints", cost, button.GiftName.."KeepsakeUpgrade", { Silent = true, SkipUpdateResourceUI = true, })
		if components.CurrentKeys then
			ModifyTextBox({ Id = components.CurrentKeys.Id,
				Text = "Available_SuperGiftPoints",
				LuaKey = "TempTextData",
				LuaValue = { Amount = tostring(GameState.Resources.SuperGiftPoints)}
			})
		end

		for i, otherButton in pairs(ScreenAnchors.AwardMenuScreen.UpgradeButtons) do
			if HasResource( "SuperGiftPoints", GetAssistKeepsakeUpgradeCost( otherButton.GiftName )) then
				ModifyTextBox({ Id = otherButton.Id, Text = ResourceData.SuperGiftPoints.RequirementText, ColorTarget = Color.White })
			else
				ModifyTextBox({ Id = otherButton.Id, Text = ResourceData.SuperGiftPoints.RequirementText, ColorTarget = Color.Red })
			end
		end

		local traitTooltip = GetTraitTooltip(button.Data, { InKeepsakePreview = true })
		local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = giftName, Rarity = GetRarityKey(GetKeepsakeLevel( giftName )) })
		ExtractValues( CurrentRun.Hero, traitData, traitData )
		button.ParentButton.TraitData = traitData
		button.Data = traitData
		ModifyTextBox({ Id = components.InfoBackgroundDescription.Id, Text = traitTooltip, UseDescription = true, LuaKey = "TooltipData", LuaValue = button.Data })
		ModifyTextBox({ Id = components.InfoBackground.Id, Text = traitTooltip })
		SetAnimation({ DestinationId = components[button.ParentButton.ButtonKey.."Rank"].Id, Name = "KeepsakeRank" .. GetKeepsakeLevel( traitData.Name )})
		thread( UpgradeKeepsakePresentation, button )

		if IsKeepsakeMaxed( button.GiftName ) then
			ModifyTextBox({ Id = button.ParentButton.LevelProgressId, Text = "Keepsake_Level_Progress_Max" })
			ModifyTextBox({ Id = components.CurrentLevel.Id, Text = "LegendaryKeepsake_Level_"..GetKeepsakeLevel(button.GiftName), LuaKey = "TempTextData", LuaValue = { Level = GetKeepsakeLevel(button.GiftName) }})

			DestroyTextBox({ Id = button.Id })
			UseableOff({ Id = button.Id })
		else
			ModifyTextBox({ Id = button.Id, Text = ResourceData.SuperGiftPoints.RequirementText, LuaKey = "TempTextData", LuaValue = { Amount = GetAssistKeepsakeUpgradeCost( button.GiftName )}})
			ModifyTextBox({ Id = components.CurrentLevel.Id, Text = "LegendaryKeepsake_Level_"..GetKeepsakeLevel(button.GiftName), LuaKey = "TempTextData", LuaValue = { Level = GetKeepsakeLevel(button.GiftName) }})
			local traitName = traitData.Name
			local newTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = GetRarityKey(GetKeepsakeLevel( traitData.Name ) + 1 )})
			SetTraitTextData( traitData, { ReplacementTraitData = newTraitData } )
			ModifyTextBox({ Id = button.ParentButton.DescriptionTextBoxId, Text = traitData.Name .. "_Delta", UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData })
			ModifyTextBox({ Id = components.EquipSubtitle.Id, Text = "AssistTraitUpgrade_Subtitle", ColorTarget = Color.White, ColorDuration = 0 })
		end
		if not button.ParentButton.Blocked and HeroHasTrait( button.GiftName ) then
			local searchTable = CurrentRun.Hero.Traits
			if CurrentRun.Hero.TraitDictionary then
				searchTable = CurrentRun.Hero.TraitDictionary[button.GiftName]
			end
			if not searchTable then
				return nil
			end

			for k, existingTrait in pairs( searchTable ) do
				if existingTrait.Name == button.GiftName then
					existingTrait.RemainingUses = existingTrait.RemainingUses + 1
					break
				end
			end
		end
	elseif GetAssistKeepsakeLevel(giftName) >= 5 then
		MaxxedOutKeepsakeUpgrade( button )
		thread( PlayVoiceLines, GlobalVoiceLines.MaxedLegendaryVoiceLines, false )
	else
		-- can't afford presentation'
		CannotAffordKeepsakeUpgrade( button )
		thread( PlayVoiceLines, HeroVoiceLines.NotEnoughSuperGiftPointsVoiceLines, false )
		if not IsKeepsakeMaxed( button.GiftName ) then
			local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = giftName, Rarity = GetRarityKey(GetKeepsakeLevel( giftName )) })
			local traitName = traitData.Name
			local newTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = GetRarityKey(GetKeepsakeLevel( traitData.Name ) + 1 )})
			SetTraitTextData( traitData, { ReplacementTraitData = newTraitData } )
			ModifyTextBox({ Id = button.ParentButton.DescriptionTextBoxId, Text = traitData.Name .. "_Delta", UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData })
		end
	end
end