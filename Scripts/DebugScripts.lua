--[[ * DEBUG SCRIPTS ]]

-- Camera Unleash
OnKeyPressed{ "ControlShift K", Name = "CameraUnleash",
	function( triggerArgs )
		ClearCameraClamp({ })
		ClearCameraRail({ })
		LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 2.0 })
	end
}

-- UI / ART CHEATS
OnKeyPressed{ "ControlShift L", Name = "LoadCheckpoint", Safe = true,
	function( triggerArgs )
		DebugPrint({ Text = "Game Loading" })
		LoadCheckpoint({ })
		DebugPrint({ Text = "Game Loaded" })
	end
}

OnKeyPressed{ "ControlShift X", Name = "DamageActiveUnit",
	function( triggerArgs )
		SacrificeHealth({ SacrificeHealthMin = 45, SacrificeHealthMax = 45, MinHealth = 1 })
	end
}

OnKeyPressed{ "Alt W", Name = "Create Weapon loot",
	function( triggerArgs )
		CreateWeaponLoot()
	end
}

OnKeyPressed{ "Alt L", Name = "OpenUpgradeChoiceMenu",
	function( triggerArgs )
		CreateStackLoot()
	end
}

OnKeyPressed{ "Control X", Name = "DestroyActiveUnit",
	function( triggerArgs )
		Kill( CurrentRun.Hero, triggerArgs )
	end
}

OnKeyPressed{ "Control T", Name = "ToggleUI",
	function( triggerArgs )
		if ConfigOptionCache.ShowUIAnimations then
			SetConfigOption({ Name = "ShowUIAnimations", Value = false })
			SetConfigOption({ Name = "UseOcclusion", Value = false })
			HideCombatUI()
		else
			SetConfigOption({ Name = "ShowUIAnimations", Value = true })
			SetConfigOption({ Name = "UseOcclusion", Value = true })
			ShowCombatUI()
		end
		UpdateConfigOptionCache()
	end
}

function ToggleConfigOption( name )
	if GetConfigOptionValue({ Name = name }) then
		SetConfigOption({ Name = name, Value = false })
	else
		SetConfigOption({ Name = name, Value = true })
	end
	DebugPrint({ Text = name.." = "..tostring(GetConfigOptionValue({ Name = name })) })
end

function ToggleDebugScreen( screenName )

	if GetTopScreenName({ }) == screenName then
		ExitMenu({ Name = screenName })
	else

		if DebugScreenOpen ~= nil then
			ExitMenu({ Name = DebugScreenOpen })
			DebugScreenOpen = nil
		end

		OpenMenu({ Name = screenName, PopExistingToFront = true })
		DebugScreenOpen = screenName

	end
end

OnKeyPressed{ "ControlShift P", Name = "Toggle AutoPlay",
	function( triggerArgs )

		if GetConfigOptionValue({ Name = "FastForward" }) then
			AutoPlayOff()
		else
			AutoPlayOn()
		end

	end
}

OnKeyPressed{ "ControlAltShift P", Name = "Toggle AutoPlay Invulnerable",
	function( triggerArgs )

		if GetConfigOptionValue({ Name = "FastForward" }) then
			AutoPlayOff()
			BlockHeroDeath = nil
		else
			AutoPlayOn()
			BlockHeroDeath = true
		end

	end
}

function AutoPlayOn()
	SetConfigOption({ Name = "FastForward", Value = true })
	SetConfigOption({ Name = "RequireFocusToUpdate", Value = false })
	SetConfigOption({ Name = "UseMouse", Value = false })
end

function AutoPlayOff()
	SetConfigOption({ Name = "FastForward", Value = false })
	SetConfigOption({ Name = "RequireFocusToUpdate", Value = true })
end

OnAnyLoad
{
	function( triggerArgs )

		HotLoadInfo = HotLoadInfo or {}

	end
}

function ValidateIds( ids )
	if ids ~= nil then
		for _, id in pairs(ids) do
			assert( IdExists({ Id = id }), "Missing id: "..id )
		end
	end
end

-- Minos Keys

OnKeyPressed{ "ControlShift W", Name = "Grant Upgrade",
	function( triggerArgs )
		AddMoney( 9000, "GrantUpgrade" )
		LiveFillInShopOptions()
		StartUpStore()
	end
}

function LiveFillInShopOptions()
	CurrentRun.CurrentRoom.Store = FillInShopOptions( { StoreData = StoreData.RoomShop , RoomName = CurrentRun.CurrentRoom.Name } )
end

--ForceEvent = "OlympianReunionQuestComplete"

function ForcePlayTextLines( source, textLinesName )

	local possibleSets =
	{
		"OnUsedTextLineSets", "InteractTextLineSets", "RepeatableTextLineSets",
		"PriorityPickupTextLineSets", "PickupTextLineSets", "RejectionTextLines", "MakeUpTextLines", "BoughtTextLines", "GiftTextLineSets",
		"BossPresentationIntroTextLineSets", "BossPresentationTextLineSets", "BossPresentationRepeatableTextLineSets",
	}
	for k, possibleSet in pairs( possibleSets ) do
		local set = source[possibleSet]
		if set ~= nil then
			local event = set[textLinesName]
			if event ~= nil then
				event.Force = true
				PlayTextLines( source, event )
				event.Force = false
				return true
			end
		end
	end

	return false

end

OnKeyPressed{ "Control N", Name = "Force Next Room & Encounter",
	function( triggerArgs )
		ForceNextRoom = "B_MiniBoss02"

		-- Stomp any rooms already assigned to doors
		for doorId, door in pairs( OfferedExitDoors ) do
			local room = door.Room
			if room ~= nil then
				ForceNextEncounter = "MiniBossSpreadShot"

				if ForceNextRoom ~= nil then
					DebugPrint({ Text = "ForceNextRoom = "..tostring(ForceNextRoom) })
				end

				local forcedRoomData = RoomData[ForceNextRoom]
				local forcedRoom = CreateRoom( forcedRoomData )
				AssignRoomToExitDoor( door, forcedRoom )
			end
		end
	end
}

