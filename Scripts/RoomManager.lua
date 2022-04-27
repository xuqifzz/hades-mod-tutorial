Import "Color.lua"
Import "UIPresentation.lua"
Import "UIScripts.lua"
Import "CreditsScripts.lua"
Import "EventPresentation.lua"
Import "AudioScripts.lua"
Import "Narrative.lua"
Import "CodexData.lua"
Import "GiftData.lua"
Import "SellTraitData.lua"
Import "StoreData.lua"
Import "WeaponUpgradeData.lua"
Import "BoonInfoScreenData.lua"
Import "GhostData.lua"
Import "ObstacleData.lua"
Import "CodexScripts.lua"
Import "UtilityScripts.lua"
Import "DebugScripts.lua"
Import "PlayerAIData.lua"
Import "Localization.lua"

Import "Art.lua"
Import "EnemyAI.lua"
Import "UpgradeManager.lua"
Import "FishingScripts.lua"
Import "FishingData.lua"
Import "AwardMenuScripts.lua"
Import "KeepsakeScripts.lua"
Import "StoreScripts.lua"
Import "SellTraitScripts.lua"
Import "MarketScreen.lua"
Import "GhostAdminScreen.lua"
Import "MusicPlayerScreen.lua"
Import "QuestLogScreen.lua"
Import "AchievementLogic.lua"
Import "BadgePresentation.lua"
Import "BadgeLogic.lua"
Import "RunClearScreen.lua"
Import "RunHistoryScreen.lua"
Import "GameStatsScreen.lua"
Import "RoomPresentation.lua"
Import "RunData.lua"
Import "RunManager.lua"
Import "Combat.lua"
Import "CombatPresentation.lua"
Import "GhostScripts.lua"
Import "TraitTrayScripts.lua"
Import "WeaponUpgradeScripts.lua"
Import "BoonInfoScreenScripts.lua"

-- Spawned Objects
Using "BlackScreen"
Using "BaseLoot"
Using "BaseBoon"
Using "BloodFrame"
Using "ChallengeSwitchBase"
Using "ChallengeSwitchLocked"
Using "ChallengeSwitchOpen"
Using "SecretDoor_Closed"
Using "SecretDoor_Revealed"
Using "ShrinePointDoor_Closed"
Using "ShrinePointDoor_Revealed"
Using "InteractBacking"
Using "ConsolationPrize"
Using "ShadeShieldBunker"

Using "EnemySwordIdle"
Using "EnemySwordPickup"
Using "EnemySpearIdle"
Using "EnemySpearPickup"
Using "EnemyBowIdle"
Using "EnemyBowPickup"
Using "EnemyShieldIdle"
Using "EnemyShieldPickup"
Using "StyxGibletsRat01a"
Using "StyxGibletsRat01b"
Using "Critter_MouseBounce"
Using "Critter_MouseScurry"

-- Hot-swapped Art
Using "BreakableIdle1"
Using "BreakableIdle2"
Using "BreakableIdle3"
Using "BreakableHighValueIdle"
Using "BreakableHighValueIdleSuper"
Using "TartarusWallPillar01"
Using "TartarusWallMural01"
Using "HouseStatueSkelly01"
Using "HouseStatueSkelly02"
Using "HouseStatueSkelly03"
Using "HouseStatueSkelly04"

-- Non-Binked Traps
Using "SpikeTrapIdle"
Using "SpikeTrapPressed"
Using "SpikeTrapPreFire"
Using "SpikeTrapDeactivated"
Using "DartTrapPressed"
Using "DartTrapPreFire"
Using "DartTrapDeactivated"
Using "ReflectionBlob"
Using "TrapFissureDisabled"
Using "GasTrapIdle"
Using "GasTrapActivated"
Using "ReflectiveMirrorIdle"
Using "ReflectiveMirrorTriggered"
Using "SawTrapProjectile"
Using "SawTrapIdle"
Using "SawTrapDeactivated"
Using "GasTrapPoisonIdle"
Using "GasTrapPoisonActivated"
Using "HadesTombstone"

-- Non-Binked Enemies
Using "Swarmer"
Using "SwarmerHelmeted"
Using "LightSpawner"
Using "HeavyRanged"
Using "HeavyRangedForked"
Using "HeavyRangedSplitterMiniboss"
Using "ShieldRanged"
Using "EnemyWretchThiefIdle"
Using "Projectile_BloodlessGrenadier"
Using "Projectile_BloodlessGrenadierActivate"
Using "Projectile_BloodlessGrenadierToss"
Using "CrusherUnit"
Using "CrusherUnitOnGround"
Using "BaseMedusaHead"
Using "EnemyMedusaHeadFire"
Using "EnemyMedusaHeadFireHitAndRun"
Using "ShadeNaked"
Using "ShadeNakedDeathVFX"
Using "Crawler"
Using "RatThug" -- Binked but need its fx textures, especially the scales since it shares many with Crawler
Using "FlurrySpawner"
Using "SoulSpawnerButterfly"
Using "SoulSpawnerButterflyDeath"

RoomThreadName = "RoomThread"

OnPreThingCreation
{
	function( triggerArgs )

		--ValidateThreadLeaks()
		UpdateConfigOptionCache()
		RandomInit()
		DoPatches()
		SetupMap()
		AudioInit()
		NarrativeInit()
		CodexInit()

		LifeOnKillRecord = {}
		DamageRecord = {}
		HealthRecord = {}
		SpawnRecord = {}
		OfferedExitDoors = {}

		local mapName = GetMapName({ })
		if RoomData[mapName] == nil then
			return
		end

		if GameState == nil then
			StartNewGame()
		end

		ResetUI()

		if RandomChance(0.5) then
			local thingsToSwap = GetMapThings({ Name = "RandomSwaps" })
			for swapId, currentName in pairs( thingsToSwap ) do
				if ObstacleData[currentName] ~= nil and ObstacleData[currentName].RandomSwaps ~= nil then
					local randomSwapName = GetRandomValue( ObstacleData[currentName].RandomSwaps )
					SwapName({ DestinationId = swapId, Name = randomSwapName })
				end
			end
		end

		if CurrentRun.CurrentRoom ~= nil then
			RunUnthreadedEvents( CurrentRun.CurrentRoom.PreThingCreationUnthreadedEvents, CurrentRun.CurrentRoom )

			if GetConfigOptionValue({ Name = "ResetRoomData" }) then
				CurrentRun.CurrentRoom.Flipped = false
				for key, value in pairs( RoomData[CurrentRun.CurrentRoom.Name] ) do
					CurrentRun.CurrentRoom[key] = value
				end
				if CurrentRun.CurrentRoom.Encounter ~= nil then
					local encounterData = EncounterData[CurrentRun.CurrentRoom.Encounter.Name]
					if encounterData ~= nil then
						for key, value in pairs( encounterData ) do
							CurrentRun.CurrentRoom.Encounter[key] = value
						end
						if CurrentRun.CurrentRoom.Encounter.Generated then
							GenerateEncounter( CurrentRun, CurrentRun.CurrentRoom, CurrentRun.CurrentRoom.Encounter )
						end
					else
						CurrentRun.CurrentRoom.Encounter = ChooseEncounter( CurrentRun, CurrentRun.CurrentRoom )
					end
				end
			end
			if GetConfigOptionValue({ Name = "ForceFlipMapThings" }) then
				CurrentRun.CurrentRoom.Flipped = true
			end
		end

		if CurrentRun ~= nil and CurrentRun.CurrentRoom.Flipped ~= nil and CurrentRun.CurrentRoom.Name == GetMapName({ }) then
			SetConfigOption({ Name = "FlipMapThings", Value = CurrentRun.CurrentRoom.Flipped })
		end

		if GetConfigOptionValue({ Name = "DumpRunStatsOnLoad" }) then
			DumpGameStateToFile()
		end

	end
}

OnAnyLoad
{
	function( triggerArgs )

		CheckQuestStatus({ Silent = true })
		thread( CheckProgressAchievements )
		RemoveInputBlock({ Name = "MapLoad" })

		local mapName = triggerArgs.name
		if RoomData[mapName] ~= nil then
			if CurrentRun.CurrentRoom.ExitsUnlocked then
				if CurrentRun.CurrentRoom.Encounter ~= nil then
					-- Hack to correct bad save state
					CurrentRun.CurrentRoom.Encounter.Completed = true
				end
				RestoreUnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
			else
				StartRoom( CurrentRun, CurrentRun.CurrentRoom )
			end
		end

	end
}

Import "DeathLoop.lua"

function ValidateIdLeaks( trace, tableToCheck )
	if tableToCheck.ObjectId ~= nil or tableToCheck.Id ~= nil then
		DebugAssert({ Condition = false, Text = "Id leak found in "..trace })
	end
	local idLeakIgnores = ToLookup({ "InspectPoints", "RunHistory", "RoomHistory", "Hero", "PostLineFunctionArgs", "AmbientMusicSource", "ChallengeSwitch", })
	for key, value in pairs( tableToCheck ) do
		if not SaveIgnores[key] and not idLeakIgnores[key] and type(value) == "table" then
			local recursiveTrace = trace.."."..key
			ValidateIdLeaks( recursiveTrace, value )
		end
	end
end

function ValidateLoops( trace, tableToCheck )
	if string.len( trace ) > 150 then
		DebugAssert({ Condition = false, Text = "Loop found in "..trace })
	end
	local extraIgnores = ToLookup({ })
	for key, value in pairs( tableToCheck ) do
		if not SaveIgnores[key] and not extraIgnores[key] and type(value) == "table" then
			local recursiveTrace = trace.."."..key
			ValidateLoops( recursiveTrace, value )
		end
	end
end

function ValidateThreadLeaks()
	local threadIgnores = ToLookup({ "MapLoad", "CombatUIHide" })
	for k, thread in pairs( _threads ) do
		if not threadIgnores[thread.tag] then
			DebugAssert({ false, Text = "thread still active: "..tostring(thread.tag) })
		end
	end
end

