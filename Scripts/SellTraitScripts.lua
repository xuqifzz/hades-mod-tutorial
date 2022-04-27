function GenerateSellTraitShop( currentRun, currentRoom, args )
	GenerateSellTraitValues( currentRun, currentRoom, args )
	if currentRoom.SellOptions == nil then
		currentRoom.SellOptions = {}
		for i = 1, 3 do
			if IsEmpty(currentRoom.SellValues) then
				break
			end
			table.insert(currentRoom.SellOptions, RemoveRandomValue(currentRoom.SellValues))
		end
	end
end

function GenerateSellTraitValues( currentRun, currentRoom, args )
	args = args or {}
	currentRoom.SellValues = {}
	for index, traitData in pairs (CurrentRun.Hero.Traits) do
		if IsGodTrait( traitData.Name, { ForShop = true }) and traitData.Rarity and not Contains( args.ExclusionNames, traitData.Name ) then
			currentRoom.SellValues[traitData.Name] = { Name = traitData.Name, Value = GetTraitValue( traitData ) }
		end
	end
end

function OpenSellTraitMenu()

	OnScreenOpened({Flag = "SellTraitMenu", PersistCombatUI = true })
	FreezePlayerUnit("SellTraitMenuOpen", { DisableTray = false })
	SetPlayerInvulnerable("SellTraitMenuOpen")
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = true })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 10 })

	ScreenAnchors.SellTraitScreen = { Components = {} }
	local screen = ScreenAnchors.SellTraitScreen
	screen.Name = "SellTraitScript"
	local components = screen.Components

	EnableShopGamepadCursor( screen.Name )

	PlaySound({ Name = "/SFX/Menu Sounds/WellShopOpenNew" })

	components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })
	components.ShopBackground = CreateScreenComponent({ Name = "SellShopBackground", Group = "Combat_Menu" })
	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Group = "Combat_Menu", Scale = 0.7 })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = 0, OffsetY = 440 })
	components.CloseButton.OnPressedFunctionName = "CloseSellTraitScreen"
	components.CloseButton.ControlHotkey = "Cancel"
	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 4 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.157, 0.090, 0.055, 0.85} })

	-- Title
	CreateTextBox(MergeTables({ 
		Id = components.ShopBackground.Id, 
		Text = "SellTrait_Title",
		FontSize = 32,
		OffsetX = 0,
		OffsetY = -445,
		Color = Color.White,
		Font = "SpectralSCLightTitling",
		ShadowBlur = 0,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		Justification = "Center",
	},LocalizationData.SellTraitScripts.TitleText))

	CreateTextBox({ Id = components.ShopBackground.Id, Text = "SellTrait_Hint", FontSize = 14, OffsetX = 0, OffsetY = 390, Width = 840, Color = Color.Gray, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })

	-- Flavor Text
	local flavorTextOptions = { "SellTrait_FlavorText01", "SellTrait_FlavorText02", "SellTrait_FlavorText03", }
	local flavorText = GetRandomValue( flavorTextOptions )
	CreateTextBox({ Id = components.ShopBackground.Id, Text = flavorText,
			FontSize = 16,
			OffsetY = -385, Width = 840,
			Color = {0.698, 0.702, 0.514, 1.0},
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Center" })


	local outdatedData = false
	if CurrentRun.CurrentRoom.SellOptions == nil then
		outdatedData = true
	else
		for itemIndex, sellData in pairs(CurrentRun.CurrentRoom.SellOptions ) do
			if sellData.Name and not HeroHasTrait(sellData.Name) then
				outdatedData = true
			end
		end
	end
	if outdatedData then
		CurrentRun.CurrentRoom.SellOptions = nil
		GenerateSellTraitShop( CurrentRun, CurrentRun.CurrentRoom )
	end

	CreateSellButtons()

	if TableLength( CurrentRun.CurrentRoom.SellOptions ) > 0 then
		thread( PlayVoiceLines, HeroVoiceLines.SellTraitShopUsedVoiceLines, true )
	else
		thread( PlayVoiceLines, HeroVoiceLines.SellTraitShopSoldOutVoiceLines, true )
	end

	-- Short delay to let animations finish and prevent accidental input
	wait(0.5)

	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )

end

function CreateSellButtons()

	local itemLocationY = 370
	local itemLocationX = ScreenCenterX - 355
	local firstOption = true
	local buttonOffsetX = 350
	local components = ScreenAnchors.SellTraitScreen.Components
	local sellList = {}
	local upgradeOptionsTable = {}
	for itemIndex, sellData in pairs( CurrentRun.CurrentRoom.SellOptions ) do
		for index, traitData in pairs (CurrentRun.Hero.Traits) do
			if sellData.Name == traitData.Name and traitData.Rarity and ( upgradeOptionsTable[traitData.Name] == nil or GetRarityValue(upgradeOptionsTable[traitData.Name].Rarity) > GetRarityValue(traitData.Rarity) ) then
				upgradeOptionsTable[traitData.Name] = { Data = traitData, Value = sellData.Value }
			end
		end
	end

	for i, value in pairs(upgradeOptionsTable) do
		table.insert( sellList, value )
	end

	for itemIndex, sellData in pairs( sellList ) do
		local itemData = sellData.Data
		if itemData ~= nil then
			local itemBackingKey = "Backing"..itemIndex
			components[itemBackingKey] = CreateScreenComponent({ Name = "TraitBacking", Group = "Combat_Menu", X = ScreenCenterX, Y = itemLocationY })
			SetScaleY({ Id = components[itemBackingKey].Id, Fraction = 1.25 })
			local upgradeData = nil
			local upgradeTitle = nil
			local upgradeDescription = nil
			local upgradeData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.Name, Rarity = itemData.Rarity })
			local tooltipData = upgradeData
			SetTraitTextData( tooltipData, { OldOnly = true })
			upgradeTitle = GetTraitTooltipTitle( upgradeData )
			upgradeDescription = GetTraitTooltip( upgradeData, { ForTraitTray = true, Initial = true })
			-- Setting button graphic based on boon type
			local purchaseButtonKey = "PurchaseButton"..itemIndex

			local iconOffsetX = -338
			local iconOffsetY = -2
			local exchangeIconPrefix = nil
			local overlayLayer = "Combat_Menu_Overlay"

			components[purchaseButtonKey] = CreateScreenComponent({ Name = "SellSlot"..itemIndex, Group = "Combat_Menu", Scale = 1, X = itemLocationX + buttonOffsetX, Y = itemLocationY })
			if upgradeData.CustomRarityColor then
				components[purchaseButtonKey.."Patch"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = iconOffsetX + itemLocationX + buttonOffsetX + 35, Y = iconOffsetY + itemLocationY })
				SetAnimation({ DestinationId = components[purchaseButtonKey.."Patch"].Id, Name = "BoonRarityPatch"})
				SetColor({ Id = components[purchaseButtonKey.."Patch"].Id, Color = upgradeData.CustomRarityColor })
			elseif itemData.Rarity ~= "Common" and itemData.Rarity then
				components[purchaseButtonKey.."Patch"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = iconOffsetX + itemLocationX + buttonOffsetX + 35, Y = iconOffsetY + itemLocationY })
				SetAnimation({ DestinationId = components[purchaseButtonKey.."Patch"].Id, Name = "BoonRarityPatch"})
				SetColor({ Id = components[purchaseButtonKey.."Patch"].Id, Color = Color["BoonPatch" .. itemData.Rarity] })
			end

			if upgradeData.Icon ~= nil then
				components[purchaseButtonKey.."Icon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = iconOffsetX + itemLocationX + buttonOffsetX, Y = iconOffsetY + itemLocationY })
				SetAnimation({ DestinationId = components[purchaseButtonKey.."Icon"].Id, Name = upgradeData.Icon .. "_Large" })
				SetScale({ DestinationId = components[purchaseButtonKey.."Icon"].Id, Fraction = 0.85 })
			end
			components[purchaseButtonKey.."IconOverlay"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", X = iconOffsetX + itemLocationX + buttonOffsetX, Y = iconOffsetY + itemLocationY })
			SetAnimation({ DestinationId = components[purchaseButtonKey.."IconOverlay"].Id, Name = "Frame_Sell_Overlay" })
			SetAlpha({ Id = components[purchaseButtonKey.."IconOverlay"].Id, Fraction = 0, Duration = 0 })
			SetScale({ Id = components[purchaseButtonKey.."IconOverlay"].Id, Fraction = 0.85 })

			components[purchaseButtonKey.."Frame"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = iconOffsetX + itemLocationX + buttonOffsetX, Y = iconOffsetY + itemLocationY })
			SetAnimation({ DestinationId = components[purchaseButtonKey.."Frame"].Id, Name = "Frame_Sell"})
			SetScale({ Id = components[purchaseButtonKey.."Frame"].Id, Fraction = 0.85 })

			-- Button data setup
			components[purchaseButtonKey].OnPressedFunctionName = "HandleSellChoiceSelection"
			components[purchaseButtonKey].UpgradeName = upgradeData.Name
			components[purchaseButtonKey].Index = itemIndex
			components[purchaseButtonKey].Rarity = upgradeData.Rarity
			components[purchaseButtonKey].IsDuoBoon = upgradeData.IsDuoBoon
			if HasHeroTraitValue( "BlockMoney" ) then
				components[purchaseButtonKey].Value = 0
			else
				components[purchaseButtonKey].Value = sellData.Value
			end
			components[components[purchaseButtonKey].Id] = purchaseButtonKey
			-- Creates upgrade slot text
			SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = 665 })
			local selectionString = "UpgradeChoiceMenu_PermanentItem"
			local selectionStringColor = Color.Black

			local traitData = TraitData[itemData.Name]
			if traitData.Slot ~= nil then
				selectionString = "UpgradeChoiceMenu_"..traitData.Slot
			end

			local textOffset = 115 - buttonOffsetX
			local exchangeIconOffset = 0
			local lineSpacing = 8
			local traitNameOffset = LocalizationData.SellTraitScripts.UpgradeTitle.TraitNameOffsetX[GetLanguage({})] or 75
			local text = "Boon_Common"
			local overlayLayer = ""
			local color = Color.White
			if itemData.Rarity then
				text = "Boon_"..tostring(itemData.Rarity)
				color = Color["BoonPatch" .. itemData.Rarity ]
				if upgradeData.CustomRarityColor then
					color = upgradeData.CustomRarityColor
				end
			end
			if upgradeData.CustomRarityName then
				text = upgradeData.CustomRarityName
			end
			CreateTextBox(MergeTables(LocalizationData.SellTraitScripts.ShopButton,{
				Id = components[purchaseButtonKey].Id, Text = text,
				FontSize = 25,
				OffsetX = textOffset + 630, OffsetY = -60,
				Width = 720,
				Color = color,
				Font = "AlegreyaSansSCLight",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Right",
			}))

			CreateTextBox(MergeTables(LocalizationData.SellTraitScripts.ShopButton,{
				Id = components[purchaseButtonKey].Id,
				Text = "SellTraitPrefix",
				FontSize = 20,
				OffsetX = textOffset + exchangeIconOffset, OffsetY = -65,
				Color = Color.CostUnaffordableLight,
				Font = "AlegreyaSansSCRegular",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
			}))

			CreateTextBox(MergeTables(LocalizationData.SellTraitScripts.ShopButton,{
				Id = components[purchaseButtonKey].Id,
				Text = upgradeTitle,
				FontSize = 25,
				OffsetX = textOffset + exchangeIconOffset + traitNameOffset, OffsetY = -65,
				Color = color,
				Font = "AlegreyaSansSCLight",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
				LuaKey = "TooltipData", LuaValue = tooltipData,
			}))

			CreateTextBox(MergeTables(LocalizationData.SellTraitScripts.ShopButton,{
				Id = components[purchaseButtonKey].Id, Text = "Sell_ItemCost", TextSymbolScale = 0.6, LuaKey = "TempTextData", LuaValue = { Amount = components[purchaseButtonKey].Value }, FontSize = 24,
				OffsetY = GetLocalizedValue(60, { { Code = "ja", Value = 75}, }),
				OffsetX = 430,
				Color = Color.Gold,
				Justification = "RIGHT",
				Font="AlegreyaSansSCBold",
				FontSize=26,
				LangJaScaleModifier = 0.85,
				ShadowColor = {0,0,0,1},
				ShadowOffsetY=2,
				ShadowOffsetX=0,
				ShadowAlpha=1,
				ShadowBlur=0,
				OutlineColor={0,0,0,1},
				OutlineThickness=2,
			}))

			CreateTextBoxWithFormat(MergeTables(LocalizationData.SellTraitScripts.ShopButton,{
				Id = components[purchaseButtonKey].Id,
				Text = upgradeDescription,
				OffsetX = textOffset, OffsetY = -40,
				Width = GetLocalizedValue(675, { { Code = "ja", Value = 670 }, }),
				Justification = "Left",
				VerticalJustification = "Top",
				LineSpacingBottom = lineSpacing,
				UseDescription = true,
				LuaKey = "TooltipData", LuaValue = tooltipData,
				Format = "BaseFormat",
				VariableAutoFormat = "BoldFormatGraft",
				TextSymbolScale = 0.8,
			}))

			if firstOption then
				TeleportCursor({ OffsetX = itemLocationX + buttonOffsetX, OffsetY = itemLocationY, ForceUseCheck = true, })
				firstOption = false
			end
		end
		itemLocationY = itemLocationY + 220
	end


	if IsMetaUpgradeSelected("RerollPanelMetaUpgrade") then
		local increment = 0
		if CurrentRun.CurrentRoom.SpentRerolls then
			increment = CurrentRun.CurrentRoom.SpentRerolls[ScreenAnchors.SellTraitScreen.Name] or 0
		end
		local cost = RerollCosts.SellTrait + increment
		if IsEmpty( CurrentRun.CurrentRoom.SellValues ) then
			cost = -1
		end
		local color = Color.White
		if CurrentRun.NumRerolls < cost then
			color = Color.CostUnaffordable
		end

		local name = "RerollPanelMetaUpgrade_ShortTotal"
		local tooltip = "MetaUpgradeRerollHint"
		if cost < 0 then
			name = "RerollPanel_Blocked"
			tooltip = "MetaUpgradeRerollBlockedHint"
		end

		components["RerollPanel"] = CreateScreenComponent({ Name = "ShopRerollButton", Scale = 1.0, Group = "Combat_Menu" })
		Attach({ Id = components["RerollPanel"].Id, DestinationId = components.ShopBackground.Id, OffsetX = -200, OffsetY = 440 })
		components["RerollPanel"].OnPressedFunctionName = "AttemptPanelReroll"
		components["RerollPanel"].RerollFunctionName = "RerollSellTraitScreen"
		components["RerollPanel"].Cost = cost
		components["RerollPanel"].RerollColor = Color.DarkRed
		components["RerollPanel"].RerollId = ScreenAnchors.SellTraitScreen.Name
		CreateTextBox({ Id = components["RerollPanel"].Id, Text = name, OffsetX = 28, OffsetY = -5,
		ShadowColor = {0,0,0,1}, ShadowOffset={0,3}, OutlineThickness = 3, OutlineColor = {0,0,0,1},
		FontSize = 28, Color = color, Font = "AlegreyaSansSCExtraBold", LuaKey = "TempTextData", LuaValue = { Amount = cost }})
		SetInteractProperty({ DestinationId = components["RerollPanel"].Id, Property = "TooltipOffsetX", Value = 850 })
		CreateTextBox({ Id = components["RerollPanel"].Id, Text = tooltip, FontSize = 1, Color = Color.Transparent, Font = "AlegreyaSansSCExtraBold", LuaKey = "TempTextData", LuaValue = { Amount = cost }})
	end