function SpawnDummyEnemy( args )
	if args == nil then
		args = {}
	end

	if args.Name == nil then
		args.Name = "HeavyMelee"
	end

	local enemyData = EnemyData[args.Name]
	--local enemyData = EnemyData.HeavyRanged
	local newEnemy = DeepCopyTable( enemyData )
	if not args.Active then
		newEnemy.DisableAIWhenReady = true
	end

	if args.HealthBuffer ~= nil then
		newEnemy.HealthBuffer = args.HealthBuffer
	end
	newEnemy.BlocksLootInteraction = false

	local invaderSpawnPoint = 40000
	newEnemy.ObjectId = SpawnUnit({
			Name = enemyData.Name,
			Group = "Standing",
			DestinationId = invaderSpawnPoint, OffsetX = 100, OffsetY = 100 })

	SetupEnemyObject( newEnemy, CurrentRun )

	if args.Health ~= nil then
		newEnemy.MaxHealth = args.Health
		newEnemy.Health = args.Health
	end

	return newEnemy
end

OnKeyPressed{ "ControlShift S", Name = "Fill Super Meter", Safe = true,
	function( triggerArgs )
		BuildSuperMeter( CurrentRun, 100 )
	end
}

OnKeyPressed{ "Shift X", Name = "Spawn God Boon",
	function(triggerArgs)
		--local debugBoons = {GetRandomValue(GetEligibleLootNames())}
		local debugBoons = { "DionysusUpgrade" }

		for k, debugBoon in pairs( debugBoons ) do
			CreateLoot({ Name = debugBoon, OffsetX = k * 100 })
		end

		wait(2)
		local numDummies = 1
		for dummy = 1, numDummies, 1 do
			--SpawnDummyEnemy()
		end
	end
}

OnKeyPressed{ "Alt X", Name = "Spawn MetaUpgrade",
	function(triggerArgs)
		local debugBoon = "HealthMetaUpgrade"
		--local debugBoon = GetRandomKey( MetaUpgradeData )
		local lootData = MetaUpgradeData[debugBoon]
		local lootArea = GetIdsByType({ Name = "LootPoint" })

		local lootId = nil
		if lootArea ~= nil then
			lootId = SpawnObstacle({ Name = debugBoon, DestinationId = lootArea[1], Group = "MetaUpgrades" })
		end

		AddResource( "MetaPoints", 100, "Debug" )

		wait(2)
		SpawnDummyEnemy()
		SpawnDummyEnemy()
		SpawnDummyEnemy()
		SpawnDummyEnemy()
	end
}

OnKeyPressed{ "Alt A", Name = "Spawn Ammo",
	function(triggerArgs)
		local consumableName = "ChaosWeaponUpgrade"
		local playerId = GetIdsByType({ Name = "_PlayerUnit" })
		local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = playerId, Group = "Standing" })
		local consumable = CreateConsumableItem( consumableId, consumableName, 0 )
	end
}

OnKeyPressed{ "Alt H", Name = "Spawn Health", Safe = true,
	function(triggerArgs)
		local playerId = GetIdsByType({ Name = "_PlayerUnit" })
		DropHealth( "HealDropMinor", playerId )
	end
}

OnKeyPressed{ "Alt R", Name = "Add Rerolls", Safe = true,
	function(triggerArgs)
		if CurrentRun ~= nil then
			AddRerolls( 99, "Debug", { IgnoreMetaUpgrades = true } )
		end
	end
}

OnKeyPressed{ "Alt M", Name = "Spawn Money", Safe = true,
	function(triggerArgs)
		thread( GushMoney, { Amount = 50, LocationId = CurrentRun.Hero.ObjectId, Radius = 100, Source = "DebugSpawnMoney" } )
	end
}


OnKeyPressed{ "ControlShift G", Name = "Max All Gifts",
	function(triggerArgs)
		CurrentRun.DebugUnlockGifts = true
		for npcName, npcData in pairs(GiftData) do
			if true then
				IncrementGiftMeter( npcName, GetMaxGiftLevel(npcName))

				if GameState.Gift[npcName].NewTraits == nil then
					GameState.Gift[npcName].NewTraits = {}
				end
				for i, data in pairs(npcData) do
					if type(data) == "table" and data.Gift ~= nil then
						local traitName = data.Gift
						table.insert( GameState.Gift[npcName].NewTraits, traitName )
					end
				end
			end
		end
	end
}

OnKeyPressed{ "ControlAltShift C", Name = "Fully Unlock GhostAdmin",
	function(triggerArgs)
		for cosmeticName, cosmeticData in pairs( ConditionalItemData ) do
			cosmeticData.GameStateRequirements = nil
		end
		for trackName, trackData in pairs( MusicPlayerTrackData ) do
			trackData.GameStateRequirements = nil
		end
	end
}

OnKeyPressed{ "ControlAltShift R", Name = "Randomize Gift Status",
	function(triggerArgs)
		CurrentRun.DebugUnlockGifts = true
		for npcName, npcData in pairs(GiftData) do
			if RandomChance(0.8) then
				IncrementGiftMeter( npcName, GetMaxGiftLevel(npcName))

				if GameState.Gift[npcName].NewTraits == nil then
					GameState.Gift[npcName].NewTraits = {}
				end
				for i, data in pairs(npcData) do
					if type(data) == "table" and data.Gift ~= nil then
						local traitName = data.Gift
						table.insert( GameState.Gift[npcName].NewTraits, traitName )
						if CoinFlip() then
							GameState.KeepsakeChambers[traitName] =  TraitData[traitName].ChamberThresholds[2]
						else
							GameState.KeepsakeChambers[traitName] =  RandomInt(1, TraitData[traitName].ChamberThresholds[2])
						end
					end
				end
			end
		end
	end
}

