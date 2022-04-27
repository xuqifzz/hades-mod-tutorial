ObjectiveData =
{
	-- most of this is auto-populated from WeaponData
	EXMove = { Description = "Objective_EXMove" },
	SuperMove = { Description = "Objective_SuperMove"},
	BuildSuper = { Description = "Objective_BuildMeter"},
	Mythmaker = { Description = "Objective_Mythmaker"},
	KillRequiredEnemies = { Description = "Objective_KillRequiredEnemies"},
	PickUpLoot = { Description = "Objective_PickUpLoot"},
	GiftPrompt = { Description = "Objective_GiveGift" },
	FishPrompt = { Description = "Objective_SellFish" },
	MetaPrompt = { Description = "Objective_MetaSpend" },
	ShopPrompt = { Description = "Objective_ShopSpend" },
	BedPrompt = { Description = "Objective_UseBed" },
	EasyModePrompt = { Description = "Objective_UseGodMode" },
	UnlockWeapon = { Description = "Objective_UnlockWeapon" },
	UnlockMetaUpgrade = { Description = "Objective_UnlockMetaUpgrade" },
	GiftRackPrompt = { Description = "Objective_UseGiftRack" },
	AdvancedTooltipPrompt = { Description = "Objective_AdvancedTooltip" },
	AchillesBedroomPrompt = { Description = "Objective_EnterBedroomHades" },
	AspectsRevealPrompt = { Description = "Objective_OpenWeaponUpgradeScreen" },

	Fishing = { Description = "Objective_Fishing" },

	TimeChallenge = { Description = "Objective_TimeChallenge" },
	TimeChallengeValue = { Description = "ChallengeSwitch_Value", LuaKey = "RemainingSeconds", StartingLuaValue = "-" },
	TimeChallengeReward = { Description = "Objective_TimeChallengeReward" },

	ThanatosKills = { Description = "Objective_ThanatosKills", LuaKey = "ThanatosKills", StartingLuaValue = "0" },
	PlayerKills = { Description = "Objective_PlayerKills", LuaKey = "PlayerKills", StartingLuaValue = "0" },

	SurvivalChallenge = { Description = "Objective_SurvivalTimer", LuaKey = "RemainingSeconds", StartingLuaValue = "-" },

	PerfectClear = { Description = "Objective_PerfectClear" },
	PerfectClearCleanup = { Description = "Objective_PerfectClearCleanup" },
	SpearThrowRegularRetrieve = { Description = "Objective_SpearWeaponThrowTeleport_StandardRecall" },
	SpearWeaponThrowTeleport = { Description = "Objective_SpearWeaponThrowTeleport" },
	SpearWeaponThrowSingle = { Description = "Objective_SpearWeaponThrowSingle"},
	SpearWeaponSpinRanged = { Description = "Objective_SpearWeaponSpinRanged" },
	ShieldGrind = { Description = "Objective_ShieldGrind" },
	ShieldRushAndThrow = { Description = "Objective_ShieldRushAndThrow" },
	ManualReload = { Description = "Objective_ManualReload" },
	GunEmpower = {Description = "Objective_GunEmpower"},
	ModifiedRush = { Description = "Objective_ModifiedRush"},
	ModifiedRanged = { Description = "Objective_ModifiedRanged"},
	PerfectCharge = { Description = "Objective_PerfectCharge"},
	GunWeaponActiveReload = { Description = "Objective_GunWeaponActiveReload"},
	GunWeaponManualReload = { Description = "Objective_GunWeaponManualReload"},
	FistWeaponFistWeave = { Description = "Objective_FistWeaponFistWeave"},
	FistSpecialVacuum = { Description = "Objective_FistSpecialVacuum"},

	FistWeaponGilgamesh = { Description = "Objective_GilgameshAttack" },
	RushWeaponGilgamesh = { Description = "Objective_GilgameshDash" },

	BeowulfAttack = { Description = "Objective_BeowulfAttack"},
	BeowulfSpecial = { Description = "Objective_BeowulfSpecial"},
	BeowulfTackle = { Description = "Objective_BeowulfTackle"},

	SwordWeaponArthur = { Description = "Objective_SwordAttackArthur"},
	ConsecrationField = { Description = "Objective_ConsecrationField"},

	GunGrenadeLucifer = { Description = "Objective_GunGrenadeLucifer"},
	GunGrenadeLuciferBlast = { Description = "Objective_GunGrenadeLuciferBlast"},
}