function DoPatches()

	TextRecord = nil

	-- Cleanup leaked globals
	hero = nil
	itemData = nil
	roomForDoorData = nil
	enemyName = nil
	tooltipData = nil
	upgradeData = nil
	healValue = nil
	hasIdentical = nil
	curseData = nil
	alternateLootId = nil
	rumbleParams = nil
	notifyName = nil
	enemyVulnerability = nil
	collisionVulnerability = nil
	blessingData = nil
	giftOffsetZ = nil
	upgradeTitlePrefix = nil
	upgradeTitleSuffix = nil
	weaponSetNames = nil
	weaponData = nil
	SkellyWeaponEquipReactionVoiceLines = nil
	FurthestRunProgress = nil
	attributeRequirements = nil
	ViewedTooltips = nil
	CombatSlow = nil
	LastStandVignette = nil
	HeroWeapons = nil
	EnemiesBiome3Champions = nil
	RunRecordData = nil
	DamageTextRecord = nil
	DialogueBackground = nil
	LeapPointsOccupied = nil
	HadesBloodstoneVignette = nil
	PersistentShoutEffectSoundId = nil
	DevotionSoundId = nil
	TheseusWrathActivationVoiceLines = nil
	GiftPointRecord = nil
	LockKeyRecord = nil
	bothBossesDead = nil
	ammoVulnerability = nil

	for key, value in pairs( GameData ) do
		_G[key] = nil
	end
	for key, value in pairs( ConstantsData ) do
		_G[key] = nil
	end
	for setName, set in pairs( EnemySets ) do
		_G[setName] = nil
	end
	for setName, set in pairs( WeaponSets ) do
		_G[setName] = nil
	end
	for setName, set in pairs( EncounterSets ) do
		_G[setName] = nil
	end

	ShowingCodexUpdateAnimation = false
	if ActiveScreens then
		if ActiveScreens.TraitTrayScreen then
			ActiveScreens.TraitTrayScreen = nil
		end
		if ActiveScreens.Codex then
			ActiveScreens.Codex = nil
		end
	end

	if GameState ~= nil then
		GameState.Flags = GameState.Flags or {}
		GameState.Flags.Overlook = false
		GameState.ReturnedRandomEligibleSourceNames = GameState.ReturnedRandomEligibleSourceNames or {}
		GameState.PlayedRandomRunIntroData = GameState.PlayedRandomRunIntroData or {}
		GameState.PlayedRandomRunOutroData = GameState.PlayedRandomRunOutroData  or {}
		GameState.HeardGhostLines = GameState.HeardGhostLines or {}
		GameState.LastUnlockedMetaUpgrades = GameState.LastUnlockedMetaUpgrades or {}
		GameState.MetaUpgradesUnlocked = GameState.MetaUpgradesUnlocked or {}
		GameState.MetaUpgradesSelected = GameState.MetaUpgradesSelected or {}
		GameState.MetaUpgradeState =  GameState.MetaUpgradeState or {}
		GameState.KeepsakeChambers = GameState.KeepsakeChambers or {}
		GameState.Resources = GameState.Resources or {}
		GameState.LifetimeResourcesGained = GameState.LifetimeResourcesGained or {}
		GameState.LifetimeResourcesSpent = GameState.LifetimeResourcesSpent or {}
		GameState.EnemyEliteAttributeKills = GameState.EnemyEliteAttributeKills or {}
		if GameState.LockKeys ~= nil then
			GameState.Resources.LockKeys = GameState.LockKeys
			GameState.LockKeys = nil
		end
		if GameState.LockKeysGained ~= nil then
			GameState.LifetimeResourcesGained.LockKeys = GameState.LockKeysGained
			GameState.LockKeysGained = nil
		end
		if GameState.GiftPoints ~= nil then
			GameState.Resources.GiftPoints = GameState.GiftPoints
			GameState.GiftPoints = nil
		end
		if GameState.MetaPoints ~= nil then
			GameState.Resources.MetaPoints = GameState.MetaPoints
			GameState.MetaPoints = nil
		end
		if GameState.ShrinePoints ~= nil then
			GameState.Resources.MetaPoints = (GameState.Resources.MetaPoints or 0) + (GameState.ShrinePoints * 5)
			GameState.ShrinePoints = nil
		end

		if (Revision == nil or Revision < 25100 ) and GameState.Flags.HardMode then
			GameState.MetaUpgrades.MetaPointCapShrineUpgrade = 0
			if GameState.MetaUpgrades.HealingReductionShrineUpgrade == nil or GameState.MetaUpgrades.HealingReductionShrineUpgrade == 0 then
				GameState.MetaUpgrades.HealingReductionShrineUpgrade = 1
			end
		end

		GameState.ShrinePointClearsComplete = GameState.ShrinePointClearsComplete or {}
		GameState.ActiveMutators = GameState.ActiveMutators or {}
		GameState.Onslaughts = GameState.Onslaughts or {}
		GameState.WeaponUnlocks = GameState.WeaponUnlocks or {}
		GameState.SeenWeaponUnlocks = GameState.SeenWeaponUnlocks or {}
		GameState.AssistUnlocks = GameState.AssistUnlocks or {}
		GameState.LastWeaponUpgradeData = GameState.LastWeaponUpgradeData or {}
		GameState.TimesClearedWeapon = GameState.TimesClearedWeapon or {}
		GameState.WeaponRecordsClearTime = GameState.WeaponRecordsClearTime or {}
		GameState.WeaponRecordsShrinePoints = GameState.WeaponRecordsShrinePoints or {}
		GameState.RecordClearedShrineThreshold = GameState.RecordClearedShrineThreshold or {}
		GameState.TraitsTaken = GameState.TraitsTaken or {}
		GameState.ClearedWithMetaUpgrades = GameState.ClearedWithMetaUpgrades or {}
		GameState.QuestsViewed = GameState.QuestsViewed or {}
		GameState.QuestStatus = GameState.QuestStatus or {}
		GameState.SpeechRecordContexts = GameState.SpeechRecordContexts or {}

		GameState.EasyModeLevel = GameState.EasyModeLevel or 0

		if GameState.SuspendedRun == nil then
			if not GameState.MetaUpgradeStagesUnlocked then
				local highestUnlockIndex = 0
				for metaUpgradeName in pairs( GameState.MetaUpgradesUnlocked ) do
					for i, rowData in pairs(MetaUpgradeOrder) do
						if Contains( rowData, metaUpgradeName ) and highestUnlockIndex < i then
							highestUnlockIndex = i
						end
					end
				end
				local expectedUnlockStage = math.ceil(( highestUnlockIndex - MetaUpgradeLockOrder.BaseUnlocked ) / MetaUpgradeLockOrder.LockedSetsCount)
					GameState.MetaUpgradeStagesUnlocked = expectedUnlockStage
			end

			for metaUpgradeName, metaUpgradeData in pairs( MetaUpgradeData ) do

				if metaUpgradeData.Starting then
					GameState.MetaUpgradesUnlocked[metaUpgradeName] = true
				end

				if not GameState.MetaUpgradesUnlocked[metaUpgradeName] or MetaUpgradeData[metaUpgradeName].Skip then
					local metaPointRefund = GetMetaUpgradeTotalInvestment( metaUpgradeData )
					if metaPointRefund > 0 then
						DebugPrint({ Text = metaUpgradeData.Name.." Refunded: "..metaPointRefund })
						GameState.Resources.MetaPoints = GameState.Resources.MetaPoints + metaPointRefund
					end
					GameState.MetaUpgrades[metaUpgradeName] = nil
				end
				local condemnedKeys = {}
				for key, value in pairs(GameState.MetaUpgrades) do
					if type(value) == "string" then
						IncrementTableValue( GameState.MetaUpgrades, value )
						table.insert( condemnedKeys, key )
					end
				end
				for i, key in pairs(condemnedKeys) do
					GameState.MetaUpgrades[key] = nil
				end

				if (GameState.MetaUpgrades[metaUpgradeName] or 0) < 0 then
					DebugPrint({ Text = metaUpgradeName.." below 0. Fixing." })
					GameState.MetaUpgrades[metaUpgradeName] = 0
				end

				if GameState.MetaUpgrades[metaUpgradeName] ~= nil and metaUpgradeData.MaxInvestment ~= nil and metaUpgradeData.Cost ~= nil and not Contains( ShrineUpgradeOrder, metaUpgradeName ) then
					-- Refund MetaUpgrades that have had their cap lowered
					local currentRank = GameState.MetaUpgradeState[metaUpgradeName] or 0
					local newCap = metaUpgradeData.MaxInvestment
					if currentRank > newCap then
						DebugPrint({ Text = metaUpgradeData.Name.." PrevRank = "..currentRank })
						DebugPrint({ Text = metaUpgradeData.Name.." NewRank = "..newCap })
						local metaPointRefund = (currentRank - newCap) * metaUpgradeData.Cost
						DebugPrint({ Text = metaUpgradeData.Name.." Refunded = "..metaPointRefund })
						GameState.Resources.MetaPoints = GameState.Resources.MetaPoints + metaPointRefund
						GameState.MetaUpgradeState[metaUpgradeName] = newCap
						if Contains(GameState.MetaUpgradesSelected, metaUpgradeName ) then
							GameState.MetaUpgrades[metaUpgradeName] = newCap
						end
					end
				end

				if metaUpgradeData.OldCostTable ~= nil and (Revision == nil or Revision < metaUpgradeData.OldRevision) and not GameState.Flags.InFlashback and CurrentRun ~= nil and CurrentRun.CurrentRoom.Name ~= "RoomOpening" then
					local currentRank = GameState.MetaUpgradeState[metaUpgradeName] or 0
					for rank, oldValue in ipairs( metaUpgradeData.OldCostTable ) do
						if rank <= currentRank then
							local newValue = metaUpgradeData.CostTable[rank] or 0
							local metaPointRefund = oldValue - newValue
							if metaPointRefund > 0 then
								DebugPrint({ Text = metaUpgradeData.Name.." Rank = "..rank })
								DebugPrint({ Text = metaUpgradeData.Name.." Refunded = "..metaPointRefund })
								GameState.Resources.MetaPoints = GameState.Resources.MetaPoints + metaPointRefund
							end
							if metaUpgradeData.CostTable[rank] and not metaUpgradeData.CostTable[rank + 1] and rank < GameState.MetaUpgradeState[metaUpgradeName] then
								GameState.MetaUpgradeState[metaUpgradeName] = rank
								if Contains(GameState.MetaUpgradesSelected, metaUpgradeName ) then
									GameState.MetaUpgrades[metaUpgradeName] = rank
								end
							end
						end
					end
				end

				--[[
				if GameState.MetaUpgrades[metaUpgradeName] ~= nil and metaUpgradeData.CostTable ~= nil then
					-- Refund MetaUpgrades that have had their cap lowered
					local currentRank = GameState.MetaUpgrades[metaUpgradeName]
					local newCap = TableLength( metaUpgradeData.CostTable )
					if GameState.MetaUpgrades[metaUpgradeName] > newCap then
						DebugPrint({ Text = metaUpgradeData.Name.." CurrentRank: "..currentRank })
						for i = currentRank - 1, newCap, -1 do
							local metaPointRefund = metaUpgradeData.CostTable[newCap]
							if metaPointRefund > 0 then
								DebugPrint({ Text = metaUpgradeData.Name.." Refunded: "..metaPointRefund })
								if Contains( ShrineUpgradeOrder, metaUpgradeName ) then
									-- Do nothing
								else
									GameState.Resources.MetaPoints = GameState.Resources.MetaPoints + metaPointRefund
								end
							end
						end
						GameState.MetaUpgrades[metaUpgradeName] = newCap
						DebugPrint({ Text = metaUpgradeData.Name.." NewRank: "..GameState.MetaUpgrades[metaUpgradeName] })
					end
				end
				]]
			end
			if IsEmpty( GameState.MetaUpgradesSelected ) then
				for k, metaUpgradeChoices  in pairs( MetaUpgradeOrder ) do
					GameState.MetaUpgradesSelected[k] = metaUpgradeChoices[1]
				end
			else
				for k, metaUpgradeName  in pairs( GameState.MetaUpgradesSelected ) do
					if not MetaUpgradeData[metaUpgradeName] and MetaUpgradeOrder[k] then
						GameState.MetaUpgradesSelected[k] = MetaUpgradeOrder[k][1]
					end
				end
			end

			if (Revision == nil or Revision <= 31053) and ( Contains( GameState.MetaUpgradesSelected, "DuoRarityBoonDropMetaUpgrade" ) or Contains( GameState.MetaUpgradesSelected, "RunProgressRewardMetaUpgrade" ) ) then
				-- Swap out DuoRarityBoonDropMetaUpgrade and in RareBoonDropMetaUpgrade
				GameState.MetaUpgradesSelected[10] = "RareBoonDropMetaUpgrade"
				GameState.MetaUpgrades.RareBoonDropMetaUpgrade = GameState.MetaUpgradeState.RareBoonDropMetaUpgrade
				GameState.MetaUpgrades.DuoRarityBoonDropMetaUpgrade = 0
				-- Swap out RunProgressRewardMetaUpgrade and in EpicBoonDropMetaUpgrade
				GameState.MetaUpgradesSelected[11] = "EpicBoonDropMetaUpgrade"
				GameState.MetaUpgrades.EpicBoonDropMetaUpgrade = GameState.MetaUpgradeState.EpicBoonDropMetaUpgrade
				GameState.MetaUpgrades.RunProgressRewardMetaUpgrade = 0
			end
			if not CurrentRun.MetaUpgradeCache then
				BuildMetaupgradeCache()
			end
		end

		GameState.WeaponsTouched = GameState.WeaponsTouched or {}
		GameState.WeaponsUnlocked = GameState.WeaponsUnlocked or {}
		if IsWeaponUpgradeUnlocked( "SpearWeapon", 4 ) then
			GameState.SeenWeaponUnlocks.SpearWeapon4 = true
		end

		GameState.Cosmetics = GameState.Cosmetics or {}
		GameState.CosmeticsViewed = GameState.CosmeticsViewed or {}
		GameState.CosmeticsAdded = GameState.CosmeticsAdded or {}
		GameState.MusicTracksViewed = GameState.MusicTracksViewed or {}
		if not GameState.Cosmetics.Cosmetic_DrapesRed and not GameState.Cosmetics.Cosmetic_DrapesGreen and not GameState.Cosmetics.Cosmetic_DrapesBlue and not GameState.Cosmetics.Cosmetic_DrapesGrey then
			AddCosmetic( "Cosmetic_DrapesRed" )
		end
		if not GameState.Cosmetics.Cosmetic_LaurelsRed and not GameState.Cosmetics.Cosmetic_LaurelsBlue and not GameState.Cosmetics.Cosmetic_LaurelsSkulls then
			AddCosmetic( "Cosmetic_LaurelsRed" )
		end
		if not GameState.Cosmetics.Cosmetic_WallWeaponBident and not GameState.Cosmetics.Cosmetic_WallWeaponSword and not GameState.Cosmetics.Cosmetic_WallWeaponAxe then
			AddCosmetic( "Cosmetic_WallWeaponBident" )
		end
		if not GameState.CosmeticsAdded.Cosmetic_SouthHallTrimBrown then
			AddCosmetic( "Cosmetic_SouthHallTrimBrown" )
		end
		if not GameState.CosmeticsAdded.Cosmetic_HouseCandles01 then
			AddCosmetic( "Cosmetic_HouseCandles01" )
		end
		if not GameState.CosmeticsAdded.Cosmetic_UISkinDefault then
			AddCosmetic( "Cosmetic_UISkinDefault" )
		end
		AddCosmetic( "/Music/MusicPlayer/MainThemeMusicPlayer" )
		AddCosmetic( "/Music/MusicPlayer/MusicExploration4MusicPlayer" )
		GameState.Cosmetics.Cosmetic_NorthHallPedestalHammer = nil
		GameState.Cosmetics.Cosmetic_NorthHallPedestalArtifact = nil
		GameState.Cosmetics.Cosmetic_NorthHallPedestalSphere = nil

		if GameState.Cosmetics.Cosmetic_NorthHallPaintingTartarus and GameState.Cosmetics.Cosmetic_NorthHallPaintingAsphodel then
			-- Mutually exclusive now
			GameState.Cosmetics.Cosmetic_NorthHallPaintingTartarus = nil
		end

		local activeCharacterPaintings = {}
		for k, characterPainting in pairs( { "Cosmetic_NorthHallPaintingHades", "Cosmetic_NorthHallPaintingZagreus", "Cosmetic_NorthHallPaintingMysteryWoman" } ) do
			if GameState.Cosmetics[characterPainting] then
				activeCharacterPaintings[characterPainting] = true
			end
		end
		while TableLength( activeCharacterPaintings ) >= 2 do
			local characterPainting = RemoveRandomKey( activeCharacterPaintings )
			GameState.Cosmetics[characterPainting] = nil
			DebugPrint({ Text = "Disabled mutually exclusive cosmetic: "..characterPainting })
		end

		local activeMiscPaintings = {}
		for k, miscPainting in pairs( { "Cosmetic_NorthHallPaintingMysteryGirl", "Cosmetic_NorthHallPaintingTots", "Cosmetic_NorthHallPaintingTheseus" } ) do
			if GameState.Cosmetics[miscPainting] then
				activeMiscPaintings[miscPainting] = true
			end
		end
		while TableLength( activeMiscPaintings ) >= 2 do
			local miscPainting = RemoveRandomKey( activeMiscPaintings )
			GameState.Cosmetics[miscPainting] = nil
			DebugPrint({ Text = "Disabled mutually exclusive cosmetic: "..miscPainting })
		end

		if TextLinesRecord.OrpheusFirstMeeting then
			AddCosmetic( "OrpheusUnlockItem" )
		end

		if TextLinesRecord.OrpheusWithEurydice01 then
			GameState.Flags.OrpheusReunionInProgress = false
		end

		if TextLinesRecord.AchillesAboutHadesBedroom01 ~= nil and TextLinesRecord.Inspect_DeathAreaBedroomHades_Portrait_01 == nil then
			thread(RestoreActivateHadesBedroomDoor)
		end


		for cosmeticName, v in pairs( GameState.Cosmetics ) do
			GameState.CosmeticsAdded[cosmeticName] = true
		end

		if (Revision == nil or Revision < 30100 ) and GameState.CosmeticsAdded.Cosmetic_HousePillarsA  then
			DebugPrint({ Text = "Refunding Cosmetic_HousePillarsA" })
			AddResource( "Gems", 800 )
		end
		if (Revision == nil or Revision < 32686 ) and GameState.CosmeticsAdded.NyxQuestItem  then
			DebugPrint({ Text = "Refunding NyxQuestItem" })
			AddResource( "MetaPoints", 5746 )
		end

		GameState.ScreensViewed = GameState.ScreensViewed or {}

		GameState.ItemInteractions = GameState.ItemInteractions or {}
		GameState.EnemySpawns = GameState.EnemySpawns or {}
		GameState.EnemyDamage = GameState.EnemyDamage or {}

		if TableLength(GameState.WeaponsUnlocked) > 1 then
			GameState.CompletedObjectiveSets["UnlockWeapon"] = true
		end

		GameState.ObjectivesCompleted = GameState.ObjectivesCompleted or {}
		GameState.ObjectivesFailed = GameState.ObjectivesFailed or {}
		GameState.LastObjectiveCompletedRun = GameState.LastObjectiveCompletedRun or {}
		GameState.LastObjectiveFailedRun = GameState.LastObjectiveFailedRun or {}

		if GameState.CaughtFish and not GameState.TotalCaughtFish then
			GameState.TotalCaughtFish = ShallowCopyTable( GameState.CaughtFish )
		end
		GameState.TotalCaughtFish = GameState.TotalCaughtFish or {}

		if not IsEmpty( GameState.RunHistory ) then
			local prevRun = GameState.RunHistory[#GameState.RunHistory]
			if prevRun ~= nil then
				UpdateRunHistoryCache( prevRun )
			end
		end

		if GameState.EncountersOccuredCache ~= nil then
			GameState.EncountersOccurredCache = GameState.EncountersOccuredCache
			GameState.EncountersOccuredCache = nil
		end

		GameState.EncountersOccurredCache = GameState.EncountersOccurredCache or {}
		GameState.EncountersCompletedCache = GameState.EncountersCompletedCache or {}
		GameState.RoomCountCache = GameState.RoomCountCache or {}

		for cosmeticName, data in pairs( GameState.Cosmetics ) do
			if type(data) ~= "string" then
				GameState.Cosmetics[cosmeticName] = UIData.Constants.VISIBLE
			end
		end

		GameState.CompletedRunsCache = GetCompletedRuns()
		GameState.AccumulatedMetaPointsCache = GameState.LifetimeResourcesGained.MetaPoints or 0

		for npcName in pairs( GiftData ) do
			if GameState.Gift and not GameState.Gift[npcName] then
				GameState.Gift[npcName] = {}
				GameState.Gift[npcName].Value = GiftData[npcName].Value
			end
		end

		-- gifting overrides
		if GameState.Gift.TrainingMelee ~= nil and GameState.Gift.NPC_Skelly_01 == nil then
			GameState.Gift.NPC_Skelly_01 = DeepCopyTable( GameState.Gift.TrainingMelee )
		elseif GameState.Gift.TrainingMelee ~= nil and GameState.Gift.NPC_Skelly_01 ~= nil and GameState.Gift.TrainingMelee.Value > GameState.Gift.NPC_Skelly_01.Value then
			GameState.Gift.NPC_Skelly_01.Value = GameState.Gift.TrainingMelee.Value
		end

		if GameState.Gift.NPC_Cerberus_01 ~= nil and GameState.Gift.NPC_Cerberus_01.Value then
			local targetGiftValue = GameState.Gift.NPC_Cerberus_01.Value

			if GameState.Gift.NPC_Cerberus_01.Value > 0 and not TextLinesRecord.CerberusGift01 then
				GameState.Gift.NPC_Cerberus_01.Value = 0
			elseif GameState.Gift.NPC_Cerberus_01.Value > 1 and not TextLinesRecord.CerberusGift02 then
				GameState.Gift.NPC_Cerberus_01.Value = 1
			elseif GameState.Gift.NPC_Cerberus_01.Value > 2 and not TextLinesRecord.CerberusGift03 then
				GameState.Gift.NPC_Cerberus_01.Value = 2
			elseif GameState.Gift.NPC_Cerberus_01.Value > 3 and not TextLinesRecord.CerberusGift04 then
				GameState.Gift.NPC_Cerberus_01.Value = 3
			elseif GameState.Gift.NPC_Cerberus_01.Value > 4 and not TextLinesRecord.CerberusGift05 then
				GameState.Gift.NPC_Cerberus_01.Value = 4
			end
		end
		
		if GameState.Gift.ArtemisUpgrade ~= nil and GameState.Gift.ArtemisUpgrade.Value then
			if GameState.Gift.ArtemisUpgrade.Value > 4 and not TextLinesRecord.ArtemisGift03 then
				GameState.Gift.ArtemisUpgrade.Value = 3
			end
		end

		if GameState.Gift.NPC_Achilles_01 ~= nil and GameState.Gift.NPC_Achilles_01.Value then
			local targetGiftValue = GameState.Gift.NPC_Achilles_01.Value

			if targetGiftValue >= 4 and not TextLinesRecord.AchillesGift04_A then
				GameState.Gift.NPC_Achilles_01.Value = 3
			elseif targetGiftValue >= 5 and not TextLinesRecord.AchillesGift05_A and not TextLinesRecord.AchillesGift05_B then
				GameState.Gift.NPC_Achilles_01.Value = 4
			elseif targetGiftValue >= 6 and not TextLinesRecord.AchillesGift06_A then
				GameState.Gift.NPC_Achilles_01.Value = 5
			elseif targetGiftValue >= 7 and not TextLinesRecord.AchillesGift07_A then
				GameState.Gift.NPC_Achilles_01.Value = 6
			end

			if targetGiftValue < 4 and TextLinesRecord.AchillesGift04_A then
				GameState.Gift.NPC_Achilles_01.Value = 4
			end
			if targetGiftValue < 5 and ( TextLinesRecord.AchillesGift05_A or TextLinesRecord.AchillesGift05_B ) then
				GameState.Gift.NPC_Achilles_01.Value = 5
			end
			if targetGiftValue < 6 and TextLinesRecord.AchillesGift06_A then
				GameState.Gift.NPC_Achilles_01.Value = 6
			end
			if targetGiftValue < 7 and TextLinesRecord.AchillesGift07_A then
				GameState.Gift.NPC_Achilles_01.Value = 7
			end
			if targetGiftValue < 8 and TextLinesRecord.AchillesGift08_A then
				GameState.Gift.NPC_Achilles_01.Value = 8
			end
			if targetGiftValue < 9 and TextLinesRecord.AchillesGift09_A then
				GameState.Gift.NPC_Achilles_01.Value = 9
			end
		end
		if GameState.Gift.NPC_Sisyphus_01 ~= nil and GameState.Gift.NPC_Sisyphus_01.Value > 6 and not TextLinesRecord.SisyphusGift07_A then
			GameState.Gift.NPC_Sisyphus_01.Value = 6
		end
		if GameState.Gift.NPC_Thanatos_01 ~= nil  and GameState.Gift.NPC_Thanatos_01.Value then
			if GameState.Gift.NPC_Thanatos_01.Value > 5 and not TextLinesRecord.ThanatosGift06 then
				GameState.Gift.NPC_Thanatos_01.Value = 5
			end
			if GameState.Gift.NPC_Thanatos_01.Value > 6 and not TextLinesRecord.ThanatosGift07_A then
				GameState.Gift.NPC_Thanatos_01.Value = 6
			end
			if GameState.Gift.NPC_Thanatos_01.Value > 9 and not TextLinesRecord.ThanatosGift10 then
				GameState.Gift.NPC_Thanatos_01.Value = 9
			end
		end
		if GameState.Gift.NPC_Patroclus_01 ~= nil and GameState.Gift.NPC_Patroclus_01.Value > 6 and not TextLinesRecord.PatroclusGift07_A then
			GameState.Gift.NPC_Patroclus_01.Value = 6
		end
		if GameState.Gift.NPC_Dusa_01 ~= nil then
			local decrementGiftMeter = false
			if GameState.Gift.NPC_Dusa_01.Value == 6 and not TextLinesRecord.DusaGift06 then
				decrementGiftMeter = true
			elseif GameState.Gift.NPC_Dusa_01.Value == 7 and not TextLinesRecord.DusaGift07 then
				decrementGiftMeter = true
			elseif GameState.Gift.NPC_Dusa_01.Value == 8 and not TextLinesRecord.DusaGift08 then
				decrementGiftMeter = true
			elseif GameState.Gift.NPC_Dusa_01.Value == 9 and not TextLinesRecord.DusaGift09 then
				decrementGiftMeter = true
			elseif GameState.Gift.NPC_Dusa_01.Value == 10 and not TextLinesRecord.DusaGift10 then
				decrementGiftMeter = true
			end

			if decrementGiftMeter then
				GameState.Gift.NPC_Dusa_01.Value = GameState.Gift.NPC_Dusa_01.Value - 1
			end
		end

		if GameState.Gift.NPC_Eurydice_01 ~= nil then
			if GameState.Gift.NPC_Eurydice_01.Value > 3 and not TextLinesRecord.EurydiceGift04 then
				GameState.Gift.NPC_Eurydice_01.Value = 3
			elseif GameState.Gift.NPC_Eurydice_01.Value == 4 and not TextLinesRecord.EurydiceGift05 then
				GameState.Gift.NPC_Eurydice_01.Value = 4
			end
		end

		if GameState.Gift.HermesUpgrade ~= nil then
			if GameState.Gift.HermesUpgrade.Value > 5 and not ( TextLinesRecord.HermesGift06 or TextLinesRecord.HermesGift06B ) then
				GameState.Gift.HermesUpgrade.Value = 5
			end
			if GameState.Gift.HermesUpgrade.Value > 7 and not ( TextLinesRecord.HermesGift08 or TextLinesRecord.HermesGift08B ) then
				GameState.Gift.HermesUpgrade.Value = 7
			end
		end
		if GameState.Gift.AphroditeUpgrade ~= nil then
			if GameState.Gift.AphroditeUpgrade.Value > 5 and not TextLinesRecord.AphroditeGift06 then
				GameState.Gift.AphroditeUpgrade.Value = 5
			end
		end
	end

	if CodexStatus ~= nil then
		if CodexStatus.OtherDenizens ~= nil then
			local patchCodexNames =
			{
				TrainingMelee = "NPC_Skelly_01",
				NPC_MaleGhost_01 = "NPC_Achilles_01",
				NPC_FemaleGhost_01 = "NPC_Nyx_01",
				NPC_Musician_01 = "NPC_Orpheus_01",
			}
			for oldName, newName in pairs(patchCodexNames) do
				if CodexStatus.OtherDenizens[oldName] and not CodexStatus.OtherDenizens[newName] then
					CodexStatus.OtherDenizens[newName] = DeepCopyTable( CodexStatus.OtherDenizens[oldName] )
				end
				if GameState.Gift[oldName] and not GameState.Gift[newName] then
					GameState.Gift[newName] = DeepCopyTable( GameState.Gift[oldName] )
				end
			end
		end
		if CodexStatus.ChthonicGods ~= nil then
			local patchCodexNames =
			{
				NPC_BoatMan_01 = "NPC_Charon_01",
				NPC_ChildGhost_01 = "NPC_Hypnos_01",
				NPC_FemaleGhost_01 = "NPC_Nyx_01",
			}
			for oldName, newName in pairs(patchCodexNames) do
				if CodexStatus.ChthonicGods[oldName] and not CodexStatus.ChthonicGods[newName] then
					CodexStatus.ChthonicGods[newName] = DeepCopyTable( CodexStatus.ChthonicGods[oldName] )
				end
				if GameState.Gift[oldName] and not GameState.Gift[newName] then
					GameState.Gift[newName] = DeepCopyTable( GameState.Gift[oldName] )
				end
			end
		end
		if Codex[CodexStatus.SelectedChapterName] == nil then
			CodexStatus.SelectedChapterName = GetFirstKey(Codex)
		end
	end

	if CurrentRun ~= nil then

		UpdateRunHistoryCache( CurrentRun )

		CurrentRun.AnimationState = CurrentRun.AnimationState or {}
		CurrentRun.EventState = CurrentRun.EventState or {}
		CurrentRun.NPCInteractions = CurrentRun.NPCInteractions or {}
		CurrentRun.ActivationRecord = CurrentRun.ActivationRecord or {}
		CurrentRun.TriggerRecord = CurrentRun.TriggerRecord or {}
		CurrentRun.MoneySpent = CurrentRun.MoneySpent or 0
		CurrentRun.RoomCreations = CurrentRun.RoomCreations or {}
		CurrentRun.InvulnerableFlags = CurrentRun.InvulnerableFlags or {}
		CurrentRun.PhasingFlags = CurrentRun.PhasingFlags or {}
		CurrentRun.HealthRecord = CurrentRun.HealthRecord or {}
		CurrentRun.ActualHealthRecord = CurrentRun.ActualHealthRecord or {}
		CurrentRun.DamageRecord = CurrentRun.DamageRecord or {}
		CurrentRun.ConsumableRecord = CurrentRun.ConsumableRecord or {}
		CurrentRun.WeaponsFiredRecord = CurrentRun.WeaponsFiredRecord or {}
		CurrentRun.GameplayTime = CurrentRun.GameplayTime or 99999
		CurrentRun.BiomeTime = CurrentRun.BiomeTime or 99999

		CurrentRun.BlockTimerFlags = CurrentRun.BlockTimerFlags or {}
		if CurrentRun.BlockTimerFlags.Codex then
			DebugPrint({Text = " Removing Erroneous Codex Timer Block"})
			CurrentRun.BlockTimerFlags.Codex = nil
		end
		CurrentRun.NumRerolls = CurrentRun.NumRerolls or 0
		CurrentRun.ThanatosSpawns = CurrentRun.ThanatosSpawns or 0
		CurrentRun.ClosedDoors = CurrentRun.ClosedDoors or {}
		CurrentRun.SupportAINames = CurrentRun.SupportAINames or {}
		CurrentRun.BannedEliteAttributes = CurrentRun.BannedEliteAttributes or {}

		if CurrentRun.CompletedStyxWings == nil then
			CurrentRun.CompletedStyxWings = 0

			for i, roomData in pairs( CurrentRun.RoomHistory ) do
				if roomData.LinkedRoom == "D_Hub" and roomData.Name ~= "D_Intro" then
					CurrentRun.CompletedStyxWings = CurrentRun.CompletedStyxWings + 1
				end
			end
		end

		if CurrentRun.WingDepth ~= nil and CurrentRun.WingDepth >= 3 and CurrentRun.BiomeRoomCountCache["D_Combat02"] ~= nil and CurrentRun.BiomeRoomCountCache["D_Combat03"] ~= nil and CurrentRun.BiomeRoomCountCache["D_Combat06"] ~= nil then
			DebugPrint({ Text="Manually forcing a MiniBoss instead of Combat room" })
			CurrentRun.CurrentRoom.ForceWingEndMiniBoss = true
		end

		for i, roomData in pairs( CurrentRun.RoomHistory ) do
			if roomData.Store and roomData.Store.SpawnedStoreItems then
				for s, spawnedItemData in pairs (roomData.Store.SpawnedStoreItems) do
					CurrentRun.RoomHistory[i].Store.SpawnedStoreItems[s] =  { ObjectId = spawnedItemData.ObjectId, Cost = spawnedItemData.Cost }
				end
			end
		end
		if CurrentRun.CurrentRoom ~= nil then
			CurrentRun.CurrentRoom.EliteAttributes = CurrentRun.CurrentRoom.EliteAttributes or {}
			CurrentRun.CurrentRoom.VoiceLinesPlayed = CurrentRun.CurrentRoom.VoiceLinesPlayed or {}
			CurrentRun.CurrentRoom.TextLinesRecord = CurrentRun.CurrentRoom.TextLinesRecord or {}
			if CurrentRun.CurrentRoom.ChallengeSwitch ~= nil and CurrentRun.CurrentRoom.ChallengeSwitch.RewardType == nil then
				CurrentRun.CurrentRoom.ChallengeSwitch = DeepCopyTable( ObstacleData.ChallengeSwitch )
			end
			if CurrentRun.CurrentRoom.SellOptions then
				local hasIndex = false
				for i, data in pairs( CurrentRun.CurrentRoom.SellOptions ) do
					if data.Index then
						hasIndex = true
					end
					if data.Value == 0 and data.Index and CurrentRun.Hero.Traits[data.Index] then
						data.Value = GetTraitValue(CurrentRun.Hero.Traits[data.Index])
					end
				end
				if hasIndex then
					CurrentRun.CurrentRoom.SellOptions = nil
				end
			end
			if CurrentRun.CurrentRoom.Store ~= nil and CurrentRun.CurrentRoom.Store.StoreOptions ~= nil then
				local giftDropIndex = nil
				for i, storeOption in pairs( CurrentRun.CurrentRoom.Store.StoreOptions ) do
					if storeOption.Type == "Cosmetic" then
						storeOption.Name = "HealDropRange"
						storeOption.Type = "Consumable"
					elseif not storeOption.Name then
						storeOption.Name = "HealDropRange"
						storeOption.Type = "Consumable"
					elseif storeOption.Name == "StoreGiftDrop" then
						giftDropIndex = i
					end
				end
				if giftDropIndex ~= nil then
					CurrentRun.CurrentRoom.Store.StoreOptions[giftDropIndex] = GetRampedConsumableData( ConsumableData.GiftDrop )
					CurrentRun.CurrentRoom.Store.StoreOptions[giftDropIndex].Type = "Consumable"
				end
			end

			DebugAssert({ Condition = RoomData[CurrentRun.CurrentRoom.Name] ~= nil, Text = "Missing Room: "..tostring(CurrentRun.CurrentRoom.Name) })

			CurrentRun.CurrentRoom.ShrineMetaUpgradeName = RoomData[CurrentRun.CurrentRoom.Name].ShrineMetaUpgradeName
			CurrentRun.CurrentRoom.SpawnRewardOnId = RoomData[CurrentRun.CurrentRoom.Name].SpawnRewardOnId
			CurrentRun.CurrentRoom.DisableRewardMagnetisim = RoomData[CurrentRun.CurrentRoom.Name].DisableRewardMagnetisim
			CurrentRun.CurrentRoom.HideEncounterText = RoomData[CurrentRun.CurrentRoom.Name].HideEncounterText
			CurrentRun.CurrentRoom.Binks = RoomData[CurrentRun.CurrentRoom.Name].Binks
			CurrentRun.CurrentRoom.FadeOutAnimation = RoomData[CurrentRun.CurrentRoom.Name].FadeOutAnimation

			CurrentRun.CurrentRoom.UnthreadedEvents = DeepCopyTable(RoomData[CurrentRun.CurrentRoom.Name].UnthreadedEvents)
			CurrentRun.CurrentRoom.ObstacleData = DeepCopyTable(RoomData[CurrentRun.CurrentRoom.Name].ObstacleData)

			if CurrentRun.CurrentRoom.Name ~= nil and RoomData[CurrentRun.CurrentRoom.Name] ~= nil then
				CurrentRun.CurrentRoom.StackNumOverride = CurrentRun.CurrentRoom.StackNumOverride or RoomData[CurrentRun.CurrentRoom.Name].StackNumOverride
			end

			if CurrentRun.CurrentRoom.Name == "A_Boss03" then
				CurrentRun.CurrentRoom.RestorePresentationFunction = RoomData.A_Boss03.RestorePresentationFunction
			end

			if CurrentRun.CurrentRoom.Name == "B_Boss01" then
				CurrentRun.CurrentRoom.LinkedRoom = RoomData.B_Boss01.LinkedRoom
				CurrentRun.CurrentRoom.ExitFunctionName = RoomData.BaseAsphodel.ExitFunctionName
				CurrentRun.CurrentRoom.SkipLoadNextMap = RoomData.BaseAsphodel.SkipLoadNextMap
				CurrentRun.CurrentRoom.HydraStartingPosition = RoomData.B_Boss01.HydraStartingPosition
			end

			if CurrentRun.CurrentRoom.Name == "B_Boss02" then
				CurrentRun.CurrentRoom.HydraStartingPosition = RoomData.B_Boss02.HydraStartingPosition
			end

			if CurrentRun.CurrentRoom.Name == "C_Boss01" then
				CurrentRun.CurrentRoom.ShowRunClearScreen = RoomData.C_Boss01.ShowRunClearScreen
				CurrentRun.CurrentRoom.LinkedRoom = RoomData.C_Boss01.LinkedRoom
				CurrentRun.CurrentRoom.ExitFunctionName = RoomData.BaseElysium.ExitFunctionName
				CurrentRun.CurrentRoom.SkipLoadNextMap = false
				CurrentRun.Cleared = false
				RemoveTimerBlock( CurrentRun, "TheseusMinotaurKillPresentation" )
			end

			if CurrentRun.CurrentRoom.Name == "D_Boss01" then
				CurrentRun.CurrentRoom.LinkedRoom = RoomData.D_Boss01.LinkedRoom
				CurrentRun.CurrentRoom.ExitFunctionName = RoomData.D_Boss01.ExitFunctionName
				CurrentRun.CurrentRoom.SkipLoadNextMap = RoomData.D_Boss01.SkipLoadNextMap
				CurrentRun.CurrentRoom.NextRoomSet = RoomData.D_Boss01.NextRoomSet
				CurrentRun.CurrentRoom.FishBiome = RoomData.D_Boss01.FishBiome
				CurrentRun.CurrentRoom.SwapAnimations = RoomData.D_Boss01.SwapAnimations
				CurrentRun.CurrentRoom.ZoomFraction = RoomData.D_Boss01.ZoomFraction
			end

			if CurrentRun.CurrentRoom.Name == "A_MiniBoss02" then
				CurrentRun.CurrentRoom.SpawnOnIds = RoomData.A_MiniBoss02.SpawnOnIds
			end

			if CurrentRun.CurrentRoom.Name == "C_MiniBoss01" then
				if CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.UnthreadedEvents ~= nil and CurrentRun.CurrentRoom.Encounter.UnthreadedEvents[3].FunctionName == "WaitForMinotaurEarlyExit" then
					CurrentRun.CurrentRoom.Encounter = SetupEncounter( EncounterData.MiniBossMinotaur )
				end
			end

			if CurrentRun.CurrentRoom.Name == "C_MiniBoss02" and CurrentRun.CurrentRoom.Encounter.Name ~= "MiniBossNakedSpawners" then
				CurrentRun.CurrentRoom.Encounter = SetupEncounter( EncounterData.MiniBossNakedSpawners )
			end

			if CurrentRun.CurrentRoom.Encounter ~= nil and EncounterData[CurrentRun.CurrentRoom.Encounter.Name] ~= nil then
				CurrentRun.CurrentRoom.Encounter.RequiredKillFunctionName = CurrentRun.CurrentRoom.Encounter.RequiredKillFunctionName or EncounterData[CurrentRun.CurrentRoom.Encounter.Name].RequiredKillFunctionName
			end

			if CurrentRun.CurrentRoom.Name == "D_Reprieve01" then
				CurrentRun.CurrentRoom.StartUnthreadedEvents = DeepCopyTable(RoomData.D_Reprieve01.StartUnthreadedEvents)
			end

			if CurrentRun.CurrentRoom.Name == "D_Hub" then
				CurrentRun.CurrentRoom.IntroSequenceDuration = RoomData[CurrentRun.CurrentRoom.Name].IntroSequenceDuration
				CurrentRun.CurrentRoom.BlockCameraReattach = RoomData[CurrentRun.CurrentRoom.Name].BlockCameraReattach
				CurrentRun.CurrentRoom.EntranceFunctionName = RoomData[CurrentRun.CurrentRoom.Name].EntranceFunctionName
			end

			if CurrentRun.CurrentRoom.Name == "E_Story01" then
				CurrentRun.CurrentRoom.ExitFunctionName = RoomData.E_Story01.ExitFunctionName
				CurrentRun.CurrentRoom.RunOverrides = RoomData.E_Story01.RunOverrides
			end

		end

		if CurrentRun.RewardStores == nil then
			InitializeRewardStores( CurrentRun )
		else
			for storeName, storeData in pairs( RewardStoreData ) do
				if CurrentRun.RewardStores[storeName] == nil then
					CurrentRun.RewardStores[storeName] = DeepCopyTable( storeData )
				end
			end
			if CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.RoomSetName == "Styx" and CurrentRun.RewardStores.RunProgress ~= nil then
				for k, reward in pairs( CurrentRun.RewardStores.RunProgress ) do
					if reward.Name == "Devotion" then
						CurrentRun.RewardStores.RunProgress[k] = nil
						DebugPrint({ Text = "Removed bad reward" })
					end
				end
			end
		end
		if CurrentRun.Hero ~= nil then

			CurrentRun.Hero.OnTouchdown = nil
			CurrentRun.Hero.CanBeStyxPoisoned = true
			CurrentRun.Hero.CanStoreAmmo = true
			CurrentRun.Hero.PersistentInvulnerableFlags = CurrentRun.Hero.PersistentInvulnerableFlags or {}
			if not CurrentRun.Hero.PersistentInvulnerableFlags.AutoPlay then
				CurrentRun.Hero.PersistentInvulnerableFlags.AutoPlay = nil
			end

			CurrentRun.Hero.DisableCombatControlsKeys = CurrentRun.Hero.DisableCombatControlsKeys or {}
			CurrentRun.Hero.InvulnerableFlags = CurrentRun.Hero.InvulnerableFlags or {}
			CurrentRun.Hero.LastStands = CurrentRun.Hero.LastStands or {}
			CurrentRun.Hero.StoredAmmo = {}
			CurrentRun.Hero.MaxLastStands = CurrentRun.Hero.MaxLastStands or TableLength( CurrentRun.Hero.LastStands )
			CurrentRun.Hero.MaxHealth = CurrentRun.Hero.MaxHealth or HeroData.DefaultHero.MaxHealth
			CurrentRun.Hero.Health = CurrentRun.Hero.Health or CurrentRun.Hero.MaxHealth
			CurrentRun.Hero.Health = math.ceil(CurrentRun.Hero.Health)
			CurrentRun.Hero.SuperActive = false
			CurrentRun.Hero.EnemyMoneyDropBaseValue = CurrentRun.Hero.EnemyMoneyDropBaseValue or 1.0
			CurrentRun.Hero.AnimOffsetZ = CurrentRun.Hero.AnimOffsetZ or HeroData.DefaultHero.AnimOffsetZ
			CurrentRun.Hero.ShrinePointMetaPointBonusMultiplier = CurrentRun.Hero.ShrinePointMetaPointBonusMultiplier or HeroData.DefaultHero.ShrinePointMetaPointBonusMultiplier
			CurrentRun.Hero.BoonData.ReplaceChance = CurrentRun.Hero.BoonData.ReplaceChance or HeroData.DefaultHero.BoonData.ReplaceChance
			CurrentRun.Hero.BoonData.GameStateRequirements = CurrentRun.Hero.BoonData.GameStateRequirements or ShallowCopyTable(HeroData.DefaultHero.BoonData.GameStateRequirements)

			CurrentRun.Hero.DamagedAnimation = CurrentRun.Hero.DamagedAnimation or HeroData.DefaultHero.DamagedAnimation
			CurrentRun.Hero.DamagedFxStyles = CurrentRun.Hero.DamagedFxStyles or HeroData.DefaultHero.DamagedFxStyles
			CurrentRun.Hero.InvulnerableHitFx = CurrentRun.Hero.InvulnerableHitFx or HeroData.DefaultHero.InvulnerableHitFx
			CurrentRun.Hero.ComboThreshold = CurrentRun.Hero.ComboThreshold or HeroData.DefaultHero.ComboThreshold
			CurrentRun.Hero.PerfectDashHitDisableDuration = CurrentRun.Hero.PerfectDashHitDisableDuration or HeroData.DefaultHero.PerfectDashHitDisableDuration

			CurrentRun.Hero.GuaranteedCrit = {}
			if CurrentRun.Hero.GuaranteedCritWeapons == nil then
				CurrentRun.Hero.GuaranteedCritWeapons = {}
			end

			CurrentRun.Hero.Binks = ShallowCopyTable(HeroData.DefaultHero.Binks)

			if CurrentRun.Hero.WeaponBinks == nil then
				CurrentRun.Hero.WeaponBinks = ShallowCopyTable(HeroData.DefaultHero.WeaponBinks)
			end			
			if not Contains(CurrentRun.Hero.WeaponBinks, "ZagreusWrath_Bink") then
				table.insert(CurrentRun.Hero.WeaponBinks, "ZagreusWrath_Bink")
			end

			if CurrentRun.Hero.SuperTempHealthGain ~= nil then
				CurrentRun.Hero.SuperTempHealthGain = nil
			end

			if GameState.LastAwardTrait == "RetainMoneyOnDeathTrait" then
				GameState.LastAwardTrait = "BonusMoneyTrait"
			end

			for weaponName in pairs( CurrentRun.Hero.Weapons ) do
				if WeaponData[weaponName] ~= nil and WeaponData[weaponName].SecondaryWeapon and not CurrentRun.Hero.Weapons[WeaponData[weaponName].SecondaryWeapon] then
					CurrentRun.Hero.Weapons[WeaponData[weaponName].SecondaryWeapon] = true
				end
			end
			CurrentRun.Hero.Weapons.ShoutWeapon = nil

			CurrentRun.Hero.DefaultWeapon = CurrentRun.Hero.DefaultWeapon or HeroData.DefaultHero.DefaultWeapon
			CurrentRun.Hero.LeaveRoomAmmoMangetismSpeed = CurrentRun.Hero.LeaveRoomAmmoMangetismSpeed or HeroData.DefaultHero.LeaveRoomAmmoMangetismSpeed
			CurrentRun.Hero.DashManeuverTimeThreshold = CurrentRun.Hero.DashManeuverTimeThreshold or HeroData.DefaultHero.DashManeuverTimeThreshold
			CurrentRun.Hero.FinalHitSlowParameters = CurrentRun.Hero.FinalHitSlowParameters or HeroData.DefaultHero.FinalHitSlowParameters
			CurrentRun.Hero.ShoutSlowParameters = CurrentRun.Hero.ShoutSlowParameters or HeroData.DefaultHero.ShoutSlowParameters
			CurrentRun.Hero.InvulnerableFrameMinDamage = CurrentRun.Hero.InvulnerableFrameMinDamage or HeroData.DefaultHero.InvulnerableFrameMinDamage

			if CurrentRun.Hero.Super == nil then
				CurrentRun.Hero.Super = ShallowCopyTable(HeroData.DefaultHero.Super)
			end

			if CurrentRun.Hero.RallyHealth == nil then
				CurrentRun.Hero.RallyHealth = ShallowCopyTable(HeroData.DefaultHero.RallyHealth)
			else
				if CurrentRun.Hero.RallyHealth.RallyDecayRateSeconds == nil then
					CurrentRun.Hero.RallyHealth.RallyDecayRateSeconds = HeroData.DefaultHero.RallyHealth.RallyDecayRateSeconds
				end
				if CurrentRun.Hero.RallyHealth.RallyDecayHold == nil then
					CurrentRun.Hero.RallyHealth.RallyDecayHold = HeroData.DefaultHero.RallyHealth.RallyDecayHold
				end
				if CurrentRun.Hero.RallyHealth.State == nil then
					CurrentRun.Hero.RallyHealth.State = HeroData.DefaultHero.RallyHealth.State
				end
				if CurrentRun.Hero.RallyHealth.MaxRallyHealthPerHit == nil then
					CurrentRun.Hero.RallyHealth.MaxRallyHealthPerHit = HeroData.DefaultHero.RallyHealth.MaxRallyHealthPerHit
				end
			end
			CurrentRun.Hero.HandlingDeath = false

			if CurrentRun.Hero.IsDead and CurrentRun.CurrentRoom and RoomSetData.Secrets[CurrentRun.CurrentRoom.Name] and CurrentDeathAreaRoom == nil then
				CurrentRun.Hero.IsDead = false
			end
			local mapName = GetMapName({ })
			if mapName == "DeathArea" then
				CurrentRun.Hero.IsDead = true
			end

			if CurrentRun.Hero.StackData == nil then
				CurrentRun.Hero.StackData = ShallowCopyTable(HeroData.DefaultHero.StackData)
			else
				CurrentRun.Hero.StackData.AllowRarityOverride  = HeroData.DefaultHero.StackData.AllowRarityOverride
			end
			if CurrentRun.Hero.HermesData == nil then
				CurrentRun.Hero.HermesData = ShallowCopyTable(HeroData.DefaultHero.HermesData)
			end
			if CurrentRun.Hero.IsDead and CurrentRun.ActiveBiomeTimer then
				CurrentRun.ActiveBiomeTimer = false
			end
			if CurrentRun.Hero.OutgoingDamageModifiers then
				local condemnedIds = {}
				for i, modifierData in pairs(CurrentRun.Hero.OutgoingDamageModifiers) do
					if modifierData.ValidWeapons and not modifierData.ValidWeaponsLookup then
						modifierData.ValidWeaponsLookup = ToLookup( modifierData.ValidWeapons )
					end
					if modifierData.Temporary then
						table.insert(condemnedIds, i)
					end
				end
				if not IsEmpty(condemnedIds) then
				
					for i, index in pairs(condemnedIds) do
						CurrentRun.Hero.OutgoingDamageModifiers[index] = nil
					end
					CurrentRun.Hero.OutgoingDamageModifiers = CollapseTable(CurrentRun.Hero.OutgoingDamageModifiers)
				end
			end
			if CurrentRun.Hero.IncomingDamageModifiers then
				local condemnedIds = {}
				for i, modifierData in pairs(CurrentRun.Hero.IncomingDamageModifiers) do
					if modifierData.ValidWeapons and not modifierData.ValidWeaponsLookup then
						modifierData.ValidWeaponsLookup = ToLookup( modifierData.ValidWeapons )
					end
					if modifierData.Temporary then
						table.insert(condemnedIds, i)
					end
				end
				if not IsEmpty(condemnedIds) then
					for i, index in pairs(condemnedIds) do
						CurrentRun.Hero.IncomingDamageModifiers[index] = nil
					end
					CurrentRun.Hero.IncomingDamageModifiers = CollapseTable(CurrentRun.Hero.IncomingDamageModifiers)
				end
			end

			if CurrentRun.Hero.RecentTraits ~= nil then
				if type(CurrentRun.Hero.RecentTraits[1]) ~= "table" then
					CurrentRun.Hero.RecentTraits = {}
				end
				if IsEmpty(CurrentRun.Hero.RecentTraits) or not CurrentRun.Hero.RecentTraits[1].Id then
					for i, traitData in pairs( CurrentRun.Hero.Traits ) do
						if IsPrioritizedDisplayTrait( traitData ) then
							-- force no overlaps with any existing traits
							traitData.Id = -1 * i
							PriorityTrayTraitAdd( traitData, { DeferSort = true })
						end
					end
				end
			else
				CurrentRun.Hero.RecentTraits = {}
			end

			local traitsToAdd = {}
			local traitsToRemove = {}
			for i, trait in pairs(CurrentRun.Hero.Traits) do
				ExtractValues( CurrentRun.Hero, trait, trait )
				trait.AnchorId = nil
				trait.AdditionalDataAnchorId = nil
				trait.AdvancedTooltipFrame = nil
				trait.AdvancedTooltipIcon = nil
				trait.Id = trait.Id or GetTraitUniqueId()
				local addTraitToUpdate = function ( trait )
					if trait.OnExpire then
						trait.OnExpire = nil
						IncrementTableValue( traitsToRemove, trait.Name )
					else
						IncrementTableValue( traitsToAdd, trait.Name )
					end

				end

				if not TraitData[trait.Name] then
					IncrementTableValue(traitsToRemove, trait.Name)
				elseif TableLength(trait.PropertyChanges) ~= TableLength(TraitData[trait.Name].PropertyChanges) or
				   TableLength(trait.EnemyPropertyChanges) ~= TableLength(TraitData[trait.Name].EnemyPropertyChanges) or
				   TableLength(trait.AddShout) ~= TableLength(TraitData[trait.Name].AddShout) or
				   TableLength( trait.LoadBinks ) ~= TableLength( TraitData[trait.Name].LoadBinks ) then
					addTraitToUpdate( trait )
				elseif trait.Slot == "Shout" and not trait.TooltipWrathStocks then
					addTraitToUpdate( trait )
				elseif trait.Slot == "Shout" and TraitData[trait.Name].AddShout and TraitData[trait.Name].AddShout.MaxDurationMultiplier then
					local hasExtractValues = true
					if TraitData[trait.Name].AddShout.ExtractValues then
						for i, extractData in pairs( TraitData[trait.Name].AddShout.ExtractValues ) do
							if not trait[extractData.ExtractAs] then
								hasExtractValues = false
							end
						end
					end
					if not hasExtractValues then
						addTraitToUpdate( trait )
					end
				elseif trait.CustomNameWithMetaUpgrade and trait.CustomNameWithMetaUpgrade.MetaUpgradeName == "HealingReductionShrineUpgrade" and not trait.HealingReduction then
					addTraitToUpdate( trait )
				else
					for key, data in pairs (TraitData[trait.Name]) do
						if not trait[key] then
							addTraitToUpdate(  trait )
							break
						end
					end
				end

				if trait.PropertyChanges ~= nil then
					for k, propertyChange in pairs( trait.PropertyChanges ) do
						if propertyChange.ProjectileProperty == "DamagePerConescutiveHit" then
							addTraitToUpdate( trait )
						elseif propertyChange.WeaponProperty == "AdditionalProjectileDamageMultiplier" then
							addTraitToUpdate( trait )
						elseif propertyChange.LifeProperty == "MaxHealth" then
							addTraitToUpdate( trait )
						elseif propertyChange.LifeProperty == "Health" then
							addTraitToUpdate( trait )
						end
					end
				end

				if trait.AddOutgoingDamageModifiers and trait.AddOutgoingDamageModifiers.ValidWeapons and not trait.AddOutgoingDamageModifiers.ValidWeaponsLookup then
					addTraitToUpdate( trait )
				end

				if trait.Name == "NoCollisionTrait" then
					IncrementTableValue(traitsToRemove, trait.Name)
					IncrementTableValue(traitsToAdd, "MetaPointHealTrait")
				end

				if trait.Name == "LimitGainTrait" then
					IncrementTableValue(traitsToRemove, trait.Name)
					IncrementTableValue(traitsToAdd, "SuperGenerationTrait")
				end

				if trait.Name == "RetainMoneyOnDeathTrait" then
					IncrementTableValue(traitsToRemove, trait.Name)
					IncrementTableValue(traitsToAdd, "BonusMoneyTrait")
				end

				if trait.Name == "ChaosCurseMoveSpeedTrait" or trait.Name == "TemporaryMoveSpeedTrait" then
					if trait.PropertyChanges[1].ChangeType == "Add" then
						IncrementTableValue(traitsToRemove, trait.Name)
					end
				end

				if trait.Name == "MetaUpgradeLastStandTrait" or trait.Name == "AthenaLastStandTrait" then
					IncrementTableValue(traitsToRemove, trait.Name)
					AddLastStand({
						Icon = trait.LifeIcon or "ExtraLifeZag",
						WeaponName = "LastStandMetaUpgradeShield",
						HealFraction = 0.5
					})
				end

				if trait.Name == "ReincarnationTrait" and trait.KeepsakeLastStandHealAmount == nil then
					IncrementTableValue(traitsToRemove, trait.Name)
					AddLastStand({
						InsertAtEnd = true,
						Icon = "ExtraLifeSkelly",
						WeaponName = "LastStandReincarnateShield",
						HealAmount = GetTotalHeroTraitValue( "KeepsakeLastStandHealAmount" ),
					})
				end
			end

			local orderedTraitsToAdd = CollapseTableAsOrderedKeyValuePairs(traitsToAdd)
			for index, kvp in ipairs(orderedTraitsToAdd) do
				local traitName = kvp.Key
				local traitNumber = kvp.Value
				for i=1, traitNumber do
					DebugPrint({Text = " Removing " .. traitName })
					RemoveTrait( CurrentRun.Hero, traitName )
				end
				for i=1, traitNumber do

					DebugPrint({Text = " Readding " .. traitName })
					AddTraitToHero({ TraitName = traitName, Rarity = "Common" })
				end
			end

			local orderedTraitsToRemove = CollapseTableAsOrderedKeyValuePairs(traitsToRemove)
			for index, kvp in ipairs(orderedTraitsToRemove) do
				local traitName = kvp.Key
				local traitNumber = kvp.Value
				for i=1, traitNumber do
					DebugPrint({Text = " Removing " .. traitName })
					RemoveTrait( CurrentRun.Hero, traitName )
				end
			end			

			if CurrentRun.Hero.OnFireWeapons and HeroHasTrait("ShieldRushBonusProjectileTrait") then
				if CurrentRun.Hero.OnFireWeapons.ShieldThrow and CurrentRun.Hero.OnFireWeapons.ShieldThrow.ChaosShieldThrow then
					RemoveOnFireWeapons( CurrentRun.Hero, { LegalOnFireWeapons = {"ShieldThrow" }, AddOnFireWeapons = { "ChaosShieldThrow" } } )
				end
				if CurrentRun.Hero.OnFireWeapons.ShieldThrowDash and CurrentRun.Hero.OnFireWeapons.ShieldThrowDash.ChaosShieldThrow then
					RemoveOnFireWeapons( CurrentRun.Hero, { LegalOnFireWeapons = {"ShieldThrowDash" }, AddOnFireWeapons = { "ChaosShieldThrow" } } )
				end
			end

			ValidateMaxHealth()
			CleanRecentTraitsRecord()
			SortPriorityTraits()

			CurrentRun.Hero.TargetMetaRewardsRatio = CurrentRun.Hero.TargetMetaRewardsRatio or HeroData.DefaultHero.TargetMetaRewardsRatio
			CurrentRun.Hero.TargetMetaRewardsAdjustSpeed = CurrentRun.Hero.TargetMetaRewardsAdjustSpeed or HeroData.DefaultHero.TargetMetaRewardsAdjustSpeed
			CurrentRun.Hero.CanBeFrozen = CurrentRun.Hero.CanBeFrozen or HeroData.DefaultHero.CanBeFrozen

			if GetNumMetaUpgrades( "EnemyDamageShrineUpgrade" ) > 0 then
				if not HasIncomingDamageModifier(CurrentRun.Hero, "EnemyDamageShrineUpgrade") then
					local damageIncrease = GetNumMetaUpgrades( "EnemyDamageShrineUpgrade" ) * ( MetaUpgradeData.EnemyDamageShrineUpgrade.ChangeValue - 1 )
					AddIncomingDamageModifier( CurrentRun.Hero,
					{
						Name = "EnemyDamageShrineUpgrade",
						NonTrapDamageTakenMultiplier = damageIncrease
					})
				end
			end

			if HasIncomingDamageModifier( CurrentRun.Hero, "MagicShield" ) then
				RemoveIncomingDamageModifier( CurrentRun.Hero, "MagicShield" )
			end
		end

		if CurrentRun.CurrentRoom ~= nil then
			if CurrentRun.CurrentRoom.ChosenRewardType == "Health" then
				CurrentRun.CurrentRoom.ChosenRewardType = "RoomRewardMaxHealthDrop"
			elseif CurrentRun.CurrentRoom.ChosenRewardType == "Money" then
				CurrentRun.CurrentRoom.ChosenRewardType = "RoomRewardMoneyDrop"
			elseif CurrentRun.CurrentRoom.ChosenRewardType == "MetaPoints" then
				CurrentRun.CurrentRoom.ChosenRewardType = "RoomRewardMetaPointDrop"
			elseif CurrentRun.CurrentRoom.ChosenRewardType == "Gift" then
				CurrentRun.CurrentRoom.ChosenRewardType = "GiftDrop"
			elseif CurrentRun.CurrentRoom.ChosenRewardType == "LockKey" then
				CurrentRun.CurrentRoom.ChosenRewardType = "LockKeyDrop"
			end

			if CurrentRun.CurrentRoom.ChallengeEncounterName == "TimeChallengeEncounterTartarus" then
				CurrentRun.CurrentRoom.ChallengeEncounterName = "TimeChallengeTartarus"
			end
			if CurrentRun.CurrentRoom.ChallengeEncounterName == "TimeChallengeEncounterAsphodel" then
				CurrentRun.CurrentRoom.ChallengeEncounterName = "TimeChallengeAsphodel"
			end

			if CurrentRun.CurrentRoom.Name == "B_Boss01" then
				CurrentRun.CurrentRoom.ZoomFraction = RoomSetData.Asphodel.B_Boss01.ZoomFraction
				CurrentRun.CurrentRoom.CameraZoomWeights = RoomSetData.Asphodel.B_Boss01.CameraZoomWeights

			end

			if CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.Name == "Boss01" then
				CurrentRun.CurrentRoom.Encounter.Name = "BossHarpy1"
			end

		end		

		if CurrentRun.CurrentRoom.Encounter ~= nil and EncounterData[CurrentRun.CurrentRoom.Encounter.Name] ~= nil then
			CurrentRun.CurrentRoom.Encounter.StartRoomUnthreadedEvents = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].StartRoomUnthreadedEvents
			CurrentRun.CurrentRoom.Encounter.WipeEnemiesOnKill = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].WipeEnemiesOnKill
			CurrentRun.CurrentRoom.Encounter.CancelSpawnsOnKill = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].CancelSpawnsOnKill
			CurrentRun.CurrentRoom.Encounter.CancelSpawnsOnKillAll = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].CancelSpawnsOnKillAll
			CurrentRun.CurrentRoom.Encounter.CancelSpawnsOnKillAllTypes = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].CancelSpawnsOnKillAllTypes
			CurrentRun.CurrentRoom.Encounter.PreSpawnEnemies = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].PreSpawnEnemies
			CurrentRun.CurrentRoom.Encounter.EnemyCountShineModifierAmount = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].EnemyCountShineModifierAmount
			CurrentRun.CurrentRoom.Encounter.BlockEliteAttributes = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].BlockEliteAttributes

			CurrentRun.CurrentRoom.Encounter.SpawnIntervalMin = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].SpawnIntervalMin
			CurrentRun.CurrentRoom.Encounter.SpawnIntervalMax = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].SpawnIntervalMax
			CurrentRun.CurrentRoom.Encounter.SpawnCapHitReleaseDuration = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].SpawnCapHitReleaseDuration
			CurrentRun.CurrentRoom.Encounter.SpawnThreadName = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].SpawnThreadName
			CurrentRun.CurrentRoom.Encounter.LoadBinksFromEnemySet = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].LoadBinksFromEnemySet
			CurrentRun.CurrentRoom.Encounter.Binks = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].Binks

			if CurrentRun.CurrentRoom.Encounter.EnemyCountShrineModifierName ~= nil and CurrentRun.CurrentRoom.Encounter.EnemyCountShineModifierAmount == nil then
				CurrentRun.CurrentRoom.Encounter.EnemyCountShineModifierAmount = 1
			end

			if CurrentRun.CurrentRoom.Encounter.WrappingData ~= nil and CurrentRun.CurrentRoom.Encounter.WrappingData.ObstacleOptions ~= nil then
				--if type(GetFirstValue(CurrentRun.CurrentRoom.Encounter.WrappingData.ObstacleOptions)) == "string" then
					CurrentRun.CurrentRoom.Encounter.WrappingData = EncounterData.WrappingAsphodel.WrappingData
				--end
			end

			if CurrentRun.CurrentRoom.Encounter.DistanceTriggers ~= nil then
				for k, trigger in pairs( CurrentRun.CurrentRoom.Encounter.DistanceTriggers ) do
					if trigger.TriggerGroup ~= nil and type( trigger.TriggerGroup ) == "table" then
						trigger.TriggerGroup = nil
						DebugPrint({ Text = "removed back-compat wrong type" })
					end
				end
			end

			if CurrentRun.CurrentRoom.Encounter.Name == "WrappingAsphodel" then
				CurrentRun.CurrentRoom.Encounter.UnthreadedEvents = EncounterSets.EncounterEventsWrapping
			end

			if CurrentRun.CurrentRoom.Encounter.Name == "MiniBossCrawler" then
				CurrentRun.CurrentRoom.Encounter.UnthreadedEvents = EncounterData.MiniBossCrawler.UnthreadedEvents
			end

			if CurrentRun.CurrentRoom.Encounter.Name == "A_Boss01" then
				CurrentRun.CurrentRoom.Encounter.SpawnWaves = EncounterData.A_Boss01.SpawnWaves
			end

			if CurrentRun.CurrentRoom.Encounter.Name == "A_Boss02" then
				CurrentRun.CurrentRoom.Encounter.SpawnWaves = EncounterData.A_Boss01.SpawnWaves
			end

			if CurrentRun.CurrentRoom.Encounter.Name == "BossHydra" then
				CurrentRun.CurrentRoom.Encounter.BlockHeadsByHydraVariant = EncounterData.BossHydra.BlockHeadsByHydraVariant
			end

			if CurrentRun.CurrentRoom.Encounter.Name == "MiniBossMinotaur" then
				OverwriteTableKeys(CurrentRun.CurrentRoom.Encounter, EncounterData.MiniBossMinotaur)
				CurrentRun.CurrentRoom.Encounter.UnthreadedEvents = EncounterData.MiniBossMinotaur.UnthreadedEvents
				CurrentRun.CurrentRoom.Encounter.SpawnWaves = EncounterData.MiniBossMinotaur.SpawnWaves
			end

			if CurrentRun.CurrentRoom.Encounter.Name == "SurvivalElysium" then
				CurrentRun.CurrentRoom.Encounter.ActiveEnemyCapBase = EncounterData.SurvivalElysium.ActiveEnemyCapBase
			end

			if CurrentRun.CurrentRoom.Encounter.Name == "BossTheseusAndMinotaur" then
				CurrentRun.CurrentRoom.Encounter.SpawnThreadName = EncounterData.BossTheseusAndMinotaur.SpawnThreadName
			end

			if CurrentRun.CurrentRoom.Encounter.Name == "BossCharon" then
				CurrentRun.CurrentRoom.Encounter.SpawnWaves = EncounterData.BossCharon.SpawnWaves
			end

			if CurrentRun.CurrentRoom.Encounter.Name == "BossHadesPeaceful" then
				CurrentRun.CurrentRoom.Encounter.PostUnthreadedEvents = EncounterData.BossHadesPeaceful.PostUnthreadedEvents
			end

			if CurrentRun.CurrentRoom.Encounter.InheritFrom ~= nil and Contains(CurrentRun.CurrentRoom.Encounter.InheritFrom, "BaseIntroEncounter") then
				CurrentRun.CurrentRoom.Encounter.DistanceTriggers = EncounterData[CurrentRun.CurrentRoom.Encounter.Name].DistanceTriggers
			end

			if CurrentRun.CurrentRoom.Encounter.RequiredKillFunctionName == "TrackThanatosChallengeProgress" then
				CurrentRun.CurrentRoom.Encounter.ObjectiveSets = EncounterData.BaseThanatos.ObjectiveSets
			end

			if CurrentRun.CurrentRoom.Encounter.CancelSpawnsOnKill ~= nil and type(CurrentRun.CurrentRoom.Encounter.CancelSpawnsOnKill) ~= "table" then
				CurrentRun.CurrentRoom.Encounter.CancelSpawnsOnKill = { CurrentRun.CurrentRoom.Encounter.CancelSpawnsOnKill }
			end

			if CurrentRun.CurrentRoom.Encounter.Spawns ~= nil then
				for k, spawnData in pairs( CurrentRun.CurrentRoom.Encounter.Spawns ) do
					if spawnData.Name == "Turret" then
						spawnData.Name = "SplitShotUnit"
					end
					if spawnData.Name == "TurretElite" then
						spawnData.Name = "SplitShotUnitElite"
					end
				end
			end

			if CurrentRun.CurrentRoom.Encounter.SpawnWaves ~= nil then
				for k, wave in pairs( CurrentRun.CurrentRoom.Encounter.SpawnWaves ) do
					for k, spawnData in pairs( wave.Spawns ) do
						if spawnData.Name == "Turret" then
							spawnData.Name = "SplitShotUnit"
						end
						if spawnData.Name == "TurretElite" then
							spawnData.Name = "SplitShotUnitElite"
						end
					end
				end
			end
		end

		CurrentRun.MoneyRecord = CurrentRun.MoneyRecord or {}

		if TextLinesRecord.NyxMiscMeeting01 or TextLinesRecord.NyxGrantsRespec then
			GameState.Flags.SwapMetaupgradesEnabled = true
		end

		if IsWeaponUnlocked( "FistWeapon" ) then
			GameState.Flags.FistUnlocked = true
		end

		if IsWeaponUnlocked( "GunWeapon" ) then
			GameState.Flags.GunUnlocked = true
		end

		if GetNumUnlockedWeaponUpgrades() > 0 then
			GameState.Flags.AspectsUnlocked = true
		end

		-- Super old, not needed anymore
		--if CalcTotalNumEntries( UseRecord ) > 9999 then
			--UseRecord = {}
		--end

		if CurrentRun.MarketItems ~= nil then
			for k, item in pairs( CurrentRun.MarketItems ) do
				if item.Buys ~= nil or item.CostLow ~= nil then
					-- Remove old data structure
					CurrentRun.MarketItems = nil
					break
				end
			end
		end

		if CurrentRun.LootTypeHistory ~= nil then
			for lootName, i in pairs(CurrentRun.LootTypeHistory) do
				if not GameData.MissingPackages[lootName] then
					LoadPackages({ Name = lootName })
				end
			end
		end


	end
	DebugPrint({Text = " Done patching."})