OnKeyPressed{ "Alt D", Name = "Spawn Dummy",
	function(triggerArgs)
		ConfigOptionCache.LogCombatMultipliers = true
		--local enemy = SpawnDummyEnemy({ Name = "HydraHeadLavamaker", Health = 1400, HealthBuffer = 0, Active = false })
		local enemy = SpawnDummyEnemy({ Name = "PunchingBagUnit", Health = 10, HealthBuffer = 0, Active = false })
		--enemy.WeaponOptions = { "HadesCast"}
		end
}


OnKeyPressed{ "ControlShift Y", Name = "Show RunClearScreen",
	function(triggerArgs)
		local traits = {
			"SpearThrowBounce",
			"ZeusWeaponTrait", 
			"ZeusWeaponTrait", 
			"ZeusWeaponTrait", 
			"ZeusSecondaryTrait", 
			"ZeusRangedTrait", 
			"ZeusRangedTrait", 
			"ZeusRangedTrait", 
			"ZeusRushTrait", 
			"ZeusShoutTrait",
			"ZeusShoutTrait",
			"ZeusShoutTrait",
			"ArtemisSupportingFireTrait",
			"ArtemisSupportingFireTrait",
			"ArtemisSupportingFireTrait",
			"CritVulnerabilityTrait",
			"ArtemisCriticalTrait",
			}
		for i, name in pairs(traits) do
			AddTraitToHero({TraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = name, Rarity = "Common"}) })
		end
		
		AddLastStand({
			Name = "ReincarnationTrait",
			InsertAtEnd = true,
			IncreaseMax = true,
			Icon = "ExtraLifeSkelly",
			WeaponName = "LastStandReincarnateShield",
			HealAmount = GetTotalHeroTraitValue( "KeepsakeLastStandHealAmount" ),
		})
		AddLastStand({
			Name = "ReincarnationTrait",
			InsertAtEnd = true,
			IncreaseMax = true,
			Icon = "ExtraLifeSkelly",
			WeaponName = "LastStandReincarnateShield",
			HealAmount = GetTotalHeroTraitValue( "KeepsakeLastStandHealAmount" ),
		})
		AddLastStand({
			Name = "ReincarnationTrait",
			InsertAtEnd = true,
			IncreaseMax = true,
			Icon = "ExtraLifeSkelly",
			WeaponName = "LastStandReincarnateShield",
			HealAmount = GetTotalHeroTraitValue( "KeepsakeLastStandHealAmount" ),
		})
		ShowRunClearScreen()
	end
}

OnKeyPressed{ "Alt Y", Name = "LogCombatMultipliers",
	function(triggerArgs)
		ConfigOptionCache.LogCombatMultipliers = not ConfigOptionCache.LogCombatMultipliers
	end
}

OnKeyPressed{ "ControlAlt R", Name = "Reload All Traits",
	function(triggerArgs)
		ReloadAllTraits()
	end
}

OnKeyPressed{ "Alt T", Name = "Add Traits",
	function(triggerArgs)
		 -- EquipPlayerWeapon( WeaponData.FistWeapon )
		local traits = {
			"SpearThrowBounce",
			}
		for i, name in pairs(traits) do
			AddTraitToHero({TraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = name, Rarity = "Common"}) })
		end
	end
}

OnKeyPressed{ "ControlAlt C", Name = "Credits Test",
function(triggerArgs)
		AddInputBlock({ Name = "Credits Test" })
		StartCredits( "Return02" )
		RemoveInputBlock({ Name = "Credits Test" })
	end
}

OnKeyPressed{ "ControlShift F", Name = "Full Wrath & Trait",
	function(triggerArgs)

	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Shout" or traitData.AltSlot == "Shout" then
			BuildSuperMeter( CurrentRun, 25)
			return
		end
	end

	AddTraitToHero({TraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = "ZeusShoutTrait", Rarity = "Epic"}) })

	-- BuildSuperMeter( CurrentRun, 100)
	end
}

OnKeyPressed{ "Alt K", Name = "Kill Required Kills",
	function(triggerArgs)
		DestroyRequiredKills()
	end
}

OnKeyPressed{ "Alt I", Name = "Display Run Info",
	function(triggerArgs)
		DebugPrint({ Text = "Run #: "..GetCompletedRuns() })
		DebugPrint({ Text = "Depth: "..GetRunDepth( CurrentRun ) })
		DebugPrint({ Text = "Encounter: "..CurrentRun.CurrentRoom.Encounter.Name })
	end
}

OnKeyPressed{ "Control M", Name = "Add Resources", Safe = true,
	function( triggerArgs )
		AddResource( "MetaPoints", 99999, "Debug" )
		AddResource( "Gems", 9999, "Debug" )
		AddResource( "LockKeys", 999, "Debug" )
		AddResource( "GiftPoints", 9999, "Debug" )
		AddResource( "SuperLockKeys", 99, "Debug" )
		AddResource( "SuperGems", 99, "Debug" )
		AddResource( "SuperGiftPoints", 99, "Debug" )
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
		thread( PlayVoiceLines, GlobalVoiceLines.FabulousWealthVoiceLines, true )
	end
}

OnKeyPressed{ "ControlAlt F", Name = "Add Fish", Safe = true,
	function( triggerArgs )
		RecordFish(GetFish("Tartarus", "Good"))
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
		thread( PlayVoiceLines, GlobalVoiceLines.FabulousWealthVoiceLines, true )
	end
}

