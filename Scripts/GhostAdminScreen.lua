function UseGhostAdmin( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenGhostAdminScreen()
	UseableOn({ Id = usee.ObjectId })
	GhostAdminSessionCompletePresentation( usee, screen )
end

function DisplayCosmetics( screen, slotName )

	local components = screen.Components

	ModifyTextBox({ Id = components["Category"..slotName].Id, Color = Color.White })
	DestroyTextBox({ Id = components.ShopBackgroundDim.Id })

	local newButtonKey = "NewIcon"..slotName
	if components[newButtonKey] ~= nil then
		SetAlpha({ Id = components[newButtonKey].Id, Fraction = 0.0 })
	end

	screen.ActiveCategory = slotName

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	local availableItems = {}
	local purchasedItems = {}

	for cosmeticName, cosmeticData in pairs( ConditionalItemData ) do
		if not cosmeticData.DebugOnly and cosmeticData.ResourceCost ~= nil and not cosmeticData.Disabled then
			if cosmeticData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, cosmeticData, cosmeticData.GameStateRequirements ) then
				if GameState.CosmeticsAdded[cosmeticName] then
					purchasedItems[cosmeticData.Slot] = purchasedItems[cosmeticData.Slot] or {}
					table.insert( purchasedItems[cosmeticData.Slot], cosmeticData )
				else

					availableItems[cosmeticData.Slot] = availableItems[cosmeticData.Slot] or {}
					table.insert( availableItems[cosmeticData.Slot], cosmeticData )
				end
			end
		end
	end
	for trackName, trackData in pairs( MusicPlayerTrackData ) do
		if not trackData.DebugOnly and trackData.ResourceCost ~= nil then
			if GameState.CosmeticsAdded[trackData.Name] then
				purchasedItems.Music = purchasedItems.Music or {}
				table.insert( purchasedItems.Music, trackData )
			else
				if trackData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, trackData, trackData.GameStateRequirements ) then
					availableItems.Music = availableItems.Music or {}
					table.insert( availableItems.Music, trackData )
				end
			end
		end
	end

	screen.NumItems = 0
	screen.NumItemsPurchaseable = 0
	screen.NumItemsAffordable = 0

	local firstUseable = false

	-- Available
	local itemsToDisplay = availableItems[slotName] or {}
	table.sort( itemsToDisplay, CosmeticItemSort )
	for k, cosmetic in ipairs( itemsToDisplay ) do

		screen.NumItems = screen.NumItems + 1
		screen.NumItemsPurchaseable = screen.NumItemsPurchaseable + 1
		if HasResource( cosmetic.ResourceName, cosmetic.ResourceCost ) then
			screen.NumItemsAffordable = screen.NumItemsAffordable + 1
		end

		screen.OfferedVoiceLines = screen.OfferedVoiceLines or cosmetic.OfferedVoiceLines

		local purchaseButtonKey = "PurchaseButton"..screen.NumItems
		components[purchaseButtonKey] = CreateScreenComponent({ Name = "ButtonGhostAdminItem", Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })
		components[purchaseButtonKey].OnMouseOverFunctionName = "MouseOverGhostAdminItem"
		AttachLua({ Id = components[purchaseButtonKey].Id, Table = components[purchaseButtonKey] })
		SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = 665 })

		local purchaseButtonTitleKey = "PurchaseButtonTitle"..screen.NumItems
		components[purchaseButtonTitleKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })

		if cosmetic.Icon ~= nil then
			local iconKey = "Icon"..screen.NumItems
			components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX, Y = itemLocationY, Scale = 0.5, Group = "Combat_Menu" })
			SetAnimation({ DestinationId = components[iconKey].Id , Name = cosmetic.Icon })
		end

		local name = cosmetic.Name
		for trackName, trackData in pairs( MusicPlayerTrackData ) do
			if trackData.Name == name then
				name = GetMusicTrackTitle( name )
				break
			end
		end

		local displayName = name

		local resourceData = ResourceData[cosmetic.ResourceName]
		local costString = resourceData.IconPath
		costString = cosmetic.ResourceCost.." @"..costString
		local costColor = Color.CostAffordableShop
		if not HasResource( cosmetic.ResourceName, cosmetic.ResourceCost ) then
			costColor = Color.CostUnaffordable
		end

		-- Title
		CreateTextBox(MergeTables({ Id = components[purchaseButtonTitleKey].Id,
			Text = displayName,
			OffsetX = -355,
			OffsetY = -20,
			FontSize = 24,
			Width = 720,
			Color = costColor,
			Font = "AlegreyaSansSCBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Left",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		}, LocalizationData.GhostAdminScreen.CosmeticTitle ))

		-- Cost
		CreateTextBox(MergeTables({ Id = components[purchaseButtonTitleKey].Id, Text = costString,
			OffsetX = 430,
			OffsetY = 0,
			FontSize = 28,
			Color = costColor,
			Font = "AlegreyaSansSCBold",
			Justification = "Right",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		}, LocalizationData.GhostAdminScreen.CosmeticCost ))

		-- Description
		CreateTextBoxWithFormat(MergeTables({ Id = components[purchaseButtonKey].Id,
			Text = displayName,
			OffsetX = -355,
			OffsetY = -4,
			Format = "BaseFormat",
			UseDescription = true,
			VariableAutoFormat = "BoldFormatGraft",
			LuaKey = "TooltipData",
			LuaValue = cosmetic,
			Justification = "Left",
			VerticalJustification = "Top",
			LineSpacingBottom = 0,
			Width = 615,
			FontSize = 16,
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		}, LocalizationData.GhostAdminScreen.CosmeticDescription))

		components[purchaseButtonKey].OnPressedFunctionName = "HandleGhostAdminPurchase"
		if not firstUseable then
			TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
			firstUseable = true
		end

		components[purchaseButtonKey].Data = cosmetic
		components[purchaseButtonKey].Index = screen.NumItems
		components[purchaseButtonKey].TitleId = components[purchaseButtonTitleKey].Id
		components[purchaseButtonKey].DisplayName = name

		if not GameState.CosmeticsViewed[cosmetic.Name] then
			-- New icon
			local newButtonKey = "NewIcon"..screen.NumItems
			components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
			SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "MusicPlayerNewTrack" })
			Attach({ Id = components[newButtonKey].Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = -430, OffsetY = 0 })
			components[purchaseButtonKey].NewButtonId = components[newButtonKey].Id
		end

		itemLocationY = itemLocationY + screen.EntryYSpacer

	end

	-- Purchased
	local itemsToDisplay = purchasedItems[slotName] or {}
	table.sort( itemsToDisplay, CosmeticItemSort )
	for k, cosmetic in ipairs( itemsToDisplay ) do

		screen.NumItems = screen.NumItems + 1

		local buttonName = "ButtonGhostAdminItem"
		if not cosmetic.Removable or ( cosmetic.RotateOnly and GameState.Cosmetics[cosmetic.Name] ) then
			buttonName = "ButtonGhostAdminItemDisabled"
		end

		local purchaseButtonKey = "PurchaseButton"..screen.NumItems
		components[purchaseButtonKey] = CreateScreenComponent({ Name = buttonName, Group = "Combat_Menu", Scale = 1.0, X = itemLocationX, Y = itemLocationY })
		SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = 665 })

		local purchaseButtonTitleKey = "PurchaseButtonTitle"..screen.NumItems
		components[purchaseButtonTitleKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })

		if cosmetic.Icon ~= nil then
			local iconKey = "Icon"..screen.NumItems
			components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX, Y = itemLocationY, Scale = 0.4, Group = "Combat_Menu" })
			SetAnimation({ DestinationId = components[iconKey].Id , Name = cosmetic.Icon })
		end

		local name = cosmetic.Name
		for trackName, trackData in pairs( MusicPlayerTrackData ) do
			if trackData.Name == name then
				name = GetMusicTrackTitle( name )
				break
			end
		end

		local titleColor = {0.5, 0.5, 0.5, 1.0}
		local displayName = cosmetic.RePurchaseName or name
		local costText = "Shop_Purchased"
		if cosmetic.Removable then
			if GameState.Cosmetics[name] then
				if not cosmetic.RotateOnly then
					components[purchaseButtonKey].OnPressedFunctionName = "HandleGhostAdminRemoval"
					--titleColor = Color.CostAffordableShop
					costText = "Shop_Removable"
				end
			else
				components[purchaseButtonKey].Free = true
				components[purchaseButtonKey].OnPressedFunctionName = "HandleGhostAdminPurchase"
				--titleColor = Color.CostAffordableShop
				costText = "Shop_ReAdd"
			end
		end

		-- Title
		CreateTextBox(MergeTables({ Id = components[purchaseButtonTitleKey].Id,
			Text = displayName,
			OffsetX = -355,
			OffsetY = -22,
			FontSize = 24,
			Width = 720,
			Color = titleColor,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
			Justification = "Left",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		}, LocalizationData.GhostAdminScreen.CosmeticTitle ))

		-- Cost
		CreateTextBox(MergeTables({ Id = components[purchaseButtonTitleKey].Id,
			Text = costText,
			OffsetX = 430,
			OffsetY = 0,
			FontSize = 28,
			Color = Color.White,
			Font = "AlegreyaSansSCBold",
			Justification = "Right",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		}, LocalizationData.GhostAdminScreen.CosmeticCost ))

		-- Description
		CreateTextBoxWithFormat(MergeTables({ Id = components[purchaseButtonKey].Id,
			Text = displayName,
			OffsetX = -355,
			OffsetY = -4,
			Format = "BaseFormat",
			UseDescription = true,
			VariableAutoFormat = "BoldFormatGraft",
			LuaKey = "TooltipData",
			LuaValue = cosmetic,
			Justification = "Left",
			VerticalJustification = "Top",
			LineSpacingBottom = 0,
			Width = 615,
			FontSize = 16,
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		}, LocalizationData.GhostAdminScreen.CosmeticDescription))

		if not firstUseable then
			TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
			firstUseable = true
		end

		components[purchaseButtonKey].Data = cosmetic
		components[purchaseButtonKey].Index = screen.NumItems
		components[purchaseButtonKey].TitleId = components[purchaseButtonTitleKey].Id
		components[purchaseButtonKey].DisplayName = name

		itemLocationY = itemLocationY + screen.EntryYSpacer

	end

	GhostAdminPostDisplayCategoryPresentation( screen )

