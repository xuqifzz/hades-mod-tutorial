MetaUpgradeData =
{
	BaseMetaUpgrade =
	{
		UsePromptOffsetX = 60,
		UsePromptOffsetY = 15,
		ResourceName = "LockKeys",
		UnlockCost = 10,
	},

	HealthMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_StartingHealth",
		RequiredAccumulatedMetaPoints = 200,
		Starting = true,
		CostTable = { 40, 45, 50, 55, 60, 65, 70, 75, 80, 85 },
		ShortTotal = "HealthMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "HealthMetaUpgrade_ShortTotalNoIcon",
		ChangeValue = 5,
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				ChangeValue = 5,
				ChangeType = "Add",
			},
		}
	},

	HighHealthDamageMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_HighHealthDamage",
		RequiredAccumulatedMetaPoints = 200,
		Starting = true,
		CostTable = { 50, 100, 150, 200, 250 },
		ShortTotal = "HighHealthDamageMetaUpgrade_ShortTotal",
		ChangeValue = 1.05,
		DisplayValue = 80, -- display variable to show the health threshold
		FormatAsPercent = true,
		AddOutgoingDamageModifiers =
		{
			HighHealthSourceMultiplierData = { Threshold = 0.8, Multiplier = 1.05 },
		}
	},

	HealthEncounterEndRegenMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Skip = true,
		RequiredAccumulatedMetaPoints = 75,
		ResourceName = "LockKeys",
		UnlockCost = 3,
		CostTable = { 25, 75, 150, 500 },
		ShortTotal = "HealthEncounterEndRegenMetaUpgrade_ShortTotal",
		ChangeValue = 10,
	},

	DoorHealMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_DoorHeal",
		Starting = true,
		CostTable = { 10, 20, 40 },
		ShortTotal = "DoorHealMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "DoorHealMetaUpgrade_ShortTotalNoIcon",
		ChangeValue = 1,
	},

	DarknessHealMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_DarknessHeal",
		Starting = true,
		CostTable = { 30, 60 },
		ShortTotal = "DarknessHealMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "DarknessHealMetaUpgrade_ShortTotalNoIcon",
		FormatAsPercent = true,
		ChangeValue = 1.3,
	},

	HealthDropMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Skip = true,
		RequiredAccumulatedMetaPoints = 200,
		CostTable = { 50, 100, 150, 200, 300 },
		ShortTotal = "HealthDropMetaUpgrade_ShortTotal",
		ChangeValue = 1.01,
		FormatAsPercent = true,
	},

	WeaponDamageMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Skip = true,
		Cost = 10,
		CostIncreaseInterval = 1,
		CostIncrease = 10,
		ShortTotal = "WeaponDamageMetaUpgrade_ShortTotal",
		PropertyChanges =
		{
			{
				WeaponNames = WeaponSets.HeroPhysicalWeapons,
				ProjectileProperty = "DamageLow",
				ChangeValue = 1.10,
				ChangeType = "MultiplyBase",
			},
			{
				WeaponNames = WeaponSets.HeroPhysicalWeapons,
				ProjectileProperty = "DamageHigh",
				ChangeValue = 1.10,
				ChangeType = "MultiplyBase",
			},
		},

	},

	DashAttackMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		ResourceName = "LockKeys",
		UnlockCost = 3,
		CostTable = { 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 },
		Skip = true,
		ShortTotal = "DashAttackMetaUpgrade_ShortTotal",
		ReapplyOnWeaponSwitch = true,
		ChangeValue = 1.10,
		FormatAsPercent = true,
		PropertyChanges =
		{
			{
				WeaponName = "SwordWeaponDash",
				ProjectileProperty = "DamageAddition",
				ChangeValue = 1,
				ChangeType = "Add",
			},
			{
				WeaponName = "ShieldWeaponDash",
				ProjectileProperty = "DamageAddition",
				ChangeValue = 2,
				ChangeType = "Add",
			},
			{
				WeaponName = "SpearWeaponDash",
				ProjectileProperty = "DamageAddition",
				ChangeValue = 1.5,
				ChangeType = "Add",
			},
			{
				WeaponName = "BowWeaponDash",
				ProjectileProperty = "DamageAddition",
				ChangeValue = 3,
				ChangeType = "Add",
			},
		},
	},

	AmmoMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_AmmoSupply",
		Starting = true,
		Cost = 10,
		CostTable = { 20, 80 },
		ShortTotal = "AmmoMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "AmmoMetaUpgrade_ShortTotalNoIcon",
		KeywordOverrides =
		{
			{
				Key = "Cast",
				Value = "Cast",
			},
			{
				Key = "Ammo",
				Value = "Ammo",
			}
		},
		PropertyChanges =
		{
			{
				WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
				WeaponProperty = "MaxAmmo",
				ChangeValue = 1,
				ChangeType = "Add",
			},
		},
	},

	ReloadAmmoMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_ReloadAmmo",
		Starting = true,
		Cost = 10,
		CostTable = { 60, 120 },
		KeywordOverrides =
		{
			{
				Key = "Cast",
				Value = "CastAlt",
			},
			{
				Key = "Ammo",
				Value = "AmmoAlt",
			}
		},
		BaseValue = 5,
		ShortTotal = "ReloadAmmoMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "ReloadAmmoMetaUpgrade_ShortTotalNoIcon",
		ChangeValue = -1,
	},

	StaminaMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_DashCharges",
		Starting = true,
		CostTable = { 50 },
		ShortTotal = "StaminaMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "StaminaMetaUpgrade_ShortTotalNoIcon",
		HelpTextTable =
		{
			[0] = "StaminaMetaUpgrade_Off",
			[1] = "StaminaMetaUpgrade_On",
		},
		PropertyChanges =
		{
			{
				WeaponNames = WeaponSets.HeroRushWeapons,
				WeaponProperty = "ClipSize",
				ChangeValue = 1,
				ChangeType = "Add",
			},
		},
	},

	PerfectDashMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_PerfectDash",
		Starting = true,
		CostTable = { 75 },
		ShortTotal = "PerfectDashMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "PerfectDashMetaUpgrade_ShortTotalNoIcon",
		PreEquipWeapon = "PerfectDashEmpowerApplicator",
		ChangeValue = 1.5, -- display variable, change below value to affect gameplay
		DisplayValue = 2, -- display variable used to display duration of buff
		PropertyChanges =
		{
			{
				WeaponName = "PerfectDashEmpowerApplicator",
				EffectName = "PerfectDashDamageBonus",
				EffectProperty = "Modifier",
				ChangeValue = 0.5,
				ChangeType = "Add",
			},
		},
		HelpTextTable =
		{
			[0] = "PerfectDashMetaUpgrade_Off",
			[1] = "PerfectDashMetaUpgrade_On",
		},

	},

	BackstabMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_SneakAttack",
		Starting = true,
		CostTable = { 10, 15, 20, 25, 30 },
		ShortTotal = "BackstabMetaUpgrade_ShortTotal",
		ChangeValue = 1.1,
		FormatAsPercent = true,
		AddOutgoingDamageModifiers =
		{
			HitVulnerabilityMultiplier = 1.1,
		}
	},
	FirstStrikeMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_FirstStrike",
		Starting = true,
		CostTable = { 10, 15, 20, 25, 30 },
		ShortTotal = "FirstStrikeMetaUpgrade_ShortTotal",
		ChangeValue = 1.15,
		FormatAsPercent = true,
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			HitMaxHealthMultiplier = 1.15,
		}
	},

	StoredAmmoVulnerabilityMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_AmmoVulnerability",
		Starting = true,
		CostTable = { 10, 30, 50, 70, 90 },
		Color = { 255, 255, 255, 255 },
		ShortTotal = "StoredAmmoVulnerabilityMetaUpgrade_ShortTotal",
		ChangeValue = 1.1,
		FormatAsPercent = true,
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			StoredAmmoMultiplier = 1.1,
		}
	},
	StoredAmmoSlowMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_UnstoredAmmoVulnerability",
		Starting = true,
		CostTable = { 20, 40, 60, 80, 100 },
		Color = { 255, 255, 255, 255 },
		ShortTotal = "StoredAmmoSlowMetaUpgrade_ShortTotal",
		FormatAsPercent = true,
		PreEquipWeapon = "StoredAmmoSlowApplicator",
		ChangeValue = 1.06, -- display variable, change below value to affect gameplay
		PropertyChanges =
		{
			{
				WeaponName = "StoredAmmoSlowApplicator",
				EffectName = "StoredAmmoSlowReduceDamageOutput",
				EffectProperty = "Modifier",
				ChangeValue = -0.06,
				ChangeType = "Add",
			},
			{
				WeaponName = "StoredAmmoSlowApplicator",
				EffectName = "StoredAmmoSlow",
				EffectProperty = "Modifier",
				ChangeValue = -0.06,
				ChangeType = "Add",
			},
		},

	},

	UnstoredAmmoVulnerabilityMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_UnstoredAmmoVulnerability",
		Starting = true,
		CostTable = { 10, 30, 50, 70, 90 },
		Color = { 255, 255, 255, 255 },
		ShortTotal = "UnstoredAmmoVulnerabilityMetaUpgrade_ShortTotal",
		ChangeValue = 1.1,
		FormatAsPercent = true,
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroNonPhysicalWeapons,
			UnstoredAmmoMultiplier = 1.1,
		}
	},

	VulnerabilityEffectBonusMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_EffectVulnerability",
		Starting = true,
		CostTable = { 50, 500 },
		Color = { 255, 255, 255, 255 },
		ShortTotal = "VulnerabilityEffectBonusMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "VulnerabilityEffectBonusMetaUpgrade_ShortTotalNoIcon",
		ChangeValue = 1.20,
		FormatAsPercent = true,
		AddOutgoingDamageModifiers =
		{
			MinRequiredVulnerabilityEffects = 2,
			PerVulnerabilityEffectAboveMinMultiplier = 1.20,
		}
	},

	GodEnhancementMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_GodEnhancement",
		Starting = true,
		CostTable = { 50, 150 },
		Color = { 255, 255, 255, 255 },
		ShortTotal = "GodEnhancementMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "GodEnhancementMetaUpgrade_ShortTotalNoIcon",
		InRunTooltip = "GodEnhancementMetaUpgrade_InRun",
		InRunValueFunctionName = "GetTotalGodEnhancement",
		ChangeValue = 1.025,
		DecimalPlaces = 1,
		AddOutgoingDamageModifiers =
		{
			PerUniqueGodMultiplier = 1.025,
		}
	},

	ExtraChanceMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_ExtraChance",
		Starting = true,
		CostTable = { 30, 500, 1000 },
		Color = { 255, 255, 255, 255 },
		ShortTotal = "ExtraChanceMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "ExtraChanceMetaUpgrade_ShortTotalNoIcon",
		ChangeValue = 1,
		KeywordOverride =
		{
			Key = "ExtraChance",
			Value = "ExtraChance",
		},
	},


	ExtraChanceWrathMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_ExtraChance",
		Starting = true,
		CostTable = { 30, 500, 1000 },
		Color = { 255, 255, 255, 255 },
		ShortTotal = "ExtraChanceWrathMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "ExtraChanceWrathMetaUpgrade_ShortTotalNoIcon",
		ChangeValue = 1,
	},

	ExtraChanceReplenishMetaUpgrade=
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_ExtraChanceReplenish",
		Starting = true,
		CostTable = { 600 },
		Color = { 255, 255, 255, 255 },
		ShortTotal = "ExtraChanceReplenishMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "ExtraChanceReplenishMetaUpgrade_ShortTotalNoIcon",
		ChangeValue = 1,
		HealPercent = 0.3,
		KeywordOverride =
		{
			Key = "ExtraChance",
			Value = "ExtraChanceAlt",
		},
		HelpTextTable =
		{
			[0] = "ExtraChanceReplenishMetaUpgrade_Off",
			[1] = "ExtraChanceReplenishMetaUpgrade_On",
		},
	},

	RallyMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Skip = true,
		RequiredAccumulatedMetaPoints = 200,
		ResourceName = "LockKeys",
		UnlockCost = 6,
		CostTable = { 40, 60, 100, 200 },
		ShortTotal = "RallyMetaUpgrade_ShortTotal",
		ChangeValue = 1.15,
		FormatAsPercent = true,
	},

	MoneyMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_StartingMoney",
		RequiredAccumulatedMetaPoints = 120,
		Starting = true,
		CostTable = { 30, 35, 40, 45, 50, 55, 60, 65, 70, 75 },
		ShortTotal = "MoneyMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "MoneyMetaUpgrade_ShortTotalNoIcon",
		ChangeValue = 10,
	},

	InterestMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_Interest",
		RequiredAccumulatedMetaPoints = 120,
		Starting = true,
		CostTable = { 70, 90, 110 },
		ShortTotal = "InterestMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "InterestMetaUpgrade_ShortTotalNoIcon",
		ChangeValue = 1.05,
	},

	RareBoonDropMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_RareBoonChance",
		RequiredAccumulatedMetaPoints = 500,
		Starting = true,
		Cost = 50,
		MaxInvestment = 40,
		ShortTotal = "RareBoonDropMetaUpgrade_ShortTotal",
		ChangeValue = 1.01,
	},

	EpicBoonDropMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_EpicBoonChance",
		RequiredAccumulatedMetaPoints = 1000,
		Starting = true,
		Cost = 100,
		MaxInvestment = 20,
		ShortTotal = "EpicBoonDropMetaUpgrade_ShortTotal",
		ChangeValue = 1.01,
	},

	DuoRarityBoonDropMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_DuoRarityBoon",
		Starting = true,
		Cost = 250,
		MaxInvestment = 10,
		ShortTotal = "DuoRarityBoonDropMetaUpgrade_ShortTotal",
		ChangeValue = 1.01,
	},

	EpicHeroicBoonMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_EpicHeroicBoon",
		Starting = true,
		Cost = 250,
		MaxInvestment = 10,
		ShortTotal = "EpicHeroicBoonMetaUpgrade_ShortTotal",
		ChangeValue = 1.01,
	},

	RunProgressRewardMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_EpicHeroicBoon",
		Starting = true,
		Cost = 150,
		MaxInvestment = 10,
		ShortTotal = "RunProgressRewardMetaUpgrade_ShortTotal",
		ChangeValue = 1.02,
	},

	RerollMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_Reroll",
		Starting = true,
		OldRevision = 35402,
		OldCostTable = { 500, 1000, 2000, 3000, 4000, 5000, 10000, 20000, 30000, 40000 },
		CostTable = { 500, 750, 1000, 1250, 1500, 1750, 2000, 2250 },
		ShortTotal = "RerollMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "RerollMetaUpgrade_ShortTotalNoIcon",
		ChangeValue = 1,
	},

	RerollPanelMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "MirrorIcon_RerollPanel",
		Starting = true,
		OldRevision = 32686,
		OldCostTable = { 1000, 5000, 10000, 25000 },
		CostTable = { 1000, 2000, 3000, 4000 },
		ShortTotal = "RerollPanelMetaUpgrade_ShortTotal",
		ShortTotalNoIcon = "RerollPanelMetaUpgrade_ShortTotalNoIcon",
		ChangeValue = 1,
	},

	LimitMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Skip = true,
		Cost = 1,
		CostIncreaseInterval = 1,
		CostIncrease = 1,
		ShortTotal = "LimitMetaUpgrade_ShortTotal",
		ChangeValue = 1.02,
	},

	SpeedMetaUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Skip = true,
		Cost = 50,
		CostIncreaseInterval = 1,
		CostIncrease = 50,
		ShortTotal = "SpeedMetaUpgrade_ShortTotal",
		PropertyChanges =
		{
			{
				UnitProperty = "Speed",
				ChangeValue = 100,
				ChangeType = "Add",
			},
		},
	},

	-- Shrine/Difficulty/Heat MetaUpgrades
	MetaPointCapShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_DarknessCap",
		Starting = true,
		CostTable = { 1, 1, 1, 1, 1 },
		--CostTable = { 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 },
		NoPointsHelpTextId = "MetaPointCapShrineUpgrade_NoPoints",
		ShortTotal = "MetaPointCapShrineUpgrade_ShortTotal",
		BaseValue = 3000,
		ChangeValue = -500,
	},

	MetaUpgradeStrikeThroughShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_DarknessCap",
		Starting = true,
		CostTable = { 2, 2, 2, 2 },
		NoPointsHelpTextId = "MetaUpgradeStrikeThroughShrineUpgrade_NoPoints",
		ShortTotal = "MetaUpgradeStrikeThroughShrineUpgrade_ShortTotal",
		ChangeValue = -3,

		GameStateRequirements =
		{
			RequiredMetaUpgradeStageUnlocked = 4
		},
		DisablesMetaUpgrades = true, -- Alt name "MetaMetaUpgrade" rejected for being too confusing
	},
	HealingReductionShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_HealingReduction",
		Starting = true,
		CostTable = { 1, 1, 1, 1 },
		ShortTotal = "HealingReductionShrineUpgrade_ShortTotal",
		ShortTotalNoIcon = "HealingReductionShrineUpgrade_ShortTotalNoIcon",
		ChangeValue = 1.25,
	},

	ReducedLootChoicesShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_LockedChoice",
		Starting = true,
		CostTable = { 2, 3 },
		ShortTotal = "ReducedLootChoicesShrineUpgrade_ShortTotal",
		ChangeValue = 1,
	},

	ShopPricesShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_ShopPrices",
		Starting = true,
		Cost = 1,
		MaxInvestment = 2,
		ShortTotal = "ShopPricesShrineUpgrade_ShortTotal",
		ChangeValue = 1.4,
	},

	EnemyHealthShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_EnemyHealth",
		Starting = true,
		Cost = 1,
		MaxInvestment = 2,
		ShortTotal = "EnemyHealthShrineUpgrade_ShortTotal",
		ShortTotalNoIcon = "EnemyHealthShrineUpgrade_ShortTotalNoIcon",
		ChangeValue = 1.15,
	},

	EnemyDamageShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_EnemyDamage",
		Starting = true,
		Cost = 1,
		MaxInvestment = 5,
		ShortTotal = "EnemyDamageShrineUpgrade_ShortTotal",
		ChangeValue = 1.20,
	},

	TrapDamageShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_TrapDamage",
		Starting = true,
		Cost = 1,
		MaxInvestment = 1,
		ShortTotal = "EnemyDamageShrineUpgrade_ShortTotal",
		ChangeValue = 5,
		FormatAsPercent = true,
		HelpTextTable =
		{
			[0] = "TrapDamageShrineUpgrade_Off",
			[1] = "TrapDamageShrineUpgrade_On",
		},
	},

	EnemySpeedShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_EnemySpeed",
		Starting = true,
		Cost = 3,
		MaxInvestment = 2,
		ShortTotal = "EnemySpeedShrineUpgrade_ShortTotal",
		ChangeValue = 1.2,
		--ChangeValues = { 1.1, 1.25, 1.5 },
		--[[
		HelpTextTable =
		{
			[0] = "EnemySpeedShrineUpgrade_0",
			[1] = "EnemySpeedShrineUpgrade_1",
			[2] = "EnemySpeedShrineUpgrade_2",
			[3] = "EnemySpeedShrineUpgrade_3"
		},
		]]
	},

	EnemyShieldShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_ShieldHealth",
		Starting = true,
		CostTable = { 1, 1 },
		ShortTotal = "EnemyShieldShrineUpgrade_ShortTotal",
		ShortTotalNoIcon = "EnemyShieldShrineUpgrade_ShortTotalNoIcon",
		ChangeValue = 1,
	},

	EnemyCountShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_EnemyCount",
		Starting = true,
		CostTable = { 1, 1, 1 },
		ShortTotal = "EnemyCountShrineUpgrade_ShortTotal",
		ChangeValue = 1.20,
	},

	MinibossCountShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_MinibossCount",
		Starting = true,
		CostTable = { 2 },
		ShortTotal = "MinibossCountShrineUpgrade_ShortTotal",
		ShortTotalNoIcon = "MinibossCountShrineUpgrade_ShortTotalNoIcon",
		ChangeValue = 1,
		HelpTextTable =
		{
			[0] = "MinibossCountShrineUpgrade_Off",
			[1] = "MinibossCountShrineUpgrade_On",
		},
	},

	EnemyEliteShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_EnemyElites",
		Starting = true,
		CostTable = { 2, 3 },
		ShortTotal = "EnemyEliteShrineUpgrade_ShortTotal",
		ShortTotalNoIcon = "EnemyEliteShrineUpgrade_ShortTotalNoIcon",
		ChangeValue = 1,
	},

	ForceSellShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_ForceSell",
		Starting = true,
		CostTable = { 2 },
		ShortTotal = "ForceSellShrineUpgrade_ShortTotal",
		ChangeValue = 1,
		HelpTextTable =
		{
			[0] = "ForceSellShrineUpgrade_Off",
			[1] = "ForceSellShrineUpgrade_On",
		},
	},

	BossDifficultyShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_BossDifficulty",
		Starting = true,
		CostTable = { 1, 2, 3, 4 },
		ShortTotal = "BossDifficultyShrineUpgrade_ShortTotal",
		ChangeValue = 1,
		GameStateRequirements =
		{
			RequiredTextLines = { "Fury2FirstAppearance", "Fury3FirstAppearance" }
		},
		RankGameStateRequirements = 
		{
			[4] = { RequiredCosmetics = { "HadesEMFight"}}
		}
	},

	HarpyDifficultyShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Skip = true,
		CostTable = { 1, 1 },
		ShortTotal = "HarpyDifficultyShrineUpgrade_ShortTotal",
		ChangeValue = 1,
		GameStateRequirements =
		{
			RequiredTextLines = { "Fury2FirstAppearance", "Fury3FirstAppearance" }
		},
	},
	HydraDifficultyShrineUpgrade =
	{
		Skip = true,
		InheritFrom = { "BaseMetaUpgrade", },
		CostTable = { 1 },
		ShortTotal = "HydraDifficultyShrineUpgrade_ShortTotal",
		ChangeValue = 1,
	},


	HardEncounterShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Starting = true,
		CostTable = { 2, 2, 2 },
		ShortTotal = "HardEncounterShrineUpgrade_ShortTotal",
		ChangeValue = 1,
	},

	BiomeSpeedShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_BiomeSpeed",
		Starting = true,
		CostTable = { 1, 2, 3 },
		ShortTotal = "BiomeSpeedShrineUpgrade_ShortTotal",
		HelpTextTable =
		{
			[0] = "BiomeSpeedShrineUpgrade_0",
			[1] = "BiomeSpeedShrineUpgrade_1",
			[2] = "BiomeSpeedShrineUpgrade_2",
			[3] = "BiomeSpeedShrineUpgrade_3"
		},
		ChangeValue = 2,
		BaseValue = 9,
	},

	NoInvulnerabilityShrineUpgrade =
	{
		InheritFrom = { "BaseMetaUpgrade", },
		Icon = "ShrineIcon_NoInvulnerability",
		Starting = true,
		CostTable = { 1 },
		ShortTotal = "NoInvulnerabilityShrineUpgrade_ShortTotal",
		ChangeValue = 2,
		FormatAsPercent = true,
		HelpTextTable =
		{
			[0] = "NoInvulnerabilityShrineUpgrade_Off",
			[1] = "NoInvulnerabilityShrineUpgrade_On",
		},
		GameStateRequirements =
		{
			RequiredTrueFlags = { "HardMode", },
		},
	}
}

