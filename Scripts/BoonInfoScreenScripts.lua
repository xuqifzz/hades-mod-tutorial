function ShowBoonInfoScreen( lootName )
	OnScreenOpened( { Flag = "BoonInfoScreen", PersistCombatUI = true } )
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_TraitTray_Backing" })
	
	FreezePlayerUnit("BoonInfoScreen" )

	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoud" })	

	ScreenAnchors.BoonInfoScreen = { LootName = lootName, StartingIndex = 1, Components = {}, Name = "BoonInfoScreen", TraitContainers = {}, TraitRequirements = {} }
	local screen = ScreenAnchors.BoonInfoScreen
	local components = ScreenAnchors.BoonInfoScreen.Components
	BoonInfoPopulateTraits( screen )
	EnableShopGamepadCursor( ScreenAnchors.BoonInfoScreen.Name )
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 32 })
	SetConfigOption({ Name = "FreeFormSelectSuccessDistanceStep", Value = 18 })
	if IsScreenOpen("Codex") then
		screen.OldFreeFormSelecSearchFromId = GetConfigOptionValue({ Name = "FreeFormSelecSearchFromId" })
		CodexUI.Screen.Components.CloseButton.OnPressedFunctionName = nil
	end

	components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu_TraitTray_Backing" })
	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 10 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.090, 0.055, 0.157, 0.6} })

	components.ShopBackground = CreateScreenComponent({ Name = "BoonInfoBacking", Group = "Combat_Menu_TraitTray_Backing", X = ScreenCenterX, Y = ScreenHeight/2 })

	components.PageUp = CreateScreenComponent({ Name = "ButtonCodexUp", Scale = 0.8, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu_TraitTray_Backing" })	
	Attach({ Id = components.PageUp.Id, DestinationId = components.ShopBackground.Id, OffsetX = -400 , OffsetY = -395 })
	components.PageUp.OnPressedFunctionName = "BoonInfoScreenPrevious"
	components.PageUp.ControlHotkey = "MenuUp"
	
	components.PageDown = CreateScreenComponent({ Name = "ButtonCodexDown", Scale = 0.8, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu_TraitTray_Backing" })
	Attach({ Id = components.PageDown.Id, DestinationId = components.ShopBackground.Id, OffsetX = -400 , OffsetY = 415 })	
	components.PageDown.OnPressedFunctionName = "BoonInfoScreenNext"
	components.PageDown.ControlHotkey = "MenuDown"

	
	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Scale = 1, Group = "Combat_Menu_TraitTray_Backing" })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = 0 , OffsetY = 490 })
	components.CloseButton.OnPressedFunctionName = "CloseBoonInfoScreen"
	components.CloseButton.ControlHotkey = "Cancel"
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "Codex_BoonInfo_Title",
		FontSize = 32,
		OffsetX = 0, OffsetY = -487,
		Color = Color.White,
		Font = "SpectralSCLightTitling",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
		OutlineThickness = 3,
		Justification = "Center",
		LuaKey = "TempTextData",
		LuaValue = { BoonName = lootName }
	})

	for i = screen.StartingIndex, screen.StartingIndex + BoonInfoScreenData.NumPerPage - 1 do 
		CreateBoonInfoButton( screen.SortedTraitIndex[i], i )
	end
	TeleportCursor({ DestinationId = ScreenAnchors.BoonInfoScreen.Components["BooninfoButton1"].DetailsBacking.Id, ForceUseCheck = true })

	components.RequirementsTitle = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
	Attach({ Id = components.RequirementsTitle.Id, DestinationId = components.ShopBackground.Id, OffsetX = 100 , OffsetY = -405 })
	CreateTextBox(MergeTables({
		Id = components.RequirementsTitle.Id,
		Text = "BoonInfo_Requirements",
		FontSize = 28,
		OffsetX = 75,
		OffsetY = 60,
		Color = color,
		Font = "AlegreyaSansSCLight",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
	}, LocalizationData.BoonInfoScreenScripts.RequirementsTitle ))
	
	UpdateBoonInfoPageButtons( screen )


	ScreenAnchors.BoonInfoScreen.KeepOpen = true
	ScreenAnchors.BoonInfoScreen.CanClose = true
	thread( HandleWASDInput, ScreenAnchors.BoonInfoScreen )
	HandleScreenInput( ScreenAnchors.BoonInfoScreen )
