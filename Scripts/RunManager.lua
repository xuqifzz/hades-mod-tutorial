function CreateNewHero( prevRun, args )
	local newHeroData = GetEligibleHero()
	local newHero = DeepCopyTable( newHeroData )
	newHero.SpeakerId = 1
	newHero.Traits = {}
	newHero.RecentTraits = {}
	newHero.Health = newHero.MaxHealth
	newHero.InvulnerableFlags = {}
	newHero.PersistentInvulnerableFlags = {}
	newHero.SuperMeter = 0
	newHero.SuperMeterLimit = CalculateSuperMeter()

	if args ~= nil and args.WeaponName ~= nil then
		newHero.Weapons[args.WeaponName] = true
	elseif prevRun ~= nil then
		newHero.Weapons = ShallowCopyTable( prevRun.Hero.Weapons )
	end

	local damageIncrease = 1 + GetNumMetaUpgrades( "EnemyDamageShrineUpgrade" ) * ( MetaUpgradeData.EnemyDamageShrineUpgrade.ChangeValue - 1 )
	AddIncomingDamageModifier( newHero,
	{
		Name = "EnemyDamageShrineUpgrade",
		NonTrapDamageTakenMultiplier = damageIncrease
	})
	local trapDamageIncrease = 1 + GetNumMetaUpgrades( "TrapDamageShrineUpgrade" ) * ( MetaUpgradeData.TrapDamageShrineUpgrade.ChangeValue - 1 )
	AddIncomingDamageModifier( newHero,
	{
		Name = "TrapDamageShrineUpgrade",
		TrapDamageTakenMultiplier = trapDamageIncrease
	})

	newHero.RallyHealth.ConversionPercent = newHero.RallyHealth.ConversionPercent + ( GetNumMetaUpgrades( "RallyMetaUpgrade" ) * ( MetaUpgradeData.RallyMetaUpgrade.ChangeValue - 1 ))

	if args ~= nil and args.TraitNames ~= nil then
		for k, traitName in pairs( args.TraitNames ) do
			AddTrait( newHero, traitName )
		end
	end

	return newHero
end


function CalculateStartingMoney()
	return GetTotalHeroTraitValue( "BonusMoney" ) + GetNumMetaUpgrades("MoneyMetaUpgrade") * MetaUpgradeData.MoneyMetaUpgrade.ChangeValue
end

function InitHeroLastStands( newHero )
	for s = 1, GetNumMetaUpgrades("ExtraChanceMetaUpgrade" ) do
		for i = 1, MetaUpgradeData["ExtraChanceMetaUpgrade"].ChangeValue do
			AddLastStand({
				Unit = newHero,
				IncreaseMax = true,
				Icon = "ExtraLifeZag",
				WeaponName = "LastStandMetaUpgradeShield",
				HealFraction = 0.5,
				Silent = true
			})
		end
	end
	for s = 1, GetNumMetaUpgrades("ExtraChanceReplenishMetaUpgrade" ) do
		for i = 1, MetaUpgradeData["ExtraChanceReplenishMetaUpgrade"].ChangeValue do
			AddLastStand({
				Name = "ExtraChanceReplenishMetaUpgrade",
				Unit = newHero,
				IncreaseMax = true,
				Icon = "ExtraLifeReplenish",
				WeaponName = "LastStandMetaUpgradeShield",
				HealFraction = MetaUpgradeData.ExtraChanceReplenishMetaUpgrade.HealPercent,
				Silent = true
			})
		end
	end
end

function CalculateSuperMeter()
	return 100 -- this will be something fancy some day
end

function IsTraitEligible( currentRun, traitData )

	if traitData.MaxAmount ~= nil and traitData.MaxAmount <= GetTraitCount(CurrentRun.Hero, traitData) then
		return false
	end

	if not IsGameStateEligible( currentRun, traitData ) then
		return
	end

	return true

end

function GetEligibleHero()
	local eligibleHeroes = { }
	local runsComplete = GetCompletedRuns()
	--DebugPrint({ Text = "GetEligibleHero - Runs Complete: "..tostring(runsComplete), LogOnly = true })
	for heroKey, heroData in pairs( HeroData ) do
		if heroData.RequiredMinCompletedRuns ~= nil and GetCompletedRuns() < heroData.RequiredMinCompletedRuns then
			-- haven't completed enough runs
			--DebugPrint({ Text = "GetEligibleHero - Unavailable: (not enough runs) "..tostring(heroKey), LogOnly = true })
		elseif heroData.UnavailableAfterCompletedRuns ~= nil and GetCompletedRuns() >= heroData.UnavailableAfterCompletedRuns then
			-- completed too many runs
			--DebugPrint({ Text = "GetEligibleHero - Unavailable: (too many runs) "..tostring(heroKey), LogOnly = true })
		else
			--DebugPrint({ Text = "GetEligibleHero - Available: "..tostring(heroKey), LogOnly = true })
			eligibleHeroes[heroKey] = heroData
		end
	end
	local pickedHero = GetRandomValue( eligibleHeroes )
	return pickedHero
end

function StartNewGame()

	DebugAssert({ Condition = GameState == nil, "Overwriting existing game state!" })

	GameState = {}
	GameState.WeaponHistory = {}
	GameState.WeaponsTouched = {}
	GameState.WeaponsUnlocked = {}
	GameState.RunHistory = {}
	GameState.MetaUpgrades = {}
	GameState.WeaponKills = {}
	GameState.LootPickups = {}
	GameState.TraitsTaken = {}
	GameState.QuestsViewed = {}
	GameState.QuestStatus = {}

	GameState.Cosmetics = {}
	GameState.CosmeticsViewed = {}
	GameState.CosmeticsAdded = {}
	GameState.MusicTracksViewed = {}
	-- Default starting cosmetics
	AddCosmetic( "Cosmetic_DrapesRed" )
	AddCosmetic( "Cosmetic_LaurelsRed" )
	AddCosmetic( "Cosmetic_WallWeaponBident" )
	AddCosmetic( "Cosmetic_SouthHallTrimBrown" )
	AddCosmetic( "Cosmetic_HouseCandles01" )
	AddCosmetic( "/Music/MusicPlayer/MainThemeMusicPlayer" )
	AddCosmetic( "/Music/MusicPlayer/MusicExploration4MusicPlayer" )

	GameState.ScreensViewed = {}

	GameState.NPCInteractions = {}
	GameState.ItemInteractions = {}
	GameState.EnemySpawns = {}
	GameState.EnemyKills = {}
	GameState.EnemyEliteAttributeKills = {}
	GameState.EnemyDamage = {}
	GameState.CompletedObjectiveSets = {}
	GameState.ObjectivesCompleted = {}
	GameState.ObjectivesFailed = {}
	GameState.LastObjectiveCompletedRun = {}
	GameState.LastObjectiveFailedRun = {}
	GameState.HintsShown = {}
	GameState.Resources = {}
	GameState.LifetimeResourcesGained = {}
	GameState.LifetimeResourcesSpent = {}
	GameState.ShrinePointClearsComplete = {}
	GameState.HeardGhostLines = {}
	GameState.KeepsakeChambers = {}
	GameState.ActiveMutators = {}
	GameState.Onslaughts = {}
	GameState.EncountersOccurredCache = {}
	GameState.EncountersCompletedCache = {}
	GameState.RoomCountCache = {}
	GameState.WeaponUnlocks = {}
	GameState.AssistUnlocks = {}
	GameState.LastWeaponUpgradeData = {}
	GameState.RecordClearedShrineThreshold = {}
	GameState.RecordLastClearedShrineReward = {}
	GameState.ClearedWithMetaUpgrades = {}
	GameState.SpeechRecordContexts = {}
	GameState.MetaUpgradesUnlocked = {}
	GameState.MetaUpgradeStagesUnlocked = 0
	GameState.MetaUpgradesSelected = {}
	GameState.MetaUpgradeState = {}

	for metaUpgradeName, metaUpgradeData in pairs( MetaUpgradeData ) do
		if metaUpgradeData.Starting then
			GameState.MetaUpgradesUnlocked[metaUpgradeName] = true
		end
	end
	for k, metaUpgradeChoices  in pairs( MetaUpgradeOrder ) do
		GameState.MetaUpgradesSelected[k] = metaUpgradeChoices[1]
	end

	InitializeGiftData()
	GameState.ReturnedRandomEligibleSourceNames = {}
	GameState.PlayedRandomRunIntroData = {}
	GameState.PlayedRandomRunOutroData = {}
	GameState.Flags = {}
	if GetConfigOptionValue({ Name = "KioskMode" }) then
		GameState.Flags.KioskMode = true
	else
		GameState.Flags.DefaultMode = true
	end
	if GetConfigOptionValue({ Name = "HardMode" }) then
		GameState.Flags.HardMode = true
		for name, amount in pairs( HeroData.DefaultHero.HardModeForcedMetaUpgrades ) do
			GameState.MetaUpgrades[name] = amount
		end
		for name, amount in pairs( HeroData.DefaultHero.HardModeStartingResources ) do
			GameState.Resources[name] = (GameState.Resources[name] or 0) + round( amount )
			--AddResource( name, amount, "HardMode", { Silent = true } )
		end
	end
	GameState.EasyModeLevel = 0

	if CurrentRun == nil then
		StartNewRun()
	end

end

function StartNewRun( prevRun, args )

	SetupRunData()
	ResetUI()

	SessionState.NeedWeaponPickupBinkLoad = false

	CurrentRun = {}
	CurrentRun.DamageRecord = {}
	CurrentRun.HealthRecord = {}
	CurrentRun.ConsumableRecord = {}
	CurrentRun.ActualHealthRecord = {}
	CurrentRun.BlockTimerFlags = {}
	CurrentRun.WeaponsFiredRecord = {}

	if args ~= nil then
		if args.RunOverrides ~= nil then
			for key, value in pairs( args.RunOverrides ) do
				CurrentRun[key] = value
			end
		end
		CurrentRun.ForceNextEncounterData = args.Encounter
	end
	CurrentRun.Hero = CreateNewHero( prevRun, args )

	if prevRun ~= nil and prevRun.BonusDarknessWeapon ~= nil and CurrentRun.Hero.Weapons[prevRun.BonusDarknessWeapon] then
		if GameState.Cosmetics.UnusedWeaponBonusAddGems then
			AddTrait( CurrentRun.Hero, "UnusedWeaponBonusTraitAddGems" )
		else
			AddTrait( CurrentRun.Hero, "UnusedWeaponBonusTrait" )
		end
	end


	EquipKeepsake( CurrentRun.Hero, GameState.LastAwardTrait, { SkipNewTraitHighlight = true })
	EquipAssist( CurrentRun.Hero, GameState.LastAssistTrait, { SkipNewTraitHighlight = true } )
	EquipWeaponUpgrade( CurrentRun.Hero, { SkipTraitHighlight = true } )
	CurrentRun.RoomHistory = {}
	UpdateRunHistoryCache( CurrentRun )
	CheckRunStartFlags( CurrentRun )
	BuildMetaupgradeCache()
	CurrentRun.RoomCreations = {}
	CurrentRun.LootTypeHistory = {}
	CurrentRun.NPCInteractions = {}
	CurrentRun.AnimationState = {}
	CurrentRun.EventState = {}
	CurrentRun.ActivationRecord = {}
	CurrentRun.SpeechRecord = {}
	CurrentRun.TextLinesRecord = {}
	CurrentRun.TriggerRecord = {}
	CurrentRun.UseRecord = {}
	CurrentRun.GiftRecord = {}
	CurrentRun.HintRecord = {}
	CurrentRun.EnemyUpgrades = {}
	CurrentRun.BlockedEncounters = {}
	CurrentRun.InvulnerableFlags = {}
	CurrentRun.PhasingFlags = {}
	CurrentRun.Money = CalculateStartingMoney()
	CurrentRun.MoneySpent = 0
	CurrentRun.MoneyRecord = {}
	CurrentRun.BonusDarknessWeapon = GetRandomUnequippedWeapon()
	CurrentRun.ActiveObjectives = {}
	CurrentRun.RunDepthCache = 1
	CurrentRun.GameplayTime = 0
	CurrentRun.BiomeTime = 0
	CurrentRun.ActiveBiomeTimer = GetNumMetaUpgrades("BiomeSpeedShrineUpgrade") > 0
	CurrentRun.NumRerolls = GetNumMetaUpgrades( "RerollMetaUpgrade" ) + GetNumMetaUpgrades("RerollPanelMetaUpgrade")
	CurrentRun.ThanatosSpawns = 0
	CurrentRun.SupportAINames = {}
	CurrentRun.Hero.TargetMetaRewardsAdjustSpeed = 10.0
	CurrentRun.ClosedDoors = {}
	CurrentRun.CompletedStyxWings = 0
	CurrentRun.TargetShrinePointThreshold = GetCurrentRunClearedShrinePointThreshold( GetEquippedWeapon() )
	CurrentRun.BannedEliteAttributes = {}
	if ConfigOptionCache.EasyMode then
		CurrentRun.EasyModeLevel = GameState.EasyModeLevel
	end
	InitHeroLastStands( CurrentRun.Hero )

	InitializeRewardStores( CurrentRun )
	SelectBannedEliteAttributes( CurrentRun )

	if args ~= nil and args.RoomName ~= nil then
		CurrentRun.CurrentRoom = CreateRoom( RoomData[args.RoomName], args )
	else
		CurrentRun.CurrentRoom = ChooseStartingRoom( CurrentRun, "Tartarus" )
	end

	return CurrentRun

end

function UpdateWeaponHistory(currentRun)
	local eligibleMeleeWeapons = GetEligibleMeleeWeapons()
	for index, weaponData in pairs(eligibleMeleeWeapons) do
		local weaponName = weaponData.Name
		if GameState.WeaponHistory[weaponName] == nil then
			GameState.WeaponHistory[weaponName] = 0
		end

		if currentRun.Hero.Weapons[weaponName] then
			GameState.WeaponHistory[weaponName] = 0
		else
			GameState.WeaponHistory[weaponName] = GameState.WeaponHistory[weaponName] + 1
		end
	end
end

function ChooseStartingRoom( currentRun, roomSetName )

	if GetCompletedRuns() == 0 then
		local forcedStartingRoom = GetMapName({ })
		if forcedStartingRoom ~= nil and forcedStartingRoom ~= "" then
			if RoomData[forcedStartingRoom] == nil then
				forcedStartingRoom = "RoomOpening"
			end
			local startingRoom = CreateRoom( RoomData[forcedStartingRoom] )
			return startingRoom
		end
	end

	local eligibleRooms = {}
	local forcedRooms = {}
	for roomName, roomData in pairs( RoomSetData[roomSetName] ) do
		if roomData.Starting and IsRoomEligible( currentRun, nil, roomData ) then
			table.insert( eligibleRooms, roomData )
			if IsRoomForced( currentRun, nil, roomData ) then
				table.insert( forcedRooms, roomData )
			end
		end
	end

	local startingRoomData = nil
	if not IsEmpty( forcedRooms ) then
		startingRoomData = GetRandomValue( forcedRooms )
	else
		startingRoomData = GetRandomValue( eligibleRooms )
	end

	local startingRoom = CreateRoom( startingRoomData )
	return startingRoom

end

function CreateRoom( roomData, args )
	if args == nil then
		args = {}
	end

	local room = DeepCopyTable( roomData )
	room.SpawnPoints = {}
	room.SpawnPointsUsed = {}
	room.EliteAttributes = {}
	room.VoiceLinesPlayed = {}
	room.TextLinesRecord = {}
	if args.RoomOverrides ~= nil then
		for key, value in pairs( args.RoomOverrides ) do
			room[key] = value
		end
	end
	if not args.SkipChooseEncounter then
		room.Encounter = ChooseEncounter( CurrentRun, room )
		RecordEncounter( CurrentRun, room.Encounter )
	end

	if args.RewardStoreName == nil then

		local roomName = room.GenusName or room.Name
		if room.FirstClearRewardStore ~= nil and IsRoomFirstClearOverShrinePointThreshold( GetEquippedWeapon(), CurrentRun, roomName ) then
			args.RewardStoreName  = room.FirstClearRewardStore
		else
			args.RewardStoreName = room.ForcedRewardStore or "RunProgress"
		end
	end
	if not args.SkipChooseReward then
		room.RewardStoreName = args.RewardStoreName
		room.ChosenRewardType = ChooseRoomReward( CurrentRun, room, args.RewardStoreName, args.PreviouslyChosenRewards )
		SetupRoomReward( CurrentRun, room, args.PreviouslyChosenRewards )
	end

	local secretChance = room.SecretSpawnChance or RoomData.BaseRoom.SecretSpawnChance
	for k, mutator in pairs( GameState.ActiveMutators ) do
		if mutator.SecretSpawnChanceMultiplier ~= nil then
			secretChance = secretChance * mutator.SecretSpawnChanceMultiplier
		end
	end
	room.SecretChanceSuccess =  RandomChance( secretChance )

	local shrinePointDoorChance = room.ShrinePointDoorSpawnChance or RoomData.BaseRoom.ShrinePointDoorSpawnChance
	room.ShrinePointDoorChanceSuccess =  RandomChance( shrinePointDoorChance )

	local challengeChance = room.ChallengeSpawnChance or RoomData.BaseRoom.ChallengeSpawnChance
	for k, mutator in pairs( GameState.ActiveMutators ) do
		if mutator.ChallengeSpawnChanceMultiplier ~= nil then
			challengeChance = challengeChance * mutator.ChallengeSpawnChanceMultiplier
		end
	end
	room.ChallengeChanceSuccess = RandomChance( challengeChance )

	local wellShopChance = room.WellShopSpawnChance or RoomData.BaseRoom.WellShopSpawnChance
	for k, mutator in pairs( GameState.ActiveMutators ) do
		if mutator.ChallengeSpawnChanceMultiplier ~= nil then
			wellShopChance = wellShopChance * mutator.WellShopSpawnChanceMultiplier
		end
	end
	room.WellShopChanceSuccess = RandomChance( wellShopChance )

	local sellTraitShopChance = room.SellTraitShopChance or RoomData.BaseRoom.SellTraitShopChance
	for k, mutator in pairs( GameState.ActiveMutators ) do
		if mutator.ChallengeSpawnChanceMultiplier ~= nil then
			sellTraitShopChance = sellTraitShopChance * mutator.SellTraitShopChanceMultiplier
		end
	end
	room.SellTraitShopChanceSuccess = RandomChance( sellTraitShopChance )

	local fishingPointChance = room.FishingPointChance or RoomData.BaseRoom.FishingPointChance
	for k, mutator in pairs( GameState.ActiveMutators ) do
		if mutator.FishingPointChanceMultiplier ~= nil then
			fishingPointChance = fishingPointChance * mutator.FishingPointChanceMultiplier
		end
	end
	room.FishingPointChanceSuccess =  RandomChance( fishingPointChance + GetTotalHeroTraitValue("FishingPointChanceBonus") )
	if CurrentRun.RoomCreations[room.Name] == nil then
		CurrentRun.RoomCreations[room.Name] = 0
	end
	CurrentRun.RoomCreations[room.Name] = CurrentRun.RoomCreations[room.Name] + 1

	return room
end

function CheckPreviousReward( currentRun, room, previouslyChosenRewards, args )

	if currentRun.CurrentRoom ~= nil then
		if currentRun.CurrentRoom.DeferReward then
			room.UseOptionalOverrides = currentRun.CurrentRoom.UseOptionalOverrides or currentRun.CurrentRoom.UseExitOverrides -- UseExitOverrides is for backwards compatability
			room.ForceLootName = currentRun.CurrentRoom.ForceLootName
		elseif currentRun.CurrentRoom.PersistentExitDoorRewards and args.Door ~= nil then
			for roomIndex = #CurrentRun.RoomHistory, 1, -1 do
				local prevRoom = CurrentRun.RoomHistory[roomIndex]
				if currentRun.CurrentRoom.Name == prevRoom.Name and prevRoom.OfferedRewards ~= nil and prevRoom.OfferedRewards[args.Door.ObjectId] ~= nil then
					room.UseOptionalOverrides = prevRoom.OfferedRewards[args.Door.ObjectId].UseOptionalOverrides or prevRoom.OfferedRewards[args.Door.ObjectId].UseExitOverrides -- UseExitOverrides is for backwards compatability
					room.ForceLootName = prevRoom.OfferedRewards[args.Door.ObjectId].ForceLootName
					return
				end
			end
		end
	end

end

function SetupRoomReward( currentRun, room, previouslyChosenRewards, args )

	args = args or {}

	CheckPreviousReward( currentRun, room, previouslyChosenRewards, args )

	if room.ChosenRewardType == "Boon" and not room.ForceLootName then

		local excludeLootNames = {}
		if previouslyChosenRewards ~= nil then
			for i, data in pairs( previouslyChosenRewards ) do
				if data.RewardType == "Boon" then
					table.insert( excludeLootNames, data.ForceLootName )
				end
			end
		end
		-- Pre-generate specific type
		local lootData = ChooseLoot( excludeLootNames )
		if not args.IgnoreForceLootName then
			for k, trait in pairs( CurrentRun.Hero.Traits ) do
				if trait ~= nil and trait.ForceBoonName ~= nil and trait.Uses > 0 and not Contains(excludeLootNames, trait.ForceBoonName) then
					lootData = { Name = trait.ForceBoonName }
				end
			end
		end
		if lootData == nil then
			room.ForceLootName = ChooseLoot().Name
		else
			room.ForceLootName = lootData.Name
		end
	elseif room.ChosenRewardType == "Devotion" then
		local devotionEncounterName = GetRandomValue(room.DevotionEncounters)
		local encounterData = EncounterData[devotionEncounterName]
		local encounter = SetupEncounter( encounterData )
		room.Encounter = encounter
		RecordEncounter( currentRun, room.Encounter )
		currentRun.LastDevotionDepth = currentRun.RunDepthCache

		room.Encounter.LootAName = GetInteractedGodThisRun()
		for k, trait in pairs( CurrentRun.Hero.Traits ) do
			if trait ~= nil and trait.ForceBoonName ~= nil and trait.Uses > 0 and Contains(GetInteractedGodsThisRun(), trait.ForceBoonName) then
				room.Encounter.LootAName = trait.ForceBoonName
			end
		end
		room.Encounter.LootBName = GetInteractedGodThisRun( room.Encounter.LootAName )
	end
end

function ChooseNextRoomData( currentRun, args )

	args = args or {}

	local currentRoom = currentRun.CurrentRoom
	local roomSetName = currentRun.CurrentRoom.RoomSetName or "Tartarus"
	if args.ForceNextRoomSet ~= nil then
		roomSetName = args.ForceNextRoomSet
	elseif currentRoom.NextRoomSet ~= nil then
		roomSetName = GetRandomValue( currentRoom.NextRoomSet )
	elseif currentRoom.UsePreviousRoomSet then
		local previousRoom = GetPreviousRoom(currentRun) or currentRoom
		roomSetName = previousRoom.RoomSetName or "Tartarus"
	elseif currentRoom.NextRoomSetNoGenerate ~= nil then
		roomSetName = GetRandomValue( currentRoom.NextRoomSetNoGenerate )
	end

	local roomDataSet = args.RoomDataSet or RoomSetData[roomSetName]
	local nextRoomData = nil
	if ForceNextRoom ~= nil and RoomData[ForceNextRoom] ~= nil then
		nextRoomData = RoomData[ForceNextRoom]
	elseif args.ForceNextRoom ~= nil and RoomData[args.ForceNextRoom] ~= nil then
		nextRoomData = RoomData[args.ForceNextRoom]
	elseif currentRoom.LinkedRoom ~= nil or currentRoom.LinkedRooms ~= nil or currentRoom.LinkedRoomByPactLevel then
		local nextRoomName = currentRoom.LinkedRoom
		if currentRoom.LinkedRooms ~= nil then
			local eligibleRoomNames = {}
			local forcedRoomNames = {}
			for i, linkedRoomName in ipairs( CollapseTableOrdered( currentRoom.LinkedRooms ) ) do
				if IsRoomEligible( currentRun, currentRoom, roomDataSet[linkedRoomName], args ) then
					table.insert( eligibleRoomNames, linkedRoomName )
					if IsRoomForced( currentRun, currentRoom, roomDataSet[linkedRoomName], args ) then
						table.insert( forcedRoomNames, linkedRoomName )
					end
				end
			end
			if not IsEmpty( forcedRoomNames ) then
				nextRoomName = GetRandomValue( forcedRoomNames )
			else
				nextRoomName = GetRandomValue( eligibleRoomNames )
			end
		elseif currentRoom.LinkedRoomByPactLevel then
			local shrineLevel = GetNumMetaUpgrades( currentRoom.ShrineMetaUpgradeName )
			nextRoomName = currentRoom.LinkedRoomByPactLevel[shrineLevel]
		end

		if nextRoomName ~= nil then
			nextRoomData = roomDataSet[nextRoomName]
		end
	end

	if nextRoomData == nil then
		local eligibleRooms = {}
		local forcedRooms = {}
		for i, kvp in ipairs( CollapseTableAsOrderedKeyValuePairs( roomDataSet ) ) do
			local roomName = kvp.Key
			local roomData = kvp.Value
			if IsRoomEligible( currentRun, currentRoom, roomData, args ) then
				table.insert( eligibleRooms, roomData )
				if IsRoomForced( currentRun, currentRoom, roomData, args ) then
					table.insert( forcedRooms, roomData )
				end
			end
		end
		if not IsEmpty( forcedRooms ) then
			nextRoomData = GetRandomValue( forcedRooms )
		else
			nextRoomData = GetRandomValue( eligibleRooms )
		end
	end

	DebugAssert({ Condition = nextRoomData ~= nil, Text = "No eligible rooms for exit door!"  })
	return nextRoomData

end