MetaUpgradeLockOrder =
{
	BaseUnlocked = 4,
	LockedSetsCount = 2,
	LockedSetCosts = { 5, 10, 20, 30 }
}

MetaUpgradeOrder =
{
	{ "BackstabMetaUpgrade", "FirstStrikeMetaUpgrade" },
	{ "DoorHealMetaUpgrade", "DarknessHealMetaUpgrade" },
	{ "ExtraChanceMetaUpgrade", "ExtraChanceReplenishMetaUpgrade" },
	{ "StaminaMetaUpgrade", "PerfectDashMetaUpgrade" },
	{ "StoredAmmoVulnerabilityMetaUpgrade", "StoredAmmoSlowMetaUpgrade" },
	{ "AmmoMetaUpgrade", "ReloadAmmoMetaUpgrade" },
	{ "MoneyMetaUpgrade", "InterestMetaUpgrade" },
	{ "HealthMetaUpgrade", "HighHealthDamageMetaUpgrade" },
	{ "VulnerabilityEffectBonusMetaUpgrade", "GodEnhancementMetaUpgrade" },
	{ "RareBoonDropMetaUpgrade", "RunProgressRewardMetaUpgrade" },
	{ "EpicBoonDropMetaUpgrade", "DuoRarityBoonDropMetaUpgrade" },
	{ "RerollMetaUpgrade", "RerollPanelMetaUpgrade" },
}

BiomeTimeLimits =
{
	ValidBiomes = { "Tartarus", "Asphodel", "Elysium", "Styx" },
	-- corresponds to BiomeList
	Penalty =
	{
		Damage = 5,
		Interval = 1,
	},
	Timers =
	{
		{ 0, 540, 540, 540, 540 },
		{ 0, 420, 420, 420, 420 },
		{ 0, 300, 300, 300, 300 },
	}
}

RerollCosts =
{
	Boon = 1,
	Shop = 1,
	SellTrait = 1,
	Hammer = -1, -- Disabled
	ReuseIncrement = 1,
}

ShrineUpgradeOrder =
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
	"NoInvulnerabilityShrineUpgrade",
}

ShrineClearData =
{
	ClearThreshold = 1,
	BossRoomNames = { "A_Boss", "B_Boss01", "C_Boss01", "D_Boss01" },
}