end

function CreateBoonInfoButton( traitName, index )
	local traitInfo = {}
	table.insert( ScreenAnchors.BoonInfoScreen.TraitContainers, traitInfo )
	local offset = { X = 110, Y = BoonInfoScreenData.ButtonStartY + index * BoonInfoScreenData.ButtonYSpacer }
	traitInfo.DetailsBacking = CreateScreenComponent({ Name = "BoonInfoButton", Group = "Combat_Menu_TraitTray_Backing", X = offset.X + 455, Y = offset.Y + 200 })
	traitInfo.OnPressedFunctionName = "BoonInfoButtonPress"
	ScreenAnchors.BoonInfoScreen.Components["BooninfoButton"..index] = traitInfo
	
	CreateTextBoxWithFormat(MergeTables({
		Id = traitInfo.DetailsBacking.Id,
		OffsetX = -260,
		OffsetY = BoonInfoScreenData.DecriptionBoxOffsetY,
		Width = 665,
		Justification = "Left",
		VerticalJustification = "Top",
		LineSpacingBottom = 8,
		UseDescription = true,
		Format = "BaseFormat",
		VariableAutoFormat = "BoldFormatGraft",
		TextSymbolScale = 0.8,
	}, LocalizationData.TraitTrayScripts.DetailsBacking ))

	traitInfo.TitleBox = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", X = offset.X + 20, Y = offset.Y + 170 })
	CreateTextBox(MergeTables({
		Id = traitInfo.TitleBox.Id,
		FontSize = 25,
		OffsetX = 170,
		OffsetY = BoonInfoScreenData.TextBoxOffsetY,
		Color = color,
		Font = "AlegreyaSansSCLight",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
	}, LocalizationData.TraitTrayScripts.TitleBox))

	traitInfo.RarityBox = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", X = offset.X + 20, Y = offset.Y + 170 })
	CreateTextBox(MergeTables({
		Id = traitInfo.RarityBox.Id,
		FontSize = 25,
		OffsetX = 860,
		OffsetY = -17,
		Color = color,
		Font = "AlegreyaSansSCLight",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Right",
	}, LocalizationData.TraitTrayScripts.RarityBox))

	traitInfo.Patch = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", X = offset.X + 110, Y = offset.Y + 205, Scale = 0.8 })
	SetAnimation({ DestinationId = traitInfo.Patch.Id, Name = "BoonRarityPatch"})
	SetColor({ Id = traitInfo.Patch.Id, Color = Color.Transparent })

	traitInfo.Frame = CreateScreenComponent({ Name = "BoonInfoTraitFrame", Group = "Combat_Menu_TraitTray", X = offset.X + 90, Y = offset.Y + 200, Scale = 0.8 })
	traitInfo.Icon = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", X = offset.X + 90, Y = offset.Y + 200, Scale = 0.8 })
	traitInfo.QuestIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", X = offset.X + 142, Y = offset.Y + 150,})
	traitInfo.TraitName = traitName
	traitInfo.Index = index
	local newTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = "Common", ForBoonInfo = true })
	newTraitData.ForBoonInfo = true
	SetTraitTextData( newTraitData )
	SetTraitTrayDetails( { TraitData = newTraitData, ForBoonInfo = true }, traitInfo.DetailsBacking, traitInfo.RarityBox, traitInfo.TitleBox, traitInfo.Patch, traitInfo.Icon )
	if not GameState.TraitsTaken[traitName] and HasActiveQuestForTrait( traitName ) then
		SetAnimation({ DestinationId = traitInfo.QuestIcon.Id, Name = "QuestItemFound" })
	else
		SetAnimation({ DestinationId = traitInfo.QuestIcon.Id, Name = "Blank" })
	end
end