end

function GetMaxHealthUpgradeIncrement( value )
	local expectedMaxHealth = HeroData.DefaultHero.MaxHealth
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		if trait.PropertyChanges ~= nil then
			for k, propertyChange in pairs( trait.PropertyChanges ) do
				if propertyChange.LuaProperty == "MaxHealth" then
					expectedMaxHealth = expectedMaxHealth + propertyChange.ChangeValue
				end
			end
		end
	end

	expectedMaxHealth = expectedMaxHealth + GetNumMetaUpgrades("HealthMetaUpgrade") * MetaUpgradeData.HealthMetaUpgrade.ChangeValue + value
	expectedMaxHealth = round(expectedMaxHealth * GetTotalHeroTraitValue("MaxHealthMultiplier", { IsMultiplier = true }))

	return expectedMaxHealth - CurrentRun.Hero.MaxHealth
end

function ValidateMaxHealth( blockHealing )
	local expectedMaxHealth = HeroData.DefaultHero.MaxHealth
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		if trait.PropertyChanges ~= nil then
			for k, propertyChange in pairs( trait.PropertyChanges ) do
				if propertyChange.LuaProperty == "MaxHealth" then
					expectedMaxHealth = expectedMaxHealth + propertyChange.ChangeValue
				end
			end
		end
	end
	expectedMaxHealth = expectedMaxHealth + GetNumMetaUpgrades("HealthMetaUpgrade") * MetaUpgradeData.HealthMetaUpgrade.ChangeValue
	expectedMaxHealth = round(expectedMaxHealth * GetTotalHeroTraitValue("MaxHealthMultiplier", { IsMultiplier = true }))
	if expectedMaxHealth ~= CurrentRun.Hero.MaxHealth then
		local delta = expectedMaxHealth - CurrentRun.Hero.MaxHealth
		CurrentRun.Hero.MaxHealth = round( CurrentRun.Hero.MaxHealth + delta ) 
		if not blockHealing then
			CurrentRun.Hero.Health = round( CurrentRun.Hero.Health + delta )  
		end
	end
end

function SetupMap()

	CreateGroup({ Name = "Standing" })

	CreateGroup({ Name = "Standing_Back" })
	InsertGroupBehind({ Name = "Standing_Back", DestinationName = "Standing" })

	CreateGroup({ Name = "Standing_Back_Add", BlendMode = "Additive" })
	InsertGroupInFront({ Name = "Standing_Back_Add", DestinationName = "Standing_Back" })

	CreateGroup({ Name = "FX_Terrain", BlendMode = "Normal" })
	InsertGroupBehind({ Name = "FX_Terrain", DestinationName = "Standing_Back" })

	CreateGroup({ Name = "FX_Terrain_Dark", BlendMode = "Normal" })
	InsertGroupBehind({ Name = "FX_Terrain_Dark", DestinationName = "FX_Terrain" })

	CreateGroup({ Name = "FX_Terrain_Liquid", BlendMode = "Normal" })
	InsertGroupBehind({ Name = "FX_Terrain_Liquid", DestinationName = "FX_Terrain" })

	CreateGroup({ Name = "FX_Terrain_Add", BlendMode = "Additive" })
	InsertGroupInFront({ Name = "FX_Terrain_Add", DestinationName = "FX_Terrain" })

	CreateGroup({ Name = "FX_Displacement", BlendMode = "DisplacementMerge" })
	InsertGroupInFront({ Name = "FX_Displacement", DestinationName = "Standing" })

	CreateGroup({ Name = "FX_Standing_Add", BlendMode = "AdditiveMerge" })
	InsertGroupInFront({ Name = "FX_Standing_Add", DestinationName = "FX_Displacement" })

	CreateGroup({ Name = "FX_Dark", BlendMode = "Normal" })
	InsertGroupBehind({ Name = "FX_Dark", DestinationName = "Standing_Back" })

	CreateGroup({ Name = "FX_Terrain_Top", BlendMode = "Normal" })
	InsertGroupInFront({ Name = "FX_Terrain_Top", DestinationName = "FX_Terrain" })

	CreateGroup({ Name = "Shadows" })
	InsertGroupBehind({ Name = "Shadows", DestinationName = "FX_Terrain_Add" })

	CreateGroup({ Name = "FX_Standing_Top", BlendMode = "Normal" })
	InsertGroupInFront({ Name = "FX_Standing_Top", DestinationName = "FX_Standing_Add" })

	CreateGroup({ Name = "FX_Add_Top", BlendMode = "Additive" })
	InsertGroupInFront({ Name = "FX_Add_Top", DestinationName = "FX_Standing_Top" })

	local vignetteBlendMode = "Overlay"
	if not GetConfigOptionValue({ Name = "DrawBloom" }) then
		vignetteBlendMode = "Additive"
	end
	CreateGroup({ Name = "Vignette", BlendMode = vignetteBlendMode })
	InsertGroupInFront({ Name = "Vignette", DestinationName = "MapArt" })

	CreateGroup({ Name = "Combat_UI_World_Backing" })
	CreateGroup({ Name = "Combat_UI_World" })
	CreateGroup({ Name = "Combat_UI_World_Add", BlendMode = "Additive" })
	CreateGroup({ Name = "Combat_UI" })
	CreateGroup({ Name = "Combat_UI_Backing" })
	CreateGroup({ Name = "Combat_UI_Additive", BlendMode = "Additive" })
	CreateGroup({ Name = "Combat_Menu" })
	CreateGroup({ Name = "Combat_Menu_Additive", BlendMode = "Additive" })
	CreateGroup({ Name = "Combat_Menu_Overlay_Backing" })
	CreateGroup({ Name = "Combat_Menu_Overlay" })
	CreateGroup({ Name = "Combat_Menu_TraitTray_Backing" })
	CreateGroup({ Name = "Combat_Menu_TraitTray" })
	CreateGroup({ Name = "Combat_Menu_TraitTray_Additive", BlendMode = "Additive" })
	CreateGroup({ Name = "Combat_Menu_TraitTray_Overlay" })
	CreateGroup({ Name = "Combat_Menu_TraitTray_Overlay_Additive", BlendMode = "Additive" })
	CreateGroup({ Name = "Portrait_FX_Behind" })
	CreateGroup({ Name = "Portrait_FX_Behind_Add", BlendMode = "Additive" })

	InsertGroupInFront({ Name = "Combat_UI_World", DestinationName = "Combat_UI_World_Backing" })
	InsertGroupInFront({ Name = "Combat_UI_Backing", DestinationName = "Combat_UI_World" })
	InsertGroupInFront({ Name = "Combat_UI_World_Add", DestinationName = "Combat_UI_World_Backing" })
	InsertGroupInFront({ Name = "Combat_UI", DestinationName = "Combat_UI_Backing" })
	InsertGroupInFront({ Name = "Combat_UI_Additive", DestinationName = "Combat_UI" })
	InsertGroupInFront({ Name = "Combat_Menu", DestinationName = "Combat_UI_Additive" })
	InsertGroupBehind({ Name = "Portrait_FX_Behind", DestinationName = "Combat_Menu" })
	InsertGroupInFront({ Name = "Portrait_FX_Behind_Add", DestinationName = "Portrait_FX_Behind" })
	InsertGroupInFront({ Name = "Combat_Menu_Additive", DestinationName = "Combat_Menu" })
	InsertGroupInFront({ Name = "Combat_Menu_Overlay_Backing", DestinationName = "Combat_Menu_Additive" })
	InsertGroupInFront({ Name = "Combat_Menu_Overlay", DestinationName = "Combat_Menu_Overlay_Backing" })
	InsertGroupInFront({ Name = "Combat_Menu_TraitTray_Backing", DestinationName = "Combat_Menu_Overlay" })
	InsertGroupInFront({ Name = "Combat_Menu_TraitTray", DestinationName = "Combat_Menu_TraitTray_Backing" })
	InsertGroupInFront({ Name = "Combat_Menu_TraitTray_Additive", DestinationName = "Combat_Menu_TraitTray" })
	InsertGroupInFront({ Name = "Combat_Menu_TraitTray_Overlay", DestinationName = "Combat_Menu_TraitTray_Additive" })
	InsertGroupInFront({ Name = "Combat_Menu_TraitTray_Overlay_Additive", DestinationName = "Combat_Menu_TraitTray_Overlay" })

end

function IsRecordRunDepth( currentRun )
	local highestRunDepth = GetHighestPrevRunRepth( currentRun )
	if currentRun.RunDepthCache >= highestRunDepth then
		return true
	end
	return false
end

function GetHighestPrevRunRepth( currentRun )
	local highestRunDepth = 0
	for k, prevRun in pairs( GameState.RunHistory ) do
		if prevRun.RunDepthCache > highestRunDepth then
			highestRunDepth = prevRun.RunDepthCache
		end
	end
	return highestRunDepth
end

function GetFastestRunClearTime( currentRun )
	local fastestTime = 999999
	if currentRun.Cleared then
		fastestTime = currentRun.GameplayTime
	end
	for k, prevRun in pairs( GameState.RunHistory ) do
		if IsSameMode( prevRun ) and prevRun.RunDepthCache > 44 and prevRun.Cleared and prevRun.GameplayTime ~= nil and prevRun.GameplayTime < fastestTime then
			fastestTime = prevRun.GameplayTime
		end
	end
	return fastestTime
end

function GetFastestRunClearTimeWithWeapon( currentRun, weapon )
	local fastestTime = nil
	if currentRun.Cleared and currentRun.WeaponsCache[weapon] then
		fastestTime = currentRun.GameplayTime
	end
	for k, prevRun in pairs( GameState.RunHistory ) do
		if prevRun.WeaponsCache ~= nil and prevRun.WeaponsCache[weapon] then
			if IsSameMode( prevRun ) and prevRun.RunDepthCache > 44 and prevRun.Cleared and prevRun.GameplayTime ~= nil and (fastestTime == nil or prevRun.GameplayTime < fastestTime) then
				fastestTime = prevRun.GameplayTime
			end
		end
	end
	return fastestTime
end

function RunHasOneOfTraits( run, traits )
	if run.TraitCache == nil then
		return false
	end
	for k, traitName in pairs( traits ) do
		if run.TraitCache[traitName] then
			return true
		end
	end
	return false
end

function RunHasTraits( run, traits )
	if run.TraitCache == nil then
		return false
	end
	for k, traitName in pairs( traits ) do
		if not run.TraitCache[traitName] then
			return false
		end
	end
	return true
end

OnUsed{ "ExitDoors",
	function( triggerArgs )
		AttemptUseDoor( triggerArgs.TriggeredByTable )
	end
}

function AttemptUseDoor( door )

	if not door.ReadyToUse or not CheckRoomExitsReady( CurrentRun.CurrentRoom ) or CheckSpecialDoorRequirement( door ) ~= nil then
		thread( CannotUseDoorPresentation, door )
		return
	end

	if CurrentRun.CurrentRoom.SellTraitShrineUpgrade and CurrentRun.CurrentRoom.SellTraitShop ~= nil and GetNumMetaUpgrades( "ForceSellShrineUpgrade" ) > 0 and not CurrentRun.CurrentRoom.SoldTrait and not IsEmpty( CurrentRun.CurrentRoom.SellOptions ) then
		-- if the shrine upgrade is active, blcok the entrance until the well shop is used
		if CheckCooldown( "DoorLocked", 1.0 ) then
			PlaySound({ Name = door.LockedUseSound or RoomData.BaseRoom.LockedUseSound, Id = door.ObjectId })
			thread( InCombatTextArgs, { Text = "ExitBlockedBySellWell", TargetId = CurrentRun.Hero.ObjectId, SkipRise = true, SkipFlash = true, SkipShadow = false, Duration = 1.5, OffsetY = -160, ShadowScaleX = 2.0 } )
			thread( PlayVoiceLines, HeroVoiceLines.ExitBlockedBySellWellVoiceLines, true )
		end
		return false
	end


	if door.Cost ~= nil then
		SpendMoney( door.Cost, door.Name or "Door" )
	end

	if door.DoorDepthSkip then
		CurrentRun.CurrentRoom.DepthSkip = door.DoorDepthSkip
	end

	if door.DoorBiomeSkip then
		CurrentRun.CurrentRoom.NextRoomSet = door.DoorBiomeSkip
	end

	if door.HealthCost ~= nil then
		SacrificeHealth({ SacrificeHealthMin = door.HealthCost, SacrificeHealthMax = door.HealthCost, Silent = true })
	end

	SetPlayerInvulnerable( "LeaveRoom" )
	AddTimerBlock( CurrentRun, "UseDoor" )

	if door.OnUsedPresentationFunctionName ~= nil then
		local onUsedPresentationFunction = _G[door.OnUsedPresentationFunctionName]
		if onUsedPresentationFunction ~= nil then
			onUsedPresentationFunction( door.ObjectId, door )
		end
	end

	RemoveTimerBlock( CurrentRun, "UseDoor" )
	SetPlayerVulnerable( "LeaveRoom" )

	PlaySound({ Name = door.UnlockedUseSound or RoomData.BaseRoom.UnlockedUseSound })
	LeaveRoom( CurrentRun, door )

end

function CheckSpecialDoorRequirement( door )

	if door == nil then
		return "ExitNotActive"
	end

	if door.HealthCost ~= nil and CurrentRun.Hero.Health <= door.HealthCost then
		return "ExitBlockedByHealthReq"
	end

	if door.ShrinePointReq ~= nil and GetTotalSpentShrinePoints() < door.ShrinePointReq then
		return "ExitBlockedByShrinePointReq"
	end

	if door.Cost ~= nil and CurrentRun.Money < door.Cost then
		return "ExitBlockedByMoneyReq"
	end

	return nil

end

function CheckDoorHealTrait( currentRun )
	local maxHealth = currentRun.Hero.MaxHealth
	local healAmount = 0
	local roomHealFraction = GetTotalHeroTraitValue("DoorHeal")

	healAmount = roomHealFraction * maxHealth

	healAmount = healAmount + GetNumMetaUpgrades("DoorHealMetaUpgrade") * MetaUpgradeData.DoorHealMetaUpgrade.ChangeValue
	healAmount = round( healAmount * CalculateHealingMultiplier())
	if healAmount > 0 then
		Heal( CurrentRun.Hero, { HealAmount = healAmount, Name = "DoorHeal" } )
	end

	thread( UpdateHealthUI )
end

function CheckInspectPoints( currentRun, source )
	if source.InspectPoints == nil then
		return
	end
	for id, inspectPointData in pairs( source.InspectPoints ) do
		ProcessTextLines( inspectPointData.InteractTextLineSets )
		inspectPointData.ObjectId = id
		if IsInspectPointEligible( currentRun, source, inspectPointData ) then
			Activate({ Id = id })
			AttachLua({ Id = id, Table = inspectPointData })
			inspectPointData.RecordUse = true
			if inspectPointData.Hidden ~= nil then
				SetAlpha({ Id = id, Fraction = 0.0 })
			end
			if inspectPointData.Deactivated then
				SetAlpha({ Id = id, Fraction = 1.0 })
				UseableOn({ Id = id })
				inspectPointData.Deactivated = false
			end
			if inspectPointData.ClearNextInteractLinesOnActivate then
				local source = ActiveEnemies[inspectPointData.ClearNextInteractLinesOnActivate]
				source.NextInteractLines = nil
				UseableOff({ Id = source.ObjectId })
				RefreshUseButton( source.ObjectId, source )
				StopStatusAnimation( source )
			end
		elseif inspectPointData.DeactivateIfIneligible then
			SetAlpha({ Id = id, Fraction = 0.0 })
			UseableOff({ Id = id })
			inspectPointData.Deactivated = true
		end

	end
end

