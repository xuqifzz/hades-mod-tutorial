GameData.RunClearMessageData =
{
	DefaultMessage =
	{
		DebugOnly = true,
		Icon = "Shop_BedroomDecor",
	},

	ClearNumOne =
	{
		InheritFrom = { "DefaultMessage" },
		Priority = true,
		GameStateRequirements =
		{
			RequiredRunsCleared = 1,
		},
	},

	ClearNumTen =
	{
		InheritFrom = { "DefaultMessage" },
		Priority = true,
		GameStateRequirements =
		{
			RequiredRunsCleared = 10,
		},
	},

	ClearNumFifty =
	{
		InheritFrom = { "DefaultMessage" },
		Priority = true,
		GameStateRequirements =
		{
			RequiredRunsCleared = 50,
		},
	},

	ClearNumOneHundred =
	{
		InheritFrom = { "DefaultMessage" },
		Priority = true,
		GameStateRequirements =
		{
			RequiredRunsCleared = 100,
		},
	},

	ClearNumTwoFifty =
	{
		InheritFrom = { "DefaultMessage" },
		Priority = true,
		GameStateRequirements =
		{
			RequiredRunsCleared = 250,
		},
	},

	ClearNumFiveHundred =
	{
		InheritFrom = { "DefaultMessage" },
		Priority = true,
		GameStateRequirements =
		{
			RequiredRunsCleared = 500,
		},
	},

	ClearNearDeath =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredMaxHealthFraction = 0.05,
			RequiredMaxLastStands = 0,
		},
	},

	ClearFullHealth =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredMinHealthFraction = 1.0,
			RequiredFalseTraits = { "SwordCursedLifeStealTrait", "SpearSpinTravel" },
		},
	},

	ClearHighMaxHealth =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredMinMaxHealthAmount = 400,
		},
	},

	ClearTimeFast =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCurrentClearTimeMax = 900,
		},
	},

	ClearTimeVeryFast =
	{
		InheritFrom = { "DefaultMessage" },
		Priority = true,
		GameStateRequirements =
		{
			RequiredCurrentClearTimeMax = 720,
		},
	},

	ClearTimeSlow =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCurrentClearTimeMin = 3600,
		},
	},

	ClearMoneyNone =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredMoneyMax = 0,
		},
	},

	ClearMoneyHigh =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredMoneyMin = 2000,
		},
	},

	ClearMetaPointsInvestedNone =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredActiveMetaPointsMax = 0,
		},
	},

	ClearNoOlympianBoons =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredNoGodBoons = true,
		},
	},

	ClearAllStoryRooms =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredRoomsThisRun = { "A_Story01", "B_Story01", "C_Story01", },
		},
	},

	ClearAllReprieveRooms =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredRoomsThisRun = { "A_Reprieve01", "B_Reprieve01", "C_Reprieve01", },
		},
	},

	ClearAllShopRooms =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredRoomsThisRun = { "A_Shop01", "B_Shop01", "C_Shop01", },
		},
	},

	ClearRequiredTraitsZeus =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCountOfTraitsCount = 6,
			RequiredCountOfTraits =
			{
				"ZeusWeaponTrait",
				"ZeusRushTrait",
				"ZeusRangedTrait",
				"ZeusSecondaryTrait",
				"ZeusShoutTrait",

				"RetaliateWeaponTrait",
				"SuperGenerationTrait",
				"OnWrathDamageBuffTrait",
				"PerfectDashBoltTrait",

				"ZeusBonusBounceTrait",
				"ZeusLightningDebuff",
				"ZeusBoltAoETrait",
				"ZeusBonusBoltTrait",
				"ZeusChargedBoltTrait",
			},
			RequiredOneOfTraits = { "ZeusChargedBoltTrait" },
		},
	},

	ClearRequiredTraitsPoseidon =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCountOfTraitsCount = 6,
			RequiredCountOfTraits =
			{
				"PoseidonWeaponTrait",
				"PoseidonSecondaryTrait",
				"PoseidonRushTrait",
				"PoseidonRangedTrait",
				"PoseidonShoutTrait",
				"PoseidonShoutDurationTrait",
				"BossDamageTrait",
				"EncounterStartOffenseBuffTrait",

				"RoomRewardBonusTrait",
				"DefensiveSuperGenerationTrait",
				"BonusCollisionTrait",
				"SlamExplosionTrait",
				"SlipperyTrait",
				"DoubleCollisionTrait",
			},
			RequiredOneOfTraits = { "DoubleCollisionTrait" },
		},
	},

	ClearRequiredTraitsAthena =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCountOfTraitsCount = 6,
			RequiredCountOfTraits =
			{
				"AthenaWeaponTrait",
				"AthenaSecondaryTrait",
				"AthenaRushTrait",
				"AthenaRangedTrait",
				"AthenaShoutTrait",

				"TrapDamageTrait",
				"EnemyDamageTrait",
				"AthenaRetaliateTrait",
				"PreloadSuperGenerationTrait",

				"AthenaBackstabDebuffTrait",
				"AthenaShieldTrait",
				"ShieldHitTrait",
			},
			RequiredOneOfTraits = { "ShieldHitTrait" },
		},
	},

	ClearRequiredTraitsAres =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCountOfTraitsCount = 6,
			RequiredCountOfTraits =
			{
				"AresWeaponTrait",
				"AresSecondaryTrait",
				"AresRushTrait",
				"AresRangedTrait",
				"AresShoutTrait",

				"LastStandDamageBonusTrait",
				"AresRetaliateTrait",
				"IncreasedDamageTrait",
				"OnEnemyDeathDamageInstanceBuffTrait",
				"AresLongCurseTrait",
				"AresLoadCurseTrait",
				"AresAoETrait",
				"AresDragTrait",
				"AresCursedRiftTrait",
			},
			RequiredOneOfTraits = { "AresCursedRiftTrait" },
		},
	},

	ClearRequiredTraitsArtemis =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCountOfTraitsCount = 6,
			RequiredCountOfTraits =
			{
				"ArtemisWeaponTrait",
				"ArtemisRushTrait",
				"ArtemisRangedTrait",
				"ArtemisSecondaryTrait",
				"ArtemisShoutTrait",

				 "AmmoReclaimTrait",
				 "CritBonusTrait",
				 "ArtemisSupportingFireTrait",
				 "ArtemisBonusProjectileTrait",
				 "CritVulnerabilityTrait",
				 "ArtemisCriticalTrait",
				 "CriticalBufferMultiplierTrait",
				 "CriticalSuperGenerationTrait",
				 "ArtemisAmmoExitTrait",
				 "MoreAmmoTrait",
			},
			RequiredOneOfTraits = { "MoreAmmoTrait" },
		},
	},

	ClearRequiredTraitsAphrodite =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCountOfTraitsCount = 6,
			RequiredCountOfTraits =
			{
				"AphroditeWeaponTrait",
				"AphroditeSecondaryTrait",
				"AphroditeRushTrait",
				"AphroditeRangedTrait",
				"AphroditeShoutTrait",
				"AphroditeRangedBonusTrait",

				"AphroditeRetaliateTrait",
				"AphroditeDeathTrait",
				"ProximityArmorTrait",
				"HealthRewardBonusTrait",
				"AphroditeDurationTrait",
				"AphroditeWeakenTrait",
				"CharmTrait",
			},
			RequiredOneOfTraits = { "CharmTrait" },
		},
	},

	ClearRequiredTraitsDionysus =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCountOfTraitsCount = 6,
			RequiredCountOfTraits =
			{
				"DionysusWeaponTrait",
				"DionysusSecondaryTrait",
				"DionysusRushTrait",
				"DionysusRangedTrait",
				"DionysusShoutTrait",
				"FountainDamageBonusTrait",

				"DoorHealTrait",
				"LowHealthDefenseTrait",
				"DionysusSpreadTrait",
				"DionysusSlowTrait",
				"DionysusPoisonPowerTrait",
				"DionysusDefenseTrait",
				"DionysusComboVulnerability",
			},
			RequiredOneOfTraits = { "DionysusComboVulnerability" },
		},
	},

	ClearRequiredTraitsDemeter =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCountOfTraitsCount = 6,
			RequiredCountOfTraits =
			{
				"DemeterWeaponTrait",
				"DemeterSecondaryTrait",
				"DemeterRushTrait",
				"DemeterRangedTrait",
				"DemeterShoutTrait",
				"DemeterRangedBonusTrait",
				"DemeterRetaliateTrait",

				"CastNovaTrait",
				"ZeroAmmoBonusTrait",
				"MaximumChillBlast",
				"MaximumChillBonusSlow",
				"InstantChillKill",
			},
			RequiredOneOfTraits = { "InstantChillKill" },
		},
	},

	ClearRequiredTraitsHermes =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCountOfTraitsCount = 3,
			RequiredCountOfTraits =
			{
				"HermesShoutDodge",
				"HermesWeaponTrait",
				"HermesSecondaryTrait",
				"RushRallyTrait",
				"MoveSpeedTrait",
				"RushSpeedBoostTrait",
				"RapidCastTrait",
				"BonusDashTrait",
				"DodgeChanceTrait",
				"MagnetismTrait",
				"RegeneratingSuperTrait",
				"ChamberGoldTrait",
				"SpeedDamageTrait",
			},
			RequiredOneOfTraits = { "MagnetismTrait", "UnstoredAmmoDamageTrait" },
		},
	},

	ClearRequiredTraitsChaos =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCountOfTraitsCount = 3,
			RequiredCountOfTraits =
			{
				"ChaosBlessingMeleeTrait",
				"ChaosBlessingRangedTrait",
				"ChaosBlessingAmmoTrait",
				"ChaosBlessingMaxHealthTrait",
				"ChaosBlessingBoonRarityTrait",
				"ChaosBlessingMoneyTrait",
				"ChaosBlessingMetapointTrait",
				"ChaosBlessingTrapDamageTrait",
				"ChaosBlessingSecondaryTrait",
				"ChaosBlessingDashAttackTrait",
				"ChaosBlessingExtraChanceTrait"
			},
			RequiredOneOfTraits = { "ChaosBlessingExtraChanceTrait" },
		},
	},

	ClearSynergyTraits =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCountOfTraitsCount = 4,
			RequiredCountOfTraits =
			{
				"LightningCloudTrait",
				"AutoRetaliateTrait",
				"ImpactBoltTrait",
				"ReboundingAthenaCastTrait",

				"TriggerCurseTrait",
				"SlowProjectileTrait",
				"ArtemisReflectBuffTrait",

				"AresHomingTrait",
				"AmmoBoltTrait",
				"HeartsickCritDamageTrait",

				"CurseSickTrait",
				"ImprovedPomTrait",
				"DionysusAphroditeStackIncreaseTrait",

				"RaritySuperBoost",

				"HomingLaserTrait",
				"IceStrikeArrayTrait",
				"BlizzardOrbTrait",
				"JoltDurationTrait",

				"PoseidonAresProjectileTrait",
				"ArtemisBonusProjectileTrait",
				"CastBackstabTrait",
				"PoisonTickRateTrait",
				"MultiLaserTrait",
				"StationaryRiftTrait",
				"NoLastStandRegenerationTrait",
				"RegeneratingCappedSuperTrait",
				"StatusImmunityTrait",
				"PoisonCritVulnerabilityTrait",
			},
		},
	},

	ClearLegendaryTraits =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredCountOfTraitsCount = 3,
			RequiredCountOfTraits =
			{
				"ZeusChargedBoltTrait",
				"ShieldHitTrait",
				"DoubleCollisionTrait",
				"FishingTrait",
				"MoreAmmoTrait",
				"UnstoredAmmoDamageTrait",
				"CharmTrait",
				"AresCursedRiftTrait",
				"DionysusComboVulnerability",
				"InstantChillKill",
				"MagnetismTrait",
				"HermesRushAreaSlow",
			},
		},
	},

	ClearChallengeSwitches =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredEncountersThisRun =
			{
				"TimeChallengeTartarus",
				"TimeChallengeAsphodel",
				"TimeChallengeElysium",
			},
			RequiredTrait = "TemporaryForcedChallengeSwitchTrait",
		},
	},

	ClearDevotionEncounters =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredMinEncountersThisRun =
			{
				Count = 2,
				Names =
				{
					"DevotionTestTartarus",
					"DevotionTestAsphodel",
					"DevotionTestElysium",
				},
			},
			RequiredInteractedGodsThisRun = 4,
		},
	},

	ClearShrineChallengeEncounters =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredMinEncountersThisRun =
			{
				Count = 3,
				Names =
				{
					"ShrineChallengeTartarus",
					"ShrineChallengeAsphodel",
					"ShrineChallengeElysium",
				},
			},
		},
	},

	ClearMiniBossEncounters =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredMinEncountersThisRun =
			{
				Count = 5,
				Names =
				{
					-- Tartarus
					"MiniBossGrenadier",
					"MiniBossWretchAssassin",
					"MiniBossHeavyRangedSplitter",
					-- Asphodel
					-- "WrappingAsphodel",
					"MiniBossHitAndRun",
					"MiniBossSpreadShot",
					-- Elysium
					"MiniBossNakedSpawners",
					"MiniBossNakedSpawners",
					"MiniBossMinotaur",
					-- Styx
					"MiniBossRatThug",
					"MiniBossMineLayer",
					"MiniBossSatyr",
					"MiniBossHeavyRangedForked",
					"MiniBossCrawler",
				},
			},
			RequiredActiveMetaUpgrade = "MinibossCountShrineUpgrade",
		},
	},

	ClearWeaponsFiredWrath =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredWeaponsFiredThisRun =
			{
				Count = 50,
				Names =
				{
					"AresSurgeWeapon",
					"PoseidonSurfWeapon",
					"AthenaShoutWeapon",
					--"LightningStrikeX",
					--"DionysusShoutWeapon",
					"AphroditeSuperCharm",
					"AphroditeMaxSuperCharm",
					"ArtemisShoutWeapon",
					"ArtemisMaxShoutWeapon",
					"DemeterSuper",
					"DemeterMaxSuper",
				},
			},
		},
	},

	ClearWeaponsFiredRanged =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredWeaponsFiredThisRun =
			{
				Count = 1000,
				Names =
				{
					"RangedWeapon",
				},
			},
		},
	},

	ClearFishCaught =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredMinCaughtFishThisRun = 4,
			RequiredAnyCaughtFishTypesThisRun = { "Fish_Tartarus_Legendary_01", "Fish_Asphodel_Legendary_01", "Fish_Elysium_Legendary_01", "Fish_Styx_Legendary_01", "Fish_Chaos_Legendary_01" },
		},
	},

	ClearConsecutiveHigh =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredConsecutiveClears = 10,
		},
	},

	ClearHealItems =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredConsumablesThisRun =
			{
				Count = 65,
				Names =
				{
					"RoomRewardHealDrop",
					"HealDropRange",
					"HealDropMinor",
				},
			}
		},
	},

	ClearStackUpgrades =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			MinRequiredRunLootPickups =
			{
				Count = 11,
				Name =	"StackUpgrade",
			}
		},
	},

	ClearGiftDrops =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredConsumablesThisRun =
			{
				Count = 7,
				Names =
				{
					"GiftDrop",
					"GiftDropRunProgress",
					"SuperGiftDrop",
				},
			}
		},
	},

	ClearLockKeyDrops =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredConsumablesThisRun =
			{
				Count = 7,
				Names =
				{
					"LockKeyDrop",
					"LockKeyDropRunProgress",
				},
			}
		},
	},

	ClearConsolationPrizes =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredConsumablesThisRun =
			{
				Count = 2,
				Names =
				{
					"RoomRewardConsolationPrize",
				},
			}
		},
	},

	ClearManyLastStands =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredMinLastStandsUsed = 6,
		},
	},

	ClearShutDownThanatos =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredAnyEncountersThisRun = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro" },
			RequiredMaxThanatosKillsThisRun = 0,
		},
	},

	ClearManyTraitsSold =
	{
		InheritFrom = { "DefaultMessage" },
		GameStateRequirements =
		{
			RequiredMinTraitsSold = 5,
		},
	},

}

