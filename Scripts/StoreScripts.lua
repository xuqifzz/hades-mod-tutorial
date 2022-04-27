
function FillInShopOptions( args )
	if args == nil then
		args = {}
	end

	if args.RoomName and RoomData[args.RoomName] and RoomData[args.RoomName].PersistentStore then
		local store = GetPreviousStore( args )
		if store ~= nil then
			return store
		end
	end

	local storeData = nil
	if args.StoreData ~= nil then
		storeData = args.StoreData
	else
		storeData = StoreData
	end

	local store =
	{
		StoreOptions = {}
	}

	if storeData.Traits ~= nil then
		for i, itemName in pairs( storeData.Traits ) do
			if not Contains( storeData.GuaranteedItems, itemName) and not Contains( args.ExclusionNames, itemName) and IsTraitEligible(CurrentRun, TraitData[itemName]) then
				local upgradeData = {}
				upgradeData.Name = itemName
				upgradeData.Type = "Trait"
				table.insert( store.StoreOptions, upgradeData )
			end
		end
	end

	if storeData.Consumables ~= nil then
		for i, itemName in pairs( storeData.Consumables ) do
			if not Contains( storeData.GuaranteedItems, itemName ) and not Contains( args.ExclusionNames, itemName ) then
				local upgradeData = ConsumableData[itemName]
				if StoreItemEligible(upgradeData, args) then
					upgradeData = {}
					upgradeData.Name = itemName
					upgradeData.Type = "Consumable"
					table.insert ( store.StoreOptions, upgradeData )
				end
			end
		end
	end

	local cosmetics = {}
	local cosmeticOffers = 0
	if storeData.CosmeticOffers then
		cosmeticOffers = storeData.CosmeticOffers.Amount
		if cosmeticOffers == nil then
			cosmeticOffers = RandomInt( storeData.CosmeticOffers.Min, storeData.CosmeticOffers.Max )
		end
		if cosmeticOffers == nil or cosmeticOffers < 0 then
			cosmeticOffers = 0
		end
	end

	if storeData.CosmeticOffers ~= nil then
		for i, itemName in pairs( storeData.CosmeticOffers.Options ) do
			if not GameState.Cosmetics[itemName] and not Contains( args.ExclusionNames, itemName) then
				local upgradeData = {}
				upgradeData.Name = itemName
				upgradeData.Type = "Cosmetic"
				table.insert( cosmetics, upgradeData )
			end
		end

		while TableLength( cosmetics ) > cosmeticOffers do
			RemoveRandomValue( cosmetics )
		end
	end
	cosmeticOffers = math.min(TableLength(cosmetics), cosmeticOffers)

	local healOffers = {}
	local healOfferAmount = 0

	if storeData.HealingOffers then
		healOfferAmount = storeData.HealingOffers.Amount
		if healOfferAmount == nil then
			healOfferAmount = RandomInt( storeData.HealingOffers.Min, storeData.HealingOffers.Max )
		end
		if healOfferAmount == nil or healOfferAmount < 0 then
			healOfferAmount = 0
		end
		if storeData.HealingOffers.Options then
			for i=1, healOfferAmount do
				local options = {}
				for i, data in pairs( storeData.HealingOffers.Options ) do
					if not Contains(args.ExclusionNames, data.Name ) and StoreItemNameEligible(data.Name, data.Type) then
						table.insert( options, data )
					end
				end

				local healOfferData = GetRandomValue( options )
				local upgradeData = DeepCopyTable( healOfferData )

				if upgradeData and not Contains( args.ExclusionNames, upgradeData.Name ) then
					table.insert( healOffers, upgradeData )
				end
			end
		elseif storeData.HealingOffers.WeightedList then
			local pickedOptions = {}
			local options = DeepCopyTable( storeData.HealingOffers.WeightedList )
			while TableLength( pickedOptions ) < healOfferAmount do
				local weightedList = {}
				for i, itemData in pairs( options ) do
					if not Contains(args.ExclusionNames, itemData.Name ) and StoreItemNameEligible(itemData.Name, itemData.Type) then
						weightedList[i] = itemData.Weight
					end
				end

				local index = GetRandomValueFromWeightedList( weightedList )
				table.insert( pickedOptions, options[index] )
				table.remove( options, index )
			end
			for s, itemData in pairs( pickedOptions ) do
				if not Contains( args.ExclusionNames, itemData.Name ) then
					table.insert( healOffers, itemData )
				end
			end
		end

	end
	local godTraits = {}
	if storeData.GodTraitOffers ~= nil then
		local godTraitNumber = RandomInt( storeData.GodTraitOffers.Min, storeData.GodTraitOffers.Max )
		local godTraitOptions = ShallowCopyTable( storeData.GodTraitOffers.Types)
		local ignoredGod = nil
		for i=1, godTraitNumber do
			local pickedGod = GetEligibleInteractedGod( ignoredGod )
			if pickedGod ~= nil then
				local upgradeData = {}
				upgradeData.Name = "RandomLoot"
				upgradeData.Type = "Boon"
				upgradeData.Args = { ForceLootName = pickedGod, BoughtFromShop = true, DoesNotBlockExit = true, Cost = GetProcessedValue( ConsumableData.RandomLoot.Cost ) }
				ignoredGod = pickedGod
				table.insert( godTraits, upgradeData )
			end
		end
	end

	if storeData.MaxOffers then
		while TableLength( store.StoreOptions ) > ( storeData.MaxOffers - TableLength( godTraits ) - healOfferAmount - cosmeticOffers ) do
			RemoveRandomValue( store.StoreOptions )
		end
		store.StoreOptions = CollapseTable( store.StoreOptions )
		store.StoreOptions = CombineTables( healOffers, store.StoreOptions )
		store.StoreOptions = CombineTables( store.StoreOptions, godTraits )
		store.StoreOptions = CombineTables( store.StoreOptions, cosmetics )
	end

	if storeData.GroupsOf then
		for i, groupData in pairs(storeData.GroupsOf) do
			local options = {}
			if groupData.Options ~= nil then
				for s, itemName in pairs(groupData.Options) do
					local upgradeData = ConsumableData[itemName]
					if StoreItemEligible(upgradeData, args) or groupData.SkipRequirements then
						if itemName == "RandomLoot" or itemName == "BoostedRandomLoot" then
							local pickedGod = GetEligibleInteractedGod()
							if pickedGod ~= nil then
								upgradeData = {}
								upgradeData.Name = "RandomLoot"
								upgradeData.Type = "Boon"
								upgradeData.Args = { ForceLootName = pickedGod, BoughtFromShop = true, DoesNotBlockExit = true, Cost = GetProcessedValue( ConsumableData[itemName].Cost ) }
								if itemName == "BoostedRandomLoot" then
									upgradeData.Args.AddBoostedAnimation = true
									upgradeData.Args.BoonRaritiesOverride = { LegendaryChance = 0.1, EpicChance = 0.25, RareChance = 1.0 }
								end
								table.insert( options, upgradeData )
							end
						else
							upgradeData = {}
							upgradeData.Name = itemName
							upgradeData.Type = "Consumable"
							table.insert ( options, upgradeData )
						end
					end
				end
			end
			if groupData.OptionsData ~= nil then
				for s, itemData in pairs(groupData.OptionsData) do
					local upgradeData = ConsumableData[itemData.Name]
					if ( itemData.ReplaceRequirements == nil and ( StoreItemEligible(upgradeData, args) or itemData.SkipRequirements )) or ( itemData.ReplaceRequirements and IsGameStateEligible( CurrentRun, itemData.ReplaceRequirements) ) then
						local itemName = itemData.Name
						if itemName == "RandomLoot" or itemName == "BoostedRandomLoot" then
							local pickedGod = GetEligibleInteractedGod()
							if pickedGod ~= nil then
								upgradeData = {}
								upgradeData.Name = "RandomLoot"
								upgradeData.Type = "Boon"
								upgradeData.Args = { ForceLootName = pickedGod, BoughtFromShop = true, DoesNotBlockExit = true, Cost = GetProcessedValue( ConsumableData[itemName].Cost ) }
								if itemName == "BoostedRandomLoot" then
									upgradeData.Args.AddBoostedAnimation = true
									upgradeData.Args.BoonRaritiesOverride = { LegendaryChance = 0.1, EpicChance = 0.25, RareChance = 1.0 }
								end
							end
						else
							upgradeData = {}
							upgradeData.Name = itemData.Name
							upgradeData.Type = "Consumable"
							if itemData.Cost ~= nil then
								upgradeData.Cost = itemData.Cost
							end
						end

						if itemData.UpgradeChance and RandomChance( itemData.UpgradeChance ) then
							upgradeData.AddBoostedAnimation = true
							upgradeData.BoonRaritiesOverride = { LegendaryChance = 0.1, EpicChance = 0.25, RareChance = 1.0 }
							if itemData.UpgradedCost then
								upgradeData.Cost = itemData.UpgradedCost
							end
						end
						upgradeData.Weight = itemData.Weight or 1
						table.insert ( options, upgradeData )
					end
				end
			end
			if groupData.WeightedList then
				local pickedOptions = {}
				while TableLength( pickedOptions ) < groupData.Offers do
					local weightedList = {}
					for i, storeData in pairs( options ) do
						weightedList[i] = storeData.Weight
					end

					local index = GetRandomValueFromWeightedList( weightedList )
					table.insert( pickedOptions, options[index] )
					table.remove( options, index )
				end
				for s, itemData in pairs( pickedOptions ) do
					table.insert( store.StoreOptions, itemData )
				end
			else
				while TableLength( options ) > groupData.Offers do
					RemoveRandomValue( options )
				end
				for s, itemData in pairs(options) do
					table.insert( store.StoreOptions, itemData )
				end
			end
		end
	end
	return store