function StartRoom( currentRun, currentRoom )

	if currentRoom.EncounterSpecificDataOverwrites ~= nil and currentRoom.EncounterSpecificDataOverwrites[currentRoom.Encounter.Name] ~= nil then
		OverwriteTableKeys(currentRoom, currentRoom.EncounterSpecificDataOverwrites[currentRoom.Encounter.Name])
	end

	if currentRoom.RunOverrides then
		OverwriteTableKeys(currentRun, currentRoom.RunOverrides)
	end

	currentRun.RunDepthCache = currentRun.RunDepthCache or GetRunDepth( currentRun )
	currentRun.BiomeDepthCache = currentRun.BiomeDepthCache or GetBiomeDepth( currentRun )
	if currentRoom.WingRoom then
		currentRun.WingDepth = (currentRun.WingDepth or 0) + 1
	else
		currentRun.WingDepth = 0
	end
	if currentRoom.WingEndRoom then
		currentRun.CompletedStyxWings = currentRun.CompletedStyxWings + 1
	end

	DebugAssert({ Condition = not currentRun.Hero.IsDead, Text = "Starting a room with a dead hero!" })

	if currentRoom.RichPresence ~= nil then
		SetRichPresence({ Key = "status", Value = currentRoom.RichPresence })
		SetRichPresence({ Key = "steam_display", Value = currentRoom.RichPresence })
	end

	AddTimerBlock( currentRun, "StartRoom" )
	if currentRoom.TimerBlock ~= nil then
		AddTimerBlock( currentRun, currentRoom.TimerBlock )
	end
	if currentRoom.RemoveTimerBlock ~= nil then
		RemoveTimerBlock( currentRun, currentRoom.RemoveTimerBlock )
	end

	LifeOnKillRecord = {}
	DamageRecord = {}
	SpawnRecord = {}
	HealthRecord = {}
	ForceNextRoom = nil
	ForceNextEncounter = nil

	DebugPrint({ Text = "StartRoom: "..currentRoom.Name.." (RunDepth = "..currentRun.RunDepthCache..")".." (BiomeDepth = "..currentRun.BiomeDepthCache..")".." (Seed = "..GetGlobalRng().seed..")" })

	local previousRoom = GetPreviousRoom(currentRun)
	if previousRoom ~= nil and previousRoom.StartTime ~= nil then
		local timeInPrev = _worldTime - previousRoom.StartTime
		--DebugPrint({ Text = "Time in previous: "..timeInPrev.." seconds" })
	end

	if currentRoom.CameraWalls then
		CreateCameraWalls({ })
	end

	if currentRoom.BreakableOptions ~= nil then
		RandomizeBreakables( currentRoom )
	end

	AddInputBlock({ Name = "StartRoom" })
	local firstRoomOfRun = IsEmpty( currentRun.RoomHistory )
	SetupHeroObject( currentRun, firstRoomOfRun )
	if firstRoomOfRun and not GameState.ActiveOnslaught then
		ValidateMaxHealth()
	end
	currentRoom.StartTime = _worldTime

	local prevRoom = GetPreviousRoom( currentRun )
	if prevRoom ~= nil and prevRoom.CheckWeaponHistory then
		UpdateWeaponHistory(currentRun)
	end

	SwitchActiveUnit({ Id = currentRun.Hero.ObjectId })

	SetupPreActivatedEnemies( currentRun )
	AssignObstacles( currentRoom )

	LoadSpawnPackages( currentRoom.Encounter )
	HandleSecretSpawns( currentRun )
	CheckChallengeSwitchItemValidity( currentRun )
	StartRoomPreLoadBinks({
		Run = currentRun,
		Room = currentRoom,
		Encounter = currentRoom.Encounter,
		ChallengeEncounter = currentRoom.ChallengeEncounter
	})

	if currentRoom.BreakableValueOptions ~= nil then
		HandleBreakableSwap( currentRoom )
	end

	-- Active ExitDoors
	local exitDoorIds = GetInactiveIds({ Name = "ExitDoors" })
	local firstDoor = true
	while not IsEmpty( exitDoorIds ) do
		local doorId = RemoveRandomValue( exitDoorIds )
		if firstDoor or RandomChance( currentRun.CurrentRoom.ExtraDoorActivateChance or 1.0 ) then
			Activate({ Id = doorId })
			firstDoor = false
		end
	end

	ChooseNextRewardStore( currentRun )

	FadeOut({ Color =  Color.Black, Duration = 0 })

	if currentRoom.Encounter.SpawnWaves ~= nil and GetNumMetaUpgrades( "EnemyEliteShrineUpgrade" ) > 0 then
		PickRoomEliteTypeUpgrades(currentRoom)
	end

	RunUnthreadedEvents( currentRoom.StartUnthreadedEvents, currentRoom )
	RunUnthreadedEvents( currentRoom.Encounter.StartRoomUnthreadedEvents, currentRoom )

	local darknessEarned = 0
	for i, traitData in pairs(GetHeroTraitValues( "DarknessPerRoom" )) do
		darknessEarned = darknessEarned + traitData.Base + round(traitData.DepthMult * GetRunDepth( currentRun ))
	end
	AddResource( "MetaPoints", darknessEarned, "DarknessPerRoom", { Silent = true } )

	SetupRoomArt( currentRun, currentRoom )

	if GetNumMetaUpgrades("BiomeSpeedShrineUpgrade") > 0 then
		local currentArea = CurrentRun.CurrentRoom.BiomeMapArea or CurrentRun.CurrentRoom.RoomSetName
		local previousArea = nil
		if prevRoom then
			previousArea = prevRoom.BiomeMapArea or prevRoom.RoomSetName
		end
		local currentAreaIndex = -1
		for biomeListIndex, biomes in ipairs(BiomeList) do
			if BiomeList[biomeListIndex] == currentArea then
				currentAreaIndex = biomeListIndex
			end
		end

		if previousArea == nil or ( currentArea ~= previousArea and Contains(BiomeTimeLimits.ValidBiomes, currentArea ) and Contains(BiomeTimeLimits.ValidBiomes, previousArea )) then
			local additionalTime = BiomeTimeLimits.Timers[GetNumMetaUpgrades("BiomeSpeedShrineUpgrade")][currentAreaIndex]
			CurrentRun.BiomeTime = math.max( CurrentRun.BiomeTime, 0 ) + additionalTime
			thread( BiomeTimeCheckpointPresentation, CurrentRun, additionalTime )
		end
		-- if we are in a erebus / chaos / postboss room reset the timer
		thread( BiomeSpeedTimerLoop )
	end

	if GetNumMetaUpgrades("ExtraChanceReplenishMetaUpgrade") > 0 then
		local numRegenerationLastStands = 0
		for i, lastStand in pairs(CurrentRun.Hero.LastStands) do
			if lastStand.Name == "ExtraChanceReplenishMetaUpgrade" then
				numRegenerationLastStands = numRegenerationLastStands + 1
			end
		end
		while GetNumMetaUpgrades("ExtraChanceReplenishMetaUpgrade") > numRegenerationLastStands do
			AddLastStand({
				Name = "ExtraChanceReplenishMetaUpgrade",
				Unit = CurrentRun.Hero,
				Icon = "ExtraLifeReplenish",
				WeaponName = "LastStandMetaUpgradeShield",
				HealFraction = MetaUpgradeData.ExtraChanceReplenishMetaUpgrade.HealPercent,
				Silent = true
			})
			numRegenerationLastStands = numRegenerationLastStands + 1
		end
		CurrentRun.Hero.MaxLastStands = TableLength(CurrentRun.Hero.LastStands)
	end

	StartRoomPresentation( currentRun, currentRoom, darknessEarned )

	RemoveInputBlock({ Name = "StartRoom" })
	RemoveTimerBlock( currentRun, "StartRoom" )

	StartTriggers( currentRoom, currentRoom.DistanceTriggers )
	RunEvents( currentRoom )
	RunTraitThreads( currentRun.Hero )

	CheckAutoObjectiveSets( currentRun, "RoomStart" )

	if currentRoom.Encounter.SpawnDelay ~= nil then
		wait( currentRoom.Encounter.SpawnDelay )
	end

	if currentRoom.DisableWeapons then
		DisableCombatControls()
	elseif currentRoom.DisableWeaponsExceptDash then
		DisableCombatControls()
		ToggleControl({ Names = { "Rush" }, Enabled = true })
	else
		EnableCombatControls()
	end

	if not currentRoom.HideCombatUI then
		ShowCombatUI()
	end

	DebugAssert({ Condition = CurrentRun.Hero.IsDead or MusicId ~= nil or SecretMusicId ~= nil or AmbientMusicId ~= nil or currentRoom.NoReward or
		string.match( currentRoom.Name, "Test" ) ~= nil or string.match( currentRoom.Name, "Reprieve" ) ~= nil or string.match( currentRoom.Name, "B_Story01" ) ~= nil or
		currentRoom.Encounter.StartGlobalVoiceLines == "PerfectClearStartVoiceLines" or currentRoom.EndMusicOnEnterDuration ~= nil,
		Text = "Room started with no music!" })

	CheckDashOverride( currentRoom )

	-- Take the room's StartTriggerDistance, otherwise the encounter's
	local startTriggerDistance = currentRoom.OverrideStartTriggerDistance or currentRoom.Encounter.StartTriggerDistance
	if startTriggerDistance ~= nil and startTriggerDistance > 0 then
		local encounterStartIds = GetIdsByType({ Name = "EncounterStartPoint" })
		if not IsEmpty( encounterStartIds ) then
			local notifyName = "EncounterStartDistance"

			NotifyWithinDistanceAny({ Ids = { currentRun.Hero.ObjectId }, DestinationIds = encounterStartIds, Distance = startTriggerDistance, Notify = notifyName })
			waitUntil( notifyName )
		end
	end

	StartEncounter( currentRun, currentRoom, currentRoom.Encounter )

	CheckInspectPoints( currentRun, currentRoom, currentRoom.Encounter )

	StartTriggers( currentRoom, currentRoom.PostCombatDistanceTriggers )

end

function RestoreUnlockRoomExits( currentRun, currentRoom )

	LifeOnKillRecord = {}
	DamageRecord = {}
	SpawnRecord = {}
	HealthRecord = {}

	DebugPrint({ Text = "RestoreUnlockRoomExits: "..currentRoom.Name.." (RunDepth = "..currentRun.RunDepthCache..")".." (BiomeDepth = "..currentRun.BiomeDepthCache..")".." (Seed = "..GetGlobalRng().seed..")" })

	if currentRoom.CameraWalls then
		CreateCameraWalls({ })
	end

	AddInputBlock({ Name = "RestoreUnlockRoomExits" })
	SetupHeroObject( currentRun )

	SwitchActiveUnit({ Id = currentRun.Hero.ObjectId })

	SetupPreActivatedEnemies( currentRun )
	DisableRoomTraps()

	HandleSecretSpawns( currentRun )
	StartRoomPreLoadBinks({
		Run = currentRun,
		Room = currentRoom,
		Encounter = currentRoom.Encounter,
		ChallengeEncounter = currentRoom.ChallengeEncounter
	})

	RestoreObjectStates( currentRoom )

	-- Active ExitDoors
	local exitDoorIds = GetInactiveIds({ Name = "ExitDoors" })
	local firstDoor = true
	while not IsEmpty( exitDoorIds ) do
		local doorId = RemoveRandomValue( exitDoorIds )
		if firstDoor or RandomChance( currentRun.CurrentRoom.ExtraDoorActivateChance or 1.0 ) then
			Activate({ Id = doorId })
			firstDoor = false
		end
	end

	FadeOut({ Color =  Color.Black, Duration = 0 })

	SetupRoomArt( currentRun, currentRoom )

	CheckDashOverride( currentRoom )

	DestroyTraitUI()

	wait(0.6) -- Let object restoration transitions finish before fade in

	if currentRoom.RestorePresentationFunction ~= nil then
		local restorePresentationFunction = _G[currentRoom.RestorePresentationFunction]
		restorePresentationFunction( )
	end

	RestoreUnlockRoomExitsPresentation( currentRun, currentRoom )

	--StartTriggers( currentRoom, currentRoom.DistanceTriggers )
	--RunEvents( currentRoom )
	--RunTraitThreads( currentRun.Hero )
	RunUnthreadedEvents( currentRoom.PostCombatReloadEvents, currentRoom )

	CheckInspectPoints( currentRun, currentRoom, currentRoom.Encounter )

	StartTriggers( currentRoom, currentRoom.PostCombatDistanceTriggers )

	wait(0.1)

	DoUnlockRoomExits( currentRun, currentRoom )
	Destroy({ Ids = GetIds({ Name = "WaterEndingObjectsDestroy" }) })

	wait(0.1)

	RemoveInputBlock({ Name = "RestoreUnlockRoomExits" })

	if currentRoom.DisableWeapons then
		DisableCombatControls()
	else
		EnableCombatControls()
	end

	if not currentRoom.HideCombatUI then
		ShowCombatUI()
	end

	if GetNumMetaUpgrades("BiomeSpeedShrineUpgrade") > 0 then
		thread( BiomeSpeedTimerLoop )
	end


end

function LoadSpawnPackages( encounter )

	for _, packageData in pairs(GetHeroTraitValues("LoadPackages")) do
		if type(packageData) == "table" then
			LoadPackages({ Names = packageData })
		else
			LoadPackages({ Name = packageData })
		end
	end

	if encounter.Spawns == nil then
		return
	end

	for k, spawnData in pairs( encounter.Spawns ) do
		LoadPackages({ Name = spawnData.Name })
	end
end

function SetupPreActivatedEnemies( currentRun )

	for enemyName, enemyData in pairs( EnemyData ) do
		local ids = GetIdsByType({ Name = enemyName })
		for k, id in pairs( ids ) do
			local newEnemy = DeepCopyTable( enemyData )
			newEnemy.ObjectId = id
			SetupEnemyObject( newEnemy, currentRun )
		end
	end

end

function SetupHeroObject( currentRun, applyLuaUpgrades )

	local heroIds = GetIdsByType({ Name = "_PlayerUnit" })
	DebugAssert({ Condition = #heroIds <= 1, Text = "Too many _PlayerUnit objects on map!" })
	currentRun.Hero.ObjectId = heroIds[1]
	AttachLua({ Id = currentRun.Hero.ObjectId, Table = currentRun.Hero})

	AddToGroup({ Id = currentRun.Hero.ObjectId, Name = "HeroTeam" })

	GatherAndEquipWeapons( currentRun )

	-- Laurel Crown VFX
	if currentRun.Hero.AttachedAnimationName ~= nil then
		CreateAnimation({ Name = currentRun.Hero.AttachedAnimationName, DestinationId = currentRun.Hero.ObjectId })
	end

	-- Hero Light
	if currentRun.Hero.AttachedLightName ~= nil and not currentRun.CurrentRoom.BlockHeroLight then
		local heroGroup = GetGroupName({ Id = currentRun.Hero.ObjectId, DrawGroup = true })
		local heroLightGroup = "HeroLight"
		local heroLightId = SpawnObstacle({ Name = currentRun.Hero.AttachedLightName, DestinationId = currentRun.Hero.ObjectId, Group = heroLightGroup })
		InsertGroupBehind({ Name = heroLightGroup, DestinationName = heroGroup })
		SetScale({ Id = heroLightId, Fraction = currentRun.Hero.AttachedLightScale })
		SetColor({ Id = heroLightId, Color = currentRun.Hero.AttachedLightColor })
		Attach({ Id = heroLightId, DestinationId = currentRun.Hero.ObjectId })
		currentRun.Hero.AttachedLightId = heroLightId
	end

	-- Clear per-room state dictionaries
	CurrentRun.Hero.InvulnerableFlags = {}
	CurrentRun.InvulnerableFlags = {}
	CurrentRun.PhasingFlags = {}

	-- Easy mode Check
	if ConfigOptionCache.EasyMode then
		if not HeroHasTrait( "GodModeTrait") then
			AddTraitToHero({ TraitName = "GodModeTrait", SkipUIUpdate = true })
		end
	else
		RemoveTrait( currentRun.Hero, "GodModeTrait" )
	end
	-- Build all upgrades.
	UpdateHeroTraitDictionary()
	ApplyMetaUpgrades( currentRun.Hero, applyLuaUpgrades )
	ApplyTraitAutoRamp( currentRun.Hero )
	ApplyTraitUpgrade( currentRun.Hero, applyLuaUpgrades )
	ApplyTraitSetupFunctions( currentRun.Hero )
	ApplyMetaModifierHeroUpgrades( currentRun.Hero, applyLuaUpgrades )
	ApplyAllTraitWeapons( currentRun.Hero )

	for k, trait in pairs( currentRun.Hero.Traits ) do
		if trait.RoomCooldown ~= nil then
			IncrementTraitCooldown( trait )
		end
		if trait.TimeCooldown ~= nil then
			IncrementTraitCooldown( trait, trait.TimeCooldown)
		end
	end
	-- Completes setup
	SetHeroProperties( currentRun )

	currentRun.Hero.PlayingVoiceLines = false
	currentRun.Hero.QueuedVoiceLines = {}
	currentRun.Hero.LastKillTime = nil
	currentRun.Hero.StatusAnimation = nil
	currentRun.Hero.PrevStatusAnimation = nil
	currentRun.Hero.BlockStatusAnimations = nil
	currentRun.Hero.FreezeInputKeys = {}
	currentRun.Hero.DisableCombatControlsKeys = {}
	currentRun.Hero.ActiveEffects = {}
	currentRun.Hero.Frozen = false
	currentRun.Hero.Mute = false
	currentRun.Hero.Reloading = false
	currentRun.Hero.KillStealVictimId = nil
	currentRun.Hero.KillStolenFromId = nil
	currentRun.Hero.ComboCount = 0
	currentRun.Hero.ComboReady = false
	currentRun.Hero.VacuumRush = false
	currentRun.Hero.WeaponSpawns = nil

	SetLightBarColor({ PlayerIndex = 1, Color = currentRun.Hero.LightBarColor or HeroData.DefaultHero.LightBarColor });

end

function GetEncounterBinks( currentEncounter, binksToPreload, preloadedEnemyTypes )
	if currentEncounter == nil then
		return
	end

	if currentEncounter.EnemySet and currentEncounter.LoadBinksFromEnemySet then
		for k, enemyName in pairs( currentEncounter.EnemySet ) do
			local enemy = EnemyData[enemyName]
			if enemy ~= nil and preloadedEnemyTypes[enemyName] == nil then
				if enemy.Binks ~= nil then
					for i, binkName in ipairs( enemy.Binks ) do
						table.insert( binksToPreload, binkName )
					end
				end
				if enemy.OnDeathSpawnEncounter ~= nil then
					local deathSpawnEncounter = EncounterData[enemy.OnDeathSpawnEncounter]
					GetEncounterBinks( deathSpawnEncounter, binksToPreload, preloadedEnemyTypes )
				end
				preloadedEnemyTypes[enemyName] = true
			end
		end
	end

	if currentEncounter.SpawnWaves ~= nil then
		for waveIndex, wave in pairs( currentEncounter.SpawnWaves ) do
			for k, spawnEnemyArgs in pairs( wave.Spawns ) do
				local enemyName = spawnEnemyArgs.Name or k or "?"
				local enemy = EnemyData[enemyName]
				if enemy ~= nil and preloadedEnemyTypes[enemyName] == nil then
					if enemy.Binks ~= nil then
						for i, binkName in ipairs( enemy.Binks ) do
							table.insert( binksToPreload, binkName )
						end
					end
					if enemy.OnDeathSpawnEncounter ~= nil then
						local deathSpawnEncounter = EncounterData[enemy.OnDeathSpawnEncounter]
						GetEncounterBinks( deathSpawnEncounter, binksToPreload, preloadedEnemyTypes )
					end
					preloadedEnemyTypes[enemyName] = true
				end
			end
		end
	end
	if currentEncounter.Spawns ~= nil then
		for index, spawnInfo in pairs( currentEncounter.Spawns ) do
			local enemyData = EnemyData[spawnInfo.Name]
			if enemyData ~= nil and preloadedEnemyTypes[enemyData.Name] == nil then
				if enemyData.Binks ~= nil then
					for i, binkName in ipairs( enemyData.Binks ) do
						table.insert( binksToPreload, binkName )
					end
				end
				if enemyData.OnDeathSpawnEncounter ~= nil then
					local deathSpawnEncounter = EncounterData[enemy.OnDeathSpawnEncounter]
					GetEncounterBinks( deathSpawnEncounter, binksToPreload, preloadedEnemyTypes )
				end
				preloadedEnemyTypes[enemyData.Name] = true
			end
		end
	end
end

function StartRoomPreLoadBinks( args )

	local currentRun = args.Run
	local room = args.Room
	local currentEncounter = args.Encounter
	local challengeEncounter = args.ChallengeEncounter

	local binksToPreload = ShallowCopyTable( currentRun.Hero.Binks )
	local weaponBinksToPreload = ShallowCopyTable( currentRun.Hero.WeaponBinks )
	local preloadedEnemyTypes = {}
	local enemyName = nil

	--DebugPrint({ Text = "Preloading binks for encounter:"..currentEncounter.Name })

	-- Enemy binks
	GetEncounterBinks( currentEncounter, binksToPreload, preloadedEnemyTypes )
	GetEncounterBinks( challengeEncounter, binksToPreload, preloadedEnemyTypes )

	-- Zagreus weapon binks
	for weaponName, equipped in pairs( currentRun.Hero.Weapons ) do
		if preloadedEnemyTypes[weaponName] == nil then
			local weaponData = GetWeaponData( currentRun.Hero, weaponName )
			local heroWeaponSetData = WeaponSets.HeroWeaponSets[weaponName]
			if equipped and weaponData ~= nil and weaponData.Binks ~= nil then
				for i, binkName in ipairs(weaponData.Binks) do
					if not Contains( binksToPreload, binkName ) then
						table.insert(binksToPreload, binkName)
					end
				end
			end
			if equipped and weaponData ~= nil and weaponData.WeaponBinks ~= nil then
				for i, binkName in ipairs(weaponData.WeaponBinks) do
					if not Contains( weaponBinksToPreload, binkName ) then
						table.insert(weaponBinksToPreload, binkName)
					end
				end
			end
			preloadedEnemyTypes[weaponName] = true
		end
	end
	for i, data in pairs( currentRun.Hero.Traits ) do
		if data ~= nil and data.Binks ~= nil then
			for j, binkName in ipairs(data.Binks) do
				if not Contains( binksToPreload, binkName ) then
					table.insert( binksToPreload, binkName )
				end
			end
		end
	end

	if currentEncounter ~= nil and currentEncounter.Binks ~= nil then
		for j, binkName in ipairs(currentEncounter.Binks) do
			if not Contains( binksToPreload, binkName ) then
				table.insert( binksToPreload, binkName )
			end
		end
	end

	if room ~= nil and room.Binks ~= nil then
		for j, binkName in ipairs(room.Binks) do
			if not Contains( binksToPreload, binkName ) then
				table.insert( binksToPreload, binkName )
			end
		end
	end

	local dedupe = {}
	local finalBinksToPreload = {}
	for i, name in ipairs(binksToPreload) do
		if dedupe[name] == nil then
			dedupe[name] = name
			table.insert(finalBinksToPreload, name)
		end
	end

	dedupe = {}
	local finalWeaponBinksToPreload = {}
	for i, name in ipairs(weaponBinksToPreload) do
		if dedupe[name] == nil then
			dedupe[name] = name
			table.insert(finalWeaponBinksToPreload, name)
		end
	end

	-- for i, name in pairs(finalBinksToPreload) do
	-- 	DebugPrint({ Text = "preload: "..name })
	-- end
	-- for i, name in pairs(finalWeaponBinksToPreload) do
	-- 	DebugPrint({ Text = "WEP preload: "..name })
	-- end

	PreLoadBinks({ Names = finalBinksToPreload })
	if room ~= nil and room.SkipWeaponBinkPreLoading then
		DebugPrint({ Text = "StartRoomPreLoadBinks: Skip preloading weapon binks in "..room.Name })
	else
		PreLoadBinks({ Names = finalWeaponBinksToPreload, Cache = "WeaponCache" })
	end
end

function BeginThanatosEncounter()
	StartEncounterEffects( CurrentRun )
end

function BeginPerfectClearEncounter()
	StartEncounterEffects( CurrentRun )
end

function BeginSurvivalEncounter()
	StartEncounterEffects( CurrentRun )
end

function BeginWrappingEncounter()
	StartEncounterEffects( CurrentRun )
end

function StartEncounter( currentRun, currentRoom, currentEncounter )

	if CurrentRun.CurrentRoom.Encounter.EncounterType ~= "NonCombat" then
		ShowSuperMeter()
		if CurrentRun.CurrentRoom.Encounter == currentEncounter and currentEncounter ~= currentRoom.ChallengeEncounter and not CurrentRun.CurrentRoom.Encounter.DelayedStart then
			StartEncounterEffects( currentRun )
		end
	end

	if currentEncounter.DifficultyRating ~= nil and currentEncounter.EncounterType == "Default" then
		DebugPrint({ Text = currentEncounter.Name })
		DebugPrint({ Text = "    Encounter Difficulty = "..currentEncounter.DifficultyRating })
		for waveIndex, wave in pairs(currentEncounter.SpawnWaves) do
			DebugPrint({ Text = "        Wave #"..waveIndex })
			if wave.DifficultyRating ~= nil then
				DebugPrint({ Text = "        Wave Difficulty = "..wave.DifficultyRating })
			end

			for k, spawnEnemyArgs in pairs(wave.Spawns) do
				local enemyName = spawnEnemyArgs.Name or k or "?"
				local enemyCount = spawnEnemyArgs.TotalCount or spawnEnemyArgs.CountMax or "?"
				DebugPrint({ Text = "            "..enemyName.." "..enemyCount })
			end
		end
	end

	currentEncounter.Completed = false
	currentEncounter.InProgress = true
	if currentEncounter.TimerBlock ~= nil then
		AddTimerBlock( currentRun, currentEncounter.TimerBlock )
	end
	if CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth <= HealthUI.LowHealthThreshold and not currentRoom.HideLowHealthShroud then
		HeroDamageLowHealthPresentation( true )
	end
	if CurrentRun.CurrentRoom.Encounter == currentEncounter and currentEncounter ~= currentRoom.ChallengeEncounter then
		local goldPerRoom = round( GetTotalHeroTraitValue("MoneyPerRoom") )
		if HasHeroTraitValue( "BlockMoney" ) then
			goldPerRoom = 0
		end
		if goldPerRoom > 0 then
			if not CurrentRun.CurrentRoom.HideEncounterText then
				thread( PassiveGoldGainPresentation, goldPerRoom )
			end
			AddMoney( goldPerRoom, "Hermes Money Trait" )
		end
	end

	StartTriggers( currentEncounter, currentEncounter.DistanceTriggers )

	if currentEncounter.UnthreadedEvents == nil then
		-- Event set for hand made encounters
		currentEncounter.UnthreadedEvents = EncounterSets.EncounterEventsDefault
	end
	RunEvents( currentEncounter )

	StartTriggers( currentEncounter, currentEncounter.PostCombatDistanceTriggers )

	currentEncounter.Completed = true
	currentRun.EncountersCompletedCache[currentEncounter.Name] = (currentRun.EncountersCompletedCache[currentEncounter.Name] or 0) + 1
	GameState.EncountersCompletedCache[currentEncounter.Name] = (GameState.EncountersCompletedCache[currentEncounter.Name] or 0) + 1

	-- Check for encounter-end effects
	if currentEncounter and currentEncounter.StartTime and not currentEncounter.ClearTime then
		currentEncounter.ClearTime = _worldTime - currentEncounter.StartTime
	end
	EndEncounterEffects( currentRun, currentRoom, currentEncounter )
	if not currentEncounter.SkipDisableTrapsOnEnd then
		DisableRoomTraps()
	end

	if currentEncounter ~= nil and currentEncounter.RemoveUpgradeOnEnd ~= nil then
		RemoveEnemyUpgrade(currentEncounter.RemoveUpgradeOnEnd, CurrentRun)
	end

	-- Check for encoutner complete exit
	wait( 0.2, RoomThreadName )
	if CheckRoomExitsReady( currentRoom ) then
		UnlockRoomExits( currentRun, currentRoom )
	end

end

function GiveRandomConsumablesSource( source, args )
	GiveRandomConsumables( args )
end

function GiveRandomConsumables( args )
	args = args or {}
	wait( args.Delay, RoomThreadName )

	local multiplier = args.LootMultiplier or 1
	local range = args.Range or 150
	local minForce = args.MinForce or 75
	local maxForce = args.MaxForce or 150
	local destinationId = args.DestinationId or CurrentRun.Hero.ObjectId
	for i, lootData in pairs(args.LootOptions) do
		if lootData.Chance ~= nil and RandomChance(lootData.Chance * multiplier) then
			local consumableId = SpawnObstacle({ Name = lootData.Name, DestinationId = destinationId, Group = "Standing", OffsetX = RandomFloat(-1 * range, range), OffsetY = RandomFloat(-1 * range, range), ForceToValidLocation = true })
			local consumable = CreateConsumableItem( consumableId, lootData.Name, 0 )
			if lootData.Overrides ~= nil then
				for key, value in pairs( lootData.Overrides ) do
					if consumable[key] ~= nil then
						consumable[key] = value
					end
				end
			end
			ApplyConsumableItemResourceMultiplier( {}, consumable )
			ExtractValues( CurrentRun.Hero, consumable, consumable )
			if not args.NotRequiredPickup then
				ActivatedObjects[consumable.ObjectId] = consumable
			end
			ApplyUpwardForce({ Id = consumableId, Speed = RandomFloat( 500, 700 ) })
			ApplyForce({ Id = consumableId, Speed = RandomFloat( minForce, maxForce ), Angle = RandomFloat( 0, 360 ), SelfApplied = true })
			SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = consumable.ObjectId })

		elseif lootData.MinAmount ~= nil and lootData.MaxAmount ~= nil then
			local amount = RandomInt(lootData.MinAmount * multiplier , lootData.MaxAmount * multiplier)
			if lootData.Name == "Money" then
				thread( GushMoney, { Amount = amount, LocationId = destinationId, Source = "GiveRandomConsumables" } )
			else
				for i = 1, amount do
					local consumableId = SpawnObstacle({ Name = lootData.Name, DestinationId = destinationId, Group = "Standing", OffsetX = RandomFloat(-1 * range, range), OffsetY = RandomFloat(-1 * range, range), ForceToValidLocation = true })
					local consumable = CreateConsumableItem( consumableId, lootData.Name, 0 )
					if lootData.Overrides ~= nil then
						for key, value in pairs( lootData.Overrides ) do
							if consumable[key] ~= nil then
								consumable[key] = value
							end
						end						
						-- To match CreateConsumableItemFromData multipliers
						if consumable.AddResources ~= nil and consumable.AddResources.MetaPoints ~= nil then
							consumable.AddResources.MetaPoints = round( consumable.AddResources.MetaPoints * CalculateMetaPointMultiplier() )
						end
						if consumable.AddResources ~= nil and consumable.AddResources.Gems ~= nil then
							consumable.AddResources.Gems = round( consumable.AddResources.Gems * GetTotalHeroTraitValue( "GemMultiplier", { IsMultiplier = true } ))
						end
					end
					ApplyConsumableItemResourceMultiplier( {}, consumable )
					ExtractValues( CurrentRun.Hero, consumable, consumable )
					if not args.NotRequiredPickup then
						ActivatedObjects[consumable.ObjectId] = consumable
					end
					ApplyUpwardForce({ Id = consumableId, Speed = RandomFloat( args.UpwardForceMin or 500, args.UpwardForceMax or 700 ) })
					ApplyForce({ Id = consumableId, Speed = RandomFloat( args.ForceMin or 75, args.ForceMax or 150 ), Angle = RandomFloat( 0, 360 ), SelfApplied = true })
					SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = consumable.ObjectId })
				end
			end
		end
	end
end

function GiveLoot( args )
	local lootData = ChooseLoot( { args.ExcludeLootName }, args.ForceLootName )
	if lootData ~= nil then
		if not args.BoughtFromShop then
			for k, trait in pairs( CurrentRun.Hero.Traits ) do
				if trait.ForceBoonName == lootData.Name then
					trait.Uses = trait.Uses - 1
				end
			end
		end
		local loot = CreateLoot(MergeTables({ Name = lootData.Name }, args))
        return loot
	end
end

function CreateStackLoot( args )
	args = args or {}
	if args.StackNum == nil then
		args.StackNum = 1
	end
	if CurrentRun ~= nil and CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.StackNumOverride then
		args.StackNum = CurrentRun.CurrentRoom.StackNumOverride
	end
	return CreateLoot( MergeTables( args, { Name = "StackUpgrade" } ) )
end

function CreateWeaponLoot( args )
	args = args or {}
	return CreateLoot( MergeTables( args, { Name = "WeaponUpgrade" } ) )
end

function CreateHermesLoot( args )
	args = args or {}
	return CreateLoot( MergeTables( args, { Name = "HermesUpgrade" } ) )
end

function IsRarityForcedCommon( name )
	if CurrentRun.CurrentRoom.ForceCommonLootFirstRun and GetCompletedRuns() == 0 then
		return true
	end

	local referencedTable = "BoonData"
	if name == "StackUpgrade" then
		referencedTable = "StackData"
	elseif name == "WeaponUpgrade" then
		referencedTable = "WeaponData"
	end

	if CurrentRun.Hero[referencedTable] ~= nil and CurrentRun.Hero[referencedTable].AllowRarityOverride and CurrentRun.CurrentRoom.BoonRaritiesOverride then
		return false
	end

	if CurrentRun.Hero[referencedTable] == nil or CurrentRun.Hero[referencedTable].ForceCommon then
		return true
	end

	return false
end

function GetRarityChances( args )
	local name = args.Name
	local ignoreTempRarityBonus = args.IgnoreTempRarityBonus
	local referencedTable = "BoonData"
	if name == "StackUpgrade" then
		referencedTable = "StackData"
	elseif name == "WeaponUpgrade" then
		referencedTable = "WeaponData"
	elseif name == "HermesUpgrade" then
		referencedTable = "HermesData"
	end

	local legendaryRoll = CurrentRun.Hero[referencedTable].LegendaryChance or 0
	local heroicRoll = CurrentRun.Hero[referencedTable].HeroicChance or 0
	local epicRoll = CurrentRun.Hero[referencedTable].EpicChance or 0
	local rareRoll = CurrentRun.Hero[referencedTable].RareChance or 0

	if CurrentRun.CurrentRoom.BoonRaritiesOverride then
		legendaryRoll = CurrentRun.CurrentRoom.BoonRaritiesOverride.LegendaryChance or legendaryRoll
		heroicRoll = CurrentRun.CurrentRoom.BoonRaritiesOverride.HeroicChance or heroicRoll
		epicRoll = CurrentRun.CurrentRoom.BoonRaritiesOverride.EpicChance or epicRoll
		rareRoll =  CurrentRun.CurrentRoom.BoonRaritiesOverride.RareChance or rareRoll
	elseif args.BoonRaritiesOverride then
		legendaryRoll = args.BoonRaritiesOverride.LegendaryChance or legendaryRoll
		heroicRoll = args.BoonRaritiesOverride.HeroicChance or heroicRoll
		epicRoll = args.BoonRaritiesOverride.EpicChance or epicRoll
		rareRoll =  args.BoonRaritiesOverride.RareChance or rareRoll
	end

	local metaupgradeRareBoost = GetNumMetaUpgrades( "RareBoonDropMetaUpgrade" ) * ( MetaUpgradeData.RareBoonDropMetaUpgrade.ChangeValue - 1 )
	local metaupgradeEpicBoost = GetNumMetaUpgrades( "EpicBoonDropMetaUpgrade" ) * ( MetaUpgradeData.EpicBoonDropMetaUpgrade.ChangeValue - 1 ) + GetNumMetaUpgrades( "EpicHeroicBoonMetaUpgrade" ) * ( MetaUpgradeData.EpicBoonDropMetaUpgrade.ChangeValue - 1 )
	local metaupgradeLegendaryBoost = GetNumMetaUpgrades( "DuoRarityBoonDropMetaUpgrade" ) * ( MetaUpgradeData.EpicBoonDropMetaUpgrade.ChangeValue - 1 )
	local metaupgradeHeroicBoost = GetNumMetaUpgrades( "EpicHeroicBoonMetaUpgrade" ) * ( MetaUpgradeData.EpicBoonDropMetaUpgrade.ChangeValue - 1 )
	legendaryRoll = legendaryRoll + metaupgradeLegendaryBoost
	heroicRoll = heroicRoll + metaupgradeHeroicBoost
	rareRoll = rareRoll + metaupgradeRareBoost
	epicRoll = epicRoll + metaupgradeEpicBoost

	local rarityTraits = GetHeroTraitValues("RarityBonus", { UnlimitedOnly = ignoreTempRarityBonus })
	for i, rarityTraitData in pairs(rarityTraits) do
		if rarityTraitData.RequiredGod == nil or rarityTraitData.RequiredGod == name then
			if rarityTraitData.RareBonus then
				rareRoll = rareRoll + rarityTraitData.RareBonus
			end
			if rarityTraitData.EpicBonus then
				epicRoll = epicRoll + rarityTraitData.EpicBonus
			end
			if rarityTraitData.HeroicBonus then
				heroicRoll = heroicRoll + rarityTraitData.HeroicBonus
			end
			if rarityTraitData.LegendaryBonus then
				legendaryRoll = legendaryRoll + rarityTraitData.LegendaryBonus
			end
		end
	end
	return
	{
		Rare = rareRoll,
		Epic = epicRoll,
		Heroic = heroicRoll,
		Legendary = legendaryRoll,
	}
