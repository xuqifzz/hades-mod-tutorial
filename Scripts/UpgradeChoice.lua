
function OpenUpgradeChoiceMenu( lootData )

	local upgradeName = lootData.Name
	local upgradeChoiceData = LootData[upgradeName]
	-- Not allowed to quit after seeing otherwise hidden choices
	InvalidateCheckpoint()

	OnScreenOpened({Flag = "BoonMenu", PersistCombatUI = true })
	FreezePlayerUnit("BoonMenuOpen", { DisableTray = false })
	SetPlayerInvulnerable("BoonMenuOpen")
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = true })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })

	ScreenAnchors.ChoiceScreen = { Components = {} }
	local screen = ScreenAnchors.ChoiceScreen
	screen.Name = "UpgradeChoice_"..upgradeName
	local components = screen.Components

	EnableShopGamepadCursor( screen.Name )

	screen.SubjectName = upgradeName
	components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })
	components.ShopBackgroundSplatter = CreateScreenComponent({ Name = "BoonBackground", Group = "Combat_Menu" })
	components.ShopBackground = CreateScreenComponent({ Name = "BoonBox", Group = "Combat_Menu" })


	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 4 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.15, 0.15, 0.15, 0.7} })

	wait(0.25)

	components.ShopFrontFx = CreateScreenComponent({ Name = "BoonSelectInFrontFx", Group = "Combat_Menu" })

	components.ShopBoonIcon = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu", X = 182, Y = 160 })
	SetAnimation({ DestinationId = components.ShopBoonIcon.Id, Name = upgradeChoiceData.Icon, Scale = 1.0 })

	-- components.ShopFrontHand = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })
	-- SetAnimation({ DestinationId = components.ShopFrontHand.Id, Name = "BoonSelectFrontHand" })

	components.ShopLighting = CreateScreenComponent({ Name = "BoonSelectLighting", Group = "Combat_Menu_Additive" })
	SetColor({ Id = components.ShopLighting.Id, Color = upgradeChoiceData.LightingColor })

	-- Title
	CreateTextBox({ Id = components.ShopBackground.Id, Text = upgradeChoiceData.MenuTitle or "UpgradeChoiceMenu_Title_"..upgradeName,
		FontSize = 32,
		OffsetX = 0, OffsetY = -465,
		Color = Color.White,
		Font = "SpectralSCLightTitling",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
		OutlineThickness = 3,
		Justification = "Center"
	})
	if CurrentRun.LootTypeHistory then
		RandomSynchronize( CurrentRun.LootTypeHistory[upgradeName] )
	else
		RandomSynchronize()
	end
	-- Flavor Text
	if upgradeChoiceData.FlavorTextIds ~= nil then
		local flavorText = GetRandomValue( upgradeChoiceData.FlavorTextIds )
		CreateTextBox(MergeTables({ Id = components.ShopBackground.Id, Text = flavorText,
				FontSize = 16,
				OffsetY = -410, Width = 1040,
				Color = {0.698, 0.702, 0.514, 1.0},
				Font = "AlegreyaSansSCRegular",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Center" }, LocalizationData.UpgradeChoice.FlavorText))
	end

	CreateBoonLootButtons( lootData )

	-- Short delay to let animations finish and prevent accidental input
	wait(0.5)

	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )

end

function CreateBoonLootButtons( lootData, reroll)

	local components = ScreenAnchors.ChoiceScreen.Components
	local upgradeName = lootData.Name
	local upgradeChoiceData = LootData[upgradeName]
	local upgradeOptions = lootData.UpgradeOptions
	if upgradeOptions == nil then
		SetTraitsOnLoot( lootData )
		upgradeOptions = lootData.UpgradeOptions
	end

	if not lootData.StackNum then
		lootData.StackNum = 1
	end
	if not reroll then
		lootData.StackNum = lootData.StackNum + GetTotalHeroTraitValue("PomLevelBonus")
	end
	local tooltipData = {}

	local itemLocationY = 370
	local itemLocationX = ScreenCenterX - 355
	local firstOption = true
	local buttonOffsetX = 350

	if IsEmpty( upgradeOptions ) then
		table.insert(upgradeOptions, { ItemName = "FallbackMoneyDrop", Type = "Consumable", Rarity = "Common" })
	end

	local blockedIndexes = {}
	for i = 1, TableLength(upgradeOptions) do
		table.insert( blockedIndexes, i )
	end
	for i = 1, CalcNumLootChoices() do
		RemoveRandomValue( blockedIndexes )
	end

	-- Sort traits in the following order: Melee, Secondary, Rush, Range
	table.sort(upgradeOptions, function (x, y)
		local slotToInt = function( slot )
			if slot ~= nil then
				local slotType = slot.Slot

				if slotType == "Melee" then
					return 0
				elseif slotType == "Secondary" then
					return 1
				elseif slotType == "Ranged" then
					return 2
				elseif slotType == "Rush" then
					return 3
				elseif slotType == "Shout" then
					return 4
				end
			end
			return 99
		end
		return slotToInt(TraitData[x.ItemName]) < slotToInt(TraitData[y.ItemName])
	end)

	if TableLength( upgradeOptions ) > 1 then
		-- Only create the "Choose One" textbox if there's something to choose
		CreateTextBox({ Id = components.ShopBackground.Id, Text = "UpgradeChoiceMenu_SubTitle",
			FontSize = 30,
			OffsetX = -435, OffsetY = -318,
			Color = Color.White,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Left"
		})
	end
	for itemIndex, itemData in ipairs( upgradeOptions ) do
		local itemBackingKey = "Backing"..itemIndex
		components[itemBackingKey] = CreateScreenComponent({ Name = "TraitBacking", Group = "Combat_Menu", X = ScreenCenterX, Y = itemLocationY })
		SetScaleY({ Id = components[itemBackingKey].Id, Fraction = 1.25 })
		local upgradeData = nil
		local upgradeTitle = nil
		local upgradeDescription = nil
		if itemData.Type == "Trait" then
			upgradeData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.ItemName, Rarity = itemData.Rarity })
			local traitNum = GetTraitCount(CurrentRun.Hero, upgradeData)
			if HeroHasTrait(itemData.ItemName) then
				upgradeTitle = "TraitLevel_Upgrade"
				upgradeData.Title = upgradeData.Name
			else
				upgradeTitle = GetTraitTooltipTitle( TraitData[itemData.ItemName] )

				upgradeData.Title = GetTraitTooltipTitle( TraitData[itemData.ItemName] ) .."_Initial"
				if not HasDisplayName({ Text = upgradeData.Title }) then
					upgradeData.Title = GetTraitTooltipTitle( TraitData[itemData.ItemName] )
				end
			end

			if itemData.TraitToReplace ~= nil then
				upgradeData.TraitToReplace = itemData.TraitToReplace
				upgradeData.OldRarity = itemData.OldRarity
				local existingNum = GetTraitNameCount( CurrentRun.Hero, upgradeData.TraitToReplace )
				tooltipData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.ItemName, FakeStackNum = existingNum, RarityMultiplier = upgradeData.RarityMultiplier})
				if existingNum > 1 then
					upgradeTitle = "TraitLevel_Exchange"
					tooltipData.Title = GetTraitTooltipTitle( TraitData[upgradeData.Name])
					tooltipData.Level = existingNum
				end
			elseif lootData.StackOnly then
				tooltipData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.ItemName, FakeStackNum = lootData.StackNum, RarityMultiplier = upgradeData.RarityMultiplier})
				tooltipData.OldLevel = traitNum;
				tooltipData.NewLevel = traitNum + lootData.StackNum;
				tooltipData.Title = GetTraitTooltipTitle( TraitData[itemData.ItemName] )
				upgradeData.Title = tooltipData.Title
			else
				if upgradeData.Rarity == "Legendary" then
					if TraitData[upgradeData.Name].IsDuoBoon then
						CreateAnimation({ Name = "BoonEntranceDuo", DestinationId = components[itemBackingKey].Id })
					else
					CreateAnimation({ Name = "BoonEntranceLegendary", DestinationId = components[itemBackingKey].Id })
					end
				end

				tooltipData = upgradeData
			end
			SetTraitTextData( tooltipData )
			upgradeDescription = GetTraitTooltip( tooltipData , { Default = upgradeData.Title })

		elseif itemData.Type == "Consumable" then
			-- TODO(Dexter) Determinism

			upgradeData = GetRampedConsumableData(ConsumableData[itemData.ItemName], itemData.Rarity)
			upgradeTitle = upgradeData.Name
			upgradeDescription = GetTraitTooltip(upgradeData)

			if upgradeData.UseFunctionArgs ~= nil then
				if upgradeData.UseFunctionName ~= nil and upgradeData.UseFunctionArgs.TraitName ~= nil then
					local traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = upgradeData.UseFunctionArgs.TraitName, Rarity = itemData.Rarity })
					SetTraitTextData( traitData )
					upgradeData.UseFunctionArgs.TraitName = nil
					upgradeData.UseFunctionArgs.TraitData = traitData
					tooltipData = MergeTables( tooltipData, traitData )
				elseif upgradeData.UseFunctionNames ~= nil then
					local hasTraits = false
					for i, args in pairs(upgradeData.UseFunctionArgs) do
						if args.TraitName ~= nil then
							hasTraits = true
							local processedTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = args.TraitName, Rarity = itemData.Rarity })
							SetTraitTextData( processedTraitData )
							tooltipData = MergeTables( tooltipData, processedTraitData )
							upgradeData.UseFunctionArgs[i].TraitName = nil
							upgradeData.UseFunctionArgs[i].TraitData = processedTraitData
						end
					end
					if not hasTraits then
						tooltipData = upgradeData
					end
				end
			else
				tooltipData = upgradeData
			end
		elseif itemData.Type == "TransformingTrait" then
			local blessingData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.ItemName, Rarity = itemData.Rarity })
			local curseData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemData.SecondaryItemName, Rarity = itemData.Rarity })
			curseData.OnExpire =
			{
				TraitData = blessingData
			}
			upgradeTitle = "ChaosCombo_"..curseData.Name.."_"..blessingData.Name
			blessingData.Title = "ChaosBlessingFormat"

			SetTraitTextData( blessingData )
			SetTraitTextData( curseData )
			blessingData.TrayName = blessingData.Name.."_Tray"

			tooltipData = MergeTables( tooltipData, blessingData )
			tooltipData = MergeTables( tooltipData, curseData )
			tooltipData.Blessing = itemData.ItemName
			tooltipData.Curse = itemData.SecondaryItemName

			upgradeDescription = blessingData.Title
			upgradeData = DeepCopyTable( curseData )
			upgradeData.Icon = blessingData.Icon

			local extractedData = GetExtractData( blessingData )
			for i, value in pairs(extractedData) do
				local key = value.ExtractAs
				if key then
					upgradeData[key] = blessingData[key]
				end
			end
		end

		-- Setting button graphic based on boon type
		local purchaseButtonKey = "PurchaseButton"..itemIndex


		local iconOffsetX = -338
		local iconOffsetY = -2
		local exchangeIconPrefix = nil
		local overlayLayer = "Combat_Menu_Overlay_Backing"

		components[purchaseButtonKey] = CreateScreenComponent({ Name = "BoonSlot"..itemIndex, Group = "Combat_Menu", Scale = 1, X = itemLocationX + buttonOffsetX, Y = itemLocationY })
		if upgradeData.CustomRarityColor then
			components[purchaseButtonKey.."Patch"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = iconOffsetX + itemLocationX + buttonOffsetX + 38, Y = iconOffsetY + itemLocationY })
			SetAnimation({ DestinationId = components[purchaseButtonKey.."Patch"].Id, Name = "BoonRarityPatch"})
			SetColor({ Id = components[purchaseButtonKey.."Patch"].Id, Color = upgradeData.CustomRarityColor })
		elseif itemData.Rarity ~= "Common" then
			components[purchaseButtonKey.."Patch"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = iconOffsetX + itemLocationX + buttonOffsetX + 38, Y = iconOffsetY + itemLocationY })
			SetAnimation({ DestinationId = components[purchaseButtonKey.."Patch"].Id, Name = "BoonRarityPatch"})
			SetColor({ Id = components[purchaseButtonKey.."Patch"].Id, Color = Color["BoonPatch" .. itemData.Rarity] })
		end

		if Contains( blockedIndexes, itemIndex ) then
			itemData.Blocked = true
			overlayLayer = "Combat_Menu"
			UseableOff({ Id = components[purchaseButtonKey].Id })
			ModifyTextBox({ Ids = components[purchaseButtonKey].Id, BlockTooltip = true })
			CreateTextBox({ Id = components[purchaseButtonKey].Id,
			Text = "ReducedLootChoicesKeyword",
			OffsetX = textOffset, OffsetY = -30,
			Color = Color.Transparent,
			Width = 675,
			})
			thread( TraitLockedPresentation, { Components = components, Id = purchaseButtonKey, OffsetX = itemLocationX + buttonOffsetX, OffsetY = iconOffsetY + itemLocationY } )
		end

		if upgradeData.Icon ~= nil then
			components[purchaseButtonKey.."Icon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = iconOffsetX + itemLocationX + buttonOffsetX, Y = iconOffsetY + itemLocationY })
			SetAnimation({ DestinationId = components[purchaseButtonKey.."Icon"].Id, Name = upgradeData.Icon .. "_Large" })
			SetScale({ Id = components[purchaseButtonKey.."Icon"].Id, Fraction = 0.85 })
		end

		if upgradeData.TraitToReplace ~= nil then
			local yOffset = 70
			local xOffset = 700
			local blockedIconOffset = 0
			local textOffset = xOffset * -1 + 110
			if Contains( blockedIndexes, itemIndex ) then
				blockedIconOffset = -20
			end

			components[purchaseButtonKey.."ExchangeIcon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = overlayLayer, X = iconOffsetX + itemLocationX + buttonOffsetX + xOffset, Y = iconOffsetY + itemLocationY + yOffset + blockedIconOffset})
			SetAnimation({ DestinationId = components[purchaseButtonKey.."ExchangeIcon"].Id, Name = TraitData[upgradeData.TraitToReplace].Icon .. "_Small" })

			components[purchaseButtonKey.."ExchangeIconFrame"] = CreateScreenComponent({ Name = "BlankObstacle", Group = overlayLayer, X = iconOffsetX + itemLocationX + buttonOffsetX + xOffset, Y = iconOffsetY + itemLocationY + yOffset + blockedIconOffset})
			SetAnimation({ DestinationId = components[purchaseButtonKey.."ExchangeIconFrame"].Id, Name = "BoonIcon_Frame_".. itemData.OldRarity})

			exchangeIconPrefix = "{!Icons.TraitExchange} "

			CreateTextBox(MergeTables({
				Id = components[purchaseButtonKey.."ExchangeIcon"].Id,
				Text = "ReplaceTraitPrefix",
				OffsetX = textOffset, 
				OffsetY = -12 - blockedIconOffset + (LocalizationData.UpgradeChoice.ExchangeText.LangOffsetY[GetLanguage({})] or 0),
				FontSize = 20,
				Color = {160, 160, 160, 255},
				Width = 675,
				Font = "AlegreyaSansSCRegular",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
				VerticalJustification = "Top",
			}, LocalizationData.UpgradeChoice.ExchangeText))

			CreateTextBox(MergeTables({
				Id = components[purchaseButtonKey.."ExchangeIcon"].Id,
				Text = GetTraitTooltipTitle( TraitData[itemData.TraitToReplace ]),
				OffsetX = textOffset + 150 + (LocalizationData.UpgradeChoice.ExchangeText.LangOffsetX[GetLanguage({})] or 0), 
				OffsetY = -12 - blockedIconOffset + (LocalizationData.UpgradeChoice.ExchangeText.LangOffsetY[GetLanguage({})] or 0),
				FontSize = 20,
				Color = Color["BoonPatch" .. itemData.OldRarity],
				Width = 675,
				Font = "AlegreyaSansSCRegular",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
				VerticalJustification = "Top",
			}, LocalizationData.UpgradeChoice.ExchangeText))

		end

		components[purchaseButtonKey.."Frame"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = iconOffsetX + itemLocationX + buttonOffsetX, Y = iconOffsetY + itemLocationY })
		if upgradeData.Frame then
			SetAnimation({ DestinationId = components[purchaseButtonKey.."Frame"].Id, Name = "Frame_Boon_Menu_".. upgradeData.Frame})
			SetScale({ Id = components[purchaseButtonKey.."Frame"].Id, Fraction = 0.85 })
		else
			SetAnimation({ DestinationId = components[purchaseButtonKey.."Frame"].Id, Name = "Frame_Boon_Menu_".. itemData.Rarity})
			SetScale({ Id = components[purchaseButtonKey.."Frame"].Id, Fraction = 0.85 })
		end
		-- Button data setup
		components[purchaseButtonKey].OnPressedFunctionName = "HandleUpgradeChoiceSelection"
		components[purchaseButtonKey].Data = upgradeData
		components[purchaseButtonKey].UpgradeName = upgradeName
		components[purchaseButtonKey].Type = itemData.Type
		components[purchaseButtonKey].LootData = lootData
		components[purchaseButtonKey].LootColor = upgradeChoiceData.LootColor
		components[purchaseButtonKey].BoonGetColor = upgradeChoiceData.BoonGetColor

		components[components[purchaseButtonKey].Id] = purchaseButtonKey
		-- Creates upgrade slot text
		SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = 675 })
		local selectionString = "UpgradeChoiceMenu_PermanentItem"
		local selectionStringColor = Color.Black

		if itemData.Type == "Trait" then
			local traitData = TraitData[itemData.ItemName]
			if traitData.Slot ~= nil then
				selectionString = "UpgradeChoiceMenu_"..traitData.Slot
			end
		elseif itemData.Type == "Consumable" then
			selectionString = upgradeData.UpgradeChoiceText or "UpgradeChoiceMenu_PermanentItem"
		end

		local textOffset = 115 - buttonOffsetX
		local exchangeIconOffset = 0
		local lineSpacing = 8
		local text = "Boon_"..tostring(itemData.Rarity)
		local overlayLayer = ""
		if upgradeData.CustomRarityName then
			text = upgradeData.CustomRarityName
		end
		local color = Color["BoonPatch" .. itemData.Rarity ]
		if upgradeData.CustomRarityColor then
			color = upgradeData.CustomRarityColor
		end

		CreateTextBox({ Id = components[purchaseButtonKey].Id, Text = text  ,
			FontSize = 27,
			OffsetX = textOffset + 630, OffsetY = -60,
			Width = 720,
			Color = color,
			Font = "AlegreyaSansSCLight",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Right"
		})
		if exchangeIconPrefix then
			CreateTextBox({ Id = components[purchaseButtonKey].Id,
				Text = exchangeIconPrefix ,
				FontSize = 27,
				OffsetX = textOffset, OffsetY = -55,
				Color = color,
				Font = "AlegreyaSansSCLight",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
				LuaKey = "TooltipData", LuaValue = tooltipData,
			})
			exchangeIconOffset = 40
			if upgradeData.Slot == "Shout" then
				lineSpacing = 4
			end
		end
		CreateTextBox({ Id = components[purchaseButtonKey].Id,
			Text = upgradeTitle,
			FontSize = 27,
			OffsetX = textOffset + exchangeIconOffset, OffsetY = -55,
			Color = color,
			Font = "AlegreyaSansSCLight",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Left",
			LuaKey = "TooltipData", LuaValue = tooltipData,
		})

		-- Chaos curse/blessing traits need VariableAutoFormat disabled
		local autoFormat = "BoldFormatGraft"
		if upgradeDescription == "ChaosBlessingFormat" or itemData.Type == "TransformingTrait" then
			autoFormat = nil
		end

		CreateTextBoxWithFormat(MergeTables({ Id = components[purchaseButtonKey].Id,
			Text = upgradeDescription,
			OffsetX = textOffset, OffsetY = -30,
			Width = GetLocalizedValue(675, { { Code = "ja", Value = 670 }, }),
			Justification = "Left",
			VerticalJustification = "Top",
			LineSpacingBottom = lineSpacing,
			UseDescription = true,
			LuaKey = "TooltipData", LuaValue = tooltipData,
			Format = "BaseFormat",
			VariableAutoFormat = autoFormat,
			TextSymbolScale = 0.8,
		}, LocalizationData.UpgradeChoice.BoonLootButton))

		local needsQuestIcon = false
		if not GameState.TraitsTaken[upgradeData.Name] and HasActiveQuestForTrait( upgradeData.Name ) then
			needsQuestIcon = true
		elseif itemData.ItemName ~= nil and not GameState.TraitsTaken[itemData.ItemName] and HasActiveQuestForTrait( itemData.ItemName ) then
			needsQuestIcon = true
		end

		if needsQuestIcon then
			components[purchaseButtonKey.."QuestIcon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = itemLocationX + 92, Y = itemLocationY - 55 })
			SetAnimation({ DestinationId = components[purchaseButtonKey.."QuestIcon"].Id, Name = "QuestItemFound" })
			-- Silent toolip
			CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = "TraitQuestItem", Color = Color.Transparent, LuaKey = "TooltipData", LuaValue = tooltipData, })
		end

		if upgradeData.LimitedTime then
			-- Silent toolip
			CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = "SeasonalItem", Color = Color.Transparent, LuaKey = "TooltipData", LuaValue = tooltipData, })
		end

		if firstOption then
			TeleportCursor({ OffsetX = itemLocationX + buttonOffsetX, OffsetY = itemLocationY, ForceUseCheck = true, })
			firstOption = false
		end

		itemLocationY = itemLocationY + 220
	end



	if IsMetaUpgradeSelected( "RerollPanelMetaUpgrade" ) then
		local cost = -1
		if lootData.BlockReroll then
			cost = -1
		elseif lootData.Name == "WeaponUpgrade" then
			cost = RerollCosts.Hammer
		else
			cost = RerollCosts.Boon
		end
		local baseCost = cost

		local name = "RerollPanelMetaUpgrade_ShortTotal"
		local tooltip = "MetaUpgradeRerollHint"
		if cost >= 0 then

			local increment = 0
			if CurrentRun.CurrentRoom.SpentRerolls then
				increment = CurrentRun.CurrentRoom.SpentRerolls[lootData.ObjectId] or 0
			end
			cost = cost + increment
		else
			name = "RerollPanel_Blocked"
			tooltip = "MetaUpgradeRerollBlockedHint"
		end
		local color = Color.White
		if CurrentRun.NumRerolls < cost or cost < 0 then
			color = Color.CostUnaffordable
		end

		if baseCost > 0 then
			components["RerollPanel"] = CreateScreenComponent({ Name = "ShopRerollButton", Scale = 1.0, Group = "Combat_Menu" })
			Attach({ Id = components["RerollPanel"].Id, DestinationId = components.ShopBackground.Id, OffsetX = 0, OffsetY = 410 })
			components["RerollPanel"].OnPressedFunctionName = "AttemptPanelReroll"
			components["RerollPanel"].RerollFunctionName = "RerollBoonLoot"
			components["RerollPanel"].RerollColor = lootData.LootColor
			components["RerollPanel"].RerollId = lootData.ObjectId

			components["RerollPanel"].Cost = cost

			CreateTextBox({ Id = components["RerollPanel"].Id, Text = name, OffsetX = 28, OffsetY = -5,
			ShadowColor = {0,0,0,1}, ShadowOffset={0,3}, OutlineThickness = 3, OutlineColor = {0,0,0,1},
			FontSize = 28, Color = color, Font = "AlegreyaSansSCExtraBold", LuaKey = "TempTextData", LuaValue = { Amount = cost }})
			SetInteractProperty({ DestinationId = components["RerollPanel"].Id, Property = "TooltipOffsetX", Value = 350 })
			CreateTextBox({ Id = components["RerollPanel"].Id, Text = tooltip, FontSize = 1, Color = Color.Transparent, Font = "AlegreyaSansSCExtraBold", LuaKey = "TempTextData", LuaValue = { Amount = cost }})
		end
	end
