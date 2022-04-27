QuestData =
{
	DefaultQuestItem =
	{
		DebugOnly = true,
		Icon = "Shop_BedroomDecor",
		RewardResourceName = "Gems",
		RewardResourceAmount = 10,
	},

	FirstClear =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "MetaPoints",
		RewardResourceAmount = 1000,
		UnlockGameStateRequirements =
		{
			-- no requirements
		},
		CompleteGameStateRequirements =
		{
			RequiredMinRunsCleared = 1,
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- I broke free after all! Sort of.
			{ Cue = "/VO/ZagreusHome_2967" },
		},
	},

	SwordHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 200,
		UnlockGameStateRequirements =
		{
			--RequiredSeenRooms = { "B_Intro", },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"SwordTwoComboTrait",
				"SwordSecondaryAreaDamageTrait",
				"SwordHeavySecondStrikeTrait",
				"SwordThrustWaveTrait",
				"SwordSecondaryDoubleAttackTrait",
				"SwordHealthBufferDamageTrait",
				"SwordDoubleDashAttackTrait",
				"SwordCriticalTrait",
				"SwordBackstabTrait",
				"SwordCursedLifeStealTrait",
				"SwordGoldDamageTrait",
				"SwordBlinkTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- I know Stygius like the back of my hand.
			{ Cue = "/VO/ZagreusHome_2984" },
		},
	},

	BowHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 200,
		UnlockGameStateRequirements =
		{
			RequiredWeaponsUnlocked = { "BowWeapon" },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"BowDoubleShotTrait",
				"BowLongRangeDamageTrait",
				"BowSlowChargeDamageTrait",
				"BowTapFireTrait",
				"BowPenetrationTrait",
				"BowPowerShotTrait",
				"BowSecondaryBarrageTrait",
				"BowTripleShotTrait",
				"BowSecondaryFocusedFireTrait",
				"BowChainShotTrait",
				"BowCloseAttackTrait",
				"BowConsecutiveBarrageTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Coronacht and I are close by now.
			{ Cue = "/VO/ZagreusHome_2985" },
		},
	},

	ShieldHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 200,
		UnlockGameStateRequirements =
		{
			RequiredWeaponsUnlocked = { "ShieldWeapon" },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"ShieldDashAOETrait",
				"ShieldRushProjectileTrait",
				"ShieldThrowFastTrait",
				"ShieldThrowCatchExplode",
				"ShieldChargeHealthBufferTrait",
				"ShieldChargeSpeedTrait",
				"ShieldBashDamageTrait",
				"ShieldPerfectRushTrait",
				"ShieldThrowElectiveCharge",
				"ShieldThrowEmpowerTrait",
				"ShieldBlockEmpowerTrait",
				"ShieldThrowRushTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Aegis has seen me through how many fights?
			{ Cue = "/VO/ZagreusHome_2986" },
		},
	},

	SpearHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 200,
		UnlockGameStateRequirements =
		{
			RequiredWeaponsUnlocked = { "SpearWeapon" },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"SpearReachAttack",
				"SpearAutoAttack",
				"SpearThrowExplode",
				"SpearThrowBounce",
				"SpearThrowPenetrate",
				"SpearThrowCritical",
				"SpearSpinDamageRadius",
				"SpearSpinChargeLevelTime",
				"SpearDashMultiStrike",
				"SpearThrowElectiveCharge",
				"SpearSpinChargeAreaDamageTrait",
				"SpearAttackPhalanxTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Varatha, has there ever been a greater spear?
			{ Cue = "/VO/ZagreusHome_2987" },
		},
	},

	FistHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 200,
		UnlockGameStateRequirements =
		{
			RequiredWeaponsUnlocked = { "FistWeapon" },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"FistReachAttackTrait",
				"FistAttackFinisherTrait",
				"FistConsecutiveAttackTrait",
				"FistDashAttackHealthBufferTrait",
				"FistDoubleDashSpecialTrait",
				"FistTeleportSpecialTrait",
				"FistChargeSpecialTrait",
				"FistKillTrait",
				"FistSpecialLandTrait",
				"FistSpecialFireballTrait",
				"FistAttackDefenseTrait",
				"FistHeavyAttackTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Malphon's always there for the direct approach.
			{ Cue = "/VO/ZagreusHome_2988" },
		},
	},

	GunHammerUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 200,
		UnlockGameStateRequirements =
		{
			RequiredWeaponsUnlocked = { "GunWeapon" },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"GunSlowGrenade",
				"GunMinigunTrait",
				"GunShotgunTrait",
				"GunExplodingSecondaryTrait",
				"GunGrenadeFastTrait",
				"GunArmorPenerationTrait",
				"GunHeavyBulletTrait",
				"GunInfiniteAmmoTrait",
				"GunGrenadeDropTrait",
				"GunGrenadeClusterTrait",
				"GunChainShotTrait",
				"GunHomingBulletTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Exagryph, you and I have been through a lot.
			{ Cue = "/VO/ZagreusHome_2989" },
		},
	},

	AthenaUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 150,
		UnlockGameStateRequirements =
		{
			-- no requirements
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
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
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Can't believe Lady Athena's fighting for me.
			{ Cue = "/VO/ZagreusHome_2971" },
		},
	},

	ZeusUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 150,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "ZeusGift01", },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
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
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Lord Uncle Zeus sure has been generous.
			{ Cue = "/VO/ZagreusHome_2972" },
		},
	},

	ArtemisUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 150,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "ArtemisGift01", },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"ArtemisWeaponTrait",
				"ArtemisRushTrait",
				"ArtemisRangedTrait",
				"ArtemisSecondaryTrait",
				"ArtemisShoutTrait",

				"CritBonusTrait",
				"ArtemisSupportingFireTrait",
				--"ArtemisBonusProjectileTrait",
				"CritVulnerabilityTrait",
				"ArtemisCriticalTrait",
				"CriticalBufferMultiplierTrait",
				"CriticalSuperGenerationTrait",
				"ArtemisAmmoExitTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Grateful for your help, Lady Artemis.
			{ Cue = "/VO/ZagreusHome_2976" },
		},
	},

	AphroditeUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 150,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "AphroditeGift01", },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
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
				"AphroditePotencyTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Lady Aphrodite... showing me favor.
			{ Cue = "/VO/ZagreusHome_2974" },
		},
	},

	AresUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 150,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "AresGift01", },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"AresWeaponTrait",
				"AresSecondaryTrait",
				"AresRushTrait",
				"AresRangedTrait",
				"AresShoutTrait",

				"AresRetaliateTrait",
				"IncreasedDamageTrait",
				"OnEnemyDeathDamageInstanceBuffTrait",
				"LastStandDamageBonusTrait",
				"AresLongCurseTrait",
				"AresLoadCurseTrait",
				"AresAoETrait",
				"AresDragTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Where there's violence, there's Lord Ares.
			{ Cue = "/VO/ZagreusHome_2975" },
		},
	},

	PoseidonUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 150,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "PoseidonGift01", },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"PoseidonWeaponTrait",
				"PoseidonSecondaryTrait",
				"PoseidonRushTrait",
				"PoseidonRangedTrait",
				"PoseidonShoutTrait",

				"EncounterStartOffenseBuffTrait",
				"RoomRewardBonusTrait",
				"DefensiveSuperGenerationTrait",
				"PoseidonShoutDurationTrait",
				"BonusCollisionTrait",
				"SlamExplosionTrait",
				"SlipperyTrait",
				"BossDamageTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Uncle Poseidon... so different from Father.
			{ Cue = "/VO/ZagreusHome_2973" },
		},
	},

	DionysusUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 150,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "DionysusGift01", },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"DionysusWeaponTrait",
				"DionysusSecondaryTrait",
				"DionysusRushTrait",
				"DionysusRangedTrait",
				"DionysusShoutTrait",

				"DoorHealTrait",
				"LowHealthDefenseTrait",
				"FountainDamageBonusTrait",
				"DionysusSpreadTrait",
				"DionysusSlowTrait",
				"DionysusPoisonPowerTrait",
				"DionysusDefenseTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Never a dull moment with Lord Dionysus around.
			{ Cue = "/VO/ZagreusHome_2977" },
		},
	},

	HermesUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 150,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "HermesGift01", },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
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
				"RegeneratingSuperTrait",
				"ChamberGoldTrait",
				"AmmoReclaimTrait",
				"SpeedDamageTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Glad to have Lord Hermes on my side.
			{ Cue = "/VO/ZagreusHome_2978" },
		},
	},

	DemeterUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 150,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "DemeterGift01", },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"DemeterWeaponTrait",
				"DemeterRushTrait",
				"DemeterRangedTrait",
				"DemeterSecondaryTrait",
				"DemeterShoutTrait",

				"CastNovaTrait",
				"DemeterRangedBonusTrait",
				"DemeterRetaliateTrait",

				"ZeroAmmoBonusTrait",
				"MaximumChillBlast",
				"MaximumChillBonusSlow",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Lady Demeter seems to have taken a shine to me.
			{ Cue = "/VO/ZagreusHome_2979" },
		},
	},

	LegendaryUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 1000,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "AthenaFirstPickUp", "AresFirstPickUp", "AphroditeFirstPickUp", "ArtemisFirstPickUp", "DionysusFirstPickUp", "HermesFirstPickUp", "DemeterFirstPickUp" },
			RequiredAnyTraitsTaken =
			{
				"ZeusChargedBoltTrait",
				"DoubleCollisionTrait",
				"ShieldHitTrait",
				"AresCursedRiftTrait",
				"CharmTrait",
				"MoreAmmoTrait",
				"DionysusComboVulnerability",
				"MagnetismTrait",
				"UnstoredAmmoDamageTrait",
				"InstantChillKill",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"ZeusChargedBoltTrait",
				"DoubleCollisionTrait",
				"ShieldHitTrait",
				"AresCursedRiftTrait",
				"CharmTrait",
				"MoreAmmoTrait",
				"DionysusComboVulnerability",
				"MagnetismTrait",
				"UnstoredAmmoDamageTrait",
				"InstantChillKill",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- The greatest boons of the Olympians... what an honor.
			{ Cue = "/VO/ZagreusHome_3592" },
		},
	},

	SynergyUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 15,
		Spacing = 28,
		FontSize = 18,
		MaxEntriesPerColumn = 14,
		UnlockGameStateRequirements =
		{
			RequiredAnyTraitsTaken =
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
				"SelfLaserTrait",
				"StationaryRiftTrait",
				"NoLastStandRegenerationTrait",
				"RegeneratingCappedSuperTrait",
				"StatusImmunityTrait",
				"PoisonCritVulnerabilityTrait",
			}
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
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
				"SelfLaserTrait",
				"StationaryRiftTrait",
				"NoLastStandRegenerationTrait",
				"RegeneratingCappedSuperTrait",
				"StatusImmunityTrait",
				"PoisonCritVulnerabilityTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- The Olympians aren't all on the best of terms I guess.
			{ Cue = "/VO/ZagreusHome_2980" },
		},
	},

	ChaosBlessings =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "LockKeys",
		RewardResourceAmount = 30,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "ChaosGift03", },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"ChaosBlessingMeleeTrait",
				"ChaosBlessingRangedTrait",
				"ChaosBlessingAmmoTrait",
				"ChaosBlessingMaxHealthTrait",
				"ChaosBlessingBoonRarityTrait",
				"ChaosBlessingMoneyTrait",
				"ChaosBlessingMetapointTrait",
				--"ChaosBlessingTrapDamageTrait",
				--"ChaosBlessingGemTrait",
				"ChaosBlessingSecondaryTrait",
				"ChaosBlessingDashAttackTrait",
				"ChaosBlessingBackstabTrait",
				"ChaosBlessingAlphaStrikeTrait",
				"ChaosBlessingExtraChanceTrait"
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- The gifts of Master Chaos...
			{ Cue = "/VO/ZagreusHome_2981" },
		},
	},

	ChaosCurses =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "LockKeys",
		RewardResourceAmount = 30,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "ChaosGift02", },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"ChaosCurseNoMoneyTrait",
				"ChaosCurseAmmoUseDelayTrait",
				"ChaosCursePrimaryAttackTrait",
				"ChaosCurseSecondaryAttackTrait",
				"ChaosCurseCastAttackTrait",
				"ChaosCurseDeathWeaponTrait",
				"ChaosCurseHiddenRoomReward",
				"ChaosCurseDamageTrait",
				"ChaosCurseTrapDamageTrait",
				"ChaosCurseHealthTrait",
				"ChaosCurseMoveSpeedTrait",
				"ChaosCurseDashRangeTrait",
				"ChaosCurseSpawnTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- I think Master Chaos just likes messing with me.
			{ Cue = "/VO/ZagreusHome_2982" },
		},
	},

	MeetOlympians =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "GiftPoints",
		RewardResourceAmount = 3,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "ZeusFirstPickUp", },
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"ZeusFirstPickUp",
				"PoseidonFirstPickUp",
				"AthenaFirstPickUp",
				"DionysusFirstPickUp",
				"AphroditeFirstPickUp",
				"AresFirstPickUp",
				"ArtemisFirstPickUp",
				-- "HermesFirstPickUp",
			},
		},
		IncompleteName = "Quest_UnknownCondition",

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- My extended family seems an interesting lot.
			{ Cue = "/VO/ZagreusHome_2969" },
		},
	},

	MeetChthonicGods =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "LockKeys",
		RewardResourceAmount = 10,
		UnlockGameStateRequirements =
		{
			-- RequiredTextLines = { "NyxGift01", },
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"Fury2FirstAppearance",
				"Fury3FirstAppearance",
				"ChaosFirstPickUp",
			},
			RequiredMinNPCInteractions =
			{
				NPC_Hades_01 = 1,
				NPC_Nyx_01 = 1,
				NPC_Charon_01 = 1,
				NPC_Hypnos_01 = 1,
				NPC_Thanatos_01 = 1,
				NPC_FurySister_01 = 1,
			},
		},
		DisplayOrder =
		{
			{ Requirement = "NPC_Hades_01", Text = "MetHades", },
			{ Requirement = "NPC_Nyx_01", Text = "MetNyx", },
			{ Requirement = "NPC_Charon_01", Text = "MetCharon", },
			{ Requirement = "NPC_Thanatos_01", Text = "MetThanatos", },
			{ Requirement = "NPC_Hypnos_01", Text = "MetHypnos", },
			{ Requirement = "NPC_FurySister_01", Text = "MetFury", },
		},
		IncompleteName = "Quest_UnknownCondition",

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Good to have friends in low places..
			{ Cue = "/VO/ZagreusHome_2970" },
		},
	},

	WeaponUnlocks =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 60,
		UnlockGameStateRequirements =
		{
			-- None
		},
		CompleteGameStateRequirements =
		{
			RequiredWeaponsUnlocked =
			{
				"SwordWeapon",
				"SpearWeapon",
				"ShieldWeapon",
				"BowWeapon",
				"FistWeapon",
				"GunWeapon"
			},
		},
		IncompleteName = "Quest_UnknownCondition",

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Nice to have my ancient legendary weapons there.
			{ Cue = "/VO/ZagreusHome_2983" },
		},
	},

	WeaponClears =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperLockKeys",
		RewardResourceAmount = 10,
		UnlockGameStateRequirements =
		{
			RequiredWeaponsUnlocked = { "SwordWeapon", "SpearWeapon", "ShieldWeapon", "BowWeapon", "GunWeapon", "FistWeapon", },
			RequiredMinRunsCleared = 1,
		},
		CompleteGameStateRequirements =
		{
			RequiredClearsWithWeapons =
			{
				Names =
				{
					"SwordWeapon",
					"SpearWeapon",
					"ShieldWeapon",
					"BowWeapon",
					"FistWeapon",
					"GunWeapon",
				},
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Guess I have been rather busy as of late.
			{ Cue = "/VO/ZagreusHome_2990" },
		},
	},

	WeaponAspects =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGems",
		RewardResourceAmount = 6,
		UnlockGameStateRequirements =
		{
			RequiredMinUnlockedWeaponEnchantments = 4,
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"SwordCriticalParryTrait",
				"DislodgeAmmoTrait",

				"BowLoadAmmoTrait",
				"BowMarkHomingTrait",

				"SpearTeleportTrait",
				"SpearWeaveTrait",

				"ShieldTwoShieldTrait",
				"ShieldRushBonusProjectileTrait",

				"FistVacuumTrait",
				"FistWeaveTrait",

				"GunManualReloadTrait",
				"GunGrenadeSelfEmpowerTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- My weapons have revealed their hidden power.
			{ Cue = "/VO/ZagreusHome_2991" },
		},
	},

	KeepsakesQuest =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "ZeusGift01", "AthenaGift01", "AchillesGift01", "CerberusGift01", "NyxGift01", "SkellyGift01", "DusaGift01", "HypnosGift01" },
		},
		CompleteGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"MaxHealthKeepsakeTrait",
				"DirectionalArmorTrait",
				"BackstabAlphaStrikeTrait",
				"BonusMoneyTrait",
				"LifeOnUrnTrait",
				"ReincarnationTrait",
				"ShopDurationTrait",
				"VanillaTrait",
				"ShieldAfterHitTrait",
				"DistanceDamageTrait",
				"ShieldBossTrait",
				"PerfectClearDamageBonusTrait",
				"LowHealthDamageTrait",

				"ForceAthenaBoonTrait",
				"ForceAphroditeBoonTrait",
				"ForceArtemisBoonTrait",
				"ForceZeusBoonTrait",
				"ForcePoseidonBoonTrait",
				"ForceAresBoonTrait",
				"ForceDionysusBoonTrait",
				"ForceDemeterBoonTrait",
				"FastClearDodgeBonusTrait",

				"ChaosBoonTrait",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Where would I be without my friends?
			{ Cue = "/VO/ZagreusHome_2992" },
		},
	},

	FirstSkellyStatue =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGems",
		RewardResourceAmount = 5,
		UnlockGameStateRequirements =
		{
			RequiredMinRunsCleared = 1,
			RequiredTextLines = { "TrophyQuest_Beginning_01" },
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"TrophyQuest_BronzeUnlocked_01",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- I guess it is a pretty decent statue.
			{ Cue = "/VO/ZagreusHome_2995" },
		},
	},

	--[[
	WeaponClearsHighHeat =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 2000,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"TrophyQuest_GoldUnlocked_01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredClearsWithWeapons =
			{
				ShrinePoints = 32,
				Names =
				{
					"SwordWeapon",
					"SpearWeapon",
					"ShieldWeapon",
					"BowWeapon",
					"FistWeapon",
					"GunWeapon",
				},
			},
		},
	},
	]]

	--[[
	WeaponClearsFast =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 1000,
		UnlockGameStateRequirements =
		{
			RequiredMinClearTime = 1320,
		},
		CompleteGameStateRequirements =
		{
			RequiredClearsWithWeapons =
			{
				ClearTime = 1320,
				Names =
				{
					"SwordWeapon",
					"SpearWeapon",
					"ShieldWeapon",
					"BowWeapon",
					"FistWeapon",
					"GunWeapon",
				},
			},
		},
	},
	]]--

	MiniBossKills =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperLockKeys",
		RewardResourceAmount = 3,
		UnlockGameStateRequirements =
		{
			RequiredSeenRooms = { "D_Intro", },
		},
		CompleteGameStateRequirements =
		{
			RequiredKills =
			{
				BloodlessGrenadierElite = 1,
				HeavyRangedSplitterMiniboss = 1,
				WretchAssassinMiniboss = 1,
				ShieldRangedElite = 1,
				HitAndRunUnitElite = 1,
				CrusherUnitElite = 1,
				SpreadShotUnitMiniboss = 1,
				FlurrySpawnerElite = 1,
				ThiefImpulseMineLayerMiniboss = 1,
				HeavyRangedForkedMiniboss = 1,
				RatThugMiniboss = 1,
				SatyrRangedMiniboss = 1,
			},
		},
		IncompleteName = "Quest_UnknownCondition",
		DisplayOrder =
		{
			"BloodlessGrenadierElite",
			"HeavyRangedSplitterMiniboss",
			"WretchAssassinMiniboss",
			"ShieldRangedElite",
			"HitAndRunUnitElite",
			"CrusherUnitElite",
			"SpreadShotUnitMiniboss",
			"FlurrySpawnerElite",
			"ThiefImpulseMineLayerMiniboss",
			"HeavyRangedForkedMiniboss",
			"RatThugMiniboss",
			"SatyrRangedMiniboss",
		},
		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Was this lot the best you have, Father?
			{ Cue = "/VO/ZagreusHome_2994" },
		}

	},

	EliteAttributeKills =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 450,
		UnlockGameStateRequirements =
		{
			RequiredMinRunsCleared = 1,
			RequiredMinShrinePointThresholdClear = 1,
		},
		CompleteGameStateRequirements =
		{
			RequiredEliteAttributeKills =
			{
				Blink = 1,
				HeavyArmor = 1,
				ExtraDamage = 1,
				Vacuuming = 1,
				DeathSpreadHitShields = 1,
				Frenzy = 1,
				Beams = 1,
				Disguise = 1,
				Molten = 1,
				Homing = 1,
				MultiEgg = 1,
			},
		},
		-- IncompleteName = "Quest_UnknownCondition",
		DisplayOrder =
		{
			"Blink",
			"HeavyArmor",
			"ExtraDamage",
			"Vacuuming",
			"DeathSpreadHitShields",
			"Frenzy",
			"Beams",
			"Disguise",
			"Molten",
			"Homing",
			"MultiEgg",
		},
		DisplayOrder =
		{
			{ Requirement = "Blink", Text = "EliteAttribute_Blink", },
			{ Requirement = "HeavyArmor", Text = "EliteAttribute_HeavyArmor", },
			{ Requirement = "ExtraDamage", Text = "EliteAttribute_ExtraDamage", },
			{ Requirement = "Vacuuming", Text = "EliteAttribute_Vacuuming", },
			{ Requirement = "DeathSpreadHitShields", Text = "EliteAttribute_DeathSpreadHitShields", },
			{ Requirement = "Frenzy", Text = "EliteAttribute_Frenzy", },
			{ Requirement = "Beams", Text = "EliteAttribute_Beams", },
			{ Requirement = "Disguise", Text = "EliteAttribute_Disguise", },
			{ Requirement = "Molten", Text = "EliteAttribute_Molten", },
			{ Requirement = "Homing", Text = "EliteAttribute_Homing", },
			{ Requirement = "MultiEgg", Text = "EliteAttribute_MultiEgg", },
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- I get the perks of getting to slay Father's forces.
			{ Cue = "/VO/ZagreusHome_2999" },
		},
	},

	CosmeticsSmall =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGems",
		RewardResourceAmount = 4,
		UnlockGameStateRequirements =
		{
			RequiredNumCosmeticsMin = 20,
		},
		CompleteGameStateRequirements =
		{
			RequiredNumCosmeticsMin = 37, -- Account for starting 7 cosmetics
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- The Contractor's been plenty busy thanks to me.
			{ Cue = "/VO/ZagreusHome_2968" },
		},
	},

	WellShopItems =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 150,
		Spacing = 29,
		FontSize = 19,
		MaxEntriesPerColumn = 13,
		UnlockGameStateRequirements =
		{
			RequiredTraitsTaken =
			{
				"TemporaryDoorHealTrait",
				"TemporaryImprovedWeaponTrait",
				"TemporaryImprovedSecondaryTrait",
				"TemporaryImprovedTrapDamageTrait",
				"TemporaryMoreAmmoTrait",
				"TemporaryBoonRarityTrait",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredMinItemInteractions =
			{
				HealDropRange = 1,
				EmptyMaxHealthDrop = 1,
				DamageSelfDrop = 1,
				LastStandDrop = 1,
				MetaDropRange = 1,
				GemDropRange = 1,
				KeepsakeChargeDrop = 1,
				RandomStoreItem = 1,
			},

			RequiredTraitsTaken =
			{
				"TemporaryDoorHealTrait",
				"TemporaryWeaponLifeOnKillTrait",
				"TemporaryImprovedWeaponTrait",
				"TemporaryMoreAmmoTrait",
				"TemporaryImprovedRangedTrait",
				"TemporaryMoveSpeedTrait",
				"TemporaryBoonRarityTrait",
				"TemporaryLastStandHealTrait",
				"TemporaryArmorDamageTrait",
				"TemporaryAlphaStrikeTrait",
				"TemporaryBackstabTrait",
				"TemporaryImprovedSecondaryTrait",
				"TemporaryImprovedTrapDamageTrait",
				"TemporaryPreloadSuperGenerationTrait",
				"TemporaryForcedSecretDoorTrait",
				"TemporaryForcedChallengeSwitchTrait",
				"TemporaryForcedFishingPointTrait",
				"TemporaryBlockExplodingChariotsTrait",
			},
		},
		DisplayOrder =
		{
			{ Requirement = "HealDropRange", },
			{ Requirement = "EmptyMaxHealthDrop", },
			{ Requirement = "DamageSelfDrop", },
			{ Requirement = "LastStandDrop", },
			{ Requirement = "MetaDropRange", },
			{ Requirement = "GemDropRange", },
			{ Requirement = "KeepsakeChargeDrop", },
			{ Requirement = "RandomStoreItem", },
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Charon must have made a fortune off of me.
			{ Cue = "/VO/ZagreusHome_3014" },
		},
	},

	CodexSmall =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 40,
		UnlockGameStateRequirements =
		{
			RequiredTextLines = { "AchillesGrantsCodex", },
		},
		CompleteGameStateRequirements =
		{
			RequiredCodexEntriesMin = 70,
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Achilles' Codex... I'm getting somewhere with it.
			{ Cue = "/VO/ZagreusHome_2993" },
		},
	},

	PactUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperLockKeys",
		RewardResourceAmount = 15,
		UnlockGameStateRequirements =
		{
			RequiredTrueFlags = { "ShrineUnlocked", },
		},
		CompleteGameStateRequirements =
		{
			RequiredClearedWithMetaUpgrades =
			{
				"EnemyDamageShrineUpgrade",
				"HealingReductionShrineUpgrade",
				"ShopPricesShrineUpgrade",
				"EnemyCountShrineUpgrade",
				"BossDifficultyShrineUpgrade",

				"EnemyHealthShrineUpgrade",
				"EnemyEliteShrineUpgrade",
				"MinibossCountShrineUpgrade",
				"ForceSellShrineUpgrade",
				"EnemySpeedShrineUpgrade",

				"TrapDamageShrineUpgrade",
				"MetaUpgradeStrikeThroughShrineUpgrade",
				"EnemyShieldShrineUpgrade",
				"ReducedLootChoicesShrineUpgrade",
				"BiomeSpeedShrineUpgrade",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Not even the Pact of Punishment can stop me.
			{ Cue = "/VO/ZagreusHome_2998" },
		},
	},

	MirrorUpgrades =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperLockKeys",
		RewardResourceAmount = 8,
		UnlockGameStateRequirements =
		{
			RequiredMinRunsCleared = 1,
			RequiredTrueFlags = { "SwapMetaupgradesEnabled" },
			RequiredMetaUpgradeStageUnlocked = 4,
		},
		CompleteGameStateRequirements =
		{
			RequiredClearedWithMetaUpgrades =
			{
				"BackstabMetaUpgrade",
				"FirstStrikeMetaUpgrade",
				"DoorHealMetaUpgrade",
				"DarknessHealMetaUpgrade",
				"ExtraChanceMetaUpgrade",
				"ExtraChanceReplenishMetaUpgrade",
				"StaminaMetaUpgrade",
				"PerfectDashMetaUpgrade",
				"StoredAmmoVulnerabilityMetaUpgrade",
				"StoredAmmoSlowMetaUpgrade",
				"AmmoMetaUpgrade",
				"ReloadAmmoMetaUpgrade",
				"MoneyMetaUpgrade",
				"InterestMetaUpgrade",
				"HealthMetaUpgrade",
				"HighHealthDamageMetaUpgrade",
				"VulnerabilityEffectBonusMetaUpgrade",
				"GodEnhancementMetaUpgrade",
				"RareBoonDropMetaUpgrade",
				"DuoRarityBoonDropMetaUpgrade",
				"EpicBoonDropMetaUpgrade",
				"RunProgressRewardMetaUpgrade",
				"RerollMetaUpgrade",
				"RerollPanelMetaUpgrade",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- The Mirror of Night... it's made me strong.
			{ Cue = "/VO/ZagreusHome_3000" },
		},
	},

	-- narrative quests
	SkellyTrueDeath =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGems",
		RewardResourceAmount = 6,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"SkellyTrueDeathQuest_Beginning_01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"SkellyTrueDeathQuestComplete",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- I guess I'm glad Skelly's not permanently dead.
			{ Cue = "/VO/ZagreusHome_3001" },
		},
	},
	SkellyTrueDeath_B =
	{
		InheritFrom = { "SkellyTrueDeath" },
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"SkellyTrueDeathQuest_Beginning_01B",
			},
		},
	},	

	EpilogueSetUp =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGems",
		RewardResourceAmount = 5,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"HadesAboutOlympianReunionQuest01A",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"PersephoneAboutOlympianReunionQuest01",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Took some figuring out, but so does any decent plan, I guess.
			{ Cue = "/VO/ZagreusHome_3740" },
		},
	},

	OlympianReunion =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 20,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"PersephoneAboutOlympianReunionQuest01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"ZeusAboutOlympianReunionQuest01",
				"PoseidonAboutOlympianReunionQuest01",
				"DemeterAboutOlympianReunionQuest01",
				"AthenaAboutOlympianReunionQuest01",
				"AphroditeAboutOlympianReunionQuest01",
				"AresAboutOlympianReunionQuest01",
				"ArtemisAboutOlympianReunionQuest01",
				"DionysusAboutOlympianReunionQuest01",
				"HermesAboutOlympianReunionQuest01",
				"OlympianReunionQuestComplete",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- We're one big happy family. No issues whatsoever!
			{ Cue = "/VO/ZagreusHome_3590" },
		},
	},

	NyxChaosReunion =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 4,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"NyxAboutChaos06",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"NyxInChaos01",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Nyx... this was the least I could do.
			{ Cue = "/VO/ZagreusHome_3002" },
		},
	},
	SisyphusLiberation =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 4,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"SisyphusLiberationQuest_Beginning_01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"SisyphusLiberationQuestComplete",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- I guess Sisyphus is even freer than before.
			{ Cue = "/VO/ZagreusHome_3003" },
		},
	},

	OrpheusRelease =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 80,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"HadesAboutOrpheusUnlockItem01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredMinNPCInteractions =
			{
				NPC_Orpheus_01 = 1,
			},
		},
		DisplayOrder =
		{
			{ Requirement = "NPC_Orpheus_01", Text = "OrpheusFirstMeeting", },
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Tartarus is gloomy enough without Orpheus in it.
			{ Cue = "/VO/ZagreusHome_3588" },
		},
	},


	OrpheusEurydiceReunion =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"EurydiceProgressWithOrpheus03",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"OrpheusAboutSingersReunionQuest01",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Hope Orpheus and Eurydice can be happy again.
			{ Cue = "/VO/ZagreusHome_3004" },
		},
	},
	AchillesPatroclusReunion_A =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 4,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"AchillesAboutMyrmidonReunionQuest03_A",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"MyrmidonReunionQuestComplete",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- May Achilles and Patroclus make up for lost time.
			{ Cue = "/VO/ZagreusHome_3005" },
		},
	},
	AchillesPatroclusReunion_B =
	{
		InheritFrom = { "AchillesPatroclusReunion_A" },
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"AchillesAboutMyrmidonReunionQuest03_B",
			},
		},
	},
	AchillesPatroclusReunion_C =
	{
		InheritFrom = { "AchillesPatroclusReunion_A" },
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"AchillesAboutMyrmidonReunionQuest03_C",
			},
		},
	},

	DusaLoungeRenovation =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGems",
		RewardResourceAmount = 4,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"DusaLoungeRenovationQuest01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"DusaLoungeRenovationQuestComplete",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Dusa's got everything under control, I hope.
			{ Cue = "/VO/ZagreusHome_3006" },
		},
	},

	PoseidonFish =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "Gems",
		RewardResourceAmount = 250,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"PoseidonFishQuest01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"PoseidonFishQuestComplete",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- I shall procure all the fishes.
			{ Cue = "/VO/ZagreusHome_3013" },
		},
	},
	MusicLessons =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"OrpheusAboutMusicPlaying01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"OrpheusMusicProgress04",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- I'm no Orpheus, but I'm no slouch.
			{ Cue = "/VO/ZagreusHome_3012" },
		},
	},
	GuanYuAspectEscape =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"AchillesRevealsGuanYuAspect01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredPlayed =
			{
				-- Well, Guan Yu...? Take good care of Varatha for me.
				"/VO/ZagreusField_3231",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- The Frost Fair Blade... what a weapon...
			{ Cue = "/VO/ZagreusHome_3007" },
		},
	},
	ArthurAspectEscape =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"NyxRevealsArthurAspect01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredPlayed =
			{
				-- We made it, Stygius. I hope this Arthur serves you well someday.
				"/VO/ZagreusField_3250",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Holy Excalibur... thank you for your strength.
			{ Cue = "/VO/ZagreusHome_3008" },
		},
	},
	RamaAspectEscape =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"ArtemisRevealsRamaAspect01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredPlayed =
			{
				-- We're here, Coronacht. May you serve Rama well... if you haven't already done so, I guess...
				"/VO/ZagreusField_3251",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Celestial Sharanga... it was my honor.
			{ Cue = "/VO/ZagreusHome_3009" },
		},
	},
	BeowulfAspectEscape =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"ChaosRevealsBeowulfAspect01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredPlayed =
			{
				-- Here we are, then, Aegis. This Beowulf will be most fortunate to have your protection.	
				"/VO/ZagreusField_3691",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Naegling's Board... nothing gets past you.
			{ Cue = "/VO/ZagreusHome_3010" },
		},
	},
	GilgameshAspectEscape =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"MinotaurRevealsGilgameshAspect01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredPlayed =
			{
				-- All right, we made it, Malphon. Appreciate you lending me the might of Gilgamesh.
				"/VO/ZagreusField_4656",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- The Claws of Enkidu helped me scrape by to the top.
			{ Cue = "/VO/ZagreusHome_3591" },
		},
	},
	LuciferAspectEscape =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"ZeusRevealsLuciferAspect01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredPlayed =
			{
				-- Here's the surface, Exagryph. Maybe it's as rare a sight for that Lucifer as it is for me.
				"/VO/ZagreusField_3690",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Igneus Eden... where in blazes did Lucifer find you?
			{ Cue = "/VO/ZagreusHome_3011" },
		},
	},

	ChaosKeepsakeEscape =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGems",
		RewardResourceAmount = 3,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"ChaosSurfaceQuest01",
				"LordHadesDefeated02",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"LordHadesChaosSurfaceQuestDefeat01",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Always happy to oblige Master Chaos.
			{ Cue = "/VO/ZagreusHome_3016" },
		},
	},

	PoseidonBeatTheseus =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperGiftPoints",
		RewardResourceAmount = 3,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"PoseidonBeatTheseusQuest01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"PoseidonBeatTheseusQuestComplete",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Anything to cut Theseus down to size.
			{ Cue = "/VO/ZagreusHome_3017" },
		},
	},

	AresEarnKills =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperLockKeys",
		RewardResourceAmount = 2,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"AresKillQuest01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"AresKillQuestComplete",
			},
		},
		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- This one's for you, ever-bloodthirsty god of war.
			{ Cue = "/VO/ZagreusHome_3027" },
		},
	},

	HermesBeatCharon =
	{
		InheritFrom = { "DefaultQuestItem" },
		RewardResourceName = "SuperLockKeys",
		RewardResourceAmount = 5,
		UnlockGameStateRequirements =
		{
			RequiredTextLines =
			{
				"HermesBeatCharonQuest01",
			},
		},
		CompleteGameStateRequirements =
		{
			RequiredTextLines =
			{
				"BossCharonHermesQuestComplete01",
			},
		},

		CashedOutVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "ZagreusProphecyFulfilledSpeech", Time = 3 },
			},

			-- Hermes really believed I could pull this off.
			{ Cue = "/VO/ZagreusHome_3015" },
		},
	},

}

