ConstantsData.SquelchedHermesRunCount = 5
MusicTrackData =
{
	Tartarus =
	{
		{ Name = "/Music/MusicHadesReset_MC", },
		{ Name = "/Music/MusicHadesReset2_MC", },
		{ Name = "/Music/MusicHadesReset3_MC", },
		{ Name = "/Music/MusicTartarus4_MC", },
	},
	Asphodel =
	{
		{ Name = "/Music/MusicAsphodel1_MC", },
		{ Name = "/Music/MusicAsphodel2_MC", },
		{ Name = "/Music/MusicAsphodel3_MC", },
	},
	Elysium =
	{
		{ Name = "/Music/MusicElysium1_MC", },
		{ Name = "/Music/MusicElysium2_MC", },
		{ Name = "/Music/MusicElysium3_MC", },
	},
	Styx =
	{
		{ Name = "/Music/MusicStyx1_MC", },
	},
}

MusicPlayerTrackData =
{
	BaseMusicTrack =
	{
		DebugOnly = true,
		ResourceName = "SuperGems",
		-- ResourceCost = 1,
		Icon = "Cosmetic_MusicTrack",
		DeathAreaFocusId = 424035,
		PanDuration = 2.5,
		PreActivationHoldDuration = 2,
		PostActivationHoldDuration = 1.3,
		UsePanSound = true,
		SkipFade = true,
		UseItemActivationVfx = true,
		RevealGlobalVoiceLines = "MusicPurchaseResponseVoiceLines",
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
		},
	},
	["/Music/MusicPlayer/MainThemeMusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		-- ResourceCost = 1,
	},
	["/Music/MusicPlayer/MusicExploration4MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		-- ResourceCost = 5,
	},
	["/Music/MusicPlayer/HadesThemeMusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 1,
	},
	["/Music/MusicPlayer/MusicHadesResetMusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 2,
	},
	["/Music/MusicPlayer/MusicHadesReset2MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 2,
	},
	["/Music/MusicPlayer/MusicHadesReset3MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 2,
	},
	["/Music/MusicPlayer/MusicTartarus4MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 2,
	},
	["/Music/MusicPlayer/MusicAsphodel1MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredSeenRooms = { "B_Intro" },
		},
	},
	["/Music/MusicPlayer/MusicAsphodel2MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredSeenRooms = { "B_Intro" },
		},
	},
	["/Music/MusicPlayer/MusicAsphodel3MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredSeenRooms = { "B_Intro" },
		},
	},
	["/Music/MusicPlayer/MusicElysium1MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredSeenRooms = { "C_Intro" },
		},
	},
	["/Music/MusicPlayer/MusicElysium2MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredSeenRooms = { "C_Intro" },
		},
	},
	["/Music/MusicPlayer/MusicElysium3MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredSeenRooms = { "C_Intro" },
		},
	},	
	["/Music/MusicPlayer/MusicStyx1MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredSeenRooms = { "D_Hub" },
		},
	},
	["/Music/MusicPlayer/BossFightMusicMusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 4,
		LockedTextId = "MusicPlayerHiddenTrack",
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredSeenRooms = { "D_Boss01" },
		},
	},
	["/Music/MusicPlayer/CharonShopThemeMusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 1,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredSeenRooms = { "D_Boss01" },
		},
	},
	["/Music/MusicPlayer/CharonFightThemeMusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 3,
		LockedTextId = "MusicPlayerHiddenTrack",
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredSeenRooms = { "CharonFight01" },
		},
	},
	["/Music/MusicPlayer/ChaosThemeMusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredTextLines = { "ChaosFirstPickUp" },
		},
	},
	["/Music/MusicPlayer/ThanatosThemeMusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredTextLines = { "ThanatosFirstAppearance" },
		},
	},
	["/Music/MusicPlayer/MusicExploration1MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 1,
	},
	["/Music/MusicPlayer/MusicExploration2MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 1,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredSeenRooms = { "B_Wrapping01" },
		},
	},
	["/Music/MusicPlayer/MusicExploration3MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredSeenRooms = { "C_Story01" },
		},
	},
	["/Music/MusicPlayer/OrpheusSong1MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 3,
		LockedTextId = "MusicPlayerHiddenTrack",
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredAnyTextLines = { "OrpheusSingsAgain01", "OrpheusSingsAgain01_B", "OrpheusSingsAgain01_C", "OrpheusSingsAgain01_D" },
		},
	},
	["/Music/MusicPlayer/OrpheusSong2MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 4,
		LockedTextId = "MusicPlayerHiddenTrack",
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredTextLines = { "OrpheusSingsAgain02" },
		},
	},
	["/Music/MusicPlayer/EurydiceSong1MusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 3,
		LockedTextId = "MusicPlayerHiddenTrack",
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredAnyTextLines = { "OrpheusSingsAgain03", "OrpheusSingsAgain03_B" },
		},
	},
	["/Music/MusicPlayer/PersephoneThemeMusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 4,
		LockedTextId = "MusicPlayerHiddenTrack",
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredTextLines = { "PersephoneFirstMeeting" },
		},
	},	
	["/Music/MusicPlayer/EndThemeMusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 5,
		LockedTextId = "MusicPlayerHiddenTrack",
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredTextLines = { "Ending01" },
		},
	},
	["/Music/MusicPlayer/TheUnseenOnesMusicPlayer"] =
	{
		InheritFrom = { "BaseMusicTrack", },
		ResourceCost = 5,
		LockedTextId = "MusicPlayerHiddenTrack",
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_MusicPlayer", },
			RequiredTextLines = { "LordHadesExtremeMeasures01" },
		},
	},
}

MusicPlayerTrackOrderData =
{
	"/Music/MusicPlayer/MainThemeMusicPlayer",
	"/Music/MusicPlayer/MusicExploration4MusicPlayer",
	"/Music/MusicPlayer/HadesThemeMusicPlayer",
	"/Music/MusicPlayer/MusicHadesResetMusicPlayer",
	"/Music/MusicPlayer/MusicHadesReset2MusicPlayer",
	"/Music/MusicPlayer/MusicHadesReset3MusicPlayer",
	"/Music/MusicPlayer/MusicTartarus4MusicPlayer",
	"/Music/MusicPlayer/MusicAsphodel1MusicPlayer",
	"/Music/MusicPlayer/MusicAsphodel2MusicPlayer",
	"/Music/MusicPlayer/MusicAsphodel3MusicPlayer",
	"/Music/MusicPlayer/MusicElysium1MusicPlayer",
	"/Music/MusicPlayer/MusicElysium2MusicPlayer",
	"/Music/MusicPlayer/MusicElysium3MusicPlayer",
	"/Music/MusicPlayer/MusicStyx1MusicPlayer",
	"/Music/MusicPlayer/ChaosThemeMusicPlayer",
	"/Music/MusicPlayer/ThanatosThemeMusicPlayer",
	"/Music/MusicPlayer/MusicExploration1MusicPlayer",
	"/Music/MusicPlayer/MusicExploration2MusicPlayer",
	"/Music/MusicPlayer/MusicExploration3MusicPlayer",
	"/Music/MusicPlayer/CharonShopThemeMusicPlayer",
	"/Music/MusicPlayer/CharonFightThemeMusicPlayer",
	"/Music/MusicPlayer/EurydiceSong1MusicPlayer",
	"/Music/MusicPlayer/OrpheusSong1MusicPlayer",
	"/Music/MusicPlayer/OrpheusSong2MusicPlayer",
	"/Music/MusicPlayer/BossFightMusicMusicPlayer",
	"/Music/MusicPlayer/TheUnseenOnesMusicPlayer",
	"/Music/MusicPlayer/PersephoneThemeMusicPlayer",
	"/Music/MusicPlayer/EndThemeMusicPlayer",
}

RoomStartMusicEvents =
{
	{
		GameStateRequirements =
		{
			RequiresInRun = true,
			RequiredRunDepth = 2,
		},
		MusicSection = 2,
	},
	{
		GameStateRequirements =
		{
			RequiresInRun = true,
			RequiredRunDepth = 3,
		},
		MusicSection = 3,
	},
	{
		GameStateRequirements =
		{
			RequiresInRun = true,
			RequiredMusicSection = 0,
			RequiredMusicSectionRoomDuration = 2,
			RequiredFalseBiome = "Styx",
		},
		MusicSection = 1,
	},
	{
		GameStateRequirements =
		{
			RequiresInRun = true,
			RequiresNullMusicId = true,
			RequiresNullSecretMusicId = true,
			RequiredFalseRooms = { "B_Wrapping01", "B_Intro", "C_Intro", "D_Intro", "A_Reprieve01", "B_Reprieve01", "C_Reprieve01", "D_Reprieve01", "B_Story01", },
		},
		PlayBiomeMusic = true,
		MusicSection = 0,
		UseRoomMusicSection = true,
	},
}

CombatOverMusicEvents =
{
	{
		GameStateRequirements =
		{
			RequiredMinDepth = 3,
			RequiredMusicName = "/Music/MusicExploration4_MC",
		},
		EndMusic = true,
	},
	{
		GameStateRequirements =
		{
			RequiredFalseRooms = { "D_Mini01", "D_Mini02", "D_Mini03", "D_Mini04", "D_Mini05", "D_Mini06", "D_Mini07", "D_Mini08", "D_Mini09", "D_Mini10", "D_Mini11", "D_Mini12", "D_Mini13", "D_Mini14", }
		},
		MusicMutedStems = { "Drums", },
	},
}

AmbienceTracks =
{
	Tartarus =
	{
		{ Name = "/Leftovers/Object Ambiences/EvilLairAmbienceMatchSiteE", ReverbValue = 2.0 },
	},
	Asphodel =
	{
		{ Name = "/Leftovers/Object Ambiences/LavaAmbience_MatchSiteB", ReverbValue = 1.0 },
	},
	Elysium =
	{
		{ Name = "/Ambience/ElysiumAmbientLoop", ReverbValue = 1.5 },
	},
	Styx =
	{
		{ Name = "/Leftovers/Object Ambiences/CreepyIslandAmbience", ReverbValue = 2.0 },
	},
}

-- **VO: Misc. Global Voice Lines**
GlobalVoiceLines = GlobalVoiceLines or {}
GlobalVoiceLines.ResumePreviousRunLines_Old =
{
	{
		RandomRemaining = true,

		-- Let us continue then our tale from before.
		{ Cue = "/VO/Storyteller_0111", PreLineWait = 0.8 },

		-- Let us sing more then of the champion of the gods.
		{ Cue = "/VO/Storyteller_0112", PreLineWait = 0.8 },
	},
}
GlobalVoiceLines.CombatBeginsVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceThisRun = true,
		RequiredBiome = "Styx",
		RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "BossHarpy1", "BossHarpy2", "BossHarpy3", "BossHydra", "MiniBossMinotaur", "BossTheseusAndMinotaur", "BossHades", "BossHadesPeaceful", "BossCharon", "EnemyIntroFight01", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "GeneratedStyxMini", "GeneratedStyxMiniSingle" },
		RequiredEncounterActiveEnemyCapMin = 2,
		CooldownName = "CombatBeginsLinesPlayedRecently",
		CooldownTime = 500,
		SuccessiveChanceToPlay = 0.25,
		PreLineWait = 2.0,

		-- Am I interrupting something?
		{ Cue = "/VO/ZagreusField_2378" },
		-- Anyone seen a Satyr sack?
		{ Cue = "/VO/ZagreusField_2379", RequiredTextLines = { "CerberusBossDoorUnlock01" }, RequiredFalseSeenRoomThisRun = "D_Reprieve01", },
		-- You know you're tresspassing on private property!
		{ Cue = "/VO/ZagreusField_2380" },
		-- What are you doing to this place?
		{ Cue = "/VO/ZagreusField_2381" },
		-- All right, break it up!
		{ Cue = "/VO/ZagreusField_2382" },
		-- Look what you've done to this place!
		{ Cue = "/VO/ZagreusField_2383" },
		-- This place is a mess!
		{ Cue = "/VO/ZagreusField_2384" },
		-- Found one of their dens.
		{ Cue = "/VO/ZagreusField_2385" },
		-- It's one of their dens.
		{ Cue = "/VO/ZagreusField_2386" },
		-- Dead end, huh?
		{ Cue = "/VO/ZagreusField_2387" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceThisRun = true,
		RequiredBiome = "Styx",
		RequiredEncounters = { "GeneratedStyxMini", "GeneratedStyxMiniSingle" },
		RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "BossHarpy1", "BossHarpy2", "BossHarpy3", "BossHydra", "MiniBossMinotaur", "BossTheseusAndMinotaur", "BossHades", "BossCharon", "EnemyIntroFight01", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", },
		RequiredEncounterActiveEnemyCapMin = 2,
		CooldownName = "CombatBeginsLinesPlayedRecently",
		CooldownTime = 500,
		SuccessiveChanceToPlay = 0.85,
		PlayOnceFromTableThisRun = true,
		PreLineWait = 0.6,

		-- Aah!
		{ Cue = "/VO/ZagreusField_2455" },
		-- Whoa!
		{ Cue = "/VO/ZagreusField_2456" },
		-- Hey!
		{ Cue = "/VO/ZagreusField_2457" },
		-- Hello!
		{ Cue = "/VO/ZagreusField_2458" },
		-- Hi!
		{ Cue = "/VO/ZagreusField_2459" },
		-- Tsk.
		{ Cue = "/VO/ZagreusField_2460" },
		-- You!
		{ Cue = "/VO/ZagreusField_2461" },
		-- Wha-?
		{ Cue = "/VO/ZagreusField_2462" },
		-- Nrgh!
		{ Cue = "/VO/ZagreusField_2463" },
		-- Gah.
		{ Cue = "/VO/ZagreusField_2464" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceThisRun = true,
		RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "BossHarpy1", "BossHarpy2", "BossHarpy3", "BossHydra", "MiniBossMinotaur", "BossTheseusAndMinotaur", "BossHades", "BossCharon", "EnemyIntroFight01", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "ThiefMineLayerIntro", "HeavyRangedIntro", "PunchingBagIntro", "LightSpawnerIntro", "DisembodiedHandIntro", "SpreadShotIntro", "ShieldRangedIntro", "CrusherIntro", "FreezeShotIntro", "RangedBurrowerIntro", "BerserkerIntro", "WaveFistIntro", "PitcherIntro", "SelfDestructIntro", "ShadeSwordUnitIntro", "ShadeSpearUnitIntro", "ShadeShieldUnitIntro",	"ShadeBowUnitIntro", "FlurrySpawnerUnitIntro", "ChariotIntro", "ChariotSuicideIntro"
		 },
		RequiredFalseRooms = { "RoomOpening", "D_Boss01" },
		RequiredEncounterActiveEnemyCapMin = 2,
		CooldownName = "CombatBeginsLinesPlayedRecently",
		CooldownTime = 500,
		SuccessiveChanceToPlay = 0.2,
		PreLineWait = 2.0,

		-- Stand aside.
		{ Cue = "/VO/ZagreusField_0014" },
		-- Damn you.
		{ Cue = "/VO/ZagreusField_0016" },
		-- You want to die again?
		{ Cue = "/VO/ZagreusField_0018", RequiredFalseBiome = "Styx" },
		-- Out of my way.
		{ Cue = "/VO/ZagreusField_0020" },
		-- Come try me.
		{ Cue = "/VO/ZagreusField_0022" },
		-- Stand down, or suffer.
		{ Cue = "/VO/ZagreusField_0024" },
		-- Come on, then.
		{ Cue = "/VO/ZagreusField_0026" },
		-- How do you do.
		{ Cue = "/VO/ZagreusField_0028" },
		-- You again.
		{ Cue = "/VO/ZagreusField_0030", RequiredMinCompletedRuns = 30, RequiredMinRunsCleared = 1, },
		-- What now.
		{ Cue = "/VO/ZagreusField_0316" },
		-- Look who.
		{ Cue = "/VO/ZagreusField_0318" },
		-- Hello mates.
		{ Cue = "/VO/ZagreusField_0320", CooldownName = "SaidHelloRecently", CooldownTime = 80 },
		-- Surprise.
		{ Cue = "/VO/ZagreusField_0322" },
		-- Come and get it.
		{ Cue = "/VO/ZagreusField_0571" },
		-- You wretches.
		{ Cue = "/VO/ZagreusField_0573", RequiredFalseBiome = "Elysium" },
		-- What is it now.
		{ Cue = "/VO/ZagreusField_0575" },
		-- Oh hello.
		{ Cue = "/VO/ZagreusField_0577", CooldownName = "SaidHelloRecently", CooldownTime = 80 },
		-- May I help you?
		{ Cue = "/VO/ZagreusField_0579" },
		-- Want to fight?
		{ Cue = "/VO/ZagreusField_0581" },
		-- Do not mess with me right now.
		{ Cue = "/VO/ZagreusField_0583" },
		-- Am I interrupting something?
		{ Cue = "/VO/ZagreusField_0585" },
		-- Now let's be reasonable, no...?
		{ Cue = "/VO/ZagreusField_0587" },
		-- You can't stop me.
		{ Cue = "/VO/ZagreusField_0589", CooldownName = "SaidStopRecently", CooldownTime = 80 },
		-- Come.
		{ Cue = "/VO/ZagreusField_0591" },
		-- All right who's next?
		{ Cue = "/VO/ZagreusField_1833" },
		-- More trouble.
		{ Cue = "/VO/ZagreusField_1835" },
		-- Hi there!
		{ Cue = "/VO/ZagreusField_1837" },
		-- Who's first?
		{ Cue = "/VO/ZagreusField_1839" },
		-- Think you can stop me?
		{ Cue = "/VO/ZagreusField_1841", CooldownName = "SaidStopRecently", CooldownTime = 60 },
		-- Ready for me?
		{ Cue = "/VO/ZagreusField_1843" },
		-- Don't get in my way.
		{ Cue = "/VO/ZagreusField_1845" },
		-- Coming through!
		{ Cue = "/VO/ZagreusField_1847" },
		-- Fight me!
		{ Cue = "/VO/ZagreusField_1850" },
		-- Who dies first?
		{ Cue = "/VO/ZagreusField_3262" },
		-- Here I am.
		{ Cue = "/VO/ZagreusField_3263" },
		-- Come on, let's fight.
		{ Cue = "/VO/ZagreusField_3264" },
		-- Let's fight!
		{ Cue = "/VO/ZagreusField_3265" },
		-- Over here!
		{ Cue = "/VO/ZagreusField_3266" },
		-- Blasted wretches.
		{ Cue = "/VO/ZagreusField_3267", RequiredBiome = "Tartarus" },
		-- Come on!
		{ Cue = "/VO/ZagreusField_3268" },
		-- Come on, you!
		{ Cue = "/VO/ZagreusField_3269" },
		-- I'll be leaving shortly.
		{ Cue = "/VO/ZagreusField_3270" },
		-- I'll destroy you.
		{ Cue = "/VO/ZagreusField_3271" },
		-- Time to fight.
		{ Cue = "/VO/ZagreusField_3272" },
		-- Let's see how quickly I can slay you all.
		{ Cue = "/VO/ZagreusField_3273" },
	},
}
GlobalVoiceLines.CombatResolvedVoiceLines =
{
	{
		RandomRemaining = true,
		PlayOnceThisRun = true,
		PreLineWait = 1.0,
		RequiredFalseRooms = { "RoomSimple01" },
		ThreadName = "RoomThread",
		CooldownTime = 300,

		-- You should've listened.
		{ Cue = "/VO/ZagreusField_0015", RequiredPlayedThisRoom = { "/VO/ZagreusField_0014" }, },
		-- Don't cross me again.
		{ Cue = "/VO/ZagreusField_0017", RequiredPlayedThisRoom = { "/VO/ZagreusField_0016" }, },
		-- You had it coming.
		{ Cue = "/VO/ZagreusField_0019", RequiredPlayedThisRoom = { "/VO/ZagreusField_0018" }, },
		-- You can't stop me.
		{ Cue = "/VO/ZagreusField_0021", RequiredPlayedThisRoom = { "/VO/ZagreusField_0020" }, },
		-- Stupid fools.
		{ Cue = "/VO/ZagreusField_0023", RequiredPlayedThisRoom = { "/VO/ZagreusField_0022" }, },
		-- You shouldn'tve crossed me.
		{ Cue = "/VO/ZagreusField_0025", RequiredPlayedThisRoom = { "/VO/ZagreusField_0024" }, },
		-- Pathetic.
		{ Cue = "/VO/ZagreusField_0027", RequiredPlayedThisRoom = { "/VO/ZagreusField_0026" }, },
		-- Nice meeting you.
		{ Cue = "/VO/ZagreusField_0029", RequiredPlayedThisRoom = { "/VO/ZagreusField_0028" }, },
		-- Enough.
		{ Cue = "/VO/ZagreusField_0317", RequiredPlayedThisRoom = { "/VO/ZagreusField_0316" }, },
		-- Always a pleasure.
		{ Cue = "/VO/ZagreusField_0319", RequiredPlayedThisRoom = { "/VO/ZagreusField_0318" }, },
		-- Have a nice death.
		{ Cue = "/VO/ZagreusField_0321", RequiredPlayedThisRoom = { "/VO/ZagreusField_0320" }, },
		-- So much for them.
		{ Cue = "/VO/ZagreusField_0323", RequiredPlayedThisRoom = { "/VO/ZagreusField_0322" }, },
		-- Satisfied?
		{ Cue = "/VO/ZagreusField_0572", RequiredPlayedThisRoom = { "/VO/ZagreusField_0571" }, },
		-- Suffer in darkness.
		{ Cue = "/VO/ZagreusField_0574", RequiredPlayedThisRoom = { "/VO/ZagreusField_0573" }, },
		-- Will that be all?
		{ Cue = "/VO/ZagreusField_0576", RequiredPlayedThisRoom = { "/VO/ZagreusField_0575" }, },
		-- Good-bye for now.
		{ Cue = "/VO/ZagreusField_0578", RequiredPlayedThisRoom = { "/VO/ZagreusField_0577" }, },
		-- Good riddance.
		{ Cue = "/VO/ZagreusField_0580", RequiredPlayedThisRoom = { "/VO/ZagreusField_0579" }, CooldownName = "SaidGoodRecently", CooldownTime = 40, },
		-- That's settled, then.
		{ Cue = "/VO/ZagreusField_0582", RequiredPlayedThisRoom = { "/VO/ZagreusField_0581" }, },
		-- I warned you.
		{ Cue = "/VO/ZagreusField_0584", RequiredPlayedThisRoom = { "/VO/ZagreusField_0583" }, },
		-- Didn't think so.
		{ Cue = "/VO/ZagreusField_0586", RequiredPlayedThisRoom = { "/VO/ZagreusField_0585" }, },
		-- Was that really necessary?
		{ Cue = "/VO/ZagreusField_0588", RequiredPlayedThisRoom = { "/VO/ZagreusField_0587" }, },
		-- What did I tell you.
		{ Cue = "/VO/ZagreusField_0590", RequiredPlayedThisRoom = { "/VO/ZagreusField_0589" }, },
		-- Simple.
		{ Cue = "/VO/ZagreusField_0592", RequiredPlayedThisRoom = { "/VO/ZagreusField_0591" }, },
		-- That's everyone.
		{ Cue = "/VO/ZagreusField_1834", RequiredPlayedThisRoom = { "/VO/ZagreusField_1833" }, },
		-- Problem solved.
		{ Cue = "/VO/ZagreusField_1836", RequiredPlayedThisRoom = { "/VO/ZagreusField_1835" }, },
		-- Bye now.
		{ Cue = "/VO/ZagreusField_1838", RequiredPlayedThisRoom = { "/VO/ZagreusField_1837" }, },
		-- Saved some for everyone.
		{ Cue = "/VO/ZagreusField_1840", RequiredPlayedThisRoom = { "/VO/ZagreusField_1839" }, },
		-- You had no chance.
		{ Cue = "/VO/ZagreusField_1842", RequiredPlayedThisRoom = { "/VO/ZagreusField_1841" }, },
		-- No problem.
		{ Cue = "/VO/ZagreusField_1844", RequiredPlayedThisRoom = { "/VO/ZagreusField_1843" }, },
		-- Enough.
		{ Cue = "/VO/ZagreusField_1846" , RequiredPlayedThisRoom = { "/VO/ZagreusField_1845" }, },
		-- Pardon me.
		{ Cue = "/VO/ZagreusField_1848", RequiredPlayedThisRoom = { "/VO/ZagreusField_1847" }, },
		-- Dead to the last.
		{ Cue = "/VO/ZagreusField_1851", RequiredPlayedThisRoom = { "/VO/ZagreusField_1850" }, },
		-- That's the last of them.
		{ Cue = "/VO/ZagreusField_3274", RequiredPlayedThisRoom = { "/VO/ZagreusField_3262" }, },
		-- Last one standing.
		{ Cue = "/VO/ZagreusField_3275", RequiredPlayedThisRoom = { "/VO/ZagreusField_3263" }, },
		-- That'll do.
		{ Cue = "/VO/ZagreusField_3276", RequiredPlayedThisRoom = { "/VO/ZagreusField_3264" }, },
		-- That'll do it.
		{ Cue = "/VO/ZagreusField_3277", RequiredPlayedThisRoom = { "/VO/ZagreusField_3265" }, },
		-- They're gone.
		{ Cue = "/VO/ZagreusField_3278", RequiredPlayedThisRoom = { "/VO/ZagreusField_3266" }, },
		-- Enjoy your death.
		{ Cue = "/VO/ZagreusField_3279", RequiredPlayedThisRoom = { "/VO/ZagreusField_3267" }, },
		-- They're finished.
		{ Cue = "/VO/ZagreusField_3280", RequiredPlayedThisRoom = { "/VO/ZagreusField_3268" }, },
		-- Got them.
		{ Cue = "/VO/ZagreusField_3281", RequiredPlayedThisRoom = { "/VO/ZagreusField_3269" }, },
		-- Time to go, then.
		{ Cue = "/VO/ZagreusField_3282", RequiredPlayedThisRoom = { "/VO/ZagreusField_3270" }, },
		-- Destroyed as promised.
		{ Cue = "/VO/ZagreusField_3283", RequiredPlayedThisRoom = { "/VO/ZagreusField_3271" }, },
		-- Their time's up.
		{ Cue = "/VO/ZagreusField_3284", RequiredPlayedThisRoom = { "/VO/ZagreusField_3272" }, },
		-- Short work.
		{ Cue = "/VO/ZagreusField_3285", RequiredPlayedThisRoom = { "/VO/ZagreusField_3273" }, },
	},
	-- SkellySummonTrait
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceThisRun = true,
			PreLineWait = 1.8,
			ThreadName = "RoomThread",
			ObjectType = "TrainingMeleeSummon",

			-- Well this is awkward.
			{ Cue = "/VO/Skelly_0350" },
			-- Hey, nice.
			{ Cue = "/VO/Skelly_0351" },
			-- You did it!
			{ Cue = "/VO/Skelly_0352" },
			-- Nice work there pal.
			{ Cue = "/VO/Skelly_0353" },
			-- Well my work here is done.
			{ Cue = "/VO/Skelly_0354" },
			-- You showed them, pal!
			{ Cue = "/VO/Skelly_0355" },
			-- Well that's a wrap.
			{ Cue = "/VO/Skelly_0356" },
			-- Done and done!
			{ Cue = "/VO/Skelly_0357" },
			-- Well see you!
			{ Cue = "/VO/Skelly_0358", CooldownName = "SaidSeeYouRecently", CooldownTime = 40 },
			-- Well better go!
			{ Cue = "/VO/Skelly_0359" },
			-- How am I supposed to get back?
			{ Cue = "/VO/Skelly_0095" },
		},
	},
	-- DusaSummonTrait
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceThisRun = true,
		PreLineWait = 1.3,
		ThreadName = "RoomThread",
		ObjectType = "DusaSummon",
		Cooldowns =
		{
			{ Name = "DusaAnyQuipSpeech", Time = 4 },
		},

		-- You did it!!
		{ Cue = "/VO/Dusa_0339" },
		-- Yay, you did it!
		{ Cue = "/VO/Dusa_0340" },
		-- Woo-hoo!
		{ Cue = "/VO/Dusa_0341" },
		-- I knew you could do it!
		{ Cue = "/VO/Dusa_0342" },
		-- Great work, Prince!
		{ Cue = "/VO/Dusa_0343" },
		-- Well that was exciting!
		{ Cue = "/VO/Dusa_0344" },
		-- Whew, you made it!
		{ Cue = "/VO/Dusa_0345" },
		-- All right, this place is clean!
		{ Cue = "/VO/Dusa_0346" },
		-- That's one less problem, right?
		{ Cue = "/VO/Dusa_0347" },
		-- You showed them, Prince!
		{ Cue = "/VO/Dusa_0348" },
		-- That's what you get!!
		{ Cue = "/VO/Dusa_0349" },
		-- Don't mess with Zagreus!!
		{ Cue = "/VO/Dusa_0350" },
		-- Hah, take that!
		{ Cue = "/VO/Dusa_0351" },
	},
}
GlobalVoiceLines.CombatResolvedLowHealthVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PlayOnceFromTableThisRun = true,
	ChanceToPlay = 0.33,
	PreLineWait = 1.0,
	RequiredFalseRooms = { "RoomSimple01", "A_Boss01", "A_Boss02", "A_Boss03", "B_Boss01", "B_Boss02", "C_Boss01", "D_Boss01" },

	-- That was close.
	{ Cue = "/VO/ZagreusField_0652" },
	-- I should keep going.
	{ Cue = "/VO/ZagreusField_0031" },
	-- I should press on.
	{ Cue = "/VO/ZagreusField_0032" },
	-- I should go.
	{ Cue = "/VO/ZagreusField_0033a" },
	-- Nothing left here.
	{ Cue = "/VO/ZagreusField_0034" },
	-- Need to press on.
	{ Cue = "/VO/ZagreusField_0666" },
	-- Took a bite out of me there.
	{ Cue = "/VO/ZagreusField_0667" },
	-- Nearly got me.
	{ Cue = "/VO/ZagreusField_0668" },
	-- Uh that hurt.
	{ Cue = "/VO/ZagreusField_0669" },
	-- Almost had me.
	{ Cue = "/VO/ZagreusField_0670" },
	-- Barely made it.
	{ Cue = "/VO/ZagreusField_0671" },
	-- Barely got through.
	{ Cue = "/VO/ZagreusField_0672" },
	-- Unghh...
	{ Cue = "/VO/ZagreusField_0673" },
}

-- item interaction lines
GlobalVoiceLines.UsedHealDropVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.55,
	SuccessiveChanceToPlay = 0.5,
	RequiredFalseRooms = { "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },
	Cooldowns =
	{
		{ Name = "ZagreusAnyQuipSpeech" },
		{ Name = "HadesPostBossCooldown", Time = 30 },
	},

	-- That's better.
	{ Cue = "/VO/ZagreusField_0133", RequiredKillEnemiesNotFound = true, },
	-- Hmm.
	{ Cue = "/VO/ZagreusField_0134", },
	-- Good.
	{ Cue = "/VO/ZagreusField_0135", CooldownName = "SaidGoodRecently", CooldownTime = 40, },
	-- That's a relief.
	{ Cue = "/VO/ZagreusField_0299", RequiredKillEnemiesNotFound = true, },
	-- Much better.
	{ Cue = "/VO/ZagreusField_0300", RequiredKillEnemiesNotFound = true, },
	-- Mmph.
	{ Cue = "/VO/ZagreusField_0302", },
	-- Whew...
	{ Cue = "/VO/ZagreusField_0303", RequiredKillEnemiesNotFound = true, CooldownName = "SaidWhewRecently", CooldownTime = 30 },
	-- Mmm.
	{ Cue = "/VO/ZagreusField_0370", },
	-- Mm-hmm.
	{ Cue = "/VO/ZagreusField_0371", RequiredKillEnemiesNotFound = true, },
	-- Hit the spot.
	{ Cue = "/VO/ZagreusField_0372", RequiredKillEnemiesNotFound = true, },
	-- Yum.
	{ Cue = "/VO/ZagreusField_0373", RequiredKillEnemiesNotFound = true, },
	-- Five-second rule. That was five seconds right?
	{ Cue = "/VO/ZagreusField_0735", SuccessiveChanceToPlay = 0.02, PreLineWait = 0.55, RequiredFalseEncounters = { "Shop" }, RequiredKillEnemiesNotFound = true, RequiredFalseScreenOpen = "Store" },
}
GlobalVoiceLines.FabulousWealthVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	CooldownTime = 10,

	-- I'm rich!
	{ Cue = "/VO/ZagreusField_0659", },
}
GlobalVoiceLines.UsedMoneyDropVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	CooldownName = "HadesPostBossCooldown",
	CooldownTime = 100,
	RequiredFalseEncounters = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro" },

	-- I bet Charon's going to want all this.
	{ Cue = "/VO/ZagreusField_0739", },
	-- Nice.
	{ Cue = "/VO/ZagreusField_0229", },
	-- Excellent.
	{ Cue = "/VO/ZagreusField_0230", },
	-- Good enough.
	{ Cue = "/VO/ZagreusField_0231", },
	-- I'll take it.
	{ Cue = "/VO/ZagreusField_0232", },
	-- I'm rich!
	{ Cue = "/VO/ZagreusField_0659", },
	-- Vast riches.
	{ Cue = "/VO/ZagreusField_0660", },
	-- Coin for Charon.
	{ Cue = "/VO/ZagreusField_0661", },
	-- Should fetch me something.
	{ Cue = "/VO/ZagreusField_0662", },
	-- I'll just take that.
	{ Cue = "/VO/ZagreusField_0663", },
	-- Father won't miss a couple coins.
	{ Cue = "/VO/ZagreusField_0664", },
	-- Shiny.
	{ Cue = "/VO/ZagreusField_0665", },
}
GlobalVoiceLines.PurchasedDiscountedItemVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.45,
	PlayOnceFromTableThisRun = true,
	SuccessiveChanceToPlay = 0.75,
	RequiredTrait = "DiscountTrait",

	-- Special rate!
	{ Cue = "/VO/ZagreusField_4088" },
	-- What a deal!
	{ Cue = "/VO/ZagreusField_4089" },
	-- Great price!
	{ Cue = "/VO/ZagreusField_4090" },
	-- What a steal!
	{ Cue = "/VO/ZagreusField_4091" },
	-- What a steal! Borrow!
	{ Cue = "/VO/ZagreusField_4092", RequiredPlayed = { "/VO/ZagreusField_4091" }, SuccessiveChanceToPlay = 0.05 },
	-- Sale price!
	{ Cue = "/VO/ZagreusField_4093" },
	-- Membership has its perks!
	{ Cue = "/VO/ZagreusField_4094" },
	-- Cheers for the discount.
	{ Cue = "/VO/ZagreusField_4095" },
}
GlobalVoiceLines.PurchasedRandomItemVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.45,
	PlayOnceFromTableThisRun = true,
	SuccessiveChanceToPlay = 0.75,

	-- What do I get?
	{ Cue = "/VO/ZagreusField_1136" },

}

GlobalVoiceLines.PurchasedConsumableVoiceLines =
{
	{
		[1] = GlobalVoiceLines.PurchasedDiscountedItemVoiceLines,
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		CooldownTime = 30,

		-- Thank you, mate.
		{ Cue = "/VO/ZagreusField_0179" },
		-- Always a pleasure, Charon.
		{ Cue = "/VO/ZagreusField_0180", CooldownName = "MentionedCharon", CooldownTime = 40, RequiredFalsePlayedThisRoom = { "/VO/ZagreusField_0759" } },
		-- Don't spend it all in one place, mate.
		{ Cue = "/VO/ZagreusField_0181" },
		-- Pleasure doing business.
		{ Cue = "/VO/ZagreusField_0182" },
		-- Should come in useful.
		{ Cue = "/VO/ZagreusField_0483", CooldownName = "SaidUsefulRecently", CooldownTime = 40 },
		-- I could use this.
		{ Cue = "/VO/ZagreusField_0484" },
		-- Cheers, mate.
		{ Cue = "/VO/ZagreusField_0485" },
		-- I'll take it.
		{ Cue = "/VO/ZagreusField_0486" },
		-- Why not.
		{ Cue = "/VO/ZagreusField_0487" },
		-- Here's the fee.
		{ Cue = "/VO/ZagreusField_0488" },
		-- Just what I need.
		{ Cue = "/VO/ZagreusField_0489" },
		-- Should be useful.
		{ Cue = "/VO/ZagreusField_0871", CooldownName = "SaidUsefulRecently", CooldownTime = 40 },
		-- I'll pay for that.
		{ Cue = "/VO/ZagreusField_0874" },
		-- Should help keep me going.
		{ Cue = "/VO/ZagreusField_0875", RequiredFalseBiome = "Styx" },
		-- I'll take this one.
		{ Cue = "/VO/ZagreusField_0877" },
	},
}
GlobalVoiceLines.PurchasedWellShopItemVoiceLines =
{
	{
		[1] = GlobalVoiceLines.PurchasedDiscountedItemVoiceLines,
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		CooldownTime = 30,
		SuccessiveChanceToPlay = 0.33,

		-- Should come in useful.
		{ Cue = "/VO/ZagreusField_0483" },
		-- I could use this.
		{ Cue = "/VO/ZagreusField_0484" },
		-- I'll take it.
		{ Cue = "/VO/ZagreusField_0486" },
		-- Why not.
		{ Cue = "/VO/ZagreusField_0487" },
		-- Just what I need.
		{ Cue = "/VO/ZagreusField_0489" },
		-- Should be useful.
		{ Cue = "/VO/ZagreusField_0871" },
		-- I'll just take this one.
		{ Cue = "/VO/ZagreusField_0872" },
		-- Coin goes in, that comes out.
		{ Cue = "/VO/ZagreusField_0873", SuccessiveChanceToPlay = 0.02 },
		-- I'll pay for that.
		{ Cue = "/VO/ZagreusField_0874" },
		-- Should help keep me going.
		{ Cue = "/VO/ZagreusField_0875" },
		-- Payment in full.
		{ Cue = "/VO/ZagreusField_0876" },
		-- I'll take this one.
		{ Cue = "/VO/ZagreusField_0877" },
		-- Bought.
		{ Cue = "/VO/ZagreusField_4061" },
		-- I'll take that.
		{ Cue = "/VO/ZagreusField_4062" },
		-- Should be handy.
		{ Cue = "/VO/ZagreusField_4063" },
		-- Here, then.
		{ Cue = "/VO/ZagreusField_4064" },
		-- This one.
		{ Cue = "/VO/ZagreusField_4065" },
		-- That one.
		{ Cue = "/VO/ZagreusField_4066" },
		-- Gimme.
		{ Cue = "/VO/ZagreusField_4067" },
		-- Looks handy.
		{ Cue = "/VO/ZagreusField_4068" },
		-- Worth it.
		{ Cue = "/VO/ZagreusField_4069" },
		-- Sold.
		{ Cue = "/VO/ZagreusField_4070" },
		-- This ought to help for sure.
		{ Cue = "/VO/ZagreusField_4419" },
		-- Worth it.
		{ Cue = "/VO/ZagreusField_4420" },
	},
}
GlobalVoiceLines.PurchasedRandomPomVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.45,

	-- Mm, got stronger there.
	{ Cue = "/VO/ZagreusField_3790" },
	-- Tart and tasty!
	{ Cue = "/VO/ZagreusField_3791" },
	-- Boosted a Boon.
	{ Cue = "/VO/ZagreusField_3792" },
	-- One of my Boons got stronger.
	{ Cue = "/VO/ZagreusField_3793" },
	-- Always hits the spot.
	{ Cue = "/VO/ZagreusField_3794" },
	-- That Boon got better, huh.
	{ Cue = "/VO/ZagreusField_3795", PreLineWait = 1.33 },
	-- Give me a better Boon.
	{ Cue = "/VO/ZagreusField_3796" },
	-- Which Boon's it going to be.
	{ Cue = "/VO/ZagreusField_3797" },
}
GlobalVoiceLines.PurchasedChaosWeaponUpgradeVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.33,

	-- Let's mix things up, Daedalus.
	{ Cue = "/VO/ZagreusField_3782" },
	-- What's it going to be?
	{ Cue = "/VO/ZagreusField_3783" },
	-- Time to mess with my weapon.
	{ Cue = "/VO/ZagreusField_3784" },
	-- Hit me, Daedalus.
	{ Cue = "/VO/ZagreusField_3785" },
	-- Random enchantments.
	{ Cue = "/VO/ZagreusField_3786" },
	-- Surprise me, Daedalus.
	{ Cue = "/VO/ZagreusField_3787" },
	-- Let's take our chances then.
	{ Cue = "/VO/ZagreusField_3788" },
	-- The old Daedalus Surprise.
	{ Cue = "/VO/ZagreusField_3789", RequiredPlayed = { "/VO/ZagreusField_3782", "/VO/ZagreusField_3787" } },
}
GlobalVoiceLines.PurchasedDamageSelfDropVoicelines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.1,

	-- Ow! Money.
	{ Cue = "/VO/ZagreusField_3778" },
	-- Augh, I'm rich!
	{ Cue = "/VO/ZagreusField_3779" },
	-- Aah, wealth!
	{ Cue = "/VO/ZagreusField_3780" },
	-- Oof, extra coin!
	{ Cue = "/VO/ZagreusField_3781" },
	-- Urgh! More obols, more suffering.
	{ Cue = "/VO/ZagreusField_4676", RequiredPlayed = { "/VO/ZagreusField_3778", "/VO/ZagreusField_3779", "/VO/ZagreusField_3780", "/VO/ZagreusField_3781" }, },
}

-- resource interaction voice lines
GlobalVoiceLines.SpentMetaPointsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- Here's the Darkness.
	{ Cue = "/VO/ZagreusHome_1636" },
	-- Here's your Darkness.
	{ Cue = "/VO/ZagreusHome_1637" },
}
GlobalVoiceLines.PurchasedMetaPointsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.66,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- I'll take some Darkness.
	{ Cue = "/VO/ZagreusHome_1633" },
	-- Darkness, please.
	{ Cue = "/VO/ZagreusHome_1634" },
	-- Could use some Darkness.
	{ Cue = "/VO/ZagreusHome_1635" },
}
GlobalVoiceLines.InsufficientMetaPointsVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
		},

		-- Not enough Darkness.
		{ Cue = "/VO/ZagreusHome_1628" },
		-- Don't have enough Darkness.
		{ Cue = "/VO/ZagreusHome_1629" },
		-- I need more Darkness for that.
		{ Cue = "/VO/ZagreusHome_1630" },
		-- I don't have the Darkness.
		{ Cue = "/VO/ZagreusHome_1631" },
		-- Need more Darkness.
		{ Cue = "/VO/ZagreusHome_1632" },
	},
	[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
}

GlobalVoiceLines.SpentLockKeysVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- Here's the Keys.
	{ Cue = "/VO/ZagreusHome_1665" },
	-- Here are your Keys.
	{ Cue = "/VO/ZagreusHome_1666" },
}
GlobalVoiceLines.PurchasedLockKeysVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.66,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- Could always use more Keys.
	{ Cue = "/VO/ZagreusHome_1661" },
	-- More Keys for me.
	{ Cue = "/VO/ZagreusHome_1662" },
	-- Chthonic Keys.
	{ Cue = "/VO/ZagreusHome_1663" },
	-- Extra Keys.
	{ Cue = "/VO/ZagreusHome_1664" },
}
GlobalVoiceLines.InsufficientLockKeysVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- Need more of those keys.
	{ Cue = "/VO/ZagreusField_0910" },
	-- Don't have enough keys.
	{ Cue = "/VO/ZagreusField_0912" },
	-- Need more keys.
	{ Cue = "/VO/ZagreusField_0914" },
	-- I lack the necessary keys.
	{ Cue = "/VO/ZagreusHome_1227" },
	-- I need to track down more Chthonic Keys.
	{ Cue = "/VO/ZagreusHome_1228" },
	-- I don't have enough Chthonic Keys...
	{ Cue = "/VO/ZagreusHome_1231" },
	-- I need more Chthonic Keys for this.
	{ Cue = "/VO/ZagreusHome_1233" },
}

GlobalVoiceLines.SpentGiftPointsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- Here's the Nectar.
	{ Cue = "/VO/ZagreusHome_1671" },
	-- Here's your Nectar.
	{ Cue = "/VO/ZagreusHome_1672" },
}
GlobalVoiceLines.PurchasedGiftPointsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.75,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- I'll take the Nectar.
	{ Cue = "/VO/ZagreusHome_1667" },
	-- I'll have that Nectar.
	{ Cue = "/VO/ZagreusHome_1668" },
	-- Let's have that Nectar.
	{ Cue = "/VO/ZagreusHome_1669" },
	-- Let's see that Nectar.
	{ Cue = "/VO/ZagreusHome_1670" },
}
GlobalVoiceLines.InsufficientGiftPointsVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
		},

		-- Need some more Nectar.
		{ Cue = "/VO/ZagreusHome_1560" },
		-- Don't have enough Nectar for this.
		{ Cue = "/VO/ZagreusHome_1561" },
		-- Not enough Nectar.
		{ Cue = "/VO/ZagreusHome_1562" },
		-- Need more Nectar.
		{ Cue = "/VO/ZagreusHome_1563" },
	},
	[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
}

GlobalVoiceLines.SpentGemsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.5,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- Here's the Gemstones.
	{ Cue = "/VO/ZagreusHome_1647" },
	-- Here's the Gemstones, then.
	{ Cue = "/VO/ZagreusHome_1648" },
	-- Trade you these Gemstones.
	{ Cue = "/VO/ZagreusHome_1649" },
	-- Here are the gems.
	{ Cue = "/VO/ZagreusHome_1119" },
}
GlobalVoiceLines.PurchasedGemsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.75,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- I'll take the Gemstones.
	{ Cue = "/VO/ZagreusHome_1643" },
	-- I'll have the Gemstones.
	{ Cue = "/VO/ZagreusHome_1644" },
	-- Gemstones, please.
	{ Cue = "/VO/ZagreusHome_1645" },
	-- Go with the Gemstones.
	{ Cue = "/VO/ZagreusHome_1646" },
}
GlobalVoiceLines.InsufficientGemsVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
		},

		-- Not enough Gemstones.
		{ Cue = "/VO/ZagreusHome_1638" },
		-- Don't have enough Gemstones.
		{ Cue = "/VO/ZagreusHome_1639" },
		-- Need more Gemstones for that.
		{ Cue = "/VO/ZagreusHome_1640" },
		-- I need more Gemstones.
		{ Cue = "/VO/ZagreusHome_1641" },
		-- I'm short of Gemstones.
		{ Cue = "/VO/ZagreusHome_1642" },
	},
	[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
}

GlobalVoiceLines.SpentSuperGemsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.4,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- Your Diamonds.
	{ Cue = "/VO/ZagreusHome_1658" },
	-- Here's the Diamonds.
	{ Cue = "/VO/ZagreusHome_1659" },
	-- These are your Diamonds.
	{ Cue = "/VO/ZagreusHome_1660" },
}
GlobalVoiceLines.PurchasedSuperGemsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.75,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- I'll have a Diamond.
	{ Cue = "/VO/ZagreusHome_1654" },
	-- Could use that Diamond.
	{ Cue = "/VO/ZagreusHome_1655" },
	-- I'll take that Diamond.
	{ Cue = "/VO/ZagreusHome_1656" },
	-- The Diamond, please.
	{ Cue = "/VO/ZagreusHome_1657" },
}
GlobalVoiceLines.InsufficientSuperGemsVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
		},

		-- Not enough Diamonds.
		{ Cue = "/VO/ZagreusHome_1650" },
		-- Don't have enough Diamonds.
		{ Cue = "/VO/ZagreusHome_1651" },
		-- I need more Diamonds.
		{ Cue = "/VO/ZagreusHome_1652" },
		-- I'm short of Diamonds.
		{ Cue = "/VO/ZagreusHome_1653" },
	},
	[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
}

GlobalVoiceLines.SpentSuperLockKeysVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.4,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- Here's payment in Blood.
	{ Cue = "/VO/ZagreusHome_1683" },
	-- Trade you this Titan Blood.
	{ Cue = "/VO/ZagreusHome_1684" },
	-- Here's Titan Blood, then.
	{ Cue = "/VO/ZagreusHome_1685" },
}
GlobalVoiceLines.PurchasedSuperLockKeysVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.75,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- I need the Titan Blood.
	{ Cue = "/VO/ZagreusHome_1679" },
	-- Give me the Titan Blood.
	{ Cue = "/VO/ZagreusHome_1680" },
	-- Could use that Titan Blood.
	{ Cue = "/VO/ZagreusHome_1681" },
	-- I'll buy the Titan Blood.
	{ Cue = "/VO/ZagreusHome_1682" },
}
GlobalVoiceLines.NotEnoughSuperLockKeysVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- It's sealed shut.
	{ Cue = "/VO/ZagreusHome_0140" },
	-- Locked.
	{ Cue = "/VO/ZagreusHome_0142" },
	-- It's locked.
	{ Cue = "/VO/ZagreusHome_0037" },
	-- Hmm.
	{ Cue = "/VO/ZagreusField_1042" },
	-- Not enough Titan Blood.
	{ Cue = "/VO/ZagreusHome_1552" },
	-- I need more Titan Blood.
	{ Cue = "/VO/ZagreusHome_1553" },
	-- I'm lacking Titan Blood.
	{ Cue = "/VO/ZagreusHome_1554" },
	-- Don't have the Titan Blood.
	{ Cue = "/VO/ZagreusHome_1555" },
	-- All right, then, keep your secrets...
	{ Cue = "/VO/ZagreusHome_1232", RequiredScreenOpen = "WeaponUpgradeScreen", },
}
GlobalVoiceLines.InsufficientSuperLockKeysVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
		},

		-- Not enough Titan Blood.
		{ Cue = "/VO/ZagreusHome_1552" },
		-- I need more Titan Blood.
		{ Cue = "/VO/ZagreusHome_1553" },
		-- I'm lacking Titan Blood.
		{ Cue = "/VO/ZagreusHome_1554" },
		-- Don't have the Titan Blood.
		{ Cue = "/VO/ZagreusHome_1555" },
		-- All right, then, keep your secrets...
		-- { Cue = "/VO/ZagreusHome_1232", RequiredScreenOpen = "WeaponUpgradeScreen", SuccessiveChanceToPlay = 0.02 } },
	},
	[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
}

GlobalVoiceLines.SpentSuperGiftPointsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- Here's the Ambrosia.
	{ Cue = "/VO/ZagreusHome_1677" },
	-- This Ambrosia ought to pay for that.
	{ Cue = "/VO/ZagreusHome_1678" },
}
GlobalVoiceLines.PurchasedSuperGiftPointsVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.75,
	Cooldowns =
	{
		{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
	},

	-- One Ambrosia bottle, please.
	{ Cue = "/VO/ZagreusHome_1673" },
	-- I'll take the Ambrosia.
	{ Cue = "/VO/ZagreusHome_1674" },
	-- Ambrosia, then, why not.
	{ Cue = "/VO/ZagreusHome_1675" },
	-- Give me your finest bottle.
	{ Cue = "/VO/ZagreusHome_1676" },
}
GlobalVoiceLines.InsufficientSuperGiftPointsVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlayAll = 0.75,
		Cooldowns =
		{
			{ Name = "ZagreusResourceInteractionSpeech", Time = 6 },
		},

		-- Need more Ambrosia here.
		{ Cue = "/VO/ZagreusHome_1556" },
		-- Don't have enough Ambrosia.
		{ Cue = "/VO/ZagreusHome_1557" },
		-- I need to get my hands on more Ambrosia.
		{ Cue = "/VO/ZagreusHome_1558" },
		-- Lacking Ambrosia here.
		{ Cue = "/VO/ZagreusHome_1559" },
	},
	[2] = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
}
GlobalVoiceLines.InvalidResourceInteractionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.25,
	CooldownTime = 8,

	-- I can't.
	{ Cue = "/VO/ZagreusField_0390" },
	-- Can't do that.
	{ Cue = "/VO/ZagreusField_0391" },
	-- It's no use.
	{ Cue = "/VO/ZagreusField_0392" },
	-- No use.
	{ Cue = "/VO/ZagreusField_0393" },
	-- No way.
	{ Cue = "/VO/ZagreusField_0394" },
	-- Poor me.
	{ Cue = "/VO/ZagreusField_0494" },
}

GlobalVoiceLines.MiscEndVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.5,
	UsePlayerSource = true,
	RequiredMinElapsedTime = 3,
	SuccessiveChanceToPlay = 0.25,
	RequiredFalseTextLinesThisRun =  { "PersephoneMeeting07" },

	-- Well, see you around.
	{ Cue = "/VO/ZagreusHome_2070" },
	-- Well see you later, then.
	{ Cue = "/VO/ZagreusHome_0271" },
	-- You take care.
	{ Cue = "/VO/ZagreusHome_0272" },
	-- Until next time.
	{ Cue = "/VO/ZagreusHome_0273" },
	-- Till next time.
	{ Cue = "/VO/ZagreusHome_0274" },
	-- Good-bye for now.
	{ Cue = "/VO/ZagreusHome_0275" },
	-- Bye for now.
	{ Cue = "/VO/ZagreusHome_0276" },
	-- Nice chatting!
	{ Cue = "/VO/ZagreusHome_3028" },
	-- Good chatting.
	{ Cue = "/VO/ZagreusHome_3029" },
	-- See you!
	{ Cue = "/VO/ZagreusHome_3030" },
	-- Cheers!
	{ Cue = "/VO/ZagreusHome_3031" },
	-- Take care!
	{ Cue = "/VO/ZagreusHome_3032" },
	-- Take care, OK?
	{ Cue = "/VO/ZagreusHome_3033" },
	-- All right I'm off.
	{ Cue = "/VO/ZagreusHome_3034" },
	-- Good seeing you.
	{ Cue = "/VO/ZagreusHome_3035" },
	-- Well, take care.
	{ Cue = "/VO/ZagreusHome_0560" },
	-- Good catching up.
	{ Cue = "/VO/ZagreusHome_0563" },
	-- Well, see you.
	{ Cue = "/VO/ZagreusField_1711" },
	-- Bye.
	{ Cue = "/VO/ZagreusField_1712" },
}
GlobalVoiceLines.MiscEndVoiceLines_Dusa =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 3,
		SuccessiveChanceToPlay = 0.2,

		-- Bye, Dusa.
		{ Cue = "/VO/ZagreusHome_3036" },
		-- See you, Dusa.
		{ Cue = "/VO/ZagreusHome_3037" },
		-- Take care, Dusa!
		{ Cue = "/VO/ZagreusHome_3038" },
	},
	[2] = GlobalVoiceLines.MiscEndVoiceLines,
}
GlobalVoiceLines.MiscEndVoiceLines_Hypnos =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 3,
		SuccessiveChanceToPlay = 0.2,
		RequiredFalseTextLinesThisRun =  { "PersephoneMeeting07" },

		-- See you, Hypnos.
		{ Cue = "/VO/ZagreusHome_3039" },
		-- All right, Hypnos.
		{ Cue = "/VO/ZagreusHome_3040" },
		-- Get some rest, mate.
		{ Cue = "/VO/ZagreusHome_3041" },
		-- Bye, Hypnos.
		{ Cue = "/VO/ZagreusHome_3042" },
	},
	[2] = GlobalVoiceLines.MiscEndVoiceLines,
}
GlobalVoiceLines.MiscEndVoiceLines_Thanatos =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 3,
		SuccessiveChanceToPlay = 0.2,

		-- See you, Than.
		{ Cue = "/VO/ZagreusHome_3043" },
		-- See you, Thanatos.
		{ Cue = "/VO/ZagreusHome_3044" },
		-- See you out there.
		{ Cue = "/VO/ZagreusHome_3045" },
	},
	[2] = GlobalVoiceLines.MiscEndVoiceLines,
}
GlobalVoiceLines.MiscEndVoiceLines_Achilles =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 3,
		SuccessiveChanceToPlay = 0.2,

		-- Thanks, sir.
		{ Cue = "/VO/ZagreusHome_3046" },
		-- Take care, sir.
		{ Cue = "/VO/ZagreusHome_3047" },
		-- Thank you, sir.
		{ Cue = "/VO/ZagreusHome_3048" },
	},
	[2] = GlobalVoiceLines.MiscEndVoiceLines,
}
GlobalVoiceLines.MiscEndVoiceLines_Cerberus =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 3,
		SuccessiveChanceToPlay = 0.2,

		-- See you, boy.
		{ Cue = "/VO/ZagreusHome_3049" },
		-- Be good, boy.
		{ Cue = "/VO/ZagreusHome_3050" },
		-- Back soon, boy.
		{ Cue = "/VO/ZagreusHome_3051" },
		-- Take care, boy.
		{ Cue = "/VO/ZagreusHome_3052" },
	},
	[2] = GlobalVoiceLines.MiscEndVoiceLines,
}
GlobalVoiceLines.MiscEndVoiceLines_Megaera =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 3,
		SuccessiveChanceToPlay = 0.2,
		RequiredTextLines = { "MegaeraGift06" },

		-- Take care, Meg.
		{ Cue = "/VO/ZagreusHome_3053" },
		-- See you out there?
		{ Cue = "/VO/ZagreusHome_3054" },
		-- Nice seeing you, Meg.
		{ Cue = "/VO/ZagreusHome_3055" },
		-- See you soon, Meg.
		{ Cue = "/VO/ZagreusHome_3056" },
	},
	[2] = GlobalVoiceLines.MiscEndVoiceLines,
}
GlobalVoiceLines.MiscEndVoiceLines_Orpheus =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 3,
		SuccessiveChanceToPlay = 0.2,

		-- Bye, mate.
		{ Cue = "/VO/ZagreusHome_3057", RequiresNullAmbientMusicId = true },
		-- Take care, mate.
		{ Cue = "/VO/ZagreusHome_3058", RequiresNullAmbientMusicId = true },
		-- Cheers, mate.
		{ Cue = "/VO/ZagreusHome_3059", RequiresNullAmbientMusicId = true },
		-- Beautiful, mate.
		{ Cue = "/VO/ZagreusHome_3060", RequiresAmbientMusicId = true },
		-- You sound amazing, mate.
		{ Cue = "/VO/ZagreusHome_3061", RequiresAmbientMusicId = true },
	},
	[2] = GlobalVoiceLines.MiscEndVoiceLines,
}
GlobalVoiceLines.MiscEndVoiceLines_Nyx =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 3,
		SuccessiveChanceToPlay = 0.2,

		-- Bye, Nyx.
		{ Cue = "/VO/ZagreusHome_3062" },
		-- Thank you, Nyx.
		{ Cue = "/VO/ZagreusHome_3063" },
	},
	[2] = GlobalVoiceLines.MiscEndVoiceLines,
}
GlobalVoiceLines.MiscEndVoiceLines_Hades =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 3,
		SuccessiveChanceToPlay = 0.2,
		RequiredTextLines = { "Ending01" },

		-- See you out there, Father.
		{ Cue = "/VO/ZagreusHome_3698" },
		-- Father.
		{ Cue = "/VO/ZagreusHome_3699" },
		-- Take care, Father.
		{ Cue = "/VO/ZagreusHome_3700" },
		-- See you up top.
		{ Cue = "/VO/ZagreusHome_3701" },
		-- Nice chatting.
		{ Cue = "/VO/ZagreusHome_3702" },
		-- Good talk.
		{ Cue = "/VO/ZagreusHome_3703" },
		-- All right, then!
		{ Cue = "/VO/ZagreusHome_3704" },
		-- Thank you, Father.
		{ Cue = "/VO/ZagreusHome_3705" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 3,
		SuccessiveChanceToPlay = 0.2,

		-- Good chat, Father!
		{ Cue = "/VO/ZagreusHome_3064" },
		-- Well then!
		{ Cue = "/VO/ZagreusHome_3065" },
		-- Well all right!
		{ Cue = "/VO/ZagreusHome_3066" },
	},
}
GlobalVoiceLines.MiscEndVoiceLines_Persephone =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 2,
		SuccessiveChanceToPlayAll = 0.2,
		RequiredTrueFlags = { "PersephoneAway" },

		-- Come back soon, Mother.
		{ Cue = "/VO/ZagreusHome_3598" },
		-- Take care, OK?
		{ Cue = "/VO/ZagreusHome_3599" },
		-- Safe travels, Mother.
		{ Cue = "/VO/ZagreusHome_3600" },
		-- We'll take care of things while you're away.
		{ Cue = "/VO/ZagreusHome_3601" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 2,
		SuccessiveChanceToPlay = 0.2,

		-- Bye, Mother.
		{ Cue = "/VO/ZagreusHome_3593" },
		-- Take care, Mother.
		{ Cue = "/VO/ZagreusHome_3594" },
		-- Love you, Mother.
		{ Cue = "/VO/ZagreusHome_3595", RequiredTextLines = { "PersephoneGift09" }, },
		-- Let me know if you need anything.
		{ Cue = "/VO/ZagreusHome_3596" },
		-- Good to see you, Mother.
		{ Cue = "/VO/ZagreusHome_3597", RequiredFalseFlags = { "PersephoneGoingAway" }, },
	},
	[2] = GlobalVoiceLines.MiscEndVoiceLines,
}
GlobalVoiceLines.MiscEndVoiceLines_Charon =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.4,
		UsePlayerSource = true,
		RequiredMinElapsedTime = 2,
		SuccessiveChanceToPlay = 0.33,
		RequiredTextLines = { "CharonGift01" },

		-- Couldn't agree more, mate.
		{ Cue = "/VO/ZagreusField_0750" },
		-- Hello to you as well, mate!
		{ Cue = "/VO/ZagreusField_0751", RequiredTextLines = { "CharonGift02" } },
		-- I'll just have a look around.
		{ Cue = "/VO/ZagreusField_0752" },
		-- Fine day or night to you as well, Charon.
		{ Cue = "/VO/ZagreusField_0753", CooldownName = "MentionedCharon", CooldownTime = 40 },
		-- You're absolutely right, there, mate.
		{ Cue = "/VO/ZagreusField_0754", RequiredTextLines = { "CharonGift02" } },
		-- Truer words have not been spoken, mate.
		{ Cue = "/VO/ZagreusField_0755", RequiredTextLines = { "CharonGift04" } },
		-- Couldn't have said it better myself.
		{ Cue = "/VO/ZagreusField_0756" },
		-- Oh I'm just fine thank you for asking, mate.
		{ Cue = "/VO/ZagreusField_0757", RequiredTextLines = { "CharonGift03" } },
		-- It's good to see you too, mate.
		{ Cue = "/VO/ZagreusField_0758", RequiredTextLines = { "CharonGift03" } },
		-- Always a pleasure, Charon.
		{ Cue = "/VO/ZagreusField_0759", CooldownName = "MentionedCharon", CooldownTime = 40 },
	},
}

GlobalVoiceLines.KillingEnemyVoiceLines =
{
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		
		Cooldowns =
		{
			{ Name = "FlurrySpawnerReinforcementHintsPlayedRecently", Time = 20 },
			{ Name = "FlurrySpawnerHintExtraCooldown", Time = 180 },
		},

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			ChanceToPlay = 0.15,
			RequiredEncounters = { "MiniBossNakedSpawners" },
			RequiredUnitAlive = "FlurrySpawnerElite",
		},

		-- Have to take care of that Butterfly Ball!
		{ Cue = "/VO/ZagreusField_3565", GameStateRequirements = { RequiredPlayed = { "/VO/ZagreusField_3567" }, }, },
		-- Need to deal with the blasted Butterfly Ball!
		{ Cue = "/VO/ZagreusField_3566", GameStateRequirements = { RequiredPlayed = { "/VO/ZagreusField_3567" }, }, },
		-- They'll just keep coming 'cause of that Butterfly Ball!
		{ Cue = "/VO/ZagreusField_3567" },
		-- I should deal with that Butterfly Ball!
		{ Cue = "/VO/ZagreusField_3568", GameStateRequirements = { RequiredPlayed = { "/VO/ZagreusField_3567" }, }, },
		-- Better handle that Butterfly Ball!
		{ Cue = "/VO/ZagreusField_3569", GameStateRequirements = { RequiredPlayed = { "/VO/ZagreusField_3567" }, }, },
		-- There's no end to these guys!
		{ Cue = "/VO/ZagreusField_3570", GameStateRequirements = { RequiredPlayed = { "/VO/ZagreusField_3567" }, }, },
	},
	{
		RandomRemaining = true,
		PlayOnceThisRun = true,
		PreLineWait = 0.35,
		CooldownTime = 180,
		CooldownName = "ZagQuipped",
		
		ExplicitRequirements = true,
		GameStateRequirements =
		{
			ChanceToPlay = 0.045,
			RequiredFalseEncounters = { "BossHarpy1", "BossHarpy2", "BossHarpy3", "BossHydra", "BossTheseusAndMinotaur", "MiniBossMinotaur", "BossHades" },
		},

		-- There.
		{ Cue = "/VO/ZagreusField_0035", },
		-- There!
		{ Cue = "/VO/ZagreusField_0036", },
		-- Hah.
		{ Cue = "/VO/ZagreusField_0037", },
		-- T'heh.
		{ Cue = "/VO/ZagreusField_0038", },
		-- Hmph.
		{ Cue = "/VO/ZagreusField_0039", },
		-- He-heh.
		{ Cue = "/VO/ZagreusField_0040", },
		-- Heh.
		{ Cue = "/VO/ZagreusField_0041", },
		-- Got 'em.
		{ Cue = "/VO/ZagreusField_0042", },
		-- Next.
		{ Cue = "/VO/ZagreusField_0043", },
		-- Next?
		{ Cue = "/VO/ZagreusField_0044", },
		-- Tsch.
		{ Cue = "/VO/ZagreusField_0045", },
		-- Pff.
		{ Cue = "/VO/ZagreusField_0046", },
		-- Idiot.
		{ Cue = "/VO/ZagreusField_0047", },
		-- Easy.
		{ Cue = "/VO/ZagreusField_0048", },
		-- Nice try.
		{ Cue = "/VO/ZagreusField_0049", },
		-- Good night.
		{ Cue = "/VO/ZagreusField_0050", },
		-- You're dead.
		{ Cue = "/VO/ZagreusField_0051", },
		-- See you.
		{ Cue = "/VO/ZagreusField_0052", },
		-- Dead.
		{ Cue = "/VO/ZagreusField_0053", },
		-- Farewell.
		{ Cue = "/VO/ZagreusField_0054", },
		-- Die.
		{ Cue = "/VO/ZagreusField_0304", },
		-- Die!
		{ Cue = "/VO/ZagreusField_0305", },
		-- Out.
		{ Cue = "/VO/ZagreusField_0306", },
		-- Fool.
		{ Cue = "/VO/ZagreusField_0307", },
		-- Useless.
		{ Cue = "/VO/ZagreusField_0308", },
		-- What now!
		{ Cue = "/VO/ZagreusField_0309", },
		-- Like that?
		{ Cue = "/VO/ZagreusField_0310", },
		-- Suffer.
		{ Cue = "/VO/ZagreusField_0311", GameStateRequirements = { RequiredFalseBiome = "Styx" } },
		-- You're mine.
		{ Cue = "/VO/ZagreusField_0312", },
		-- Weak.
		{ Cue = "/VO/ZagreusField_0313", },
		-- Weak!
		{ Cue = "/VO/ZagreusField_0314", },
		-- Wretch.
		{ Cue = "/VO/ZagreusField_0315", GameStateRequirements = { RequiredFalseBiome = "Elysium" } },
		-- Got you.
		{ Cue = "/VO/ZagreusField_0593", },
		-- Got you!
		{ Cue = "/VO/ZagreusField_0594", },
		-- Back.
		{ Cue = "/VO/ZagreusField_0595", },
		-- You're dust.
		{ Cue = "/VO/ZagreusField_0596", },
		-- You're gone.
		{ Cue = "/VO/ZagreusField_0597", },
		-- Worthless.
		{ Cue = "/VO/ZagreusField_0598", },
		-- Get out.
		{ Cue = "/VO/ZagreusField_0599", },
		-- Easy.
		{ Cue = "/VO/ZagreusField_0600", },
		-- Who else.
		{ Cue = "/VO/ZagreusField_0601", },
		-- Who else?
		{ Cue = "/VO/ZagreusField_0602", },
		-- What else.
		{ Cue = "/VO/ZagreusField_0603", },
		-- What else?
		{ Cue = "/VO/ZagreusField_0604", },
		-- Well?
		{ Cue = "/VO/ZagreusField_0605", },
		-- Not a chance.
		{ Cue = "/VO/ZagreusField_0606", },
		-- Stay dead.
		{ Cue = "/VO/ZagreusField_0607", GameStateRequirements = { RequiredFalseBiome = "Styx" } },
		-- Stay dead!
		{ Cue = "/VO/ZagreusField_0608", GameStateRequirements = { RequiredFalseBiome = "Styx" } },
		-- Stay dead next time.
		{ Cue = "/VO/ZagreusField_0609", GameStateRequirements = { RequiredFalseBiome = "Styx" } },
		-- Out of my sight.
		{ Cue = "/VO/ZagreusField_0610", },
		-- You're done.
		{ Cue = "/VO/ZagreusField_0611", },
		-- You're done!
		{ Cue = "/VO/ZagreusField_0612", },
		-- Pop.
		{ Cue = "/VO/ZagreusField_0613", },
		-- Don't come back.
		{ Cue = "/VO/ZagreusField_0614", GameStateRequirements = { RequiredFalseBiome = "Styx" } },
		-- And don't come back!
		{ Cue = "/VO/ZagreusField_0615", GameStateRequirements = { RequiredFalseBiome = "Styx" } },
		-- Bye now.
		{ Cue = "/VO/ZagreusField_0616", },
		-- Pest.
		{ Cue = "/VO/ZagreusField_0617", },
		-- Out.
		{ Cue = "/VO/ZagreusField_1000", },
		-- Back.
		{ Cue = "/VO/ZagreusField_1001", },
		-- Burn.
		{ Cue = "/VO/ZagreusField_1002", GameStateRequirements = { RequiredFalseBiome = "Styx" } },
		-- Hah.
		{ Cue = "/VO/ZagreusField_1003", },
		-- Heh!
		{ Cue = "/VO/ZagreusField_1004", },
		-- Hmph.
		{ Cue = "/VO/ZagreusField_1005", },
		-- He-heh.
		{ Cue = "/VO/ZagreusField_1006", },
		-- Hm-hm.
		{ Cue = "/VO/ZagreusField_1007", },
		-- No you don't.
		{ Cue = "/VO/ZagreusField_1008", },
		-- No.
		{ Cue = "/VO/ZagreusField_1009", },
		-- Really?
		{ Cue = "/VO/ZagreusField_1010", },
		-- Rot.
		{ Cue = "/VO/ZagreusField_1011", },
		-- Give it up.
		{ Cue = "/VO/ZagreusField_1012", },
		-- I think not.
		{ Cue = "/VO/ZagreusField_1013", },
		-- Vermin.
		{ Cue = "/VO/ZagreusField_1014", GameStateRequirements = { RequiredBiome = "Styx" } },
		-- Die again.
		-- { Cue = "/VO/ZagreusField_0618", },
		-- OK.
		{ Cue = "/VO/ZagreusField_3286" },
		-- Dead.
		{ Cue = "/VO/ZagreusField_3287" },
		-- Dead!
		{ Cue = "/VO/ZagreusField_3288" },
		-- Got them.
		{ Cue = "/VO/ZagreusField_3289" },
		-- No.
		{ Cue = "/VO/ZagreusField_3290" },
		-- Heh, no.
		{ Cue = "/VO/ZagreusField_3291" },
		-- Uh-uh.
		{ Cue = "/VO/ZagreusField_3292" },
		-- How's that?
		{ Cue = "/VO/ZagreusField_3293" },
		-- No chance.
		{ Cue = "/VO/ZagreusField_3294" },
		-- Dust.
		{ Cue = "/VO/ZagreusField_3295" },
		-- Bye.
		{ Cue = "/VO/ZagreusField_3296" },
		-- 'Night.
		{ Cue = "/VO/ZagreusField_3297" },
		-- Khh.
		{ Cue = "/VO/ZagreusField_3298" },
		-- Hm-hm.
		{ Cue = "/VO/ZagreusField_3299" },
		-- <Scoff>
		{ Cue = "/VO/ZagreusField_3300" },
		-- Lights out.
		{ Cue = "/VO/ZagreusField_3301" },
		-- Pah!
		{ Cue = "/VO/ZagreusField_3302" },
		-- Out!
		{ Cue = "/VO/ZagreusField_3303" },
		-- What.
		{ Cue = "/VO/ZagreusField_3304" },
		-- Mine.
		{ Cue = "/VO/ZagreusField_3305" },
		-- Gone.
		{ Cue = "/VO/ZagreusField_3306" },
		-- Nice.
		{ Cue = "/VO/ZagreusField_3307" },
		-- Who's next.
		{ Cue = "/VO/ZagreusField_3308" },
		-- Good.
		{ Cue = "/VO/ZagreusField_3309" },
		-- More...
		{ Cue = "/VO/ZagreusField_3310" },
		-- Shot.
		{ Cue = "/VO/ZagreusField_3311", GameStateRequirements = {  RequiredAnyWeapon = { "BowWeapon", "GunWeapon" }, } },
		-- Pow.
		{ Cue = "/VO/ZagreusField_3312", GameStateRequirements = {  RequiredAnyWeapon = { "FistWeapon" }, } },
		-- Right.
		{ Cue = "/VO/ZagreusField_3313" },
		-- Get dead.
		{ Cue = "/VO/ZagreusField_3314" },
		-- You're gone.
		{ Cue = "/VO/ZagreusField_3315" },
	},
	-- chaos response
	{
		PreLineWait = 0.37,
		RandomRemaining = true,
		NoTarget = true,
		Source = { SubtitleColor = Color.ChaosVoice },
		CooldownTime = 400,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			RequiredKillEnemiesFound = true,
			ChanceToPlay = 0.1,
			RequiredTextLines = { "ChaosAboutWeaponEnchantments01", "ChaosGift01" },
			RequiredTrait = "ShieldRushBonusProjectileTrait",
			RequiredFalseBiome = "Styx",
			RequiredWeapon = "ShieldWeapon",
		},

		-- Elimination.
		{ Cue = "/VO/Chaos_0255" },
		-- Returned to the abyss.
		{ Cue = "/VO/Chaos_0256" },
		-- Inevitable.
		{ Cue = "/VO/Chaos_0257" },
		-- Yes.
		{ Cue = "/VO/Chaos_0258" },
		-- Destruction.
		{ Cue = "/VO/Chaos_0259" },
		-- Devastation.
		{ Cue = "/VO/Chaos_0260" },
		-- Annihilation.
		{ Cue = "/VO/Chaos_0261" },
		-- Eradication.
		{ Cue = "/VO/Chaos_0262" },
		-- Elimination.
		{ Cue = "/VO/Chaos_0263" },
		-- Extinction.
		{ Cue = "/VO/Chaos_0264" },
		-- Entropy.
		{ Cue = "/VO/Chaos_0265" },
		-- Death.
		{ Cue = "/VO/Chaos_0266" },
		-- Combustion.
		{ Cue = "/VO/Chaos_0267" },
		-- Purification.
		{ Cue = "/VO/Chaos_0268" },
		-- Dissolution.
		{ Cue = "/VO/Chaos_0269" },
		-- Extermination.
		{ Cue = "/VO/Chaos_0270" },
		-- Ruination.
		{ Cue = "/VO/Chaos_0271" },
		-- Impressive.
		{ Cue = "/VO/Chaos_0272" },
		-- <Laughter>
		{ Cue = "/VO/Chaos_0211" },
		-- <Laughter>
		{ Cue = "/VO/Chaos_0212" },
		-- <Laughter>
		{ Cue = "/VO/Chaos_0213" },
		-- Amusing.
		{ Cue = "/VO/Chaos_0224" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceThisRun = true,
		PreLineWait = 0.75,
		ThreadName = "RoomThread",
		ObjectType = "DusaSummon",
		CooldownTime = 6,
		
		ExplicitRequirements = true,
		GameStateRequirements =
		{
			ChanceToPlay = 0.25,
			RequiredFalseEncounters = { "BossHarpy1", "BossHarpy2", "BossHarpy3", "BossHydra", "BossTheseusAndMinotaur", "MiniBossMinotaur", "BossHades" },
			RequiredTrait = "DusaAssistTrait",
		},

		-- Ooh nice one!
		{ Cue = "/VO/Dusa_0287" },
		-- Wow!
		{ Cue = "/VO/Dusa_0288" },
		-- Whoo!
		{ Cue = "/VO/Dusa_0289" },
		-- Hoh, wow!
		{ Cue = "/VO/Dusa_0290" },
		-- Hoo, wow!
		{ Cue = "/VO/Dusa_0291" },
		-- Look at you!!
		{ Cue = "/VO/Dusa_0292" },
		-- Ooh, ouch!
		{ Cue = "/VO/Dusa_0293" },
		-- Whoa!
		{ Cue = "/VO/Dusa_0294" },
		-- Ooh!
		{ Cue = "/VO/Dusa_0295" },
		-- Ouch!
		{ Cue = "/VO/Dusa_0296" },
		-- Nice shot!
		{ Cue = "/VO/Dusa_0297" },
		-- Wow look at you!
		{ Cue = "/VO/Dusa_0298" },
	},
}
GlobalVoiceLines.RevengeKillingEnemyVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PlayOnceFromTableThisRun = true,
	PreLineWait = 0.45,
	CooldownName = "ZagQuipped",
	CooldownTime = 3,

	ExplicitRequirements = true,
	GameStateRequirements =
	{
		RequiredFalseRooms = { "A_Boss01", "A_Boss02", "A_Boss03", "B_Boss01", "B_Boss02", "C_Boss01", "D_Boss01" },
		RequiresInRun = true,
	},

	-- That's for last time.
	{ Cue = "/VO/ZagreusField_0976", },
	-- That was for last time.
	{ Cue = "/VO/ZagreusField_0977", },
	-- I always come back.
	{ Cue = "/VO/ZagreusField_0978", },
	-- That's what you get.
	{ Cue = "/VO/ZagreusField_0979", },
	-- Payback.
	{ Cue = "/VO/ZagreusField_0980", },
	-- Got you back.
	{ Cue = "/VO/ZagreusField_0981", },
	-- You kill me, I kill you.
	{ Cue = "/VO/ZagreusField_0982", },
	-- Let's call it even.
	{ Cue = "/VO/ZagreusField_0983", },
}

GlobalVoiceLines.RubbleKillVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PlayOnceFromTableThisRun = true,
	PreLineWait = 0.45,
	CooldownTime = 50,
	CooldownName = "ZagQuipped",
	RequiredMinHealthFraction = 0.25,

	-- Heads up.
	{ Cue = "/VO/ZagreusField_0995", },
	-- That's what you get.
	{ Cue = "/VO/ZagreusField_0996", },
	-- You're nothing.
	{ Cue = "/VO/ZagreusField_0997", },
	-- Back to dust.
	{ Cue = "/VO/ZagreusField_0998", },
	-- Crushed.
	{ Cue = "/VO/ZagreusField_0999", },
}

GlobalVoiceLines.BoonUsedVoiceLines =
{
	TriggerCooldowns =
	{
		"ZagreusBoonPickUpSpeech",
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		RequiredLastGodLoot = "ZeusUpgrade",
		RequiredEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
		RequireCurrentEncounterNotComplete = true,
		Source = { SubtitleColor = Color.ZeusVoice },

		-- I am most grateful.
		{ Cue = "/VO/Zeus_0087" },
		-- Why, I am honored!
		{ Cue = "/VO/Zeus_0088" },
		-- This pleases me.
		{ Cue = "/VO/Zeus_0089" },
		-- Thanks to you, young man.
		{ Cue = "/VO/Zeus_0090" },
		-- I shall remember this, Nephew.
		{ Cue = "/VO/Zeus_0091" },
		-- Bless you, Zagreus.
		{ Cue = "/VO/Zeus_0092" },
		-- How very kind of you.
		{ Cue = "/VO/Zeus_0093" },
		-- Wisely decided, there, young man!
		{ Cue = "/VO/Zeus_0165" },
		-- Now wasn't that a simple test, Nephew?
		{ Cue = "/VO/Zeus_0166" },
		-- Oh I feel very proud!
		{ Cue = "/VO/Zeus_0167" },
		-- Not the hardest choice you've ever made!
		{ Cue = "/VO/Zeus_0168" },
		-- Congratulations, you made the right choice!
		{ Cue = "/VO/Zeus_0169" },
		-- Ah, young man, you hurt somebody's feelings!
		{ Cue = "/VO/Zeus_0170" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		RequiredLastGodLoot = "PoseidonUpgrade",
		RequiredEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
		RequireCurrentEncounterNotComplete = true,
		Source = { SubtitleColor = Color.PoseidonVoice },

		-- I'm ever-grateful, Nephew!
		{ Cue = "/VO/Poseidon_0085", },
		-- My thanks are just as boundless as the sea!
		-- { Cue = "/VO/Poseidon_0086", },
		-- I very much appreciated that!
		{ Cue = "/VO/Poseidon_0087", },
		-- You honor your Lord Uncle, little Nephew!
		-- { Cue = "/VO/Poseidon_0088", },
		-- I'm proud to call you nephew, little Nephew!
		-- { Cue = "/VO/Poseidon_0089", },
		-- That's mighty generous of you!
		-- { Cue = "/VO/Poseidon_0090", },
		-- I'm thankful for the gesture there!
		{ Cue = "/VO/Poseidon_0091", },
		-- Haha, just as I thought!
		{ Cue = "/VO/Poseidon_0202", },
		-- No choice at all, correct?!
		{ Cue = "/VO/Poseidon_0203", },
		-- A good decision there!
		{ Cue = "/VO/Poseidon_0204", },
		-- Ah, hahaha, yes!
		{ Cue = "/VO/Poseidon_0205", },
		-- Well chosen, little Hades!
		{ Cue = "/VO/Poseidon_0206", },
		-- Greatly decided, Nephew!
		{ Cue = "/VO/Poseidon_0207", },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		RequiredLastGodLoot = "AthenaUpgrade",
		RequiredEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
		RequireCurrentEncounterNotComplete = true,
		Source = { SubtitleColor = Color.AthenaVoice },

		-- I am most grateful.
		{ Cue = "/VO/Athena_0083", },
		-- I thank you, Cousin.
		{ Cue = "/VO/Athena_0084", },
		-- How thoughtful, Zagreus.
		{ Cue = "/VO/Athena_0085", },
		-- You are most generous.
		{ Cue = "/VO/Athena_0086", },
		-- You honor me.
		{ Cue = "/VO/Athena_0087", },
		-- Thank you, Zagreus.
		{ Cue = "/VO/Athena_0088", },
		-- Wisely decided, Cousin.
		{ Cue = "/VO/Athena_0186", },
		-- A strategic choice.
		{ Cue = "/VO/Athena_0187", },
		-- Correct decision, Zagreus.
		{ Cue = "/VO/Athena_0188", },
		-- I trusted I could count on you.
		{ Cue = "/VO/Athena_0189", },
		-- No pleasing all upon Olympus, I suppose.
		{ Cue = "/VO/Athena_0190", },
		-- Very good. That is, for me, at least.
		-- { Cue = "/VO/Athena_0191", },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		RequiredLastGodLoot = "AresUpgrade",
		RequiredEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
		RequireCurrentEncounterNotComplete = true,
		Source = { SubtitleColor = Color.AresVoice },

		-- How very thoughtful.
		{ Cue = "/VO/Ares_0078", RequiredPlayed = { "/VO/Ares_0186" } },
		-- A token of my gratitude.
		-- { Cue = "/VO/Ares_0088", },
		-- Most intriguing.
		-- { Cue = "/VO/Ares_0080", },
		-- Why thank you.
		{ Cue = "/VO/Ares_0081", RequiredPlayed = { "/VO/Ares_0186" } },
		-- How very gracious.
		{ Cue = "/VO/Ares_0082", RequiredPlayed = { "/VO/Ares_0186" } },
		-- I shall remember this.
		{ Cue = "/VO/Ares_0083", RequiredPlayed = { "/VO/Ares_0186" } },
		-- A thoughtful gesture.
		{ Cue = "/VO/Ares_0084", RequiredPlayed = { "/VO/Ares_0186" } },
		-- You're wise to side with me.
		{ Cue = "/VO/Ares_0183", RequiredPlayed = { "/VO/Ares_0186" } },
		-- Let us wage war together, then.
		{ Cue = "/VO/Ares_0184", RequiredPlayed = { "/VO/Ares_0186" } },
		-- A shrewd decision on your part.
		{ Cue = "/VO/Ares_0185", RequiredPlayed = { "/VO/Ares_0186" } },
		-- Neutrality was not an option here.
		{ Cue = "/VO/Ares_0186", },
		-- Then, let us stand together.
		{ Cue = "/VO/Ares_0187", RequiredPlayed = { "/VO/Ares_0186" } },
		-- I knew you would be sensible.
		{ Cue = "/VO/Ares_0188", RequiredPlayed = { "/VO/Ares_0186" } },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		RequiredLastGodLoot = "AphroditeUpgrade",
		RequiredEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
		RequireCurrentEncounterNotComplete = true,
		Source = { SubtitleColor = Color.AphroditeVoice },

		-- I knew your heart was true!
		{ Cue = "/VO/Aphrodite_0160", },
		-- I knew you'd come around.
		{ Cue = "/VO/Aphrodite_0161", },
		-- What choice was there, really?
		{ Cue = "/VO/Aphrodite_0162", },
		-- Always trust your heart.
		{ Cue = "/VO/Aphrodite_0163", },
		-- Your heart shall never carry you astray.
		{ Cue = "/VO/Aphrodite_0164", },
		-- Wisely decided, dearest.
		{ Cue = "/VO/Aphrodite_0165", },
		-- I'm grateful, dearest.
		{ Cue = "/VO/Aphrodite_0090", },
		-- How thoughtful.
		{ Cue = "/VO/Aphrodite_0091", },
		-- Why thank you, love!
		{ Cue = "/VO/Aphrodite_0092", },
		-- You really shouldn't have!
		{ Cue = "/VO/Aphrodite_0093", },
		-- I won't forget this, not anytime soon!
		{ Cue = "/VO/Aphrodite_0094", },
		-- I very much appreciate it.
		{ Cue = "/VO/Aphrodite_0095", },
		-- I'm positively moved!
		{ Cue = "/VO/Aphrodite_0096", },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		RequiredLastGodLoot = "ArtemisUpgrade",
		RequiredEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
		RequireCurrentEncounterNotComplete = true,
		Source = { SubtitleColor = Color.ArtemisVoice },

		-- Hey thanks!
		{ Cue = "/VO/Artemis_0083", },
		-- You're very kind.
		{ Cue = "/VO/Artemis_0084", },
		-- I'm grateful.
		{ Cue = "/VO/Artemis_0085", },
		-- Thank you for this.
		{ Cue = "/VO/Artemis_0086", },
		-- Bless you Zagreus.
		{ Cue = "/VO/Artemis_0087", },
		-- I won't forget this.
		{ Cue = "/VO/Artemis_0088", },
		-- How nice of you.
		{ Cue = "/VO/Artemis_0089", },
		-- You chose correctly, Zagreus!
		{ Cue = "/VO/Artemis_0172", },
		-- Right on the mark!
		{ Cue = "/VO/Artemis_0173", },
		-- Not much of a choice, admittedly!
		{ Cue = "/VO/Artemis_0174", },
		-- I'd say you made the right decision there!
		{ Cue = "/VO/Artemis_0175", },
		-- Uh-oh, somebody's going to be upset!
		{ Cue = "/VO/Artemis_0176", },
		-- Ah good, you didn't make me mad this time!
		{ Cue = "/VO/Artemis_0177",
			RequiredMinAnyTextLines =
			{
				TextLines =
				{
					"ArtemisRejection01", "ArtemisRejection02", "ArtemisRejection03", "ArtemisRejection04", "ArtemisRejection05", "ArtemisRejection06", "ArtemisRejection07", "ArtemisRejection08", "ArtemisRejection09", "ArtemisRejection10",
				},
				Count = 8,
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		RequiredLastGodLoot = "DionysusUpgrade",
		RequiredEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
		RequireCurrentEncounterNotComplete = true,
		Source = { SubtitleColor = Color.DionysusVoice },

		-- Hey cheers man!
		{ Cue = "/VO/Dionysus_0077", },
		-- What, for me, Zag, wow...!
		{ Cue = "/VO/Dionysus_0078", },
		-- Hey now that is something, yeah!
		{ Cue = "/VO/Dionysus_0079", },
		-- I can't say no to that!
		{ Cue = "/VO/Dionysus_0080", },
		-- I owe you one man!
		{ Cue = "/VO/Dionysus_0081", },
		-- Cheers, I'll take it man!
		{ Cue = "/VO/Dionysus_0082", },
		-- Oh yeah I dig it man!
		{ Cue = "/VO/Dionysus_0083", },
		-- Hahaha, don't you know it, man!
		{ Cue = "/VO/Dionysus_0171" },
		-- Oh we are going to have a feast tonight!
		{ Cue = "/VO/Dionysus_0172" },
		-- Ooh you're in a real heap of trouble, Zag!
		{ Cue = "/VO/Dionysus_0173" },
		-- Yeaaah, man, you know what it's all about!
		{ Cue = "/VO/Dionysus_0174" },
		-- Hah, cheers to you, then, man!
		{ Cue = "/VO/Dionysus_0175" },
		-- That definitely was a good decision, man!
		{ Cue = "/VO/Dionysus_0176" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.5,
		RequiredLastGodLoot = "DemeterUpgrade",
		RequiredEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
		RequireCurrentEncounterNotComplete = true,
		Source = { SubtitleColor = Color.DemeterVoice },

		-- Ah yes, indeed.
		{ Cue = "/VO/Demeter_0171", },
		-- I'm grateful, Zagreus.
		{ Cue = "/VO/Demeter_0173", },
		-- You have my gratitude.
		{ Cue = "/VO/Demeter_0174", },
		-- How thoughtful, Zagreus.
		{ Cue = "/VO/Demeter_0175", },
		-- Why thank you, little sprout.
		{ Cue = "/VO/Demeter_0176", },
		-- Well done, my little sprout.
		{ Cue = "/VO/Demeter_0190", },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.15,
		RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium" },
		Cooldowns =
		{
			{ Name = "ZagreusBoonTakenSpeech", Time = 10 },
		},

		-- In the name of Hades.
		{ Cue = "/VO/ZagreusField_0176" },
		-- Hear me, on my authority.
		{ Cue = "/VO/ZagreusField_0178" },
		-- In the name of Hades!
		{ Cue = "/VO/ZagreusExtra_0002" },
		-- In the name of Hades!
		{ Cue = "/VO/ZagreusExtra_0004" },
		-- In the name of Hades!
		{ Cue = "/VO/ZagreusExtra_0006" },
		-- In the name of Hades!
		{ Cue = "/VO/ZagreusExtra_0008" },
		-- Olympus! I accept this message!
		{ Cue = "/VO/ZagreusExtra_0003" },
		-- Olympus! I accept this message!
		{ Cue = "/VO/ZagreusExtra_0005" },
		-- Olympus! I accept this message!
		{ Cue = "/VO/ZagreusExtra_0007" },
		-- Olympus! I accept this message!
		{ Cue = "/VO/ZagreusExtra_0009" },
		-- In the name of Hades!
		{ Cue = "/VO/ZagreusField_0984" },
		-- In the name of Hades.
		{ Cue = "/VO/ZagreusField_0985" },
		-- In the name of Hades...!
		{ Cue = "/VO/ZagreusField_0986" },
		-- Olympus! I accept this message!
		{ Cue = "/VO/ZagreusField_0987" },
		-- Olympus, I accept this message.
		{ Cue = "/VO/ZagreusField_0988" },
		-- Olympus? I accept this message...!
		{ Cue = "/VO/ZagreusField_0989" },
	},
}
GlobalVoiceLines.ChaosBoonUsedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.15,

	ExplicitRequirements = true,
	GameStateRequirements =
	{
		-- None
	},

	-- In the name of Hades!
	{ Cue = "/VO/ZagreusExtra_0002" },
	-- In the name of Hades!
	{ Cue = "/VO/ZagreusExtra_0006" },
	-- In the name of Hades!
	{ Cue = "/VO/ZagreusExtra_0008" },
	-- In the name of Hades!
	{ Cue = "/VO/ZagreusField_0984" },
	-- In the name of Hades.
	{ Cue = "/VO/ZagreusField_0985" },
}

GlobalVoiceLines.CheckOlympianReunionVoiceLines =
{
	{
		PlayOnce = true,
		PreLineWait = 1.05,
		RequiredTextLines = { "PersephoneAboutOlympianReunionQuest01", "ZeusAboutOlympianReunionQuest01", "PoseidonAboutOlympianReunionQuest01", "AthenaAboutOlympianReunionQuest01", "AresAboutOlympianReunionQuest01", "AphroditeAboutOlympianReunionQuest01", "ArtemisAboutOlympianReunionQuest01", "DionysusAboutOlympianReunionQuest01", "DemeterAboutOlympianReunionQuest01", "HermesAboutOlympianReunionQuest01" },
		RequiredFalseTextLines = { "OlympianReunionQuestComplete" },

		-- That was the last of the invitations... 
		{ Cue = "/VO/ZagreusField_4669", },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		RequiredTextLines = { "PersephoneAboutOlympianReunionQuest01", "ZeusAboutOlympianReunionQuest01", "PoseidonAboutOlympianReunionQuest01", "AthenaAboutOlympianReunionQuest01", "AresAboutOlympianReunionQuest01", "AphroditeAboutOlympianReunionQuest01", "ArtemisAboutOlympianReunionQuest01", "DionysusAboutOlympianReunionQuest01", "DemeterAboutOlympianReunionQuest01", "HermesAboutOlympianReunionQuest01" },
		RequiredFalseTextLines = { "OlympianReunionQuestComplete" },

		-- Just need to tell Mother. Once I get home...
		{ Cue = "/VO/ZagreusField_4670" },
	}
}

GlobalVoiceLines.FoundRareBoonVoiceLines =
{
	Cooldowns =
	{
		{ Name = "ZagreusFoundRareBoonSpeechPlayed", Time = 400 },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.75,
		PreLineWait = 1.05,
		RequiredInactiveMetaUpgrade = "ReducedLootChoicesShrineUpgrade",
		ValuableUpgradeInRoom = {
			HasAtLeastRarity = "Legendary",
		},

		-- Ooh.
		{ Cue = "/VO/ZagreusField_3379", },
		-- Heyy...
		{ Cue = "/VO/ZagreusField_3380", },
		-- Hoh...
		{ Cue = "/VO/ZagreusField_3381", },
		-- Mm, hmm.
		{ Cue = "/VO/ZagreusField_3382", },
		-- Mmm!
		{ Cue = "/VO/ZagreusField_3383", },
		-- All right...
		{ Cue = "/VO/ZagreusField_3384", },
		-- Nice...
		{ Cue = "/VO/ZagreusField_3385", },
		-- The goods.
		{ Cue = "/VO/ZagreusField_3386", },
		-- Ooh, good.
		{ Cue = "/VO/ZagreusField_3387", },
		-- Ah, yes.
		{ Cue = "/VO/ZagreusField_3388", },
		-- Yes...
		{ Cue = "/VO/ZagreusField_3389", },
		-- Whoo...
		{ Cue = "/VO/ZagreusField_3390", },
		-- Interesting...
		{ Cue = "/VO/ZagreusField_3391", },
		-- Hmm...
		{ Cue = "/VO/ZagreusField_3392", },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.75,
		PreLineWait = 1.05,
		RequiredInactiveMetaUpgrade = "ReducedLootChoicesShrineUpgrade",
		ValuableUpgradeInRoom = {
			AllAtLeastRarity = "Rare",
			HasAtLeastRarity = "Epic",
		},

		-- Ooh.
		{ Cue = "/VO/ZagreusField_3379", },
		-- Heyy...
		{ Cue = "/VO/ZagreusField_3380", },
		-- Hoh...
		{ Cue = "/VO/ZagreusField_3381", },
		-- Mm, hmm.
		{ Cue = "/VO/ZagreusField_3382", },
		-- Mmm!
		{ Cue = "/VO/ZagreusField_3383", },
		-- All right...
		{ Cue = "/VO/ZagreusField_3384", },
		-- Nice...
		{ Cue = "/VO/ZagreusField_3385", },
		-- The goods.
		{ Cue = "/VO/ZagreusField_3386", },
		-- Ooh, good.
		{ Cue = "/VO/ZagreusField_3387", },
		-- Ah, yes.
		{ Cue = "/VO/ZagreusField_3388", },
		-- Yes...
		{ Cue = "/VO/ZagreusField_3389", },
		-- Whoo...
		{ Cue = "/VO/ZagreusField_3390", },
		-- Interesting...
		{ Cue = "/VO/ZagreusField_3391", },
		-- Hmm...
		{ Cue = "/VO/ZagreusField_3392", },
	},	
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.75,
		PreLineWait = 1.05,
		RequiredInactiveMetaUpgrade = "ReducedLootChoicesShrineUpgrade",
		HasAnyTraitNamesInRoom = GameData.AllSynergyTraits,

		-- Ooh.
		{ Cue = "/VO/ZagreusField_3379", },
		-- Heyy...
		{ Cue = "/VO/ZagreusField_3380", },
		-- Hoh...
		{ Cue = "/VO/ZagreusField_3381", },
		-- Mm, hmm.
		{ Cue = "/VO/ZagreusField_3382", },
		-- Mmm!
		{ Cue = "/VO/ZagreusField_3383", },
		-- All right...
		{ Cue = "/VO/ZagreusField_3384", },
		-- Nice...
		{ Cue = "/VO/ZagreusField_3385", },
		-- The goods.
		{ Cue = "/VO/ZagreusField_3386", },
		-- Ooh, good.
		{ Cue = "/VO/ZagreusField_3387", },
		-- Ah, yes.
		{ Cue = "/VO/ZagreusField_3388", },
		-- Yes...
		{ Cue = "/VO/ZagreusField_3389", },
		-- Whoo...
		{ Cue = "/VO/ZagreusField_3390", },
		-- Interesting...
		{ Cue = "/VO/ZagreusField_3391", },
		-- Hmm...
		{ Cue = "/VO/ZagreusField_3392", },
	},	
}

GlobalVoiceLines.DemeterFatalityVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Source = { SubtitleColor = Color.DemeterVoice },
		RequiredRoom = "D_Boss01",

		-- Reap what you sow!
		{ Cue = "/VO/Demeter_0231" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		Source = { SubtitleColor = Color.DemeterVoice },

		-- Freeze to death!
		{ Cue = "/VO/Demeter_0126" },
		-- Wither and die!
		{ Cue = "/VO/Demeter_0232" },
		-- Ripe for harvest!
		{ Cue = "/VO/Demeter_0233" },
	},
}

-- Lieutenant / Devotion Scripts
GlobalVoiceLines.DevotionChoicePresentedVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,

	ExplicitRequirements = true,
	GameStateRequirements =
	{
		-- None
	},

	-- Looks like I've a choice to make.
	{ Cue = "/VO/ZagreusField_0160", },
	-- The gods want me to pick a favorite?
	{ Cue = "/VO/ZagreusField_0161", },
	-- The gods want me to choose.
	{ Cue = "/VO/ZagreusField_0162", },
	-- Time to pick sides.
	{ Cue = "/VO/ZagreusField_0336", },
	-- They're making me choose.
	{ Cue = "/VO/ZagreusField_0337", },
	-- One of them's going to be mad.
	{ Cue = "/VO/ZagreusField_0338", },
	-- One of them's not going to like this.
	{ Cue = "/VO/ZagreusField_0339", },
	-- Whose favor to choose?
	{ Cue = "/VO/ZagreusField_0401", },
	-- One god or the other...
	{ Cue = "/VO/ZagreusField_0402", },
	-- I have to pick a side.
	{ Cue = "/VO/ZagreusField_0403", },
	-- Whichever god I don't pick won't be pleased.
	{ Cue = "/VO/ZagreusField_0404", },
}
GlobalVoiceLines.GodRejectedVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 1.3,
	RequiredEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
	UsePlayerSource = true,

	-- Did what I had to do.
	{ Cue = "/VO/ZagreusField_0408" },
	-- He'll get over it.
	{ Cue = "/VO/ZagreusField_0409", RequiredRejectedGodGender = "Male" },
	-- She'll get over it.
	{ Cue = "/VO/ZagreusField_0410", RequiredRejectedGodGender = "Female" },
	-- Damned either way I guess.
	{ Cue = "/VO/ZagreusField_0167" },
	-- So that's the way it is then.
	{ Cue = "/VO/ZagreusField_0168" },
	-- He won't like this.
	{ Cue = "/VO/ZagreusField_4155", RequiredRejectedGodGender = "Male" },
	-- She won't like this.
	{ Cue = "/VO/ZagreusField_4156", RequiredRejectedGodGender = "Female" },
	-- He won't stand for this.
	{ Cue = "/VO/ZagreusField_4157", RequiredRejectedGodGender = "Male" },
	-- She won't let this go.
	{ Cue = "/VO/ZagreusField_4158", RequiredRejectedGodGender = "Female" },
	-- Didn't have much choice.
	{ Cue = "/VO/ZagreusField_4159" },
	-- Had to do it.
	{ Cue = "/VO/ZagreusField_4160" },
	-- Well that's that.
	{ Cue = "/VO/ZagreusField_4161" },
	-- Had to choose.
	{ Cue = "/VO/ZagreusField_4162" },
}

GlobalVoiceLines.ForkingPathVoiceLines =
{
	RequiredMinOfferedRewardTypes = 2,
	Cooldowns =
	{
		{ Name = "ZagreusForkingPathVoiceLinesPlayed", Time = 120 },
	},
	Queue = "NeverQueue",
	{
		BreakIfPlayed = true,
		PlayOnce = true,
		RequiredKillEnemiesNotFound = true,
		RequiredFalseBiome = "Styx",

		-- Each exit has its own reward.
		{ Cue = "/VO/ZagreusField_0366" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		RequiredKillEnemiesNotFound = true,
		SuccessiveChanceToPlay = 0.25,
		PlayOnceFromTableThisRun = true,
		RequiredPlayed = "/VO/ZagreusField_0366",
		RequiredFalseBiome = "Styx",
		RequiredMaxCompletedRuns = 75,

		-- Let me see...
		{ Cue = "/VO/ZagreusField_0100",  },
		-- Where now...?
		{ Cue = "/VO/ZagreusField_0101a" },
		-- Where now...
		{ Cue = "/VO/ZagreusField_0101b" },
		-- Which way...
		{ Cue = "/VO/ZagreusField_0102" },
		-- Now what...
		{ Cue = "/VO/ZagreusField_0367" },
		-- Where to...
		{ Cue = "/VO/ZagreusField_0368" },
		-- Which path...
		{ Cue = "/VO/ZagreusField_0369" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		RequiredKillEnemiesNotFound = true,
		SuccessiveChanceToPlay = 0.33,
		PlayOnceFromTableThisRun = true,
		RequiredBiome = "Styx",
		RequiredMaxDoorsClosedInRoom = 4,

		-- Which one first.
		{ Cue = "/VO/ZagreusField_2400", RequiredMaxDoorsClosedInRoom = 0 },
		-- Where to.
		{ Cue = "/VO/ZagreusField_2401" },
		-- Which tunnel.
		{ Cue = "/VO/ZagreusField_2402" },
		-- If I were a Satyr sack, where would I be...
		{ Cue = "/VO/ZagreusField_2403", RequiredFalseSeenRoomThisRun = "D_Reprieve01", RequiredTextLines = { "CerberusBossDoorUnlock01" }, },
		-- Which tunnel?
		{ Cue = "/VO/ZagreusField_2404" },
		-- Let's see here.
		{ Cue = "/VO/ZagreusField_2405" },
		-- Satyr tunnels...
		{ Cue = "/VO/ZagreusField_2406" },
		-- All these tunnels...
		{ Cue = "/VO/ZagreusField_2407" },
	},

}
GlobalVoiceLines.BreakingStuffVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.85,
		CooldownTime = 8,
		RequiredRoom = "RoomOpening",
		RequiredKillEnemiesNotFound = true,
		SuccessiveChanceToPlay = 0.5,

		-- Whoops.
		{ Cue = "/VO/ZagreusHome_0090" },
		-- How'd that happen?
		{ Cue = "/VO/ZagreusField_0947", RequiredPlayed = { "/VO/ZagreusHome_0090" } },
		-- Fixed that for you.
		{ Cue = "/VO/ZagreusField_0948", RequiredPlayed = { "/VO/ZagreusHome_0090" } },
		-- How careless of me.
		{ Cue = "/VO/ZagreusField_0949", RequiredPlayed = { "/VO/ZagreusHome_0090" } },
		-- Who keeps fixing that?
		{ Cue = "/VO/ZagreusField_0950", RequiredPlayed = { "/VO/ZagreusHome_0090" } },
		-- Whoops!
		-- { Cue = "/VO/ZagreusHome_0091" },
		-- Erm sorry...!
		-- { Cue = "/VO/ZagreusHome_0092" },
		-- Oh must've slipped.
		-- { Cue = "/VO/ZagreusHome_0093" },
	},
}
GlobalVoiceLines.SkellyKilledVoiceLines =
{
	PreLineWait = 1.3,
	UsePlayerSource = true,
	PlayOnce = true,

	-- Whoops!
	{ Cue = "/VO/ZagreusHome_0091" },
}
GlobalVoiceLines.ShadeKilledVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		CooldownTime = 10,
		PlayOnceFromTableThisRun = true,
		RequiresInRun = true,
		RequiredRoom = "RoomOpening",
		RequiredKillEnemiesNotFound = true,

		-- Go away.
		{ Cue = "/VO/ZagreusHome_0094" },
		-- Out of my way.
		{ Cue = "/VO/ZagreusHome_0095" },
		-- Shoo already.
		{ Cue = "/VO/ZagreusHome_0096", RequiredPlayed = { "/VO/ZagreusField_1054", "/VO/ZagreusField_1055" } },
		-- Out of my sight.
		{ Cue = "/VO/ZagreusHome_0097" },
		-- Piss off.
		{ Cue = "/VO/ZagreusHome_0098" },
		-- Get out.
		{ Cue = "/VO/ZagreusField_1049" },
		-- Out!
		{ Cue = "/VO/ZagreusField_1050" },
		-- Go sulk someplace else.
		{ Cue = "/VO/ZagreusField_1051" },
		-- Get out of here.
		{ Cue = "/VO/ZagreusField_1052" },
		-- Disappear.
		{ Cue = "/VO/ZagreusField_1053" },
		-- Shoo.
		{ Cue = "/VO/ZagreusField_1054" },
		-- Shoo!
		{ Cue = "/VO/ZagreusField_1055" },
		-- Wretches.
		{ Cue = "/VO/ZagreusField_1056" },
		-- You're in my way.
		{ Cue = "/VO/ZagreusField_1057" },
	},
	{
		ObjectType = "NPC_Sisyphus_01",
		RequiredUnitAlive = "NPC_Sisyphus_01",
		PreLineWait = 0.45,
		RandomRemaining = true,
		BreakIfPlayed = true,
		CooldownTime = 60,
		SuccessiveChanceToPlay = 0.25,
		RequiresInRun = true,
		RequiredKillEnemiesNotFound = true,

		-- Chased them away you did!
		{ Cue = "/VO/Sisyphus_0381" },
		-- Those shades always come back.
		{ Cue = "/VO/Sisyphus_0382" },
		-- Oh those shades aren't so bad.
		{ Cue = "/VO/Sisyphus_0383" },
		-- Why trouble them, Prince Z.?
		{ Cue = "/VO/Sisyphus_0384", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
		-- No need for that here, Prince.
		{ Cue = "/VO/Sisyphus_0385", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
		-- They'll just come back next time.
		{ Cue = "/VO/Sisyphus_0386" },
		-- Those shades are stuck here, Prince.
		{ Cue = "/VO/Sisyphus_0387", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
		-- Why shoo those shades away?
		{ Cue = "/VO/Sisyphus_0388" },
	},
}
GlobalVoiceLines.BreakableDestroyedVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		CooldownTime = 60,
		RequiresInRun = true,
		RequiredUnitAlive = "NPC_Charon_01",
		SuccessiveChanceToPlay = 0.05,

		-- Don't mind me, Charon.
		{ Cue = "/VO/ZagreusField_0884", CooldownName = "MentionedCharon", CooldownTime = 40 },
		-- Just tidying up a bit.
		{ Cue = "/VO/ZagreusField_0885" },
		-- Must have slipped.
		{ Cue = "/VO/ZagreusField_0886" },
		-- Wasn't me.
		{ Cue = "/VO/ZagreusField_1624" },
		-- Who keeps replacing those.
		{ Cue = "/VO/ZagreusField_1625", RequiredPlayed = { "/VO/ZagreusField_0884"} },
		-- Took care of those for you, mate.
		{ Cue = "/VO/ZagreusField_1626" },
		-- No need to thank me, mate.
		{ Cue = "/VO/ZagreusField_1627" },
		-- No urns permitted in this chamber.
		{ Cue = "/VO/ZagreusField_1628" },
	},
	{
		ObjectType = "NPC_Sisyphus_01",
		RequiredUnitAlive = "NPC_Sisyphus_01",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.25,
		PlayFromTarget = true,
		CooldownTime = 60,
		SuccessiveChanceToPlay = 0.01,

		-- Erm, Prince...?
		{ Cue = "/VO/Sisyphus_0088", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
		-- You show those dusty pots!
		{ Cue = "/VO/Sisyphus_0371" },
		-- Nice shot, Prince Z.!
		{ Cue = "/VO/Sisyphus_0372", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
		-- That sound never gets old!
		{ Cue = "/VO/Sisyphus_0373" },
		-- Thank you for picking up a bit!
		{ Cue = "/VO/Sisyphus_0374" },
		-- They keep replacing those.
		{ Cue = "/VO/Sisyphus_0375" },
		-- Nice shot, Prince Z.!
		{ Cue = "/VO/Sisyphus_0376", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
		-- I'm glad that wasn't me!
		{ Cue = "/VO/Sisyphus_0377" },
		-- Break all the pots you like!
		{ Cue = "/VO/Sisyphus_0378" },
		-- Fraid those are empty, Prince!
		{ Cue = "/VO/Sisyphus_0379", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
		-- Don't bother with those, Prince.
		{ Cue = "/VO/Sisyphus_0380", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
	},
}
GlobalVoiceLines.BreakableHighValueDestroyedVoiceLines =
{
	{
		PlayOnce = true,
		PlayOnceFromTableThisRun = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.8,
		RequiredKillEnemiesNotFound = true,
		RequiredBiome = "Styx",

		-- Some of those urns have coin in them don't they.
		{ Cue = "/VO/ZagreusField_2613", },
		-- These urns have coin in them.
		{ Cue = "/VO/ZagreusField_2614", },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.8,
		RequiredKillEnemiesNotFound = true,
		CooldownName = "HadesPostBossCooldown",
		CooldownTime = 270,
		SuccessiveChanceToPlay = 0.25,

		-- I'm rich!
		{ Cue = "/VO/ZagreusField_0659", },
		-- Shiny.
		{ Cue = "/VO/ZagreusField_0665", },
		-- That's a lot of coin.
		{ Cue = "/VO/ZagreusField_0941", },
		-- Look at all that coin.
		{ Cue = "/VO/ZagreusField_0942", },
		-- Hey, money!
		{ Cue = "/VO/ZagreusField_0943", },
		-- Lucky find!
		{ Cue = "/VO/ZagreusField_0944", },
		-- Hello, coin!
		{ Cue = "/VO/ZagreusField_0945", },
		-- Lots of coin there.
		{ Cue = "/VO/ZagreusField_0946", },
	},
}

GlobalVoiceLines.HydraHeadsDefeatedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.66,
	SuccessiveChanceToPlay = 0.25,
	UsePlayerSource = true,
	Cooldowns =
	{
		{ Name = "ZagreusAnyQuipSpeech" },
	},

	ExplicitRequirements = true,
	GameStateRequirements =
	{
		-- None
	},

	-- There.
	{ Cue = "/VO/ZagreusField_0035", },
	-- There!
	{ Cue = "/VO/ZagreusField_0036", },
	-- Hah.
	{ Cue = "/VO/ZagreusField_0037", },
	-- Hmph.
	{ Cue = "/VO/ZagreusField_0039", },
	-- Tsch.
	{ Cue = "/VO/ZagreusField_0045", },
	-- Pff.
	{ Cue = "/VO/ZagreusField_0046", },
	-- Die.
	{ Cue = "/VO/ZagreusField_0304", },
	-- Die!
	{ Cue = "/VO/ZagreusField_0305", },
	-- What now!
	{ Cue = "/VO/ZagreusField_0309", },
	-- Like that?
	{ Cue = "/VO/ZagreusField_0310", },
	-- Got you.
	{ Cue = "/VO/ZagreusField_0593", },
	-- Got you!
	{ Cue = "/VO/ZagreusField_0594", },
	-- Back.
	{ Cue = "/VO/ZagreusField_0595", },
	-- You're dust.
	{ Cue = "/VO/ZagreusField_0596", },
	-- Back.
	{ Cue = "/VO/ZagreusField_1001", },
}

GlobalVoiceLines.HydraHeadsSpawnedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 3.5,
	SuccessiveChanceToPlay = 0.2,
	RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
	RequiresInRun = true,
	Cooldowns =
	{
		{ Name = "ZagreusAnyQuipSpeech" },
	},

	-- Keep 'em coming!
	{ Cue = "/VO/ZagreusField_0456" },
	-- Not finished yet?
	{ Cue = "/VO/ZagreusField_0453" },
	-- Brought friends, have you?
	{ Cue = "/VO/ZagreusField_0454" },
	-- Want more?
	{ Cue = "/VO/ZagreusField_0455" },
	-- How many of these are there?
	{ Cue = "/VO/ZagreusField_0457", ChanceToPlayAgain = 0.2, RequiredMaxTimesSeenRoom = { B_Intro = 50 }, },
	-- Here come the heads.
	{ Cue = "/VO/ZagreusField_1825", RequiredPlayed = { "/VO/ZagreusField_0457" } },
	-- How about more heads!
	-- { Cue = "/VO/ZagreusField_1826", RequiredPlayed = { "/VO/ZagreusField_0457" } },
	-- How about more heads?
	{ Cue = "/VO/ZagreusField_1827", RequiredPlayed = { "/VO/ZagreusField_0457" }, ChanceToPlay = 0.1, ChanceToPlayAgain = 0.1 },
	-- More heads, keep 'em coming.
	{ Cue = "/VO/ZagreusField_1828", RequiredPlayed = { "/VO/ZagreusField_0457" } },
	-- Sure has a lot of these.
	{ Cue = "/VO/ZagreusField_1829", RequiredPlayed = { "/VO/ZagreusField_0457" }, ChanceToPlay = 0.1, ChanceToPlayAgain = 0.1 },
	-- More heads.
	{ Cue = "/VO/ZagreusField_1830", RequiredPlayed = { "/VO/ZagreusField_0457" } },
	-- Good, more heads.
	{ Cue = "/VO/ZagreusField_1831", RequiredPlayed = { "/VO/ZagreusField_0457" }, ChanceToPlay = 0.1, ChanceToPlayAgain = 0.1 },
	-- I call heads...?
	{ Cue = "/VO/ZagreusField_1832", RequiredPlayed = { "/VO/ZagreusField_0457" }, ChanceToPlay = 0.1, ChanceToPlayAgain = 0.1 },
	-- Time for more heads?
	{ Cue = "/VO/ZagreusField_3161", RequiredPlayed = { "/VO/ZagreusField_0457" } },
	-- Time for more heads.
	{ Cue = "/VO/ZagreusField_3162", RequiredPlayed = { "/VO/ZagreusField_0457" } },
	-- Come on, you heads!
	{ Cue = "/VO/ZagreusField_3163", RequiredPlayed = { "/VO/ZagreusField_0457" } },
	-- Attack me, heads!
	{ Cue = "/VO/ZagreusField_3164", RequiredPlayed = { "/VO/ZagreusField_0457" } },
	-- Let's bash some heads.
	{ Cue = "/VO/ZagreusField_3165", RequiredPlayed = { "/VO/ZagreusField_0457" } },
	-- Hi heads!
	{ Cue = "/VO/ZagreusField_3166", RequiredPlayed = { "/VO/ZagreusField_0457" } },
}

GlobalVoiceLines.VerminMoneyDropVoiceLines =
{
	PlayOnce = true,
	PlayOnceFromTableThisRun = true,
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.0,
	RequiredMinHealthFraction = 0.4,
	ChanceToPlay = 0.2,
	UsePlayerSource = true,
	Cooldowns =
	{
		{ Name = "ZagreusAnyQuipSpeech" },
	},

	-- Why do these vermin carry coin?
	{ Cue = "/VO/ZagreusField_2615" },
	-- That was a wealthy vermin.
	{ Cue = "/VO/ZagreusField_2616", RequiredPlayed = { "/VO/ZagreusField_2615" } },
}
GlobalVoiceLines.SurvivalMoneyDropVoiceLines =
{
	PlayOnce = true,
	PlayOnceFromTableThisRun = true,
	BreakIfPlayed = true,
	PreLineWait = 1.0,
	ChanceToPlay = 0.1,
	UsePlayerSource = true,
	RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" },
	Cooldowns =
	{
		{ Name = "ZagreusAnyQuipSpeech" },
	},

	-- Least I'm picking up some coin!
	{ Cue = "/VO/ZagreusField_4640" },
	-- Cheers for the coin!
	{ Cue = "/VO/ZagreusField_4641" },
}

GlobalVoiceLines.SurvivalAboutToStartVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.0,
	PlayOnceFromTableThisRun = true,
	SuccessiveChanceToPlayAll = 0.5,
	RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" },

	-- Oh, no.
	{ Cue = "/VO/ZagreusField_0962" },
	-- Uh oh...
	{ Cue = "/VO/ZagreusField_0159", RequiredPlayed = { "/VO/ZagreusField_0962" } },
	-- Here we go again.
	{ Cue = "/VO/ZagreusField_0959", RequiredPlayed = { "/VO/ZagreusField_0962" } },
	-- Blood and darkness...
	{ Cue = "/VO/ZagreusField_0960", RequiredPlayed = { "/VO/ZagreusField_0962" } },
	-- What is it now.
	{ Cue = "/VO/ZagreusField_0961", RequiredPlayed = { "/VO/ZagreusField_0962" } },
	-- Oh, gods.
	{ Cue = "/VO/ZagreusField_0963", RequiredPlayed = { "/VO/ZagreusField_0962" } },
	-- What...
	{ Cue = "/VO/ZagreusField_0964", RequiredPlayed = { "/VO/ZagreusField_0962" } },
}
GlobalVoiceLines.SurvivalStartVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.85,
	PlayOnceFromTableThisRun = true,
	SuccessiveChanceToPlayAll = 0.5,

	ExplicitRequirements = true,
	GameStateRequirements =
	{
		-- None
	},

	-- I'm trapped...!
	{ Cue = "/VO/ZagreusField_0185" },
	-- Then, here we go...
	{ Cue = "/VO/ZagreusField_0186" },
	-- Think you got me, do you?
	{ Cue = "/VO/ZagreusField_0187" },
	-- Come on, then.
	{ Cue = "/VO/ZagreusField_0114", },
	-- Whoops.
	{ Cue = "/VO/ZagreusField_0545", },
	-- I'm in for it.
	{ Cue = "/VO/ZagreusField_0546", },
	-- Found me, huh?
	{ Cue = "/VO/ZagreusField_0547", },
	-- Got their attention.
	{ Cue = "/VO/ZagreusField_0548", },
	-- OK.
	{ Cue = "/VO/ZagreusField_0549", },
	-- Father.
	{ Cue = "/VO/ZagreusField_0550", },
	-- Father...!
	{ Cue = "/VO/ZagreusField_0551", },
	-- Made them mad.
	{ Cue = "/VO/ZagreusField_0552", },
	-- Surrounded...!
	{ Cue = "/VO/ZagreusField_0397", },
	-- Caught out...!
	{ Cue = "/VO/ZagreusField_0398", },
	-- Caught me...!
	{ Cue = "/VO/ZagreusField_0399", },
	-- Damn it...!
	{ Cue = "/VO/ZagreusField_0400", GameStateRequirements = { RequiredMaxHealthFraction = 0.5, }, },
	-- I get the feeling I am being watched.
	{ Cue = "/VO/ZagreusField_1610", },
	-- Oh this is trouble.
	{ Cue = "/VO/ZagreusField_1611", },
}
GlobalVoiceLines.SurvivalExpiringVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.55,
	SuccessiveChanceToPlayAll = 0.5,

	ExplicitRequirements = true,
	GameStateRequirements =
	{
		-- None
	},

	-- Almost there...
	{ Cue = "/VO/ZagreusField_0188" },
	-- Few more moments...
	{ Cue = "/VO/ZagreusField_0189" },
	-- Got to hold on...
	{ Cue = "/VO/ZagreusField_0190" },
	-- Almost...!
	{ Cue = "/VO/ZagreusField_0553" },
	-- Just a bit longer...!
	{ Cue = "/VO/ZagreusField_0554" },
	-- So close...!
	{ Cue = "/VO/ZagreusField_0555" },
	-- Nearly made it...!
	{ Cue = "/VO/ZagreusField_0556" },
}
GlobalVoiceLines.SurvivalResolvedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 3.65,
	SuccessiveChanceToPlayAll = 0.33,
	ExplicitRequirements = true,
	GameStateRequirements =
	{
		-- None
	},

	-- Well that's better!
	{ Cue = "/VO/ZagreusField_0191" },
	-- There we are.
	{ Cue = "/VO/ZagreusField_0192" },
	-- Peace and quiet.
	{ Cue = "/VO/ZagreusField_0193" },
	-- Finally.
	{ Cue = "/VO/ZagreusField_0220" },
	-- That's that.
	{ Cue = "/VO/ZagreusField_0221" },
	-- There we go.
	{ Cue = "/VO/ZagreusField_0224" },
	-- Now to collect.
	{ Cue = "/VO/ZagreusField_0222", },
	-- There.
	{ Cue = "/VO/ZagreusField_0226", },
}

GlobalVoiceLines.PerfectClearAboutToStartVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.0,
	SuccessiveChanceToPlay = 0.33,
	PlayOnceFromTableThisRun = true,
	UsePlayerSource = true,

	-- Greetings Father.
	{ Cue = "/VO/ZagreusField_1105" },
	-- What now.
	{ Cue = "/VO/ZagreusField_1101", RequiredPlayed = { "/VO/ZagreusField_1105" } },
	-- Let's hear it.
	{ Cue = "/VO/ZagreusField_1102", RequiredPlayed = { "/VO/ZagreusField_1105" } },
	-- What's this.
	{ Cue = "/VO/ZagreusField_1103", RequiredPlayed = { "/VO/ZagreusField_1105" } },
	-- That you, Father?
	{ Cue = "/VO/ZagreusField_1104", RequiredPlayed = { "/VO/ZagreusField_1105" } },
	-- You have my attention.
	{ Cue = "/VO/ZagreusField_1106", RequiredPlayed = { "/VO/ZagreusField_1105" } },
	-- What's all this.
	{ Cue = "/VO/ZagreusField_1107", RequiredPlayed = { "/VO/ZagreusField_1105" } },
}
GlobalVoiceLines.PerfectClearStartVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.85,
	SuccessiveChanceToPlayAll = 0.33,
	PlayOnceFromTableThisRun = true,
	UsePlayerSource = true,

	ExplicitRequirements = true,
	GameStateRequirements =
	{
		-- None
	},

	-- Let's give it a go.
	{ Cue = "/VO/ZagreusField_1108" },
	-- They won't so much as scratch me.
	{ Cue = "/VO/ZagreusField_1109" },
	-- Let's go, you wretches.
	{ Cue = "/VO/ZagreusField_1110" },
	-- Can't touch me, you wretches.
	{ Cue = "/VO/ZagreusField_1111" },
	-- I so do like a challenge.
	{ Cue = "/VO/ZagreusField_1112" },
	-- Just you try and hit me.
	{ Cue = "/VO/ZagreusField_1113" },
	-- Let's see if I've still got it.
	{ Cue = "/VO/ZagreusField_1114" },
	-- They won't harm a hair on my head.
	{ Cue = "/VO/ZagreusField_1115" },
	-- Think you can hit me?
	{ Cue = "/VO/ZagreusField_1116" },
}
GlobalVoiceLines.PerfectClearGotHitVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.3,
	CooldownTime = 300,
	Queue = "Interrupt",
	UsePlayerSource = true,

	-- Ah, they got me!
	{ Cue = "/VO/ZagreusField_1117" },
	-- Augh, blew it.
	{ Cue = "/VO/ZagreusField_1118" },
	-- Tsch, lucky shot.
	{ Cue = "/VO/ZagreusField_1119" },
	-- Eugh damn it.
	{ Cue = "/VO/ZagreusField_1120" },
	-- Ungh I'm hit...!
	{ Cue = "/VO/ZagreusField_1121" },
	-- Ugh what?!
	{ Cue = "/VO/ZagreusField_1122" },
	-- Khh, got me!
	{ Cue = "/VO/ZagreusField_1123" },
	-- Ugh, great.
	{ Cue = "/VO/ZagreusField_1124" },
	-- Ungf no...
	{ Cue = "/VO/ZagreusField_1125" },
	-- Mph no, not the onion...!
	{ Cue = "/VO/ZagreusField_1215", RequiredPlayed = { "/VO/ZagreusField_1198", "/VO/ZagreusField_1199", "/VO/ZagreusField_1200" } },
	-- Aack, onion, damn!
	{ Cue = "/VO/ZagreusField_1216", RequiredPlayed = { "/VO/ZagreusField_1198", "/VO/ZagreusField_1199", "/VO/ZagreusField_1200" } },
}
GlobalVoiceLines.PerfectClearCompleteVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 3.25,
	SuccessiveChanceToPlayAll = 0.75,

	-- Yes.
	{ Cue = "/VO/ZagreusField_1126", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- Yes...!
	{ Cue = "/VO/ZagreusField_1127", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- Simple.
	{ Cue = "/VO/ZagreusField_1128", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- Easy.
	{ Cue = "/VO/ZagreusField_1129", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- No problem.
	{ Cue = "/VO/ZagreusField_1130", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- No problem!
	{ Cue = "/VO/ZagreusField_1131", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- There we go.
	{ Cue = "/VO/ZagreusField_1132", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- How's that?
	{ Cue = "/VO/ZagreusField_1133", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- How's that!
	{ Cue = "/VO/ZagreusField_1134", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- There.
	{ Cue = "/VO/ZagreusField_1135", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- What do I get?
	{ Cue = "/VO/ZagreusField_1136", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- Short work.
	{ Cue = "/VO/ZagreusField_1137", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- Whew.
	{ Cue = "/VO/ZagreusField_1138", CurrentEncounterValueFalse = "PlayerTookDamage", CooldownName = "SaidWhewRecently", CooldownTime = 30 },

	-- Eugh...
	{ Cue = "/VO/ZagreusField_1139", CurrentEncounterValueTrue = "PlayerTookDamage" },
	-- Ah, that's it?
	{ Cue = "/VO/ZagreusField_1140", CurrentEncounterValueTrue = "PlayerTookDamage" },
	-- Ah, well...
	{ Cue = "/VO/ZagreusField_1141", CurrentEncounterValueTrue = "PlayerTookDamage" },
	-- Eh...
	{ Cue = "/VO/ZagreusField_1142", CurrentEncounterValueTrue = "PlayerTookDamage" },
	-- Not my best.
	{ Cue = "/VO/ZagreusField_1143", CurrentEncounterValueTrue = "PlayerTookDamage" },
	-- Well moving on.
	{ Cue = "/VO/ZagreusField_1144", CurrentEncounterValueTrue = "PlayerTookDamage" },
	-- Hope no one saw that.
	{ Cue = "/VO/ZagreusField_1145", CurrentEncounterValueTrue = "PlayerTookDamage" },
	-- Oof.
	{ Cue = "/VO/ZagreusField_1146", CurrentEncounterValueTrue = "PlayerTookDamage" },
	-- Sloppy of me.
	{ Cue = "/VO/ZagreusField_1147", CurrentEncounterValueTrue = "PlayerTookDamage" },
}
GlobalVoiceLines.CharonFightStartVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 1.1,
	UsePlayerSource = true,
	SuccessiveChanceToPlayAll = 0.5,

	-- Let's settle this like gentlemen, Charon!
	{ Cue = "/VO/ZagreusField_3750" },
	-- You just might be my favorite sparring partner, mate!
	{ Cue = "/VO/ZagreusField_3751", RequiredPlayed = { "/VO/ZagreusField_3750" } },
	-- Come on, let's have another go of it!
	{ Cue = "/VO/ZagreusField_3752", RequiredPlayed = { "/VO/ZagreusField_3750" } },
	-- Think you can beat me, Charon?
	{ Cue = "/VO/ZagreusField_3753", RequiredPlayed = { "/VO/ZagreusField_3750" } },
	-- Sure beats having to ferry souls about, right?
	{ Cue = "/VO/ZagreusField_3754", RequiredPlayed = { "/VO/ZagreusField_3750" } },
	-- Let's go, Charon!
	{ Cue = "/VO/ZagreusField_3755", RequiredPlayed = { "/VO/ZagreusField_3750" } },
	-- You and me, Charon mate!
	{ Cue = "/VO/ZagreusField_3756", RequiredPlayed = { "/VO/ZagreusField_3750" } },
	-- You and me, mate!
	{ Cue = "/VO/ZagreusField_3757", RequiredPlayed = { "/VO/ZagreusField_3750" } },
}
GlobalVoiceLines.CharonFightRewardVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.8,
		UsePlayerSource = true,
		PlayOnce = true,
		PlayOnceContext = "CharonFightFirstVictory",

		-- No way, a membership card? For me?
		{ Cue = "/VO/ZagreusField_3766" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.8,
		UsePlayerSource = true,
		RequiredPlayed = { "/VO/ZagreusField_3766" },
		SuccessiveChanceToPlay = 0.33,

		-- Aw, for me?
		{ Cue = "/VO/ZagreusField_2563" },
		-- No way, a membership card? For me?
		{ Cue = "/VO/ZagreusField_3766" },
		-- Why, thank you.
		{ Cue = "/VO/ZagreusField_3320" },
		-- Ah, yes!
		{ Cue = "/VO/ZagreusField_4097" },
		-- Rewards card!
		{ Cue = "/VO/ZagreusField_4098" },
		-- My membership card!
		{ Cue = "/VO/ZagreusField_4099" },
		-- My membership is renewed.
		{ Cue = "/VO/ZagreusField_4100" },
		-- Well, sign me up!
		{ Cue = "/VO/ZagreusField_4101" },
		-- Hey, thought I lost that!
		{ Cue = "/VO/ZagreusField_4102" },
		-- Aw, for me?
		{ Cue = "/VO/ZagreusField_4103" },
		-- My card!
		{ Cue = "/VO/ZagreusField_4104" },
	},

}

GlobalVoiceLines.OnslaughtCompleteVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 3.25,
	SuccessiveChanceToPlayAll = 0.75,

	ExplicitRequirements = true,
	GameStateRequirements =
	{
		-- None
	},

	-- You had it coming.
	{ Cue = "/VO/ZagreusField_0019" },
	-- You can't stop me.
	{ Cue = "/VO/ZagreusField_0021" },
	-- Blasted fools.
	{ Cue = "/VO/ZagreusField_0023" },
	-- Pathetic.
	{ Cue = "/VO/ZagreusField_0027" },
	-- Nice meeting you.
	{ Cue = "/VO/ZagreusField_0029" },
	-- Enough.
	{ Cue = "/VO/ZagreusField_0317" },
	-- Always a pleasure.
	{ Cue = "/VO/ZagreusField_0319" },
	-- So much for them.
	{ Cue = "/VO/ZagreusField_0323" },
	-- Suffer in darkness.
	{ Cue = "/VO/ZagreusField_0574" },
	-- Will that be all?
	{ Cue = "/VO/ZagreusField_0576" },
	-- Good-bye for now.
	{ Cue = "/VO/ZagreusField_0578" },
	-- Good riddance.
	{ Cue = "/VO/ZagreusField_0580", CooldownName = "SaidGoodRecently", CooldownTime = 40, },
	-- That's settled, then.
	{ Cue = "/VO/ZagreusField_0582" },
	-- Simple.
	{ Cue = "/VO/ZagreusField_0592" },
}

GlobalVoiceLines.RecordRunDepthVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PlayOnceFromTableThisRun = true,
	RequiredMinCompletedRuns = 1,
	PreLineWait = 0.35,
	RequiredFalseRoomSet = "Secrets",
	RequiredFalseRooms = { "A_PreBoss01", "A_Boss01", "B_Intro", "B_PreBoss01", "B_Boss01", "B_Boss02", "C_Intro", "C_PreBoss01", "C_Boss01", "D_Hub", "D_Boss01", },
	RequiresLastRunNotCleared = true,
	RequiredRunsCleared = 0,

	-- Farthest I've come.
	{ Cue = "/VO/ZagreusField_0183" },
	-- Never gone this far.
	{ Cue = "/VO/ZagreusField_0184" },
	-- Don't think I've gone this far.
	{ Cue = "/VO/ZagreusField_0331" },
	-- This the farthest I've come?
	{ Cue = "/VO/ZagreusField_0332" },
	-- Made it this far.
	{ Cue = "/VO/ZagreusField_0333" },
	-- Long way from home.
	{ Cue = "/VO/ZagreusField_0334" },
	-- Never been this far.
	{ Cue = "/VO/ZagreusField_0335" },
}
GlobalVoiceLines.EnteredReprieveRoomVoiceLines =
{
	{
		PlayOnce = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.75,

		-- Must be the Fountain Chamber I commissioned back at home...
		{ Cue = "/VO/ZagreusField_2914", RequiredCosmetics = { "TartarusReprieve" }, RequiredRoom = "A_Reprieve01" },
		-- Ah good, this has to be the chamber renovation I put in.
		{ Cue = "/VO/ZagreusField_2915", RequiredCosmetics = { "AsphodelReprieve" }, RequiredRoom = "B_Reprieve01" },
		-- Glad I put in the order for a Fountain Chamber in this area.
		{ Cue = "/VO/ZagreusField_2916", RequiredCosmetics = { "ElysiumReprieve" }, RequiredRoom = "C_Reprieve01" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.15,
		RequiredMinHealthFraction = 1.0,
		SuccessiveChanceToPlay = 0.05,

		-- Got to use the fountain to get out of here.
		{ Cue = "/VO/ZagreusField_1824", },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.15,
		SuccessiveChanceToPlayAll = 0.33,

		-- Peace and quiet.
		{ Cue = "/VO/ZagreusField_0193" },
		-- Looks clear.
		{ Cue = "/VO/ZagreusField_0764" },
		-- Anyone there...?
		{ Cue = "/VO/ZagreusField_0765" },
		-- A fountain chamber.
		{ Cue = "/VO/ZagreusField_0766" },
		-- The Fates are being kind I guess.
		{ Cue = "/VO/ZagreusField_0767" },
		-- Guess I get a break.
		{ Cue = "/VO/ZagreusField_0768" },
		-- A welcome sight.
		{ Cue = "/VO/ZagreusField_0769" },
		-- Clear for now.
		{ Cue = "/VO/ZagreusField_0770" },
		-- Whew.
		{ Cue = "/VO/ZagreusField_0771", CooldownName = "SaidWhewRecently", CooldownTime = 30 },
		-- No one's here.
		{ Cue = "/VO/ZagreusField_1602" },
		-- Bit of a break.
		{ Cue = "/VO/ZagreusField_1603" },
		-- So quiet.
		{ Cue = "/VO/ZagreusField_1604" },
		-- Whew...
		{ Cue = "/VO/ZagreusField_2682", RequiredBiome = "Asphodel", },
		-- Whew...
		{ Cue = "/VO/ZagreusField_2683" },
		-- Best spot in Asphodel...
		{ Cue = "/VO/ZagreusField_2684", RequiredBiome = "Asphodel", },
		-- Fountain chamber...
		{ Cue = "/VO/ZagreusField_2685" },
		-- Respite...
		{ Cue = "/VO/ZagreusField_2686" },
		-- Nice place...
		{ Cue = "/VO/ZagreusField_2687" },
		-- Did Daedalus himself build all of this...?
		{ Cue = "/VO/ZagreusField_2712", RequiredBiome = "Elysium" },
		-- Must be the work of Daedalus.
		-- { Cue = "/VO/ZagreusField_2688", RequiredBiome = "Elysium", PlayOnce = true, },
		-- Here again.
		{ Cue = "/VO/ZagreusField_2689", RequiredBiome = "Tartarus", },
		-- Oh. Good.
		{ Cue = "/VO/ZagreusField_2690" },
		-- Can catch my breath...
		{ Cue = "/VO/ZagreusField_2691" },
	}
}

GlobalVoiceLines.GiftDropPickUpVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.7,
	SuccessiveChanceToPlay = 0.15,
	RequiredFalseEncounters = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", },
	Cooldowns =
	{
		{ Name = "ZagreusAnyQuipSpeech" },
	},

	-- Nice.
	{ Cue = "/VO/ZagreusField_0229" },
	-- Excellent.
	{ Cue = "/VO/ZagreusField_0230" },
	-- I'll take it.
	{ Cue = "/VO/ZagreusField_0232" },
	-- All mine.
	{ Cue = "/VO/ZagreusField_0233" },
	-- Cheers.
	{ Cue = "/VO/ZagreusField_0236" },
	-- Someone's going to enjoy this.
	{ Cue = "/VO/ZagreusField_1036" },
	-- Someone'll like this.
	{ Cue = "/VO/ZagreusField_1037" },
	-- Good stuff.
	{ Cue = "/VO/ZagreusField_1038" },
}

GlobalVoiceLines.ExitedAsphodelRoomVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	SuccessiveChanceToPlay = 0.33,
	CooldownTime = 300,
	RequiredFalseRooms = { "B_Intro", "B_Story01", "B_Boss01", "B_Boss02" },
	PlayOnceFromTableThisRun = true,
	UsePlayerSource = true,

	-- Let's get out of here.
	{ Cue = "/VO/ZagreusField_0892" },
	-- On to the next one.
	{ Cue = "/VO/ZagreusField_0893" },
	-- All aboard.
	{ Cue = "/VO/ZagreusField_0894" },
	-- Onward.
	{ Cue = "/VO/ZagreusField_0895" },
	-- Course is set.
	{ Cue = "/VO/ZagreusField_0896" },
	-- Get me out of here.
	{ Cue = "/VO/ZagreusField_0897" },
	-- Next island.
	{ Cue = "/VO/ZagreusField_0898" },
	-- Off we go.
	{ Cue = "/VO/ZagreusField_3985" },
	-- And we're off.
	{ Cue = "/VO/ZagreusField_3986" },
	-- Moving on.
	{ Cue = "/VO/ZagreusField_3987" },
	-- Moving right along.
	{ Cue = "/VO/ZagreusField_3988" },
	-- Easy does it...
	{ Cue = "/VO/ZagreusField_3989" },
	-- Steady now...
	{ Cue = "/VO/ZagreusField_3990" },
}
GlobalVoiceLines.EnteredFuryChamberVoiceLines =
{
	{
		PreLineWait = 1.35,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.5,
		RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },

		-- Hi you three.
		{ Cue = "/VO/ZagreusField_2595", RequiredActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 }, RequiredMinSupportAINames = 2, RequiredPlayed = { "/VO/ZagreusField_2597" } },
		-- Hi you two.
		{ Cue = "/VO/ZagreusField_2596", RequiredActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 }, RequiredMaxSupportAINames = 1, RequiredPlayed = { "/VO/ZagreusField_2597" } },
		-- Uh....
		{ Cue = "/VO/ZagreusField_2597" },
		-- Hello, Fury Sisters.
		{ Cue = "/VO/ZagreusField_2598", RequiredPlayed = { "/VO/ZagreusField_2597" } },
		-- I'm back, ladies.
		{ Cue = "/VO/ZagreusField_2599", RequiredPlayed = { "/VO/ZagreusField_2597" } },
		-- Hope I didn't keep you waiting, ladies.
		{ Cue = "/VO/ZagreusField_2600", RequiredPlayed = { "/VO/ZagreusField_2597" } },
	},
	{
		RequiredRoom = "A_Boss01",
		{
			RequiredLastLinePlayed = { "/VO/ZagreusField_1574", "/VO/ZagreusField_1575", "/VO/ZagreusField_1576" },
			PreLineWait = 1.35,
			BreakIfPlayed = true,
			RandomRemaining = true,

			-- I knew it.
			{ Cue = "/VO/ZagreusField_1580" },
			-- What do you know.
			{ Cue = "/VO/ZagreusField_1581" },
			-- Sure enough!
			{ Cue = "/VO/ZagreusField_1582" },
		},
		{
			RequiredLastLinePlayed = { "/VO/ZagreusField_1571", "/VO/ZagreusField_1572", "/VO/ZagreusField_1573", "/VO/ZagreusField_1577", "/VO/ZagreusField_1578", "/VO/ZagreusField_1579" },
			PreLineWait = 1.35,
			BreakIfPlayed = true,
			RandomRemaining = true,

			-- Guess not.
			{ Cue = "/VO/ZagreusField_1583" },
			-- Oh well.
			{ Cue = "/VO/ZagreusField_1584" },
			-- Guess I was wrong.
			{ Cue = "/VO/ZagreusField_1585" },
			-- Not quite.
			{ Cue = "/VO/ZagreusField_1586" },
		},
		{
			PreLineWait = 1.35,
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlayAll = 0.5,

			-- It's you.
			-- { Cue = "/VO/ZagreusField_0868" },
			-- Well this is awkward.
			{ Cue = "/VO/ZagreusField_0870", RequiredFalseTextLines = { "MegaeraGift03" } },
			-- Oh, no.
			{ Cue = "/VO/ZagreusField_0869", RequiredPlayed = { "/VO/ZagreusField_0870" }, RequiredFalseTextLines = { "MegaeraGift07" } },
			-- Hi, Meg.
			{ Cue = "/VO/ZagreusField_0324", RequiredPlayed = { "/VO/ZagreusField_0870" }, },
			-- Oh hello!
			{ Cue = "/VO/ZagreusField_0441", RequiredPlayed = { "/VO/ZagreusField_0870" }, },
			-- Hey there Meg.
			{ Cue = "/VO/ZagreusField_0326", RequiredPlayed = { "/VO/ZagreusField_0870" }, },
			-- Hello, Meg.
			{ Cue = "/VO/ZagreusField_0437", RequiredPlayed = { "/VO/ZagreusField_0870" }, },
			-- I'm back, Meg.
			{ Cue = "/VO/ZagreusField_0438", RequiredPlayed = { "/VO/ZagreusField_0870" }, },
			-- I'm here, Meg.
			{ Cue = "/VO/ZagreusField_0439", RequiredPlayed = { "/VO/ZagreusField_0870" }, },
			-- We meet again!
			{ Cue = "/VO/ZagreusField_0440", RequiredPlayed = { "/VO/ZagreusField_0870" }, },
			-- Can't get rid of me, Meg.
			{ Cue = "/VO/ZagreusField_0442", RequiredPlayed = { "/VO/ZagreusField_0870" }, },
			-- Miss me, Meg?
			{ Cue = "/VO/ZagreusField_1370", RequiredPlayed = { "/VO/ZagreusField_0870" }, RequiredTextLines = { "MegaeraGift01", "MegaeraMeeting05" } },
			-- What's new, Meg.
			{ Cue = "/VO/ZagreusField_1371", RequiredPlayed = { "/VO/ZagreusField_0870" }, RequiredTextLines = { "MegaeraGift01", "MegaeraMeeting05" } },
			-- Hello.
			{ Cue = "/VO/ZagreusField_1372", RequiredPlayed = { "/VO/ZagreusField_0870" }, RequiredTextLines = { "MegaeraGift01", "MegaeraMeeting05" } },
			-- Hi there.
			{ Cue = "/VO/ZagreusField_1373", RequiredPlayed = { "/VO/ZagreusField_0870" }, RequiredTextLines = { "MegaeraGift01", "MegaeraMeeting05" } },
			-- Shall we?
			{ Cue = "/VO/ZagreusField_1374", RequiredPlayed = { "/VO/ZagreusField_0870" }, RequiredTextLines = { "MegaeraGift01", "MegaeraMeeting05" } },
			-- Sorry I'm late.
			{ Cue = "/VO/ZagreusField_1375", RequiredPlayed = { "/VO/ZagreusField_0870" }, RequiredTextLines = { "MegaeraGift01", "MegaeraMeeting05" } },
			-- Got here as fast as I could.
			{ Cue = "/VO/ZagreusField_1376", RequiredPlayed = { "/VO/ZagreusField_0870" }, RequiredTextLines = { "MegaeraGift01", "MegaeraMeeting05" } },
			-- Megaera.
			{ Cue = "/VO/ZagreusField_1377", RequiredPlayed = { "/VO/ZagreusField_0870" }, RequiredTextLines = { "MegaeraGift01", "MegaeraMeeting05" } },
			-- Here we are.
			{ Cue = "/VO/ZagreusField_1378", RequiredPlayed = { "/VO/ZagreusField_0870" }, RequiredTextLines = { "MegaeraGift01", "MegaeraMeeting05" } },
		},
	},
	{
		RequiredRoom = "A_Boss02",
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.66,
			RequiredLastLinePlayed = { "/VO/ZagreusField_1571", "/VO/ZagreusField_1572", "/VO/ZagreusField_1573" },
			PreLineWait = 1.35,

			-- I knew it.
			{ Cue = "/VO/ZagreusField_1580" },
			-- What do you know.
			{ Cue = "/VO/ZagreusField_1581" },
			-- Sure enough!
			{ Cue = "/VO/ZagreusField_1582" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.66,
			RequiredLastLinePlayed = { "/VO/ZagreusField_1574", "/VO/ZagreusField_1575", "/VO/ZagreusField_1576", "/VO/ZagreusField_1577", "/VO/ZagreusField_1578", "/VO/ZagreusField_1579" },
			PreLineWait = 1.35,

			-- Guess not.
			{ Cue = "/VO/ZagreusField_1583" },
			-- Oh well.
			{ Cue = "/VO/ZagreusField_1584" },
			-- Guess I was wrong.
			{ Cue = "/VO/ZagreusField_1585" },
			-- Not quite.
			{ Cue = "/VO/ZagreusField_1586" },
		},
		{
			PreLineWait = 1.35,
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlayAll = 0.5,

			-- Oh, um. Hi there!
			{ Cue = "/VO/ZagreusField_1446", PreLineWait = 0.3 },
			-- Alecto.
			{ Cue = "/VO/ZagreusField_1447", RequiredPlayed = { "/VO/ZagreusField_1446" } },
			-- Oh great.
			{ Cue = "/VO/ZagreusField_1448", RequiredPlayed = { "/VO/ZagreusField_1446" } },
			-- I'm back!
			{ Cue = "/VO/ZagreusField_1449", RequiredPlayed = { "/VO/ZagreusField_1446" } },
			-- Oh, hi.
			{ Cue = "/VO/ZagreusField_1450", RequiredPlayed = { "/VO/ZagreusField_1446" } },
			-- Greetings, Alecto.
			{ Cue = "/VO/ZagreusField_1451", RequiredPlayed = { "/VO/ZagreusField_1446" } },
			-- Alecto!
			{ Cue = "/VO/ZagreusField_3820", RequiredPlayed = { "/VO/ZagreusField_1446" } },
			-- Alecto...
			{ Cue = "/VO/ZagreusField_3821", RequiredPlayed = { "/VO/ZagreusField_1446" } },
			-- You again.
			{ Cue = "/VO/ZagreusField_3822", RequiredPlayed = { "/VO/ZagreusField_1446" } },
			-- Lovely.
			{ Cue = "/VO/ZagreusField_3823", RequiredPlayed = { "/VO/ZagreusField_1446" } },
		},
	},
	{
		RequiredRoom = "A_Boss03",
		{
			RequiredLastLinePlayed = { "/VO/ZagreusField_1577", "/VO/ZagreusField_1578", "/VO/ZagreusField_1579" },
			PreLineWait = 1.35,
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.66,

			-- I knew it.
			{ Cue = "/VO/ZagreusField_1580" },
			-- What do you know.
			{ Cue = "/VO/ZagreusField_1581" },
			-- Sure enough!
			{ Cue = "/VO/ZagreusField_1582" },
		},
		{
			RequiredLastLinePlayed = { "/VO/ZagreusField_1571", "/VO/ZagreusField_1572", "/VO/ZagreusField_1573", "/VO/ZagreusField_1574", "/VO/ZagreusField_1575", "/VO/ZagreusField_1576" },
			PreLineWait = 1.35,
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.66,

			-- Guess not.
			{ Cue = "/VO/ZagreusField_1583" },
			-- Oh well.
			{ Cue = "/VO/ZagreusField_1584" },
			-- Guess I was wrong.
			{ Cue = "/VO/ZagreusField_1585" },
			-- Not quite.
			{ Cue = "/VO/ZagreusField_1586" },
		},
		{
			PreLineWait = 1.35,
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlayAll = 0.5,

			-- Erm... nice to meet you?
			{ Cue = "/VO/ZagreusField_1452", PreLineWait = 0.6, PlayOnce = true, },
			-- Think I know what you're going to say.
			{ Cue = "/VO/ZagreusField_1453", PreLineWait = 0.6, RequiredPlayed = { "/VO/ZagreusField_1452" },
				MinRunsSinceAnyTextLines = {
					TextLines = {
						"Fury3Encounter07",
						"Fury3Encounter08",
						"Fury3Encounter09",
						"Fury3Encounter10",
						"Fury3Encounter11",
						"Fury3Encounter12",
						"Fury3Encounter13",
						"Fury3Encounter14",
					}, Count = 3 },
			 },
			-- Let's hear it.
			{ Cue = "/VO/ZagreusField_1454", RequiredPlayed = { "/VO/ZagreusField_1452" } },
			-- Hello, Tisiphone.
			{ Cue = "/VO/ZagreusField_1455", RequiredPlayed = { "/VO/ZagreusField_1452" } },
			-- Tisiphone.
			{ Cue = "/VO/ZagreusField_1456", RequiredPlayed = { "/VO/ZagreusField_1452" } },
			-- Oh good.
			{ Cue = "/VO/ZagreusField_1457", RequiredPlayed = { "/VO/ZagreusField_1452" } },
			-- Tisiphone!
			{ Cue = "/VO/ZagreusField_3838", RequiredTextLines = { "Fury3Encounter06" }, },
			-- Erm... hello.
			{ Cue = "/VO/ZagreusField_3839", RequiredPlayed = { "/VO/ZagreusField_1452" } },
			-- Erm... hi.
			{ Cue = "/VO/ZagreusField_3840", RequiredPlayed = { "/VO/ZagreusField_1452" } },
			-- Friends?
			{ Cue = "/VO/ZagreusField_3841", RequiredTextLines = { "Fury3Encounter14" }, },
			-- Friends? Maybe?
			{ Cue = "/VO/ZagreusField_3842", RequiredTextLines = { "Fury3Encounter14" }, },
		},
	},
}
GlobalVoiceLines.BarelySurvivedBossFightVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 7.1,
	RequiredMaxHealthFraction = 0.25,
	RequiredMaxLastStands = 0,
	SuccessiveChanceToPlay = 0.33,
	UsePlayerSource = true,

	-- Urgh, much too close...
	{ Cue = "/VO/ZagreusField_4347" },
	-- Mmph, good enough, I guess...
	{ Cue = "/VO/ZagreusField_4348" },
	-- ...Whew....
	{ Cue = "/VO/ZagreusField_4349" },
	-- ...Made it, barely...
	{ Cue = "/VO/ZagreusField_4350" },
	-- ...Could have been me.
	{ Cue = "/VO/ZagreusField_4351" },
	-- ...No problem...
	{ Cue = "/VO/ZagreusField_4352" },
	-- ...That's that, then.
	{ Cue = "/VO/ZagreusField_4353" },
	-- ...Almost had me.
	{ Cue = "/VO/ZagreusField_4354" },
	-- ...Could have gone worse.
	{ Cue = "/VO/ZagreusField_4355" },
	-- ...Barely got through...
	{ Cue = "/VO/ZagreusField_4356" },
	-- ...Much too close.
	{ Cue = "/VO/ZagreusField_4357" },
	-- ...Heh. Alive and well.
	{ Cue = "/VO/ZagreusField_4358" },
}

GlobalVoiceLines.BarelySurvivedFinalBossFightVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 1.5,
	RequiredMaxHealthFraction = 0.25,
	RequiredMaxLastStands = 0,
	SuccessiveChanceToPlay = 0.33,
	UsePlayerSource = true,

	-- Urgh, much too close...
	{ Cue = "/VO/ZagreusField_4347" },
	-- Mmph, good enough, I guess...
	{ Cue = "/VO/ZagreusField_4348" },
	-- ...Whew....
	{ Cue = "/VO/ZagreusField_4349" },
	-- ...Made it, barely...
	{ Cue = "/VO/ZagreusField_4350" },
	-- ...Could have been me.
	{ Cue = "/VO/ZagreusField_4351" },
	-- ...No problem...
	{ Cue = "/VO/ZagreusField_4352" },
	-- ...That's that, then.
	{ Cue = "/VO/ZagreusField_4353" },
	-- ...Almost had me.
	{ Cue = "/VO/ZagreusField_4354" },
	-- ...Could have gone worse.
	{ Cue = "/VO/ZagreusField_4355" },
	-- ...Barely got through...
	{ Cue = "/VO/ZagreusField_4356" },
	-- ...Much too close.
	{ Cue = "/VO/ZagreusField_4357" },
	-- ...Heh. Alive and well.
	{ Cue = "/VO/ZagreusField_4358" },
}
GlobalVoiceLines.FuryVanquishedGlobalVoiceLines =
{
	[1] = GlobalVoiceLines.BarelySurvivedBossFightVoiceLines,
	-- multi furies
	[2] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 8.2,
		CooldownName = "MiscPostBossCooldown",
		CooldownTime = 18,
		SuccessiveChanceToPlay = 0.2,
		RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
		RequiredMinSupportAINames = 2,

		-- The other two took off...
		{ Cue = "/VO/ZagreusField_2534" },
		-- The others flew off...
		{ Cue = "/VO/ZagreusField_2535" },
		-- The other sisters left...
		{ Cue = "/VO/ZagreusField_2536" },
		-- Where'd the others go?
		{ Cue = "/VO/ZagreusField_2537" },
	},
	-- two furies
	[3] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 8.2,
		CooldownName = "MiscPostBossCooldown",
		CooldownTime = 18,
		SuccessiveChanceToPlay = 0.2,
		RequiredRoom = "A_Boss02",
		RequiredActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
		RequiredSupportAINames = { "Megaera" },
		RequiredFalseSupportAINames = { "Tisiphone", "Alecto" },

		-- Meg took off...
		{ Cue = "/VO/ZagreusField_2542" },
		-- Meg flew off...
		{ Cue = "/VO/ZagreusField_2543" },
	},
	[4] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 8.2,
		CooldownName = "MiscPostBossCooldown",
		CooldownTime = 18,
		SuccessiveChanceToPlay = 0.2,
		RequiredRoom = "A_Boss01",
		RequiredActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
		RequiredSupportAINames = { "Alecto" },
		RequiredFalseSupportAINames = { "Megaera", "Tisiphone" },

		-- Alecto took off...
		{ Cue = "/VO/ZagreusField_2538" },
		-- Alecto flew off.
		{ Cue = "/VO/ZagreusField_2539" },
	},
	[5] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 8.2,
		CooldownName = "MiscPostBossCooldown",
		CooldownTime = 18,
		SuccessiveChanceToPlay = 0.2,
		RequiredActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
		RequiredSupportAINames = { "Tisiphone" },
		RequiredFalseSupportAINames = { "Megaera", "Alecto" },

		-- Tisiphone took took off...
		{ Cue = "/VO/ZagreusField_2540" },
		-- Tisiphone flew off...
		{ Cue = "/VO/ZagreusField_2541" },
	},
	[6] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 8.2,
		CooldownName = "MiscPostBossCooldown",
		CooldownTime = 18,
		SuccessiveChanceToPlay = 0.15,
		RequiredActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
		RequiredMaxSupportAINames = 1,

		-- The other sister left...
		{ Cue = "/VO/ZagreusField_2532" },
		-- Where'd the other one go?
		{ Cue = "/VO/ZagreusField_2533" },
	},
	-- meg only
	[7] =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 7.2,
			CooldownName = "MiscPostBossCooldown",
			CooldownTime = 18,
			RequiredRoom = "A_Boss01",
			RequiredTextLines = { "MegaeraGift07" },

			-- Strictly business.
			{ Cue = "/VO/ZagreusField_3963" },
			-- No hard feelings.
			{ Cue = "/VO/ZagreusField_3964", RequiredTextLines = { "MegaeraGift08" }, },
			-- See you back home.
			{ Cue = "/VO/ZagreusField_3965" },
			-- Bye, Meg.
			{ Cue = "/VO/ZagreusField_3966", RequiredAnyTextLines = { "BecameCloseWithMegaera01", "BecameCloseWithMegaera01_B" }, },
			-- Nice seeing you?
			{ Cue = "/VO/ZagreusField_3967" },
			-- Nice seeing you.
			{ Cue = "/VO/ZagreusField_3968", RequiredTextLines = { "MegaeraGift09" }, },
			-- Well, it's been lovely.
			{ Cue = "/VO/ZagreusField_3969", RequiredTextLines = { "MegaeraGift10" }, },
			-- Hope she's not mad.
			{ Cue = "/VO/ZagreusField_3970", RequiredTextLines = { "MegaeraGift08" }, },
			-- She's going to be mad.
			{ Cue = "/VO/ZagreusField_3971" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 7.2,
			CooldownName = "MiscPostBossCooldown",
			CooldownTime = 18,
			RequiredRoom = "A_Boss01",
			RequiredFalseTextLines = { "MegaeraGift07" },

			-- Got you that time, Meg.
			{ Cue = "/VO/ZagreusField_0174" },
			-- Be seeing you around, Meg.
			{ Cue = "/VO/ZagreusField_0173", },
			-- Got you.
			{ Cue = "/VO/ZagreusField_0175" },
			-- Yes!
			{ Cue = "/VO/ZagreusField_0327" },
			-- Yes.
			{ Cue = "/VO/ZagreusField_0328" },
			-- I did it!
			{ Cue = "/VO/ZagreusField_0329" },
			-- I did it.
			{ Cue = "/VO/ZagreusField_0330" },
		},
	},
	-- alecto only
	[8] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 7.6,
		SuccessiveChanceToPlayAll = 0.5,
		RequiredRoom = "A_Boss02",

		-- Get out.
		{ Cue = "/VO/ZagreusField_1458", RequiredPlayed = { "/VO/ZagreusField_1463" } },
		-- That's that, then.
		{ Cue = "/VO/ZagreusField_1459", RequiredPlayed = { "/VO/ZagreusField_1463" } },
		-- She wasn't very nice.
		{ Cue = "/VO/ZagreusField_1460", RequiredPlayed = { "/VO/ZagreusField_1463" } },
		-- Tell Meg I said hello.
		{ Cue = "/VO/ZagreusField_1461", RequiredPlayed = { "/VO/ZagreusField_1463" }, RequiredFalseSupportAINames = { "Megaera" }, },
		-- See you later.
		{ Cue = "/VO/ZagreusField_1462", RequiredPlayed = { "/VO/ZagreusField_1463" } },
		-- I don't like her very much.
		{ Cue = "/VO/ZagreusField_1463" },
		-- Ugh, that one...
		{ Cue = "/VO/ZagreusField_4495", RequiredPlayed = { "/VO/ZagreusField_1463" } },
		-- <Deep Breath>
		{ Cue = "/VO/ZagreusField_4496", RequiredPlayed = { "/VO/ZagreusField_1463" }, RequiredMaxHealthFraction = 0.3 },
		-- She's tough...
		{ Cue = "/VO/ZagreusField_4497", RequiredPlayed = { "/VO/ZagreusField_1463" } },
		-- Got her.
		{ Cue = "/VO/ZagreusField_4498", RequiredPlayed = { "/VO/ZagreusField_1463" } },
		-- She won't like this.
		{ Cue = "/VO/ZagreusField_4499", RequiredPlayed = { "/VO/ZagreusField_1463" } },
	},
	-- tisiphone only
	[9] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 7.6,
		SuccessiveChanceToPlayAll = 0.5,
		RequiredRoom = "A_Boss03",

		-- Peace, Tisiphone.
		{ Cue = "/VO/ZagreusField_1464", RequiredPlayed = { "/VO/ZagreusField_1465" } },
		-- That's one way to prove I'm innocent.
		{ Cue = "/VO/ZagreusField_1465" },
		-- Glad that's over.
		{ Cue = "/VO/ZagreusField_1466", RequiredPlayed = { "/VO/ZagreusField_1465" } },
		-- Hope she won't be back anytime soon.
		{ Cue = "/VO/ZagreusField_1467", RequiredPlayed = { "/VO/ZagreusField_1465" } },
		-- Always disturbing.
		{ Cue = "/VO/ZagreusField_1468", RequiredPlayed = { "/VO/ZagreusField_1465" } },
		-- Go wrongfully accuse somebody else.
		{ Cue = "/VO/ZagreusField_1469", RequiredPlayed = { "/VO/ZagreusField_1465" }, RequiredFalseTextLines = { "Fury3Encounter12" }, },
		-- No murder.
		{ Cue = "/VO/ZagreusField_4489", RequiredPlayed = { "/VO/ZagreusField_1465" }, },
		-- I'm innocent.
		{ Cue = "/VO/ZagreusField_4490", RequiredPlayed = { "/VO/ZagreusField_1465" }, },
		-- Next time, Tisiphone.
		{ Cue = "/VO/ZagreusField_4491", RequiredPlayed = { "/VO/ZagreusField_1465" }, RequiredTextLines = { "Fury3Encounter12" }, },
		-- See you again I'm sure.
		{ Cue = "/VO/ZagreusField_4492", RequiredPlayed = { "/VO/ZagreusField_1465" }, RequiredTextLines = { "Fury3Encounter12" }, },
		-- She's a bit much.
		{ Cue = "/VO/ZagreusField_4493", RequiredPlayed = { "/VO/ZagreusField_1465" }, },
		-- Nice chatting.
		{ Cue = "/VO/ZagreusField_4494", RequiredPlayed = { "/VO/ZagreusField_1465" }, },
	},
	[10] = GlobalVoiceLines.ChaosReactionVoiceLines,
}
GlobalVoiceLines.EnteredHydraChamberVoiceLines =
{
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		RequiredRoom = "B_Boss02",
		PreLineWait = 1.35,

		-- Erm, this is not the deadly Hydra chamber I expected.
		{ Cue = "/VO/ZagreusField_2601" },
		-- Bone Hydra! I love what you've done with the place!
		{ Cue = "/VO/ZagreusField_2602", RequiredPlayed = { "/VO/ZagreusField_2601" }, RequiredFalsePlayed = { "/VO/ZagreusField_3147" } },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 1.35,
		RequiredUnitAlive = "HydraHeadImmortalLavamaker",
		RequiredFalsePlayed = { "/VO/ZagreusField_3147" },

		-- Bone Hydra, you look... different...
		{ Cue = "/VO/ZagreusField_3925" },
		-- Changed up your look again, have you, Hydra?
		{ Cue = "/VO/ZagreusField_3927" },
		-- Another new look for you I see, Bone Hydra.
		{ Cue = "/VO/ZagreusField_3928" },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 1.35,
		RequiredUnitAlive = "HydraHeadImmortalSummoner",
		RequiredFalsePlayed = { "/VO/ZagreusField_3147" },

		-- Bone Hydra, you look... different...
		{ Cue = "/VO/ZagreusField_3925" },
		-- Changed up your look again, have you, Hydra?
		{ Cue = "/VO/ZagreusField_3927" },
		-- Another new look for you I see, Bone Hydra.
		{ Cue = "/VO/ZagreusField_3928" },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 1.35,
		RequiredUnitAlive = "HydraHeadImmortalSlammer",
		RequiredFalsePlayed = { "/VO/ZagreusField_3147" },

		-- Bone Hydra, you look positively smashing!
		{ Cue = "/VO/ZagreusField_3926" },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 1.35,
		RequiredUnitAlive = "HydraHeadImmortalWavemaker",
		RequiredFalsePlayed = { "/VO/ZagreusField_3147" },

		-- Bone Hydra, you look... different...
		{ Cue = "/VO/ZagreusField_3925" },
		-- Changed up your look again, have you, Hydra?
		{ Cue = "/VO/ZagreusField_3927" },
		-- Another new look for you I see, Bone Hydra.
		{ Cue = "/VO/ZagreusField_3928" },
	},
	{
		PlayOnce = true,
		PlayOnceContext = "NewHydraHeadEncounter",
		BreakIfPlayed = true,
		PreLineWait = 1.35,
		RequiredUnitAlive = "HydraHeadImmortalLavamaker",
		RequiredPlayed = { "/VO/ZagreusField_3147" },
		RequiredFalsePlayed = { "/VO/ZagreusField_3925" },

		-- Well, look at you, Lernie!
		{ Cue = "/VO/ZagreusField_3929" },
		-- May I say, you look lovely this day or night, Lernie?
		{ Cue = "/VO/ZagreusField_3930" },
	},
	{
		PlayOnce = true,
		PlayOnceContext = "NewHydraHeadEncounter",
		BreakIfPlayed = true,
		PreLineWait = 1.35,
		RequiredUnitAlive = "HydraHeadImmortalSummoner",
		RequiredPlayed = { "/VO/ZagreusField_3147" },
		RequiredFalsePlayed = { "/VO/ZagreusField_3925" },

		-- Well, look at you, Lernie!
		{ Cue = "/VO/ZagreusField_3929" },
		-- May I say, you look lovely this day or night, Lernie?
		{ Cue = "/VO/ZagreusField_3930" },
	},
	{
		PlayOnce = true,
		PlayOnceContext = "NewHydraHeadEncounter",
		BreakIfPlayed = true,
		PreLineWait = 1.35,
		RequiredUnitAlive = "HydraHeadImmortalSlammer",
		RequiredPlayed = { "/VO/ZagreusField_3147" },
		RequiredFalsePlayed = { "/VO/ZagreusField_3925" },

		-- Well, look at you, Lernie!
		{ Cue = "/VO/ZagreusField_3929" },
		-- May I say, you look lovely this day or night, Lernie?
		{ Cue = "/VO/ZagreusField_3930" },
	},
	{
		PlayOnce = true,
		PlayOnceContext = "NewHydraHeadEncounter",
		BreakIfPlayed = true,
		PreLineWait = 1.35,
		RequiredUnitAlive = "HydraHeadImmortalWavemaker",
		RequiredPlayed = { "/VO/ZagreusField_3147" },
		RequiredFalsePlayed = { "/VO/ZagreusField_3925" },

		-- Well, look at you, Lernie!
		{ Cue = "/VO/ZagreusField_3929" },
		-- May I say, you look lovely this day or night, Lernie?
		{ Cue = "/VO/ZagreusField_3930" },
	},
	{
		PlayOnce = true,
		PreLineWait = 1.35,
		RequiredPlayed = { "/VO/ZagreusField_0127", "/VO/ZagreusField_0447", "/VO/ZagreusField_0448", "/VO/ZagreusField_0449", "/VO/ZagreusField_0446", "/VO/ZagreusField_0450", "/VO/ZagreusField_0451", "/VO/ZagreusField_0452", "/VO/ZagreusField_1380", "/VO/ZagreusField_1381", "/VO/ZagreusField_1382", "/VO/ZagreusField_1383", "/VO/ZagreusField_1384" },
		RequiredKills = { HydraHeadImmortal = 20 },
		BreakIfPlayed = true,

		-- Bone Hydra, you're back! How wonderful.
		{ Cue = "/VO/ZagreusField_3142", },
		-- Hydra, I feel like we're just not getting through to one another, here.
		{ Cue = "/VO/ZagreusField_3143", },
		-- Bone Hydra, how come we never talk?
		{ Cue = "/VO/ZagreusField_3144", },
		-- Bone Hydra, if you understand me, menacingly hiss.
		{ Cue = "/VO/ZagreusField_3145", },
		-- Bone Hydra, I hope you know this isn't personal, don't you?
		{ Cue = "/VO/ZagreusField_3146", },
		-- Bone Hydra... can I call you Bone Hydra? Lernie, maybe? Lernie, I like that.
		-- note: ZagreusField_3147 is the Lernie Line
		{ Cue = "/VO/ZagreusField_3147", },
	},
	{
		PlayOnce = true,
		PreLineWait = 1.35,
		RequiredPlayed = { "/VO/ZagreusField_3147", },

		-- You don't mind if I call you Lernie from now on, right?
		{ Cue = "/VO/ZagreusField_3148" },
	},
	{
		PlayOnce = true,
		PreLineWait = 2.1,
		RequiredPlayed = { "/VO/ZagreusField_3148", },
		BreakIfPlayed = true,

		-- I'll take that as a 'No, not at all, thank you for asking, friend.'
		{ Cue = "/VO/ZagreusField_3149", },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.35,
		RequiredPlayed = { "/VO/ZagreusField_3142", "/VO/ZagreusField_3143", "/VO/ZagreusField_3144", "/VO/ZagreusField_3145", "/VO/ZagreusField_3146", "/VO/ZagreusField_3147", "/VO/ZagreusField_3148" },

		-- Why, hello, Lernie, what have you been up to since I last destroyed your multitude of heads?
		{ Cue = "/VO/ZagreusField_3150" },
		-- Good day, Lernie, and now? Prepare to die.
		{ Cue = "/VO/ZagreusField_3151" },
		-- How goes it lately, Lernie, everything just fine?
		{ Cue = "/VO/ZagreusField_3152" },
		-- I'm back, Lernie, to kill you once again!
		{ Cue = "/VO/ZagreusField_3153" },
		-- If only you knew just how I feel, Lernie.
		{ Cue = "/VO/ZagreusField_3154" },
		-- I know you missed me, Lernie, and I missed you, too!
		{ Cue = "/VO/ZagreusField_3155" },
		-- Lernie, wonderful to see you once again!
		{ Cue = "/VO/ZagreusField_3156" },
		-- What's the matter, Lernie? You seem quite upset!
		{ Cue = "/VO/ZagreusField_3157" },
		-- How is the lava temperature lately, Lernie?
		{ Cue = "/VO/ZagreusField_3158" },
		-- Lernie, if you'd like for me to kill you, hiss.
		{ Cue = "/VO/ZagreusField_3159" },
		-- Lernie, hiss once if you think you're going to lose.
		{ Cue = "/VO/ZagreusField_3160" },
		-- I see you re-grew your neck!
		{ Cue = "/VO/ZagreusField_2603", RequiredRoomLastRun = "B_PostBoss01", },
		-- How's the old neck holding up?
		{ Cue = "/VO/ZagreusField_2604" },
		-- Why, Lernie, you are looking positively fabulous, I have to say.
		{ Cue = "/VO/ZagreusField_3519" },
		-- Lernie, you really didn't have to reconstitute yourself just for my sake.
		{ Cue = "/VO/ZagreusField_3520" },
		-- Stopped anybody from attempting to leave Asphodel of late, Lernie?
		{ Cue = "/VO/ZagreusField_3521" },
		-- We'll have to catch up some other time, Lernie, as I'm in a bit of a rush.
		{ Cue = "/VO/ZagreusField_3522" },
		-- Not really in a talking mood this time, Lernie.
		{ Cue = "/VO/ZagreusField_3523" },
		-- All right, Lernie, let's have it out between us, then.
		{ Cue = "/VO/ZagreusField_3524" },
		-- Why must we always fight like this, Lernie?
		{ Cue = "/VO/ZagreusField_3525" },
		-- I have longed to hear the sound of your hiss, Lernie.
		{ Cue = "/VO/ZagreusField_3526" },
		-- Well, look at you, Lernie!
		{ Cue = "/VO/ZagreusField_3929", ChanceToPlayAgain = 0.1 },
		-- May I say, you look lovely this day or night, Lernie?
		{ Cue = "/VO/ZagreusField_3930", ChanceToPlayAgain = 0.1 },
		-- May I say, you look lovely this whatever-time-it-is, Lernie?
		{ Cue = "/VO/ZagreusField_3931", ChanceToPlayAgain = 0.1 },
	},
	{
		RandomRemaining = true,
		PreLineWait = 1.35,
		-- SuccessiveChanceToPlayAll = 0.33,
		RequiredFalsePlayed = { "/VO/ZagreusField_3147" },

		-- You. Come to fulfill my father's wishes?
		{ Cue = "/VO/ZagreusField_0127", RequiredPlayed = { "/VO/ZagreusField_0447" } },
		-- Erm... hello?
		{ Cue = "/VO/ZagreusField_0447" },
		-- You touch me, and I shall have your head.
		{ Cue = "/VO/ZagreusField_0448", RequiredPlayed = { "/VO/ZagreusField_0447" } },
		-- You touch me, and I shall have your head(s).
		{ Cue = "/VO/ZagreusField_0449", RequiredPlayed = { "/VO/ZagreusField_0448" } },
		-- Big one, huh.
		{ Cue = "/VO/ZagreusField_0446", RequiredPlayed = { "/VO/ZagreusField_0447" } },
		-- Get back in the magma and no-one gets hurt.
		{ Cue = "/VO/ZagreusField_0450", RequiredPlayed = { "/VO/ZagreusField_0447" } },
		-- I wouldn't mess with me if I were you.
		{ Cue = "/VO/ZagreusField_0451", RequiredPlayed = { "/VO/ZagreusField_0447" } },
		-- Come and get it.
		{ Cue = "/VO/ZagreusField_0452", RequiredPlayed = { "/VO/ZagreusField_0447" } },
		-- I'll get you for last time.
		{ Cue = "/VO/ZagreusField_1379", RequiredPlayed = { "/VO/ZagreusField_0447" }, ConsecutiveDeathsInRoom = { Name = "B_Boss01", Count = 1, } },
		-- I see you grew your heads back.
		{ Cue = "/VO/ZagreusField_1380", RequiredPlayed = { "/VO/ZagreusField_0447" }, ConsecutiveClearsOfRoom = { Name = "B_Boss01", Count = 1, } },
		-- Remember me?
		{ Cue = "/VO/ZagreusField_1381", RequiredPlayed = { "/VO/ZagreusField_0447" } },
		-- Bone Hydra! It's been too long.
		{ Cue = "/VO/ZagreusField_1382", RequiredPlayed = { "/VO/ZagreusField_0447" }, RequiredKills = { HydraHeadImmortal = 4 }, },
		-- I will keep coming back just like your stupid heads.
		{ Cue = "/VO/ZagreusField_1383", RequiredPlayed = { "/VO/ZagreusField_0447" }, },
		-- Don't you have something to say to me?
		{ Cue = "/VO/ZagreusField_1384", RequiredPlayed = { "/VO/ZagreusField_0447" } },
	},
	{
		PreLineWait = 3.35,
		RequiredPlayedThisRoom =  { "/VO/ZagreusField_0447" },

		-- Oh, great.
		{ Cue = "/VO/ZagreusField_1060" },
	},
}
GlobalVoiceLines.HydraVanquishedGlobalVoiceLines =
{
	[1] = GlobalVoiceLines.BarelySurvivedBossFightVoiceLines,
	[2] =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 6.75,

		-- Got you.
		{ Cue = "/VO/ZagreusField_0458", RequiredPlayed = { "/VO/ZagreusField_0459" } },
		-- And, clear.
		{ Cue = "/VO/ZagreusField_2610", RequiredPlayed = { "/VO/ZagreusField_0459" } },
		-- Whew, any more heads you'd like chopped off? No?
		{ Cue = "/VO/ZagreusField_0459" },
		-- And don't come back!
		{ Cue = "/VO/ZagreusField_0460", RequiredPlayed = { "/VO/ZagreusField_0459" } },
		-- Enough.
		{ Cue = "/VO/ZagreusField_1846", RequiredPlayed = { "/VO/ZagreusField_0459" } },
		-- Enough.
		{ Cue = "/VO/ZagreusField_2609", RequiredPlayed = { "/VO/ZagreusField_0459" } },
		-- Till you reconstitute again!
		{ Cue = "/VO/ZagreusField_3167", RequiredKills = { HydraHeadImmortal = 10 }, },
		-- Done bashing heads for now.
		{ Cue = "/VO/ZagreusField_3168", RequiredKills = { HydraHeadImmortal = 10 }, },
		-- Heads down.
		{ Cue = "/VO/ZagreusField_3169" },
		-- That's all the heads.
		{ Cue = "/VO/ZagreusField_3170", RequiredKills = { HydraHeadImmortal = 10 }, },
		-- No more heads.
		{ Cue = "/VO/ZagreusField_3171", RequiredKills = { HydraHeadImmortal = 10 }, },
		-- Good, no more heads.
		{ Cue = "/VO/ZagreusField_3172" },
		-- That's what you get.
		{ Cue = "/VO/ZagreusField_3173" },
		-- Enjoy your magma bath!
		{ Cue = "/VO/ZagreusField_3174", RequiredKills = { HydraHeadImmortal = 10 }, },
		-- Lovely chatting with you, Lernie dear!
		{ Cue = "/VO/ZagreusField_3175", RequiredPlayed = { "/VO/ZagreusField_3148" } },
		-- Bye for now Lernie.
		{ Cue = "/VO/ZagreusField_3176", RequiredPlayed = { "/VO/ZagreusField_3148" } },
		-- Hydra heads were never meant to fly.
		{ Cue = "/VO/ZagreusField_2611", RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 }, },
		-- Back to wherever your neck went.
		{ Cue = "/VO/ZagreusField_2612", RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 }, },
	},
	[3] = GlobalVoiceLines.ChaosReactionVoiceLines,
}

GlobalVoiceLines.ChallengeSwitchOpenedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.45,
	SuccessiveChanceToPlayAll = 0.5,

	-- Very nice.
	{ Cue = "/VO/ZagreusField_0228", },
	-- Nice.
	{ Cue = "/VO/ZagreusField_0229", },
	-- Excellent.
	{ Cue = "/VO/ZagreusField_0230", },
	-- Good enough.
	{ Cue = "/VO/ZagreusField_0231", },
	-- I'll take it.
	{ Cue = "/VO/ZagreusField_0232", },
	-- All mine.
	{ Cue = "/VO/ZagreusField_0233", },
	-- Thank you Father.
	{ Cue = "/VO/ZagreusField_0234", },
	-- I'll just help myself.
	{ Cue = "/VO/ZagreusField_0235", CooldownName = "SaidHelpRecently", CooldownTime = 30 },
	-- Cheers.
	{ Cue = "/VO/ZagreusField_0236", },
	-- Mine.
	{ Cue = "/VO/ZagreusField_3991", },
	-- Mine now.
	{ Cue = "/VO/ZagreusField_3992", },
	-- Cheers, Father.
	{ Cue = "/VO/ZagreusField_3993", },
	-- Earned my keep.
	{ Cue = "/VO/ZagreusField_3994", },
}
GlobalVoiceLines.ChallengeSwitchEmptyVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.75,

	-- Well isn't that just great.
	{ Cue = "/VO/ZagreusField_1985" },
	-- Just what I wanted: nothing!
	{ Cue = "/VO/ZagreusField_1986" },
	-- All that for nothing.
	{ Cue = "/VO/ZagreusField_1987" },
	-- Father sure is stingy.
	{ Cue = "/VO/ZagreusField_1988" },
	-- Empty. Damn.
	{ Cue = "/VO/ZagreusField_1989" },
	-- That's unfortunate.
	{ Cue = "/VO/ZagreusField_1990" },
}

GlobalVoiceLines.CurseTestVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		CooldownTime = 2.0,
		PreLineWait = 0.15,

		-- You asked for this!
		{ Cue = "/VO/ZagreusField_0093", RequiredKillEnemiesFound = true, },
		-- You had your chance!
		{ Cue = "/VO/ZagreusField_0094", RequiredKillEnemiesFound = true, },
		-- Enough of this crap!
		{ Cue = "/VO/ZagreusField_0095", RequiredKillEnemiesFound = true, },
		-- All right that's it!
		{ Cue = "/VO/ZagreusField_0096", RequiredKillEnemiesFound = true, },
		-- That does it!
		{ Cue = "/VO/ZagreusField_0097", RequiredKillEnemiesFound = true, },
		-- Get out of my WAY!
		{ Cue = "/VO/ZagreusField_0098a", RequiredKillEnemiesFound = true, RequiredMinCompletedRuns = 1, },
		-- You know who you're dealing with?
		{ Cue = "/VO/ZagreusField_0099b", RequiredKillEnemiesFound = true, RequiredMinCompletedRuns = 1, },

		-- I should keep going.
		{ Cue = "/VO/ZagreusField_0031", RequiredKillEnemiesNotFound = true, RequiresNotInRun = true, },
		-- I should press on.
		{ Cue = "/VO/ZagreusField_0032", RequiredKillEnemiesNotFound = true, RequiresNotInRun = true, },
		-- I should go.
		{ Cue = "/VO/ZagreusField_0033a", RequiredKillEnemiesNotFound = true, RequiresNotInRun = true, },
		-- Nothing left here.
		{ Cue = "/VO/ZagreusField_0034", RequiredKillEnemiesNotFound = true, RequiresNotInRun = true, },

		-- Go away.
		{ Cue = "/VO/ZagreusHome_0094", RequiresInRun = true, },
		-- Out of my way.
		{ Cue = "/VO/ZagreusHome_0095", RequiresInRun = true, },
		-- Shoo already.
		{ Cue = "/VO/ZagreusHome_0096", RequiresInRun = true, },
		-- Out of my sight.
		{ Cue = "/VO/ZagreusHome_0097", RequiresInRun = true, },
		-- Piss off.
		{ Cue = "/VO/ZagreusHome_0098", RequiresInRun = true, },

	},
}

GlobalVoiceLines.WrathTestVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		CooldownTime = 2.0,
		PreLineWait = 0,

		-- You asked for this!
		{ Cue = "/VO/ZagreusField_0093", RequiredKillEnemiesFound = true, },
		-- You had your chance!
		{ Cue = "/VO/ZagreusField_0094", RequiredKillEnemiesFound = true, },
		-- Enough of this crap!
		{ Cue = "/VO/ZagreusField_0095", RequiredKillEnemiesFound = true, },
		-- All right that's it!
		{ Cue = "/VO/ZagreusField_0096", RequiredKillEnemiesFound = true, },
		-- That does it!
		{ Cue = "/VO/ZagreusField_0097", RequiredKillEnemiesFound = true, },
		-- Get out of my WAY!
		{ Cue = "/VO/ZagreusField_0098a", RequiredKillEnemiesFound = true, },
		-- You know who you're dealing with?
		{ Cue = "/VO/ZagreusField_0099b", RequiredKillEnemiesFound = true, },
	},
}

GlobalVoiceLines.MiniBossEncounterStartVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 2.5,
		SuccessiveChanceToPlayAll = 0.75,
		RequiredTrait = "SwordThrustWaveTrait",
		RequiredEncounters = { "MiniBossWaveFist" },
		RequireCurrentEncounterCompleted = true,

		-- All right, lads, let's see who makes the bigger waves.
		{ Cue = "/VO/ZagreusField_2678" },
		-- Hello, Wave-Makers! I, too, can make waves.
		{ Cue = "/VO/ZagreusField_2679" },
		-- I can make waves too.
		{ Cue = "/VO/ZagreusField_2680" },
		-- Your waves against mine.
		{ Cue = "/VO/ZagreusField_2681" },
	},
	{
		{
			PlayOnce = true,
			PreLineWait = 2.75,
			RequiredRooms = { "A_MiniBoss03" },

			-- Um. Sorry, wrong chamber!
			{ Cue = "/VO/ZagreusField_3972" },
		},
		{
			BreakIfPlayed = true,
			PlayOnce = true,
			PreLineWait = 1.75,
			RequiredRooms = { "A_MiniBoss03" },

			-- And, I'm locked in.
			{ Cue = "/VO/ZagreusField_3973" },	
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 2.75,
			SuccessiveChanceToPlay = 0.75,
			RequiredRooms = { "A_MiniBoss03" },

			-- It's that damn Wretched Sneak.
			{ Cue = "/VO/ZagreusField_3714" },
			-- Come on, Sneak!
			{ Cue = "/VO/ZagreusField_3715" },
			-- You've been waiting for this, haven't you?
			{ Cue = "/VO/ZagreusField_3716" },
			-- All right, you Sneak.
			{ Cue = "/VO/ZagreusField_3717" },
			-- I see you, Sneak.
			{ Cue = "/VO/ZagreusField_3947" },
			-- Let's go, Sneak!
			{ Cue = "/VO/ZagreusField_3948" },
			-- You and me, Sneak!
			{ Cue = "/VO/ZagreusField_3949" },
			-- A Wretched Sneak...
			{ Cue = "/VO/ZagreusField_3950" },
			-- Come try me, Sneak.
			{ Cue = "/VO/ZagreusField_3951" },
		},
	},
	{
		PlayOnce = true,
		PlayOnceContext = "MiniBossCountDoomstone",
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 2.5,
		RequiredEncounters = { "MiniBossHeavyRangedSplitter2" },
		RequiredRoom = "A_MiniBoss04",
		RequiredPlayed = { "/VO/ZagreusField_3704" },

		-- Uh oh...
		{ Cue = "/VO/ZagreusField_0159" },
		-- What...
		{ Cue = "/VO/ZagreusField_0964" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 2.5,
		SuccessiveChanceToPlay = 0.75,
		RequiredEncounters = { "MiniBossHeavyRangedSplitter", "MiniBossHeavyRangedSplitter2" },

		-- Doomstone. Just great.
		{ Cue = "/VO/ZagreusField_3704" },
		-- Let's go, Doomstone.
		{ Cue = "/VO/ZagreusField_3705", RequiredPlayed = { "/VO/ZagreusField_3704" }, },
		-- Time to break you to bits.
		{ Cue = "/VO/ZagreusField_3706", RequiredPlayed = { "/VO/ZagreusField_3704" }, },
		-- Come on, Doomstone.
		{ Cue = "/VO/ZagreusField_3707", RequiredPlayed = { "/VO/ZagreusField_3704" }, },
		-- I thought crystals were supposed to be pretty.
		{ Cue = "/VO/ZagreusField_3708", RequiredPlayed = { "/VO/ZagreusField_3704" }, },
		-- All right, Doomstone.
		{ Cue = "/VO/ZagreusField_3938", RequiredPlayed = { "/VO/ZagreusField_3704" }, },
		-- Doomstone! Hi.
		{ Cue = "/VO/ZagreusField_3939", RequiredPlayed = { "/VO/ZagreusField_3704" }, },
		-- Come get smashed to bits.
		{ Cue = "/VO/ZagreusField_3940", RequiredPlayed = { "/VO/ZagreusField_3704" }, },
		-- Blasted Doomstone, then.
		{ Cue = "/VO/ZagreusField_3941", RequiredPlayed = { "/VO/ZagreusField_3704" }, },
		-- I'll break you again.
		{ Cue = "/VO/ZagreusField_3942", RequiredPlayed = { "/VO/ZagreusField_3704" }, },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 2.5,
		SuccessiveChanceToPlayAll = 0.75,
		RequiredFalseRooms = { "A_MiniBoss03", "A_MiniBoss04", "C_MiniBoss01" },

		-- Uh oh...
		{ Cue = "/VO/ZagreusField_0159", PreLineWait = 1.25, },
		-- Hey, lads.
		{ Cue = "/VO/ZagreusField_0645", RequiredPlayed = { "/VO/ZagreusField_0159" } },
		-- Let's go, lads.
		{ Cue = "/VO/ZagreusField_0646", RequiredPlayed = { "/VO/ZagreusField_0159" } },
		-- Ready, lads?
		{ Cue = "/VO/ZagreusField_0647", RequiredPlayed = { "/VO/ZagreusField_0159" } },
		-- You lads again huh.
		{ Cue = "/VO/ZagreusField_0648", RequiredPlayed = { "/VO/ZagreusField_0159" }, RequireCurrentEncounterCompleted = true, },
		-- You and me.
		{ Cue = "/VO/ZagreusField_0649", RequiredPlayed = { "/VO/ZagreusField_0159" } },
		-- Oh this place.
		{ Cue = "/VO/ZagreusField_0650", PreLineWait = 1.0, RequiredPlayed = { "/VO/ZagreusField_0159" }, RequiredSeenRooms = { "A_MiniBoss01", "A_MiniBoss02" } },
	},

}

GlobalVoiceLines.B_MiniBossEncounterStartVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 2.75,
		SuccessiveChanceToPlayAll = 0.75,
		RequiredFalseTextLines = { "DusaFirstMeeting", "DusaFirstMeeting_Alt" },

		-- This isn't good.
		{ Cue = "/VO/ZagreusField_0443", RequiredPlayed = { "/VO/ZagreusField_0445" } },
		-- Trouble.
		{ Cue = "/VO/ZagreusField_0444", RequiredPlayed = { "/VO/ZagreusField_0445" } },
		-- That's a problem.
		{ Cue = "/VO/ZagreusField_0445" },
		-- Oh no.
		{ Cue = "/VO/ZagreusField_1182", RequiredPlayed = { "/VO/ZagreusField_0445" } },
		-- Oh good, I love snakes.
		{ Cue = "/VO/ZagreusField_1184", RequiredPlayed = { "/VO/ZagreusField_0445" } },
		-- Fancy running into you again.
		{ Cue = "/VO/ZagreusField_1186", RequiredPlayed = { "/VO/ZagreusField_0445" } },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 2.75,
		SuccessiveChanceToPlayAll = 0.75,

		-- This isn't good.
		{ Cue = "/VO/ZagreusField_0443", RequiredPlayed = { "/VO/ZagreusField_1183" } },
		-- Trouble.
		{ Cue = "/VO/ZagreusField_0444", RequiredPlayed = { "/VO/ZagreusField_1183" } },
		-- That's a problem.
		{ Cue = "/VO/ZagreusField_0445", RequiredPlayed = { "/VO/ZagreusField_1183" } },
		-- Oh no.
		{ Cue = "/VO/ZagreusField_1182", RequiredPlayed = { "/VO/ZagreusField_1183" } },
		-- You're not Dusa.
		{ Cue = "/VO/ZagreusField_1183", RequiredAnyTextLines = { "DusaFirstMeeting", "DusaFirstMeeting_Alt" } },
		-- Oh good, I love snakes.
		{ Cue = "/VO/ZagreusField_1184", RequiredPlayed = { "/VO/ZagreusField_1183" } },
		-- My favorite power couple.
		{ Cue = "/VO/ZagreusField_1185", PreLineWait = 5.1, RequiredPlayed = { "/VO/ZagreusField_1183" } },
		-- Fancy running into you again.
		{ Cue = "/VO/ZagreusField_1186", RequiredPlayed = { "/VO/ZagreusField_1183" } },
		-- You two again!
		{ Cue = "/VO/ZagreusField_4230", RequiredPlayed = { "/VO/ZagreusField_1183" } },
		-- You two ready for me, then?
		{ Cue = "/VO/ZagreusField_4231", RequiredPlayed = { "/VO/ZagreusField_1183" } },
		-- Hello, Megagorgon!
		{ Cue = "/VO/ZagreusField_4232", RequiredPlayed = { "/VO/ZagreusField_1183" } },
		-- The Megagorgon!
		{ Cue = "/VO/ZagreusField_4233", RequiredPlayed = { "/VO/ZagreusField_1183" } },
	},
}
GlobalVoiceLines.B_MiniBossSpreadShotEncounterStartVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 2.75,
	SuccessiveChanceToPlayAll = 0.75,

	-- The Witches Circle...
	{ Cue = "/VO/ZagreusField_3722" },
	-- These Witches again.
	{ Cue = "/VO/ZagreusField_3723", RequiredPlayed = { "/VO/ZagreusField_3722" } },
	-- Hit me if you can, Witches!
	{ Cue = "/VO/ZagreusField_3724", RequiredPlayed = { "/VO/ZagreusField_3722" } },
	-- Hey look, it's me, Witches!
	{ Cue = "/VO/ZagreusField_3725", RequiredPlayed = { "/VO/ZagreusField_3722" } },
	-- Hello, Witches Circle.
	{ Cue = "/VO/ZagreusField_3726", RequiredPlayed = { "/VO/ZagreusField_3722" } },
	-- Witches Circle!
	{ Cue = "/VO/ZagreusField_3956", RequiredPlayed = { "/VO/ZagreusField_3722" } },
	-- Break it up, Witches!
	{ Cue = "/VO/ZagreusField_3957", RequiredPlayed = { "/VO/ZagreusField_3722" } },
	-- Mind if I join the fray, Witches?
	{ Cue = "/VO/ZagreusField_3958", RequiredPlayed = { "/VO/ZagreusField_3722" } },
}
GlobalVoiceLines.C_MiniBossEncounterStartVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 2.75,
	SuccessiveChanceToPlayAll = 0.75,
	TriggerCooldowns =
	{
		"RespawningVoiceLinesPlayedRecently",
		"RespawnedVoiceLinesPlayedRecently",
		"FlurrySpawnerReinforcementHintsPlayedRecently",
	},

	-- Soul-sucking butterflies...
	{ Cue = "/VO/ZagreusField_1975" },
	-- You and me, Butterfly Ball.
	{ Cue = "/VO/ZagreusField_1976", RequiredPlayed = { "/VO/ZagreusField_1975" } },
	-- It's the Butterfly Ball.
	{ Cue = "/VO/ZagreusField_1977", RequiredPlayed = { "/VO/ZagreusField_1975" } },
	-- The mother of all Soul Catchers.
	{ Cue = "/VO/ZagreusField_1978", RequiredPlayed = { "/VO/ZagreusField_1975" } },
	-- It's that big Soul Catcher again.
	{ Cue = "/VO/ZagreusField_1979", RequiredPlayed = { "/VO/ZagreusField_1975" } },
	-- Oh it's the butterfly chamber.
	{ Cue = "/VO/ZagreusField_2693", RequireCurrentEncounterCompleted = true },
	-- Butterfly chamber.
	{ Cue = "/VO/ZagreusField_2694", RequireCurrentEncounterCompleted = true },
	-- Come forth and be swatted, deadly butterflies.
	{ Cue = "/VO/ZagreusField_2695", RequireCurrentEncounterCompleted = true },
	-- There you are, gigantic Soul Catcher.
	{ Cue = "/VO/ZagreusField_2696", RequireCurrentEncounterCompleted = true },
}

GlobalVoiceLines.D_MiniBossEncounterStartVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 1.75,
	SuccessiveChanceToPlayAll = 0.75,
	PlayOnceFromTableThisRun = true,

	-- That's one big Satyr...
	{ Cue = "/VO/ZagreusField_2875", RequiredRoom = "D_MiniBoss01" },
	-- Another one of those gigantic Satyrs?
	{ Cue = "/VO/ZagreusField_2876", RequiredRoom = "D_MiniBoss01", RequiredPlayed = { "/VO/ZagreusField_2875" } },
	-- That's the most gigantic vermin I have ever seen.
	{ Cue = "/VO/ZagreusField_2879", RequiredRoom = "D_MiniBoss02" },
	-- Another one of those especially gigantic vermin!
	{ Cue = "/VO/ZagreusField_2880", RequiredRoom = "D_MiniBoss02", RequiredPlayed = { "/VO/ZagreusField_2879" } },
	-- What sort of terrible Snakestone is that?
	{ Cue = "/VO/ZagreusField_2883", RequiredRoom = "D_MiniBoss03", RequiredEncounters = { "MiniBossHeavyRangedForked" } },
	-- It's that giant Snakestone once again!
	{ Cue = "/VO/ZagreusField_2884", RequiredRoom = "D_MiniBoss03", RequiredPlayed = { "/VO/ZagreusField_2883" }, RequiredEncounters = { "MiniBossHeavyRangedForked" } },
	-- Don't like the look of that big Bother over there.
	{ Cue = "/VO/ZagreusField_2887", RequiredRoom = "D_MiniBoss04" },
	-- That blasted giant Bother has come back.
	{ Cue = "/VO/ZagreusField_2888", RequiredRoom = "D_MiniBoss04", RequiredPlayed = { "/VO/ZagreusField_2887" } },
	-- This blasted place again.
	{ Cue = "/VO/ZagreusField_2891", RequiredSeenRooms = { "D_MiniBoss01", "D_MiniBoss02", "D_MiniBoss03", "D_MiniBoss04" } },
	-- It's one of their lairs.
	{ Cue = "/VO/ZagreusField_2892", RequiredSeenRooms = { "D_MiniBoss01", "D_MiniBoss02", "D_MiniBoss03", "D_MiniBoss04" } },
	-- Time to deal with Father's pest problem I guess.
	{ Cue = "/VO/ZagreusField_2893", RequiredSeenRooms = { "D_MiniBoss01", "D_MiniBoss02", "D_MiniBoss03", "D_MiniBoss04" } },
	-- One of their disgusting lairs, huh.
	{ Cue = "/VO/ZagreusField_2894", RequiredSeenRooms = { "D_MiniBoss01", "D_MiniBoss02", "D_MiniBoss03", "D_MiniBoss04" } },
	-- Can't quite get acclimated to this smell.
	{ Cue = "/VO/ZagreusField_2895", RequiredSeenRooms = { "D_MiniBoss01", "D_MiniBoss02", "D_MiniBoss03", "D_MiniBoss04" } },
	-- And Father thinks my chambers are a mess!
	{ Cue = "/VO/ZagreusField_2896", RequiredSeenRooms = { "D_MiniBoss01", "D_MiniBoss02", "D_MiniBoss03", "D_MiniBoss04" } },
}

GlobalVoiceLines.CrawlerMiniBossEncounterStartVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.75,
		SuccessiveChanceToPlayAll = 0.75,

		-- Oh no.
		{ Cue = "/VO/ZagreusField_3366", RequiredPlayed = { "/VO/ZagreusField_3353", "/VO/ZagreusField_3367" }, },
		-- Wait, it's back?
		{ Cue = "/VO/ZagreusField_3367", RequiredPlayed = { "/VO/ZagreusField_3353" }, },
		-- No, not the tiny vermin.
		{ Cue = "/VO/ZagreusField_3368", RequiredPlayed = { "/VO/ZagreusField_3353", "/VO/ZagreusField_3367" }, },
		-- No, anything but the tiny vermin...!
		{ Cue = "/VO/ZagreusField_3369", RequiredPlayed = { "/VO/ZagreusField_3353", "/VO/ZagreusField_3367" }, },
		-- The tiny vermin!
		{ Cue = "/VO/ZagreusField_3370", RequiredPlayed = { "/VO/ZagreusField_3353", "/VO/ZagreusField_3367" }, },
		-- Come forth, you tiny vermin!
		{ Cue = "/VO/ZagreusField_3371", RequiredPlayed = { "/VO/ZagreusField_3353", "/VO/ZagreusField_3367" }, },
		-- No! Bad vermin! Bad!
		{ Cue = "/VO/ZagreusField_3454", PreLineWait = 4.5, RequiredPlayed = { "/VO/ZagreusField_3353", "/VO/ZagreusField_3367" }, },
		-- Um. Wrong chamber?
		{ Cue = "/VO/ZagreusField_3713", RequiredPlayed = { "/VO/ZagreusField_3353", "/VO/ZagreusField_3367" }, },
	},
	{
		PreLineWait = 1.75,
		PlayOnce = true,
		PlayOnceContext = "TinyVerminIntro",
		Cooldowns =
		{
			{ Name = "CrawlerBossBurrowSpeech", Time = 20 },
		},

		-- Uh....
		{ Cue = "/VO/ZagreusField_3353" },
		-- Oh, haha! It's just a tiny vermin!
		{ Cue = "/VO/ZagreusField_3354", PreLineWait = 0.65 },
		-- Oh gods!
		{ Cue = "/VO/ZagreusField_3356", PreLineWait = 1.3 },
		-- That... what... I...
		-- { Cue = "/VO/ZagreusField_3357", PreLineWait = 1.0 },
		-- Wait, where's it going...
		-- { Cue = "/VO/ZagreusField_3453", PreLineWait = 1.4 },
		-- Where do you think you're going?
		-- { Cue = "/VO/ZagreusField_3452", PreLineWaip = 1.1 },
		-- Oh gods!
		-- { Cue = "/VO/ZagreusField_3356", PreLineWait = 2.3 },
	},
}

GlobalVoiceLines.CrawlerMiniBossEncounterEndVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.9,
	SuccessiveChanceToPlayAll = 0.66,
	ThreadName = "RoomThread",

	-- So vicious, yet so tiny.
	{ Cue = "/VO/ZagreusField_3455" },
	-- Pick on somebody your own size next time!
	{ Cue = "/VO/ZagreusField_3457", RequiredPlayed = { "/VO/ZagreusField_3455" } },
	-- It's dead... I think?
	{ Cue = "/VO/ZagreusField_3365", RequiredPlayed = { "/VO/ZagreusField_3455" } },
	-- Eugh, that thing...
	{ Cue = "/VO/ZagreusField_3359", RequiredPlayed = { "/VO/ZagreusField_3455" } },
	-- That vicious little...
	{ Cue = "/VO/ZagreusField_3360", RequiredPlayed = { "/VO/ZagreusField_3455" } },
	-- I much prefer gigantic vermin, thanks...
	{ Cue = "/VO/ZagreusField_3361", RequiredPlayed = { "/VO/ZagreusField_3455" } },
	-- I got you, tiny vermin.
	{ Cue = "/VO/ZagreusField_3362", RequiredPlayed = { "/VO/ZagreusField_3455" } },
	-- You don't scare me, tiny vermin!
	{ Cue = "/VO/ZagreusField_3363", RequiredPlayed = { "/VO/ZagreusField_3455" } },
	-- Is it dead...?
	-- { Cue = "/VO/ZagreusField_3358", RequiredPlayed = { "/VO/ZagreusField_3457" } },
	-- It's dead...
	{ Cue = "/VO/ZagreusField_3364", RequiredPlayed = { "/VO/ZagreusField_3455" }, PreLineWait = 2.1 },
	-- Come back when you're bigger!
	-- { Cue = "/VO/ZagreusField_3456", RequiredPlayed = { "/VO/ZagreusField_3357" } },
}

GlobalVoiceLines.CrystalMiniBossDefeatedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 2.0,
	SuccessiveChanceToPlay = 0.66,
	ThreadName = "RoomThread",
	UsePlayerSource = true,

	-- Broken to bits.
	{ Cue = "/VO/ZagreusField_3709", RequiredPlayed = { "/VO/ZagreusField_3945" }, },
	-- You'll be back, won't you.
	{ Cue = "/VO/ZagreusField_3710", RequiredPlayed = { "/VO/ZagreusField_3945" }, },
	-- Gone all to pieces.
	{ Cue = "/VO/ZagreusField_3711", RequiredPlayed = { "/VO/ZagreusField_3945" }, },
	-- Shattered that.
	{ Cue = "/VO/ZagreusField_3712", RequiredPlayed = { "/VO/ZagreusField_3945" }, },
	-- You're free, tortured souls trapped in a crystal thing.
	{ Cue = "/VO/ZagreusField_3943", RequiredPlayed = { "/VO/ZagreusField_3945" }, },
	-- Eugh, that thing.
	{ Cue = "/VO/ZagreusField_3944", RequiredPlayed = { "/VO/ZagreusField_3945" }, },
	-- One less giant evil crystal, then.
	{ Cue = "/VO/ZagreusField_3945" },
	-- Smashing!
	{ Cue = "/VO/ZagreusField_3946", RequiredPlayed = { "/VO/ZagreusField_3945" }, },
}

GlobalVoiceLines.FinalBossDefeatedVoiceLines =
{
	[1] = GlobalVoiceLines.BarelySurvivedFinalBossFightVoiceLines,
	[2] =
	{
		Queue = "Always",
		RandomRemaining = true,
		PreLineWait = 1.0,
		UsePlayerSource = true,
		-- SuccessiveChanceToPlayAll = 0.66,
		RequiredMinHealthFraction = 0.15,
		Cooldowns =
		{
			{ Name = "ZagreusAnyQuipSpeech", Time = 12 },
		},

		-- Good-bye, Father.
		{ Cue = "/VO/ZagreusField_2179" },
		-- See you at home.
		{ Cue = "/VO/ZagreusField_2180", RequiredPlayed = { "/VO/ZagreusField_2179" }, RequiredFalseTextLinesThisRun = { "LordHadesDefeated01" }, },
		-- There.
		{ Cue = "/VO/ZagreusField_2263", RequiredPlayed = { "/VO/ZagreusField_2179" } },
		-- Yes.
		{ Cue = "/VO/ZagreusField_2264", RequiredPlayed = { "/VO/ZagreusField_2179" } },
		-- Bye.
		{ Cue = "/VO/ZagreusField_2265", RequiredPlayed = { "/VO/ZagreusField_2179" } },
		-- Tsch...
		{ Cue = "/VO/ZagreusField_2266", RequiredPlayed = { "/VO/ZagreusField_2179" } },
		-- Say hi to Hypnos for me.
		{ Cue = "/VO/ZagreusField_2267", RequiredPlayed = { "/VO/ZagreusField_2179" }, SuccessiveChanceToPlay = 0.05, RequiredTextLines = { "Ending01" }, },
		-- Got you.
		{ Cue = "/VO/ZagreusField_0175", RequiredPlayed = { "/VO/ZagreusField_2179" }, },
		-- I did it!
		{ Cue = "/VO/ZagreusField_0329", CooldownName = "SaidIDidItRecently", CooldownTime = 40, RequiredPlayed = { "/VO/ZagreusField_2179" }, },
		-- I did it.
		{ Cue = "/VO/ZagreusField_0330", CooldownName = "SaidIDidItRecently", CooldownTime = 40, RequiredPlayed = { "/VO/ZagreusField_2179" }, },
	},
}

GlobalVoiceLines.EnteredCharonFightVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlay = 0.66,
		UsePlayerSource = true,

		-- Oh, hi.
		{ Cue = "/VO/ZagreusField_1450" },
		-- Whoops!
		{ Cue = "/VO/ZagreusHome_0091" },
		-- Erm sorry...!
		{ Cue = "/VO/ZagreusHome_0092", RequiredFalsePlayedThisRun = { "/VO/ZagreusField_3744" }, },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlay = 0.66,
		ObjectType = "Charon",

		-- Harrhh...!
		{ Cue = "/VO/Charon_0028" },
		-- Hrraahh...!
		{ Cue = "/VO/Charon_0029" },
		-- Hrrrr...!
		{ Cue = "/VO/Charon_0030" },
		-- Nrrrrhhh...!
		{ Cue = "/VO/Charon_0031" },
		-- Hmmmm....!
		{ Cue = "/VO/Charon_0032" },
		-- Guuhhhh...
		{ Cue = "/VO/Charon_0033" },
		-- Heehhhh...
		{ Cue = "/VO/Charon_0034" },
		-- Mrrrrnnn....
		{ Cue = "/VO/Charon_0035" },
	},
}

GlobalVoiceLines.FoundShopVoiceLines =
{
	-- Think I hear the river.
	{ Cue = "/VO/ZagreusField_0482", PreLineWait = 1.2, PlayOnce = true, BreakIfPlayed = true, RequiredRoom = "A_Shop01", Cooldowns = { { Name = "ZagreusFoundShopSpeech", Time = 20 }, }, },
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 2.2,
		SuccessiveChanceToPlay = 0.33,
		Cooldowns =
		{
			{ Name = "ZagreusFoundShopSpeech", Time = 20 },
		},

		-- Something's here.
		{ Cue = "/VO/ZagreusField_0126" },
		-- Better stock up.
		{ Cue = "/VO/ZagreusField_0256" },
		-- Must be something I can use.
		{ Cue = "/VO/ZagreusField_0257" },
		-- Charon must be nearby.
		{ Cue = "/VO/ZagreusField_0903" },
		-- I'm at the docks.
		{ Cue = "/VO/ZagreusField_0904" },
		-- Let's see what's up for sale.
		{ Cue = "/VO/ZagreusField_0905" },
		-- Sounds like Charon's breathing up ahead.
		{ Cue = "/VO/ZagreusField_0481", PreLineWait = 1.6, RequiredRoom = "A_Shop01", CooldownName = "MentionedCharon", CooldownTime = 40 },
		-- Charon's shop.
		{ Cue = "/VO/ZagreusField_1608", RequiredRooms = { "B_Shop01", "C_Shop01" } },
		-- Somewhere to spend some coin.
		{ Cue = "/VO/ZagreusField_4425" },
		-- One of Charon's shops.
		{ Cue = "/VO/ZagreusField_4426" },
		-- Charon's offerings ahead I guess.
		{ Cue = "/VO/ZagreusField_4427" },
		-- A marketplace here, huh.
		{ Cue = "/VO/ZagreusField_4428" },
		-- A river market.
		{ Cue = "/VO/ZagreusField_4429" },
		-- Charon's set up shop.
		{ Cue = "/VO/ZagreusField_4430" },
	},
}

GlobalVoiceLines.BountyEarnedVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.6,
		RequiredFalseRooms = { "D_Boss01" },
		RequiredTextLines = { "HadesAboutBounties01" },
		SuccessiveChanceToPlay = 0.33,

		-- Earned a bounty.
		{ Cue = "/VO/ZagreusField_2649" },
		-- Compensation.
		{ Cue = "/VO/ZagreusField_2650" },
		-- Another bounty.
		{ Cue = "/VO/ZagreusField_2651" },
		-- Claimed a bounty.
		{ Cue = "/VO/ZagreusField_2652" },
		-- This bounty's mine.
		{ Cue = "/VO/ZagreusField_2653" },
		-- That's my bounty.
		{ Cue = "/VO/ZagreusField_2654" },
		-- My bounty.
		{ Cue = "/VO/ZagreusField_2655" },
		-- Got a bounty.
		{ Cue = "/VO/ZagreusField_2656" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlayAll = 0.5,
		CooldownTime = 6,

		-- Earning my keep.
		{ Cue = "/VO/ZagreusField_1088" },
		-- Should fetch me something.
		{ Cue = "/VO/ZagreusField_0662", },
		-- I'll just take that.
		{ Cue = "/VO/ZagreusField_0663", },
		-- Good.
		{ Cue = "/VO/ZagreusField_0135", CooldownName = "SaidGoodRecently", CooldownTime = 40, },
		-- Nice.
		{ Cue = "/VO/ZagreusField_0229" },
		-- I'll take that.
		{ Cue = "/VO/ZagreusField_0276" },
		-- Sure.
		{ Cue = "/VO/ZagreusField_0277" },
		-- Mine.
		{ Cue = "/VO/ZagreusField_0273" },
	},
}

GlobalVoiceLines.CosmeticUnlockedVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.65,
	Queue = "Interrupt",

	-- Some new decor.
	{ Cue = "/VO/ZagreusHome_0306" },
	-- Should liven things a bit.
	{ Cue = "/VO/ZagreusHome_0307" },
	-- I'll just set that there.
	{ Cue = "/VO/ZagreusHome_0308" },
	-- Looks good I guess.
	{ Cue = "/VO/ZagreusHome_0309" },
	-- More decor!
	{ Cue = "/VO/ZagreusHome_2013" },
	-- Should look good right there.
	{ Cue = "/VO/ZagreusHome_2014" },
	-- A fine addition to the bedchambers.
	{ Cue = "/VO/ZagreusHome_2015" },
	-- Just what I always wanted!
	{ Cue = "/VO/ZagreusHome_2016" },
	-- How about we put this... there.
	{ Cue = "/VO/ZagreusHome_2017" },
}

GlobalVoiceLines.HadesRedecorationReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	Cooldown = 60,
	ObjectType = "NPC_Hades_01",
	RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
	RequiredSourceValueFalse = "InPartnerConversation",

	-- Redecorating once again, I see?
	{ Cue = "/VO/Hades_0886" },
	-- Indecisive as ever.
	{ Cue = "/VO/Hades_0887" },
	-- An utterly unnecessary change.
	{ Cue = "/VO/Hades_0888" },
	-- What did you do now...
	{ Cue = "/VO/Hades_0889" },
	-- What are you doing now?
	{ Cue = "/VO/Hades_0890" },
	-- What have you done this time...
	{ Cue = "/VO/Hades_0891" },
	-- You use your limited authority for that?
	{ Cue = "/VO/Hades_0892" },
	-- A change for change's sake.
	{ Cue = "/VO/Hades_0893" },
	-- Blast, just leave it be!
	{ Cue = "/VO/Hades_0894" },
	-- What are you even going on about?
	{ Cue = "/VO/Hades_0895" },
	-- Whose House do you think this is?
	{ Cue = "/VO/Hades_0896" },
	-- Augh, what did you do, now.
	{ Cue = "/VO/Hades_0897" },
	-- You need not listen to him, Contractor!
	{ Cue = "/VO/Hades_0898" },
	-- Was that truly necessary, boy?
	{ Cue = "/VO/Hades_0899" },
	-- Why bother with such triviality?
	{ Cue = "/VO/Hades_0900" },
	-- Utterly senseless.
	{ Cue = "/VO/Hades_0901" },
	-- It was fine!
	{ Cue = "/VO/Hades_0902" },
	-- Leave that poor Contractor alone.
	{ Cue = "/VO/Hades_0903" },
	-- Can you believe this, Cerberus?
	{ Cue = "/VO/Hades_0904", AreIdsAlive = { 370007 }, },
	-- You're wasting everybody's time.
	{ Cue = "/VO/Hades_0905" },
}

GlobalVoiceLines.CosmeticRemovedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		Cooldown = 60,

		-- Let's take that down for now.
		{ Cue = "/VO/ZagreusHome_1785" },
		-- Let's pack that up for now.
		{ Cue = "/VO/ZagreusHome_1786" },
		-- Teardown approved, Contractor.
		{ Cue = "/VO/ZagreusHome_1787" },
		-- I miss the way things used to be with that.
		{ Cue = "/VO/ZagreusHome_1788" },
		-- Let's go without that for a bit, all right?
		{ Cue = "/VO/ZagreusHome_1789" },
		-- What say we change things up again, all right?
		{ Cue = "/VO/ZagreusHome_1736" },
		-- Let's shift some things around if you don't mind.
		{ Cue = "/VO/ZagreusHome_1737" },
		-- I'd like to see how that looks the other way again, please.
		{ Cue = "/VO/ZagreusHome_2639" },
		-- All right if we restore that to the way it was before?
		{ Cue = "/VO/ZagreusHome_2644" },
	},
	[2] = GlobalVoiceLines.HadesRedecorationReactionVoiceLines,	
}

GlobalVoiceLines.CosmeticReAddedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		Cooldown = 60,

		-- Let's bring that back I think.
		{ Cue = "/VO/ZagreusHome_1790" },
		-- Let's put that up again.
		{ Cue = "/VO/ZagreusHome_1791" },
		-- Let's see how this looks again.
		{ Cue = "/VO/ZagreusHome_1792" },
		-- Let's put this back up, why not.
		{ Cue = "/VO/ZagreusHome_1793" },
		-- Let's go ahead with this again.
		{ Cue = "/VO/ZagreusHome_1794" },
		-- I think we'd better go with this option instead.
		{ Cue = "/VO/ZagreusHome_1735" },
		-- I think we ought to mix things up a bit.
		{ Cue = "/VO/ZagreusHome_1738" },
		-- Let's try this on for size instead, OK?
		{ Cue = "/VO/ZagreusHome_1739" },
		-- Let's make an adjustment over here again, Contractor.
		{ Cue = "/VO/ZagreusHome_2638" },
		-- We're going to reconfigure that bit once again, Contractor.
		{ Cue = "/VO/ZagreusHome_2640" },
		-- I wanted to see how this looks again if that's all right.
		{ Cue = "/VO/ZagreusHome_2641" },
		-- How about we make an adjustment right over here if that's OK.
		{ Cue = "/VO/ZagreusHome_2642" },
		-- Guess what, Contractor? Changed my mind again.
		{ Cue = "/VO/ZagreusHome_2643" },
		-- I think I want to change things up again right over here.
		{ Cue = "/VO/ZagreusHome_2645" },
		-- I'm thinking we should freshen things a bit right over here.
		{ Cue = "/VO/ZagreusHome_2646" },
		-- Eh, let's see how it looks this other way, all right?
		{ Cue = "/VO/ZagreusHome_2647" },
		-- I think we'd better go with this option instead.
		{ Cue = "/VO/ZagreusHome_1735" },
		-- What say we change things up again, all right?
		{ Cue = "/VO/ZagreusHome_1736" },
		-- Let's try this on for size instead, OK?
		{ Cue = "/VO/ZagreusHome_1739" },

	},
	[2] = GlobalVoiceLines.HadesRedecorationReactionVoiceLines,
}

GlobalVoiceLines.CerberusBedReAddedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.5,
		BreakIfPlayed = true,
		Cooldowns =
		{
			{ Name = "ZagCerberusBedReAddedVoiceLines", Time = 30 },
		},

		-- Excuse me while I swap your bedding for you, boy.
		{ Cue = "/VO/ZagreusHome_1754", AreIdsAlive = { 370007 }, },
		-- Let's change the bedding up for Cerberus.
		{ Cue = "/VO/ZagreusHome_1755" },
		-- This other bedding seems a better fit.
		{ Cue = "/VO/ZagreusHome_1756" },
		-- Hard to decide which bedding type to choose.
		{ Cue = "/VO/ZagreusHome_1757" },
	},
	[2] = GlobalVoiceLines.CosmeticReAddedVoiceLines,
}

GlobalVoiceLines.ColumnsReAddedVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.35,
		Cooldowns =
		{
			{ Name = "ZagColumnsReAddedVoiceLines", Time = 30 },
		},

		-- Changed my mind about those columns there.
		{ Cue = "/VO/ZagreusHome_1761" },
		-- Let's go back to an older style for those columns.
		{ Cue = "/VO/ZagreusHome_1762" },
	},
	[2] = GlobalVoiceLines.CosmeticReAddedVoiceLines,
}

GlobalVoiceLines.GhostAdminUseHintVoiceLines =
{
	RandomRemaining = true,
	IsIdAlive = 427173,
	PreLineWait = 0.35,
	TriggerOnceThisRun = true,
	UsePlayerSource = true,
	TriggerCooldowns = { "HouseNPCAnySpeech", },
	RequiredLifetimeResourcesSpentMax = { Gems = 3000, SuperGems = 10 },
	SuccessiveChanceToPlayAll = 0.1,
	Cooldowns =
	{
		{ Name = "ZagreusMiscHouseSpeech", Time = 20 },
	},

	-- I should check in with the House Contractor.
	{ Cue = "/VO/ZagreusHome_1490" },
	-- Ought to spend some of these gems with the House Contractor.
	{ Cue = "/VO/ZagreusHome_1491" },
	-- Wonder what jobs the House Contractor has available.
	{ Cue = "/VO/ZagreusHome_1492" },
}

GlobalVoiceLines.BlessedByBouldyVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 1.13,
		UsePlayerSource = true,
		SuccessiveChanceToPlayAll = 0.8,

		-- I, uh... OK!
		{ Cue = "/VO/ZagreusField_2808" },
		-- Well then!
		{ Cue = "/VO/ZagreusField_2809" },
		-- I see!
		{ Cue = "/VO/ZagreusField_2810" },
		-- Well, cheers!
		{ Cue = "/VO/ZagreusField_2811" },
		-- Enlightening!
		{ Cue = "/VO/ZagreusField_2812" },
		-- All right!
		{ Cue = "/VO/ZagreusField_2813", RequiredFalsePlayedThisRoom = { "/VO/ZagreusField_2813" }, },
		-- Fair enough!
		{ Cue = "/VO/ZagreusField_2814" },
		-- OK!
		{ Cue = "/VO/ZagreusField_2951" },
		-- OK?
		{ Cue = "/VO/ZagreusField_2952" },
		-- Indeed.
		{ Cue = "/VO/ZagreusField_2953" },
		-- Well...?
		{ Cue = "/VO/ZagreusField_2954" },
		-- Good chat!
		{ Cue = "/VO/ZagreusField_2955" },
		-- Pleasure!
		{ Cue = "/VO/ZagreusField_2956" },
		-- Huh.
		{ Cue = "/VO/ZagreusField_2957" },
		-- Thanks?
		{ Cue = "/VO/ZagreusField_2958" },
		-- Thanks!
		{ Cue = "/VO/ZagreusField_2959", RequiredFalsePlayedThisRoom = { "/VO/ZagreusField_2959" }, },
		-- Cheers?
		{ Cue = "/VO/ZagreusField_2960" },
		-- Cheers!
		{ Cue = "/VO/ZagreusField_2961" },
		-- A pleasure!
		{ Cue = "/VO/ZagreusField_4225", RequiredFalsePlayedThisRoom = { "/VO/ZagreusField_4225" }, },
		-- Well, see you!
		{ Cue = "/VO/ZagreusField_4226" },
		-- Good chat!
		{ Cue = "/VO/ZagreusField_4227" },
		-- Brilliant!
		{ Cue = "/VO/ZagreusField_4228" },
		-- That's that!
		{ Cue = "/VO/ZagreusField_4229" },
	},
	{
		ObjectType = "NPC_Sisyphus_01",
		RequiredUnitAlive = "NPC_Sisyphus_01",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlay = 0.65,
		RequiresInRun = true,
		RequiredKillEnemiesNotFound = true,
		RequiredFalseTextLinesThisRun = { "BouldyFirstMeeting" },

		-- Bouldy is much obliged!
		{ Cue = "/VO/Sisyphus_0356" },
		-- Thanks on behalf of Bouldy there!
		{ Cue = "/VO/Sisyphus_0357" },
		-- Look how happy Bouldy is!
		{ Cue = "/VO/Sisyphus_0358" },
		-- That's one good rock, isn't he, Prince!
		{ Cue = "/VO/Sisyphus_0359", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
		-- You've Bouldy's favor, Prince!
		{ Cue = "/VO/Sisyphus_0360", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
		-- I think he likes you!
		{ Cue = "/VO/Sisyphus_0361" },
		-- Bouldy is grateful.
		{ Cue = "/VO/Sisyphus_0362" },
		-- Your offering has been accepted, Prince!
		{ Cue = "/VO/Sisyphus_0363", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
		-- I'm sure he's grateful, Prince.
		{ Cue = "/VO/Sisyphus_0364", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
		-- That's good of you, Prince Z.!
		{ Cue = "/VO/Sisyphus_0365", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
		-- Bouldy has got you covered!
		{ Cue = "/VO/Sisyphus_0366" },
		-- See that, Bouldy?
		{ Cue = "/VO/Sisyphus_0367" },
		-- Think Bouldy's warming up to you!
		{ Cue = "/VO/Sisyphus_0368" },
		-- Bouldy's a good listener isn't he!
		{ Cue = "/VO/Sisyphus_0369" },
		-- You have been blessed by Bouldy!
		{ Cue = "/VO/Sisyphus_0370" },
		-- Bouldy appreciated that!
		{ Cue = "/VO/Sisyphus_0463" },
		-- Oh, look how happy Bouldy is!
		{ Cue = "/VO/Sisyphus_0464" },
		-- You're most gracious, Prince Z.
		{ Cue = "/VO/Sisyphus_0465" },
		-- You see that, Bouldy?
		{ Cue = "/VO/Sisyphus_0466" },
		-- You two have a real thing going!
		{ Cue = "/VO/Sisyphus_0467" },
		-- Bouldy's got your back.
		{ Cue = "/VO/Sisyphus_0468" },
	},
}

GlobalVoiceLines.PostBedroomIntermissionVoiceLines =
{
	{
		BreakIfPlayed = true,
		PreLineWait = 1.4,
		UsePlayerSource = true,
		RequiredAnyTextLinesThisRun = { "MegaeraWithThanatosBedroom01MegThan_BackOff" },
		-- SuccessiveChanceToPlay = 0.75,

		-- <Sigh>
		{ Cue = "/VO/ZagreusHome_0043" },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 1.4,
		UsePlayerSource = true,
		RequiredAnyTextLinesThisRun = { "BecameCloseWithMegaera01Meg_BackOff", "BecameCloseWithMegaera01_BMeg_BackOff" },
		-- SuccessiveChanceToPlay = 0.75,

		-- Sorry, Meg.
		{ Cue = "/VO/ZagreusHome_0774" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 3.5,
		UsePlayerSource = true,

		RequiredFalseTextLinesThisRun = { "BecameCloseWithThanatos01Than_BackOff", "BecameCloseWithThanatos01_BThan_BackOff", "BecameCloseWithMegaera01Meg_BackOff", "BecameCloseWithMegaera01_BMeg_BackOff" },
		-- SuccessiveChanceToPlay = 0.75,

		-- Whew...
		{ Cue = "/VO/ZagreusField_2682" },
		-- Whew...
		{ Cue = "/VO/ZagreusField_2683" },
		-- Mmph.
		{ Cue = "/VO/ZagreusField_0302" },
		-- Whew...
		{ Cue = "/VO/ZagreusField_0303" },
		-- <Sigh.>
		{ Cue = "/VO/ZagreusHome_0043" },
		-- <Sigh...>
		{ Cue = "/VO/ZagreusHome_0104" },
		-- <Sigh>
		{ Cue = "/VO/ZagreusHome_0788" },
	},
}

GlobalVoiceLines.PostBecameCloseWithDusaAftermathVoiceLines =
{
	UsePlayerSource = true,

	-- Um, I... thanks...
	{ Cue = "/VO/ZagreusHome_1965", PreLineWait = 0.45, RequiredTextLines = { "BecameCloseWithDusaAftermath01Dusa_Accept" } },
	-- Haha, OK.
	{ Cue = "/VO/ZagreusHome_1966", PreLineWait = 0.25, RequiredTextLines = { "BecameCloseWithDusaAftermath01Dusa_Decline" } },
}

-- Global Hades Lines
GlobalVoiceLines.HadesDeathTauntVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.95,
	NoTarget = true,

	-- What did I tell you?
	{ Cue = "/VO/Hades_0259" },
	-- What did I tell you.
	{ Cue = "/VO/Hades_0260" },
	-- What did you expect?
	{ Cue = "/VO/Hades_0261" },
	-- What did you expect.
	{ Cue = "/VO/Hades_0262" },
	-- Surely you could have avoided that.
	{ Cue = "/VO/Hades_0263" },
	-- That was inevitable.
	{ Cue = "/VO/Hades_0264" },
	-- I'll see you back at home.
	{ Cue = "/VO/Hades_0265" },
	-- You are a weakling, boy.
	{ Cue = "/VO/Hades_0266" },
	-- Was that truly your best?
	{ Cue = "/VO/Hades_0267" },
	-- Die, like a mere mortal.
	{ Cue = "/VO/Hades_0268" },
	-- Oh, that was it?
	{ Cue = "/VO/Hades_0269" },
	-- <Laughter>
	{ Cue = "/VO/Hades_0270" },
	-- <Laughter>
	{ Cue = "/VO/Hades_0271" },
	-- <Laughter>
	{ Cue = "/VO/Hades_0272" },
	-- A very tragic end.
	{ Cue = "/VO/Hades_0329" },
	-- Your time is up, boy.
	{ Cue = "/VO/Hades_0330" },
	-- So much for that attempt.
	{ Cue = "/VO/Hades_0331" },
	-- Whatever happened there?
	{ Cue = "/VO/Hades_0332" },
	-- You don't have what it takes. Nobody does.
	{ Cue = "/VO/Hades_0333" },
	-- A tragic end fit for a poet's verse.
	{ Cue = "/VO/Hades_0334" },
	-- How many deaths is that?
	{ Cue = "/VO/Hades_0335" },
	-- You never seem to learn.
	{ Cue = "/VO/Hades_0336" },
	-- What did I tell you?
	{ Cue = "/VO/Hades_0337" },
}

GlobalVoiceLines.HadesPostBossVoiceLines =
{
	Queue = "Interrupt",
	{
		RandomRemaining = true,
		PreLineWait = 1.35,
		NoTarget = true,
		SuccessiveChanceToPlay = 0.5,
		CooldownName = "HadesPostBossCooldown",
		CooldownTime = 30,

		-- A_PostBoss01 lines
		-- You wouldn't dare.
		{ Cue = "/VO/Intercom_0273", RequiredPlayed = { "/VO/Intercom_0274" }, RequiredFalseTextLines = { "Ending01" }, },
		-- How did you... grrr.
		{ Cue = "/VO/Intercom_0274", RequiredFalseTextLines = { "Ending01" }, },
		-- Go on and try.
		{ Cue = "/VO/Intercom_0275", RequiredPlayed = { "/VO/Intercom_0274" }, },
		-- You're going nowhere, boy.
		{ Cue = "/VO/Intercom_0276", RequiredPlayed = { "/VO/Intercom_0274" }, RequiredFalseTextLines = { "Ending01" }, },
		-- You won't be anything at all.
		{ Cue = "/VO/Intercom_0277", RequiredPlayed = { "/VO/Intercom_0274" }, RequiredPlayedThisRoom = { "/VO/ZagreusField_0891" }, RequiredFalseTextLines = { "Ending01" }, },
		-- You withstood the combined might of the Furies...
		{ Cue = "/VO/Intercom_0543", RequiredRoom = "A_PostBoss01", RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 }, },
		-- At least the Fury Sisters are on better terms.
		{ Cue = "/VO/Intercom_0544", RequiredRoom = "A_PostBoss01", RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 }, },
		-- Megaera failed again?
		{ Cue = "/VO/Intercom_0278", RequiredRoom = "A_PostBoss01", RequiredKillsThisRun = { "Harpy" }, ConsecutiveClearsOfRoom = { Name = "A_Boss01", Count = 2, }, RequiredPlayed = { "/VO/Intercom_0274" }, },
		-- You're not permitted to leave Tartarus...!
		{ Cue = "/VO/Intercom_0279", RequiredRoom = "A_PostBoss01", RequiredPlayed = { "/VO/Intercom_0274" }, RequiredFalseTextLines = { "Ending01" }, },
		-- It seems the Fury failed to do her job.
		{ Cue = "/VO/Intercom_0280", RequiredRoom = "A_PostBoss01", RequiredPlayed = { "/VO/Intercom_0274" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Megaera seems to be having difficulties.
		{ Cue = "/VO/Intercom_0325", RequiredRoom = "A_PostBoss01", RequiredKillsThisRun = { "Harpy"}, ConsecutiveClearsOfRoom = { Name = "A_Boss01", Count = 3 }, },
		-- Go on to Asphodel, and die.
		{ Cue = "/VO/Intercom_0326", RequiredRoom = "A_PostBoss01", RequiredRoomLastRun = "B_Intro", RequiredFalseTextLines = { "Ending01" }, },
		-- Did you enjoy this stint in Tartarus?
		{ Cue = "/VO/Intercom_0327", RequiredRoom = "A_PostBoss01", RequiredPlayed = { "/VO/Intercom_0274" }, },
		-- Tartarus has proved unable to contain you.
		{ Cue = "/VO/Intercom_0328", RequiredRoom = "A_PostBoss01", RequiredPlayed = { "/VO/Intercom_0274" }, RequiredMinRunsCleared = 1 },
		-- Alecto failed...?!
		{ Cue = "/VO/Intercom_0361", RequiredRoom = "A_PostBoss01", RequiredKillsThisRun = { "Harpy2"}, RequiredPlayed = { "/VO/Intercom_0274" }, },
		-- Alecto failed just as her sister did.
		{ Cue = "/VO/Intercom_0362", RequiredRoom = "A_PostBoss01", RequiredKillsThisRun = { "Harpy2"}, RequiredPlayed = { "/VO/Intercom_0274" }, },
		-- Tisiphone has failed me, has she.
		{ Cue = "/VO/Intercom_0363", RequiredRoom = "A_PostBoss01", RequiredKillsThisRun = { "Harpy3"}, RequiredPlayed = { "/VO/Intercom_0274" }, },
		-- Tisiphone, defeated...?!
		{ Cue = "/VO/Intercom_0364", RequiredRoom = "A_PostBoss01", RequiredKillsThisRun = { "Harpy3"}, RequiredPlayed = { "/VO/Intercom_0274" }, },
		-- So much for the fearsome Furies.
		{ Cue = "/VO/Intercom_0365", RequiredRoom = "A_PostBoss01", RequiredKills = { Harpy2 = 1, Harpy3 = 1 }, RequiredPlayed = { "/VO/Intercom_0274" }, },
		-- I ought to lock you up in Tartarus.
		{ Cue = "/VO/Intercom_0590", RequiredRoom = "A_PostBoss01", RequiredPlayed = { "/VO/Intercom_0274" }, RequiredFalseTextLines = { "Ending01" }, },
		-- How many times...
		{ Cue = "/VO/Intercom_0591", RequiredRoom = "A_PostBoss01", RequiredPlayed = { "/VO/Intercom_0274" }, RequiredMinCompletedRuns = 25 },
		-- Enjoy the searing heat of Asphodel.
		{ Cue = "/VO/Intercom_0592", RequiredRoom = "A_PostBoss01", RequiredPlayed = { "/VO/Intercom_0274" }, },
		-- Here's to a pleasant voyage up in Asphodel.
		{ Cue = "/VO/Intercom_0593", RequiredRoom = "A_PostBoss01", RequiredPlayed = { "/VO/Intercom_0274" }, },
		-- Do bathe yourself in magma when you get to Asphodel.
		{ Cue = "/VO/Intercom_0594", RequiredRoom = "A_PostBoss01", RequiredPlayed = { "/VO/Intercom_0274" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Suitably achieved, this time around.
		{ Cue = "/VO/Intercom_0994", RequiredRoom = "A_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- The Furies seem incapable of thwarting you.
		{ Cue = "/VO/Intercom_0995", RequiredRoom = "A_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- Your progress has been duly noted, boy.
		{ Cue = "/VO/Intercom_0996", RequiredRoom = "A_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- Is Tartarus some sort of joke to you?
		{ Cue = "/VO/Intercom_0997", RequiredRoom = "A_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- Those wretches of Tartarus cannot be relied upon.
		{ Cue = "/VO/Intercom_0998", RequiredRoom = "A_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- You'll have more difficulties up in Asphodel.
		{ Cue = "/VO/Intercom_0999", RequiredRoom = "A_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- Are you suitably warmed up for Asphodel?
		{ Cue = "/VO/Intercom_1000", RequiredRoom = "A_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- Let's see how you fare in warmer environs.
		{ Cue = "/VO/Intercom_1001", RequiredRoom = "A_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- Alecto's performance has been lacking as of late.
		{ Cue = "/VO/Intercom_1002", RequiredRoom = "A_PostBoss01", RequiredKillsThisRun = { "Harpy2"}, RequiredTextLines = { "Ending01" } },
		-- That Tisiphone has met her match with you.
		{ Cue = "/VO/Intercom_1003", RequiredRoom = "A_PostBoss01", RequiredKillsThisRun = { "Harpy3"}, RequiredTextLines = { "Ending01" } },
		-- Megaera had better not be going easy on you.
		{ Cue = "/VO/Intercom_1004", RequiredRoom = "A_PostBoss01", RequiredKillsThisRun = { "Harpy"}, RequiredTextLines = { "Ending01" } },
		-- Hrm, already made it out of Tartarus...
		{ Cue = "/VO/Intercom_1005", RequiredRoom = "A_PostBoss01", RequiredTextLines = { "Ending01" } },

		-- B_PostBoss01 lines
		-- You surpassed my Hydra.
		{ Cue = "/VO/Intercom_0380", RequiredRoom = "B_PostBoss01" },
		-- The Hydra fell to you again, did it.
		{ Cue = "/VO/Intercom_0381", RequiredRoom = "B_PostBoss01", RequiredPlayed = { "/VO/Intercom_0380" } },
		-- Where do you think you're going?
		{ Cue = "/VO/Intercom_0382", RequiredPlayed = { "/VO/Intercom_0274" }, RequiredFalseTextLines = { "Ending01" }, },
		-- No paradise awaits you, boy.
		{ Cue = "/VO/Intercom_0383", RequiredRoom = "B_PostBoss01", RequiredFalseTextLines = { "Ending01" }, },
		-- Tread lightly, boy.
		{ Cue = "/VO/Intercom_0384", RequiredPlayed = { "/VO/Intercom_0274" }, },
		-- You are testing my patience.
		{ Cue = "/VO/Intercom_0385", RequiredRoom = "B_PostBoss01", RequiredFalseTextLines = { "Ending01" }, },
		-- Still there, are you?
		{ Cue = "/VO/Intercom_0386", RequiredRoom = "B_PostBoss01", RequiredFalseTextLines = { "Ending01" }, },
		-- We'll have you back here soon enough I think.
		{ Cue = "/VO/Intercom_0387", RequiredRoom = "B_PostBoss01" },
		-- Go no further, boy. I'm warning you.
		{ Cue = "/VO/Intercom_0388", RequiredRoom = "B_PostBoss01", RequiredFalseTextLines = { "Ending01" }, },
		-- How could you, boy? That Hydra had a family!
		{ Cue = "/VO/Intercom_0389", RequiredRoom = "B_PostBoss01", RequiredPlayed = { "/VO/Intercom_0380" } },
		-- That victory of yours shall be short-lived.
		{ Cue = "/VO/Intercom_0390", RequiredRoom = "B_PostBoss01", RequiredFalseTextLines = { "Ending01" }, },
		-- Oh, I didn't see you come in.
		{ Cue = "/VO/Intercom_0391", RequiredPlayed = { "/VO/Intercom_0274" }, },
		-- I trust you had a pleasant stay in Asphodel?
		{ Cue = "/VO/Intercom_0392", RequiredRoom = "B_PostBoss01" },
		-- You think you can just walk into Elysium, do you?
		{ Cue = "/VO/Intercom_0393", RequiredRoom = "B_PostBoss01", RequiredSeenRooms = { "C_Intro" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Off to taint Elysium again?
		{ Cue = "/VO/Intercom_0595", RequiredRoom = "B_PostBoss01", RequiredSeenRooms = { "C_Intro" }, RequiredFalseTextLines = { "Ending01" }, },
		-- King Theseus is eager to see you again soon.
		{ Cue = "/VO/Intercom_0596", RequiredRoom = "B_PostBoss01", RequiredSeenRooms = { "C_Boss01" } },
		-- Just as we were finishing cleaning up Elysium...
		{ Cue = "/VO/Intercom_0597", RequiredRoom = "B_PostBoss01", RequiredSeenRooms = { "C_Boss01" } },
		-- They're already expecting you up in Elysium.
		{ Cue = "/VO/Intercom_0598", RequiredRoom = "B_PostBoss01", RequiredSeenRooms = { "C_Boss01" } },
		-- Short work of the Hydra, then, I take it.
		{ Cue = "/VO/Intercom_1006", RequiredRoom = "B_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- Had enough heat for now, I presume?
		{ Cue = "/VO/Intercom_1007", RequiredRoom = "B_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- That blasted Hydra never takes my feedback...
		{ Cue = "/VO/Intercom_1008", RequiredRoom = "B_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- It seems you're off to cooler climates, then.
		{ Cue = "/VO/Intercom_1009", RequiredRoom = "B_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- The Bloodless failed to stop you once again...
		{ Cue = "/VO/Intercom_1010", RequiredRoom = "B_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- You crossed through all of Asphodel's defenses...
		{ Cue = "/VO/Intercom_1011", RequiredRoom = "B_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- Hrm, you crossed through Asphodel quite rapidly...
		{ Cue = "/VO/Intercom_1012", RequiredRoom = "B_PostBoss01", RequiredTextLines = { "Ending01" } },
		-- Emerged from Asphodel intact, have you?
		{ Cue = "/VO/Intercom_1013", RequiredRoom = "B_PostBoss01", RequiredTextLines = { "Ending01" } },

		-- C_PostBoss01 Lines
		-- So you withstood the finest of Elysium.
		{ Cue = "/VO/Intercom_0441", RequiredRoom = "C_PostBoss01" },
		-- King Theseus has fallen to the likes of you?
		{ Cue = "/VO/Intercom_0442", RequiredRoom = "C_PostBoss01", RequiredFalseTextLines = { "Ending01" }, },
		-- Your struggles soon shall be in vain.
		{ Cue = "/VO/Intercom_0443", RequiredRoom = "C_PostBoss01", RequiredFalseTextLines = { "Ending01" }, },
		-- You really think you can get out of here?
		{ Cue = "/VO/Intercom_0444", RequiredRoom = "C_PostBoss01" },
		-- So you thwarted the Champion of Elysium.
		{ Cue = "/VO/Intercom_0445", RequiredRoom = "C_PostBoss01" },
		-- Don't make me come up there, boy.
		{ Cue = "/VO/Intercom_0446", RequiredRoom = "C_PostBoss01" },
		-- Nothing good awaits beyond my realm.
		{ Cue = "/VO/Intercom_0447", RequiredRoom = "C_PostBoss01", RequiredFalseTextLines = { "Ending01" }, },
		-- The worst is yet to come, boy.
		{ Cue = "/VO/Intercom_0448", RequiredRoom = "C_PostBoss01", RequiredFalseTextLines = { "Ending01" }, },
		-- You think you can just walk away from me?
		{ Cue = "/VO/Intercom_0449", RequiredRoom = "C_PostBoss01", RequiredFalseTextLines = { "Ending01" }, },
		-- A disappointing show from Theseus.
		{ Cue = "/VO/Intercom_0450", RequiredRoom = "C_PostBoss01" },
		-- Must I send Cerberus to block your path again?
		{ Cue = "/VO/Intercom_0451", RequiredRoom = "C_PostBoss01", RequiredTextLines = { "CerberusStyxMeeting01" } },
		-- I shall have to have a word with our King Theseus.
		{ Cue = "/VO/Intercom_0452", RequiredRoom = "C_PostBoss01" },
		-- Your stubborness shall only bring you pain.
		{ Cue = "/VO/Intercom_0453", RequiredRoom = "C_PostBoss01", RequiredFalseTextLines = { "Ending01" }, },
		-- I shall stop you by my own hand if I must.
		{ Cue = "/VO/Intercom_0454", RequiredRoom = "C_PostBoss01", RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" } },
		-- Go give the vermin in the Temple my regards.
		{ Cue = "/VO/Intercom_0599", RequiredRoom = "C_PostBoss01", RequiredSeenRooms = { "D_Combat01", "D_Combat02", "D_Combat03", "D_Combat04" } },
		-- Befriended any Satyrs lately, boy?
		{ Cue = "/VO/Intercom_0600", RequiredRoom = "C_PostBoss01", RequiredSeenRooms = { "D_Combat01", "D_Combat02", "D_Combat03", "D_Combat04" } },
		-- You force me to send Cerberus ahead, again.
		{ Cue = "/VO/Intercom_0601", RequiredRoom = "C_PostBoss01", RequiredSeenRooms = { "D_Hub" } },
		-- Cerberus is patiently at work, instead of resting here.
		{ Cue = "/VO/Intercom_0602", RequiredRoom = "C_PostBoss01", RequiredSeenRooms = { "D_Hub" } },
		-- I suppose that I shall be seeing you quite soon.
		{ Cue = "/VO/Intercom_0603", RequiredRoom = "C_PostBoss01", RequiredSeenRooms = { "D_Boss01" } },
		-- Hurry up, then, and I shall see you outside.
		{ Cue = "/VO/Intercom_0604", RequiredRoom = "C_PostBoss01", RequiredSeenRooms = { "D_Boss01" } },
		-- Go tend to the Satyr problem, for a change.
		{ Cue = "/VO/Intercom_1014", RequiredRoom = "C_PostBoss01", RequiredTextLines = { "Ending01" }, },
		-- You made short work of Theseus, I take it, boy?
		{ Cue = "/VO/Intercom_1015", RequiredRoom = "C_PostBoss01", RequiredTextLines = { "Ending01" }, },
		-- The finest of Elysium all failed to thwart you, eh?
		{ Cue = "/VO/Intercom_1016", RequiredRoom = "C_PostBoss01", RequiredTextLines = { "Ending01" }, },
		-- It seems I had best prepare myself, at this rate.
		{ Cue = "/VO/Intercom_1017", RequiredRoom = "C_PostBoss01", RequiredTextLines = { "Ending01" }, },
		-- You won't get through me quite that easily.
		{ Cue = "/VO/Intercom_1018", RequiredRoom = "C_PostBoss01", RequiredTextLines = { "Ending01" }, },
		-- So close to the surface, already...
		{ Cue = "/VO/Intercom_1019", RequiredRoom = "C_PostBoss01", RequiredTextLines = { "Ending01" }, },
		-- Elysium ought to be harder to escape than that.
		{ Cue = "/VO/Intercom_1020", RequiredRoom = "C_PostBoss01", RequiredTextLines = { "Ending01" }, },
		-- Already made it that far, have you, boy?
		{ Cue = "/VO/Intercom_1021", RequiredRoom = "C_PostBoss01", RequiredTextLines = { "Ending01" }, },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		UsePlayerSource = true,
		RequiredFalseScreensOpen = { "AwardMenu", "SellTraitMenu", "Store" },

		-- I sure did, Father.
		{ Cue = "/VO/ZagreusField_1539", RequiredPlayedThisRoom = { "/VO/Intercom_0380" }, },
		-- You are correct, Father.
		{ Cue = "/VO/ZagreusField_1540", RequiredPlayedThisRoom = { "/VO/Intercom_0380" }, },

		-- It most certainly did.
		{ Cue = "/VO/ZagreusField_1541", RequiredPlayedThisRoom = { "/VO/Intercom_0381" }, },
		-- It fell to me, indeed.
		{ Cue = "/VO/ZagreusField_1542", RequiredPlayedThisRoom = { "/VO/Intercom_0381" }, },

		-- I think I'm going to Elysium.
		{ Cue = "/VO/ZagreusField_1543", RequiredPlayedThisRoom = { "/VO/Intercom_0382" }, RequiredRoom = "B_PostBoss01" },
		-- You know exactly where.
		{ Cue = "/VO/ZagreusField_1544", RequiredPlayedThisRoom = { "/VO/Intercom_0382" }, },

		-- I figured, thanks.
		{ Cue = "/VO/ZagreusField_1545", RequiredPlayedThisRoom = { "/VO/Intercom_0383" }, },
		-- Oh I'm sure it's fine.
		{ Cue = "/VO/ZagreusField_1546", RequiredPlayedThisRoom = { "/VO/Intercom_0383" }, },

		-- Thanks for the tip.
		{ Cue = "/VO/ZagreusField_1547", RequiredPlayedThisRoom = { "/VO/Intercom_0384" }, },
		-- Don't know any other way.
		{ Cue = "/VO/ZagreusField_1548", RequiredPlayedThisRoom = { "/VO/Intercom_0384" }, },

		-- Good.
		{ Cue = "/VO/ZagreusField_1549", RequiredPlayedThisRoom = { "/VO/Intercom_0385" }, },
		-- Sounds like progress to me.
		{ Cue = "/VO/ZagreusField_1550", RequiredPlayedThisRoom = { "/VO/Intercom_0385" }, },

		-- I am, indeed.
		{ Cue = "/VO/ZagreusField_1551", RequiredPlayedThisRoom = { "/VO/Intercom_0386" }, },
		-- Seems that way.
		{ Cue = "/VO/ZagreusField_1552", RequiredPlayedThisRoom = { "/VO/Intercom_0386" }, },

		-- We'll see.
		{ Cue = "/VO/ZagreusField_1553", RequiredPlayedThisRoom = { "/VO/Intercom_0387" }, },
		-- Don't count on it.
		{ Cue = "/VO/ZagreusField_1554", RequiredPlayedThisRoom = { "/VO/Intercom_0387" }, },

		-- Or else what, Father?
		{ Cue = "/VO/ZagreusField_1555", RequiredPlayedThisRoom = { "/VO/Intercom_0388" }, },
		-- Sorry, can't turn back.
		{ Cue = "/VO/ZagreusField_1556", RequiredPlayedThisRoom = { "/VO/Intercom_0388" }, },

		-- So do I.
		{ Cue = "/VO/ZagreusField_1557", RequiredPlayedThisRoom = { "/VO/Intercom_0389" }, },
		-- Not in the mood for your jesting, Father.
		{ Cue = "/VO/ZagreusField_1558", RequiredPlayedThisRoom = { "/VO/Intercom_0389" }, },

		-- There's always the next one.
		{ Cue = "/VO/ZagreusField_1559", RequiredPlayedThisRoom = { "/VO/Intercom_0390" }, },
		-- What are you, the Three Fates?
		{ Cue = "/VO/ZagreusField_1560", RequiredPlayedThisRoom = { "/VO/Intercom_0390" }, },

		-- Don't worry, won't be long.
		{ Cue = "/VO/ZagreusField_1561", RequiredPlayedThisRoom = { "/VO/Intercom_0391" }, },
		-- Well, I did.
		{ Cue = "/VO/ZagreusField_1562", RequiredPlayedThisRoom = { "/VO/Intercom_0391" }, },

		-- Oh very much.
		{ Cue = "/VO/ZagreusField_1563", RequiredPlayedThisRoom = { "/VO/Intercom_0392" }, },
		-- You really need to turn down the heat in that place.
		{ Cue = "/VO/ZagreusField_1564", RequiredPlayedThisRoom = { "/VO/Intercom_0392" }, },

		-- Yes, yes I do.
		{ Cue = "/VO/ZagreusField_1565", RequiredPlayedThisRoom = { "/VO/Intercom_0393" }, },
		-- I absolutely do.
		{ Cue = "/VO/ZagreusField_1566", RequiredPlayedThisRoom = { "/VO/Intercom_0393" }, },


		-- C_PostBoss01 responses
		-- Detecting a pattern yet, Father?
		{ Cue = "/VO/ZagreusField_1998", RequiredPlayedThisRoom = { "/VO/Intercom_0441" }, },
		-- They weren't that great.
		{ Cue = "/VO/ZagreusField_1999", RequiredPlayedThisRoom = { "/VO/Intercom_0441" }, },

		-- Don't forget Asterius!
		{ Cue = "/VO/ZagreusField_2000", RequiredPlayedThisRoom = { "/VO/Intercom_0442" }, },
		-- He's all talk.
		{ Cue = "/VO/ZagreusField_2001", RequiredPlayedThisRoom = { "/VO/Intercom_0442" }, },

		-- So you keep saying.
		{ Cue = "/VO/ZagreusField_2002", RequiredPlayedThisRoom = { "/VO/Intercom_0443" }, },
		-- You know nothing of my struggles.
		{ Cue = "/VO/ZagreusField_2003", RequiredPlayedThisRoom = { "/VO/Intercom_0443" }, },

		-- What gave you that idea?
		{ Cue = "/VO/ZagreusField_2004", RequiredPlayedThisRoom = { "/VO/Intercom_0444" }, },
		-- I do.
		{ Cue = "/VO/ZagreusField_2005", RequiredPlayedThisRoom = { "/VO/Intercom_0444" }, },

		-- I guess word travels fast.
		{ Cue = "/VO/ZagreusField_2006", RequiredPlayedThisRoom = { "/VO/Intercom_0445" }, },
		-- I thwarted him all right.
		{ Cue = "/VO/ZagreusField_2007", RequiredPlayedThisRoom = { "/VO/Intercom_0445" }, },

		-- Not making you do anything.
		{ Cue = "/VO/ZagreusField_2008", RequiredPlayedThisRoom = { "/VO/Intercom_0446" }, },
		-- Stay home, Father.
		{ Cue = "/VO/ZagreusField_2009", RequiredPlayedThisRoom = { "/VO/Intercom_0446" }, },

		-- I'll be the judge of that.
		{ Cue = "/VO/ZagreusField_2010", RequiredPlayedThisRoom = { "/VO/Intercom_0447" }, },
		-- I'm sure I'll find something.
		{ Cue = "/VO/ZagreusField_2011", RequiredPlayedThisRoom = { "/VO/Intercom_0447" }, },

		-- Looking forward to it!
		{ Cue = "/VO/ZagreusField_2012", RequiredPlayedThisRoom = { "/VO/Intercom_0448" }, },
		-- See you soon, Father.
		{ Cue = "/VO/ZagreusField_2013", RequiredPlayedThisRoom = { "/VO/Intercom_0448" }, },

		-- It's more of a brisk jog.
		{ Cue = "/VO/ZagreusField_2014", RequiredPlayedThisRoom = { "/VO/Intercom_0449" }, },
		-- Better off this way.
		{ Cue = "/VO/ZagreusField_2015", RequiredPlayedThisRoom = { "/VO/Intercom_0449" }, },

		-- Perhaps your expectations are too high.
		{ Cue = "/VO/ZagreusField_2016", RequiredPlayedThisRoom = { "/VO/Intercom_0450" }, },
		-- I pray his ego will recover soon.
		{ Cue = "/VO/ZagreusField_2017", RequiredPlayedThisRoom = { "/VO/Intercom_0450" }, },

		-- No, but you're going to anyway.
		{ Cue = "/VO/ZagreusField_2018", RequiredPlayedThisRoom = { "/VO/Intercom_0451" }, },
		-- You leave Cerberus out of this.
		{ Cue = "/VO/ZagreusField_2019", RequiredPlayedThisRoom = { "/VO/Intercom_0451" }, },

		-- Tell him I said hi.
		{ Cue = "/VO/ZagreusField_2020", RequiredPlayedThisRoom = { "/VO/Intercom_0452" }, },
		-- Mind asking him to tone it down a bit?
		{ Cue = "/VO/ZagreusField_2021", RequiredPlayedThisRoom = { "/VO/Intercom_0452" }, },

		-- What would you know of it?
		{ Cue = "/VO/ZagreusField_2022", RequiredPlayedThisRoom = { "/VO/Intercom_0453" }, },
		-- What are you, the Fates?
		{ Cue = "/VO/ZagreusField_2023", RequiredPlayedThisRoom = { "/VO/Intercom_0453" }, },

		-- I welcome you to try.
		{ Cue = "/VO/ZagreusField_2024", RequiredPlayedThisRoom = { "/VO/Intercom_0454" }, },
		-- Then I'll deal with you same as all the rest.
		{ Cue = "/VO/ZagreusField_2025", RequiredPlayedThisRoom = { "/VO/Intercom_0454" }, },
	},
}

GlobalVoiceLines.HadesWrathAttackVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.25,
	SuccessiveChanceToPlay = 0.66,
	RequiredFalseBossPhase = 3,
	Cooldowns =
	{
		{ Name = "HadesAnyQuipSpeech" },
		{ Name = "HadesWrathSpeech", Time = 150 },
	},

	-- You test my patience!
	{ Cue = "/VO/HadesField_0054" },
	-- You had your chance!
	{ Cue = "/VO/HadesField_0056" },
	-- Hrryyaaaahhh!
	{ Cue = "/VO/HadesField_0058" },
	-- Grraaauuuugggghhh!
	{ Cue = "/VO/HadesField_0059" },
	-- You wish to anger me?!
	{ Cue = "/VO/HadesField_0060" },
	-- I've had it with you, boy!!
	{ Cue = "/VO/HadesField_0286" },
	-- Let's have it out, then, boy!!
	{ Cue = "/VO/HadesField_0287" },
	-- I shall not take such disrespect from you!!
	{ Cue = "/VO/HadesField_0288" },
	-- You wish to anger me?!
	{ Cue = "/VO/HadesField_0289" },
	-- You brought this on yourself!!
	{ Cue = "/VO/HadesField_0290" },
	-- I'll tolerate no more of this from you!!
	{ Cue = "/VO/HadesField_0291" },
	-- Raauuugghhhh!!
	{ Cue = "/VO/HadesField_0292" },
	-- Nrrraaaaghh!!
	{ Cue = "/VO/HadesField_0293" },	
}
GlobalVoiceLines.HadesBeamAttackVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.8,
		TriggerCooldowns = { "HadesAnyQuipSpeech" },
		RequiredFalseBossPhase = 3,
		Cooldowns =
		{
			-- { Name = "HadesAnyQuipSpeech" },
			{ Name = "HadesCastBeamSpeech", Time = 60 },
		},

		-- I have something for you!!
		{ Cue = "/VO/HadesField_0061" },
		-- Zagreus!!
		{ Cue = "/VO/HadesField_0062", RequiredTextLines = { "Ending01" }, },
		-- You blasted little...!
		{ Cue = "/VO/HadesField_0063" },
		-- No more!
		{ Cue = "/VO/HadesField_0064" },
		-- Enough of you!
		{ Cue = "/VO/HadesField_0065" },
		-- Out of my sight!
		{ Cue = "/VO/HadesField_0066" },
		-- Now this!!
		{ Cue = "/VO/HadesField_0300" },
		-- This is for your own good!
		{ Cue = "/VO/HadesField_0301" },
		-- Let's see you run from this!
		{ Cue = "/VO/HadesField_0302" },
		-- You'll burn!
		{ Cue = "/VO/HadesField_0303" },
		-- Behold!!
		{ Cue = "/VO/HadesField_0304" },
		-- Fire!!
		{ Cue = "/VO/HadesField_0305" },
	},
	[2] = GlobalVoiceLines.HadesWrathAttackVoiceLines,
}

GlobalVoiceLines.FatherSonArgumentVoiceLines =
{
	{
		RequiredTextLines = { "Ending01" },
		MaxRunsSinceAnyTextLines = { TextLines = { "HadesGift05" }, Count = 60 },
		RequiredFalseBossPhase = 3,
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.25,
			TriggerCooldowns = { "HadesAnyQuipSpeech", "HadesSummonSpawnsSpeech", "HadesGoneInvisSpeech" },
			Cooldowns =
			{
				{ Name = "FatherSonArgumentSpeech", Time = 320 },
				{ Name = "HadesStageSwitchSpeech", Time = 90 },
				{ Name = "ZagStageSwitchSpeech", Time = 90 },
			},

			-- Path A
			-- You think I shall go easy on you, boy?
			{ Cue = "/VO/HadesField_0506" },

			-- Path B
			-- You think your mother shall make me go soft, do you?
			{ Cue = "/VO/HadesField_0507" },

			-- Path C
			-- Why don't you clean your chambers so ferociously?
			{ Cue = "/VO/HadesField_0508" },

			-- Path D
			-- You'd not have made it here without Olympus, boy!
			{ Cue = "/VO/HadesField_0509" },

			-- Path E
			-- Which of our relatives aided you this time, boy?
			{ Cue = "/VO/HadesField_0510" },

			-- Path F
			-- You mother already begins to coddle you!
			{ Cue = "/VO/HadesField_0511" },

			-- Path G
			-- I trust you're having a most pleasant evening, boy?
			{ Cue = "/VO/HadesField_0512" },

			-- Path H
			-- Zagreus! Is this the best that you can do?
			{ Cue = "/VO/HadesField_0513" },

			-- Path I
			-- Zagreus! I trust you had a pleasant journey here?
			{ Cue = "/VO/HadesField_0515" },

			-- Path J
			-- Zagreus! How fared your plundering of my domain?
			{ Cue = "/VO/HadesField_0516" },

			-- Path K
			-- To think you're so receptive to this form of discipline!
			{ Cue = "/VO/HadesField_0517" },
		},
		-- Path A
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,
			RandomRemaining = true,
			-- You think I shall go easy on you, boy?
			RequiredLastLinePlayed = { "/VO/HadesField_0506" },

			-- Would be odd of you to start right now!
			{ Cue = "/VO/ZagreusField_4548" },
			-- What, you mean like last time?
			{ Cue = "/VO/ZagreusField_4549" },
			-- Think we both know the answer to that one!
			{ Cue = "/VO/ZagreusField_4550" },
			-- Not really, though, why do you ask?
			{ Cue = "/VO/ZagreusField_4551" },
			-- I guess we'll find out soon, won't we?
			{ Cue = "/VO/ZagreusField_4552" },
		},
		{
			PreLineWait = 0.4,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.85,

			-- You know, I think you're right!
			{ Cue = "/VO/HadesField_0518", RequiredLastLinePlayed = { "/VO/ZagreusField_4548" }, },
			-- You're easily distracted, you know that?
			{ Cue = "/VO/HadesField_0519", RequiredLastLinePlayed = { "/VO/ZagreusField_4549" }, },
			-- That we most certainly do.
			{ Cue = "/VO/HadesField_0520", RequiredLastLinePlayed = { "/VO/ZagreusField_4550" }, },
			-- A useless thought is all!
			{ Cue = "/VO/HadesField_0521", RequiredLastLinePlayed = { "/VO/ZagreusField_4551" }, },
			-- I suppose we shall!
			{ Cue = "/VO/HadesField_0522", RequiredLastLinePlayed = { "/VO/ZagreusField_4552" }, },
		},
		{
			PreLineWait = 0.4,
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.55,

			-- Why, thanks!
			{ Cue = "/VO/ZagreusField_4598", RequiredLastLinePlayed = { "/VO/HadesField_0518" }, },
			-- Good chat!
			{ Cue = "/VO/ZagreusField_4599", RequiredLastLinePlayed = { "/VO/HadesField_0518" }, },

			-- Look at that lovely sky!
			{ Cue = "/VO/ZagreusField_4600", RequiredLastLinePlayed = { "/VO/HadesField_0519" }, },
			-- Am not!
			{ Cue = "/VO/ZagreusField_4601", RequiredLastLinePlayed = { "/VO/HadesField_0519" }, },

			-- Great!
			{ Cue = "/VO/ZagreusField_4602", RequiredLastLinePlayed = { "/VO/HadesField_0520" }, },
			-- All right, then!
			{ Cue = "/VO/ZagreusField_4603", RequiredLastLinePlayed = { "/VO/HadesField_0520" }, },

			-- Save it, then!
			{ Cue = "/VO/ZagreusField_4604", RequiredLastLinePlayed = { "/VO/HadesField_0521" }, },
			-- Well thanks for sharing, anyway!
			{ Cue = "/VO/ZagreusField_4605", RequiredLastLinePlayed = { "/VO/HadesField_0521" }, },

			-- Let's do it then!
			{ Cue = "/VO/ZagreusField_4606", RequiredLastLinePlayed = { "/VO/HadesField_0522" }, },
		},
		-- Path B
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,
			RandomRemaining = true,
			-- You think your mother shall make me go soft, do you?
			RequiredLastLinePlayed = { "/VO/HadesField_0507" },

			-- I'm sure she'll wear you down eventually!
			{ Cue = "/VO/ZagreusField_4553" },
			-- Who knows? Mother's full of surprises!
			{ Cue = "/VO/ZagreusField_4554" },
			-- Perish the thought of you being less difficult, Father!
			{ Cue = "/VO/ZagreusField_4555" },
			-- Is that your deepest fear of late, Father?
			{ Cue = "/VO/ZagreusField_4556" },
			-- I think you'll get there, yes!
			{ Cue = "/VO/ZagreusField_4557" },
		},
		{
			PreLineWait = 0.4,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.85,

			-- You treat her with respect!
			{ Cue = "/VO/HadesField_0523", RequiredLastLinePlayed = { "/VO/ZagreusField_4553", "/VO/ZagreusField_4554" }, },
			-- Do not treat her as you allow yourself with me!
			{ Cue = "/VO/HadesField_0524", RequiredLastLinePlayed = { "/VO/ZagreusField_4553", "/VO/ZagreusField_4554" }, },
			-- Ah, how could I forget?
			{ Cue = "/VO/HadesField_0525", RequiredLastLinePlayed = { "/VO/ZagreusField_4554" }, },
		},
		{
			PreLineWait = 0.4,
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.75,

			-- Same goes for you!
			{ Cue = "/VO/ZagreusField_4607", RequiredLastLinePlayed = { "/VO/HadesField_0523", "/VO/HadesField_0524" }, },
			-- Worry about yourself!
			{ Cue = "/VO/ZagreusField_4608", RequiredLastLinePlayed = { "/VO/HadesField_0523", "/VO/HadesField_0524" }, },
			-- Likewise to you!
			{ Cue = "/VO/ZagreusField_4609", RequiredLastLinePlayed = { "/VO/HadesField_0523", "/VO/HadesField_0524" }, },
			-- No plans for that!
			{ Cue = "/VO/ZagreusField_4610", RequiredLastLinePlayed = { "/VO/HadesField_0523", "/VO/HadesField_0524" }, },
			-- Old age, it happens!
			{ Cue = "/VO/ZagreusField_4611", RequiredLastLinePlayed = { "/VO/HadesField_0525" }, },
			-- You've been so busy!
			{ Cue = "/VO/ZagreusField_4612", RequiredLastLinePlayed = { "/VO/HadesField_0525" }, },
		},
		-- Path C
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,
			RandomRemaining = true,
			-- Why don't you clean your chambers so ferociously?
			RequiredLastLinePlayed = { "/VO/HadesField_0508" },

			-- My chambers just aren't as enjoyable to fight!
			{ Cue = "/VO/ZagreusField_4558" },
			-- What, so they could look like your boring chambers?
			{ Cue = "/VO/ZagreusField_4559" },
			-- Too busy ransacking through your domain, sorry!
			{ Cue = "/VO/ZagreusField_4560" },
			-- Why don't you concentrate on fighting back?
			{ Cue = "/VO/ZagreusField_4561" },
		},
		{
			PreLineWait = 0.4,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.85,

			-- You and your clever wit!
			{ Cue = "/VO/HadesField_0556", RequiredLastLinePlayed = { "/VO/ZagreusField_4558" }, },
			-- Bah...!
			{ Cue = "/VO/HadesField_0555", RequiredLastLinePlayed = { "/VO/ZagreusField_4558" }, },
			-- You take that back about my chambers!
			{ Cue = "/VO/HadesField_0526", RequiredLastLinePlayed = { "/VO/ZagreusField_4559" }, },
			-- What would you know of real work?
			{ Cue = "/VO/HadesField_0527", RequiredLastLinePlayed = { "/VO/ZagreusField_4560" }, },
			-- I ask the questions here!
			{ Cue = "/VO/HadesField_0528", RequiredLastLinePlayed = { "/VO/ZagreusField_4561" }, },
		},
		{
			PreLineWait = 0.4,
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.75,

			-- Nope!
			{ Cue = "/VO/ZagreusField_4613", RequiredLastLinePlayed = { "/VO/HadesField_0526" }, },
			-- They're boring, I say!
			{ Cue = "/VO/ZagreusField_4614", RequiredLastLinePlayed = { "/VO/HadesField_0526" }, },

			-- This isn't real work?
			{ Cue = "/VO/ZagreusField_4615", RequiredLastLinePlayed = { "/VO/HadesField_0527" }, },
			-- Just what you've taught me!
			{ Cue = "/VO/ZagreusField_4616", RequiredLastLinePlayed = { "/VO/HadesField_0527" }, },

			-- Whatever you say!
			{ Cue = "/VO/ZagreusField_4617", RequiredLastLinePlayed = { "/VO/HadesField_0528" }, },
			-- Really?
			{ Cue = "/VO/ZagreusField_4618", RequiredLastLinePlayed = { "/VO/HadesField_0528" }, },
		},
		-- Path D
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,
			RandomRemaining = true,
			-- You'd not have made it here without Olympus, boy!
			RequiredLastLinePlayed = { "/VO/HadesField_0509" },

			-- That's funny, you wouldn't be here without Olympus, either!
			{ Cue = "/VO/ZagreusField_4562" },
			-- You act like you do everything yourself!
			{ Cue = "/VO/ZagreusField_4563" },
			-- You should be pleased to have their help!
			{ Cue = "/VO/ZagreusField_4564" },
			-- And what's your point, exactly, there?
			{ Cue = "/VO/ZagreusField_4565" },
		},
		{
			PreLineWait = 0.4,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.85,

			-- Bah, blast you, boy!
			{ Cue = "/VO/HadesField_0529", RequiredLastLinePlayed = { "/VO/ZagreusField_4562" }, },
			-- More than you know!
			{ Cue = "/VO/HadesField_0530", RequiredLastLinePlayed = { "/VO/ZagreusField_4563" }, },
			-- Oh, I'm delighted, boy!
			{ Cue = "/VO/HadesField_0531", RequiredLastLinePlayed = { "/VO/ZagreusField_4564" }, },
			-- Someday you'll understand!
			{ Cue = "/VO/HadesField_0532", RequiredLastLinePlayed = { "/VO/ZagreusField_4565" }, },
		},
		{
			PreLineWait = 0.4,
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.75,

			-- Blast you right back!
			{ Cue = "/VO/ZagreusField_4619", RequiredLastLinePlayed = { "/VO/HadesField_0529" }, },
			-- <Chuckle>
			{ Cue = "/VO/ZagreusField_4620", RequiredLastLinePlayed = { "/VO/HadesField_0529" }, },

			-- Well, cheers!
			{ Cue = "/VO/ZagreusField_4621", RequiredLastLinePlayed = { "/VO/HadesField_0530" }, },
			-- I know a thing or two!
			{ Cue = "/VO/ZagreusField_4622", RequiredLastLinePlayed = { "/VO/HadesField_0530" }, },

			-- I can tell!
			{ Cue = "/VO/ZagreusField_4623", RequiredLastLinePlayed = { "/VO/HadesField_0531" }, },
			-- Clearly!
			{ Cue = "/VO/ZagreusField_4624", RequiredLastLinePlayed = { "/VO/HadesField_0531" }, },

			-- Ominous!
			{ Cue = "/VO/ZagreusField_4625", RequiredLastLinePlayed = { "/VO/HadesField_0532" }, },
			-- Sounds good!
			{ Cue = "/VO/ZagreusField_4626", RequiredLastLinePlayed = { "/VO/HadesField_0532" }, },
		},
		-- Path E
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,
			RandomRemaining = true,
			-- Which of our relatives aided you this time, boy?
			RequiredLastLinePlayed = { "/VO/HadesField_0510" },

			-- I'll leave that one for you to figure out!
			{ Cue = "/VO/ZagreusField_4566" },
			-- Who do you think, Father?
			{ Cue = "/VO/ZagreusField_4567" },
			-- Oh, quite a few of them, I'll have you know!
			{ Cue = "/VO/ZagreusField_4568" },
			-- Certainly not you!
			{ Cue = "/VO/ZagreusField_4569", RequiredFalseTraits = { "HadesShoutKeepsake" }, },
		},
		{
			PreLineWait = 0.5,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.85,

			-- Enough!
			{ Cue = "/VO/HadesField_0551", RequiredLastLinePlayed = { "/VO/ZagreusField_4568", "/VO/ZagreusField_4569" }, },
			-- All right!
			{ Cue = "/VO/HadesField_0553", RequiredLastLinePlayed = { "/VO/ZagreusField_4568", "/VO/ZagreusField_4569" }, },
			-- I think it's time for you to die!
			{ Cue = "/VO/HadesField_0533", RequiredLastLinePlayed = { "/VO/ZagreusField_4567" }, },
			-- Do not pretend to even care!
			{ Cue = "/VO/HadesField_0534", RequiredLastLinePlayed = { "/VO/ZagreusField_4567" }, },
		},
		{
			PreLineWait = 0.4,
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.75,

			-- Well I would beg to differ!
			{ Cue = "/VO/ZagreusField_4627", RequiredLastLinePlayed = { "/VO/HadesField_0533" }, },
			-- Mm, no thanks!
			{ Cue = "/VO/ZagreusField_4628", RequiredLastLinePlayed = { "/VO/HadesField_0533" }, },

			-- All right, I won't!
			{ Cue = "/VO/ZagreusField_4629", RequiredLastLinePlayed = { "/VO/HadesField_0534" }, },
			-- Fine!
			{ Cue = "/VO/ZagreusField_4630", RequiredLastLinePlayed = { "/VO/HadesField_0534" }, },
		},
		-- Path F
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,
			RandomRemaining = true,
			-- You mother already begins to coddle you!
			RequiredLastLinePlayed = { "/VO/HadesField_0511" },

			-- Last I checked princes were meant to be coddled!
			{ Cue = "/VO/ZagreusField_4570" },
			-- It's called showing affection to your children, Father!
			{ Cue = "/VO/ZagreusField_4571" },
			-- Whatever will you do about it, Father?
			{ Cue = "/VO/ZagreusField_4572" },
			-- What do you even care?
			{ Cue = "/VO/ZagreusField_4573" },
		},
		{
			PreLineWait = 0.4,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.85,

			-- Ah, thank you for the information, there!
			{ Cue = "/VO/HadesField_0535", RequiredLastLinePlayed = { "/VO/ZagreusField_4570", "/VO/ZagreusField_4571" }, },
			-- Please, teach me more, then!
			{ Cue = "/VO/HadesField_0536", RequiredLastLinePlayed = { "/VO/ZagreusField_4570", "/VO/ZagreusField_4571", }, },
			-- Always such accusations, from you!
			{ Cue = "/VO/HadesField_0537", RequiredLastLinePlayed = { "/VO/ZagreusField_4573", }, },
			-- You impudent...!
			{ Cue = "/VO/HadesField_0549", RequiredLastLinePlayed = { "/VO/ZagreusField_4572", }, },
			-- You impertinent...!
			{ Cue = "/VO/HadesField_0550", RequiredLastLinePlayed = { "/VO/ZagreusField_4572", }, },
		},
		{
			PreLineWait = 0.4,
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.75,

			-- You're most welcome!
			{ Cue = "/VO/ZagreusField_4631", RequiredLastLinePlayed = { "/VO/HadesField_0535" }, },
			-- Sure thing!
			{ Cue = "/VO/ZagreusField_4632", RequiredLastLinePlayed = { "/VO/HadesField_0535" }, },
			-- Happy to!
			{ Cue = "/VO/ZagreusField_4633", RequiredLastLinePlayed = { "/VO/HadesField_0536" }, },
			-- Always!
			{ Cue = "/VO/ZagreusField_4634", RequiredLastLinePlayed = { "/VO/HadesField_0537" }, },
		},
		-- Path G
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,
			RandomRemaining = true,
			-- I trust you're having a most pleasant evening, boy?
			RequiredLastLinePlayed = { "/VO/HadesField_0512" },

			-- Quite lovely, Father, how about yourself?
			{ Cue = "/VO/ZagreusField_4574" },
			-- There's a refreshing chill now that you mention it!
			{ Cue = "/VO/ZagreusField_4575" },
			-- Oh I most definitely am, thank you, Father!
			{ Cue = "/VO/ZagreusField_4576" },
			-- It could be going better, I suppose!
			{ Cue = "/VO/ZagreusField_4577" },
		},
		{
			PreLineWait = 0.4,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.85,

			-- Oh, you know, same as ever, here!
			{ Cue = "/VO/HadesField_0538", RequiredLastLinePlayed = { "/VO/ZagreusField_4574" }, },
			-- Silence!
			{ Cue = "/VO/HadesField_0552", RequiredLastLinePlayed = { "/VO/ZagreusField_4574" }, },

			-- Just as I thought!
			{ Cue = "/VO/HadesField_0539", RequiredLastLinePlayed = { "/VO/ZagreusField_4577", }, },
			-- And such a shame for that!
			{ Cue = "/VO/HadesField_0540", RequiredLastLinePlayed = { "/VO/ZagreusField_4577" }, },

			-- You impudent...!
			{ Cue = "/VO/HadesField_0549", RequiredLastLinePlayed = { "/VO/ZagreusField_4572", }, },
			-- You impertinent...!
			{ Cue = "/VO/HadesField_0550", RequiredLastLinePlayed = { "/VO/ZagreusField_4572", }, },
		},
		{
			PreLineWait = 0.4,
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.75,

			-- Well, carry on!
			{ Cue = "/VO/ZagreusField_4635", RequiredLastLinePlayed = { "/VO/HadesField_0538" }, },
			-- Thanks for your concern!
			{ Cue = "/VO/ZagreusField_4636", RequiredLastLinePlayed = { "/VO/HadesField_0539" }, },
			-- It'll be all right!
			{ Cue = "/VO/ZagreusField_4637", RequiredLastLinePlayed = { "/VO/HadesField_0540" }, },
		},
		-- Path H
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,
			RandomRemaining = true,
			-- Zagreus! Is this the best that you can do?
			RequiredLastLinePlayed = { "/VO/HadesField_0513" },

			-- You'll have to let me know when this is over!
			{ Cue = "/VO/ZagreusField_4578" },
			-- We'll soon find out I think!
			{ Cue = "/VO/ZagreusField_4579" },
			-- I'm pretty sure it is!
			{ Cue = "/VO/ZagreusField_4580" },
			-- You know what, probably not!
			{ Cue = "/VO/ZagreusField_4581" },
		},
		{
			PreLineWait = 0.4,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.85,
			RequiredLastLinePlayed = { "/VO/ZagreusField_4568", "/VO/ZagreusField_4578", "/VO/ZagreusField_4579", "/VO/ZagreusField_4580", "/VO/ZagreusField_4581" },

			-- Enough!
			{ Cue = "/VO/HadesField_0551" },
			-- Silence!
			{ Cue = "/VO/HadesField_0552" },
			-- All right!
			{ Cue = "/VO/HadesField_0553" },
			-- End of discussion, boy!
			{ Cue = "/VO/HadesField_0554" },
			-- Bah...!
			{ Cue = "/VO/HadesField_0555" },
			-- You and your clever wit!
			{ Cue = "/VO/HadesField_0556" },
		},
		-- Path I
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,
			RandomRemaining = true,
			-- Zagreus! I trust you had a pleasant journey here?
			RequiredLastLinePlayed = { "/VO/HadesField_0515" },

			-- Oh, absolutely wonderful, thank you!
			{ Cue = "/VO/ZagreusField_4586" },
			-- It went all right, now that you mention it!
			{ Cue = "/VO/ZagreusField_4587" },
			-- Quite pleasant, actually!
			{ Cue = "/VO/ZagreusField_4588" },
			-- It's always pleasant in the Underworld!
			{ Cue = "/VO/ZagreusField_4589" },
		},
		{
			PreLineWait = 0.4,
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.75,

			-- How truly wonderful to hear.
			{ Cue = "/VO/HadesField_0543", RequiredLastLinePlayed = { "/VO/ZagreusField_4586", "/VO/ZagreusField_4587", "/VO/ZagreusField_4588", "/VO/ZagreusField_4577" }, },
		},
		-- Path J
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,
			RandomRemaining = true,
			-- Zagreus! How fared your plundering of my domain?
			RequiredLastLinePlayed = { "/VO/HadesField_0516" },

			-- It fared just great, thank you for asking, there!
			{ Cue = "/VO/ZagreusField_4590" },
			-- Could have gone better, though what can you do?
			{ Cue = "/VO/ZagreusField_4591" },
			-- Not bad at all, this time!
			{ Cue = "/VO/ZagreusField_4592" },
			-- I've had better escape attempts I think!
			{ Cue = "/VO/ZagreusField_4593" },
		},
		{
			PreLineWait = 0.4,
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.85,

			-- You're very welcome, boy!
			{ Cue = "/VO/HadesField_0541", RequiredLastLinePlayed = { "/VO/ZagreusField_4590" }, },
			-- I can do this!
			{ Cue = "/VO/HadesField_0544", RequiredLastLinePlayed = { "/VO/ZagreusField_4591" }, },
			-- How truly wonderful to hear.
			{ Cue = "/VO/HadesField_0543", RequiredLastLinePlayed = { "/VO/ZagreusField_4592" }, },
			-- Losing your spirit, same as ever, there!
			{ Cue = "/VO/HadesField_0545", RequiredLastLinePlayed = { "/VO/ZagreusField_4593" }, },
		},
		{
			PreLineWait = 0.4,
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.75,

			-- Not just yet!
			{ Cue = "/VO/ZagreusField_4638", RequiredLastLinePlayed = { "/VO/HadesField_0545" }, },
		},
		-- Path K
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.9,
			-- To think you're so receptive to this form of discipline!
			RequiredLastLinePlayed = { "/VO/HadesField_0517" },

			-- And we finally have an activity we can do together!
			{ Cue = "/VO/ZagreusField_4594" },
			-- Seems like you have a lot to learn about discipline, huh?
			{ Cue = "/VO/ZagreusField_4595" },
			-- We gods do like to fight!
			{ Cue = "/VO/ZagreusField_4596" },
			-- Discipline, that's what we're calling it?
			{ Cue = "/VO/ZagreusField_4597" },
		},
		{
			PreLineWait = 0.4,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.85,

			-- Ah, yes, indeed!
			{ Cue = "/VO/HadesField_0546", RequiredLastLinePlayed = { "/VO/ZagreusField_4594", "/VO/ZagreusField_4575", "/VO/ZagreusField_4576" }, },
			-- We've all a lot to learn, I think!
			{ Cue = "/VO/HadesField_0547", RequiredLastLinePlayed = { "/VO/ZagreusField_4595" }, },
			-- Incorrigible brat!
			{ Cue = "/VO/HadesField_0548", RequiredLastLinePlayed = { "/VO/ZagreusField_4595" }, },
			-- How thoughtful, there, indeed!
			{ Cue = "/VO/HadesField_0542", RequiredLastLinePlayed = { "/VO/ZagreusField_4595" }, },
			-- Silence!
			{ Cue = "/VO/HadesField_0552", RequiredLastLinePlayed = { "/VO/ZagreusField_4597" }, },
			-- I think it's time for you to die!
			{ Cue = "/VO/HadesField_0533", RequiredLastLinePlayed = { "/VO/ZagreusField_4596" }, },
		},
		{
			PreLineWait = 0.4,
			BreakIfPlayed = true,
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.75,

			-- Well, carry on!
			{ Cue = "/VO/ZagreusField_4635", RequiredLastLinePlayed = { "/VO/HadesField_0538" }, },
			-- Thanks for your concern!
			{ Cue = "/VO/ZagreusField_4636", RequiredLastLinePlayed = { "/VO/HadesField_0539" }, },
			-- It'll be all right!
			{ Cue = "/VO/ZagreusField_4637", RequiredLastLinePlayed = { "/VO/HadesField_0540" }, },
		},
	},
	-- pre-ending
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.25,
		TriggerCooldowns = { "HadesAnyQuipSpeech", "HadesSummonSpawnsSpeech", "HadesGoneInvisSpeech" },
		RequiredFalseTextLines = { "Ending01" },
		Cooldowns =
		{
			{ Name = "FatherSonArgumentSpeech", Time = 300 },
			{ Name = "HadesStageSwitchSpeech", Time = 70 },
			{ Name = "ZagStageSwitchSpeech", Time = 70 },
		},

		-- Path A
		-- You dare lash out against me like this, boy?
		{ Cue = "/VO/HadesField_0155" },
		-- You really think you can just walk away?
		{ Cue = "/VO/HadesField_0359", RequiredPlayed = { "/VO/HadesField_0155" } },
		-- You dare attempt to vanquish me, again?
		{ Cue = "/VO/HadesField_0360", RequiresLastRunCleared = true, RequiredPlayed = { "/VO/HadesField_0155" } },
		-- You truly think this surface is where you belong?
		{ Cue = "/VO/HadesField_0361", RequiredPlayed = { "/VO/HadesField_0155" } },
		-- Do you even realize what you're doing, boy?
		{ Cue = "/VO/HadesField_0362", RequiredPlayed = { "/VO/HadesField_0155" } },

		-- Path B
		-- Why do you keep up this foolishness?
		{ Cue = "/VO/HadesField_0158", RequiredPlayed = { "/VO/HadesField_0155" } },
		-- Why do you keep doing this, time after blasted time?
		{ Cue = "/VO/HadesField_0363", RequiredPlayed = { "/VO/HadesField_0155" } },
		-- Why have you forced me to confront you here, again?
		{ Cue = "/VO/HadesField_0364", RequiredPlayed = { "/VO/HadesField_0155" } },
		-- Why do you wish to die repeatedly like this?
		{ Cue = "/VO/HadesField_0365", RequiredPlayed = { "/VO/HadesField_0155" } },
		-- Why have you come all this way, again?
		{ Cue = "/VO/HadesField_0366", RequiredPlayed = { "/VO/HadesField_0155" } },

		-- Path C
		-- You've no control over your brutish strength!
		{ Cue = "/VO/HadesField_0216", RequiredPlayed = { "/VO/HadesField_0155" }, CooldownName = "SaidStrengthRecently", CooldownTime = 40, },
		-- That brutish strength of yours! How like your relatives you are!
		{ Cue = "/VO/HadesField_0367", RequiredPlayed = { "/VO/HadesField_0155" }, CooldownName = "SaidStrengthRecently", CooldownTime = 40, },
		-- You lack the proper form! Pure brutish strength!
		{ Cue = "/VO/HadesField_0368", RequiredPlayed = { "/VO/HadesField_0155" }, CooldownName = "SaidStrengthRecently", CooldownTime = 40, },
		-- Is this another showing of your brutish strength?
		{ Cue = "/VO/HadesField_0369", RequiredPlayed = { "/VO/HadesField_0155" }, CooldownName = "SaidStrengthRecently", CooldownTime = 40, },

		-- Path D
		-- What shall it take for you to cease with this madness?
		{ Cue = "/VO/HadesField_0217", RequiredPlayed = { "/VO/HadesField_0155" } },
		-- What shall it take for all of this to end?
		{ Cue = "/VO/HadesField_0370", RequiredPlayed = { "/VO/HadesField_0155" } },
		-- What shall it take for you to cease making me face you here?
		{ Cue = "/VO/HadesField_0371", RequiredPlayed = { "/VO/HadesField_0155" } },
		-- What shall it take for you to stop this foolishness?
		{ Cue = "/VO/HadesField_0372", RequiredPlayed = { "/VO/HadesField_0155" } },
		-- What is it going to take for you to get some sense into your head?
		{ Cue = "/VO/HadesField_0373", RequiredPlayed = { "/VO/HadesField_0155" } },
	},
	-- Path A
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.85,
		-- You dare lash out against me like this, boy?
		RequiredLastLinePlayed = { "/VO/HadesField_0155", "/VO/HadesField_0359", "/VO/HadesField_0360", "/VO/HadesField_0361", "/VO/HadesField_0362" },

		-- I do!
		{ Cue = "/VO/ZagreusField_2291" },
		-- That's right!
		{ Cue = "/VO/ZagreusField_2292" },
		-- What do you think, Father?
		{ Cue = "/VO/ZagreusField_2293" },
		-- I guess so!
		{ Cue = "/VO/ZagreusField_2294" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.75,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2293" },

		-- I think that you are an ignoble brat!
		{ Cue = "/VO/HadesField_0156" },
		-- I think you are wasting your time.
		{ Cue = "/VO/HadesField_0157" },
	},
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.65,
		RequiredLastLinePlayed = { "/VO/HadesField_0156" },

		-- Oh you'll think better of me soon!
		{ Cue = "/VO/ZagreusField_2295" },
		-- And I am shocked to hear it!
		{ Cue = "/VO/ZagreusField_2296" },
		-- And I think you're a miserable failure as a father!
		{ Cue = "/VO/ZagreusField_2297" },
	},
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.5,
		RequiredLastLinePlayed = { "/VO/HadesField_0157" },

		-- It's my time to do with as I please!
		{ Cue = "/VO/ZagreusField_2298" },
		-- I don't care what you think!
		{ Cue = "/VO/ZagreusField_2299" },
		-- Oh this isn't a waste of time at all!
		{ Cue = "/VO/ZagreusField_2300" },
	},
	-- Path B
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.85,
		-- Why do you keep up this foolishness?
		RequiredLastLinePlayed = { "/VO/HadesField_0158", "/VO/HadesField_0363", "/VO/HadesField_0364", "/VO/HadesField_0365", "/VO/HadesField_0366" },

		-- It beats having to live within your House!
		{ Cue = "/VO/ZagreusField_2301" },
		-- You know exactly why!
		{ Cue = "/VO/ZagreusField_2302" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.75,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2301" },

		-- Would that you could be useful there from time to time!
		{ Cue = "/VO/HadesField_0159" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.75,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2302" },
		RequiredFalseTextLines = { "PersephoneFirstMeeting" },

		-- You shall never find her! She is gone!
		{ Cue = "/VO/HadesField_0160" },
	},
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.65,
		RequiredLastLinePlayed = { "/VO/HadesField_0159" },

		-- You'd like that, wouldn't you?
		{ Cue = "/VO/ZagreusField_2303" },
		-- Would that you could shut up and fight!
		{ Cue = "/VO/ZagreusField_2304" },
	},
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.65,
		RequiredLastLinePlayed = { "/VO/HadesField_0160" },

		-- Liar! Why should I trust a single word you say?
		{ Cue = "/VO/ZagreusField_2305" },
		-- No! She's out there. I know it!
		{ Cue = "/VO/ZagreusField_2306" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.55,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2305" },

		-- You're but a simple fool!
		{ Cue = "/VO/HadesField_0161" },
		-- All that I've told you is for your own good.
		{ Cue = "/VO/HadesField_0162" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.55,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2306" },

		-- She's gone, I say!
		{ Cue = "/VO/HadesField_0163" },
		-- You know nothing!
		{ Cue = "/VO/HadesField_0164" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.55,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2303" },

		-- You'd like to perish, wouldn't you?!
		{ Cue = "/VO/HadesField_0165" },
		-- What would you know of it!
		{ Cue = "/VO/HadesField_0166" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.55,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2304" },

		-- Oh I can do just that.
		{ Cue = "/VO/HadesField_0167" },
		-- I'll happily oblige.
		{ Cue = "/VO/HadesField_0168" },
	},
	-- Path C
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.85,
		RequiredLastLinePlayed = { "/VO/HadesField_0216", "/VO/HadesField_0367", "/VO/HadesField_0368", "/VO/HadesField_0369" },

		-- I'll show you brutish strength!
		{ Cue = "/VO/ZagreusField_2412" },
		-- Not interested in the analysis now, Father!
		{ Cue = "/VO/ZagreusField_2413" },
	},
	-- C_1
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.85,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2412" },

		-- And I'll show you the might that vanquished the Titans themselves.
		{ Cue = "/VO/HadesField_0218" },
		-- No! You're holding back, as always.
		{ Cue = "/VO/HadesField_0219" },
	},
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.75,
		-- And I'll show you the might that vanquished the Titans themselves.
		RequiredLastLinePlayed = { "/VO/HadesField_0218" },

		-- I'm not afraid of you!
		{ Cue = "/VO/ZagreusField_2416", PreLineWait = 0.7 },
		-- I'll have you join them soon!
		{ Cue = "/VO/ZagreusField_2417" },
	},
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.75,
		-- No! You're holding back, as always.
		RequiredLastLinePlayed = { "/VO/HadesField_0219" },

		-- Am I brutish or am I holding back? Make up your blasted mind!
		{ Cue = "/VO/ZagreusField_2418" },
		-- You want me to go all out? Then fine!
		{ Cue = "/VO/ZagreusField_2419" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.35,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2416" },

		-- You ought to be.
		{ Cue = "/VO/HadesField_0226" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.35,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2417" },

		-- You impudent...!
		{ Cue = "/VO/HadesField_0227" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.35,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2418" },

		-- I'll make you regret this.
		{ Cue = "/VO/HadesField_0228" },
	},
	{
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.35,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2419" },
		PreLineWait = 0.4,

		-- Fine!
		{ Cue = "/VO/HadesField_0229" },
	},
	-- C_2
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.55,
		-- Not interested in the analysis now, Father!
		RequiredLastLinePlayed = { "/VO/ZagreusField_2413" },

		-- You have no inkling of what you need.
		{ Cue = "/VO/HadesField_0220" },
		-- Oh I think it's the perfect time.
		{ Cue = "/VO/HadesField_0221" },
	},
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.75,
		-- You have no inkling of what you need.
		RequiredLastLinePlayed = { "/VO/HadesField_0220" },

		-- I said shut up with the analysis!
		{ Cue = "/VO/ZagreusField_2420" },
		-- I need you to quit blathering and fight!
		{ Cue = "/VO/ZagreusField_2421" },
	},
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.85,
		-- Oh I think it's the perfect time.
		RequiredLastLinePlayed = { "/VO/HadesField_0221" },

		-- Oh I disagree!
		{ Cue = "/VO/ZagreusField_2422" },
		-- Well then, let's hear it!
		{ Cue = "/VO/ZagreusField_2423" },
	},
	{
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.35,
		PreLineWait = 0.4,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2420" },

		-- Unfilial oaf!
		{ Cue = "/VO/HadesField_0235" },
	},
	{
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.35,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2421" },
		PreLineWait = 0.3,

		-- Happily.
		{ Cue = "/VO/HadesField_0231" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.35,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2422" },

		-- I thought you might!
		{ Cue = "/VO/HadesField_0232" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.35,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2423" },

		-- You'd not listen even if I did!
		{ Cue = "/VO/HadesField_0233" },
	},
	-- Path D
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.85,
		RequiredLastLinePlayed = { "/VO/HadesField_0217", "/VO/HadesField_0370", "/VO/HadesField_0371", "/VO/HadesField_0372", "/VO/HadesField_0373" },

		-- You know exactly what it's going to take!
		{ Cue = "/VO/ZagreusField_2414" },
		-- It'll take you getting out of my blasted way!
		{ Cue = "/VO/ZagreusField_2415" },
	},
	-- D_1
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.85,
		-- You know exactly what it's going to take!
		RequiredLastLinePlayed = {  "/VO/ZagreusField_2291", "/VO/ZagreusField_2292", "/VO/ZagreusField_2294", "/VO/ZagreusField_2414" },

		-- Stubborn oaf!
		{ Cue = "/VO/HadesField_0222" },
		-- What you desire is impossible!
		{ Cue = "/VO/HadesField_0223" },
	},
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.75,
		-- Stubborn oaf!
		RequiredLastLinePlayed = { "/VO/HadesField_0222" },

		-- Miserable husk of a man!
		{ Cue = "/VO/ZagreusField_2424" },
		-- Wretched excuse for a father!
		{ Cue = "/VO/ZagreusField_2425" },
	},
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.75,
		-- What you desire is impossible!
		RequiredLastLinePlayed = { "/VO/HadesField_0223" },

		-- We'll see!
		{ Cue = "/VO/ZagreusField_2426" },
		-- Like you would know!
		{ Cue = "/VO/ZagreusField_2427" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.35,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2424" },

		-- What would you know of misery?!
		{ Cue = "/VO/HadesField_0234" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.35,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2425" },

		-- Such utter disrespect!
		{ Cue = "/VO/HadesField_0230" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.35,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2426" },

		-- We certainly shall!
		{ Cue = "/VO/HadesField_0236" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlay = 0.35,
		RequiredLastLinePlayed = { "/VO/ZagreusField_2427" },

		-- I do, you idiot!
		{ Cue = "/VO/HadesField_0237" },
	},
	-- D_2
	{
		RandomRemaining = true,
		PreLineWait = 0.4,
		ChanceToPlay = 0.85,
		-- It'll take you getting out of my blasted way!
		RequiredLastLinePlayed = { "/VO/ZagreusField_2415" },

		-- You cannot talk to me that way!
		{ Cue = "/VO/HadesField_0224" },
		-- No; that shall accomplish nothing.
		{ Cue = "/VO/HadesField_0225" },
	},
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.75,
		-- You cannot talk to me that way!
		RequiredLastLinePlayed = { "/VO/HadesField_0224" },

		-- Well I just did!
		{ Cue = "/VO/ZagreusField_2428" },
		-- And you cannot treat me this way!
		{ Cue = "/VO/ZagreusField_2429" },
	},
	{
		RandomRemaining = true,
		UsePlayerSource = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.75,
		-- No; that shall accomplish nothing.
		RequiredLastLinePlayed = { "/VO/HadesField_0225" },

		-- Let's test that theory!
		{ Cue = "/VO/ZagreusField_2530" },
		-- Oh I think it shall!
		{ Cue = "/VO/ZagreusField_2531" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.35,
		-- Well I just did!
		RequiredLastLinePlayed = { "/VO/ZagreusField_2428" },

		-- You won't do it again.
		{ Cue = "/VO/HadesField_0238" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.35,
		-- And you cannot treat me this way!
		RequiredLastLinePlayed = { "/VO/ZagreusField_2429" },

		-- I'll treat you as you deserve.
		{ Cue = "/VO/HadesField_0239" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.35,
		-- Let's test that theory!
		RequiredLastLinePlayed = { "/VO/ZagreusField_2530" },

		-- Happily.
		{ Cue = "/VO/HadesField_0231" },
		-- Fine!
		{ Cue = "/VO/HadesField_0229", PreLineWait = 0.25, },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.35,
		-- Oh I think it shall!
		RequiredLastLinePlayed = { "/VO/ZagreusField_2531" },

		-- I thought you might!
		{ Cue = "/VO/HadesField_0232" },
		-- You impudent...!
		{ Cue = "/VO/HadesField_0227", PreLineWait = 0.65 },
	},
}

-- alt copy below
GlobalVoiceLines.HadesComplimentVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	ObjectType = "NPC_Hades_01",
	PreLineWait = 1.3,

	-- ...Well done, Zagreus.
	{ Cue = "/VO/Hades_1189", RequiredPlayed = { "/VO/Hades_1191" }, },
	-- Your performance has been adequate of late...
	{ Cue = "/VO/Hades_1190", RequiredPlayed = { "/VO/Hades_1191" }, },
	-- You are a hard worker.
	{ Cue = "/VO/Hades_1191" },
	-- Your mother's proud of you, as you can see.
	{ Cue = "/VO/Hades_1192", RequiredPlayed = { "/VO/Hades_1191" }, },
	-- You lack several of my worst traits.
	{ Cue = "/VO/Hades_1193", RequiredPlayed = { "/VO/Hades_1191" }, },
	-- Your contributions to this realm are appreciated.
	{ Cue = "/VO/Hades_1194", RequiredPlayed = { "/VO/Hades_1191" }, },
}
GlobalVoiceLines.HadesComplimentVoiceLinesAlt =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	ObjectType = "NPC_Hades_Story_01",
	PreLineWait = 1.3,

	-- ...Well done, Zagreus.
	{ Cue = "/VO/Hades_1189", RequiredPlayed = { "/VO/Hades_1191" }, },
	-- Your performance has been adequate of late...
	{ Cue = "/VO/Hades_1190", RequiredPlayed = { "/VO/Hades_1191" }, },
	-- You are a hard worker.
	{ Cue = "/VO/Hades_1191" },
	-- Your mother's proud of you, as you can see.
	{ Cue = "/VO/Hades_1192", RequiredPlayed = { "/VO/Hades_1191" }, },
	-- You lack several of my worst traits.
	{ Cue = "/VO/Hades_1193", RequiredPlayed = { "/VO/Hades_1191" }, },
	-- Your contributions to this realm are appreciated.
	{ Cue = "/VO/Hades_1194", RequiredPlayed = { "/VO/Hades_1191" }, },
}

-- Global Megaera Lines
GlobalVoiceLines.MegaeraGreetingVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.4,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlay = 0.25,
		RequiredTextLines = { "MegaeraGift10" },

		-- You miss me, Zagreus?
		{ Cue = "/VO/MegaeraHome_0239", RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" } },
		-- What brings you back here, hm?
		{ Cue = "/VO/MegaeraHome_0240" },
		-- What is it, Zagreus?
		{ Cue = "/VO/MegaeraHome_0241" },
		-- Something you need from me?
		{ Cue = "/VO/MegaeraHome_0242" },
		-- May I help you, Zagreus?
		{ Cue = "/VO/MegaeraHome_0243" },
		-- What can I do for you?
		{ Cue = "/VO/MegaeraHome_0244" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.4,
		PlayOnceFromTableThisRun = true,
		-- SuccessiveChanceToPlay = 0.5,

		-- Tsch...
		{ Cue = "/VO/MegaeraHome_0053" },
		-- You...
		{ Cue = "/VO/MegaeraHome_0054", RequiredFalseTextLines = { "MegaeraGift10" }, },
		-- Rnnggh...
		{ Cue = "/VO/MegaeraHome_0055", RequiredFalseTextLines = { "MegaeraGift05" } },
		-- Go away.
		{ Cue = "/VO/MegaeraHome_0056", RequiredMinCompletedRuns = 4, RequiredFalseTextLines = { "MegaeraGift05" } },
		-- Hmph.
		{ Cue = "/VO/MegaeraHome_0057" },
		-- Hmm.
		{ Cue = "/VO/MegaeraHome_0066", RequiredTextLines = { "MegaeraGift03" }, },
		-- Yes?
		{ Cue = "/VO/MegaeraHome_0067", RequiredMinCompletedRuns = 4 },
		-- May I help you?
		{ Cue = "/VO/MegaeraHome_0068", RequiredMinCompletedRuns = 4 },
		-- Eh.
		{ Cue = "/VO/MegaeraHome_0069", RequiredFalseTextLines = { "MegaeraGift05" } },
		-- Khh.
		{ Cue = "/VO/MegaeraHome_0070", RequiredFalseTextLines = { "MegaeraGift06" } },
		-- What.
		{ Cue = "/VO/MegaeraHome_0071", RequiredMinCompletedRuns = 4 },
		-- Oh.
		{ Cue = "/VO/MegaeraHome_0072", RequiredFalseTextLines = { "MegaeraGift07" } },
		-- Zagreus.
		{ Cue = "/VO/MegaeraHome_0058", RequiredTextLines = { "MegaeraGift05" } },
		-- You're back.
		{ Cue = "/VO/MegaeraHome_0059", RequiredTextLines = { "MegaeraGift05" } },
		-- You're back?
		{ Cue = "/VO/MegaeraHome_0060", RequiredTextLines = { "MegaeraGift05" } },
		-- Hmm.
		{ Cue = "/VO/MegaeraHome_0061", RequiredTextLines = { "MegaeraGift05" } },
		-- Yes...?
		{ Cue = "/VO/MegaeraHome_0073", RequiredTextLines = { "MegaeraGift06" } },
		-- Hard times.
		{ Cue = "/VO/MegaeraHome_0075", RequiredTextLines = { "MegaeraGift06" } },
		-- Home again.
		{ Cue = "/VO/MegaeraHome_0076", RequiredTextLines = { "MegaeraGift06" } },
		-- Welcome back.
		{ Cue = "/VO/MegaeraHome_0188", RequiredTextLines = { "MegaeraGift10" } },
		-- Zagreus.
		{ Cue = "/VO/MegaeraHome_0189", RequiredTextLines = { "MegaeraGift07" } },
		-- Hey you.
		{ Cue = "/VO/MegaeraHome_0190", RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" } },
		-- Prince.
		{ Cue = "/VO/MegaeraHome_0191", RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" } },
		-- You're back?
		{ Cue = "/VO/MegaeraHome_0192", RequiredTextLines = { "MegaeraGift07" } },
		-- Hmm.
		{ Cue = "/VO/MegaeraHome_0193", RequiredTextLines = { "MegaeraGift09" } },
		-- Oh, hey.
		{ Cue = "/VO/MegaeraHome_0194", RequiredTextLines = { "MegaeraGift10" } },
		-- Come here.
		{ Cue = "/VO/MegaeraHome_0195", RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" } },
		-- Come here, Zag.
		{ Cue = "/VO/MegaeraHome_0196", RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" } },
		-- Over here.
		{ Cue = "/VO/MegaeraHome_0197", RequiredTextLines = { "MegaeraGift10" } },
		-- Going to come talk to me?
		{ Cue = "/VO/MegaeraHome_0198", RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" } },
	}
}

GlobalVoiceLines.MultiFuryFightStartVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.1,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.5,
		RequiredMinElapsedTime = 3,
		RequiredRoom = "A_Boss01",
		RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
		ObjectType = "Harpy",

		-- Come, sisters!
		{ Cue = "/VO/MegaeraField_0356", RequiredSupportAINames = { "Tisiphone", "Alecto" }, },
		-- Now, sisters!
		{ Cue = "/VO/MegaeraField_0357", RequiredSupportAINames = { "Tisiphone", "Alecto" }, },
		-- Prepare, sisters!
		{ Cue = "/VO/MegaeraField_0358", RequiredSupportAINames = { "Tisiphone", "Alecto" }, },
		-- Alecto, Tisiphone, now!!
		{ Cue = "/VO/MegaeraField_0361", RequiredSupportAINames = { "Tisiphone", "Alecto" }, },
		-- We are the Furies!!
		{ Cue = "/VO/MegaeraField_0365", RequiredSupportAINames = { "Tisiphone", "Alecto" }, },
		-- Now!
		{ Cue = "/VO/MegaeraField_0366" },
		-- Attack!
		{ Cue = "/VO/MegaeraField_0367" },
		-- Kill!
		{ Cue = "/VO/MegaeraField_0368" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.1,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.5,
		RequiredMinElapsedTime = 3,
		RequiredRoom = "A_Boss02",
		RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
		ObjectType = "Harpy2",

		-- Let's go, sisters!
		{ Cue = "/VO/Alecto_0289", RequiredSupportAINames = { "Tisiphone", "Megaera" }, },
		-- Now, sisters!
		{ Cue = "/VO/Alecto_0290", RequiredSupportAINames = { "Tisiphone", "Megaera" }, },
		-- Ready, sisters!
		{ Cue = "/VO/Alecto_0292", RequiredSupportAINames = { "Tisiphone", "Megaera" }, },
		-- Ready, sisters?
		{ Cue = "/VO/Alecto_0293", RequiredSupportAINames = { "Tisiphone", "Megaera" }, },
		-- Megaera, Tisiphone, now!!
		{ Cue = "/VO/Alecto_0294", RequiredSupportAINames = { "Tisiphone", "Megaera" }, },
		-- Megaera, Tis, you ready?
		{ Cue = "/VO/Alecto_0295", RequiredSupportAINames = { "Tisiphone", "Megaera" }, },
		-- We are the Furies!!
		{ Cue = "/VO/Alecto_0299", RequiredSupportAINames = { "Tisiphone", "Megaera" }, },
		-- Now!
		{ Cue = "/VO/Alecto_0300" },
		-- Attack!
		{ Cue = "/VO/Alecto_0301" },
		-- Kill!
		{ Cue = "/VO/Alecto_0302" },
	}
}

-- Global Thanatos Lines
GlobalVoiceLines.ThanatosDeathTauntVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.25,
	NoTarget = true,
	Source = { SubtitleColor = Color.ThanatosVoice },

	-- Time to go home.
	{ Cue = "/VO/Thanatos_0116" },
	-- Can't be helped.
	{ Cue = "/VO/Thanatos_0117" },
	-- You tried.
	{ Cue = "/VO/Thanatos_0118" },
	-- Oh, Zag...
	{ Cue = "/VO/Thanatos_0119" },
	-- What were you thinking.
	{ Cue = "/VO/Thanatos_0120" },
	-- You're dead.
	{ Cue = "/VO/Thanatos_0121" },
	-- You're dead, Zag.
	{ Cue = "/VO/Thanatos_0122" },
	-- You're coming with me.
	{ Cue = "/VO/Thanatos_0123" },
	-- That's it.
	{ Cue = "/VO/Thanatos_0124" },
	-- That does it.
	{ Cue = "/VO/Thanatos_0125" },
	-- Well, come along.
	{ Cue = "/VO/Thanatos_0126" },
	-- You had this coming.
	{ Cue = "/VO/Thanatos_0127" },
	-- What did you expect.
	{ Cue = "/VO/Thanatos_0128" },
	-- No escaping Death.
	{ Cue = "/VO/Thanatos_0129" },
	-- I have to take you back.
	{ Cue = "/VO/Thanatos_0130" },
	-- Let's go home.
	{ Cue = "/VO/Thanatos_0131" },
	-- Let's go, Zag.
	{ Cue = "/VO/Thanatos_0132" },
	-- We're heading home.
	{ Cue = "/VO/Thanatos_0133" },
	-- There is no escape.
	{ Cue = "/VO/Thanatos_0134" },
	-- Time to die.
	{ Cue = "/VO/Thanatos_0135" },
	-- Blood and darkness.
	{ Cue = "/VO/Thanatos_0136" },
	-- In the name of Hades.
	{ Cue = "/VO/Thanatos_0137" },
	-- Death has come.
	{ Cue = "/VO/Thanatos_0138" },
	-- Not this time.
	{ Cue = "/VO/Thanatos_0139" },
	-- I'm sorry.
	{ Cue = "/VO/Thanatos_0140" },
	-- I have to take you now.
	{ Cue = "/VO/Thanatos_0141" },
	-- It's over.
	{ Cue = "/VO/Thanatos_0142" },
	-- You're finished.
	{ Cue = "/VO/Thanatos_0143" },
	-- You brought this on yourself.
	{ Cue = "/VO/Thanatos_0144" },
	-- Your luck's run out.
	{ Cue = "/VO/Thanatos_0145" },
	-- Nothing I can do.
	{ Cue = "/VO/Thanatos_0146" },
}

GlobalVoiceLines.ThanatosGreetingVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.4,
	PlayOnceFromTableThisRun = true,

	-- Hmph.
	{ Cue = "/VO/Thanatos_0161", RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- What.
	{ Cue = "/VO/Thanatos_0183" },
	-- Well, well.
	{ Cue = "/VO/Thanatos_0188", RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- What do you need exactly.
	{ Cue = "/VO/Thanatos_0147", RequiredPlayed = { "/VO/Thanatos_0183" }, RequiredFalseTextLines = { "ThanatosGift07_A" } },
	-- Hmph.
	{ Cue = "/VO/Thanatos_0161", RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Hm.
	{ Cue = "/VO/Thanatos_0179", RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Yes?
	{ Cue = "/VO/Thanatos_0182", RequiredFalseTextLines = { "ThanatosGift06" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Tsch.
	{ Cue = "/VO/Thanatos_0180", RequiredFalseTextLines = { "ThanatosGift05" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- What?
	{ Cue = "/VO/Thanatos_0184", RequiredFalseTextLines = { "ThanatosGift05" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- You.
	{ Cue = "/VO/Thanatos_0186", RequiredFalseTextLines = { "ThanatosGift04" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- It's you.
	{ Cue = "/VO/Thanatos_0187", RequiredFalseTextLines = { "ThanatosGift05" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- What's up.
	{ Cue = "/VO/Thanatos_0152", RequiredTextLines = { "ThanatosGift04" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Heh.
	{ Cue = "/VO/Thanatos_0181", RequiredTextLines = { "ThanatosGift05" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- What is it, Zag.
	{ Cue = "/VO/Thanatos_0148", RequiredTextLines = { "ThanatosGift03" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Welcome home.
	{ Cue = "/VO/Thanatos_0192", RequiredTextLines = { "ThanatosGift05" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Sorry, Zag.
	{ Cue = "/VO/Thanatos_0191", RequiredTextLines = { "ThanatosGift06" }, RequiredPlayed = { "/VO/Thanatos_0183" }, RequiresRunNotCleared = true },
	-- You all right?
	{ Cue = "/VO/Thanatos_0189", RequiredTextLines = { "ThanatosGift06" }, RequiredPlayed = { "/VO/Thanatos_0183" }, RequiresRunNotCleared = true },
	-- You OK?
	{ Cue = "/VO/Thanatos_0190", RequiredTextLines = { "ThanatosGift06" }, RequiredPlayed = { "/VO/Thanatos_0183" }, RequiresRunNotCleared = true },
	-- Hey Zag.
	{ Cue = "/VO/Thanatos_0193", RequiredTextLines = { "ThanatosGift06" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Hey.
	{ Cue = "/VO/Thanatos_0194", RequiredTextLines = { "ThanatosGift06" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Ahem.
	-- { Cue = "/VO/Thanatos_0185" },
	-- Welcome back.
	{ Cue = "/VO/Thanatos_0425", RequiredTextLines = { "ThanatosGift07_A" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Hey Zag.
	{ Cue = "/VO/Thanatos_0426", RequiredAnyTextLines = { "BecameCloserWithThanatos01", "BecameCloserWithThanatos01_B" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Hey.
	{ Cue = "/VO/Thanatos_0427", RequiredTextLines = { "ThanatosGift10" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- You're back.
	{ Cue = "/VO/Thanatos_0428", RequiredTextLines = { "ThanatosGift06" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Good work out there.
	{ Cue = "/VO/Thanatos_0429", RequiredTextLines = { "ThanatosGift06" }, RequiredPlayed = { "/VO/Thanatos_0183" }, RequiresRunCleared = true, },
	-- Well done that time.
	{ Cue = "/VO/Thanatos_0430", RequiredTextLines = { "ThanatosGift06" }, RequiredPlayed = { "/VO/Thanatos_0183" }, RequiresRunCleared = true, },
	-- Good work.
	{ Cue = "/VO/Thanatos_0431", RequiredTextLines = { "ThanatosGift06" }, RequiredPlayed = { "/VO/Thanatos_0183" }, RequiresRunCleared = true, },
	-- Heard you made it, Zag.
	{ Cue = "/VO/Thanatos_0432", RequiredTextLines = { "ThanatosGift06" }, RequiredPlayed = { "/VO/Thanatos_0183" }, RequiresRunCleared = true, },
	-- Went all the way again, huh.
	{ Cue = "/VO/Thanatos_0433", RequiredTextLines = { "ThanatosGift08" }, RequiredPlayed = { "/VO/Thanatos_0183" }, RequiresRunCleared = true, },
	-- Glad you're back.
	{ Cue = "/VO/Thanatos_0434", RequiredAnyTextLines = { "BecameCloserWithThanatos01", "BecameCloserWithThanatos01_B" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Back in one piece.
	{ Cue = "/VO/Thanatos_0435", RequiredTextLines = { "ThanatosGift07_A" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Over here.
	{ Cue = "/VO/Thanatos_0436", RequiredTextLines = { "ThanatosGift06" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- Hm, hello.
	{ Cue = "/VO/Thanatos_0437", RequiredTextLines = { "ThanatosGift06" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
	-- What's going on, Zag.
	{ Cue = "/VO/Thanatos_0438", RequiredAnyTextLines = { "BecameCloserWithThanatos01", "BecameCloserWithThanatos01_B" }, RequiredPlayed = { "/VO/Thanatos_0183" } },
}

GlobalVoiceLines.ThanatosEnteredOfficeVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.5,
	SuccessiveChanceToPlay = 0.2,
	ObjectType = "NPC_Thanatos_01",
	RequiredSourceValueFalse = "InPartnerConversation",
	SubtitleMinDistance = 800,

	-- You're going back there?
	{ Cue = "/VO/Thanatos_0560" },
	-- Don't stay too long in there.
	{ Cue = "/VO/Thanatos_0561", RequiredPlayed = { "/VO/Thanatos_0560" }, },
	-- Looking the other way, don't worry, Zag.
	{ Cue = "/VO/Thanatos_0562", RequiredPlayed = { "/VO/Thanatos_0560" }, RequiredFalseTextLines = { "Ending01" } },
	-- Didn't see a thing.
	{ Cue = "/VO/Thanatos_0563", RequiredPlayed = { "/VO/Thanatos_0560" }, RequiredFalseTextLines = { "Ending01" } },
}
GlobalVoiceLines.ThanatosLeftOfficeVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.75,
	SuccessiveChanceToPlay = 0.33,
	ObjectType = "NPC_Thanatos_01",
	SubtitleMinDistance = 800,
	RequiredSourceValueFalse = "InPartnerConversation",

	-- Hey.
	{ Cue = "/VO/Thanatos_0564" },
	-- Back, huh.
	{ Cue = "/VO/Thanatos_0565" },
	-- You made it.
	{ Cue = "/VO/Thanatos_0566" },
	-- Done snooping?
	{ Cue = "/VO/Thanatos_0567" },
	-- Had enough in there?
	{ Cue = "/VO/Thanatos_0568" },
}
GlobalVoiceLines.AchillesLeftHadesBedroomVoiceLines =
{
	{
		RequiredTextLines = { "Inspect_DeathAreaBedroomHades_Portrait_01" },
		RequiredFalseTextLines = { "Ending01" },
		PlayOnce = true,
		{
			PreLineWait = 2.0,
			ObjectType = "NPC_Achilles_01",

			-- Find what you need?
			{ Cue = "/VO/Achilles_0325", PreLineAnim = "AchillesIdleGreeting", },
		},
		{
			UsePlayerSource = true,
			BreakIfPlayed = true,
			PreLineWait = 0.2,

			-- I did, thank you!
			{ Cue = "/VO/ZagreusHome_3280" },
		},
	},
}

-- Global Dusa Lines
GlobalVoiceLines.DusaNervousGreetingVoiceLines =
{
	{
		BreakIfPlayed = true,
		PreLineWait = 0.15,
		SuccessiveChanceToPlay = 0.25,
		ObjectType = "NPC_Dusa_01",

		-- <Gasp>
		{ Cue = "/VO/Dusa_0053" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.15,
		RequiredPlayed = { "/VO/Dusa_0053" },
		ObjectType = "NPC_Dusa_01",

		-- <Gasp>
		{ Cue = "/VO/Dusa_0053" },
		-- Eek!
		{ Cue = "/VO/Dusa_0049" },
		-- Ah!
		{ Cue = "/VO/Dusa_0050" },
		-- It's him!
		-- { Cue = "/VO/Dusa_0051" },
		-- Y, your Highness!
		{ Cue = "/VO/Dusa_0052" },
		-- Uh-oh!
		-- { Cue = "/VO/Dusa_0054" },
		-- Oh!
		{ Cue = "/VO/Dusa_0055" },
		-- Whaa--?
		{ Cue = "/VO/Dusa_0056" },
		-- H, hi!
		{ Cue = "/VO/Dusa_0057" },
		-- B, bye!
		-- { Cue = "/VO/Dusa_0058" },
		-- Hah, haha!
		{ Cue = "/VO/Dusa_0059" },
		-- Hah, haha...!
		-- { Cue = "/VO/Dusa_0060" },
		-- Hah, haha...
		-- { Cue = "/VO/Dusa_0061" },
	},
}

GlobalVoiceLines.DusaConfidentGreetingVoiceLines =
{
	{
		BreakIfPlayed = true,
		PreLineWait = 0.15,
		RequiredTextLines = { "BecameCloseWithDusa01" },
		ObjectType = "NPC_Dusa_01",

		-- Oh, hi!
		{ Cue = "/VO/Dusa_0106" },
		-- Hello!
		{ Cue = "/VO/Dusa_0107" },
		-- Hello!
		{ Cue = "/VO/Dusa_0108" },
		-- There you are!
		{ Cue = "/VO/Dusa_0109" },
		-- You're back!
		{ Cue = "/VO/Dusa_0110" },
		-- It's you!
		{ Cue = "/VO/Dusa_0111" },
		-- Hi there!
		{ Cue = "/VO/Dusa_0112" },
		-- Highness!
		{ Cue = "/VO/Dusa_0113" },
		-- Look who!
		{ Cue = "/VO/Dusa_0114" },
		-- The Prince himself!
		{ Cue = "/VO/Dusa_0115" },
		-- Whoa!
		{ Cue = "/VO/Dusa_0116" },
		-- Hey!
		{ Cue = "/VO/Dusa_0117" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.2,
		RequiredTextLines = { "BecameCloseWithDusa01" },

		-- Hi Dusa.
		{ Cue = "/VO/ZagreusHome_2018" },
		-- Hey Dusa.
		{ Cue = "/VO/ZagreusHome_2019" },
		-- Hey Dusa!
		{ Cue = "/VO/ZagreusHome_2020" },
		-- Dusa!
		{ Cue = "/VO/ZagreusHome_2021" },
	},
}

-- Global Hypnos Lines
GlobalVoiceLines.HypnosAwakenedVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.15,
	ObjectType = "NPC_Hypnos_01",
	SkipAnim = true,

	-- Wha--?
	{ Cue = "/VO/Hypnos_0009" },
	-- Huh?
	{ Cue = "/VO/Hypnos_0010" },
	-- Hah!
	{ Cue = "/VO/Hypnos_0011" },
	-- Oh!
	{ Cue = "/VO/Hypnos_0012" },
	-- Nuh!
	{ Cue = "/VO/Hypnos_0013" },
	-- Ah! Hah-ha.
	{ Cue = "/VO/Hypnos_0014" },
	-- Whoa!
	{ Cue = "/VO/Hypnos_0015" },
	-- Ahem!
	{ Cue = "/VO/Hypnos_0016" },
	-- I'm up! I'm up.
	{ Cue = "/VO/Hypnos_0017" },
	-- Wah! Ah, oh, hah!
	{ Cue = "/VO/Hypnos_0158" },
	-- Wha? Ah, oh, hehe!
	{ Cue = "/VO/Hypnos_0159" },
	-- Hrn? Oh, I, uh, hi!
	-- { Cue = "/VO/Hypnos_0160" },
	-- Nwah? I, oh, wha, hah!
	-- { Cue = "/VO/Hypnos_0161" },
	-- Ah, I'm up, I'm up!
	{ Cue = "/VO/Hypnos_0162" },
	-- Oh, wha, uh, uh, hah!
	-- { Cue = "/VO/Hypnos_0163" },
	-- Ahem, I, hm, hm, hm!
	{ Cue = "/VO/Hypnos_0164" },
	-- Whoa, wha, I, uh!
	-- { Cue = "/VO/Hypnos_0165" },
	-- Wha, who, ah!
	{ Cue = "/VO/Hypnos_0166" },
	-- Nuh, uh, ahah!
	-- { Cue = "/VO/Hypnos_0167" },
	-- Whu-- huh? Hah!
	{ Cue = "/VO/Hypnos_0265" },
	-- Oh! I, I, um, hi!
	-- { Cue = "/VO/Hypnos_0266" },
	-- Ah! Oh, um, haha!
	{ Cue = "/VO/Hypnos_0267" },
	-- Wha! Um, ah, ow!
	-- { Cue = "/VO/Hypnos_0268" },
	-- Ah, I, um, hello!
	{ Cue = "/VO/Hypnos_0269" },
}
GlobalVoiceLines.HypnosDozingOffVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.15,
	SkipAnim = true,
	Actor = "SleepyBoyOcclusion",
	ObjectType = "NPC_Hypnos_01",

	-- <Yawn>
	{ Cue = "/VO/Hypnos_0154" },
	-- <Yawn>
	{ Cue = "/VO/Hypnos_0155" },
	-- <Yawn>
	{ Cue = "/VO/Hypnos_0156" },
	-- <Yawn>
	{ Cue = "/VO/Hypnos_0157" },
}
GlobalVoiceLines.HypnosGreetingVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.15,
		SuccessiveChanceToPlay = 0.33,
		RequiredQueuedTextLines = { "HypnosAboutThanatos04" },
		ObjectType = "NPC_Hypnos_01",
		PreLineAnim = "HypnosIdleGreeting",

		-- Um, can I...?
		{ Cue = "/VO/Hypnos_0217" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.15,
		RequiredTextLines = { "Ending01" },
		ObjectType = "NPC_Hypnos_01",
		RequiresRunCleared = true,
		SuccessiveChanceToPlay = 0.75,
		PreLineAnim = "HypnosIdleGreeting",

		-- You did it!
		{ Cue = "/VO/Hypnos_0257" },
		-- Hurray!
		{ Cue = "/VO/Hypnos_0258" },
		-- Everyone, he's back!
		{ Cue = "/VO/Hypnos_0259" },
		-- He's back!
		{ Cue = "/VO/Hypnos_0260" },
		-- Heeey!
		{ Cue = "/VO/Hypnos_0261" },
		-- Nice going!
		{ Cue = "/VO/Hypnos_0262" },
		-- Great job!
		{ Cue = "/VO/Hypnos_0263" },
		-- Hoh, wow!
		{ Cue = "/VO/Hypnos_0264" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.15,
		RequiredTextLines = { "Ending01" },
		ObjectType = "NPC_Hypnos_01",
		RequiredDeathRoom = "D_Boss01",
		SuccessiveChanceToPlay = 0.75,
		PreLineAnim = "HypnosIdleGreeting",

		-- Somebody's mad...
		{ Cue = "/VO/Hypnos_0246" },
		-- Aw, too bad!
		{ Cue = "/VO/Hypnos_0247" },
		-- Oof, sorry!
		{ Cue = "/VO/Hypnos_0248" },
		-- Tough one, huh?
		{ Cue = "/VO/Hypnos_0249" },
		-- Daw...
		{ Cue = "/VO/Hypnos_0250" },
		-- Hey, sorry!
		{ Cue = "/VO/Hypnos_0251" },
		-- Hey, died again, huh?
		{ Cue = "/VO/Hypnos_0252" },
		-- Aw, it happens!
		{ Cue = "/VO/Hypnos_0253" },
		-- That's rough...
		{ Cue = "/VO/Hypnos_0254" },
		-- Redacteds...?
		{ Cue = "/VO/Hypnos_0255", RequiredTextLines = { "HypnosConsolation40" }, },
		-- Redacteds, huh.
		{ Cue = "/VO/Hypnos_0256", RequiredTextLines = { "HypnosConsolation40" }, },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.15,
		ObjectType = "NPC_Hypnos_01",
		PreLineAnim = "HypnosIdleGreeting",

		-- Aw...
		{ Cue = "/VO/Hypnos_0018", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Hello!
		{ Cue = "/VO/Hypnos_0019", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- There he is!
		{ Cue = "/VO/Hypnos_0020", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Welcome!
		{ Cue = "/VO/Hypnos_0021", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Welcome back!
		{ Cue = "/VO/Hypnos_0022" },
		-- Come on in!
		{ Cue = "/VO/Hypnos_0023", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Welcome to the House of Hades!
		{ Cue = "/VO/Hypnos_0229", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Welcome to the House of Hades!
		{ Cue = "/VO/Hypnos_0230", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Please, make yourself at home!
		{ Cue = "/VO/Hypnos_0231", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- You're home!
		{ Cue = "/VO/Hypnos_0232", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Welcome to the House of Hades?
		{ Cue = "/VO/Hypnos_0233", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Welcome!
		{ Cue = "/VO/Hypnos_0234", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Thanks for stopping by!
		{ Cue = "/VO/Hypnos_0235", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Thanks for stopping in!
		{ Cue = "/VO/Hypnos_0236", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Huh, how was it out there?
		{ Cue = "/VO/Hypnos_0237", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- You're back, huh?
		{ Cue = "/VO/Hypnos_0238", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Hiya, friend!
		{ Cue = "/VO/Hypnos_0239", RequiredPlayed = { "/VO/Hypnos_0022" }, RequiredTextLines = { "HypnosGift06" } },
		-- Hey, hey!
		{ Cue = "/VO/Hypnos_0240", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Hey it's you!
		{ Cue = "/VO/Hypnos_0241", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Hello!
		{ Cue = "/VO/Hypnos_0242", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Hello!
		{ Cue = "/VO/Hypnos_0243", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Oh hey!
		{ Cue = "/VO/Hypnos_0244", RequiredPlayed = { "/VO/Hypnos_0022" }, },
		-- Thanks for dying!
		{ Cue = "/VO/Hypnos_0245", RequiredPlayed = { "/VO/Hypnos_0022" }, },
	},
}

-- Global Persephone Lines
GlobalVoiceLines.PersephoneHomeGreetingVoiceLines =
{
	{
		BreakIfPlayed = true,
		RequiredQueuedTextLines = "PersephoneAboutOlympianReunionQuest01",
		SuccessiveChanceToPlay = 0.33,
		ObjectType = "NPC_Persephone_Home_01",

		-- Zagreus? Come here a moment, please.
		{ Cue = "/VO/Persephone_0114" },
	},
	{
		BreakIfPlayed = true,
		RequiredQueuedTextLines = "PersephoneReturnsToHouse01",
		ObjectType = "NPC_Persephone_Home_01",

		-- Zagreus, I'm back!
		{ Cue = "/VO/Persephone_0144" },
	},
	{
		{
			RandomRemaining = true,
			RequiredTrueFlags = { "PersephoneJustReturned" },
			ObjectType = "NPC_Persephone_Home_01",
			SuccessiveChanceToPlayAll = 0.5,

			-- Zagreus, I'm back!
			{ Cue = "/VO/Persephone_0144", RequiredFalsePlayedLastRun = { "/VO/Persephone_0144" }, },
			-- So good to see you, son.
			{ Cue = "/VO/Persephone_0145", RequiredPlayed = { "/VO/Persephone_0144" }, },
			-- Whew, I just got back!
			{ Cue = "/VO/Persephone_0146", RequiredPlayed = { "/VO/Persephone_0144" }, },
			-- Good to be back at last.
			{ Cue = "/VO/Persephone_0147", RequiredPlayed = { "/VO/Persephone_0144" }, },
			-- Ah look who it is!
			{ Cue = "/VO/Persephone_0143", RequiredPlayed = { "/VO/Persephone_0144" }, },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredTrueFlags = { "PersephoneJustReturned" },
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.5,
			PreLineWait = 0.3,

			-- Mother, you're back!
			{ Cue = "/VO/ZagreusHome_3602", RequiredPlayed = { "/VO/ZagreusHome_3603" }, RequiredFalsePlayedThisRoom = { "/VO/Persephone_0144", "/VO/Persephone_0146", "/VO/Persephone_0147" } },
			-- Mother!
			{ Cue = "/VO/ZagreusHome_3603" },
			-- Glad you're home.
			{ Cue = "/VO/ZagreusHome_3604", RequiredPlayed = { "/VO/ZagreusHome_3603" }, },
			-- Good to have you back.
			{ Cue = "/VO/ZagreusHome_3605", RequiredPlayed = { "/VO/ZagreusHome_3603" }, RequiredFalsePlayedThisRoom = { "/VO/Persephone_0144", "/VO/Persephone_0146", "/VO/Persephone_0147" }, },
			-- We all missed you.
			{ Cue = "/VO/ZagreusHome_3606", RequiredPlayed = { "/VO/ZagreusHome_3603" }, },
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.66,
		ObjectType = "NPC_Persephone_Home_01",
		RequiresRunCleared = true,
		RequiredFalseTextLinesThisRun = { "Ending01", "OlympianReunionQuestComplete" },

		-- Well done, Zagreus.
		{ Cue = "/VO/Persephone_0319" },
		-- Excellent work, my son.
		{ Cue = "/VO/Persephone_0320" },
		-- I knew you could do it.
		{ Cue = "/VO/Persephone_0321" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.33,
		ObjectType = "NPC_Persephone_Home_01",

		-- Zagreus!
		{ Cue = "/VO/Persephone_0142" },
		-- Ah, there you are.
		{ Cue = "/VO/Persephone_0296" },
		-- Welcome, my son.
		{ Cue = "/VO/Persephone_0297", RequiredFalseTextLinesThisRun = { "Ending01" }, },
		-- Welcome back.
		{ Cue = "/VO/Persephone_0298", RequiredFalseTextLinesThisRun = { "Ending01" }, },
		-- Hello, my son.
		{ Cue = "/VO/Persephone_0299" },
		-- Zagreus.
		{ Cue = "/VO/Persephone_0300" },
		-- Greetings.
		{ Cue = "/VO/Persephone_0301" },
	}
}

-- Global Patroclus Lines
GlobalVoiceLines.PatroclusGreetingLines =
{
	Queue = "Interrupt",
	Cooldowns =
	{
		{ Name = "PatroclusGreetedRecently", Time = 30 },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineAnim = "AchillesIdleGreeting",
		ObjectType = "NPC_Achilles_Story_01",
		SuccessiveChanceToPlay = 0.5,

		-- Why, look who.
		{ Cue = "/VO/Achilles_0222" },
		-- Hah, haha.
		{ Cue = "/VO/Achilles_0223", RequiredPlayed = { "/VO/Achilles_0222" } },
		-- Hello, lad.
		{ Cue = "/VO/Achilles_0224", RequiredPlayed = { "/VO/Achilles_0222" } },
		-- Look, Pat.
		{ Cue = "/VO/Achilles_0225", RequiredPlayed = { "/VO/Achilles_0222" } },
		-- We've a guest.
		{ Cue = "/VO/Achilles_0226", RequiredPlayed = { "/VO/Achilles_0222" } },
		-- Ah, you're here.
		{ Cue = "/VO/Achilles_0227", RequiredPlayed = { "/VO/Achilles_0222" } },
		-- How goes it, lad?
		{ Cue = "/VO/Achilles_0228", RequiredPlayed = { "/VO/Achilles_0222" } },
		-- Come all this way, huh.
		{ Cue = "/VO/Achilles_0229", RequiredPlayed = { "/VO/Achilles_0222" } },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		RequiredFalseTextLines = { "MyrmidonReunionQuestComplete" },
		ObjectType = "NPC_Patroclus_01",

		-- Oh.
		{ Cue = "/VO/Patroclus_0152", RequiredPlayed = { "/VO/Patroclus_0158"} },
		-- Although...
		{ Cue = "/VO/Patroclus_0153", RequiredPlayed = { "/VO/Patroclus_0158"} },
		-- But anyway...
		{ Cue = "/VO/Patroclus_0155", RequiredPlayed = { "/VO/Patroclus_0158"} },
		-- ...Ah.
		{ Cue = "/VO/Patroclus_0156", RequiredPlayed = { "/VO/Patroclus_0158"} },
		-- ...You.
		{ Cue = "/VO/Patroclus_0157", RequiredPlayed = { "/VO/Patroclus_0158"} },
		-- Well...
		{ Cue = "/VO/Patroclus_0158" },
		-- <Chuckle>
		{ Cue = "/VO/Patroclus_0076", RequiredPlayed = { "/VO/Patroclus_0158"} },
		-- <Chuckle>
		{ Cue = "/VO/Patroclus_0342", RequiredPlayed = { "/VO/Patroclus_0158"} },
		-- Hrn?
		{ Cue = "/VO/Patroclus_0333", RequiredPlayed = { "/VO/Patroclus_0158"} },
		-- Eh...
		{ Cue = "/VO/Patroclus_0334", RequiredPlayed = { "/VO/Patroclus_0158"} },
		-- Heh...
		{ Cue = "/VO/Patroclus_0335", RequiredPlayed = { "/VO/Patroclus_0158"} },
		-- Hm.
		{ Cue = "/VO/Patroclus_0336", RequiredPlayed = { "/VO/Patroclus_0158"} },
		-- Ah yes.
		{ Cue = "/VO/Patroclus_0337", RequiredPlayed = { "/VO/Patroclus_0158"} },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		RequiredTextLines = { "MyrmidonReunionQuestComplete" },
		ObjectType = "NPC_Patroclus_01",
		IsIdAlive = 563036,
		SuccessiveChanceToPlayAll = 0.25,

		-- Achilles, look.
		{ Cue = "/VO/Patroclus_0227",  },
		-- We have a visitor.
		{ Cue = "/VO/Patroclus_0228" },
		-- Here comes our guest.
		{ Cue = "/VO/Patroclus_0229" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		RequiredTextLines = { "MyrmidonReunionQuestComplete" },
		ObjectType = "NPC_Patroclus_01",
		SuccessiveChanceToPlay = 0.66,

		-- You're back.
		{ Cue = "/VO/Patroclus_0220" },
		-- You're back, stranger.
		{ Cue = "/VO/Patroclus_0221" },
		-- Ah.
		{ Cue = "/VO/Patroclus_0222" },
		-- Oh.
		{ Cue = "/VO/Patroclus_0223" },
		-- Welcome back.
		{ Cue = "/VO/Patroclus_0224" },
		-- You're back.
		{ Cue = "/VO/Patroclus_0225" },
		-- It's you.
		{ Cue = "/VO/Patroclus_0226" },
		-- Well, look who.
		{ Cue = "/VO/Patroclus_0230" },
		-- Stranger.
		{ Cue = "/VO/Patroclus_0231" },
		-- Stranger...!
		{ Cue = "/VO/Patroclus_0232" },
		-- Hello again.
		{ Cue = "/VO/Patroclus_0233" },
	},
}

GlobalVoiceLines.PatroclusMutteringLines =
{
	{
		{
			PlayOnce = true,
			RandomRemaining = true,
			Queue = "Interrupt",
			PreLineWait = 0.75,
			-- SuccessiveChanceToPlayAll = 0.25,
			IsIdAlive = 563036,
			-- SubtitleMinDistance = 1300,
			Actor = "StrangerOcclusionP",
			ObjectType = "NPC_Achilles_Story_01",

			-- ...and then, when that pig-headed braggart ordered me to do it, I swear... 
			{ Cue = "/VO/Achilles_0260" },
		},
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			Queue = "Interrupt",
			PreLineWait = 0.7,
			-- SuccessiveChanceToPlayAll = 0.25,
			IsIdAlive = 563036,
			-- SubtitleMinDistance = 1300,
			Actor = "StrangerOcclusionP",
			ObjectType = "NPC_Achilles_Story_01",
			RequiredFalsePlayedThisRoom = { "/VO/Achilles_0222" },

			-- ...were it not for you, Pat, I don't even like to think about what I'd have done. The war would have gone differently, then, I suppose.
			{ Cue = "/VO/Achilles_0353" },
		},
	},
	{
		-- after reunion
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			Queue = "Interrupt",
			PreLineWait = 0.75,
			-- SuccessiveChanceToPlayAll = 0.5,
			-- SubtitleMinDistance = 1300,
			RequiredFalsePlayedThisRoom = { "/VO/Achilles_0260" },
			Actor = "StrangerOcclusionP",
			IsIdAlive = 563036,

			-- ...hahaha, that was an amazing day, indeed.
			{ Cue = "/VO/Patroclus_0304", PreLineWait = 1.0, BreakIfPlayed = true, },
			-- ...a moment, we have other company, I think.
			{ Cue = "/VO/Patroclus_0305", PreLineWait = 1.0, BreakIfPlayed = true, },
			-- ...oh, I am not so certain about that, are you quite sure?
			{ Cue = "/VO/Patroclus_0306", PreLineWait = 1.0 },
			-- ...come now, I don't think that's anything to be concerned about.
			{ Cue = "/VO/Patroclus_0307", PreLineWait = 1.0 },
			-- ...always the stubbornness, well, fine, have it your way...!
			{ Cue = "/VO/Patroclus_0308", PreLineWait = 1.0 },
			-- ...isn't fear for the weak, my friend?
			{ Cue = "/VO/Patroclus_0309", PreLineWait = 1.0 },
			-- ...haha, wait, my friend, someone is here.
			{ Cue = "/VO/Patroclus_0310", PreLineWait = 1.0 },
			-- ...hahaha, oh, it seems we have a visitor.
			{ Cue = "/VO/Patroclus_0311", PreLineWait = 1.0 },
			-- ...hahaha, someone's coming, wait...
			{ Cue = "/VO/Patroclus_0312", PreLineWait = 1.0 },
			-- ...mm, but it would seem we have a visitor, don't we?
			{ Cue = "/VO/Patroclus_0313", PreLineWait = 1.0 },
			-- ...though, look there, that's your ward approaching, no?
			{ Cue = "/VO/Patroclus_0314", PreLineWait = 1.0 },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			Queue = "Interrupt",
			PreLineWait = 0.75,
			-- SuccessiveChanceToPlayAll = 0.5,
			-- SubtitleMinDistance = 1300,
			Actor = "StrangerOcclusionP",
			IsIdAlive = 563036,

			ObjectType = "NPC_Achilles_Story_01",
			SuccessiveChanceToPlay = 0.5,

			-- More than quite sure, indeed!
			{ Cue = "/VO/Achilles_0261", RequiredPlayedThisRoom = { "/VO/Patroclus_0306" }, },
			-- Well I suppose you're right.
			{ Cue = "/VO/Achilles_0262", RequiredPlayedThisRoom = { "/VO/Patroclus_0307" }, },
			-- Oh, come on, you can fight better than that.
			{ Cue = "/VO/Achilles_0263", RequiredPlayedThisRoom = { "/VO/Patroclus_0308" }, },
			-- Indeed it is, you're right.
			{ Cue = "/VO/Achilles_0264", RequiredPlayedThisRoom = { "/VO/Patroclus_0309" }, },
			-- You're right!
			{ Cue = "/VO/Achilles_0265", RequiredPlayedThisRoom = { "/VO/Patroclus_0310" }, },
			-- We do.
			{ Cue = "/VO/Achilles_0266", RequiredPlayedThisRoom = { "/VO/Patroclus_0311" }, },
			-- Ah, yes.
			{ Cue = "/VO/Achilles_0267", RequiredPlayedThisRoom = { "/VO/Patroclus_0312" }, },
			-- Indeed!
			{ Cue = "/VO/Achilles_0268", RequiredPlayedThisRoom = { "/VO/Patroclus_0313" }, },
			-- I do believe it is!
			{ Cue = "/VO/Achilles_0269", RequiredPlayedThisRoom = { "/VO/Patroclus_0314" }, },
		},		
		-- after reunion
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			Queue = "Interrupt",
			PreLineWait = 0.75,
			SuccessiveChanceToPlayAll = 0.5,
			-- SubtitleMinDistance = 1300,
			Actor = "StrangerOcclusionP",
			RequiredTextLines = { "MyrmidonReunionQuestComplete" },
			AreIdsNotAlive = { 563036 },

			-- ...We were invincible, together, weren't we? Though, I have never missed those days...
			{ Cue = "/VO/Patroclus_0295", PreLineWait = 1.0 },
			-- ...I thought that I was lost, just... wandering, but, not even moving, just... being here...
			{ Cue = "/VO/Patroclus_0296", PreLineWait = 1.0 },
			-- ...When is he going to return again, it's been a bit too long...
			{ Cue = "/VO/Patroclus_0297", PreLineWait = 1.0 },
			-- ...That blasted god, I hope that he is treating you with every due respect...
			{ Cue = "/VO/Patroclus_0298", PreLineWait = 1.0 },
			-- ...Who would have ever guessed, that someday we would meet again, within this place...
			{ Cue = "/VO/Patroclus_0299", PreLineWait = 1.0 },
			-- ...I wonder where you are... presiding over some proud hall somewhere...
			{ Cue = "/VO/Patroclus_0300", PreLineWait = 1.0 },
			-- ...Let's see, the glade looks nice and orderly of late, I guess...
			{ Cue = "/VO/Patroclus_0301", PreLineWait = 1.0 },
			-- ...We've all the rest of time together, now... the Fates were gentle with us, after all...
			{ Cue = "/VO/Patroclus_0302", PreLineWait = 1.0 },
			-- ...The fish are positively teeming, aren't they?
			{ Cue = "/VO/Patroclus_0303", PreLineWait = 1.0, RequiresFishingPointInRoom = true },
		},
		-- before reunion
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			Queue = "Interrupt",
			PreLineWait = 0.75,
			SuccessiveChanceToPlayAll = 0.25,
			-- SubtitleMinDistance = 1300,
			Actor = "StrangerOcclusionP",
			RequiredFalseTextLines = { "MyrmidonReunionQuestComplete" },

			{ Cue = "/VO/Patroclus_0144" },
			{ Cue = "/VO/Patroclus_0145" },
			{ Cue = "/VO/Patroclus_0146" },
			{ Cue = "/VO/Patroclus_0147" },
			{ Cue = "/VO/Patroclus_0148" },
			{ Cue = "/VO/Patroclus_0149" },
			{ Cue = "/VO/Patroclus_0150" },
			{ Cue = "/VO/Patroclus_0151" },
			-- ...To think, he could have... none of this, it didn't have to be....
			{ Cue = "/VO/Patroclus_0030", PreLineWait = 1.4 },
			-- ...He was always, you were always such a stubborn fool...
			{ Cue = "/VO/Patroclus_0031", PreLineWait = 1.4 },
			-- ...Why was I brought here, to be left alone? Where did you go... what did you do?
			{ Cue = "/VO/Patroclus_0032", PreLineWait = 1.4 },
			-- ...You're wallowing away somewhere, the same as I, but where...? And why not here...?
			{ Cue = "/VO/Patroclus_0033", PreLineWait = 1.4 },
			-- ...So then, I'll just keep waiting here, I guess. No time to lose, hahaha.
			{ Cue = "/VO/Patroclus_0034", PreLineWait = 1.4 },
			-- ...But you must hate me so, to have abandoned me among these noble champions and kings....
			{ Cue = "/VO/Patroclus_0035", PreLineWait = 1.4 },
			-- ...Truly must the gods despise us, each in turn, to have divided us like this...
			{ Cue = "/VO/Patroclus_0036", PreLineWait = 1.4 },
			-- ...What we were once, I wonder if it's but a falsely ringing memory of mine...
			{ Cue = "/VO/Patroclus_0037", PreLineWait = 1.4 },
			-- ...It's all forgettable, with just a single drink, and yet, I always hesitate...
			{ Cue = "/VO/Patroclus_0289", PreLineWait = 1.4 },
			-- ...Where are you now, I wonder, and what thoughts are running through your mind...?
			{ Cue = "/VO/Patroclus_0290", PreLineWait = 1.4 },
			-- ...So damned obstinate, about every detail... always so unyielding, to your doom...
			{ Cue = "/VO/Patroclus_0291", PreLineWait = 1.4 },
			-- ...The Fates decided this for us, I guess, and so... who are we to complain...?
			{ Cue = "/VO/Patroclus_0292", PreLineWait = 1.4 },
			-- ...What more could I have even done? Could I have swayed you, any other way? I tried, with all my might, with all my heart, you must know that, and still, it never was enough...
			{ Cue = "/VO/Patroclus_0293", PreLineWait = 1.4 },
			-- ...You chose to die in glory, not to live in peace... and all for what? Such a waste, all for your foolish pride, that you should care more to be remembered by those you shall never know than to be loved...
			{ Cue = "/VO/Patroclus_0294", PreLineWait = 1.4 },
		},
	},
}

-- misc additional voiceover
-- Theseus
GlobalVoiceLines.TheseusWrathActivationVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.1,
	CooldownTime = 40,
	CooldownName = "TheseusWrathLinesPlayedRecently",

	-- Olympians! Aid us against this fiend!
	{ Cue = "/VO/Theseus_0088", RequiredAnyUnitAlive = { "Minotaur", "Minotaur2" }, },
	-- Olympians, I call upon your aid!
	{ Cue = "/VO/Theseus_0089" },
	-- Gods of Olympus, I shall stop this monster!
	{ Cue = "/VO/Theseus_0090" },
	-- Gods above, lend me your strength!
	{ Cue = "/VO/Theseus_0091" },
	-- Gods, grant me your power!
	{ Cue = "/VO/Theseus_0092" },
	-- By the power of Olympus!!
	{ Cue = "/VO/Theseus_0093" },
	-- Witness the power of the gods!!
	{ Cue = "/VO/Theseus_0094" },
	-- Gods on high, attend me!!
	{ Cue = "/VO/Theseus_0095" },
	-- Olympus, I invoke your aid!
	{ Cue = "/VO/Theseus_0450" },
	-- Olympus, I require your assistance, now!
	{ Cue = "/VO/Theseus_0451", RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 }, },
	-- Olympus, help me, please!
	{ Cue = "/VO/Theseus_0452", RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 }, },
	-- Olympus, please avenge my chariot!
	{ Cue = "/VO/Theseus_0453", RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 }, },
	-- Olympus, vengeance for the Macedonian!!
	{ Cue = "/VO/Theseus_0454",RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 }, },
	-- Olympus, 'tis my time of need!
	{ Cue = "/VO/Theseus_0455", RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 }, },
}

GlobalVoiceLines.TheseusChariotRuinedVoiceLines =
{
	Queue = "Interrupt",
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.0,
		SuccessiveChanceToPlay = 0.02,
		ObjectType = "Theseus2",

		-- Gah, my chariot! You filth!
		{ Cue = "/VO/Theseus_0305" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.0,
		RequiredPlayed = { "/VO/Theseus_0305" },
		ObjectType = "Theseus2",

		-- Ungh, my... no!!
		{ Cue = "/VO/Theseus_0304" },
		-- Urngh, why, you!!
		{ Cue = "/VO/Theseus_0306" },
		-- Augh, no, it's ruined!!
		{ Cue = "/VO/Theseus_0307" },
		-- Nrrh I'll make you pay for this!!
		{ Cue = "/VO/Theseus_0308" },
		-- Guh, that -- you!!
		{ Cue = "/VO/Theseus_0309" },
		-- Wha, how, you!!
		{ Cue = "/VO/Theseus_0310" },
		-- My, my, my! No!!
		{ Cue = "/VO/Theseus_0311" },
		-- Chariot!! I shall avenge you!
		{ Cue = "/VO/Theseus_0312" },
		-- Noooo!!
		{ Cue = "/VO/Theseus_0313" },
		-- Augh, drat!!
		{ Cue = "/VO/Theseus_0314" },
		-- No! What depths you stoop to, fiend!!
		{ Cue = "/VO/Theseus_0315" },
		-- How dare you, monster!
		{ Cue = "/VO/Theseus_0316" },
		-- I shall get you for this!!
		{ Cue = "/VO/Theseus_0317" },
		-- Wha, why did it explode?!
		{ Cue = "/VO/Theseus_0318" },
		-- The Macedonian!!
		{ Cue = "/VO/Theseus_0319" },
		-- Another priceless chariot?!
		{ Cue = "/VO/Theseus_0320" },
		-- No, not again!!
		{ Cue = "/VO/Theseus_0321" },
		-- No!! I'd just completed the repairs!
		{ Cue = "/VO/Theseus_0322" },
		-- Again you did this to me?!
		{ Cue = "/VO/Theseus_0323" },
		-- My chariot may be gone, but we shall rise again!
		{ Cue = "/VO/Theseus_0324" },
		-- Gah, no!
		{ Cue = "/VO/Theseus_0325" },
		-- How many times?!
		{ Cue = "/VO/Theseus_0326" },
		-- My chariot, again?!
		{ Cue = "/VO/Theseus_0327" },
		-- The Macedonian, destroyed?!
		{ Cue = "/VO/Theseus_0328" },
	},
}

-- Chaos
GlobalVoiceLines.ChaosReactionVoiceLines =
{
	PreLineWait = 1.23,
	RandomRemaining = true,
	NoTarget = true,
	SuccessiveChanceToPlay = 0.33,
	RequiredTextLines = { "ChaosAboutWeaponEnchantments01", "ChaosGift01" },
	RequiredTrait = "ShieldRushBonusProjectileTrait",
	RequiredWeapon = "ShieldWeapon",
	RequiredFalseBiome = "Styx",
	RequiredFalseRooms = { "A_Boss01", "A_Boss02", "A_Boss03", "B_Boss01", "B_Boss02", "C_Boss01", "D_Boss01" },
	Source = { SubtitleColor = Color.ChaosVoice },
	CooldownTime = 400,

	-- Impressive.
	{ Cue = "/VO/Chaos_0272" },
	-- <Laughter>
	{ Cue = "/VO/Chaos_0211" },
	-- <Laughter>
	{ Cue = "/VO/Chaos_0212" },
	-- <Laughter>
	{ Cue = "/VO/Chaos_0213" },
	-- Amusing.
	{ Cue = "/VO/Chaos_0224" },
	-- Interesting.
	{ Cue = "/VO/Chaos_0225" },
	-- Intriguing.
	{ Cue = "/VO/Chaos_0226" },
	-- Indeed.
	{ Cue = "/VO/Chaos_0227" },
	-- Indeed.
	{ Cue = "/VO/Chaos_0228" },
	-- So...
	{ Cue = "/VO/Chaos_0229" },
	-- Well...
	{ Cue = "/VO/Chaos_0230" },
	-- Fine.
	{ Cue = "/VO/Chaos_0231" },
	-- This pleases me.
	{ Cue = "/VO/Chaos_0117" },
}
GlobalVoiceLines.ChaosDeathReactionVoiceLines =
{
	PreLineWait = 3.87,
	RandomRemaining = true,
	NoTarget = true,
	SuccessiveChanceToPlay = 0.2,
	RequiredTextLines = { "ChaosAboutWeaponEnchantments01", "ChaosGift01" },
	RequiredTrait = "ShieldRushBonusProjectileTrait",
	RequiredWeapon = "ShieldWeapon",
	RequiredFalseBiome = "Styx",
	Source = { SubtitleColor = Color.ChaosVoice },
	Cooldowns =
	{
		{ "ChaosDeathReactionSpeech", Time = 20 },
	},

	-- Most interesting.
	{ Cue = "/VO/Chaos_0096" },
	-- How unexpected.
	{ Cue = "/VO/Chaos_0097" },
	-- How amusing.
	{ Cue = "/VO/Chaos_0098" },
	-- Death and rebirth.
	{ Cue = "/VO/Chaos_0099" },
	-- How very droll.
	{ Cue = "/VO/Chaos_0100" },
	-- That was unfortunate.
	{ Cue = "/VO/Chaos_0101" },
	-- A perfectly fine death.
	{ Cue = "/VO/Chaos_0102" },
	-- Now that was unexpected.
	{ Cue = "/VO/Chaos_0143" },
	-- Why, that is rather strange.
	{ Cue = "/VO/Chaos_0144" },
	-- How very interesting.
	{ Cue = "/VO/Chaos_0145" },
	-- That was quite strange.
	{ Cue = "/VO/Chaos_0146" },
	-- Quite unanticipated.
	{ Cue = "/VO/Chaos_0147" },
	-- Indeed.
	{ Cue = "/VO/Chaos_0227" },
	-- Indeed.
	{ Cue = "/VO/Chaos_0228" },
	-- So...
	{ Cue = "/VO/Chaos_0229" },
	-- Well...
	{ Cue = "/VO/Chaos_0230" },
	-- Fine.
	{ Cue = "/VO/Chaos_0231" },
	-- Defeated.
	{ Cue = "/VO/Chaos_0252" },
	-- Defeated, once again.
	{ Cue = "/VO/Chaos_0253" },
}
GlobalVoiceLines.ChaosSecretUnlockedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 1.13,
		NoTarget = true,
		RequiredTextLines = { "ChaosGift03" },
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlay = 0.2,
		Source = { SubtitleColor = Color.ChaosVoice },
		RequiredMinMaxHealthAmount = 50,
		RequiredMinHealthFraction = 0.5,

		-- I summon you...
		{ Cue = "/VO/Chaos_0189",  },
		-- Son of Hades...
		{ Cue = "/VO/Chaos_0190",  },
		-- Come, Son of Hades.
		{ Cue = "/VO/Chaos_0191",  },
		-- Come to me...
		{ Cue = "/VO/Chaos_0192",  },
		-- Follow my voice...
		{ Cue = "/VO/Chaos_0193",  },
		-- Return to the abyss...
		{ Cue = "/VO/Chaos_0194",  },
		-- Enter the abyss...
		{ Cue = "/VO/Chaos_0195",  },
		-- Fall into the abyss...
		{ Cue = "/VO/Chaos_0196",  },
		-- I recommend making a brief detour.
		{ Cue = "/VO/Chaos_0197",  },
		-- Heed my call...
		{ Cue = "/VO/Chaos_0198",  },
	},
}

-- Hermes
GlobalVoiceLines.RushedHermesVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.1,
	CooldownTime = 40,
	Queue = "Interrupt",
	RequiredMaxElapsedTime = 3.35,

	-- OK so long!
	{ Cue = "/VO/Hermes_0131" },
	-- Anyway bye!
	{ Cue = "/VO/Hermes_0132" },
	-- Anyhow!
	{ Cue = "/VO/Hermes_0133" },
	-- Anyway, here!
	{ Cue = "/VO/Hermes_0134" },
	-- Yeah, yeah!
	{ Cue = "/VO/Hermes_0135" },
	-- I'm out!
	{ Cue = "/VO/Hermes_0136" },
	-- Oop, got to go!
	{ Cue = "/VO/Hermes_0137" },
	-- Later Coz!
	{ Cue = "/VO/Hermes_0138" },
	-- Eh you get the gist.
	{ Cue = "/VO/Hermes_0139" },
	-- Eh!
	{ Cue = "/VO/Hermes_0140" },
	-- Hmph!
	{ Cue = "/VO/Hermes_0141" },
	-- Feh!
	{ Cue = "/VO/Hermes_0142" },
	-- Say no more!
	{ Cue = "/VO/Hermes_0144" },
	-- Alrighty, then!
	{ Cue = "/VO/Hermes_0145" },
	-- You got it!
	{ Cue = "/VO/Hermes_0146" },
	-- You're the boss!
	{ Cue = "/VO/Hermes_0147" },
}

-- Storyteller
GlobalVoiceLines.RushedStorytellerVoiceLines =
{
	RandomRemaining = true,
	Queue = "Interrupt",
	RequiredMaxElapsedTime = 7.8,
	Source = { SubtitleColor = Color.NarratorVoice },

	-- Ahem!
	{ Cue = "/VO/Storyteller_0320" },
	-- Why, I--!
	{ Cue = "/VO/Storyteller_0321" },
	-- I never!
	{ Cue = "/VO/Storyteller_0322" },
	-- Hmph!
	{ Cue = "/VO/Storyteller_0323" },
	-- Rude!
	{ Cue = "/VO/Storyteller_0324" },
	-- But--!
	{ Cue = "/VO/Storyteller_0325" },
	-- Ah--!
	{ Cue = "/VO/Storyteller_0326" },
	-- Eh?
	{ Cue = "/VO/Storyteller_0327" },
	-- Wha--?
	{ Cue = "/VO/Storyteller_0328" },
	-- Eh...
	{ Cue = "/VO/Storyteller_0329" },
}
GlobalVoiceLines.HadesFeedbackVoiceLines =
{
	{
		PlayOnceThisRun = true,
		ObjectType = "NPC_Hades_Story_01",
		PreLineWait = 0.33,
		BreakIfPlayed = true,
		RequiredMinAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 7 },

		-- Enough, boy! Wrap it up.
		{ Cue = "/VO/Hades_0844" },
	},
	{
		PlayOnceThisRun = true,
		ObjectType = "NPC_Hades_Story_01",
		RequiredLastLinePlayed = { "/VO/ZagreusHome_2120", "/VO/ZagreusHome_2121", "/VO/ZagreusHome_2122", "/VO/ZagreusHome_2123", "/VO/ZagreusHome_2124", "/VO/ZagreusHome_2125", "/VO/ZagreusHome_2126", "/VO/ZagreusHome_2130", "/VO/ZagreusHome_2131", "/VO/ZagreusHome_2131", "/VO/ZagreusField_1139", "/VO/ZagreusField_1142" },
		PreLineWait = 0.33,
		BreakIfPlayed = true,

		-- That is not correct.
		{ Cue = "/VO/Hades_0808" },
		-- Incorrect.
		{ Cue = "/VO/Hades_0809" },
		-- That's not correct.
		{ Cue = "/VO/Hades_0810" },
		-- Wrong again.
		{ Cue = "/VO/Hades_0811" },
		-- Do you not remember anything I taught?
		{ Cue = "/VO/Hades_0812" },
		-- No, wrong.
		{ Cue = "/VO/Hades_0813" },
		-- Absolutely wrong.
		{ Cue = "/VO/Hades_0814" },
		-- I trust you're learning from all these mistakes?
		{ Cue = "/VO/Hades_0815" },
		-- Other desk.
		{ Cue = "/VO/Hades_0816" },
		-- Other desk!
		{ Cue = "/VO/Hades_0817" },
		-- Wrong desk!
		{ Cue = "/VO/Hades_0818" },
		-- That goes to desk sigma.
		{ Cue = "/VO/Hades_0819" },
		-- You're looking for desk epsilon.
		{ Cue = "/VO/Hades_0820" },
		-- Not there, desk alpha.
		{ Cue = "/VO/Hades_0821" },
		-- No, desk omega for that step.
		{ Cue = "/VO/Hades_0822" },
		-- I have seen quite enough.
		{ Cue = "/VO/Hades_0823" },
		-- More mistakes even than last time, hm?
		{ Cue = "/VO/Hades_0824" },
	},
}

-- Cosmetics
GlobalVoiceLines.HadesGhostAdminPurchaseReactionVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Hades_01",
		RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
		RequiredSourceValueFalse = "InPartnerConversation",
		Queue = "Always",
		Cooldowns =
		{
			{ "HadesGhostAdminSpeech", Time = 20 },
		},
	
		-- A decadent acquisition.
		{ Cue = "/VO/Hades_0516" },
		-- Who requested that?
		{ Cue = "/VO/Hades_0517" },
		-- I did not authorize such an expenditure.
		{ Cue = "/VO/Hades_0518" },
		-- That would not have been next on my list.
		{ Cue = "/VO/Hades_0519" },
		-- What are you doing to this House.
		{ Cue = "/VO/Hades_0521", RequiredFalseTextLines = { "Ending01" }, },
		-- Betrayed, by my own Contractor...
		{ Cue = "/VO/Hades_0522" },
		-- What is that doing there?
		{ Cue = "/VO/Hades_0523", RequiredFalseTextLines = { "Ending01" }, },
		-- A senseless change.
		{ Cue = "/VO/Hades_0530", RequiredFalseTextLines = { "Ending01" }, },
		-- What did you purchase now.
		{ Cue = "/VO/Hades_0533" },
		-- What are we supposed to do with that?
		{ Cue = "/VO/Hades_0534" },
		-- What is that even supposed to be.
		{ Cue = "/VO/Hades_0535" },
		-- I don't recall approving that expense.
		{ Cue = "/VO/Hades_0536" },
		-- Mmm-hm.
		{ Cue = "/VO/Hades_0165", RequiredTextLines = { "Ending01" }, },
		-- Mmm.
		{ Cue = "/VO/Hades_0166", RequiredTextLines = { "Ending01" }, },
		-- Hmph.
		{ Cue = "/VO/Hades_0167", RequiredTextLines = { "Ending01" }, },
		-- Indeed.
		{ Cue = "/VO/Hades_0169", RequiredTextLines = { "Ending01" }, },
		-- Indeed?
		{ Cue = "/VO/Hades_0170", RequiredTextLines = { "Ending01" }, },
		-- Really.
		{ Cue = "/VO/Hades_0172", RequiredTextLines = { "Ending01" }, },
		-- Anything else?
		{ Cue = "/VO/Hades_0768", RequiredTextLines = { "Ending01" }, },
		--[[
		-- Oh be still.
		{ Cue = "/VO/Hades_0610" },
		-- You've no authority in my domain.
		{ Cue = "/VO/Hades_0611" },
		-- You need not listen to him, Contractor.
		{ Cue = "/VO/Hades_0612" },
		-- You are distracting me!
		{ Cue = "/VO/Hades_0613" },
		-- Keep it down!
		{ Cue = "/VO/Hades_0614" },
		-- What is it that you're on about?
		{ Cue = "/VO/Hades_0615" },
		-- I give the orders around here.
		{ Cue = "/VO/Hades_0616" },
		-- What is it do you think that shall achieve?
		{ Cue = "/VO/Hades_0620" },
		-- I cannot concentrate with you about!
		{ Cue = "/VO/Hades_0622" },
		]]--
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.25,
		Queue = "Always",
		AreIdsNotAlive = { 370006 },
		UsePlayerSource = true,

		-- Very nice.
		{ Cue = "/VO/ZagreusField_0228" },
		-- Nice.
		{ Cue = "/VO/ZagreusField_0229" },
		-- Excellent.
		{ Cue = "/VO/ZagreusField_0230" },
		-- Good enough.
		{ Cue = "/VO/ZagreusField_0231" },
		-- I'll take it.
		{ Cue = "/VO/ZagreusField_0232" },
		-- Much better.
		{ Cue = "/VO/ZagreusField_0300" },
		-- That's better.
		{ Cue = "/VO/ZagreusField_0133" },
	},
}

GlobalVoiceLines.HadesQuestLogReactionVoiceLines =
{
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.75,
		ObjectType = "NPC_Hades_01",
		TriggerCooldowns = { "HadesGhostAdminSpeech", },
		RequiredLastLinePlayed = { "/VO/ZagreusHome_1336" },
		RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
		RequiredSourceValueFalse = "InPartnerConversation",

		-- You requisitioned that useless bit of parchment?
		{ Cue = "/VO/Hades_0623" },
	},
}

GlobalVoiceLines.HadesGhostAdminCriticalItemPurchaseReactionVoiceLines =
{
	{

		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Hades_01",
		RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
		RequiredSourceValueFalse = "InPartnerConversation",
		Queue = "Always",
		SuccessiveChanceToPlay = 0.75,
		Cooldowns =
		{
			{ "HadesGhostAdminSpeech", Time = 20 },
		},

		-- Oh be still.
		{ Cue = "/VO/Hades_0610" },
		-- You've no authority in my domain.
		{ Cue = "/VO/Hades_0611", RequiredFalseTextLines = { "Ending01" }, },
		-- You need not listen to him, Contractor.
		{ Cue = "/VO/Hades_0612" },
		-- You are distracting me!
		{ Cue = "/VO/Hades_0613" },
		-- Keep it down!
		{ Cue = "/VO/Hades_0614" },
		-- What is it that you're on about?
		{ Cue = "/VO/Hades_0615" },
		-- I give the orders around here.
		{ Cue = "/VO/Hades_0616" },
		-- You think the Contractor is going to help you?
		{ Cue = "/VO/Hades_0617", RequiredFalseTextLines = { "Ending01" }, },
		-- That shall be of no help to you, I'm sure.
		{ Cue = "/VO/Hades_0618" },
		-- Go practice your declaiming someplace else.
		{ Cue = "/VO/Hades_0619" },
		-- What is it do you think that shall achieve?
		{ Cue = "/VO/Hades_0620" },
		-- I cannot concentrate with you about!
		{ Cue = "/VO/Hades_0622", RequiredFalseTextLines = { "Ending01" }, },
		-- I shall review this work once the time permits!
		{ Cue = "/VO/Hades_0639" },
		-- Whatever are you are going on about?
		{ Cue = "/VO/Hades_0640" },
		-- Of all the things, you think that takes priority?
		{ Cue = "/VO/Hades_0641" },
		-- Would that your birthright gave you better sense.
		{ Cue = "/VO/Hades_0642", RequiredFalseTextLines = { "Ending01" }, },
		-- So wasteful of my realm's resources, boy.
		{ Cue = "/VO/Hades_0643", RequiredFalseTextLines = { "Ending01" }, },
		-- What are you prattling about now?
		{ Cue = "/VO/Hades_0644", RequiredFalseTextLines = { "Ending01" }, },
	},
}

GlobalVoiceLines.DraperyColorResponseVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.4,
		PlayOnce = true,

		-- How about a moody blue color of some sort for the drapery there.
		{ Cue = "/VO/ZagreusHome_1083", RequiredCosmetics = { "Cosmetic_DrapesBlue" } },
		-- Perhaps a rich green hue for the drapery will feel a little homelier?
		{ Cue = "/VO/ZagreusHome_1084", RequiredCosmetics = { "Cosmetic_DrapesGreen" } },
		-- A crimson color for the drapery is sure to be a better fit for the decor.
		{ Cue = "/VO/ZagreusHome_1085", RequiredCosmetics = { "Cosmetic_DrapesRed" } },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,

		-- You know what, I changed my mind about the drapery.
		{ Cue = "/VO/ZagreusHome_1086" },
		-- I miss the way things used to be, dear Drapery.
		{ Cue = "/VO/ZagreusHome_1087" },
		-- The time has come once more to modify the drapery.
		{ Cue = "/VO/ZagreusHome_1088" },
		-- Helps keep things colorful to change the drapery from time to time.
		{ Cue = "/VO/ZagreusHome_1089" },
		-- Either those curtains go, or I do.
		{ Cue = "/VO/ZagreusHome_1090" },
	},
}
GlobalVoiceLines.HadesDraperyColorReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.65,
	ObjectType = "NPC_Hades_01",
	RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
	RequiredSourceValueFalse = "InPartnerConversation",
	SuccessiveChanceToPlay = 0.66,

	-- A garish hue.
	{ Cue = "/VO/Hades_0510", RequiredPlayed = { "/VO/Hades_0515" }, RequiredAnyCosmetics = { "Cosmetic_DrapesGreen", "Cosmetic_DrapesBlue" } },
	-- Indecisive as ever.
	{ Cue = "/VO/Hades_0511", RequiredPlayed = { "/VO/Hades_0515" }, RequiredFalseTextLines = { "Ending01" } },
	-- Make up your mind.
	{ Cue = "/VO/Hades_0512", RequiredPlayed = { "/VO/Hades_0515" } },
	-- Quit changing the blasted drapery.
	{ Cue = "/VO/Hades_0513", RequiredPlayed = { "/VO/Hades_0515" } },
	-- Would that you cared about more than the drapery.
	{ Cue = "/VO/Hades_0514", RequiredPlayed = { "/VO/Hades_0515" }, RequiredFalseTextLines = { "Ending01" } },
	-- The prior hue was fine.
	{ Cue = "/VO/Hades_0529", RequiredPlayed = { "/VO/Hades_0515" }, RequiredAnyCosmetics = { "Cosmetic_DrapesGreen", "Cosmetic_DrapesBlue" } },
	-- It was perfectly acceptable before.
	{ Cue = "/VO/Hades_0515" },
}

GlobalVoiceLines.TrimColorResponseVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.4,
		PlayOnce = true,

		-- Back there, let's change the color theming up a little bit.
		{ Cue = "/VO/ZagreusHome_1744", RequiredCosmetics = { "Cosmetic_SouthHallTrimPurple" } },
		-- This color ought to suit the hall back there.
		{ Cue = "/VO/ZagreusHome_1745", RequiredCosmetics = { "Cosmetic_SouthHallTrimGrey" } },
		-- This is the color suited for our hall back there.
		{ Cue = "/VO/ZagreusHome_1747", RequiredCosmetics = { "Cosmetic_SouthHallTrimRed" } },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.4,

		-- We should redecorate the hall back there like so.
		{ Cue = "/VO/ZagreusHome_1746" },
		-- Let's try this color on for size instead.
		{ Cue = "/VO/ZagreusHome_1748", },
		-- I'd like to see it in this color once again.
		{ Cue = "/VO/ZagreusHome_1749" },
		-- This color seemed to suit the hall quite well.
		{ Cue = "/VO/ZagreusHome_1750" },
		-- Let's change the colors up back there again.
		{ Cue = "/VO/ZagreusHome_1751",  },
	},
}
GlobalVoiceLines.HadesTrimColorReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.65,
	ObjectType = "NPC_Hades_01",
	RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
	RequiredSourceValueFalse = "InPartnerConversation",
	SuccessiveChanceToPlay = 0.66,

	-- A garish hue.
	{ Cue = "/VO/Hades_0510", RequiredPlayed = { "/VO/Hades_0515" } },
	-- Indecisive as ever.
	{ Cue = "/VO/Hades_0511", RequiredPlayed = { "/VO/Hades_0515" }, RequiredFalseTextLines = { "Ending01" } },
	-- Make up your mind.
	{ Cue = "/VO/Hades_0512", RequiredPlayed = { "/VO/Hades_0515" } },
	-- The prior hue was fine.
	{ Cue = "/VO/Hades_0529", RequiredPlayed = { "/VO/Hades_0515" } },
	-- It was perfectly acceptable before.
	{ Cue = "/VO/Hades_0515" },
}

GlobalVoiceLines.RugPurchaseResponseVoiceLines =
{
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			PlayOnce = true,
			PlayOnceContext = "RugPurchase",

			-- A fine hallway requires a fine rug, I always say! I say it sometimes...
			{ Cue = "/VO/ZagreusHome_1710", RequiredCosmetics = { "Cosmetic_NorthHallRug" } },
			-- Oh we absolutely need to get this rug, right over there.
			{ Cue = "/VO/ZagreusHome_1711", RequiredCosmetics = { "Cosmetic_NorthHallRugA" } },
			-- By my decree, this House is not a house without this rug.
			{ Cue = "/VO/ZagreusHome_1712", RequiredCosmetics = { "Cosmetic_NorthHallRugB" } },
			-- If there's a finer rug to set back there, I'll likely end up getting it as well.
			{ Cue = "/VO/ZagreusHome_1713", RequiredCosmetics = { "Cosmetic_NorthHallRugC" } },
			-- Should make my bedchambers a little more presentable I guess.
			{ Cue = "/VO/ZagreusHome_1773", RequiredCosmetics = { "Cosmetic_BedroomRug" } },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.4,

			-- What time is it? That's right: Rug-switching time!
			{ Cue = "/VO/ZagreusHome_1714" },
			-- Hrm I don't know let's try a different rug.
			{ Cue = "/VO/ZagreusHome_1715" },
			-- Let's try a different rug there, if you please.
			{ Cue = "/VO/ZagreusHome_1716" },
			-- I've had a change of heart about that rug if you don't mind.
			{ Cue = "/VO/ZagreusHome_1717" },
			-- I think we both know that it's time to change the rug.
			{ Cue = "/VO/ZagreusHome_1718" },
			-- Think this rug's really going to tie the whole room together.
			{ Cue = "/VO/ZagreusHome_1784" },
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		ObjectType = "NPC_Hades_01",
		RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
		RequiredSourceValueFalse = "InPartnerConversation",
		SuccessiveChanceToPlay = 0.66,

		-- You could make better use of your limitless time.
		{ Cue = "/VO/Hades_0648" },
		-- Would that your sense of taste exceeded rugs.
		{ Cue = "/VO/Hades_0649", RequiredFalseTextLines = { "Ending01" }, },
		-- The poets doubtless shall be singing of your rug.
		{ Cue = "/VO/Hades_0650" },
		-- What have you done to my floor surfaces?
		{ Cue = "/VO/Hades_0651" },
		-- It ties nothing of the sort.
		{ Cue = "/VO/Hades_0691", RequiredLastLinePlayed = { "/VO/ZagreusHome_1784" } },
		-- Are you quite finished alternating rugs?
		{ Cue = "/VO/Hades_0652", RequiredAnyCosmetics = { "Cosmetic_NorthHallRug", "Cosmetic_NorthHallRugA", "Cosmetic_NorthHallRugB", "Cosmetic_NorthHallRugC", "Cosmetic_LoungeRug", "Cosmetic_LoungeRugA", "Cosmetic_LoungeRugB", "Cosmetic_LoungeRugC", "CosmeticAchillesRug" } },
		-- Meddling with rugs again are we?
		{ Cue = "/VO/Hades_0653", RequiredAnyCosmetics = { "Cosmetic_NorthHallRug", "Cosmetic_NorthHallRugA", "Cosmetic_NorthHallRugB", "Cosmetic_NorthHallRugC", "Cosmetic_LoungeRug", "Cosmetic_LoungeRugA", "Cosmetic_LoungeRugB", "Cosmetic_LoungeRugC", "CosmeticAchillesRug" } },
		-- Oh leave the blasted rugs alone for once.
		{ Cue = "/VO/Hades_0654", RequiredAnyCosmetics = { "Cosmetic_NorthHallRug", "Cosmetic_NorthHallRugA", "Cosmetic_NorthHallRugB", "Cosmetic_NorthHallRugC", "Cosmetic_LoungeRug", "Cosmetic_LoungeRugA", "Cosmetic_LoungeRugB", "Cosmetic_LoungeRugC", "CosmeticAchillesRug" } },
	}
}

GlobalVoiceLines.LoungeRugSpecificPurchaseResponseVoiceLines =
{
	-- The lounge could use a decent rug I think.
	{ Cue = "/VO/ZagreusHome_1777", RequiredAnyCosmetics = { "Cosmetic_LoungeRug", "Cosmetic_LoungeRugA", "Cosmetic_LoungeRugB", "Cosmetic_LoungeRugC" }, Cooldowns = { { Name = "SaidThinkRecently", Time = 40 }, }, },
	-- This stately rug should match the lounge decor.
	{ Cue = "/VO/ZagreusHome_1778", RequiredAnyCosmetics = { "Cosmetic_LoungeRug", "Cosmetic_LoungeRugA", "Cosmetic_LoungeRugB", "Cosmetic_LoungeRugC" }, },
	-- The lounge's regulars might like this rug I guess.
	{ Cue = "/VO/ZagreusHome_1779", RequiredAnyCosmetics = { "Cosmetic_LoungeRug", "Cosmetic_LoungeRugA", "Cosmetic_LoungeRugB", "Cosmetic_LoungeRugC" }, },
	-- A serviceable rug for a serviceable lounge.
	{ Cue = "/VO/ZagreusHome_1780", RequiredAnyCosmetics = { "Cosmetic_LoungeRug", "Cosmetic_LoungeRugA", "Cosmetic_LoungeRugB", "Cosmetic_LoungeRugC" }, },
}

GlobalVoiceLines.LoungeRugPurchaseResponseVoiceLines = DeepCopyTable( GlobalVoiceLines.RugPurchaseResponseVoiceLines )
ConcatTableValues( GlobalVoiceLines.LoungeRugPurchaseResponseVoiceLines[1][1], GlobalVoiceLines.LoungeRugSpecificPurchaseResponseVoiceLines )

GlobalVoiceLines.MusicPurchaseResponseVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.6,
		ObjectType = "NPC_Orpheus_01",
		SuccessiveChanceToPlay = 0.5,

		-- The famous artistry of Daedalus...
		{ Cue = "/VO/Orpheus_0157" },
		-- My music stand...
		{ Cue = "/VO/Orpheus_0158" },
		-- By the Fates...
		{ Cue = "/VO/Orpheus_0159" },
		-- The gift of song...
		{ Cue = "/VO/Orpheus_0160" },
		-- A song returns to me...
		{ Cue = "/VO/Orpheus_0161" },
		-- My memory of music stirs...
		{ Cue = "/VO/Orpheus_0162" },
		-- Has inspiration struck?
		{ Cue = "/VO/Orpheus_0163" },
		-- By my muse...
		{ Cue = "/VO/Orpheus_0164" },
		-- Another song...
		{ Cue = "/VO/Orpheus_0165" },
		-- A song...
		{ Cue = "/VO/Orpheus_0166" },
		-- Another memory...
		{ Cue = "/VO/Orpheus_0167" },
		-- I remember...
		{ Cue = "/VO/Orpheus_0168" },
		-- How splendid.
		{ Cue = "/VO/Orpheus_0169" },
		-- A fine selection.
		{ Cue = "/VO/Orpheus_0170" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.4,

		-- Should check the music stand to hear this one.
		{ Cue = "/VO/ZagreusHome_1100" },
		-- Another piece for the music stand.
		{ Cue = "/VO/ZagreusHome_1101" },
		-- More music for the music stand is always good.
		{ Cue = "/VO/ZagreusHome_1102" },
		-- Can hardly wait to listen to this one.
		{ Cue = "/VO/ZagreusHome_1103" },
		-- More substantive material for the music stand.
		{ Cue = "/VO/ZagreusHome_1104" },
		-- More music to soothe the senses.
		{ Cue = "/VO/ZagreusHome_1105" },
		-- Not going to say no to more music.
		{ Cue = "/VO/ZagreusHome_1106" },
		-- New music for the music stand? OK!
		{ Cue = "/VO/ZagreusHome_1107" },
		-- Think I'm going to enjoy listening to this piece.
		{ Cue = "/VO/ZagreusHome_3682" },
		-- Think I'm going to enjoy listening to this piece, potentially over and over.
		{ Cue = "/VO/ZagreusHome_3683" },
		-- Always room for some new music in my life.
		{ Cue = "/VO/ZagreusHome_3684" },
		-- Diamonds for a piece of music seems like a fair exchange!
		{ Cue = "/VO/ZagreusHome_3685" },
		-- Time to load up the old music stand.
		{ Cue = "/VO/ZagreusHome_3686" },
		-- Excited to give this one a listen.
		{ Cue = "/VO/ZagreusHome_3687" },
	}
}

-- Badge Seller / Badge System
GlobalVoiceLines.UpgradedBadgeVoiceLines = 
{
	-- rank-up lines
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,

		-- I believe I'm eligible for the rank of Warden, Resources Director?
		{ Cue = "/VO/ZagreusHome_3615", RequiredValues = { BadgeRank = 1 } },
		-- Make me a Fixer, Resources Director, I'm ready.
		{ Cue = "/VO/ZagreusHome_3616", RequiredValues = { BadgeRank = 6 } },
		-- All right, Resources Director, I'm ready to be an Agent.
		{ Cue = "/VO/ZagreusHome_3617", RequiredValues = { BadgeRank = 11 } },
		-- Need a new Cleaner, Resources Director? Because I'm ready.
		{ Cue = "/VO/ZagreusHome_3618", RequiredValues = { BadgeRank = 16 } },
		-- To the realm, Resources Director! Thus I become a Shadow.
		{ Cue = "/VO/ZagreusHome_3619", RequiredValues = { BadgeRank = 21 } },
		-- With this donation, I accept the honorable rank of Dusk.
		{ Cue = "/VO/ZagreusHome_3620", RequiredValues = { BadgeRank = 26 } },
		-- Resources Director, it's my humble privilege to achieve the rank of Wraith.
		{ Cue = "/VO/ZagreusHome_3621", RequiredValues = { BadgeRank = 31 } },
		-- I scarce believe it but I'm eligible now to become Overseer.
		{ Cue = "/VO/ZagreusHome_3622", RequiredValues = { BadgeRank = 36 } },
		-- This is for the realm, Resources Director. Thus I become a Specter.
		{ Cue = "/VO/ZagreusHome_3623", RequiredValues = { BadgeRank = 41 } },
		-- The rarest rank achievable is mine... the rank of One.
		{ Cue = "/VO/ZagreusHome_3624", RequiredValues = { BadgeRank = 46 } },
		-- Somehow I've done it... the final rank... Unseen One... like Father.
		{ Cue = "/VO/ZagreusHome_3625", RequiredValues = { BadgeRank = 50 } },
	},
	-- tier-up lines
	{
		RandomRemaining = true,
		PreLineWait = 0.35,

		-- Director, I believe I'm eligible for the next tier.
		{ Cue = "/VO/ZagreusHome_3626" },
		-- Badge me, Resources Director.
		{ Cue = "/VO/ZagreusHome_3627" },
		-- For the realm!
		{ Cue = "/VO/ZagreusHome_3628" },
		-- Here, you like resources, right?
		{ Cue = "/VO/ZagreusHome_3629" },
		-- Next tier, my good shade!
		{ Cue = "/VO/ZagreusHome_3630" },
		-- Next tier, if you please!
		{ Cue = "/VO/ZagreusHome_3631" },
		-- I do believe I'm eligible now.
		{ Cue = "/VO/ZagreusHome_3632" },
		-- Here you go, Director!
		{ Cue = "/VO/ZagreusHome_3633" },
		-- My badge is due for an upgrade I think!
		{ Cue = "/VO/ZagreusHome_3634" },
		-- Spruce up my badge, please!
		{ Cue = "/VO/ZagreusHome_3635" },
		-- Here, in the name of Hades.
		{ Cue = "/VO/ZagreusHome_3636" },
		-- Got a donation here.
		{ Cue = "/VO/ZagreusHome_3637" },
		-- Ready to badge me, Director?
		{ Cue = "/VO/ZagreusHome_3638" },
		-- My badge, please, Resources Director?
		{ Cue = "/VO/ZagreusHome_3639" },
		-- Due for another upgrade here!
		{ Cue = "/VO/ZagreusHome_3640" },
	}
}

GlobalVoiceLines.CannotAffordBadgeVoiceLines = 
{
	RandomRemaining = true,
	PreLineWait = 0.45,
	Cooldowns =
	{
		{ Name = "ZagCannotAffordBadgeSpeech", Time = 12 },
	},

	-- Not qualified yet, huh.
	{ Cue = "/VO/ZagreusHome_3641" },
	-- I'm not there yet.
	{ Cue = "/VO/ZagreusHome_3642" },
	-- In due time, I guess.
	{ Cue = "/VO/ZagreusHome_3643" },
	-- No rush, I'll get there.
	{ Cue = "/VO/ZagreusHome_3644" },
	-- I need how much...?
	{ Cue = "/VO/ZagreusHome_3645" },
	-- Oof, that's steep.
	{ Cue = "/VO/ZagreusHome_3646" },
	-- I'll have to come back.
	{ Cue = "/VO/ZagreusHome_3647" },
	-- You drive a hard bargain, Resources Director.
	{ Cue = "/VO/ZagreusHome_3648" },
	-- Can't you give me a better deal?
	{ Cue = "/VO/ZagreusHome_3649" },
	-- What if I ask really nicely, Resources Director?
	{ Cue = "/VO/ZagreusHome_3650" },
}

-- Skelly
GlobalVoiceLines.SkellyClosedShrineReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.85,
	ObjectType = "TrainingMelee",
	Cooldowns =
	{
		{ Name = "SkellyClosedShrineSpeech", Time = 60 },
	},

	-- Forget something, or what?
	{ Cue = "/VO/Skelly_0278", },
	-- What's the matter there boyo?
	{ Cue = "/VO/Skelly_0279", },
	-- Said our goodbyes already pal.
	{ Cue = "/VO/Skelly_0280", },
	-- What you need more practice, pal?
	{ Cue = "/VO/Skelly_0281", },
	-- Just go, pal. You can do it.
	{ Cue = "/VO/Skelly_0282", },
	-- Go on, boyo, get out of here.
	{ Cue = "/VO/Skelly_0283", },
	-- Don't stick around on my account, boyo.
	{ Cue = "/VO/Skelly_0284", },
	-- Need another fancy weapon there or what?
	{ Cue = "/VO/Skelly_0285", },
	-- What do you need there pal?
	{ Cue = "/VO/Skelly_0286", },
	-- Not ready yet or something?
	{ Cue = "/VO/Skelly_0287", },
}

GlobalVoiceLines.SkellySummonExitReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	ThreadName = "RoomThread",
	RequiredTrait = "SkellyAssistTrait",
	PreLineWait = 0.1,
	ObjectType = "TrainingMeleeSummon",

	-- Well see you.
	{ Cue = "/VO/Skelly_0448", CooldownName = "SaidSeeYouRecently", CooldownTime = 40 },
	-- I'll just hang out a while.
	{ Cue = "/VO/Skelly_0449", },
	-- So long pal!
	{ Cue = "/VO/Skelly_0450", },
	-- Bye boyo.
	{ Cue = "/VO/Skelly_0451", },
	-- Glad to be of service!
	{ Cue = "/VO/Skelly_0452", },
}

GlobalVoiceLines.MiscWeaponEquipVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.33,
		Cooldowns =
		{
			{ Name = "ZagreusMiscWeaponEquipSpeech", Time = 40 },
		},
		-- Think I'll try this one.
		{ Cue = "/VO/ZagreusField_0156" },
		-- Let's go with this one.
		{ Cue = "/VO/ZagreusField_0358" },
		-- Maybe this one.
		{ Cue = "/VO/ZagreusField_0359" },
		-- Care to join me out there?
		{ Cue = "/VO/ZagreusHome_1282" },
		-- Care to accompany me?
		{ Cue = "/VO/ZagreusHome_1283" },
		-- I'll gain more Darkness with this.
		{ Cue = "/VO/ZagreusField_1158", RequiredOneOfTraits = { "UnusedWeaponBonusTrait", "UnusedWeaponBonusTraitAddGems" }, },
		-- Should help me gain more Darkness.
		{ Cue = "/VO/ZagreusField_1159", RequiredOneOfTraits = { "UnusedWeaponBonusTrait", "UnusedWeaponBonusTraitAddGems" }, },
	},
	-- Chaos Shield Responses
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		NoTarget = true,
		SuccessiveChanceToPlay = 0.33,
		RequiredTextLines = { "ChaosAboutWeaponEnchantments01", "ChaosGift01" },
		RequiredTrait = "ShieldRushBonusProjectileTrait",
		RequiredWeapon = "ShieldWeapon",
		Source = { SubtitleColor = Color.ChaosVoice },
		Cooldowns =
		{
			{ Name = "ChaosShieldSpeech", Time = 120 },
		},

		-- Very well.
		{ Cue = "/VO/Chaos_0112",  },
		-- I give you power.
		{ Cue = "/VO/Chaos_0223",  },
		-- I see.
		{ Cue = "/VO/Chaos_0273",  },
		-- Greetings.
		{ Cue = "/VO/Chaos_0274",  },
		-- Ah, at last.
		{ Cue = "/VO/Chaos_0275",  },
		-- Hmm.
		{ Cue = "/VO/Chaos_0276",  },
	}
}

-- Skelly
GlobalVoiceLines.SkellyWeaponEquipReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.6,
	SuccessiveChanceToPlay = 0.25,
	ObjectType = "TrainingMelee",
	RequiredFalseScreenOpen = "WeaponUpgradeScreen",
	Cooldowns =
	{
		{ Name = "SkellyQuipAnySpeech", Time = 35 },
	},

	-- Change of plan there huh?
	{ Cue = "/VO/Skelly_0073", },
	-- Yeah that one's pretty nice.
	{ Cue = "/VO/Skelly_0074", },
	-- Ooh change of plan I like it!
	{ Cue = "/VO/Skelly_0075", },
	-- This ought to be good.
	{ Cue = "/VO/Skelly_0076", },
	-- Want to try that thing out?
	{ Cue = "/VO/Skelly_0077", },
	-- You using that thing now huh?
	{ Cue = "/VO/Skelly_0078", },
	-- Hey that looks pretty mean.
	{ Cue = "/VO/Skelly_0079", },
	-- Ooh would you look at that.
	{ Cue = "/VO/Skelly_0080", },
	-- Rolling with that thing, eh?
	{ Cue = "/VO/Skelly_0288" },
	-- Care for a warm-up with that?
	{ Cue = "/VO/Skelly_0289" },
	-- That would've been my pick.
	{ Cue = "/VO/Skelly_0290" },
	-- Bet you couldn't hit me with that, pal.
	{ Cue = "/VO/Skelly_0291" },
	-- That one huh...
	{ Cue = "/VO/Skelly_0292" },
	-- Time to give that thing some work I guess.
	{ Cue = "/VO/Skelly_0293" },
	-- You be careful with that one boyo.
	{ Cue = "/VO/Skelly_0294" },
	-- Pretty mean knife you got there.
	{ Cue = "/VO/Skelly_0081", RequiredWeapon = "SwordWeapon" },
	-- Pretty scary serving platter there.
	{ Cue = "/VO/Skelly_0082", RequiredWeapon = "ShieldWeapon" },
	-- That some kind of fishing pole or what?
	{ Cue = "/VO/Skelly_0083", RequiredWeapon = "SpearWeapon" },
	-- Scared to get up close and personal, boyo?
	{ Cue = "/VO/Skelly_0084", RequiredWeapon = "BowWeapon" },
	-- What, you going to sock it to me, pal?
	{ Cue = "/VO/Skelly_0460", RequiredWeapon = "FistWeapon" },
	-- You like those mittens huh?
	{ Cue = "/VO/Skelly_0461", RequiredWeapon = "FistWeapon" },
	-- Yeah, give me your best shot!
	{ Cue = "/VO/Skelly_0462", RequiredWeapon = "FistWeapon" },
	-- Yeah, put up your dukes!
	{ Cue = "/VO/Skelly_0463", RequiredWeapon = "FistWeapon" },
	-- Sock it to me, boyo!
	{ Cue = "/VO/Skelly_0464", RequiredWeapon = "FistWeapon" },
	-- Keep your finger on the trigger at all times, pal.
	{ Cue = "/VO/Skelly_0244", RequiredWeapon = "GunWeapon" },
	-- Nothing to it, pal, just point and shoot.
	{ Cue = "/VO/Skelly_0245", RequiredWeapon = "GunWeapon" },
	-- Know how to use that thing?
	{ Cue = "/VO/Skelly_0246", RequiredWeapon = "GunWeapon", PlayOnce = true },
	-- You got a license for that thing?
	{ Cue = "/VO/Skelly_0247", RequiredWeapon = "GunWeapon", PlayOnce = true },
	-- I got your chopping block right here, pal.
	{ Cue = "/VO/Skelly_0295", RequiredWeapon = "SwordWeapon" },
	-- Up for some slicing huh.
	{ Cue = "/VO/Skelly_0296", RequiredWeapon = "SwordWeapon" },
	-- Stick it to me, boyo, come on!
	{ Cue = "/VO/Skelly_0297", RequiredWeapon = "SpearWeapon" },
	-- Just watch the ribs with that, OK?
	{ Cue = "/VO/Skelly_0298", RequiredWeapon = "SpearWeapon" },
	-- Go on and clock me with that if you want.
	{ Cue = "/VO/Skelly_0299", RequiredWeapon = "ShieldWeapon" },
	-- I still don't get what that's supposed to be.
	{ Cue = "/VO/Skelly_0300", RequiredWeapon = "ShieldWeapon", RequiredPlayed = { "/VO/Skelly_0082" } },
	-- Give me one of them arrows right in the eye!
	{ Cue = "/VO/Skelly_0301", RequiredWeapon = "BowWeapon" },
	-- Couple of practice shots or something?
	{ Cue = "/VO/Skelly_0302", RequiredAnyWeapon = { "BowWeapon", "GunWeapon" }, },
	-- Go on, boyo, shoot me, let's see you do it!
	{ Cue = "/VO/Skelly_0303", RequiredAnyWeapon = { "BowWeapon", "GunWeapon" }, },
	-- How about you give me your best shot!
	{ Cue = "/VO/Skelly_0304", RequiredAnyWeapon = { "BowWeapon", "GunWeapon" }, },
	-- Bet you can't hit me repeatedly from there.
	{ Cue = "/VO/Skelly_0305", RequiredWeapon = "BowWeapon" },
}

GlobalVoiceLines.SkellySummonTauntVoiceLines =
{
	{
		RandomRemaining = true,
		PostLineWait = 10.5,
		ThreadName = "RoomThread",
		RequiredTrait = "SkellyAssistTrait",
		RequiresInRun = true,
		RequiredKillEnemiesFound = true,
		RequiredFalseEncounters = { "BossHarpy1", "BossHarpy2", "BossHarpy3", "BossHydra", "BossHades" },
		ObjectType = "TrainingMeleeSummon",

		-- I'll hold them off, boyo, you do your thing!
		{ Cue = "/VO/Skelly_0339", RequiredMinKillEnemies = 2 },
		-- Forget about me, boyo! Save yourself!
		{ Cue = "/VO/Skelly_0340", RequiredMinKillEnemies = 3 },
		-- Oh I got your back, there, pal!
		{ Cue = "/VO/Skelly_0341" },
		-- Come on, bozo, pick on someone your own size!
		{ Cue = "/VO/Skelly_0322" },
		-- Waaaaaaaa I'm an important target!!
		{ Cue = "/VO/Skelly_0326" },
		-- Whoever kills me gets a big promotion!
		{ Cue = "/VO/Skelly_0327", RequiredMinKillEnemies = 2 },
		-- Hah what a bunch of bozos!!
		{ Cue = "/VO/Skelly_0332", RequiredMinKillEnemies = 2 },
		-- Look at all these guys, come on!
		{ Cue = "/VO/Skelly_0333", RequiredMinKillEnemies = 3 },
		-- Heeey bozo, let's see what you got!
		{ Cue = "/VO/Skelly_0334" },
		-- You bozos look like you could use some practice!
		{ Cue = "/VO/Skelly_0337", RequiredMinKillEnemies = 2 },
		-- You mess with my pal, you mess with me!
		{ Cue = "/VO/Skelly_0338" },
		-- Your mama presses olive oil!
		{ Cue = "/VO/Skelly_0394" },
		-- Hey pick on somebody my size!
		{ Cue = "/VO/Skelly_0395" },
		-- Think you can break these bones?
		{ Cue = "/VO/Skelly_0396" },
		-- Nyah-nyah come get me!
		{ Cue = "/VO/Skelly_0397" },
		-- Nyah, come get me and all that!
		{ Cue = "/VO/Skelly_0398" },
		-- Hope I don't die and drop this precious loot!
		{ Cue = "/VO/Skelly_0399" },
		-- You don't have what it takes!!
		{ Cue = "/VO/Skelly_0400" },
		-- Hey, may I have your attention for a sec?
		{ Cue = "/VO/Skelly_0401" },
		-- Don't mean to interrupt!!
		{ Cue = "/VO/Skelly_0402" },
		-- Come on, you bozos, do it!
		{ Cue = "/VO/Skelly_0403", RequiredMinKillEnemies = 2 },
		-- I'm here, kill me, you bozos!
		{ Cue = "/VO/Skelly_0404", RequiredMinKillEnemies = 2 },
		-- Come on, kill me, you goofs!
		{ Cue = "/VO/Skelly_0405", RequiredMinKillEnemies = 2 },
		-- Come on! Get me already!
		{ Cue = "/VO/Skelly_0406" },
		-- Come on, kill me!
		{ Cue = "/VO/Skelly_0407" },
		-- Come on, kill me, I'm here!!
		{ Cue = "/VO/Skelly_0408" },
		-- Kill me, I'm here!
		{ Cue = "/VO/Skelly_0409" },
		-- Come on, do it, kill me!!
		{ Cue = "/VO/Skelly_0410" },
		-- What's the matter, scared?!
		{ Cue = "/VO/Skelly_0411" },
		-- You want a piece of me you guys?!
		{ Cue = "/VO/Skelly_0412", RequiredMinKillEnemies = 2 },
		-- Come on, you bozos, let's see what you got!
		{ Cue = "/VO/Skelly_0413", RequiredMinKillEnemies = 2 },
		-- Hey bozos, over here!
		{ Cue = "/VO/Skelly_0414", RequiredMinKillEnemies = 2 },
		-- Got some real fancy bozos over here!
		{ Cue = "/VO/Skelly_0415", RequiredMinKillEnemies = 2 },
		-- These guys don't look so tough!
		{ Cue = "/VO/Skelly_0416", RequiredMinKillEnemies = 2 },
		-- Oh I can take a hit!!
		{ Cue = "/VO/Skelly_0417" },
		-- Come give me your best shot!!
		{ Cue = "/VO/Skelly_0418" },
		-- You won't take me alive!!
		{ Cue = "/VO/Skelly_0419" },
		-- You beat me, I'll just keep coming back!
		{ Cue = "/VO/Skelly_0574" },
		-- Go on and sock it to me, here!
		{ Cue = "/VO/Skelly_0575" },
		-- Can't even kill an unarmed skeleton!
		{ Cue = "/VO/Skelly_0576" },
		-- How about a stationary target for a change?
		{ Cue = "/VO/Skelly_0577" },
		-- Want me to move, make me!
		{ Cue = "/VO/Skelly_0578" },
		-- Come give me your best shot!
		{ Cue = "/VO/Skelly_0579" },
		-- Oh, help me, boyo, I'm so scared!
		{ Cue = "/VO/Skelly_0580" },
		-- Ahahaha, please!
		{ Cue = "/VO/Skelly_0581" },
		-- Woo, hoohoohoohoo!
		{ Cue = "/VO/Skelly_0582" },
		-- You know who you're dealing with?
		{ Cue = "/VO/Skelly_0583" },
	},
}

-- Reactive Gossip
GossipSubtitlesMinDistance = 1200
GlobalVoiceLines.MegaeraGossipVoiceLines =
{
	PostLineWait = 0.35,
	RandomRemaining = true,
	ObjectType = "NPC_FurySister_01",
	RequiredTrueFlags = { "MegDusaGossipLegal" },
	SubtitleMinDistance = GossipSubtitlesMinDistance,
	Actor = "GossipOcclusionM",
	RequiredFalseScreenOpen = "Dialog",
	PostLineWait = 1,

	-- Really...?
	{ Cue = "/VO/MegaeraHome_0294" },
	-- Really.
	{ Cue = "/VO/MegaeraHome_0295" },
	-- Oh, really...
	{ Cue = "/VO/MegaeraHome_0296" },
	-- That is absurd.
	{ Cue = "/VO/MegaeraHome_0297" },
	-- You can't be serious.
	{ Cue = "/VO/MegaeraHome_0298" },
	-- You're serious right now?
	{ Cue = "/VO/MegaeraHome_0299" },
	-- What an idiot.
	{ Cue = "/VO/MegaeraHome_0300" },
	-- What a fool.
	{ Cue = "/VO/MegaeraHome_0301" },
	-- Go on.
	{ Cue = "/VO/MegaeraHome_0302" },
	-- And...?
	{ Cue = "/VO/MegaeraHome_0303" },
	-- No...
	{ Cue = "/VO/MegaeraHome_0304" },
	-- No...!
	{ Cue = "/VO/MegaeraHome_0305" },
	-- You're serious.
	{ Cue = "/VO/MegaeraHome_0306" },
	-- He said that?
	{ Cue = "/VO/MegaeraHome_0307" },
	-- He said what?
	{ Cue = "/VO/MegaeraHome_0308" },
	-- You did?
	{ Cue = "/VO/MegaeraHome_0309" },
	-- Unbelievable.
	{ Cue = "/VO/MegaeraHome_0310" },
	-- You don't want to know what I think.
	{ Cue = "/VO/MegaeraHome_0311" },
	-- Oh, blood and darkness.
	{ Cue = "/VO/MegaeraHome_0312" },
	-- That's what I thought.
	{ Cue = "/VO/MegaeraHome_0313" },
	-- That's what I thought!
	{ Cue = "/VO/MegaeraHome_0314" },
	-- I know!
	{ Cue = "/VO/MegaeraHome_0315" },
	-- Ugh, seriously.
	{ Cue = "/VO/MegaeraHome_0316" },
	-- Yes, well...
	{ Cue = "/VO/MegaeraHome_0317" },
	-- What can you do...
	{ Cue = "/VO/MegaeraHome_0318" },
	-- Oh that's too bad.
	{ Cue = "/VO/MegaeraHome_0319" },
	-- Tsk, oh...
	{ Cue = "/VO/MegaeraHome_0320" },
	-- That's unfortunate.
	{ Cue = "/VO/MegaeraHome_0321" },
	-- Wow.
	{ Cue = "/VO/MegaeraHome_0322" },
	-- What?
	{ Cue = "/VO/MegaeraHome_0323" },
	-- What?!
	{ Cue = "/VO/MegaeraHome_0324" },
	-- <Scoff>
	{ Cue = "/VO/MegaeraHome_0325" },
	-- You did?
	{ Cue = "/VO/MegaeraHome_0326" },
	-- You really said that?
	{ Cue = "/VO/MegaeraHome_0327" },
	-- Oh I don't know.
	{ Cue = "/VO/MegaeraHome_0328" },
	-- I mean, I guess.
	{ Cue = "/VO/MegaeraHome_0329" },
	-- I know, I know.
	{ Cue = "/VO/MegaeraHome_0330" },
	-- Look, I...
	{ Cue = "/VO/MegaeraHome_0331" },
	-- It's totally all right.
	{ Cue = "/VO/MegaeraHome_0332" },
	-- I understand, it's fine.
	{ Cue = "/VO/MegaeraHome_0333" },
}

GlobalVoiceLines.DusaGossipBridgeVoiceLines =
{
	RandomRemaining = true,
	ObjectType = "NPC_Dusa_01",
	RequiredTrueFlags = { "MegDusaGossipLegal" },
	SubtitleMinDistance = GossipSubtitlesMinDistance,
	Actor = "GossipOcclusionD",
	RequiredFalseScreenOpen = "Dialog",
	PostLineWait = 1,

	-- So, then I say...
	{ Cue = "/VO/Dusa_0365" },
	-- And, then I said...
	{ Cue = "/VO/Dusa_0366" },
	-- But you know what else?
	{ Cue = "/VO/Dusa_0367" },
	-- Oh that's not all.
	{ Cue = "/VO/Dusa_0368" },
	-- Oh there's more.
	{ Cue = "/VO/Dusa_0369" },
	-- There's more.
	{ Cue = "/VO/Dusa_0370" },
	-- There's more, though.
	{ Cue = "/VO/Dusa_0371" },
	-- Oh but get this.
	{ Cue = "/VO/Dusa_0372" },
	-- But get this.
	{ Cue = "/VO/Dusa_0373" },
	-- Get this.
	{ Cue = "/VO/Dusa_0374" },
	-- It gets worse!
	{ Cue = "/VO/Dusa_0375" },
	-- You know what I heard?
	{ Cue = "/VO/Dusa_0376" },
	-- What I heard is...
	{ Cue = "/VO/Dusa_0377" },
	-- Know what?
	{ Cue = "/VO/Dusa_0378" },
	-- You know what else?
	{ Cue = "/VO/Dusa_0379" },
	-- Listen to this.
	{ Cue = "/VO/Dusa_0380" },
}
GlobalVoiceLines.DusaGossipWhisperVoiceLines =
{
	PostLineWait = 0.35,
	RandomRemaining = true,
	ObjectType = "NPC_Dusa_01",
	RequiredTrueFlags = { "MegDusaGossipLegal" },
	SubtitleMinDistance = GossipSubtitlesMinDistance,
	Actor = "GossipOcclusionD",
	RequiredFalseScreenOpen = "Dialog",
	PostLineWait = 1,

	--[[
	-- <whisper>
	{ Cue = "/VO/Dusa_0455" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0456" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0457" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0458" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0459" },
	]]--

	-- <whisper>
	{ Cue = "/VO/Dusa_0398" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0399" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0399ALT" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0400" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0401" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0402" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0403" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0404" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0405" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0406" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0407" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0408" },
	-- <whisper>
	{ Cue = "/VO/Dusa_0409" },
}
GlobalVoiceLines.DusaGossipReactionVoiceLines =
{
	RandomRemaining = true,
	ObjectType = "NPC_Dusa_01",
	RequiredTrueFlags = { "MegDusaGossipLegal" },
	SubtitleMinDistance = GossipSubtitlesMinDistance,
	Actor = "GossipOcclusionD",
	RequiredFalseScreenOpen = "Dialog",
	PostLineWait = 1,

	-- I know, right?
	{ Cue = "/VO/Dusa_0381" },
	-- Right?
	{ Cue = "/VO/Dusa_0382" },
	-- Right!
	{ Cue = "/VO/Dusa_0383" },
	-- I know!!
	{ Cue = "/VO/Dusa_0384" },
	-- I know.
	{ Cue = "/VO/Dusa_0385" },
	-- Seriously.
	{ Cue = "/VO/Dusa_0386" },
	-- Seriously!
	{ Cue = "/VO/Dusa_0387" },
	-- You better believe it!
	{ Cue = "/VO/Dusa_0388" },
	-- Uh huh.
	{ Cue = "/VO/Dusa_0389" },
	-- Can you imagine?
	{ Cue = "/VO/Dusa_0390" },
	-- Can you believe it?
	{ Cue = "/VO/Dusa_0391" },
	-- I swear.
	{ Cue = "/VO/Dusa_0392" },
	-- No kidding.
	{ Cue = "/VO/Dusa_0393" },
	-- Yep.
	{ Cue = "/VO/Dusa_0394" },
	-- Really.
	{ Cue = "/VO/Dusa_0395" },
	-- Really!
	{ Cue = "/VO/Dusa_0396" },
	-- For sure.
	{ Cue = "/VO/Dusa_0397" },
}
GlobalVoiceLines.DusaGossipConclusionVoiceLines =
{
	PostLineWait = 0.35,
	RandomRemaining = true,
	ObjectType = "NPC_Dusa_01",
	RequiredTrueFlags = { "MegDusaGossipLegal" },
	SubtitleMinDistance = GossipSubtitlesMinDistance,
	Actor = "GossipOcclusionD",
	RequiredFalseScreenOpen = "Dialog",
	PostLineWait = 1,

	-- Anyway...
	{ Cue = "/VO/Dusa_0412" },
	-- <Sigh> Anyway...
	{ Cue = "/VO/Dusa_0413" },
	-- Anyhow...
	{ Cue = "/VO/Dusa_0414" },
	-- ...Tell you later.
	{ Cue = "/VO/Dusa_0415" },
	-- ...You know how it goes.
	{ Cue = "/VO/Dusa_0416" },
	-- ...You can guess the rest.
	{ Cue = "/VO/Dusa_0417" },
	-- Hello!
	{ Cue = "/VO/Dusa_0418" },
	-- Well, you know...
	{ Cue = "/VO/Dusa_0419" },
	-- Eh, what can you do.
	{ Cue = "/VO/Dusa_0420" },
	-- You get the gist.
	{ Cue = "/VO/Dusa_0421" },
	-- ...Told you.
	{ Cue = "/VO/Dusa_0422" },
	-- See?
	{ Cue = "/VO/Dusa_0423" },
	-- What'd I tell you?
	{ Cue = "/VO/Dusa_0424" },
}

GlobalVoiceLines.SurvivalEncounterStartVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.85,
		NoTarget = true,
		RequiredFalseBiome = "Styx",

		-- You truly are an idiot, aren't you.
		{ Cue = "/VO/Intercom_0057", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Don't make me laugh.
		{ Cue = "/VO/Intercom_0060", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Do not so much as think about it.
		{ Cue = "/VO/Intercom_0041", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- I do not think so, boy.
		{ Cue = "/VO/Intercom_0043", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Who dares?
		{ Cue = "/VO/Intercom_0096", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- You dare?
		{ Cue = "/VO/Intercom_0097", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Thief!
		{ Cue = "/VO/Intercom_0098", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Interloper!
		{ Cue = "/VO/Intercom_0099" },
		-- You shall pay for that!
		{ Cue = "/VO/Intercom_0100", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- You shall regret this.
		{ Cue = "/VO/Intercom_0101", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredFalseTextLines = { "Ending01" }, },
		-- That is private property.
		{ Cue = "/VO/Intercom_0102", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- We have an intruder.
		{ Cue = "/VO/Intercom_0103" },
		-- Trespasser!
		{ Cue = "/VO/Intercom_0104" },
		-- Transgressions are not tolerated.
		{ Cue = "/VO/Intercom_0105", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Consider this a warning.
		{ Cue = "/VO/Intercom_0106", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- We have a pest problem.
		{ Cue = "/VO/Intercom_0107" },
		-- Death is inescapable.
		{ Cue = "/VO/Intercom_0226", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- You cannot escape.
		{ Cue = "/VO/Intercom_0227", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- That is far enough.
		{ Cue = "/VO/Intercom_0228", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Wretches of the Underworld, this is your chance.
		{ Cue = "/VO/Intercom_0229", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel" } },
		-- Come forth, wretches, and stop this meddler.
		{ Cue = "/VO/Intercom_0230", RequiredFalseBiome = "Elysium" },
		-- Do not presume that you escape my notice, boy.
		{ Cue = "/VO/Intercom_0231", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- You really think you can get out of here?
		{ Cue = "/VO/Intercom_0232", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Let's see if you can live through this.
		{ Cue = "/VO/Intercom_0233", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Nobody gets out of here, whether alive or dead.
		{ Cue = "/VO/Intercom_0234", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- You're out well past your curfew, boy.
		{ Cue = "/VO/Intercom_0235", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredFalseTextLines = { "Ending01" }, },
		-- I've tolerated your impudence for long enough.
		{ Cue = "/VO/Intercom_0236", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredFalseTextLines = { "Ending01" }, },
		-- I see you there.
		{ Cue = "/VO/Intercom_0237", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- You think you can just walk away from here?
		{ Cue = "/VO/Intercom_0238", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- If I could have a minute of your time...
		{ Cue = "/VO/Intercom_0239", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Let's see your relatives upon Olympus get you out of this.
		{ Cue = "/VO/Intercom_0240", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Allow me, boy, to introduce some of my loyal subjects.
		{ Cue = "/VO/Intercom_0241", RequiredAnyTextLines = { "HadesGift01", "HadesGift01_B" }, },
		-- You're not going anywhere.
		{ Cue = "/VO/Intercom_0242", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Champions of Elysium, now prove yourselves!
		{ Cue = "/VO/Intercom_0463", RequiredBiome = "Elysium" },
		-- Come, heroes of Elysium, and vanquish the intruder!
		{ Cue = "/VO/Intercom_0464", RequiredBiome = "Elysium" },
		-- Why you...
		{ Cue = "/VO/Intercom_0551", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- That does not belong to you.
		{ Cue = "/VO/Intercom_0552", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Again with your tampering?
		{ Cue = "/VO/Intercom_0553", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0552" } },
		-- That was ill-advised.
		{ Cue = "/VO/Intercom_0554", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- What, again?
		{ Cue = "/VO/Intercom_0555", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0552" } },
		-- My coffers are not yours for pillaging.
		{ Cue = "/VO/Intercom_0556", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- You thief.
		{ Cue = "/VO/Intercom_0557", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Security!
		{ Cue = "/VO/Intercom_0558" },
		-- Halt.
		{ Cue = "/VO/Intercom_0567", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Seal the chamber.
		{ Cue = "/VO/Intercom_0568", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- There you are.
		{ Cue = "/VO/Intercom_0569", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- He's there. Get him.
		{ Cue = "/VO/Intercom_0570", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- What's your rush, there, boy?
		{ Cue = "/VO/Intercom_0571", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- My subjects wish to have a word with you.
		{ Cue = "/VO/Intercom_0572", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- No need to be in such a hurry, boy.
		{ Cue = "/VO/Intercom_0573", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- I thought I'd find you here.
		{ Cue = "/VO/Intercom_0574", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- All right, wretches, get to work!
		{ Cue = "/VO/Intercom_1110" },
		-- Stop him, wretches!
		{ Cue = "/VO/Intercom_1111" },
		-- Stop him, wretches, now!
		{ Cue = "/VO/Intercom_1112" },
		-- You leave my troves alone!
		{ Cue = "/VO/Intercom_1113", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Those troves are not for you!
		{ Cue = "/VO/Intercom_1114", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Get your hands off my trove!
		{ Cue = "/VO/Intercom_1115", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- Wretches, take him, now!
		{ Cue = "/VO/Intercom_1116" },
		-- Remain exactly where you are.
		{ Cue = "/VO/Intercom_1117" },
		-- I'll give these wretches not a minute more.
		{ Cue = "/VO/Intercom_1118", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" } },
		-- How foolhardy of you.
		{ Cue = "/VO/Intercom_1119" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.2,
		RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" },
		RequiredFalseBiome = "Styx",
		UsePlayerSource = true,

		-- You lot, huh?
		{ Cue = "/VO/ZagreusField_0215", PreLineWait = 4.9, },
		-- Come and get it.
		{ Cue = "/VO/ZagreusField_0217" },
		-- Let's make this quick.
		{ Cue = "/VO/ZagreusField_0218" },
		-- No time to lose.
		{ Cue = "/VO/ZagreusField_0219" },
	}
}

GlobalVoiceLines.SurvivalEncounterSurvivedVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.35,
		NoTarget = true,
		RequiredFalseBiome = "Styx",

		-- Enough!
		{ Cue = "/VO/Intercom_0243" },
		-- Worthless wretches.
		{ Cue = "/VO/Intercom_0244", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Pah, useless.
		{ Cue = "/VO/Intercom_0245", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Blood and darkness.
		{ Cue = "/VO/Intercom_0246", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- They had their chance.
		{ Cue = "/VO/Intercom_0247", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- I shall deal with you later, then.
		{ Cue = "/VO/Intercom_0248", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- You lived through all of that?
		{ Cue = "/VO/Intercom_0249", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Who is going to clean all of this up?
		{ Cue = "/VO/Intercom_0250", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Idiots!
		{ Cue = "/VO/Intercom_0251", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Worthless!
		{ Cue = "/VO/Intercom_0252", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Useless!
		{ Cue = "/VO/Intercom_0253", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Damnable fools.
		{ Cue = "/VO/Intercom_0254", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- It seems I need to look for better help.
		{ Cue = "/VO/Intercom_0255", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Back to the lowest depths with them.
		{ Cue = "/VO/Intercom_0256", RequiredFalseBiome = "Elysium", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Enough, I've better things to do.
		{ Cue = "/VO/Intercom_0257", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Kkh, you waste my time.
		{ Cue = "/VO/Intercom_0258", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- All right, break it up!
		{ Cue = "/VO/Intercom_0419", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- That's all the time we have.
		{ Cue = "/VO/Intercom_0420", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Bah, that's enough!
		{ Cue = "/VO/Intercom_0421", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Decidedly below my expectations.
		{ Cue = "/VO/Intercom_0422", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Work faster next time!
		{ Cue = "/VO/Intercom_0423", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- No more of this buffoonery!
		{ Cue = "/VO/Intercom_0424", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- I expected more from the Exalted.
		{ Cue = "/VO/Intercom_0465", RequiredBiome = "Elysium", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Disappointing for these so-called Champions.
		{ Cue = "/VO/Intercom_0466", RequiredBiome = "Elysium", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Why do I pay these wretches.
		{ Cue = "/VO/Intercom_0559", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- That's quite enough.
		{ Cue = "/VO/Intercom_0560", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Fine, help yourself.
		{ Cue = "/VO/Intercom_0561", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, CooldownName = "SaidHelpRecently", CooldownTime = 30, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- You did not earn this, boy.
		{ Cue = "/VO/Intercom_0562", RequiredFalseEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Nrgh, how many times...
		{ Cue = "/VO/Intercom_0563", RequiredMinCompletedRuns = 12, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- There. Satisfied?
		{ Cue = "/VO/Intercom_0564", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Ugh, why do I bother.
		{ Cue = "/VO/Intercom_0565", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- I should not be the supervisor here.
		{ Cue = "/VO/Intercom_0566", RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Fine, get out.
		{ Cue = "/VO/Intercom_0575", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Again you make a mockery of me.
		{ Cue = "/VO/Intercom_0576", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- I've no more time for this.
		{ Cue = "/VO/Intercom_0577", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Out, all of you!
		{ Cue = "/VO/Intercom_0578", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Utterly incompetent.
		{ Cue = "/VO/Intercom_0579", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- I ought have left them all in Erebus.
		{ Cue = "/VO/Intercom_0580", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- I trust they inconvenienced you at least.
		{ Cue = "/VO/Intercom_0581", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Why do I even bother.
		{ Cue = "/VO/Intercom_0582", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Every time!
		{ Cue = "/VO/Intercom_1120", RequiredPlayed = { "/VO/Intercom_0243" }, RequiredMinCompletedRuns = 15 },
		-- Incompetents.
		{ Cue = "/VO/Intercom_1121", RequiredPlayed = { "/VO/Intercom_0243" }, PlayOnce = true, },
		-- Pah. Fine, go!
		{ Cue = "/VO/Intercom_1122", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" } },
		-- Fine, go, then!
		{ Cue = "/VO/Intercom_1123", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" }, RequiredTextLines = { "Ending01" }, },
		-- Time's up!
		{ Cue = "/VO/Intercom_1124", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" }, RequiredTextLines = { "Ending01" }, },
		-- All right, all right!
		{ Cue = "/VO/Intercom_1125", RequiredEncounters = { "SurvivalTartarus", "SurvivalAsphodel", "SurvivalElysium" }, RequiredPlayed = { "/VO/Intercom_0243" }, RequiredTextLines = { "Ending01" }, },
	},
	{
		RandomRemaining = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.66,
		UsePlayerSource = true,
		RequiredBiome = "Styx",

		-- Yes.
		{ Cue = "/VO/ZagreusField_1126" },
		-- Yes...!
		{ Cue = "/VO/ZagreusField_1127" },
		-- Simple.
		{ Cue = "/VO/ZagreusField_1128", RequiredMinHealthFraction = 0.6 },
		-- Easy.
		{ Cue = "/VO/ZagreusField_1129", RequiredMinHealthFraction = 0.6 },
		-- No problem.
		{ Cue = "/VO/ZagreusField_1130" },
		-- No problem!
		{ Cue = "/VO/ZagreusField_1131" },
		-- There we go.
		{ Cue = "/VO/ZagreusField_1132", },
		-- How's that?
		{ Cue = "/VO/ZagreusField_1133" },
		-- How's that!
		{ Cue = "/VO/ZagreusField_1134" },
		-- There.
		{ Cue = "/VO/ZagreusField_1135" },
		-- What do I get?
		{ Cue = "/VO/ZagreusField_1136" },
		-- Short work.
		{ Cue = "/VO/ZagreusField_1137" },
		-- Whew.
		{ Cue = "/VO/ZagreusField_1138", RequiredMaxHealthFraction = 0.4, CooldownName = "SaidWhewRecently", CooldownTime = 30 },
	}
}

GlobalVoiceLines.CharonSurprisedVoiceLines =
{
	Queue = "Interrupt",
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		ObjectType = "NPC_Charon_01",
		PreLineWait = 0.1,
		Cooldowns =
		{
			{ Name = "CharonSurprisedSpeech", Time = 10 },
		},

		-- Hoh?
		{ Cue = "/VO/Charon_0052" },
		-- Hrn?
		{ Cue = "/VO/Charon_0053" },
		-- Hehh?
		{ Cue = "/VO/Charon_0054" },
		-- Hraugh!
		{ Cue = "/VO/Charon_0055" },
		-- Nrraugh?!
		{ Cue = "/VO/Charon_0068" },
		-- Hrrngh?!
		{ Cue = "/VO/Charon_0069" },
		-- Haaah?!
		{ Cue = "/VO/Charon_0070" },
		-- Rraah!!
		{ Cue = "/VO/Charon_0071" },
		-- Hrrnn!!
		{ Cue = "/VO/Charon_0072" },
	},
}

-- ending
GlobalVoiceLines.SunriseOverlookVoiceLines =
{
	BreakIfPlayed = true,
	PreLineWait = 2.8,
	UsePlayerSource = true,
	PlayOnce = true,
	RequiredTrueFlags = { "Overlook" },

	-- Wha, that thing, that's... the sun...
	{ Cue = "/VO/ZagreusField_3592", PlayOnce = true, PreLineWait = 5.6 },
	-- So... bright... ugh...
	{ Cue = "/VO/ZagreusField_3595", RequiredPlayed = { "/VO/ZagreusField_3592" }, PreLineWait = 6.0 },
	-- It's... I...
	{ Cue = "/VO/ZagreusField_4695", RequiredPlayed = { "/VO/ZagreusField_3592" }, PreLineWait = 6.0 },
	-- So much water... Uncle Poseidon's realm
	{ Cue = "/VO/ZagreusField_3593", RequiredPlayed = { "/VO/ZagreusField_3592" }, },
	-- Mother isn't far...
	{ Cue = "/VO/ZagreusField_3594", RequiredPlayed = { "/VO/ZagreusField_3592" }, },
	-- Huh... to see this each day...
	{ Cue = "/VO/ZagreusField_4694", RequiredPlayed = { "/VO/ZagreusField_3592" }, },
	-- ...Beautiful...
	{ Cue = "/VO/ZagreusField_4696", RequiredPlayed = { "/VO/ZagreusField_3592" }, PreLineWait = 6.2 },
	-- ...The Sun... 
	{ Cue = "/VO/ZagreusField_4697", RequiredPlayed = { "/VO/ZagreusField_3592" }, PreLineWait = 6.0 },
	-- ...The Sun... Helios...
	{ Cue = "/VO/ZagreusField_4698", RequiredPlayed = { "/VO/ZagreusField_4697" }, PreLineWait = 6.0, RequiredTextLines = { "DemeterAboutHelios01" } },
}