end

function GetPreviousStore( args )
	if CurrentRun.RoomCreations[args.RoomName] == nil then
		return nil
	end

	for roomIndex = #CurrentRun.RoomHistory, 1, -1 do
		local room = CurrentRun.RoomHistory[roomIndex]
		if room.Name == args.RoomName then
			return { StoreOptions = DeepCopyTable( room.Store.StoreOptions )}
		end
	end
	return nil
end

function RerollStore()
	DestroyStoreButtons()
	local randomExclusion = nil
	if not IsEmpty(CurrentRun.CurrentRoom.Store.StoreOptions ) then
		randomExclusion = { GetRandomValue( CurrentRun.CurrentRoom.Store.StoreOptions ).Name }
	end
	CurrentRun.CurrentRoom.Store.StoreOptions = FillInShopOptions({ StoreData = StoreData.RoomShop, RoomName = CurrentRun.CurrentRoom.Name, ExclusionNames = randomExclusion }).StoreOptions
	CreateStoreButtons()
end

function StoreItemNameEligible( itemName, itemCategory)
	if itemCategory == "Consumable" then
		return StoreItemEligible( ConsumableData[itemName] )
	elseif itemCategory == "Trait" then
		return StoreItemEligible( TraitData[itemName] )
	end
end

function StoreItemEligible( itemData, args )
	if itemData.RequiredNextMaps and (args.RoomName == nil or not Contains( itemData.RequiredNextMaps, args.RoomName )) then
		return false
	end

	if itemData.RequiredFalseNextMaps and Contains( itemData.RequiredFalseNextMaps, args.RoomName ) then
		return false
	end

	if itemData.RequireUpgradableTraits and not UpgradableGodTraitCountAtLeast( 0 )  then
		return false
	end
	return IsGameStateEligible( CurrentRun, itemData )