function IsRoomForced( currentRun, currentRoom, nextRoomData, args )
	if nextRoomData.AlwaysForce then
		return true
	end

	if nextRoomData.ForceIfEncounterNotCompleted ~= nil and not HasEncounterBeenCompleted( nextRoomData.ForceIfEncounterNotCompleted ) then
		return true
	end

	if nextRoomData.ForceIfUnseenForRuns ~= nil and not HasSeenRoomInNumRuns( nextRoomData.Name, nextRoomData.ForceIfUnseenForRuns ) then
		DebugPrint({ Text = "Forcing = "..nextRoomData.Name })
		return true
	end

	args = args or{}

	local depthSkip = args.RoomsSkipped or 0
	local currentRunDepth = currentRun.RunDepthCache + depthSkip
	if nextRoomData.ForceAtRunDepth ~= nil and currentRunDepth == nextRoomData.ForceAtRunDepth then
		return true
	end
	if nextRoomData.ForceAtRunDepthMin ~= nil and currentRunDepth >= nextRoomData.ForceAtRunDepthMin then
		if currentRunDepth >= nextRoomData.ForceAtRunDepthMax then
			return true
		else
			local forcedChance = 1 / (nextRoomData.ForceAtRunDepthMax - currentRunDepth)
			if RandomChance( forcedChance ) then
				return true
			end
		end
	end
	local currentBiomeDepth = currentRun.BiomeDepthCache + depthSkip
	if nextRoomData.ForceAtBiomeDepth ~= nil and currentBiomeDepth == nextRoomData.ForceAtBiomeDepth then
		return true
	end
	if nextRoomData.ForceAtBiomeDepthMin ~= nil and currentBiomeDepth >= nextRoomData.ForceAtBiomeDepthMin then
		if currentBiomeDepth >= nextRoomData.ForceAtBiomeDepthMax then
			return true
		else
			local forcedChance = 1 / (nextRoomData.ForceAtBiomeDepthMax - currentBiomeDepth)
			if RandomChance( forcedChance ) then
				return true
			end
		end
	end

	if currentRoom ~= nil and currentRoom.ForceWingEndMiniBoss and nextRoomData.WingEndMiniBoss and (currentRun.CompletedStyxWings < 4 or HasSeenRoomInRun(currentRun, "D_Reprieve01")) then
		return true
	end

	if nextRoomData.ForceChanceByRemainingWings then
		local chance = 1 / (5 - currentRun.CompletedStyxWings)
		if RandomChance(chance) then
			return true
		end
	end

	return false

end

function IsRoomEligible( currentRun, currentRoom, nextRoomData, args )
	if args == nil then
		args = {}
	end

	if nextRoomData == nil then
		return false
	end

	local excludedNames = args.ExcludedNames
	local excludedTypes = args.ExcludedTypes
	local excludedRewards = args.ExcludedRewards
	local roomsSkipped = args.DepthSkip or 0

	if nextRoomData.DebugOnly then
		return false
	end

	if excludedNames ~= nil and excludedNames[nextRoomData.Name] then
		return false
	end

	if excludedTypes ~= nil and excludedTypes[nextRoomData.Type] then
		return false
	end

	if excludedRewards ~= nil and not IsEmpty(nextRoomData.RewardTypes) and ContainsAll(excludedRewards, nextRoomData.RewardTypes) then
		return false
	end

	if nextRoomData.ForceAtBiomeDepth ~= nil and currentRun.BiomeDepthCache ~= nextRoomData.ForceAtBiomeDepth then
		return false
	end
	if nextRoomData.ForceAtBiomeDepthMin ~= nil and currentRun.BiomeDepthCache < nextRoomData.ForceAtBiomeDepthMin then
		return false
	end

	if currentRoom ~= nil then
		if nextRoomData.Name == currentRoom.Name then
			return false
		end
		if nextRoomData.Starting and not currentRoom.AllowNextRoomStarting then
			return false
		end
		if nextRoomData.RequiresLinked then
			if currentRoom.LinkedRoom ~= nextRoomData.Name and ( currentRoom.LinkedRooms == nil or not Contains( currentRoom.LinkedRooms, nextRoomData.Name ) ) then
				return false
			end
		end

		-- If in a MiniBoss wing and we are not a MiniBoss, we are ineligible (except Reprieve)
		if currentRoom.RequireWingEndMiniBoss and nextRoomData.WingEndRoom and not nextRoomData.WingEndMiniBoss and not nextRoomData.AllowAsAnyWingEnd then
			return false
		end

		-- If in a regular wing and we are a MiniBoss room, we are ineligible (except Reprieve)
		if not currentRoom.RequireWingEndMiniBoss and nextRoomData.WingEndRoom and nextRoomData.WingEndMiniBoss and not nextRoomData.AllowAsAnyWingEnd then
			return false
		end
	end

	if nextRoomData.MaxAppearancesThisRun ~= nil and currentRun.RoomCountCache[nextRoomData.Name] ~= nil and currentRun.RoomCountCache[nextRoomData.Name] >= nextRoomData.MaxAppearancesThisRun then
		return false
	end
	if nextRoomData.MaxAppearancesThisBiome ~= nil and currentRun.BiomeRoomCountCache[nextRoomData.Name] ~= nil and currentRun.BiomeRoomCountCache[nextRoomData.Name] >= nextRoomData.MaxAppearancesThisBiome then
		return false
	end

	if nextRoomData.MaxCreationsThisRun ~= nil and currentRun.RoomCreations[nextRoomData.Name] ~= nil and currentRun.RoomCreations[nextRoomData.Name] >= nextRoomData.MaxCreationsThisRun then
		return false
	end

	if not IsGameStateEligible( currentRun, nextRoomData , nextRoomData.GameStateRequirements, args) then
		return false
	end
	return true

end

function GetNumRoomAppearances( roomHistory, nextRoomData )
	if roomHistory == nil then
		return 0
	end

	local numAppearances = 0
	for roomOrder, roomData in pairs( roomHistory ) do
		if roomData.Name == nextRoomData.Name then
			numAppearances = numAppearances + 1
		end
	end
	return numAppearances
end

function ChooseEncounter( currentRun, room )

	DebugAssert({ Condition = room ~= nil, Text = "Choosing an encounter for a nil room!" })

	local encounterData = nil
	if ForceNextEncounter ~= nil then
		DebugPrint({ Text = "ForceNextEncounter = "..tostring(ForceNextEncounter) })
		encounterData = EncounterData[ForceNextEncounter]
		encounterData.SkipIntroEncounterCheck = true
		ForceNextEncounter = nil
	elseif currentRun.ForceNextEncounterData ~= nil then
		encounterData = currentRun.ForceNextEncounterData
	elseif HasHeroTraitValue( "ForceThanatosEncounter" ) then
		local legalEncounters = {}
		for i, encounterName in pairs( EncounterSets.ThanatosEncounters ) do
			if IsEncounterEligible( currentRun, room, EncounterData[encounterName] ) then
				table.insert(legalEncounters, encounterName )
			end
		end
		if not IsEmpty( legalEncounters ) then
			UseHeroTraitsWithValue( "ForceThanatosEncounter", true )
			encounterData = EncounterData[legalEncounters[1]]
		end
	end

	if not encounterData then
		local eligibleEncounters = {}
		local forcedEncounters = {}
		if room.LegalEncounters ~= nil then
			for k, encounterName in pairs( room.LegalEncounters ) do
				local encounterData = EncounterData[encounterName]
				if IsEncounterEligible( currentRun, room, encounterData ) then
					table.insert( eligibleEncounters, encounterData )
					if IsEncounterForced( currentRun, room, encounterData ) then
						table.insert( forcedEncounters, encounterData )
					end
				end
			end
		else
			for encounterName, encounterData in pairs( EncounterData ) do
				if IsEncounterEligible( currentRun, room, encounterData ) then
					table.insert( eligibleEncounters, encounterData )
					if IsEncounterForced( currentRun, room, encounterData ) then
						table.insert( forcedEncounters, encounterData )
					end
				end
			end
		end

		local roomName = room.Name
		if roomName == nil then
			roomName = GetKey(RoomData, room)
		end

		if roomName == nil then
			roomName = tostring(room.HelpTextId)..":"..tostring(room.Type)..":"..tostring(room.LegalEncounters[1])
		end

		DebugAssert({ Condition = not IsEmpty( eligibleEncounters ) or not IsEmpty(forcedEncounters), Text = "No encounters available for "..tostring(roomName).."!" })

		if not IsEmpty( forcedEncounters ) then
			encounterData = GetRandomValue( forcedEncounters )
		else
			encounterData = GetRandomValue( eligibleEncounters )
		end

		if encounterData.EnemySet ~= nil then
			for k, enemyName in pairs(encounterData.EnemySet) do
				if EnemyData[enemyName].ForceIntroduction and not HasEncounterBeenCompleted(EnemyData[enemyName].RequiredIntroEncounter) then
					encounterData = EncounterData[EnemyData[enemyName].RequiredIntroEncounter]
				end
			end
		end
	end

	local encounter = SetupEncounter(encounterData, room)

	return encounter

end

function SetupEncounter( encounterData, room )
	local encounter = DeepCopyTable( encounterData )

	room = room or CurrentRun.CurrentRoom
	if room.RewardOverrides ~= nil and room.RewardOverrides.MakeHardEncounter then
		encounter.IsHardEncounter = true
	end

	if encounter.Generated then
		GenerateEncounter(CurrentRun, room, encounter)
	end

	-- Check if enemies need to be introduced
	if encounter ~= nil and encounter.SpawnWaves ~= nil and not encounter.SkipIntroEncounterCheck then
		for k, wave in pairs(encounter.SpawnWaves) do
			for k, spawnData in pairs(wave.Spawns) do
				local requiredIntroEncounterName = EnemyData[spawnData.Name].RequiredIntroEncounter
				if requiredIntroEncounterName ~= nil and not HasEncounterBeenCompleted(requiredIntroEncounterName) and IsGameStateEligible( CurrentRun, EncounterData[requiredIntroEncounterName] ) then
					encounter = DeepCopyTable(EncounterData[requiredIntroEncounterName])
					if encounter.Generated then
						GenerateEncounter(CurrentRun, room, encounter)
					end
				end
			end
		end
	end

	return encounter
end

function ChooseChallengeEncounter( room )

	DebugAssert({ Condition = room ~= nil, Text = "Choosing a challenge for a nil room." })

	local encounterName = room.ChallengeEncounterName
	DebugAssert({ Condition = encounterName ~= nil, Text = "Room has no ChallengeEncounterName set." })
	local encounter = DeepCopyTable( EncounterData[encounterName] )

	if encounter.Generated then
		GenerateEncounter(CurrentRun, room, encounter)
	end

	return encounter
end

function SetupShrineChallengeEnemySet( encounter )
	local enemySetPrefix = "ShrineChallenge"
	encounter.EnemySet = {}

	local spawnOptionsSuperElite = ShallowCopyTable(EnemySets[enemySetPrefix.."SuperElite"])
	local spawnOptionsFodder = ShallowCopyTable(EnemySets[enemySetPrefix.."Fodder"])

	local enemiesAdded = 0

	while not IsEmpty(spawnOptionsSuperElite) do
		local newSpawnOption = RemoveRandomValue(spawnOptionsSuperElite)
		if IsEnemyEligible(newSpawnOption, encounter, nil) then
			table.insert(encounter.EnemySet, newSpawnOption)
			enemiesAdded = enemiesAdded + 1
			break
		end
	end

	while enemiesAdded < encounter.MaxTypes and not IsEmpty(spawnOptionsFodder) do
		newSpawnOption = RemoveRandomValue(spawnOptionsFodder)
		if IsEnemyEligible(newSpawnOption, encounter, nil) then
			table.insert(encounter.EnemySet, newSpawnOption)
			enemiesAdded = enemiesAdded + 1
		end
	end
end

function GenerateEncounter( currentRun, room, encounter )
	if encounter.IsHardEncounter and encounter.HardEncounterOverrideValues then
		DebugPrint({ Text = "Overwriting for hard encounter" })
		OverwriteTableKeys(encounter, encounter.HardEncounterOverrideValues)
	end

	if encounter.UseRoomEncounterEnemySet then
		encounter.EnemySet = room.Encounter.EnemySet
	end

	-- Encounter Difficulty
	local depthDifficultyRamp = encounter.DepthDifficultyRamp or 0.45
	local difficultyModifer = encounter.DifficultyModifier or 0

	-- resources
	local metaPointStoreRamp = encounter.MetaPointStoreRamp or 0
	encounter.MetaPointStore = math.ceil( currentRun.RunDepthCache * metaPointStoreRamp * GetTotalHeroTraitValue("RoomMetaPointMultiplier", { IsMultiplier = true }))

	local moneyDropStoreRamp = encounter.MoneyDropCapDepthRamp or 0
	encounter.MoneyDropStore = ( RandomInt( encounter.MoneyDropCapMin, encounter.MoneyDropCapMax ) + currentRun.RunDepthCache * moneyDropStoreRamp ) or 0
	DebugPrint({ Text = "Encounter Money Store Cap: "..tostring( encounter.MoneyDropStore ) })

	local baseDifficulty = encounter.BaseDifficulty or EncounterData.Generated.BaseDifficulty
	if encounter.BaseDifficultyMin ~= nil and encounter.BaseDifficultyMax ~= nil then
		baseDifficulty = RandomInt(encounter.BaseDifficultyMin, encounter.BaseDifficultyMax)
	end
	local depthMultiplier = currentRun.BiomeDepthCache
	if encounter.UseRunDepth then
		depthMultiplier = currentRun.RunDepthCache
	end
	encounter.DifficultyRating = baseDifficulty + depthMultiplier * depthDifficultyRamp + difficultyModifer
	if encounter.DifficultyRatingShrineModifierName then
		local modifierName = encounter.DifficultyRatingShrineModifierName
		encounter.DifficultyRating = encounter.DifficultyRating * (GetNumMetaUpgrades(modifierName) * MetaUpgradeData[modifierName].ChangeValue )
	else
		encounter.DifficultyRating = encounter.DifficultyRating * (1 + GetNumMetaUpgrades("EnemyCountShrineUpgrade") * (MetaUpgradeData.EnemyCountShrineUpgrade.ChangeValue - 1 ) )
	end

	local minDifficulty = encounter.MinimumDifficulty or ConstantsData.MinimumDifficulty
	encounter.DifficultyRating = math.max( minDifficulty, encounter.DifficultyRating )

	encounter.ActiveEnemyCap = CalculateActiveEnemyCap( currentRun, room, encounter )
	encounter.Blacklist = encounter.Blacklist or {}

	if encounter.BuildCustomEnemySet ~= nil then
		local customEnemySetFunction = _G[encounter.BuildCustomEnemySet]
		customEnemySetFunction( encounter )
	end

	-- Wave Count
	local minWaves = encounter.MinWaves or 1
	local maxWaves = encounter.MaxWaves or 1
	local waveCount = RandomInt(minWaves, maxWaves)
	encounter.WaveCount = waveCount

	-- Wave Setup
	local preExistingWaves = 0
	encounter.SpawnWaves = encounter.SpawnWaves or {}
	for waveIndex=1, waveCount do
		if encounter.SpawnWaves[waveIndex] == nil then
			local waveTemplate = encounter.WaveTemplate
			if encounter.ManualWaveTemplates ~= nil and encounter.ManualWaveTemplates[waveIndex] ~= nil then
				waveTemplate = encounter.ManualWaveTemplates[waveIndex]
			elseif encounter.ManualWaveTemplates ~= nil and encounter.ManualWaveTemplates[-1 * (waveCount - waveIndex)] then
				waveTemplate = encounter.ManualWaveTemplates[-1 * (waveCount - waveIndex)]
			end
			encounter.SpawnWaves[waveIndex] = DeepCopyTable(waveTemplate)
			local wave = encounter.SpawnWaves[waveIndex]
			wave.WaveIndex = waveIndex

			if encounter.NoFirstWaveStartDelay and waveIndex == 1 then
				wave.StartDelay = 0
				wave.OverrideValues = nil
			end

			if waveTemplate.AddAtTime ~= nil then
				wave.AddAtTime = encounter.TimeLimit - (encounter.AddAtTimeInterval * (waveIndex - 1))
			end

			-- Wave Difficulty
			wave.DifficultyRating = WaveDifficultyPatterns[waveCount][waveIndex] * encounter.DifficultyRating
		else
			local wave = encounter.SpawnWaves[waveIndex]
			wave.WaveIndex = waveIndex
			wave.DifficultyRating = WaveDifficultyPatterns[waveCount][waveIndex] * encounter.DifficultyRating
			preExistingWaves = preExistingWaves + 1
		end
	end

	local requireCompletedIntro = encounter.RequireCompletedIntro
	local minDepthBeforeIntros = RoomData.BaseRoom.MinDepthBeforeIntros
	if room ~= nil then
		minDepthBeforeIntros = room.MinDepthBeforeIntros or RoomData.BaseRoom.MinDepthBeforeIntros
	end
	if GetBiomeDepth(CurrentRun) < minDepthBeforeIntros then
		requireCompletedIntro = true
	end


	if not encounter.BlockHighlightEncounter and preExistingWaves == 0 and waveCount > 1 and encounter.EncounterType ~= "SurvivalChallenge" then
		-- Highlight Encounter - Pick an enemy as the highlight in each wave
		DebugPrint({ Text = "Generating Highlght Encounter" })
		local eligibleEnemies = {}
		encounter.SpawnWaves[1].TypeCount = 1
		encounter.SpawnWaves[1].BlockEliteTypes = encounter.BlockHighlightEliteTypes
		for k, enemyName in pairs( encounter.EnemySet ) do
			if IsEnemyEligible(enemyName, encounter, encounter.SpawnWaves[1]) then
				table.insert(eligibleEnemies, enemyName)
			end
		end

		if IsEmpty( eligibleEnemies ) then
			DebugAssert({ Condition = true, Text = "No eligible enemies to highlight!" })
		else
			local highlightEnemy = RemoveRandomValue(eligibleEnemies)
			if EnemyData[highlightEnemy].EnemySightedVoiceLines ~= nil then
				encounter.DistanceTriggers = encounter.DistanceTriggers or {}
				table.insert(encounter.DistanceTriggers,
					{
						Name = highlightEnemy.."SightedVoiceLines",
						TriggerGroups = { "GroundEnemies", "FlyingEnemies" },
						WithinDistance = 700,
						VoiceLines = EnemyData[highlightEnemy].EnemySightedVoiceLines
					}
				)
			end

			encounter.Blacklist[highlightEnemy] = true
			local waveTypeCount = 1
			for waveNum, wave in ipairs(encounter.SpawnWaves) do
				AddToSpawnTable(wave.Spawns, highlightEnemy)
				local encounterMaxTypes = math.floor(encounter.MaxTypes + (encounter.TypeCountDepthRamp * GetBiomeDepth(CurrentRun)))
				wave.TypeCount = math.min(waveTypeCount, encounterMaxTypes)
				waveTypeCount = waveTypeCount + 1

				wave.RequireCompletedIntro = wave.requireCompletedIntro or requireCompletedIntro
				FillEnemyTypes(encounter, wave, room)
				FillEnemyCounts(encounter, wave, room)
			end
		end
	else
		-- Family Encounter
		DebugPrint({ Text = "Generating Family Encounter" })
		for waveNum, wave in pairs(encounter.SpawnWaves) do
			if waveNum > preExistingWaves then
				wave.RequireCompletedIntro = wave.requireCompletedIntro or requireCompletedIntro
				FillEnemyTypes(encounter, wave, room)
				FillEnemyCounts(encounter, wave, room)
			end
		end
	end
end

function FillEnemyTypes( encounter, wave, room )
	local spawnTable = wave.Spawns
	local requireCompletedIntro = wave.RequireCompletedIntro

	local typeCountDepthRamp = encounter.TypeCountDepthRamp or 0
	local minTypes = wave.MinTypes or encounter.MinTypes
	local maxTypes = wave.MaxTypes or math.floor(encounter.MaxTypes + (typeCountDepthRamp * GetBiomeDepth(CurrentRun)))
	local enemyTypeCount = wave.TypeCount or RandomInt(minTypes, maxTypes)
	if enemyTypeCount > encounter.MaxTypesCap then
		enemyTypeCount = encounter.MaxTypesCap
	end
	encounter.TypeCount = enemyTypeCount

	local eligibleEnemies = {}
	for k, enemyName in pairs( encounter.EnemySet ) do
		if IsEnemyEligible(enemyName, encounter, wave) then
			table.insert(eligibleEnemies, enemyName)
		end
	end

	local removeIndexes = {}
	local eliteCapReached = false
	local eliteTypeCount = 0
	for index, spawnData in pairs( spawnTable ) do
		if spawnData.RequiredMetaUpgrade ~= nil and GetNumMetaUpgrades(spawnData.RequiredMetaUpgrade) == 0 then
			table.insert(removeIndexes, index)
		end
		if spawnData.Name and EnemyData[spawnData.Name] and EnemyData[spawnData.Name].IsElite then
			eliteTypeCount = eliteTypeCount + 1
		end
	end
	for k, index in pairs(removeIndexes) do
		table.remove(spawnTable, index)
	end
	CollapseTable(spawnTable)

	if encounter.MaxEliteTypes ~= nil and eliteTypeCount >= encounter.MaxEliteTypes then
		eliteCapReached = true
		for k, spawnName in pairs(eligibleEnemies) do
			if EnemyData[spawnName].IsElite then
				RemoveValue(eligibleEnemies, spawnName)
			end
		end
	end

	local typesToAdd = enemyTypeCount - TableLength(spawnTable)
	DebugPrint({ Text=enemyTypeCount })

	-- Make sure there are enough enemy types to choose from
	local eligibleEnemiesCount = TableLength(eligibleEnemies)
	DebugAssert({ Condition = eligibleEnemiesCount > 0, Text = "No eligible enemies. Did you direct load this map?" })
	if eligibleEnemiesCount < typesToAdd then
		typesToAdd = eligibleEnemiesCount
		DebugPrint({ Text = "Not enough eligible enemies. Reducing type count." })
	end

	for index, spawnData in ipairs( spawnTable ) do
		if spawnData.Generated and spawnData.Name == nil then
			if spawnData.EnemySet ~= nil then
				local uniqueEligibleEnemies = {}
				for k, enemyName in pairs( spawnData.EnemySet ) do
					if IsEnemyEligible(enemyName, encounter, wave) then
						table.insert(uniqueEligibleEnemies, enemyName)
					end
				end
				local newTypeName = RemoveRandomValue(uniqueEligibleEnemies)
				spawnData.Name = newTypeName
			else
				local newTypeName = RemoveRandomValue(eligibleEnemies)
				spawnData.Name = newTypeName
			end
		end
		--[[if EnemyData[spawnData.Name].IsElite and room.EliteAttributes[spawnData.Name] == nil then
			PickEliteAttributes( room, EnemyData[spawnData.Name] )
		end]]
	end

	for i=1, typesToAdd do
		local newTypeName = RemoveRandomValue(eligibleEnemies)
		if newTypeName == nil then
			return
		end
		AddToSpawnTable(spawnTable, newTypeName)
		--[[if EnemyData[newTypeName].IsElite and room.EliteAttributes[newTypeName] == nil then
			PickEliteAttributes( room, EnemyData[newTypeName] )
		end]]
		RemoveAllValues(eligibleEnemies, newTypeName)

		if not eliteCapReached and encounter.MaxEliteTypes ~= nil then
			eliteTypeCount = 0
			for k, spawnData in pairs(spawnTable) do
				if EnemyData[spawnData.Name].IsElite then
					eliteTypeCount = eliteTypeCount + 1
				end
			end

			if eliteTypeCount >= encounter.MaxEliteTypes then
				eliteCapReached = true
				for k, spawnName in pairs(eligibleEnemies) do
					if EnemyData[spawnName].IsElite then
						RemoveValue(eligibleEnemies, spawnName)
					end
				end
			end
		end

		if EnemyData[newTypeName].GeneratorData ~= nil and EnemyData[newTypeName].GeneratorData.BlockEnemyTypes ~= nil then
			for k, enemyType in pairs(EnemyData[newTypeName].GeneratorData.BlockEnemyTypes) do
				RemoveAllValues(eligibleEnemies, enemyType)
				if encounter.BlockTypesAcrossWaves then
					encounter.Blacklist[enemyType] = true
				end
			end
		end

		if encounter.EncounterType == "SurvivalChallenge" then
			if EnemyData[newTypeName].GeneratorData ~= nil and EnemyData[newTypeName].GeneratorData.BlockEnemyTypesSurvival ~= nil then
				for k, enemyType in pairs(EnemyData[newTypeName].GeneratorData.BlockEnemyTypesSurvival) do
					RemoveAllValues(eligibleEnemies, enemyType)
					if encounter.BlockTypesAcrossWaves then
						encounter.Blacklist[enemyType] = true
					end
				end
			end
		end
	end
end

function AddToSpawnTable(spawnTable, newTypeName)
	local newTypeData = { Name = newTypeName, Generated = true }
	table.insert(spawnTable, newTypeData)
end

function CalculateEnemyDifficultyRating( enemyName, room )
	local difficultyRating = EnemyData[enemyName].GeneratorData.DifficultyRating

	if EnemyData[enemyName].IsElite and room.EliteAttributes[enemyName] ~= nil then
		local difficultyRatingMultiplier = 1
		for k, attributeName in pairs(room.EliteAttributes[enemyName]) do
			if EnemyData[enemyName].EliteAttributeData[attributeName].DifficultyRatingMultiplier ~= nil then
				difficultyRatingMultiplier = difficultyRatingMultiplier + EnemyData[enemyName].EliteAttributeData[attributeName].DifficultyRatingMultiplier - 1
			end
		end
		difficultyRating = difficultyRating * difficultyRatingMultiplier
	end

	return difficultyRating

end

function FillEnemyCounts( encounter, wave, room )
	local spawnTable = wave.Spawns

	if encounter.InfiniteSpawns then
		for k, spawnData in ipairs( spawnTable ) do
			if spawnData.Generated or spawnData.CountMin == nil and spawnData.CountMax == nil and spawnData.TotalCount == nil then
				spawnData.InfiniteSpawns = true
			end
		end
		return
	end

	local accumulatedDifficulty = 0
	local generateCount = 0

	for k, spawnData in ipairs( spawnTable ) do
		DebugAssert({ Condition = spawnData.Name ~= nil, Text = "Enemy spawn  is nil. Probably did not have any eligible enemies (because of direct load?)." })

		-- Calculate how much difficulty the pre-made spawns have
		if not spawnData.Generated and ((spawnData.CountMin ~= nil and spawnData.CountMax ~= nil) or spawnData.TotalCount ~= nil) then
			local count = spawnData.TotalCount or spawnData.CountMax
			accumulatedDifficulty = accumulatedDifficulty + (CalculateEnemyDifficultyRating(spawnData.Name, room) * count)
		else
			spawnData.Generated = true
			spawnData.GeneratorData = EnemyData[spawnData.Name].GeneratorData
			generateCount = generateCount + 1
		end
	end

	-- Allot each enemy type their piece of the difficulty pie
	for typesGenerated, spawnData in ipairs( spawnTable ) do
		if spawnData.Generated and spawnData.TotalCount == nil then
			spawnData.TotalCount = 0
			local remainingDifficulty = wave.DifficultyRating - accumulatedDifficulty
			local difficultySlice = 0

			if typesGenerated == generateCount then
				if remainingDifficulty < 0 then
					remainingDifficulty = 0
				end

				difficultySlice = remainingDifficulty
			else
				local mean = wave.DifficultyRating/generateCount
				local stddev = mean / 3
				difficultySlice = RandomNormal(mean, stddev)

				if difficultySlice > remainingDifficulty then
					difficultySlice = remainingDifficulty
				end
				-- Spawn a minimum of one of each enemy type
				if difficultySlice < spawnData.GeneratorData.DifficultyRating then
					difficultySlice = spawnData.GeneratorData.DifficultyRating
				end
			end

			local allowedCount = math.ceil(difficultySlice / spawnData.GeneratorData.DifficultyRating)

			-- Dont go over a types individual maximum
			if spawnData.GeneratorData.MaxCount ~= nil and allowedCount > spawnData.GeneratorData.MaxCount then
				allowedCount = spawnData.GeneratorData.MaxCount
			end

			if allowedCount < 0 then
				allowedCount = 0
			end

			spawnData.TotalCount = spawnData.TotalCount + allowedCount

			local typeDifficulty = CalculateEnemyDifficultyRating(spawnData.Name, room) * allowedCount
			accumulatedDifficulty = accumulatedDifficulty + typeDifficulty
		end
	end
