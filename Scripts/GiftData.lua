GiftOrdering =
{
	-- row 1
	"MaxHealthKeepsakeTrait", -- cerberus
	"DirectionalArmorTrait", -- achilles
	"BackstabAlphaStrikeTrait", -- nyx
	"PerfectClearDamageBonusTrait", -- thanatos
	"ShopDurationTrait", -- charon
	"BonusMoneyTrait", -- hypnos
	"LowHealthDamageTrait", -- megaera
	"DistanceDamageTrait", -- orpheus
	"LifeOnUrnTrait", -- dusa
	"ReincarnationTrait", -- skelly

	-- row 2
	"ForceZeusBoonTrait", -- zeus
	"ForcePoseidonBoonTrait", -- poseidon
	"ForceAthenaBoonTrait", -- athena
	"ForceAphroditeBoonTrait", -- aphrodite
	"ForceAresBoonTrait", -- ares
	"ForceArtemisBoonTrait", -- artemis
	"ForceDionysusBoonTrait", -- dionysus
	"FastClearDodgeBonusTrait", -- hermes
	"ForceDemeterBoonTrait", -- demeter
	"ChaosBoonTrait", -- primordial chaos

	-- row 3
	"VanillaTrait", -- sisyphus
	"ShieldBossTrait", -- eurydice
	"ShieldAfterHitTrait", -- patroclus
	"ChamberStackTrait", -- persephone
	"HadesShoutKeepsake", -- hades

	-- companions
	"FuryAssistTrait",
	"ThanatosAssistTrait",
	"SisyphusAssistTrait",
	"SkellyAssistTrait",
	"DusaAssistTrait",
	"AchillesPatroclusAssistTrait",
}

GiftOrderingReverseLookup =
{
	-- Programmatically filled in via RunData
}

GiftIconData = 
{
	GiftPoints = 
	{
		FilledWithGift = "FilledHeartWithGiftIcon",
		Filled = "FilledHeartIcon",
		Empty = "EmptyHeartIcon",
		EmptyWithGift = "EmptyHeartWithGiftIcon",
		Locked = "LockedHeartIcon",
		GiftText = "GiftUseText",
		Unavailable = "UnavailableHeartIcon",
		Mystery = "MysteryHeartIcon",
	},
	SuperGiftPoints = 
	{
		FilledWithGift = "FilledSuperHeartWithGiftIcon",
		Filled = "FilledSuperHeartIcon",
		Empty = "EmptySuperHeartIcon",
		EmptyWithGift = "EmptySuperHeartWithGiftIcon",
		Locked = "LockedSuperHeartIcon",
		GiftText = "SuperGiftUseText",
		Unavailable = "UnavailableHeartIcon",
		Mystery = "MysteryHeartIcon",
	},
}

AssistUpgradeData = 
{
	SkellyAssistTrait = 
	{
		Costs = { 1, 2, 3, 4, 5, },
	},
	FuryAssistTrait = 
	{
		Costs = { 1, 2, 3, 4, 5, },
	},
	ThanatosAssistTrait = 
	{
		Costs = { 1, 2, 3, 4, 5, },
	},
	SisyphusAssistTrait = 
	{
		Costs = { 1, 2, 3, 4, 5, },
	},
	DusaAssistTrait = 
	{
		Costs = { 1, 2, 3, 4, 5, },
	},
	AchillesPatroclusAssistTrait =
	{
		Costs = { 1, 2, 3, 4, 5, },
	},	
}