end

function RemoveStoreItem( args )
	if CurrentRun == nil or CurrentRun.CurrentRoom == nil or CurrentRun.CurrentRoom.Store == nil or IsEmpty( CurrentRun.CurrentRoom.Store.StoreOptions ) then
		return
	end
	for i, data in pairs( CurrentRun.CurrentRoom.Store.StoreOptions ) do
		local dataArgs = data.Args or {}
		if args.IsBoon and data.Type == "Boon" and data.Args and data.Args.ForceLootName == args.Name and TableLength(dataArgs.BoonRaritiesOverride) == TableLength(args.BoonRaritiesOverride) then
			if dataArgs.BoonRaritiesOverride == args.BoonraritiesOverride then
				CurrentRun.CurrentRoom.Store.StoreOptions[i] = nil
				break
			elseif dataArgs.BoonRaritiesOverride ~= nil and args.BoonRaritiesOverride ~= nil and dataArgs.BoonRaritiesOverride.Epic == args.BoonRaritiesOverride.Epic and  dataArgs.BoonRaritiesOverride.Rare == args.BoonRaritiesOverride.Rare then
				CurrentRun.CurrentRoom.Store.StoreOptions[i] = nil
				break
			end
		elseif ( data.Name ~= "StackUpgradeDrop" and data.Name == ( args.Name .. "Drop" )) or ( data.Name == "StackUpgradeDrop" and args.Name == "StackUpgrade" and args.StackNum == 1 ) or ( data.Name == "StackUpgradeDropRare" and args.Name == "StackUpgrade" and args.StackNum == 2 ) or ( data.Name == "StackUpgradeDropRare" and args.Name == "StackUpgrade" and args.StackNum == 2 ) then
			CurrentRun.CurrentRoom.Store.StoreOptions[i] = nil
			break
		elseif data.Name == args.Name then
			CurrentRun.CurrentRoom.Store.StoreOptions[i] = nil
			break
		end
	end
	CurrentRun.CurrentRoom.StoreItemsPurchased = (CurrentRun.CurrentRoom.StoreItemsPurchased or 0) + 1
end

function RunShopGeneration( roomData )
	if IsWellShopEligible( CurrentRun, roomData ) then
		roomData.Store = FillInShopOptions({ StoreData = StoreData.RoomShop, RoomName = roomData.Name })
	end
	if roomData.ChosenRewardType == "Shop" then
		local storeOptions = StoreData.WorldShop
		if CurrentRun.CurrentRoom.StoreDataName and StoreData[CurrentRun.CurrentRoom.StoreDataName] then
			storeOptions = StoreData[CurrentRun.CurrentRoom.StoreDataName]
		end
		roomData.Store = FillInShopOptions({ RoomName = roomData.Name, StoreData = storeOptions })
	end
end

OnUsed{ "WeaponShop",
	function( triggerArgs )
		StartUpStore()
	end
}

function CheckChallengeSwitchItemValidity( currentRun )
	-- unfortunately, too many things rely on the current store item generation flow to use anything more generic @alice
	if not currentRun or not currentRun.CurrentRoom or not currentRun.CurrentRoom.Store or not currentRun.CurrentRoom.Store.StoreOptions then
		return
	end
	if not currentRun.CurrentRoom.ChallengeSwitch then
		return
	end
	
	local hasChallengeSwitchRequirement = false
	for i, itemData in pairs( currentRun.CurrentRoom.Store.StoreOptions ) do
		if itemData then
			if itemData.Type == "Trait" then
				if TraitData[itemData.Name] and TraitData[itemData.Name].RequiredNoChallengeSwitchInRoom then
					hasChallengeSwitchRequirement = true
				end
			elseif itemData.Type == "Consumable" then
				if ConsumableData[itemData.Name] and ConsumableData[itemData.Name].RequiredNoChallengeSwitchInRoom then
					hasChallengeSwitchRequirement = true
				end
			end
		end
	end

	if hasChallengeSwitchRequirement then
		currentRun.CurrentRoom.Store.StoreOptions = FillInShopOptions({ StoreData = StoreData.RoomShop, RoomName = CurrentRun.CurrentRoom.Name }).StoreOptions
	end
end

function CheckForbiddenShopItem( eventSource, args )
	local spawnOnId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "ForbiddenShopItemSpawnPoint" })
	if spawnOnId == nil or spawnOnId == 0 then
		return
	end

	CurrentRun.ForbiddenShopItemOffered = true

	local consumableName = "ForbiddenShopItem"
	local playerId = GetIdsByType({ Name = "_PlayerUnit" })
	local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = spawnOnId, Group = "Standing" })
	local consumable = CreateConsumableItem( consumableId, consumableName, 0 )
	if consumable.DropMoney ~= nil then
		consumable.DropMoney = round( consumable.DropMoney * GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } ))
	end

	table.insert( CurrentRun.CurrentRoom.Store.SpawnedStoreItems, { ObjectId = consumableId, Cost = consumable.Cost } )
	SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = consumableId })

	local shopIds = GetInactiveIds({ Name = "ForbiddenShop" })
	Activate({ Ids = shopIds })

end

function SpawnStoreItemsInWorld()
	local kitIds = GetIdsByType({ Name = "LootPoint" })
	table.sort( kitIds )
	if CurrentRun.CurrentRoom.Store == nil then
		local storeOptions = StoreData.WorldShop
		if CurrentRun.CurrentRoom.StoreDataName and StoreData[CurrentRun.CurrentRoom.StoreDataName] then
			storeOptions = StoreData[CurrentRun.CurrentRoom.StoreDataName]
		end
		CurrentRun.CurrentRoom.Store = FillInShopOptions({ RoomName = CurrentRun.CurrentRoom.Name, StoreData = storeOptions })
	end

	CurrentRun.CurrentRoom.Store.SpawnedStoreItems = {}
	local sortedList = CollapseTableAsOrderedKeyValuePairs( CurrentRun.CurrentRoom.Store.StoreOptions )
	for i, kvp in ipairs( sortedList ) do
		local index = kvp.Key
		local itemData = kvp.Value
		if kitIds[index] ~= nil  then
			local spawnedItem = SpawnStoreItemInWorld( itemData, kitIds[index] )
		end
	end