end

function IsEnemyEligible( enemyName, encounter, wave )
	if EnemyData[enemyName].IneligibleIfUncompletedIntroEncounter and EnemyData[enemyName].RequiredIntroEncounter ~= nil and not HasEncounterBeenCompleted(EnemyData[enemyName].RequiredIntroEncounter) then
		return false
	end
	if wave ~= nil and wave.RequireCompletedIntro and EnemyData[enemyName].RequiredIntroEncounter ~= nil and not HasEncounterBeenCompleted(EnemyData[enemyName].RequiredIntroEncounter) then
		return false
	end

	if wave ~= nil and wave.BlockEliteTypes	and EnemyData[enemyName	].IsElite then
		return false
	end

	if encounter.Blacklist ~= nil and encounter.Blacklist[enemyName] then
		return false
	end

	for k, mutator in pairs( GameState.ActiveMutators ) do
		if mutator.RemoveEnemies ~= nil then
			if Contains( mutator.RemoveEnemies, enemyName ) then
				return false
			end
		end
	end

	for i, traitValue in pairs( GetHeroTraitValues( "BlockedEnemyTypes" )) do
		if Contains( traitValue, enemyName ) then
			return false
		end
	end


	if wave ~= nil then
		if wave.TypeCount == 1 and EnemyData[enemyName].GeneratorData.BlockSolo then
			return false
		end

		local eliteTypeCount = 0
		for k, spawnData in pairs(wave.Spawns) do
			if spawnData.Name ~= nil and enemyName == spawnData.Name then
				return false
			end

			if spawnData.Name ~= nil and EnemyData[spawnData.Name].IsElite then
				eliteTypeCount = eliteTypeCount + 1
			end

			if spawnData.Name ~= nil and EnemyData[spawnData.Name].GeneratorData ~= nil and EnemyData[spawnData.Name].GeneratorData.BlockEnemyTypes ~= nil then
				for k, enemyType in pairs(EnemyData[spawnData.Name].GeneratorData.BlockEnemyTypes) do
					if enemyType == enemyName then
						return false
					end
				end
			end
		end

		if encounter.MinEliteTypes ~= nil and eliteTypeCount < encounter.MinEliteTypes and not EnemyData[enemyName].IsElite then
			if encounter.WaveCount - wave.WaveIndex <= encounter.MinEliteTypes - eliteTypeCount then
				return false
			end
		end

		if encounter.MaxEliteTypes ~= nil and eliteTypeCount >= encounter.MaxEliteTypes and EnemyData[enemyName].IsElite then
			return false
		end
	end

	local isGameStateEligibleArgs = {}
	if EnemyData[enemyName].IsElite and GetNumMetaUpgrades("EnemyEliteShrineUpgrade") > 0 then
		isGameStateEligibleArgs.SkipMinBiomeDepth = true
	end
	if not IsGameStateEligible(CurrentRun, EnemyData[enemyName], EnemyData[enemyName], isGameStateEligibleArgs ) then
		return false
	end

	return true
end

function IsEncounterForced( currentRun, room, nextEncounterData )

	if nextEncounterData.AlwaysForce then
		return true
	end

	if nextEncounterData.ForceIfEncounterNotCompleted ~= nil and not HasEncounterBeenCompleted( nextEncounterData.ForceIfEncounterNotCompleted ) then
		return true
	end

	return false

end

function IsEncounterEligible( currentRun, room, nextEncounterData )
	if room.LegalEncounters ~= nil and not room.LegalEncountersDictionary[nextEncounterData.Name] then
		return false
	end

	if room.IllegalEncounters ~= nil and room.IllegalEncountersDictionary[nextEncounterData.Name] then
		return false
	end

	if nextEncounterData.MaxAppearancesThisRun ~= nil and currentRun.EncountersOccurredCache[nextEncounterData.Name] ~= nil and currentRun.EncountersOccurredCache[nextEncounterData.Name] >= nextEncounterData.MaxAppearancesThisRun then
		return false
	end
	if nextEncounterData.MaxAppearancesThisBiome ~= nil and currentRun.EncountersOccurredBiomeCache[nextEncounterData.Name] ~= nil and currentRun.EncountersOccurredBiomeCache[nextEncounterData.Name] >= nextEncounterData.MaxAppearancesThisBiome then
		return false
	end

	if nextEncounterData.MinRoomsBetweenType ~= nil and currentRun.EncountersDepthCache[nextEncounterData.Name] ~= nil then
		local roomsSinceType = currentRun.RunDepthCache - currentRun.EncountersDepthCache[nextEncounterData.Name]
		if roomsSinceType < nextEncounterData.MinRoomsBetweenType then
			return false
		end
	end

	if nextEncounterData.MinRunsSinceThanatosSpawn ~= nil then
		--DebugPrint({ Text = "nextEncounterData.MinRunsSinceThanatosSpawn = "..nextEncounterData.MinRunsSinceThanatosSpawn })
		local runsSinceOccurred = 0
		for runIndex = #GameState.RunHistory + 1, 1, -1 do
			local prevRun = GameState.RunHistory[runIndex] or currentRun
			if prevRun.ThanatosSpawns ~= nil and prevRun.ThanatosSpawns > 0 then
				if runsSinceOccurred < nextEncounterData.MinRunsSinceThanatosSpawn then
					--DebugPrint({ Text = "runsSinceOccurred = "..runsSinceOccurred })
					return false
				end
			end
			runsSinceOccurred = runsSinceOccurred + 1
			if runsSinceOccurred > nextEncounterData.MinRunsSinceThanatosSpawn then
				--DebugPrint({ Text = "runsSinceOccurred = "..runsSinceOccurred })
				break
			end
		end
	end

	if currentRun.BlockedEncounters[nextEncounterData.Name] then
		return false
	end

	if nextEncounterData.BlockedByPreviousEncountersThisRun ~= nil then
		for k, blockingEncounterName in pairs( nextEncounterData.BlockedByPreviousEncountersThisRun ) do
			if HasEncounterOccurred( currentRun, blockingEncounterName ) then
				return false
			end
		end
	end

	for k, mutator in pairs( GameState.ActiveMutators ) do
		if mutator.RemoveEncounters ~= nil then
			if Contains( mutator.RemoveEncounters, nextEncounterData.Name ) then
				return false
			end
		end
	end

	if not IsGameStateEligible( currentRun, nextEncounterData ) then
		return false
	end

	return true

end

function GetNumEncounterAppearances( roomHistory, nextEncounterData )
	local numAppearances = 0
	for roomOrder, roomData in pairs( roomHistory ) do
		if roomData.Encounter.Name == nextEncounterData.Name then
			numAppearances = numAppearances + 1
		end
	end
	return numAppearances
end

function HasEncounterOccurred( currentRun, encounterName, requireCompleted )

	if requireCompleted then
		if currentRun.EncountersCompletedCache[encounterName] ~= nil then
			return true
		end
	else
		if currentRun.EncountersOccurredCache[encounterName] ~= nil then
			return true
		end
	end

	return false

end

function HasEncounterBeenCompleted( encounterName )

	if CurrentRun.EncountersCompletedCache[encounterName] ~= nil then
		return true
	end

	if GameState.EncountersCompletedCache[encounterName] ~= nil then
		return true
	end

	return false
end

function IsInspectPointEligible( currentRun, source, inspectPointData )

	if inspectPointData.PlayOnce and HasUsed( inspectPointData.ObjectId ) then
		return false
	end

	if inspectPointData.PlayOnceThisRun and HasUsedThisRun( inspectPointData.ObjectId ) then
		return false
	end

	if not IsGameStateEligible( currentRun, inspectPointData ) then
		return false
	end

	return true
end

function ChooseLoot( excludeLootNames, forceLootName )

	local newLootName = nil
	if forceLootName ~= nil then
		newLootName = forceLootName
	else
		local eligibleLootNames = GetEligibleLootNames( excludeLootNames )
		newLootName = GetRandomValue( eligibleLootNames )
	end

	local newlootData = LootData[newLootName]
	return newlootData

end

function InitializeRewardStores( run )

	run.RewardStores = {}
	for storeName, storeData in pairs( RewardStoreData ) do
		run.RewardStores[storeName] = DeepCopyTable( storeData )
	end

end

function IsRoomRewardEligible( run, room, reward, previouslyChosenRewards, args )

	if not reward.AllowDuplicates and previouslyChosenRewards ~= nil then
		local previouslyChosen = false
		for k, prevReward in pairs( previouslyChosenRewards ) do
			if prevReward.RewardType == reward.Name then
				return false
			end
		end
	end

	if room.EligibleRewards ~= nil and not Contains( room.EligibleRewards, reward.Name ) then
		return false
	end

	if room.IneligibleRewards ~= nil and Contains( room.IneligibleRewards, reward.Name ) then
		return false
	end

	if (not args.IgnoreGameStateRequirements or not reward.AllowSkipRequirements) and not IsGameStateEligible( run, reward, reward.GameStateRequirements ) then
		return false
	end

	return true

end

function ChooseRoomReward( run, room, rewardStoreName, previouslyChosenRewards, args )

	if room.NoReward then
		return nil
	end

	if args == nil then
		args = {}
	end

	if room.ForcedReward ~= nil then
		return room.ForcedReward
	end
	if room.ForcedFirstReward ~= nil and previouslyChosenRewards then
		local foundFirstReward = false
		for i, value in ipairs( previouslyChosenRewards ) do
				if value.RewardType == room.ForcedFirstReward then
				foundFirstReward = true
				break
			end
		end
		if not foundFirstReward then
			return room.ForcedFirstReward
		end
	end

	if run.CurrentRoom ~= nil and run.CurrentRoom.DeferReward then
		return run.CurrentRoom.ChosenRewardType
	end

	if run.CurrentRoom ~= nil and run.CurrentRoom.PersistentExitDoorRewards and args.Door ~= nil then
		for roomIndex = #run.RoomHistory, 1, -1 do
			local prevRoom = run.RoomHistory[roomIndex]
			if run.CurrentRoom.Name == prevRoom.Name and prevRoom.OfferedRewards ~= nil and prevRoom.OfferedRewards[args.Door.ObjectId] ~= nil then
				return prevRoom.OfferedRewards[args.Door.ObjectId].Type
			end
		end
	end

	if room.ChooseRewardRequirements ~= nil then
		if not IsGameStateEligible( run, room, room.ChooseRewardRequirements ) then
			return nil
		end
	end

	if room.ForcedRewards ~= nil then
		for k, forcedReward in pairs( room.ForcedRewards ) do
			if IsGameStateEligible( run, forcedReward, forcedReward.GameStateRequirements ) then
				room.ForceLootName = forcedReward.LootName
				room.ForcedReward = forcedReward
				return forcedReward.Name
			end
		end
	end

	RandomSynchronize( 4 )
	local eligibleRewardKeys = {}
	for key, reward in pairs( run.RewardStores[rewardStoreName] ) do
		if IsRoomRewardEligible( CurrentRun, room, reward, previouslyChosenRewards, args ) then
			table.insert( eligibleRewardKeys, key )
		end
	end

	if IsEmpty( eligibleRewardKeys ) then
		if args.NumStoreRefills ~= nil and args.NumStoreRefills >= 2 then
			-- Final fallback
			return "RoomRewardHealDrop"
		end
		-- Nothing eligible, add another set (no need to throw out the ineligible rewards remaining)
		local newRewardSet = DeepCopyTable( RewardStoreData[rewardStoreName] )
		ConcatTableValues( run.RewardStores[rewardStoreName], newRewardSet )
		args.NumStoreRefills = (args.NumStoreRefills or 0) + 1
		return ChooseRoomReward( run, room, rewardStoreName, previouslyChosenRewards, args )
	end

	local rewardKey = GetRandomValue( eligibleRewardKeys )
	local reward = run.RewardStores[rewardStoreName][rewardKey]
	run.RewardStores[rewardStoreName][rewardKey] = nil
	CollapseTable( run.RewardStores[rewardStoreName] )
	room.RewardOverrides = reward.Overrides

	return reward.Name

end

function GetEligibleLootNames( excludeLootNames )
	local eligibleLootNames = nil
	if ReachedMaxGods( excludeLootNames ) then
		eligibleLootNames = OrderedKeysToList( CurrentRun.LootTypeHistory )
	else
		eligibleLootNames = OrderedKeysToList( LootData )
	end

	local output = {}
	for i, lootName in pairs( eligibleLootNames ) do
		local lootData = LootData[lootName]
		if not lootData.DebugOnly and lootData.GodLoot and IsGameStateEligible( CurrentRun, lootData ) then
			table.insert(output, lootName)
		end
	end
	if excludeLootNames ~= nil then
		for k, excludeLootName in pairs( excludeLootNames ) do
			RemoveValue( output, excludeLootName )
		end
	end
	return output
end

function GetInteractedGods( needsEnemyUpgrade )
	needsEnemyUpgrade = needsEnemyUpgrade or false
	local interactedGods = {}
	if GameState.LootPickups ~= nil then
		for lootName, amount in pairs( GameState.LootPickups ) do
			if amount >= 1 and ( not needsEnemyUpgrade or EnemyUpgradeData[lootName] ~= nil ) then
				table.insert( interactedGods, lootName )
			end
		end
	end
	return interactedGods
end

function GetEligibleInteractedGods( ignoredGod )
	local eligibleGods = GetEligibleLootNames( { ignoredGod } )
	local interactedGods = GetInteractedGods()
	local unionGods = {}
	for i, godName in pairs(eligibleGods) do
		if Contains(interactedGods, godName ) then
			table.insert( unionGods, godName )
		end
	end
	if IsEmpty(unionGods) then
		DebugPrint({ Text = "No god both eligible and interacted with! Probably a debug save?"})
		return eligibleGods
	end
	return unionGods
end

function GetEligibleInteractedGod( ignoredGod )
	return GetRandomValue(GetEligibleInteractedGods( ignoredGod ))
end

function GetInteractedGodsThisRun( ignoredGod )
	local interactedGods = {}
	if CurrentRun ~= nil then
		for lootName, i in pairs( CurrentRun.LootTypeHistory ) do
			if LootData[lootName] and LootData[lootName].GodLoot and (ignoredGod == nil or lootName ~= ignoredGod) then
				table.insert( interactedGods, lootName )
			end
		end
	end
	return interactedGods
end

function GetInteractedGodThisRun( ignoredGod )
	return GetRandomValue(GetInteractedGodsThisRun(ignoredGod))
end
function GetUninteractedGodThisRun()
	local notInteractedGods = {}
	for godName, godData in pairs(LootData) do
		if godData.GodLoot and not godData.DebugOnly and CurrentRun.LootTypeHistory[godName] == nil and IsGameStateEligible( CurrentRun, godData ) then
			table.insert(notInteractedGods, godData.Name)
		end
	end
	return GetRandomValue(notInteractedGods)
end

function ReachedMaxGods( excludedGods )
	excludedGods = excludedGods or {}
	local maxLootTypes = 4
	local gods = ShallowCopyTable( excludedGods )
	for i, godName in pairs(GetInteractedGodsThisRun()) do
		if not Contains( gods, godName ) then
			table.insert( gods, godName )
		end
	end
	return TableLength( gods ) >= maxLootTypes
end

function EndRun( currentRun )
	CurrentRun.EndingRoomName = currentRun.CurrentRoom.Name
	table.insert( GameState.RunHistory, currentRun )
	CurrentRun.CurrentRoom = nil
	CurrentRun = nil
end

