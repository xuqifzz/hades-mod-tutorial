ConstantsData.MinimumDifficulty = 10

WaveDifficultyPatterns =
{
	{ 1 },
	{ 0.5, 0.5 },
	{ 0.3, 0.15, 0.55 },
	{ 0.3, 0.1, 0.2, 0.4 },
	{ 0.25, 0.1, 0.15, 0.15, 0.35 },
}

TimerBlockCombatExcludes = 
{
	"ThanatosEncounter", "SurvivalEncounter",
}

BaseWaveOverrideValues =
{
	RequireNearPlayerDistance = 1500,
	SpawnAggroed = true,
	IgnoreSpawnPreferences = true,
}

ElysiumWaveOverrideValues =
{
	RequireNearPlayerDistance = 1500,
	SpawnAggroed = true,
	IgnoreSpawnPreferences = true,
}

IntroWaveOverrideValues =
{
	ActiveEnemyCapBase = 2.3,
	ActiveEnemyCapMax = 8,
	ActiveEnemyCapDepthRamp = 0.35,
	SpawnIntervalMin = 0.175,
	SpawnIntervalMax = 0.225,
	RequireNearPlayerDistance = 750,
	SpawnAggroed = true,
	IgnoreSpawnPreferences = true,
}

EncounterData =
{
	NonCombat =
	{
		EncounterType = "NonCombat",
		SkipExitReadyCheckpoint = true,
	},

	MinibossEncounter =
	{
		EncounterType = "Miniboss",
		RewardPreviewIcon = "RoomElitePreview2",
		RewardBoostedAnimation = "RoomRewardAvailableRareSparkles",
		BlockSpawnMultipliers = true,
		BlockEliteAttributes = true,
	},

	BossEncounter =
	{
		EncounterType = "Boss",
		RewardPreviewIcon = "RoomElitePreview4",
		RewardBoostedAnimation = "RoomRewardAvailableRareSparkles",
		BlockSpawnMultipliers = true,
		ActiveEnemyCapMax = 7,
	},

	Empty =
	{
		InheritFrom = { "NonCombat" },
		SkipCombatBeginsVoiceLines = true,
	},

	Secret =
	{
		InheritFrom = { "Empty" },
		-- UnthreadedEvents = {},
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Nyx_Story_01" }, } },
			{ FunctionName = "CheckConversations" },
		},
	},

	Surface =
	{
		InheritFrom = { "NonCombat" },
		UnthreadedEvents = {},
	},

	-- ending
	Story_Persephone_01 =
	{
		InheritFrom = { "NonCombat" },
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		MaxAppearancesThisBiome = 1,
		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "ActivatePrePlaced",
				Args =
				{
					FractionMin = 1.0, FractionMax = 1.0,
					LegalTypes = { "NPC_Persephone_01" },
				}
			},
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					RequiredTextLines = { "PersephoneMeeting09" },
				},
				Args =
				{
					Groups = { "TravelBags" },
				},
			},
		},
	},

	Generated =
	{
		EncounterType = "Default",
		Generated = true,
		PreSpawnEnemies = true,
		PreSpawnMinPlayerDistance = 750,
		GroupReinforcements = false,
		UnthreadedEvents = EncounterSets.EncounterEventsGenerated,

		SpawnIntervalMin = 0.175,
		SpawnIntervalMax = 0.225,
		ActiveEnemyCapBase = 2.3,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0.35,
		MinTypes = 1,
		MaxTypes = 2,
		MinWaves = 1,
		MaxWaves = 3,
		MaxTypesCap = 4,
		TypeCountDepthRamp = 0.20,
		BaseDifficulty = 30,
		DepthDifficultyRamp = 10,
		MetaPointStoreRamp = 0.5,
		MoneyDropCapMin = 10,
		MoneyDropCapMax = 10,
		MoneyDropCapDepthRamp = 0.5,
		EnemySet = EnemySets.EnemiesBiome1,
		WaveStartPresentationFunction = "StartWavePresentation",

		Spawns = {},
		SpawnWaves = {},
		WaveTemplate =
		{
			Spawns =
			{

			},
			OverrideValues = BaseWaveOverrideValues,
			StartDelay = 1.0
		},
		NoFirstWaveStartDelay = true,

		ReinforcementsDataOverride =
		{
			RequireNearPlayerDistance = 750,
			SpawnAggroed = true,
		},
	},

	GeneratedTartarus =
	{
		InheritFrom = { "Generated" },
		EnemySet = EnemySets.EnemiesBiome1,
		FastClearThreshold = 25,
		ActiveEnemyCapBase = 2.3,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0.35,
		DepthDifficultyRamp = 11,
		MaxEliteTypes = 1,

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 12,
			EnemySet = EnemySets.EnemiesBiome1Hard,
			MaxEliteTypes = 5,
		},
	},

	GeneratedAsphodel =
	{
		InheritFrom = { "Generated" },
		EnemySet = EnemySets.EnemiesBiome2,
		SpawnHazards = true,
		PreSpawnMinPlayerDistance = 1150,
		RequireNearPlayerDistance = 1500,
		BaseDifficulty = 170,
		ActiveEnemyCapBase = 5.0,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 1.0,
		TypeCountDepthRamp = 0.35,
		MinTypes = 2,
		MaxTypes = 2,
		MaxTypesCap = 5,
		MinWaves = 2,
		MaxWaves = 3,
		DepthDifficultyRamp = 25,
		MoneyDropCapMin = 15,
		MoneyDropCapMax = 25,
		MoneyDropCapDepthRamp = 0,
		FastClearThreshold = 40,
		MaxEliteTypes = 2,

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "DisableRoomTraps" },
		},

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] = {
				Spawns =
				{

				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				PauseHazards = true,
			},

			-- 1 Wave left (second to last wave)
			[-1] =
			{
				Spawns =
				{

				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				EnableRoomTraps = true,
			},

			-- 0 Waves left (last wave)
			[0] =
			{
				Spawns =
				{

				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				UnpauseHazards = true,
			},
		},

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 30,
			EnemySet = EnemySets.EnemiesBiome2Hard,
			MaxEliteTypes = 5,
		},
	},

	GeneratedElysium =
	{
		InheritFrom = { "Generated" },
		UnthreadedEvents = EncounterSets.EncounterEventsGenerated,
		EnemySet = EnemySets.EnemiesBiome3,
		PreSpawnMinPlayerDistance = 900,
		RequireNearPlayerDistance = 1250,
		BaseDifficulty = 220,
		TypeCountDepthRamp = 0.35,
		MinTypes = 2,
		MaxTypes = 2,
		MaxTypesCap = 5,
		MinWaves = 2,
		MaxWaves = 3,
		ActiveEnemyCapMax = 6,
		MoneyDropCapMin = 25,
		MoneyDropCapMax = 35,
		MoneyDropCapDepthRamp = 0,
		DepthDifficultyRamp = 70,
		ActiveEnemyCapDepthRamp = 0.4,
		FastClearThreshold = 45,
		MaxEliteTypes = 3,

		--SpawnShadeWeapons = true,
		WaveTemplate =
		{
			Spawns =
			{

			},
			OverrideValues = ElysiumWaveOverrideValues,
			StartDelay = 1.0
		},

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 80,
			EnemySet = EnemySets.EnemiesBiome3Hard,
			MaxEliteTypes = 4,
		},
	},

	GeneratedStyx =
	{
		InheritFrom = { "Generated" },
		UnthreadedEvents = EncounterSets.EncounterEventsGenerated,
		EnemySet = EnemySets.EnemiesBiome4,
		PreSpawnMinPlayerDistance = 700,
		RequireNearPlayerDistance = 1250,
		BaseDifficulty = 900,
		DepthDifficultyRamp = 0,
		TypeCountDepthRamp = 0,
		MinTypes = 2,
		MaxTypes = 4,
		MaxTypesCap = 4,
		MinWaves = 3,
		MaxWaves = 3,
		MoneyDropCapMin = 40,
		MoneyDropCapMax = 65,
		MoneyDropCapDepthRamp = 0,
		ActiveEnemyCapBase = 5,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0,
		FastClearThreshold = 50,
		MaxEliteTypes = 3,

		WaveTemplate =
		{
			Spawns =
			{

			},
			OverrideValues = BaseWaveOverrideValues,
			StartDelay = 1.0
		},

		HardEncounterOverrideValues =
		{
			MaxEliteTypes = 4,
		},

		--MaxAppearancesThisRun = 1,
	},

	BaseStyxMiniboss =
	{
		EnemySet = EnemySets.EnemiesBiome4MiniBossFodder,
		SpawnIntervalMin = 2.5,
		SpawnIntervalMax = 4.0,
		SpawnCapHitReleaseDuration = 8.0,
		SpawnAggroed = true,

		MinWaves = 1,
		MaxWaves = 1,
		MaxTypesCap = 3,
		ActiveEnemyCapBase = 3,
		ActiveEnemyCapMax = 8,

		EnemyCountDepthRamp = 0,
		FastClearThreshold = 60,

		MaxAppearancesThisRun = 1,
		PreSpawnEnemies = false,
		NoFirstWaveStartDelay = false,
	},

	MiniBossRatThug =
	{
		InheritFrom = { "BaseStyxMiniboss", "MinibossEncounter", "GeneratedStyx" },

		SpawnIntervalMin = 4.0,
		SpawnIntervalMax = 6.5,
		SpawnCapHitReleaseDuration = 9.5,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "RatThugMiniboss",
						TotalCount = 1,
						ForceFirst = true,
						SpawnOnId = 547560,
					},
					{
						Name = "ThiefImpulseMineLayer",
						InfiniteSpawns = true,
					},
					{
						EnemySet = EnemySets.EnemiesBiome4MiniBoss,
						TotalCount = 1,
						Generated = true,
						RequiredMetaUpgrade = "MinibossCountShrineUpgrade",
						PrioritySpawn = true,
					},
				},
				StartDelay = 1.0,
			},
		},

		CancelSpawnsOnKillAll = EnemySets.EnemiesBiome4MiniBoss,
		SpawnThreadName = "MiniBossRatThugSpawnThread",

		StartGlobalVoiceLines = "D_MiniBossEncounterStartVoiceLines",
	},

	MiniBossMineLayer =
	{
		InheritFrom = { "BaseStyxMiniboss", "MinibossEncounter", "GeneratedStyx" },

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "ThiefImpulseMineLayerMiniboss",
						TotalCount = 1,
						ForceFirst = true,
						SpawnOnId = 510885,
					},
					{
						Name = "RatThug",
						InfiniteSpawns = true,
					},
					{
						EnemySet = EnemySets.EnemiesBiome4MiniBoss,
						TotalCount = 1,
						Generated = true,
						RequiredMetaUpgrade = "MinibossCountShrineUpgrade",
						PrioritySpawn = true,
					},
				},
				StartDelay = 1.0,
			},
		},

		CancelSpawnsOnKillAll = EnemySets.EnemiesBiome4MiniBoss,
		SpawnThreadName = "MiniBossMineLayerSpawnThread",

		StartGlobalVoiceLines = "D_MiniBossEncounterStartVoiceLines",
	},

	MiniBossSatyr =
	{
		InheritFrom = { "BaseStyxMiniboss", "MinibossEncounter", "GeneratedStyx" },


		SpawnIntervalMin = 0.8,
		SpawnIntervalMax = 1.2,
		SpawnCapHitReleaseDuration = 4.0,
		ActiveEnemyCapBase = 6,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "SatyrRangedMiniboss",
						TotalCount = 1,
						ForceFirst = true,
						SpawnOnId = 547603,
					},
					{
						Name = "Crawler",
						InfiniteSpawns = true,
					},
					{
						EnemySet = EnemySets.EnemiesBiome4MiniBoss,
						TotalCount = 1,
						Generated = true,
						RequiredMetaUpgrade = "MinibossCountShrineUpgrade",
						PrioritySpawn = true,
					},
				},
				StartDelay = 1.0,
			},
		},

		CancelSpawnsOnKillAll = EnemySets.EnemiesBiome4MiniBoss,
		SpawnThreadName = "MiniBossSatyrSpawnThread",

		StartGlobalVoiceLines = "D_MiniBossEncounterStartVoiceLines",
	},

	MiniBossHeavyRangedForked =
	{
		InheritFrom = { "BaseStyxMiniboss", "MinibossEncounter", "GeneratedStyx" },

		SpawnIntervalMin = 5.5,
		SpawnIntervalMax = 7.0,
		SpawnCapHitReleaseDuration = 11.0,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "HeavyRangedForkedMiniboss",
						TotalCount = 1,
						ForceFirst = true,
						SpawnOnId = 543255,
					},
					{
						Name = "SatyrRanged",
						InfiniteSpawns = true,
					},
					{
						EnemySet = EnemySets.EnemiesBiome4MiniBoss,
						TotalCount = 1,
						Generated = true,
						RequiredMetaUpgrade = "MinibossCountShrineUpgrade",
						PrioritySpawn = true,
					},
				},
				StartDelay = 1.0,
			},
		},

		CancelSpawnsOnKillAll = EnemySets.EnemiesBiome4MiniBoss,
		SpawnThreadName = "MiniBossHeavyRangedForkedSpawnThread",

		StartGlobalVoiceLines = "D_MiniBossEncounterStartVoiceLines",
	},

	MiniBossCrawler =
	{
		InheritFrom = { "BaseStyxMiniboss", "MinibossEncounter" },
		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "ActivatePrePlaced",
				Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "CrawlerMiniBoss" }, IgnoreAI = true, SkipPresentation = true, PreLoadBinks = true },
			},
			{ FunctionName = "AngleIds", Args = { Ids = { 552394 }, DestinationId = 40055 } }
		},
		ShrineMetaUpgradeName = "BossDifficultyShrineUpgrade",
		UnthreadedEvents = EncounterSets.EncounterEventsCrawlerMiniBoss,

		WipeEnemiesOnKill = "CrawlerMiniBoss",

		SpawnIntervalMin = 9.0,
		SpawnIntervalMax = 11.0,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 4,
		SpawnAggroed = true,
		MoneyDropCapMin = 25,
		MoneyDropCapMax = 25,
		MoneyDropCapDepthRamp = 0,
		FastClearThreshold = 75,
		SkipIntroEncounterCheck = true,
		SkipLastKillPresentation = true,
		SkipCombatBeginsVoiceLines = true,

		SpawnWaves =
		{
		},

		EncounterResolvedGlobalVoiceLines = "CrawlerMiniBossEncounterEndVoiceLines",

	},

	GeneratedStyxMini =
	{
		InheritFrom = { "Generated" },
		UnthreadedEvents = EncounterSets.EncounterEventsGenerated,
		EnemySet = EnemySets.EnemiesBiome4Mini,
		PreSpawnEnemies = true,
		PreSpawnAIWakeDelay = 0.5,
		PreSpawnMinPlayerDistance = 300,
		RequireNearPlayerDistance = 1250,
		BaseDifficultyMin = 130,
		BaseDifficultyMax = 230,
		TypeCountDepthRamp = 0,
		MinTypes = 1,
		MaxTypes = 2,
		MaxTypesCap = 2,
		MinWaves = 1,
		MaxWaves = 1,
		MoneyDropCapMin = 8,
		MoneyDropCapMax = 12,
		MoneyDropCapDepthRamp = 0,
		DepthDifficultyRamp = 0,
		ActiveEnemyCapBase = 3,
		ActiveEnemyCapMin = 3,
		ActiveEnemyCapMax = 3,
		ActiveEnemyCapDepthRamp = 0.0,

		WaveTemplate =
		{
			Spawns =
			{

			},
			OverrideValues = BaseWaveOverrideValues,
			StartDelay = 0
		},
		NoFirstWaveStartDelay = false,

		HardEncounterOverrideValues =
		{
			EnemySet = EnemySets.EnemiesBiome4MiniHard
		},
	},

	GeneratedStyxMiniSingle =
	{
		InheritFrom = { "Generated" },
		UnthreadedEvents = EncounterSets.EncounterEventsGenerated,
		EnemySet = EnemySets.EnemiesBiome4MiniSingle,
		PreSpawnEnemies = true,
		PreSpawnMinPlayerDistance = 300,
		RequireNearPlayerDistance = 1250,
		BaseDifficultyMin = 10,
		BaseDifficultyMax = 10,
		TypeCountDepthRamp = 0,
		MinTypes = 1,
		MaxTypes = 2,
		MaxTypesCap = 1,
		MinWaves = 1,
		MaxWaves = 1,
		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,
		DepthDifficultyRamp = 0,
		ActiveEnemyCapBase = 1,
		ActiveEnemyCapMin = 1,
		ActiveEnemyCapMax = 2,
		ActiveEnemyCapDepthRamp = 0.0,

		WaveTemplate =
		{
			Spawns =
			{

			},
			OverrideValues = BaseWaveOverrideValues,
			StartDelay = 1.0
		},

		HardEncounterOverrideValues =
		{
			EnemySet = EnemySets.EnemiesBiome4MiniSingle
		},
	},

	Challenge =
	{
		EncounterType = "TimeChallenge",
		GroupReinforcements = false,
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		UnthreadedEvents = EncounterSets.EncounterEventsTimeChallenge,

		SpawnIntervalMin = 0.175,
		SpawnIntervalMax = 0.225,

		MinTypes = 2,
		MaxTypes = 3,
		MaxTypesCap = 3,
		TypeCountDepthRamp = 0,
		MinWaves = 1,
		MaxWaves = 1,

		ActiveEnemyCapBase = 8,
		ActiveEnemyCapMin = 8,
		ActiveEnemyCapMax = 8,

		LootDrops =
		{
			GiftDrop =
			{
				DropChance = 0.05,
				DropCount = 1,
			},
		},
		StartingValue = 100,
		MinValue = 10,
		ValueDepthRamp = 0.0,
		ValueDecayAmount = 1,
		LootDecayInterval = 1.0,
		DecayStartDelay = 9.0,

		SpawnRadius = 1000,
		DifficultyModifier = 0,
		DepthDifficultyRamp = 0,

		RequireCompletedIntro = true,
		IgnoreSpawnPreferences = true,
		PreSpawnMinPlayerDistance = 0,

		TimedSpawnsVictoryText = "TimedChallenge_Victory",
		TimedSpawnsFailureText = "TimedChallenge_Failure",

		Blacklist = { LightSpawner = true, LightSpawnerElite = true, SelfDestructSpawner = true },
	},

	TimeChallengeTartarus =
	{
		InheritFrom = { "Challenge", "GeneratedTartarus" },
		BaseDifficulty = 110,
	},

	TimeChallengeAsphodel =
	{
		InheritFrom = { "Challenge", "GeneratedAsphodel" },
		EnemySet = EnemySets.EnemiesBiome2Challenge,
		StartingValue = 100,
		BaseDifficulty = 210,
	},

	TimeChallengeElysium =
	{
		InheritFrom = { "Challenge", "GeneratedElysium" },
		EnemySet = EnemySets.EnemiesBiome3,
		StartingValue = 100,
		BaseDifficulty = 290,

		Blacklist = { FlurrySpawner = true, FlurrySpawnerElite = true },
	},

	TimeChallengeStyx =
	{
		InheritFrom = { "Challenge", "GeneratedStyx" },
		EnemySet = EnemySets.EnemiesBiome4,
		StartingValue = 100,
		BaseDifficulty = 1000,
	},

	BaseEscalalation =
	{
		InheritFrom = { "Generated", },
		EncounterType = "Escalation",
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		DifficultyModifier = 100,
		StartDelay = 1.5,
		BlockSpawnMultipliers = true,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 3,
		MaxTypes = 3,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,

		InfiniteSpawns = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "UnstableGenerator",
						TotalCount = 1,
						ForceFirst = true,
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 0.0,
			},

		},
		CancelSpawnsOnKill = { "UnstableGenerator" },
		SpawnThreadName = "EscalalationSpawnThread",

		-- StartGlobalVoiceLines = "C_MiniBossEncounterStartVoiceLines",
	},

	EscalationTartarus =
	{
		InheritFrom = { "BaseEscalalation", "GeneratedTartarus" },
	},

	EscalationAsphodel =
	{
		InheritFrom = { "BaseEscalalation", "GeneratedStyx" },

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "UnstableGenerator",
						TotalCount = 2,
						ForceFirst = true,
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 0.0,
			},

		},
		CancelSpawnsOnKill = { "UnstableGenerator" },
	},

	EscalationElysium =
	{
		InheritFrom = { "BaseEscalalation", "GeneratedElysium" },

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "UnstableGenerator",
						TotalCount = 3,
						ForceFirst = true,
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 0.0,
			},

		},
		CancelSpawnsOnKill = { "UnstableGenerator" },
	},

	EscalationStyx =
	{
		InheritFrom = { "BaseEscalalation", "GeneratedStyx" },

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "UnstableGenerator",
						TotalCount = 4,
						ForceFirst = true,
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 0.0,
			},

		},
		CancelSpawnsOnKill = { "UnstableGenerator" },
	},

	BaseDevotion =
	{
		DifficultyModifier = 0,
		DepthDifficultyRamp = 0,
		BaseDifficulty = 150,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		SpawnAggroed = true,
		RequireNearPlayerDistance = 750,
		IgnoreSpawnPreferences = true,
		SpawnIntervalMin = 1.0,
		SpawnIntervalMax = 2.0,
		ActiveEnemyCapBase = 8,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0,
		TypeCountDepthRamp = 0,
		MinTypes = 3,
		MaxTypes = 4,
		MaxTypesCap = 4,
		MinWaves = 1,
		MaxWaves = 1,
		MoneyDropCapMin = 30,
		MoneyDropCapMax = 30,
		MoneyDropCapDepthRamp = 0,

		SkipIntroEncounterCheck = true,

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "DisableRoomTraps" },
		},

		WaveTemplate =
		{
			Spawns =
			{

			},
			StartDelay = 1.0
		},
		PreUnthreadedEvents =
		{
			{ FunctionName = "StartDevotionTest" },
			{
				FunctionName = "CheckAssistHint",
				Args =
				{
					Delay = 10.0,
				}
			},
		},
		DistanceTriggers =
		{
			{
				TriggerObjectType = "LootPoint", WithinDistance = 700, GlobalVoiceLines = "DevotionChoicePresentedVoiceLines", FunctionName = "DevotionTestPresentation",
			},
			{
				TriggerGroup = "GroundEnemies", WithinDistance = 1000,
				VoiceLines =
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.33,
					RequireCurrentEncounterNotComplete = true,
					PreLineWait = 2.3,

					-- I angered her I guess.
					{ Cue = "/VO/ZagreusField_0169", RequiredRejectedGodGender = "Female" },
					-- I angered him I guess.
					{ Cue = "/VO/ZagreusField_0170", RequiredRejectedGodGender = "Male" },
					-- Looks like I angered her.
					{ Cue = "/VO/ZagreusField_0171", RequiredRejectedGodGender = "Female" },
					-- Looks like I angered him.
					{ Cue = "/VO/ZagreusField_0172", RequiredRejectedGodGender = "Male" },
					-- He's angry now.
					{ Cue = "/VO/ZagreusField_0411", RequiredRejectedGodGender = "Male" },
					-- She's angry now.
					{ Cue = "/VO/ZagreusField_0412", RequiredRejectedGodGender = "Female" },
					-- Now he's angry.
					{ Cue = "/VO/ZagreusField_0413", RequiredRejectedGodGender = "Male" },
					-- Now she's angry.
					{ Cue = "/VO/ZagreusField_0414", RequiredRejectedGodGender = "Female" },
					-- Guess he's upset.
					{ Cue = "/VO/ZagreusField_0415", RequiredRejectedGodGender = "Male" },
					-- Guess she's upset.
					{ Cue = "/VO/ZagreusField_0416", RequiredRejectedGodGender = "Female" },
					-- Here comes his wrath.
					{ Cue = "/VO/ZagreusField_4163", RequiredRejectedGodGender = "Male" },
					-- Here comes her wrath.
					{ Cue = "/VO/ZagreusField_4164", RequiredRejectedGodGender = "Female" },
					-- Let's give him a show.
					{ Cue = "/VO/ZagreusField_4165", RequiredRejectedGodGender = "Male" },
					-- Let's give her a show.
					{ Cue = "/VO/ZagreusField_4166", RequiredRejectedGodGender = "Female" },
					-- Let's give him a show, then.
					{ Cue = "/VO/ZagreusField_4167", RequiredRejectedGodGender = "Male" },
					-- Let's give her a show, then.
					{ Cue = "/VO/ZagreusField_4168", RequiredRejectedGodGender = "Female" },
					-- He can't stay mad forever.
					{ Cue = "/VO/ZagreusField_4169", RequiredRejectedGodGender = "Male" },
					-- She can't stay mad forever.
					{ Cue = "/VO/ZagreusField_4170", RequiredRejectedGodGender = "Female" },
					-- Time to win him over.
					{ Cue = "/VO/ZagreusField_4171", RequiredRejectedGodGender = "Male" },
					-- Time to win her over.
					{ Cue = "/VO/ZagreusField_4172", RequiredRejectedGodGender = "Female" },
				},
			},
		},
	},

	DevotionTestTartarus =
	{
		InheritFrom = { "BaseDevotion", "GeneratedTartarus" },
		EncounterType = "Devotion",
		DelayedStart = true,
		EnemySet = EnemySets.EnemiesBiome1Devotion,
		BaseDifficulty = 160,
	},

	DevotionTestAsphodel =
	{
		InheritFrom = { "BaseDevotion", "GeneratedAsphodel" },
		EncounterType = "Devotion",
		DelayedStart = true,
		EnemySet = EnemySets.EnemiesBiome2Devotion,
		BaseDifficulty = 430,
		MinTypes = 4,
		MaxTypes = 5,
		MaxTypesCap = 5,
		MinWaves = 2,
		MaxWaves = 2,
	},

	DevotionTestElysium =
	{
		InheritFrom = { "BaseDevotion", "GeneratedElysium" },
		EncounterType = "Devotion",
		DelayedStart = true,
		EnemySet = EnemySets.EnemiesBiome3Devotion,
		BaseDifficulty = 520,
		MinTypes = 4,
		MaxTypes = 5,
		MaxTypesCap = 5,
		MinWaves = 2,
		MaxWaves = 2,
	},

	BaseThanatos =
	{
		ObjectiveSets = "ThanatosChallenge",
		RequiredKillFunctionName = "TrackThanatosChallengeProgress",
		MaxTimeSincePlayerDamage = 5,
		MaxThanatosSpawnsThisRun = 1,
		RequiredMinCompletedRuns = 1,
		RequiredMinBiomeDepth = 3,

		ThanatosKills = 0,
		PlayerKills = 0,

		BlockFishingBeforeStart = true,
		BlockCodexBeforeStart = true,
		DelayedStart = true,
		SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		FastClearThreshold = 65,
		TimerBlock = "ThanatosEncounter",
		MinEliteTypes = 1,
		MaxEliteTypes = 1,
		BlockHighlightEliteTypes = true,

		MuteSecretMusicDrumsOnCombatOver = true,
		NextRoomResumeMusic = true,

		UnthreadedEvents = EncounterSets.EncounterEventsThanatos,
	},

	ThanatosTartarus =
	{
		InheritFrom = { "BaseThanatos", "GeneratedTartarus" },
		RequireAnyEncounterCompleted = { "ThanatosElysium", "ThanatosElysiumIntro", },
		BaseDifficulty = 200,
		MinTypes = 4,
		MaxTypes = 5,
		MaxTypesCap = 5,
		MinWaves = 3,
		MaxWaves = 3,
		EnemySet = EnemySets.EnemiesBiome1Thanatos,
		ActiveEnemyCapBase = 7,

		RequiredMinBiomeDepth = 9,

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 16,
		},
	},

	ThanatosAsphodel =
	{
		InheritFrom = { "BaseThanatos", "GeneratedAsphodel" },
		RequireAnyEncounterCompleted = { "ThanatosElysium", "ThanatosElysiumIntro", },
		BaseDifficulty = 400,
		MinTypes = 4,
		MaxTypes = 5,
		MaxTypesCap = 5,
		MinWaves = 3,
		MaxWaves = 3,
		EnemySet = EnemySets.EnemiesBiome2Thanatos,
		ActiveEnemyCapBase = 8,

		RequiredMinBiomeDepth = 2,

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 40,
		},
	},

	ThanatosElysium =
	{
		InheritFrom = { "BaseThanatos", "GeneratedElysium" },
		BaseDifficulty = 575,
		MinTypes = 4,
		MaxTypes = 5,
		MaxTypesCap = 5,
		MinWaves = 3,
		MaxWaves = 3,

		RequiredMinBiomeDepth = 3,

		-- run rollout prereqs
		RequiredFalseTextLinesThisRun = { "SisyphusFirstMeeting", "EurydiceFirstMeeting01_A", "EurydiceFirstMeeting01_B", "EurydiceFirstMeeting01_C", "PatroclusFirstMeeting" },
		RequiredAnyTextLines = { "Fury2FirstAppearance", "Fury3FirstAppearance" },

		Blacklist = { ChariotSuicide = true, ChariotSuicideElite = true },

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 110,
		},
	},
	ThanatosElysiumIntro =
	{
		InheritFrom = { "ThanatosElysium" },
		RequiredFalseTextLines = { "ThanatosFirstAppearance" },
	},

	BasePerfectClear =
	{
		EncounterType = "PerfectClear",
		RewardPreviewIcon = "RoomElitePreview3",
		RewardBoostedAnimation = "RoomRewardAvailableRareSparkles",

		MinRoomsBetweenType = 11,
		SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		BlockCodexBeforeStart = true,
		DelayedStart = true,
		PlayerTookDamage = false,
		UnthreadedEvents = EncounterSets.EncounterEventsPerfectClear,

		Spawns = {},
		DestroyEnemyInterval = 0.05,

		StartGlobalVoiceLines = "PerfectClearStartVoiceLines",
		EncounterResolvedGlobalVoiceLines = "PerfectClearCompleteVoiceLines",

		FastClearThreshold = 90,

		MinRoomsBetweenType = 0,
		MinTypes = 3,
		MaxTypes = 3,
		MaxTypesCap = 3,
		MinWaves = 1,
		MaxWaves = 1,
	},

	ShrineChallengeTartarus =
	{
		InheritFrom = { "BasePerfectClear", "GeneratedTartarus" },
		EnemySet = EnemySets.ShrineChallengeTartarus;
		RequiredBiome = "Tartarus",

		HardEncounterOverrideValues =
		{
		},

		BaseDifficulty = 60,
	},

	ShrineChallengeAsphodel =
	{
		InheritFrom = { "BasePerfectClear", "GeneratedAsphodel" },
		EnemySet = EnemySets.ShrineChallengeAsphodel;
		RequiredBiome = "Asphodel",

		HardEncounterOverrideValues =
		{
		},

		BaseDifficulty = 200,
	},

	ShrineChallengeElysium =
	{
		InheritFrom = { "BasePerfectClear", "GeneratedElysium" },
		EnemySet = EnemySets.ShrineChallengeElysium;
		RequiredBiome = "Elysium",

		HardEncounterOverrideValues =
		{
		},

		BaseDifficulty = 280,
	},

	BaseSurvival =
	{
		EncounterType = "SurvivalChallenge",
		HadesDeathTaunt = true,

		TimerBlock = "SurvivalEncounter",
		RequiredInactiveMetaUpgrade = "BiomeSpeedShrineUpgrade",
		MinRoomsBetweenType = 11,
		ActiveEnemyCapBase = 8,
		ActiveEnemyCapMax = 8,
		BlockFishingBeforeStart = true,
		SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,
		SkipLastKillPresentation = true,
		SpawnAggroed = true,
		RequireNearPlayerDistance = 750,
		MoneyDropCapMin = 60,
		MoneyDropCapMax = 60,
		MoneyDropCapDepthRamp = 0,
		FastClearThreshold = 60,
		RequiredMinCompletedRuns = 1,

		BlockCodexBeforeStart = true,
		DelayedStart = true,
		BlockTypesAcrossWaves = true,

		RequiredKills = {},
		UnthreadedEvents = EncounterSets.EncounterEventsSurvival,

		Spawns = {},
		Blacklist = { ThiefMineLayer = true, ThiefMineLayerElite = true, ThiefPoisonLayer = true },
		DestroyEnemyInterval = 0.05,

		TimerUnitName = "TimeCrystal",
		TimerUnitSpawnIntervalMin = 5.0,
		TimerUnitSpawnIntervalMax = 6.0,

		StartGlobalVoiceLines = "SurvivalStartVoiceLines",
		TimeExpiringGlobalVoiceLines = "SurvivalExpiringVoiceLines",
		EncounterResolvedGlobalVoiceLines = "SurvivalResolvedVoiceLines",
	},

	SurvivalTartarus =
	{
		InheritFrom = { "BaseSurvival", "GeneratedTartarus" },
		EnemySet = EnemySets.EnemiesBiome1Survival,
		RequiredMinBiomeDepth = 6,
		ActiveEnemyCapBase = 6,
		ActiveEnemyCapMax = 6,

		SpawnIntervalMin = 0.5,
		SpawnIntervalMax = 0.8,
		MinWaves = 2,
		MaxWaves = 3,
		MinTypes = 2,
		MaxTypes = 2,
		TypeCountDepthRamp = 0.0,

		TimeLimit = 45,
		AddAtTimeInterval = 12,
		InfiniteSpawns = true,

		SpawnWaves =
		{
		},

		ManualWaveTemplates =
		{
			{
				AddAtTime = 45,
				Spawns = {},
				RequireCompletedIntro = true,
			}
		},

		WaveTemplate =
		{
			AddAtTime = 45,
			MinTypes = 1,
			MaxTypes = 1,
			Spawns = {},
			RequireCompletedIntro = true,
		},
		SpawnThreadName = "SurvivalSpawnThread",
	},

	SurvivalAsphodel =
	{
		InheritFrom = { "BaseSurvival", "GeneratedAsphodel" },
		EnemySet = EnemySets.EnemiesBiome2Survival,

		RequiredMinBiomeDepth = 2,
		ActiveEnemyCapBase = 7,
		ActiveEnemyCapMax = 7,

		SpawnIntervalMin = 0.7,
		SpawnIntervalMax = 2.0,
		MinWaves = 2,
		MaxWaves = 3,
		MinTypes = 3,
		MaxTypes = 3,
		TypeCountDepthRamp = 0.0,

		TimeLimit = 55,
		AddAtTimeInterval = 15,
		InfiniteSpawns = true,

		SpawnWaves =
		{
		},

		ManualWaveTemplates =
		{
			{
				AddAtTime = 55,
				Spawns = {},
				RequireCompletedIntro = true,
			}
		},

		WaveTemplate =
		{
			AddAtTime = 55,
			MinTypes = 2,
			MaxTypes = 2,
			Spawns = {},
			RequireCompletedIntro = true,
		},
	},

	SurvivalElysium =
	{
		InheritFrom = { "BaseSurvival", "GeneratedElysium" },
		EnemySet = EnemySets.EnemiesBiome3Survival,

		RequiredMinBiomeDepth = 3,
		ActiveEnemyCapBase = 7,
		ActiveEnemyCapMax = 7,

		SpawnIntervalMin = 0.7,
		SpawnIntervalMax = 2.0,
		MinWaves = 2,
		MaxWaves = 3,
		MinTypes = 3,
		MaxTypes = 3,
		TypeCountDepthRamp = 0.0,

		TimeLimit = 55,
		AddAtTimeInterval = 15,
		InfiniteSpawns = true,

		SpawnWaves =
		{
		},

		ManualWaveTemplates =
		{
			{
				AddAtTime = 55,
				Spawns = {},
				RequireCompletedIntro = true,
			}
		},

		WaveTemplate =
		{
			AddAtTime = 55,
			MinTypes = 2,
			MaxTypes = 2,
			Spawns = {},
			RequireCompletedIntro = true,
		},
	},

	-- Intro Encounters
	BaseIntroEncounter =
	{
		RequiredFalseFlags = {"KioskMode"},

		SpawnIntervalMin = 0.0,
		SpawnIntervalMax = 0.0,

		Generated = true,
		PreSpawnEnemies = true,
		UnthreadedEvents = EncounterSets.EncounterEventsGenerated,
		MinWaves = 2,
		MaxWaves = 2,
		MinTypes = 2,
		MaxTypes = 2,
		MaxTypesCap = 2,

		EnemyCountDepthRamp = 0.0,
		ActiveEnemyCapBase = 2,
		ActiveEnemyCapDepthRamp = 0.0,
	},

	ThiefMineLayerIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedTartarus" },

		DistanceTriggers =
		{
			{
				Name = "ThiefMineLayerSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 600,
				VoiceLines = EnemyData.BaseThief.EnemyFirstEncounterVoiceLines
			}
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ThiefMineLayer",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "ThiefMineLayer",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	HeavyRangedIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedTartarus" },

		DistanceTriggers =
		{
			{
				Name = "HeavyRangedSightedVoiceLines",
				TriggerGroup = "FlyingEnemies", WithinDistance = 600,
				VoiceLines = EnemyData.BaseCrystal.EnemyFirstEncounterVoiceLines
			}
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "HeavyRanged",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "HeavyRanged",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	PunchingBagIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedTartarus" },

		DistanceTriggers =
		{
			{
				Name = "PunchingBagSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 600,
				VoiceLines = EnemyData.BaseGlutton.EnemyFirstEncounterVoiceLines
			},
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "PunchingBagUnit",
						CountMin = 3,
						CountMax = 3,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "PunchingBagUnit",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	LightSpawnerIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedTartarus" },

		DistanceTriggers =
		{
			{
				Name = "LightSpawnerSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 600,
				VoiceLines = EnemyData.BaseSpawner.EnemyFirstEncounterVoiceLines
			}
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "LightSpawner",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "LightSpawner",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	DisembodiedHandIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedTartarus" },
		RequiredSeenEncounter = "BossHarpy3",

		DistanceTriggers =
		{
			{
				Name = "DisembodiedHandSightedVoiceLines",
				TriggerGroup = "FlyingEnemies", WithinDistance = 600,
				VoiceLines = EnemyData.DisembodiedHand.EnemyFirstEncounterVoiceLines,
			}
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "DisembodiedHand",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "DisembodiedHand",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	SpreadShotIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedAsphodel" },
		MaxWaves = 3,

		DistanceTriggers =
		{
			{
				Name = "SpreadShotSightedVoiceLines",
				TriggerGroup = "FlyingEnemies", WithinDistance = 600,
				VoiceLines = EnemyData.SpreadShotUnit.EnemyFirstEncounterVoiceLines,
			}
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SpreadShotUnit",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] = {
				Spawns =
				{
					{
						Name = "SpreadShotUnit",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				PauseHazards = true,
			},

			-- 1 Wave left (second to last wave)
			[-1] =
			{
				Spawns =
				{
					{
						Name = "SpreadShotUnit",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				EnableRoomTraps = true,
			},

			-- 0 Waves left (last wave)
			[0] =
			{
				Spawns =
				{
					{
						Name = "SpreadShotUnit",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				UnpauseHazards = true,
			},
		},
	},

	ShieldRangedIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedAsphodel" },
		MaxWaves = 3,
		ActiveEnemyCapBase = 5,

		DistanceTriggers =
		{
			{
				Name = "ShieldRangedSightedVoiceLines",
				TriggerGroup = "FlyingEnemies", WithinDistance = 600,
				VoiceLines = EnemyData.ShieldRanged.EnemyFirstEncounterVoiceLines,
			}
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ShieldRanged",
						CountMin = 1,
						CountMax = 1,
					},
					{
						Name = "BloodlessNakedElite",
						CountMin = 4,
						CountMax = 4,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "ShieldRanged",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] = {
				Spawns =
				{
					{
						Name = "ShieldRanged",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				PauseHazards = true,
			},

			-- 1 Wave left (second to last wave)
			[-1] =
			{
				Spawns =
				{
					{
						Name = "ShieldRanged",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				EnableRoomTraps = true,
			},

			-- 0 Waves left (last wave)
			[0] =
			{
				Spawns =
				{
					{
						Name = "ShieldRanged",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				UnpauseHazards = true,
			},
		},
	},

	CrusherIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedAsphodel" },
		MaxWaves = 3,

		DistanceTriggers =
		{
			{
				Name = "CrusherUnitSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 500,
				VoiceLines = EnemyData.CrusherUnit.EnemyFirstEncounterVoiceLines,
			}
		},
		
		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "CrusherUnit",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "CrusherUnit",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] = {
				Spawns =
				{
					{
						Name = "CrusherUnit",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				PauseHazards = true,
			},

			-- 1 Wave left (second to last wave)
			[-1] =
			{
				Spawns =
				{
					{
						Name = "CrusherUnit",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				EnableRoomTraps = true,
			},

			-- 0 Waves left (last wave)
			[0] =
			{
				Spawns =
				{
					{
						Name = "CrusherUnit",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				UnpauseHazards = true,
			},
		},
	},

	FreezeShotIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedAsphodel" },
		MaxWaves = 3,
		ActiveEnemyCapBase = 4,

		DistanceTriggers =
		{
			{
				Name = "FreezeShotUnitSightedVoiceLines",
				TriggerGroup = "FlyingEnemies", WithinDistance = 600,
				VoiceLines = EnemyData.FreezeShotUnit.EnemyFirstEncounterVoiceLines,
			}
		},

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "FreezeShotUnit",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "BloodlessGrenadier",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "FreezeShotUnit",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] = {
				Spawns =
				{
					{
						Name = "FreezeShotUnit",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				PauseHazards = true,
			},

			-- 1 Wave left (second to last wave)
			[-1] =
			{
				Spawns =
				{
					{
						Name = "FreezeShotUnit",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				EnableRoomTraps = true,
			},

			-- 0 Waves left (last wave)
			[0] =
			{
				Spawns =
				{
					{
						Name = "FreezeShotUnit",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				UnpauseHazards = true,
			},
		},
	},

	RangedBurrowerIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedAsphodel" },
		MaxWaves = 3,
		RequireEncounterCompleted = "BossHydra",

		DistanceTriggers =
		{
			{
				Name = "RangedBurrowerSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 700,
				VoiceLines = EnemyData.RangedBurrower.EnemyFirstEncounterVoiceLines,
			}
		},

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "RangedBurrower",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "RangedBurrower",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] = {
				Spawns =
				{
					{
						Name = "RangedBurrower",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				PauseHazards = true,
			},

			-- 1 Wave left (second to last wave)
			[-1] =
			{
				Spawns =
				{
					{
						Name = "RangedBurrower",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				EnableRoomTraps = true,
			},

			-- 0 Waves left (last wave)
			[0] =
			{
				Spawns =
				{
					{
						Name = "RangedBurrower",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				UnpauseHazards = true,
			},
		},
	},

	BerserkerIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedAsphodel" },
		MaxWaves = 3,

		DistanceTriggers =
		{
			{
				Name = "BerserkerSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 600,
				VoiceLines = EnemyData.BloodlessNakedBerserker.EnemyFirstEncounterVoiceLines,
			}
		},

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "BloodlessNakedBerserker",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "BloodlessNakedBerserker",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] = {
				Spawns =
				{
					{
						Name = "BloodlessNakedBerserker",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				PauseHazards = true,
			},

			-- 1 Wave left (second to last wave)
			[-1] =
			{
				Spawns =
				{
					{
						Name = "BloodlessNakedBerserker",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				EnableRoomTraps = true,
			},

			-- 0 Waves left (last wave)
			[0] =
			{
				Spawns =
				{
					{
						Name = "BloodlessNakedBerserker",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				UnpauseHazards = true,
			},
		},
	},

	WaveFistIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedAsphodel" },
		MaxWaves = 3,

		DistanceTriggers =
		{
			{
				Name = "WaveFistSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 600,
				VoiceLines = EnemyData.BloodlessWaveFist.EnemyFirstEncounterVoiceLines,
			}
		},

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "BloodlessWaveFist",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "BloodlessWaveFist",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] = {
				Spawns =
				{
					{
						Name = "BloodlessWaveFist",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				PauseHazards = true,
			},

			-- 1 Wave left (second to last wave)
			[-1] =
			{
				Spawns =
				{
					{
						Name = "BloodlessWaveFist",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				EnableRoomTraps = true,
			},

			-- 0 Waves left (last wave)
			[0] =
			{
				Spawns =
				{
					{
						Name = "BloodlessWaveFist",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				UnpauseHazards = true,
			},
		},
	},

	PitcherIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedAsphodel" },
		MaxWaves = 3,

		DistanceTriggers =
		{
			{
				Name = "PitcherSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 700,
				VoiceLines = EnemyData.BloodlessPitcher.EnemyFirstEncounterVoiceLines,
			}
		},

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "BloodlessPitcher",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "BloodlessPitcher",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] = {
				Spawns =
				{
					{
						Name = "BloodlessPitcher",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				PauseHazards = true,
			},

			-- 1 Wave left (second to last wave)
			[-1] =
			{
				Spawns =
				{
					{
						Name = "BloodlessPitcher",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				EnableRoomTraps = true,
			},

			-- 0 Waves left (last wave)
			[0] =
			{
				Spawns =
				{
					{
						Name = "BloodlessPitcher",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				UnpauseHazards = true,
			},
		},
	},

	SelfDestructIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedAsphodel" },
		MaxWaves = 3,

		DistanceTriggers =
		{
			{
				Name = "SelfDestructSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 700,
				VoiceLines = EnemyData.BloodlessSelfDestruct.EnemyFirstEncounterVoiceLines,
			}
		},

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "BloodlessSelfDestruct",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "BloodlessSelfDestruct",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] = {
				Spawns =
				{
					{
						Name = "BloodlessSelfDestruct",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				PauseHazards = true,
			},

			-- 1 Wave left (second to last wave)
			[-1] =
			{
				Spawns =
				{
					{
						Name = "BloodlessSelfDestruct",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				EnableRoomTraps = true,
			},

			-- 0 Waves left (last wave)
			[0] =
			{
				Spawns =
				{
					{
						Name = "BloodlessSelfDestruct",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				UnpauseHazards = true,
			},
		},
	},

	ShadeSwordUnitIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedElysium" },

		DistanceTriggers =
		{
			{
				Name = "ShadeSwordUnitSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 700,
				VoiceLines = EnemyData.ShadeSwordUnit.EnemyFirstEncounterVoiceLines,
			}
		},

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ShadeSwordUnit",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "ShadeSwordUnit",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	ShadeSpearUnitIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedElysium" },

		DistanceTriggers =
		{
			{
				Name = "ShadeSpearUnitSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 700,
				VoiceLines = EnemyData.ShadeSpearUnit.EnemyFirstEncounterVoiceLines,
			}
		},

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ShadeSpearUnit",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "ShadeSpearUnit",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	ShadeShieldUnitIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedElysium" },

		DistanceTriggers =
		{
			{
				Name = "ShadeShieldUnitSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 700,
				VoiceLines = EnemyData.ShadeShieldUnit.EnemyFirstEncounterVoiceLines,
			}
		},

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ShadeShieldUnit",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "ShadeShieldUnit",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	ShadeBowUnitIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedElysium" },

		DistanceTriggers =
		{
			{
				Name = "ShadeBowUnitSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 700,
				VoiceLines = EnemyData.ShadeBowUnit.EnemyFirstEncounterVoiceLines,
			}
		},

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ShadeBowUnit",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "ShadeBowUnit",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	FlurrySpawnerUnitIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedElysium" },

		DistanceTriggers =
		{
			{
				Name = "FlurrySpawnerSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 700,
				VoiceLines = EnemyData.FlurrySpawner.EnemyFirstEncounterVoiceLines,
			}
		},

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "FlurrySpawner",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "FlurrySpawner",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	IllusionistIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedElysium" },

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Illusionist",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Illusionist",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	ChariotIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedElysium" },

		DistanceTriggers =
		{
			{
				Name = "ChariotSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 700,
				VoiceLines = EnemyData.Chariot.EnemyFirstEncounterVoiceLines,
			}
		},

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Chariot",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Chariot",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},

	ChariotSuicideIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedElysium" },

		DistanceTriggers =
		{
			{
				Name = "ChariotSuicideSightedVoiceLines",
				TriggerGroup = "GroundEnemies", WithinDistance = 700,
				VoiceLines = EnemyData.ChariotSuicide.EnemyFirstEncounterVoiceLines,
			}
		},

		Spawns = {},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ChariotSuicide",
						CountMin = 6,
						CountMax = 6,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "ChariotSuicide",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},
	},
	-- CUSTOM ENCOUNTERS
	-- murder boat
	WrappingAsphodel =
	{
		InheritFrom = { "GeneratedAsphodel", "MinibossEncounter" },
		GenusName = "WrappingAsphodel",
		RequiredInactiveMetaUpgrade = "MinibossCountShrineUpgrade",
		EnemySet = EnemySets.EnemiesBiome2Wrapping,
		MinRoomsBetweenType = 0,
		PreSpawnEnemies = false,
		SkipIntroEncounterCheck = true,
		BlockCodexBeforeStart = true,
		DelayedStart = true,

		DifficultyModifier = 60,
		MinWaves = 3,
		MaxWaves = 3,
		MinTypes = 3,
		MaxTypes = 5,
		ActiveEnemyCapMax = 6,

		BlockHighlightEncounter = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "ShieldRanged",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				PauseHazards = true,
				RequireCompletedIntro = true,
			},

			[2] =
			{
				Spawns =
				{
					{
						Name = "ShieldRanged",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				PauseHazards = true,
				RequireCompletedIntro = true,
			},

			-- 1 Wave left (second to last wave)
			[-1] =
			{
				Spawns =
				{
					{
						Name = "ShieldRanged",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				EnableRoomTraps = true,
				RequireCompletedIntro = true,
			},

			-- 0 Waves left (last wave)
			[0] =
			{
				Spawns =
				{
					{
						Name = "ShieldRanged",
						Generated = true
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 1.0,
				UnpauseHazards = true,
				RequireCompletedIntro = true,
			},
		},

		UnthreadedEvents = EncounterSets.EncounterEventsWrapping,
		WrappingData =
		{
			StartingGroupName = "WaterStartingObjects",
			EndingGroupName = "WaterEndingObjects",
			SpawnGroupName = "Terrain_Below",
			SpawnPointGroupName = "WaterSpawnPoints",
			ObstacleOptions =
			{
				{
					Name = "AsphodelLavaFire",
					SpawnScaleMin = 1.0,
					SpawnScaleMax = 1.0,
				},
				{
					Name = "AsphodelLavaSmoke",
					SpawnScaleMin = 1.0,
					SpawnScaleMax = 1.0,
				},
				{
					Name = "AsphodelTerrainRock01",
					SpawnScaleMin = 0.15,
					SpawnScaleMax = 0.25,
				},
				{
					Name = "AsphodelTerrainRock02",
					SpawnScaleMin = 0.15,
					SpawnScaleMax = 0.25,
				},
				{
					Name = "AsphodelTerrainRock03",
					SpawnScaleMin = 0.15,
					SpawnScaleMax = 0.25,
				},
			},
			LerpMovement = true,
			SpawnRate = 2,
			SpawnsPerBurstMin = 1,
			SpawnsPerBurstMax = 3,
			AllowFlip = true,

			ObstacleWrapData =
			{
				{
					Name = "Group1",
					Ids = { 512056, 511550, 511201, 511125, 511516, 511177, 548055, 511116, },
					FirstWrapDelay = 0.0,
					FirstRepeatDelay = 16,
					ResetOffsetDistance = -2800,
					FirstMoveTime = 8,
					MoveTime = 13,
					Destroy = false,
				},
				{
					Name = "Group2",
					Ids = { 512021, 512071, 511956, 510736, 511121, 512041, },
					FirstWrapDelay = 0.0,
					FirstRepeatDelay = 21,
					ResetOffsetDistance = -400,
					MoveTime = 13,
					Destroy = false,
				},
				{
					Name = "Group3",
					Ids = { 511991, 511962, 511978, 514025, 511972, 512006, 511054, 514010, 514029, },
					FirstWrapDelay = 3,
					FirstRepeatDelay = 21,
					ResetOffsetDistance = 800,
					FirstTeleport = true,
					MoveTime = 16,
					Destroy = false,
				},
				{
					Name = "Group4",
					Ids = { 514056, 514060, 514068, 514064, 514127, 514142, },
					FirstWrapDelay = 9,
					FirstRepeatDelay = 21,
					ResetOffsetDistance = 4000,
					FirstTeleport = true,
					MoveTime = 13,
					Destroy = false,
				},
			},
		},
	},

	WrappingAsphodel2 =
	{
		InheritFrom = { "WrappingAsphodel" },
		GenusName = "WrappingAsphodel",
		RequiredInactiveMetaUpgrade = "nil",
		RequiredActiveMetaUpgrade = "MinibossCountShrineUpgrade",

		DifficultyModifier = 250,
		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 3,
		MaxTypes = 5,
		MaxEliteTypes = 5,

		ActiveEnemyCapBase = 6,
		ActiveEnemyCapMax = 6,
		SpawnIntervalMin = 1.5,
		SpawnIntervalMax = 2.5,

		BlockHighlightEncounter = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "ShieldRangedMiniBoss",
						TotalCount = 1,
						SpawnOnIds = { 514164 },
						ForceFirst = true,
					},
				},
				StartDelay = 0.5,
				TypeCount = 4,
			},
		},
		CancelSpawnsOnKill = { "ShieldRangedMiniBoss" },
		SpawnThreadName = "ShieldRangedMiniBossSpawnThread",
	},

	OpeningEmpty =
	{
		InheritFrom = { "NonCombat" },
		AlwaysForce = true,
		RequiredFalseTextLines = { "AthenaFirstPickUp" },

		UnthreadedEvents =
		{
			{ FunctionName = "EncounterAudio" },
			{ FunctionName = "PostCombatAudio" },
		}
	},

	OpeningGenerated =
	{
		InheritFrom = { "GeneratedTartarus" },
		RequireCompletedIntro = true,
		RequiredTextLines = { "AthenaFirstPickUp" },
		GroupReinforcements = false,
		MaxWaves = 1,
		DifficultyModifier = -30,

		UnthreadedEvents =
		{
			{ FunctionName = "EncounterAudio" },
			{ FunctionName = "HandleEnemySpawns" },
			{ FunctionName = "CheckForAllEnemiesDead" },
			{ FunctionName = "PostCombatAudio" },
		}
	},

	BaseOnslaught =
	{
		UnthreadedEvents = EncounterSets.EncounterEventsOnslaught,
		PreSpawnEnemies = false,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMax = 10,
		SpawnIntervalMin = 0.175,
		SpawnIntervalMax = 0.225,
		WaveStartPresentationFunction = "StartWavePresentation",
		Music = "/Music/MusicExploration1_MC",

		StartVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.0,

			-- What now.
			{ Cue = "/VO/ZagreusField_0316" },
		},

		EncounterResolvedGlobalVoiceLines = "OnslaughtCompleteVoiceLines",
	},

	EnemyIntroFight01 =
	{
		AlwaysForce = true,
		RequiredFalseTextLines = { "AthenaFirstPickUp" },
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { LegalTypes = { "SpikeTrap" }, } },
		},
		PreSpawnEnemies = true,

		SpawnWaves =
        {
            {
                Spawns =
                {
					{
						Name = "SimpleMelee",
						CountMin = 1,
						CountMax = 1,
						SpawnOnId = 487926,
					},
                },
				StartDelay = 0,
				OverrideValues =
				{
					SpawnIntervalMin = 0.175,
					SpawnIntervalMax = 0.225,
				},
            },

			-- wave 2
			{
                Spawns =
                {
					{
						Name = "HeavyMelee",
						CountMin = 2,
						CountMax = 2,
						SpawnOnIds = { 430031, 430030, },
					},
                },
                StartDelay = 1,
				OverrideValues =
				{
					SpawnIntervalMin = 0.175,
					SpawnIntervalMax = 0.225,
				},
            },

			-- wave 3
			{
                Spawns =
                {
					{
						Name = "LightRanged",
						CountMin = 3,
						CountMax = 3,
						SpawnOnIds = { 430033, 430034, 430032, },
					},
                },
                StartDelay = 1,
				OverrideValues =
				{
					SpawnIntervalMin = 1.5,
					SpawnIntervalMax = 1.5,
				},
            },

			-- wave 4
			{
                Spawns =
                {
					{
						Name = "HeavyMelee",
						CountMin = 1,
						CountMax = 1,
						SpawnOnId = 430003,
					},

					{
						Name = "LightRanged",
						CountMin = 3,
						CountMax = 3,
						SpawnOnIds = { 430033, 430034, 430032, },
					},
                },
                StartDelay = 1.0,
				OverrideValues =
				{
					SpawnIntervalMin = 0.3,
					SpawnIntervalMax = 0.3,
				},
            },
        },
	},

	TestFight =
	{
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0 } },
		},

		SpawnIntervalMin = 0.1,
		SpawnIntervalMax = 0.25,
		ActiveEnemyCapBase = 1,
		RequiredKills = {},

		Spawns =
		{
			{
				Name = "TimeCrystal",
				TotalCount = 9999,
			},
		},
	},

	TestDexterFight =
	{
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0 } },
		},

		SpawnIntervalMin = 3.0,
		SpawnIntervalMax = 3.0,
		ActiveEnemyCapBase = 3,
		RequiredKills = {},

		Spawns =
		{
			{
				Name = "ShadeSwordUnitTest",
				TotalCount = 6,
			},
		},
	},

	TuningFight =
	{
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0 } },
		},

		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.05,
		ActiveEnemyCapBase = 10,
		RequiredKills = {},

		Spawns =
		{
			{
				Name = "DisembodiedHand",
				TotalCount = 1,
				ForceFirst = true,
			},
		},
	},

	FL_Fight01 =
	{
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0 } },
		},

		SpawnIntervalMin = 0.1,
		SpawnIntervalMax = 0.1,
		ActiveEnemyCapBase = 10,
		RequiredKills = {},

		SpawnWaves =
        {
            {
			-- first wave
                Spawns =
                {
					{
						Name = "Swarmer",
						CountMin = 0,
						CountMax = 0,
					},
					{
						Name = "LightRanged",
						CountMin = 3,
						CountMax = 3,
					},
					{
						Name = "HeavyMelee",
						CountMin = 0,
						CountMax = 0,
					},
					{
						Name = "LightSpawner",
						CountMin = 0,
						CountMax = 0,
					},
                },
				StartDelay = 1,
				OverrideValues =
				{
					SpawnIntervalMin = 0.5,
					SpawnIntervalMax = 0.5,
				},
            },


			-- second wave
			{
                Spawns =
                {
					{
						Name = "Swarmer",
						CountMin = 3,
						CountMax = 3,
					},
					{
						Name = "LightRanged",
						CountMin = 0,
						CountMax = 0,
					},
					{
						Name = "HeavyMelee",
						CountMin = 0,
						CountMax = 0,
					},
					{
						Name = "LightSpawner",
						CountMin = 0,
						CountMax = 0,
					},
                },
                StartDelay = 0
            },

			-- third wave
			{
                Spawns =
                {
                    Swarmer =
					{
						Name = "Swarmer",
						CountMin = 0,
						CountMax = 0,
					},
					LightRanged =
					{
						Name = "LightRanged",
						CountMin = 3,
						CountMax = 3,
					},
					HeavyMelee =
					{
						Name = "HeavyMelee",
						CountMin = 2,
						CountMax = 2,
					},
					LightSpawner =
					{
						Name = "LightSpawner",
						CountMin = 0,
						CountMax = 0,
					},
                },
                StartDelay = 0,
				OverrideValues =
				{
					SpawnIntervalMin = 0.1,
					SpawnIntervalMax = 0.1,
				},
            },
        },
	},

	FL_Fight02 =
	{
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0 } },
		},

		SpawnIntervalMin = 0.1,
		SpawnIntervalMax = 0.1,
		ActiveEnemyCapBase = 10,
		RequiredKills = {},

		SpawnWaves =
        {
			-- first wave
			{
				Spawns =
				{
					{
						Name = "Swarmer",
						CountMin = 0,
						CountMax = 0,
					},
					{
						Name = "LightRanged",
						CountMin = 3,
						CountMax = 3,
					},
					{
						Name = "HeavyMelee",
						CountMin = 0,
						CountMax = 0,
					},
					{
						Name = "LightSpawner",
						CountMin = 1,
						CountMax = 1,
					},
				},
			},

			-- second wave
            {
                Spawns =
                {
					{
						Name = "Swarmer",
						CountMin = 0,
						CountMax = 0,
					},
					{
						Name = "LightRanged",
						CountMin = 0,
						CountMax = 0,
					},
					{
						Name = "HeavyMelee",
						CountMin = 0,
						CountMax = 0,
					},
					{
						Name = "LightSpawner",
						CountMin = 3,
						CountMax = 3,
					},
                },
				StartDelay = 1,
				OverrideValues = {
					SpawnIntervalMin = 0.5,
					SpawnIntervalMax = 0.5,
				},
            },
		},
	},

	FL_Fight03 =
	{
		SpawnIntervalMin = 0.1,
		SpawnIntervalMax = 0.1,
		ActiveEnemyCapBase = 10,
		RequiredKills = {},

		SpawnWaves =
        {
			-- first wave
			{
				Spawns =
				{
					{
						Name = "Swarmer",
						CountMin = 4,
						CountMax = 4,
					},
					{
						Name = "LightRanged",
						CountMin = 0,
						CountMax = 0,
					},
					{
						Name = "HeavyMelee",
						CountMin = 0,
						CountMax = 0,
					},
					{
						Name = "LightSpawner",
						CountMin = 0,
						CountMax = 0,
					},
				},
			},

			-- second wave
			{
				Spawns =
				{
					{
						Name = "Swarmer",
						CountMin = 0,
						CountMax = 0,
					},
					{
						Name = "LightRanged",
						CountMin = 2,
						CountMax = 2,
					},
					{
						Name = "HeavyMelee",
						CountMin = 1,
						CountMax = 1,
					},
					{
						Name = "LightSpawner",
						CountMin = 0,
						CountMax = 0,
					},
				},
			},
		},
	},

	MorganFight =
	{
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 0.7, FractionMax = 1.0, LegalTypes = { "SpikeTrap", "DartTrap", "DartTrapEmitter", "BlastCube", "GasTrapPassive" }, } },
		},

		EnemyCountDepthRamp = 0.2,
		SpawnIntervalMin = 0.5,
		SpawnIntervalMax = 0.2,
		EnemyCountDepthRamp = .2,
		EnemyCountRunRamp = .2,
		ActiveEnemyCapBase = 14,

		Spawns =
		{
			{
				Name = "HeavyRanged",
				CountMin = 3,
				CountMax = 6,
			},

			{
				Name = "HeavyMelee",
				CountMin = 3,
				CountMax = 6,
			},

			{
				Name = "Swarmer",
				CountMin = 5,
				CountMax = 10,
			},
		},
	},

	BossHarpy1 =
	{
		InheritFrom = { "BossEncounter" },
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Harpy" }, IgnoreAI = true, SkipPresentation = true, PreLoadBinks = true } },
			{
				FunctionName = "MultiFuryActivations",
				Args =
				{
					BossId = 50002,
					ObstacleIds = { Alecto = 510510, Tisiphone = 510511 }
				}
			},
		},
		SpawnIntervalMin = 5,
		SpawnIntervalMax = 7,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 4,
		ActiveEnemyCapMax = 7,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		SkipLastKillPresentation = true,
		SkipIntroEncounterCheck = true,
		MoneyDropCapMin = 20,
		MoneyDropCapMax = 20,
		MoneyDropCapDepthRamp = 0,
		FastClearThreshold = 55,

		WipeEnemiesOnKill = "Harpy",

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "LightRanged",
						InfiniteSpawns = true,
					},
					{
						Name = "HeavyMelee",
						InfiniteSpawns = true,
					},
				},
				StartDelay = 15
			},
		},

		CancelSpawnsOnKill = { "Harpy" },
		SpawnThreadName = "Harpy1SpawnThread",

		PostUnthreadedEvents =
		{
			{
				FunctionName = "GiveRandomConsumablesSource",
				Args =
				{
					Delay = 0.5,
					NotRequiredPickup = true,
					LootOptions =
					{
						{
							Name = "GemDrop",
							SpawnSound = "/SFX/GemDropSFX",
							MinAmount = 1,
							MaxAmount = 1,
							Overrides =
							{
								AddResources =
								{
									Gems = 10,
								},
							}
						},
					},
				},
				GameStateRequirements =
				{
					RequiredCosmetics = { "BossAddGems" },
				},
			},
		},
	},

	BossHarpy2 =
	{
		InheritFrom = { "BossHarpy1" },
		SpawnIntervalMin = 18,
		SpawnIntervalMax = 23,
		FastClearThreshold = 55,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Harpy2" }, IgnoreAI = true, SkipPresentation = true, PreLoadBinks = true } },
			{
				FunctionName = "MultiFuryActivations",
				Args =
				{
					BossId = 510595,
					ObstacleIds = { Megaera = 520857, Tisiphone = 520858 }
				}
			},
		},

		ActiveEnemyCapBase = 2,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "PunchingBagUnit",
						InfiniteSpawns = true,
					},
				},
				StartDelay = 25
			},
		},

		CancelSpawnsOnKill = { "Harpy2" },
		WipeEnemiesOnKill = "Harpy2",
		SpawnThreadName = "Harpy2Spawns",
	},

	BossHarpy3 =
	{
		InheritFrom = { "BossHarpy1" },
		FastClearThreshold = 55,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Harpy3" }, IgnoreAI = true, SkipPresentation = true, PreLoadBinks = true } },
			{
				FunctionName = "MultiFuryActivations",
				Args =
				{
					BossId = 510595,
					ObstacleIds = { Megaera = 520855, Alecto = 520856 }
				}
			},
		},

		SpawnWaves =
		{
		},

		CancelSpawnsOnKill = { "Harpy3" },
	},

	BossHarpyTriumvirate =
	{
		InheritFrom = { "BossEncounter" },
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Harpy", "Harpy2", "Harpy3" }, IgnoreAI = true, SkipPresentation = true, PreLoadBinks = true } },
		},
		HoldKillPresentationForUnitDeaths = {"Harpy", "Harpy2", "Harpy3"},
		SpawnIntervalMin = 5,
		SpawnIntervalMax = 7,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 3,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		SkipLastKillPresentation = true,
		SkipIntroEncounterCheck = true,
		MoneyDropCapMin = 20,
		MoneyDropCapMax = 20,
		MoneyDropCapDepthRamp = 0,
		FastClearThreshold = 50,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "LightRanged",
						TotalCount = 0,
					},
					{
						Name = "HeavyMelee",
						TotalCount = 0,
					},
				},
				StartDelay = 15
			},
		},

		CancelSpawnsOnKill = { "Harpy", "Harpy2", "Harpy3" },

		PostUnthreadedEvents =
		{
			{
				FunctionName = "GiveRandomConsumablesSource",
				Args =
				{
					Delay = 0.5,
					NotRequiredPickup = true,
					LootOptions =
					{
						{
							Name = "GemDrop",
							MinAmount = 1,
							MaxAmount = 1,
							Overrides =
							{
								AddResources =
								{
									Gems = 10,
								},
							}
						},
					},
				},
				GameStateRequirements =
				{
					RequiredCosmetics = { "BossAddGems" },
				},
			},
		},
	},

	BossHydra =
	{
		InheritFrom = { "BossEncounter" },
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "PickHydraVariant", Args = { MaxSideHeadTypes = 2, Options = { "HydraHeadImmortal", "HydraHeadImmortalLavamaker", "HydraHeadImmortalSummoner", "HydraHeadImmortalSlammer", "HydraHeadImmortalWavemaker", } } },
			{ FunctionName = "ActivateHydra", Args = { FractionMin = 1.0, FractionMax = 1.0, IgnoreAI = true, SkipPresentation = true, PreLoadBinks = true, } },
			{ FunctionName = "DisableRoomTraps" },
		},
		CancelSpawnsOnKill = { "HydraHeadImmortal" },
		WipeEnemiesOnKill = "HydraHeadImmortal",
		SpawnHazards = true,

		HydraHeads = {},

		BlockHeadsByHydraVariant =
		{
			HydraHeadImmortal = { "HydraHeadDartmaker" },
			HydraHeadImmortalLavamaker = { "HydraHeadLavamaker" },
			HydraHeadImmortalSummoner = { "HydraHeadSummoner" },
			HydraHeadImmortalSlammer = { "HydraHeadSlammer" },
			HydraHeadImmortalWavemaker = { "HydraHeadWavemaker" },
		},

		BlockSpawnMultipliers = true,
		SpawnIntervalMin = 0.5,
		SpawnIntervalMax = 0.5,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 10,
		EndMusicOnCombatOver = 20,
		FastClearThreshold = 100,

		Spawns = {},
		SpawnThreadName = "BossHydraSpawns",

		PostUnthreadedEvents =
		{
			{
				FunctionName = "GiveRandomConsumablesSource",
				Args =
				{
					Delay = 0.5,
					NotRequiredPickup = true,
					DestinationId = 40128,
					LootOptions =
					{
						{
							Name = "GemDrop",
							MinAmount = 1,
							MaxAmount = 1,
							Overrides =
							{
								AddResources =
								{
									Gems = 20,
								},
							}
						},
					},
				},
				GameStateRequirements =
				{
					RequiredCosmetics = { "BossAddGems" },
				},
			},
		},
	},

	BossHades =
	{
		InheritFrom = { "BossEncounter" },
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Hades" }, IgnoreAI = true, SkipPresentation = true, PreLoadBinks = true } },
		},
		WipeEnemiesOnKill = "Hades",
		SpawnIntervalMin = 5,
		SpawnIntervalMax = 7,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 5,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		SkipLastKillPresentation = true,
		SkipIntroEncounterCheck = true,
		MoneyDropCapMin = 0,
		MoneyDropCapMax = 0,
		MoneyDropCapDepthRamp = 0,
		FastClearThreshold = 150,
		BlockCodexBeforeStart = true,
		DelayedStart = true,
		SpawnWaves =
		{
		},

		CancelSpawnsOnKill = { "Hades" },
		SpawnThreadName = "HadesSpawns",

		PostUnthreadedEvents =
		{
			{
				FunctionName = "GiveRandomConsumablesSource",
				Args =
				{
					Delay = 0.5,
					NotRequiredPickup = true,
					DestinationId = 553271,
					LootOptions =
					{
						{
							Name = "GemDrop",
							MinAmount = 1,
							MaxAmount = 1,
							Overrides =
							{
								AddResources =
								{
									Gems = 50,
								},
							}
						},
					},
				},
				GameStateRequirements =
				{
					RequiredCosmetics = { "BossAddGems" },
				},
			},
		},
	},

	BossHadesPeaceful =
	{
		InheritFrom = { "BossEncounter", "NonCombat" },
		EncounterType = "NonCombat",
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Hades_Story_02" }, IgnoreAI = true, SkipPresentation = true, PreLoadBinks = true } },
		},

		PostUnthreadedEvents =
		{
			{
				FunctionName = "RecordRunCleared",
			},
			{
				FunctionName = "GiveRandomConsumablesSource",
				Args =
				{
					Delay = 0.5,
					NotRequiredPickup = true,
					LootOptions =
					{
						{
							Name = "GemDrop",
							MinAmount = 1,
							MaxAmount = 1,
							Overrides =
							{
								AddResources =
								{
									Gems = 50,
								},
							}
						},
					},
				},
				GameStateRequirements =
				{
					RequiredCosmetics = { "BossAddGems" },
				},
			},
		},

		RequiredTextLines = { "PersephoneMeeting09" },
		RequiredFalseTextLines = { "PersephoneReturnsHome01" },
		AlwaysForce = true,
	},

	BossCharon =
	{
		InheritFrom = { "BossEncounter" },
		EncounterType = "OptionalBoss",
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Charon" }, IgnoreAI = true, SpawnOverrides = { CannotDieFromDamage = true }, SkipPresentation = true, PreLoadBinks = true } },
		},
		SpawnIntervalMin = 5,
		SpawnIntervalMax = 7,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 4,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		SkipLastKillPresentation = true,
		SkipIntroEncounterCheck = true,
		MoneyDropCapMin = 20,
		MoneyDropCapMax = 20,
		MoneyDropCapDepthRamp = 0,
		FastClearThreshold = 55,
		BlockCodexBeforeStart = true,
		DelayedStart = true,
		UnthreadedEvents = EncounterSets.EncounterEventsCharonFight,

		SpawnWaves =
		{
		},

		CancelSpawnsOnKill = { "Charon" },
		SpawnThreadName = "CharonSpawnThread",
		WipeEnemiesOnKill = "Charon",
	},

	BossTheseusAndMinotaur =
	{
		InheritFrom = { "BossEncounter" },
		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "ActivatePrePlacedByShrineLevel",
				Args =
				{
					[0] = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Theseus", "Minotaur" }, IgnoreAI = true, SkipPresentation = true, PreLoadBinks = true },
					[1] = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Theseus", "Minotaur" }, IgnoreAI = true, SkipPresentation = true, PreLoadBinks = true },
					[2] = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Theseus", "Minotaur" }, IgnoreAI = true, SkipPresentation = true, PreLoadBinks = true },
					[3] = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Theseus2", "Minotaur2" }, IgnoreAI = true, SkipPresentation = true, PreLoadBinks = true },
					[4] = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Theseus2", "Minotaur2" }, IgnoreAI = true, SkipPresentation = true, PreLoadBinks = true },
				},
			},
			--{ FunctionName = "AngleIdsTowardPlayer", Args = { Ids = { 481705, 481706, 543036, 543035 } } }
		},
		ShrineMetaUpgradeName = "BossDifficultyShrineUpgrade",

		SpawnIntervalMin = 5,
		SpawnIntervalMax = 7,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 2,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		CheckComboPartnerForKillPresentation = true,
		SkipLastKillPresentation = true,
		SkipIntroEncounterCheck = true,
		MoneyDropCapMin = 20,
		MoneyDropCapMax = 20,
		MoneyDropCapDepthRamp = 0,
		FastClearThreshold = 90,

		SpawnWaves =
		{
		},

		CancelSpawnsOnKill = { "Theseus", "Minotaur" },
		SpawnThreadName = "TheseusMinotaurSpawns",

		PostUnthreadedEvents =
		{
			{
				FunctionName = "GiveRandomConsumablesSource",
				Args =
				{
					Delay = 0.5,
					NotRequiredPickup = true,
					LootOptions =
					{
						{
							Name = "GemDrop",
							MinAmount = 1,
							MaxAmount = 1,
							Overrides =
							{
								AddResources =
								{
									Gems = 30,
								},
							}
						},
					},
				},
				GameStateRequirements =
				{
					RequiredCosmetics = { "BossAddGems" },
				},
			},
		},
	},

	MiniBossMinotaur =
	{
		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "ActivatePrePlacedByShrineLevel",
				Args =
				{
					[0] = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Minotaur" }, IgnoreAI = true, SpawnOverrides = { CannotDieFromDamage = true }, SkipPresentation = true, PreLoadBinks = true },
					[1] = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Minotaur" }, IgnoreAI = true, SpawnOverrides = { CannotDieFromDamage = true }, SkipPresentation = true, PreLoadBinks = true },
					[2] = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Minotaur" }, IgnoreAI = true, SpawnOverrides = { CannotDieFromDamage = true }, SkipPresentation = true, PreLoadBinks = true },
					[3] = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Minotaur2" }, IgnoreAI = true, SpawnOverrides = { CannotDieFromDamage = true }, SkipPresentation = true, PreLoadBinks = true },
					[4] = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Minotaur2" }, IgnoreAI = true, SpawnOverrides = { CannotDieFromDamage = true }, SkipPresentation = true, PreLoadBinks = true },
				},
			},
			{ FunctionName = "AngleIdsTowardPlayer", Args = { Ids = { 522244, 543191 } } }
		},
		ShrineMetaUpgradeName = "BossDifficultyShrineUpgrade",

		SpawnIntervalMin = 9.0,
		SpawnIntervalMax = 11.0,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 4,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		MoneyDropCapMin = 25,
		MoneyDropCapMax = 25,
		MoneyDropCapDepthRamp = 0,
		FastClearThreshold = 75,
		SkipIntroEncounterCheck = true,
		SkipLastKillPresentation = true,

		SpawnWaves =
		{
		},
	},

	MiniBossWretchAssassin =
	{
		InheritFrom = { "GeneratedTartarus", "MinibossEncounter" },
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		EnemySet = EnemySets.EnemiesBiome1MiniBoss,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		MaxEliteTypes = 2,

		SpawnIntervalMin = 4.0,
		SpawnIntervalMax = 7.0,
		StartDelay = 2,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 2,
		ActiveEnemyCapMax = 4,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "WretchAssassinMiniboss",
						TotalCount = 1,
						SpawnOnIds = { 490898 },
						ForceFirst = true,
					},
					{
						Name = "DisembodiedHand",
						InfiniteSpawns = true,
						RequiredMetaUpgrade = "MinibossCountShrineUpgrade",
					},
				},
				StartDelay = 0.5,
			},
		},

		WipeEnemiesOnKill = "WretchAssassinMiniboss",
		CancelSpawnsOnKill = { "WretchAssassinMiniboss" },
		SpawnThreadName = "WretchAssassinMinibossSpawnThread",
		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
	},

	MiniBossSwarmerHelemted =
	{
		InheritFrom = { "GeneratedTartarus", "MinibossEncounter" },
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		EnemySet = EnemySets.EnemiesBiome1MiniBoss,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		MaxEliteTypes = 2,

		SpawnIntervalMin = 4.0,
		SpawnIntervalMax = 6.0,
		StartDelay = 2,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 10,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "SwarmerHelmeted",
						TotalCount = 5,
						SpawnOnIds = { 481547, 481543, 481550, },
					},
				},
				StartDelay = 0.5,
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
	},

	MiniBossHeavyRangedSplitter =
	{
		InheritFrom = { "GeneratedTartarus", "MinibossEncounter" },
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		MaxEliteTypes = 2,

		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.1,
		StartDelay = 2,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 10,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "HeavyRangedSplitterMiniboss",
						TotalCount = 1,
						SpawnOnIds = { 490981 },
					},
				},
				StartDelay = 0.5,
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
	},

	MiniBossHeavyRangedSplitter2 =
	{
		InheritFrom = { "MiniBossHeavyRangedSplitter" },
		GenusName = "MiniBossHeavyRangedSplitter",


		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "HeavyRangedSplitterMiniboss",
						TotalCount = 1,
						SpawnOnIds = { 523997, },
					},
				},
				StartDelay = 0.5,
			},
		},
	},

	MiniBossGrenadier =
	{
		InheritFrom = { "GeneratedTartarus", "MinibossEncounter" },
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		EnemySet = EnemySets.EnemiesBiome1MiniBoss,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		MaxEliteTypes = 2,

		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.1,
		StartDelay = 2,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 10,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,

		ForceIfEncounterNotCompleted = "MiniBossGrenadier",

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "BloodlessGrenadierElite",
						TotalCount = 2,
						SpawnOnIds = { 410104, 410155, },
					},
					{
						TotalCount = 2,
						Generated = true,
						RequiredMetaUpgrade = "MinibossCountShrineUpgrade",
					},
				},
				StartDelay = 0.5,
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
	},

	MiniBossSelfDestruct =
	{
		InheritFrom = { "GeneratedTartarus", "MinibossEncounter" },
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		EnemySet = EnemySets.EnemiesBiome1MiniBoss,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		MaxEliteTypes = 2,

		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.1,
		StartDelay = 2,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 10,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "BloodlessSelfDestructElite",
						TotalCount = 2,
					},
					{
						TotalCount = 2,
						Generated = true,
						RequiredMetaUpgrade = "MinibossCountShrineUpgrade",
					},
				},
				StartDelay = 0.5,
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
	},

	MiniBossPitcher =
	{
		InheritFrom = { "GeneratedTartarus", "MinibossEncounter" },
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		EnemySet = EnemySets.EnemiesBiome1MiniBoss,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		MaxEliteTypes = 2,

		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.1,
		StartDelay = 2,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 10,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "BloodlessPitcherElite",
						TotalCount = 2,
					},
					{
						TotalCount = 2,
						Generated = true,
						RequiredMetaUpgrade = "MinibossCountShrineUpgrade",
					},
				},
				StartDelay = 0.5,
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
	},

	MiniBossWaveFist =
	{
		InheritFrom = { "GeneratedTartarus", "MinibossEncounter" },
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		EnemySet = EnemySets.EnemiesBiome1MiniBoss,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		MaxEliteTypes = 2,

		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.1,
		StartDelay = 2,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 10,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "BloodlessWaveFistElite",
						TotalCount = 2,
					},
					{
						TotalCount = 2,
						Generated = true,
						RequiredMetaUpgrade = "MinibossCountShrineUpgrade",
					},
				},
				StartDelay = 0.5,
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
	},

	MiniBossHitAndRun =
	{
		InheritFrom = { "MinibossEncounter" },
		EnemyCountShrineModifierName = "MinibossCountShrineUpgrade",
		EnemyCountShineModifierAmount = 0,
		StartDelay = 0,
		SpawnAggroed = true,
		SpawnIntervalMin = 2,
		SpawnIntervalMax = 2,

		ActiveEnemyCapBase = 10,
		EnemyCountDepthRamp = 0,

		EndMusicOnCombatOver = 20,

		SkipIntroEncounterCheck = true,
		PreSpawnEnemies = false,
		SpawnHazards = true,
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "HitAndRunUnitElite",
						TotalCount = 1,
						ForceFirst = true,
						SpawnOnIds = { 410155 },
					},
					{
						Name = "CrusherUnitElite",
						TotalCount = 1,
					},
				},
			},
		},

		StartGlobalVoiceLines = "B_MiniBossEncounterStartVoiceLines",
	},

	MiniBossSpreadShot =
	{
		InheritFrom = { "MinibossEncounter" },
		EnemyCountShrineModifierName = "MinibossCountShrineUpgrade",
		EnemyCountShineModifierAmount = 0,
		ShrineMetaUpgradeName = "MinibossCountShrineUpgrade",
		StartDelay = 0,
		SpawnAggroed = true,
		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.05,

		ActiveEnemyCapBase = 10,
		EnemyCountDepthRamp = 0,

		EndMusicOnCombatOver = 20,

		SkipIntroEncounterCheck = true,
		PreSpawnEnemies = false,
		SpawnHazards = true,
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SpreadShotUnitMiniboss",
						TotalCount = 4,
						ForceFirst = true,
						SpawnOnIds = { 548132, 547899, 547897, 547901, },
					},
				},
			},
		},

		StartGlobalVoiceLines = "B_MiniBossSpreadShotEncounterStartVoiceLines",
	},

	MiniBossNakedSpawners =
	{
		InheritFrom = { "GeneratedElysium", "MinibossEncounter" },
		--EnemyCountShrineModifierName = "MinibossCountShrineUpgrade",
		--EnemyCountShineModifierAmount = 1.5,
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		EnemySet = EnemySets.EnemiesBiome3Hard,
		LoadBinksFromEnemySet = true,
		DifficultyModifier = 100,
		StartDelay = 1.5,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,

		SpawnIntervalMin = 1.5,
		SpawnIntervalMax = 3.5,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 6,
		ActiveEnemyCapMin = 6,
		ActiveEnemyCapMax = 6,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "FlurrySpawnerElite",
						TotalCount = 1,
						ForceFirst = true,
						SpawnOnIds = { 547382, 547381, },
					},
					{
						Name = "ShadeNakedElite",
						InfiniteSpawns = true,
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 0.0,
			},

		},
		CancelSpawnsOnKillAll = { "FlurrySpawnerElite" },
		SpawnThreadName = "MiniBossNakedSpawnersSpawnThread",

		StartGlobalVoiceLines = "C_MiniBossEncounterStartVoiceLines",
	},

	MiniBossShadeMagic =
	{
		InheritFrom = { "GeneratedElysium", "MinibossEncounter" },
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		EnemySet = EnemySets.EnemiesBiome3Hard,
		LoadBinksFromEnemySet = true,
		DifficultyModifier = 100,
		StartDelay = 1.5,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,

		SpawnIntervalMin = 0.01,
		SpawnIntervalMax = 0.01,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 6,
		ActiveEnemyCapMin = 6,
		ActiveEnemyCapMax = 6,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "ShadeMagicUnit",
						TotalCount = 1,
						ForceFirst = true,
						SpawnOnIds = { 522819, },
						RequiredFalseMetaUpgrade = "MinibossCountShrineUpgrade"
					},
					{
						Name = "ShadeMagicUnit",
						TotalCount = 2,
						ForceFirst = true,
						SpawnOnIds = { 522894, 522819, },
						RequiredMetaUpgrade = "MinibossCountShrineUpgrade"
					},
				},
				OverrideValues = BaseWaveOverrideValues,
				StartDelay = 0.0,
			},

		},
		--CancelSpawnsOnKillAll = { "FlurrySpawnerElite" },
		--SpawnThreadName = "MiniBossNakedSpawnersSpawnThread",

		--StartGlobalVoiceLines = "C_MiniBossEncounterStartVoiceLines",
	},

	-- Hydra Fight Encounters
	BaseHydraEncounter =
	{
		Generated = true,
		MinWaves = 1,
		MaxWaves = 1,
		BlockHighlightEncounter = true,
		MinTypes = 1,
		MaxTypes = 1,
		MaxTypesCap = 1,

		EncounterType = "Spawned",
		UnthreadedEvents = EncounterSets.EncounterEventsHydraPhase,
		SpawnIntervalMin = 0.8,
		SpawnIntervalMax = 0.8,
		ActiveEnemyCapBase = 10,
		BlockSpawnMultipliers = true,
		FastClearThreshold = 100,

		UseRoomEncounterEnemySet = true,
	},

	-- Rank 1
	HydraHeads1 =
	{
		InheritFrom = {"BaseHydraEncounter"},

		ManualWaveTemplates =
		{
			[1] = {
				Spawns =
				{
					{
						TotalCount = 3,
						SpawnOnIds = { 506375, 506376, 506377, 506378, 506380, 506381, },
						Generated = true,
					},
				},
			}
		}
	},

	HydraHeads2 =
	{
		InheritFrom = {"BaseHydraEncounter"},

		ManualWaveTemplates =
		{
			[1] = {
				Spawns =
				{
					{
						TotalCount = 1,
						SpawnOnIds = { 506375, 506376 },
						Generated = true,
					},
					{
						TotalCount = 1,
						SpawnOnIds = { 506377, 506378, },
						Generated = true,
					},
					{
						TotalCount = 1,
						SpawnOnIds = { 506380, 506381, },
						Generated = true,
					},
				},
			}
		}
	},

	HydraHeads3 =
	{
		InheritFrom = {"BaseHydraEncounter"},

		ManualWaveTemplates =
		{
			[1] = {
				Spawns =
				{
					{
						TotalCount = 2,
						SpawnOnIds = { 506375, 506376, 506380, 506381, },
						Generated = true,
					},
					{
						TotalCount = 1,
						SpawnOnIds = { 506377, 506378, },
						Generated = true,
					},
				},
			}
		}

	},

	-- Rank 3
	HydraHeads4 =
	{
		InheritFrom = {"BaseHydraEncounter"},

		ManualWaveTemplates =
		{
			[1] = {
				Spawns =
				{
					{
						TotalCount = 2,
						SpawnOnIds = { 506381, 506376, },
						ForceFirst = true,
						Generated = true,
					},
					{
						TotalCount = 2,
						SpawnOnIds = { 506380, 506377, },
						ForceFirst = true,
						Generated = true,
					},
					{
						TotalCount = 2,
						SpawnOnIds = { 506375, 506378, },
						ForceFirst = true,
						Generated = true,
					},
				},
			},
		},

		StartGlobalVoiceLines = "HydraHeadsSpawnedVoiceLines",

	},

	HydraHeads5 =
	{
		InheritFrom = {"BaseHydraEncounter"},

		ManualWaveTemplates =
		{
			[1] = {
				Spawns =
				{
					{
						TotalCount = 3,
						SpawnOnIds = { 506381, 506376, 506377 },
						ForceFirst = true,
						Generated = true,
					},
					{
						TotalCount = 3,
						SpawnOnIds = { 506378, 506375, 506380, },
						ForceFirst = true,
						Generated = true,
					},
				},
			},
		},
	},

	HydraHeads6 =
	{
		InheritFrom = {"BaseHydraEncounter"},

		ManualWaveTemplates =
		{
			[1] = {
				Spawns =
				{
					{
						TotalCount = 2,
						SpawnOnIds = { 506381, 506376, },
						ForceFirst = true,
						Generated = true,
					},
					{
						TotalCount = 4,
						SpawnOnIds = { 506378, 506375, 506380, 506377, },
						ForceFirst = true,
						Generated = true,
					},
				},
			},
		},

		StartGlobalVoiceLines = "HydraHeadsSpawnedVoiceLines",

	},

	HydraHeads7 =
	{
		InheritFrom = {"BaseHydraEncounter"},

		ManualWaveTemplates =
		{
			[1] = {
				Spawns =
				{
					{
						TotalCount = 3,
						SpawnOnIds = { 506381, 506376, 506378, },
						ForceFirst = true,
						Generated = true,
					},
					{
						TotalCount = 2,
						SpawnOnIds = { 506380, 506377, },
						ForceFirst = true,
						Generated = true,
					},
					{
						TotalCount = 1,
						SpawnOnIds = { 506375 },
						ForceFirst = true,
						Generated = true,
					},
				},
			},
		},

		StartGlobalVoiceLines = "HydraHeadsSpawnedVoiceLines",

	},

	-- Theseus & Minotaur
	ChariotSpawns =
	{
		EncounterType = "Spawned",
		UnthreadedEvents =
		{
			{ FunctionName = "HandleEnemySpawns" },
			{ FunctionName = "CheckForEncounterEnemiesDead" },
		},
		SpawnIntervalMin = 19.0,
		SpawnIntervalMax = 22.0,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 2,
		BlockSpawnMultipliers = true,
		SpawnAggroed = true,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Chariot",
						InfiniteSpawns = true,
					},
				},
				StartDelay = 3,
			},
		},
		CancelSpawnsOnKillAllTypes = { "Theseus", "Minotaur" },
		SpawnThreadName = "TheseusMinotaurSpawns",
	},

	-- UNIQUE ROOM ENCOUNTERS
	HealthRestore =
	{
		InheritFrom = { "NonCombat" },
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivateObjects", Args = { ObjectType = "HealthFountain" } },
			{ FunctionName = "SpawnRoomReward" },
		},
	},

	Shop =
	{
		InheritFrom = { "NonCombat" },
		SecretMusic = "/Music/BlankMusicCue",
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "SpawnRoomReward" },
			{ FunctionName = "CheckForbiddenShopItem", GameStateRequirements = { ChanceToPlay = 0.22, RequiredMinRunsCleared = 1, CurrentRunValueFalse = "ForbiddenShopItemOffered", } },
		},
		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Charon_01", WithinDistance = 600,
				LeaveDistanceBuffer = 60,
				VoiceLines =
				{
					{
						PlayOnce = true,
						BreakIfPlayed = true,
						UsePlayerSource = true,
						RequiredSeenRooms = { "CharonFight01" },
						CooldownName = "MentionedCharon",
						CooldownTime = 20,

						-- Erm, you're not angry with me, are you, Charon mate?
						{ Cue = "/VO/ZagreusField_3850" },
					},
					{
						UsePlayerSource = true,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.5,
						RequiredFalseSeenRoomsThisRun = { "D_Combat01", "D_Combat02", "D_Combat03", "D_Combat04", "D_Combat05", "D_Combat06" },
						-- RequiredTextLines = { "CharonFirstMeeting" },
						CooldownName = "MentionedCharon",
						CooldownTime = 20,

						-- What's new, Charon?
						{ Cue = "/VO/ZagreusField_0495", RequiredTextLines = { "CharonGift02" }, RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- How goes it, mate?
						{ Cue = "/VO/ZagreusField_0496", RequiredTextLines = { "CharonGift02" }, RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- Greetings, Charon.
						{ Cue = "/VO/ZagreusField_0497", RequiredTextLines = { "CharonGift01" }, RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- Hi, Charon.
						{ Cue = "/VO/ZagreusField_0899", RequiredTextLines = { "CharonGift02" }, RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- Greetings, Charon.
						{ Cue = "/VO/ZagreusField_0900", RequiredTextLines = { "CharonGift01" }, RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- It's Charon.
						{ Cue = "/VO/ZagreusField_0901", RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- Good old Charon.
						{ Cue = "/VO/ZagreusField_0902", RequiredTextLines = { "CharonGift03" }, RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- Charon!
						{ Cue = "/VO/ZagreusField_1605", RequiredRooms = { "C_Shop01" }, RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- How's business, mate?
						{ Cue = "/VO/ZagreusField_1606", RequiredTextLines = { "CharonGift02" }, RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- Fancy seeing you up here.
						{ Cue = "/VO/ZagreusField_1607", RequiredBiome = "Elysium", RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- Charon's shop.
						{ Cue = "/VO/ZagreusField_1608", RequiredBiome = "Tartarus" },
						-- Look at all this.
						{ Cue = "/VO/ZagreusField_1612", RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- Hello, Charon!
						{ Cue = "/VO/ZagreusField_4435", RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- Hey Charon.
						{ Cue = "/VO/ZagreusField_4436", RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- Looking good, Charon.
						{ Cue = "/VO/ZagreusField_4437", RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- Open for business, mate?
						{ Cue = "/VO/ZagreusField_4438", RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- What's new, mate?
						{ Cue = "/VO/ZagreusField_4439", RequiredPlayed = { "/VO/ZagreusField_1608 "}, },
						-- Quite the selection.
						{ Cue = "/VO/ZagreusField_4440", RequiredPlayed = { "/VO/ZagreusField_1608 "}, RequiredRoomMaxValues = { StoreItemsPurchased = 0 }, },
						-- What a selection, mate.
						{ Cue = "/VO/ZagreusField_4441", RequiredPlayed = { "/VO/ZagreusField_1608 "}, RequiredRoomMaxValues = { StoreItemsPurchased = 0 }, },
						-- Plenty in stock.
						{ Cue = "/VO/ZagreusField_4442", RequiredPlayed = { "/VO/ZagreusField_1608 "}, RequiredRoomMaxValues = { StoreItemsPurchased = 0 }, },
						-- Good stuff in stock.
						{ Cue = "/VO/ZagreusField_4443", RequiredPlayed = { "/VO/ZagreusField_1608 "}, RequiredRoomMaxValues = { StoreItemsPurchased = 1 }, },
					},
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.33,
						PreLineAnim = "Charon_IdleGreeting",
						RequiredTextLines = { "Ending01", "CharonAboutSecretService01" },
						RequiredRooms = { "A_Shop01", "B_Shop01", "C_Shop01", "B_PreBoss01", "C_PreBoss01" },

						-- Haaahhhhh....
						{ Cue = "/VO/Charon_0010" },
						-- Mmmrrrrnnn....
						{ Cue = "/VO/Charon_0011" },
						-- Hrrnmmmm....
						{ Cue = "/VO/Charon_0012" },
						-- Khhhrrrrr....
						{ Cue = "/VO/Charon_0013" },
						-- Heeehhhhhhh....
						{ Cue = "/VO/Charon_0014" },
						-- Hhrrrrnneehhhh....
						{ Cue = "/VO/Charon_0015" },
						-- Urrrrrrgggghhh...
						{ Cue = "/VO/Charon_0016" },
						-- Hrrrnnnhh....
						{ Cue = "/VO/Charon_0017" },
						-- Nnnnrrrrrhhh....
						{ Cue = "/VO/Charon_0018" },
						-- Hnnnggghhhh....
						{ Cue = "/VO/Charon_0019" },
						-- Hohhhh....
						{ Cue = "/VO/Charon_0020" },
						-- Hrrrnnnn...?
						{ Cue = "/VO/Charon_0021" },
					},					
					{
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.66,

						-- Haaahhhhh....
						{ Cue = "/VO/Charon_0010" },
						-- Mmmrrrrnnn....
						{ Cue = "/VO/Charon_0011" },
						-- Hrrnmmmm....
						{ Cue = "/VO/Charon_0012" },
						-- Khhhrrrrr....
						{ Cue = "/VO/Charon_0013" },
						-- Heeehhhhhhh....
						{ Cue = "/VO/Charon_0014" },
						-- Hhrrrrnneehhhh....
						{ Cue = "/VO/Charon_0015" },
						-- Urrrrrrgggghhh...
						{ Cue = "/VO/Charon_0016" },
						-- Hrrrnnnhh....
						{ Cue = "/VO/Charon_0017" },
						-- Nnnnrrrrrhhh....
						{ Cue = "/VO/Charon_0018" },
						-- Hnnnggghhhh....
						{ Cue = "/VO/Charon_0019" },
						-- Hohhhh....
						{ Cue = "/VO/Charon_0020" },
						-- Hrrrnnnn...?
						{ Cue = "/VO/Charon_0021" },
					},
				},
			},
		},

		ExitVoiceLines =
		{
			-- table duplicated from A_PreBoss01 ExitVoiceLines because the Encounter lines below take priority
			{
				PreLineWait = 0.25,
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.5,
				RequiredTextLines = { "Fury2FirstAppearance", "Fury3FirstAppearance" },
				RequiredRoom = "A_PreBoss01",
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
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				RequiredTextLines = { "CharonAboutHermes01" },
				RequiredFalseRooms = { "A_PreBoss01", "D_Hub" },
				PlayOnceFromTableThisRun = true,
				RequiredLootThisRun = "HermesUpgrade",
				SuccessiveChanceToPlay = 0.02,
				RequiredUnitAlive = "NPC_Charon_01",

				-- Say hi to Hermes for me!
				{ Cue = "/VO/ZagreusField_1965" },
				-- Tell Hermes I said hi, will you?
				{ Cue = "/VO/ZagreusField_1966" },
				-- Tell Hermes hey for me!
				{ Cue = "/VO/ZagreusField_4431" },
				-- Regards to Hermes!
				{ Cue = "/VO/ZagreusField_4432" },
				-- See you, Charon!
				{ Cue = "/VO/ZagreusField_4433", RequiredTextLines = { "CharonGift06" }, },
				-- Appreciate you, Charon!
				{ Cue = "/VO/ZagreusField_4434", RequiredTextLines = { "CharonGift06" }, },
			},
		},
	},

	HealthGateLoot =
	{
		PostUnthreadedEvents =
		{
			{ FunctionName = "GrantLoot", Args = { ConsumableName = "TrialUpgrade" } },
		},
	},

	CombatTestJosh =
	{
		SpawnIntervalMin = 1.0,
		SpawnIntervalMax = 2.0,
		ActiveEnemyCapBase = 10,
		EnemyCountDepthRamp = 0.2,

		Spawns =
		{
			{
				Name = "LightSpawner",
				CountMin = 0,
				CountMax = 0,
			},
		},

	},

	-- NPC Encounters
	TestNPCs =
	{
		InheritFrom = { "NonCombat" },
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Hades_01", "NPC_Cerberus_01", "NPC_Achilles_01", "NPC_Nyx_01", "NPC_Dusa_01", "NPC_Skelly_01", "NPC_Charon_01", "NPC_Orpheus_01", "NPC_Eurydice_01", "NPC_Sisyphus_01", "NPC_Hypnos_01", "NPC_Thanatos_01", "NPC_Thanatos_Field_01", "NPC_FurySister_01" }, } },
		},

		DistanceTriggers =
		{
			{
				TriggerGroup = "Art_NPCs", WithinDistance = 400, LockToCharacter = true,
				VoiceLines =
				{
					-- He remembered only meeting her.
					-- { Cue = "/VO/Storyteller_0056", PreLineWait = 0.35 },
				},
			},
		},
	},

	Story_HadesTest_01 =
	{
		InheritFrom = { "NonCombat" },
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Hades_01", "NPC_Cerberus_01", "NPC_Achilles_01", "NPC_Nyx_01", "NPC_Dusa_01" }, } },
		},

		DistanceTriggers =
		{
			{
				-- TriggerGroup = "Art_NPCs", WithinDistance = 400, LockToCharacter = true,
				VoiceLines =
				{
					-- He remembered only meeting her.
					-- { Cue = "/VO/Storyteller_0056", PreLineWait = 0.35 },

					-- The Princess Ariadne.
					-- { Cue = "/VO/Storyteller_0057", PreLineWait = 0.85 },
				},
			},
		},

		GreetedVoiceLines =
		{
			-- He told her that the gods were on his side.
			-- { Cue = "/VO/Storyteller_0060", PreLineWait = 0.45, PlayOnce = true },

			-- She begged him for his safe return.
			-- { Cue = "/VO/Storyteller_0059", PreLineWait = 0.85, PlayOnce = true },
		},

	},

	Story_Sisyphus_01 =
	{
		InheritFrom = { "NonCombat" },
		MaxAppearancesThisBiome = 1,
		UnthreadedEvents = {},
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Sisyphus_01", "NPC_Bouldy_01" }, } },
			{ FunctionName = "CheckConversations" },
			-- MegaeraWithSisyphus01
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredQueuedTextLines = "MegaeraWithSisyphus01_FollowUp",
					RequiredTextLines = { "SisyphusMeeting04" },
					RequiredKills = { Harpy = 2 },
				},
				Args =
				{
					Ids = { 506343, },
					AddEncounterEvent =
					{
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							SourceId = 506343,
							IntroWait = 1.5,
							PanIds = { 20077, 506343, 370001, },
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.85,
									UsePlayerSource = true,

									-- Uh oh.
									{ Cue = "/VO/ZagreusField_2660" },
								},
							},
							TextLineSet =
							{
								MegaeraWithSisyphus01 =
								{
									-- requirements are above
									{ Cue = "/VO/MegaeraField_0030", PreLineWait = 0.35,
										AngleTowardTargetId = 370001,
										PreLineAnim = "FuryIdleInHouseFidgetWhipTaunt_Start",
										PostLineAnim = "FuryIdleInHouseFidgetWhipTaunt_ReturnToIdle",
										Text = "...You help him out again, you'll get a thousand lashes next we meet. And when I return, this little rock of yours had better be up there rather than here, or else you'll get a thousand more." },
									{ Cue = "/VO/Sisyphus_0167", Portrait = "Portrait_Sisyphus_Default_01", Speaker = "NPC_Sisyphus_01",
										PostLineFunctionName = "ExitNPCPresentation", PostLineFunctionArgs = { ObjectId = 506343, TeleportToId = 506344 },
										PreLineAnim = "SisyphusExplaining", PreLineAnimTarget = 370001,
										Text = "Sounds good, sounds good, Madam, that's more than equitable really, I'll hold you to that! Be seeing you around!" },
								},
							},
						},
					},
				},
			},

			-- MegaeraWithSisyphus02
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredQueuedTextLines = "MegaeraWithSisyphus02_FollowUp",
				},
				Args =
				{
					Ids = { 506343, },
					AddEncounterEvent =
					{
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							SourceId = 506343,
							IntroWait = 1.5,
							PanIds = { 20077, 506343, 370001, },
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.85,
									UsePlayerSource = true,

									-- Um, Meg...?
									-- { Cue = "/VO/ZagreusHome_0184" },
								},
							},
							TextLineSet =
							{
								MegaeraWithSisyphus02 =
								{
									-- requirements are above
									{ Cue = "/VO/MegaeraField_0031", PreLineWait = 0.35,
										AngleTowardTargetId = 370001,
										PreLineAnim = "FuryIdleInHouseFidgetWhipTaunt_Start",
										PostLineAnim = "FuryIdleInHouseFidgetWhipTaunt_ReturnToIdle",
										Text = "...And you'll keep busy with your boulder if you know what's good for you, you little cheat. Don't go thinking I'm not watching you." },
									{ Cue = "/VO/Sisyphus_0169", Portrait = "Portrait_Sisyphus_Default_01", Speaker = "NPC_Sisyphus_01",
										PostLineFunctionName = "ExitNPCPresentation", PostLineFunctionArgs = { ObjectId = 506343, TeleportToId = 506344 },
										PreLineAnim = "SisyphusExplaining", PreLineAnimTarget = 370001,
										Text = "I appreciate your vigilance, Madam, and surely I'll be getting Bouldy up this very hill in no time flat, despite the fact that I have never once achieved this!" },
								},
							},
						},
					},
				},
			},

			-- MegaeraWithSisyphus03
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredQueuedTextLines = "MegaeraWithSisyphus03_FollowUp",
				},
				Args =
				{
					Ids = { 506343, },
					AddEncounterEvent =
					{
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							SourceId = 506343,
							IntroWait = 1.5,
							PanIds = { 20077, 506343, 370001, },
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.85,
									UsePlayerSource = true,

									-- Um, Meg...?
									-- { Cue = "/VO/ZagreusHome_0184" },
								},
							},
							TextLineSet =
							{
								MegaeraWithSisyphus03 =
								{
									-- requirements are above
									{ Cue = "/VO/MegaeraField_0445", PreLineWait = 0.35,
										AngleTowardTargetId = 370001,
										PreLineAnim = "FuryIdleInHouseFidgetWhipTaunt_Start",
										PostLineAnim = "FuryIdleInHouseFidgetWhipTaunt_ReturnToIdle",
										Text = "...And when this matter with the Prince is over with, we will be getting back to how things used to be. Until such time, I'd better regularly see your boulder on that hill." },
									{ Cue = "/VO/Sisyphus_0174", Portrait = "Portrait_Sisyphus_Default_01", Speaker = "NPC_Sisyphus_01",
										PostLineFunctionName = "ExitNPCPresentation", PostLineFunctionArgs = { ObjectId = 506343, TeleportToId = 506344 },
										PreLineAnim = "SisyphusExplaining", PreLineAnimTarget = 370001,
										Text = "Entirely makes sense to me, Madam, and rest assured that Bouldy, {#DialogueItalicFormat}erm{#PreviousFormat}, that is to say this boulder here, that I will push it regularly, moving forward, same as ever! Now good-bye!" },
								},
							},
						},
					},
				},
			},

			-- ThanatosWithSisyphus01
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredQueuedTextLines = "ThanatosWithSisyphus01_FollowUp",
				},
				Args =
				{
					Ids = { 506345, },
					AddEncounterEvent =
					{
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							SourceId = 506345,
							IntroWait = 1.5,
							PanIds = { 20077, 506345, 370001, },
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.85,
									UsePlayerSource = true,

									-- Um, Meg...?
									-- { Cue = "/VO/ZagreusHome_0184" },
								},
							},
							TextLineSet =
							{
								ThanatosWithSisyphus01 =
								{
									EndVoiceLines =
									{
										PreLineWait = 1.0,
										UsePlayerSource = true,
										-- You all right, there, sir?
										{ Cue = "/VO/ZagreusField_0476" },
									},
									-- requirements are above
									{ Cue = "/VO/Thanatos_0215", PreLineWait = 0.35,
										AngleTowardTargetId = 370001,
										Text = "...And, lastly, you're forbidden from offering further assistance to Prince Zagreus. Do we understand each other?" },
									{ Cue = "/VO/Sisyphus_0163", Portrait = "Portrait_Sisyphus_Default_01", Speaker = "NPC_Sisyphus_01",
										Text = "Why, absolutely, Master Thanatos, I wouldn't think of it! My mind is fully occupied with all the latest boulder-pushing strategies, besides." },
									{ Cue = "/VO/Thanatos_0216", PostLineThreadedFunctionName = "ThanatosExit", PostLineFunctionArgs = { IgnoreMusic = true },
										Text = "Enough! Get back to work, and I'll get back to mine." },
								},
							},
						},
					},
				},
			},

			-- ThanatosWithSisyphus02
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredQueuedTextLines = "ThanatosWithSisyphus02_FollowUp",
				},
				Args =
				{
					Ids = { 506345, },
					AddEncounterEvent =
					{
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							SourceId = 506345,
							IntroWait = 1.5,
							PanIds = { 20077, 506345, 370001, },
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.85,
									UsePlayerSource = true,

									-- Um, Meg...?
									-- { Cue = "/VO/ZagreusHome_0184" },
								},
							},
							TextLineSet =
							{
								ThanatosWithSisyphus02 =
								{
									-- requirements are above
									{ Cue = "/VO/Sisyphus_0165", Portrait = "Portrait_Sisyphus_Default_01", Speaker = "NPC_Sisyphus_01",
										AngleTowardTargetId = 370001,
										Text = "I understand you, Master Thanatos, and will be doing as you say. No more assistance for Prince Zagreus, dead serious this time." },
									{ Cue = "/VO/ThanatosField_0218",
										PreLineAnim = "ThanatosIdleInhouseFidget_HairFlick",
										PostLineThreadedFunctionName = "ThanatosExit",
										PostLineFunctionArgs = { IgnoreMusic = true },
										Text = "Good. It shall be both our skins if you are caught in one of your deceptions. See to it that this doesn't happen." },
								},
							},
						},
					},
				},
			},

			-- ThanatosWithSisyphus03
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredQueuedTextLines = "ThanatosWithSisyphus03_FollowUp",
				},
				Args =
				{
					Ids = { 506345, },
					AddEncounterEvent =
					{
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							SourceId = 506345,
							IntroWait = 1.5,
							PanIds = { 20077, 506345, 370001, },
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.85,
									UsePlayerSource = true,

									-- Um, Meg...?
									-- { Cue = "/VO/ZagreusHome_0184" },
								},
							},
							TextLineSet =
							{
								ThanatosWithSisyphus03 =
								{
									-- requirements are above
									{ Cue = "/VO/ThanatosField_0216", PreLineWait = 0.35,
										AngleTowardTargetId = 370001,
										Text = "...You would be wise to heed my words next time, and fear the consequences of eluding me. Death can be most unpleasant, as I'm sure you know." },
									{ Cue = "/VO/Sisyphus_0176", Portrait = "Portrait_Sisyphus_Default_01", Speaker = "NPC_Sisyphus_01",
										Text = "Well, that's just it, Master Thanatos. I never was terribly fearful of you gods, if you'll forgive my saying so. Far as I can tell, all of you seem to have your struggles much like mortals do. A fear of death aside." },
									{ Cue = "/VO/ThanatosField_0217", PostLineThreadedFunctionName = "ThanatosExit",
										Emote = "PortraitEmoteFiredUp",
										PreLineAnim = "ThanatosIdleInhouseFidget_HairFlick",
										PostLineThreadedFunctionName = "ThanatosExit",
										PostLineFunctionArgs = { IgnoreMusic = true },
										Text = "What would you know of the struggles of gods? Now you have eternity to think on what you've done. Maybe I'll check again with you after another aeon or two, see if you've learned anything more." },
								},
							},
						},
					},
				},
			},
		},

		StartVoiceLines =
		{
			-- The strum of music brought him to an unexpected sight...
			-- { Cue = "/VO/Storyteller_0079", PreLineWait = 1.5, PlayOnce = true },
		},

		ExitVoiceLines =
		{
			ObjectType = "NPC_Sisyphus_01",
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineAnim = "SisyphusIdleGreeting",

				-- Well you take care!
				{ Cue = "/VO/Sisyphus_0122" },
				-- Bye now!
				{ Cue = "/VO/Sisyphus_0123" },
				-- You can do it!
				{ Cue = "/VO/Sisyphus_0124" },
				-- You got this, Prince!
				{ Cue = "/VO/Sisyphus_0125", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
				-- Farewell, then!
				{ Cue = "/VO/Sisyphus_0126" },
				-- All right, bye!
				{ Cue = "/VO/Sisyphus_0127" },
				-- Careful out there!
				{ Cue = "/VO/Sisyphus_0128" },
				-- Take care out there!
				{ Cue = "/VO/Sisyphus_0111" },
				-- Good luck out there!
				{ Cue = "/VO/Sisyphus_0112" },
				-- Godspeed and all!
				{ Cue = "/VO/Sisyphus_0113" },
				-- Take care of yourself!
				{ Cue = "/VO/Sisyphus_0114" },
				-- Go get them, Prince!
				{ Cue = "/VO/Sisyphus_0115", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
				-- Farewell, Highness!
				{ Cue = "/VO/Sisyphus_0116" },
				-- Safe travels!
				{ Cue = "/VO/Sisyphus_0117" },
				-- Bye now!
				{ Cue = "/VO/Sisyphus_0118" },
				-- You can do this!
				{ Cue = "/VO/Sisyphus_0119" },
				-- So long for now!
				{ Cue = "/VO/Sisyphus_0120" },
				-- Keep going, Prince!
				{ Cue = "/VO/Sisyphus_0121", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
				-- See you again, all right?
				{ Cue = "/VO/Sisyphus_0242" },
				-- Do tell the Furies I said hi!
				{ Cue = "/VO/Sisyphus_0243", RequiredCosmetics = { "SisyphusQuestItem" } },
				-- You have this, Prince!
				{ Cue = "/VO/Sisyphus_0244", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
				-- Stop by again sometime!
				{ Cue = "/VO/Sisyphus_0245", RequiredTextLines = { "SisyphusGift02" }, },
				-- Careful out there, all right?
				{ Cue = "/VO/Sisyphus_0246" },
				-- May you get out of here this time, Highness!
				{ Cue = "/VO/Sisyphus_0247", RequiredTextLines = { "SisyphusGift02" }, },
				-- Always a pleasure, Prince!
				{ Cue = "/VO/Sisyphus_0248", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
				-- So long, Highness!
				{ Cue = "/VO/Sisyphus_0249" },
				-- Think he'll go all the way this time, Bouldy?
				{ Cue = "/VO/Sisyphus_0250", RequiredTextLines = { "SisyphusMeeting06" }, },
				-- Keep fighting, Highness!
				{ Cue = "/VO/Sisyphus_0251" },
				-- Thanks for stopping by!
				{ Cue = "/VO/Sisyphus_0252" },
				-- Until next time, all right?
				{ Cue = "/VO/Sisyphus_0253", RequiredTextLines = { "SisyphusGift02" }, },
			}
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Sisyphus_01", WithinDistance = 600,
				LeaveDistanceBuffer = 60,
				VoiceLines =
				{
					{
						RandomRemaining = true,
						PreLineAnim = "SisyphusIdleGreeting",

						-- Your Highness!
						{ Cue = "/VO/Sisyphus_0058" },
						-- Hullo!
						{ Cue = "/VO/Sisyphus_0054", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- That who I think it is...?
						{ Cue = "/VO/Sisyphus_0050", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Ahoy!
						{ Cue = "/VO/Sisyphus_0051", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Ahoy there!
						{ Cue = "/VO/Sisyphus_0052", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Look who!
						{ Cue = "/VO/Sisyphus_0053", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Hullo, hullo!
						{ Cue = "/VO/Sisyphus_0055", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Just on a little break!
						{ Cue = "/VO/Sisyphus_0056", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Perfect timing!
						{ Cue = "/VO/Sisyphus_0057", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Well, well!
						{ Cue = "/VO/Sisyphus_0059", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Aren't you a sight!
						{ Cue = "/VO/Sisyphus_0060", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Prince Z.!
						{ Cue = "/VO/Sisyphus_0061", RequiredPlayed = { "/VO/Sisyphus_0058" }, Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
						-- Hey, hey!
						{ Cue = "/VO/Sisyphus_0062", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Good morning or whenever!
						{ Cue = "/VO/Sisyphus_0063", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Bouldy, look who!
						{ Cue = "/VO/Sisyphus_0206", RequiredPlayed = { "/VO/Sisyphus_0058" }, RequiredTextLines = { "SisyphusMeeting06" }, },
						-- Hullo, Your Highness!
						{ Cue = "/VO/Sisyphus_0207", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- You're back, welcome!
						{ Cue = "/VO/Sisyphus_0208", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- He's back again, Bouldy!
						{ Cue = "/VO/Sisyphus_0209", RequiredPlayed = { "/VO/Sisyphus_0058" }, RequiredTextLines = { "SisyphusMeeting06" }, },
						-- Good to see you!
						{ Cue = "/VO/Sisyphus_0210", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Caught me on a break again!
						{ Cue = "/VO/Sisyphus_0211", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Hullo, Prince Z.!
						{ Cue = "/VO/Sisyphus_0212", RequiredPlayed = { "/VO/Sisyphus_0058" }, Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
						-- How nice to see you, Prince!
						{ Cue = "/VO/Sisyphus_0213", RequiredPlayed = { "/VO/Sisyphus_0058" }, Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
						-- It's him, Bouldy!
						{ Cue = "/VO/Sisyphus_0214", RequiredPlayed = { "/VO/Sisyphus_0058" }, RequiredTextLines = { "SisyphusMeeting06" }, },
						-- Well if it isn't you!
						{ Cue = "/VO/Sisyphus_0215", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Ahoy, what's new of late?
						{ Cue = "/VO/Sisyphus_0216", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- The Prince returns!
						{ Cue = "/VO/Sisyphus_0217", RequiredPlayed = { "/VO/Sisyphus_0058" }, Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
						-- What a surprise!
						{ Cue = "/VO/Sisyphus_0218", RequiredPlayed = { "/VO/Sisyphus_0058" }, },
						-- Why, look who's here, Bouldy!
						{ Cue = "/VO/Sisyphus_0219", RequiredPlayed = { "/VO/Sisyphus_0058" }, RequiredTextLines = { "SisyphusMeeting06" }, },
					},
					{
						UsePlayerSource = true,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.66,
						RequiredTextLines = { "SisyphusFirstMeeting" },

						-- Hello, sir.
						{ Cue = "/VO/ZagreusField_0463" },
						-- Hey sir!
						{ Cue = "/VO/ZagreusField_0464" },
					},
				},
			},
		},
	},

	Story_Patroclus_01 =
	{
		InheritFrom = { "NonCombat" },
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		MaxAppearancesThisBiome = 1,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Patroclus_01", "NPC_Achilles_Story_01" }, } },
			{ FunctionName = "CheckConversations" },
		},

		StartVoiceLines =
		{
			-- The strum of music brought him to an unexpected sight...
			-- { Cue = "/VO/Storyteller_0079", PreLineWait = 1.5, PlayOnce = true },
		},

		ExitVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineAnim = "AchillesIdleGreeting",
				ObjectType = "NPC_Achilles_Story_01",
				SuccessiveChanceToPlay = 0.75,

				-- Fight on.
				{ Cue = "/VO/Achilles_0230" },
				-- Farewell.
				{ Cue = "/VO/Achilles_0231" },
				-- Farewell, lad.
				{ Cue = "/VO/Achilles_0232" },
				-- Till we meet again.
				{ Cue = "/VO/Achilles_0233" },
				-- Fight like I'd fight out there.
				{ Cue = "/VO/Achilles_0234" },
				-- Good journey.
				{ Cue = "/VO/Achilles_0235" },
				-- Fear is for the weak.
				{ Cue = "/VO/Achilles_0236" },
				-- We'll see you.
				{ Cue = "/VO/Achilles_0237" },
			},
			ObjectType = "NPC_Sisyphus_01",
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.33,
				ObjectType = "NPC_Patroclus_01",
				RequiredTextLines = { "MyrmidonQuestComplete" },

				-- Be well.
				{ Cue = "/VO/Patroclus_0269" },
				-- Farewell.
				{ Cue = "/VO/Patroclus_0270" },
				-- Good fortune.
				{ Cue = "/VO/Patroclus_0271" },
				-- Take care.
				{ Cue = "/VO/Patroclus_0272" },
				-- Take care of yourself.
				{ Cue = "/VO/Patroclus_0273" },
				-- Till we meet again.
				{ Cue = "/VO/Patroclus_0274" },
				-- Keep going.
				{ Cue = "/VO/Patroclus_0275" },
				-- Good-bye.
				{ Cue = "/VO/Patroclus_0276" },
				-- Bye, stranger.
				{ Cue = "/VO/Patroclus_0277" },
				-- Bye.
				{ Cue = "/VO/Patroclus_0278" },
			},
		},
	},

	Story_Eurydice_01 =
	{
		InheritFrom = { "NonCombat" },
		UnthreadedEvents =
		{
			-- None
		},
		MaxAppearancesThisBiome = 1,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Eurydice_01", "NPC_Orpheus_Story_01" }, } },
			{ FunctionName = "CheckConversations" },
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Eurydice_01", WithinDistance = 900,
				LeaveDistanceBuffer = 60,
				VoiceLines =
				{
					{
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.1,
						RequiresAmbientMusicId = true,
						-- requires Orpheus present
						AreIdsAlive = { 554419 },
						RequiredTextLines = { "OrpheusWithEurydice01" },

						-- Look, Orphy!
						{ Cue = "/VO/Eurydice_0261" },
						-- Look who, Orphy!
						{ Cue = "/VO/Eurydice_0262" },
					},
					{
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.75,
						RequiresAmbientMusicId = true,
						-- will not play with Orpheus present
						AreIdsNotAlive = { 554419 },

						-- Who's there?
						{ Cue = "/VO/Eurydice_0051", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Yeah, what do you want? Oh!
						{ Cue = "/VO/Eurydice_0052", RequiredPlayed = { "/VO/Eurydice_0064" }, RequiredFalseTextLines = { "EurydiceGift07" }, },
						-- Someone there?
						{ Cue = "/VO/Eurydice_0053", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Oh hey!
						{ Cue = "/VO/Eurydice_0054", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Hi hon!
						{ Cue = "/VO/Eurydice_0055", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Hey hon!
						{ Cue = "/VO/Eurydice_0056", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Hey you!
						{ Cue = "/VO/Eurydice_0057", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Hey!
						{ Cue = "/VO/Eurydice_0058", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Majesty!
						{ Cue = "/VO/Eurydice_0059", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Majesty.
						{ Cue = "/VO/Eurydice_0060", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Look-ee who.
						{ Cue = "/VO/Eurydice_0061", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Hi!
						{ Cue = "/VO/Eurydice_0062", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Welcome!
						{ Cue = "/VO/Eurydice_0063", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Come on in!
						{ Cue = "/VO/Eurydice_0064", },
						-- Make yourself at home.
						{ Cue = "/VO/Eurydice_0065", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Hades kid!
						{ Cue = "/VO/Eurydice_0256", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Hey!
						{ Cue = "/VO/Eurydice_0257", RequiredPlayed = { "/VO/Eurydice_0064" }, RequiredTextLines = { "EurydiceGift03" } },
						-- Welcome back!
						{ Cue = "/VO/Eurydice_0258", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- Come in!
						{ Cue = "/VO/Eurydice_0259", RequiredPlayed = { "/VO/Eurydice_0064" } },
						-- What's going on?
						{ Cue = "/VO/Eurydice_0260", RequiredPlayed = { "/VO/Eurydice_0064" } },
					},
					{
						UsePlayerSource = true,
						PlayOnce = true,
						PlayOnceContext = "EurydiceFirstMeeting",
						RequiredFalseTextLines = { "EurydiceFirstMeeting01_A", "EurydiceFirstMeeting01_B", "EurydiceFirstMeeting01_C", },
						PreLineWait = 0.75,
						PostLineWait = 9,

						-- OK?
						{ Cue = "/VO/ZagreusField_2952" },
					},
					{
						BreakIfPlayed = true,
						PlayOnce = true,
						UsePlayerSource = true,
						RequiredFalseTextLines = { "EurydiceFirstMeeting01_A", "EurydiceFirstMeeting01_B", "EurydiceFirstMeeting01_C", },
						RequiredFalseFlags = { "MetEurydice" },
						Queue = "Always",

						-- Could dash clear through that wall I think...
						{ Cue = "/VO/ZagreusField_3005", BreakIfPlayed = true, },
					},
					{
						RandomRemaining = true,
						UsePlayerSource = true,
						SuccessiveChanceToPlayAll = 0.5,
						RequiresMusicId = true,
						RequiresAmbientMusicId = true,
						RequiredFalsePlayedThisRoom = { "/VO/ZagreusField_3423" },
						-- Orpheus is present
						IsIdAlive = 554419,

						-- Hey, you two!
						{ Cue = "/VO/ZagreusField_3464" },
						-- Hello, you two.
						{ Cue = "/VO/ZagreusField_3465" },
						-- You sound terrific.
						{ Cue = "/VO/ZagreusField_3466" },
						-- Hey mate! Eurydice!
						{ Cue = "/VO/ZagreusField_3467" },
					},
					{
						RandomRemaining = true,
						UsePlayerSource = true,
						SuccessiveChanceToPlay = 0.5,
						RequiredAnyTextLines = { "EurydiceFirstMeeting01_A", "EurydiceFirstMeeting01_B", "EurydiceFirstMeeting01_C", },
						RequiresMusicId = true,
						RequiresAmbientMusicId = true,
						-- will not play with Orpheus present
						AreIdsNotAlive = { 554419 },

						-- Hi there!
						{ Cue = "/VO/ZagreusField_2663", RequiredPlayed = { "/VO/ZagreusField_2664" } },
						-- Hello!
						{ Cue = "/VO/ZagreusField_2664" },
						-- Lovely singing.
						{ Cue = "/VO/ZagreusField_2665", RequiredPlayed = { "/VO/ZagreusField_2664" } },
						-- Hello Eurydice.
						{ Cue = "/VO/ZagreusField_2666", RequiredTextLines = { "EurydiceGift01" }, RequiredPlayed = { "/VO/ZagreusField_2664" } },
						-- It's only me.
						{ Cue = "/VO/ZagreusField_2667", RequiredPlayed = { "/VO/ZagreusField_2664" } },
						-- Something smells good.
						{ Cue = "/VO/ZagreusField_2668", RequiredPlayed = { "/VO/ZagreusField_2664" } },
						-- Hey what's cooking?
						{ Cue = "/VO/ZagreusField_2669", RequiredTextLines = { "EurydiceGift01" }, RequiredPlayed = { "/VO/ZagreusField_2664" } },
					},
					{
						UsePlayerSource = true,
						RequiresNullAmbientMusicId = true,
						RequiredPlayedThisRoom = { "/VO/ZagreusField_2511" },

						-- It's only me.
						{ Cue = "/VO/ZagreusField_2667" },
					}
				},
			},
		},
	},


	Story_NyxWithChaos_01 =
	{
		InheritFrom = { "NonCombat" },

		MaxAppearancesThisRun = 1,
		UnthreadedEvents = {},
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Nyx_Story_01" }, } },
			{ FunctionName = "CheckConversations" },

			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					-- MinRunsSinceAnyTextLines = { TextLines = { "MegIntermissionChat01", "MegIntermissionChat02", "MegIntermissionChat03" }, Count = 3 }
				},
			},
		},

	},

}