end

function AllAtLeastRarity( loot, baseRarity )
	if IsEmpty(loot.UpgradeOptions) then
		return false
	end
	for i, traitData in pairs( loot.UpgradeOptions ) do
		if GetRarityValue( traitData.Rarity ) < GetRarityValue( baseRarity ) then
			return false
		end
	end
	return true
end

function HasAtLeastRarity( loot, baseRarity )
	if IsEmpty(loot.UpgradeOptions) then
		return false
	end
	for i, traitData in pairs( loot.UpgradeOptions ) do
		if GetRarityValue( traitData.Rarity ) >= GetRarityValue( baseRarity ) then
			return true
		end
	end
	return false
end

function HasTraitOnLoot( loot, traitName )
	for i, traitData in pairs( loot.UpgradeOptions ) do
		if traitData.ItemName == traitName then
			return true
		end
	end
	return false
end

function HasExchangeOnLoot( loot )
	if loot == nil or loot.UpgradeOptions == nil then
		return
	end
	for i, traitData in pairs( loot.UpgradeOptions ) do
		if traitData.TraitToReplace ~= nil then
			return true
		end
	end
	return false
end

function HasTraitsOnLoot( loot, traitNames )
	if loot == nil or loot.UpgradeOptions == nil then
		return false
	end
	for i, traitData in pairs( loot.UpgradeOptions ) do
		if Contains(traitNames, traitData.ItemName) then
			return true
		end
	end
	return false
end

function CreateLoot( args )

	RandomSynchronize()
	local lootPoint = args.SpawnPoint or SelectLootSpawnPoint(CurrentRun.CurrentRoom)
	if lootPoint == nil then
		DebugAssert({ Text = "GiveLoot: trying to give loot but there are no eligible LootPoint objects in room." })
	end
	local lootData = args.LootData or LootData[args.Name]
	local loot = DeepCopyTable( lootData )
	local lootId = SpawnObstacle({ Name = lootData.Name, DestinationId = lootPoint, Group = "Standing", OffsetX = args.OffsetX, OffsetY = args.OffsetY })
	loot.ObjectId = lootId
	loot.BlockExitText = "ExitBlockedByBoon"
	loot.BoughtFromShop = args.BoughtFromShop
	loot.StackNum = args.StackNum
	loot.ExchangeOnlyFromLootName = args.ExchangeOnlyFromLootName

	if args.AddBoostedAnimation then
		CreateAnimation({ DestinationId = loot.ObjectId, Name = "RoomRewardAvailableRareSparkles" })
	end
	if args.SuppressFlares then
		StopAnimation({ DestinationId = loot.ObjectId, Names = { "BoonOrbSpawn", "BoonOrbSpawn2", "PickupFlare", "PickupFlareA", "PickupFlareA2", "PickupFlareB01", "PickupFlareB02" }, })
	end

	if IsRarityForcedCommon( args.Name ) or args.ForceCommon then
		loot.RarityChances = {}
		loot.ForceCommon = true
	else
		loot.IgnoreTempRarityBonus = args.IgnoreTempRarityBonus
		loot.BoonRaritiesOverride = ShallowCopyTable( args.BoonRaritiesOverride )
		loot.RarityChances = GetRarityChances( loot )
		if not args.IgnoreTempRarityBonus then
			loot.RarityBoosted = true
		end
	end

	SetTraitsOnLoot( loot )

	AddToGroup({ Id = lootId, Name = "Loot" })
	loot.MenuNotify = UIData.BoonMenuId
	if not args.DoesNotBlockExit then
		ActivatedObjects[lootId] = loot
	end
	LootObjects[lootId] = loot

	local lootId = loot.ObjectId
	AttachLua({ Id = lootId, Table = loot })
	SetColor({ Id = lootId, Color = loot.LootColor, Duration = 0 })
	if not args.SuppressSpawnSounds then
		thread( PlayRandomEligibleVoiceLines, { loot.OnSpawnVoiceLines, GlobalVoiceLines.LootGrantedVoiceLines } )
		PlaySound({ Name = loot.SpawnSound or "/Leftovers/SFX/AnnouncementPing4", Id = lootId })
	end

	if args.Cost ~= nil and args.Cost > 0 then
		loot.Cost = args.Cost
		local costMultiplier = 1 + ( GetNumMetaUpgrades( "ShopPricesShrineUpgrade" ) * ( MetaUpgradeData.ShopPricesShrineUpgrade.ChangeValue - 1 ) )
		costMultiplier = costMultiplier * GetTotalHeroTraitValue("StoreCostMultiplier", {IsMultiplier = true})
		if costMultiplier ~= 1 then
			loot.Cost = round( loot.Cost * costMultiplier )
		end
		UpdateCostText( loot )
	end
	return loot
end

function SelectLootSpawnPoint(currentRoom)
	if currentRoom.SpawnPoints.Loot == nil or IsEmpty(currentRoom.SpawnPoints.Loot) then
		currentRoom.SpawnPoints.Loot = GetIdsByType({ Name = "LootPoint" })
	end

	if currentRoom.SpawnPoints.Loot == nil or IsEmpty(currentRoom.SpawnPoints.Loot) then
		return SelectRoomRewardSpawnPoint( currentRoom )
	end

	return RemoveRandomValue(currentRoom.SpawnPoints.Loot)
end

function SelectRoomRewardSpawnPoint( currentRoom )
	if currentRoom.SpawnRewardOnId then
		return currentRoom.SpawnRewardOnId
	end

	local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = "SpawnPoints" })
	if spawnPointId <= 0 then
		if currentRoom.SpawnPoints.Loot == nil or IsEmpty(currentRoom.SpawnPoints.Loot) then
			currentRoom.SpawnPoints.Loot = GetIdsByType({ Name = "LootPoint" })
		end
		spawnPointId = RemoveRandomValue(currentRoom.SpawnPoints.Loot) or -1
	end
	DebugAssert({ Condition = spawnPointId > 0, Text = "No spawn point found for RoomReward!" })
	return spawnPointId
end

function CheckMoneyDrop( currentRun, currentRoom, enemy, moneyDropData )

	if enemy == nil or moneyDropData == nil then
		return
	end

	if enemy.CharacterInteraction ~= nil or enemy.CharacterInteractions ~= nil then
		return
	end

	if moneyDropData.Chance == nil or not RandomChance( moneyDropData.Chance ) then
		return
	end

	if HasHeroTraitValue( "BlockMoney" ) then
		return
	end

	local moneyMultiplier = GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } )
	for key, upgradeName in pairs( CurrentRun.EnemyUpgrades ) do
		local upgradeData = EnemyUpgradeData[upgradeName]
		if upgradeData.MoneyMultiplierDelta then
			moneyMultiplier = moneyMultiplier + (upgradeData.MoneyMultiplier - 1)
		end
	end

	local currentEncounter = currentRoom.Encounter
	if currentEncounter ~= nil and currentEncounter.MoneyDropStore and not moneyDropData.IgnoreRoomMoneyStore then
		if moneyDropData.MinParcels and moneyDropData.MaxParcels then
			local numDrops = RandomInt( moneyDropData.MinParcels, moneyDropData.MaxParcels )
			while( currentEncounter.MoneyDropStore > 0 and numDrops > 0 ) do
				local amount = RandomInt( moneyDropData.MinValue, moneyDropData.MaxValue ) or 1
				amount = amount * moneyMultiplier
				amount = round( amount )
				if amount <= 0 then
					amount = 1
				end
				DropMoney( amount, { LocationId = enemy.ObjectId, Radius = moneyDropData.Radius, Source = enemy.Name } )
				numDrops = numDrops - amount
				currentEncounter.MoneyDropStore = currentEncounter.MoneyDropStore - amount
				--DebugPrint({ Text = "Money Store: "..tostring( currentEncounter.MoneyDropStore ) })
				if currentEncounter.MoneyDropStore <= 0 then
					--DebugPrint({ Text = "Money Store Maxed!" })
				end
			end
		end
	else
		local numDropParcels = RandomInt( moneyDropData.MinParcels, moneyDropData.MaxParcels )
		for index = 1, numDropParcels, 1 do

			local amount = RandomInt( moneyDropData.MinValue, moneyDropData.MaxValue ) or 1
			amount = amount * moneyMultiplier
			amount = round( amount )

			DropMoney( amount, { LocationId = enemy.ObjectId, Radius = moneyDropData.Radius, Source = enemy.Name } )
			--DebugPrint({ Text = "Money Other: "..tostring( amount ) })
		end
	end
	if enemy.MoneyDropGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[enemy.MoneyDropGlobalVoiceLines], true )
	end

end

function GushConsumables( args )
	if args == nil then
		args = {}
	end

	local targetId = args.TargetId or CurrentRun.Hero.ObjectId
	local generatedSpawnId = nil
	if args.LocationId then
		generatedSpawnId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = targetId, Group = "Standing" })
		targetId = generatedSpawnId
	end

	for k = 1, args.Amount or 1 do
		local consumableId = SpawnObstacle({ Name = args.ConsumableName, DestinationId = targetId, Group = "Standing", ForceToValidLocation = true, })
		local consumable = CreateConsumableItem( consumableId, args.ConsumableName )
		ApplyUpwardForce({ Id = consumableId, Speed = args.UpwardSpeed or RandomFloat( args.UpwardSpeedMin or 500, args.UpwardSpeedMax or 700 ) })
		local speed = args.Speed or RandomFloat( 75, 560 )
		if args.MinSpeed and args.MaxSpeed then
			speed = RandomFloat( args.MinSpeed, args.MaxSpeed )
		end
		ApplyForce({ Id = consumableId, Speed = speed, Angle = args.Angle or RandomFloat( 0, 360 ), SelfApplied = true })
		wait( args.Interval )
	end

	if generatedSpawnId then
		Destroy({ Id = generatedSpawnId })
	end

end

function CheckAmmoDrop( currentRun, targetId, ammoDropData, numDrops )
	if ammoDropData == nil then
		return
	end

	if ammoDropData.Count == nil or ammoDropData.Count <= 0 or numDrops == 0 then
		return
	end

	if ammoDropData.Chance ~= nil and not RandomChance( ammoDropData.Chance ) then
		return
	end

	if ammoDropData.LocationX ~= nil then
		targetId = nil
	end

	if numDrops == nil then
		numDrops = ammoDropData.Count
	end

	local consumableName = "AmmoPack"
	for i = 1, numDrops do
		ammoDropData.Count = ammoDropData.Count - 1
	end

	if IsMetaUpgradeActive("ReloadAmmoMetaUpgrade") then
		return
	end

	for i = 1, numDrops do
		local offset = {}
		if ammoDropData.Angle ~= nil then
			offset = CalcOffset( math.rad(ammoDropData.Angle + 180), 48 )
		end
		local consumableId = SpawnObstacle({ Name = consumableName, DestinationId = targetId, LocationX = ammoDropData.LocationX, LocationY = ammoDropData.LocationY, OffsetX = offset.X, OffsetY = offset.Y, Group = "Standing" })
		local consumable = CreateConsumableItem( consumableId, consumableName )
		consumable.AddAmmo = 1
		ApplyUpwardForce({ Id = consumableId, Speed = RandomFloat( ammoDropData.UpwardForceMin or 500, ammoDropData.UpwardForceMax or 700 ) })
		if ammoDropData.ForceMax ~= nil then
			ApplyForce({ Id = consumableId, Speed = RandomFloat( ammoDropData.ForceMin, ammoDropData.ForceMax ), Angle = ammoDropData.Angle or RandomFloat( 0, 360 ), SelfApplied = true })
		end
		local delay = GetTotalHeroTraitValue("AmmoDropUseDelay")
		if delay > 0 then
			SetInteractProperty({ DestinationId = consumableId, Property = "Cooldown", Value = delay })
			thread( DoUseDelay, consumableId, delay )
		end

		for i, data in pairs(GetHeroTraitValues("AmmoFieldWeapon")) do
			thread( FireAmmoWeapon, consumableId, data )
		end
		thread( EscalateMagnetism, consumable )
	end
end

function DoUseDelay( id, delay )
	local fadeInTime = math.min( delay, 0.25 )
	SetAlpha({ Id = id, Fraction = 0.5, Duration = 0 })
	wait( delay - fadeInTime)
	SetAlpha({ Id = id, Fraction = 1, Duration = fadeInTime })
end

function EscalateMagnetism( consumable )

	if consumable.MagnetismEscalateDelay == nil then
		return
	end
	wait( consumable.MagnetismEscalateDelay - consumable.MagnetismHintRemainingTime , RoomThreadName )
	if not IsAlive({ Id = consumable.ObjectId }) then
		return
	end
	CreateAnimation({ Name = "AmmoReturnTimer", DestinationId = consumable.ObjectId })
	wait( consumable.MagnetismHintRemainingTime, RoomThreadName )
	SetObstacleProperty({ Property = "Magnetism", Value = consumable.MagnetismEscalateAmount, DestinationId = consumable.ObjectId })

end

function RecordObjectState( room, id, property, value )
	if room.ObjectStates == nil then
		room.ObjectStates = {}
	end
	if room.ObjectStates[id] == nil then
		room.ObjectStates[id] = {}
	end
	room.ObjectStates[id][property] = value
end

function RestoreObjectStates( room )

	if room.ObjectStates == nil then
		return
	end

	for id, objectState in pairs( room.ObjectStates ) do

		local unit = ActiveEnemies[id]
		if unit ~= nil then
			for property, value in pairs( objectState ) do
				unit[property] = value
			end
		end

		if objectState.Animation ~= nil then
			SetAnimation({ DestinationId = id, Name = objectState.Animation })
		end
		if objectState.FlipHorizontal then
			FlipHorizontal({ Id = id })
		end
		if objectState.Location ~= nil then
			Teleport({ Id = id, OffsetX = objectState.Location.X, OffsetY = objectState.Location.Y })
		end
		if objectState.Angle ~= nil then
			SetGoalAngle({ Id = id, Angle = objectState.Angle, CompleteAngle = true })
		end

		if objectState.Destroyed then
			SetThingProperty({ DestinationId = id, Property = "SuppressSounds", Value = true, DataValue = false })
			SetUnitProperty({ DestinationId = id, Property = "OnDeathWeapon", Value = nil, DataValue = true })
			Destroy({ Id = id })
		else
			if objectState.SwapData and ObstacleData[objectState.SwapData] then
				local newData = ObstacleData[objectState.SwapData]
				local newObject = DeepCopyTable( newData )
				newObject.ObjectId = id
				AttachLua({ Id = id, Table = newObject })
				if newObject.SpawnPropertyChanges ~= nil then
					ApplyUnitPropertyChanges( newObject, newObject.SpawnPropertyChanges, true )
				end
			end
		end

	end

end

function RandomizeBreakables( currentRoom )
	local breakableIds = GetIds({ Name = "Breakables" })
	for k, id in pairs( breakableIds ) do
		local breakableName = GetRandomValue(currentRoom.BreakableOptions)
		if type(breakableName) == "string" then
			SetAnimation({ DestinationId = id, Name = breakableName })
			RecordObjectState( currentRoom, id, "Animation", breakableName )
			if CoinFlip() then
				FlipHorizontal({ Id = id })
				RecordObjectState( currentRoom, id, "FlipHorizontal", true )
			end
		end
	end
end

function HandleBreakableSwap( currentRoom )
	local roomBreakableData = currentRoom.BreakableValueOptions
	local legalBreakables = FindAllSwappableBreakables()
	local highValueLimit = roomBreakableData.MaxHighValueBreakables or 1
	if IsEmpty( legalBreakables ) then
		return
	end
	if TableLength( legalBreakables ) < highValueLimit then
		highValueLimit = TableLength( legalBreakables )
	end

	local chanceMultiplier = 1.0
	for k, mutator in pairs( GameState.ActiveMutators ) do
		if mutator.BreakableChanceMultiplier ~= nil then
			chanceMultiplier = chanceMultiplier * mutator.BreakableChanceMultiplier
		end
	end

	for index = 0, highValueLimit, 1 do
		local breakableData = RemoveRandomValue( legalBreakables )
		if breakableData == nil then
			return
		end
		local valueOptions = breakableData.ValueOptions
		for k, swapOption in ipairs( valueOptions ) do
			if swapOption.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, swapOption, swapOption.GameStateRequirements ) then
				if RandomChance( swapOption.Chance * chanceMultiplier ) then
					SetAnimation({ DestinationId = breakableData.ObjectId, Name = swapOption.Animation, OffsetY = swapOption.OffsetY or 0 })
					RecordObjectState( currentRoom, breakableData.ObjectId, "Animation", swapOption.Animation )
					breakableData.MoneyDropOnDeath = swapOption.MoneyDropOnDeath
					RecordObjectState( currentRoom, breakableData.ObjectId, "MoneyDropOnDeath", breakableData.MoneyDropOnDeath )
					DebugPrint({ Text = "HandleBreakableSwap: an up-valued breakable has spawned somewhere in this room." })
					OverwriteTableKeys(breakableData, swapOption.DataOverrides)
					break
				end
			end
		end
	end
end

function FindAllSwappableBreakables()
	local legalBreakables = { }
	for id, enemy in pairs( ActiveEnemies ) do
		if enemy.ValueOptions ~= nil then
			legalBreakables[id] = enemy
		end
	end
	return legalBreakables
end

MoneyObjects = { }
function DropMoney( amount, args )
	if amount == nil then
		return
	end
	if args.LocationId == nil then
		args.LocationId = CurrentRun.Hero.ObjectId
	end
	args.Radius = args.Radius or 25
	local offset = CalcOffset( RandomFloat( 0, 360 ), args.Radius )
	if args.Offset ~= nil then
		offset.X = offset.X + args.Offset.X
		offset.Y = offset.Y + args.Offset.Y
	end
	if args.OffsetZ ~= nil then
		offset.Z = args.OffsetZ
	else
		offset.Z = 0
	end

	local moneySize = "MoneySmall"
	if amount < 10 then
		moneySize = "MoneySmall"
	elseif amount < 25 then
		moneySize = "MoneyMedium"
	else
		moneySize = "MoneyLarge"
	end
	local moneyDropId = SpawnObstacle({ Name = moneySize, DestinationId = args.LocationId, OffsetX = offset.X, OffsetY = offset.Y, OffsetZ = offset.Z, Group = "Standing", TriggerOnSpawn = false, })
	MoneyObjects[moneyDropId] = { Amount = amount, Source = args.Source }
	PlaySound({ Name = "/Leftovers/Menu Sounds/CoinFlash", Id = moneyDropId, ManagerCap = 28 })
end

OnUsed{ "Money MoneySmall MoneyMedium MoneyLarge",
	function( triggerArgs )
		if MoneyObjects[triggerArgs.triggeredById] == nil then
			DebugAssert({ Condition = false, "Picked up money with no source!" })
		end
		local money = MoneyObjects[triggerArgs.triggeredById]
		AddMoney( money.Amount, money.Source )
		MoneyObjects[triggerArgs.triggeredById] = nil
	end
}

function SpendMoney( amount, source )

	if amount == nil or amount <= 0 then
		return
	end

	CurrentRun.Money = CurrentRun.Money - amount
	CurrentRun.MoneySpent = CurrentRun.MoneySpent + amount

	CurrentRun.MoneyRecord[source] = (CurrentRun.MoneyRecord[source] or 0) - amount
	GameState.LifetimeResourcesSpent.Money = (GameState.LifetimeResourcesSpent.Money or 0) + amount
	CreateAnimation({ Name = "SpendMoneyFx", DestinationId = CurrentRun.Hero.ObjectId })
	thread( UpdateMoneyUI, CurrentRun.Money )

end

function ZeroSuperMeter()
	CurrentRun.Hero.SuperMeter = 0
	StopSuper()
end

function ZeroMoney()
	CurrentRun.Money = 0
	thread( UpdateMoneyUI, CurrentRun.Money )
end

function ClearUpgrades()
	CurrentRun.Hero.RecentTraits = {}
	CurrentRun.Hero.Traits = {}
	CurrentRun.Hero.OnFireWeapons = {}
	CurrentRun.Hero.OnSlamWeapons = {}
	CurrentRun.Hero.OnDamageWeapons = {}
	CurrentRun.Hero.OnKillWeapons = {}
	CurrentRun.Hero.LastStands = {}
	CurrentRun.Hero.WeaponDataOverride = nil

	if CurrentRun.Hero.OutgoingDamageModifiers ~= nil then
		for i, modifier in pairs( CurrentRun.Hero.OutgoingDamageModifiers ) do
			if modifier.Name and MetaUpgradeData[modifier.Name] == nil then
				CurrentRun.Hero.OutgoingDamageModifiers[i] = nil
			end
		end
	end
	UpdateNumHiddenTraits()
end

function AddMoney( amount, source )

	if amount == nil or round( amount ) <= 0 then
		return
	end
	amount = round( amount )

	if CurrentRun.Money == nil then
		CurrentRun.Money = 0
	end
	local sound = "/SFX/GoldCoinPickup"
	if HasHeroTraitValue("BlockMoney") then
		amount = 0
		sound = "/SFX/Player Sounds/DarknessCollectionPickupSMALL"
	end
	
	if not CurrentRun.CurrentRoom.HideGoldGainFx then
		PlaySound({ Name = sound, ManagerCap = 28 })
	end

	CurrentRun.Money = CurrentRun.Money + amount
	CurrentRun.MoneyRecord[source] = (CurrentRun.MoneyRecord[source] or 0) + amount
	GameState.LifetimeResourcesGained.Money = (GameState.LifetimeResourcesGained.Money or 0) + amount
	ShowResourceUIs({ CombatOnly = not CurrentRun.Hero.IsDead, UpdateIfShowing = true })
	UpdateMoneyUI( CurrentRun.Money )
end

function ProcessInterest( eventSource, args )
	if not IsMetaUpgradeActive("InterestMetaUpgrade") then
		return
	end
	args = args or {}
	local waitDelay = args.StartDelay or 0 
	local goldPerRoom = round( GetTotalHeroTraitValue("MoneyPerRoom") )
	if HasHeroTraitValue( "BlockMoney" ) then
		goldPerRoom = 0
	end
	if goldPerRoom > 0 then
		waitDelay = waitDelay + 0.5
	end
	wait( waitDelay)
	local interest = math.ceil(CurrentRun.Money * ( GetTotalMetaUpgradeChangeValue("InterestMetaUpgrade") - 1 ))
	AddMoney( interest, "InterestMetaupgrade")
	thread( InCombatText, CurrentRun.Hero.ObjectId, "InterestGainedCombatText", 1.5 , {  LuaKey = "TempTextData", LuaValue = { Amount = interest }})
end

function AddRerolls( amount, source, args )

	args = args or {}

	if args.Thread then
		args.Thread = false
		thread( AddRerolls, amount, source, args )
		return
	end
	wait( args.Delay )

	CurrentRun.NumRerolls = (CurrentRun.NumRerolls or 0) + amount
	if CurrentRun.NumRerolls > 0 then
		ShowResourceUIs({ CombatOnly = not CurrentRun.Hero.IsDead, UpdateIfShowing = true })
	end
	UpdateRerollUI( CurrentRun.NumRerolls )
	thread( PopOverheadText, { Amount = amount, Text = "RerollAmount", Color = Color.White } )
end

function OnMetaPointsAdded( name, amount, source, args )

	args = args or {}
	GameState.AccumulatedMetaPointsCache = GameState.LifetimeResourcesGained.MetaPoints or 0
	local healMultiplier = GetTotalHeroTraitValue("MetaPointHealMultiplier") + ( GetTotalMetaUpgradeChangeValue("DarknessHealMetaUpgrade") - 1 )
	healMultiplier = healMultiplier * CalculateHealingMultiplier() * GetTotalHeroTraitValue("MaxHealthMultiplier", { IsMultiplier = true })
	if healMultiplier > 0 and round( healMultiplier * amount ) > 0 then
		thread( DelayedHeal, 0.5,  round( healMultiplier * amount ), "MetaPointHeal" )
	end

end

function AddResource( name, amount, source, args )

	if amount == nil or amount == 0 then
		return
	end

	args = args or {}
	local resourceData = ResourceData[name]
	GameState.Resources[name] = (GameState.Resources[name] or 0) + round( amount )
	if not args.NoLifetimeEffect then
		GameState.LifetimeResourcesGained[name] = (GameState.LifetimeResourcesGained[name] or 0) + round( amount )
	end

	if resourceData ~= nil and resourceData.OnAddedFunctionName ~= nil then
		local onAddedFunction = _G[resourceData.OnAddedFunctionName]
		if onAddedFunction ~= nil then
			onAddedFunction( name, amount, source, args )
		end
	end

	ShowResourceUIs({ CombatOnly = not CurrentRun.Hero.IsDead, ForceShowName = name })
	UpdateResourceUI( name, GameState.Resources[name] )

	if not args.Silent then
		if not args.SkipOverheadText and ResourceData[name] and ResourceData[name].GainedText then
			local resourceColor = Color.White
			if ResourceData[name].Color then
				resourceColor = ResourceData[name].Color
			end
			thread( PopOverheadText, { Amount = amount, Text = ResourceData[name].GainedText, Color = resourceColor } )
		end
		thread( ResourceGainPresentation, name, amount )
	end
end

function SpendResource( name, amount, source, args )

	if GameState.Resources[name] == nil or GameState.Resources[name] < amount then
		return false
	end

	args = args or {}

	GameState.Resources[name] = (GameState.Resources[name] or 0) - round( amount )
	if not args.NoLifetimeEffect then
		GameState.LifetimeResourcesSpent[name] = (GameState.LifetimeResourcesSpent[name] or 0) + round( amount )
	end

	if not args.SkipUpdateResourceUI then
		ShowResourceUIs({ CombatOnly = not CurrentRun.Hero.IsDead, UpdateIfShowing = true })
		UpdateResourceUI( name, GameState.Resources[name] )
	end

	if not args.Silent then
		if not args.SkipOverheadText then
			local text = ResourceData[name].SpendText or "SpendGenericResource"
			local color = ResourceData[name].Color or Color.White

			thread( PopOverheadText, { Amount = amount, Text = text, Color = color } )
		end
		thread( ResourceGainPresentation, name, amount * -1 )
	end
	return true

end

function HasResource( name, amount )
	if amount == 0 then
		return true
	end
	amount = amount or 1
	if GameState.Resources[name] == nil or GameState.Resources[name] < amount then
		return false
	end
	return true
end

function HasResources( name, args )
	if not args then
		return true
	end
	DebugAssert({ Condition = ( type(args) == "table" ), Text = " Has Resources called with non-table value " .. tostring(args) })
	for resourceName, amount in pairs(args) do
		if not HasResource( resourceName, amount ) then
			return false
		end
	end
	return true
end

function OnGiftPointsAdded( name, amount, source, args )

	args = args or {}
	if amount > 0 then
		local healthGained = GetTotalHeroTraitValue("GiftPointHealthMultiplier")
		if healthGained > 0 then
			AddMaxHealth( healthGained, "DionysusMaxHealthTrait" )
		end
	end

	if not IsEmpty( ActiveEnemies ) then
		for id, unit in pairs( ActiveEnemies ) do
			if not unit.PostCombatTravel then
				SetAvailableUseText( unit )
			end
		end
	end
end

function AddMaxHealth( healthGained, source, args )
	args = args or {}
	if args.Thread then
		args.Thread = false
		thread( AddMaxHealth, healthGained, source, args )
		return
	end
	local startingHealth = CurrentRun.Hero.MaxHealth
	wait( args.Delay )
	healthGained = round(healthGained)
	local traitName = "RoomRewardMaxHealthTrait"
	if args.NoHealing then
		traitName = "RoomRewardEmptyMaxHealthTrait"
	end

	local healthTraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName })
	healthTraitData.PropertyChanges[1].ChangeValue = healthGained
	AddTraitToHero({ TraitData = healthTraitData })
	healthGained = round(healthGained * GetTotalHeroTraitValue("MaxHealthMultiplier", { IsMultiplier = true }))
	if not( args.Silent ) then
		MaxHealthIncreaseText({ MaxHealthGained = CurrentRun.Hero.MaxHealth - startingHealth , SpecialText = "MaxHealthIncrease" })
	end
end

function OnLockKeysAdded( name, amount, source, args )

	args = args or {}

	if amount > 0 then
		thread( UpdateWeaponKits )
		if not CurrentRun.Hero.IsDead and CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.ChallengeSwitch ~= nil then
			thread( UpdateLockedKeyPresentation, CurrentRun.CurrentRoom.ChallengeSwitch )
		end
	end

end

