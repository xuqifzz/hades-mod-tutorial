EncounterSets =
{
	TartarusEncountersDefault =
	{
		"GeneratedTartarus", "GeneratedTartarus", "GeneratedTartarus",
		"GeneratedTartarus", "GeneratedTartarus", "GeneratedTartarus", "SurvivalTartarus",
		"GeneratedTartarus", "GeneratedTartarus", "GeneratedTartarus", "SurvivalTartarus", "ThanatosTartarus"
	},

	AsphodelEncountersDefault =
	{
		"GeneratedAsphodel", "GeneratedAsphodel", "GeneratedAsphodel",
		"GeneratedAsphodel", "GeneratedAsphodel", "GeneratedAsphodel",
		"GeneratedAsphodel", "GeneratedAsphodel", "GeneratedAsphodel", "ThanatosAsphodel"
	},

	ElysiumEncountersDefault =
	{
		"GeneratedElysium", "GeneratedElysium", "GeneratedElysium",
		"GeneratedElysium", "GeneratedElysium", "GeneratedElysium",
		"GeneratedElysium", "GeneratedElysium", "GeneratedElysium", "ThanatosElysium",
		"ThanatosElysiumIntro", "ThanatosElysiumIntro", "ThanatosElysiumIntro"
	},

	StyxEncountersMini =
	{
		"GeneratedStyxMini", "GeneratedStyxMini", "GeneratedStyxMini", "GeneratedStyxMini",
	},

	TartarusEncountersNoSurvival =
	{
		"GeneratedTartarus"
	},

	ThanatosEncounters = 
	{
		"ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium"
	},

	EncounterEventsGenerated =
	{
		{ FunctionName = "EncounterAudio" },
		{ FunctionName = "HandleTrapChains" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForAllEnemiesDead" },
		{ FunctionName = "PostCombatAudio" },
		{ FunctionName = "SpawnRoomReward" },
	},

	EncounterEventsDefault =
	{
		{ FunctionName = "EncounterAudio" },
		{ FunctionName = "HandleTrapChains" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForAllEnemiesDead" },
		{ FunctionName = "PostCombatAudio" },
		{ FunctionName = "SpawnRoomReward" },
	},

	EncounterEventsSurvival =
	{
		{ FunctionName = "SurvivalEncounterStartPresentation" },
		{ FunctionName = "EncounterAudio" },
		{ FunctionName = "BeginSurvivalEncounter" },
		{ FunctionName = "HandleTimedSpawns" },
		{ FunctionName = "DisableRoomTraps" },
		{ FunctionName = "CheckForAllEnemiesDead" },
		{ FunctionName = "PostCombatAudio" },
		{ FunctionName = "SpawnRoomReward" },
	},

	EncounterEventsPerfectClear =
	{
		{ FunctionName = "PerfectClearEncounterStartPresentation" },
		{ FunctionName = "EncounterAudio" },
		{ FunctionName = "BeginPerfectClearEncounter" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForAllEnemiesDead" },
		{ FunctionName = "PostCombatAudio" },
		{ FunctionName = "CheckActiveObjectivesStatus" },
		{ FunctionName = "PerfectClearEncounterEndPresentation" },
		{ FunctionName = "SpawnPerfectClearRoomReward" },
	},

	EncounterEventsThanatos =
	{
		{ FunctionName = "ThanatosPreSpawnPresentation" },
		{ FunctionName = "HandleThanatosSpawn" },
		{ FunctionName = "ThanatosEncounterStartPresentation" },
		-- { FunctionName = "EncounterAudio" },
		{ FunctionName = "BeginThanatosEncounter" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForAllEnemiesDead" },
		{ FunctionName = "PostCombatAudio" },
		{ FunctionName = "SpawnRoomReward" },
	},

	EncounterEventsWrapping =
	{
		{ FunctionName = "WrappingEncounterStartPresentation" },
		{ FunctionName = "EncounterAudio" },
		{ FunctionName = "BeginWrappingEncounter" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForAllEnemiesDead" },
		{ FunctionName = "DisableRoomTraps" },
		{ FunctionName = "PostCombatAudio" },
		{ FunctionName = "WrappingEncounterEndPresentation" },
		{ FunctionName = "SpawnRoomReward" },
	},

	EncounterEventsTraversal =
	{
		{ FunctionName = "EncounterAudio" },
		{ FunctionName = "UnlockRoomExits" },
		{ FunctionName = "HandleTrapChains" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "PostCombatAudio" },
	},

	EncounterEventsCrawlerMiniBoss =
	{
		{ FunctionName = "EncounterAudio" },
		{ FunctionName = "HandleTrapChains" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForAllEnemiesDead" },
		{ FunctionName = "CrawlerMiniBossEndPresentation" },
		{ FunctionName = "PostCombatAudio" },
		{ FunctionName = "SpawnRoomReward" },
	},

	EncounterEventsTimeChallenge =
	{
		{ FunctionName = "ChallengeEncounterStartPresentation" },
		{ FunctionName = "EncounterAudio" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForAllEnemiesDead" },
		{ FunctionName = "PostCombatAudio" },
		{ FunctionName = "DisableRoomTraps" },
		{ FunctionName = "EndChallengeEncounter" },
	},

	EncounterEventsOnslaught =
	{
		{ FunctionName = "EncounterAudio" },
		{ FunctionName = "HandleCoverSpawns" },
		{ FunctionName = "SpawnOnslaughtObjects" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForAllEnemiesDead" },
		{ FunctionName = "PostCombatAudio" },
		{ FunctionName = "SpawnRoomReward" },
	},

	EncounterEventsHydraPhase =
	{
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForEncounterEnemiesDead" },
	},

	EncounterEventsCharonFight =
	{
		{ FunctionName = "EncounterAudio" },
		{ FunctionName = "HandleEnemySpawns" },
		{ FunctionName = "CheckForAllEnemiesDead" },
		{ FunctionName = "PostCombatAudio" },
	},

	EncounterEventsNonCombat =
	{
		{ FunctionName = "CheckConversations" },
	},

	ChallengeOptions =
	{
		"MoneyChallengeSwitch",
		"MoneyChallengeSwitch2",
		"MoneyChallengeSwitch3",

		"HealthChallengeSwitch",
		"HealthChallengeSwitch2",
		"HealthChallengeSwitch3",

		"DarknessChallengeSwitch",
		"DarknessChallengeSwitch2",
		"DarknessChallengeSwitch3",

		"GemChallengeSwitch",
		"GemChallengeSwitch2",
		"GemChallengeSwitch3",
	},
}