ObjectiveSetData =
{
	-- turning these off temporarily
	--[[
	BasicTutorial =
	{
		RequiredRoom = "RoomOpening",
		RequiredMainWeapon = "SwordWeapon",
		Objectives =
		{
			{"SwordWeapon"},
			{"RushWeapon"},
			{"RangedWeapon"},
		},
		StartDelay = 3,
	},

	RoomStructureTutorial =
	{
		RequiredRoom = "RoomSimple01",
		RequiredEncounters = {"EnemyIntroFight01"},
		Objectives =
		{
			{"KillRequiredEnemies"},
			{"PickUpLoot"},
		},
		StartDelay = 30,
	},


	MythmakerTutorial =
	{
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredEncounters = { "FirstMythPoint" },
		RequiredRoom = "RoomSimple03",
		Objectives =
		{
			{"Mythmaker"}
		},
	},

	LimitTutorial =
	{
		--RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredEncounters = { "MeterIntroduction" },
		RequiredRoom = "RoomSimple03",
		Objectives =
		{
			{"BuildSuper", "EXMove", "SuperMove"}
		},
	},

	ModifierTutorial =
	{
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredEncounters = { "ModifierIntroduction" },
		RequiredRoom = "RoomSimple03",
		Objectives =
		{
			{"ModifiedRush", "ModifiedRanged"}
		},
	},
	]]--

	SwordTutorial =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "SwordWeapon",
		RequiredFalseTraits = { "SwordConsecrationTrait" },
		Objectives =
		{
			{"SwordWeapon", "SwordParry", "SwordWeaponDash"}
		},
	},

	SwordTutorial_Arthur =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "SwordWeapon",
		RequiredTrait = "SwordConsecrationTrait",
		Objectives =
		{
			{"SwordWeaponArthur", "ConsecrationField", "SwordWeaponDash"}
		},
	},

	ShieldTutorial =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "ShieldWeapon",
		RequiredFalseTraits = { "ShieldTwoShieldTrait", "ShieldRushBonusProjectileTrait", "ShieldLoadAmmoTrait" },
		Objectives =
		{
			{"ShieldWeapon", "ShieldWeaponRush", "ShieldThrow", "ShieldWeaponDash"}
		},
	},

	ShieldTutorial_Grind =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "ShieldWeapon",
		RequiredTrait = "ShieldTwoShieldTrait",
		Objectives =
		{
			{"ShieldWeapon", "ShieldWeaponRush", "ShieldGrind", "ShieldWeaponDash"}
		},
	},
	
	ShieldTutorial_BonusProjectile =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "ShieldWeapon",
		RequiredTrait = "ShieldRushBonusProjectileTrait",
		Objectives =
		{
			{"ShieldWeapon", "ShieldWeaponRush", "ShieldRushAndThrow", "ShieldWeaponDash" }
		},
	},

	ShieldTutorial_Beowulf =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "ShieldWeapon",
		RequiredTrait = "ShieldLoadAmmoTrait",
		Objectives =
		{
			{"BeowulfAttack", "ShieldWeaponRush", "BeowulfTackle", "BeowulfSpecial", "ShieldWeaponDash"}
		},
	},

	SpearTutorial =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "SpearWeapon",
		RequiredFalseTraits = { "SpearTeleportTrait", "SpearSpinTravel" },
		Objectives =
		{
			{"SpearWeapon", "SpearWeaponSpin", "SpearWeaponThrow", "SpearWeaponDash"}
		},
	},

	SpearTutorial_Teleport =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "SpearWeapon",
		RequiredTrait = "SpearTeleportTrait",
		Objectives =
		{
			{"SpearWeapon", "SpearWeaponSpin", "SpearWeaponThrowTeleport", "SpearThrowRegularRetrieve", "SpearWeaponDash" }
		},
	},

	SpearTutorial_SpinTravel = 
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "SpearWeapon",
		RequiredTrait = "SpearSpinTravel",
		Objectives =
		{
			{"SpearWeapon", "SpearWeaponSpinRanged", "SpearWeaponThrowSingle", "SpearWeaponDash" }
		},	
	},

	BowTutorial =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "BowWeapon",
		RequiredFalseTraits = { "BowLoadAmmoTrait" },
		Objectives =
		{
			{"BowWeapon", "BowSplitShot", "PerfectCharge", "BowWeaponDash"}
		},
	},

	BowTutorialLoad = 
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "BowWeapon",
		RequiredTrait = "BowLoadAmmoTrait",
		Objectives =
		{
			{"BowWeapon", "BowSplitShot", "PerfectCharge", "LoadAmmoApplicator", "BowWeaponDash" }
		},
	
	},

	GunTutorial =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "GunWeapon",
		RequiredFalseTraits = { "GunGrenadeSelfEmpowerTrait", "GunManualReloadTrait", "GunLoadedGrenadeTrait" },
		Objectives =
		{
			{"GunWeapon", "GunWeaponManualReload", "GunGrenadeToss", "GunWeaponDash" }
		},
	},

	GunTutorial_ManualReload =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "GunWeapon",
		RequiredTrait = "GunManualReloadTrait",
		Objectives =
		{
			{"GunWeapon", "ManualReload", "GunGrenadeToss", "GunWeaponDash" }
		},
	},

	GunTutorial_SelfEmpower =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "GunWeapon",
		RequiredTrait = "GunGrenadeSelfEmpowerTrait",
		Objectives =
		{
			{"GunWeapon", "GunWeaponManualReload", "GunGrenadeToss", "GunEmpower", "GunWeaponDash" }
		},
	},

	GunTutorial_Lucifer =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "GunWeapon",
		RequiredTrait = "GunLoadedGrenadeTrait",
		Objectives =
		{
			{"GunWeapon", "GunWeaponManualReload", "GunGrenadeLucifer", "GunGrenadeLuciferBlast" }
		},
	},

	FistTutorial =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "FistWeapon",
		RequiredFalseTraits = { "FistWeaveTrait", "FistVacuumTrait", "FistDetonateTrait" },
		Objectives =
		{
			{ "FistWeapon", "FistWeaponSpecial", "FistWeaponDash", "FistWeaponSpecialDash" }
		},
	},

	FistTutorial_FistWeave =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "FistWeapon",
		RequiredTrait = "FistWeaveTrait",
		Objectives =
		{
			{ "FistWeapon", "FistWeaponSpecial", "FistWeaponDash", "FistWeaponSpecialDash", "FistWeaponFistWeave" }
		},
	},

	FistTutorial_Vacuum =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "FistWeapon",
		RequiredTrait = "FistVacuumTrait",
		Objectives =
		{
			{ "FistWeapon", "FistSpecialVacuum", "FistWeaponDash", "FistWeaponSpecialDash" }
		},
	},

	FistTutorial_Gilgamesh =
	{
		AllowRepeat = true,
		OverrideExistingObjective = false,
		RequiredFalseObjectiveTriggers = { "RoomStart" },
		RequiredMainWeapon = "FistWeapon",
		RequiredTrait = "FistDetonateTrait",
		Objectives =
		{
			{ "FistWeaponGilgamesh", "FistWeaponSpecial", "RushWeaponGilgamesh", "FistWeaponDash", "FistDetonationWeapon" },
		},
	},

	TimeChallenge =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		Objectives =
		{
			{ "TimeChallenge" },
			{ "TimeChallengeReward" },
		},
	},

	SurvivalChallenge =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		Objectives =
		{
			{ "SurvivalChallenge" }
		},
	},

	PerfectClear =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		HoldUntilEncounterOver = true,
		Objectives =
		{
			{ "PerfectClear" },
		},
	},

	ThanatosChallenge =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{ "ThanatosKills", "PlayerKills" },
		},
	},

	Fishing =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		RequiredMaxTotalCaughtFish = 0,
		Objectives =
		{
			{ "Fishing" }
		},
	},

	GiftPrompt =
	{
		AllowRepeat = false,
		RequiredRoom = "DeathArea",
		RequiredResourcesMin = { GiftPoints = 1, },
		RequiredFalseFlags = { "InFlashback", },
		Objectives =
		{
			{ "GiftPrompt" }
		},
		StartDelay = 5.75,
	},

	FishPrompt =
	{
		AllowRepeat = false,
		RequiredRoom = "DeathArea",
		RequiredHasFish = true,
		RequiredFalseFlags = { "InFlashback", },
		Objectives =
		{
			{ "FishPrompt" }
		},
		StartDelay = 5.75,
	},

	AdvancedTooltipPrompt =
	{
		AllowRepeat = false,
		ManualActivationOnly = true,
		RequiredTraitCount = 3,
		Objectives =
		{
			{ "AdvancedTooltipPrompt" }
		},
	},

	MetaPrompt =
	{
		ManualActivationOnly = true,
		AllowRepeat = false,
		RequiredRoom = "DeathAreaBedroom",
		Objectives =
		{
			{ "MetaPrompt" }
		},
		StartDelay = 2.25,
	},

	BedPrompt =
	{
		ManualActivationOnly = true,
		AllowRepeat = true,
		RequiredTextLines = { "HadesFirstMeeting" },
		RequiredTrueFlags = { "AllowFlashback" },
		RequiredRoom = "DeathAreaBedroom",
		RequiredFalseTextLinesThisRun = { "Flashback_Mother_01", },
		Objectives =
		{
			{ "BedPrompt" }
		},
		StartDelay = 2.25,
	},

	EasyModePrompt =
	{
		AllowRepeat = true,
		ManualActivationOnly = true,
		Objectives =
		{
			{ "EasyModePrompt" }
		},
		StartDelay = 1.25,
	},

	--[[ShopPrompt =
	{
		AllowRepeat = false,
		RequiredRoom = "A_Shop01",
		Objectives =
		{
			{ "ShopPrompt" }
		},
		StartDelay = 3,
	},]]--

	AchillesBedroomPrompt =
	{
		AllowRepeat = false,
		ManualActivationOnly = true,
		OverrideExistingObjective = true,
		Objectives =
		{
			{ "AchillesBedroomPrompt" }
		},
		RequiredTextLines = { "PersephoneMeeting08", },
		RequiredFalseTextLines = { "AchillesAboutHadesBedroom01", "Ending01" },
	},

	AspectsRevealPrompt =
	{
		AllowRepeat = false,
		ManualActivationOnly = true,
		Objectives =
		{
			{ "AspectsRevealPrompt" }
		},
		RequiredTrueFlags = { "AspectsUnlocked" },
		RequiredScreenViewedFalse = "WeaponUpgradeScreen",
	},

	UnlockWeapon =
	{
		AllowRepeat = false,
		PriorityLevel = 1,
		RequiredRoom = "RoomPreRun",
		RequiredResourcesMin = { LockKeys = 1, },
		Objectives =
		{
			{ "UnlockWeapon" }
		},
	},

	GiftRackPrompt =
	{
		AllowRepeat = false,
		PriorityLevel = 2,
		OverrideExistingObjective = false,
		RequiredRoom = "RoomPreRun",
		RequireNewTraits = true,
		Objectives =
		{
			{ "GiftRackPrompt" }
		},
	},

	UnlockMetaUpgrade =
	{
		ManualActivationOnly = true,
		AllowRepeat = false,
		Objectives =
		{
			{ "UnlockMetaUpgrade" }
		},
	},
}

