OnslaughtData =
{
	BaseOnslaught =
	{
		DebugOnly = true,

		RoomOverrides =
		{
			EntranceFunctionName = "RoomEntrancePortal",
			ForcedRewardStore = "MetaProgress",
			EligibleRewards = { "RoomRewardMetaPointDrop", "RoomRewardMetaPointDropRunProgress", },
			ChallengeSpawnChance = 0.0,
			WellShopSpawnChance = 0.0,
			SecretSpawnChance = 0.0,
			ShrinePointDoorSpawnChance = 0.0,
			IgnoreMetaPointMultiplier = true,
			RewardConsumableOverrides =
			{
				AddResources =
				{
					MetaPoints = 200,
				},
			},
		},
	},

	Onslaught_StayBack =
	{
		InheritFrom = { "BaseOnslaught" },

		WeaponName = "ShieldWeapon",
		TraitNames =
		{
			-- Daedalus
			"ShieldThrowFastTrait",
			-- Boons
			"PoseidonWeaponTrait",
			"DionysusSecondaryTrait",
			-- Chaos
			"ChaosCurseMoveSpeedTrait",
		},
		RunOverrides =
		{
			ExitsReadyFunctionName = "OnslaughtVictory",
			DeathFunctionName = "OnslaughtDeath",
			MetaUpgrades =
			{
				-- Mirror
				HealthMetaUpgrade = 10,
				-- Pact
				EnemyHealthShrineUpgrade = 10,
				EnemyDamageShrineUpgrade = 50,
			},
		},
		Encounter =
		{
			InheritFrom = { "BaseOnslaught", },
			SpawnWaves =
			{
				-- wave 1
				{
					Spawns =
					{
						{ Name = "HeavyMelee", TotalCount = 10, },
					},
				},
				-- wave 2
				{
					Spawns =
					{
						{ Name = "BloodlessNaked", TotalCount = 10, },
					},
				},
				-- wave 3
				{
					Spawns =
					{
						{ Name = "PunchingBagUnit", TotalCount = 10, },
					},
				},
				-- wave 4
				{
					Spawns =
					{
						{ Name = "HeavyMelee", TotalCount = 10, },
						{ Name = "BloodlessNaked", TotalCount = 10, },
						{ Name = "PunchingBagUnit", TotalCount = 10, },
					},
				},
			},
		},
		RoomName = "B_Combat02",
	},

	Onslaught_DeadRising =
	{
		InheritFrom = { "BaseOnslaught" },

		WeaponName = "GunWeapon",
		TraitNames =
		{
			-- Daedalus
			"GunMinigunTrait",
			-- Boons
			"AthenaWeaponTrait",
			"AthenaWeaponTrait",
			"AthenaWeaponTrait",
			"AthenaWeaponTrait",
			"AthenaWeaponTrait",
			-- Chaos
		},
		RunOverrides =
		{
			ExitsReadyFunctionName = "OnslaughtVictory",
			DeathFunctionName = "OnslaughtDeath",
			MetaUpgrades =
			{
				-- Mirror
				StaminaMetaUpgrade = 2,
				-- Pact
				--EnemySpeedShrineUpgrade = 10,
			},
		},
		Encounter =
		{
			InheritFrom = { "BaseOnslaught", },
			SpawnWaves =
			{
				-- wave 1
				{
					Spawns =
					{
						{ Name = "BloodlessNaked", TotalCount = 12, },
					},
				},
				-- wave 2
				{
					Spawns =
					{
						{ Name = "BloodlessNakedElite", TotalCount = 6, },
					},
				},
				-- wave 3
				{
					Spawns =
					{
						{ Name = "BloodlessNaked", TotalCount = 12, },
						{ Name = "BloodlessNakedElite", TotalCount = 6, },
					},
				},
			},
		},
		RoomName = "A_Combat12",
	},

	Onslaught_Doom =
	{
		InheritFrom = { "BaseOnslaught" },

		WeaponName = "GunWeapon",
		TraitNames =
		{
			-- Daedalus
			"GunShotgunTrait",
			-- Boons
			"PoseidonRangedTrait",
			"PoseidonRangedTrait",
			"PoseidonRangedTrait",
			"MoreAmmoTrait",
			"MoreAmmoTrait",
			-- Chaos
		},
		RunOverrides =
		{
			ExitsReadyFunctionName = "OnslaughtVictory",
			DeathFunctionName = "OnslaughtDeath",
			MetaUpgrades =
			{
				-- Mirror
				AmmoMetaUpgrade = 2,
				-- Pact
				--EnemySpeedShrineUpgrade = 10,
			},
		},
		Encounter =
		{
			InheritFrom = { "BaseOnslaught", },
			SpawnWaves =
			{
				-- wave 1
				{
					Spawns =
					{
						{ Name = "Swarmer", TotalCount = 30, },
					},
				},
				-- wave 2
				{
					Spawns =
					{
						{ Name = "Swarmer", TotalCount = 30, },
						{ Name = "SwarmerElite", TotalCount = 15, },
					},
				},
				-- wave 3
				{
					Spawns =
					{
						{ Name = "Swarmer", TotalCount = 30, },
						{ Name = "SwarmerElite", TotalCount = 15, },
						{ Name = "LightSpawner", TotalCount = 6, },
					},
				},
				-- wave 4
				{
					Spawns =
					{
						{ Name = "Swarmer", TotalCount = 30, },
						{ Name = "SwarmerElite", TotalCount = 15, },
						{ Name = "LightSpawner", TotalCount = 6, },
						{ Name = "LightSpawnerElite", TotalCount = 3, },
					},
				},
			},
		},
		RoomName = "B_Combat21",
	},


	Onslaught_Deflector01 =
	{
		InheritFrom = { "BaseOnslaught" },

		WeaponName = "SwordWeapon",
		TraitNames =
		{
			-- Daedalus
			"SwordTwoComboTrait",
			-- Boons
			"AthenaWeaponTrait",
			"AthenaRangedTrait",
			"AthenaSecondaryTrait",
			"AthenaRushTrait",
			-- Well
			"TemporaryMoveSpeedTrait",
		},
		RunOverrides =
		{
			ExitsReadyFunctionName = "OnslaughtVictory",
			DeathFunctionName = "OnslaughtDeath",
			MetaUpgrades =
			{
				-- Mirror
				BackstabMetaUpgrade = 5,
				StaminaMetaUpgrade = 3,
				AmmoMetaUpgrade = 4,
				-- Pact
				EnemySpeedShrineUpgrade = 5,
				EnemyDamageShrineUpgrade = 25,
			},
		},
		Encounter =
		{
			InheritFrom = { "BaseOnslaught", },
			SpawnWaves =
			{
				-- wave 1
				{
					Spawns =
					{
						{ Name = "LightRanged", TotalCount = 20, },
					},
				},
				-- wave 2
				{
					Spawns =
					{
						{ Name = "LightRangedElite", TotalCount = 12, },
					},
				},
				-- wave 3
				{
					Spawns =
					{
						{ Name = "SpreadShotUnit", TotalCount = 10, },
						{ Name = "SpreadShotUnitElite", TotalCount = 10, },
					},
				},
			},
		},
		RoomName = "A_Combat17",
	},
	Onslaught_Horde01 =
	{
		InheritFrom = { "BaseOnslaught" },

		WeaponName = "GunWeapon",
		TraitNames =
		{
			-- Daedalus
			"GunMinigunTrait",
			-- Boons
			"PoseidonWeaponTrait",
			"PoseidonWeaponTrait",
			"PoseidonWeaponTrait",
			"PoseidonWeaponTrait",
			"DionysusRangedTrait",
			"DionysusRangedTrait",
			"PoseidonSecondaryTrait",
			"PoseidonSecondaryTrait",
			-- Chaos
			"ChaosCurseDashAttackTrait",
		},
		RunOverrides =
		{
			ExitsReadyFunctionName = "OnslaughtVictory",
			DeathFunctionName = "OnslaughtDeath",
			MetaUpgrades =
			{
				-- Mirror
				-- StoredAmmoVulnerabilityMetaUpgrade = 4,
				AmmoMetaUpgrade = 2,
				-- BackstabMetaUpgrade = 5,
				-- HealthMetaUpgrade = 5,

				-- Pact
				-- EnemySpeedShrineUpgrade = 5,
				-- EnemyDamageShrineUpgrade = 25,
				-- EnemyHealthShrineUpgrade = 10,
				-- EnemyShieldShrineUpgrade = 3,
			},
		},
		Encounter =
		{
			InheritFrom = { "BaseOnslaught", },
			SpawnWaves =
			{
				-- wave 1
				{
					Spawns =
					{
						{ Name = "HeavyMelee", TotalCount = 10, },
					},
				},
				-- wave 2
				{
					Spawns =
					{
						{ Name = "HeavyMelee", TotalCount = 8, },
						{ Name = "PunchingBagUnit", TotalCount = 4, },
					},
				},
				-- wave 3
				{
					Spawns =
					{
						{ Name = "HeavyMelee", TotalCount = 6, },
						{ Name = "HeavyMeleeElite", TotalCount = 4, },
						{ Name = "PunchingBagUnit", TotalCount = 3, },
						{ Name = "PunchingBagUnitElite", TotalCount = 2, },
					},
				},
			},
		},
		RoomName = "A_Combat16",
	},

	Onslaught_MedusaClash01 =
	{
		InheritFrom = { "BaseOnslaught" },

		WeaponName = "ShieldWeapon",
		TraitNames =
		{
			-- Daedalus
			"ShieldThrowFastTrait",
			-- Boons
			"ZeusWeaponTrait",
			"ZeusWeaponTrait",
			"ZeusWeaponTrait",
			"ZeusWeaponTrait",
			"ZeusSecondaryTrait",
			"ZeusSecondaryTrait",
			"ZeusSecondaryTrait",
			"ZeusSecondaryTrait",
			"ZeusRushTrait",
			"ZeusRushTrait",
			"ZeusRushTrait",
			"ZeusRushTrait",
			-- "AphroditeShoutTrait",
			-- "AphroditeShoutTrait",
			-- "AphroditeShoutTrait",
			-- Chaos
			"ChaosCurseCastAttackTrait",
		},
		RunOverrides =
		{
			ExitsReadyFunctionName = "OnslaughtVictory",
			DeathFunctionName = "OnslaughtDeath",
			MetaUpgrades =
			{
				-- Mirror
				StaminaMetaUpgrade = 1,
				-- StoredAmmoVulnerabilityMetaUpgrade = 4,
				-- AmmoMetaUpgrade = 2,
				BackstabMetaUpgrade = 10,
				-- HealthMetaUpgrade = 5,

				-- Pact
				-- EnemySpeedShrineUpgrade = 5,
				-- EnemyDamageShrineUpgrade = 5,
				-- EnemyHealthShrineUpgrade = 10,
				EnemyShieldShrineUpgrade = 1,
			},
		},
		Encounter =
		{
			InheritFrom = { "BaseOnslaught", },
			SpawnWaves =
			{
				-- wave 1
				{
					Spawns =
					{
						{ Name = "FreezeShotUnit", TotalCount = 10, },
					},
				},
				-- wave 2
				{
					Spawns =
					{
						{ Name = "FreezeShotUnit", TotalCount = 8, },
						{ Name = "FreezeShotUnitElite", TotalCount = 6, },
					},
				},
				-- wave 3
				{
					Spawns =
					{
						{ Name = "HitAndRunUnit", TotalCount = 1, },
						{ Name = "FreezeShotUnit", TotalCount = 6, },
						{ Name = "FreezeShotUnitElite", TotalCount = 4, },
					},
				},
			},
		},
		RoomName = "A_Combat19",
	},

	Onslaught_RainingDeath01 =
	{
		InheritFrom = { "BaseOnslaught" },

		WeaponName = "BowWeapon",
		TraitNames =
		{
			-- Daedalus
			"BowSlowChargeDamageTrait",
			-- Boons
			"AresWeaponTrait",
			"AresWeaponTrait",
			"AresWeaponTrait",
			"AresWeaponTrait",
			"AresRangedTrait",
			"AresRangedTrait",
			"AresRangedTrait",
			"AresRangedTrait",
			"AresSecondaryTrait",
			"AresSecondaryTrait",
			"AresSecondaryTrait",
			"AresSecondaryTrait",
			"AresRushTrait",
			"AresRushTrait",
			"AresRushTrait",
			"AresRushTrait",
			-- "AphroditeShoutTrait",
			-- "AphroditeShoutTrait",
			-- "AphroditeShoutTrait",
			-- Chaos
		},
		RunOverrides =
		{
			ExitsReadyFunctionName = "OnslaughtVictory",
			DeathFunctionName = "OnslaughtDeath",
			MetaUpgrades =
			{
				-- Mirror
				StaminaMetaUpgrade = 2,
				-- StoredAmmoVulnerabilityMetaUpgrade = 4,
				AmmoMetaUpgrade = 2,
				BackstabMetaUpgrade = 5,
				-- HealthMetaUpgrade = 5,

				-- Pact
				-- EnemySpeedShrineUpgrade = 5,
				-- EnemyDamageShrineUpgrade = 50,
				-- EnemyHealthShrineUpgrade = 10,
				-- EnemyShieldShrineUpgrade = 1,
			},
		},
		Encounter =
		{
			InheritFrom = { "BaseOnslaught", },
			SpawnWaves =
			{
				-- wave 1
				{
					Spawns =
					{
						{ Name = "BloodlessNaked", TotalCount = 8, },
						{ Name = "CrusherUnit", TotalCount = 1, },
					},
				},
				-- wave 2
				{
					Spawns =
					{
						{ Name = "BloodlessNaked", TotalCount = 4, },
						{ Name = "BloodlessNakedElite", TotalCount = 4, },
						{ Name = "BloodlessWaveFist", TotalCount = 2, },
						{ Name = "CrusherUnit", TotalCount = 1, },
					},
				},
				-- wave 3
				{
					Spawns =
					{
						{ Name = "BloodlessNaked", TotalCount = 6, },
						{ Name = "BloodlessNakedElite", TotalCount = 4, },
						{ Name = "BloodlessWaveFistElite", TotalCount = 2, },
						{ Name = "CrusherUnitElite", TotalCount = 1, },
					},
				},
			},
		},
		RoomName = "A_Combat13",
	},

	Onslaught_DrunkenSpear01 =
	{
		InheritFrom = { "BaseOnslaught" },

		WeaponName = "SpearWeapon",
		TraitNames =
		{
			-- Daedalus
			"SpearSpinDamageRadius",
			-- Boons
			"DionysusWeaponTrait",
			"DionysusWeaponTrait",
			"DionysusWeaponTrait",
			"DionysusWeaponTrait",
			"AphroditeRangedTrait",
			"AphroditeRangedTrait",
			"AphroditeRangedTrait",
			"AphroditeRangedTrait",
			"DionysusSecondaryTrait",
			-- "DionysusSpreadTrait",
			"DionysusRushTrait",
			"DionysusRushTrait",
			"DionysusRushTrait",
			"DionysusRushTrait",
			-- Chaos
		},
		RunOverrides =
		{
			ExitsReadyFunctionName = "OnslaughtVictory",
			DeathFunctionName = "OnslaughtDeath",
			MetaUpgrades =
			{
				-- Mirror
				StaminaMetaUpgrade = 1,
				StoredAmmoVulnerabilityMetaUpgrade = 5,
				AmmoMetaUpgrade = 1,
				BackstabMetaUpgrade = 5,
				-- HealthMetaUpgrade = 5,

				-- Pact
				EnemySpeedShrineUpgrade = 2,
				EnemyDamageShrineUpgrade = 10,
				-- EnemyHealthShrineUpgrade = 10,
				-- EnemyShieldShrineUpgrade = 1,
			},
		},
		Encounter =
		{
			InheritFrom = { "BaseOnslaught", },
			SpawnWaves =
			{
				-- wave 1
				{
					Spawns =
					{
						{ Name = "ThiefMineLayer", TotalCount = 2, },
						{ Name = "HeavyMelee", TotalCount = 6, },
						{ Name = "HeavyRanged", TotalCount = 2, },
					},
				},
				-- wave 2
				{
					Spawns =
					{
						{ Name = "ThiefMineLayer", TotalCount = 1, },
						{ Name = "ThiefMineLayerElite", TotalCount = 1, },
						{ Name = "HeavyMelee", TotalCount = 3, },
						{ Name = "HeavyMeleeElite", TotalCount = 3, },
						{ Name = "HeavyRanged", TotalCount = 1, },
						{ Name = "HeavyRangedElite", TotalCount = 1, },
					},
				},
				-- wave 3
				{
					Spawns =
					{
						{ Name = "ThiefMineLayerElite", TotalCount = 2, },
						{ Name = "HeavyMeleeElite", TotalCount = 6, },
						{ Name = "HeavyRangedElite", TotalCount = 2, },
					},
				},
			},
		},
		RoomName = "A_Combat05",
	},

}

OnslaughtRotationData =
{
	"Onslaught_DeadRising",
	"Onslaught_Doom",
	"Onslaught_StayBack",
	"Onslaught_Deflector01",
	"Onslaught_Horde01",
	"Onslaught_MedusaClash01",
	"Onslaught_RainingDeath01",
	"Onslaught_DrunkenSpear01",
}