end

function SpawnStoreItemInWorld( itemData, kitId )
	local spawnedItem = nil
	if itemData.Name == "StackUpgradeDrop" then
		spawnedItem = CreateStackLoot({ SpawnPoint = kitId, Cost = GetProcessedValue( ConsumableData.StackUpgradeDrop.Cost ), DoesNotBlockExit = true, SuppressSpawnSounds = true, } )
	elseif itemData.Name == "WeaponUpgradeDrop" then
		spawnedItem = CreateWeaponLoot({ SpawnPoint = kitId, Cost = itemData.Cost or GetProcessedValue( ConsumableData.WeaponUpgradeDrop.Cost ), DoesNotBlockExit = true, SuppressSpawnSounds = true, } )
	elseif itemData.Name =="HermesUpgradeDrop" then
		spawnedItem = CreateHermesLoot({ SpawnPoint = kitId, Cost = itemData.Cost or GetProcessedValue( ConsumableData.HermesUpgradeDrop.Cost ), DoesNotBlockExit = true, SuppressSpawnSounds = true, BoughtFromShop = true, AddBoostedAnimation = itemData.AddBoostedAnimation, BoonRaritiesOverride = itemData.BoonRaritiesOverride })
		spawnedItem.CanReceiveGift = false
		SetThingProperty({ Property = "SortBoundsScale", Value = 1.0, DestinationId = spawnedItem.ObjectId })
	elseif itemData.Name == "StoreTrialUpgradeDrop" then
		local args  = { BoughtFromShop = true, DoesNotBlockExit = true, Cost = GetProcessedValue( ConsumableData.StoreTrialUpgradeDrop.Cost ) }
		args.SpawnPoint = kitId
		args.DoesNotBlockExit = true
		args.SuppressSpawnSounds = true
		args.Name = "TrialUpgrade"
		spawnedItem = GiveLoot( args )
		spawnedItem.CanReceiveGift = false
		SetThingProperty({ Property = "SortBoundsScale", Value = 1.0, DestinationId = spawnedItem.ObjectId })
	elseif itemData.Name == "StackUpgradeDropRare" then
		spawnedItem = CreateStackLoot({ SpawnPoint = kitId, Cost = GetProcessedValue( ConsumableData.StackUpgradeDropRare.Cost ), DoesNotBlockExit = true, SuppressSpawnSounds = true, StackNum = 2, AddBoostedAnimation = true, })
	elseif itemData.Type == "Consumable" then
		local consumablePoint = SpawnObstacle({ Name = itemData.Name, DestinationId = kitId, Group = "Standing" })
		local upgradeData =  GetRampedConsumableData( ConsumableData[itemData.Name] )
		spawnedItem = CreateConsumableItemFromData( consumablePoint, upgradeData )
		ApplyConsumableItemResourceMultiplier( CurrentRun.CurrentRoom, spawnedItem )
		ExtractValues( CurrentRun.Hero, spawnedItem, spawnedItem )
	elseif itemData.Type == "Boon" then
		itemData.Args.SpawnPoint = kitId
		itemData.Args.DoesNotBlockExit = true
		itemData.Args.SuppressSpawnSounds = true
		itemData.Args.SuppressFlares = true
		spawnedItem = GiveLoot( itemData.Args )
		spawnedItem.CanReceiveGift = false
		SetThingProperty({ Property = "SortBoundsScale", Value = 1.0, DestinationId = spawnedItem.ObjectId })
	end
	if spawnedItem ~= nil then
		SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = spawnedItem.ObjectId })
		spawnedItem.SpawnPointId = kitId
		spawnedItem.UseText = spawnedItem.PurchaseText or "Shop_UseText"
		table.insert( CurrentRun.CurrentRoom.Store.SpawnedStoreItems, { ObjectId = spawnedItem.ObjectId, Cost = spawnedItem.Cost } )
	end

end

function UpdateCostText( object, textExists )
	textExists = textExists or false

	if object.Cost ~= nil and object.Cost > 0 then
		local costFontColor = Color.CostAffordable
		if object.Cost > CurrentRun.Money and not object.Purchased then
			costFontColor = Color.CostUnaffordable
		end
		if object.HealthCost and not object.Purchased then
			if CurrentRun.Hero.Health > object.HealthCost then
				costFontColor = Color.CostAffordableShop
			else
				costFontColor = Color.CostUnaffordable
			end
		end

		if textExists then
			ModifyTextBox({ Id = object.ObjectId, ColorTarget = costFontColor, ColorDuration = 0.2 })
		else
			CreateTextBox({ Id = object.ObjectId, Text = "Shop_ItemCost", TextSymbolScale = 0.6, LuaKey = "TempTextData", LuaValue = { Amount = object.Cost }, FontSize = 24, OffsetY = -75, Color = costFontColor, Justification = "CENTER",
				Font="AlegreyaSansSCBold",
				FontSize=36,
				ShadowColor = {0,0,0,1},
				ShadowOffset= {0,2},
				ShadowAlpha=1,
				ShadowBlur=0,
				OutlineColor={0,0,0,1},
				OutlineThickness=2,

			})
		end
	end
end

