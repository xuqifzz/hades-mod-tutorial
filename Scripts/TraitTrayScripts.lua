function ShowDepthCounter()
	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.HideEncounterText then
		return
	end
	if ScreenAnchors.RunDepthId == nil and not CurrentRun.Hero.IsDead then
		ScreenAnchors.RunDepthId = CreateScreenObstacle({ Name = "BlankObstacle", X = UIData.CurrentRunDepth.X, Y = UIData.CurrentRunDepth.Y, Group = "Combat_Menu_Overlay" })
	end
	local text = "CurrentRunDepth"
	if CurrentRun.RunDepthCache >= 2 then
		text = "CurrentRunDepth_Plural"
	end
	CreateTextBox( MergeTables( UIData.CurrentRunDepth.TextFormat, { Id = ScreenAnchors.RunDepthId, Text = text, } ) )
	ModifyTextBox({ Id = ScreenAnchors.RunDepthId, FadeTarget = 0, FadeDuration = 0.0 })
	ModifyTextBox({ Id = ScreenAnchors.RunDepthId, FadeTarget = 1, FadeDuration = 0.1 })
end

function HideDepthCounter()
	if ScreenAnchors.RunDepthId ~= nil then
		Destroy({ Id = ScreenAnchors.RunDepthId })
		ScreenAnchors.RunDepthId = nil
	end
end

function ShowAdvancedTooltip( args )

	if GameState.Flags.InFlashback then
		return
	end

	args = args or {}

	if not CombatUI.ShowingTraitDescription then
		ShowCombatUI()
		ShowResourceUIs()
		if not IsEmpty(CombatUI.Hide) and not GameState.WaitingForChoice then
			return
		end
		CombatUI.ShowingTraitDescription = true

		ShowAdvancedTooltipScreen( args )

	end
end