function StartEncounterEffects( currentRun )
	BuildSuperMeter( currentRun, GetTotalHeroTraitValue("StartingSuperAmount"))
	currentRun.CurrentRoom.Encounter.StartTime = _worldTime
	CurrentRun.Hero.HitShields = 0
	if not currentRun.CurrentRoom.BlockClearRewards then
		for i, traitData in pairs( currentRun.Hero.Traits) do
			if traitData.PerfectClearDamageBonus then
				PerfectClearTraitStartPresentation( traitData )
			end
			if traitData.FastClearDodgeBonus then
				SetupDodgeBonus( currentRun.CurrentRoom.Encounter, traitData )
			end
			if traitData.EncounterStartWeapon then
				FireWeaponFromUnit({ Weapon = traitData.EncounterStartWeapon, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
			end
			if traitData.GoldBonusDrop then
				TraitUIActivateTrait( traitData )
			end

			if traitData.BossEncounterShieldHits then
				if currentRun.CurrentRoom.Encounter.EncounterType == "Boss"  then
					CurrentRun.Hero.HitShields = traitData.BossEncounterShieldHits
					ApplyEffectFromWeapon({ WeaponName = "EurydiceDefenseApplicator", EffectName = "EurydiceDefenseEffect", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
					UpdateTraitNumber( traitData )
				end
			end
		end
	end
end

function EndEncounterEffects( currentRun, currentRoom, currentEncounter )
	if currentEncounter == nil or currentEncounter.EncounterType == "NonCombat" then
		return
	end
	
	CurrentRun.Hero.HeroTraitValuesCache = {}

	if currentEncounter == currentRoom.Encounter or currentEncounter == currentRoom.ChallengeEncounter then
		thread( PostEncounterDrainSuper )
		StopSuper()
		ClearEffect({ Id = currentRun.Hero.ObjectId, Name = "KillDamageBonus"})
		if currentRoom.DestroyAssistUnitOnEncounterEndId then
			local assistUnit = ActiveEnemies[currentRoom.DestroyAssistUnitOnEncounterEndId]
			if assistUnit ~= nil then
				Kill( assistUnit )
			end
		end
		if currentRoom.DestroyAssistProjectilesOnEncounterEnd then
			ExpireProjectiles({ Name = currentRoom.DestroyAssistProjectilesOnEncounterEnd })
		end

		if currentRoom.CodexUpdates then
			for category, categoryItems in pairs( currentRoom.CodexUpdates ) do
				for categoryItem, count in pairs( categoryItems ) do
					IncrementCodexValue( category, categoryItem, count )
					CheckCodexUnlock( category, categoryItem, true )
				end
			end
		end

		if currentRoom.PendingCodexUpdate then
			currentRoom.PendingCodexUpdate = false
			wait( 0.2, RoomThreadName )
			thread( ShowCodexUpdate )

		end
	end

	if currentEncounter == currentRoom.Encounter then

		local heroHealth = CurrentRun.Hero.Health
		local encounterHealAmount = GetTotalHeroTraitValue("CombatEncounterAbsoluteHeal")

		local healthFloor = round(GetNumMetaUpgrades("HealthEncounterEndRegenMetaUpgrade") * MetaUpgradeData.HealthEncounterEndRegenMetaUpgrade.ChangeValue + CurrentRun.Hero.MaxHealth * GetTotalHeroTraitValue("CombatEncounterHealthPercentFloor"))
		if (heroHealth + encounterHealAmount) < healthFloor then
			encounterHealAmount = healthFloor - heroHealth
		end
		Heal( CurrentRun.Hero, { HealAmount = encounterHealAmount, Name = "EncounterHeal" } )

		local traitsToRemove = {}
		for k, trait in pairs( currentRun.Hero.Traits ) do
			if trait.BossEncounterShieldHits then
				if currentRun.CurrentRoom.Encounter.EncounterType == "Boss"  then
					CurrentRun.Hero.HitShields = 0
					UpdateTraitNumber( trait )
				end
			end
			if trait.RemainingUses ~= nil and trait.UsesAsEncounters and (not trait.UsesRequireSpawnMultiplier or ( trait.UsesRequireSpawnMultiplier and not currentEncounter.BlockSpawnMultipliers )) then
				if trait.HoldRemainingRooms ~= nil and trait.HoldRemainingRooms > 0 then
					trait.HoldRemainingRooms = trait.HoldRemainingRooms - 1
				else
					trait.RemainingUses = trait.RemainingUses - 1
					if trait.RemainingUses <= 0 then
						table.insert( traitsToRemove, trait )
					end
				end
				TraitUIUpdateText( trait )
			end
			if trait.EncounterPreDamage and not IsEmpty(currentRoom.UsedPreDamageTraits) then
				for i, usedTrait in pairs( currentRoom.UsedPreDamageTraits ) do
					if AreTraitsIdentical( usedTrait, trait ) then
						trait.RemainingUses = trait.RemainingUses - 1
						if trait.RemainingUses <= 0 then
							table.insert( traitsToRemove, trait )
						end
						TraitUIUpdateText( trait )
						break
					end
				end
			end
		end
		if not currentRoom.BlockClearRewards then
			for k, traitData in pairs(currentRun.Hero.Traits) do
				if not currentEncounter.PlayerTookDamage and traitData.PerfectClearDamageBonus then
					traitData.AccumulatedDamageBonus = traitData.AccumulatedDamageBonus + (traitData.PerfectClearDamageBonus - 1)
					PerfectClearTraitSuccessPresentation( traitData )
					CurrentRun.CurrentRoom.PerfectEncounterCleared = true
					CheckAchievement( { Name = "AchBuffedButterfly", CurrentValue = traitData.AccumulatedDamageBonus } )
				end
				if traitData.FastClearThreshold then
					local clearTimeThreshold = currentEncounter.FastClearThreshold or traitData.FastClearThreshold
					if currentEncounter.ClearTime < clearTimeThreshold and traitData.FastClearDodgeBonus then
						local lastDodgeBonus = traitData.AccumulatedDodgeBonus
						SetLifeProperty({ Property = "DodgeChance", Value = -1 * lastDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
						SetUnitProperty({ Property = "Speed", Value = 1/( 1 + lastDodgeBonus ), ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
						traitData.AccumulatedDodgeBonus = traitData.AccumulatedDodgeBonus + traitData.FastClearDodgeBonus
						SetLifeProperty({ Property = "DodgeChance", Value = traitData.AccumulatedDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
						SetUnitProperty({ Property = "Speed", Value = 1 + traitData.AccumulatedDodgeBonus, ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
						thread( FastClearTraitSuccessPresentation, traitData )
						CheckAchievement( { Name = "AchBuffedPlume", CurrentValue = traitData.AccumulatedDodgeBonus } )
					end
				end
			end
		end

		for k, trait in pairs( traitsToRemove ) do
			RemoveTraitData( currentRun.Hero, trait )
		end
		AdvanceKeepsake()
		UpgradeHarvestBoon()
		UpgradeChamberStacks()
	end
end

function CheckOnRoomClearTraits( currentRun, currentRoom, currentEncounter )
	if not currentRoom.BlockClearRewards and not currentEncounter.ProcessedOnRoomClear then
		currentEncounter.ProcessedOnRoomClear = true
		for k, traitData in pairs(currentRun.Hero.Traits) do
			if not currentEncounter.PlayerTookDamage and traitData.PerfectClearDamageBonus then
				traitData.AccumulatedDamageBonus = traitData.AccumulatedDamageBonus + (traitData.PerfectClearDamageBonus - 1)
				PerfectClearTraitSuccessPresentation( traitData )
				CurrentRun.CurrentRoom.PerfectEncounterCleared = true
			end
			if traitData.FastClearThreshold then
				local clearTimeThreshold = currentEncounter.FastClearThreshold or traitData.FastClearThreshold
				if currentEncounter.ClearTime < clearTimeThreshold and traitData.FastClearDodgeBonus then
					local lastDodgeBonus = traitData.AccumulatedDodgeBonus
					SetLifeProperty({ Property = "DodgeChance", Value = -1 * lastDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
					SetUnitProperty({ Property = "Speed", Value = 1/( 1 + lastDodgeBonus ), ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
					traitData.AccumulatedDodgeBonus = traitData.AccumulatedDodgeBonus + traitData.FastClearDodgeBonus
					SetLifeProperty({ Property = "DodgeChance", Value = traitData.AccumulatedDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
					SetUnitProperty({ Property = "Speed", Value = 1 + traitData.AccumulatedDodgeBonus, ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
					thread( FastClearTraitSuccessPresentation, traitData )
				end
			end
		end
	end
end

function IsCombatEncounterActive( currentRun )
	if currentRun.CurrentRoom.AlwaysInCombat then
		return true
	end

	if not currentRun.Hero.IsDead then
		if HasTimerBlock( currentRun ) then
			local hasExcludedTimer = false
			for _, name in pairs( TimerBlockCombatExcludes ) do
				if currentRun.BlockTimerFlags[ name ] then
					hasExcludedTimer = true
				end
			end
			if not hasExcludedTimer then
				return false
			end
		end

		if currentRun.CurrentRoom.StartedChallengeEncounter and not currentRun.CurrentRoom.ChallengeEncounter.Completed then
			return true
		end

		local encounter = currentRun.CurrentRoom.Encounter
		if encounter ~= nil then
			if encounter.EncounterType == "NonCombat" then
				return false
			end
			if not encounter.InProgress then
				return false
			end
			if encounter.DelayedStart and not encounter.StartTime then
				return false
			end
			if not encounter.Completed then
				return true
			end
		end
	end
	return false
end

function CheckRoomExitsReady( currentRoom )

	if CurrentRun.Hero.IsDead then
		return
	end

	if not IsEmpty( ActivatedObjects ) then
		return false
	end

	if IsScreenOpen( "BoonMenu" ) then
		return false
	end

	if not currentRoom.Encounter.ExitsDontRequireCompleted and not currentRoom.Encounter.Completed then
		return false
	end

	return true

end

function GetRemainingSpawns( currentRun, currentRoom, currentEncounter )

	if currentRun.Hero.IsDead then
		return 0
	end

	if currentEncounter.Completed then
		return 0
	end

	if CheckCancelSpawns(currentRun, currentRoom, currentEncounter) then
		return 0
	end

	local remainingSpawns = 0
	if currentEncounter.Spawns ~= nil then
		for k, spawnInfo in pairs( currentEncounter.Spawns ) do
			if spawnInfo.RemainingSpawns == nil then
				-- Spawn totals have not been generated yet. Somewhat of an ambiguous case, unsure how to best handle yet.
				remainingSpawns = remainingSpawns + 1
			else
				remainingSpawns = remainingSpawns + spawnInfo.RemainingSpawns
			end
		end
	end
	return remainingSpawns

end

function CheckCancelSpawns( currentRun, currentRoom, currentEncounter )
	if currentEncounter.CancelSpawns then
		return true
	end

	if currentEncounter.CancelSpawnsOnKill ~= nil then
		for k, unitName in pairs(currentEncounter.CancelSpawnsOnKill) do
			if currentRoom.Kills ~= nil and currentRoom.Kills[unitName] ~= nil and currentRoom.Kills[unitName] >= 1 then
				return true
			end
		end
	end

	if currentEncounter.CancelSpawnsOnKillAll ~= nil then
		local remainingSpawns = 0
		for k, spawnInfo in pairs( currentEncounter.Spawns ) do
			if Contains(currentEncounter.CancelSpawnsOnKillAll, spawnInfo.Name) then
				local newRemainingSpawns = spawnInfo.RemainingSpawns or 1
				remainingSpawns = remainingSpawns + newRemainingSpawns
			end
		end
		if remainingSpawns == 0 then
			local killedAll = true
			for k, id in pairs(GetIdsByType({ Names = currentEncounter.CancelSpawnsOnKillAll })) do
				if ActiveEnemies[id] ~= nil and not ActiveEnemies[id].IsDead then
					killedAll = false
				end
			end
			if killedAll then
				return true
			end
		end
	end

	if currentEncounter.CancelSpawnsOnKillAllTypes ~= nil then
		local killCountGoal = TableLength(currentEncounter.CancelSpawnsOnKillAllTypes)
		local killCount = 0
		for k, unitName in pairs(currentEncounter.CancelSpawnsOnKillAllTypes) do
			if currentRoom.Kills ~= nil and currentRoom.Kills[unitName] ~= nil and currentRoom.Kills[unitName] >= 1 then
				killCount = killCount + 1
			end
		end

		if killCount >= killCountGoal then
			return true
		end
	end

	return false
end

function GetNextSpawn( currentEncounter )

	local forcedSpawn = nil
	local remainingSpawnInfo = {}
	local remainingPrioritySpawnInfo = {}
	for k, spawnInfo in orderedPairs( currentEncounter.Spawns ) do
		if spawnInfo.InfiniteSpawns or spawnInfo.RemainingSpawns > 0 then
			local enemyData = EnemyData[spawnInfo.Name]
			if enemyData ~= nil and enemyData.LargeUnitCap ~= nil and enemyData.LargeUnitCap > 0 then
				local largeUnitCount = 0
				-- @optimization Convert to buckets by type
				for enemyId, enemy in pairs( ActiveEnemies ) do
					if enemy.LargeUnitCap ~= nil and enemyData.LargeUnitCap > 0 then
						largeUnitCount = largeUnitCount + 1
					end
				end
				if largeUnitCount < enemyData.LargeUnitCap then
					table.insert( remainingSpawnInfo, spawnInfo )
					if spawnInfo.PrioritySpawn then
						table.insert( remainingPrioritySpawnInfo, spawnInfo )
					end
				else
					DebugPrint({ Text = "Avoiding LargeUnitCap: "..enemyData.Name })
				end
			else
				table.insert( remainingSpawnInfo, spawnInfo )
				if spawnInfo.PrioritySpawn then
					table.insert( remainingPrioritySpawnInfo, spawnInfo )
				end
			end

			if spawnInfo.ForceFirst then
				forcedSpawn = spawnInfo
			end
		end
	end

	if forcedSpawn ~= nil then
		return forcedSpawn
	end

	local randomSpawnInfo = GetRandomValue( remainingPrioritySpawnInfo ) or GetRandomValue( remainingSpawnInfo )
	return randomSpawnInfo

end

function ApplyEliteAttribute( enemy, attributeName )
	if enemy.EliteAttributeData == nil or enemy.EliteAttributeData[attributeName] == nil then
		DebugPrint({ Text=enemy.Name.." does not have the attribute "..attributeName.." defined!" })
		return
	end
	table.insert(enemy.EliteAttributes, attributeName)
	if enemy.IsClone and enemy.EliteAttributeData[attributeName].SkipApplyOnClones then
		return
	end

	local attributeData = enemy.EliteAttributeData[attributeName]
	local enemyAIData = enemy.DefaultAIData or enemy

	if attributeData.DataOverrides ~= nil then
		OverwriteTableKeys(enemy, attributeData.DataOverrides)
	end

	if attributeData.AIDataOverrides ~= nil then
		OverwriteTableKeys(enemyAIData, attributeData.AIDataOverrides)
	end

	if attributeData.AddWeaponOptions ~= nil then
		for k, weaponName in pairs(attributeData.AddWeaponOptions) do
			table.insert(enemy.WeaponOptions, weaponName)
		end
	end

	if attributeData.AddDumbFireWeaponsOnSpawn ~= nil then
		enemy.AddDumbFireWeaponsOnSpawn = enemy.AddDumbFireWeaponsOnSpawn or {}
		enemy.AddDumbFireWeaponsOnSpawn = CombineTables(enemy.AddDumbFireWeaponsOnSpawn, attributeData.AddDumbFireWeaponsOnSpawn)
	end

	if attributeData.AddEnemyOnDeathWeapons ~= nil then
		AddEnemyOnDeathWeapons( enemy, attributeData.AddEnemyOnDeathWeapons )
	end

	if attributeData.WeaponPropertyChanges ~= nil then
		for k, weaponName in pairs(enemy.WeaponOptions) do
			EquipWeapon({ DestinationId = enemy.ObjectId, Name = weaponName })
			ApplyWeaponPropertyChanges( enemy, weaponName, attributeData.WeaponPropertyChanges )
		end
	end
end

function PickEliteAttributes( currentRoom, enemy )

	if currentRoom.Encounter ~= nil and currentRoom.Encounter.BlockEliteAttributes then
		return
	end

	if enemy.EliteAttributeOptions == nil or IsEmpty(enemy.EliteAttributeOptions) then
		return
	end

	enemy.EliteAttributeCount = GetNumMetaUpgrades( "EnemyEliteShrineUpgrade" )
	local attributeOptions = {}
	for k, attributeName in pairs(enemy.EliteAttributeOptions) do
		if IsEliteAttributeEligible(enemy, attributeName) then
			table.insert(attributeOptions, attributeName)
		end
	end

	for i=1, enemy.EliteAttributeCount do
		if IsEmpty(attributeOptions) then
			DebugPrint({ Text="RunManager.lua:795 ".."Ran out of legal Elite Attribute options!" })
			break
		end
		local attributeName = RemoveRandomValue(attributeOptions)
		currentRoom.EliteAttributes[enemy.Name] = currentRoom.EliteAttributes[enemy.Name] or {}
		table.insert(currentRoom.EliteAttributes[enemy.Name], attributeName)
		RemoveAllValues(attributeOptions, attributeName)
		if enemy.EliteAttributeData[attributeName].BlockAttributes ~= nil then
			for k, blockedAttributeName in pairs(enemy.EliteAttributeData[attributeName].BlockAttributes) do
				RemoveAllValues(attributeOptions, blockedAttributeName)
			end
		end
	end

end

function IsEliteAttributeEligible( enemy, attributeName )
	local attributeRequirements = enemy.EliteAttributeData[attributeName].Requirements or enemy.EliteAttributeData[attributeName]

	if attributeRequirements.RequiresFalseSuperElite and enemy.IsSuperElite then
		return false
	end

	if Contains(CurrentRun.BannedEliteAttributes, attributeName) then
		return false
	end

	if Contains(enemy.BlockAttributes, attributeName) then
		return false
	end

	if not IsGameStateEligible(CurrentRun, enemy.EliteAttributeData[attributeName], attributeRequirements) then
		return false
	end

	return true
end

function SetupEnemyObject( newEnemy, currentRun, args )
	local currentRoom = currentRun.CurrentRoom
	local skipModifiers = newEnemy.SkipModifiers

	local shrineLevel = GetNumMetaUpgrades(newEnemy.ShrineMetaUpgradeName)
	local requiredShrineLevel = newEnemy.ShrineMetaUpgradeRequiredLevel or 1
	if newEnemy.ShrineDataOverwrites ~= nil and shrineLevel >= requiredShrineLevel then
		OverwriteTableKeys(newEnemy, newEnemy.ShrineDataOverwrites)
	end
	if newEnemy.ShrineDefualtAIDataOverwrites ~= nil and shrineLevel > 0 then
		if newEnemy.DefaultAIData == nil then
			newEnemy.DefaultAIData = {}
		end
		OverwriteTableKeys(newEnemy.DefaultAIData, newEnemy.ShrineDefualtAIDataOverwrites)
	end
	if newEnemy.ShrineWeaponOptionsOverwrite ~= nil and shrineLevel > 0 then
		newEnemy.WeaponOptions = newEnemy.ShrineWeaponOptionsOverwrite
	end

	newEnemy.WeaponHistory = newEnemy.WeaponHistory or {}

	if newEnemy.WeaponOptions ~= nil and not newEnemy.SkipSetupSelectWeapon then
		newEnemy.WeaponName = SelectWeapon( newEnemy )
		EquipWeapon({ Name = newEnemy.WeaponName, DestinationId = newEnemy.ObjectId })
	end
	if newEnemy.OnHitWeapons ~= nil then
		for k, weaponName in pairs(newEnemy.OnHitWeapons) do
			EquipWeapon({ Name = weaponName, DestinationId = newEnemy.ObjectId })
		end
	end

	if newEnemy.IsElite then
		newEnemy.EliteAttributes = newEnemy.EliteAttributes or {}
		--[[if currentRoom.EliteAttributes[newEnemy.Name] == nil then
			PickEliteAttributes( currentRoom, newEnemy )
		end]]
		if currentRoom.EliteAttributes[newEnemy.Name] ~= nil then
			for k, attributeName in pairs(currentRoom.EliteAttributes[newEnemy.Name]) do
				ApplyEliteAttribute(newEnemy, attributeName)
			end
		end
	end

	if newEnemy.AddDumbFireWeaponsOnSpawn ~= nil then
		for k, weaponName in pairs( newEnemy.AddDumbFireWeaponsOnSpawn ) do
			newEnemy.DumbFireWeapons = newEnemy.DumbFireWeapons or {}
			EquipWeapon({ Name = weaponName, DestinationId = newEnemy.ObjectId })
			table.insert( newEnemy.DumbFireWeapons, weaponName )
		end
	end

	newEnemy.Groups = newEnemy.Groups or {}
	table.insert( newEnemy.Groups, "EnemyTeam" )
	if newEnemy.RequiredKill then
		table.insert( newEnemy.Groups, "RequiredKillEnemies" )
	end
	AddToGroup({ Id = newEnemy.ObjectId, Names = newEnemy.Groups })

	if newEnemy.RespawnOnDeath then
		newEnemy.OriginalSpawnLocationId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = newEnemy.ObjectId })
	end

	if not skipModifiers then
		ApplyEnemyModifiers( newEnemy, currentRun, args )
	end
	if newEnemy.AlwaysTraitor then
		SwitchAllegiance({ Id = newEnemy.ObjectId })
	end

	ApplyEnemyTraits( currentRun, newEnemy )

	newEnemy.BarXScale = 1

	local healthMultiplier = newEnemy.HealthMultiplier or 1
	healthMultiplier = healthMultiplier + ( GetNumMetaUpgrades( "EnemyHealthShrineUpgrade" ) * ( MetaUpgradeData.EnemyHealthShrineUpgrade.ChangeValue - 1 ) )
	if healthMultiplier ~= 1 and newEnemy.UseShrineUpgrades and newEnemy.MaxHealth ~= nil then
		newEnemy.MaxHealth = newEnemy.MaxHealth * healthMultiplier
	end
	newEnemy.Health = newEnemy.MaxHealth

	if newEnemy.PreDamageIfEncounterCompleted ~= nil and HasEncounterOccurred( currentRun, newEnemy.PreDamageIfEncounterCompleted, true ) then
		newEnemy.Health = newEnemy.MaxHealth * newEnemy.PreDamagePercent
	end

	for i, traitData in pairs(CurrentRun.Hero.Traits) do
		if traitData.EncounterPreDamage then
			local validEnemy = false
			local damageData = traitData.EncounterPreDamage
			if damageData.EnemyType ~= nil then
				if damageData.EnemyType == "Boss" and newEnemy.IsBoss then
					validEnemy = true
				end
			else
				validEnemy = true
			end
			if validEnemy then
				newEnemy.Health = newEnemy.Health - ( newEnemy.MaxHealth * damageData.PreDamage )
				CurrentRun.CurrentRoom.UsedPreDamageTraits = CurrentRun.CurrentRoom.UsedPreDamageTraits or {}
				table.insert( CurrentRun.CurrentRoom.UsedPreDamageTraits, traitData )
			end
		end
	end

	if newEnemy.HealthBuffer ~= nil and newEnemy.HealthBuffer > 0 then
		local healthBufferMultiplier = newEnemy.HealthBufferMultiplier or 1
		newEnemy.HealthBuffer = newEnemy.HealthBuffer * healthMultiplier * healthBufferMultiplier
		DoEnemyHealthBuffered( newEnemy )
	end

	if newEnemy.Phases ~= nil then
		newEnemy.CurrentPhase = 1
	end
	newEnemy.HitShields = 0
	if newEnemy.UseShrineUpgrades then
		newEnemy.HitShields = GetNumMetaUpgrades( "EnemyShieldShrineUpgrade" )
		local eliteSpeedMultiplier = newEnemy.EliteAdditionalSpeedMultiplier or 0
		local speedMultiplier =  1 + eliteSpeedMultiplier
		if GetNumMetaUpgrades( "EnemySpeedShrineUpgrade" ) > 0  then
			if MetaUpgradeData.EnemySpeedShrineUpgrade.ChangeValues and MetaUpgradeData.EnemySpeedShrineUpgrade.ChangeValues[GetNumMetaUpgrades( "EnemySpeedShrineUpgrade" )] then
				speedMultiplier = speedMultiplier + (MetaUpgradeData.EnemySpeedShrineUpgrade.ChangeValues[GetNumMetaUpgrades( "EnemySpeedShrineUpgrade" )] - 1)
			elseif MetaUpgradeData.EnemySpeedShrineUpgrade.ChangeValue then
				speedMultiplier = speedMultiplier + GetNumMetaUpgrades("EnemySpeedShrineUpgrade") * ( MetaUpgradeData.EnemySpeedShrineUpgrade.ChangeValue - 1)
			end
		end
		if speedMultiplier > 1.0 then
			newEnemy.SpeedMultiplier = speedMultiplier
			SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = newEnemy.SpeedMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationId = newEnemy.ObjectId })
		end
	end

	if args ~= nil and args.IgnoreAI then
		newEnemy.SkipAISetupOnActivate = true
	end

	if newEnemy.SpeedMin ~= nil and newEnemy.SpeedMax ~= nil then
		newEnemy.MoveSpeed = RandomInt( newEnemy.SpeedMin, newEnemy.SpeedMax )
		SetUnitProperty({ Property = "Speed", Value = newEnemy.MoveSpeed, DestinationId = newEnemy.ObjectId })
	end

	if newEnemy.ScaleMin and newEnemy.ScaleMax then
		newEnemy.Scale = RandomFloat( newEnemy.ScaleMin, newEnemy.ScaleMax )
		SetScale({ Fraction = newEnemy.Scale, Id = newEnemy.ObjectId })
	end

	if newEnemy.Color ~= nil then
		SetColor({ Id = newEnemy.ObjectId, Color = newEnemy.Color, MultiplyBase = true })
	end

	if newEnemy.SpawnFx ~= nil then
		CreateAnimation({ DestinationId = newEnemy.ObjectId, Name = newEnemy.SpawnFx })
	end

	if newEnemy.SpawnAnimation ~= nil then
		SetAnimation({ DestinationId = newEnemy.ObjectId, Name = newEnemy.SpawnAnimation })
	end

	if newEnemy.AddOutlineImmediately then
		if not newEnemy.HasOutline and newEnemy.Outline ~= nil and newEnemy.HealthBuffer ~= nil and newEnemy.HealthBuffer > 0 then
			newEnemy.Outline.Id = newEnemy.ObjectId
			AddOutline( newEnemy.Outline )
			newEnemy.HasOutline = true
		end
	end

	if newEnemy.RequiredKill then
		RequiredKillEnemies[newEnemy.ObjectId] = newEnemy
		notifyExistingWaiters( "RequiredKillEnemyKilledOrSpawned" )
	end

	if newEnemy.MoneyDropOnDeath and newEnemy.MoneyDropOnDeath.ValuePerDifficulty and newEnemy.MoneyDropOnDeath.ValuePerDifficulty > 0 then
		if newEnemy.GeneratorData ~= nil then
			newEnemy.MoneyDropOnDeath.MinValue = newEnemy.MoneyDropOnDeath.ValuePerDifficulty * newEnemy.GeneratorData.DifficultyRating
			newEnemy.MoneyDropOnDeath.MaxValue = newEnemy.MoneyDropOnDeath.ValuePerDifficulty * newEnemy.GeneratorData.DifficultyRating * newEnemy.MoneyDropOnDeath.ValuePerDifficultyMaxValueVariance
		else
			newEnemy.MoneyDropOnDeath.MinValue = 1
			newEnemy.MoneyDropOnDeath.MaxValue = 1
		end
	end

	local backstabUpgrades = GetNumMetaUpgrades("BackstabMetaUpgrade")
	local ammoDamageUpgrades = GetNumMetaUpgrades("StoredAmmoVulnerabilityMetaUpgrade")
	-- Metaupgrades are expressed as values of 1.05, 1.1, etc.
	local baseMetaUpgradeChangeValue = (MetaUpgradeData.BackstabMetaUpgrade.ChangeValue - 1)

	local enemyVulnerability = 1.0 + backstabUpgrades * baseMetaUpgradeChangeValue
	local collisionVulnerability = 1.0 * GetTotalHeroTraitValue("BonusCollisionVulnerability", { IsMultiplier = true })

	SetLifeProperty({ Property = "CollisionDamageMultiplier", Value = collisionVulnerability, ValueChangeType = "Multiply", DestinationId = newEnemy.ObjectId, DataValue = false })

	if newEnemy.CharacterInteractions ~= nil then
		ActivatedObjects[newEnemy.ObjectId] = newEnemy
	end

	if newEnemy.DistanceTriggers ~= nil then
		for k, trigger in ipairs( newEnemy.DistanceTriggers ) do
			thread( CheckDistanceTrigger, trigger, newEnemy )
		end
	end

	if newEnemy.RandomFlipHorizontal and CoinFlip() then
		FlipHorizontal({ Id = newEnemy.ObjectId })
	end

	if newEnemy.SelectCustomSpawnOptions ~= nil then
		local customSpawnOptionsFunction = _G[newEnemy.SelectCustomSpawnOptions]
		customSpawnOptionsFunction( newEnemy )
	end

	ActiveEnemies[newEnemy.ObjectId] = newEnemy
	AttachLua({ Id = newEnemy.ObjectId, Table = newEnemy })

	SpawnRecord[newEnemy.Name] = (SpawnRecord[newEnemy.Name] or 0) + 1
	GameState.EnemySpawns[newEnemy.Name] = (GameState.EnemySpawns[newEnemy.Name] or 0) + 1

	if args == nil or (not args.SkipPresentation and not args.SkipSpawnVoiceLines) then
		thread( PlayVoiceLines, newEnemy.OnSpawnVoiceLines, nil, newEnemy )
	end

	if args ~= nil and args.PreLoadBinks then
		LoadEnemyBinks( newEnemy )
	end

	RunUnthreadedEvents( newEnemy.SpawnUnthreadedEvents, newEnemy )

	if newEnemy.AdditionalEnemySetupFunctionName ~= nil then
		local additionalSetupFunction = _G[newEnemy.AdditionalEnemySetupFunctionName]
		additionalSetupFunction( newEnemy, currentRun, args )
	end

	if newEnemy.OnSpawnFireFunction ~= nil then
		local spawnFunction = _G[newEnemy.OnSpawnFireFunction]
		spawnFunction( newEnemy )
	end

	if newEnemy.PermanentlyEnrage then
		newEnemy.PermanentEnraged = true
		thread(EnrageUnit, newEnemy, currentRun)
	end

	if newEnemy.SetLastInvisibilityTimeOnSpawn then
		newEnemy.LastInvisibilityTime = _worldTime
	else
		newEnemy.LastInvisibilityTime = 0
	end

	if newEnemy.SetLastTeleportTimeOnSpawn then
		newEnemy.LastTeleportTime = _worldTime
	else
		newEnemy.LastTeleportTime = 0
	end
end

function LoadEnemyBinks( enemy )

	if enemy.Binks ~= nil then
		PreLoadBinks({ Names = enemy.Binks })
	end
	if enemy.OnDeathSpawnEncounter ~= nil and EncounterData[enemy.OnDeathSpawnEncounter] ~= nil then
		local binksToPreload = {}
		local enemyCache = {}
		GetEncounterBinks( EncounterData[enemy.OnDeathSpawnEncounter], binksToPreload, enemyCache )
		local dedupe = {}
		local finalBinksToPreload = {}
		for i, name in ipairs(binksToPreload) do
			if dedupe[name] == nil then
				dedupe[name] = name
				table.insert(finalBinksToPreload, name)
			end
		end
		PreLoadBinks({ Names = finalBinksToPreload })
	end
	if enemy.OtherEnemyBinks ~= nil then
		for k, otherEnemyName in pairs( enemy.OtherEnemyBinks ) do
			local enemyData = EnemyData[otherEnemyName]
			if enemyData ~= nil then
				LoadEnemyBinks( enemyData )
			end
		end
	end
	if enemy.SpawnOptions ~= nil then
		for k, spawnOption in pairs( enemy.SpawnOptions ) do
			local enemyData = EnemyData[spawnOption]
			if enemyData ~= nil then
				LoadEnemyBinks( enemyData )
			end
		end
	end
end

function CreateTethers( newEnemy )

	if newEnemy == nil or newEnemy.Tethers == nil or newEnemy.TetherIds ~= nil then
		return
	end

	newEnemy.TetherIds = {}
	local prevTetherId = newEnemy.ObjectId
	for k, tether in ipairs( newEnemy.Tethers ) do
		local count = tether.Count or 1
		for i = 1, count do
			local offsetX = nil
			local offsetY = nil
			if tether.SpawnRadius ~= nil then
				offsetX = RandomFloat( -tether.SpawnRadius, tether.SpawnRadius )
				offsetY = RandomFloat( -tether.SpawnRadius, tether.SpawnRadius )
			end
			local tetherId = SpawnObstacle({ Name = tether.Name, DestinationId = newEnemy.ObjectId, Group = tether.GroupName or "Standing", OffsetX = offsetX, offsetY = offsetY })
			SetAlpha({ Id = tetherId, Fraction = 0 })
			SetAlpha({ Id = tetherId, Fraction = 1.0, Duration = 0.3 })
			if tether.Elasticity ~= nil then
				Attach({ Id = tetherId, DestinationId = newEnemy.ObjectId, TetherDistance = tether.Distance, TetherElasticity = tether.Elasticity })
			else
				Attach({ Id = prevTetherId, DestinationId = tetherId, TetherDistance = tether.Distance, TetherRetractSpeed = tether.RetractSpeed, TetherTrackZRatio = tether.TrackZRatio })
			end
			table.insert( newEnemy.TetherIds, tetherId )
			if newEnemy.EliteIcon or ( newEnemy.HealthBuffer ~= nil and newEnemy.HealthBuffer > 0 ) then
				newEnemy.Outline.Id = tetherId
				if newEnemy.Outline.Thickness > 0 then
					AddOutline( newEnemy.Outline )
				end
			end
			prevTetherId = tetherId
		end
	end

end

OnActivationFinished{
	function( triggerArgs )
		local unit = triggerArgs.TriggeredByTable
		if unit ~= nil and not unit.IsDead then
			unit.ActivationFinished = true
			if unit.FireWeaponOnActivationFinished then
				FireWeaponFromUnit({ Weapon = unit.FireWeaponOnActivationFinished, Id = unit.ObjectId, DestinationId = unit.ObjectId, AutoEquip = true })
			end

			if not unit.SkipAISetupOnActivate then
				SetupAI( CurrentRun, unit )
			end
			CreateLevelDisplay( unit, CurrentRun )
			CreateTethers( unit )
			if unit.AttachedAnimationName ~= nil then
				CreateAnimation({ Name = unit.AttachedAnimationName, DestinationId = unit.ObjectId, OffsetZ = unit.AttachedAnimationOffsetZ })
			end
			thread( PlayVoiceLines, unit.OnActivationFinishedVoiceLines, nil, unit )
		end
	end
}

function ApplyEnemyModifiers(newEnemy, currentRun, args )

	EquipSpecialWeapons( newEnemy, newEnemy )
	for k, enemyUpgradeName in pairs( CurrentRun.EnemyUpgrades ) do
		local upgradeData = EnemyUpgradeData[enemyUpgradeName]
		if upgradeData.AddDumbFireWeapons then
			EquipDumbFireWeapons( newEnemy, upgradeData )
		end
		if upgradeData.AddSpecialWeapons then
			EquipSpecialWeapons( newEnemy, upgradeData )
		end
		if upgradeData.AddEnemyOnDeathWeapons then
			AddEnemyOnDeathWeapons( newEnemy, upgradeData.AddEnemyOnDeathWeapons )
		end
		ApplyUnitPropertyChanges( newEnemy, upgradeData.PropertyChanges, true )
	end

	-- for enemy on spawn traits
	for i, traitData in pairs( GetHeroTraitValues("AddOnEnemySpawnWeapon")) do
		if traitData.AffectChance == nil or RandomChance(traitData.AffectChance) then
			FireWeaponFromUnit({ Weapon = traitData.Weapon, Id = currentRun.Hero.ObjectId, DestinationId = newEnemy.ObjectId, AutoEquip = true })
		end
	end
	if CurrentRun.CurrentRoom.ElapsedTimeMultiplier then
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = CurrentRun.CurrentRoom.ElapsedTimeMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationId = newEnemy.ObjectId })
	end
end

function SetupAI( currentRun, enemy )

	if enemy.AIWakeDelay ~= nil then
		wait(enemy.AIWakeDelay)
	end

	if enemy.GroupAI ~= nil then
		if ActiveGroupAIs[enemy.GroupAI] == nil then
			ActiveGroupAIs[enemy.GroupAI] = {}
		end
		table.insert( ActiveGroupAIs[enemy.GroupAI], enemy )

		-- Start the thread for the first one found
		if #ActiveGroupAIs[enemy.GroupAI] == 1 then
			local groupAIFunction = _G[enemy.GroupAI]
			thread( groupAIFunction, ActiveGroupAIs[enemy.GroupAI], currentRun )
		end

		return
	end

	if enemy.ComboPartnerName ~= nil then
		enemy.ComboPartnerId = GetClosestUnitOfType({ Id = enemy.ObjectId, DestinationName = enemy.ComboPartnerName })
	end

	if enemy.SupportUnitName ~= nil then
		SpawnSupportAI( enemy, currentRun )
	end

	if enemy.AIStages ~= nil then
		enemy.AIThreadName = "EnemyAIThread"..enemy.ObjectId
		thread( StagedAI, enemy, currentRun )
		return
	end

	local aiBehavior = PickEnemyAI( currentRun, enemy )
	if aiBehavior ~= nil then
		enemy.AIThreadName = "EnemyAIThread"..enemy.ObjectId
		thread( SetAI, aiBehavior, enemy, currentRun )
	end

	ActivateDumbFireWeapons( currentRun, enemy )
end

function ActivateDumbFireWeapons( currentRun, enemy )

	if enemy.DumbFireWeapons ~= nil then
		for k, weaponData in pairs( enemy.DumbFireWeapons ) do
			if weaponData.Name == nil then
				weaponData = WeaponData[weaponData]
				thread( DumbFireAttack, enemy, currentRun, weaponData )
			else
				thread( DumbFireAttack, enemy, currentRun, weaponData )
			end
		end
	end
end

function CheckAvailableTextLines( source, args )

	if source.InteractTextLineSets == nil then
		return
	end

	local useableOffFromGift = NeedsUseableOff( source, source.GiftTextLineSets )
	if useableOffFromGift then
		return
	end

	if source.NextInteractLines == nil then
		local interactLines = GetRandomEligibleTextLines( source, source.InteractTextLineSets, args )
		local repeatableLines = GetRandomEligibleTextLines( source, source.RepeatableTextLineSets, args )
		if interactLines == "UseableOffSource" or repeatableLines == "UseableOffSource" then
			-- Queue nothing
		elseif interactLines ~= nil then
			SetNextInteractLines( source, interactLines )
		elseif repeatableLines ~= nil then
			SetNextInteractLines( source, repeatableLines )
		end
	else
		-- Restore status
		if source.NextInteractLines.OnQueuedFunctionArgs ~= nil and source.NextInteractLines.OnQueuedFunctionArgs.Restore then
			local onQueuedFunction = _G[source.NextInteractLines.OnQueuedFunctionName]
			onQueuedFunction( source, source.NextInteractLines.OnQueuedFunctionArgs )
		end
		if source.NextInteractLines.OnQueuedFunctions ~= nil then
			for k, onQueuedFunctionData in pairs( source.NextInteractLines.OnQueuedFunctions ) do
				if onQueuedFunctionData.Args.Restore and ( onQueuedFunctionData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, source, onQueuedFunctionData.GameStateRequirements ) ) then
					local onQueuedFunction = _G[onQueuedFunctionData.Name]
					onQueuedFunction( source, onQueuedFunctionData.Args )
				end
			end
		end
		if source.NextInteractLines.StatusAnimation then
			PlayStatusAnimation( source, { Animation = source.NextInteractLines.StatusAnimation } )
		end
	end
end

function SetAvailableUseText( source )
	local genusName = GetGenusName( source )
	local canGift = ( GetTextLinesUseableStatus( source, source.GiftTextLineSets ) and CanReceiveGift( source ) and ( HasResource( GetNextGiftResource( genusName ), GetNextGiftResourceQuantity( genusName ))))
	local canAssistAction = ( source.AssistInteractText ~= nil )
	if source.NextInteractLines ~= nil or canGift or canAssistAction or source.AlwaysShowDefaultUseText then
		UseableOn({ Id = source.ObjectId })
		RefreshUseButton( source.ObjectId, source )
	else
		UseableOff({ Id = source.ObjectId })
	end
end

function SetNextInteractLines( source, textLines )
	if textLines == nil then
		return
	end

	source.NextInteractLines = textLines

	if source.NextInteractLines.UseText ~= nil then
		source.UseText = source.NextInteractLines.UseText
	end

	if source.NextInteractLines.InteractDistance ~= nil then
		SetInteractProperty({ DestinationId = source.ObjectId, Property = "Distance", Value = source.NextInteractLines.InteractDistance })
	end

	if textLines.TeleportToId ~= nil then
		Teleport({ Id = textLines.TeleportId or source.ObjectId, DestinationId = textLines.TeleportToId, OffsetX = textLines.TeleportOffsetX, OffsetY = textLines.TeleportOffsetY, OnlyIfDestinationExits = true, })
	end
	if textLines.TeleportWithId ~= nil then
		Teleport({ Id = textLines.TeleportWithId, DestinationId = textLines.TeleportToId })
		Teleport({ Id = source.ObjectId, DestinationId = textLines.TeleportToId, OffsetX = textLines.TeleportOffsetX, OffsetY = textLines.TeleportOffsetY, OnlyIfDestinationExits = true, })
	end
	if textLines.AngleTowardTargetId ~= nil then
		AngleTowardTarget({ Id = textLines.AngleId or source.ObjectId, DestinationId = textLines.AngleTowardTargetId })
	end
	if not CurrentRun.NPCInteractions[source.Name] or textLines.UseInitialInteractSetup then

		-- Only do first conversation this run
		if textLines.OnQueuedFunctionName ~= nil then
			local onQueuedFunction = _G[textLines.OnQueuedFunctionName]
			onQueuedFunction( source, textLines.OnQueuedFunctionArgs )
		end
		if textLines.OnQueuedFunctions ~= nil then
			for k, onQueuedFunctionData in pairs( textLines.OnQueuedFunctions ) do
				if onQueuedFunctionData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, source, onQueuedFunctionData.GameStateRequirements ) then
					local onQueuedFunction = _G[onQueuedFunctionData.Name]
					onQueuedFunction( source, onQueuedFunctionData.Args )
				end
			end
		end
		if textLines.OnQueuedThreadedFunctionName ~= nil then
			local onQueuedFunction = _G[textLines.OnQueuedThreadedFunctionName]
			thread( onQueuedFunction, source, textLines.OnQueuedFunctionArgs )
		end
		if textLines.StatusAnimation then
			PlayStatusAnimation( source, { Animation = textLines.StatusAnimation } )
		end
	end

end

function SetStatusAnimationFromTextLines( source, textLines )
	if not source or not textLines then
		return
	end

	if textLines.OnQueuedFunctionName ~= nil or textLines.OnQueuedThreadedFunctionName ~= nil then
		local onQueuedFunctionArgs = textLines.OnQueuedFunctionArgs
		if onQueuedFunctionArgs and onQueuedFunctionArgs.StatusAnimation then
			PlayStatusAnimation( source, { Animation = onQueuedFunctionArgs.StatusAnimation } )
		end
	end
	if textLines.OnQueuedFunctions ~= nil then
		for k, onQueuedFunctionData in pairs( textLines.OnQueuedFunctions ) do
			if onQueuedFunctionData.Args and onQueuedFunctionData.Args.StatusAnimation and ( onQueuedFunctionData.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, source, onQueuedFunctionData.GameStateRequirements ) ) then
				PlayStatusAnimation( source, { Animation = onQueuedFunctionData.Args.StatusAnimation } )
			end
		end
	end

	if textLines.StatusAnimation then
		PlayStatusAnimation( source, { Animation = textLines.StatusAnimation } )
	end
end

function CheckConversations()
	-- Check partner conversations first

	local allowPartnerConversationsThisRun = true
	if CurrentRun.Hero.IsDead and not IsGameStateEligible( CurrentRun, GameData.PartnerConversationRequirements ) then
		allowPartnerConversationsThisRun = false
	end
	--local sortedUnits = CollapseTableOrdered( ActiveEnemies )
	local sortedUnits = {}
	for k, unitName in ipairs( GameData.ConversationOrder ) do
		local unitIds = GetIdsByType({ Name = unitName })
		table.sort( unitIds )
		for k, unitId in ipairs( unitIds ) do
			local unit = ActiveEnemies[unitId]
			if unit ~= nil then
				table.insert( sortedUnits, unit )
			end
		end
	end
	if allowPartnerConversationsThisRun then
		for id, unit in ipairs( sortedUnits ) do
			if CurrentRun.PartnerConversationName == nil or CurrentRun.PartnerConversationName == unit.Name then
				CheckAvailableTextLines( unit, { RequirePartner = true } )
				if CheckPartnerConversations( unit ) then
					CurrentRun.PartnerConversationName = unit.Name
					break
				end
			end
		end
	end
	-- Then normal conversations
	for id, unit in ipairs( sortedUnits ) do
		CheckAvailableTextLines( unit, { RequireNoPartner = true } )
		SetAvailableUseText( unit )
	end
end

function CheckPartnerConversations( unit )

	if unit.NextInteractLines == nil then
		return false
	end

	for partnerId, partnerUnit in pairs( ActiveEnemies ) do
		if partnerUnit.Name == unit.NextInteractLines.Partner then
			local allTextLineSets = MergeTables( partnerUnit.InteractTextLineSets, partnerUnit.RepeatableTextLineSets ) or partnerUnit.InteractTextLineSets
			for partnerTextLinesName, partnerTextLines in pairs( allTextLineSets  ) do
				-- Partner conversation overrides any other conversation chosen
				if partnerTextLinesName == unit.NextInteractLines.Name then
					SetNextInteractLines( partnerUnit, partnerTextLines )
					if unit.NextInteractLines.UseText ~= nil then
						partnerUnit.UseText = unit.NextInteractLines.UseText
					end
					if unit.NextInteractLines.BlockDistanceTriggers ~= nil then
						partnerUnit.NextInteractLines.BlockDistanceTriggers = unit.NextInteractLines.BlockDistanceTriggers
					end
					partnerUnit.CanReceiveGift = false
					unit.CanReceiveGift = false
					partnerUnit.InPartnerConversation = true
					unit.InPartnerConversation = true
					return true
				end
			end
		end
	end

	return false

end

function GetRandomEligibleTextLines( source, textLineSets, args )

	if textLineSets == nil then
		return nil
	end

	local useable = true
	local superPriorityTextLines = {}
	local priorityTextLines = {}
	local eligibleTextLines = {}
	local eligibleUnplayedTextLines = {}
	for textLineSetName, textLineSet in pairs( textLineSets ) do

		if CurrentRun.TextLinesRecord[textLineSet.Name] then
			-- Conversation completed
			if textLineSet.UseableOffSource then
				return "UseableOffSource"
			end
		elseif IsTextLineEligible( CurrentRun, textLineSet, nil, nil, args ) then
			-- Conversation available
			table.insert( eligibleTextLines, textLineSet )
			if not PlayedRandomTextLines[textLineSet.Name] then
				table.insert( eligibleUnplayedTextLines, textLineSet )
			end
			if textLineSet.SuperPriority then
				table.insert( superPriorityTextLines, textLineSet )
			elseif textLineSet.Priority then
				table.insert( priorityTextLines, textLineSet )
			end
		end

	end

	if not useable then
		return nil
	end

	if not IsEmpty( superPriorityTextLines ) then
		return GetRandomValue( superPriorityTextLines )
	end

	if not IsEmpty( priorityTextLines ) then
		return GetRandomValue( priorityTextLines )
	end

	local randomLines = nil
	if IsEmpty( eligibleUnplayedTextLines ) then
		-- All lines played, start the record over
		for textLinesName, textLines in pairs( textLineSets ) do
			PlayedRandomTextLines[textLinesName] = nil
		end
		randomLines = GetRandomValue( eligibleTextLines )
	else
		randomLines = GetRandomValue( eligibleUnplayedTextLines )
	end
	if randomLines ~= nil then
		PlayedRandomTextLines[randomLines.Name] = true
	end
	return randomLines

end

function GetTextLinesUseableStatus( source, textLineSets )
	if textLineSets == nil then
		return false
	end

	local useable = true
	local conversationAvailable = false
	for k, textLineSet in pairs( textLineSets ) do
		if CurrentRun.TextLinesRecord[textLineSet.Name] then
			-- Conversation completed
			if textLineSet.UseableOffSource then
				useable = false
			end
		elseif IsTextLineEligible( CurrentRun, textLineSet ) then
			-- Conversation available
			conversationAvailable = true
		end
	end
	return conversationAvailable and useable
end

function NeedsUseableOff( source, textLineSets )
	if textLineSets == nil then
		return false
	end
	for k, textLineSet in pairs( textLineSets ) do
		if CurrentRun.TextLinesRecord[textLineSet.Name] and textLineSet.UseableOffSource then
			return true
		end
	end
	return false
end

function CalcTotalSpawns( currentRun, currentRoom, currentEncounter, spawnInfo )

	if spawnInfo.InfiniteSpawns then
		return 1
	end

	if spawnInfo.TotalCount == nil and (spawnInfo.CountMin == nil or spawnInfo.CountMax == nil) then
		return 0
	end

	if spawnInfo.RequiredMetaUpgrade ~= nil and GetNumMetaUpgrades(spawnInfo.RequiredMetaUpgrade) == 0 then
		return 0
	end

	if spawnInfo.RequiredFalseMetaUpgrade ~= nil and GetNumMetaUpgrades(spawnInfo.RequiredMetaUpgrade) > 0 then
		return 0
	end

	local totalSpawns = spawnInfo.TotalCount or RandomInt( spawnInfo.CountMin, spawnInfo.CountMax )
	if currentEncounter.EnemyCountDepthRamp ~= nil then
		totalSpawns = totalSpawns * ( 1.0 + ( (GetRunDepth( currentRun ) - 1) * currentEncounter.EnemyCountDepthRamp ) )
	end
	if currentEncounter.EnemyCountRunRamp ~= nil then
		totalSpawns = totalSpawns * ( 1.0 + ( GetCompletedRuns() * currentEncounter.EnemyCountRunRamp ) )
	end

	local spawnMultiplier = 1
	if not currentEncounter.BlockSpawnMultipliers then
		spawnMultiplier = GetTotalHeroTraitValue("SpawnMultiplier", { IsMultiplier = true })
	end


	if spawnInfo.EnemyCountShrineModifierName then
		local modifierName = spawnInfo.EnemyCountShrineModifierName
		totalSpawns = math.floor( totalSpawns + (GetNumMetaUpgrades(modifierName) * spawnInfo.EnemyCountShineModifierAmount ) )
	elseif currentEncounter.EnemyCountShrineModifierName then
		local modifierName = currentEncounter.EnemyCountShrineModifierName
		totalSpawns = math.floor( totalSpawns + (GetNumMetaUpgrades(modifierName) * currentEncounter.EnemyCountShineModifierAmount ) )
	end

	totalSpawns = totalSpawns * spawnMultiplier

	return totalSpawns

end

function PickEnemyAI( currentRun, newEnemy )
	local aiOption = nil

	-- Use the room's individual overrides
	if currentRun.CurrentRoom.AIOverride ~= nil then
		aiOption = currentRun.CurrentRoom.AIOverride[newEnemy.Name]
	end

	-- Otherwise, use the room's full override
	if aiOption == nil and currentRun.CurrentRoom.AIFullOverrideName ~= nil and newEnemy.AIOptions ~= nil then
		aiOption = _G[currentRun.CurrentRoom.AIFullOverrideName]
	end

	-- Otherwise use the encounter's overrides
	if aiOption == nil and currentRun.CurrentRoom.Encounter ~= nil and currentRun.CurrentRoom.Encounter.Spawns ~= nil then
		if currentRun.CurrentRoom.Encounter.Spawns[newEnemy.Name] ~= nil then
			aiOption = currentRun.CurrentRoom.Encounter.Spawns[newEnemy.Name].AIOverride
		end
	end

	-- Otherwise pick from the enemy's available AI
	if aiOption == nil then
		aiOption = GetRandomValue( newEnemy.AIOptions )
	end

	return aiOption
end

function UnlockRoomExits( run, room, delay )

	if run.ExitsReadyFunctionName ~= nil then
		RunFunctionName( run.ExitsReadyFunctionName )
	end

	if room.ExitsUnlocked then
		return
	end
	room.ExitsUnlocked = true
	thread( CheckQuestStatus )
	thread( CheckProgressAchievements )

	if IsEmpty( OfferedExitDoors ) then
		return
	end

	wait( delay or 0.4 ) -- Must wait for post-reward presentation to complete

	local heroLocation = GetLocation({ Id = run.Hero.ObjectId })
	RecordObjectState( room, run.Hero.ObjectId, "Location", heroLocation )
	local heroAngle = GetAngle({ Id = run.Hero.ObjectId })
	RecordObjectState( room, run.Hero.ObjectId, "Angle", heroAngle )

	if room.Encounter ~= nil and not room.Encounter.SkipExitReadyCheckpoint then
		DebugAssert({ Condition = room.Encounter.Completed, Text = "Exits unlocked in incompleted encounter!" })
		room.CheckpointInvalidated = false
		SaveCheckpoint({ SaveName = "_Temp", DevSaveName = CreateDevSaveName( run, { PostReward = true } ) })
		ValidateCheckpoint({ Valid = true })
	end

	wait(0.02)

	DoUnlockRoomExits( run, room )

end

function ChooseNextRewardStore( run )

	RandomSynchronize()

	local rewardStoreName = nil
	local targetMetaRewardsRatio = (run.CurrentRoom.TargetMetaRewardsRatio or run.Hero.TargetMetaRewardsRatio) - ( GetNumMetaUpgrades( "RunProgressRewardMetaUpgrade" ) * ( MetaUpgradeData.RunProgressRewardMetaUpgrade.ChangeValue - 1 ) )
	--DebugPrint({ Text = "targetMetaRewardsRatio = "..targetMetaRewardsRatio })
	local metaProgressChance = targetMetaRewardsRatio 
	local currentMetaProgressRatio = CalcMetaProgressRatio( run )
	if currentMetaProgressRatio ~= nil then
		metaProgressChance = metaProgressChance + (run.Hero.TargetMetaRewardsAdjustSpeed * (targetMetaRewardsRatio - currentMetaProgressRatio))
	end
	--DebugPrint({ Text = "metaProgressChance = "..metaProgressChance })
	if RandomChance( metaProgressChance ) then
		rewardStoreName = "MetaProgress"
	else
		rewardStoreName = "RunProgress"
	end
	--DebugPrint({ Text = "rewardStoreName = "..rewardStoreName })
	run.NextRewardStoreName = rewardStoreName
	return rewardStoreName

end

function DoUnlockRoomExits( run, room )

	-- Synchronize the RNG to its initial state. Makes room reward choices deterministic on save/load
	RandomSynchronize()

	local rewardsChosen = {}
	local rewardStoreName = run.NextRewardStoreName or ChooseNextRewardStore( run )
	local rewardStoreOverrides = {}
	local exitDoorsIPairs = CollapseTableOrdered( OfferedExitDoors )
	for index, door in ipairs( exitDoorsIPairs ) do
		if door.Room == nil then
			local roomForDoorData = nil
			if door.ForceRoomName ~= nil then
				roomForDoorData = RoomData[door.ForceRoomName]
			else
				roomForDoorData = ChooseNextRoomData( run )
			end
			local roomForDoor = CreateRoom( roomForDoorData, { SkipChooseReward = true, SkipChooseEncounter = true, })
			roomForDoor.NeedsReward = true
			door.Room = roomForDoor
		end
		local roomForDoorName = door.Room.GenusName or door.Room.Name
		if door.Room.FirstClearRewardStore ~= nil and IsRoomFirstClearOverShrinePointThreshold( GetEquippedWeapon(), run, roomForDoorName ) then
			rewardStoreOverrides[index] = door.Room.FirstClearRewardStore
		elseif door.Room.ForcedRewardStore ~= nil then
			rewardStoreOverrides[index] = door.Room.ForcedRewardStore
		end
		if rewardStoreOverrides[index] and not Contains( RewardStoreData.InvalidOverrides, rewardStoreOverrides[index] ) then
			rewardStoreName = rewardStoreOverrides[index]
		end
		wait( 0.02 ) -- Distribute workload
	end

	if run.CurrentRoom.FirstAppearanceNumExitOverrides ~= nil and not HasSeenRoomEarlierInRun( run, run.CurrentRoom.Name ) then
		local randomDoors = ShallowCopyTable( exitDoorsIPairs )
		for i = 1, run.CurrentRoom.FirstAppearanceNumExitOverrides do
			local randomDoor = RemoveRandomValue( randomDoors )
			if randomDoor ~= nil and randomDoor.Room ~= nil then
				randomDoor.Room.UseOptionalOverrides = true
				for key, value in pairs( randomDoor.Room.OptionalOverrides ) do
					randomDoor.Room[key] = value
				end
			end
		end
	end

	for index, door in ipairs( exitDoorsIPairs ) do
		local room = door.Room
		if room ~= nil and room.NeedsReward then
			if Contains( RewardStoreData.InvalidOverrides, rewardStoreOverrides[index] ) then
				room.RewardStoreName =  rewardStoreOverrides[index] or defaultRewardStoreName
			else
				room.RewardStoreName = rewardStoreName or defaultRewardStoreName
			end
			room.ChosenRewardType = ChooseRoomReward( CurrentRun, room, rewardStoreName, rewardsChosen, { Door = door } )
			SetupRoomReward( CurrentRun, room, rewardsChosen, { Door = door, IgnoreForceLootName = room.IgnoreForceLootName } )
			table.insert( rewardsChosen, { RewardType = room.ChosenRewardType, ForceLootName = room.ForceLootName })
			room.NeedsReward = false
			if room.UseOptionalOverrides then
				for key, value in pairs( room.OptionalOverrides ) do
					room[key] = value
				end
			end
			AssignRoomToExitDoor( door, room )
			wait( 0.02 ) -- Distribute workload
		end

	end

	if CurrentRun.CurrentRoom.LogShrineClears then
		local roomName = CurrentRun.CurrentRoom.GenusName or CurrentRun.CurrentRoom.Name
		SetRoomCleared( GetEquippedWeapon(), roomName, CurrentRun.CurrentRoom.ChosenRewardType )
	end

	wait( 0.02 ) -- Distribute workload

	for index, door in ipairs( exitDoorsIPairs ) do
		CreateDoorRewardPreview( door )
		thread( ExitDoorUnlockedPresentation, door )
		door.ReadyToUse = true
	end

	if CurrentRun.CurrentRoom.ForceFishing and CurrentRun.CurrentRoom.FishingPointId and IsUseable({ Id = CurrentRun.CurrentRoom.FishingPointId }) then
		thread( FishingPointAvailablePresentation, CurrentRun.CurrentRoom )
	end

	if CurrentRun.CurrentRoom.ChallengeSwitch ~= nil then
		local challengeSwitch = CurrentRun.CurrentRoom.ChallengeSwitch
		local startingValue = challengeSwitch.StartingValue or 0
		if challengeSwitch.RewardType == "Health" then
			startingValue = startingValue * CalculateHealingMultiplier()
		end
		if challengeSwitch.RewardType == "Money" and HasHeroTraitValue("BlockMoney") then
			startingValue = 0
		end
		challengeSwitch.StartingValue = round( startingValue )
		challengeSwitch.ReadyToUse = true
		challengeSwitch.UseText = challengeSwitch.ChallengeAvailableUseText
		RefreshUseButton( challengeSwitch.ObjectId, challengeSwitch )
		SetAnimation({ Name = challengeSwitch.UnlockedAnimationName, DestinationId = challengeSwitch.ObjectId })
		PlaySound({ Name = "/SFX/ChallengeChestUnlocked", Id = challengeSwitch.ObjectId })
	end
	if CurrentRun.CurrentRoom.WellShop ~= nil then
		CurrentRun.CurrentRoom.WellShop.ReadyToUse = true
		CurrentRun.CurrentRoom.WellShop.UseText = CurrentRun.CurrentRoom.WellShop.AvailableUseText
		RefreshUseButton( CurrentRun.CurrentRoom.WellShop.ObjectId, CurrentRun.CurrentRoom.WellShop )
		SetAnimation({ Name = "WellShopUnlocked", DestinationId = CurrentRun.CurrentRoom.WellShop.ObjectId })
		PlaySound({ Name = "/SFX/WellShopUnlocked", Id = CurrentRun.CurrentRoom.WellShop.ObjectId })
	end
	if CurrentRun.CurrentRoom.SellTraitShop ~= nil then
		CurrentRun.CurrentRoom.SellTraitShop.ReadyToUse = true
		CurrentRun.CurrentRoom.SellTraitShop.UseText = CurrentRun.CurrentRoom.SellTraitShop.AvailableUseText
		RefreshUseButton( CurrentRun.CurrentRoom.SellTraitShop.ObjectId, CurrentRun.CurrentRoom.SellTraitShop )
		SetAnimation({ Name = "SellTraitShopUnlocked", DestinationId = CurrentRun.CurrentRoom.SellTraitShop.ObjectId })
		PlaySound({ Name = "/SFX/WellShopUnlocked", Id = CurrentRun.CurrentRoom.SellTraitShop.ObjectId })
	end
	StartTriggers( CurrentRun.CurrentRoom, CurrentRun.CurrentRoom.ExitsUnlockedDistanceTriggers )

end

function AssignRoomToExitDoor( door, room )

	door.Room = room
	OfferedExitDoors[door.ObjectId] = door

	AddToGroup({ Id = door.ObjectId, Name = "ExitDoors" })

	CurrentRun.CurrentRoom.OfferedRewards = CurrentRun.CurrentRoom.OfferedRewards or {}
	if room.ChosenRewardType ~= nil then
		CurrentRun.CurrentRoom.OfferedRewards[door.ObjectId] = { Type = room.ChosenRewardType, ForceLootName = room.ForceLootName, UseOptionalOverrides = room.UseOptionalOverrides }
	end
	if door.AllowReroll and not room.NoReroll and CheckSpecialDoorRequirement( door ) == nil and room.ChosenRewardType ~= "Shop" and IsMetaUpgradeSelected( "RerollMetaUpgrade" ) then
		door.CanBeRerolled = true
	end
	RefreshUseButton( door.ObjectId, door )

end

function LeaveRoom( currentRun, door )

	local nextRoom = door.Room

	ZeroSuperMeter()
	ClearEffect({ Id = currentRun.Hero.ObjectId, All = true, BlockAll = true, })
	StopCurrentStatusAnimation( currentRun.Hero )
	currentRun.Hero.BlockStatusAnimations = true
	AddTimerBlock( currentRun, "LeaveRoom" )
	SetPlayerInvulnerable( "LeaveRoom" )

	local ammoIds = GetIdsByType({ Name = "AmmoPack" })
	SetObstacleProperty({ Property = "Magnetism", Value = 3000, DestinationIds = ammoIds })
	SetObstacleProperty({ Property = "MagnetismSpeedMax", Value = currentRun.Hero.LeaveRoomAmmoMangetismSpeed, DestinationIds = ammoIds })
	StopAnimation({ DestinationIds = ammoIds, Name = "AmmoReturnTimer" })

	RunUnthreadedEvents( currentRun.CurrentRoom.LeaveUnthreadedEvents, currentRun.CurrentRoom )

	if IsRecordRunDepth( currentRun ) then
		thread( PlayVoiceLines, GlobalVoiceLines.RecordRunDepthVoiceLines )
	end

	ResetObjectives()

	if currentRun.CurrentRoom.ChallengeEncounter ~= nil and currentRun.CurrentRoom.ChallengeEncounter.InProgress then
		currentRun.CurrentRoom.ChallengeEncounter.EndedEarly = true
		currentRun.CurrentRoom.ChallengeEncounter.InProgress = false
		thread( PlayVoiceLines, HeroVoiceLines.FleeingEncounterVoiceLines, false )
	end

	if currentRun.CurrentRoom.CloseDoorsOnUse then
		CloseDoorForRun( currentRun, door )
	end

	RemoveRallyHealth()
	if not nextRoom.BlockDoorHealFromPrevious then
		CheckDoorHealTrait( currentRun )
	end
	local removedTraits = {}
	for _, trait in pairs( currentRun.Hero.Traits ) do
		if trait.RemainingUses ~= nil and trait.UsesAsRooms ~= nil and trait.UsesAsRooms then
			UseTraitData( currentRun.Hero, trait )
			if trait.RemainingUses ~= nil and trait.RemainingUses <= 0 then
				table.insert( removedTraits, trait )
			end
		end
	end
	for _, trait in pairs( removedTraits ) do
		RemoveTraitData( currentRun.Hero, trait )
	end

	local exitFunctionName = currentRun.CurrentRoom.ExitFunctionName or door.ExitFunctionName or "LeaveRoomPresentation"
	local exitFunction = _G[exitFunctionName]
	exitFunction( currentRun, door )

	TeardownRoomArt( currentRun, currentRoom )
	if not currentRun.Hero.IsDead then
		--On Zag death cleanup is already processed
		CleanupEnemies()
	end
	killTaggedThreads( RoomThreadName )
	killWaitUntilThreads( "RequiredKillEnemyKilledOrSpawned" )
	killWaitUntilThreads( "AllRequiredKillEnemiesDead" ) -- Can exist for a TimeChallenge encounter
	killWaitUntilThreads( "RequiredEnemyKilled" ) -- Can exist for a TimeChallenge encounter

	RemoveTimerBlock( currentRun, "LeaveRoom" )
	if currentRun.CurrentRoom.TimerBlock ~= nil then
		RemoveTimerBlock( currentRun, currentRun.CurrentRoom.TimerBlock )
	end
	SetPlayerVulnerable( "LeaveRoom" )

	if currentRun.CurrentRoom.SkipLoadNextMap then
		return
	end

	MoneyObjects = {}
	OfferedExitDoors = {}

	local flipMap = false
	if currentRun.CurrentRoom.ExitDirection ~= nil and nextRoom.EntranceDirection ~= nil and nextRoom.EntranceDirection ~= "LeftRight" then
		flipMap = nextRoom.EntranceDirection ~= currentRun.CurrentRoom.ExitDirection
	else
		flipMap = RandomChance( nextRoom.FlipHorizontalChance or 0.5 )
	end
	nextRoom.Flipped = flipMap

	if nextRoom.Encounter == nil then
		nextRoom.Encounter = ChooseEncounter( CurrentRun, nextRoom )
		RecordEncounter( CurrentRun, nextRoom.Encounter )
	end

	currentRun.CurrentRoom.EndingHealth = currentRun.Hero.Health
	currentRun.CurrentRoom.EndingAmmo = GetWeaponProperty({ Id = currentRun.Hero.ObjectId, WeaponName = "RangedWeapon", Property = "Ammo" })
	table.insert( currentRun.RoomHistory, currentRun.CurrentRoom )
	UpdateRunHistoryCache( currentRun, currentRun.CurrentRoom )
	local previousRoom = currentRun.CurrentRoom
	currentRun.CurrentRoom = nextRoom

	RunShopGeneration( currentRun.CurrentRoom )

	GameState.LocationName = nextRoom.LocationText
	RandomSetNextInitSeed()
	if not nextRoom.SkipSave then
		SaveCheckpoint({ StartNextMap = nextRoom.Name, SaveName = "_Temp", DevSaveName = CreateDevSaveName( currentRun ) })
		ValidateCheckpoint({ Value = true })

	end

	RemoveInputBlock({ Name = "MoveHeroToRoomPosition" })
	AddInputBlock({ Name = "MapLoad" })

	LoadMap({ Name = nextRoom.Name, ResetBinks = previousRoom.ResetBinksOnExit or currentRun.CurrentRoom.ResetBinksOnEnter, LoadBackgroundColor = currentRun.CurrentRoom.LoadBackgroundColor })

end


function RecordEncounter( run, encounter )

	run.EncountersOccurredCache[encounter.Name] = (run.EncountersOccurredCache[encounter.Name] or 0) + 1
	GameState.EncountersOccurredCache[encounter.Name] = (GameState.EncountersOccurredCache[encounter.Name] or 0) + 1

	run.EncountersOccurredBiomeCache[encounter.Name] = (run.EncountersOccurredBiomeCache[encounter.Name] or 0) + 1

	run.EncountersDepthCache[encounter.Name] = run.RunDepthCache

end

function StartTriggers( triggerSource, triggers )

	if triggerSource == nil or triggers == nil then
		return
	end

	for k, trigger in ipairs( triggers ) do
		thread( CheckDistanceTrigger, trigger, triggerSource )
	end

end

function RunEvents( eventSource )

	RunThreadedEvents( eventSource.ThreadedEvents, eventSource )
	RunUnthreadedEvents( eventSource.PreUnthreadedEvents, eventSource )
	RunUnthreadedEvents( eventSource.UnthreadedEvents, eventSource )
	RunUnthreadedEvents( eventSource.PostUnthreadedEvents, eventSource )

end

function RunThreadedEvents( events, eventSource )

	if events == nil then
		return
	end

	for k, event in ipairs( events ) do
		if type(event) == "table" then
			if event.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, event.GameStateRequirements ) then
				if event.FunctionName ~= nil then
					local eventFunction = _G[event.FunctionName]
					DebugAssert({ Condition = eventFunction ~= nil, Text = "Unthreaded event function '"..event.FunctionName.."' is not defined.'" })
					if eventFunction ~= nil then
						manualFunctionCall( event.FunctionName, event.Args )
						thread( eventFunction, eventSource, event.Args )
					end
				elseif event.Function ~= nil then
					thread( event.Function, eventSource, event.Args )
				end
			end
		else
			thread( event, eventSource )
		end
	end

end

function RunUnthreadedEvents( events, eventSource )

	if events == nil then
		return
	end

	for k, event in ipairs( events, eventSource ) do
		if type(event) == "table" then
			if event.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, event.GameStateRequirements ) then
				if event.FunctionName ~= nil then
					manualFunctionCall( event.FunctionName, event.Args )
					local eventFunction = _G[event.FunctionName]
					DebugAssert({ Condition = eventFunction ~= nil, Text = "Unthreaded event function '"..event.FunctionName.."' is not defined.'" })
					if eventFunction ~= nil then
						eventFunction( eventSource, event.Args )
						if event.BreakIfPlayed then
							return
						end
					end
				elseif event.Function ~= nil then
					event.Function( eventSource, event.Args )
					if event.BreakIfPlayed then
						return
					end
				end
			end
		else
			event( eventSource )
			if event.BreakIfPlayed then
				return
			end
		end
	end

end

function CheckDistanceTriggerThread( source, args )
	thread( CheckDistanceTrigger, args, source )
end

function CheckDistanceTrigger( trigger, triggerSource, id )

	local currentRun = CurrentRun

	trigger.Name = trigger.Name or triggerSource.Name..(triggerSource.ObjectId or trigger.TriggerGroup or trigger.TriggerObjectType)..(id or "")

	local triggerIds = trigger.TriggerIds or { trigger.TriggerId }
	if triggerSource.ObjectId ~= nil then
		triggerIds = { triggerSource.ObjectId }
	end
	if trigger.TriggerGroup ~= nil or trigger.TriggerGroups ~= nil then
		triggerIds = GetIds({ Name = trigger.TriggerGroup, Names = trigger.TriggerGroups })
	elseif trigger.TriggerObjectType ~= nil then
		triggerIds = GetIdsByType({ Name = trigger.TriggerObjectType })
	end
	local actualSource = nil
	if triggerIds ~= nil then
		triggerId = triggerIds[1]
		actualSource = ActiveEnemies[triggerId] -- @refactor Return the actual table from the notify. Need to change so the real source comes through to begin with
	end

	if actualSource ~= nil and actualSource.NextInteractLines ~= nil and actualSource.NextInteractLines.BlockDistanceTriggers then
		return
	end

	if not IsDistanceTriggerEligible( currentRun, trigger, trigger.GameStateRequirements ) then
		return
	end

	if trigger.PreTriggerVfx ~= nil then
		CreateAnimation({ Name = trigger.PreTriggerVfx, DestinationId = triggerSource.ObjectId, OffsetX = triggerSource.AnimOffsetX, OffsetZ = triggerSource.AnimOffsetZ, Group = "Combat_UI_World" })
	end

	if trigger.PreTriggerAnimation ~= nil then
		SetAnimation({ Name = trigger.PreTriggerAnimation, DestinationId = triggerSource.ObjectId })
	end

	if trigger.PreTriggerSound ~= nil then
		triggerSource.PreTriggerSoundId = PlaySound({ Name = trigger.PreTriggerSound, Id = triggerSource.ObjectId })
	end

	if trigger.PreTriggerSetFlagTrue ~= nil then
		GameState.Flags[trigger.PreTriggerSetFlagTrue] = true
	end
	if trigger.PreTriggerSetFlagFalse ~= nil then
		GameState.Flags[trigger.PreTriggerSetFlagFalse] = false
	end

	if trigger.PreTriggerFunctionName ~= nil then
		local preTriggerFunction = _G[trigger.PreTriggerFunctionName]
		preTriggerFunction( actualSource or triggerSource, trigger.PreTriggerFunctionArgs )
	end

	local notifiedIds = {}

	local triggeredOnce = false
	while not triggeredOnce or trigger.Repeat do

		triggeredOnce = true

		if triggerSource.ObjectId ~= nil then
			triggerIds = { triggerSource.ObjectId }
		end
		if trigger.TriggerGroup ~= nil then
			triggerIds = GetIds({ Name = trigger.TriggerGroup })
		elseif trigger.TriggerObjectType ~= nil then
			triggerIds = GetIdsByType({ Name = trigger.TriggerObjectType })
		end

		if trigger.RemoveNotifiedIds then
			for id, v in pairs( notifiedIds ) do
				RemoveValueAndCollapse( triggerIds, id )
			end
		end

		local notifiedById = 0
		if trigger.OutsideDistance ~= nil then
			local notifyName = "OutsideDistance"..trigger.Name
			NotifyOutsideDistanceAll({ Id = currentRun.Hero.ObjectId, DestinationNames = trigger.TriggerGroup, DestinationIds = triggerIds, Distance = trigger.OutsideDistance, ScaleY = trigger.ScaleY or 1.0, Notify = notifyName })
			waitUntil( notifyName )
			notifiedById = NotifyResultsTable[notifyName]
		end

		if trigger.WithinDistance ~= nil then
			local notifyName = "WithinDistance"..trigger.Name
			local destinationNames = { trigger.TriggerGroup }
			if trigger.TriggerGroups ~= nil then
				destinationNames = CombineTables( destinationNames, trigger.TriggerGroups )
			end
			NotifyWithinDistanceAny({ Ids = { currentRun.Hero.ObjectId }, DestinationNames = destinationNames, DestinationIds = triggerIds, Distance = trigger.WithinDistance, ScaleY = trigger.ScaleY or 1.0, Notify = notifyName })
			waitUntil( notifyName )
			notifiedById = NotifyResultsTable[notifyName]
		end

		currentRun.TriggerRecord[trigger.Name] = true
		notifiedIds[notifiedById] = true

		if trigger.ActivateGroup ~= nil then
			Activate({ Name = trigger.ActivateGroup })
			local ids = GetIds({ Name = trigger.ActivateGroup })
			for k, id in pairs( ids ) do
				local name = GetName({ Id = id })
				local enemyData = EnemyData[name]
				if enemyData ~= nil then
					local newEnemy = DeepCopyTable( enemyData )
					newEnemy.ObjectId = id
					SetupEnemyObject( newEnemy, currentRun )
				end
			end
		end

		if trigger.DeleteGroup ~= nil then
			Destroy({ Ids = GetIds({ Name = trigger.DeleteGroup }) })
		end

		local triggerId = nil
		local triggerTable = nil
		if triggerIds ~= nil then
			triggerId = triggerIds[1]
			triggerTable = ActiveEnemies[triggerId] -- @refactor Return the actual table from the notify
		end

		if trigger.ChanceToTrigger ~= nil and not RandomChance( trigger.ChanceToTrigger ) then
			break
		end

		if trigger.VoiceLines ~= nil then
			thread( PlayVoiceLines, trigger.VoiceLines, nil, triggerTable )
		end

		if trigger.GlobalVoiceLines ~= nil then
			thread( PlayVoiceLines, GlobalVoiceLines[trigger.GlobalVoiceLines], true, triggerTable )
		end

		if trigger.Stinger ~= nil then
			PlaySound({ Name = trigger.Stinger, Delay = 0.5 })
		end

		if trigger.LockToCharacter ~= nil then
			for k, id in pairs( triggerIds ) do
				local name = GetName({ Id = id })
				local npcData = EnemyData[name]
				if npcData.Quip ~= nil then
					PlaySound({ Name = npcData.Quip, Id = id })
				end
				if npcData.HailAnimation ~= nil then
					SetAnimation({ Name = npcData.HailAnimation, DestinationId = id })
				end
				thread( PanToTargetAndBack, id )
			end
		end

		if trigger.SetFlagTrue ~= nil then
			GameState.Flags[trigger.SetFlagTrue] = true
		end
		if trigger.SetFlagFalse ~= nil then
			GameState.Flags[trigger.SetFlagFalse] = false
		end

		if trigger.FunctionName ~= nil then
			local triggerFunction = _G[trigger.FunctionName]
			manualFunctionCall( trigger.FunctionName, trigger.Args )
			thread( triggerFunction, triggerSource, trigger.Args )
		elseif trigger.Function ~= nil then
			thread( trigger.Function, triggerSource, trigger.Args )
		end
		if trigger.PresentDevotionChoice ~= nil then
			thread( DevotionTestPresentation )
		end
		-- AlphaObjectOut/In are for a visual prototype & should be replaced; used in DOF experiment in RoomStoryOutside_01
		if trigger.AlphaObjectOut ~= nil then
			SetAlpha({ Id = trigger.AlphaObjectOut, Fraction = 0.0, Duration = 1.0 })
		end
		if trigger.AlphaObjectIn ~= nil then
			if trigger.AlphaObjectIn == "Self" then
				SetAlpha({ Id = notifiedById, Fraction = 1.0, Duration = 1.0 })
			else
				SetAlpha({ Id = trigger.AlphaObjectIn, Fraction = 1.0, Duration = 1.0 })
			end
		end

		if trigger.ShakeSelf ~= nil then
			Flash({ Id = triggerSource.ObjectId, Speed = 1, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.White, ExpireAfterCycle = true })
			Shake({ Id = triggerSource.ObjectId, Distance = 3, Speed = 150, Duration = 0.65 })
		end

		if trigger.PostTriggerVfx ~= nil then
			CreateAnimation({ Name = trigger.PostTriggerVfx, DestinationId = triggerSource.ObjectId, OffsetX = triggerSource.AnimOffsetX, OffsetZ = triggerSource.AnimOffsetZ, Group = "Combat_UI_World" })
		end

		if trigger.PostTriggerAnimation ~= nil then
			SetAnimation({ Name = trigger.PostTriggerAnimation, DestinationId = triggerSource.ObjectId })
		end

		if trigger.PostTriggerAngleTowardTarget ~= nil then
			AngleTowardTarget({ Id = triggerSource.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		end

		if trigger.PreTriggerVfx ~= nil then
			StopAnimation({ Name = trigger.PreTriggerVfx, DestinationId = triggerSource.ObjectId })
		end

		if trigger.PreTriggerSound ~= nil then
			StopSound({ Id = triggerSource.PreTriggerSoundId, Duration = 0.2 })
		end

		if trigger.InCombatText ~= nil then
			trigger.InCombatText.TargetId = triggerSource.ObjectId
			thread( InCombatTextArgs, trigger.InCombatText )
		end

		if trigger.StatusAnimation ~= nil then
			PlayStatusAnimation( triggerSource, { Animation = trigger.StatusAnimation } )
		end
		if trigger.Emote ~= nil then
			PlayEmote( { TargetId = triggerId, AnimationName = trigger.Emote, OffsetZ = triggerSource.EmoteOffsetZ } )
		end

		if trigger.PostTriggerFunctionName ~= nil then
			local postTriggerFunction = _G[trigger.PostTriggerFunctionName]
			postTriggerFunction( triggerSource, trigger.PostTriggerFunctionArgs )
		end

		if trigger.Repeat then

			wait(0.01)

			local repeatBufferDistance = 10
			if trigger.OutsideDistance ~= nil then
				local notifyName = "OutsideDistanceRepeatBuffer"..(trigger.Name or trigger.TriggerGroup or trigger.TriggerObjectType)
				NotifyWithinDistanceAny({ Ids = { currentRun.Hero.ObjectId }, DestinationNames = { trigger.TriggerGroup }, DestinationIds = triggerIds, Distance = trigger.OutsideDistance - repeatBufferDistance, Notify = notifyName })
				waitUntil( notifyName )
			end
			if trigger.WithinDistance ~= nil then
				local notifyName = "WithinDistanceRepeatBuffer"..(trigger.Name or trigger.TriggerGroup or trigger.TriggerObjectType)
				NotifyOutsideDistanceAll({ Id = currentRun.Hero.ObjectId, DestinationNames = trigger.TriggerGroup, DestinationIds = triggerIds, Distance = trigger.WithinDistance + repeatBufferDistance, Notify = notifyName })
				waitUntil( notifyName )
 			end

			wait(0.01)

			if trigger.OnRepeatSetFlagTrue ~= nil then
				GameState.Flags[trigger.OnRepeatSetFlagTrue] = true
			end
			if trigger.OnRepeatSetFlagFalse ~= nil then
				GameState.Flags[trigger.OnRepeatSetFlagFalse] = false
			end

			if trigger.OnRepeatFunctionName ~= nil then
				local onRepeatFunction = _G[trigger.OnRepeatFunctionName]
				onRepeatFunction( triggerSource, trigger.OnRepeatFunctionArgs )
			end

		elseif trigger.LeaveDistanceBuffer ~= nil then

			if trigger.OutsideDistance ~= nil then
				local notifyName = "OutsideDistanceRepeatBuffer"..(trigger.TriggerGroup or trigger.TriggerObjectType)
				NotifyWithinDistanceAny({ Ids = { currentRun.Hero.ObjectId }, DestinationNames = { trigger.TriggerGroup }, DestinationIds = triggerIds, Distance = trigger.OutsideDistance - trigger.LeaveDistanceBuffer, Notify = notifyName })
				waitUntil( notifyName )
			end
			if trigger.WithinDistance ~= nil then
				local notifyName = "WithinDistanceRepeatBuffer"..(trigger.TriggerGroup or trigger.TriggerObjectType)
				NotifyOutsideDistanceAll({ Ids = { currentRun.Hero.ObjectId }, DestinationNames = { trigger.TriggerGroup }, DestinationIds = triggerIds, Distance = trigger.WithinDistance + trigger.LeaveDistanceBuffer, Notify = notifyName })
				waitUntil( notifyName )
 			end

			thread( PlayVoiceLines, trigger.LeaveVoiceLines, nil, triggerTable )
		end

	end

end

function IsDistanceTriggerEligible( currentRun, trigger, requirements )

	if not IsGameStateEligible( currentRun, trigger, requirements ) then
		return false
	end

	if trigger.TriggerOnceThisRun and currentRun.TriggerRecord[trigger.Name] then
		return false
	end

	return true

end

function PanToTargetAndBack( targetId )
	PanCamera({ Ids = { targetId, CurrentRun.Hero.ObjectId }, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3 })
	wait(3.0)
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
end

function AssignObstacles( eventSource )

	if eventSource.ObstacleData == nil then
		return
	end

	for id, obstacleData in pairs( eventSource.ObstacleData ) do
		local obstacle = DeepCopyTable( obstacleData )
		obstacle.ObjectId = id
		if obstacle.Template ~= nil and ObstacleData[obstacle.Template] ~= nil then
			obstacle = MergeTables( ObstacleData[obstacle.Template], obstacle )
		end
		SetupObstacle( obstacle )
	end

end

function PlayStatusAnimation( source, args )

	local animation = args.Animation

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	if source.BlockStatusAnimations then
		return
	end

	if animation == source.StatusAnimation then
		-- Already playing this
		return
	end

	if not IsAlive({ Id = source.ObjectId }) then
		return
	end

	if source.StatusAnimation ~= nil then
		StopAnimation({ Name = source.StatusAnimation, DestinationId = source.ObjectId })
	end

	source.PrevStatusAnimation = source.StatusAnimation
	source.StatusAnimation = animation
	CreateAnimation({ Name = animation, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })

end

function StopCurrentStatusAnimation( source )
	if source.StatusAnimation ~= nil then
		StopAnimation({ Name = source.StatusAnimation, DestinationId = source.ObjectId })
		source.StatusAnimation = nil
	end
end

function StopStatusAnimation( source, animation )

	if not ConfigOptionCache.ShowUIAnimations then
		return false
	end

	if source == nil then
		return false
	end

	if animation == nil then
		animation = source.StatusAnimation
	else
		if animation ~= source.StatusAnimation then
			-- Not the one currently playing
			return false
		end
	end

	if animation ~= nil then
		StopAnimation({ Name = animation, DestinationId = source.ObjectId })
	end
	source.StatusAnimation = nil

	if source.PrevStatusAnimation ~= nil and source.PrevStatusAnimation ~= source.StatusAnimation then
		source.StatusAnimation = source.PrevStatusAnimation
		if IsAlive({ Id = source.ObjectId }) then
			CreateAnimation({ Name = source.PrevStatusAnimation, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
			source.PrevStatusAnimation = nil
		end
	end
	return true
end


function HandleSecretSpawns( currentRun )

	local currentRoom = currentRun.CurrentRoom

	RandomSynchronize( 13 )

	local secretPointIds = GetIdsByType({ Name = "SecretPoint" })

	-- Secret Door
	if not IsEmpty( secretPointIds ) and IsSecretDoorEligible( currentRun, currentRoom ) then
		currentRoom.ForceSecretDoor = true
		UseHeroTraitsWithValue("ForceSecretDoor", true)
		local secretRoomData = ChooseNextRoomData( currentRun, { RoomDataSet = RoomSetData.Secrets } )
		if secretRoomData ~= nil then
			local secretPointId = RemoveRandomValue( secretPointIds )
			local secretDoor = DeepCopyTable( ObstacleData.SecretDoor )
			secretDoor.ObjectId = SpawnObstacle({ Name = "SecretDoor", Group = "FX_Terrain", DestinationId = secretPointId, AttachedTable = secretDoor })
			SetupObstacle( secretDoor )
			secretDoor.HealthCost = GetSecretDoorCost()
			local secretRoom = CreateRoom( secretRoomData )
			AssignRoomToExitDoor( secretDoor, secretRoom )
			secretDoor.OnUsedPresentationFunctionName = "SecretDoorUsedPresentation"
			currentRun.LastSecretDepth = GetRunDepth( currentRun )
		end
	end
	if not IsEmpty( secretPointIds ) and IsShrinePointDoorEligible( currentRun, currentRoom ) then
		currentRoom.ForceShrinePointDoor = true
		local shrinePointRoomOptions = currentRoom.ShrinePointRoomOptions or RoomSetData.Base.BaseRoom.ShrinePointRoomOptions
		local shrinePointRoomName = GetRandomValue(shrinePointRoomOptions)
		local shrinePointRoomData = RoomSetData.Base[shrinePointRoomName]
		if shrinePointRoomData ~= nil then
			local secretPointId = RemoveRandomValue( secretPointIds )
			local shrinePointDoor = DeepCopyTable( ObstacleData.ShrinePointDoor )
			shrinePointDoor.ObjectId = SpawnObstacle({ Name = "ShrinePointDoor", Group = "FX_Terrain", DestinationId = secretPointId, AttachedTable = shrinePointDoor })
			SetupObstacle( shrinePointDoor )
			shrinePointDoor.ShrinePointReq = currentRoom.ShrinePointDoorCost or ( shrinePointDoor.CostBase + ( shrinePointDoor.CostPerDepth * (currentRun.RunDepthCache - 1) ) )
			local activeShrinePoints = GetTotalSpentShrinePoints()
			local costFontColor = Color.CostAffordable
			if shrinePointDoor.ShrinePointReq > activeShrinePoints then
				costFontColor = Color.CostUnaffordable
			end
			local shrinePointRoom = CreateRoom( shrinePointRoomData, { SkipChooseReward = true } )
			shrinePointRoom.NeedsReward = true
			AssignRoomToExitDoor( shrinePointDoor, shrinePointRoom )
			shrinePointDoor.OnUsedPresentationFunctionName = "ShrinePointDoorUsedPresentation"
			currentRun.LastShrinePointDoorDepth = GetRunDepth( currentRun )
		end
	end

	local challengeBaseIds = GetIdsByType({ Name = "ChallengeSwitchBase" })

	-- Challenge Switch
	if not IsEmpty( challengeBaseIds ) and IsChallengeSwitchEligible( currentRun, TableLength( challengeBaseIds )) then
		local hasForceTrait = HasHeroTraitValue("ForceChallengeSwitch")
		currentRoom.ForceChallengeSwitch = true
		UseHeroTraitsWithValue("ForceChallengeSwitch", true)
		local challengeBaseId = RemoveRandomValue( challengeBaseIds )
		local challengeOptions = {}
		for k, challengeName in pairs( EncounterSets.ChallengeOptions ) do
			local challengeData = ObstacleData[challengeName]
			if challengeData.Requirements == nil or IsGameStateEligible( CurrentRun, challengeData, challengeData.Requirements ) then
				table.insert( challengeOptions, challengeName )
			end
		end
		if not IsEmpty( challengeOptions ) then
			local challengeType = GetRandomValue( challengeOptions )
			local challengeSwitch = DeepCopyTable( ObstacleData[challengeType] )
			currentRoom.ChallengeSwitch = challengeSwitch
			challengeSwitch.ObjectId = challengeBaseId
			local offsetX = challengeSwitch.TextAnchorIdOffsetX
			if IsHorizontallyFlipped({ Id = challengeSwitch.ObjectId }) then
				offsetX = offsetX * -1
			end
			challengeSwitch.TextAnchorId = SpawnObstacle({ Name = "BlankObstacle", Group = "Standing", DestinationId = challengeBaseId })
			Attach({ Id = challengeSwitch.TextAnchorId, DestinationId = challengeBaseId, OffsetX = offsetX, OffsetY = challengeSwitch.TextAnchorIdOffsetY, OffsetZ = challengeSwitch.TextAnchorIdOffsetZ })
			SetThingProperty({ Property = "SortMode", Value = "FromParent", DestinationId = challengeSwitch.TextAnchorId })

			local challengeEncounter = ChooseChallengeEncounter(currentRoom)
			currentRoom.ChallengeEncounter = challengeEncounter
			challengeEncounter.Switch = challengeSwitch
			challengeEncounter.SpawnNearId = challengeSwitch.ObjectId

			local rewardMultiplier = challengeSwitch.RewardMultiplier or 1
			local startingValue = rewardMultiplier * challengeEncounter.StartingValue * (1 + challengeEncounter.ValueDepthRamp * GetRunDepth(CurrentRun)) * GetTotalHeroTraitValue("ChallengeRewardIncrease", {IsMultiplier = true})
			challengeSwitch.StartingValue = round( startingValue )
			challengeSwitch.ValueTextAnchor = SpawnObstacle({ Name = "BlankObstacle", DestinationId = challengeSwitch.ObjectId })
			Attach({ Id = challengeSwitch.ValueTextAnchor, DestinationId = challengeSwitch.ObjectId })
			CreateTextBox({ Id = challengeSwitch.ValueTextAnchor, Text = challengeSwitch.ChallengeText, LuaKey = "Amount", OffsetX = -40 , OffsetY = -220, LuaValue = startingValue, Font = "FellType", FontSize = 40, Color = Color.White, OutlineThickness = 1, OutlineColor = {0.0, 0.0, 0.0,1}, TextSymbolScale = 0.5, })
			ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, FadeTarget = 0, FadeDuration = 0 })

			if challengeSwitch.KeyCost == nil and challengeSwitch.KeyCostMin ~= nil and challengeSwitch.KeyCostMax ~= nil then
				challengeSwitch.KeyCost = RandomInt(challengeSwitch.KeyCostMin, challengeSwitch.KeyCostMax)
			end
			SetupObstacle( challengeSwitch )
			SetAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.LockedAnimationName })
			UseableOn({ Id = challengeSwitch.ObjectId })
			if challengeSwitch.SpawnPropertyChanges ~= nil then
				ApplyUnitPropertyChanges( challengeSwitch, challengeSwitch.SpawnPropertyChanges, true )
			end
			currentRun.LastChallengeDepth = currentRun.RunDepthCache
			challengeBaseId = nil
		end
	end

	-- Well Shop
	if not IsEmpty( challengeBaseIds ) and IsWellShopEligible( currentRun, currentRoom ) then
		currentRoom.ForceWellShop = true
		local challengeBaseId = RemoveRandomValue( challengeBaseIds )
		currentRoom.WellShop = DeepCopyTable( ObstacleData.WellShop )
		currentRoom.WellShop.ObjectId = challengeBaseId
		SetupObstacle( currentRoom.WellShop )
		SetAnimation({ DestinationId = currentRoom.WellShop.ObjectId, Name = "WellShopLocked" })
		UseableOn({ Id = currentRoom.WellShop.ObjectId })
		if currentRoom.WellShop.SpawnPropertyChanges ~= nil then
			ApplyUnitPropertyChanges( currentRoom.WellShop, currentRoom.WellShop.SpawnPropertyChanges, true )
		end
		currentRun.LastWellShopDepth = currentRun.RunDepthCache
		challengeBaseId = nil
	end

	-- Sell Trait Shop
	if not IsEmpty( challengeBaseIds ) and IsSellTraitShopEligible( currentRun, currentRoom ) then
		currentRoom.ForceSellTraitShop = true
		local challengeBaseId = RemoveRandomValue( challengeBaseIds )
		currentRoom.SellTraitShop = DeepCopyTable( ObstacleData.SellTraitShop )
		currentRoom.SellTraitShop.ObjectId = challengeBaseId
		SetupObstacle( currentRoom.SellTraitShop)
		SetAnimation({ DestinationId = currentRoom.SellTraitShop.ObjectId, Name = "SellTraitShopLocked" })
		UseableOn({ Id = currentRoom.SellTraitShop.ObjectId })
		if currentRoom.SellTraitShop.SpawnPropertyChanges ~= nil then
			ApplyUnitPropertyChanges( currentRoom.SellTraitShop, currentRoom.SellTraitShop.SpawnPropertyChanges, true )
		end
		currentRun.LastSellTraitShopDepth = currentRun.RunDepthCache
		challengeBaseId = nil
		GenerateSellTraitShop( currentRun, currentRoom )
	end

	-- Fishing
	local fishingPoints = GetInactiveIdsByType({ Name = "FishingPoint" })
	if not IsEmpty( fishingPoints ) and IsFishingEligible( currentRun, currentRoom ) then
		currentRoom.ForceFishing = true
		UseHeroTraitsWithValue("ForceFishingPoint", true)
		CurrentRun.CurrentRoom.FishingPointId = GetRandomValue(fishingPoints)
		Activate({ Id = CurrentRun.CurrentRoom.FishingPointId })
		currentRun.LastFishingPointDepth = GetRunDepth( currentRun )
	end

end

function IsFishingEligible( currentRun, currentRoom )
	if currentRoom.PersistentFishing and CurrentRun.RoomCreations[currentRoom.Name] then
		for roomIndex = #CurrentRun.RoomHistory, 1, -1 do
			local room = CurrentRun.RoomHistory[roomIndex]
			if room.Name == currentRoom.Name and room.CompletedFishing then
				return false
			end
		end
	end

	if currentRoom.ForceFishing then
		return true
	end

	if currentRoom.FishingPointForceRequirements ~= nil then 
		for k, requirements in pairs(currentRoom.FishingPointForceRequirements) do
			if IsGameStateEligible( currentRun, currentRoom.FishingPointForceRequirements ) then
				return true
			end
		end
	end

	if HasHeroTraitValue( "ForceFishingPoint" ) then
		return true
	end

	if not currentRoom.FishingPointChanceSuccess then
		return false
	end

	if not IsGameStateEligible( currentRun, currentRoom.FishingPointRequirements ) and not HeroHasTrait("FishingTrait") then
		return false
	end

	return true
end

function IsSecretDoorEligible( currentRun, currentRoom )

	if currentRoom.ForceSecretDoor then
		return true
	end

	if HasHeroTraitValue( "ForceSecretDoor" ) then
		return true
	end

	if not currentRoom.SecretChanceSuccess then
		return false
	end

	if not IsGameStateEligible( currentRun, currentRoom.SecretDoorRequirements ) then
		return false
	end

	return true

end

function IsShrinePointDoorEligible( currentRun, currentRoom )

	if currentRoom.ForceShrinePointDoor then
		return true
	end

	if HasHeroTraitValue( "ForceShrinePointDoor" ) then
		return true
	end

	if not currentRoom.ShrinePointDoorChanceSuccess then
		return false
	end

	if not IsGameStateEligible( currentRun, currentRoom.ShrinePointDoorRequirements ) then
		return false
	end

	return true

end

function IsChallengeSwitchEligible( currentRun, numPedestals )

	local currentRoom = currentRun.CurrentRoom
	if numPedestals ~= nil then

		local reservedPedestals = 0
		if currentRoom.ForceWellShop then
			reservedPedestals = reservedPedestals + 1
		end
		if currentRoom.ForceSellTraitShop then
			reservedPedestals = reservedPedestals + 1
		end

		if numPedestals <= reservedPedestals then
			return false
		end
	end

	if currentRoom.ForceChallengeSwitch then
		return true
	end

	if HasHeroTraitValue("ForceChallengeSwitch") then
		return true
	end

	if not currentRoom.ChallengeChanceSuccess then
		return false
	end

	if not IsGameStateEligible( currentRun, currentRoom.ChallengeSwitchRequirements ) then
		return false
	end

	return true

end

function IsWellShopEligible( currentRun, currentRoom )
	if currentRoom.ForceWellShop then
		return true
	end
	if not IsGameStateEligible( currentRun, currentRoom.WellShopRequirements ) then
		return false
	end
	if not currentRoom.WellShopChanceSuccess then
		return false
	end
	return true

end

function IsSellTraitShopEligible( currentRun, currentRoom )

	if currentRoom.ForceSellTraitShop then
		return true
	end

	if not IsGameStateEligible( currentRun, currentRoom.SellTraitShopRequirements ) then
		return false
	end

	if not currentRoom.SellTraitShopChanceSuccess then
		return false
	end

	return true

end

function CreateVignette()
	if not GetConfigOptionValue({ Name = "DrawBloom" }) then
		return
	end
	ScreenAnchors.Vignette = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Vignette" })
	SetAnimation({ Name = "VignetteOverlay", DestinationId = ScreenAnchors.Vignette })
end

function DestroyRequiredKills( args )
	args = args or {}
	local currentEnemies = ShallowCopyTable( RequiredKillEnemies )
	for k, enemy in pairs( currentEnemies ) do
		if args.SkipIds ~= nil and Contains( args.SkipIds, enemy.ObjectId ) then
			-- Skip
		else
			if args.BlockLoot then
				enemy.MoneyDropOnDeath = nil
				enemy.AmmoDropOnDeath = nil
				enemy.MetaPointDropOnDeath = nil
			end
			if args.BlockDeathWeapons then
				SetUnitProperty({ Property = "OnDeathWeapon", Value = "null", DestinationId = enemy.ObjectId })
			end
			thread( Kill, enemy )
			wait( destroyInterval, RoomThreadName )
		end
	end

	if args.DestroyInterval ~= nil then
		DestroyRequiredKills( blockLoot ) -- Call again w/ no interval in case something spawned while waiting (from spawners)
	end
end

function DestroyHadesFightObstacles()
	for k, enemy in pairs( ActiveEnemies ) do
		if enemy.Name == "HadesAmmo" or enemy.Name == "HadesTombstone" then
			SetUnitProperty({ Property = "OnDeathWeapon", Value = "null", DestinationId = enemy.ObjectId })
			thread( Kill, enemy )
		end
	end
end

function DisableTrap( enemy )
	if enemy.ToggleTrap then
		enemy.DisableAIWhenReady = true
		if enemy.DisabledAnimation ~= nil then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DisabledAnimation })
		end
	elseif enemy.DestroyOnTrapDisable then
		Kill( enemy )
	end
end

function EnableTrap( enemy )
	if enemy.ToggleTrap and enemy.AIDisabled then
		enemy.AIDisabled = false
		if enemy.AIOptions ~= nil and not IsEmpty(enemy.AIOptions) then
			thread(SetAI, GetRandomValue(enemy.AIOptions), enemy, CurrentRun)
		end
	elseif enemy.DisableAIWhenReady then
		if enemy.IdleAnimation ~= nil then
			SetAnimation({ Name = enemy.IdleAnimation, DestinationId = enemy.ObjectId })
		end
		enemy.DisableAIWhenReady = false
	end
end

function DisableRoomTraps()
	CurrentRun.CurrentRoom.BlockDisableTraps = true
	for enemyId, enemy in pairs( ActiveEnemies ) do
		DisableTrap( enemy )
	end
	ExpireProjectiles({ Name = "SmokeTrapWeapon" })
end
function EnableRoomTraps( )
	CurrentRun.CurrentRoom.BlockDisableTraps = false
	for enemyId, enemy in pairs( ActiveEnemies ) do
		EnableTrap(enemy)
	end
end

function ConsecrationFieldDeath( triggerArgs, traitDataArgs )
	if triggerArgs.name == "ConsecrationField" then
		CurrentRun.CurrentRoom.BlockDisableTraps = nil
	end

end

function DisableTraps( owner, weaponData, args )
	local disabledTraps = {}
	if CurrentRun.CurrentRoom.BlockDisableTraps then
		return
	end
	CurrentRun.CurrentRoom.BlockDisableTraps = true

	local ids = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", Distance = args.Range, PreciseCollision = true, ScaleY = 0.6, ScaleX = 1 })
	for _, id in pairs( ids ) do
		local enemy = ActiveEnemies[id]
		if enemy and enemy.ToggleTrap then
			DisableTrap( enemy )
			table.insert( disabledTraps, enemy )
		end
	end
	wait( args.Duration, RoomThreadName )
	if IsCombatEncounterActive( CurrentRun ) then
		for _, enemy in pairs( disabledTraps ) do
			EnableTrap(enemy)
		end
	end
end

function PickRoomEliteTypeUpgrades( room )
	local roomEliteTypes = {}
	for k, wave in pairs(room.Encounter.SpawnWaves) do
		for index, spawnData in ipairs( wave.Spawns ) do
			if EnemyData[spawnData.Name].IsElite then
				table.insert(roomEliteTypes, spawnData.Name)
			end
		end
	end
	local eliteTypeUpgradeCount = room.EliteTypeUpgradeCount or 1
	for i = 1, eliteTypeUpgradeCount do
		local eliteType = RemoveRandomValue(roomEliteTypes)
		if eliteType ~= nil then
			PickEliteAttributes( room, EnemyData[eliteType] )
			RemoveAllValues(roomEliteTypes, eliteType)
		end
	end
end