function UpdateRunHistoryCache( run, roomAdded )

	run.RoomCountCache = run.RoomCountCache or {}
	run.BiomeRoomCountCache = run.BiomeRoomCountCache or {}

	if run.EncountersOccuredCache ~= nil then
		run.EncountersOccurredCache = run.EncountersOccuredCache
		run.EncountersOccuredCache = nil
	end
	if run.EncountersOccuredBiomeCache ~= nil then
		run.EncountersOccurredBiomeCache = run.EncountersOccuredBiomeCache
		run.EncountersOccuredBiomeCache = nil
	end

	run.EncountersOccurredCache = run.EncountersOccurredCache or {}
	run.EncountersOccurredBiomeCache = run.EncountersOccurredBiomeCache or {}
	run.EncountersCompletedCache = run.EncountersCompletedCache or {}
	run.EncountersDepthCache = run.EncountersDepthCache or {}

	if run.RoomHistory ~= nil and not IsEmpty( run.RoomHistory ) then
		run.RunDepthCache = GetRunDepth( run )
		run.BiomeDepthCache = GetBiomeDepth( run )
	else
		run.RunDepthCache = run.RunDepthCache or 0
		run.BiomeDepthCache = run.BiomeDepthCache or 0
	end

	if roomAdded ~= nil then
		run.RoomCountCache[roomAdded.Name] = (run.RoomCountCache[roomAdded.Name] or 0) + 1

		if roomAdded.RoomSetName ~= run.RoomHistory[#run.RoomHistory].RoomSetName then
			run.BiomeRoomCountCache = {}
			run.EncountersOccurredBiomedCache = {}
		end

		run.BiomeRoomCountCache[roomAdded.Name] = (run.BiomeRoomCountCache[roomAdded.Name] or 0) + 1

		GameState.RoomCountCache[roomAdded.Name] = (GameState.RoomCountCache[roomAdded.Name] or 0) + 1
	end

end

function CheckRunStartFlags( currentRun )
	for flagName, requirement in pairs( GameStateFlagData.RunStartFlags ) do
		if IsGameStateEligible( currentRun, requirement ) then
			GameState.Flags[flagName] = true
		end
	end
end

function GetRunDepth( currentRun )
	if currentRun.RoomHistory == nil then
		return 1
	end

	local depth = 1
	if currentRun.CurrentRoom and currentRun.CurrentRoom.DepthSkip then
		depth = currentRun.CurrentRoom.DepthSkip + 1
	end
	for k, room in pairs( currentRun.RoomHistory ) do
		if room.DepthSkip then
			depth = depth + room.DepthSkip
		end
		depth = depth + 1
	end
	return depth

end

function GetBiomeDepth( currentRun )

	local depth = 1
	if currentRun.CurrentRoom and currentRun.CurrentRoom.DepthSkip then
		depth = currentRun.CurrentRoom.DepthSkip + 1
	end
	if currentRun.CurrentRoom == nil or currentRun.CurrentRoom.NextRoomSet ~= nil then
		-- @refactor Ambiguous point 'between' biomes?
		return depth
	end

	for roomIndex = #currentRun.RoomHistory, 1, -1 do
		local room = currentRun.RoomHistory[roomIndex]
		if room.NextRoomSet ~= nil then
			return depth
		end
		if room.DepthSkip then
			depth = depth + room.DepthSkip
		end
		depth = depth + 1
	end
	return depth

end

function GetPreviousRoom( currentRun )
	if CurrentDeathAreaRoom ~= nil then
		return PreviousDeathAreaRoom
	end

	local prevRoomIndex = TableLength( currentRun.RoomHistory )
	return currentRun.RoomHistory[prevRoomIndex]
end

function GetRunCompletedRooms( currentRun )
	return TableLength( currentRun.RoomHistory )
end

function GetCompletedRuns()
	GameState.CompletedRunsCache = TableLength( GameState.RunHistory )
	return GameState.CompletedRunsCache
end

function HasSeenRoom( roomName, excludeThisRun )

	if GameState.RoomCountCache[roomName] ~= nil and GameState.RoomCountCache[roomName] > 0 then
		return true
	end

	if not excludeThisRun and HasSeenRoomInRun( CurrentRun, roomName ) then
		return true
	end

	return false
end

function HasSeenEncounter( encounterName )

	if GameState.EncountersOccurredCache[encounterName] ~= nil and GameState.EncountersOccurredCache[encounterName] > 0 then
		return true
	end
	return false

end

-- 'cleared' means achieved a victory condition as opposed to dying
function GetNumRunsCleared()
	local runsCleared = 0
	if CurrentRun.Cleared then
		runsCleared = runsCleared + 1
	end
	for k, run in pairs( GameState.RunHistory ) do
		if run.Cleared then
			runsCleared = runsCleared + 1
		end
	end

	return runsCleared
end

function GetNumRunsWithWeapon( weaponName )
	local runCount = 0
	if CurrentRun.WeaponsCache ~= nil and CurrentRun.WeaponsCache[weaponName] then
		runCount = runCount + 1
	end
	for k, prevRun in pairs( GameState.RunHistory ) do
		if prevRun.WeaponsCache ~= nil and prevRun.WeaponsCache[weaponName] then
			if IsSameMode( prevRun ) then
				runCount = runCount + 1
			end
		end
	end
	return runCount
end

function GetNumRunsClearedWithWeapon( weaponName )
	local runsCleared = 0
	if CurrentRun.Cleared and CurrentRun.WeaponsCache[weaponName] then
		runsCleared = runsCleared + 1
	end
	for k, prevRun in pairs( GameState.RunHistory ) do
		if prevRun.WeaponsCache ~= nil and prevRun.WeaponsCache[weaponName] then
			if prevRun.Cleared and IsSameMode( prevRun ) then
				runsCleared = runsCleared + 1
			end
		end
	end
	return runsCleared
end

function GetNumRunsNotCleared()
	local count = 0
	for k, run in pairs( GameState.RunHistory ) do
		if not run.Cleared then
			count = count + 1
		end
	end
	return count
end

function RecordRunStats()
	CurrentRun.EndingRoomName = CurrentRun.CurrentRoom.Name
	CurrentRun.WeaponsCache = DeepCopyTable( CurrentRun.Hero.Weapons )
	CurrentRun.TraitCache = CurrentRun.TraitCache or {}
	for k, traitData in pairs( CurrentRun.Hero.Traits ) do
		if not traitData.RecordCacheOnEquip then
			CurrentRun.TraitCache[traitData.Name] = (CurrentRun.TraitCache[traitData.Name] or 0) + 1
		end
		if traitData.Slot == "Keepsake" then
			CurrentRun.EndingKeepsakeName = traitData.Name
		end
	end
	CurrentRun.MetaPointsCache = GetTotalSpentMetaPoints()
	CurrentRun.ShrinePointsCache = GetTotalSpentShrinePoints()
end

function RecordRunCleared()

	-- set current run to Cleared / victory achieved; used with GetNumRunsCleared()
	CurrentRun.Cleared = true
	RecordRunStats()

	GameState.TimesCleared = 0
	GameState.TimesClearedWeapon = {}
	GameState.WeaponRecordsClearTime = {}
	GameState.WeaponRecordsShrinePoints = {}

	for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
		GameState.TimesClearedWeapon[weaponName] = 0
	end

	for upgradeName, upgradeAmount in pairs( GameState.MetaUpgrades ) do
		if IsMetaUpgradeActive( upgradeName ) then
			GameState.ClearedWithMetaUpgrades[upgradeName] = math.max( GameState.ClearedWithMetaUpgrades[upgradeName] or 0, upgradeAmount )
		end
	end

	GameState.ConsecutiveClearsRecord = 0
	GameState.ConsecutiveClears = 0

	for k, run in ipairs( GameState.RunHistory ) do
		if run.Cleared then
			GameState.TimesCleared = GameState.TimesCleared + 1
			if run.WeaponsCache ~= nil then
				for weaponName, v in pairs( run.WeaponsCache ) do
					GameState.TimesClearedWeapon[weaponName] = (GameState.TimesClearedWeapon[weaponName] or 0) + 1
					if run.TargetShrinePointThreshold then
						if GameState.WeaponRecordsClearTime[weaponName] == nil or run.GameplayTime < GameState.WeaponRecordsClearTime[weaponName] then
							GameState.WeaponRecordsClearTime[weaponName] = run.GameplayTime
						end
						if GameState.WeaponRecordsShrinePoints[weaponName] == nil or run.ShrinePointsCache > GameState.WeaponRecordsShrinePoints[weaponName] then
							GameState.WeaponRecordsShrinePoints[weaponName] = run.ShrinePointsCache
						end
					end
				end
			end
			GameState.ConsecutiveClears = GameState.ConsecutiveClears + 1
			if GameState.ConsecutiveClears > GameState.ConsecutiveClearsRecord then
				GameState.ConsecutiveClearsRecord = GameState.ConsecutiveClears
			end
		else
			GameState.ConsecutiveClears = 0
		end
	end

	if CurrentRun.Cleared then
		GameState.TimesCleared = GameState.TimesCleared + 1
		for weaponName, v in pairs( CurrentRun.WeaponsCache ) do
			GameState.TimesClearedWeapon[weaponName] = (GameState.TimesClearedWeapon[weaponName] or 0) + 1
			if GameState.WeaponRecordsClearTime[weaponName] == nil or CurrentRun.GameplayTime < GameState.WeaponRecordsClearTime[weaponName] then
				GameState.WeaponRecordsClearTime[weaponName] = CurrentRun.GameplayTime
			end
			if GameState.WeaponRecordsShrinePoints[weaponName] == nil or CurrentRun.ShrinePointsCache > GameState.WeaponRecordsShrinePoints[weaponName] then
				GameState.WeaponRecordsShrinePoints[weaponName] = CurrentRun.ShrinePointsCache
			end
		end
		GameState.ConsecutiveClears = GameState.ConsecutiveClears + 1
		if GameState.ConsecutiveClears > GameState.ConsecutiveClearsRecord then
			GameState.ConsecutiveClearsRecord = GameState.ConsecutiveClears
		end
	else
		GameState.ConsecutiveClears = 0
	end

end

function IsSameMode( run )

	if CurrentRun.EasyModeLevel ~= nil and run.EasyModeLevel ~= nil then
		return true
	end

	if CurrentRun.EasyModeLevel == nil and run.EasyModeLevel == nil then
		return true
	end

	return false

end

function GetRecordShrinePointClear( weaponName )
	if GameState.WeaponRecordsShrinePoints and GameState.WeaponRecordsShrinePoints[weaponName] ~= nil then
		return GameState.WeaponRecordsShrinePoints[weaponName]
	end
	return 0
end

function GetShrinePointLimit( weaponName )
	if weaponName == nil then
		weaponName = GetEquippedWeapon()
	end
	if GameState.WeaponRecordsShrinePoints and GameState.WeaponRecordsShrinePoints[weaponName] ~= nil then
		if GetMaximumAllocatableShrinePoints() < GetCurrentRunClearedShrinePointThreshold( weaponName ) then
			return GetMaximumAllocatableShrinePoints()
		end
	end
	return GetCurrentRunClearedShrinePointThreshold( weaponName )
end

function GetMaximumPossibleShrinePoints()
	local total = 0
	for i, name in pairs( ShrineUpgradeOrder ) do
		local metaupgradeData = MetaUpgradeData[name]
		if metaupgradeData.CostTable then
			for s, cost in pairs( metaupgradeData.CostTable ) do
				total = total + cost
			end
		elseif metaupgradeData.Cost then
			total = total + metaupgradeData.Cost * metaupgradeData.MaxInvestment
		end
	end
	return total
end

function GetMaximumAllocatableShrinePoints()
	-- how much can be allocated
	if GameState.Flags.HardMode then
		return HeroData.DefaultHero.MaxShrinePointThresholdHardMode
	end
	return HeroData.DefaultHero.MaxShrinePointThreshold
end

function GetHighestRunClearShrinePointThreshold()
	local maxValue = -1 * ShrineClearData.ClearThreshold
	for i, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
		if GetLastClearedShrinePointThreshold( weaponName ) > maxValue then
			maxValue = GetLastClearedShrinePointThreshold( weaponName )
		end
	end
	return maxValue
end

function GetLastClearedShrinePointThreshold( weaponName )
	local minValue = nil
	for i, roomName in pairs( ShrineClearData.BossRoomNames ) do
		local roomClearValue = GetLastRoomClearedShrinePointThreshold( weaponName, roomName )
		if not minValue or roomClearValue < minValue then
			minValue = roomClearValue
		end
	end
	return minValue

end

function GetCurrentRunClearedShrinePointThreshold( weaponName )
	return GetLastClearedShrinePointThreshold( weaponName ) + ShrineClearData.ClearThreshold
end

function GetTotalEarnedBounties()
	local bounties = 0
	if GameState.RecordLastClearedShrineReward ~= nil then
		for i, weaponData in pairs( GameState.RecordLastClearedShrineReward ) do
			for s, roomData in pairs( weaponData ) do
				if type(roomData) == "table" then
					bounties = bounties + TableLength( roomData )
				else
					bounties = bounties + 1
				end
			end
		end
	end
	return bounties
end

function IsShrinePointLevelFullyCleared( weaponName, shrinePoints )
	local hasReward = true
	for i, roomName in pairs( ShrineClearData.BossRoomNames ) do
		if not GameState.RecordLastClearedShrineReward or not GameState.RecordLastClearedShrineReward[weaponName] or not GameState.RecordLastClearedShrineReward[weaponName][roomName] or not GameState.RecordLastClearedShrineReward[weaponName][roomName][shrinePoints] then
			hasReward = false
		end
	end
	return hasReward
end

function GetLastRoomClearedShrinePointThreshold( weaponName, roomName )
	if GameState.RecordClearedShrineThreshold and GameState.RecordClearedShrineThreshold[weaponName] ~= nil and GameState.RecordClearedShrineThreshold[weaponName][roomName] then
		return GameState.RecordClearedShrineThreshold[weaponName][roomName]
	end
	if GameState.Flags.HardMode then
		local startingValue = -1
		for name, amount in pairs( HeroData.DefaultHero.HardModeForcedMetaUpgrades ) do
			startingValue = startingValue + amount
		end
		return startingValue
	end
	return 0
end

function ObtainedRoomShrineReward( weaponName, roomName, threshold )
	if GameState.RecordLastClearedShrineReward and GameState.RecordLastClearedShrineReward[weaponName] and GameState.RecordLastClearedShrineReward[weaponName][roomName] and GameState.RecordLastClearedShrineReward[weaponName][roomName][threshold] then
		return true
	end
	return false
end

function GetRoomShrineRewardIcon( weaponName, roomName, threshold )
	local lastClearedThreshold = GetLastRoomClearedShrinePointThreshold( weaponName, roomName )
	if threshold == 0 then
		if GameState.RecordLastClearedShrineReward and GameState.RecordLastClearedShrineReward[weaponName] and GameState.RecordLastClearedShrineReward[weaponName][roomName] and type(GameState.RecordLastClearedShrineReward[weaponName][roomName]) == "table" and GameState.RecordLastClearedShrineReward[weaponName][roomName][threshold] then
			local consumableName = GameState.RecordLastClearedShrineReward[weaponName][roomName][threshold]
			if ConsumableData[consumableName] and ConsumableData[consumableName].Icon then
				return ConsumableData[consumableName].Icon
			else
				return consumableName .. "Preview"
			end
		end
		if IsScreenOpen( "ShrineUpgrade" ) then
			return "UnknownSuperRewardSmall"
		end	
		return "UnknownSuperRewardSmallUnearned"
	elseif lastClearedThreshold >= threshold then
		if GameState.RecordLastClearedShrineReward and GameState.RecordLastClearedShrineReward[weaponName] and GameState.RecordLastClearedShrineReward[weaponName][roomName] and type(GameState.RecordLastClearedShrineReward[weaponName][roomName]) == "table" and GameState.RecordLastClearedShrineReward[weaponName][roomName][threshold] then
			local consumableName = GameState.RecordLastClearedShrineReward[weaponName][roomName][threshold]
			if ConsumableData[consumableName] and ConsumableData[consumableName].Icon then
				return ConsumableData[consumableName].Icon
			else
				return consumableName .. "Preview"
			end
		end
		return "UnknownSuperRewardSmall"
	end
	if IsScreenOpen( "ShrineUpgrade" ) then
		return "UnknownSuperRewardSmall"
	end	
	return "UnknownSuperRewardSmallUnearned"
end

function GetHighestShrinePointRunClear( currentRun, args )
	args = args or {}
	local highestPoints = 0
	if currentRun ~= nil and currentRun.TargetShrinePointThreshold ~= nil and currentRun.Cleared and currentRun.ShrinePointsCache ~= nil then
		highestPoints = currentRun.ShrinePointsCache
	end
	for k, prevRun in pairs( GameState.RunHistory ) do
		if (args.IgnoreSameMode or IsSameMode( prevRun )) and prevRun.TargetShrinePointThreshold ~= nil and prevRun.Cleared and prevRun.ShrinePointsCache ~= nil and prevRun.ShrinePointsCache > highestPoints then
			highestPoints = prevRun.ShrinePointsCache
		end
	end
	return highestPoints
end

function GetHighestShrinePointRunClearWithWeapon( currentRun, weapon )
	local highestPoints = 0
	if currentRun ~= nil and currentRun.TargetShrinePointThreshold ~= nil and currentRun.Cleared and currentRun.ShrinePointsCache ~= nil and currentRun.WeaponsCache[weapon] then
		highestPoints = currentRun.ShrinePointsCache
	end
	for k, prevRun in pairs( GameState.RunHistory ) do
		if prevRun.WeaponsCache ~= nil and prevRun.WeaponsCache[weapon] then
			if IsSameMode( prevRun ) and prevRun.TargetShrinePointThreshold ~= nil and prevRun.Cleared and prevRun.ShrinePointsCache ~= nil and prevRun.ShrinePointsCache > highestPoints then
				highestPoints = prevRun.ShrinePointsCache
			end
		end
	end
	return highestPoints
end

function GetPreUpdateSevenHighestShrinePointRunClear()

	local highestPoints = 0
	for k, prevRun in pairs( GameState.RunHistory ) do
		if not prevRun.TargetShrinePointThreshold and prevRun.RunDepthCache > 44 and prevRun.Cleared and prevRun.GameplayTime ~= nil and prevRun.ShrinePointsCache > highestPoints then
			highestPoints = prevRun.ShrinePointsCache
		end
	end
	return highestPoints
end

function SetRoomCleared( weaponName, roomName, rewardName )
	if not GameState.RecordClearedShrineThreshold then
		GameState.RecordClearedShrineThreshold = {}
	end
	if not GameState.RecordClearedShrineThreshold[weaponName] then
		GameState.RecordClearedShrineThreshold[weaponName] = {}
	end
	if not GameState.RecordLastClearedShrineReward then
		GameState.RecordLastClearedShrineReward = {}
	end
	if not GameState.RecordLastClearedShrineReward[weaponName] then
		GameState.RecordLastClearedShrineReward[weaponName] = {}
	end
	if not GameState.RecordLastClearedShrineReward[weaponName][roomName] or type(GameState.RecordLastClearedShrineReward[weaponName][roomName]) ~= "table" then
		GameState.RecordLastClearedShrineReward[weaponName][roomName] = {}
	end

	if IsRoomFirstClearOverShrinePointThreshold( weaponName, CurrentRun, roomName ) then
		if not GameState.SpentShrinePointsCache or GameState.SpentShrinePointsCache == 0 then
			if not GameState.RecordClearedShrineThreshold[weaponName][roomName] then
				GameState.RecordClearedShrineThreshold[weaponName][roomName] = 0
			end
			GameState.RecordLastClearedShrineReward[weaponName][roomName][0] = rewardName
		else
			GameState.RecordClearedShrineThreshold[weaponName][roomName] = GetLastRoomClearedShrinePointThreshold( weaponName, roomName ) + ShrineClearData.ClearThreshold
			GameState.RecordLastClearedShrineReward[weaponName][roomName][GetLastRoomClearedShrinePointThreshold( weaponName, roomName )] = rewardName
		end
	end
end

function IsRoomFirstClearOverShrinePointThreshold( weaponName, currentRun, roomName )
	local activeShrinePoints = 0
	if GameState.SpentShrinePointsCache then
		activeShrinePoints = GameState.SpentShrinePointsCache
		if activeShrinePoints > GetCurrentRunClearedShrinePointThreshold( weaponName ) then
			activeShrinePoints = GetCurrentRunClearedShrinePointThreshold( weaponName )
		end
	end

	if activeShrinePoints == 0 then
		-- special case for zero heat
		local firstClear = true
		if GameState.RecordLastClearedShrineReward and GameState.RecordLastClearedShrineReward[weaponName] and GameState.RecordLastClearedShrineReward[weaponName][roomName] and GameState.RecordLastClearedShrineReward[weaponName][roomName][0] then
			firstClear = false
		end
		return firstClear
	end

	if GetCurrentRunClearedShrinePointThreshold( weaponName ) > GetMaximumAllocatableShrinePoints() then
		return false
	end

	return activeShrinePoints >= GetLastRoomClearedShrinePointThreshold( weaponName, roomName ) + ShrineClearData.ClearThreshold
end

function HasSeenRoomInRun( run, roomName )

	if run.CurrentRoom ~= nil and run.CurrentRoom.Name == roomName then
		return true
	end
	if run.RoomCountCache ~= nil and run.RoomCountCache[roomName] ~= nil and run.RoomCountCache[roomName] > 0 then
		return true
	end
	return false

end

function HasSeenRoomEarlierInRun( run, roomName )

	if run.RoomCountCache[roomName] ~= nil and run.RoomCountCache[roomName] > 0 then
		return true
	end
	return false

end

function HasSeenRoomInNumRuns( roomName, runCount )

	if HasSeenRoomInRun( CurrentRun, roomName ) then
		return true
	end

	for runIndex = #GameState.RunHistory, #GameState.RunHistory - (runCount - 1), -1 do
		if runIndex <= 0 then
			return false
		end
		local prevRun = GameState.RunHistory[runIndex]
		if HasSeenRoomInRun( prevRun, roomName ) then
			return true
		end
	end

	return false

end

function BuildMetaupgradeCache()
	CurrentRun.MetaUpgradeCache = {}
	for upgradeName, upgradeAmount in pairs( GameState.MetaUpgrades ) do
		if IsMetaUpgradeActive( upgradeName ) then
			CurrentRun.MetaUpgradeCache[upgradeName] = upgradeAmount
		end
	end
end

function GetNumMetaUpgrades( upgradeName, args )
	if CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead and CurrentRun.CurrentRoom and not CurrentRun.CurrentRoom.TestRoom and CurrentRun.MetaUpgradeCache then
		return CurrentRun.MetaUpgradeCache[upgradeName] or 0
	end
	args = args or {}
	if not MetaUpgradeData[upgradeName] then
		return 0
	end

	if not args.UnModified and not IsMetaUpgradeActive( upgradeName ) then
		return 0
	end

	if CurrentRun.MetaUpgrades ~= nil then
		-- Run override
		return CurrentRun.MetaUpgrades[upgradeName] or 0
	end
	return GameState.MetaUpgrades[upgradeName] or 0
end

function GetTotalAccumulatedMetaPoints()
	if not GameState.Resources or not GameState.Resources.MetaPoints then
		return 0
	end

	local total = GameState.Resources.MetaPoints + GetTotalSpentMetaPoints()
	return total
end

function GetTotalSpentMetaPoints()
	local total = 0
	for k, upgradeName in pairs( GameState.MetaUpgradesSelected ) do
		for i = 1, GetNumMetaUpgrades( upgradeName, { UnModified = true }) do
			local price = GetMetaUpgradePrice( MetaUpgradeData[upgradeName], i - 1 )
			if price ~= nil then
				total = total + price
			end
		end
	end
	return total
end

function GetTotalSpentShrinePoints()
	local total = 0
	for k, upgradeName in pairs( ShrineUpgradeOrder ) do
		for i = 1, GetNumMetaUpgrades( upgradeName ) do
			local price = GetMetaUpgradePrice( MetaUpgradeData[upgradeName], i - 1 )
			if price ~= nil then
				total = total + price
			end
		end
	end
	return total
end

function GetEligibleMeleeWeapons()
	local eligibleMeleeWeaponData = {}
	for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
		local weaponData = WeaponData[weaponName]
		if IsWeaponEligible( CurrentRun, weaponData ) then
			table.insert( eligibleMeleeWeaponData, weaponData )
		end
	end
	return eligibleMeleeWeaponData
end

function IsWeaponEligible( currentRun, weaponData )

	if not weaponData.StartingWeapon then
		return false
	end

	if weaponData.GameStateRequirements ~= nil and not IsGameStateEligible( currentRun, weaponData, weaponData.GameStateRequirements ) then
		return false
	end

	return true

end

OnSpawn{
	function( triggerArgs )
		local obstacleData = ObstacleData[triggerArgs.name]
		if obstacleData ~= nil then
			wait(0.01) -- @refactor Order of initialization issue
			local obstacle = DeepCopyTable( obstacleData )
			obstacle.ObjectId = triggerArgs.triggeredById
			SetupObstacle( obstacle, true )
		elseif triggerArgs.NeedsLuaInitialization and EnemyData[triggerArgs.name] ~= nil then
			local enemy = DeepCopyTable(EnemyData[triggerArgs.name])
			enemy.ObjectId = triggerArgs.triggeredById
			SetupEnemyObject( enemy, CurrentRun )
			if triggerArgs.SpawnedById ~= nil then
				local spawner = ActiveEnemies[triggerArgs.SpawnedById]
				if spawner ~= nil then
					spawner.Spawns = spawner.Spawns or {}
					spawner.Spawns[enemy.ObjectId] = enemy
				elseif enemy.ActivateFuseIfNoSpawner then
					ActivateFuse( enemy )
				end
			end
		end
	end
}

function CloseDoorForRun( run, obstacle )
	run.ClosedDoors[run.CurrentRoom.Name] = run.ClosedDoors[run.CurrentRoom.Name] or {}
	run.ClosedDoors[run.CurrentRoom.Name][obstacle.ObjectId] = true
end

function IsDoorClosedForRun( run, obstacle )

	if run.ClosedDoors == nil then
		return false
	end

	local roomDoors = run.ClosedDoors[run.CurrentRoom.Name]
	if roomDoors == nil then
		return false
	end

	if not roomDoors[obstacle.ObjectId] then
		return false
	end

	return true

end

function SetupObstacle( obstacle, replaceOnlyNull )

	if obstacle.SetupGameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, obstacle, obstacle.SetupGameStateRequirements ) then
		if obstacle.DestroyIfNotSetup then
			Destroy({ Id = obstacle.ObjectId })
		end
		return
	end

	if obstacle.Activate then
		Activate({ Id = obstacle.ObjectId })
	end
	if obstacle.ActivateIds ~= nil then
		Activate({ Ids = obstacle.ActivateIds })
	end
	AttachLua({ Id = obstacle.ObjectId, Table = obstacle, OnlyNullKeys = replaceOnlyNull })
	MapState.ActiveObstacles[obstacle.ObjectId] = obstacle
	if obstacle.Buckets ~= nil then
		for k, bucketName in pairs( obstacle.Buckets ) do
			MapState[bucketName] = MapState[bucketName] or {}
			MapState[bucketName][obstacle.ObjectId] = obstacle
		end
	end

	ExtractValues( CurrentRun.Hero, obstacle, obstacle )

	obstacle.Health = obstacle.MaxHealth

	if obstacle.IsDefaultDoor and not IsDoorClosedForRun( CurrentRun, obstacle ) and (obstacle.AvailableRequirements == nil or IsGameStateEligible( CurrentRun, obstacle, obstacle.AvailableRequirements ) ) then
		OfferedExitDoors[obstacle.ObjectId] = obstacle
	end

	if obstacle.BlockExitUntilUsed then
		ActivatedObjects[obstacle.ObjectId] = obstacle
	end

	if obstacle.OverheadText ~= nil then
		CreateTextBox({
			Id = obstacle.ObjectId,
			Text = obstacle.OverheadText,
			Font = obstacle.OverheadTextFont or "FellType",
			FontSize = obstacle.OverheadTextFontSize or 16,
			OffsetY = obstacle.OverheadTextOffset or -65,
			Color = obstacle.OverheadTextColor or Color.White
			})
	end

	if obstacle.AlphaMin ~= nil and obstacle.AlphaMax ~= nil then
		local fraction = RandomFloat( obstacle.AlphaMin, obstacle.AlphaMax )
		SetAlpha({ Id = obstacle.ObjectId, Fraction = fraction })
	end

	if obstacle.SpawnPropertyChanges ~= nil then
		ApplyUnitPropertyChanges( obstacle, obstacle.SpawnPropertyChanges, true )
	end

	if obstacle.InteractDistance ~= nil then
		SetInteractProperty({ DestinationId = obstacle.ObjectId, Property = "Distance", Value = obstacle.InteractDistance })
	end
	if obstacle.InteractOffsetX ~= nil then
		SetInteractProperty({ DestinationId = obstacle.ObjectId, Property = "OffsetX", Value = obstacle.InteractOffsetX })
	end
	if obstacle.InteractOffsetY ~= nil then
		SetInteractProperty({ DestinationId = obstacle.ObjectId, Property = "OffsetY", Value = obstacle.InteractOffsetY })
	end
	if obstacle.AutoActivate ~= nil then
		SetInteractProperty({ DestinationId = obstacle.ObjectId, Property = "AutoActivate", Value = obstacle.AutoActivate })
	end
	if obstacle.DisableIfUnuseable and obstacle.OnUsedGameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, obstacle, obstacle.OnUsedGameStateRequirements ) then
		UseableOff({ Id = obstacle.ObjectId })
	end

	if obstacle.AddToGroup ~= nil then
		AddToGroup({ Id = obstacle.ObjectId, Name = obstacle.AddToGroup })
	end

	if obstacle.KeyCost ~= nil and obstacle.KeyCost > 0 then
		UpdateLockedKeyPresentation( obstacle )
	end

	if obstacle.MetaRewardAnimation ~= nil and CurrentRun.NextRewardStoreName == "MetaProgress" then
		SetAnimation({ Name = obstacle.MetaRewardAnimation, DestinationId = obstacle.ObjectId })
	end

	ProcessTextLines( obstacle.OnUsedTextLineSets )
	ProcessTextLines( obstacle.OnTrophyRevealedTextLineSets )
	ProcessTextLines( obstacle.OnTrophyUnlockedTextLineSets )

	if obstacle.DistanceTrigger ~= nil then
		thread( CheckDistanceTrigger, obstacle.DistanceTrigger, obstacle )
	end
	if obstacle.DistanceTriggers ~= nil then
		for k, trigger in ipairs( obstacle.DistanceTriggers ) do
			thread( CheckDistanceTrigger, trigger, obstacle, k )
		end
	end

	if obstacle.HealFraction ~= nil then
		for cosmeticName, owned in pairs( GameState.Cosmetics ) do
			local cosmeticData = ConditionalItemData[cosmeticName]
			if cosmeticData ~= nil and cosmeticData.AddHealFraction ~= nil then
				obstacle.HealFraction = obstacle.HealFraction + cosmeticData.AddHealFraction
			end
		end
	end

	if obstacle.SetupFunctionName ~= nil then
		RunFunctionName( obstacle.SetupFunctionName, obstacle, obstacle.SetupFunctionArgs )
	end
	if obstacle.SetupFunctions ~= nil then
		for k, setupFunctionEntry in ipairs( obstacle.SetupFunctions ) do
			if setupFunctionEntry.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, obstacle, setupFunctionEntry.GameStateRequirements ) then
				RunFunctionName( setupFunctionEntry.Name, obstacle, setupFunctionEntry.Args )
			end
		end
	end

	if obstacle.Name ~= nil and GameState.Cosmetics[obstacle.Name] == UIData.Constants.PENDING_REVEAL and not obstacle.UseableWhilePending then
		UseableOff({ Id = obstacle.ObjectId })
	end

	if obstacle.ActivateGameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, obstacle, obstacle.ActivateGameStateRequirements ) then
		SetAlpha({ Id = obstacle.ObjectId, Fraction = 0 })
		SetThingProperty({ Property = "StopsUnits", Value = false, Id = obstacle.ObjectId })
		SetThingProperty({ Property = "StopsLight", Value = false, Id = obstacle.ObjectId })
		UseableOff({ Id = obstacle.ObjectId })
	end

end