ScreenData.RunHistory =
{
	AllowInputRepeat = true,
	TraitsPerColumn = 8,
	TraitColumnStartX = -650,
	TraitColumnOffsetY = 92,
	MaxColumns = 4,
	TraitColumnSpacing = 
	{
		{ Code = "en", Value = 336 },
		{ Code = "ja", Value = 400 },
	},
}

ScreenData.GameStats =
{
	CategoryStartX = 500,
	CategoryStartY = 220,
	CategorySpacingX = 240,

	ScrollOffset = 0,
	ItemsPerPage = 15,
	LangItemsPerPage =
	{
		{ Code = "de", Value = 10 },
		{ Code = "ja", Value = 9 },
		{ Code = "pt-BR", Value = 10 },
		{ Code = "ru", Value = 10 },
	},
	LangLineSpacingSmall =
	{
		{ Code = "de", Value = 52 },
		{ Code = "ja", Value = 55 },
		{ Code = "pt-BR", Value = 52 },
		{ Code = "ru", Value = 52 },
	},
	TraitColumnStartX = -550,
	TraitColumnStartY = -200,
	TraitColumnSpacing = 
	{
		{ Code = "en", Value = 400 },
	},

	TraitFilters =
	{
		"GameStats_Weapons",
		"GameStats_Boons",
		"GameStats_WeaponUpgrades",
		"GameStats_Aspects",
		"GameStats_Keepsakes",
	},

	WeaponColumnHeaders =
	{
		{ OffsetX = 0, Text = "", Justification = "Left", },
		{ OffsetX = 0, Text = "", Justification = "Right", },
		{ OffsetX = 220, Text = "", Justification = "Left", },
		{ OffsetX = 675, Text = "RunClearScreen_Header_Clears", Justification = "Right", },
		{ OffsetX = 860, Text = "RunClearScreen_Header_RecordClearTime", Justification = "Right", },
		{ OffsetX = 1010, Text = "RunClearScreen_Header_RecordShrinePoints", Justification = "Right", },
	}
}