end

function HandleSellChoiceSelection( screen, button )
	RemoveWeaponTrait( button.UpgradeName )
	AddMoney( button.Value, "Trait Sell" )

	for index, sellData in pairs( CurrentRun.CurrentRoom.SellOptions ) do
		if sellData.Name == button.UpgradeName then
			CurrentRun.CurrentRoom.SellOptions[index] = nil
		end
	end
	CurrentRun.CurrentRoom.SoldTrait = true
	CurrentRun.Hero.TraitsSold = (CurrentRun.Hero.TraitsSold or 0) + 1
	local purchaseButtonKey = screen.Components[button.Id]
	Destroy({ Ids = { screen.Components[purchaseButtonKey].Id }})
	local clearIds = {}
	if( screen.Components[purchaseButtonKey.."Icon"] ) then
		table.insert(clearIds, screen.Components[purchaseButtonKey.."Icon"].Id )
	end
	if( screen.Components[purchaseButtonKey.."Frame"] ) then
		table.insert(clearIds, screen.Components[purchaseButtonKey.."Frame"].Id )
	end
	if( screen.Components[purchaseButtonKey.."Patch"] ) then
		table.insert(clearIds, screen.Components[purchaseButtonKey.."Patch"].Id )
	end
	if( screen.Components[purchaseButtonKey.."IconOverlay"] ) then
		table.insert(clearIds, screen.Components[purchaseButtonKey.."IconOverlay"].Id )
	end

	if not IsEmpty( clearIds ) then
		Destroy({ Ids = clearIds })
	end
	CreateAnimation({ Name = "BoonSlotPurchase", DestinationId = screen.Components["Backing".. button.Index].Id, OffsetX = 0 })
	PlaySound({ Name = "/SFX/Menu Sounds/SellTraitShopConfirm" })
	thread( PlayVoiceLines, HeroVoiceLines.SoldTraitVoiceLines, true )
	if button.Rarity == "Legendary" and not button.IsDuoBoon then
		CheckAchievement({ Name = "AchPurgedLegendBoon" })
	end