end

function OpenGhostAdminScreen( defaultCategory )

	local screen = DeepCopyTable( ScreenData.GhostAdmin )
	screen.Components = {}
	screen.Name = "GhostAdmin"
	screen.Resource = "Gems"
	screen.SaleData = {}
	screen.NumSales = 0
	screen.NumItemsOffered = 0
	screen.ActiveCategory = defaultCategory or screen.DisplayOrder[1]

	if IsScreenOpen( screen.Name ) then
		return
	end
	OnScreenOpened({ Flag = screen.Name, PersistCombatUI = true })
	FreezePlayerUnit()
	EnableShopGamepadCursor()
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 8 })
	SetConfigOption({ Name = "FreeFormSelectSuccessDistanceStep", Value = 8 })
	SetConfigOption({ Name = "FreeFormSelectRepeatDelay", Value = 0.6 })
	SetConfigOption({ Name = "FreeFormSelectRepeatInterval", Value = 0.1 })
	SetConfigOption({ Name = "FreeFormSelecSearchFromId", Value = 0 })

	PlaySound({ Name = "/SFX/Menu Sounds/ContractorMenuOpen" })

	local components = screen.Components

	components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })
	components.ShopBackground = CreateScreenComponent({ Name = "GhostAdminScreenBackground", Group = "Combat_Menu" })
	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 4 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.090, 0.055, 0.157, 0.7} })

	wait(0.5)
	-- Title
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "GhostAdminScreen_Title", FontSize = 32, OffsetX = 0, OffsetY = -445, Color = Color.White, Font = "SpectralSCLightTitling", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3}, Justification = "Center",
		LangEsScaleModifier = 0.9,
	})

	-- Flavor Text
	local flavorTextOptions = { "GhostAdminScreen_FlavorText01", "GhostAdminScreen_FlavorText02", "GhostAdminScreen_FlavorText03", }
	local flavorText = GetRandomValue( flavorTextOptions )
	CreateTextBox(MergeTables({ Id = components.ShopBackground.Id, Text = flavorText,
			FontSize = 16,
			OffsetY = -370, Width = 840,
			Color = {0.698, 0.702, 0.514, 1.0},
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Center" }, LocalizationData.GhostAdminScreen.FlavorText))

	local categoryTitleX = 480
	for slotIndex, slotName in ipairs( screen.DisplayOrder ) do
		screen.Components["Category"..slotName] = CreateScreenComponent({ Name = "ButtonGhostAdminTab", X = categoryTitleX, Y = 245, Scale = 1.0, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
		screen.Components["Category"..slotName].OnPressedFunctionName = "GhostAdminSelectCategory"
		screen.Components["Category"..slotName].Category = slotName
		CreateTextBox({ Id = screen.Components["Category"..slotName].Id,
			Text = slotName,
			FontSize = 16,
			Color = Color.CodexTitleUnselected,
			Font = "AlegreyaSansSCBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Center"
		})

		if slotName ~= screen.ActiveCategory and HasUnviewedCosmetic( slotName ) then
			-- New icon
			local newButtonKey = "NewIcon"..slotName
			components[newButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
			SetAnimation({ DestinationId = components[newButtonKey].Id , Name = "MusicPlayerNewTrack" })
			Attach({ Id = components[newButtonKey].Id, DestinationId = screen.Components["Category"..slotName].Id, OffsetX = 0, OffsetY = -30 })
		elseif not HasUnpurchasedCosmetic( slotName ) then
			-- Complete icon
			local completeButtonKey = "CompleteIcon"..slotName
			components[completeButtonKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
			SetAnimation({ DestinationId = components[completeButtonKey].Id , Name = "ContractorPurchasedCheckmark" })
			Attach({ Id = components[completeButtonKey].Id, DestinationId = screen.Components["Category"..slotName].Id, OffsetX = 0, OffsetY = -20 })
		end

		categoryTitleX = categoryTitleX + 193
	end

	DisplayCosmetics( screen, screen.ActiveCategory )

	CreateTextBox({ Id = components.ShopBackground.Id, Text = "GhostAdminScreen_Hint", FontSize = 14, OffsetX = 0, OffsetY = 370, Width = 840, Color = Color.Gray, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })

	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Group = "Combat_Menu", Scale = 0.7 })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = 0, OffsetY = 440 })
	components.CloseButton.OnPressedFunctionName = "CloseGhostAdminScreen"
	components.CloseButton.ControlHotkey = "Cancel"

	screen.Components.ScrollLeft = CreateScreenComponent({ Name = "ButtonCodexLeft", X = ScreenCenterX - 999, Y = 260, Scale = 0.75, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
	screen.Components.ScrollLeft.OnPressedFunctionName = "GhostAdminPrevCategory"
	screen.Components.ScrollLeft.ControlHotkeys = { "MenuLeft", "Left" }
	SetAlpha({ Id = screen.Components.ScrollLeft.Id, Fraction = 0.01 })
	SetInteractProperty({ DestinationId = screen.Components.ScrollLeft.Id, Property = "FreeFormSelectable", Value = false })

	screen.Components.ScrollRight = CreateScreenComponent({ Name = "ButtonCodexRight", X = ScreenCenterX + 999, Y = 260, Scale = 0.75, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
	screen.Components.ScrollRight.OnPressedFunctionName = "GhostAdminNextCategory"
	screen.Components.ScrollRight.ControlHotkeys = { "MenuRight", "Right" }
	SetAlpha({ Id = screen.Components.ScrollRight.Id, Fraction = 0.01 })
	SetInteractProperty({ DestinationId = screen.Components.ScrollRight.Id, Property = "FreeFormSelectable", Value = false })

	screen.Components.ScrollUp = CreateScreenComponent({ Name = "ButtonCodexUp", X = 500, Y = screen.ItemStartY - screen.EntryYSpacer + 75, Scale = 0.75, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
	screen.Components.ScrollUp.OnPressedFunctionName = "GhostAdminScrollUp"
	screen.Components.ScrollUp.ControlHotkey = "MenuUp"

	screen.Components.ScrollDown = CreateScreenComponent({ Name = "ButtonContractorDown", X = 500, Y = screen.ItemStartY + ( (screen.EntryYSpacer + 1) * screen.ItemsPerPage) - 75, Scale = 0.75, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
	screen.Components.ScrollDown.OnPressedFunctionName = "GhostAdminScrollDown"
	screen.Components.ScrollDown.ControlHotkey = "MenuDown"

	SetAlpha({ Ids = { components.ScrollUp.Id, components.ScrollDown.Id }, Fraction = 0, Duration = 0 })
	GhostAdminUpdateVisibility( screen )

	thread( GhostAdminScreenOpenedPresentation, screen )

	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )
	return screen

end

function HasUnviewedCosmetic( slotName )
	if slotName == "Music" then
		for trackName, trackData in pairs( MusicPlayerTrackData ) do
			if not trackData.DebugOnly and trackData.ResourceCost ~= nil and not GameState.CosmeticsAdded[trackData.Name] then
				if trackData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, trackData, trackData.GameStateRequirements ) then
					if not GameState.CosmeticsViewed[trackData.Name] then
						return true
					end
				end
			end
		end
	else
		for cosmeticName, cosmeticData in pairs( ConditionalItemData ) do
			if not cosmeticData.DebugOnly and cosmeticData.ResourceCost ~= nil and not cosmeticData.Disabled and cosmeticData.Slot == slotName and not GameState.CosmeticsAdded[cosmeticData.Name] then
				if cosmeticData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, cosmeticData, cosmeticData.GameStateRequirements ) then
					if not GameState.CosmeticsViewed[cosmeticData.Name] then
						return true
					end
				end
			end
		end
	end
	return false
end

function HasUnpurchasedCosmetic( slotName )
	if slotName == "Music" then
		for trackName, trackData in pairs( MusicPlayerTrackData ) do
			if not trackData.DebugOnly and trackData.ResourceCost ~= nil and not GameState.CosmeticsAdded[trackData.Name] then
				return true
			end
		end
	else
		for cosmeticName, cosmeticData in pairs( ConditionalItemData ) do
			if not cosmeticData.DebugOnly and cosmeticData.ResourceCost ~= nil and not cosmeticData.Disabled and cosmeticData.Slot == slotName and not GameState.CosmeticsAdded[cosmeticData.Name] then
				return true
			end
		end
	end
	return false
end

function CloseGhostAdminScreen( screen, button )
	DisableShopGamepadCursor()
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16 })
	SetConfigOption({ Name = "FreeFormSelectSuccessDistanceStep", Value = 8 })
	SetConfigOption({ Name = "FreeFormSelectRepeatDelay", Value = 0.0 })

	PlaySound({ Name = "/SFX/Menu Sounds/ContractorMenuClose" })
	SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = "GhostAdminScreenOut" })
	wait(0.25)
	CloseScreen( GetAllIds( screen.Components ) )

	UnfreezePlayerUnit()
	screen.KeepOpen = false
	OnScreenClosed({ Flag = screen.Name })
end

function HandleGhostAdminPurchase( screen, button )
	local upgradeData = button.Data

	if not button.Free and not HasResource( upgradeData.ResourceName, upgradeData.ResourceCost ) then
		Flash({ Id = screen.Components["PurchaseButton".. button.Index].Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
		CantAffordPresentation()
		return
	end

	if upgradeData.ResourceCost ~= nil and upgradeData.ResourceCost > 0 and upgradeData.PurchaseRequirements ~= nil and not IsGameStateEligible( CurrentRun, upgradeData.PurchaseRequirements ) then
		CantPurchasePresentation( screen.Components["PurchaseButton".. button.Index] )
		return
	end

	if button.Free then
		PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteAffectionSFX" })
	else
		PlaySound({ Name = "/SFX/Menu Sounds/ContractorItemPurchase" })
		-- needed PlayPurchase* because setting SkipPurchase* to nil doesn't work
		if upgradeData.PlayPurchaseGlobalVoiceLines or not upgradeData.SkipPurchaseGlobalVoiceLines then
			thread( PlayVoiceLines, GlobalVoiceLines.PurchasedGhostAdminItemVoiceLines, true )
		end
		SpendResource( upgradeData.ResourceName, upgradeData.ResourceCost, upgradeData.Name )
	end

	table.insert( screen.SaleData, upgradeData )
	screen.NumSales = screen.NumSales + 1

	local status = UIData.Constants.PENDING_REVEAL
	if button.Free then
		status = UIData.Constants.VISIBLE
	end
	AddCosmetic( upgradeData.Name, status )
	if upgradeData.Names ~= nil then
		for i, name in pairs( upgradeData.Names ) do
			AddCosmetic( name, status )
		end
	end
	if upgradeData.RemoveCosmetics ~= nil then
		for k, name in pairs( upgradeData.RemoveCosmetics ) do
			GameState.Cosmetics[name] = nil
		end
	end
	if upgradeData.OnPurchasedFunctionName ~= nil then
		local onPurcahsedFunction = _G[upgradeData.OnPurchasedFunctionName]
		onPurcahsedFunction( upgradeData.OnPurchasedFunctionArgs )
	end

	Destroy({ Id = screen.Components["PurchaseButtonTitle".. button.Index].Id })
	screen.Components["PurchaseButtonTitle".. button.Index] = nil

	CreateAnimation({ Name = "ContractorSlotPurchase", DestinationId = screen.Components["PurchaseButton".. button.Index].Id, OffsetX = 0 })

	Destroy({ Id = screen.Components["PurchaseButton".. button.Index].Id })
	screen.Components["PurchaseButton".. button.Index] = nil

	if screen.Components["Icon".. button.Index] ~= nil then
		Destroy({ Id = screen.Components["Icon".. button.Index].Id })
		screen.Components["Icon".. button.Index] = nil
	end

	for i, button in pairs( screen.Components ) do
		if button.Data ~= nil and button.Data.ResourceCost ~= nil then
			local costColor = Color.CostAffordable
			if not HasResource( button.Data.ResourceName, button.Data.ResourceCost ) then
				costColor = Color.CostUnaffordable
			end
			local purchaseButtonTitleKey = "PurchaseButtonTitle"..button.Index
			ModifyTextBox({ Id = screen.Components[purchaseButtonTitleKey].Id, Color = costColor })
		end
	end
	-- close screen
	CloseGhostAdminScreen( screen, button )

	thread( DoGhostAdminPurchase, screen, button )
end

function DoGhostAdminPurchase( screen, button )
	local itemData = button.Data
	PreActivateCosmeticItemsPresentation( button, itemData )
	ActivateConditionalItem( itemData )
	if itemData.ActivateUnits ~= nil then
		ActivatePrePlacedUnits( itemData, { Ids = itemData.ActivateUnits, CheckConversations = true, FadeInDuration = itemData.FadeInDuration, } )
	end
	PostActivateCosmeticItemsPresentation( button, itemData )

	OpenGhostAdminScreen( screen.ActiveCategory )
end

function HandleGhostAdminRemoval( screen, button )
	local itemData = button.Data

	PlaySound({ Name = "/SFX/Menu Sounds/ContractorItemPurchase" })
	--[[
	if not upgradeData.SkipPurchaseGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines.PurchasedGhostAdminItemVoiceLines, true )
	end

	--table.insert( screen.SaleData, upgradeData )
	--screen.NumSales = screen.NumSales + 1
	--]]

	GameState.Cosmetics[itemData.Name] = nil

	--[[
	if upgradeData.OnPurchasedFunctionName ~= nil then
		local onPurcahsedFunction = _G[upgradeData.OnPurchasedFunctionName]
		onPurcahsedFunction( upgradeData.OnPurchasedFunctionArgs )
	end
	]]

	Destroy({ Id = screen.Components["PurchaseButtonTitle".. button.Index].Id })
	screen.Components["PurchaseButtonTitle".. button.Index] = nil

	CreateAnimation({ Name = "ContractorSlotPurchase", DestinationId = screen.Components["PurchaseButton".. button.Index].Id, OffsetX = 0 })

	Destroy({ Id = screen.Components["PurchaseButton".. button.Index].Id })
	screen.Components["PurchaseButton".. button.Index] = nil

	if screen.Components["Icon".. button.Index] ~= nil then
		Destroy({ Id = screen.Components["Icon".. button.Index].Id })
		screen.Components["Icon".. button.Index] = nil
	end

	-- close screen
	CloseGhostAdminScreen( screen, button )

	thread( DoGhostAdminRemoval, screen, button )
end

function DoGhostAdminRemoval( screen, button )
	PreActivateCosmeticItemsPresentation( button, button.Data, { Removal = true } )
	DeactivateConditionalItem( button.Data )
	PostActivateCosmeticItemsPresentation( button, button.Data, { Removal = true } )

	OpenGhostAdminScreen( screen.ActiveCategory )
end

function AddCosmetic( name, status )

	if not GameState.Cosmetics[name] then
		thread( CheckQuestStatus )
	end

	-- Current ownership
	GameState.Cosmetics[name] = status or true
	-- Record of it ever being added
	GameState.CosmeticsAdded[name] = true
end

function GhostAdminHideItems( screen )
	local componentIds =  {}
	for i = 1, screen.NumItems do
		local purchaseButtonKey = "PurchaseButton"..i
		table.insert( componentIds, screen.Components[purchaseButtonKey].Id )
		local purchaseButtonTitleKey = "PurchaseButtonTitle"..i
		table.insert( componentIds, screen.Components[purchaseButtonTitleKey].Id )
		local iconKey = "Icon"..i
		table.insert( componentIds, screen.Components[iconKey].Id )
		local newButtonKey = "NewIcon"..i
		if screen.Components[newButtonKey] ~= nil then
			table.insert( componentIds, screen.Components[newButtonKey].Id )
		end
	end
	local fadeOutTime = 0.1
	SetAlpha({ Ids = componentIds, Fraction = 0, Duration = fadeOutTime })
	ModifyTextBox({ Ids = componentIds, FadeTarget = 0, FadeDuration = fadeOutTime })
	ModifyTextBox({ Id = screen.Components["Category"..screen.ActiveCategory].Id, Color = Color.CodexTitleUnselected })
	wait( fadeOutTime )
	Destroy({ Ids = componentIds })
end

function GhostAdminNextCategory( screen, button )
	GhostAdminSelectCategoryPresentation( screen, button )
	local nextCategoryIndex = GetKey( screen.DisplayOrder, screen.ActiveCategory ) + 1
	if nextCategoryIndex > #screen.DisplayOrder then
		nextCategoryIndex = 1
	end
	GhostAdminHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.EntryYSpacer) })
	DisplayCosmetics( screen, screen.DisplayOrder[nextCategoryIndex] )
	GhostAdminUpdateVisibility( screen )
end

function GhostAdminPrevCategory( screen, button )
	GhostAdminSelectCategoryPresentation( screen, button )
	local nextCategoryIndex = GetKey( screen.DisplayOrder, screen.ActiveCategory ) - 1
	if nextCategoryIndex < 1 then
		nextCategoryIndex = #screen.DisplayOrder
	end
	GhostAdminHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.EntryYSpacer) })
	DisplayCosmetics( screen, screen.DisplayOrder[nextCategoryIndex] )
	GhostAdminUpdateVisibility( screen )
