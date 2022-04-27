RoomSetData.Asphodel =
{
	BaseAsphodel =
	{
		DebugOnly = true,

		LegalEncounters = EncounterSets.AsphodelEncountersDefault,
		ChallengeEncounterName = "TimeChallengeAsphodel",
		LocationText = "Location_Asphodel",
		LocationTextShort = "Location_Asphodel_Short",
		ResultText = "RunHistoryScreenResult_Asphodel",
		RichPresence = "#RichPresence_Asphodel",
		DevotionEncounters = {"DevotionTestAsphodel"},
		TargetMetaRewardsRatio = 0.40,
		SecretSpawnChance = 0.075,
		SecretDoorRequirements =
		{
			RequiredTextLines = { "HermesFirstPickUp" },
			-- run rollout prereqs
			RequiredFalseTextLinesThisRun = { "HermesFirstPickUp", "SisyphusFirstMeeting", },
			RequiredMinRoomsSinceSecretDoor = 8,
		},
		ShrinePointDoorCost = 10,
		ShrinePointDoorSpawnChance = 0.15,
		ShrinePointDoorRequirements =
		{
			RequiredScreenViewed = "ShrineUpgrade",
			RequiredMinRoomsSinceShrinePointDoor = 8,
			RequiredCosmetics = { "ShrinePointGates", },
		},
		ChallengeSpawnChance = 0.30,
		ChallengeSwitchRequirements =
		{
			RequiredMinBiomeDepth = 2,
			RequiredMinRoomsSinceChallengeSwitch = 6,
		},
		WellShopSpawnChance = 0.35,
		WellShopRequirements =
		{
			RequiredMinCompletedRuns = 1,
			RequiredMinRoomsSinceWellShop = 3,
			RequiredMinBiomeDepth = 4,
		},
		SellTraitShopChance = 0.10,
		SellTraitShopRequirements =
		{
			RequiredMinCompletedRuns = 1,
			RequiredUpgradeableGodTraits = 3,
			RequiredMinRoomsSinceSellTraitShop = 2,
		},
		FishingPointChance = 0.1,
		FishingPointRequirements =
		{
			RequiredCosmetics = { "FishingUnlockItem" },
			RequiredMinRoomsSinceFishingPoint = 10,
		},
		TrapOptions = EnemySets.TrapsBiome2,
		ExitDoorIconOffzetZ = 100,
		ExitDoorIconOffzetY = 0,
		EntranceFunctionName = "AsphodelEnterRoomPresentation",
		ZoomFraction = 0.88,
		FootstepAnimationL = "AshFootstepL",
		FootstepAnimationR = "AshFootstepR",
		SwapAnimations =
		{
			["FishingPoint"] = "FishingPoint_NoShadow",
			["FishingPointActive"] = "FishingPointActive_NoShadow",
		},	
		SwapSounds =
		{
			["/SFX/Player Sounds/FootstepsHardSurface"] = "/SFX/Player Sounds/FootstepsSandMEDIUM",
			["/SFX/Player Sounds/FootstepsHardSurfaceRun"] = "/SFX/Player Sounds/FootstepsSandMEDIUMRun",
		},
		StopSecretMusic = true,
		ShopSecretMusic = "/Music/CharonShopTheme",
		MinDepthBeforeIntros = 2,
		MaxAppearancesThisBiome = 1,
		IntroSequenceDuration = 0.9,

		HazardData =
		{
			SpawnPointGroupName = "Hazards",
			ObstacleName = "LavaSplash",
			SpawnRate = 10,
			SpawnStagger = 0.1,
			SpawnsPerBurstMin = 4,
			SpawnsPerBurstMax = 5,
		},
		CameraWalls = true,
		SoftClamp = 0.0,
		BreakableOptions = { "BreakableAsphodelIdle", "BreakableAsphodelIdle2", "BreakableAsphodelIdle3" },
		BreakableValueOptions = { MaxHighValueBreakables = 3 },
		WallSlamMultiplier = 1.5,

		EntranceDirectionEndIdObstacleName = "BoatMovePoint",
	},

	B_Combat01 =
	{
		InheritFrom = { "BaseAsphodel", "RandomizeTrapTypesAll" },
		NumExits = 2,
		EntranceDirection = "Right",

		GameStateRequirements =
		{
			-- None
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	B_Combat02 =
	{
		InheritFrom = { "BaseAsphodel", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		EntranceDirection = "Left",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	B_Combat03 =
	{
		InheritFrom = { "BaseAsphodel", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		EntranceDirection = "LeftRight",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	B_Combat04 =
	{
		InheritFrom = { "BaseAsphodel", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 3,
		EntranceDirection = "Left",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	B_Combat05 =
	{
		InheritFrom = { "BaseAsphodel", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		EntranceDirection = "Right",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	B_Combat06 =
	{
		InheritFrom = { "BaseAsphodel", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		EntranceDirection = "Right",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	B_Combat07 =
	{
		InheritFrom = { "BaseAsphodel", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		EntranceDirection = "Right",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	B_Combat08 =
	{
		InheritFrom = { "BaseAsphodel", "RandomizeTrapTypes" },

		NumExits = 2,
		EntranceDirection = "Right",

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	B_Combat09 =
	{
		InheritFrom = { "BaseAsphodel", "RandomizeTrapTypesAll" },
		NumExits = 1,
		EntranceDirection = "Left",
		IneligibleRewards = { "Devotion" },

		GameStateRequirements =
		{
			RequiredMaxBiomeDepth = 4,
		},
	},

	B_Combat10 =
	{
		InheritFrom = { "BaseAsphodel", "RandomizeTrapTypesAll" },
		NumExits = 1,
		EntranceDirection = "Left",
		IneligibleRewards = { "Devotion" },

		GameStateRequirements =
		{
			RequiredMaxBiomeDepth = 4,
		},
	},

	B_Combat21 =
	{
		InheritFrom = { "BaseAsphodel", "RandomizeTrapTypes" },

		NumExits = 3,
		EntranceDirection = "LeftRight",

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	B_Combat22 =
	{
		InheritFrom = { "BaseAsphodel", "RandomizeTrapTypes" },

		NumExits = 2,
		EntranceDirection = "LeftRight",
		
		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "HeroExit",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	B_PreBoss01 =
	{
		InheritFrom = { "BaseAsphodel" },
		NumExits = 1,
		EntranceDirection = "LeftRight",

		ShrineMetaUpgradeName = "BossDifficultyShrineUpgrade",
		LinkedRoomByPactLevel =
		{
			[0] = "B_Boss01", [1] = "B_Boss01", [2] = "B_Boss02", [3] = "B_Boss02", [4] = "B_Boss02"
		},

		ForceAtBiomeDepthMin = 7,
		ForceAtBiomeDepthMax = 7,

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
		SpawnRewardOnId = 547715,
		FlipHorizontalChance = 0.0,

		DisableRewardMagnetisim = true,

		InspectPoints =
		{
			[370027] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_B_PreBoss_01_01 =
					{
						-- Way to spoil the surprise, old man.
						EndCue = "/VO/ZagreusField_0932",
						EndWait = 0.4,
						{ Cue = "/VO/Storyteller_0196",
							Text = "{#DialogueItalicFormat}Having traversed the flaming river Phlegethon to gain this vantage point, relentless Zagreus must now confront a foe of unimaginable savagery, who lies ahead, awaiting patiently its time to strike." },
					},
				},
			},
		},

		ResetBinksOnExit = true,
	},

	B_Boss01 =
	{
		InheritFrom = { "BaseAsphodel" },
		NumExits = 1,
		EntranceDirection = "Right",
		RewardPreviewIcon = "RoomElitePreview4",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",
		ResultText = "RunHistoryScreenResult_B_Boss01",
		RichPresence = "#RichPresence_BBoss01",

		GameStateRequirements =
		{
			-- None
		},

		RequiresLinked = true,
		LinkedRoom = "B_PostBoss01",
		Milestone = true,
		MilestoneIcon = "BossIcon",
		ResetBinksOnExit = true,
		LegalEncounters = { "BossHydra", },
		FirstClearRewardStore = "SuperMetaProgress",
		ForcedRewardStore = "MetaProgress",
		EligibleRewards = { "RoomRewardMetaPointDrop", "RoomRewardMetaPointDropRunProgress", "SuperGemDrop" },
		NoReroll = true,
		SpawnRewardOnId = 40128,
		BlockTreasureImps = true,
		FlipHorizontalChance = 0.0,
		RewardConsumableOverrides =
		{
			ValidRewardNames = { "RoomRewardMetaPointDrop", "RoomRewardMetaPointDropRunProgress", },
			AddResources =
			{
				MetaPoints = 100,
			},
		},

		EntranceFunctionName = "RoomEntranceBossHydra",
		EntranceGroupName = "EntranceObstacles",
		ExitGroupName = "ExitObstacles",
		IntroSequenceDuration = 4.5,
		BlockCameraReattach = true,
		LogShrineClears = true,
		HydraStartingPosition = 554461,

		ZoomFraction = 0.77,
		ZoomFractionSwitch = 0.9,
		CameraZoomWeights =
		{
			[510234] = 1.150, -- Top
			[510235] = 0.93,
			[510236] = 0.93,
			[510237] = 0.93,
		},

		EnterGlobalVoiceLines = "EnteredHydraChamberVoiceLines",
		UnthreadedEvents =
		{
			{ FunctionName = "BossIntroHydra", Args = { } },
			{
				FunctionName = "CheckAssistHint",
				Args =
				{
					Delay = 10.0,
				}
			},
		},

		MusicActiveStems = { "Guitar", "Bass", "Drums" },
		MusicSection = 2,
		MusicStartDelay = 0.25,
	},

	B_Boss02 =
	{
		InheritFrom = { "B_Boss01" },
		GenusName = "B_Boss01",
		ZoomFraction = 0.85,
		ZoomFractionSwitch = 0.9,
		CameraZoomWeights =
		{
			[510234] = 1.11, -- Center
			[517868] = 0.83, -- Top
			[510235] = 0.83,
			[510236] = 0.83,
			[510237] = 0.83,
		},
		HydraStartingPosition = 480903,

	},

	B_PostBoss01 =
	{
		InheritFrom = { "BaseAsphodel" },
		LegalEncounters = { "Empty" },
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		EntranceFunctionName = "RoomEntranceStandard",

		BreakableOptions = { "BreakableIdle1", "BreakableIdle2", "BreakableIdle3" },

		GameStateRequirements =
		{
			-- None
		},

		RequiresLinked = true,
		NextRoomSet = { "Elysium" },
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
		IntroSequenceDuration = 0.9,
		FlipHorizontalChance = 1.0,
		ExitPath = { 558953 },

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

		CameraWalls = false,

		ObstacleData =
		{
			[486511] =
			{
				Template = "HealthFountain",
				Activate = true,
				ActivateIds = { 486607, },
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
		},

		ThreadedEvents =
		{
			{ FunctionName = "HadesSpeakingPresentation", Args = { VoiceLines = GlobalVoiceLines.HadesPostBossVoiceLines, StartDelay = 1 } },
			{ FunctionName = "ProcessInterest", Args = { StartDelay = 1 } },
		},
		EnterVoiceLines =
		{
		},
		ExitVoiceLines =
		{
			PreLineWait = 0.5,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlayAll = 0.66,

			-- Onward.
			{ Cue = "/VO/ZagreusField_1591" },
			-- To the top.
			{ Cue = "/VO/ZagreusField_1592" },
			-- Take me up.
			{ Cue = "/VO/ZagreusField_1593" },
			-- Get me out of here.
			{ Cue = "/VO/ZagreusField_1594" },
			-- Closer...
			{ Cue = "/VO/ZagreusField_4394" },
			-- Bye, Asphodel.
			{ Cue = "/VO/ZagreusField_4395" },
			-- That's it for Asphodel.
			{ Cue = "/VO/ZagreusField_4396" },
			-- Get out of this damn heat.
			{ Cue = "/VO/ZagreusField_4397" },
			-- Enough of this place.
			{ Cue = "/VO/ZagreusField_4398" },
			-- One more floor.
			{ Cue = "/VO/ZagreusField_4399" },
			-- Next region.
			{ Cue = "/VO/ZagreusField_4400" },
			-- Onward, then.
			{ Cue = "/VO/ZagreusField_4401" },
		},

		InspectPoints =
		{
			[532754] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_B_Story_01_01 =
					{
						-- Surely they're friendly, right?
						EndCue = "/VO/ZagreusField_1660",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0228",
							Text = "{#DialogueItalicFormat}Well past the flaming river escalates the hidden stair toward the most well-guarded, splendorous environment within the Underworld: the heavenly Elysium, home eternal to the greatest souls which ever lived." },
					},
				},
			},
		},
	},

	B_Wrapping01 =
	{
		InheritFrom = { "BaseAsphodel", "RandomizeTrapTypes" },
		IsMiniBossRoom = true,
		RewardPreviewIcon = "RoomElitePreview2",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",
		ResultText = "RunHistoryScreenResult_B_Wrapping01",
		Ambience = "/Leftovers/Object Ambiences/WaterRushingBloodRiver2",

		GameStateRequirements =
		{
			RequiredFalseSeenRoomsThisRun = { "B_MiniBoss01", "B_MiniBoss02" },
			RequiredFalseRooms = { "B_MiniBoss01" },
		},

		LegalEncounters = { "WrappingAsphodel", "WrappingAsphodel2" },
		FlipHorizontalChance = 0.0,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { LegendaryChance = 0.1, EpicChance = 0.25, RareChance = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 6,
		MaxAppearancesThisBiome = 1,
		NumExits = 1,
		EntranceDirection = "LeftRight",
		IntroSequenceDuration = 1.5,

		EndMusicOnEnterDuration = 0.25,

		CameraWalls = false,

		HazardData =
		{
			SpawnPointGroupName = "HazardSpawnPoints",
			ObstacleName = "LavaSplash",
			SpawnRate = 6,
			SpawnStagger = 0.1,
			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 3,
			StartDelay = 4,
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
		PostCombatReloadEvents =
		{
			{
				FunctionName = "WrappingPostCombatReloadPresentation",
				Args =
				{
				}
			},
		},

		EnterVoiceLines =
		{
			{
				{
					PlayOnce = true,
					RequiredActiveMetaUpgradeLevel = { Name = "MinibossCountShrineUpgrade", Count = 1 },

					-- Huh, a little quieter than usual.
					{ Cue = "/VO/ZagreusField_4661", PreLineWait = 7.7 },
					-- ...Oh.
					{ Cue = "/VO/ZagreusField_4662", PreLineWait = 1.0 },
				},
				{
					PlayOnce = true,
					RequiredActiveMetaUpgradeLevel = { Name = "MinibossCountShrineUpgrade", Count = 1 },
					BreakIfPlayed = true,
					Cooldowns =
					{
						{ Name = "ZagreusBWrappingSpeech", Time = 200 },
					},

					-- Thought Voidstones didn't get this big...
					{ Cue = "/VO/ZagreusField_4663", PreLineWait = 1.5 },
				},
			},
			{
				PreLineWait = 12.0,
				RandomRemaining = true,
				BreakIfPlayed = true,
				RequiredActiveMetaUpgradeLevel = { Name = "MinibossCountShrineUpgrade", Count = 1 },
				SuccessiveChanceToPlayAll = 0.5,
				Cooldowns =
				{
					{ Name = "ZagreusBWrappingSpeech", Time = 200 },
				},

				-- That's one big Voidstone.
				{ Cue = "/VO/ZagreusField_4664" },
				-- Another big Voidstone, huh.
				{ Cue = "/VO/ZagreusField_4665" },
				-- Come on up, big Voidstone.
				{ Cue = "/VO/ZagreusField_4666", PreLineWait = 10.5 },
				-- Come forth, big Voidstone!
				{ Cue = "/VO/ZagreusField_4667", PreLineWait = 10.5 },
			},
			{
				RandomRemaining = true,
				PreLineWait = 1.5,
				SuccessiveChanceToPlayAll = 0.66,

				-- Here goes nothing.
				{ Cue = "/VO/ZagreusField_0557", RequiredPlayed = { "/VO/ZagreusField_2702" } },
				-- Away we go.
				{ Cue = "/VO/ZagreusField_0558", RequiredPlayed = { "/VO/ZagreusField_2702" } },
				-- Moving right along.
				{ Cue = "/VO/ZagreusField_0559", RequiredPlayed = { "/VO/ZagreusField_2702" } },
				-- Time for another voyage 'board the Barge of Death.
				{ Cue = "/VO/ZagreusField_2697", RequireCurrentEncounterCompleted = true, RequiredPlayed = { "/VO/ZagreusField_2702" }, RequiredPlayed = { "/VO/ZagreusField_2702" } },
				-- Barge of Death again huh.
				{ Cue = "/VO/ZagreusField_2698", RequireCurrentEncounterCompleted = true, RequiredPlayed = { "/VO/ZagreusField_2702" }, RequiredPlayed = { "/VO/ZagreusField_2702" } },
				-- The Barge of Death is always here for me.
				{ Cue = "/VO/ZagreusField_2699", RequireCurrentEncounterCompleted = true, RequiredPlayed = { "/VO/ZagreusField_2702" }, RequiredPlayed = { "/VO/ZagreusField_2702" } },
				-- Have to say, the Barge of Death is never late.
				{ Cue = "/VO/ZagreusField_2700", RequireCurrentEncounterCompleted = true, RequiredPlayed = { "/VO/ZagreusField_2702" }, RequiredPlayed = { "/VO/ZagreusField_2702" } },
				-- Ready when you are, Barge of Death.
				{ Cue = "/VO/ZagreusField_2701", RequireCurrentEncounterCompleted = true, RequiredPlayed = { "/VO/ZagreusField_2702" }, RequiredPlayed = { "/VO/ZagreusField_2702" } },
				-- Why it's the Barge of Death.
				{ Cue = "/VO/ZagreusField_2702" },
				-- Barge of Death, you're here!
				{ Cue = "/VO/ZagreusField_2703", RequireCurrentEncounterCompleted = true, RequiredPlayed = { "/VO/ZagreusField_2702" }, RequiredPlayed = { "/VO/ZagreusField_2702" } },
				-- Somebody lose a spine out there?
				{ Cue = "/VO/ZagreusField_2704", RequiredPlayed = { "/VO/ZagreusField_2702" } },
			},
		},
	},

	B_MiniBoss01 =
	{
		InheritFrom = { "BaseAsphodel", },
		IsMiniBossRoom = true,
		RewardPreviewIcon = "RoomElitePreview2",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",
		ResultText = "RunHistoryScreenResult_B_MiniBoss01",

		GameStateRequirements =
		{
			RequiredFalseSeenRoomsThisRun = { "B_Wrapping01", "B_MiniBoss02" },
		},

		LegalEncounters = { "MiniBossHitAndRun" },
		FlipHorizontalChance = 0.0,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { LegendaryChance = 0.1, EpicChance = 0.25, RareChance = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 6,
		MaxAppearancesThisBiome = 1,
		NumExits = 1,
		EntranceDirection = "Right",
		ZoomFraction = 0.85,

		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,

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
			PreLineWait = 1.6,
			SuccessiveChanceToPlayAll = 0.33,
			ThreadName = "RoomThread",

			-- Don't let it go to your head?
			{ Cue = "/VO/ZagreusField_1187", RequiredPlayed = { "/VO/ZagreusField_1188" } },
			-- Until next time, gigantic gorgon head.
			{ Cue = "/VO/ZagreusField_1188" },
			-- I didn't catch her name.
			{ Cue = "/VO/ZagreusField_1189", RequiredPlayed = { "/VO/ZagreusField_1188" } },
			-- Bye, you two.
			{ Cue = "/VO/ZagreusField_4234", RequiredPlayed = { "/VO/ZagreusField_1188" } },
			-- See you next time.
			{ Cue = "/VO/ZagreusField_4235", RequiredPlayed = { "/VO/ZagreusField_1188" } },
			-- Farewell, gigantic gorgon head.
			{ Cue = "/VO/ZagreusField_4236", RequiredPlayed = { "/VO/ZagreusField_1188" } },
			-- There goes the power couple.
			{ Cue = "/VO/ZagreusField_4237", RequiredPlayed = { "/VO/ZagreusField_1188" } },
			-- I hate those two.
			{ Cue = "/VO/ZagreusField_4238", RequiredPlayed = { "/VO/ZagreusField_1188" } },
			-- Enough of them.
			{ Cue = "/VO/ZagreusField_4239", RequiredPlayed = { "/VO/ZagreusField_1188" } },
		},
	},

	B_MiniBoss02 =
	{
		InheritFrom = { "BaseAsphodel", },
		IsMiniBossRoom = true,
		RewardPreviewIcon = "RoomElitePreview2",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",
		ResultText = "RunHistoryScreenResult_B_MiniBoss02",

		GameStateRequirements =
		{
			RequiredFalseSeenRoomsThisRun = { "B_Wrapping01", "B_MiniBoss01" },
			RequiredSeenEncounter = "BossHydra",
		},

		LegalEncounters = { "MiniBossSpreadShot" },
		FlipHorizontalChance = 0.0,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { LegendaryChance = 0.1, EpicChance = 0.25, RareChance = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 6,
		MaxAppearancesThisBiome = 1,
		NumExits = 1,
		EntranceDirection = "Right",
		ZoomFraction = 0.85,

		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,

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

			-- Witchcraft. What can you do.
			{ Cue = "/VO/ZagreusField_3727" },
			-- Farewell, ladies.
			{ Cue = "/VO/ZagreusField_3728", RequiredPlayed = { "/VO/ZagreusField_3727" } },
			-- No hard feelings.
			{ Cue = "/VO/ZagreusField_3729", RequiredPlayed = { "/VO/ZagreusField_3727" } },
			-- That takes care of them.
			{ Cue = "/VO/ZagreusField_3730", RequiredPlayed = { "/VO/ZagreusField_3727" } },
			-- Well I, for one, had a lovely time.
			{ Cue = "/VO/ZagreusField_3959", RequiredPlayed = { "/VO/ZagreusField_3727" } },
			-- Bye now, ladies.
			{ Cue = "/VO/ZagreusField_3960", RequiredPlayed = { "/VO/ZagreusField_3727" } },
			-- Let's do this again sometime all right?
			{ Cue = "/VO/ZagreusField_3961", RequiredPlayed = { "/VO/ZagreusField_3727" } },
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
					B_MiniBoss02_FirstInspect =
					{
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							RequiredMinElapsedTime = 3,
							UsePlayerSource = true,
							-- I'm sure the Witches Circle will reconvene soon enough.
							{ Cue = "/VO/ZagreusField_3906" },
						},
						{ Cue = "/VO/Storyteller_0369",
							Text = "{#DialogueItalicFormat}The act of sorcery often ends in an untimely death and an eternity in Tartarus for careless souls, though some are able to perfect the trade, and take up permanent residence elsewhere..." },
					},
				},
			},
		},
	},

	B_Shop01 =
	{
		InheritFrom = { "BaseAsphodel" },
		NumExits = 1,
		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 3,
		ForceAtBiomeDepthMax = 5,
		LegalEncounters = { "Shop" },
		ForcedReward = "Shop",
		NoReroll = true,
		EntranceDirection = "Left",

		GameStateRequirements =
		{
			RequiredMinExits = 2,
			RequiredMaxBiomeDepth = 5,
		},

		Binks =
		{
			"CharonIdleShop_Bink",
			"CharonIdleGreeting_Bink",
		},

		SpawnRewardGlobalVoiceLines = "FoundShopVoiceLines",

		InspectPoints =
		{
			[390000] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_B_Shop_01_01 =
					{
						-- I do enjoy dead people's fineries.
						EndCue = "/VO/ZagreusField_0933",
						EndWait = 0.3,
						{ Cue = "/VO/Storyteller_0197",
							Text = "{#DialogueItalicFormat}The searing flame and ashes of the river Phlegethon mean nothing to the ferryman, Charon, who travels all the waters of the Underworld, bearing the dead, the damned, and all their fineries." },
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
	},

	B_Reprieve01 =
	{
		InheritFrom = { "BaseAsphodel" },
		NumExits = 1,
		IneligibleRewards = { "Devotion", },
		SuppressRewardSpawnSounds = true,
		MaxCreationsThisRun = 1,
		
		GameStateRequirements =
		{
			RequiredCosmetics = { "AsphodelReprieve" },
			RequiredMinCompletedRuns = 0,
			RequiredMinBiomeDepth = 3,
		},

		LegalEncounters = { "HealthRestore" },
		EntranceDirection = "Right",
		SpawnRewardOnId = 410000,
		ZoomFraction = 0.75,

		EntranceFunctionName = "AsphodelEnterRoomPresentation",

		MusicMutedStems = { "Guitar", "Drums", "Bass" },
		EnterGlobalVoiceLines = "EnteredReprieveRoomVoiceLines",

		InspectPoints =
		{
			[506296] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_B_Reprieve_01_01 =
					{
						-- You feeling lucky, too, old man? Then show yourself! No...?
						EndCue = "/VO/ZagreusField_0934",
						EndWait = 0.3,
						{ Cue = "/VO/Storyteller_0198",
							Text = "{#DialogueItalicFormat}Hidden well within the limitless inferno of the river Phlegethon, somehow, a trickle of life-giving water yet remains; as though provided by the Fates themselves unto the very lucky Prince." },
					},
				},
			},
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "HealthFountain", WithinDistance = 800,
				VoiceLines =
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.33,

					-- What's this doing all the way out here?
					{ Cue = "/VO/ZagreusField_0760" },
					-- Is that a sight for sore eyes.
					{ Cue = "/VO/ZagreusField_0761" },
					-- What's that thing doing here?
					{ Cue = "/VO/ZagreusField_0762" },
					-- How'd that get here?
					{ Cue = "/VO/ZagreusField_0763" },
				},
			},
		},
	},

	B_Intro =
	{
		InheritFrom = { "BaseAsphodel" },
		NumExits = 1,
		LegalEncounters = { "Empty" },
		IntroSequenceDuration = 1.4,
		NoReward = true,
		NoReroll = true,
		SkipLastKillPresentation = true,
		HideRewardPreview = true,
		TimerBlock = "IntroRoom",
		RemoveTimerBlock = "InterBiome",
		EntranceFunctionName = "RoomEntranceStandard",
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		FlipHorizontalChance = 0.0,

		ForceAtBiomeDepthMin = 0,
		ForceAtBiomeDepthMax = 1,
		MaxAppearancesThisBiome = 1,

		GameStateRequirements =
		{
			-- None
		},

		ZoomFraction = 0.78,
		ZoomFractionSwitch = 0.95,

		ThreadedEvents =
		{
			{ FunctionName = "DisplayLocationText", Args = { Text = "Location_Asphodel" } },
			{ FunctionName = "CheckLocationUnlock", Args = { Biome = "Asphodel" } },
		},

		-- Room Audio Below This Line
		MusicActiveStems = { "Guitar", "Bass", "Drums" },
		MusicStartDelay = 1.75,
		MusicMutedStems = { "Drums" },
		PlayBiomeMusic = true,
		MusicSection = 0,

		EnterVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 2.65,
			SuccessiveChanceToPlayAll = 0.5,

			-- Getting warmer.
			{ Cue = "/VO/ZagreusField_0261", RequiredPlayed = { "/VO/ZagreusField_0262" } },
			-- Now we're getting somewhere.
			{ Cue = "/VO/ZagreusField_0262" },
			-- Change of scenery at least.
			{ Cue = "/VO/ZagreusField_0263", RequiredPlayed = { "/VO/ZagreusField_0262" } },
			-- The Asphodel Meadows...
			{ Cue = "/VO/ZagreusField_0264", RequiredPlayed = { "/VO/ZagreusField_0262" } },
			-- Made it to Asphodel...
			{ Cue = "/VO/ZagreusField_0265", RequiredPlayed = { "/VO/ZagreusField_0262" } },
			-- Asphodel...
			{ Cue = "/VO/ZagreusField_4240", RequiredPlayed = { "/VO/ZagreusField_0262" } },
			-- Hot up here...
			{ Cue = "/VO/ZagreusField_4241", RequiredPlayed = { "/VO/ZagreusField_0262" } },
			-- Be there soon, Lernie...
			{ Cue = "/VO/ZagreusField_4242", RequiredPlayed = { "/VO/ZagreusField_3147", "/VO/ZagreusField_0262" }, RequiredFalsePlayedLastRun = { "/VO/ZagreusField_3147" }, },
			-- Be there soon, Bone Hydra...
			{ Cue = "/VO/ZagreusField_4243", RequiredSeenRooms = { "B_Boss01" }, RequiredFalsePlayed = { "/VO/ZagreusField_3147" }, RequiredPlayed = { "/VO/ZagreusField_0262" } },
			-- Ugh, this heat...
			{ Cue = "/VO/ZagreusField_4244", RequiredPlayed = { "/VO/ZagreusField_0262" } },
			-- The Bone Hydra awaits...
			{ Cue = "/VO/ZagreusField_4245", RequiredSeenRooms = { "B_Boss01" }, RequiredFalsePlayed = { "/VO/ZagreusField_3147" }, RequiredPlayed = { "/VO/ZagreusField_0262" } },
			-- Lernie awaits...
			{ Cue = "/VO/ZagreusField_4246", RequiredSeenRooms = { "B_Boss01" }, RequiredPlayed = { "/VO/ZagreusField_3147", "/VO/ZagreusField_0262" }, RequiredFalsePlayedLastRun = { "/VO/ZagreusField_3147" }, },
			-- Love that sulfur smell...
			{ Cue = "/VO/ZagreusField_4247", RequiredPlayed = { "/VO/ZagreusField_0262" } },
		},

		InspectPoints =
		{
			[480897] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_B_Intro_01_01 =
					{
						-- I'm only flame-resistant not flame-proof.
						EndCue = "/VO/ZagreusField_0936",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0200",
							Text = "{#DialogueItalicFormat}The once-verdant plains of Asphodel are now engulfed in scintillating flame, having been flooded by the river Phlegethon, whose hideously superheated contents could bring death swiftly even to those resistant to most heat." },
					},
				},
			},
			[505096] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTextLines = { "Inspect_B_Intro_01_01", },
				InteractTextLineSets =
				{
					Inspect_B_Intro_02 =
					{
						-- Or until I crush their bones to dust.
						EndCue = "/VO/ZagreusField_0534",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0160",
							Text = "{#DialogueItalicFormat}Within the suffocating heat of Asphodel reside the vast majority of those who lived upon the earth and died. There they persist until the end of time." },
					},
				},
			},
		},

		DistanceTriggers =
		{
			-- Overlook
			{
				TriggerGroup = "OverlookOut", WithinDistance = 150, FunctionName = "BiomeOverlook", Repeat = true, Args = { PanTargetId = 547653, ZoomFraction = 0.75 },
			},
			{
				TriggerGroup = "OverlookIn", WithinDistance = 150, FunctionName = "BiomeBackToRoom", Repeat = true,
			},
		},
	},

	B_Story01 =
	{
		InheritFrom = { "BaseAsphodel" },
		ForcedReward = "Story",
		NoReroll = true,
		MaxCreationsThisRun = 1,
		
		RichPresence = "#RichPresence_BStory01",

		GameStateRequirements =
		{
			-- run rollout prereqs
			RequiredFalseTextLinesThisRun = { "HermesFirstPickUp", "SisyphusFirstMeeting", "Fury2FirstAppearance", "Fury3FirstAppearance" },
			RequiredFalseTextLinesLastRun = { "OrpheusAboutSingersReunionQuest01" },
			RequiredMinBiomeDepth = 2,
			RequiredMinCompletedRuns = 1,
			RequiredSeenRooms = { "B_Boss01" },
		},

		ZoomFraction = 0.85,
		TimerBlock = "StoryRoom",

		EndMusicOnEnterDuration = 0.2,

		FlipHorizontalChance = 0.0,
		LegalEncounters = { "Story_Eurydice_01" },
		EntranceDirection = "LeftRight",
		NumExits = 1,

		InspectPoints =
		{
			[547875] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredAnyTextLines = { "EurydiceFirstMeeting01_A", "EurydiceFirstMeeting01_B", "EurydiceFirstMeeting01_C" },
				InteractTextLineSets =
				{
					Inspect_B_Story_01_01 =
					{
						-- You watch yourself, old man.
						EndCue = "/VO/ZagreusHome_1316",
						EndWait = 0.4,
						{ Cue = "/VO/Storyteller_0275",
							Text = "{#DialogueItalicFormat}From within a humble residence in Asphodel reverberates the golden-sounding voice of lorn Eurydice, who once attempted to escape the Underworld, and failed, utterly, much like Prince Zagreus." },
					},
				},
			},
		},

		EnterVoiceLines =
		{
			{
				BreakIfPlayed = true,
				PreLineWait = 2.0,
				AreIdsAlive = { 554419 },
				RequiredAnyQueuedTextLines = { 
					"OrpheusWithEurydiceEndTheme01",
					"OrpheusWithEurydiceInTheBloodChat01",
					"OrpheusWithEurydiceInTheBloodChat02",
					"OrpheusWithEurydiceInTheBloodChat03",
					"OrpheusWithEurydiceInTheBloodChat04"
				},
				-- ...Hey, I know this one...!
				{ Cue = "/VO/ZagreusField_4282", PlayOnce = true, PlayOnceContext = "OrpheusEurydiceReunion" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 2.0,
				AreIdsAlive = { 554419 },

				-- ...That's Orpheus!
				{ Cue = "/VO/ZagreusField_3423", PlayOnce = true, PlayOnceContext = "OrpheusEurydiceReunion" },
				-- ...They're both here...
				{ Cue = "/VO/ZagreusField_3424", ChanceToPlayAgain = 0.1 },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 2.0,
				RequiresNullAmbientMusicId = true,
				PlayOnce = true,

				-- Wait... she's not singing...
				{ Cue = "/VO/ZagreusField_2511" },
				-- Hope Eurydice's all right...
				{ Cue = "/VO/ZagreusField_2512", RequiredPlayed = { "/VO/ZagreusField_2511" } },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlayAll = 0.1,
				PreLineWait = 2.0,

				-- What... singing... here?
				{ Cue = "/VO/ZagreusField_2506", PlayOnce = true },
				-- Must be Eurydice.
				{ Cue = "/VO/ZagreusField_2507", RequiredPlayed = { "/VO/ZagreusField_2506" }, PlayOnce = true, },
				-- She's always singing.
				{ Cue = "/VO/ZagreusField_2508", RequiredPlayed = { "/VO/ZagreusField_2506" }, RequiredFalseTextLines = { "EurydiceProgressWithOrpheus03" } },
				-- Good to be back here.
				{ Cue = "/VO/ZagreusField_2509", RequiredPlayed = { "/VO/ZagreusField_2506" } },
				-- Eurydice...
				{ Cue = "/VO/ZagreusField_2510", RequiredPlayed = { "/VO/ZagreusField_2506" }, AreIdsNotAlive = { 554419 }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.1,
				PreLineWait = 2.0,

				-- Guess I get a break.
				{ Cue = "/VO/ZagreusField_0768" },
				-- Can catch my breath...
				{ Cue = "/VO/ZagreusField_2691" },
			}
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Eurydice_01", WithinDistance = 375,
				SetFlagTrue = "MetEurydice",
			}
		},

		ExitVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.15,
				SuccessiveChanceToPlay = 0.75,
				RequiredFalsePlayedThisRoom = { "/VO/Eurydice_0080" },
				Cooldowns =
				{
					{ Name = "ZagreusExitSpeech" },
				},

				-- Bye now!
				{ Cue = "/VO/ZagreusField_2523" },
				-- Till next time!
				{ Cue = "/VO/ZagreusField_2524" },
				-- See you!
				{ Cue = "/VO/ZagreusField_2525" },
				-- Thanks again!
				{ Cue = "/VO/ZagreusField_2526" },
				-- Take care!
				{ Cue = "/VO/ZagreusField_2527" },
				-- Bye!
				{ Cue = "/VO/ZagreusField_2528" },
				-- See you again!
				{ Cue = "/VO/ZagreusField_2529" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlayAll = 0.75,
				-- RequiredFalseTextLinesThisRun = { "EurydiceFirstMeeting01_C" },
				RequiredFalseTextLinesThisRun = { "EurydiceAboutOrpheus02" },
				ObjectType = "NPC_Eurydice_01",
				RequiredFalsePlayedThisRoom = { "/VO/Eurydice_0080" },
				Cooldowns =
				{
					{ Name = "EurydiceExitSpeech" },
				},

				-- Well, see you!
				{ Cue = "/VO/Eurydice_0111" },
				-- Careful, hon!
				{ Cue = "/VO/Eurydice_0112" },
				-- Take care, yeah?
				{ Cue = "/VO/Eurydice_0113" },
				-- Farewell Your Majesty!
				{ Cue = "/VO/Eurydice_0114" },
				-- Bye!!
				{ Cue = "/VO/Eurydice_0115" },
				-- OK bye!
				{ Cue = "/VO/Eurydice_0116" },
				-- Later then, yeah?
				{ Cue = "/VO/Eurydice_0117" },
				-- Smooth sailing!
				{ Cue = "/VO/Eurydice_0118" },
				-- Stay cool!
				{ Cue = "/VO/Eurydice_0119" },
				-- See you next time!
				{ Cue = "/VO/Eurydice_0120" },
				-- Come again!
				{ Cue = "/VO/Eurydice_0121" },
				-- You can do it!
				{ Cue = "/VO/Eurydice_0122", RequiredTextLines = { "EurydiceMiscMeeting05" } },
				-- See you!
				{ Cue = "/VO/Eurydice_0219" },
				-- Take it easy!
				{ Cue = "/VO/Eurydice_0220" },
				-- Take care!
				{ Cue = "/VO/Eurydice_0221" },
				-- Bye, hon!
				{ Cue = "/VO/Eurydice_0222" },
				-- Stay safe!
				{ Cue = "/VO/Eurydice_0223", RequiredTextLines = { "EurydiceMiscMeeting05" } },
				-- Safe travels!
				{ Cue = "/VO/Eurydice_0224", RequiredTextLines = { "EurydiceMiscMeeting05" } },
			}
		},

		StartUnthreadedEvents =
		{
			-- None
		},

		UnthreadedEvents =
		{
			-- None
		},

		ThreadedEvents =
		{
			-- None
		},

		LeaveUnthreadedEvents =
		{
			{ FunctionName = "StopMusicianMusic", Args = { Duration = 4.0, } },
		},
	},
}

OverwriteTableKeys( RoomData, RoomSetData.Asphodel )