OnKeyPressed{ "ControlAlt L", Name = "Open MetaUpgradeMenu",
	function( triggerArgs )
		GameState.Flags.SwapMetaupgradesEnabled = true
		GameState.Flags.SwapMetaupgradesEnabledPresentation = true
		GameState.MetaUpgradeStagesUnlocked = 5
		OpenMetaUpgradeMenu()
	end
}

OnKeyPressed{ "ControlAlt S", Name = "Open ShrineUpgradeMenu",
	function( triggerArgs )
		GameState.WeaponRecordsShrinePoints = {}
		GameState.RecordClearedShrineThreshold = {}
		for i, weaponName in ipairs( WeaponSets.HeroPhysicalWeapons ) do

			GameState.WeaponRecordsShrinePoints[weaponName] = 1000 - ShrineClearData.ClearThreshold
			GameState.RecordClearedShrineThreshold[weaponName] = {}
			for s, roomName in pairs(ShrineClearData.BossRoomNames) do
				GameState.RecordClearedShrineThreshold[weaponName][roomName] = 1000 - ShrineClearData.ClearThreshold
			end
		end
		OpenShrineUpgradeMenu({ BlockRunStartButton = true, IgnoreRequirements = true })
	end
}

function CreateDevSaveName( currentRun, args )
	-- Only legal Windows file path characters allowed
	-- Ordering is now such that sorting by name sorts by 'deepest' saves
	local name = ""
	name = name.."Run "..(GetCompletedRuns() + 1)..", "
	if args ~= nil and args.StartNextMap ~= nil then
		name = name.."Dead, "..args.StartNextMap
	else
		name = name.."Depth "..GetRunDepth( currentRun )..", "
		name = name..currentRun.CurrentRoom.Name..", "
		name = name..currentRun.CurrentRoom.Encounter.Name
		if args ~= nil and args.PostReward then
			name = name.." (PostReward)"
		elseif currentRun.CurrentRoom.ChosenRewardType ~= nil then
			name = name.." ("..currentRun.CurrentRoom.ChosenRewardType
			if currentRun.CurrentRoom.ForceLootName ~= nil then
				name = name.." - "..currentRun.CurrentRoom.ForceLootName
			end
			name = name..")"
		end
	end
	return name
end

function EquipDebugWeapons( newEnemy )
	local debugContinuousWeapon = "DionysusEnemyWeapon"
	EquipWeapon({ Name = debugContinuousWeapon, DestinationId = newEnemy.ObjectId })
	SetUnitProperty({ Property = "ContinuousWeapon", Value = debugContinuousWeapon, DestinationId = newEnemy.ObjectId })

end

function OnHotLoadXML()
	thread( PostHotloadXML )
end

function PostHotloadXML()
	if CurrentRun ~= nil then
		SetHeroProperties( CurrentRun )
		HideCombatUI()
		ShowCombatUI()
	end
end

function OnHotLoadLua()

	if SetupRunData ~= nil then
		SetupRunData()
	end

	if HotLoadInfo ~= nil then
		if HotLoadInfo.CurrentTextLines ~= nil then
			HotLoadInfo.CurrentTextLines = TextLinesCache[HotLoadInfo.CurrentTextLines.Name]
		end

		if HotLoadInfo.TextBoxCache ~= nil then
			for id, formatName in pairs( HotLoadInfo.TextBoxCache ) do
				local params = ShallowCopyTable( TextFormats[formatName] )
				params.Id = id
				params.AutoSetDataProperties = true
			ModifyTextBox( params )
			end
		end
	end

end

OnKeyPressed{ "ControlShift C", Name = "UnlockEntireCodex",
	function(triggerArgs)
		UnlockEntireCodex()
		thread( ShowCodexUpdate )
	end
}

function UnlockEntireCodex()

	CodexStatus.Enabled = true
	local num = 10

	for chapterName, chapterData in pairs(Codex) do
		if chapterData.Entries ~= nil then
			for entryName, entryData in pairs(chapterData.Entries) do
				for i = 1, num do
					UnlockCodexEntry(chapterName, entryName, i, true )
				end
			end
		end
	end
end

function GetRewardsTaken( room, rewardsTakenTotals )
	if room.ChosenRewardType ~= nil then
		if rewardsTakenTotals[room.ChosenRewardType] == nil then
			rewardsTakenTotals[room.ChosenRewardType] = 0
		end
		rewardsTakenTotals[room.ChosenRewardType] = rewardsTakenTotals[room.ChosenRewardType] + 1

		-- Track boons individually as well, whereas "Boon" is the sum of all boons
		--if room.ChosenRewardType == "Boon" and room.ForceLootName ~= nil then
			--rewardsTakenTotals[room.ForceLootName] = (rewardsTakenTotals[room.ForceLootName] or 0) + 1
		--end
	end

	if room.ChosenRewardType == "Boon" and room.ForceLootName ~= nil then
		return tostring(room.ForceLootName)
	else
		return tostring(room.ChosenRewardType)
	end
end

function GetRewardsOffered( room, rewardsOfferedTotals, sep )
	local rewardsOfferedStr = nil
	if sep == nil then
		sep = ", "
	end
	if room.OfferedRewards ~= nil then
		for doorId, offeredReward in pairs( room.OfferedRewards ) do
			local rewardType = offeredReward.Type
			if rewardType ~= nil then
				if rewardsOfferedStr == nil then
					rewardsOfferedStr = rewardType
				else
					rewardsOfferedStr = rewardsOfferedStr..sep..rewardType
				end
				if OfferedExitDoors[doorId] ~= nil and OfferedExitDoors[doorId].Room ~= nil then
					rewardsOfferedStr = rewardsOfferedStr.." ("..OfferedExitDoors[doorId].Room.Name..")"
				end
				rewardsOfferedTotals[rewardType] = (rewardsOfferedTotals[rewardType] or 0) + 1
			end
		end
	end
	return tostring(rewardsOfferedStr)
end