function IsGameStateEligible( currentRun, source, requirements, args )
	if args == nil then
		args = {}
	end
	local roomSkip = args.RoomsSkipped or 0

	if source == nil then
		return false
	end

	if requirements == nil then
		requirements = source
	end

	if IsEmpty( requirements ) then
		return true
	end

	if requirements.Skip then
		return false
	end

	if requirements.Force then
		return true
	end

	if requirements.ChanceToPlay ~= nil and not RandomChance( requirements.ChanceToPlay ) then
		return false
	end

	local currentRunDepth = 0
	if currentRun.RunDepthCache ~= nil then
		currentRunDepth = currentRun.RunDepthCache  + roomSkip
	end

	local currentBiomeDepth = 0
	if currentRun.BiomeDepthCache ~= nil then
		currentBiomeDepth = currentRun.BiomeDepthCache + roomSkip
	end

	if requirements.RequiredGiftLevel ~= nil then
		if GetGiftLevel( requirements.RequiredGiftLevel.NPCName ) < requirements.RequiredGiftLevel.MinLevel then
			return false
		end
	end

	if requirements.AssistUpgradeLevel ~= nil then
		if not GameState.AssistUnlocks[requirements.AssistUpgradeLevel.Name] or GameState.AssistUnlocks[requirements.AssistUpgradeLevel.Name] < requirements.AssistUpgradeLevel.Level then
			return false
		end
	end

	if requirements.RequiredTextLines ~= nil then
		for k, textLineSet in pairs( requirements.RequiredTextLines ) do
			if TextLinesRecord[textLineSet] == nil then
				return false
			end
		end
	end

	if requirements.RequiredAnyTextLines ~= nil then
		local anyTrue = false
		for k, textLineSet in pairs( requirements.RequiredAnyTextLines ) do
			if TextLinesRecord[textLineSet] then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	-- this is a duplicate of RequiredAnyTextLines above for testing multiple pairs / sets of lines in some cases
	if requirements.RequiredAnyOtherTextLines ~= nil then
		local anyTrue = false
		for k, textLineSet in pairs( requirements.RequiredAnyOtherTextLines ) do
			if TextLinesRecord[textLineSet] then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredMinAnyTextLines ~= nil then
		local numTrue = 0
		for k, textLineSet in pairs( requirements.RequiredMinAnyTextLines.TextLines ) do
			if TextLinesRecord[textLineSet] then
				numTrue = numTrue + 1
			end
		end
		if numTrue < requirements.RequiredMinAnyTextLines.Count then
			return false
		end
	end
	if requirements.RequiredMaxAnyTextLines ~= nil then
		local numTrue = 0
		for k, textLineSet in pairs( requirements.RequiredMaxAnyTextLines.TextLines ) do
			if TextLinesRecord[textLineSet] then
				numTrue = numTrue + 1
			end
		end
		if numTrue > requirements.RequiredMaxAnyTextLines.Count then
			return false
		end
	end

	if requirements.RequiredAnyTextLinesThisRun ~= nil then
		local anyTrue = false
		for k, textLineSet in pairs( requirements.RequiredAnyTextLinesThisRun ) do
			if currentRun.TextLinesRecord[textLineSet] then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredTextLinesThisRoom ~= nil then
		for k, textLines in pairs( requirements.RequiredTextLinesThisRoom ) do
			if not currentRun.CurrentRoom.TextLinesRecord[textLines] then
				return false
			end
		end
	end
	if requirements.RequiredFalseTextLinesThisRoom ~= nil then
		for k, textLines in pairs( requirements.RequiredFalseTextLinesThisRoom ) do
			if currentRun.CurrentRoom.TextLinesRecord[textLines] then
				return false
			end
		end
	end

	if requirements.RequiredTextLinesThisRun ~= nil and currentRun.TextLinesRecord ~= nil and not currentRun.TextLinesRecord[requirements.RequiredTextLinesThisRun] then
		return false
	end
	if requirements.RequiredFalseTextLinesThisRun ~= nil and currentRun.TextLinesRecord ~= nil and type(requirements.RequiredFalseTextLinesThisRun) == "table" then -- Backwards compat
		for k, textLineSet in pairs( requirements.RequiredFalseTextLinesThisRun ) do
			if currentRun.TextLinesRecord[textLineSet] ~= nil then
				return false
			end
		end
	end

	if requirements.RequiredFalseTextLines ~= nil then
		for k, textLineSet in pairs( requirements.RequiredFalseTextLines ) do
			if TextLinesRecord[textLineSet] ~= nil then
				return false
			end
		end
	end

	if requirements.RequiredQueuedTextLines ~= nil then
		local anyTrue = false
		for unitId, unit in pairs( ActiveEnemies ) do
			if unit.NextInteractLines ~= nil and unit.NextInteractLines.Name == requirements.RequiredQueuedTextLines then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end
	if requirements.RequiredAnyQueuedTextLines ~= nil then
		local anyTrue = false
		for unitId, unit in pairs( ActiveEnemies ) do
			for k, textLineSet in pairs( requirements.RequiredAnyQueuedTextLines ) do
				if unit.NextInteractLines ~= nil and unit.NextInteractLines.Name == textLineSet then
					anyTrue = true
					break
				end
			end
		end
		if not anyTrue then
			return false
		end
	end
	if requirements.RequiredFalseQueuedTextLines ~= nil then
		for unitId, unit in pairs( ActiveEnemies ) do
			for k, textLineSet in pairs( requirements.RequiredFalseQueuedTextLines ) do
				if unit.NextInteractLines ~= nil and unit.NextInteractLines.Name == textLineSet then
					return false
				end
			end
		end
	end

	local prevRun = GameState.RunHistory[#GameState.RunHistory]
	if requirements.RequiredAnyTextLinesLastRun ~= nil then
		if prevRun == nil or prevRun.TextLinesRecord == nil then
			return false
		end
		local anyTrue = false
		for k, textLineSet in pairs( requirements.RequiredAnyTextLinesLastRun ) do
			if prevRun.TextLinesRecord[textLineSet] then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end
	if requirements.RequiredFalseTextLinesLastRun ~= nil and prevRun ~= nil and prevRun.TextLinesRecord ~= nil then
		for k, textLineSet in pairs( requirements.RequiredFalseTextLinesLastRun ) do
			if prevRun.TextLinesRecord[textLineSet] ~= nil then
				return false
			end
		end
	end

	if requirements.RequiredCodexEntry ~= nil then
		local requiredEntryName = requirements.RequiredCodexEntry.EntryName
		local requiredEntryIndex = requirements.RequiredCodexEntry.EntryIndex or 1
		local requiredCodexEntryFound = HasCodexEntryBeenFound(requiredEntryName, requiredEntryIndex)
		if not requiredCodexEntryFound then
			return false
		end
	end

	if requirements.RequiredCodexEntries ~= nil then

		for requiredEntryName, requiredEntryIndex in pairs(requirements.RequiredCodexEntries) do
			if not HasCodexEntryBeenFound(requiredEntryName, requiredEntryIndex) then
				return false
			end
		end
	end

	if requirements.RequiredCodexEntriesMin ~= nil then
		if CalcNumCodexEntriesUnlocked() < requirements.RequiredCodexEntriesMin then
			return false
		end
	end

	if requirements.RequiresCodexFullyUnlocked ~= nil then
		for chapterName, chapterData in pairs( Codex ) do
			for entryName, entryData in pairs( Codex[chapterName].Entries ) do
				if CodexStatus[chapterName] == nil or CodexStatus[chapterName][entryName] == nil then
					return false
				else
					for i = 1, #entryData.Entries do
						if not CodexStatus[chapterName][entryName][i] or not CodexStatus[chapterName][entryName][i].Unlocked then
							return false
						end
					end
				end
			end
		end
	end

	if requirements.RequiredGodLoot ~= nil then
		if not LootData[requirements.RequiredGodLoot] then
			return false
		end

		local hasTrait = false
		for i, traitData in pairs(CurrentRun.Hero.Traits ) do
			if LootData[requirements.RequiredGodLoot].TraitIndex[traitData.Name] then
				hasTrait = true
				break
			end
		end
		if not hasTrait then
			return false
		end
	end

	if requirements.RequiredLootThisRun ~= nil and not CurrentRun.LootTypeHistory[requirements.RequiredLootThisRun] then
		return false
	end

	if requirements.RequiredFalseGodLoot ~= nil and CurrentRun.LootTypeHistory[requirements.RequiredFalseGodLoot] then
		return false
	end
	if requirements.RequiredFalseGodLoots ~= nil then
		for k, requiredFalseGodLoot in pairs( requirements.RequiredFalseGodLoots ) do
			if CurrentRun.LootTypeHistory[requiredFalseGodLoot] then
				return false
			end
		end
	end

	if requirements.MinRequiredRunLootPickups ~= nil then
		if not CurrentRun.LootTypeHistory[requirements.MinRequiredRunLootPickups.Name] or CurrentRun.LootTypeHistory[requirements.MinRequiredRunLootPickups.Name] < requirements.MinRequiredRunLootPickups.Count then
			return false
		end
	end
	
	if requirements.RequiredNoGodBoons ~= nil then
		for traitName in pairs(CurrentRun.Hero.TraitDictionary) do
			if IsGodTrait( traitName, {ForShop = true }) then
				return false
			end
		end
	end

	if requirements.MinRequiredLootPickups ~= nil then
		for requiredLoot, requiredLootPickupsCount in pairs( requirements.MinRequiredLootPickups ) do
			if GameState.LootPickups[requiredLoot] == nil or GameState.LootPickups[requiredLoot] < requiredLootPickupsCount then
				return false
			end
		end
	end

	if requirements.RequiredWeapon ~= nil and not CurrentRun.Hero.Weapons[requirements.RequiredWeapon] then
		return false
	end
	if requirements.RequiredAnyWeapon ~= nil then
		local anyTrue = false
		for k, name in pairs( requirements.RequiredAnyWeapon ) do
			if CurrentRun.Hero.Weapons[name] then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredFalseWeapon ~= nil and CurrentRun.Hero.Weapons[requirements.RequiredFalseWeapon] then
		return false
	end
	if requirements.RequiredFalseWeaponLastRun ~= nil and prevRun ~= nil and prevRun.Hero.Weapons[requirements.RequiredFalseWeaponLastRun] then
		return false
	end

	if requirements.RequiredMinWeaponKills ~= nil then
		for requiredWeapon, requiredWeaponKillCount in pairs( requirements.RequiredMinWeaponKills ) do
			if GameState.WeaponKills[requiredWeapon] == nil or GameState.WeaponKills[requiredWeapon] < requiredWeaponKillCount then
				return false
			end
		end
	end

	if requirements.ConsecutiveDeathsInRoom ~= nil then
		local consecutiveDeathsInRoom = 0
		if HasSeenRoomEarlierInRun( currentRun, requirements.ConsecutiveDeathsInRoom.Name ) then
			if not currentRun.Cleared and currentRun.EndingRoomName == requirements.ConsecutiveDeathsInRoom.Name then
				-- Saw the room this run and died in it, streak continues
				consecutiveDeathsInRoom = consecutiveDeathsInRoom + 1
			else
				-- Saw the room this run and didn't die in it, streak is 0
				return false
			end
		end
		for i = #GameState.RunHistory, 1 , -1 do
			local run = GameState.RunHistory[i]
			if HasSeenRoomInRun( run, requirements.ConsecutiveDeathsInRoom.Name ) then
				if not run.Cleared and run.EndingRoomName == requirements.ConsecutiveDeathsInRoom.Name then
					-- Saw the room this run and died in it, streak continues
					consecutiveDeathsInRoom = consecutiveDeathsInRoom + 1
				else
					-- Saw the room this run and didn't die, streak is broken
					break
				end
			end
		end

		if consecutiveDeathsInRoom < requirements.ConsecutiveDeathsInRoom.Count then
			return false
		end
	end

	if requirements.ConsecutiveClearsOfRoom ~= nil then
		local consecutiveClearsOfRoom = 0
		if HasSeenRoomEarlierInRun( currentRun, requirements.ConsecutiveClearsOfRoom.Name ) then
			if currentRun.Cleared or currentRun.EndingRoomName ~= requirements.ConsecutiveClearsOfRoom.Name then
				-- Saw the room this run and didn't die in it, streak continues
				consecutiveClearsOfRoom = consecutiveClearsOfRoom + 1
			else
				-- Saw the room this run and died in it, streak is 0
				return false
			end
		end
		for i = #GameState.RunHistory, 1 , -1 do
			local run = GameState.RunHistory[i]
			if HasSeenRoomInRun( run, requirements.ConsecutiveClearsOfRoom.Name ) then
				if run.Cleared or run.EndingRoomName ~= requirements.ConsecutiveClearsOfRoom.Name then
					-- Saw the room this run and didn't die in it, streak continues
					consecutiveClearsOfRoom = consecutiveClearsOfRoom + 1
				else
					-- Saw the room this run and died in it, streak is broken
					break
				end
			end
		end
		if consecutiveClearsOfRoom < requirements.ConsecutiveClearsOfRoom.Count then
			return false
		end
	end

	if requirements.RequiredFalseSeenRoomThisRun ~= nil then
		if HasSeenRoomInRun( currentRun, requirements.RequiredFalseSeenRoomThisRun ) then
			return false
		end
	end

	if requirements.RequiredFalseSeenRoomsThisRun ~= nil then
		for k, roomName in pairs(requirements.RequiredFalseSeenRoomsThisRun) do
			if HasSeenRoomInRun( currentRun, roomName ) then
				return false
			end
		end
	end

	if requirements.RequiredMinTimesSeenRoom ~= nil then
		for requiredRoom, requiredTimesSeen in pairs( requirements.RequiredMinTimesSeenRoom ) do
			if GameState.RoomCountCache[requiredRoom] == nil or GameState.RoomCountCache[requiredRoom] < requiredTimesSeen then
				return false
			end
		end
	end
	if requirements.RequiredMaxTimesSeenRoom ~= nil then
		for requiredRoom, requiredTimesSeen in pairs( requirements.RequiredMaxTimesSeenRoom ) do
			if GameState.RoomCountCache[requiredRoom] == nil or GameState.RoomCountCache[requiredRoom] > requiredTimesSeen then
				return false
			end
		end
	end

	if requirements.RequiredLastKilledByUnits ~= nil and not Contains( requirements.RequiredLastKilledByUnits, LastKilledByUnitName ) then
		return false
	end

	if requirements.RequiredLastKilledByWeaponNames ~= nil and not Contains( requirements.RequiredLastKilledByWeaponNames, LastKilledByWeaponName ) then
		return false
	end

	if requirements.RequiredSlottedTrait ~= nil then
		local hasSlot = false
		for i, traitData in pairs(CurrentRun.Hero.Traits ) do
			if traitData.Slot == requirements.RequiredSlottedTrait then
				hasSlot = true
				break
			end
			if traitData.AltSlot and traitData.AltSlot == requirements.RequiredSlottedTrait then
				hasSlot = true
				break
			end
		end

		if not hasSlot then
			return false
		end
	end

	if requirements.RequiredTrait ~= nil and ( not TraitData[requirements.RequiredTrait] or not HeroHasTrait( requirements.RequiredTrait )) then
		return false
	end

	if requirements.RequiredOneOfTraits ~= nil then
		local hasTrait = false
		for i, traitName in pairs(requirements.RequiredOneOfTraits) do
			if HeroHasTrait( traitName ) then
				hasTrait = true
				break
			end
		end
		if not hasTrait then
			return false
		end
	end

	if requirements.RequiredAnyLastPickedTraits ~= nil then
		local hasTrait = false
		for i, traitName in pairs( requirements.RequiredAnyLastPickedTraits ) do
			if GameState.LastPickedTraitName == traitName then
				hasTrait = true
				break
			end
		end
		if not hasTrait then
			return false
		end
	end

	if requirements.RequiredCountOfTraits ~= nil then
		local numTraits = 0
		for i, traitName in pairs( requirements.RequiredCountOfTraits ) do
			if HeroHasTrait( traitName ) then
				numTraits = numTraits + 1
			end
		end
		if numTraits < requirements.RequiredCountOfTraitsCount then
			return false
		end
	end

	if requirements.RequiredFalseTrait ~= nil and TraitData[requirements.RequiredFalseTrait] and HeroHasTrait( requirements.RequiredFalseTrait ) then
		return false
	end

	if requirements.RequiredFalseTraits ~= nil  then
		for i, traitName in pairs(requirements.RequiredFalseTraits) do
			if HeroHasTrait( traitName ) then
				return false
			end
		end
	end

	if requirements.RequiredTraitCount ~= nil and requirements.RequiredTraitCount > GetTotalTraitCount(CurrentRun.Hero) then
		return false
	end

	if requirements.RequiredTraitsTaken ~= nil then
		for k, traitName in pairs( requirements.RequiredTraitsTaken ) do
			if not GameState.TraitsTaken[traitName] then
				return false
			end
		end
	end
	if requirements.RequiredAnyTraitsTaken ~= nil then
		local anyTrue = false
		for k, traitName in pairs( requirements.RequiredAnyTraitsTaken ) do
			if GameState.TraitsTaken[traitName] then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredClearedWithMetaUpgrades ~= nil then
		for k, upgradeName in pairs( requirements.RequiredClearedWithMetaUpgrades ) do
			if (GameState.ClearedWithMetaUpgrades[upgradeName] or 0) <= 0 then
				return false
			end
		end
	end
	if requirements.RequiredRunHasOneOfTraits ~= nil and not RunHasOneOfTraits(requirements.RequiredRunHasOneOfTraits  ) then
		return false
	end

	if requirements.RequiredClearedWithTraits ~= nil then
		local hasClear = false
		if currentRun.Cleared and RunHasTraits( currentRun, requirements.RequiredClearedWithTraits ) then
			hasClear = true
		else
			for k, prevRun in pairs( GameState.RunHistory ) do
				if prevRun.Cleared and RunHasTraits( prevRun, requirements.RequiredClearedWithTraits ) then
					hasClear = true
					break
				end
			end
		end
		if not hasClear then
			return false
		end
	end

	if requirements.RequiredHasEffect ~= nil and not HasEffect({ Id = CurrentRun.Hero.ObjectId, EffectName = requirements.RequiredHasEffect }) then
		return false
	end
	if requirements.RequiredFalseHasEffect ~= nil and HasEffect({ Id = CurrentRun.Hero.ObjectId, EffectName = requirements.RequiredFalseHasEffect }) then
		return false
	end

	if requirements.RequiredKeepsake ~= nil and GameState.LastAwardTrait ~= requirements.RequiredKeepsake  then
		return false
	end

	if requirements.RequiredAssistKeepsake ~= nil and GameState.LastAssistTrait ~= requirements.RequiredAssistKeepsake  then
		return false
	end

	if requirements.RequiredAnyAssistKeepsake ~= nil and GameState.LastAssistTrait == nil then
		return false
	end

	if requirements.RequiresMaxAssistTrait  ~= nil and ( GameState.LastAssistTrait ~= requirements.RequiresMaxAssistTrait or GetAssistKeepsakeLevel( requirements.RequiresMaxAssistTrait ) < 5 ) then
		return false
	end

	if requirements.RequiresMaxKeepsake ~= nil and GameState.LastAwardTrait ~= nil and not IsKeepsakeMaxed( GameState.LastAwardTrait ) then
		return false
	end

	if requirements.RequiresMaxKeepsakes ~= nil then
		if GameState.LastAwardTrait == nil then
			return false
		end
		for k, keepsakeName in pairs(requirements.RequiresMaxKeepsakes) do
			 if not IsKeepsakeMaxed( keepsakeName ) then
				return false
			end
		end
	end

	if requirements.RequiredAnyKeepsakes ~= nil and not Contains( requirements.RequiredAnyKeepsakes, GameState.LastAwardTrait ) then
		return false
	end

	if requirements.RequiresUsedAssistLastRoom then
		local prevRoom = GetPreviousRoom( currentRun )
		if prevRoom == nil or not prevRoom.UsedAssist then
			return false
		end
	end
	if requirements.RequiredUsedAssistInRoomThisRun ~= nil then
		for roomOrder, roomData in pairs( currentRun.RoomHistory ) do
			if roomData.Name == requirements.RequiredUsedAssistInRoomThisRun and not roomData.UsedAssist then
				return false
			end
		end
	end

	if requirements.RequiredRoom ~= nil then
		if currentRun.Hero.IsDead and CurrentDeathAreaRoom ~= nil then
			if CurrentDeathAreaRoom.Name ~= requirements.RequiredRoom then
				return false
			end
		elseif currentRun.CurrentRoom.Name ~= requirements.RequiredRoom then
			return false
		end
	end

	if requirements.RequiredRooms ~= nil then
		if currentRun.Hero.IsDead and CurrentDeathAreaRoom ~= nil then
			if not Contains( requirements.RequiredRooms, CurrentDeathAreaRoom.Name ) then
				return false
			end
		elseif currentRun.CurrentRoom == nil or not Contains( requirements.RequiredRooms, currentRun.CurrentRoom.Name ) then
			return false
		end
	end
	if requirements.RequiredSeenRooms ~= nil then
		for k, roomName in pairs( requirements.RequiredSeenRooms ) do
			if not HasSeenRoom( roomName ) then
				return false
			end
		end
	end
	if requirements.RequiredFalseSeenRooms ~= nil then
		for k, roomName in pairs( requirements.RequiredFalseSeenRooms ) do
			if HasSeenRoom( roomName ) then
				return false
			end
		end
	end
	if requirements.RequiredSeenRoomsBeforeThisRun ~= nil then
		for k, roomName in pairs( requirements.RequiredSeenRoomsBeforeThisRun ) do
			if not HasSeenRoom( roomName, true ) then
				return false
			end
		end
	end
	if requirements.RequiredFalseSeenRoomsBeforeThisRun ~= nil then
		for k, roomName in pairs( requirements.RequiredFalseSeenRoomsBeforeThisRun ) do
			if HasSeenRoom( roomName, true ) then
				return false
			end
		end
	end
	if requirements.RequiredDeathRoom ~= nil then
		if not DidFailRun( currentRun ) or currentRun.CurrentRoom.Name ~= requirements.RequiredDeathRoom then
			return false
		end
	end
	if requirements.RequiredAnyDeathRooms ~= nil then
		if not DidFailRun( currentRun ) or not Contains( requirements.RequiredAnyDeathRooms, currentRun.CurrentRoom.Name ) then
			return false
		end
	end
	if requirements.RequiredFalseDeathRoom ~= nil and DidFailRun( currentRun ) and currentRun.CurrentRoom.Name == requirements.RequiredFalseDeathRoom then
		return false
	end
	if requirements.RequiredFalseDeathRooms ~= nil and DidFailRun( currentRun ) and Contains( requirements.RequiredFalseDeathRooms, currentRun.CurrentRoom.Name ) then
		return false
	end

	if requirements.RequiredAnyDeathEncounters ~= nil and currentRun.Hero.IsDead then
		if currentRun.CurrentRoom.Encounter == nil or not Contains( requirements.RequiredAnyDeathEncounters, currentRun.CurrentRoom.Encounter.Name ) then
			return false
		end
	end
	if requirements.RequiredFalseDeathEncounters ~= nil and currentRun.Hero.IsDead then
		if currentRun.CurrentRoom.Encounter == nil or Contains( requirements.RequiredFalseDeathEncounters, currentRun.CurrentRoom.Encounter.Name ) then
			return false
		end
	end

	if requirements.RequiresInRun then
		if currentRun.Hero.IsDead then
			return false
		end
	end
	if requirements.RequiresNotInRun then
		if not currentRun.Hero.IsDead then
			return false
		end
	end

	if requirements.CurrentRoomValueTrue ~= nil then
		if currentRun.CurrentRoom ~= nil then
			if not CurrentRun.CurrentRoom[requirements.CurrentRoomValueTrue] then
				return false
			end
		end
	end
	if requirements.CurrentRoomValueFalse ~= nil then
		if currentRun.CurrentRoom ~= nil then
			if CurrentRun.CurrentRoom[requirements.CurrentRoomValueFalse] then
				return false
			end
		end
	end
	if requirements.RequiredRoomValues ~= nil then
		for key, value in pairs( requirements.RequiredRoomValues ) do
			if currentRun.CurrentRoom[key] ~= value then
				return false
			end
		end
	end
	if requirements.RequiredRoomMinValues ~= nil then
		for key, minValue in pairs( requirements.RequiredRoomMinValues ) do
			if (currentRun.CurrentRoom[key] or 0) < minValue then
				return false
			end
		end
	end
	if requirements.RequireRoomMaxValues ~= nil then
		for key, maxValue in pairs( requirements.RequireRoomMaxValues ) do
			if (currentRun.CurrentRoom[key] or 0) > maxValue then
				return false
			end
		end
	end

	if requirements.CurrentRunValueTrue ~= nil then
		if currentRun ~= nil then
			if not CurrentRun[requirements.CurrentRunValueTrue] then
				return false
			end
		end
	end
	if requirements.CurrentRunValueFalse ~= nil then
		if currentRun then
			if CurrentRun[requirements.CurrentRunValueFalse] then
				return false
			end
		end
	end
	if requirements.RequiredRunValues ~= nil then
		if currentRun then
			for key, value in pairs( requirements.RequiredRunValues ) do
				if CurrentRun[key] ~= value then
					return false
				end
			end
		end
	end
	if requirements.RequiredRunMinValues ~= nil then
		if currentRun then
			for key, value in pairs( requirements.RequiredRunMinValues ) do
				if (CurrentRun[key] or 0) < value then
					return false
				end
			end
		end
	end
	if requirements.RequiredRunMaxValues ~= nil then
		if currentRun then
			for key, value in pairs( requirements.RequiredRunMaxValues ) do
				if (CurrentRun[key] or 0) > value then
					return false
				end
			end
		end
	end

	if requirements.CurrentEncounterValueTrue ~= nil then
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.Encounter ~= nil then
			if not CurrentRun.CurrentRoom.Encounter[requirements.CurrentEncounterValueTrue] then
				return false
			end
		end
	end
	if requirements.CurrentEncounterValueFalse ~= nil then
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.Encounter ~= nil then
			if CurrentRun.CurrentRoom.Encounter[requirements.CurrentEncounterValueFalse] then
				return false
			end
		end
	end

	if requirements.RequireOneOfEncountersSeen ~= nil then
		local hasEncounter = false
		for i, name in pairs( requirements.RequireOneOfEncountersSeen ) do
			if HasSeenEncounter( name ) then
				hasEncounter = true
				break
			end
		end

		if not hasEncounter then
			return false
		end
	end

	if requirements.RequireEncounterCompleted ~= nil and not HasEncounterBeenCompleted( requirements.RequireEncounterCompleted ) then
		return false
	end

	if requirements.RequireAnyEncounterCompleted ~= nil then
		local anyCompleted = false
		for k, encounterName in pairs(requirements.RequireAnyEncounterCompleted) do 
			if HasEncounterBeenCompleted( encounterName ) then
				anyCompleted = true
				break
			end
		end
		if not anyCompleted then
			return false
		end
	end

	if requirements.RequireCurrentEncounterCompleted ~= nil then
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.Encounter ~= nil then
			if not HasEncounterBeenCompleted( currentRun.CurrentRoom.Encounter.Name ) then
				return false
			end
		end
	end

	if requirements.RequireCurrentEncounterNotComplete ~= nil then
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.Encounter ~= nil and currentRun.CurrentRoom.Encounter.Completed then
			return false
		end
	end

	if requirements.RequiredAnyPrevRoom ~= nil then
		local previousRoom = GetPreviousRoom( currentRun )
		if previousRoom == nil then
			return false
		end
		if not Contains( requirements.RequiredAnyPrevRoom, previousRoom.Name ) then
			return false
		end
	end
	if requirements.RequiredFalsePrevRooms ~= nil then
		local previousRoom = GetPreviousRoom( currentRun )
		if previousRoom ~= nil and Contains( requirements.RequiredFalsePrevRooms, previousRoom.Name ) then
			return false
		end
	end

	if requirements.RequiredMinExits ~= nil then
		if currentRun.CurrentRoom == nil then
			return false
		end
		DebugAssert({ Condition = currentRun.CurrentRoom.NumExits ~= nil, Text = currentRun.CurrentRoom.Name.." missing NumExits data." })
		if currentRun.CurrentRoom.NumExits < requirements.RequiredMinExits then
			return false
		end
	end

	if requirements.RequiredMinOfferedRewardTypes ~= nil then
		local offeredTypes = {}
		if currentRun.CurrentRoom.OfferedRewards ~= nil then
			for k, offeredReward in pairs( currentRun.CurrentRoom.OfferedRewards ) do
				if offeredReward.Type ~= nil then
					offeredTypes[offeredReward.Type] = true
				end
			end
		end
		if TableLength( offeredTypes ) < requirements.RequiredMinOfferedRewardTypes then
			return false
		end
	end

	if requirements.RequiredFalseRooms ~= nil and currentRun.CurrentRoom ~= nil and Contains( requirements.RequiredFalseRooms, currentRun.CurrentRoom.Name ) then
		return false
	end

	if requirements.RequiredFalseRoomSet ~= nil and currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.RoomSetName == requirements.RequiredFalseRoomSet then
		return false
	end

	if requirements.RequiredEncounters ~= nil and not Contains( requirements.RequiredEncounters, currentRun.CurrentRoom.Encounter.Name ) then
		return false
	end

	if requirements.RequiredFalseEncounters ~= nil and Contains( requirements.RequiredFalseEncounters, currentRun.CurrentRoom.Encounter.Name ) then
		return false
	end

	if requirements.RequiredBiome ~= nil then
		if currentRun.CurrentRoom == nil or currentRun.CurrentRoom.RoomSetName ~= requirements.RequiredBiome then
			return false
		end
	end

	if requirements.RequiredBiomes ~= nil then
		if currentRun.CurrentRoom == nil or not Contains(requirements.RequiredBiome, currentRun.CurrentRoom.RoomSetName ) then
			return false
		end
	end

	if requirements.RequiredFalseBiome ~= nil then
		if currentRun.CurrentRoom == nil or currentRun.CurrentRoom.RoomSetName == requirements.RequiredFalseBiome then
			return false
		end
	end

	if requirements.RequiredEncounterActiveEnemyCapMin ~= nil and currentRun.CurrentRoom.Encounter ~= nil then
		if currentRun.CurrentRoom.Encounter.ActiveEnemyCap ~= nil and currentRun.CurrentRoom.Encounter.ActiveEnemyCap < requirements.RequiredEncounterActiveEnemyCapMin then
			return false
		end
	end

	if requirements.RequiredCompletedRuns ~= nil and GetCompletedRuns() ~= requirements.RequiredCompletedRuns then
		return false
	end

	if requirements.RequiredFalseCompletedRuns ~= nil and GetCompletedRuns() == requirements.RequiredFalseCompletedRuns then
		return false
	end

	if requirements.RequiredMinCompletedRuns ~= nil and GetCompletedRuns() < requirements.RequiredMinCompletedRuns then
		return false
	end

	if requirements.RequiredMaxCompletedRuns ~= nil and GetCompletedRuns() > requirements.RequiredMaxCompletedRuns then
		return false
	end

	if requirements.RequiresRunCleared ~= nil and not currentRun.Cleared then
		return false
	end
	if requirements.RequiresRunNotCleared ~= nil and currentRun.Cleared then
		return false
	end
	if requirements.RequiresLastRunCleared ~= nil and (prevRun == nil or not prevRun.Cleared) then
		return false
	end
	if requirements.RequiresLastRunNotCleared ~= nil and prevRun ~= nil and prevRun.Cleared then
		return false
	end

	if requirements.RequiresBestClearTime and currentRun.Cleared then
		local recordTime = GetFastestRunClearTime( currentRun )
		if currentRun.GameplayTime > recordTime then
			return false
		end
	end

	if requirements.RequiresBestClearTimeLastRun and prevRun ~= nil and prevRun.Cleared then
		local recordTime = GetFastestRunClearTime( prevRun )
		if prevRun.GameplayTime > recordTime then
			return false
		end
	end

	if requirements.RequiredMinClearTime ~= nil and GetFastestRunClearTime( currentRun ) > requirements.RequiredMinClearTime then
		return false
	end

	if requirements.RequiredCurrentClearTimeMin ~= nil and currentRun.GameplayTime < requirements.RequiredCurrentClearTimeMin then
		return false
	end

	if requirements.RequiredCurrentClearTimeMax ~= nil and currentRun.GameplayTime > requirements.RequiredCurrentClearTimeMax then
		return false
	end

	if requirements.RequiredWeaponsFiredThisRun ~= nil then
		local totalFires = 0
		for k, weaponName in pairs( requirements.RequiredWeaponsFiredThisRun.Names ) do
			totalFires = totalFires + (currentRun.WeaponsFiredRecord[weaponName] or 0)
		end
		if totalFires < requirements.RequiredWeaponsFiredThisRun.Count then
			return false
		end
	end

	if requirements.RequiredClearsWithWeapons ~= nil then
		for k, weaponName in pairs( requirements.RequiredClearsWithWeapons.Names ) do
			if (GameState.TimesClearedWeapon[weaponName] or 0) <= 0 then
				return false
			end
			if requirements.RequiredClearsWithWeapons.ShrinePoints ~= nil and (GameState.WeaponRecordsShrinePoints[weaponName] or 0) <= requirements.RequiredClearsWithWeapons.ShrinePoints then
				return false
			end
			if requirements.RequiredClearsWithWeapons.ClearTime ~= nil and (GameState.WeaponRecordsClearTime[weaponName] or 999999) > requirements.RequiredClearsWithWeapons.ClearTime then
				return false
			end
		end
	end

	if requirements.RequiredMinBountiesEarned and GetTotalEarnedBounties() < requirements.RequiredMinBountiesEarned  then
		return false
	end

	if requirements.ReachedShrineSoftCapWithWeaponName ~= nil and GetCurrentRunClearedShrinePointThreshold( requirements.ReachedShrineSoftCapWithWeaponName ) <= GetMaximumAllocatableShrinePoints() then
		return false
	end

	if requirements.ReachedShrineSoftCapWithAnyWeaponName ~= nil then
		local anyWeapon = false
		for i, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
			if GetCurrentRunClearedShrinePointThreshold( weaponName ) > GetMaximumAllocatableShrinePoints() then
				anyWeapon = true
			end
		end
		if not anyWeapon then
			return false
		end
	end

	if requirements.ReachedShrineSoftCapWithAllWeapons ~= nil then
		local allWeapons = true
		for i, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
			if allWeapons and GetCurrentRunClearedShrinePointThreshold( weaponName ) <= GetMaximumAllocatableShrinePoints() then
				allWeapons = false
			end
		end
		if not allWeapons then
			return false
		end
	end

	if requirements.RequiresLessThanTargetShrinePointThreshold ~= nil and GameState.SpentShrinePointsCache and ( GameState.SpentShrinePointsCache >= GetShrinePointLimit() or GetCurrentRunClearedShrinePointThreshold( GetEquippedWeapon() ) > GetMaximumAllocatableShrinePoints()) then
		return false
	end

	if requirements.RequiresShrinePointsAtThreshold ~= nil and GameState.SpentShrinePointsCache and ( GameState.SpentShrinePointsCache ~= GetShrinePointLimit() or GetCurrentRunClearedShrinePointThreshold( GetEquippedWeapon() ) > GetMaximumAllocatableShrinePoints()) then
		return false
	end

	if requirements.RequiredMinShrinePointsAboveThreshold ~= nil and GameState.SpentShrinePointsCache and ( GameState.SpentShrinePointsCache - GetShrinePointLimit() ) < requirements.RequiredMinShrinePointsAboveThreshold then
		return false
	end

	if requirements.RequiredActiveShrinePointsMax ~= nil and GameState.SpentShrinePointsCache and GameState.SpentShrinePointsCache > requirements.RequiredActiveShrinePointsMax then
		return false
	end

	if requirements.RequiredActiveShrinePointsMin ~= nil and GameState.SpentShrinePointsCache and GameState.SpentShrinePointsCache < requirements.RequiredActiveShrinePointsMin then
		return false
	end

	local lastRunShrinePoints = 0
	if prevRun and prevRun.ShrinePointsCache then
		lastRunShrinePoints = prevRun.ShrinePointsCache
	end

	if requirements.RequiresMoreActiveShrinePointsThanPrevRun and GameState.SpentShrinePointsCache <= lastRunShrinePoints then
		return false
	end

	if requirements.RequiresLessActiveShrinePointsThanPrevRun and GameState.SpentShrinePointsCache >= lastRunShrinePoints then
		return false
	end

	if requirements.RequiredAtLeastShrinePointClear ~= nil and GetHighestShrinePointRunClear(currentRun) < requirements.RequiredAtLeastShrinePointClear then
		return false
	end

	if requirements.RequiredAtMostShrinePointClear ~= nil and GetHighestShrinePointRunClear(currentRun) > requirements.RequiredAtMostShrinePointClear then
		return false
	end

	if requirements.RequiredMinShrinePointThresholdClear ~= nil then
		local recordShrinePoints = GetHighestRunClearShrinePointThreshold( )
		if requirements.RequiredMinShrinePointThresholdClear > recordShrinePoints then
			return false
		end
	end
	if requirements.RequiredMaxShrinePointThresholdClear ~= nil then
		local recordShrinePoints = GetHighestRunClearShrinePointThreshold( )
		if requirements.RequiredMaxShrinePointThresholdClear <= recordShrinePoints then
			return false
		end
	end

	if requirements.RequiredWeaponsUnlocked ~= nil then
		for k, weaponName in pairs(requirements.RequiredWeaponsUnlocked) do
			if not IsWeaponUnlocked(weaponName) then
				return false
			end
		end
	end
	if requirements.RequiredAnyWeaponsUnlocked ~= nil then
		local anyTrue = false
		for k, weaponName in pairs(requirements.RequiredAnyWeaponsUnlocked) do
			if IsWeaponUnlocked(weaponName) then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredMinUnlockedWeaponEnchantments ~= nil and GetNumUnlockedWeaponUpgrades() < requirements.RequiredMinUnlockedWeaponEnchantments then
		return false
	end
	if requirements.RequiredMaxUnlockedWeaponEnchantments ~= nil and GetNumUnlockedWeaponUpgrades() > requirements.RequiredMaxUnlockedWeaponEnchantments then
		return false
	end
	if requirements.RequiredMinMaxedWeaponEnchantments and GetNumMaxedWeaponUpgrades() < requirements.RequiredMinMaxedWeaponEnchantments then
		return false
	end
	if requirements.RequiredMaxMaxedWeaponEnchantments and GetNumMaxedWeaponUpgrades() > requirements.RequiredMinMaxedWeaponEnchantments then
		return false
	end

	if requirements.RequiredUniqueGodTraitsTaken ~= nil and GetNumUniqueGodTraitsTaken( ) < requirements.RequiredUniqueGodTraitsTaken then
		return false
	end

	if requirements.RequiredUniqueWeaponUpgradesTaken ~= nil and GetNumUniqueWeaponUpgradesTaken( ) < requirements.RequiredUniqueWeaponUpgradesTaken then
		return false
	end

	if requirements.RequiredMinSuperLockKeysSpentOnWeapon ~= nil then
		local totalInvestment = 0
		local weaponName = requirements.RequiredMinSuperLockKeysSpentOnWeapon.Name
		for index in pairs( WeaponUpgradeData[weaponName] ) do
			for level = 1, (GetWeaponUpgradeLevel( weaponName, index )) do
				totalInvestment = totalInvestment + (WeaponUpgradeData[weaponName][index].Costs[level] or 0)
			end
		end
		if totalInvestment < requirements.RequiredMinSuperLockKeysSpentOnWeapon.Count then
			return false
		end
	end

	if requirements.RequiredMaxWeaponUpgrade ~= nil and requirements.RequiredMaxWeaponUpgradeIndex ~= nil then
		if not IsWeaponUpgradeMaxed( requirements.RequiredMaxWeaponUpgrade, requirements.RequiredMaxWeaponUpgradeIndex ) then
			return false
		end
	end
	if requirements.RequiredFalseMaxWeaponUpgrade ~= nil and requirements.RequiredFalseMaxWeaponUpgradeIndex ~= nil then
		if IsWeaponUpgradeMaxed( requirements.RequiredFalseMaxWeaponUpgrade, requirements.RequiredFalseMaxWeaponUpgradeIndex ) then
			return false
		end
	end

	if requirements.RequiredLastInteractedWeaponUpgrade ~= nil and ( GameState.LastInteractedWeaponUpgrade == nil or GetWeaponUpgradeTrait( GameState.LastInteractedWeaponUpgrade.WeaponName, GameState.LastInteractedWeaponUpgrade.ItemIndex ) ~= requirements.RequiredLastInteractedWeaponUpgrade ) then
		return false
	end

	if requirements.RequiredLastInteractedWeaponName ~= nil and ( GameState.LastInteractedWeaponUpgrade == nil or GameState.LastInteractedWeaponUpgrade.WeaponName ~= requirements.RequiredLastInteractedWeaponName ) then
		return false
	end

	if requirements.RequiredLastInteractedWeaponUpgradeMinLevel ~= nil
		and GameState.LastInteractedWeaponUpgrade ~= nil
		and GetWeaponUpgradeLevel( GameState.LastInteractedWeaponUpgrade.WeaponName, GameState.LastInteractedWeaponUpgrade.ItemIndex ) < requirements.RequiredLastInteractedWeaponUpgradeMinLevel then
		return false
	end

	if requirements.RequiredLastInteractedWeaponUpgradeMaxLevel ~= nil
		and GameState.LastInteractedWeaponUpgrade ~= nil
		and GetWeaponUpgradeLevel( GameState.LastInteractedWeaponUpgrade.WeaponName, GameState.LastInteractedWeaponUpgrade.ItemIndex ) > requirements.RequiredLastInteractedWeaponUpgradeMaxLevel then
		return false
	end

	if requirements.RequiredLastInteractedWeaponUpgradeMaxed ~= nil then
		if GameState.LastInteractedWeaponUpgrade == nil then
			return false
		end

		if GetWeaponUpgradeLevel( GameState.LastInteractedWeaponUpgrade.WeaponName, GameState.LastInteractedWeaponUpgrade.ItemIndex ) < WeaponUpgradeData[GameState.LastInteractedWeaponUpgrade.WeaponName][GameState.LastInteractedWeaponUpgrade.ItemIndex ].MaxUpgradeLevel then
			return false
		end
	end

	if requirements.RequiredInactiveMetaUpgrade ~= nil and GetNumMetaUpgrades( requirements.RequiredInactiveMetaUpgrade ) > 0 then
		return false
	end
	if requirements.RequiredActiveMetaUpgrade ~= nil and GetNumMetaUpgrades( requirements.RequiredActiveMetaUpgrade ) < 1 then
		return false
	end

	if requirements.RequiredMetaUpgradeSelected ~= nil then
		local upgradeName = requirements.RequiredMetaUpgradeSelected
		local metaUpgradeFound = false

		local nulledMetaUpgradeCount = GetNulledMetaUpgradeCount()
		for k, selectedUpgradeName in pairs( GameState.MetaUpgradesSelected ) do
			if k > (#MetaUpgradeOrder - nulledMetaUpgradeCount) then
				if MetaUpgradeOrder[k][1] == upgradeName then
					metaUpgradeFound = true
				end
			elseif selectedUpgradeName == upgradeName then
				metaUpgradeFound = true
				break
			end
		end
		if not metaUpgradeFound then
			return false
		end
	end

	if requirements.RequiredMinActiveMetaUpgradeLevel ~= nil then
		if GetNumMetaUpgrades( requirements.RequiredMinActiveMetaUpgradeLevel.Name ) < requirements.RequiredMinActiveMetaUpgradeLevel.Count then
			return false
		end
	end

	if requirements.RequiredMaxActiveMetaUpgradeLevel ~= nil then
		if GetNumMetaUpgrades( requirements.RequiredMaxActiveMetaUpgradeLevel.Name ) > requirements.RequiredMaxActiveMetaUpgradeLevel.Count then
			return false
		end
	end

	if requirements.RequiredActiveMetaUpgradeLevel ~= nil then
		if GetNumMetaUpgrades( requirements.RequiredActiveMetaUpgradeLevel.Name ) ~= requirements.RequiredActiveMetaUpgradeLevel.Count then
			return false
		end
	end
	
	if requirements.RequiredAllMetaUpgradesInvestment ~= nil then
		if not GameState.MetaUpgradeState then
			return false
		end

		for i, data in pairs(MetaUpgradeOrder) do
			for s, metaupgradeName in pairs(data) do
				if not GameState.MetaUpgradeState[metaupgradeName] and not GameState.MetaUpgrades[metaupgradeName] then
						
					return false
				end
				local investment = GameState.MetaUpgradeState[metaupgradeName] or 0
				if IsMetaUpgradeActive(metaupgradeName) then
					investment = GameState.MetaUpgrades[metaupgradeName] or 0
				end

				if investment < requirements.RequiredAllMetaUpgradesInvestment then
					return false
				end
			end
		end
	end

	if requirements.RequiredAllMetaUpgradesMaxed ~= nil then
		if not GameState.MetaUpgradeState then
			return false
		end

		for i, data in pairs(MetaUpgradeOrder) do
			for s, metaupgradeName in pairs(data) do
				if not GameState.MetaUpgradeState[metaupgradeName] and not GameState.MetaUpgrades[metaupgradeName] then
						
					return false
				end
				local investment = GameState.MetaUpgradeState[metaupgradeName] or 0
				if IsMetaUpgradeActive(metaupgradeName) then
					investment = GameState.MetaUpgrades[metaupgradeName] or 0
				end

				if MetaUpgradeData[metaupgradeName].MaxInvestment then
					if investment < MetaUpgradeData[metaupgradeName].MaxInvestment then
						return false
					end
				elseif MetaUpgradeData[metaupgradeName].CostTable then
					if MetaUpgradeData[metaupgradeName].CostTable[investment + 1] then
						return false
					end
				end
			end
		end
	end

	if requirements.RequiredTextLinesPerMetaUpgradeLevel ~= nil then
		if GetNumMetaUpgrades( requirements.RequiredTextLinesPerMetaUpgradeLevel.MetaUpgradeName ) >= requirements.RequiredTextLinesPerMetaUpgradeLevel.Count then
			for k, textLineSet in pairs( requirements.RequiredTextLinesPerMetaUpgradeLevel.TextLines ) do
				if TextLinesRecord[textLineSet] == nil then
					return false
				end
			end
		end
	end

	if requirements.RequiredSupportAINames ~= nil then
		for k, requiredSupportAIName in pairs( requirements.RequiredSupportAINames ) do
			if not currentRun.SupportAINames[requiredSupportAIName] then
				return false
			end
		end
	end
	if requirements.RequiredFalseSupportAINames ~= nil then
		for k, requiredSupportAIName in pairs( requirements.RequiredFalseSupportAINames ) do
			if currentRun.SupportAINames[requiredSupportAIName] then
				return false
			end
		end
	end
	if requirements.RequiredMinSupportAINames ~= nil then
		local supportAINames = {}
		for enemyId, enemy in pairs( ActiveEnemies ) do
			ConcatTableValues( supportAINames, enemy.SupportAINames )
		end
		if TableLength( supportAINames ) < requirements.RequiredMinSupportAINames then
			return false
		end
	end
	if requirements.RequiredMaxSupportAINames ~= nil then
		local supportAINames = {}
		for enemyId, enemy in pairs( ActiveEnemies ) do
			ConcatTableValues( supportAINames, enemy.SupportAINames )
		end
		if TableLength( supportAINames ) > requirements.RequiredMaxSupportAINames then
			return false
		end
	end

	if requirements.MaxUnitsByType ~= nil then
		for name, count in pairs(requirements.MaxUnitsByType) do
			if #GetIdsByType({ Name = name }) >= count then
				return false
			end
		end
	end

	if requirements.RequiredRunDepth ~= nil and currentRunDepth ~= requirements.RequiredRunDepth then
		return false
	end

	if requirements.RequiredMinDepth ~= nil and currentRunDepth < requirements.RequiredMinDepth then
		return false
	end

	if requirements.RequiredMaxDepth ~= nil and currentRunDepth >= requirements.RequiredMaxDepth then
		return false
	end

	if requirements.RequiredBiomeDepth ~= nil and currentBiomeDepth ~= requirements.RequiredBiomeDepth then
		return false
	end

	if requirements.RequiresGreaterThanPrevRunDepth ~= nil and prevRun ~= nil then
		if currentRunDepth <= prevRun.RunDepthCache then
			return false
		end
	end

	if not args.SkipMinBiomeDepth and (CurrentRun.CurrentRoom == nil or not CurrentRun.CurrentRoom.SkipMinBiomeDepthRequirements) and requirements.RequiredMinBiomeDepth ~= nil and currentBiomeDepth < requirements.RequiredMinBiomeDepth then
		return false
	end

	if requirements.EliteShrineUpgradeMinBiomeDepth ~= nil and requirements.IsElite and GetNumMetaUpgrades("EnemyEliteShrineUpgrade") > 0 then
		if currentBiomeDepth < requirements.EliteShrineUpgradeMinBiomeDepth then
			return false
		end
	end

	if requirements.RequiredMaxBiomeDepth ~= nil and currentBiomeDepth > requirements.RequiredMaxBiomeDepth then
		return false
	end

	if currentRun.WingDepth ~= nil then
		if requirements.RequiredMinWingDepth ~= nil and currentRun.WingDepth < requirements.RequiredMinWingDepth then
			return false
		end
		if requirements.RequiredMaxWingDepth ~= nil and currentRun.WingDepth > requirements.RequiredMaxWingDepth then
			return false
		end
	end

	if requirements.RequiredLastLinePlayed ~= nil and not Contains( requirements.RequiredLastLinePlayed, LastLinePlayed ) then
		return false
	end

	if requirements.RequiredPlayed ~= nil then
		if type(requirements.RequiredPlayed) ~= "table" then
			if SpeechRecord[requirements.RequiredPlayed] == nil then
				return false
			end
		else
			for k, voiceLine in pairs( requirements.RequiredPlayed ) do
				if SpeechRecord[voiceLine] == nil then
					return false
				end
			end
		end
	end
	if requirements.RequiredFalsePlayed ~= nil then
		for k, voiceLine in pairs( requirements.RequiredFalsePlayed ) do
			if SpeechRecord[voiceLine] ~= nil then
				return false
			end
		end
	end

	if requirements.RequiredPlayedThisRun ~= nil then
		for k, voiceLine in pairs( requirements.RequiredPlayedThisRun ) do
			if not currentRun.SpeechRecord[voiceLine] then
				return false
			end
		end
	end
	if requirements.RequiredAnyPlayedThisRun ~= nil then
		local anyTrue = false
		for k, voiceLine in pairs( requirements.RequiredAnyPlayedThisRun ) do
			if Contains( currentRun.SpeechRecord, voiceLine ) then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end
	if requirements.RequiredFalsePlayedThisRun ~= nil then
		for k, voiceLine in pairs( requirements.RequiredFalsePlayedThisRun ) do
			if currentRun.SpeechRecord[voiceLine] then
				return false
			end
		end
	end
	if requirements.RequiredFalsePlayedLastRun ~= nil and prevRun ~= nil then
		for k, voiceLine in pairs( requirements.RequiredFalsePlayedLastRun ) do
			if prevRun.SpeechRecord ~= nil and prevRun.SpeechRecord[voiceLine] then
				return false
			end
		end
	end

	if requirements.RequiredPlayedThisRoom ~= nil and not ContainsAny( requirements.RequiredPlayedThisRoom, currentRun.CurrentRoom.VoiceLinesPlayed ) then
		return false
	end

	if requirements.RequiredFalsePlayedThisRoom ~= nil and ContainsAny( requirements.RequiredFalsePlayedThisRoom, currentRun.CurrentRoom.VoiceLinesPlayed ) then
		return false
	end

	if requirements.RequiredRoomThisRun ~= nil then
		local roomData = RoomData[requirements.RequiredRoomThisRun]
		if roomData == nil or currentRun.RoomCountCache[roomData.Name] == nil or currentRun.RoomCountCache[roomData.Name] <= 0 then
			return false
		end
	end
	if requirements.RequiredRoomsThisRun ~= nil then
		for k, roomName in pairs( requirements.RequiredRoomsThisRun ) do
			if currentRun.RoomCountCache[roomName] == nil or currentRun.RoomCountCache[roomName] == 0 then
				return false
			end
		end
	end
	if requirements.RequiredAnyRoomsThisRun ~= nil then
		local anyTrue = false
		for k, roomName in pairs( requirements.RequiredAnyRoomsThisRun ) do
			if currentRun.RoomCountCache[roomName] ~= nil and currentRun.RoomCountCache[roomName] >= 1 then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredRoomLastRun ~= nil then
		local roomData = RoomData[requirements.RequiredRoomLastRun]
		if roomData == nil or prevRun == nil or prevRun.RoomCountCache[roomData.Name] == nil or prevRun.RoomCountCache[roomData.Name] < 1  then
			return false
		end
	end
	if requirements.RequiredAnyRoomsLastRun ~= nil then
		local anyTrue = false
		if prevRun == nil then
			return false
		end
		for k, roomName in pairs( requirements.RequiredAnyRoomsLastRun ) do
			if prevRun.RoomCountCache[roomName] ~= nil and prevRun.RoomCountCache[roomName] >= 1 then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end
	if requirements.RequiredFalseRoomLastRun ~= nil then
		local roomData = RoomData[requirements.RequiredFalseRoomLastRun]
		if roomData ~= nil and prevRun ~= nil and prevRun.RoomCountCache[roomData.Name]~= nil and prevRun.RoomCountCache[roomData.Name] > 0 then
			return false
		end
	end

	if requirements.RequiredEncounterThisRun ~= nil then
		if not HasEncounterOccurred( currentRun, requirements.RequiredEncounterThisRun ) then
			return false
		end
	end

	if requirements.RequiredEncountersThisRun ~= nil then
		for k, encounterName in pairs( requirements.RequiredEncountersThisRun ) do
			if not HasEncounterOccurred( currentRun, encounterName, true ) then
				return false
			end
		end
	end

	if requirements.RequiredAnyEncountersThisRun ~= nil then
		local anyTrue = false
		for k, encounterName in pairs( requirements.RequiredAnyEncountersThisRun ) do
			if HasEncounterOccurred( currentRun, encounterName, true ) then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredSeenEncounter ~= nil then
		if not HasSeenEncounter( requirements.RequiredSeenEncounter ) then
			return false
		end
	end

	if requirements.RequiredCompletedEncounter ~= nil then
		if not HasEncounterOccurred( currentRun, requirements.RequiredCompletedEncounter, true ) then
			return false
		end
	end

	if requirements.RequiredMinEncountersThisRun ~= nil then
		local count = 0
		for k, encounterName in pairs( requirements.RequiredMinEncountersThisRun.Names ) do
			count = count + (currentRun.EncountersCompletedCache[encounterName] or 0)
		end
		if count < requirements.RequiredMinEncountersThisRun.Count then
			return false
		end
	end

	if requirements.RequiredKillEnemiesFound and IsEmpty( RequiredKillEnemies ) then
		return false
	end

	if requirements.RequiredKillEnemiesNotFound ~= nil and not IsEmpty( RequiredKillEnemies ) then
		return false
	end

	if requirements.RequiredMinKillEnemies and TableLength( RequiredKillEnemies ) < requirements.RequiredMinKillEnemies then
		return false
	end

	if requirements.RequiredAnyActiveEnemyTypes and ActiveEnemies ~= nil then
		local anyTrue = false
		for k, enemy in pairs( ActiveEnemies ) do
			if Contains( requirements.RequiredAnyActiveEnemyTypes, enemy.Name ) then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredUnitAlive ~= nil then
		local unitId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = requirements.RequiredUnitAlive })
		if not IsAlive({ Id = unitId }) then
			return false
		end
	end
	if requirements.RequiredAnyUnitAlive ~= nil then
		local anyTrue = false
		for k, requiredUnit in pairs( requirements.RequiredAnyUnitAlive ) do
			local unitId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = requiredUnit })
			if IsAlive({ Id = unitId }) then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end
	if requirements.RequiredUnitNotAlive ~= nil then
		local unitId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = requirements.RequiredUnitNotAlive })
		if IsAlive({ Id = unitId }) then
			return false
		end
	end
	if requirements.RequiredUnitsNotAlive ~= nil then
		for k, unit in pairs( requirements.RequiredUnitsNotAlive ) do
			local unitId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = unit })
			if IsAlive({ Id = unitId }) then
				return false
			end
		end
	end

	if requirements.RequiredUnitNotDead ~= nil then
		local unitId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = requirements.RequiredUnitNotDead })
		if ActiveEnemies[unitId] == nil or ActiveEnemies[unitId].IsDead then
			return false
		end
	end

	if requirements.RequiredAnyUnitNotDead ~= nil then
		local anyTrue = false
		for k, requiredUnit in pairs( requirements.RequiredAnyUnitNotDead ) do
			local unitId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = requiredUnit })
			if ActiveEnemies[unitId] ~= nil and not ActiveEnemies[unitId].IsDead then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredMainWeapon ~= nil and not currentRun.Hero.Weapons[requirements.RequiredMainWeapon] then
		return false
	end

	if requirements.RequiredMetaUpgradeUnlocked ~= nil and not GameState.MetaUpgradesUnlocked[requirements.RequiredMetaUpgradeUnlocked] then
		return false
	end
	if requirements.RequiredMetaUpgradeStageUnlocked ~= nil and GameState.MetaUpgradeStagesUnlocked < requirements.RequiredMetaUpgradeStageUnlocked then
		return false
	end

	if requirements.RequiredWeaponsUnlocked ~= nil then
		for k, weaponName in pairs( requirements.RequiredWeaponsUnlocked ) do
			if not GameState.WeaponsUnlocked[weaponName] then
				return false
			end
		end
	end
	if requirements.RequiredFalseWeaponsUnlocked ~= nil then
		for k, weaponName in pairs( requirements.RequiredFalseWeaponsUnlocked ) do
			if GameState.WeaponsUnlocked[weaponName] then
				return false
			end
		end
	end

	if requirements.RequiredMinRunsWithWeapons ~= nil then
		for weaponName, runCount in pairs( requirements.RequiredMinRunsWithWeapons ) do
			local count = 0
			for k, run in pairs( GameState.RunHistory ) do
				if run.WeaponsCache ~= nil and run.WeaponsCache[weaponName] then
					count = count + 1
				end
			end
			if count < runCount then
				return false
			end
		end
	end
	if requirements.RequiredMaxRunsWithWeapons ~= nil then
		for weaponName, runCount in pairs( requirements.RequiredMaxRunsWithWeapons ) do
			local count = 0
			for k, run in pairs( GameState.RunHistory ) do
				if run.WeaponsCache ~= nil and run.WeaponsCache[weaponName] then
					count = count + 1
				end
			end
			if count > runCount then
				return false
			end
		end
	end

	if requirements.RequiredMinAwardTraits ~= nil and UIData.AwardMenu.AvailableTraits ~= nil then
		local numAwardTraits = 0
		for itemIndex, upgradeData in ipairs(UIData.AwardMenu.AvailableTraits) do
			if upgradeData.Unlocked then
				numAwardTraits = numAwardTraits + 1
			end
		end
		if requirements.RequiredMinAwardTraits > numAwardTraits then
			return false
		end
	end

	if requirements.RequiredFalseLootPickup ~= nil and GameState.LootPickups[requirements.RequiredFalseLootPickup] ~= nil then
		return false
	end

	if requirements.RequiredOnlyNotPickedUp ~= nil then
		if GameState.LootPickups[requirements.RequiredOnlyNotPickedUp] then
			return false
		end

		local eligibleLootNames = OrderedKeysToList( LootData )
		local output = {}
		for i, lootName in pairs(eligibleLootNames) do
			local lootData = LootData[lootName]
			if not lootData.DebugOnly and lootData.GodLoot and not GameState.LootPickups[lootName] and lootName ~= requirements.RequiredOnlyNotPickedUp and lootName ~= requirements.RequiredOnlyNotPickedUpIgnoreName then
				return false
			end
		end
	end

	if requirements.RequiredLootChoices ~= nil and requirements.RequiredLootChoices ~= CalcNumLootChoices() then
		return false
	end

	if requirements.RequiredMinNumLockedWeapons ~= nil and GetNumLockedWeapons() < requirements.RequiredMinNumLockedWeapons then
		return false
	end

	if requirements.RequiredMinTotalKills ~= nil and ( GameState.TotalRequiredEnemyKills == nil or GameState.TotalRequiredEnemyKills < requirements.RequiredMinTotalKills ) then
		return false
	end

	if requirements.RequiredKills ~= nil then
		for requiredKill, requiredKillCount in pairs( requirements.RequiredKills ) do
			if GameState.EnemyKills[requiredKill] == nil or GameState.EnemyKills[requiredKill] < requiredKillCount then
				return false
			end
		end
	end

	if requirements.RequiredFalseKills ~= nil then
		for k, requiredKill in pairs(requirements.RequiredFalseKills ) do
			if GameState.EnemyKills[requiredKill] ~= nil and GameState.EnemyKills[requiredKill] > 0 then
				return false
			end
		end
	end

	if requirements.RequiredEliteAttributeKills ~= nil then
		for requiredKill, requiredKillCount in pairs( requirements.RequiredEliteAttributeKills ) do
			if (GameState.EnemyEliteAttributeKills[requiredKill] or 0) < requiredKillCount then
				return false
			end
		end
	end

	if requirements.RequiredKillsThisRun ~= nil then
		local numKillsThisRun = 0
		for k, requiredKill in pairs( requirements.RequiredKillsThisRun ) do
			for roomOrder, room in pairs( currentRun.RoomHistory ) do
				if room.Kills ~= nil and room.Kills[requiredKill] ~= nil then
					numKillsThisRun = numKillsThisRun + room.Kills[requiredKill]
				end
			end
		end
		if numKillsThisRun <= 0 then
			return false
		end
	end
	if requirements.RequiredFalseKillsThisRun ~= nil then
		local numKillsThisRun = 0
		for k, requiredKill in pairs( requirements.RequiredFalseKillsThisRun ) do
			for roomOrder, room in pairs( currentRun.RoomHistory ) do
				if room.Kills ~= nil and room.Kills[requiredKill] ~= nil then
					numKillsThisRun = numKillsThisRun + room.Kills[requiredKill]
				end
			end
		end
		if numKillsThisRun > 0 then
			return false
		end
	end

	if requirements.RequiredAnyKillsThisRun ~= nil then
		local anyKills = false
		for k, requiredKill in pairs( requirements.RequiredAnyKillsThisRun ) do
			for roomOrder, room in pairs( currentRun.RoomHistory ) do
				if room.Kills ~= nil and room.Kills[requiredKill] ~= nil then
					anyKills = true
					break
				end
			end
		end
		if not anyKills then
			return false
		end
	end

	if requirements.RequiredKillsLastRun ~= nil then
		if prevRun == nil then
			return false
		end
		local numKillsLastRun = 0
		for k, requiredKill in pairs( requirements.RequiredKillsLastRun ) do
			for roomOrder, room in pairs( prevRun.RoomHistory ) do
				if room.Kills ~= nil and room.Kills[requiredKill] ~= nil then
					numKillsLastRun = numKillsLastRun + room.Kills[requiredKill]
				end
			end
		end
		if numKillsLastRun <= 0 then
			return false
		end
	end

	if requirements.RequiredBossPhase ~= nil and ActiveEnemies[CurrentRun.CurrentRoom.BossId] ~= nil then
		local boss = ActiveEnemies[CurrentRun.CurrentRoom.BossId]
		if boss.CurrentPhase ~= requirements.RequiredBossPhase then
			return false
		end
	end
	if requirements.RequiredFalseBossPhase ~= nil and ActiveEnemies[CurrentRun.CurrentRoom.BossId] ~= nil then
		local boss = ActiveEnemies[CurrentRun.CurrentRoom.BossId]
		if boss.CurrentPhase == requirements.RequiredFalseBossPhase then
			return false
		end
	end

	if requirements.RequiredMinMaximumLastStands ~= nil then
		if currentRun.Hero.MaxLastStands == nil or currentRun.Hero.MaxLastStands < requirements.RequiredMinMaximumLastStands then
			return false
		end
	end

	if requirements.RequiredMaxHealthFraction ~= nil then
		local currentHealthFraction = currentRun.Hero.Health / currentRun.Hero.MaxHealth
		if currentHealthFraction > requirements.RequiredMaxHealthFraction then
			return false
		end
	end

	if requirements.RequiredMinHealthFraction ~= nil then
		local currentHealthFraction = currentRun.Hero.Health / currentRun.Hero.MaxHealth
		if currentHealthFraction < requirements.RequiredMinHealthFraction then
			return false
		end
	end

	if requirements.RequiredMinMaxHealthAmount ~= nil then
		local currentMaxHealth = currentRun.Hero.MaxHealth
		if currentMaxHealth < requirements.RequiredMinMaxHealthAmount then
			return false
		end
	end

	if requirements.RequiredMaxLastStands ~= nil then
		if GetNumLastStands( currentRun.Hero ) > requirements.RequiredMaxLastStands then
			return false
		end
	end

	if requirements.RequiredLastGodLoot ~= nil and CurrentLootData ~= nil and CurrentLootData.Name ~= requirements.RequiredLastGodLoot then
		return false
	end

	if requirements.RequiredLastGodGender ~= nil and CurrentLootData ~= nil and CurrentLootData.Gender ~= requirements.RequiredLastGodGender then
		return false
	end

	if requirements.RequiredSwappedGodLoot ~= nil and currentRun.CurrentRoom.ReplacedTraitSource ~= requirements.RequiredSwappedGodLoot then
		return false
	end

	if requirements.RequiresLastUpgradeSwapped ~= nil and currentRun.CurrentRoom.ReplacedTraitSource == nil then
		return false
	end

	if CurrentLootData ~= nil then
		if requirements.RequiresSwappedGodLoot and not HasExchangeOnLoot( CurrentLootData ) then
			return false
		end

		if requirements.HasTraitNameInRoom and not HasTraitOnLoot( CurrentLootData, requirements.HasTraitNameInRoom ) then
			return false
		end

		if requirements.HasAnyTraitNamesInRoom and not HasTraitsOnLoot( CurrentLootData, requirements.HasAnyTraitNamesInRoom ) then
			return false
		end

		if requirements.ValuableUpgradeInRoom ~= nil then

			local meetsMinRarityRequirement = false
			local meetsHighestRarityRequirement = false


			if requirements.ValuableUpgradeInRoom.AllAtLeastRarity ~= nil and AllAtLeastRarity( CurrentLootData, requirements.ValuableUpgradeInRoom.AllAtLeastRarity) then
				meetsMinRarityRequirement = true
			end

			if requirements.ValuableUpgradeInRoom.HasAtLeastRarity ~= nil and HasAtLeastRarity( CurrentLootData, requirements.ValuableUpgradeInRoom.HasAtLeastRarity) then
				meetsHighestRarityRequirement = true
			end
			if not meetsMinRarityRequirement or not meetsHighestRarityRequirement then
				return false
			end
		end
	end

	if requirements.RequiredRewardInRoom ~= nil then
		local hasReward = false
		for i, value in pairs( ActivatedObjects ) do
			if value.Name == requirements.RequiredRewardInRoom then
				hasReward = true
				break
			end
		end
		if not hasReward then
			return false
		end
	end

	if requirements.RequiredFalseRewardTypesInRoom ~= nil then
		for i, value in pairs( ActivatedObjects ) do
			if Contains( requirements.RequiredFalseRewardTypesInRoom, value.Name ) then
				return false
			end
		end
	end

	if requirements.RequiredFalseRewardType ~= nil then
		if currentRun.CurrentRoom.ChosenRewardType == requirements.RequiredFalseRewardType then
			return false
		end
	end

	if requirements.RequiredNotActivatedThisRun ~= nil and currentRun.ActivationRecord[requirements.RequiredNotActivatedThisRun] then
		return false
	end
	if requirements.RequiredIdsNotActivatedThisRun ~= nil then
		for i, id in pairs( requirements.RequiredIdsNotActivatedThisRun ) do
			if currentRun.ActivationRecord[id] then
				return false
			end
		end
	end

	if requirements.RequiredRejectedGodGender ~= nil and CurrentRun.CurrentRoom.RejectedLootData ~= nil and CurrentRun.CurrentRoom.RejectedLootData.Gender ~= requirements.RequiredRejectedGodGender then
		return false
	end

	if requirements.RequiredSpurnedGodName ~= nil and CurrentRun.CurrentRoom.Encounter.SpurnedGodName ~= requirements.RequiredSpurnedGodName then
		return false
	end
	if requirements.RequiredFalseSpurnedGodName ~= nil and CurrentRun.CurrentRoom.Encounter.SpurnedGodName ~= nil and CurrentRun.CurrentRoom.Encounter.SpurnedGodName == requirements.RequiredFalseSpurnedGodName then
		return false
	end

	if requirements.RequiredMinRunsCleared ~= nil and GetNumRunsCleared() < requirements.RequiredMinRunsCleared then
		return false
	end
	if requirements.RequiredMaxRunsCleared ~= nil and GetNumRunsCleared() > requirements.RequiredMaxRunsCleared then
		return false
	end
	if requirements.RequiredRunsCleared ~= nil and GetNumRunsCleared() ~= requirements.RequiredRunsCleared then
		return false
	end

	if requirements.RequiredMinConsecutiveClears ~= nil and GameState.ConsecutiveClears ~= nil and GameState.ConsecutiveClears < requirements.RequiredMinConsecutiveClears then
		return false
	end

	if requirements.RequiredConsecutiveClears ~= nil and GameState.ConsecutiveClears ~= nil and GameState.ConsecutiveClears ~= requirements.RequiredConsecutiveClears then
		return false
	end

	if requirements.PlayerMaxHealthFraction ~= nil and currentRun.Hero.Health / currentRun.Hero.MaxHealth >= requirements.PlayerMaxHealthFraction then
		return false
	end

	if requirements.NotMaxLastStands ~= nil and ( not currentRun.Hero.LastStands or not currentRun.Hero.MaxLastStands or TableLength( currentRun.Hero.LastStands ) >= currentRun.Hero.MaxLastStands ) then
		return false
	end

	if requirements.RequiredMinLastStandsUsed ~= nil then
		if currentRun.Hero.LastStandsUsed == nil or requirements.RequiredMinLastStandsUsed > currentRun.Hero.LastStandsUsed then
			return false
		end
	end

	if requirements.RequiredMinTraitsSold ~= nil then
		if currentRun.Hero.TraitsSold == nil or requirements.RequiredMinTraitsSold > currentRun.Hero.TraitsSold then
			return false
		end
	end

	if requirements.IsIdAlive ~= nil and not IsAlive({ Id = requirements.IsIdAlive }) then
		return false
	end
	if requirements.AreIdsAlive ~= nil then
		for i, id in pairs( requirements.AreIdsAlive ) do
			if not IsAlive({ Id = id }) then
				return false
			end
		end
	end
	if requirements.AreAnyIdsAlive ~= nil then
		local anyAlive = false
		for i, id in pairs( requirements.AreAnyIdsAlive ) do
			if IsAlive({ Id = id }) then
				anyAlive = true
				break
			end
		end
		if not anyAlive then
			return false
		end
	end
	if requirements.AreIdsNotAlive ~= nil then
		for i, id in pairs( requirements.AreIdsNotAlive ) do
			if IsAlive({ Id = id }) then
				return false
			end
		end
	end

	if requirements.MaxThanatosSpawnsThisRun ~= nil and currentRun.ThanatosSpawns ~= nil and currentRun.ThanatosSpawns >= requirements.MaxThanatosSpawnsThisRun then
		return false
	end

	if requirements.RequiredMaxThanatosKillsThisRun ~= nil then
		if (currentRun.CurrentRoom.Encounter.ThanatosKills or 0) > requirements.RequiredMaxThanatosKillsThisRun then
			return false
		end
		for roomIndex = #currentRun.RoomHistory, 1, -1 do
			if currentRun.RoomHistory[roomIndex].Encounter.ThanatosKills then
				if currentRun.RoomHistory[roomIndex].Encounter.ThanatosKills > requirements.RequiredMaxThanatosKillsThisRun then
					return false
				end
				break
			end
		end
	end

	if requirements.ObjectivesCompleted ~= nil then
		if requirements.ObjectivesCompleted.Min ~= nil then
			if (GameState.ObjectivesCompleted[requirements.ObjectivesCompleted.Name] or 0) < requirements.ObjectivesCompleted.Min then
				return false
			end
		end
		if requirements.ObjectivesCompleted.Max ~= nil then
			if (GameState.ObjectivesCompleted[requirements.ObjectivesCompleted.Name] or 0) > requirements.ObjectivesCompleted.Max then
				return false
			end
		end
	end
	if requirements.ObjectivesFailed ~= nil then
		if requirements.ObjectivesFailed.Min ~= nil then
			if (GameState.ObjectivesFailed[requirements.ObjectivesFailed.Name] or 0) < requirements.ObjectivesFailed.Min then
				return false
			end
		end
		if requirements.ObjectivesFailed.Max ~= nil then
			if (GameState.ObjectivesFailed[requirements.ObjectivesFailed.Name] or 0) > requirements.ObjectivesFailed.Max then
				return false
			end
		end
	end
	if requirements.ObjectiveCompletedLastOffer ~= nil then
		if (GameState.LastObjectiveCompletedRun[requirements.ObjectiveCompletedLastOffer] or 0) < (GameState.LastObjectiveFailedRun[requirements.ObjectiveCompletedLastOffer] or 0) then
			return false
		end
	end
	if requirements.ObjectiveFailedLastOffer ~= nil then
		if (GameState.LastObjectiveFailedRun[requirements.ObjectiveFailedLastOffer] or 0) < (GameState.LastObjectiveCompletedRun[requirements.ObjectiveFailedLastOffer] or 0) then
			return false
		end
	end

	if requirements.AnyQuestWithStatus ~= nil and not HasAnyQuestWithStatus( requirements.AnyQuestWithStatus ) then
		return false
	end
	if requirements.AllQuestsWithStatus ~= nil and not HasAllQuestsWithStatus( requirements.AllQuestsWithStatus ) then
		return false
	end

	if requirements.RequiredMinQuestsComplete ~= nil then
		local numQuestsComplete = 0
		if GameState.QuestStatus ~= nil then
			for questName, questStatus in pairs( GameState.QuestStatus ) do
				if questStatus == "CashedOut" then
					numQuestsComplete = numQuestsComplete + 1
				end
			end
		end
		if numQuestsComplete < requirements.RequiredMinQuestsComplete then
			return false
		end
	end
	if requirements.RequiredMaxQuestsComplete ~= nil then
		local numQuestsComplete = 0
		if GameState.QuestStatus ~= nil then
			for questName, questStatus in pairs( GameState.QuestStatus ) do
				if questStatus == "CashedOut" then
					numQuestsComplete = numQuestsComplete + 1
				end
			end
		end
		if numQuestsComplete > requirements.RequiredMaxQuestsComplete then
			return false
		end
	end

	if requirements.RequireQuestsComplete ~= nil then
		for k, questName in pairs(requirements.RequireQuestsComplete) do
			if GameState.QuestStatus[questName] ~= "CashedOut" then
				return false
			end
		end
	end

	if requirements.RequireAnyQuestsComplete ~= nil then
		local anyComplete = false
		for k, questName in pairs(requirements.RequireAnyQuestsComplete) do
			if GameState.QuestStatus[questName] == "CashedOut" then
				anyComplete = true
			end
		end
		if not anyComplete then
			return false
		end
	end

	if requirements.AnyAffordableGhostAdminItem ~= nil then
		local canAffordAny = false
		for itemName, itemData in pairs( ConditionalItemData ) do
			if not itemData.DebugOnly and itemData.ResourceCost ~= nil and not GameState.CosmeticsAdded[itemName] and not itemData.IgnoreAffordable then
				if itemData.Slot == requirements.AnyAffordableGhostAdminItem and HasResource( itemData.ResourceName, itemData.ResourceCost ) then
					if itemData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, itemData, itemData.GameStateRequirements ) then
						canAffordAny = true
						break
					end
				end
			end
		end
		if not canAffordAny then
			return false
		end
	end

	if requirements.RequiredMinCaughtFishThisRun ~= nil and GetNumFishCaught( currentRun ) < requirements.RequiredMinCaughtFishThisRun then
		return false
	end

	if requirements.RequiredHasFish ~= nil and IsEmpty(GameState.CaughtFish) then
		return false
	end

	if requirements.RequiredHasNoFish ~= nil and not IsEmpty(GameState.CaughtFish) then
		return false
	end

	if requirements.RequiredMinHeldFish ~= nil and GetNumHeldFish() < requirements.RequiredMinHeldFish then
		return false
	end

	if requirements.RequiredMinTotalCaughtFish ~= nil and GetNumLifetimeFish() < requirements.RequiredMinTotalCaughtFish then
		return false
	end

	if requirements.RequiredAnyCaughtFishTypes ~= nil then
		local anyTrue = false
		for k, fishType in pairs( requirements.RequiredAnyCaughtFishTypes ) do
			if GameState.TotalCaughtFish and GameState.TotalCaughtFish[fishType] then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredAnyCaughtFishTypesOfEach ~= nil then
		for k, subTable in pairs(requirements.RequiredAnyCaughtFishTypesOfEach) do
			local anyTrue = false
			for k, fishType in pairs( subTable ) do
				if GameState.TotalCaughtFish and GameState.TotalCaughtFish[fishType] then
					anyTrue = true
					break
				end
			end
			if not anyTrue then
				return false
			end
		end
	end

	if requirements.RequiredAnyCaughtFishTypesThisRun ~= nil then
		local anyTrue = false
		if currentRun.CaughtFish ~= nil then
			for k, fishType in pairs( requirements.RequiredAnyCaughtFishTypesThisRun ) do
				if currentRun.CaughtFish[fishType] then
					anyTrue = true
					break
				end
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredMaxTotalCaughtFish ~= nil and GetNumLifetimeFish() > requirements.RequiredMaxTotalCaughtFish then
		return false
	end

	if requirements.MinRunsSinceSquelchedHermes ~= nil then
		local runsSinceOccurred = 0
		for runIndex = #GameState.RunHistory + 1, 1, -1 do
			local prevRun = GameState.RunHistory[runIndex] or currentRun
			if prevRun.SquelchedHermesPermanently then
				return false
			end
			if prevRun.SquelchedHermes then
				if runsSinceOccurred < requirements.MinRunsSinceSquelchedHermes then
					--DebugPrint({ Text = "runsSinceOccurred = "..runsSinceOccurred })
					return false
				end
			end
			runsSinceOccurred = runsSinceOccurred + 1
		end
	end
	if requirements.MaxRunsSinceSquelchedHermes ~= nil then
		local runsSinceOccurred = 0
		local squelchedTimes = 0
		for runIndex = #GameState.RunHistory + 1, 1, -1 do
			local prevRun = GameState.RunHistory[runIndex] or currentRun
			if prevRun.SquelchedHermesPermanently then
				break
			end
			if prevRun.SquelchedHermes then
				squelchedTimes = squelchedTimes + 1
				if runsSinceOccurred >= requirements.MaxRunsSinceSquelchedHermes then
					--DebugPrint({ Text = "runsSinceOccurred = "..runsSinceOccurred })
					return false
				end
			end
			runsSinceOccurred = runsSinceOccurred + 1
		end
		if squelchedTimes == 0 then
			return false
		end
	end

	if requirements.MinRunsSinceAnyTextLines ~= nil then
		for k, textLines in pairs( requirements.MinRunsSinceAnyTextLines.TextLines ) do
			local runsSinceOccurred = 0
			for runIndex = #GameState.RunHistory + 1, 1, -1 do
				local prevRun = GameState.RunHistory[runIndex] or currentRun
				if prevRun.TextLinesRecord ~= nil and prevRun.TextLinesRecord[textLines] then
					if runsSinceOccurred < requirements.MinRunsSinceAnyTextLines.Count then
						DebugPrint({ Text = "textLines = "..textLines..", ".."runsSinceOccurred = "..runsSinceOccurred })
						return false
					end
				end
				runsSinceOccurred = runsSinceOccurred + 1
				if runsSinceOccurred >= requirements.MinRunsSinceAnyTextLines.Count then
					-- Already exceeded safely
					break
				end
			end
		end
	end
	if requirements.MaxRunsSinceAnyTextLines ~= nil then
		for k, textLines in pairs( requirements.MaxRunsSinceAnyTextLines.TextLines ) do
			local runsSinceOccurred = 0
			for runIndex = #GameState.RunHistory + 1, 1, -1 do
				local prevRun = GameState.RunHistory[runIndex] or currentRun
				if prevRun.TextLinesRecord ~= nil and prevRun.TextLinesRecord[textLines] then
					if runsSinceOccurred > requirements.MaxRunsSinceAnyTextLines.Count then
						DebugPrint({ Text = "textLines = "..textLines..", ".."runsSinceOccurred = "..runsSinceOccurred })
						return false
					else
						-- Did occur recently enough
						break
					end
				end
				runsSinceOccurred = runsSinceOccurred + 1
			end
		end
	end

	if requirements.RequiredTrueConfigOptions ~= nil then
		for k, configOption in pairs( requirements.RequiredTrueConfigOptions ) do
			if not GetConfigOptionValue({ Name = configOption }) then
				return false
			end
		end
	end
	if requirements.RequiredFalseConfigOptions ~= nil then
		for k, configOption in pairs( requirements.RequiredFalseConfigOptions ) do
			if GetConfigOptionValue({ Name = configOption }) then
				return false
			end
		end
	end

	if requirements.RequiresFalseHadesProcession then
		if CurrentDeathAreaRoom ~= nil and CurrentDeathAreaRoom.HadesProcessionActive then
			return false
		end
	end

	if requirements.RequiresFalseGossiping then
		if CurrentDeathAreaRoom ~= nil and CurrentDeathAreaRoom.GossipingActive then
			return false
		end
	end

	if requirements.RequiredCosmeticsAdded ~= nil then
		for k, name in pairs( requirements.RequiredCosmeticsAdded ) do
			if not GameState.CosmeticsAdded[name] then
				return false
			end
		end
	end

	if requirements.RequiredCosmetics ~= nil then
		for k, name in pairs( requirements.RequiredCosmetics ) do
			if not GameState.Cosmetics[name] then
				return false
			end
		end
	end
	if requirements.RequiredAnyCosmetics ~= nil then
		local anyTrue = false
		for k, name in pairs( requirements.RequiredAnyCosmetics ) do
			if GameState.Cosmetics[name] then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredCosmeticPurchaseable ~= nil then
		local cosmeticData = ConditionalItemData[requirements.RequiredCosmeticPurchaseable]
		if cosmeticData == nil then
			return false
		end
		if GameState.CosmeticsAdded[cosmeticData.Name] or not IsGameStateEligible( CurrentRun, cosmeticData, cosmeticData.GameStateRequirements ) then
			return false
		end
	end
	if requirements.RequiredFalseCosmeticPurchaseable ~= nil then
		local cosmeticData = ConditionalItemData[requirements.RequiredFalseCosmeticPurchaseable]
		if cosmeticData ~= nil and not GameState.CosmeticsAdded[cosmeticData.Name] and IsGameStateEligible( CurrentRun, cosmeticData, cosmeticData.GameStateRequirements ) then
			return false
		end
	end
	if requirements.RequiredSeenCosmeticPurchaseable ~= nil then
		local cosmeticData = ConditionalItemData[requirements.RequiredSeenCosmeticPurchaseable]
		if cosmeticData == nil then
			return false
		end
		if not GameState.CosmeticsAdded[cosmeticData.Name] and not GameState.CosmeticsViewed[cosmeticData.Name] then
			return false
		end
	end

	if requirements.RequiredMinAnyCosmetics ~= nil then
		local numTrue = 0
		for k, name in pairs( requirements.RequiredMinAnyCosmetics.Cosmetics ) do
			if GameState.Cosmetics[name] then
				numTrue = numTrue + 1
			end
		end
		if numTrue < requirements.RequiredMinAnyCosmetics.Count then
			return false
		end
	end
	if requirements.RequiredMaxAnyCosmetics ~= nil then
		local numTrue = 0
		for k, name in pairs( requirements.RequiredMaxAnyCosmetics.Cosmetics ) do
			if GameState.Cosmetics[name] then
				numTrue = numTrue + 1
			end
		end
		if numTrue > requirements.RequiredMaxAnyCosmetics.Count then
			return false
		end
	end

	if requirements.RequiredFalseCosmetics ~= nil then
		for k, name in pairs( requirements.RequiredFalseCosmetics ) do
			if GameState.Cosmetics[name] then
				return false
			end
		end
	end

	if requirements.RequiredNumCosmeticsMin ~= nil then
		if TableLength( GameState.CosmeticsAdded ) < requirements.RequiredNumCosmeticsMin then
			return false
		end
	end

	if requirements.RequiresPendingCosmeticItems ~= nil then
		local hasPending = false
		local ids = GetIds({ Names = { "Conditional" }})
		for k, id in pairs (ids) do
			local name = GetName({ Id = id })
			if GameState.Cosmetics[name] == UIData.Constants.PENDING_REVEAL then
				hasPending = true
			end
		end

		if not hasPending then
			return false
		end
	end

	if requirements.RequiredCosmeticItemVisible and GameState.Cosmetics[requirements.RequiredCosmeticItemVisible] ~= UIData.Constants.VISIBLE then
		return false
	end

	if requirements.RequiredAnyCosmeticItemVisible then
		local anyTrue = false
		for k, name in pairs( requirements.RequiredAnyCosmeticItemVisible ) do
			if GameState.Cosmetics[name] == UIData.Constants.VISIBLE then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredTrueFlags ~= nil then
		for k, flag in pairs( requirements.RequiredTrueFlags ) do
			if not GameState.Flags[flag] then
				return false
			end
		end
	end
	if requirements.RequiredFalseFlags ~= nil then
		for k, flag in pairs( requirements.RequiredFalseFlags ) do
			if GameState.Flags[flag] then
				return false
			end
		end
	end
	if requirements.RequiredAnyTrueFlags ~= nil then
		local anyTrue = false
		for k, flag in pairs( requirements.RequiredAnyTrueFlags ) do
			if GameState.Flags[flag] then
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	if requirements.RequiredValues ~= nil then
		for key, value in pairs( requirements.RequiredValues ) do
			if GameState[key] ~= value then
				return false
			end
		end
	end
	if requirements.RequiredFalseValues ~= nil then
		for key, value in pairs( requirements.RequiredFalseValues ) do
			if GameState[key] == value then
				return false
			end
		end
	end	
	if requirements.RequiredMinValues ~= nil then
		for key, minValue in pairs( requirements.RequiredMinValues ) do
			if (GameState[key] or 0) < minValue then
				return false
			end
		end
	end
	if requirements.RequiredMaxValues ~= nil then
		for key, maxValue in pairs( requirements.RequiredMaxValues ) do
			if (GameState[key] or 0) > maxValue then
				return false
			end
		end
	end

	if requirements.RequiredAccumulatedMetaPoints ~= nil then
		if GetTotalAccumulatedMetaPoints() < requirements.RequiredAccumulatedMetaPoints then
			return false
		end
	end

	if requirements.RequiredActiveMetaPointsMin ~= nil then
		if GetTotalSpentMetaPoints() < requirements.RequiredActiveMetaPointsMin then
			return false
		end
	end
	if requirements.RequiredActiveMetaPointsMax ~= nil then
		if GetTotalSpentMetaPoints() > requirements.RequiredActiveMetaPointsMax then
			return false
		end
	end

	if requirements.RequiredResourcesMin ~= nil then
		for name, amount in pairs( requirements.RequiredResourcesMin ) do
			if not HasResource( name, amount ) then
				return false
			end
		end
	end

	if requirements.RequiredResourcesMax ~= nil then
		for name, amount in pairs( requirements.RequiredResourcesMax ) do
			if HasResource( name, amount + 1 ) then
				return false
			end
		end
	end

	if requirements.RequiredLifetimeResourcesGainedMin ~= nil then
		for name, amount in pairs( requirements.RequiredLifetimeResourcesGainedMin ) do
			if GameState.LifetimeResourcesGained[name] == nil or ( GameState.LifetimeResourcesGained[name] ~= nil and GameState.LifetimeResourcesGained[name] < amount ) then
				return false
			end
		end
	end
	if requirements.RequiredLifetimeResourcesGainedMax ~= nil then
		for name, amount in pairs( requirements.RequiredLifetimeResourcesGainedMax ) do
			if GameState.LifetimeResourcesGained[name] ~= nil and GameState.LifetimeResourcesGained[name] > amount then
				return false
			end
		end
	end

	if requirements.RequiredLifetimeResourcesSpentMin ~= nil then
		for name, amount in pairs( requirements.RequiredLifetimeResourcesSpentMin ) do
			if GameState.LifetimeResourcesSpent[name] == nil or ( GameState.LifetimeResourcesSpent[name] ~= nil and GameState.LifetimeResourcesSpent[name] < amount ) then
				return false
			end
		end
	end
	if requirements.RequiredLifetimeResourcesSpentMax ~= nil then
		for name, amount in pairs( requirements.RequiredLifetimeResourcesSpentMax ) do
			if GameState.LifetimeResourcesSpent[name] ~= nil and GameState.LifetimeResourcesSpent[name] > amount then
				return false
			end
		end
	end

	if requirements.RequiredMoneyMin ~= nil then
		if currentRun.Money < requirements.RequiredMoneyMin then
			return false
		end
	end
	if requirements.RequiredMoneyMax ~= nil then
		if currentRun.Money > requirements.RequiredMoneyMax then
			return false
		end
	end

	if requirements.RequiredConsumablesThisRun ~= nil then
		local count = 0
		for k, name in pairs( requirements.RequiredConsumablesThisRun.Names ) do
			count = count + (currentRun.ConsumableRecord[name] or 0)
		end
		if count < requirements.RequiredConsumablesThisRun.Count then
			return false
		end
	end

	if requirements.RequiredFalseConsumablesThisRun ~= nil then
		for k, name in pairs( requirements.RequiredFalseConsumablesThisRun ) do
			if currentRun.ConsumableRecord[name] then
				return false
			end
		end
	end

	if requirements.RequiredActiveShrinePointsMin ~= nil then
		if GetTotalSpentShrinePoints() < requirements.RequiredActiveShrinePointsMin then
			return false
		end
	end
	if requirements.RequiredActiveShrinePointsMax ~= nil then
		if GetTotalSpentShrinePoints() > requirements.RequiredActiveShrinePointsMax then
			return false
		end
	end

	if requirements.RequireNewTraits ~= nil then
		if not HasNewTraits() then
			return false
		end
	end

	if requirements.RequiredNoEquipedAwardTrait ~= nil then
		if GameState.LastAwardTrait ~= nil then
			return false
		end
	end

	-- note this is for the Daedalus Hammer not Weapon Aspects
	if requirements.RequiredMinWeaponUpgrades ~= nil then
		local numUpgrades = 0
		if currentRun.LootTypeHistory and currentRun.LootTypeHistory.WeaponUpgrade then
			if currentRun.LootTypeHistory.WeaponUpgrade < requirements.RequiredMinWeaponUpgrades then
				return false
			else
				numUpgrades = currentRun.LootTypeHistory.WeaponUpgrade
			end
		end

		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.ChosenRewardType == "WeaponUpgrade" and (numUpgrades + 1) < requirements.RequiredMinWeaponUpgrades then
			return false
		elseif numUpgrades < requirements.RequiredMinWeaponUpgrades then
			return false
		end
	end

	if requirements.RequiredMaxWeaponUpgrades ~= nil then
		local numUpgrades = 0
		if currentRun.LootTypeHistory and currentRun.LootTypeHistory.WeaponUpgrade then
			if currentRun.LootTypeHistory.WeaponUpgrade > requirements.RequiredMaxWeaponUpgrades then
				return false
			else
				numUpgrades = currentRun.LootTypeHistory.WeaponUpgrade
			end
		end
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.ChosenRewardType == "WeaponUpgrade" and (numUpgrades + 1) > requirements.RequiredMaxWeaponUpgrades then
			return false
		end
	end

	if requirements.RequiredMaxHermesUpgrades ~= nil then
		local numUpgrades = 0
		if currentRun.LootTypeHistory and currentRun.LootTypeHistory.HermesUpgrade then
			if currentRun.LootTypeHistory.HermesUpgrade > requirements.RequiredMaxHermesUpgrades then
				return false
			else
				numUpgrades = currentRun.LootTypeHistory.HermesUpgrade
			end
		end
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.ChosenRewardType == "HermesUpgrade" and (numUpgrades + 1) > requirements.RequiredMaxHermesUpgrades then
			return false
		end
	end

	if requirements.RequiredInStore ~= nil then
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.Store ~= nil and currentRun.CurrentRoom.Store.StoreOptions ~=nil then
			local foundItem = false
			for i, value in pairs(currentRun.CurrentRoom.Store.StoreOptions) do
				if value.Name == requirements.RequiredInStore then
					foundItem = true
				end
			end
			if not foundItem then
				return false
			end
		end
	end
	if requirements.RequiredInStoreAffordable ~= nil then
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.Store ~= nil and currentRun.CurrentRoom.Store.StoreOptions ~=nil then
			local foundItem = false
			for i, value in pairs(currentRun.CurrentRoom.Store.StoreOptions) do
				if value.Name == requirements.RequiredInStoreAffordable then
					foundItem = true
					if value.HealthCost and CurrentRun.Hero.Health <= upgradeData.HealthCost then
						return false
					end

					if value.Cost and CurrentRun.Money == nil or CurrentRun.Money < value.Cost then
						return false
					end
				end
			end

			if not foundItem then
				return false
			end
		end
	end
	if requirements.RequiredInStoreUnaffordable ~= nil then
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.Store ~= nil and currentRun.CurrentRoom.Store.StoreOptions ~=nil then
			local foundItem = false
			for i, value in pairs(currentRun.CurrentRoom.Store.StoreOptions) do
				if value.Name == requirements.RequiredInStoreUnaffordable then
					foundItem = true
					if value.HealthCost and CurrentRun.Hero.Health > upgradeData.HealthCost then
						return false
					end

					if value.Cost and CurrentRun.Money ~= nil and CurrentRun.Money >= value.Cost then
						return false
					end
				end
			end

			if not foundItem then
				return false
			end
		end
	end

	if requirements.RequiredNotInStore ~= nil then
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.Store ~= nil and currentRun.CurrentRoom.Store.StoreOptions ~=nil then
			for i, value in pairs(currentRun.CurrentRoom.Store.StoreOptions) do
				if value.Name == requirements.RequiredNotInStore then
					return false
				end
			end
		end
	end

	if requirements.RequiredNotInStoreNames ~= nil then
		if currentRun.CurrentRoom ~= nil and currentRun.CurrentRoom.Store ~= nil and currentRun.CurrentRoom.Store.StoreOptions ~=nil then
			for i, value in pairs(currentRun.CurrentRoom.Store.StoreOptions) do
				if Contains( requirements.RequiredNotInStoreNames, value.Name ) then
					return false
				end
			end
		end
	end


	if requirements.RequiredPurchasedWorldItemCountMin ~= nil or requirements.RequiredPurchasedWorldItemCountMax ~= nil then
		local num = 0
		if CurrentRun.CurrentRoom.Store ~= nil and CurrentRun.CurrentRoom.Store.SpawnedStoreItems ~= nil then
			for i, item in pairs(CurrentRun.CurrentRoom.Store.SpawnedStoreItems) do
				if not IsAlive({Id = item.ObjectId}) then
					num = num + 1
				end
			end
		end
		if requirements.RequiredPurchasedWorldItemCountMin and num < requirements.RequiredPurchasedWorldItemCountMin then
			return false
		end
		if requirements.RequiredPurchasedWorldItemCountMax and num > requirements.RequiredPurchasedWorldItemCountMax then
			return false
		end
	end

	if requirements.RequiredMusicName ~= nil then
		if requirements.RequiredMusicName ~= MusicName then
			return false
		end
	end

	if requirements.RequiredMusicSection ~= nil then
		if requirements.RequiredMusicSection ~= MusicSection then
			return false
		end
	end

	if requirements.RequiredAmbientTrackName ~= nil then
		if requirements.RequiredAmbientTrackName ~= AmbientTrackName then
			return false
		end
	end

	if requirements.RequiredAmbientTrackNameMatch and source ~= nil and source.OnQueuedFunctionArgs ~= nil then
		if AmbientTrackName ~= nil and source.OnQueuedFunctionArgs.TrackName ~= AmbientTrackName then
			return false
		end
	end

	if requirements.RequiredMusicSectionRoomDuration ~= nil and MusicSectionStartDepth ~= nil then
		local duration = GetRunDepth( currentRun ) - MusicSectionStartDepth
		if duration < requirements.RequiredMusicSectionRoomDuration then
			return false
		end
	end

	if requirements.RequiresNotFishing ~= nil and CurrentRun.Hero.FishingStarted then
		return false
	end

	if requirements.RequiresMusicId ~= nil and MusicId == nil then
		return false
	end
	if requirements.RequiresNullMusicId ~= nil and MusicId ~= nil then
		return false
	end

	if requirements.RequiresSecretMusicId ~= nil and SecretMusicId == nil then
		return false
	end
	if requirements.RequiresNullSecretMusicId ~= nil and SecretMusicId ~= nil then
		return false
	end

	if requirements.RequiresAmbientMusicId ~= nil and AmbientMusicId == nil then
		return false
	end
	if requirements.RequiresNullAmbientMusicId ~= nil and AmbientMusicId ~= nil then
		return false
	end

	if requirements.RequiredFalseInteractionThisRun ~= nil then
		if CurrentRun.NPCInteractions[requirements.RequiredFalseInteractionThisRun] then
			return false
		end
	end
	if requirements.RequiredMinNPCInteractions ~= nil then
		for requiredNPC, requiredNPCInteractionsCount in pairs( requirements.RequiredMinNPCInteractions ) do
			if GameState.NPCInteractions[requiredNPC] == nil or GameState.NPCInteractions[requiredNPC] < requiredNPCInteractionsCount then
				return false
			end
		end
	end
	if requirements.RequiredMaxNPCInteractions ~= nil then
		for requiredNPC, requiredNPCInteractionsCount in pairs( requirements.RequiredMaxNPCInteractions ) do
			if GameState.NPCInteractions[requiredNPC] == nil or GameState.NPCInteractions[requiredNPC] > requiredNPCInteractionsCount then
				return false
			end
		end
	end

	if requirements.RequiredMinItemInteractions ~= nil then
		for requiredItem, requiredItemInteractionsCount in pairs( requirements.RequiredMinItemInteractions ) do
			if GameState.ItemInteractions[requiredItem] == nil or GameState.ItemInteractions[requiredItem] < requiredItemInteractionsCount then
				return false
			end
		end
	end

	if requirements.RequiredUpgradeableGodTraits ~= nil then
		if not UpgradableGodTraitCountAtLeast( requirements.RequiredUpgradeableGodTraits ) then
			return false
		end
	end

	if requirements.RequiredInteractedGods ~= nil then
		if TableLength( GetEligibleInteractedGods() ) < requirements.RequiredInteractedGods then
			return false
		end
	end

	if requirements.RequiredInteractedGodsThisRun ~= nil then
		if TableLength( GetInteractedGodsThisRun() ) < requirements.RequiredInteractedGodsThisRun then
			return false
		end
	end

	if requirements.RequiredMinRoomsSinceDevotion ~= nil then
		if currentRun.LastDevotionDepth ~= nil and currentRun.LastDevotionDepth ~= currentRun.RunDepthCache and currentRun.RunDepthCache - requirements.RequiredMinRoomsSinceDevotion < currentRun.LastDevotionDepth then
			return false
		end
	end

	if requirements.RequiredMinRoomsSinceWellShop ~= nil then
		if currentRun.LastWellShopDepth ~= nil and currentRun.LastWellShopDepth ~= currentRun.RunDepthCache and currentRun.RunDepthCache - requirements.RequiredMinRoomsSinceWellShop < currentRun.LastWellShopDepth then
			return false
		end
	end

	if requirements.RequiredMinRoomsSinceSellTraitShop ~= nil then
		if currentRun.LastSellTraitShopDepth ~= nil and currentRun.LastSellTraitShopDepth ~= currentRun.RunDepthCache and currentRun.RunDepthCache - requirements.RequiredMinRoomsSinceSellTraitShop < currentRun.LastSellTraitShopDepth then
			return false
		end
	end

	if requirements.RequiredMinRoomsSinceSecretDoor ~= nil then
		if currentRun.LastSecretDepth ~= nil and currentRun.LastSecretDepth ~= currentRun.RunDepthCache and currentRun.RunDepthCache - requirements.RequiredMinRoomsSinceSecretDoor < currentRun.LastSecretDepth then
			return false
		end
	end

	if requirements.RequiredMinRoomsSinceShrinePointDoor ~= nil then
		if currentRun.LastShrinePointDoorDepth ~= nil and currentRun.LastShrinePointDoorDepth ~= currentRun.RunDepthCache and currentRun.RunDepthCache - requirements.RequiredMinRoomsSinceShrinePointDoor < currentRun.LastShrinePointDoorDepth then
			return false
		end
	end

	if requirements.RequiredMinRoomsSinceChallengeSwitch ~= nil then
		if currentRun.LastChallengeDepth ~= nil and currentRun.LastChallengeDepth ~= currentRun.RunDepthCache and currentRun.RunDepthCache - requirements.RequiredMinRoomsSinceChallengeSwitch < currentRun.LastChallengeDepth then
			return false
		end
	end

	if requirements.RequiredNoChallengeSwitchInRoom ~= nil and CurrentRun.CurrentRoom.ChallengeSwitch then
		return false
	end

	if requirements.RequiredMinRoomsSinceFishingPoint ~= nil then
		if currentRun.LastFishingPointDepth ~= nil and currentRun.LastFishingPointDepth ~= currentRun.RunDepthCache and currentRun.RunDepthCache - requirements.RequiredMinRoomsSinceFishingPoint < currentRun.LastFishingPointDepth then
			return false
		end
	end

	if requirements.RequiresFishingPointInRoom ~= nil and not CurrentRun.CurrentRoom.FishingPointId then
		return false
	end

	if requirements.RequiresFalseFishingInput and CurrentRun.Hero.FishingInput then
		return false
	end

	if requirements.RequiredMinDoorsClosedInRoom ~= nil then
		local roomName = requirements.RequiredMinDoorsClosedRoom or currentRun.CurrentRoom.Name
		if TableLength( currentRun.ClosedDoors[roomName] or {} ) < requirements.RequiredMinDoorsClosedInRoom then
			return false
		end
	end
	if requirements.RequiredMaxDoorsClosedInRoom ~= nil then
		local roomName = requirements.RequiredMaxDoorsClosedRoom or currentRun.CurrentRoom.Name
		if TableLength( currentRun.ClosedDoors[roomName] or {} ) > requirements.RequiredMaxDoorsClosedInRoom then
			return false
		end
	end

	if requirements.RequiredScreenOpen ~= nil and not IsScreenOpen( requirements.RequiredScreenOpen ) then
		return false
	end
	if requirements.RequiredFalseScreenOpen ~= nil and IsScreenOpen( requirements.RequiredFalseScreenOpen ) then
		return false
	end
	if requirements.RequiredFalseScreensOpen ~= nil then
		for k, screenName in pairs( requirements.RequiredFalseScreensOpen ) do
			if IsScreenOpen( screenName ) then
				return false
			end
		end
	end

	if requirements.RequiredScreenViewed ~= nil and not GameState.ScreensViewed[requirements.RequiredScreenViewed] then
		return false
	end

	if requirements.RequiredScreenViewedFalse ~= nil and GameState.ScreensViewed[requirements.RequiredScreenViewedFalse] then
		return false
	end

	if requirements.RequiresNewMusicTracks ~= nil then
		local anyTrue = false
		for trackName, trackData in pairs( MusicPlayerTrackData ) do
			if GameState.Cosmetics[trackData.Name] and not GameState.CosmeticsViewed[trackData.Name] then
				-- Owned but not viewed
				anyTrue = true
				break
			end
		end
		if not anyTrue then
			return false
		end
	end

	return true