GiftData =
{

	DefaultGiftData =
	{
		Value = 0,
		Locked = 5,
		Maximum = 8,
	},

	DefaultGodGiftData =
	{
		Value = 0,
		Locked = 5,
		Maximum = 7,
	},

	NPC_Achilles_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Achilles_Max",
		MaxedSticker = "Keepsake_AchillesSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "AchillesGift09_A" }, },
		Locked = 7,
		Maximum = 9,
		[1] = { Gift = "DirectionalArmorTrait" },
		[7] = { Gift = "AchillesPatroclusAssistTrait", RequiredResource = "SuperGiftPoints" },
		[8] = { RequiredResource = "SuperGiftPoints" },
		[9] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "MyrmidonReunionQuestComplete" } }
	},

	NPC_Orpheus_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Orpheus_Max",
		MaxedSticker = "Keepsake_OrpheusSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "OrpheusGift08" }, },
		Locked = 7,
		[1] = { Gift = "DistanceDamageTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		[8] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "OrpheusAboutSingersReunionQuest01" } }
	},

	NPC_Eurydice_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Eurydice_Max",
		MaxedSticker = "Keepsake_EurydiceSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "EurydiceGift08" }, },
		Locked = 7,
		[1] = { Gift = "ShieldBossTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		[8] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "EurydiceAboutSingersReunionQuestComplete01" } }
	},

	NPC_Patroclus_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Patroclus_Max",
		MaxedSticker = "Keepsake_PatroclusSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "PatroclusGift08_A" }, },
		Locked = 7,
		[1] = { Gift = "ShieldAfterHitTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		[8] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "PatroclusWithAchilles01" } }
	},

	NPC_Hades_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Hades_Max",
		MaxedSticker = "Keepsake_HadesSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "HadesGift05" }, },
		Locked = 2,
		Maximum = 5,
		[2] = { Gift = "HadesShoutKeepsake" },
		UnlockGameStateRequirements = { RequiredTextLines = { "HadesPostEnding02" } },
	},

	NPC_Persephone_Home_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Persephone_Max",
		MaxedSticker = "Keepsake_PersephoneSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "PersephoneGift09" }, },
		Locked = 7,
		Maximum = 9,
		[1] = { Gift = "ChamberStackTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		[8] = { RequiredResource = "SuperGiftPoints" },
		[9] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "PersephoneAboutNyx02" } }
	},

	NPC_Nyx_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Nyx_Max",
		MaxedSticker = "Keepsake_NyxSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "NyxGift09" }, },
		Locked = 7,
		Maximum = 9,
		[1] = { Gift = "BackstabAlphaStrikeTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		[8] = { RequiredResource = "SuperGiftPoints" },
		[9] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "NyxChaosReunionQuestComplete" } }
	},

	NPC_Hypnos_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Hypnos_Max",
		MaxedSticker = "Keepsake_HypnosSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "HypnosGift08" }, },
		Locked = 7,
		Maximum = 8,
		[1] = { Gift = "BonusMoneyTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		[8] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "HypnosAboutThanatos04" } }
	},

	NPC_FurySister_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Meg_Max",
		MaxedSticker = "Keepsake_MegSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "MegaeraGift10" }, },
		Locked = 7,
		Maximum = 10,
		[1] = { Gift = "LowHealthDamageTrait" },
		[7] = { Gift = "FuryAssistTrait", RequiredResource = "SuperGiftPoints", HeartDividerAfter = true },
		[8] = { RequiredResource = "SuperGiftPoints" },
		[9] = { RequiredResource = "SuperGiftPoints" },
		[10] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredAnyTextLines = { "MegaeraBedroom02", "MegaeraBedroom02B" } }
	},

	NPC_Thanatos_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Thanatos_Max",
		MaxedSticker = "Keepsake_ThanatosSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "ThanatosGift10" }, },
		Locked = 7,
		Maximum = 10,
		[1] = { Gift = "PerfectClearDamageBonusTrait" },
		[7] = { Gift = "ThanatosAssistTrait", RequiredResource = "SuperGiftPoints", HeartDividerAfter = true },
		[8] = { RequiredResource = "SuperGiftPoints" },
		[9] = { RequiredResource = "SuperGiftPoints" },
		[10] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "ThanatosFieldBuildingTrust01" } }
	},

	NPC_Dusa_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Dusa_Max",
		MaxedSticker = "Keepsake_DusaSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "BecameCloseWithDusa01" }, },
		Locked = 7,
		Maximum = 10,
		[1] = { Gift = "LifeOnUrnTrait" },
		[7] = { Gift = "DusaAssistTrait", RequiredResource = "SuperGiftPoints", HeartDividerAfter = true },
		[8] = { RequiredResource = "SuperGiftPoints", RequiredResourceAmount = 2 },
		[9] = { RequiredResource = "SuperGiftPoints", RequiredResourceAmount = 3 },
		[10] = { RequiredResource = "SuperGiftPoints", RequiredResourceAmount = 4 },
		UnlockGameStateRequirements = { RequiredTextLines = { "DusaLoungeRenovationQuestComplete" } }
	},

	NPC_Skelly_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Skelly_Max",
		MaxedSticker = "Keepsake_SkellySticker_Max",
		MaxedRequirement = { RequiredTextLines = { "SkellyGift09" }, },
		Locked = 7,
		Maximum = 9,
		[1] = { Gift = "ReincarnationTrait" }, 
		[7] = { Gift = "SkellyAssistTrait", RequiredResource = "SuperGiftPoints" },
		[8] = { RequiredResource = "SuperGiftPoints" },
		[9] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "SkellyTrueDeathQuestComplete" } }
	},

	NPC_Sisyphus_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Sisyphus_Max",
		MaxedSticker = "Keepsake_SisyphusSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "SisyphusGift09_A" }, },
		Locked = 7,
		Maximum = 9,
		[1] = { Gift = "VanillaTrait" },
		[7] = { Gift = "SisyphusAssistTrait", RequiredResource = "SuperGiftPoints" },
		[8] = { RequiredResource = "SuperGiftPoints" },
		[9] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "SisyphusLiberationQuestComplete" } }
	},

	NPC_Bouldy_01 = 
	{
		InheritFrom = {"DefaultGiftData"},	
		Locked = 11,
		InfiniteGifts = true,
	},
	NPC_Charon_01 =
	{
		InheritFrom = {"DefaultGiftData"},
		MaxedIcon = "Keepsake_Charon_Max",
		MaxedSticker = "Keepsake_CharonSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "CharonGift07" }, },
		Locked = 7,
		Maximum = 7,
		[1] = { Gift = "ShopDurationTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "CharonAboutCustomerLoyalty01" } }
	},

	NPC_Cerberus_01 =
	{
		InheritFrom = {"DefaultGiftData"},	
		MaxedIcon = "Keepsake_Cerberus_Max",
		MaxedSticker = "Keepsake_CerberusSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "CerberusGift09" }, },
		Locked = 7,
		Maximum = 9,
		[1] = { Gift = "MaxHealthKeepsakeTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		[8] = { RequiredResource = "SuperGiftPoints" },
		[9] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "CerberusAboutBeingBestBoy01" } },
		TrackUnlockedBlockInput = true,
	},

	ZeusUpgrade =
	{
		InheritFrom = {"DefaultGodGiftData"},
		MaxedIcon = "Keepsake_Zeus_Max",
		MaxedSticker = "Keepsake_ZeusSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "ZeusGift07" }, },
		Locked = 7,
		Maximum = 7,
		[1] = { Gift = "ForceZeusBoonTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "ZeusAboutRumors01" } }
	},

	PoseidonUpgrade =
	{
		InheritFrom = {"DefaultGodGiftData"},
		MaxedIcon = "Keepsake_Poseidon_Max",
		MaxedSticker = "Keepsake_PoseidonSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "PoseidonGift07" }, },
		Locked = 7,
		Maximum = 7,
		[1] = { Gift = "ForcePoseidonBoonTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "PoseidonAboutFishing03" } }
	},

	AthenaUpgrade =
	{
		InheritFrom = {"DefaultGodGiftData"},
		MaxedIcon = "Keepsake_Athena_Max",
		MaxedSticker = "Keepsake_AthenaSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "AthenaGift07" }, },
		Locked = 7,
		Maximum = 7,
		[1] = { Gift = "ForceAthenaBoonTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "AthenaRunCleared03" } }
	},

	AresUpgrade =
	{
		InheritFrom = {"DefaultGodGiftData"},
		MaxedIcon = "Keepsake_Ares_Max",
		MaxedSticker = "Keepsake_AresSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "AresGift07" }, },
		Locked = 7,
		Maximum = 7,
		[1] = { Gift = "ForceAresBoonTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "AresKillQuestAftermath01" } }
	},

	DionysusUpgrade =
	{
		InheritFrom = {"DefaultGodGiftData"},
		MaxedIcon = "Keepsake_Dionysus_Max",
		MaxedSticker = "Keepsake_DionysusSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "DionysusGift07" }, },
		Locked = 7,
		Maximum = 7,
		[1] = { Gift = "ForceDionysusBoonTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "DionysusAboutAmbrosia03" } }
	},

	AphroditeUpgrade =
	{
		InheritFrom = {"DefaultGodGiftData"},
		MaxedIcon = "Keepsake_Aphrodite_Max",
		MaxedSticker = "Keepsake_AphroditeSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "AphroditeGift06", "AphroditeGift07" }, },
		Locked = 7,
		Maximum = 7,
		[1] = { Gift = "ForceAphroditeBoonTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "AphroditeAboutLove02" } }
	},

	ArtemisUpgrade =
	{
		InheritFrom = {"DefaultGodGiftData"},
		MaxedIcon = "Keepsake_Artemis_Max",
		MaxedSticker = "Keepsake_ArtemisSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "ArtemisGift07" }, },
		Locked = 7,
		Maximum = 7,
		[1] = { Gift = "ForceArtemisBoonTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "ArtemisAboutCallisto07" } }
	},

	DemeterUpgrade =
	{
		InheritFrom = {"DefaultGodGiftData"},
		MaxedIcon = "Keepsake_Demeter_Max",
		MaxedSticker = "Keepsake_DemeterSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "DemeterGift07" }, },
		Locked = 7,
		Maximum = 7,
		[1] = { Gift = "ForceDemeterBoonTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "DemeterPostEpilogue03" } }
	},
	
	HermesUpgrade =
	{
		InheritFrom = {"DefaultGodGiftData"},
		MaxedIcon = "Keepsake_Hermes_Max",
		MaxedSticker = "Keepsake_HermesSticker_Max",
		MaxedRequirement = { RequiredAnyTextLines = { "HermesGift08", "HermesGift08B" }, },
		Locked = 7,
		Maximum = 8,
		[1] = { Gift = "FastClearDodgeBonusTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		[8] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "HermesAboutPlume02" } }
	},

	TrialUpgrade =
	{
		InheritFrom = {"DefaultGodGiftData"},
		MaxedIcon = "Keepsake_Chaos_Max",
		MaxedSticker = "Keepsake_ChaosSticker_Max",
		MaxedRequirement = { RequiredTextLines = { "ChaosGift08" }, },
		Value = 0,
		Locked = 7,
		Maximum = 8,
		[1] = { Gift = "ChaosBoonTrait" },
		[7] = { RequiredResource = "SuperGiftPoints" },
		[8] = { RequiredResource = "SuperGiftPoints" },
		UnlockGameStateRequirements = { RequiredTextLines = { "ChaosAboutNyx06" } }
	},
}