function ShowAdvancedTooltipScreen( args )
	OnScreenOpened( { Flag = "TraitTrayScreen", PersistCombatUI = true, SkipBlockTimer = true, } )
	if args.DontDuckAudio then
		SetAdvancedTooltipMixing( 1 )
	end
	FreezePlayerUnit("AdvancedTooltip", { DisableTray = false })
	thread(MarkObjectiveComplete, "AdvancedTooltipPrompt")

	local firstTrait = nil

	ScreenAnchors.TraitTrayScreen = DeepCopyTable( ScreenData.TraitTrayScreen )
	local components = ScreenAnchors.TraitTrayScreen.Components
	EnableShopGamepadCursor( ScreenAnchors.TraitTrayScreen.Name )
	if not GetConfigOptionValue({ Name = "UseMouse" }) then
		SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "TraitTrayTraits" })
	end
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 12.0 })

	components.BackgroundTint = CreateScreenComponent({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_UI_Backing" })
	SetScale({ Id = components.BackgroundTint.Id, Fraction = 10 })
	SetColor({ Id = components.BackgroundTint.Id, Color = {20, 20, 20, 255} })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = components.BackgroundTint.Id, Fraction = 0.66, Duration = 0.25 })

	local possibleAutoPins = {}

	local displayedTrait = 0
	if IsEmpty(CurrentRun.Hero.RecentTraits) then
		displayedTrait = displayedTrait - 5
	else
		displayedTrait = TableLength( CurrentRun.Hero.RecentTraits) - 5
	end
	local displayedTraits = {}
	local highlightedTrait = nil
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if not trait.Hidden and (not IsExistingTraitShown(trait) or trait == GetExistingUITrait( trait )) then
			-- two column pairs of 5 and 6

			local itemColumn = math.floor( displayedTrait / 11 )
			local itemNum = displayedTrait % 11
			local traitIcon = nil
			local xOffset = 0
			local yOffset = 0
			if IsShownInTraitTray( trait ) and trait == GetExistingUITrait( trait ) then
				xOffset = CombatUI.TraitUIStart - xOffset
				yOffset = TraitUI.IconStartY + GetTraitIndex(trait) * TraitUI.SpacerY
				if trait.Slot == nil then
					xOffset = 8 + xOffset + TraitUI.SpacerX * 0.5
					yOffset = yOffset - TraitUI.SpacerY * 0.5
				end
			else
				if itemNum < 6 then
					-- first column of the two column pair
					xOffset = 8 + CombatUI.TraitUIStart + ( itemColumn + 1 ) * TraitUI.SpacerX
					yOffset = TraitUI.IconStartY + ( itemNum ) * TraitUI.SpacerY
				else
					-- second column of the two column pair
					xOffset = 8 + CombatUI.TraitUIStart + ( itemColumn + 1.5 ) * TraitUI.SpacerX
					yOffset = TraitUI.IconStartY + ( itemNum - 7 + 1.5 ) * TraitUI.SpacerY
				end
			end

			traitIcon = CreateScreenComponent({ Name = "TraitTrayIconButton", X = xOffset, Y = yOffset, Group = "Combat_Menu_TraitTray" })
			AddToGroup({ Id  = traitIcon.Id, Name = "TraitTrayTraits" })
			traitIcon.OnPressedFunctionName = "PinTraitDetails"
			if not IsExistingTraitShown( trait ) then
				trait.AnchorId = traitIcon.Id
			end
			SetAnimation({ Name = GetTraitIcon( trait ), DestinationId = traitIcon.Id, Group = "Combat_Menu_TraitTray" })
			traitIcon.OffsetX = xOffset
			traitIcon.OffsetY = yOffset
			CreateTextBox({
				Id = traitIcon.Id,
				UseDescription = true,
				VariableAutoFormat = "BoldFormatGraft",
				Scale = 0.0,
				Hide = true,
			})

			if args.DisableTooltips then
				ModifyTextBox({ Id = traitIcon.Id, BlockTooltip = true })
			end

			table.insert( components, traitIcon )
			traitIcon.TraitData = trait
			ScreenAnchors.TraitTrayScreen.Icons[ traitIcon.Id ] = traitIcon

			local traitFrameId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray"  })
			Attach({ Id = traitFrameId, DestinationId = traitIcon.Id })
			if GetTraitFrame(trait) ~= nil then
				local traitFrame = GetTraitFrame( trait )
				local rarityValue = GetRarityValue( trait )
				for i, existingTrait in pairs( CurrentRun.Hero.TraitDictionary[trait.Name]) do
					if (AreTraitsIdentical(trait, existingTrait) and rarityValue < GetRarityValue( existingTrait.Rarity )) then
						rarityValue = GetRarityValue( existingTrait.Rarity )
						traitFrame = GetTraitFrame( existingTrait )
					  end
				end
				SetAnimation({ Name = traitFrame, DestinationId = traitFrameId })
			end
			table.insert( ScreenAnchors.TraitTrayScreen.Frames, traitFrameId )

			if not IsShownInTraitTray(trait) then
				displayedTrait = displayedTrait + 1
			end
			TraitUICreateText( trait, "Combat_Menu_TraitTray_Overlay" )

			if not firstTrait or (not IsEmpty(CurrentRun.Hero.RecentTraits) and AreTraitsIdentical( CurrentRun.Hero.RecentTraits[1], trait )) then
				TeleportCursor({ OffsetX = xOffset, OffsetY = yOffset, ForceUseCheck = true })
				highlightedTrait = traitIcon
				firstTrait = true
			end

			if args.AutoPin and IsPossibleAutoPin( trait ) then
				table.insert( possibleAutoPins, traitIcon )
			end
		end
	end

	local shownColumns = math.ceil( displayedTrait / 11 )
	if displayedTrait % 11 >= 6 then
		shownColumns = shownColumns + 1
	end
	shownColumns = shownColumns + 1
	ScreenAnchors.TraitTrayScreen.ShownColumns = shownColumns

	-- dynamically sized backing

	components.ShopBackground = CreateScreenComponent({ Name = "TraitTrayBackground", Group = "Combat_Menu_TraitTray_Backing", X = 450, Y = ScreenHeight/2 - 118})
	for cosmeticName, status in pairs( GameState.Cosmetics ) do
		local cosmeticData = ConditionalItemData[cosmeticName]
		if cosmeticData ~= nil and cosmeticData.TraitTrayBackground ~= nil then
			SetAnimation({ Name = cosmeticData.TraitTrayBackground, DestinationId = components.ShopBackground.Id })
			break
		end
	end

	components.CenterColumn = CreateScreenComponent({ Name = "TraitTray_Center", Group = "Combat_Menu_TraitTray_Backing", X = CombatUI.TraitUIStart, Y = 32 + ScreenHeight/2 - 100 })
	SetScaleX({ Id = components.CenterColumn.Id, Fraction = (shownColumns + 1) / 2 })
	components.EndColumn = CreateScreenComponent({ Name = "TraitTray_Right", Group = "Combat_Menu_TraitTray_Backing", X = CombatUI.TraitUIStart + ( shownColumns + 1 ) * TraitUI.SpacerX / 2, Y = ScreenHeight/2 - 100 })

	for cosmeticName, status in pairs( GameState.Cosmetics ) do
		local cosmeticData = ConditionalItemData[cosmeticName]
		if cosmeticData ~= nil and cosmeticData.TraitTrayTop ~= nil then
			DebugPrint({ Text = "cosmeticData.TraitTrayTop = "..cosmeticData.TraitTrayTop })
			components.BackingTop = CreateScreenComponent({ Name = cosmeticData.TraitTrayTop, Group = "Combat_Menu_TraitTray_Backing", X = 160, Y = 200, Scale = 0.5 })
			components.BackingBottom = CreateScreenComponent({ Name = cosmeticData.TraitTrayBottom, Group = "Combat_Menu_TraitTray_Backing", X = 160, Y = 910, Scale = 0.5 })
			break
		end
	end

	if not args.HideCloseButton then
		components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Scale = 0.7, Group = "Combat_Menu_TraitTray" })
		Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = -355 + ( shownColumns * 32 ), OffsetY = 435 })
		components.CloseButton.OnPressedFunctionName = "CloseAdvancedTooltipScreen"
		components.CloseButton.ControlHotkey = "Cancel"
		AddToGroup({ Id  = components.CloseButton.Id, Name = "TraitTrayTraits" })
		AddToGroup({ Id  = components.CloseButton.Id, Name = "TraitTrayShrineUpgrades" })
		AddToGroup({ Id  = components.CloseButton.Id, Name = "TraitTrayMetaUpgrades" })
	end

	-- dynamic sockets
	for i = 0, shownColumns do
		local xOffset = 0
		if i % 2 == 0 then
			xOffset = 8 + CombatUI.TraitUIStart + ( math.floor(i/2) + 1 ) * TraitUI.SpacerX
			local newColumnObject = CreateScreenComponent({ Name = "TraitTray_ShortColumn", Group = "Combat_Menu_TraitTray_Backing", X = xOffset - 64, Y = (TraitUI.IconStartY + 2.5 * TraitUI.SpacerY) - 0 })
			table.insert( ScreenAnchors.TraitTrayScreen.Columns, newColumnObject.Id )
		else
			xOffset = 8 + CombatUI.TraitUIStart + ( math.floor(i/2) + 1.5 ) * TraitUI.SpacerX
			local newColumnObject = CreateScreenComponent({ Name = "TraitTray_LongColumn", Group = "Combat_Menu_TraitTray_Backing", X = xOffset - 64, Y = (TraitUI.IconStartY + 2.5 * TraitUI.SpacerY) - 0 })
			table.insert( ScreenAnchors.TraitTrayScreen.Columns, newColumnObject.Id )
		end
	end

	-- ShrineUpgrades / MetaUpgrades
	local offsetX = 20
	local offsetY = 50

	if GameState.SpentShrinePointsCache ~= nil and GameState.SpentShrinePointsCache > 0 then
		components.ShrineUpgradeBacking = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Backing", X = offsetX, Y = offsetY, Scale = 0.5, })
		SetScaleX({ Id = components.ShrineUpgradeBacking.Id, Fraction = 1.0 })
		local backingAnim = "MetaUpgradeTrayBacking"
		for cosmeticName, status in pairs( GameState.Cosmetics ) do
			local cosmeticData = ConditionalItemData[cosmeticName]
			if cosmeticData ~= nil and cosmeticData.ShrineUpgradeBacking ~= nil then
				backingAnim = cosmeticData.ShrineUpgradeBacking
				break
			end
		end
		SetAnimation({ DestinationId = components.ShrineUpgradeBacking.Id, Name = backingAnim })
		offsetX = offsetX + 190
		for k, upgradeName in ipairs( ShrineUpgradeOrder ) do
			local upgradeData = MetaUpgradeData[upgradeName]
			if upgradeData.GameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, upgradeData.GameStateRequirements ) then
				-- Blank
			else
				components["ShrineIcon"..k] = CreateScreenComponent({ Name = "TraitTrayMetaUpgradeIconButton", Group = "Combat_Menu_TraitTray", X = offsetX, Y = offsetY })
				SetAnimation({ DestinationId = components["ShrineIcon"..k].Id, Name = upgradeData.Icon })
				local numUpgrades = GetNumMetaUpgrades( upgradeName )
				if numUpgrades > 0 then
					local totalStatChange = GetTotalStatChange( upgradeData )
					local text = GetMetaUpgradeShortTotalText( upgradeData, true )
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
						LangJaScaleModifier = 0.80,
						OutlineThickness = 2,
						OutlineColor = {0,0,0,1},
					})
					SetupMetaIconTrayTooltip( components["ShrineIcon"..k], upgradeName, upgradeData, offsetX, args )
					AddToGroup({ Id  = components["ShrineIcon"..k].Id, Name = "TraitTrayShrineUpgrades" })
					ScreenAnchors.TraitTrayScreen.HasShrineUpgradeIcon = true
				else
					UseableOff({ Id = components["ShrineIcon"..k].Id })
					SetColor({ Id = components["ShrineIcon"..k].Id, Color = {0.5, 0.55, 0.6, 0.55} })
				end
			end
			offsetX = offsetX + 65
		end
	end
	offsetX = 20
	offsetY = offsetY + 60
	GameState.SpentMetaPointsCache = GetTotalSpentMetaPoints()
	if GameState.SpentMetaPointsCache > 0 then
		components.MetaUpgradeBacking = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Backing", X = offsetX, Y = offsetY, Scale = 0.5, })
		SetScaleX({ Id = components.MetaUpgradeBacking.Id, Fraction = 1.0 })
		CreateTextBox({ Id = components.MetaUpgradeBacking.Id,
			Text = "InGameUI_ActiveMetaPoints",
			FontSize = 22,
			OffsetX = 20, OffsetY = 0,
			Color = titleColor,
			Font = "AlegreyaSansSCBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Left" })
		local backingAnim = "MetaUpgradeTrayBacking"
		for cosmeticName, status in pairs( GameState.Cosmetics ) do
			local cosmeticData = ConditionalItemData[cosmeticName]
			if cosmeticData ~= nil and cosmeticData.MetaUpgradeBacking ~= nil then
				backingAnim = cosmeticData.MetaUpgradeBacking
				break
			end
		end
		SetAnimation({ DestinationId = components.MetaUpgradeBacking.Id, Name = backingAnim })
		offsetX = offsetX + 190
		for k, upgradeName in ipairs( GameState.MetaUpgradesSelected ) do
			if k > GetNumLockedMetaUpgrades() then
				-- Blank
			else
				local upgradeData = MetaUpgradeData[upgradeName]
				components["MetaIcon"..k] = CreateScreenComponent({ Name = "TraitTrayMetaUpgradeIconButton", Group = "Combat_Menu_TraitTray", X = offsetX, Y = offsetY })
				SetAnimation({ DestinationId = components["MetaIcon"..k].Id, Name = upgradeData.Icon })
				local numUpgrades = GetNumMetaUpgrades( upgradeName )
				if numUpgrades > 0 then
					local totalStatChange = GetTotalStatChange( upgradeData )
					local text = GetMetaUpgradeShortTotalText( upgradeData, true )
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
					SetupMetaIconTrayTooltip( components["MetaIcon"..k], upgradeName, upgradeData, offsetX, args )
					AddToGroup({ Id  = components["MetaIcon"..k].Id, Name = "TraitTrayMetaUpgrades" })
					ScreenAnchors.TraitTrayScreen.HasMetaUpgradeIcon = true
				else
					UseableOff({ Id = components["MetaIcon"..k].Id })
					SetColor({ Id = components["MetaIcon"..k].Id, Color = {0.5, 0.55, 0.6, 0.55} })
				end
			end
			offsetX = offsetX + 89
		end
	end


	CreatePrimaryBacking()
	if highlightedTrait ~= nil then
		SetHighlightedTraitFrame( highlightedTrait )
	end

	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoud" })

	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	ScreenAnchors.TraitTrayScreen.CanClose = true
	ScreenAnchors.TraitTrayScreen.KeepOpen = true

	if IsEmpty( possibleAutoPins ) then
		if highlightedTrait ~= nil then
			PinTraitDetails( ScreenAnchors.TraitTrayScreen, highlightedTrait, { Hover = true } )
		end
	else
		for k = 1, ScreenAnchors.TraitTrayScreen.MaxPins do
			local traitButton = RemovePriorityPin( possibleAutoPins )
			PinTraitDetails( ScreenAnchors.TraitTrayScreen, traitButton )
			if IsEmpty( possibleAutoPins ) then
				break
			end
		end
	end

	ScreenAnchors.TraitTrayScreen.OnWASDInputFunctionName = "TraitTrayWASDInput"

	thread( HandleWASDInput, ScreenAnchors.TraitTrayScreen )
	HandleScreenInput( ScreenAnchors.TraitTrayScreen )