function ShowStoreScreen()

	local screen = { Components = {} }
	screen.Name = "Store"

	if IsScreenOpen( screen.Name ) then
		return
	end

	SetPlayerInvulnerable("StoreScreenOpen")
	OnScreenOpened({ Flag = screen.Name, PersistCombatUI = true })
	FreezePlayerUnit("StoreScreen", { DisableTray = false })
	EnableShopGamepadCursor()
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = true })
	SetConfigOption({ Name = "FreeFormSelecSearchFromId", Value = 0 })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 10 })

	PlaySound({ Name = "/SFX/Menu Sounds/WellShopOpenNew" })
	thread( PlayVoiceLines, GlobalVoiceLines.OpenedShopLines, true )

	CurrentRun.CurrentRoom.Store.Screen = screen
	local components = screen.Components

	local offeredWeaponUpgrades = {}

	components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_UI_World" })
	components.ShopBackground = CreateScreenComponent({ Name = "WellShopBackground", Group = "Combat_UI_World" })
	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Group = "Combat_UI_Backing", Scale = 0.7 })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = 0, OffsetY = 440 })
	components.CloseButton.OnPressedFunctionName = "CloseStoreScreen"
	components.CloseButton.ControlHotkey = "Cancel"
	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 4 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.090, 0.055, 0.157, 0.85} })

	wait(0.25)

	-- Title
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "Store_Title", FontSize = 32, OffsetX = 0, OffsetY = -445, Color = Color.White, Font = "SpectralSCLightTitling", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3}, Justification = "Center" })

	CreateTextBox({ Id = components.ShopBackground.Id, Text = "Store_Hint", FontSize = 14, OffsetX = 0, OffsetY = 380, Width = 840, Color = Color.Gray, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })

	-- Flavor Text
	local flavorTextOptions = { "WellShop_FlavorText01", "WellShop_FlavorText02", "WellShop_FlavorText03", }
	local flavorText = GetRandomValue( flavorTextOptions )
	CreateTextBox(MergeTables({ Id = components.ShopBackground.Id, Text = flavorText,
			FontSize = 16,
			OffsetY = -385, Width = 840,
			Color = {0.698, 0.702, 0.514, 1.0},
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "Center",
		}, LocalizationData.SellTraitScripts.FlavorText))

	CreateStoreButtons()
	
	if not IsEmpty(CurrentRun.CurrentRoom.Store.StoreOptions ) then
		thread( PlayVoiceLines, HeroVoiceLines.WellShopUsedVoiceLines, true )
	end
	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )

end

