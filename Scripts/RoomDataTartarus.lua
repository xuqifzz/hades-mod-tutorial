RoomSetData.Tartarus =
{
	BaseTartarus =
	{
		DebugOnly = true,

		LegalEncounters = EncounterSets.TartarusEncountersDefault,
		ChallengeEncounterName = "TimeChallengeTartarus",
		LocationText = "Location_Tartarus",
		LocationTextShort = "Location_Tartarus_Short",
		ResultText = "RunHistoryScreenResult_Tartarus",
		RichPresence = "#RichPresence_Tartarus",
		DevotionEncounters = {"DevotionTestTartarus"},
		SecretSpawnChance = 0.15,
		SecretDoorRequirements =
		{
			RequiredTextLines = { "HermesFirstPickUp" },
			RequiredFalseTextLinesThisRun = { "HermesFirstPickUp" },
			-- run rollout preqs
			RequiredFalseTextLinesThisRun = { "CharonFirstMeeting", "CharonFirstMeeting_Alt", "HermesFirstPickUp", "SisyphusFirstMeeting" },

			RequiredMinRoomsSinceSecretDoor = 10,
		},
		ShrinePointDoorCost = 5,
		ShrinePointDoorSpawnChance = 0.15,
		ShrinePointDoorRequirements =
		{
			RequiredScreenViewed = "ShrineUpgrade",
			RequiredMinRoomsSinceShrinePointDoor = 8,
			RequireEncounterCompleted = "EnemyIntroFight01",
			RequiredCosmetics = { "ShrinePointGates", },
		},
		ChallengeSpawnChance = 0.25,
		ChallengeSwitchRequirements =
		{
			RequiredMinBiomeDepth = 7,
			RequiredMinRoomsSinceChallengeSwitch = 7,
		},
		WellShopSpawnChance = 0.30,
		WellShopRequirements =
		{
			RequiredMinBiomeDepth = 4,
			RequiredMinCompletedRuns = 1,
			RequiredMinRoomsSinceWellShop = 3,
		},
		SellTraitShopChance = 0.0, -- purposefully blocked in Tartarus
		SellTraitShopRequirements =
		{
			RequiredMinBiomeDepth = 4,
			RequiredMinCompletedRuns = 1,
			RequiredUpgradeableGodTraits = 3,
			RequiredMinRoomsSinceSellTraitShop = 6,
		},
		FishingPointChance = 0.25,
		FishingPointRequirements =
		{
			RequiredCosmetics = { "FishingUnlockItem" },
			RequiredMinRoomsSinceFishingPoint = 10,
		},
		TrapOptions = EnemySets.TrapsBiome1,
		UsePromptOffsetX = 20,
		UsePromptOffsetY = -100,
		StopSecretMusic = true,
		ShopSecretMusic = "/Music/CharonShopTheme",
		MaxAppearancesThisBiome = 1,
		SoftClamp = 0.75,
		BreakableOptions = { "BreakableIdle1", "BreakableIdle2", "BreakableIdle3" },
		BreakableValueOptions = { MaxHighValueBreakables = 3 },

		SwapSounds =
		{
			["/SFX/Player Sounds/FootstepsHardSurface"] = "/SFX/Player Sounds/FootstepsHardSurface",
			["/SFX/Player Sounds/FootstepsHardSurfaceRun"] = "/SFX/Player Sounds/FootstepsHardSurfaceRun",
		},
	},

	RoomSimple01 =
	{
		InheritFrom = { "BaseTartarus" },

		MaxAppearancesThisBiome = 1,
		ForceIfEncounterNotCompleted = "EnemyIntroFight01",
		LegalEncounters = { "EnemyIntroFight01", "GeneratedTartarus", },
		NumExits = 1,
		IneligibleRewards = { "Devotion" },
		
		GameStateRequirements =
		{
			RequiredMaxBiomeDepth = 5,
		},

		ForcedRewardStore = "RunProgress",
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "AthenaUpgrade",
				GameStateRequirements =
				{
					RequiredFalseTextLines = { "AthenaFirstPickUp", },
				}
			},
		},

		ForceCommonLootFirstRun = true,
		ForceLootTableFirstRun = { "AthenaWeaponTrait", "AthenaRushTrait", "AthenaRangedTrait" },
		IntroSequenceDuration = 0.8,
		EntranceDirection = "Right",
		ZoomFraction = 1.0,
		CameraZoomWeights =
		{
			[430025] = 0.94,
			[40012] = 1.0,
			[40020] = 1.0,
		},

		Ambience = "/Leftovers/Object Ambiences/EvilLairAmbienceMatchSiteE",

		FlipHorizontalChance = 0.0,

		DistanceTriggers =
		{
			-- Intro
			{
				TriggerGroup = "GroundEnemies", WithinDistance = 600, RequiredCompletedRuns = 0,
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					PreLineWait = 0.01,
					-- I'm leaving. Try and stop me.
					{ Cue = "/VO/ZagreusScratch_0005", PlayOnce = true },
				},
			},
		},
	},

	A_PreBoss01 =
	{
		InheritFrom = { "BaseTartarus" },

		LinkedRooms = { "A_Boss01", "A_Boss02", "A_Boss03" },
		ForceAtBiomeDepthMin = 11,
		ForceAtBiomeDepthMax = 11,

		GameStateRequirements =
		{
			-- None
		},

		Binks =
		{
			"CharonIdleShop_Bink",
			"CharonIdleGreeting_Bink",
		},

		LegalEncounters = { "Shop" },
		ForcedFirstReward = "Shop",
		ForcedRewardStore = "RunProgress",
		IneligibleRewards = { "Devotion", "RoomRewardMoneyDrop", },
		NumExits = 1,

		DisableRewardMagnetisim = true,

		ZoomFraction = 0.85,

		EntranceDirection = "LeftRight",
		FlipHorizontalChance = 0.0,
		BlockRunProgressUI = true,

		-- MusicActiveStems = { "Bass", "Drums" },
		-- MusicMutedStems = { "Guitar" },

		SpawnRewardOnId = 486416,

		InspectPoints =
		{
			[370027] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					A_PreBoss_01_FirstInspect =
					{
						-- And I can reckon quite a bit.
						EndCue = "/VO/ZagreusField_0931",
						EndWait = 0.3,
						{ Cue = "/VO/Storyteller_0195",
							Text = "{#DialogueItalicFormat}Beyond the present chamber lies the outermost perimeter of Tartarus, promising terrifying dangers far beyond the Underworld Prince's reckoning." },
					},
				},
			},
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "WeaponShop", WithinDistance = 1600,
				VoiceLines =
				{
					-- The gods were pleased with all his bravery.
					-- { Cue = "/VO/Storyteller_0046", PreLineWait = 0.35 },
				},
			},
		},

		ObstacleData =
		{
			[507864] = {
				OnHitCrowdReaction =
				{
					AnimationName = "StatusIconFear",
					ReactionChance = 0.55,
					Shake = true,
					Ids = { 508121, 508118, 508122, 508119, 508123, 508120, },
					Cooldown = 8.0,
				},
			},
			[507819] = {
				OnHitCrowdReaction =
				{
					AnimationName = "StatusIconFear",
					ReactionChance = 0.55,
					Shake = true,
					Ids = { 508084, 508083, 508088, 508086, 508085, 508087, },
					Cooldown = 8.0,
				},
			},
		},

		-- @ make GlobalVoiceLines
		ExitVoiceLines =
		{
			PreLineWait = 0.35,
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlayAll = 0.6,
			RequiredTextLines = { "Fury2FirstAppearance", "Fury3FirstAppearance" },
			RequiredInactiveMetaUpgrade = "BossDifficultyShrineUpgrade",

			-- Who's it going to be.
			{ Cue = "/VO/ZagreusField_1567" },
			-- Which sister this time.
			{ Cue = "/VO/ZagreusField_1568", RequiredPlayed = { "/VO/ZagreusField_1567" } },
			-- One Fury sister, coming up.
			{ Cue = "/VO/ZagreusField_1569", RequiredPlayed = { "/VO/ZagreusField_1567" } },
			-- Time to face the Furies.
			{ Cue = "/VO/ZagreusField_1570", RequiredPlayed = { "/VO/ZagreusField_1567" } },
			-- I bet Alecto's next.
			{ Cue = "/VO/ZagreusField_1571", RequiredPlayed = { "/VO/ZagreusField_1567" } },
			-- I'll guess... Alecto.
			{ Cue = "/VO/ZagreusField_1572", RequiredPlayed = { "/VO/ZagreusField_1567" } },
			-- Guessing Alecto.
			{ Cue = "/VO/ZagreusField_1573", RequiredPlayed = { "/VO/ZagreusField_1567" } },
			-- I bet it's Meg again.
			{ Cue = "/VO/ZagreusField_1574", RequiredPlayed = { "/VO/ZagreusField_1567" } },
			-- Please be Meg?
			{ Cue = "/VO/ZagreusField_1575", RequiredPlayed = { "/VO/ZagreusField_1567" } },
			-- Please be Meg.
			{ Cue = "/VO/ZagreusField_1576", RequiredPlayed = { "/VO/ZagreusField_1567" } },
			-- I bet Tisipone's up.
			{ Cue = "/VO/ZagreusField_1577", RequiredPlayed = { "/VO/ZagreusField_1567" } },
			-- Time for Tisiphone maybe?
			{ Cue = "/VO/ZagreusField_1578", RequiredPlayed = { "/VO/ZagreusField_1567" } },
			-- Got a feeling it's Tisiphone this time.
			{ Cue = "/VO/ZagreusField_1579", RequiredPlayed = { "/VO/ZagreusField_1567" } },
		},

		MusicMutedStems = { "Drums" },
		ReverbValue = 2.0,
	},

	A_Boss01 =
	{
		InheritFrom = {"BaseTartarus", "RandomizeTrapTypes"},
		RewardPreviewIcon = "RoomElitePreview4",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",
		ResultText = "RunHistoryScreenResult_A_Boss01",
		RichPresence = "#RichPresence_ABoss01",
		TrapOptions = EnemySets.TrapsBiome1,

		GameStateRequirements =
		{
			-- None
		},

		RequiresLinked = true,
		LinkedRoom = "A_PostBoss01",
		ForceIfUnseenForRuns = 6,
		Milestone = true,
		MilestoneIcon = "BossIcon",
		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		LegalEncounters = { "BossHarpy1", },
		FirstClearRewardStore = "SuperMetaProgress",
		ForcedRewardStore = "MetaProgress",
		EligibleRewards = { "RoomRewardMetaPointDrop", "RoomRewardMetaPointDropRunProgress", "SuperLockKeyDrop" },
		NoReroll = true,
		RewardConsumableOverrides =
		{
			ValidRewardNames = { "RoomRewardMetaPointDrop", "RoomRewardMetaPointDropRunProgress", },
			AddResources =
			{
				MetaPoints = 50,
			},
		},
		EntranceDirection = "Right",
		BlockRunProgressUI = true,
		BlockTreasureImps = true,
		ZoomFraction = 0.9,
		NumExits = 1,
		SkipLastKillPresentation = true,
		LogShrineClears = true,
		GenusName = "A_Boss",

		FlipHorizontalChance = 0.0,

		EntranceFunctionName = "RoomEntranceBoss",
		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 50002 },
		IntroSequenceDuration = 2.7,
		BlockCameraReattach = true,

		EnterGlobalVoiceLines = "EnteredFuryChamberVoiceLines",

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 50002 },
					SetupBossIds = { 50002 },
					VoiceLines =
					{
						PreLineWait = 0.2,
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.66,
						ObjectType = "Harpy",

						-- Hmm.
						{ Cue = "/VO/MegaeraHome_0061" },
						-- Tsch.
						{ Cue = "/VO/MegaeraHome_0053", RequiredPlayed = { "/VO/MegaeraHome_0061" }, },
						-- So...
						{ Cue = "/VO/MegaeraField_0407", RequiredTextLines = { "MegaeraGift03" }, },
						-- Oh.
						-- { Cue = "/VO/MegaeraHome_0074", RequiredTextLines = { "MegaeraGift02" }, },
						-- Hmph.
						{ Cue = "/VO/MegaeraHome_0057", RequiredTextLines = { "MegaeraGift02" }, },
						-- <Laughter>
						{ Cue = "/VO/MegaeraField_0375", RequiredTextLines = { "MegaeraGift10" }, },
						-- <Laughter>
						-- { Cue = "/VO/MegaeraField_0376", RequiredTextLines = { "MegaeraGift10" }, },
						-- <Laughter>
						-- { Cue = "/VO/MegaeraField_0377", RequiredTextLines = { "MegaeraGift10" }, },
						-- Ready, Alecto.
						{ Cue = "/VO/MegaeraField_0339", RequiredMaxSupportAINames = 1, RequiredSupportAINames = { "Alecto" }, },
						-- Ready, Sister!
						{ Cue = "/VO/MegaeraField_0340", RequiredMaxSupportAINames = 1, RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 }, },
						-- Ready, Tis.
						{ Cue = "/VO/MegaeraField_0354", RequiredMaxSupportAINames = 1, RequiredSupportAINames = { "Tisiphone" }, },
						-- Ready, sisters.
						{ Cue = "/VO/MegaeraField_0359", RequiredSupportAINames = { "Tisiphone", "Alecto" }, },
						-- Ready, sisters?
						{ Cue = "/VO/MegaeraField_0360", RequiredSupportAINames = { "Tisiphone", "Alecto" }, },
						-- Alecto, Tis, you ready?
						{ Cue = "/VO/MegaeraField_0362", RequiredSupportAINames = { "Tisiphone", "Alecto" }, },
						-- Erinyes, ready.
						{ Cue = "/VO/MegaeraField_0363", RequiredSupportAINames = { "Tisiphone", "Alecto" }, },
					},
				},
			},
			{
				FunctionName = "MultiFuryIntro",
				Args =
				{
					BossId = 50002,
				}
			},
			{
				FunctionName = "CheckAssistHint",
				Args =
				{
					Delay = 10.0,
				}
			},
		},

		InspectPoints =
		{
			[510795] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTextLines = { "Fury2FirstAppearance", "Fury3FirstAppearance" },
				InteractTextLineSets =
				{
					A_Boss_01_Inspect01 =
					{
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							-- They'll just have to try harder next time.
							{ Cue = "/VO/ZagreusField_4673" },
						},
						{ Cue = "/VO/Storyteller_0411",
							Text = "{#DialogueItalicFormat}The Erinyes; known also as the Furies, they are the trusted sentinels of Lord Hades, charged with torturing the worst of mortalkind... and ridding the Underworld of any fool enough to trespass where they do not belong." },
					},
				},
			},
		},

		RequiredKillsObject = "Harpy",
		RequiredKillsCount = 1,

		Ambience = "/Leftovers/Ambience/CreepyHauntedWindLoop",
		MusicSection = 1,
		MusicActiveStems = { "Bass", "Drums" },
		MusicMutedStems = { "Guitar" },
		MusicStartDelay = 0.25,
	},

	A_Boss02 =
	{
		InheritFrom = { "A_Boss01" },
		RewardPreviewIcon = "RoomElitePreview4",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",
		ResultText = "RunHistoryScreenResult_A_Boss02",
		RichPresence = "#RichPresence_ABoss02",
		LegalEncounters = { "BossHarpy2", },

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 510595 },

		GameStateRequirements =
		{
			RequiredKills = { Harpy = 6 },
			-- run rollout prereqs
			RequiredFalseTextLinesThisRun = { "HermesFirstPickUp", "SisyphusFirstMeeting", "ChaosFirstPickUp" },
			RequiredTextLinesPerMetaUpgradeLevel = { TextLines = { "FurySistersUnion01" }, MetaUpgradeName = "BossDifficultyShrineUpgrade", Count = 1 },
		},

		ForceIfUnseenForRuns = 6,

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 510595 },
					SetupBossIds = { 510595 },
					VoiceLines =
					{
						PreLineWait = 0.1,
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.66,
						ObjectType = "Harpy2",

						-- <Laughter>
						{ Cue = "/VO/Alecto_0307", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- <Laughter>
						{ Cue = "/VO/Alecto_0311" },
						-- T'hah.
						{ Cue = "/VO/Alecto_0186", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- Pshh.
						{ Cue = "/VO/Alecto_0213", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- So...!
						{ Cue = "/VO/Alecto_0149", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- Redblood!
						{ Cue = "/VO/Alecto_0383", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- Finally.
						{ Cue = "/VO/Alecto_0384", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- Oh, finally.
						{ Cue = "/VO/Alecto_0385", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- You...!
						{ Cue = "/VO/Alecto_0386", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- Pff.
						{ Cue = "/VO/Alecto_0387", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- Nrrggh....
						{ Cue = "/VO/Alecto_0388", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- Good...
						{ Cue = "/VO/Alecto_0389", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- Well!
						{ Cue = "/VO/Alecto_0390", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- Well, well!
						{ Cue = "/VO/Alecto_0391", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- Oh, good.
						{ Cue = "/VO/Alecto_0392", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- Oh...
						{ Cue = "/VO/Alecto_0393", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- Trash god...
						{ Cue = "/VO/Alecto_0394", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- There you are.
						{ Cue = "/VO/Alecto_0395", RequiredPlayed = { "/VO/Alecto_0311" } },
						-- Erinyes, ready.
						{ Cue = "/VO/Alecto_0296", RequiredSupportAINames = { "Tisiphone", "Megaera" }, RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 }, },
						-- Ready, sisters.
						{ Cue = "/VO/Alecto_0291", RequiredSupportAINames = { "Tisiphone", "Megaera" },	RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 }, },
					},
				},
			},
			{
				FunctionName = "MultiFuryIntro",
				Args =
				{
					BossId = 510595,
				}
			},
		},

		EnterGlobalVoiceLines = "EnteredFuryChamberVoiceLines",

		RequiredKillsObject = "Harpy2",
		RequiredKillsCount = 1,
	},

	A_Boss03 =
	{
		InheritFrom = { "A_Boss01" },
		RewardPreviewIcon = "RoomElitePreview4",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",
		ResultText = "RunHistoryScreenResult_A_Boss03",
		RichPresence = "#RichPresence_ABoss03",
		LegalEncounters = { "BossHarpy3", },

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		RestorePresentationFunction = "Harpy3MapRestore",
		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 510595 },

		GameStateRequirements =
		{
			RequiredKills = { Harpy = 6 },
			-- run rollout prereqs
			RequiredFalseTextLinesThisRun = { "HermesFirstPickUp", "SisyphusFirstMeeting", "ChaosFirstPickUp" },
			RequiredTextLinesPerMetaUpgradeLevel = { TextLines = { "FurySistersUnion01" }, MetaUpgradeName = "BossDifficultyShrineUpgrade", Count = 1 },
		},

		ForceIfUnseenForRuns = 6,

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 510595 },
					SetupBossIds = { 510595 },
					VoiceLines =
					{
						PreLineWait = 0.1,
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.33,
						ObjectType = "Harpy3",

						-- Mrrr...?
						{ Cue = "/VO/Tisiphone_0050" },
						-- Mrr...
						{ Cue = "/VO/Tisiphone_0051" },
						-- Mrr...
						{ Cue = "/VO/Tisiphone_0053" },
						-- Drrr...
						{ Cue = "/VO/Tisiphone_0054" },
						-- Mmmrr...
						{ Cue = "/VO/Tisiphone_0068" },
					},
				},
			},
			{
				FunctionName = "MultiFuryIntro",
				Args =
				{
					BossId = 510595,
				}
			},
		},

		EnterGlobalVoiceLines = "EnteredFuryChamberVoiceLines",

		RequiredKillsObject = "Harpy3",
		RequiredKillsCount = 1,
	},

	A_PostBoss01 =
	{
		InheritFrom = { "BaseTartarus" },
		LegalEncounters = { "Empty" },
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,

		GameStateRequirements =
		{
			-- None
		},

		RequiresLinked = true,
		NextRoomSet = { "Asphodel", },
		RichPresence = "#RichPresence_PostBoss",
		IgnoreMusic = true,
		UseBiomeMap = true,
		BlockRunProgressUI = true,
		Ambience = "/Leftovers/Ambience/CreepyHauntedWindLoop",
		EntranceDirection = "Right",
		NoReward = true,
		NoReroll = true,
		ZoomFraction = 0.75,
		NumExits = 1,
		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 0.9,

		ExitPath = { 558947 },

		SkipLastKillPresentation = true,
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 1.0,
		SellTraitShopChance = 1.0,
		ForceWellShop = true,
		ForceSellTraitShop = true,
		WellShopRequirements =
		{
			-- None
		},
		SecretSpawnChance = 0.0,
		SellTraitShrineUpgrade = true,

		ObstacleData =
		{
			[557482] =
			{
				Template = "HealthFountain",
				Activate = true,
				ActivateIds = { 557482, },
				SetupGameStateRequirements =
				{

				},
			},
			[486504] =
			{
				Template = "GiftRack",
				Activate = true,
				ActivateIds = { 486371, },
				SetupGameStateRequirements =
				{
					RequiredCosmetics = { "PostBossGiftRack", },
				},
			},
			[430000] =
			{
				Template = "ExitDoor",
				InteractDistance = 500,
			},
		},

		ThreadedEvents =
		{
			{ FunctionName = "HadesSpeakingPresentation", Args = { VoiceLines = GlobalVoiceLines.HadesPostBossVoiceLines, StartDelay = 2 } },
			{ FunctionName = "ProcessInterest", Args = { StartDelay = 1 } },
		},
		EnterVoiceLines =
		{
			{
				PreLineWait = 6.8,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.5,

				-- OK...
				{ Cue = "/VO/ZagreusField_0258", RequiredPlayed = { "/VO/ZagreusField_0888" }, },
				-- Got to keep going.
				{ Cue = "/VO/ZagreusField_0259", RequiredPlayed = { "/VO/ZagreusField_0888" }, },
				-- Well, Father? I'm trespassing through your secret hall, and going up.
				{ Cue = "/VO/ZagreusField_0887", RequiredPlayed = { "/VO/ZagreusField_0888" }, RequiredFalseTextLines = { "Ending01" }, },
				-- Don't mind me, Father.
				{ Cue = "/VO/ZagreusField_0888" },
				-- I'll just be a moment, Father.
				{ Cue = "/VO/ZagreusField_0891", PreLineWait = 1.5, RequiredPlayed = { "/VO/ZagreusField_0888" }, },
				-- Off to Asphodel.
				{ Cue = "/VO/ZagreusField_1504", RequiredPlayed = { "/VO/ZagreusField_0888" }, },
				-- Let's hear it, Father.
				{ Cue = "/VO/ZagreusField_1505", PreLineWait = 1.2, RequiredPlayed = { "/VO/ZagreusField_0888" }, },
				-- Well, Father?
				{ Cue = "/VO/ZagreusField_1506", PreLineWait = 1.25, RequiredPlayed = { "/VO/ZagreusField_0888" }, },
				-- Moving on.
				{ Cue = "/VO/ZagreusField_1507", RequiredPlayed = { "/VO/ZagreusField_0888" }, },
				-- Next stop, Asphodel.
				{ Cue = "/VO/ZagreusField_1508", RequiredPlayed = { "/VO/ZagreusField_0888" }, },
			},
		},
		ExitVoiceLines =
		{
			PreLineWait = 0.5,
			RandomRemaining = true,
			BreakIfPlayed = true,
			
			-- Up we go then.
			{ Cue = "/VO/ZagreusField_0260" },
			-- I'll just go on up.
			{ Cue = "/VO/ZagreusField_0889" },
			-- Going up.
			{ Cue = "/VO/ZagreusField_0890" },
			-- Let's go up.
			{ Cue = "/VO/ZagreusField_1588" },
			-- See you, Tartarus.
			{ Cue = "/VO/ZagreusField_1589" },
			-- Heading up.
			{ Cue = "/VO/ZagreusField_1590" },
			-- That's enough Tartarus.
			{ Cue = "/VO/ZagreusField_4386" },
			-- So much for Tartarus.
			{ Cue = "/VO/ZagreusField_4387" },
			-- Broke out of Tartarus.
			{ Cue = "/VO/ZagreusField_4388" },
			-- Till next time, Tartarus.
			{ Cue = "/VO/ZagreusField_4389" },
			-- Nowhere to go but up.
			{ Cue = "/VO/ZagreusField_4390" },
			-- Closer to the surface.
			{ Cue = "/VO/ZagreusField_4391" },
			-- Next floor.
			{ Cue = "/VO/ZagreusField_4392" },
			-- Up we go.
			{ Cue = "/VO/ZagreusField_4393" },
		},

		InspectPoints =
		{
			[557493] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredMinCompletedRuns = 1,
				RequiredTextLines = { "A_PostBoss_01_GearsInspect01" },
				RequiredFalseTextLinesThisRun = { "A_Boss_01_Inspect01" },
				ConsecutiveClearsOfRoom = { Name = "A_Boss01", Count = 2, },
				InteractTextLineSets =
				{
					A_PostBoss_01_FirstInspect =
					{
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							-- Lovely.
							{ Cue = "/VO/ZagreusField_0533" },
						},
						{ Cue = "/VO/Storyteller_0159",
							Text = "{#DialogueItalicFormat}The path from Tartarus is finally laid bare. Far above, the heat from Phlegethon, the river of flame, is faintly felt already... even as its dangers lie in wait." },
					},
				},
			},
			[557494] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					A_PostBoss_01_GearsInspect01 =
					{
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							-- I barge where I please.
							{ Cue = "/VO/ZagreusField_4674" },
						},
						{ Cue = "/VO/Storyteller_0412",
							Text = "{#DialogueItalicFormat}None, other than those in the trusted inner circle of Lord Hades, are authorized to enter the intricate chambers connecting the vast regions of the Underworld; but the Prince decides to barge in, anyway." },
					},
				},
			},
		},
	},

	A_MiniBoss01 =
	{
		InheritFrom = { "BaseTartarus" },

		IsMiniBossRoom = true,
		RewardPreviewIcon = "RoomElitePreview2",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",
		ResultText = "RunHistoryScreenResult_A_MiniBoss01",
		LegalEncounters = { "MiniBossGrenadier" },

		MaxCreationsThisRun = 1,

		GameStateRequirements =
		{
			RequiredFalseSeenRoomsThisRun = { "A_MiniBoss02", "A_MiniBoss03", "A_MiniBoss04" },
		},

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		ForceAtBiomeDepthMin = 5,
		ForceAtBiomeDepthMax = 9,
		NumExits = 1,
		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,
		WellShopSpawnChance = 0.0,

		CameraWalls = false,

		Ambience = "/Leftovers/Object Ambiences/EvilLairAmbienceMatchSiteE",

		MaxAppearancesThisBiome = 1,
		EntranceDirection = "Left",
		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BlockTreasureImps = true,
		ZoomFraction = 0.95,
		CameraZoomWeights =
		{
			[50064] = 1.0,
			[40001] = 0.9,
		},

		BoonRaritiesOverride = { LegendaryChance = 0.1, EpicChance = 0.25, RareChance = 1.0 },
		SecretSpawnChance = 0.0,

		ThreadedEvents =
		{
			{ FunctionName = "MiniBossRoomPresentation" },
		},
		UnthreadedEvents =
		{
			{
				FunctionName = "CheckAssistHint",
				Args =
				{
					Delay = 10.0,
				}
			},
		},

		CombatResolvedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 2.0,
			SuccessiveChanceToPlayAll = 0.66,
			ThreadName = "RoomThread",

			-- Anyone else...?
			{ Cue = "/VO/ZagreusField_0653" },
			-- Had enough?
			{ Cue = "/VO/ZagreusField_0654" },
			-- That's what you get.
			{ Cue = "/VO/ZagreusField_0655" },
		},
	},

	A_MiniBoss02 =
	{
		InheritFrom = { "A_MiniBoss01" },
		
		LegalEncounters = { "MiniBossHeavyRangedSplitter2" },
		ResultText = "RunHistoryScreenResult_A_MiniBoss02",		

		GameStateRequirements =
		{
			RequiredFalseSeenRoomsThisRun = { "A_MiniBoss01", "A_MiniBoss03", "A_MiniBoss04" },
			RequiredActiveMetaUpgrade = "MinibossCountShrineUpgrade",
			RequiredSeenEncounter = "BossHarpy1",
		},

		ZoomFraction = 0.95,

		NumExits = 1,
		EntranceDirection = "Left",

		CombatResolvedVoiceLines =
		{
			[1] = GlobalVoiceLines.CrystalMiniBossDefeatedVoiceLines,
		},
	},

	A_MiniBoss03 =
	{
		InheritFrom = { "A_MiniBoss01" },
		LegalEncounters = { "MiniBossWretchAssassin" },
		ResultText = "RunHistoryScreenResult_A_MiniBoss03",
		
		GameStateRequirements =
		{
			RequiredFalseSeenRoomsThisRun = { "A_MiniBoss01", "A_MiniBoss02", "A_MiniBoss04" },
			RequiredSeenEncounter = "BossHades",
		},

		ZoomFraction = 0.90,

		NumExits = 1,
		EntranceDirection = "Right",

		CombatResolvedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 2.0,
			SuccessiveChanceToPlayAll = 0.66,
			ThreadName = "RoomThread",

			-- That'll show you.
			{ Cue = "/VO/ZagreusField_3718", RequiredPlayed = { "/VO/ZagreusField_3721" }, },
			-- See you next time, I'm sure?
			{ Cue = "/VO/ZagreusField_3719", RequiredPlayed = { "/VO/ZagreusField_3721" }, },
			-- That's what you get.
			{ Cue = "/VO/ZagreusField_3720", RequiredPlayed = { "/VO/ZagreusField_3721" }, },
			-- Back to the shadows.
			{ Cue = "/VO/ZagreusField_3721" },
			-- Who's laughing now?
			{ Cue = "/VO/ZagreusField_3952", RequiredPlayed = { "/VO/ZagreusField_3721" }, },
			-- Stay out of my way next time.
			{ Cue = "/VO/ZagreusField_3953", RequiredPlayed = { "/VO/ZagreusField_3721" }, },
			-- Takes care of that.
			{ Cue = "/VO/ZagreusField_3954", RequiredPlayed = { "/VO/ZagreusField_3721" }, },
			-- You stab me, I stab you.
			{ Cue = "/VO/ZagreusField_3955", RequiredPlayed = { "/VO/ZagreusField_3721" }, },
		},

		InspectPoints =
		{
			[555812] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredMinCompletedRuns = 1,
				InteractTextLineSets =
				{
					A_MiniBoss03_01_FirstInspect =
					{
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							RequiredMinElapsedTime = 3,
							UsePlayerSource = true,
							-- Let's do this again sometime!
							{ Cue = "/VO/ZagreusField_3905" },
						},
						{ Cue = "/VO/Storyteller_0368",
							Text = "{#DialogueItalicFormat}The most violent wretches of Tartarus are sealed away even from other condemned souls; their only visitors, those fool enough to attempt escape." },
					},
				},
			},
		},

	},

	A_MiniBoss04 =
	{
		InheritFrom = { "A_MiniBoss01" },
		LegalEncounters = { "MiniBossHeavyRangedSplitter" },
		ResultText = "RunHistoryScreenResult_A_MiniBoss02",

		GameStateRequirements =
		{
			RequiredFalseSeenRoomsThisRun = { "A_MiniBoss01", "A_MiniBoss02", "A_MiniBoss03" },
			RequiredInactiveMetaUpgrade = "MinibossCountShrineUpgrade",
			RequiredSeenEncounter = "BossHarpy1",
		},

		ZoomFraction = 0.90,

		NumExits = 1,
		EntranceDirection = "Right",

		CombatResolvedVoiceLines =
		{
			[1] = GlobalVoiceLines.CrystalMiniBossDefeatedVoiceLines,
		},

		InspectPoints =
		{
			[555812] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					A_MiniBoss04_01_FirstInspect =
					{
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							RequiredMinElapsedTime = 3,
							UsePlayerSource = true,
							-- They basically turn into big crystals.
							{ Cue = "/VO/ZagreusField_3904" },

						},
						{ Cue = "/VO/Storyteller_0367",
							Text = "{#DialogueItalicFormat}Damned, lost souls with nowhere left to turn congregate in deepest Tartarus, where they fuse together with the earth itself into odious forms which defy description." },
					},
				},
			},
		},

	},

	-- small combat arena
	A_Combat01 =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypes" },
		IneligibleRewards = { "Devotion" },

		GameStateRequirements =
		{
			RequiredMaxBiomeDepth = 6,
		},

		EntranceDirection = "Right",
		NumExits = 1,
		ZoomFraction = 0.95,
	},

	-- medium combat arena
	A_Combat02 =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		EntranceDirection = "LeftRight",
		NumExits = 1,
		ZoomFraction = 0.85,
		ZoomFractionSwitch = 0.9,
	},

	A_Combat03 =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		EntranceDirection = "Right",
		NumExits = 1,
		ZoomFraction = 0.9,
	},

	-- barrel + dart + small arena
	A_Combat04 =
	{
		InheritFrom = { "BaseTartarus" },
		LegalEncounters = EncounterSets.TartarusEncountersNoSurvival,
		IneligibleRewards = { "Devotion" },

		GameStateRequirements =
		{
			RequiredMaxBiomeDepth = 6,
		},

		EntranceDirection = "Right",
		NumExits = 1,
		ZoomFraction = 0.95,
	},

	-- guys in the middle
	A_Combat05 =
	{
		InheritFrom = { "BaseTartarus" },
		IneligibleRewards = { "Devotion" },

		GameStateRequirements =
		{
			-- None
		},

		EntranceDirection = "Right",
		NumExits = 2,
		ZoomFraction = 0.95,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	-- smaller room l-shape cover
	A_Combat06 =
	{
		InheritFrom = { "BaseTartarus" },
		IneligibleRewards = { "Devotion" },

		GameStateRequirements =
		{
			RequiredMaxBiomeDepth = 6,
		},

		EntranceDirection = "Left",
		NumExits = 2,
		ZoomFraction = 0.95,
	},

	-- smaller room with gaps
	A_Combat07 =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		EntranceDirection = "Right",
		NumExits = 1,
		ZoomFraction = 0.95,
		RushMaxRangeOverride = 535,
	},

	A_Combat08A =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypes" },
		IneligibleRewards = { "Devotion" },

		GameStateRequirements =
		{
			RequiredMaxBiomeDepth = 6,
			RequiredFalseRooms = { "A_Combat08B" },
		},

		EntranceDirection = "Right",
		NumExits = 1,
		ZoomFraction = 0.95,
	},

	A_Combat08B =
	{

		InheritFrom = { "BaseTartarus", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 7,
			RequiredFalseRooms = { "A_Combat08A" },
		},

		EntranceDirection = "Right",
		NumExits = 1,
		ZoomFraction = 0.95,
	},

	-- Long room with enemies spawning near bombs
	A_Combat09 =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypes" },
		IneligibleRewards = { "Devotion" },

		GameStateRequirements =
		{
			RequiredMaxBiomeDepth = 6,
		},

		StartUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 0.5, FractionMax = 1.0, Groups = { "Traps" } } },
		},
		EntranceDirection = "Right",
		NumExits = 1,
		ZoomFraction = 0.95,
	},

	-- U Shaped room with combat focused around pillars
	A_Combat10 =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		EntranceDirection = "Left",
		NumExits = 2,
		ZoomFraction = 0.9,

		Ambience = "/Leftovers/Ambience/MatchSiteIPoolAmbience",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	-- Maze-like room where units can chase you into a corner
	A_Combat11 =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 7,
		},

		EntranceDirection = "Left",
		LegalEncounters = EncounterSets.TartarusEncountersNoSurvival,
		RushMaxRangeOverride = 450,
		NumExits = 2,
		ZoomFraction = 0.9,
	},

	-- Arena Pit
	A_Combat12 =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			RequiredMaxBiomeDepth = 6,
		},

		EntranceDirection = "LeftRight",
		NumExits = 2,
		ZoomFraction = 0.9,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	A_Combat13 =
	{
		InheritFrom = { "BaseTartarus", "AllPrePlacedTraps" },

		GameStateRequirements =
		{
			-- None
		},

		EntranceDirection = "LeftRight",
		NumExits = 1,
		ZoomFraction = 0.85,
		ZoomFractionSwitch = 0.9,
		RushMaxRangeOverride = 525,

		RemoteTrapChains =
		{
			[487027] =
			{
				Chains =
				{
					{ 410161, 410205, 410325, 410314, },
				}
			}
		},
	},

	A_Combat14 =
	{
		InheritFrom = { "BaseTartarus", "AllPrePlacedTraps" },

		GameStateRequirements =
		{
			-- None
		},

		EntranceDirection = "Right",
		NumExits = 1,
		ZoomFraction = 0.85,
		ZoomFractionSwitch = 0.9,
		RushMaxRangeOverride = 525,
	},

	-- Bridge with attackers on both sides
	A_Combat15 =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypesAll" },

		GameStateRequirements =
		{
			-- None
		},

		EntranceDirection = "Left",
		NumExits = 2,
		ZoomFraction = 0.95,
		RushMaxRangeOverride = 525,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	A_Combat16 =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		EntranceDirection = "LeftRight",
		NumExits = 2,
		ZoomFraction = 0.9,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	-- bridge with rows of low impassability
	A_Combat17 =
	{
		InheritFrom = { "BaseTartarus" },

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 7,
		},

		Ambience = "/Leftovers/Ambience/StillWaterAmbience",
		EntranceDirection = "Right",
		LegalEncounters = EncounterSets.TartarusEncountersNoSurvival,
		NumExits = 2,
		ZoomFraction = 0.95,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	-- west-leaning corridor with dart traps
	A_Combat18 =
	{
		InheritFrom = { "BaseTartarus", "AllPrePlacedTraps" },
		
		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 7,
		},

		EntranceDirection = "Right",
		LegalEncounters = EncounterSets.TartarusEncountersNoSurvival,
		NumExits = 1,
		ZoomFraction = 0.9,
	},

	-- antechamber w/ pillars & spikewalls
	A_Combat19 =
	{
		InheritFrom = { "BaseTartarus", "AllPrePlacedTraps" },

		GameStateRequirements =
		{
			-- None
		},

		EntranceDirection = "Right",
		NumExits = 2,
		ZoomFraction = 0.95,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	-- wide chamber with central pillars and surrounding traps
	A_Combat20 =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypes" },
		
		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 7,
		},

		EntranceDirection = "LeftRight",
		NumExits = 2,
		ZoomFraction = 0.9,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	-- apostrophe shape room with pillars and passive spiketraps
	A_Combat21 =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypesAll" },

		GameStateRequirements =
		{
			RequiredMaxBiomeDepth = 6,
		},

		EntranceDirection = "LeftRight",
		LegalEncounters = EncounterSets.TartarusEncountersNoSurvival,
		NumExits = 1,
		ZoomFraction = 0.95,
	},

	-- adjacent rooms with traps on the periphery
	A_Combat24 =
	{
		InheritFrom = { "BaseTartarus", "RandomizeTrapTypesAll" },
		LegalEncounters = EncounterSets.TartarusEncountersNoSurvival,

		GameStateRequirements =
		{
			-- None
		},

		EntranceDirection = "Left",
		RushMaxRangeOverride = 200,
		NumExits = 2,
		ZoomFraction = 0.95,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},


	A_Combat25 =
	{
		InheritFrom = { "BaseTartarus", "AllPrePlacedTraps" },
		DebugOnly = true,

		GameStateRequirements =
		{
			-- None
		},

		EntranceDirection = "LeftRight",
		NumExits = 1,
		ZoomFraction = 0.85,
		ZoomFractionSwitch = 0.9,

		RemoteTrapChains =
		{
			[430045] =
			{
				Chains =
				{
					{ 430025, 430026, 430027, 430028, 430029 },
				}
			},
			[430046] =
			{
				Chains =
				{
					{ 430058, 430057, 430051, 430052, 430056, 430055, 430047, 430048, 430049, 430050, }
				}
			}
		},
	},


	A_Reprieve01 =
	{
		InheritFrom = { "BaseTartarus" },
		IneligibleRewards = { "Devotion", },
		SuppressRewardSpawnSounds = true,
		
		MaxCreationsThisRun = 1,
		LegalEncounters = { "HealthRestore" },
		EntranceDirection = "LeftRight",
		SecretMusic = "/Music/BlankMusicCue",
		--ZoomFraction = 0.75,
		SpawnRewardOnId = 410000,
		IntroSequenceDuration = 0.02,
		NumExits = 2,

		GameStateRequirements =
		{
			RequiredCosmetics = { "TartarusReprieve" },
			RequiredMinCompletedRuns = 0,
			RequiredMinBiomeDepth = 3,
		},

		MusicMutedStems = { "Drums" },
		EnterGlobalVoiceLines = "EnteredReprieveRoomVoiceLines",

		ZoomFraction = 0.975,
		CameraZoomWeights =
		{
			[482574] = 0.90,
			[482572] = 1.10,
			[482573] = 0.90,
		},

		Ambience = "/Leftovers/Ambience/StillWaterAmbience",

		InspectPoints =
		{
			[480765] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredMinCompletedRuns = 1,
				InteractTextLineSets =
				{
					A_Reprieve_01_FirstInspect =
					{
						-- And not a moment too soon.
						EndCue = "/VO/ZagreusField_0532",
						EndWait = 0.4,
						{ Cue = "/VO/Storyteller_0158",
							Text = "{#DialogueItalicFormat}A place of calm and respite, whilst perhaps unimaginable in the Underworld, occasionally is to be found, in fact." },
					},
				},
			},
		},
	},

	A_Shop01 =
	{
		InheritFrom = { "BaseTartarus" },
		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 7,
		LegalEncounters = { "Shop" },
		ForcedReward = "Shop",
		NoReroll = true,

		GameStateRequirements =
		{
			RequiredMinExits = 2,
			RequiredMaxBiomeDepth = 9,
		},

		Binks =
		{
			"CharonIdleShop_Bink",
			"CharonIdleGreeting_Bink",
		},

		SpawnRewardOnId = 486418,

		NumExits = 1,
		ZoomFraction = 0.85,

		EntranceDirection = "Right",

		Ambience = "/Leftovers/Object Ambiences/ShipwreckAmbience",
		SpawnRewardGlobalVoiceLines = "FoundShopVoiceLines",

		InspectPoints =
		{
			[390000] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					CharonFirstInspect =
					{
						-- That would be me.
						EndCue = "/VO/ZagreusField_0674",
						EndWait = 0.3,
						{ Cue = "/VO/Storyteller_0116",
							Text = "{#DialogueItalicFormat}The infernal wares of the stygian boatman, Charon, lie sprawled about, available for sale to whomever would be willing to quench the boatman's great thirst for riches." },
					},
				},
			},
			[515864] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredMinRunsCleared = 1,
				InteractTextLineSets =
				{
					CharonFirstInspect =
					{
						-- Too bad I can't just take the ferry to the surface.
						EndCue = "/VO/ZagreusField_1473",
						EndWait = 0.3,
						{ Cue = "/VO/Storyteller_0221",
							Text = "{#DialogueItalicFormat}The River Styx flows infamously through the Underworld, offering the boatman Charon expeditious travel from the realm of mortals to the lowest depths, where many of their shades reside forever." },
					},
				},
			},
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Charon_01", WithinDistance = 1600,
				VoiceLines =
				{
					-- The gods were pleased with all his bravery.
					-- { Cue = "/VO/Storyteller_0046", PreLineWait = 0.35 },
				},
			},
		},

		-- MusicMutedStems = { "Drums" },
		ReverbValue = 2.0,

		ThreadedEvents =
		{
			{
				FunctionName = "PatrolPath",
				Args =
				{
					GroupName = "GhostShoppers",
					--NewGroupName= "Active3DGhosts",
					--RemoveFromGroup = true,
					--AddToGroup = true,
					MaxPatrols = 40,
					SendPatrolInterval = 0.0,
					SpeedMin = 30,
					SpeedMax = 60,
					Loop = true,
					Path =
					{
						{ Id = 508114, OffsetRadius = 30 },
						{ Id = 508095, OffsetRadius = 50 },
						{ Id = 508096, OffsetRadius = 50 },
						{
							Branch =
							{
								{
									{ Id = 508097, OffsetRadius = 10 },
									{ Id = 508098, OffsetRadius = 10, AngleTowardIdOnStop = 480237, PostArriveWait = 7 },
									{ Id = 508097, OffsetRadius = 10 },
								},
								{
									{ Id = 508099, OffsetRadius = 10 },
									{ Id = 508100, OffsetRadius = 10, AngleTowardIdOnStop = 50074, PostArriveWait = 7 },
									{ Id = 508099, OffsetRadius = 10 },
								},
								{
									{ Id = 508101, OffsetRadius = 10 },
									{ Id = 508102, OffsetRadius = 10, AngleTowardIdOnStop = 480238, PostArriveWait = 7 },
									{ Id = 508101, OffsetRadius = 10 },
								},
								{
									{ Id = 508105, OffsetRadius = 10, AngleTowardIdOnStop = 508106, PostArriveWait = 5, EmoteOnEnd = "Fear", MinUseInterval = 10 },
								},
							},
						},
					},
				},
			},

			{
				FunctionName = "PatrolPath",
				Args =
				{
					GroupName = "GhostBoaters",
					--NewGroupName= "Active3DGhosts",
					--RemoveFromGroup = true,
					--AddToGroup = true,
					MaxPatrols = 5,
					SendPatrolInterval = 6,
					SpeedMin = 40,
					SpeedMax = 60,
					Loop = true,
					Path =
					{
						{ Id = 508103, OffsetRadius = 50 },
						{ Id = 508104, OffsetRadius = 50, PostArriveWait = 10 },
						{ Id = 508103, OffsetRadius = 50 },
						{ Id = 508096, OffsetRadius = 50 },
						{ Id = 508113, OffsetRadius = 50, PostArriveWait = 10 },
					},
				},
			},
		},
	},

	RoomOpening =
	{
		InheritFrom = { "BaseTartarus" },
		Starting = true,
		LegalEncounters = { "OpeningEmpty", "OpeningGenerated" },
		IntroSequenceDuration = 1.8,
		NextRoomSet = { "Tartarus", },

		GameStateRequirements =
		{
			-- None
		},

		ForcedRewardStore = "RunProgress",
		IneligibleRewards = { "Devotion", "RoomRewardMoneyDrop", "RoomRewardMaxHealthDrop", },
		FishingPointChance = 0.1,
		FishingPointRequirements =
		{
			RequiredCosmetics = { "FishingUnlockItem" },
			RequiredMinRoomsSinceFishingPoint = 10,
		},

		ChooseRewardRequirements =
		{
			RequiredTextLines = { "AthenaFirstPickUp", },
		},
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ZeusUpgrade",
				GameStateRequirements =
				{
					RequiredTextLines = { "AthenaFirstPickUp", },
					RequiredFalseTextLines = { "ZeusFirstPickUp", },
				}
			},
			{
				Name = "WeaponUpgrade",
				GameStateRequirements =
				{
					RequiredTextLines = { "ZeusFirstPickUp", },
					RequiredFalseLootPickup = "WeaponUpgrade",
				}
			},
			{
				Name = "Boon",
				LootName = "AphroditeUpgrade",
				GameStateRequirements =
				{
					RequiredTextLines = { "ZeusFirstPickUp", },
					RequiredOnlyNotPickedUp = "AphroditeUpgrade",
					RequiredOnlyNotPickedUpIgnoreName = "DemeterUpgrade",
				}
			},
			{
				Name = "Boon",
				LootName = "ArtemisUpgrade",
				GameStateRequirements =
				{
					RequiredTextLines = { "ZeusFirstPickUp", },
					RequiredOnlyNotPickedUp = "ArtemisUpgrade",
					RequiredOnlyNotPickedUpIgnoreName = "DemeterUpgrade",
				}
			},
			{
				Name = "Boon",
				LootName = "PoseidonUpgrade",
				GameStateRequirements =
				{
					RequiredTextLines = { "ZeusFirstPickUp", },
					RequiredOnlyNotPickedUp = "PoseidonUpgrade",
					RequiredOnlyNotPickedUpIgnoreName = "DemeterUpgrade",
				}
			},
			{
				Name = "Boon",
				LootName = "DionysusUpgrade",
				GameStateRequirements =
				{
					RequiredTextLines = { "ZeusFirstPickUp", },
					RequiredOnlyNotPickedUp = "DionysusUpgrade",
					RequiredOnlyNotPickedUpIgnoreName = "DemeterUpgrade",
				}
			},
			{
				Name = "Boon",
				LootName = "AresUpgrade",
				GameStateRequirements =
				{
					RequiredTextLines = { "ZeusFirstPickUp", },
					RequiredOnlyNotPickedUp = "AresUpgrade",
					RequiredOnlyNotPickedUpIgnoreName = "DemeterUpgrade",
				}
			},
			{
				Name = "Boon",
				LootName = "HermesUpgrade",
				GameStateRequirements =
				{
					RequiredTextLines = {  "AthenaFirstPickUp", "ZeusFirstPickUp", "PoseidonFirstPickUp", "AphroditeFirstPickUp", "ArtemisFirstPickUp", "AresFirstPickUp", "DionysusFirstPickUp" },
					RequiredOnlyNotPickedUp = "HermesUpgrade",
					RequiredOnlyNotPickedUpIgnoreName = "DemeterUpgrade",
				}
			},
			{
				Name = "Boon",
				LootName = "PoseidonUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "PoseidonShoutTrait",
						Rarity = "Epic",
					},
				},
				PostPickupFunction = "FirstTimeFreeWrath",
				ForcedTextLines =
				{
					PoseidonWrathIntro01 =
					{
						{ Cue = "/VO/Poseidon_0139",
							PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 1.0,
							StartSound = "/Leftovers/World Sounds/MapZoomInShort", EndSound = "/SFX/PoseidonBoonWaveCrash",
							Text = "I have to tell you something, little Hades: My relatives and I, we've been holding back one of our greatest gifts!! To see if you were worthy. And you are! My aid is yours, so call me if you need anything! Especially to smash your enemies to bits." },
					},
				},
				-- note: if making any changes to this, please also adjust VoiceLines reqs for PoseidonWrathIntro01 in this file
				GameStateRequirements =
				{
					RequiredMinCompletedRuns = 4,
					RequiredTextLines = { "PoseidonFirstPickUp" },
					RequiredFalseTextLines = { "PoseidonWrathIntro01" },
				}
			},
			{
				Name = "Boon",
				LootName = "DemeterUpgrade",
				GameStateRequirements =
				{
					RequiredSeenRooms = { "D_Boss01" },
					RequiredOnlyNotPickedUp = "DemeterUpgrade",
				}
			},
			{
				Name = "Boon",
				LootName = "PoseidonUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "FishingTrait",
						Rarity = "Legendary",
					},
				},
				-- PostPickupFunction = "FirstTimeFreeWrath",
				ForcedTextLines =
				{
					PoseidonFishQuest01 =
					{
						{ Cue = "/VO/Poseidon_0148",
							PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 1.0,
							StartSound = "/Leftovers/World Sounds/MapZoomInShort", EndSound = "/SFX/PoseidonBoonWaveCrash",
							Text = "Nephew! I'm mightily impressed with your ability to cull those rivers there of all the denizens of my domain! Your crusty father's not entitled to the bounties of the sea! But, on my limitless authority, you {#DialogueItalicFormat}are{#PreviousFormat}! You have my Rod of Fishing... now have {#DialogueItalicFormat}this{#PreviousFormat}!" },
					},
				},
				-- note: if making any changes to this, please also adjust VoiceLines reqs for PoseidonFishQuest01 in this file
				GameStateRequirements =
				{
					RequiredTextLines = { "PoseidonAboutFishing01", "PoseidonWrathIntro01" },
					RequiredFalseTextLinesLastRun = { "PoseidonWrathIntro01" },
					RequiredFalseTextLines = { "PoseidonFishQuest01" },
					RequiredMinTotalCaughtFish = 3,
				}
			},

		},

		EntranceDirection = "Right",
		BlockRunProgressUI = true,
		NumExits = 1,
		ZoomFraction = 0.75,
		EntranceFunctionName = "RoomEntranceOpening",
		CameraZoomWeights =
		{
			[410008] = 1.00,
			[410007] = 1.25,
		},
		SpawnRewardOnId = 410006,

		StartUnthreadedEvents =
		{
			{
				FunctionName = "StartDemoPresentation",
				GameStateRequirements =
				{
					RequiredTrueFlags = { "KioskMode", },
					RequiredMaxCompletedRuns = 0,
				},
			},
			{
				FunctionName = "ShowRunIntro",
				GameStateRequirements =
				{
					RequiredTrueConfigOptions = { "ShowUIAnimations", },
					RequiredFalseConfigOptions = { "EditingMode", },
				},
			},
			{
				FunctionName = "MusicPlayerEvent",
				Args = { TrackName = "/Music/MusicExploration4_MC", },
			},

		},

		UnthreadedEvents =
		{
			{
				FunctionName = "SpawnRoomReward",
				Args =
				{
					VoiceLines =
					{
						PreLineWait = 0.65,
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.5,
						Cooldowns =
						{
							{ Name = "ZagreusStartNewRunSpeech", Time = 10 },
						},

						-- Hoh, what's this.
						{ Cue = "/VO/ZagreusField_0536" },
						-- Already.
						{ Cue = "/VO/ZagreusField_0537" },
						-- Oh good.
						{ Cue = "/VO/ZagreusField_0538", CooldownName = "SaidGoodRecently", CooldownTime = 40, },
						-- Should help me on my way.
						{ Cue = "/VO/ZagreusField_0697" },
						-- A gift from the gods.
						{ Cue = "/VO/ZagreusField_0698" },
						-- Somebody's looking out for me.
						{ Cue = "/VO/ZagreusField_0699" },
						-- Something from Olympus.
						{ Cue = "/VO/ZagreusField_0700" },
						-- Something for my journey.
						{ Cue = "/VO/ZagreusField_0701" },
						-- One for the road.
						{ Cue = "/VO/ZagreusField_0702" },
					},
					WaitUntilPickup = true,
				},
				GameStateRequirements =
				{
					RequiredTextLines = { "AthenaFirstPickUp", },
				},
			},
		},

		ThreadedEvents =
		{
			{ FunctionName = "DisplayLocationText", Args = { Text = "Location_Tartarus" } },
			{ FunctionName = "CheckLocationUnlock", Args = { Biome = "Tartarus" } },
			{
				FunctionName = "PatrolPath",
				Args =
				{
					GroupName = "GhostPatrols",
					NewGroupName= "ActiveGhosts",
					RemoveFromGroup = true,
					AddToGroup = true,
					MaxPatrols = 10,
					SendPatrolInterval = 1.0,
					SpeedMin = 30,
					SpeedMax = 80,
					Path =
					{
						{ Id = 410943, OffsetRadius = 10, },
						{
						Branch =
						{
							{
								{ Id = 410940, OffsetRadius = 10 },
							},
							{
								{ Id = 410957, OffsetRadius = 10, AngleTowardIdOnStop = 410959, PostArriveWait = 5 },
							},
							{
								{ Id = 410956, OffsetRadius = 10, AngleTowardIdOnStop = 410960, PostArriveWait = 5 },
							},
							{
								{ Id = 410958, OffsetRadius = 10 },
								{ Id = 410951, OffsetRadius = 10 },
								{
									Branch =
									{
										{
											{ Id = 410955, OffsetRadius = 10, PostArriveWait = 15, MinUseInterval = 15 },
											{ Id = 410951, OffsetRadius = 10 },
										},

										{
											{ Id = 410954, OffsetRadius = 10, PostArriveWait = 13, MinUseInterval = 13  },
											{ Id = 410951, OffsetRadius = 10 },
										},

									},
								},
								{ Id = 410944, OffsetRadius = 10 },
								{
									Branch =
									{
										{
											{ Id = 410945, OffsetRadius = 10, PostArriveWait = 15, MinUseInterval = 15 },
											{ Id = 410944, OffsetRadius = 10 },
											{ Id = 410951, OffsetRadius = 10 },
											{ Id = 410958, OffsetRadius = 10 },
										},

										{
											{ Id = 410961, OffsetRadius = 10, PostArriveWait = 13, MinUseInterval = 13 },
											{ Id = 410944, OffsetRadius = 10  },
											{ Id = 410951, OffsetRadius = 10 },
											{ Id = 410958, OffsetRadius = 10 },
										},

									},
								},
							},
							{
								{ Id = 410941, OffsetRadius = 10 },
								{
									Branch =
									{
										{
											{ Id = 410942, OffsetRadius = 10, PostArriveWait = 15, MinUseInterval = 15 },
											{ Id = 410941, OffsetRadius = 10 },
										},

										{
											{ Id = 410953, OffsetRadius = 10, PostArriveWait = 13, MinUseInterval = 13 },
											{ Id = 410941, OffsetRadius = 10  },
										},

										{
											{ Id = 410946, OffsetRadius = 10 },
											{ Id = 410947, OffsetRadius = 10, PostArriveWait = 13, MinUseInterval = 13 },
											{ Id = 410946, OffsetRadius = 10 },
											{ Id = 410941, OffsetRadius = 10 },
										},

									},
								},
							},
						},
						},
					},
				},
			},
		},

		-- Room Audio Below This Line
		Music = "/Music/MusicExploration4_MC",
		MusicSection = 1,
		MusicActiveStems = { "Keys", "Drums" },
		MusicStartDelay = 2.75,
		MusicRequirements =
		{
			RequiredMaxCompletedRuns = 0,
		},
		Ambience = "/Leftovers/Ambience/MatchSiteIPoolAmbience",
		EnterVoiceLines =
		{
			-- Good-bye, Father.
			{ Cue = "/VO/ZagreusField_0011", RequiredCompletedRuns = 0, PreLineWait = 3.0 },
			-- To hell with this place.
			{ Cue = "/VO/ZagreusScratch_0004", RequiredCompletedRuns = 0, PreLineWait = 6.0, BreakIfPlayed = true },
			-- Shut up, old man.
			-- { Cue = "/VO/ZagreusScratch_0002b", RequiredCompletedRuns = 0, BreakIfPlayed = true, RequiredFalseFlags = { "KioskMode" }, },
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.15,
				RequiredMinCompletedRuns = 1,
				SkipAnim = true,
				Cooldowns =
				{
					{ Name = "ZagreusStartNewRunSpeech", Time = 10 },
				},
				TriggerCooldowns = { "LootDroppedSpeech" },

				-- Wasn't planning on it.
				{ Cue = "/VO/ZagreusField_0002a", RequiredLastLinePlayed = { "/VO/Hades_0061" }, RequiredFalseTextLines = { "Ending01" }, },
				-- Wasn't about to start.
				{ Cue = "/VO/ZagreusField_4452", RequiredLastLinePlayed = { "/VO/Hades_0061" }, RequiredTextLines = { "Ending01" }, },

				-- No. Not on your life.
				{ Cue = "/VO/ZagreusField_0003", RequiredLastLinePlayed = { "/VO/Hades_0062" }, RequiredFalseTextLines = { "Ending01" }, },
				-- I'm getting there.
				{ Cue = "/VO/ZagreusField_4453", RequiredLastLinePlayed = { "/VO/Hades_0062" }, RequiredTextLines = { "Ending01" }, },

				-- You failed. I won't.
				{ Cue = "/VO/ZagreusField_0004", RequiredLastLinePlayed = { "/VO/Hades_0063" }, RequiredFalseTextLines = { "PersephoneFirstMeeting" }, },
				-- No harm in giving it another shot.
				{ Cue = "/VO/ZagreusField_4454", RequiredLastLinePlayed = { "/VO/Hades_0063" }, RequiredTextLines = { "Ending01" }, },

				-- I'm not staying. Not even for him.
				{ Cue = "/VO/ZagreusField_0005", RequiredLastLinePlayed = { "/VO/Hades_0064" }, RequiredFalseTextLines = { "PersephoneFirstMeeting" }, },
				-- I'm not staying. Not even for him.
				{ Cue = "/VO/ZagreusField_4455", RequiredLastLinePlayed = { "/VO/Hades_0064" }, RequiredTextLines = { "Ending01" }, },

				-- I'll show you.
				{ Cue = "/VO/ZagreusField_0006", RequiredLastLinePlayed = { "/VO/Hades_0065" }, RequiredFalseTextLines = { "Ending01" } },

				-- I'll have to be more careful.
				{ Cue = "/VO/ZagreusField_0007", RequiredLastLinePlayed = { "/VO/Hades_0066" } },

				-- What's life without a little pain.
				{ Cue = "/VO/ZagreusField_0008b", RequiredLastLinePlayed = { "/VO/Hades_0067" }, RequiredFalseTextLines = { "Ending01" } },
				-- Mortals know to make the most of it.
				{ Cue = "/VO/ZagreusField_4456", RequiredLastLinePlayed = { "/VO/Hades_0067" }, RequiredTextLines = { "Ending01" } },

				-- Get out of my head.
				{ Cue = "/VO/ZagreusField_0009", RequiredLastLinePlayed = { "/VO/Hades_0068" }, RequiredFalseTextLines = { "Ending01" } },

				-- Fear is for the weak.
				{ Cue = "/VO/ZagreusField_0010", RequiredLastLinePlayed = { "/VO/Hades_0069" }, },

				-- Good-bye, Father.
				{ Cue = "/VO/ZagreusField_0011", RequiredLastLinePlayed = { "/VO/Hades_0070" }, RequiredFalseTextLines = { "Ending01" } },

				-- I'm well past wondering.
				{ Cue = "/VO/ZagreusField_0560", RequiredLastLinePlayed = { "/VO/Hades_0196" }, RequiredFalseTextLines = { "Ending01" } },
				-- I wonder if I'll beat you once again.
				{ Cue = "/VO/ZagreusField_4457", RequiredLastLinePlayed = { "/VO/Hades_0196" }, RequiredTextLines = { "Ending01" } },

				-- At last I know the gods more than by name.
				{ Cue = "/VO/ZagreusField_0561", RequiredLastLinePlayed = { "/VO/Hades_0197" }, RequiredFalseTextLines = { "Ending01" } },

				-- Blood and darkness, well indeed.
				{ Cue = "/VO/ZagreusField_0562", RequiredLastLinePlayed = { "/VO/Hades_0198" }, },

				-- This one's for you, Achilles.
				{ Cue = "/VO/ZagreusField_0563", RequiredLastLinePlayed = { "/VO/Hades_0199" }, },

				-- That's what you think.
				{ Cue = "/VO/ZagreusField_0564", RequiredLastLinePlayed = { "/VO/Hades_0200" }, RequiredFalseTextLines = { "PersephoneFirstMeeting" } },
				-- I'm leaving, Father. Try and stop me.
				{ Cue = "/VO/ZagreusField_3551", RequiredLastLinePlayed = { "/VO/Hades_0200" }, RequiredTextLines = { "PersephoneFirstMeeting" }, RequiredFalsePlayedThisRun = { "/VO/ZagreusField_3551" }, RequiredFalsePlayedLastRun = { "/VO/ZagreusField_3551" }, },

				-- At least Zeus is helping me.
				{ Cue = "/VO/ZagreusField_0565", RequiredLastLinePlayed = { "/VO/Hades_0201" }, RequiredFalseTextLines = { "PersephoneMeeting06" } },
				-- Glad I'm on his good side...
				{ Cue = "/VO/ZagreusField_4458", RequiredLastLinePlayed = { "/VO/Hades_0201" }, RequiredTextLines = { "PersephoneMeeting06" } },

				-- I'll find my place all right.
				{ Cue = "/VO/ZagreusField_0566", RequiredLastLinePlayed = { "/VO/Hades_0202" }, RequiredFalseTextLines = { "Ending01" } },
				-- I've found my place I think.
				{ Cue = "/VO/ZagreusField_4459", RequiredLastLinePlayed = { "/VO/Hades_0202" }, RequiredTextLines = { "Ending01" } },

				-- My place is with my mother.
				{ Cue = "/VO/ZagreusField_0567", RequiredLastLinePlayed = { "/VO/Hades_0203" }, RequiredFalseTextLines = { "Ending01" } },
				-- He's right.
				{ Cue = "/VO/ZagreusField_4460", RequiredLastLinePlayed = { "/VO/Hades_0203" }, RequiredTextLines = { "Ending01" } },

				-- We've put each other through a lot, haven't we, Meg.
				{ Cue = "/VO/ZagreusField_0568", RequiredLastLinePlayed = { "/VO/Hades_0204" }, },
				-- See you again soon, Meg.
				{ Cue = "/VO/ZagreusField_4461", RequiredLastLinePlayed = { "/VO/Hades_0204" }, RequiredTextLines = { "MegaeraGift10" } },

				-- I'll show you neat and orderly.
				{ Cue = "/VO/ZagreusField_0569", RequiredLastLinePlayed = { "/VO/Hades_0205" }, RequiredFalseTextLines = { "Ending01" } },
				-- No one gets out.
				{ Cue = "/VO/ZagreusField_4462", RequiredLastLinePlayed = { "/VO/Hades_0205" }, RequiredTextLines = { "Ending01" } },

				-- I'll be the judge of that.
				{ Cue = "/VO/ZagreusField_1525", RequiredLastLinePlayed = { "/VO/Hades_0366" }, },
				-- Oh, I don't know, the surface is quite nice.
				{ Cue = "/VO/ZagreusField_4463", RequiredLastLinePlayed = { "/VO/Hades_0366" }, RequiredTextLines = { "Ending01" } },

				-- We gods are all alike.
				{ Cue = "/VO/ZagreusField_1526", RequiredLastLinePlayed = { "/VO/Hades_0367" }, RequiredFalseTextLines = { "Ending01" } },
				-- You don't mean that, Father.
				{ Cue = "/VO/ZagreusField_4464", RequiredLastLinePlayed = { "/VO/Hades_0367" }, RequiredTextLines = { "Ending01" } },

				-- I'll leave my mark all right.
				{ Cue = "/VO/ZagreusField_1527", RequiredLastLinePlayed = { "/VO/Hades_0368" }, },

				-- You got that right.
				{ Cue = "/VO/ZagreusField_1528", RequiredLastLinePlayed = { "/VO/Hades_0369" }, },

				-- File this, Father.
				{ Cue = "/VO/ZagreusField_1529", RequiredLastLinePlayed = { "/VO/Hades_0370" }, RequiredFalseTextLines = { "Ending01" } },
				-- Not even the Pact of Punishment can stop me.
				{ Cue = "/VO/ZagreusHome_2998", RequiredLastLinePlayed = { "/VO/Hades_0370" }, RequiredTextLines = { "Ending01" } },

				-- Nyx, give me strength.
				{ Cue = "/VO/ZagreusField_1530", RequiredLastLinePlayed = { "/VO/Hades_0371" }, RequiredFalseTextLines = { "Ending01" } },

				-- Who's ready for the real afterlife experience?
				{ Cue = "/VO/ZagreusField_1531", RequiredLastLinePlayed = { "/VO/Hades_0372" }, },

				-- I'll show you willfulness.
				{ Cue = "/VO/ZagreusField_1532", RequiredLastLinePlayed = { "/VO/Hades_0373" }, RequiredFalseTextLines = { "Ending01" } },
				-- Guess that's a compliment!
				{ Cue = "/VO/ZagreusField_4466", RequiredLastLinePlayed = { "/VO/Hades_0373" }, RequiredTextLines = { "Ending01" } },

				-- I take some pride in making messes, yes.
				{ Cue = "/VO/ZagreusField_1533", RequiredLastLinePlayed = { "/VO/Hades_0374" }, },

				-- How about I take a closer look.
				{ Cue = "/VO/ZagreusField_1534", RequiredLastLinePlayed = { "/VO/Hades_0375" }, },

				-- You don't need me, and I don't need you.
				{ Cue = "/VO/ZagreusField_1535", RequiredLastLinePlayed = { "/VO/Hades_0376" }, RequiredFalseTextLines = { "Ending01" } },
				-- How times have changed.
				{ Cue = "/VO/ZagreusField_4467", RequiredLastLinePlayed = { "/VO/Hades_0376" }, RequiredTextLines = { "Ending01" } },

				-- I'm no mere mortal.
				{ Cue = "/VO/ZagreusField_1536", RequiredLastLinePlayed = { "/VO/Hades_0377" }, },

				-- If only you could see me now, Father.
				{ Cue = "/VO/ZagreusField_1537", RequiredLastLinePlayed = { "/VO/Hades_0378" }, RequiredFalseTextLines = { "Ending01" } },
				-- I've both my parents' eyes.
				{ Cue = "/VO/ZagreusField_4468", RequiredLastLinePlayed = { "/VO/Hades_0378" }, RequiredTextLines = { "Ending01" } },

				-- Time for another blood spree, then.
				{ Cue = "/VO/ZagreusField_1538", RequiredLastLinePlayed = { "/VO/Hades_0379" } },

				-- How about now, Father?
				{ Cue = "/VO/ZagreusField_2430", RequiredLastLinePlayed = { "/VO/Hades_0467" }, },

				-- I'll find out for myself.
				{ Cue = "/VO/ZagreusField_2431", RequiredLastLinePlayed = { "/VO/Hades_0468" }, RequiredFalseTextLines = { "PersephoneFirstMeeting" }, },
				-- Does seem that way.
				{ Cue = "/VO/ZagreusHome_2066", RequiredLastLinePlayed = { "/VO/Hades_0468" }, RequiredTextLines = { "PersephoneFirstMeeting" }, },

				-- I'm getting used to it.
				{ Cue = "/VO/ZagreusField_2432", RequiredLastLinePlayed = { "/VO/Hades_0469" }, },

				-- Just have to cross a couple rivers, then.
				{ Cue = "/VO/ZagreusField_2433", RequiredLastLinePlayed = { "/VO/Hades_0470" }, },

				-- I'll go where I please.
				{ Cue = "/VO/ZagreusField_2434", RequiredLastLinePlayed = { "/VO/Hades_0471" }, RequiredFalseTextLines = { "Ending01" } },
				-- Think you can stop me?
				{ Cue = "/VO/ZagreusField_1019", RequiredLastLinePlayed = { "/VO/Hades_0471" }, RequiredTextLines = { "Ending01" } },

				-- I'm sure you'll think of something soon enough.
				{ Cue = "/VO/ZagreusField_3328", RequiredLastLinePlayed = { "/VO/Hades_0629" }, RequiredFalseTextLines = { "AchillesAboutZagreus01" }, },
				-- I am the god of blood.
				{ Cue = "/VO/ZagreusField_4465", RequiredLastLinePlayed = { "/VO/Hades_0629" }, RequiredTextLines = { "AchillesAboutZagreus01" }, },

				-- You stay away from me.
				{ Cue = "/VO/ZagreusField_3329", RequiredLastLinePlayed = { "/VO/Hades_0832" }, RequiredFalseTextLines = { "Ending01" } },
				-- I'll be sure to say hello.
				{ Cue = "/VO/ZagreusHome_2062", RequiredLastLinePlayed = { "/VO/Hades_0832" }, RequiredTextLines = { "Ending01" }, },

				-- Headed over to Elysium right now...
				{ Cue = "/VO/ZagreusField_3330", RequiredLastLinePlayed = { "/VO/Hades_0833" }, },

				-- Who needs your rivers.
				{ Cue = "/VO/ZagreusField_3331", RequiredLastLinePlayed = { "/VO/Hades_0834" }, RequiredFalseTextLines = { "Ending01" }, },
				-- Whatever you say...
				{ Cue = "/VO/ZagreusHome_2251", RequiredLastLinePlayed = { "/VO/Hades_0834" }, RequiredTextLines = { "Ending01" }, },

				-- ...Ceaseless chatter.
				{ Cue = "/VO/ZagreusField_3332", RequiredLastLinePlayed = { "/VO/Hades_0835" }, },

				-- I've anger enough.
				{ Cue = "/VO/ZagreusField_3333", RequiredLastLinePlayed = { "/VO/Hades_0836" }, },

				-- Not afraid of you or your damn spear.
				{ Cue = "/VO/ZagreusField_3334", RequiredLastLinePlayed = { "/VO/Hades_0837" }, RequiredFalseTextLines = { "Ending01" }, },
				-- I could take him.
				{ Cue = "/VO/ZagreusHome_1903", RequiredLastLinePlayed = { "/VO/Hades_0837" }, RequiredTextLines = { "Ending01" }, },

				-- Fear is for the weak...
				{ Cue = "/VO/ZagreusField_3335", RequiredLastLinePlayed = { "/VO/Hades_0838" }, },

				-- Let's find some gemstones then.
				{ Cue = "/VO/ZagreusField_3336", RequiredLastLinePlayed = { "/VO/Hades_0839" }, },

				-- Guess I'll see what I can do about it, Father.
				{ Cue = "/VO/ZagreusField_3337", RequiredLastLinePlayed = { "/VO/Hades_0840" }, },

				-- No one will worship you.
				{ Cue = "/VO/ZagreusField_3338", RequiredLastLinePlayed = { "/VO/Hades_0841" }, RequiredFalseTextLines = { "Ending01" }, },
				-- The power of Night.
				{ Cue = "/VO/ZagreusHome_2109", RequiredLastLinePlayed = { "/VO/Hades_0841" }, RequiredTextLines = { "Ending01" }, },

				-- post-ending
				-- Got the best instructor who ever lived.
				{ Cue = "/VO/ZagreusField_4469", RequiredLastLinePlayed = { "/VO/Hades_0950" }, },
				-- My differences have made me strong, all right.
				{ Cue = "/VO/ZagreusField_4470", RequiredLastLinePlayed = { "/VO/Hades_0951" }, },
				-- Here's to my friends and family...
				{ Cue = "/VO/ZagreusField_4471", RequiredLastLinePlayed = { "/VO/Hades_0952" }, },
				-- I swear, this family...
				{ Cue = "/VO/ZagreusField_4472", RequiredLastLinePlayed = { "/VO/Hades_0953" }, },
				-- Still figuring our boundaries out I guess.
				{ Cue = "/VO/ZagreusField_4473", RequiredLastLinePlayed = { "/VO/Hades_0954" }, },
				-- You taught me that, at least.
				{ Cue = "/VO/ZagreusField_4474", RequiredLastLinePlayed = { "/VO/Hades_0955" }, },
				-- I'm fond of running, thanks.
				{ Cue = "/VO/ZagreusField_4475", RequiredLastLinePlayed = { "/VO/Hades_0956" }, },
				-- I will.
				{ Cue = "/VO/ZagreusField_4476", RequiredLastLinePlayed = { "/VO/Hades_0957" }, },
				-- Set your aim higher, too.
				{ Cue = "/VO/ZagreusField_4477", RequiredLastLinePlayed = { "/VO/Hades_0958" }, },
				-- It's nice enough to visit, anyhow.
				{ Cue = "/VO/ZagreusField_4478", RequiredLastLinePlayed = { "/VO/Hades_0959" }, },
				-- I'll see what I can do.
				{ Cue = "/VO/ZagreusField_4479", RequiredLastLinePlayed = { "/VO/Hades_0960" }, },
				-- This is our home.
				{ Cue = "/VO/ZagreusField_4480", RequiredLastLinePlayed = { "/VO/Hades_0961" }, },
				-- Time to uphold it, then.
				{ Cue = "/VO/ZagreusField_4481", RequiredLastLinePlayed = { "/VO/Hades_0962" }, },
				-- A little pride's all right.
				{ Cue = "/VO/ZagreusField_4482", RequiredLastLinePlayed = { "/VO/Hades_0963" }, },
			},
			{
				RandomRemaining = true,
				PreLineWait = 2.65,
				SuccessiveChanceToPlayAll = 0.05,
				RequiredFalseFlags = { "KioskMode" },
				RequiredFalseTextLines = { "Ending01" },
				Cooldowns =
				{
					{ Name = "ZagreusStartNewRunSpeech", Time = 10 },
				},

				-- Wait for me, Mother. I'll be there soon.
				{ Cue = "/VO/ZagreusScratch_0003", RequiredMinCompletedRuns = 6, RequiredTextLines = { "Flashback_Mother_01", } },
				-- To hell with this place.
				{ Cue = "/VO/ZagreusScratch_0004", RequiredMinCompletedRuns = 20, },
				-- I'm getting out of here.
				{ Cue = "/VO/ZagreusField_0013", RequiredMinCompletedRuns = 5, },
			},
		},

		DistanceTriggers =
		{
			-- Intro
			{
				TriggerObjectType = "SecretDoor", WithinDistance = 600,
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					PreLineWait = 0.1,
					SuccessiveChanceToPlayAll = 0.1,

					-- Hoh, what's this.
					-- { Cue = "/VO/ZagreusField_0536", RequiredKillEnemiesNotFound = true },
				},
			},
		},

		InspectPoints =
		{
			[390001] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredMinCompletedRuns = 1,
				InteractTextLineSets =
				{
					OpeningFirstInspect =
					{
						-- Good thing I'm not dead.
						EndCue = "/VO/ZagreusField_0530",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0118",
							Text = "{#DialogueItalicFormat}Composed of such innumerable ever-shifting interlocking chambers, the Underworld of Lord Hades all but guarantees the dead shall there remain until the end of time." },
					},
				},
			},
			[410183] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTextLines = { "OpeningFirstInspect" },
				RequiredAnyTextLines = { "CharonFirstMeeting", "CharonFirstMeeting_Alt" },
				InteractTextLineSets =
				{
					OpeningProcGenHint =
					{
						-- Built to ensure no one gets out. We'll see about that.
						EndCue = "/VO/ZagreusField_0529",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0154",
							Text = "{#DialogueItalicFormat}Each time the Prince delves back into the Underworld, its ever-shifting chambers realign to frustrate his attempts to perhaps map it out." },
					},
				},
			},
		},
	},

	-- NPC room layout 1
	A_Story01 =
	{
		InheritFrom = { "BaseTartarus" },
		ForcedReward = "Story",
		NoReroll = true,
		MaxCreationsThisRun = 1,
		RichPresence = "#RichPresence_AStory01",

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 4,
			RequiredMinCompletedRuns = 1,
			RequiredSeenRooms = { "A_Boss01" },
		},

		SecretMusic = "/Music/MusicExploration1_MC",
		ZoomFraction = 0.85,
		TimerBlock = "StoryRoom",

		FlipHorizontalChance = 0.0,
		LegalEncounters = { "Story_Sisyphus_01" },
		EntranceDirection = "LeftRight",
		NumExits = 1,
		InspectPoints =
		{
			[506297] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTextLines = { "SisyphusFirstMeeting" },
				InteractTextLineSets =
				{
					Inspect_A_Story_01_01 =
					{
						-- Lots of wretchedness to go around, I guess.
						EndCue = "/VO/ZagreusField_0935",
						EndWait = 0.3,
						{ Cue = "/VO/Storyteller_0199",
							Text = "{#DialogueItalicFormat}Within the depths of Tartarus reside the most wretched of all the shades who linger for eternity within the Underworld, whose Lord and Master is especially unkind to those attempting to cheat death." },
					},
				},
			},
		},

		ThreadedEvents =
		{
			{
				FunctionName = "PatrolPath",
				Args =
				{
					GroupName = "GhostPatrols",
					NewGroupName= "ActiveGhosts",
					RemoveFromGroup = true,
					AddToGroup = true,
					MaxPatrols = 10,
					SendPatrolInterval = 1.5,
					SpeedMin = 20,
					SpeedMax = 70,
					Path =
					{
						--{ Id = 486417, OffsetRadius = 280 },
						{
							Branch =
							{
								{
									{ Id = 486418, OffsetRadius = 10, PostArriveWait = 5, EmoteOnEnd = "Fear", MinUseInterval = 10 },
								},
								{
									{ Id = 486427, OffsetRadius = 50 },
									{
										Branch =
										{
											{
												{ Id = 486419, OffsetRadius = 10, AngleTowardIdOnStop = 370001, MinUseInterval = 7.1, PostArriveWait = 7.0, EmoteOnEnd = "OhBoy" },
											},
											{
												{ Id = 486420, OffsetRadius = 10, AngleTowardIdOnStop = 370001, MinUseInterval = 7.1, PostArriveWait = 7.0, EmoteOnEnd = "OhBoy" },
											},
											{
												{ Id = 486421, OffsetRadius = 10, AngleTowardIdOnStop = 486068, MinUseInterval = 7.1, PostArriveWait = 7.0, EmoteOnEnd = "Smile" },
											},
											{
												{ Id = 486422, OffsetRadius = 10, AngleTowardIdOnStop = 486068, MinUseInterval = 7.1, PostArriveWait = 7.0, EmoteOnEnd = "Smile" },
											},
										},
									},
								},
								{
									{ Id = 486423, OffsetRadius = 20, MinUseInterval = 10, },
									{ Id = 486424, OffsetRadius = 20, PostArriveWait = 10 },
								},
								{
									{ Id = 486429, OffsetRadius = 10, MinUseInterval = 3.1, },
									{ Id = 486430, OffsetRadius = 10, MinUseInterval = 10.1, PostArriveWait = 10.0, EmoteOnEnd = "OhBoy" },
								},
							},
						},
					},
				},
			},
		},
	},
}

OverwriteTableKeys( RoomData, RoomSetData.Tartarus )