OnKeyPressed{ "ControlAlt G", Name = "DumpGameStateStats", Safe = true,
	function(triggerArgs)
		DumpGameStateStats()
	end
}

OnKeyPressed{ "ControlShift CapsLock", Name = "DumpGameStateToFile",
	function(triggerArgs)
		DumpGameStateToFile()
	end
}

function DumpGameStateStats()
	local runs = TableLength( GameState.RunHistory ) + 1
	DebugPrint({ Text = "GameState:" })
	DebugPrint({ Text = "  Runs: "..runs })
	DebugPrint({ Text = "  Collected MetaPoints: "..GetTotalAccumulatedMetaPoints() })
	DebugPrint({ Text = "  Spent MetaPoints: "..GetTotalAccumulatedMetaPoints() - GameState.Resources.MetaPoints })

	DebugPrint({ Text = "  Damage Dealers: " })
	for name, count in pairs( GameState.EnemySpawns ) do
		if GameState.EnemyDamage[name] ~= nil then
			DebugPrint({ Text = "    Name: "..name..", Spawns: "..count..", Kills: "..tostring(GameState.EnemyKills[name]).." Damage: "..tostring(GameState.EnemyDamage[name]) })
		end
	end

	DumpRunStats( CurrentRun, runs )
end

function DumpGameStateToFile()

	local gameData =
	{
		CurrentRun = CurrentRun,
		GameState =
		{
			MetaPoints = GameState.Resources.MetaPoints,
			MetaUpgrades = GameState.MetaUpgrades,
			LockKeys = GameState.Resources.LockKeys,
			GiftPoints = GameState.Resources.GiftPoints,
			ShrinePoints = GameState.Resources.ShrinePoints,
			SpentShrinePointsCache = GameState.SpentShrinePointsCache,
			TimesCleared = GameState.TimesCleared,
			CompletedRunsCache = GameState.CompletedRunsCache,
		}
	}
	local json = TableToJSONString(gameData, {}, "GameData")
	DebugPrint({ File = "GameData.json", Text = json })

end

function DumpRunHistoryStats()

	local runs = TableLength( GameState.RunHistory ) + 1
	local outFileBuf = ""

	outFileBuf = DebugPrintf({ File = outFileBuf, Text = "GameState:" })
	outFileBuf = DebugPrintf({ File = outFileBuf, Text = "  Runs: "..runs })
	outFileBuf = DebugPrintf({ File = outFileBuf, Text = "  Collected MetaPoints: "..GetTotalAccumulatedMetaPoints() })
	outFileBuf = DebugPrintf({ File = outFileBuf, Text = "  Spent MetaPoints: "..GetTotalAccumulatedMetaPoints() - GameState.Resources.MetaPoints })

	-- Full room history of all runs
	local gameStatsCsvBuf = DebugWriteCsvRow("", { "Room", "Depth", "Chosen Reward", "Reward Taken", "Next Rewards Offered" })
	local csvFile = "GameStatsDump.csv"
	local rewardsOfferedTotals = {}
	local rewardsTakenTotals = {}
	local roomDists = {}
	local runDepthHistogram = {}
	local runsSampled = 0
	local allRunHistory = CollapseTableOrdered( GameState.RunHistory )
	table.insert(allRunHistory, CurrentRun)
	if runs > 1 then
		for runIndex, run in pairs(allRunHistory) do
			outFileBuf = DumpRunStats( run, runIndex, outFileBuf )
			if run.RoomHistory ~= nil then
				for depth, room in ipairs(run.RoomHistory) do
					if room ~= nil then
						local row = {}
						-- Track room distributions
						if roomDists[room.Name] == nil then
							roomDists[room.Name] = { 1 }
						else
							roomDists[room.Name] = { roomDists[room.Name][1] + 1 }
						end
						table.insert(row, room.Name)
						table.insert(row, depth)
						table.insert(row, room.ChosenRewardType)
						table.insert(row, GetRewardsTaken(room, rewardsTakenTotals))
						table.insert(row, '"'..GetRewardsOffered(room, rewardsOfferedTotals)..'"')
						gameStatsCsvBuf = DebugWriteCsvRow(gameStatsCsvBuf, row)
					end
				end
				local depth = GetRunDepth(run)
				runDepthHistogram[depth] = (runDepthHistogram[depth] or 0) + 1
				runsSampled = runsSampled + 1
			end
		end
		--DebugPrint({ File = csvFile, Text = gameStatsCsvBuf })
		--DebugPrint({ File = "RunHistoryFullDump.txt", Text = outFileBuf })
	end

	-- RunDepthHistogram.csv
	-- We want this sorted by KEY, so use orderedPairs
	local depthHistogramCsv = "RunDepthHistogram.csv"
	local depthHistogramCsvBuf = DebugWriteCsvRow("", { "Depth", "# of runs at depth", "% of total runs sampled" })
	for depth, instances in pairs(runDepthHistogram) do
		local percentage = "0%"
		if runsSampled > 0 then
			percentage = tostring( instances / runsSampled * 100 ).."%"
		end
		depthHistogramCsvBuf = DebugWriteCsvRow(depthHistogramCsvBuf, { depth, instances, percentage })
	end
	--DebugPrint({ File = depthHistogramCsv, Text = depthHistogramCsvBuf })

	-- Room.csv aggregation
	local roomsCsv = "RoomDistributions.csv"
	local roomsCsvBuf = DebugWriteCsvRow("", { "Room Name", "Times Seen", "% Seen" })
	local totalRoomsSeen = 0
	roomDists = CollapseTableAsOrderedKeyValuePairs( roomDists )
	for i, kvp in ipairs(roomDists) do
		local timesSeen = kvp.Value[1]
		totalRoomsSeen = totalRoomsSeen + timesSeen
	end
	if totalRoomsSeen > 0 then
		for i, kvp in ipairs(roomDists) do
			local roomName = kvp.Key
			local timesSeen = kvp.Value[1]
			roomsCsvBuf = DebugWriteCsvRow(roomsCsvBuf, { kvp.Key, timesSeen, tostring(timesSeen / totalRoomsSeen * 100).."%" })
		end
	end
	--DebugPrint({ File = roomCsv, Text = roomsCsvBuf })

	-- Rewards taken/offered aggregation
	rewardsTakenTotals = CollapseTableAsOrderedKeyValuePairs(rewardsTakenTotals)
	rewardsOfferedTotals = CollapseTableAsOrderedKeyValuePairs(rewardsOfferedTotals)

	local rewardsCsv = "RewardsData.csv"
	local rewardsCsvBuf = ""
	header = { "Reward Name", "Times Taken", "Times Offered", "% Taken", "% Offered" }
	local rows = {}
	local totalRewardsTaken = 0
	local totalRewardsOffered = 0
	for i, kvp in ipairs(rewardsOfferedTotals) do
		local rewardName = kvp.Key
		local timesTaken = 0
		local timesOffered = kvp.Value
		for j, takenKvp in ipairs(rewardsTakenTotals) do
			if takenKvp.Key == rewardName then
				timesTaken = takenKvp.Value
				totalRewardsTaken = totalRewardsTaken + (timesTaken or 0)
			end
		end
		totalRewardsOffered = totalRewardsOffered + (timesOffered or 0)
		local row = { rewardName, timesTaken, timesOffered }
		table.insert(rows, row)
	end
	table.sort(rows, function (a, b)
		-- Sort by most taken, then by most offered
		if a[2] > b[2] == 0 then
			return a[3] > b[3]
		end
		return a[2] > b[2]
	end)
	if totalRewardsTaken > 0 then
		rewardsCsvBuf = DebugWriteCsvRow(rewardsCsvBuf, header)
		for i, row in ipairs(rows) do
			table.insert(row, tostring(row[2] / totalRewardsTaken * 100).."%")
			table.insert(row, tostring(row[3] / totalRewardsOffered * 100).."%")
			rewardsCsvBuf = DebugWriteCsvRow(rewardsCsvBuf, row)
		end
	end
	--DebugPrint({ File = rewardsCsv, Text = rewardsCsvBuf })