end

function RemovePriorityPin( possiblePins )
	for k, traitButton in pairs( possiblePins ) do
		if traitButton.TraitData.IsWeaponEnchantment then
			RemoveValue( possiblePins, traitButton )
			return traitButton
		end
	end
	return RemoveRandomValue( possiblePins )
end

function TraitTrayWASDInput( screen )
	local currentZone = GetConfigOptionValue({ Name = "ExclusiveInteractGroup" })
	if currentZone == nil or currentZone == "" then
		SetConfigOption({ Name = "ExclusiveInteractGroup", Value = "TraitTrayTraits" })
	end	
end

function FreeFormSelectFailed( directionX, directionY )

	if ScreenAnchors.TraitTrayScreen == nil then
		return
	end

	local currentZone = GetConfigOptionValue({ Name = "ExclusiveInteractGroup" })
	if currentZone == nil or currentZone == "" then
		return
	end

	local interactZones = { "TraitTrayTraits", }
	if ScreenAnchors.TraitTrayScreen.HasMetaUpgradeIcon then
		table.insert( interactZones, "TraitTrayMetaUpgrades" )
	end
	if ScreenAnchors.TraitTrayScreen.HasShrineUpgradeIcon then
		table.insert( interactZones, "TraitTrayShrineUpgrades" )
	end
	local direction = 1
	if directionY > 0 then
		direction = -1
	end

	local currentIndex = GetKey( interactZones, currentZone )
	if not currentIndex then
		return
	end
	
	local nextIndex = currentIndex + direction
	if nextIndex < 1 or nextIndex  > #interactZones then
		return
	end

	local nextZone = interactZones[nextIndex]
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nextZone })
	TeleportCursor({ DestinationNames = nextZone })

end

function IsPossibleAutoPin( trait )

	if trait.IsWeaponEnchantment then
		return true
	end

	if trait.Rarity == "Legendary" or trait.Rarity == "Heroic" or trait.IsDuoBoon or trait.Frame == "Hammer" then
		return true
	end

	local traitCount = GetTraitCount( CurrentRun.Hero, trait )
	if traitCount >= 3 then
		return true
	end

	return false
end