end

function DidFailRun( run )
	if run.Cleared then
		return false
	end
	if not run.Hero.IsDead then
		return false
	end
	return true
end

function GetRandomEligibleGameState( currentRun, sources )

	local eligibleSources = {}
	for k, source in pairs( sources ) do
		if IsGameStateEligible( currentRun, source ) then
			table.insert( eligibleSources, source )
		end
	end
	return GetRandomValue( eligibleSources )

end

function GetRandomRemainingEligibleGameState( currentRun, sources )

	if sources == nil then
		return nil
	end

	local availableEligibleSources = {}
	local allEligibleSources = {}
	for k, source in pairs( sources ) do
		if IsGameStateEligible( currentRun, source ) then
			table.insert( allEligibleSources, source )
			if not GameState.ReturnedRandomEligibleSourceNames[source.Name] then
				table.insert( availableEligibleSources, source )
			end
		end
	end

	if IsEmpty( allEligibleSources ) then
		return nil
	end

	local randomSource = nil
	if IsEmpty( availableEligibleSources ) then
		-- All sources returned, start the record over
		for k, source in pairs( sources ) do
			GameState.ReturnedRandomEligibleSourceNames[source.Name] = nil
		end
		randomSource = GetRandomValue( allEligibleSources )
	else
		randomSource = GetRandomValue( availableEligibleSources )
	end
	GameState.ReturnedRandomEligibleSourceNames[randomSource.Name] = true
	return randomSource