end

function DebugWriteCsvRow(buffer, row)
	return DebugWriteLine(buffer, table.concat(row, ","))
end

function DebugWriteLine(buffer, appendString)
	buffer = buffer..appendString.."\r\n"
	return buffer
end

function DebugPrintf(args)
	if args.File == nil then
		DebugPrint(args)
	else
		return DebugWriteLine(args.File, args.Text)
	end
end

function DumpRunStats( currentRun, runIndex, outFile )

	if runIndex == nil then
		runIndex = 1
	end
	if currentRun == nil then
		return outFile
	end
	if currentRun.RoomHistory == nil then
		return outFile
	end

	local runDepth = GetRunDepth(currentRun)

	outFile = DebugPrintf({ File = outFile, Text = "Run #"..runIndex..":" })
	outFile = DebugPrintf({ File = outFile, Text = "  Collected Money: "..((currentRun.Money or 0) + (currentRun.MoneySpent or 0)) })
	outFile = DebugPrintf({ File = outFile, Text = "  Spent Money: "..(currentRun.MoneySpent or 0) })
	outFile = DebugPrintf({ File = outFile, Text = "  Money Sources: " })
	if currentRun.MoneyRecord ~= nil then
		for source, amount in pairs( currentRun.MoneyRecord ) do
			outFile = DebugPrintf({ File = outFile, Text = "      Source: "..source..", Amount: "..amount })
		end
	end

	outFile = DebugPrintf({ File = outFile, Text = "  Damage Sources: " })
	if currentRun.DamageRecord ~= nil then
		for source, amount in pairs( currentRun.DamageRecord ) do
			outFile = DebugPrintf({ File = outFile, Text = "      Source: "..source..", Amount: "..amount })
		end
	end
	outFile = DebugPrintf({ File = outFile, Text = "  Health Sources: " })
	if currentRun.HealthRecord ~= nil then
		for source, amount in pairs( currentRun.HealthRecord ) do
			outFile = DebugPrintf({ File = outFile, Text = "      Source: "..source..", Amount: "..amount })
		end
	end
	outFile = DebugPrintf({ File = outFile, Text = "  Actual Health Sources: " })
	if currentRun.ActualHealthRecord then
		for source, amount in pairs( currentRun.ActualHealthRecord ) do
			outFile = DebugPrintf({ File = outFile, Text = "      Source: "..source..", Amount: "..amount })
		end
	end
	outFile = DebugPrintf({ File = outFile, Text = "  Hero Traits (Depth "..runDepth.."):" })
	if currentRun.Hero ~= nil and currentRun.Hero.Traits ~= nil then
		local collapsedTraits = {}
		local traitTxt = "traits_run "..runIndex.."_depth_"..runDepth..".txt"
		local traitTxtBuf = ""
		for k, traitData in pairs( currentRun.Hero.Traits ) do
			collapsedTraits[traitData.Name] = traitData
			if not currentRun.Hero.IsDead then
				traitTxtBuf = DebugPrintf({ File = traitTxtBuf, Text = traitData.Name..", Depth: "..runDepth })
			end
		end
		DebugPrint({ File = traitTxt, Text = traitTxtBuf })
		collapsedTraits = CollapseTableOrdered(collapsedTraits)

		-- No sense logging traits if the player is dead
		if not currentRun.Hero.IsDead then
			local traitsCsv = "Traits at Run "..runIndex..", Depth "..runDepth..".csv"
			local traitsCsvBuf = DebugWriteCsvRow( "", { "Trait", "Level", "Rarity", "God", "RemainingUses", "RemainingRooms" })
			local traitsCsvRows = {}

			for k, traitData in ipairs( collapsedTraits ) do
				local level = nil
				if currentRun.Hero.TraitDictionary ~= nil then
					level = TableLength( currentRun.Hero.TraitDictionary[traitData.Name] )
				end
				if level == nil then
					level = 1
				end
				table.insert( traitsCsvRows, { traitData.Name, level, tostring(traitData.Rarity), tostring(traitData.God), tostring(traitData.RemainingUses), tostring(traitData.RemainingRooms) })
				outFile = DebugPrintf({ File = outFile, Text = "      Trait: "..traitData.Name.." ("..tostring(traitData.Rarity)..", level "..level..") God: "..tostring(traitData.God) })
			end

			-- Sort by most upgraded, then Rarity
			table.sort(traitsCsvRows, function (a, b)
				if a[2] == b[2] then
					local rarityTable = {
						Common = 0,
						Rare = 1,
						Epic = 2,
						Legendary = 3
					}
					local aRarity = rarityTable[a[3]]
					local bRarity = rarityTable[b[3]]
					if aRarity == nil then
						aRarity = -1
					end
					if bRarity == nil then
						bRarity = -1
					end
					return aRarity > bRarity
				end
				return a[2] > b[2]
			end)
			for i, row in ipairs(traitsCsvRows) do
				traitsCsvBuf = DebugWriteCsvRow( traitsCsvBuf, row )
			end
			DebugPrint({ File = traitsCsv, Text = traitsCsvBuf })
		end
	end

	outFile = DebugPrintf({ File = outFile, Text = "    Room History:" })
	local rewardsOfferedTotals = {}
	local rewardsTakenTotals = {}
	for depth, room in ipairs( currentRun.RoomHistory ) do
		if room ~= nil then
			local rewardStr = GetRewardsTaken( room, rewardsTakenTotals )
			local rewardsOfferedStr = GetRewardsOffered( room, rewardsOfferedTotals )
			outFile = DebugPrintf({ File = outFile, Text = "      Depth: "..depth.." | Room: "..room.Name.." | Reward: "..rewardStr.." | Next Rewards Offered: "..rewardsOfferedStr })
		end
	end
	if currentRun.CurrentRoom ~= nil then
		local rewardStr = GetRewardsTaken( currentRun.CurrentRoom, rewardsTakenTotals )
		local rewardsOfferedStr = GetRewardsOffered( currentRun.CurrentRoom, rewardsOfferedTotals )
		outFile = DebugPrintf({ File = outFile, Text = "      Current Depth: "..runDepth.." | Room: "..currentRun.CurrentRoom.Name.." | Reward: "..rewardStr.." | Next Rewards Offered: "..rewardsOfferedStr })
	else
		outFile = DebugPrintf({ File = outFile, Text = "      Current Depth:  (DeathArea)"})
	end

	outFile = DebugPrintf({ File = outFile, Text = "    Rewards Offered Totals:" })
	for rewardType, rewardCount in pairs( rewardsOfferedTotals ) do
		outFile = DebugPrintf({ File = outFile, Text = "      "..rewardType..": "..rewardCount })
	end

	outFile = DebugPrintf({ File = outFile, Text = "    Rewards Taken Totals:" })
	for rewardType, rewardCount in pairs( rewardsTakenTotals ) do
		outFile = DebugPrintf({ File = outFile, Text = "      "..rewardType..": "..rewardCount })
	end

	if currentRun.RewardStores ~= nil then
		for storeName, rewardStore in pairs( currentRun.RewardStores ) do
			local storeStr = ""
			for j, reward in pairs( rewardStore ) do
				storeStr = storeStr..tostring(reward.Name)..", "
			end
			outFile = DebugPrintf({ File = outFile, Text = "    Upcoming Rewards ("..storeName.."): "..storeStr })
		end
	end

	return outFile