end

function DestroyBoonLootButtons( lootData )
	local components = ScreenAnchors.ChoiceScreen.Components
	local toDestroy = {}
	for index = 1, 3 do
		local destroyIndexes = {
		"PurchaseButton"..index,
		"PurchaseButton"..index.. "Lock",
		"PurchaseButton"..index.. "Icon",
		"PurchaseButton"..index.. "ExchangeIcon",
		"PurchaseButton"..index.. "ExchangeIconFrame",
		"PurchaseButton"..index.. "QuestIcon",
		"Backing"..index,
		"PurchaseButton"..index.. "Frame",
		"PurchaseButton"..index.. "Patch"}
		for i, indexName in pairs( destroyIndexes ) do
			if components[indexName] then
				table.insert(toDestroy, components[indexName].Id)
				components[indexName] = nil
			end
		end
	end
	if components["RerollPanel"] then
		table.insert(toDestroy, components["RerollPanel"].Id)
		components["RerollPanel"] = nil
	end
	if ScreenAnchors.ChoiceScreen.SacrificedTraitId then
		table.insert(toDestroy, ScreenAnchors.ChoiceScreen.SacrificedTraitId )
		ScreenAnchors.ChoiceScreen.SacrificedTraitId = nil
	end
	if ScreenAnchors.ChoiceScreen.SacrificedFrameId then
		table.insert(toDestroy, ScreenAnchors.ChoiceScreen.SacrificedFrameId )
		ScreenAnchors.ChoiceScreen.SacrificedFrameId = nil
	end
	if ScreenAnchors.ChoiceScreen.ActivateSwapId then
		table.insert(toDestroy, ScreenAnchors.ChoiceScreen.ActivateSwapId )
		ScreenAnchors.ChoiceScreen.ActivateSwapId = nil
	end
	Destroy({ Ids = toDestroy })