end

function CloseSellTraitScreen( screen, button )
	DisableShopGamepadCursor( screen.Name )
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16 })
	PlaySound({ Name = "/SFX/Menu Sounds/WellShopCloseNew" })
	SetAnimation({ Name = "SellShopOut", DestinationId = screen.Components.ShopBackground.Id })
	
	local useableOffButtonIds = {}
	for index = 1, 3 do
		if screen.Components["PurchaseButton"..index] and screen.Components["PurchaseButton"..index].Id then
			table.insert(useableOffButtonIds, screen.Components["PurchaseButton"..index].Id)
		end
	end
	UseableOff({ Ids = useableOffButtonIds, ForceHighlightOff = true })

	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	UnfreezePlayerUnit("SellTraitMenuOpen")
	SetPlayerVulnerable("SellTraitMenuOpen")
	screen.KeepOpen = false
	OnScreenClosed({Flag = "SellTraitMenu"})

	ScreenAnchors.SellTraitScreen = nil
end


function RerollSellTraitScreen()
	DestroySellButtons()
	local exclusions = {}
	if not IsEmpty(CurrentRun.CurrentRoom.SellOptions ) and not IsEmpty( CurrentRun.CurrentRoom.SellValues ) then
		exclusions = { GetRandomValue( CurrentRun.CurrentRoom.SellOptions).Name }
	end
	CurrentRun.CurrentRoom.SellOptions = nil
	GenerateSellTraitShop( CurrentRun, CurrentRun.CurrentRoom, { ExclusionNames = exclusions } )
	CreateSellButtons()
