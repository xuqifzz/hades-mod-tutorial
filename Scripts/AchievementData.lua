GameData.AchievementData =
{
	DefaultAchievement =
	{
		DebugOnly = true,
	},

	AchClearTartarus =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredSeenRooms = { "B_Intro", },
		},
	},

	AchClearAsphodel =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredSeenRooms = { "C_Intro", },
		},
	},

	AchClearElysium =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredSeenRooms = { "D_Intro", },
		},
	},

	AchClearElysiumEM =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredRoom = "C_PostBoss01",
			RequireEncounterCompleted = "BossTheseusAndMinotaur",
			RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
		},
	},

	AchClearHeatGate =
	{
		InheritFrom = { "DefaultAchievement" },
	},

	AchClearAnyRun =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiresRunCleared = true,
		},
	},

	AchClearRun4thAspect =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiresRunCleared = true,
			RequiresInRun = true,
			RequiredOneOfTraits = { "SwordConsecrationTrait", "SpearSpinTravel", "ShieldLoadAmmoTrait", "BowBondTrait", "FistDetonateTrait", "GunLoadedGrenadeTrait" },
		},
	},

	AchBeatCharon =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredTrait = "DiscountTrait",
		},
	},

	AchBronzeSkellyTrophy =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredTextLines = { "TrophyQuest_BronzeUnlocked_01" },
		},
	},

	AchSilverSkellyTrophy =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredTextLines = { "TrophyQuest_SilverUnlocked_01" },
		},
	},

	AchFoundKeepsakes =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredTextLines = { "CerberusGift01", "AchillesGift01", "NyxGift01", "HypnosGift01", "CharonGift01", "MegaeraGift01", "ThanatosGift01", "OrpheusGift01", "DusaGift01", "SkellyGift01",
								  "SisyphusGift01", "EurydiceGift01", "PatroclusGift01", "PersephoneGift01", "HadesGift02", "AthenaGift01", "ZeusGift01", "PoseidonGift01", "AphroditeGift01", "ArtemisGift01",
								  "AresGift01", "DionysusGift01", "ChaosGift01" },
			RequiredAnyTextLines = { "HermesGift01", "HermesGift01B" },
			RequiredAnyOtherTextLines = { "DemeterGift01", "DemeterGift02", "DemeterGift03" },
		},
	},

	AchLeveledKeepsakes =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiresMaxKeepsakes = { 
				"MaxHealthKeepsakeTrait", "DirectionalArmorTrait",
				"BackstabAlphaStrikeTrait", "BonusMoneyTrait",
				"ShopDurationTrait", "LowHealthDamageTrait",
				"PerfectClearDamageBonusTrait", "DistanceDamageTrait",
				"LifeOnUrnTrait", "ReincarnationTrait",
				"VanillaTrait", "ShieldBossTrait",
				"ShieldAfterHitTrait", "ChamberStackTrait",
				"HadesShoutKeepsake", "ForceAthenaBoonTrait",
				"ForceZeusBoonTrait", "ForcePoseidonBoonTrait",
				"ForceAphroditeBoonTrait", "ForceArtemisBoonTrait",
				"ForceAresBoonTrait", "ForceDionysusBoonTrait",
				"ForceDemeterBoonTrait", "FastClearDodgeBonusTrait",
				"ChaosBoonTrait" },
		},
	},

	AchFoundSummon =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredAnyAssistKeepsake = true,
		},
	},

	AchFoundAllSummons =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredTextLines = { "MegaeraGift07", "ThanatosGift07_A", "DusaGift07", "SkellyGift07", "SisyphusGift07_A", "AchillesGift07_A" },
		},
	},

	AchMaxedAnyAspect =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredMinMaxedWeaponEnchantments = 1,
		},
	},

	ActUnlockedAllAspects =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredMinUnlockedWeaponEnchantments = 18,
		},

	},

	AchPickedManyBoons =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredUniqueGodTraitsTaken = 100,
		},
	},

	AchPurgedLegendBoon =
	{
		InheritFrom = { "DefaultAchievement" },
	},

	AchPickedManyHammers =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredUniqueWeaponUpgradesTaken = 50,
		},
	},

	AchUnlockedAllWeapons =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredWeaponsUnlocked = { "SwordWeapon", "SpearWeapon", "ShieldWeapon", 'BowWeapon', "FistWeapon", "GunWeapon" },
		},	
	},

	AchForgedBond =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredAnyTextLines =
			{
				"CerberusGift09", "AchillesGift09_A",
				"NyxGift09", "HypnosGift08",
				"CharonGift07", "MegaeraGift10",
				"ThanatosGift10", "OrpheusGift08",
				"BecameCloseWithDusa01", "SkellyGift09",
				"SisyphusGift09_A", "EurydiceGift08",
				"PatroclusGift08_A", "PersephoneGift09",
				"HadesGift05", "ZeusGift07",
				"PoseidonGift07", "AthenaGift07",
				"AphroditeGift07", "ArtemisGift07",
				"AresGift07", "DionysusGift07",
				"DemeterGift07", "ChaosGift08",
				"HermesGift08",	"HermesGift08B"
			},
		},
	},

	AchOlympiansCodex =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredCodexEntries =
			{
				ZeusUpgrade = 3,
				PoseidonUpgrade = 3,
				AthenaUpgrade = 3,
				AphroditeUpgrade = 3,
				AresUpgrade = 3,
				ArtemisUpgrade = 3,
				DionysusUpgrade = 3,
				DemeterUpgrade = 4,
				HermesUpgrade = 3,
			},
		},
	},

	AchManyBrokerTrades =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredMinValues = { MarketSales = 20 },
		},
	},

	AchManyCosmetics =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredNumCosmeticsMin = 50,
		},
	},

	AchManyQuests =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredMinQuestsComplete = 15,
		},
	},

	AchFishFromEachBiome =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredAnyCaughtFishTypesOfEach = {
				{ "Fish_Tartarus_Common_01", "Fish_Tartarus_Rare_01", "Fish_Tartarus_Legendary_01" },
				{ "Fish_Asphodel_Common_01", "Fish_Asphodel_Rare_01", "Fish_Asphodel_Legendary_01" },
				{ "Fish_Elysium_Common_01", "Fish_Elysium_Rare_01", "Fish_Elysium_Legendary_01" },
				{ "Fish_Styx_Common_01", "Fish_Styx_Rare_01", "Fish_Styx_Legendary_01" },
				{ "Fish_Surface_Common_01", "Fish_Surface_Rare_01", "Fish_Surface_Legendary_01" },
			},
		},
	},

	AchOrpheusSingsAgain =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredAnyTextLines = { "OrpheusSingsAgain01", "OrpheusSingsAgain01_B", "OrpheusSingsAgain01_C", "OrpheusSingsAgain01_D", "OrpheusSingsAgain02", "OrpheusSingsAgain03", "OrpheusSingsAgain03_B"  },
		},
	},

	AchMirrorAllUnlocked =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredAllMetaUpgradesInvestment = 1
		},
	},

	AchNyxChaosReunion =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequireQuestsComplete = { "NyxChaosReunion", },
		},
	},

	AchMeetChthonicGods =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequireQuestsComplete = { "MeetChthonicGods", },
		},
	},

	AchAresKills =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequireQuestsComplete = { "AresEarnKills", },
		},
	},

	AchSisyphusLiberation =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequireQuestsComplete = { "SisyphusLiberation", },
		},
	},

	AchSingersReunion =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequireQuestsComplete = { "OrpheusEurydiceReunion", },
		},
	},

	AchMyrmidonReunion =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequireAnyQuestsComplete = { "AchillesPatroclusReunion_A", "AchillesPatroclusReunion_B", "AchillesPatroclusReunion_C", },
		},
	},

	AchMirrorUpgradeClears =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequireQuestsComplete = { "MirrorUpgrades", },
		},
	},

	AchPactUpgradesClears =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequireQuestsComplete = { "PactUpgrades", },
		},
	},

	AchWeaponClears =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequireQuestsComplete = { "WeaponClears", },
		},
	},

	AchEliteAttributeKills =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequireQuestsComplete = { "EliteAttributeKills", },
		},
	},

	AchAccessAdminChamber =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredRoom = "DeathAreaOffice",
			RequiredCosmetics = { "OfficeDoorUnlockItem" },
		},
	},

	AchReachedEnding =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredTextLines = { "Ending01" },
		},
	},

	AchReachedEpilogue =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredTextLines = { "OlympianReunionQuestComplete" },
		},
	},

	AchWellShopItems =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredRunMinValues = { WellPurchases = 9 },
		},
	},

	AchBuffedButterfly =
	{
		InheritFrom = { "DefaultAchievement" },
		GoalValue = 1.296,
	},

	AchBuffedPlume =
	{
		InheritFrom = { "DefaultAchievement" },
		GoalValue = 0.2,
	},

	AchCrushedThanatos =
	{
		InheritFrom = { "DefaultAchievement" },
		GoalValue = 15,
	},

	AchGreaterCall =
	{
		InheritFrom = { "DefaultAchievement" },
	},

	AchGreaterCallSpurned =
	{
		InheritFrom = { "DefaultAchievement" },
	},

	AchSkellyKills =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredKills = { TrainingMelee = 15 },
		},
	},

	AchCerberusPets =
	{
		InheritFrom = { "DefaultAchievement" },
		CompleteGameStateRequirements =
		{
			RequiredMinValues = { NumCerberusPettings = 10 },
		},
	},
}