end

function AttemptBoonLootReroll()

	if CurrentRun.NumRerolls <= 0 then
		return
	end

	CurrentRun.NumRerolls = CurrentRun.NumRerolls - 1
	UpdateRerollUI( CurrentRun.NumRerolls )

	RandomSynchronize( CurrentRun.NumRerolls )
	InvalidateCheckpoint()
	RerollBoonLoot()
end

function RerollBoonLoot( lootData )	
	lootData = lootData or CurrentLootData
	DestroyBoonLootButtons( lootData )
	local itemNames = {}
	for i, value in pairs( lootData.UpgradeOptions ) do
		table.insert( itemNames, value.ItemName )
	end
	SetTraitsOnLoot( lootData, { ExclusionNames = { GetRandomValue( itemNames )}})
	CreateBoonLootButtons( lootData, true )
end

function GetRarityValue( rarity )
	local rarityOrdering = {"Common", "Rare", "Epic", "Heroic", "Legendary"}
	return GetKey(rarityOrdering, rarity) or 1
end

function GetRarityKey( index )
	local rarityOrdering = {"Common", "Rare", "Epic", "Heroic", "Legendary"}
	return rarityOrdering[index]
end

function GetUpgradedRarity( baseRarity )
	local rarityTable =
	{
		Common = "Rare",
		Rare = "Epic",
		Epic = "Heroic",
	}

	if HasHeroTraitValue("ReplaceUpgradedRarityTable") then
		rarityTable = GetHeroTraitValues("ReplaceUpgradedRarityTable")[1]
	end

	return rarityTable[baseRarity]