end

function UpdateConfigOptionCache()
	ConfigOptionCache = ConfigOptionCache or {}
	ConfigOptionCache.ShowDamageNumbers = GetConfigOptionValue({ Name = "ShowDamageNumbers" })
	ConfigOptionCache.ShowUIAnimations = GetConfigOptionValue({ Name = "ShowUIAnimations" })
	ConfigOptionCache.LogCombatMultipliers = GetConfigOptionValue({ Name = "LogCombatMultipliers" })
	ConfigOptionCache.ShowSpeechBubble = GetConfigOptionValue({ Name = "ShowSpeechBubble" })
	ConfigOptionCache.EasyMode = GetConfigOptionValue({ Name = "EasyMode" })
	ConfigOptionCache.HardMode = GetConfigOptionValue({ Name = "HardMode" })
end

function AddTimerBlock( run, flag )
	if flag == nil then
		flag = "Generic"
	end
	run.BlockTimerFlags[flag] = true
end

function HasTimerBlock( run )
	return not IsEmpty(run.BlockTimerFlags)
end

function RemoveTimerBlock( run, flag )
	if flag == nil then
		flag = "Generic"
	end
	run.BlockTimerFlags[flag] = nil
end

function UpdateTimers( elapsed )

	if CurrentRun == nil or CurrentRun.Hero.IsDead then
		return
	end

	if not IsEmpty( CurrentRun.BlockTimerFlags ) then
		return
	end

	CurrentRun.GameplayTime = CurrentRun.GameplayTime + elapsed
	if CurrentRun.ActiveBiomeTimer and not IsBiomeTimerPaused() then
		CurrentRun.BiomeTime = CurrentRun.BiomeTime - elapsed
		if CurrentRun.BiomeTime <= 30 and (CurrentRun.BiomeTime + elapsed) > 30 then
			BiomeTimerAboutToExpirePresentation()
		elseif CurrentRun.BiomeTime <= 0 and (CurrentRun.BiomeTime + elapsed) > 0 then
			BiomeTimerExpiredPresentation()
		end
	end
