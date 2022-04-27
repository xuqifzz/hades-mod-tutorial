RoomSetData.Base =
{
	BaseRoom =
	{
		DebugOnly = true,
		SecretSpawnChance = 0.2,
		SecretDoorRequirements =
		{
			RequiredMinCompletedRuns = 1,
			RequiredMinBiomeDepth = 0,
			RequiredMinRoomsSinceSecretDoor = 4,
		},
		ShrinePointDoorSpawnChance = 0.3,
		ShrinePointDoorRequirements =
		{
			RequiredScreenViewed = "ShrineUpgrade",
			RequiredMinRoomsSinceShrinePointDoor = 4,
			RequiredCosmetics = { "ShrinePointGates", },
		},
		ChallengeSpawnChance = 0.25,
		ChallengeSwitchRequirements =
		{
			RequiredMinBiomeDepth = 5,
			RequiredMinRoomsSinceChallengeSwitch = 3,
		},
		WellShopSpawnChance = 0.40,
		WellShopRequirements =
		{
			RequiredMinBiomeDepth = 3,
			RequiredMinRoomsSinceWellShop = 2,
		},
		SellTraitShopChance = 0.10,
		SellTraitShopRequirements =
		{
			RequiredMinBiomeDepth = 3,
			RequiredUpgradeableGodTraits = 3,
			RequiredMinRoomsSinceSellTraitShop = 6,
		},
		FishingPointChance = 0.10,
		FishingPointRequirements =
		{
			RequiredCosmetics = { "FishingUnlockItem" },
			RequiredMinRoomsSinceFishingPoint = 10,
		},
		MinDepthBeforeIntros = 3,
		LockedUseSound = "/Leftovers/World Sounds/Caravan Interior/ChestClose",
		UnlockedUseSound = "/Leftovers/SFX/DoorClose",
		UsePromptOffsetX = 10,
		UsePromptOffsetY = -50,
		StopSecretMusic = true,
		IntroSequenceDuration = 0.1,
		ChallengeEncounterName = "TimeChallengeTartarus",
		NumExits = 1,
		ShrinePointRoomOptions = { "RoomChallenge01", "RoomChallenge02", "RoomChallenge03", "RoomChallenge04" },
	},

	_TartarusTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
	},
	_AsphodelTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
	},
	_ElysiumTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
	},
	_StyxTemplateRoom =
	{
		InheritFrom = { "BaseRoom" },
	},
	TestingRoom = 
	{
		TestRoom = true,
	},
	C_CombatTemp01 =
	{
		InheritFrom = { "BaseRoom" },
	},

	RandomizeTrapTypes =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,

		PreThingCreationUnthreadedEvents =
		{
			{
				FunctionName = "RandomizeTrapTypes", Args =
				{
					FractionMin = 0.0,
					FractionMax = 1.0,
				}
			},
		},
	},

	RandomizeTrapTypesAll =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,

		PreThingCreationUnthreadedEvents =
		{
			{
				FunctionName = "RandomizeTrapTypes", Args =
				{
					FractionMin = 1.0,
					FractionMax = 1.0,
				}
			},
		},
	},

	AllPrePlacedTraps =
	{
		InheritFrom = { "BaseRoom" },
		DebugOnly = true,

		StartUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0 } },
		},
	},

	-- ending
	Return01 =
	{
		InheritFrom = { "BaseRoom" },
		LegalEncounters = { "Surface" },
		-- Music = "/Music/EndTheme",
		Ambience = "/Leftovers/Object Ambiences/WaterRushingStream",
		ZoomFraction = 0.75,

		PauseMusicOnPauseScreen = true,

		EntranceFunctionName = "ReturnRoomEntrance",
		ExitFunctionName = "ReturnRoomExit",
		FlipHorizontalChance = 0.0,
		SkipSave = true,
		BlockCameraReattach = true,
		
		HideCombatUI = true,
		HideEncounterText = true,
		HideGoldGainFx = true,
		BlockTraitSetup = true,
		HideLowHealthShroud = true,

		SecretSpawnChance = 0.0,
		ShrinePointDoorSpawnChance = 0.0,
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		SellTraitShopChance = 0.0,
		FishingPointChance = 0.0,

		UnthreadedEvents =
		{
			-- HandleReturnBoatRideIntro & HandleReturnBoatRide are called from PersephoneReturnsHome01 narrative event
			{ FunctionName = "HandleReturnBoatRideAnimationSetup" },
		},
		ThreadedEvents =
		{
		},

		BoatAnimData =
		{
			Zagreus = "ZagreusEndingBoat_IdleLoop4",
			Persephone = "PersephoneEndingBoat_IdleLoop1",
		},

		Binks =
		{
			"CharonEndingBoatRowIdle_Bink",
			"CharonEndingBoatRow_Bink",
			"ZagreusEndingBoatIdleLoop_Bink",
			"ZagreusEndingBoatIdleFidget1_Bink",
			"ZagreusEndingBoatIdleFidget2_Bink",
			"NPC_PersephoneEndingBoatIdleLoop_Bink",
			"NPC_PersephoneEndingBoatIdleFidget1_Bink",
			"EndingBoatFront_Bink",
			"EndingBoatBack_Bink",
		},
	},

	Return02 =
	{
		InheritFrom = { "Return01" },
		Ambience = "None",

		UnthreadedEvents =
		{
			{ FunctionName = "HandleReturnBoatRide", Args = { NextMap = "Return03", } },
		},
		ThreadedEvents =
		{
		},

		BoatAnimData =
		{
			Zagreus = "ZagreusEndingBoat_IdleLoop4",
			Persephone = "PersephoneEndingBoat_IdleLoop3",
		},
	},

	Return03 =
	{
		InheritFrom = { "Return01" },
		Ambience = "None",

		UnthreadedEvents =
		{
			{ FunctionName = "HandleReturnBoatRide", Args = { NextMap = "Return04", } },
		},
		ThreadedEvents =
		{
			--{ FunctionName = "BoatRideSupportiveShadeReact", Args = { AnimationNames = { "StatusIconSmile" }, ReactionChance = 1.0, Delay = 20, Ids = { 571365 }, Shake = true } },
		},

		BoatAnimData =
		{
			--Zagreus = "ZagreusEndingBoat_IdleLoop3",
			Persephone = "PersephoneEndingBoat_IdleLoop2",
		},
	},

	Return04 =
	{
		InheritFrom = { "Return01" },
		Ambience = "None",

		UnthreadedEvents =
		{
			{ FunctionName = "HandleReturnBoatRide", Args = { NextMap = "Return05", } },
		},
		ThreadedEvents =
		{
		},

		BoatAnimData =
		{
			Zagreus = "ZagreusEndingBoat_IdleLoop5",
			Persephone = "PersephoneEndingBoat_IdleLoop4",
		},
	},

	Return05 =
	{
		InheritFrom = { "Return01" },
		Ambience = "None",

		UnthreadedEvents =
		{
			{ FunctionName = "HandleReturnBoatRide", Args = { NextMap = "Return06", } },
		},
		ThreadedEvents =
		{
		},

		BoatAnimData =
		{
			Zagreus = "ZagreusEndingBoat_IdleLoop2",
			Persephone = "PersephoneEndingBoat_IdleLoop2",
		},
	},

	Return06 =
	{
		InheritFrom = { "Return01" },

		ThreadedEvents = {},
		UnthreadedEvents =
		{
			{ FunctionName = "HandleReturnBoatRideAudio" },
			{ FunctionName = "HandleReturnBoatRide", Args = {  } },
			{ FunctionName = "HandleReturnBoatRideOutro" },
			{ FunctionName = "SurfaceKillHero", Args = {  } },
		},

		BoatAnimData =
		{
			Zagreus = "ZagreusEndingBoat_IdleLoop1",
			Persephone = "PersephoneEndingBoat_IdleLoop4",
		},

		RunOverrides =
		{
			DeathPresentationFunctionName = "BoatToDeathAreaTransition",
			ReturnedByBoat = true,
		},
	},

	RoomChallenge01 =
	{
		InheritFrom = { "BaseRoom" },
		RewardPreviewIcon = "RoomElitePreview3",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",

		NumExits = 3,
		EntranceFunctionName = "RoomEntrancePortal",
		NextRoomEntranceFunctionName = "RoomEntrancePortal",
		EntranceAnimation = "ZagreusDashEntrance",
		EntranceVfx = "ZagreusSecretDoorDiveFadeFx_Shrine",
		ExitAnimation = "ZagreusSecretDoorExit",
		ExitVfx = "ZagreusSecretDoorDiveFadeFx_Shrine",
		ExitDoorOpenAnimation = "ExitDoorLinesSpecial",
		ExitDoorCloseAnimation = "ExitDoorLinesSpecial",
		LocationText = "Location_Challenge",
		ResultText = "RunHistoryScreenResult_Challenge",
		RichPresence = "#RichPresence_Erebus",
		BiomeName = "Challenge",
		Ambience = "/Leftovers/Ambience/MountainAmbience",
		BlockRandomStems = true,
		SkipLeavePrevRoomSFX = true,
		UsePreviousRoomSet = true,
		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		ForcedRewardStore = "RunProgress",
		IgnoreForceLootName = true,
		-- SkipMinBiomeDepthRequirements = true,
		BoonRaritiesOverride =
		{
			LegendaryChance = 0.1,
			EpicChance = 0.25,
			RareChance = 0.90
		},
		StackNumOverride = 2,
		RewardConsumableOverrides =
		{
			AddMaxHealth = 50,
			DropMoney = 200,
		},
		LegalEncounters = { "ShrineChallengeTartarus", "ShrineChallengeAsphodel", "ShrineChallengeElysium", },
		ZoomFraction = 0.75,
		SoftClamp = 0.75,

		SecretSpawnChance = 0.0,
		ShrinePointDoorSpawnChance = 0.0,
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		IneligibleRewards = { "Devotion", "WeaponUpgrade", },

		InspectPoints =
		{
			[515865] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					CharonFirstInspect =
					{
						-- Is this where Father's goons assemble to come after me?
						EndCue = "/VO/ZagreusField_1472",
						EndWait = 0.3,
						{ Cue = "/VO/Storyteller_0220",
							Text = "{#DialogueItalicFormat}Concealed in the dark recesses of the Underworld is the land of Erebus, wherein the dead await eternal sentencing; they long for the attention and good graces of their master, the Lord Hades." },
					},
				},
			},
		},
	},

	RoomChallenge02 =
	{
		InheritFrom = { "RoomChallenge01" },

		InspectPoints =
		{
		},
	},
	RoomChallenge03 =
	{
		InheritFrom = { "RoomChallenge01" },

		InspectPoints =
		{
		},
	},
	RoomChallenge04 =
	{
		InheritFrom = { "RoomChallenge01" },

		InspectPoints =
		{
		},
	},

	CharonFight01 =
	{
		InheritFrom = { "BaseRoom" },
		UsePreviousRoomSet = true,
		NoReward = true,

		EntranceFunctionName = "RoomEntrancePortal",
		NextRoomEntranceFunctionName = "RoomEntrancePortal",
		HeroEndPoint = 50059,

		ZoomFraction = 0.85,

		LegalEncounters = { "BossCharon" },

		LocationText = "Location_Challenge",
		BiomeName = "Challenge",

		Milestone = true,
		MilestoneIcon = "BossIcon",
		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,

		Ambience = "/Leftovers/Object Ambiences/WaterRushingBloodRiver2",
		EnterGlobalVoiceLines = "EnteredCharonFightVoiceLines",

		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 0.0,
		BlockCameraReattach = true,
		SkipLastKillPresentation = true,
		ResultText = "RunHistoryScreenResult_CharonFight01",
		RichPresence = "#RichPresence_CharonFight",

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntroCharon",
				Args =
				{
					ProcessTextLinesIds = { 490802 },
					SetupBossIds = { 490802 },
					DelayedStart = true,
				},
			},
		},

		InspectPoints =
		{
			[556684] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredMinCompletedRuns = 1,
				InteractTextLineSets =
				{
					CharonFight01_FirstInspect =
					{
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								RequiredMinElapsedTime = 3,
								-- Nice place you got here, mate!
								{ Cue = "/VO/ZagreusField_3903" },
							},
							{
								PreLineWait = 0.2,
								ObjectType = "Charon",
								-- Mmmrrrrnnn....
								{ Cue = "/VO/Charon_0011", RequiredPlayed = { "/VO/ZagreusField_3903" } },
							},
						},
						{ Cue = "/VO/Storyteller_0366",
							Text = "{#DialogueItalicFormat}A hidden stretch of the boundless river Styx cuts through misty Erebus, providing for the river-boatman Charon a locale in which to deal with the unruliest of souls." },
					},
				},
			},
		},

	},

	TestEnemies =
	{
		InheritFrom = { "RandomizeTrapTypes", "TestingRoom" },
		-- LinkedRooms = { "A_Reprieve01" },
		-- NextRoomSet = { "Tartarus", },

		LegalEncounters = { "TestFight" },
		NumExits = 1,
		ChallengeEncounterName = "TimeChallengeTartarus",
		ChallengeSpawnChance = 1.0,
		WellShopSpawnChance = 1.0,
		WellShopRequirements =
		{
			-- None
		},
		ForceChallengeSwitch = true,
		ForceSecretDoor = true,
		ForceShrinePointDoor = true,
		AllowSuperOutsideEncounter = true,
		AlwaysInCombat = true,
		StartUnthreadedEvents =
		{
			{
				FunctionName = "LiveFillInShopOptions",
				Args =
				{
				},
			},
		},
	},

	TestDexter =
	{
		InheritFrom = { "BaseRoom", "TestingRoom"  },
		NextRoomSet = { "Tartarus", },
		LegalEncounters = { "TestDexterFight" },
	},

	TestNPCs =
	{
		InheritFrom = { "BaseRoom", "TestingRoom"  },
		LegalEncounters = { "TestNPCs" },
		AllowSuperOutsideEncounter = true,
		AlwaysInCombat = true,
		Ambience = "/Leftovers/Ambience/BurningAmbience",
		Music = "/Music/MusicExploration4_MC",
		MusicActiveStems = { "Bass", "Guitar" },
		MusicMutedStems = { "Drums" },
		InspectPoints =
		{
			[370000] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					PersephoneVOTest1 =
					{
						{ Cue = "/VO/Persephone_0018",
							Text = "{#DialogueItalicFormat}'Hades: I can no longer tolerate my life here in this place. So, I am leaving, even if it kills me. I won't be returning to Olympus. If there is a place where I belong in this world, it must be somewhere between heaven and hell. Perhaps it's on the coast and has a little garden. Take care of Cerberus; I shall miss him.  --Persephone'" },
					},
				},
			},
		},

		PostUnthreadedEvents =
		{
			{
				FunctionName = "CheckConversations",
				Args = {},
			},
		},
	},

	TestJoshRoomEnemyTest =
	{
		InheritFrom = { "BaseRoom", "TestingRoom"  },
		LegalEncounters = { "CombatTestJosh" },
	},

	TestAlice =
	{
		InheritFrom = { "BaseRoom", "TestingRoom"  },
		NextRoomSet = { "Tartarus", },
		LegalEncounters = { "Empty" },
		BlockHeroLight = true,
		NumExits = 1,
		AllowSuperOutsideEncounter = true,
		AlwaysInCombat = true,
	},

	TestJen =
	{
		InheritFrom = { "BaseRoom", "TestingRoom"  },
		NextRoomSet = { "Tartarus", },
		LegalEncounters = { "Empty" },
	},

	TestJoanne =
	{
		InheritFrom = { "BaseRoom", "TestingRoom"  },
		NextRoomSet = { "Tartarus", },
		LegalEncounters = { "Empty" },
	},

	TestTuning =
	{
		InheritFrom = { "RandomizeTrapTypes", "TestingRoom"  },
		-- LinkedRooms = { "A_Reprieve01" },
		-- NextRoomSet = { "Tartarus", },
		SecretSpawnChance = 0.0,
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		AllowSuperOutsideEncounter = true,
		AlwaysInCombat = true,

		LegalEncounters = { "TuningFight" },
	},

	TestMorgan =
	{
		InheritFrom = { "BaseRoom", "TestingRoom"  },
		LegalEncounters = { "MorganFight" },
		DistanceTriggers =
		{
			 { TriggerGroup = "EnemyTrap", WithinDistance = 100, ActivateGroup = "PrePlacedEnemies"  },
		},
	},

	TestEduardo =
	{
		InheritFrom = { "BaseRoom", "TestingRoom"  },
		LegalEncounters = { "Empty" },
		--[[UnthreadedEvents =
		{
			{ FunctionName = "BeginTestRoomInro"},
		},]]--
	},


	TestThinh =
	{
		InheritFrom = { "RandomizeTrapTypes", "TestingRoom"  },
		-- LinkedRooms = { "A_Reprieve01" },
		-- NextRoomSet = { "Tartarus", },

		LegalEncounters = { "TestFight" },
		NumExits = 1,
		ChallengeEncounterName = "TimeChallengeTartarus",
		ChallengeSpawnChance = 1.0,
		WellShopSpawnChance = 1.0,
		WellShopRequirements =
		{
			-- None
		},
		ForceChallengeSwitch = true,
		ForceSecretDoor = true,
		ForceShrinePointDoor = true,
		AllowSuperOutsideEncounter = true,
		AlwaysInCombat = true,
		StartUnthreadedEvents =
		{
			{
				FunctionName = "LiveFillInShopOptions",
				Args =
				{
				},
			},
		},
	},

	TestAnimations =
	{
		InheritFrom = { "BaseRoom", "TestingRoom"  },
		LegalEncounters = { "Empty" },
		ThreadedEvents =
		{
			{ FunctionName = "AnimateOnDistance", Args = {AnimationName = "ZagreusWalk", Name = "NPC_Hades_01", Distance = 500} },
		},
	},

	TestAllThings =
	{
		InheritFrom = { "BaseRoom", "TestingRoom"  },
		LegalEncounters = { "Empty" },
		NoReward = true,
		ZoomFraction = 0.75,
		KeepsakeFreeSwap = true,
		AlwaysAllowLootInteraction = true,
		AllowSuperOutsideEncounter = true,
		AlwaysInCombat = true,
		SecretSpawnChance = 1.0,
		ChallengeSpawnChance = 1.0,
		WellShopSpawnChance = 1.0,
		WellShopRequirements =
		{
			-- None
		},
		ForceSecretDoor = true,
		ForceChallengeSwitch = true,
		StartUnthreadedEvents =
		{
			{
				FunctionName = "AddResources",
				Args =
				{
					MetaPoints = 9999,
					Gems = 9999,
					--Money = 9999,
					GiftPoints = 9,
					LockKeys = 999,
					SuperGems = 99,
					SuperLockKeys = 99,
				},
			},
			{
				FunctionName = "AssignWeaponKits",
				Args =
				{
					IgnoreRequirements = true,
				},
			},
			{
				FunctionName = "SpawnAllLoot",
				Args =
				{
					StripInteractTextRequirements = true,
					RespawnAfterUse = true,
					WipeRecordsAfterUse = true,
					StopAnimations = { "BoonOrbSpawn", "BoonOrbSpawn2", "PickupFlare", "PickupFlareA", "PickupFlareA2", "PickupFlareB01", "PickupFlareB02" },
				},
			},
			{
				FunctionName = "SpawnAllConsumables",
				Args =
				{
					ExcludeNames =
					{
						"StackUpgradeDrop", "WeaponUpgradeDrop", "DionysusGiftDrop", "BaseConsumable", "Tier1Consumable", "Tier2Consumable", "Tier3Consumable", "RandomMinorLootDrop",
						"AmmoPack",  "MoneyDrop", "FallbackMoneyDrop", "HealingPotencyDrop", "LastStandDurationDrop", "LastStandHealDrop", "RandomKeepsake","RandomStoreItem","DamageSelfDrop","AspectRarityDrop", "KeepsakeChargeDrop",
					},
					HideWorldTextOverride = false,
					StopAnimations = { "BoonOrbSpawn", "BoonOrbSpawn2", "PickupFlare", "PickupFlareA", "PickupFlareA2", "PickupFlareB01", "PickupFlareB02" },
				},
			},
			{
				FunctionName = "CreateEnemySpawnButtons",
				Args =
				{
					SpawnButtonGroup = "BiomeSpawnButtons1",
					Names = EnemySets.EnemiesBiome1,
					SpawnOnId = 410144,
					ExcludeNames = { },
				},
			},
			{
				FunctionName = "CreateEnemySpawnButtons",
				Args =
				{
					SpawnButtonGroup = "BiomeSpawnButtons2",
					Names = EnemySets.EnemiesBiome2,
					SpawnOnId = 410098,
					ExcludeNames = { },
				},
			},
			{
				FunctionName = "CreateEnemySpawnButtons",
				Args =
				{
					SpawnButtonGroup = "BiomeSpawnButtons3",
					Names = EnemySets.EnemiesBiome3,
					SpawnOnId = 421593,
					ExcludeNames = { },
				},
			},
			{
				FunctionName = "CreateEnemySpawnButtons",
				Args =
				{
					SpawnButtonGroup = "BiomeSpawnButtons4",
					Names = EnemySets.EnemiesBiome4,
					SpawnOnId = 421608,
					ExcludeNames = { },
				},
			},
			{
				FunctionName = "CreateEnemySpawnButtons",
				Args =
				{
					SpawnButtonGroup = "BiomeSpawnButtonsMinibosses",
					Names = EnemySets.Minibosses,
					SpawnOnId = 421626,
					ExcludeNames = { },
				},
			},
			{
				FunctionName = "CreateEnemySpawnButtons",
				Args =
				{
					SpawnButtonGroup = "BiomeSpawnButtonsTest",
					Names = { "TestCharacter" },
					SpawnOnId = 421611,
					ExcludeNames = { },
				},
			},
			{
				FunctionName = "CreateNPCSpawnButtons",
				Args =
				{
					SpawnButtonIds = { 421570, 421565, 421566, 421564, 421563, 421562, 421560, 421561, 421569, 421568, 421567, 421559, 421572, 421573, 421571, },
					ExcludeNames = { "NPC_Neutral", "NPC_Giftable" },
				},
			},
			{
				FunctionName = "CheckConversations",
				Args = {},
			},
			{
				FunctionName = "ShowMaterialText",
				Args =
				{
					Group = "MaterialExamples",
				},
			},
			{
				FunctionName = "StripInteractTextRequirements",
				Args =
				{
				},
			},
			{
				FunctionName = "ShowCombatUI",
				Args =
				{
				},
			},
			{
				FunctionName = "LiveFillInShopOptions",
				Args =
				{
				},
			},
			{
				FunctionName = "UnlockEntireCodex",
				Args =
				{
				},
			},
		},
		ObstacleData =
		{
			-- Market / Exchange
			[421558] =
			{
				InteractDistance = 200,
				UseText = "UseMarket",
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				OnUsedFunctionName = "UseMarketObject",
			},

			-- Desk Scroll / Shrine
			[421554] =
			{
				KeyCost = 10,
				LockOffsetZ = 81,
				LockKeyTextOffsetY = -30,
				InteractDistance = 250,
				UseText = "UseShrine",
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				OnUsedFunctionName = "UseShrineObject",
			},

			[421602] =
			{
				InteractDistance = 200,
				OverheadText = "Stop",
				OverheadTextFontSize = 30,
				OnUsedFunctionName = "AllAIStop",
			},

			[421601] =
			{
				InteractDistance = 200,
				OverheadText = "Follow",
				OverheadTextFontSize = 30,
				OnUsedFunctionName = "AllAIFollow",
			},
		}
	},

	TestAndrew =
	{
		InheritFrom = { "BaseRoom", "TestingRoom"  },
		LegalEncounters = { "Empty" },
		BlockHeroLight = true,
		NoReward = true,
	}
}

OverwriteTableKeys( RoomData, RoomSetData.Base )