end

function GetWeaponUpgradeChoice( traitNames )
	return GetRandomValue(GetEligibleWeaponTraits( traitNames ))
end

function GetPriorityTraits( traitNames, lootData )
	if traitNames == nil then
		return {}
	end

	local priorityOptions = {}
	local heroHasPriorityTrait = false
	local occupiedSlots = {}

	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot then
			occupiedSlots[traitData.Slot] = true
		end
	end

	for index, traitName in ipairs(traitNames) do

		if TraitData[traitName] and (lootData.StripRequirements or IsGameStateEligible(CurrentRun, TraitData[traitName])) then
			if not HeroHasTrait(traitName) and not occupiedSlots[TraitData[traitName].Slot] then
				local data = { ItemName = traitName, Type = "Trait"}
				table.insert(priorityOptions, data)
			else
				heroHasPriorityTrait = true
			end
		end
	end

	if heroHasPriorityTrait then
		return { GetRandomValue(priorityOptions) }
	end

	while TableLength( priorityOptions ) > GetTotalLootChoices() do
		RemoveRandomValue( priorityOptions )
		priorityOptions = CollapseTable( priorityOptions )
	end
	return priorityOptions;
end

function GetReplacementTraits( traitNames, onlyFromLootName )
	if traitNames == nil then
		return {}
	end

	local priorityOptions = {}
	local occupiedSlots = {}

	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot then
			if not occupiedSlots[traitData.Slot] then
				occupiedSlots[traitData.Slot] = { TraitName = traitData.Name, Rarity = "Common" }
			end
			if  traitData.Rarity ~= nil and GetRarityValue( traitData.Rarity ) > GetRarityValue( occupiedSlots[traitData.Slot].Rarity ) then
				occupiedSlots[traitData.Slot].Rarity = traitData.Rarity
			end
		end
	end

	for index, traitName in ipairs(traitNames) do
		local slot = TraitData[traitName].Slot
		if IsGameStateEligible( CurrentRun, TraitData[traitName] ) and not HeroHasTrait(traitName) and occupiedSlots[slot] and GetUpgradedRarity(occupiedSlots[slot].Rarity) ~= nil and ( onlyFromLootName == nil or LootData[onlyFromLootName].TraitIndex[occupiedSlots[slot].TraitName] ) then
			local data = { ItemName = traitName, Type = "Trait", TraitToReplace = occupiedSlots[slot].TraitName, OldRarity = occupiedSlots[slot].Rarity, Rarity = GetUpgradedRarity(occupiedSlots[slot].Rarity) }
			table.insert(priorityOptions, data)
		end
	end
	return { GetRandomValue(priorityOptions) }