end

function InvalidateCheckpoint()
	if CurrentRun.CurrentRoom ~= nil and not CurrentRun.CurrentRoom.CheckpointInvalidated then
		CurrentRun.CurrentRoom.CheckpointInvalidated = true
		ValidateCheckpoint({ Value = false })
	end
end

function SelectBannedEliteAttributes( run )
	local banCount = 2
	local banOptions = ShallowCopyTable( EnemySets.EliteAttributesRunBanOptions )

	for i = 1, banCount do
		local banChoice = RemoveRandomValue( banOptions )
		if banChoice ~= nil then
			table.insert( run.BannedEliteAttributes, banChoice )
		end
	end
end

function LeaveRoomWithNoDoor( source, args )
	local door = { ObjectId = args.ObjectId, Room = CreateRoom( RoomData[args.NextMap] ) }
	if args.ExitSound ~= nil then
		PlaySound({ Name = args.ExitSound })
	end
	LeaveRoom( CurrentRun, door )
end

function KillMapThreads()
	killTaggedThreads( RoomThreadName )
	killTaggedThreads( CombatUI.HideThreadName )
end

function HasCodexEntryBeenFound( requiredEntryName, requiredEntryIndex )
	local codexEntryFound = false
	for chapterName, chapterData in pairs(Codex) do
		for entryName in pairs(Codex[chapterName].Entries) do
			if entryName == requiredEntryName then
				if CodexStatus[chapterName] == nil or CodexStatus[chapterName][entryName] == nil or CodexStatus[chapterName][entryName][requiredEntryIndex] == nil or not CodexStatus[chapterName][entryName][requiredEntryIndex].Unlocked or CodexStatus[chapterName][entryName].New then
					return false
				else
					local allUnlocked = true
					for i = 1, requiredEntryIndex do
						if not CodexStatus[chapterName][entryName][i] or not CodexStatus[chapterName][entryName][i].Unlocked then
							allUnlocked = false
							break
						end
					end
					if allUnlocked then
						codexEntryFound = true
					end
				end
			end
		end
	end
	if not codexEntryFound then
		return false
	end
	return true
end