QuestOrderData =
{
	"OlympianReunion",
	"EpilogueSetUp",
	"FirstClear",
	"MeetOlympians",
	"MeetChthonicGods",

	"NyxChaosReunion",
	"AchillesPatroclusReunion_A",
	"AchillesPatroclusReunion_B",
	"AchillesPatroclusReunion_C",
	"OrpheusRelease",
	"OrpheusEurydiceReunion",
	"SisyphusLiberation",
	"SkellyTrueDeath",
	"SkellyTrueDeath_B",
	"DusaLoungeRenovation",
	"ChaosKeepsakeEscape",
	"PoseidonBeatTheseus",
	"AresEarnKills",
	"HermesBeatCharon",

	"AthenaUpgrades",
	"ZeusUpgrades",
	"PoseidonUpgrades",
	"AphroditeUpgrades",
	"AresUpgrades",
	"ArtemisUpgrades",
	"DionysusUpgrades",
	"HermesUpgrades",
	"DemeterUpgrades",
	"LegendaryUpgrades",
	"SynergyUpgrades",
	"ChaosBlessings",
	"ChaosCurses",

	"WeaponUnlocks",
	"SwordHammerUpgrades",
	"ArthurAspectEscape",
	"RamaAspectEscape",
	"BeowulfAspectEscape",
	"GilgameshAspectEscape",
	"LuciferAspectEscape",
	"BowHammerUpgrades",
	"ShieldHammerUpgrades",
	"SpearHammerUpgrades",
	"GuanYuAspectEscape",
	"FistHammerUpgrades",
	"GunHammerUpgrades",

	"WeaponClears",
	"WeaponAspects",
	"PactUpgrades",
	"EliteAttributeKills",
	"MiniBossKills",
	"CosmeticsSmall",
	"CodexSmall",
	"WellShopItems",

	"MirrorUpgrades",
	"KeepsakesQuest",
	"PoseidonFish",
	"MusicLessons",
	"FirstSkellyStatue",
	--"WeaponClearsHighHeat",
	--"WeaponClearsFast",
}

ScreenData.QuestLog =
{
	ItemStartX = 710,
	ItemStartY = 260,
	EntryYSpacer = 52,
	ItemsPerPage = 12,
	ScrollOffset = 0,
}