end

function GetEligibleWeaponTraits( traitNames )
	local ineligibleTraits = {}

	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		local traitGod = traitData.God
		local traitSlot = traitData.Slot
		if traitGod ~= nil and traitSlot  ~= nil then
			-- If the traits overlap type and aren't the same name then that slot is taken
			for s, possibleTraitName in pairs( traitNames ) do
				local possibleTraitData = TraitData[possibleTraitName]
				if possibleTraitData ~= nil and traitSlot == possibleTraitData.Slot then
					table.insert(ineligibleTraits, possibleTraitName)
				end
			end
		end
	end

	local eligibleTraits = {}
	for i, traitName in pairs(traitNames) do
		if not Contains(ineligibleTraits, traitName) then
			table.insert(eligibleTraits, traitName)
		end
	end

	return eligibleTraits
end

function GetPriorityDependentTraits ( lootData )

	if lootData.LinkedUpgrades == nil then
		return nil
	end

	local linkedTraits = {}
	local orderedLinkedUpgrades = CollapseTableAsOrderedKeyValuePairs( lootData.LinkedUpgrades )
	for i, kvp in ipairs( orderedLinkedUpgrades ) do
		local traitName = kvp.Key
		local dependencyTable = kvp.Value
		local valid = false
		if not HeroHasTrait( traitName ) then
			if dependencyTable.OneOf ~= nil then
				for j, dependentTraitName in ipairs(dependencyTable.OneOf) do
					if not valid and HeroHasTrait(dependentTraitName) then
						valid = true
					end
				end
			end

			if not valid and dependencyTable.OneFromEachSet ~= nil then
				valid = true
				for i, traitSet in ipairs(dependencyTable.OneFromEachSet) do
					local foundInSet = false
					for j, dependentTraitName in ipairs(dependencyTable.OneFromEachSet[i]) do
						if not foundInSet and HeroHasTrait(dependentTraitName) then
							foundInSet = true
						end
					end
					if not foundInSet then
						valid = false
						break
					end
				end
			end

			if valid and dependencyTable.PriorityChance ~= nil then
				table.insert( linkedTraits, { TraitName = traitName, PriorityChance = dependencyTable.PriorityChance })
			end
		end
	end

	return linkedTraits
