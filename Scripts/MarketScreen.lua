function UseMarketObject( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	GenerateMarketItems()
	if CurrentRun.MarketOptions == nil then
		CurrentRun.MarketOptions = TableLength( CurrentRun.MarketItems )
	end
	local screen = OpenMarketScreen()
	UseableOn({ Id = usee.ObjectId })
	MarketSessionCompletePresentation( usee, screen )
end

function GenerateMarketItems()
	if CurrentRun.MarketItems ~= nil then
		return CurrentRun.MarketItems
	end
	RandomSynchronize()
	CurrentRun.MarketItems = {}
	CurrentRun.MarketOptions = BrokerScreenData.MaxOptions
	local numRemainingTempOptions = BrokerScreenData.MaxNonPriorityOffers
	local buyOptions = ShallowCopyTable( BrokerData )
	local priorityOptions = {}
	for i, option in ipairs( buyOptions ) do
		if option.Priority then
			table.insert( priorityOptions, option )
		end
	end
	for i, option in pairs( priorityOptions ) do
		RemoveValue( buyOptions, option )
	end
	while #CurrentRun.MarketItems < CurrentRun.MarketOptions and not ( IsEmpty( buyOptions ) and IsEmpty( priorityOptions )) and not ( IsEmpty( priorityOptions ) and numRemainingTempOptions <= 0 ) do
		local buyData = nil
		if not IsEmpty ( priorityOptions ) then
			buyData = RemoveFirstValue( priorityOptions )
		elseif numRemainingTempOptions > 0 then
			buyData = RemoveRandomValue( buyOptions )

			if buyData and buyData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, buyData, buyData.GameStateRequirements ) then
				numRemainingTempOptions = numRemainingTempOptions - 1
			end
		end

		buyData.BuyTitle = ResourceData[buyData.BuyName].TitleName
		buyData.BuyTitleSingular = ResourceData[buyData.BuyName].TitleName_Singular or ResourceData[buyData.BuyName].TitleName
		buyData.BuyIcon = "{!Icons."..ResourceData[buyData.BuyName].IconString.."}"
		buyData.CostIcon = "{!Icons."..ResourceData[buyData.CostName].SmallIconString.."}"
		if buyData and buyData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, buyData, buyData.GameStateRequirements ) then
			table.insert( CurrentRun.MarketItems, DeepCopyTable( buyData ))
		end
	end

	return marketItems
end