function CreateStoreButtons()

	local itemLocationStartY = ShopUI.ShopItemStartY
	local itemLocationYSpacer = ShopUI.ShopItemSpacerY
	local itemLocationMaxY = itemLocationStartY + 4 * itemLocationYSpacer

	local itemLocationStartX = ShopUI.ShopItemStartX
	local itemLocationXSpacer = ShopUI.ShopItemSpacerX
	local itemLocationMaxX = itemLocationStartX + 1 * itemLocationXSpacer

	local itemLocationTextBoxOffset = 380

	local itemLocationX = itemLocationStartX
	local itemLocationY = itemLocationStartY

	local components = CurrentRun.CurrentRoom.Store.Screen.Components

	local numButtons = StoreData.WorldShop.MaxOffers
	if numButtons == nil then
		numButtons = 0
		for i, groupData in pairs( StoreData.WorldShop.GroupsOf ) do
			numButtons = numButtons + groupData.Offers
		end
	end

	local firstUseable = false
	for itemIndex = 1, numButtons do
		local upgradeData = CurrentRun.CurrentRoom.Store.StoreOptions[itemIndex]

		local itemBackingSoldOutKey = "ItemBackingSoldOut"..itemIndex
		components[itemBackingSoldOutKey] = CreateScreenComponent({ Name = "BoonSlotInactive"..itemIndex, Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })

		if upgradeData ~= nil then
			if not upgradeData.Processed then
				if upgradeData.Type == "Trait" then
					upgradeData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = upgradeData.Name })
					if upgradeData.CostIncreasePerStack ~= nil then
						upgradeData.Cost = upgradeData.Cost + GetTraitCount(CurrentRun.Hero, upgradeData) * upgradeData.CostIncreasePerStack
					end
					upgradeData.Type = "Trait"
					SetTraitTextData( upgradeData )
				elseif upgradeData.Type == "Consumable" then
					upgradeData = GetRampedConsumableData( ConsumableData[upgradeData.Name] )
					upgradeData.Type = "Consumable"
				elseif upgradeData.Type == "Cosmetic" then
					upgradeData = DeepCopyTable( ConditionalItemData[upgradeData.Name] )
					upgradeData.Type = "Cosmetic"
				end

				local costMultiplier = 1 + ( GetNumMetaUpgrades( "ShopPricesShrineUpgrade" ) * ( MetaUpgradeData.ShopPricesShrineUpgrade.ChangeValue - 1 ) )
				costMultiplier = costMultiplier * GetTotalHeroTraitValue("StoreCostMultiplier", {IsMultiplier = true})
				if costMultiplier ~= 1 then
					upgradeData.Cost = round( upgradeData.Cost * costMultiplier )
				end

				upgradeData.Processed = true
			elseif upgradeData.Type == "Trait" then
				RecalculateStoreTraitDurations( upgradeData )
			end

			CurrentRun.CurrentRoom.Store.StoreOptions[itemIndex] = upgradeData
			local tooltipData = upgradeData


			local purchaseButtonKey = "PurchaseButton"..itemIndex
			components[purchaseButtonKey] = CreateScreenComponent({ Name = "BoonSlot"..itemIndex, Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })
			SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "TooltipOffsetX", Value = 665 })
			SetInteractProperty({ DestinationId = components[purchaseButtonKey].Id, Property = "FreeFormSelectOffsetX", Value = -200 })

			if upgradeData.Icon ~= nil then
				local iconKey = "Icon"..itemIndex
				components[iconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX - 343, Y = itemLocationY, Group = "Combat_Menu" })
				SetAnimation({ DestinationId = components[iconKey].Id , Name = upgradeData.Icon.."_Large" })
			end

			local itemBackingKey = "Backing"..itemIndex
			components[itemBackingKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = itemLocationX + itemLocationTextBoxOffset, Y = itemLocationY })

			local purchaseButtonTitleKey = "PurchaseButtonTitle"..itemIndex
			components[purchaseButtonTitleKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", Scale = 1, X = itemLocationX, Y = itemLocationY })
			CreateTextBoxWithFormat(MergeTables({ Id = components[purchaseButtonKey].Id,
				Text = GetTraitTooltip( upgradeData ),
				OffsetX = -245,
				OffsetY = -23,
				Format = "BaseFormat",
				UseDescription = true,
				VariableAutoFormat = "BoldFormatGraft",
				LuaKey = "TooltipData",
				LuaValue = tooltipData,
				Justification = "Left",
				VerticalJustification = "Top",
				LineSpacingBottom = 8,
				Width = "665" },LocalizationData.SellTraitScripts.ShopButton))


			local costString = "@GUI\\Icons\\Currency_Small"
			costString = upgradeData.Cost .. " " .. costString
			local costColor = Color.CostAffordableShop
			if CurrentRun.Money ~= nil and CurrentRun.Money < upgradeData.Cost then
				costColor = Color.CostUnaffordable
			end

			if upgradeData.HealthCost then
				costString = upgradeData.HealthCost .. " @GUI\\Icons\\Life_Small"
				if CurrentRun.Hero.Health > upgradeData.HealthCost then
					costColor = Color.CostAffordableShop
				else
					costColor = Color.CostUnaffordable
				end
			end

			local needsQuestIcon = false
			if upgradeData.Type == "Trait" then
				if not GameState.TraitsTaken[upgradeData.Name] and HasActiveQuestForTrait( upgradeData.Name ) then
					needsQuestIcon = true
				end
			elseif upgradeData.Type == "Consumable" then
				if not GameState.ItemInteractions[upgradeData.Name] and HasActiveQuestForItem( upgradeData.Name ) then
					needsQuestIcon = true
				end
			end
			if needsQuestIcon then
				components[purchaseButtonKey.."QuestIcon"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu", X = itemLocationX + 112, Y = itemLocationY - 55 })
				SetAnimation({ DestinationId = components[purchaseButtonKey.."QuestIcon"].Id, Name = "QuestItemFound" })
				-- Silent toolip
				CreateTextBox({ Id = components[purchaseButtonKey].Id, TextSymbolScale = 0, Text = "TraitQuestItem", Color = Color.Transparent, LuaKey = "TooltipData", LuaValue = tooltipData, })
			end

			components[purchaseButtonKey].OnPressedFunctionName = "HandleStorePurchase"
			if not firstUseable then
				TeleportCursor({ OffsetX = itemLocationX, OffsetY = itemLocationY, ForceUseCheck = true })
				firstUseable = true
			end

			CreateTextBox(MergeTables({ Id = components[purchaseButtonTitleKey].Id, Text = costString, OffsetX = 410, OffsetY = -50, FontSize = 28, Color = costColor, Font = "AlegreyaSansSCRegular", Justification = "Right" },LocalizationData.SellTraitScripts.ShopButton))

			CreateTextBox(MergeTables({ Id = components[purchaseButtonTitleKey].Id, Text = upgradeData.Name,
				FontSize = 25,
				OffsetX = -245, OffsetY = -50,
				Width = 720,
				Color = costColor,
				Font = "AlegreyaSansSCBold",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
			},LocalizationData.SellTraitScripts.ShopButton))

			components[purchaseButtonKey].Data = upgradeData
			components[purchaseButtonKey].WeaponName = currentWeapon
			components[purchaseButtonKey].Index = itemIndex
			components[purchaseButtonKey].TitleId = components[purchaseButtonTitleKey].Id

			if CurrentRun.CurrentRoom.Store.Buttons == nil then
				CurrentRun.CurrentRoom.Store.Buttons = {}
			end
			table.insert(CurrentRun.CurrentRoom.Store.Buttons, components[purchaseButtonKey])
		end
		itemLocationX = itemLocationX + itemLocationXSpacer
		if itemLocationX >= itemLocationMaxX then
			itemLocationX = itemLocationStartX
			itemLocationY = itemLocationY + itemLocationYSpacer
		end
	end

	if IsMetaUpgradeSelected("RerollPanelMetaUpgrade") then
		local increment = 0
		if CurrentRun.CurrentRoom.SpentRerolls then
			increment = CurrentRun.CurrentRoom.SpentRerolls[CurrentRun.CurrentRoom.Store.Screen.Name] or 0
		end
		local cost = RerollCosts.Shop + increment

		local color = Color.White
		if CurrentRun.NumRerolls < cost or cost < 0 then
			color = Color.CostUnaffordable
		end
		if cost > 0 then
			components["RerollPanel"] = CreateScreenComponent({ Name = "ShopRerollButton", Scale = 1.0, Group = "Combat_Menu" })
			Attach({ Id = components["RerollPanel"].Id, DestinationId = components.ShopBackground.Id, OffsetX = -200, OffsetY = 440 })
			components["RerollPanel"].OnPressedFunctionName = "AttemptPanelReroll"
			components["RerollPanel"].RerollFunctionName = "RerollStore"
			components["RerollPanel"].Cost = cost
			components["RerollPanel"].RerollColor = {48, 25, 83, 255}
			components["RerollPanel"].RerollId = CurrentRun.CurrentRoom.Store.Screen.Name
			CreateTextBox({ Id = components["RerollPanel"].Id, Text = "RerollPanelMetaUpgrade_ShortTotal", OffsetX = 28, OffsetY = -5,
			ShadowColor = {0,0,0,1}, ShadowOffset={0,3}, OutlineThickness = 3, OutlineColor = {0,0,0,1},
			FontSize = 28, Color = color, Font = "AlegreyaSansSCExtraBold", LuaKey = "TempTextData", LuaValue = { Amount = cost }})
			SetInteractProperty({ DestinationId = components["RerollPanel"].Id, Property = "TooltipOffsetX", Value = 850 })
			CreateTextBox({ Id = components["RerollPanel"].Id, Text = "MetaUpgradeRerollHint", FontSize = 1, Color = Color.Transparent, Font = "AlegreyaSansSCExtraBold", LuaKey = "TempTextData", LuaValue = { Amount = cost }})
		end
	end

end
function DestroyStoreButtons()
	local components = CurrentRun.CurrentRoom.Store.Screen.Components
	local toDestroy = {}
	for index = 1, StoreData.RoomShop.MaxOffers do
		local destroyIndexes = { "ItemBackingSoldOut"..index, "PurchaseButton"..index, "Icon"..index, "Backing"..index, "PurchaseButtonTitle"..index }
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
	CurrentRun.CurrentRoom.Store.Buttons = {}
end

function RecalculateStoreTraitDurations( traitData )
	local traitName = traitData.Name
	if not TraitData[traitName] then
		return
	end

	if traitData.RemainingUses ~= nil and TraitData[traitName].RemainingUses then
		traitData.RemainingUses = TraitData[traitName].RemainingUses
	end

	if not IsEmpty( CurrentRun.Hero.Traits ) and traitData.RemainingUses ~= nil then
		for i, data in pairs( GetHeroTraitValues( "TraitDurationIncrease" )) do
			if data.ValidTraits == nil or Contains( data.ValidTraits, traitName ) then
				if traitData.RemainingUses ~= nil and TraitData[traitName].RemainingUses then
					traitData.RemainingUses = TraitData[traitName].RemainingUses + data.Amount
				end
			end
		end
	end
end

function StartUpStore()
	RandomSynchronize(11)
	if CurrentRun.CurrentRoom.Store == nil then
		CurrentRun.CurrentRoom.Store = FillInShopOptions({ RoomName = CurrentRun.CurrentRoom.Name, StoreData = StoreData.RoomShop })
	end
	if TableLength( CurrentRun.CurrentRoom.Store.StoreOptions ) == 0 then
		thread( PlayVoiceLines, HeroVoiceLines.WellShopSoldOutVoiceLines, true )
	end
	ShowStoreScreen()
end

function CloseStoreScreen( screen, button )
	CurrentRun.CurrentRoom.Store.StoreOptions = CollapseTable( CurrentRun.CurrentRoom.Store.StoreOptions )
	DisableShopGamepadCursor()
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16 })
	PlaySound({ Name = "/SFX/Menu Sounds/WellShopCloseNew" })
	SetAnimation({ Name = "WellShopOut", DestinationId = screen.Components.ShopBackground.Id })
	local components = screen.Components
	local useableOffButtonIds = {}
	for index = 1, StoreData.RoomShop.MaxOffers do
		if components["PurchaseButton"..index] and components["PurchaseButton"..index].Id then
			table.insert(useableOffButtonIds, components["PurchaseButton"..index].Id)
		end
	end
	UseableOff({ Ids = useableOffButtonIds, ForceHighlightOff = true })
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
	CurrentRun.CurrentRoom.Store.Buttons = {}
	UnfreezePlayerUnit("StoreScreen")
	screen.KeepOpen = false
	OnScreenClosed({Flag = "Store"})
	thread( MarkObjectiveComplete, "ShopPrompt" )
	SetPlayerVulnerable("StoreScreenOpen")

	if CurrentRun.CurrentRoom.Store.CosmeticUnlocked ~= nil then
		thread( DisplayUnlockText, {
			TitleText = "Store_CosmeticUnlocked_Title",
			SubtitleText = "Store_CosmeticUnlocked_Subtitle",
			SubtitleData = { LuaKey = "TempTextData", LuaValue = { Name = CurrentRun.CurrentRoom.Store.CosmeticUnlocked }}
		})
		CurrentRun.CurrentRoom.Store.CosmeticUnlocked = nil
	end