end


function AnimateOnDistance(eventSource, args)
	local notifyName = "WithinDistance"..args.Name

	NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = GetIdsByType({ Name = args.Name }), Distance = args.Distance, Notify = notifyName })
	waitUntil( notifyName )

	--SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = args.AnimationName })

	SetUnitProperty({ Property = "MoveGraphic", Value = args.AnimationName, DestinationId = CurrentRun.Hero.ObjectId })
	--SetThingProperty({ Property = "Graphic", Value = "HeroDeadIdle", DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "Speed", Value = 200, DestinationId = CurrentRun.Hero.ObjectId })

	thread(AnimateOutsideDistance(eventSource, args))
end

function AnimateOutsideDistance(eventSource, args)
	local notifyName = "OutsideDistance"..args.Name

	NotifyOutsideDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = GetIdsByType({ Name = args.Name }), Distance = args.Distance, Notify = notifyName })
	waitUntil( notifyName )

	--SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = args.AnimationName })

	SetUnitProperty({ Property = "MoveGraphic", Value = "ZagreusRun", DestinationId = CurrentRun.Hero.ObjectId })
	--SetThingProperty({ Property = "Graphic", Value = "HeroDeadIdle", DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "Speed", Value = 500, DestinationId = CurrentRun.Hero.ObjectId })

	thread(AnimateOnDistance(eventSource, args))
end