function CloseAdvancedTooltipScreen()
	if ScreenAnchors.TraitTrayScreen == nil or not ScreenAnchors.TraitTrayScreen.CanClose then
		return
	end
	ScreenAnchors.TraitTrayScreen.CanClose = false

	local ids = GetAllIds( ScreenAnchors.TraitTrayScreen.Components )
	for i, button in pairs( ScreenAnchors.TraitTrayScreen.Components ) do
		if button.TraitData ~= nil and not IsShownInTraitTray(button.TraitData) then
			if button.TraitData.TraitIconOverlay ~= nil then
				table.insert( ids, button.TraitData.TraitIconOverlay )
				button.TraitData.TraitIconOverlay = nil
			end
			if button.TraitData.TraitActiveOverlay ~= nil then
				table.insert( ids, button.TraitData.TraitActiveOverlay )
				button.TraitData.TraitActiveOverlay = nil
			end

			if button.TraitData.AnchorId ~= nil then
				table.insert( ids, button.TraitData.AnchorId )
				button.TraitData.AnchorId = nil
			end
			if button.TraitData.TraitInfoCardId ~= nil then
				table.insert( ids, button.TraitData.TraitInfoCardId )
				button.TraitData.TraitInfoCardId = nil
			end
			RemoveValueAndCollapse( ScreenAnchors.TraitAnchorIds, button.TraitData.AnchorId )
		end
	end
	table.insert( ids, ScreenAnchors.TraitTrayScreen.HoverFrame )
	ConcatTableValues( ids, ScreenAnchors.TraitTrayScreen.Frames )
	ConcatTableValues( ids, ScreenAnchors.TraitTrayScreen.Columns )
	ConcatTableValues( ids, { ScreenAnchors.TraitTrayScreen.PrimaryFrameBacking })
	ConcatTableValues( ids, { ScreenAnchors.TraitTrayScreen.BackingTop } )
	ConcatTableValues( ids, { ScreenAnchors.TraitTrayScreen.BackingBottom } )
	ConcatTableValues( ids, { ScreenAnchors.TraitTrayScreen.BackingDecor } )
	ConcatTableValues( ids, { ScreenAnchors.TraitTrayScreen.BadgeNamePlateId } )
	ConcatTableValues( ids, ScreenAnchors.TraitTrayScreen.PrimaryFrames )
	for k, pin in pairs( ScreenAnchors.TraitTrayScreen.Pins ) do
		ConcatTableValues( ids, GetAllIds( pin.Components ) )
	end

	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow", Delay = 0.1 })
	
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		if IsShownInTraitTray(trait) and trait == GetExistingUITrait( trait ) then
			TraitUICreateText( trait )
		end
	end
	DisableShopGamepadCursor( ScreenAnchors.TraitTrayScreen.Name )
	CloseScreen( ids, 0.05 )

	ScreenAnchors.TraitTrayScreen.TitleBox = nil
	ScreenAnchors.TraitTrayScreen.RarityBox = nil
	ScreenAnchors.TraitTrayScreen.ExitMessageBox = nil
	UnfreezePlayerUnit("AdvancedTooltip")
	ScreenAnchors.TraitTrayScreen.KeepOpen = false
	notifyExistingWaiters("ScreenInput"..ScreenAnchors.TraitTrayScreen.Name)
	StartHideAfterDelayThread()
	OnScreenClosed({Flag = "TraitTrayScreen"})
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16.0 })
	HideDepthCounter()
	SetAdvancedTooltipMixing( 0 )
	ScreenAnchors.TraitTrayScreen = nil
	if not CurrentRun.Hero.IsDead then
		HideResourceUIs({ NonCombatOnly = true })
	end
	CombatUI.ShowingTraitDescription = false

	
	if ScreenAnchors.ChoiceScreen ~= nil then
		local screenIds = GetAllIds({ 
			ScreenAnchors.ChoiceScreen.Components.PurchaseButton1, 
			ScreenAnchors.ChoiceScreen.Components.PurchaseButton2, 
			ScreenAnchors.ChoiceScreen.Components.PurchaseButton3 })
		
		if screenIds[1] then
			TeleportCursor({ DestinationId = screenIds[1], ForceUseCheck = true })
		end
	elseif IsScreenOpen("Store") then
		local screenIds = GetAllIds({
			CurrentRun.CurrentRoom.Store.Screen.Components.PurchaseButton1, 
			CurrentRun.CurrentRoom.Store.Screen.Components.PurchaseButton2, 
			CurrentRun.CurrentRoom.Store.Screen.Components.PurchaseButton3 })

		screenIds = CollapseTable(screenIds)
		
		if screenIds[1] then
			TeleportCursor({ DestinationId = screenIds[1], ForceUseCheck = true })
		end
	elseif IsScreenOpen("SellTraitMenu") then
		local screenIds = GetAllIds({ 
			ScreenAnchors.SellTraitScreen.Components.PurchaseButton1, 
			ScreenAnchors.SellTraitScreen.Components.PurchaseButton2, 
			ScreenAnchors.SellTraitScreen.Components.PurchaseButton3 })
		
		if screenIds[1] then
			TeleportCursor({ DestinationId = screenIds[1], ForceUseCheck = true })
		end
	end
	local choiceIds = GetIdsByType({ Name = "ButtonDialogueChoice"})
	
	if not IsEmpty( choiceIds ) then
		local minId = choiceIds[1]
		local minY = GetLocation({ Id = minId }).Y
		for i, id in pairs(choiceIds) do
			if GetLocation({ Id = id }).Y < minY then
				minY = GetLocation({ Id = id }).Y 
				minId = id
			end
		end
		if minId then
			TeleportCursor({ DestinationId = minId, ForceUseCheck = true })
		end
	end

end