function OpenMarketScreen()

	local screen = { Components = {} }
	screen.Name = "Market"
	screen.NumSales = 0
	screen.NumItemsOffered = 0

	if IsScreenOpen( screen.Name ) then
		return
	end
	OnScreenOpened({ Flag = screen.Name, PersistCombatUI = true })
	FreezePlayerUnit()
	EnableShopGamepadCursor()

	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelIn" })

	local components = screen.Components

	components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })
	components.ShopBackground = CreateScreenComponent({ Name = "ShopBackground", Group = "Combat_Menu" })
	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Group = "Combat_Menu", Scale = 0.7 })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = 0, OffsetY = 440 })
	components.CloseButton.OnPressedFunctionName = "CloseMarketScreen"
	components.CloseButton.ControlHotkey = "Cancel"
	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 4 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.090, 0.055, 0.157, 0.7} })

	-- Title
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "MarketScreen_Title", FontSize = 32, OffsetX = 0, OffsetY = -445, Color = Color.White, Font = "SpectralSCLightTitling", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3}, Justification = "Center" })
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "MarketScreen_Hint", FontSize = 14, OffsetX = 0, OffsetY = 380, Width = 865, Color = Color.Gray, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })

	-- Flavor Text
	local flavorTextOptions = { "MarketScreen_FlavorText01", "MarketScreen_FlavorText02", "MarketScreen_FlavorText03", }
	local flavorText = GetRandomValue( flavorTextOptions )
	CreateTextBox(MergeTables({ Id = components.ShopBackground.Id, Text = flavorText,
			FontSize = 16,
			OffsetY = -385, Width = 990,
			Color = {0.698, 0.702, 0.514, 1.0},
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Center" }, LocalizationData.MarketScreen.FlavorText))

	-- image

	local tooltipData = {}
	local yScale = math.min( 3 / CurrentRun.MarketOptions , 1 )

	local itemLocationStartY = ShopUI.ShopItemStartY - ( ShopUI.ShopItemSpacerY * (1 - yScale) * 0.5)
	local itemLocationYSpacer = ShopUI.ShopItemSpacerY * yScale
	local itemLocationMaxY = itemLocationStartY + 4 * itemLocationYSpacer

	local itemLocationStartX = ShopUI.ShopItemStartX
	local itemLocationXSpacer = ShopUI.ShopItemSpacerX
	local itemLocationMaxX = itemLocationStartX + 1 * itemLocationXSpacer

	local itemLocationTextBoxOffset = 380

	local itemLocationX = itemLocationStartX
	local itemLocationY = itemLocationStartY

	local textSymbolScale = 0.8

	local firstUseable = false
	for itemIndex, item in ipairs( CurrentRun.MarketItems ) do

		if not item.SoldOut then

			screen.NumItemsOffered = screen.NumItemsOffered + 1

			--local itemBackingSoldOutKey = "ItemBackingSoldOut"..itemIndex
			--components[itemBackingSoldOutKey] = CreateScreenComponent({ Name = "MarketSlotInactive", Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })
			--SetScaleY({ Id = components[itemBackingSoldOutKey].Id , Fraction = yScale })
			local purchaseButtonKey = "PurchaseButton"..itemIndex
			components[purchaseButtonKey] = CreateScreenComponent({ Name = "MarketSlot", Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })
			SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = 665 })

			local iconKey = "Icon"..itemIndex
			components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX - 360, Y = itemLocationY, Group = "Combat_Menu" })
			if not item.Priority then
				--SetAnimation({ Name = "MarketLimitedOffer", DestinationId = components[iconKey].Id })
				--SetScale({ Id = components[iconKey].Id, Fraction = yScale * 1.25 })
			end

			local itemBackingKey = "Backing"..itemIndex
			components[itemBackingKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = itemLocationX + itemLocationTextBoxOffset, Y = itemLocationY })

			local purchaseButtonTitleKey = "PurchaseButtonTitle"..itemIndex
			components[purchaseButtonTitleKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })



			local costColor = {0.878, 0.737, 0.259, 1.0}
			if not HasResource( item.CostName, item.CostAmount ) then
				costColor = Color.TradeUnaffordable
			end

			components[purchaseButtonKey].OnPressedFunctionName = "HandleMarketPurchase"
			if not firstUseable then
				TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY })
				firstUseable = true
			end

			-- left side text
			local buyResourceData = ResourceData[item.BuyName]
			if buyResourceData then
				components[purchaseButtonTitleKey .. "Icon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Scale = 1 })
				SetAnimation({ Name = buyResourceData.Icon, DestinationId = components[purchaseButtonTitleKey .. "Icon"].Id, Scale = 1 })
				Attach({ Id = components[purchaseButtonTitleKey .. "Icon"].Id, DestinationId = components[purchaseButtonTitleKey].Id, OffsetX = -400, OffsetY = 0 })
				components[purchaseButtonTitleKey .. "SellText"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Scale = 1 })
				Attach({ Id = components[purchaseButtonTitleKey .. "SellText"].Id, DestinationId = components[purchaseButtonTitleKey].Id, OffsetX = 0, OffsetY = 0 })

				local titleText = "MarketScreen_Entry_Title"
				if item.BuyAmount == 1 then
					titleText = "MarketScreen_Entry_Title_Singular"
				end
				CreateTextBox({ Id = components[purchaseButtonKey].Id, Text = titleText,
					FontSize = 48 * yScale ,
					OffsetX = -350, OffsetY = -35,
					Width = 720,
					Color = {0.878, 0.737, 0.259, 1.0},
					Font = "AlegreyaSansSCMedium",
					ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
					Justification = "Left",
					VerticalJustification = "Top",
					LuaKey = "TempTextData",
					LuaValue = item,
					LineSpacingBottom = 20,
					TextSymbolScale = textSymbolScale,
				})
				CreateTextBox({ Id = components[purchaseButtonTitleKey.."SellText"].Id, Text = "MarketScreen_Cost",
					FontSize = 48 * yScale ,
					OffsetX = 420, OffsetY = -24,
					Width = 720,
					Color = costColor,
					Font = "AlegreyaSansSCMedium",
					ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
					Justification = "Right",
					LuaKey = "TempTextData",
					LuaValue = item,
					LineSpacingBottom = 20,
					TextSymbolScale = textSymbolScale,
				})
				ModifyTextBox({ Ids = components[purchaseButtonTitleKey.."SellText"].Id, BlockTooltip = true })

				CreateTextBoxWithFormat({ Id = components[purchaseButtonKey].Id, Text = buyResourceData.IconString or item.BuyName,
					FontSize = 16 * yScale,
					OffsetX = -350, OffsetY = 0,
					Width = 650,
					Color = Color.White,
					Justification = "Left",
					VerticalJustification = "Top",
					LuaKey = "TempTextData",
					LuaValue = item,
					TextSymbolScale = textSymbolScale,
					Format = "MarketScreenDescriptionFormat",
					VariableAutoFormat = "BoldFormatGraft",
					UseDescription = true
				})
				if not item.Priority then
					CreateTextBox({ Id = components[purchaseButtonKey].Id, Text = "Market_LimitedTimeOffer", OffsetX = 300, OffsetY = 0, FontSize = 28, Color = costColor, Font = "AlegreyaSansSCRegular", Justification = "Left", TextSymbolScale = textSymbolScale })
				end
			end

			components[purchaseButtonKey].Data = item
			components[purchaseButtonKey].Index = itemIndex
			components[purchaseButtonKey].TitleId = components[purchaseButtonTitleKey].Id
		end

		itemLocationX = itemLocationX + itemLocationXSpacer
		if itemLocationX >= itemLocationMaxX then
			itemLocationX = itemLocationStartX
			itemLocationY = itemLocationY + itemLocationYSpacer
		end
	end

	if screen.NumItemsOffered == 0 then
		thread( PlayVoiceLines, GlobalVoiceLines.MarketSoldOutVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.OpenedMarketVoiceLines, true )
	end

	HandleScreenInput( screen )
	return screen