end

function GhostAdminSelectCategory( screen, button )
	GhostAdminSelectCategoryPresentation( screen, button )
	GhostAdminHideItems( screen )
	wait( 0.1 )
	screen.ScrollOffset = 0
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.EntryYSpacer) })
	DisplayCosmetics( screen, button.Category )
	GhostAdminUpdateVisibility( screen )
end

function GhostAdminScrollUp( screen, button )
	if screen.ScrollOffset <= 0 then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset - screen.ItemsPerPage
	GhostAdminUpdateVisibility( screen )
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY + ((screen.ItemsPerPage - 1) * screen.EntryYSpacer), ForceUseCheck = true })
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
end

function GhostAdminScrollDown( screen, button )
	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		return
	end
	screen.ScrollOffset = screen.ScrollOffset + screen.ItemsPerPage
	GhostAdminUpdateVisibility( screen )
	TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
end

function GhostAdminUpdateVisibility( screen )

	local components = screen.Components
	local offIds = {}
	local onIds = {}
	for index = 1, screen.NumItems do
		local questButtonKey = "PurchaseButton"..index
		local purchaseButtonTitleKey = "PurchaseButtonTitle"..index
		local newButtonKey = "NewIcon"..index
		local iconKey = "Icon"..index

		local visibleIndex = index - screen.ScrollOffset

		if visibleIndex >= 1 and visibleIndex <= screen.ItemsPerPage then
			-- Page in view
			Teleport({ Id = components[questButtonKey].Id, OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((visibleIndex - 1) * screen.EntryYSpacer) })
			table.insert( onIds, components[questButtonKey].Id )
			Teleport({ Id = components[purchaseButtonTitleKey].Id, OffsetX = screen.ItemStartX, OffsetY = screen.ItemStartY + ((visibleIndex - 1) * screen.EntryYSpacer) })
			table.insert( onIds, components[purchaseButtonTitleKey].Id )
			Teleport({ Id = components[iconKey].Id, OffsetX = screen.ItemStartX + screen.IconOffsetX, OffsetY = screen.ItemStartY + screen.IconOffsetY + ((visibleIndex - 1) * screen.EntryYSpacer) })
			table.insert( onIds, components[iconKey].Id )
			if components[newButtonKey] ~= nil and not GameState.CosmeticsViewed[components[questButtonKey].Data.Name] then
				Teleport({ Id = components[newButtonKey].Id, OffsetX = screen.ItemStartX + screen.IconOffsetX, OffsetY = screen.ItemStartY + screen.IconOffsetY + ((visibleIndex - 1) * screen.EntryYSpacer) })
				table.insert( onIds, components[newButtonKey].Id )
			end

			if visibleIndex == 1 then
				SetInteractProperty({ DestinationId = components[questButtonKey].Id, Property = "FreeFormSelectOffsetY", Value = 20 })
			elseif visibleIndex == screen.ItemsPerPage then
				SetInteractProperty({ DestinationId = components[questButtonKey].Id, Property = "FreeFormSelectOffsetY", Value = -20 })
			else
				SetInteractProperty({ DestinationId = components[questButtonKey].Id, Property = "FreeFormSelectOffsetY", Value = 0 })
			end

		else
			-- Page out of view
			table.insert( offIds, components[questButtonKey].Id )
			table.insert( offIds, components[purchaseButtonTitleKey].Id )
			table.insert( offIds, components[iconKey].Id )
			if components[newButtonKey] ~= nil then
				table.insert( offIds, components[newButtonKey].Id )
			end
		end

	end

	SetAlpha({ Ids = onIds, Fraction = 1 })
	UseableOn({ Ids = onIds })

	SetAlpha({ Ids = offIds, Fraction = 0 })
	UseableOff({ Ids = offIds, ForceHighlightOff = true })

	if screen.ScrollOffset <= 0 then
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 0, Duration = 0.1 })
		UseableOff({ Id = components.ScrollUp.Id, ForceHighlightOff = true })
	else
		SetAlpha({ Id = components.ScrollUp.Id, Fraction = 1, Duration = 0.1 })
		UseableOn({ Id = components.ScrollUp.Id })
	end

	if screen.ScrollOffset + screen.ItemsPerPage >= screen.NumItems then
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 0, Duration = 0.1 })
		UseableOff({ Id = components.ScrollDown.Id, ForceHighlightOff = true })
	else
		SetAlpha({ Id = components.ScrollDown.Id, Fraction = 1, Duration = 0.1 })
		UseableOn({ Id = components.ScrollDown.Id })
	end

end

function MouseOverGhostAdminItem( button )
	local newButtonKey = "NewIcon"..button.Index
	SetAlpha({ Id = button.NewButtonId, Fraction = 0, Duration = 0.2 })
	GameState.CosmeticsViewed[button.Data.Name] = true
end

function CosmeticItemSort( itemA, itemB )
	local itemASortName = itemA.SortName or itemA.ResourceName
	local itemBSortName = itemB.SortName or itemB.ResourceName
	if itemASortName ~= itemBSortName then
		return GetKey( ScreenData.GhostAdmin.ResourceOrder, itemASortName ) < GetKey( ScreenData.GhostAdmin.ResourceOrder, itemBSortName )
	end
	if itemA.ResourceCost ~= itemB.ResourceCost then
		return itemA.ResourceCost < itemB.ResourceCost
	end
	return itemA.Name < itemB.Name
end