end
function GetEligibleTraitUpgrades ( lootData )
	local eligibleTraits = DeepCopyTable( lootData.Traits )

	if lootData.LinkedUpgrades == nil then
		return eligibleTraits
	end

	local linkedTraits = {}
	local orderedLinkedUpgrades = CollapseTableAsOrderedKeyValuePairs( lootData.LinkedUpgrades )
	for i, kvp in ipairs( orderedLinkedUpgrades ) do
		local traitName = kvp.Key
		local dependencyTable = kvp.Value
		local valid = false

		if dependencyTable.OneOf ~= nil then
			for j, dependentTraitName in ipairs(dependencyTable.OneOf) do
				if not valid and HeroHasTrait(dependentTraitName) then
					valid = true
				end
			end
		end

		if not valid and dependencyTable.OneFromEachSet ~= nil then
			valid = true
			for i, traitSet in ipairs(dependencyTable.OneFromEachSet) do
				local foundInSet = false
				for j, dependentTraitName in ipairs(dependencyTable.OneFromEachSet[i]) do
					if not foundInSet and HeroHasTrait(dependentTraitName) then
						foundInSet = true
					end
				end
				if not foundInSet then
					valid = false
					break
				end
			end

		end


		if valid then
			table.insert( linkedTraits, traitName )
		end
	end

	return CombineTablesIPairs(eligibleTraits, linkedTraits )
end

function GetConsumableChoice( consumablesData )

	return GetRandomValue( GetEligibleConsumableNames( consumablesData ))
end

function GetEligibleConsumableNames( consumablesData )
	local eligibleConsumables = {}
	for i, consumableName in ipairs( CollapseTableOrdered(consumablesData) ) do
		if IsGameStateEligible( CurrentRun, ConsumableData[consumableName] ) then
			table.insert( eligibleConsumables, consumableName )
		end
	end
	return eligibleConsumables
end