end

function HandleStorePurchase( screen, button )
	local upgradeData = button.Data

	if upgradeData.HealthCost and CurrentRun.Hero.Health <= upgradeData.HealthCost then
		Flash({ Id = screen.Components["PurchaseButton".. button.Index].Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
		CantAffordPresentation( upgradeData )
		return
	end

	if CurrentRun.Money == nil or CurrentRun.Money < upgradeData.Cost then
		Flash({ Id = screen.Components["PurchaseButton".. button.Index].Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
		CantAffordPresentation( upgradeData )
		return
	end

	if upgradeData.Cost ~= nil and upgradeData.Cost > 0 and upgradeData.PurchaseRequirements ~= nil and not IsGameStateEligible( CurrentRun, upgradeData.PurchaseRequirements ) then
		CantPurchasePresentation( screen.Components["PurchaseButton".. button.Index] )
		return
	end

	StorePurchasePresentation( screen, button, upgradeData )

	CurrentRun.WellPurchases =  (CurrentRun.WellPurchases or 0) + 1

	SpendMoney( upgradeData.Cost, upgradeData.Name or "WeaponUpgrade" )
	local values = {}
	for i, value in pairs (CurrentRun.CurrentRoom.Store.StoreOptions) do
		if value.Name == upgradeData.Name then
			CurrentRun.CurrentRoom.Store.StoreOptions[i] = nil
		end
	end

	if upgradeData.Type == "Trait" then
		AddTraitToHero({ TraitData = upgradeData })
		IncrementTableValue( GameState.ItemInteractions, upgradeData.Name )
		CheckCodexUnlock( "Items", upgradeData.Name )
	elseif upgradeData.Type == "Consumable" then
		local consumableName = upgradeData.Name
		local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = CurrentRun.Hero.ObjectId, Group = "Standing" })
		local consumable = CreateConsumableItemFromData( consumableId, upgradeData, 0 )
	end

	if upgradeData.CloseScreen then
		thread( PlayRandomEligibleVoiceLines, { upgradeData.PurchasedLines } )
		CloseStoreScreen( screen, button )
		return
	end
	if screen.Components["PurchaseButton"..button.Index.."QuestIcon"] ~= nil then
		Destroy({ Id = screen.Components["PurchaseButton"..button.Index.."QuestIcon"].Id })
		screen.Components["PurchaseButton"..button.Index.."QuestIcon"] = nil
	end

	Destroy({ Id = screen.Components["PurchaseButtonTitle".. button.Index].Id })
	screen.Components["PurchaseButtonTitle".. button.Index] = nil

	CreateAnimation({ Name = "BoonSlotPurchase", DestinationId = screen.Components["Backing".. button.Index].Id, OffsetX = -380 })

	Destroy({ Id = screen.Components["PurchaseButton".. button.Index].Id })
	screen.Components["PurchaseButton".. button.Index] = nil

	Destroy({ Id = screen.Components["Icon".. button.Index].Id })
	screen.Components["Icon".. button.Index] = nil

	thread( PlayRandomEligibleVoiceLines, { upgradeData.PurchasedLines } )

	for i, button in pairs(CurrentRun.CurrentRoom.Store.Buttons) do
		UpdateCostButton( button )
	end
end


function UpdateCostButton(button)
	if button == nil then
		return
	end

	local upgradeData = button.Data
	local costColor = Color.CostAffordableShop
	if CurrentRun.Money == nil or CurrentRun.Money < upgradeData.Cost then
		costColor = Color.CostUnaffordable
	end
	if upgradeData.HealthCost then
		if CurrentRun.Hero.Health > upgradeData.HealthCost then
			costColor = Color.CostAffordableShop
		else
			costColor = Color.CostUnaffordable
		end
	end
	ModifyTextBox({ Id = button.TitleId, Color = costColor })
end

function StoreCostSort( itemA, itemB )
	return itemA.Cost < itemB.Cost
end

function UnwrapRandomLoot( spawnId )
	FreezePlayerUnit("RandomLoot")
	RandomSynchronize()
	InvalidateCheckpoint()
	local obstacleId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = spawnId })
	local reward = GiveLoot({ SpawnPoint = obstacleId })
	reward.BoughtFromShop = true
	UseableOff({ Id = reward.ObjectId })
	UnwrapLootPresentation( reward )
	Destroy({ Id = obstacleId })
	wait(0.7)
	UseableOn({ Id = reward.ObjectId })
	SetInteractProperty({ DestinationId = reward.ObjectId, Property = "AutoActivate", Value = true })
	SetInteractProperty({ DestinationId = reward.ObjectId, Property = "AutoUseDistance", Value = 1000})
	SetInteractProperty({ DestinationId = reward.ObjectId, Property = "Distance", Value = 1000})

	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "cancelCharge" })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "ForceControlRelease" })

	UnfreezePlayerUnit("RandomLoot")
	HideUseButton( reward.ObjectId, reward, 0 )