OnKeyPressed{ "Alt D1", Name = "ChangeWeaponSword",
	function(triggerArgs)
		EquipPlayerWeapon( WeaponData.SwordWeapon, { PreLoadBinks = true, LoadPackages = true } )
	end
}
OnKeyPressed{ "Alt D2", Name = "ChangeWeaponSpear",
	function(triggerArgs)
		EquipPlayerWeapon( WeaponData.SpearWeapon, { PreLoadBinks = true, LoadPackages = true } )
	end
}
OnKeyPressed{ "Alt D3", Name = "ChangeWeaponShield",
	function(triggerArgs)
		EquipPlayerWeapon( WeaponData.ShieldWeapon, { PreLoadBinks = true, LoadPackages = true } )
	end
}
OnKeyPressed{ "Alt D4", Name = "ChangeWeaponBow",
	function(triggerArgs)
		EquipPlayerWeapon( WeaponData.BowWeapon, { PreLoadBinks = true, LoadPackages = true } )
	end
}
OnKeyPressed{ "Alt D5", Name = "ChangeWeaponGun",
	function(triggerArgs)
		EquipPlayerWeapon( WeaponData.GunWeapon, { PreLoadBinks = true, LoadPackages = true } )
	end
}
OnKeyPressed{ "Alt D6", Name = "ChangeWeaponFist",
	function(triggerArgs)
		EquipPlayerWeapon( WeaponData.FistWeapon, { PreLoadBinks = true, LoadPackages = true } )
	end
}

function EditingModeOn()
	if CurrentDeathAreaRoom ~= nil and CurrentDeathAreaRoom.Name == "DeathAreaBedroom" then
		local ids = GetIds({ Names = { "Conditional" }})
		for k, id in pairs (ids) do
			SetAlpha({ Id = id, Fraction = 1, Duration = 0 })
		end
	end
end

function EditingModeOff()

	if CurrentDeathAreaRoom ~= nil and CurrentDeathAreaRoom.ZoomFraction ~= nil then
		FocusCamera({ Fraction = CurrentDeathAreaRoom.ZoomFraction, Duration = 0.01 })
	elseif CurrentRun ~= nil and CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.ZoomFraction ~= nil then
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, Duration = 0.01 })
	else
		FocusCamera({ Fraction = 1.0, Duration = 0.01 })
	end
	notify( "EditingModeOff" )

end

function ReloadAllTraits()
	-- Remove all traits, then readd them in order
	local weaponName = GetEquippedWeapon()
	local removedTraitData = {}
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		table.insert(removedTraitData, { Name = traitData.Name, Rarity = traitData.Rarity })
		DebugPrint({Text = "Reloading trait" .. traitData.Name })
	end

	for i, traitData in pairs(removedTraitData) do
		RemoveTrait( CurrentRun.Hero, traitData.Name )
	end
	-- re-equip all weapons to flush Absolute change values

	UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })
	local weaponSetNames = WeaponSets.HeroWeaponSets[weaponName]
	if weaponSetNames ~= nil then
		for k, linkedWeaponName in pairs( weaponSetNames ) do
			UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName })
		end
	end
	UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = "RangedWeapon "})


	EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })
	if weaponSetNames ~= nil then
		for k, linkedWeaponName in pairs( weaponSetNames ) do
			EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName })
		end
	end
	EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = "RangedWeapon" })


	for i, traitData in pairs(removedTraitData) do
		if traitData.Name then
			if traitData.Rarity then
				AddTraitToHero({ TraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, Rarity = traitData.Rarity}) })
			else
				AddTraitToHero({ TraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name }) })
			end
		end
	end
	UpdateHeroTraitDictionary()
	DebugPrint({Text = "Finished reloading "})
end

--OnControlPressed{ "Assist", -- Switch comment with below to run via LeftTrigger instead if debug keys not available
OnKeyPressed{ "ControlAltShift T", Name = "PerfTest",
	function( triggerArgs )

		AdjustZoom({ Fraction = 0.4, LerpTime = 0.0 })

		local spawnRadius = 2000 -- Actually a square

		local binkUnitCount = 12
		for i = 1, binkUnitCount do
			local unitName = "HeavyMelee"
			local newUnit = DeepCopyTable( EnemyData[unitName] )
			newUnit.ObjectId = SpawnUnit({ Name = newUnit.Name, Group = "Standing", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = spawnRadius, OffsetY = spawnRadius })
			newUnit.SkipAISetupOnActivate = true
			SetupEnemyObject( newUnit, CurrentRun )
		end

		local staticObjectCount = 1000
		for i = 1, staticObjectCount do
			local objectId = SpawnObstacle({ Name = "HouseChair01", Group =  "Standing", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = math.random(-spawnRadius, spawnRadius), OffsetY = math.random(-spawnRadius, spawnRadius) })
			SetScale({ Id = objectId, Fraction = 0.4 })
		end

		local vfxCount = 1000
		local animAnchorId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Standing", DestinationId = CurrentRun.Hero.ObjectId })
		for i = 1, vfxCount do
			CreateAnimation({ Name = "CandleFlame", DestinationId = animAnchorId, OffsetX = math.random(-spawnRadius, spawnRadius), OffsetY = math.random(-spawnRadius, spawnRadius) })
		end

	end
}

OnKeyPressed{ "ControlAlt N", Name = "AnimationTest",
	function( triggerArgs )
 		CreateAnimation({ Name = "HadesUrnConsumeFx_Self", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0 })
	end
}

function TestFunction( unit )
	unit.Targetable = true
end

function DumpTableInfo( object )
	local string = tostring(object)
	if type(object) == "table" then
		string = "(TABLE VALUE)"
	end
	if object ~= nil then
		if object.Name then
			string = string .. ":Name " .. object.Name
		end
		local displayed = 0
		for i, key in pairs(object) do
			string = string.." ".. tostring(i) .. ":" .. tostring(key)
			displayed = displayed + 1
			if displayed > 4 then
				break
			end
		end
	end
	DebugPrint({Text = string })
end

function DoPatchesForSaveFileDumper()
	if not GameState.MetaUpgradesSelected then
		GameState.MetaUpgradesSelected = {}
	end
	if IsEmpty( GameState.MetaUpgradesSelected ) then
		for k, metaUpgradeChoices in pairs( MetaUpgradeOrder ) do
			GameState.MetaUpgradesSelected[k] = metaUpgradeChoices[1]
		end
	end
end