function GetEligibleUpgrades( upgradeOptions, lootData, upgradeChoiceData )
	local eligibleUpgrades = {}

	if lootData.StackOnly then
		local upgradeableGodTraitsKVPs = CollapseTableAsOrderedKeyValuePairs(GetAllUpgradeableGodTraits())
		for i, kvp in ipairs( upgradeableGodTraitsKVPs ) do
			local traitName = kvp.Key
			table.insert(eligibleUpgrades, { ItemName = traitName, Type = "Trait"})
		end
	else
		local eligibleWeaponUpgrades = GetEligibleWeaponTraits(upgradeChoiceData.WeaponUpgrades)
		for i, traitName in pairs(eligibleWeaponUpgrades) do
			table.insert(eligibleUpgrades, { ItemName = traitName, Type = "Trait"})
		end

		local eligibleTraitUpgrades = GetEligibleTraitUpgrades(upgradeChoiceData) or {}

		for i, traitName in ipairs(eligibleTraitUpgrades) do
			table.insert(eligibleUpgrades, { ItemName = traitName, Type = "Trait"})
		end

		for i, consumableName in ipairs(GetEligibleConsumableNames( upgradeChoiceData.Consumables )) do
			table.insert(eligibleUpgrades, { ItemName = consumableName, Type = "Consumable" })
		end
	end

	local toRemove = {}
	for i, upgradeData in ipairs(eligibleUpgrades) do
		local data = nil
		if upgradeData.Type == "Consumable" then
			data = ConsumableData[upgradeData.ItemName]
		elseif upgradeData.Type == "Trait" then
			data = TraitData[upgradeData.ItemName]
		end

		if not lootData.StackOnly and upgradeData.Type == "Trait" and HeroHasTrait(upgradeData.ItemName) then
			table.insert(toRemove, upgradeData)
		elseif not lootData.StripRequirements and not IsGameStateEligible(CurrentRun, data) then
			table.insert(toRemove, upgradeData)
		end
	end

	for i, value in ipairs(toRemove) do
		RemoveValue(eligibleUpgrades, value )
	end
	eligibleUpgrades = CollapseTableOrdered(eligibleUpgrades)
	return eligibleUpgrades
end

function HandleUpgradeChoiceSelection( screen, button )
	local buttonId = button.Id
	local upgradeData = button.Data
	local currentRun = CurrentRun
	
	currentRun.CurrentRoom.ReplacedTraitSource = nil
	if button.Type == "Trait" then
		-- handle trait
		if upgradeData.TraitToReplace then
			local numOldTrait = GetTraitNameCount( CurrentRun.Hero, upgradeData.TraitToReplace )
			RemoveWeaponTrait( upgradeData.TraitToReplace )
			AddTraitToHero({ TraitData = upgradeData })
			for i=1, numOldTrait-1 do
				AddTraitToHero({ TraitName = upgradeData.Name })
			end
			DeactivateSwapTraitPresentation()
			currentRun.CurrentRoom.ReplacedTraitSource = GetLootSourceName(upgradeData.TraitToReplace)
		else
			if button.LootData.StackOnly then
				for i = 1, button.LootData.StackNum do
					AddTraitToHero({ TraitName = upgradeData.Name  })
				end
			else
				AddTraitToHero({ TraitData = upgradeData, PreProcessedForDisplay = true })
			end
		end
	elseif button.Type == "Consumable" then
		-- handle consumable
		local consumableName = upgradeData.Name
		local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = CurrentRun.Hero.ObjectId, Group = "Standing" })
		local consumable = CreateConsumableItemFromData( consumableId, upgradeData, 0 )
	elseif button.Type == "TransformingTrait" then
		local curseData = upgradeData
		curseData.CurseName = curseData.Name
		curseData.BlessingName = upgradeData.OnExpire.TraitData.Name
		curseData.LastCurseName = curseData.Name
		curseData.LastBlessingName = upgradeData.OnExpire.TraitData.Name
		curseData.TraitTitle = "ChaosCombo_"..curseData.Name.."_"..upgradeData.OnExpire.TraitData.Name
		curseData.Icon = TraitData[curseData.Name].Icon
		upgradeData.OnExpire.TraitData.TraitTitle = "Blank"
		upgradeData.OnExpire.TraitData.LastCurseName = curseData.Name
		upgradeData.OnExpire.TraitData.LastBlessingName = upgradeData.OnExpire.TraitData.Name

		AddTraitToHero({ TraitData = curseData, PreProcessedForDisplay = true })
	end
	LogUpgradeChoice( button )
	PlaySound({ Name = button.LootData.UpgradeSelectedSound or "/SFX/HeatRewardDrop", Id = buttonId })
	CreateAnimation({ Name = "BoonGet", DestinationId = buttonId, Scale = 1.0, GroupName = "Combat_Menu_Additive", Color = button.BoonGetColor or button.LootColor })
	--wait( 0.4, RoomThreadName )
	CloseUpgradeChoiceScreen( screen, button )
	IncrementTableValue( GameState.LootPickups, button.UpgradeName )
	CheckCodexUnlock( "OlympianGods", button.UpgradeName )
	CheckCodexUnlock( "ChthonicGods", button.UpgradeName )
	CheckCodexUnlock( "Items", button.UpgradeName )

	UpgradeAcquiredPresentation( button.UpgradeName, buttonId )
	ChaosBassStop()

	wait( 0.2, RoomThreadName )
	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end

	SetLightBarColor({ PlayerIndex = 1, Color = CurrentRun.Hero.LightBarColor or { 0.0, 0.0, 0.0, 0.0 } });

end

function CloseUpgradeChoiceScreen( screen, button )
	DisableShopGamepadCursor( screen.Name )
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = "BoonSelectOut" })
	if ScreenAnchors.ChoiceScreen.ActivateSwapId ~= nil then
		Destroy({ Id = ScreenAnchors.ChoiceScreen.ActivateSwapId })
		ScreenAnchors.ChoiceScreen.ActivateSwapId = nil
	end

	
	local useableOffButtonIds = {}
	for index = 1, 3 do
		if screen.Components["PurchaseButton"..index] and screen.Components["PurchaseButton"..index].Id then
			table.insert(useableOffButtonIds, screen.Components["PurchaseButton"..index].Id)
		end
	end
	UseableOff({ Ids = useableOffButtonIds, ForceHighlightOff = true })

	CloseScreen( GetAllIds( screen.Components ), 0.25 )
	if not LootData[screen.SubjectName].SelectionSound then
		PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	else
		PlaySound({ Name = LootData[screen.SubjectName].SelectionSound })
	end
	UnfreezePlayerUnit("BoonMenuOpen")
	SetPlayerVulnerable("BoonMenuOpen")
	SetConfigOption({ Name = "UseOcclusion", Value = true })
	screen.KeepOpen = false
	OnScreenClosed({Flag = "BoonMenu"})

	NotifyResultsTable[ UIData.BoonMenuId ] = screen.SubjectName
	notifyExistingWaiters( UIData.BoonMenuId )

	if CurrentRun.Hero.IsDead then
		HideCombatUI()
		return
	end

	CheckObjectiveSet("AdvancedTooltipPrompt")

	if not IsEmpty(LootObjects)  then
		for itemId, item in pairs( LootObjects ) do
			if IsAlive({ Id = itemId }) then
				if not item.ForceCommon then
					RandomSynchronize()
					item.RarityChances = GetRarityChances( item )
				end
				item.UpgradeOptions = nil
			end
		end
	end
	ScreenAnchors.ChoiceScreen = nil