function CreateTraitRequirements( traitName )
	local screen = ScreenAnchors.BoonInfoScreen
	Destroy({Ids = screen.TraitRequirements })
	screen.TraitRequirements = {}
	local traitData = TraitData[traitName]
	if not traitData then
		traitData = ConsumableData[traitName]
	end
	local startY = 120
	local startX = 10
	local width = 500
	local hasRequirement = false
	if traitData.RequiredMetaUpgradeSelected then
		local requiredMetaUpgrade = traitData.RequiredMetaUpgradeSelected
		local requirementsText = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
		table.insert(screen.TraitRequirements, requirementsText.Id )
		Attach({ Id = requirementsText.Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = startX , OffsetY = -405 })
	
		local color = Color.White
		if IsGameStateEligible( CurrentRun, { RequiredMetaUpgradeSelected = traitData.RequiredMetaUpgradeSelected }) then
			color = Color.BoonInfoAcquired
		end
		CreateTextBox({
		Id = requirementsText.Id,
		Text = "BoonInfo_RequiredMetaupgrade",
		FontSize = 24,
		Width = 360,
		OffsetX = 200,
		OffsetY =  startY-5,
		Color = color,
		Font = "AlegreyaSansSCLight",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		LuaKey = "TempTextData",
		LuaValue = { MetaupgradeName = requiredMetaUpgrade }})
		startY = startY + 45
		hasRequirement = true

		if MetaUpgradeData[requiredMetaUpgrade] and MetaUpgradeData[requiredMetaUpgrade].Icon then
			local metaupgradeIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
			SetAnimation({ Name = MetaUpgradeData[requiredMetaUpgrade].Icon, DestinationId = metaupgradeIcon.Id })
			table.insert(screen.TraitRequirements, metaupgradeIcon.Id )
			Attach({ Id = metaupgradeIcon.Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = startX + 175, OffsetY = -290 })
		end
	end
	if traitData.RequiredTrait then
		local requirementsText = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
		table.insert(screen.TraitRequirements, requirementsText.Id )
		Attach({ Id = requirementsText.Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = startX + 35, OffsetY = -405 })
		local color = Color.BoonInfoUnacquired
		if HeroHasTrait(traitData.RequiredTrait) then
			color = Color.BoonInfoAcquired
		end
		CreateTextBox({
		Id = requirementsText.Id,
		Text = "BoonInfo_RequiredTrait",
		FontSize = 20,
		OffsetX = 170,
		OffsetY =  startY,
		Color = color,
		Font = "AlegreyaSansSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		LuaKey = "TempTextData",
		LuaValue = { TraitName = traitData.RequiredTrait}})
		startY = startY + 45
		hasRequirement = true

		
		if TraitData[traitData.RequiredTrait] and TraitData[traitData.RequiredTrait].Icon then
			local metaupgradeIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
			SetAnimation({ Name = GetTraitIcon( TraitData[traitData.RequiredTrait] ), DestinationId = metaupgradeIcon.Id })
			SetScale({ Id = metaupgradeIcon.Id, Fraction = 0.5 })
			table.insert(screen.TraitRequirements, metaupgradeIcon.Id )
			Attach({ Id = metaupgradeIcon.Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = startX + 180, OffsetY = -405 + 120 })
		end
	end
	
	if traitData.RequiredOneOfTraits then
		startY = CreateTraitRequirementList( screen, { Text = "BoonInfo_OneOf", TextSingular = "BoonInfo_OneOf_Singular" }, traitData.RequiredOneOfTraits, startY, IsGameStateEligible(CurrentRun, { RequiredOneOfTraits = traitData.RequiredOneOfTraits }))
		hasRequirement = true
	end

	if BoonInfoScreenData.TraitRequirementsDictionary[traitName] then
		hasRequirement = true
		local requirementData = BoonInfoScreenData.TraitRequirementsDictionary[traitName]
		if requirementData.Type == "OneOf" then
			startY = CreateTraitRequirementList( screen, { Text = "BoonInfo_OneOf", TextSingular = "BoonInfo_OneOf_Singular"  }, requirementData.OneOf, startY )
		elseif requirementData .Type == "OneFromEachSet" then
			for i, set in pairs(requirementData.OneFromEachSet) do		
				startY = CreateTraitRequirementList( screen, { Text = "BoonInfo_OneOf", TextSingular = "BoonInfo_OneOf_Singular"  }, set, startY )
			end
		elseif requirementData.Type == "TwoOf" then
			local allTraitsDictionary = {}
			local hasRequirement = false
			local hasAmount = 0
			for i, traitSet in pairs(requirementData .OneFromEachSet) do
				for s, traitName in pairs(traitSet) do
					allTraitsDictionary[traitName] = true
				end
			end	
			for traitName in pairs( allTraitsDictionary ) do
				if HeroHasTrait( traitName ) then
					hasAmount = hasAmount + 1
				end
			end

			startY = CreateTraitRequirementList( screen, { Text = "BoonInfo_TwoOf" }, (GetAllKeys(allTraitsDictionary)), startY, ( hasAmount >= 2 ))
		end
	end

	if not hasRequirement then
		local requirementsText = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
		table.insert(screen.TraitRequirements, requirementsText.Id )
		Attach({ Id = requirementsText.Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = startX , OffsetY = -405 })
	
		CreateTextBox({
		Id = requirementsText.Id,
		Text = "BoonInfo_NoRequirements",
		FontSize = 24,
		OffsetX = 170,
		OffsetY =  startY,
		Color = {159, 159, 159, 255},
		Font = "AlegreyaSansSCRegular",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left"})
	end
end

function CreateTraitRequirementList( screen, headerTextArgs, traitList, startY, metRequirement )
	local startX = 0
	local originalY = startY
	local requirementsText = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
	local headerText = headerTextArgs.Text
	if TableLength(traitList) == 1 and headerTextArgs.TextSingular then
		headerText = headerTextArgs.TextSingular
	end
	table.insert(screen.TraitRequirements, requirementsText.Id )
	Attach({ Id = requirementsText.Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = startX , OffsetY = -405 })
	
	local removeIndexes = {}
	for traitName in pairs (screen.HiddenTraits) do
		for i, requirementTraitName in pairs( traitList ) do

			if TraitData[requirementTraitName].RequiredTrait == traitName then
				table.insert(removeIndexes, i)
			end
		end
	end

	for _, index in pairs(removeIndexes) do
		traitList[index] = nil
	end

	traitList = CollapseTable(traitList)
	
	if metRequirement == nil then
		for i, traitName in pairs( traitList ) do
			if HeroHasTrait( traitName ) then
				metRequirement = true
			end
		end
	end

	local color = Color.White
	if metRequirement then
		color = Color.BoonInfoAcquired
	end

	CreateTextBox({
	Id = requirementsText.Id,
	Text = headerText,
	FontSize = 24,
	OffsetX = 205,
	OffsetY =  startY,
	Color = color,
	Font = "AlegreyaSansSCRegular",
	ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
	Justification = "Left"})
	startY = startY + 35
	local sharedGod = nil
	local allSame = true
	for i, traitName in ipairs(traitList) do
		if not sharedGod then
			sharedGod = GetLootSourceName( traitName )
		elseif sharedGod ~= GetLootSourceName(traitName) then
			allSame = false
		end
		local displayedTraitName = traitName
		if TraitData[traitName].BoonInfoRequirementText then
			displayedTraitName = TraitData[traitName].BoonInfoRequirementText 
		end
		local traitNamePlate = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
		table.insert(screen.TraitRequirements, traitNamePlate.Id )
		Attach({ Id = traitNamePlate.Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = startX , OffsetY = -405 })
		
		local color = Color.BoonInfoUnacquired
		if HeroHasTrait(traitName) then
			color = Color.BoonInfoAcquired
		end

		CreateTextBox({
		Id = traitNamePlate.Id,
		Text = "BoonInfo_BulletPoint",
		FontSize = 20,
		OffsetX = 220,
		OffsetY =  startY,
		Color = color,
		Font = "AlegreyaSansSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		LuaKey = "TempTextData",
		LuaValue = { TraitName = displayedTraitName }})
		startY = startY + BoonInfoScreenData.RequirementsYSpacer
	end
	if allSame and sharedGod and LootData[sharedGod].BoonInfoIcon then
		local godPlate = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
		SetAnimation({ Name = LootData[sharedGod].BoonInfoIcon, DestinationId = godPlate.Id })
		SetScale({ Id = godPlate.Id, Fraction = 0.33 })
		table.insert(screen.TraitRequirements, godPlate.Id )
		Attach({ Id = godPlate.Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = startX + 185, OffsetY = originalY - 405 })
		if (startY - originalY ) < 100 then
			startY = originalY + 100
		end

		Move({ Id = requirementsText.Id, OffsetX = 100, Duration = 0 })

	end

	startY = startY + 35
	return startY
end
OnMouseOver{ "BoonInfoButton",
	function( triggerArgs )
	
		SetConfigOption({ Name = "FreeFormSelecSearchFromId", Value = triggerArgs.triggeredById})
		if triggerArgs.triggeredById == nil or not IsScreenOpen("BoonInfoScreen") then
			return
		end
		local data = nil
		for i, boonData in pairs(ScreenAnchors.BoonInfoScreen.TraitContainers) do
			if boonData.DetailsBacking.Id == triggerArgs.triggeredById then
				data = boonData
			end
		end
		PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
		if data then
			if data.TraitName then
				CreateTraitRequirements( data.TraitName )
			else
				Destroy({Ids = screen.TraitRequirements })
				screen.TraitRequirements = {}
			end
		end
	end
}

OnMouseOff{ "BoonInfoButton",
	function( triggerArgs )
		screen = ScreenAnchors.BoonInfoScreen
		if screen then
			Destroy({Ids = screen.TraitRequirements })
			screen.TraitRequirements = {}
		end
	end
}
function BoonInfoScreenPrevious( screen, button )
	if not screen.SortedTraitIndex[screen.StartingIndex - BoonInfoScreenData.NumPerPage] then
		return 
	end
	local components = ScreenAnchors.BoonInfoScreen.Components
	screen.StartingIndex = screen.StartingIndex - BoonInfoScreenData.NumPerPage
	UpdateBoonInfoButtons( screen )
	UpdateBoonInfoPageButtons( screen )
	TeleportCursor({ DestinationId = ScreenAnchors.BoonInfoScreen.Components["BooninfoButton4"].DetailsBacking.Id, ForceUseCheck = true })
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
end

function BoonInfoScreenNext( screen, button )
	if not screen.SortedTraitIndex[screen.StartingIndex + BoonInfoScreenData.NumPerPage] then
		return 
	end
	local components = ScreenAnchors.BoonInfoScreen.Components
	screen.StartingIndex = screen.StartingIndex + BoonInfoScreenData.NumPerPage
	UpdateBoonInfoButtons( screen )
	UpdateBoonInfoPageButtons( screen )
	TeleportCursor({ DestinationId = ScreenAnchors.BoonInfoScreen.Components["BooninfoButton1"].DetailsBacking.Id, ForceUseCheck = true })
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
end

function UpdateBoonInfoPageButtons ( screen )
	local components = ScreenAnchors.BoonInfoScreen.Components
	if screen.SortedTraitIndex[screen.StartingIndex + BoonInfoScreenData.NumPerPage ] then
		SetAlpha({ Id = components.PageDown.Id, Fraction = 1, Duration = 0 })
		UseableOn({ Id = components.PageDown.Id })
	else
		SetAlpha({ Id = components.PageDown.Id, Fraction = 0, Duration = 0 })
		UseableOff({ Id = components.PageDown.Id })
	end
	if screen.SortedTraitIndex[screen.StartingIndex - BoonInfoScreenData.NumPerPage] then
		SetAlpha({ Id = components.PageUp.Id, Fraction = 1, Duration = 0 })
		UseableOn({ Id = components.PageUp.Id })
	else
		SetAlpha({ Id = components.PageUp.Id, Fraction = 0, Duration = 0 })
		UseableOff({ Id = components.PageUp.Id })
	end
end

function UpdateBoonInfoButtons( screen )
	local numDisplayed = 1
	for i = screen.StartingIndex, screen.StartingIndex + BoonInfoScreenData.NumPerPage - 1 do 
		local traitName = screen.SortedTraitIndex[i]
		local traitInfo = ScreenAnchors.BoonInfoScreen.TraitContainers[numDisplayed]
		numDisplayed = numDisplayed + 1
		if traitName and traitInfo then
			UseableOn({ Id = traitInfo.DetailsBacking.Id })
			local rarity = "Common"
			if TraitData[traitName] then
				if TraitData[traitName].RarityLevels and TraitData[traitName].RarityLevels.Legendary then
					rarity = "Legendary"
				end
				local newTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = rarity, ForBoonInfo = true })
				newTraitData.ForBoonInfo = true
				SetTraitTextData( newTraitData )
				newTraitData.Rarity = rarity
				traitInfo.TraitName = traitName
			
				SetAlpha({ Id = traitInfo.DetailsBacking.Id, Fraction = 1, Duration = 0 })
				SetAlpha({ Id = traitInfo.Frame.Id, Fraction = 1, Duration = 0 })

				-- Workaround to clear lua keywords @alice
				Destroy({ Id = traitInfo.DetailsBacking.Id })
			
				local offset = { X = 115, Y = BoonInfoScreenData.ButtonStartY + traitInfo.Index * BoonInfoScreenData.ButtonYSpacer }
				traitInfo.DetailsBacking = CreateScreenComponent({ Name = "BoonInfoButton", Group = "Combat_Menu_TraitTray_Backing", X = offset.X + 450, Y = offset.Y + 200 })
				CreateTextBoxWithFormat(MergeTables({
					Id = traitInfo.DetailsBacking.Id,
					OffsetX = -260,
					OffsetY = BoonInfoScreenData.DecriptionBoxOffsetY,
					Width = 665,
					Justification = "Left",
					VerticalJustification = "Top",
					LineSpacingBottom = 8,
					UseDescription = true,
					Format = "BaseFormat",
					VariableAutoFormat = "BoldFormatGraft",
					TextSymbolScale = 0.8,
				}, LocalizationData.TraitTrayScripts.DetailsBacking ))
				
				if not GameState.TraitsTaken[traitName] and HasActiveQuestForTrait( traitName ) then
					SetAnimation({ DestinationId = traitInfo.QuestIcon.Id, Name = "QuestItemFound" })
				else
					SetAnimation({ DestinationId = traitInfo.QuestIcon.Id, Name = "Blank" })
				end
				SetTraitTrayDetails( { TraitData = newTraitData, ForBoonInfo = true }, traitInfo.DetailsBacking, traitInfo.RarityBox, traitInfo.TitleBox, traitInfo.Patch, traitInfo.Icon )
			elseif ConsumableData[traitName] then
				upgradeData = GetRampedConsumableData(ConsumableData[traitName])
				local tooltipData = upgradeData
				if upgradeData.UseFunctionArgs ~= nil then
					if upgradeData.UseFunctionName ~= nil and upgradeData.UseFunctionArgs.TraitName ~= nil then
						local traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = upgradeData.UseFunctionArgs.TraitName, ForBoonInfo = true })
						traitData.ForBoonInfo = true
						SetTraitTextData( traitData )
						upgradeData.UseFunctionArgs.TraitName = nil
						upgradeData.UseFunctionArgs.TraitData = traitData
						tooltipData = MergeTables( tooltipData, traitData )
					elseif upgradeData.UseFunctionNames ~= nil then
						local hasTraits = false
						for i, args in pairs(upgradeData.UseFunctionArgs) do
							if args.TraitName ~= nil then
								hasTraits = true
								local processedTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = args.TraitName })
								SetTraitTextData( processedTraitData )
								tooltipData = MergeTables( tooltipData, processedTraitData )
							end
						end
						if not hasTraits then
							tooltipData = upgradeData
						end
					end
				else
					tooltipData = upgradeData
				end			
				traitInfo.TraitName = upgradeData.Name
				tooltipData.Name = upgradeData.Name
				tooltipData.CustomTrayText = upgradeData.Name
				tooltipData.CustomTitle = upgradeData.Name
				SetAnimation({ DestinationId = traitInfo.QuestIcon.Id, Name = "Blank" })

				-- Workaround to clear lua keywords @alice
				Destroy({ Id = traitInfo.DetailsBacking.Id })
			
				local offset = { X = 115, Y = BoonInfoScreenData.ButtonStartY + traitInfo.Index * BoonInfoScreenData.ButtonYSpacer }
				traitInfo.DetailsBacking = CreateScreenComponent({ Name = "BoonInfoButton", Group = "Combat_Menu_TraitTray_Backing", X = offset.X + 450, Y = offset.Y + 200 })
				CreateTextBoxWithFormat(MergeTables({
					Id = traitInfo.DetailsBacking.Id,
					OffsetX = -260,
					OffsetY = BoonInfoScreenData.DecriptionBoxOffsetY,
					Width = 665,
					Justification = "Left",
					VerticalJustification = "Top",
					LineSpacingBottom = 8,
					UseDescription = true,
					Format = "BaseFormat",
					VariableAutoFormat = "BoldFormatGraft",
					TextSymbolScale = 0.8,
				}, LocalizationData.TraitTrayScripts.DetailsBacking ))

				SetTraitTrayDetails( { TraitData = tooltipData, ForBoonInfo = true }, traitInfo.DetailsBacking, traitInfo.RarityBox, traitInfo.TitleBox, traitInfo.Patch, traitInfo.Icon )
			end
		else
			UseableOff({ Id = traitInfo.DetailsBacking.Id })
			SetAnimation({ DestinationId = traitInfo.QuestIcon.Id, Name = "Blank" })
			SetAlpha({ Id = traitInfo.DetailsBacking.Id, Fraction = 0, Duration = 0 })
			SetAlpha({ Id = traitInfo.Frame.Id, Fraction = 0, Duration = 0 })
			traitInfo.TraitName = nil
			ClearTraitTrayDetails( traitInfo.DetailsBacking, traitInfo.RarityBox, traitInfo.TitleBox, traitInfo.Patch, traitInfo.Icon )	
		end
	end