function PinTraitDetails( screen, button, args )

	if not screen.CanClose then
		return
	end

	args = args or {}

	if args.RemoveHovers then
		-- Remove the previous hover
		for k, pin in pairs( screen.Pins ) do
			if pin.Button.PinFromHover then
				thread( PinTraitDetails, screen, pin.Button, { Hover = true, RemoveOnly = true, } )
				break
			end
		end
	end

	if button.PinIndex ~= nil then

		if args.Hover and not button.PinFromHover then
			-- Pin was locked in, don't remove from hover off
			return
		end

		local fadeOutTime = 0.2

		if not args.Hover then
			local components = screen.Pins[button.PinIndex].Components
			if button.PinFromHover then
				-- Pin it
				button.PinFromHover = false
				if components.PinIndicator == nil then
					components.PinIndicator = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", Scale = 0.5 })
					components.PinIndicatorDetails = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", Scale = 0.8 })
				end
				Attach({ Id = components.PinIndicator.Id, DestinationId = button.Id })
				if button.TraitData.Slot == "Assist" or button.TraitData.Slot == "Keepsake" then
					SetAnimation({ DestinationId = components.PinIndicator.Id, Name = "TraitPinIn_NoHighlight" })
				else
					SetAnimation({ DestinationId = components.PinIndicator.Id, Name = "TraitPinIn" })
					SetAnimation({ DestinationId = components.PinIndicatorDetails.Id, Name = "TraitTray_Highlight" })
				end
				Attach({ Id = components.PinIndicatorDetails.Id, DestinationId = components.Icon.Id })
				TraitTrayPinOnPresentation( screen, button )
				return
			else
				-- Unpin it
				button.PinFromHover = true
				if button.TraitData.Slot == "Assist" then
					SetAnimation({ DestinationId = components.PinIndicator.Id, Name = "TraitPinOut_NoHighlight" })
				else
					SetAnimation({ DestinationId = components.PinIndicator.Id, Name = "TraitPinOut" })
				end
				SetAnimation({ DestinationId = components.PinIndicatorDetails.Id, Name = "Blank" })
				TraitTrayPinOffPresentation( screen, button )
				return
			end
		end

		-- Toggle off
		local pin = screen.Pins[button.PinIndex]
		local componentIds = GetAllIds( pin.Components )
		SetAlpha({ Ids = componentIds, Fraction = 0, Duration = fadeOutTime })
		ModifyTextBox({ Ids = componentIds, FadeTarget = 0, FadeDuration = fadeOutTime })

		-- Slide others up
		for index, pin in ipairs( screen.Pins ) do
			if index > button.PinIndex then
				local toSlideIds = GetAllIds( pin.Components )
				RemoveValueAndCollapse( toSlideIds, pin.Components.PinIndicator.Id )
				Move({ Ids = toSlideIds, Angle = 90, Distance = screen.PinSpacing, Speed = screen.PinCollapseSpeed, SmoothStep = true })
				pin.Button.PinIndex = pin.Button.PinIndex - 1
			end
		end
		RemoveIndexAndCollapse( screen.Pins, button.PinIndex )
		button.PinIndex = nil

		waitScreenTime( fadeOutTime )
		Destroy({ Ids = componentIds })
		return
	end

	if args.RemoveOnly then
		return
	end

	if #screen.Pins >= screen.MaxPins then
		return
	end

	local pinIndex = #screen.Pins + 1
	button.PinIndex = pinIndex
	button.PinFromHover = args.Hover
	local components = {}
	screen.Pins[pinIndex] = {}
	screen.Pins[pinIndex].Components = components
	screen.Pins[pinIndex].Button = button

	local offset = { X = screen.PinOffsetX + ((screen.ShownColumns - 1) * 64), Y = screen.PinOffsetY }
	--local offset = { X = screen.PinOffsetX, Y = screen.PinOffsetY }
	offset.Y = offset.Y + ((pinIndex - 1) * screen.PinSpacing)

	local language = GetLanguage({})
	local detailsBackingXOffset = LocalizationData.TraitTrayScripts.DetailsBackingXOffset[language] or -260
	local detailsBackingYOffset = LocalizationData.TraitTrayScripts.DetailsBackingYOffset[language] or 0
	local detailsBackingWidth = LocalizationData.TraitTrayScripts.DetailsBackingWidth[language] or 665
	local titleBoxXOffset = LocalizationData.TraitTrayScripts.TitleBoxXOffset[language] or 170
	local titleBoxYOffset = LocalizationData.TraitTrayScripts.TitleBoxYOffset[language] or 0

	components.DetailsBacking = CreateScreenComponent({ Name = "TraitTrayDetailsBacking", Group = "Combat_Menu_TraitTray_Backing", X = offset.X + 450, Y = offset.Y + 200 })
	CreateTextBoxWithFormat(MergeTables({
		Id = components.DetailsBacking.Id,
		OffsetX = detailsBackingXOffset,
		OffsetY = -20 + detailsBackingYOffset,
		Width = detailsBackingWidth,
		Justification = "Left",
		VerticalJustification = "Top",
		LineSpacingBottom = 8,
		UseDescription = true,
		Format = "BaseFormat",
		VariableAutoFormat = "BoldFormatGraft",
		TextSymbolScale = 0.8,
	}, LocalizationData.TraitTrayScripts.DetailsBacking ))

	components.TitleBox = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", X = offset.X + 20, Y = offset.Y + 170 })
	CreateTextBox(MergeTables({
		Id = components.TitleBox.Id,
		FontSize = 25,
		OffsetX = titleBoxXOffset,
		OffsetY = -17 + titleBoxYOffset,
		Color = color,
		Font = "AlegreyaSansSCLight",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
	}, LocalizationData.TraitTrayScripts.TitleBox))

	components.RarityBox = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", X = offset.X + 20, Y = offset.Y + 170 })
	CreateTextBox(MergeTables({
		Id = components.RarityBox.Id,
		FontSize = 25,
		OffsetX = 860,
		OffsetY = -17 + titleBoxYOffset,
		Color = color,
		Font = "AlegreyaSansSCLight",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Right",
	}, LocalizationData.TraitTrayScripts.RarityBox))

	components.Patch = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", X = offset.X + 102, Y = offset.Y + 202, Scale = 0.8 })
	SetAnimation({ DestinationId = components.Patch.Id, Name = "BoonRarityPatch"})
	SetColor({ Id = components.Patch.Id, Color = Color.Transparent })

	components.Frame = CreateScreenComponent({ Name = "TraitTray_TraitBaseFrame", Group = "Combat_Menu_TraitTray", X = offset.X + 90, Y = offset.Y + 200, Scale = 0.8 })
	components.Icon = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", X = offset.X + 90, Y = offset.Y + 200, Scale = 0.8 })

	if not args.Hover then
		-- Immediately Pin it
		if components.PinIndicator == nil then
			components.PinIndicator = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", Scale = 0.5 })
			components.PinIndicatorDetails = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", Scale = 0.8 })
		end
		Attach({ Id = components.PinIndicator.Id, DestinationId = button.Id })
		if button.TraitData.Slot == "Assist" or button.TraitData.Slot == "Keepsake" then
			SetAnimation({ DestinationId = components.PinIndicator.Id, Name = "TraitPinIn_NoHighlight" })
		else
			SetAnimation({ DestinationId = components.PinIndicator.Id, Name = "TraitPinIn" })
		end
		Attach({ Id = components.PinIndicatorDetails.Id, DestinationId = components.Icon.Id })
		SetAnimation({ DestinationId = components.PinIndicatorDetails.Id, Name = "Blank" })
		TraitTrayPinOnPresentation( screen, button )
	end

	SetTraitTextData( button.TraitData, { OldOnly = true } )
	
	local showingTrait = nil
	local rarityValue = 0
	for s, existingTrait in pairs( CurrentRun.Hero.Traits) do
		if (AreTraitsIdentical(existingTrait, button.TraitData) and rarityValue < GetRarityValue( existingTrait.Rarity )) then
			showingTrait = existingTrait
			rarityValue = GetRarityValue( showingTrait.Rarity )
		end
	end
	if showingTrait then
		button.OverrideRarity = showingTrait.Rarity
	end
	SetTraitTrayDetails( button, components.DetailsBacking, components.RarityBox, components.TitleBox, components.Patch, components.Icon )

end

OnMouseOver{ "TraitTrayIconButton",
	function( triggerArgs )
		if triggerArgs.triggeredById == nil or not IsScreenOpen("TraitTrayScreen") then
			return
		end
		local button = ScreenAnchors.TraitTrayScreen.Icons[triggerArgs.triggeredById]
		if not button then
			return
		end
		SetHighlightedTraitFrame( button )
		PinTraitDetails( ScreenAnchors.TraitTrayScreen, button, { Hover = true, RemoveHovers = true } )
		TraitTrayHoverOnPresentation( ScreenAnchors.TraitTrayScreen, button )
		if ScreenAnchors.TraitTrayScreen.Pins ~= nil then
			local pin = ScreenAnchors.TraitTrayScreen.Pins[button.PinIndex]
			if pin ~= nil and not pin.Button.FromHover and pin.Components.PinIndicatorDetails ~= nil then
				SetAnimation({ DestinationId = pin.Components.PinIndicatorDetails.Id, Name = "TraitTray_Highlight" })
				return
			end
		end
	end
}