end


function LogUpgradeChoice( button )
	if CurrentRun == nil then
		return
	end
	if CurrentRun.LootChoiceHistory == nil then
		CurrentRun.LootChoiceHistory = {}
	end

	local depth = 0
	if not IsEmpty(CurrentRun.RoomHistory) then
		depth = TableLength(CurrentRun.RoomHistory)
	end

	local data =
	{
		Depth = depth,
		UpgradeName = button.LootData.Name,
		UpgradeChoices = {}
	}

	if button.LootData.UpgradeOptions == nil then
		return
	end

	for i, upgradeData in pairs(button.LootData.UpgradeOptions) do
		if not upgradeData.Blocked then
			local choiceData =
			{
				Chosen = tostring( upgradeData.ItemName == button.Data.Name ),
				Name = tostring(upgradeData.ItemName),
				Rarity = tostring(upgradeData.Rarity),
			}
			if upgradeData.Type == "TransformingTrait" then
				choiceData.BlessingName = upgradeData.SecondaryItemName
			end
			if upgradeData.TraitToReplace ~= nil then
				choiceData.TraitToReplace = upgradeData.TraitToReplace
				choiceData.OldRarity = upgradeData.OldRarity
			end
			table.insert( data.UpgradeChoices, choiceData )
		end
	end

	table.insert( CurrentRun.LootChoiceHistory, data )
end

OnMouseOver{ "BoonSlot1 BoonSlot2 BoonSlot3",
	function( triggerArgs )
		if triggerArgs.triggeredById == nil or not IsScreenOpen("BoonMenu") or ScreenAnchors.ChoiceScreen == nil or ScreenAnchors.ChoiceScreen.Components[ triggerArgs.triggeredById ] == nil then
			return
		end
		local key = ScreenAnchors.ChoiceScreen.Components[ triggerArgs.triggeredById ]
		local component = ScreenAnchors.ChoiceScreen.Components[key]
		if component ~= nil and component.Data and component.Data.TraitToReplace then
			ActivateSwapTraitPresentation( component.Data.TraitToReplace )
		end
	end
}

OnMouseOff{ "BoonSlot1 BoonSlot2 BoonSlot3",
	function( triggerArgs )
		if IsScreenOpen("BoonMenu") then
			local key = ScreenAnchors.ChoiceScreen.Components[ triggerArgs.triggeredById ]
			local component = ScreenAnchors.ChoiceScreen.Components[key]
			if component ~= nil and component.Data and component.Data.TraitToReplace then
				DeactivateSwapTraitPresentation()
			end
		end
	end
}

function ActivateSwapTraitPresentation( traitName )
	local existingTraitData = GetExistingUITraitName( traitName )
	if existingTraitData ~= nil and existingTraitData.TraitSwapOverlay == nil then
		local toDestroy = {}
		if ScreenAnchors.ChoiceScreen.SacrificedTraitId then
			table.insert(toDestroy, ScreenAnchors.ChoiceScreen.SacrificedTraitId )
			ScreenAnchors.ChoiceScreen.SacrificedTraitId = nil
		end
		if ScreenAnchors.ChoiceScreen.SacrificedFrameId then
			table.insert(toDestroy, ScreenAnchors.ChoiceScreen.SacrificedFrameId )
			ScreenAnchors.ChoiceScreen.SacrificedFrameId = nil
		end
		if ScreenAnchors.ChoiceScreen.ActivateSwapId then
			table.insert(toDestroy, ScreenAnchors.ChoiceScreen.ActivateSwapId )
			ScreenAnchors.ChoiceScreen.ActivateSwapId = nil
		end
		Destroy({ Ids = toDestroy })

		local sacrificeIconId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", DestinationId = existingTraitData.AnchorId })
		Attach({ Id = sacrificeIconId, DestinationId = existingTraitData.AnchorId })
		SetAnimation({ Name = GetTraitIcon(existingTraitData), DestinationId = sacrificeIconId, Group = "Combat_Menu_Overlay" })
		ScreenAnchors.ChoiceScreen.SacrificedTraitId = sacrificeIconId

		local sacrificeFrameId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", DestinationId = existingTraitData.AnchorId })
		SetAnimation({ DestinationId = sacrificeFrameId, Name = "BoonIcon_Frame_".. (existingTraitData.Rarity or "Common")})
		Attach({ Id = sacrificeFrameId, DestinationId = sacrificeIconId})
		ScreenAnchors.ChoiceScreen.SacrificedFrameId = sacrificeFrameId

		local traitFrameId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay"  })
		SetAnimation({ Name = "BoonIcon_Frame_Exchange", DestinationId = traitFrameId })
		Attach({ Id = traitFrameId, DestinationId = existingTraitData.AnchorId })
		ScreenAnchors.ChoiceScreen.ActivateSwapId = traitFrameId
	end
end

function DeactivateSwapTraitPresentation()
	if ScreenAnchors.ChoiceScreen.ActivateSwapId ~= nil then
		Destroy({Ids = { ScreenAnchors.ChoiceScreen.ActivateSwapId, ScreenAnchors.ChoiceScreen.SacrificedTraitId, ScreenAnchors.ChoiceScreen.SacrificedFrameId }})
		ScreenAnchors.ChoiceScreen.ActivateSwapId = nil
		ScreenAnchors.ChoiceScreen.SacrificedTraitId = nil
		ScreenAnchors.ChoiceScreen.SacrificedFrameId = nil
	end
end