end


function CloseBoonInfoScreen()
	if ScreenAnchors.BoonInfoScreen == nil or not ScreenAnchors.BoonInfoScreen.CanClose then
		return
	end
	ScreenAnchors.BoonInfoScreen.KeepOpen = false
	ScreenAnchors.BoonInfoScreen.CanClose = false
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

	DisableShopGamepadCursor( ScreenAnchors.BoonInfoScreen.Name )
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16.0 })

	local ids = GetAllIds( ScreenAnchors.BoonInfoScreen.Components )
	for i, traitContainer in pairs(ScreenAnchors.BoonInfoScreen.TraitContainers) do
		ids = ConcatTableValues( ids, { traitContainer.QuestIcon.Id, traitContainer.Icon.Id, traitContainer.TitleBox.Id, traitContainer.Frame.Id, traitContainer.RarityBox.Id, traitContainer.DetailsBacking.Id, traitContainer.Patch.Id })
	end
	ids = ConcatTableValues( ids, ScreenAnchors.BoonInfoScreen.TraitRequirements )
	UseableOff({ Ids = ids })
	CloseScreen( ids , 0.15 )
	UnfreezePlayerUnit("BoonInfoScreen")
	OnScreenClosed({Flag = "BoonInfoScreen"})
	
	if IsScreenOpen("Codex") then
		SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "Combat_Menu_Overlay" })
		SetConfigOption({ Name = "FreeFormSelecSearchFromId", Value = ScreenAnchors.BoonInfoScreen.OldFreeFormSelecSearchFromId})
		CodexUI.Screen.Components.CloseButton.OnPressedFunctionName = "CloseCodexScreen"
		TeleportCursor({ DestinationId = ScreenAnchors.BoonInfoScreen.OldFreeFormSelecSearchFromId, ForceUseCheck = true })	
	else
		SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
		SetConfigOption({ Name = "FreeFormSelecSearchFromId", Value = 0 })
	end
	ScreenAnchors.BoonInfoScreen = nil
	
end

function BoonInfoPopulateTraits( screen )
	screen.HiddenTraits = {}
	screen.SortedTraitIndex = {}
	for traitName, requirements in pairs (BoonInfoScreenData.HiddenTraitData) do
		if not IsGameStateEligible(CurrentRun, requirements) then
			screen.HiddenTraits[traitName] = true
		end
	end

	for i, traitName in ipairs(BoonInfoScreenData.SortedTraitIndex[screen.LootName]) do
		if not TraitData[traitName] or not TraitData[traitName].RequiredTrait or not screen.HiddenTraits[TraitData[traitName].RequiredTrait ] then
			table.insert(screen.SortedTraitIndex, traitName)
		end
	end
end