OnMouseOff{ "TraitTrayIconButton",
	function( triggerArgs )
		if triggerArgs.triggeredById == nil or not IsScreenOpen("TraitTrayScreen") then
			return
		end
		local button = ScreenAnchors.TraitTrayScreen.Icons[triggerArgs.triggeredById]
		if ScreenAnchors.TraitTrayScreen.Pins ~= nil then
			local pin = ScreenAnchors.TraitTrayScreen.Pins[button.PinIndex]
			if pin ~= nil and pin.Components.PinIndicatorDetails ~= nil then
				SetAnimation({ DestinationId = pin.Components.PinIndicatorDetails.Id, Name = "Blank" })
				return
			end
		end
	end
}

function CreatePrimaryBacking()

	local locationY = TraitUI.StartY

	ScreenAnchors.TraitTrayScreen.PrimaryFrames = {}

	local obstacleName = "TraitTray_Slots_"..GetTraitTraySize()
	for cosmeticName, status in pairs( GameState.Cosmetics ) do
		local cosmeticData = ConditionalItemData[cosmeticName]
		if cosmeticData ~= nil and cosmeticData.TraitBacking ~= nil then
			obstacleName = cosmeticData.TraitBacking
			if cosmeticData.TraitBackingDecor ~= nil then
				ScreenAnchors.TraitTrayScreen.BackingDecor = CreateScreenObstacle({ Name = cosmeticData.TraitBackingDecor, Group = "Combat_Menu_TraitTray_Backing", X = 960, Y = 1015 })
			end
			break
		end
	end
	ScreenAnchors.TraitTrayScreen.PrimaryFrameBacking = CreateScreenObstacle({ Name = obstacleName, Group = "Combat_Menu_TraitTray_Backing", X = CombatUI.TraitUIStart, Y = locationY})

	if GameState.BadgeRank ~= nil then
		ScreenAnchors.TraitTrayScreen.BadgeNamePlateId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", X = 210, Y = 1052 })
		SetAnimation({ Name = "BadgeNamePlate01", DestinationId = ScreenAnchors.TraitTrayScreen.BadgeNamePlateId })
		local badgeData = GameData.BadgeData[GameData.BadgeOrderData[GameState.BadgeRank]]
		CreateTextBox({
			Id = ScreenAnchors.TraitTrayScreen.BadgeNamePlateId,
			Text = badgeData.Name,
			FontSize = 20,
			OffsetX = 0, OffsetY = 0,
			Color = {255, 235, 118, 255},
			Font = "AlegreyaSansSCMedium",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0,2},
			Justification = "Center",
			OutlineThickness = 2,
			OutlineColor = {0,0,0,1},
		})
	end

	locationY = TraitUI.IconStartY
	local attackIcon = CreateScreenObstacle({ Name = "TraitTray_SlotIcon_Attack", Group = "Combat_Menu_TraitTray_Backing", X = TraitUI.IconStartX, Y = locationY})
	locationY = locationY + TraitUI.SpacerY
	local secondaryIcon = CreateScreenObstacle({ Name = "TraitTray_SlotIcon_Secondary", Group = "Combat_Menu_TraitTray_Backing", X = TraitUI.IconStartX, Y = locationY})
	locationY = locationY + TraitUI.SpacerY
	local rangedIcon = CreateScreenObstacle({ Name = "TraitTray_SlotIcon_Ranged", Group = "Combat_Menu_TraitTray_Backing", X = TraitUI.IconStartX, Y = locationY})
	locationY = locationY + TraitUI.SpacerY
	local dashIcon = CreateScreenObstacle({ Name = "TraitTray_SlotIcon_Dash", Group = "Combat_Menu_TraitTray_Backing", X = TraitUI.IconStartX, Y = locationY})

	table.insert( ScreenAnchors.TraitTrayScreen.PrimaryFrames, attackIcon )
	table.insert( ScreenAnchors.TraitTrayScreen.PrimaryFrames, secondaryIcon )
	table.insert( ScreenAnchors.TraitTrayScreen.PrimaryFrames, rangedIcon )
	table.insert( ScreenAnchors.TraitTrayScreen.PrimaryFrames, dashIcon )

	if HasUnlockedWrath() then
		locationY = locationY + TraitUI.SpacerY
		local wrathIcon = CreateScreenObstacle({ Name = "TraitTray_SlotIcon_Wrath", Group = "Combat_Menu_TraitTray_Backing", X = TraitUI.IconStartX, Y = locationY})
		table.insert( ScreenAnchors.TraitTrayScreen.PrimaryFrames, wrathIcon )
	end

	locationY = TraitUI.IconStartY
	for i, icon in pairs(ScreenAnchors.TraitTrayScreen.PrimaryFrames) do
		local frameIcon = CreateScreenObstacle({ Name = "TraitTray_SlotFrame", Group = "Combat_Menu_TraitTray_Backing", X = TraitUI.IconStartX, Y = locationY})
		locationY = locationY + TraitUI.SpacerY
		table.insert(ScreenAnchors.TraitTrayScreen.Frames, frameIcon )
	end
	if HasUnlockedKeepsakes() then
		local frameIcon = CreateScreenObstacle({ Name = "TraitTray_KeepsakeBacking", Group = "Combat_Menu_TraitTray_Backing", X = TraitUI.IconStartX, Y = locationY})

		table.insert( ScreenAnchors.TraitTrayScreen.PrimaryFrames, frameIcon )
	end
end

