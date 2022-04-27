UnitSetData.Enemies =
{
	-- Top-level inheritance
	IsNeutral =
	{
		DamageType = "Neutral",
		TriggersOnDamageEffects = false,
		TriggersOnHitEffects = true,
		SkipModifiers = true,
		DropItemsOnDeath = false,
		BlockWrathGain = true,
		BlocksLootInteraction = false,
		SimulationSlowOnHit = false,
		UseShrineUpgrades = false,
		CanBeFrozen = false,
		AggroMinimumDistance = 500,
		SkipDamageText = true,
		HideLevelDisplay = true,
		BlockLifeSteal = true,
		NoComboPoints = true,
		IgnoreAutoLock = true,
	},

	BaseVulnerableEnemy =
	{
		HitInvulnerableText = "Combat_Invulnerable",
		Material = "Organic",
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamaged",
			Rapid = "HitSparkEnemyDamagedRapid",
		},
		InvulnerableHitFx = "InvincibleHitSpark",
		DamageType = "Enemy",

		TriggersOnDamageEffects = true,
		TriggersOnHitEffects = true,
		DropItemsOnDeath  = true,
		BlocksLootInteraction = true,
		SimulationSlowOnHit = true,
		UseShrineUpgrades = true,
		RequiredKill = true,
		AggroIfLastAlive = true,
		CanBeFrozen = true,
		AggroMinimumDistance = 500,
		AIAggroRange = 600,
		ChainAggroAllEnemies = true,
		CanStoreAmmo = true,

		HealthBufferedGripBonus = 0,
		HealthBufferedRegenAmount = 0.01,
		HealthBufferedRegenTick = 0.05,
		HealthBufferedRegenHitDelay = 1.0,

		AggroReactionTimeMin = 0.05,
		AggroReactionTimeMax = 0.2,
		PreSpawnAggroReactionTimeMin = 0.05,
		PreSpawnAggroReactionTimeMax = 0.45,
		NoTargetWanderDuration = 1.0,
		NoTargetWanderDistance = 200,

		MaxHitShields = 5,

		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.33,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
		IncomingDamageModifiers =
		{
			{
				Name = "BaseVulnerability",
				NonPlayerMultiplier = 8,
				Multiplicative = true,
			},
			{
				Name = "MineImmunity",
				ValidWeapons = {"BloodMineBlast","ImpulseMineBlast"},
				ValidWeaponMultiplier = 0,
				Multiplicative = true,
			},
		},
	},

	BaseBossEnemy =
	{
		IsBoss = true,
		UseBossHealthBar = true,
		IncomingDamageModifiers =
		{
			{
				Name = "BaseVulnerability",
				NonPlayerMultiplier = 2,
				Multiplicative = true,
			},
			{
				Name = "MineImmunity",
				ValidWeapons = {"BloodMineBlast","ImpulseMineBlast"},
				ValidWeaponMultiplier = 0,
				Multiplicative = true,
			},
		},
	},

	Elite =
	{
		IsElite = true,
		EliteIcon = true,

		EliteAttributeOptions = EnemySets.AllEliteAttributes,
		EliteAttributeData =
		{
			DeepInheritance = true,
			-- Blink: Teleports to a random spawn point every so often
			Blink =
			{
				AIDataOverrides =
				{
					TeleportToSpawnPoints = true,
					TeleportationIntervalMin = 5.5,
					TeleportationIntervalMax = 9.0,
					TeleportStartFx = "BlinkStart",
					TeleportEndFx = "BlinkEnd",
					TeleportPreWaitFx = "BlinkPreWait",
					PreTeleportWait = 0.5,
					PostTeleportWait = 0.2,
					AngleTowardsTeleportTarget = true,
				},
				RequiresFalseSuperElite = true,
				BlockAttributes = { "Beams" },
			},
			-- Frenzy: 50% enemy attack and move speed
			Frenzy =
			{
				DataOverrides =
				{
					EliteAdditionalSpeedMultiplier = 0.5,
					AttachedAnimationName = "EliteUnitStatus2"
				},
				BlockAttributes = { "Homing", "Vacuuming" },
			},
			-- HeavyArmor: 50% armor increase
			HeavyArmor =
			{
				DataOverrides =
				{
					HealthMultiplier = 1.5,
					HealthBarType = "ExtraLarge",
				},
				RequiresFalseSuperElite = true,
			},
			-- HeavyArmor: Passive Lava lob
			Molten =
			{
				RequireEncounterCompleted = "BossHarpy1", -- Require that you've been to Asphodel
				RequiredBiome = "Asphodel",
				AddDumbFireWeaponsOnSpawn = { "EliteLavaSplash" },
			},
			Homing =
			{
				WeaponPropertyChanges =
				{
					{
						ProjectileProperty = "Type",
						ChangeValue = "HOMING",
					},
					{
						ProjectileProperty = "AutoAdjustForTarget",
						ChangeValue = true,
					},
					{
						ProjectileProperty = "MaxAdjustRate",
						ChangeValue = math.rad(90),
						ChangeType = "Absolute",
					},
				},
				BlockAttributes = { "Frenzy" },
			},
			ExtraDamage =
			{
				DataOverrides =
				{
					AttachedAnimationName = "EliteUnitStatus"
				},
				WeaponPropertyChanges =
				{
					{
						ProjectileProperty = "DamageLow",
						ChangeValue = 2.0,
						ChangeType = "Multiply",
					},
					{
						ProjectileProperty = "DamageHigh",
						ChangeValue = 2.0,
						ChangeType = "Multiply",
					},
				}
			},
			Vacuuming =
			{
				AddDumbFireWeaponsOnSpawn = { "EliteVacuum" },
				BlockAttributes = { "Frenzy" },
			},
			-- Smoked: Passive smoke puff
			Smoked =
			{
				RequireEncounterCompleted = "BossHarpy1", -- Require that you've been to Asphodel
				AddDumbFireWeaponsOnSpawn = { "EliteSmoke" },
			},
			-- Smoked: Passive smoke puff
			Disguise =
			{
				RequiredBiome = "Tartarus",
				SkipApplyOnClones = true,
				DifficultyRatingMultiplier = 5.0,
				AddDumbFireWeaponsOnSpawn = { "EliteClones" },
				DataOverrides =
				{
					KillSpawnsOnDeath = true,
				},
				BlockAttributes = { "DeathSpreadHitShields" },
			},
			Beams =
			{
				AddDumbFireWeaponsOnSpawn = { "EliteBeams" },
				BlockAttributes = { "Blink" },
			},
			DeathSpreadHitShields =
			{
				DifficultyRatingMultiplier = 1.2,
				AddDumbFireWeaponsOnSpawn = { "EliteDeathAllyHitShields" },
				BlockAttributes = { "Disguise" },
			},
			MultiEgg =
			{
				AddEnemyOnDeathWeapons =
				{
					{
						Weapon = "EliteDeathMultiEgg"
					}
				},
			},
		},
	},

	SuperElite =
	{
		IsSuperElite = true,
	},

	-- WRETCH THUG
	BaseThug =
	{
		PreferredSpawnPoint = "EnemyPointMelee",
		MaxHealth = 160,
		HealthBarOffsetY = -230,
		HitSparkScale = 3.0,
		HitSparkOffsetZ = 175,

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/HeavyMelee/EmoteAlerted",

		LargeUnitCap = 3,
		Binks =
		{
			"EnemyWretchThugAttack_Bink",
			"EnemyWretchThugDeathVFX_Bink",
			"EnemyWretchThugIdle_Bink",
			"EnemyWretchThugOnHit_Bink",
			"EnemyWretchThugStart_Bink",
			"EnemyWretchThugWalk_Bink"
		},

		AIOptions =
		{
			AggroAI,
		},
		--AIAggroRange = 900,

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		MoneyDropGlobalVoiceLines = "SurvivalMoneyDropVoiceLines",
		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Wretches!
			{ Cue = "/VO/ZagreusField_0841" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Wretches.
			{ Cue = "/VO/ZagreusField_0840", RequiredPlayed = { "/VO/ZagreusField_0841" } },
			-- Wretches!
			{ Cue = "/VO/ZagreusField_0841" },
			-- More Wretches!
			{ Cue = "/VO/ZagreusField_0842", RequiredPlayed = { "/VO/ZagreusField_0841" } },
			-- More Wretches?
			{ Cue = "/VO/ZagreusField_0843", RequiredPlayed = { "/VO/ZagreusField_0841" } },
		},
	},

	HeavyMelee =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseThug" },
		GenusName = "HeavyMelee",

		Material = "Bone",

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveSuccessDistance = 125,
		},

		WeaponOptions =
		{
			"HeavyMelee",
		},

		GeneratorData =
		{
			DifficultyRating = 10,
			BlockEnemyTypes = {"HeavyMeleeElite", "HeavyMeleeSuperElite"}
		},
	},

	HeavyMeleeElite =
	{
		InheritFrom = { "Elite", "HeavyMelee" },

		HealthBuffer = 480,
		HealthBarType = "MediumLarge",

		RequiredMinBiomeDepth = 3,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		IsAggroedSound = "/SFX/Enemy Sounds/HeavyMelee/EmoteTaunting",

		WeaponOptions =
		{
			"HeavyMelee",
		},

		EliteAttributeData =
		{
			DeepInheritance = true,
			DoubleTap =
			{
				DataOverrides =
				{
					WeaponOptions =
					{
						"HeavyMeleeElite",
					}
				},
			},
		},

		GeneratorData =
		{
			DifficultyRating = 26,
			BlockEnemyTypes = {"HeavyMelee", "HeavyMeleeSuperElite"}
			--MaxCount = 3,
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	HeavyMeleeSuperElite =
	{
		InheritFrom = { "SuperElite", "Elite", "HeavyMeleeElite" },

		HealthBuffer = 1500,

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackAnimation = "EnemyWretchThugAttackChargeFast",
			PreAttackDuration = 0.2,
			PreFireAnimation = "EnemyWretchThugAttackChargeFast",
			PreFireDuration = 0.13,
			FireAnimation = "EnemyWretchThugAttackFireFast",
			FireDuration = 0.6,

			PostAttackDuration = 0.1,
		},

		WeaponOptions =
		{
			"HeavyMelee",
		},

		GeneratorData =
		{
			DifficultyRating = 100,
			BlockEnemyTypes = {"HeavyMelee", "HeavyMeleeElite"}
			--MaxCount = 3,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 4,
			Threshold = 0.85,
		},
	},

	WretchAssassin =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		PreferredSpawnPoint = "EnemyPointMelee",
		MaxHealth = 300,
		HealthBuffer = 700,
		HealthBarOffsetY = -225,

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveSuccessDistance = 125,
			PreAttackEndFunctionName = "EnemyHandleInvisibleAttack",
			PreAttackEndFunctionArgs = { CreateAnimation = "BlinkEnd_WretchAssassin" },

			InvisibilityFadeOutDuration = 0.45,
			InvisibilityFadeInDuration = 0.2,
		},

		WeaponOptions =
		{
			"WretchAssassinStab", "WretchAssassinRanged"
		},

		GeneratorData =
		{
			DifficultyRating = 7,
		},

		AIOptions =
		{
			AggroAI,
		},
		--AIAggroRange = 900,

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/WretchedShadeAssassin/EmoteAlerted",
		Binks =
		{
			"Enemy_WretchAssassin_Idle_Bink",
			"Enemy_WretchAssassin_Teleport_Bink",
			"Enemy_WretchAssassin_OnHit_Bink",
			"Enemy_WretchAssassinRange_Bink",
			"Enemy_WretchAssassinStab_Bink",
			"Enemy_WretchAssassin_DeathVFX_Bink",
		},
	},

	WretchAssassinMiniboss =
	{
		InheritFrom = { "BaseVulnerableEnemy", "WretchAssassin" },
	},

	WretchAssassinMinibossSuperElite =
	{
		InheritFrom = { "SuperElite", "WretchAssassin" },
		MaxHealth = 1000,
		HealthBuffer = 2000,

		GeneratorData =
		{
			DifficultyRating = 500,
			BlockSolo = true,
			BlockEnemyTypes = {"WretchAssassinMiniboss"},
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},
	},

	DisembodiedHand =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		PreferredSpawnPoint = "EnemyPointMelee",
		MaxHealth = 140,
		HealthBarOffsetY = -200,
		HitSparkScale = 2.0,
		HitSparkOffsetZ = 175,

		Groups = { "FlyingEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/Wringer/WringerAlerted",

		Material = "Organic",

		RequiredSeenEncounter = "BossHades",
		RequiredIntroEncounter = "DisembodiedHandIntro",

		DefaultAIData =
		{
			DeepInheritance = true,

		},

		WeaponOptions =
		{
			"DisembodiedHandGrab",
		},

		GeneratorData =
		{
			DifficultyRating = 11,
			BlockEnemyTypes = {"DisembodiedHandElite", "DisembodiedHandSuperElite"}
		},

		AIOptions =
		{
			AggroAI,
		},
		--AIAggroRange = 900,

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},
		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Wringers!
			{ Cue = "/VO/ZagreusField_3693" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_3693" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Wringers.
			{ Cue = "/VO/ZagreusField_3692", RequiredPlayed = { "/VO/ZagreusField_3693" }, },
			-- Wringers!
			{ Cue = "/VO/ZagreusField_3693" },
			-- More Wringers!
			{ Cue = "/VO/ZagreusField_3694", RequiredPlayed = { "/VO/ZagreusField_3693" }, },
			-- More Wringers?
			{ Cue = "/VO/ZagreusField_3695", RequiredPlayed = { "/VO/ZagreusField_3693" }, },
		},

		Binks =
		{
			"Enemy_WringerIdle_Bink",
			"Enemy_WringerMove_Bink",
			"Enemy_WringerAttack_Bink",
			"Enemy_Wringer_OnHit_Bink",
			"Enemy_WringerDeathVFX_Bink",
			"Enemy_WringerStart_Bink",
		},
	},
	DisembodiedHandElite =
	{
		InheritFrom = { "Elite", "DisembodiedHand" },

		HealthBuffer = 230,
		RequiredMinBiomeDepth = 3,
		BlockAttributes = { "Blink" },

		WeaponOptions =
		{
			"DisembodiedHandGrabElite",
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},

		GeneratorData =
		{
			DifficultyRating = 20,
			BlockEnemyTypes = {"DisembodiedHand", "DisembodiedHandSuperElite"}
		},
	},

	DisembodiedHandSuperElite =
	{
		InheritFrom = { "SuperElite", "DisembodiedHandElite" },
		HealthBuffer = 2000,

		GeneratorData =
		{
			DifficultyRating = 300,
			BlockSolo = true,
			BlockEnemyTypes = {"DisembodiedHand", "DisembodiedHandElite"},
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},
	},

	-- WRETCH SWARMER
	BaseSwarmer =
	{
		PreferredSpawnPoint = "EnemyPointMelee",
		Groups = { "FlyingEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/Swarmer/EmoteAlerted",
		Material = "Bone",

		BlockAttributes = { "DeathSpreadHitShields" },

		MaxHealth = 30,
		HealthBarOffsetY = -100,

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackEndShake = true,
			PreAttackSound = "/SFX/Enemy Sounds/Swarmer/EmoteCharging",
			PreAttackFlashSound = "/Leftovers/SFX/AuraOnLoud",
			AggroAnimation = "EnemyWretchSwarmerAlert",
			PreAttackAnimation = "EnemyWretchSwarmerAttackCharge",
			FireAnimation = "EnemyWretchSwarmerAttackFire",
			PostAttackAnimation = "EnemyWretchSwarmerPostAttack",
		},
		AggroDuration = 0.5,

		ActiveCapWeight = 0.5,

		AIOptions =
		{
			AggroAI,
		},

		AmmoDropOnDeath =
		{
			Chance = 0.1,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		DeathForce = 1100,

		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Numbskulls.
			{ Cue = "/VO/ZagreusField_0856", RequiredPlayed = { "/VO/ZagreusField_0857" } },
			-- Numbskulls!
			{ Cue = "/VO/ZagreusField_0857" },
			-- More Numbskulls!
			{ Cue = "/VO/ZagreusField_0858", RequiredPlayed = { "/VO/ZagreusField_0857" } },
			-- More Numbskulls?
			{ Cue = "/VO/ZagreusField_0859", RequiredPlayed = { "/VO/ZagreusField_0857" } },
		},
	},

	Swarmer =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseSwarmer" },
		GenusName = "Swarmer",

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 0.5,
			FireDuration = 0.5,
			PostAttackDuration = 0.5,

			--AIAggroRange = 725,
			AIAttackDistance = 350,
			AIBufferDistance = 550,
			RetreatAfterAttack = true,

			AIRequireProjectileLineOfSight = true,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 80,
			AILineOfSighEndBuffer = 32,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = false,
		},

		WeaponOptions =
		{
			"SwarmerMelee",
		},

		GeneratorData =
		{
			DifficultyRating = 3,
			BlockEnemyTypes = {"SwarmerElite", "SwarmerSuperElite"}
		},

		MoneyDropOnDeath =
		{
			Chance = 0.25,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.33,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	SwarmerElite =
	{
		InheritFrom = { "Elite", "Swarmer" },
		HealthBuffer = 50,

		AIAggroRange = 850,
		BlockAttributes = { "HeavyArmor" },

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 0.5,
			FireDuration = 0.5,
			PostAttackDuration = 0.4,

			RetreatAfterAttack = false,
		},

		WeaponOptions =
		{
			"SwarmerMelee",
		},

		RequiredMinBiomeDepth = 3,

		FireAnimation = "EnemyWretchSwarmerAttackFireWithStreaks",

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},

		GeneratorData =
		{
			DifficultyRating = 7,
			BlockEnemyTypes = {"Swarmer", "SwarmerSuperElite"}
		},
	},

	SwarmerSuperElite =
	{
		InheritFrom = { "SuperElite", "SwarmerElite" },
		HealthBuffer = 250,

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 0.5,
			FireDuration = 0.5,
			PostAttackDuration = 0.4,

			RetreatAfterAttack = false,
		},

		FireAnimation = "EnemyWretchSwarmerAttackFireWithStreaks",

		BlockAttributes = { "HeavyArmor" },

		WeaponOptions =
		{
			"SwarmerMeleeSuperElite",
		},

		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 1.5,
			Threshold = 0.65,
		},

		GeneratorData =
		{
			DifficultyRating = 50,
			BlockEnemyTypes = {"Swarmer", "SwarmerElite"}
		},


		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.33,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	SwarmerHelmeted =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseSwarmer" },
		Health = 400,
		HealthBuffer = 400,

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 0.5,
			FireDuration = 0.5,
			PostAttackDuration = 0.1,

			--AIAggroRange = 725,
			AIAttackDistance = 350,
			AIBufferDistance = 550,
			RetreatAfterAttack = false,

			AIRequireProjectileLineOfSight = true,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 80,
			AILineOfSighEndBuffer = 32,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = false,
		},

		WeaponOptions =
		{
			"SwarmerHelmetedMelee"
		},

		GeneratorData =
		{
			DifficultyRating = 10,
			BlockEnemyTypes = {"SwarmerElite", "SwarmerSuperElite"}
		},

		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 1.5,
			Threshold = 0.65,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.25,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.33,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	-- WRETCH GLUTTON
	BaseGlutton =
	{
		PreferredSpawnPoint = "EnemyPointMelee",
		Groups = { "GroundEnemies" },
		
		LargeUnitCap = 5,
		Binks =
		{
			"EnemyWretchGluttonAttack_Bink",
			"EnemyWretchGluttonDeathVFX_Bink",
			"EnemyWretchGluttonIdle_Bink",
			"EnemyWretchGluttonOnHit_Bink",
		},
		Material = "Organic",

		DeathForce = 1400,

		HealthBarOffsetY = -220,
		HitSparkScale = 2.8,
		HealthBarType = "MediumLarge",
		HitSparkOffsetZ = 160,

		AIOptions =
		{
			AggroAI,
		},

		AmmoDropOnDeath =
		{
		  Chance = 1.0,
		  MinAmmo = 1,
		  MaxAmmo = 2,
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Louts!
			{ Cue = "/VO/ZagreusField_0845" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_0845" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Louts.
			{ Cue = "/VO/ZagreusField_0844", RequiredPlayed = { "/VO/ZagreusField_0845" } },
			-- Louts!
			{ Cue = "/VO/ZagreusField_0845" },
			-- More Louts!
			{ Cue = "/VO/ZagreusField_0846", RequiredPlayed = { "/VO/ZagreusField_0845" } },
			-- More Louts?
			{ Cue = "/VO/ZagreusField_0847", RequiredPlayed = { "/VO/ZagreusField_0845" } },
		},
	},

	PunchingBagUnit =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseGlutton" },
		GenusName = "PunchingBagUnit",
		RequiredIntroEncounter = "PunchingBagIntro",

		MaxHealth = 210,
		IsAggroedSound = "/SFX/Enemy Sounds/PunchingBag/EmoteAlerted",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"PunchingBagUnitWeapon",
		},

		GeneratorData =
		{
			DifficultyRating = 15,
			BlockEnemyTypes = {"PunchingBagUnitElite", "PunchingBagUnitSuperElite"}
		},

		MoneyDropGlobalVoiceLines = "SurvivalMoneyDropVoiceLines",
	},

	PunchingBagUnitElite =
	{
		InheritFrom = { "Elite", "PunchingBagUnit" },

		MaxHealth = 210,
		HealthBuffer = 310,

		HealthBarOffsetY = -200,

		IsAggroedSound = "/SFX/Enemy Sounds/PunchingBag/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 0.4,
		},

		WeaponOptions =
		{
			"PunchingBagUnitWeapon",
		},

		--EliteAttributeOptions = CombineTables(EnemySets.AllEliteAttributes, { "Wavemaking" } ),
		EliteAttributeData =
		{
			DeepInheritance = true,
			Wavemaking =
			{
				DataOverrides =
				{
					WeaponOptions =
					{
						"PunchingBagUnitWeaponElite",
					}
				},
			},
		},

		GeneratorData =
		{
			DifficultyRating = 35,
			BlockEnemyTypes = {"PunchingBagUnit", "PunchingBagUnitSuperElite"}
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.9,
		},

		RequiredMinBiomeDepth = 3,
	},


	PunchingBagUnitSuperElite =
	{
		InheritFrom = { "SuperElite", "PunchingBagUnitElite" },

		MaxHealth = 210,
		HealthBuffer = 1400,

		HealthBarOffsetY = -200,

		IsAggroedSound = "/SFX/Enemy Sounds/PunchingBag/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 0.1,
		},

		GeneratorData =
		{
			DifficultyRating = 200,
			BlockEnemyTypes = {"PunchingBagUnit", "PunchingBagUnitElite"}
		},

		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 4,
			Threshold = 0.9,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

	},


	-- WRETCH THIEF
	BaseThief =
	{
		PreferredSpawnPoint = "EnemyPointMelee",
		Material = "Stone",
		Groups = { "GroundEnemies" },

		BlockAttributes = { "Blink" },

		Binks =
		{
			"EnemyStyxThiefIdle_Bink",
			"EnemyWretchThiefFidget_Bink",
			"EnemyWretchThiefOnHit_Bink",
			"EnemyWretchThiefThrow_Bink",
			"EnemyWretchThiefWalk_Bink",
			"EnemyStyxThiefFidget_Bink",
			"EnemyStyxThiefOnHit_Bink",
			"EnemyStyxThiefWalk_Bink",
		},

		DeathForce = 1100,
		DestroyDelay = 0.2,
		HitSparkScale = 1.75,
		AmmoDropOnDeath =
		{
		  Chance = 1.0,
		  MinAmmo = 1,
		  MaxAmmo = 1,
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Pests!
			{ Cue = "/VO/ZagreusField_0865" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_0865" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Pests.
			{ Cue = "/VO/ZagreusField_0864", RequiredPlayed = { "/VO/ZagreusField_0865" } },
			-- Pests!
			{ Cue = "/VO/ZagreusField_0865" },
			-- More Pests!
			{ Cue = "/VO/ZagreusField_0866", RequiredPlayed = { "/VO/ZagreusField_0865" } },
			-- More Pests?
			{ Cue = "/VO/ZagreusField_0867", RequiredPlayed = { "/VO/ZagreusField_0865" } },
		},
	},

	ThiefMineLayer =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseThief" },
		RequiredMinCompletedRuns = 2,
		GenusName = "ThiefMineLayer",

		RequiredIntroEncounter = "ThiefMineLayerIntro",

		MaxHealth = 40,
		HealthBarOffsetY = -135,

		FuseSpawnsOnDeath = true,
		FuseSpawnsInterval = 0.3,

		Material = "Stone",
		PreAttackSound = "/SFX/Enemy Sounds/ThiefMineLayer/EmoteCharging",
		IsAggroedSound = "/SFX/Enemy Sounds/ThiefMineLayer/EmoteAlerted",

		DefaultAIData =
		{
			DeepInheritance = true,

			BlendWithNames = { "Breakable", "BreakableAsphodel", "BreakableHighValue" },
			BlendMinDistance = 800,
			BlendMaxDistance = 2000,
			MoveSuccessDistance = 76,
			AIWanderDistanceMin = 300,
			AIWanderDistance = 600,
			AIRetreatDistance = 450,
			BlendInTime = 0.5,
			BlendTimeoutMin = 5.0,
			BlendTimeoutMax = 6.0,
			AttackWhileBlending = true,
			AttackWhileBlendingIntervalMin = 3.0,
			AttackWhileBlendingIntervalMax = 3.5,
			AttackWhileMovingIntervalMin = 1.50,
			AttackWhileMovingIntervalMax = 1.50,
			MaxActiveSpawns = 7,
			PreLayDropAnimation = "EnemyWretchThiefThrowCharge",
			LayDropAnimation = "EnemyWretchThiefThrowFire",

			PreAttackEndShake = true,
			PreAttackEndShakeSound = "/SFX/Enemy Sounds/ThiefMineLayer/EmoteAlerted",
			PreAttackDuration = 0.1,
			PostAttackDuration = 0.1,

			DropName = "BloodMine",
			SpawnDropAsUnit = true,
			DropOffsetZ = 100,
			DropUpwardForce = 500,
			DropScaleInDuration = 0.01,

			AttackOnMoveStart = true,
		},

		AIOptions =
		{
			BlendInAI,
		},

		WeaponOptions = { "MineToss" },

		GeneratorData =
		{
			DifficultyRating = 8,
			BlockSolo = true,
			BlockEnemyTypes = {"ThiefMineLayerElite"}
		},

		MoneyDropGlobalVoiceLines = "SurvivalMoneyDropVoiceLines",
	},

	ThiefMineLayerElite =
	{
		InheritFrom = { "Elite", "ThiefMineLayer" },

		HealthBuffer = 60,

		Material = "Stone",
		IsAggroedSound = "/SFX/Enemy Sounds/ThiefMineLayer/EmoteStealing",

		DefaultAIData =
		{
			DeepInheritance = true,

			BlendWithNames = { },
			BlendMinDistance = 0,
			BlendMaxDistance = 0,
			BlendInTime = 0,
			BlendTimeoutMin = 0,
			BlendTimeoutMax = 0,
			MaxActiveSpawns = 8,

			AIWanderDistanceMin = 150,
			AIWanderDistance = 300,

			AttackWhileMovingIntervalMin = 1.0,
			AttackWhileMovingIntervalMax = 1.0,

			AttackWhileBlendingIntervalMin = 2.0,
			AttackWhileBlendingIntervalMax = 2.0,
		},

		BlockAttributes = { "HeavyArmor" },

		GeneratorData =
		{
			DifficultyRating = 17,
			BlockEnemyTypes = {"ThiefMineLayer"}
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

		RequiredMinBiomeDepth = 3,
	},

	ThiefImpulseMineLayer =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseThief" },

		MaxHealth = 500,
		HealthBarOffsetY = -135,
		HealthBarType = "Small",
		AddOutlineImmediately = true,

		FuseSpawnsOnDeath = true,
		FuseSpawnsInterval = 0.3,

		Material = "Stone",
		PreAttackSound = "/SFX/Enemy Sounds/ImpulseMineLayer/EmoteCharging",
		IsAggroedSound = "/SFX/Enemy Sounds/ImpulseMineLayer/EmoteAlerted",

		DefaultAIData =
		{
			DeepInheritance = true,

			BlendWithNames = { "Breakable", "BreakableAsphodel", "BreakableHighValue" },
			BlendMinDistance = 800,
			BlendMaxDistance = 2000,
			MoveSuccessDistance = 76,
			AIWanderDistanceMin = 300,
			AIWanderDistance = 600,
			AIRetreatDistance = 450,
			BlendWithRandom = true,
			BlendInTime = 0.5,
			BlendTimeoutMin = 0.75,
			BlendTimeoutMax = 1.5,
			AttackWhileBlending = true,
			AttackWhileBlendingIntervalMin = 3.0,
			AttackWhileBlendingIntervalMax = 3.5,
			AttackWhileMovingIntervalMin = 3.00,
			AttackWhileMovingIntervalMax = 3.50,

			PreAttackEndShake = true,
			PreAttackEndShakeSound = "/SFX/Enemy Sounds/ImpulseMineLayer/ImpulseMineLayerShake",
			PreAttackDuration = 0.1,
			PostAttackDuration = 0.1,

			MaxConsecutiveAttacks = 1,
			AttackOnMoveStart = true,
			PostAttackOnMoveStartWait = 1.0,
		},

		AIOptions =
		{
			BlendInAI,
		},

		WeaponOptions = { "GrenadierWeapon" },

		MoneyDropOnDeath =
		{
			Chance = 0.4,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		GeneratorData =
		{
			DifficultyRating = 80,
			BlockSolo = true,
			BlockEnemyTypes = {"ThiefImpulseMineLayerElite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Bothers!
			{ Cue = "/VO/ZagreusField_2203" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_2203" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Bothers.
			{ Cue = "/VO/ZagreusField_2202", RequiredPlayed = { "/VO/ZagreusField_2203" } },
			-- Bothers!
			{ Cue = "/VO/ZagreusField_2203" },
			-- More Bothers!
			{ Cue = "/VO/ZagreusField_2204", RequiredPlayed = { "/VO/ZagreusField_2203" } },
			-- More Bothers?
			{ Cue = "/VO/ZagreusField_2205", RequiredPlayed = { "/VO/ZagreusField_2203" } },
		},

	},

	ThiefImpulseMineLayerElite =
	{
		InheritFrom = { "Elite", "ThiefImpulseMineLayer" },

		HealthBuffer = 500,

		Material = "Stone",
		IsAggroedSound = "/SFX/Enemy Sounds/ImpulseMineLayer/EmoteStealing",

		DefaultAIData =
		{
			DeepInheritance = true,

			BlendWithNames = { },
			BlendMinDistance = 0,
			BlendMaxDistance = 0,
			BlendInTime = 0,
			BlendTimeoutMin = 0,
			BlendTimeoutMax = 0,
			MaxActiveSpawns = 4,

			AIWanderDistanceMin = 150,
			AIWanderDistance = 300,

			AttackWhileMovingIntervalMin = 2.5,
			AttackWhileMovingIntervalMax = 3.0,

			AttackWhileBlendingIntervalMin = 1.0,
			AttackWhileBlendingIntervalMax = 1.5,
		},

		EliteAttributeData =
		{
			DeepInheritance = true,
			HeavyArmor =
			{
				DataOverrides =
				{
					HealthMultiplier = 1.5,
					HealthBarType = "ExtraLarge",
				},
			},
		},

		GeneratorData =
		{
			DifficultyRating = 120,
			BlockEnemyTypes = {"ThiefImpulseMineLayer"}
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

		RequiredMinBiomeDepth = 3,
	},

	ThiefImpulseMineLayerMiniboss =
	{
		InheritFrom = { "Elite", "ThiefImpulseMineLayer" },

		Health = 1200,
		HealthBuffer = 2500,
		HealthBarType = "MediumLarge",

		WeaponOptions = { "GrenadierWeaponMiniboss" },

		GeneratorData =
		{
			DifficultyRating = 700,
			MaxCount = 1,
			BlockEnemyTypes = { "ThiefImpulseMineLayer", "ThiefImpulseMineLayerElite" },
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

	},

	-- WRETCH CASTER
	BaseCaster =
	{
		PreferredSpawnPoint = "EnemyPointRanged",
		EliteAttributeOptions = CombineTables(EnemySets.AllEliteAttributes, EnemySets.RangedOnlyEliteAttributes ),
		Groups = { "FlyingEnemies" },
		Binks =
		{
			"EnemyWretchCasterAttack_Bink",
			"EnemyWretchCasterAttackAlt_Bink",
			"EnemyWretchCasterDeathVFX_Bink",
			"EnemyWretchCasterIdle_Bink",
			"EnemyWretchCasterMove_Bink",
			"EnemyWretchCasterOnHit_Bink",
			"EnemyWretchCasterStart_Bink",
			"EnemyWretchCasterStop_Bink"
		},

		LargeUnitCap = 6,

		IsAggroedSound = "/SFX/Enemy Sounds/Caster/EmoteAlerted",
		Material = "Organic",

		PreAttackSound = "/SFX/Enemy Sounds/Caster/EmoteCharging",
		HitSparkScale = 1.5,
		DeathForce = 900,

		MaxHealth = 80,
		HealthBarOffsetY = -180,
		HitSparkOffsetZ = 140,
		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackEndShake = true,
			PreAttackAnimation = "EnemyWretchCasterAttackCharge",
			FireAnimation = "EnemyWretchCasterAttackFire",

			PreAttackDuration = 0.5,
			PostAttackDuration = 0.5,
			TakeCoverDuration = 2.5,
			CoverHugDistance = 150,
			AIAttackDistance = 1200,
			AIMoveWithinRangeTimeoutMin = 2.0,
			AIMoveWithinRangeTimeoutMax = 4.0,
		},

		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = HideAndPeekAI,
		PeekAggroMultiplier = 3,
		AIAggroRange = 750,

		AmmoDropOnDeath =
		{
			Chance = 0.7,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Witches.
			{ Cue = "/VO/ZagreusField_0848", RequiredPlayed = { "/VO/ZagreusField_0849" } },
			-- Witches!
			{ Cue = "/VO/ZagreusField_0849" },
			-- More Witches!
			{ Cue = "/VO/ZagreusField_0850", RequiredPlayed = { "/VO/ZagreusField_0849" } },
			-- More Witches?
			{ Cue = "/VO/ZagreusField_0851", RequiredPlayed = { "/VO/ZagreusField_0849" } },
		},

		EliteAttributeData =
		{
			DeepInheritance = true,
			Frenzy =
			{
				DataOverrides =
				{
					EliteAdditionalSpeedMultiplier = 0.3,
					AttachedAnimationName = "EliteUnitStatus2"
				},
				BlockAttributes = { "Homing", "Vacuuming" },
			},
		},
	},

	LightRanged =
	{
		InheritFrom = { "BaseCaster", "BaseVulnerableEnemy" },
		GenusName = "LightRanged",

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackSound = "/SFX/Enemy Sounds/Caster/EmoteCharging",
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 80,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = false,

			TakeCoverDuration = 2.3,

			PreAttackAnimation = "EnemyWretchCasterAttackCharge",
			FireAnimation = "EnemyWretchCasterAttackFire",

			PreAttackDuration = 0.5,
			PostAttackDuration = 0.5,
		},

		WeaponOptions =
		{
			"LightRangedWeapon",
		},

		GeneratorData =
		{
			DifficultyRating = 5,
			BlockEnemyTypes = {"LightRangedElite", "LightRangedSuperElite"}
		},

		MoneyDropGlobalVoiceLines = "SurvivalMoneyDropVoiceLines",
	},

	LightRangedElite =
	{
		InheritFrom = { "Elite", "LightRanged" },
		EliteAttributeOptions = CombineTables(EnemySets.AllEliteAttributes, EnemySets.RangedOnlyEliteAttributes ),

		HealthBuffer = 120,

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 0.25,
			PostAttackDuration = 0.50,
			TakeCoverDuration = 1.0,

			AIFireTicksMin = 3,
			AIFireTicksMax = 3,
			AIFireTicksCooldown = 0.15,

			AIMoveWithinRangeTimeoutMin = 1.0,
			AIMoveWithinRangeTimeoutMax = 1.5,
		},

		EliteAttributeData =
		{
			DeepInheritance = true,
			HeavyArmor =
			{
				DataOverrides =
				{
					HealthMultiplier = 2.0,
					HealthBarType = "ExtraLarge",
				},
			},
		},

		IsAggroedSound = "/SFX/Enemy Sounds/Caster/EmoteTaunting",

		WeaponOptions =
		{
			"LightRangedWeaponElite",
		},

		GeneratorData =
		{
			DifficultyRating = 15,
			BlockEnemyTypes = {"LightRanged", "LightRangedSuperElite"}
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

		RequiredMinBiomeDepth = 3,
	},

	LightRangedSuperElite =
	{
		InheritFrom = { "SuperElite", "LightRangedElite" },

		HealthBuffer = 1200,

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 0.25,
			PostAttackDuration = 1.2,
			TakeCoverDuration = 4.0,

			AIFireTicksMin = 1,
			AIFireTicksMax = 1,
			AIFireTicksCooldown = 0.07,

			AIMoveWithinRangeTimeoutMin = 1.0,
			AIMoveWithinRangeTimeoutMax = 1.5,

			IsAggroedSound = "/SFX/Enemy Sounds/Caster/EmoteTaunting",
		},

		BlockAttributes = { "HeavyArmor" },

		WeaponOptions =
		{
			"LightRangedWeaponSuperElite",
		},

		GeneratorData =
		{
			DifficultyRating = 200,
			BlockEnemyTypes = {"LightRanged", "LightRangedElite"}
		},

		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 4.5,
			Threshold = 0.65,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		RequiredMinBiomeDepth = 3,
	},

	SpreadShotUnit =
	{
		InheritFrom = { "LightRanged", "BaseVulnerableEnemy" },
		GenusName = "SpreadShotUnit",

		MaxHealth = 150,

		DefaultAIData =
		{
			DeepInheritance = true,

			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 160,
			AIAngleTowardsPlayerWhileFiring = false,

			PreAttackDuration = 0.25,
			PostAttackDuration = 2.0,

		 	PreAttackSound = "/SFX/Enemy Sounds/Caster/EmoteCharging",
			PreAttackAnimation = "EnemyWretchCasterAttackCharge_SpreadShot",
			FireAnimation = "EnemyWretchCasterAttackFire_SpreadShot",

			SurroundDistance = 550,
			StandOffTime = 0.5,
			MaxAttackers = 2,
		},
		PostAggroAI = SurroundAI,

		WeaponOptions =
		{
			"SpreadShotWeapon",
		},

		GeneratorData =
		{
			DifficultyRating = 20,
			BlockEnemyTypes = {"SpreadShotUnitElite"},
		},

		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Spreaders.
			{ Cue = "/VO/ZagreusField_2206", RequiredPlayed = { "/VO/ZagreusField_2207" } },
			-- Spreaders!
			{ Cue = "/VO/ZagreusField_2207" },
			-- More Spreaders!
			{ Cue = "/VO/ZagreusField_2208", RequiredPlayed = { "/VO/ZagreusField_2207" } },
			-- More Spreaders?
			{ Cue = "/VO/ZagreusField_2209", RequiredPlayed = { "/VO/ZagreusField_2207" } },
		},

		Binks =
		{
			"EnemyWretchCasterSpreadShotAttack_Bink",
			"EnemyWretchCasterSpreadShotAttackAlt_Bink",
			"EnemyWretchCasterDeathVFX_Bink",
			"EnemyWretchCasterSpreadShotIdle_Bink",
			"EnemyWretchCasterIdle_Bink",
			"EnemyWretchCasterSpreadShotMove_Bink",
			"EnemyWretchCasterSpreadShotOnHit_Bink",
			"EnemyWretchCasterSpreadShotStart_Bink",
			"EnemyWretchCasterSpreadShotStop_Bink"
		},
	},

	SpreadShotUnitElite =
	{
		InheritFrom = { "Elite", "SpreadShotUnit" },
		EliteAttributeOptions = CombineTables(EnemySets.AllEliteAttributes, EnemySets.RangedOnlyEliteAttributes ),

		HealthBuffer = 225,

		DefaultAIData =
		{
			DeepInheritance = true,

			AIFireTicksMin = 3,
			AIFireTicksMax = 3,
			AIFireTicksCooldown = 0.3,

			PreAttackDuration = 0.5,
			PostAttackDuration = 0.5,
			PostAttackCooldown = 1.5,

			AIMoveWithinRangeTimeoutMin = 1.0,
			AIMoveWithinRangeTimeoutMax = 1.5,
		},

		EliteAttributeData =
		{
			DeepInheritance = true,
			HeavyArmor =
			{
				DataOverrides =
				{
					HealthMultiplier = 2.0,
					HealthBarType = "ExtraLarge",
				},
			},
		},

		GeneratorData =
		{
			DifficultyRating = 35,
			BlockEnemyTypes = {"SpreadShotUnit"}
		},
		RequiredMinBiomeDepth = 2,
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

	},

	SpreadShotUnitMiniboss =
	{
		InheritFrom = { "Elite", "SpreadShotUnit" },

		MaxHealth = 425,
		HealthBuffer = 850,
		HealthBarType = "MediumLarge",

		DefaultAIData =
		{
			DeepInheritance = true,

		 	PreAttackSound = "/SFX/Enemy Sounds/Caster/EmoteCharging",
			AIMoveWithinRangeTimeoutMin = 1.0,
			AIMoveWithinRangeTimeoutMax = 1.0,

			MaxAttackers = 3,
		},

		WeaponOptions =
		{
			"SpreadShotMinibossRadial", "SpreadShotMinibossCone", "SpreadShotMinibossCross"
		},
		ShrineMetaUpgradeName = "MinibossCountShrineUpgrade",
		ShrineWeaponOptionsOverwrite = { "SpreadShotMinibossRadial", "SpreadShotMinibossCone", "SpreadShotMinibossCross",
										"SpreadShotMinibossInvulnerableLine", "SpreadShotMinibossInvulnerableCone", "SpreadShotMinibossInvulnerableCross",
										"SpreadShotMinibossInvulnerableCone", "SpreadShotMinibossInvulnerableCross" },

		GeneratorData =
		{
			DifficultyRating = 60,
		},

		RequiredMinBiomeDepth = 2,
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

	},

	SplitShotUnit =
	{
		InheritFrom = { "LightRanged", "BaseVulnerableEnemy" },
		GenusName = "SplitShotUnit",

		MaxHealth = 250,
		HealthBarType = "Small",

		IsAggroedSound = "/SFX/Enemy Sounds/Caster/EmoteAlerted",

		DefaultAIData =
		{
			DeepInheritance = true,

			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 160,
			AIAngleTowardsPlayerWhileFiring = false,

			PreAttackDuration = 0.5,
			PostAttackDuration = 2.5,

			MaxAttackers = 2,

			SurroundDistance = 800,
			StandOffTime = 0.5,

			PreAttackSound = "/SFX/Enemy Sounds/Caster/EmoteCharging",
			PreAttackAnimation = "EnemyWretchCasterAttackCharge_SplitShot",
			FireAnimation = "EnemyWretchCasterAttackFire_SplitShot",
		},
		PostAggroAI = SurroundAI,

		WeaponOptions =
		{
			"SplitShotWeapon",
		},

		GeneratorData =
		{
			DifficultyRating = 35,
			BlockEnemyTypes = {"SplitShotUnitElite"}
		},

		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Splitters.
			{ Cue = "/VO/ZagreusField_2210", RequiredPlayed = { "/VO/ZagreusField_2211" } },
			-- Splitters!
			{ Cue = "/VO/ZagreusField_2211" },
			-- More Splitters!
			{ Cue = "/VO/ZagreusField_2212", RequiredPlayed = { "/VO/ZagreusField_2211" } },
			-- More Splitters?
			{ Cue = "/VO/ZagreusField_2213", RequiredPlayed = { "/VO/ZagreusField_2211" } },
		},

		Binks =
		{
			"EnemyWretchCasterSplitShotAttack_Bink",
			"EnemyWretchCasterSplitShotAttackAlt_Bink",
			"EnemyWretchCasterSplitShotIdle_Bink",
			"EnemyWretchCasterDeathVFX_Bink",
			"EnemyWretchCasterIdle_Bink",
			"EnemyWretchCasterSplitShotMove_Bink",
			"EnemyWretchCasterSplitShotOnHit_Bink",
			"EnemyWretchCasterSplitShotStart_Bink",
			"EnemyWretchCasterSplitShotStop_Bink"
		},
	},

	SplitShotUnitElite =
	{
		InheritFrom = { "Elite", "SplitShotUnit" },
		EliteAttributeOptions = CombineTables(EnemySets.AllEliteAttributes, EnemySets.RangedOnlyEliteAttributes ),

		HealthBuffer = 345,

		IsAggroedSound = "/SFX/Enemy Sounds/Caster/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,

			PostAttackDuration = 1.5,
			PostAttackCooldown = 1.5,
		},

		WeaponOptions =
		{
			"SplitShotWeaponElite",
		},

		EliteAttributeData =
		{
			DeepInheritance = true,
			HeavyArmor =
			{
				DataOverrides =
				{
					HealthMultiplier = 2.0,
					HealthBarType = "ExtraLarge",
				},
			},
		},

		GeneratorData =
		{
			DifficultyRating = 125,
			BlockEnemyTypes = {"SplitShotUnit"},
		},
		RequiredMinBiomeDepth = 3,
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	BaseCrystal =
	{
		PreferredSpawnPoint = "EnemyPointRanged",
		Groups = { "FlyingEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/Caster/EmoteAlerted",
		Material = "Organic",

		PreAttackSound = "/SFX/Enemy Sounds/Caster/EmoteCharging",

		DeathForce = 900,

		HealthBarOffsetY = -235,

		AIAggroRange = 750,
		HitSparkScale = 1.75,
		AmmoDropOnDeath =
		{
			Chance = 0.7,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Brimstones!
			{ Cue = "/VO/ZagreusField_0837" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_0837" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Brimstones.
			{ Cue = "/VO/ZagreusField_0836", RequiredPlayed = { "/VO/ZagreusField_0837" } },
			-- Brimstones!
			{ Cue = "/VO/ZagreusField_0837" },
			-- More Brimstones!
			{ Cue = "/VO/ZagreusField_0838", RequiredPlayed = { "/VO/ZagreusField_0837" } },
			-- More Brimstones?
			{ Cue = "/VO/ZagreusField_0839", RequiredPlayed = { "/VO/ZagreusField_0837" } },
		},
	},

	HeavyRanged =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseCrystal" },
		RequiredMinCompletedRuns = 2,
		GenusName = "HeavyRanged",

		RequiredIntroEncounter = "HeavyRangedIntro",

		MaxHealth = 60,
		HealthBarOffsetY = -150,

		IsAggroedSound = "/SFX/Enemy Sounds/Brimstone/CrystalAggro",
		Material = "Stone",

		DefaultAIData =
		{
			PreAttackSound = "/SFX/Enemy Sounds/Brimstone/CrystalTargetAcquired",
			PreAttackEndShake = true,

			PreAttackWaitForAnimation = true,
			PostAttackDuration = 3.0,
			StandOffTime = 1.2,
			SurroundDistance = 600,
			AIAttackDistance = 700,
			MaxAttackers = 2,
		},
		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = SurroundAI,

		WeaponOptions =
		{
			"HeavyRangedWeapon",
		},

		SpawnObstaclesOnDeath =
		{
			{ Name = "HeavyRangedCrystal4", RandomForceMin = 100, RandomForceMax = 400, UpwardForce = 1800 },
		},

		Tethers =
		{
			{ Name = "HeavyRangedCrystal1", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
			{ Name = "HeavyRangedCrystal2", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
			{ Name = "HeavyRangedCrystal3", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
		},
		OnDeathTetherUpwardForce = 1800,
		OnDeathTetherRandomForceMin = 100,
		OnDeathTetherRandomForceMax = 150,

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		GeneratorData =
		{
			DifficultyRating = 8,
			BlockEnemyTypes = {"HeavyRangedElite"}
		},

		MoneyDropGlobalVoiceLines = "SurvivalMoneyDropVoiceLines",
	},

	HeavyRangedElite =
	{
		InheritFrom = { "Elite", "HeavyRanged" },

		HealthBuffer = 90,

		DefaultAIData =
		{
			PreAttackSound = "/SFX/Enemy Sounds/Brimstone/CrystalTargetAcquired",
			PreAttackEndShake = true,

			PreAttackWaitForAnimation = true,
			PostAttackDuration = 3.0,
			StandOffTime = 0.2,
			SurroundDistance = 600,
			AIAttackDistance = 700,
			MaxAttackers = 4,
		},

		EliteAttributeData =
		{
			DeepInheritance = true,
			HeavyArmor =
			{
				DataOverrides =
				{
					HealthMultiplier = 4.0,
					HealthBarType = "ExtraLarge",
				},
			},
		},

		GeneratorData =
		{
			DifficultyRating = 20,
			BlockEnemyTypes = {"HeavyRanged"}
		},
		RequiredMinBiomeDepth = 3,
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	HeavyRangedForked =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseCrystal" },
		GenusName = "HeavyRangedForked",

		RequiredIntroEncounter = nil,
		PreferredSpawnPoint = "EnemyPointRanged",

		MaxHealth = 850,
		HealthBarOffsetY = -150,
		HealthBarType = "Medium",

		IsAggroedSound = "/SFX/Enemy Sounds/HeavyRangedForked/CrystalAggro",
		Material = "Stone",

		DefaultAIData =
		{
			PreAttackSound = "/SFX/Enemy Sounds/HeavyRangedForked/CrystalTargetAcquired",
			PreAttackEndShake = true,

			PreAttackWaitForAnimation = true,
			PostAttackDuration = 3.0,
			StandOffTime = 0.2,
			SurroundDistance = 800,
			AIAttackDistance = 950,
			MaxAttackers = 2,
		},

		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = SurroundAI,

		WeaponOptions =
		{
			"HeavyRangedWeaponFork",
		},

		GeneratorData =
		{
			DifficultyRating = 80,
			BlockEnemyTypes = {"HeavyRangedForkedElite"}
		},

		MoneyDropOnDeath =
		{
			Chance = 0.6,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Snakestones!
			{ Cue = "/VO/ZagreusField_2216" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_2216" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Snakestones.
			{ Cue = "/VO/ZagreusField_2215", RequiredPlayed = { "/VO/ZagreusField_2216" } },
			-- Snakestones!
			{ Cue = "/VO/ZagreusField_2216" },
			-- More Snakestones!
			{ Cue = "/VO/ZagreusField_2217", RequiredPlayed = { "/VO/ZagreusField_2216" } },
			-- More Snakestones?
			{ Cue = "/VO/ZagreusField_2218", RequiredPlayed = { "/VO/ZagreusField_2216" } },
		},

		SpawnObstaclesOnDeath =
		{
			{ Name = "HeavyRangedForkedCrystal4", RandomForceMin = 100, RandomForceMax = 400, UpwardForce = 1800 },
		},

		Tethers =
		{
		},
		OnDeathTetherUpwardForce = 1800,
		OnDeathTetherRandomForceMin = 100,
		OnDeathTetherRandomForceMax = 150,
	},

	HeavyRangedForkedElite =
	{
		InheritFrom = { "Elite", "HeavyRangedForked" },

		HealthBuffer = 650,

		DefaultAIData =
		{
			PreAttackSound = "/SFX/Enemy Sounds/HeavyRangedForked/CrystalTargetAcquired",
			PreAttackEndShake = true,

			PreAttackWaitForAnimation = true,
			PostAttackDuration = 3.0,
			StandOffTime = 0.2,
			SurroundDistance = 600,
			AIAttackDistance = 700,
			MaxAttackers = 4,
		},

		WeaponOptions =
		{
			"HeavyRangedWeaponForkElite",
		},

		GeneratorData =
		{
			DifficultyRating = 130,
			BlockEnemyTypes = {"HeavyRangedForked"}
		},
		--RequiredMinBiomeDepth = 3,
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	HeavyRangedForkedMiniboss =
	{
		InheritFrom = { "Elite", "HeavyRangedForked" },

		Health = 1000,
		HealthBuffer = 4500,
		HealthBarType = "Large",

		DefaultAIData =
		{
			PreAttackSound = "/SFX/Enemy Sounds/HeavyRangedForked/CrystalTargetAcquired",
			PreAttackEndShake = true,

			PreAttackWaitForAnimation = true,
			PostAttackDuration = 5.0,
			StandOffTime = 0.2,
			SurroundDistance = 600,
			AIAttackDistance = 700,
			MaxAttackers = 1,

			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			SkipStopBeforePreAttackEnd = true,
		},

		WeaponOptions =
		{
			"HeavyRangedWeaponForkMiniboss",
		},

		GeneratorData =
		{
			DifficultyRating = 500,
			MaxCount = 1,
			BlockEnemyTypes = { "HeavyRangedForked", "HeavyRangedForkedElite" },
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 4.5,
			Threshold = 0.65,
		},
	},

	HeavyRangedSplitterMiniboss =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseCrystal" },

		RequiredIntroEncounter = nil,
		PreferredSpawnPoint = "EnemyPointRanged",

		MaxHealth = 850,
		HealthBuffer = 1325,
		HealthBarOffsetY = -300,
		HealthBarType = "Large",

		IsAggroedSound = "/SFX/Enemy Sounds/HeavyRangedSplitterMiniboss/EmoteAlerted",
		Material = "Stone",
		HitSparkScale = 4.5,
		HitSparkOffsetZ = 325,

		IgnoreFrozenAnimFreeze = true,

		DefaultAIData =
		{
			PreAttackSound = "/SFX/Enemy Sounds/HeavyRangedSplitterMiniboss/EmoteAlerted2",
			PreAttackEndShake = false,

			PreAttackWaitForAnimation = true,
			FireDuration = 3.75,
			PostAttackDuration = 0.1,
			AIAttackDistance = 50,
			AIBufferDistance = 50,

			MoveToRandomSpawnPoint = true,
			MoveToSpawnPointDistanceMax = 9999,
			MoveToSpawnPointDistanceMin = 400,
			MoveToSpawnPointFromSelf = true,
		},
		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = AttackerAI,

		WeaponOptions =
		{
			"HeavyRangedWeaponSplitter",
		},
		WipeEnemyTypesOnKill = { "HeavyRangedSplitterFragment" },
		ExpireProjectilesOnKill = { "SpawnSplitterFragment" },
		CancelWeaponFireRequestsOnKill = true,

		OnDamagedWeapons = {
			SpawnSplitterFragment = { Requirements = { MaxUnitsByType = { HeavyRangedSplitterFragment = 12 } } },
		},

		GeneratorData =
		{
			DifficultyRating = 500,
		},

		MoneyDropOnDeath =
		{
			Chance = 1.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 20,
			MaxValue = 30,
			--ValuePerDifficulty = 0.33,
			--ValuePerDifficultyMaxValueVariance = 1.3,
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

		SpawnObstaclesOnDeath =
		{
			-- { Name = "HeavyRangedForkedCrystal4", RandomForceMin = 100, RandomForceMax = 400, UpwardForce = 1800 },
		},

		Tethers =
		{
		},
		OnDeathTetherUpwardForce = 1800,
		OnDeathTetherRandomForceMin = 100,
		OnDeathTetherRandomForceMax = 150,
	},

	HeavyRangedSplitterMinibossSuperElite =
	{
		InheritFrom = { "BaseVulnerableEnemy", "HeavyRangedSplitterMiniboss" },
		MaxHealth = 1500,
		HealthBuffer = 3000,
		WipeEnemyTypesOnKill = { "HeavyRangedSplitterFragmentSuperElite" },
		ExpireProjectilesOnKill = { "SpawnSplitterFragmentSuperElite" },

		OnDamagedWeapons = {
			SpawnSplitterFragmentSuperElite = { Requirements = { MaxUnitsByType = { HeavyRangedSplitterFragmentSuperElite = 12 } } },
		},

		GeneratorData =
		{
			DifficultyRating = 500,
			BlockSolo = true,
			BlockEnemyTypes = {"HeavyRangedSplitterMiniboss"},
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},
	},

	HeavyRangedSplitterFragment =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseCrystal" },

		MaxHealth = 20,
		HealthBuffer = 20,
		HealthBarOffsetY = -150,

		IsAggroedSound = "/SFX/Enemy Sounds/HeavyRangedSplitterFragment/CrystalAggroSMALL",
		Material = "Stone",

		DefaultAIData =
		{
			PreAttackSound = "/SFX/Enemy Sounds/HeavyRangedSplitterFragment/CrystalTargetAcquiredSMALL",
			PreAttackEndShake = true,

			PreAttackWaitForAnimation = true,
			PreAttackDuration = 0.3,
			PostAttackDuration = 1.0,
			AIAttackDistance = 700,
			AIBufferDistance = 700,

			MoveToRandomLocation = true,
			MoveToRandomLocationRadius = 1000,
			MoveToRandomLocationRadiusMin = 400,
			MoveToRandomLocationTimeout = 3.0,
		},
		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = AttackerAI,
		WeaponOptions = { "HeavyRangedSplitterFragment" },

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	HeavyRangedSplitterFragmentSuperElite =
	{
		InheritFrom = { "BaseVulnerableEnemy", "HeavyRangedSplitterFragment" },
		HealthBuffer = 50,

		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},
	},

	HealRanged =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseCrystal" },
		GenusName = "HealRanged",
		PreferredSpawnPoint = "EnemyPointSupport",

		MaxHealth = 100,
		HealthBarOffsetY = -160,

		IsAggroedSound = "/SFX/Enemy Sounds/Brimstone/ShieldCrystalAggro",
		Material = "Stone",

		DefaultAIData =
		{
			PreAttackSound = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract",
			PreAttackEndShake = true,

			PreAttackWaitForAnimation = true,
			PostAttackDuration = 3.0,
			StandOffTime = 1.0,
			AIAttackDistance = 1000,
			TargetFriends = true,
			IgnoreSelfType = true,
			TargetWeak = true,
			AIWanderDistance = 100,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 100,
		},
		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = AttackerAI,

		WeaponOptions =
		{
			"HealBeam",
		},

		SpawnObstaclesOnDeath =
		{
			{ Name = "HeavyRangedCrystal4", RandomForceMin = 100, RandomForceMax = 400, UpwardForce = 1800 },
		},

		Tethers =
		{
			{ Name = "HealRangedCrystal1", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
			{ Name = "HealRangedCrystal2", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
			{ Name = "HealRangedCrystal3", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
		},
		OnDeathTetherUpwardForce = 1800,
		OnDeathTetherRandomForceMin = 100,
		OnDeathTetherRandomForceMax = 150,

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		GeneratorData =
		{
			DifficultyRating = 10,
			BlockSolo = true,
			MaxCount = 4,
			BlockEnemyTypes = {"HealRangedElite"},
			BlockEnemyTypesSurvival = {"ShieldRanged", "ShieldRangedElite"},
		},
	},

	HealRangedElite =
	{
		InheritFrom = { "Elite", "HealRanged" },

		HealthBuffer = 100,

		GeneratorData =
		{
			DifficultyRating = 30,
			BlockSolo = true,
			MaxCount = 4,
			BlockEnemyTypes = {"HealRanged"},
			BlockEnemyTypesSurvival = {"ShieldRanged", "ShieldRangedElite"},
		},
		RequiredMinBiomeDepth = 3,
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 4.5,
			Threshold = 0.65,
		},
	},

	ShieldRanged =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseCrystal" },
		GenusName = "ShieldRanged",
		PreferredSpawnPoint = "EnemyPointSupport",

		BlockAttributes = { "ExtraDamage" },

		MaxHealth = 350,
		HealthBarOffsetY = -160,
		HealthBarType = "Medium",
		NoTargetMoveTowardsPlayer = true,
		SelfDestructIfNoAllies = true,

		IsAggroedSound = "/SFX/Enemy Sounds/Brimstone/ShieldCrystalAggro",
		Material = "Stone",

		DefaultAIData =
		{
			PreAttackSound = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract",
			PreAttackEndShake = true,

			PreAttackDuration = 1.05,
			PostAttackDuration = 6.0,
			AIAttackDistance = 300,
			AIBufferDistance = 300,

			TargetFriends = true,
			FireWeaponAtSelf = true,
			IgnoreSelfType = true,
			AIWanderDistance = 100,

			AIRequireProjectileLineOfSight = false,
			MoveSuccessDistance = 200,
		},
		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = AttackerAI,

		WeaponOptions =
		{
			"ShieldAlliesAoE",
		},
		SelfDestructWeapon = "ShieldRangedSelfDestruct",

		SpawnObstaclesOnDeath =
		{
			{ Name = "HealRangedCrystal4", RandomForceMin = 100, RandomForceMax = 400, UpwardForce = 1800 },
		},

		Tethers =
		{
			{ Name = "HealRangedCrystal1", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
			{ Name = "HealRangedCrystal2", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
			{ Name = "HealRangedCrystal3", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
		},
		OnDeathTetherUpwardForce = 1800,
		OnDeathTetherRandomForceMin = 100,
		OnDeathTetherRandomForceMax = 150,

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		GeneratorData =
		{
			DifficultyRating = 20,
			BlockSolo = true,
			MaxCount = 2,
			BlockEnemyTypes = {"ShieldRangedElite", "ShieldRangedSuperElite"},
			BlockEnemyTypesSurvival = {"HealRanged", "HealRangedElite"},
		},

		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Voidstones.
			{ Cue = "/VO/ZagreusField_1162", RequiredPlayed = { "/VO/ZagreusField_1163" } },
			-- Voidstones!
			{ Cue = "/VO/ZagreusField_1163" },
			-- More Voidstones!
			{ Cue = "/VO/ZagreusField_1164", RequiredPlayed = { "/VO/ZagreusField_1163" } },
			-- More Voidstones?
			{ Cue = "/VO/ZagreusField_1165", RequiredPlayed = { "/VO/ZagreusField_1163" } },
		},
	},

	ShieldRangedElite =
	{
		InheritFrom = { "Elite", "ShieldRanged" },

		HealthBuffer = 350,

		GeneratorData =
		{
			DifficultyRating = 25,
			BlockSolo = true,
			MaxCount = 2,
			BlockEnemyTypes = {"ShieldRanged", "ShieldRangedSuperElite"},
			BlockEnemyTypesSurvival = {"HealRanged", "HealRangedElite"},
		},
		RequiredMinBiomeDepth = 3,
		EliteAttributeData =
		{
			DeepInheritance = true,
			HeavyArmor =
			{
				DataOverrides =
				{
					HealthMultiplier = 2.0,
					HealthBarType = "ExtraLarge",
				},
			},
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	ShieldRangedSuperElite =
	{
		InheritFrom = { "SuperElite", "ShieldRangedElite" },
		HealthBuffer = 650,

		GeneratorData =
		{
			DifficultyRating = 100,
			BlockSolo = true,
			MaxCount = 2,
			BlockEnemyTypes = {"ShieldRanged", "ShieldRangedElite"},
			BlockEnemyTypesSurvival = {"HealRanged", "HealRangedElite"},
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},

		SpawnObstaclesOnDeath =
		{
			{
				Name = "HealRangedCrystal4", RandomForceMin = 100, RandomForceMax = 400, UpwardForce = 1800,
				HSV = { 0, -1, 0 },
				Color = { 128, 128, 128, 255 },
				Outline =
				{
					R = 196,
					G = 41,
					B = 2,
					Opacity = 0.8,
					Thickness = 3,
					Threshold = 0.6,
				},
			},
		},

		Tethers =
		{
			{ Name = "HealRangedCrystal1SuperElite", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
			{ Name = "HealRangedCrystal2SuperElite", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
			{ Name = "HealRangedCrystal3SuperElite", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	ShieldRangedMiniBoss =
	{
		InheritFrom = { "Elite", "ShieldRanged" },
		HealthBarType = "Large",
		SpawnObstaclesOnDeath =
		{
		},
		Tethers =
		{
			{ Name = "HealRangedCrystal1Miniboss", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
			{ Name = "HealRangedCrystal2Miniboss", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
			{ Name = "HealRangedCrystal3Miniboss", SpawnRadius = 80, Distance = 50, Elasticity = 1000.0, OwnerHitVelocity = 700, },
		},
		MaxHealth = 1200,
		HealthBuffer = 3750,

		DefaultAIData =
		{
			PreAttackSound = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract",
			PreAttackEndShake = true,

			PreAttackDuration = 1.05,
			PostAttackDuration = 2.0,
			AIAttackDistance = 300,
			AIBufferDistance = 300,

			TargetFriends = true,
			FireWeaponAtSelf = true,
			IgnoreSelfType = true,
			AIWanderDistance = 100,

			AIRequireProjectileLineOfSight = false,
			MoveSuccessDistance = 200,
		},

		WeaponOptions =
		{
			"ShieldAlliesAoELarge",
		},

		GeneratorData =
		{
			DifficultyRating = 25,
			BlockSolo = true,
			MaxCount = 2,
			BlockEnemyTypes = {"ShieldRanged", "ShieldRangedSuperElite"},
			BlockEnemyTypesSurvival = {"HealRanged", "HealRangedElite"},
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	RangedBurrower =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		MaxHealth = 120,
		GenusName = "RangedBurrower",

		RequiredIntroEncounter = "RangedBurrowerIntro",
		RequireEncounterCompleted = "BossHydra",

		PreferredSpawnPoint = "EnemyPointRanged",
		EliteAttributeOptions = CombineTables(EnemySets.AllEliteAttributes, EnemySets.RangedOnlyEliteAttributes ),
		BlockAttributes = { "Frenzy" },
		Groups = { "GroundEnemies" },

		IsAggroedSound = "/SFX/Enemy Sounds/RangedBurrower/EmoteAlerted",
		Material = "Organic",

		HitSparkScale = 1.0,
		DeathForce = 900,
		
		SpawnFx = "EnemyBurrowEntrance_BoneDracon",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"RangedBurrowerBurrow", "RangedBurrowerWeapon",
		},

		GeneratorData =
		{
			DifficultyRating = 22,
			BlockEnemyTypes = {"RangedBurrowerElite", "RangedBurrowerSuperElite"}
		},
		Binks =
		{
			"Enemy_BoneDracon_Idle_Bink",
			"Enemy_BoneDracon_OnHit_Bink",
			"Enemy_BoneDraconBurrowSet_Bink",
			"Enemy_BoneDraconAttackRange_Bink",
			"Enemy_BoneDraconDeathVFX_Bink",
		},

		HealthBarOffsetY = -180,
		HitSparkOffsetZ = 140,

		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = AttackerAI,
		AIAggroRange = 850,

		AmmoDropOnDeath =
		{
			Chance = 0.7,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,

			-- Dracons!
			{ Cue = "/VO/ZagreusField_3701" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_3701" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Dracons.
			{ Cue = "/VO/ZagreusField_3700", RequiredPlayed = { "/VO/ZagreusField_3701" }, },
			-- Dracons!
			{ Cue = "/VO/ZagreusField_3701" },
			-- More Dracons!
			{ Cue = "/VO/ZagreusField_3702", RequiredPlayed = { "/VO/ZagreusField_3701" }, },
			-- More Dracons?
			{ Cue = "/VO/ZagreusField_3703", RequiredPlayed = { "/VO/ZagreusField_3701" }, },
		},
	},

	RangedBurrowerElite =
	{
		InheritFrom = { "Elite", "RangedBurrower" },
		HealthBuffer = 180,

		WeaponOptions = { "RangedBurrowerBurrow", "RangedBurrowerWeaponElite" },
		BlockAttributes = { "Frenzy" },
		RequiredMinBiomeDepth = 2,

		GeneratorData =
		{
			DifficultyRating = 40,
			BlockEnemyTypes = {"RangedBurrower", "RangedBurrowerSuperElite"},
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	RangedBurrowerSuperElite =
	{
		InheritFrom = { "SuperElite", "Elite", "RangedBurrower" },
		HealthBuffer = 2000,

		GeneratorData =
		{
			DifficultyRating = 300,
			BlockSolo = true,
			BlockEnemyTypes = {"RangedBurrower", "RangedBurrowerElite"},
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},
	},

	Chariot =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "Chariot",

		Groups = { "GroundEnemies" },

		RequiredIntroEncounter = "ChariotIntro",

		MaxHealth = 1100,
		HealthBarOffsetY = -230,
		HealthBarType = "Large",
		HitSparkScale = 3.0,

		IsAggroedSound = "/SFX/Enemy Sounds/Chariot/ChariotAggro",
		--AIAggroRange = 800,
		Material = "Stone",

		DefaultAIData =
		{
			DeepInheritance = true,

			AIRequireProjectileLineOfSight = false,
			AIRequireUnitLineOfSight = true,
			SetupDistance = 400,
			SetupTimeout = 5.0,
			RamDistance = 80,
			RamTimeout = 2.0,
			RamWeaponName = "ChariotRam",
			RamEffectName = "RamBerserk",
			PreAttackAnimation = "ChariotAttackCharge",
			PreAttackSound = "/SFX/Enemy Sounds/Chariot/ChariotAttackStart",
			PreAttackShake = 400,
			PreAttackFlash = 1.0,
			PreAttackDuration = 0.5,
			PostAttackAnimation = "ChariotStop",
			RamRecoverTime = 2.0,

			UseRamAILoop = true,
		},
		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = AttackerAI,

		WeaponOptions = { "ChariotRam" },

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		GeneratorData =
		{
			DifficultyRating = 80,
			BlockEnemyTypes = { "ChariotElite", "ChariotSuperElite" },
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Chariots!
			{ Cue = "/VO/ZagreusField_1682" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_1682" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Chariots.
			{ Cue = "/VO/ZagreusField_1681", RequiredPlayed = { "/VO/ZagreusField_1682" } },
			-- Chariots!
			{ Cue = "/VO/ZagreusField_1682" },
			-- More Chariots!
			{ Cue = "/VO/ZagreusField_1683", RequiredPlayed = { "/VO/ZagreusField_1682" } },
			-- More Chariots?
			{ Cue = "/VO/ZagreusField_1684", RequiredPlayed = { "/VO/ZagreusField_1682" } },
		},

		LargeUnitCap = 3,
		Binks =
		{
			"Enemy_ChariotIdle_Bink",
			"Enemy_ChariotAttack_Bink",
			"Enemy_ChariotOnHit_Bink",
			"Enemy_ChariotDeathVFX_Bink",
		},
	},

	ChariotElite =
	{
		InheritFrom = { "Elite", "Chariot" },

		HealthBuffer = 700,

		DefaultAIData =
		{
			DeepInheritance = true,

			SetupDistance = 600,
		},

		GeneratorData =
		{
			DifficultyRating = 130,
			BlockSolo = true,
			BlockEnemyTypes = {"Chariot", "ChariotSuperElite"},
		},
		RequiredMinBiomeDepth = 3,
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	ChariotSuperElite =
	{
		InheritFrom = { "SuperElite", "Elite", "Chariot" },
		HealthBuffer = 1700,

		GeneratorData =
		{
			DifficultyRating = 300,
			BlockSolo = true,
			BlockEnemyTypes = {"Chariot", "ChariotElite"},
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	ChariotSuicide =
	{
		InheritFrom = { "Chariot" },
		GenusName = "ChariotSuicide",
		HitSparkScale = 1.2,

		Groups = { "GroundEnemies" },

		RequireEncounterCompleted = "ChariotIntro",
		RequiredIntroEncounter = "ChariotSuicideIntro",

		ActiveCapWeight = 0.5,
		LargeUnitCap = 6,

		MaxHealth = 60,
		HealthBarOffsetY = -130,
		HealthBarType = "Small",
		BlockSelfDamageNumbers = true,

		IsAggroedSound = "/SFX/Enemy Sounds/FireChariot/FireChariotAggro",
		--AIAggroRange = 900,

		DefaultAIData =
		{
			AIRequireProjectileLineOfSight = false,
			AIRequireUnitLineOfSight = true,
			SetupDistance = 800,
			SetupTimeout = 5.0,
			RamDistance = 10,
			RamTimeout = 6.0,
			RamWeaponName = "ChariotRamSelfDestruct",
			RamEffectName = "RamBerserk",
			PreAttackAnimation = "SuicideChariotAttackCharge",
			PreAttackSound = "/SFX/Enemy Sounds/FireChariot/FireChariotAttackStart",
			PreAttackShake = 400,
			PreAttackFlash = 1.0,
			PreAttackDuration = 0.5,
			PostAttackAnimation = "ChariotSuicideStop",
			RamRecoverTime = 2.0,
		},

		GeneratorData =
		{
			DifficultyRating = 15,
			BlockEnemyTypes = { "ChariotSuicideElite" },
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Flame Wheels!
			{ Cue = "/VO/ZagreusField_1972" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_1972" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			RequiredFalseRooms = { "C_MiniBoss02" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Flame Wheels.
			{ Cue = "/VO/ZagreusField_1971", RequiredPlayed = { "/VO/ZagreusField_1972" } },
			-- Flame Wheels!
			{ Cue = "/VO/ZagreusField_1972" },
			-- More Flame Wheels!
			{ Cue = "/VO/ZagreusField_1973", RequiredPlayed = { "/VO/ZagreusField_1972" } },
			-- More Flame Wheels?
			{ Cue = "/VO/ZagreusField_1974", RequiredPlayed = { "/VO/ZagreusField_1972" } },
		},

		Binks =
		{
			"Enemy_ChariotSmallIdle_Bink",
			"Enemy_ChariotSmallAttack_Bink",
			"Enemy_ChariotSmallOnHit_Bink",
			"Enemy_ChariotSmallDeathVFX_Bink",
		},

	},

	ChariotSuicideElite =
	{
		InheritFrom = { "Elite", "ChariotSuicide" },

		Groups = { "GroundEnemies" },
		BlockAttributes = { "ExtraDamage", "HeavyArmor", "DeathSpreadHitShields" },


		HealthBuffer = 60,
		HealthBarOffsetY = -140,
		HealthBarType = "Medium",

		GeneratorData =
		{
			DifficultyRating = 40,
			BlockEnemyTypes = { "ChariotSuicide" },
		},
		RequiredMinBiomeDepth = 3,
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	SupportShields =
	{
		PreferredSpawnPoint = "EnemyPointSupport",
		RequiredIntroEncounter = "SupportShieldsIntro",

		RequiredKill = true,

		PreAttackDuration = 1.00,
		PreAttackSound = "/Leftovers/SFX/PlayerMovementPower",
		PreAttackAnimation = "GhostSupportAttackAnim",
		-- PreAttackEndShakeSound = "/Leftovers/Menu Sounds/TitanToggleShort",
		PostAttackCooldown = 6.00,
		PreAttackColor = Color.Blue,
		PostAttackAnimation = "GhostSupportIdleAnim",

		Material = "Organic",

		MaxHealth = 300,
		HealthBarOffsetY = -200,

		WeaponOptions =
		{
			"ShieldAlliesGun"
		},
		AIOptions =
		{
			AttackAllies,
		},
		AggroMinimumDistance = 500,

		GeneratorData =
		{
			DifficultyRating = 7,
			BlockSolo = true,
		},
	},

	-- SPAWNER
	BaseSpawner =
	{
		BlockAttributes = { "Blink", "ExtraDamage" },

		PreferredSpawnPoint = "EnemyPointSupport",
		Material = "Bone",

		HealthBarOffsetY = -130,
		HitSparkScale = 2.4,

		BlockAttributes = { "Disguise", "ExtraDamage" },

		AIOptions =
		{
			SpawnerAI,
		},
		AggroSpawnsOnHit = true,

		AmmoDropOnDeath =
		{
		  Chance = 1.0,
		  MinAmmo = 1,
		  MaxAmmo = 1,
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Skullomats!
			{ Cue = "/VO/ZagreusField_0861" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_0861" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Skullomats.
			{ Cue = "/VO/ZagreusField_0860", RequiredPlayed = { "/VO/ZagreusField_0861" } },
			-- Skullomats!
			{ Cue = "/VO/ZagreusField_0861" },
			-- More Skullomats!
			{ Cue = "/VO/ZagreusField_0862", RequiredPlayed = { "/VO/ZagreusField_0861" } },
			-- More Skullomats?
			{ Cue = "/VO/ZagreusField_0863", RequiredPlayed = { "/VO/ZagreusField_0861" } },
		},
	},

	LightSpawner =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseSpawner" },
		GenusName = "LightSpawner",
		RequiredMinCompletedRuns = 1,

		RequiredIntroEncounter = "LightSpawnerIntro",

		CreateSpawnAnimation = "SpawnerPopingSkulls",
		--SpawnedUnitAnimation = "GhostParticles",
		PostCreateSpawnAnimation = "SpawnerIdleAnim",

		MaxHealth = 120,
		HealthBarOffsetY = -180,

		SpawnerOptions =
		{
			"Swarmer",
		},
		SpawnBurstDelay = 4.5,
		SpawnsPerBurst = 3,
		SpawnRadius = 0,
		SpawnRate = 1.2,
		SpawnDelay = 0.60,
		MaxActiveSpawns = 5,
		SpawnedAggroTetherDistance = 750,

		GeneratorData =
		{
			DifficultyRating = 10,
			MaxCount = 4,
			BlockSolo = true,
			BlockEnemyTypes = {"LightSpawnerElite", "LightSpawnerSuperElite"}
		},
	},

	LightSpawnerElite =
	{
		InheritFrom = { "Elite", "LightSpawner" },
		MaxHealth = 500,
		HealthBuffer = 500,

		IneligibleIfUncompletedIntroEncounter = true,

		BlockAttributes = { "Disguise", "ExtraDamage", "Blink" },

		SpawnerOptions =
		{
			"SwarmerElite",
		},
		SpawnBurstDelay = 4.5,
		SpawnRate = 1.2,
		SpawnsPerBurstMin = 1,
		SpawnsPerBurstMax = 3,
		MaxActiveSpawns = 6,
		SpawnedAggroTetherDistance = 1200,
		GeneratorData =
		{
			DifficultyRating = 120,
			MaxCount = 1,
			BlockSolo = true,
			BlockEnemyTypes = {"LightSpawner", "LightSpawnerSuperElite"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	LightSpawnerSuperElite =
	{
		InheritFrom = { "SuperElite", "Elite", "LightSpawner" },
		MaxHealth = 500,
		HealthBuffer = 1500,

		SpawnerOptions =
		{
			"SwarmerElite",
		},

		SpawnsPerBurst = 1,
		MaxActiveSpawns = 6,
		SpawnRate = 0.4,
		GeneratorData =
		{
			DifficultyRating = 250,
			MaxCount = 1,
			BlockSolo = true,
			BlockEnemyTypes = {"LightSpawner", "LightSpawnerElite"}
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 8,
			Threshold = 0.75,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	ShadeSpawner =
	{
		InheritFrom = { "BaseVulnerableEnemy", "BaseSpawner" },
		GenusName = "ShadeSpawner",
		RequiredMinBiomeDepth = 3,

		--SpawnAnimation = "SpawnerPopingSkulls",
		--PostSpawnAnimation = "SpawnerIdleAnim",

		MaxHealth = 280,
		HealthBarOffsetY = -180,

		SpawnerOptions =
		{
			"ShadeNaked",
		},
		SpawnBurstDelay = 4.5,
		SpawnsPerBurst = 1,
		SpawnRadius = 0,
		SpawnRate = 5.0,
		SpawnDelay = 0.00,
		MaxActiveSpawns = 3,
		SpawnedAggroTetherDistance = 750,

		GeneratorData =
		{
			DifficultyRating = 20,
			MaxCount = 3,
			BlockSolo = true,
			BlockEnemyTypes = {"ShadeSpawnerElite"}
		},
	},

	ShadeSpawnerElite =
	{
		InheritFrom = { "Elite", "ShadeSpawner" },
		HealthBuffer = 120,

		SpawnerOptions =
		{
			"ShadeNakedElite",
		},
		SpawnsPerBurst = 1,
		MaxActiveSpawns = 3,
		GeneratorData =
		{
			DifficultyRating = 40,
			MaxCount = 3,
			BlockSolo = true,
			BlockEnemyTypes = {"ShadeSpawner"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 4,
			Threshold = 0.6,
		},
	},

	FlurrySpawner =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "FlurrySpawner",

		MaxHealth = 1100,
		HealthBarOffsetY = -130,
		HealthBarType = "MediumLarge",

		IsAggroedSound = "/SFX/Enemy Sounds/Brimstone/CrystalAggro",
		--AIAggroRange = 3000,
		Material = "Stone",

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackSound = "/SFX/Enemy Sounds/FlurrySpawnerPreAttack",
			PreAttackEndShake = true,

			PreAttackDuration = 1.0,
			PostAttackDuration = 5.5,
			AIAttackDistance = 2000,

			AIBufferDistance = 1250,
			RetreatTimeout = 0.5,
			RetreatAfterAttack = true,
			RetreatToSpawnPoints = true,

			SkipStopBeforeAttack = true,
			SkipStopBeforeAttackEnd = true,
			SkipMovement = true,
		},
		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = AttackerAI,

		WeaponOptions =
		{
			"FlurrySpawnerWeapon",
		},

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		GeneratorData =
		{
			DifficultyRating = 60,
			BlockSolo = true,
			MaxCount = 3,
			BlockEnemyTypes = { "FlurrySpawnerElite", "FlurrySpawnerSuperElite" }
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Soul Catchers!
			{ Cue = "/VO/ZagreusField_1968" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_1968" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			RequiredFalseRooms = { "C_MiniBoss02" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Soul Catchers.
			{ Cue = "/VO/ZagreusField_1967", RequiredPlayed = { "/VO/ZagreusField_1968" } },
			-- Soul Catchers!
			{ Cue = "/VO/ZagreusField_1968" },
			-- More Soul Catchers!
			{ Cue = "/VO/ZagreusField_1969", RequiredPlayed = { "/VO/ZagreusField_1968" } },
			-- More Soul Catchers?
			{ Cue = "/VO/ZagreusField_1970", RequiredPlayed = { "/VO/ZagreusField_1968" } },
		},
	},

	FlurrySpawnerElite =
	{
		InheritFrom = { "Elite", "FlurrySpawner" },

		BlockAttributes = { "HeavyArmor" },

		MaxHealth = 2000,
		HealthBuffer = 2400,
		HealthBarOffsetY = -160,
		HealthBarType = "Large",

		RequiredSpawnPoint = "EnemyPointRanged",

		ShrineMetaUpgradeName = "MinibossCountShrineUpgrade",
		ShrineWeaponOptionsOverwrite = { "FlurrySpawnerWeaponElite", "FlurrySpawnerDash" },
		ShrineDefualtAIDataOverwrites = { PostAttackDuration = 1.0 },

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 1.0,
			PostAttackDuration = 4.0,
			AIAttackDistance = 3000,
		},

		WeaponOptions =
		{
			"FlurrySpawnerWeaponElite",
		},

		GeneratorData =
		{
			DifficultyRating = 120,
			BlockSolo = true,
			MaxCount = 1,
			BlockEnemyTypes = { "FlurrySpawner", "FlurrySpawnerSuperElite" },
		},
		RequiredMinBiomeDepth = 3,
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 4.5,
			Threshold = 0.65,
		},
	},

	FlurrySpawnerSuperElite =
	{
		InheritFrom = { "SuperElite", "FlurrySpawnerElite" },

		MaxHealth = 2500,
		HealthBuffer = 2800,
		HealthBarOffsetY = -160,
		HealthBarType = "Large",

		RequiredSpawnPoint = "EnemyPointRanged",

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 1.0,
			PostAttackDuration = 5.0,
			AIAttackDistance = 3000,
		},

		WeaponOptions =
		{
			"FlurrySpawnerWeaponElite",
		},

		RequiredMinBiomeDepth = 20,
		GeneratorData =
		{
			DifficultyRating = 500,
			BlockSolo = false,
			MaxCount = 1,
			BlockEnemyTypes = { "FlurrySpawner", "FlurrySpawnerElite" },
		},

		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 4.5,
			Threshold = 0.65,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	UnstableGenerator =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "UnstableGenerator",

		MaxHealth = 3000,
		HealthBarOffsetY = -130,
		HealthBarType = "Large",

		IsAggroedSound = "/SFX/Enemy Sounds/Brimstone/CrystalAggro",
		Material = "Stone",

		RequiredSpawnPoint = "EnemyPointSupport",

		DefaultAIData =
		{
			TeleportationIntervalMin = 4.5,
			TeleportationIntervalMax = 9.0,
			TeleportToSpawnPoints = true,
			TeleportToSpawnPointType = "EnemyPointSupport",
			TeleportStartFx = "IllusionistPuff",
			--TeleportAnimation = "",

			PreAttackSound = "/SFX/Enemy Sounds/FlurrySpawnerPreAttack",
			PreAttackEndShake = true,

			EscalationLevel = 0,
			MaxEscalationLevel = 5,
			EscalationInterval = 6,
			AttackSlotsPerTickMin = 2,
			AttackSlotsPerTickMax = 3,

			PreAttackDuration = 0.3,
			FireDuration = 0.0,
			PostAttackDuration = 2.0,

			EscalateSound = "/SFX/Enemy Sounds/Brimstone/CrystalAggro",
			EscalateFx = "ShadeWeaponPickup",

			EscalationAIDataOverwrites = {
				-- 1
				{
					AttackSlotsPerTickMin = 4,
					AttackSlotsPerTickMax = 4,
					EscalateAnimation = "UnstableGeneratorIdle_Level1",
				},

				-- 2
				{
					AttackSlotsPerTickMin = 8,
					AttackSlotsPerTickMax = 8,
					EscalateAnimation = "UnstableGeneratorIdle_Level2",
					PostAttackDuration = 1.5,
				},

				-- 3
				{
					AttackSlotsPerTickMin = 12,
					AttackSlotsPerTickMax = 12,
					EscalateAnimation = "UnstableGeneratorIdle_Level3",
				},

				-- 4
				{
					AttackSlotsPerTickMin = 18,
					AttackSlotsPerTickMax = 18,
					PostAttackDuration = 1.0,
					EscalateAnimation = "UnstableGeneratorIdle_Level4",
				},

				-- 5
				{
					AttackSlotsPerTickMin = 22,
					AttackSlotsPerTickMax = 22,
					PostAttackDuration = 0.5,
					EscalateAnimation = "UnstableGeneratorIdle_Level5",
				},
			},
		},

		AIOptions =
		{
			UnstableGeneratorAI,
		},

		WeaponOptions =
		{
			"UnstableGeneratorWeapon",
		},

		GeneratorData =
		{
			DifficultyRating = 35,
			BlockSolo = true,
			MaxCount = 3,
			BlockEnemyTypes = { "FlurrySpawnerElite" }
		},
	},

	UnstableGeneratorElite =
	{
		InheritFrom = { "Elite", "UnstableGenerator" },

		MaxHealth = 3000,
		HealthBuffer = 3000,
		HealthBarOffsetY = -160,
		HealthBarType = "Large",

		WeaponOptions =
		{
			"FlurrySpawnerWeaponElite",
		},

		GeneratorData =
		{
			DifficultyRating = 200,
			BlockSolo = true,
			MaxCount = 1,
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 4.5,
			Threshold = 0.65,
		},
	},

	-- BLOODLESS
	BaseBloodless =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		Groups = { "GroundEnemies" },
		Material = "Bone",
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedSkeleton",
			Rapid = "HitSparkEnemyDamagedSkeletonRapid",
		},
		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteAlerted",
		HealthBarOffsetY = -200,
		HitSparkScale = 1.5,
		HitSparkOffsetZ = 100,

		BlockAttributes = { "Blink" },
		SkipSetupSelectWeapon = true,

		AIOptions =
		{
			AggroAI,
		},
		--AIAggroRange = 725,
		PostAggroAI = LeapIntoRangeAI,
		DefaultAIData =
		{
			DeepInheritance = true,
			LeapSound = "/SFX/Enemy Sounds/Bloodless01/EmoteThrustAttacking",
			LeapLandingSound = "/SFX/Enemy Sounds/Bloodless01/EmoteHurt",
			LeapWhenTargetBeyondDistance = 1400,
			LeapWhenTargetOutOfSight = true,
			LeapSpeed = 2000,
			LeapPrepareTime = 0.5,
			LeapRecoveryTime = 0.5,
			LeapOffsetRange = 1200,
			AIMoveWithinRangeTimeoutMin = 4.0,
			AIMoveWithinRangeTimeoutMax = 8.0,
		},

		AmmoDropOnDeath =
		{
		  Chance = 1.0,
		  MinAmmo = 1,
		  MaxAmmo = 3,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.15,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			RequiredFalseRooms = { "A_MiniBoss01", "A_MiniBoss02" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Bloodless.
			{ Cue = "/VO/ZagreusField_0852", RequiredPlayed = { "/VO/ZagreusField_0853" } },
			-- Bloodless!
			{ Cue = "/VO/ZagreusField_0853" },
			-- More Bloodless!
			{ Cue = "/VO/ZagreusField_0854", RequiredPlayed = { "/VO/ZagreusField_0853" } },
			-- More Bloodless?
			{ Cue = "/VO/ZagreusField_0855", RequiredPlayed = { "/VO/ZagreusField_0853" } },
		},
	},

	BloodlessNaked =
	{
		InheritFrom = { "BaseBloodless" },
		GenusName = "BloodlessNaked",
		PreferredSpawnPoint = "EnemyPointMelee",

		LargeUnitCap = 5,

		MaxHealth = 310,
		HealthBuffer = 0,

		HealthBarOffsetY = -155,
		HealthBarType = "Medium",

		DefaultAIData =
		{
			DeepInheritance = true,

			LeapOffsetRange = 700,
			LeapWhenTargetBeyondDistance = 750,
			LeapWhenTargetOutOfSight = true,

			-- PreAttackSound = "/SFX/Enemy Sounds/Bloodless01/EmoteCharging",
			PreAttackAnimation = "EnemySkellyAttackCharge",
			FireAnimation = "EnemySkellyAttackFire",

			LeapChargeAnimation = "Enemy_SkellyLeapLong_Charge",
			LeapLandingAnimation = "Enemy_SkellyLeapLong_Landing",
		},

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		WeaponOptions =
		{
			"BloodlessMelee",
		},

		GeneratorData =
		{
			DifficultyRating = 12,
			BlockEnemyTypes = {"BloodlessNakedElite", "BloodlessNakedSuperElite"}
		},

		Binks =
		{
			"Enemy_BloodlessNaked_OnHit_Bink",
			"Enemy_BloodlessNaked_Attack_Bink",
			"Enemy_BloodlessNaked_Idle_Bink",
			"Enemy_BloodlessNaked_StartStop_Bink",
			"Enemy_BloodlessNaked_Leap_Bink",
			"Enemy_BloodlessNaked_LeapLong_Bink",
			"Enemy_BloodlessNaked_Walk_Bink",
			"Enemy_BloodlessNaked_WalkFidget_Bink",
			"Enemy_SkellyDeathVFX_Bink",
		},
	},

	BloodlessNakedElite =
	{
		InheritFrom = { "Elite", "BloodlessNaked" },

		RequiredMinBiomeDepth = 2,
		HealthBuffer = 250,
		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteTaunting",

		GeneratorData =
		{
			DifficultyRating = 25,
			BlockEnemyTypes = {"BloodlessNaked", "BloodlessNakedSuperElite"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.7,
		},
	},

	BloodlessNakedSuperElite =
	{
		InheritFrom = { "SuperElite", "Elite", "BloodlessNaked" },

		HealthBuffer = 1600,
		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteTaunting",

		GeneratorData =
		{
			DifficultyRating = 150,
			BlockEnemyTypes = {"BloodlessNaked", "BloodlessNakedElite"}
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 4.5,
			Threshold = 0.65,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	BloodlessNakedBerserker =
	{
		InheritFrom = { "BloodlessNaked" },
		PreferredSpawnPoint = "EnemyPointMelee",
		RequiredIntroEncounter = "BerserkerIntro",
		GenusName = "BloodlessNakedBerserker",

		LargeUnitCap = 5,
		MaxHealth = 400,

		HealthBarOffsetY = -155,
		HealthBarType = "MediumLarge",

		IsAggroedSound = "/SFX/Enemy Sounds/BloodlessBerserker/EmoteAlerted",

		DefaultAIData =
		{
			DeepInheritance = true,
			LeapWhenTargetBeyondDistance = 99999,
			LeapWhenTargetOutOfSight = false,
			LeapRecoveryTime = 1.0,
			RetreatLeapDistance = 800,
			RetreatLeapMinDistance = 50,

			PreAttackSound = nil,
			PreAttackAnimation = "Enemy_BloodlessNakedBerserkAttacks_Start",

			LeapChargeAnimation = "Enemy_SkellyLeapLong_Charge",
			LeapLandingAnimation = "Enemy_SkellyLeapLong_Landing",
		},

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		WeaponOptions =
		{
			"BloodlessMeleeBerserkerCombo1"
		},

		GeneratorData =
		{
			DifficultyRating = 30,
			BlockEnemyTypes = {"BloodlessNakedBerserkerElite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Bone-Rakers!
			{ Cue = "/VO/ZagreusField_3697" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_3697" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Bone-Rakers.
			{ Cue = "/VO/ZagreusField_3696", RequiredPlayed = { "/VO/ZagreusField_3697" }, },
			-- Bone-Rakers!
			{ Cue = "/VO/ZagreusField_3697" },
			-- More Bone-Rakers!
			{ Cue = "/VO/ZagreusField_3698", RequiredPlayed = { "/VO/ZagreusField_3697" }, },
			-- More Bone-Rakers?
			{ Cue = "/VO/ZagreusField_3699", RequiredPlayed = { "/VO/ZagreusField_3697" }, },
		},

		Binks =
		{
			"Enemy_BloodlessNaked_OnHit_Bink",
			"Enemy_BloodlessNakedBerserk_Attacks_Bink",
			"Enemy_BloodlessNaked_Idle_Bink",
			"Enemy_BloodlessNaked_StartStop_Bink",
			"Enemy_BloodlessNaked_Leap_Bink",
			"Enemy_BloodlessNaked_LeapLong_Bink",
			"Enemy_BloodlessNaked_Walk_Bink",
			"Enemy_BloodlessNaked_WalkFidget_Bink",
			"Enemy_SkellyDeathVFX_Bink",
		},


	},

	BloodlessNakedBerserkerElite =
	{
		InheritFrom = { "Elite", "BloodlessNakedBerserker" },

		RequiredMinBiomeDepth = 2,
		HealthBuffer = 325,
		IsAggroedSound = "/SFX/Enemy Sounds/BloodlessBerserker/EmoteTaunting",

		GeneratorData =
		{
			DifficultyRating = 80,
			BlockEnemyTypes = {"BloodlessNakedBerserker" }
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.7,
		},
	},

	BloodlessWaveFist =
	{
		InheritFrom = { "BaseBloodless" },
		GenusName = "BloodlessWaveFist",
		PreferredSpawnPoint = "EnemyPointMelee",
		RequiredIntroEncounter = "WaveFistIntro",

		MaxHealth = 430,
		HealthBuffer = 0,

		HealthBarOffsetY = -175,
		HealthBarType = "MediumLarge",

		LargeUnitCap = 5,

		DefaultAIData =
		{
			DeepInheritance = true,

			LeapWhenTargetWithinDistance = 550,
			LeapWhenTargetOutOfSight = false,

			PreAttackAnimation = "Enemy_BloodlessWaveAttacks_Start",
			FireAnimation = "Enemy_BloodlessWaveAttacks_Fire",

			LeapChargeAnimation = "Enemy_SkellyLeapLong_Charge",
			LeapLandingAnimation = "Enemy_SkellyLeapLong_Landing",

			RetreatLeapDistance = 2000,
			RetreatLeapMinDistance = 1500,
		},

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		WeaponOptions =
		{
			"BloodlessWaveFistWeapon",
		},

		GeneratorData =
		{
			DifficultyRating = 40,
			BlockEnemyTypes = {"BloodlessWaveFistElite"}
		},

		Binks =
		{
			"Enemy_BloodlessNaked_OnHit_Bink",
			"Enemy_BloodlessNaked_Attack_Bink",
			"Enemy_BloodlessWave_Attack_Bink",
			"Enemy_BloodlessNaked_Idle_Bink",
			"Enemy_BloodlessNaked_StartStop_Bink",
			"Enemy_BloodlessNaked_Leap_Bink",
			"Enemy_BloodlessNaked_LeapLong_Bink",
			"Enemy_BloodlessNaked_Walk_Bink",
			"Enemy_BloodlessNaked_WalkFidget_Bink",
			"Enemy_SkellyDeathVFX_Bink",
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Wave-Makers!
			{ Cue = "/VO/ZagreusField_1439" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_1439" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			RequiredFalseRooms = { "A_MiniBoss01", "A_MiniBoss02" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Wave-Makers.
			{ Cue = "/VO/ZagreusField_1438", RequiredPlayed = { "/VO/ZagreusField_1439" } },
			-- Wave-Makers!
			{ Cue = "/VO/ZagreusField_1439" },
			-- More Wave-Makers!
			{ Cue = "/VO/ZagreusField_1440", RequiredPlayed = { "/VO/ZagreusField_1439" } },
			-- More Wave-Makers?
			{ Cue = "/VO/ZagreusField_1441", RequiredPlayed = { "/VO/ZagreusField_1439" } },
			-- All right, lads, let's see who makes the bigger waves.
			{ Cue = "/VO/ZagreusField_2678", RequiredTrait = "SwordThrustWaveTrait", RequiredPlayed = { "/VO/ZagreusField_1439" } },
			-- Hello, Wave-Makers! I, too, can make waves.
			{ Cue = "/VO/ZagreusField_2679", RequiredTrait = "SwordThrustWaveTrait", RequiredPlayed = { "/VO/ZagreusField_1439" } },
			-- I can make waves too.
			{ Cue = "/VO/ZagreusField_2680", RequiredTrait = "SwordThrustWaveTrait", RequiredPlayed = { "/VO/ZagreusField_1439" } },
			-- Your waves against mine.
			{ Cue = "/VO/ZagreusField_2681", RequiredTrait = "SwordThrustWaveTrait", RequiredPlayed = { "/VO/ZagreusField_1439" } },

		},
	},

	BloodlessWaveFistElite =
	{
		InheritFrom = { "Elite", "BloodlessWaveFist" },

		RequiredMinBiomeDepth = 2,
		HealthBuffer = 450,
		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteTaunting",

		WeaponOptions =
		{
			"BloodlessWaveFistWeaponElite",
		},

		GeneratorData =
		{
			DifficultyRating = 75,
			BlockEnemyTypes = {"BloodlessWaveFist"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 1.0,
			Thickness = 1.5,
			Threshold = 0.7,
		},
	},

	BloodlessGrenadier =
	{
		InheritFrom = { "BaseBloodless" },
		GenusName = "BloodlessGrenadier",
		PreferredSpawnPoint = "EnemyPointRanged",

		MaxHealth = 500,
		HealthBarType = "Large",
		HealthBarOffsetY = -220,
		HitSparkScale = 2.0,
		HitSparkOffsetZ = 180,
		AttachedAnimationOffsetZ = 0,

		WeaponOptions = { "BloodlessGrenadierRanged", "BloodlessGrenadierCluster" },

		DefaultAIData =
		{
			DeepInheritance = true,

			LeapChargeAnimation = "Enemy_BloodlessGrenadierJump_Charge",
			LeapLandingAnimation = "Enemy_BloodlessGrenadierJump_Landing",

			LeapSound = "/SFX/Enemy Sounds/Bloodless02/EmoteThrustAttacking",
			LeapLandingSound = "/SFX/Enemy Sounds/Bloodless02/EmoteHurt",

			PreAttackDuration = 0.3,
			PostAttackDuration = 1.5,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 150,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,

			AIAttackDistance = 700,
			AIRetreatDistance = 600,
			LeapWhenTargetBeyondDistance = 500,
			RetreatLeapDistance = 1500,
			RetreatLeapMinDistance = 600,
			PreAttackEndShake = false,
		},

		GeneratorData =
		{
			DifficultyRating = 50,
			--MaxCount = 2,
			BlockEnemyTypes = {"BloodlessGrenadierElite"}
		},

		LargeUnitCap = 5,
		Binks =
		{
			"Enemy_BloodlessGrenadierIdle_Bink",
			"Enemy_BloodlessGrenadierWalk_Bink",
			"Enemy_BloodlessGrenadierJump_Bink",
			"Enemy_BloodlessGrenadierCharge_Bink",
			"Enemy_BloodlessGrenadierAttack_Bink",
			"Enemy_BloodlessGrenadierOnHit_Bink",
			"Enemy_BloodlessGrenadierSelfDestruct_Bink",
			"Enemy_BloodlessGrenadierDeathVFX_Bink",
			"Enemy_SkellyDeathVFX_Bink",
		},

		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			RequiredFalseRooms = { "A_MiniBoss01", "A_MiniBoss02" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Inferno-bombers.
			{ Cue = "/VO/ZagreusField_1166", RequiredPlayed = { "/VO/ZagreusField_1167" } },
			-- Inferno-bombers!
			{ Cue = "/VO/ZagreusField_1167" },
			-- More Inferno-bombers!
			{ Cue = "/VO/ZagreusField_1168", RequiredPlayed = { "/VO/ZagreusField_1167" } },
			-- More Inferno-bombers?
			{ Cue = "/VO/ZagreusField_1169", RequiredPlayed = { "/VO/ZagreusField_1167" } },
		},
	},

	BloodlessGrenadierElite =
	{
		InheritFrom = { "Elite", "BloodlessGrenadier" },

		HealthBuffer = 700,
		RequiredMinBiomeDepth = 2,

		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless02/EmoteTaunting",

		WeaponOptions = { "BloodlessGrenadierRangedElite", "BloodlessGrenadierCluster" },

		GeneratorData =
		{
			DifficultyRating = 80,
			--MaxCount = 3,
			BlockEnemyTypes = {"BloodlessGrenadier"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.98,
		},
	},

	BloodlessSelfDestruct =
	{
		InheritFrom = { "BaseBloodless" },
		GenusName = "BloodlessSelfDestruct",
		PreferredSpawnPoint = "EnemyPointMelee",
		RequiredIntroEncounter = "SelfDestructIntro",

		MaxHealth = 500,
		HealthBarType = "MediumLarge",
		HealthBarOffsetY = -160,

		WeaponOptions = { "BloodlessGrenadierDive", "BloodlessReposition" },

		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteAlerted",

		DefaultAIData =
		{
			DeepInheritance = true,

			LeapChargeAnimation = "Enemy_BloodlessGrenadierJump_Charge",
			LeapLandingAnimation = "Enemy_BloodlessGrenadierJump_Landing",
			LeapLandingSound = "/EmptyCue",

			RepositionLeap = true,
			LeapOffsetRange = 300,
			LeapRecoveryTime = 0.0,
			AIBufferDistance = 500,
			RetreatTimeout = 1.5,

			PostAttackDuration = 0.5,
			LeapWhenTargetBeyondDistance = 300,
		},

		GeneratorData =
		{
			DifficultyRating = 35,
			BlockEnemyTypes = {"BloodlessSelfDestructElite"}
		},


		LargeUnitCap = 5,
		Binks =
		{
			"Enemy_BloodlessGrenadierIdle_Bink",
			"Enemy_BloodlessGrenadierWalk_Bink",
			"Enemy_BloodlessGrenadierJump_Bink",
			"Enemy_BloodlessGrenadierCharge_Bink",
			"Enemy_BloodlessGrenadierAttack_Bink",
			"Enemy_BloodlessGrenadierOnHit_Bink",
			"Enemy_BloodlessGrenadierSelfDestruct_Bink",
			"Enemy_BloodlessGrenadierDeathVFX_Bink"
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Slam-dancers!
			{ Cue = "/VO/ZagreusField_1171" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_1171" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			RequiredFalseRooms = { "A_MiniBoss01", "A_MiniBoss02" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Slam-dancers.
			{ Cue = "/VO/ZagreusField_1170", RequiredPlayed = { "/VO/ZagreusField_1171" } },
			-- Slam-dancers!
			{ Cue = "/VO/ZagreusField_1171" },
			-- More Slam-dancers!
			{ Cue = "/VO/ZagreusField_1172", RequiredPlayed = { "/VO/ZagreusField_1171" } },
			-- More Slam-dancers?
			{ Cue = "/VO/ZagreusField_1173", RequiredPlayed = { "/VO/ZagreusField_1171" } },
		},
	},

	BloodlessSelfDestructElite =
	{
		InheritFrom = { "Elite", "BloodlessSelfDestruct" },
		HealthBuffer = 600,
		RequiredMinBiomeDepth = 2,

		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteTaunting",

		WeaponOptions = { "BloodlessGrenadierDive", "BloodlessReposition", "BloodlessReposition" },
		ChanceToRepositionAsWeapon = 0.75,

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.95,
		},

		GeneratorData =
		{
			DifficultyRating = 55,
			BlockEnemyTypes = {"BloodlessSelfDestruct"}
		},
	},

	BloodlessPitcher =
	{
		InheritFrom = { "BaseBloodless" },
		GenusName = "BloodlessPitcher",

		PreferredSpawnPoint = "EnemyPointRanged",
		RequiredIntroEncounter = "PitcherIntro",

		MaxHealth = 350,
		HealthBarType = "MediumLarge",
		HealthBarOffsetY = -200,
		HitSparkOffsetZ = 180,
		HitSparkScale = 1.3,

		DefaultAIData =
		{
			DeepInheritance = true,

			LeapChargeAnimation = "Enemy_BloodlessGrenadierJump_Charge",
			LeapLandingAnimation = "Enemy_BloodlessGrenadierJump_Landing",
			LeapSound = "/SFX/Enemy Sounds/Bloodless02/EmoteThrustAttacking",
			LeapLandingSound = "/SFX/Enemy Sounds/Bloodless02/EmoteHurt",

			PreAttackSound = "/SFX/Enemy Sounds/Bloodless02/EmoteCharging",

			PreAttackAnimation = "Enemy_BloodlessPitcherAttack_Charge",
			PreFireAnimation = "Enemy_BloodlessGrenadierAttack_Fire",
			-- FireAnimation = "Enemy_BloodlessGrenadierAttack_Fire",
			PostAttackAnimation = "Enemy_BloodlessGrenadierAttack_ReturnToIdle",
			PreAttackWaitForAnimation = true,

			PreAttackEndShake = true,

			PreAttackDurationMin = 0.8,
			PreAttackDurationMax = 1.8,
			PreFireDuration = 0.0,
			PostAttackDurationMin = 1.5,
			PostAttackDurationMax = 1.5,
			AIAttackDistance = 750,
			AIBufferDistance = 600,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 100,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = false,

			LeapWhenTargetBeyondDistance = 2000,
			LeapWhenTargetWithinDistance = 800,
			LeapWhenTargetOutOfSight = true,
			LeapOffsetRange = 750,
			RetreatLeapWhenHitChance = 0.8,
			RetreatLeapDistance = 1500,
			RetreatLeapMinDistance = 500,
		},

		WeaponOptions = { "BloodlessPitch", "BloodlessPitchCurve" },

		GeneratorData =
		{
			DifficultyRating = 50,
			BlockEnemyTypes = {"BloodlessPitcherElite", "BloodlessPitcherSuperElite"}
		},

		LargeUnitCap = 5,
		Binks =
		{
			"Enemy_BloodlessGrenadierIdle_Bink",
			"Enemy_BloodlessGrenadierWalk_Bink",
			"Enemy_BloodlessGrenadierJump_Bink",
			"Enemy_BloodlessGrenadierCharge_Bink",
			"Enemy_BloodlessGrenadierAttack_Bink",
			"Enemy_BloodlessGrenadierOnHit_Bink",
			"Enemy_BloodlessGrenadierDeathVFX_Bink"
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Burn-Flingers!
			{ Cue = "/VO/ZagreusField_1443" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_1443" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			RequiredFalseRooms = { "A_MiniBoss01", "A_MiniBoss02" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Burn-Flingers.
			{ Cue = "/VO/ZagreusField_1442", RequiredPlayed = { "/VO/ZagreusField_1443" } },
			-- Burn-Flingers!
			{ Cue = "/VO/ZagreusField_1443" },
			-- More Burn-Flingers!
			{ Cue = "/VO/ZagreusField_1444", RequiredPlayed = { "/VO/ZagreusField_1443" } },
			-- More Burn-Flingers?
			{ Cue = "/VO/ZagreusField_1445", RequiredPlayed = { "/VO/ZagreusField_1443" } },
		},
	},

	BloodlessPitcherElite =
	{
		InheritFrom = { "Elite", "BloodlessPitcher" },
		EliteAttributeOptions = CombineTables(EnemySets.AllEliteAttributes, EnemySets.RangedOnlyEliteAttributes ),

		RequiredMinBiomeDepth = 2,
		HealthBuffer = 400,

		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless02/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackDurationMax = 1.0,
		},

		WeaponOptions = { "BloodlessPitch", "BloodlessPitchCurveVolley" },

		GeneratorData =
		{
			DifficultyRating = 95,
			BlockEnemyTypes = {"BloodlessPitcher", "BloodlessPitcherSuperElite"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.95,
		},
	},

	BloodlessPitcherSuperElite =
	{
		InheritFrom = { "SuperElite", "Elite", "BloodlessPitcher" },

		HealthBuffer = 2000,

		WeaponOptions = { "BloodlessPitch", "BloodlessPitchCurve", "BloodlessReposition", "BloodlessGrenadierRanged", "BloodlessGrenadierCluster" },

		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless02/EmoteTaunting",

		GeneratorData =
		{
			DifficultyRating = 300,
			BlockEnemyTypes = {"BloodlessPitcher", "BloodlessPitcherElite"}
		},

		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 4.5,
			Threshold = 0.95,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	CrusherUnit =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "CrusherUnit",

		RequiredIntroEncounter = "CrusherIntro",

		Material = "Stone",
		DeathForce = 900,

		MaxHealth = 420,
		HealthBarOffsetY = -210,
		HealthBarType = "MediumLarge",

		FreezeBreakDuration = 0.9,
		FreezeTimeReductionPerInput = 0.5,
		HitSparkScale = 2.5,
		HitSparkOffsetZ = 175,
		SkipRotateOnAggro = true,
		IsAggroedSound = "/SFX/Enemy Sounds/Crusher/EmoteAlerted",

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Enemy Sounds/Crusher/EmoteCharging",
			PreAttackAnimation = "CrusherUnitIdle",
			PreAttackFx = "FallingCrusherShadow",
			PreAttackStopAnimations = { "CrusherShadowSky", "CrusherShadowFadeIn", },
			PreAttackWaitForAnimation = true,
			PostAttackDuration = 3.5,
			PostAttackAnimation = "CrusherUnitOnGround",
			AIAttackDistance = 75,
			AIBufferDistance = 600,
			AIMoveWithinRangeTimeoutMin = 3.5,
			AIMoveWithinRangeTimeoutMax = 4.5,
			PostLaunchHideDurationMin = 0.8,
			PostLaunchHideDurationMax = 1.5,
			PostLaunchHideFadeInDuration = 1.0,
			LaunchAnimation = "CrusherUnitAscending",

			ResetSkyAttackSound = "/SFX/Enemy Sounds/Crusher/EmoteJumping",
			ShadowAnimationFadeInName = "CrusherShadowFadeIn",
			StopAnimationsOnLaunch = { "CrusherShadowGround", "CrusherCrater", },
			ShadowAnimationFadeOutName = "CrusherShadowFadeOut",

			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 80,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = false,
			RetreatTimeout = 4.0,
			SkipAngleTowardTarget = true,

			WaitIfBlockedDistance = 250,
			WaitIfBlockedDurationMin = 0.5,
			WaitIfBlockedDurationMax = 1.0,
		},
		StopAnimationsOnDeath = { "CrusherShadowGround", "CrusherCrater", },

		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = SkyAttackerAI,
		AIAggroRange = 600,
		AIWanderDistance = 0,
		WakeUpDelay = 0.3,
		SpawnFx = "CrusherCraterFadeIn",

		AmmoDropOnDeath =
		{
			Chance = 0.7,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		WeaponOptions = { "CrusherUnitSlam" },

		GeneratorData =
		{
			DifficultyRating = 40,
			MaxCount = 1,
			BlockEnemyTypes = {"CrusherUnitElite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Skull-Crushers!
			{ Cue = "/VO/ZagreusField_1179" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_1179" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			RequiredFalseRooms = { "B_MiniBoss01" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Skull-Crushers.
			{ Cue = "/VO/ZagreusField_1178", RequiredPlayed = { "/VO/ZagreusField_1179" } },
			-- Skull-Crushers!
			{ Cue = "/VO/ZagreusField_1179" },
			-- More Skull-Crushers!
			{ Cue = "/VO/ZagreusField_1180", RequiredPlayed = { "/VO/ZagreusField_1179" } },
			-- Skull-Crushers?
			{ Cue = "/VO/ZagreusField_1181", RequiredPlayed = { "/VO/ZagreusField_1179" } },
		},
		OutgoingDamageModifiers =
		{
			{
				Name = "FriendImmunity",
				FriendMultiplier = 0,
				Multiplicative = true,
			},
		},
	},

	CrusherUnitElite =
	{
		InheritFrom = { "Elite", "CrusherUnit" },
		MaxHealth = 500,
		HealthBuffer = 1200,
		RequiredMinBiomeDepth = 2,

		BlockAttributes = { "Molten" },

		HealthBarType = "Large",

		ShrineMetaUpgradeName = "MinibossCountShrineUpgrade",
		ShrineWeaponOptionsOverwrite = { "CrusherUnitSlamUpgraded" },

		DefaultAIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 2.0,
		},

		EliteAttributeData =
		{
			DeepInheritance = true,
			HeavyArmor =
			{
				DataOverrides =
				{
					HealthMultiplier = 1.5,
					HealthBarType = "ExtraLarge",
				},
			},
		},

		GeneratorData =
		{
			DifficultyRating = 80,
			MaxCount = 1,
			BlockEnemyTypes = {"CrusherUnit"}
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	CrusherUnitSuperElite =
	{
		InheritFrom = { "BaseVulnerableEnemy", "CrusherUnit" },
		MaxHealth = 900,
		HealthBuffer = 2400,

		GeneratorData =
		{
			DifficultyRating = 500,
			BlockSolo = true,
			BlockEnemyTypes = {"CrusherUnitElite"},
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.6,
		},
	},

	TimeCrystal =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "Illusionist",

		RequiredIntroEncounter = "IllusionistIntro",

		Material = "Organic",
		DeathForce = 900,

		MaxHealth = 180,
		HealthBarOffsetY = -180,

		KillSpawnsOnDeath = true,

		DefaultAIData =
		{
			PreAttackEndShake = true,
		},

		AIOptions =
		{
			AttackerAI,
		},

		AmmoDropOnDeath =
		{
			Chance = 0.7,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		WeaponOptions = { "TimeCrystalDash" },
		OnHitForcedWeapon = "TimeCrystalDash",
		OnHitForcedWeaponCooldown = 7.0,

		ModifyTimerOnDeath = -5.0,

		GeneratorData =
		{
			DifficultyRating = 16,
			BlockEnemyTypes = {"IllusionistElite"}
		},
	},

	Illusionist =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "Illusionist",

		RequiredIntroEncounter = "IllusionistIntro",

		Material = "Organic",
		DeathForce = 900,

		MaxHealth = 110,
		HealthBarOffsetY = -180,

		KillSpawnsOnDeath = true,
		IsAggroedSound = "/SFX/Enemy Sounds/Caster/EmoteAlerted",

		DefaultAIData =
		{
			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Enemy Sounds/Caster/EmoteCharging",
			PreAttackAnimation = "3DGhostIdle",
			PostAttackAnimation = "3DGhostIdle",
			PreAttackDuration = 0.5,
			PostAttackDuration = 1.0,
			PostAttackCooldown = 1.0,
			AIAttackDistance = 800,
			AIMoveWithinRangeTimeoutMin = 2.0,
			AIMoveWithinRangeTimeoutMax = 4.0,

			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 80,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = false,
			RetreatTimeout = 3.0,
		},

		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = AttackerAI,
		AIAggroRange = 750,

		AmmoDropOnDeath =
		{
			Chance = 0.7,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		WeaponOptions = { "IllusionistWeapon" },
		OnHitForcedWeapon = "IllusionistSplit",
		OnHitForcedWeaponCooldown = 7.0,

		GeneratorData =
		{
			DifficultyRating = 16,
			BlockEnemyTypes = {"IllusionistElite"}
		},
	},

	IllusionistElite =
	{
		InheritFrom = { "Elite", "BaseVulnerableEnemy", "Illusionist" },

		HealthBuffer = 150,

		GeneratorData =
		{
			DifficultyRating = 50,
			BlockEnemyTypes = {"Illusionist"}
		},

		OnHitForcedWeapon = "IllusionistSplitElite",
		OnHitForcedWeaponCooldown = 5.0,

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 4,
			Threshold = 0.85,
		},
	},

	IllusionistClone =
	{
		InheritFrom = { "Illusionist" },

		MaxHealth = 1,

		AIBufferDistance = 1000,
		RetreatTimeout = 4.0,

		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},

		AIOptions =
		{
			RetreatThenDieAI,
		},
	},

	IllusionistCloneElite =
	{
		InheritFrom = { "Elite", "Illusionist" },

		HealthBuffer = 10,

		AIBufferDistance = 1000,
		RetreatTimeout = 4.0,

		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 4,
			Threshold = 0.85,
		},

		AIOptions =
		{
			RetreatThenDieAI,
		},
	},

	FreezeShotUnit =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "FreezeShotUnit",
		MaxHealth = 150,
		HealthBarType = "Medium",
		HealthBarOffsetY = -120,
		HitSparkScale = 1.3,

		PreferredSpawnPoint = "EnemyPointSupport",
		RequiredIntroEncounter = "FreezeShotIntro",

		Groups = { "FlyingEnemies" },

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "EnemyMedusaHeadFire",
			FireAnimation = "EnemyMedusaHeadFire",
			PostAttackAnimation = "EnemyMedusaHeadIdle",

			PreAttackDuration = 0.3,
			PostAttackDuration = 0.5,

			AIBufferDistance = 800,
			AIAttackDistance = 600,

			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 80,

			AIMoveWithinRangeTimeoutMin = 2.0,
			AIMoveWithinRangeTimeoutMax = 3.0,

			RetreatAfterAttack = true,
			RetreatToSpawnPoints = true,
			PreAttackEndShake = true,

			TakeCoverDuration = 2.1,
			CoverHugDistance = 150,
		},

		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/Spitter/EmoteAlerted",
		PreAttackSound = "/SFX/Enemy Sounds/Spitter/EmoteCharging",
		AIAggroRange = 1100,

		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = HideAndPeekAI,
		PeekAggroMultiplier = 3,

		WeaponOptions =
		{
			"FreezeShotWeapon",
		},

		GeneratorData =
		{
			DifficultyRating = 15,
			BlockSolo = true,
			BlockEnemyTypes = {"FreezeShotUnitElite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Gorgons!
			{ Cue = "/VO/ZagreusField_1175" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_1175" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Gorgons.
			{ Cue = "/VO/ZagreusField_1174", RequiredPlayed = { "/VO/ZagreusField_1175" } },
			-- Gorgons!
			{ Cue = "/VO/ZagreusField_1175" },
			-- Gorgons!
			{ Cue = "/VO/ZagreusField_1176", RequiredPlayed = { "/VO/ZagreusField_1175" } },
			-- Gorgons?
			{ Cue = "/VO/ZagreusField_1177", RequiredPlayed = { "/VO/ZagreusField_1175" } },
		},
	},

	FreezeShotUnitElite =
	{
		InheritFrom = { "Elite", "FreezeShotUnit" },
		EliteAttributeOptions = CombineTables(EnemySets.AllEliteAttributes, EnemySets.RangedOnlyEliteAttributes ),

		HealthBuffer = 280,
		RequiredMinBiomeDepth = 3,

		DefaultAIData =
		{
			DeepInheritance = true,
			AIFireTicksMin = 5,
			AIFireTicksMax = 5,
			AIFireTicksCooldown = 0.25,

			PostAttackDuration = 0.5,
			PostAttackCooldown = 1.0,
		},

		IsAggroedSound = "/SFX/Enemy Sounds/Spitter/EmoteTaunting",

		GeneratorData =
		{
			DifficultyRating = 40,
			BlockSolo = true,
			BlockEnemyTypes = {"FreezeShotUnit"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 4,
			Threshold = 0.6,
		},
	},

  DusaSummon =
  {
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "TrainingMelee",
		RequiredKill = false,
		DropItemsOnDeath = false,
		UseShrineUpgrades = false,
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},
		MaxHealth = 400,
		HealthBarOffsetY = -145,
		HealthBarType = "MediumLarge",
		SkipDamageText = false,
		AnimOffsetZ = 120,
		UnuseableWhenDead = true,
		SpeechCooldownTime = 9,
		SkipModifiers = true,
		AlwaysTraitor = true,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		InvincibubbleAnim = "Invincibubble_Zag",

		Groups = { "FlyingEnemies", "TrainingEnemies" },

		Material = "Bone",

		MeterMultiplier = 0,

		DefaultAIData =
		{
			PreAttackSound = "/Leftovers/SFX/CroneSlowHiss",
			AIBufferDistance = 750,
			AIAttackDistance = 600,
			RetreatAfterAttack = true,
			RetreatTimeout = 1.0,

			PreAttackAnimation = "NPCDusaPreAttack",
			FireAnimation = "NPCDusaAttack",
			PostAttackAnimation = "NPCDusaIdle",
		},

		WeaponOptions =
		{
			"DusaFreezeShotSpray", "DusaFreezeShotSpread"
		},

		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = AttackerAI,

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		OnSpawnVoiceLines =
		{
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredRooms = { "A_Boss01", },
					RequiredTrait = "DusaAssistTrait",
					PreLineWait = 2.2,
					Queue = "Always",
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.DusaVoice },

					-- Oh hi, sorry, Miss Meg!
					{ Cue = "/VO/Dusa_0216" },
					-- I really hate this part of the job, Miss Meg!
					{ Cue = "/VO/Dusa_0217" },
					-- Miss Meg, I am so sorry!
					{ Cue = "/VO/Dusa_0218" },
					-- Um hi again, Miss Meg!
					{ Cue = "/VO/Dusa_0219" },
					-- Prince, this is so mean!!
					{ Cue = "/VO/Dusa_0220" },
					-- Now break it up, you two!
					{ Cue = "/VO/Dusa_0221" },
					-- I hate to see you fight!
					{ Cue = "/VO/Dusa_0222" },
					-- No way, Miss Meg?!
					{ Cue = "/VO/Dusa_0223" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredBiome = "Asphodel",
					RequiredTrait = "DusaAssistTrait",
					PreLineWait = 2.2,
					Queue = "Always",
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.DusaVoice },
					RequiredAnyUnitAlive = { "FreezeShotUnit", "FreezeShotUnitElite" },
					RequiredMinKillEnemies = 3,

					-- What a bunch of phonies!
					{ Cue = "/VO/Dusa_0262" },
					-- You give gorgons a bad name!
					{ Cue = "/VO/Dusa_0263" },
					-- You no-good gorgons!
					{ Cue = "/VO/Dusa_0264" },
					-- Get ready for the real deal, gorgon heads!
					{ Cue = "/VO/Dusa_0265" },
					-- You ladies ready?!
					{ Cue = "/VO/Dusa_0266" },
					-- Come get a taste of your own medicine!
					{ Cue = "/VO/Dusa_0267" },
					-- Come and get it, ladies!!
					{ Cue = "/VO/Dusa_0268" },
					-- Gorgons causing problems for you, Prince?
					{ Cue = "/VO/Dusa_0269" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredRooms = { "B_MiniBoss01", },
					RequiredTrait = "DusaAssistTrait",
					PreLineWait = 2.2,
					Queue = "Always",
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.DusaVoice },
					RequiredAnyUnitAlive = { "HitAndRunUnit", "HitAndRunUnitElite", "HitAndRunUnitSuperElite" },

					-- Whoa, big momma!
					{ Cue = "/VO/Dusa_0270" },
					-- May I remind you, no relation, Prince?
					{ Cue = "/VO/Dusa_0271" },
					-- Hey, sister, let's see what you've got!
					{ Cue = "/VO/Dusa_0272" },
					-- This lady's trouble, Prince!
					{ Cue = "/VO/Dusa_0273" },
					-- I'm not afraid of you!!
					{ Cue = "/VO/Dusa_0274" },
					-- You're not so tough!
					{ Cue = "/VO/Dusa_0275" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredRooms = { "B_Boss01", "B_Boss02" },
					RequiredTrait = "DusaAssistTrait",
					PreLineWait = 2.2,
					Queue = "Always",
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.DusaVoice },

					-- Oh hi Big Snake!
					{ Cue = "/VO/Dusa_0224" },
					-- Look at this big old snake!
					{ Cue = "/VO/Dusa_0225" },
					-- Oh wow that thing is huge!
					{ Cue = "/VO/Dusa_0226" },
					-- That big snake making trouble, Prince?
					{ Cue = "/VO/Dusa_0227" },
					-- I'm not afraid of snakes!
					{ Cue = "/VO/Dusa_0228" },
					-- I'm not afraid of snakes!! That would be weird.
					{ Cue = "/VO/Dusa_0229", RequiredPlayed = { "/VO/Dusa_0220" } },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredRooms = { "C_MiniBoss01", },
					RequiredTrait = "DusaAssistTrait",
					PreLineWait = 2.2,
					Queue = "Always",
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.DusaVoice },

					-- Oh wow this guy is huge!
					{ Cue = "/VO/Dusa_0230" },
					-- Whoa it's the Minotaur!
					{ Cue = "/VO/Dusa_0231" },
					-- Look at the size of this guy!
					{ Cue = "/VO/Dusa_0232" },
					-- This looks like trouble, Prince!
					{ Cue = "/VO/Dusa_0233" },
					-- Let's slow this bruiser down!
					{ Cue = "/VO/Dusa_0234" },
					-- Hey, toughguy, over here!
					{ Cue = "/VO/Dusa_0235" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredRooms = { "C_Boss01", },
					RequiredTrait = "DusaAssistTrait",
					PreLineWait = 2.2,
					Queue = "Always",
					RequiredAnyUnitAlive = { "Theseus", "Theseus2" },
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.DusaVoice },

					-- Whoa, what a crowd!
					{ Cue = "/VO/Dusa_0236" },
					-- Hey, look, an audience!
					{ Cue = "/VO/Dusa_0237" },
					-- Would you look at this crowd?
					{ Cue = "/VO/Dusa_0238" },
					-- Is this the main event?!
					{ Cue = "/VO/Dusa_0239" },
					-- Wow look at all this!
					{ Cue = "/VO/Dusa_0240" },
					-- Wow this place is amazing, Prince!
					{ Cue = "/VO/Dusa_0241" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredRooms = { "CharonFight01", },
					RequiredTrait = "DusaAssistTrait",
					PreLineWait = 2.2,
					Queue = "Always",
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.DusaVoice },

					-- Oh wow, that's Charon, Prince!
					{ Cue = "/VO/Dusa_0502" },
					-- You stay away from him, please, Charon sir!
					{ Cue = "/VO/Dusa_0503" },
					-- You'll please forgive us, won't you, Charon sir?
					{ Cue = "/VO/Dusa_0504" },
					-- Um, no hard feelings, OK, Charon sir?
					{ Cue = "/VO/Dusa_0505" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredTrait = "DusaAssistTrait",
					PreLineWait = 2.2,
					Queue = "Always",
					RequiredRooms = { "D_Boss01", },
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.DusaVoice },

					-- Ah, it's your father, Prince!!
					{ Cue = "/VO/Dusa_0248" },
					-- Am I supposed to be here, Prince?!
					{ Cue = "/VO/Dusa_0249" },
					-- Um, I could get in lots of trouble here!
					{ Cue = "/VO/Dusa_0250" },
					-- Oh wow, Lord Hades, sir!!
					{ Cue = "/VO/Dusa_0251" },
					-- Ahh, oh no, it's him!
					{ Cue = "/VO/Dusa_0252" },
					-- Ahh it's the big boss!!
					{ Cue = "/VO/Dusa_0253" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredTrait = "DusaAssistTrait",
					PreLineWait = 2.2,
					Queue = "Always",
					RequiredEncounters = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro" },
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.DusaVoice },

					-- Ooh, Thanatos!
					{ Cue = "/VO/Dusa_0242" },
					-- It's Thanatos, what do you need me for?
					{ Cue = "/VO/Dusa_0243" },
					-- Oh wow, it's Thanatos!
					{ Cue = "/VO/Dusa_0244" },
					-- Whoa is that Thanatos?
					{ Cue = "/VO/Dusa_0245" },
					-- Ah, that is Thanatos!
					{ Cue = "/VO/Dusa_0246" },
					-- Wait, Thanatos, that's him!
					{ Cue = "/VO/Dusa_0247" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredTrait = "DusaAssistTrait",
					PreLineWait = 2.2,
					Queue = "Always",
					Source = { SubtitleColor = Color.DusaVoice },

					-- Time to do my thing!
					{ Cue = "/VO/Dusa_0195" },
					-- Time to take out the trash!
					{ Cue = "/VO/Dusa_0196" },
					-- Got here as fast as I could!
					{ Cue = "/VO/Dusa_0204" },
					-- Incomiiing!
					{ Cue = "/VO/Dusa_0202" },
					-- Who wants to tangle, huh?!
					{ Cue = "/VO/Dusa_0203" },
					-- Don't worry, I'll save you!
					{ Cue = "/VO/Dusa_0207" },
					-- I'm here to rescue you!!
					{ Cue = "/VO/Dusa_0208" },
					-- This sure beats mopping floors!
					{ Cue = "/VO/Dusa_0209" },
					-- Statue-making time!
					{ Cue = "/VO/Dusa_0200" },
					-- Who wants to get rocked?!
					{ Cue = "/VO/Dusa_0201" },
					-- I'm tougher than I look!
					{ Cue = "/VO/Dusa_0212" },
					-- I'll get right on it, Prince!
					{ Cue = "/VO/Dusa_0214" },
					-- You can count on me!
					{ Cue = "/VO/Dusa_0205" },
					-- You can count on me!
					{ Cue = "/VO/Dusa_0215" },
				}
			}
		},

		OnHitVoiceLinesRequireAttackerName = "_PlayerUnit",
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			PlayFromTarget = true,
			ChanceToPlay = 0.05,
			CooldownTime = 100,

			-- Heyy!
			{ Cue = "/VO/Dusa_0323" },
			-- Hey!
			{ Cue = "/VO/Dusa_0324" },
			-- Um, hey!
			{ Cue = "/VO/Dusa_0325" },
			-- Oh stop!
			{ Cue = "/VO/Dusa_0326" },
			-- Not me, Prince!
			{ Cue = "/VO/Dusa_0327" },
			-- Nuh-uh!
			{ Cue = "/VO/Dusa_0328" },
			-- No sir!
			{ Cue = "/VO/Dusa_0329" },
			-- Uh, Prince?
			{ Cue = "/VO/Dusa_0330" },
			-- Your Highness!
			{ Cue = "/VO/Dusa_0331" },
			-- Honest mistake!
			{ Cue = "/VO/Dusa_0332" },
			-- Don't worry about me!
			{ Cue = "/VO/Dusa_0333" },
			-- Ow!! Kidding.
			{ Cue = "/VO/Dusa_0334" },
			-- I'm only here to help!
			{ Cue = "/VO/Dusa_0335" },
			-- Hey, what gives?
			{ Cue = "/VO/Dusa_0336" },
			-- Good thing we have this bond!
			{ Cue = "/VO/Dusa_0337" },
			-- Woo, I'm invincible!!
			{ Cue = "/VO/Dusa_0338" },
		},
		KillingEnemyVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			ChanceToPlay = 0.1,
			PlayFromTarget = true,
			CooldownTime = 7,

			-- Got one!
			{ Cue = "/VO/Dusa_0276" },
			-- I got one!
			{ Cue = "/VO/Dusa_0277" },
			-- Take that!
			{ Cue = "/VO/Dusa_0278" },
			-- Got you!
			{ Cue = "/VO/Dusa_0279" },
			-- Go away!
			{ Cue = "/VO/Dusa_0280" },
			-- Go away!
			{ Cue = "/VO/Dusa_0281" },
			-- Ooh I got one!
			{ Cue = "/VO/Dusa_0282" },
			-- Got 'em!
			{ Cue = "/VO/Dusa_0283" },
			-- Haha!
			{ Cue = "/VO/Dusa_0284" },
			-- That'll show you!
			{ Cue = "/VO/Dusa_0285" },
			-- Rocked one!
			{ Cue = "/VO/Dusa_0286" },
		},
		LastStandReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.45,
			CooldownTime = 12,
			Queue = "Always",

			-- Oh no are you OK?
			{ Cue = "/VO/Dusa_0299", PreLineWait = 2.0 },
			-- Prince, no!
			{ Cue = "/VO/Dusa_0300" },
			-- Ah, watch out!
			{ Cue = "/VO/Dusa_0301" },
			-- Oh no!!
			{ Cue = "/VO/Dusa_0302" },
			-- Are you OK?
			{ Cue = "/VO/Dusa_0303", PreLineWait = 2.0 },
			-- Ah you're hurt!
			{ Cue = "/VO/Dusa_0304", PreLineWait = 2.0 },
			-- No, keep fighting!
			{ Cue = "/VO/Dusa_0305", PreLineWait = 2.0 },
			-- Keep fighting, Prince!
			{ Cue = "/VO/Dusa_0306", PreLineWait = 2.0 },
			-- Oh, ow!!
			{ Cue = "/VO/Dusa_0307" },
			-- No, I...!
			{ Cue = "/VO/Dusa_0308", PreLineWait = 2.0 },
			-- I can't look...!
			{ Cue = "/VO/Dusa_0309", PreLineWait = 2.0 },
			-- Prince!
			{ Cue = "/VO/Dusa_0310", PreLineWait = 2.0 },
			-- Zagreus!
			{ Cue = "/VO/Dusa_0311", PreLineWait = 2.0 },
			-- Keep fighting!
			{ Cue = "/VO/Dusa_0312", PreLineWait = 2.0 },
		},
		WrathReactionVoiceLines =
		{
			Queue = "Interrupt",
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 2.3,
				CooldownTime = 30,
				SuccessiveChanceToPlayAll = 0.5,
				RequiredTrait = "AthenaShoutTrait",

				-- Oh, it's Athena, huh...
				{ Cue = "/VO/Dusa_0319" },
				-- Athena's helping you?
				{ Cue = "/VO/Dusa_0320" },
				-- Careful with that one, Prince.
				{ Cue = "/VO/Dusa_0321" },
				-- Help from Athena, huh?
				{ Cue = "/VO/Dusa_0322" },
			},
			{
				RandomRemaining = true,
				PreLineWait = 2.3,
				CooldownTime = 30,
				SuccessiveChanceToPlayAll = 0.5,

				-- Oh wow, look at you go!
				{ Cue = "/VO/Dusa_0313" },
				-- Whoa, that is something, Prince!
				{ Cue = "/VO/Dusa_0314" },
				-- Woo, you get them, Prince!
				{ Cue = "/VO/Dusa_0315" },
				-- Wow, would you look at that!
				{ Cue = "/VO/Dusa_0316" },
				-- Calling in extra favors, Prince?
				{ Cue = "/VO/Dusa_0317" },
				-- That'll show them!
				{ Cue = "/VO/Dusa_0318" },
			},
		},
		AssistEndedVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				Source = { SubtitleColor = Color.DusaVoice },
				Cooldowns =
				{
					{ Name = "DusaAnyQuipSpeech", Time = 30 },
				},

				-- Take care, OK?!
				{ Cue = "/VO/Dusa_0352" },
				-- I have to go!
				{ Cue = "/VO/Dusa_0353" },
				-- Aah I have to go!
				{ Cue = "/VO/Dusa_0354" },
				-- Bye, Prince!
				{ Cue = "/VO/Dusa_0355" },
				-- Keep going!
				{ Cue = "/VO/Dusa_0356" },
				-- Hope I could help!
				{ Cue = "/VO/Dusa_0357" },
				-- Please be OK?
				{ Cue = "/VO/Dusa_0358" },
				-- I need to get back!
				{ Cue = "/VO/Dusa_0359" },
				-- Oh no I'm late!
				{ Cue = "/VO/Dusa_0360" },
				-- Keep fighting, Zagreus!
				{ Cue = "/VO/Dusa_0361" },
				-- OK byeee!
				{ Cue = "/VO/Dusa_0362" },
				-- Go on without me, Prince!
				{ Cue = "/VO/Dusa_0363" },
				-- Hope I did OK!
				{ Cue = "/VO/Dusa_0364" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.2,
				UsePlayerSource = true,
				SuccessiveChanceToPlay = 0.2,
				RequiredFalseBossPhase = 3,

				-- Cheers!
				{ Cue = "/VO/ZagreusField_2774", RequiredKillEnemiesFound = true, },
				-- Bye now!
				{ Cue = "/VO/ZagreusField_2775" },
				-- See you!
				{ Cue = "/VO/ZagreusField_2776" },
				-- See you at home?
				{ Cue = "/VO/ZagreusField_2777", RequiredFalseTraits = { "SkellyAssistTrait", "SisyphusAssistTrait" }, RequiredKillEnemiesFound = true, },
				-- Thanks!
				{ Cue = "/VO/ZagreusField_2778", RequiredKillEnemiesFound = true, },
				-- Thank you!!
				{ Cue = "/VO/ZagreusField_3012", RequiredKillEnemiesFound = true, },
				-- I owe you one!
				{ Cue = "/VO/ZagreusField_3013", RequiredKillEnemiesFound = true, },
				-- OK good-bye!
				{ Cue = "/VO/ZagreusField_3014" },
				-- We'll chat later OK?
				{ Cue = "/VO/ZagreusField_3015" },
				-- Thank you for that!
				{ Cue = "/VO/ZagreusField_3016" },
			},
		}
	},

	HitAndRunUnit =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "HitAndRunUnit",
		MaxHealth = 1200,
		RequiredMinBiomeDepth = 3,

		HealthBarType = "Large",

		PreferredSpawnPoint = "EnemyPointRanged",

		Groups = { "FlyingEnemies" },

		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/MegaGorgon/EmoteAlerted",

		FreezeBreakDuration = 0.1,
		FreezeTimeReductionPerInput = 0.5,

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "EnemyMedusaHeadFireHitAndRun",
			FireAnimation = "EnemyMedusaHeadFireHitAndRun",
			PostAttackAnimation = "EnemyMedusaHeadIdle",

			PreAttackSound = "/Leftovers/SFX/CroneSlowHiss",
			AIBufferDistance = 750,
			AIAttackDistance = 600,
			RetreatAfterAttack = true,
			RetreatTimeout = 1.8,
		},

		WeaponOptions =
		{
			"FreezeShotSpray", "FreezeShotSpread"
		},

		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = AttackerAI,

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		GeneratorData =
		{
			DifficultyRating = 80,
			EncounterPrefixId = "Encounter_Small",
			BlockEnemyTypes = {"HitAndRunUnitElite", "HitAndRunUnitSuperElite"}
		},
		DeathForce = 800,
	},

	HitAndRunUnitElite =
	{
		InheritFrom = { "Elite", "HitAndRunUnit" },
		EliteAttributeOptions = CombineTables(EnemySets.AllEliteAttributes, EnemySets.RangedOnlyEliteAttributes ),

		HealthBuffer = 2000,
		HitSparkScale = 3.0,
		HitSparkOffsetZ = 110,
		ShrineMetaUpgradeName = "MinibossCountShrineUpgrade",
		ShrineDefualtAIDataOverwrites =
		{
			TeleportToSpawnPoints = true,
			TeleportationIntervalMin = 7.0,
			TeleportationIntervalMax = 8.0,
			TeleportStartFx = "HitAndRunUnitBlink",
			TeleportEndFx = "HitAndRunUnitBlink",
		},

		WeaponOptions =
		{
			"FreezeShotSpray", "FreezeShotSpread"
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2.2,
			Threshold = 0.6,
		},

		IsAggroedSound = "/SFX/Enemy Sounds/Spitter/EmoteTaunting",

		GeneratorData =
		{
			DifficultyRating = 175,
			BlockSolo = true,
			BlockEnemyTypes = {"HitAndRunUnit", "HitAndRunUnitSuperElite"}
		},
	},

	HitAndRunUnitSuperElite =
	{
		InheritFrom = { "SuperElite", "Elite", "HitAndRunUnit" },

		MaxHealth = 1500,
		HealthBuffer = 3000,

		IsAggroedSound = "/SFX/Enemy Sounds/Spitter/EmoteTaunting",

		GeneratorData =
		{
			DifficultyRating = 500,
			BlockSolo = true,
			BlockEnemyTypes = {"HitAndRunUnit", "HitAndRunUnitElite"}
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 8,
			Threshold = 0.75,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},


	-- ELYSIUM SHADES
	BaseShade =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		Groups = { "GroundEnemies" },
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteAlerted",
		HealthBarOffsetY = -200,
		HitSparkScale = 1.5,

		AIOptions =
		{
			AggroAI,
		},
		--AIAggroRange = 825,
		PostAggroAI = AttackerAI,

		DefaultAIData =
		{
			DeepInheritance = true,
			AIMoveWithinRangeTimeoutMin = 4.0,
			AIMoveWithinRangeTimeoutMax = 8.0,
		},

		KillingWeaponBlockDeathWeapons = { "ThanatosDeathCurse", "ThanatosDeathCurseAoE" },

		AmmoDropOnDeath =
		{
		  Chance = 1.0,
		  MinAmmo = 1,
		  MaxAmmo = 3,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.15,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
		DestroyDelay = 0.2,
	},

	ShadeNaked =
	{
		InheritFrom = { "BaseShade" },
		GenusName = "ShadeNaked",

		MaxHealth = 150,
		HealthBuffer = 0,
		HealthBarType = "Small",
		HitSparkScale = 1.0,

		HealthBarOffsetY = -135,
		HealthBarType = "Small",

		WakeDelay = 0.5,

		MoveToPickupTimeout = 10,
		AIPickupType = {"EnemyBow", "EnemySpear", "EnemyShield", "EnemySword", "EnemyDagger", "EnemyMagicGauntlets"},
		AIPickupTime = 2.0,
		PickupSound = "/SFX/Enemy Sounds/Exalted/NakedShadeRespawned",
		PickupFx = "ShadeWeaponPickup",
		AIPickupRange = 35,
		PickupFailedAnimation = "ShadeNaked_Idle",
		BeginPickupAnimation = "ShadeNaked_Pickup",

		PickupAttemptCooldown = 1.0,

		AIOptions =
		{
			PickupAI,
		},

		WeaponOptions = { "ShadeSideDash" },

		GeneratorData =
		{
			DifficultyRating = 10,
			BlockEnemyTypes = {"ShadeNakedElite"}
		},
		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},

		RespawningVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.33,
			CooldownTime = 240,
			PreLineWait = 0.45,
			RequiredFalseRooms = { "C_MiniBoss02" },
			Cooldowns =
			{
				{ Name = "RespawningVoiceLinesPlayedRecently", Time = 60 },
			},

			-- One's respawning.
			-- { Cue = "/VO/ZagreusField_1690" },
			-- One's respawning!
			-- { Cue = "/VO/ZagreusField_1691" },
			-- That one's respawning.
			-- { Cue = "/VO/ZagreusField_1692" },
			-- That one's respawning!
			-- { Cue = "/VO/ZagreusField_1693" },
			-- One's regenerating.
			{ Cue = "/VO/ZagreusField_3177" },
			-- One's regenerating!
			{ Cue = "/VO/ZagreusField_3178" },
			-- That one's regenerating.
			{ Cue = "/VO/ZagreusField_3179" },
			-- That one's regenerating!
			{ Cue = "/VO/ZagreusField_3180" },
			-- One's rearming.
			{ Cue = "/VO/ZagreusField_1694" },
			-- One's rearming!
			{ Cue = "/VO/ZagreusField_1695" },
			-- That one's rearming.
			{ Cue = "/VO/ZagreusField_1696" },
			-- That one's rearming!
			{ Cue = "/VO/ZagreusField_1697" },
			-- He's trying to respawn!
			{ Cue = "/VO/ZagreusField_1698" },
		},
		RespawnedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.33,
			CooldownTime = 240,
			PreLineWait = 0.65,
			RequiredFalseRooms = { "C_MiniBoss02" },
			Cooldowns =
			{
				{ Name = "RespawnedVoiceLinesPlayedRecently", Time = 60 },
			},

			-- Damn it, one's come back.
			{ Cue = "/VO/ZagreusField_1699" },
			-- He's fully recovered!
			{ Cue = "/VO/ZagreusField_1700" },
			-- Damn, he's recovered!
			{ Cue = "/VO/ZagreusField_1701" },
			-- That one's come back!
			{ Cue = "/VO/ZagreusField_1702" },
			-- That one fully rearmed!
			{ Cue = "/VO/ZagreusField_1703" },
		},
	},

	ShadeNakedElite =
	{
		InheritFrom = { "Elite", "ShadeNaked" },

		EliteAttributeOptions = { },

		RequiredMinBiomeDepth = 3,
		HealthBuffer = 50,
		-- IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteTaunting",

		GeneratorData =
		{
			DifficultyRating = 15,
			BlockEnemyTypes = {"ShadeNaked"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	ShadeNakedEliteTrap =
	{
		InheritFrom = { "ShadeNakedElite" },

		AIBufferDistance = 1000,
		RetreatTimeoutMin = 3.0,
		RetreatTimeoutMax = 4.0,
		PostRetreatFlash = true,
		PostRetreatDuration = 0.8,
		AIOptions = { RetreatThenDieAI },
		IgnoreThanatosChallengeTracker = true,
	},

	ShadeNakedSuperElite =
	{
		InheritFrom = { "SuperElite", "Elite", "ShadeNaked" },

		HealthBuffer = 100,

		GeneratorData =
		{
			DifficultyRating = 30,
		},

		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	ShadeBowUnit =
	{
		InheritFrom = { "BaseShade" },
		GenusName = "ShadeBowUnit",
		PreferredSpawnPoint = "EnemyPointRanged",

		RequiredIntroEncounter = "ShadeBowUnitIntro",

		MaxHealth = 450,
		HealthBarOffsetY = -155,
		HealthBarType = "Medium",

		IsAggroedSound = "/SFX/Enemy Sounds/Exalted/EmoteAlertedBow",
		OnDeathThreadedFunctionName = "AddPlaceholderEnemyCount",

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackSound = "/SFX/Enemy Sounds/Exalted/EmoteCharging",

			TakeCoverDuration = 1.7,
			CoverHugDistance = 250,
			AIMoveWithinRangeTimeoutMin = 2.0,
			AIMoveWithinRangeTimeoutMax = 4.0,
			AIAttackDistance = 1100,
		},

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		WeaponOptions =
		{
			"ShadeBowRanged",
		},
		DisarmedWeapon = "ShadeBowSideDash",

		SpawnObstaclesOnDeath =
		{
			{ Name = "EnemyBow" },
		},
		SpawnsEnemyOnDeath = true,

		AIAggroRange = 1000,
		PostAggroAI = HideAndPeekAI,
		PeekAggroMultiplier = 3,

		GeneratorData =
		{
			DifficultyRating = 55,
			BlockEnemyTypes = {"ShadeBowUnitElite", "ShadeBowUnitSuperElite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Strongbows!
			{ Cue = "/VO/ZagreusField_1678" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_1678" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Strongbows.
			{ Cue = "/VO/ZagreusField_1677", RequiredPlayed = { "/VO/ZagreusField_1678" } },
			-- Strongbows!
			{ Cue = "/VO/ZagreusField_1678" },
			-- More Strongbows!
			{ Cue = "/VO/ZagreusField_1679", RequiredPlayed = { "/VO/ZagreusField_1678" } },
			-- More Strongbows?
			{ Cue = "/VO/ZagreusField_1680", RequiredPlayed = { "/VO/ZagreusField_1678" } },
		},

		Binks =
		{
			"ShadeBowAttacks_Bink",
			"ShadeBowOnHit_Bink",
			"ShadeBowIdle_Bink",
			"ShadeBowRun_Bink",
			"ShadeDeathVFX_Bink",
		},
	},

	ShadeBowUnitElite =
	{
		InheritFrom = { "Elite", "ShadeBowUnit" },
		EliteAttributeOptions = CombineAllValues( {EnemySets.AllEliteAttributes, EnemySets.RangedOnlyEliteAttributes, EnemySets.ShadeOnlyEliteAttributes} ),

		RequiredMinBiomeDepth = 3,
		HealthBuffer = 350,
		IsAggroedSound = "/SFX/Enemy Sounds/Exalted/EmoteTauntingBow",

		WeaponOptions =
		{
			--"ShadeDisengage",
			"ShadeBowRangedRapidFire", "ShadeBowSideDash",
			--"ShadeBowRangedSplitFire",
		},

		GeneratorData =
		{
			DifficultyRating = 80,
			BlockEnemyTypes = {"ShadeBowUnit", "ShadeBowUnitSuperElite"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	ShadeBowUnitSuperElite =
	{
		InheritFrom = { "SuperElite", "Elite", "ShadeBowUnit" },

		HealthBuffer = 1300,
		IsAggroedSound = "/SFX/Enemy Sounds/Exalted/EmoteTauntingBow",

		WeaponOptions =
		{
			"ShadeBowRangedRapidSalvo", "ShadeBowSideDash",
		},

		GeneratorData =
		{
			DifficultyRating = 250,
			BlockEnemyTypes = {"ShadeBowUnit", "ShadeBowUnitElite"}
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},


	ShadeSpearUnit =
	{
		InheritFrom = { "BaseShade" },
		GenusName = "ShadeSpearUnit",
		PreferredSpawnPoint = "EnemyPointMelee",

		RequiredIntroEncounter = "ShadeSpearUnitIntro",

		MaxHealth = 850,
		HealthBarOffsetY = -185,
		HealthBarType = "MediumLarge",
		IsAggroedSound = "/SFX/Enemy Sounds/Exalted/EmoteAlertedSpear",
		OnDeathThreadedFunctionName = "AddPlaceholderEnemyCount",

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackSound = "/SFX/Enemy Sounds/Exalted/EmoteCharging",

			LeapChargeAnimation = "ShadeSpear_AttackLeapLaunch",
			LeapLandingAnimation = "ShadeSpear_AttackLeapTouchDown",
			LeapSound = "/Leftovers/SFX/PlayerJumpMedium",
			LeapLandingSound = "/SFX/ArrowMetalStoneClang",
			LeapSpeed = 2500,
			LeapPrepareTime = 0.15,
			LeapRecoveryTime = 0.5,
			LeapOffsetRange = 700,
		},

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		WeaponOptions =
		{
			"ShadeSpearThrustSingle",  "ShadeSpearLeap"
		},
		DisarmedWeapon = "ShadeSpearForwardDash",

		SpawnObstaclesOnDeath =
		{
			{ Name = "EnemySpear" },
		},
		SpawnsEnemyOnDeath = true,

		OnTouchdown =
		{
			LeapIfBlocked = true,
		},

		GeneratorData =
		{
			DifficultyRating = 60,
			BlockEnemyTypes = {"ShadeSpearUnitElite", "ShadeSpearUnitSuperElite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Longspears!
			{ Cue = "/VO/ZagreusField_1670" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_1670" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Longspears.
			{ Cue = "/VO/ZagreusField_1669", RequiredPlayed = { "/VO/ZagreusField_1670" } },
			-- Longspears!
			{ Cue = "/VO/ZagreusField_1670" },
			-- More Longspears!
			{ Cue = "/VO/ZagreusField_1671", RequiredPlayed = { "/VO/ZagreusField_1670" } },
			-- More Longspears?
			{ Cue = "/VO/ZagreusField_1672", RequiredPlayed = { "/VO/ZagreusField_1670" } },
		},

		Binks =
		{
			"ShadeSpearIdle_Bink",
			"ShadeSpearRun_Bink",
			"ShadeSpearAttacks_Bink",
			"ShadeSpearOnHit_Bink",
			"ShadeSpearAttackLeap_Bink",
			"ShadeOnHit_Bink",
			"ShadeDeathVFX_Bink",
		},
	},

	ShadeSpearUnitElite =
	{
		InheritFrom = { "Elite", "ShadeSpearUnit" },
		EliteAttributeOptions = CombineAllValues( {EnemySets.AllEliteAttributes, EnemySets.ShadeOnlyEliteAttributes} ),

		RequiredMinBiomeDepth = 3,
		HealthBuffer = 500,
		IsAggroedSound = "/SFX/Enemy Sounds/Exalted/EmoteTauntingSpear",

		BlockAttributes = { "Blink" },
		WeaponOptions =
		{
			"ShadeSpearThrust",  "ShadeSpearLeap"
		},

		GeneratorData =
		{
			DifficultyRating = 95,
			BlockEnemyTypes = {"ShadeSpearUnit", "ShadeSpearUnitSuperElite"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	ShadeSpearUnitSuperElite =
	{
		InheritFrom = { "SuperElite", "Elite", "ShadeSpearUnit" },

		HealthBuffer = 1100,
		IsAggroedSound = "/SFX/Enemy Sounds/Exalted/EmoteTauntingSpear",

		WeaponOptions =
		{
			"ShadeSpearLeapSuper"
		},

		GeneratorData =
		{
			DifficultyRating = 300,
			BlockEnemyTypes = {"ShadeSpearUnit", "ShadeSpearUnitElite"}
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	ShadeShieldUnit =
	{
		InheritFrom = { "BaseShade" },
		GenusName = "ShadeShieldUnit",
		PreferredSpawnPoint = "EnemyPointMelee",

		MaxHealth = 650,
		HealthBarOffsetY = -180,
		HealthBarType = "MediumLarge",
		IsAggroedSound = "/SFX/Enemy Sounds/Exalted/EmoteAlertedShield",
		OnDeathThreadedFunctionName = "AddPlaceholderEnemyCount",
		RequiredIntroEncounter = "ShadeShieldUnitIntro",

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackSound = "/SFX/Enemy Sounds/Exalted/EmoteCharging",
		},
		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		WeaponOptions =
		{
			"ShadeShieldMelee", "ShadeHunkerDown",
		},

		SpawnObstaclesOnDeath =
		{
			{ Name = "EnemyShield" },
		},
		SpawnsEnemyOnDeath = true,

		GeneratorData =
		{
			DifficultyRating = 70,
			BlockEnemyTypes = {"ShadeShieldUnitElite", "ShadeShieldUnitSuperElite"},
			BlockSolo = true,
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Greatshields!
			{ Cue = "/VO/ZagreusField_1674" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_1674" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Greatshields.
			{ Cue = "/VO/ZagreusField_1673", RequiredPlayed = { "/VO/ZagreusField_1674" } },
			-- Greatshields!
			{ Cue = "/VO/ZagreusField_1674" },
			-- More Greatshields!
			{ Cue = "/VO/ZagreusField_1675", RequiredPlayed = { "/VO/ZagreusField_1674" } },
			-- More Greatshields?
			{ Cue = "/VO/ZagreusField_1676", RequiredPlayed = { "/VO/ZagreusField_1674" } },
		},

		Binks =
		{
			"ShadeOnHit_Bink",
			"ShadeShieldIdle_Bink",
			"ShadeShieldWalk_Bink",
			"ShadeShieldSlam_Bink",
			"ShadeShieldAttacks_Bink",
			"ShadeShieldOnHit_Bink",
			"ShadeDeathVFX_Bink",
		},
		ProjectileBlockPresentationFunctionName = "ShadeBlockPresentation"
	},

	ShadeShieldUnitElite =
	{
		InheritFrom = { "Elite", "ShadeShieldUnit" },
		EliteAttributeOptions = CombineAllValues( {EnemySets.AllEliteAttributes, EnemySets.ShadeOnlyEliteAttributes} ),

		RequiredMinBiomeDepth = 3,
		HealthBuffer = 550,
		IsAggroedSound = "/SFX/Enemy Sounds/Exalted/EmoteTauntingShield",

		WeaponOptions =
		{
			"ShadeShieldMeleeElite", "ShadeHunkerDownElite",
		},

		BlockAttributes = { "Vacuuming", "Blink" },

		GeneratorData =
		{
			DifficultyRating = 125,
			BlockEnemyTypes = {"ShadeShieldUnit", "ShadeShieldUnitSuperElite"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	ShadeShieldUnitSuperElite =
	{
		InheritFrom = { "SuperElite", "Elite", "ShadeShieldUnit" },

		HealthBuffer = 1400,
		IsAggroedSound = "/SFX/Enemy Sounds/Exalted/EmoteTauntingShield",

		WeaponOptions =
		{
			"ShadeHunkerDownElite",
		},

		BlockAttributes = { "Vacuuming", "Blink" },

		GeneratorData =
		{
			DifficultyRating = 350,
			BlockEnemyTypes = {"ShadeShieldUnit", "ShadeShieldUnitElite"}
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},


	ShadeSwordUnit =
	{
		InheritFrom = { "BaseShade" },
		GenusName = "ShadeSwordUnit",
		PreferredSpawnPoint = "EnemyPointMelee",

		MaxHealth = 700,
		HealthBarType = "MediumLarge",
		IsAggroedSound = "/SFX/Enemy Sounds/Exalted/EmoteAlertedSword",
		OnDeathThreadedFunctionName = "AddPlaceholderEnemyCount",
		RequiredIntroEncounter = "ShadeSwordUnitIntro",
		ForceIntroduction = true,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		WeaponOptions =
		{
			"ShadeSwordWeapon", "ShadeSwordOverhead", "ShadeSideDash",
		},
		DisarmedWeapon = "ShadeSwordWeapon",

		SpawnObstaclesOnDeath =
		{
			{ Name = "EnemySword" },
		},
		SpawnsEnemyOnDeath = true,

		GeneratorData =
		{
			DifficultyRating = 45,
			BlockEnemyTypes = {"ShadeShieldUnitElite", "ShadeSwordUnitSuperElite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Brightswords!
			{ Cue = "/VO/ZagreusField_1666" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_1666" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", "PerfectClearShrinePointChallenge" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Brightswords.
			{ Cue = "/VO/ZagreusField_1665", RequiredPlayed = { "/VO/ZagreusField_1666" } },
			-- Brightswords!
			{ Cue = "/VO/ZagreusField_1666" },
			-- More Brightswords!
			{ Cue = "/VO/ZagreusField_1667", RequiredPlayed = { "/VO/ZagreusField_1666" } },
			-- More Brightswords?
			{ Cue = "/VO/ZagreusField_1668", RequiredPlayed = { "/VO/ZagreusField_1666" } },
		},

		Binks =
		{
			"ShadeSwordAttack_Bink",
			"ShadeSwordAttackOverHead_Bink",
			"ShadeSwordRun_Bink",
			"ShadeSwordOnHit_Bink",
			"ShadeSwordIdle_Bink",
			"ShadeOnHit_Bink",
			"ShadeDeathVFX_Bink",
		},
	},

	ShadeSwordUnitTest =
	{
		InheritFrom = { "ShadeSwordUnit" },
		-- AIOptions =
		-- {
		-- 	FollowAI
		-- },
		WeaponOptions =
		{
			"ShadeSideDash",
		},
		DisarmedWeapon = "ShadeSideDash"
	},

	ShadeSwordUnitElite =
	{
		InheritFrom = { "Elite", "ShadeSwordUnit" },
		EliteAttributeOptions = CombineAllValues( {EnemySets.AllEliteAttributes, EnemySets.ShadeOnlyEliteAttributes} ),

		RequiredMinBiomeDepth = 3,
		HealthBuffer = 400,
		IsAggroedSound = "/SFX/Enemy Sounds/Exalted/EmoteTauntingSword",

		WeaponOptions =
		{
			"ShadeSwordWeapon", "ShadeSwordOverheadElite", "ShadeSideDash",
		},

		GeneratorData =
		{
			DifficultyRating = 100,
			BlockEnemyTypes = {"ShadeSwordUnit", "ShadeSwordUnitSuperElite"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	ShadeSwordUnitSuperElite =
	{
		InheritFrom = { "SuperElite", "Elite", "ShadeSwordUnit" },

		HealthBuffer = 1400,
		IsAggroedSound = "/SFX/Enemy Sounds/Exalted/EmoteTauntingSword",

		WeaponOptions =
		{
			"ShadeSwordOverheadSuperElite", "ShadeSideDash",
		},

		GeneratorData =
		{
			DifficultyRating = 250,
			BlockEnemyTypes = {"ShadeSwordUnit", "ShadeSwordUnitElite"}
		},
		Outline =
		{
			R = 196,
			G = 41,
			B = 2,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	-- Satyrs
	BaseSatyr =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},
		Groups = { "GroundEnemies" },
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteAlerted",
		HealthBarOffsetY = -200,
		AddOutlineImmediately = true,
		HitSparkOffsetZ = 140,

		SpawnObstaclesOnDeath =
		{
			{ Name = "StyxGibletsRat01b", GroupName = "FX_Terrain" },
		},

		AIOptions =
		{
			AggroAI,
		},
		--AIAggroRange = 1500,
		PostAggroAI = AttackerAI,

		DefaultAIData =
		{
			DeepInheritance = true,
			AIMoveWithinRangeTimeoutMin = 4.0,
			AIMoveWithinRangeTimeoutMax = 8.0,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.5,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
		DestroyDelay = 0.2,
		HitSparkScale = 1.5,

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Satyrs!
			{ Cue = "/VO/ZagreusField_2195" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_2195" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Satyrs.
			{ Cue = "/VO/ZagreusField_2194", RequiredPlayed = { "/VO/ZagreusField_2195" } },
			-- Satyrs!
			{ Cue = "/VO/ZagreusField_2195" },
			-- More Satyrs!
			{ Cue = "/VO/ZagreusField_2196", RequiredPlayed = { "/VO/ZagreusField_2195" } },
			-- More Satyrs?
			{ Cue = "/VO/ZagreusField_2197", RequiredPlayed = { "/VO/ZagreusField_2195" } },
		},
	},

	SatyrRanged =
	{
		InheritFrom = {  "BaseSatyr", "BaseVulnerableEnemy", },
		GenusName = "SatyrRanged",
		PreferredSpawnPoint = "EnemyPointRanged",

		MaxHealth = 1300,
		HealthBarOffsetY = -185,
		HealthBarType = "Medium",

		IsAggroedSound = "/SFX/Enemy Sounds/Satyr/EmoteAlerted",
		OnDeathThreadedFunctionName = "AddPlaceholderEnemyCount",

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackSound = "/SFX/DusaHiss",

			AIMoveWithinRangeTimeoutMin = 2.0,
			AIMoveWithinRangeTimeoutMax = 4.0,
			AIAttackDistance = 1300,

			RetreatAfterAttack = true,
			RetreatTimeout = 0.75,
			AIBufferDistance = 1500,
		},

		SpawnObstaclesOnDeath =
		{
		},

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		WeaponOptions =
		{
			"SatyrSingleShot",
		},

		PostAggroAI = AttackerAI,

		GeneratorData =
		{
			DifficultyRating = 130,
			BlockEnemyTypes = {"SatyrRangedElite"}
		},

		LargeUnitCap = 5,
		Binks =
		{
			"Enemy_SatyrRangedAttack_Bink",
			"Enemy_SatyrOnHit_Bink",
			"Enemy_SatyrIdle_Bink",
			"Enemy_SatyrMove_Bink",
			"ShadeDeathVFX_Bink",
			"Enemy_SatyrMoveStop_Bink"
		},
	},

	SatyrRangedElite =
	{
		InheritFrom = { "Elite", "SatyrRanged" },
		EliteAttributeOptions = CombineTables(EnemySets.AllEliteAttributes, EnemySets.RangedOnlyEliteAttributes ),

		HealthBuffer = 1100,
		HealthBarOffsetY = -185,

		IsAggroedSound = "/SFX/Enemy Sounds/Satyr/EmoteTaunting",

		WeaponOptions =
		{
			"SatyrSplitShot",
		},

		GeneratorData =
		{
			DifficultyRating = 230,
			BlockEnemyTypes = {"SatyrRanged"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.97,
		},
	},

	SatyrRangedMiniboss =
	{
		InheritFrom = { "Elite", "SatyrRanged" },

		Health = 1200,
		HealthBuffer = 2500,
		HealthBarType = "MediumLarge",

		IsAggroedSound = "/SFX/Enemy Sounds/Satyr/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackDash = "SatyrDash",
			PreAttackDashChance = 1.0,
		},

		WeaponOptions =
		{
			"SatyrMinigun",
		},

		GeneratorData =
		{
			DifficultyRating = 700,
			MaxCount = 1,
			BlockEnemyTypes = { "SatyrRanged", "SatyrRangedElite" },
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 3,
			Threshold = 0.97,
		},

		LargeUnitCap = 5,
		Binks =
		{
			"Enemy_SatyrMinibossRangedAttack_Bink",
			"Enemy_SatyrMinibossOnHit_Bink",
			"Enemy_SatyrMinibossIdle_Bink",
			"Enemy_SatyrMinibossMove_Bink",
			"ShadeDeathVFX_Bink",
			"Enemy_SatyrMinibossMoveStop_Bink"
		},
	},

	-- Rats
	Crawler =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},
		GenusName = "Crawler",

		MaxHealth = 1,
		HealthBarOffsetY = -100,
		AddOutlineImmediately = true,

		PreferredSpawnPoint = "EnemyPointMelee",
		Groups = { "FlyingEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/Crawler/EmoteAlerted",
		Material = "Organic",

		--AIAggroRange = 725,
		AggroDuration = 0.5,
		ActiveCapWeight = 0.4,

		FireWeaponOnActivationFinished = "RatSpawnWeaponSmall",

		DefaultAIData =
		{
			DeepInheritance = true,
			AIRequireProjectileLineOfSight = false,
			AIRequireUnitLineOfSight = true,
			SetupDistance = 400,
			SetupTimeout = 8.0,
			RamDistance = 50,
			RamTimeout = 1.0,
			RamWeaponName = "CrawlerRush",
			RamEffectName = "RamBerserk",
			PreAttackAnimation = "EnemyCrawlerIdle",
			PreAttackSound = "/SFX/Enemy Sounds/Swarmer/EmoteCharging",
			PreAttackShake = 400,
			PreAttackFlash = 1.0,
			PreAttackDuration = 0.25,
			PreAttackEndMinWaitTime = 0.25,
			PreAttackAnimation = "EnemyCrawlerIdle",
			RamRecoverTime = 1.0,
			PreAttackEndShake = true,

			UseRamAILoop = true,
			RetreatAfterRam = true,
			AIBufferDistance = 400,
			RetreatTimeout = 0.3,
		},
		AIOptions =
		{
			AggroAI,
		},
		PostAggroAI = AttackerAI,

		WeaponOptions = { "CrawlerRush" },

		GeneratorData =
		{
			DifficultyRating = 10,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.1,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.1,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		DeathForce = 1100,

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Crawlers!
			{ Cue = "/VO/ZagreusField_2187" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_2187" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Crawlers.
			{ Cue = "/VO/ZagreusField_2186", RequiredPlayed = { "/VO/ZagreusField_2187" } },
			-- Crawlers!
			{ Cue = "/VO/ZagreusField_2187" },
			-- More Crawlers!
			{ Cue = "/VO/ZagreusField_2188", RequiredPlayed = { "/VO/ZagreusField_2187" } },
			-- More Crawlers?
			{ Cue = "/VO/ZagreusField_2189", RequiredPlayed = { "/VO/ZagreusField_2187" } },
		},
	},

	CrawlerMiniBoss =
	{
		InheritFrom = { "BaseBossEnemy", "Elite", "Crawler" },
		HealthBarTextId = "CrawlerMiniBoss_Full",

		MaxHealth = 12000,

		OnDeathFunctionName = "CrawlerMiniBossKillPresentation",
		OnDeathFunctionArgs = { Message = "CrawlerDefeatedMessage", StartPanTime = 1.0, EndPanTime = 2.0, EndAngle = 270, FlashRed = true, MessageDelay = 0.5 },
		DeathAnimation = "EnemyCrawlerMiniBossDeath",

		SpawnOptions =
		{
			"RatThug",
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			UseRamAILoop = false,
			RamWeaponName = "CrawlerRushMiniBoss",
		},
		AIOptions =
		{
			AttackerAI,
		},
		SkipSetupSelectWeapon = true,

		WeaponOptions = { "CrawlerRushMiniBoss", "CrawlerRushMiniBoss", "CrawlerSpawns", "CrawlerReburrow" },

		MoneyDropOnDeath =
		{
			Chance = 1.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 100,
			MaxValue = 130,
			IgnoreRoomMoneyStore = true,
			--ValuePerDifficulty = 0.33,
			--ValuePerDifficultyMaxValueVariance = 1.3,
		},
	},

	RatThug =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},
		GenusName = "RatThug",

		MaxHealth = 1600,
		HealthBarOffsetY = -130,
		AddOutlineImmediately = true,

		PreferredSpawnPoint = "EnemyPointMelee",
		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/RatThug/EmoteCharging",
		Material = "Organic",

		FireWeaponOnActivationFinished = "RatSpawnWeapon",

		SpawnObstaclesOnDeath =
		{
		},

		DefaultAIData =
		{

		},

		AIOptions =
		{
			AggroAI,
		},
		--AIAggroRange = 725,

		WeaponOptions =
		{
			"RatThugMelee", "RatPoisonShake"
		},

		LargeUnitCap = 5,
		GeneratorData =
		{
			DifficultyRating = 75,
			BlockEnemyTypes = {"RatThugElite"}
		},

		MoneyDropOnDeath =
		{
			Chance = 0.35,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.065,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
		MoneyDropGlobalVoiceLines = "VerminMoneyDropVoiceLines",

		DeathForce = 1100,

		EnemyFirstEncounterVoiceLines =
		{
			BreakIfPlayed = true,
			
			-- Vermin!
			{ Cue = "/VO/ZagreusField_2191" },
		},
		EnemySightedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			RequiredFalsePlayedThisRun = { "/VO/ZagreusField_2191" },
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro" },
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.2,

			-- Vermin.
			{ Cue = "/VO/ZagreusField_2190", RequiredPlayed = { "/VO/ZagreusField_2191" } },
			-- Vermin!
			{ Cue = "/VO/ZagreusField_2191" },
			-- More Vermin!
			{ Cue = "/VO/ZagreusField_2192", RequiredPlayed = { "/VO/ZagreusField_2191" } },
			-- More Vermin?
			{ Cue = "/VO/ZagreusField_2193", RequiredPlayed = { "/VO/ZagreusField_2191" } },
		},

		LargeUnitCap = 5,
		Binks =
		{
			"Enemy_RatThugIdle_Bink",
			"Enemy_RatThugMove_Bink",
			"Enemy_RatThugShake_Bink",
			"Enemy_RatThugAttackBite_Bink",
			"Enemy_RatThugOnHit_Bink",
			"Enemy_RatThugBurrow_Bink",
		},
  	},



	RatThugElite =
	{
		InheritFrom = { "Elite", "RatThug" },

		HealthBuffer = 1400,
		HitSparkScale = 2.5,
		GeneratorData =
		{
			DifficultyRating = 110,
			BlockEnemyTypes = {"RatThug"}
		},
		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	RatThugMiniboss =
	{
		InheritFrom = { "Elite", "RatThug" },

		Health = 1600,
		HealthBuffer = 5500,

		WeaponOptions =
		{
			"RatThugMeleeMiniboss", "RatPoisonShakeMiniboss",
		},

		GeneratorData =
		{
			DifficultyRating = 400,
			MaxCount = 1,
			BlockEnemyTypes = { "RatThug", "RatThugElite" },
		},

		HitSparkScale = 3.0,

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},


	-- TRAINING DUMMIES
	-- Skelly, Id = 420928
	TrainingMelee =
	{
		InheritFrom = { "BaseVulnerableEnemy", "NPC_Neutral", "NPC_Giftable" },
		GenusName = "NPC_Skelly_01",
		EmoteOffsetX = -80,
		EmoteOffsetY = -150,
		RequiredKill = false,
		UseShrineUpgrades = false,
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedSkeleton",
			Rapid = "HitSparkEnemyDamagedSkeletonRapid",
		},
		MaxHealth = 900,
		HealthBarOffsetY = -145,
		HealthBarType = "MediumLarge",
		SkipDamageText = false,
		AnimOffsetZ = 200,
		UnuseableWhenDead = true,
		SpeechCooldownTime = 9,
		NoComboPoints = false,
		IgnoreAutoLock = false,
		BondAlwaysApplies = true,

		Groups = { "GroundEnemies", "TrainingEnemies" },

		Material = "Bone",

		--AITurnDelayMin = 0.5,
		--AITurnDelayMax = 0.5,

		MeterMultiplier = 0,
		RespawnAtIdOnDeath = 40107,
		RespawnDelay = 4.85,

		ActivateRequirements =
		{
			RequiredTrueFlags = { "SkellyUnlocked" },
		},

		CustomEffectOffsetY = 
		{
			MarkBondTarget = -220
		},

		WeaponOptions =
		{
			"HeavyMelee",
		},

		AIOptions =
		{
			TrainingAI,
		},
		AITetherToSpawnLocation = true,
		AITetherDistance = 0,

		Portrait = "Portrait_Skelly_Default_01",
		Groups = { "NPCs" },

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		InteractTextLineSets =
		{
			SkellyFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- If you insist...!
				EndCue = "/VO/ZagreusHome_0165",
				EndWait = 0.45,
				{ Cue = "/VO/Skelly_0371",
					Text = "Nice place you got here, boyo! Name's Skelly, how's it going, but enough with the small talk already, I'm here to do a job. So let me have it! Give me everything you got!!" },
				{ Cue = "/VO/ZagreusHome_0164", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "I don't remember having you on payroll, mate. Who's your supervisor?" },
				{ Cue = "/VO/Skelly_0160",
					Text = "{#DialogueItalicFormat}Oh-hoh{#PreviousFormat}, I'm not about to rat my sources, pal! Just try and beat it out of me!" },
			},
			SkellyMiscMeeting01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyFirstMeeting", },
				UseableOffSource = true,
				-- OK!
				EndCue = "/VO/ZagreusHome_0385",
				EndWait = 0.45,
				{ Cue = "/VO/ZagreusField_0347", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Don't suppose I can talk you into fighting back this time?" },
				{ Cue = "/VO/Skelly_0006",
					Text = "Not a chance, boyo, I'm paid to take it not to dish it out! Now give it to me!!" },
			},
			SkellyMiscMeeting02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyMiscMeeting01" },
				UseableOffSource = true,
				RequiredAccumulatedMetaPoints = 200,
				{ Cue = "/VO/Skelly_0161",
					Emote = "PortraitEmoteSparkly",
					Text = "Hey, you're getting pretty strong, there, pal! Though, I am being paid to tell you that! But not being paid to not tell you that last part..." },
				{ Cue = "/VO/ZagreusHome_0169", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusExpressiveEmpathy", PreLineAnimTarget = "Hero",
					Text = "I have to ask you something, mate. What do you even need the pay for, anyway?" },
				{ Cue = "/VO/Skelly_0162",
					Text = "That, pal, is nobody's business but my own! Besides, it's impolite discussing money all the time! Now back to beating me to powder!" },
			},

			SkellyHintMeeting01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredFalseTextLines = { "SkellyNoMoreHintMeetings01" },
				RequiredMetaUpgradeUnlocked = "BackstabMetaUpgrade",
				RequiredMaxRunsCleared = 2,
				RequiredMaxCompletedRuns = 20,
				UseableOffSource = true,
				-- I'll keep that in mind, mate.
				EndCue = "/VO/ZagreusScratch_0016a",
				EndWait = 0.45,
				{ Cue = "/VO/Skelly_0168",
					Text = "Let me give you a piece of advice, boyo. You run across a guy like me out there, you just give him a good stab right in the back without a second thought before he sends you crying back to Papa." },
			},
			SkellyHintMeeting02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredFalseTextLines = { "SkellyNoMoreHintMeetings01" },
				RequiredAccumulatedMetaPoints = 50,
				RequiredMaxRunsCleared = 2,
				RequiredMaxCompletedRuns = 20,
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0003",
					Text = "You getting pretty strong, I'll give you that, boyo. Strong enough to smack a guy like me right up against the wall and I'd go straight to pieces, {#DialogueItalicFormat}boom{#PreviousFormat}! You just remember, when you're duking it out, the walls are your friend!" },
				{ Cue = "/VO/ZagreusHome_0166", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					Text = "Smack guys against walls. Sound advice as ever, mate." },
			},
			SkellyHintMeeting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredFalseTextLines = { "SkellyNoMoreHintMeetings01" },
				RequiredMaxRunsCleared = 2,
				RequiredMaxCompletedRuns = 15,
				{ Cue = "/VO/Skelly_0169",
					Text = "Hey pal watch where you throw those bloodstone things of yours, you drop them, you go pick them up, you understand? But if somebody gives you grief, you got my permission to chuck one right in his eye!" },
				{ Cue = "/VO/ZagreusHome_0479", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'll just aim generally for the midsection since the eyes are a lot harder to hit in my experience." },
			},
			SkellyHintMeeting04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredFalseTextLines = { "SkellyNoMoreHintMeetings01" },
				RequiredMaxRunsCleared = 2,
				RequiredMaxCompletedRuns = 15,
				{ Cue = "/VO/Skelly_0170",
					Text = "You're pretty quick, you know, boyo! Just be sure to use that fancy dash of yours and keep 'em guessing! Don't let 'em catch you standing still!" },
				{ Cue = "/VO/ZagreusHome_0168", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					Text = "Dash like mad instead of standing still. That's not the worst advice, I guess." },
			},
			SkellyHintMeeting05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredFalseTextLines = { "SkellyNoMoreHintMeetings01" },
				RequiredSeenEncounter = "Shop",
				RequiredMaxRunsCleared = 2,
				RequiredMaxCompletedRuns = 20,
				{ Cue = "/VO/Skelly_0171",
					Text = "Little tip, boyo? You find any coinage while you're out there, you be sure to pawn it off to that old Charon, boatman guy? Use it or lose it, pal, use it or lose it." },
				{ Cue = "/VO/ZagreusHome_0167", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					Text = "Thanks, mate, note to self: Always spend everything I earn instead of ever saving." },
			},
			SkellyHintMeeting06 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredFalseTextLines = { "SkellyNoMoreHintMeetings01" },
				RequiredSeenRooms = { "A_MiniBoss01" },
				RequiredMaxRunsCleared = 2,
				RequiredMaxCompletedRuns = 20,
				{ Cue = "/VO/Skelly_0174",
					Text = "Once in a while, pal, you're going to see a real fancy bozo try to ruin your good time. You'll know him 'cause he's glowing like a light, but that's his special armor, see? You got to punch right through it, he's going to shrug you off until you do!" },
				{ Cue = "/VO/ZagreusHome_0548", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					Text = "For a good time, beware the fancy glowing bozos on my quest. Check." },
			},
			SkellyHintMeeting07 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredFalseTextLines = { "SkellyNoMoreHintMeetings01" },
				{ Cue = "/VO/Skelly_0173",
					Text = "You know something, boyo, I think you could do a real number on one of these columns holding up this place, and bring the whole thing down in just a few swipes, boom, boom, {#DialogueItalicFormat}BOOM{#PreviousFormat}! I'd hate to be standing near one of them if you did!" },
				{ Cue = "/VO/ZagreusHome_0480", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					Text = "Wreck my father's finely crafted architecture every chance I get. That I can do for sure." },
			},
			SkellyHintMeeting09 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredFalseTextLines = { "SkellyNoMoreHintMeetings01" },
				RequiredRoomThisRun = "C_Intro",
				RequiredMaxRunsCleared = 2,
				RequiredMaxCompletedRuns = 20,
				{ Cue = "/VO/Skelly_0248",
					Text = "Boyo, next time you make it to the big VIP area upstairs, you watch out for those weapon-wielding gents out there! The eyeball soul thing that pops out when you beat 'em? You got to squash those, too, or else they'll grab their gear and come right back!" },
				{ Cue = "/VO/ZagreusHome_0867", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					Text = "Crush the souls of Elysium's Exalted shades to stop them from regenerating over and over. I'll definitely do that next time I'm there." },
			},

			SkellyHintMeeting_EasyMode01 =
			{
				Priority = true,
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredMinCompletedRuns = 7,
				RequiredFalseSeenRooms = { "A_PostBoss01" },
				RequiredFalseFlags = { "HardMode" },
				RequiredFalseConfigOptions = { "EasyMode" },
				StatusAnimation = "StatusIconWantsToTalkImportant",
				EndVoiceLines =
				{
					PreLineWait = 0.35,
					ObjectType = "TrainingMelee",
					-- Exactly, pal, that's it!
					{ Cue = "/VO/Skelly_0368" },
				},
				{ Cue = "/VO/Skelly_0367",
					Emote = "PortraitEmoteFiredUp",
					Text = "If you're having a rough time out there, boyo, you just remember something: You're a {#DialogueItalicFormat}god{#PreviousFormat}, all right?! Way tougher than you think. They give you trouble, you just turn on {#DialogueItalicFormat}God Mode{#PreviousFormat}, and you let 'em have it for me!" },
				{ Cue = "/VO/ZagreusHome_1506", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					PostLineThreadedFunctionName = "DisplayGodModeHint",
					Text = "You act as though this {#DialogueItalicFormat}God Mode {#PreviousFormat}is some sort of lever I can simply switch at will if ever I wish to unlock my latent strength, there, mate." },
			},

			SkellyAboutHintMeetings01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredMinAnyTextLines = { TextLines = { "SkellyHintMeeting01", "SkellyHintMeeting02", "SkellyHintMeeting03", "SkellyHintMeeting04", "SkellyHintMeeting05", "SkellyHintMeeting06", "SkellyHintMeeting07", "SkellyHintMeeting09", "SkellyHintMeeting_EasyMode01" }, Count = 4 },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.4,
					-- If I must.
					{ Cue = "/VO/ZagreusHome_3086" },
				},
				{ Cue = "/VO/ZagreusHome_3085", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Skelly, how do you know all this stuff, by the way? I mean no offense, but you're a skeleton who just stands around. Yet you have this wealth of knowledge of the Underworld?" },
				{ Cue = "/VO/Skelly_0527",
					Text = "Hey, I know people, pal! We'll just have to leave it at that. Now let's see you break some of these bones, huh?" },
			},
			SkellyNoMoreHintMeetings01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredMinRunsCleared = 2,
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "TrainingMelee",
					-- Yep. Now hop to it!
					{ Cue = "/VO/Skelly_0530" },
				},
				{ Cue = "/VO/Skelly_0529",
					Text = "Well, pal? You have come a pretty long way, let me tell {#DialogueItalicFormat}you{#PreviousFormat}. I think most of the smarts I've picked up, you know by now. And so... if I'm fresh out of tips for you... I guess there's only one thing left to do." },
				{ Cue = "/VO/ZagreusHome_3088", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Stand there eternally to be whaled upon at my whim, using whichever weapon suits me at the time?" },
			},

			SkellyAboutSkellyPainting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredCosmetics = { "Cosmetic_LoungePaintingSkelly" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "TrainingMelee",
					-- Yeah, no, that definitely wouldn't fly.
					{ Cue = "/VO/Skelly_0526" },
				},
				{ Cue = "/VO/ZagreusHome_3083", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Say, mate? I picked up a painting for our lounge that looked a little like yourself. Reminds me... have you ever even been inside? Should come join us sometime." },
				{ Cue = "/VO/Skelly_0525",
					Text = "Ah, you know, while I appreciate that, there, boyo... those kind of social spaces, they're not really for me. I kind of like it out here, just me, these bats whizzing around from time to time.... Besides! The old contract makes it pretty clear I got to stay right here." },
				{ Cue = "/VO/ZagreusHome_3084", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "What if I picked you up bodily and brought you in? Contract have anything to say about that?" },
			},

			SkellyRunProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredMinTimesSeenRoom = { B_Intro = 2 },
				RequiredFalseTextLines = { "SkellyRunCleared01" },
				{ Cue = "/VO/Skelly_0165",
					Text = "Got to say, you're really getting somewhere, boyo, I'm pretty impressed here! And they don't even pay me to do that, I'm just supposed to stand around!" },
				{ Cue = "/VO/ZagreusHome_0171", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Appreciate the vote of confidence, mate. Maybe you're right and someday I'll get out of here. Hey, if I never come back, you won't just be stuck here forever, will you?" },
				{ Cue = "/VO/Skelly_0166",
					Emote = "PortraitEmoteSparkly",
					Text = "{#DialogueItalicFormat}Heh, hehehe{#PreviousFormat}, that's a good one! {#DialogueItalicFormat}No{#PreviousFormat}! Probably not. Wasn't anything in the old contract about that... {#DialogueItalicFormat}huh{#PreviousFormat}." },
			},
			SkellyRunProgress02 =
			{
				Priority = true,
				PlayOnce = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredFalseSeenRooms = { "A_PostBoss01" },
				ConsecutiveDeathsInRoom = { Name = "A_Boss01", Count = 3, },
				UseableOffSource = true,
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.4,
					-- Appreciate it, Skelly.
					{ Cue = "/VO/ZagreusHome_3087" },
				},
				{ Cue = "/VO/Skelly_0528",
					Text = "Hitting a wall out there, boyo? Hey I know the feeling. You just keep at it, though! You're getting tougher, getting smarter... between the two of those, I'm thinking you'll pull through soon enough here." },
			},

			SkellyBackstory01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyGift01", "NyxGift01", "AchillesGift01" },
				RequiredAnyOtherTextLines = { "SkellyRunProgress01", "SkellyRunCleared01" },
				UseableOffSource = true,
				{ Cue = "/VO/ZagreusHome_0172", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Come on, mate, won't you say who hired you? Was it Achilles? Couldn't have been Nyx...? Is it that big a deal?" },
				{ Cue = "/VO/Skelly_0167",
					Text = "I am an individual of some integrity, boyo, and protect my sources with my life! You'll have to kill me if you want to make me squeal!" },
			},
			SkellyBackstory02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyGift03", "SkellyBackstory01", "ThanatosFirstAppearance", "HermesFirstPickUp" },
				RequiredAnyTextLines = { "CharonFirstMeeting", "CharonFirstMeeting_Alt" },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.4,
					-- Hrm.
					{ Cue = "/VO/ZagreusHome_2941" },
				},
				{ Cue = "/VO/ZagreusHome_2939", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Say, {#DialogueItalicFormat}uh{#PreviousFormat}, Skelly? How'd you get here, anyway?" },
				{ Cue = "/VO/Skelly_0481",
					Text = "Oh, you know, just kind of zapped right in, like Papa lets us do! Some of us sometimes. Why do you ask?" },
				{ Cue = "/VO/ZagreusHome_2940", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I meant... how did you get to the realm of the dead, in the first place. Lord Hermes whisk you to the entryway? Thanatos scoop you up, Charon give you a lift, what?" },
				{ Cue = "/VO/Skelly_0482",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteDepressed", WaitTime = 4.3 },
					Text = "Oh, {#DialogueItalicFormat}haha{#PreviousFormat}! Well, that's a little personal, don't you think, boyo? I... I don't like to talk about it much. So, if I could have a little privacy...?" },
			},
			SkellyBackstory03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyBackstory02", "SkellyGift08" },
				UseableOffSource = true,
				EndVoiceLines =
				{
					PreLineWait = 0.3,
					ObjectType = "TrainingMelee",
					-- Oh, hahaha, but I do!
					{ Cue = "/VO/Skelly_0504" },
				},
				{ Cue = "/VO/ZagreusHome_2962", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Skelly, is it really true you don't want to talk about how you got here? Just curious who you used to be. What you were like. Your real name." },
				{ Cue = "/VO/Skelly_0501",
					Emote = "PortraitEmoteFiredUp",
					Text = "Hey, what makes you think this isn't my real name, pal? I'm offended!" },
				{ Cue = "/VO/ZagreusHome_2963", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					PortraitExitAnimation = "Portrait_Zag_Empathetic_01_Exit",
					Text = "Sorry, what I meant was... I was just interested to get to know you better, after all you've done to help. Anything you can share? Trade you for a detail about me!" },
				{ Cue = "/VO/Skelly_0502", PreLineWait = 3.0, Speaker = "SkellyBackstory",
					PreLineThreadedFunctionName = "SkellyBackstoryPresentationStart",
					Text = "...Well all right... I was once a commander of men. Name of Schelemeus. Captain of the Cretan second fleet, sailing on Athens under King Minos. We were unstoppable... but then one day... one wrong turn... and we sailed straight into the waters of Charybdis." },
				{ Cue = "/VO/ZagreusHome_2964", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					PostLineThreadedFunctionName = "SkellyBackstoryPresentationEnd",
					Text = "Skelly, that's... that's incredible! So then... you and your crew, you perished at sea?" },
				{ Cue = "/VO/Skelly_0503", PreLineWait = 0.35,
					EndSecretMusic = true,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSurprise", DoShake = true, WaitTime = 2.5 },
					Text = "I, uh, {#DialogueItalicFormat}pfff, hahaha{#PreviousFormat}, boyo, you are something else, you know? All that Schelemeus stuff, I could have had you eating out of my hand for days!" },
				{ Cue = "/VO/ZagreusHome_2965", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "Oh, I get it. You got me. Fine, then, {#DialogueItalicFormat}Schelemeus{#PreviousFormat}, but I don't appreciate the trick." },
			},
			SkellyBackstory04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyBackstory03", "SkellyGift05" },
				UseableOffSource = true,
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "TrainingMelee",
					-- Yep!
					{ Cue = "/VO/Skelly_0505" },
				},
				{ Cue = "/VO/ZagreusHome_2966", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Skelly... I'm serious. You really won't tell me anything about you? You're just going to leave me to speculate, forever?" },
			},
			SkellyBackstory05 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurAboutSkelly01" },
				UseableOffSource = true,
				EndVoiceLines =
				{
					{
						UsePlayerSource = true,
						PreLineWait = 0.4,
						-- Argh.
						{ Cue = "/VO/ZagreusField_4273" },
					},
					{
						ObjectType = "TrainingMelee",
						PreLineWait = 0.1,
						-- Hahaha!
						{ Cue = "/VO/Skelly_0539" },
					},
				},
				{ Cue = "/VO/ZagreusField_4269", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Say, Skelly... or should I say {#DialogueItalicFormat}Schelemeus{#PreviousFormat}? I happened to have a chat with somebody familiar with that name. Large bull-headed fellow originally from Crete. You said you made it all up! What's going on?" },
				{ Cue = "/VO/Skelly_0535",
					Emote = "PortraitEmoteSparkly",
					Text = "Never said I made it up, pal! I just knew you weren't going to believe me, I mean, look at me! I look like a captain of the Cretan second fleet to you?" },
				{ Cue = "/VO/ZagreusField_4270", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "I don't know. I've never met one. Do they all just stand around doing nothing?" },
				{ Cue = "/VO/Skelly_0536", Speaker = "SkellyBackstory",
					Emote = "PortraitEmoteFiredUp",
					Text = "Well, sounds like {#DialogueItalicFormat}somebody{#PreviousFormat}'s never had to lead like fifty-or-something sailors in a voyage across the sea in a Minoan galley with nothing but the stars to guide 'em! What do you think the captains do, pull the oars?" },
				{ Cue = "/VO/ZagreusField_4271", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Wait, what about Hermes? He gave me the impression you might have been somebody else. Nobody in particular. Not some great sea-captain." },
				{ Cue = "/VO/Skelly_0537",
					Emote = "PortraitEmoteFiredUp",
					Text = "What is it with you gods talking behind the backs of all your friends, boyo?" },
				{ Cue = "/VO/ZagreusField_4272", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					Emote = "PortraitEmoteFiredUp",
					Text = "Don't change the subject!" },
				{ Cue = "/VO/Skelly_0538",
					Emote = "PortraitEmoteFiredUp",
					Text = "Don't change the subject!" },
			},

			SkellyAboutSources01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyBackstory01", "HermesAboutSkelly01" },
				UseableOffSource = true,
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.4,
					-- Fine. Maybe.
					{ Cue = "/VO/ZagreusHome_2944" },
				},
				{ Cue = "/VO/ZagreusHome_2942", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "That Lucky Tooth you gave me, Skelly. First off, thanks again, and secondly... is this even yours? Had a run-in with Hermes, who got me thinking." },
				{ Cue = "/VO/Skelly_0483",
					Emote = "PortraitEmoteNervous",
					Text = "What, {#DialogueItalicFormat}haha{#PreviousFormat}, you going to believe everything that gabby guy tells you, now, boyo? He doesn't know a thing about me!" },
				{ Cue = "/VO/ZagreusHome_2943", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Never said he did. Though since you let on... what's your relationship to him? Working for him?" },
				{ Cue = "/VO/Skelly_0484",
					Emote = "PortraitEmoteFiredUp",
					Text = "No! Nope. Definitely not working for him, closer to a peer relationship. Well, other than the fact that he's a god and I'm just... well, what you see is what you get with me, pal. Hey, you won't tell anyone, will you? I'm just here to help, I swear!" },
			},
			SkellyAboutSources02 =
			{
				PlayOnce = true,
				GiftableOffSource = true,
				RequiredTextLines = { "AchillesAboutSkelly01", "DusaAboutSkelly01", "NyxAboutSkelly01", "ThanatosAboutSkelly01", "HermesAboutSkelly02", "SkellyAboutSources01", "SkellyGift09" },
				UseableOffSource = true,
				RequiredKills = { TrainingMelee = 3 },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.4,
					-- OK.
					{ Cue = "/VO/ZagreusHome_0627" },
				},
				{ Cue = "/VO/ZagreusHome_2945", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "All right, fess up, Skelly, who are you working for? I know it's not Achilles. It's not Nyx. Dusa has no idea who you are. My father... no way. Hypnos? Give me a break. So the House is ruled out." },
				{ Cue = "/VO/Skelly_0485",
					Text = "Sorry, pal, my lips are sealed. How about we change the subject?" },
				{ Cue = "/VO/ZagreusHome_2946", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					Text = "How about you tell me who your sources are?" },
				{ Cue = "/VO/Skelly_0486",
					Emote = "PortraitEmoteCheerful",
					Text = "Nope!" },
				{ Cue = "/VO/ZagreusHome_2947", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					Text = "Tell me." },
				{ Cue = "/VO/Skelly_0487",
					Text = "No way." },
				{ Cue = "/VO/ZagreusHome_2948", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					Emote = "PortraitEmoteFiredUp",
					Text = "Tell me!" },
				{ Cue = "/VO/Skelly_0488",
					Emote = "PortraitEmoteSurprise",
					Text = "I said no!" },
				{ Cue = "/VO/ZagreusHome_2949", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					Text = "Tell me, Skelly." },
				{ Cue = "/VO/Skelly_0489",
					Text = "Nuh-uh." },
				{ Cue = "/VO/ZagreusHome_2950", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					Text = "Come on, tell me, please?" },
				{ Cue = "/VO/Skelly_0490",
					Text = "No. Means. No." },
				{ Cue = "/VO/ZagreusHome_2951", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					Text = "Why won't you tell me?" },
				{ Cue = "/VO/Skelly_0491",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Nice try, pal." },
				{ Cue = "/VO/ZagreusHome_2952", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					Text = "What if I never hit you again?" },
				{ Cue = "/VO/Skelly_0492", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteNervous", WaitTime = 1 },
					Text = "...Uh... no...?" },
				{ Cue = "/VO/ZagreusHome_2953", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So help me, Skelly, if you don't tell me who you're working for, there will be no more violence between us, ever." },
				{ Cue = "/VO/Skelly_0493",
					Emote = "PortraitEmoteNervous",
					Text = "No... please, have mercy, boyo..." },
				{ Cue = "/VO/ZagreusHome_2954", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					Emote = "PortraitEmoteFiredUp",
					Text = "No mercy, Skelly. Tell me. Or else... it will be only pleasantries between us from here on out." },
				{ Cue = "/VO/Skelly_0494",
					PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 1 },
					Text = "Nrrrghh, {#DialogueItalicFormat}all right{#PreviousFormat}! But you got to promise me something, promise not to let on or tell anybody in your fancy House, all right? Or else I'm done for. {#DialogueItalicFormat}I'm serious{#PreviousFormat}!" },
				{ Cue = "/VO/ZagreusHome_2955", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					Text = "I promise. So...?" },
				{ Cue = "/VO/Skelly_0495", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "SpecialAudioPresentation",
					PreLineThreadedFunctionArgs = { Delay = 1.6, SoundName = "/Leftovers/Menu Sounds/TextReveal2", },
					Text = "...It's Charon." },
				{ Cue = "/VO/ZagreusHome_2956", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathy_Return", PreLineAnimTarget = "Hero",
					Text = "Charon! Huh." },
				{ Cue = "/VO/Skelly_0496",
					Text = "Yeah. He's rich. He's got connections to guys like me, and I think he's got a horse in this chariot race you've got going on around here with Papa." },
				{ Cue = "/VO/ZagreusHome_2957", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					Text = "What's his angle?" },
				{ Cue = "/VO/Skelly_0497",
					Text = "No idea. Maybe he likes you, maybe he's bored." },
				{ Cue = "/VO/ZagreusHome_2958", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "And Hermes... he's working for Charon, too?" },
				{ Cue = "/VO/Skelly_0498",
					Emote = "PortraitEmoteCheerful",
					Text = "Yep! Now, let's pretend like none of this ever happened, so I can stick around, all right? Remember, pal, you promised!" },
			},
			SkellyAboutSources03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "HermesAboutSecretService01", "CharonAboutSkelly01" },
				UseableOffSource = true,
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					ObjectType = "TrainingMelee",
					-- If you did, pal, I would not be here right now!
					{ Cue = "/VO/Skelly_0500" },
				},
				{ Cue = "/VO/ZagreusHome_2960", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					Text = "Skelly, did you tell Charon and Hermes about our little conversation from before, about your sources? Because, I didn't tell them, but... they seemed to know." },
				{ Cue = "/VO/Skelly_0499",
					Emote = "PortraitEmoteSurprise",
					Text = "Boyo, thought we agreed we weren't going to be having conversations on the subject from here on. Spares me having to spill my guts with my sources later." },
				{ Cue = "/VO/ZagreusHome_2961", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "I didn't get you into too much trouble, did I?" },
			},

			SkellyAboutSources04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyAboutSources02", "CharonAboutSecretService01", "ThanatosAboutCharon01", "OlympianReunionQuestComplete", "SkellyPostEpilogue01" },
				UseableOffSource = true,
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 4,
					-- Appreciate you answering!
					{ Cue = "/VO/ZagreusHome_3518" },
				},
				{ Cue = "/VO/ZagreusHome_3517", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					Text = "Hey, Skelly, what with everything out in the open now, with the Queen and Charon, and all that... mind if I mention some of this to Thanatos? Charon's his brother, after all." },
				{ Cue = "/VO/Skelly_0547",
					Emote = "PortraitEmoteSurprise",
					Text = "Oh! Yeah, now that you mention it, I guess that part of the old contract no longer applies. So, go right ahead! Appreciate you asking, pal." },
			},

			SkellyAboutGifting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyGift01" },
				EndVoiceLines =
				{
					PreLineWait = 0.15,
					ObjectType = "TrainingMelee",
					-- Hahaha, sure!
					{ Cue = "/VO/Skelly_0480" },
				},
				{ Cue = "/VO/Skelly_0478",
					Emote = "PortraitEmoteCheerful",
					Text = "Pal, thanks again for that Nectar bottle from before, stuff just goes right through me like you won't believe! Though, I hope you're not going around giving that stuff away to every bozo you know." },
				{ Cue = "/VO/ZagreusHome_2802", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "What, Skelly, you worried something bad is going to happen if I express a bit of generosity from time to time through our somewhat-illicit gift-giving custom around here?" },
				{ Cue = "/VO/Skelly_0479",
					Emote = "PortraitEmoteFiredUp",
					Text = "No, I'm worried you'll be wasting your time! If you give that stuff away, don't expect to get anything back. Well, not after the first time, anyway. Usually! I'm just saying... don't get your hopes up." },
				{ Cue = "/VO/ZagreusHome_2803", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Maybe I just want to show thanks to my friends for its own sake!" },
			},

			-- weapon aspects content
			SkellyAboutSuperLockKeys01 =
			{
				Priority = true,
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredFalseTextLinesThisRun = { "AchillesAboutSuperLockKeys01" },
				RequiredLifetimeResourcesGainedMin = { SuperLockKeys = 1 },
				RequiredLifetimeResourcesGainedMax = { SuperLockKeys = 4 },
				RequiredMaxRunsCleared = 0,
				{ Cue = "/VO/ZagreusHome_1891", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey, Skelly? You look like you know your way around Tartarus. Found some of this ancient Titan blood out there, and I was looking to score some more." },
				{ Cue = "/VO/Skelly_0444",
					Text = "Ah, you've come to the right place regarding that, there, pal! It's your mean weapons back there that can find the stuff. Once you get all the way through Tartarus with one, that's all the blood you're going to get! For the time being anyhow." },
				{ Cue = "/VO/ZagreusHome_2799", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "How am I supposed to keep track of which weapons I've earned these with, then?" },
				{ Cue = "/VO/Skelly_0476",
					Text = "I don't know, there's always the invention of writing stuff down? You'll figure something out." },
			},
			SkellyAboutSuperLockKeys02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyAboutSuperLockKeys01" },
				RequiredScreenViewedFalse = "WeaponUpgradeScreen",
				RequiredFalseWeaponsUnlocked = { "GunWeapon" },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.4,
					-- Unlock those first, then, huh.
					{ Cue = "/VO/ZagreusHome_2801" },
				},
				{ Cue = "/VO/ZagreusHome_2800", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Skelly, you mentioned the ancient bit of blood I found in Tartarus. Know what I'm supposed to do with this stuff?" },
				{ Cue = "/VO/Skelly_0477",
					Text = "Wouldn't know a thing about it! Definitely doesn't have anything to do with those Infernal Arms of yours, some of which appear to still be {#DialogueItalicFormat}unavailable to you{#PreviousFormat}, as I understand?" },
			},

			SkellyAboutWeaponEnchantments01 =
			{
				SuperPriority = true,
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredTrueFlags = { "AspectsUnlocked" },
				RequiredMaxUnlockedWeaponEnchantments = 6,
				RequiredFalseTextLines = { "SkellyAboutWeaponEnchantments02" },
				EndVoiceLines =
				{
					PreLineWait = 0.45,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 4,
					-- That's an imaginative theory, mate.
					{ Cue = "/VO/ZagreusHome_1066", RequiredScreenViewed = "WeaponUpgradeScreen", RequiredFalsePlayed = { "/VO/ZagreusHome_1067" } },
					-- I should go check it out.
					{ Cue = "/VO/ZagreusHome_1067", RequiredScreenViewedFalse = "WeaponUpgradeScreen", RequiredFalsePlayed = { "/VO/ZagreusHome_1066" } },
				},
				{ Cue = "/VO/Skelly_0250",
					Emote = "PortraitEmoteFiredUp",
					Text = "So the strangest thing happened while you were out, boyo! One of your weapon holder things back there, it picked up this eerie glow! Could see it from the corner of my eye!" },
				{ Cue = "/VO/ZagreusHome_1065", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Calm down, Skelly. I'm sure whatever it is is perfectly normal for a legendary semi-sentient Titan-slaying weapon from the dawn of time." },
				{ Cue = "/VO/Skelly_0251",
					Text = "That's just it! Those weapons of yours, they have seen some real business, pal. You're giving them a real workout, so maybe they're starting to like you or something? Loosening up a bit, you know? Like you and me!" },
			},
			SkellyAboutWeaponEnchantments02 =
			{
				Priority = true,
				PlayOnce = true,
				UseableOffSource = true,
				RequiredLifetimeResourcesSpentMin = { SuperLockKeys = 4 },
				RequiredMinUnlockedWeaponEnchantments = 4,
				RequiredScreenViewed = "WeaponUpgradeScreen",
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.6,
					-- Uh... sure.
					{ Cue = "/VO/ZagreusHome_1247" },
				},
				{ Cue = "/VO/Skelly_0276",
					Text = "You know, pal, when you're not around and it's just me and all your weapons, I mean your {#DialogueItalicFormat}Infernal Arms {#PreviousFormat}right over there, between us they are making me a bit uncomfortable." },
				{ Cue = "/VO/ZagreusHome_1246", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Can't blame you, mate. I wouldn't want to be stuck in a chamber with a bunch of legendary, quite possibly malevolent killing artifacts. Anything I can do?" },
				{ Cue = "/VO/Skelly_0277",
					Emote = "PortraitEmoteSparkly",
					Text = "Oh I didn't mean it like a bad thing, boyo! The weirder you make those things, the more it gives me the shakes, and keeps me hopping like this nice and steady till the next time you get back! So, thanks!" },
			},

			SkellyAboutFistWeapon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredMinRunsWithWeapons = { FistWeapon = 1 },
				RequiredMaxRunsWithWeapons = { FistWeapon = 12 },
				MaxRunsSinceAnyTextLines = { TextLines = { "AchillesAboutFistWeapon01" }, Count = 10 },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.4,
					-- All right, maybe I will.
					{ Cue = "/VO/ZagreusHome_2139" },
				},
				{ Cue = "/VO/ZagreusHome_2138", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Say, Skelly? Don't suppose you'd care to tell me how the infamous Twin Fists of Malphon came to be right here in this very courtyard, would you?" },
				{ Cue = "/VO/Skelly_0465",
					Emote = "PortraitEmoteSparkly",
					Text = "Nope! Not any of my business, pal, which is to say, I didn't see a thing! And even if I did, it isn't what I'm paid to do! Don't you have someone in your fancy House there paid to keep watch over stuff like that? Ask them!" },
			},

			SkellyAboutGuanYuAspect01 =
			{
				Priority = true,
				PlayOnce = true,
				UseableOffSource = true,
				RequiredLastInteractedWeaponUpgrade = "SpearSpinTravel",
				RequiredTextLines = { "AchillesRevealsGuanYuAspect01" },
				MaxRunsSinceAnyTextLines = { TextLines = { "AchillesRevealsGuanYuAspect01" }, Count = 15 },
				RequiredPlayed = { "/VO/ZagreusHome_2027" },
				RequiredFalsePlayed = { "/VO/ZagreusHome_3490", "/VO/ZagreusHome_2654", "/VO/ZagreusHome_2048", "/VO/ZagreusHome_2053", "/VO/ZagreusHome_2649" },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.5,
					-- I miss my fancy sorcery already.
					{ Cue = "/VO/ZagreusHome_2031" },
				},
				{ Cue = "/VO/Skelly_0455",
					Text = "Hey, just want to say, pal, that spooky {#DialogueItalicFormat}crimson phoenix {#PreviousFormat}stuff that you were going on about before? I mean, whoa, you just say some nonsense and you get a brand-new spear? I was so impressed, I decided to try that trick for myself!" },
				{ Cue = "/VO/ZagreusHome_2029", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					Emote = "PortraitEmoteDepressed",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "Oh, gods... Skelly, what did you do...?" },
				{ Cue = "/VO/Skelly_0456",
					Emote = "PortraitEmoteSparkly",
					Text = "Relax, boyo, just had a little chat with your old serving platter over there after you left, is all. That thing hits pretty hard! So, then, I say to it, {#DialogueItalicFormat}I see you through the eyes of the crimson phoenix{#PreviousFormat}... and you want to know what happened after that?" },
				{ Cue = "/VO/ZagreusHome_2030", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So you carelessly spoke secret words imparted by the Fates themselves to an infernal weapon forged at the dawn of creation, then what? Say, did you walk up to Aegis, or just shout over your shoulder?" },
				{ Cue = "/VO/Skelly_0457",
					Emote = "PortraitEmoteFiredUp",
					Text = "Over my shoulder! Anyway, what happened next was {#DialogueItalicFormat}nothing{#PreviousFormat}! Your {#DialogueItalicFormat}Aegis {#PreviousFormat}kept on bobbing like a dummy. So then I went and said that mumbo jumbo to every other weapon, but nope! Doesn't work at all. So much for your fancy sorcery, huh?" },
			},

			SkellyAboutPact01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting" },
				RequiredFalseFlags = { "HardMode" },
				RequiredMinRunsCleared = 1,
				RequiredMaxRunsCleared = 8,
				RequiredMinShrinePointThresholdClear = 0,
				EndVoiceLines =
				{
					PreLineWait = 0.55,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 3,
					-- As likely an explanation as any I guess.
					{ Cue = "/VO/ZagreusHome_1064" },
				},
				{ Cue = "/VO/ZagreusHome_1063", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "So, what exactly happened with the formerly pink window over there? Now it's got these sinister orange flames and an enormous Pact of Punishment hanging ominously over the exit. Father stop by?" },
				{ Cue = "/VO/Skelly_0274",
					Text = "Pal, I don't know a thing about it, honest! I was just minding my own business, when all the sudden, {#DialogueItalicFormat}wham{#PreviousFormat}! I get hit right in the back. I fall to pieces, no idea what's going on! When I finally come to, the window job was done...!" },
			},

			SkellyTrueDeathQuest_Beginning_01 =
			{
				Priority = true,
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyGift06" },
				RequiredMinUnlockedWeaponEnchantments = 4,
				RequiredFalseTextLines = { "SkellyTrueDeathQuest_Beginning_01B" },
				RequiredFalseMaxWeaponUpgrade = "SwordWeapon",
				RequiredFalseMaxWeaponUpgradeIndex = 1,
				StatusAnimation = "StatusIconWantsToTalkImportant",
				EndVoiceLines =
				{
					PreLineWait = 0.72,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 3,
					-- All right... maybe.
					{ Cue = "/VO/ZagreusHome_1406" },
				},
				{ Cue = "/VO/Skelly_0307",
					Emote = "PortraitEmoteDepressed",
					Text = "Listen, boyo: I don't know exactly how to put this, so I'm just going to come right out. I need your help with something, and, I'll be honest, I don't think you're going to like it." },
				{ Cue = "/VO/ZagreusHome_1403", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If it doesn't involve hacking away at you with reckless abandon, Skelly, I don't want to hear it. But... oh. You're being serious." },
				{ Cue = "/VO/Skelly_0308",
					Text = "I am. And funny you should put it like that. Boyo, I am asking you to get me out of here. {#DialogueItalicFormat}Permanently{#PreviousFormat}, if you catch my drift. This standing around stuff... just kind of wears on you, after a while, you know?" },
				{ Cue = "/VO/ZagreusHome_1404", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag", PreLineWait = 0.3,
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "...I know. I can only imagine. Tell me what I can do." },
				{ Cue = "/VO/Skelly_0309",
					Text = "That blade of yours back there. It's got a special power. You got to spruce it all the way up. Your Aspect, not somebody's else's. Then let me have it with that thing... and I'm out of here." },
				{ Cue = "/VO/ZagreusHome_1405", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "Then you'd be dead, forever? You're asking me to kill you." },
				{ Cue = "/VO/Skelly_0311",
					Text = "I know it's a lot to dump on you, but I got my reasons. I don't exactly have a lot of options, here, so... give it some thought. Till then, we'll act like nothing's changed, all right?" },
			},
			SkellyTrueDeathQuest_Beginning_01B =
			{
				Priority = true,
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyGift06" },
				RequiredMinUnlockedWeaponEnchantments = 4,
				RequiredFalseTextLines = { "SkellyTrueDeathQuest_Beginning_01" },
				RequiredMaxWeaponUpgrade = "SwordWeapon",
				RequiredMaxWeaponUpgradeIndex = 1,
				StatusAnimation = "StatusIconWantsToTalkImportant",
				EndVoiceLines =
				{
					PreLineWait = 0.72,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 3,
					-- All right... maybe.
					{ Cue = "/VO/ZagreusHome_1406" },
				},
				{ Cue = "/VO/Skelly_0307",
					Emote = "PortraitEmoteDepressed",
					Text = "Listen, boyo: I don't know exactly how to put this, so I'm just going to come right out. I need your help with something, and, I'll be honest, I don't think you're going to like it." },
				{ Cue = "/VO/ZagreusHome_1403", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If it doesn't involve hacking away at you with reckless abandon, Skelly, I don't want to hear it. But... oh. You're being serious." },
				{ Cue = "/VO/Skelly_0308",
					Text = "I am. And funny you should put it like that. Boyo, I am asking you to get me out of here. {#DialogueItalicFormat}Permanently{#PreviousFormat}, if you catch my drift. This standing around stuff... just kind of wears on you, after a while, you know?" },
				{ Cue = "/VO/ZagreusHome_1404", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag", PreLineWait = 0.3,
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "...I know. I can only imagine. Tell me what I can do." },
				{ Cue = "/VO/Skelly_0310",
					Text = "That blade of yours back there. It's got a special power. Your Aspect, now that it's maxed out. You got to let me have it with that thing... and then I'm out of here." },
				{ Cue = "/VO/ZagreusHome_1405", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					Text = "Then you'd be dead... forever? You're asking me to kill you." },
				{ Cue = "/VO/Skelly_0311",
					Text = "I know it's a lot to dump on you, but I got my reasons. I don't exactly have a lot of options, here, so... give it some thought. Till then, we'll act like nothing's changed, all right?" },
			},

			SkellyRunCleared01 =
			{
				Priority = true,
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting", "TrophyQuest_Beginning_01", "PersephoneMeeting06" },
				RequiresRunCleared = true,
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						-- Sure looks that way.
						{ Cue = "/VO/ZagreusHome_3512" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "TrainingMelee",
						-- Huzzah!
						{ Cue = "/VO/Skelly_0239" },
					},
				},
				{ Cue = "/VO/Skelly_0540",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteDepressed", WaitTime = 7.5 },					Text = "So, {#DialogueItalicFormat}uh{#PreviousFormat}, pal? My sources tell me that you made it pretty far. Which means... my usefulness is coming to an end." },
				{ Cue = "/VO/ZagreusHome_3510", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Your {#DialogueItalicFormat}usefulness{#PreviousFormat}, what, you just mean the standing around, letting me lay into you with whatever vicious attack sequence I fancy at the time?" },
				{ Cue = "/VO/Skelly_0541",
					Text = "Yeah! Once you achieve your goal... my contract's up. You won't need me anymore." },
				{ Cue = "/VO/ZagreusHome_3511", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "But only if I leave for good, isn't that right? So if I stuck around... you'd stay here, too?" },
				{ Cue = "/VO/Skelly_0542",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSparkly", WaitTime = 2.3 },
					Text = "Probably, but... wait, you're really going to stay?" },
			},

			SkellyPostEnding01 =
			{
				SuperPriority = true,
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting", "Ending01", "SkellyRunCleared01" },
				RequiredFalseTextLines = { "OlympianReunionQuestComplete" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 4,
					-- It better be.
					{ Cue = "/VO/ZagreusHome_3514" },
				},
				{ Cue = "/VO/Skelly_0543",
					Emote = "PortraitEmoteFiredUp",
					Text = "So Mama's back in town from what I hear, boyo! It's awful nice knowing I trained you well." },
				{ Cue = "/VO/ZagreusHome_3513", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "{#DialogueItalicFormat}Erm{#PreviousFormat}, you must mean the Queen, and evidently you're aware of our relationship. You keep that quiet, understand, Skelly?" },
				{ Cue = "/VO/Skelly_0544",
					Text = "{#DialogueItalicFormat}Ahh{#PreviousFormat}, and thus the pupil trains the master, for a change! I hear you, pal. Your secret's safe with me." },
			},

			SkellyPostEpilogue01 =
			{
				SuperPriority = true,
				PlayOnce = true,
				UseableOffSource = true,
				RequiredTextLines = { "SkellyFirstMeeting", "OlympianReunionQuestComplete" },
				EndVoiceLines =
				{
					PreLineWait = 0.4,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 4,
					-- Same here.
					{ Cue = "/VO/ZagreusHome_3516" },
				},
				{ Cue = "/VO/Skelly_0545",
					Text = "You must have had yourself a real bash, with all those fancy gods and stuff! Could hear all the festivity from all the way out here. How was it, pal?" },
				{ Cue = "/VO/ZagreusHome_3515", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "It... went better than expected, all in all. I hope you didn't feel left out! It was a pretty limited guest list. Kind of a diplomatic mission, I would say. Not quite as good a time as it might have sounded from the outside." },
				{ Cue = "/VO/Skelly_0546",
					Text = "{#DialogueItalicFormat}Ohh{#PreviousFormat}, don't you even worry about me, there, pal! I much prefer the solitary life, and besides! When things are good for you, they're good for me. Glad everything worked out." },
			},
		},

		RepeatableTextLineSets =
		{
			SkellyChat01 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0026",
					Text = "Less yakking, more smacking, boyo, now come on!" },
			},
			SkellyChat02 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0027",
					Text = "Less chatter, more batter, boyo, hit me already!" },
			},
			SkellyChat03 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0028",
					Text = "Less talking, more socking, here, pal!" },
			},
			SkellyChat04 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0029",
					Text = "Come on, boyo, less gabbing, more stabbing over here!" },
			},
			SkellyChat05 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0030",
					Text = "Less prattle, more battle, boyo, give me all you got!" },
			},
			SkellyChat06 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0031",
					Text = "Can't break {#DialogueItalicFormat}these {#PreviousFormat}bones, pal, what you just try it!" },
			},
			SkellyChat07 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0032",
					Text = "You want another a piece of this, or what?" },
			},
			SkellyChat08 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0033",
					Text = "Enough with the small talk, boyo, hit me, go on!" },
			},
			SkellyChat09 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0034",
					Text = "Trying to bore me to death with all this chit-chat, pal?" },
			},
			SkellyChat10 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0035",
					Text = "This look like a shoulder to cry on to you, boyo?" },
			},
			SkellyChat11 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0036",
					Text = "Let me have it already, boyo, no holding back!" },
			},
			SkellyChat12 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0037",
					Text = "Let's see what you can do in terms of hitting me, pal!" },
			},
			SkellyChat13 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0038",
					Text = "You could be hitting me right now, boyo!" },
			},
			SkellyChat14 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0039",
					Text = "Sure could go for somebody just whaling away on me right now." },
			},
			SkellyChat15 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0040",
					Text = "What's the matter, you gone soft or something, pal?" },
			},
			SkellyChat16 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Skelly_0041",
					Text = "You going to hit me over here, or what?" },
			},
			SkellyChat17 =
			{
				UseableOffSource = true,
				RequiredTextLines = { "SkellyGift05", },
				{ Cue = "/VO/Skelly_0042",
					Text = "Go on, boyo, give me your best shot, it's my job!" },
			},
			SkellyChat18 =
			{
				UseableOffSource = true,
				RequiredTextLines = { "SkellyGift05", },
				{ Cue = "/VO/Skelly_0043",
					Text = "Sure could use a good smack in the jaw from you right about now!" },
			},
			SkellyChat19 =
			{
				UseableOffSource = true,
				RequiredTextLines = { "SkellyGift05", },
				{ Cue = "/VO/Skelly_0044",
					Text = "You want to fight me, boyo, well hop to it, stat!" },
			},
			SkellyChat20 =
			{
				UseableOffSource = true,
				RequiredTextLines = { "SkellyGift05", },
				{ Cue = "/VO/Skelly_0045",
					Text = "What do I look like, pal, some kind of conversationalist?" },
			},
			SkellyChat21 =
			{
				UseableOffSource = true,
				RequiredTextLines = { "SkellyGift05", },
				{ Cue = "/VO/Skelly_0046",
					Text = "Our relationship, boyo, requires no exchange of words!" },
			},
		},

		GiftTextLineSets =
		{
			-- grants a gift
			SkellyGift01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/ZagreusHome_0110", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "For you, mate! Thought you might get a kick out of this." },
				{ Cue = "/VO/Skelly_0120",
					Emote = "PortraitEmoteSparkly",
					Text = "For me, pal? Awful nice of you, just awful nice, but guess what, I got this for you! Tit for tat, you understand, a deal's a deal!" },
			},
			SkellyGift02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyGift01", },
				{ Cue = "/VO/Skelly_0115",
					Emote = "PortraitEmoteSparkly",
					Text = "{#DialogueItalicFormat}Whoa-hoh{#PreviousFormat}, you being serious here, pal? You brought that all this way, for little old me?! That's real nice of you!" },
				{ Cue = "/VO/ZagreusHome_0161", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "You're not so bad yourself, mate. Thanks for always being here for me to savagely attack without a second thought." },
			},
			SkellyGift03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyGift02", },
				{ Cue = "/VO/Skelly_0116",
					Emote = "PortraitEmoteSparkly",
					Text = "{#DialogueItalicFormat}Whoaaaa{#PreviousFormat}, now get a load of what you got there, boyo! Wait, really, that's for me? Or you just pulling my leg?" },
				{ Cue = "/VO/ZagreusHome_0162", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "I'm really giving this to you, mate. Now go enjoy it, will you? Once I've finished pummeling you some more just for the sake of it." },
			},
			SkellyGift04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyGift03", },
				{ Cue = "/VO/Skelly_0117",
					Emote = "PortraitEmoteSparkly",
					Text = "Heeey now {#DialogueItalicFormat}that's {#PreviousFormat}what I'm talking about, thanks, boyo! Won't forget you doing me a solid like this, cross my heart!!" },
				{ Cue = "/VO/ZagreusHome_0163",
					Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "No need to thank me, mate. But don't you dare forget it or I'll attack you repeatedly and without mercy." },
			},
			SkellyGift05 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyGift04", },
				{ Cue = "/VO/Skelly_0118",
					Text = "Oh look here, pal, I can't just keep accepting these from you! Not when they're paying me already, I got standards to uphold, you know?" },
				{ Cue = "/VO/ZagreusHome_0513",
					Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenial_Full", PreLineAnimTarget = "Hero",
					Text = "I will look the other way if you do, mate. Now, here! Or else!" },
			},
			SkellyGift06 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyGift05", },
				{ Cue = "/VO/Skelly_0119",
					Text = "{#DialogueItalicFormat}Haaah{#PreviousFormat}, you're kidding, {#DialogueItalicFormat}what{#PreviousFormat}? Sometimes, boyo, you make me feel alive again, you know that? Being honest with you here, I'm grateful, really." },
				{ Cue = "/VO/ZagreusHome_0514", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "If not for you, my friend, I'd have no one to viciously attack with no fear of reprisal whatsoever." },
			},

			-- high relationship / locked gifts
			-- grants a gift
			SkellyGift07 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyGift06", },
				{ Cue = "/VO/ZagreusHome_1411", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					Text = "Skelly, while I know your services have already been paid in full, your sources ought to know you've been doing an excellent job. So much so, I wanted to give you this." },
				{ Cue = "/VO/Skelly_0318",
					Emote = "PortraitEmoteSparkly",
					Text = "{#DialogueItalicFormat}Whaaa{#PreviousFormat}, is that a vintage bottle of Ambrosia, pal?! I never even thought I'd get to try a thing like that, I mean, what am I, here? Know what, I want you to have this. To symbolize our friendship, and in case you ever need a hand out there." },
			},
			SkellyGift08 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyGift07", },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						-- Hah!! Nope!
						{ Cue = "/VO/Skelly_0320" },
					},
					{
						UsePlayerSource = true,
						PreLineWait = 0.6,
						-- Drat.
						{ Cue = "/VO/ZagreusHome_1415" },
					}
				},
				{ Cue = "/VO/ZagreusHome_1413", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					Text = "Hope you enjoyed that vintage bottle of Ambrosia last time, Skelly, because I got you another. Here!" },
				{ Cue = "/VO/Skelly_0319",
					Emote = "PortraitEmoteSparkly",
					Text = "{#DialogueItalicFormat}Aww{#PreviousFormat}, no way, boyo, you kidding me right now? Why are you even, I... look, I, I just stand around and let you beat me up, you don't have to do this. You don't even know who I am. Who I was." },
				{ Cue = "/VO/ZagreusHome_1414", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					Text = "You're my friend, mate. That's all that matters. Although... I don't suppose you're willing to divulge those types of details? Just out of curiosity." },
			},
			SkellyGift09 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyGift08", },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.6,
					-- Well great, I guess!
					{ Cue = "/VO/ZagreusHome_1509" },
				},
				{ Cue = "/VO/ZagreusHome_1507", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					Text = "You know, Skelly, I still cannot entirely get over that whole permanently-kill-you stunt you pulled on me. You had me deeply worried for a while, all for just a laugh?" },
				{ Cue = "/VO/Skelly_0369",
					Emote = "PortraitEmoteFiredUp",
					Text = "Yeah, that's right! Not exactly much to do here, case you hadn't noticed recently! Good thing I'm able to stay occupied with intellectual pursuits." },
				{ Cue = "/VO/ZagreusHome_1508", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "That's what you call it, then? In any case, I did want to make sure: You sure that you're all right, having to stand around like this?" },
				{ Cue = "/VO/Skelly_0370",
					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineFunctionArgs = { Text = "TrainingMelee", Icon = "Keepsake_SkellySticker_Max" },
					Text = "You kidding, pal? This is the life! Imagine getting paid to stand around! And being pals with you!" },
			},

		},

		OnDeathThreadedFunctionName = "CheckSkellyTrueDeathQuestCompletePresentation",
		OnDeathTextLineSets =
		{
			SkellyTrueDeathQuestComplete =
			{
				PlayOnce = true,
				-- SkellyTrueDeathQuestCompleteRequirements
				RequiredAnyTextLines = { "SkellyTrueDeathQuest_Beginning_01", "SkellyTrueDeathQuest_Beginning_01B" },
				RequiredWeapon = "SwordWeapon",
				RequiredLastInteractedWeaponUpgrade = "SwordBaseUpgradeTrait",
				RequiredLastInteractedWeaponUpgradeMaxed = true,
				GiftableOffSource = true,

				-- Then no more tricks like that again.
				EndCue = "/VO/ZagreusHome_1410",
				EndWait = 0.5,
				{ Cue = "/VO/Skelly_0316",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#DialogueItalicFormat}Hahaha{#PreviousFormat}, got you pretty good, again, didn't I, boyo?! {#DialogueItalicFormat}I am asking you to get me out of here. {#PreviousFormat}Hahahaha! All that stuff about your blade, and your Aspect, I mean, you ate all of it right up! {#DialogueItalicFormat}Woo, hoo-hoo!{#PreviousFormat}" },
				{ Cue = "/VO/ZagreusHome_1409", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "It appears I've been the victim of an elaborate prank. Not sure that I appreciate it, Skelly. What if I were to never hit you again, how would you like that?" },
				{ Cue = "/VO/Skelly_0317",
					Emote = "PortraitEmoteNervous",
					Text = "Whoa, {#DialogueItalicFormat}whoa whoa whoa whoa{#PreviousFormat}, whoa! Now come on, boyo, it was just a joke, I figured things could lighten up a little here. Don't need to do anything rash!" },
			},
		},

		GiftGivenVoiceLines =
		{
			{
				BreakIfPlayed = true,
				PreLineWait = 1.1,
				PlayFromTarget = true,
				RequiredTextLines = { "SkellyGift07" },

				-- Skelly, mate... this what I think it is?
				-- { Cue = "/VO/ZagreusHome_1412" },
				-- Skelly, mate! You really shouldn't have. Do you have any idea how hard-to-find this is?!
				{ Cue = "/VO/ZagreusHome_1487" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 1.0,
				PlayFromTarget = true,

				-- Cheers, mate.
				{ Cue = "/VO/ZagreusHome_0315" },
			},
		},

		WeaponUnlockReactionVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 2.7,
				Cooldowns =
				{
					{ Name = "SkellyWeaponEquipSpeech", Time = 10 },
				},

				-- Heeey nice!
				{ Cue = "/VO/Skelly_0085", },
				-- What'd you get, what'd you get?
				{ Cue = "/VO/Skelly_0086", },
				-- Get anything good?
				{ Cue = "/VO/Skelly_0087", },
				-- What is that thing?
				{ Cue = "/VO/Skelly_0088", },
				-- Hooh, you got one!
				{ Cue = "/VO/Skelly_0089", },
			},
		},

		EnteredOnslaughtReactionVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			CooldownTime = 12,

			-- Yeah all right.
			{ Cue = "/VO/Skelly_0053" },
			-- Yeah sure.
			{ Cue = "/VO/Skelly_0059" },

		},

		OnslaughtVictoryReactionVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			CooldownTime = 12,

			-- How's it going?
			{ Cue = "/VO/Skelly_0132" },
			-- Look at this guy over here.
			{ Cue = "/VO/Skelly_0151" },
			-- We have a winner!
			{ Cue = "/VO/Skelly_0240" },
		},
		OnslaughtFailReactionVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			CooldownTime = 12,

			-- Take another shot?
			{ Cue = "/VO/Skelly_0144" },
			-- Time for a break there, pal?
			{ Cue = "/VO/Skelly_0090" },
			-- So you want to give it a rest, or what?
			{ Cue = "/VO/Skelly_0091" },
		},
		FailedToEnterOnslaughtReactionVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.25,
			CooldownTime = 15,

			-- All right, pal, you can stop!
			{ Cue = "/VO/Skelly_0092" },
			-- Anytime you want to stop, there, boyo.
			{ Cue = "/VO/Skelly_0093" },
		},

		OnHitVoiceLinesQueueDelay = 0.6,

		OnHitByWeaponVoiceLines =
		{
			RangedWeapon =
			{
				CooldownTime = 5,
				CooldownName = "SkellyOnHit",
				RequiredFalseTraits = { "ShieldLoadAmmoTrait" },

				BreakIfPlayed = true,
				RandomRemaining = true,

				-- Ah you shot me!
				{ Cue = "/VO/Skelly_0138", },
				-- I'll hang onto that!
				{ Cue = "/VO/Skelly_0139", },
				-- Caught it!
				{ Cue = "/VO/Skelly_0140", },
				-- Stuck me good!
				{ Cue = "/VO/Skelly_0141", },
				-- I'm hit!
				{ Cue = "/VO/Skelly_0142", },
				-- Dropped something!
				{ Cue = "/VO/Skelly_0147", },
			},
		},

		OnHitVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				CooldownTime = 80,
				CooldownName = "SkellyOnHit",
				-- SkellyTrueDeathQuestCompleteRequirements
				RequiredWeapon = "SwordWeapon",
				RequiredLastInteractedWeaponUpgrade = "SwordBaseUpgradeTrait",
				RequiredLastInteractedWeaponUpgradeMaxed = true,
				RequiredAnyTextLines = { "SkellyTrueDeathQuest_Beginning_01", "SkellyTrueDeathQuest_Beginning_01B" },
				RequiredFalseTextLines = { "SkellyTrueDeathQuestComplete" },

				-- That's it, keep going!!
				{ Cue = "/VO/Skelly_0313" },
			},
			{
				CooldownTime = 8,
				CooldownName = "SkellyOnHit",
				{
					BreakIfPlayed = true,
					SuccessiveChanceToPlay = 0.75,
					RandomRemaining = true,
					RequiredTrueFlags = { "Overlook" },

					-- Well this is awkward!
					{ Cue = "/VO/Skelly_0094", RequiredPlayed = { "/VO/Skelly_0096" } },
					-- How am I supposed to get back?
					{ Cue = "/VO/Skelly_0095", RequiredPlayed = { "/VO/Skelly_0096" } },
					-- Don't think I'm supposed to be here.
					{ Cue = "/VO/Skelly_0096" },
					-- Uh kind of stuck here, pal.
					{ Cue = "/VO/Skelly_0097", RequiredPlayed = { "/VO/Skelly_0096" } },
				},
				{
					BreakIfPlayed = true,
					SuccessiveChanceToPlay = 0.75,
					RandomRemaining = true,
					PlayOnce = true,

					-- Never felt a cut like that before!
					{ Cue = "/VO/Skelly_0262", RequiredOneOfTraits = { "SwordCriticalParryTrait" }, },
					-- Love what you've done to your sword!
					{ Cue = "/VO/Skelly_0263", RequiredOneOfTraits = { "DislodgeAmmoTrait" } },
					-- That bow's got a different sting to it!
					{ Cue = "/VO/Skelly_0264", RequiredOneOfTraits = { "BowLoadAmmoTrait" } },
					-- New arrows or something there pal?
					{ Cue = "/VO/Skelly_0265", RequiredOneOfTraits = { "BowMarkHomingTrait" } },
					-- Your shield's looking pretty handsome pal!
					{ Cue = "/VO/Skelly_0266", RequiredTrait = "ShieldTwoShieldTrait" },
					-- I get the feeling I am being watched...?
					{ Cue = "/VO/Skelly_0267", RequiredTrait = "ShieldRushBonusProjectileTrait" },
					-- Never been stabbed quite like that!
					{ Cue = "/VO/Skelly_0268", RequiredTrait = "SpearTeleportTrait" },
					-- Felt all three points on that spear, pal!
					{ Cue = "/VO/Skelly_0269", RequiredTrait = "SpearWeaveTrait" },
					-- Hey that shot felt different somehow!
					{ Cue = "/VO/Skelly_0270", RequiredOneOfTraits = { "GunManualReloadTrait", "GunGrenadeSelfEmpowerTrait" } },
					-- You been messing with that shooty thing pal?
					{ Cue = "/VO/Skelly_0271", RequiredOneOfTraits = { "GunManualReloadTrait", "GunGrenadeSelfEmpowerTrait" } },
					-- More of a slicing feel there rather than a stabbing!
					{ Cue = "/VO/Skelly_0447", RequiredTrait = "SpearSpinTravel" },
					-- Yeoow that's got a nice little kick of heat to it!
					{ Cue = "/VO/Skelly_0468", RequiredTrait = "SwordConsecrationTrait" },
					-- Hooh now that's what I call getting shot by arrows!
					{ Cue = "/VO/Skelly_0469", RequiredTrait = "BowBondTrait" },
					-- Ah, yeah, that's the stuff!
					{ Cue = "/VO/Skelly_0471", RequiredTrait = "ShieldLoadAmmoTrait" },
					-- Ooh, nice burning sensation from that!
					{ Cue = "/VO/Skelly_0473", RequiredTrait = "GunLoadedGrenadeTrait" },
					-- Oof, I felt that deep down in my jaw!
					{ Cue = "/VO/Skelly_0548", RequiredTrait = "FistDetonateTrait" },
				},
				{
					BreakIfPlayed = true,
					SuccessiveChanceToPlay = 0.33,
					RandomRemaining = true,
					RequiredFalseTextLinesThisRoom = { "SkellyAboutSources01" },

					-- Eh, not bad!
					{ Cue = "/VO/Skelly_0012", },
					-- Felt that one!
					{ Cue = "/VO/Skelly_0013", },
					-- Eh nice!
					{ Cue = "/VO/Skelly_0014", },
					-- Yeah that's it!
					{ Cue = "/VO/Skelly_0015", },
					-- That's the stuff!
					{ Cue = "/VO/Skelly_0016", },
					-- Yeah boyo!
					{ Cue = "/VO/Skelly_0017", },
					-- Yeah!
					{ Cue = "/VO/Skelly_0018", },
					-- Oh yeah!
					{ Cue = "/VO/Skelly_0019", },
					-- Pretty nice!
					{ Cue = "/VO/Skelly_0020", },
					-- Whoa yeah!
					{ Cue = "/VO/Skelly_0021", },
					-- Oww nice!
					{ Cue = "/VO/Skelly_0022", },
					-- Good one!
					{ Cue = "/VO/Skelly_0023", },
					-- Almost felt that!
					{ Cue = "/VO/Skelly_0024", },
					-- Heh!
					{ Cue = "/VO/Skelly_0025", },
					-- Whoa-hoh!
					{ Cue = "/VO/Skelly_0063", },
					-- Yeeoww!
					{ Cue = "/VO/Skelly_0064", },
					-- That's the spirit!
					{ Cue = "/VO/Skelly_0065", },
					-- Yeah keep going!
					{ Cue = "/VO/Skelly_0066", },
					-- Ho-hohhh!
					{ Cue = "/VO/Skelly_0067", },
					-- Whoo!
					{ Cue = "/VO/Skelly_0068", },
					-- That kind of hurt!
					{ Cue = "/VO/Skelly_0069", },
					-- Hoh, yeah!
					{ Cue = "/VO/Skelly_0070", },
					-- Nice one!
					{ Cue = "/VO/Skelly_0071", },
					-- Real nice!
					{ Cue = "/VO/Skelly_0072", },
					-- Take another shot?
					{ Cue = "/VO/Skelly_0144", RequiredAnyWeapon = { "BowWeapon", "GunWeapon" } },
					-- Hah!
					{ Cue = "/VO/Skelly_0420", },
					-- Yeah that's it!
					{ Cue = "/VO/Skelly_0421", },
					-- What if I beg for mercy, huh?
					-- { Cue = "/VO/Skelly_0422", },
					-- Ah, no, keep hitting me!
					{ Cue = "/VO/Skelly_0423", },
					-- The pain is indescribable!
					{ Cue = "/VO/Skelly_0424", SuccessiveChanceToPlay = 0.01 },
					-- Didn't hurt.
					{ Cue = "/VO/Skelly_0425", },
					-- Didn't hurt!!
					{ Cue = "/VO/Skelly_0426", },
					-- Felt nothing there sorry!
					{ Cue = "/VO/Skelly_0427", },
					-- Weak!!
					{ Cue = "/VO/Skelly_0428", },
					-- Nah that was nothing.
					{ Cue = "/VO/Skelly_0429", },
					-- Pssh I coud hit harder than that!
					{ Cue = "/VO/Skelly_0430", },
					-- You call that a hit?
					{ Cue = "/VO/Skelly_0431", },
					-- Oh please.
					{ Cue = "/VO/Skelly_0432", },
					-- Nope couldn't feel a thing!
					{ Cue = "/VO/Skelly_0433", },
				},
			},
		},

		OnKillGlobalVoiceLines = "SkellyKilledVoiceLines",
		KillsRequiredForVoiceLines = 1,

		OnDeathVoiceLines =
		{
			Queue = "Interrupt",
			{
				{
					SkipAnim = true,
					PreLineWait = 0.8,

					-- SkellyTrueDeathQuestCompleteRequirements
					RequiredWeapon = "SwordWeapon",
					RequiredLastInteractedWeaponUpgrade = "SwordBaseUpgradeTrait",
					RequiredLastInteractedWeaponUpgradeMaxed = true,
					RequiredAnyTextLines = { "SkellyTrueDeathQuest_Beginning_01", "SkellyTrueDeathQuest_Beginning_01B" },
					RequiredFalseTextLines = { "SkellyTrueDeathQuestComplete" },
					Cooldowns =
					{
						{ Name = "SkellyOnDeathSpeech", Time = 20 },
					},

					-- I'm... finally... free... boyo...
					{ Cue = "/VO/Skelly_0314", },
				},
				{
					BreakIfPlayed = true,
					UsePlayerSource = true,
					PreLineWait = 1.2,

					-- SkellyTrueDeathQuestCompleteRequirements
					RequiredWeapon = "SwordWeapon",
					RequiredLastInteractedWeaponUpgrade = "SwordBaseUpgradeTrait",
					RequiredLastInteractedWeaponUpgradeMaxed = true,
					RequiredAnyTextLines = { "SkellyTrueDeathQuest_Beginning_01", "SkellyTrueDeathQuest_Beginning_01B" },
					RequiredLastInteractedWeaponUpgradeMinLevel = 5,
					RequiredFalseTextLines = { "SkellyTrueDeathQuestComplete" },

					-- Farewell, Skelly...
					{ Cue = "/VO/ZagreusHome_1407", },
				}
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				SkipAnim = true,

				{
					-- No, nooooooo!
					Cooldowns =
					{
						{ Name = "SkellyOnDeathSpeech", Time = 20 },
					},
					Cue = "/VO/Skelly_0098",
				},
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SkipAnim = true,
				Cooldowns =
				{
					{ Name = "SkellyOnDeathSpeech", Time = 20 },
				},

				-- Yep that'll do it...!
				{ Cue = "/VO/Skelly_0099", },
				-- Yeaaaah!
				{ Cue = "/VO/Skelly_0100", },
				-- Sweet release!
				{ Cue = "/VO/Skelly_0101", },
				-- AAAAAAAHH!!
				{ Cue = "/VO/Skelly_0102", },
				-- Ooh be right back...!
				{ Cue = "/VO/Skelly_0103", },
				-- Oops got to go!
				{ Cue = "/VO/Skelly_0104", },
				-- Ahhhhh...
				{ Cue = "/VO/Skelly_0105", },
				-- Ah! I am slain...!
				{ Cue = "/VO/Skelly_0592", },
				-- Niiiice....
				{ Cue = "/VO/Skelly_0593", },
				-- Aand, I'm dead.
				{ Cue = "/VO/Skelly_0594", },
				-- Farewell... boyo...
				{ Cue = "/VO/Skelly_0595", RequiredTextLines = { "SkellyTrueDeathQuestComplete" }, },
				-- Ah, my femur!
				{ Cue = "/VO/Skelly_0596", },
				-- Right in the vertebrae!
				{ Cue = "/VO/Skelly_0597", },
				-- Right in the cranium!
				{ Cue = "/VO/Skelly_0598", },
				-- Right in the pelvis, oof!
				{ Cue = "/VO/Skelly_0599", },
				-- I'm... too young... to die...
				{ Cue = "/VO/Skelly_0600", RequiredTextLines = { "SkellyTrueDeathQuestComplete" }, },
				-- I don't want to die!
				{ Cue = "/VO/Skelly_0601", RequiredTextLines = { "SkellyTrueDeathQuestComplete" }, },
			},
		},

		OnSpawnVoiceLines =
		{
			ThreadName = "RoomThread",
			{
				PlayOnce = true,
				PreLineWait = 2,
				-- Psst, over here!
				{ Cue = "/VO/Skelly_0007", },
			},
			{
				PlayOnce = true,
				UsePlayerSource = true,
				BreakIfPlayed = true,

				-- What the...?
				{ Cue = "/VO/ZagreusField_0396" },
			},
			{
				RequiredPlayedThisRoom = { "/VO/ZagreusField_1259", "/VO/ZagreusField_0153", "/VO/ZagreusField_0151", "/VO/ZagreusField_0154", },
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 3.5,
				CooldownTime = 10,

				-- Heeey nice!
				{ Cue = "/VO/Skelly_0085", },
				-- What'd you get, what'd you get?
				{ Cue = "/VO/Skelly_0086", },
				-- Get anything good?
				{ Cue = "/VO/Skelly_0087", },
				-- What is that thing?
				{ Cue = "/VO/Skelly_0088", },
				-- Hooh, you got one!
				{ Cue = "/VO/Skelly_0089", },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.9,
				RequiredFalsePlayedThisRoom = { "/VO/ZagreusField_1259", "/VO/ZagreusField_0153", "/VO/ZagreusField_0151", "/VO/ZagreusField_0154" },

				-- Hey hey!
				{ Cue = "/VO/Skelly_0008" },
				-- Hey boyo!
				{ Cue = "/VO/Skelly_0009" },
				-- Want a piece of me boyo?
				{ Cue = "/VO/Skelly_0010" },
				-- Think you can take me boyo?
				{ Cue = "/VO/Skelly_0011" },
				-- Want to fight?
				{ Cue = "/VO/Skelly_0130" },
				-- Heh-heyy!
				{ Cue = "/VO/Skelly_0131" },
				-- How's it going?
				{ Cue = "/VO/Skelly_0132" },
				-- What's up, boyo.
				{ Cue = "/VO/Skelly_0048" },
				-- Ready to go or what?
				{ Cue = "/VO/Skelly_0129" },
			},
		},

		OnRespawnVoiceLines =
		{
			ThreadName = "RoomThread",
			{
				{
					UsePlayerSource = true,
					PreLineWait = 1.6,

					-- SkellyTrueDeathQuestCompleteRequirements
					RequiredWeapon = "SwordWeapon",
					RequiredLastInteractedWeaponUpgrade = "SwordBaseUpgradeTrait",
					RequiredLastInteractedWeaponUpgradeMaxed = true,
					RequiredFalseTextLines = { "SkellyTrueDeathQuestComplete" },
					RequiredAnyTextLines = { "SkellyTrueDeathQuest_Beginning_01", "SkellyTrueDeathQuest_Beginning_01B" },
					RequiredPlayed = { "/VO/Skelly_0314" },

					-- What...
					{ Cue = "/VO/ZagreusHome_1408", },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,

					-- SkellyTrueDeathQuestCompleteRequirements
					RequiredWeapon = "SwordWeapon",
					RequiredLastInteractedWeaponUpgrade = "SwordBaseUpgradeTrait",
					RequiredLastInteractedWeaponUpgradeMaxed = true,
					RequiredAnyTextLines = { "SkellyTrueDeathQuest_Beginning_01", "SkellyTrueDeathQuest_Beginning_01B" },
					RequiredFalseTextLines = { "SkellyTrueDeathQuestComplete" },
					RequiredPlayed = { "/VO/Skelly_0314" },

					-- AH, hahahaha, whoo-hoo-hoo!
					{ Cue = "/VO/Skelly_0315", },
				},
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.8,
				CooldownTime = 5,

				-- Hah, haha, bet I got you pretty good!
				{ Cue = "/VO/Skelly_0106", RequiredPlayed = { "/VO/Skelly_0098" }, PlayOnce = true, },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.8,
				CooldownTime = 5,
				RequiredFalseTextLinesThisRoom = { "SkellyAboutSources01" },

				-- What'd I miss?
				{ Cue = "/VO/Skelly_0107" },
				-- Aand, we're back.
				{ Cue = "/VO/Skelly_0109" },
				-- All right back to work.
				{ Cue = "/VO/Skelly_0110" },
				-- Miss me, boyo?
				{ Cue = "/VO/Skelly_0111" },
				-- Heeey.
				{ Cue = "/VO/Skelly_0112" },
				-- Oh hi.
				{ Cue = "/VO/Skelly_0113" },
				-- All right I'm back!
				{ Cue = "/VO/Skelly_0114" },
				-- Anyways...
				{ Cue = "/VO/Skelly_0602" },
				-- Back in one piece!
				{ Cue = "/VO/Skelly_0603" },
				-- Good as new!
				{ Cue = "/VO/Skelly_0604" },
				-- Never felt so alive!
				{ Cue = "/VO/Skelly_0605" },
				-- Go again?
				{ Cue = "/VO/Skelly_0606" },
				-- I live again, boyo!
				{ Cue = "/VO/Skelly_0607" },
				-- <Gasp> I'm alive!!
				{ Cue = "/VO/Skelly_0608" },
				-- All that damage, that was nothing, pal!
				{ Cue = "/VO/Skelly_0609" },
			},
		},

		-- Trophy Quest
		TrophyUnlockedVoiceLines =
		{
			Queue = "Interrupt",
			{
				-- bronze unlocked
				{
					RequiredTextLines = { "TrophyQuest_Beginning_01" },
					RequiredFalseTextLines = { "TrophyQuest_BronzeUnlocked_01" },
					PlayOnce = true,
					PreLineWait = 0.6,
					Source = { SubtitleColor = Color.SkellyVoice },

					-- Hooray, you did it, pal!
					{ Cue = "/VO/Skelly_0181" },
				},
				{
					RequiredTextLines = { "TrophyQuest_Beginning_01" },
					RequiredFalseTextLines = { "TrophyQuest_BronzeUnlocked_01" },
					UsePlayerSource = true,
					PlayOnce = true,
					PreLineWait = 0.7,

					-- What'd I get?
					{ Cue = "/VO/ZagreusHome_0705" },
				},
				{
					RequiredTextLines = { "TrophyQuest_Beginning_01" },
					RequiredFalseTextLines = { "TrophyQuest_BronzeUnlocked_01" },
					PreLineWait = 1.3,
					Source = { SubtitleColor = Color.SkellyVoice },

					-- Huzzah!
					{ Cue = "/VO/Skelly_0239", },
				},
				{
					RequiredTextLines = { "TrophyQuest_Beginning_01" },
					RequiredFalseTextLines = { "TrophyQuest_BronzeUnlocked_01" },
					UsePlayerSource = true,
					BreakIfPlayed = true,
					PreLineWait = 0.3,

					-- What in blazes...
					{ Cue = "/VO/ZagreusHome_0677" },
				},
			},
			{
				-- silver unlocked
				{
					PlayOnce = true,
					RequiredTextLines = { "TrophyQuest_BronzeUnlocked_01" },
					RequiredFalseTextLines = { "TrophyQuest_SilverUnlocked_01" },
					PreLineWait = 0.6,
					Source = { SubtitleColor = Color.SkellyVoice },

					-- Oh, have I got something for you, boyo!
					{ Cue = "/VO/Skelly_0176", },
				},
				{
					UsePlayerSource = true,
					RequiredTextLines = { "TrophyQuest_BronzeUnlocked_01" },
					RequiredFalseTextLines = { "TrophyQuest_SilverUnlocked_01" },
					PlayOnce = true,
					PreLineWait = 0.4,

					-- Finally did it, what do I get?
					{ Cue = "/VO/ZagreusHome_0702" },
				},
				{
					PlayOnce = true,
					RequiredTextLines = { "TrophyQuest_BronzeUnlocked_01" },
					RequiredFalseTextLines = { "TrophyQuest_SilverUnlocked_01" },
					PreLineWait = 1.3,
					Source = { SubtitleColor = Color.SkellyVoice },

					-- Ta-daaaa!
					{ Cue = "/VO/Skelly_0242" },
				},
				{
					UsePlayerSource = true,
					PlayOnce = true,
					RequiredTextLines = { "TrophyQuest_BronzeUnlocked_01" },
					RequiredFalseTextLines = { "TrophyQuest_SilverUnlocked_01" },
					PreLineWait = 0.5,

					-- Another Skelly statue. Why am I not surprised.
					{ Cue = "/VO/ZagreusHome_0680" },
				},
				{
					PlayOnce = true,
					RequiredTextLines = { "TrophyQuest_BronzeUnlocked_01" },
					RequiredFalseTextLines = { "TrophyQuest_SilverUnlocked_01" },
					PreLineWait = 0.4,
					BreakIfPlayed = true,
					Source = { SubtitleColor = Color.SkellyVoice },

					-- Because, pal, you are a discerning individual!
					{ Cue = "/VO/Skelly_0187" },
				},
			},
			{
				-- gold unlocked
				{
					PlayOnce = true,
					RequiredTextLines = { "TrophyQuest_SilverUnlocked_01" },
					PreLineWait = 0.6,
					Source = { SubtitleColor = Color.SkellyVoice },

					-- Oh no...
					{ Cue = "/VO/Skelly_0190" },
				},
				{
					UsePlayerSource = true,
					RequiredTextLines = { "TrophyQuest_SilverUnlocked_01" },
					PlayOnce = true,
					PreLineWait = 0.4,

					-- I have a feeling I know what this is...
					{ Cue = "/VO/ZagreusHome_0704" },
				},
				{
					PlayOnce = true,
					RequiredTextLines = { "TrophyQuest_SilverUnlocked_01" },
					PreLineWait = 0.6,
					Source = { SubtitleColor = Color.SkellyVoice },

					-- Heh!
					{ Cue = "/VO/Skelly_0025" },
				},
				{
					PlayOnce = true,
					UsePlayerSource = true,
					RequiredTextLines = { "TrophyQuest_SilverUnlocked_01" },
					PreLineWait = 0.8,

					-- It's another statue of you, Skelly.
					{ Cue = "/VO/ZagreusHome_0684" },
					-- ...It's amazing!!
					{ Cue = "/VO/ZagreusHome_0685", PreLineWait = 1.4 },
				},
				{
					PlayOnce = true,
					RequiredTextLines = { "TrophyQuest_SilverUnlocked_01" },
					PreLineWait = 1.0,
					BreakIfPlayed = true,
					Source = { SubtitleColor = Color.SkellyVoice },

					-- ...What... you really mean that, pal?
					{ Cue = "/VO/Skelly_0192" },
				},
			},
		},

		TrophyLockedNotEnoughHeatVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 3.25,
			CooldownTime = 8,

			-- Go fill out that form you got.
			{ Cue = "/VO/Skelly_0227" },
			-- I don't make the rules, pal.
			{ Cue = "/VO/Skelly_0228" },
			-- Got to sign up for this contest.
			{ Cue = "/VO/Skelly_0229" },
			-- Go on, I dare you!
			{ Cue = "/VO/Skelly_0230" },
			-- Do you have the guts?
			{ Cue = "/VO/Skelly_0231" },
			-- Go on...
			{ Cue = "/VO/Skelly_0232" },
			-- It's an amazing prize, boyo!
			{ Cue = "/VO/Skelly_0236" },
			-- Come on, pal, live a little!
			{ Cue = "/VO/Skelly_0237" },
		},
		TrophyLockedEnoughHeatVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 3.25,
			CooldownTime = 8,

			-- Uh-uh-uh!
			{ Cue = "/VO/Skelly_0233" },
			-- Gotta earn it, pal!
			{ Cue = "/VO/Skelly_0234" },
			-- Think you got what it takes?!
			{ Cue = "/VO/Skelly_0235" },
			-- It's an amazing prize, boyo!
			{ Cue = "/VO/Skelly_0236" },
			-- Come on, pal, live a little!
			{ Cue = "/VO/Skelly_0237" },
			-- Nuh-uh, you gotta work for it!
			{ Cue = "/VO/Skelly_0238" },
			-- Go on...
			{ Cue = "/VO/Skelly_0232" },
			-- I don't make the rules, pal.
			{ Cue = "/VO/Skelly_0228" },
			-- Go on, I dare you!
			{ Cue = "/VO/Skelly_0230" },
		},

		TrophyAttackReactionVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.33,
			CooldownTime = 6,
			RequiredTextLines = { "TrophyQuest_BronzeUnlocked_01" },

			-- Whoa don't you touch that thing!
			{ Cue = "/VO/Skelly_0212" },
			-- That is a priceless work of art there pal!
			{ Cue = "/VO/Skelly_0213" },
			-- Hey, don't you scratch that thing, boyo!
			{ Cue = "/VO/Skelly_0214" },
			-- You're killing me pal.
			{ Cue = "/VO/Skelly_0215" },
			-- No, not the statue, please!
			{ Cue = "/VO/Skelly_0216", RequiredTextLines = { "TrophyQuest_GoldUnlocked_01" }, },
			-- Don't do it!
			{ Cue = "/VO/Skelly_0217" },
			-- No, stop!
			{ Cue = "/VO/Skelly_0218" },
			-- Please pal.
			{ Cue = "/VO/Skelly_0219" },
			-- Aw you are cruel.
			{ Cue = "/VO/Skelly_0220" },
			-- Hey watch the statues!
			{ Cue = "/VO/Skelly_0221", RequiredTextLines = { "TrophyQuest_GoldUnlocked_01" }, },
			-- Whoa whoa whoa!
			{ Cue = "/VO/Skelly_0222" },
			-- Hey watch it!
			{ Cue = "/VO/Skelly_0223" },
			-- Don't hit those!
			{ Cue = "/VO/Skelly_0224" },
			-- Whoa careful pal!
			{ Cue = "/VO/Skelly_0225" },
			-- Hey stop it!
			{ Cue = "/VO/Skelly_0226" },
		},

		-- FYI Skelly's Binks are currently called *_Skeleton_*, whereas the normal skeleton/bloodless enemies are *_Skelly_*
		Binks =
		{
			"Enemy_Skeleton_OnHit_Bink",
			"Enemy_Skeleton_Attack_Bink",
			"Enemy_Skeleton_Dead_Bink",
		},
	},

	TrainingMeleeSummon =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "TrainingMelee",
		RequiredKill = false,
		DropItemsOnDeath = false,
		UseShrineUpgrades = false,
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedSkeleton",
			Rapid = "HitSparkEnemyDamagedSkeletonRapid",
		},
		MaxHealth = 300,
		HealthBarOffsetY = -170,
		HealthBarType = "MediumLarge",
		SkipDamageText = false,
		AnimOffsetZ = 200,
		UnuseableWhenDead = true,
		SpeechCooldownTime = 9,
		SkipModifiers = true,
		IncomingDamageModifiers =
		{
			{
				Name = "Innate",
				PlayerMultiplier = 0.05,
			}
		},
		Groups = { "GroundEnemies", "TrainingEnemies" },

		DamagedAnimation = "EnemySkeletonOnHit",
		Material = "Bone",

		MeterMultiplier = 0,

		ActivateRequirements =
		{
			RequiredTrueFlags = { "SkellyUnlocked" },
		},

		-- was: OnSpawnVoiceLines (these play after the activation is complete, not at the start)
		OnActivationFinishedVoiceLines  =
		{
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.3,
					PostLineWait = 9.0,
					RequiredTrait = "SkellyAssistTrait",
					RequiredRooms = { "A_Boss01", "A_Boss02", "A_Boss03" },
					SuccessiveChanceToPlayAll = 0.2,

					-- Hey, hey, what's going on?
					{ Cue = "/VO/Skelly_0360" },
					-- Hey, hey, what's going on?
					{ Cue = "/VO/Skelly_0550" },
					-- Heya lady!
					{ Cue = "/VO/Skelly_0551", RequiredInactiveMetaUpgrade = "BossDifficultyShrineUpgrade" },
					-- You keep that whip away from my pal!
					{ Cue = "/VO/Skelly_0552" },
					-- So, what's going on between you two?	
					{ Cue = "/VO/Skelly_0553", RequiredTextLines = { "MegaeraGift10" }, RequiredRooms = { "A_Boss01" }, RequiredInactiveMetaUpgrade = "BossDifficultyShrineUpgrade" },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.3,
					PostLineWait = 9.0,
					RequiredTrait = "SkellyAssistTrait",
					RequiredRooms = { "B_Boss01", "B_Boss02" },
					SuccessiveChanceToPlayAll = 0.2,

					-- Look at the size of that thing!
					{ Cue = "/VO/Skelly_0361" },
					-- Hey you big lug, over here!
					{ Cue = "/VO/Skelly_0554", RequiredPlayed = { "/VO/Skelly_0361" }, },
					-- Hey Big-Bones, want some of this?!
					{ Cue = "/VO/Skelly_0555", RequiredPlayed = { "/VO/Skelly_0361" }, },
					-- Why'd you drag me into this one, pal?!
					{ Cue = "/VO/Skelly_0556", RequiredPlayed = { "/VO/Skelly_0361" }, },
					-- Nice bone structure on that thing over there!
					{ Cue = "/VO/Skelly_0557", RequiredPlayed = { "/VO/Skelly_0361" }, },					
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.3,
					PostLineWait = 9.0,
					RequiredTrait = "SkellyAssistTrait",
					RequiredRooms = { "C_MiniBoss01" },
					SuccessiveChanceToPlayAll = 0.2,

					-- Hey toughguy, over here!
					{ Cue = "/VO/Skelly_0362" },
					-- Hey, bull boy, what's the matter?
					{ Cue = "/VO/Skelly_0558" },
					-- Ooh, help, he's got a double bladed axe!
					{ Cue = "/VO/Skelly_0559" },
					-- Charge into this, bull boy!
					{ Cue = "/VO/Skelly_0560" },
					-- Remember me, bull boy?!
					{ Cue = "/VO/Skelly_0561", RequiredTextLines = { "SkellyBackstory05" }, },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.3,
					PostLineWait = 9.0,
					RequiredTrait = "SkellyAssistTrait",
					RequiredRooms = { "C_Boss01" },
					RequiredAnyUnitAlive = { "Theseus", "Theseus2" },
					SuccessiveChanceToPlayAll = 0.2,

					-- Wha, is that Theseus?!
					{ Cue = "/VO/Skelly_0363" },
					-- The king of Athens, I'm so scared, boyo!
					{ Cue = "/VO/Skelly_0562", RequiredPlayed = { "/VO/Skelly_0363" } },
					-- And the crowd goes nuts!
					{ Cue = "/VO/Skelly_0563", RequiredPlayed = { "/VO/Skelly_0363" } },
					-- This one's for you guys out in the cheap seats!
					{ Cue = "/VO/Skelly_0564", RequiredPlayed = { "/VO/Skelly_0363" } },
					-- Looks like I made it for the big event!
					{ Cue = "/VO/Skelly_0565", RequiredPlayed = { "/VO/Skelly_0363" } },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.3,
					PostLineWait = 9.0,
					RequiredTrait = "SkellyAssistTrait",
					RequiredEncounters = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro" },
					SuccessiveChanceToPlayAll = 0.2,

					-- Hey Thanatos, big fan right here!
					{ Cue = "/VO/Skelly_0364", RequiredPlayed = { "/VO/Skelly_0566", "/VO/Skelly_0568" } },
					-- Hey Thanatos, big fan right here!
					{ Cue = "/VO/Skelly_0566" },
					-- Whoa hey, it's Thanatos!
					{ Cue = "/VO/Skelly_0567", RequiredPlayed = { "/VO/Skelly_0566" } },
					-- Ooh it's that Thanatos!
					{ Cue = "/VO/Skelly_0568", RequiredPlayed = { "/VO/Skelly_0566" } },
					-- Don't kill me, Thanatos!
					{ Cue = "/VO/Skelly_0569", RequiredPlayed = { "/VO/Skelly_0566" } },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.3,
					PostLineWait = 9.0,
					RequiredTrait = "SkellyAssistTrait",
					RequiredRooms = { "D_Boss01" },
					SuccessiveChanceToPlay = 0.2,

					-- Uh, hey, uh... hey!
					{ Cue = "/VO/Skelly_0365" },
					-- Uh, must have taken a wrong turn somewhere!
					{ Cue = "/VO/Skelly_0570", RequiredPlayed = { "/VO/Skelly_0365" }, },
					-- Hey, what you doing all the way up here?
					{ Cue = "/VO/Skelly_0571", RequiredPlayed = { "/VO/Skelly_0365" }, },
					-- Whoa it's Papa, you're in trouble, pal!
					{ Cue = "/VO/Skelly_0572", RequiredPlayed = { "/VO/Skelly_0365" }, },
					-- Think this one's between you and Papa, pal!
					{ Cue = "/VO/Skelly_0573", RequiredPlayed = { "/VO/Skelly_0365" }, },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.3,
					PostLineWait = 9.0,
					RequiredTrait = "SkellyAssistTrait",
					RequiresUsedAssistLastRoom = true,
					SuccessiveChanceToPlay = 0.2,

					-- Need my services again, boyo?
					{ Cue = "/VO/Skelly_0366" },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.3,
					PostLineWait = 9.0,
					RequiredTrait = "SkellyAssistTrait",
					RequiresInRun = true,

					-- What's all this riff-raff?
					{ Cue = "/VO/Skelly_0321" },
					-- These bozos causing problems, pal?
					{ Cue = "/VO/Skelly_0323" },
					-- Nobody messes with my pal!
					{ Cue = "/VO/Skelly_0324" },
					-- Hey how's everybody doing?
					{ Cue = "/VO/Skelly_0325" },
					-- Waaaaaaaa I'm an important target!!
					{ Cue = "/VO/Skelly_0326" },
					-- Whoever kills me gets a big promotion!
					{ Cue = "/VO/Skelly_0327" },
					-- Ah boyo this place is a mess!
					{ Cue = "/VO/Skelly_0328" },
					-- Whoa nice place to stand around!
					{ Cue = "/VO/Skelly_0329" },
					-- Got here just as soon as I was able, pal!
					{ Cue = "/VO/Skelly_0330" },
					-- I shall protect you, pal!
					{ Cue = "/VO/Skelly_0331" },
					-- Hah what a bunch of bozos!!
					{ Cue = "/VO/Skelly_0332" },
					-- What'd I miss, anything good?
					{ Cue = "/VO/Skelly_0335" },
					-- It's standing doing nothing time!
					{ Cue = "/VO/Skelly_0336" },
					-- Whoa it is hot in here!
					{ Cue = "/VO/Skelly_0387", RequiredBiome = "Asphodel" },
					-- Hey look at all that magma!
					{ Cue = "/VO/Skelly_0388", RequiredBiome = "Asphodel" },
					-- This place is pretty nice!
					{ Cue = "/VO/Skelly_0389", RequiredBiome = "Elysium" },
					-- Whoa, look at all of this!
					{ Cue = "/VO/Skelly_0390", RequiredBiome = "Elysium" },
					-- Hey real fancy place!
					{ Cue = "/VO/Skelly_0391", RequiredBiome = "Elysium" },
					-- Whoa this place is a dump!
					{ Cue = "/VO/Skelly_0392", RequiredBiome = "Styx" },
					-- The air feels weird up here!
					{ Cue = "/VO/Skelly_0393", RequiredBiome = "Styx" },
				},
			},
			[2] = GlobalVoiceLines.SkellySummonTauntVoiceLines,
			[3] = GlobalVoiceLines.SkellySummonTauntVoiceLines,
			[4] = GlobalVoiceLines.SkellySummonTauntVoiceLines,
			[5] = GlobalVoiceLines.SkellySummonTauntVoiceLines,
			[6] = GlobalVoiceLines.SkellySummonTauntVoiceLines,
			[7] = GlobalVoiceLines.SkellySummonTauntVoiceLines,
			[8] = GlobalVoiceLines.SkellySummonTauntVoiceLines,
			[9] = GlobalVoiceLines.SkellySummonTauntVoiceLines,
			[10] = GlobalVoiceLines.SkellySummonTauntVoiceLines,
		},
		OnDeathVoiceLines =
		{
			Queue = "Interrupt",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				CooldownTime = 5,
				SkipAnim = true,
				RequiresInRun = true,
				Cooldowns =
				{
					{ Name = "SkellyOnDeathSpeech", Time = 20 },
				},

				-- Ah dang it!
				{ Cue = "/VO/Skelly_0342" },
				-- Ah dang!
				{ Cue = "/VO/Skelly_0343" },
				-- Aack!
				{ Cue = "/VO/Skelly_0344" },
				-- Whaa?
				{ Cue = "/VO/Skelly_0345" },
				-- Blarrgh!
				{ Cue = "/VO/Skelly_0346" },
				-- I'm done for!
				{ Cue = "/VO/Skelly_0347", RequiredKillEnemiesFound = true, },
				-- I'm out!
				{ Cue = "/VO/Skelly_0348" },
				-- Uh, pal?!
				{ Cue = "/VO/Skelly_0349" },
				-- AAAAAAAHH!!
				{ Cue = "/VO/Skelly_0102", },
				-- Oops got to go!
				{ Cue = "/VO/Skelly_0104", },
				-- Dang got to go!
				{ Cue = "/VO/Skelly_0434", },
				-- I can't hold out boyo!
				{ Cue = "/VO/Skelly_0435", RequiredKillEnemiesFound = true, },
				-- Avenge me, pal!!
				{ Cue = "/VO/Skelly_0436", RequiredKillEnemiesFound = true, },
				-- You got this, boyo, go...!
				{ Cue = "/VO/Skelly_0437", RequiredKillEnemiesFound = true, },
				-- You bozos going to pay!
				{ Cue = "/VO/Skelly_0438", RequiredMinKillEnemies = 2 },
				-- I swear I'll be avenged!!
				{ Cue = "/VO/Skelly_0439", RequiredKillEnemiesFound = true, },
				-- You haven't seen the last of me!!
				{ Cue = "/VO/Skelly_0440", RequiredKillEnemiesFound = true, },
				-- Ack, lucky shot!
				{ Cue = "/VO/Skelly_0441", RequiredKillEnemiesFound = true, },
				-- Oof all right I'm out!
				{ Cue = "/VO/Skelly_0442" },
				-- Ah! I am slain...!
				{ Cue = "/VO/Skelly_0592" },
				-- Aand, I'm dead.
				{ Cue = "/VO/Skelly_0594" },
				-- Farewell... boyo...
				{ Cue = "/VO/Skelly_0595", RequiredTextLines = { "SkellyTrueDeathQuestComplete" } },
				-- I'm... too young... to die...
				{ Cue = "/VO/Skelly_0600", RequiredTextLines = { "SkellyTrueDeathQuestComplete" } },
				-- I don't want to die!
				{ Cue = "/VO/Skelly_0601" },
			},
		},

		WeaponOptions =
		{
			"HeavyMelee",
		},

		AIOptions =
		{
			TrainingAI,
		},
		AITetherToSpawnLocation = true,
		AITetherDistance = 0,

		MoneyDropOnDeath =
		{
			Chance = 0,
		},
	},

	SimpleMelee =
	{
		InheritFrom = { "HeavyMelee" },
		AggroIfLastAlive = false,

		PreferredSpawnPoint = "EnemyPointMelee",

		AIMoveWithinRangeTimeout = 5.0,
		AIWanderDistance = 0,
		AIAggroRange = 800,
		AggroReactionTime = 0,
		WeaponOptions =
		{
			"HeavyMelee",
		},
	},

	HarpySupportUnit =
	{
		InheritFrom = { "IsNeutral" },
		DamageType = "Enemy",
		RequiredKill = false,
		HideHealthBar = true,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		AIOptions =
		{
			HarpySupportAI,
		},

		SupportAIWeaponOptions = { Megaera = {}, Alecto = {}, Tisiphone = {} },
		AttackRateMin = 5.0,
		AttackRateMax = 6.5,
		WakeUpDelayMin = 4,
		WakeUpDelayMax = 6,
	},

	-- Bosses
	-- Megaera
	Harpy =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		Portrait = "Portrait_FurySister01_Default_01",
		Groups = { "NPCs" },
		AnimOffsetZ = 260,
		MaxHealth = 4400,
		AISetupDelay = 1.5,
		EmoteOffsetX = 0,
		EmoteOffsetY = -220,

		ShrineDataOverwrites =
		{
			MaxHealth = 4800,
		},

		SpeechCooldownTime = 11,

		Groups = { "GroundEnemies", "FlyingEnemies" },
		OnDeathFunctionName = "HarpyKillPresentation",
		OnDeathFunctionArgs = { Message = "HarpyDefeatedMessage", BossDifficultyMessage = "HarpiesDefeatedMessage", CameraPanTime = 1.5, StartSound = "/Leftovers/Menu Sounds/EmoteShocked", BatsAfterDeath = true, FlashRed = true, AddInterBiomeTimerBlock = true },
		DeathAnimation = "FuryDead",
		FightStartGlobalVoiceLines = "MultiFuryFightStartVoiceLines",
		ClearChillOnDeath = true,

		Material = "Organic",
		HealthBarOffsetY = -275,
		--RepulseOnMeleeInvulnerableHit = 400,
		IgnoreInvincibubbleOnHit = true,

		AdditionalEnemySetupFunctionName = "SelectHarpySupportAIs",

		DefaultAIData =
		{

		},
		WeaponOptions = { "HarpyLunge", "HarpyWhipWhirl" },
		DisarmedWeapon = "HarpyLunge",

		ShrineMetaUpgradeName = "BossDifficultyShrineUpgrade",
		SupportAIWeaponSetOptions = { "Tisiphone", "Alecto" },
		SupportUnitName = "HarpySupportUnit",

		SpawnOptions =
		{
			"HeavyMelee",
			"LightRanged",
		},

		AIEndHealthThreshold = 0.75,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },

				AddSupportAIWeaponOptions =
				{
					-- Tisiphone
					Tisiphone = {
						"SummonTisiphoneBombingRun"
					},
					-- Alecto
					Alecto = {
						"SummonAlectoWhipShot"
					},
				},

				AIData =
				{
					AIEndHealthThreshold = 0.75,
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EquipRandomWeapon = { "HarpyLightning", "HarpyBeam" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "FuryShieldedStart",

				AIData =
				{
					AIEndHealthThreshold = 0.50,
				},

				StageTransitionVoiceLines =
				{
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						PreLineWait = 0.75,
						CooldownTime = 20,
						CooldownName = "MegSpokeRecently",
						RequiredFalseTextLines = { "MegaeraGift10" },
						SuccessiveChanceToPlay = 0.33,

						-- We're not finished yet.
						{ Cue = "/VO/MegaeraField_0113" },
						-- We're only getting started.
						{ Cue = "/VO/MegaeraField_0114" },
						-- I'll make you suffer.
						{ Cue = "/VO/MegaeraField_0116" },
						-- Best not get overconfident.
						{ Cue = "/VO/MegaeraField_0118" },
						-- You've got a lot of nerve.
						{ Cue = "/VO/MegaeraField_0122" },
						-- I don't think so.
						{ Cue = "/VO/MegaeraField_0276" },
						-- You're weak, Zag.
						{ Cue = "/VO/MegaeraField_0277", ConsecutiveDeathsInRoom = { Name = "A_Boss01", Count = 2, }, },
						-- Weak.
						{ Cue = "/VO/MegaeraField_0278", ConsecutiveDeathsInRoom = { Name = "A_Boss01", Count = 1, }, },
						-- Not a chance.
						{ Cue = "/VO/MegaeraField_0279", ConsecutiveDeathsInRoom = { Name = "A_Boss01", Count = 2, }, },
						-- I think not.
						{ Cue = "/VO/MegaeraField_0280" },
						-- Fool.
						{ Cue = "/VO/MegaeraField_0281" },
						-- Pshh.
						{ Cue = "/VO/MegaeraField_0282" },
						-- You can't hurt me.
						{ Cue = "/VO/MegaeraField_0283" },
					},
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						PreLineWait = 0.75,
						CooldownTime = 20,
						CooldownName = "MegSpokeRecently",
						RequiredTextLines = { "MegaeraGift10" },
						SuccessiveChanceToPlay = 0.33,

						-- That's it.
						{ Cue = "/VO/MegaeraField_0290" },
						-- All right.
						{ Cue = "/VO/MegaeraField_0291" },
						-- Don't you dare hold back.
						{ Cue = "/VO/MegaeraField_0652" },
						-- Now we're getting somewhere.
						{ Cue = "/VO/MegaeraField_0653" },
						-- Think you can keep this up?
						{ Cue = "/VO/MegaeraField_0649" },
						-- We aren't finished here.
						{ Cue = "/VO/MegaeraField_0655" },
						-- You haven't got me yet.
						{ Cue = "/VO/MegaeraField_0656" },
						-- I think not.
						{ Cue = "/VO/MegaeraField_0280" },
						-- Pshh.
						{ Cue = "/VO/MegaeraField_0282" },
						-- You can't hurt me.
						{ Cue = "/VO/MegaeraField_0283" },
						-- I don't think so.
						{ Cue = "/VO/MegaeraField_0276" },
						-- No.
						{ Cue = "/VO/MegaeraField_0780" },
						-- I don't think so.
						{ Cue = "/VO/MegaeraField_0781" },
					},
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EquipRandomWeapon = { "HarpySpawns" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "FuryShieldedStart",
				--CombatText = "PoweredUp",

				AddSupportAIWeaponOptions =
				{
					-- Tisiphone
					Tisiphone = {
						"SummonTisiphoneFog"
					},
					-- Alecto
					Alecto = {
						"SummonAlectoLightningChase"
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.25,
				},

				StageTransitionVoiceLines =
				{
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						PreLineWait = 0.75,
						SuccessiveChanceToPlay = 0.75,
						CooldownTime = 12,
						CooldownName = "MegSpokeRecently",

						-- Wretches of Tartarus, to me!
						{ Cue = "/VO/MegaeraField_0106" },
						-- Wretches of the Underworld, to me!
						{ Cue = "/VO/MegaeraField_0107" },
						-- Hear me, on my authority!
						{ Cue = "/VO/MegaeraField_0108" },
						-- In the name of Hades!
						{ Cue = "/VO/MegaeraField_0109" },
						-- Hear me, you wretched shades!
						{ Cue = "/VO/MegaeraField_0110" },
						-- I need some backup, now!
						{ Cue = "/VO/MegaeraField_0111" },
						-- Let's see you handle this!
						{ Cue = "/VO/MegaeraField_0112" },
						-- I need backup, now!
						{ Cue = "/VO/MegaeraField_0284" },
						-- Come, wretches!
						{ Cue = "/VO/MegaeraField_0285" },
						-- Requesting backup, damn it!
						{ Cue = "/VO/MegaeraField_0286" },
						-- Come and kill him, wretches!
						{ Cue = "/VO/MegaeraField_0287" },
						-- Wretches, bring him down!
						{ Cue = "/VO/MegaeraField_0288" },
						-- Meet some of my friends.
						{ Cue = "/VO/MegaeraField_0289" },
						-- Wretches of Tartarus, I summon you!
						{ Cue = "/VO/MegaeraField_0642" },
						-- Hear me, Wretches, and come fight with me!
						{ Cue = "/VO/MegaeraField_0643" },
						-- Back me up, Wretches of Tartarus, right now!
						{ Cue = "/VO/MegaeraField_0644" },
						-- All right, you wretched shades, appear!
						{ Cue = "/VO/MegaeraField_0645" },
						-- Hope you don't mind if I invited a few friends?
						{ Cue = "/VO/MegaeraField_0646", RequiredTextLines = { "MegaeraGift10" } },
						-- Requesting immediate assistance!
						{ Cue = "/VO/MegaeraField_0647" },
						-- Requesting backup, Tartarus entryway!
						{ Cue = "/VO/MegaeraField_0648" },
						-- Requesting backup, now!
						{ Cue = "/VO/MegaeraField_0782" },
						-- Wretches of Tartarus, come in!
						{ Cue = "/VO/MegaeraField_0783" },
						-- Requesting backup!
						{ Cue = "/VO/MegaeraField_0784" },
						-- Come, Wretches!
						{ Cue = "/VO/MegaeraField_0785" },
						-- Come, Wretches! On my authority!
						{ Cue = "/VO/MegaeraField_0786" },
						-- Wretches, now!
						{ Cue = "/VO/MegaeraField_0787" },
						-- Here, Wretches!
						{ Cue = "/VO/MegaeraField_0788" },
					},

				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EquipRandomWeapon = { "HarpyLightning", "HarpyBeam" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "FuryShieldedStart",
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				StageTransitionVoiceLines =
				{
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						PreLineWait = 0.75,
						CooldownTime = 12,
						SuccessiveChanceToPlay = 0.33,
						CooldownName = "MegSpokeRecently",
						RequiredFalseTextLines = { "MegaeraGift10" },

						-- You're going to pay for this.
						{ Cue = "/VO/MegaeraField_0115" },
						-- I am not finished yet.
						{ Cue = "/VO/MegaeraField_0117" },
						-- This isn't over yet.
						{ Cue = "/VO/MegaeraField_0119" },
						-- I will not let you win.
						{ Cue = "/VO/MegaeraField_0120" },
						-- You haven't beat me yet.
						{ Cue = "/VO/MegaeraField_0121" },
						-- That's it.
						{ Cue = "/VO/MegaeraField_0290" },
						-- All right.
						{ Cue = "/VO/MegaeraField_0291" },
						-- Let's end this.
						{ Cue = "/VO/MegaeraField_0292" },
						-- This ends here.
						{ Cue = "/VO/MegaeraField_0293" },
						-- I'm not through with you yet.
						{ Cue = "/VO/MegaeraField_0294" },
						-- Enough of this.
						{ Cue = "/VO/MegaeraField_0295" },
						-- We aren't finished here.
						{ Cue = "/VO/MegaeraField_0655" },
						-- You haven't got me yet.
						{ Cue = "/VO/MegaeraField_0656" },
					},
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						PreLineWait = 0.75,
						CooldownTime = 12,
						SuccessiveChanceToPlay = 0.2,
						CooldownName = "MegSpokeRecently",
						RequiredTextLines = { "MegaeraGift10" },

						-- This isn't over yet.
						{ Cue = "/VO/MegaeraField_0119" },
						-- That's it.
						{ Cue = "/VO/MegaeraField_0290" },
						-- All right.
						{ Cue = "/VO/MegaeraField_0291" },
						-- Let's end this.
						{ Cue = "/VO/MegaeraField_0292" },
						-- This ends here.
						{ Cue = "/VO/MegaeraField_0293" },
						-- I'm not through with you yet.
						{ Cue = "/VO/MegaeraField_0294" },
						-- I'm not finished with you yet.
						{ Cue = "/VO/MegaeraField_0650" },
						-- You've gotten stronger, Zag.
						{ Cue = "/VO/MegaeraField_0651" },
						-- You used to be a total pushover.
						{ Cue = "/VO/MegaeraField_0654" },
						-- How did you get this tough.
						{ Cue = "/VO/MegaeraField_0657" },
						-- Enough, let's finish this.
						{ Cue = "/VO/MegaeraField_0658" },
					},
				},
			},
		},

		PlayerInjuredVoiceLineThreshold = 0.75,
		PlayerInjuredVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.75,
			SuccessiveChanceToPlay = 0.25,
			CooldownTime = 120,
			CooldownName = "MegSpokeRecently",

			-- Go home, Zagreus.
			{ Cue = "/VO/MegaeraField_0123" },
			-- That's what you get.
			{ Cue = "/VO/MegaeraField_0124" },
			-- Hah! Idiot.
			{ Cue = "/VO/MegaeraField_0125", RequiredFalseTextLines = { "MegaeraGift10" } },
			-- To hell with you.
			{ Cue = "/VO/MegaeraField_0130", RequiredFalseTextLines = { "MegaeraGift10" } },
			-- Get the hell out of here.
			{ Cue = "/VO/MegaeraField_0131", RequiredFalseTextLines = { "MegaeraGift10" } },
			-- You stupid little fool.
			-- { Cue = "/VO/MegaeraField_0132" },
			-- <Laughter>
			{ Cue = "/VO/MegaeraField_0134" },
			-- <Laughter>
			{ Cue = "/VO/MegaeraField_0135" },
			-- <Laughter>
			{ Cue = "/VO/MegaeraField_0136" },
			-- I'll show you pain.
			{ Cue = "/VO/MegaeraField_0268" },
			-- How did that feel?
			{ Cue = "/VO/MegaeraField_0269" },
			-- There.
			{ Cue = "/VO/MegaeraField_0270" },
			-- That was nothing.
			{ Cue = "/VO/MegaeraField_0271" },
			-- For last time.
			{ Cue = "/VO/MegaeraField_0272", ConsecutiveClearsOfRoom = { Name = "A_Boss01", Count = 1 }, },
			-- I'll make you scream.
			{ Cue = "/VO/MegaeraField_0273" },
			-- I'll hurt you worse than that.
			{ Cue = "/VO/MegaeraField_0274" },
			-- I feel your pain.
			{ Cue = "/VO/MegaeraField_0275" },
			-- Feel that?
			{ Cue = "/VO/MegaeraField_0774", RequiredTextLines = { "MegaeraGift10" } },
			-- Like that?
			{ Cue = "/VO/MegaeraField_0775", RequiredTextLines = { "MegaeraGift10" } },
			-- Want more?
			{ Cue = "/VO/MegaeraField_0776", RequiredTextLines = { "MegaeraGift10" } },
			-- That's it.
			{ Cue = "/VO/MegaeraField_0777", RequiredTextLines = { "MegaeraGift10" } },
			-- Hmm.
			{ Cue = "/VO/MegaeraField_0778", RequiredTextLines = { "MegaeraGift10" } },
			-- Hah!
			{ Cue = "/VO/MegaeraField_0779" },

		},
		LastStandReactionVoiceLineMinHealthThreshold = 0.25,
		LastStandReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.7,
			CooldownTime = 30,
			Queue = "Always",

			-- I'll get you yet.
			{ Cue = "/VO/MegaeraField_0218" },
			-- Die already.
			{ Cue = "/VO/MegaeraField_0219" },
			-- You lived through that?
			{ Cue = "/VO/MegaeraField_0220" },
			-- Die!
			{ Cue = "/VO/MegaeraField_0221" },
			-- Die, damn you.
			{ Cue = "/VO/MegaeraField_0222" },
			-- Cute.
			{ Cue = "/VO/MegaeraField_0223" },
			-- You're bleeding, Zagreus.
			{ Cue = "/VO/MegaeraField_0224" },
			-- You can't hold out forever.
			{ Cue = "/VO/MegaeraField_0225" },
			-- You're going home.
			{ Cue = "/VO/MegaeraField_0226" },
			-- Give up.
			{ Cue = "/VO/MegaeraField_0227" },
			-- Give up already.
			{ Cue = "/VO/MegaeraField_0228" },
			-- You're dead.
			{ Cue = "/VO/MegaeraField_0229" },
			-- You're mine.
			{ Cue = "/VO/MegaeraField_0230" },
			-- I know Nyx is helping you.
			{ Cue = "/VO/MegaeraField_0231" },
			-- You cheating little...
			{ Cue = "/VO/MegaeraField_0232" },
			-- You're running out of chances, Zagreus.
			{ Cue = "/VO/MegaeraField_0233" },
			-- You'll get what you deserve.
			{ Cue = "/VO/MegaeraField_0234" },
			-- Got you for once.
			{ Cue = "/VO/MegaeraField_0235", ConsecutiveClearsOfRoom = { Name = "A_Boss01", Count = 3 }, },
			-- I hope that hurt.
			{ Cue = "/VO/MegaeraField_0236", ConsecutiveClearsOfRoom = { Name = "A_Boss01", Count = 2 }, },
			-- You and your dirty tricks.
			{ Cue = "/VO/MegaeraField_0237", ConsecutiveClearsOfRoom = { Name = "A_Boss01", Count = 2 }, },
			-- Hah!
			{ Cue = "/VO/MegaeraField_0238", ConsecutiveClearsOfRoom = { Name = "A_Boss01", Count = 2 }, },
			-- I can beat you.
			{ Cue = "/VO/MegaeraField_0239", ConsecutiveClearsOfRoom = { Name = "A_Boss01", Count = 2 }, },
			-- Slowed you down, have I?
			{ Cue = "/VO/MegaeraField_0240", ConsecutiveClearsOfRoom = { Name = "A_Boss01", Count = 3 }, },
			-- Give Hades my regards.
			{ Cue = "/VO/MegaeraField_0128" },
		},
		WrathReactionVoiceLines =
		{
			Queue = "Interrupt",
			{
				RandomRemaining = true,
				PreLineWait = 1,
				PlayOnceFromTableThisRun = true,
				SuccessiveChanceToPlay = 0.5,

				-- What--?
				{ Cue = "/VO/MegaeraField_0398", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- What...!
				{ Cue = "/VO/MegaeraField_0399", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- Zagreus...
				{ Cue = "/VO/MegaeraField_0400", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- Come then.
				{ Cue = "/VO/MegaeraField_0401", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- Do your worst.
				{ Cue = "/VO/MegaeraField_0402", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- How...?
				{ Cue = "/VO/MegaeraField_0403", RequiredPlayed = { "/VO/MegaeraField_0409" }, RequiredFalseTextLines = { "MegaeraGift07" } },
				-- How...
				{ Cue = "/VO/MegaeraField_0404", RequiredPlayed = { "/VO/MegaeraField_0409" }, RequiredFalseTextLines = { "MegaeraGift07" } },
				-- What is this.
				{ Cue = "/VO/MegaeraField_0405", RequiredPlayed = { "/VO/MegaeraField_0409" }, RequiredFalseTextLines = { "MegaeraGift07" } },
				-- What's gotten into you.
				{ Cue = "/VO/MegaeraField_0406", RequiredPlayed = { "/VO/MegaeraField_0409" }, RequiredFalseTextLines = { "MegaeraGift07" } },
				-- So...
				{ Cue = "/VO/MegaeraField_0407", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- How did you--?
				{ Cue = "/VO/MegaeraField_0408", RequiredPlayed = { "/VO/MegaeraField_0409" }, RequiredFalseTextLines = { "MegaeraGift07" } },
				-- How did you...!
				{ Cue = "/VO/MegaeraField_0409" },
				-- This again.
				{ Cue = "/VO/MegaeraField_0410", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- You're angry.
				{ Cue = "/VO/MegaeraField_0411", RequiredPlayed = { "/VO/MegaeraField_0409" }, RequiredFalseTextLines = { "MegaeraGift07" } },
				-- You have no self control.
				{ Cue = "/VO/MegaeraField_0412", RequiredPlayed = { "/VO/MegaeraField_0409" }, RequiredFalseTextLines = { "MegaeraGift07" } },
				-- Control yourself.
				{ Cue = "/VO/MegaeraField_0413", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- Fight me yourself!
				{ Cue = "/VO/MegaeraField_0697", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- Need help against me, huh?
				{ Cue = "/VO/MegaeraField_0698", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- Calling in favors again?
				{ Cue = "/VO/MegaeraField_0699", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- Calling for help?
				{ Cue = "/VO/MegaeraField_0700", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- Nice trick...
				{ Cue = "/VO/MegaeraField_0701", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- This again?
				{ Cue = "/VO/MegaeraField_0702", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- Come on, Zag.
				{ Cue = "/VO/MegaeraField_0703", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- Not this again.
				{ Cue = "/VO/MegaeraField_0704", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- Oh no.
				{ Cue = "/VO/MegaeraField_0705", RequiredPlayed = { "/VO/MegaeraField_0409" } },
				-- You'll need more help than that.
				{ Cue = "/VO/MegaeraField_0706", RequiredPlayed = { "/VO/MegaeraField_0409" } },
			}
		},
		AssistReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.8,
				Queue = "Interrupt",
				RequiredTrait = "ThanatosAssistTrait",
				RequiredRoom = "A_Boss01",

				-- Thanatos, here?!
				{ Cue = "/VO/MegaeraField_0557" },
				-- What is this, Than?!
				{ Cue = "/VO/MegaeraField_0558" },
				-- Get out of here, Than.
				{ Cue = "/VO/MegaeraField_0559" },
				-- This isn't your fight, Than.
				{ Cue = "/VO/MegaeraField_0560" },
				-- Thanatos, again?
				{ Cue = "/VO/MegaeraField_0561" },
				-- Thanatos!
				{ Cue = "/VO/MegaeraField_0562" },
				-- Thanatos?!
				{ Cue = "/VO/MegaeraField_0563" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.8,
				Queue = "Interrupt",
				RequiredTrait = "SkellyAssistTrait",
				RequiredRoom = "A_Boss01",

				-- What is the meaning of this?
				{ Cue = "/VO/MegaeraField_0564" },
				-- Who is this idiot?
				{ Cue = "/VO/MegaeraField_0565" },
				-- I didn't summon you!
				{ Cue = "/VO/MegaeraField_0566" },
				-- How did that get in?!
				{ Cue = "/VO/MegaeraField_0567" },
				-- Odd friends you're making, Zagreus!
				{ Cue = "/VO/MegaeraField_0568" },
				-- It's that damn skeleton!
				{ Cue = "/VO/MegaeraField_0569", RequiredPlayed = { "/VO/MegaeraField_0567" }, },
				-- The skeleton, again?
				{ Cue = "/VO/MegaeraField_0570", RequiredPlayed = { "/VO/MegaeraField_0567" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.8,
				Queue = "Interrupt",
				RequiredTrait = "SisyphusAssistTrait",
				RequiredRoom = "A_Boss01",

				-- Sisyphus!!
				{ Cue = "/VO/MegaeraField_0571" },
				-- Sisyphus?!
				{ Cue = "/VO/MegaeraField_0572" },
				-- How dare you, Sisyphus?!
				{ Cue = "/VO/MegaeraField_0573" },
				-- It can't be, Sisyphus?!
				{ Cue = "/VO/MegaeraField_0574" },
				-- Damn you, Sisyphus!
				{ Cue = "/VO/MegaeraField_0575" },
				-- You blasted wretch!!
				{ Cue = "/VO/MegaeraField_0576" },
				-- How could you, Zagreus!!
				{ Cue = "/VO/MegaeraField_0577" },
				-- You're going to be sorry, Sisyphus!
				{ Cue = "/VO/MegaeraField_0578" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.8,
				Queue = "Interrupt",
				RequiredTrait = "DusaAssistTrait",
				RequiredRoom = "A_Boss01",

				-- Dusa?!
				{ Cue = "/VO/MegaeraField_0713" },
				-- Dusa!
				{ Cue = "/VO/MegaeraField_0714" },
				-- Dusa, here?
				{ Cue = "/VO/MegaeraField_0715" },
				-- Dusa, how?
				{ Cue = "/VO/MegaeraField_0716" },
				-- What are you doing, Dusa?!
				{ Cue = "/VO/MegaeraField_0717" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.8,
				Queue = "Interrupt",
				RequiredTrait = "AchillesPatroclusAssistTrait",
				RequiredRoom = "A_Boss01",

				-- Get back to your post, Shade!
				{ Cue = "/VO/MegaeraField_0740" },
				-- You shouldn't be here, Shade!
				{ Cue = "/VO/MegaeraField_0741" },
				-- Achilles?!
				{ Cue = "/VO/MegaeraField_0718", RequiredPlayed = { "/VO/MegaeraField_0740", "/VO/MegaeraField_0741" }, },
				-- Achilles!
				{ Cue = "/VO/MegaeraField_0719", RequiredPlayed = { "/VO/MegaeraField_0740", "/VO/MegaeraField_0741" }, },
				-- Achilles, here?
				{ Cue = "/VO/MegaeraField_0720", RequiredPlayed = { "/VO/MegaeraField_0740", "/VO/MegaeraField_0741" }, },
				-- Achilles, what?
				{ Cue = "/VO/MegaeraField_0721", RequiredPlayed = { "/VO/MegaeraField_0740", "/VO/MegaeraField_0741" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				Queue = "Interrupt",
				RequiredOneOfTraits = { "ThanatosAssistTrait", "SkellyAssistTrait", "SisyphusAssistTrait", "DusaAssistTrait", "AchillesPatroclusAssistTrait" },
				RequiredRoom = "A_Boss01",

				-- What is this, Zagreus?
				{ Cue = "/VO/MegaeraField_0579" },
				-- Fight me yourself!
				{ Cue = "/VO/MegaeraField_0580" },
				-- Can't handle me yourself?
				{ Cue = "/VO/MegaeraField_0581" },
				-- You again?
				{ Cue = "/VO/MegaeraField_0582" },
				-- You again!
				{ Cue = "/VO/MegaeraField_0583" },
				-- I told you to get out!
				{ Cue = "/VO/MegaeraField_0584" },
				-- I said stay out of this!
				{ Cue = "/VO/MegaeraField_0585" },
				-- Get out of here!!
				{ Cue = "/VO/MegaeraField_0586" },
				-- Don't interfere with this!
				{ Cue = "/VO/MegaeraField_0587" },
				-- You are not authorized to be here!
				{ Cue = "/VO/MegaeraField_0588" },
				-- Don't you have someplace else to be?
				{ Cue = "/VO/MegaeraField_0589" },
			},
		},
		CauseOfDeathVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.5,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				SuccessiveChanceToPlayAll = 0.33,
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				Source = { SubtitleColor = Color.MegVoice },

				-- We got him.
				{ Cue = "/VO/MegaeraField_0369" },
				-- We are the Furies.
				{ Cue = "/VO/MegaeraField_0370" },
				-- Our work here is done.
				{ Cue = "/VO/MegaeraField_0371" },
				-- He had no chance against us.
				{ Cue = "/VO/MegaeraField_0375" },
				-- <Laughter>
				{ Cue = "/VO/MegaeraField_0373" },
				-- We got him, sisters.
				{ Cue = "/VO/MegaeraField_0669" },
				-- Got him, Alecto. Good.
				{ Cue = "/VO/MegaeraField_0670", RequiredMaxSupportAINames = 1, RequiredSupportAINames = { "Alecto" }, },
				-- Stand down, Tisiphone. He's done.
				{ Cue = "/VO/MegaeraField_0671", RequiredMaxSupportAINames = 1, RequiredSupportAINames = { "Tisiphone" }, },
				-- He's finished, Tis. Well done.
				{ Cue = "/VO/MegaeraField_0672", RequiredMaxSupportAINames = 1, RequiredSupportAINames = { "Tisiphone" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.4,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				Source = { SubtitleColor = Color.MegVoice },
				RequiredTextLines = { "MegaeraGift10" },

				-- You're mine and always will be, Zagreus.
				{ Cue = "/VO/MegaeraField_0659", RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" }, },
				-- You're mine, Zag. Don't forget it.
				{ Cue = "/VO/MegaeraField_0660", RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" }, },
				-- We'll have to finish this back home.
				{ Cue = "/VO/MegaeraField_0661", RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" }, },
				-- It's all part of the job.
				{ Cue = "/VO/MegaeraField_0662" },
				-- What else did you expect?
				{ Cue = "/VO/MegaeraField_0663" },
				-- You could do better than that, Zagreus.
				{ Cue = "/VO/MegaeraField_0664" },
				-- Were you distracted maybe, Zagreus?
				{ Cue = "/VO/MegaeraField_0665" },
				-- Don't get so careless with me next time, Zag.
				{ Cue = "/VO/MegaeraField_0666" },
				-- Thanks for the little workout there.
				{ Cue = "/VO/MegaeraField_0667" },
				-- I guess I'll see you back here before long.
				{ Cue = "/VO/MegaeraField_0668" },
				-- You almost had me there.
				{ Cue = "/VO/MegaeraField_0673" },
				-- Finally.
				{ Cue = "/VO/MegaeraField_0296" },
				-- Give Hades my regards.
				{ Cue = "/VO/MegaeraField_0128" },
				-- You should have known better.
				{ Cue = "/VO/MegaeraField_0129" },
				-- I think we're finished here.
				{ Cue = "/VO/MegaeraField_0133" },
				-- I finally got you.
				{ Cue = "/VO/MegaeraField_0297", ConsecutiveClearsOfRoom = { Name = "A_Boss01", Count = 1, }, },
				-- I got you.
				{ Cue = "/VO/MegaeraField_0298" },
			},			
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.5,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				Source = { SubtitleColor = Color.MegVoice },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 2,
				},
				-- About damn time I finally got you, Zag.
				{ Cue = "/VO/MegaeraField_0143", RequiredTextLines = { "MegaeraGift03" }, },
				-- That took me long enough.
				{ Cue = "/VO/MegaeraField_0144" },
				-- Revenge is always sweet.
				{ Cue = "/VO/MegaeraField_0145", RequiredFalseTextLines = { "MegaeraGift10" } },
				-- I finally got you, Zagreus.
				{ Cue = "/VO/MegaeraField_0146" },
				-- Did you go easy on me, Zagreus?
				{ Cue = "/VO/MegaeraField_0147", RequiredFalseTextLines = { "MegaeraGift10" } },
				-- Did you just let me win...?
				{ Cue = "/VO/MegaeraField_0148", RequiredFalseTextLines = { "MegaeraGift10" } },
				-- Give Hades my regards.
				{ Cue = "/VO/MegaeraField_0128" },
				-- You must have let me win.
				{ Cue = "/VO/MegaeraField_0310" },
				-- Your heart just wasn't in it... why?
				{ Cue = "/VO/MegaeraField_0311", RequiredTextLines = { "MegaeraGift05" }, RequiredFalseTextLines = { "MegaeraGift10" } },
				-- I'll take what vengeance I can get.
				{ Cue = "/VO/MegaeraField_0312", RequiredFalseTextLines = { "MegaeraGift10" } },
				-- The Fates were on my side for once.
				{ Cue = "/VO/MegaeraField_0313" },
				-- You're out of practice, Zag.
				{ Cue = "/VO/MegaeraField_0314" },
				-- Get out of here.
				{ Cue = "/VO/MegaeraField_0315", RequiredFalseTextLines = { "MegaeraGift10" } },
				-- Finally got you for once.
				{ Cue = "/VO/MegaeraField_0677" },
				-- You better not have given me this one.
				{ Cue = "/VO/MegaeraField_0678" },
				-- Still got it in me after all this time.
				{ Cue = "/VO/MegaeraField_0679" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.5,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				Source = { SubtitleColor = Color.MegVoice },
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss01",
				  Count = 2,
				},
				-- You'll never beat me, Zag.
				{ Cue = "/VO/MegaeraField_0137", RequiredFalseTextLines = { "MegaeraMeeting01", "MegaeraMeeting01_Alt", "MegaeraMeeting01_B", "MegaeraMeeting01_Alt_B" } },
				-- Don't you know when to quit?
				{ Cue = "/VO/MegaeraField_0138", RequiredFalseTextLines = { "MegaeraGift10" } },
				-- Give up, already, damn you.
				{ Cue = "/VO/MegaeraField_0139", RequiredFalseTextLines = { "MegaeraGift10" } },
				-- I'll kill you next time, too.
				{ Cue = "/VO/MegaeraField_0140" },
				-- Must I keep doing this?
				{ Cue = "/VO/MegaeraField_0141" },
				-- You just can't take a hint.
				{ Cue = "/VO/MegaeraField_0142", RequiredFalseTextLines = { "MegaeraGift10" } },
				-- I'll kill you again, and again, and again.
				{ Cue = "/VO/MegaeraField_0306" },
				-- Your shining relatives can't help you here.
				{ Cue = "/VO/MegaeraField_0307", RequiredFalseTextLines = { "MegaeraGift10" } },
				-- Next time will pan out just like this.
				{ Cue = "/VO/MegaeraField_0308" },
				-- I'll send you back as often as it takes.
				{ Cue = "/VO/MegaeraField_0309" },
				-- Got you again like in the old days, Zag.
				{ Cue = "/VO/MegaeraField_0674" },
				-- Beginning to see a pattern, Zagreus?
				{ Cue = "/VO/MegaeraField_0675" },
				-- I'll never hold back, for you or anyone.
				{ Cue = "/VO/MegaeraField_0676" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.6,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				RequiredFalseTextLines = { "MegaeraGift10" },
				Source = { SubtitleColor = Color.MegVoice },

				-- Go home, Zagreus.
				{ Cue = "/VO/MegaeraField_0123" },
				-- That's what you get.
				{ Cue = "/VO/MegaeraField_0124" },
				-- Hah! Idiot.
				{ Cue = "/VO/MegaeraField_0125" },
				-- There! Now get out of my hall.
				{ Cue = "/VO/MegaeraField_0126" },
				-- You're nothing to me anymore.
				{ Cue = "/VO/MegaeraField_0127", RequiredFalseTextLines = { "MegaeraGift05" } },
				-- Give Hades my regards.
				{ Cue = "/VO/MegaeraField_0128" },
				-- You should have known better.
				{ Cue = "/VO/MegaeraField_0129" },
				-- To hell with you.
				{ Cue = "/VO/MegaeraField_0130" },
				-- Get the hell out of here.
				{ Cue = "/VO/MegaeraField_0131" },
				-- You stupid little fool.
				-- { Cue = "/VO/MegaeraField_0132" },
				-- I think we're finished here.
				{ Cue = "/VO/MegaeraField_0133" },
				-- Finally.
				{ Cue = "/VO/MegaeraField_0296" },
				-- I finally got you.
				{ Cue = "/VO/MegaeraField_0297" },
				-- I got you.
				{ Cue = "/VO/MegaeraField_0298" },
				-- Do not come back.
				{ Cue = "/VO/MegaeraField_0299" },
				-- Stupid fool.
				{ Cue = "/VO/MegaeraField_0300" },
				-- You little fool.
				{ Cue = "/VO/MegaeraField_0301" },
				-- Do say hello to Nyx for me.
				{ Cue = "/VO/MegaeraField_0302", RequiredTextLines = { "NyxFirstMeeting", "Flashback_Mother_01" } },
				-- Drown in the River Styx.
				{ Cue = "/VO/MegaeraField_0303" },
				-- We're through.
				{ Cue = "/VO/MegaeraField_0304" },
				-- We're finished here.
				{ Cue = "/VO/MegaeraField_0305" },
				-- <Laughter>
				{ Cue = "/VO/MegaeraField_0134" },
				-- <Laughter>
				{ Cue = "/VO/MegaeraField_0135" },
				-- <Laughter>
				{ Cue = "/VO/MegaeraField_0136" },
			},
		},
		InvulnerableHitSound = "/SFX/Enemy Sounds/Megaera/EmoteLaugh",
		--[[
		InvulnerableVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.15,
			CooldownTime = 3,

			-- Placeholder
		},
		--]]
		CharmStartSound = "/SFX/Enemy Sounds/Megaera/EmoteChuckle",
		OnCharmedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.66,
			CooldownTime = 120,
			CooldownName = "MegSpokeRecently",
			RequiredTextLines = { "MegaeraGift03" },
			SuccessiveChanceToPlay = 0.25,
			RequiredRoom = "A_Boss01",

			-- Do something with your hair?
			{ Cue = "/VO/MegaeraField_0590", RequiredTextLines = { "/VO/MegaeraField_0599" } },
			-- You look different somehow.
			{ Cue = "/VO/MegaeraField_0591", RequiredTextLines = { "/VO/MegaeraField_0599" } },
			-- What did you do to me....
			{ Cue = "/VO/MegaeraField_0592", RequiredTextLines = { "/VO/MegaeraField_0599" } },
			-- What in the...
			{ Cue = "/VO/MegaeraField_0593", RequiredTextLines = { "/VO/MegaeraField_0599" } },
			-- Quit messing with my heart...
			{ Cue = "/VO/MegaeraField_0594", RequiredTextLines = { "/VO/MegaeraField_0599" }, RequiredFalseTextLines = { "MegaeraGift10" } },
			-- Have you been working out?
			{ Cue = "/VO/MegaeraField_0595", RequiredTextLines = { "/VO/MegaeraField_0599" } },
			-- What is going on...
			{ Cue = "/VO/MegaeraField_0596", RequiredTextLines = { "/VO/MegaeraField_0599" } },
			-- This is embarrassing...
			{ Cue = "/VO/MegaeraField_0597", RequiredTextLines = { "/VO/MegaeraField_0599" } },
			-- Dirty trick...
			{ Cue = "/VO/MegaeraField_0598", RequiredTextLines = { "/VO/MegaeraField_0599" } },
			-- Oh no...
			{ Cue = "/VO/MegaeraField_0599", },
		},

		LowHealthVoiceLineThreshold = 0.6,
		LowHealthVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PlayOnceFromTableThisRun = true,
				CooldownTime = 12,
				CooldownName = "MegSpokeRecently",
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.05,
				
				ExplicitRequirements = true,
				GameStateRequirements =
				{
					RequiredFalseTextLines = { "MegaeraGift10" },
				},

				-- Bastard!
				{ Cue = "/VO/MegaeraField_0090", },
				-- You bastard!
				{ Cue = "/VO/MegaeraField_0091", },
				-- You little brat!
				{ Cue = "/VO/MegaeraField_0092", },
				-- You brat!
				{ Cue = "/VO/MegaeraField_0093", },
				-- How dare you!
				{ Cue = "/VO/MegaeraField_0094", },
				-- You dare?
				{ Cue = "/VO/MegaeraField_0095", },
				-- Why, you!
				{ Cue = "/VO/MegaeraField_0096", },
				-- That hurt.
				{ Cue = "/VO/MegaeraField_0097", },
				-- Ungh, you!
				{ Cue = "/VO/MegaeraField_0264", },
				-- Pfah!
				{ Cue = "/VO/MegaeraField_0265", },
				-- Tsch, heh.
				{ Cue = "/VO/MegaeraField_0267", },
				-- That all you've got?
				{ Cue = "/VO/MegaeraField_0637", },
				-- Am I supposed to be impressed?
				{ Cue = "/VO/MegaeraField_0635", },
				-- What else?
				{ Cue = "/VO/MegaeraField_0638", },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PlayOnceFromTableThisRun = true,
				CooldownTime = 60,
				CooldownName = "MegSpokeRecently",
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.01,
				RequiredTextLines = { "MegaeraGift10" },

				-- Pfah!
				{ Cue = "/VO/MegaeraField_0265", },
				-- Tsch, heh.
				{ Cue = "/VO/MegaeraField_0267", },
				-- Augh, hahaha.
				{ Cue = "/VO/MegaeraField_0626", },
				-- Oh-hoh...
				{ Cue = "/VO/MegaeraField_0627", },
				-- Not bad.
				{ Cue = "/VO/MegaeraField_0628", },
				-- Really.
				{ Cue = "/VO/MegaeraField_0629", },
				-- Hmph.
				{ Cue = "/VO/MegaeraField_0630", },
				-- That's it.
				{ Cue = "/VO/MegaeraField_0631", },
				-- Not yet.
				{ Cue = "/VO/MegaeraField_0632", },
				-- Ungh, heh.
				{ Cue = "/VO/MegaeraField_0633", },
				-- How thoughtful of you, Zag.
				{ Cue = "/VO/MegaeraField_0634", },
				-- You can do better than that.
				{ Cue = "/VO/MegaeraField_0636", },
				-- That's it?
				{ Cue = "/VO/MegaeraField_0639", },
				-- Is that all?
				{ Cue = "/VO/MegaeraField_0640", },
				-- My turn.
				{ Cue = "/VO/MegaeraField_0641", },
				-- Mm.
				{ Cue = "/VO/MegaeraField_0768", },
				-- Really...
				{ Cue = "/VO/MegaeraField_0769", },
				-- Nice shot...
				{ Cue = "/VO/MegaeraField_0770", RequiredAnyWeapon = { "BowWeapon", "GunWeapon" } },
				-- Damn...
				{ Cue = "/VO/MegaeraField_0771", },
				-- Oh, come on.
				{ Cue = "/VO/MegaeraField_0772", },
				-- Really, Zag?
				{ Cue = "/VO/MegaeraField_0773", },
			},
		},
		CriticalHealthVoiceLineThreshold = 0.3,
		CriticalHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			SuccessiveChanceToPlay = 0.05,
			CooldownTime = 12,
			CooldownName = "MegSpokeRecently",
			PreLineWait = 0.35,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredFalseTextLines = { "MegaeraGift10" },
			},

			-- Damn it!
			{ Cue = "/VO/MegaeraField_0098", },
			-- Damn you!
			{ Cue = "/VO/MegaeraField_0099", },
			-- Curse you!
			{ Cue = "/VO/MegaeraField_0100", },
			-- Blood and darkness!
			{ Cue = "/VO/MegaeraField_0101", },
			-- Not again!
			{ Cue = "/VO/MegaeraField_0102",
				GameStateRequirements =
				{
					ConsecutiveClearsOfRoom = { Name = "A_Boss01", Count = 1 },
				},
			},
			-- Enough of this!
			{ Cue = "/VO/MegaeraField_0103", },
			-- That does it!
			{ Cue = "/VO/MegaeraField_0104", },
			-- Enough!
			{ Cue = "/VO/MegaeraField_0105", },
			-- Urgh no.
			{ Cue = "/VO/MegaeraField_0262", },
			-- Gah, hrngh!
			{ Cue = "/VO/MegaeraField_0266", },
			-- Augh damn it!
			{ Cue = "/VO/MegaeraField_0263", },
		},
		DeathVoiceLines =
		{
			Queue = "Interrupt",
			{
				{ Cue = "/EmptyCue" }
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,
				SkipAnim = true,
				RequiredFalseTextLines = { "MegaeraGift10" },

				-- No...!
				{ Cue = "/VO/MegaeraField_0149", PreLineWait = 0.3, RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- No!
				{ Cue = "/VO/MegaeraField_0150", PreLineWait = 0.3, RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- How...!
				{ Cue = "/VO/MegaeraField_0151", PreLineWait = 0.3, RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- How...?!
				{ Cue = "/VO/MegaeraField_0152", PreLineWait = 0.3, RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- What...?!
				{ Cue = "/VO/MegaeraField_0153", PreLineWait = 0.3, RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- Impossible!
				{ Cue = "/VO/MegaeraField_0154", PlayOnce = true },
				-- I can't--!
				{ Cue = "/VO/MegaeraField_0155", PreLineWait = 0.6, RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- Again?!
				{ Cue = "/VO/MegaeraField_0156", RequiredPlayed = { "/VO/MegaeraField_0154" }, RequiredKills = { Harpy = 3 } },
				-- Not again?!
				{ Cue = "/VO/MegaeraField_0157", RequiredPlayed = { "/VO/MegaeraField_0154" }, RequiredKills = { Harpy = 5 } },
				-- Ungh, damn...
				{ Cue = "/VO/MegaeraField_0316", PreLineWait = 0.3, RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- Damn you...
				{ Cue = "/VO/MegaeraField_0317", RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- Ngh, blood and--
				{ Cue = "/VO/MegaeraField_0318", RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- Lord Hades, I...
				{ Cue = "/VO/MegaeraField_0319", RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- Sisters...
				{ Cue = "/VO/MegaeraField_0320", RequiredPlayed = { "/VO/MegaeraField_0154" }, RequiredTextLines = { "Fury2FirstAppearance", "Fury3FirstAppearance" } },
				-- Why, you...
				{ Cue = "/VO/MegaeraField_0321", RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- This is...
				{ Cue = "/VO/MegaeraField_0322", RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- How could I--!
				{ Cue = "/VO/MegaeraField_0323", RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- Absurd...
				{ Cue = "/VO/MegaeraField_0324", RequiredPlayed = { "/VO/MegaeraField_0154" } },
				-- Why...
				{ Cue = "/VO/MegaeraField_0325", RequiredPlayed = { "/VO/MegaeraField_0154" } },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SkipAnim = true,
				PreLineWait = 1.0,
				RequiredTextLines = { "MegaeraGift10" },

				-- Nggh... not... bad...
				{ Cue = "/VO/MegaeraField_0680" },
				-- Ungh, heh heh...
				{ Cue = "/VO/MegaeraField_0681" },
				-- Guh, got... me...
				{ Cue = "/VO/MegaeraField_0682" },
				-- Unghh! That was...
				{ Cue = "/VO/MegaeraField_0683" },
				-- Kh!! Keep... go...
				{ Cue = "/VO/MegaeraField_0684" },
				-- No! You're... good...
				{ Cue = "/VO/MegaeraField_0685" },
				-- Ngh! Every... time...!
				{ Cue = "/VO/MegaeraField_0686" },
				-- Mmph! Well... fought...
				{ Cue = "/VO/MegaeraField_0687" },
				-- Ungh, you... can't...
				{ Cue = "/VO/MegaeraField_0688" },
				-- Augh, can't... be...
				{ Cue = "/VO/MegaeraField_0689" },
				-- Guh, fine.... then....
				{ Cue = "/VO/MegaeraField_0690" },
				-- Sisters... go...
				{ Cue = "/VO/MegaeraField_0691", PreLineWait = 0.3, RequiredSupportAINames = { "Tisiphone", "Alecto" }, },
				-- Sorry... sisters...
				{ Cue = "/VO/MegaeraField_0692", PreLineWait = 0.3, RequiredSupportAINames = { "Tisiphone", "Alecto" }, },
				-- Ughh... Alecto....
				{ Cue = "/VO/MegaeraField_0693", RequiredMaxSupportAINames = 1,	RequiredSupportAINames = { "Alecto" }, },
				-- Guh... Tis, I....
				{ Cue = "/VO/MegaeraField_0694", RequiredMaxSupportAINames = 1,	RequiredSupportAINames = { "Tisiphone" }, },
				-- Don't... like... you...
				{ Cue = "/VO/MegaeraField_0695" },
				-- Ngh... not... yet...
				{ Cue = "/VO/MegaeraField_0696" },
			},
		},
		OnKillGlobalVoiceLines = "FuryVanquishedGlobalVoiceLines",
		KillsRequiredForVoiceLines = 1,

		MetaPointDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 4,
			MaxParcels = 4,
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		BossPresentationSuperPriorityIntroTextLineSets =
		{
			FurySistersUnion01 =
			{
				PlayOnce = true,
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0186", Speaker = "NPC_FurySister_01",
					Text = "My sisters and I. We've had a chance to talk, and we have come to an agreement, Zagreus. As you can see." },
				{ Cue = "/VO/Alecto_0295", PreLineWait = 0.35, Speaker = "NPC_FurySister_02", Portrait = "Portrait_FurySister02_Default_01",
					Text = "Megaera, Tis, you ready?" },
				{ Cue = "/VO/Tisiphone_0091", PreLineWait = 0.35, Speaker = "NPC_FurySister_03", Portrait = "Portrait_FurySister03_Default_01",
					Text = "{#DialogueItalicFormat}Mmurdererr{#PreviousFormat}!" },
				{ Cue = "/VO/ZagreusField_1403", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Three against one. Doesn't seem all that sporting, now, does it?" },
				{ Cue = "/VO/MegaeraField_0187", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "We're each well past the need for any sport. We'll kill you, whatever it takes. Erinyes! {#DialogueItalicFormat}Now{#PreviousFormat}." },
			},
			FurySistersUnion02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FurySistersUnion01", "MegaeraGift06", "MegaeraBedroom01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Tisiphone", "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0419", Speaker = "NPC_FurySister_01",
					Text = "What's the matter, Zagreus? You look a bit uncomfortable. Something you want to say to me? Or any one of us?" },
				{ Cue = "/VO/ZagreusField_2736", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "Well, it's just... there's something that I wanted to discuss with you, at some point, Meg, but after more consideration, I am thinking maybe now is not the time." },
				{ Cue = "/VO/MegaeraField_0420", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I understand entirely. Though you should know my sisters and I keep no secrets from each other, anymore. Isn't that right, Sisters?" },
			},

			FuryPostSistersUnion01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FurySistersUnion01" },
				RequiredInactiveMetaUpgrade = "BossDifficultyShrineUpgrade",
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0421", Speaker = "NPC_FurySister_01",
					Text = "{#DialogueItalicFormat}Eugh{#PreviousFormat}, I almost want to thank you, Zagreus. I thought you'd never change that blasted Pact, and leave me here, in peace." },
				{ Cue = "/VO/ZagreusField_2737", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What, you mean you aren't lonelier without Alecto's or Tisiphone's companionship? They seem so wonderful to have around." },
				{ Cue = "/VO/MegaeraField_0422", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "They're tolerable each to some extent. About as much as I can say for you. Now let's the two of us begin." },
			},

			FurySisterUnionSingleSis01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FurySistersUnion01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredSupportAINames = { "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0552", Speaker = "NPC_FurySister_01", Portrait = "Portrait_FurySister01_Default_01",
					Text = "See, Alecto? He is right on time, just as I said." },
				{ Cue = "/VO/Alecto_0266",
					Emote = "PortraitEmoteFiredUp",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Speaker = "NPC_FurySister_02", Portrait = "Portrait_FurySister02_Default_01",
					Text = "Megaera, {#DialogueItalicFormat}bleed {#PreviousFormat}him!" },
			},
			FurySisterUnionSingleSis02 =
			{
				PlayOnce = true,
				RequiredPlayed = { "FurySistersUnion01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredSupportAINames = { "Tisiphone" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0554", Speaker = "NPC_FurySister_01", Portrait = "Portrait_FurySister01_Default_01",
					Text = "Heads up, Tisiphone. I think I found a murderer for you." },
				{ Cue = "/VO/Tisiphone_0027",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Mmuuurrr{#PreviousFormat}derrrr..." },
			},
		},

		BossPresentationPriorityIntroTextLineSets =
		{
			FuryMetSisters01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2FirstAppearance", "Fury3FirstAppearance" },
				RequiredInactiveMetaUpgrade = "BossDifficultyShrineUpgrade",
				{ Cue = "/VO/MegaeraField_0178", Speaker = "NPC_FurySister_01",
					Text = "I have to level with you, Zagreus. For all we've been through... never once have I wanted you to meet my sisters." },
				{ Cue = "/VO/ZagreusField_1399", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I can't imagine why not! We had a lovely time getting to know each other. We laughed, we cried! My only regret was that you couldn't be there, yourself." },
				{ Cue = "/VO/MegaeraField_0179", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You don't know what you're saying. There's a reason that they're not permitted in the House. Though, come on. One of us is going back there, now." },
			},

			FuryMetSisters02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2FirstAppearance", "Fury3FirstAppearance", "FuryMetSisters01" },
				RequiredInactiveMetaUpgrade = "BossDifficultyShrineUpgrade",
				{ Cue = "/VO/MegaeraField_0180", Speaker = "NPC_FurySister_01",
					Text = "You've really done it, Zagreus. My sisters have returned. All three of us now share the same assignment." },
				{ Cue = "/VO/ZagreusField_1400", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Is it wrong of me that I am somewhat honored to have garnered the attention of the Erinyes?" },
				{ Cue = "/VO/MegaeraField_0181", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh I would say it's very wrong of you, indeed." },
			},

			FuryNoDarknessReaction01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MegaeraMirrorProgress01" },
				RequiredActiveMetaPointsMax = 0,
				{ Cue = "/VO/MegaeraField_0414", Speaker = "NPC_FurySister_01",
					Text = "I sense something different about you, Zagreus. Your old weakness. {#DialogueItalicFormat}Ah{#PreviousFormat}... the Mirror. I thought you said you weren't trying to compete with me?" },
				{ Cue = "/VO/ZagreusField_2735", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I wasn't. But then you gave me a good idea to try. I'm not as weak as I once was. With or without the Mirror's help." },
				{ Cue = "/VO/MegaeraField_0415", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Is that so? Well then let's see if you're correct. Come on." },
			},

			FuryAboutPersephoneMeeting01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "PersephoneFirstMeeting" },
				RequiredFalseTextLines = { "Ending01" },
				RequiredFalseTextLinesLastRun = { "MegaeraAboutPersephoneMeeting01", "MegaeraAboutPersephoneMeeting01_Alt" },
				MaxRunsSinceAnyTextLines = { TextLines = { "Ending01" }, Count = 18 },
				RequiredFalseSupportAINames = { "Alecto" },
				RequiresLastRunCleared = true,
				{ Cue = "/VO/MegaeraField_0707", Speaker = "NPC_FurySister_01",
					Text = "I heard that you escaped. Then, what are you still doing here? Forget something along the way?" },
				{ Cue = "/VO/ZagreusField_4654", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You know... I think I'd rather fight you to the death again than try to answer either of those questions, right now." },
				{ Cue = "/VO/MegaeraField_0708", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I don't know what you're up to, Zagreus. But I guess it doesn't matter, either way. All that matters is you're not getting past me." },
			},

			FuryPostEnding01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Ending01" },
				RequiredFalseTextLines = { "PersephoneAboutOlympianReunionQuest01" },
				RequiredFalseSupportAINames = { "Alecto" },
				{ Cue = "/VO/MegaeraField_0711", Speaker = "NPC_FurySister_01",
					Text = "Your mother has returned to us, already, Zagreus. And still you're going to keep battling your way out, past me and everything up there? Why?" },
				{ Cue = "/VO/ZagreusField_4305", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Father says there's no escape from here, and I like to repeatedly show him he's wrong. Besides, I think getting out there a bit from time to time does me some good." },
				{ Cue = "/VO/MegaeraField_0712", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Sounds like you've found yourself a steady line of work. Most jobs just need doing. If this one gives you some fulfillment, stick to it. Now, come on." },
			},

			FuryAboutEpilogueReunionQuest01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "PersephoneAboutOlympianReunionQuest01" },
				RequiredFalseTextLines = { "OlympianReunionQuestComplete" },
				MaxRunsSinceAnyTextLines = { TextLines = { "OlympianReunionQuestComplete" }, Count = 15 },
				RequiredFalseSupportAINames = { "Alecto" },
				{ Cue = "/VO/MegaeraField_0748", Speaker = "NPC_FurySister_01",
					Text = "What is it that you're up to now, Zagreus? The Queen is back. But still you're making me show up like this?" },
				{ Cue = "/VO/ZagreusField_4313", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Got some unfinished business with the Olympians to take care of, was in the area, figured I'd say hi. Hi, Meg!" },
				{ Cue = "/VO/MegaeraField_0749", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Don't start with me. You show up here, we fight, somebody dies. That's it. Now, who's it going to be?" },
			},

			FuryPostIntermission01 =
			{
				PlayOnce = true,
				RequiredMinAnyTextLines = { TextLines = { "MegIntermissionChat01", "MegIntermissionChat02", "MegIntermissionChat03", "MegIntermissionChat04", "MegIntermissionChat05", "MegIntermissionChat06" }, Count = 1 },
				RequiredAnyTextLinesLastRun = { "MegIntermissionChat01", "MegIntermissionChat02", "MegIntermissionChat03", "MegIntermissionChat04", "MegIntermissionChat05", "MegIntermissionChat06" },
				RequiredFalseSupportAINames = { "Alecto" },
				{ Cue = "/VO/MegaeraField_0750", Speaker = "NPC_FurySister_01",
					Text = "Been seeing an awful lot of each other lately, haven't we. You had enough of me, yet, Zag?" },
				{ Cue = "/VO/ZagreusField_4314", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Never enough, Meg. You ready for another go at it, too, I take it?" },
				{ Cue = "/VO/MegaeraField_0751", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Always. Although I do like to keep things fresh, so... surprise me." },
			},
			FuryEncounterStoryProgress01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryFirstAppearance" },
				RequiredAnyTextLines = { "Flashback_Mother_01", "CerberusStyxMeeting01" },
				RequiredFalseTextLines = { "MegaeraGift07", "PersephoneFirstMeeting" },
				RequiredKills = { Harpy = 2 },
				{ Cue = "/VO/MegaeraField_0023", Speaker = "NPC_FurySister_01",
					Text = "Listen to me, Zagreus. Your mother is long gone. You're never getting out of here, and even if you did, what hope could you possibly have in finding her up in the world out there?" },
				{ Cue = "/VO/ZagreusField_0512", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					Text = "I've hope enough. Not that it's any of your business anymore." },
				{ Cue = "/VO/MegaeraField_0024", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your family is here. And so is your responsibility. You're running from yourself. Though, I can slow you down a bit I think." },
			},

			FuryEncounterGunWeapon01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter02" },
				RequiredWeapon = "GunWeapon",
				{ Cue = "/VO/MegaeraField_0164", Speaker = "NPC_FurySister_01",
					Text = "{#DialogueItalicFormat}What{#PreviousFormat}... where did you get the Rail? Do you know what you have? Where are your customary weapons?" },
				{ Cue = "/VO/ZagreusField_1385", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I left them at home. And, I sort of know what I have, inasmuch as it's largely responsible for getting me this far. Would you like to see a demonstration?" },
				{ Cue = "/VO/MegaeraField_0165", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Yes, I would. I always have, as a matter of fact." },
			},

			FuryEncounterFistWeapon01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter02" },
				RequiredWeapon = "FistWeapon",
				{ Cue = "/VO/MegaeraField_0435", Speaker = "NPC_FurySister_01",
					Text = "What's that you're holding, Zagreus? Please tell me that you didn't steal the most dangerous, unstable artifacts sealed shut within your father's vault." },
				{ Cue = "/VO/ZagreusField_2743", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#DialogueItalicFormat}Erm{#PreviousFormat}, it wasn't I who stole them, if that's any reassurance to you, Meg!" },
				{ Cue = "/VO/MegaeraField_0436", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You are a hopeless fool. You cannot possibly know what you're doing with those things. You put them back exactly where you found them." },
			},

			FuryAboutDusaFiring01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryFirstAppearance", "DusaVsNyx04" },
				RequiredFalseTextLines = { "MegaeraAboutDusaVsNyx02" },
				RequiredTrueFlags = { "DusaFiredFromJob" },
				RequiredFalseSupportAINames = { "Alecto" },
				{ Cue = "/VO/MegaeraField_0730", Speaker = "NPC_FurySister_01",
					Text = "...Nyx really let Dusa go?" },
				{ Cue = "/VO/ZagreusField_4309", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "She did... so you heard. I don't know what happened. You didn't even get a chance to say goodbye?" },
				{ Cue = "/VO/MegaeraField_0731", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "No. Damn it. If you had anything to do with this...! Even if you didn't, come on and die!" },
			},

			FuryPactReaction03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryFirstAppearance" },
				RequiredTrueFlags = { "ShrineUnlocked" },
				RequiredActiveShrinePointsMin = 25,
				{ Cue = "/VO/MegaeraField_0446", Speaker = "NPC_FurySister_01",
					Text = "What have you done with the Pact, Zagreus? This isn't even Asphodel, and I can barely tolerate the heat. Do you really want to die this terribly?" },
				{ Cue = "/VO/ZagreusField_2748", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Appreciate all the concern, but I just thought I'd live a little, Meg. You ought to try it for yourself, sometime!" },
				{ Cue = "/VO/MegaeraField_0447", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You ought to try watching your mouth. You want a swift and painful death, you'll have one momentarily." },
			},

		},
		BossPresentationIntroTextLineSets =
		{
			--[[ removed to make room for QuestLog 11/23/19 [gk]
			FuryFirstAppearanceFirstRun =
			{
				PlayOnce = true,
				RequiredCompletedRuns = 0,
				{ Cue = "/VO/MegaeraField_0002", Speaker = "NPC_FurySister_01",
					Text = "Halt, Zagreus. Not one step further." },
				{ Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag", Cue = "/VO/ZagreusField_0461",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Come on, Meg. Haven't we had more than enough of each other by now? Besides, don't you have someplace else to be?" },
				{ Cue = "/VO/MegaeraField_0003", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You know exactly why I'm here. Now shut your mouth, and come die like a man." },
			},
			]]--
			FuryFirstAppearance =
			{
				PlayOnce = true,
				RequiredFalseTextLines = { "FuryFirstAppearanceFirstRun" },
				{ Cue = "/VO/MegaeraField_0002", Speaker = "NPC_FurySister_01",
					Text = "Halt, Zagreus. Not one step further." },
				{ Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag", Cue = "/VO/ZagreusField_0461",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Come on, Meg. Haven't we had more than enough of each other by now? Besides, don't you have someplace else to be?" },
				{ Cue = "/VO/MegaeraField_0004", Speaker = "NPC_FurySister_01",
					Text = "Your father sent me. All in all, I'd rather be on your bad side than his. Now you can turn back like a good little man, or I can send you home the painful way. What'll it be?" },
				{ Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag", Cue = "/VO/ZagreusField_0137", PreLineWait = 0.35,
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "...I'll have to go with the painful way." },
				{ Cue = "/VO/MegaeraField_0005", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "A man after my own heart." },
			},

			FuryEncounterStoryProgress02 =
			{
				PlayOnce = true,
				RequiredAnyRoomsLastRun = { "B_Boss01", "B_Boss02", },
				RequiredTextLines = { "FuryEncounterStoryProgress01", },
				RequiredFalseTextLines = { "MegaeraGift08", "OlympianReunionQuestComplete" },
				RequiredFalseSupportAINames = { "Alecto" },
				{ Cue = "/VO/MegaeraField_0025", Speaker = "NPC_FurySister_01",
					Text = "Tell me something, Zag, because I'm curious. Do your Olympian relatives know the real reason you've been trying to escape?" },
				{ Cue = "/VO/ZagreusField_0513", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'll get around to that in due time. They're family. They'll understand no doubt." },
				{ Cue = "/VO/MegaeraField_0026", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're in over your head, you idiot. You'll fray what bonds are left between Lord Hades and those ingrates on Olympus." },
			},

			FuryAboutBeingClose01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MegaeraGift10" },
				RequiredFalseSupportAINames = { "Alecto" },
				{ Cue = "/VO/MegaeraField_0437", Speaker = "NPC_FurySister_01",
					Text = "Things can't entirely be different between you and me. You know that, don't you, Zag? Not when it comes to this, at least." },
				{ Cue = "/VO/ZagreusField_2744", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "I do. We wouldn't both be consummate professionals if it were any other way. You won't be going easy on me, will you?" },
				{ Cue = "/VO/MegaeraField_0438", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I'm going to pretend you didn't ask me that. Now give me everything you've got!" },
			},

			FuryAboutBeingClose02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryAboutBeingClose01", "Fury2FirstAppearance", "Fury3FirstAppearance" },
				RequiredInactiveMetaUpgrade = "BossDifficultyShrineUpgrade",
				{ Cue = "/VO/MegaeraField_0441", Speaker = "NPC_FurySister_01",
					Text = "What is it, Zagreus? You've got that pleased-with-yourself look, which can only mean you have something obnoxious to tell me." },
				{ Cue = "/VO/ZagreusField_2950", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "{#DialogueItalicFormat}I never{#PreviousFormat}! Look, I'm simply pleased to see you, Meg. Hence the insuppressible smile. Could have been one of your lovely sisters here instead..." },
				{ Cue = "/VO/MegaeraField_0442", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're not going to throw me off my guard that easily. My sisters wouldn't let me hear the end of it." },
			},

			FuryAboutPersephoneMeeting02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryAboutPersephoneMeeting01" },
				RequiredFalseTextLines = { "Ending01" },
				RequiredFalseSupportAINames = { "Alecto" },
				{ Cue = "/VO/MegaeraField_0746", Speaker = "NPC_FurySister_01",
					Text = "And where, exactly, do you think you're going, Zagreus?" },
				{ Cue = "/VO/ZagreusField_4312", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I think I'm going all the way to the top again, Meg. To find my mother. You won't stop me. Get out of my way." },
				{ Cue = "/VO/MegaeraField_0747", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "We both know that's not going to happen. Getting out of your way, I mean." },
			},
			FuryAboutPersephoneMeeting03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryAboutPersephoneMeeting02", "PersephoneMeeting04" },
				RequiredFalseTextLines = { "Ending01" },
				RequiredFalseSupportAINames = { "Alecto" },
				{ Cue = "/VO/MegaeraField_0709", Speaker = "NPC_FurySister_01",
					Text = "Your mother, Zagreus. You really think you'll find her once again, out there? Even if you make it out... maybe she's found another hiding place." },
				{ Cue = "/VO/ZagreusField_2860", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It isn't us she's hiding from up there. Father let her go. He never wanted to go after her. So I appreciate your concern, but I'll find her again." },
				{ Cue = "/VO/MegaeraField_0710", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "That sounds like information neither one of them would want for me to know. You know the punishment for spilling secrets, don't you?" },
			},

			FuryRunClearedReaction02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter02" },
				RequiredFalseSeenRooms = { "D_Boss01" },
				RequiresLastRunNotCleared = true,
				RequiredRunsCleared = 0,
				{ Cue = "/VO/MegaeraField_0170", Speaker = "NPC_FurySister_01",
					Text = "What are you doing, Zagreus? The Underworld is sealed off. What you're attempting is impossible. You've seen what happens when you go too far." },
				{ Cue = "/VO/ZagreusField_1388", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "This place can't stay sealed shut forever, Meg. In the meantime, I thought I'd get some practice in, you know?" },
				{ Cue = "/VO/MegaeraField_0171", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I'm not your practice partner, fool." },
			},

			-- Fury Sisters Foreshadow
			FuryStoryProgress01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MegaeraWithHades01" },
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/MegaeraField_0174", Speaker = "NPC_FurySister_01",
					Text = "May I help you with something, Zagreus?" },
				{ Cue = "/VO/ZagreusField_1390", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Now that you mention it, you can, Meg. I was wondering what was Father carrying on with you about back home?" },
				{ Cue = "/VO/MegaeraField_0175", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Eavesdropping again? If you must know, my job performance is under review. Though, I'm sure this job's about to go just fine." },
			},
			-- Fury Sisters Foreshadow
			FuryStoryProgress02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryStoryProgress01" },
				RequiredFalseTextLines = { "FuryMetSisters02", "Ending01" },
				RequiredKills = { Harpy = 5 },
				RequiredRoomLastRun = "B_Intro",
				{ Cue = "/VO/MegaeraField_0176", Speaker = "NPC_FurySister_01",
					Text = "I sincerely hope that you enjoy these meetings with me while you can. I know I will." },
				{ Cue = "/VO/ZagreusField_1398", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Now that's a rather ominous thing to say to someone, Meg. Care to explain in terms an idiot like me could understand?" },
				{ Cue = "/VO/MegaeraField_0177", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Lord Hades is exploring other options. He has no confidence in my ability to stop you anymore. Though, maybe it isn't too late for me to change his mind." },
			},

			FuryRunProgress01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter02", "MegaeraGift01" },
				RequiredAnyRoomsLastRun = { "B_Boss01", "B_Boss02" },
				RequiredFalseRoomLastRun = "C_Intro",
				{ Cue = "/VO/MegaeraField_0166", Speaker = "NPC_FurySister_01",
					Text = "It's been a while, Zagreus. You must have made it pretty far last time. Let's see. Outer reaches of Asphodel?" },
				{ Cue = "/VO/ZagreusField_1386", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Outer reaches of Asphodel. And I have to say, Meg, you are positively a sight compared with that blasted Bone Hydra stewing away up there." },
				{ Cue = "/VO/MegaeraField_0167", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "How very flattering, to have compared me to the remains of some mindless outsized lizard. Come, maybe I'll kill you just as easily as your new Hydra friend." },
			},
			FuryRunProgress02 =
			{
				PlayOnce = true,
				RequiredMinCompletedRuns = 30,
				{ Cue = "/VO/MegaeraField_0380", Speaker = "NPC_FurySister_01",
					Text = "How many times have we been going at it like this, Zagreus? You tired of me, yet?" },
				{ Cue = "/VO/ZagreusField_1587", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "We're both immortals, Meg. We'll be seeing plenty of each other for a while yet. I've come to welcome these occasions." },
				{ Cue = "/VO/MegaeraField_0381", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Then, good. Lashing you across the face beats waiting for the opportunity to do so. Come." },
			},
			FuryRunProgress03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter02" },
				RequiredRoomLastRun = "C_Intro",
				RequiredRunsCleared = 0,
				{ Cue = "/VO/MegaeraField_0168", Speaker = "NPC_FurySister_01",
					Text = "I heard what happened. You crossed the River of Flame. You really did it." },
				{ Cue = "/VO/ZagreusField_1387", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "That Hydra was a total bastard, though. Bastard{#DialogueItalicFormat}s{#PreviousFormat}. But, you sound practically impressed with me, there, Meg! I feel so flattered!" },
				{ Cue = "/VO/MegaeraField_0169", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You'll soon feel something else. I don't know how you did it. But it changes nothing." },
			},
			FuryRunProgress04 =
			{
				PlayOnce = true,
				RequiredKills = { Harpy = 50 },
				{ Cue = "/VO/MegaeraField_0439", Speaker = "NPC_FurySister_01",
					Text = "How utterly disgusting... I was just counting, Zagreus, and as it happens, I have lost to you fifty times, already! If not more. Can you believe this? {#DialogueItalicFormat}Ugh{#PreviousFormat}, how I've fallen." },
				{ Cue = "/VO/ZagreusField_2745", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, don't take it so hard, Meg! Once you die several dozen times, you start to get accustomed to the emotional pain, as well as the physical! Up for some more of either?" },
				{ Cue = "/VO/MegaeraField_0440", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Of course! Who do you think I am? Although I guess there's no use keeping score with you." },
			},
			FuryRunProgress05 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryRunProgress04" },
				RequiredKills = { Harpy = 500 },
				{ Cue = "/VO/MegaeraField_0754", Speaker = "NPC_FurySister_01",
					Text = "You know how many times you've beaten me, here, Zagreus? Can you even guess?" },
				{ Cue = "/VO/ZagreusField_4316", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#DialogueItalicFormat}Erm{#PreviousFormat}... feels like a lot, admittedly, I mean, we've been going at this for a while, now. Four hundred and twelve times...?" },
				{ Cue = "/VO/MegaeraField_0755", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "...Five hundred times, exactly. Though I figure, you haven't been keeping track of how many times I've killed you. {#DialogueItalicFormat}Ugh{#PreviousFormat}, maybe that's my problem. Well, plenty of time to work it out after this." },
			},

			FuryAboutAlecto01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MegaeraGift01" },
				RequiredKillsLastRun = { "Harpy2" },
				RequiredInactiveMetaUpgrade = "BossDifficultyShrineUpgrade",
				{ Cue = "/VO/MegaeraField_0182", Speaker = "NPC_FurySister_01",
					Text = "You beat Alecto, Zag. Could hear her screaming her head off about it all the way through Tartarus... I almost want to thank you." },
				{ Cue = "/VO/ZagreusField_1401", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "I almost want to say you're very welcome. Have you and she always been on bad terms like this?" },
				{ Cue = "/VO/MegaeraField_0183", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "We have long-standing differences. It's worse with family. You know what it's like." },
			},

			FuryAboutTisiphone01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MegaeraGift01" },
				RequiredKillsLastRun = { "Harpy3" },
				RequiredInactiveMetaUpgrade = "BossDifficultyShrineUpgrade",
				{ Cue = "/VO/MegaeraField_0184", Speaker = "NPC_FurySister_01",
					Text = "{#DialogueItalicFormat}Huh{#PreviousFormat}. Not even Tisiphone could stop you. Your father must be sorely disappointed." },
				{ Cue = "/VO/ZagreusField_1402", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "He's difficult to please, that much is true. What happened to Tisiphone, anyway? She isn't much for conversation." },
				{ Cue = "/VO/MegaeraField_0185", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "It runs in the family. Tis only knows her work. And, professional distance is important." },
			},

			FuryAboutSisyphus01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SisyphusLiberationQuestComplete" },
				{ Cue = "/VO/MegaeraField_0425", Speaker = "NPC_FurySister_01",
					Text = "If there's anyone in all the Underworld who owes you, Zagreus, it's your friend, Sisyphus. He would be much worse off if not for you." },
				{ Cue = "/VO/ZagreusField_2738", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "What, because I've been distracting you from administering lashings like before? I hate to think you prefer to whip with no fear of reprisal whatsoever, Meg." },
				{ Cue = "/VO/MegaeraField_0426", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Dereliction of duty and fear of reprisal are not one and the same. Though you don't seem to be concerned with either one." },
			},

			FuryNoHammerReaction01 =
			{
				PlayOnce = true,
				RequiredMaxWeaponUpgrades = 0,
				RequiredTextLines = { "AchillesAboutDaedalus01" },
				{ Cue = "/VO/MegaeraField_0429", Speaker = "NPC_FurySister_01",
					Text = "Your weapon's looking rather dull, there, Zagreus. Great Daedalus decided not to grace you with his gifts this time around?" },
				{ Cue = "/VO/ZagreusField_2740", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Now that you mention it, he hasn't, no. Though I'm prepared to say I don't need special augmentations to get past you." },
				{ Cue = "/VO/MegaeraField_0430", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, we can put that to the test right now. Just remember, you need all the help you can get." },
			},

			FuryDarknessReaction01 =
			{
				PlayOnce = true,
				RequiredActiveMetaPointsMin = 1000,
				RequiredTextLines = { "FuryFirstAppearance" },
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/MegaeraField_0378", Speaker = "NPC_FurySister_01",
					Text = "That Mirror's made you stronger, Zagreus. You're fortunate to have Nyx helping you." },
				{ Cue = "/VO/ZagreusField_1391", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "No hard feelings. I think she feels partly responsible for all of this." },
				{ Cue = "/VO/MegaeraField_0379", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "She shouldn't. The only one responsible for all of this is you. And I thought even you would have understood that by now." },
			},

			FuryPactReaction01 =
			{
				PlayOnce = true,
				RequiredTrueFlags = { "ShrineUnlocked" },
				RequiredTextLines = { "FuryFirstAppearance" },
				RequiredActiveShrinePointsMin = 2,
				RequiredFalseFlags = { "HardMode" },
				{ Cue = "/VO/MegaeraField_0172", Speaker = "NPC_FurySister_01",
					Text = "{#DialogueItalicFormat}Tsch{#PreviousFormat}. I can't believe it. You signed the Pact of Punishment. Have you completely lost your mind? Or just trying to insult me?" },
				{ Cue = "/VO/ZagreusField_1389", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well if you're going to be so rude about it, maybe a little of each? Though, what do you even care which pacts I sign or don't?" },
				{ Cue = "/VO/MegaeraField_0173", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I'm not an idiot. I see what you're doing. You want to be punished? Then, come on." },
			},
			FuryPactReaction01_B =
			{
				PlayOnce = true,
				RequiredTrueFlags = { "ShrineUnlocked" },
				RequiredTextLines = { "FuryFirstAppearance" },
				RequiredFalseTextLines = { "MegaeraGift03" },
				RequiredActiveShrinePointsMin = 2,
				RequiredTrueFlags = { "HardMode" },
				{ Cue = "/VO/MegaeraField_0722", Speaker = "NPC_FurySister_01",
					Text = "{#DialogueItalicFormat}Tsch{#PreviousFormat}. You really volunteered into a Pact of Punishment? You can't back out of it, now. You're even more of a fool than I already thought." },
				{ Cue = "/VO/ZagreusField_4306", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Maybe I just like a challenge, ever thought of that? Besides, what do you even care which pacts I sign or don't?" },
				{ Cue = "/VO/MegaeraField_0723", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're right. I {#DialogueItalicFormat}don't {#PreviousFormat}care. You want to be punished? Then, come on." },
			},
			FuryPactReaction02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryFirstAppearance", "FuryPactReaction01" },
				RequiredTrueFlags = { "ShrineUnlocked" },
				RequiredFalseTextLines = { "BecameCloseWithMegaera01", "BecameCloseWithMegaera01_B" },
				RequiredFalseFlags = { "HardMode" },
				RequiredActiveShrinePointsMin = 4,
				{ Cue = "/VO/MegaeraField_0390", Speaker = "NPC_FurySister_01",
					Text = "I have been longing for a fairer fight with you. Maybe that's why you signed the Pact? To pity me?" },
				{ Cue = "/VO/ZagreusField_1397", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "I have my reasons. Pitying you isn't one of them. Although I guess you don't believe me, do you?" },
				{ Cue = "/VO/MegaeraField_0391", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "If it's punishment you want, how am I to say no?" },
			},
			FuryPactReaction02_B =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryFirstAppearance", "FuryPactReaction01_B" },
				RequiredTrueFlags = { "ShrineUnlocked" },
				RequiredAnyTextLines = { "BecameCloseWithMegaera01", "BecameCloseWithMegaera01_B" },
				RequiredTrueFlags = { "HardMode" },
				RequiredActiveShrinePointsMin = 10,
				RequiredMinActiveMetaUpgradeLevel = { Name = "EnemyDamageShrineUpgrade", Count = 1 },
				{ Cue = "/VO/MegaeraField_0724", Speaker = "NPC_FurySister_01",
					Text = "You know I can hit even harder than usual with the Pact of Punishment working against you. Maybe that's why you signed it? To pity me?" },
				{ Cue = "/VO/ZagreusField_1397", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "I have my reasons. Pitying you isn't one of them. Although I guess you don't believe me, do you?" },
				{ Cue = "/VO/MegaeraField_0725", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "No, I don't think I do. Come on, then, and let's see where all your pity gets you." },
			},
			-- PactReaction3 moved up
			FuryPactReaction04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryFirstAppearance" },
				RequiredTrueFlags = { "ShrineUnlocked" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "EnemySpeedShrineUpgrade", Count = 2 },
				{ Cue = "/VO/MegaeraField_0756", Speaker = "NPC_FurySister_01",
					Text = "This should be over pretty quickly, I think, Zag. Never took you for the Forced Overtime type. That's not a Pact condition for the faint of heart." },
				{ Cue = "/VO/ZagreusField_4317", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You wound me, Meg! You know I like to barge into situations thoughtlessly and recklessly, and sort everything out later. Forced Overtime's the perfect fit!" },
				{ Cue = "/VO/MegaeraField_0757", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Ahh{#PreviousFormat}, well, when you put it that way. Look, don't go saying I didn't warn you." },
			},

			FuryChaosReaction01 =
			{
				PlayOnce = true,
				RequiredGodLoot = "TrialUpgrade",
				RequiredTextLines = { "FuryFirstAppearance" },
				RequiredFalseTextLines = { "NyxAboutChaos06" },
				{ Cue = "/VO/MegaeraField_0382", Speaker = "NPC_FurySister_01",
					Text = "Hold it, Zagreus. I sense something, is that... {#DialogueItalicFormat}ah{#PreviousFormat}. You've been in contact with Chaos. So even they are now involved with this." },
				{ Cue = "/VO/ZagreusField_1393", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Just because Chaos is giving me the power to crush you doesn't mean they're getting involved with this, does it?" },
				{ Cue = "/VO/MegaeraField_0383", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You don't know who or what you're dealing with. Ask Nyx about them for me sometime. Here, I'll give you a chance to ask her very soon." },
			},

			FuryThanatosReaction01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "ThanatosFirstAppearance", "FuryFirstAppearance" },
				RequiredFalseTextLines = { "ThanatosGift07_A" },
				RequiredEncounterThisRun = "ThanatosTartarus",
				{ Cue = "/VO/MegaeraField_0392", Speaker = "NPC_FurySister_01",
					Text = "I know that Thanatos assisted you in getting to this point. I don't appreciate his interference." },
				{ Cue = "/VO/ZagreusField_1405", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm sure you'll have a chance to tell him back at home." },
				{ Cue = "/VO/MegaeraField_0393", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "He has domain over the wretched shades, but his power has no sway with me. And neither does your own." },
			},
			FuryThanatosReaction02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "ThanatosFirstAppearance", "ThanatosGift06", "MegaeraGift01" },
				RequiredEncounterThisRun = "ThanatosTartarus",
				RequiredFalseTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0394", Speaker = "NPC_FurySister_01",
					Text = "I still cannot believe that Thanatos is helping you. I mistook him for someone with integrity." },
				{ Cue = "/VO/ZagreusField_1406", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You mistook him for someone who blindly follows orders without considering the implications." },
				{ Cue = "/VO/MegaeraField_0395", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "How dare you...! If you like death so much, then here, let me indulge you. Thanatos will welcome you with open arms." },
			},

			FuryHighRelationship01 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "BecameCloseWithMegaera01", "BecameCloseWithMegaera01_B" },
				{ Cue = "/VO/MegaeraField_0726", Speaker = "NPC_FurySister_01",
					Text = "Prince Zagreus, you are trespassing beyond the limits of your authority. I am under orders to stop you." },
				{ Cue = "/VO/ZagreusField_4307", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Come on, Meg, why so formal all of a sudden? We've been through this countless times. Wait, is it because...?" },
				{ Cue = "/VO/MegaeraField_0727", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, come on, Zag. Will you just learn to play along, for once? Come on and fight me like you mean it." },
			},
			FuryHighRelationship02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryHighRelationship01" },
				RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" },
				MinRunsSinceAnyTextLines = { TextLines = { "FuryHighRelationship01" }, Count = 2 },
				RequiredInactiveMetaUpgrade = "BossDifficultyShrineUpgrade",
				{ Cue = "/VO/MegaeraField_0728", Speaker = "NPC_FurySister_01",
					Text = "What is it, Zagreus? You look a little hesitant to go another round with me. Or is it my imagination?" },
				{ Cue = "/VO/ZagreusField_4308", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Well, it's just... can we really keep the personal and the professional completely separate like this, Meg? It's with mixed emotions that I fight you to the death, only to be happy to see you back at the House." },
				{ Cue = "/VO/MegaeraField_0729", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Then learn to keep your emotions in check. You keep them bottled up a while, they'll be that much stronger when it's time to let them out." },
			},

			FuryEncounterFistWeapon02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounterFistWeapon01" },
				RequiredAnyTextLines = { "BecameCloseWithMegaera01", "BecameCloseWithMegaera01_B" },				
				RequiredWeapon = "FistWeapon",
				{ Cue = "/VO/MegaeraField_0752", Speaker = "NPC_FurySister_01",
					Text = "Nice gloves, there, Zagreus. Think you can take me up close with those things? Well within striking distance of my whip." },
				{ Cue = "/VO/ZagreusField_4315", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Not wearing them for fashion's sake, here, Meg. You won't mind if I give you my best shot with Malphon here, will you?" },
				{ Cue = "/VO/MegaeraField_0753", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I'd mind if you didn't. Want to get your hands dirty, fine. Let's see it." },
			},

			FuryAboutWeaponEnchantments01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter02" },
				RequiredWeapon = "SwordWeapon",
				RequiredLastInteractedWeaponUpgradeMaxed = true,
				{ Cue = "/VO/MegaeraField_0427", Speaker = "NPC_FurySister_01",
					Emote = "PortraitEmoteSurprise",
					Text = "What happened to your weapon, Zagreus? I sensed its power long before you turned up. That isn't just some Daedalus enchantment on it." },
				{ Cue = "/VO/ZagreusField_2739", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, Stygius and I have been getting much more closely acquainted lately, Meg. Would you care to see the fruits of our healthy symbiotic relationship?" },
				{ Cue = "/VO/MegaeraField_0428", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You, in a healthy relationship? Why yes, then this I have to see." },
			},

			FuryKeepsakeReaction01 =
			{
				PlayOnce = true,
				RequiredKeepsake = "LowHealthDamageTrait",
				{ Cue = "/VO/MegaeraField_0732", Speaker = "NPC_FurySister_01",
					Text = "Nice earring, Zagreus. Maybe I should have thought twice before giving you a thing like that." },
				{ Cue = "/VO/ZagreusField_4310", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Why, because the gift you generously gave me may end up being instrumental in your own demise? Sounds straight out of one of those tales the mortals like to go spreading around." },
				{ Cue = "/VO/MegaeraField_0733", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "They like it when best-laid plans fall completely to pieces, don't they? You better grow to like it, too." },
			},

			FuryThanatosKeepsakeReaction01 =
			{
				PlayOnce = true,
				RequiredKeepsake = "PerfectClearDamageBonusTrait",
				{ Cue = "/VO/MegaeraField_0431", Speaker = "NPC_FurySister_01",
					Text = "I sense something of death upon you, Zagreus. What's that you have, something from Thanatos is it?" },
				{ Cue = "/VO/ZagreusField_2741", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, this old thing? It's just a listless butterfly Than gave me, which happens to fill me with even more supernatural strength than usual. Don't pay it any mind." },
				{ Cue = "/VO/MegaeraField_0432", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Not even Thanatos can help you here. But if I ever start a bug collection, I'll know who to call." },
			},

			-- should come before the event below
			FuryLegendaryKeepsakeReaction01_B =
			{
				PlayOnce = true,
				RequiredFalseTextLines = { "FuryLegendaryKeepsakeReaction01" },
				RequiredAssistKeepsake = "FuryAssistTrait",
				{ Cue = "/VO/MegaeraField_0734", Speaker = "NPC_FurySister_01",
					Text = "You know Battie's not going to work here, don't you? I'm definitely not going to help you out of this one." },
				{ Cue = "/VO/ZagreusField_4311", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Come on, Meg, you can do anything if you set your mind to it! Though, don't worry, Battie's just here for the show." },
				{ Cue = "/VO/MegaeraField_0735", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Then, let's make it a good one. Come on." },
			},
			FuryLegendaryKeepsakeReaction01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryLegendaryKeepsakeReaction01_B" },
				RequiredAssistKeepsake = "FuryAssistTrait",
				{ Cue = "/VO/MegaeraField_0443", Speaker = "NPC_FurySister_01",
					Text = "Your little bat companion not too much to handle, is she, Zagreus? I trust you're taking excellent care of her. Not that she needs your help." },
				{ Cue = "/VO/ZagreusField_2747", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh she's been positively perfect, thank you, Meg. Especially in how she puts us into contact when I need a hand. I hope it's not too much hassle, helping out from time to time?" },
				{ Cue = "/VO/MegaeraField_0444", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "If you were hoping to avoid a hassle, you've definitely come to the wrong place." },
			},

			FuryLowHealth01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryFirstAppearance" },
				RequiredMaxHealthFraction = 0.33,
				RequiredMaxLastStands = 0,
				{ Cue = "/VO/MegaeraField_0384", Speaker = "NPC_FurySister_01",
					Text = "Look at yourself, Zagreus, you are a total mess. Halfway to death or worse. You're making this too easy." },
				{ Cue = "/VO/ZagreusField_1394", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Hit a few snags on my way to meet you, Meg. So, if you wouldn't mind going easy on me this one?" },
				{ Cue = "/VO/MegaeraField_0385", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Not on your life or death. But I will kill you quickly, how's that?" },
			},
			FuryLowHealth02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryFirstAppearance" },
				RequiredMaxHealthFraction = 0.33,
				RequiredMaxLastStands = 0,
				{ Cue = "/VO/MegaeraField_0386", Speaker = "NPC_FurySister_01",
					Text = "You're wounded, Zagreus. How unbecoming of a god. Not to mention that I have the upper hand." },
				{ Cue = "/VO/ZagreusField_1395", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I figured I'd give you a head start this time, so I let the wretched shades bludgeon me repeatedly along the way." },
				{ Cue = "/VO/MegaeraField_0387", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Fool. If you're half-dead already by the time you get to me, what hope can you possibly have for what lies ahead?" },
			},
			FuryLowHealth03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryFirstAppearance" },
				RequiredMaxHealthFraction = 0.65,
				RequiredTextLines = { "MegaeraWithHypnos01" },
				{ Cue = "/VO/MegaeraField_0388", Speaker = "NPC_FurySister_01",
					Text = "You look like you had trouble getting to me, Zagreus. Did you try asking for directions on the way?" },
				{ Cue = "/VO/ZagreusField_1396", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "You sound like Hypnos. He's getting to you, isn't he. Isn't he!" },
				{ Cue = "/VO/MegaeraField_0389", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You shut your mouth right now, with that. Come die." },
			},
			FuryLowHealth04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryFirstAppearance" },
				RequiredRoomLastRun = "B_Intro",
				RequiredMaxHealthFraction = 0.5,
				RequiredMaxLastStands = 1,
				{ Cue = "/VO/MegaeraField_0433", Speaker = "NPC_FurySister_01",
					Text = "You're not escaping death this time, here, Zagreus. You ready to go home?" },
				{ Cue = "/VO/ZagreusField_2742", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "No, not just yet, though thanks for asking, Meg. If you intend to force me, know that I am going to resist, with all my might." },
				{ Cue = "/VO/MegaeraField_0434", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Well I appreciate the warning. Now prepare to die." },
			},
		},

		BossPresentationTextLineSets =
		{
			FuryEncounter01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/MegaeraField_0006", Speaker = "NPC_FurySister_01",
					Text = "Ever stubborn, aren't you. Maybe my whip might make you reconsider whatever it is that you're attempting here." },
				{ Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag", Cue = "/VO/ZagreusField_0462",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Your whip's not been all that persuasive in the past." },
				{ Cue = "/VO/MegaeraField_0007", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Maybe persistence will pay off for both of us. Come, then." },
			},

			FuryEncounter02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter01" },
				RequiredFalseTextLines = { "MegaeraGift07" },
				{ Cue = "/VO/MegaeraField_0008", Speaker = "NPC_FurySister_01",
					Text = "And there you are again. Lord Hades ought to lock you up rather than let you run amok in his domain like this." },
				{ Cue = "/VO/ZagreusField_0505", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm sure he'd welcome all this feedback from you, Meg. Or maybe you're just pining for my father's job?" },
				{ Cue = "/VO/MegaeraField_0009", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I have no envy for your father's position. Besides, I happen to enjoy my own responsibilities." },
			},

			FuryEncounter03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter02" },
				RequiredFalseTextLines = { "MegaeraGift10" },
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0010", Speaker = "NPC_FurySister_01",
					Text = "Oh, there you are. Just as I was beginning to think it's been too long since last I killed you, Zag." },
				{ Cue = "/VO/ZagreusField_0506", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Admit it, Meg. You can't stop thinking about me." },
				{ Cue = "/VO/MegaeraField_0011", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Don't flatter yourself. I think of you in pain. And now there's no more need for the imagination." },
			},

			FuryEncounter04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter02" },
				{ Cue = "/VO/MegaeraField_0012", Speaker = "NPC_FurySister_01",
					Text = "Well, Zag? Any last requests this time before I send you home?" },
				{ Cue = "/VO/ZagreusField_0539", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "Let's see, how about a swift and painful death, would that be possible?" },
				{ Cue = "/VO/MegaeraField_0013", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Be cheeky all you like. You'll get exactly what you asked, and nothing more." },
			},

			-- fury win streak
			FuryWinStreak01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter04" },
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0018", Speaker = "NPC_FurySister_01",
					Text = "{#DialogueItalicFormat}Pff{#PreviousFormat}. And here you are again. You're slow to learn the way of things I see." },
				{ Cue = "/VO/ZagreusField_0510", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					Text = "I may be slow to learn, but... least I'm rather patient!" },
				{ Cue = "/VO/MegaeraField_0019", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "This talk about your patience is beginning to test mine. Enough! Come on and die." },
			},

			FuryWinStreak02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter02" },
				RequiredActiveMetaPointsMin = 320,
				RequiredFalseTextLines = { "MegaeraGift07" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0016", Speaker = "NPC_FurySister_01",
					Text = "Give up already, Zag. Or I'll keep killing you each time you come this far." },
				{ Cue = "/VO/ZagreusField_0509", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					Text = "I have some bad news for you, Meg. Little by little, I'm getting stronger." },
				{ Cue = "/VO/MegaeraField_0017", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "That may be so. But you will never be my equal. Ever. You'd do well to remember that." },
			},

			FuryWinStreak03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter02" },
				RequiredFalseKills = { "Harpy" },
				{ Cue = "/VO/MegaeraField_0014", Speaker = "NPC_FurySister_01",
					Text = "You're never getting past me, Zagreus." },
				{ Cue = "/VO/ZagreusField_0508", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "While that's probably the case... maybe I will this time." },
				{ Cue = "/VO/MegaeraField_0015", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Keep telling yourself that. Maybe it'll help take your mind off the pain that is to come." },
			},

			-- fury lose streak
			FuryLoseStreak01 =
			{
				PlayOnce = true,
				RequiredRoomLastRun = "B_Intro",
				RequiredFalseSeenRooms = { "C_Intro" },
				{ Cue = "/VO/MegaeraField_0021", Speaker = "NPC_FurySister_01",
					Text = "Even if you manage to get past me, there's no getting out of Asphodel. You saw what it was like. You really want to go back there?" },
				{ Cue = "/VO/ZagreusField_0511", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It's not a matter of want. The way out is there in that direction, past the river of flame." },
				{ Cue = "/VO/MegaeraField_0022", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're more stubborn than your father. I never thought that such a thing was possible." },
			},

			FuryLoseStreak02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter04" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 2,
				},
				{ Cue = "/VO/MegaeraField_0020", Speaker = "NPC_FurySister_01",
					PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Finally, you're back. You won't get past me like you did last time. Though, I would like to see you try." },
			},

			-- high relationship status / high affinity
			FuryPreMatchHighAffinity01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter02", "MegaeraGift06" },
				{ Cue = "/VO/MegaeraField_0027", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Well, Zag? May I have this dance for old time's sake?" },
			},
			FuryPreMatchHighAffinity02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryEncounter02", "MegaeraGift05" },
				{ Cue = "/VO/MegaeraField_0028", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You ready for me this time, Zagreus? Come on and fight. No holding back." },
			},
			FuryPreMatchHighAffinity03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryPreMatchHighAffinity01", "FuryPreMatchHighAffinity02", "MegaeraGift05", },
				{ Cue = "/VO/MegaeraField_0029", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I guess we know the drill by now, don't we. Not that I don't enjoy our little arguments, in my own way." },
			},
		},

		-- following are short misc repeatable evergreen combat start lines
		BossPresentationRepeatableTextLineSets =
		{
			-- multi fury lines - both sisters
			FurySistersUnionRepeatable01 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Tisiphone", "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0196", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "He's here, Alecto. Tis. Let's get him, now." },
			},
			FurySistersUnionRepeatable02 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Tisiphone", "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0197", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Prepare yourselves, Sisters. And you, too, Zag." },
			},
			FurySistersUnionRepeatable03 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Tisiphone", "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0198", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Together this time, Sisters. Go!" },
			},
			FurySistersUnionRepeatable04 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Tisiphone", "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0199", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Alecto. Tisiphone. Our guest is here." },
			},
			FurySistersUnionRepeatable05 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Tisiphone", "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0200", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "He's here. Let's get to work, Sisters." },
			},
			FurySistersUnionRepeatable06 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Tisiphone", "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0201", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Well, Sisters? We have a reputation to uphold." },
			},
			FurySistersUnionRepeatable07 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Tisiphone", "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0546", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You ready, Sisters? There he is. Now, on my mark." },
			},
			-- 8 missing
			FurySistersUnionRepeatable09 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Tisiphone", "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0547", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "All right, Sisters, let's show him what we've got." },
			},
			FurySistersUnionRepeatable10 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Tisiphone", "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0548", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Alecto, Tis, he's mine. Just back me up." },
			},
			FurySistersUnionRepeatable11 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Tisiphone", "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0549", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "No time for further talk, now, Sisters. Take him, now." },
			},
			FurySistersUnionRepeatable12 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Tisiphone", "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0550", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "No quarter now or ever, Erinyes. Attack!" },
			},

			-- multi fury lines - one sister
			FurySisterUnionRepeatable01 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0202", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Are you ready, Sister? Let's take care of him." },
			},
			FurySisterUnionRepeatable02 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0203", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Come, Sister, it's time to get to work." },
			},
			FurySisterUnionRepeatable03 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0204", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "He's here, Sister. Let's go." },
			},
			FurySisterUnionRepeatable04 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0205", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "It's him. Prepare yourself, Sister." },
			},
			FurySisterUnionRepeatable05 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredSupportAINames = { "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0551", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Alecto and I were just wondering when you'd arrive." },
			},
			FurySisterUnionRepeatable06 =
			{
				RequiredFalseTextLinesLastRun = { "FurySisterUnionSingleSis01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredSupportAINames = { "Alecto" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0552", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "See, Alecto? He is right on time, just as I said." },
			},
			FurySisterUnionRepeatable07 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredSupportAINames = { "Tisiphone" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0553", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You see, Tisiphone? He's here, just as I said." },
			},
			FurySisterUnionRepeatable08 =
			{
				RequiredFalseTextLinesLastRun = { "FurySisterUnionSingleSis02" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredSupportAINames = { "Tisiphone" },
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0554", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Heads up, Tisiphone. I think I found a murderer for you." },
			},
			FurySisterUnionRepeatable09 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0555", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Let's go, Sister. Together, we can take him." },
			},
			FurySisterUnionRepeatable10 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss01",
				{ Cue = "/VO/MegaeraField_0556", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "...Well, Sister, we'll have to finish catching up some other time." },
			},

			-- for high affinity
			FuryMiscStartHighAffinity01 =
			{
				RequiredAnyTextLines = { "MegaeraBedroom02", "MegaeraBedroom02B" },
				RequiredAnyOtherTextLines = { "BecameCloseWithMegaera01", "BecameCloseWithMegaera01_B" },
				{ Cue = "/VO/MegaeraField_0055", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I wish it didn't have to be this way." },
			},
			FuryMiscStartHighAffinity02 =
			{
				RequiredTextLines = { "MegaeraGift06" },
				RequiredAnyTextLines = { "BecameCloseWithMegaera01", "BecameCloseWithMegaera01_B" },
				{ Cue = "/VO/MegaeraField_0056", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Why must we always have to fight." },
			},
			FuryMiscStartHighAffinity03 =
			{
				RequiredTextLines = { "MegaeraGift06" },
				{ Cue = "/VO/MegaeraField_0057", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "It's time we had one of our little fights." },
			},
			FuryMiscStartHighAffinity04 =
			{
				RequiredTextLines = { "MegaeraGift06", },
				{ Cue = "/VO/MegaeraField_0058", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I so was hoping you'd show up just now." },
			},
			FuryMiscStartHighAffinity05 =
			{
				RequiredTextLines = { "MegaeraGift07", },
				{ Cue = "/VO/MegaeraField_0059", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Now that you're here, how about a little dance?" },
			},
			FuryMiscStartHighAffinity06 =
			{
				RequiredTextLines = { "MegaeraGift06", },
				{ Cue = "/VO/MegaeraField_0060", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "How about we go once more for old time's sake?" },
			},
			FuryMiscStartHighAffinity07 =
			{
				RequiredTextLines = { "MegaeraGift05", },
				{ Cue = "/VO/MegaeraField_0061", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You ready for me, Zagreus?" },
			},
			FuryMiscStartHighAffinity08 =
			{
				RequiredTextLines = { "MegaeraGift06", },
				{ Cue = "/VO/MegaeraField_0062", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "And here I was just wondering when you'd show up." },
			},
			FuryMiscStartHighAffinity09 =
			{
				RequiredTextLines = { "MegaeraGift06", },
				{ Cue = "/VO/MegaeraField_0063", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "And there he is at last, the Prince himself." },
			},
			-- fury win streak
			FuryMiscStartWinStreak01 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0042", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You've come to die to me again?" },
			},
			FuryMiscStartWinStreak02 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0043", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I killed you last time, I'll kill you again." },
			},
			FuryMiscStartWinStreak03 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0044", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I guess you want to die again?" },
			},
			FuryMiscStartWinStreak04 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0045", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "It seems you haven't learned your lesson yet." },
			},
			FuryMiscStartWinStreak05 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0046", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I hope you'll pose more of a threat this time." },
			},
			FuryMiscStartWinStreak06 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0194", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You don't seem to learn. Then, come and die." },
			},
			FuryMiscStartWinStreak07 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0195", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You aren't getting past me, Zagreus." },
			},
			-- fury lose streak
			FuryMiscStartLoseStreak01 =
			{
				RequiredFalseTextLines = { "MegaeraGift06" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0048", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I'll never stand aside for you." },
			},
			FuryMiscStartLoseStreak02 =
			{
				RequiredFalseTextLines = { "MegaeraGift10" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0049", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I'm back again, and I'll keep coming back." },
			},
			FuryMiscStartLoseStreak03 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0050", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You'll get past me over my dead body." },
			},
			FuryMiscStartLoseStreak04 =
			{
				RequiredFalseTextLines = { "MegaeraGift06" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0051", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I'm never going to back down from you." },
			},
			FuryMiscStartLoseStreak05 =
			{
				RequiredKills = { Harpy2 = 30 },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0053", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I guess we know how this is going to go." },
			},
			FuryMiscStartLoseStreak06 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0054", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I'm pledged to stand against you, Zagreus." },
			},
			FuryMiscStartLoseStreak07 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0206", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I will keep coming back, the same as you." },
			},
			FuryMiscStartLoseStreak08 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0207", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I will not stand aside for you, Zagreus." },
			},
			FuryMiscStartLoseStreak09 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 3,
				},
				{ Cue = "/VO/MegaeraField_0208", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Don't know if I can stop you anymore, but I can slow you down." },
			},
			FuryMiscStartLoseStreak10 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/MegaeraField_0209", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I'll get you back for what you did last time." },
			},
			FuryMiscStartLoseStreak11 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 4,
				},
				{ Cue = "/VO/MegaeraField_0742", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "One of these encounters, you'll let your guard down, and I'll kill you again for old time's sake." },
			},
			FuryMiscStartLoseStreak12 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 4,
				},
				{ Cue = "/VO/MegaeraField_0743", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Even if I can't stop you... I can get a few good hits in, I'm sure." },
			},
			FuryMiscStartLoseStreak13 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 5,
				},
				{ Cue = "/VO/MegaeraField_0744", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I've got a lot of payback to administer here, let me tell you, Zag." },
			},
			FuryMiscStartLoseStreak14 =
			{
				RequiredTextLines = { "MegaeraGift05" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 6,
				},
				{ Cue = "/VO/MegaeraField_0745", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Ungh{#PreviousFormat}, I've practically lost count how many times you beat me in a row here, Zag..." },
			},

			-- other general cases
			FuryMiscStart01 =
			{
				{ Cue = "/VO/MegaeraField_0032", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I thought you might show up." },
			},
			FuryMiscStart02 =
			{
				{ Cue = "/VO/MegaeraField_0033", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You're right on schedule." },
			},
			FuryMiscStart03 =
			{
				{ Cue = "/VO/MegaeraField_0034", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "No need for small talk, Zag." },
			},
			FuryMiscStart04 =
			{
				{ Cue = "/VO/MegaeraField_0035", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Up for another fight I see?" },
			},
			FuryMiscStart05 =
			{
				{ Cue = "/VO/MegaeraField_0036", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "What say we get things started." },
			},
			FuryMiscStart06 =
			{
				{ Cue = "/VO/MegaeraField_0037", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You ready for me, Zagreus?" },
			},
			FuryMiscStart07 =
			{
				{ Cue = "/VO/MegaeraField_0038", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Come on and show me what you've got." },
			},
			FuryMiscStart08 =
			{
				{ Cue = "/VO/MegaeraField_0039", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Let's go, then, Zagreus." },
			},
			FuryMiscStart09 =
			{
				{ Cue = "/VO/MegaeraField_0040", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I'm ready for you, Zag." },
			},
			FuryMiscStart10 =
			{
				{ Cue = "/VO/MegaeraField_0041", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Not one step further, Zag." },
			},
			FuryMiscStart11 =
			{
				{ Cue = "/VO/MegaeraField_0052", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I can't just let you off without a fight." },
			},
			FuryMiscStart12 =
			{
				{ Cue = "/VO/MegaeraField_0047", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "It's you again, is it." },
			},
			FuryMiscStart13 =
			{
				{ Cue = "/VO/MegaeraField_0190", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Come all this way again, just to see me." },
			},
			FuryMiscStart14 =
			{
				{ Cue = "/VO/MegaeraField_0191", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Get on your guard, Zagreus." },
			},
			FuryMiscStart15A =
			{
				RequiredTextLines = { "MegaeraGift03" },
				{ Cue = "/VO/MegaeraField_0192", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You're prompt sometimes, I have to give you that." },
			},
			FuryMiscStart15 =
			{
				{ Cue = "/VO/MegaeraField_0193", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Halt, Zagreus. Not one step further." },
			},

			-- max relationship
			FuryMiscStartMaxRelationship01 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0526", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Come for another round with me, Zagreus?" },
			},
			FuryMiscStartMaxRelationship02 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0527", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Let's see if you can make it past me, Zag." },
			},
			FuryMiscStartMaxRelationship03 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0528", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "No hard feelings, Zagreus. And don't you dare hold back." },
			},
			FuryMiscStartMaxRelationship04 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0529", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "One thing I like about you, Zag? You're always right on time." },
			},
			FuryMiscStartMaxRelationship06 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0530", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I hope you're ready for me this time, Zagreus." },
			},
			FuryMiscStartMaxRelationship07 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0531", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Don't think I'm going to go easy on you, Zagreus." },
			},
			FuryMiscStartMaxRelationship08 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0532", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You know it's strictly business here between us, don't you, Zag?" },
			},
			FuryMiscStartMaxRelationship09 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0533", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
				Text = "I expect you to give me the best you've got, Zagreus." },
			},
			FuryMiscStartMaxRelationship10 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0534", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "If you so much as think of going easy on me, Zagreus, I'll kill you." },
			},
			FuryMiscStartMaxRelationship11 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0535", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "No holding back against me, Zagreus. Certainly not here." },
			},
			FuryMiscStartMaxRelationship12 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0536", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You'll find I don't grow weary of these run-ins with you, Zag." },
			},
			FuryMiscStartMaxRelationship13 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0537", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You know I can't just let you walk away without a fight." },
			},
			FuryMiscStartMaxRelationship14 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0538", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You won't be getting out of here without a dance." },
			},
			FuryMiscStartMaxRelationship15 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0539", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "There's nothing you can do to hurt me, Zag. Though I would like to see you try." },
			},
			FuryMiscStartMaxRelationship16 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0540", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I'm starting to enjoy these little outings with you, Zag." },
			},
			FuryMiscStartMaxRelationship17 =
			{
				RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" },
				{ Cue = "/VO/MegaeraField_0541", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Come on, Zag. Come at me with everything you've got." },
			},
			FuryMiscStartMaxRelationship18 =
			{
				RequiredTextLines = { "MegaeraGift10" },
				{ Cue = "/VO/MegaeraField_0542", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "Do you want me, Zagreus? Then come and get me." },
			},
			FuryMiscStartMaxRelationship19 =
			{
				RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" },
				{ Cue = "/VO/MegaeraField_0543", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "I'll give you one thing, Zag. You never keep me waiting very long." },
			},
			FuryMiscStartMaxRelationship20 =
			{
				RequiredTextLines = { "MegaeraGift08" },
				{ Cue = "/VO/MegaeraField_0544", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "You're looking pretty good, there, Zag. Though let me see what I can do." },
			},
			FuryMiscStartMaxRelationship21 =
			{
				RequiredTextLines = { "MegaeraGift07" },
				{ Cue = "/VO/MegaeraField_0545", Speaker = "NPC_FurySister_01",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "FuryTaunt", PreLineWait = 0.35,
					Text = "No pleasure without pain, right, Zagreus?" },
			},

		},

		Binks =
		{
			"Enemy_Fury_Idle_Bink",
			"Enemy_Fury_Run_Bink",
			"Enemy_Fury_StartStop_Bink",
			"Enemy_Fury_Lunge_Bink",
			"Enemy_Fury_Beam_Bink",
			"Enemy_Fury_Lightning_Bink",
			"Enemy_Fury_WhipWhirl_Bink",
			"Enemy_Fury_Shielded_Bink",
			"Enemy_Fury_Dead_Bink",
			"Enemy_Fury_Taunt_Bink",

			"Enemy_Alecto_Taunt_Bink",
			"Enemy_Tisiphone_Taunt_Bink",
			"Enemy_AlectoMultiFuryHover_Bink",
			"Enemy_AlectoMultiFuryTakeOff_Bink",
			"Enemy_AlectoMultiFurySkyDive_Bink",
			"Enemy_TisiphoneMultiFuryHover_Bink",
			"Enemy_TisiphoneMultiFuryTakeOff_Bink",
			"Enemy_TisiphoneMultiFurySkyDive_Bink",

		},
	},

	-- Alecto
	Harpy2 =
	{
		InheritFrom = { "Harpy" },
		HealthBarTextId = "Harpy2_Full",
		Portrait = "Portrait_FurySister02_Default_01",
		SpawnAnimation = "AlectoTaunt_StartIdle",
		DeathAnimation = "FuryDeadAlecto",
		FightStartGlobalVoiceLines = "MultiFuryFightStartVoiceLines",
		ClearChillOnDeath = true,
		PermanentEnragedColorGrade = "AlectoRage",
		MaxHealth = 4600,
		ShrineDataOverwrites =
		{
			MaxHealth = 4900,
		},

		Groups = { "GroundEnemies", "FlyingEnemies" },
		--RageChargeDuration = 5,
		EnragedPresentation = "HarpyEnragedPresentation",
		RageDecayRate = 0.00,
		RageDecayStartDuration = 4.0,
		LastRageGainTime = 0,
		RageChargeMultiplier = 0.0,
		EnragedDuration = 12,
		EnragedMoveSpeedBonus = 200,
		EnragedWaitMultiplier = 0.65,

		DefaultAIData =
		{
		},
		WeaponOptions = { "HarpyLungeAlecto", "HarpyWhipArc", "HarpyBuildRage" },
		DisarmedWeapon = "HarpyLungeAlecto",
		RageWeapon = "HarpyEnrage",
		EndThreadWaitsOnDeath = "Harpy2Spawns",

		AdditionalEnemySetupFunctionName = "SelectHarpySupportAIs",

		ShrineMetaUpgradeName = "BossDifficultyShrineUpgrade",
		SupportAIWeaponSetOptions = { "Megaera", "Tisiphone" },

		SpawnOptions =
		{
		},

		AIEndHealthThreshold = 0.75,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				ThreadedFunctions = { "HandleHarpyRage", },

				AddSupportAIWeaponOptions =
				{
					Megaera = {
						"SummonMegaeraWhipWhirl"
					},
					Tisiphone = {
						"SummonTisiphoneBombingRun"
					},
				},

				AIData =
				{
					AIEndHealthThreshold = 0.75,
				},
				StageTransitionVoiceLines =
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.35,
					CooldownTime = 16,
					CooldownName = "AlectoSpokeRecently",

					-- That's it!
					-- { Cue = "/VO/Alecto_0166" },
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EquipRandomWeapon = { "HarpyLightningChase" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "Fury2ShieldedStart",
				AIData =
				{
					AIEndHealthThreshold = 0.50,
				},
				StageTransitionVoiceLines =
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.35,
					CooldownTime = 16,
					CooldownName = "AlectoSpokeRecently",

					-- That's it!
					-- { Cue = "/VO/Alecto_0166" },
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EquipRandomWeapon = { "HarpyWhipShot" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "Fury2ShieldedStart",

				AddSupportAIWeaponOptions =
				{
					Megaera = {
						"SummonMegaeraHarpyBeam"
					},
					Tisiphone = {
						"SummonTisiphoneFog"
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.25,
				},
				StageTransitionVoiceLines =
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.35,
					CooldownTime = 16,
					CooldownName = "AlectoSpokeRecently",

					-- That's it!
					-- { Cue = "/VO/Alecto_0166" },
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "Fury2ShieldedStart",
				ThreadedFunctions = { "EnrageHarpyPermanent" },
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				StageTransitionVoiceLines =
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.35,

					-- Now you've done it.
					-- { Cue = "/VO/Alecto_0169" },
				},
			},
		},

		AssistReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.8,
				Queue = "Interrupt",
				RequiredTrait = "ThanatosAssistTrait",
				RequiredRoom = "A_Boss02",

				-- What, Thanatos?!
				{ Cue = "/VO/Alecto_0415" },
				-- You bastard, Thanatos!
				{ Cue = "/VO/Alecto_0416", RequiredPlayed = { "/VO/Alecto_0415" }, },
				-- Get out of here, death god!
				{ Cue = "/VO/Alecto_0417", RequiredPlayed = { "/VO/Alecto_0415" }, },
				-- Not your fight, Thanatos!
				{ Cue = "/VO/Alecto_0418", RequiredPlayed = { "/VO/Alecto_0415" }, },
				-- Thanatos, again?
				{ Cue = "/VO/Alecto_0419", RequiredPlayed = { "/VO/Alecto_0415" }, },
				-- Thanatos!
				{ Cue = "/VO/Alecto_0420", RequiredPlayed = { "/VO/Alecto_0415" }, },
				-- Thanatos?!
				{ Cue = "/VO/Alecto_0421", RequiredPlayed = { "/VO/Alecto_0415" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.8,
				Queue = "Interrupt",
				RequiredTrait = "SkellyAssistTrait",
				RequiredRoom = "A_Boss02",

				-- Do I know you, dead man?!
				{ Cue = "/VO/Alecto_0422" },
				-- This idiot again?!
				{ Cue = "/VO/Alecto_0423", RequiredPlayed = { "/VO/Alecto_0422" }, },
				-- I didn't call for you!
				{ Cue = "/VO/Alecto_0424", RequiredPlayed = { "/VO/Alecto_0422" }, },
				-- How did he get in?!
				{ Cue = "/VO/Alecto_0425", RequiredPlayed = { "/VO/Alecto_0422" }, },
				-- Some friend you got, redblood!
				{ Cue = "/VO/Alecto_0426", RequiredPlayed = { "/VO/Alecto_0422" }, },
				-- That skeleton again!
				{ Cue = "/VO/Alecto_0427", RequiredPlayed = { "/VO/Alecto_0422" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.5,
				Queue = "Interrupt",
				RequiredTrait = "SisyphusAssistTrait",
				RequiredRoom = "A_Boss02",

				-- What in the hell was that?!
				{ Cue = "/VO/Alecto_0428" },
				-- I know that damn boulder!
				{ Cue = "/VO/Alecto_0429", RequiredPlayed = { "/VO/Alecto_0428" }, },
				-- The hell did that come from?!
				{ Cue = "/VO/Alecto_0430", RequiredPlayed = { "/VO/Alecto_0428" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				Queue = "Interrupt",
				RequiredOneOfTraits = { "ThanatosAssistTrait", "SkellyAssistTrait", "SisyphusAssistTrait", "DusaAssistTrait", "AchillesPatroclusAssistTrait" },
				RequiredRoom = "A_Boss02",

				-- You need some help, redblood?!
				{ Cue = "/VO/Alecto_0431" },
				-- Fight me yourself, redblood!
				{ Cue = "/VO/Alecto_0432" },
				-- Can't handle me yourself, huh?
				{ Cue = "/VO/Alecto_0433" },
				-- You again?
				{ Cue = "/VO/Alecto_0434" },
				-- You again!
				{ Cue = "/VO/Alecto_0435" },
				-- Get lost!
				{ Cue = "/VO/Alecto_0436" },
				-- Stay out of this, I said!
				{ Cue = "/VO/Alecto_0437" },
				-- Get out of here!!
				{ Cue = "/VO/Alecto_0438" },
				-- Oh don't you mess with me!
				{ Cue = "/VO/Alecto_0439" },
				-- The hell you doing here?
				{ Cue = "/VO/Alecto_0440" },
			},
		},

		CauseOfDeathVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.5,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				SuccessiveChanceToPlayAll = 0.33,
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				Source = { SubtitleColor = Color.AlectoVoice },

				-- We got him.
				{ Cue = "/VO/Alecto_0303" },
				-- We are the Furies.
				{ Cue = "/VO/Alecto_0304" },
				-- I guess we're finished here.
				{ Cue = "/VO/Alecto_0305" },
				-- He never stood a chance.
				{ Cue = "/VO/Alecto_0306" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.3,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				Source = { SubtitleColor = Color.AlectoVoice },
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss02",
				  Count = 2,
				},
				-- Come back again sometime!
				{ Cue = "/VO/Alecto_0232" },
				-- Until the next one, redblood.
				{ Cue = "/VO/Alecto_0233" },
				-- That never gets old, redblood.
				{ Cue = "/VO/Alecto_0234" },
				-- You know, I can get used to this!
				{ Cue = "/VO/Alecto_0235" },
				-- You don't have what it takes, redblood.
				{ Cue = "/VO/Alecto_0236" },
				-- Try not to waste my time again, hm?
				{ Cue = "/VO/Alecto_0237" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.3,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				Source = { SubtitleColor = Color.AlectoVoice },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 2,
				},
				-- Finally, whew.
				{ Cue = "/VO/Alecto_0238" },
				-- Was just a matter of time I guess.
				{ Cue = "/VO/Alecto_0239" },
				-- We fury sisters do like our revenge.
				{ Cue = "/VO/Alecto_0240" },
				-- About damn time I got my way with you.
				{ Cue = "/VO/Alecto_0241" },
				-- You better not be going easy on me, redblood.
				{ Cue = "/VO/Alecto_0242" },
				-- That was a sloppy fight even for you, redblood.
				{ Cue = "/VO/Alecto_0243" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.3,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				Source = { SubtitleColor = Color.AlectoVoice },

				-- Get out of here, redblood.
				{ Cue = "/VO/Alecto_0215" },
				-- See you next time, you trash.
				{ Cue = "/VO/Alecto_0216" },
				-- You're just like Megaera.
				{ Cue = "/VO/Alecto_0217" },
				-- I told you what was going to happen.
				{ Cue = "/VO/Alecto_0218" },
				-- Go on now back to daddy.
				{ Cue = "/VO/Alecto_0219" },
				-- Bye now, see you next time!
				{ Cue = "/VO/Alecto_0220" },
				-- Aw, we were just getting started.
				{ Cue = "/VO/Alecto_0221" },
				-- Right down the drain with you.
				-- { Cue = "/VO/Alecto_0222" },
				-- Aw, over so soon?
				{ Cue = "/VO/Alecto_0223" },
				-- Another piece of trash goes down the drain.
				{ Cue = "/VO/Alecto_0224" },
				-- Tell Daddy I said hi.
				{ Cue = "/VO/Alecto_0225" },
				-- Finally.
				{ Cue = "/VO/Alecto_0226" },
				-- All right, all right, that's enough.
				{ Cue = "/VO/Alecto_0227" },
				-- Satisfied? I am.
				{ Cue = "/VO/Alecto_0228" },
				-- Try harder!
				{ Cue = "/VO/Alecto_0208" },
				-- Weak.
				{ Cue = "/VO/Alecto_0209" },
				-- <Laughter>
				{ Cue = "/VO/Alecto_0231" },
				-- <Laughter>
				{ Cue = "/VO/Alecto_0229" },
				-- <Laughter>
				{ Cue = "/VO/Alecto_0230" },
			},
		},
		RageFullSound = "/SFX/SurvivalChallengeStart",
		RageFullVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			CooldownTime = 20,

			-- That's it!
			{ Cue = "/VO/Alecto_0166" },
			-- My turn.
			{ Cue = "/VO/Alecto_0167" },
			-- That does it!
			{ Cue = "/VO/Alecto_0168" },
			-- Now you've done it.
			{ Cue = "/VO/Alecto_0169" },
			-- Graahhh!
			{ Cue = "/VO/Alecto_0170" },
			-- Rrryaah!
			{ Cue = "/VO/Alecto_0171" },
			-- Raaahh!
			{ Cue = "/VO/Alecto_0172" },
			-- Enough of this!
			{ Cue = "/VO/Alecto_0173" },
			-- Why, you!
			{ Cue = "/VO/Alecto_0175" },
			-- Enough!
			{ Cue = "/VO/Alecto_0176" },
		},

		RageExpiredSound = "/Leftovers/World Sounds/MapZoomInShortHigh",
		RageExpiredVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			RequiresInRun = true,
			SuccessiveChanceToPlay = 0.33,

			-- Whew.
			{ Cue = "/VO/Alecto_0177" },
			-- Whew!
			{ Cue = "/VO/Alecto_0178" },
			-- Nrrgghh...
			{ Cue = "/VO/Alecto_0179" },
			-- Mmph.
			{ Cue = "/VO/Alecto_0180" },
		},

		InvulnerableHitSound = "/SFX/Enemy Sounds/Alecto/EmoteLaugh",
		InvulnerableVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			CooldownTime = 16,
			CooldownName = "AlectoSpokeRecently",

			-- I don't think so.
			-- { Cue = "/VO/Alecto_0207" },
			-- Not a chance.
			-- { Cue = "/VO/Alecto_0210" },
			-- Nice try.
			-- { Cue = "/VO/Alecto_0212" },
			-- No way.
			-- { Cue = "/VO/Alecto_0211" },
			-- Pshh.
			-- { Cue = "/VO/Alecto_0213" },
			-- Really?
			-- { Cue = "/VO/Alecto_0214" },
		},
		LowHealthVoiceLineThreshold = 0.6,
		LowHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			SuccessiveChanceToPlay = 0.33,
			CooldownTime = 16,
			CooldownName = "AlectoSpokeRecently",
			PreLineWait = 0.35,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- T'hah.
			{ Cue = "/VO/Alecto_0186", },
			-- You trash.
			{ Cue = "/VO/Alecto_0187", },
			-- Piece of trash.
			{ Cue = "/VO/Alecto_0188", },
			-- Tsch.
			{ Cue = "/VO/Alecto_0189", },
			-- Tsch, heh.
			{ Cue = "/VO/Alecto_0190", },
			-- Huh.
			{ Cue = "/VO/Alecto_0191", },
			-- Pff.
			{ Cue = "/VO/Alecto_0192", },
			-- You little.
			{ Cue = "/VO/Alecto_0193", },
			-- Really.
			{ Cue = "/VO/Alecto_0194", },
			-- Really?
			{ Cue = "/VO/Alecto_0195", },
			-- Felt that.
			{ Cue = "/VO/Alecto_0198", },
			-- Ow.
			{ Cue = "/VO/Alecto_0199", },
			-- Not bad.
			{ Cue = "/VO/Alecto_0200", },
			-- Pfah!
			{ Cue = "/VO/Alecto_0205", },
		},
		CriticalHealthVoiceLineThreshold = 0.3,
		CriticalHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			SuccessiveChanceToPlay = 0.33,
			CooldownTime = 16,
			CooldownName = "AlectoSpokeRecently",
			PreLineWait = 0.35,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- How dare you.
			{ Cue = "/VO/Alecto_0201", },
			-- Gah!
			{ Cue = "/VO/Alecto_0206", },
			-- Damn.
			{ Cue = "/VO/Alecto_0196", },
			-- Damn it.
			{ Cue = "/VO/Alecto_0197", },
			-- Urgh no.
			{ Cue = "/VO/Alecto_0202", },
			-- Augh damn!
			{ Cue = "/VO/Alecto_0203", },
			-- Ungh, you!
			{ Cue = "/VO/Alecto_0204", },
			-- Urgh.
			{ Cue = "/VO/Alecto_0184", },
			-- Hrrr.
			{ Cue = "/VO/Alecto_0185", },
		},
		DeathVoiceLines =
		{
			Queue = "Interrupt",
			{
				{ Cue = "/EmptyCue" }
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.45,
				SkipAnim = true,

				-- No way...!
				{ Cue = "/VO/Alecto_0244", RequiredPlayed = { "/VO/Alecto_0253" } },
				-- Damn, I--!
				{ Cue = "/VO/Alecto_0245", RequiredPlayed = { "/VO/Alecto_0253" } },
				-- How...!
				{ Cue = "/VO/Alecto_0246", RequiredPlayed = { "/VO/Alecto_0253" } },
				-- How...?!
				{ Cue = "/VO/Alecto_0247", RequiredPlayed = { "/VO/Alecto_0253" } },
				-- What...?!
				{ Cue = "/VO/Alecto_0248", RequiredPlayed = { "/VO/Alecto_0253" } },
				-- Gaah!
				{ Cue = "/VO/Alecto_0249", RequiredPlayed = { "/VO/Alecto_0253" } },
				-- I can't--!
				{ Cue = "/VO/Alecto_0250", RequiredPlayed = { "/VO/Alecto_0253" } },
				-- Again?!
				{ Cue = "/VO/Alecto_0251", RequiredPlayed = { "/VO/Alecto_0253" } },
				-- Ahh, why--!
				{ Cue = "/VO/Alecto_0252", RequiredPlayed = { "/VO/Alecto_0253" } },
				-- Why, you--!
				{ Cue = "/VO/Alecto_0253" },
				-- Ungh, damn...
				{ Cue = "/VO/Alecto_0254", RequiredPlayed = { "/VO/Alecto_0253" } },
				-- Damn you...
				{ Cue = "/VO/Alecto_0255", RequiredPlayed = { "/VO/Alecto_0253" } },
				-- Argh, how--!
				{ Cue = "/VO/Alecto_0256", RequiredPlayed = { "/VO/Alecto_0253" } },
			},
		},
		OnKillGlobalVoiceLines = "FuryVanquishedGlobalVoiceLines",
		KillsRequiredForVoiceLines = 1,

		PlayerInjuredVoiceLineThreshold = 0.5,
		PlayerInjuredVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.75,
			CooldownTime = 120,
			CooldownName = "AlectoSpokeRecently",

			-- Aw, did that hurt?
			{ Cue = "/VO/Alecto_0158" },
			-- How was that?
			{ Cue = "/VO/Alecto_0159" },
			-- That was nothing.
			{ Cue = "/VO/Alecto_0160" },
			-- You're bleeding.
			{ Cue = "/VO/Alecto_0161" },
			-- Remember that.
			{ Cue = "/VO/Alecto_0162" },
			-- I'll make you scream.
			{ Cue = "/VO/Alecto_0163" },
			-- I'll hurt you worse than that.
			{ Cue = "/VO/Alecto_0164" },
			-- I feel your pain.
			{ Cue = "/VO/Alecto_0165" },
			-- I'm going to kill you.
			{ Cue = "/VO/Alecto_0128" },
			-- I'll kill you yet.
			{ Cue = "/VO/Alecto_0129" },
			-- You'll die!
			{ Cue = "/VO/Alecto_0403" },
			-- Die!
			{ Cue = "/VO/Alecto_0411" },
			-- T'hah!
			{ Cue = "/VO/Alecto_0404" },
			-- Nrah, haha!
			{ Cue = "/VO/Alecto_0405" },
			-- Like that?!
			{ Cue = "/VO/Alecto_0406" },
			-- How's that!
			{ Cue = "/VO/Alecto_0407" },
			-- There!
			{ Cue = "/VO/Alecto_0408" },
			-- Want more?!
			{ Cue = "/VO/Alecto_0409" },
			-- Bleed!
			{ Cue = "/VO/Alecto_0410" },
			-- Oh we're not done!
			{ Cue = "/VO/Alecto_0412" },
			-- That hurt?
			{ Cue = "/VO/Alecto_0413" },
			-- You trash!
			{ Cue = "/VO/Alecto_0414" },
		},
		LastStandReactionVoiceLineMinHealthThreshold = 0.3,
		LastStandReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 2.1,
			CooldownTime = 16,
			Queue = "Always",

			-- Still standing huh.
			{ Cue = "/VO/Alecto_0121" },
			-- Die already.
			{ Cue = "/VO/Alecto_0122" },
			-- Still kicking?
			{ Cue = "/VO/Alecto_0123" },
			-- Still kicking are you.
			{ Cue = "/VO/Alecto_0124" },
			-- Still alive huh.
			{ Cue = "/VO/Alecto_0125" },
			-- I said die!
			{ Cue = "/VO/Alecto_0126" },
			-- Ooh, you're hurt.
			{ Cue = "/VO/Alecto_0127" },
			-- Aw, you're hurt.
			{ Cue = "/VO/Alecto_0130" },
			-- Not finished? Fine.
			{ Cue = "/VO/Alecto_0131" },
			-- You're as good as dead.
			{ Cue = "/VO/Alecto_0132", RequiredMaxLastStands = 0 },
			-- Nice trick.
			{ Cue = "/VO/Alecto_0133" },
			-- Give up.
			{ Cue = "/VO/Alecto_0134" },
			-- You're dead.
			{ Cue = "/VO/Alecto_0135" },
			-- You're mine.
			{ Cue = "/VO/Alecto_0136" },
			-- You won't last.
			{ Cue = "/VO/Alecto_0137", ConsecutiveDeathsInRoom = { Name = "A_Boss02", Count = 1, }, },
			-- Got you that time.
			{ Cue = "/VO/Alecto_0138", ConsecutiveClearsOfRoom = { Name = "A_Boss02", Count = 1, }, },
			-- I bet that hurt.
			{ Cue = "/VO/Alecto_0139" },
			-- For last time.
			{ Cue = "/VO/Alecto_0140", ConsecutiveClearsOfRoom = { Name = "A_Boss02", Count = 1, }, },
			-- Hah!
			{ Cue = "/VO/Alecto_0141" },
			-- I'll get you yet.
			{ Cue = "/VO/Alecto_0142" },
			-- Hurts, doesn't it?
			{ Cue = "/VO/Alecto_0143" },
		},
		WrathReactionVoiceLineMinHealthThreshold = 0.1,
		WrathReactionVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 1,
			CooldownTime = 30,
			SuccessiveChanceToPlayAll = 0.5,
			Queue = "Interrupt",

			-- Interesting...!
			{ Cue = "/VO/Alecto_0144" },
			-- Oho, hoh...!
			{ Cue = "/VO/Alecto_0145" },
			-- Angry now?
			{ Cue = "/VO/Alecto_0146" },
			-- Guess I hit a nerve.
			{ Cue = "/VO/Alecto_0147" },
			-- What's the matter?
			{ Cue = "/VO/Alecto_0148" },
			-- So...!
			{ Cue = "/VO/Alecto_0149" },
			-- So...
			{ Cue = "/VO/Alecto_0150" },
			-- What the--
			{ Cue = "/VO/Alecto_0151" },
			-- What the?
			{ Cue = "/VO/Alecto_0152" },
			-- Huh?
			{ Cue = "/VO/Alecto_0153" },
			-- Whoa.
			{ Cue = "/VO/Alecto_0154" },
			-- Easy, redblood.
			{ Cue = "/VO/Alecto_0155" },
			-- Ooh, you're mad!
			{ Cue = "/VO/Alecto_0156" },
			-- Relax, redblood.
			{ Cue = "/VO/Alecto_0157" },
		},

		BossPresentationPriorityIntroTextLineSets =
		{
			Fury2SisterUnion01 =
			{
				PlayOnce = true,
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera", "Tisiphone" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0055",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You ready, Megaera? Tisiphone? Let's go." },
			},
			Fury2SisterUnionSingleSis01 =
			{
				PlayOnce = true,
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0060",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Check it out, Sis! The god of trash is here. Let's get to work." },
			},
			Fury2SisterUnionWithMeg01 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "BecameCloseWithMegaera01", "BecameCloseWithMegaera01_B" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0323",
					Emote = "PortraitEmoteAnger",
					Text = "{#DialogueItalicFormat}Ugh{#PreviousFormat}, would you just {#DialogueItalicFormat}look {#PreviousFormat}at him! That smug look, that posture, {#DialogueItalicFormat}everything{#PreviousFormat}! Please tell me you're not going soft for this trash-god, Sister." },
				{ Cue = "/VO/MegaeraField_0423", Speaker = "NPC_FurySister_01", Portrait = "Portrait_FurySister01_Default_01",
					Text = "Come on, Alecto. When was the last time that we looked to one another for approval? Besides, as long as we kill him, what do you even care?" },
				{ Cue = "/VO/Alecto_0324", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", DoShake = true, WaitTime = 3.65 },
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You know, fair point, there, Sister! Very nicely said. {#DialogueItalicFormat}Let's kill him, now{#PreviousFormat}!" },
			},

			Fury2SisterUnionWithMeg02 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "Fury2SisterUnionWithMeg01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera" },
				MinRunsSinceAnyTextLines = { TextLines = { "Fury2SisterUnionWithMeg01" }, Count = 2 },
				-- for backward compatibility (event was originally named Fury3 not 2)
				RequiredFalseTextLines = { "Fury3SisterUnionWithMeg02" },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss02",
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0325",
					Text = "Look at this awful piece of trash, come here again to bleed all over our nice shiny floor. Ready to fight my lovely sister, there, redblood?" },
				{ Cue = "/VO/MegaeraField_0424", Speaker = "NPC_FurySister_01", Portrait = "Portrait_FurySister01_Default_01",
					Text = "He's not so awful once you get to know him, Sis. Not that it matters for what we're about to do." },
				{ Cue = "/VO/Alecto_0326", PreLineWait = 0.35,
					Emote = "PortraitEmoteDepressed",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "The both of you disgust me, Meg, you know that? Get it together and {#DialogueItalicFormat}kill {#PreviousFormat}him this time, damn you!" },
			},

			Fury2PactReaction01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2FirstAppearance" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredFalseFlags = { "HardMode" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0327",
					Text = "You must have gone and signed a Pact! Isn't that right, redblood? Tell me right now." },
				{ Cue = "/VO/ZagreusField_3808", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Well, as a matter of fact, I have. Though I don't see how that's any business of yours, Alecto." },
				{ Cue = "/VO/Alecto_0328",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteAnger",
					Text = "I like working {#DialogueItalicFormat}alone{#PreviousFormat}! And you don't see me doing that, right now, do you? So I would say it's my business, all right. Along with killing {#DialogueItalicFormat}you{#PreviousFormat}!" },
			},

			Fury2PactDisabledReaction01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2PactReaction01" },
				RequiredInactiveMetaUpgrade = "BossDifficultyShrineUpgrade",
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0329",
					Emote = "PortraitEmoteCheerful",
					Text = "{#DialogueItalicFormat}Whew{#PreviousFormat}, I thought I'd never get some quiet time again, you know, redblood? That damned Pact you stupidly agreed to, making me work with my sisters again. I'll get you for that!" },
				{ Cue = "/VO/ZagreusField_3809", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm sensing a pattern that it really doesn't take much for you to have something to {#DialogueItalicFormat}get {#PreviousFormat}me for, does it?" },
				{ Cue = "/VO/Alecto_0330",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, that's rich! How smart of you, you're {#DialogueItalicFormat}smart{#PreviousFormat}! Know what? I'll get you for that, too." },
			},

		},
		BossPresentationIntroTextLineSets =
		{
			Fury2FirstAppearance =
			{
				PlayOnce = true,
				PreEventWait = 0.4,
				PreLineFunctionName = "EmoteShockPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.1 },
				{ Cue = "/VO/Alecto_0002", Speaker = "NPC_FurySister_Unnamed_02", SpeakerLabelOffsetY = 18,
					Emote = "PortraitEmoteCheerful",
					Text = "{#DialogueItalicFormat}Ah, hah hah, hohohohohhh. {#PreviousFormat}Finally. I've been waiting for this! Really." },
				{ Cue = "/VO/ZagreusField_1408", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "You must be one of Megaera's lovely sisters, I don't believe we've had the pleasure. Waiting for what, exactly?" },
				{ Cue = "/VO/Alecto_0003", PreLineWait = 0.35,
					Text = "...So sick of, you know, doing my regular job, uninterrupted. Not having to clean up Meg's messes!" },
				{ Cue = "/VO/ZagreusField_1409", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					Text = "I get the feeling we're starting off on the wrong foot." },
				{ Cue = "/VO/Alecto_0004",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Anyway. I always wanted to kill a god. You'll have to do." },
			},

			Fury2PostEnding01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2FirstAppearance", "Ending01" },
				RequiredFalseSupportAINames = { "Megaera" },
				{ Cue = "/VO/Alecto_0441",
					Text = "Heard rumblings about some news back at your daddy's House, redblood. So his illustrious abducted Queen, she's come back home?!" },
				{ Cue = "/VO/ZagreusField_4300", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Wait, how do you even know all that? And should you really be talking about the Queen that way?" },
				{ Cue = "/VO/Alecto_0442",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I don't answer to her! She can come and go as she wants for all I care. But you want to know who can't?! Yeah, you." },
			},
			Fury2PostEnding02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2PostEnding01" },
				MinRunsSinceAnyTextLines = { TextLines = { "Fury2PostEnding01" }, Count = 10 },
				RequiredFalseSupportAINames = { "Megaera" },
				{ Cue = "/VO/Alecto_0445",
					Text = "I got to ask, how come you keep on showing up, redblood? I thought you would have had enough beatings by now." },
				{ Cue = "/VO/ZagreusField_4302", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well, you know, I've come to enjoy these visits with you so much, Alecto, that I've made it something of a regular routine. Form good habits, and then stick to them, I say!" },
				{ Cue = "/VO/Alecto_0446",
					Emote = "PortraitEmoteAnger",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You call this a good habit, huh? Maybe for me, it is. Well, come here all you like, and I will be here waiting, {#DialogueItalicFormat}every single time{#PreviousFormat}! About once every three times, anyway." },
			},
			Fury2PostEpilogue01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2PostEnding01", "OlympianReunionQuestComplete" },
				RequiredFalseSupportAINames = { "Megaera" },
				{ Cue = "/VO/Alecto_0443",
					Text = "Heard you had a real bash down in your daddy's House, redblood. So sorry I couldn't make it. Next time, though, all right?" },
				{ Cue = "/VO/ZagreusField_4301", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Next time, definitely, Alecto. We missed you for sure and wish you could have made it!" },
				{ Cue = "/VO/Alecto_0444",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Hohoho{#PreviousFormat}, I'm sure you did. But, you know, work comes first! So let's get busy." },
			},

			Fury2EndOfDiscussion01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2PostEpilogue01", "Fury2PostEnding02" },
				MinRunsSinceAnyTextLines = { TextLines = { "Fury2PostEpilogue01", "Fury2PostEnding02" }, Count = 2 },
				RequiredKills = { Harpy2 = 12 },
				RequiredFalseSupportAINames = { "Megaera" },
				{ Cue = "/VO/Alecto_0321",
					Text = "Hey, redblood. I have done a lot of thinking, and I've come to the conclusion that I want you {#DialogueItalicFormat}never {#PreviousFormat}to speak to me again. {#DialogueItalicFormat}Ever{#PreviousFormat}. Got that?" },
				{ Cue = "/VO/ZagreusField_3807", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "...{#DialogueItalicFormat}Erm{#PreviousFormat}, I don't know how to respond to what you said without directly disobeying your request, Alecto. But for future reference, fine, I'll bite." },
				{ Cue = "/VO/Alecto_0322",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteFiredUp",
					Text = "You'll {#DialogueItalicFormat}die{#PreviousFormat}! There's no use standing here flapping our gums when we could cut to killing one another right away. Come on!" },
			},

			Fury2LowHealth01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter02" },
				RequiredMaxHealthFraction = 0.5,
				RequiredMaxLastStands = 1,
				{ Cue = "/VO/Alecto_0313",
					Text = "{#DialogueItalicFormat}Ahh{#PreviousFormat}, look at you, redblood. You're practically already dead! Now that's no fun at all." },
				{ Cue = "/VO/ZagreusField_1421", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Sorry to disappoint you, Alecto. I know you enjoy being responsible for a hundred percent of my bloodshed." },
				{ Cue = "/VO/Alecto_0314",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, that's all right, no hard feelings at all! You just be sure to get in better health before next I get to kill you, hm?" },
			},
			Fury2LowHealth02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter02" },
				RequiredMaxHealthFraction = 0.5,
				RequiredMaxLastStands = 1,
				{ Cue = "/VO/Alecto_0315",
					Text = "You know I smelled your blood from three chambers away? Hope you saved some of it for me." },
				{ Cue = "/VO/ZagreusField_1422", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I've saved some of my blood, yes! Though I was thinking I'd hang onto it for now, if you don't mind." },
				{ Cue = "/VO/Alecto_0316",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteFiredUp",
					Text = "Do I look like someone who doesn't mind, trash god? I'll take your blood, however much you've got." },
			},
			Fury2LowHealth03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter02" },
				RequiredMaxHealthFraction = 0.5,
				RequiredMaxLastStands = 1,
				{ Cue = "/VO/Alecto_0317",
					Text = "What's the matter, redblood? You look a little paler than usual. Been bleeding much, having to get this far?" },
				{ Cue = "/VO/ZagreusField_1423", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I ran into some setbacks, if you have to know. But don't worry, I'm sure I've plenty left to bleed." },
				{ Cue = "/VO/Alecto_0318",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh {#DialogueItalicFormat}whew{#PreviousFormat}, that's a relief all right! I was so worried that I wasn't going to be the one to kill you this time." },
			},
			Fury2LowHealth04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter02" },
				RequiredMaxHealthFraction = 0.5,
				RequiredMaxLastStands = 1,
				{ Cue = "/VO/Alecto_0331",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're looking pretty beat already, there, redblood. So let's finish you off." },
			},
			Fury2LowHealth05 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter02" },
				RequiredMaxHealthFraction = 0.5,
				RequiredMaxLastStands = 1,
				{ Cue = "/VO/Alecto_0332",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Next time, don't you go losing so much blood before you get here, trash! I like to take it out of you myself." },
			},
		},

		BossPresentationTextLineSets =
		{
			Fury2MiscEncounter01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2FirstAppearance" },
				{ Cue = "/VO/Alecto_0005",
					Text = "You're no god! You're nothing but a piece of trash. Born into all of this. And you don't even want it!" },
				{ Cue = "/VO/ZagreusField_1410", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "You seem to have me all figured out. And here I thought we were still getting to know each other." },
				{ Cue = "/VO/Alecto_0006",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Tsch{#PreviousFormat}. Well. You want to know what I want? Here, I'll show you." },
			},
			Fury2MiscEncounter02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter01" },
				{ Cue = "/VO/Alecto_0007",
					Emote = "PortraitEmoteAffection",
					Text = "You know what I like about you? The way you bleed. {#DialogueItalicFormat}Mmm{#PreviousFormat}." },
				{ Cue = "/VO/ZagreusField_1411", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "That... is not the type of flattery I'm used to. You're making me a bit uncomfortable, I'll have you know." },
				{ Cue = "/VO/Alecto_0008",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Never met a god that bleeds like you. Red. Like a worthless mortal. Come on! Let's bleed you dry." },
			},
			Fury2MiscEncounter03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0009",
					Text = "Let's get to work, redblood, what do you say? Me, I say you've kept this girl waiting long enough." },
				{ Cue = "/VO/ZagreusField_1412", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well, I say I don't appreciate you calling me redblood. You're making me rather self-conscious about it, you know." },
				{ Cue = "/VO/Alecto_0010",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Oh, hoho{#PreviousFormat}, you're funny. But you'll break. They always do." },
			},
			Fury2MiscEncounter04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter03" },
				{ Cue = "/VO/Alecto_0011",
					Text = "I have got to admit, you are really frustrating, you know, redblood? What is it going to take to make you scream, hm?" },
				{ Cue = "/VO/ZagreusField_1413", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What, you mean to say Meg never told you? And here I thought you two were close." },
				{ Cue = "/VO/Alecto_0012",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Ehh{#PreviousFormat}, we'll find out. I've got plenty of ideas left I've been meaning to try." },
			},
			Fury2MiscEncounter05 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0013",
					Text = "You know something, redblood? In retrospect, I should have known this wasn't going to be a quick job." },
				{ Cue = "/VO/ZagreusField_1414", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "They say both gods and mortals are notoriously poor at estimating how long it takes to get anything done." },
				{ Cue = "/VO/Alecto_0014",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Normally when I'm on the job, they grovel, then they scream. They shut up eventually, but not you. At least, not yet." },
			},
			Fury2MiscEncounter06 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0019",
					Text = "{#DialogueItalicFormat}Huh{#PreviousFormat}! You really must like pain an awful lot, redblood. Or maybe it's just me." },
				{ Cue = "/VO/ZagreusField_1417", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "You see, Alecto? Turns out we do have a common interest after all." },
				{ Cue = "/VO/Alecto_0020",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteSurprise",
					Text = "Did you just--? Don't you {#DialogueItalicFormat}ever {#PreviousFormat}compare yourself to me again, you trash. You want more pain, I'm happy to oblige." },
			},
			Fury2MiscEncounter07 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter01", "Fury2MiscEncounter02", "Fury2MiscEncounter03", "Fury2MiscEncounter04", "Fury2MiscEncounter05", "Fury2MiscEncounter06" },
				{ Cue = "/VO/Alecto_0371",
					Text = "I've got a lot to be thankful for, you know, redblood? Your daddy could have shut you in the lowest pits, and then we never would have met!" },
				{ Cue = "/VO/ZagreusField_3819", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Perish the thought, Alecto. What would you have done with yourself if not for all our fated encounters?" },
				{ Cue = "/VO/Alecto_0372",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I don't know! I mean, before we met, I flayed all sorts of other trash down here! But lately I've been keeping them waiting, because of you." },
			},
			Fury2MiscEncounter08 =
			{
				PlayOnce = true,
				RequiredTextLines = { "FuryMetSisters01" },
				{ Cue = "/VO/Alecto_0373",
					Emote = "PortraitEmoteCheerful",
					Text = "Good job, redblood! You made it all this way! But, I have got to send you back to daddy, now. Nothing personal!" },
				{ Cue = "/VO/ZagreusField_3810", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Wish you could join me, Alecto. Want me to put in a good word with Father next time, so you can come visit us at the House yourself?" },
				{ Cue = "/VO/Alecto_0374",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, you know, I'd rather have my eyes put out, but thanks for offering! Now, time to head on home." },
			},
			Fury2MiscEncounter09 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter07" },
				RequiredFalseSupportAINames = { "Megaera" },
				{ Cue = "/VO/Alecto_0375",
					Text = "You know, redblood, my appointments usually don't come to {#DialogueItalicFormat}me{#PreviousFormat}, much less again and again! Think I'm here to show you a good time, huh?!" },
				{ Cue = "/VO/ZagreusField_3811", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Alecto, I just like to see you menacingly smile. And, hey, having to deal with you now and again beats having to fight Meg all the time." },
				{ Cue = "/VO/Alecto_0376",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteSurprise",
					Text = "{#DialogueItalicFormat}Whaa{#PreviousFormat}?! You think dealing with {#DialogueItalicFormat}me {#PreviousFormat}beats dealing with that {#DialogueItalicFormat}weakling{#PreviousFormat}? {#DialogueItalicFormat}Graaaah{#PreviousFormat}!" },
			},
			Fury2MiscEncounter10 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter09" },
				RequiredMinTimesSeenRoom = { A_Boss02 = 20 },
				{ Cue = "/VO/Alecto_0377",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", DoShake = true, WaitTime = 3.0 },
					Text = "How many times is it going to take, redblood? {#DialogueItalicFormat}How many{#PreviousFormat}?! Tell me! How can you stand running into me like this, over and over?" },
				{ Cue = "/VO/ZagreusField_3812", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well, habits can be hard to break. As for how many times, I've really no idea. Though I guess there's one way to find out." },
				{ Cue = "/VO/Alecto_0378",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I'll give you one thing... I like it when my prey bites back. Come on, let's see some blood again." },
			},

			Fury2AboutTisiphoneSpeech01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter09", "Fury3Encounter14" },
				RequiredFalseSupportAINames = { "Tisiphone" },
				{ Cue = "/VO/Alecto_0379",
					Text = "Tisiphone's started to say the strangest things, lately, redblood. You wouldn't happen to know anything about that, would you?" },
				{ Cue = "/VO/ZagreusField_3813", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Oh, don't fret. I was just trying to help her expand her somewhat limited vocabulary." },
				{ Cue = "/VO/Alecto_0380",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteAnger",
					Text = "Stay out of her head!! You really think she's got something to learn from you? Learn to shut up from her!" },
			},

			Fury2AboutMegaeraRelationship01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter09" },
				RequiredAnyTextLines = { "BecameCloseWithMegaera01_BMeg_GoToHer", "BecameCloseWithMegaera01Meg_GoToHer" },
				RequiredFalseSupportAINames = { "Megaera" },
				{ Cue = "/VO/Alecto_0381",
					Text = "{#DialogueItalicFormat}Eugh{#PreviousFormat}, still can't believe Megaera got mixed up with you, redblood. For all her weakness, I always thought at least she took her job here seriously. {#DialogueItalicFormat}Eh{#PreviousFormat}, live and learn!" },
				{ Cue = "/VO/ZagreusField_3814", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Not interested in your nasty remarks about her, Alecto. Though if you keep them up, I'm warning you, I might get mad." },
				{ Cue = "/VO/Alecto_0382",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteAffection",
					Text = "{#DialogueItalicFormat}Ohh{#PreviousFormat}, you might get {#DialogueItalicFormat}mad{#PreviousFormat}? Defend Megaera's honor, since she's far too weak to do it her damn self? You think she's so pure! {#DialogueItalicFormat}Hahaha{#PreviousFormat}! You're disgusting! Both of you." },
			},

			-- fury2 win streak
			Fury2WinStreak01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter02" },
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0015",
					Emote = "PortraitEmoteCheerful",
					Text = "Oh hey, redblood! You're back for more. I like that stubborn stupidness about you, honestly. If only I could keep you alive even longer this time." },
				{ Cue = "/VO/ZagreusField_1415", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What, you planning to kill me with insults this time?" },
				{ Cue = "/VO/Alecto_0016",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Haven't decided how just yet. This girl likes a little spontaneity." },
			},
			Fury2WinStreak02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter02" },
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0017",
					Text = "{#DialogueItalicFormat}Huh{#PreviousFormat}! Normally my marks don't make a habit of seeking me out again after I'm through with them." },
				{ Cue = "/VO/ZagreusField_1416", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "I can imagine that, it's just, I've really come to appreciate these little back-and-forth exchanges that we have." },
				{ Cue = "/VO/Alecto_0018",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Ugh{#PreviousFormat}, I do so hate to let you down like this, redblood. But you're just not my type. Maybe I'll finally get it through your head this time." },
			},

			Fury2LoseStreak01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter04" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 2,
				},
				{ Cue = "/VO/Alecto_0021",
					Text = "Know something, redblood? Try as I might, I still have not forgiven you for beating me last time. Call it a crippling character flaw, I don't know..." },
				{ Cue = "/VO/ZagreusField_1418", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Forgiveness can take time. Though self-reflection is a healthy step. We're making progress!" },
				{ Cue = "/VO/Alecto_0022",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 3 },					
					Text = "You think we're making progress? Here? {#DialogueItalicFormat}Ah, hah, ha-hah, ha-hah, ha-hah, {#PreviousFormat}why you piece of trash! I'll show you progress." },
			},
			Fury2LoseStreak02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter04" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 2,
				},
				{ Cue = "/VO/Alecto_0023",
					Text = "Redblood, I'm getting awful sick of seeing your smug face, time, after time, after time." },
				{ Cue = "/VO/ZagreusField_1419", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Have you given any thought to just... leaving me alone, and going back to wherever it is you came from?" },
				{ Cue = "/VO/Alecto_0024",
					Emote = "PortraitEmoteAnger",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You see? That is {#DialogueItalicFormat}exactly {#PreviousFormat}what I mean. To think that Megaera had to put up with you for, I don't know how long." },
			},
			Fury2LoseStreak03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter04" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 2,
				},
				{ Cue = "/VO/Alecto_0025",
					Text = "Damn you for this, redblood. You're making me look bad, you know? Making me {#DialogueItalicFormat}feel {#PreviousFormat}bad." },
				{ Cue = "/VO/ZagreusField_1420", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Alecto, I didn't ask you to repeatedly attempt to kill me. How did you expect me to respond?" },
				{ Cue = "/VO/Alecto_0026",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Ah-hahah-hahaha, hahah{#PreviousFormat}, you do know what happens when you make me {#DialogueItalicFormat}feel {#PreviousFormat}bad, don't you...? " },
			},
			Fury2LoseStreak04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury2MiscEncounter04" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0319",
					Text = "{#DialogueItalicFormat}Huh{#PreviousFormat}, it's the god of trash, come once again to filthy up this place! You're getting real predictable, you know." },
				{ Cue = "/VO/ZagreusField_3806", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Considering I beat you last we met, I'd be much more concerned with your predictability than mine." },
				{ Cue = "/VO/Alecto_0320",
					PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteAnger",
					Text = "Don't want to hear it from you, trash! Just want to see you bleed. Now you come here!" },
			},
		},

		BossPresentationRepeatableTextLineSets =
		{
			-- multi fury lines - both sisters
			Fury2SistersUnionRepeatable01 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera", "Tisiphone" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0054",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Ohh{#PreviousFormat}, there he is, sisters. It's time to get to work." },
			},
			Fury2SistersUnionRepeatable02 =
			{
				RequiredFalseTextLinesLastRun = { "Fury2SisterUnion01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera", "Tisiphone" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0055",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You ready, Megaera? Tisiphone? Let's go." },
			},
			Fury2SistersUnionRepeatable03 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera", "Tisiphone" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0056",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Let's tear him into shreds, sisters, come on!" },
			},
			Fury2SistersUnionRepeatable04 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera", "Tisiphone" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0057",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Hey, check it out, sisters, he's back. You ready?" },
			},
			Fury2SistersUnionRepeatable05 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera", "Tisiphone" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0058",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "He's come crawling back again, sisters. Let's get him, then." },
			},
			Fury2SistersUnionRepeatable06 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera", "Tisiphone" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0355",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "All right, sisters! Don't screw this up for me!" },
			},
			Fury2SistersUnionRepeatable07 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera", "Tisiphone" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0356",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "I'm taking point against this trash, sisters. You back me up." },
			},
			Fury2SistersUnionRepeatable08 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera", "Tisiphone" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0357",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "All three of us against {#DialogueItalicFormat}this {#PreviousFormat}trash, sisters? All right!" },
			},
			Fury2SistersUnionRepeatable09 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera", "Tisiphone" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0358",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "The three Furies up against the trash god! What a fight!" },
			},
			Fury2SistersUnionRepeatable09 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera", "Tisiphone" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0359",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Emote = "PortraitEmoteCheerful",
					Text = "Oh, {#DialogueItalicFormat}hohohohoho{#PreviousFormat}, look at him, sisters! Don't you just want to whip him all to shreds?!" },
			},
			Fury2SistersUnionRepeatable10 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredSupportAINames = { "Megaera", "Tisiphone" },
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0360",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Much as I love chatting with you, Meg, Tisiphone... our prey is here." },
			},

			-- multi fury lines - one sister
			Fury2SisterUnionRepeatable01 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0059",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You ready, Sis? This redblood's nothing to the both of us." },
			},
			Fury2SisterUnionRepeatable02 =
			{
				RequiredFalseTextLinesLastRun = { "Fury2SisterUnionSingleSis01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0060",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Check it out, Sis! The god of trash is here. Let's get to work." },
			},
			Fury2SisterUnionRepeatable03 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0061",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Well, Sis, what do you say we get started on him?" },
			},
			Fury2SisterUnionRepeatable04 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0062",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "There he is, Sis! I'm ready if you're ready." },
			},
			Fury2SisterUnionRepeatable05 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0361",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "All right, Sister! Let's rip him all to shreds!" },
			},
			Fury2SisterUnionRepeatable06 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0362",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You ready for him, Sister? I most definitely am!" },
			},
			Fury2SisterUnionRepeatable07 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0363",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You're never getting through the both of us without losing a lot of blood, trash god." },
			},
			Fury2SisterUnionRepeatable08 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredTextLines = { "Fury2MiscEncounter02" },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0364",
					Emote = "PortraitEmoteCheerful",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "My sis and I, we're going to tear you limb from limb, redblood!" },
			},
			Fury2SisterUnionRepeatable09 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0365",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Think you can scoot right past the both of us, trash god?!" },
			},
			Fury2SisterUnionRepeatable10 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredRoom = "A_Boss02",
				{ Cue = "/VO/Alecto_0366",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "All right, Sis! You just back me up against this trash!" },
			},

			-- alecto win streak
			Fury2MiscStartWinStreak01 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0063",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "I'll just keep killing you, redblood. Not that I mind!" },
			},
			Fury2MiscStartWinStreak02 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0064",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "What are we going to do with you this time, now, hm?" },
			},
			Fury2MiscStartWinStreak03 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0065",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "I'm impressed, redblood. You really never learn." },
			},
			Fury2MiscStartWinStreak04 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0066",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Turns out, killing the god of trash never gets old." },
			},
			Fury2MiscStartWinStreak05 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0067",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "How would you like to die this time, redblood? Here, let me guess." },
			},
			Fury2MiscStartWinStreak06 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0068",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You just don't get it, do you? Though I bet I can make you learn." },
			},
			-- alecto lose streak
			Fury2MiscStartLoseStreak01 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0069",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "I'm getting real sick of you, trash god. Come on!" },
			},
			Fury2MiscStartLoseStreak02 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0070",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Bad news for you, redblood. I like dying." },
			},
			Fury2MiscStartLoseStreak03 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0071",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Come on, redblood, let's see you kill me again!" },
			},
			Fury2MiscStartLoseStreak04 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0072",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You're stuck with me forever, trash. Remember that." },
			},
			Fury2MiscStartLoseStreak05 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0073",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "I'm really starting to hate you. You know that, redblood?" },
			},
			Fury2MiscStartLoseStreak06 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0074",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Why if it isn't the god of trash himself. I'm so honored." },
			},
			Fury2MiscStartLoseStreak07 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0075",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Good news for you, I'm in a real bad mood right now." },
			},
			Fury2MiscStartLoseStreak08 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0076",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Been looking forward to this chance to get you back, redblood." },
			},
			Fury2MiscStartLoseStreak09 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0077",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Heard you were in the area, and thought I'd take another stab at killing you." },
			},
			Fury2MiscStartLoseStreak10 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0078",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Redblood, I really don't appreciate what happened here last time." },
			},
			Fury2MiscStartLoseStreak11 =
			{
				RequiredKills = { Harpy2 = 6 },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0345",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You might get through me, trash god, but I'm going to spill your blood before you do!" },
			},
			Fury2MiscStartLoseStreak12 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss02",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0367",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Long as I slow you down, redblood, I've done my job." },
			},

			-- meg lose streak reaction
			Fury2MiscStartVsFuryLoseStreak01 =
			{
				RequiredRoomLastRun = "A_Boss01",
				RequiredFalseSupportAINames = { "Megaera" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0046",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You think just 'cause you got through Megaera, you'll get through me?" },
			},
			Fury2MiscStartVsFuryLoseStreak02 =
			{
				RequiredRoomLastRun = "A_Boss01",
				RequiredFalseSupportAINames = { "Megaera" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0047",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Your daddy never should have given Megaera this job." },
			},
			Fury2MiscStartVsFuryLoseStreak03 =
			{
				RequiredRoomLastRun = "A_Boss01",
				RequiredTextLines = { "Fury2MiscEncounter02" },
				RequiredFalseSupportAINames = { "Tisiphone", "Megaera" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0048",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Megaera couldn't make it, redblood, so it's me and you." },
			},
			Fury2MiscStartVsFuryLoseStreak04 =
			{
				RequiredRoomLastRun = "A_Boss01",
				RequiredTextLines = { "MegaeraGift08" },
				RequiredFalseSupportAINames = { "Megaera" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0049",
					Emote = "PortraitEmoteFiredUp",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Hah{#PreviousFormat}! It's Megaera's hot mess. Let's clean you up." },
			},
			-- tisiphone lose streak reaction
			Fury2MiscStartVsFury3LoseStreak01 =
			{
				RequiredRoomLastRun = "A_Boss03",
				RequiredFalseSupportAINames = { "Tisiphone" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss03",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0050",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You got Tisiphone, so what. Now I'll get you." },
			},
			Fury2MiscStartVsFury3LoseStreak02 =
			{
				RequiredRoomLastRun = "A_Boss03",
				RequiredTextLines = { "Fury2MiscEncounter02" },
				RequiredFalseSupportAINames = { "Tisiphone" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss03",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0051",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You mess with Tis, redblood, you mess with me, get it?" },
			},
			Fury2MiscStartVsFury3LoseStreak03 =
			{
				RequiredRoomLastRun = "A_Boss03",
				RequiredFalseSupportAINames = { "Tisiphone" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss03",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0052",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Tisiphone's been having problems with you, huh. Let's see if I can help." },
			},
			Fury2MiscStartVsFury3LoseStreak04 =
			{
				RequiredRoomLastRun = "A_Boss03",
				RequiredTextLines = { "Fury2MiscEncounter02" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "A_Boss03",
				  Count = 1,
				},
				{ Cue = "/VO/Alecto_0053",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Nobody messes with Tisiphone but me, redblood." },
			},
			-- other general cases
			Fury2MiscStart01 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0027",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "I'm going to enjoy this, redblood." },
			},
			Fury2MiscStart02 =
			{
				{ Cue = "/VO/Alecto_0028",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Just when I was beginning to feel bored." },
			},
			Fury2MiscStart03 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0029",
					Emote = "PortraitEmoteAnger",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "I'm going to tear you limb from limb, redblood." },
			},
			Fury2MiscStart04 =
			{
				{ Cue = "/VO/Alecto_0030",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "The Fates must want to spill your blood as much as I do." },
			},
			Fury2MiscStart05 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0031",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Time to die, again, redblood. Let's get to killing you." },
			},
			Fury2MiscStart06 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0032",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "This job never gets old, redblood, I can assure you that." },
			},
			Fury2MiscStart07 =
			{
				{ Cue = "/VO/Alecto_0033",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Well if it isn't the god of trash himself. Come die." },
			},
			Fury2MiscStart08 =
			{
				{ Cue = "/VO/Alecto_0034",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Good, I was getting real tired waiting around to kill you." },
			},
			Fury2MiscStart09 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0035",
					Emote = "PortraitEmoteAffection",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Aww{#PreviousFormat}, you came back all this way! I'm flattered, redblood." },
			},
			Fury2MiscStart10 =
			{
				{ Cue = "/VO/Alecto_0036",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Got some kind of deathwish, don't you. Fine." },
			},
			Fury2MiscStart11 =
			{
				{ Cue = "/VO/Alecto_0041",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Oh, thank the Fates I get to deal with you this time." },
			},
			Fury2MiscStart12 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0042",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Let's see what you can do, redblood. Come on!" },
			},
			-- renamed, previously 13
			Fury2MiscStart13A =
			{
				{ Cue = "/VO/Alecto_0043",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Well! Look who's back. The god of trash, himself." },
			},
			Fury2MiscStart13 =
			{
				{ Cue = "/VO/Alecto_0044",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Get ready for a bunch of pain and suffering, trash god." },
			},
			Fury2MiscStart14 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0045",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Whoa, whoa, whoa, hold it right there, redblood." },
			},
			Fury2MiscStart15 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0333",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Been waiting here to beat you to a bloody pulp, redblood!" },
			},
			Fury2MiscStart16 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0334",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Don't even open that damn mouth of yours, redblood. Except to scream." },
			},
			Fury2MiscStart17 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0335",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You must like pain, or something, don't you, there, redblood?" },
			},
			Fury2MiscStart18 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0336",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Somebody's dying soon, redblood! {#DialogueItalicFormat}Ohh{#PreviousFormat}, I can't wait." },
			},
			Fury2MiscStart19 =
			{
				{ Cue = "/VO/Alecto_0337",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Come give me everything you've got, trash god!" },
			},
			Fury2MiscStart20 =
			{
				{ Cue = "/VO/Alecto_0338",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Let's see what you're made of, trash god! Come on!" },
			},
			Fury2MiscStart21 =
			{
				{ Cue = "/VO/Alecto_0339",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Looks like my prayers to the god of trash have finally been answered, huh?!" },
			},
			Fury2MiscStart22 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0340",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "What's the matter, there, redblood? Gone awful quiet! Did I hurt your feelings, {#DialogueItalicFormat}huh{#PreviousFormat}?" },
			},
			Fury2MiscStart23 =
			{
				{ Cue = "/VO/Alecto_0341",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Ohh{#PreviousFormat}, I'm going to bleed you till you're dry." },
			},
			Fury2MiscStart24 =
			{
				{ Cue = "/VO/Alecto_0342",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You want to mess with me {#DialogueItalicFormat}again{#PreviousFormat}, redblood?! Well then, {#DialogueItalicFormat}come on{#PreviousFormat}!" },
			},
			Fury2MiscStart25 =
			{
				{ Cue = "/VO/Alecto_0343",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "How is it possible I am so sick of you, but never sick of {#DialogueItalicFormat}killing {#PreviousFormat}you, redblood?" },
			},
			Fury2MiscStart26 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0344",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Emote = "PortraitEmoteFiredUp",
					Text = "Step on it, redblood! I've got lots of other trash to whip, you know!" },
			},
			Fury2MiscStart27 =
			{
				{ Cue = "/VO/Alecto_0346",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "You want through that door back there, it's going to cost you blood!" },
			},
			Fury2MiscStart28 =
			{
				RequiredAnyTextLines = { "BecameCloseWithMegaera01_BMeg_GoToHer", "BecameCloseWithMegaera01Meg_GoToHer" },
				{ Cue = "/VO/Alecto_0347",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Megaera's not just weak, she's got bad taste to match." },
			},
			-- renamed, previously 29
			Fury2MiscStart29B =
			{
				{ Cue = "/VO/Alecto_0348",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Oh good, I was just itching for a live one, here, trash god." },
			},
			-- renamed, previously 29
			Fury2MiscStart29A =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0349",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Live or die, your daddy doesn't care, redblood!" },
			},
			Fury2MiscStart29 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0350",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Good thing your daddy hates you, or I wouldn't have the pleasure here, redblood!" },
			},
			Fury2MiscStart30 =
			{
				{ Cue = "/VO/Alecto_0351",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "I'm real sick of waiting here, so how about we make this {#DialogueItalicFormat}real quick{#PreviousFormat}, redblood!" },
			},
			Fury2MiscStart31 =
			{
				{ Cue = "/VO/Alecto_0352",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Nothing like nice, fresh blood to warm things up in here, I always say!" },
			},
			Fury2MiscStart32 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0353",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "When I heard you were coming through, redblood, I told my sisters I would see you here." },
			},
			Fury2MiscStart33 =
			{
				{ Cue = "/VO/Alecto_0354",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Emote = "PortraitEmoteFiredUp",
					Text = "{#DialogueItalicFormat}Ohh{#PreviousFormat}, we are going to enjoy this, here, redblood!" },
			},
			Fury2MiscStart34 =
			{
				{ Cue = "/VO/Alecto_0368",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Heard you were in the area and volunteered for this, trash god." },
			},
			Fury2MiscStart35 =
			{
				RequiredTextLines = { "Fury2MiscEncounter02" },
				{ Cue = "/VO/Alecto_0369",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Text = "Time to spill it for me once again, redblood." },
			},
			Fury2MiscStart36 =
			{
				{ Cue = "/VO/Alecto_0370",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "AlectoTaunt", PreLineWait = 0.35,
					Emote = "PortraitEmoteFiredUp",
					Text = "I'll send you screaming home to daddy, now come on!!" },
			},
		},

		Binks =
		{
			"Enemy_Alecto_Idle_Bink",
			"Enemy_Alecto_Run_Bink",
			"Enemy_Alecto_StartStop_Bink",
			"Enemy_Alecto_Lunge_Bink",
			"Enemy_Alecto_Beam_Bink",
			"Enemy_Alecto_Lightning_Bink",
			"Enemy_Alecto_WhipWhirl_Bink",
			"Enemy_Alecto_Shielded_Bink",
			"Enemy_Fury2_Dead_Bink",
			"Enemy_Alecto_Taunt_Bink",
			"Enemy_Alecto_TauntIdleLoop_Bink",
			"Enemy_Alecto_Rage_Bink",

			"Enemy_Fury_Idle_Bink",
			"Enemy_Tisiphone_Taunt_Bink",
			"Enemy_MegaeraMultiFuryHover_Bink",
			"Enemy_MegaeraMultiFuryTakeOff_Bink",
			"Enemy_MegaeraMultiFurySkyDive_Bink",
			"Enemy_TisiphoneMultiFuryHover_Bink",
			"Enemy_TisiphoneMultiFuryTakeOff_Bink",
			"Enemy_TisiphoneMultiFurySkyDive_Bink",
		},
	},

	-- Tisiphone
	Harpy3 =
	{
		InheritFrom = { "Harpy" },
		HealthBarTextId = "Harpy3_Full",
		Portrait = "Portrait_FurySister03_Default_01",
		SpawnAnimation = "TisiphoneTaunt_Loop_2",
		DeathAnimation = "FuryDeadTisiphone",
		ClearChillOnDeath = true,

		MaxHealth = 5200,
		ShrineDataOverwrites =
		{
			MaxHealth = 5600,
		},

		Groups = { "GroundEnemies", "FlyingEnemies" },

		DefaultAIData =
		{

		},
		WeaponOptions = { "HarpyWhipLasso", "HarpyWhipCombo1" },
		DisarmedWeapon = "HarpyWhipCombo1",

		AdditionalEnemySetupFunctionName = "SelectHarpySupportAIs",

		ShrineMetaUpgradeName = "BossDifficultyShrineUpgrade",
		SupportAIWeaponSetOptions = { "Megaera", "Alecto" },

		SpawnOptions =
		{
		},

		AIEndHealthThreshold = 0.66,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				EquipRandomWeapon = { "HarpyLightningLine", "HarpySlowBeam360" },

				AddSupportAIWeaponOptions =
				{
					-- Tisiphone
					Megaera = {
						"SummonMegaeraWhipWhirl"
					},
					-- Alecto
					Alecto = {
						"SummonAlectoWhipShot"
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.66,
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "Fury3ShieldedStart",
				ThreadedFunctions = { "Harpy3MapTransition" },
				EquipRandomWeapon = { "HarpyLightningLine", "HarpySlowBeam360" },
				WaitDuration = 3.5,

				AddSupportAIWeaponOptions =
				{
					-- Tisiphone
					Megaera = {
						"SummonMegaeraHarpyBeam"
					},
					-- Alecto
					Alecto = {
						"SummonAlectoLightningChase"
					},
				},
				AIData =
				{
					AIEndHealthThreshold = 0.33,
				},

			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "Fury3ShieldedStart",
				ThreadedFunctions = { "Harpy3MapTransition" },
				UnequipWeapons = {"HarpyLightningLine"},
				EquipWeapons = { "HarpyLightningCardinal" },
				WaitDuration = 3.5,
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
		},

		CauseOfDeathVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.6,
			Queue = "Interrupt",
			NoTarget = true,
			SkipAnim = true,
			Source = { SubtitleColor = Color.TisiphoneVoice },

			-- Murderer.
			{ Cue = "/VO/Tisiphone_0071" },
			-- Murdererrr....
			{ Cue = "/VO/Tisiphone_0072" },
			-- Mmurderer...
			{ Cue = "/VO/Tisiphone_0073" },
			-- Murderer!
			{ Cue = "/VO/Tisiphone_0074" },
			-- Murdererrr...!
			{ Cue = "/VO/Tisiphone_0076" },
			-- Murdererr.....
			{ Cue = "/VO/Tisiphone_0077" },
			-- Murdererr.
			{ Cue = "/VO/Tisiphone_0078" },
			-- <Laughter>
			-- { Cue = "/VO/Tisiphone_0075" },
			-- Murderer!
			{ Cue = "/VO/Tisiphone_0167" },
			-- Mmmurder....
			{ Cue = "/VO/Tisiphone_0168" },
			-- Mmmurrhrrhrhrhr...
			{ Cue = "/VO/Tisiphone_0170" },
			-- Mmurderr Zzagreus.
			{ Cue = "/VO/Tisiphone_0171", RequiredTextLines = { "Fury3Encounter10" } },
			-- Zagreusss....
			{ Cue = "/VO/Tisiphone_0172", RequiredTextLines = { "Fury3Encounter10" } },
			-- Zzzagreus...
			{ Cue = "/VO/Tisiphone_0173", RequiredTextLines = { "Fury3Encounter10" } },
			-- Zagreuss murderrrerrrr!
			{ Cue = "/VO/Tisiphone_0174", RequiredTextLines = { "Fury3Encounter10" } },
			-- Zagreusss...!
			{ Cue = "/VO/Tisiphone_0175", ConsecutiveClearsOfRoom = { Name = "A_Boss03", Count = 2, }, RequiredTextLines = { "Fury3Encounter10" } },
			-- Zagreuss.....
			{ Cue = "/VO/Tisiphone_0176", ConsecutiveClearsOfRoom = { Name = "A_Boss03", Count = 2, }, RequiredTextLines = { "Fury3Encounter10" } },
			-- Zrrrhhderrerrr.
			{ Cue = "/VO/Tisiphone_0177", ConsecutiveClearsOfRoom = { Name = "A_Boss03", Count = 2, }, RequiredTextLines = { "Fury3Encounter10" } },
		},
		LowHealthVoiceLineThreshold = 0.6,
		LowHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			CooldownTime = 24,
			CooldownName = "TisiphoneSpokeRecently",
			PreLineWait = 0.35,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- Mrr!
			{ Cue = "/VO/Tisiphone_0062" },
			-- Mmm.
			{ Cue = "/VO/Tisiphone_0063" },
			-- Rrr...
			{ Cue = "/VO/Tisiphone_0064" },
			-- Mrruu?
			{ Cue = "/VO/Tisiphone_0052" },
			-- Zungh!
			{ Cue = "/VO/Tisiphone_0159", GameStateRequirements = { RequiredTextLines = { "Fury3Encounter08" } }, },
			-- Zmm.
			{ Cue = "/VO/Tisiphone_0160", GameStateRequirements = { RequiredTextLines = { "Fury3Encounter08" } }, },
			-- Grr...
			{ Cue = "/VO/Tisiphone_0161", GameStateRequirements = { RequiredTextLines = { "Fury3Encounter08" } }, },
			-- Grnngh...
			{ Cue = "/VO/Tisiphone_0162", GameStateRequirements = { RequiredTextLines = { "Fury3Encounter08" } }, },
			-- Grnhh!
			{ Cue = "/VO/Tisiphone_0163", GameStateRequirements = { RequiredTextLines = { "Fury3Encounter08" } }, },
		},
		CriticalHealthVoiceLineThreshold = 0.3,
		CriticalHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			CooldownTime = 24,
			CooldownName = "TisiphoneSpokeRecently",
			PreLineWait = 0.35,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- Mrrngh...
			{ Cue = "/VO/Tisiphone_0065" },
			-- Mrhh!
			{ Cue = "/VO/Tisiphone_0066" },
			-- Rrngh!
			{ Cue = "/VO/Tisiphone_0067" },
		},
		DeathVoiceLines =
		{
			Queue = "Interrupt",
			{
				{ Cue = "/EmptyCue" }
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.45,
				SkipAnim = true,

				-- Mm, murderr....?
				{ Cue = "/VO/Tisiphone_0079" },
				-- Mrr, mur--!
				{ Cue = "/VO/Tisiphone_0080" },
				-- Mmurderr....
				{ Cue = "/VO/Tisiphone_0081" },
				-- Mmmuuu....
				{ Cue = "/VO/Tisiphone_0082" },
				-- Mur, der, err....
				{ Cue = "/VO/Tisiphone_0083" },
				-- Mmmmuunnngggh....
				{ Cue = "/VO/Tisiphone_0084" },
				-- Mm, mmrrr!
				{ Cue = "/VO/Tisiphone_0085" },
				-- Mrrr--?!
				{ Cue = "/VO/Tisiphone_0086" },
				-- Muurdderr...!
				{ Cue = "/VO/Tisiphone_0087" },
				-- Mur, murderr...
				{ Cue = "/VO/Tisiphone_0088" },
				-- Zuh, Zrngh....?
				{ Cue = "/VO/Tisiphone_0178", RequiredTextLines = { "Fury3Encounter08" } },
				-- Za, gree--!
				{ Cue = "/VO/Tisiphone_0179", RequiredTextLines = { "Fury3Encounter08" } },
				-- Zzah, gree, urngh....
				{ Cue = "/VO/Tisiphone_0180", RequiredTextLines = { "Fury3Encounter08" } },
				-- Zzzyah....
				{ Cue = "/VO/Tisiphone_0181", RequiredTextLines = { "Fury3Encounter08" } },
				-- Zah, gre, us....
				{ Cue = "/VO/Tisiphone_0182", RequiredTextLines = { "Fury3Encounter10" } },
				-- Zzzzuurrrnngh....
				{ Cue = "/VO/Tisiphone_0183", RequiredTextLines = { "Fury3Encounter08" } },
				-- Zz, zzurngh!
				{ Cue = "/VO/Tisiphone_0184", RequiredTextLines = { "Fury3Encounter08" } },
				-- Zzaah--?!
				{ Cue = "/VO/Tisiphone_0185", RequiredTextLines = { "Fury3Encounter08" } },
				-- Zzahgreus...!
				{ Cue = "/VO/Tisiphone_0186", RequiredTextLines = { "Fury3Encounter10" } },
				-- Zz-zahgreeus...
				{ Cue = "/VO/Tisiphone_0187", RequiredTextLines = { "Fury3Encounter10" } },
			},
		},
		OnKillGlobalVoiceLines = "FuryVanquishedGlobalVoiceLines",
		KillsRequiredForVoiceLines = 1,

		PlayerInjuredVoiceLineThreshold = 0.35,
		PlayerInjuredVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.75,
			CooldownTime = 120,
			CooldownName = "TisiphoneSpokeRecently",

			-- Murdderr....
			{ Cue = "/VO/Tisiphone_0057" },
			-- Murderrerrr....
			{ Cue = "/VO/Tisiphone_0058" },
			-- Murdererr!
			{ Cue = "/VO/Tisiphone_0059" },
			-- Murrr...
			{ Cue = "/VO/Tisiphone_0060" },
			-- Mmm...
			{ Cue = "/VO/Tisiphone_0061" },
			-- Zaggreuss....
			{ Cue = "/VO/Tisiphone_0153", RequiredTextLines = { "Fury3Encounter10" } },
			-- Zaggreusss....
			{ Cue = "/VO/Tisiphone_0154", RequiredTextLines = { "Fury3Encounter10" } },
			-- Zagreuss!
			{ Cue = "/VO/Tisiphone_0155", RequiredTextLines = { "Fury3Encounter10" } },
			-- Zrngh...
			{ Cue = "/VO/Tisiphone_0156", RequiredTextLines = { "Fury3Encounter10" } },
			-- Zrngh!
			{ Cue = "/VO/Tisiphone_0157", RequiredTextLines = { "Fury3Encounter10" } },
			-- Znnh...
			{ Cue = "/VO/Tisiphone_0158", RequiredTextLines = { "Fury3Encounter10" } },
		},
		MapTransitionReactionVoiceLines =
		{
			Queue = "Interrupt",
			Cooldowns =
			{
				{ Name = "ZagreusLightsOutSpeech", Time = 70 },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlayAll = 0.5,
				PlayOnceFromTableThisRun = true,
				RequiredTrait = "SkellyAssistTrait",
				ObjectType = "TrainingMeleeSummon",
				Queue = "Interrupt",

				-- Hey who turned out the lights?!
				{ Cue = "/VO/Skelly_0549", SuccessiveChanceToPlay = 0.05 },
				-- Whoa whoa whoa!
				{ Cue = "/VO/Skelly_0222" },
				-- Whaa?
				{ Cue = "/VO/Skelly_0345" },
				-- Uh, pal?!
				{ Cue = "/VO/Skelly_0349" },
				-- Can't see nothing over here!
				{ Cue = "/VO/Skelly_0585", RequiredPlayed = { "/VO/Skelly_0549" } },
				-- Hey, what the?
				{ Cue = "/VO/Skelly_0586", RequiredPlayed = { "/VO/Skelly_0549" } },
				-- Ah, this again huh.
				{ Cue = "/VO/Skelly_0587", RequiredPlayed = { "/VO/Skelly_0549" } },
				-- I'm scared, hold me, boyo!
				{ Cue = "/VO/Skelly_0588", RequiredPlayed = { "/VO/Skelly_0549" } },
				-- Where'd everybody go?
				{ Cue = "/VO/Skelly_0589", RequiredPlayed = { "/VO/Skelly_0549" } },
				-- The walls, boyo!
				{ Cue = "/VO/Skelly_0590", RequiredPlayed = { "/VO/Skelly_0549" } },
				-- Ah, no, not this again!
				{ Cue = "/VO/Skelly_0591", RequiredPlayed = { "/VO/Skelly_0549" } },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				SuccessiveChanceToPlayAll = 0.1,

				-- Not again.
				{ Cue = "/VO/ZagreusField_1516", RequiredPlayed = { "/VO/ZagreusField_1521" } },
				-- Lights out.
				{ Cue = "/VO/ZagreusField_1517", RequiredPlayed = { "/VO/ZagreusField_1521" } },
				-- The chamber....
				{ Cue = "/VO/ZagreusField_1518", RequiredPlayed = { "/VO/ZagreusField_1521" } },
				-- The walls....
				{ Cue = "/VO/ZagreusField_1519", RequiredPlayed = { "/VO/ZagreusField_1521" } },
				-- Not good.
				{ Cue = "/VO/ZagreusField_1520", RequiredPlayed = { "/VO/ZagreusField_1521" } },
				-- What is she...
				{ Cue = "/VO/ZagreusField_1521", PlayOnce = true, },
				-- This again.
				{ Cue = "/VO/ZagreusField_1522", RequiredPlayed = { "/VO/ZagreusField_1521" } },
				-- What...
				{ Cue = "/VO/ZagreusField_0964", RequiredPlayed = { "/VO/ZagreusField_1521" } },
				-- Oh, no.
				{ Cue = "/VO/ZagreusField_0962", RequiredPlayed = { "/VO/ZagreusField_1521" } },
				-- Uh oh...
				{ Cue = "/VO/ZagreusField_0159", RequiredPlayed = { "/VO/ZagreusField_1521" } },
				-- Oh, gods.
				{ Cue = "/VO/ZagreusField_0963", RequiredPlayed = { "/VO/ZagreusField_1521" } },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.4,

				-- Murderrerr!
				{ Cue = "/VO/Tisiphone_0038" },
				-- Murdererrrrrr...!!
				{ Cue = "/VO/Tisiphone_0040" },
				-- MurdereRRRR...!!
				{ Cue = "/VO/Tisiphone_0041" },
				-- Mur, der, rerrr!!
				{ Cue = "/VO/Tisiphone_0042" },
				-- Murrrnnngghh!!
				{ Cue = "/VO/Tisiphone_0043" },
				-- Mrrnnnhhhhhh!
				{ Cue = "/VO/Tisiphone_0044" },
				-- Zagreus!!
				{ Cue = "/VO/Tisiphone_0135", RequiredTextLines = { "Fury3Encounter10" }, },
				-- Zagreusssss!
				{ Cue = "/VO/Tisiphone_0136", RequiredTextLines = { "Fury3Encounter10" }, },
				-- ZagreUSSSS...!!
				{ Cue = "/VO/Tisiphone_0137", RequiredTextLines = { "Fury3Encounter10" }, },
				-- Zag, re, uss...!!
				{ Cue = "/VO/Tisiphone_0138", RequiredTextLines = { "Fury3Encounter10" }, },
				-- Zurrrnnngghh!!
				{ Cue = "/VO/Tisiphone_0139", RequiredTextLines = { "Fury3Encounter08" }, },
				-- Zrrnnnhhhhhh!
				{ Cue = "/VO/Tisiphone_0140", RequiredTextLines = { "Fury3Encounter08" }, },
				-- Zrr, hrrnnn...
				{ Cue = "/VO/Tisiphone_0141", RequiredTextLines = { "Fury3Encounter08" }, },
			},
		},
		AssistReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.8,
			Queue = "Interrupt",
			RequiredOneOfTraits = { "ThanatosAssistTrait", "SkellyAssistTrait", "SisyphusAssistTrait", "DusaAssistTrait", "AchillesPatroclusAssistTrait" },
			RequiredRoom = "A_Boss03",

			-- Murderrr...?
			{ Cue = "/VO/Tisiphone_0055" },
			-- Murderr...!
			{ Cue = "/VO/Tisiphone_0056" },
			-- Mrrr...?
			{ Cue = "/VO/Tisiphone_0050" },
			-- Mrr...
			{ Cue = "/VO/Tisiphone_0051" },
			-- Mrruu?
			{ Cue = "/VO/Tisiphone_0052" },
			-- Mrr...
			{ Cue = "/VO/Tisiphone_0053" },
			-- Drrr...
			{ Cue = "/VO/Tisiphone_0054" },
			-- Mmurderer...!
			{ Cue = "/VO/Tisiphone_0169" },
		},
		WrathReactionVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 1,
			CooldownTime = 30,
			SuccessiveChanceToPlay = 0.33,
			Queue = "Interrupt",

			-- Murderrr...?
			{ Cue = "/VO/Tisiphone_0055" },
			-- Murderr...!
			{ Cue = "/VO/Tisiphone_0056" },
			-- Zagreuss...?
			{ Cue = "/VO/Tisiphone_0151", RequiredTextLines = { "Fury3Encounter10" } },
			-- Zagreuss...!
			{ Cue = "/VO/Tisiphone_0152", RequiredTextLines = { "Fury3Encounter10" } },
			-- Zrrr...?
			{ Cue = "/VO/Tisiphone_0146", RequiredTextLines = { "Fury3Encounter08" } },
			-- Zrr...
			{ Cue = "/VO/Tisiphone_0147", RequiredTextLines = { "Fury3Encounter08" } },
			-- Zuh?
			{ Cue = "/VO/Tisiphone_0148", RequiredTextLines = { "Fury3Encounter08" } },
			-- Zrr...
			{ Cue = "/VO/Tisiphone_0149", RequiredTextLines = { "Fury3Encounter08" } },
			-- Grrr...
			{ Cue = "/VO/Tisiphone_0150", RequiredTextLines = { "Fury3Encounter08" } },
		},

		InvulnerableHitSound = nil,
		InvulnerableVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			CooldownTime = 16,
			CooldownName = "TisiphoneSpokeRecently",

			-- Mmmrr...
			{ Cue = "/VO/Tisiphone_0068" },
			-- Mm-hhmmm...
			{ Cue = "/VO/Tisiphone_0069" },
			-- Hhrrm.
			{ Cue = "/VO/Tisiphone_0070" },
			-- Zrrrnh...
			{ Cue = "/VO/Tisiphone_0164", RequiredTextLines = { "Fury3Encounter08" } },
			-- Zrn-hhm...
			{ Cue = "/VO/Tisiphone_0165", RequiredTextLines = { "Fury3Encounter08" } },
			-- Zhrrm.
			{ Cue = "/VO/Tisiphone_0166", RequiredTextLines = { "Fury3Encounter08" } },
		},
		LastStandReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 2.4,
			CooldownTime = 16,
			SuccessiveChanceToPlay = 0.66,
			Queue = "Always",

			-- Murderrrr!
			{ Cue = "/VO/Tisiphone_0031" },
			-- Mmmmurdderrrr....
			{ Cue = "/VO/Tisiphone_0032" },
			-- Murdderr, murderrerrr!
			{ Cue = "/VO/Tisiphone_0033" },
			-- Mmmuurrderrerrr....
			{ Cue = "/VO/Tisiphone_0024" },
			-- Murder. Murder!
			{ Cue = "/VO/Tisiphone_0089" },
		},

		BossPresentationPriorityIntroTextLineSets =
		{
			Fury3SisterUnionSingleSis01_A =
			{
				PlayOnce = true,
				RequiredFalseTextLines = { "Fury3SisterUnionSingleSis01_B" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredSupportAINames = { "Alecto" },
				RequiredRoom = "A_Boss03",
				{ Cue = "/VO/Alecto_0051", Speaker = "NPC_FurySister_02", Portrait = "Portrait_FurySister02_Default_01",
					Text = "You mess with Tis, redblood, you mess with me, get it?" },
				{ Cue = "/VO/Tisiphone_0024",
					Emote = "PortraitEmoteAnger",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Mmmuurrderrerrr{#PreviousFormat}...!" },
			},
			Fury3SisterUnionSingleSis01_B =
			{
				PlayOnce = true,
				RequiredFalseTextLines = { "Fury3SisterUnionSingleSis01_A" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
				RequiredMaxSupportAINames = 1,
				RequiredSupportAINames = { "Megaera" },
				RequiredRoom = "A_Boss03",
				{ Cue = "/VO/MegaeraField_0554", Speaker = "NPC_FurySister_01", Portrait = "Portrait_FurySister01_Default_01",
					Text = "Heads up, Tisiphone. I think I found a murderer for you." },
				{ Cue = "/VO/Tisiphone_0024",
					Emote = "PortraitEmoteAnger",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Mmmuurrderrerrr{#PreviousFormat}...!" },
			},
		},
		BossPresentationIntroTextLineSets =
		{
			Fury3FirstAppearance =
			{
				PlayOnce = true,
				PreEventWait = 0.4,
				{ Cue = "/VO/Tisiphone_0002", Speaker = "NPC_FurySister_Unnamed_03", SpeakerLabelOffsetY = 18,
					Text = "{#DialogueItalicFormat}Mmmm... mmmurderer..." },
				{ Cue = "/VO/ZagreusField_1424", PreLineWait = 0.3, Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey, you must be one of Meg's sisters! Nice to finally meet you. My name's Zagreus. Not {#DialogueItalicFormat}Murderer{#PreviousFormat}. Definitely not." },
				{ Cue = "/VO/Tisiphone_0003",
					Text = "Murderer... {#DialogueItalicFormat}mmmmurderrrerrrrrrrr...!" },
				{ Cue = "/VO/ZagreusField_1425", PreLineWait = 0.3, Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					Text = "{#DialogueItalicFormat}Erm{#PreviousFormat}... look, I've done some things that maybe aren't great, but I am very, very sure I haven't murdered anyone." },
				{ Cue = "/VO/Tisiphone_0004",
					Emote = "PortraitEmoteAnger",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Mmmmmurderrrerrrrrrrr{#PreviousFormat}...!" },
			},

			Fury3PostEnding01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Ending01" },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.65,
					-- Well then, let's get to work!
					{ Cue = "/VO/ZagreusField_4545" },
				},
				{ Cue = "/VO/ZagreusField_4544", PreLineWait = 0.3, Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm here on official business this time, Tisiphone, so, {#DialogueItalicFormat}uh{#PreviousFormat}... stand aside! Although, I guess the whole point of this job is that you're meant to try and stop me anyway, isn't that right?" },
				{ Cue = "/VO/Tisiphone_0026",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Mmm, hrr-hrr-{#DialogueItalicFormat}hrrdderrr{#PreviousFormat}..." },
			},
			Fury3PostEpilogue01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "OlympianReunionQuestComplete" },
				{ Cue = "/VO/ZagreusField_4546", PreLineWait = 0.3, Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, sorry that you couldn't make the feast back at the House, Tisiphone. Though, I don't really think it was your kind of scene. Although, Ares was there, he's probably done some murders, right?" },
				{ Cue = "/VO/Tisiphone_0019",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Murrddderrrr? Murrdderrr. {#DialogueItalicFormat}Murddder{#PreviousFormat}!" },
			},			
		},

		BossPresentationTextLineSets =
		{
			Fury3Encounter01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3FirstAppearance" },
				{ Cue = "/VO/Tisiphone_0005",
					Text = "{#DialogueItalicFormat}Mmmmurrr{#PreviousFormat}... derr...?" },
				{ Cue = "/VO/ZagreusField_1426", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#DialogueItalicFormat}Erm{#PreviousFormat}... how about, no? No murder. No murder!" },
				{ Cue = "/VO/Tisiphone_0006",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Mmmmuurderrr....{#PreviousFormat}" },
			},

			Fury3Encounter02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3Encounter01" },
				{ Cue = "/VO/Tisiphone_0007",
					Emote = "PortraitEmoteSurprise",
					Text = "Murder...? Murder, murrrder...!" },
				{ Cue = "/VO/ZagreusField_1427", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "I was really hoping we could change the subject. Please?" },
				{ Cue = "/VO/Tisiphone_0008",
					Emote = "PortraitEmoteAnger",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Muurderer... {#DialogueItalicFormat}muuurrderer{#PreviousFormat}!" },
			},

			Fury3Encounter03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3Encounter02" },
				{ Cue = "/VO/Tisiphone_0009",
					Text = "Mmm... mmm.... mmmrrrr....!" },
				{ Cue = "/VO/ZagreusField_1428", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Let me guess. Murder? Murderer, perhaps? One of those two." },
				{ Cue = "/VO/Tisiphone_0010",
					Emote = "PortraitEmoteAnger",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Mmm, mmmurder... mmmurder!!" },
			},

			Fury3Encounter04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3Encounter03" },
				{ Cue = "/VO/Tisiphone_0011",
					Text = "Mmmrrrrr... mmurrr, derrr...." },
				{ Cue = "/VO/ZagreusField_1429", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Please, I'm not a murderer, you don't have to do this." },
				{ Cue = "/VO/Tisiphone_0012",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Murderer. Muurrdererrr...." },
			},

			Fury3Encounter05 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3Encounter04" },
				{ Cue = "/VO/Tisiphone_0013",
					Text = "Murdererrr... murder, murder, {#DialogueItalicFormat}murder{#PreviousFormat}!" },
				{ Cue = "/VO/ZagreusField_1430", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "We're not getting through to one another, are we. I'm sorry that it has to be this way." },
				{ Cue = "/VO/Tisiphone_0014",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", WaitTime = 1.7 },					
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Murderer. {#DialogueItalicFormat}Murdererrr{#PreviousFormat}!!" },
			},

			Fury3Encounter06 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3Encounter05" },
				{ Cue = "/VO/Tisiphone_0015",
					Text = "Murder? {#DialogueItalicFormat}Murder{#PreviousFormat}...? Murder...." },
				{ Cue = "/VO/ZagreusField_1431", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "I don't understand. But I'm not who you think I am. My father sent you to stop me, that's all." },
				{ Cue = "/VO/Tisiphone_0016",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Murderer... murderer! {#DialogueItalicFormat}Murderer{#PreviousFormat}!" },
			},

			-- tisiphone subplot
			Fury3Encounter07 =
			{
				PlayOnce = true,
				RequiredKills = { Harpy3 = 8 },
				RequiredTextLines = { "Fury3Encounter06", "MegaeraAboutSisters01", "MegaeraAboutTisiphone01", "MegaeraGift06" },
				RequiredFalseSupportAINames = { "Alecto" },
				-- MinRunsSinceAnyTextLines = { TextLines = { "Fury3Encounter06" }, Count = 5 },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.65,
					-- Murderzer?!
					{ Cue = "/VO/ZagreusField_3825" },
				},
				{ Cue = "/VO/Tisiphone_0097",
					Text = "Mrrr... murr.. derr... {#DialogueItalicFormat}murrdderr{#PreviousFormat}!" },
				{ Cue = "/VO/ZagreusField_3824", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "No, murder. Zagreus. My name is Zagreus! Can you say that, Tisiphone? No murder. {#DialogueItalicFormat}Zagreus{#PreviousFormat}!" },
				{ Cue = "/VO/Tisiphone_0098",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Murr... derr... {#DialogueItalicFormat}zerrr{#PreviousFormat}...." },
			},

			Fury3Encounter08 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3Encounter07" },
				RequiredFalseSupportAINames = { "Alecto" },
				-- RequiredInactiveMetaUpgrade = "BossDifficultyShrineUpgrade",
				{ Cue = "/VO/Tisiphone_0099",
					Text = "Mm, murrr... derr... zerrr!" },
				{ Cue = "/VO/ZagreusField_3826", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You really did say {#DialogueItalicFormat}murderzer{#PreviousFormat}, didn't you! That's progress! Zagreus! I'm Zagreus, I'm not a murderer! Can you say Zagreus?" },
				{ Cue = "/VO/Tisiphone_0100",
					Emote = "PortraitEmoteDepressed",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Derr... zerr... zahh... zahh, {#DialogueItalicFormat}graaahh{#PreviousFormat}!" },
			},

			Fury3Encounter09 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3Encounter08" },
				RequiredFalseSupportAINames = { "Alecto" },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.4,
					-- Almost!
					{ Cue = "/VO/ZagreusField_3828" },
				},
				{ Cue = "/VO/Tisiphone_0101",
					Emote = "PortraitEmoteDepressed",
					Text = "Zerr... znnhh... zrrrnggh...!" },
				{ Cue = "/VO/ZagreusField_3827", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Do you remember me, Tisiphone? My name is Zagreus. Prince of the Underworld? Pretty close with Megaera, I guess. Try saying Zagreus again for me?" },
				{ Cue = "/VO/Tisiphone_0102",
					Emote = "PortraitEmoteDepressed",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Zrrnngh... zaahh... zahh... gree... mrrsss...?" },
			},

			Fury3Encounter10 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3Encounter09" },
				RequiredFalseSupportAINames = { "Alecto" },
				EndVoiceLines =
				{
					{
						UsePlayerSource = true,
						PreLineWait = 0.35,
						-- That's it!
						{ Cue = "/VO/ZagreusField_3830" },
					},
					{
						PreLineWait = 0.2,
						Source = { SubtitleColor = Color.MegVoice },
						RequiredFalseSupportAINames = { "Alecto" },
						RequiredSupportAINames = { "Megaera" },
						-- You did it, Zag.
						{ Cue = "/VO/MegaeraHome_0289" },
					},
				},
				{ Cue = "/VO/Tisiphone_0103",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#DialogueItalicFormat}Zzaaahhh... durrr... err{#PreviousFormat}... Zzahh... durr." },
				{ Cue = "/VO/ZagreusField_3829", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Oh, you're so close, Tisiphone! Remember, Zagreus? That's me. I'm not your enemy, you know, don't you know that? I'm only Zagreus!" },
				{ Cue = "/VO/Tisiphone_0104",
					Emote = "PortraitEmoteDepressed",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSurprise", DoShake = true, WaitTime = 5.6 },
					Text = "...Zzzzzaaahhh... gree... usss.... Zzaagreeusss! {#DialogueItalicFormat}Zaagreuss{#PreviousFormat}!!" },
			},

			Fury3Encounter11 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3Encounter10" },
				RequiredFalseSupportAINames = { "Alecto" },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.7,
					-- That's not happy...
					{ Cue = "/VO/ZagreusField_3832" },
				},
				{ Cue = "/VO/Tisiphone_0105",
					Text = "{#DialogueItalicFormat}Zzzaaggreussss{#PreviousFormat}.... mm... murrdererr...." },
				{ Cue = "/VO/ZagreusField_3831", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					Emote = "PortraitEmoteSurprise",
					Text = "No. Wait. Just the first part. No murderer. Just Zagreus. Or... let's see, how about... {#DialogueItalicFormat}happy{#PreviousFormat}? Can you say {#DialogueItalicFormat}happy{#PreviousFormat}?" },
				{ Cue = "/VO/Tisiphone_0106",
					Emote = "PortraitEmoteDepressed",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Mmrrr... {#DialogueItalicFormat}Zzzrrderrrerrr{#PreviousFormat}...." },
			},

			Fury3Encounter12 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3Encounter11" },
				RequiredFalseSupportAINames = { "Alecto" },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.7,
					-- Great.
					{ Cue = "/VO/ZagreusField_3834" },
				},
				{ Cue = "/VO/Tisiphone_0107",
					Text = "Murdderr... Zzaagreusss... {#DialogueItalicFormat}murddererrr{#PreviousFormat}..." },
				{ Cue = "/VO/ZagreusField_3833", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "{#DialogueItalicFormat}Erm{#PreviousFormat}, well... let's try again with {#DialogueItalicFormat}happy{#PreviousFormat}, how about that? Happy? No murder, only happy. Come on, now!" },
				{ Cue = "/VO/Tisiphone_0108",
					Emote = "PortraitEmoteAnger",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Murderr... murderr {#DialogueItalicFormat}Zzagreusss{#PreviousFormat}!" },
			},

			Fury3Encounter13 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3Encounter12" },
				RequiredFalseSupportAINames = { "Alecto" },
				{ Cue = "/VO/Tisiphone_0109",
					Emote = "PortraitEmoteDepressed",
					Text = "Mmmmurdde{#DialogueItalicFormat}rerrr{#PreviousFormat}... znnnhh... zrrrnnggh..." },
				{ Cue = "/VO/ZagreusField_3835", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "{#DialogueItalicFormat}Eugh{#PreviousFormat}, I guess the {#DialogueItalicFormat}happy {#PreviousFormat}thing just isn't doing it for you. Though, maybe trying to kill me like this is as close as you can get. You learned my name at least, that's something, right?" },
				{ Cue = "/VO/Tisiphone_0110",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Murrddderr... Zzaagreusss{#PreviousFormat}..." },
			},

			Fury3Encounter14 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3Encounter13" },
				RequiredFalseSupportAINames = { "Alecto" },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.65,
					-- Friends!
					{ Cue = "/VO/ZagreusField_3837" },
				},
				{ Cue = "/VO/Tisiphone_0111",
					Text = "Mmmuurdderrr... {#DialogueItalicFormat}murrdderrrerrrrr{#PreviousFormat}...." },
				{ Cue = "/VO/ZagreusField_3836", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag", PreLineWait = 0.35,
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "...Then we're back to square one. Look, I was just trying to get through to you with all the Zagreus and happy stuff. But, if you can understand any of this, Tisiphone, I think you're all right, just the way you are. Friends?" },
				{ Cue = "/VO/Tisiphone_0112",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "...Zzrrngh... zrrnnggh... {#DialogueItalicFormat}zzrrdderrrerrr!{#PreviousFormat}..." },
			},

			Fury3Encounter15 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Fury3Encounter14" },
				RequiredFalseSupportAINames = { "Alecto" },
				MinRunsSinceAnyTextLines = { TextLines = { "Fury3Encounter14" }, Count = 3 },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.6,
					-- Ah, didn't think so.
					{ Cue = "/VO/ZagreusField_4109" },
				},
				{ Cue = "/VO/Tisiphone_0117",
					Text = "Zzz, zzaa... {#DialogueItalicFormat}Zaaggreus? {#PreviousFormat}Mmurderrrer?" },
				{ Cue = "/VO/ZagreusField_4108", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey, {#DialogueItalicFormat}uhh{#PreviousFormat}, any second thoughts, by any chance, about the whole {#DialogueItalicFormat}happy {#PreviousFormat}thing? Just making sure." },
				{ Cue = "/VO/Tisiphone_0174",
					PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Zagreuss {#DialogueItalicFormat}murderrrer{#PreviousFormat}!" },
			},

		},

		BossPresentationRepeatableTextLineSets =
		{
			Fury3MiscStart01 =
			{
				{ Cue = "/VO/Tisiphone_0017",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Mmmmm, mmm, mmrrrrr...." },
			},
			Fury3MiscStart02 =
			{
				{ Cue = "/VO/Tisiphone_0018",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Mm, mmurrdererrrrr.... Murdererr!" },
			},
			Fury3MiscStart03 =
			{
				{ Cue = "/VO/Tisiphone_0019",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Murder...? Murrdderrr. Murddder!" },
			},
			Fury3MiscStart04 =
			{
				{ Cue = "/VO/Tisiphone_0020",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Muurdddderrrerrr.... murdderrerrrr...!" },
			},
			Fury3MiscStart05 =
			{
				{ Cue = "/VO/Tisiphone_0021",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Mmm, murdder? {#DialogueItalicFormat}Murdderrer{#PreviousFormat}?" },
			},
			Fury3MiscStart06 =
			{
				{ Cue = "/VO/Tisiphone_0022",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Murder. Murder. Murder. {#DialogueItalicFormat}Murder. Murder{#PreviousFormat}!" },
			},
			Fury3MiscStart07 =
			{
				{ Cue = "/VO/Tisiphone_0023",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Murderer. Murderer...! {#DialogueItalicFormat}Murderer{#PreviousFormat}!" },
			},
			Fury3MiscStart08 =
			{
				{ Cue = "/VO/Tisiphone_0024",
					Emote = "PortraitEmoteAnger",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Mmmuurrderrerrr{#PreviousFormat}...!" },
			},
			Fury3MiscStart09 =
			{
				{ Cue = "/VO/Tisiphone_0025",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Mmmurrrderrerrr...?" },
			},
			Fury3MiscStart10 =
			{
				{ Cue = "/VO/Tisiphone_0026",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Mmm-hhhm-hmm-mmurrdderrr..." },
			},
			Fury3MiscStart12 =
			{
				{ Cue = "/VO/Tisiphone_0027",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Mmuuurrrrrderrrr...." },
			},
			Fury3MiscStart13 =
			{
				{ Cue = "/VO/Tisiphone_0028",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Murrdderrr? Murrdderrrr...." },
			},
			Fury3MiscStart14 =
			{
				{ Cue = "/VO/Tisiphone_0029",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Mmm... mmmrrrr... mrrrrr!" },
			},
			Fury3MiscStart15 =
			{
				{ Cue = "/VO/Tisiphone_0030",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Mm, mmm, mmrrrnnggghh!" },
			},
			Fury3MiscStart16 =
			{
				{ Cue = "/VO/Tisiphone_0031",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Murderrrr{#PreviousFormat}!" },
			},
			Fury3MiscStart17 =
			{
				RequiredTextLines = { "Fury3Encounter08" },
				{ Cue = "/VO/Tisiphone_0113",
					Emote = "PortraitEmoteDepressed",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Zzzaah, zzz, zrnnghh... {#PreviousFormat}muurddderr...!" },
			},
			Fury3MiscStart18 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0114",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Zz, zzzaggreuss.... {#DialogueItalicFormat}Zagreus{#PreviousFormat}!" },
			},
			Fury3MiscStart19 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0115",
					Emote = "PortraitEmoteSurprise",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Zzzagreus? {#DialogueItalicFormat}Mmmurdderr Zaggreuss{#PreviousFormat}!" },
			},
			Fury3MiscStart20 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0116",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Mmmurrdderrr.... {#DialogueItalicFormat}Zzaaggreusss{#PreviousFormat}...!" },
			},
			Fury3MiscStart21 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0117",
					Emote = "PortraitEmoteSurprise",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Zzz, zzaa... {#DialogueItalicFormat}Zaaggreus? {#PreviousFormat}Mmurderrrer?" },
			},
			Fury3MiscStart22 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0118",
					Emote = "PortraitEmoteDepressed",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Zzhhrr, zzzrnn, {#DialogueItalicFormat}Zzzrrderrerr{#PreviousFormat}..." },
			},
			Fury3MiscStart23 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0119",
					Emote = "PortraitEmoteAnger",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Zagreuss. Zagreuss...! {#DialogueItalicFormat}Zagreuss{#PreviousFormat}!" },
			},
			Fury3MiscStart24 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0120",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Zzzaaagggreussss{#PreviousFormat}...." },
			},
			Fury3MiscStart25 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0121",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Zzzaaagggreussss{#PreviousFormat}...?" },
			},
			Fury3MiscStart26 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0121",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Zzzaaagg{#DialogueItalicFormat}greussss{#PreviousFormat}...?" },
			},
			Fury3MiscStart27 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0123",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Zzzaaag{#PreviousFormat}greusssss...." },
			},
			Fury3MiscStart28 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0124",
					Emote = "PortraitEmoteFiredUp",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Zzagreuss? {#DialogueItalicFormat}Zzaaggreusss. {#PreviousFormat}Murderrerrrrr...." },
			},
			Fury3MiscStart29 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0125",
					Emote = "PortraitEmoteAnger",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Zzz... zzuh, zzzrnnn! {#DialogueItalicFormat}Mur{#PreviousFormat}dderrrr!" },
			},
			Fury3MiscStart30 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0126",
					Emote = "PortraitEmoteDepressed",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Zz, zrrngh, {#DialogueItalicFormat}zzrraugghhh{#PreviousFormat}!" },
			},

			Fury3MiscStart31 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0127",
					Emote = "PortraitEmoteAnger",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Zag{#PreviousFormat}reussss!" },
			},

			Fury3MiscStart32 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0128",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Zzz{#DialogueItalicFormat}zaaaag{#PreviousFormat}greusss....!" },
			},

			Fury3MiscStart33 =
			{
				RequiredTextLines = { "Fury3Encounter10" },
				{ Cue = "/VO/Tisiphone_0129",
					Emote = "PortraitEmoteAnger",
					PreLineFunctionName = "StartBossRoomMusic", PreLineAnim = "TisiphoneTaunt_2", PreLineWait = 0.35,
					Text = "Zzzagreuss, {#DialogueItalicFormat}mmurderrr{#PreviousFormat}!" },
			},
		},

		Binks =
		{
			"Enemy_Tisiphone_Idle_Bink",
			"Enemy_Tisiphone_Run_Bink",
			"Enemy_Tisiphone_StartStop_Bink",
			"Enemy_Tisiphone_Lunge_Bink",
			"Enemy_Tisiphone_Beam_Bink",
			"Enemy_Tisiphone_Lightning_Bink",
			"Enemy_Tisiphone_WhipWhirl_Bink",
			"Enemy_Tisiphone_Shielded_Bink",
			"Enemy_Fury3_Dead_Bink",
			"Enemy_Tisiphone_Taunt_Bink",

			"Enemy_Fury_Idle_Bink",
			"Enemy_Alecto_Taunt_Bink",
			"Enemy_MegaeraMultiFuryHover_Bink",
			"Enemy_MegaeraMultiFuryTakeOff_Bink",
			"Enemy_MegaeraMultiFurySkyDive_Bink",
			"Enemy_AlectoMultiFuryHover_Bink",
			"Enemy_AlectoMultiFuryTakeOff_Bink",
			"Enemy_AlectoMultiFurySkyDive_Bink",
		},
	},

	-- Hydra
	HydraHeadImmortal =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		GenusName = "HydraHeadImmortal",
		HealthBarTextId = "HydraHeadImmortal_Full",
		AltHealthBarTextIds =
		{
			{ TextId = "HydraHeadImmortal_NickName", Requirements = { RequiredPlayed = { "/VO/ZagreusField_3147" } } },
		},

		ShrineMetaUpgradeName = "BossDifficultyShrineUpgrade",
		ShrineMetaUpgradeRequiredLevel = 2,

		MaxHealth = 6000,
		AISetupDelay = 1.5,
		DetachedMoveSpeed = 1000,

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedSkeleton",
			Rapid = "HitSparkEnemyDamagedSkeletonRapid",
		},
		DeathFx = "ExplosionBone",
		DeathAnimation = "EnemyHydraDeathVFX",
		ClearChillOnDeath = true,
		DeathSound = "/SFX/Enemy Sounds/HydraHead/EmoteFinalDying2",
		OnKillGlobalVoiceLines = "HydraVanquishedGlobalVoiceLines",
		KillsRequiredForVoiceLines = 1,

		Groups = { "GroundEnemies" },
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted",
		IgnoreInvincibubbleOnHit = true,

		OnDeathFunctionName = "HydraKillPresentation",
		OnDeathFunctionArgs = { Message = "HydraDefeatedMessage", AltMessage = "HydraDefeatedMessage02", StartPanTime = 1.5, EndPanTime = 3.5, StartSound = "/SFX/Enemy Sounds/HydraHead/EmoteAttacking", EndAngle = 270, FlashRed = true, AddInterBiomeTimerBlock = true, KillEnemyNames = { "HydraTooth", "HydraTooth2" } },


		SwapAnimations = {},
		Binks =
		{
			"Enemy_Hydra_Roar_Bink",
			"Enemy_Hydra_OnHit_Bink",
			"Enemy_Hydra_MouthOpening_Bink",
			"Enemy_Hydra_Slam_Bink",
			"Enemy_Hydra_Idle_Bink",
			"Enemy_Hydra_Ranged_Bink",
			"Enemy_Hydra_DeathVFX_Bink",
			"Enemy_Hydra_Lunge_Bink",
			"Enemy_Hydra_Sleep_Bink",
		},
		OtherEnemyBinks =
		{
			"BloodlessNaked",
		},

		WeaponOptions =
		{
			"HydraLunge", "HydraSlam", "HydraDart"
		},

		AIOptions =
		{
			AttackerAI,
		},
		ResetPositionId = 480903,

		DefaultAIData =
		{
			AIBufferDistance = 600,
			AIAttackDistance = 600,
			--PreAttackEndShake = true, = true,
		},

		AIEndHealthThreshold = 0.66,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.66,
				},
				DisableRoomTraps = true,
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				SelectRandomAIStage = "AIStagesRank1",
				SelectPactLevelAIStage = "PactDataStage0",
				TransitionFunction = "HydraStageTransition",
				TransitionAnimation = "EnemyHydraTaunt",
				TransitionSound = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted",
				StartDelay = 2.0,
				AIData =
				{
					AIEndWithSpawnedEncounter = true,
				},
				NewVulnerability = false,
				AIWaitTime = 0,
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "HydraStageTransition",
				TransitionAnimation = "EnemyHydraTaunt",
				TransitionSound = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted",
				StartDelay = 2.0,
				SelectPactLevelAIStage = "PactDataStage1",
				AIWaitTime = 0,

				AIData =
				{
					AIEndHealthThreshold = 0.33,
				},
				DisableRoomTraps = true,
				NewVulnerability = true,
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				SelectRandomAIStage = "AIStagesRank2",
				SelectPactLevelAIStage = "PactDataStage2",
				TransitionFunction = "HydraStageTransition",
				TransitionAnimation = "EnemyHydraTaunt",
				TransitionSound = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted",
				StartDelay = 2.0,
				AIData =
				{
					AIEndWithSpawnedEncounter = true,
				},
				AIWaitTime = 0,

				StageTransitionVoiceLines =
				{
					RandomRemaining = true,
					PreLineWait = 1.25,
					SuccessiveChanceToPlay = 0.33,
					RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },

					-- Oh you can't be serious!
					{ Cue = "/VO/ZagreusField_2605", ChanceToPlayAgain = 0.001 },
					-- Who needs a neck anyway?
					{ Cue = "/VO/ZagreusField_2606", RequiredPlayed = { "/VO/ZagreusField_2605" } },
					-- Come on, you flying bastard.
					{ Cue = "/VO/ZagreusField_2607", RequiredPlayed = { "/VO/ZagreusField_2605" } },
					-- You and me, Severed Hydra Head!
					{ Cue = "/VO/ZagreusField_2608", RequiredPlayed = { "/VO/ZagreusField_2605" } },
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "HydraStageTransition",
				SelectPactLevelAIStage = "PactDataStage3",
				TransitionAnimation = "EnemyHydraTaunt",
				TransitionSound = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted",
				StartDelay = 2.0,
				AIWaitTime = 0,

				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				DisableRoomTraps = true,
				NewVulnerability = true,
			},
		},

		AIStagesRank1 =
		{
			{
				SpawnEncounter = "HydraHeads1",
			},
			{
				SpawnEncounter = "HydraHeads3",
			},
			{
				SpawnEncounter = "HydraHeads3",
			},
		},

		AIStagesRank2 =
		{
			{
				SpawnEncounter = "HydraHeads5",
			},
			{
				SpawnEncounter = "HydraHeads6",
			},
		},

		PactDataStage0 =
		{
			Default = {
			},
		},

		PactDataStage1 =
		{
			Default = {
				UnequipWeapons = {"HydraDart" },
				EquipWeapons = { "HydraDartVolley" },
			},
		},

		PactDataStage2 =
		{
			Default = {
				TransitionFunction = "HydraStageTransition",
				UnequipWeapons = {"HydraDartVolley"  },
				EquipWeapons = { "HydraDart" },
			},

			[2] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = {"HydraDart", "HydraDartVolley", "HydraLunge", "HydraSlam" },
				EquipWeapons = { "HydraLungeUntethered", "HydraSlamUntethered" },
			},

			[3] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = {"HydraDart", "HydraDartVolley", "HydraLunge", "HydraSlam" },
				EquipWeapons = { "HydraLungeUntethered", "HydraSlamUntethered" },
			},

			[4] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = {"HydraDart", "HydraDartVolley", "HydraLunge", "HydraSlam" },
				EquipWeapons = { "HydraLungeUntethered", "HydraSlamUntethered" },
			},
		},

		PactDataStage3 =
		{
			Default = {
				UnequipWeapons = { "HydraSlam", "HydraDart" },
				EquipWeapons = { "HydraSlamFrenzy", "HydraDartVolley" },
			},

			[2] = {
				EquipWeapons = { "HydraDartVolley" },
			},
			[3] = {
				EquipWeapons = { "HydraDartVolley" },
			},
			[4] = {
				EquipWeapons = { "HydraDartVolley" },
			},
		},

		BecameInvulnerableGlobalVoiceLines = "HydraHeadsDefeatedVoiceLines",
		DestroyTethersOnDeath = true,
		Tethers =
		{
			{ Name = "HydraNeck", Distance = 73, RetractSpeed = 500, TrackZRatio = 0.2, Count = 9 },
			{ Name = "HydraBase", Distance = 60 },
			{ Name = "AsphodelLavaRippleHydra", Distance = 15, GroupName = "Lava_FX" },
		},
		DetachedNeckCount = 5,
		DetachedNeckAnimation = "HydraNeckBroken",

		AmmoDropOnDeath =
		{
			Chance = 0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		GeneratorData =
		{
			DifficultyRating = 1,
		},
	},

	HydraHeadImmortalLavamaker =
	{
		InheritFrom = { "HydraHeadImmortal"  },
		GenusName = "HydraHeadImmortal",
		RequiredKills = { HydraHeadImmortal = 3 },

		WeaponOptions =
		{
			"HydraLunge", "HydraSlam", "HydraLavaSpit", "HydraLavaSpit", "HydraLavaSpitInterior"
		},

		PactDataStage0 =
		{
			Default = {
				EquipWeapons = { "HydraLavaSpitExterior" },
			},
		},

		PactDataStage1 =
		{
			Default = {
				UnequipWeapons = { "HydraLavaSpitExterior", "HydraLavaSpit", "HydraLavaSpit" },
				EquipWeapons = { "HydraLavaSpit2", "HydraLavaSpit2" },
			},
		},

		PactDataStage2 =
		{
			Default = {
				TransitionFunction = "HydraStageTransition",
				EquipWeapons = {"HydraLavaSpitExterior" },
			},

			[2] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = { "HydraLunge", "HydraSlam", "HydraLavaSpitExterior", "HydraLavaSpitInterior" },
				EquipWeapons = { "HydraLungeUntethered", "HydraSlamUntethered" },
			},

			[3] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = { "HydraLunge", "HydraSlam", "HydraLavaSpitExterior", "HydraLavaSpitInterior" },
				EquipWeapons = { "HydraLungeUntethered", "HydraSlamUntethered" },
			},

			[4] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = { "HydraLunge", "HydraSlam", "HydraLavaSpitExterior", "HydraLavaSpitInterior" },
				EquipWeapons = { "HydraLungeUntethered", "HydraSlamUntethered" },
			},
		},

		PactDataStage3 =
		{
			Default = {
				UnequipWeapons = { "HydraSlam", "HydraLavaSpit2", "HydraLavaSpit2" },
				EquipWeapons = { "HydraSlamFrenzy", "HydraLavaSpitFrenzy" },
			},

			[2] = {
				EquipWeapons = { "HydraLavaSpitFrenzy" },
			},
			[3] = {
				EquipWeapons = { "HydraLavaSpitFrenzy" },
			},
			[4] = {
				EquipWeapons = { "HydraLavaSpitFrenzy" },
			},
		},

		SwapAnimations =
		{
			["EnemyHydraIdle"] = "EnemyHydraOrangeIdle",
			["EnemyHydraMove"] = "EnemyHydraOrangeMove",
			["EnemyHydraRoarPreAttack"] = "EnemyHydraOrangeRoarPreAttack",
			["EnemyHydraRoarFire"] = "EnemyHydraOrangeRoarFire",
			["EnemyHydraRoarFire_Loop"] = "EnemyHydraOrangeRoarFire_Loop",
			["EnemyHydraRoarReturnToIdle"] = "EnemyHydraOrangeRoarReturnToIdle",
			["EnemyHydraTaunt"] = "EnemyHydraOrangeTaunt",
			["EnemyHydraOnHit_1"] = "EnemyHydraOrangeOnHit_1",
			["EnemyHydraOnHit_2"] = "EnemyHydraOrangeOnHit_2",
			["EnemyHydraBite_Charge"] = "EnemyHydraOrangeBite_Charge",
			["EnemyHydraBite_Charge2"] = "EnemyHydraOrangeBite_Charge2",
			["EnemyHydraBite_Attack"] = "EnemyHydraOrangeBite_Attack",
			["EnemyHydraDeath"] = "EnemyHydraOrangeDeath",
			["EnemyHydraMouthOpening_Start"] = "EnemyHydraOrangeMouthOpening_Start",
			["EnemyHydraMouthOpening_Loop"] = "EnemyHydraOrangeMouthOpening_Loop",
			["EnemyHydraMouthOpening_End"] = "EnemyHydraOrangeMouthOpening_End",
			["EnemyHydraHealing"] = "EnemyHydraOrangeHealing",
			["EnemyHydraSlamCharge"] = "EnemyHydraOrangeSlamCharge",
			["EnemyHydraSlamFire"] = "EnemyHydraOrangeSlamFire",
			["EnemyHydraRecover"] = "EnemyHydraOrangeRecover",
			["EnemyHydraRangedPreAttack"] = "EnemyHydraOrangeRangedPreAttack",
			["EnemyHydraRangedFire"] = "EnemyHydraOrangeRangedFire",
			["EnemyHydraRangedFireLoop"] = "EnemyHydraOrangeRangedFireLoop",
			["EnemyHydraRangedPostAttack"] = "EnemyHydraOrangeRangedPostAttack",
			["EnemyHydraLungePreAttack"] = "EnemyHydraOrangeLungePreAttack",
			["EnemyHydraLungeChargeLoop"] = "EnemyHydraOrangeLungeChargeLoop",
			["EnemyHydraLungeFire"] = "EnemyHydraOrangeLungeFire",
			["EnemyHydraLungeReturnToIdle"] = "EnemyHydraOrangeLungeReturnToIdle",
			["EnemyHydraSleep_Loop"] = "EnemyHydraOrangeSleep_Loop",
			["EnemyHydraSleep_Wake"] = "EnemyHydraOrangeSleep_Wake",
		},

		Binks =
		{
			"Enemy_HydraOrange_Roar_Bink",
			"Enemy_HydraOrange_OnHit_Bink",
			"Enemy_HydraOrange_MouthOpening_Bink",
			"Enemy_HydraOrange_Slam_Bink",
			"Enemy_HydraOrange_Idle_Bink",
			"Enemy_HydraOrange_Ranged_Bink",
			"Enemy_Hydra_DeathVFX_Bink",
			"Enemy_HydraOrange_Lunge_Bink",
			"Enemy_HydraOrange_Sleep_Bink",
		},
	},

	HydraHeadImmortalSummoner =
	{
		InheritFrom = { "HydraHeadImmortal"  },
		GenusName = "HydraHeadImmortal",
		RequiredKills = { HydraHeadImmortal = 3 },

		WeaponOptions =
		{
			"HydraLunge", "HydraSlam", "HydraSummonSpread", "HydraCrusher"
		},

		PactDataStage0 =
		{
			Default = {
				UnequipWeapons = { "HydraCrusher", "HydraSummonSpread" },
				EquipWeapons = { "HydraSummon2" },
			},
		},

		PactDataStage1 =
		{
			Default = {
				UnequipWeapons = { "HydraSummon2", },
				EquipWeapons = { "HydraSummonSpread2", "HydraCrusher2" },
			},
		},

		PactDataStage2 =
		{
			Default = {
				TransitionFunction = "HydraStageTransition",
				UnequipWeapons = { "HydraCrusher2", "HydraSummonSpread2" },
				EquipWeapons = {"HydraSummon2" },
			},

			[2] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = { "HydraLunge", "HydraSlam", "HydraCrusher2", "HydraSummonSpread2" },
				EquipWeapons = { "HydraLungeUntethered", "HydraSlamUntethered", "HydraSummon2" },
			},

			[3] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = { "HydraLunge", "HydraSlam", "HydraCrusher2", "HydraSummonSpread2" },
				EquipWeapons = { "HydraLungeUntethered", "HydraSlamUntethered", "HydraSummon2" },
			},

			[4] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = { "HydraLunge", "HydraSlam", "HydraCrusher2", "HydraSummonSpread2" },
				EquipWeapons = { "HydraLungeUntethered", "HydraSlamUntethered", "HydraSummon2" },
			},
		},

		PactDataStage3 =
		{
			Default = {
				UnequipWeapons = { "HydraSlam", "HydraSummon2" },
				EquipWeapons = { "HydraSlamFrenzy", "HydraSummonSpread3", "HydraCrusher3" },
			},

			[2] = {
				UnequipWeapons = { "HydraSummon2" },
				EquipWeapons = { "HydraSummonSpread3", "HydraCrusher3" },
			},
			[3] = {
				UnequipWeapons = { "HydraSummon2" },
				EquipWeapons = { "HydraSummonSpread3", "HydraCrusher3" },
			},
			[4] = {
				UnequipWeapons = { "HydraSummon2" },
				EquipWeapons = { "HydraSummonSpread3", "HydraCrusher3" },
			},
		},

		SwapAnimations =
		{
			["EnemyHydraIdle"] = "EnemyHydraGreenIdle",
			["EnemyHydraMove"] = "EnemyHydraGreenMove",
			["EnemyHydraRoarPreAttack"] = "EnemyHydraGreenRoarPreAttack",
			["EnemyHydraRoarFire"] = "EnemyHydraGreenRoarFire",
			["EnemyHydraRoarFire_Loop"] = "EnemyHydraGreenRoarFire_Loop",
			["EnemyHydraRoarReturnToIdle"] = "EnemyHydraGreenRoarReturnToIdle",
			["EnemyHydraTaunt"] = "EnemyHydraGreenTaunt",
			["EnemyHydraOnHit_1"] = "EnemyHydraGreenOnHit_1",
			["EnemyHydraOnHit_2"] = "EnemyHydraGreenOnHit_2",
			["EnemyHydraBite_Charge"] = "EnemyHydraGreenBite_Charge",
			["EnemyHydraBite_Charge2"] = "EnemyHydraGreenBite_Charge2",
			["EnemyHydraBite_Attack"] = "EnemyHydraGreenBite_Attack",
			["EnemyHydraDeath"] = "EnemyHydraGreenDeath",
			["EnemyHydraMouthOpening_Start"] = "EnemyHydraGreenMouthOpening_Start",
			["EnemyHydraMouthOpening_Loop"] = "EnemyHydraGreenMouthOpening_Loop",
			["EnemyHydraMouthOpening_End"] = "EnemyHydraGreenMouthOpening_End",
			["EnemyHydraHealing"] = "EnemyHydraGreenHealing",
			["EnemyHydraSlamCharge"] = "EnemyHydraGreenSlamCharge",
			["EnemyHydraSlamFire"] = "EnemyHydraGreenSlamFire",
			["EnemyHydraRecover"] = "EnemyHydraGreenRecover",
			["EnemyHydraRangedPreAttack"] = "EnemyHydraGreenRangedPreAttack",
			["EnemyHydraRangedFire"] = "EnemyHydraGreenRangedFire",
			["EnemyHydraRangedFireLoop"] = "EnemyHydraGreenRangedFireLoop",
			["EnemyHydraRangedPostAttack"] = "EnemyHydraGreenRangedPostAttack",
			["EnemyHydraLungePreAttack"] = "EnemyHydraGreenLungePreAttack",
			["EnemyHydraLungeChargeLoop"] = "EnemyHydraGreenLungeChargeLoop",
			["EnemyHydraLungeFire"] = "EnemyHydraGreenLungeFire",
			["EnemyHydraLungeReturnToIdle"] = "EnemyHydraGreenLungeReturnToIdle",
			["EnemyHydraSleep_Loop"] = "EnemyHydraGreenSleep_Loop",
			["EnemyHydraSleep_Wake"] = "EnemyHydraGreenSleep_Wake",
		},

		Binks =
		{
			"Enemy_HydraGreen_Roar_Bink",
			"Enemy_HydraGreen_OnHit_Bink",
			"Enemy_HydraGreen_MouthOpening_Bink",
			"Enemy_HydraGreen_Slam_Bink",
			"Enemy_HydraGreen_Idle_Bink",
			"Enemy_HydraGreen_Ranged_Bink",
			"Enemy_Hydra_DeathVFX_Bink",
			"Enemy_HydraGreen_Lunge_Bink",
			"Enemy_HydraGreen_Sleep_Bink",
		},

		OtherEnemyBinks =
		{
			"BloodlessNakedBerserker",
		},
	},

	HydraHeadImmortalSlammer =
	{
		InheritFrom = { "HydraHeadImmortal"  },
		GenusName = "HydraHeadImmortal",
		RequiredKills = { HydraHeadImmortal = 3 },

		WeaponOptions =
		{
			"HydraLunge", "HydraBite", "HydraSlamScattered"
		},

		PactDataStage0 =
		{
			Default = {
				--UnequipWeapons = { "HydraSlamScattered" },
			},
		},

		PactDataStage1 =
		{
			Default = {
				EquipWeapons = { "HydraSlamScattered2" },
				UnequipWeapons = { "HydraSlamScattered" },
			},
		},

		PactDataStage2 =
		{
			Default = {
				TransitionFunction = "HydraStageTransition",
			},

			[2] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = { "HydraLunge" },
			},

			[3] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = { "HydraLunge" },
			},

			[4] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = { "HydraLunge" },
			},
		},

		PactDataStage3 =
		{
			Default = {
				UnequipWeapons = { "HydraSlamScattered2", "HydraLungeUntethered" },
				EquipWeapons = { "HydraSlamScatteredFrenzy", },
			},

			[2] = {
				EquipWeapons = { "HydraSlamScatteredFrenzy", },
			},
			[3] = {
				EquipWeapons = { "HydraSlamScatteredFrenzy", },
			},
			[4] = {
				EquipWeapons = { "HydraSlamScatteredFrenzy", },
			},
		},

		SwapAnimations =
		{
			["EnemyHydraIdle"] = "EnemyHydraBlueIdle",
			["EnemyHydraMove"] = "EnemyHydraBlueMove",
			["EnemyHydraRoarPreAttack"] = "EnemyHydraBlueRoarPreAttack",
			["EnemyHydraRoarFire"] = "EnemyHydraBlueRoarFire",
			["EnemyHydraRoarFire_Loop"] = "EnemyHydraBlueRoarFire_Loop",
			["EnemyHydraRoarReturnToIdle"] = "EnemyHydraBlueRoarReturnToIdle",
			["EnemyHydraTaunt"] = "EnemyHydraBlueTaunt",
			["EnemyHydraOnHit_1"] = "EnemyHydraBlueOnHit_1",
			["EnemyHydraOnHit_2"] = "EnemyHydraBlueOnHit_2",
			["EnemyHydraBite_Charge"] = "EnemyHydraBlueBite_Charge",
			["EnemyHydraBite_Charge2"] = "EnemyHydraBlueBite_Charge2",
			["EnemyHydraBite_Attack"] = "EnemyHydraBlueBite_Attack",
			["EnemyHydraDeath"] = "EnemyHydraBlueDeath",
			["EnemyHydraMouthOpening_Start"] = "EnemyHydraBlueMouthOpening_Start",
			["EnemyHydraMouthOpening_Loop"] = "EnemyHydraBlueMouthOpening_Loop",
			["EnemyHydraMouthOpening_End"] = "EnemyHydraBlueMouthOpening_End",
			["EnemyHydraHealing"] = "EnemyHydraBlueHealing",
			["EnemyHydraSlamCharge"] = "EnemyHydraBlueSlamCharge",
			["EnemyHydraSlamFire"] = "EnemyHydraBlueSlamFire",
			["EnemyHydraRecover"] = "EnemyHydraBlueRecover",
			["EnemyHydraRangedPreAttack"] = "EnemyHydraBlueRangedPreAttack",
			["EnemyHydraRangedFire"] = "EnemyHydraBlueRangedFire",
			["EnemyHydraRangedFireLoop"] = "EnemyHydraBlueRangedFireLoop",
			["EnemyHydraRangedPostAttack"] = "EnemyHydraBlueRangedPostAttack",
			["EnemyHydraLungePreAttack"] = "EnemyHydraBlueLungePreAttack",
			["EnemyHydraLungeChargeLoop"] = "EnemyHydraBlueLungeChargeLoop",
			["EnemyHydraLungeFire"] = "EnemyHydraBlueLungeFire",
			["EnemyHydraLungeReturnToIdle"] = "EnemyHydraBlueLungeReturnToIdle",
			["EnemyHydraSleep_Loop"] = "EnemyHydraBlueSleep_Loop",
			["EnemyHydraSleep_Wake"] = "EnemyHydraBlueSleep_Wake",
		},

		Binks =
		{
			"Enemy_HydraBlue_Roar_Bink",
			"Enemy_HydraBlue_OnHit_Bink",
			"Enemy_HydraBlue_MouthOpening_Bink",
			"Enemy_HydraBlue_Slam_Bink",
			"Enemy_HydraBlue_Idle_Bink",
			"Enemy_HydraBlue_Ranged_Bink",
			"Enemy_Hydra_DeathVFX_Bink",
			"Enemy_HydraBlue_Lunge_Bink",
			"Enemy_HydraBlue_Sleep_Bink",
		},
	},

	HydraHeadImmortalWavemaker =
	{
		InheritFrom = { "HydraHeadImmortal"  },
		GenusName = "HydraHeadImmortal",
		RequiredKills = { HydraHeadImmortal = 3 },

		WeaponOptions =
		{
			"HydraLunge", "HydraSlam", "HydraRoar2"
		},

		PactDataStage0 =
		{
			Default = {
				EquipWeapons = { "HydraRoarVolleyLeft", "HydraRoarVolleyRight" },
			},
		},

		PactDataStage1 =
		{
			Default = {
				UnequipWeapons = { "HydraRoarVolleyLeft", "HydraRoarVolleyRight", "HydraRoar2" },
				EquipWeapons = { "HydraRoar3" },
			},
		},

		PactDataStage2 =
		{
			Default = {
				TransitionFunction = "HydraStageTransition",
				UnequipWeapons = { "HydraRoar3" },
				EquipWeapons = { "HydraRoarVolleyLeft", "HydraRoarVolleyRight", "HydraRoarVolleyInsideOut" },
			},

			[2] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = { "HydraLunge", "HydraSlam", "HydraRoar3" },
				EquipWeapons = { "HydraLungeUntethered", "HydraSlamUntethered", "HydraRoarVolleyLeft", "HydraRoarVolleyRight", "HydraRoarVolleyInsideOut" },
			},

			[3] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = { "HydraLunge", "HydraSlam", "HydraRoar3" },
				EquipWeapons = { "HydraLungeUntethered", "HydraSlamUntethered", "HydraRoarVolleyLeft", "HydraRoarVolleyRight", "HydraRoarVolleyInsideOut" },
			},

			[4] = {
				TransitionFunction = "HydraFinalStageTransition",
				UnequipWeapons = { "HydraLunge", "HydraSlam", "HydraRoar3" },
				EquipWeapons = { "HydraLungeUntethered", "HydraSlamUntethered", "HydraRoarVolleyLeft", "HydraRoarVolleyRight", "HydraRoarVolleyInsideOut" },
			},
		},

		PactDataStage3 =
		{
			Default = {
				UnequipWeapons = { "HydraSlam", "HydraRoarVolleyLeft", "HydraRoarVolleyRight", "HydraRoarVolleyInsideOut" },
				EquipWeapons = { "HydraSlamFrenzy", "HydraRoar2Frenzy", "HydraRoar3" },
			},

			[2] = {
				UnequipWeapons = { "HydraRoarVolleyLeft", "HydraRoarVolleyRight", "HydraRoarVolleyInsideOut" },
				EquipWeapons = { "HydraRoar2Frenzy", "HydraRoar3" },
			},
			[3] = {
				UnequipWeapons = { "HydraRoarVolleyLeft", "HydraRoarVolleyRight", "HydraRoarVolleyInsideOut" },
				EquipWeapons = { "HydraRoar2Frenzy", "HydraRoar3" },
			},
			[4] = {
				UnequipWeapons = { "HydraRoarVolleyLeft", "HydraRoarVolleyRight", "HydraRoarVolleyInsideOut" },
				EquipWeapons = { "HydraRoar2Frenzy", "HydraRoar3" },
			},
		},

		SwapAnimations =
		{
			["EnemyHydraIdle"] = "EnemyHydraPurpleIdle",
			["EnemyHydraMove"] = "EnemyHydraPurpleMove",
			["EnemyHydraRoarPreAttack"] = "EnemyHydraPurpleRoarPreAttack",
			["EnemyHydraRoarFire"] = "EnemyHydraPurpleRoarFire",
			["EnemyHydraRoarFire_Loop"] = "EnemyHydraPurpleRoarFire_Loop",
			["EnemyHydraRoarReturnToIdle"] = "EnemyHydraPurpleRoarReturnToIdle",
			["EnemyHydraTaunt"] = "EnemyHydraPurpleTaunt",
			["EnemyHydraOnHit_1"] = "EnemyHydraPurpleOnHit_1",
			["EnemyHydraOnHit_2"] = "EnemyHydraPurpleOnHit_2",
			["EnemyHydraBite_Charge"] = "EnemyHydraPurpleBite_Charge",
			["EnemyHydraBite_Charge2"] = "EnemyHydraPurpleBite_Charge2",
			["EnemyHydraBite_Attack"] = "EnemyHydraPurpleBite_Attack",
			["EnemyHydraDeath"] = "EnemyHydraPurpleDeath",
			["EnemyHydraMouthOpening_Start"] = "EnemyHydraPurpleMouthOpening_Start",
			["EnemyHydraMouthOpening_Loop"] = "EnemyHydraPurpleMouthOpening_Loop",
			["EnemyHydraMouthOpening_End"] = "EnemyHydraPurpleMouthOpening_End",
			["EnemyHydraHealing"] = "EnemyHydraPurpleHealing",
			["EnemyHydraSlamCharge"] = "EnemyHydraPurpleSlamCharge",
			["EnemyHydraSlamFire"] = "EnemyHydraPurpleSlamFire",
			["EnemyHydraRecover"] = "EnemyHydraPurpleRecover",
			["EnemyHydraRangedPreAttack"] = "EnemyHydraPurpleRangedPreAttack",
			["EnemyHydraRangedFire"] = "EnemyHydraPurpleRangedFire",
			["EnemyHydraRangedFireLoop"] = "EnemyHydraPurpleRangedFireLoop",
			["EnemyHydraRangedPostAttack"] = "EnemyHydraPurpleRangedPostAttack",
			["EnemyHydraLungePreAttack"] = "EnemyHydraPurpleLungePreAttack",
			["EnemyHydraLungeChargeLoop"] = "EnemyHydraPurpleLungeChargeLoop",
			["EnemyHydraLungeFire"] = "EnemyHydraPurpleLungeFire",
			["EnemyHydraLungeReturnToIdle"] = "EnemyHydraPurpleLungeReturnToIdle",
			["EnemyHydraSleep_Loop"] = "EnemyHydraPurpleSleep_Loop",
			["EnemyHydraSleep_Wake"] = "EnemyHydraPurpleSleep_Wake",
		},

		Binks =
		{
			"Enemy_HydraPurple_Roar_Bink",
			"Enemy_HydraPurple_OnHit_Bink",
			"Enemy_HydraPurple_MouthOpening_Bink",
			"Enemy_HydraPurple_Slam_Bink",
			"Enemy_HydraPurple_Idle_Bink",
			"Enemy_HydraPurple_Ranged_Bink",
			"Enemy_Hydra_DeathVFX_Bink",
			"Enemy_HydraPurple_Lunge_Bink",
			"Enemy_HydraPurple_Sleep_Bink",
		},
	},

	BaseHydraHead =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		Groups = { "GroundEnemies" },
		Material = "Organic",

		MaxHealth = 410,
		HealthBuffer = 410,
		HitSparkScale = 3.0,
		HitSparkOffsetZ = 175,

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedSkeleton",
			Rapid = "HitSparkEnemyDamagedSkeletonRapid",
		},
		DeathFx = "ExplosionBone",
		DeathAnimation = "EnemyHydraDeathVFX",
		ClearChillOnDeath = true,
		DeathSound = "/SFX/Enemy Sounds/HydraHead/EmoteFinalDying2",
		DestroyDelay = 1.5,
		HaltOnDeath = true,

		--RespawnOnDeath = true,
		--RespawnDelay = 25.0,
		--OnSpawnFireFunction = "HydraHeadSpawn",
		--OnDeathFunctionName = "HydraHeadDeath",

		WeaponOptions =
		{
			"HydraBite"
		},
		DisarmedWeapon = "HydraBite",

		AIOptions =
		{
			AttackerAI,
		},

		DefaultAIData =
		{
			PostAttackCooldown = 0.0,
			RetreatAfterAttack = false,
			AIBufferDistance = 400,
			--SurroundDistance = 400,
			AIAttackDistance = 700,
			--StandOffTime = 2.0,
			--MaxAttackers = 1,
			--PreAttackEndShake = true,
		},

		DestroyTethersOnDeath = true,
		Tethers =
		{
			{ Name = "HydraNeckMelee", Distance = 73, RetractSpeed = 500, TrackZRatio = 0.2, Count = 7 },
			{ Name = "HydraBaseMelee", Distance = 45 },
			{ Name = "AsphodelLavaRippleHydra", Distance = 15, GroupName = "Lava_FX" },
		},

		AmmoDropOnDeath =
		{
			Chance = 0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		GeneratorData =
		{
			DifficultyRating = 20,
		},
	},

	HydraHeadDartmaker =
	{
		InheritFrom = { "BaseHydraHead" },
		IsAggroedSound = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted",

		WeaponOptions =
		{
			"HydraBite", "HydraDart"
		},

		Outline =
        {
			R = 255,
			G = 255,
			B = 0,
            Opacity = 0.8,
            Thickness = 0,
            Threshold = 0.2,
        },

		SwapAnimations = {},

		Binks =
		{
			"Enemy_Hydra_Roar_Bink",
			"Enemy_Hydra_OnHit_Bink",
			"Enemy_Hydra_MouthOpening_Bink",
			"Enemy_Hydra_Idle_Bink",
			"Enemy_Hydra_Ranged_Bink",
			"Enemy_Hydra_DeathVFX_Bink",
		},
	},

	HydraHeadLavamaker =
	{
		InheritFrom = { "BaseHydraHead" },
		IsAggroedSound = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted",

		WeaponOptions =
		{
			"HydraBite", "HydraLavaSpit"
		},

		Outline =
        {
			R = 255,
			G = 255,
			B = 0,
            Opacity = 0.8,
            Thickness = 0,
            Threshold = 0.2,
        },

		SwapAnimations =
		{
			["EnemyHydraIdle"] = "EnemyHydraOrangeIdle",
			["EnemyHydraMove"] = "EnemyHydraOrangeMove",
			["EnemyHydraRoarPreAttack"] = "EnemyHydraOrangeRoarPreAttack",
			["EnemyHydraRoarFire"] = "EnemyHydraOrangeRoarFire",
			["EnemyHydraRoarFire_Loop"] = "EnemyHydraOrangeRoarFire_Loop",
			["EnemyHydraRoarReturnToIdle"] = "EnemyHydraOrangeRoarReturnToIdle",
			["EnemyHydraTaunt"] = "EnemyHydraOrangeTaunt",
			["EnemyHydraOnHit_1"] = "EnemyHydraOrangeOnHit_1",
			["EnemyHydraOnHit_2"] = "EnemyHydraOrangeOnHit_2",
			["EnemyHydraBite_Charge"] = "EnemyHydraOrangeBite_Charge",
			["EnemyHydraBite_Charge2"] = "EnemyHydraOrangeBite_Charge2",
			["EnemyHydraBite_Attack"] = "EnemyHydraOrangeBite_Attack",
			["EnemyHydraDeath"] = "EnemyHydraOrangeDeath",
			["EnemyHydraMouthOpening_Start"] = "EnemyHydraOrangeMouthOpening_Start",
			["EnemyHydraMouthOpening_Loop"] = "EnemyHydraOrangeMouthOpening_Loop",
			["EnemyHydraMouthOpening_End"] = "EnemyHydraOrangeMouthOpening_End",
			["EnemyHydraHealing"] = "EnemyHydraOrangeHealing",
			["EnemyHydraSlamCharge"] = "EnemyHydraOrangeSlamCharge",
			["EnemyHydraSlamFire"] = "EnemyHydraOrangeSlamFire",
			["EnemyHydraRecover"] = "EnemyHydraOrangeRecover",
			["EnemyHydraRangedPreAttack"] = "EnemyHydraOrangeRangedPreAttack",
			["EnemyHydraRangedFire"] = "EnemyHydraOrangeRangedFire",
			["EnemyHydraRangedFireLoop"] = "EnemyHydraOrangeRangedFireLoop",
			["EnemyHydraRangedPostAttack"] = "EnemyHydraOrangeRangedPostAttack",
			["EnemyHydraLungePreAttack"] = "EnemyHydraOrangeLungePreAttack",
			["EnemyHydraLungeChargeLoop"] = "EnemyHydraOrangeLungeChargeLoop",
			["EnemyHydraLungeFire"] = "EnemyHydraOrangeLungeFire",
			["EnemyHydraLungeReturnToIdle"] = "EnemyHydraOrangeLungeReturnToIdle",
			["EnemyHydraSleep_Loop"] = "EnemyHydraOrangeSleep_Loop",
			["EnemyHydraSleep_Wake"] = "EnemyHydraOrangeSleep_Wake",
		},

		Binks =
		{
			"Enemy_HydraOrange_Roar_Bink",
			"Enemy_HydraOrange_OnHit_Bink",
			"Enemy_HydraOrange_MouthOpening_Bink",
			"Enemy_HydraOrange_Idle_Bink",
			"Enemy_HydraOrange_Ranged_Bink",
			"Enemy_Hydra_DeathVFX_Bink",
		},
	},

	HydraHeadSummoner =
	{
		InheritFrom = { "BaseHydraHead" },
		IsAggroedSound = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted",

		WeaponOptions =
		{
			"HydraBite", "HydraSummon"
		},

		Outline =
         {
			R = 255,
			G = 255,
			B = 0,
            Opacity = 0.8,
            Thickness = 0,
            Threshold = 0.2,
         },

		SwapAnimations =
		{
			["EnemyHydraIdle"] = "EnemyHydraGreenIdle",
			["EnemyHydraMove"] = "EnemyHydraGreenMove",
			["EnemyHydraRoarPreAttack"] = "EnemyHydraGreenRoarPreAttack",
			["EnemyHydraRoarFire"] = "EnemyHydraGreenRoarFire",
			["EnemyHydraRoarFire_Loop"] = "EnemyHydraGreenRoarFire_Loop",
			["EnemyHydraRoarReturnToIdle"] = "EnemyHydraGreenRoarReturnToIdle",
			["EnemyHydraTaunt"] = "EnemyHydraGreenTaunt",
			["EnemyHydraOnHit_1"] = "EnemyHydraGreenOnHit_1",
			["EnemyHydraOnHit_2"] = "EnemyHydraGreenOnHit_2",
			["EnemyHydraBite_Charge"] = "EnemyHydraGreenBite_Charge",
			["EnemyHydraBite_Charge2"] = "EnemyHydraGreenBite_Charge2",
			["EnemyHydraBite_Attack"] = "EnemyHydraGreenBite_Attack",
			["EnemyHydraDeath"] = "EnemyHydraGreenDeath",
			["EnemyHydraMouthOpening_Start"] = "EnemyHydraGreenMouthOpening_Start",
			["EnemyHydraMouthOpening_Loop"] = "EnemyHydraGreenMouthOpening_Loop",
			["EnemyHydraMouthOpening_End"] = "EnemyHydraGreenMouthOpening_End",
			["EnemyHydraHealing"] = "EnemyHydraGreenHealing",
			["EnemyHydraSlamCharge"] = "EnemyHydraGreenSlamCharge",
			["EnemyHydraSlamFire"] = "EnemyHydraGreenSlamFire",
			["EnemyHydraRecover"] = "EnemyHydraGreenRecover",
			["EnemyHydraRangedPreAttack"] = "EnemyHydraGreenRangedPreAttack",
			["EnemyHydraRangedFire"] = "EnemyHydraGreenRangedFire",
			["EnemyHydraRangedFireLoop"] = "EnemyHydraGreenRangedFireLoop",
			["EnemyHydraRangedPostAttack"] = "EnemyHydraGreenRangedPostAttack",
			["EnemyHydraLungePreAttack"] = "EnemyHydraGreenLungePreAttack",
			["EnemyHydraLungeChargeLoop"] = "EnemyHydraGreenLungeChargeLoop",
			["EnemyHydraLungeFire"] = "EnemyHydraGreenLungeFire",
			["EnemyHydraLungeReturnToIdle"] = "EnemyHydraGreenLungeReturnToIdle",
			["EnemyHydraSleep_Loop"] = "EnemyHydraOrangeSleep_Loop",
			["EnemyHydraSleep_Wake"] = "EnemyHydraOrangeSleep_Wake",
		},

		Binks =
		{
			"Enemy_HydraGreen_OnHit_Bink",
			"Enemy_HydraGreen_MouthOpening_Bink",
			"Enemy_HydraGreen_Idle_Bink",
			"Enemy_Hydra_DeathVFX_Bink",
		},
	},

	HydraHeadSlammer =
	{
		InheritFrom = { "BaseHydraHead" },
		IsAggroedSound = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted",

		WeaponOptions =
		{
			"HydraBite", "HydraSlam"
		},

		Outline =
        {
			R = 255,
			G = 255,
			B = 0,
            Opacity = 0.8,
            Thickness = 0,
            Threshold = 0.2,
        },

		SwapAnimations =
		{
			["EnemyHydraIdle"] = "EnemyHydraBlueIdle",
			["EnemyHydraMove"] = "EnemyHydraBlueMove",
			["EnemyHydraRoarPreAttack"] = "EnemyHydraBlueRoarPreAttack",
			["EnemyHydraRoarFire"] = "EnemyHydraBlueRoarFire",
			["EnemyHydraRoarFire_Loop"] = "EnemyHydraBlueRoarFire_Loop",
			["EnemyHydraRoarReturnToIdle"] = "EnemyHydraBlueRoarReturnToIdle",
			["EnemyHydraTaunt"] = "EnemyHydraBlueTaunt",
			["EnemyHydraOnHit_1"] = "EnemyHydraBlueOnHit_1",
			["EnemyHydraOnHit_2"] = "EnemyHydraBlueOnHit_2",
			["EnemyHydraBite_Charge"] = "EnemyHydraBlueBite_Charge",
			["EnemyHydraBite_Charge2"] = "EnemyHydraBlueBite_Charge2",
			["EnemyHydraBite_Attack"] = "EnemyHydraBlueBite_Attack",
			["EnemyHydraDeath"] = "EnemyHydraBlueDeath",
			["EnemyHydraMouthOpening_Start"] = "EnemyHydraBlueMouthOpening_Start",
			["EnemyHydraMouthOpening_Loop"] = "EnemyHydraBlueMouthOpening_Loop",
			["EnemyHydraMouthOpening_End"] = "EnemyHydraBlueMouthOpening_End",
			["EnemyHydraHealing"] = "EnemyHydraBlueHealing",
			["EnemyHydraSlamCharge"] = "EnemyHydraBlueSlamCharge",
			["EnemyHydraSlamFire"] = "EnemyHydraBlueSlamFire",
			["EnemyHydraRecover"] = "EnemyHydraBlueRecover",
			["EnemyHydraRangedPreAttack"] = "EnemyHydraBlueRangedPreAttack",
			["EnemyHydraRangedFire"] = "EnemyHydraBlueRangedFire",
			["EnemyHydraRangedFireLoop"] = "EnemyHydraBlueRangedFireLoop",
			["EnemyHydraRangedPostAttack"] = "EnemyHydraBlueRangedPostAttack",
			["EnemyHydraLungePreAttack"] = "EnemyHydraBlueLungePreAttack",
			["EnemyHydraLungeChargeLoop"] = "EnemyHydraBlueLungeChargeLoop",
			["EnemyHydraLungeFire"] = "EnemyHydraBlueLungeFire",
			["EnemyHydraLungeReturnToIdle"] = "EnemyHydraBlueLungeReturnToIdle",
			["EnemyHydraSleep_Loop"] = "EnemyHydraBlueSleep_Loop",
			["EnemyHydraSleep_Wake"] = "EnemyHydraBlueSleep_Wake",
		},

		Binks =
		{
			"Enemy_HydraBlue_OnHit_Bink",
			"Enemy_HydraBlue_Slam_Bink",
			"Enemy_HydraBlue_Idle_Bink",
			"Enemy_Hydra_DeathVFX_Bink",
		},
	},

	HydraHeadWavemaker =
	{
		InheritFrom = { "BaseHydraHead" },
		IsAggroedSound = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted",

		WeaponOptions =
		{
			"HydraBite", "HydraRoar"
		},

		Outline =
        {
			R = 255,
			G = 255,
			B = 0,
            Opacity = 0.8,
            Thickness = 0,
            Threshold = 0.2,
        },

		SwapAnimations =
		{
			["EnemyHydraIdle"] = "EnemyHydraPurpleIdle",
			["EnemyHydraMove"] = "EnemyHydraPurpleMove",
			["EnemyHydraRoarPreAttack"] = "EnemyHydraPurpleRoarPreAttack",
			["EnemyHydraRoarFire"] = "EnemyHydraPurpleRoarFire",
			["EnemyHydraRoarFire_Loop"] = "EnemyHydraPurpleRoarFire_Loop",
			["EnemyHydraRoarReturnToIdle"] = "EnemyHydraPurpleRoarReturnToIdle",
			["EnemyHydraTaunt"] = "EnemyHydraPurpleTaunt",
			["EnemyHydraOnHit_1"] = "EnemyHydraPurpleOnHit_1",
			["EnemyHydraOnHit_2"] = "EnemyHydraPurpleOnHit_2",
			["EnemyHydraBite_Charge"] = "EnemyHydraPurpleBite_Charge",
			["EnemyHydraBite_Charge2"] = "EnemyHydraPurpleBite_Charge2",
			["EnemyHydraBite_Attack"] = "EnemyHydraPurpleBite_Attack",
			["EnemyHydraDeath"] = "EnemyHydraPurpleDeath",
			["EnemyHydraMouthOpening_Start"] = "EnemyHydraPurpleMouthOpening_Start",
			["EnemyHydraMouthOpening_Loop"] = "EnemyHydraPurpleMouthOpening_Loop",
			["EnemyHydraMouthOpening_End"] = "EnemyHydraPurpleMouthOpening_End",
			["EnemyHydraHealing"] = "EnemyHydraPurpleHealing",
			["EnemyHydraSlamCharge"] = "EnemyHydraPurpleSlamCharge",
			["EnemyHydraSlamFire"] = "EnemyHydraPurpleSlamFire",
			["EnemyHydraRecover"] = "EnemyHydraPurpleRecover",
			["EnemyHydraRangedPreAttack"] = "EnemyHydraPurpleRangedPreAttack",
			["EnemyHydraRangedFire"] = "EnemyHydraPurpleRangedFire",
			["EnemyHydraRangedFireLoop"] = "EnemyHydraPurpleRangedFireLoop",
			["EnemyHydraRangedPostAttack"] = "EnemyHydraPurpleRangedPostAttack",
			["EnemyHydraLungePreAttack"] = "EnemyHydraPurpleLungePreAttack",
			["EnemyHydraLungeChargeLoop"] = "EnemyHydraPurpleLungeChargeLoop",
			["EnemyHydraLungeFire"] = "EnemyHydraPurpleLungeFire",
			["EnemyHydraLungeReturnToIdle"] = "EnemyHydraPurpleLungeReturnToIdle",
			["EnemyHydraSleep_Loop"] = "EnemyHydraPurpleSleep_Loop",
			["EnemyHydraSleep_Wake"] = "EnemyHydraPurpleSleep_Wake",
		},

		Binks =
		{
			"Enemy_HydraPurple_Roar_Bink",
			"Enemy_HydraPurple_OnHit_Bink",
			"Enemy_HydraPurple_Idle_Bink",
			"Enemy_Hydra_DeathVFX_Bink",
		},
	},

	HydraTooth =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		HealthBarOffsetY = -100,

		MaxHealth = 50,

		PreAttackDuration = 5.0,
		PostAttackCooldown = 0.0,

		AIOptions = { AttackAndDie },
		DisplayAttackTimer = true,
		AttackTimerOffsetY = -60,
		AttackTimerEndThreshold = 1,
		AttackTimerEndSound = "/SFX/Enemy Sounds/HydraHead/HydraEggPreSpawn",
		AttackTimerEndShake = true,

		RequiredKill = false,

		WeaponOptions =
		{
			"HydraSpawns",
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
		},
	},

	HydraTooth2 =
	{
		InheritFrom = { "HydraTooth" },
		MaxHealth = 50,
		HealthBuffer = 35,
		PreAttackDuration = 5.0,
		WeaponOptions =
		{
			"HydraSpawns2",
		},

		Outline =
		{
			R = 255,
			G = 255,
			B = 0,
			Opacity = 0.8,
			Thickness = 2,
			Threshold = 0.6,
		},
	},

	HadesAmmo =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		IsBossDamage = true,

		MaxHealth = 250,
		HealthBarOffsetY = -210,
		HealthBarType = "Medium",

		DefaultAIData = {
			PreAttackDuration = 5.0,
			PostAttackCooldown = 0.0,
		},

		AIOptions = { AttackAndDie },
		DisplayAttackTimer = true,
		AttackTimerOffsetY = -200,

		RequiredKill = false,

		WeaponOptions =
		{
			"HadesAmmoWeapon",
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		ShrineMetaUpgradeName = "BossDifficultyShrineUpgrade",
		ShrineMetaUpgradeRequiredLevel = 4,
		ShrineDataOverwrites = { AddDumbFireWeaponsOnSpawn = { "HadesAmmoWeaponSlowPools" }, },
	},

	HadesTombstone =
	{
		InheritFrom = { "IsNeutral", "BaseVulnerableEnemy" },
		IsBossDamage = true,
		MaxHealth = 1,
		SkipDamageText = true,
		HideHealthBar = true,
		HideLevelDisplay = true,
		RequiredKill = false,

		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},
	},

	-- Elysium Boss
	-- Theseus
	Theseus =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		HealthBarTextId = "Theseus",
		Portrait = "Portrait_Theseus_Default_01",
		SpawnAnimation = "TheseusTaunt_Loop",
		TauntAnimation = "TheseusTaunt_ReturnToIdle",
		AnimOffsetZ = 220,
		EmoteOffsetX = -50,
		EmoteOffsetY = -250,

		GenusName = "Theseus",

		AdditionalEnemySetupFunctionName = "SelectTheseusGod",

		OnDeathCrowdReaction = { AnimationNames = { "StatusIconGrief", "StatusIconOhBoy", "StatusIconFear" }, Sound = "/SFX/TheseusCrowdBoo", ReactionChance = 0.15, Delay = 1.8, Requirements = { RequiredRoom = "C_Boss01" }, Shake = true, RadialBlur = true },

		AISetupDelay = 1.5,
		MaxHealth = 9000,
		StopBiomeTimerIfComboPartnerDead = true,

		EndThreadWaitsOnDeath = "TheseusMinotaurSpawns",
		EnrageOnDeath = "Minotaur",
		EnrageOnDeathStartDelay = 1.0,
		EnragedPresentation = "TheseusEnragedPresentation",
		ComboPartnerName = "Minotaur",
		ExpireComboPartnerEffectOnDeath = "BullRushSpeed",
		Groups = { "GroundEnemies" },

		Material = "Organic",
		HealthBarOffsetY = -275,
		--RepulseOnMeleeInvulnerableHit = 400,
		IgnoreInvincibubbleOnHit = true,
		DeathAnimation = "TheseusDeathVFX",
		ClearChillOnDeath = true,
		DestroyDelay = 5.0,

		EnragedWaitMultiplier = 0.8,

		DefaultAIData =
		{
			ComboPartnerName = "Minotaur",
		},

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		OnDeathFunctionName = "TheseusMinotaurKillPresentation",
		OnDeathFunctionArgs = { Message = "TheseusDefeatedMessage", StartPanTime = 1.5, EndPanTime = 3.5, StartSound = "/SFX/Enemy Sounds/HydraHead/EmoteAttacking", EndAngle = 270, FlashRed = true, AddInterBiomeTimerBlock = true },

		WeaponOptions =
		{
			"TheseusSpearThrow",
			"TheseusSpearSpin",
			"MinotaurTheseusThrow_Theseus", "MinotaurTheseusSlam_Theseus"--, "MinotaurTheseusXStrike_Theseus"
		},
		AIEndHealthThreshold = 0.50,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.50,
				},
			},
			{
				RandomAIFunctionNames = { "TheseusGodAI" },
				TransitionFunction = "BossStageTransition",
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
		},

		PlayerInjuredVoiceLineThreshold = 0.7,
		PlayerInjuredVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.75,
			CooldownTime = 40,
			CooldownName = "TheseusSpokeRecently",

			-- Suffer, fiend.
			{ Cue = "/VO/Theseus_0141" },
			-- There, you monster.
			{ Cue = "/VO/Theseus_0142" },
			-- There!
			{ Cue = "/VO/Theseus_0143" },
			-- Ha-hah!
			{ Cue = "/VO/Theseus_0144" },
			-- Hah!
			{ Cue = "/VO/Theseus_0145" },
			-- I shall scour you from this place.
			{ Cue = "/VO/Theseus_0146" },
			-- You see?
			{ Cue = "/VO/Theseus_0147" },
			-- Wide open.
			{ Cue = "/VO/Theseus_0148" },
			-- Too slow!
			{ Cue = "/VO/Theseus_0149" },
			-- Got you!
			{ Cue = "/VO/Theseus_0150" },
			-- How's that?
			{ Cue = "/VO/Theseus_0151" },
			-- You monster!
			{ Cue = "/VO/Theseus_0152" },
			-- Fiend!
			{ Cue = "/VO/Theseus_0153" },
			-- Hellspawn!
			{ Cue = "/VO/Theseus_0154" },
			-- Back!
			{ Cue = "/VO/Theseus_0155" },
			-- Back, fiend!
			{ Cue = "/VO/Theseus_0156" },
			-- Face me!
			{ Cue = "/VO/Theseus_0157" },
			-- Fall!
			{ Cue = "/VO/Theseus_0158" },
			-- Begone!
			{ Cue = "/VO/Theseus_0159" },
			-- Have at you!
			{ Cue = "/VO/Theseus_0160" },
			-- On your guard!
			{ Cue = "/VO/Theseus_0161" },
			-- Die, you blackguard.
			{ Cue = "/VO/Theseus_0162" },
			-- <Laugh>
			{ Cue = "/VO/Theseus_0072" },
			-- <Laugh>
			{ Cue = "/VO/Theseus_0073" },
			-- How now, daemon?!
			{ Cue = "/VO/Theseus_0395" },
			-- There, daemon!
			{ Cue = "/VO/Theseus_0396" },
			-- What now?!
			{ Cue = "/VO/Theseus_0397" },
		},
		LastStandReactionVoiceLineMinHealthThreshold = 0.3,
		LastStandReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 2.0,
			CooldownTime = 40,
			Queue = "Always",

			-- Hmm, indeed!
			{ Cue = "/VO/Theseus_0110" },
			-- Still alive eh?
			{ Cue = "/VO/Theseus_0111" },
			-- Let's finish this.
			{ Cue = "/VO/Theseus_0112" },
			-- I'll get you yet.
			{ Cue = "/VO/Theseus_0113" },
			-- We're not finished!
			{ Cue = "/VO/Theseus_0114" },
			-- Oh we're not finished.
			{ Cue = "/VO/Theseus_0115" },
			-- Stand and fight!
			{ Cue = "/VO/Theseus_0116" },
			-- Prepare to die!
			{ Cue = "/VO/Theseus_0117" },
			-- Return to hell!
			{ Cue = "/VO/Theseus_0118" },
			-- You should not be here!
			{ Cue = "/VO/Theseus_0119" },
			-- Gods smite you!
			{ Cue = "/VO/Theseus_0120" },
			-- You cannot prevail!
			{ Cue = "/VO/Theseus_0121" },
			-- Do you see?
			{ Cue = "/VO/Theseus_0122" },
			-- Stubborn fool!
			{ Cue = "/VO/Theseus_0123" },
			-- Give up!
			{ Cue = "/VO/Theseus_0124" },
			-- No mercy to monsters!
			{ Cue = "/VO/Theseus_0125" },
			-- Die with dignity!
			{ Cue = "/VO/Theseus_0126" },
			-- Take that!
			{ Cue = "/VO/Theseus_0070" },
			-- Die!
			{ Cue = "/VO/Theseus_0071" },
		},
		WrathReactionVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 1,
			CooldownTime = 60,
			SuccessiveChanceToPlay = 0.5,
			Queue = "Interrupt",

			-- What?
			{ Cue = "/VO/Theseus_0127" },
			-- Wha--?
			{ Cue = "/VO/Theseus_0128" },
			-- How?
			{ Cue = "/VO/Theseus_0129" },
			-- How is this--?
			{ Cue = "/VO/Theseus_0130" },
			-- So...!
			{ Cue = "/VO/Theseus_0131" },
			-- By the gods!
			{ Cue = "/VO/Theseus_0132" },
			-- Hrrngh!
			{ Cue = "/VO/Theseus_0133" },
			-- You cheat!
			{ Cue = "/VO/Theseus_0134" },
			-- Deceiver!
			{ Cue = "/VO/Theseus_0135" },
			-- Trickery!
			{ Cue = "/VO/Theseus_0136" },
			-- Treachery!
			{ Cue = "/VO/Theseus_0137" },
			-- Madness!
			{ Cue = "/VO/Theseus_0138" },
			-- Liar!!
			{ Cue = "/VO/Theseus_0139" },
			-- What's this?
			{ Cue = "/VO/Theseus_0140" },
			-- Bah!
			{ Cue = "/VO/Theseus_0407" },
			-- Betrayal!
			{ Cue = "/VO/Theseus_0408" },
			-- Why, gods?!
			{ Cue = "/VO/Theseus_0409" },
			-- Lord Zeus, what have I done?!
			{ Cue = "/VO/Theseus_0410", RequiredTrait = "ZeusShoutTrait" },
			-- Lord Zeus, do I offend?!
			{ Cue = "/VO/Theseus_0411", RequiredTrait = "ZeusShoutTrait" },
			-- Lord Poseidon, was I not your favored?
			{ Cue = "/VO/Theseus_0412", RequiredTrait = "PoseidonShoutTrait" },
			-- Lord Poseidon, why?!
			{ Cue = "/VO/Theseus_0413", RequiredTrait = "PoseidonShoutTrait" },
			-- Lord Poseidon, is this all because...?!
			{ Cue = "/VO/Theseus_0414", RequiredTrait = "PoseidonShoutTrait", RequiredPlayed = { "/VO/Theseus_0412", "/VO/Theseus_0413" }, },
			-- Lady Athena, please!!
			{ Cue = "/VO/Theseus_0415", RequiredTrait = "AthenaShoutTrait" },
			-- Lady Athena, forgive me!
			{ Cue = "/VO/Theseus_0416", RequiredTrait = "AthenaShoutTrait" },
			-- Artemis, why?!
			{ Cue = "/VO/Theseus_0417", RequiredTrait = "ArtemisShoutTrait" },
			-- Please, Lady Artemis!
			{ Cue = "/VO/Theseus_0418", RequiredTrait = "ArtemisShoutTrait" },
			-- Lord Ares, you oppose me?
			{ Cue = "/VO/Theseus_0419", RequiredTrait = "AresShoutTrait" },
			-- How typical, Lord Ares!!
			{ Cue = "/VO/Theseus_0420", RequiredTrait = "AresShoutTrait" },
			-- Dionysus, I've offended you?!
			{ Cue = "/VO/Theseus_0421", RequiredTrait = "DionysusShoutTrait" },
			-- But why, Lord Dionysus?!
			{ Cue = "/VO/Theseus_0422", RequiredTrait = "DionysusShoutTrait" },
			-- Dionysus, is this all because of Ariadne?!
			{ Cue = "/VO/Theseus_0423", RequiredTrait = "DionysusShoutTrait", RequiredPlayed = { "/VO/Theseus_0421", "/VO/Theseus_0422" }, },
			-- Why, Goddess Demeter?
			{ Cue = "/VO/Theseus_0446", RequiredTrait = "DemeterShoutTrait" },
			-- But Goddess Demeter, what did I do?!
			{ Cue = "/VO/Theseus_0447", RequiredTrait = "DemeterShoutTrait" },

			-- Who?!
			{ Cue = "/VO/Theseus_0351", RequiredTrait = "HadesShoutTrait" },
			-- Of course you need help!
			{ Cue = "/VO/Theseus_0359", RequiredTrait = "HadesShoutTrait" },
		},
		AssistReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.8,
				Queue = "Interrupt",
				RequiredTrait = "FuryAssistTrait",

				-- A Fury, here?!
				{ Cue = "/VO/Theseus_0339", RequiredPlayed = { "/VO/Theseus_0344" }, },
				-- Where did she come from?
				{ Cue = "/VO/Theseus_0340", RequiredPlayed = { "/VO/Theseus_0344" }, },
				-- The Fury Megaera!!
				{ Cue = "/VO/Theseus_0341", RequiredPlayed = { "/VO/Theseus_0344" }, },
				-- The Fury!
				{ Cue = "/VO/Theseus_0342", RequiredPlayed = { "/VO/Theseus_0344" }, },
				-- You cheat!!
				{ Cue = "/VO/Theseus_0343", RequiredPlayed = { "/VO/Theseus_0344" }, },
				-- Is that?!
				{ Cue = "/VO/Theseus_0344" },
				-- It's her!!
				{ Cue = "/VO/Theseus_0345", RequiredPlayed = { "/VO/Theseus_0344" }, },
				-- My lady Megaera!!
				{ Cue = "/VO/Theseus_0346", RequiredPlayed = { "/VO/Theseus_0344" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.8,
				Queue = "Interrupt",
				RequiredTrait = "ThanatosAssistTrait",

				-- What is Death doing here?
				{ Cue = "/VO/Theseus_0373", RequiredPlayed = { "/VO/Theseus_0380" } },
				-- Why is Death on his side?!
				{ Cue = "/VO/Theseus_0374", RequiredPlayed = { "/VO/Theseus_0380" } },
				-- Death has no business here!
				{ Cue = "/VO/Theseus_0375", RequiredPlayed = { "/VO/Theseus_0380" } },
				-- I'm not afraid of Death!
				{ Cue = "/VO/Theseus_0376", RequiredPlayed = { "/VO/Theseus_0380" } },
				-- You took me once already, Thanatos!
				{ Cue = "/VO/Theseus_0377", RequiredPlayed = { "/VO/Theseus_0380" } },
				-- Death returns?!
				{ Cue = "/VO/Theseus_0378", RequiredPlayed = { "/VO/Theseus_0380" } },
				-- Why is Death helping you?
				{ Cue = "/VO/Theseus_0379", RequiredPlayed = { "/VO/Theseus_0380" } },
				-- Thanatos!!
				{ Cue = "/VO/Theseus_0380" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.8,
				Queue = "Interrupt",
				RequiredTrait = "SkellyAssistTrait",

				-- Who is this wretch?!
				{ Cue = "/VO/Theseus_0365" },
				-- Begging your pardon?!
				{ Cue = "/VO/Theseus_0366", RequiredPlayed = { "/VO/Theseus_0365" } },
				-- Begone, foul skeleton!
				{ Cue = "/VO/Theseus_0367", RequiredPlayed = { "/VO/Theseus_0365" } },
				-- It's that damn skeleton!
				{ Cue = "/VO/Theseus_0368", RequiredPlayed = { "/VO/Theseus_0365" } },
				-- What is that doing here!
				{ Cue = "/VO/Theseus_0369", RequiredPlayed = { "/VO/Theseus_0365" } },
				-- You are unwelcome in Elysium!
				{ Cue = "/VO/Theseus_0370", RequiredPlayed = { "/VO/Theseus_0365" } },
				-- Get out of here, you skeleton!!
				{ Cue = "/VO/Theseus_0371", RequiredPlayed = { "/VO/Theseus_0365" } },
				-- Skeleton!
				{ Cue = "/VO/Theseus_0372", RequiredPlayed = { "/VO/Theseus_0365" } },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.8,
				Queue = "Interrupt",
				RequiredTrait = "SisyphusAssistTrait",

				-- Where did that come from?!
				{ Cue = "/VO/Theseus_0381" },
				-- Who is this miscreant?!
				{ Cue = "/VO/Theseus_0382", RequiredPlayed = { "/VO/Theseus_0381" } },
				-- A foul trap!!
				{ Cue = "/VO/Theseus_0383", RequiredPlayed = { "/VO/Theseus_0381" } },
				-- What, how?!
				{ Cue = "/VO/Theseus_0384", RequiredPlayed = { "/VO/Theseus_0381" } },
				-- Look out, Asterius!
				{ Cue = "/VO/Theseus_0385", RequiredPlayed = { "/VO/Theseus_0381" }, RequiredAnyUnitAlive = { "Minotaur", "Minotaur2" }, RequiredFalseFlags = { "HeroesMuted" }, },
				-- Watch out!!
				{ Cue = "/VO/Theseus_0386", RequiredPlayed = { "/VO/Theseus_0381" } },
				-- Bwaah?!
				{ Cue = "/VO/Theseus_0387", RequiredPlayed = { "/VO/Theseus_0381" } },
				-- That boulder?!
				{ Cue = "/VO/Theseus_0388", RequiredPlayed = { "/VO/Theseus_0381" } },
				-- That blasted rock!!
				{ Cue = "/VO/Theseus_0389", RequiredPlayed = { "/VO/Theseus_0381" } },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.8,
				Queue = "Interrupt",
				RequiredTrait = "AchillesPatroclusAssistTrait",

				-- My fellow warriors! Why?!
				{ Cue = "/VO/Theseus_0515", RequiredPlayed = { "/VO/Theseus_0516" }, },
				-- The great Achilles!
				{ Cue = "/VO/Theseus_0516" },
				-- Achilles has returned!
				{ Cue = "/VO/Theseus_0517", RequiredPlayed = { "/VO/Theseus_0516" }, },
				-- Achilles, but, I -- why?!
				{ Cue = "/VO/Theseus_0518", RequiredPlayed = { "/VO/Theseus_0516" }, },
				-- My noble warriors, you would side with him?
				{ Cue = "/VO/Theseus_0519", RequiredPlayed = { "/VO/Theseus_0516" }, },
				-- These warriors again!
				{ Cue = "/VO/Theseus_0520", RequiredPlayed = { "/VO/Theseus_0516" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				Queue = "Interrupt",
				RequiredOneOfTraits = { "ThanatosAssistTrait", "FuryAssistTrait", "SkellyAssistTrait",  "SisyphusAssistTrait", "DusaAssistTrait", "AchillesPatroclusAssistTrait" },

				-- The fiend has help!
				{ Cue = "/VO/Theseus_0347" },
				-- Where, what?!
				{ Cue = "/VO/Theseus_0348" },
				-- An intruder!
				{ Cue = "/VO/Theseus_0349" },
				-- A foul trick!
				{ Cue = "/VO/Theseus_0350" },
				-- Who?!
				{ Cue = "/VO/Theseus_0351" },
				-- What?!
				{ Cue = "/VO/Theseus_0352" },
				-- You?!
				{ Cue = "/VO/Theseus_0353" },
				-- Begone, you!
				{ Cue = "/VO/Theseus_0354" },
				-- This is not your fight!
				{ Cue = "/VO/Theseus_0355" },
				-- Stay out of this!
				{ Cue = "/VO/Theseus_0356" },
				-- Again, this treachery?
				{ Cue = "/VO/Theseus_0357" },
				-- Bah, fight fair!!
				{ Cue = "/VO/Theseus_0358" },
				-- Of course you need help!
				{ Cue = "/VO/Theseus_0359" },
				-- What is the meaning of this?
				{ Cue = "/VO/Theseus_0360" },
				-- You again!!
				{ Cue = "/VO/Theseus_0361" },
				-- Preposterous!
				{ Cue = "/VO/Theseus_0362" },
				-- What is this?!
				{ Cue = "/VO/Theseus_0363" },
				-- Ah, drat!
				{ Cue = "/VO/Theseus_0364" },
			},
		},

		OnHitVoiceLinesQueueDelay = 0.6,
		OnHitByWeaponVoiceLines =
		{
			MinotaurBullRushRam =
			{
				SuccessiveChanceToPlay = 0.66,
				BreakIfPlayed = true,
				RandomRemaining = true,
				Queue = "Interrupt",
				RequiredFalseFlags = { "HeroesMuted" },
				RequiredFalseTextLines = { "TheseusAboutFraternalBonds06_A", "TheseusAboutFraternalBonds06_B" },
				Cooldowns =
				{
					{ Name = "TheseusOnHitSpeech", Time = 30 },
				},

				-- Look out, Asterius!
				{ Cue = "/VO/Theseus_0504", },
				-- Out of the way, my friend!
				{ Cue = "/VO/Theseus_0505", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Asterius, watch out!
				{ Cue = "/VO/Theseus_0506", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Step back, Asterius!
				{ Cue = "/VO/Theseus_0507", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Ah, blast!
				{ Cue = "/VO/Theseus_0508", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Move, Asterius!
				{ Cue = "/VO/Theseus_0509", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Not me, Asterius!
				{ Cue = "/VO/Theseus_0510", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- He'd make a mockery of us!
				{ Cue = "/VO/Theseus_0511", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Be more careful, my friend!
				{ Cue = "/VO/Theseus_0512", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- The blasted fiend tricked us!
				{ Cue = "/VO/Theseus_0513", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Augh, watch yourself, my friend!
				{ Cue = "/VO/Theseus_0514", RequiredPlayed = { "/VO/Theseus_0504" } },
			},
			MinotaurArmoredBullRushRam =
			{
				CooldownTime = 30,
				SuccessiveChanceToPlay = 0.66,
				BreakIfPlayed = true,
				RandomRemaining = true,
				RequiredFalseFlags = { "HeroesMuted" },
				Cooldowns =
				{
					{ Name = "TheseusOnHitSpeech", Time = 30 },
				},

				-- Look out, Asterius!
				{ Cue = "/VO/Theseus_0504", },
				-- Out of the way, my friend!
				{ Cue = "/VO/Theseus_0505", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Asterius, watch out!
				{ Cue = "/VO/Theseus_0506", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Step back, Asterius!
				{ Cue = "/VO/Theseus_0507", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Ah, blast!
				{ Cue = "/VO/Theseus_0508", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Move, Asterius!
				{ Cue = "/VO/Theseus_0509", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Not me, Asterius!
				{ Cue = "/VO/Theseus_0510", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- He'd make a mockery of us!
				{ Cue = "/VO/Theseus_0511", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Be more careful, my friend!
				{ Cue = "/VO/Theseus_0512", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- The blasted fiend tricked us!
				{ Cue = "/VO/Theseus_0513", RequiredPlayed = { "/VO/Theseus_0504" } },
				-- Augh, watch yourself, my friend!
				{ Cue = "/VO/Theseus_0514", RequiredPlayed = { "/VO/Theseus_0504" } },
			},
		},

		CrowdReactionVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.8,
			SuccessiveChanceToPlay = 0.5,
			RequiredAnyUnitAlive = { "Minotaur", "Minotaur2" },
			RequiredFalseFlags = { "HeroesMuted" },
			Cooldowns =
			{
				{ Name = "TheseusQuipAnySpeech", Time = 60 },
			},

			-- Thank you!! Thank you!
			{ Cue = "/VO/Theseus_0434" },
			-- The adoration of the crowd!
			{ Cue = "/VO/Theseus_0435" },
			-- Hear that, Asterius?
			{ Cue = "/VO/Theseus_0436" },
			-- Ah, hahaha, yes!
			{ Cue = "/VO/Theseus_0437" },
			-- Such a spectacle is it not?
			{ Cue = "/VO/Theseus_0438" },
			-- A gracious audience!
			{ Cue = "/VO/Theseus_0439" },
			-- They love us, Asterius!!
			{ Cue = "/VO/Theseus_0440" },
			-- Nothing like battling before an audience!
			{ Cue = "/VO/Theseus_0441" },
			-- Thank you, my fellow shades!
			{ Cue = "/VO/Theseus_0474" },
			-- They know our victory is certain here!
			{ Cue = "/VO/Theseus_0475" },
			-- That cheering's not for you, monster!
			{ Cue = "/VO/Theseus_0476" },
			-- We shall prevail for you in the stands!
			{ Cue = "/VO/Theseus_0477" },
			-- A most enthusiastic audience!
			{ Cue = "/VO/Theseus_0478" },
			-- Are you enjoying yourselves in the stands?!
			{ Cue = "/VO/Theseus_0479" },
			-- Such fervor coming from this crowd!
			{ Cue = "/VO/Theseus_0480" },
			-- To all who came to see us fight, thank you!
			{ Cue = "/VO/Theseus_0481" },
			-- We owe everything to our audience!
			{ Cue = "/VO/Theseus_0482" },
			-- Keep cheering, as we battle to the last!
			{ Cue = "/VO/Theseus_0483" },
			-- The roaring of the crowd fills me with strength!
			{ Cue = "/VO/Theseus_0484" },
			-- Just listen to that, friend Asterius!
			{ Cue = "/VO/Theseus_0485" },
			-- You shall have what you came to see!
			{ Cue = "/VO/Theseus_0486" },
			-- To all our fans, we dedicate this fight to you!
			{ Cue = "/VO/Theseus_0487" },
		},
		CauseOfDeathVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.4,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				SuccessiveChanceToPlayAll = 0.33,
				Source = { SubtitleColor = Color.TheseusVoice },
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 2,
				},
				-- That was for last time, fiend!
				{ Cue = "/VO/Theseus_0210" },
				-- Ahh, the sweetness of revenge!!
				 { Cue = "/VO/Theseus_0211" },
				-- Thus I reassert my status as the Champion!
				 { Cue = "/VO/Theseus_0212" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.4,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				SuccessiveChanceToPlayAll = 0.33,
				Source = { SubtitleColor = Color.TheseusVoice },
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_Boss01",
				  Count = 2,
				},
				-- Your foolish attempts shall get you nowhere!
				 { Cue = "/VO/Theseus_0207" },
				-- I shall send you to hell however many times it takes!
				 { Cue = "/VO/Theseus_0208" },
				-- You are forever doomed to fail.
				 { Cue = "/VO/Theseus_0209" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.75,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				Source = { SubtitleColor = Color.TheseusVoice },

				-- You shall never defeat us.
				 { Cue = "/VO/Theseus_0192", RequiredAnyUnitAlive = { "Minotaur", "Minotaur2" }, RequiredFalseFlags = { "HeroesMuted" }, },
				-- Asterius and I are undefeatable.
				 { Cue = "/VO/Theseus_0193", RequiredAnyUnitAlive = { "Minotaur", "Minotaur2" }, RequiredFalseFlags = { "HeroesMuted" }, },
				-- Well done, Asterius!
				 { Cue = "/VO/Theseus_0194", RequiredAnyUnitAlive = { "Minotaur", "Minotaur2" }, RequiredFalseFlags = { "HeroesMuted" }, },
				-- We make a formidable duo, don't we, Asterius?
				 { Cue = "/VO/Theseus_0195", RequiredAnyUnitAlive = { "Minotaur", "Minotaur2" }, RequiredFalseFlags = { "HeroesMuted" }, },
				-- You were a fool to stand against our might.
				 { Cue = "/VO/Theseus_0196", RequiredAnyUnitAlive = { "Minotaur", "Minotaur2" }, RequiredFalseFlags = { "HeroesMuted" }, },
				-- Back to the hell that spawned you.
				 { Cue = "/VO/Theseus_0197" },
				-- I send you to the depths of hell.
				 { Cue = "/VO/Theseus_0198" },
				-- Begone from here and don't return, you fiend.
				 { Cue = "/VO/Theseus_0199" },
				-- Return whence you came.
				 { Cue = "/VO/Theseus_0200" },
				-- You are unwelcome in Elysium.
				 { Cue = "/VO/Theseus_0201" },
				-- You had no chance against the Champion.
				 { Cue = "/VO/Theseus_0202", RequiredFalseFlags = { "HeroesMuted" }, },
				-- When next we meet, it shall go even worse.
				 { Cue = "/VO/Theseus_0203" },
				-- Elysium is for the great, not for the likes of you!
				 { Cue = "/VO/Theseus_0204" },
				-- You should have stayed down in the depths of hell.
				 { Cue = "/VO/Theseus_0205" },
				-- You failed, as was surely fated.
				 { Cue = "/VO/Theseus_0206" },
				-- That was for Asterius.
				 { Cue = "/VO/Theseus_0424", RequiredUnitsNotAlive = { "Minotaur", "Minotaur2" }, RequiredFalseFlags = { "HeroesMuted" }, },
				-- Asterius, my friend, you are avenged.
				 { Cue = "/VO/Theseus_0425", RequiredUnitsNotAlive = { "Minotaur", "Minotaur2" }, RequiredFalseFlags = { "HeroesMuted" }, },
				-- Vengeance is mine, dear Asterius!
				 { Cue = "/VO/Theseus_0426", RequiredUnitsNotAlive = { "Minotaur", "Minotaur2" }, RequiredFalseFlags = { "HeroesMuted" }, },
				-- You destroy my chariot, I destroy you, end of tale.
				 { Cue = "/VO/Theseus_0427", RequiredUnitNotAlive = "Theseus2", RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 }, },
				-- Chariots can be repaired, rebuilt! Honor cannot.
				 { Cue = "/VO/Theseus_0428", RequiredUnitNotAlive = "Theseus2", RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 }, },
				-- That was for my beautiful chariot, foul daemon.
				 { Cue = "/VO/Theseus_0429", RequiredUnitNotAlive = "Theseus2", RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 }, },
				-- Your foul deeds shall go unsung, mark you my words.
				 { Cue = "/VO/Theseus_0430" },
				-- There. I shall await when next you clamber to these heights.
				 { Cue = "/VO/Theseus_0431" },
				-- Absolutely devastated, aren't we. Hmph!
				 { Cue = "/VO/Theseus_0432" },
				-- If only you could hear the roaring crowd.
				 { Cue = "/VO/Theseus_0433" },
			},
		},

		OnKillVoiceLines =
		{
			[1] = GlobalVoiceLines.BarelySurvivedBossFightVoiceLines,
			[2] =
			{
				RequiredUnitsNotAlive = { "Minotaur", "Minotaur2" },
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 6.1,

				-- That'll teach him.
				{ Cue = "/VO/ZagreusField_1794" },
				-- That ought to shut him up.
				{ Cue = "/VO/ZagreusField_1795" },
				-- Who's Champion now?
				{ Cue = "/VO/ZagreusField_1796" },
				-- What a loudmouth.
				{ Cue = "/VO/ZagreusField_1797" },
				-- They say to never meet your heroes.
				{ Cue = "/VO/ZagreusField_1798" },
				-- That's one Champion unseated.
				{ Cue = "/VO/ZagreusField_1799" },
				-- Finally.
				{ Cue = "/VO/ZagreusField_0220" },
				-- That'll do.
				{ Cue = "/VO/ZagreusField_1253" },
				-- That ought to make Theseus shut it for a bit.
				{ Cue = "/VO/ZagreusHome_0873" },
			},
			[3] = GlobalVoiceLines.ChaosReactionVoiceLines,
		},

		-- RageFullSound = "/SFX/Enemy Sounds/Theseus/EmotePoweringUp",
		RageFullVoiceLines =
		{
			--[[
			{
				RandomRemaining = true,
				PreLineWait = 0.6,

				-- Asterius!!
				{ Cue = "/VO/Theseus_0226" },
				-- No, Asterius!
				{ Cue = "/VO/Theseus_0227" },
			},
			]]--
		},

		CharmStartSound = "/SFX/Enemy Sounds/Theseus/EmoteLaugh",
		OnCharmedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.4,
			CooldownTime = 120,
			CooldownName = "TheseusSpokeRecently",
			SuccessiveChanceToPlay = 0.33,

			-- Eugh, you... fiend...
			{ Cue = "/VO/Theseus_0294" },
			-- What, I... huh...
			{ Cue = "/VO/Theseus_0295" },
			-- You... betrayer...!
			{ Cue = "/VO/Theseus_0296" },
			-- By my faith, I...!
			{ Cue = "/VO/Theseus_0297" },
			-- Urgh, what in the...
			{ Cue = "/VO/Theseus_0298" },
			-- Asterius, I... augh!
			{ Cue = "/VO/Theseus_0299", RequiredAnyUnitAlive = { "Minotaur", "Minotaur2" }, },
			-- You, augh!
			{ Cue = "/VO/Theseus_0300" },
			-- What, I, urgh!
			{ Cue = "/VO/Theseus_0301" },
			-- How-- dah!
			{ Cue = "/VO/Theseus_0302" },
			-- I am smitten...!
			{ Cue = "/VO/Theseus_0303" },
		},

		InvulnerableHitSound = "/SFX/Enemy Sounds/Theseus/EmoteChuckle",
		InvulnerableVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			CooldownTime = 100,
			CooldownName = "TheseusSpokeRecently",
			PreLineWait = 0.2,
			RequiredFalseFlags = { "HeroesMuted" },

			-- Weak!
			{ Cue = "/VO/Theseus_0184", },
			-- The gods protect me!
			{ Cue = "/VO/Theseus_0185", },
			-- My shield is strong!
			{ Cue = "/VO/Theseus_0186", },
			-- No you don't!
			{ Cue = "/VO/Theseus_0187", },
			-- I think not.
			{ Cue = "/VO/Theseus_0188", },
			-- Foolish.
			{ Cue = "/VO/Theseus_0189", },
			-- Never!
			{ Cue = "/VO/Theseus_0190", },
			-- Not a chance!
			{ Cue = "/VO/Theseus_0191", },
		},
		LowHealthVoiceLineThreshold = 0.6,
		LowHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			CooldownTime = 12,
			CooldownName = "TheseusSpokeRecently",
			PreLineWait = 0.35,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredFalseFlags = { "HeroesMuted" },
			},

			-- You hit me!
			{ Cue = "/VO/Theseus_0166", },
			-- Huh!
			{ Cue = "/VO/Theseus_0167", },
			-- Well!
			{ Cue = "/VO/Theseus_0168", },
			-- A clean hit.
			{ Cue = "/VO/Theseus_0169", },
			-- A solid hit.
			{ Cue = "/VO/Theseus_0170", },
			-- You dare?
			{ Cue = "/VO/Theseus_0171", },
			-- Pff.
			{ Cue = "/VO/Theseus_0172", },
			-- Tsch.
			{ Cue = "/VO/Theseus_0173", },
			-- Bah.
			{ Cue = "/VO/Theseus_0174", },
			-- That's it, fiend!
			{ Cue = "/VO/Theseus_0178", },
			-- Again!
			{ Cue = "/VO/Theseus_0179", },
			-- The fiend has fangs!
			{ Cue = "/VO/Theseus_0180", },
			-- It shall take more than that!
			{ Cue = "/VO/Theseus_0183", },
			-- Dah, my chariot!
			{ Cue = "/VO/Theseus_0399", GameStateRequirements = { RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 }, }, },
			-- This thing is falling apart!
			{ Cue = "/VO/Theseus_0400", GameStateRequirements = { RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 }, }, },
			-- We can take more than that!
			{ Cue = "/VO/Theseus_0401", GameStateRequirements = { RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 }, }, },
			-- You scratched the detailing!
			{ Cue = "/VO/Theseus_0402", GameStateRequirements = { RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 }, }, },
			-- Try all you like!
			{ Cue = "/VO/Theseus_0403", },
			-- Naught but a scratch!
			{ Cue = "/VO/Theseus_0404", GameStateRequirements = { RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 }, }, },
			-- That was nothing!
			{ Cue = "/VO/Theseus_0405", },
			-- Foul daemon!
			{ Cue = "/VO/Theseus_0406", },
		},
		CriticalHealthVoiceLineThreshold = 0.3,
		CriticalHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			CooldownTime = 12,
			CooldownName = "TheseusSpokeRecently",
			PreLineWait = 0.35,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- Blast!
			{ Cue = "/VO/Theseus_0163", },
			-- Blast you.
			{ Cue = "/VO/Theseus_0164", },
			-- Curse you!
			{ Cue = "/VO/Theseus_0165", },
			-- Nrghh.
			{ Cue = "/VO/Theseus_0176", },
			-- You...!
			{ Cue = "/VO/Theseus_0177", },
			-- Gah, you.
			{ Cue = "/VO/Theseus_0175", },
			-- Rngh, you fiend!
			{ Cue = "/VO/Theseus_0181", },
			-- Khh, you monster!
			{ Cue = "/VO/Theseus_0182", },
			-- Dah!
			{ Cue = "/VO/Theseus_0521", },
			-- Augh!
			{ Cue = "/VO/Theseus_0522", },
			-- Guh, I shall not lose to you again!
			{ Cue = "/VO/Theseus_0523",
				GameStateRequirements =
				{
					ConsecutiveClearsOfRoom = { Name = "C_Boss01", Count = 1, },
				},
			},
			-- Khh, I am not finished yet!
			{ Cue = "/VO/Theseus_0524", },
			-- Urgh, this is absurd!
			{ Cue = "/VO/Theseus_0525", },
			-- Nrgh, why, you!
			{ Cue = "/VO/Theseus_0526", },
		},
		DeathVoiceLines =
		{
			Queue = "Interrupt",
			{
				{ Cue = "/EmptyCue" }
			},
			{
				RandomRemaining = true,
				SkipAnim = true,
				PreLineWait = 0.4,

				-- Nn, noooo!
				{ Cue = "/VO/Theseus_0213", RequiredPlayed = { "/VO/Theseus_0220" } },
				-- Wha, how--?
				{ Cue = "/VO/Theseus_0214", RequiredPlayed = { "/VO/Theseus_0220" } },
				-- You... fiend...!
				{ Cue = "/VO/Theseus_0215", RequiredPlayed = { "/VO/Theseus_0220" } },
				-- You... monster...!
				{ Cue = "/VO/Theseus_0216", RequiredPlayed = { "/VO/Theseus_0220" } },
				-- You... blackguard...!
				{ Cue = "/VO/Theseus_0217", RequiredPlayed = { "/VO/Theseus_0220" } },
				-- H, how... could you...
				{ Cue = "/VO/Theseus_0218", RequiredPlayed = { "/VO/Theseus_0220" } },
				-- Khh, why, you...
				{ Cue = "/VO/Theseus_0219", RequiredPlayed = { "/VO/Theseus_0220" } },
				-- Nrraauuugghh!
				{ Cue = "/VO/Theseus_0220" },
				-- Grraaauuuggghhh!
				{ Cue = "/VO/Theseus_0221", RequiredPlayed = { "/VO/Theseus_0220" } },
				-- Daamn youuu!
				{ Cue = "/VO/Theseus_0222", RequiredPlayed = { "/VO/Theseus_0220" } },
				-- I shall return!!
				{ Cue = "/VO/Theseus_0223", RequiredPlayed = { "/VO/Theseus_0220" } },
				-- I am... still... urgh...
				{ Cue = "/VO/Theseus_0224", RequiredPlayed = { "/VO/Theseus_0220" } },
				-- How... dare... ungghh.
				{ Cue = "/VO/Theseus_0225", RequiredPlayed = { "/VO/Theseus_0220" } },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.1,
				ObjectType = "Minotaur2",
				RequiredFalseFlags = { "HeroesMuted" },
				RequiredAnyUnitNotDead = { "Minotaur", "Minotaur2" },

				-- King...!
				{ Cue = "/VO/Minotaur_0242" },
				-- King, no!
				{ Cue = "/VO/Minotaur_0243" },
				-- Theseus!
				{ Cue = "/VO/Minotaur_0244" },
				-- No, Theseus!
				{ Cue = "/VO/Minotaur_0245" },
				-- The Champion...!
				{ Cue = "/VO/Minotaur_0246" },
				-- No...!
				{ Cue = "/VO/Minotaur_0247" },
				-- Blast...!
				{ Cue = "/VO/Minotaur_0248" },
				-- You...!
				{ Cue = "/VO/Minotaur_0249" },
				-- How...!
				{ Cue = "/VO/Minotaur_0250" },
				-- What?
				{ Cue = "/VO/Minotaur_0251" },
				-- The king, defeated?
				{ Cue = "/VO/Minotaur_0252" },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.1,
				ObjectType = "Minotaur",
				RequiredFalseFlags = { "HeroesMuted" },
				RequiredAnyUnitNotDead = { "Minotaur", "Minotaur2" },

				-- King...!
				{ Cue = "/VO/Minotaur_0242" },
				-- King, no!
				{ Cue = "/VO/Minotaur_0243" },
				-- Theseus!
				{ Cue = "/VO/Minotaur_0244" },
				-- No, Theseus!
				{ Cue = "/VO/Minotaur_0245" },
				-- The Champion...!
				{ Cue = "/VO/Minotaur_0246" },
				-- No...!
				{ Cue = "/VO/Minotaur_0247" },
				-- Blast...!
				{ Cue = "/VO/Minotaur_0248" },
				-- You...!
				{ Cue = "/VO/Minotaur_0249" },
				-- How...!
				{ Cue = "/VO/Minotaur_0250" },
				-- What?
				{ Cue = "/VO/Minotaur_0251" },
				-- The king, defeated?
				{ Cue = "/VO/Minotaur_0252" },
			},
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlay = 0.5,
					UsePlayerSource = true,
					RequiredAnyUnitNotDead = { "Minotaur", "Minotaur2" },
					RequiredKillEnemiesFound = true,

					-- You're next, Bull-man!
					{ Cue = "/VO/ZagreusField_1779" },
					-- See that, Bull-man?
					{ Cue = "/VO/ZagreusField_1780" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlay = 0.75,
					UsePlayerSource = true,
					RequiredAnyUnitNotDead = { "Minotaur", "Minotaur2" },
					RequiredKillEnemiesFound = true,

					-- One down, one to go.
					{ Cue = "/VO/ZagreusField_1778" },
					-- Now to deal with you!
					{ Cue = "/VO/ZagreusField_1783" },
					-- You're next!
					{ Cue = "/VO/ZagreusField_1784" },
					-- Now for the other one.
					{ Cue = "/VO/ZagreusField_1785" },
					-- You and me!
					{ Cue = "/VO/ZagreusField_1786" },
					-- You and me now!
					{ Cue = "/VO/ZagreusField_1787" },
				},
			},
		},

		MetaPointDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 4,
			MaxParcels = 4,
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		Binks =
		{
			"TheseusWalk_Bink",
			"TheseusIdle_Bink",
			"TheseusSpearSpin_Bink",
			"TheseusWrath_Bink",
			"TheseusSpearThrow_Bink",
			"MinotaurTheseusThrow_Bink",
			"TheseusTaunt_Bink",
			"TheseusDeathVFX_Bink",
		},

		Groups = { "NPCs" },

		BossPresentationSuperPriorityIntroTextLineSets =
		{
			TheseusExtremeMeasures01 =
			{
				PlayOnce = true,
				PreEventWait = 1.0,
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				{ Cue = "/VO/Theseus_0266",
					Emote = "PortraitEmoteSparkly",
					Text = "{#DialogueItalicFormat}Ah, hahaha{#PreviousFormat}, it's finally time, Asterius. He's here! Aren't you, now, you vile, insignificant hellspawn? Prepare now to be overrun!!" },
				{ Cue = "/VO/ZagreusField_2750", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, this is unfair... that's a bronze-plated Macedonian Tau-Lambda! What's an obnoxious bellyacher like you doing with the most durable chariot created, to date?" },
				{ Cue = "/VO/Theseus_0267",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteFiredUp",	
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Pah{#PreviousFormat}! You don't deserve to know. Suffice it that Asterius and I were handsomely rewarded once again. And we shall not hesitate to exploit our hard-fought spoils against {#DialogueItalicFormat}you{#PreviousFormat}!" },
			},
			TheseusAboutFraternalBonds02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusAboutFraternalBonds01" },
				{ Cue = "/VO/Theseus_0540",
					Emote = "PortraitEmoteDepressed",
					Text = "He would pit you against me, Asterius. I can see it in his mis-matched eyes! I cannot shake the terrible vision that, someday or night, it shall be me, standing alone here, whilst you...? Whilst you take sides against me! With that {#DialogueItalicFormat}fiend{#PreviousFormat}!" },
				{ Cue = "/VO/ZagreusField_3880", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "Asterius, about that, please consider it a standing offer, if you like. I'd rather have you as a friend than as a foe. Not sure that I can say the same for Theseus, of course." },
				{ Cue = "/VO/Theseus_0541",
					Emote = "PortraitEmoteAnger",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}You poisonous worm{#PreviousFormat}! I knew you had a more sinister trick at play, because your fighting style certainly is of no concern just on its own! Are there truly no depths to which you would not stoop?!" },
			},
			TheseusAboutFraternalBonds03_A =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusAboutFraternalBonds02" },
				RequiredFalseTextLines = { "TheseusAboutFraternalBonds03_B" },
				-- RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				{ Cue = "/VO/Theseus_0542", PreLineWait = 0.35,
					Emote = "PortraitEmoteFiredUp",
					Text = "...I'm telling you, you're {#DialogueItalicFormat}wrong{#PreviousFormat}, Asterius! He is no {#DialogueItalicFormat}royalty{#PreviousFormat}, most certainly not any {#DialogueItalicFormat}I {#PreviousFormat}would recognize! He's but a nameless, long-forgotten minor god born of the depths, and bound to stay in them!" },
				{ Cue = "/VO/Minotaur_0283", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "I, too, once was berated by such words, king. We've faced this enemy how many times? And in my estimation, he's fought bravely, here." },
				{ Cue = "/VO/Theseus_0543",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteSurprise",					
					Text = "{#DialogueItalicFormat}Bravely{#PreviousFormat}?! Hiding behind those pillars is what you call {#DialogueItalicFormat}bravely{#PreviousFormat}, Asterius? We shall have to discuss this strange lapse of judgment after we achieve our victory!" },
			},
			TheseusAboutFraternalBonds03_B =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusAboutFraternalBonds02" },
				RequiredFalseTextLines = { "TheseusAboutFraternalBonds03_A" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				-- RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				{ Cue = "/VO/Theseus_0542", PreLineWait = 0.35,
					Emote = "PortraitEmoteFiredUp",
					Text = "...I'm telling you, you're {#DialogueItalicFormat}wrong{#PreviousFormat}, Asterius! He is no {#DialogueItalicFormat}royalty{#PreviousFormat}, most certainly not any {#DialogueItalicFormat}I {#PreviousFormat}would recognize! He's but a nameless, long-forgotten minor god born of the depths, and bound to stay in them!" },
				{ Cue = "/VO/Minotaur_0283", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					Text = "I, too, once was berated by such words, king. We've faced this enemy how many times? And in my estimation, he's fought bravely, here." },
				{ Cue = "/VO/Theseus_0543",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					Emote = "PortraitEmoteSurprise",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Bravely{#PreviousFormat}?! Hiding behind those pillars is what you call {#DialogueItalicFormat}bravely{#PreviousFormat}, Asterius? We shall have to discuss this strange lapse of judgment after we achieve our victory!" },
			},

			TheseusAboutFraternalBonds04_A =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusAboutFraternalBonds03_A", "TheseusAboutFraternalBonds03_B" },
				RequiredFalseTextLines = { "TheseusAboutFraternalBonds04_B" },
				-- RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				{ Cue = "/VO/Theseus_0544", PreLineWait = 0.35,
					Emote = "PortraitEmoteDepressed",
					Text = "I hope you're perfectly pleased with yourself, hellspawn. Because Asterius has been quite cross with me! Such as he is. He says I have misjudged the likes of you! {#DialogueItalicFormat}Outrageousness{#PreviousFormat}." },
				{ Cue = "/VO/Minotaur_0284", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "You don't hear me, king. We still have a lot to learn about this foe. Each time, he's differently equipped. Weapons, god-given abilities, and such. Despite our efforts... it's been difficult to read his strategies." },
				{ Cue = "/VO/Theseus_0545",
					SetFlagTrue = "HeroesMuted",
					Emote = "PortraitEmoteDepressed",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "And now, you're saying I can't fight, Asterius? Even though I had no difficulty besting {#DialogueItalicFormat}you {#PreviousFormat}within that maze of yours?! Come on, let's do this fight!" },
			},
			TheseusAboutFraternalBonds04_B =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusAboutFraternalBonds03_A", "TheseusAboutFraternalBonds03_B" },
				RequiredFalseTextLines = { "TheseusAboutFraternalBonds04_A" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				-- RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				{ Cue = "/VO/Theseus_0544", PreLineWait = 0.35,
					Emote = "PortraitEmoteDepressed",
					Text = "I hope you're perfectly pleased with yourself, hellspawn. Because Asterius has been quite cross with me! Such as he is. He says I have misjudged the likes of you! {#DialogueItalicFormat}Outrageousness{#PreviousFormat}." },
				{ Cue = "/VO/Minotaur_0284", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					Text = "You don't hear me, king. We still have a lot to learn about this foe. Each time, he's differently equipped. Weapons, god-given abilities, and such. Despite our efforts... it's been difficult to read his strategies." },
				{ Cue = "/VO/Theseus_0545",
					SetFlagTrue = "HeroesMuted",
					Emote = "PortraitEmoteDepressed",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "And now, you're saying I can't fight, Asterius? Even though I had no difficulty besting {#DialogueItalicFormat}you {#PreviousFormat}within that maze of yours?! Come on, let's do this fight!" },
			},

			TheseusAboutFraternalBonds05_A =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusAboutFraternalBonds04_A", "TheseusAboutFraternalBonds04_B" },
				RequiredFalseTextLines = { "TheseusAboutFraternalBonds05_B" },
				-- RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				{ Cue = "/VO/Theseus_0546", PreLineWait = 0.35,
					Emote = "PortraitEmoteDepressed",
					Text = "Well, worm! Come fight us, I suppose. And take fullest advantage of the havoc that you sowed! We are no team! We're merely two combatants, simultaneously booked to be here, now." },
				{ Cue = "/VO/Minotaur_0285", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "King, I think you are over-reacting, here. Try to be reasonable. And be more considerate about my point of view. Don't think I am asking for too much." },
				{ Cue = "/VO/Theseus_0547",
					Emote = "PortraitEmoteDepressed",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're asking the impossible of me! But, let us fight. And let us lose, I'm sure, because if we are not a team, what are we, then, Asterius...?" },
			},
			TheseusAboutFraternalBonds05_B =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusAboutFraternalBonds04_A", "TheseusAboutFraternalBonds04_B" },
				RequiredFalseTextLines = { "TheseusAboutFraternalBonds05_A" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				-- RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				{ Cue = "/VO/Theseus_0546", PreLineWait = 0.35,
					Emote = "PortraitEmoteDepressed",
					Text = "Well, worm! Come fight us, I suppose. And take fullest advantage of the havoc that you sowed! We are no team! We're merely two combatants, simultaneously booked to be here, now." },
				{ Cue = "/VO/Minotaur_0285", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					Text = "King, I think you are over-reacting, here. Try to be reasonable. And be more considerate about my point of view. Don't think I am asking for too much." },
				{ Cue = "/VO/Theseus_0547",
					Emote = "PortraitEmoteDepressed",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You're asking the impossible of me! But, let us fight. And let us lose, I'm sure, because if we are not a team, what are we, then, Asterius...?" },
			},
			TheseusAboutFraternalBonds05Extra_A =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusAboutFraternalBonds05_A", "TheseusAboutFraternalBonds05_B" },
				RequiredFalseTextLines = { "TheseusAboutFraternalBonds05Extra_B", "TheseusAboutFraternalBonds06_A", "TheseusAboutFraternalBonds06_B" },
				-- RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				{ Cue = "/VO/Minotaur_0301", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "You'll have to excuse the Champion, there, short one. He hasn't been himself. Though he'll still fight you to the death, I'm sure." },
				{ Cue = "/VO/ZagreusField_4110", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "That's good, because you had me worried for a moment, there. Hey maybe I can knock some sense back into him, what do you think?" },
				{ Cue = "/VO/Minotaur_0302", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					Text = "I'm not so sure. I've tried. But I know better than to underestimate you. Fight us, then." },
			},
			TheseusAboutFraternalBonds05Extra_B =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusAboutFraternalBonds05_A", "TheseusAboutFraternalBonds05_B" },
				RequiredFalseTextLines = { "TheseusAboutFraternalBonds05Extra_A", "TheseusAboutFraternalBonds06_A", "TheseusAboutFraternalBonds06_B" },
				-- RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				{ Cue = "/VO/Minotaur_0301", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					Text = "You'll have to excuse the Champion, there, short one. He hasn't been himself. Though he'll still fight you to the death, I'm sure." },
				{ Cue = "/VO/ZagreusField_4110", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "That's good, because you had me worried for a moment, there. Hey maybe I can knock some sense back into him, what do you think?" },
				{ Cue = "/VO/Minotaur_0302", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					Text = "I'm not so sure. I've tried. But I know better than to underestimate you. Fight us, then." },
			},
			TheseusAboutFraternalBonds06_A =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusAboutFraternalBonds05Extra_A", "TheseusAboutFraternalBonds05Extra_B" },
				RequiredFalseTextLines = { "TheseusAboutFraternalBonds06_B" },
				-- RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.7,
					-- Well, glad that's settled, then!
					{ Cue = "/VO/ZagreusField_3881" },
				},
				{ Cue = "/VO/Theseus_0548", PreLineWait = 0.35,
					Emote = "PortraitEmoteFiredUp",
					Text = "Please fight with me, again, Asterius. I mean, just like before! You must forgive me my indecencies of late. This blasted fiend! His lies and treachery get right under my skin. Or the phantasmagorical equivalent!" },
				{ Cue = "/VO/Minotaur_0286", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "Swear something to me, king. That you'll discard your fears about our bond. The short one here is never going to break it. He doesn't even understand it. The only one who can break it is you, yourself." },
				{ Cue = "/VO/Theseus_0549",
					SetFlagFalse = "HeroesMuted",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I... oh, my dear friend, Asterius. I see, of course, you're right, you're right. {#DialogueItalicFormat}You're right{#PreviousFormat}! And I solemnly do swear to you, indeed, that I shall never again doubt our brotherhood! Nor shall I ever listen to this fiend! Together, now and always!!" },
			},
			TheseusAboutFraternalBonds06_B =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusAboutFraternalBonds05_A", "TheseusAboutFraternalBonds05_B" },
				RequiredFalseTextLines = { "TheseusAboutFraternalBonds06_A" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				-- RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.7,
					-- Well, glad that's settled, then!
					{ Cue = "/VO/ZagreusField_3881" },
				},
				{ Cue = "/VO/Theseus_0548", PreLineWait = 0.35,
					Emote = "PortraitEmoteFiredUp",
					Text = "Please fight with me, again, Asterius. I mean, just like before! You must forgive me my indecencies of late. This blasted fiend... his lies and treachery get right under my skin. Or the phantasmagorical equivalent!" },
				{ Cue = "/VO/Minotaur_0286", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					Text = "Swear something to me, king. That you'll discard your fears about our bond. The short one here is never going to break it. He doesn't even understand it. The only one who can break it is you, yourself." },
				{ Cue = "/VO/Theseus_0549",
					SetFlagFalse = "HeroesMuted",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I... oh, my dear friend, Asterius. I see, of course, you're right, you're right. {#DialogueItalicFormat}You're right{#PreviousFormat}! And I solemnly do swear to you, indeed, that I shall never again doubt our brotherhood! Nor shall I ever listen to this fiend! Together, now and always!!" },
			},

		},

		BossPresentationPriorityIntroTextLineSets =
		{
			TheseusExtremeMeasures02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusExtremeMeasures01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				{ Cue = "/VO/Theseus_0270",
					Emote = "PortraitEmoteSparkly",
					Text = "Come forth, blackguard, and you shall soon be crushed under the massive wheels of the finest chariot the world has ever known!" },
				{ Cue = "/VO/ZagreusField_2752", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You only have that chariot because of me, you know. It's all because of a condition of the Pact of Punishment! Nothing you did or earned. So drop the act!" },
				{ Cue = "/VO/Theseus_0271",
					PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#DialogueItalicFormat}Hahahahah{#PreviousFormat}, what?! You claim to be my benefactor, when in truth, you are my figuratively mortal enemy?! I'll do the chariot-equivalent of trample you!" },
			},
			TheseusExtremeMeasures03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusExtremeMeasures01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				{ Cue = "/VO/Theseus_0552",
					Emote = "PortraitEmoteSparkly",
					Text = "Come, blackguard! And be crushed beneath the raging wheelwork of the Macedonian Tau-Lambda, once again!" },
				{ Cue = "/VO/ZagreusField_3883", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Theseus, you do know you look even more ridiculous than normal wearing that mask? I get the chariot and the unsporting weaponry, but why wear {#DialogueItalicFormat}that {#PreviousFormat}thing?" },
				{ Cue = "/VO/Theseus_0553",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Bah! {#PreviousFormat}This blessed mask was crafted by great Daedalus, himself! A work of art, and my entitled claim as champion! What has he ever done for you?!" },
			},

			TheseusPactReverted01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusExtremeMeasures01" },
				RequiredRoomLastRun = "C_Intro",
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				{ Cue = "/VO/Theseus_0275",
					Emote = "PortraitEmoteSparkly",
					Text = "Well now, Asterius, he's returned! And this time, we shall have to vanquish him without the aid of our divine armor! A worthy challenge, no?" },
				{ Cue = "/VO/Minotaur_0262", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "Be cautious not to underestimate him, king. He has proved troublesome before." },
				{ Cue = "/VO/Theseus_0276",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Nonsense, my friend! For how can one underestimate that which deserves no esteem whatsoever?! Together, now, {#DialogueItalicFormat}attack{#PreviousFormat}!" },
			},
			TheseusExtremeMeasures_IfYouWon01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusExtremeMeasures01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				RequiredKillsLastRun = { "Theseus2" },
				{ Cue = "/VO/Theseus_0268",
					Emote = "PortraitEmoteSparkly",
					Text = "Well, you senseless monster, I suspect you're not so pleased with yourself, now! Behold!! For my glorious chariot has been restored!" },
				{ Cue = "/VO/ZagreusField_2751", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, indeed, nice work! Though must have cost a fortune in gemstones and diamonds, restoring an old Macedonian. I thought it was totaled after last time." },
				{ Cue = "/VO/Theseus_0269",
					PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "The only thing which shall be totaled here, you heartless property-destroying scourge, is {#DialogueItalicFormat}you yourself{#PreviousFormat}! Asterius!! Together, let us break him!" },
			},
			TheseusExtremeMeasures_IfYouWon02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusExtremeMeasures_IfYouWon01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Theseus_0277",
					Emote = "PortraitEmoteSparkly",
					Text = "My chariot and I stand ready for you, daemon! And I assume Asterius, as well! I feel it in my phantom heart, we shall not fall to you this time!" },
				{ Cue = "/VO/ZagreusField_2753", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You know, my opinion of the Macedonian Tau-Lambda has fallen precipitously of late. Though perhaps it's not the chariot but the driver." },
				{ Cue = "/VO/Theseus_0278",
					Emote = "PortraitEmoteAnger",
					PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Silence{#PreviousFormat}!! Show me a finer chariot-driver anywhere within Elysium, why, you cannot! I'll run you down for such an insult to my pride!" },
			},
			TheseusExtremeMeasures_IfYouWon03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusExtremeMeasures_IfYouWon02" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Theseus_0279",
					Emote = "PortraitEmoteSparkly",
					Text = "Ready yourself and your fine armor, friend Asterius! I shall drive circles around him, whilst you dispatch him with your mighty axe!" },
				{ Cue = "/VO/ZagreusField_2754", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Your strategy might work a little better if you didn't shout it loud enough for me to hear. Though I have to say I'm impressed you can drive, fight, and shout all at the same time." },
				{ Cue = "/VO/Theseus_0280",
					Emote = "PortraitEmoteAnger",
					PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "And {#DialogueItalicFormat}I{#PreviousFormat}, fiend, am impressed that {#DialogueItalicFormat}you {#PreviousFormat}yet live and breathe! A temporary state Asterius and I shall soon alleviate! {#DialogueItalicFormat}To war{#PreviousFormat}!!" },
			},

			TheseusWithAsterius01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusExtremeMeasures_IfYouWon03" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Minotaur_0259", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					Text = "He's here, king. Activating armor. It's fortunate repairs on your chariot were completed in time." },
				{ Cue = "/VO/Theseus_0272",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Nonsense, my friend! We could defeat this vile hellspawn with or without the additional divine protection we've been granted here! Get him!" },
			},

			TheseusPoseidonQuestReaction01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "PoseidonBeatTheseusQuestComplete" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				{ Cue = "/VO/Theseus_0550",
					Emote = "PortraitEmoteSparkly",
					Text = "Avert your eyes, fiend, lest the shining bronzework of the Macedonian should strike you blind! We are prepared to face your devilry!" },
				{ Cue = "/VO/ZagreusField_3882", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Prepared for me, really? I've dismantled your ridiculous chariot before. Even Poseidon knows you're just a blowhard with a fancy ride." },
				{ Cue = "/VO/Theseus_0551",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteAnger",
					Text = "How {#DialogueItalicFormat}dare {#PreviousFormat}you to invoke my Lord Poseidon's name?! And, to besmirch our complicated past! No god shall ever favor you as he has favored both Asterius and me!" },
			},
		},

		BossPresentationIntroTextLineSets =
		{
			TheseusFirstAppearance_NotMetMinotaur =
			{
				PlayOnce = true,
				RequiredFalseTextLines = { "MinotaurFirstAppearance_NotMetTheseus", "MinotaurFirstAppearance_MetTheseus", "TheseusFirstAppearance_MetBeatMinotaur", "TheseusFirstAppearance_MetNotBeatMinotaur" },
				{ Cue = "/VO/Theseus_0002",
					Emote = "PortraitEmoteSparkly",
					Text = "Hold, fiend! You'll walk not one more step toward the light of day, so long as I am here." },
				{ Cue = "/VO/Minotaur_0069", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "Two against one. Seems hardly fair.... Ah, well! {#DialogueItalicFormat}<Snort> {#PreviousFormat}Let's kill him and be done, king." },
				{ Cue = "/VO/ZagreusField_1763", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Theseus?! The Bull of Minos?! You two are legends! I'd be honored if we had a sporting contest here!" },
				{ Cue = "/VO/Theseus_0003",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Ahh{#PreviousFormat}, a naked attempt to sway me from my convictions. Defend yourself, you blackguard! And may the gods show you some mercy, for I shall not!" },
			},
			TheseusFirstAppearance_MetBeatMinotaur =
			{
				PlayOnce = true,
				Priority = true,
				RequiredTextLines = { "MinotaurFirstAppearance_NotMetTheseus" },
				RequiredFalseTextLines = { "TheseusFirstAppearance_NotMetMinotaur", "TheseusFirstAppearance_MetNotBeatMinotaur" },
				RequiredKills = { Minotaur = 1 },
				{ Cue = "/VO/Minotaur_0070", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "I warned you, short one. Now you face a foe more terrible even than I. The only other foe whom I have ever faced, who bested me." },
				{ Cue = "/VO/Theseus_0002",
					Emote = "PortraitEmoteSparkly",
					Text = "Hold, fiend! You'll walk not one more step toward the light of day, so long as I am here." },
				{ Cue = "/VO/ZagreusField_1764", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Theseus?! No way! You two are legends! I'd be honored if we had a sporting contest here!" },
				{ Cue = "/VO/Theseus_0003",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Ahh{#PreviousFormat}, a naked attempt to sway me from my convictions. Defend yourself, you blackguard! And may the gods show you some mercy, for I shall not!" },
			},
			TheseusFirstAppearance_MetNotBeatMinotaur =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurFirstAppearance_NotMetTheseus" },
				RequiredFalseTextLines = { "TheseusFirstAppearance_NotMetMinotaur", "TheseusFirstAppearance_MetBeatMinotaur" },
				RequiredFalseKills = { "Minotaur" },
				{ Cue = "/VO/Minotaur_0071", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "Beware, short one. Now you face a foe more terrible even than I. The only foe whom I have ever faced, who bested me." },
				{ Cue = "/VO/Theseus_0002",
					Emote = "PortraitEmoteSparkly",
					Text = "Hold, fiend! You'll walk not one more step toward the light of day, so long as I am here." },
				{ Cue = "/VO/ZagreusField_1764", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Theseus?! No way! You two are legends! I'd be honored if we had a sporting contest here!" },
				{ Cue = "/VO/Theseus_0003",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Ahh{#PreviousFormat}, a naked attempt to sway me from my convictions. Defend yourself, you blackguard! And may the gods show you some mercy, for I shall not!" },
			},

			TheseusSecondEncounter01_IfYouLost =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusFirstAppearance_NotMetMinotaur", "TheseusFirstAppearance_MetBeatMinotaur", "TheseusFirstAppearance_MetNotBeatMinotaur" },
				RequiredFalseTextLines = { "TheseusSecondEncounter01_IfYouWon" },
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Theseus_0004",
					Emote = "PortraitEmoteSparkly",
					Text = "So! The fiend returns to challenge us again, Asterius! Despite having experienced such a thorough thrashing by us last time!" },
				{ Cue = "/VO/ZagreusField_1765", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You know full well that wasn't a fair fight. Face me yourself and we'll see how you fare." },
				{ Cue = "/VO/Theseus_0006",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Silence{#PreviousFormat}, you monster! I'll hear no more such wicked lies, half-truths, or quarter-truths! You, however, soon shall hear my blessed spear! Specifically, the sound it makes whilst sliding into your exposed midsection! Defend yourself!" },
			},
			TheseusSecondEncounter01_IfYouWon =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusFirstAppearance_NotMetMinotaur", "TheseusFirstAppearance_MetBeatMinotaur", "TheseusFirstAppearance_MetNotBeatMinotaur" },
				RequiredFalseTextLines = { "TheseusSecondEncounter01_IfYouLost" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Theseus_0005",
					Emote = "PortraitEmoteSparkly",
					Text = "So! The fiend returns to challenge us again, Asterius! Or, rather, to besmirch the honor of this competition!" },
				{ Cue = "/VO/ZagreusField_1766", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Besmirch {#DialogueItalicFormat}what {#PreviousFormat}honor? You're just complaining that you lost. Even though I was outnumbered!" },
				{ Cue = "/VO/Theseus_0006",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Silence{#PreviousFormat}, you monster!! I'll hear no more such wicked lies, half-truths, or quarter-truths! You, however, soon shall hear my blessed spear! Specifically, the sound it makes whilst sliding into your exposed midsection! Defend yourself!" },
			},

			TheseusAboutGilgameshAspect01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter01" },
				RequiredFalseTextLines = { "TheseusAboutGilgameshAspect01_B" },
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				RequiredWeapon = "FistWeapon",
				RequiredTrait = "FistDetonateTrait",
				{ Cue = "/VO/Theseus_0560",
					Emote = "PortraitEmoteSparkly",
					Text = "What are those bestial gloves of yours, blackguard? Beginning to show more of your true and savage nature, here perhaps?" },
				{ Cue = "/VO/Minotaur_0287", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "No. He bears the Twin Fists in the aspect of a king called Gilgamesh. That king, he, too, wrestled a beastlike man, who then became a friend. Maybe that's why I knew this fight would come." },
				{ Cue = "/VO/Theseus_0561",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "What are you telling me, Asterius? Now is certainly not a good time for waxing philosophical, I think! And, surely this King Gilgamesh of whom you speak is much more competent a fighter than {#DialogueItalicFormat}this {#PreviousFormat}filth!" },
			},
			TheseusAboutGilgameshAspect01_B =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter01" },
				RequiredFalseTextLines = { "TheseusAboutGilgameshAspect01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				RequiredWeapon = "FistWeapon",
				RequiredTrait = "FistDetonateTrait",
				{ Cue = "/VO/Theseus_0560",
					Emote = "PortraitEmoteSparkly",
					Text = "What are those bestial gloves of yours, blackguard? Beginning to show more of your true and savage nature, here perhaps?" },
				{ Cue = "/VO/Minotaur_0287", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					Text = "No. He bears the Twin Fists in the aspect of a king called Gilgamesh. That king, he, too, wrestled a beastlike man, who then became a friend. Maybe that's why I knew this fight would come." },
				{ Cue = "/VO/Theseus_0561",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "What are you telling me, Asterius? Now is certainly not a good time for waxing philosophical, I think! And, surely this King Gilgamesh of whom you speak is much more competent a fighter than {#DialogueItalicFormat}this {#PreviousFormat}filth!" },
			},
		},

		BossPresentationTextLineSets =
		{
			TheseusEncounter01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Theseus_0007",
					Emote = "PortraitEmoteFiredUp",
					Text = "So, hellspawn! You seek to break through to the surface of the world. But you shall not achieve your goal, whilst I yet live and breathe! Or the equivalent of it, here in the splendors of Elysium!" },
				{ Cue = "/VO/ZagreusField_1767", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Then you leave me with little choice but to make you shut up, already. And your bull-headed manservant there." },
				{ Cue = "/VO/Theseus_0008",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "That {#DialogueItalicFormat}Minotaur {#PreviousFormat}whom you address is my dear friend, you preconceiving stain upon the earth! Asterius and I are brothers here in death as we were enemies in life. Not that you could ever understand fraternal bonds as strong as ours!" },
			},
			TheseusEncounter02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter01" },
				{ Cue = "/VO/Theseus_0009",
					Emote = "PortraitEmoteSparkly",
					Text = "{#DialogueItalicFormat}Ah-hah{#PreviousFormat}, the fiend comes crawling back once more, drawn as he is much like the unassuming moth unto the flame of righteousness!" },
				{ Cue = "/VO/ZagreusField_1768", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Oh no! Not the flame of righteousness! Are you finished? Let's get this started, I've come a long way." },
				{ Cue = "/VO/Theseus_0010",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Hear that, Asterius? Our fiendish visitor is begging us for mercy. Begging us, no doubt, to drop our guard!! Together now, my friend, let's vanquish him, and may the glory of Olympus guide us!!" },
			},
			TheseusEncounter03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter02" },
				{ Cue = "/VO/Theseus_0011",
					Emote = "PortraitEmoteFiredUp",
					Text = "And where do you think you're going, fiend?! Thought you might scoot right past Asterius and myself without a fight?" },
				{ Cue = "/VO/ZagreusField_1769", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "No, on quite the contrary I've been under no impression that avoiding conflict is an option here. So say your piece, and let's get on with it." },
				{ Cue = "/VO/Theseus_0012",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You, hellspawn, shall not traverse that gate behind me whilst my compatriot and I equivalently live and breathe! Prepare for death!" },
			},
			TheseusEncounter04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter03" },
				{ Cue = "/VO/Theseus_0013",
					Emote = "PortraitEmoteSparkly",
					Text = "{#DialogueItalicFormat}Ah, hahaha, {#PreviousFormat}you are just in time, Fiend from Lowest Depths! Asterius and I have trained extensively since our last skirmish here!" },
				{ Cue = "/VO/ZagreusField_1770", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So all you do here in Elysium is train for martial competition? You're constantly awaiting your next fight to the death?" },
				{ Cue = "/VO/Theseus_0014",
					Emote = "PortraitEmoteAnger",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "And who are {#DialogueItalicFormat}you {#PreviousFormat}to judge, you misbegotten, shameful, unfilial maggot? It is an {#DialogueItalicFormat}honor {#PreviousFormat}to have the opportunity to spend my afterlife perpetually standing in your ruinous path!" },
			},
			TheseusEncounter05 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter04" },
				{ Cue = "/VO/Theseus_0015",
					Text = "See here, Asterius! The god-hated fiend is back once more to be destroyed by our joint, righteous fury!" },
				{ Cue = "/VO/ZagreusField_1771", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#DialogueItalicFormat}God-hated{#PreviousFormat}? You'll have to be more specific. I have the gods on my side. Though I suppose you do, too. Why can't they make up their minds?" },
				{ Cue = "/VO/Theseus_0016",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "They {#DialogueItalicFormat}have {#PreviousFormat}made up their minds! They stand united against darkness, as do I! With the exception of Asterius, here, who serves the light! Let's serve it now, my friend! To battle!" },
			},

			-- theseus win streak
			TheseusWinStreak01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter05" },
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Theseus_0017",
					Emote = "PortraitEmoteSparkly",
					Text = "Upon my word, the fiend again darkens these halls! Alas, Asterius, it seems I was mistaken and he hasn't learned his lesson after all!" },
				{ Cue = "/VO/ZagreusField_1772", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "And what's this lesson that I ought have learned? Is it to always slay you first since you're so damn insufferable all the time?" },
				{ Cue = "/VO/Theseus_0018",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your lesson, monster, is to never, {#DialogueItalicFormat}ever {#PreviousFormat}take up arms against those favored by the gods themselves! You shall never see the light of day as I once did! Uh, no offense, Asterius." },
			},
			-- theseus lose streak
			TheseusLoseStreak01 =
			{
				PlayOnce = true,
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Theseus_0019",
					Text = "Well, hellspawn, you stained my honor last we battled here. But as you plainly see, I have returned! As has Asterius! And we've no shortage of honor left to spare!" },
				{ Cue = "/VO/ZagreusField_1773", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Shouldn't {#DialogueItalicFormat}I {#PreviousFormat} be the Champion of Elysium, now that I've beaten you? Isn't there someone else around to challenge me, say, Heracles? Someone less chatty?" },
				{ Cue = "/VO/Theseus_0020",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Ah, hahaha, {#PreviousFormat}very clever, fiend. Invoking Heracles' name, in an attempt to drive me to a jealous rage. It shall not work! But you shall dearly pay nevertheless!" },
			},
			TheseusLoseStreak02A =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusLoseStreak01" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Theseus_0021",
					Emote = "PortraitEmoteSparkly",
					Text = "The monster has returned, in a vainglorious attempt to wrest the title Champion from me!" },
				{ Cue = "/VO/ZagreusField_1774", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I couldn't care less about your title. Though, shouldn't you share it with the Minotaur? He's more than half the reason you've been any trouble." },
				{ Cue = "/VO/Theseus_0022",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You'll not drive a wedge between us, fiend. Asterius and I share a fraternal bond forged from the strongest bronze! Nay, adamant! But you have caused us both offense, so, die!" },
			},
			TheseusLoseStreak02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusLoseStreak01" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Theseus_0023",
					Text = "I have recovered, as you can plainly see, monster! As has Asterius! And this time we are filled with renewed vigor, to destroy you utterly!" },
				{ Cue = "/VO/ZagreusField_1775", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So we're locked in an endless cycle of violence, basically. I guess that's one way for you to pass the time here in this stodgy place." },
				{ Cue = "/VO/Theseus_0024",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You take that back about Elysium! Or, better: I shall make you eat those careless, inappropriate remarks! Come, Asterius, {#DialogueItalicFormat}to war{#PreviousFormat}!" },
			},

			-- these next several events branch based on Pact status
			TheseusWithAsterius02 =
			{
				PlayOnce = true,
				RequiredFalseTextLines = { "TheseusWithAsterius02_B" },
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				{ Cue = "/VO/Minotaur_0260", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "We're well-equipped to deal with you, short one. Though I know better than to disregard your might." },
				{ Cue = "/VO/Theseus_0273",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Speak for yourself, Asterius! I, for one, know only pure contempt for this foul daemon and his underhanded fighting style! A style we shall easily dismantle, now!" },
			},
			TheseusWithAsterius02_B =
			{
				PlayOnce = true,
				RequiredFalseTextLines = { "TheseusWithAsterius02" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				{ Cue = "/VO/Minotaur_0260", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					Text = "We're well-equipped to deal with you, short one. Though I know better than to disregard your might." },
				{ Cue = "/VO/Theseus_0273",
					Emote = "PortraitEmoteSparkly",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Speak for yourself, Asterius! I, for one, know only pure contempt for this foul daemon and his underhanded fighting style! A style we shall easily dismantle, now!" },
			},
			TheseusWithAsterius03 =
			{
				PlayOnce = true,
				RequiredFalseTextLines = { "TheseusWithAsterius03_B" },
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				{ Cue = "/VO/Theseus_0039",
					Emote = "PortraitEmoteSparkly",
					Text = "What hope have you, monster, versus the blessed bonds of brotherhood?" },
				{ Cue = "/VO/Minotaur_0261", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "Best not belittle him, king. He is more powerful than he appears. We must remain alert, this time." },
				{ Cue = "/VO/Theseus_0274",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, I am perfectly alert right now, Asterius! And were I still alive, I would be positively salivating at the thought of running through this pustule with my spear, or whichever means I had available! Now, {#DialogueItalicFormat}let's go{#PreviousFormat}!" },
			},
			TheseusWithAsterius03_B =
			{
				PlayOnce = true,
				RequiredFalseTextLines = { "TheseusWithAsterius03" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				{ Cue = "/VO/Theseus_0039",
					Emote = "PortraitEmoteSparkly",
					Text = "What hope have you, monster, versus the blessed bonds of brotherhood?" },
				{ Cue = "/VO/Minotaur_0261", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					Text = "Best not belittle him, king. He is more powerful than he appears. We must remain alert, this time." },
				{ Cue = "/VO/Theseus_0274",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, I am perfectly alert right now, Asterius! And were I still alive, I would be positively salivating at the thought of running through this pustule with my spear, or whichever means I had available! Now, {#DialogueItalicFormat}let's go{#PreviousFormat}!" },
			},
			TheseusWithAsterius04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter05" },
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				{ Cue = "/VO/ZagreusField_2761", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Theseus, before you flap your ghostly gums at me again, I'd like to hear from good Asterius this time! He almost never gets a word in, thanks to you." },
				{ Cue = "/VO/Minotaur_0270", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "The king speaks for the both of us, short one. Though if you wish to hear me say something to you, I will oblige." },
				{ Cue = "/VO/Theseus_0293",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Emote = "PortraitEmoteSparkly",
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "And I, too, shall oblige! That is, oblige my trusty spear, which yearns to penetrate your soft and vulnerable, altogether pallid flesh! Now, die!" },
			},

			TheseusPostEnding01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter01", "PersephoneMeeting06" },
				{ Cue = "/VO/Theseus_0444",
					Emote = "PortraitEmoteSparkly",
					Text = "Why, look, Asterius, the fiend returns! The rumors that he fled to haunt the surface must have been mere lies!" },
				{ Cue = "/VO/ZagreusField_4274", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well no, in this case, those rumors must have been quite accurate, it's just, I'm back! Realized I didn't want a future for myself that didn't include crushing you repeatedly like this." },
				{ Cue = "/VO/Theseus_0445",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Oh, {#DialogueItalicFormat}hoho{#PreviousFormat}, such {#DialogueItalicFormat}clever {#PreviousFormat}excuse-making from one so versed in treachery! Well, if you are indeed contained within this realm, then we shall be delighted to make sure it always stays that way! Now come and fight!" },
			},
			TheseusPostEpilogue01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter01", "OlympianReunionQuestComplete" },
				{ Cue = "/VO/Theseus_0562",
					Emote = "PortraitEmoteSparkly",
					Text = "Have you yet heard, monster?! The Queen Persephone is back! To rule the Underworld in all her terrifying grace! Perhaps one of these days or nights she shall be present in the stands, to witness your destruction at our hands!" },
				{ Cue = "/VO/ZagreusField_4275", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Yeah, about that? She's my mother. So maybe watch your fool mouth with me, or else I might just put in a bad word!" },
				{ Cue = "/VO/Theseus_0563",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteAnger",
					Text = "Oh, you disgust me, daemon, that you would even dare to say such things about the Queen! Prepare now to be {#DialogueItalicFormat}vanquished {#PreviousFormat}in her name!" },
			},

			TheseusLowHealth01 =
			{
				PlayOnce = true,
				RequiredMaxHealthFraction = 0.25,
				RequiredMaxLastStands = 0,
				RequiredTextLines = { "TheseusEncounter01" },
				{ Cue = "/VO/Theseus_0027",
					Emote = "PortraitEmoteSparkly",
					Text = "What's this, Asterius? This blackguard thinks that he can saunter in here whilst bleeding profusely, and confront the two of us?! A hollow fool!" },
				{ Cue = "/VO/ZagreusField_1777", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Ran into trouble on the way with your combative friends here in Elysium. One more unfair advantage in your favor." },
				{ Cue = "/VO/Theseus_0028",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteFiredUp",
					Text = "How would you know of fairness, fiend? You belong in the lowest depths, forgotten in the mists of time! Come, let us send you there!" },
			},
			TheseusLowHealth02 =
			{
				PlayOnce = true,
				RequiredMaxHealthFraction = 0.25,
				RequiredMaxLastStands = 0,
				RequiredTextLines = { "TheseusEncounter01" },
				{ Cue = "/VO/Theseus_0289",
					Emote = "PortraitEmoteSparkly",
					Text = "Look at this contemptible fiend, stumbling half-dead already into our hallowed colosseum! What transpired, monster, did perchance my Exalted brethren trouble your dark path?" },
				{ Cue = "/VO/ZagreusField_2758", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Theseus? I would appreciate it if you could be more considerate of the substantial effort necessary just to reach this point where I can make you shut your mouth." },
				{ Cue = "/VO/Theseus_0290",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Effort, {#DialogueItalicFormat}pah{#PreviousFormat}! You shall be imminently slain, and {#DialogueItalicFormat}effortlessly{#PreviousFormat}, I am quite certain of that! Asterius, to arms!!" },
			},
			TheseusLowHealth03 =
			{
				PlayOnce = true,
				RequiredMaxHealthFraction = 0.25,
				RequiredMaxLastStands = 0,
				RequiredTextLines = { "TheseusEncounter01" },
				{ Cue = "/VO/Theseus_0291",
					Emote = "PortraitEmoteSparkly",
					Text = "What hope can you possibly have of vanquishing us, hellspawn, when you are visibly upon the verge of death? You are, more than usual, a miserable sight!" },
				{ Cue = "/VO/ZagreusField_2759", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Thanks for your concern, there, Theseus. But I trust I have plenty of life left in me with which to destroy you, if not your companion as well." },
				{ Cue = "/VO/Theseus_0292",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Hah! {#PreviousFormat}What would you know of trust! Being a vile, grievously-wounded-already creature such as you are! Asterius, let's end his misery!" },
			},

			TheseusYarnReaction01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter01" },
				RequiredTrait = "TemporaryBoonRarityTrait",
				{ Cue = "/VO/Theseus_0025",
					Emote = "PortraitEmoteSurprise",
					Text = "What's this? Our enemy has come to mock us, Asterius! He holds the Yarn of Ariadne, and would flaunt it in our faces!" },
				{ Cue = "/VO/ZagreusField_1776", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "What, this? I just picked it out of a Well. Was supposed to help me get here. No offense intended, more than usual. What's it to you?" },
				{ Cue = "/VO/Theseus_0026",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "As if you wouldn't know! That Yarn is a token of days long gone. When Asterius and I battled in the Labyrinth, to the death! Together, we now face a greater threat. Attack us if you dare!" },
			},
			TheseusYarnReaction02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusYarnReaction01" },
				RequiredTrait = "TemporaryBoonRarityTrait",
				{ Cue = "/VO/Theseus_0283",
					Emote = "PortraitEmoteSurprise",
					Text = "Again you mock me with the Yarn of Ariadne, blackguard. You ought know that woman's name means absolutely nothing to me, now!" },
				{ Cue = "/VO/ZagreusField_2756", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "You seem pretty put off by a random bit of twine, there, Former King of Athens. Care to share your innermost thoughts on the subject, or best keep them bottled up?" },
				{ Cue = "/VO/Theseus_0284",
					Emote = "PortraitEmoteAnger",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Nothing shall be bottled {#DialogueItalicFormat}here{#PreviousFormat}, you filth! That she became enamored of me was not my responsibility, besides! She was naive! The same as you." },
			},
			TheseusYarnReaction03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusYarnReaction02" },
				RequiredTrait = "TemporaryBoonRarityTrait",
				{ Cue = "/VO/Theseus_0285",
					Emote = "PortraitEmoteSurprise",
					Text = "That blasted Yarn of Ariadne, once again!! Have you no shred of dignity at all, monster? Or would you stoop to any desperate means to draw me out?" },
				{ Cue = "/VO/ZagreusField_2757", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Just happened to have it on me, Theseus. But it seems to keep upsetting you. Maybe you should seek this Ariadne in my father's realm, and make amends?" },
				{ Cue = "/VO/Theseus_0286",
					Emote = "PortraitEmoteAnger",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Maybe {#DialogueItalicFormat}you {#PreviousFormat}should {#DialogueItalicFormat}shut up{#PreviousFormat}!! That Ariadne's dead to me. She has been since we were alive! I cherish her memory, yes. But only because, if not for her, I'd not have met Asterius! Now, meet his axe!!" },
			},
			-- alt below
			TheseusYarnReaction04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusYarnReaction03" },
				RequiredFalseTextLines = { "TheseusYarnReaction04_B" },
				RequiredTrait = "TemporaryBoonRarityTrait",
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				{ Cue = "/VO/Theseus_0287",
					Text = "Why, look, Asterius! It seems the fiend has brought some sort of nondescript yarn-ball! Not seen the likes of it. Indeed, it holds no sway on me, at all!" },
				{ Cue = "/VO/Minotaur_0265", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					Text = "King. The princess Ariadne was my sister, if you don't recall. Please do not denigrate her memory. {#DialogueItalicFormat}<Snort> {#PreviousFormat}You're making me upset." },
				{ Cue = "/VO/Theseus_0288",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Ah{#PreviousFormat}, no, my friend! I meant you no offense! But I'd no love for her, was that my fault?! {#DialogueItalicFormat}Pff{#PreviousFormat}, forgive me. I... I shall seek her out. Someday or night. But first!! This daemon {#DialogueItalicFormat}has {#PreviousFormat}to be destroyed. Together, no?!" },
			},
			TheseusYarnReaction04_B =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusYarnReaction03" },
				RequiredFalseTextLines = { "TheseusYarnReaction04" },
				RequiredTrait = "TemporaryBoonRarityTrait",
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				{ Cue = "/VO/Theseus_0287",
					Text = "Why, look, Asterius! It seems the fiend has brought some sort of nondescript yarn-ball! Not seen the likes of it. Indeed, it holds no sway on me, at all!" },
				{ Cue = "/VO/Minotaur_0265", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					Text = "King. The princess Ariadne was my sister, if you don't recall. Please do not denigrate her memory. {#DialogueItalicFormat}<Snort> {#PreviousFormat}You're making me upset." },
				{ Cue = "/VO/Theseus_0288",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Ah{#PreviousFormat}, no, my friend! I meant you no offense! But I'd no love for her, was that my fault?! {#DialogueItalicFormat}Pff{#PreviousFormat}, forgive me. I... I shall seek her out. Someday or night. But first!! This daemon {#DialogueItalicFormat}has {#PreviousFormat}to be destroyed. Together, no?!" },
			},

			TheseusAutographReaction01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "HypnosAutograph01" },
				{ Cue = "/VO/Theseus_0448",
					Emote = "PortraitEmoteSparkly",
					Text = "Now hold a moment, fiend! Asterius made me aware that you recently asked of him an {#DialogueItalicFormat}autograph{#PreviousFormat}. A tribute to his fame! As I am Champion, I am prepared to generously offer mine, as well." },
				{ Cue = "/VO/ZagreusField_2760", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh! No thanks. Appreciate the offer, though. How about a fight, instead?" },
				{ Cue = "/VO/Theseus_0449",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Emote = "PortraitEmoteAnger",
					Text = "{#DialogueItalicFormat}Ah, pffsch{#PreviousFormat}, you...! 'Twas merely a jest! I'd not have given you the cloth about my loins, much less my name! But a fight you certainly shall have!" },
			},

			TheseusAboutBeingChampion01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter01" },
				RequiredKills = { Theseus = 8, Theseus2 = 2 },
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 2,
				},
				{ Cue = "/VO/Theseus_0532",
					Emote = "PortraitEmoteSparkly",
					Text = "Ready yourself, Asterius, my friend! For our most hated enemy has come to challenge us again, before this loving crowd!" },
				{ Cue = "/VO/ZagreusField_3876", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "I don't understand this place at all. How is it you're still champion after all this time? After losing repeatedly and often, I mean." },
				{ Cue = "/VO/Theseus_0533",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "What would you know of it?! There's more, much more, to being champion than empty victories! It is a way of thought. A bearing! A certain dignity which you shall never have!" },
			},
			TheseusAboutGods01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter01" },
				RequiredCountOfTraitsCount = 2,
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
				{ Cue = "/VO/Theseus_0536",
					Emote = "PortraitEmoteSparkly",
					Text = "The gods are testing us once more, Asterius! For, how else to explain this fiend approaching us, bearing such blessings as would normally be fit only for heroes such as we?" },
				{ Cue = "/VO/ZagreusField_3878", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You {#DialogueItalicFormat}do {#PreviousFormat}know I'm related to them, right? The god of the dead is my father? I'm sure word's gotten around. Not that I want deferential treatment from the likes of you." },
				{ Cue = "/VO/Theseus_0537",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Good! For you'll get nothing of the sort. The gods are on {#DialogueItalicFormat}my {#PreviousFormat}side, not yours, monster! What business would they have, abetting you?" },
			},

			TheseusAboutFraternalBonds01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter01", "PersephoneFirstMeeting" },
				RequiredKills = { Theseus = 10, Theseus2 = 1 },
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Theseus_0538",
					Emote = "PortraitEmoteDepressed",
					Text = "Beware, Asterius! The daemon comes! The daemon, who would sever the fraternal bonds we share, if we so much as drop our guard!" },
				{ Cue = "/VO/ZagreusField_3879", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "What? You think I'm here to ruin your friendship? Look, to each his own in that regard, though since you bring it up, I really don't see why Asterius puts up with you." },
				{ Cue = "/VO/Theseus_0539",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}You see{#PreviousFormat}? Just as I said! Cover your bovine ears, Asterius, for this monstrosity would poison us to get the upper hand!" },
			},

			TheseusAboutManyBattles01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter01", "Ending01" },
				RequiredKills = { Theseus = 25 },
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 2,
				},
				{ Cue = "/VO/Theseus_0556",
					Emote = "PortraitEmoteSparkly",
					Text = "You know, hellspawn, I have been thinking on this for some time, and I've a declaration I must make: I shall hear no more of your silver-tongued lies. You come here, and we fight, and that is all!" },
				{ Cue = "/VO/ZagreusField_3885", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "What are you even talking about? I barely get a word in edgewise, much less Asterius over there. You know what? Fine. I've had it with you, anyway." },
				{ Cue = "/VO/Theseus_0557",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "And {#DialogueItalicFormat}I{#PreviousFormat}'ve had it with {#DialogueItalicFormat}you{#PreviousFormat}! Now, come, Asterius, let's shut this blackguard up! Or shut him {#DialogueItalicFormat}down{#PreviousFormat}, whichever you prefer." },
			},
			TheseusAboutManyBattles02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusAboutManyBattles01" },
				RequiredKills = { Theseus = 30 },
				MinRunsSinceAnyTextLines = { TextLines = { "TheseusAboutManyBattles01" }, Count = 10 },
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 2,
				},
				{ Cue = "/VO/Theseus_0558",
					Emote = "PortraitEmoteSparkly",
					Text = "There is but one thing I shall give to you, blackguard. Other than the razor-sharp point of my blessed spear! You are resilient. Time after time, you challenge us! Sometimes I fear I shall develop some sort of grudging respect for you!" },
				{ Cue = "/VO/ZagreusField_3886", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "I've no such fear, myself, Theseus. Though, I appreciate you noticing. You're quite an inspiration, you know? I wouldn't come all this way to destroy just anyone." },
				{ Cue = "/VO/Theseus_0559",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "To {#DialogueItalicFormat}be {#PreviousFormat}destroyed, you mean! I see you plain, monster. You seek the glory of this fight, before this crowd? You yearn for it! Then, you shall have it! Just as often as you please!" },
			},
			TheseusAboutPainting01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter05" },
				RequiredCosmetics = { "Cosmetic_NorthHallPaintingTheseus" },
				{ Cue = "/VO/Theseus_0534",
					Emote = "PortraitEmoteSparkly",
					Text = "I vividly recall our every clash against you, daemon. Each victory! And even the defeats. But you? You've not learned anything, have you?" },
				{ Cue = "/VO/ZagreusField_3877", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It's all right, Theseus. We have a splendid painting of you back at the House, for those moments when I invariably forget you exist. You were quite dashing with long hair, you know!" },
				{ Cue = "/VO/Theseus_0535",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "So, I am honored even in the lowest pits of hell? And yet, remembered in my carefree youth. Not in the wisdom of my latter days! Well then, remember {#DialogueItalicFormat}this{#PreviousFormat}!" },
			},

			TheseusHasWeaponUpgrade01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter03" },
				RequiredTrait = "SpearTeleportTrait",
				RequiredWeapon = "SpearWeapon",
				{ Cue = "/VO/Theseus_0281",
					Emote = "PortraitEmoteSparkly",
					Text = "What, {#DialogueItalicFormat}ho{#PreviousFormat}, that is a handsome spear you doubtless claimed deceitfully from some more-worthy bearer than yourself!" },
				{ Cue = "/VO/ZagreusField_2755", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Oh, this old thing? How nice of you to notice. It once belonged to the hero, Achilles. A little past your time, but maybe you've heard of him? Seeing as he's {#DialogueItalicFormat}much {#PreviousFormat}more famous than you ever were." },
				{ Cue = "/VO/Theseus_0282",
					Emote = "PortraitEmoteAnger",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "How {#DialogueItalicFormat}dare {#PreviousFormat}you say such things to me! I was the greatest king of Athens in my day! The tales of my exploits with Asterius and many other challenges shall long outlive whatever comes of {#DialogueItalicFormat}you{#PreviousFormat}!" },
			},
			TheseusAboutArthurAspect01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter03" },
				RequiredTrait = "SwordConsecrationTrait",
				RequiredWeapon = "SwordWeapon",
				{ Cue = "/VO/Theseus_0554",
					Emote = "PortraitEmoteSparkly",
					Text = "Tell me something, monster: Whence did you steal that kingly blade you're brandishing about? It seems ill-fitting for one such as you." },
				{ Cue = "/VO/ZagreusField_3884", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Oh, this? I wouldn't say I stole it, so much as naturally wooed the Fates into bestowing it upon me. You could say I'm kind of testing it out." },
				{ Cue = "/VO/Theseus_0555",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Ahh{#PreviousFormat}, well then! I pity whosoever shall lay hands upon that cursed thing, once you are finished with this {#DialogueItalicFormat}testing {#PreviousFormat}of yours. I think that we can make it rather quick!" },
			},

			TheseusMiscStartWithGilgameshAspect01 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusAboutGilgameshAspect01", "TheseusAboutGilgameshAspect01_B" },
				RequiredFalseTextLines = { "TheseusMiscStartWithGilgameshAspect01_B" },
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				RequiredWeapon = "FistWeapon",
				RequiredTrait = "FistDetonateTrait",
				{ Cue = "/VO/Minotaur_0296", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "There, king! He has the weapons I told you about... the fists of Gilgamesh. Follow my lead this time." },
			},
			TheseusMiscStartWithGilgameshAspect01_B =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusAboutGilgameshAspect01", "TheseusAboutGilgameshAspect01_B" },
				RequiredFalseTextLines = { "TheseusMiscStartWithGilgameshAspect01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				RequiredWeapon = "FistWeapon",
				RequiredTrait = "FistDetonateTrait",
				{ Cue = "/VO/Minotaur_0296", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "There, king! He has the weapons I told you about... the fists of Gilgamesh. Follow my lead this time." },
			},
		},

		-- following are short misc repeatable evergreen combat start lines
		BossPresentationRepeatableTextLineSets =
		{
			-- other general cases
			TheseusMiscStart01 =
			{
				{ Cue = "/VO/Theseus_0029",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Prepare to be sent back into the depths whence you came!" },
			},
			TheseusMiscStart02 =
			{
				{ Cue = "/VO/Theseus_0030",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "{#DialogueItalicFormat}Ahh{#PreviousFormat}, at last! Come, Asterius, let's vanquish this blackguard!" },
			},

			TheseusMiscStart03 =
			{
				{ Cue = "/VO/Theseus_0031",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Come, hellspawn, and get destroyed by the two greatest fighters in Elysium!" },
			},
			TheseusMiscStart04 =
			{
				{ Cue = "/VO/Theseus_0032",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Dare you clash against the Champion of Elysium and his most trusted friend?" },
			},
			TheseusMiscStart05 =
			{
				{ Cue = "/VO/Theseus_0033",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "If you seek a swift and righteous death, you fiend, you've come to the right place!" },
			},
			TheseusMiscStart06 =
			{
				{ Cue = "/VO/Theseus_0034",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Come forth and die, preferably with some amount of dignity!" },
			},
			TheseusMiscStart07 =
			{
				{ Cue = "/VO/Theseus_0035",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "It's time, Asterius! Let us assert our greatness through single-minded combat!" },
			},
			TheseusMiscStart08 =
			{
				{ Cue = "/VO/Theseus_0036",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "By the gods of Olympus, you'll go no further on your wicked quest!" },
			},
			TheseusMiscStart09 =
			{
				{ Cue = "/VO/Theseus_0037",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "There is no greater pleasure in Elysium than vanquishing the likes of you!" },
			},
			TheseusMiscStart10 =
			{
				{ Cue = "/VO/Theseus_0038",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I swear upon my honor, fiend, you shall not pass!" },
			},
			TheseusMiscStart11 =
			{
				RequiredFalseTextLinesLastRun = { "TheseusWithAsterius03", "TheseusWithAsterius03_B" },
				{ Cue = "/VO/Theseus_0527",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "No matter how you try, you cannot shake the bond we share, monster!" },
			},
			TheseusMiscStart12 =
			{
				{ Cue = "/VO/Theseus_0040",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You stop right there, blackguard, and make your plans for death!" },
			},
			TheseusMiscStart13 =
			{
				{ Cue = "/VO/Theseus_0041",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "We've nothing left to say to one another, hellspawn! Other than: To battle!" },
			},
			TheseusMiscStart14 =
			{
				{ Cue = "/VO/Theseus_0042",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Few others in Elysium are so unwise to take up arms against Asterius and myself!" },
			},
			TheseusMiscStart15 =
			{
				{ Cue = "/VO/Theseus_0043",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You challenge us to battle, hellspawn?! Then, Asterius and I accept!" },
			},
			TheseusMiscStart16 =
			{
				{ Cue = "/VO/Theseus_0044",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Attack us if you dare, blackguard! Asterius and I stand ready!" },
			},
			TheseusMiscStart17 =
			{
				{ Cue = "/VO/Theseus_0045",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I see my brethren failed to thwart your advance. Well, you shall go no further!" },
			},
			TheseusMiscStart18 =
			{
				{ Cue = "/VO/Theseus_0046",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Come forth, blackguard, and be vanquished by my righteous spear!" },
			},
			TheseusMiscStart19 =
			{
				{ Cue = "/VO/Theseus_0047",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Asterius and I shall smite you back into the lowest depths of hell!" },
			},
			TheseusMiscStart20 =
			{
				{ Cue = "/VO/Theseus_0048",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You are beneath the notice of the gods, monster! Whilst I have earned their favor!" },
			},
			TheseusMiscStart21 =
			{
				{ Cue = "/VO/Theseus_0049",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You return at your peril, hellspawn. You'll get no quarter here!" },
			},
			TheseusMiscStart22 =
			{
				{ Cue = "/VO/Theseus_0050",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Upon my faith, you'll take not one more step toward the light of day!" },
			},
			TheseusMiscStart23 =
			{
				{ Cue = "/VO/Theseus_0528",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Face us, {#DialogueItalicFormat}filth{#PreviousFormat}! However many times it takes, until you cannot stand it any longer!" },
			},
			TheseusMiscStart24 =
			{
				{ Cue = "/VO/Theseus_0529",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Behold, Asterius! Our hated enemy has come to be dispatched before a loving crowd, once more!" },
			},
			TheseusMiscStart25 =
			{
				{ Cue = "/VO/Theseus_0530",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Try as you might, monster, you shall not shake either my own resolve, or that of my dear friend!" },
			},
			TheseusMiscStart26 =
			{
				{ Cue = "/VO/Theseus_0531",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Our foolhardy challenger approaches once again, I see! Well, then, prepare to be run through!" },
			},

			-- with minotaur lines
			TheseusMiscStart23_A =
			{
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				MinRunsSinceAnyTextLines = { TextLines = { "TheseusMiscStart23_A", "TheseusMiscStart23_B" }, Count = 10 },
				{ Cue = "/VO/Minotaur_0077", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You face the Champion, and me. Ready yourself." },
			},
			TheseusMiscStart23_B =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				MinRunsSinceAnyTextLines = { TextLines = { "TheseusMiscStart23_A", "TheseusMiscStart23_B" }, Count = 15 },
				{ Cue = "/VO/Minotaur_0077", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You face the Champion, and me. Ready yourself." },
			},
			TheseusMiscStart24_A =
			{
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				MinRunsSinceAnyTextLines = { TextLines = { "TheseusMiscStart24_A", "TheseusMiscStart24_B" }, Count = 15 },
				{ Cue = "/VO/Minotaur_0078", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Let us destroy him quickly, king. Or, perhaps slowly." },
			},
			TheseusMiscStart24_B =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				MinRunsSinceAnyTextLines = { TextLines = { "TheseusMiscStart24_A", "TheseusMiscStart24_B" }, Count = 15 },
				{ Cue = "/VO/Minotaur_0078", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Let us destroy him quickly, king. Or, perhaps slowly." },
			},
			TheseusMiscStart25_A =
			{
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				MinRunsSinceAnyTextLines = { TextLines = { "TheseusMiscStart25_A", "TheseusMiscStart25_B" }, Count = 15 },
				{ Cue = "/VO/Minotaur_0079", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Waste not more words with this one, king. Let's fight." },
			},
			TheseusMiscStart25_B =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				MinRunsSinceAnyTextLines = { TextLines = { "TheseusMiscStart25_A", "TheseusMiscStart25_B" }, Count = 15 },
				{ Cue = "/VO/Minotaur_0079", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Waste not more words with this one, king. Let's fight." },
			},
			TheseusMiscStart26_A =
			{
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				MinRunsSinceAnyTextLines = { TextLines = { "TheseusMiscStart26_A", "TheseusMiscStart26_B" }, Count = 15 },
				{ Cue = "/VO/Minotaur_0080", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Default_01",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "It is as the king said. You will not leave Elysium except through us." },
			},
			TheseusMiscStart26_B =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				MinRunsSinceAnyTextLines = { TextLines = { "TheseusMiscStart26_A", "TheseusMiscStart26_B" }, Count = 15 },
				{ Cue = "/VO/Minotaur_0080", Speaker = "Minotaur", Portrait = "Portrait_Minotaur_Armored_01",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "It is as the king said. You will not leave Elysium except through us." },
			},

			-- win streak
			TheseusMiscStartWinStreak01 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Theseus_0051",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Look who has managed to come crawling back, Asterius? Let us deliver him again!" },
			},
			TheseusMiscStartWinStreak02 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Theseus_0052",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Try as you might, monster, Asterius and I shall stop you!" },
			},
			TheseusMiscStartWinStreak03 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_Boss01",
				  Count = 1,
				},
				{ Cue = "/VO/Theseus_0053",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You must take sick, appalling pleasure in defeat, hellspawn!" },
			},
			-- lose streak
			TheseusMiscStartLoseStreak01 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 2,
				},
				{ Cue = "/VO/Theseus_0054",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I shall never yield the title Champion of Elysium to the likes of you!" },
			},
			TheseusMiscStartLoseStreak02 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 2,
				},
				{ Cue = "/VO/Theseus_0055",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "You think that you can get through me again, hellspawn? Come try!" },
			},
			TheseusMiscStartLoseStreak03 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_Boss01",
				  Count = 2,
				},
				{ Cue = "/VO/Theseus_0056",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource", PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I {#DialogueItalicFormat}always {#PreviousFormat}shall rise up to thwart your wicked plans, monster!" },
			},
		},
		ProjectileBlockPresentationFunctionName = "ShadeBlockPresentation",
		ProjectileBlockSoundName = "/SFX/Enemy Sounds/Theseus/EmoteChuckle",
		OnDamagedFunctionName = "TheseusDamaged",
	},

	-- Armored Theseus
	Theseus2 =
	{
		InheritFrom = { "Theseus", "BaseBossEnemy"  },
		Portrait = "Portrait_Theseus_Armored_01",
		TauntAnimation = "TheseusChariot_TauntReturnToIdle",
		SpawnAnimation = "TheseusChariot_Taunt_Start",
		AnimOffsetZ = 220,

		GenusName = "Theseus",

		AISetupDelay = 1.5,
		MaxHealth = 12000,
		StopBiomeTimerIfComboPartnerDead = true,

		EndThreadWaitsOnDeath = "TheseusMinotaurSpawns",
		ComboPartnerName = "Minotaur2",
		Groups = { "GroundEnemies" },

		DismountSpeedMultiplier = 10,
		DismountWaitDuration = 5.25,

		OnDeathFunctionName = "TheseusMinotaurKillPresentation",
		OnDeathFunctionArgs = { Message = "TheseusDefeatedMessage", StartPanTime = 1.5, EndPanTime = 3.5, StartSound = "/SFX/Enemy Sounds/HydraHead/EmoteAttacking", EndAngle = 270, FlashRed = true, AddInterBiomeTimerBlock = true },

		Material = "Armored",
		HealthBarOffsetY = -275,
		--RepulseOnMeleeInvulnerableHit = 400,
		IgnoreInvincibubbleOnHit = true,
		DeathAnimation = "TheseusDeathVFX",
		ClearChillOnDeath = true,

		DefaultAIData =
		{
			ComboPartnerName = "Minotaur2",

			AIAttackDistance = 200,
			AIBufferDistance = 200,
			AIMoveWithinRangeTimeout = 10.0,
		},

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		WeaponOptions =
		{
			"TheseusChariotCenterDive", "TheseusChariotClusterBomb", "TheseusChariotExteriorPatrol", "TheseusChariotWait",
		},

		AIEndHealthThreshold = 0.33,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "TheseusChariotAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.33,
				},
			},
			{
				RandomAIFunctionNames = { "TheseusGodAI" },
				TransitionFunction = "TheseusChariotDismount",
				UnequipWeapons = { "TheseusChariotCenterDive", "TheseusChariotClusterBomb", "TheseusChariotExteriorPatrol", "TheseusChariotWait" },
				EquipWeapons = { "TheseusSpearThrow", "TheseusSpearSpin" },
				WaitDuration = 0.7,
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
		},


		MetaPointDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 4,
			MaxParcels = 4,
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		Binks =
		{
			"TheseusWalk_Bink",
			"TheseusIdle_Bink",
			"TheseusSpearSpin_Bink",
			"TheseusWrath_Bink",
			"TheseusSpearThrow_Bink",
			"TheseusChariotTaunt_Bink",
			"TheseusChariotRide_Bink",
			"TheseusChariotFall_Bink",
			--"MinotaurTheseusThrow_Bink",
			"TheseusTaunt_Bink",
			"TheseusDeathVFX_Bink",
		},
		OnDamagedFunctionName = "Theseus2Damaged",
		Groups = { "NPCs" },
		OutgoingDamageModifiers =
		{
			{
				Name = "FriendImmunity",
				FriendMultiplier = 0,
				Multiplicative = true,
			},
		},
	},

	-- Minotaur
	-- Asterius
	Minotaur =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		HealthBarTextId = "Minotaur_NickName",
		AltHealthBarTextIds =
		{
			{ TextId = "Minotaur_Full", Requirements = { RequiredRoom = "C_MiniBoss01" } },
		},
		Portrait = "Portrait_Minotaur_Default_01",
		TauntAnimation = "Minotaur_Taunt",
		SpeechCooldownTime = 12,
		AnimOffsetZ = 240,

		OnDeathCrowdReaction = { AnimationNames = { "StatusIconGrief", "StatusIconOhBoy", "StatusIconDisgruntled" }, Sound = "/SFX/TheseusCrowdBoo", ReactionChance = 0.15, Delay = 1.8, Requirements = { RequiredRoom = "C_Boss01" }, Shake = true, RadialBlur = true },

		GenusName = "Minotaur",

		MaxHealth = 14000,
		AISetupDelay = 1.5,
		StopBiomeTimerIfComboPartnerDead = true,

		EndThreadWaitsOnDeath = "TheseusMinotaurSpawns",
		EnrageOnDeath = "Theseus",
		EnrageOnDeathStartDelay = 1.0,
		EnragedPresentation = "MinotaurEnragedPresentation",
		ComboPartnerName = "Theseus",
		Groups = { "GroundEnemies" },
		ExpireEffectOnThreshold = "BullRushSpeed",

		PreDamageIfEncounterCompleted = "MiniBossMinotaur",
		PreDamagePercent = 0.80,

		OnDeathFunctionName = "TheseusMinotaurKillPresentation",
		OnDeathFunctionArgs = { Message = "MinotaurDefeatedMessage", StartPanTime = 1.5, EndPanTime = 3.5, StartSound = "/SFX/Enemy Sounds/Minotaur/EmoteDying", EndAngle = 270, FlashRed = true, AddInterBiomeTimerBlock = true },

		Material = "Organic",
		HealthBarOffsetY = -275,
		--RepulseOnMeleeInvulnerableHit = 400,
		IgnoreInvincibubbleOnHit = true,
		DeathAnimation ="MinotaurDeathVFX",
		ClearChillOnDeath = true,
		DestroyDelay = 5.0,

		DeathSound = "/SFX/Enemy Sounds/Minotaur/EmoteDying",

		DefaultAIData =
		{
			DeepInheritance = true,
			ComboPartnerName = "Theseus",
			PreAttackEndMinWaitTime = 0.3,
		},

		WeaponOptions =
		{
			"Minotaur5AxeCombo1", "MinotaurLeapCombo1", "MinotaurBullRush",
			"MinotaurTheseusThrow_Minotaur", "MinotaurTheseusSlam_Minotaur"--, "MinotaurTheseusXStrike_Minotaur"
		},

		AIEndHealthThreshold = 0.5,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.5,
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "Minotaur_Taunt",
				StartDelay = 1.75,
				PermanentlyEnrage = true,
				EquipWeapons = { "MinotaurAxeOverhead", "MinotaurBullRush2", "MinotaurCrescentCombo1" },
				UnequipWeapons = { "MinotaurBullRush" },
				AIData =
				{
					AIEndHealthThreshold = 0.20,
					ThresholdOverrideIfInRoom = { Room = "C_Boss01", Value = 0.0 },
				},
				StageTransitionVoiceLines =
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.45,
					Cooldowns =
					{
						{ Name = "MinotaurQuipAnySpeech" },
					},

					-- Beware.
					{ Cue = "/VO/Minotaur_0178" },
					-- <Snort>
					{ Cue = "/VO/Minotaur_0182" },
					-- Hrr. <Snort>
					{ Cue = "/VO/Minotaur_0183" },
					-- You're strong.
					{ Cue = "/VO/Minotaur_0150" },
					-- Not finished.
					{ Cue = "/VO/Minotaur_0155" },
					-- Fight on.
					{ Cue = "/VO/Minotaur_0156" },
					-- Huh.
					{ Cue = "/VO/Minotaur_0157" },
					-- Hmm.
					{ Cue = "/VO/Minotaur_0158" },
					-- Good.
					{ Cue = "/VO/Minotaur_0159" },
					-- I'll crush you.
					{ Cue = "/VO/Minotaur_0188" },

				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "MinotaurFinalStageTransition",
				TransitionAnimation = "Minotaur_Taunt",
				StartDelay = 0.0,
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
		},

		PlayerInjuredVoiceLineThreshold = 0.35,
		PlayerInjuredVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.75,
			CooldownTime = 180,
			CooldownName = "MinotaurSpokeRecently",
			SuccessiveChanceToPlay = 0.25,

			-- Got you.
			{ Cue = "/VO/Minotaur_0177" },
			-- Beware.
			{ Cue = "/VO/Minotaur_0178" },
			-- Now...
			{ Cue = "/VO/Minotaur_0179" },
			-- Fight me.
			{ Cue = "/VO/Minotaur_0180" },
			-- Heh.
			{ Cue = "/VO/Minotaur_0181" },
			-- <Snort>
			{ Cue = "/VO/Minotaur_0182" },
			-- Hrr. <Snort>
			{ Cue = "/VO/Minotaur_0183" },
			-- There.
			{ Cue = "/VO/Minotaur_0184" },
			-- Fall.
			{ Cue = "/VO/Minotaur_0185" },
			-- Pain.
			{ Cue = "/VO/Minotaur_0186" },
			-- Destruction.
			{ Cue = "/VO/Minotaur_0187" },
			-- I'll crush you.
			{ Cue = "/VO/Minotaur_0188" },
		},
		LastStandReactionVoiceLineMinHealthThreshold = 0.3,
		LastStandReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			RequiredUnitsNotAlive = { "Theseus", "Theseus2" },
			PreLineWait = 2.2,
			CooldownTime = 40,
			SuccessiveChanceToPlay = 0.66,
			Queue = "Always",

			-- There.
			{ Cue = "/VO/Minotaur_0146" },
			-- Still standing.
			{ Cue = "/VO/Minotaur_0147" },
			-- You lived through that.
			{ Cue = "/VO/Minotaur_0148" },
			-- You'll die yet.
			{ Cue = "/VO/Minotaur_0149" },
			-- You're strong.
			{ Cue = "/VO/Minotaur_0150" },
			-- Fight me.
			{ Cue = "/VO/Minotaur_0151" },
			-- Survived...
			{ Cue = "/VO/Minotaur_0152" },
			-- That's it.
			{ Cue = "/VO/Minotaur_0153" },
			-- More.
			{ Cue = "/VO/Minotaur_0154" },
			-- Not finished.
			{ Cue = "/VO/Minotaur_0155" },
			-- Fight on.
			{ Cue = "/VO/Minotaur_0156" },
			-- Huh.
			{ Cue = "/VO/Minotaur_0157" },
			-- Hmm.
			{ Cue = "/VO/Minotaur_0158" },
			-- Good.
			{ Cue = "/VO/Minotaur_0159" },
			-- Once more.
			{ Cue = "/VO/Minotaur_0160" },
			-- Die, now.
			{ Cue = "/VO/Minotaur_0161" },
			-- Fall!
			{ Cue = "/VO/Minotaur_0162" },
		},
		WrathReactionVoiceLineMinHealthThreshold = 0.3,
		WrathReactionVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 1.1,
			CooldownTime = 120,
			SuccessiveChanceToPlay = 0.2,
			Queue = "Interrupt",
			RequiredUnitsNotAlive = { "Theseus", "Theseus2" },

			-- The gods...
			{ Cue = "/VO/Minotaur_0163" },
			-- Gods.
			{ Cue = "/VO/Minotaur_0164" },
			-- Nice trick.
			{ Cue = "/VO/Minotaur_0165" },
			-- Hoh...
			{ Cue = "/VO/Minotaur_0166" },
			-- Grrr.
			{ Cue = "/VO/Minotaur_0167" },
			-- Impressive.
			{ Cue = "/VO/Minotaur_0168" },
			-- How...
			{ Cue = "/VO/Minotaur_0169" },
			-- Hrrn.
			{ Cue = "/VO/Minotaur_0170" },
			-- This again.
			{ Cue = "/VO/Minotaur_0171" },
			-- This again?
			{ Cue = "/VO/Minotaur_0172" },
			-- Fight me yourself.
			{ Cue = "/VO/Minotaur_0173" },
			-- Just like the king.
			{ Cue = "/VO/Minotaur_0174" },
			-- The gods are fickle...
			{ Cue = "/VO/Minotaur_0175" },
			-- The gods' favor...
			{ Cue = "/VO/Minotaur_0176" },
		},
		CauseOfDeathVoiceLines =
		{
			--[[
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 2,
				},
				-- About damn time I finally got you, Zag.
				-- { Cue = "/VO/MegaeraField_0143", RequiredTextLines = { "MegaeraGift03" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.75,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 2,
				},
			},
			]]--
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.75,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				Source = { SubtitleColor = Color.MinotaurVoice },

				-- A noble attempt.
				{ Cue = "/VO/Minotaur_0210" },
				-- Just what I needed.
				{ Cue = "/VO/Minotaur_0211" },
				-- Another challenger destroyed.
				{ Cue = "/VO/Minotaur_0212" },
				-- Destruction.
				{ Cue = "/VO/Minotaur_0213" },
				-- Slaughtered.
				{ Cue = "/VO/Minotaur_0214" },
				-- <Snort> A decent fight.
				{ Cue = "/VO/Minotaur_0215" },
				-- The Champion and I will reign forever.
				{ Cue = "/VO/Minotaur_0216" },
				-- You are broken.
				{ Cue = "/VO/Minotaur_0217" },
				-- May this defeat fill you with vengeful fury.
				{ Cue = "/VO/Minotaur_0218" },
				-- I will be waiting for you to return.
				{ Cue = "/VO/Minotaur_0219" },
				-- All challengers are worthy.
				{ Cue = "/VO/Minotaur_0220" },
				-- It will take you more than that to vanquish me.
				{ Cue = "/VO/Minotaur_0221" },
				-- This is the fate of those who challenge me.
				{ Cue = "/VO/Minotaur_0222" },
				-- Return to the bowels of hell, short one.
				{ Cue = "/VO/Minotaur_0223" },
				-- <Snort> <Laughter>
				{ Cue = "/VO/Minotaur_0224" },
				-- <Snort> <Laughter>
				{ Cue = "/VO/Minotaur_0225" },
				-- <Snort> <Laughter>
				{ Cue = "/VO/Minotaur_0226" },
			},
		},

		OnKillVoiceLines =
		{
			[1] = GlobalVoiceLines.BarelySurvivedBossFightVoiceLines,
			[2] =
			{
				RequiredUnitsNotAlive = { "Theseus", "Theseus2" },
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 6.5,
				RequiredFalseRooms = { "C_MiniBoss01" },

				-- That'll show them.
				{ Cue = "/VO/ZagreusField_1800" },
				-- Thank you, thank you.
				{ Cue = "/VO/ZagreusField_1801" },
				-- Can I get some applause or something here?
				{ Cue = "/VO/ZagreusField_1802" },
				-- Hope you enjoyed the show out in the stands!
				{ Cue = "/VO/ZagreusField_1803" },
				-- That's all for today's show!
				{ Cue = "/VO/ZagreusField_1804" },
				-- Please, hold your applause!
				{ Cue = "/VO/ZagreusField_1805", PreLineWait = 6.8 },
				-- I guess I win this round.
				{ Cue = "/VO/ZagreusField_1806" },
			},
			[3] = GlobalVoiceLines.ChaosReactionVoiceLines,
		},

		-- RageFullSound = "/SFX/Enemy Sounds/Minotaur/EmotePoweringUp",
		RageFullVoiceLines =
		{
			--[[
			{
				RandomRemaining = true,
				PreLineWait = 0.6,

				-- King...!
				{ Cue = "/VO/Minotaur_0242" },
			},
			]]--
		},

		OnCharmedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.4,
			CooldownTime = 120,
			CooldownName = "MinotaurSpokeRecently",
			SuccessiveChanceToPlay = 0.33,

			-- Nrgh...
			{ Cue = "/VO/Minotaur_0271" },
			-- King, you...
			{ Cue = "/VO/Minotaur_0272", RequiredAnyUnitAlive = { "Theseus", "Theseus2" }, },
			-- I... hate...
			{ Cue = "/VO/Minotaur_0273" },
			-- What, I...
			{ Cue = "/VO/Minotaur_0274" },
			-- Rngh.
			{ Cue = "/VO/Minotaur_0275" },
			-- King...!
			{ Cue = "/VO/Minotaur_0276", RequiredAnyUnitAlive = { "Theseus", "Theseus2" }, },
			-- Mrngh?
			{ Cue = "/VO/Minotaur_0277" },
			-- Head, ungh...
			{ Cue = "/VO/Minotaur_0278" },
		},

		-- InvulnerableHitSound = "/SFX/Enemy Sounds/Minotaur/EmoteChuckle",
		InvulnerableVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			CooldownTime = 100,
			CooldownName = "MinotaurSpokeRecently",
			PreLineWait = 0.2,

			-- Useless.
			{ Cue = "/VO/Minotaur_0202", },
			-- No.
			{ Cue = "/VO/Minotaur_0203", },
			-- <Snort>
			{ Cue = "/VO/Minotaur_0204", },
			-- Not even a scratch.
			{ Cue = "/VO/Minotaur_0205", },
			-- Weak.
			{ Cue = "/VO/Minotaur_0206", },
			-- Really.
			{ Cue = "/VO/Minotaur_0207", },
			-- Huh.
			{ Cue = "/VO/Minotaur_0208", },
			-- I think not.
			{ Cue = "/VO/Minotaur_0209", },
		},
		LowHealthVoiceLineThreshold = 0.6,
		LowHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			CooldownName = "MinotaurSpokeRecently",
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.01,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- You're quick.
			{ Cue = "/VO/Minotaur_0190", },
			-- Interesting.
			{ Cue = "/VO/Minotaur_0191", },
			-- Good.
			{ Cue = "/VO/Minotaur_0192", },
			-- So.
			{ Cue = "/VO/Minotaur_0201", },
			-- Grr.
			{ Cue = "/VO/Minotaur_0189", },
			-- You.
			{ Cue = "/VO/Minotaur_0196", },
		},
		CriticalHealthVoiceLineThreshold = 0.3,
		CriticalHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			CooldownName = "MinotaurSpokeRecently",
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.01,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- Tsch.
			{ Cue = "/VO/Minotaur_0193", },
			-- <Snort>
			{ Cue = "/VO/Minotaur_0194", },
			-- Blast.
			{ Cue = "/VO/Minotaur_0195", },
			-- Well.
			{ Cue = "/VO/Minotaur_0197", },
			-- Huh.
			{ Cue = "/VO/Minotaur_0198", },
			-- What.
			{ Cue = "/VO/Minotaur_0199", },
			-- How.
			{ Cue = "/VO/Minotaur_0200", },
		},
		EarlyExitVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			Queue = "Interrupt",

			-- Ungh. Enough!
			{ Cue = "/VO/Minotaur_0081" },
			-- Urgh. Enough.
			{ Cue = "/VO/Minotaur_0082" },
			-- Guh. Enough...
			{ Cue = "/VO/Minotaur_0083" },
			-- Uff. Enough, short one.
			{ Cue = "/VO/Minotaur_0084" },
			-- Hrrn. Stand down!
			{ Cue = "/VO/Minotaur_0085" },
			-- Hng. Cease fire!
			{ Cue = "/VO/Minotaur_0086", RequiredWeapon = { "GunWeapon" } },
			-- Urnh. Stop!
			{ Cue = "/VO/Minotaur_0087" },
			-- Khh. I yield.
			{ Cue = "/VO/Minotaur_0088" },
			-- Augh. Well done!
			{ Cue = "/VO/Minotaur_0089" },
			-- Unff. Well done.
			{ Cue = "/VO/Minotaur_0090" },
			-- Guh. Enough! Well fought.
			{ Cue = "/VO/Minotaur_0091", RequiredTextLines = { "MinotaurOutro02", "MinotaurOutro03", "MinotaurOutro04", "MinotaurOutro05", } },
			-- Ungh. Enough. You win.
			{ Cue = "/VO/Minotaur_0092", RequiredTextLines = { "MinotaurOutro02", "MinotaurOutro03", "MinotaurOutro04", "MinotaurOutro05", } },
			-- Urgh. Enough... I yield.
			{ Cue = "/VO/Minotaur_0093", RequiredTextLines = { "MinotaurOutro02", "MinotaurOutro03", "MinotaurOutro04", "MinotaurOutro05", } },
			-- Hrrn. Enough, short one.
			{ Cue = "/VO/Minotaur_0094", RequiredTextLines = { "MinotaurOutro02", "MinotaurOutro03", "MinotaurOutro04", "MinotaurOutro05", } },
			-- Hng. Stand down! I concede.
			{ Cue = "/VO/Minotaur_0095", RequiredTextLines = { "MinotaurOutro02", "MinotaurOutro03", "MinotaurOutro04", "MinotaurOutro05", } },
			-- Urnh. Cease fire! I yield.
			{ Cue = "/VO/Minotaur_0096", RequiredTextLines = { "MinotaurOutro02", "MinotaurOutro03", "MinotaurOutro04", "MinotaurOutro05", }, RequiredWeapon = "GunWeapon" },
			-- Khh. Stop! I yield.
			{ Cue = "/VO/Minotaur_0097", RequiredTextLines = { "MinotaurOutro02", "MinotaurOutro03", "MinotaurOutro04", "MinotaurOutro05", } },
			-- Rngh. Well done! I yield.
			{ Cue = "/VO/Minotaur_0098", RequiredTextLines = { "MinotaurOutro02", "MinotaurOutro03", "MinotaurOutro04", "MinotaurOutro05", } },
		},
		PostMatchTauntVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.3,

			-- <Snort>
			{ Cue = "/VO/Minotaur_0182" },
			-- Hrr. <Snort>
			{ Cue = "/VO/Minotaur_0183" },
			-- <Snort>
			{ Cue = "/VO/Minotaur_0204", },
		},
		DeathVoiceLines =
		{
			{
				RandomRemaining = true,
				Queue = "Interrupt",
				SkipAnim = true,

				-- I... fall...
				{ Cue = "/VO/Minotaur_0227", RequiredPlayed = { "/VO/Minotaur_0229" } },
				-- Defeated...
				{ Cue = "/VO/Minotaur_0228", RequiredPlayed = { "/VO/Minotaur_0229" } },
				-- Urrh, unnghhh.
				{ Cue = "/VO/Minotaur_0229" },
				-- Nn, noooo.
				{ Cue = "/VO/Minotaur_0230", RequiredPlayed = { "/VO/Minotaur_0229" } },
				-- Hh, how...
				{ Cue = "/VO/Minotaur_0231", RequiredPlayed = { "/VO/Minotaur_0229" } },
				-- Well... done...
				{ Cue = "/VO/Minotaur_0232", RequiredPlayed = { "/VO/Minotaur_0229" } },
				-- You're... strong...
				{ Cue = "/VO/Minotaur_0233", RequiredPlayed = { "/VO/Minotaur_0229" } },
				-- King, I...
				{ Cue = "/VO/Minotaur_0234", RequiredPlayed = { "/VO/Minotaur_0229" } },
				-- Ugh, can't...
				-- { Cue = "/VO/Minotaur_0235" },
				-- Hah, hahaha...
				{ Cue = "/VO/Minotaur_0236", RequiredPlayed = { "/VO/Minotaur_0229" } },
				-- Thank... you...
				{ Cue = "/VO/Minotaur_0237", RequiredPlayed = { "/VO/Minotaur_0229" } },
				-- Good... fight...
				{ Cue = "/VO/Minotaur_0238", RequiredPlayed = { "/VO/Minotaur_0229" } },
				-- Urgh, again...?
				{ Cue = "/VO/Minotaur_0239", RequiredPlayed = { "/VO/Minotaur_0229" } },
				-- You... got me...
				{ Cue = "/VO/Minotaur_0240", RequiredPlayed = { "/VO/Minotaur_0229" } },
				-- Blast... urgh...
				{ Cue = "/VO/Minotaur_0241", RequiredPlayed = { "/VO/Minotaur_0229" } },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.1,
				ObjectType = "Theseus",
				RequiredAnyUnitNotDead = { "Theseus", "Theseus2" },

				-- Asterius!!
				{ Cue = "/VO/Theseus_0226" },
				-- No, Asterius!
				{ Cue = "/VO/Theseus_0227" },
				-- Asterius, no!
				{ Cue = "/VO/Theseus_0228" },
				-- Bull, no!!
				{ Cue = "/VO/Theseus_0229" },
				-- You dispatched the Bull!
				{ Cue = "/VO/Theseus_0230" },
				-- You struck down the Bull!
				{ Cue = "/VO/Theseus_0231" },
				-- That was my friend, you bastard!
				{ Cue = "/VO/Theseus_0232" },
				-- That was my friend!
				{ Cue = "/VO/Theseus_0233" },
				-- Blast, Asterius!
				{ Cue = "/VO/Theseus_0234" },
				-- The Bull, defeated?
				{ Cue = "/VO/Theseus_0235" },
				-- How could you?!
				{ Cue = "/VO/Theseus_0236" },
				-- Damn you, fiend!
				{ Cue = "/VO/Theseus_0237" },
				-- No!
				{ Cue = "/VO/Theseus_0238" },
				-- Gah!
				{ Cue = "/VO/Theseus_0239" },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.1,
				ObjectType = "Theseus2",
				RequiredAnyUnitNotDead = { "Theseus", "Theseus2" },

				-- Asterius!!
				{ Cue = "/VO/Theseus_0226" },
				-- No, Asterius!
				{ Cue = "/VO/Theseus_0227" },
				-- Asterius, no!
				{ Cue = "/VO/Theseus_0228" },
				-- Bull, no!!
				{ Cue = "/VO/Theseus_0229" },
				-- You dispatched the Bull!
				{ Cue = "/VO/Theseus_0230" },
				-- You struck down the Bull!
				{ Cue = "/VO/Theseus_0231" },
				-- That was my friend, you bastard!
				{ Cue = "/VO/Theseus_0232" },
				-- That was my friend!
				{ Cue = "/VO/Theseus_0233" },
				-- Blast, Asterius!
				{ Cue = "/VO/Theseus_0234" },
				-- The Bull, defeated?
				{ Cue = "/VO/Theseus_0235" },
				-- How could you?!
				{ Cue = "/VO/Theseus_0236" },
				-- Damn you, fiend!
				{ Cue = "/VO/Theseus_0237" },
				-- No!
				{ Cue = "/VO/Theseus_0238" },
				-- Gah!
				{ Cue = "/VO/Theseus_0239" },
			},
			
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlay = 0.5,
					UsePlayerSource = true,
					RequiredAnyUnitNotDead = { "Theseus", "Theseus2" },
					RequiredKillEnemiesFound = true,

					-- You're next, king!
					{ Cue = "/VO/ZagreusField_1781" },
					-- You and me, king!
					{ Cue = "/VO/ZagreusField_1782" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlay = 0.75,
					UsePlayerSource = true,
					RequiredAnyUnitNotDead = { "Theseus", "Theseus2" },
					RequiredKillEnemiesFound = true,

					-- One down, one to go.
					{ Cue = "/VO/ZagreusField_1778" },
					-- Now to deal with you!
					{ Cue = "/VO/ZagreusField_1783" },
					-- You're next!
					{ Cue = "/VO/ZagreusField_1784" },
					-- Now for the other one.
					{ Cue = "/VO/ZagreusField_1785" },
					-- You and me!
					{ Cue = "/VO/ZagreusField_1786" },
					-- You and me now!
					{ Cue = "/VO/ZagreusField_1787" },
				},
			}
			
		},
		MetaPointDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 4,
			MaxParcels = 4,
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		Groups = { "NPCs" },

		BossPresentationPriorityIntroTextLineSets =
		{
			MinotaurExtremeMeasures01 =
			{
				PlayOnce = true,
				PreEventWait = 1.0,
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				{ Cue = "/VO/Minotaur_0253",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Observe this gleaming coat of bronze with which I am adorned, now, short one. {#DialogueItalicFormat}<Snort> {#PreviousFormat}Your doing, as I'm to understand." },
				{ Cue = "/VO/ZagreusField_2897", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "My father is to thank for that, not me. I've proven difficult for him to contain, so now I'm beneficiary of his latest Pact of Punishment. You're welcome!" },
				{ Cue = "/VO/Minotaur_0254",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "I hadn't thanked you, as of yet. Though, come. I'll repay you suitably for having me encased within this... suit." },
			},
			MinotaurExtremeMeasures02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurExtremeMeasures01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				{ Cue = "/VO/Minotaur_0257",
					Text = "Tell me, short one, where is your own armored suit? I would prefer not to do battle against one who's ill equipped." },
				{ Cue = "/VO/ZagreusField_2899", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You know, my father keeps the dress code very strict down there in Tartarus. No armor in the House! Never tried the stuff." },
				{ Cue = "/VO/Minotaur_0258",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Dress code. {#DialogueItalicFormat}<Snort> {#PreviousFormat}I, too, follow a code. And it's a code that strictly states I cannot let you pass without a fight." },
			},
			MinotaurExtremeMeasuresWinStreak01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurExtremeMeasures01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 1,
				},
				{ Cue = "/VO/Minotaur_0255",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Even with this armor I was unable to best you one-to-one. Perhaps I lack as yet the necessary training to take full advantage of its benefit." },
				{ Cue = "/VO/ZagreusField_2898", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I don't suppose you have some good acquaintances with whom to train, until such time as you see fit to face me once again?" },
				{ Cue = "/VO/Minotaur_0256",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "No. {#DialogueItalicFormat}<Snort> {#PreviousFormat}King Theseus is occupied with preparations of his own. You are my good acquaintance now." },
			},
			MinotaurPactReverted01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurExtremeMeasures01" },
				RequiredRoomLastRun = "C_Intro",
				RequiredMaxActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 2 },
				{ Cue = "/VO/Minotaur_0263",
					Text = "I am returned once more to my more-earthly capability, short one. And I am able to move freely once again." },
				{ Cue = "/VO/ZagreusField_2900", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Fine change of pace, Asterius! Who needs that old, spectacular, custom-fitting suit of legendary armor, anyway?" },
				{ Cue = "/VO/Minotaur_0264",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "You mock me. Yet you know nothing of being trapped; enclosed in something and unable to break free. I need no armor to fight you." },
			},

			MinotaurAboutGilgameshAspect01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurRevealsGilgameshAspect01" },
				RequiredFalseTextLines = { "MinotaurAboutGilgameshAspect02" },
 				RequiredFalseTraits = { "FistDetonateTrait" },
 				RequiredFalsePlayed = { "/VO/ZagreusHome_3490" },
				{ Cue = "/VO/Minotaur_0291",
					Text = "You haven't spoken to your fist-weapons yet, have you, short one? {#DialogueItalicFormat}'I see you overcome the wild and make peace with death.' {#PreviousFormat}That's what you're supposed to tell them. I'm sure of it." },
				{ Cue = "/VO/ZagreusField_4265", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Just been a little tied up lately is all, but I will get to it, Asterius! I guess you'll want to know the result?" },
				{ Cue = "/VO/Minotaur_0292",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Yes. Here, I'll give you this chance to get home quickly, if you want to know, yourself." },
			},
			MinotaurAboutGilgameshAspect02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurRevealsGilgameshAspect01" },
				RequiredWeapon = "FistWeapon",
				RequiredTrait = "FistDetonateTrait",
				{ Cue = "/VO/Minotaur_0293",
					Text = "There, on your hands... the weapons you call Malphon. They're just as I saw in my dream. Monstrous. Like me." },
				{ Cue = "/VO/ZagreusField_4266", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Former property of someone called Gilgamesh. The beast-man he fought, Enkidu... you said they became friends? What said your dream about us on that front, sir?" },
				{ Cue = "/VO/Minotaur_0294",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "It didn't say much. Only that we would fight. Just as that Gilgamesh and Enkidu once did. Maybe the outcome will be the same, maybe it won't. We'll find out." },
			},
		},

		BossPresentationIntroTextLineSets =
		{
			MinotaurFirstAppearance_NotMetTheseus =
			{
				PlayOnce = true,
				RequiredFalseTextLines = { "TheseusFirstAppearance_MetBeatMinotaur", "TheseusFirstAppearance_MetNotBeatMinotaur", "TheseusFirstAppearance_NotMetMinotaur", "MinotaurFirstAppearance_MetTheseus" },
				{ Cue = "/VO/Minotaur_0002",
					Text = "You come from the bowels of hell. This is not your place." },
				{ Cue = "/VO/ZagreusField_1746", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Agreed on both counts! Just passing through, so if you'll excuse me..." },
				{ Cue = "/VO/Minotaur_0003",
					Text = "I will not. {#DialogueItalicFormat}<Snort> {#PreviousFormat}The Champion of Elysium would never back down from such a contest. Neither will I." },
				{ Cue = "/VO/ZagreusField_1747", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Wait, {#DialogueItalicFormat}you're {#PreviousFormat}not the Champion of Elysium...? You're the Bull of Minos! I can't imagine who's even stronger than you. Is it Heracles? Tell me it's Heracles." },
				{ Cue = "/VO/Minotaur_0004",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",	PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I will not. {#DialogueItalicFormat}<Snort> {#PreviousFormat}You talk too much, short one. Come get destroyed." },
			},
			MinotaurFirstAppearance_MetTheseus =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusFirstAppearance_MetBeatMinotaur", "TheseusFirstAppearance_MetNotBeatMinotaur", "TheseusFirstAppearance_NotMetMinotaur" },
				RequiredFalseTextLines = { "MinotaurFirstAppearance_NotMetTheseus" },
				{ Cue = "/VO/Minotaur_0002",
					Text = "You come from the bowels of hell. This is not your place." },
				{ Cue = "/VO/ZagreusField_1746", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Agreed on both counts! Just passing through, so if you'll excuse me..." },
				{ Cue = "/VO/Minotaur_0003",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "I will not. {#DialogueItalicFormat}<Snort> {#PreviousFormat}The Champion of Elysium would never back down from such a contest. Neither will I." },
			},
			MinotaurMetTheseus01 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "TheseusFirstAppearance_MetBeatMinotaur", "TheseusFirstAppearance_MetNotBeatMinotaur", "TheseusFirstAppearance_NotMetMinotaur" },
				{ Cue = "/VO/Minotaur_0017",
					Text = "You have met the Champion, the king. Let us see if you are fit to face him once again." },
				{ Cue = "/VO/ZagreusField_1754", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You mean face both of you, together. Which doesn't seem particularly fair." },
				{ Cue = "/VO/Minotaur_0018",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Life isn't particularly fair, short one. Nor death. I'd have expected you to know as much. But here, have your fair fight." },
			},

			MinotaurMetTheseus02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "TheseusEncounter03" },
				{ Cue = "/VO/Minotaur_0019",
					Text = "Let us clash here again before you face the Champion. We never will allow you through without a fight." },
				{ Cue = "/VO/ZagreusField_1755", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You're nothing like Theseus. Why go along with everything he says and does? You're your own man. And bull." },
				{ Cue = "/VO/Minotaur_0020",
					Text = "King Theseus slew me in life, and saved me in death. I was cast into Erebus. A monster. He found me when he died. And used his influence to bring me here, with him." },
				{ Cue = "/VO/ZagreusField_1756", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "That's nice of him and all, but sounds like you're even to me. Seeing as he killed you in the first place." },
				{ Cue = "/VO/Minotaur_0021",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "No; we're not. And I will fight for him, and alongside him, for eternity. As recompense for helping me to understand exactly who I am." },
			},

			MinotaurDefeatedTheseus01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurMetTheseus01" },
				RequiredKills = { Theseus = 1 },
				RequiredKillsLastRun = { "Theseus" },
				{ Cue = "/VO/Minotaur_0015",
					Text = "You bested the Champion, himself. Which means that I have little hope of vanquishing you, here." },
				{ Cue = "/VO/ZagreusField_1753", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So then, why bother fighting me? You don't have to do this. That Theseus is a highly questionable influence on you!" },
				{ Cue = "/VO/Minotaur_0016",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "I see you plain, short one. I, too, was born of darkness. But, I chose the path of light. Even in death, it was not too late. {#DialogueItalicFormat}<Snort> {#PreviousFormat}Not even for a monster, such as I. I trust your deaths will likewise be enlightening." },
			},

			MinotaurPactHighHeatReaction01 =
			{
				PlayOnce = true,
				RequiredActiveShrinePointsMin = 25,
				RequiredAnyTextLines = { "TheseusFirstAppearance_MetBeatMinotaur", "TheseusFirstAppearance_MetNotBeatMinotaur", "TheseusFirstAppearance_NotMetMinotaur" },				
				{ Cue = "/VO/Minotaur_0310",
					Text = "This heat... it reminds me of when I was young. Living in darkness. Learning to fight. To kill." },
				{ Cue = "/VO/ZagreusField_4645", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "I suppose you're about to put that learning to practice in another moment here?" },
				{ Cue = "/VO/Minotaur_0311",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "I am. The heat fills me with strength. Let's see if it has any effect on you." },
			},

			MinotaurAutograph01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "HypnosConsolation31_B", "HypnosConsolation31_C", "HypnosConsolation32_B", "HypnosConsolation32_C" },
				-- Shall we get started then?
				EndCue = "/VO/ZagreusField_1759",
				EndWait = 0.6,
				{ Cue = "/VO/Minotaur_0024",
					Text = "{#DialogueItalicFormat}Ah{#PreviousFormat}. I sense another furious battle here awaits us, short one. Although you're more inquisitive than usual..." },
				{ Cue = "/VO/ZagreusField_1758", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "{#DialogueItalicFormat}Uhh{#PreviousFormat}, oh! It's just, I have an odd request. You see, the god of slumber, Hypnos? Colleague of mine. Huge fan. He's in desperate need of your autograph. Little personalized message? I don't suppose you'd be so kind. It'd mean a lot to him." },
				{ Cue = "/VO/Minotaur_0025",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Autograph. I see. Then, it appears there are such gods as favor me. I will inscribe a bit of parchment for your colleague, then." },
				{ Cue = "/VO/Storyteller_0229", IsNarration =  true, PreLineWait = 0.4,
					Text = "{#DialogueItalicFormat}The god-forsaken Minotaur impresses then upon a parchment a brief message to the god of sleep, and gives it to the favor-asking Prince." },
				{ Cue = "/VO/Minotaur_0026",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Know, short one, that this favor is for you and not for Hypnos. Though he may challenge me himself, at any time." },
			},

			MinotaurAboutFistWeapon01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurMetTheseus01" },
				RequiredWeapon = "FistWeapon",
				{ Cue = "/VO/Minotaur_0279",
					Text = "{#DialogueItalicFormat}Huh{#PreviousFormat}. You mean to fight with me bare-handed this time, short one? I'm not ashamed to say the Champion himself defeated me in such a manner back when we drew breath." },
				{ Cue = "/VO/ZagreusField_3437", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Wouldn't say the Twin Fists of Malphon counts as empty-handed, sir, though it surprises me to hear you could be beaten in such a way." },
				{ Cue = "/VO/Minotaur_0280",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",		
					Text = "I was hungry and unprepared. Inexperienced. No longer. Come." },
			},

			MinotaurAboutFriendship01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurEncounter01" },
				RequiredKills = { Theseus = 5, Minotaur = 5 },
				RequiredResourcesMin = { GiftPoints = 1, SuperGiftPoints = 1 },
				{ Cue = "/VO/Minotaur_0281",
					Text = "You must take pleasure in having to fight against me, short one. I, too, have come to look forward to it. Even if I end up falling to your strength." },
				{ Cue = "/VO/ZagreusField_3438", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, I was going to say, I'd much prefer we settle this more amicably, couldn't we? Perhaps I could interest you in a fine bottle of Nectar? Ambrosia, even?" },
				{ Cue = "/VO/Minotaur_0282",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "No, thank you. These battles are enough. Besides... you won that Ambrosia from us, fair and square." },
			},
			MinotaurAboutFriendship02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurAboutFriendship01" },
				RequiredKills = { Minotaur = 8, Minotaur2 = 2 },
				{ Cue = "/VO/Minotaur_0305",
					Text = "Well, you're back, short one. Or Prince. Whatever they call you. I'm not much for formality." },
				{ Cue = "/VO/ZagreusField_4112", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Not much for it either, here, Asterius. Though, speaking of which, how would you prefer to be addressed? The Minotaur, the Bull of Minos? Those aren't offensive to you, are they?" },
				{ Cue = "/VO/Minotaur_0306",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "They don't mean anything to me. They mean something to others. I have my name. You know it. Use it if you want. Now, enough." },
			},

			MinotaurAboutSkelly01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "SkellyBackstory04", "HermesAboutSkinnyLittleChap01", "MinotaurEncounter01" },
				MinRunsSinceAnyTextLines = { TextLines = { "SkellyBackstory04" }, Count = 2 },
				RequiredKills = { Minotaur = 10 },
				{ Cue = "/VO/ZagreusField_4260", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Say, you're from Crete, originally, aren't you, Asterius? I know this is a stretch, but... I don't suppose you ever heard of a commander by the name of {#DialogueItalicFormat}Schelemeus{#PreviousFormat}? Captain of the Cretan second fleet, something like that?" },
				{ Cue = "/VO/Minotaur_0307",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "The king of Crete commanded the greatest navy in the world. Even I knew that, having never seen the light of day, the ships, the sea. {#DialogueItalicFormat}Schelemeus{#PreviousFormat}, huh...? I might have heard the name. So what?" },
				{ Cue = "/VO/ZagreusField_4261", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What, Schelemeus was a real person, then? But, Skelly said... ah, you know what, it's nothing, Asterius. Shall we?" },
				{ Cue = "/VO/Minotaur_0308",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Yes. Let's." },
			},

			MinotaurRevealsGilgameshAspect01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurAboutFistWeapon01", "AchillesRevealsGuanYuAspect01" },
				RequiredPlayed = { "/VO/ZagreusHome_2027" },
				RequiredMinSuperLockKeysSpentOnWeapon = { Name = "FistWeapon", Count = 5 },
				RequiredFalseTextLinesThisRun = GameData.LegendaryAspectIntroTextLines,
				RequiredFalseTextLinesLastRun = GameData.LegendaryAspectIntroTextLines,
				EndVoiceLines =
				{
					PreLineWait = 0.9,
					UsePlayerSource = true,
					-- I see you overcome the wild and make peace with death!
					{ Cue = "/VO/ZagreusField_4264" },
				},
				{ Cue = "/VO/Minotaur_0288",
					Text = "You've come, short one. I dreamed of this very moment." },
				{ Cue = "/VO/ZagreusField_4262", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Come on, Asterius, we've fought how many times already? What's there to dream about?" },
				{ Cue = "/VO/Minotaur_0289",
					Text = "No. I dreamed. And in my dream, there was something I had to tell you. Rather... something you have to tell the weapons you wear on your hands. Tell them, {#DialogueItalicFormat}'I see you overcome the wild and make peace with death.'{#PreviousFormat}" },
				{ Cue = "/VO/ZagreusField_4263", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
					Text = "Hey, I know what that is, that's a waking-phrase. So I'm to speak it to Malphon. Wait, why are you helping me?" },
				{ Cue = "/VO/Minotaur_0290",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I don't know whether I'm helping you or not. But in my dream... an ancient hero fought a beast of a man, barehanded. They became friends, in the end, after a great battle. I long for a fight like that." },
			},

			MinotaurClearProgress01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurEncounter01", "TheseusEncounter01", "PersephoneMeeting02" },
				RequiredMinRunsCleared = 2,
				{ Cue = "/VO/Minotaur_0303",
					Text = "I wonder something, short one. You keep coming back. But I don't know why. You're trying to get out of here, aren't you? But something's killing you up there." },
				{ Cue = "/VO/ZagreusField_4111", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You've deduced more or less correctly, Asterius. And yes, let's say there are some challenges remaining once I get out of Elysium. Though I'd best say no more of it than that." },
				{ Cue = "/VO/Minotaur_0304",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "That's fine. It's good to know you've fallen just as often as I have. I may not be the one to kill you. But I'll soften you up for whoever does." },
			},
			MinotaurClearProgress01_B =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurClearProgress01", "PersephoneMeeting04" },
				RequiredMinRunsCleared = 4,
				{ Cue = "/VO/Minotaur_0297",
					Text = "You ever make it out of here, short one? I wonder, sometimes, what it must be like... the outside." },
				{ Cue = "/VO/ZagreusField_4267", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You've never been outside? Oh, right... the labyrinth thing. You lived in a horrible maze all your life. I haven't seen much of the surface, but... it's beautiful. Cold. When I'm there, though, I... feel out of place." },
				{ Cue = "/VO/Minotaur_0298",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Out of place. I understand, I think. I don't see why you'd want to go somewhere like that. It can't live up to the stories. Why ruin it? Speaking of which..." },
			},
			MinotaurPostEpilogue01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "OlympianReunionQuestComplete" },
				{ Cue = "/VO/Minotaur_0299",
					Text = "Everyone's saying that the Queen is back. Do you know what that means, short one?" },
				{ Cue = "/VO/ZagreusField_4268", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well, for me, at least, it happens to mean quite a bit. I'm her son!" },
				{ Cue = "/VO/Minotaur_0300",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "It doesn't mean a thing. We're still here to fight. Though, for what it's worth... my mother also was a queen. May yours treat you better than she treated me. Better than I'm about to treat you, here." },
			},

			MinotaurLowHealth01 =
			{
				PlayOnce = true,
				RequiredMaxHealthFraction = 0.25,
				RequiredMaxLastStands = 0,
				RequiredTextLines = { "MinotaurEncounter01" },
				{ Cue = "/VO/Minotaur_0031",
					Text = "I smell the blood on you, short one. {#DialogueItalicFormat}<Snort> {#PreviousFormat}You are severely wounded. This will not be a fair fight." },
				{ Cue = "/VO/ZagreusField_1762", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "An unfair fight is not worth having, then, wouldn't you say?" },
				{ Cue = "/VO/Minotaur_0032",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "I would not. An unfair fight is better than no fight at all." },
			},
			MinotaurLowHealth02 =
			{
				PlayOnce = true,
				RequiredMaxHealthFraction = 0.25,
				RequiredMaxLastStands = 0,
				RequiredTextLines = { "MinotaurEncounter01" },
				{ Cue = "/VO/Minotaur_0266",
					Text = "You're hardly in a state to fight against me, here. Won't take too long to bring you death." },
				{ Cue = "/VO/ZagreusField_2901", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Great! Thanks for the encouragement, Asterius. Don't let me keep you waiting on that, then." },
				{ Cue = "/VO/Minotaur_0267",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "If mere words can sap your will for battle, short one, then know this: You never stood a chance." },
			},
			MinotaurLowHealth03 =
			{
				PlayOnce = true,
				RequiredMaxHealthFraction = 0.25,
				RequiredMaxLastStands = 0,
				RequiredTextLines = { "MinotaurEncounter01" },
				{ Cue = "/VO/Minotaur_0268",
					Text = "You look as though you withstood many foes in getting here this time. Barely withstood, that is." },
				{ Cue = "/VO/ZagreusField_2902", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "They took a lot out of me, yes. But you have no idea just how long and arduous a trip it is from Tartarus to here! " },
				{ Cue = "/VO/Minotaur_0269",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "What would you know of arduous? Try living in an ever-shifting maze of countless passageways. Now let me finish what your foes began." },
			},
		},

		BossPresentationTextLineSets =
		{
			MinotaurEncounter01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Minotaur_0005",
					Text = "We meet again, short one. For further battle." },
				{ Cue = "/VO/ZagreusField_1748", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#DialogueItalicFormat}Short one{#PreviousFormat}?! That's a low blow, sir. I thought you were the big-honorable type." },
				{ Cue = "/VO/Minotaur_0006",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "You mock my sense of honor. {#DialogueItalicFormat}<Snort> {#PreviousFormat}Common tactic. Now prepare." },
			},
			MinotaurEncounter02 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "MinotaurEncounter01" },
				{ Cue = "/VO/Minotaur_0009",
					Text = "You choose to challenge me again. Not many in Elysium so dare. Then, I accept." },
				{ Cue = "/VO/ZagreusField_1750", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Wait, I never challenged you! The entrance to your chamber looks like any other pathway in Elysium. I have no quarrel with you, sir!" },
				{ Cue = "/VO/Minotaur_0010",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "To step into my chamber is to challenge me. {#DialogueItalicFormat}<Snort> {#PreviousFormat}It is a custom since the time I lived and breathed in darkness. I will send you into such a darkness now." },
			},
			MinotaurEncounter03 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "MinotaurEncounter02" },
				{ Cue = "/VO/Minotaur_0007",
					Text = "My next opponent has arrived in short order." },
				{ Cue = "/VO/ZagreusField_1749", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Short order? That was another jab about my height, wasn't it!" },
				{ Cue = "/VO/Minotaur_0008",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "I do not jab. {#DialogueItalicFormat}<Snort> {#PreviousFormat}All of my strength goes into every strike. Observe." },
			},
			MinotaurEncounter04 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "MinotaurEncounter03" },
				{ Cue = "/VO/Minotaur_0011",
					Text = "You have returned to my chamber. I trust you are familiar now with what this means." },
				{ Cue = "/VO/ZagreusField_1751", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It means I've challenged you to a battle of strength and glory, because apparently that's all there is to do for fun around here for those such as yourself?" },
				{ Cue = "/VO/Minotaur_0012",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "That... {#DialogueItalicFormat}<Snort> {#PreviousFormat}Yes. Essentially that is correct. Prepare." },
			},
			MinotaurEncounter05 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "MinotaurEncounter04" },
				{ Cue = "/VO/Minotaur_0013",
					Text = "It would seem {#DialogueItalicFormat}<Snort> {#PreviousFormat}that the time for additional {#DialogueItalicFormat}fun {#PreviousFormat}has arrived." },
				{ Cue = "/VO/ZagreusField_1752", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Ah, yes, my favorite pastime: Getting butchered by a giant double-bladed axe. And sometimes trampled." },
				{ Cue = "/VO/Minotaur_0014",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Then, good. You have much to enjoy in store." },
			},
			MinotaurEncounter06 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "MinotaurEncounter05", "MinotaurMetTheseus02" },
				{ Cue = "/VO/Minotaur_0022",
					Text = "Well, short one. It seems I must attempt to maim you here, so that the king and I might finally stop you at the gates." },
				{ Cue = "/VO/ZagreusField_1757", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You know, you hurt me with this '{#DialogueItalicFormat}short one{#PreviousFormat}' business almost as much as with that axe. Why isn't Theseus '{#DialogueItalicFormat}short one{#PreviousFormat}'? We're the same height!" },
				{ Cue = "/VO/Minotaur_0023",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "No. The king is greater. He is the greatest king of Athens! What are you? A willful son of a fickle god. I am beneath your father's notice. And you are beneath the king's. Now fight me." },
			},

			-- minotaur win streak
			MinotaurWinStreak01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurEncounter01" },
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 1,
				},
				{ Cue = "/VO/Minotaur_0027",
					Text = "It is not often that my challengers return to face another slaughter at my hands." },
				{ Cue = "/VO/ZagreusField_1760", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Yeah, well. You're kind of in my way. What choice do I have?" },
				{ Cue = "/VO/Minotaur_0028",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					Text = "Your choices led you here, and they will lead you to defeat, again." },
			},

			-- minotaur lose streak
			MinotaurLoseStreak01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurEncounter01" },
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 2,
				},
				{ Cue = "/VO/Minotaur_0029",
					Text = "You are more skilled than I expected, short one. A re-match is most certainly in order." },
				{ Cue = "/VO/ZagreusField_1761", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You're going to force a rematch each time I manage to defeat you, aren't you?" },
				{ Cue = "/VO/Minotaur_0030",
					PreLineWait = 0.35,
					PreLineFunctionName = "StartBossRoomMusic",
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "We and our victories are all impermanent here in Elysium. We live, such as it is, for moments such as these." },
			},
		},

		-- following are short misc repeatable evergreen combat start lines
		BossPresentationRepeatableTextLineSets =
		{
			-- other general cases
			MinotaurMiscStart01 =
			{
				{ Cue = "/VO/Minotaur_0033",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Your challenge is hereby accepted, short one." },
			},
			MinotaurMiscStart02 =
			{
				{ Cue = "/VO/Minotaur_0034",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Another challenger. {#DialogueItalicFormat}<Snort> {#PreviousFormat}Come get destroyed." },
			},
			MinotaurMiscStart03 =
			{
				{ Cue = "/VO/Minotaur_0035",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "I accept all challengers. No prior notice necessary." },
			},
			MinotaurMiscStart04 =
			{
				{ Cue = "/VO/Minotaur_0036",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "You have returned. {#DialogueItalicFormat}<Snort> {#PreviousFormat}I'm always ready to oppose you." },
			},
			MinotaurMiscStart05 =
			{
				{ Cue = "/VO/Minotaur_0037",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "You enter my chamber once again, short one. Then, good." },
			},
			MinotaurMiscStart06 =
			{
				{ Cue = "/VO/Minotaur_0038",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "I expected you to reappear. {#DialogueItalicFormat}<Snort> {#PreviousFormat}Let us fight." },
			},
			MinotaurMiscStart07 =
			{
				{ Cue = "/VO/Minotaur_0039",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "Appears it's time we challenged one another once again. Prepare." },
			},
			MinotaurMiscStart08 =
			{
				{ Cue = "/VO/Minotaur_0040",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "Good. {#DialogueItalicFormat}<Snort> {#PreviousFormat}It feels as though I haven't crushed the life from anything in ages." },
			},
			MinotaurMiscStart09 =
			{
				{ Cue = "/VO/Minotaur_0041",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "Returned to battle me for glory, short one? {#DialogueItalicFormat}<Snort> {#PreviousFormat}Excellent." },
			},
			MinotaurMiscStart10 =
			{
				{ Cue = "/VO/Minotaur_0042",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Come fight me again, short one. We have eternity to grow stronger." },
			},
			MinotaurMiscStart11 =
			{
				{ Cue = "/VO/Minotaur_0043",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "Thank you, short one. {#DialogueItalicFormat}<Snort> {#PreviousFormat}Few in Elysium dare challenge me repeatedly." },
			},
			MinotaurMiscStart12 =
			{
				{ Cue = "/VO/Minotaur_0044",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "The short one from the bowels of hell has finally returned." },
			},
			MinotaurMiscStart13 =
			{
				{ Cue = "/VO/Minotaur_0045",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "I heard you had again entered Elysium. {#DialogueItalicFormat}<Snort> {#PreviousFormat}At last." },
			},
			MinotaurMiscStart14 =
			{
				{ Cue = "/VO/Minotaur_0046",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Hold nothing back against me, short one. Now, come." },
			},
			MinotaurMiscStart15 =
			{
				{ Cue = "/VO/Minotaur_0047",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Let us grow stronger in the ways of battle, short one." },
			},
			MinotaurMiscStart16 =
			{
				{ Cue = "/VO/Minotaur_0048",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "I always am prepared to fight whoever dares oppose me." },
			},
			MinotaurMiscStart17 =
			{
				{ Cue = "/VO/Minotaur_0049",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Let us battle now before you face the Champion, himself." },
			},
			MinotaurMiscStart19 =
			{
				{ Cue = "/VO/Minotaur_0050",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "You seek the Champion. You must confront me, first." },
			},
			MinotaurMiscStart20 =
			{
				{ Cue = "/VO/Minotaur_0051",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "Hrmm. {#DialogueItalicFormat}<Snort> {#PreviousFormat}It has been long enough since my last fight." },
			},

			MinotaurMiscStart21 =
			{
				{ Cue = "/VO/Minotaur_0315",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "I've been waiting for another round against you. Let's go. Now." },
			},
			MinotaurMiscStart22 =
			{
				{ Cue = "/VO/Minotaur_0316",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "They said you were headed this way. {#DialogueItalicFormat}<Snort> {#PreviousFormat}I said I'd stop you. Though, we'll see." },
			},
			MinotaurMiscStart23 =
			{
				{ Cue = "/VO/Minotaur_0317",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "Each time we fight... I think I learn a little more. Let's start." },
			},
			MinotaurMiscStart24 =
			{
				{ Cue = "/VO/Minotaur_0318",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "I had a feeling you would cross my path again. I've been looking forward to this." },
			},
			MinotaurMiscStart25 =
			{
				{ Cue = "/VO/Minotaur_0319",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "I'm going to run you down, or run you through. Your choice, short one." },
			},
			MinotaurMiscStart26 =
			{
				{ Cue = "/VO/Minotaur_0321",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "Told the king I'd try to stop you on the way. He thought I'd have no trouble. {#DialogueItalicFormat}<Snort> {#PreviousFormat}We'll see." },
			},
			MinotaurMiscStart27 =
			{
				{ Cue = "/VO/Minotaur_0322",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Come on, short one. I've been waiting too long for this." },
			},
			MinotaurMiscStart28 =
			{
				{ Cue = "/VO/Minotaur_0324",
					RequiredKills = { Minotaur = 10 },					
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "You know what it takes to leave this chamber alive, short one. {#DialogueItalicFormat}<Snort> {#PreviousFormat}Come on and fight." },
			},

			-- extreme measures
			MinotaurMiscStartExtremeMeasures01 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				{ Cue = "/VO/Minotaur_0312",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "I have my armor, short one. Let's see what you have." },
			},
			MinotaurMiscStartExtremeMeasures02 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				{ Cue = "/VO/Minotaur_0313",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Let's see if you can cut through my coat this time." },
			},
			MinotaurMiscStartExtremeMeasures03 =
			{
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				{ Cue = "/VO/Minotaur_0314",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "This armor's heavy. But makes me even faster than before. {#DialogueItalicFormat}<Snort> {#PreviousFormat}Watch." },
			},

			-- win streak
			MinotaurMiscStartWinStreak01 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 1,
				},
				{ Cue = "/VO/Minotaur_0052",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "You are resilient, short one, I will give you that." },
			},
			MinotaurMiscStartWinStreak02 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 1,
				},
				{ Cue = "/VO/Minotaur_0053",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "I'm prepared to slaughter you again, short one. Come fight." },
			},
			MinotaurMiscStartWinStreak03 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 1,
				},
				{ Cue = "/VO/Minotaur_0054",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "Interesting. {#DialogueItalicFormat}<Snort> {#PreviousFormat}Most never challenge me again once I destroy them." },
			},
			MinotaurMiscStartWinStreak04 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 1,
				},
				{ Cue = "/VO/Minotaur_0055",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "What hope have you against the Champion, if you can't get through me?" },
			},
			MinotaurMiscStartWinStreak05 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 1,
				},
				{ Cue = "/VO/Minotaur_0056",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "You have tenacity, short one. I have to give you that." },
			},
			MinotaurMiscStartWinStreak06 =
			{
				ConsecutiveDeathsInRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 1,
				},
				{ Cue = "/VO/Minotaur_0057",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "You do not take all your defeats to heart, do you? That's good." },
			},

			-- lose streak
			MinotaurMiscStartLoseStreak01 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 2,
				},
				{ Cue = "/VO/Minotaur_0058",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "You're quick, short one. Let's see if you can get past me again." },
			},
			MinotaurMiscStartLoseStreak02 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 2,
				},
				{ Cue = "/VO/Minotaur_0059",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Well, short one. I'm curious to see if you can best me once again." },
			},
			MinotaurMiscStartLoseStreak03 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 2,
				},
				{ Cue = "/VO/Minotaur_0060",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "A worthy challenger returns. Let's see you defeat me again." },
			},
			MinotaurMiscStartLoseStreak04 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 2,
				},
				{ Cue = "/VO/Minotaur_0061",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Glory and honor to you if you can vanquish me again. Come!" },
			},
			MinotaurMiscStartLoseStreak05 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 2,
				},
				{ Cue = "/VO/Minotaur_0062",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "I welcome the taste of defeat, short one. It is akin to feeling alive." },
			},
			MinotaurMiscStartLoseStreak06 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 2,
				},
				{ Cue = "/VO/Minotaur_0063",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "I'm still learning all your tricks, short one. Come show me more." },
			},
			MinotaurMiscStartLoseStreak07 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 2,
				},
				{ Cue = "/VO/Minotaur_0064",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayPreLineTauntAnimFromSource",
					Text = "Let's see you get through me again, short one." },
			},
			MinotaurMiscStartLoseStreak08 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 2,
				},
				{ Cue = "/VO/Minotaur_0065",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "I'm the one to challenge {#DialogueItalicFormat}you {#PreviousFormat}this time, short one." },
			},
			MinotaurMiscStartLoseStreak09 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 2,
				},
				{ Cue = "/VO/Minotaur_0066",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "I have looked forward to repaying you in kind for our last fight." },
			},
			MinotaurMiscStartLoseStreak10 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 2,
				},
				{ Cue = "/VO/Minotaur_0067",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "You're strong, short one. But I am just as obstinate as you." },
			},
			MinotaurMiscStartLoseStreak11 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 1,
				},
				{ Cue = "/VO/Minotaur_0320",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "The Champion awaits, short one. If you can get through me again, that is." },
			},
			MinotaurMiscStartLoseStreak12 =
			{
				ConsecutiveClearsOfRoom =
				{
				  Name = "C_MiniBoss01",
				  Count = 1,
				},
				{ Cue = "/VO/Minotaur_0323",
					PreLineFunctionName = "StartBossRoomMusic", PreLineWait = 0.35,
					Text = "Good. Now I can get you back for last time. All I need is one clean hit." },
			},			
		},

		-- following are for when he exits the miniboss encounter
		BossPresentationOutroTextLineSets =
		{
			MinotaurOutro01 =
			{
				Priority = true,
				PlayOnce = true,
				RequiredFalseTextLines = { "TheseusFirstAppearance_NotMetMinotaur", "TheseusFirstAppearance_MetBeatMinotaur", "TheseusFirstAppearance_MetNotBeatMinotaur" },
				{ Cue = "/VO/Minotaur_0099",
					Text = "Well fought. Though, your technique pales in comparison to that of the Champion of Elysium. I expect you'll soon see for yourself." },
			},
			MinotaurOutro02 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Minotaur_0100",
					Text = "I respect your strength, short one. The Champion of Elysium awaits. Until such time." },
			},
			MinotaurOutro03 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurOutro05" },
				{ Cue = "/VO/Minotaur_0101",
					Text = "You were a worthy challenger. Most welcome here. Until we meet again." },
			},
			MinotaurOutro04 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Minotaur_0102",
				RequiredTextLines = { "MinotaurOutro02" },
					Text = "You have earned your passage. I go now to recover for the next occasion that we meet." },
			},
			MinotaurOutro05 =
			{
				PlayOnce = true,
				RequiredTextLines = { "MinotaurOutro04" },
				{ Cue = "/VO/Minotaur_0103",
					Text = "Thank you for sparring with me, short one. I'm glad we've made a habit of it thus." },
			},
			MinotaurGilgameshAspectOutro01 =
			{
				Priority = true,
				PlayOnce = true,
				RequiredTrait = "FistDetonateTrait",
				RequiredWeapon = "FistWeapon",
				RequiredTextLines = { "MinotaurRevealsGilgameshAspect01" },
				{ Cue = "/VO/Minotaur_0309",
					Text = "{#DialogueItalicFormat}Urgh{#PreviousFormat}... the might of Gilgamesh... I understand it now. But I won't make his friend's mistake. We'll fight again." },
			},
			MinotaurGilgameshAspectOutro02 =
			{
				Priority = true,
				PlayOnce = true,
				RequiredTrait = "FistDetonateTrait",
				RequiredWeapon = "FistWeapon",
				RequiredTextLines = { "MinotaurGilgameshAspectOutro01" },
				{ Cue = "/VO/Minotaur_0295",
					Text = "Such strength... the strength of Gilgamesh. Thank you for the battle, short one." },
			},

		},

		-- following are repeatable versions of the above
		BossPresentationOutroRepeatableTextLineSets =
		{
			--[[
			MinotaurMiscOutro01 =
			{
				{ Cue = "",
					Text = "Peaaaaace!" },
			},
			]]--
		},

		Binks =
		{
			"MinotaurIdle_Bink",
			"MinotaurBullRush_Bink",
			"MinotaurWalk_Bink",
			"MinotaurBullRushCharge_Bink",
			"MinotaurCrouchThrow_Bink",
			"MinotaurBullRushStrike_Bink",
			"MinotaurCrescentStrike_Bink",
			"MinotaurAttackLeap_Bink",
			"MinotaurWalkStop_Bink",
			"MinotaurAttackSwings_Bink",
			"MinotaurTaunt_Bink",
			"MinotaurDeathVFX_Bink",

		},
		OutgoingDamageModifiers =
		{
			{
				Name = "FriendImmunity",
				FriendMultiplier = 0,
				Multiplicative = true,
			},
		},
	},

	-- Armored Minotaur
	Minotaur2 =
	{
		InheritFrom = { "Minotaur", "BaseBossEnemy" },
		Portrait = "Portrait_Minotaur_Armored_01",
		TauntAnimation = "MinotaurArmored_Taunt",
		SpeechCooldownTime = 12,
		AnimOffsetZ = 240,

		GenusName = "Minotaur",

		MaxHealth = 16000,
		AISetupDelay = 1.5,
		StopBiomeTimerIfComboPartnerDead = true,

		Material = "MetalObstacle",

		EndThreadWaitsOnDeath = "TheseusMinotaurSpawns",
		EnrageOnDeath = "Theseus",
		EnrageOnDeathStartDelay = 1.0,
		EnragedPresentation = "MinotaurEnragedPresentation",
		ComboPartnerName = "Theseus2",
		Groups = { "GroundEnemies" },

		PreDamageIfEncounterCompleted = "MiniBossMinotaur",
		PreDamagePercent = 0.80,

		OnDeathFunctionName = "TheseusMinotaurKillPresentation",
		OnDeathFunctionArgs = { Message = "MinotaurDefeatedMessage", StartPanTime = 1.5, EndPanTime = 3.5, StartSound = "/SFX/Enemy Sounds/Minotaur/EmoteDying", EndAngle = 270, FlashRed = true, AddInterBiomeTimerBlock = true },

		Material = "Armored",
		HealthBarOffsetY = -275,
		--RepulseOnMeleeInvulnerableHit = 400,
		IgnoreInvincibubbleOnHit = true,
		DeathAnimation ="MinotaurArmoredDeathVFX",
		ClearChillOnDeath = true,
		DestroyDelay = 5.0,

		DeathSound = "/SFX/Enemy Sounds/Minotaur/EmoteDying",

		DefaultAIData =
		{
			DeepInheritance = true,
			ComboPartnerName = "Theseus2",
		},

		WeaponOptions =
		{
			"MinotaurArmored5AxeCombo1", "MinotaurArmoredLeapCombo1", "MinotaurArmoredBullRush", "MinotaurArmoredAxeSpin"
		},

		AIEndHealthThreshold = 0.5,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.5,
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "MinotaurArmored_Taunt",
				StartDelay = 1.75,
				PermanentlyEnrage = true,
				EquipWeapons = { "MinotaurArmoredAxeOverhead", "MinotaurArmoredBullRush2", "MinotaurArmoredCrescentCombo1" },
				UnequipWeapons = { "MinotaurArmoredBullRush" },
				AIData =
				{
					AIEndHealthThreshold = 0.20,
					ThresholdOverrideIfInRoom = { Room = "C_Boss01", Value = 0.0 },
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "MinotaurFinalStageTransition",
				TransitionAnimation = "MinotaurArmored_Taunt",
				StartDelay = 0.0,
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
		},

		MetaPointDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 4,
			MaxParcels = 4,
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		Groups = { "NPCs" },

		Binks =
		{
			"MinotaurArmoredIdle_Bink",
			"MinotaurArmoredBullRush_Bink",
			"MinotaurArmoredWalk_Bink",
			"MinotaurArmoredBullRushCharge_Bink",
			--"MinotaurCrouchThrow_Bink",
			"MinotaurArmoredAttackAxeSpin_Bink",
			"MinotaurArmoredBullRushStrike_Bink",
			"MinotaurArmoredCrescentStrike_Bink",
			"MinotaurArmoredAttackLeap_Bink",
			"MinotaurArmoredWalkStop_Bink",
			"MinotaurArmoredAttackSwings_Bink",
			"MinotaurArmoredTaunt_Bink",
			"MinotaurArmoredDeathVFX_Bink",

		},
	},

	CerberusAssistUnit =
	{
		InheritFrom = { "IsNeutral" },
		DamageType = "Enemy",
		RequiredKill = false,
		HideHealthBar = true,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		AIOptions =
		{
			CerberusAssistAI,
		},
	},

	-- Hades / Lord Hades / -- Lord Hades / -- God of the Dead
	Hades =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		HealthBarTextId = "Hades_Full",
		AnimOffsetZ = 300,
		SpawnAnimation = "HadesBattleIntroIdle",
		AttachedAnimationName = "LaurelCindersSpawnerHades",

		ShrineMetaUpgradeName = "BossDifficultyShrineUpgrade",
		ShrineMetaUpgradeRequiredLevel = 4,
		ShrineDataOverwrites = {
			Phases = 3,
			MaxHealth = 22000,
		},

		-- ending
		ActivateRequirements =
		{
			RequiredFalseFlags = { "HadesEndingFlag" },
		},

		AISetupDelay = 6.0,
		MaxHealth = 17000,
		Phases = 2,
		Phase2VFX = "HadesFlameAura",

		Portrait = "Portrait_Hades_HelmCape_01",
		Groups = { "GroundEnemies" },

		Material = "Organic",
		HealthBarOffsetY = -275,
		RepulseOnMeleeInvulnerableHit = 400,
		IgnoreInvincibubbleOnHit = true,
		DeathAnimation = "HadesDeathFullscreen",
		ClearChillOnDeath = true,
		ManualDeathAnimation = true,
		DestroyDelay = 1.0,
		StopAnimationsOnDeath =
		{
			"HadesUrnConsumeFx_Self",
			"HadesUrnConsumeParticles_Self",
			"HadesUrnConsumeFxDark_Self",
			"HadesUrnConsumeFxDark2_Self",
			"HadesUrnConsumeGlow_Self",
			"HadesHeal",
		},

		EnragedWaitMultiplier = 0.8,

		EndThreadWaitsOnDeath = "HadesSpawns",

		InvisibilityEndSound = "/SFX/Enemy Sounds/Hades/HadesReappear",
		CharmStartSound = "/SFX/Enemy Sounds/Hades/EmoteLaugh",

		SpeechCooldownTime = 10,

		SkipSetupSelectWeapon = true,

		--InvisibilityOnHitFx = "QuickFlashRed",
		--InvisibilityAlphaFlashOnHit = true,

		OutgoingDamageModifiers =
		{
			HadesStoredAmmoVulnerability =
			{
				StoredAmmoMultiplier = 2.0,
			},
		},

		DefaultAIData =
		{
			PreAttackEndFunctionName = "EnemyHandleInvisibleAttack",
			PreAttackEndFunctionArgs = { Animation = "HadesReappear" },
			InvisibilityFadeOutDuration = 1.0,
			InvisibilityFadeInDuration = 0.3,
			PostTeleportWaitDurationMin = 1.0,
			PostTeleportWaitDurationMax = 2.0,
			PostInvisibilityFunction = "HadesTeleport",

			DashWeapon = "HadesDash",
			PreAttackDash = "HadesSideDash",
			DashIfOverDistance = 500,
		},

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		Phase2ActivateGroups = { "Lighting_Phase2", "Terrain_Phase2", "Snow_Phase2" },
		Phase2DeactivateGroups =  { "Snow_Phase1" },
		Phase3DeactivateGroups =  { "Lighting_Phase2" },

		OnDeathFunctionName = "HadesKillPresentation",
		OnDeathFunctionArgs = { Message = "HadesDefeatedMessage", StartPanTime = 1.5, MessageLayer = "ScreenOverlay", MessageDelay = 1.5, MessageDuration = 3.5, AddInterBiomeTimerBlock = true },

		WeaponOptions =
		{
			"HadesInvisibility", "HadesBidentStrike", "HadesBidentSpin", "HadesCast"
		},
		AIEndHealthThreshold = 0.66,
		AIStages =
		{
			-- Phase 1
			{
				RandomAIFunctionNames = { "AttackerAI" },
				SelectPactLevelAIStage = "PactDataStage0",
				AIData =
				{
					AIEndHealthThreshold = 0.66,
				},
				StageTransitionGlobalVoiceLines = "FatherSonArgumentVoiceLines",
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				SelectPactLevelAIStage = "PactDataStage1",
				AIData =
				{
					AIEndHealthThreshold = 0.33,
				},
				StageTransitionGlobalVoiceLines = "FatherSonArgumentVoiceLines",
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				SelectPactLevelAIStage = "PactDataStage2",
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
				StageTransitionGlobalVoiceLines = "FatherSonArgumentVoiceLines",
			},
			-- Phase 2
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "HadesPhaseTransition",
				SelectPactLevelAIStage = "PactDataStage3",
				AIData =
				{
					AIEndHealthThreshold = 0.50,
					PreAttackDashChance = 0.5,
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				PermanentlyEnrage = true,
				SelectPactLevelAIStage = "PactDataStage4",
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
			-- Phase 3
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "HadesPhaseTransition",
				SelectPactLevelAIStage = "PactDataStage5",
				SetHealthPercent = 0.8,
				AIData =
				{
					AIEndHealthThreshold = 0.0,
					PreAttackDashChance = 0.5,
				},
			},
		},

		-- first third of Phase 1
		PactDataStage0 =
		{
			Default = {
			},

			[4] = {
				UnequipWeapons = { "HadesBidentSpin" },
				EquipWeapons = { "HadesBidentThrow", "HadesBidentSpin2" },
			},
		},

		-- second third of Phase 1
		PactDataStage1 =
		{
			Default = {
				FireWeapon = "HadesSpawns",
			},

			[4] = {
				FireWeapon = "HadesSpawns2",
			},
		},

		-- third third of Phase 1
		PactDataStage2 =
		{
			Default = {
				FireWeapon = "HadesSpawns",
				EquipWeapons = { "HadesBidentStrikeCombo1" },
			},

			[4] = {
				FireWeapon = "HadesSpawns2",
				EquipWeapons = { "HadesBidentStrikeCombo1" },
			},
		},

		-- first half of Phase 2
		PactDataStage3 =
		{
			Default = {
				EquipWeapons = { "HadesCastBeam", "HadesCastBeam", "HadesWrath", "HadesBidentArcCombo1" },
				UnequipWeapons = { "HadesInvisibility", "HadesBidentStrike" },
			},

			[4] = {
				EquipWeapons = { "HadesCastBeam2", "HadesCastBeam2", "HadesWrath", "HadesBidentArcCombo1", "HadesBidentThrowCombo1" },
				UnequipWeapons = { "HadesInvisibility", "HadesBidentStrike", "HadesCast", "HadesBidentThrow" },
				DumbFireWeapons = { "HadesWrathPassive" },
			},
		},

		-- second half of Phase 2
		PactDataStage4 =
		{
			Default = {
				EquipWeapons = { "HadesCastBeam360", "HadesCastBeam360", "HadesMobilityCombo1" },
				UnequipWeapons = { "HadesCastBeam", "HadesCastBeam" },
			},

			[4] = {
				EquipWeapons = { "HadesCastBeam2360", "HadesCastBeam2360", "HadesConsumeHeal", "HadesCerberusAssist" },
				UnequipWeapons = { "HadesCastBeam2", "HadesCastBeam2" },
				ClearObstacleTypes = "HadesBidentReturnPoint",
			},
		},

		-- all of Phase 3 in EM4
		PactDataStage5 =
		{
			Default = {
			},

			[4] = {
				EquipWeapons = { "HadesBidentRangedChain", "HadesInvisibility" },
				UnequipWeapons = { "HadesCastBeam2360", "HadesCerberusAssist", "HadesBidentStrikeCombo1", "HadesBidentArcCombo1" },
				DumbFireWeapons = { "HadesWrathPassive", "HadesReverseDarkness" },
			},
		},

		PlayerInjuredVoiceLineThreshold = 0.65,
		PlayerInjuredVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.75,
			SuccessiveChanceToPlay = 0.33,
			RequiredFalseBossPhase = 3,
			Cooldowns =
			{
				{ Name = "HadesAnyQuipSpeech" },
				{ Name = "HadesPlayerInjuredSpeech", Time = 40 },
			},

			-- You see?
			{ Cue = "/VO/HadesField_0090" },
			-- Go home.
			{ Cue = "/VO/HadesField_0091" },
			-- Go home!
			{ Cue = "/VO/HadesField_0092" },
			-- Go home, I said!
			{ Cue = "/VO/HadesField_0093" },
			-- You brought this on yourself.
			{ Cue = "/VO/HadesField_0094" },
			-- There.
			{ Cue = "/VO/HadesField_0095" },
			-- There!
			{ Cue = "/VO/HadesField_0096" },
			-- Another?
			{ Cue = "/VO/HadesField_0097" },
			-- More?
			{ Cue = "/VO/HadesField_0098" },
			-- Well?
			{ Cue = "/VO/HadesField_0099" },
			-- Again?
			{ Cue = "/VO/HadesField_0100" },
			-- Pathetic.
			{ Cue = "/VO/HadesField_0175", RequiredFalseTextLines = { "Ending01" }, },
			-- Wide open.
			{ Cue = "/VO/HadesField_0176" },
			-- I thought Achilles taught you to be quick.
			{ Cue = "/VO/HadesField_0177", SuccessiveChanceToPlay = 0.01 },
			-- Die!
			{ Cue = "/VO/HadesField_0285" },
			-- Fall!
			{ Cue = "/VO/HadesField_0281" },
			-- Fall, blast you!
			{ Cue = "/VO/HadesField_0282", RequiredBossPhase = 2 },
			-- Fall, I said!
			{ Cue = "/VO/HadesField_0283", RequiredAnyPlayedThisRun = { "/VO/HadesField_0281", "/VO/HadesField_0282", "/VO/HadesField_0563", "/VO/HadesField_0564", "/VO/HadesField_0285" }, },
			-- Fall, blast you!
			{ Cue = "/VO/HadesField_0563", RequiredBossPhase = 2 },
			-- Die already!
			{ Cue = "/VO/HadesField_0564", RequiredBossPhase = 2 },
			-- Go back!
			{ Cue = "/VO/HadesField_0565" },
		},
		LastStandReactionVoiceLineMinHealthThreshold = 0.2,
		LastStandReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 2.0,
			Queue = "Always",
			SuccessiveChanceToPlay = 0.66,
			RequiredFalseBossPhase = 3,
			Cooldowns =
			{
				{ Name = "HadesLastStandReactionSpeech", Time = 60 },
			},
			TriggerCooldowns = { "HadesAnyQuipSpeech" },

			-- You're going back!
			{ Cue = "/VO/HadesField_0067" },
			-- You cannot cheat death!
			{ Cue = "/VO/HadesField_0068" },
			-- There is no escape.
			{ Cue = "/VO/HadesField_0069" },
			-- Go home, boy.
			{ Cue = "/VO/HadesField_0070" },
			-- Kick and scream all you like.
			{ Cue = "/VO/HadesField_0071" },
			-- You can't withstand me.
			{ Cue = "/VO/HadesField_0072" },
			-- Perish!
			{ Cue = "/VO/HadesField_0169" },
			-- Death is inescapable.
			{ Cue = "/VO/HadesField_0170" },
			-- Fall!
			{ Cue = "/VO/HadesField_0171" },
			-- Go home!
			{ Cue = "/VO/HadesField_0172" },
			-- You still resist?
			{ Cue = "/VO/HadesField_0173" },
			-- You're bleeding, boy.
			{ Cue = "/VO/HadesField_0174" },
			-- Idiot!
			{ Cue = "/VO/HadesField_0294", RequiredFalseTextLines = { "Ending01" }, },
			-- You'll perish yet.
			{ Cue = "/VO/HadesField_0295" },
			-- Think you can keep this up?
			{ Cue = "/VO/HadesField_0296" },
			-- You're merely stalling, boy!
			{ Cue = "/VO/HadesField_0297" },
			-- Not yet persuaded to go back I see?
			{ Cue = "/VO/HadesField_0298" },
			-- Hungry for more, I see?
			{ Cue = "/VO/HadesField_0299" },
		},
		WrathReactionVoiceLineMinHealthThreshold = 0.2,
		WrathReactionVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.1,
				SuccessiveChanceToPlay = 0.33,
				PlayOnceFromTableThisRun = true,
				RequiredFalseBossPhase = 3,
				Cooldowns =
				{
					{ Name = "HadesWrathSpeech", Time = 400 },
				},
				TriggerCooldowns = { "HadesAnyQuipSpeech" },
				RequiredFalseTraits = { "HadesShoutTrait" },

				-- My foolish brother cannot help you now.
				{ Cue = "/VO/HadesField_0073", RequiredTrait = "ZeusShoutTrait" },
				-- Blast that wretched Zeus!
				{ Cue = "/VO/HadesField_0074", RequiredTrait = "ZeusShoutTrait" },
				-- Zeus...!
				{ Cue = "/VO/HadesField_0663", RequiredTrait = "ZeusShoutTrait" },
				-- Brother? Blast!
				{ Cue = "/VO/HadesField_0664", RequiredTrait = "ZeusShoutTrait" },
				-- Another contribution from my brother Zeus!
				{ Cue = "/VO/HadesField_0468", RequiredTrait = "ZeusShoutTrait", RequiredTextLines = { "Ending01" }, },
				-- Be thankful that my brother favors you!
				{ Cue = "/VO/HadesField_0469", RequiredTrait = "ZeusShoutTrait", RequiredTextLines = { "Ending01" }, },

				-- Poseidon ought not meddle in others' affairs!
				{ Cue = "/VO/HadesField_0075", RequiredTrait = "PoseidonShoutTrait" },
				-- I don't appreciate this, Brother Poseidon!
				{ Cue = "/VO/HadesField_0076", RequiredTrait = "PoseidonShoutTrait" },
				-- Poseidon...!
				{ Cue = "/VO/HadesField_0665", RequiredTrait = "PoseidonShoutTrait" },
				-- Damn you, Brother!
				{ Cue = "/VO/HadesField_0666", RequiredTrait = "PoseidonShoutTrait" },
				-- Brother Poseidon making time to meddle here?
				{ Cue = "/VO/HadesField_0470", RequiredTrait = "PoseidonShoutTrait", RequiredTextLines = { "Ending01" }, },
				-- Poseidon must assert himself at every opportunity!
				{ Cue = "/VO/HadesField_0471", RequiredTrait = "PoseidonShoutTrait", RequiredTextLines = { "Ending01" }, },

				-- You'd cower underneath Athena's shield?
				{ Cue = "/VO/HadesField_0077", RequiredTrait = "AthenaShoutTrait" },
				-- Athena cannot save you from me, boy.
				{ Cue = "/VO/HadesField_0078", RequiredTrait = "AthenaShoutTrait" },
				-- I'll slay you once her shield falls.
				{ Cue = "/VO/HadesField_0667", RequiredTrait = "AthenaShoutTrait" },
				-- Athena would be wiser to stay out of this!
				{ Cue = "/VO/HadesField_0668", RequiredTrait = "AthenaShoutTrait" },
				-- How good of wise Athena to join in!
				{ Cue = "/VO/HadesField_0472", RequiredTrait = "AthenaShoutTrait", RequiredTextLines = { "Ending01" }, },
				-- Where would you be without Athena's aid?
				{ Cue = "/VO/HadesField_0473", RequiredTrait = "AthenaShoutTrait", RequiredTextLines = { "Ending01" }, },

				-- Aphrodite has no jurisdiction here!
				{ Cue = "/VO/HadesField_0079", RequiredTrait = "AphroditeShoutTrait" },
				-- Pah, that meddlesome goddess of love!
				{ Cue = "/VO/HadesField_0080", RequiredTrait = "AphroditeShoutTrait" },
				-- You think of her at such a time as this?!
				{ Cue = "/VO/HadesField_0669", RequiredTrait = "AphroditeShoutTrait" },
				-- You cannot sway me, boy!
				{ Cue = "/VO/HadesField_0670", RequiredTrait = "AphroditeShoutTrait" },
				-- Must Aphrodite get involved in everything?
				{ Cue = "/VO/HadesField_0474", RequiredTrait = "AphroditeShoutTrait", RequiredTextLines = { "Ending01" }, },
				-- To Aphrodite all of this must be some sort of jest!
				{ Cue = "/VO/HadesField_0475", RequiredTrait = "AphroditeShoutTrait", RequiredTextLines = { "Ending01" }, },

				-- The hunting-goddess ought choose lesser prey.
				{ Cue = "/VO/HadesField_0081", RequiredTrait = "ArtemisShoutTrait" },
				-- Artemis! This hunt is well out of your league!
				{ Cue = "/VO/HadesField_0082", RequiredTrait = "ArtemisShoutTrait" },
				-- You are the prey, not me.
				{ Cue = "/VO/HadesField_0671", RequiredTrait = "ArtemisShoutTrait" },
				-- You'll need more arrows than that!
				{ Cue = "/VO/HadesField_0672", RequiredTrait = "ArtemisShoutTrait" },
				-- Boy, you're the one who's being hunted here!
				{ Cue = "/VO/HadesField_0476", RequiredTrait = "ArtemisShoutTrait", RequiredTextLines = { "Ending01" }, },
				-- The goddess of the hunt ought know when to retreat.
				{ Cue = "/VO/HadesField_0477", RequiredTrait = "ArtemisShoutTrait", RequiredTextLines = { "Ending01" }, },

				-- Predictable the war-god would be here!
				{ Cue = "/VO/HadesField_0083", RequiredTrait = "AresShoutTrait" },
				-- You'd best stay out of my affairs, Ares!
				{ Cue = "/VO/HadesField_0084", RequiredTrait = "AresShoutTrait" },
				-- Turn back this instant, boy!
				{ Cue = "/VO/HadesField_0673", RequiredTrait = "AresShoutTrait" },
				-- This shape-shifting of yours won't last for long.
				{ Cue = "/VO/HadesField_0674", RequiredTrait = "AresShoutTrait" },
				-- This must be a delight for your dear cousin Ares, boy!
				{ Cue = "/VO/HadesField_0478", RequiredTrait = "AresShoutTrait", RequiredTextLines = { "Ending01" }, },
				-- That Ares can turn any small dispute into a war!
				{ Cue = "/VO/HadesField_0479", RequiredTrait = "AresShoutTrait", RequiredTextLines = { "Ending01" }, },

				-- That drunkard's power means nothing to me!
				{ Cue = "/VO/HadesField_0085", RequiredTrait = "DionysusShoutTrait" },
				-- Why are you staining my clothes with wine?!
				{ Cue = "/VO/HadesField_0086", RequiredTrait = "DionysusShoutTrait" },
				-- You think this cause for celebration, boy?!
				{ Cue = "/VO/HadesField_0675", RequiredTrait = "DionysusShoutTrait" },
				-- You cloud your senses with this foolishness!
				{ Cue = "/VO/HadesField_0676", RequiredTrait = "DionysusShoutTrait" },
				-- This is a battle, not a time for revelry!
				{ Cue = "/VO/HadesField_0480", RequiredTrait = "DionysusShoutTrait", RequiredTextLines = { "Ending01" }, },
				-- You would seek aid from drunken Dionysus, then?
				{ Cue = "/VO/HadesField_0481", RequiredTrait = "DionysusShoutTrait", RequiredTextLines = { "Ending01" }, },

				-- Demeter had best stay out of my affairs!
				{ Cue = "/VO/HadesField_0327", RequiredTrait = "DemeterShoutTrait" },
				-- That cold witch worsens the weather still?!
				{ Cue = "/VO/HadesField_0328", RequiredTrait = "DemeterShoutTrait" },
				-- The cold is of no consequence to me!
				{ Cue = "/VO/HadesField_0677", RequiredTrait = "DemeterShoutTrait" },
				-- Demeter, you...!
				{ Cue = "/VO/HadesField_0678", RequiredTrait = "DemeterShoutTrait" },
				-- My foster sister must have better things to do!
				{ Cue = "/VO/HadesField_0482", RequiredTrait = "DemeterShoutTrait", RequiredTextLines = { "Ending01" }, },
				-- That Demeter ought tend some other plot of land!
				{ Cue = "/VO/HadesField_0483", RequiredTrait = "DemeterShoutTrait", RequiredTextLines = { "Ending01" }, },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.5,
				Cooldowns =
				{
					{ Name = "HadesWrathSpeech", Time = 400 },
				},
				TriggerCooldowns = { "HadesAnyQuipSpeech" },
				RequiredFalseTraits = { "HadesShoutTrait" },

				-- I'll not indulge such outbursts from you, boy!
				{ Cue = "/VO/HadesField_0087" },
				-- You'd pit my own kin, against me?
				{ Cue = "/VO/HadesField_0088" },
				-- How vile that you'd drag Olympus into this!
				{ Cue = "/VO/HadesField_0089", RequiredFalseTextLines = { "Ending01" }, },
				-- Grrr...!
				{ Cue = "/VO/HadesField_0679" },
				-- You and your relatives!
				{ Cue = "/VO/HadesField_0680" },
				-- That blasted...!
				{ Cue = "/VO/HadesField_0681" },
				-- How dare that...!
				{ Cue = "/VO/HadesField_0682" },
				-- Nrgh, that meddler!
				{ Cue = "/VO/HadesField_0683" },
				-- Cry all you like!
				{ Cue = "/VO/HadesField_0684" },
				-- Face me yourself!
				{ Cue = "/VO/HadesField_0685" },
				-- You leave Olympus out of this!
				{ Cue = "/VO/HadesField_0686" },
				-- It seems you need all of the help that you can get!
				{ Cue = "/VO/HadesField_0484", RequiredTextLines = { "Ending01" }, },
				-- Ah, yes, my dear family being of such help!
				{ Cue = "/VO/HadesField_0485", RequiredTextLines = { "Ending01" }, },
				-- So this is how Olympus is assisting our domain?!
				{ Cue = "/VO/HadesField_0486", RequiredTextLines = { "Ending01" }, },
				-- How cordial of Olympus to appear!
				{ Cue = "/VO/HadesField_0487", RequiredTextLines = { "Ending01" }, },
			},
		},
		AssistReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.75,
				RequiredFalseBossPhase = 3,
				Queue = "Interrupt",
				RequiredTrait = "FuryAssistTrait",

				-- Megaera, what are you doing here?
				{ Cue = "/VO/HadesField_0443", RequiredPlayed = { "/VO/HadesField_0447" }, },
				-- Why spring to his assistance, Megaera?
				{ Cue = "/VO/HadesField_0444", RequiredPlayed = { "/VO/HadesField_0447" }, },
				-- You're surely needed elsewhere, Megaera!
				{ Cue = "/VO/HadesField_0445", RequiredPlayed = { "/VO/HadesField_0447" }, },
				-- Don't bother to assist him, Megaera!
				{ Cue = "/VO/HadesField_0446", RequiredPlayed = { "/VO/HadesField_0447" }, },
				-- You're wasting Megaera's valuable time!
				{ Cue = "/VO/HadesField_0447" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.75,
				RequiredFalseBossPhase = 3,
				Queue = "Interrupt",
				RequiredTrait = "ThanatosAssistTrait",

				-- Get back to your assignments, Thanatos!
				{ Cue = "/VO/HadesField_0448", RequiredPlayed = { "/VO/HadesField_0451" }, },
				-- Don't you have mortals to attend to, Thanatos?
				{ Cue = "/VO/HadesField_0449", RequiredPlayed = { "/VO/HadesField_0451" }, },
				-- No need to listen to him, Thanatos!
				{ Cue = "/VO/HadesField_0450", RequiredPlayed = { "/VO/HadesField_0451" }, },
				-- Distracting Thanatos from his duties, I see!
				{ Cue = "/VO/HadesField_0451" },
				-- You needn't drag poor Thanatos into this mess!
				{ Cue = "/VO/HadesField_0452", RequiredPlayed = { "/VO/HadesField_0451" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.75,
				RequiredFalseBossPhase = 3,
				Queue = "Interrupt",
				RequiredTrait = "SkellyAssistTrait",

				-- I did not summon you!
				{ Cue = "/VO/HadesField_0264" },
				-- Return immediately to your post, you wretch!
				{ Cue = "/VO/HadesField_0265" },
				-- You, identify yourself!!
				{ Cue = "/VO/HadesField_0266" },
				-- Who is this miscreant?!
				{ Cue = "/VO/HadesField_0267" },
				-- What baseborn wretch is this?!
				{ Cue = "/VO/HadesField_0268" },
				-- That blasted wretch is back?
				{ Cue = "/VO/HadesField_0269", RequiredPlayed = { "/VO/HadesField_0264" } },
				-- Begone from here, blast you!!
				{ Cue = "/VO/HadesField_0270" },
				-- You shall be very sorry for this, wretch!
				{ Cue = "/VO/HadesField_0271" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.75,
				RequiredFalseBossPhase = 3,
				Queue = "Interrupt",
				RequiredTrait = "SisyphusAssistTrait",

				-- Was that a boulder from the blasted sky?
				{ Cue = "/VO/HadesField_0272" },
				-- Your handiwork, I take it, Brother Zeus?!
				{ Cue = "/VO/HadesField_0273", RequiredPlayed = { "/VO/HadesField_0272" }, },
				-- Was that your foolish doing, Poseidon?!
				{ Cue = "/VO/HadesField_0274", RequiredPlayed = { "/VO/HadesField_0272" }, },
				-- Another of your blasted boulders, boy?!
				{ Cue = "/VO/HadesField_0275", RequiredPlayed = { "/VO/HadesField_0272" }, },
				-- A collapse from the Temple, nothing more!
				{ Cue = "/VO/HadesField_0276", RequiredPlayed = { "/VO/HadesField_0272" }, },
				-- Was that the blasted boulder from before?!
				{ Cue = "/VO/HadesField_0277", RequiredPlayed = { "/VO/HadesField_0272" }, },
				-- You mean to mock me with such tricks?
				{ Cue = "/VO/HadesField_0278", RequiredPlayed = { "/VO/HadesField_0272" }, },
				-- A laughable excuse for an assault.
				{ Cue = "/VO/HadesField_0279", RequiredPlayed = { "/VO/HadesField_0272" }, },
				-- Foul weather is the only kind!
				{ Cue = "/VO/HadesField_0280", RequiredPlayed = { "/VO/HadesField_0272" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.75,
				RequiredFalseBossPhase = 3,
				Queue = "Interrupt",
				RequiredTrait = "DusaAssistTrait",

				-- This isn't what we compensate the gorgon for!
				{ Cue = "/VO/HadesField_0458" },
				-- Return immediately to your post, gorgon!
				{ Cue = "/VO/HadesField_0459", RequiredPlayed = { "/VO/HadesField_0458" }, },
				-- You're a custodian, not a combatant, gorgon!
				{ Cue = "/VO/HadesField_0460", RequiredPlayed = { "/VO/HadesField_0458" }, },
				-- What is the gorgon doing here again?
				{ Cue = "/VO/HadesField_0461", RequiredPlayed = { "/VO/HadesField_0458" }, },
				-- You summon our custodian for help?
				{ Cue = "/VO/HadesField_0462", RequiredPlayed = { "/VO/HadesField_0458" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.75,
				RequiredFalseBossPhase = 3,
				Queue = "Interrupt",
				RequiredTrait = "AchillesPatroclusAssistTrait",

				-- Back to your post, Shade!
				{ Cue = "/VO/HadesField_0453" },
				-- I don't appreciate this, Shade!
				{ Cue = "/VO/HadesField_0454", RequiredPlayed = { "/VO/HadesField_0453" }, },
				-- Begone with you, back to Elysium!
				{ Cue = "/VO/HadesField_0455", RequiredTextLines = { "MyrmidonReunionQuestComplete" }, RequiredPlayed = { "/VO/HadesField_0453" }, },
				-- The famous spearwork of the Myrmidons!
				{ Cue = "/VO/HadesField_0456", RequiredPlayed = { "/VO/HadesField_0453" }, },
				-- You've still some spark, then, Shade?
				{ Cue = "/VO/HadesField_0457", RequiredPlayed = { "/VO/HadesField_0453" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				Queue = "Interrupt",
				RequiredFalseBossPhase = 3,
				RequiredOneOfTraits = { "ThanatosAssistTrait", "SkellyAssistTrait", "SisyphusAssistTrait", "DusaAssistTrait", "AchillesPatroclusAssistTrait" },

				-- Face me yourself!
				{ Cue = "/VO/HadesField_0463" },
				-- Invite more of your friends, why don't you, boy?
				{ Cue = "/VO/HadesField_0464", RequiredFalseTraits = { "SisyphusAssistTrait" }, },
				-- Leave that one out of this!
				{ Cue = "/VO/HadesField_0465" },
				-- You need assistance even now?
				{ Cue = "/VO/HadesField_0466" },
				-- Who else shall you drag into this?
				{ Cue = "/VO/HadesField_0467" },
			},


		},
		AssistActivatedVoiceLines =
		{
			Queue = "Interrupt",
			{
				{
					{
						RandomRemaining = true,
						PreLineWait = 0.05,
						Source = { SubtitleColor = Color.HadesVoice },
						Cooldowns =
						{
							{ Name = "HadesAnyQuipSpeech", Time = 10 },
						},

						-- Cerberus!!
						{ Cue = "/VO/HadesField_0625", RequiredPlayed = { "/VO/HadesField_0628" } },
						-- Cerberus!!
						{ Cue = "/VO/HadesField_0626", RequiredPlayed = { "/VO/HadesField_0628" } },
						-- Cerberus?!
						{ Cue = "/VO/HadesField_0627", RequiredPlayed = { "/VO/HadesField_0628" } },
						-- Now, Cerberus!!
						{ Cue = "/VO/HadesField_0628" },
					},
					{
						SkipAnim = true,
						NoTarget = true,

						{ Cue = "/VO/CerberusBarks2" },
					}
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.25,
					UsePlayerSource = true,
					RequiredFalseBossPhase = 3,
					Cooldowns =
					{
						{ Name = "ZagreusAnyQuipSpeech", Time = 10 },
					},

					-- What?!
					{ Cue = "/VO/ZagreusField_4530" },
					-- Don't kill me, boy!!
					{ Cue = "/VO/ZagreusField_4531", RequiredPlayed = { "/VO/ZagreusField_4530" }, },
					-- Have mercy, boy!!
					{ Cue = "/VO/ZagreusField_4532", RequiredPlayed = { "/VO/ZagreusField_4530" }, },
					-- Down, boy!! No treat. No treat!!
					{ Cue = "/VO/ZagreusField_4533", RequiredPlayed = { "/VO/ZagreusField_4530" }, },
					-- Bad boy! Bad!
					{ Cue = "/VO/ZagreusField_4534", RequiredPlayed = { "/VO/ZagreusField_4530" }, },
					-- Bad boy! I mean.. good boy?!
					{ Cue = "/VO/ZagreusField_4535", RequiredPlayed = { "/VO/ZagreusField_4530", "/VO/ZagreusField_4534" }, },
					-- Don't listen to him, boy!
					{ Cue = "/VO/ZagreusField_4536", RequiredPlayed = { "/VO/ZagreusField_4530" }, },
					-- Don't have to do this, boy!
					{ Cue = "/VO/ZagreusField_4537", RequiredPlayed = { "/VO/ZagreusField_4530" }, },

				}

			}
		},

		PhaseEndedVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 1.0,
			UsePlayerSource = true,
			RequiredBossPhase = 1,

			-- There!
			{ Cue = "/VO/ZagreusField_2340", RequiredPlayed = { "/VO/ZagreusField_2343" }, },
			-- There.
			{ Cue = "/VO/ZagreusField_2341", RequiredPlayed = { "/VO/ZagreusField_2343" }, },
			-- Got you.
			{ Cue = "/VO/ZagreusField_2342", RequiredPlayed = { "/VO/ZagreusField_2343" }, },
			-- Got you!
			{ Cue = "/VO/ZagreusField_2343" },
			-- Hrnm!
			{ Cue = "/VO/ZagreusField_2344", RequiredPlayed = { "/VO/ZagreusField_2343" }, },
			-- Like that?
			{ Cue = "/VO/ZagreusField_2345", RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" }, RequiredPlayed = { "/VO/ZagreusField_2343" }, },
			-- Hah!
			{ Cue = "/VO/ZagreusField_2346", RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" }, RequiredPlayed = { "/VO/ZagreusField_2343" }, },
			-- Come on, get up.
			{ Cue = "/VO/ZagreusField_2347", PreLineWait = 2.0, RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" }, RequiredPlayed = { "/VO/ZagreusField_2343" }, },
			-- Get up.
			{ Cue = "/VO/ZagreusField_2348", PreLineWait = 2.0, RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" }, RequiredPlayed = { "/VO/ZagreusField_2343" }, },
			-- We're not finished.
			{ Cue = "/VO/ZagreusField_2349", PreLineWait = 2.0, RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" }, RequiredPlayed = { "/VO/ZagreusField_2343" }, },
			-- Let's finish this.
			{ Cue = "/VO/ZagreusField_2350", PreLineWait = 2.0, RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" }, RequiredPlayed = { "/VO/ZagreusField_2343" }, },
			-- Let's finish this, then.
			{ Cue = "/VO/ZagreusField_2351", PreLineWait = 2.0, RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" }, RequiredPlayed = { "/VO/ZagreusField_2343" }, },
			-- Not finished, then?
			{ Cue = "/VO/ZagreusField_2174", PreLineWait = 2.0, RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" }, RequiredPlayed = { "/VO/ZagreusField_2343" }, },
		},
		NextPhaseVoiceLines =
		{
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 2.0,
					SuccessiveChanceToPlay = 0.66,
					RequiredBossPhase = 2,
					TriggerCooldowns = { "HadesAnyQuipSpeech" },

					-- I... can... still... fight!
					{ Cue = "/VO/HadesField_0650" },
					-- Then, this is it!
					{ Cue = "/VO/HadesField_0655", RequiredPlayed = { "/VO/HadesField_0650" }, },
					-- Fight me for real, damn you!
					{ Cue = "/VO/HadesField_0656", RequiredPlayed = { "/VO/HadesField_0650" }, },
				},
				{
					RandomRemaining = true,
					PreLineWait = 2.0,
					RequiredFalseBossPhase = 3,
					-- SuccessiveChanceToPlay = 0.66,
					TriggerCooldowns = { "HadesAnyQuipSpeech" },

					-- Enough of this!!
					{ Cue = "/VO/HadesField_0053" },
					-- You asked for this!
					{ Cue = "/VO/HadesField_0055", RequiredPlayed = { "/VO/HadesField_0053" }, },
					-- Enough!!
					{ Cue = "/VO/HadesField_0057", RequiredPlayed = { "/VO/HadesField_0053" }, },
					-- We're... not... finished!
					{ Cue = "/VO/HadesField_0651", RequiredPlayed = { "/VO/HadesField_0053" }, },
					-- Let's see you deal with this!
					{ Cue = "/VO/HadesField_0652", RequiredPlayed = { "/VO/HadesField_0053" }, },
					-- You... can't... kill... me!
					{ Cue = "/VO/HadesField_0653", RequiredPlayed = { "/VO/HadesField_0053" }, },
					-- Come on and die!
					{ Cue = "/VO/HadesField_0654", RequiredPlayed = { "/VO/HadesField_0053" }, },
					-- I shall not fall to you again!!
					{ Cue = "/VO/HadesField_0649", RequiredPlayed = { "/VO/HadesField_0053" }, RequiredTextLines = { "PersephoneMeeting03" } },
					-- We're not finished!
					{ Cue = "/VO/HadesField_0571", RequiredPlayed = { "/VO/HadesField_0053" }, },
					-- Blast you!
					{ Cue = "/VO/HadesField_0572", RequiredPlayed = { "/VO/HadesField_0053" }, },
					-- That does it!
					{ Cue = "/VO/HadesField_0573", RequiredPlayed = { "/VO/HadesField_0053" }, },
					-- You truly dare?
					{ Cue = "/VO/HadesField_0574", RequiredPlayed = { "/VO/HadesField_0053" }, },
					-- Do not hold back!
					-- { Cue = "/VO/HadesField_0575", RequiredPlayed = { "/VO/HadesField_0650" }, },
					-- No holding back!
					{ Cue = "/VO/HadesField_0576", RequiredPlayed = { "/VO/HadesField_0053" }, RequiredTextLines = { "Ending01" } },
					-- All right!
					-- { Cue = "/VO/HadesField_0577", RequiredPlayed = { "/VO/HadesField_0650" }, },
					-- Try that again!
					{ Cue = "/VO/HadesField_0578", RequiredPlayed = { "/VO/HadesField_0053" }, RequiredTextLines = { "Ending01" } },
				},
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				RequiredFalseTextLinesThisRun = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				PreLineWait = 2.0,
				SuccessiveChanceToPlay = 0.33,
				TriggerCooldowns = { "ZagreusAnyQuipSpeech" },
				RequiredFalseBossPhase = 3,
				UsePlayerSource = true,

				-- All right.
				{ Cue = "/VO/ZagreusField_2352", RequiredPlayed = { "/VO/ZagreusField_2357" }, },
				-- Let's go!
				{ Cue = "/VO/ZagreusField_2353", RequiredPlayed = { "/VO/ZagreusField_2357" }, },
				-- Hraahh!
				{ Cue = "/VO/ZagreusField_2354", RequiredPlayed = { "/VO/ZagreusField_2357" }, },
				-- Come on!!
				{ Cue = "/VO/ZagreusField_2355", RequiredPlayed = { "/VO/ZagreusField_2357" }, },
				-- Come on...!
				{ Cue = "/VO/ZagreusField_2356", RequiredPlayed = { "/VO/ZagreusField_2357" }, },
				-- Father...
				{ Cue = "/VO/ZagreusField_2357" },
				-- If you beat me, I'll just keep coming back!
				{ Cue = "/VO/ZagreusField_2358", RequiredMaxHealthFraction = 0.5, RequiredMaxLastStands = 1, RequiredPlayed = { "/VO/ZagreusField_2357" }, ConsecutiveDeathsInRoom = { Name = "D_Boss01", Count = 1, }, },
				-- Urgghh!!
				{ Cue = "/VO/ZagreusField_2359", RequiredMaxHealthFraction = 0.3, RequiredMaxLastStands = 0 },
			},
		},

		CauseOfDeathVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.65,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				SuccessiveChanceToPlayAll = 0.25,
				Source = { SubtitleColor = Color.HadesVoice },
				ConsecutiveClearsOfRoom =
				{
				  Name = "D_Boss01",
				  Count = 2,
				},
				-- Consider that a reimbursement for last time.
				{ Cue = "/VO/HadesField_0129" },
				-- You are somewhat stronger than expected, boy.
				{ Cue = "/VO/HadesField_0130" },
				-- How arrogant of you to think you are superior to me.
				{ Cue = "/VO/HadesField_0131" },
				-- I am still more than capable of besting you.
				{ Cue = "/VO/HadesField_0583", RequiredTextLines = { "Ending01" }, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.65,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				SuccessiveChanceToPlayAll = 0.33,
				Source = { SubtitleColor = Color.HadesVoice },
				ConsecutiveDeathsInRoom =
				{
				  Name = "D_Boss01",
				  Count = 2,
				},
				-- How many times shall you make me do this?
				{ Cue = "/VO/HadesField_0126" },
				-- Keep trying vainly as often as you like.
				{ Cue = "/VO/HadesField_0127" },
				-- Your flailing attempts against me are embarrassing.
				{ Cue = "/VO/HadesField_0128" },
				-- You're stubborn, boy; however, so am I.
				{ Cue = "/VO/HadesField_0318" },
				-- Got you again, there, boy.
				{ Cue = "/VO/HadesField_0586", RequiredTextLines = { "Ending01" }, },
			},
			-- Extreme Measures 4 specific
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.65,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				SuccessiveChanceToPlayAll = 0.5,
				RequiredTextLines = { "Ending01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 4 },
				Source = { SubtitleColor = Color.HadesVoice },

				-- Do not become too prideful with me, boy.
				{ Cue = "/VO/HadesField_0584", SuccessiveChanceToPlay = 0.05 },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.65,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				SuccessiveChanceToPlayAll = 0.5,
				RequiredTextLines = { "Ending01" },
				Source = { SubtitleColor = Color.HadesVoice },

				-- I expected more from you than this.
				{ Cue = "/VO/HadesField_0579" },
				-- Come, you've bested me before!
				{ Cue = "/VO/HadesField_0580" },
				-- Where was your savage strength this time?
				{ Cue = "/VO/HadesField_0581" },
				-- I expect more consistency from you.
				{ Cue = "/VO/HadesField_0582" },
				-- You could have done better than that.
				{ Cue = "/VO/HadesField_0585" },
				-- Beats listening to incessantly complaining shades.
				{ Cue = "/VO/HadesField_0587" },
				-- I still have some of my old strength, it seems.
				{ Cue = "/VO/HadesField_0433" },
				-- Better fortunes next time, Zagreus.
				{ Cue = "/VO/HadesField_0434" },
				-- You did make it this far at least.
				{ Cue = "/VO/HadesField_0435" },
				-- Be mindful of the House while I am gone.
				{ Cue = "/VO/HadesField_0436" },
				-- Until our next exchange.
				{ Cue = "/VO/HadesField_0437" },
				-- Perhaps next time you shall fare differently.
				{ Cue = "/VO/HadesField_0438" },
				-- Sometimes one's best is insufficient, boy.
				{ Cue = "/VO/HadesField_0439" },
				-- Next time, I shall expect better results from you.
				{ Cue = "/VO/HadesField_0440" },
				-- Not even the combined might of Olympus was enough.
				{ Cue = "/VO/HadesField_0441", RequiredOneOfTraits = GameData.AllSynergyTraits },
				-- Seek better help from all your relatives next time.
				{ Cue = "/VO/HadesField_0442" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.65,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				Source = { SubtitleColor = Color.HadesVoice },

				-- Would that you applied yourself to something worth the while.
				{ Cue = "/VO/HadesField_0116", RequiredFalseTextLines = { "Ending01" }, },
				-- I send you home now with nothing to show for it.
				{ Cue = "/VO/HadesField_0117" },
				-- You're as disgraceful as our kin upon Olympus.
				{ Cue = "/VO/HadesField_0118", RequiredFalseTextLines = { "Ending01" }, },
				-- I told you, boy, that there is no escape.
				{ Cue = "/VO/HadesField_0119" },
				-- Someday or night you shall look back on this, and thank me, boy.
				{ Cue = "/VO/HadesField_0120", RequiredFalseTextLines = { "Ending01" }, },
				-- If this must be the way to teach you discipline, then so be it.
				{ Cue = "/VO/HadesField_0121" },
				-- You mind your manners once you return to my hall.
				{ Cue = "/VO/HadesField_0122" },
				-- How disappointingly predictable an outcome.
				{ Cue = "/VO/HadesField_0123", RequiredFalseTextLines = { "Ending01" }, },
				-- You well could have expected this result.
				{ Cue = "/VO/HadesField_0124" },
				-- Weakling! Remember that I vanquished Titans, boy.
				{ Cue = "/VO/HadesField_0125", RequiredFalseTextLines = { "HadesGift05" }, },
				-- You never, ever learn.
				{ Cue = "/VO/HadesField_0317", RequiredTextLines = { "LordHadesMiscEncounter05" }, RequiredFalseTextLines = { "Ending01" }, },
				-- Achilles taught you reasonably well.
				{ Cue = "/VO/HadesField_0319", RequiredMinRunsCleared = 1, },
				-- Supposing I shall see you here again some other eve.
				{ Cue = "/VO/HadesField_0320", RequiredTextLines = { "LordHadesMiscEncounter06" } },
				-- Now that we're finished here, I can get back to work.
				{ Cue = "/VO/HadesField_0321" },
			},
		},

		InvulnerableHitSound = "/SFX/Enemy Sounds/Hades/EmoteChuckle",
		InvulnerableVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.2,
			ChanceToPlay = 0.25,
			Cooldowns =
			{
				{ Name = "HadesAnyQuipSpeech", Time = 30 },
				{ Name = "HadesHitWhileInvulnerableSpeech", Time = 100 },
			},
			-- No.
			{ Cue = "/VO/HadesField_0112", },
			-- Useless.
			{ Cue = "/VO/HadesField_0113", },
			-- You waste your strength.
			{ Cue = "/VO/HadesField_0114", CooldownName = "SaidStrengthRecently", CooldownTime = 40, },
			-- Idiot.
			{ Cue = "/VO/HadesField_0115", RequiredFalseTextLines = { "Ending01" }, },
			-- A wasted effort.
			{ Cue = "/VO/HadesField_0588", },
			-- How reckless.
			{ Cue = "/VO/HadesField_0589", },
			-- I think not.
			{ Cue = "/VO/HadesField_0590", },
			-- I'm afraid not.
			{ Cue = "/VO/HadesField_0591", RequiredTextLines = { "Ending01" }, },
		},
		LowHealthVoiceLineThreshold = 0.6,
		LowHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			CooldownTime = 12,
			CooldownName = "HadesSpokeRecently",
			PreLineWait = 0.35,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- You hit me!
			-- { Cue = "/VO/Theseus_0166", },
		},
		CriticalHealthVoiceLineThreshold = 0.3,
		CriticalHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			Cooldowns =
			{
				{ Name = "HadesAnyQuipSpeech", Time = 30 },
				{ Name = "HadesCriticalHealthSpeech", Time = 200 },
			},
			PreLineWait = 0.35,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredFalseBossPhase = 3,
			},

			-- You...
			{ Cue = "/VO/HadesField_0102" },
			-- Hmph.
			{ Cue = "/VO/HadesField_0103" },
			-- Tsch.
			{ Cue = "/VO/HadesField_0104" },
			-- Khh.
			{ Cue = "/VO/HadesField_0105" },
			-- Pah.
			{ Cue = "/VO/HadesField_0106" },
			-- Really.
			{ Cue = "/VO/HadesField_0107" },
			-- Nrgh.
			{ Cue = "/VO/HadesField_0108" },
			-- Again!
			{ Cue = "/VO/HadesField_0101" },
			-- Harder.
			-- { Cue = "/VO/HadesField_0109" },
			-- Harder!
			-- { Cue = "/VO/HadesField_0110" },
			-- Truly.
			{ Cue = "/VO/HadesField_0111" },
			-- Urgh...
			{ Cue = "/VO/HadesField_0592", GameStateRequirements = { RequiredBossPhase = 2 } },
			-- How...
			{ Cue = "/VO/HadesField_0593", GameStateRequirements = { RequiredBossPhase = 2 } },
			-- No...
			{ Cue = "/VO/HadesField_0594", GameStateRequirements = { RequiredBossPhase = 2 } },
			-- Hrm...
			{ Cue = "/VO/HadesField_0595" },
			-- So...
			{ Cue = "/VO/HadesField_0596" },
			-- I see...
			{ Cue = "/VO/HadesField_0597" },
			-- Right...
			{ Cue = "/VO/HadesField_0598", GameStateRequirements = { RequiredBossPhase = 1 } },
		},
		-- DefeatedSound = "/SFX/Enemy Sounds/Hades/EmoteDying",
		DefeatedVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SkipAnim = true,

				-- Guh... blast...
				{ Cue = "/VO/HadesField_0132" },
				-- Tsch... how...
				{ Cue = "/VO/HadesField_0133" },
				-- Nrghh... you...
				{ Cue = "/VO/HadesField_0134" },
				-- Khh... heh, heh...
				{ Cue = "/VO/HadesField_0135" },
				-- Mmph... hrm, hrm.
				{ Cue = "/VO/HadesField_0136" },
				-- Hrngh... grrr...
				{ Cue = "/VO/HadesField_0306" },
				-- Ungh... <scoff>
				{ Cue = "/VO/HadesField_0307" },
				-- Ngh... you...!
				{ Cue = "/VO/HadesField_0308" },
				-- Dah... brat...
				{ Cue = "/VO/HadesField_0309", RequiredFalseTextLines = { "Ending01" }, },
				-- How... augh...
				{ Cue = "/VO/HadesField_0310" },
			},
		},
		DeathSound = "/SFX/StabSplatterEndSequence",
		BossKillVoiceLines =
		{
			{
				Queue = "Interrupt",
				RandomRemaining = true,
				SkipAnim = true,
				PreLineWait = 0.5,
				PostLineWait = 1.0,

				-- See... you... at... home....
				{ Cue = "/VO/HadesField_0137", RequiredPlayed = { "/VO/HadesField_0139" } },
				-- Charon... take me home.
				{ Cue = "/VO/HadesField_0138", RequiredPlayed = { "/VO/HadesField_0139" } },
				-- There... is... no... escape...
				{ Cue = "/VO/HadesField_0139" },
				-- Fare... well.
				{ Cue = "/VO/HadesField_0140", RequiredPlayed = { "/VO/HadesField_0139" } },
				-- Good... riddance...
				{ Cue = "/VO/HadesField_0141", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredFalseTextLines = { "Ending01" }, },
				-- Ungh... no...
				{ Cue = "/VO/HadesField_0142", RequiredPlayed = { "/VO/HadesField_0139" } },
				-- Blast... you...
				{ Cue = "/VO/HadesField_0311", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredFalseTextLines = { "Ending01" }, },
				-- Un... grate... ful...
				{ Cue = "/VO/HadesField_0312", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredFalseTextLines = { "Ending01" }, },
				-- How... dare... you...
				{ Cue = "/VO/HadesField_0313", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredFalseTextLines = { "Ending01" }, },
				-- You'll... pay... for...
				{ Cue = "/VO/HadesField_0314", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredFalseTextLines = { "Ending01" }, },
				-- You... shall... not...
				{ Cue = "/VO/HadesField_0315", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredFalseTextLines = { "Ending01" }, },
				-- Why... you... how...?
				{ Cue = "/VO/HadesField_0316", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredFalseTextLines = { "Ending01" }, },
				-- I... cannot... remain.
				{ Cue = "/VO/HadesField_0374", RequiredPlayed = { "/VO/HadesField_0139" } },
				-- My... strength... fails...
				{ Cue = "/VO/HadesField_0375", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredFalseTextLines = { "Ending01" }, },
				-- Blast... I... urgh...
				{ Cue = "/VO/HadesField_0376", RequiredPlayed = { "/VO/HadesField_0139" } },
				-- Again, I... you...
				{ Cue = "/VO/HadesField_0377", RequiredPlayed = { "/VO/HadesField_0139" } },
				-- You'll never... truly... win...
				{ Cue = "/VO/HadesField_0378", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredFalseTextLines = { "Ending01" }, },
				-- I shall... remember... this...
				{ Cue = "/VO/HadesField_0379", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredFalseTextLines = { "Ending01" }, },
				-- Are you... yet... satisfied...
				{ Cue = "/VO/HadesField_0380", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredFalseTextLines = { "Ending01" }, },
				-- You shall... soon... follow...
				{ Cue = "/VO/HadesField_0381", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredFalseTextLines = { "Ending01" }, },
				-- You... win... boy...
				{ Cue = "/VO/HadesField_0488", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredTextLines = { "Ending01" }, },
				-- Well... done... boy....
				{ Cue = "/VO/HadesField_0489", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredTextLines = { "Ending01" }, },
				-- You're... quite... strong...
				{ Cue = "/VO/HadesField_0490", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredTextLines = { "Ending01" }, },
				-- You... fought... well...
				{ Cue = "/VO/HadesField_0491", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredTextLines = { "Ending01" }, },
				-- Let's... do... this... again...
				{ Cue = "/VO/HadesField_0492", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredTextLines = { "Ending01" }, },
				-- I'll... get... you... yet...
				{ Cue = "/VO/HadesField_0493", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredTextLines = { "Ending01" }, },
				-- Beaten... once... again...
				{ Cue = "/VO/HadesField_0494", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredTextLines = { "Ending01" }, ConsecutiveDeathsInRoom =
				{ Name = "D_Boss01", Count = 1, }, },
				-- I... could have... had... you...
				{ Cue = "/VO/HadesField_0495", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredTextLines = { "Ending01" }, RequiredMaxHealthFraction = 0.5, RequiredMaxLastStands = 0 },
				-- Such... strength... boy...
				{ Cue = "/VO/HadesField_0496", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredTextLines = { "Ending01" }, },
				-- I... must... go...
				{ Cue = "/VO/HadesField_0497", RequiredPlayed = { "/VO/HadesField_0139" }, RequiredTextLines = { "Ending01" }, },
			},
			{
				[1] = GlobalVoiceLines.FinalBossDefeatedVoiceLines,
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PlayOnceThisRun = true,
				PreLineWait = 8.1,
				SuccessiveChanceToPlayAll = 0.75,
				ThreadName = "RoomThread",
				ObjectType = "TrainingMeleeSummon",
				RequiredRoom = "D_Boss01",

				-- So, uh... that happened.
				{ Cue = "/VO/Skelly_0453" },
				-- I, uh... I'll just be over here.
				{ Cue = "/VO/Skelly_0454" },
				-- We have a winner!
				{ Cue = "/VO/Skelly_0240" },
				-- You earned it, pal.
				{ Cue = "/VO/Skelly_0241" },
			},
		},

		SelectCustomSpawnOptions = "SetupHadesSpawnOptions",

		MetaPointDropOnDeath =
		{
			Chance = 0.0,
			MinParcels = 4,
			MaxParcels = 4,
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
		},

		-- ending
		BossPresentationSuperPriorityIntroTextLineSets =
		{
			LordHadesAboutPersephoneMeeting01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "PersephoneFirstMeeting" },
				RequiredFalseTextLines = { "PersephoneMeeting09" },
				{ Cue = "/VO/HadesField_0404", PreLineWait = 0.35,
					Text = "You now know that, even if you are able to surpass me, you shall ultimately perish, soon enough. And yet you still persist! Utterly senseless." },
				{ Cue = "/VO/ZagreusField_3680", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I found her, Father. And I'm going to find Mother again. And again, and again, until I have some answers, finally. She'd like some answers, too, beginning with {#DialogueItalicFormat}why did you never tell her that I lived{#PreviousFormat}? You let her go, and left her to her grief!" },
				{ Cue = "/VO/HadesField_0405",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#DialogueItalicFormat}Silence{#PreviousFormat}, boy! Save all your ignorant and baseless accusations. You seem incapable of heeding my request that you not blather on about a matter you shall never understand. Then, I shall save my breath for this fight!" },
			},
			LordHadesAboutPersephoneMeeting02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "PersephoneMeeting02" },
				RequiredFalseTextLines = { "PersephoneMeeting09" },
				{ Cue = "/VO/HadesField_0557", PreLineWait = 0.35,
					Text = "You were never supposed to live. Took all of Nyx's strength to circumvent what should have been a certainty. Now you cannot stay dead. Such is the wry humor of the Fates." },
				{ Cue = "/VO/ZagreusField_4326", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Nyx saved me.... So according to the Fates I was never meant to be born, since neither you nor Mother are of the Underworld, something like that? Or was that just another lie you told, to Mother and whoever else?" },
				{ Cue = "/VO/HadesField_0558",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#DialogueItalicFormat}Bah! {#PreviousFormat}You think everything a lie. The realm beneath our feet was appointed to me on certain conditions, not that I had much of a choice. Among them: A one-time surface-dweller such as I would never have an heir." },
				{ Cue = "/VO/ZagreusField_4327", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You really believed that? Then why attempt to have a child, anyway?" },
				{ Cue = "/VO/HadesField_0559",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You don't know anything! Why anyone would {#DialogueItalicFormat}choose {#PreviousFormat}to have a child is a mystery to me. The Fates said I would never have an heir. Perhaps {#DialogueItalicFormat}this {#PreviousFormat}was all they meant." },
			},
			LordHadesAboutPersephoneMeeting05 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "PersephoneMeeting05_A", "PersephoneMeeting05_B" },
				RequiredFalseTextLines = { "PersephoneMeeting09" },
				{ Cue = "/VO/HadesField_0406", PreLineWait = 0.35,
					Text = "To think Olympus has been aiding you. You must be so grateful to them for their aid, without which none of this would have been possible." },
				{ Cue = "/VO/ZagreusField_3681", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Yeah, about that. Father, did... did you let Mother go because you feared Olympus would find out? And... not respond well to the circumstances if they did?" },
				{ Cue = "/VO/HadesField_0407",
					Text = "{#DialogueItalicFormat}Tsch. {#PreviousFormat}Be grateful they have not found out as yet, for all your meddling. You do not know them as well as you think. Ask yourself why she left Olympus, and how. Or better yet, ask {#DialogueItalicFormat}her{#PreviousFormat}." },
				{ Cue = "/VO/ZagreusField_3682", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Well, she seems quite lovely, so... knowing you, you probably tricked her into signing a pact to come join you, or something. Since you weren't allowed on Olympus, why not have Olympus come to you?" },
				{ Cue = "/VO/HadesField_0408",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#DialogueItalicFormat}Hah{#PreviousFormat}! Surprisingly not distant from the truth. I took her, boy! I took her down with me. Is that what you wish to hear? Does that anger you? Come, bring forth that anger, then!" },
			},
			LordHadesAboutPersephoneMeeting06 =
			{
				PlayOnce = true,
				RequiredTextLines = { "PersephoneMeeting06" },
				RequiredFalseTextLines = { "PersephoneMeeting09" },
				{ Cue = "/VO/HadesField_0409", PreLineWait = 0.35,
					Text = "So, boy. Did you ask her? About how she came to join me in the Underworld. Did you confirm all your suspicions, then?" },
				{ Cue = "/VO/ZagreusField_3683", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You didn't drag her down to hell, yourself, apparently. You're not going to tell me who did, though I can well imagine. Your brothers got to reign forever on Olympus, while you got sent down into the Underworld. So they gave you a consolation prize... didn't they?" },
				{ Cue = "/VO/HadesField_0410",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You make such accusations, knowing next to nothing. Careless as ever. Poseidon had nothing to do with it! He knows even less than you. If you value her existence or your own, you would be wise to keep it that way. And to turn back!" },
			},
			LordHadesAboutPersephoneMeeting07 =
			{
				PlayOnce = true,
				RequiredTextLines = { "PersephoneMeeting07" },
				RequiredFalseTextLines = { "PersephoneMeeting09" },
				{ Cue = "/VO/HadesField_0411", PreLineWait = 0.35,
					Text = "...She was the Queen. Queen of the Underworld! My Queen. Commanding reverence, and awe, and fear. She was not just... what was the term you used? A {#DialogueItalicFormat}consolation prize{#PreviousFormat}? You are as disrespectful to her as you are to me." },
				{ Cue = "/VO/ZagreusField_3684", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Emote = "PortraitEmoteFiredUp",
					Text = "Oh, what would you even know?! You claim so much respect for her, yet you didn't even respect her enough to tell her what happened after she left! But... what am I saying... I know you love her, still, Father. That best explains all the terrible choices you've made." },
				{ Cue = "/VO/HadesField_0412",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineWait = 0.35,
					Text = "...All the terrible choices I've made. By the time you have existed for as long as I have, pray you will have made fewer. Although I fear you shall surpass me in at least this one regard." },
			},

			-- hades letting you go
			LordHadesBeforePersephoneReturn01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				RequiredTextLines = { "PersephoneMeeting09" },
				-- for ending testing
				RequiredFalseTextLines = { "Ending01" },
				EndVoiceLines =
				{
					PreLineWait = 0.3,
					-- Go. Before I reconsider.
					{ Cue = "/VO/HadesField_0415" },
				},
				{ Cue = "/VO/HadesField_0413", PreLineWait = 0.35,
					Text = "...I have done virtually everything within my power to prevent this. All of it... for nothing. The Fates were not content to saddle me within the earth; they mock me, still." },
				{ Cue = "/VO/ZagreusField_3685", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag", PortraitExitAnimation = "Portrait_Zag_Defiant_01_Exit",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Maybe they just think you're in the wrong. And that you're an obstinate, overbearing, miserable excuse for a husband and father. Don't you understand I'm trying to fix the problems you caused? Since you're so unwilling to do it yourself." },
				{ Cue = "/VO/HadesField_0414",
					PreLineThreadedFunctionName = "DoHadesSigh",
					PreLineWait = 5.3,
					Text = "You're right. I was unwilling. I made my choices, in all this. I loved her, yes. I loved her terribly. But now... it seems I am merely delaying the inevitable. Go, then. Go to her. But, should harm befall her... I shall bring my worst wrath upon whomever is to blame... including you." },
				{ Cue = "/VO/ZagreusField_3686",

					MusicActiveStems = { "WoodWinds" },
					MusicActiveStemsDuration = 2,

					PostLineThreadedFunctionName = "SetupPersephoneMusic",
					PostLineFunctionArgs = { FullBlast = true },
					Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Emote = "PortraitEmoteSurprise",
					SetFlagFalse = "HadesEndingFlag",
					-- PostLineThreadedFunctionName = "UnlockRoomExitsEvent",
					Text = "What? You're letting me go, just like that? You're just afraid of getting struck down again. You're serious?" },
			},

			LordHadesPostEnding01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Ending01" },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 1.25,
					-- To the death!
					{ Cue = "/VO/ZagreusField_4657" },
				},
				{ Cue = "/VO/HadesField_0421", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Heh. {#PreviousFormat}Confronting you like this... it's different now. Still... it is a responsibility, just as before. There is to be no escape from my realm. Ultimately, I must see to that, myself." },
				{ Cue = "/VO/ZagreusField_3688", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "That's the spirit, Father! As for me, I find the candor of our interactions here to be rather refreshing, I must say. Especially the interactions between my weapons and your physique. You're tough, but you're an easy target." },
				{ Cue = "/VO/HadesField_0422",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineWait = 0.35,
					Text = "And you are scrawny, though slippery, blast you. All that pent-up rage behind your smiling words... come, unleash it once again. I expect you to go all out. To the death!" },
			},

			LordHadesExtremeMeasures01 =
			{
				PlayOnce = true,
				PreEventWait = 1.0,
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 4 },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 1.25,
					
					-- Let's go!
					{ Cue = "/VO/ZagreusField_4330" },
				},
				{ Cue = "/VO/HadesField_0611", PreLineWait = 0.35,
					Text = "I was reviewing the terms of the Pact of Punishment to which you are bound. Even when my servants resort to extreme measures, they were still unable to surpass you, then. So now, it is my turn." },
				{ Cue = "/VO/ZagreusField_4329", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					PostLineAnimTarget = "Hero",
					Text = "Caught you unprepared, did I? After Theseus and his Macedonian, I half-expected to see you thundering around on some golden chariot of your own, drawn by sable steeds, that sort of thing. But it's just you." },
				{ Cue = "/VO/HadesField_0612",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineWait = 0.35,
					Text = "It is just me, indeed. However... that should be more than necessary, here. No holding back this time, Zagreus. Are you ready?" },
			},

		},
		BossPresentationPriorityIntroTextLineSets =
		{
			LordHadesHasGuanYuAspect01 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				RequiredTrait = "SpearSpinTravel",
				RequiredWeapon = "SpearWeapon",
				{ Cue = "/VO/HadesField_0325", PreLineWait = 0.35,
					Text = "What have you done with my ancient weapon, boy? I sense Varatha's form there in your feeble grip, but... there's some garish power you've awakened in it, haven't you?" },
				{ Cue = "/VO/ZagreusField_2970", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, just took a splash of Titan Blood at the right time was all. There's more to your ancient weapon than you gave it credit for, I guess. Though let's not keep it waiting, no?" },
				{ Cue = "/VO/HadesField_0326",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "No, let's not. Gigaros is the mightier weapon, with none of the treacherous past. It needs no fanciful shape-shifting tricks to run you through. Behold!" },
			},
			LordHadesHasArthurAspect01 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				RequiredTrait = "SwordConsecrationTrait",
				RequiredWeapon = "SwordWeapon",
				{ Cue = "/VO/HadesField_0388", PreLineWait = 0.35,
					Text = "I never had any respect for Stygius, that blade you bear. Perhaps unfairly, due to Brother Poseidon's sloppy form when once he wielded it. But now it seems quite different in your care." },
				{ Cue = "/VO/ZagreusField_3422", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I think we've grown quite close to one another, yes. Enough to where I've come to know a different side of this fine blade right here. This is the aspect of some Arthur fellow! Maybe the two of you could get acquainted properly?" },
				{ Cue = "/VO/HadesField_0389",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#DialogueItalicFormat}Arthur! {#PreviousFormat}No name either of gods or kings of any realm I know. Then, introduce us, as you say! To this new amateur, to whom your blade rendered its services." },
			},
			LordHadesHasRamaAspect01 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				RequiredTrait = "BowBondTrait",
				RequiredWeapon = "BowWeapon",
				{ Cue = "/VO/HadesField_0390", PreLineWait = 0.35,
					Text = "The bow is the weapon of a coward, boy. I said so even to Hera's face. I'm unsurprised that you are drawn to it, and yet... something has changed about it, I can tell." },
				{ Cue = "/VO/ZagreusField_3518", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What, you mean that Coronacht has taken on the aspect of a divine preserver person of some sort, of whom I've seen mere glimpses but seems definitely very capable, and really rather brave?" },
				{ Cue = "/VO/HadesField_0391",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "I know not why the old Infernal Arms endear themselves to you. And, I entirely care not in whose weakling aspect you bring them forth, only to fall to me." },
			},
			LordHadesHasBeowulfAspect01 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				RequiredTrait = "ShieldLoadAmmoTrait",
				RequiredWeapon = "ShieldWeapon",
				{ Cue = "/VO/HadesField_0399", PreLineWait = 0.35,
					Text = "There you are, bearing my brother's blasted shield... flaunting it about so recklessly. Though, what have you done to it, now?" },
				{ Cue = "/VO/ZagreusField_3581", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Not much, really, besides awakening the aspect of a supposedly unstoppable, dragon-slaying warrior called Beowulf. If it has the power to protect him against a giant lizard, I figure it may help me against you." },
				{ Cue = "/VO/HadesField_0400",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You presently shall find I'm no mere giant lizard, boy. Though we shall see whether this Beowulf is any help to you." },
			},
			LordHadesHasGilgameshAspect01 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				RequiredTrait = "FistDetonateTrait",
				RequiredWeapon = "FistWeapon",
				{ Cue = "/VO/HadesField_0618", PreLineWait = 0.35,
					Text = "Resorting to mere fisticuffs with me... though, how you got Malphon to look like that, I've no idea. Pray tell, whose monstrous claws are those? A manticore's?" },
				{ Cue = "/VO/ZagreusField_4335", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "These claws, I'll have you know, Father, belonged once to an ancient god-king known as Gilgamesh. You ever meet?" },
				{ Cue = "/VO/HadesField_0619",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#DialogueItalicFormat}Hrm{#PreviousFormat}. Provided he was flesh and blood at some point, then he resides within my realm. Presumably within Elysium somewhere, sadly bereft of his manticore claws, thanks to you. Come, show me what they can do." },
			},
			LordHadesHasLuciferAspect01 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				RequiredTrait = "GunLoadedGrenadeTrait",
				RequiredWeapon = "GunWeapon",
				{ Cue = "/VO/HadesField_0401", PreLineWait = 0.35,
					Text = "You approach me with that loathsome Rail, boy. Emanating a hellish fury more even than usual, at that. Little surprise you took a shine to it. It was the weapon that I hated most of all." },
				{ Cue = "/VO/ZagreusField_3582", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well, someone called Lucifer apparently thought differently, and took a crack at his own father with it, once. This one's for him, then." },
				{ Cue = "/VO/HadesField_0402",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Invoking names you know nothing about. Presuming, all the while, far too much. You take that monstrous artifact for another friend? You would be wiser to be wary of its influence. But, let us fight." },
			},

			-- prioritized for ending
			LordHadesMiscEncounter05 =
			{
				PlayOnce = true,
				RequiredTextLines = { "PersephoneMeeting04" },
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				{ Cue = "/VO/HadesField_0143", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Ah{#PreviousFormat}, but there you are, boy, finally. Despite my knowing you are always late for everything, here you've outdone yourself by quite some time." },
				{ Cue = "/VO/ZagreusField_2275", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Emote = "PortraitEmoteFiredUp",
					Text = "Oh shut up, and get your fork, and burn away that regal cape, and let's get to this, then. I'd no idea you had all these capes to spare! Must have a whole entire storage chamber full of them." },
				{ Cue = "/VO/HadesField_0144",
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Your mockery of me may temporarily embolden you, but achieves nothing useful, in the end." },
			},

			LordHadesMiscEncounter03 =
			{
				PlayOnce = true,
				RequiredMinTimesSeenRoom = { D_Boss01 = 3 },
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				{ Cue = "/VO/HadesField_0018", PreLineWait = 0.35,
					Text = "This cold white substance falling slowly from the heavens. Snow, they call it. Look carefully upon each fleck. Tiny crystals! But structurally weak. They melt! This surface realm... it is held up by mine." },
				{ Cue = "/VO/ZagreusField_2228", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If you're quite finished teaching me about this snow phenomenon, can we get on with brutally trying to kill each other, here?" },
				{ Cue = "/VO/HadesField_0019",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "You wish to have your mortal-colored blood spill once again upon this bed of snow, then fine. Let us proceed." },
			},
			LordHadesMiscEncounter06 =
			{
				PlayOnce = true,
				RequiredTextLines = { "LordHadesMiscEncounter03" },
				RequiredMinTimesSeenRoom = { D_Boss01 = 4 },
				RequiredFalseTextLines = { "PersephoneFirstMeeting" },
				{ Cue = "/VO/HadesField_0146", PreLineWait = 0.35,
					Text = "You still have yet to see the sun itself. You know only the light of Ixion, but the sun? It is positively blinding. Hideous." },
				{ Cue = "/VO/ZagreusField_2276", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It has been snowy nightfall every single time now that you mention it. I didn't know it snowed so much up here." },
				{ Cue = "/VO/HadesField_0147",
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "It hasn't always. But, that's of no consequence to us. Especially when there's a raging battle to be fought." },
			},

			LordHadesPostEpilogue01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "OlympianReunionQuestComplete" },
				{ Cue = "/VO/HadesField_0423", PreLineWait = 0.35,
					Text = "If you are here, then... the Olympians must still be lending you their aid. Just as before! I scarce believe the Queen's preposterous idea worked. That all it took to settle an old score was a blasted family feast." },
				{ Cue = "/VO/ZagreusField_3689", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Come on, Father, even you must have enjoyed that feast to some extent. We ought to do it more often! Good thing you trusted Mother's judgment on that one. So, then, to the death, once more?" },
				{ Cue = "/VO/HadesField_0424",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineWait = 0.35,
					Text = "Indeed. To the death, as always, boy. Zagreus. Ready yourself." },
			},			
		},
		BossPresentationIntroTextLineSets =
		{
			LordHadesEncounter01 =
			{
				PlayOnce = true,
				RequiredFalseTextLines = { "LordHadesEncounter01_B" },
				RequiredMinCompletedRuns = 4,
				EndVoiceLines =
				{
					BreakIfPlayed = true,
					UsePlayerSource = true,
					PreLineWait = 1.0,
					-- No. You're going home, not me.
					{ Cue = "/VO/ZagreusField_2226" },
				},
				{ Cue = "/VO/HadesField_0006", PreLineWait = 0.35,
					Text = "...I never grew accustomed to the air, up here. It gusts senselessly whichever way it pleases. I suppose you must prefer it to the stillness of the air below." },
				{ Cue = "/VO/ZagreusField_2224", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You know, you're right. The air up here seems pretty good so far. But I will reserve judgment till I've had my fill. I have to say, though, Father: The Helm of Darkness suits you. I'm touched you'd dust it off on my account." },
				{ Cue = "/VO/HadesField_0145",
					Text = "It should not have had to come to this. For all your antics with me and around the House, I always kept my temper, have I not? Unlike you." },
				{ Cue = "/VO/ZagreusField_2307", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Well, let's see. You've berated me repeatedly and often. You've lied to me. Mustered your wretched forces to kill me, over and over. But, sure, I'll grant you that you've always kept most of your anger bottled up. All that's about to change, then?" },
				{ Cue = "/VO/HadesField_0008",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "We're gods, boy. Killing one another is our lot. Although, I always thought I was above it. I told you that you cannot leave this place. It seems I must enforce my rules myself. I'm sending you home, now." },
			},
			-- if you get to Hades on the first run
			LordHadesEncounter01_B =
			{
				PlayOnce = true,
				RequiredFalseTextLines = { "LordHadesEncounter01" },
				RequiredMaxCompletedRuns = 3,
				EndVoiceLines =
				{
					BreakIfPlayed = true,
					UsePlayerSource = true,
					PreLineWait = 1.0,
					-- No. You're going home, not me.
					{ Cue = "/VO/ZagreusField_2226" },
				},
				{ Cue = "/VO/HadesField_0006", PreLineWait = 0.35,
					Text = "...I never grew accustomed to the air, up here. It gusts senselessly whichever way it pleases. I suppose you must prefer it to the stillness of the air below." },
				{ Cue = "/VO/ZagreusField_2224", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You know, you're right. The air up here seems pretty good so far. But I will reserve judgment till I've had my fill. I have to say, though, Father: The Helm of Darkness suits you. I'm touched you'd dust it off on my account." },
				{ Cue = "/VO/HadesField_0145",
					Text = "It should not have had to come to this. For all your antics with me and around the House, I always kept my temper, have I not? Unlike you." },
				{ Cue = "/VO/ZagreusField_2454", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Well let's see. You've berated me repeatedly and often. You've lied to me. Mustered a bunch of incompetent wretches to try to kill me. But, sure, I'll grant you that you've always kept most of your anger bottled up. All that's about to change, then?" },
				{ Cue = "/VO/HadesField_0008",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "We're gods, boy. Killing one another is our lot. Although, I always thought I was above it. I told you that you cannot leave this place. It seems I must enforce my rules myself. I'm sending you home, now." },
			},

			LordHadesEncounter_YouDefeated01 =
			{
				PlayOnce = true,
				RequiredKills = { Hades = 1 },
				RequiredAnyTextLines = { "HadesAboutGhostAdmin01", "DusaLoungeRenovationQuest02", "NyxAboutGhostAdmin01", "HadesAboutGhostAdmin03" },
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0022", PreLineWait = 0.35,
					Text = "You know now what you're doing here is without any purpose whatsoever. Even if I don't slay you myself, you'll simply perish when you cross that threshold there. And yet you still persist?" },
				{ Cue = "/VO/ZagreusField_2230", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I do. Besides, making these treks helps pass the time during the ongoing Underworld renovations. And I'll be in tiptop shape once they're complete!" },
				{ Cue = "/VO/HadesField_0023",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Would that we had a little more support; the renovations could have been complete by now! As ever, you think only of yourself. But if you must insist like this, then you will find me waiting for you once you get here. Every single time." },
			},

			LordHadesEncounter_DoneTalking01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "LordHadesAboutPersephoneMeeting07" },
				RequiredFalseTextLines = { "PersephoneMeeting09" },
				{ Cue = "/VO/HadesField_0150", PreLineWait = 0.35,
					Text = "Why? Why do you keep showing up? In spite of knowing that the outcome shall be just the same as how it always was?" },
				{ Cue = "/VO/ZagreusField_2277", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Beats having to toil away under your overbearing supervision. And besides, as you may be aware, I've recently made up my mind to leave this place." },
				{ Cue = "/VO/HadesField_0151",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "{#DialogueItalicFormat}Eughh{#PreviousFormat}... utterly incorrigible. When next we meet here, then, we'll keep it brief. I have grown weary of our aimless conversations. Now prepare!" },
			},

			LordHadesHadesKeepsakeReaction01 =
			{
				PlayOnce = true,
				RequiredTrait = "HadesShoutKeepsake",
				{ Cue = "/VO/HadesField_0620", PreLineWait = 0.35,
					Text = "You bear the Sigil of the Dead. I wear the Helm of Darkness. Even devoid of artifacts as these, we fight here without witnesses... in shadow." },
				{ Cue = "/VO/ZagreusField_4333", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",					
					Text = "If only everybody knew you had a mighty son most capable of cutting you down to size, with or without the ability to vanish suddenly." },
				{ Cue = "/VO/HadesField_0621",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "A very boastful son, who often thinks too much of his ability. Come, then! I'll make you vanish suddenly." },
			},
			LordHadesPersephoneKeepsakeReaction01 =
			{
				PlayOnce = true,
				RequiredTrait = "ChamberStackTrait",
				{ Cue = "/VO/HadesField_0622", PreLineWait = 0.35,
					Text = "...That pomegranate blossom... I caught its subtle scent as you approached. The Queen has her mother's strength. And much more self control." },
				{ Cue = "/VO/ZagreusField_4334", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",					
					Text = "What, you're afraid of a little flower, now, Father? One that imbues me with the fiercest might of Olympus, granted, but still! It looks harmless, at least." },
				{ Cue = "/VO/HadesField_0623",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "I fear your little flower there much more than you. The Queen and her mother... they possess power over life. Thus, power over death." },
			},

			LordHadesExtremeMeasures02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "LordHadesExtremeMeasures01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 4 },
				ConsecutiveDeathsInRoom =
				{
					Name = "D_Boss01",
					Count = 1,
				},
				{ Cue = "/VO/HadesField_0613", PreLineWait = 0.35,
					Text = "Extreme measures permitted, even still? You must have forgotten to change the conditions of your Pact of Punishment." },
				{ Cue = "/VO/ZagreusField_4331", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					PostLineAnimTarget = "Hero",
					Text = "Wasn't an oversight. You're strong, Father. I want to be as strong, and more. Not that I'm taking after you, or anything." },
				{ Cue = "/VO/HadesField_0614",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineWait = 0.35,
					Text = "You wish to test yourself against the full extent of my wrath, then very well. You have earned that right. Besides yourself, only the Titans have. Now, then... {#DialogueItalicFormat}attack{#PreviousFormat}!" },
			},
			LordHadesExtremeMeasures03 =
			{
				PlayOnce = true,
				PreEventWait = 1.0,
				RequiredTextLines = { "LordHadesExtremeMeasures01", "LordHadesExtremeMeasuresDefeat01" },
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 4 },
				ConsecutiveClearsOfRoom =
				{
					Name = "D_Boss01",
					Count = 1,
				},
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 1.25,
					-- To the death!
					{ Cue = "/VO/ZagreusField_4657" },
				},				
				{ Cue = "/VO/HadesField_0615", PreLineWait = 0.35,
					Text = "You vanquished me... even when I threw everything I had at you, and more. I fought you as I fought the Titans themselves, and still I failed." },
				{ Cue = "/VO/ZagreusField_4332", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					PostLineAnimTarget = "Hero",
					Text = "Oh, don't take it so hard, Father. There's always next time, right? Meaning, this time. Maybe I won't be so fortunate." },
				{ Cue = "/VO/HadesField_0616",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineWait = 0.35,
					Text = "Of that, I am most certain. Come, let us see the limits of our abilities, then. I warn you: I shall hold nothing back. To the death!" },
			},

			LordHadesNoBoonsReaction01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Ending01" },
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				RequiredNoGodBoons = true,
				{ Cue = "/VO/HadesField_0659", PreLineWait = 0.35,
					Text = "...Nary a whif of Mount Olympus on you, this time. How is it that you clambered all this way, without the generous support of your dear family? Doubtless you merely purged their blessings for some coin." },
				{ Cue = "/VO/ZagreusField_4643", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Hey, I resent that, Father! I'm more than capable of getting here all on my own, now, thanks." },
				{ Cue = "/VO/HadesField_0660",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Such arrogance has led to many a mortal's downfall... and many a god's." },
			},
			LordHadesNoBoonsReaction02 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				RequiredNoGodBoons = true,
				RequiredMinCompletedRuns = 10,
				{ Cue = "/VO/HadesField_0561", PreLineWait = 0.35,
					Text = "Odd. No stink of Olympus on you, this time. Have you truly come all this way without assistance from your relatives? Or were you overzealous at a Pool of Purging?" },
				{ Cue = "/VO/ZagreusField_4668", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Wouldn't you like to know? Not even Nyx believed that I could come this far without aid from the Olympians. Maybe I just have a knack for proving everybody wrong." },
				{ Cue = "/VO/HadesField_0562",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You have a {#DialogueItalicFormat}knack {#PreviousFormat}for being struck down in various, ignoble ways, that much is certain. Come, then! Show me what you, yourself, can do!" },
			},

			LordHadesAboutFishing01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "Ending01", "HadesPostEnding02" },
				-- fishing point in front of him
				IsIdAlive = 553255,
				{ Cue = "/VO/HadesField_0689", PreLineWait = 0.35,
					Text = "Be still. These waters... teeming with Poseidon's river denizens. That one there, before me... it's been taunting me, I think, for quite some time." },
				{ Cue = "/VO/ZagreusField_4675", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "You offering to take me {#DialogueItalicFormat}fishing{#PreviousFormat}, Father? Sounds more pleasant than having you slaughter me again, or the other way around." },
				{ Cue = "/VO/HadesField_0690",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "You mistook my meaning. First, {#DialogueItalicFormat}you {#PreviousFormat}shall have my spear. Then, that thing shall, if it has not yet come to its senses. Though, if you vanquish me, I'm certain your uncle shall not mind if you extract it, yourself." },
			},

			LordHadesPactHighHeatReaction01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "DemeterFirstPickUp" },
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				RequiredActiveShrinePointsMin = 25,
				{ Cue = "/VO/HadesField_0657", PreLineWait = 0.35,
					Text = "It is a testament to the awful might of Demeter that, even with the surge of heat created by the Pact of Punishment you toy with recklessly, this place remains a frozen waste." },
				{ Cue = "/VO/ZagreusField_4642", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "The Pact did make the road here a little more fraught than usual. But if it couldn't stop me, I can't imagine it could stop Demeter." },
				{ Cue = "/VO/HadesField_0658",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Forget her, and the blasted Pact. I'll stop you, myself." },
			},

			LordHadesWinterCurseReaction01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "OlympianReunionQuestComplete", "DemeterLiftsWinterCurse02" },
				{ Cue = "/VO/HadesField_0661", PreLineWait = 0.35,
					Text = "Enjoying the delicate warmth of the surface, b-- Zagreus? Apparently, the generosity of the goddess of seasons knows no bounds." },
				{ Cue = "/VO/ZagreusField_4644", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "Does feel a bit different, maybe. Though, Demeter said something about how this spot, in particular, would remain bereft of warmth, as a reminder. Do you think she knows what happened with Mother, really?" },
				{ Cue = "/VO/HadesField_0662",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Demeter may harbor vengeful feelings and suspicions, but she is no fool. Experience teaches us to know when to quit. Though, evidently, that is a lesson you have yet to learn." },
			},

			LordHadesLowHealth01 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				RequiredMaxHealthFraction = 0.25,
				RequiredMaxLastStands = 0,
				{ Cue = "/VO/HadesField_0024", PreLineWait = 0.35,
					Text = "Look at yourself, boy. You barely stand, and yet believe you can surpass me in your current state?" },
				{ Cue = "/VO/ZagreusField_2231", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It's not exactly easy getting here, you know. But I'm not going back. Not yet." },
				{ Cue = "/VO/HadesField_0025",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Perhaps not yet. But very, very soon." },
			},

			LordHadesHasWeaponUpgrade01 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				RequiredTrait = "SpearWeaveTrait",
				RequiredWeapon = "SpearWeapon",

				{ Cue = "/VO/HadesField_0246", PreLineWait = 0.35,
					Text = "Varatha... I recognize its presence, now. That's not just any three-pronged lance you wield. I could never stand to look at it, once my brothers and my sisters and myself... once our foul work was done." },
				{ Cue = "/VO/ZagreusField_2465", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You mean once you'd chopped up your cruel and overbearing Titan parents, right? Shame you threw it out. It's quite useful." },
				{ Cue = "/VO/HadesField_0241",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Perhaps the Fates decided that its wielders ought to all eventually wind up on its receiving end. Come, then! Let us see what the great Achilles has taught you." },
			},
			LordHadesHasWeaponUpgrade02 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				RequiredTrait = "DislodgeAmmoTrait",
				RequiredWeapon = "SwordWeapon",

				{ Cue = "/VO/HadesField_0242", PreLineWait = 0.35,
					Text = "So! You think that you can vanquish me with my fool brother's old, forgotten blade. Poseidon was never any good with Stygius. Grew envious of my spearwork. Now he's famous for that fork of his! Always taking credit where none is due." },
				{ Cue = "/VO/ZagreusField_2466", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Must be hard, knowing that everybody's going to think you learned your spearwork from Poseidon, not the other way around. As for Stygius, I can assure you it's in good hands now." },
				{ Cue = "/VO/HadesField_0243",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Your assurances mean nothing to me, boy. You think yourself quite capable? Then show me." },
			},
			LordHadesHasWeaponUpgrade03 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				RequiredTrait = "ShieldTwoShieldTrait",
				RequiredWeapon = "ShieldWeapon",

				{ Cue = "/VO/HadesField_0244", PreLineWait = 0.35,
					Text = "You come here bearing brother Zeus' Aegis. I wonder how much more insulting you could be." },
				{ Cue = "/VO/ZagreusField_2467", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What? I haven't even started to insult you here yet, Father. Flustered by the old Shield of Chaos, then?" },
				{ Cue = "/VO/HadesField_0245",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Doubtless Zeus does not even remember wielding it. I never should have relied on him for anything after that! Then, come. Let's see if you're any better with it than your great uncle." },
			},
			-- alt below (in case you know more from Demeter already)
			LordHadesAboutEternalWinter01 =
			{
				PlayOnce = true,
				RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				-- winter introductions
				RequiredAnyTextLines = { "DemeterMiscPickup11", "DemeterMiscPickupAboutWinter01", "DemeterMiscPickupAboutWinter02", "DemeterMiscPickupAboutWinter03", "DemeterRejection09", "DemeterMakeUp06", "DemeterMakeUp07", "DemeterMakeUp10" },
				RequiredFalseTextLines = { "LordHadesAboutEternalWinter01_B", "OlympianReunionQuestComplete" },
				RequiredGodLoot = "DemeterUpgrade",
				{ Cue = "/VO/HadesField_0322", PreLineWait = 0.35,
					Text = "{#DialogueItalicFormat}Hrm{#PreviousFormat}. It grew distinctly colder just as you arrived. So {#DialogueItalicFormat}Demeter {#PreviousFormat}has been in contact with you, then. That witch. Tell me how much she knows." },
				{ Cue = "/VO/ZagreusField_2968", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What? I don't... wait, this everlasting winter, it's her doing, isn't it? Why? Don't mortals die when it's cold? Sounds like a lot of extra work for you." },
				{ Cue = "/VO/HadesField_0323",
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "Then you are ignorant. Keep it that way, with her. Lest you risk everything, you understand? The consequences would be far worse than a foul stretch of weather. But, enough talk, now." },
			},
			LordHadesAboutEternalWinter01_B =
			{
				PlayOnce = true,
				RequiredTextLines = { "LordHadesMiscEncounter06", "DemeterAboutPersephone03" },
				RequiredFalseTextLines = { "LordHadesAboutEternalWinter01", "Ending01" },
				RequiredGodLoot = "DemeterUpgrade",
				{ Cue = "/VO/HadesField_0322", PreLineWait = 0.35,
					Text = "Hrm. It grew distinctly colder just as you arrived. So Demeter has been in contact with you, then. That witch. Tell me how much she knows." },
				{ Cue = "/VO/ZagreusField_2969", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "She lost her daughter... who's my mother. But, Demeter still thinks I'm Nyx's son, and... what have you done, Father? This everlasting winter, it's her doing, isn't it? Freezing mortals to death. Why don't you stop this?" },
				{ Cue = "/VO/HadesField_0324",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Text = "The two of you know nothing, then, it seems. Keep it that way, especially with her. Lest you risk everything, you understand? The consequences would be far worse than a foul stretch of weather. But, enough talk, now." },
			},
		},

		BossPresentationTextLineSets =
		{
			LordHadesMiscEncounter01 =
			{
				PlayOnce = true,
				RequiredFalseTextLines = { "Ending01" },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 0.6,
					-- Shut up!
					{ Cue = "/VO/ZagreusField_2220" },
				},
				{ Cue = "/VO/HadesField_0004", PreLineWait = 0.35,
					Text = "...The sea... the heavens, and the earth. All of this belongs to my brothers. We are their kin by birth. But we are foreigners in their country." },
				{ Cue = "/VO/ZagreusField_2173", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "No. No mournful speeches. Now get out of my way." },
				{ Cue = "/VO/HadesField_0005",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "You impertinent brat. Fine. Impulsiveness runs in the family." },
			},
			LordHadesMiscEncounter02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "LordHadesMiscEncounter01" },
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0016", PreLineWait = 0.35,
					Text = "There was a time when Cerberus would never have permitted any soul to exit through that gateway there behind you." },
				{ Cue = "/VO/ZagreusField_2227", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, that can't possibly be true! What about Orpheus, Theseus, Heracles, Odysseus? Countless tales of brave men delving into the Underworld, then leaving whence they came!" },
				{ Cue = "/VO/HadesField_0017",
					PostLineAnim = "HadesBattleIntro", Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "They left on my authority alone. Nor did they take for granted my good graces. You believe you are entitled simply to walk out of here. From your birthright and your responsibilities! But I am here to tell you, {#DialogueItalicFormat}no{#PreviousFormat}." },
			},
			-- MiscEncounter03 moved up to priority
			LordHadesMiscEncounter04 =
			{
				PlayOnce = true,
				RequiredTextLines = { "LordHadesMiscEncounter01" },
				{ Cue = "/VO/HadesField_0020", PreLineWait = 0.35,
					Text = "My brothers and my sisters and myself. We, too, wanted to slay our parents. The Titans. Bastards. And worse." },
				{ Cue = "/VO/ZagreusField_2229", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "And you succeeded. Chopped up some of them into many tiny bits, and sprinkled them throughout the pits of Tartarus so that they can't regenerate! Or so I hear. Inspiring, really!" },
				{ Cue = "/VO/HadesField_0021",
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "We had no recourse at the time, save to collaborate. Developed a specific plan, and saw it through. And, the Titans...? You think me cruel, yet know nothing of cruelty. But, here, you want something to hate, then have it!" },
			},
			-- MiscEncounter05 moved up to priority
			-- MiscEncounter06 moved up to priority
			LordHadesMiscEncounter07 =
			{
				PlayOnce = true,
				RequiredKills = { Hades = 5 },
				RequiredTextLines = { "LordHadesMiscEncounter01" },
				{ Cue = "/VO/HadesField_0148", PreLineWait = 0.35,
					Text = "I must admit to something, boy. Achilles taught you reasonably well. I expected that if anyone could train you into martial competence, it would be him." },
				{ Cue = "/VO/ZagreusField_2310", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Though you didn't expect that, one day, I would end up using everything I learned from him against {#DialogueItalicFormat}you{#PreviousFormat}." },
				{ Cue = "/VO/HadesField_0149",
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I anticipate more than you know. But Achilles merely practiced against mortals. Now, you practice against {#DialogueItalicFormat}me{#PreviousFormat}." },
			},
		},

		-- following are short misc repeatable evergreen combat start lines
		BossPresentationRepeatableTextLineSets =
		{
			-- other general cases
			LordHadesMiscStart01 =
			{
				{ Cue = "/VO/HadesField_0026",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Come all this way again, to fall to me? Would that you paid me such respects back at the House." },
			},
			LordHadesMiscStart02 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0027",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "What is it going to take for you to understand that your place is in the House?!" },
			},
			LordHadesMiscStart03 =
			{
				{ Cue = "/VO/HadesField_0028",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I shall give you no quarter, boy. Although I doubt that you expected otherwise." },
			},
			LordHadesMiscStart04 =
			{
				{ Cue = "/VO/HadesField_0029",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "The sea and air are very still this eve. Though I suppose that is about to change." },
			},
			LordHadesMiscStart05 =
			{
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0030",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Know only that I take no pleasure in what I am now forced to do." },
			},
			LordHadesMiscStart06 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0178",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "There you are. Then let us now commence this ugly business yet again." },
			},
			LordHadesMiscStart07 =
			{
				{ Cue = "/VO/HadesField_0179",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "The heavens and the seas belong to my brothers; but know that you are still in {#DialogueItalicFormat}my {#PreviousFormat}domain." },
			},
			LordHadesMiscStart08 =
			{
				{ Cue = "/VO/HadesField_0180",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "You bypassed Cerberus again, I see. Unfortunately for the both of us." },
			},
			LordHadesMiscStart09 =
			{
				{ Cue = "/VO/HadesField_0181",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I had other pressing business to attend to. But I cannot let you leave." },
			},
			LordHadesMiscStart10 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0182",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "No matter how many times you try, your stubbornness shall get you nowhere with me." },
			},

			LordHadesMiscStart11 =
			{
				RequiredWeapon = "SwordWeapon",
				{ Cue = "/VO/HadesField_0329",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "You're back, with Stygius in hand. Come then, and show me your technique!" },
			},
			LordHadesMiscStart12 =
			{
				RequiredWeapon = "SwordWeapon",
				{ Cue = "/VO/HadesField_0330",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "The Blade of the Underworld cannot help you here, you realize that, boy?" },
			},
			LordHadesMiscStart13 =
			{
				RequiredWeapon = "BowWeapon",
				{ Cue = "/VO/HadesField_0331",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Your heart-seeking Coronacht may have brought you this far, but shall not help you, here." },
			},
			LordHadesMiscStart14 =
			{
				RequiredWeapon = "BowWeapon",
				{ Cue = "/VO/HadesField_0332",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "That heart-seeking bow you wield... it is nothing but a tool for cowards, boy." },
			},
			LordHadesMiscStartWithSpear01 =
			{
				RequiredWeapon = "SpearWeapon",
				{ Cue = "/VO/HadesField_0397",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "So, Varatha and Gigaros are to clash again upon this empty field. Let us have at it, then." },
			},
			LordHadesMiscStartWithSpear02 =
			{
				RequiredWeapon = "SpearWeapon",
				{ Cue = "/VO/HadesField_0398",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I knew someday the Eternal Spear would turn on me. Let's see you wield it, boy." },
			},
			LordHadesMiscStart15 =
			{
				RequiredWeapon = "ShieldWeapon",
				{ Cue = "/VO/HadesField_0333",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "The Shield of Chaos... what a monstrous thing. How suitable for you." },
			},
			LordHadesMiscStart16 =
			{
				RequiredWeapon = "ShieldWeapon",
				{ Cue = "/VO/HadesField_0334",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "You bear the Aegis so much like your uncle Zeus once did." },
			},
			LordHadesMiscStart17 =
			{
				RequiredWeapon = "GunWeapon",
				{ Cue = "/VO/HadesField_0335",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "You think the Rail of Adamant can vanquish me? We'll momentarily find out." },
			},
			LordHadesMiscStart18 =
			{
				RequiredWeapon = "GunWeapon",
				{ Cue = "/VO/HadesField_0336",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "You would take aim at me with Exagryph? Then, very well." },
			},
			LordHadesMiscStart19 =
			{
				RequiredWeapon = "FistWeapon",
				{ Cue = "/VO/HadesField_0337",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "You would attack me with the savagery of the Twin Fists? Then, come." },
			},
			LordHadesMiscStart20 =
			{
				RequiredWeapon = "FistWeapon",
				RequiredTextLines = { "LordHadesMiscStart19" },
				{ Cue = "/VO/HadesField_0338",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Again, you seek to use the power of Malphon against me. Fine." },
			},
			LordHadesMiscStart21 =
			{
				{ Cue = "/VO/HadesField_0339",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "You are predictable in your arrivals here. Less so during the fight itself." },
			},
			LordHadesMiscStart22 =
			{
				RequiredPlayed = { "/VO/ZagreusHome_0895" },
				{ Cue = "/VO/HadesField_0340",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I was just thinking on when last I vanquished you. Come, refresh my memory." },
			},
			LordHadesMiscStart23 =
			{
				RequiredKills = { Hades = 5 },
				RequiredRoomLastRun = "D_Boss01",
				{ Cue = "/VO/HadesField_0341",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "No matter how often you defeat me, I shall face you here." },
			},
			LordHadesMiscStart24 =
			{
				RequiredRoomLastRun = "D_Boss01",
				{ Cue = "/VO/HadesField_0342",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Remember, I can always get here much, much faster than you." },
			},
			LordHadesMiscStart25 =
			{
				RequiredRoomLastRun = "D_Boss01",
				{ Cue = "/VO/HadesField_0343",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "No matter how quickly you're able to get here, I shall be waiting." },
			},
			LordHadesMiscStart26 =
			{
				RequiredRoomLastRun = "D_Boss01",
				{ Cue = "/VO/HadesField_0344",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Again, you draw me from all my responsibilities back at the House." },
			},
			LordHadesMiscStart27 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0345",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I cannot let you go, boy. Some night such as this one, you'll understand." },
			},
			LordHadesMiscStart28 =
			{
				RequiresLastRunCleared = true,
				{ Cue = "/VO/HadesField_0346",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I shall be interested to see if you can vanquish me again, here, boy." },
			},
			LordHadesMiscStart29 =
			{
				{ Cue = "/VO/HadesField_0347",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Come, show me everything you've learned of how to fight." },
			},
			LordHadesMiscStart30 =
			{
				{ Cue = "/VO/HadesField_0348",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "You've slipped by Cerberus again, I see. Then, draw your weapon, boy." },
			},
			LordHadesMiscStart31 =
			{
				{ Cue = "/VO/HadesField_0349",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I see it's time again that we begin our bloody business here." },
			},
			LordHadesMiscStart32 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0350",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "This blasted place... how can you even stand it on the surface, here?" },
			},
			LordHadesMiscStart33 =
			{
				RequiredMinRunsCleared = 5,
				{ Cue = "/VO/HadesField_0351",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Who shall be first to return home this time, do you suppose?" },
			},
			LordHadesMiscStart34 =
			{
				RequiresLastRunNotCleared = true,
				{ Cue = "/VO/HadesField_0352",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "It seems it's time again I sent you home, myself." },
			},
			LordHadesMiscStart35 =
			{
				{ Cue = "/VO/HadesField_0353",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Your rampage through my realm ends here and now." },
			},
			LordHadesMiscStart36 =
			{
				{ Cue = "/VO/HadesField_0354",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I thought you might arrive right about now. Then, let us have our fight." },
			},
			LordHadesMiscStart37 =
			{
				{ Cue = "/VO/HadesField_0355",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "You'll go not one step farther past this threshold, boy." },
			},
			LordHadesMiscStart38 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0356",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "The world beyond my realm is not for you. You're going home." },
			},
			LordHadesMiscStart40 =
			{
				RequiredMinRunsCleared = 5,
				{ Cue = "/VO/HadesField_0357",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I wonder, boy, who's going to kill whom this time around." },
			},
			LordHadesMiscStart41 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				ConsecutiveDeathsInRoom =
				{
					Name = "D_Boss01",
					Count = 1,
				},
				{ Cue = "/VO/HadesField_0358",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I cannot fathom why you wish to die repeatedly like this." },
			},

			LordHadesPostEndingStart01 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0425",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Already here? It seems our Underworld still has many failings I shall have to deal with, after this." },
			},
			LordHadesPostEndingStart02 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0426",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Come show your father what you've learned of late. Do not hold back." },
			},
			LordHadesPostEndingStart03 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0427",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Would that you cleaned your chambers with the same devotion you show getting to these heights." },
			},
			LordHadesPostEndingStart04 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0428",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Untold murderous wretches in my realm, all at my beck and call, yet still you made it here." },
			},
			LordHadesPostEndingStart05 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0429",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "You have circumvented all of my security measures again. But can you get through {#DialogueItalicFormat}me{#PreviousFormat}?" },
			},
			LordHadesPostEndingStart06 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0430",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I trust you have retained enough of your strength through this ordeal to make this worth our while?" },
			},
			LordHadesPostEndingStart07 =
			{
				RequiredTextLines = { "Ending01" },
				RequiredMaxHealthFraction = 0.65,
				{ Cue = "/VO/HadesField_0431",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Catch your breath if necessary, and then let us see if you shall earn your bonus for this day." },
			},
			LordHadesPostEndingStart08 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0432",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "{#DialogueItalicFormat}Bah{#PreviousFormat}! Not one of my overseers managed to stop you, again? Must I do everything myself?" },
			},
			LordHadesPostEndingStart09 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0599",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I've other work to get to! Arm yourself, and let us end this quickly, boy." },
			},
			LordHadesPostEndingStart10 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0600",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "It seems our realm has many weaknesses. I shall deal with them shortly, then." },
			},
			LordHadesPostEndingStart11 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0601",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Let us see if the support you're getting from Olympus amounts to anything of use." },
			},
			LordHadesPostEndingStart12 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0602",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Blast, but you're persistent, even now! Though let us see how strong you are, as well." },
			},
			LordHadesPostEndingStart13 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0603",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I should be getting back to my desk. But I suppose the work can wait." },
			},
			LordHadesPostEndingStart14 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0604",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "{#DialogueItalicFormat}Ah{#PreviousFormat}, there you are, boy! I was beginning to think I'd need a thicker cloak." },
			},
			LordHadesPostEndingStart15 =
			{
				RequiredTextLines = { "Ending01", "HadesGift03" },
				{ Cue = "/VO/HadesField_0605",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Well, Zagreus. Even if I vanquish you, arriving here is a sufficient feat." },
			},
			LordHadesPostEndingStart16 =
			{
				RequiredTextLines = { "Ending01", "HadesGift04" },
				{ Cue = "/VO/HadesField_0606",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I must admit, this is a welcome change of pace from all the parchmentwork." },
			},
			LordHadesPostEndingStart17 =
			{
				RequiredTextLines = { "Ending01" },
				ConsecutiveDeathsInRoom = { Name = "D_Boss01", Count = 1, },
				{ Cue = "/VO/HadesField_0607",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I suppose that you must be eager to repay me for last time, then?" },
			},
			LordHadesPostEndingStart18 =
			{
				RequiredTextLines = { "Ending01", "HadesGift02" },
				ConsecutiveDeathsInRoom = { Name = "D_Boss01", Count = 1, },
				{ Cue = "/VO/HadesField_0608",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "I expect I shall be able to vanquish you again. Though, we shall see." },
			},
			LordHadesPostEndingStart19 =
			{
				RequiredTextLines = { "Ending01" },
				ConsecutiveClearsOfRoom = { Name = "D_Boss01", Count = 2 },
				{ Cue = "/VO/HadesField_0609",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Perhaps the blasted Fates shall favor {#DialogueItalicFormat}me{#PreviousFormat}, for once." },
			},
			LordHadesPostEndingStart20 =
			{
				RequiredTextLines = { "Ending01" },
				ConsecutiveClearsOfRoom = { Name = "D_Boss01", Count = 2 },
				{ Cue = "/VO/HadesField_0610",
					PreLineWait = 0.35,
					PostLineAnim = "HadesBattleIntro", PreLineWait = 0.35, Portrait = "Portrait_Hades_HelmCape_01", AngleTowardTargetId = 40000,
					PreLineFunctionName = "StartFinalBossRoomIntroMusic",
					PostLineFunctionName = "StartFinalBossRoomMusic",
					Text = "Our last exchange left much to be desired, for my part. But this time, we shall see." },
			},
		},

		BossPresentationNextStageTextLineSets =
		{
			LordHadesR1FirstWin =
			{
				PlayOnce = true,
				RequiredBossPhase = 1,
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 3.0,
					-- Oh great.
					{ Cue = "/VO/ZagreusField_2175" },
				},
				{ Cue = "/VO/HadesField_0010", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.35,
					Text = "...{#DialogueItalicFormat}Tsch{#PreviousFormat}. To have been brought this low... by my own ungrateful child. I would expect such treatment from my brothers, but from you...? {#DialogueItalicFormat}Nrrrgghhh{#PreviousFormat}...." },
			},
			LordHadesNextStageMisc01 =
			{
				PlayOnce = true,
				RequiredBossPhase = 1,
				RequiredTextLines = { "LordHadesR1FirstWin" },
				{ Cue = "/VO/HadesField_0031", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.35,
					Text = "...Such contempt, for your own father. But we are not finished here, yet." },
			},
			LordHadesNextStageMisc02 =
			{
				PlayOnce = true,
				RequiredBossPhase = 1,
				RequiredTextLines = { "LordHadesR1FirstWin" },
				{ Cue = "/VO/HadesField_0032", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.35,
					Text = "...Your youth provides you with a certain mindless strength. But, such power has its limits." },
			},
			LordHadesNextStageMisc03 =
			{
				PlayOnce = true,
				RequiredBossPhase = 1,
				RequiredTextLines = { "LordHadesR1FirstWin" },
				{ Cue = "/VO/HadesField_0033", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.35,
					Text = "...Now that we had our little warm-up, it is time that we began in earnest." },
			},
			LordHadesNextStageMisc04 =
			{
				PlayOnce = true,
				RequiredBossPhase = 1,
				RequiredTextLines = { "LordHadesR1FirstWin" },
				{ Cue = "/VO/HadesField_0034", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.35,
					Text = "...You strike at your own father. What choice does that leave me." },
			},
			LordHadesNextStageMisc05 =
			{
				PlayOnce = true,
				RequiredBossPhase = 1,
				RequiredTextLines = { "LordHadesR1FirstWin" },
				{ Cue = "/VO/HadesField_0035", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.35,
					Text = "...{#DialogueItalicFormat}Hmph{#PreviousFormat}. All right, then, boy. You've stirred my anger suitably, by now." },
			},

			LordHadesFinalStage01 =
			{
				PlayOnce = true,
				RequiredBossPhase = 2,
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 4 },
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 5.5,
					-- Are you serious?
					{ Cue = "/VO/ZagreusField_1058" },
				},				
				{ Cue = "/VO/HadesField_0688", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#DialogueItalicFormat}Urgh{#PreviousFormat}... no... I'm... not... finished... with you... {#DialogueItalicFormat}yet{#PreviousFormat}!! " },
			},
		},

		BossPresentationNextStageRepeatableTextLineSets =
		{
			-- none on purpose
		},

		BossPresentationOutroTextLineSets =
		{
			--[[ (Early Access)
			LordHadesFirstDefeat =
			{
				PlayOnce = true,
				{ Cue = "/VO/HadesField_0011", Portrait = "Portrait_Hades_Helm_01",
					PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAnger", DoShake = true, WaitTime = 9.8 },
					Text = "I... how... you.... Go. Go, then. {#DialogueItalicFormat}Go{#PreviousFormat}!! Get out of here! Get out!" },
				{ Cue = "/VO/ZagreusField_2176", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I told you that I would, Father. And I'm going to. Goodbye." },
				{ Cue = "/VO/HadesField_0012", Portrait = "Portrait_Hades_Helm_01",
					PreLineWait = 0.35,
					Text = "...Wait. Wait, just... if you... if you find her. If you somehow find her? Tell her something for me, tell her... Tell her Cerberus is doing very well." },
				{ Cue = "/VO/ZagreusField_2177", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What? Wait. I don't think I owe you any favors, here. Though, answer me one question, and I'll give it some thought, how's that?" },
				{ Cue = "/VO/HadesField_0014", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.35,
					Text = "...I know your question, boy. But, ask it anyway." },
				{ Cue = "/VO/ZagreusField_2214", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
					Text = "Persephone. My mother. Why did she leave?" },
				{ Cue = "/VO/HadesField_0015", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.8 },
					Text = "...I... urgh... blood and darkness..." },
			},
			]]--

			-- Ending
			LordHadesDefeated01 =
			{
				PlayOnce = true,
				-- backwards compatibility edge case
				RequiredFalseTextLines = { "PersephoneFirstMeeting" },
				{ Cue = "/VO/HadesField_0011", Portrait = "Portrait_Hades_Helm_01",
					PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 9.3 },
					Text = "I... how... you.... Go. Go, then. {#DialogueItalicFormat}Go{#PreviousFormat}!! Get out of here! Get out!" },
				{ Cue = "/VO/ZagreusField_2176", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I told you that I would, Father. And I'm going to. Goodbye." },
				{ Cue = "/VO/HadesField_0012", Portrait = "Portrait_Hades_Helm_01",
					PreLineWait = 0.35,
					Text = "...Wait. Wait, just... if you... if you find her. If you somehow find her? Tell her something for me, tell her... Tell her Cerberus is doing very well." },
				{ Cue = "/VO/ZagreusField_2177", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What? Wait. I don't think I owe you any favors, here. Though, answer me one question, and I'll give it some thought, how's that?" },
				{ Cue = "/VO/HadesField_0014", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.35,
					Text = "...I know your question, boy. But, ask it anyway." },
				{ Cue = "/VO/ZagreusField_2214", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
					Text = "Persephone. My mother. Why did she leave?" },
				{ Cue = "/VO/HadesField_0015", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.8 },
					Text = "...I... {#DialogueItalicFormat}urgh{#PreviousFormat}... blood and darkness..." },
			},

			LordHadesDefeated02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "PersephoneFirstMeeting" },
				{ Cue = "/VO/ZagreusField_4324", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "You're not going to cooperate with me on this, are you? Even now, knowing Mother wants to see me again?" },
				{ Cue = "/VO/HadesField_0560", Portrait = "Portrait_Hades_Helm_01",
					PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#DialogueItalicFormat}Urgh{#PreviousFormat}! Blast you... you shall ruin everything... with all your damnable questions!" },
				{ Cue = "/VO/ZagreusField_4325", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenial_Full", PreLineAnimTarget = "Hero",
					Text = "Then, die, already. And get the hell out of my way." },
			},

			LordHadesChaosSurfaceQuestDefeat01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "ChaosSurfaceQuest01" },
				RequiredTrait = "ChaosBoonTrait",
				EndVoiceLines =
				{
					PreLineWait = 4.3,
					Source = { SubtitleColor = Color.ChaosVoice },
					NoTarget = true,

					-- <Laughter>
					{ Cue = "/VO/Chaos_0213" },
				},
				{ Cue = "/VO/HadesField_0403", Portrait = "Portrait_Hades_Helm_01",
					PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 2.3 },
					Text = "...Blast you, boy... we should have never sprung from Chaos... none of this..." },
			},
			LordHadesExtremeMeasuresDefeat01 =
			{
				PlayOnce = true,
				RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 4 },
				{ Cue = "/VO/HadesField_0624", Portrait = "Portrait_Hades_Helm_01",
					PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1 },
					Text = "{#DialogueItalicFormat}Urgh{#PreviousFormat}.... {#DialogueItalicFormat}<Gasp> {#PreviousFormat}How... I... I went all out! And still...?" },
			},
		},

		BossPresentationOutroRepeatableTextLineSets =
		{
			LordHadesMiscDefeat01 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0208", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "Blast you, boy. You think you are superior to me? You are a fool." },
			},
			LordHadesMiscDefeat02 =
			{
				{ Cue = "/VO/HadesField_0209", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.8 },
					Text = "{#DialogueItalicFormat}Urgh...! {#PreviousFormat}With your youth comes a certain strength, it seems." },
			},
			LordHadesMiscDefeat03 =
			{
				{ Cue = "/VO/HadesField_0210", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.8 },
					Text = "{#DialogueItalicFormat}Tsch... {#PreviousFormat}I... I shall see you back at home." },
			},
			LordHadesMiscDefeat04 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0211", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 3 },
					Text = "How? How is this possible, that this... {#DialogueItalicFormat}urgh!{#PreviousFormat}" },
			},
			LordHadesMiscDefeat05 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0212", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.6 },
					Text = "{#DialogueItalicFormat}Ungh... {#PreviousFormat}The world you seek out there... it's even crueler than the one you know." },
			},
			LordHadesMiscDefeat06 =
			{
				{ Cue = "/VO/HadesField_0213", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.5 },
					Text = "{#DialogueItalicFormat}Augh! {#PreviousFormat}Why... I was much stronger once, than this..." },
			},
			LordHadesMiscDefeat07 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0214", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.0 },
					Text = "{#DialogueItalicFormat}Aah, blast{#PreviousFormat}! That you of all my kin would be the one, to do this, to me...." },
			},
			LordHadesMiscDefeat08 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0215", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Mmph{#PreviousFormat}... No matter how many times you beat me... we're family. There's no escaping that." },
			},
			LordHadesMiscDefeat09 =
			{
				{ Cue = "/VO/HadesField_0247", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "Again, you have defeated me, somehow. And yet..." },
			},
			LordHadesMiscDefeat10 =
			{
				{ Cue = "/VO/HadesField_0248", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "What shall it take... what shall it take for you to..." },
			},
			LordHadesMiscDefeat11 =
			{
				{ Cue = "/VO/HadesField_0249", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Ungh, {#PreviousFormat}you... tell no one at the House. Do you hear me?" },
			},
			LordHadesMiscDefeat12 =
			{
				{ Cue = "/VO/HadesField_0250", Portrait = "Portrait_Hades_Helm_01",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Rrngh{#PreviousFormat}, you stubborn... you shrug off death as though it means nothing to you...!" },
			},
			LordHadesMiscDefeat13 =
			{
				{ Cue = "/VO/HadesField_0251", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "...I shall keep coming back... the same as you...!" },
			},
			LordHadesMiscDefeat14 =
			{
				{ Cue = "/VO/HadesField_0252", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "You... you think that you're the only one... who shall keep fighting?" },
			},
			LordHadesMiscDefeat15 =
			{
				{ Cue = "/VO/HadesField_0253", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "I must admit... you've learned something. At some point, in all this." },
			},
			LordHadesMiscDefeat16 =
			{
				RequiredKills = { Hades = 5 },
				RequiredOneOfTraits = GameData.AllSynergyTraits,
				{ Cue = "/VO/HadesField_0254", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Urgh{#PreviousFormat}... were it not for all my wretched kin upon Olympus, you..." },
			},

			LordHadesMiscDefeat17 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				RequiredOneOfTraits = GameData.AllSynergyTraits,
				{ Cue = "/VO/HadesField_0382", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Rngh{#PreviousFormat}, vanquished again... by my own fool kin...." },
			},
			LordHadesMiscDefeat18 =
			{
				{ Cue = "/VO/HadesField_0383", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Guh{#PreviousFormat}! Boy, you speak none of this, to anyone!" },
			},
			LordHadesMiscDefeat19 =
			{
				{ Cue = "/VO/HadesField_0384", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Urgh{#PreviousFormat}! How did... you accomplish this...?" },
			},
			LordHadesMiscDefeat20 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0385", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Nrgh{#PreviousFormat}! You cannot escape... none of us can." },
			},
			LordHadesMiscDefeat21 =
			{
				Priority = true,
				RequiredFalseTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0386", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Augh{#PreviousFormat}... then, go, see what awaits you in this realm..." },
			},
			LordHadesMiscDefeat22 =
			{
				{ Cue = "/VO/HadesField_0387", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Gah{#PreviousFormat}... I, fell to you, again, I... how...?" },
			},

			LordHadesMiscPostEndingDefeat01 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0498", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Gah{#PreviousFormat}... you have your mother's perseverance. How is it that you got this strong?" },
			},
			LordHadesMiscPostEndingDefeat02 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0499", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Urngh{#PreviousFormat}! It seems... I was no match for you, this time." },
			},
			LordHadesMiscPostEndingDefeat03 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0500", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Augh{#PreviousFormat}... I'm not as limber as I used to be, while you...?" },
			},
			LordHadesMiscPostEndingDefeat04 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0501", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Nngh{#PreviousFormat}... for a student of Achilles... I fear that you surpass even his skill, by now..." },
			},
			LordHadesMiscPostEndingDefeat05 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0502", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Umphh{#PreviousFormat}... you broke through every one of my defenses, once again..." },
			},
			LordHadesMiscPostEndingDefeat06 =
			{
				RequiredTextLines = { "Ending01" },
				{ Cue = "/VO/HadesField_0503", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Argh{#PreviousFormat}... you bested me, I'll grant you, Zagreus..." },
			},
			LordHadesMiscPostEndingDefeat07 =
			{
				RequiredTextLines = { "Ending01" },
				RequiredOneOfTraits = GameData.AllSynergyTraits,
				{ Cue = "/VO/HadesField_0504", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Ungh{#PreviousFormat}... Olympus gave you quite the edge against me, then..." },
			},
			LordHadesMiscPostEndingDefeat08 =
			{
				RequiredTextLines = { "Ending01" },
				RequiredOneOfTraits = GameData.AllSynergyTraits,
				{ Cue = "/VO/HadesField_0505", Portrait = "Portrait_Hades_Helm_01", PreLineWait = 0.3,
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 0.4 },
					Text = "{#DialogueItalicFormat}Grngh{#PreviousFormat}... you owe this victory to all your relatives..." },
			},
		},

		Binks =
		{
			"HadesBattleIdle_Bink",
			"HadesBattleIntro_Bink",
			"HadesBattleIntroIdle_Bink",
			"HadesBattleRun_Bink",
			"HadesBattleDash_Bink",
			"HadesBattleAttackSpin_Bink",
			"HadesBattleBidentFlurry_Bink",
			"HadesBattleAttackRange_Bink",
			"HadesBattleSpawn_Bink",
			"HadesBattleWrathTwo_Bink",
			"HadesBattleKnockDown_Bink",
			"HadesBattleInvisibility_Bink",
			"HadesBattleCastBeam_Bink",
			"HadesBattleAttackArcOne_Bink",
			"HadesBattleAttackArcTwo_Bink",
			"HadesDeathFullscreen",
			"HadesBattleKnockDownTwo_Bink",
			"HadesBattleDeath_Bink",
			"HadesBattleKnockDownRecover_Bink",

			"HadesBattleAttackSpin2_Bink",
			"HadesBattleBidentThrow_Bink",
			"HadesBattleBidentDashRecover_Bink",
			"HadesBattleHeal_Bink",
			"HadesBattleKnockDownPreRecover_Bink",

			"Cerberus_HadesAssistJumpIn_Bink",
			"Cerberus_HadesAssistRun_Bink",
			"Cerberus_HadesAssistJumpFromRun_Bink",
		},
	},
	-- ending
	NPC_Hades_Story_02 =
	{
		InheritFrom = { "Hades", "IsNeutral" },
		ActivateRequirements =
		{
			-- RequiredTrueFlags = { "HadesEndingFlag" },
			RequiredTextLines = { "PersephoneMeeting09" },
			RequiredFalseTextLines = { "PersephoneReturnsHome01" },
		},

		RequiredKill = false,

		IgnoreInvincibubbleOnHit = false,
		InvincibubbleScale = 2.0,
		InvulnerableHitSound = "/EmptyCue",
		InvulnerableVoiceLines =
		{
			--
		},
		RepulseOnMeleeInvulnerableHit = 250,
		OnHitVoiceLines =
		{
			PlayOnce = true,
			PlayOnceContext = "HadesMercyMeeting",
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			PlayFromTarget = true,
			CooldownTime = 8,

			-- Not this time.
			{ Cue = "/VO/HadesField_0416" },
			-- You cannot goad me this time.
			{ Cue = "/VO/HadesField_0417" },
			-- Do not keep her waiting.
			{ Cue = "/VO/HadesField_0418" },
			-- Go to her, I said.
			{ Cue = "/VO/HadesField_0419" },
			-- Enough of this.
			{ Cue = "/VO/HadesField_0420" },
		},

	},

	-- Boss Charon; Charon Fight; mapname = CharonFight01 -- Charon
	Charon =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy"},
		HealthBarTextId = "Charon_Full",
		AnimOffsetZ = 300,
		--SpawnAnimation = "HadesBattleIntroIdle",
		--AttachedAnimationName = "LaurelCindersSpawnerHades",

		AISetupDelay = 2.0,
		MaxHealth = 16500,

		Portrait = "Portrait_Charon_Default_01",
		Groups = { "GroundEnemies" },

		SpeechCooldownTime = 12,

		Material = "Organic",
		HealthBarOffsetY = -275,
		RepulseOnMeleeInvulnerableHit = 400,
		IgnoreInvincibubbleOnHit = true,
		--DeathAnimation = "HadesDeathFullscreen",
		--ClearChillOnDeath = true,
		--ManualDeathAnimation = true,
		--DestroyDelay = 1.0,
		--EndThreadWaitsOnDeath = "HadesSpawns",

		--CharmStartSound = "/SFX/Enemy Sounds/Hades/EmoteLaugh",

		DefaultAIData =
		{
		},

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		WeaponOptions =
		{
			-- "CharonMeleeCombom1",
			"CharonRadialPush", "CharonMeleeCombo2", "CharonMeleeStraight", "CharonMeleeBack",
			"CharonGhostChargeLeft", "CharonGhostChargeRight",
		},
		AIEndHealthThreshold = 0.66,
		AIStages =
		{
			-- Phase 1
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.66,
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "CharonTaunt",
				TransitionUnthreadedFunctionNames = { "RandomizeCover" },
				TransitionUnthreadedFunctionArgs = { { CoverOptions = { 490863, 490864, 490865, 490866, }, CoverCountMin = 2, CoverCountMax = 2, ShakeScreen = true, StartWait = 1.0, EndWait = 1.0 } },
				UnequipWeapons = { "CharonGhostChargeLeft", "CharonGhostChargeRight", },
				EquipRandomWeapon = { "CharonGhostChargeLeftAndRight", "CharonGhostChargeTopAndBot", "CharonGhostCharge360" },
				AIData =
				{
					AIEndHealthThreshold = 0.33,
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "BossStageTransition",
				TransitionAnimation = "CharonTaunt",
				TransitionUnthreadedFunctionNames = { "RandomizeCover" },
				TransitionUnthreadedFunctionArgs = { { CoverOptions = { 490863, 490864, 490865, 490866, }, CoverCountMin = 0, CoverCountMax = 0, ShakeScreen = true, StartWait = 1.0, EndWait = 1.0 } },
				EquipRandomWeapon = { "CharonGhostChargeLeftAndRight", "CharonGhostChargeTopAndBot", "CharonGhostCharge360" },
				AIData =
				{
					AIEndHealthThreshold = 0.11,
				},
			},
			{
				RandomAIFunctionNames = { "AttackerAI" },
				TransitionFunction = "CharonFightEndPresentation",
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
		},

		PlayerInjuredVoiceLineThreshold = 0.5,
		PlayerInjuredVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.75,
			SuccessiveChanceToPlay = 0.66,
			Cooldowns =
			{
				{ Name = "CharonAnyQuipSpeech" },
				{ Name = "CharonPlayerInjuredSpeech", Time = 40 },
			},

			-- Heehh...
			{ Cue = "/VO/Charon_0079" },
			-- Tsyehh...
			{ Cue = "/VO/Charon_0080" },
			-- Hrrnn...
			{ Cue = "/VO/Charon_0081" },
			-- Haah...
			{ Cue = "/VO/Charon_0082" },
			-- Krrr...
			{ Cue = "/VO/Charon_0083" },
			-- Kh,hh,hh...
			{ Cue = "/VO/Charon_0084" },
			-- Hah!
			{ Cue = "/VO/Charon_0085" },
			-- Hrn!
			{ Cue = "/VO/Charon_0086" },
			-- Hehh!
			{ Cue = "/VO/Charon_0087" },
		},
		LastStandReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 2.0,
			Queue = "Always",
			SuccessiveChanceToPlay = 0.66,
			Cooldowns =
			{
				{ Name = "CharonLastStandReactionSpeech", Time = 60 },
			},
			TriggerCooldowns = { "CharonAnyQuipSpeech" },

			-- Hoh...
			{ Cue = "/VO/Charon_0088" },
			-- Hrnn...
			{ Cue = "/VO/Charon_0089" },
			-- Khh...
			{ Cue = "/VO/Charon_0090" },
			-- Hhhh...
			{ Cue = "/VO/Charon_0091" },
			-- Phhh...
			{ Cue = "/VO/Charon_0092" },
		},
		WrathReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 1,
				SuccessiveChanceToPlayAll = 0.35,
				PlayOnceFromTableThisRun = true,
				TriggerCooldowns = { "CharonAnyQuipSpeech" },

				-- Hrrrnn!
				{ Cue = "/VO/Charon_0093" },
				-- Gaahhh!
				{ Cue = "/VO/Charon_0094" },
				-- Khhaaa!
				{ Cue = "/VO/Charon_0095" },
				-- Shehh!
				{ Cue = "/VO/Charon_0096" },
				-- Hohh...
				{ Cue = "/VO/Charon_0097" },
				-- Nraugh!
				{ Cue = "/VO/Charon_0098" },
			},
		},
		AssistReactionVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.8,
				SuccessiveChanceToPlay = 0.8,
				Queue = "Interrupt",
				RequiredTrait = "ThanatosAssistTrait",

				-- Hehh?
				{ Cue = "/VO/Charon_0054" },
				-- Hraugh!
				{ Cue = "/VO/Charon_0055" },
				-- Hrrngh?!
				{ Cue = "/VO/Charon_0069" },
				-- Haaah?!
				{ Cue = "/VO/Charon_0070" },
				-- Rraah!!
				{ Cue = "/VO/Charon_0071" },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.85,
				SuccessiveChanceToPlayAll = 0.35,
				PlayOnceFromTableThisRun = true,

				-- Ch'hehhh....
				{ Cue = "/VO/Charon_0056" },
				-- Hrnmm..
				{ Cue = "/VO/Charon_0057" },
				-- Krrr...
				{ Cue = "/VO/Charon_0058" },
				-- Nrrrhh...
				{ Cue = "/VO/Charon_0059" },
			},
		},

		CauseOfDeathVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.4,
				Queue = "Interrupt",
				NoTarget = true,
				SkipAnim = true,
				Source = { SubtitleColor = Color.CharonVoice },

				-- Hrreehhh, hehh....
				{ Cue = "/VO/Charon_0048" },
				-- Hrrooooaaauugghh...
				{ Cue = "/VO/Charon_0049" },
				-- Grraauugggh....
				{ Cue = "/VO/Charon_0050" },
				-- Hooaaaahh...!
				{ Cue = "/VO/Charon_0051" },
			},
		},

		InvulnerableHitSound = "/SFX/Enemy Sounds/Charon/EmoteHurt",
		InvulnerableVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			PlayFromTarget = true,
			ChanceToPlay = 0.25,
			Cooldowns =
			{
				{ Name = "CharonAnyQuipSpeech" },
			},

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
		LowHealthVoiceLineThreshold = 0.6,
		LowHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.35,
			Cooldowns =
			{
				{ Name = "CharonAnyQuipSpeech" },
			},

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- You hit me!
			-- { Cue = "/VO/Theseus_0166", },
		},
		CriticalHealthVoiceLineThreshold = 0.3,
		CriticalHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			Cooldowns =
			{
				{ Name = "CharonAnyQuipSpeech" },
			},
			PreLineWait = 0.35,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- You...
			-- { Cue = "/VO/HadesField_0102" },
		},
		-- DefeatedSound = "/SFX/Enemy Sounds/Hades/EmoteDying",
		EarlyExitVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.85,
				UsePlayerSource = true,

				-- Wait, did I win?
				{ Cue = "/VO/ZagreusField_3758" },
				-- Hah, got you there!
				{ Cue = "/VO/ZagreusField_3759", RequiredPlayed = { "/VO/ZagreusField_3758" }, PreLineWait = 0.1, },
				-- Whew, mate, you are tough!
				{ Cue = "/VO/ZagreusField_3760", RequiredPlayed = { "/VO/ZagreusField_3758" }, },
				-- Um, no hard feelings, right?
				{ Cue = "/VO/ZagreusField_3761", RequiredPlayed = { "/VO/ZagreusField_3758" }, },
				-- Oh, I was just getting warmed up!
				{ Cue = "/VO/ZagreusField_3762", RequiredPlayed = { "/VO/ZagreusField_3758" }, },
				-- Nice fighting to the death with you.
				{ Cue = "/VO/ZagreusField_3763", RequiredPlayed = { "/VO/ZagreusField_3758" }, },
				-- Good fight, mate.
				{ Cue = "/VO/ZagreusField_3764", RequiredPlayed = { "/VO/ZagreusField_3758" }, },
				-- You had me worried, mate.
				{ Cue = "/VO/ZagreusField_3765", RequiredPlayed = { "/VO/ZagreusField_3758" }, },
			},
			{
				RandomRemaining = true,
				Queue = "Interrupt",

				-- Hrraaauuggh!!
				{ Cue = "/VO/Charon_0100" },
				-- Hyyeeeh!
				{ Cue = "/VO/Charon_0101" },
				-- Nyaaaahh!
				{ Cue = "/VO/Charon_0102" },
				-- Hrrrnnn!
				{ Cue = "/VO/Charon_0103" },
				-- Hoh, hoohhh!
				{ Cue = "/VO/Charon_0104" },
				-- Rrrraauuggghhh....
				{ Cue = "/VO/Charon_0060" },
				-- Urrraaauuhggghh...
				{ Cue = "/VO/Charon_0061" },
				-- Hrrrnngaaaaugh!!
				{ Cue = "/VO/Charon_0062" },
				-- Krraaugghhh....
				{ Cue = "/VO/Charon_0063" },
			},
		},
		PostMatchTauntVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.3,

			-- <Snort>
			-- { Cue = "/VO/Minotaur_0182" },
		},

		BossPresentationPriorityIntroTextLineSets =
		{
			BossCharonAboutHermesQuest01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "HermesBeatCharonQuest01" },
				EndVoiceLines =
				{
					[1] = GlobalVoiceLines.CharonFightStartVoiceLines,
				},
				{ Cue = "/VO/Charon_0011",
					Text = "{#DialogueItalicFormat}Mmmrrrrnnn{#PreviousFormat}...." },
				{ Cue = "/VO/ZagreusField_3849", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "You know, Charon, your associate Hermes apparently had a wager with you that I could beat you twice in a row at some point? I'd hate to disappoint him, so... no hard feelings?" },
				{ Cue = "/VO/Charon_0038",
					PreLineAnim = "CharonTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartCharonBossRoomMusic",
					Text = "{#DialogueItalicFormat}Nnnrrrraaaaaauugggghhh{#PreviousFormat}!!" },
			},
		},
		BossPresentationIntroTextLineSets =
		{
			BossCharonEncounter01 =
			{
				PlayOnce = true,
				EndVoiceLines =
				{
					UsePlayerSource = true,
					PreLineWait = 1.3,
					RequiredMinElapsedTime = 4,
					-- Oh. It's because you're going to kill me.
					{ Cue = "/VO/ZagreusField_3749" },
				},
				{ Cue = "/VO/Charon_0010",
					Text = "{#DialogueItalicFormat}Haaahhhhh{#PreviousFormat}...." },
				{ Cue = "/VO/ZagreusField_3747", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#DialogueItalicFormat}Erm{#PreviousFormat}, Charon, look, I can explain. It's just, I've grown very accustomed to taking stuff throughout my father's realm. I wasn't stealing from you, honestly!" },
				{ Cue = "/VO/Charon_0038",
					PreLineAnim = "CharonTaunt",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 1.2 },
					Emote = "PortraitEmoteAnger",
					Text = "Mmnnn{#DialogueItalicFormat}rraaauuugggghhh{#PreviousFormat}!!" },
				{ Cue = "/VO/ZagreusField_3748", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineFunctionName = "StartCharonBossRoomMusic",
					Text = "That was not an understanding sound. Wait, why are you brandishing your oar in such a menacing way?" },
			},

			BossCharonEncounter02 =
			{
				PlayOnce = true,
				RequiredTextLines = { "BossCharonEncounter01" },
				EndVoiceLines =
				{
					[1] = GlobalVoiceLines.CharonFightStartVoiceLines,
				},
				{ Cue = "/VO/Charon_0010",
					Text = "{#DialogueItalicFormat}Haaahhhhh{#PreviousFormat}...." },
				{ Cue = "/VO/ZagreusField_3847", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "You're just testing me, here, right, Charon? I mean, when you place a huge sum of coin conspicuously within my reach, what do you expect me to do?" },
				{ Cue = "/VO/Charon_0040",
					Text = "Nrrnnhhh, hnnnn, hrrnn, {#DialogueItalicFormat}hrrrrrnnn{#PreviousFormat}..." },
				{ Cue = "/VO/ZagreusField_3848", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					PreLineFunctionName = "StartCharonBossRoomMusic",
					Text = "Sounds good, mate, when I rob you from now on it's just my way of saying {#DialogueItalicFormat}Charon, I would like to battle you to the death right now for a quick change of pace{#PreviousFormat}." },
			},

		},

		BossPresentationTextLineSets =
		{
			--
		},

		-- following are short misc repeatable evergreen combat start lines
		BossPresentationRepeatableTextLineSets =
		{
			-- other general cases
			BossCharonMiscStart01 =
			{
				EndVoiceLines =
				{
					[1] = GlobalVoiceLines.CharonFightStartVoiceLines,
				},
				{ Cue = "/VO/Charon_0045",
					PreLineAnim = "CharonTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartCharonBossRoomMusic",
					Text = "{#DialogueItalicFormat}Hrrrnnnggghh{#PreviousFormat}...." },
			},
			BossCharonMiscStart02 =
			{
				EndVoiceLines =
				{
					[1] = GlobalVoiceLines.CharonFightStartVoiceLines,
				},
				{ Cue = "/VO/Charon_0046",
					PreLineAnim = "CharonTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartCharonBossRoomMusic",
					Text = "{#DialogueItalicFormat}Grrnrnhh, rrraahhh{#PreviousFormat}!" },
			},
			BossCharonMiscStart03 =
			{
				EndVoiceLines =
				{
					[1] = GlobalVoiceLines.CharonFightStartVoiceLines,
				},
				{ Cue = "/VO/Charon_0047",
					PreLineAnim = "CharonTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartCharonBossRoomMusic",
					Text = "{#DialogueItalicFormat}Hrraaaahhhhhh{#PreviousFormat}!!" },
			},
			BossCharonMiscStart04 =
			{
				EndVoiceLines =
				{
					[1] = GlobalVoiceLines.CharonFightStartVoiceLines,
				},
				{ Cue = "/VO/Charon_0073",
					PreLineAnim = "CharonTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartCharonBossRoomMusic",
					Text = "Hrrn... {#DialogueItalicFormat}grrraaauuuggghh{#PreviousFormat}!!" },
			},
			BossCharonMiscStart05 =
			{
				EndVoiceLines =
				{
					[1] = GlobalVoiceLines.CharonFightStartVoiceLines,
				},
				{ Cue = "/VO/Charon_0074",
					PreLineAnim = "CharonTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartCharonBossRoomMusic",
					Text = "Rrnn... {#DialogueItalicFormat}hhrraaaauuuggghh{#PreviousFormat}!!" },
			},
			BossCharonMiscStart06 =
			{
				EndVoiceLines =
				{
					[1] = GlobalVoiceLines.CharonFightStartVoiceLines,
				},
				{ Cue = "/VO/Charon_0075",
					PreLineAnim = "CharonTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartCharonBossRoomMusic",
					Text = "Grrr... {#DialogueItalicFormat}nrrraauuuggghhh{#PreviousFormat}!!" },
			},
			BossCharonMiscStart07 =
			{
				EndVoiceLines =
				{
					[1] = GlobalVoiceLines.CharonFightStartVoiceLines,
				},
				{ Cue = "/VO/Charon_0076",
					PreLineAnim = "CharonTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartCharonBossRoomMusic",
					Text = "Urrh... {#DialogueItalicFormat}urraaauuuggghh{#PreviousFormat}!!" },
			},
			BossCharonMiscStart08 =
			{
				EndVoiceLines =
				{
					[1] = GlobalVoiceLines.CharonFightStartVoiceLines,
				},
				{ Cue = "/VO/Charon_0077",
					PreLineAnim = "CharonTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartCharonBossRoomMusic",
					Text = "Krrr... {#DialogueItalicFormat}krraauuuggghh{#PreviousFormat}!!" },
			},
			BossCharonMiscStart09 =
			{
				EndVoiceLines =
				{
					[1] = GlobalVoiceLines.CharonFightStartVoiceLines,
				},
				{ Cue = "/VO/Charon_0078",
					PreLineAnim = "CharonTaunt", PreLineWait = 0.35,
					PreLineFunctionName = "StartCharonBossRoomMusic",
					Text = "Hhh, {#DialogueItalicFormat}hrreehhhhh{#PreviousFormat}!!" },
			},

		},

		-- following are for when he ends the boss encounter
		BossPresentationOutroTextLineSets =
		{
			BossCharonOutro01 =
			{
				PlayOnce = true,
				{ Cue = "/VO/Charon_0099",
					PreLineThreadedFunctionName = "PowerWordPresentation", PreLineThreadedFunctionArgs = { WaitTime = 4.1 },
					Text = "Haahh, nrraugh, {#DialogueItalicFormat}haaaaah{#PreviousFormat}!!" },
			},

			BossCharonHermesQuestComplete01 =
			{
				PlayOnce = true,
				RequiredTextLines = { "HermesBeatCharonQuest01" },
				ConsecutiveClearsOfRoom = { Name = "CharonFight01", Count = 1 },
				{ Cue = "/VO/ZagreusField_3900", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
					PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
					PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Got you, mate! Twice in a row. I guess Hermes wins his little wager with you, then. You tell him I said {#DialogueItalicFormat}hrrrrrnnnggghh{#PreviousFormat}!" },
				{ Cue = "/VO/Charon_0019",
					Text = "{#DialogueItalicFormat}Hrrrrrnnnggghh{#PreviousFormat}..." },
			},

		},

		-- following are repeatable versions of the above
		BossPresentationOutroRepeatableTextLineSets =
		{
			--
		},

		Binks =
		{
			"CharonIdleBattle_Bink",
			"CharonMove_Bink",
			"CharonMeleeFront_Bink",
			"CharonMeleeFrontLRTI_Bink",
			"CharonMeleeBackSwing_Bink",
			"CharonCast_Bink",
			"CharonRadialPush_Bink",
			"CharonGhostCharge_Bink",
			"CharonTaunt_Bink",
		},
	},

	CharonGhostChargeSource =
	{
		PreAttackDuration = 0.0,
		FireDuration = 0.0,
		PostAttackDuration = 0.0,

		--PreAttackAnimation = "ArcherTrapPreAttack",
		--FireAnimation = "ArcherTrapIdle",
		--PostAttackAnimation = "ArcherTrapIdle",
		--PreAttackEndShake = true,

		SkipMovement = true,
		SkipAngleTowardTarget = true,

		TargetSelf = true,
		TargetOffsetForward = 100,

		AIOptions =
		{
		},

		WeaponOptions =
		{
			"CharonGhostCharge",
		},
	},

	-- Traps
	BaseTrap =
	{
		InheritFrom = { "IsNeutral" },
		NonHeroKillCombatText = "TrapKill",
		RequiredKill = false,
		AggroMinimumDistance = 500,
		StartAggroed = true,
		TriggersOnHitEffects = false,
		CanBeFrozen = false,
		HideHealthBar = true,
		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 20.0,
			},
		},
	},

	AthenaShield =
	{
		InheritFrom = { "IsNeutral" },
		RequiredKill = false,
		AlwaysTraitor = true,
		HideHealthBar = true,
		MeterMultiplier = 0,
		WeaponName = "AthenaShieldAuraBlast",
	},

	TrapPadDisabled =
	{
		InheritFrom = { "BaseTrap" },
	},

	TrapFissureDisabled =
	{
		InheritFrom = { "BaseTrap" },
	},

	HazardPoint =
	{
		InheritFrom = { "BaseTrap" },
	},

	SpikeTrap =
	{
		InheritFrom = { "BaseTrap" },

		PreAttackDuration = 0.2,
		PostAttackCooldown = 2.0,

		TargetGroups = { "GroundEnemies", "HeroTeam", "DestructibleGeo" },
		IdleAnimation = "SpikeTrapIdle",
		PreAttackAnimation = "SpikeTrapPreFire",
		PreAttackSound = "/SFX/SpikeTrapSetWithShake",
		PostAttackAnimation = "SpikeTrapPressed",
		ReloadingLoopSound = "/SFX/TrapSettingLoop",
		ReloadedSound = "/SFX/TrapSet",
		DisabledAnimation = "SpikeTrapDeactivated",

		Material = "MetalObstacle",

		WeaponOptions =
		{
			"SpikeTrapWeapon",
		},
		AIOptions =
		{
			AttackOnlyGroups,
		},
		AIAttackDistance = 100,
		AIResetDistance = 110,
		ToggleTrap = true,
	},

	AxeTrap =
	{
		InheritFrom = { "BaseTrap" },

		DefaultAIData =
		{
			PreAttackDuration = 0.3,
			PostAttackDuration = 1.0,
			PostAttackCooldown = 0.5,

			TargetGroups = { "GroundEnemies", "HeroTeam", "DestructibleGeo" },
			IdleAnimation = "AxeTrapReset",
			PreAttackAnimation = "AxeTrapActivated",
			PreAttackSound = "/SFX/SpikeTrapSetWithShake",
			ReloadingLoopSound = "/SFX/TrapSettingLoop",
			ReloadedSound = "/SFX/TrapSet",
			DisabledAnimation = "AxeTrapIdle",
			SkipAngleTowardTarget = true,

			AddUnitCollisionDuringAttack = true,
			AddProjectileCollisionDuringAttack = true,
		},

		Material = "MetalObstacle",

		WeaponOptions =
		{
			"AxeTrapWeapon",
		},
		ToggleTrap = true
	},

	AxeTrapTrigger =
	{
		InheritFrom = { "BaseTrap" },

		PreAttackDuration = 0.2,
		PostAttackCooldown = 2.0,

		TargetGroups = { "GroundEnemies", "HeroTeam" },
		LinkedEnemy = "DartTrapEmitter",
		IdleAnimation = "DartTrapIdle",
		PreAttackAnimation = "DartTrapPreFire",
		PreAttackSound = "/SFX/TrapSet",
		PostAttackAnimation = "DartTrapPressed",
		ReloadingLoopSound = "/SFX/TrapSettingLoop",
		ReloadedSound = "/Leftovers/Menu Sounds/TalismanMetalClankDown",
		SkipAngleTowardTarget = true,

		DisabledAnimation = "DartTrapDeactivated",

		WeaponOptions =
		{
			"AxeTrapWeapon",
		},
		AIOptions =
		{
			RemoteAttack,
		},
		AIAttackDistance = 100,
		AIResetDistance = 110,
		ToggleTrap = true
	},


	GasTrapPassive =
	{
		InheritFrom = { "BaseTrap" },

		IdleAnimation = "GasTrapActivated",
		PreAttackAnimation = "GasTrapActivated",
		DisabledAnimation = "TrapFissureDisabled",

		PreAttackDuration = 3.0,
		PostAttackCooldownMin = 15.0,
		PostAttackCooldownMax = 20.0,
		PreAttackColor = Color.White,

		WakeUpDelayMin = 5.0,
		WakeUpDelayMax = 15.0,

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },
		-- ReloadingLoopSound = "/SFX/TrapSettingLoop",
		-- ReloadedSound = "/SFX/TrapSet",
		PostAttackFlash = false,

		WeaponOptions =
		{
			"SmokeTrapWeapon",
		},
		AIOptions =
		{
			PassiveAttack,
		},
		TargetGroups = { "GroundEnemies", "HeroTeam" },
		AIAttackDistance = 100,
		AIResetDistance = 110,
		ToggleTrap = true,
	},

	PoisonTrap =
	{
		InheritFrom = { "BaseTrap" },

		IdleAnimation = "GasTrapPoisonIdle",
		PreAttackAnimation = "GasTrapPoisonActivated",
		DisabledAnimation = "GasTrapPoisonDisabled",

		PreAttackDuration = 1.5,
		PostAttackCooldown = 15.0,
		PreAttackColor = Color.White,

		WakeUpDelayMin = 5.0,
		WakeUpDelayMax = 15.0,

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },
		-- ReloadingLoopSound = "/SFX/TrapSettingLoop",
		-- ReloadedSound = "/SFX/TrapSet",
		PostAttackFlash = false,

		WeaponOptions =
		{
			"PoisonTrapWeapon",
		},
		AIOptions =
		{
			PassiveAttack,
		},
		TargetGroups = { "GroundEnemies", "HeroTeam" },
		ToggleTrap = true,
	},

	SpikeCube =
	{
		InheritFrom = { "BaseTrap" },

		PreAttackDuration = 0.01,
		PostAttackCooldown = 0.75,

		--RequiredVictimVelocity = 1000,
		Color = { 255, 0, 0, 255 },

		AttackWarningAnimation = "LobWarningDecal",
		AttackWarningAnimationRadius = 210,

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		Material = "MetalObstacle",

		WeaponOptions =
		{
			"SpikeWallWeapon",
		},
		AIOptions =
		{
			CollisionRetaliate,
		},
		ToggleTrap = true,
	},

	PhalanxTrap =
	{
		InheritFrom = { "BaseTrap" },

		DisabledAnimation = "PhalanxTrapDeactivated",

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		Material = "MetalObstacle",

		WeaponOptions =
		{
			"PhalanxTrapWeapon",
		},
		AIOptions =
		{
			AttackOnlyGroups,
		},
		SearchDistanceOffset = 120,
		AIAttackDistance = 100,
		AttackDistanceScaleY = 0.7,
		--AIResetDistance = 110,

		PreAttackFlash = true,
		--PreAttackFx = "RadialNovaReverse",
		PreAttackDuration = 0.5,
		FireDuration = 1.5,
		PostAttackCooldown = 2.0,
		PreAttackAnimation = "PhalanxTrapPreAttack",
		FireAnimation = "PhalanxTrapFire",
		PostAttackAnimation = "PhalanxTrapIdle",
		SkipAngleTowardTarget = true,
		GroupTrigger = true,

		ToggleTrap = true,
		IdleAnimation = "PhalanxTrapIdle",

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 5.0,
			},
		},
	},

	PhalanxTrapPassive =
	{
		InheritFrom = { "BaseTrap" },

		DisabledAnimation = "PhalanxTrapDeactivated",

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		Material = "MetalObstacle",

		PreAttackFx = "ShieldCharge",
		PreAttackEndShake = true,
		PreAttackFlashSound = "/Leftovers/SFX/AuraOnLoud",
		PreAttackAnimation = "PhalanxTrapPreAttack",
		FireAnimation = "PhalanxTrapFire",
		-- PostAttackAnimation = "PhalanxTrapIdle",
		PreAttackSound = "/SFX/TrapSet",
		ReloadedSound = "/Leftovers/Menu Sounds/TalismanMetalClankDown",

		SkipMovement = true,
		SkipAngleTowardTarget = true,
		PreAttackDuration = 0.6,
		PostAttackCooldown = 2.0,

		TargetSelf = true,
		TargetOffsetForward = 100,

		WeaponOptions =
		{
			"PhalanxTrapWeapon",
		},
		AIOptions =
		{
			PassiveAttack,
		},
		ToggleTrap = true,
	},

	BannerSupport =
	{
		InheritFrom = { "BaseTrap" },
		NonHeroKillCombatText = nil,

		PreAttackDuration = 0.1,
		FireDuration = 0,
		PostAttackDuration = 0.1,
		PostAttackCooldown = 0.0,

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },
		--ReloadedSound = "/Leftovers/Menu Sounds/TalismanMetalClankDown",

		AIAttackDistance = 9999,
		AIBufferDistance = 9999,


		Material = "MetalObstacle",

		WeaponOptions =
		{
			"MoveSpeedAoE",
		},
		AIOptions =
		{
			AttackerAI,
		},
		ToggleTrap = true,
	},

	BlastCubeFused =
	{
		InheritFrom = { "BaseTrap" },

		MaxHealth = 9999,
		SkipDamageText = true,
		HideHealthBar = true,
		HideLevelDisplay = true,

		FlashOnFuse = true,
		FuseDuration = 1.5,
		FuseAnimation = "BlastCubeLit",
		FuseWarningAnimation = "BlastWarningDecal",
		FuseWarningWeapon = "BlastCubeExplosion",

		OnDeathShakeScreenSpeed = 350,
		OnDeathShakeScreenDistance = 8,
		OnDeathShakeScreenDuration = 0.65,
		OnDeathShakeScreenFalloff = 1500,

		OnDamagedFunctionName = "ActivateFuse",

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 50,
			},
		},
	},

	GunBombUnit =
	{
		InheritFrom = { "BaseTrap" },

		MaxHealth = 9999,
		FlashOnFuse = true,
		FuseDuration = 0.2,
		OnDamagedFunctionName = "ActivateLuciferFuse",
		FuseActivationSound = "/Leftovers/SFX/CurSprint",
		--FuseAnimation = "BlastCubeLit",
		CanStoreAmmo = false,
		OnHitShake = { Distance = 3, Speed = 600, Duration = 0.15 },


		OnDeathShakeScreenSpeed = 150,
		OnDeathShakeScreenDistance = 4,
		OnDeathShakeScreenDuration = 0.25,
		OnDeathShakeScreenFalloff = 1500,

		AlwaysTraitor = true,
		OnDeathFunctionName = "GunBombDetonate",

		AdditionalEnemySetupFunctionName = "SetUpGunBombImmolation",
		ImmolationInterval = 1.0,
		IncomingDamageModifiers =
		{
			{
				Name = "ImmolationImmunity",
				ValidWeapons = {"GunBombImmolation"},
				ValidWeaponMultiplier = 0,
				Multiplicative = true,
			},
		},
	},
	BlastCubeFusedRegenerating =
	{
		InheritFrom = { "BaseTrap" },

		SkipDamageText = true,
		HideHealthBar = true,
		HideLevelDisplay = true,

		FlashOnFuse = true,
		FuseDuration = 2.0,
		FuseAnimation = "BlastCubeFusedRegeneratingLit",
		FuseWarningAnimation = "BlastWarningDecal",
		FuseWarningWeapon = "BlastCubeExplosionElysium",
		PostFuseWeapon = "BlastCubeExplosionElysium",
		FuseDormantDuration = 6.0,
		PostFuseRevive = true,
		PostFuseReviveAnimation = "BlastCubeFusedRegeneratingOnSpawn",

		OnDeathShakeScreenSpeed = 350,
		OnDeathShakeScreenDistance = 8,
		OnDeathShakeScreenDuration = 0.65,
		OnDeathShakeScreenFalloff = 1500,

		OnHitFunctionName = "ActivateFuse",

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 33.33,
			},
		},
	},

	BloodMine =
	{
		InheritFrom = { "BaseTrap" },
		UseShrineUpgrades = true,
		SkipDamageText = true,
		HideHealthBar = true,
		HideLevelDisplay = true,
		DamageType = "Enemy",

		ActivateFuseIfNoSpawner = true,
		FuseWarningAnimation = "BlastWarningDecal",

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		OnDamagedFunctionName = "ActivateFuse",

		AIOptions =
		{
			MineAI,
		},
		AIAttackDistance = 100,

		FuseAnimation = "BloodMineActivated",
		FuseWarningWeapon = "BloodMineBlast",
		FlashOnFuse = true,
		FuseDuration = 1.0,
		TriggerDistance = 225,
		WakeUpDelay = 1.5,
		ExpirationDuration = 15.0,

		CleanupAnimation = "Blank",
		OutgoingDamageModifiers =
		{
			{
				Name = "FriendImmunity",
				FriendMultiplier = 0,
			},
		},
	},

	ImpulseMine =
	{
		InheritFrom = { "BaseTrap" },
		UseShrineUpgrades = true,
		SkipDamageText = true,
		HideHealthBar = true,
		HideLevelDisplay = true,

		ActivateFuseIfNoSpawner = true,
		FuseWarningAnimation = "BlastWarningDecal",

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		OnDamagedFunctionName = "ActivateFuse",

		AIOptions =
		{
			MineAI,
		},
		AIAttackDistance = 100,

		FuseAnimation = "ImpulseMineActivated",
		FuseWarningWeapon = "ImpulseMineBlast",
		FlashOnFuse = true,
		FuseDuration = 1.0,
		TriggerDistance = 50,
		WakeUpDelay = 1.5,
		ExpirationDuration = 10.0,
	},

	AliceTestEnemy =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		Material = "MetalObstacle",

		AggroIfLastAlive = true,
		PreAttackDuration = 0.5,
		FireDuration = 0.1,
		PostAttackDuration = 0.5,

		AIRequireProjectileLineOfSight = false,
		AIRequireUnitLineOfSight = false,
		AILineOfSightBuffer = 80,
		AIAngleTowardsPlayerWhileFiring = false,
		AITrackTargetDuringCharge = false,

		WeaponOptions =
		{
			"BaseAliceWeapon",
			"BaseAliceLaser",
		},

		DefaultAIData =
		{
			PreAttackSound = "/SFX/Enemy Sounds/Brimstone/CrystalTargetAcquired",
			PreAttackEndShake = true,
		},
		AIOptions =
		{
			AliceTestAI,
		},
	},

	BaseBreakable =
	{
		InheritFrom = { "IsNeutral" },
		GenusName = "Breakable",
		MaxHealth = 1,
		HideHealthBar = true,
		HideLevelDisplay = true,
		SkipDamageText = true,
		RequiredKill = false,
		CanBeFrozen = false,
		OnKillGlobalVoiceLines = "BreakableDestroyedVoiceLines",
		KillsRequiredForVoiceLines = 2,
		MeterMultiplier = 0,

		CollisionReaction =
		{
			MinVelocity = 1000,
			KillSelf = true,
		}
	},

	Breakable =
	{
		InheritFrom = { "BaseBreakable" },

		AmmoDropOnDeath =
		{
			Chance = 0.03,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},

		ValueOptions =
        {
			{
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 15, MaxValue = 15, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableHighValueIdleSuper",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
				},
				GameStateRequirements =
				{
					RequiredCosmetics = { "BreakableValue3", },
				},
            },
			{
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 10, MaxValue = 10, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableHighValueIdle",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
				},
				GameStateRequirements =
				{
					RequiredCosmetics = { "BreakableValue2", },
					RequiredFalseCosmetics = { "BreakableValue3", },
				},
            },
			{
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 5, MaxValue = 5, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableHighValueIdle",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
				},
				GameStateRequirements =
				{
					RequiredCosmetics = { "BreakableValue1", },
					RequiredFalseCosmetics = { "BreakableValue2", },
				},
            },
        },
	},

	BreakableAsphodel =
	{
		InheritFrom = { "BaseBreakable" },

		AmmoDropOnDeath =
		{
			Chance = 0.03,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},

		ValueOptions =
        {
			{
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 15, MaxValue = 15, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableAsphodelHighValueIdleSuper",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
				},
				GameStateRequirements =
				{
					RequiredCosmetics = { "BreakableValue3", },
				},
            },
			{
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 10, MaxValue = 10, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableAsphodelHighValueIdle",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
				},
				OffsetY = 28,
				GameStateRequirements =
				{
					RequiredCosmetics = { "BreakableValue2", },
					RequiredFalseCosmetics = { "BreakableValue3", },
				},
            },
			{
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 5, MaxValue = 5, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableAsphodelHighValueIdle",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
				},
				OffsetY = 28,
				GameStateRequirements =
				{
					RequiredCosmetics = { "BreakableValue1", },
					RequiredFalseCosmetics = { "BreakableValue2", },
				},
            },
        },
	},

	BreakableAsphodelHeal =
	{
		InheritFrom = { "BaseBreakable" },

		HealDropOnDeath =
		{
			Chance = 1.0,
			Name = "HealDropMinor",
			Radius = 50,
		},
	},

	BreakableElysium =
	{
		InheritFrom = { "BaseBreakable" },

		AmmoDropOnDeath =
		{
			Chance = 0.03,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},

		ValueOptions =
        {
			{
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 15, MaxValue = 15, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableElysiumHighValueIdleSuper",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
				},
				GameStateRequirements =
				{
					RequiredCosmetics = { "BreakableValue3", },
				},
            },
			{
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 10, MaxValue = 10, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableElysiumHighValueIdle",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
				},
				OffsetY = 28,
				GameStateRequirements =
				{
					RequiredCosmetics = { "BreakableValue2", },
					RequiredFalseCosmetics = { "BreakableValue3", },
				},
            },
			{
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 5, MaxValue = 5, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableElysiumHighValueIdle",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
				},
				OffsetY = 28,
				GameStateRequirements =
				{
					RequiredCosmetics = { "BreakableValue1", },
					RequiredFalseCosmetics = { "BreakableValue2", },
				},
            },
        },
	},

	BreakableStyx =
	{
		InheritFrom = { "BaseBreakable" },

		AmmoDropOnDeath =
		{
			Chance = 0.03,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},

		ValueOptions =
        {
			{
                Chance = 0.20,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 15, MaxValue = 15, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableStyxHighValueIdleSuper",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
				},
				GameStateRequirements =
				{
					RequiredCosmetics = { "BreakableValue3", },
				},
            },
			{
                Chance = 0.20,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 10, MaxValue = 10, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableStyxHighValueIdle",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
				},
				OffsetY = 28,
				GameStateRequirements =
				{
					RequiredCosmetics = { "BreakableValue2", },
					RequiredFalseCosmetics = { "BreakableValue3", },
				},
            },
			{
                Chance = 0.20,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 5, MaxValue = 5, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableStyxHighValueIdle",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
				},
				OffsetY = 28,
				GameStateRequirements =
				{
					RequiredCosmetics = { "BreakableValue1", },
					RequiredFalseCosmetics = { "BreakableValue2", },
				},
            },
        },
	},

	BreakableHighValue =
	{
		InheritFrom = { "Breakable" },

		MoneyDropOnDeath =
		{
			Chance = 1.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 10,
			MaxValue = 10,
		},

		OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
		KillsRequiredForVoiceLines = 1,
	},

	ReflectiveMirror =
	{
		InheritFrom = { "BaseBreakable" },

		MaxHealth = 9999,
		SkipDamageText = true,
		HideHealthBar = true,
		HideLevelDisplay = true,

		RetailiateOnce = true,
		OnDamagedFunctionName = "RetaliateAttack",
		PreAttackAnimation = "ReflectiveMirrorTriggered",
		PreAttackDuration = 0.3,
		FireFunctionName = "ActivateFuse",

		FuseDuration = 0.6,
		RespawnOnDeath = true,
		RespawnDelay = 4.0,

		WeaponOptions = { "ReflectiveMirrorWeapon" },

		AmmoDropOnDeath =
		{
			Chance = 0.03,
			MinAmmo = 1,
			MaxAmmo = 1,
		},

		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},
	},

	DartTrap =
	{
		InheritFrom = { "BaseTrap" },

		PreAttackDuration = 0.2,
		PostAttackCooldown = 2.0,

		TargetGroups = { "GroundEnemies", "HeroTeam" },
		LinkedEnemy = "DartTrapEmitter",
		IdleAnimation = "DartTrapIdle",
		PreAttackAnimation = "DartTrapPreFire",
		PreAttackSound = "/SFX/TrapSet",
		PostAttackAnimation = "DartTrapPressed",
		ReloadingLoopSound = "/SFX/TrapSettingLoop",
		ReloadedSound = "/Leftovers/Menu Sounds/TalismanMetalClankDown",

		DisabledAnimation = "DartTrapDeactivated",

		AIOptions =
		{
			RemoteAttack,
		},
		AIAttackDistance = 100,
		AIResetDistance = 110,
		MaxVictimZ = 1,
		ToggleTrap = true,
	},

	DartTrapEmitter =
	{
		InheritFrom = { "IsNeutral" },
		Type = "Trap",
		TriggersOnHitEffects = false,

		PreAttackAnimation = "DartTrapEmitterFire",
		PostAttackAnimation = "DartTrapEmitterReturnToIdle",

		PreAttackDuration = 0.0,
		PostAttackDuration = 0.0,

		AIFireTicksMin = 3,
		AIFireTicksMax = 3,
		AIFireTicksCooldown = 0.15,
		AITrackTargetDuringCharge = false,

		Material = "MetalObstacle",

		WeaponOptions =
		{
			"DartTrapWeapon",
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 33.33,
			},
		},
	},

	ArcherTrap =
	{
		InheritFrom = { "BaseTrap" },

		DisabledAnimation = "ArcherTrapDeactivated",

		PreAttackDuration = 2.0,
		FireDuration = 0.3,
		PostAttackDuration = 0.5,
		PostAttackCooldown = 3.0,

		PreAttackAnimation = "ArcherTrapPreAttack",
		FireAnimation = "ArcherTrapIdle",
		PostAttackAnimation = "ArcherTrapIdle",
		ReloadingLoopSound = "/SFX/TrapSettingLoop",
		ReloadedSound = "/SFX/ArcherTrapReloaded",
		PreAttackEndShake = true,

		SkipMovement = true,
		SkipAngleTowardTarget = true,

		TargetSelf = true,
		TargetOffsetForward = 100,

		AIOptions =
		{
			PassiveAttack,
		},

		WeaponOptions =
		{
			"ArcherTrapWeapon",
		},
		ToggleTrap = true,
		IdleAnimation = "ArcherTrapIdle",

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 30,
			},
		},
	},

	PassiveRoomWeapon =
	{
		InheritFrom = { "IsNeutral" },
		DamageType = "Enemy",
		RequiredKill = false,
		HideHealthBar = true,

		WakeUpDelay = 3.0,

		DefaultAIData =
		{
			DeepInheritance = true,

			SkipMovement = true,
			SkipAngleTowardTarget = true,
		},

		AIOptions =
		{
			AttackerAI,
		},
	},

	ZeusUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 2.5,
			PostAttackCooldownMax = 3.5,
			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 0,
			TargetOffsetDistanceMax = 230,
			TeleportToTargetId = true,

			AIFireTicksMin = 6,
			AIFireTicksMax = 10,
			FireCooldown = 0.2,
			ResetTargetPerTick = true,
		},

		WeaponOptions =
		{
			"DevotionZeus",
		},
	},

	DionysusUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 0.9,
			PostAttackCooldownMax = 1.2,
			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 150,
			TargetOffsetDistanceMax = 350,
			TeleportToTargetId = true,
		},

		WeaponOptions =
		{
			"DevotionDionysus",
		},
	},

	DemeterUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 2.0,
			PreAttackFx = "DevotionPreAttackBase_Demeter",
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 3.0,
			PostAttackCooldownMax = 3.5,
			TeleportToTargetId = true,

			TargetSpawnPoints = true,
			TargetSpawnPointsPlayerRadius = 900,
		},

		WeaponOptions =
		{
			"DevotionDemeter",
		},
	},

	AresUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 1.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 2.5,
			PostAttackCooldownMax = 3.5,
			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = -50,
			TargetOffsetDistanceMax = 50,
			TeleportToTargetId = true,

			AIFireTicksMin = 4,
			AIFireTicksMax = 4,
			FireCooldown = 0.3,
		},

		WeaponOptions =
		{
			"DevotionAres",
		},
	},

	ArtemisUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.3,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 2.5,
			PostAttackCooldownMax = 2.8,
			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 200,
			TargetOffsetDistanceMax = 300,
			TeleportToTargetId = true,

			AIFireTicksMin = 7,
			AIFireTicksMax = 9,
			FireCooldown = 0.3,
			ResetTargetPerTick = true,
		},

		WeaponOptions =
		{
			"DevotionArtemis",
		},
	},

	AphroditeUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.0,
			PreFireAnimation = "DevotionPreAttackBase_Aphrodite",
			PreFireDuration = 2.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 2.5,
			PostAttackCooldownMax = 3.5,
			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 250,
			TargetOffsetDistanceMax = 350,
			TeleportToTargetId = true,

			FireTicks = 1,
			FireCooldown = 0.0,
		},

		WeaponOptions =
		{
			"DevotionAphrodite",
		},
	},

	AthenaUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 6.5,
			PostAttackCooldownMax = 7.5,
			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 0,
			TargetOffsetDistanceMax = 0,
			TeleportToTargetId = true,
			TargetFriends = true,
		},

		WeaponOptions =
		{
			"DevotionAthena",
		},
	},

	PoseidonUpgradeRoomWeapon =
	{
		InheritFrom = { "PassiveRoomWeapon" },

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 1.0,
			PreAttackFx = "DevotionPreAttackBase_Poseidon",
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 8.5,
			PostAttackCooldownMax = 9.5,
			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 300,
			TargetOffsetDistanceMax = 1000,
			TeleportToTargetId = true,
		},

		WeaponOptions =
		{
			"DevotionPoseidon",
		},
	},

	SawTrap =
	{
		InheritFrom = { "BaseTrap" },

		DisabledAnimation = "SawTrapDeactivated",

		PreAttackDuration = 0.5,
		FireDuration = 0.3,
		PostAttackDuration = 0.5,
		PostAttackCooldown = 2.5,

		PreAttackAnimation = "SawTrapPreAttack",
		FireAnimation = "SawTrapFire",
		ReloadingLoopSound = "/SFX/TrapSettingLoop",
		ReloadedSound = "/SFX/ArcherTrapReloaded",

		SkipMovement = true,
		SkipAngleTowardTarget = true,

		TargetSelf = true,
		TargetOffsetForward = 100,

		AIOptions =
		{
			PassiveAttack,
		},

		WeaponOptions =
		{
			"SawTrapWeapon",
		},
		ToggleTrap = true,
		IdleAnimation = "SawTrapIdle",


		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 30,
			},
		},
	},

	LavaSplash =
	{
		InheritFrom = { "BaseTrap" },
		NonHeroKillCombatText = nil,
		PreAttackDuration = 4.0,
		PostAttackCooldown = 2.0,
		PreAttackColor = Color.Red,
		AITrackTargetDuringCharge = true,

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },
		--PreAttackSound = "/SFX/TrapSet",
		--ReloadingLoopSound = "/SFX/TrapSettingLoop",
		ReloadedSound = "/Leftovers/Menu Sounds/TalismanMetalClankDown",

		NonHeroKillCombatText = "LavaKill",

		WeaponOptions =
		{
			"LavaSplash",
		},
		AIOptions =
		{
			AttackAndDie,
		},
		DestroyOnTrapDisable = true,
	},

	LavaTile =
	{
		InheritFrom = { "BaseTrap" },
		NonHeroKillCombatText = nil,
		TriggersOnHitEffects = false,
		PreAttackDuration = 0.0,
		PostAttackCooldown = 0.01,

		--AttackWarningAnimation = "DamagePreviewSpikeTrap",
		--AttackWarningAnimationRadius = 210,
		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },
		--IdleAnimation = "SpikeTrapIdle",
		--PreAttackAnimation = "SpikeTrapPreFire",
		-- PreAttackSound = "/SFX/SpikeTrapSetWithShake",
		--PostAttackAnimation = "SpikeTrapPressed",
		-- ReloadingLoopSound = "/SFX/TrapSettingLoop",
		-- ReloadedSound = "/SFX/TrapSet",
		DefaultAIData =
		{
			PointOnlyCollision = true,
		},

		NonHeroKillCombatText = "LavaKill",

		WeaponOptions =
		{
			"LavaTileWeapon",
		},
		AIOptions =
		{
			FireAndQuit,
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 5,
			},
		},
	},

	LavaTileTriangle01 =
	{
		InheritFrom = { "LavaTile" },
		WeaponOptions =
		{
			"LavaTileTriangle01Weapon",
		},
	},

	LavaTileTriangle02 =
	{
		InheritFrom = { "LavaTile" },
		WeaponOptions =
		{
			"LavaTileTriangle02Weapon",
		},
	},

	TestCharacter =
	{
		MaxHealth = 460,
		HealthBarOffsetY = -230,

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/HeavyMelee/EmoteAlerted",

		AIOptions =
		{
			AggroAI,
		},
		AIAggroRange = 900,

		WeaponOptions =
		{
			"SatyrRangedWeapon",
		},

		Material = "Bone",

		PreAttackSound = "/SFX/Enemy Sounds/HeavyMelee/EmoteCharging",

		PreAttackAnimation = "SatyrRangedAttack_Start",
		PreAttackDuration = 0.4,
		PreFireAnimation = "SatyrRangedAttack_ChargeLoop",
		PreFireDuration = 0.3,
		FireAnimation = "SatyrRangedAttack_Fire",
		FireDuration = 0.9,
		PostAttackAnimation = "SatyrRangedAttack_ReturnToIdle",
		PostAttackDuration = 1.5,
		PreAttackCancelSound = "/Leftovers/SFX/ImpRef02_GoDown",
		PreAttackEndShake = true,
		PreAttackEndShakeSound = "/Leftovers/SFX/SprintChargeUp",

		AIAttackDistance = 200,
		AIBufferDistance = 150,
		AITrackTargetDuringCharge = false,
		AIRequireUnitLineOfSight = true,

		WeaponOptions =
		{
			"SatyrRangedWeapon",
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Enemies )

StatusAnimations =
{
	WantsToTalk = "StatusIconWantsToTalk",
	Speaking = "StatusIconSpeaking",
	Charmed = "StatusIconNPCCharmed"
}