end

function DestroySellButtons()
	local components = ScreenAnchors.SellTraitScreen.Components
	local toDestroy = {}
	for index = 1, 3 do
		local destroyIndexes = {
		"ItemBackingSoldOut"..index,
		"PurchaseButton"..index,
		"PurchaseButton"..index.. "Icon",
		"PurchaseButton"..index.. "IconOverlay",
		"Backing"..index,
		"PurchaseButtonTitle"..index,
		"PurchaseButton"..index.. "Frame",
		"PurchaseButton"..index.. "Patch"}
		for i, indexName in pairs( destroyIndexes ) do
			if components[indexName] then
				table.insert(toDestroy, components[indexName].Id)
			end
		end
	end

	if components["RerollPanel"] then
		table.insert(toDestroy, components["RerollPanel"].Id)
	end
	Destroy({ Ids = toDestroy })
end

function GetBaseRarityValue( traitData )
	if traitData.Rarity and SellTraitData.RarityValues[traitData.Rarity] then
		return math.floor( RandomInt( SellTraitData.RarityValues[traitData.Rarity].Min, SellTraitData.RarityValues[traitData.Rarity].Max ) / SellTraitData.RoundToNearestValue ) * SellTraitData.RoundToNearestValue
	end
	return SellTraitData.BaseValue