function SetHighlightedTraitFrame( button )
	if ScreenAnchors.TraitTrayScreen.HoverFrame == nil then
		ScreenAnchors.TraitTrayScreen.HoverFrame = CreateScreenObstacle({ Name = "TraitTray_Highlight", Group = "Combat_Menu_TraitTray_Additive" })
	else
		if ScreenAnchors.LastHoverId ~= nil then
			ModifyTextBox({ Id = ScreenAnchors.LastHoverId, Text = "Blank"})
		end
	end
	Teleport({ Id = ScreenAnchors.TraitTrayScreen.HoverFrame, DestinationId = button.Id })

	SetInteractProperty({ DestinationId = button.Id, Property = "TooltipOffsetX", Value = -button.OffsetX + 1360 + ((ScreenAnchors.TraitTrayScreen.ShownColumns - 1) * 64) })
	SetInteractProperty({ DestinationId = button.Id, Property = "TooltipOffsetY", Value = -button.OffsetY + 224 + (((button.PinIndex or #ScreenAnchors.TraitTrayScreen.Pins) - 1) * ScreenAnchors.TraitTrayScreen.PinSpacing) })

	ScreenAnchors.LastHoverId = button.Id
end

function ClearTraitTrayDetails( detailsBox, rarityBox, titleBox, patch, icon )

	ModifyTextBox({ Id = detailsBox.Id, Text = "BoonInfo_Blank" })
	if rarityBox ~= nil then
		ModifyTextBox({ Id = rarityBox.Id, Text = "BoonInfo_Blank" })
	end
	if titleBox ~= nil then
		ModifyTextBox({ Id = titleBox.Id, Text = "BoonInfo_Blank" })
	end
	SetColor({ Id = patch.Id, Color = Color.Transparent })
	SetAnimation({ Name = "Blank", DestinationId = icon.Id, Group = "Combat_Menu_TraitTray" })
end

function SetTraitTrayDetails( button, detailsBox, rarityBox, titleBox, patch, icon )

	local forTraitTray = true
	if button.ForBoonInfo then
		forTraitTray = false
	end

	local name = GetTraitTooltip( button.TraitData, { ForTraitTray = forTraitTray } )
	if HasDisplayName({ Text = name .."_Initial" }) then
		name = name .."_Initial"
	end
	-- Chaos curse/blessing traits need VariableAutoFormat disabled
	local autoFormat = "BoldFormatGraft"
	if button.TraitData.OnExpire ~= nil and button.TraitData.OnExpire.TraitData ~= nil then
		autoFormat = ""
	end
	ModifyTextBox({ Id = detailsBox.Id, VariableAutoFormat = autoFormat, Text = name, LuaKey = "TooltipData", LuaValue = button.TraitData, UseDescription = true })
	ModifyTextBox({ Id = button.Id, Text = name, LuaKey = "TooltipData", LuaValue = button.TraitData, UseDescription = true, ReReadImmedaitely = true, })

	local title = GetTraitTooltipTitle( button.TraitData )
	local traitCount = 1
	if not button.ForBoonInfo then 
		traitCount = GetTraitCount( CurrentRun.Hero, button.TraitData )
	end

	if traitCount > 1 then
		title = "TraitLevel_Current"
		button.TraitData.OldLevel = traitCount;
		if not button.TraitData.Title then
			button.TraitData.Title = GetTraitTooltipTitle( button.TraitData )
		end
	end
	local titleColor = Color.White
	local rarityPatchColor = Color.Transparent
	local rarityText = "Blank"
	
	if button.TraitData.CustomRarityColor then
		rarityPatchColor = button.TraitData.CustomRarityColor
		titleColor = button.TraitData.CustomRarityColor
	elseif button.OverrideRarity ~= nil and button.OverrideRarity ~= "Common" then
		rarityPatchColor = Color["BoonPatch"..button.OverrideRarity]
		titleColor = Color["BoonPatch"..button.OverrideRarity]
	elseif button.TraitData.Rarity ~= nil and button.TraitData.Rarity ~= "Common" then
		rarityPatchColor = Color["BoonPatch"..button.TraitData.Rarity]
		titleColor = Color["BoonPatch"..button.TraitData.Rarity]
	end

	if button.TraitData.CustomRarityName then
		rarityText = button.TraitData.CustomRarityName
	elseif button.OverrideRarity then
		rarityText = "Boon_"..tostring(button.OverrideRarity)
	elseif button.TraitData.Rarity ~= nil then
		rarityText = "Boon_"..tostring(button.TraitData.Rarity)
	end
	if rarityBox ~= nil then
		ModifyTextBox({ Id = rarityBox.Id, Color = rarityPatchColor, Text = rarityText })
	end
	if titleBox ~= nil then
		ModifyTextBox({ Id = titleBox.Id, Text = title, Color = titleColor, LuaKey = "TooltipData", LuaValue = button.TraitData })
	end
	SetColor({ Id = patch.Id, Color = rarityPatchColor })
	SetAnimation({ Name = GetTraitIcon( button.TraitData, true ), DestinationId = icon.Id, Group = "Combat_Menu_TraitTray" })

end

function TraitUIAdd( trait, useFade )
	if not ConfigOptionCache.ShowUIAnimations or (( CombatUI.Hiding or not IsEmpty( CombatUI.Hide ) or not ShowingCombatUI ) and not CombatUI.ShowUIForDecision ) then
		return
	end

	if CurrentDeathAreaRoom ~= nil then
		if CurrentDeathAreaRoom.ShowResourceUIOnly then
			return
		end
	else
		if CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.HideCombatUI then
			return
		end
	end

	if not IsShownInTraitTray(trait) then
		return
	end

	local updatedTrait = IsExistingTraitShown( trait )
	if not updatedTrait then
		TraitUICreateComponent( trait, useFade )
	else
		UpdateTraitNumber( trait )
		trait = GetExistingUITrait( trait )
	end

	if not updatedTrait then
		FadeObstacleIn({ Id = trait.AnchorId, Duration = CombatUI.FadeInDuration, IncludeText = true, Direction = 0, Distance = CombatUI.FadeDistance.Trait})
		if trait.TraitIconOverlay ~= nil then
			FadeObstacleIn({ Id = trait.TraitIconOverlay, Duration = CombatUI.FadeInDuration, IncludeText = false, Direction = 0, Distance = CombatUI.FadeDistance.Trait })
		end
	end
end


function GetTraitIndex( trait )
	if trait.Slot == nil then
		if CurrentRun.Hero and CurrentRun.Hero.RecentTraits then
			for i, recentTraitData in pairs(CurrentRun.Hero.RecentTraits) do
				if AreTraitsIdentical( trait, recentTraitData ) then
					return i
				end
			end
			return -1
		else
			return -1
		end
	end

	if trait.Slot == "Assist" then
		return -1
	elseif trait.Slot == "Melee" then
		return 0
	elseif trait.Slot == "Secondary" then
		return 1
	elseif trait.Slot == "Ranged" then
		return 2
	elseif trait.Slot == "Rush" then
		return 3
	elseif trait.Slot == "Shout" then
		return 4
	elseif trait.Slot == "Keepsake" then
		if not HasUnlockedWrath() then
			return 4
		end
		return 5
	end
end
function PriorityTrayTraitAdd( newTrait, args )
	if newTrait.Slot or newTrait.Hidden then
		return
	end
	args = args or {}
	UpdateAdditionalTraitHint()

	local recentTraitData =
	{
		Name = newTrait.Name,
		LastCurseName = newTrait.LastCurseName,
		LastBlessingName = newTrait.LastBlessingName,
		Id = newTrait.Id or GetTraitUniqueId(),
		RemainingUses = newTrait.RemainingUses,
		Uses = newTrait.Uses,
		PriorityDisplay = newTrait.PriorityDisplay,
	}
	if newTrait.OnExpire and newTrait.OnExpire.TraitData then
		recentTraitData.OnExpire = { TraitData = { Name = newTrait.OnExpire.TraitData.Name } }
	end
	for i, traitData in pairs( CurrentRun.Hero.RecentTraits ) do
		if AreTraitsIdentical( newTrait, traitData ) then
			return
		end
	end
	table.insert( CurrentRun.Hero.RecentTraits, 1, recentTraitData )
	if TableLength( CurrentRun.Hero.RecentTraits ) > TraitUI.RecentTraitSize then
		local removedTrait = table.remove( CurrentRun.Hero.RecentTraits )
		TraitUIRemove( GetExistingUITrait( removedTrait ))
	end

	if not args.DeferSort then
		SortPriorityTraits()
	end
end

function PriorityTrayTraitRemove( trait )
	if IsEmpty( CurrentRun.Hero.RecentTraits ) then
		return
	end
	for i, traitData in pairs ( CurrentRun.Hero.RecentTraits ) do
		if AreTraitsIdentical( traitData, trait ) then
			CurrentRun.Hero.RecentTraits[i] = nil
		end
	end
	CurrentRun.Hero.RecentTraits = CollapseTable( CurrentRun.Hero.RecentTraits )
	SortPriorityTraits()
end

function SortPriorityTraits()

	if  not ConfigOptionCache.ShowUIAnimations or (( CombatUI.Hiding or not IsEmpty( CombatUI.Hide ) or not ShowingCombatUI ) and not CombatUI.ShowUIForDecision ) then
		return
	end


	if CurrentRun.Hero and CurrentRun.Hero.RecentTraits then
		local generatedIds = {}
		for i, recentTraitData in pairs(CurrentRun.Hero.RecentTraits) do
			local trait = GetExistingUITrait( recentTraitData )
			if trait then
				local offsetX = CombatUI.TraitUIStart  + 8 + TraitUI.SpacerX * 0.5
				local offsetY = TraitUI.IconStartY + GetTraitIndex(trait) * TraitUI.SpacerY - TraitUI.SpacerY * 0.5

				local randomNewTargetId = SpawnObstacle({ Name = "InvisibleTarget", OffsetX = offsetX, OffsetY = offsetY, Group = "Standing" })
				Move({ Id = trait.AnchorId, DestinationId = randomNewTargetId, Duration = 0.25 })
				table.insert( generatedIds, randomNewTargetId )
			else
				local showingTrait = nil
				local rarityValue = 0
				for s, existingTrait in pairs( CurrentRun.Hero.Traits) do
					if (AreTraitsIdentical(existingTrait, recentTraitData) and rarityValue < GetRarityValue( existingTrait.Rarity )) then
						showingTrait = existingTrait
						rarityValue = GetRarityValue( showingTrait.Rarity )
					end
				end
				if showingTrait then
					TraitUIAdd( showingTrait, false )
				end
			end
		end

		local numHidden = GetNumHiddenTraits()
		if numHidden > 0 then
			UpdateAdditionalTraitHint( numHidden )
			local randomNewTargetId = SpawnObstacle({ Name = "InvisibleTarget", OffsetX = 8 + CombatUI.TraitUIStart + 0.5 * TraitUI.SpacerX, OffsetY = TraitUI.StartY + TraitUI.SpacerY * (-2 + TableLength(CurrentRun.Hero.RecentTraits)), Group = "Standing" })
			Move({ Id = ScreenAnchors.AdditionalTraitHint, DestinationId = randomNewTargetId, Duration = 0.25 })
			table.insert( generatedIds, randomNewTargetId )
		elseif ScreenAnchors.AdditionalTraitHint ~= nil then
			Destroy({ Id = ScreenAnchors.AdditionalTraitHint })
			ScreenAnchors.AdditionalTraitHint = nil
		end

		if not IsEmpty(generatedIs) then
			Destroy({ Ids = generatedIds })
		end
	end
end

function GetTraitTraySize()
	local traySize = 4
	if HasUnlockedKeepsakes() then
		traySize = traySize + 1
	end

	if HasUnlockedWrath() then
		traySize = traySize + 1
	end

	return traySize
end

function HasUnlockedKeepsakes()
	return GameState.LastAwardTrait ~= nil
end

function HasUnlockedWrath()
	return TextLinesRecord.PoseidonWrathIntro01 ~= nil
end

function IsShownInTraitTray( trait )
	if CurrentRun.Hero and CurrentRun.Hero.RecentTraits then
		for i, recentTraitData in pairs(CurrentRun.Hero.RecentTraits) do
			if AreTraitsIdentical( recentTraitData, trait ) then
				return true
			end
		end
	end
	return trait.Slot ~= nil
end

function GetNumHiddenTraits()
	if CurrentRun.Hero.NumHiddenTraitsCache == nil then
		UpdateNumHiddenTraits()
	end
	return CurrentRun.Hero.NumHiddenTraitsCache
end

function UpdateNumHiddenTraits()
	local numHidden = 0
	local hiddenTraits = {}
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		if not trait.Hidden then
			if not IsShownInTraitTray( trait ) then
				local hasIdentical = false
				for s, hiddenTrait in pairs( hiddenTraits ) do
					if AreTraitsIdentical( hiddenTrait, trait ) then
						hasIdentical = true
					end
				end
				if not hasIdentical then
					numHidden = numHidden + 1
					table.insert( hiddenTraits, trait )
				end
			end
		end
	end
	CurrentRun.Hero.NumHiddenTraitsCache = numHidden
end

function CleanRecentTraitsRecord()
	if not CurrentRun or not CurrentRun.Hero or not CurrentRun.Hero.RecentTraits then
		return
	end
	for index, recentTraitData in pairs(CurrentRun.Hero.RecentTraits) do
		if not HeroHasTrait(recentTraitData.Name) or not IsPrioritizedDisplayTrait( recentTraitData ) or not recentTraitData.Id then
			CurrentRun.Hero.RecentTraits[index] = nil
		end
	end
	CurrentRun.Hero.RecentTraits = CollapseTable( CurrentRun.Hero.RecentTraits )
	SortPriorityTraits()
end

function IsPrioritizedDisplayTrait( trait )
	if not trait then
		return false
	end
	if trait.PriorityDisplay or trait.RemainingUses or trait.Uses then
		return true
	end
	return false
end

function SetupMetaIconTrayTooltip( button, upgradeName, upgradeData, offsetX, args )
	local tooltipName = upgradeName
	if CurrentRun.Hero and not CurrentRun.Hero.IsDead and upgradeData.InRunTooltip then
		tooltipName = upgradeData.InRunTooltip
	end
	local currentValue = nil
	if upgradeData.InRunValueFunctionName and _G[upgradeData.InRunValueFunctionName] then
		currentValue = _G[upgradeData.InRunValueFunctionName]()
	end
	CreateTextBox({ Id = button.Id,
		TextSymbolScale = 0,
		Text = tooltipName,
		Color = Color.Transparent,
		LuaKey = "TempTextData",
		LuaValue =
		{
			BaseValue = GetMetaUpgradeStatDelta( upgradeData ),
			StartingValue = (upgradeData.BaseValue or 0),
			CurrentValue = currentValue,
			DisplayValue = (upgradeData.DisplayValue or 0)
		}
	})
	if args.DisableTooltips then
		UseableOff({ Id = button.Id })
	else
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipOffsetX", Value = 1450 - offsetX })
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipOffsetY", Value = 44 })
		AttachLua({ Id = button.Id, Table = button })
		SetThingProperty({ DestinationId = button.Id, Property = "AddColor", Value = true })
		MouseOffMetaIconTray( button )
		button.OnMouseOverFunctionName = "MouseOverMetaIconTray"
		button.OnMouseOffFunctionName = "MouseOffMetaIconTray"
	end
end