end

function CloseMarketScreen( screen, button )
	DisableShopGamepadCursor()
	CloseScreen( GetAllIds( screen.Components ) )
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	UnfreezePlayerUnit()
	screen.KeepOpen = false
	OnScreenClosed({ Flag = screen.Name })
end

function HandleMarketPurchase( screen, button )
	local item = button.Data

	if not HasResource( item.CostName, item.CostAmount ) then
		Flash({ Id = screen.Components["PurchaseButton".. button.Index].Id, Speed = 3, MinFraction = 0.6, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
		MarketPurchaseFailPresentation( item )
		return
	end

	screen.NumSales = screen.NumSales + 1
	GameState.MarketSales = (GameState.MarketSales or 0) + 1

	MarketPurchaseSuccessPresentation( item )
	if item.Priority then
		MarketPurchaseSuccessRepeatablePresentation( button )
	else
		item.SoldOut = true
		Destroy({ Ids = { screen.Components["PurchaseButtonTitle".. button.Index].Id , screen.Components["PurchaseButtonTitle".. button.Index .. "SellText"].Id, screen.Components["PurchaseButtonTitle".. button.Index .. "Icon"].Id, screen.Components["Backing".. button.Index].Id, screen.Components["Icon".. button.Index].Id }})
		screen.Components["PurchaseButtonTitle".. button.Index .. "Icon"] = nil
		screen.Components["PurchaseButtonTitle".. button.Index .. "SellText"] = nil
		screen.Components["PurchaseButtonTitle".. button.Index] = nil
		screen.Components["Backing".. button.Index] = nil
		screen.Components["Icon".. button.Index] = nil

		-- SetScale({ Id = screen.Components["PurchaseButton".. button.Index].Id, Fraction = 0.5, Duration = 0.2 })
		SetAlpha({ Id = screen.Components["PurchaseButton".. button.Index].Id, Fraction = 0, Duration = 0.2 })
		wait(0.2)
		Destroy({ Id = screen.Components["PurchaseButton".. button.Index].Id })
		screen.Components["PurchaseButton".. button.Index] = nil
	end
	local resourceArgs = { SkipOverheadText = true, ApplyMultiplier = false, }

	SpendResource( item.CostName, item.CostAmount, "Market", resourceArgs  )

	wait(0.3)

	AddResource( item.BuyName, item.BuyAmount, "Market", resourceArgs  )

	-- Check updated affordability
	for itemIndex, item in ipairs( CurrentRun.MarketItems ) do
		if not item.SoldOut then
			local costColor = Color.TradeAffordable
			if not HasResource( item.CostName, item.CostAmount ) then
				costColor = Color.TradeUnaffordable
			end
			local purchaseButtonKey = "PurchaseButton"..itemIndex
			ModifyTextBox({ Id = screen.Components["PurchaseButtonTitle"..itemIndex.."SellText"].Id, ColorTarget = costColor, ColorDuration = 0.1 })
		end
	end

	if CoinFlip() then
		thread( PlayVoiceLines, ResourceData[item.CostName].BrokerSpentVoiceLines, true )
	else
		thread( PlayVoiceLines, ResourceData[item.BuyName].BrokerPurchaseVoiceLines, true )
	end
end