end

function GetTraitValue( traitData )
	local baseValue = GetBaseRarityValue( traitData )
	local stackValue = (GetTraitCount(CurrentRun.Hero, traitData) - 1) * math.floor( RandomInt( SellTraitData.StackValue.Min, SellTraitData.StackValue.Max ) / SellTraitData.RoundToNearestValue ) * SellTraitData.RoundToNearestValue
	return round(( baseValue + stackValue ))
end

OnMouseOver{ "SellSlot1 SellSlot2 SellSlot3",
	function( triggerArgs )
		if triggerArgs.triggeredById == nil or not IsScreenOpen("SellTraitMenu") or ScreenAnchors.SellTraitScreen == nil or ScreenAnchors.SellTraitScreen.Components[ triggerArgs.triggeredById ] == nil then
			return
		end
		local key = ScreenAnchors.SellTraitScreen.Components[ triggerArgs.triggeredById ]
		SetAlpha({ Id = ScreenAnchors.SellTraitScreen.Components[key.."IconOverlay"].Id, Fraction = 1.0, Duration = 0.1 })
	end
}

OnMouseOff{ "SellSlot1 SellSlot2 SellSlot3",
	function( triggerArgs )
		if IsScreenOpen("SellTraitMenu") then
			local key = ScreenAnchors.SellTraitScreen.Components[ triggerArgs.triggeredById ]
		SetAlpha({ Id = ScreenAnchors.SellTraitScreen.Components[key.."IconOverlay"].Id, Fraction = 0, Duration = 0.1 })
		end
	end
}