end

function AwardRandomStoreItem( args )
	local options = {}
	for i, traitName in pairs( args.Traits ) do
		if TraitData[traitName] and IsGameStateEligible( CurrentRun, TraitData[traitName]) then
			table.insert( options, { Name = traitName, Type = "Trait" })
		end
	end
	for i, consumableName in pairs( args.Consumables ) do
		if ConsumableData[consumableName] and StoreItemEligible( CurrentRun, ConsumableData[consumableName])
			and ( ConsumableData[consumableName].PurchaseRequirements == nil or IsGameStateEligible( ConsumableData[consumableName].PurchaseRequirements )) then

			table.insert( options, { Name = consumableName, Type = "Consumable" })
		end
	end
	if IsEmpty( options ) then
		return
	end

	local randomItem = GetRandomValue( options )
	if randomItem.Type == "Trait" then
		AddTraitToHero({TraitName = randomItem.Name})
	elseif randomItem.Type == "Consumable" then
		local consumableName = randomItem.Name
		local playerId = GetIdsByType({ Name = "_PlayerUnit" })
		local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = playerId, Group = "Standing" })
		local consumable = CreateConsumableItem( consumableId, consumableName, 0 )
		consumable.IgnorePurchase = true
		if consumable.AddMaxHealthArgs then
			consumable.AddMaxHealthArgs.Silent = true
		end
	end

	thread( RandomStoreItemPresentation, randomItem )

end

function GiveRandomTemporaryKeepsake( args )
	local validTraits = {}

	for i, traitName in pairs( args.Traits ) do
		if IsKeepsakeUnlocked( traitName ) and GameState.LastAwardTrait ~= traitName then
			DebugPrint({Text = " valid traits " .. traitName })
			table.insert( validTraits, traitName )
		end
	end
	local pickedTraitName = GetRandomValue( validTraits )
	local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = pickedTraitName, Rarity = GetRarityKey(GetKeepsakeLevel( pickedTraitName ))})
	traitData.RemainingUses = 3
	traitData.UsesAsEncounters = true
	traitData.Slot = nil
	traitData.LargeIconOverride = traitData.Icon
	traitData.CustomName = "TemporaryKeepsake"
	traitData.CustomTitle = "TemporaryKeepsake"
	AddTraitToHero({ TraitData = traitData })
end