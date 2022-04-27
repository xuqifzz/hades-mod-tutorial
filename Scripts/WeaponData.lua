
WeaponData =
{
	BaseUnlockableWeapon =
	{
		UsePromptOffsetX = 64,
		UsePromptOffsetY = -64,
		StartingWeapon = true,
		ResourceName = "LockKeys",
		UnlockCost = 1,

		UnlockUseText = "UseWeaponKit_LockedHasKey",
		LockedUseText = "UseWeaponKit_LockedNoKey",
	},

	RangedWeapon =
	{
		UpgradeChoiceText = "UpgradeChoiceMenu_Ranged",

		--ChargeCameraMotion = { ZoomType = "Overshoot", Fraction = 1.04, Duration = 0.22 },
		--FireCameraMotion = { ZoomType = "Ease", Fraction = 1.0, Duration = 0.1 },
		--HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.05, FalloffSpeed = 3000 },

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.17, Duration = 0.17 },
		},

		StoreAmmoOnHit = 1,
		AmmoDropDelay = 16,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 10,

		NotReadySound = "/Leftovers/SFX/OutOfAmmo2",
		NotReadyText = "OutOfAmmo_Alt",
		NoAmmoFunctionName = "RangedFailedNoAmmoPresentation",
		NotReadyAmmoPackText = "RetrieveAmmo",
		NotReadyAmmoInEnemyText = "RetrieveAmmoFromEnemy",
		NotReadyPulseStoredAmmo = true,
		--SkipAttackNotReadySounds = true,

		Sounds =
		{
			ChargeSounds =
			{
				{
					Name = "/Leftovers/SFX/AuraCharge",
					StoppedBy = { "ChargeCancel", "Fired" }
				}
			},
			FireSounds =
			{
				{
					-- StoppedBy = { "SpeechFromCue" }
				},
			},

			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Brick = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Stone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				StoneObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BrickObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				MetalObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				BushObstacle = "/SFX/Player Sounds/ZagreusBloodshotImpact",
			},
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},

		Binks =
		{
			"ZagreusRangedWeapon_Bink"
		},
		SelfMultiplier = 0,
	},

	GunWeapon =
	{
		InheritFrom = { "BaseUnlockableWeapon", },
		EquippedKitAnimation = "WeaponGunFloatingIdleOff",
		UnequippedKitAnimation = "WeaponGunFloatingIdle",
		BonusUnequippedKitAnimation = "WeaponGunFloatingIdleBonus",
		BonusEquippedKitAnimation = "WeaponGunFloatingIdleOffBonus",
		FirstTimeEquipAnimation = "ZagreusGunReloadStart",
		UpgradeChoiceText = "UpgradeChoiceMenu_Melee",
		ShortName = "GunWeapon_Short",
		UnlockName = "GunWeapon_Unlock",
		DashWeapon = "GunWeaponDash",
		SecondaryWeapon = "GunGrenadeToss",
		NoAmmoFireSound = "/EmptyCue",
		-- this is so NotReadyVoiceLines don't conflict with custom VO
		SkipAttackNotReadySounds = true,
		--ExpireDashWeaponOnDash = true,
		ResourceName = "LockKeys",
		UnlockCost = 8,
		PostWeaponUpgradeScreenAnimation = "ZagreusGunReloadEnd",
		PostWeaponUpgradeScreenAngle = 210,

		GameStateRequirements =
		{
			RequiredTrueFlags = { "GunUnlocked" },
		},

		KitInteractFunctionName = "WeaponKitSpecialInteractPresentation",
		KitInteractSpecialUnlockSound = "/Leftovers/Menu Sounds/EmoteAscendedLuciferChoir",
		KitInteractSpecialUnlockSound2 = "/SFX/Player Sounds/ZagreusLuciferUnlock2",
		KitInteractGameStateRequirements =
		{
			RequiredTextLines = { "ZeusRevealsLuciferAspect01" },
			-- Exagryph: I see your prideful fall down from the heavens to the flames!
			RequiredFalsePlayed = { "/VO/ZagreusHome_2653", },
		},

		--FireScreenshake = { Distance = 2, Speed = 300, FalloffSpeed = 0, Duration = 0.1, Angle = 90 },

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 1,

		ReloadDelay = 0.2,
		ActiveReloadTime = 0.75,
		IdleReloadAnimation = "ZagreusGunReloadStart",
		MovingReloadAnimation = "ZagreusGunRunReload",

		OutOfAmmoFunctionName = "GunOutOfAmmoPresentation",
		NoAmmoFunctionName = "GunFailedNoAmmoPresentation",
		LowAmmoSoundThreshold = 5,

		NoAmmoText = "GunReloadingStart",

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.3, Duration = 0.06 },
		},

		EquipVoiceLines =
		{
			{
				Cooldowns =
				{
					{ Name = "ZagreusWeaponEquipSpeech", Time = 40 },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.35,

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						-- None
					},

					-- Exagryph, the Rail of Adamant; annihilate all who oppose me.
					{ Cue = "/VO/ZagreusField_1259", PlayOnce = true },
					-- Exagryph, the Adamant Rail; come turn my foes to ash.
					-- { Cue = "/VO/ZagreusField_1258", PlayOnce = true },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.35,
					SuccessiveChanceToPlay = 0.33,
					TriggerCooldowns = { "ZagreusMiscWeaponEquipSpeech", },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						-- None
					},

					-- I need the rail.
					{ Cue = "/VO/ZagreusField_1260", GameStateRequirements = { RequiredPlayed = "/VO/ZagreusField_1259" }, },
					-- Ready, Exagryph?
					{ Cue = "/VO/ZagreusField_1261", GameStateRequirements = { RequiredPlayed = "/VO/ZagreusField_1259" }, },
				},
				[3] = GlobalVoiceLines.MiscWeaponEquipVoiceLines,
			},
			[2] = GlobalVoiceLines.SkellyWeaponEquipReactionVoiceLines,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteCharging_Bow" },
				{ Name = "/SFX/Player Sounds/ZagreusGunFire" },
			},
			LowAmmoFireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunFire" },
				{ Name = "/SFX/Player Sounds/ZagreusGunReloadCompleteFlash" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/GunBulletOrganicImpact",
				StoneObstacle = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/ArrowWallHitClankSmall",
				MetalObstacle = "/SFX/ArrowWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		WeaponBinks =
		{
			"ZagreusGun_Bink",
			"ZagreusGunGrenadeToss_Bink",
			"ZagreusGunFireEmpty_Bink",
			"ZagreusGunRun_Bink",
			"ZagreusGunStop_Bink",
		},
	},

	GunWeaponDash =
	{
		InheritFrom = { "GunWeapon" },
		DashWeapon = nil,

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteCharging_Bow" },
				{ Name = "/SFX/Player Sounds/ZagreusGunFire" },
			},
			LowAmmoFireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunFire" },
				{ Name = "/SFX/Player Sounds/ZagreusGunReloadCompleteFlash" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/GunBulletOrganicImpact",
				StoneObstacle = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/ArrowWallHitClankSmall",
				MetalObstacle = "/SFX/ArrowWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

	},

	ManualReloadEffectApplicator =
	{
		CompleteObjectivesOnFire = { "ManualReload" },
	},

	SniperGunWeapon =
	{
		InheritFrom = { "GunWeapon" },
		DashWeapon = nil,
		OnFiredFunctionName = "ClearManualReloadVFX",
	},

	SniperGunWeaponDash =
	{
		InheritFrom = { "SniperGunWeapon" },
		DashWeapon = SniperGunWeaponDash,
	},

	ChargeBowWeapon1 =
	{
		InheritFrom = { "BowWeaponDash" },
	},
	MaxChargeBowWeapon =
	{
		InheritFrom = { "BowWeaponDash" },
	},
	GunBombWeapon =
	{
		InheritFrom = { "GunGrenadeToss" },
	},

	SwordWeaponWave =
	{
		InheritFrom = {"SwordWeapon"},
		DashWeapon = nil,
		OnFiredFunctionName = "ClearSwordWaveVFX",
		WeaponBinks = {},
	},

	LoadAmmoApplicator =
	{
		OnFiredFunctionName = "LoadAmmo",

		NotReadySound = "/Leftovers/SFX/OutOfAmmo2",
		NotReadyText = "OutOfAmmo_Alt",
		NoAmmoFunctionName = "RangedFailedNoAmmoPresentation",
		NotReadyAmmoPackText = "RetrieveAmmo",
		NotReadyAmmoInEnemyText = "RetrieveAmmoFromEnemy",
		NotReadyPulseStoredAmmo = true,
	},

	SelfLoadAmmoApplicator =
	{
		OnFiredFunctionName = "SelfLoadAmmo",

		NotReadySound = "/Leftovers/SFX/OutOfAmmo2",
		NotReadyText = "OutOfAmmo_Alt",
		NoAmmoFunctionName = "RangedFailedNoAmmoPresentation",
		NotReadyAmmoPackText = "RetrieveAmmo",
		NotReadyAmmoInEnemyText = "RetrieveAmmoFromEnemy",
		NotReadyPulseStoredAmmo = true,
	},

	GunGrenadeToss =
	{
		--FireScreenshake = { Distance = 4, Speed = 300, FalloffSpeed = 1000, Duration = 0.1, Angle = 90 },

		CodexWeaponName = "GunWeapon",
		NotReadyText = "GunReloadingStart",

		CompleteObjectivesOnFire = { "GunGrenadeToss", "GunGrenadeLucifer" },

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 10,

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.20, Duration = 0.28 },
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteCharging_Bow" },
			},
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Bow" },
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
				StoneObstacle = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/ArrowWallHitClankSmall",
				MetalObstacle = "/SFX/ArrowWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
		SelfMultiplier = 0.01,
	},

	BowWeapon =
	{
		InheritFrom = { "BaseUnlockableWeapon", },
		EquippedKitAnimation = "WeaponBowFloatingIdleOff",
		UnequippedKitAnimation = "WeaponBowFloatingIdle",
		BonusUnequippedKitAnimation = "WeaponBowFloatingIdleBonus",
		BonusEquippedKitAnimation = "WeaponBowFloatingIdleOffBonus",
		FirstTimeEquipAnimation = "ZagreusBowFire",
		FirstTimeEquipSound = "/SFX/Player Sounds/ZagreusBowFire",
		UpgradeChoiceText = "UpgradeChoiceMenu_Melee",
		ShortName = "BowWeapon_Short",
		UnlockName = "BowWeapon_Unlock",
		DashWeapon = "BowWeaponDash",
		SecondaryWeapon = "BowSplitShot",
		ResourceName = "LockKeys",
		UnlockCost = 1,
		PostWeaponUpgradeScreenAnimation = "ZagreusBowDashFireEndLoop",
		PostWeaponUpgradeScreenAngle = 205,
		RapidDamageType = true,

		KitInteractFunctionName = "WeaponKitSpecialInteractPresentation",
		KitInteractSpecialUnlockSound = "/Leftovers/Menu Sounds/EmoteAscendedRamaSitar",
		KitInteractSpecialUnlockSound2 = "/SFX/Player Sounds/ZagreusBowFireRamaSitar",
		KitInteractGameStateRequirements =
		{
			RequiredTextLines = { "ArtemisRevealsRamaAspect01" },
			RequiredFalsePlayed = { "/VO/ZagreusHome_2052", },
		},

		ChargeCameraMotion = { ZoomType = "Overshoot", Fraction = 0.95, Duration = 0.6 },
		FireCameraMotion = { ZoomType = "Ease", Fraction = 1.0, Duration = 0.06 },

		--FireScreenshake = { Distance = 2, Speed = 300, FalloffSpeed = 0, Duration = 0.1, Angle = 90 },
		--HitScreenshake = { Distance = 6, Speed = 3000, FalloffSpeed = 0, Duration = 0.1, Angle = 90 },

		--[[
		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.1 },
		},
		]]

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 },
		},

		EquipVoiceLines =
		{
			{
				Cooldowns =
				{
					{ Name = "ZagreusWeaponEquipSpeech", Time = 40 },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.35,

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						-- None
					},

					-- Coronacht, the Heart-Seaker; let's deal some death.
					{ Cue = "/VO/ZagreusField_0154", PlayOnce = true, },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.35,
					SuccessiveChanceToPlay = 0.33,
					TriggerCooldowns = { "ZagreusMiscWeaponEquipSpeech", },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						-- None
					},

					-- Think I need my bow...
					{ Cue = "/VO/ZagreusField_1266" },
					-- Let's go, Coronacht.
					{ Cue = "/VO/ZagreusField_1267" },
					-- Coronacht hungers.
					{ Cue = "/VO/ZagreusField_1155", GameStateRequirements = { RequiredOneOfTraits = { "UnusedWeaponBonusTrait", "UnusedWeaponBonusTraitAddGems" }, }, },
				},
				[3] = GlobalVoiceLines.MiscWeaponEquipVoiceLines,
			},
			[2] = GlobalVoiceLines.SkellyWeaponEquipReactionVoiceLines,
		},

		Sounds =
		{
			FireSounds =
			{
				PerfectChargeSounds =
				{
					{ Name = "/SFX/Player Sounds/ZagreusCriticalFire" },
					{ Name = "/VO/ZagreusEmotes/EmoteAttacking_BowPowerShot" },
					{ Name = "/SFX/Player Sounds/ZagreusBowFire" },
				},
				ImperfectChargeSounds =
				{
					{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Bow"},
					{ Name = "/SFX/Player Sounds/ZagreusBowFire" },
				},
				LoadedSounds =
				{
					{ Name = "/SFX/Player Sounds/ZagreusBloodshotFire" },
				},
				{ Name = "/Leftovers/SFX/AuraOn"},
			},
			ChargeSounds =
			{
				{
					Name = "/SFX/Player Sounds/ZagreusBowChargeup" ,
					StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired" },
					SetPitchToPropertyValue = "ChargeTime",
				},
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
				StoneObstacle = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/ArrowWallHitClankSmall",
				MetalObstacle = "/SFX/ArrowWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		WeaponBinks =
		{
			"ZagreusBow_Bink",
			"ZagreusBowRapidFire_Bink",
			"ZagreusBowDash_Bink",
			"ZagreusBowRun_Bink",
			"ZagreusBowRunStop_Bink",
		},

		Upgrades = { },
	},

	BowSplitShot =
	{
		StartingWeapon = false,
		CodexWeaponName = "BowWeapon",

		--ChargeCameraMotion = { ZoomType = "Overshoot", Fraction = 0.96, Duration = 0.6 },
		--FireCameraMotion = { ZoomType = "Ease", Fraction = 1.0, Duration = 0.06 },

		--FireScreenshake = { Distance = 2, Speed = 300, FalloffSpeed = 0, Duration = 0.1, Angle = 90 },
		--HitScreenshake = { Distance = 6, Speed = 3000, FalloffSpeed = 0, Duration = 0.1, Angle = 90 },
		--[[
		HitSimSlowCooldown = 0.25,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.1 },
		},
		]]

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.225, Duration = 0.15 },
			{ ScreenPreWait = 0.17, LeftFraction = 0.225, Duration = 0.15 },
			{ ScreenPreWait = 0.17, RightFraction = 0.225, Duration = 0.2 },
			--{ ScreenPreWait = 0.20, RightFraction = 0.6, Duration = 0.3 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteRanged", },
				{ Name = "/Leftovers/SFX/AuraOn"},
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
				StoneObstacle = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/ArrowWallHitClankSmall",
				MetalObstacle = "/SFX/ArrowWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades =
		{

		},
	},

	BowWeaponDash =
	{
		StartingWeapon = false,
		CodexWeaponName = "BowWeapon",
		SkipAttackNotReadySounds = true,

		--[[
		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 1.0, LerpTime = 0.1 },
		},
		]]

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 },
		},

		Sounds =
		{
			FireSounds =
			{
				PerfectChargeSounds =
				{
					{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
					{ Name = "/VO/ZagreusEmotes/EmoteAttacking_BowPowerShot" },
				},
				ImperfectChargeSounds =
				{
					{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Bow"},
					{ Name = "/SFX/Player Sounds/BowFire" },
				},
				{ Name = "/Leftovers/SFX/AuraOn"},
			},
			ChargeSounds =
			{
				{
					Name = "/SFX/Player Sounds/ZagreusBowChargeup" ,
					StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired" },
					SetPitchToPropertyValue = "ChargeTime",
				},
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
				StoneObstacle = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/ArrowWallHitClankSmall",
				MetalObstacle = "/SFX/ArrowWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades =
		{

		},
	},
	BowWeapon2 =
	{
		InheritFrom = { "BowWeaponDash", },
	},

	ShieldWeapon =
	{
		InheritFrom = { "BaseUnlockableWeapon", },
		EquippedKitAnimation = "WeaponShieldFloatingIdleOff",
		UnequippedKitAnimation = "WeaponShieldFloatingIdle",
		BonusUnequippedKitAnimation = "WeaponShieldFloatingIdleBonus",
		BonusEquippedKitAnimation = "WeaponShieldFloatingIdleOffBonus",
		FirstTimeEquipAnimation = "ZagreusShieldPunch",
		FirstTimeEquipSound = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing",
		ShortName = "ShieldWeapon_Short",
		UnlockName = "ShieldWeapon_Unlock",
		UpgradeChoiceText = "UpgradeChoiceMenu_Melee",
		DashWeapon ="ShieldWeaponDash",
		ExpireDashWeaponOnDash = true,
		SecondaryWeapon = "ShieldThrow",
		ResourceName = "LockKeys",
		UnlockCost = 3,
		PostWeaponUpgradeScreenAnimation = "ZagreusShieldIdle",
		PostWeaponUpgradeScreenAngle = 180,

		CompleteObjectivesOnFire = { "ShieldWeapon", "BeowulfAttack" },

		KitInteractFunctionName = "WeaponKitSpecialInteractPresentation",
		KitInteractSpecialUnlockSound = "/Leftovers/Menu Sounds/EmoteAscendedBeowulfStrings",
		-- KitInteractSpecialUnlockSound2 = "/Leftovers/SFX/ImpCrowdCheer",
		KitInteractGameStateRequirements =
		{
			RequiredTextLines = { "ChaosRevealsBeowulfAspect01" },
			-- Aegis: I see you stand your ground against the serpent's flame!
			RequiredFalsePlayed = { "/VO/ZagreusHome_2648", },
		},

		SkipAttackNotReadySounds = true,
		NoControlSound = "/Leftovers/SFX/OutOfAmmo2",

		--FireScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 4000, Duration = 0.1, DynamicAngleOffset = 0 },

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			--{ ScreenPreWait = 0.06, Fraction = 0.30, LerpTime = 0.06 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.06 },

			--{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			--{ ScreenPreWait = 0.06, Fraction = 0.30, LerpTime = 0.06 },
			--{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.06 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.0, RightFraction = 0.15, Duration = 0.15 },
		},

		EquipVoiceLines =
		{
			{
				Cooldowns =
				{
					{ Name = "ZagreusWeaponEquipSpeech", Time = 40 },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.35,

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						-- None
					},

					-- Aegis, Shield of Chaos; lend me your power.
					{ Cue = "/VO/ZagreusField_0152", PlayOnce = true, },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.35,
					SuccessiveChanceToPlay = 0.33,
					TriggerCooldowns = { "ZagreusMiscWeaponEquipSpeech", },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						-- None
					},

					-- My shield...
					{ Cue = "/VO/ZagreusField_1268" },
					-- Aegis, protect me.
					{ Cue = "/VO/ZagreusField_1269" },
					-- Aegis hungers.
					{ Cue = "/VO/ZagreusField_1157", GameStateRequirements = { RequiredOneOfTraits = { "UnusedWeaponBonusTrait", "UnusedWeaponBonusTraitAddGems" }, }, },
				},
				[3] = GlobalVoiceLines.MiscWeaponEquipVoiceLines,
			},
			[2] = GlobalVoiceLines.SkellyWeaponEquipReactionVoiceLines,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Shield" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldSwipe" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmashSHIELD",
				Brick = "/SFX/MetalStoneClangSHIELD",
				Stone = "/SFX/MetalStoneClangSHIELD",
				Organic = "/SFX/MetalOrganicHitSHIELD",
				StoneObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				BrickObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				MetalObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades = { },

		WeaponBinks =
		{
			"ZagreusShieldThrowReceive_Bink",
			"ZagreusShieldQuickAttack_Bink",
			"ZagreusShieldAttack_Bink",
			"ZagreusShieldDashAttack_Bink",
			"ZagreusShieldRun_Bink",
			"ZagreusShieldRunStop_Bink",
			"ZagreusShieldWalk_Bink",
			"ZagreusShieldIdle_Bink",
			"ZagreusShieldHeavyThrow_Bink",
			"ZagreusShieldHeavyThrowNoCatch_Bink",
		},
	},

	ShieldWeaponDash =
	{
		StartingWeapon = false,
		CodexWeaponName = "ShieldWeapon",

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.0, RightFraction = 0.15, Duration = 0.15 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Shield" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldSwipe" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmashSHIELD",
				Brick = "/SFX/MetalStoneClangSHIELD",
				Stone = "/SFX/MetalStoneClangSHIELD",
				Organic = "/SFX/MetalOrganicHitSHIELD",
				StoneObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				BrickObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				MetalObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.06 },
		},

		Upgrades = { },
	},

	ShieldWeaponRush =
	{
		StartingWeapon = false,
		FireScreenshake = { Distance = 2, Speed = 300, FalloffSpeed = 1200, Duration = 0.2 },
		CodexWeaponName = "ShieldWeapon",

		CauseImpactReaction = true,
		RushOverride = true,
		DoProjectileBlockPresentation = true,
		--ChargeCameraMotion = { ZoomType = "Overshoot", Fraction = 1.16, Duration = 0.8 },
		--FireCameraMotion = { ZoomType = "Ease", Fraction = 1.0, Duration = 0.3 },
		--HitCameraMotion = { ZoomType = "Ease", Fraction = 1.2, Duration = 0.01, RestoreDefaultDuration = 0.1 },
		--HitScreenshake = { Distance = 3, Speed = 10000, Duration = 0.15, FalloffSpeed = 30000 },

		SkipAttackNotReadySounds = true,

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			--[[
			{ ScreenPreWait = 0.04, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
			]]
			--{ ScreenPreWait = 0.06, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.18, Duration = 0.27 },
		},

		Sounds =
		{
			FireSounds =
			{
				PerfectChargeSounds =
				{
					{ Name = "/SFX/Player Sounds/ZagreusCriticalFire" },
					{ Name = "/VO/ZagreusEmotes/EmoteAttacking_BowPowerShot" },
					{ Name = "/SFX/Player Sounds/ZagreusBowFire" },
				},
				{ Name = "/VO/ZagreusEmotes/EmoteParrying" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
			ChargeSounds =
			{
				{
					Name = "/SFX/Player Sounds/ZagreusWeaponChargeup",
					Key = "ShieldWeaponRush",
					StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired" },
					SetPitchToPropertyValue = "ChargeTime",
				},
				{
					Name = "/VO/ZagreusEmotes/EmoteRangedCharging",
					StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired" },
				}
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmashSHIELD",
				Brick = "/SFX/MetalStoneClangSHIELD",
				Stone = "/SFX/MetalStoneClangSHIELD",
				Organic = "/SFX/MetalOrganicHitSHIELD",
				StoneObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				BrickObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				MetalObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades = { },
	},

	ShieldThrow =
	{
		StartingWeapon = false,
		CodexWeaponName = "ShieldWeapon",

		CompleteObjectivesOnFire = { "ShieldThrow", "ShieldGrind", "BeowulfSpecial" },
		--[[
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.2, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.04 },
		},
		]]

		--FireScreenshake = { Distance = 4, Speed = 200, FalloffSpeed = 1200, Duration = 0.1 },
		OnHitFunctionNames = { "IncrementHitByShield" },
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 0.17 },
		},

		NotReadySound = "/Leftovers/SFX/OutOfAmmo2",

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteRanged" },
				{ Name = "/SFX/Player Sounds/ZagreusBowFire" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearThrow" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Brick = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Stone = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Organic = "/SFX/Player Sounds/ZagreusShieldRicochet",
				StoneObstacle = "/SFX/Player Sounds/ZagreusShieldRicochet",
				BrickObstacle = "/SFX/Player Sounds/ZagreusShieldRicochet",
				MetalObstacle = "/SFX/Player Sounds/ZagreusShieldRicochet",
				BushObstacle = "/SFX/Player Sounds/ZagreusShieldRicochet",
			},
		},

		Upgrades =
		{

		},
		SelfMultiplier = 0,
	},

	ShieldThrowDash =
	{
		InheritFrom = { "ShieldThrow", },
		NotReadySound = "/EmptyCue",

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteRanged" },
				{ Name = "/SFX/Player Sounds/ZagreusBowFire" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearThrow" },
				{ Name = "/SFX/Player Sounds/ZagreusCriticalFire" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Brick = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Stone = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Organic = "/SFX/Player Sounds/ZagreusShieldRicochet",
				StoneObstacle = "/SFX/Player Sounds/ZagreusShieldRicochet",
				BrickObstacle = "/SFX/Player Sounds/ZagreusShieldRicochet",
				MetalObstacle = "/SFX/Player Sounds/ZagreusShieldRicochet",
				BushObstacle = "/SFX/Player Sounds/ZagreusShieldRicochet",
			},
		},
	},

	ChaosShieldThrow =
	{
		InheritFrom = { "ShieldThrow", },
		CompleteObjectivesOnFire = { "ShieldRushAndThrow" },
	},

	MagicShieldBlast =
	{
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/HellFireImpact",
				Brick = "/SFX/HellFireImpact",
				Stone = "/SFX/HellFireImpact",
				Organic = "/SFX/HellFireImpact",
			},
		},
	},

	SpearWeapon =
	{
		InheritFrom = { "BaseUnlockableWeapon", },
		EquippedKitAnimation = "WeaponSpearFloatingIdleOff",
		UnequippedKitAnimation = "WeaponSpearFloatingIdle",
		BonusUnequippedKitAnimation = "WeaponSpearFloatingIdleBonus",
		BonusEquippedKitAnimation = "WeaponSpearFloatingIdleOffBonus",
		FirstTimeEquipAnimation = "ZagreusSpearThrowFireReturn",
		FirstTimeEquipSound = "/SFX/Player Sounds/ZagreusSpearSwipe",
		UpgradeChoiceText = "UpgradeChoiceMenu_Melee",
		ShortName = "SpearWeapon_Short",
		UnlockName = "SpearWeapon_Unlock",
		DashWeapon = "SpearWeaponDash",
		DashSwaps = { "SpearWeapon", "SpearWeapon2", "SpearWeapon3", },
		ExpireDashWeaponOnDash = true,
		SecondaryWeapon = "SpearWeaponThrow",
		ResourceName = "LockKeys",
		UnlockCost = 4,
		LockKeyTextOffsetY = -125,
		--DashWeaponWindow = 0.6,
		PostWeaponUpgradeScreenAnimation = "ZagreusSpearThrowFireReturn",
		PostWeaponUpgradeScreenAngle = 230,
		PostWeaponUpgradeScreenFunctionName = "RemoveSpearBase",

		KitInteractFunctionName = "WeaponKitSpecialInteractPresentation",
		KitInteractSpecialUnlockSound = "/Leftovers/Menu Sounds/EmoteAscendedGuzheng",
		KitInteractSpecialUnlockSound2 = "/SFX/Player Sounds/ZagreusGuanYuSpearSpin",
		KitInteractGameStateRequirements =
		{
			RequiredTextLines = { "AchillesRevealsGuanYuAspect01" },
			RequiredFalsePlayed = { "/VO/ZagreusHome_2027", },
		},

		--FireScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.1, DynamicAngleOffset = 0 },

		SkipAttackNotReadySounds = true,

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.02 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 },
		},

		EquipVoiceLines =
		{
			{
				Cooldowns =
				{
					{ Name = "ZagreusWeaponEquipSpeech", Time = 40 },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.35,

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						-- None
					},

					-- Varatha, the Eternal Spear; join my pursuit.
					{ Cue = "/VO/ZagreusField_0153", PlayOnce = true },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.35,
					SuccessiveChanceToPlay = 0.33,
					TriggerCooldowns = { "ZagreusMiscWeaponEquipSpeech", },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						-- None
					},

					-- Should take my spear...
					{ Cue = "/VO/ZagreusField_1264" },
					-- It's time, Varatha.
					{ Cue = "/VO/ZagreusField_1265" },
					-- Varatha hungers.
					{ Cue = "/VO/ZagreusField_1156", GameStateRequirements = { RequiredOneOfTraits = { "UnusedWeaponBonusTrait", "UnusedWeaponBonusTraitAddGems" }, }, },
				},
				[3] = GlobalVoiceLines.MiscWeaponEquipVoiceLines,
			},
			[2] = GlobalVoiceLines.SkellyWeaponEquipReactionVoiceLines,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Spear" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearThrust" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		WeaponBinks =
		{
			"ZagreusSpear_Bink",
			"ZagreusSpearRun_Bink",
			"ZagreusSpearReturnToIdle_Bink",
			"ZagreusSpearSpin_Bink",
			"ZagreusSpearThrow_Bink",
			"ZagreusSpearDashAttack_Bink",
			"ZagreusSpearThrowReceive_Bink",
			"ZagreusSpearRunStop_Bink",
		},
	},

	SpearWeapon2 =
	{
		DashWeapon = "SpearWeaponDash",

		CodexWeaponName = "SpearWeapon",

		SkipAttackNotReadySounds = true,

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.02 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Spear" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearThrust" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

	},

	SpearWeapon3 =
	{
		DashWeapon = "SpearWeaponDash",

		CodexWeaponName = "SpearWeapon",

		SkipAttackNotReadySounds = true,

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.02 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 },
		},


		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Spear" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearThrust" },
				{ Name = "/SFX/Player Sounds/BowFire" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	SpearWeaponDash =
	{
		--FireScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.1, DynamicAngleOffset = 0 },
		CodexWeaponName = "SpearWeapon",

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.02 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.2, Duration = 0.2 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmotePowerAttacking_Sword" },
				{ Name = "/SFX/Player Sounds/ZagreusSwordOverhead" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	SpearWeaponThrow =
	{
		StartingWeapon = false,

		--FireScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.1, Angle = 0 },
		--HitScreenshake = { Distance = 6, Speed = 1000, FalloffSpeed = 3000, Duration = 0.1, Angle = 0 },
		CodexWeaponName = "SpearWeapon",
		SkipAttackNotReadySounds = true,
		CompleteObjectivesOnFire = { "SpearWeaponThrow", "SpearWeaponThrowTeleport", "SpearWeaponThrowSingle" },

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.17 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusBowFire" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearThrow" },
				{
					Name = "/VO/ZagreusEmotes/EmoteSpearThrow",
					Cooldown = 0.5
				},
			},
			ChargeSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteRanged" },
				{
					Name = "/Leftovers/SFX/AuraCharge" ,
					StoppedBy = { "TriggerRelease" }
				},
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
				StoneObstacle = "/SFX/SwordWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				MetalObstacle = "/SFX/SwordWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades = { },
	},

	SpearWeaponThrowReturn =
	{
		StartingWeapon = false,
		CompleteObjectivesOnFire = { "SpearWeaponThrow", "SpearThrowRegularRetrieve" },

		--FireScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.1, Angle = 0 },
		--HitScreenshake = { Distance = 6, Speed = 1000, FalloffSpeed = 3000, Duration = 0.1, Angle = 0 },
		CodexWeaponName = "SpearWeapon",
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.1, LeftFraction = 0.17, Duration = 0.17 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusSpearReturn" },
				{
					Name = "/VO/ZagreusEmotes/EmoteAttacking_Bow",
					Cooldown = 0.5
				},
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
				StoneObstacle = "/SFX/SwordWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				MetalObstacle = "/SFX/SwordWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades = { },
	},

	SpearWeaponThrowInvisibleReturn =
	{
		InheritFrom = { "SpearWeaponThrowReturn" },
		CompleteObjectivesOnFire = {},
	},

	SpearThrowImmolation =
	{
		InheritFrom = { "SpearWeaponSpin" },
		FireScreenshake = { Distance = 0, Speed = 0, FalloffSpeed = 0, Duration = 0, DynamicAngleOffset = 0 },
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusSpearSwipe" },
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire" }
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	SpearWeaponSpin =
	{
		StartingWeapon = false,
		FireScreenshake = { Distance = 10, Speed = 400, FalloffSpeed = 0, Duration = 0.35, DynamicAngleOffset = 0 },
		ChargeCameraMotion = { ZoomType = "Overshoot", Fraction = 0.96, Duration = 0.2 },
		ChargeCancelCameraMotion = { ZoomType = "Undershoot", Fraction = 1.0, Duration = 0.1, RestoreDefaultDuration = 0.1  },
		CodexWeaponName = "SpearWeapon",
		MaxChargeText = { Text = "SpearSpinMaxMessage", Duration = 0.4, OffsetY = -160, SkipShadow = true },
		SkipAttackNotReadySounds = true,
		CompleteObjectivesOnFire = { "SpearWeaponSpinRanged" },

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.01, Fraction = 0.30, LerpTime = 0.1 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0 },
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.16, Duration = 0.3 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmotePoweringUp" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearSwipe" },
				{ Name = "/Leftovers/SFX/AuraThrow" }
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},

			ChargeSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteCharging" },
				{
					Name = "/SFX/Player Sounds/ZagreusWeaponChargeup" ,
					Key = "SpearWeaponSpin",
					StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired" },
					SetPitchToPropertyValue = "ChargeTime",
				},
			},
		},

		Upgrades = { },
	},

	SpearWeaponSpin2 =
	{
		InheritFrom = { "SpearWeaponSpin" },
		CompleteObjectivesOnFire = { "SpearWeaponSpin", "SpearWeaponSpinRanged" },
	},

	SpearWeaponSpin3 =
	{
		InheritFrom = { "SpearWeaponSpin" },
		CompleteObjectivesOnFire = { "SpearWeaponSpin", "SpearWeaponSpinRanged" },
	},

	SpearWeaponSpinExplosiveChargeWeapon =
	{
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	DeathBallRetaliate =
	{
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/HellFireImpact",
				Brick = "/SFX/HellFireImpact",
				Stone = "/SFX/HellFireImpact",
				Organic = "/SFX/HellFireImpact",
			},
		},
	},

	RushWeapon =
	{
		UpgradeChoiceText = "UpgradeChoiceMenu_Rush",

		IgnoreCancelSimOnEffects = { "RushWeaponDisable", "RushWeaponDisableCancelable" },
		--[[
		CancelEffectSimSlowParameters =
		{
			{ ScreenPreWait = 0.0, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0.07 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.1 },
		},
		]]

		CompleteObjectivesOnFire = { "RushWeapon", "RushWeaponGilgamesh" },

		FireRumbleParameters =
		{
			--{ ScreenPreWait = 0.02, Fraction = 0.125, Duration = 0.1 },
		},

		SimSlowBlur =
		{
			Strength = 0.3,
			Distance = 1.6,
			FXInTime = 0.06,
			FXHoldTime = 0.4,
			FXOutTime = 0.4,
		},

		SkipAttackNotReadySounds = true,
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteEvading" },
				{ Name = "/SFX/Player Sounds/ZagreusDash" },
			},

			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/FistImpactMedium",
				Brick = "/SFX/FistImpactMedium",
				Stone = "/SFX/FistImpactMedium",
				Organic = "/SFX/FistImpactMedium",
			},

			CancelEffectSounds =
			{
			},

			NearbyEnemyFireSounds =
			{
				{ Name = "/Leftovers/Menu Sounds/TitanToggleShort" },
			},
		},

		NoExpressiveAnim = true,

		Upgrades = { },
	},

	SpearRushWeapon =
	{
		UpgradeChoiceText = "UpgradeChoiceMenu_Rush",
		FailToFireFunctionName = "SetSpearTeleportBuffer",
		IgnoreCancelSimOnEffects = { "RushWeaponDisable", "RushWeaponDisableCancelable" },
		--[[
		CancelEffectSimSlowParameters =
		{
			{ ScreenPreWait = 0.0, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0.07 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.1 },
		},
		]]

		FireRumbleParameters =
		{
			--{ ScreenPreWait = 0.02, Fraction = 0.125, Duration = 0.1 },
		},

		SimSlowBlur =
		{
			Strength = 0.3,
			Distance = 1.6,
			FXInTime = 0.06,
			FXHoldTime = 0.4,
			FXOutTime = 0.4,
		},

		SkipAttackNotReadySounds = true,
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteEvading" },
				{ Name = "/SFX/Player Sounds/ZagreusDash" },
			},

			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/FistImpactMedium",
				Brick = "/SFX/FistImpactMedium",
				Stone = "/SFX/FistImpactMedium",
				Organic = "/SFX/FistImpactMedium",
			},

			CancelEffectSounds =
			{
			},

			NearbyEnemyFireSounds =
			{
				{ Name = "/Leftovers/Menu Sounds/TitanToggleShort" },
			},
		},

		NoExpressiveAnim = true,

		Upgrades = { },
	},

	RamWeapon =
	{
		UpgradeChoiceText = "UpgradeChoiceMenu_Rush",

		IgnoreCancelSimOnEffects = { "RushWeaponDisable", "RushWeaponDisableCancelable" },

		SimSlowBlur =
		{
			Strength = 0.3,
			Distance = 1.6,
			FXInTime = 0.06,
			FXHoldTime = 0.4,
			FXOutTime = 0.4,
		},

		SkipAttackNotReadySounds = true,
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteEvading" },
				{ Name = "/SFX/Player Sounds/ZagreusDash" },
			},

			CancelEffectSounds =
			{
				{ Name = "/Leftovers/Menu Sounds/TitanToggleShort" },
			},

			NearbyEnemyFireSounds =
			{
				{ Name = "/Leftovers/Menu Sounds/TitanToggleShort" },
			},
		},

		Upgrades = { },
	},

	RadialNova =
	{

		Sounds =
		{

			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/HellFireImpact",
				Brick = "/SFX/HellFireImpact",
				Stone = "/SFX/HellFireImpact",
				Organic = "/SFX/HellFireImpact",
			},
		},

	},

	SwordWeapon =
	{
		InheritFrom = { "BaseUnlockableWeapon", },
		EquippedKitAnimation = "WeaponSwordFloatingIdleOff",
		UnequippedKitAnimation = "WeaponSwordFloatingIdle",
		BonusUnequippedKitAnimation = "WeaponSwordFloatingIdleBonus",
		BonusEquippedKitAnimation = "WeaponSwordFloatingIdleOffBonus",
		FirstTimeEquipAnimation = "ZagreusSwordAttack1",
		FirstTimeEquipSound = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing",
		UseText = "UseWeaponKit",
		UpgradeChoiceText = "UpgradeChoiceMenu_Melee",
		ShortName = "SwordWeapon_Short",
		DashWeapon = "SwordWeaponDash",
		ExpireDashWeaponOnDash = true,
		SecondaryWeapon = "SwordParry",
		PostWeaponUpgradeScreenAnimation = "ZagreusSwordAttack2_ReturnToIdle_Loop",

		CompleteObjectivesOnFire = { "SwordWeapon", "SwordWeaponArthur" },

		KitInteractFunctionName = "WeaponKitSpecialInteractPresentation",
		KitInteractSpecialUnlockSound = "/Leftovers/Menu Sounds/EmoteAscendedArthurChoir",
		KitInteractGameStateRequirements =
		{
			RequiredTextLines = { "NyxRevealsArthurAspect01" },
			RequiredFalsePlayed = { "/VO/ZagreusHome_2047", },
		},

		SkipAttackNotReadySounds = true,

		CauseImpactReaction = true,

		--FireScreenshake = { Distance = 2, Speed = 200, FalloffSpeed = 1400, Duration = 0.1, Angle = 225 },

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.01, Fraction = 1.0, LerpTime = 0.03 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.15 },
		},

		EquipVoiceLines =
		{
			{
				Cooldowns =
				{
					{ Name = "ZagreusWeaponEquipSpeech", Time = 40 },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.35,

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						-- None
					},

					-- Stygius, Blade of the Underworld; I need your strength.
					{ Cue = "/VO/ZagreusField_0151", GameStateRequirements = { RequiredMinCompletedRuns = 1, }, PlayOnce = true },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.35,
					SuccessiveChanceToPlay = 0.33,
					TriggerCooldowns = { "ZagreusMiscWeaponEquipSpeech", },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						-- None
					},

					-- My blade...
					{ Cue = "/VO/ZagreusField_1262" },
					-- Come, Stygius.
					{ Cue = "/VO/ZagreusField_1263" },
					-- Stygius hungers.
					{ Cue = "/VO/ZagreusField_1154", GameStateRequirements = { RequiredOneOfTraits = { "UnusedWeaponBonusTrait", "UnusedWeaponBonusTraitAddGems" }, }, },
				},
				[3] = GlobalVoiceLines.MiscWeaponEquipVoiceLines,
			},
			[2] = GlobalVoiceLines.SkellyWeaponEquipReactionVoiceLines,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Sword" },
				{ Name = "/SFX/Player Sounds/ZagreusSwordSwipe" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		WeaponBinks =
		{
			"ZagreusSword_Bink",
			"ZagreusSwordReturnToIdle_Bink",
			"ZagreusSwordDashAttack_Bink",
			"ZagreusSwordRun_Bink",
			"ZagreusSwordRunStop_Bink",
			"ZagreusSwordParry_Bink",
		},
	},

	SwordWeapon2 =
	{
		StartingWeapon = false,
		CauseImpactReaction = true,
		CodexWeaponName = "SwordWeapon",
		--FireScreenshake = { Distance = 2, Speed = 300, FalloffSpeed = 0, Duration = 0.1, Angle = 90 },
		HitScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.1, Angle = 90 },

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.2, Duration = 0.15 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusSwordOverhead" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades = { },
	},

	SwordWeapon3 =
	{
		StartingWeapon = false,
		CauseImpactReaction = true,
		CodexWeaponName = "SwordWeapon",

		--ChargeCameraMotion = { ZoomType = "Overshoot", Fraction = 0.96, Duration = 0.3 },
		--FireCameraMotion = { ZoomType = "Ease", Fraction = 1.0, Duration = 0.2 },
		--HitScreenshake = { Distance = 3, Speed = 10000, Duration = 0.08, FalloffSpeed = 30000 },

		--[[FireSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.2, Fraction = 1.0, LerpTime = 0.1 },
		},
		]]

		HitSimSlowCooldown = 0.03,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.07 },

			--{ ScreenPreWait = 0.01, Fraction = 0.01, LerpTime = 0 },
			--{ ScreenPreWait = 0.06, Fraction = 0.3, LerpTime = 0.07 },
			--{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.07 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.25, Duration = 0.2 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmotePowerAttacking_Sword" },
			},
			ChargeSounds =
			{
				{
					Name = "/Leftovers/SFX/AuraCharge" ,
					StoppedBy = { "TriggerRelease" }
				},
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades = { },
	},

	SwordWeaponDash =
	{
		StartingWeapon = false,
		CauseImpactReaction = true,
		CodexWeaponName = "SwordWeapon",

		--HitScreenshake = { Distance = 3, Speed = 10000, Duration = 0.08, FalloffSpeed = 30000 },
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.125, Duration = 0.15 },
		},

		HitSimSlowParameters =
		{

			{ ScreenPreWait = 0.04, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.07 },

			--{ ScreenPreWait = 0.00, Fraction = 0.01, LerpTime = 0 },
			--{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0.07 },
			--{ ScreenPreWait = 0.035, Fraction = 1.0, LerpTime = 0.1 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Bow" },
				{ Name = "/SFX/Player Sounds/ZagreusSwordSwipe" },
			},
			ChargeSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteCharging" },
				{
					Name = "/Leftovers/SFX/AuraCharge" ,
					StoppedBy = { "TriggerRelease" }
				},
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades = { },
	},

	SwordParry =
	{
		StartingWeapon = false,
		CodexWeaponName = "SwordWeapon",

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 2,

		SkipAttackNotReadySounds = true,

		FireScreenshake = { Distance = 4, Speed = 300, FalloffSpeed = 4000, Duration = 0.25, Angle = 0 },
		ChargeCameraMotion = { ZoomType = "Ease", Fraction = 1.05, Duration = 0.04, HoldDuration = 0.4, RestoreDefaultDuration = 0.8 },

		FireSimSlowParameters =
		{
			--{ ScreenPreWait = 0.0, Fraction = 0.01, LerpTime = 0 },
			--{ ScreenPreWait = 0.04, Fraction = 0.1, LerpTime = 0.07 },
			--{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0.1 },
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.08, Fraction = 0.2, Duration = 0.22 },
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteCharging_Bow" },
				{ Name = "/SFX/Player Sounds/ZagreusSwordSwipe" },
			},
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteParry_Sword" },
			},
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
				StoneObstacle = "/SFX/SwordWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				MetalObstacle = "/SFX/SwordWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Binks =
		{
			"ZagreusSwordParry_Bink",
		},

		Upgrades = { },
	},

	SwordParryRecall =
	{
		FireSimSlowParameters =
		{
			--{ ScreenPreWait = 0.04, Fraction = 0.01, LerpTime = 0 },
			--{ ScreenPreWait = 0.04, Fraction = 0.5, LerpTime = 0.0 },
			--{ ScreenPreWait = 0.22, Fraction = 1.0, LerpTime = 0.03 },
		},
	},

	FistWeapon =
	{
		InheritFrom = { "BaseUnlockableWeapon", },
		EquippedKitAnimation = "WeaponFistsFloatingIdleOff",
		UnequippedKitAnimation = "WeaponFistsFloatingIdle",
		BonusUnequippedKitAnimation = "WeaponFistsFloatingIdleBonus",
		BonusEquippedKitAnimation = "WeaponFistsFloatingIdleOffBonus",
		FirstTimeEquipAnimation = "ZagreusFistDashUpperCut_Kit",
		FirstTimeEquipSound = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing",
		UseText = "UseWeaponKit",
		UpgradeChoiceText = "UpgradeChoiceMenu_Melee",
		ShortName = "FistWeapon_Short",
		UnlockName = "FistWeapon_Unlock",
		DashWeapon = "FistWeaponDash",
		DashSwaps = { "FistWeapon", "FistWeapon2", "FistWeapon3", "FistWeapon4", "FistWeapon5" },
		ExpireDashWeaponOnDash = true,
		CodexWeaponName = "FistWeapon",
		SecondaryWeapon = "FistWeaponSpecial",
		ResourceName = "LockKeys",
		UnlockCost = 8,
		PostWeaponUpgradeScreenAnimation = "ZagreusFistFlurryPunch_ReturnToIdle1",
		PostWeaponUpgradeScreenAngle = 208,
		ComboPoints = 1,

		CompleteObjectivesOnFire = { "FistWeapon", "FistWeaponGilgamesh" },

		GameStateRequirements =
		{
			RequiredTrueFlags = { "FistUnlocked" },
		},

		KitInteractFunctionName = "WeaponKitSpecialInteractPresentation",
		KitInteractSpecialUnlockSound = "/Leftovers/Menu Sounds/EmoteAscendedGilgameshFlute",
		KitInteractSpecialUnlockSound2 = "/SFX/Player Sounds/ZagreusClawSwipe",
		KitInteractGameStateRequirements =
		{
			RequiredTextLines = { "MinotaurRevealsGilgameshAspect01" },
			RequiredFalsePlayed = { "/VO/ZagreusHome_3490" },
		},

		SkipAttackNotReadySounds = true,

		CauseImpactReaction = true,

		--FireScreenshake = { Distance = 2, Speed = 200, FalloffSpeed = 1400, Duration = 0.1, Angle = 225 },

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.0 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 },
		},

		EquipVoiceLines =
		{
			{
				Cooldowns =
				{
					{ Name = "ZagreusWeaponEquipSpeech", Time = 40 },
				},
				{
					RandomRemaining = true,
					PlayOnceFromTableThisRun = true,
					PreLineWait = 0.35,
					TriggerCooldowns = { "SkellyWeaponEquipSpeech", },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						-- None
					},

					-- Malphon, the Twin Fists; what say we crack some skulls.
					{ Cue = "/VO/ZagreusField_3232", PlayOnce = true },
					-- Twin Fists of Malphon; our strength combined surely cannot be stopped.
					{ Cue = "/VO/ZagreusField_3233", PlayOnce = true },
				},
				{
					PlayOnce = true,
					BreakIfPlayed = true,
					PreLineWait = 0.3,
					ObjectType = "TrainingMelee",

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						-- None
					},

					-- Whoa, those are some paws!
					{ Cue = "/VO/Skelly_0459" },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.35,
					SuccessiveChanceToPlay = 0.33,
					TriggerCooldowns = { "ZagreusMiscWeaponEquipSpeech", },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						-- None
					},

					-- Could use the Fists.
					{ Cue = "/VO/ZagreusField_3234" },
					-- Let's punch things up a bit.
					{ Cue = "/VO/ZagreusField_3235" },
					-- Ready, Malphon?
					{ Cue = "/VO/ZagreusField_3236" },
					-- Malphon hungers.
					{ Cue = "/VO/ZagreusField_3421", GameStateRequirements = { RequiredOneOfTraits = { "UnusedWeaponBonusTrait", "UnusedWeaponBonusTraitAddGems" }, }, },
				},
				[3] = GlobalVoiceLines.MiscWeaponEquipVoiceLines,
			},
			[2] = GlobalVoiceLines.SkellyWeaponEquipReactionVoiceLines,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Fist1" },
				{ Name = "/SFX/Player Sounds/ZagreusFistWhoosh" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/FistImpactSmall",
				Brick = "/SFX/FistImpactSmall",
				Stone = "/SFX/FistImpactSmall",
				Organic = "/SFX/FistImpactSmall",
				StoneObstacle = "/SFX/FistImpactSmall",
				BrickObstacle = "/SFX/FistImpactSmall",
				MetalObstacle = "/SFX/FistImpactSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		WeaponBinks =
		{
			"ZagreusFistIdle_Bink",
			"ZagreusFistFlurryPunch_Bink",
			"ZagreusFistDashHayMaker_Bink",
			"ZagreusFistDashUpperCut_Bink",
			"ZagreusFistRun_Bink",
			"ZagreusFistRunStop_Bink",
			"ZagreusFistAerialUpperCut_Bink",
			"ZagreusFistGrab_Bink",
		},
	},

	FistWeapon2 =
	{
		InheritFrom = { "FistWeapon", },
	},
	FistWeapon3 =
	{
		InheritFrom = { "FistWeapon", },
	},
	FistWeapon4 =
	{
		InheritFrom = { "FistWeapon", },
	},
	FistWeapon5 =
	{
		InheritFrom = { "FistWeapon", },
	},

	FistWeaponDash =
	{
		StartingWeapon = false,
		CauseImpactReaction = true,
		CodexWeaponName = "FistWeapon",
		ComboPoints = 1,

		--HitScreenshake = { Distance = 3, Speed = 10000, Duration = 0.08, FalloffSpeed = 30000 },
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.2, Duration = 0.24 },
		},

		HitSimSlowCooldown = 0.1,
		HitSimSlowParameters =
		{

			{ ScreenPreWait = 0.02, Fraction = 0.02, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.0 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_DashPunch" },
				{ Name = "/SFX/Player Sounds/ZagreusFistWhoosh" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/FistImpactBig",
				Brick = "/SFX/FistImpactBig",
				Stone = "/SFX/FistImpactBig",
				Organic = "/SFX/FistImpactBig",
				StoneObstacle = "/SFX/FistImpactSmall",
				BrickObstacle = "/SFX/FistImpactSmall",
				MetalObstacle = "/SFX/FistImpactSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades = { },
	},

	FistWeaponSpecial =
	{
		StartingWeapon = false,
		CodexWeaponName = "FistWeapon",
		DamageNumberGenusName = "FistWeaponSpecial",
		DashWeapon = "FistWeaponSpecialDash",
		--ComboPoints = 1,
		OnFiredFunctionName = "CheckComboPowerReset",

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 2,

		SkipAttackNotReadySounds = true,

		FireScreenshake = { Distance = 4, Speed = 300, FalloffSpeed = 4000, Duration = 0.25, Angle = 0 },

		HitSimSlowCooldown = 0.02,
		HitSimSlowParameters =
		{

			{ ScreenPreWait = 0.04, Fraction = 0.02, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0.03 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.1 },
		},

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.26, Duration = 0.32 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmotePowerAttacking_Fist5" },
				{ Name = "/SFX/Player Sounds/ZagreusFistBigWhoosh" },
			},
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/FistImpactBig",
				Brick = "/SFX/FistImpactBig",
				Stone = "/SFX/FistImpactBig",
				Organic = "/SFX/FistImpactBig",
				StoneObstacle = "/SFX/FistImpactSmall",
				BrickObstacle = "/SFX/FistImpactSmall",
				MetalObstacle = "/SFX/FistImpactSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		WeaponBinks =
		{
			"ZagreusFistFlashKick_Bink",

		},

		Upgrades = { },
	},

	FistWeaponSpecialDash =
	{
		StartingWeapon = false,
		CauseImpactReaction = true,
		DamageNumberGenusName = "FistWeaponSpecial",
		CodexWeaponName = "FistWeapon",
		--ComboPoints = 1,
		OnFiredFunctionName = "CheckComboPowerReset",

		--HitScreenshake = { Distance = 3, Speed = 10000, Duration = 0.08, FalloffSpeed = 30000 },
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 0.23 },
		},

		HitSimSlowCooldown = 0.02,
		HitSimSlowParameters =
		{

			{ ScreenPreWait = 0.04, Fraction = 0.02, LerpTime = 0.0 },
			{ ScreenPreWait = 0.03, Fraction = 0.10, LerpTime = 0.03 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.1 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmotePowerAttacking_Fist2" },
				{ Name = "/SFX/Player Sounds/ZagreusFistBigWhoosh" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/FistImpactBig",
				Brick = "/SFX/FistImpactBig",
				Stone = "/SFX/FistImpactBig",
				Organic = "/SFX/FistImpactBig",
				StoneObstacle = "/SFX/FistImpactSmall",
				BrickObstacle = "/SFX/FistImpactSmall",
				MetalObstacle = "/SFX/FistImpactSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades = { },
	},

	FistSpecialVacuum =
	{
		HitSimSlowParameters =
		{

			{ ScreenPreWait = 0.03, Fraction = 0.02, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 0.20, LerpTime = 0.03 },
			{ ScreenPreWait = 0.04, Fraction = 1.00, LerpTime = 0.1 },
		},
	},

	FistDetonationWeapon =
	{	
		--[[
		HitSimSlowCooldown = 0.3,
		HitSimSlowParameters =
		{

			{ ScreenPreWait = 0.03, Fraction = 0.02, LerpTime = 0.0 },
			{ ScreenPreWait = 0.04, Fraction = 0.80, LerpTime = 0.0 },
			{ ScreenPreWait = 0.04, Fraction = 1.00, LerpTime = 0.1 },
		},
		]]
	},

	GunBombImmolation =
	{
	},

	FistWeaponLandAreaAttack =
	{

		FireScreenshake = { Distance = 3, Speed = 300, FalloffSpeed = 4000, Duration = 0.25, Angle = 0 },
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/ZagreusEmotes/EmoteAttacking_Shield" },
				{ Name = "/Leftovers/SFX/MeteorStrikeQuiet" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/FistImpactBig",
				Brick = "/SFX/FistImpactBig",
				Stone = "/SFX/FistImpactBig",
				Organic = "/SFX/FistImpactBig",
				StoneObstacle = "/SFX/FistImpactSmall",
				BrickObstacle = "/SFX/FistImpactSmall",
				MetalObstacle = "/SFX/FistImpactSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.22, Duration = 0.2 },
		},
		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{

			{ ScreenPreWait = 0.02, Fraction = 0.02, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0.03 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	-- Enemy Weapons
	SmallEnemyMelee =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.1 },
		},

		Upgrades = { },
	},

	BloodlessMelee =
	{
		AIData =
		{
			PreAttackDuration = 0.42,
			PreAttackEndDuration = 0.42,
			PreAttackWaitForAnimation = false,
			PreAttackEndShake = true,
			PreFireDuration = 0.10,
			FireDuration = 0.3,
			PostAttackDuration = 0.45,
			PostAttackCooldown = 0.35,
			PreAttackCancelDuration = 0.1,
			AIAttackDistance = 170,
			AIBufferDistance = 100,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BloodlessMeleeBerserkerCombo1 =
	{
		AIData =
		{
			AIAttackDistance = 500,
			AIBufferDistance = 100,
			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackAnimation = "Enemy_BloodlessNakedBerserkAttacks_Start",
			PreAttackDuration = 0.5,
			PreAttackEndShake = true,
			FireDuration = 0,
			PostAttackDuration = 0,

			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			[1] = "BloodlessMeleeBerserker1",
			[2] = "BloodlessMeleeBerserker2",
			[3] = "BloodlessMeleeBerserker1",
			[4] = "BloodlessMeleeBerserker2",
			[5] = "BloodlessMeleeBerserker1",
			[6] = "BloodlessMeleeBerserker2",
			[7] = "BloodlessMeleeBerserkerAttackEnd",
		},
	},

	BloodlessMeleeBerserkerCombo2 =
	{
		AIData =
		{
			AIAttackDistance = 500,
			AIBufferDistance = 100,
			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackAnimation = "Enemy_BloodlessNakedBerserkAttacks_Start",
			PreAttackDuration = 0.5,
			PreAttackEndShake = true,
			FireDuration = 0,
			PostAttackDuration = 0,

			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			[1] = "BloodlessMeleeBerserker1",
			[2] = "BloodlessMeleeBerserker2",
			[3] = "BloodlessMeleeBerserkerAttackEnd",
		},
	},

	BloodlessMeleeBerserker1 =
	{
		AIData =
		{
			DeepInheritance = true,
			FireAnimation = "Enemy_BloodlessNakedBerserkAttacks_Fire1",
			PreAttackDuration = 0.0,
			FireDuration = 0.3,
			FireDurationMinWaitTime = 0.3,
			PostAttackDuration = 0.0,
			PreAttackCancelDuration = 0.1,
			SkipAngleTowardTargetWait = true,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			SkipMovement = true,
			AIAttackDistance = 9999,
			AIBufferDistance = 200,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BloodlessMeleeBerserker2 =
	{
		InheritFrom = { "BloodlessMeleeBerserker1" },
		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "Enemy_BloodlessNakedBerserkAttacks_PreFire2",
			FireAnimation = "Enemy_BloodlessNakedBerserkAttacks_Fire2",
			PreAttackWaitForAnimation = true,
			FireDuration = 0.35,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BloodlessMeleeBerserkerAttackEnd =
	{
		AIData =
		{
			PreAttackAnimation = "Enemy_BloodlessNakedBerserkAttacks_ReturnToIdle",
			PreAttackDuration = 0.3,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			RetreatLeapAfterUse = true,

			SkipMovement = true,
			SkipFireWeapon = true,
		}
	},

	BloodlessSkullToss =
	{
		AIData =
		{
			PreAttackDuration = 0.5,
			PostAttackDuration = 1.5,
			AIAttackDistance = 750,
			AIBufferDistance = 900,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 150,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = false,

			PreAttackAnimation = "Enemy_BloodlessGrenadierAttack_Charge",
			FireAnimation = "Enemy_BloodlessGrenadierAttack_Fire",
			PostAttackAnimation = "Enemy_BloodlessGrenadierAttack_ReturnToIdle"
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/BowFire" },
			},
		},
	},

	BloodlessJavelin =
	{
		AIData =
		{
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			UnequipWeaponAfterUse = true,
			StopAnimationAfterUse = "BloodlessJavelin"
		},
	},

	BloodlessShieldBash =
	{
	},

	BloodlessDagger =
	{
		AIData =
		{
			PreAttackDuration = 0.3,
			PostAttackDuration = 1.0,
			AIAttackDistance = 150,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 100,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = false,
		},
	},

	BloodlessGrenadierRanged =
	{
		AIData =
		{
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackWaitForAnimation = true,
			FireDuration = 0.32,
			PostAttackDuration = 0.2,
			PostAttackCooldownMin = 0.3,
			PostAttackCooldownMax = 0.7,

			PreAttackAnimation = "Enemy_BloodlessGrenadierAttack_Charge",
			FireAnimation = "Enemy_BloodlessGrenadierAttack_Fire",
			PostAttackAnimation = "Enemy_BloodlessGrenadierAttack_ReturnToIdle"
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/EnemyGrenadeMortarLaunch" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	BloodlessGrenadierRangedElite =
	{
		AIData =
		{
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackWaitForAnimation = true,
			FireDuration = 0.32,
			PostAttackDuration = 0.1,
			PostAttackCooldownMin = 0.3,
			PostAttackCooldownMax = 1.3,

			PreAttackAnimation = "Enemy_BloodlessGrenadierAttack_Charge",
			FireAnimation = "Enemy_BloodlessGrenadierAttack_Fire",
			PostAttackAnimation = "Enemy_BloodlessGrenadierAttack_ReturnToIdle"

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/EnemyGrenadeMortarLaunch" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	BloodlessGrenadierCluster =
	{
		AIData =
		{
			AIAttackDistance = 300,
			PostAttackDuration = 0.0,

			MinAttacksBetweenUse = 3,
			MaxPlayerDistance = 300,
			RetreatLeapAfterUse = true,

			PreAttackDuration = 0.5,
			PreAttackAnimation = "Enemy_BloodlessGrenadierIdle",
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	BloodlessGrenadierDive =
	{
		AIData =
		{
			AIAttackDistance = 200,
			AIAngleTowardsPlayerWhileFiring = true,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 80,
			RetreatAfterAttack = true,

			PreAttackWaitForAnimation = true,
			FireDuration = 0.32,
			PostAttackDuration = 0.5,
			PostAttackCooldownMin = 0.2,
			PostAttackCooldownMax = 0.5,

			MaxConsecutiveUses = 1,

			PreAttackAnimation = "Enemy_BloodlessGrenadierSelfDestruct_Charge",
			FireAnimation = "Enemy_BloodlessGrenadierSelfDestruct_Fire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/EnemyGrenadeMortarLaunch" },
				{ Name = "/SFX/Explosion1" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BloodlessReposition =
	{
		AIData =
		{
			RepositionLeap = true,
			AIAttackDistance = 1000,
			PreAttackDuration = 0.1,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 0.0,
			PostAttackCooldownMax = 0.1,
			MaxConsecutiveUses = 3,
			PreAttackAnimation = "Enemy_BloodlessGrenadierIdle",
			FireAnimation = "Enemy_BloodlessGrenadierIdle",
			SkipFireWeapon = true,
		}
	},

	BloodlessPitch =
	{
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
				{ Name = "/SFX/Enemy Sounds/Bloodless02/EmoteRangedAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BloodlessPitchCurveVolley =
	{
		AIData =
		{
			PreAttackDurationMin = 1.7,
			PreAttackDurationMax = 1.7,
			FireTicks = 1,
			FireCooldown = 0.5,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
				{ Name = "/SFX/Enemy Sounds/Bloodless02/EmoteRangedAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},
	BloodlessPitchCurve =
	{
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/World Sounds/TrainingMontageWhoosh" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0 },
		},
	},
	BloodlessDeathLob =
	{
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/World Sounds/TrainingMontageWhoosh" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BloodlessWaveFistWeapon =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },

		AIData =
		{
			DeepInheritance = true,
			TakeCoverDuration = 1.8,

			PreAttackDuration = 0.8,
			PreAttackEndShake = true,
			PostAttackDuration = 1.5,
			AIRequireProjectileLineOfSight = false,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,

			AIAttackDistance = 700,
			AIRetreatDistance = 600,

			PreAttackCancelDuration = 0.1,
			AIAttackDistance = 950,
			AIBufferDistance = 850,
			AIAngleTowardsPlayerWhileFiring = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
				{ Name = "/SFX/Enemy Sounds/BloodlessWaveFist/EmoteWaveFistAttack" },
			},
		},
	},

	BloodlessWaveFistWeaponElite =
	{
		InheritFrom = { "BloodlessWaveFistWeapon" },
		AIData =
		{
			DeepInheritance = true,

			PostAttackDuration = 0.0,

			ChainedWeapon = "BloodlessWaveFistWeaponElite2",
		},
	},

	BloodlessWaveFistWeaponElite2 =
	{
		InheritFrom = { "BloodlessWaveFistWeapon" },

		ChainedOnly = true,

		AIData =
		{
			DeepInheritance = true,

			SkipMovement = true,
			PreAttackDuration = 0.4,
			PostAttackDuration = 2.0,

			LeapWhenTargetBeyondDistance = 9999,
			LeapWhenTargetOutOfSight = false,
		},
	},


	BloodlessWaveFistWeaponEliteV =
	{
		InheritFrom = { "BloodlessWaveFistWeapon" },

		ChainedOnly = true,

		AIData =
		{
			DeepInheritance = true,

			SkipMovement = true,
			PreAttackDuration = 0.8,
			PostAttackDuration = 2.0,

			LeapWhenTargetBeyondDistance = 9999,
			LeapWhenTargetOutOfSight = false,
		},
	},

	ShadeSwordWeapon =
	{

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			ChainedWeapon = "ShadeSwordWeapon2",

			PreAttackDuration = 0.42,
			PreAttackSound = "/SFX/Enemy Sounds/Exalted/EmoteCharging",
			PreAttackEndDuration = 0.42,
			PreFireDuration = 0.10,
			FireDuration = 0.35,
			PostAttackDuration = 0.0,
			PostAttackCooldown = 0.0,
			PreAttackCancelDuration = 0.1,
			PreAttackAnimation = "ShadeSword_PreAttack",
			FireAnimation = "ShadeSword_AttackSword",

			PreAttackEndShake = true,

			AIAttackDistance = 240,
			AIBufferDistance = 220,
			AIMoveWithinRangeTimeoutMin = 1.0,
			AIMoveWithinRangeTimeoutMax = 3.0,
			SkipAttackAfterMoveTimeout = true,
			AttackFailWeapon = "ShadeSideDash",
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/WeaponSwing" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	ShadeSwordWeapon2 =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0 },
		},

		ChainedOnly = true,

		AIData =
		{
			PreAttackDuration = 0,
			FireDuration = 1.0,
			PostAttackDuration = 0.2,
			PostAttackCooldown = 1.0,
			PreAttackCancelDuration = 0.1,
			FireAnimation = "ShadeSword_AttackSword2",

			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			SkipAngleTowardTarget = true,
			SkipMovement = true,

			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,
		}
	},

	ShadeSwordOverhead =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			PreAttackDuration = 0.50,
			FireDuration = 0.55,
			PostAttackDuration = 0.5,
			-- in animation data
			-- PreAttackSound = "/SFX/Enemy Sounds/Exalted/EmoteCharging",
			PostAttackCooldown = 1.5,
			PreAttackCancelDuration = 0.1,
			PreAttackAnimation = "ShadeSword_AttackSwordOverHeadPreAttack",
			FireAnimation = "ShadeSword_AttackSwordOverHead",
			PostAttackAnimation = "ShadeSword_AttackOverHeadReturnToIdle",

			PreAttackEndShake = true,

			AIAttackDistance = 700,
			AIBufferDistance = 650,
			AIMoveWithinRangeTimeoutMin = 1.0,
			AIMoveWithinRangeTimeoutMax = 3.0,
			SkipAttackAfterMoveTimeout = true,
			AttackFailWeapon = "ShadeSideDash",
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,

			MinPlayerDistance = 200,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/HellFireShoot" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	ShadeSwordOverheadElite =
	{
		InheritFrom = { "ShadeSwordOverhead" },

		AIData =
		{
			PreAttackDuration = 0.50,
			FireDuration = 0.55,
			PostAttackDuration = 0.5,
			PreAttackSound = "/SFX/Enemy Sounds/Exalted/EmoteCharging",
			PostAttackCooldown = 1.5,
			PreAttackCancelDuration = 0.1,
			PreAttackAnimation = "ShadeSword_AttackSwordOverHeadPreAttack",
			FireAnimation = "ShadeSword_AttackSwordOverHead",
			PostAttackAnimation = "ShadeSword_AttackOverHeadReturnToIdle",

			PreAttackEndShake = true,

			AIAttackDistance = 600,
			AIBufferDistance = 550,
			AIMoveWithinRangeTimeoutMin = 1.0,
			AIMoveWithinRangeTimeoutMax = 3.0,
			SkipAttackAfterMoveTimeout = true,
			AttackFailWeapon = "ShadeSideDash",
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,

			MinPlayerDistance = 300,
		},
	},

	ShadeSwordOverheadSuperElite =
	{
		InheritFrom = { "ShadeSwordOverhead" },
	},

	ShadeSideDash =
	{
		AIData =
		{
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.3,

			SkipMovement = true,

			CreateOwnTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistance = 200,

			AttackFailWeapon = "ShadeSideDash",
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Exalted/ExaltedDash" },
			}
		},
	},

	ShadeSpearForwardDash =
	{
		AIData =
		{
			PreAttackDuration = 0.0,
			FireDuration = 0.3,
			PostAttackDuration = 0.1,

			SkipMovement = true,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,

			MinPlayerDistance = 400,
			ForceUseIfReady = true,
		}
	},

	ShadeShieldMelee =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 0.55,
			FireDuration = 0.2,
			PostAttackDuration = 1.3,
			PostAttackCooldown = 0.5,
			PreAttackCancelDuration = 0.1,
			PreAttackAnimation = "ShadeShield_AttackCharge",
			FireAnimation = "ShadeShield_Punch",

			PreAttackEndShake = true,

			AIAttackDistance = 310,
			AIBufferDistance = 270,
			AIMoveWithinRangeTimeoutMin = 8.0,
			AIMoveWithinRangeTimeoutMax = 11.1,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,

			--SkipAngleTowardTargetWait = true,
			PreMoveAngleTowardTarget = false,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	ShadeShieldMeleeElite =
	{
		InheritFrom = { "ShadeShieldMelee" },

		AIData =
		{
			DeepInheritance = true,

			ChainedWeapon="ShadeShieldSpin",
			PostAttackDuration = 0.0,
			PostAttackCooldown = 0.0,
		},
	},

	ShadeShieldSpin =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			PreAttackAnimation = "ShadeShield_AttackCharge",
			--PreAttackFx = "ShadeBladeSpinPreview",
			FireAnimation = "ShadeShield_AttackFire",
			PreAttackDuration = 0.05,
			--PreAttackDuration = 0.6,
			FireDuration = 0.5,
			PostAttackDuration = 1.3,
			PostAttackCooldown = 0.5,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			SkipMovement = true,
			SkipAngleTowardTarget = true,

			AIMoveWithinRangeTimeout = 10.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusSpearThrow" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	ShadeHunkerDown =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			PreAttackAnimation = "ShadeShield_PreSlam",
			FireAnimation = "ShadeShield_Slam",
			PostAttackAnimation = "ShadeShieldSlam_ReturnToIdle",
			PreAttackDuration = 0.35,
			FireDuration = 2.5,
			PostAttackDuration = 0.5,
			SkipAngleTowardTargetWait = false,

			AIAttackDistance = 700,
			AIBufferDistance = 650,
			FireCooldown = 0,

			MinAttacksBetweenUse = 1,
			--ForceUseIfReady = true,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	ShadeHunkerDownElite =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			PreAttackAnimation = "ShadeShield_PreSlam",
			FireAnimation = "ShadeShield_Slam",
			PostAttackAnimation = "ShadeShieldSlam_ReturnToIdle",
			PreAttackDuration = 0.35,
			FireDuration = 2.5,
			PostAttackDuration = 0.5,
			SkipAngleTowardTarget = false,
			SkipAngleTowardTargetWait = false,
			InstantAngleTowardsTarget = true, -- this is doing nothing

			AIAttackDistance = 700,
			AIBufferDistance = 650,
			FireCooldown = 0,

			MinAttacksBetweenUse = 1,
			--ForceUseIfReady = true,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},


	ShadeBowSideDash =
	{
		AIData =
		{
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.3,

			SkipMovement = true,

			CreateOwnTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistance = 200,

			AttackFailWeapon = "ShadeBowSideDash",

			--MinAttacksBetweenUse = 1,
		}
	},

	ShadeMagicSideDash =
	{
		AIData =
		{
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.1,

			SkipMovement = true,

			TargetSpawnPoints = true,
			TargetSpawnPointsPlayerRadius = 1200,
			TargetSpawnPointsPlayerRadiusMin = 600,

			AttackFailWeapon = "ShadeMagicSideDash",

			--MinAttacksBetweenUse = 1,
		}
	},

	ShadeBowRanged =
	{

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			MinPlayerDistance = 400,

			PreAttackDurationMin = 1.35,
			PreAttackDurationMax = 1.35,
			PostAttackDuration = 1.0,

			PreAttackEndShake = true,
			PreAttackAnimation = "ShadeBowStart",
			PreFireAnimation="ShadeBowCharge",
			PreFireDuration = 0.5,
			--FireDuration = 0.2,
			FireAnimation = "ShadeBowFire",
			--PostAttackAnimation = "ShadeBowFireEndLoop",

			AIAttackDistance = 920,
			AIBufferDistance = 300,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 150,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,
			SkipStopBeforePreAttackEnd = true,

			AIMoveWithinRangeTimeoutMin = 1.0,
 			AIMoveWithinRangeTimeoutMax = 3.0,
 			SkipAttackAfterMoveTimeout = true,
 			AttackFailWeapon = "ShadeBowSideDash",

			AIChargeTargetMarker = "ShadeBowTargetMarker",
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/BowFire" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	ShadeMagicMinigun =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			MinPlayerDistance = 550,

			PreAttackDuration = 0.3,
			PostAttackDuration = 0.25,

			PreAttackEndShake = true,
			PreAttackAnimation = "ShadeBowStart",
			PreFireAnimation="ShadeBowCharge",
			--FireDuration = 0.2,
			FireAnimation = "ShadeBowFire",
			--PostAttackAnimation = "ShadeBowFireEndLoop",

			AttackSound = "/SFX/Enemy Sounds/ShadeMagicUnit/EmoteAttackingSustained",

			AIAttackDistance = 920,
			AIBufferDistance = 300,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 150,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,

			AIMoveWithinRangeTimeoutMin = 3.0,
 			AIMoveWithinRangeTimeoutMax = 5.0,
 			SkipAttackAfterMoveTimeout = true,
 			AttackFailWeapon = "ShadeMagicSideDash",

 			AIFireTicksMin = 35,
 			AIFireTicksMax = 65,
 			FireCooldown = 0.05,
		},
	},

	ShadeMagicPokeCombo =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"ShadeMagicMinigunFast",
			"ShadeMagicSideDash",
		},
		AIData =
		{
			MaxConsecutiveUses = 3,
		}
	},

	ShadeMagicMinigunFast =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			MinPlayerDistance = 550,

			PreAttackDuration = 0.1,
			PostAttackDuration = 0.0,

			PreAttackEndShake = true,
			PreAttackAnimation = "ShadeBowStart",
			PreFireAnimation="ShadeBowCharge",
			--FireDuration = 0.2,
			FireAnimation = "ShadeBowFire",
			--PostAttackAnimation = "ShadeBowFireEndLoop",

			AttackSound = "/SFX/Enemy Sounds/ShadeMagicUnit/EmoteAttackingSustained",

			AIAttackDistance = 920,
			AIBufferDistance = 300,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 150,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,

			AIMoveWithinRangeTimeoutMin = 3.0,
 			AIMoveWithinRangeTimeoutMax = 5.0,
 			SkipAttackAfterMoveTimeout = true,
 			AttackFailWeapon = "ShadeMagicSideDash",

 			AIFireTicksMin = 5,
 			AIFireTicksMax = 10,
 			FireCooldown = 0.05,
		},
	},

	ShadeMagicRadialPush =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			ForceUseIfReady = true,
			MinAttacksBetweenUse = 2,
			MaxPlayerDistance = 250,

			SkipMovement = true,
			SkipAngleTowardTarget = true,

			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackAnimation = "ShadeBowStart",
			PreAttackDuration = 0.5,
			FireDuration = 0.5,
			PostAttackDuration = 0.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	ShadeMagicSkyVolley =
	{

		AIData =
		{
			DumbFireWeapons = { "ShadeMagicSkyVolleyFire" },

			PreAttackAnimation = "ShadeBowStart",
			PreFireAnimation="ShadeBowCharge",
			FireAnimation = "ShadeBowFire",

			PreAttackEndShake = false,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			SkipMovement = true,

			CreateOwnTarget = true,
			TargetAngleOptions = { 90 },
			TargetOffsetDistance = 200,

			MinAttacksBetweenUse = 4,
			ForceUseIfReady = true,
		},
	},

	ShadeMagicSkyVolleyFire =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			SkipMovement = true,

			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 0,
			TargetOffsetDistanceMax = 600,
			ResetTargetPerTick = true,
			AnchorTargetIdOnPlayer = true,

			PreAttackDuration = 0.8,

 			AIFireTicksMin = 15,
 			AIFireTicksMax = 15,
 			FireCooldown = 0.2,
		},
	},

	ShadeBowRangedRapidFire =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			MinPlayerDistance = 400,

			AIFireTicksMin = 3,
			AIFireTicksMax = 3,
			AIFireTicksCooldown = 0.1,

			PreAttackEndShake = true,
			PreAttackDurationMin = 1.1, -- values differ from above
			PreAttackDurationMax = 1.8, -- values differ from above
			PostAttackDuration = 1.0,

			PreAttackAnimation = "ShadeBowStart",
			PreFireAnimation="ShadeBowCharge",
			PreFireDuration = 0.35,
			FireAnimation = "ShadeBowFireLong",
			PostAttackAnimation = "ShadeBowFireEndLoop",

			AIAttackDistance = 920,
			AIBufferDistance = 300,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 150,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,
			SkipStopBeforePreAttackEnd = true,

			AIMoveWithinRangeTimeoutMin = 1.0,
 			AIMoveWithinRangeTimeoutMax = 3.0,
 			SkipAttackAfterMoveTimeout = true,
 			AttackFailWeapon = "ShadeBowSideDash",

			AIChargeTargetMarker = "ShadeBowTargetMarker",

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/BowFire" },
			},
		},
	},

	ShadeBowRangedRapidSalvo =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			MinPlayerDistance = 400,

			AIFireTicksMin = 9,
			AIFireTicksMax = 9,
			AIFireTicksCooldown = 0.1,

			PreAttackEndShake = true,
			PreAttackDurationMin = 1.1, -- values differ from above
			PreAttackDurationMax = 1.8, -- values differ from above
			PostAttackDuration = 1.0,

			PreAttackAnimation = "ShadeBowStart",
			PreFireAnimation="ShadeBowCharge",
			PreFireDuration = 0.35,
			FireAnimation = "ShadeBowFire",
			PostAttackAnimation = "ShadeBowFireEndLoop",

			AIAttackDistance = 920,
			AIBufferDistance = 300,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 150,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			SkipStopBeforePreAttackEnd = true,

			AIMoveWithinRangeTimeoutMin = 1.0,
 			AIMoveWithinRangeTimeoutMax = 3.0,
 			SkipAttackAfterMoveTimeout = true,
 			AttackFailWeapon = "ShadeBowSideDash",

			AIChargeTargetMarker = "ShadeBowTargetMarker",

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/BowFire" },
			},
		},
	},

	ShadeBowRangedSplitFire =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			MinPlayerDistance = 400,

			PreAttackDuration = 1.0,
			FireDuration = 1.4,
			PostAttackDuration = 1.0,

			PreAttackAnimation = "ShadeBowStart",
			PreFireAnimation = "ShadeBowCharge",
			FireAnimation = "ShadeBowFireLong",
			PostAttackAnimation = "ShadeBowFireEndLoop",

			AIAttackDistance = 750,
			AIBufferDistance = 700,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 150,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/BowFire" },
			},
		},
	},

	ShadeSpearThrustSingle =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			PreAttackAnimation = "ShadeSpear_PreAttack",
			FireAnimation = "ShadeSpear_Fire2",
			PostAttackAnimation = "ShadeSpearAttacks_ReturnToIdle",

			PreAttackDuration = 0.5,
			PreAttackEndShake = true,
			FireDuration = 0.3,
			PostAttackDuration = 0.5,

			AIAttackDistance = 230,
			AIBufferDistance = 200,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,

			MaxPlayerDistance = 450,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusSpearThrust" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	ShadeSpearThrust =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			PreAttackAnimation = "ShadeSpear_PreAttack",
			FireAnimation = "ShadeSpear_Fire2",
			PostAttackAnimation = "ShadeSpearAttacks_ReturnToIdle",

			PreAttackDuration = 0.5,
			PreAttackEndShake = true,
			FireDuration = 0.3,
			PostAttackDuration = 0.1,

			ChainedWeapon = "ShadeSpearThrust2",

			AIAttackDistance = 230,
			AIBufferDistance = 200,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,

			MaxPlayerDistance = 450,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusSpearThrust" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	ShadeSpearThrust2 =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.1 },
		},

		ChainedOnly = true,
		AIData =
		{
			PreAttackAnimation = "ShadeSpear_PreAttack",
			FireAnimation = "ShadeSpear_Fire2",
			PostAttackAnimation = "ShadeSpearAttacks_ReturnToIdle",

			PreAttackDuration = 0.3,
			PreAttackEndMinWaitTime = 0.25,
			FireDuration = 0.3,
			PostAttackDuration = 0.2,

			ChainedWeapon = "ShadeSpearThrust3",

			SkipMovement = true,
			SkipAngleTowardTarget = false,
			AIAttackDistance = 99999,
			AIBufferDistance = 99999,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = false,
		},
	},

	ShadeSpearThrust3 =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.1 },
		},

		ChainedOnly = true,
		AIData =
		{
			PreAttackAnimation = "ShadeSpear_PreAttack",
			FireAnimation = "ShadeSpear_Fire2",
			PostAttackAnimation = "ShadeSpearAttacks_ReturnToIdle",

			PreAttackDuration = 0.15,
			PreAttackEndMinWaitTime = 0.15,
			FireDuration = 0.3,
			PostAttackDuration = 0.7,
			PostAttackCooldownMin = 0.2,
			PostAttackCooldownMax = 0.6,

			SkipMovement = true,
			SkipAngleTowardTarget = false,
			AIAttackDistance = 99999,
			AIBufferDistance = 99999,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = false,
		},
	},

	ShadeSpearLeap =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			PreAttackAnimation = "ShadeSpear_LeapPreAttack",
			FireAnimation = "ShadeSpear_AttackLeapLaunch",
			PreAttackDuration = 0.55,
			PreAttackEndMinWaitTime = 0.3,
			FireDuration = 0.0,
			PostAttackDuration = 1.3,
			PostAttackCooldownMin = 0.4,
			PostAttackCooldownMax = 0.4,
			PreAttackEndShake = true,
			--PostAttackAnimation = "ShadeSpear_AttackLeap_ReturnToIdle",

			AIAttackDistance = 400,
			AIBufferDistance = 375,

			AIMoveWithinRangeTimeout = 6.0,

			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = false,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 150,

			MinAttacksBetweenUse = 1,
			MinPlayerDistance = 300,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/SFX/PlayerJumpMedium" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	ShadeSpearLeapSuper =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			PreAttackAnimation = "ShadeSpear_LeapPreAttack",
			FireAnimation = "ShadeSpear_AttackLeapLaunch",
			PreAttackDuration = 0.55,
			PreAttackEndMinWaitTime = 0.3,
			FireDuration = 0.0,
			PostAttackDuration = 1.6,
			PostAttackCooldownMin = 0.4,
			PostAttackCooldownMax = 0.4,
			--PostAttackAnimation = "ShadeSpear_AttackLeap_ReturnToIdle",

			AIAttackDistance = 400,
			AIBufferDistance = 375,

			AIMoveWithinRangeTimeout = 2.5,

			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 150,

			MinAttacksBetweenUse = 0,
			MinPlayerDistance = 0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/SFX/PlayerJumpMedium" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	ShadeSpearTouchdown =
	{
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/ArrowMetalStoneClang" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	FlurrySpawnerWeapon =
	{
		AIData =
		{
			PreattackSound = "/SFX/Enemy Sounds/FlurrySpawnerPreAttack"
		},
	},



	UnstableGeneratorWeapon =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			AttackSlots =
			{
				-- outer circle 2
				{ Angle = 337.5, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 315, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 292.5, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 270, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 247.5, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 225, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 202.5, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 180, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 157.5, OffsetDistance = 1800, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 135, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 112.5, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 90, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 67.5, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 45, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 22.5, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 0, OffsetDistance = 1350, OffsetScaleY = 0.55, OffsetFromAttacker = true },

				-- outer circle
				{ Angle = 337.5, OffsetDistance = 900, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 292.5, OffsetDistance = 900, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 247.5, OffsetDistance = 900, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 202.5, OffsetDistance = 900, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 157.5, OffsetDistance = 900, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 112.5, OffsetDistance = 900, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 67.5, OffsetDistance = 900, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 22.5, OffsetDistance = 900, OffsetScaleY = 0.55, OffsetFromAttacker = true },

				{ Angle = 270, OffsetDistance = 450, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 180, OffsetDistance = 450, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 90, OffsetDistance = 450, OffsetScaleY = 0.55, OffsetFromAttacker = true },
				{ Angle = 0, OffsetDistance = 450, OffsetScaleY = 0.55, OffsetFromAttacker = true },

				{ Angle = 0, OffsetDistance = 0, OffsetScaleY = 0.55, OffsetFromAttacker = true },
			},

			--FireAnimation = "FuryLightning",
			--PostAttackAnimation = "FuryLungeReturnToIdle",
			--AttackSound = "/SFX/Enemy Sounds/Megaera/EmoteSustainedAttacking",

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	SatyrRangedWeapon =
	{
		CauseImpactReaction = false,
		ImpactReactionHitsOverride = 0,

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },

		AIData =
		{
			DeepInheritance = true,

			StopDuration = 0.1,
			PreAttackDuration = 0.35,
			PostAttackDuration = 1.0,

			PreAttackAnimation = "SatyrRangedAttack_Start",
			PreAttackSound = "/Leftovers/SFX/SprintChargeUp",
			PreFireAnimation="SatyrRangedAttack_ChargeLoop",
			FireAnimation = "SatyrRangedAttack_Fire",
			PostAttackAnimation = "SatyrRangedAttack_ReturnToIdle",

			AIAttackDistance = 920,
			AIBufferDistance = 700,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 150,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,
			SkipStopBeforePreAttackEnd = true,

			AIMoveWithinRangeTimeoutMin = 1.0,
 			AIMoveWithinRangeTimeoutMax = 3.0,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Satyr/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusBowFire" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	SatyrMinigun =
	{
		InheritFrom = { "SatyrRangedWeapon" },

		AIData =
		{
			DeepInheritance = true,

			PreAttackAnimation = "SatyrMinibossRangedAttack_Start",
			PreFireAnimation="SatyrMinibossRangedAttack_ChargeLoop",
			FireAnimation = "SatyrMinibossRangedAttack_Fire",
			PostAttackAnimation = "SatyrMinibossRangedAttack_ReturnToIdle",

			AIFireTicksMin = 5,
			AIFireTicksMax = 7,
			AIFireTicksCooldown = 0.07,

			PostAttackDuration = 1.5,

			AttackSound = "/SFX/Enemy Sounds/Satyr/EmoteAttacking",
			PreAttackEndShake = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusBowFire" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	TimeCrystalDash =
	{
		AIData =
		{
			PreAttackDuration = 0.1,
			FireDuration = 0.0,
			PostAttackDuration = 0.75,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,

			CreateOwnTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistance = 1000,
			AIAngleTowardsPlayerWhileFiring = true,
			PreMoveAngleTowardTarget = true,

			AttackFailWeapon = "TimeCrystalDash",
		},
	},

	SatyrDash =
	{
		AIData =
		{
			PreAttackDuration = 0.1,
			FireDuration = 0.0,
			PostAttackDuration = 0.3,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,

			CreateOwnTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistance = 200,
			AIAngleTowardsPlayerWhileFiring = true,
			PreMoveAngleTowardTarget = true,

			AttackFailWeapon = "SatyrSideDash",
		},
	},

	SatyrSingleShot =
	{
		InheritFrom = { "SatyrRangedWeapon" },

		AIData =
		{
			DeepInheritance = true,

			StopDuration = 0.1,
			PreAttackDuration = 0.8,
			FireDuration = 0.3,
			PostAttackDuration = 0.8,

			AIAttackDistance = 920,
			AIBufferDistance = 1500,
		},
	},

	SatyrSplitShot =
	{
		InheritFrom = { "SatyrRangedWeapon" },

		AIData =
		{
			DeepInheritance = true,

			StopDuration = 0.1,
			PreAttackDuration = 0.6,
			FireDuration = 0.3,
			PostAttackDuration = 0.8,

			AIAttackDistance = 920,
			AIBufferDistance = 1500,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Satyr/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusBowRapidFire" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	RatThugMelee =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			PreAttackSound = "/SFX/Enemy Sounds/RatThug/EmoteCharging",
			PreAttackEndShake = true,
			PreAttackFlashSound = "/Leftovers/SFX/AuraOnLoud",
			AggroAnimation = "EnemyWretchSwarmerAlert",

			PreAttackAnimation = "EnemyRatThugAttackBite_Start",
			FireAnimation = "EnemyRatThugAttackBite_Fire",
			PostAttackAnimation = "EnemyRatThugAttackBite_ReturnToIdle",
			PreAttackDuration = 0.5,
			FireDuration = 0.3,
			PostAttackDuration = 0.4,

			AIAttackDistance = 250,
			AIBufferDistance = 175,

			AIMoveWithinRangeTimeoutMin = 5.0,
			AIMoveWithinRangeTimeoutMax = 8.0,
			SkipAttackAfterMoveTimeout = true,
			AttackFailWeapon = "RatPoisonShake",

			AIRequireProjectileLineOfSight = true,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 80,
			AILineOfSighEndBuffer = 32,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = false,
		},
	},

	RatThugMeleeMiniboss =
	{
		InheritFrom = { "RatThugMelee" },
	},


	HarpyLunge =
	{
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			PreAttackAnimation = "FuryLungeCharge",
			FireAnimation = "FuryLungeFire",
			PostAttackAnimation = "FuryLungeReturnToIdle",

			RemoveFromGroups = { "GroundEnemies" },

			FireDuration = 0.3,
			PreAttackDuration = 0.82,
			PostAttackDuration = 1.2,
			AIAttackDistance = 600,
			AIBufferDistance = 500,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 100,
			AIMoveWithinRangeTimeout = 10.0,

			MaxConsecutiveUses = 2,

			AITrackTargetDuringCharge = false,

			RageDumbFireWeapons = { "HarpyLungeRageBeam" },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.18, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	HarpyLungeAlecto =
	{
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			PreAttackAnimation = "Fury2LungeCharge",
			FireAnimation = "Fury2LungeFire",
			PostAttackAnimation = "Fury2LungeReturnToIdle",

			RemoveFromGroups = { "GroundEnemies" },

			FireDuration = 0.3,
			PreAttackDuration = 0.7,
			PreAttackEndMinWaitTime = 0.3,
			PostAttackDuration = 1.4,
			AIAttackDistance = 600,
			AIBufferDistance = 500,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 100,
			AIMoveWithinRangeTimeout = 10.0,

			MaxConsecutiveUses = 2,

			AITrackTargetDuringCharge = false,

			RageDumbFireWeapons = { "HarpyLungeRageBeamAlecto" },
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Alecto/EmoteCharging" },
			},
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Alecto/EmoteEvading" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	HarpyWhipArc =
	{
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			RageDumbFireWeapons = { "HarpyWhipRageBeam" },

			PreAttackAnimation = "Fury2BeamCharge",
			FireAnimation = "Fury2Beam",
			PostAttackAnimation = "Fury2LungeReturnToIdle",

			PreAttackDuration = 0.5,
			PreAttackEndMinWaitTime = 0.275,
			FireDuration = 0.1,
			PostAttackDuration = 1.0,
			AIAttackDistance = 300,
			AIBufferDistance = 250,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 100,
			AIMoveWithinRangeTimeout = 4.0,

			MaxConsecutiveUses = 1,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				CooldownTime = 60,
				SuccessiveChanceToPlay = 0.5,

				-- Pain...
				{ Cue = "/VO/Alecto_0110", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Hold it...
				{ Cue = "/VO/Alecto_0111", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Right here.
				{ Cue = "/VO/Alecto_0112", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Got you.
				{ Cue = "/VO/Alecto_0113", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Have another.
				{ Cue = "/VO/Alecto_0114", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Ready?
				{ Cue = "/VO/Alecto_0115", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Dodge this.
				{ Cue = "/VO/Alecto_0116" },
				-- Come closer.
				{ Cue = "/VO/Alecto_0117", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Don't move.
				{ Cue = "/VO/Alecto_0118", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Remember this?
				{ Cue = "/VO/Alecto_0119", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- I'll make you hurt.
				{ Cue = "/VO/Alecto_0120", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Stay there.
				{ Cue = "/VO/Alecto_0397", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Here!
				{ Cue = "/VO/Alecto_0398", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Why, you!
				{ Cue = "/VO/Alecto_0399", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Have this!
				{ Cue = "/VO/Alecto_0400", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Ready?!
				{ Cue = "/VO/Alecto_0401", RequiredPlayed = { "/VO/Alecto_0116" } },
				-- Want this?!
				{ Cue = "/VO/Alecto_0402", RequiredPlayed = { "/VO/Alecto_0116" } },
			},
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Alecto/EmoteCharging" },
			},
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Alecto/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	HarpyWhipCombo1 =
	{
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			PreAttackAnimation = "Fury3BeamCharge",
			FireAnimation = "Fury3WhipWhirlFire",

			FireDuration = 0.1,
			PreAttackDuration = 0.65,
			PreAttackEndShake = true,
			PostAttackDuration = 0.3,
			AIAttackDistance = 200,
			AIBufferDistance = 150,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 100,
			AILineOfSighEndBuffer = 150,
			AIMoveWithinRangeTimeout = 5.0,

			MaxConsecutiveUses = 1,

			ChainedWeapon = "HarpyWhipCombo2"
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Tisiphone/EmoteCharging" },
			},
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Tisiphone/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	HarpyWhipCombo2 =
	{
		GenusName = "HarpyWhipCombo1",
		ChainedOnly = true,
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			PreAttackAnimation = "Fury3BeamCharge",
			FireAnimation = "Fury3WhipWhirlFire",

			FireDuration = 0.1,
			PreAttackDuration = 0.1,
			PreAttackEndMinWaitTime = 0.1,
			PostAttackDuration = 0.1,
			PostAttackMinWaitTime = 0.1,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			AIRequireUnitLineOfSight = false,
			SkipAngleTowardTarget = false,
			InstantAngleTowardsTarget = true,
			SkipMovement = true,

			ChainedWeapon = "HarpyWhipCombo3"
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Tisiphone/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	HarpyWhipCombo3 =
	{
		GenusName = "HarpyWhipCombo1",
		ChainedOnly = true,
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			FireAnimation = "Fury3WhipWhirlFire",
			PostAttackAnimation = "Fury3LungeReturnToIdle",

			FireDuration = 0.1,
			PreAttackDuration = 0.3,
			PreAttackEndMinWaitTime = 0.25,
			PostAttackDuration = 1.5,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			AIRequireUnitLineOfSight = false,
			SkipAngleTowardTarget = true,
			SkipMovement = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Tisiphone/EmotePowerAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	HarpyWhipLasso =
	{
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			PreAttackAnimation = "TisiphoneWhipLassoCharge",
			PreAttackSound = "/SFX/Enemy Sounds/Tisiphone/EmoteCharging",
			FireAnimation = "TisiphoneWhipLassoFire",

			FireDuration = 0.5,
			PreAttackDuration = 1.0,
			PostAttackDuration = 0.0,
			AIAttackDistance = 850,
			AIBufferDistance = 800,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 100,
			AILineOfSighEndBuffer = 100,
			AIMoveWithinRangeTimeout = 5.0,
			AITrackTargetDuringCharge = true,

			ChainedWeapon = "HarpyLassoLunge",

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				CooldownTime = 60,
				SuccessiveChanceToPlay = 0.5,

				-- Murr....
				{ Cue = "/VO/Tisiphone_0046" },
				-- Murrrr....
				{ Cue = "/VO/Tisiphone_0047" },
				-- Mmmrrrr....
				{ Cue = "/VO/Tisiphone_0048" },
				-- Mrrnngh!
				{ Cue = "/VO/Tisiphone_0049" },
				-- Zrnngh....
				{ Cue = "/VO/Tisiphone_0142", RequiredTextLines = { "Fury3Encounter08" } },
				-- Zurrrr....
				{ Cue = "/VO/Tisiphone_0143", RequiredTextLines = { "Fury3Encounter08" } },
				-- Zzahhh...
				{ Cue = "/VO/Tisiphone_0144", RequiredTextLines = { "Fury3Encounter08" } },
				-- Zrrnngh!
				{ Cue = "/VO/Tisiphone_0145", RequiredTextLines = { "Fury3Encounter08" } },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Tisiphone/EmotePowerAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	FlurrySpawnerDash =
	{
		AIData =
		{
			DumbFireWeapons = { "FlurrySpawnerDashTrail" },

			MinAttacksBetweenUse = 1,
			ForceUseIfReady = true,
			RetreatAfterAttack = false,
		},
	},

	FlurrySpawnerDashTrail =
	{
		AIData =
		{
			FireTicks = 16,
			FireCooldown = 0.01,

			PreAttackDuration = 0.0,
		},
	},

	HarpyLassoLunge =
	{
		ChainedOnly = true,
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			RemoveFromGroups = { "GroundEnemies" },
			DumbFireWeapons = { "HarpyLungeSurgeBeam" },

			PreAttackAnimation = "Fury3LungeCharge",
			FireAnimation = "Fury3LungeFire",
			PostAttackAnimation = "Fury3LungeReturnToIdle",

			RemoveFromGroups = { "GroundEnemies" },

			FireDuration = 0.25,
			PreAttackDuration = 0.7,
			PostAttackDuration = 1.7,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			AIMoveWithinRangeTimeout = 2.0,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			AIRequireUnitLineOfSight = false,
			AILineOfSighEndBuffer = 100,
			SkipAngleTowardTarget = true,
			AITrackTargetDuringCharge = false,
			SkipMovement = true,
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Tisiphone/EmoteCharging" },
			},
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Tisiphone/EmoteEvading" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	HarpyWhipShot =
	{
		StartingWeapon = false,

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0 },
		},

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 1.0,
			PostAttackDuration = 0.3,
			PostAttackMinWaitTime = 0.2,
			FireDuration= 0.5,
			PreAttackAnimation = "AlectoWhipShotCharge",
			PreAttackSound = "/SFX/Enemy Sounds/Alecto/EmoteCharging",
			FireAnimation = "AlectoWhipShotFire",
			AIMoveWithinRangeTimeout = 4.0,

			MaxConsecutiveUses = 3,

			AIAttackDistance = 600,
			AIBufferDistance = 450,
			AIRequireUnitLineOfSight = false,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				CooldownTime = 60,
				SuccessiveChanceToPlay = 0.5,

				-- Take this!
				{ Cue = "/VO/Alecto_0079" },
				-- Pain.
				{ Cue = "/VO/Alecto_0081" },
				-- Try this!
				{ Cue = "/VO/Alecto_0082" },
				-- Catch this!
				{ Cue = "/VO/Alecto_0083" },
				-- Die already!
				{ Cue = "/VO/Alecto_0084" },
				-- Suffer!
				{ Cue = "/VO/Alecto_0089" },
				-- Catch!
				{ Cue = "/VO/Alecto_0090" },
				-- Here you go!
				{ Cue = "/VO/Alecto_0092" },
				-- Catch, redblood!
				{ Cue = "/VO/Alecto_0094" },
				-- How's this!
				{ Cue = "/VO/Alecto_0095" },
			},
			EnragedWeaponSwap = "HarpyWhipShotRage",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Alecto/EmotePowerAttacking" },
			},
		},

		Upgrades = { },
	},

	HarpyWhipShotRage =
	{
		InheritFrom = { "HarpyWhipShot" },
		GenusName = "HarpyWhipShot",

		AIData =
		{
			DeepInheritance = true,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				CooldownTime = 60,
				SuccessiveChanceToPlay = 0.5,

				-- I said die!
				{ Cue = "/VO/Alecto_0093" },
				-- Bleed!
				{ Cue = "/VO/Alecto_0091" },
				-- Nraaugh!
				{ Cue = "/VO/Alecto_0080" },
				-- Die!
				{ Cue = "/VO/Alecto_0087" },
				-- Kill!
				{ Cue = "/VO/Alecto_0088" },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Alecto/EmotePowerAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},
	},

	SummonAlectoWhipShot =
	{
		StartingWeapon = false,
		IgnoreOutgoingDamageModifiers = true,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			SkipMovement = true,
			SkipStopBeforeAttack = true,
			SkipStopBeforePreAttackEnd = true,

			PreAttackAnimation = "Fury2MultiFuryPreview",
			PreAttackDuration = 1.0,
      		FireAnimation = "AlectoMultiFurySkyDive",

      		--[[
      		PreAttackVoiceLines =
			{
				RandomRemaining = true,
				ObjectType = "Harpy",
				RequiresSourceAlive = true,
				PreLineWait = 0.15,
				Cooldowns =
				{
					{ Name = "MegaeraSupportSpeech" },
				},

				-- Alecto!
				{ Cue = "/VO/MegaeraField_0326" },
				-- Alecto...!
				{ Cue = "/VO/MegaeraField_0327" },
				-- Here, Alecto!
				{ Cue = "/VO/MegaeraField_0328" },
				-- Here, Alecto...!
				{ Cue = "/VO/MegaeraField_0329" },
				-- Alecto, now!
				{ Cue = "/VO/MegaeraField_0330" },
				-- Alecto, now!!
				{ Cue = "/VO/MegaeraField_0331" },
				-- Now, Alecto!
				{ Cue = "/VO/MegaeraField_0332" },
				-- Now, Alecto!!
				{ Cue = "/VO/MegaeraField_0333" },
				-- Alecto, get him!
				{ Cue = "/VO/MegaeraField_0334" },
				-- Alecto, bleed him!
				{ Cue = "/VO/MegaeraField_0335" },
			},
			{
				RandomRemaining = true,
				ObjectType = "Harpy3",
				RequiresSourceAlive = true,
				PreLineWait = 0.15,
				Cooldowns =
				{
					{ Name = "TisiphoneSupportSpeech" },
				},

				-- Murder. Murder!
				{ Cue = "/VO/Tisiphone_0089" },
				-- Murder...!
				{ Cue = "/VO/Tisiphone_0089" },
				-- Mmurdererr...
				{ Cue = "/VO/Tisiphone_0089" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				CooldownTime = 60,
				SuccessiveChanceToPlay = 0.5,

				-- I said die!
				{ Cue = "/VO/Alecto_0093" },
				-- Bleed!
				{ Cue = "/VO/Alecto_0091" },
				-- Nraaugh!
				{ Cue = "/VO/Alecto_0080" },
				-- Die!
				{ Cue = "/VO/Alecto_0087" },
				-- Kill!
				{ Cue = "/VO/Alecto_0088" },
			},
			]]--
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Alecto/EmotePowerAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},
	},

	HarpyWhipWhirl =
	{
		StartingWeapon = false,

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.20, Fraction = 1.0, LerpTime = 0 },
		},

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			PreAttackDuration = 1.0,
			PostAttackDuration = 0.3,
			PostAttackMinWaitTime = 0.2,
			PreAttackAnimation = "FuryWhipWhirlCharge",
			PreAttackSound = "/SFX/Enemy Sounds/Megaera/EmoteCharging",
			FireAnimation = "FuryWhipWhirlFire",
			PostAttackAnimation = "FuryLungeReturnToIdle",
			AIMoveWithinRangeTimeout = 4.0,

			MinAttacksBetweenUse = 2,
			MaxPlayerDistance = 600,

			AIAttackDistance = 200,
			AIBufferDistance = 125,
			AIRequireUnitLineOfSight = false,

			PreAttackVoiceLines =
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.35,
					CooldownTime = 60,
					CooldownName = "MegaeraWhipWhirlPlayedRecently",
					RequiredFalseTextLines = { "MegaeraGift10" },
					SuccessiveChanceToPlay = 0.2,

					-- You are a waste of time.
					{ Cue = "/VO/MegaeraField_0083" },
					-- Hold it right there.
					{ Cue = "/VO/MegaeraField_0084" },
					-- I'll make this quick.
					{ Cue = "/VO/MegaeraField_0085" },
					-- Beg me for mercy, fool.
					{ Cue = "/VO/MegaeraField_0086" },
					-- You want a taste of this?
					{ Cue = "/VO/MegaeraField_0087" },
					-- Come closer, Zagreus.
					{ Cue = "/VO/MegaeraField_0088" },
					-- You stay right there.
					{ Cue = "/VO/MegaeraField_0089" },
					-- Come closer.
					{ Cue = "/VO/MegaeraField_0256" },
					-- Don't go anywhere.
					{ Cue = "/VO/MegaeraField_0257" },
					-- One lash is not enough.
					{ Cue = "/VO/MegaeraField_0258" },
					-- You like my whip?
					{ Cue = "/VO/MegaeraField_0259" },
					-- Here's my whip!
					{ Cue = "/VO/MegaeraField_0260" },
					-- I'll make you hurt.
					{ Cue = "/VO/MegaeraField_0261" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.35,
					CooldownTime = 60,
					CooldownName = "MegaeraWhipWhirlPlayedRecently",
					RequiredTextLines = { "MegaeraGift10" },
					SuccessiveChanceToPlay = 0.2,

					-- Hold it right there.
					{ Cue = "/VO/MegaeraField_0084" },
					-- Come closer, Zagreus.
					{ Cue = "/VO/MegaeraField_0088" },
					-- You stay right there.
					{ Cue = "/VO/MegaeraField_0089" },
					-- Come closer.
					{ Cue = "/VO/MegaeraField_0256" },
					-- Don't go anywhere.
					{ Cue = "/VO/MegaeraField_0257" },
					-- One lash is not enough.
					{ Cue = "/VO/MegaeraField_0258" },
					-- You like my whip?
					{ Cue = "/VO/MegaeraField_0259" },
					-- Here's my whip!
					{ Cue = "/VO/MegaeraField_0260" },
					-- I'll make you hurt.
					{ Cue = "/VO/MegaeraField_0261" },
					-- You like my whip?
					{ Cue = "/VO/MegaeraField_0619" },
					-- Don't go anywhere.
					{ Cue = "/VO/MegaeraField_0620" },
					-- You stay right there.
					{ Cue = "/VO/MegaeraField_0621" },
					-- You can't run away.
					{ Cue = "/VO/MegaeraField_0622" },
					-- Stay there.
					{ Cue = "/VO/MegaeraField_0623" },
					-- This won't hurt much.
					{ Cue = "/VO/MegaeraField_0624" },
					-- This will sting.
					{ Cue = "/VO/MegaeraField_0625" },
				},
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/EmotePowerAttacking" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	SummonMegaeraWhipWhirl =
	{
		StartingWeapon = false,
		IgnoreOutgoingDamageModifiers = true,

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.20, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			SkipMovement = true,
			SkipStopBeforeAttack = true,
			SkipStopBeforePreAttackEnd = true,

			PreAttackAnimation = "FuryMultiFuryPreview",
			PreAttackDuration = 1.0,
			FireAnimation = "MegaeraMultiFurySkyDive",

			--[[
			PreAttackVoiceLines =
			{
				{
					RandomRemaining = true,
					ObjectType = "Harpy2",
					RequiresSourceAlive = true,
					PreLineWait = 0.15,
					Cooldowns =
					{
						{ Name = "AlectoSupportSpeech" },
					},

					-- Megaera!
					{ Cue = "/VO/Alecto_0257" },
					-- Megaera...!
					{ Cue = "/VO/Alecto_0258" },
					-- Here, Megaera!
					{ Cue = "/VO/Alecto_0259" },
					-- Here, Megaera...!
					{ Cue = "/VO/Alecto_0260" },
					-- Megaera, now!
					{ Cue = "/VO/Alecto_0261" },
					-- Megaera, now!!
					{ Cue = "/VO/Alecto_0262" },
					-- Now, Megaera!
					{ Cue = "/VO/Alecto_0263" },
					-- Now, Megaera!!
					{ Cue = "/VO/Alecto_0264" },
					-- Megaera, get him!
					{ Cue = "/VO/Alecto_0265" },
					-- Megaera, bleed him!
					{ Cue = "/VO/Alecto_0266" },
				},
				{
					RandomRemaining = true,
					ObjectType = "Harpy3",
					RequiresSourceAlive = true,
					PreLineWait = 0.15,
					Cooldowns =
					{
						{ Name = "TisiphoneSupportSpeech" },
					},

					-- Murder. Murder!
					{ Cue = "/VO/Tisiphone_0089" },
					-- Murder...!
					{ Cue = "/VO/Tisiphone_0089" },
					-- Mmurdererr...
					{ Cue = "/VO/Tisiphone_0089" },
				},
			},
			]]--
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/EmotePowerAttacking" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},
	NPC_Thanatos_01_Assist =
	{
		StartingWeapon = false,
		IgnoreOutgoingDamageModifiers = true,	
	},

	NPC_FurySister_01_Assist =
	{
		StartingWeapon = false,
		IgnoreOutgoingDamageModifiers = true,

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0 },
		},
		Binks =
		{
			"Enemy_MegaeraMultiFurySkyDive_Bink"
		},
	},

	NPC_Sisyphus_01_Assist =
	{
		StartingWeapon = false,
		IgnoreOutgoingDamageModifiers = true,

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.3, Duration = 0.28 },
		},

		HitScreenshake = { Distance = 10, Speed = 2000, Duration = 1.0, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.20, Fraction = 1.0, LerpTime = 0 },
		},

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 10,

		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
				StoneObstacle = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/ArrowWallHitClankSmall",
				MetalObstacle = "/SFX/ArrowWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	NPC_Achilles_01_Assist =
	{
		StartingWeapon = false,		
		IgnoreOutgoingDamageModifiers = true,

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.15, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 0.20, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
		Binks =
		{
			"NPC_AchillesKeepSake_Bink"
		},
	},
	NPC_Patroclus_01_Assist =
	{
		StartingWeapon = false,
		IgnoreOutgoingDamageModifiers = true,
		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.15, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 0.20, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
		Binks =
		{
			"NPC_PatroclusKeepSake_Bink"
		},
	},

	HarpyBeam =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 15,
			FireCooldown = 0.25,
			FireInterval = 6,
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackAnimation = "FuryBeamCharge",
			FireAnimation = "FuryBeam",
			PostAttackAnimation = "FuryLungeReturnToIdle",
			AttackSound = "/SFX/Enemy Sounds/Megaera/EmoteSustainedAttacking",
			PreAttackDuration = 0.5,
			PostAttackDuration = 1.5,

			AIAttackDistance = 1200,
			AIBufferDistance = 800,

			MinAttacksBetweenUse = 3,

			AITrackTargetDuringCharge = false,

			PreAttackVoiceLines =
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.15,
					CooldownTime = 35,
					SuccessiveChanceToPlay = 0.5,
					RequiredFalseTextLines = { "MegaeraGift10" },

					-- Take this!
					{ Cue = "/VO/MegaeraField_0064" },
					-- Try this!
					{ Cue = "/VO/MegaeraField_0065" },
					-- Catch this!
					{ Cue = "/VO/MegaeraField_0066" },
					-- Dodge this!
					{ Cue = "/VO/MegaeraField_0067" },
					-- Eat this!
					{ Cue = "/VO/MegaeraField_0068" },
					-- Here!
					{ Cue = "/VO/MegaeraField_0069" },
					-- Here!
					{ Cue = "/VO/MegaeraField_0760" },
					-- Die!
					{ Cue = "/VO/MegaeraField_0070" },
					-- Kill!
					{ Cue = "/VO/MegaeraField_0071" },
					-- Suffer!
					{ Cue = "/VO/MegaeraField_0072" },
					-- Catch!
					{ Cue = "/VO/MegaeraField_0073" },
					-- Here then!
					{ Cue = "/VO/MegaeraField_0241" },
					-- I said die!
					{ Cue = "/VO/MegaeraField_0242", RequiredPlayed = { "/VO/MegaeraField_0070" }, },
					-- Catch, Zagreus!
					{ Cue = "/VO/MegaeraField_0243" },
					-- How about this!
					{ Cue = "/VO/MegaeraField_0244" },
				},
				-- max relationship
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.15,
					CooldownTime = 35,
					SuccessiveChanceToPlay = 0.5,
					RequiredTextLines = { "MegaeraGift10" },

					-- For you!
					{ Cue = "/VO/MegaeraField_0758" },
					-- Zagreus!
					{ Cue = "/VO/MegaeraField_0759" },
					-- Here!
					{ Cue = "/VO/MegaeraField_0760" },
					-- All right!
					{ Cue = "/VO/MegaeraField_0761" },
					-- Ready?
					{ Cue = "/VO/MegaeraField_0600" },
					-- Ready!
					{ Cue = "/VO/MegaeraField_0601" },
					-- All right.
					{ Cue = "/VO/MegaeraField_0602" },
					-- Now...
					{ Cue = "/VO/MegaeraField_0603" },
					-- Zagreus!
					{ Cue = "/VO/MegaeraField_0604" },
					-- How about this!
					{ Cue = "/VO/MegaeraField_0605" },
					-- Swarm!
					{ Cue = "/VO/MegaeraField_0606" },
					-- You!
					{ Cue = "/VO/MegaeraField_0607" },
					-- Fine!
					{ Cue = "/VO/MegaeraField_0608" },
					-- Run!
					{ Cue = "/VO/MegaeraField_0609" },
					-- Catch this!
					{ Cue = "/VO/MegaeraField_0066" },
					-- Dodge this!
					{ Cue = "/VO/MegaeraField_0067" },
					-- Eat this!
					{ Cue = "/VO/MegaeraField_0068" },
					-- Catch!
					{ Cue = "/VO/MegaeraField_0073" },
				}
			},
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/EmoteCharging" },
			},
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire" },
			},
		},

		Upgrades = { },
	},

	SummonMegaeraHarpyBeam =
	{
		StartingWeapon = false,
		IgnoreOutgoingDamageModifiers = true,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			SkipMovement = true,
			SkipStopBeforeAttack = true,
			SkipStopBeforePreAttackEnd = true,

			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistance = 350,
			ResetTargetPerTick = true,

			PreAttackAnimation = "FuryMultiFuryPreview",
			PreAttackDuration = 1.0,
			FireAnimation = "MegaeraMultiFurySkyDive",

			--[[
			PreAttackVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					ObjectType = "Harpy2",
					RequiresSourceAlive = true,
					PreLineWait = 0.15,
					Cooldowns =
					{
						{ Name = "AlectoSupportSpeech" },
					},

					-- Megaera!
					{ Cue = "/VO/Alecto_0257" },
					-- Megaera...!
					{ Cue = "/VO/Alecto_0258" },
					-- Here, Megaera!
					{ Cue = "/VO/Alecto_0259" },
					-- Here, Megaera...!
					{ Cue = "/VO/Alecto_0260" },
					-- Megaera, now!
					{ Cue = "/VO/Alecto_0261" },
					-- Megaera, now!!
					{ Cue = "/VO/Alecto_0262" },
					-- Now, Megaera!
					{ Cue = "/VO/Alecto_0263" },
					-- Now, Megaera!!
					{ Cue = "/VO/Alecto_0264" },
					-- Megaera, get him!
					{ Cue = "/VO/Alecto_0265" },
					-- Megaera, bleed him!
					{ Cue = "/VO/Alecto_0266" },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					ObjectType = "Harpy3",
					RequiresSourceAlive = true,
					PreLineWait = 0.15,
					Cooldowns =
					{
						{ Name = "TisiphoneSupportSpeech" },
					},

					-- Murder. Murder!
					{ Cue = "/VO/Tisiphone_0089" },
					-- Murder...!
					{ Cue = "/VO/Tisiphone_0089" },
					-- Mmurdererr...
					{ Cue = "/VO/Tisiphone_0089" },
				}
			},
			]]--
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/EmoteCharging" },
			},
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire" },
			},
		},

		Upgrades = { },
	},

	HarpySlowBeam360 =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			RageDumbFireWeapons = { "HarpyLungeSurgeBeam" },

			FireTicks = 3,
			FireCooldown = 0.9,

			PreAttackAnimation = "Fury3BeamCharge",
			FireAnimation = "Fury3Beam",
			PostAttackAnimation = "Fury3LungeReturnToIdle",
			AttackSound = "/SFX/Enemy Sounds/Tisiphone/EmoteSustainedAttacking",
			PreAttackDuration = 0.5,
			PostAttackDuration = 1.5,


			AIAttackDistance = 1200,
			AIBufferDistance = 800,

			MinAttacksBetweenUse = 2,

			AITrackTargetDuringCharge = false,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				CooldownTime = 60,
				SuccessiveChanceToPlay = 0.33,

				-- Murderrr!!
				{ Cue = "/VO/Tisiphone_0034" },
				-- Murrrr...!
				{ Cue = "/VO/Tisiphone_0035" },
				-- Mmmurder!
				{ Cue = "/VO/Tisiphone_0036" },
				-- Mmmm!!!
				{ Cue = "/VO/Tisiphone_0037" },
				-- Murderrerr!
				{ Cue = "/VO/Tisiphone_0038" },
				-- Murderrr!!
				{ Cue = "/VO/Tisiphone_0039" },
				-- Zzagreuss!!
				{ Cue = "/VO/Tisiphone_0130", RequiredTextLines = { "Fury3Encounter10" } },
				-- Zrrnnh...!
				{ Cue = "/VO/Tisiphone_0131", RequiredTextLines = { "Fury3Encounter08" } },
				-- Zzagreus!
				{ Cue = "/VO/Tisiphone_0132", RequiredTextLines = { "Fury3Encounter10" } },
				-- Zzhh!!!
				{ Cue = "/VO/Tisiphone_0133", RequiredTextLines = { "Fury3Encounter08" } },
				-- Zagreeusss!
				{ Cue = "/VO/Tisiphone_0134", RequiredTextLines = { "Fury3Encounter10" } },
				-- Zagreus!!
				{ Cue = "/VO/Tisiphone_0135", RequiredTextLines = { "Fury3Encounter10" } },
			},
		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Tisiphone/EmoteCharging" },
			},
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Tisiphone/TisiphoneHarpySlowBeam" },
			},
		},

		Upgrades = { },
	},

	HarpyLungeSurgeBeam =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 8,
			FireCooldown = 0.02,

			AttackSound = "/SFX/Enemy Sounds/Megaera/EmoteSustainedAttacking",
			PreAttackDuration = 0.0,
			PostAttackDuration = 0.0,

			AIAttackDistance = 1200,
			AIBufferDistance = 800,

			AITrackTargetDuringCharge = false,
		},

		Upgrades = { },
	},

	HarpyWhipRageBeam =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			AttackSound = "/SFX/Enemy Sounds/Alecto/EmoteSustainedAttackingAlt",

			AIAttackDistance = 300,
			AIBufferDistance = 250,

			PreAttackDuration = 0.1,
			PostAttackDuration = 0.0,
		},

		Upgrades = { },
	},

	HarpyLungeRageBeam =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 3,
			FireCooldown = 0.15,
			AttackSound = "/SFX/Enemy Sounds/Megaera/EmoteSustainedAttacking",

			AIAttackDistance = 1200,
			AIBufferDistance = 800,

			PreAttackDuration = 0.0,
			PostAttackDuration = 0.0,
		},

		Upgrades = { },
	},

	HarpyLungeRageBeamAlecto =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 3,
			FireCooldown = 0.15,
			AttackSound = "/SFX/Enemy Sounds/Alecto/EmoteSustainedAttackingAlt",

			AIAttackDistance = 1200,
			AIBufferDistance = 800,

			PreAttackDuration = 0.0,
			PostAttackDuration = 0.0,
		},

		Upgrades = { },
	},


	TheseusChariotCenterDive =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		GenusName = "TheseusChariotCenterDive",
		BlockInterrupt = true,

		AIData =
		{
			DeepInheritance = true,
			PathWeapon = true,
			ChainedWeapon = "TheseusChariotCenterDive2",

			SkipStopBeforePreAttackEnd = true,
			SkipStopBeforeAttack = true,
			AIAngleTowardsPlayerWhileFiring = false,
			SkipMovement = true,
			SkipAngleTowardTarget = true,

			AIMoveWithinRangeTimeout = 2.0,

			ReloadingLoopSound = "/SFX/Player Sounds/ZagreusGunGrenadeReloading",

			PreAttackDuration = 0.4,
			FireTicks = 16,
			FireCooldown = 0.1,
			PostAttackDuration = 0.0,

			EndOnFlagName = "Dismounted",

			MovementEffectName = "ChariotBoosters",

			MoveSuccessDistance = 25,
			PatrolPaths =
			{
				{
					[1] = 543047,
					[2] = 543043,
					[3] = 543050,
					[4] = 543053,
					[5] = 543052,
					[6] = 543051,
					[7] = 543048,
				},
				{
					[1] = 543037,
					[2] = 543038,
					[3] = 543051,
					[4] = 543055,
					[5] = 543052,
					[6] = 543050,
					[7] = 543044,
				},
			},
			FireOncePerPatrol = true,
			PatrolNearestStartId = true,
			FireAfterPatrolIndex = 3,

			MaxConsecutiveUses = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Theseus/TheseusGunFire" },
			},
		},

		Upgrades = { },
	},

	TheseusChariotCenterDive2 =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		GenusName = "TheseusChariotCenterDive",

		AIData =
		{
			DeepInheritance = true,
			PathWeapon = true,

			SkipStopBeforePreAttackEnd = true,
			SkipStopBeforeAttack = true,
			AIAngleTowardsPlayerWhileFiring = false,
			SkipMovement = true,
			SkipAngleTowardTarget = true,

			AIMoveWithinRangeTimeout = 2.0,

			PostAttackSound = "/SFX/Player Sounds/ZagreusGunGrenadeReloading",
			PreAttackSound = "/SFX/Enemy Sounds/Theseus/EmoteManiacalLaugh",
			PreAttackLoopingSound = "/SFX/Enemy Sounds/Theseus/TheseusGunSpinLoop",
			PreAttackLoopingEndSound = "/SFX/Enemy Sounds/Theseus/TheseusGunSpinEnd",

			PreAttackDuration = 0.4,
			FireTicks = 16,
			FireCooldown = 0.1,
			PostAttackDuration = 0.0,

			EndOnFlagName = "Dismounted",

			MovementEffectName = "ChariotBoosters",

			PatrolPaths =
			{
				{
					[1] = 543048,
					[2] = 543042,
					[3] = 543054,
					[4] = 543049,
					[5] = 543046,
					[6] = 543037,
				},
				{
					[1] = 543044,
					[2] = 543049,
					[3] = 543056,
					[4] = 543052,
					[5] = 543042,
					[6] = 543047,
				},
			},
			FireOncePerPatrol = true,
			PatrolNearestStartId = true,
			FireAfterPatrolIndex = 3,
		},

		PreAttackVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.15,
			CooldownTime = 60,

			-- Open fire!!
			{ Cue = "/VO/Theseus_0329" },
			-- Fire!
			{ Cue = "/VO/Theseus_0330" },
			-- Firing!
			{ Cue = "/VO/Theseus_0331" },
			-- Now, fire!!
			{ Cue = "/VO/Theseus_0332" },
			-- Commence fire!
			{ Cue = "/VO/Theseus_0333" },
			-- Commence firing!
			{ Cue = "/VO/Theseus_0334" },
			-- Chambers ready!
			{ Cue = "/VO/Theseus_0335" },
			-- Chambers set!
			{ Cue = "/VO/Theseus_0336" },
			-- Fully armed!
			{ Cue = "/VO/Theseus_0337" },
			-- In my sights!
			{ Cue = "/VO/Theseus_0338" },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Theseus/TheseusGunFire" },
			},
		},

		Upgrades = { },
	},


	TheseusChariotClusterBomb =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		BlockInterrupt = true,
		AIData =
		{
			DeepInheritance = true,
			PathWeapon = true,

			SkipStopBeforePreAttackEnd = true,
			SkipStopBeforeAttack = true,
			AIAngleTowardsPlayerWhileFiring = false,
			SkipMovement = true,
			SkipAngleTowardTarget = true,

			ReloadingLoopSound = "/SFX/Player Sounds/ZagreusGunGrenadeReloading",

			PreAttackDuration = 0.05,
			FireTicks = 7,
			FireCooldown = 0.35,
			PostAttackDuration = 0.0,

			EndOnFlagName = "Dismounted",

			MoveSuccessDistance = 25,
			PatrolPaths =
			{
				{
					[1] = 543047,
					[2] = 543787,
					[3] = 543052,
					[4] = 543037,
				},
				{
					[1] = 543037,
					[2] = 543788,
					[3] = 543052,
					[4] = 543047,
				},
			},
			FireOncePerPatrol = true,
			PatrolNearestStartId = true,
			FireAfterPatrolIndex = 2,

			MinAttacksBetweenUse = 1,
			BlockAsFirstWeapon = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Theseus/TheseusMortarLaunch" },
			},
		},

		Upgrades = { },
	},

	HarpyLightning =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		ShrineMetaUpgradeName = "BossDifficultyShrineUpgrade",
		ShrineMetaUpgradeRequiredLevel = 1,
		ShrineAIDataOverwrites =
		{
			FireCooldown = 0.6
		},

		AIData =
		{
			FireTicks = 5,
			AttackSlotsPerTickMin = 3,
			AttackSlotsPerTickMax = 4,
			AttackSlots =
			{
				{ Angle = 0, OffsetDistance = 0, OffsetScaleY = 0.48 },
				{ Angle = 0, OffsetDistance = 425, OffsetScaleY = 0.48 },
				{ Angle = 90, OffsetDistance = 425, OffsetScaleY = 0.48 },
				{ Angle = 180, OffsetDistance = 425, OffsetScaleY = 0.48 },
				{ Angle = 270, OffsetDistance = 425, OffsetScaleY = 0.48 },
			},
			PreAttackDuration = 0.5,
			FireCooldown = 1.2,
			AIAngleTowardsPlayerWhileFiring = false,
			FireAnimation = "FuryLightning",
			PostAttackAnimation = "FuryLungeReturnToIdle",
			AttackSound = "/SFX/Enemy Sounds/Megaera/EmoteSustainedAttacking",
			PostAttackDuration = 0.6,

			MinAttacksBetweenUse = 3,

			PreAttackVoiceLines =
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.15,
					CooldownTime = 60,
					RequiredFalseTextLines = { "MegaeraGift10" },
					SuccessiveChanceToPlay = 0.5,

					-- Blood and darkness!
					{ Cue = "/VO/MegaeraField_0074" },
					-- You asked for this!
					{ Cue = "/VO/MegaeraField_0075" },
					-- Start running, fool!
					{ Cue = "/VO/MegaeraField_0076" },
					-- I'll kill you where you stand!
					{ Cue = "/VO/MegaeraField_0077" },
					-- Enough!
					{ Cue = "/VO/MegaeraField_0078" },
					-- Run for it, little man!
					{ Cue = "/VO/MegaeraField_0079" },
					-- Have some of this...!
					{ Cue = "/VO/MegaeraField_0081" },
					-- I'll make you pay...!
					{ Cue = "/VO/MegaeraField_0082" },
					-- You better run.
					{ Cue = "/VO/MegaeraField_0245" },
					-- Run.
					{ Cue = "/VO/MegaeraField_0246" },
					-- Run!
					{ Cue = "/VO/MegaeraField_0247" },
					-- Hold still.
					{ Cue = "/VO/MegaeraField_0248" },
					-- Hold still!
					{ Cue = "/VO/MegaeraField_0249" },
					-- Suffer in darkness!
					{ Cue = "/VO/MegaeraField_0250" },
					-- Look out below.
					{ Cue = "/VO/MegaeraField_0251" },
					-- Why won't you give up?
					{ Cue = "/VO/MegaeraField_0252" },
					-- Stand still for me.
					{ Cue = "/VO/MegaeraField_0253" },
					-- Stand still!
					{ Cue = "/VO/MegaeraField_0254" },
					-- I'll get you.
					-- { Cue = "/VO/MegaeraField_0255" },
					-- Pin him down!
					{ Cue = "/VO/MegaeraField_0766", RequiredAnyActiveEnemyTypes = { "HeavyMelee", "LightRanged" } },
					-- Get him!
					{ Cue = "/VO/MegaeraField_0767", RequiredAnyActiveEnemyTypes = { "HeavyMelee", "LightRanged" } },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.15,
					CooldownTime = 60,
					RequiredTextLines = { "MegaeraGift10" },
					SuccessiveChanceToPlay = 0.5,

					-- Here, Zag!
					{ Cue = "/VO/MegaeraField_0610" },
					-- Start running!
					{ Cue = "/VO/MegaeraField_0611" },
					-- All right!
					{ Cue = "/VO/MegaeraField_0612" },
					-- You know what's coming!
					{ Cue = "/VO/MegaeraField_0613" },
					-- You ready?
					{ Cue = "/VO/MegaeraField_0614" },
					-- Watch your step!
					{ Cue = "/VO/MegaeraField_0615" },
					-- Better move.
					{ Cue = "/VO/MegaeraField_0616" },
					-- Hold it!
					{ Cue = "/VO/MegaeraField_0617" },
					-- I'll get you.
					{ Cue = "/VO/MegaeraField_0618" },
					-- You can't escape from me.
					{ Cue = "/VO/MegaeraField_0080" },
					-- You better run.
					{ Cue = "/VO/MegaeraField_0245" },
					-- Run.
					{ Cue = "/VO/MegaeraField_0246" },
					-- Run!
					{ Cue = "/VO/MegaeraField_0247" },
					-- Look out below.
					{ Cue = "/VO/MegaeraField_0251" },
					-- Stand still for me.
					{ Cue = "/VO/MegaeraField_0253" },
					-- That does it.
					{ Cue = "/VO/MegaeraField_0762" },
					-- Run, Zag.
					{ Cue = "/VO/MegaeraField_0763" },
					-- All right.
					{ Cue = "/VO/MegaeraField_0764" },
					-- Try this.
					{ Cue = "/VO/MegaeraField_0765" },
					-- Pin him down!
					{ Cue = "/VO/MegaeraField_0766", RequiredAnyActiveEnemyTypes = { "HeavyMelee", "LightRanged" } },
					-- Get him!
					{ Cue = "/VO/MegaeraField_0767", RequiredAnyActiveEnemyTypes = { "HeavyMelee", "LightRanged" } },
				},
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	HarpyLightningChase =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			EnragedWeaponSwap = "HarpyLightningChaseRage",
			FireTicks = 6,
			FireCooldown = 1.2,
			AIAngleTowardsPlayerWhileFiring = false,
			PreAttackDuration = 0.2,
			FireAnimation = "Fury2LightningLoop",
			PostAttackAnimation = "Fury2LightningReturnToIdle",
			AttackSound = "/SFX/Enemy Sounds/Alecto/EmoteSustainedAttacking",
			PostAttackDuration = 0.75,
			SkipStopBeforeAttack = true,
			SkipStopBeforePreAttackEnd = true,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			AIMoveWithinRangeTimeout = 1.0,
			MoveSuccessDistance = 450,

			MinAttacksBetweenUse = 5,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				CooldownTime = 60,
				SuccessiveChanceToPlay = 0.5,

				-- Pain...
				{ Cue = "/VO/Alecto_0110" },
				-- Now!!
				{ Cue = "/VO/Alecto_0174" },
				-- That's it!
				{ Cue = "/VO/Alecto_0166" },
				-- My turn.
				{ Cue = "/VO/Alecto_0167" },
				-- That does it!
				{ Cue = "/VO/Alecto_0168" },
				-- Eat this!
				{ Cue = "/VO/Alecto_0085" },
				-- Here!
				{ Cue = "/VO/Alecto_0086" },
				-- <Laughter>
				{ Cue = "/VO/Alecto_0309" },
				-- <Laughter>
				{ Cue = "/VO/Alecto_0310" },
			},
		},
	},

	HarpyLightningChaseRage =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 8,
			FireCooldown = 0.8,
			AIAngleTowardsPlayerWhileFiring = false,
			PreAttackDuration = 0.2,
			FireAnimation = "Fury2LightningLoop",
			PostAttackAnimation = "Fury2LightningReturnToIdle",
			AttackSound = "/SFX/Enemy Sounds/Alecto/EmoteSustainedAttacking",
			PostAttackDuration = 0.75,
			SkipStopBeforeAttack = true,
			SkipStopBeforePreAttackEnd = true,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			MoveSuccessDistance = 450,

			MinAttacksBetweenUse = 5,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				CooldownTime = 60,
				SuccessiveChanceToPlay = 0.5,

				-- Now!!
				{ Cue = "/VO/Alecto_0174" },
				-- That's it!
				{ Cue = "/VO/Alecto_0166" },
				-- That does it!
				{ Cue = "/VO/Alecto_0168" },
				-- Eat this!
				{ Cue = "/VO/Alecto_0085" },
				-- Here!
				{ Cue = "/VO/Alecto_0086" },
			},
		},
	},

	SummonAlectoLightningChase =
	{
		StartingWeapon = false,
		IgnoreOutgoingDamageModifiers = true,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 12,
			FireCooldown = 0.6,
			SkipMovement = true,
			SkipStopBeforeAttack = true,
			SkipStopBeforePreAttackEnd = true,

			PreAttackAnimation = "Fury2MultiFuryPreview",
			PreAttackDuration = 1.0,
			FireAnimation = "AlectoMultiFurySkyDive",

			--[[
      		PreAttackVoiceLines =
			{
				RandomRemaining = true,
				ObjectType = "Harpy",
				RequiresSourceAlive = true,
				PreLineWait = 0.15,
				Cooldowns =
				{
					{ Name = "MegaeraSupportSpeech" },
				},

				-- Alecto!
				{ Cue = "/VO/MegaeraField_0326" },
				-- Alecto...!
				{ Cue = "/VO/MegaeraField_0327" },
				-- Here, Alecto!
				{ Cue = "/VO/MegaeraField_0328" },
				-- Here, Alecto...!
				{ Cue = "/VO/MegaeraField_0329" },
				-- Alecto, now!
				{ Cue = "/VO/MegaeraField_0330" },
				-- Alecto, now!!
				{ Cue = "/VO/MegaeraField_0331" },
				-- Now, Alecto!
				{ Cue = "/VO/MegaeraField_0332" },
				-- Now, Alecto!!
				{ Cue = "/VO/MegaeraField_0333" },
				-- Alecto, get him!
				{ Cue = "/VO/MegaeraField_0334" },
				-- Alecto, bleed him!
				{ Cue = "/VO/MegaeraField_0335" },
				-- Alecto!
				{ Cue = "/VO/MegaeraField_0336" },
			},
			{
				RandomRemaining = true,
				ObjectType = "Harpy3",
				RequiresSourceAlive = true,
				PreLineWait = 0.15,
				Cooldowns =
				{
					{ Name = "TisiphoneSupportSpeech" },
				},

				-- Murder. Murder!
				{ Cue = "/VO/Tisiphone_0089" },
				-- Murder...!
				{ Cue = "/VO/Tisiphone_0089" },
				-- Mmurdererr...
				{ Cue = "/VO/Tisiphone_0089" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				CooldownTime = 60,
				SuccessiveChanceToPlay = 0.5,

				-- Now!!
				{ Cue = "/VO/Alecto_0174" },
				-- That's it!
				{ Cue = "/VO/Alecto_0166" },
				-- That does it!
				{ Cue = "/VO/Alecto_0168" },
				-- Eat this!
				{ Cue = "/VO/Alecto_0085" },
				-- Here!
				{ Cue = "/VO/Alecto_0086" },
			},
			]]--
		},
	},

	HarpyLightningCone =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			EnragedWeaponSwap = "HarpyLightningConeRage",

			FireTicks = 1,
			AttackSlotsPerTickMin = 6,
			AttackSlotsPerTickMax = 6,
			AttackSlotInterval = 0.05,
			AttackSlots =
			{
				{ UseAngleBetween = true, OffsetDistance = 300, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 800, OffsetAngle = 25, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 800, OffsetAngle = -25, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},
			FireCooldown = 1.2,
			AIAngleTowardsPlayerWhileFiring = false,
			PreAttackDuration = 0.2,
			FireAnimation = "Fury2Lightning",
			PostAttackAnimation = "Fury2LungeReturnToIdle",
			AttackSound = "/SFX/Enemy Sounds/Megaera/EmoteSustainedAttacking",
			PostAttackDuration = 0.6,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				CooldownTime = 60,

				-- Blood and darkness!
				{ Cue = "/VO/MegaeraField_0074" },
				-- You asked for this!
				{ Cue = "/VO/MegaeraField_0075" },
				-- Start running, fool!
				{ Cue = "/VO/MegaeraField_0076" },
				-- I'll kill you where you stand!
				{ Cue = "/VO/MegaeraField_0077" },
				-- Enough!
				{ Cue = "/VO/MegaeraField_0078" },
				-- Run for it, little man!
				{ Cue = "/VO/MegaeraField_0079" },
				-- You can't escape from me.
				{ Cue = "/VO/MegaeraField_0080" },
				-- Have some of this...!
				{ Cue = "/VO/MegaeraField_0081" },
				-- I'll make you pay...!
				{ Cue = "/VO/MegaeraField_0082" },
			},
		},
	},

	HarpyLightningConeRage =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 1,
			AttackSlotsPerTickMin = 6,
			AttackSlotsPerTickMax = 6,
			AttackSlotInterval = 0.05,
			AttackSlots =
			{
				{ UseAngleBetween = true, OffsetDistance = 300, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 800, OffsetAngle = 25, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 800, OffsetAngle = -25, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 1400, OffsetAngle = 30, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 1200, OffsetAngle = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 1400, OffsetAngle = -30, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},
			FireCooldown = 1.2,
			AIAngleTowardsPlayerWhileFiring = false,
			PreAttackDuration = 0.2,
			FireAnimation = "Fury2Lightning",
			PostAttackAnimation = "Fury2LungeReturnToIdle",
			AttackSound = "/SFX/Enemy Sounds/Megaera/EmoteSustainedAttacking",
			PostAttackDuration = 0.6,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				CooldownTime = 60,

				-- Blood and darkness!
				{ Cue = "/VO/MegaeraField_0074" },
				-- You asked for this!
				{ Cue = "/VO/MegaeraField_0075" },
				-- Start running, fool!
				{ Cue = "/VO/MegaeraField_0076" },
				-- I'll kill you where you stand!
				{ Cue = "/VO/MegaeraField_0077" },
				-- Enough!
				{ Cue = "/VO/MegaeraField_0078" },
				-- Run for it, little man!
				{ Cue = "/VO/MegaeraField_0079" },
				-- You can't escape from me.
				{ Cue = "/VO/MegaeraField_0080" },
				-- Have some of this...!
				{ Cue = "/VO/MegaeraField_0081" },
				-- I'll make you pay...!
				{ Cue = "/VO/MegaeraField_0082" },
			},
		},
	},

	HarpyLightningLine =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 1,
			AttackSlotsPerTickMin = 5,
			AttackSlotsPerTickMax = 5,
			AttackSlotInterval = 0.05,
			AttackSlots =
			{
				{ UseAngleBetween = true, OffsetDistance = 300, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 600, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 900, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 1200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 1500, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},
			FireCooldown = 1.2,
			AIAngleTowardsPlayerWhileFiring = false,
			PreAttackDuration = 0.2,
			FireAnimation = "Fury3Lightning",
			PostAttackAnimation = "Fury3LungeReturnToIdle",
			AttackSound = "/SFX/Enemy Sounds/Tisiphone/EmoteSustainedAttacking",
			PostAttackDuration = 0.6,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				CooldownTime = 60,

				-- Murderrr!!
				{ Cue = "/VO/Tisiphone_0039" },
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
				-- Mrr, hrrnnn...
				{ Cue = "/VO/Tisiphone_0045" },
				-- Zagreusssss!
				{ Cue = "/VO/Tisiphone_0136", RequiredTextLines = { "Fury3Encounter10" } },
				-- ZagreUSSSS...!!
				{ Cue = "/VO/Tisiphone_0137", RequiredTextLines = { "Fury3Encounter10" } },
				-- Zag, re, uss...!!
				{ Cue = "/VO/Tisiphone_0138", RequiredTextLines = { "Fury3Encounter10" } },
				-- Zurrrnnngghh!!
				{ Cue = "/VO/Tisiphone_0139", RequiredTextLines = { "Fury3Encounter08" } },
				-- Zrrnnnhhhhhh!
				{ Cue = "/VO/Tisiphone_0140", RequiredTextLines = { "Fury3Encounter08" } },
				-- Zrr, hrrnnn...
				{ Cue = "/VO/Tisiphone_0141", RequiredTextLines = { "Fury3Encounter08" } },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	HarpyLightningCardinal =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 1,
			AttackSlotsPerTickMin = 10,
			AttackSlotsPerTickMax = 10,
			AttackSlotInterval = 0.01,
			AttackSlots =
			{
				{ UseAngleBetween = true, OffsetDistance = 300, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 600, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 900, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetDistance = 1200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				--{ UseAngleBetween = true, OffsetDistance = 1500, OffsetScaleY = 0.48, OffsetFromAttacker = true },

				{ UseAngleBetween = true, OffsetAngle = 90, OffsetDistance = 300, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetAngle = 90, OffsetDistance = 600, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetAngle = 90, OffsetDistance = 900, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				--{ UseAngleBetween = true, OffsetAngle = 90, OffsetDistance = 1200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				--{ UseAngleBetween = true, OffsetAngle = 90, OffsetDistance = 1500, OffsetScaleY = 0.48, OffsetFromAttacker = true },

				--[[{ UseAngleBetween = true, OffsetAngle = 180, OffsetDistance = 300, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetAngle = 180, OffsetDistance = 600, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetAngle = 180, OffsetDistance = 900, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetAngle = 180, OffsetDistance = 1200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetAngle = 180, OffsetDistance = 1500, OffsetScaleY = 0.48, OffsetFromAttacker = true },]]--

				{ UseAngleBetween = true, OffsetAngle = 270, OffsetDistance = 300, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetAngle = 270, OffsetDistance = 600, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ UseAngleBetween = true, OffsetAngle = 270, OffsetDistance = 900, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				--{ UseAngleBetween = true, OffsetAngle = 270, OffsetDistance = 1200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				--{ UseAngleBetween = true, OffsetAngle = 270, OffsetDistance = 1500, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},
			FireCooldown = 1.2,
			AIAngleTowardsPlayerWhileFiring = false,
			PreAttackDuration = 0.2,
			FireAnimation = "Fury3Lightning",
			PostAttackAnimation = "Fury3LungeReturnToIdle",
			AttackSound = "/SFX/Enemy Sounds/Tisiphone/EmoteSustainedAttacking",
			PostAttackDuration = 0.6,


			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				CooldownTime = 60,

				-- MurdereRRRR...!!
				{ Cue = "/VO/Tisiphone_0041" },
				-- Mur, der, rerrr!!
				{ Cue = "/VO/Tisiphone_0042" },
				-- Murrrnnngghh!!
				{ Cue = "/VO/Tisiphone_0043" },
				-- Mrrnnnhhhhhh!
				{ Cue = "/VO/Tisiphone_0044" },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	SummonTisiphoneBombingRun =
	{
		StartingWeapon = false,
		IgnoreOutgoingDamageModifiers = true,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			PreAttackAnimation = "Fury3MultiFuryPreview",
			PreAttackDuration = 1.0,
			FireAnimation = "TisiphoneMultiFurySkyDive",

			SkipMovement = true,
			SkipStopBeforeAttack = true,
			SkipStopBeforePreAttackEnd = true,
			FireTicks = 1,
			AttackSlotsPerTickMin = 21,
			AttackSlotsPerTickMax = 21,
			AttackSlotInterval = 0.015,
			UseRandomAngle = true,
			AttackSlots =
			{
				{ AnchorAngleOffset = -550, OffsetDistance = -900, OffsetScaleY = 0.48 },
				{ AnchorAngleOffset = -550, OffsetDistance = -600, OffsetScaleY = 0.48 },
				{ AnchorAngleOffset = -550, OffsetDistance = -300, OffsetScaleY = 0.48 },
				{ AnchorAngleOffset = -550, OffsetDistance = 0, OffsetScaleY = 0.48 },
				{ AnchorAngleOffset = -550, OffsetDistance = 300, OffsetScaleY = 0.48 },
				{ AnchorAngleOffset = -550, OffsetDistance = 600, OffsetScaleY = 0.48 },
				{ AnchorAngleOffset = -550, OffsetDistance = 900, OffsetScaleY = 0.48, PauseDuration = 0.3 },

				{ OffsetDistance = 900, OffsetScaleY = 0.48 },
				{ OffsetDistance = 600, OffsetScaleY = 0.48 },
				{ OffsetDistance = 300, OffsetScaleY = 0.48 },
				{ OffsetDistance = 0, OffsetScaleY = 0.48 },
				{ OffsetDistance = -300, OffsetScaleY = 0.48 },
				{ OffsetDistance = -600, OffsetScaleY = 0.48 },
				{ OffsetDistance = -900, OffsetScaleY = 0.48, PauseDuration = 0.3 },

				{ AnchorAngleOffset = 550, OffsetDistance = -900, OffsetScaleY = 0.48 },
				{ AnchorAngleOffset = 550, OffsetDistance = -600, OffsetScaleY = 0.48 },
				{ AnchorAngleOffset = 550, OffsetDistance = -300, OffsetScaleY = 0.48 },
				{ AnchorAngleOffset = 550, OffsetDistance = 0, OffsetScaleY = 0.48 },
				{ AnchorAngleOffset = 550, OffsetDistance = 300, OffsetScaleY = 0.48 },
				{ AnchorAngleOffset = 550, OffsetDistance = 600, OffsetScaleY = 0.48 },
				{ AnchorAngleOffset = 550, OffsetDistance = 900, OffsetScaleY = 0.48 },

				--[[

				{ UseAngleBetween = true, OffsetDistance = 300, OffsetScaleY = 0.48 },
				{ UseAngleBetween = true, OffsetDistance = 600, OffsetScaleY = 0.48 },
				{ UseAngleBetween = true, OffsetDistance = 900, OffsetScaleY = 0.48 },

				{ UseAngleBetween = true, OffsetAngle = 90, OffsetDistance = 300, OffsetScaleY = 0.48 },
				{ UseAngleBetween = true, OffsetAngle = 90, OffsetDistance = 600, OffsetScaleY = 0.48 },
				{ UseAngleBetween = true, OffsetAngle = 90, OffsetDistance = 900, OffsetScaleY = 0.48 },

				{ UseAngleBetween = true, OffsetAngle = 180, OffsetDistance = 300, OffsetScaleY = 0.48 },
				{ UseAngleBetween = true, OffsetAngle = 180, OffsetDistance = 600, OffsetScaleY = 0.48 },
				{ UseAngleBetween = true, OffsetAngle = 180, OffsetDistance = 900, OffsetScaleY = 0.48 },

				{ UseAngleBetween = true, OffsetAngle = 270, OffsetDistance = 300, OffsetScaleY = 0.48 },
				{ UseAngleBetween = true, OffsetAngle = 270, OffsetDistance = 600, OffsetScaleY = 0.48 },
				{ UseAngleBetween = true, OffsetAngle = 270, OffsetDistance = 900, OffsetScaleY = 0.48 },
				]]
			},
			FireInterval = 3.0,

			--[[
			PreAttackVoiceLines =
			{
				{
					RandomRemaining = true,
					ObjectType = "Harpy",
					RequiresSourceAlive = true,
					PreLineWait = 0.15,
					Cooldowns =
					{
						{ Name = "MegaeraSupportSpeech" },
					},

					-- Tisiphone!
					-- { Cue = "/VO/MegaeraField_0341" },
					-- Tisiphone...!
					{ Cue = "/VO/MegaeraField_0342" },
					-- Here, Tis!
					{ Cue = "/VO/MegaeraField_0343" },
					-- Here, Tis...!
					-- { Cue = "/VO/MegaeraField_0344" },
					-- Tis, now!
					{ Cue = "/VO/MegaeraField_0345" },
					-- Tisiphone, now!!
					{ Cue = "/VO/MegaeraField_0346" },
					-- Now, Tis!
					{ Cue = "/VO/MegaeraField_0347" },
					-- Now, Tis!!
					{ Cue = "/VO/MegaeraField_0348" },
					-- Tisiphone, kill him!
					-- { Cue = "/VO/MegaeraField_0349" },
					-- Tisiphone, kill!
					{ Cue = "/VO/MegaeraField_0350" },
				},
				{
					RandomRemaining = true,
					ObjectType = "Harpy2",
					RequiresSourceAlive = true,
					PreLineWait = 0.15,
					Cooldowns =
					{
						{ Name = "AlectoSupportSpeech" },
					},

					-- Tisiphone!
					{ Cue = "/VO/Alecto_0273" },
					-- Tisiphone...!
					{ Cue = "/VO/Alecto_0274" },
					-- Here, Tis!
					{ Cue = "/VO/Alecto_0275" },
					-- Here, Tis...!
					{ Cue = "/VO/Alecto_0276" },
					-- Tis, now!
					{ Cue = "/VO/Alecto_0277" },
					-- Tisiphone, now!!
					{ Cue = "/VO/Alecto_0278" },
					-- Now, Tis!
					{ Cue = "/VO/Alecto_0279" },
					-- Now, Tis!!
					{ Cue = "/VO/Alecto_0280" },
					-- Tisiphone, kill him!
					{ Cue = "/VO/Alecto_0281" },
					-- Tisiphone, kill!
					{ Cue = "/VO/Alecto_0282" },
				},
			},
			]]--
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	SummonTisiphoneFog =
	{
		StartingWeapon = false,
		IgnoreOutgoingDamageModifiers = true,
		IgnoreOnHitEffects = true,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			PreAttackAnimation = "Fury3MultiFuryPreview",
			PreAttackDuration = 1.0,
			FireAnimation = "TisiphoneMultiFurySkyDive",

			SkipMovement = true,
			SkipStopBeforeAttack = true,
			SkipStopBeforePreAttackEnd = true,
			FireTicks = 1,
			AttackSlotsPerTickMin = 21,
			AttackSlotsPerTickMax = 21,
			AttackSlotInterval = 0.04,
			UseRandomAngle = true,
			AttackSlots =
			{
				-- outer circle 2
				{ Angle = 337.5, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 315, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 292.5, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 270, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 247.5, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 225, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 202.5, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 180, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 157.5, OffsetDistance = 1800, OffsetScaleY = 0.55 },
				{ Angle = 135, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 112.5, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 90, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 67.5, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 45, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 22.5, OffsetDistance = 1350, OffsetScaleY = 0.55 },
				{ Angle = 0, OffsetDistance = 1350, OffsetScaleY = 0.55 },

				-- outer circle
				{ Angle = 337.5, OffsetDistance = 900, OffsetScaleY = 0.55 },
				{ Angle = 292.5, OffsetDistance = 900, OffsetScaleY = 0.55 },
				{ Angle = 247.5, OffsetDistance = 900, OffsetScaleY = 0.55 },
				{ Angle = 202.5, OffsetDistance = 900, OffsetScaleY = 0.55 },
				{ Angle = 157.5, OffsetDistance = 900, OffsetScaleY = 0.55 },
				{ Angle = 112.5, OffsetDistance = 900, OffsetScaleY = 0.55 },
				{ Angle = 67.5, OffsetDistance = 900, OffsetScaleY = 0.55 },
				{ Angle = 22.5, OffsetDistance = 900, OffsetScaleY = 0.55 },

				{ Angle = 270, OffsetDistance = 450, OffsetScaleY = 0.55 },
				{ Angle = 180, OffsetDistance = 450, OffsetScaleY = 0.55 },
				{ Angle = 90, OffsetDistance = 450, OffsetScaleY = 0.55 },
				{ Angle = 0, OffsetDistance = 450, OffsetScaleY = 0.55 },
			},
			FireInterval = 3.0,

			--[[
			PreAttackVoiceLines =
			{
				{
					RandomRemaining = true,
					ObjectType = "Harpy",
					RequiresSourceAlive = true,
					PreLineWait = 0.15,
					Cooldowns =
					{
						{ Name = "MegaeraSupportSpeech" },
					},

					-- Tisiphone!
					-- { Cue = "/VO/MegaeraField_0341" },
					-- Tisiphone...!
					{ Cue = "/VO/MegaeraField_0342" },
					-- Here, Tis!
					-- { Cue = "/VO/MegaeraField_0343" },
					-- Here, Tis...!
					-- { Cue = "/VO/MegaeraField_0344" },
					-- Tis, now!
					{ Cue = "/VO/MegaeraField_0345" },
					-- Tisiphone, now!!
					{ Cue = "/VO/MegaeraField_0346" },
					-- Now, Tis!
					{ Cue = "/VO/MegaeraField_0347" },
					-- Now, Tis!!
					{ Cue = "/VO/MegaeraField_0348" },
					-- Tisiphone, kill him!
					-- { Cue = "/VO/MegaeraField_0349" },
					-- Tisiphone, kill!
					-- { Cue = "/VO/MegaeraField_0350" },
				},
				{
					RandomRemaining = true,
					ObjectType = "Harpy2",
					RequiresSourceAlive = true,
					PreLineWait = 0.15,
					Cooldowns =
					{
						{ Name = "AlectoSupportSpeech" },
					},

					-- Tisiphone!
					{ Cue = "/VO/Alecto_0273" },
					-- Tisiphone...!
					{ Cue = "/VO/Alecto_0274" },
					-- Here, Tis!
					{ Cue = "/VO/Alecto_0275" },
					-- Here, Tis...!
					{ Cue = "/VO/Alecto_0276" },
					-- Tis, now!
					{ Cue = "/VO/Alecto_0277" },
					-- Tisiphone, now!!
					{ Cue = "/VO/Alecto_0278" },
					-- Now, Tis!
					{ Cue = "/VO/Alecto_0279" },
					-- Now, Tis!!
					{ Cue = "/VO/Alecto_0280" },
					-- Tisiphone, kill him!
					-- { Cue = "/VO/Alecto_0281" },
					-- Tisiphone, kill!
					-- { Cue = "/VO/Alecto_0282" },
				},
			},
			]]--

		},

		Sounds =
		{
			ChargeSounds =
			{
				{ Name = "/SFX/GasBomb" },
			},
			FireSounds =
			{
				--
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	HarpySpawns =
	{
		StartingWeapon = false,

		AIData =
		{
			FireFunctionName = "HandleBossSpawns",
			FireAnimation = "FuryLightning",
			PostAttackAnimation = "FuryLungeReturnToIdle",
			PreAttackDuration = 0.0,
			FireDuration = 0.5,
			PostAttackDuration = 1.0,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			FireCooldown = 0,

			MaxActiveSpawns = 5,
			MinAttacksBetweenUse = 10,
			ForceUseIfReady = true,
			SpawnAggroed = true,

			SpawnRadius = 950,
			SpawnInterval = 0.1,
			SpawnCount = 6,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},

		Upgrades = { },
	},

	HarpyBuildRage =
	{
		StartingWeapon = false,

		AIData =
		{
			FireFunctionName = "HarpyBuildRage",
			SkipFireWeapon = true,
			PreAttackAnimation = "AlectoRageBuild_Start",
			BuildRageEndAnimation = "AlectoRageBuild_End",
			EarlyBreakAnimation = "AlectoRageBuild_End",
			EarlyBreakStunDuration = 1.0,
			BuildRageEndDuration = 0.5,
			PreAttackDuration = 0.0,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			FireCooldown = 0,

			MaxActiveSpawns = 5,
			MinAttacksBetweenUse = 5,
			RequiresNotEnraged = true,
			ForceUseIfReady = true,

			BuildRageTicks = 100,
			BuildRageTicksInterval = 0.055,

			DumbFireWeapons = { "HarpyBuildRageBlast" },

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.45,
				CooldownTime = 15,
				UsePlayerSource = true,
				SuccessiveChanceToPlay = 0.25,

				-- She's powering up.
				{ Cue = "/VO/ZagreusField_1509" },
				-- She's getting angry.
				{ Cue = "/VO/ZagreusField_1510" },
				-- I'd better stop her.
				{ Cue = "/VO/ZagreusField_1511" },
				-- She's getting mad.
				{ Cue = "/VO/ZagreusField_1512" },
				-- She's psyching up.
				{ Cue = "/VO/ZagreusField_1513" },
				-- She's charging up.
				{ Cue = "/VO/ZagreusField_1514" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	HarpyBuildRageBlast =
	{
		ImpactReactionHitsOverride = 1,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 5,
			FireCooldown = 0.75,
		},
	},

	-- Hydra
	HydraBite =
	{

		-- this is the weapon that causes them to 'pull back'
		AIData =
		{
			--PreAttackAnimation = "EnemyHydraBite_Charge",
			--FireAnimation = "EnemyHydraBite_Attack",
			--PostAttackAnimation = "EnemyHydraIdle",
			PreAttackDuration = 0,
			--PreAttackEndDuration = 0.5,
			--PreAttackEndShake = true,
			--PreAttackVelocityWeapon = "HydraBiteSelfVelocity",
			FireAnimation = "EnemyHydraBite_Charge",
			FireDuration = 0.8,
			PostAttackDuration = 0,
			AIAttackDistance = 175,
			AIBufferDistance = 175,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			AIMoveWithinRangeTimeout = 1.0,

			ChainedWeapon = "HydraSnap",
		},
	},

	HydraSnap =
	{

		AIData =
		{
			--PreAttackAnimation = "EnemyHydraBite_Charge2",
			FireAnimation = "EnemyHydraBite_Attack",
			PostAttackAnimation = "EnemyHydraIdle",
			PreAttackDuration = 0,
			--PreAttackEndDuration = 0.5,
			--PreAttackEndShake = true,
			--PreAttackVelocityWeapon = "HydraBiteSelfVelocity",
			SkipMovement = true,
			--SkipAngleTowardTarget = true,
			FireDuration = 0.5,
			PostAttackDuration = 1.6,
			AIAttackDistance = 375,
			AIBufferDistance = 375,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = false,
			SkipAngleTowardTarget = true,
			AIMoveWithinRangeTimeout = 1.0,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0 },
		},
	},

	HydraLunge =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},

		CauseImpactReaction = true,

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "EnemyHydraLungePreAttack",
			FireAnimation = "EnemyHydraLungeFire",
			PostAttackAnimation = "EnemyHydraLungeReturnToIdle",
			PreAttackDuration = 1.5,
			PreAttackEndDuration = 0.6,
			PreAttackEndShake = true,
			FireDuration = 0.2,
			PostAttackDuration = 0.25,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,
			AIMoveWithinRangeTimeout = 2.5,

			MinAttacksBetweenUse = 2,
			MinPlayerDistance = 350,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HydraHead/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0 },
		},
	},

	HydraLungeUntethered =
	{
		InheritFrom = { "HydraLunge" },

		ImpactReactionHitsOverride = 5,

		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 1.0,
			AIAttackDistance = 950,
			AIBufferDistance = 925,
			MinAttacksBetweenUse = 0,
		},
	},

	HydraSlam =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},

		CauseImpactReaction = true,

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "EnemyHydraIdle",
			FireAnimation = "EnemyHydraSlamCharge",
			PreAttackDuration = 0.0,
			FireDuration = 0.5,
			PostAttackDuration = 3.0,
			AIAttackDistance = 400,
			AIMoveWithinRangeTimeout = 1.0,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = false,
			PreAttackEndShake = false,

			MaxPlayerDistance = 600,
			MinAttacksBetweenUse = 2,
			ForceUseIfReady = true,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HydraHead/EmoteAttackingWithBones" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},
	},


	HydraSlamFrenzy =
	{
		InheritFrom = { "HydraSlam" },

		AIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 3.0,

			AIFireTicksMin = 3,
			AIFireTicksMax = 3,
			AIFireTicksCooldown = 0.65,
		},
	},

	HydraSlamUntethered =
	{
		InheritFrom = { "HydraSlamFrenzy" },

		ImpactReactionHitsOverride = 5,

		AIData =
		{
			DeepInheritance = true,
			AIAttackDistance = 400,
			AIBufferDistance = 375,
			PostAttackDuration = 3.0,
			MinAttacksBetweenUse = 1,
			ForceUseIfReady = false,
			MaxPlayerDistance = 800,
		},
	},


	HydraSlamScattered =
	{
		InheritFrom = { "HydraSlam" },

		AIData =
		{
			DeepInheritance = true,
			AIAttackDistance = 600,

			DumbFireWeapons = { "HydraSlamRockFallScattered" },
			MaxPlayerDistance = 9999,
		},
	},

	HydraSlamScattered2 =
	{
		InheritFrom = { "HydraSlamScattered" },

		AIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 3.0,

			AIFireTicksMin = 1,
			AIFireTicksMax = 3,
			AIFireTicksCooldown = 0.65,

			DumbFireWeapons = { "HydraSlamRockFallScattered2" },
		},
	},

	HydraSlamScatteredFrenzy =
	{
		InheritFrom = { "HydraSlamScattered" },

		AIData =
		{
			DeepInheritance = true,
			AIAttackDistance = 600,

			AIFireTicksMin = 3,
			AIFireTicksMax = 6,
			AIFireTicksCooldown = 0.65,

			DumbFireWeapons = { "HydraSlamRockFallScatteredFrenzy" },
			MaxPlayerDistance = 9999,
		},
	},

	HydraSlamRockFallScattered =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},

		CauseImpactReaction = true,

		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.5,
			FireDuration = 0.5,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,


			AIFireTicksMin = 10,
			AIFireTicksMax = 15,
			FireCooldown = 0.075,
			CreateOwnTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 300,
			TargetOffsetDistanceMax = 1400,
			OffsetDistanceScaleY = 0.5,
			ResetTargetPerTick = true,

			SkipMovement = true,

			PreAttackVoiceLines =
			{
				PlayOnce = true,
				PlayOnceContext = "HydraSlamRockFallReaction",
				PlayOnceFromTableThisRun = true,
				BreakIfPlayed = true,
				PreLineWait = 2.0,
				UsePlayerSource = true,

				-- New tricks, there, Bone Hydra?
				{ Cue = "/VO/ZagreusField_3933", RequiredFalsePlayed = { "/VO/ZagreusField_3147" }, },
				-- Now that's not nice at all.
				{ Cue = "/VO/ZagreusField_3935", ChanceToPlay = 0.5 },
			},
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HydraHead/EmoteAttackingWithBones" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},
	},

	HydraSlamRockFallScattered2 =
	{
		InheritFrom = { "HydraSlamRockFallScattered" },

		AIData =
		{
			DeepInheritance = true,

			AIFireTicksMin = 20,
			AIFireTicksMax = 25,
			FireCooldown = 0.05,
		},
	},

	HydraSlamRockFallScatteredFrenzy =
	{
		InheritFrom = { "HydraSlamRockFallScattered" },

		AIData =
		{
			DeepInheritance = true,

			AIFireTicksMin = 40,
			AIFireTicksMax = 50,
			FireCooldown = 0.033,
		},
	},

	HydraPull =
	{
		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "EnemyHydraRoarPreAttack",
			FireAnimation = "EnemyHydraRoarFire",
			PostAttackAnimation = "EnemyHydraRoarReturnToIdle",
			PreAttackDuration = 1.1,
			FireDuration = 0.5,
			PostAttackDuration = 0.2,
			AIAttackDistance = 1500,
			AIBufferDistance = 1500,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			AIMoveWithinRangeTimeout = 1.0,

			MinAttacksBetweenUse = 3,
			ForceUseIfReady = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted" },
			},
		},
	},

	HydraLavaSpit =
	{
		IgnoreOnHitEffects = true,
		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "EnemyHydraRangedPreAttack",
			FireAnimation = "EnemyHydraMouthOpening_Loop",
			PostAttackAnimation = "EnemyHydraMouthOpening_End",
			PreAttackEndShake = true,
			PreAttackDuration = 1.0,
			FireDuration = 0.5,
			PostAttackDuration = 2.5,
			AIAttackDistance = 1050,
			AIMoveWithinRangeTimeout = 1.0,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			AIFireTicksMin = 3,
			AIFireTicksMax = 4,
			AIFireTicksCooldown = 0.1,

			MinAttacksBetweenUse = 1,
			ForceUseIfReady = true,
		},

		RapidDamageType = true,
		IgnoreInvulnerabilityFrameTrigger = true,
		PresentationOnlyOnPlayerHit = true,
		OnHitFunctionNames = { "CheckLavaSplashPresentation", }
	},

	HydraLavaSpit2 =
	{
		InheritFrom = { "HydraLavaSpit" },
		AIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 1.0,
			FireDuration = 1.5,
			PostAttackDuration = 2.5,

			AIFireTicksMin = 5,
			AIFireTicksMax = 7,
			AIFireTicksCooldown = 0.1,

			MinAttacksBetweenUse = 1,
			MinPlayerDistance = 450,

			PreAttackVoiceLines =
			{
				PlayOnce = true,
				PlayOnceContext = "HydraLavaSpitReaction",
				PreLineWait = 2.0,
				UsePlayerSource = true,
				RequiredKillEnemiesFound = true,

				-- Whoa that's not good...
				{ Cue = "/VO/ZagreusField_3932" },
			},
		},
	},

	HydraLavaSpit3 =
	{
		InheritFrom = { "HydraLavaSpit2" },
		AIData =
		{
			DeepInheritance = true,

			FireDuration = 0.75,
			PostAttackDuration = 0.0,
		},
	},

	HydraLavaSpitFrenzy =
	{
		InheritFrom = { "HydraLavaSpit2" },
		WeaponComboOnly = true,
		WeaponCombo =
		{
			[1] = "HydraLavaSpit3",
			[2] = "HydraLavaSpit3",
			[2] = "HydraLavaSpit3",
		},
		AIData =
		{
			MaxConsecutiveUses = 1,
		}
	},

	HydraLavaSpitExterior =
	{
		AIData =
		{
			PreAttackAnimation = "EnemyHydraRangedPreAttack",
			FireAnimation = "EnemyHydraMouthOpening_Loop",
			PostAttackAnimation = "EnemyHydraMouthOpening_End",
			PreAttackEndShake = true,

			PreAttackDuration = 1.0,
			FireDuration = 1.5,
			PostAttackDuration = 2.5,

			MoveToId = 506393,
			AIAttackDistance = 50,
			AIMoveWithinRangeTimeout = 1.0,

			FireTicks = 1,
			FireCooldown = 0.1,
			AttackSlotsPerTick = 11,
			AttackSlotInterval = 0.05,
			AttackSlotPreFireWait = 0.1,
			AttackSlots =
			{
				{ UseMapObjectId = { B_Boss01 = 554426, B_Boss02 = 554449 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554427, B_Boss02 = 554450 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554428, B_Boss02 = 554451 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554429, B_Boss02 = 554452 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554430, B_Boss02 = 554459 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554431, B_Boss02 = 554454 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554432, B_Boss02 = 554456 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554436, B_Boss02 = 554455 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554435, B_Boss02 = 554457 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554434, B_Boss02 = 554453 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554433, B_Boss02 = 554458 }, InstantAngleTowardsTarget = true },
			},

			MinAttacksBetweenUse = 1,
			ForceUseIfReady = true,
			MinPlayerDistance = 450,
		},

		IgnoreOnHitEffects = true,
		RapidDamageType = true,
		IgnoreInvulnerabilityFrameTrigger = true,
		PresentationOnlyOnPlayerHit = true,
		OnHitFunctionNames = { "CheckLavaSplashPresentation", }
	},

	HydraLavaSpitInterior =
	{
		AIData =
		{
			PreAttackAnimation = "EnemyHydraRangedPreAttack",
			FireAnimation = "EnemyHydraMouthOpening_Loop",
			PostAttackAnimation = "EnemyHydraMouthOpening_End",
			PreAttackEndShake = true,

			PreAttackDuration = 1.0,
			FireDuration = 1.0,
			PostAttackDuration = 2.5,

			MoveToId = 506393,
			AIAttackDistance = 50,
			AIMoveWithinRangeTimeout = 1.0,

			FireTicks = 1,
			FireCooldown = 0.1,
			AttackSlotsPerTick = 9,
			AttackSlotInterval = 0.15,
			AttackSlotPreFireWait = 0.15,
			AttackSlots =
			{
				{ UseMapObjectId = { B_Boss01 = 554437, B_Boss02 = 554460 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554438, B_Boss02 = 554461 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554440, B_Boss02 = 554463 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554441, B_Boss02 = 554462 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554443, B_Boss02 = 554464 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554444, B_Boss02 = 554465 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554448, B_Boss02 = 554468 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554446, B_Boss02 = 554468 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554447, B_Boss02 = 554467 }, InstantAngleTowardsTarget = true },
			},

			MinAttacksBetweenUse = 1,
			--ForceUseIfReady = true,
			MaxPlayerDistance = 700,
		},

		IgnoreOnHitEffects = true,
		RapidDamageType = true,
		IgnoreInvulnerabilityFrameTrigger = true,
		PresentationOnlyOnPlayerHit = true,
		OnHitFunctionNames = { "CheckLavaSplashPresentation", }
	},

	HydraDart =
	{
		CauseImpactReaction = true,

		AIData =
		{
			PreAttackAnimation = "EnemyHydraRangedPreAttack",
			FireAnimation = "EnemyHydraRangedFire",
			PostAttackAnimation = "EnemyHydraRangedPostAttack",
			PreAttackWaitForAnimation = true,
			FireDuration = 0.6,
			PostAttackDuration = 2.0,
			AIAttackDistance = 50,
			AIBufferDistance = 50,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			MoveToId = 480903,
			AIMoveWithinRangeTimeout = 2.5,

			AIFireTicksMin = 5,
			AIFireTicksMax = 5,
			AIFireTicksCooldown = 0.6,

			MinAttacksBetweenUse = 2,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HydraHead/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/HydraHead/HydraSlowShoot" },
			},
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HydraDartVolley =
	{
		CauseImpactReaction = true,

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "EnemyHydraRangedPreAttack",
			FireAnimation = "EnemyHydraRangedFireLoop",
			PostAttackAnimation = "EnemyHydraRangedPostAttack",
			AttackSound = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted",
			PreAttackDuration = 1.3,
			FireDuration = 0.5,
			PostAttackDuration = 1.0,
			AIAttackDistance = 50,
			AIBufferDistance = 50,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			MoveToId = 480903,
			AIMoveWithinRangeTimeout = 2.0,

			MinAttacksBetweenUse = 1,

			FireTicks = 1,

			AttackSlotsPerTick = 13,
			AttackSlotInterval = 0.1,
			AttackSlots =
			{
				{ UseAngleBetween = true, OffsetAngle = 0, OffsetDistance = 1500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseTargetPosition = true, },
				{ UseAngleBetween = true, OffsetAngle = 15, OffsetDistance = 1500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseTargetPosition = true, },
				{ UseAngleBetween = true, OffsetAngle = -15, OffsetDistance = 1500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseTargetPosition = true, },
				{ UseAngleBetween = true, OffsetAngle = 30, OffsetDistance = 1500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseTargetPosition = true, },
				{ UseAngleBetween = true, OffsetAngle = -30, OffsetDistance = 1500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseTargetPosition = true, },
				{ UseAngleBetween = true, OffsetAngle = 45, OffsetDistance = 1500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseTargetPosition = true, },
				{ UseAngleBetween = true, OffsetAngle = -45, OffsetDistance = 1500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseTargetPosition = true, },
				{ UseAngleBetween = true, OffsetAngle = 60, OffsetDistance = 1500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseTargetPosition = true, },
				{ UseAngleBetween = true, OffsetAngle = -60, OffsetDistance = 1500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseTargetPosition = true, },
				{ UseAngleBetween = true, OffsetAngle = 75, OffsetDistance = 1500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseTargetPosition = true, },
				{ UseAngleBetween = true, OffsetAngle = -75, OffsetDistance = 1500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseTargetPosition = true, },
				{ UseAngleBetween = true, OffsetAngle = 90, OffsetDistance = 1500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseTargetPosition = true, },
				{ UseAngleBetween = true, OffsetAngle = -90, OffsetDistance = 1500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseTargetPosition = true, },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/HellFireShoot" },
			},
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HydraDartVolleyLeft =
	{
		InheritFrom = { "HydraDartVolley" },

		AIData =
		{
			DeepInheritance = true,

			TargetId = 506390,

			AttackSlotsPerTick = 7,
			AttackSlotInterval = 0.1,
			AttackSlots =
			{
				{ OffsetAngle = 120, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506390, },
				{ OffsetAngle = 100, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506390, },
				{ OffsetAngle = 80, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506390, },
				{ OffsetAngle = 60, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506390, },
				{ OffsetAngle = 40, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506390, },
				{ OffsetAngle = 20, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506390, },
				{ OffsetAngle = 0, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506390, },
			},
		},
	},

	HydraDartVolleyRight =
	{
		InheritFrom = { "HydraDartVolley" },

		AIData =
		{
			DeepInheritance = true,

			TargetId = 506388,

			AttackSlotsPerTick = 7,
			AttackSlotInterval = 0.1,
			AttackSlots =
			{
				{ OffsetAngle = -120, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506388, },
				{ OffsetAngle = -100, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506388, },
				{ OffsetAngle = -80, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506388, },
				{ OffsetAngle = -60, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506388, },
				{ OffsetAngle = -40, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506388, },
				{ OffsetAngle = -20, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506388, },
				{ OffsetAngle = 0, OffsetDistance = 500, OffsetScaleY = 0.55, InstantAngleTowardsTarget = true, UseMapObjectId = 506388, },
			},
		},
	},

	HydraDartUntethered =
	{
		InheritFrom = { "HydraDartVolley" },

		AIData =
		{
			DeepInheritance = true,

			MoveToId = nil,
		},
	},

	HydraRoar =
	{
		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "EnemyHydraRoarPreAttack",
			FireAnimation = "EnemyHydraRoarFire",
			PostAttackAnimation = "EnemyHydraRoarReturnToIdle",
			PreAttackDuration = 1.1,
			FireDuration = 1.0,
			PostAttackDuration = 4.2,
			AIAttackDistance = 5000,
			AIBufferDistance = 5000,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			AIMoveWithinRangeTimeout = 1.0,

			MaxConsecutiveUses = 1,
			ForceUseIfReady = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted" },
			},
		},
	},

	HydraRoar2 =
	{
		InheritFrom = { "HydraRoar" },
	},

	HydraRoar3 =
	{
		InheritFrom = { "HydraRoar" },
	},

	HydraRoar2Frenzy =
	{
		InheritFrom = { "HydraRoar" },

		AIData =
		{
			DeepInheritance = true,

			AIFireTicksMin = 3,
			AIFireTicksMax = 5,
			AIFireTicksCooldown = 0.65,
			AIAngleTowardsPlayerWhileFiring = true,

			ResetTargetPerTick = true,

			PreAttackVoiceLines =
			{
				PlayOnce = true,
				PlayOnceContext = "HydraRoarVolleyReaction",
				PreLineWait = 2.5,
				UsePlayerSource = true,
				RequiredKillEnemiesFound = true,

				-- Oh gods, now this?
				{ Cue = "/VO/ZagreusField_3937" },
			},
		},
	},

	HydraRoarVolleyLeft =
	{
		InheritFrom = { "HydraRoar" },
		GenusName = "HydraRoarVolley",
		AIData =
		{
			PreAttackAnimation = "EnemyHydraRoarPreAttack",
			FireAnimation = "EnemyHydraRoarFire",
			PostAttackAnimation = "EnemyHydraRoarReturnToIdle",
			PreAttackDuration = 1.1,
			FireDuration = 1.0,
			PostAttackDuration = 4.2,
			AIAttackDistance = 50,
			AIBufferDistance = 0,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			AIMoveWithinRangeTimeout = 1.0,
			MoveToId = 480903,

			FireTicks = 1,
			FireCooldown = 0.1,
			AttackSlotsPerTick = 11,
			AttackSlotInterval = 0.05,
			AttackSlotPreFireWait = 0.1,
			AttackSlots =
			{
				{ UseMapObjectId = { B_Boss01 = 554426, B_Boss02 = 554449 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554427, B_Boss02 = 554450 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554428, B_Boss02 = 554451 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554429, B_Boss02 = 554452 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554430, B_Boss02 = 554459 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554431, B_Boss02 = 554454 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554432, B_Boss02 = 554456 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554436, B_Boss02 = 554455 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554435, B_Boss02 = 554457 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554434, B_Boss02 = 554453 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554433, B_Boss02 = 554458 }, InstantAngleTowardsTarget = true },
			},

			MaxConsecutiveUses = 1,
			ForceUseIfReady = true,
		},
	},

	HydraRoarVolleyRight =
	{
		InheritFrom = { "HydraRoar" },
		GenusName = "HydraRoarVolley",
		AIData =
		{
			PreAttackAnimation = "EnemyHydraRoarPreAttack",
			FireAnimation = "EnemyHydraRoarFire",
			PostAttackAnimation = "EnemyHydraRoarReturnToIdle",
			PreAttackDuration = 1.1,
			FireDuration = 1.0,
			PostAttackDuration = 4.2,
			AIAttackDistance = 50,
			AIBufferDistance = 0,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			AIMoveWithinRangeTimeout = 1.0,
			MoveToId = 480903,

			FireTicks = 1,
			FireCooldown = 0.1,
			AttackSlotsPerTick = 11,
			AttackSlotInterval = 0.05,
			AttackSlotPreFireWait = 0.1,
			AttackSlots =
			{
				{ UseMapObjectId = { B_Boss01 = 554433, B_Boss02 = 554458 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554434, B_Boss02 = 554453 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554435, B_Boss02 = 554457 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554436, B_Boss02 = 554455 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554432, B_Boss02 = 554456 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554431, B_Boss02 = 554454 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554430, B_Boss02 = 554459 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554429, B_Boss02 = 554452 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554428, B_Boss02 = 554451 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554427, B_Boss02 = 554450 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554426, B_Boss02 = 554449 }, InstantAngleTowardsTarget = true },

			},

			PreAttackVoiceLines =
			{
				PlayOnce = true,
				PlayOnceContext = "HydraRoarVolleyReaction",
				PreLineWait = 2.0,
				UsePlayerSource = true,
				RequiredKillEnemiesFound = true,

				-- I do not appreciate that!
				{ Cue = "/VO/ZagreusField_3936" },
			},

			MaxConsecutiveUses = 1,
			ForceUseIfReady = true,
		},
	},

	HydraRoarVolleyInsideOut =
	{
		InheritFrom = { "HydraRoar" },
		GenusName = "HydraRoarVolley",
		AIData =
		{
			PreAttackAnimation = "EnemyHydraRoarPreAttack",
			FireAnimation = "EnemyHydraRoarFire",
			PostAttackAnimation = "EnemyHydraRoarReturnToIdle",
			PreAttackDuration = 1.1,
			FireDuration = 1.0,
			PostAttackDuration = 4.2,
			AIAttackDistance = 50,
			AIBufferDistance = 0,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			AIMoveWithinRangeTimeout = 1.0,
			MoveToId = 480903,

			FireTicks = 1,
			FireCooldown = 0.1,
			AttackSlotsPerTick = 11,
			AttackSlotInterval = 0.05,
			AttackSlotPreFireWait = 0.1,
			AttackSlots =
			{
				{ UseMapObjectId = { B_Boss01 = 554431, B_Boss02 = 554454 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554432, B_Boss02 = 554456 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554430, B_Boss02 = 554459 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554436, B_Boss02 = 554455 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554429, B_Boss02 = 554452 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554435, B_Boss02 = 554457 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554428, B_Boss02 = 554451 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554434, B_Boss02 = 554453 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554427, B_Boss02 = 554450 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554433, B_Boss02 = 554458 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554426, B_Boss02 = 554449 }, InstantAngleTowardsTarget = true },
			},

			MaxConsecutiveUses = 1,
			ForceUseIfReady = true,
		},
	},

	HydraSummon =
	{
		AIData =
		{
			PreAttackAnimation = "EnemyHydraMouthOpening_Start",
			FireAnimation = "EnemyHydraMouthOpening_Loop",
			PostAttackAnimation = "EnemyHydraMouthOpening_End",
			PreAttackDuration = 1.0,
			FireDuration = 0.2,
			PostAttackDuration = 5.0,
			AIAttackDistance = 950,
			AIBufferDistance = 600,
			AIMoveWithinRangeTimeout = 1.0,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,

			MaxActiveSpawns = 10,
			SpawnGroupName = "SpawnerHydra",

			MinAttacksBetweenUse = 3,
			ForceUseIfReady = true,

			AIFireTicksMin = 1,
			AIFireTicksMax = 2,
			AIFireTicksCooldown = 0.4,
		}
	},

	HydraSummon2 =
	{
		InheritFrom = { "HydraSummon" },

		AIData =
		{
			PreAttackAnimation = "EnemyHydraMouthOpening_Start",
			FireAnimation = "EnemyHydraMouthOpening_Loop",
			PostAttackAnimation = "EnemyHydraMouthOpening_End",
			PreAttackDuration = 1.0,
			FireDuration = 0.2,
			PostAttackDuration = 5.0,
			AIAttackDistance = 950,
			AIBufferDistance = 600,
			AIMoveWithinRangeTimeout = 1.0,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,

			MaxActiveSpawns = 5,
			SpawnGroupName = "SpawnerHydra",

			MinAttacksBetweenUse = 3,
			ForceUseIfReady = true,

			AIFireTicksMin = 1,
			AIFireTicksMax = 1,
			AIFireTicksCooldown = 0.4,
		}
	},

	HydraSummonSpread =
	{
		InheritFrom = { "HydraSummon" },

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "EnemyHydraMouthOpening_Start",
			FireAnimation = "EnemyHydraMouthOpening_Loop",
			PostAttackAnimation = "EnemyHydraMouthOpening_End",
			PreAttackDuration = 1.0,
			FireDuration = 0.2,
			PostAttackDuration = 2.0,
			AIAttackDistance = 50,
			AIBufferDistance = 0,
			MoveToId = 480903,
			AIMoveWithinRangeTimeout = 1.0,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,

			MaxActiveSpawns = 5,
			SpawnGroupName = "SpawnerHydra",

			MinAttacksBetweenUse = 4,
			ForceUseIfReady = true,

			FireTicks = 1,
			FireCooldown = 0.1,
			AttackSlotsPerTickMin = 1,
			AttackSlotsPerTickMax = 1,
			AttackSlotInterval = 0.4,
			AttackSlotPreFireWait = 0.1,
			AttackSlots =
			{
				{ UseMapObjectId = { B_Boss01 = 554433, B_Boss02 = 506394 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554435, B_Boss02 = 517858 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554431, B_Boss02 = 517857 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554428, B_Boss02 = 517859 }, InstantAngleTowardsTarget = true },
				{ UseMapObjectId = { B_Boss01 = 554426, B_Boss02 = 517856 }, InstantAngleTowardsTarget = true },
			},
		},
	},

	HydraSummonSpread2 =
	{
		InheritFrom = { "HydraSummonSpread" },

		AIData =
		{
			DeepInheritance = true,
			AttackSlotsPerTickMin = 2,
			AttackSlotsPerTickMax = 2,

			PreAttackVoiceLines =
			{
				PlayOnce = true,
				PlayOnceContext = "HydraSummonSpreadReaction",
				PreLineWait = 2.0,
				UsePlayerSource = true,
				RequiredKillEnemiesFound = true,

				-- Oh that's not good...
				{ Cue = "/VO/ZagreusField_3934" },
			},
		},
	},

	HydraSummonSpread3 =
	{
		InheritFrom = { "HydraSummonSpread" },

		AIData =
		{
			DeepInheritance = true,
			AttackSlotsPerTickMin = 3,
			AttackSlotsPerTickMax = 3,
		},
	},

	HydraSpawns =
	{
		StartingWeapon = false,

		AIData =
		{
			DeepInheritance = true,
			FireFunctionName = "HandleBossSpawns",
			SpawnOnSelf = true,
			AIAttackDistance = 50,
			AIBufferDistance = 10,
			FireCooldown = 0,

			MaxActiveSpawns = 10,
			SpawnGroupName = "SpawnerHydra",
			SpawnRadius = 0,
			SpawnInterval = 0.0,
			SpawnCount = 1,
			SpawnOptions =
			{
				"BloodlessNaked",
			},
			DoSpawnsActivatePresentation = false,
			SpawnAggroed = true,

			SkipFireWeapon = true,
			SkipMovement = true,
		},
	},

	HydraSpawns2 =
	{
		InheritFrom = { "HydraSpawns" },

		AIData =
		{
			DeepInheritance = true,
			SpawnOptions =
			{
				"BloodlessNakedBerserkerElite",
			},
		},
	},

	HydraHeal =
	{
		AIData =
		{
			PreAttackAnimation = "EnemyHydraHealing",
			FireAnimation = "EnemyHydraHealing",
			PostAttackAnimation = "EnemyHydraHealing",
			PreAttackDuration = 1.0,
			FireDuration = 3.0,
			PostAttackDuration = 1.0,
			AIAttackDistance = 1500,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = false,
			TargetFriends = true,

			MinAttacksBetweenUse = 1,
		},
	},

	-- Minotaur & Theseus Combos
	MinotaurTheseusThrow_Minotaur =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
		GameStateRequirements =
		{
			RequiredFalseFlags = { "HeroesMuted" },
		},

		BlockInterrupt = true,

		AIData =
		{
			MultiUnitAttack = true,
			RequireComboPartner = true,
			PartnerForceWeaponInterrupt = "MinotaurTheseusThrow",

			PreAttackAnimation = "Minotaur_Crouch",
			FireAnimation = "Minotaur_Throw",
			PostAttackAnimation = "Minotaur_ThrowReturnToIdle",

			WaitDurationForComboPartnerMove = 4,
			PreAttackDuration = 0.25,
			FireDuration = 0.25,
			PostAttackDuration = 0.5,
			PostAttackCooldown = 0.5,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,

			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,

			MaxDistanceFromComboPartner = 325,
			ForceUseIfReady	= true,

			MinAttacksBetweenUse = 1,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/EmoteThrowing" },
			},
		},
	},

	MinotaurTheseusSlam_Minotaur =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
		GameStateRequirements =
		{
			RequiredFalseFlags = { "HeroesMuted" },
			RequiredAnyTextLines = { "TheseusAboutFraternalBonds06_A", "TheseusAboutFraternalBonds06_B" },
		},

		BlockInterrupt = true,

		AIData =
		{
			MultiUnitAttack = true,
			RequireComboPartner = true,
			RequireComboPartnerNotifyName = "MinotaurTheseusSlam",
			ForceIfComboPartnerNotifyName = "MinotaurTheseusSlam",

			PreAttackAnimation = "Minotaur_BullRushCharge",
			FireAnimation = "Minotaur_BullRush",

			TargetComboPartner = true,
			EndPartnerWaitOnMoveEnd = false,
			EndPartnerWaitPostAttackAI = true,

			AIAttackDistance = 3000,
			AILineOfSightBuffer = 200,
			AILineOfSighEndBuffer = 80,
			AIRequireUnitLineOfSight = false,
			AIRequireProjectileLineOfSight = false,
			PreAttackDuration = 0.7,
			PostAttackAI = "MoveUntilEffectExpired",
			PostAttackAICanOnlyMoveForward = true,
			EffectExpiredName = "BullRushSpeed",
			MoveSuccessDistance = 32,
			PostAttackAIWait = 2.0,
			PostAttackCooldown = 0.0,

			AIMoveWithinRangeTimeout = 7.0,
			SkipAttackAfterMoveTimeout = true,
			MoveToComboPartner = true,

			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			
			PostAttackAIDumbFireWeapons = { "MinotaurTheseusSlamNova" },

			PreMoveVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 0.8,
					ObjectType = "Minotaur",
					RequiresSourceAlive = true,
					-- SuccessiveChanceToPlay = 0.50,
					CooldownTime = 25,
					CooldownName = "MinotaurSpecialPlayedRecently",
					RequiredFalseFlags = { "HeroesMuted" },

					-- King!
					{ Cue = "/VO/Minotaur_0116" },
					-- Theseus!
					{ Cue = "/VO/Minotaur_0117" },
					-- Here!
					{ Cue = "/VO/Minotaur_0118" },
					-- Here, king!
					{ Cue = "/VO/Minotaur_0119" },
					-- Now!
					{ Cue = "/VO/Minotaur_0120" },
					-- Now, king!
					{ Cue = "/VO/Minotaur_0121" },
					-- Together!
					{ Cue = "/VO/Minotaur_0122" },
					-- Ready!
					{ Cue = "/VO/Minotaur_0123" },
					-- Ready, king?
					{ Cue = "/VO/Minotaur_0124" },
					-- Show him!
					{ Cue = "/VO/Minotaur_0125" },
					-- Take him!
					{ Cue = "/VO/Minotaur_0126" },
					-- Get him!
					{ Cue = "/VO/Minotaur_0127" },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.8,
					ObjectType = "Minotaur2",
					RequiresSourceAlive = true,
					SuccessiveChanceToPlay = 0.50,
					CooldownTime = 25,
					CooldownName = "MinotaurSpecialPlayedRecently",
					RequiredFalseFlags = { "HeroesMuted" },

					-- King!
					{ Cue = "/VO/Minotaur_0116" },
					-- Theseus!
					{ Cue = "/VO/Minotaur_0117" },
					-- Here!
					{ Cue = "/VO/Minotaur_0118" },
					-- Here, king!
					{ Cue = "/VO/Minotaur_0119" },
					-- Now!
					{ Cue = "/VO/Minotaur_0120" },
					-- Now, king!
					{ Cue = "/VO/Minotaur_0121" },
					-- Together!
					{ Cue = "/VO/Minotaur_0122" },
					-- Ready!
					{ Cue = "/VO/Minotaur_0123" },
					-- Ready, king?
					{ Cue = "/VO/Minotaur_0124" },
					-- Show him!
					{ Cue = "/VO/Minotaur_0125" },
					-- Take him!
					{ Cue = "/VO/Minotaur_0126" },
					-- Get him!
					{ Cue = "/VO/Minotaur_0127" },
				},
			},
		},

		OnFireCrowdReaction = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy" }, Sound = "/SFX/TheseusCrowdCheer", ReactionChance = 0.08, Requirements = { RequiredRoom = "C_Boss01" }, Shake = true, RadialBlur = true },
	},

	MinotaurTheseusSlamNova =
	{
		AIData =
		{
			CancelIfNoComboPartner = true,
			CancelOutsideDistanceFromComboPartner = 135,
		},

		ImpactReactionHitsOverride = 1,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	MinotaurTheseusThrow_Theseus =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
		GameStateRequirements =
		{
			RequiredFalseFlags = { "HeroesMuted" },
		},

		BlockInterrupt = true,

		AIData =
		{
			MultiUnitAttack = true,
			RequireComboPartner = true,
			RequireComboPartnerNotifyName = "MinotaurTheseusThrow",
			ForceIfComboPartnerNotifyName = "MinotaurTheseusThrow",

			FireAnimation = "MinotaurTheseusThrow_Airborn",
			PostAttackAnimation = "MinotaurTheseusThrow_Landing",

			EndPartnerWaitOnMoveEnd = true,
			PreAttackDuration = 0.25,
			FireDuration = 0.25,
			PostAttackDuration = 1.0,

			AIMoveWithinRangeTimeout = 7.0,
			SkipAttackAfterMoveTimeout = true,
			MoveToComboPartner = true,
			AIAttackDistance = 150,

			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,

			RemoveUnitCollisionDuringAttack = true,
		},
		Sounds =
		{
			FireSounds =
			{
				-- { Name = "/SFX/Enemy Sounds/Theseus/EmotePowerAttacking" },
				{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				{ Name = "/SFX/Enemy Sounds/Theseus/EmoteSpecialAttack" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},

		OnFireCrowdReaction = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy" }, Sound = "/SFX/TheseusCrowdCheer", ReactionChance = 0.08, Requirements = { RequiredRoom = "C_Boss01" }, Shake = true, RadialBlur = true },
	},

	MinotaurTheseusSlam_Theseus =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
		GameStateRequirements =
		{
			RequiredFalseFlags = { "HeroesMuted" },
			RequiredAnyTextLines = { "TheseusAboutFraternalBonds06_A", "TheseusAboutFraternalBonds06_B" },
		},

		BlockInterrupt = true,

		AIData =
		{
			MultiUnitAttack = true,
			RequireComboPartner = true,
			TargetComboPartner = true,
			PartnerForceWeaponInterrupt = "MinotaurTheseusSlam",

			PreAttackAnimation = "MinotaurTheseusSlam_TheseusHold",
			--FireAnimation = "MinotaurTheseusThrow_Airborn",
			PostAttackAnimation = "TheseusSpearSpin_ReturnToIdle",

			WaitDurationForComboPartnerMove = 6,
			PreAttackDuration = 0.25,
			FireDuration = 0.25,
			PostAttackDuration = 0.5,
			PostAttackCooldown = 0.5,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,

			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,

			MinDistanceFromComboPartner = 400,
			MinAttacksBetweenUse = 6,
			ForceUseIfReady	= true,

			PreMoveVoiceLines =
			{
				{
					RandomRemaining = true,
					ObjectType = "Theseus",
					RequiresSourceAlive = true,
					-- SuccessiveChanceToPlay = 0.25,
					CooldownTime = 25,
					CooldownName = "TheseusSpecialPlayedRecently",
					PreLineWait = 0.15,
					RequiredFalseFlags = { "HeroesMuted" },

					-- Ready!
					{ Cue = "/VO/Theseus_0057" },
					-- Asterius!
					{ Cue = "/VO/Theseus_0058" },
					-- Bull!
					{ Cue = "/VO/Theseus_0059" },
					-- Here!
					{ Cue = "/VO/Theseus_0060" },
					-- Do it!
					{ Cue = "/VO/Theseus_0061" },
					-- Now!
					{ Cue = "/VO/Theseus_0062" },
					-- Together!
					{ Cue = "/VO/Theseus_0063" },
					-- Attack!
					{ Cue = "/VO/Theseus_0064" },
					-- Huh!
					{ Cue = "/VO/Theseus_0065" },
					-- Go!
					{ Cue = "/VO/Theseus_0066" },
					-- Show him!
					{ Cue = "/VO/Theseus_0067" },
				},
				{
					RandomRemaining = true,
					ObjectType = "Theseus2",
					RequiresSourceAlive = true,
					-- SuccessiveChanceToPlay = 0.25,
					CooldownTime = 25,
					CooldownName = "TheseusSpecialPlayedRecently",
					PreLineWait = 0.15,
					RequiredFalseFlags = { "HeroesMuted" },

					-- Ready!
					{ Cue = "/VO/Theseus_0057" },
					-- Asterius!
					{ Cue = "/VO/Theseus_0058" },
					-- Bull!
					{ Cue = "/VO/Theseus_0059" },
					-- Here!
					{ Cue = "/VO/Theseus_0060" },
					-- Do it!
					{ Cue = "/VO/Theseus_0061" },
					-- Now!
					{ Cue = "/VO/Theseus_0062" },
					-- Together!
					{ Cue = "/VO/Theseus_0063" },
					-- Attack!
					{ Cue = "/VO/Theseus_0064" },
					-- Huh!
					{ Cue = "/VO/Theseus_0065" },
					-- Go!
					{ Cue = "/VO/Theseus_0066" },
					-- Show him!
					{ Cue = "/VO/Theseus_0067" },
				},
			},

		},

		OnFireCrowdReaction = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy" }, Sound = "/SFX/TheseusCrowdCheer", ReactionChance = 0.08, Requirements = { RequiredRoom = "C_Boss01" }, Shake = true, RadialBlur = true },
	},

	-- UNUSED! --
	MinotaurTheseusXStrike_Minotaur =
	{
		AIData =
		{
			MultiUnitAttack = true,
			RequireComboPartner = true,
			PartnerForceWeaponInterrupt = "MinotaurTheseusXStrike",

			PreAttackAnimation = "Minotaur_Crouch",
			FireAnimation = "Minotaur_BullRush",

			WaitDurationForComboPartnerMove = 7,
			PreAttackDuration = 0.3,
			FireDuration = 0.3,
			PostAttackDuration = 1.2,
			AIAttackDistance = 600,
			AIBufferDistance = 550,

			MinAttacksBetweenUse = 2,

			RemoveUnitCollisionDuringAttack = true,
		},
	},

	-- UNUSED! --
	MinotaurTheseusXStrike_Theseus =
	{
		AIData =
		{
			MultiUnitAttack = true,
			RequireComboPartner = true,
			RequireComboPartnerNotifyName = "MinotaurTheseusXStrike",
			ForceIfComboPartnerNotifyName = "MinotaurTheseusXStrike",

			PreAttackAnimation = "ShadeSword_OnHit",
			FireAnimation = "ShadeShield_AttackFire",

			EndPartnerWaitOnMoveEnd = true,
			PreAttackDuration = 0.15,
			FireDuration = 0.3,
			PostAttackDuration = 1.2,
			AIAttackDistance = 600,
			AIBufferDistance = 550,

			RemoveUnitCollisionDuringAttack = true,
		},
	},

	-- Minotaur
	MinotaurArmoredAxeSpin =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "MinotaurArmored_AxeSpinStart",
			FireAnimation = "MinotaurArmored_AxeSpin_Fire",
			PostAttackAnimation = "MinotaurArmored_AxeSpin_ReturnToIdle",

			PreAttackEndShake = true,
			PreAttackDuration = 1.3,
			FireDuration = 0.25,
			PostAttackDuration = 2.0,
			AIAttackDistance = 390,
			AIBufferDistance = 340,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 200,
			AILineOfSighEndBuffer = 80,
			AIMoveWithinRangeTimeout = 5.0,
			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,
			ResetTargetPerTick = true,

			FireTicks = 15,
			FireCooldown = 0.4,

			MinAttacksBetweenUse = 3,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				--{ Name = "/SFX/Enemy Sounds/Minotaur/EmoteAttacking" },
			},
		},

		OnFireCrowdReaction = { AnimationNames = { "StatusIconFear", "StatusIconOhBoy" }, Sound = "/SFX/TheseusCrowdCheer", ReactionChance = 0.05, Requirements = { RequiredRoom = "C_Boss01" }, Shake = true, RadialBlur = true },
	},

	Minotaur5AxeCombo1 =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "MinotaurAttackSwings_PreAttack",
			FireAnimation = "MinotaurAttackSwings_Attack1",

			PreAttackEndShake = true,
			PreAttackDuration = 0.8,
			-- PreAttackSound (below) hooked up to PreAttackAnimation
			-- PreAttackSound = "/SFX/Enemy Sounds/Minotaur/EmotePoweringUp",
			FireDuration = 0.25,
			PostAttackDuration = 0.0,
			AIAttackDistance = 390,
			AIBufferDistance = 340,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 200,
			AILineOfSighEndBuffer = 80,
			AIMoveWithinRangeTimeout = 5.0,
			AITrackTargetDuringCharge = true,

			ChainedWeapon = "Minotaur5AxeCombo2",
			MaxConsecutiveUses = 2,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/EmoteAttacking" },
			},
		},
	},

	MinotaurArmored5AxeCombo1 =
	{
		InheritFrom = { "Minotaur5AxeCombo1" },

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "MinotaurArmoredAttackSwings_PreAttack",
			FireAnimation = "MinotaurArmoredAttackSwings_Attack1",

			ChainedWeapon = "MinotaurArmored5AxeCombo2",
		}
	},

	Minotaur5AxeCombo2 =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},

		GenusName = "Minotaur5AxeCombo1",

		AIData =
		{
			DeepInheritance = true,
			FireAnimation = "MinotaurAttackSwings_Attack2",
			PostAttackAnimation = "MinotaurAttackSwings_ReturnToIdle",


			PreAttackDuration = 0.25,
			PreAttackEndMinWaitTime = 0.25,
			FireDuration = 0.3,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			AIRequireUnitLineOfSight = false,
			SkipAngleTowardTarget = true,
			SkipMovement = true,

			ChainedWeapon = "Minotaur5AxeCombo3"
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/EmoteAttacking" },
			},
		},
	},

	MinotaurArmored5AxeCombo2 =
	{
		InheritFrom = { "Minotaur5AxeCombo2" },

		AIData =
		{
			DeepInheritance = true,
			FireAnimation = "MinotaurArmoredAttackSwings_Attack2",
			PostAttackAnimation = "MinotaurArmoredAttackSwings_ReturnToIdle",

			ChainedWeapon = "MinotaurArmored5AxeCombo3"
		}
	},

	Minotaur5AxeCombo3 =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},

		GenusName = "Minotaur5AxeCombo1",
		ChainedOnly = true,
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "MinotaurAttackSwings_PreAttackLeap",

			PreAttackDuration = 0.4,
			FireDuration = 0.3,
			PostAttackDuration = 0.4,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			AIRequireUnitLineOfSight = false,
			SkipAngleTowardTarget = false,
			SkipMovement = false,
			PreAttackEndShake = true,

			ChainedWeapon = "Minotaur5AxeCombo4",
			RageDumbFireWeapons = { "MinotaurOverheadShockwave" },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/EmoteAttacking" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		Upgrades = { },
	},

	MinotaurArmored5AxeCombo3 =
	{
		InheritFrom = { "Minotaur5AxeCombo3" },

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "MinotaurArmoredAttackSwings_PreAttackLeap",

			ChainedWeapon = "MinotaurArmored5AxeCombo4"
		}
	},

	Minotaur5AxeCombo4 =
	{
		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},

		GenusName = "Minotaur5AxeCombo1",
		ChainedOnly = true,
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "MinotaurAttackSwings_PreAttack",
			FireAnimation = "MinotaurAttackSwings_Attack1",

			PreAttackDuration = 0.35,
			PreAttackEndMinWaitTime = 0.25,
			PreAttackEndMinWaitTime = 0.05,
			FireDuration = 0.1,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			AIRequireUnitLineOfSight = false,
			SkipAngleTowardTarget = false,
			SkipMovement = true,

			ChainedWeapon = "Minotaur5AxeCombo5"
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/EmoteAttacking" },
			},
		},
		Upgrades = { },
	},

	MinotaurArmored5AxeCombo4 =
	{
		InheritFrom = { "Minotaur5AxeCombo4" },

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "MinotaurArmoredAttackSwings_PreAttack",
			FireAnimation = "MinotaurArmoredAttackSwings_Attack1",

			ChainedWeapon = "MinotaurArmored5AxeCombo5"
		}
	},

	Minotaur5AxeCombo5 =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},

		GenusName = "Minotaur5AxeCombo1",
		ChainedOnly = true,
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			DeepInheritance = true,
			FireAnimation = "MinotaurAttackSwings_Attack2",
			PostAttackAnimation = "MinotaurAttackSwings_ReturnToIdle",

			FireDuration = 0.1,
			PreAttackDuration = 0.3,
			PreAttackEndMinWaitTime = 0.3,
			PostAttackDuration = 2.8,
			AIAttackDistance = 9999,
			AIRequireUnitLineOfSight = false,
			SkipAngleTowardTarget = true,
			SkipMovement = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/EmotePowerAttacking" },
			},
		},
		Upgrades = { },
	},

	MinotaurArmored5AxeCombo5 =
	{
		InheritFrom = { "Minotaur5AxeCombo5" },

		AIData =
		{
			DeepInheritance = true,
			FireAnimation = "MinotaurArmoredAttackSwings_Attack2",
			PostAttackAnimation = "MinotaurArmoredAttackSwings_ReturnToIdle",
		}
	},

	MinotaurLeapCombo1 =
	{
		InheritFrom = {"Minotaur5AxeCombo1"},
		GenusName = "MinotaurLeapCombo1",

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MinotaurLeapCombo2",
		},
	},

	MinotaurArmoredLeapCombo1 =
	{
		InheritFrom = { "MinotaurArmored5AxeCombo1" },

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MinotaurArmoredLeapCombo2",
		}
	},

	MinotaurLeapCombo2 =
	{
		InheritFrom = {"Minotaur5AxeCombo2"},
		GenusName = "MinotaurLeapCombo1",

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MinotaurLeapCombo3",
		},
	},

	MinotaurArmoredLeapCombo2 =
	{
		InheritFrom = { "MinotaurArmored5AxeCombo2" },

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MinotaurArmoredLeapCombo3",
		}
	},

	MinotaurLeapCombo3 =
	{
		InheritFrom = {"Minotaur5AxeCombo3"},
		GenusName = "MinotaurLeapCombo1",

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MinotaurLeapCombo4",
		},
	},

	MinotaurArmoredLeapCombo3 =
	{
		InheritFrom = { "MinotaurArmored5AxeCombo3" },

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MinotaurArmoredLeapCombo4",
		}
	},

	MinotaurLeapCombo4 =
	{
		InheritFrom = {"MinotaurLeapCombo3"},
		GenusName = "MinotaurLeapCombo1",

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MinotaurLeapCombo5",
		},
	},

	MinotaurArmoredLeapCombo4 =
	{
		InheritFrom = { "MinotaurArmoredLeapCombo3" },

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MinotaurArmoredLeapCombo5",
		}
	},

	MinotaurLeapCombo5 =
	{
		GenusName = "MinotaurLeapCombo1",

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},

		ChainedOnly = true,
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "MinotaurAttackSwings_PreAttackLeap",
			RageDumbFireWeapons = { "MinotaurOverheadShockwave" },

			PreAttackDuration = 0.4,
			FireDuration = 0.3,
			PostAttackDuration = 1.7,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			AIRequireUnitLineOfSight = false,
			SkipAngleTowardTarget = false,
			SkipMovement = false,
			PreAttackEndShake = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/EmoteAttacking" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	MinotaurArmoredLeapCombo5 =
	{
		InheritFrom = { "MinotaurLeapCombo5" },

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "MinotaurArmoredAttackSwings_PreAttackLeap",
		}
	},

	MinotaurCrescentCombo1 =
	{
		InheritFrom = {"Minotaur5AxeCombo1"},
		GenusName = "MinotaurCrescentCombo1",

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MinotaurCrescentCombo2",
		},
	},

	MinotaurArmoredCrescentCombo1 =
	{
		InheritFrom = { "MinotaurArmored5AxeCombo1" },

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MinotaurArmoredCrescentCombo2",
		}
	},

	MinotaurCrescentCombo2 =
	{
		InheritFrom = {"Minotaur5AxeCombo2"},
		GenusName = "MinotaurCrescentCombo1",

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MinotaurCrescentCombo3",
		},
	},

	MinotaurArmoredCrescentCombo2 =
	{
		InheritFrom = { "MinotaurArmored5AxeCombo2" },

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MinotaurArmoredCrescentCombo3",
		}
	},

	MinotaurCrescentCombo3 =
	{
		InheritFrom = {"MinotaurAxeCrescentStrike"},
		GenusName = "MinotaurCrescentCombo1",

		AIData =
		{
			DeepInheritance = true,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			AIRequireUnitLineOfSight = false,
			SkipAngleTowardTarget = true,
			SkipMovement = true,

			PreAttackAnimation = "Minotaur_PreCrescentStrike",
			FireAnimation = "Minotaur_CrescentStrike",
			PostAttackAnimation = "Minotaur_CrescentStrikeReturnToIdle",

			PreAttackDuration = 0.2,
			FireDuration = 0.3,
			PostAttackDuration = 1.0,
		},
	},

	MinotaurArmoredCrescentCombo3 =
	{
		InheritFrom = { "MinotaurArmoredAxeCrescentStrike" },

		AIData =
		{
			DeepInheritance = true,

			PreAttackAnimation = "MinotaurArmored_PreCrescentStrike",
			FireAnimation = "MinotaurArmored_CrescentStrike",
			PostAttackAnimation = "MinotaurArmored_CrescentStrikeReturnToIdle",
		}
	},

	MinotaurAxeOverhead =
	{
		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			DeepInheritance = true,

			RageDumbFireWeapons = { "MinotaurOverheadShockwave" },
			PreAttackAnimation = "MinotaurAttackSwings_PreAttackLeap",
			PreAttackSound = "/SFX/Enemy Sounds/Minotaur/EmoteCharging",

			PreAttackEndShake = true,
			PreAttackDuration = 0.4,
			FireDuration = 0.3,
			PostAttackDuration = 0.1,
			AIAttackDistance = 675,
			AIAttackDistance = 650,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 150,
			PreAttackEndShake = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/Leftovers/SFX/PlayerJump" },
			},
		},

		Upgrades = { },
	},

	MinotaurArmoredAxeOverhead =
	{
		InheritFrom = { "MinotaurAxeOverhead" },

		AIData =
		{
			DeepInheritance = true,

			PreAttackAnimation = "MinotaurArmoredAttackSwings_PreAttackLeap",
			PreAttackSound = "/SFX/Enemy Sounds/Minotaur/EmoteCharging",
		}
	},

	MinotaurOverheadShockwave =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		ChainedOnly = true,
		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			PreAttackDuration = 0.4,
			FireDuration = 0.05,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			SkipMovement = true,
			SkipAngleTowardTarget = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				{ Name = "/SFX/Player Sounds/ZagreusSwordParry" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/EmotePowerAttacking" },
			},
		},

		Upgrades = { },

	},

	MinotaurAxeCrescentStrike =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			DeepInheritance = true,

			AIAttackDistance = 300,
			AIBufferDistance = 275,
			AIRequireUnitLineOfSight = false,
			SkipAngleTowardTarget = true,
			SkipMovement = true,

			PreAttackAnimation = "Minotaur_PreCrescentStrike",
			FireAnimation = "Minotaur_CrescentStrike",
			PostAttackAnimation = "Minotaur_CrescentStrikeReturnToIdle",

			PreAttackDuration = 0.0,
			FireDuration = 0.3,
			PostAttackDuration = 1.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/EmotePowerAttacking" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	MinotaurArmoredAxeCrescentStrike =
	{
		InheritFrom = { "MinotaurAxeCrescentStrike" },
		AIData =
		{
			DeepInheritance = true,

			PreAttackAnimation = "MinotaurArmored_PreCrescentStrike",
			FireAnimation = "MinotaurArmored_CrescentStrike",
			PostAttackAnimation = "MinotaurArmored_CrescentStrikeReturnToIdle",
		},
	},

	MinotaurBullRush =
	{
		BlockInterrupt = true,
		AIData =
		{
			DeepInheritance = true,
			AIAttackDistance = 3000,
			AILineOfSightBuffer = 200,
			AILineOfSighEndBuffer = 80,
			AIRequireUnitLineOfSight = true,
			AIRequireProjectileLineOfSight = false,
			PreAttackAnimation = "Minotaur_BullRushCharge",
			PreAttackDuration = 0.7,
			FireAnimation = "Minotaur_BullRush",
			PostAttackAI = "MoveUntilEffectExpired",
			PostAttackAICanOnlyMoveForward = true,
			EffectExpiredName = "BullRushSpeed",
			MoveSuccessDistance = 32,
			PostAttackAIWait = 2.0,
			PostAttackCooldown = 0.0,
			MinAttacksBetweenUse = 1,

			CancelIfInvisTarget = true,

			MinPlayerDistance = 300,

			PreAttackVoiceLines =
			{
				PlayedNothingFunctionName = "GenericPresentation",
				PlayedNothingFunctionArgs = { Sound = "/SFX/Enemy Sounds/Minotaur/EmotePreparingToCharge", },
				Cooldowns =
				{
					{ Name = "MinotaurBullRushSpeech", Time = 40 },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.35,
					SuccessiveChanceToPlay = 0.33,

					-- Prepare yourself.
					{ Cue = "/VO/Minotaur_0104" },
					-- Prepare.
					{ Cue = "/VO/Minotaur_0105" },
					-- Now, short one...
					{ Cue = "/VO/Minotaur_0106" },
					-- I'll get you.
					{ Cue = "/VO/Minotaur_0107" },
					-- Watch yourself.
					{ Cue = "/VO/Minotaur_0108" },
					-- Beware.
					{ Cue = "/VO/Minotaur_0109" },
					-- Rage...
					{ Cue = "/VO/Minotaur_0110" },
					-- Now...
					{ Cue = "/VO/Minotaur_0111" },
					-- Run.
					{ Cue = "/VO/Minotaur_0112" },
					-- <Snort><Snort>
					{ Cue = "/VO/Minotaur_0113" },
					-- Grruaaaaahhh...
					{ Cue = "/VO/Minotaur_0114" },
					-- Nrraaauuugghh...
					{ Cue = "/VO/Minotaur_0115" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlay = 0.02,
					PreLineWait = 0.3,
					UsePlayerSource = true,
					PlayOnceFromTableThisRun = true,

					-- He's mad!
					-- { Cue = "/VO/ZagreusField_1812" },
					-- He's angry now.
					{ Cue = "/VO/ZagreusField_1813" },
					-- Here he comes!
					-- { Cue = "/VO/ZagreusField_1814" },
					-- Here he comes.
					{ Cue = "/VO/ZagreusField_1815" },
					-- Riled him up!
					{ Cue = "/VO/ZagreusField_1816" },
					-- Uh oh...!
					{ Cue = "/VO/ZagreusField_1817" },
					-- Let's all calm down, OK?!
					-- { Cue = "/VO/ZagreusField_1818" },
				},
			},
		},

		OnFireCrowdReaction = { AnimationNames = { "StatusIconFear", "StatusIconOhBoy" }, Sound = "/SFX/TheseusCrowdCheer", ReactionChance = 0.05, Requirements = { RequiredRoom = "C_Boss01" }, Shake = true, RadialBlur = true },
	},

	MinotaurBullRush2 =
	{
		InheritFrom = { "MinotaurBullRush" },
		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MinotaurAxeCrescentStrike",

			AIAttackDistance = 3000,
			AILineOfSightBuffer = 200,
			AILineOfSighEndBuffer = 80,
			AIRequireUnitLineOfSight = true,
			AIRequireProjectileLineOfSight = false,
			PreAttackAnimation = "Minotaur_BullRushCharge",
			PreAttackDuration = 1.0,
			PreAttackSound = "/SFX/Enemy Sounds/Minotaur/EmotePreparingToCharge",
			FireAnimation = "Minotaur_BullRush",
			PostAttackAI = "MoveUntilEffectExpired",
			PostAttackAICanOnlyMoveForward = true,
			EffectExpiredName = "BullRushSpeed",
			MoveSuccessDistance = 32,
			PostAttackAIWait = 0.0,
			PostAttackCooldown = 0.0,
			MinAttacksBetweenUse = 1,
		},
	},

	MinotaurArmoredBullRush =
	{
		InheritFrom = { "MinotaurBullRush" },
		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "MinotaurArmored_BullRushCharge",
			FireAnimation = "MinotaurArmored_BullRush",
			EffectExpiredName = "ArmoredBullRushSpeed",
			MinAttacksBetweenUse = 2,
			ForceUseIfReady = true,
		},
		OnFireCrowdReaction = { AnimationNames = { "StatusIconFear", "StatusIconOhBoy" }, Sound = "/SFX/TheseusCrowdCheer", ReactionChance = 0.05, Requirements = { RequiredRoom = "C_Boss01" }, Shake = true, RadialBlur = true },
	},

	MinotaurArmoredBullRush2 =
	{
		InheritFrom = { "MinotaurBullRush2" },
		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "MinotaurArmored_BullRushCharge",
			FireAnimation = "MinotaurArmored_BullRush",
			EffectExpiredName = "ArmoredBullRushSpeed",
			ChainedWeapon = "MinotaurArmoredAxeCrescentStrike",
		},
	},

	MinotaurBullRushRam =
	{
		HitScreenshake = { Distance = 5, Speed = 1500, Duration = 0.20, FalloffSpeed = 3000 },
		FireScreenshake = { Distance = 5, Speed = 1500, Duration = 0.15, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.00, LerpTime = 0.07 },
		},
	},
	MinotaurArmoredBullRushRam =
	{
		HitScreenshake = { Distance = 5, Speed = 1500, Duration = 0.20, FalloffSpeed = 3000 },
		FireScreenshake = { Distance = 5, Speed = 1500, Duration = 0.15, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.00, LerpTime = 0.07 },
		},
	},

	MinotaurOverheadTouchdown =
	{
		FireScreenshake = { Distance = 4, Speed = 800, Duration = 0.15, FalloffSpeed = 3000 },
	},

	MinotaurArmoredOverheadTouchdown =
	{
		FireScreenshake = { Distance = 4, Speed = 800, Duration = 0.15, FalloffSpeed = 3000 },
	},

	-- Theseus
	TheseusSpearSpin =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			DeepInheritance = true,

			PreAttackAnimation = "TheseusSpearSpin_PreAttack",
			PreAttackFx = "TheseusSpinPreview",
			FireAnimation = "TheseusSpearSpin_Attack",
			PostAttackAnimation = "TheseusSpearSpin_ReturnToIdle",
			PreAttackDuration = 0.6,
			FireDuration = 0.5,
			PostAttackDuration = 0.5,
			PostAttackCooldownMin = 1.5,
			PostAttackCooldownMax = 2.0,
			PreAttackSound = "/SFX/Enemy Sounds/Theseus/EmoteCharging",

			AIAttackDistance = 275,
			AIBufferDistance = 250,

			AIMoveWithinRangeTimeout = 3.0,

			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 150,

			MaxPlayerDistance = 600,
		},

		GodUpgradeWeaponSwap = 
		{
			AphroditeUpgrade = "TheseusSpearSpinAphrodite",
			AresUpgrade = "TheseusSpearSpinAres",
			ArtemisUpgrade = "TheseusSpearSpinArtemis",
			AthenaUpgrade = "TheseusSpearSpinAthena",
			DemeterUpgrade = "TheseusSpearSpinDemeter",
			DionysusUpgrade = "TheseusSpearSpinDionysus",
			PoseidonUpgrade = "TheseusSpearSpinPoseidon",
			ZeusUpgrade = "TheseusSpearSpinZeus",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Theseus/EmotePowerAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearSwipe" },
				{ Name = "/Leftovers/SFX/AuraThrow" }
			},
		},

	},

	TheseusSpearSpinAphrodite =
	{
		InheritFrom = { "TheseusSpearSpin" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusSpearSpinAres =
	{
		InheritFrom = { "TheseusSpearSpin" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusSpearSpinAresBlades =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 5,
			FireCooldown = 0.02,

			PreAttackDuration = 0.0,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
		},
	},

	TheseusSpearSpinArtemis =
	{
		InheritFrom = { "TheseusSpearSpin" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusSpearSpinArtemisHomingBolts =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 3,
			FireCooldown = 0.02,

			PreAttackDuration = 0.0,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
		},

	},

	TheseusSpearSpinAthena =
	{
		InheritFrom = { "TheseusSpearSpin" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusSpearSpinDemeter =
	{
		InheritFrom = { "TheseusSpearSpin" },

		AIData =
		{
			DeepInheritance = true,
			DumbFireWeapons = { "TheseusSpearSpinDemeterNova" },
		},
	},

	TheseusSpearSpinDemeterNova =
	{
		StartingWeapon = false,

		--[[
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
		]]

		AIData =
		{
			PreAttackDuration = 0.0,
			PostAttackDuration = 0.0,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,

			AITrackTargetDuringCharge = false,
		},

		Upgrades = { },
	},

	TheseusSpearSpinDionysus =
	{
		InheritFrom = { "TheseusSpearSpin" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusSpearSpinDionysusPuddles =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 7,
			FireCooldown = 0.05,

			PreAttackDuration = 0.0,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,

			TargetSelf = true,
		},
	},

	TheseusSpearSpinPoseidon =
	{
		InheritFrom = { "TheseusSpearSpin" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusSpearSpinZeus =
	{
		InheritFrom = { "TheseusSpearSpin" },

		AIData =
		{
			DeepInheritance = true,
			DumbFireWeapons = { "TheseusSpearSpinZeusBolt" },
		},
	},

	TheseusSpearSpinZeusBolt =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData = {
			TargetSelf = true,

			PreAttackDuration = 0.75,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusSpearThrow =
	{
		HitScreenshake = { Distance = 4, Speed = 1200, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.18, Fraction = 1.0, LerpTime = 0 },
		},

		BlockInterrupt = true,
		SkipToChainedWeaponIfObstacleExists = "TheseusSpearReturnPoint",
		GenusName = "TheseusSpearThrow",
		AIData =
		{
			DeepInheritance = true,
			--PreAttackDuration = 1.0,
			PreAttackDurationMin = 1.35,
			PreAttackDurationMax = 1.8,
			PreAttackEndShake = true,
			WaitUntilProjectileDeath = "TheseusSpearThrow",
			PostAttackDuration = 0.0,
			PreAttackSound = "/SFX/Enemy Sounds/Theseus/EmoteCharging",

			ChainedWeapon = "TheseusSpearThrowReturn",

			PreAttackAnimation = "TheseusSpearThrow_Charge",
			FireAnimation = "TheseusSpearThrow_Fire",
			AITrackTargetDuringCharge = true,
			SkipStopBeforePreAttackEnd = true,
			AIAngleTowardsPlayerWhileFiring = false,

			AIAttackDistance = 950,
			AIBufferDistance = 850,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 80,

			MinPlayerDistance = 200,

			AIChargeTargetMarker = "TheseusSpearTargetMarker",

			PreAttackVoiceLines =
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.35,
					CooldownTime = 30,
					ChanceToPlay = 0.3,
					RequiredFalseFlags = { "HeroesMuted" },
					Cooldowns =
					{
						{ Name = "TheseusSpokeRecently", Time = 10 },
					},

					-- Prepare!
					{ Cue = "/VO/Theseus_0083" },
					-- Here, fiend!
					{ Cue = "/VO/Theseus_0084" },
					-- Hold, you monster!
					{ Cue = "/VO/Theseus_0085" },
					-- Here!
					{ Cue = "/VO/Theseus_0086" },
					-- Catch!
					{ Cue = "/VO/Theseus_0087" },
					-- Begone!!
					{ Cue = "/VO/Theseus_0076" },
					-- Take this!!
					{ Cue = "/VO/Theseus_0069" },
					-- Now, fiend...!
					{ Cue = "/VO/Theseus_0077" },
					-- Ready yourself!
					{ Cue = "/VO/Theseus_0078" },
					-- Prepare yourself!
					{ Cue = "/VO/Theseus_0079" },
					-- Are you prepared?
					{ Cue = "/VO/Theseus_0082" },
					-- No holding back!
					{ Cue = "/VO/Theseus_0080" },
					-- Now, hellspawn...!
					{ Cue = "/VO/Theseus_0081" },
					-- Have at you!
					{ Cue = "/VO/Theseus_0464" },
					-- I see you, fiend!
					{ Cue = "/VO/Theseus_0465" },
					-- Come, blackguard!
					{ Cue = "/VO/Theseus_0466" },
					-- You're mine!
					{ Cue = "/VO/Theseus_0467" },
					-- Here, daemon!
					{ Cue = "/VO/Theseus_0468" },
					-- Begone, I say!
					{ Cue = "/VO/Theseus_0469" },
					-- You try evading this!
					{ Cue = "/VO/Theseus_0470" },
					-- I swear I'll get you yet!
					{ Cue = "/VO/Theseus_0471" },
					-- Face me!
					{ Cue = "/VO/Theseus_0472" },
					-- Stand and fight!
					{ Cue = "/VO/Theseus_0473" },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.35,
					ChanceToPlay = 0.3,
					RequiredFalseFlags = { "HeroesMuted" },
					Cooldowns =
					{
						{ Name = "TheseusTauntSpeech", Time = 55 },
					},

					-- Fiend! Who taught you such sloppy technique?!
					{ Cue = "/VO/Theseus_0240" },
					-- Fiend! You are unfit to walk these hallowed passageways!
					{ Cue = "/VO/Theseus_0241" },
					-- Monster! Your battle prowess leaves much to be desired!
					{ Cue = "/VO/Theseus_0242" },
					-- Monster! You have no bearing, and no grace or courage!
					{ Cue = "/VO/Theseus_0243" },
					-- Hoh, blackguard! How your spirit must be quivering inside!
					{ Cue = "/VO/Theseus_0244" },
					-- Well, hellspawn! Not ready to admit defeat, as yet?
					{ Cue = "/VO/Theseus_0245" },
					-- You have a lot of nerve, hellspawn! But little else!
					{ Cue = "/VO/Theseus_0246" },
					-- Come, monster! Attack with everything you have!
					{ Cue = "/VO/Theseus_0247" },
					-- I do not fear you, fiend! Your presence is a stain upon Elysium!
					{ Cue = "/VO/Theseus_0248" },
					-- Well, fiend! Are you yet fearful for the inevitable end to your foul quest?
					{ Cue = "/VO/Theseus_0249" },
					-- So, monster! You think you have the wherewithal to achieve victory?!
					{ Cue = "/VO/Theseus_0250" },
					-- You, blackguard! By my honor and the gods, you shall soon be destroyed!
					{ Cue = "/VO/Theseus_0251" },
					-- Now it is abundantly apparent that you are beneath me, fiend!
					{ Cue = "/VO/Theseus_0252" },
					-- Have you anything to say for yourself, daemon? Before I slay you once again?
					{ Cue = "/VO/Theseus_0253", ConsecutiveDeathsInRoom = { Name = "C_Boss01", Count = 1, }, },
					-- What now, filth? Are you prepared to be sent screaming back to the hellish darkness?!
					{ Cue = "/VO/Theseus_0255" },
					-- Back, foul daemon, or be vanquished even faster than you've come to expect!
					{ Cue = "/VO/Theseus_0256" },
					-- Cower uncontrollably, you monster, for there's naught else you can do against my might!
					{ Cue = "/VO/Theseus_0258" },
					-- I warn you, filth, you'll gain no quarter from me, or my good companion over there!
					{ Cue = "/VO/Theseus_0259", RequiredAnyUnitAlive = { "Minotaur", "Minotaur2" } },
					-- Undeserving fiend, all which you think you have achieved was merely handed you!
					{ Cue = "/VO/Theseus_0260" },
					-- What is the matter, fiend? Is your weak sense of resolve already shaken?!
					{ Cue = "/VO/Theseus_0261" },
					-- Foul daemon! We shall thwart your each and every trespass in Elysium!
					{ Cue = "/VO/Theseus_0263" },
					-- Attack me if you dare, blackguard! Either way, I shall crush you!
					{ Cue = "/VO/Theseus_0264" },
					-- Hold, you unwelcome pustule! I shall run you through!
					{ Cue = "/VO/Theseus_0265" },
					-- Your slouching form is but a laughingstock compared to my superior technique!
					{ Cue = "/VO/Theseus_0488" },
					-- You've no defense against my blessed spear, blackguard!
					{ Cue = "/VO/Theseus_0489" },
					-- You are all talk, you know that, don't you, filth?!
					{ Cue = "/VO/Theseus_0490" },
					-- Cower all you wish! My blessed spear shall find you, anyway!
					{ Cue = "/VO/Theseus_0491" },
					-- Come fight me in the open, fiend, or are you quite afraid?!
					{ Cue = "/VO/Theseus_0492" },
					-- He thinks that he can vanquish us, Asterius!
					{ Cue = "/VO/Theseus_0493", RequiredAnyUnitAlive = { "Minotaur", "Minotaur2" } },
					-- You have insulted me too many times, blackguard!
					{ Cue = "/VO/Theseus_0494" },
					-- You'll get no quarter from me, daemon!
					{ Cue = "/VO/Theseus_0495" },
					-- Oh, stand and fight, and quit it with your writhing there, hellspawn!
					{ Cue = "/VO/Theseus_0496" },
					-- You are unwelcome in Elysium, and I shall happily escort you out!
					{ Cue = "/VO/Theseus_0497" },
					-- A monster such as you shall never have a chariot as fine as this!
					{ Cue = "/VO/Theseus_0498", RequiredAnyUnitAlive = { "Theseus2" } },
					-- You shall be imminently crushed beneath my chariot, you filth!
					{ Cue = "/VO/Theseus_0499", RequiredAnyUnitAlive = { "Theseus2" } },
					-- Either I'll run you down or else I'll run you through, hellspawn!
					{ Cue = "/VO/Theseus_0500", RequiredAnyUnitAlive = { "Theseus2" } },
					-- Do not think for a moment that you can outrun the Macedonian!
					{ Cue = "/VO/Theseus_0501", RequiredAnyUnitAlive = { "Theseus2" } },
					-- You truly think you shall withstand our unsurpassable Bullhorn technique?!
					{ Cue = "/VO/Theseus_0502", RequiredAnyUnitAlive = { "Minotaur", "Minotaur2" } },
					-- There is no greater pleasure than to send my spear straight into you and back, daemon!
					{ Cue = "/VO/Theseus_0503" },
				},
			}
		},

		GodUpgradeWeaponSwap = 
		{
			AphroditeUpgrade = "TheseusSpearThrowAphrodite",
			AresUpgrade = "TheseusSpearThrowAres",
			ArtemisUpgrade = "TheseusSpearThrowArtemis",
			AthenaUpgrade = "TheseusSpearThrowAthena",
			DemeterUpgrade = "TheseusSpearThrowDemeter",
			DionysusUpgrade = "TheseusSpearThrowDionysus",
			PoseidonUpgrade = "TheseusSpearThrowPoseidon",
			ZeusUpgrade = "TheseusSpearThrowZeus",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusSpearThrow" },
				{ Name = "/SFX/Enemy Sounds/Theseus/EmoteAttacking" },
			},
		},
	},

	TheseusSpearThrowAphrodite =
	{
		InheritFrom = { "TheseusSpearThrow" },

		AIData =
		{
			DeepInheritance = true,
			WaitUntilProjectileDeath = "TheseusSpearThrowAphrodite",

			ChainedWeapon = "TheseusSpearThrowReturnAphrodite",
		},
	},

	TheseusSpearThrowAres =
	{
		InheritFrom = { "TheseusSpearThrow" },

		AIData =
		{
			DeepInheritance = true,
			WaitUntilProjectileDeath = "TheseusSpearThrowAres",

			ChainedWeapon = "TheseusSpearThrowReturnAres",
		},
	},

	TheseusSpearThrowArtemis =
	{
		InheritFrom = { "TheseusSpearThrow" },

		AIData =
		{
			DeepInheritance = true,
			WaitUntilProjectileDeath = "TheseusSpearThrowArtemis",

			ChainedWeapon = "TheseusSpearThrowReturnArtemis",
		},
	},

	TheseusSpearThrowAthena =
	{
		InheritFrom = { "TheseusSpearThrow" },

		AIData =
		{
			DeepInheritance = true,
			WaitUntilProjectileDeath = "TheseusSpearThrowAthena",

			ChainedWeapon = "TheseusSpearThrowReturnAthena",
		},
	},

	TheseusSpearThrowDemeter =
	{
		InheritFrom = { "TheseusSpearThrow" },

		AIData =
		{
			DeepInheritance = true,
			WaitUntilProjectileDeath = "TheseusSpearThrowDemeter",
			PostAttackDumbFireWeapons = { "TheseusSpearThrowDemeterNova" },

			ChainedWeapon = "TheseusSpearThrowReturnDemeter",
		},
	},

	TheseusSpearThrowDemeterNova =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			PreAttackDuration = 0.0,
			PostAttackDuration = 0.0,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,

			AITrackTargetDuringCharge = false,
		},

		Upgrades = { },
	},

	TheseusSpearThrowDionysus =
	{
		InheritFrom = { "TheseusSpearThrow" },

		AIData =
		{
			DeepInheritance = true,
			WaitUntilProjectileDeath = "TheseusSpearThrowDionysus",

			ChainedWeapon = "TheseusSpearThrowReturnDionysus",
		},
	},

	TheseusSpearThrowPoseidon =
	{
		InheritFrom = { "TheseusSpearThrow" },

		AIData =
		{
			DeepInheritance = true,
			WaitUntilProjectileDeath = "TheseusSpearThrowPoseidon",

			ChainedWeapon = "TheseusSpearThrowReturnPoseidon",
		},
	},

	TheseusSpearThrowZeus =
	{
		InheritFrom = { "TheseusSpearThrow" },

		AIData =
		{
			DeepInheritance = true,
			WaitUntilProjectileDeath = "TheseusSpearThrowZeus",
			PostAttackDumbFireWeapons = { "TheseusSpearThrowZeusBolt" },

			ChainedWeapon = "TheseusSpearThrowReturnZeus",
		},
	},

	TheseusSpearThrowZeusBolt =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData = {
			TargetName = "TheseusSpearReturnPoint",

			PreAttackDuration = 0.2,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusSpearThrowReturn =	
	{
		HitScreenshake = { Distance = 4, Speed = 1200, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.18, Fraction = 1.0, LerpTime = 0 },
		},

		ChainedOnly = true,
		GenusName = "TheseusSpearThrow",

		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.3,
			FireDuration = 0.2,
			PostAttackDuration = 0.5,

			PreAttackAnimation = "TheseusSpearThrow_CatchLoop",
			PostAttackAnimation = "TheseusSpearThrow_ReturnToIdle",
			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = false,

			SkipMovement = true,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,

			RetreatAfterAttack = true,
			RetreatTimeoutMin = 1.3,
			RetreatTimeoutMax = 1.8,
		},

		GodUpgradeWeaponSwap = 
		{
			AphroditeUpgrade = "TheseusSpearThrowReturnAphrodite",
			AresUpgrade = "TheseusSpearThrowReturnAres",
			ArtemisUpgrade = "TheseusSpearThrowReturnArtemis",
			AthenaUpgrade = "TheseusSpearThrowReturnAthena",
			DemeterUpgrade = "TheseusSpearThrowReturnDemeter",
			DionysusUpgrade = "TheseusSpearThrowReturnDionysus",
			PoseidonUpgrade = "TheseusSpearThrowReturnPoseidon",
			ZeusUpgrade = "TheseusSpearThrowReturnZeus",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusSpearReturn" },
				{ Name = "/SFX/Enemy Sounds/Theseus/EmoteEvading" },
			},
		},
	},

	TheseusSpearThrowReturnAphrodite =
	{
		InheritFrom = { "TheseusSpearThrowReturn" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusSpearThrowReturnAres =
	{
		InheritFrom = { "TheseusSpearThrowReturn" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusSpearThrowReturnArtemis =
	{
		InheritFrom = { "TheseusSpearThrowReturn" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusSpearThrowReturnAthena =
	{
		InheritFrom = { "TheseusSpearThrowReturn" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusSpearThrowReturnDemeter =
	{
		InheritFrom = { "TheseusSpearThrowReturn" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusSpearThrowReturnDionysus =
	{
		InheritFrom = { "TheseusSpearThrowReturn" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusSpearThrowReturnPoseidon =
	{
		InheritFrom = { "TheseusSpearThrowReturn" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusSpearThrowReturnZeus =
	{
		InheritFrom = { "TheseusSpearThrowReturn" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	TheseusChariotWait =
	{
		StartingWeapon = false,
		BlockInterrupt = true,

		OnFireCrowdReaction = { AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, Sound = "/SFX/TheseusCrowdChant", ReactionChance = 0.08, Requirements = { RequiredRoom = "C_Boss01" }, Shake = true, RadialBlur = true },

		AIData =
		{
			FireAnimation = "TheseusChariot_Taunt_Start",
			PostAttackAnimation = "TheseusChariot_TauntReturnToIdle",
			PreAttackDuration = 0.1,
			FireDuration = 4.0,
			PostAttackDuration = 1.5,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			SkipMovement = true,
			PreAttackFx = "TheseusPetalShower",
			TargetSelf = true,

			AIMoveWithinRangeTimeout = 2.0,

			MinAttacksBetweenUse = 6,
			ForceUseIfReady = true,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				ObjectType = "Theseus2",
				RequiresSourceAlive = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				RequiredFalseFlags = { "HeroesMuted" },
				Cooldowns =
				{
					{ Name = "TheseusTauntSpeech", Time = 35 },
				},

				-- Fiend! Who taught you such sloppy technique?!
				{ Cue = "/VO/Theseus_0240" },
				-- Fiend! You are unfit to walk these hallowed passageways!
				{ Cue = "/VO/Theseus_0241" },
				-- Monster! Your battle prowess leaves much to be desired!
				{ Cue = "/VO/Theseus_0242" },
				-- Monster! You have no bearing, and no grace or courage!
				{ Cue = "/VO/Theseus_0243" },
				-- Hoh, blackguard! How your spirit must be quivering inside!
				{ Cue = "/VO/Theseus_0244" },
				-- Well, hellspawn! Not ready to admit defeat, as yet?
				{ Cue = "/VO/Theseus_0245" },
				-- You have a lot of nerve, hellspawn! But little else!
				{ Cue = "/VO/Theseus_0246" },
				-- Come, monster! Attack with everything you have!
				{ Cue = "/VO/Theseus_0247" },
				-- I do not fear you, fiend! Your presence is a stain upon Elysium!
				{ Cue = "/VO/Theseus_0248" },
				-- Well, fiend! Are you yet fearful for the inevitable end to your foul quest?
				{ Cue = "/VO/Theseus_0249" },
				-- So, monster! You think you have the wherewithal to achieve victory?!
				{ Cue = "/VO/Theseus_0250" },
				-- You, blackguard! By my honor and the gods, you shall soon be destroyed!
				{ Cue = "/VO/Theseus_0251" },
				-- Now it is abundantly apparent that you are beneath me, fiend!
				{ Cue = "/VO/Theseus_0252" },
				-- Have you anything to say for yourself, daemon? Before I slay you once again?
				{ Cue = "/VO/Theseus_0253", ConsecutiveDeathsInRoom = { Name = "C_Boss01", Count = 1, }, },
				-- Would that you, too, had a chariot, so I could conquer you in racing just as in battle!
				{ Cue = "/VO/Theseus_0254" },
				-- What now, filth? Are you prepared to be sent screaming back to the hellish darkness?!
				{ Cue = "/VO/Theseus_0255" },
				-- Back, foul daemon, or be vanquished even faster than you've come to expect!
				{ Cue = "/VO/Theseus_0256" },
				-- You shall be imminently overrun, I can assure you, blackguard!
				{ Cue = "/VO/Theseus_0257" },
				-- Cower uncontrollably, you monster, for there's naught else you can do against my might!
				{ Cue = "/VO/Theseus_0258" },
				-- I warn you, filth, you'll gain no quarter from me, or my good companion over there!
				{ Cue = "/VO/Theseus_0259", RequiredAnyUnitAlive = { "Minotaur", "Minotaur2" } },
				-- Undeserving fiend, all which you think you have achieved was merely handed you!
				{ Cue = "/VO/Theseus_0260" },
				-- What is the matter, fiend? Is your weak sense of resolve already shaken?!
				{ Cue = "/VO/Theseus_0261" },
				-- Stand your ground, hellspawn, and I shall run you down, or run you through!
				{ Cue = "/VO/Theseus_0262" },
				-- Foul daemon! We shall thwart your each and every trespass in Elysium!
				{ Cue = "/VO/Theseus_0263" },
				-- Attack me if you dare, blackguard! Either way, I shall crush you!
				{ Cue = "/VO/Theseus_0264" },
				-- Hold, you unwelcome pustule! I shall run you through!
				{ Cue = "/VO/Theseus_0265" },
			},
		},

		Upgrades = { },
	},

	TheseusChariotExteriorPatrol =
	{

		HitScreenshake = { Distance = 4, Speed = 1200, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.18, Fraction = 1.0, LerpTime = 0 },
		},
		BlockInterrupt = true,

		AIData =
		{
			PathWeapon = true,

			PreAttackDuration = 0.4,
			FireDuration = 0.2,
			PostAttackDuration = 0.0,

			AITrackTargetDuringCharge = false,
			SkipStopBeforePreAttackEnd = true,
			SkipStopBeforeAttack = true,
			AIAngleTowardsPlayerWhileFiring = false,
			SkipMovement = true,
			SkipAngleTowardTarget = true,

			AIMoveWithinRangeTimeout = 2.0,

			CreateOwnTarget = true,
			TargetOffsetDistance = 0,

			MovementEffectName = "ChariotBoosters",

			PatrolPaths =
			{
				{
					[1] = 543047,
					[2] = 543043,
					[3] = 543044,
					[4] = 543049,
					[5] = 543046,
					[6] = 543037,
					[7] = 543038,
					[8] = 543048,
					[9] = 543042,
					[10] = 543047,
				},
				{
					[1] = 543037,
					[2] = 543046,
					[3] = 543049,
					[4] = 543044,
					[5] = 543043,
					[6] = 543047,
					[7] = 543042,
					[8] = 543048,
					[9] = 543051,
					[10] = 543038,
				},
			},
			PatrolNearestStartId = true,
			FireAfterPatrolIndex = 1,

			MaxConsecutiveUses = 3,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Theseus/TheseusMortarLaunch" },
			},
		},
	},

	TheseusZeusUpgradeWrath =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
		BlockInterrupt = true,

		AIData =
		{
			FireTicks = 30,
			FireCooldown = 0.15,
			ResetTargetPerTick = true,
			AIAngleTowardsPlayerWhileFiring = true,
			PreAttackAnimation ="Theseus_WrathStart",
			FireAnimation = "Theseus_WrathAirLoop",
			PostAttackAnimation = "Theseus_WrathReturnToIdle",
			PostAttackDuration = 0.6,

			WrathVoiceLines =
			{
				Queue = "Interrupt",
				{
					RandomRemaining = true,
					PreLineWait = 0.1,
					CooldownTime = 40,
					CooldownName = "TheseusWrathLinesPlayedRecently",
					SuccessiveChanceToPlay = 0.5,

					-- Lord Zeus, I call upon your might!
					{ Cue = "/VO/Theseus_0096" },
					-- Lord Zeus, I need your strength!
					{ Cue = "/VO/Theseus_0097" },
				},
				[2] = GlobalVoiceLines.TheseusWrathActivationVoiceLines,
				[3] = HeroVoiceLines.TheseusWrathReactionVoiceLines_M,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},


	},

	TheseusZeusUpgradePassive =
	{

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		FireTicks = 7,
		FireCooldown = 0.15,
		FireInterval = 5.0,

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusPoseidonUpgradeWrath =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
		BlockInterrupt = true,

		AIData =
		{
			FireTicks = 30,
			FireCooldown = 0.15,
			ResetTargetPerTick = true,
			AIAngleTowardsPlayerWhileFiring = true,
			PreAttackAnimation ="Theseus_WrathStart",
			FireAnimation = "Theseus_WrathAirLoop",
			PostAttackAnimation = "Theseus_WrathReturnToIdle",
			PostAttackDuration = 0.6,

			WrathVoiceLines =
			{
				Queue = "Interrupt",
				{
					RandomRemaining = true,
					PreLineWait = 0.1,
					CooldownTime = 40,
					CooldownName = "TheseusWrathLinesPlayedRecently",
					SuccessiveChanceToPlay = 0.5,

					-- Lord Poseidon, I invoke your might!
					{ Cue = "/VO/Theseus_0098" },
					-- Lord Poseidon, aid me, now!
					{ Cue = "/VO/Theseus_0099" },
				},
				[2] = GlobalVoiceLines.TheseusWrathActivationVoiceLines,
				[3] = HeroVoiceLines.TheseusWrathReactionVoiceLines_M,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusPoseidonUpgradePassive =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData = {
			FireTicks = 1,
			FireInterval = 5.0,

			AttackSlotsPerTick = 8,
			AttackSlotInterval = 0.1,
			AttackSlots =
			{
				{ Angle = 0, OffsetDistance = 0, OffsetScaleY = 0 },

				{ Angle = 45, OffsetDistance = 800, OffsetScaleY = 0.48 },
				{ Angle = 90, OffsetDistance = 1200, OffsetScaleY = 0.48 },
				{ Angle = 135, OffsetDistance = 800, OffsetScaleY = 0.48 },
				{ Angle = 180, OffsetDistance = 1200, OffsetScaleY = 0.48 },
				{ Angle = 225, OffsetDistance = 800, OffsetScaleY = 0.48 },
				{ Angle = 270, OffsetDistance = 1200, OffsetScaleY = 0.48 },
				{ Angle = 315, OffsetDistance = 800, OffsetScaleY = 0.48 },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusAphroditeUpgradeWrath =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
		BlockInterrupt = true,

		AIData =
		{
			FireTicks = 30,
			FireCooldown = 0.15,
			ResetTargetPerTick = true,
			AIAngleTowardsPlayerWhileFiring = true,
			PreAttackAnimation ="Theseus_WrathStart",
			FireAnimation = "Theseus_WrathAirLoop",
			PostAttackAnimation = "Theseus_WrathReturnToIdle",
			PostAttackDuration = 0.6,

			WrathVoiceLines =
			{
				Queue = "Interrupt",
				{
					RandomRemaining = true,
					PreLineWait = 0.1,
					CooldownTime = 40,
					CooldownName = "TheseusWrathLinesPlayedRecently",
					SuccessiveChanceToPlay = 0.5,

					-- Lady Aphrodite, guide my hand!
					{ Cue = "/VO/Theseus_0108" },
					-- Lady Aphrodite, I invoke your aid!
					{ Cue = "/VO/Theseus_0109" },
				},
				[2] = GlobalVoiceLines.TheseusWrathActivationVoiceLines,
				[3] = HeroVoiceLines.TheseusWrathReactionVoiceLines_F,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusAphroditeUpgradePassive =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData = {
			FireTicks = 1,
			FireInterval = 6.5,

			AttackSlotsPerTick = 24,
			AttackSlotInterval = 0.01,
			AttackSlots =
			{
				-- inner circle
				{ Angle = 0, OffsetDistance = 750, OffsetScaleY = 0.48 },
				{ Angle = 45, OffsetDistance = 750, OffsetScaleY = 0.48 },
				{ Angle = 90, OffsetDistance = 750, OffsetScaleY = 0.48 },
				{ Angle = 135, OffsetDistance = 750, OffsetScaleY = 0.48 },
				{ Angle = 180, OffsetDistance = 750, OffsetScaleY = 0.48 },
				{ Angle = 225, OffsetDistance = 750, OffsetScaleY = 0.48 },
				{ Angle = 270, OffsetDistance = 750, OffsetScaleY = 0.48 },
				{ Angle = 315, OffsetDistance = 750, OffsetScaleY = 0.48 },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusAthenaUpgradeWrath =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
		BlockInterrupt = true,

		AIData =
		{
			FireTicks = 30,
			FireCooldown = 0.15,
			ResetTargetPerTick = true,
			AIAngleTowardsPlayerWhileFiring = true,
			PreAttackAnimation ="Theseus_WrathStart",
			FireAnimation = "Theseus_WrathAirLoop",
			PostAttackAnimation = "Theseus_WrathReturnToIdle",
			PostAttackDuration = 0.6,

			WrathVoiceLines =
			{
				Queue = "Interrupt",
				{
					RandomRemaining = true,
					PreLineWait = 0.1,
					CooldownTime = 40,
					CooldownName = "TheseusWrathLinesPlayedRecently",
					SuccessiveChanceToPlay = 0.5,

					-- Goddess Athena, lend to me your strength!
					{ Cue = "/VO/Theseus_0100" },
					-- Goddess Athena, I need your aid, now!
					{ Cue = "/VO/Theseus_0101" },
				},
				[2] = GlobalVoiceLines.TheseusWrathActivationVoiceLines,
				[3] = HeroVoiceLines.TheseusWrathReactionVoiceLines_F,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusAthenaUpgradePassive =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData = {
			FireTicks = 1,
			FireInterval = 6.5,

			AttackSlotsPerTick = 18,
			AttackSlotInterval = 0.06,
			AttackSlots =
			{
				-- WrathTargetSetB
				{ UseMapObjectId = 525345 },
				{ UseMapObjectId = 525347 },
				{ UseMapObjectId = 525348 },
				{ UseMapObjectId = 525349 },
				{ UseMapObjectId = 525350 },
				{ UseMapObjectId = 525351 },
				{ UseMapObjectId = 525352 },
				{ UseMapObjectId = 525353 },
				{ UseMapObjectId = 525354 },
				{ UseMapObjectId = 525355 },
				{ UseMapObjectId = 525356 },
				{ UseMapObjectId = 525357 },
				{ UseMapObjectId = 525358 },
				{ UseMapObjectId = 525359 },
				{ UseMapObjectId = 525360 },
				{ UseMapObjectId = 525361 },
				{ UseMapObjectId = 525362 },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusArtemisUpgradeWrath =
	{

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
		BlockInterrupt = true,

		AIData =
		{
			FireTicks = 30,
			FireCooldown = 0.15,
			ResetTargetPerTick = true,
			AIAngleTowardsPlayerWhileFiring = true,
			PreAttackAnimation ="Theseus_WrathStart",
			FireAnimation = "Theseus_WrathAirLoop",
			PostAttackAnimation = "Theseus_WrathReturnToIdle",
			PostAttackDuration = 0.6,

			WrathVoiceLines =
			{
				Queue = "Interrupt",
				{
					RandomRemaining = true,
					PreLineWait = 0.1,
					CooldownTime = 40,
					CooldownName = "TheseusWrathLinesPlayedRecently",
					SuccessiveChanceToPlay = 0.5,

					-- Lady Artemis, make my strength be true!
					{ Cue = "/VO/Theseus_0102" },
					-- Lady Artemis, I beg you guide my spear!!
					{ Cue = "/VO/Theseus_0103" },
				},
				[2] = GlobalVoiceLines.TheseusWrathActivationVoiceLines,
				[3] = HeroVoiceLines.TheseusWrathReactionVoiceLines_F,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusArtemisUpgradePassive =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData = {
			FireTicks = 1,
			FireInterval = 5.0,

			AttackSlotsPerTick = 42,
			AttackSlotInterval = 0.01,
			AttackSlots =
			{
				-- WrathTargetSetA
				{ UseMapObjectId = 525343 },
				{ UseMapObjectId = 525344 },
				{ UseMapObjectId = 525363 },
				{ UseMapObjectId = 525364 },
				{ UseMapObjectId = 525365 },
				{ UseMapObjectId = 525366 },

				{ UseMapObjectId = 525367 },
				{ UseMapObjectId = 525368 },
				{ UseMapObjectId = 525369 },
				{ UseMapObjectId = 525370 },
				{ UseMapObjectId = 525371 },
				{ UseMapObjectId = 525372 },

				{ UseMapObjectId = 525373 },
				{ UseMapObjectId = 525374 },
				{ UseMapObjectId = 525375 },
				{ UseMapObjectId = 525376 },
				{ UseMapObjectId = 525377 },
				{ UseMapObjectId = 525378 },

				{ UseMapObjectId = 525379 },
				{ UseMapObjectId = 525380 },
				{ UseMapObjectId = 525381 },
				{ UseMapObjectId = 525382 },
				{ UseMapObjectId = 525383 },
				{ UseMapObjectId = 525384 },

				{ UseMapObjectId = 525385 },
				{ UseMapObjectId = 525386 },
				{ UseMapObjectId = 525387 },
				{ UseMapObjectId = 525388 },
				{ UseMapObjectId = 525389 },
				{ UseMapObjectId = 525390 },

				{ UseMapObjectId = 525391 },
				{ UseMapObjectId = 525392 },
				{ UseMapObjectId = 525393 },
				{ UseMapObjectId = 525394 },
				{ UseMapObjectId = 525395 },
				{ UseMapObjectId = 525396 },

				{ UseMapObjectId = 525397 },
				{ UseMapObjectId = 525398 },
				{ UseMapObjectId = 525402 },
				{ UseMapObjectId = 525403 },
				{ UseMapObjectId = 525399 },
				{ UseMapObjectId = 525400 },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},


	TheseusAresUpgradeWrath =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
		BlockInterrupt = true,

		AIData =
		{
			FireTicks = 30,
			FireCooldown = 0.15,
			ResetTargetPerTick = true,
			AIAngleTowardsPlayerWhileFiring = true,
			PreAttackAnimation ="Theseus_WrathStart",
			FireAnimation = "Theseus_WrathAirLoop",
			PostAttackAnimation = "Theseus_WrathReturnToIdle",
			PostAttackDuration = 0.6,

			WrathVoiceLines =
			{
				Queue = "Interrupt",
				{
					RandomRemaining = true,
					PreLineWait = 0.1,
					CooldownTime = 40,
					CooldownName = "TheseusWrathLinesPlayedRecently",
					SuccessiveChanceToPlay = 0.5,

					-- Lord Ares, give me your power!
					{ Cue = "/VO/Theseus_0104" },
					-- Lord Ares, lend me your might!
					{ Cue = "/VO/Theseus_0105" },
				},
				[2] = GlobalVoiceLines.TheseusWrathActivationVoiceLines,
				[3] = HeroVoiceLines.TheseusWrathReactionVoiceLines_M,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusAresUpgradePassive =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData = {
			FireTicks = 3,
			FireCooldown = 1.5,
			FireInterval = 9.0,

			AttackSlotInterval = 0.01,
			AttackSlotsPerTickMin = 5,
			AttackSlotsPerTickMax = 6,
			AttackSlots =
			{
				-- WrathTargetSetA
				{ UseMapObjectId = 525346 },
				{ UseMapObjectId = 525411 },
				{ UseMapObjectId = 525410 },
				{ UseMapObjectId = 525408 },
				{ UseMapObjectId = 525409 },
				{ UseMapObjectId = 525406 },
				{ UseMapObjectId = 543853 },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusDionysusUpgradeWrath =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
		BlockInterrupt = true,

		AIData =
		{
			FireTicks = 50,
			FireCooldown = 0.175,
			ResetTargetPerTick = true,
			AIAngleTowardsPlayerWhileFiring = true,
			PreAttackAnimation ="Theseus_WrathStart",
			FireAnimation = "Theseus_WrathAirLoop",
			PostAttackAnimation = "Theseus_WrathReturnToIdle",
			PostAttackDuration = 0.6,

			WrathVoiceLines =
			{
				Queue = "Interrupt",
				{
					RandomRemaining = true,
					PreLineWait = 0.1,
					CooldownTime = 40,
					CooldownName = "TheseusWrathLinesPlayedRecently",
					SuccessiveChanceToPlay = 0.5,

					-- Lord Dionysus, lend me your power!
					{ Cue = "/VO/Theseus_0106" },
					-- Lord Dionysus, give me strength!
					{ Cue = "/VO/Theseus_0107" },
				},
				[2] = GlobalVoiceLines.TheseusWrathActivationVoiceLines,
				[3] = HeroVoiceLines.TheseusWrathReactionVoiceLines_M,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusDionysusUpgradePassive =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData = {
			FireTicks = 40,
			FireCooldown = 0.175,
			FireInterval = 6.75,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},
	},

	TheseusDemeterUpgradeWrath =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
		BlockInterrupt = true,

		AIData =
		{
			FireTicks = 1,
			AIAngleTowardsPlayerWhileFiring = true,
			PreAttackAnimation ="Theseus_WrathStart",
			FireAnimation = "Theseus_WrathAirLoop",
			PostAttackAnimation = "Theseus_WrathReturnToIdle",
			PostAttackDuration = 0.6,

			AttackSlotsPerTick = 16,
			AttackSlotInterval = 0.33,
			AttackSlots =
			{
				{ Angle = 0, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 45, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 90, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 135, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 180, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 225, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 270, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 315, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 0, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 45, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 90, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 135, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 180, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 225, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 270, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
				{ Angle = 315, OffsetDistance = 350, OffsetScaleY = 0.48, UseTargetPosition = true },
			},

			WrathVoiceLines =
			{
				Queue = "Interrupt",
				{
					RandomRemaining = true,
					PreLineWait = 0.1,
					CooldownTime = 40,
					CooldownName = "TheseusWrathLinesPlayedRecently",
					SuccessiveChanceToPlay = 0.5,

					-- O Goddess Demeter, I must have your support!
					{ Cue = "/VO/Theseus_0442" },
					-- Goddess Demeter, I beg of you, assist me!
					{ Cue = "/VO/Theseus_0443" },
				},
				[2] = GlobalVoiceLines.TheseusWrathActivationVoiceLines,
				[3] = HeroVoiceLines.TheseusWrathReactionVoiceLines_F,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/DemeterColdNova" },
			},
		},
	},

	TheseusDemeterUpgradePassive =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData = {
			FireTicks = 1,
			FireInterval = 10.75,

			AttackSlotInterval = 0.01,
			AttackSlotsPerTick = 24,
			AttackSlots =
			{
				-- WrathTargetSetA
				{ UseMapObjectId = 525346, PauseDuration = 1.3 },

				{ UseMapObjectId = 525360 },
				{ UseMapObjectId = 525358 },
				{ UseMapObjectId = 525359 },
				{ UseMapObjectId = 525361 },
				{ UseMapObjectId = 525362, PauseDuration = 1.3 },

				{ UseMapObjectId = 525345 },
				{ UseMapObjectId = 525347 },
				{ UseMapObjectId = 525348 },
				{ UseMapObjectId = 525349 },
				{ UseMapObjectId = 525350 },
				{ UseMapObjectId = 525351 },
				{ UseMapObjectId = 525352 },
				{ UseMapObjectId = 525353 },
				{ UseMapObjectId = 525354 },
				{ UseMapObjectId = 525355 },
				{ UseMapObjectId = 525356 },
				{ UseMapObjectId = 525357, PauseDuration = 1.3 },

				{ UseMapObjectId = 525360 },
				{ UseMapObjectId = 525358 },
				{ UseMapObjectId = 525359 },
				{ UseMapObjectId = 525361 },
				{ UseMapObjectId = 525362, PauseDuration = 1.3 },

				{ UseMapObjectId = 525346 },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/DemeterColdNova" },
			},
		},
	},

	-- HADES
	HadesInvisibility =
	{
		StartingWeapon = false,
		BlockInterrupt = true,

		AIData =
		{
			BlockWeapons = { "HadesSpawns" },

			FireFunctionName = "EnemyInvisibility",
			FireFunctionArgs = { CreateAnimation = "HadesDisappear" },
			TeleportationPointsGroupName = "HadesTeleportationPoints",
			PreAttackAnimation = "HadesBattleInvisibility",
			PreAttackSound = "/SFX/Enemy Sounds/Hades/HadesSmokeDisappear",
			PostAttackAnimation = "Hades_Idle",
			PreAttackDuration = 0.4,
			SkipFireWeapon = true,
			SkipAngleTowardTarget = true,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,

			MinAttacksBetweenUse = 4,
			BlockAsFirstWeapon = false,

			PreAttackVoiceLines =
			{
				{
					BreakIfPlayed = true,
					PreLineWait = 0.15,
					PlayOnce = true,

					-- I suppose that you must hate the very sight of me. You'll understand, then, why I wear the Helm of Darkness.
					{ Cue = "/VO/HadesField_0009" },
				},
				{
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						PreLineWait = 0.15,
						SuccessiveChanceToPlay = 0.05,
						Cooldowns =
						{
							{ Name = "HadesAnyQuipSpeech" },
							{ Name = "HadesGoneInvisSpeech", Time = 120 },
						},

						-- You are blind even to simple truths.
						{ Cue = "/VO/HadesField_0039", RequiredPlayed = { "/VO/HadesField_0009" }, RequiredFalseTextLines = { "Ending01" }, },
						-- Your eyes deceive you, boy.
						{ Cue = "/VO/HadesField_0040", RequiredPlayed = { "/VO/HadesField_0009" } },
						-- Excuse me for a moment.
						{ Cue = "/VO/HadesField_0041", RequiredPlayed = { "/VO/HadesField_0009" } },
						-- I shall be right back.
						{ Cue = "/VO/HadesField_0042", RequiredPlayed = { "/VO/HadesField_0009" } },
					},
					-- invisibility reaction
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						PreLineWait = 1.0,
						SuccessiveChanceToPlay = 0.15,
						UsePlayerSource = true,
						RequiredMaxTimesSeenRoom = { D_Boss01 = 50 },
						Cooldowns =
						{
							{ Name = "ZagreusAnyQuipSpeech" },
							{ Name = "ZagInvisReactionSpeech", Time = 300 }
						},

						-- Where'd he go.
						{ Cue = "/VO/ZagreusField_2330", RequiredPlayed = { "/VO/ZagreusField_2331" } },
						-- Where'd he go!
						{ Cue = "/VO/ZagreusField_2331" },
						-- This again.
						{ Cue = "/VO/ZagreusField_2332", RequiredPlayed = { "/VO/ZagreusField_2331" } },
						-- Face me, damn it!
						{ Cue = "/VO/ZagreusField_2333", RequiredPlayed = { "/VO/ZagreusField_2331" } },
						-- Show yourself!
						{ Cue = "/VO/ZagreusField_2334", RequiredPlayed = { "/VO/ZagreusField_2331" } },
						-- Show yourself, Father!
						{ Cue = "/VO/ZagreusField_2335", RequiredPlayed = { "/VO/ZagreusField_2331" } },
						-- Where are you...
						{ Cue = "/VO/ZagreusField_2336", RequiredPlayed = { "/VO/ZagreusField_2331" } },
						-- I know where you are...
						{ Cue = "/VO/ZagreusField_2337", RequiredPlayed = { "/VO/ZagreusField_2331" } },
						-- Quit it with this, Father.
						{ Cue = "/VO/ZagreusField_2338", RequiredPlayed = { "/VO/ZagreusField_2331" } },
						-- <Scoff>
						{ Cue = "/VO/ZagreusField_2339", RequiredPlayed = { "/VO/ZagreusField_2331" } },
					},
				},
			},
		},

		Upgrades = { },
	},

	HadesConsumeHeal =
	{
		StartingWeapon = false,
		BlockInterrupt = true,

		AIData =
		{
			BlockWeapons = { "HadesSpawns" },

			PreAttackFunctionName = "HadesConsumeHeal",
			HealTicksPerConsume = 1,
			HealPerTick = 1500,
			HealTickInterval = 2.0,
			NextUrnWait = 0.25,
			MaxConsumptions = 3,

			ConsumeFx = "HadesUrnConsumeFx",

			StopAnimationsOnEnd =
			{
				"HadesUrnConsumeFx_Self",
				"HadesUrnConsumeParticles_Self",
				"HadesUrnConsumeFxDark_Self",
				"HadesUrnConsumeFxDark2_Self",
				"HadesUrnConsumeGlow_Self",
				"HadesHeal",
			},

			PreAttackSound = "/SFX/Enemy Sounds/HeavyRangedSplitterMiniboss/CrystalBeamPreAttackBIG",
			PreAttackAnimation = "HadesBattleHeal_Start",
			PostAttackAnimation = "HadesBattleHeal_ReturnToIdle",
			PreAttackDuration = 0.4,
			PostAttackDuration = 1.1,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			CreateOwnTarget = true,
			TargetAngleOptions = { 270 },
			TargetOffsetDistance = 100,

			MaxUses = 1,
			MinAttacksBetweenUse = 15,
			RequireExistingIdsOfType = "HadesTombstone",
			BlockAsFirstWeapon = true,
			ForceUseIfReady = true,

			ChainedWeapon = "HadesSideDash",

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.66,
				RequiredFalseBossPhase = 3,
				Cooldowns =
				{
					{ Name = "HadesAnyQuipSpeech" },
					{ Name = "HadesConsumeHealSpeech", Time = 120 },
				},

				-- Dead souls, restore my strength!
				{ Cue = "/VO/HadesField_0636" },
				-- Through death, I regain life!
				{ Cue = "/VO/HadesField_0637" },
				-- Souls of the dead, to me!
				{ Cue = "/VO/HadesField_0638" },
				-- These mortal souls are mine!
				{ Cue = "/VO/HadesField_0639" },
				-- You cannot break me, boy!
				{ Cue = "/VO/HadesField_0640" },
				-- All you damned souls, come on!
				{ Cue = "/VO/HadesField_0641" },
				-- All you dead souls are mine!
				{ Cue = "/VO/HadesField_0642" },
				-- I shall be whole again!
				{ Cue = "/VO/HadesField_0643" },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/EmoteCharging" },
				{ Name = "/SFX/Enemy Sounds/HeavyRangedSplitterMiniboss/CrystalBeamFireStartBIG" },
			},
		},

	},

	HadesCerberusAssist =
	{
		StartingWeapon = false,
		BlockInterrupt = true,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			PreAttackFunctionName = "HandleHadesAssistPresentation",
			AssistPresentationPortrait = "Portrait_Cerberus_Default_01",

			PreMoveDuration = 0.01,
			PreMoveFunctionName = "EnemyInvisibility",
			PreMoveFunctionArgs = { CreateAnimation = "HadesDisappear" },
			TeleportationPointsGroupName = "HadesCerberusAssistPoints",

			PreAttackEndFunctionName = "EmptyAI",
			PostTeleportWaitDurationMin = 0.0,
			PostTeleportWaitDurationMax = 0.0,

			PreAttackDuration = 0.2,
			FireDuration = 0.5,
			PostAttackDuration = 0.0,
			FireAnimation = "HadesBattleKnockDown",
			PostAttackAnimation = "HadesBattleKnockDownRecover",
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			SkipMovement = true,
			InstantAngleTowardsTarget = true,

			ChainedWeapon = "HadesCerberusAssistMovement",
			DumbFireWeapons = { "HadesCerberusAssistRockFall" },

			TargetId = 510859,

			MinAttacksBetweenUse = 9999,
			ForceUnderHealthPercent = 0.25,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charon/EmotePowerAttacking" },
				{ Name = "/SFX/Enemy Sounds/Charon/CharonRadialBlast" },
			},
		},
		--FireScreenshake = { Distance = 15, Speed = 300, Duration = 3.0, FalloffSpeed = 3000 },
		--HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	HadesCerberusAssistRockFall =
	{
		StartingWeapon = false,

		--HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			PreAttackDuration = 0.0,
			PostAttackDuration = 0.5,

			PreAttackEndFunctionName = "EmptyAI",
			PostTeleportWaitDurationMin = 0.0,
			PostTeleportWaitDurationMax = 0.0,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			SkipMovement = true,
			SkipAngleTowardTarget = true,

			PostAttackTeleportToSpawnPoints = true,
			TeleportationInterval = 0,

			AITrackTargetDuringCharge = false,

			AIFireTicksMin = 60,
			AIFireTicksMax = 60,
			FireCooldown = 0.03,
			CreateOwnTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 450,
			TargetOffsetDistanceMax = 1450,
			OffsetDistanceScaleY = 0.5,
			ResetTargetPerTick = true,
		},
		--[[
		FireScreenshake = { Distance = 15, Speed = 800, Duration = 1.5, FalloffSpeed = 3000 },
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.05, RightFraction = 0.25, Duration = 1.5 },
		},
		]]

		Upgrades = { },
	},

	HadesCerberusAssistMovement =
	{
		StartingWeapon = false,

		--HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		
		AIData =
		{
			PreAttackDuration = 0.0,
			PostAttackDuration = 0.5,

			PreAttackEndFunctionName = "EmptyAI",
			PostTeleportWaitDurationMin = 0.0,
			PostTeleportWaitDurationMax = 0.0,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			SkipMovement = true,
			SkipAngleTowardTarget = true,

			PostAttackTeleportToSpawnPoints = true,
			TeleportationInterval = 0,

			AITrackTargetDuringCharge = false,

			AttackSlotsPerTick = 8,
			AttackSlotInterval = 0.1,
			TargetId = 510859,
			AttackSlots =
			{
				{ TeleportToId = 553257 },
				{ TeleportToId = 553258 },
				{ TeleportToId = 553259 },
				{ TeleportToId = 553260 },
				{ TeleportToId = 553264 },
				{ TeleportToId = 553263 },
				{ TeleportToId = 553262 },
				{ TeleportToId = 553261 },
			},
		},

		Upgrades = { },
	},

	HadesRadialPush =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 3,
			FireCooldown = 1.0,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			SkipMovement = true,
			SkipAngleTowardTarget = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charon/EmotePowerAttacking" },
				{ Name = "/SFX/Enemy Sounds/Charon/CharonRadialBlast" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	HadesBidentStrike =
	{
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			DeepInheritance = true,

			PreAttackAnimation = "HadesBattleBidentFlurry_Start",
			FireAnimation = "HadesBattleBidentFlurry_Fire",
			PostAttackAnimation = "HadesBattleBidentFlurry_ReturnToIdle",
			PreAttackSound = "/SFX/Enemy Sounds/Hades/EmoteCharging",

			RemoveFromGroups = { "GroundEnemies" },

			PreAttackDuration = 0.35,
			PreAttackEndMinWaitTime = 0.275,
			FireDuration = 0.2,
			PostAttackDuration = 0.8,
			AIAttackDistance = 350,
			AIBufferDistance = 300,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 100,
			AIMoveWithinRangeTimeout = 4.0,
			AITrackTargetDuringCharge = true,

			MaxConsecutiveUses = 3,

			AITrackTargetDuringCharge = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/EmotePowerAttacking" },
				{ Name = "/SFX/Enemy Sounds/Hades/HadesSpearStab" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	HadesBidentFlurry =
	{
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			PreAttackAnimation = "HadesBattleBidentFlurry_Start",
			FireAnimation = "HadesBattleBidentFlurry_Fire",
			PostAttackAnimation = "HadesBattleBidentFlurry_ReturnToIdle",
			PreAttackSound = "/SFX/Enemy Sounds/Hades/EmoteCharging",

			RemoveFromGroups = { "GroundEnemies" },

			PreAttackDuration = 0.35,
			PreAttackEndMinWaitTime = 0.25,
			FireDuration = 0.7,
			PostAttackDuration = 2.0,
			AIAttackDistance = 350,
			AIBufferDistance = 300,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 100,
			AIMoveWithinRangeTimeout = 10.0,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,

			MinAttacksBetweenUse = 4,

			FireTicks = 3,
			AIFireTicksCooldown = 0.3,

			AITrackTargetDuringCharge = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/EmotePowerAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	HadesBidentRangedChain =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"HadesCast",
			"HadesCast",
			"HadesCast",
			"HadesBidentThrow",
		},
		AIData =
		{
			MinAttacksBetweenUse = 3,
		}
	},

	HadesBidentStrikeCombo1 =
	{
		InheritFrom = {"HadesCast"},
		GenusName = "HadesBidentStrikeCombo1",

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "HadesBidentStrikeCombo2",

			PreAttackEndShake = false,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			SkipMovement = true,

			CreateOwnTarget = true,
			TargetAngleOptions = { 90 },
			TargetOffsetDistance = 200,

			MinAttacksBetweenUse = 4,
		},
	},

	HadesBidentStrikeCombo2 =
	{
		InheritFrom = {"HadesCast"},
		GenusName = "HadesBidentStrikeCombo1",
		ChainedOnly = true,

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "HadesBidentStrikeCombo3",

			PreAttackAnimation = "HadesBattleAttackRange_Start",
			FireAnimation = "HadesBattleAttackRange_Fire",
			PostAttackAnimation = "HadesBattleAttackRange_ReturnToIdle",

			PreAttackEndShake = false,
			PreAttackDuration = 0.0,
			FireDuration = 0.1,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			SkipMovement = true,

			CreateOwnTarget = true,
			TargetAngleOptions = { -90 },
			TargetOffsetDistance = 200,
		},
	},

	HadesBidentStrikeCombo3 =
	{
		GenusName = "HadesBidentStrikeCombo1",
		StartingWeapon = false,
		ChainedOnly = true,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			PreAttackAnimation = "HadesBattleBidentFlurry_Start",
			FireAnimation = "HadesBattleBidentFlurry_Fire",
			PostAttackAnimation = "HadesBattleBidentFlurry_ReturnToIdle",

			RemoveFromGroups = { "GroundEnemies" },

			PreAttackEndShake = false,
			PreAttackDuration = 0.1,
			PreAttackEndMinWaitTime = 0.1,
			FireDuration = 0.2,
			PostAttackDuration = 1.1,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			SkipMovement = true,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 100,
			AIMoveWithinRangeTimeout = 10.0,

			AITrackTargetDuringCharge = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/EmotePowerAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearThrow" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},
	ShieldBarrier =
	{
		OnFiredFunctionName = "StartShieldBarrierPresentation",

	},

	ConsecrationField =
	{
		StartingWeapon = false,
		OnFiredFunctionName = "DisableTraps",
		OnFiredFunctionArgs = { Range = 450, Duration = 8 },
	},

	HadesGraspingHands =
	{
		OnHitFunctionNames = { "HitByGraveHandsPresentation" },

	},
	HadesMobilityCombo1 =
	{
		InheritFrom = { "HadesSideDash" },
		GenusName = "HadesMobilityCombo1",

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "HadesMobilityCombo2",
		},
	},

	HadesMobilityCombo2 =
	{
		InheritFrom = { "HadesSideDash" },
		GenusName = "HadesMobilityCombo1",

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "HadesMobilityCombo3",
		},
	},

	HadesMobilityCombo3 =
	{
		InheritFrom = { "HadesDash" },
		GenusName = "HadesMobilityCombo1",

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "HadesMobilityCombo4",
		},
	},

	HadesMobilityCombo4 =
	{
		InheritFrom = { "HadesBidentSpin" },
		GenusName = "HadesMobilityCombo1",
	},

	HadesBidentSpin =
	{
		GenusName = "HadesBidentSpin",
		HitScreenshake = { Distance = 10, Speed = 1000, Duration = 0.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 0.30, LerpTime = 0.1 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			DeepInheritance = true,

			PreAttackAnimation = "HadesBattleAttackSpin_Start",
			PreAttackFx = "HadesSpinPreview",
			FireAnimation = "HadesBattleAttackSpin_Fire",
			PostAttackAnimation = "HadesBattleAttackSpin_ReturnToIdle",
			PreAttackDuration = 0.6,
			FireDuration = 0.3,
			PostAttackDuration = 0.6,
			PostAttackCooldownMin = 1.5,
			PostAttackCooldownMax = 2.0,
			PreAttackSound = "/SFX/Enemy Sounds/Hades/EmoteCharging",

			AIAttackDistance = 350,
			AIBufferDistance = 325,

			AIMoveWithinRangeTimeout = 3.0,

			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,

			MaxConsecutiveUses = 2,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				ChanceToPlay = 0.33,
				RequiredFalseBossPhase = 3,
				Cooldowns =
				{
					{ Name = "HadesAnyQuipSpeech" },
					{ Name = "HadesBidentStrikeSpeech", Time = 120 },
				},

				-- Now.
				{ Cue = "/VO/HadesField_0048" },
				-- Now!
				{ Cue = "/VO/HadesField_0049" },
				-- Here!
				{ Cue = "/VO/HadesField_0050" },
				-- Here, boy!
				{ Cue = "/VO/HadesField_0051" },
				-- Observe!
				{ Cue = "/VO/HadesField_0052" },
				-- You...!
				{ Cue = "/VO/HadesField_0284" },
				-- Why, you!
				{ Cue = "/VO/HadesField_0567" },
				-- Prepare!
				{ Cue = "/VO/HadesField_0568" },
				-- Boy...!
				{ Cue = "/VO/HadesField_0569" },
				-- You brought this on yourself!!
				{ Cue = "/VO/HadesField_0290" },
				-- Raauuugghhhh!!
				{ Cue = "/VO/HadesField_0292" },
				-- Hrryyaaaahhh!
				{ Cue = "/VO/HadesField_0058" },
				-- Grraaauuuugggghhh!
				{ Cue = "/VO/HadesField_0059" },
				-- Zagreus...!
				{ Cue = "/VO/HadesField_0570", RequiredTextLines = { "Ending01" }, },
				-- Go back!
				{ Cue = "/VO/HadesField_0566", RequiredBossPhase = 2 },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/EmotePowerAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearSwipe" },
				{ Name = "/Leftovers/SFX/AuraThrow" }
			},
		},
	},

	HadesBidentSpin2 =
	{
		GenusName = "HadesBidentSpin",
		InheritFrom = { "HadesBidentSpin" },
		AIData =
		{
			DeepInheritance = true,

			PostAttackDuration = 0.45,
			PostAttackCooldown = 0.0,
			ChainedWeapon = "HadesBidentSpin2Reverse",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/EmotePowerAttacking2" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearSwipe" },
				{ Name = "/Leftovers/SFX/AuraThrowLarge" },
			},
		},
	},

	HadesBidentSpin2Reverse =
	{
		GenusName = "HadesBidentSpin",
		InheritFrom = { "HadesBidentSpin" },
		ChainedOnly = true,
		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.3,
			PreAttackAnimation = "HadesBattleAttackSpin2_Start",
			SkipMovement = true,
			FireAnimation = "HadesBattleAttackSpin2_Fire",
			PostAttackAnimation = "HadesBattleAttackSpin2_ReturnToIdle",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/EmotePowerAttacking2" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearSwipe" },
				{ Name = "/Leftovers/SFX/AuraThrow" },
			},
		},
	},

	HadesBidentThrow =
	{
		HitScreenshake = { Distance = 4, Speed = 1200, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.18, Fraction = 1.0, LerpTime = 0 },
		},

		BlockInterrupt = true,
		SkipToChainedWeaponIfObstacleExists = "HadesBidentReturnPoint",
		GenusName = "HadesBidentThrow",
		AIData =
		{
			DeepInheritance = true,
			--PreAttackDuration = 1.0,
			PreAttackDurationMin = 0.4,
			PreAttackDurationMax = 0.5,
			PreAttackEndMinWaitTime = 0.35,
			PreAttackEndShake = true,
			WaitUntilProjectileDeath = "HadesBidentThrow",
			PostAttackDuration = 0.4,

			ChainedWeapon = "HadesBidentRecoveryDash",

			PreAttackSound = "/SFX/Enemy Sounds/Hades/EmoteCharging",
			PreAttackFlashSound = "/SFX/Enemy Sounds/Hades/HadesReappear",
			PreAttackAnimation = "HadesBattleBidentThrow_Start",
			FireAnimation = "HadesBattleBidentThrow_Fire",
			PostAttackAnimation = "HadesBattleBidentThrow_SpearRecoveryStart",
			AITrackTargetDuringCharge = true,
			SkipStopBeforePreAttackEnd = true,
			AIAngleTowardsPlayerWhileFiring = false,

			AIAttackDistance = 950,
			AIBufferDistance = 850,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 80,

			ForceFirst = true,
			ForceIfTypeExists = "HadesBidentReturnPoint",
			MinPlayerDistance = 200,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusSpearThrow" },
				{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				{ Name = "/Leftovers/SFX/AuraThrowLarge" },
				{ Name = "/SFX/Enemy Sounds/Hades/EmoteSpearThrow" },
			},
		},
	},

	HadesBidentThrowBlast =
	{
		StartingWeapon = false,

		AIData =
		{
			FireFromObstacle = "HadesBidentReturnPoint",
			TargetName = "HadesBidentReturnPoint",
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	HadesDashSlowPools =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 6,
			FireCooldown = 0.05,

			PreAttackDuration = 0.0,
			PostAttackDuration = 0.0,

			AIAttackDistance = 1200,
			AIBufferDistance = 800,

			AITrackTargetDuringCharge = false,
		},

		Upgrades = { },
	},

	HadesBidentArcCombo1 =
	{
		GenusName = "HadesBidentArcCombo1",
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "HadesBattleAttackArcOne_Start",
			FireAnimation = "HadesBattleAttackArcOne_Fire",
			PostAttackAnimation = "HadesBattleAttackArcOne_ReturnToIdle",

			PreAttackDuration = 0.65,
			PreAttackSound = "/SFX/Enemy Sounds/Hades/EmoteCharging",
			FireDuration = 0.2,
			PostAttackDuration = 0.15,
			PostAttackMinWaitTime = 0.15,
			AIAttackDistance = 390,
			AIBufferDistance = 340,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 200,
			AILineOfSighEndBuffer = 80,
			AIMoveWithinRangeTimeout = 5.0,
			AITrackTargetDuringCharge = true,

			ChainedWeapon = "HadesBidentArcCombo2",
			MaxConsecutiveUses = 2,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/SFX/Enemy Sounds/Hades/EmoteAttacking" },
			},
		},
	},

	HadesBidentArcCombo2 =
	{
		GenusName = "HadesBidentArcCombo1",
		InheritFrom = {"HadesBidentArcCombo1"},
		ChainedOnly = true,

		AIData =
		{
			DeepInheritance = true,
			FireAnimation = "HadesBattleAttackArcTwo_Fire",

			PreAttackDuration = 0.0,
			FireDuration = 0.3,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			AIRequireUnitLineOfSight = false,
			AILineOfSightBuffer = 200,
			SkipAngleTowardTarget = true,
			SkipMovement = true,

			ChainedWeapon = "HadesBidentArcCombo3"
		},
	},

	HadesBidentArcCombo3 =
	{
		GenusName = "HadesBidentArcCombo1",
		InheritFrom = {"HadesBidentSpin"},
		ChainedOnly = true,

		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.35,
			PostAttackMinWaitTime = 0.25,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			SkipAngleTowardTarget = true,
			SkipMovement = true,
		},
	},

	HadesBidentArcCombo1_2 =
	{
		InheritFrom = {"HadesBidentArcCombo1"},
		GenusName = "HadesBidentArcCombo1",

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "HadesBidentArcCombo2_2"
		},
	},

	HadesBidentArcCombo2_2 =
	{
		InheritFrom = {"HadesBidentArcCombo2"},
		GenusName = "HadesBidentArcCombo1",
		ChainedOnly = true,

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "HadesBidentArcCombo3_2"
		},
	},

	HadesBidentArcCombo3_2 =
	{
		InheritFrom = {"HadesBidentSpin2"},
		GenusName = "HadesBidentArcCombo1",
		ChainedOnly = true,

		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.35,
			PostAttackMinWaitTime = 0.25,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			SkipAngleTowardTarget = true,
			SkipMovement = true,
		},
	},

	HadesBidentThrowCombo1 =
	{
		GenusName = "HadesBidentStrikeCombo1",
		InheritFrom = {"HadesBidentArcCombo1"},

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "HadesBidentThrowCombo2",
		},
	},

	HadesBidentThrowCombo2 =
	{
		GenusName = "HadesBidentStrikeCombo1",
		InheritFrom = {"HadesBidentArcCombo2"},

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "HadesBidentThrowCombo3",
		},
	},

	HadesBidentThrowCombo3 =
	{
		GenusName = "HadesBidentArcCombo1",
		InheritFrom = {"HadesBidentThrow"},
		ChainedOnly = true,

		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.35,
			PostAttackMinWaitTime = 0.25,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			SkipAngleTowardTarget = true,
			SkipMovement = true,
		},
	},

	HadesRubbleClear =
	{
		StartingWeapon = false,

		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 0,

		AIData =
		{
			PreAttackAnimation = "HadesBattleAttackArcTwo_Start",
			FireAnimation = "HadesBattleAttackArcTwo_Fire",
			PostAttackAnimation = "HadesBattleAttackArcTwo_ReturnToIdle",
			PreAttackSound = "/SFX/Enemy Sounds/Hades/EmoteCharging",

			RemoveFromGroups = { "GroundEnemies" },

			PreAttackDuration = 1.0,
			FireDuration = 1.0,
			PostAttackDuration = 0.3,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			SkipMovement = true,
			SkipAngleTowardTarget = true,

			AITrackTargetDuringCharge = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/Menu Sounds/TextReveal3" },
				{ Name = "/SFX/Enemy Sounds/Hades/EmotePowerAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},

		FireScreenshake = { Distance = 6, Speed = 400, FalloffSpeed = 1400, Duration = 0.4 },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0 },
		},

		Upgrades = { },
	},

	HadesDash =
	{
		AIData =
		{
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.41, -- the blink itself takes 0.21
			PostAttackMinWaitTime = 0.21,

			SkipMovement = true,
			KeepInvisibility = true,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/EmoteEvading" },
				{ Name = "/SFX/Enemy Sounds/Hades/HadesDash" },
			}
		},
	},

	HadesSideDash =
	{
		AIData =
		{
			PreAttackDuration = 0.1,
			PreAttackEndMinWaitTime = 0.1,
			FireDuration = 0.0,
			PostAttackDuration = 0.3,
			PostAttackMinWaitTime = 0.21,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,

			CreateOwnTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistance = 200,
			AIAngleTowardsPlayerWhileFiring = true,
			PreMoveAngleTowardTarget = true,

			AttackFailWeapon = "HadesSideDash",
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/EmoteEvading" },
				{ Name = "/SFX/Enemy Sounds/Exalted/ExaltedDash" },
			}
		},
	},

	HadesBidentRecoveryDash =
	{
		ChainedOnly = true,
		BlockInterrupt = true,
		AIData =
		{
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.41, -- the blink itself takes 0.21
			PostAttackMinWaitTime = 0.21,

			TargetName = "HadesBidentReturnPoint",

			SkipMovement = true,
			KeepInvisibility = true,

			MaxConsecutiveUses = 1,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/EmoteSuperDash" },
				{ Name = "/SFX/Enemy Sounds/Hades/HadesDash" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/Leftovers/SFX/AuraThrowSmall" },
			}
		},
	},

	HadesCast =
	{

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.5,
			PostAttackDuration = 0.65,

			PreAttackEndShake = true,
			PreAttackAnimation = "HadesBattleAttackRange_StartHold",
			PreAttackSound = "/SFX/Enemy Sounds/Hades/HadesRangedPreAttack",
			FireDuration = 0.23,
			FireAnimation = "HadesBattleAttackRange_FireCast",
			PostAttackAnimation = "HadesBattleAttackRange_ReturnToIdle",

			AIAttackDistance = 950,
			AIBufferDistance = 900,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 50,
			AIAngleTowardsPlayerWhileFiring = false,
			AITrackTargetDuringCharge = true,
			SkipStopBeforePreAttackEnd = true,

			AIMoveWithinRangeTimeoutMin = 1.0,
 			AIMoveWithinRangeTimeoutMax = 3.0,
		},

		StoreAmmoOnHit = 1,
		AmmoDropDelay = 6.5,
		StoredAmmoIcon = "AmmoEmbeddedInPlayerIcon",
		AmmoDropFireWeapon = "HadesAmmoDrop",
		SkipAmmoDropOnMiss = true,
		StoreAmmoInLastHit = true,
		FireAmmoDropWeaponOnDeflect = true,


		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/EmoteRanged" },
				{ Name = "/SFX/Player Sounds/BowFire" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	HadesCastBeam =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
		ImpactReactionHitsOverride = 1,

		BlockInterrupt = true,

		AIData =
		{
			DeepInheritance = true,

			MinPlayerDistance = 350,

			MoveToClosestSpawnPoint = true,

			PreAttackDuration = 2.0,
			FireDuration = 3.5,
			PostAttackDuration = 1.4,
			PreAttackSound = "/SFX/Enemy Sounds/Hades/EmoteCharging",

			PreAttackEndShake = true,
			PreAttackAnimation = "HadesBattleCastBeam_Start",
			FireAnimation = "HadesBattleCastBeam_Fire",
			PostAttackAnimation = "HadesBattleCastBeam_ReturnToIdle",

			AIAttackDistance = 50,
			AIBufferDistance = 50,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 150,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			SkipStopBeforePreAttackEnd = true,

			AIMoveWithinRangeTimeoutMin = 1.0,
 			AIMoveWithinRangeTimeoutMax = 1.5,

			MinAttacksBetweenUse = 1,

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.HadesBeamAttackVoiceLines,
			},
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/HellFireShoot" },
				{ Name = "/SFX/Enemy Sounds/Hades/EmoteRangedSustained" },
				{ Name = "/SFX/Enemy Sounds/Tisiphone/TisiphoneHarpySlowBeam" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	HadesCastBeam2 =
	{
		InheritFrom = { "HadesCastBeam" },

		AIData =
		{
			DeepInheritance = true,

			DumbFireWeapons = { "HadesRadialPush" },
		},
	},

	HadesCastBeam360 =
	{

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
		ImpactReactionHitsOverride = 1,

		BlockInterrupt = true,

		AIData =
		{
			DeepInheritance = true,
			MoveToClosestSpawnPoint = true,
			
			PreAttackDuration = 1.5,
			FireDuration = 3.5,
			PostAttackDuration = 1.5,
			PreAttackSound = "/SFX/Enemy Sounds/Hades/EmoteCharging",

			PreAttackEndShake = true,
			PreAttackAnimation = "HadesBattleCastBeam_Start",
			FireAnimation = "HadesBattleCastBeam_Fire",
			PostAttackAnimation = "HadesBattleCastBeam_ReturnToIdle",

			AIAttackDistance = 50,
			AIBufferDistance = 50,
			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 150,
			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,
			SkipStopBeforePreAttackEnd = true,

			AIMoveWithinRangeTimeoutMin = 1.0,
 			AIMoveWithinRangeTimeoutMax = 1.5,

 			MinAttacksBetweenUse = 1,

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.HadesBeamAttackVoiceLines,
			},
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hades/EmoteRangedSustained" },
				{ Name = "/SFX/Enemy Sounds/Tisiphone/TisiphoneHarpySlowBeam" },
			},
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	HadesCastBeam2360 =
	{
		InheritFrom = { "HadesCastBeam360" },

		AIData =
		{
			DeepInheritance = true,

			DumbFireWeapons = { "HadesRadialPush" },
		},
	},

	HadesReverseDarkness =
	{
		ImpactReactionHitsOverride = 1,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			TargetId = 40000,

			PreAttackDuration = 0.5,
			FireDuration = 0.3,
			PostAttackDuration = 0.65,

			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			SkipMovement = true,

			AITrackTargetDuringCharge = false,

			ForceUseIfReady = true,
			MinAttacksBetweenUse = 9999,

			FireFxAtTarget = "HadesReverseDarknessVignette",
		}
	},

	HadesAmmoWeapon =
	{
		ImpactReactionHitsOverride = 1,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	HadesAmmoWeaponSlowPools =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			AttackSound = "/SFX/Enemy Sounds/Megaera/EmoteSustainedAttacking",
			PreAttackDuration = 0.0,
			PostAttackDuration = 0.0,

			AIAttackDistance = 1200,
			AIBufferDistance = 800,

			AITrackTargetDuringCharge = false,
		},

		Upgrades = { },
	},

	HadesSpawns =
	{
		StartingWeapon = false,

		BlockInterrupt = true,
		AIData =
		{
			DeepInheritance = true,
			ThreadFunctionName = "HandleBossSpawns",
			PreAttackAnimation = "HadesBattleSpawn_Start",
			PreAttackEndFunctionName = "HadesSpawnsPresentation",
			PreAttackDuration = 0.65,
			PreAttackSound = "/SFX/Enemy Sounds/Hades/EmotePoweringUp",
			FireDuration = 2.5,
			PostAttackDuration = 1.0,

			MaxActiveSpawns = 6,
			MinAttacksBetweenUse = 5,

			SpawnRadius = 9999,
			SpawnInterval = 0.1,
			DifficultyRating = 500,
			SpawnAggroed = true,


			CreateOwnTarget = true,
			TargetAngleOptions = { 240 },
			TargetOffsetDistance = 100,
			AIAttackDistance = 100,
			AIBufferDistance = 100,

			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackVoiceLines =
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.65,
					SuccessiveChanceToPlay = 0.1,
					RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 4 },
					RequiredFalseBossPhase = 3,
					Cooldowns =
					{
						{ Name = "HadesSummonSpawnsSpeech", Time = 240 },
						{ Name = "HadesStageSwitchSpeech", Time = 90 },
					},
					TriggerCooldowns = { "HadesAnyQuipSpeech", "HadesGoneInvisSpeech" },

					-- Become as darkness, wretches, and destroy him, now!
					{ Cue = "/VO/HadesField_0644" },
					-- Come, wretches! I shall turn you from our sight!
					{ Cue = "/VO/HadesField_0645" },
					-- Arise, wretches, and fight without a trace!
					{ Cue = "/VO/HadesField_0646" },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.65,
					SuccessiveChanceToPlay = 0.25,
					RequiredFalseBossPhase = 3,
					Cooldowns =
					{
						{ Name = "HadesSummonSpawnsSpeech", Time = 240 },
						{ Name = "HadesStageSwitchSpeech", Time = 70 },
					},
					TriggerCooldowns = { "HadesAnyQuipSpeech", "HadesGoneInvisSpeech" },

					-- Come forth, wretches! And dispose of this unfilial oaf.
					{ Cue = "/VO/HadesField_0043", RequiredFalseTextLines = { "Ending01" }, },
					-- Wretches of the Underworld! Heed me, and rise from the earth to do my bidding!
					{ Cue = "/VO/HadesField_0044" },
					-- Hear me, wretches! Rise now from my realm, and fight again!
					{ Cue = "/VO/HadesField_0045" },
					-- On my authority, as Lord of Death! Awaken, wretches, and defend your king!
					{ Cue = "/VO/HadesField_0046" },
					-- Upon my name, I order all you wretches of the Underworld to attend me, now!
					{ Cue = "/VO/HadesField_0047" },
					-- To me, wretches! Destroy my kin, and an eternal torment to you if you speak of this!
					{ Cue = "/VO/HadesField_0392" },
					-- Rise, wretches, and fight with the ferocity with which you once clung to your meager lives!
					{ Cue = "/VO/HadesField_0393" },
					-- Wretches of the Underworld, I command you now to rise and fight for me!
					{ Cue = "/VO/HadesField_0394" },
					-- Awaken, wretches, and fight once more upon this surface-realm where you were slain!
					{ Cue = "/VO/HadesField_0395" },
					-- Heed now my summons, wretches, and come bring my wayward son down to your depths!
					{ Cue = "/VO/HadesField_0396" },
					-- Deathless wretches, I compel you to fight!
					{ Cue = "/VO/HadesField_0647" },
					-- Heed me, wretches, on my authority!
					{ Cue = "/VO/HadesField_0648" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlay = 0.25,
					UsePlayerSource = true,
					PreLineWait = 0.5,
					RequiredFalseBossPhase = 3,
					TriggerCooldowns = { "ZagreusAnyQuipSpeech" },
					MaxRunsSinceAnyTextLines = { TextLines = { "HadesGift05" }, Count = 60 },
					Cooldowns =
					{
						{ Name = "ZagreusSummonSpawnsReactionSpeech", Time = 120 },
						{ Name = "ZagStageSwitchSpeech", Time = 70 },
					},

					-- Need help with something, Father?!
					{ Cue = "/VO/ZagreusField_2278" },
					-- I thought you planned to handle this yourself!
					{ Cue = "/VO/ZagreusField_2279" },
					-- Why don't you tell your loyal subjects to stay out of this!
					{ Cue = "/VO/ZagreusField_2280" },
					-- Upon my name, I'll bury all you wretches here and now!
					{ Cue = "/VO/ZagreusField_2281", RequiredLastLinePlayed = { "/VO/HadesField_0047" } },
					-- I'll send your wretches back where they belong!
					{ Cue = "/VO/ZagreusField_2408" },
					-- Why don't you let your wretches rest in peace?
					{ Cue = "/VO/ZagreusField_2409" },
					-- Fight again, and die again!
					{ Cue = "/VO/ZagreusField_2410", RequiredLastLinePlayed = { "/VO/HadesField_0045" } },
					-- Then I'll just have to attend to them!
					{ Cue = "/VO/ZagreusField_2411", RequiredLastLinePlayed = { "/VO/HadesField_0047" } },
				}
			},
		},

		FireScreenshake = { Distance = 15, Speed = 800, Duration = 0.7, FalloffSpeed = 3000 },
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.7 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},

		Upgrades = { },
	},

	HadesSpawns2 =
	{
		InheritFrom = { "HadesSpawns" },

		AIData =
		{
			DeepInheritance = true,

			DifficultyRating = 500,
			DifficultyRatingIncreasePerUse = 500,

			SpawnSkipOverridesForTypes = { "WretchAssassinMinibossSuperElite" },

			SpawnDefaultAIDataOverrides =
			{
				PreMoveDuration = 0.01,
				PreMoveFunctionName = "EnemyInvisibility",
				PreMoveFunctionArgs = { CreateAnimation = "HadesDisappear" },

				TeleportationPointsGroupName = "HadesTeleportationPoints",
				PreAttackEndFunctionName = "EnemyHandleInvisibleAttack",
				PreAttackEndFunctionArgs = { Animation = "HadesReappear" },
				InvisibilityInterval = 6,
				InvisibilityFadeOutDuration = 0.3,
				InvisibilityFadeInDuration = 0.3,
				PostTeleportWaitDurationMin = 1.0,
				PostTeleportWaitDurationMax = 2.0,
				PostInvisibilityFunction = "HadesTeleport",
			},
			SpawnDataOverrides =
			{
				SetLastInvisibilityTimeOnSpawn = true,
			},
		},
	},

	HadesWrath =
	{
		GenusName = "HadesWrath",
		FireScreenshake = { Distance = 11, Speed = 1000, Duration = 0.8, FalloffSpeed = 3000 },

		BlockInterrupt = true,
		AIData = {
			TeleportationPointsGroupName = "HadesTeleportationPoints",

			MinAttacksBetweenUse = 5,

			PreAttackDuration = 0.6,
			FireDuration = 1.0,
			PostAttackDuration = 1.6,

			CreateOwnTarget = true,
			TargetAngleOptions = { 240 },
			TargetOffsetDistance = 100,
			AIAttackDistance = 100,
			AIBufferDistance = 100,

			PreAttackAnimation = "HadesBattleWrathTwo_Start",
			FireAnimation = "HadesBattleWrathTwo_Fire",
			PostAttackAnimation = "HadesBattleWrathTwo_ReturnToIdle",

			AttackSound = "/Leftovers/SFX/DemonScorePoseSFX",

			AttackSlotsPerTick = 9,
			AttackSlotInterval = 0.05,
			AttackSlots =
			{
				{ UseMapObjectId = 511106 },
				{ UseMapObjectId = 552618 },
				{ UseMapObjectId = 552621 },
				{ UseMapObjectId = 552622 },
				{ UseMapObjectId = 552625 },
				{ UseMapObjectId = 552626 },
				{ UseMapObjectId = 552628 },
				{ UseMapObjectId = 552631 },
				{ UseMapObjectId = 552632 },
				{ UseMapObjectId = 552635 },
				{ UseMapObjectId = 552639 },
				{ UseMapObjectId = 552640 },
			},

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.HadesWrathAttackVoiceLines,
			},
		},
	},

	HadesWrathPassive =
	{
		AIData = {
			FireTicks = 1,
			FireInterval = 6.0,

			AttackSlotsPerTickMin = 1,
			AttackSlotsPerTickMax = 2,
			AttackSlotInterval = 0.05,
			AttackSlots =
			{
				{ UseMapObjectId = 511106 },
				{ UseMapObjectId = 552618 },
				{ UseMapObjectId = 552621 },
				{ UseMapObjectId = 552622 },
				{ UseMapObjectId = 552625 },
				{ UseMapObjectId = 552626 },
				{ UseMapObjectId = 552628 },
				{ UseMapObjectId = 552631 },
				{ UseMapObjectId = 552632 },
				{ UseMapObjectId = 552635 },
				{ UseMapObjectId = 552639 },
				{ UseMapObjectId = 552640 },
			},
		},
	},

	CrawlerRushMiniBoss =
	{
		StartingWeapon = false,
		HitScreenshake = { Distance = 5, Speed = 1500, Duration = 0.20, FalloffSpeed = 3000 },
		FireScreenshake = { Distance = 5, Speed = 1500, Duration = 0.15, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.00, LerpTime = 0.07 },
		},

		AIData =
		{
			UseRamAILoop = true,

			RetreatAfterRam = true,
			AIBufferDistance = 800,
			RetreatTimeout = 1.0,
			RamRecoverTime = 0.3,
			PreAttackDuration = 1.5,
			PreAttackSound = "/SFX/Enemy Sounds/RatThug/EmoteCharging",
			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,
			PreAttackStop = true,
			SetupDistance = 500,
			SetupTimeout = 3.0,
			PreAttackFx = "CastDustBullRushLeft",
			FireFx = "EnemyCrawlerRushMiniBossAttackStreaks",
			FireSound = "/SFX/Enemy Sounds/RatThug/EmoteDying",
		},
	},

	CrawlerSpawns =
	{
		StartingWeapon = false,

		BlockInterrupt = true,
		AIData =
		{
			ThreadFunctionName = "HandleBossSpawns",
			PreAttackAnimation = "EnemyCrawlerHowling",
			--PreAttackFx = "ThanatosTeleport",
			PostAttackAnimation = "EnemyCrawlerIdle",
			PreAttackDuration = 1.0,
			FireDuration = 1.0,
			PostAttackDuration = 0.8,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			SkipMovement = true,
			FireCooldown = 0,

			MaxActiveSpawns = 7,
			MinAttacksBetweenUse = 13,
			MaxAttacksBetweenUse = 15,

			SpawnRadius = 1000,
			SpawnInterval = 0.1,
			SpawnCount = 5,
			SpawnAggroed = true,

			CreateOwnTarget = true,
			TargetOffsetDistance = 10,

			PreAttackVoiceLines =
			{
				PlayOnce = true,
				PlayOnceContext = "TinyVerminFight",
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 2.0,
				UsePlayerSource = true,
				SuccessiveChanceToPlayAll = 0.05,
				Cooldowns =
				{
					{ Name = "CrawlerBossSummonSpeech", Time = 300 },
				},
				-- Wha, aah!
				{ Cue = "/VO/ZagreusField_3355" },	
				-- Oh no!
				{ Cue = "/VO/ZagreusField_3372", RequiredPlayed = { "/VO/ZagreusField_3355" }, },
				-- So you're the ringleader!
				{ Cue = "/VO/ZagreusField_3373", RequiredPlayed = { "/VO/ZagreusField_3355" }, },
				-- Oh gods!
				{ Cue = "/VO/ZagreusField_3356", RequiredPlayed = { "/VO/ZagreusField_3355" }, },
			},

		},

		FireRadialBlur = { Distance = 1.0, Strength = 1.0, FXHoldTime = 0.4, FXInTime = 0.15, FXOutTime = 0.15 },
		FireScreenshake = { Distance = 5, Speed = 800, Duration = 0.7, FalloffSpeed = 3000 },
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.7 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar" },
			},
		},

		Upgrades = { },
	},

	CrawlerReburrow =
	{
		ForceFirst = true,
		GenusName = "CrawlerReburrow",
		AIData =
		{
			ChainedWeapon = "CrawlerReburrowShockwave",
			MinAttacksBetweenUse = 1,

			TeleportPreWaitAnimation = "EnemyCrawlerReburrow",
			TeleportAnimation = "EnemyCrawlerBurrowFast",

			TeleportToSpawnPoints = true,
			TeleportMaxDistance = 500,
			TeleportationInterval = 0,
			TeleportPreWaitFx = "EnemyBurrowExitSmall",
			TeleportEndFx = "EnemyBurrowEntranceSmall",
			PreTeleportWait = 1.5,
			PostTeleportWait = 0.5,
			StopBeforeTeleport = true,

			SkipMovement = true,
			PreAttackDuration = 0.1,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			MinAttacksBetweenUse = 1,

			--[[
			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.4,
				UsePlayerSource = true,
				SuccessiveChanceToPlay = 0.15,
				Cooldowns =
				{
					{ Name = "CrawlerBossBurrowSpeech", Time = 270 },
				},

				-- Where'd you go?
				{ Cue = "/VO/ZagreusField_3374" },
				-- Is it gone...?
				{ Cue = "/VO/ZagreusField_3375" },
				-- Where'd it go?
				{ Cue = "/VO/ZagreusField_3376" },
				-- It's underground...
				{ Cue = "/VO/ZagreusField_3377" },
				-- Where is it...
				{ Cue = "/VO/ZagreusField_3378" },
			},
			]]--

		},
	},

	CrawlerReburrowShockwave =
	{
		GenusName = "CrawlerReburrow",
		ChainedOnly = true,
		AIData =
		{
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.5,
			SkipMovement = true,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				{ Name = "/SFX/Enemy Sounds/RatThug/EmoteCharging" },
				{ Name = "/SFX/Enemy Sounds/Crawler/EmoteAlerted" }
			},
		},
	},

	EliteDeathAllyHitShields =
	{
		AIData =
		{
			TargetSelf = true,

			PreAttackDurationMin = 2.5,
			PreAttackDurationMax = 3.5,

			FireTicks = 1,
			FireCooldown = 0.0,
			FireIntervalMin = 7.5,
			FireIntervalMax = 8.5,
			EndDumbFireOnTimesFired = 5,
		}
	},

	-- Devotion Test God Powers

	DevotionZeus =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionArtemis_ALT =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData = {
			FireTicks = 1,
			FireIntervalMin = 4.0,
			FireIntervalMax = 8.0,

			AttackSlotsPerTick = 5,
			AttackSlotInterval = 0.2,
			AttackSlots =
			{
				{ OffsetDistance = 300, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAngleBetween = true },
				{ OffsetDistance = 660, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAngleBetween = true },
				{ OffsetDistance = 960, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAngleBetween = true },
				{ OffsetDistance = 1260, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAngleBetween = true },
				{ OffsetDistance = 1560, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAngleBetween = true },
			},
		},
	},

	DevotionArtemis =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},


	DevotionPoseidon_ALT =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionAres =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionDionysus_ALT =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			FireTicks = 3,
			FireCooldown = 0.175,
			FireIntervalMin = 9,
			FireIntervalMax = 11,
		},
	},

	DevotionDionysus =
	{
		--HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0 },
		},

		AIData = {
			--[[AttackSlotsPerTick = 26,
			AttackSlotInterval = 0.001,
			AttackSlots =
			{
				{ Angle = 0, OffsetDistance = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true, PauseDuration = 0.15 },

				{ Angle = 0, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 72, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 144, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 216, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 288, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true, PauseDuration = 0.1 },

				{ Angle = 0, OffsetDistance = 400, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 36, OffsetDistance = 400, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 72, OffsetDistance = 400, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 108, OffsetDistance = 400, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 144, OffsetDistance = 400, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 180, OffsetDistance = 400, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 216, OffsetDistance = 400, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 252, OffsetDistance = 400, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 288, OffsetDistance = 400, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 324, OffsetDistance = 400, OffsetScaleY = 0.48, OffsetFromAttacker = true, PauseDuration = 0.1 },

				{ Angle = 0, OffsetDistance = 650, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 36, OffsetDistance = 650, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 72, OffsetDistance = 650, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 108, OffsetDistance = 650, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 144, OffsetDistance = 650, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 180, OffsetDistance = 650, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 216, OffsetDistance = 650, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 252, OffsetDistance = 650, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 288, OffsetDistance = 650, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 324, OffsetDistance = 650, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},]]
		},
	},

	DevotionAthena =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionAphrodite =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.30, Fraction = 1.0, LerpTime = 0 },
		},
	},

	--[[DevotionAphrodite =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData = {
			AttackSlotsPerTick = 24,
			AttackSlotInterval = 0.001,
			AttackSlots =
			{
				{ Angle = 0, OffsetDistance = 500, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 45, OffsetDistance = 500, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 90, OffsetDistance = 500, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 135, OffsetDistance = 500, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 180, OffsetDistance = 500, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 225, OffsetDistance = 500, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 270, OffsetDistance = 500, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 315, OffsetDistance = 500, OffsetScaleY = 0.48, OffsetFromAttacker = true, PauseDuration = 0.1 },

				{ Angle = 0, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 22.5, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 45, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 67.5, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 90, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 112.5, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 135, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 157.5, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 180, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 202.5, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 225, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 247.5, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 270, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 292.5, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 315, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 337.5, OffsetDistance = 950, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},
		},
	},]]--

	DevotionDionysus2 =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData = {
			FireTicks = 1,
			FireIntervalMin = 4.0,
			FireIntervalMax = 8.0,

			AttackSlotsPerTick = 8,
			AttackSlotInterval = 0.2,
			AttackSlots =
			{
				{ Angle = 0, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 45, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 90, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 135, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 180, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 225, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 270, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
				{ Angle = 315, OffsetDistance = 200, OffsetScaleY = 0.48, OffsetFromAttacker = true },
			},
		},
	},

	DevotionDemeter =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},


	ChariotRam =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ChariotRamElite =
	{
		InheritFrom = { "ChariotRam" }
	},

	ChariotRamSelfDestruct =
	{
		StartingWeapon = false,
		IgnoreHealthBuffer = true,
		OnFiredFunctionName = "SelfDestruct",
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ChariotRamDeathWeapon =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0 },
		},
	},

	IllusionistSplit =
	{
		StartingWeapon = false,

		AIData =
		{
			PreAttackWaitForAnimation = false,
			PreAttackDuration = 0,
			FireDuration = 0.0,
			AIAttackDistance = 2000,
			AIBufferDistance = 2000,
			FireCooldown = 0,
			RetreatAfterAttack = true,

			FireFunctionName = "IllusionistSplit",
			SpawnedUnit = "IllusionistClone",
			AttackSlotsPerTick = 3,
			AttackSlots =
			{
				{ Angle = 0, OffsetDistance = 50, OffsetScaleY = 0.48 },
				{ Angle = 120, OffsetDistance = 50, OffsetScaleY = 0.48 },
				{ Angle = 240, OffsetDistance = 50, OffsetScaleY = 0.48 },
			},
			AIAngleTowardsPlayerWhileFiring = false,
			AIRequireProjectileLineOfSight = false,
			PreAttackAnimation = "IllusionistPuff",
			PostAttackDuration = 0.0,
			PostAttackFx = "IllusionistPuff",
			PostAttackFXOnPlayer = true,

			MinAttacksBetweenUse = 3,
			MaxActiveSpawns = 1,
		},
	},

	IllusionistSplitElite =
	{
		StartingWeapon = false,

		AIData =
		{
			PreAttackWaitForAnimation = false,
			PreAttackDuration = 0,
			FireDuration = 0.0,
			AIAttackDistance = 2000,
			AIBufferDistance = 2000,
			FireCooldown = 0,
			RetreatAfterAttack = true,

			FireFunctionName = "IllusionistSplit",
			SpawnedUnit = "IllusionistCloneElite",
			AttackSlotsPerTick = 4,
			AttackSlots =
			{
				{ Angle = 0, OffsetDistance = 50, OffsetScaleY = 0.48 },
				{ Angle = 120, OffsetDistance = 50, OffsetScaleY = 0.48 },
				{ Angle = 240, OffsetDistance = 50, OffsetScaleY = 0.48 },
				{ Angle = 270, OffsetDistance = 50, OffsetScaleY = 0.48 },
			},
			AIAngleTowardsPlayerWhileFiring = false,
			AIRequireProjectileLineOfSight = false,
			PreAttackAnimation = "IllusionistPuff",
			PostAttackDuration = 0.0,
			PostAttackFx = "IllusionistPuff",
			PostAttackFXOnPlayer = true,

			MinAttacksBetweenUse = 3,
			MaxActiveSpawns = 1,
		},
	},

	ThanatosDeathCurse =
	{
		OnHitFunctionNames = { "CurseHealthBar" },
		IgnoreHealthBuffer = true,
		ForceCrit = true,
		IgnoreOutgoingDamageModifiers = true,

		AIData =
		{
			PreAttackAnimation = "ThanatosFire",

			PreAttackDuration = 0.35,
			PreAttackFx = "ThanatosCast",
			PreAttackEndShake = true,
			PostAttackDuration = 0.6,
			PostAttackCooldown = 0.8,
			AIAttackDistance = 800,
			IgnoreInvulnerable = true,

			TargetFriends = true,
			TrackKillSteal = true,

			MaxConsecutiveUses = 8,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				CooldownTime = 8,
				RequiredKillEnemiesFound = true,
				SuccessiveChanceToPlay = 0.75,

				-- You.
				{ Cue = "/VO/Thanatos_0186" },
				-- It's over.
				{ Cue = "/VO/Thanatos_0142" },
				-- You.
				{ Cue = "/VO/Thanatos_0255" },
				-- You...!
				{ Cue = "/VO/Thanatos_0256" },
				-- You...
				{ Cue = "/VO/Thanatos_0257" },
				-- You're next.
				{ Cue = "/VO/Thanatos_0258" },
				-- You are next.
				{ Cue = "/VO/Thanatos_0259" },
				-- How about you.
				{ Cue = "/VO/Thanatos_0260" },
				-- How about you?
				{ Cue = "/VO/Thanatos_0261" },
				-- How about... you.
				{ Cue = "/VO/Thanatos_0262" },
				-- Your turn.
				{ Cue = "/VO/Thanatos_0263" },
				-- That one.
				{ Cue = "/VO/Thanatos_0264" },
				-- You die next.
				{ Cue = "/VO/Thanatos_0265" },
				-- Prepare to die.
				-- { Cue = "/VO/Thanatos_0266" },
				-- Time is up.
				{ Cue = "/VO/Thanatos_0033" },
				-- Any last words?
				{ Cue = "/VO/Thanatos_0267" },
				-- You're already dead.
				{ Cue = "/VO/Thanatos_0268" },
				-- Say goodnight.
				{ Cue = "/VO/Thanatos_0043" },
				-- Die.
				{ Cue = "/VO/ThanatosField_0150" },
				-- Next.
				{ Cue = "/VO/ThanatosField_0151" },
				-- There.
				{ Cue = "/VO/ThanatosField_0152" },
				-- Prepare.
				{ Cue = "/VO/ThanatosField_0153" },
			},
		},
	},

	ThanatosDeathCurseAoE =
	{
		OnHitFunctionNames = { "CurseHealthBar" },
		IgnoreHealthBuffer = true,
		ForceCrit = true,

		AIData =
		{
			PreAttackAnimation = "ThanatosAoEFire",

			PreAttackDuration = 0.35,
			PreAttackFx = "ThanatosCastLong",
			PostAttackDuration = 0.6,
			PostAttackCooldown = 2.0,
			AIAttackDistance = 800,
			IgnoreInvulnerable = false,

			TargetFriends = true,
			TrackKillSteal = true,

			MinAttacksBetweenUse = 3,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				CooldownTime = 12,
				RequiredKillEnemiesFound = true,

				-- Not so fast.
				{ Cue = "/VO/Thanatos_0097" },
				-- Time to die.
				{ Cue = "/VO/Thanatos_0032" },
				-- All must die.
				{ Cue = "/VO/Thanatos_0287" },
				-- All perish.
				{ Cue = "/VO/Thanatos_0288" },
				-- Death Sentence.
				{ Cue = "/VO/Thanatos_0289" },
				-- Death Sentence...!
				{ Cue = "/VO/Thanatos_0290" },
				-- Death and decay.
				{ Cue = "/VO/Thanatos_0291" },
				-- Certain death.
				{ Cue = "/VO/Thanatos_0292" },
				-- Wither and die.
				{ Cue = "/VO/Thanatos_0293" },
				-- Who dies next?
				{ Cue = "/VO/Thanatos_0294" },
				-- Perish.
				{ Cue = "/VO/Thanatos_0295" },
				-- Die...
				{ Cue = "/VO/Thanatos_0296" },
				-- Die...!
				{ Cue = "/VO/Thanatos_0297" },
				-- Hraah...!
				{ Cue = "/VO/Thanatos_0298" },
				-- Hrnmm!
				{ Cue = "/VO/Thanatos_0299" },
				-- There is no escape.
				{ Cue = "/VO/Thanatos_0040" },
				-- Nrrgghh!
				-- { Cue = "/VO/Thanatos_0300" },
				-- Gather round...!
				{ Cue = "/VO/ThanatosField_0158", RequiredMinKillEnemies = 3 },
				-- Hold it right there...
				{ Cue = "/VO/ThanatosField_0159" },
				-- You're all coming with me...!
				{ Cue = "/VO/ThanatosField_0160", RequiredMinKillEnemies = 3 },
				-- Prepare yourselves.
				{ Cue = "/VO/ThanatosField_0161", RequiredMinKillEnemies = 3 },
			},
		},
		OutgoingDamageModifiers =
		{
			{
				PlayerSummonMultiplier = 0,
				Multiplicative = true
			}
		}
	},

	WretchAssassinStab =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.00, LerpTime = 0 },
		},

		AIData =
		{
			DeepInheritance = true,
			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackSound = "/SFX/Enemy Sounds/WretchedShadeAssassin/EmoteCharging",

			PreMoveDuration = 0.01,
			PreMoveFunctionName = "EnemyInvisibility",
			PreMoveFunctionArgs = { Animation = "EnemyWretchAssassin_Teleport", CreateAnimation = "BlinkStart_WretchAssassin" },

			PreAttackAnimation = "EnemyWretchAssassinStab_Start",
			PreAttackDuration = 0.1,
			PreAttackEndMinWaitTime = 0.1,
			FireAnimation = "EnemyWretchAssassinStab_Fire",
			FireDuration = 0.4,
			PostAttackAnimation = "EnemyWretchAssassinStab_ReturnToIdle",
			PostAttackDuration = 1.75,
			PreAttackCancelSound = "/Leftovers/SFX/ImpRef02_GoDown",
			PreAttackEndShake = true,
			PreAttackEndShakeSound = "/Leftovers/SFX/SprintChargeUp",

			AIAttackDistance = 9999,
			AIBufferDistance = 150,

			PreAttackFunctionName = "TeleportBehindTarget",
			TeleportBehindTargetDistance = -100,

			MinAttacksBetweenUse = 2,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
		},

		Upgrades = { },
	},

	WretchAssassinRanged =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			DeepInheritance = true,
			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackSound = "/SFX/Enemy Sounds/WretchedShadeAssassin/EmoteAlerted",

			PreMoveDuration = 0.01,
			PreMoveFunctionName = "EnemyInvisibility",
			PreMoveFunctionArgs = { Animation = "EnemyWretchAssassin_Teleport", CreateAnimation = "BlinkStart_WretchAssassin" },

			PreAttackAnimation = "EnemyWretchAssassinRange_Start",
			PreAttackDuration = 0.2,
			PreAttackEndMinWaitTime = 0.2,
			FireAnimation = "EnemyWretchAssassinRange_Fire",
			FireDuration = 0.3,
			PostAttackAnimation = "EnemyWretchAssassinRange_ReturnToIdle",
			PostAttackDuration = 0.6,
			PostAttackMinWaitTime = 0.4,
			PreAttackCancelSound = "/Leftovers/SFX/ImpRef02_GoDown",
			PreAttackEndShake = true,
			PreAttackEndShakeSound = "/Leftovers/SFX/SprintChargeUp",

			AIAttackDistance = 9999,
			AIBufferDistance = 150,

			TeleportToSpawnPoints = true,
			TeleportMinDistance = 400,
			TeleportMaxDistance = 1000,
			TeleportationInterval = 0,
		},

		Upgrades = { },
	},

	WretchAssassinRanged2 =
	{
		InheritFrom = { "WretchAssassinRanged" },

		AIData =
		{
			DeepInheritance = true,

			FireTicks = 3,
			FireCooldown = 0.15,
		},
	},

	HeavyMelee =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			DeepInheritance = true,
			AITrackTargetDuringCharge = false,
			AIAngleTowardsPlayerWhileFiring = false,

			PreAttackSound = "/SFX/Enemy Sounds/HeavyMelee/EmoteCharging",

			PreAttackAnimation = "EnemyWretchThugAttackCharge",
			PreAttackDuration = 0.4,
			PreFireAnimation = "EnemyWretchThugAttackCharge",
			PreFireDuration = 0.13,
			FireAnimation = "EnemyWretchThugAttackFire",
			FireDuration = 0.9,
			PostAttackAnimation = "EnemyWretchThugIdle",
			PostAttackDuration = 1.5,
			PreAttackCancelSound = "/Leftovers/SFX/ImpRef02_GoDown",
			PreAttackEndShake = true,
			PreAttackEndShakeSound = "/Leftovers/SFX/SprintChargeUp",

			AIAttackDistance = 200,
			AIBufferDistance = 150,
		},

		Upgrades = { },
	},

	HeavyMeleeElite =
	{
		InheritFrom = { "HeavyMelee" },

		AIData =
		{
			DeepInheritance = true,

			AIAttackDistance = 225,
			AIBufferDistance = 175,

			FireDuration = 0.3,
			PostAttackDuration = 0.0,
			PreAttackEndShake = false,
			ChainedWeapon = "HeavyMeleeEliteShockwave"
		},
	},

	HeavyMeleeEliteShockwave =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		ChainedOnly = true,
		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			PreAttackAnimation = "EnemyWretchThugAttackCharge",
			PreAttackDuration = 0.2,
			PreFireAnimation = "EnemyWretchThugAttackCharge",
			FireDuration = 0.4,
			FireAnimation = "EnemyWretchThugAttackFire",
			PostAttackDuration = 0.8,
			PostAttackAnimation = "EnemyWretchThugIdle",
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			SkipMovement = true,
			SkipAngleTowardTarget = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				{ Name = "/SFX/Player Sounds/ZagreusSwordParry" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/EmotePowerAttacking" },
			},
		},

		Upgrades = { },
	},

	PunchingBagUnitWeapon =
	{
		StartingWeapon = false,

		AIData =
		{
			DeepInheritance = true,
			PreAttackSound = "/SFX/Enemy Sounds/PunchingBag/EmoteCharging",
			PreAttackFlashSound = "/Leftovers/SFX/AuraOnLoud",
			PreAttackEndShake = true,
			PreAttackAnimation = "EnemyWretchGluttonAttackCharge",
			--PreAttackWaitForAnimation = true,
			PreAttackDuration = 0.66,
			PostAttackDuration = 1.1,
			--PreFireDuration = 0.13,
			FireAnimation = "EnemyWretchGluttonAttackFire",
			FireDuration = 0.5,
			PostAttackAnimation = "EnemyWretchGluttonIdle",
			PreAttackEndShakeSound = "/Leftovers/SFX/SprintChargeUp",
			IsAggroedSound = "/SFX/Enemy Sounds/PunchingBag/EmoteAlerted",

			AIAggroRange = 750,
			AIWanderDistance = 300,

			AIAngleTowardsPlayerWhileFiring = false,
			AIAttackDistance = 600,
			AIBufferDistance = 100,
			AIMoveWithinRangeTimeoutMin = 6.0,
			AIMoveWithinRangeTimeoutMax = 10.0,

			AILineOfSightBuffer = 85,
			AIRequireUnitLineOfSight = true,
			AITrackTargetDuringCharge = false,
			AIAngleTowardsPlayerWhileFiring = false,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.18, Fraction = 1.0, LerpTime = 0 },
		},
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/SwordWallHitClankSmall",
				StoneObstacle = "/SFX/ArrowMetalStoneClang",
				MetalObstacle = "/SFX/ArrowMetalStoneClang",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},

		Upgrades = { },
	},

	PunchingBagUnitWeaponElite =
	{
		InheritFrom = { "PunchingBagUnitWeapon" },

		AIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 0.0,
			ChainedWeapon = "PunchingBagUnitWeaponEliteShockwave"
		},
	},

	PunchingBagUnitWeaponEliteShockwave =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		ChainedOnly = true,
		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			PreAttackAnimation = "EnemyWretchGluttonAttackCharge",
			PreAttackDuration = 0.4,
			FireDuration = 0.4,
			FireAnimation = "EnemyWretchGluttonOnHit",
			PostAttackDuration = 0.8,
			PostAttackAnimation = "EnemyWretchGluttonIdle",
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			SkipMovement = true,
			SkipAngleTowardTarget = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				{ Name = "/SFX/Player Sounds/ZagreusSwordParry" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/EmotePowerAttacking" },
			},
		},

		Upgrades = { },
	},

	GluttonObstacleStun =
	{
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy" },
			},
		},
	},

	BerserkMeleeWeapon =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0 },
		},
		Upgrades = { },
	},

	DamageOnTouchWeapon =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0 },
		},
		Upgrades = { },
	},

	CrusherUnitTouchdown =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0 },
		},
		Upgrades = { },

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Crusher/EmoteAttacking" },
			},
		},
	},

	HydraCrusher =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0 },
		},
		Upgrades = { },

		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 1.0,
			FireDuration = 0.75,
			PostAttackDuration = 0.1,
			PreAttackAnimation = "EnemyHydraRoarPreAttack",
			PostAttackAnimation = "EnemyHydraRoarReturnToIdle",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Crusher/EmoteAttacking" },
			},
		},
	},

	HydraCrusher2 =
	{
		InheritFrom = { "HydraCrusher" },

		AIData =
		{
			DeepInheritance = true,

			FireTicks = 2,
			FireCooldown = 1.25,

			PreAttackVoiceLines =
			{
				PlayOnce = true,
				PlayOnceContext = "HydraCrusherReaction",
				PreLineWait = 2.0,
				UsePlayerSource = true,

				-- I do not appreciate that!
				{ Cue = "/VO/ZagreusField_3936" },
			},

		},
	},

	HydraCrusher3 =
	{
		InheritFrom = { "HydraCrusher" },

		AIData =
		{
			DeepInheritance = true,

			FireTicks = 3,
			FireCooldown = 1.25,
		},
	},

	RangedBurrowerWeapon =
	{
		CauseImpactReaction = true,

		AIData =
		{
			DeepInheritance = true,

			PreAttackAnimation = "EnemyBoneDraconRange_Start",
			FireAnimation = "EnemyBoneDraconRangeSingle_Fire",
			PostAttackAnimation = "EnemyBoneDraconRange_ReturnToIdle",
			PreAttackDuration = 0.3,
			PreAttackEndMinWaitTime = 0.25,
			FireDuration = 0.6,
			PostAttackDuration = 0.75,

			AIAttackDistance = 1000,
			AIBufferDistance = 50,

			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,

			SkipMovement = true,

			MaxConsecutiveUses = 1,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/RangedBurrower/EmoteAttacking" },
			},
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	RangedBurrowerWeaponElite =
	{
		InheritFrom = { "RangedBurrowerWeapon" },

		AIData =
		{
			DeepInheritance = true,

			PreAttackAnimation = "EnemyBoneDraconRange_Start",
			FireAnimation = "EnemyBoneDraconRangeRapid_Fire",
			PostAttackAnimation = "EnemyBoneDraconRange_ReturnToIdle",
			PreAttackDuration = 0.3,
			PreAttackEndMinWaitTime = 0.25,
			FireDuration = 0.6,
			PostAttackDuration = 0.5,

			AIAttackDistance = 1000,
			AIBufferDistance = 50,

			AIAngleTowardsPlayerWhileFiring = true,
			AITrackTargetDuringCharge = true,

			SkipMovement = true,

			FireTicks = 3,
			FireCooldown = 0.3,
		},
	},

	RangedBurrowerBurrow =
	{
		ForceFirst = true,
		AIData =
		{
			MinAttacksBetweenUse = 1,

			TeleportPreWaitAnimation = "EnemyBoneDraconBurrowSet_Burrow",
			TeleportAnimation = "EnemyBoneDraconBurrowSet_UnborrowWiggle",

			TeleportToSpawnPoints = true,
			TeleportMaxDistance = 800,
			TeleportMinDistance = 350,
			TeleportationInterval = 0,
			TeleportPreWaitFx = "null",
			TeleportEndFx = "EnemyBurrowEntrance_BoneDracon",
			PreTeleportWait = 0.5,
			PostTeleportWait = 1.0,
			StopBeforeTeleport = true,

			SkipMovement = true,
			PreAttackDuration = 0.1,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
		},
	},

	LightRangedWeapon =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	LightRangedWeaponElite =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	LightRangedWeaponSuperElite =
	{
		StartingWeapon = false,

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	DisembodiedHandGrab =
	{
		StartingWeapon = false,

		AIData =
		{
			DeepInheritance = true,

			AIAttackDistance = 150,
			AIBufferDistance = 150,

			OnlyClosestOfTypesMove = { "DisembodiedHand", "DisembodiedHandElite", "DisembodiedHandSuperElite" },
			NotClosestSleepTime = 0.3,

			--PreMoveFunctionName = "EnemyInvisibility",
			--PreMoveFunctionArgs = { Alpha = 0.3, Color = { 1.0, 1.0, 1.0, 0.3 } },

			PreAttackAnimation = "EnemyWringerAttack_Start",
			PreAttackDuration = 0.30,
			PreAttackEndMinWaitTime = 0.15,
			FireAnimation = "EnemyWringerAttack_Fire",
			FireDuration = 1.0,
			PostAttackDuration = 1.0,
			PreAttackEndShake = true,
			PostAttackAnimation = "EnemyWringerAttack_ReturnToIdle",

			AIRequireUnitLineOfSight = true,
			AILineOfSightBuffer = 30,

			--PreAttackFunctionName = "EnemyHandleInvisibleAttack",

			MoveSuccessDistance = 80,
		},

		--OnHitFunctionNames = { "HandGrabOnHit" },

		--HitScreenshake = { Distance = 2, Speed = 200, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.09, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	DisembodiedHandGrabElite =
	{
		InheritFrom = { "DisembodiedHandGrab" },

		AIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 0.5,
		},
	},


	SwarmerMelee =
	{
		StartingWeapon = false,

		--HitScreenshake = { Distance = 2, Speed = 200, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },

	},

	SwarmerMeleeElite =
	{
		StartingWeapon = false,

		AIData =
		{
			DeepInheritance = true,

			FireTicks = 2,
			FireCooldown = 0.5,
			ResetTargetPerTick = true,
			AIAngleTowardsPlayerWhileFiring = true,
		},

		--HitScreenshake = { Distance = 2, Speed = 200, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },

	},

	SwarmerMeleeSuperElite =
	{
		StartingWeapon = false,

		--HitScreenshake = { Distance = 2, Speed = 200, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },

	},

	SwarmerHelmetedMelee =
	{
		StartingWeapon = false,

		AIData =
		{
			DeepInheritance = true,

			PostAttackCooldown = 1.0,

			PreFireDuration = 0.3,
			AIFireTicksMin = 3,
			AIFireTicksMax = 5,
			FireCooldownMin = 0.2,
			FireCooldownMax = 0.5,
			ResetTargetPerTick = true,
			AIAngleTowardsPlayerWhileFiring = true,
		},

		--HitScreenshake = { Distance = 2, Speed = 200, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },

	},

	HeavyRangedWeapon =
	{
		StartingWeapon = false,
		RapidDamageType = true,

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		Upgrades = { },

		CauseImpactReaction = false,
		ImpactReactionHitsOverride = 0.1,
	},
	HeavyRangedWeaponFork =
	{
		InheritFrom = { "HeavyRangedWeapon", },
	},
	HeavyRangedWeaponForkElite =
	{
		InheritFrom = { "HeavyRangedWeapon", },
	},
	HeavyRangedWeaponForkMiniboss =
	{
		InheritFrom = { "HeavyRangedWeapon", },
	},
	SeekingShotWeapon =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	SpreadShotWeapon =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},


	SplitShotWeapon =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	SplitShotWeaponElite =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	SpreadShotMinibossRadial =
	{
		StartingWeapon = false,

		AIData =
		{
			AIFireTicksMin = 3,
			AIFireTicksMax = 5,
			FireCooldown = 1.35,

			PreAttackDuration = 0.5,
			PostAttackDuration = 0.5,
			PostAttackCooldown = 1.5,
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	SpreadShotMinibossCone =
	{
		StartingWeapon = false,

		AIData =
		{
			AIFireTicksMin = 5,
			AIFireTicksMax = 7,
			FireCooldown = 0.375,

			PreAttackDuration = 0.5,
			PostAttackDuration = 0.5,
			PostAttackCooldown = 1.5,
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	SpreadShotMinibossCross =
	{
		StartingWeapon = false,

		AIData =
		{
			AIFireTicksMin = 8,
			AIFireTicksMax = 14,
			FireCooldown = 0.3,

			PreAttackDuration = 0.5,
			PostAttackDuration = 0.5,
			PostAttackCooldown = 1.5,
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	SpreadShotMinibossInvulnerableLine =
	{
		StartingWeapon = false,

		AIData =
		{
			AIFireTicksMin = 1,
			AIFireTicksMax = 1,
			FireCooldown = 0.4,

			ResetTargetPerTick = true,
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackDuration = 0.5,
			PostAttackDuration = 0.5,
			PostAttackCooldown = 1.5,
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	SpreadShotMinibossInvulnerableCone =
	{
		StartingWeapon = false,

		AIData =
		{
			AIFireTicksMin = 1,
			AIFireTicksMax = 1,
			FireCooldown = 0.75,

			ResetTargetPerTick = true,
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackDuration = 0.5,
			PostAttackDuration = 0.5,
			PostAttackCooldown = 1.5,
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	SpreadShotMinibossInvulnerableCross =
	{
		StartingWeapon = false,

		AIData =
		{
			AIFireTicksMin = 1,
			AIFireTicksMax = 1,
			FireCooldown = 0.75,

			ResetTargetPerTick = true,
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackDuration = 0.5,
			PostAttackDuration = 0.5,
			PostAttackCooldown = 1.5,
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	ExplosiveBlast =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	BlastCubeExplosion =
	{
		ImpactReactionHitsOverride = 5,
	},

	BlastCubeExplosionElysium =
	{
		ImpactReactionHitsOverride = 5,
	},

	ShadeNakedEliteTrapDeath =
	{
		ImpactReactionHitsOverride = 5,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	BloodMineBlast =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.1, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	GrenadierWeapon =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },

		Sounds =
		{
			FireSounds =
			{
				--{ Name = "/SFX/Enemy Sounds/ImpulseMineLayer/ImpulseMineLobWhoosh" },
			},
		},
	},

	HeavyAssaultMelee =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	HeavyAssaultRangedAttack =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
		Upgrades = { },
	},

	ShieldAllies =
	{
		Sounds =
		{
			ImpactSounds =
			{
				Bone = "/Leftovers/SFX/PositiveTalismanProc_1",
				Brick = "/Leftovers/SFX/PositiveTalismanProc_1",
				Organic = "/Leftovers/SFX/PositiveTalismanProc_1",
			},
		},
	},


	ShieldRangedSelfDestruct =
	{
		AIData =
		{
			PreAttackStartDuration = 0.3,
			PreAttackEndDuration = 2.0,
			PreAttackEndShake = true,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,

		},
	},

	FreezeTrapWeapon =
	{

	},

	FreezeShotWeapon =
	{
		ImpactReactionHitsOverride = 0,

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Spitter/EmoteAttacking" },
			},
		},
	},

	HitAndRunMelee =
	{
		ImpactReactionHitsOverride = 0,

		AIData =
		{
			MaxPlayerDistance = 480,
			ForceWithinPlayerDistance = 300,
			MinAttacksBetweenUse = 1,

			PreAttackDuration = 0.2,
			PreAttackEndDuration = 1.2,
			PreAttackEndShake = true,
			PostAttackDuration = 1.1,
			AIAttackDistance = 250,
			AIBufferDistance = 200,
			AIMoveWithinRangeTimeout = 2.0,
		}
	},

	FreezeShotSpray =
	{
		ImpactReactionHitsOverride = 0,

		AIData =
		{
			PreAttackDuration = 0.5,
			PostAttackDuration = 0.2,
			PreAttackEndShake = true,

			AIAttackDistance = 550,
			AIAngleTowardsPlayerWhileFiring = true,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 80,

			AIFireTicksMin = 5,
			AIFireTicksMax = 5,
			AIFireTicksCooldown = 0.3,
		}
	},

	FreezeShotSpread =
	{
		ImpactReactionHitsOverride = 0,

		AIData =
		{
			PreAttackDuration = 0.5,
			PostAttackDuration = 0.2,
			PreAttackEndShake = true,

			AIAttackDistance = 600,
			AIAngleTowardsPlayerWhileFiring = false,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 80,
		}
	},

	DusaFreezeShotSpray =
	{
		ImpactReactionHitsOverride = 0,

		AIData =
		{
			PreAttackDuration = 0.5,
			FireDuration = 0.3,
			PostAttackDuration = 0.2,
			PreAttackEndShake = true,

			AIAttackDistance = 650,
			AIAngleTowardsPlayerWhileFiring = true,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 80,

			AIFireTicksMin = 5,
			AIFireTicksMax = 5,
			AIFireTicksCooldown = 0.3,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Dusa_EmoteHissing" },
			},
		},
	},

	DusaFreezeShotSpread =
	{
		ImpactReactionHitsOverride = 0,

		AIData =
		{
			PreAttackDuration = 0.5,
			FireDuration = 0.3,
			PostAttackDuration = 0.2,
			PreAttackEndShake = true,

			AIAttackDistance = 700,
			AIAngleTowardsPlayerWhileFiring = true,
			AIRequireProjectileLineOfSight = true,
			AILineOfSightBuffer = 80,
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Dusa_EmoteAttacking" },
			},
		},
	},

	FreezeShot360 =
	{
		ImpactReactionHitsOverride = 0,

		AIData =
		{
			MinAttacksBetweenUse = 1,

			PreAttackDuration = 0.5,
			PostAttackDuration = 1.6,
			PreAttackEndShake = true,

			AIAttackDistance = 600,
			AIAngleTowardsPlayerWhileFiring = false,
		}
	},

	HitAndRunLob =
	{
		AIData =
		{
			PreAttackDuration = 0.5,
			PostAttackDuration = 3.1,
			PreAttackEndShake = true,

			AIAttackDistance = 680,
			AIBufferDistance = 300,
			AIMoveWithinRangeTimeout = 2.2,
			AIAngleTowardsPlayerWhileFiring = true,

			AIFireTicksMin = 8,
			AIFireTicksMax = 10,
			AIFireTicksCooldown = 0.1,
		}
	},
	ChillRetaliate =
	{
		OnHitFunctionNames = { "MaxChillOnTarget", },
	},
	LavaTileWeapon =
	{
		RapidDamageType = true,
		CauseLeap = true,
		IgnoreInvulnerabilityFrameTrigger = true,
		PresentationOnlyOnPlayerHit = true,
		OnHitFunctionNames = { "CheckLavaPresentation", },

		CancelArmorSpark = true,
		CancelVulnerabilitySpark = true,
		CancelRumble = true,
		CancelHitSpark = true,
	},
	LavaTileTriangle01Weapon =
	{
		InheritFrom = { "LavaTileWeapon", },
	},
	LavaTileTriangle02Weapon =
	{
		InheritFrom = { "LavaTileWeapon", },
	},
	LavaSplash =
	{
		RapidDamageType = true,
		IgnoreInvulnerabilityFrameTrigger = true,
		PresentationOnlyOnPlayerHit = true,
		OnHitFunctionNames = { "CheckLavaSplashPresentation", }
	},
	EliteLavaSplash =
	{
		InheritFrom = { "LavaSplash" },

		AIData =
		{
			DeepInheritance = true,

			FireTicks = 1,
			FireCooldown = 0.0,
			FireIntervalMin = 5.0,
			FireIntervalMax = 7.5,
		},
	},
	EliteVacuum =
	{
		AIData =
		{
			FireTicks = 1,
			FireCooldown = 0.0,
			FireInterval = 3.0,

			TargetSelf = true,
		},
	},

	-- Environmental Weapons
	DartTrapWeapon =
	{
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/SwordWallHitClankSmall",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
			},
		},
	},

	SawTrapWeapon =
	{
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/MetalBoneSmash",
				Brick = "/SFX/MetalStoneClang",
				Stone = "/SFX/MetalStoneClang",
				Organic = "/SFX/StabSplatterSmall",
				StoneObstacle = "/SFX/SwordWallHitClank",
				BrickObstacle = "/SFX/SwordWallHitClank",
				MetalObstacle = "/SFX/SwordWallHitClank",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},

	ArcherTrapWeapon =
	{
		PresentationOnlyOnPlayerHit = true,
		HitScreenshake = { Distance = 6, Speed = 1000, Duration = 0.15, FalloffSpeed = 3000 },
		HitSimSlowCooldown = 1.0,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/ArrowWallHitClankSmall",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/SwordWallHitClankSmall",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/ArrowImpactSplatter",
			},
		},		
	},

	RatPoisonShake =
	{
		AIData =
		{
			PreAttackAnimation = "EnemyRatThugShake_Start",
			FireAnimation="EnemyRatThugShake_Loop",
			PostAttackAnimation = "EnemyRatThugShake_ReturnToIdle",
			PreAttackDuration = 0.4,
			FireDuration = 0.8,
			PostAttackDuration = 0.4,
			AIAttackDistance = 9999,
			SkipMovement = true,
			SkipAngleTowardTarget = true,
			AIFireTicksMin = 4,
			AIFireTicksMax = 6,
			AIFireTicksCooldown	 = 0.1,

			MinAttacksBetweenUse = 1,
		},

	},

	RatPoisonShakeMiniboss =
	{
		InheritFrom = { "RatThugPoisonShake" },
		AIData =
		{
			PreAttackAnimation = "EnemyRatThugShake_Start",
			FireAnimation="EnemyRatThugShake_Loop",
			PostAttackAnimation = "EnemyRatThugShake_ReturnToIdle",
			PreAttackDuration = 0.4,
			FireDuration = 0.8,
			PostAttackDuration = 0.4,
			AIAttackDistance = 9999,
			SkipMovement = true,
			SkipAngleTowardTarget = true,
			AIFireTicksMin = 25,
			AIFireTicksMax = 35,
			AIFireTicksCooldown	 = 0.05,

			MinAttacksBetweenUse = 1,
		},

	},

	RatSummon =
	{
		StartingWeapon = false,

		AIData =
		{
			FireFunctionName = "HandleBossSpawns",
			PreAttackAnimation = "EnemyRatThugShake_Start",
			FireAnimation="EnemyRatThugShake_Loop",
			PostAttackAnimation = "EnemyRatThugAttackBite_Fire",
			PreAttackDuration = 0.3,
			FireDuration = 0.8,
			PostAttackDuration = 0.5,
			AIAttackDistance = 700,
			AIBufferDistance = 700,
			FireCooldown = 0,

			MaxActiveSpawns = 10,
			MinAttacksBetweenUse = 3,

			SpawnRadius = 450,
			SpawnInterval = 0.1,
			SpawnCount = 10,
			SpawnOptions =
			{
				"Crawler",
			},
		},
	},

	CharonRadialPush =
	{
		StartingWeapon = false,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			ForceUseIfReady = true,
			MinAttacksBetweenUse = 5,
			MaxPlayerDistance = 400,

			SkipMovement = true,
			SkipAngleTowardTarget = true,

			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackAnimation = "CharonRadialPush_PreAttack",
			PreAttackDuration = 0.6,
			FireAnimation = "CharonRadialPush_Attack",
			FireDuration = 0.4,
			PostAttackAnimation = "CharonRadialPush_ReturnToIdle",
			PostAttackDuration = 0.9,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charon/EmotePowerAttacking" },
				{ Name = "/SFX/Enemy Sounds/Charon/CharonRadialBlast" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	CharonGhostChargeLeft =
	{
		StartingWeapon = false,
		GenusName = "CharonGhostCharge",

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 0.2, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			DeepInheritance = true,

			MoveToId = 490806,
			TargetId = 40191,
			MoveSuccessDistance = 32,
			AIAttackDistance = 50,

			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,

			FireFunctionName = "CharonGhostCharge",
			FireFunctionArgs = {
				FireFromIds = {
					[1] = 490940,
					[2] = 490941,
					[3] = 490943,
					[4] = 490942,
					[5] = 490949,
					[6] = 490948,
				},
				FireInterval = 0.05,
			},

			PreAttackAnimation = "CharonGhostCharge_PreAttack",
			PreAttackDuration = 1.0,
			FireDuration = 0.5,
			FireAnimation = "CharonGhostCharge_Attack",
			--PostAttackAnimation = "CharonGhostCharge_ReturnToIdle",
			PostAttackDuration = 0.89,

			MaxConsecutiveUses = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/Charon_0026" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	CharonGhostChargeRight =
	{
		InheritFrom = { "CharonGhostChargeLeft" },
		GenusName = "CharonGhostCharge",

		AIData =
		{
			DeepInheritance = true,
			MoveToId = 40191,
			TargetId = 490806,

			FireFunctionName = "CharonGhostCharge",
			FireFunctionArgs = {
				FireFromIds = {
					[1] = 490955,
					[2] = 490954,
					[3] = 490953,
					[4] = 490952,
					[5] = 490951,
					[6] = 490950,
				},
				FireInterval = 0.05,
			},
		},
	},

	CharonGhostChargeTopAndBot =
	{
		StartingWeapon = false,
		GenusName = "CharonGhostCharge",

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			DeepInheritance = true,

			MoveToId = 490857,
			TargetId = 490856,
			MoveSuccessDistance = 32,
			AIAttackDistance = 50,

			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,

			AIAngleTowardsPlayerWhileFiring = false,

			FireFunctionName = "CharonGhostCharge",
			FireFunctionArgs = {
				FireFromIds = {
					[1] = 490939,
					[2] = 490930,
					[3] = 490937,
					[4] = 490928,
					[5] = 490935,
					[6] = 490926,
					[7] = 490933,
					[8] = 490925,
				},
				FireInterval = 0.1,
			},

			PreAttackAnimation = "CharonGhostCharge_PreAttack",
			PreAttackDuration = 1.0,
			FireAnimation = "CharonGhostCharge_Attack",
			FireDuration = 0.5,
			--PostAttackAnimation = "CharonGhostCharge_ReturnToIdle",
			PostAttackDuration = 0.89,

			MaxConsecutiveUses = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/Charon_0026" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	CharonGhostChargeLeftAndRight =
	{
		StartingWeapon = false,
		GenusName = "CharonGhostCharge",

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			DeepInheritance = true,

			MoveToId = 490857,
			TargetId = 490856,
			MoveSuccessDistance = 32,
			AIAttackDistance = 50,

			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,

			AIAngleTowardsPlayerWhileFiring = false,

			FireFunctionName = "CharonGhostCharge",
			FireFunctionArgs = {
				FireFromIds = {
					[1] = 490940,
					[2] = 490955,
					[3] = 490941,
					[4] = 490954,
					[5] = 490943,
					[6] = 490953,
					[7] = 490942,
					[8] = 490952,
					[9] = 490949,
					[10] = 490951,
					[11] = 490948,
					[12] = 490950,
				},
				FireInterval = 0.1,
			},

			PreAttackAnimation = "CharonGhostCharge_PreAttack",
			PreAttackDuration = 1.0,
			FireAnimation = "CharonGhostCharge_Attack",
			FireDuration = 0.5,
			--PostAttackAnimation = "CharonGhostCharge_ReturnToIdle",
			PostAttackDuration = 0.89,

			MaxConsecutiveUses = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/Charon_0026" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	CharonGhostCharge360 =
	{
		StartingWeapon = false,
		GenusName = "CharonGhostCharge",

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			DeepInheritance = true,

			MoveToId = 490857,
			TargetId = 490856,
			MoveSuccessDistance = 32,
			AIAttackDistance = 50,

			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,

			AIAngleTowardsPlayerWhileFiring = false,

			FireFunctionName = "CharonGhostCharge",
			FireFunctionArgs = {
				FireFromIds = {
					[1] = 490950,
					[2] = 490951,
					[3] = 490952,
					[4] = 490953,
					[5] = 490954,
					[6] = 490955,

					[7] = 490924,
					[8] = 490925,
					[9] = 490927,
					[10] = 490926,
					[11] = 490929,
					[12] = 490928,
					[13] = 490931,
					[14] = 490930,

					[15] = 490940,
					[16] = 490941,
					[17] = 490943,
					[18] = 490942,
					[19] = 490949,
					[20] = 490948,

					[21] = 490932,
					[22] = 490933,
					[23] = 490934,
					[24] = 490935,
					[25] = 490936,
					[26] = 490937,
					[27] = 490938,
					[28] = 490939,
				},
				FireInterval = 0.1,
			},

			PreAttackAnimation = "CharonGhostCharge_PreAttack",
			PreAttackDuration = 1.0,
			FireAnimation = "CharonGhostCharge_Attack",
			FireDuration = 0.5,
			--PostAttackAnimation = "CharonGhostCharge_ReturnToIdle",
			PostAttackDuration = 0.89,

			MaxConsecutiveUses = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/VO/Charon_0026" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	CharonSpawns =
	{
		StartingWeapon = false,

		AIData =
		{
			FireFunctionName = "HandleBossSpawns",
			FireAnimation = "CharonTaunt",
			PostAttackAnimation = "Charon_IdleBattle",
			PreAttackDuration = 0.0,
			FireDuration = 0.5,
			PostAttackDuration = 1.0,
			AIAttackDistance = 9999,
			AIBufferDistance = 9999,
			FireCooldown = 0,

			MaxActiveSpawns = 5,
			MinAttacksBetweenUse = 10,
			ForceUseIfReady = true,
			SpawnAggroed = true,

			SpawnRadius = 950,
			SpawnInterval = 0.1,
			SpawnCount = 6,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
				{ Name = "/SFX/Enemy Sounds/Charon/EmotePowerAttacking" },
			},
		},

		Upgrades = { },
	},

	CharonMeleeCombo1 =
	{
		GenusName = "CharonMelee",
		AIData =
		{
			AIAttackDistance = 330,
			AIBufferDistance = 300,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			SkipFireWeapon = true,

			MaxConsecutiveUses = 3,
		},

		WeaponCombo =
		{
			[1] = "CharonMeleeRight",
			[2] = "CharonMeleeLeft",
			[3] = "CharonMeleeRight",
			[4] = "CharonMeleeLeft",
			[5] = "CharonMeleeRight",
			[6] = "CharonMeleeLeft",
			[7] = "CharonMeleeStraight"
		},
	},

	CharonMeleeCombo2 =
	{
		GenusName = "CharonMelee",
		AIData =
		{
			AIAttackDistance = 330,
			AIBufferDistance = 300,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			SkipFireWeapon = true,

			MaxConsecutiveUses = 3,
		},

		WeaponCombo =
		{
			[1] = "CharonMeleeRight",
			[2] = "CharonMeleeLeft",
			--[3] = "CharonMeleeStraight"
		},
	},

	CharonMeleeLeft =
	{
		StartingWeapon = false,
		GenusName = "CharonMelee",

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},

		AIData =
		{
			SkipMovement = true,
			SkipAngleTowardTarget = false,

			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = false,

			PreAttackAnimation = "CharonMeleeFront_PreAttackLeft",
			PreAttackDuration = 0.4,
			PreAttackEndMinWaitTime = 0.25,
			FireDuration = 0.33,
			FireAnimation = "CharonMeleeFront_AttackLeftToRight",
			--PostAttackAnimation = "CharonMeleeFront_ReturnToIdleRight",
			PostAttackDuration = 0.9,

			--MaxConsecutiveUses = 10,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charon/CharonBigSwipe2" },
				{ Name = "/SFX/Enemy Sounds/Charon/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },

		Upgrades = { },
	},

	CharonMeleeRight =
	{
		InheritFrom = { "CharonMeleeLeft" },
		GenusName = "CharonMelee",

		AIData =
		{
			SkipMovement = true,
			SkipAngleTowardTarget = false,

			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = false,

			PreAttackAnimation = "CharonMeleeFront_PreAttackRight",
			PreAttackDuration = 0.38,
			PreAttackEndMinWaitTime = 0.25,
			FireAnimation = "CharonMeleeFront_AttackRightToLeft",
			FireDuration = 0.33,
			--PostAttackAnimation = "CharonMeleeFront_ReturnToIdleLeft",
			PostAttackDuration = 0.0,

			--MaxConsecutiveUses = 3,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charon/CharonBigSwipe2" },
				{ Name = "/SFX/Enemy Sounds/Charon/EmoteCasting" },
			},
		},

	},

	CharonMeleeBack =
	{
		InheritFrom = { "CharonMeleeLeft" },
		GenusName = "CharonMelee",

		AIData =
		{
			SkipMovement = true,
			SkipAngleTowardTarget = true,

			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = true,

			PreAttackAnimation = "CharonMeleeBackSwing_PreAttack",
			PreAttackDuration = 0.8,
			FireDuration = 0.6,
			FireAnimation = "CharonMeleeBackSwing_Attack",
			PostAttackAnimation = "CharonMeleeBackSwing_ReturnToIdle",
			PostAttackDuration = 0.0,

			MinAttacksBetweenUse = 3,
			MaxPlayerDistance = 300,
		},
	},

	CharonMeleeStraight =
	{
		InheritFrom = { "CharonMeleeLeft" },
		GenusName = "CharonMelee",

		AIData =
		{
			SkipMovement = true,
			SkipAngleTowardTarget = true,

			AITrackTargetDuringCharge = true,
			AIAngleTowardsPlayerWhileFiring = false,

			PreAttackAnimation = "CharonCast_PreAttack",
			PreAttackDuration = 0.7,
			FireAnimation = "CharonCast_Attack",
			FireDuration = 0.6,
			PostAttackAnimation = "CharonCast_ReturnToIdle",
			PostAttackDuration = 0.5,

			DumbFireWeapons = { "CharonWaveStraight" },
		},

		Sounds =
		{
			FireSounds =
			{
				-- { Name = "/SFX/Enemy Sounds/Charon/EmoteCasting" },
				{ Name = "/SFX/Enemy Sounds/Charon/EmotePowerAttacking" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
			},
		},

	},

	CharonWaveStraight =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},

		ChainedOnly = true,
		CauseImpactReaction = true,
		ImpactReactionHitsOverride = 5,

		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			AIAttackDistance = 9999,
			AIAttackDistance = 9999,
			SkipMovement = true,
			SkipAngleTowardTarget = true,

			MaxConsecutiveUses = 3,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charon/CharonGroundBlastFire" },
				{ Name = "/VO/Charon_0005" },
			},
		},

		Upgrades = { },
	},

	EliteClones =
	{
		StartingWeapon = false,

		AIData =
		{
			FireFunctionName = "HandleBossSpawns",

			MaxActiveSpawns = 4,

			SpawnRadius = 950,
			SpawnInterval = 0.1,
			SpawnCount = 1,

			SpawnClones = true,
			CloneAlphaFraction = 0.35,
			SpawnAggroed = true,

			FireTicks = 1,
			FireCooldown = 0.0,
			FireInterval = 3.0,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.1, Fraction = 1.0, LerpTime = 0 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ElectricZapSmall" },
			},
		},

		Upgrades = { },
	},

	EliteBeams =
	{
		StartingWeapon = false,
		NoHitInvulnerableText = true,
		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0,
			},
		},

		AIData =
		{
			TargetFriends = true,
			TargetClosest = true,
			IgnoreTypes = { "CrusherUnit", "CrusherUnitElite", "CrusherUnitSuperElite" },

			PostAttackDuration = 3.0,
			AIAttackDistance = 1100,

			FireTicks = 1,
			FireCooldown = 0.0,
			FireInterval = 8.0,
		},


		StartingWeapon = false,
		RapidDamageType = true,
		SkipDamageTextIfNoDamage = true,
		SkipBlockPresentation = true,

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		Upgrades = { },

		CauseImpactReaction = false,
		ImpactReactionHitsOverride = 0.1,
	},

	HeavyRangedSplitterFragment =
	{
		InheritFrom = { "EliteBeams" },

		AIData =
		{
			TargetFriends = true,
			TargetClosest = true,

			FireTicks = 1,
			FireCooldown = 0.0,
			FireInterval = 8.0,
		},
	},

	BaseCollisionWeapon =
	{
		StartingWeapon = false,
		BlockWrathGain = true,

		FireScreenshake = { Distance = 3, Speed = 300, Duration = 0.15, FalloffSpeed = 3000 },

		HitSimSlowCooldown = 0.4,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.07 },
		},

		Upgrades = { },
		HitText = "BodySlamHit",
		KillText = "BodySlamHit",

		Sounds =
		{
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/Leftovers/World Sounds/PhysicalImpactPunch",
				Brick = "/Leftovers/World Sounds/PhysicalImpactPunch",
				Stone = "/Leftovers/World Sounds/PhysicalImpactPunch",
				Organic = "/Leftovers/World Sounds/PhysicalImpactPunch",
			},
		},
		OutgoingDamageModifiers =
		{
			{
				PlayerMultiplier = 0,
				Multiplicative = true
			}
		}
	},

	RubbleFall =
	{
		StartingWeapon = false,
		BlockWrathGain = true,

		FireScreenshake = { Distance = 3, Speed = 300, Duration = 0.15, FalloffSpeed = 3000 },

		HitSimSlowCooldown = 0.4,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.07 },
		},

		Upgrades = { },
		HitText = "RubbleSlamHit",
		KillText = "RubbleSlamKill",

		ImpactSounds =
		{
			Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
			Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
			Bone = "/SFX/ArrowMetalBoneSmash",
			Brick = "/SFX/ArrowMetalStoneClang",
			Stone = "/SFX/ArrowMetalStoneClang",
			Organic = "/SFX/ArrowImpactSplatter",
			StoneObstacle = "/SFX/ArrowWallHitClankSmall",
			BrickObstacle = "/SFX/ArrowWallHitClankSmall",
			MetalObstacle = "/SFX/ArrowWallHitClankSmall",
			BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
		},
		OnDestroyVoiceLines =
		{
			[1] = GlobalVoiceLines.RubbleKillVoiceLines,
		},
	},

	RubbleFallLarge =
	{
		InheritFrom = { "RubbleFall", },
		BlockWrathGain = true,

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.07 },
		},
	},


	RatDeathPuddle =
	{
	},
	SmokeTrapWeapon =
	{
		OnHitFunctionNames = { "HitBySmokeTrapWeaponPresentation",  }
	},
	EliteSmoke =
	{
		OnHitFunctionNames = { "HitBySmokeTrapWeaponPresentation",  },

		AIData =
		{
			FireTicks = 1,
			FireCooldown = 0.0,
			FireInterval = 5.0,
		},
	},
	PoisonTrapWeapon =
	{
	},
	WrathWeapon =
	{
		BlockWrathGain = true,
	},
	AthenaShoutWeapon =
	{
		InheritFrom = { "WrathWeapon", },
	},
	ArtemisShoutWeapon =
	{
		InheritFrom = { "WrathWeapon", },
		FireScreenshake = { Distance = 3, Speed = 300, Duration = 0.15, FalloffSpeed = 3000 },

		HitSimSlowCooldown = 0.4,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	ArtemisMaxShoutWeapon =
	{
		InheritFrom = { "WrathWeapon", },
	},
	LightningStrikeX =
	{
		InheritFrom = { "WrathWeapon", },
	},
	DionysusShoutWeapon =
	{
		InheritFrom = { "WrathWeapon", },
		ImpactReactionHitsOverride = 0.1,
	},
	AresSurgeWeapon =
	{
		InheritFrom = { "WrathWeapon", },

		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.1, RightFraction = 0.17, Duration = 1.5 },
		},
	},
	PoseidonSurfWeapon =
	{
		InheritFrom = { "WrathWeapon", },

		HitScreenshake = { Distance = 4, Speed = 1000, Duration = 0.10, FalloffSpeed = 3000 },

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.0, RightFraction = 0.3, Duration = 0.18 },
		},

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			--{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.00, LerpTime = 0.07 },
		},
	},
	AphroditeSuperCharm =
	{
		InheritFrom = { "WrathWeapon", },

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.0, RightFraction = 0.18, Duration = 0.18 },
		},
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0 },
		},
	},
	AphroditeMaxSuperCharm =
	{
		InheritFrom = { "WrathWeapon", },
		HitScreenshake = { Distance = 6, Speed = 1200, Duration = 0.18, FalloffSpeed = 3000 },
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.0, RightFraction = 0.30, Duration = 0.30 },
		},
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 0.2, LerpTime = 0 },
			{ ScreenPreWait = 0.20, Fraction = 1.0, LerpTime = 0 },
		},
	},
	AthenaShieldBlast =
	{
		BlockWrathGain = true,
	},

	PoseidonShoutWeapon =
	{
		BlockWrathGain = true,
	},

	AphroditeShoutWeapon =
	{
		BlockWrathGain = true,
	},

	AresShoutWeapon =
	{
		BlockWrathGain = true,
	},

	DionysusShoutWeapon =
	{
		BlockWrathGain = true,
	},

	ShadeDeathSpawn =
	{
		FiredHeroVoiceLines = "ShadeRespawnHintVoiceLines",
	},

	ShadeDeathSpawnElite =
	{
		FiredHeroVoiceLines = "ShadeRespawnHintVoiceLines",
	},
}

ProjectileData =
{
	NoShakeProjectile =
	{
		CancelCameraShake = true,
	},
	NoSlowFrameProjectile =
	{
		CancelSlowFrames = true,
		CancelVulnerabilitySpark = true,
	},
	BowSplitShot =
	{
		CancelArmorSpark = true,
		CancelUnitHitFlash = true,
	},
	ZeusColorProjectile =
	{
		DamageTextStartColor = Color.ZeusDamageLight,
		DamageTextColor = Color.ZeusDamage,
	},
	AphroditeColorProjectile =
	{
		DamageTextStartColor = Color.AphroditeDamageLight,
		DamageTextColor = Color.AphroditeDamage,
	},
	DionysusColorProjectile =
	{
		DamageTextStartColor = Color.DionysusDamageLight,
		DamageTextColor = Color.DionysusDamage,
	},
	AresColorProjectile =
	{
		DamageTextStartColor = Color.AresDamageLight,
		DamageTextColor = Color.AresDamage,
	},
	DemeterColorProjectile =
	{
		DamageTextStartColor = Color.DemeterDamageLight,
		DamageTextColor = Color.DemeterDamage,
	},
	PoseidonColorProjectile =
	{
		DamageTextStartColor = Color.PoseidonDamageLight,
		DamageTextColor = Color.PoseidonDamage,
	},
	ArtemisColorProjectile =
	{
		DamageTextStartColor = Color.ArtemisDamageLight,
		DamageTextColor = Color.ArtemisDamage,
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/ArrowMetalBoneSmash",
				Brick = "/SFX/ArrowMetalStoneClang",
				Stone = "/SFX/ArrowMetalStoneClang",
				Organic = "/SFX/GunBulletOrganicImpact",
				StoneObstacle = "/SFX/ArrowWallHitClankSmall",
				BrickObstacle = "/SFX/ArrowWallHitClankSmall",
				MetalObstacle = "/SFX/ArrowWallHitClankSmall",
				BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
			},
		},
	},
	AthenaColorProjectile =
	{
		DamageTextStartColor = Color.AthenaDamageLight,
		DamageTextColor = Color.AthenaDamage,
	},
	DeflectedProjectile =
	{
		InheritFrom = { "AthenaColorProjectile", },
	},
	RubbleColorProjectile =
	{
		DamageTextStartColor = Color.WallSlamDamageLight,
		DamageTextColor = Color.WallSlamDamage,
	},

	-- Base Player Weapons
	BowSplitShot =
	{
		DamagedFxStyle = "Rapid",
	},
	FistWeapon =
	{
		DamagedFxStyle = "Rapid",
	},
	FistWeapon2 =
	{
		DamagedFxStyle = "Rapid",
	},
	FistWeapon3 =
	{
		DamagedFxStyle = "Rapid",
	},
	FistWeapon4 =
	{
		DamagedFxStyle = "Rapid",
	},
	FistWeapon5 =
	{
		DamagedFxStyle = "Rapid",
	},
	GunWeapon =
	{
		DamagedFxStyle = "Rapid",
	},

	HydraHeal =
	{
		InheritFrom = { "NoSlowFrameProjectile", },
	},
	HealBeam =
	{
		InheritFrom = { "NoSlowFrameProjectile", },
	},
	ShieldBeam =
	{
		InheritFrom = { "NoSlowFrameProjectile", },
		NoHitInvulnerableText = true,
	},
	HeavyRangedWeapon =
	{
		InheritFrom = { "NoSlowFrameProjectile", },
	},
	HeavyRangedWeaponFork =
	{
		InheritFrom = { "NoSlowFrameProjectile", },
	},
	HeavyRangedWeaponForkMiniboss =
	{
		InheritFrom = { "NoSlowFrameProjectile", },
	},
	AresEnemyWeapon =
	{
		InheritFrom = { "NoSlowFrameProjectile", },
	},
	AphroditeEnemyWeapon =
	{
		InheritFrom = { "NoSlowFrameProjectile", },
	},
	LightningStrikeSecondary =
	{
		InheritFrom = { "ZeusColorProjectile", },
	},
	LightningStrikeX =
	{
		InheritFrom = { "ZeusColorProjectile", },
	},
	LightningStrikeRetaliate =
	{
		InheritFrom = { "ZeusColorProjectile", },
	},
	ZeusAttackBolt =
	{
		InheritFrom = { "ZeusColorProjectile", },
	},
	LightningStrikeCrit =
	{
		InheritFrom = { "ZeusColorProjectile", },
	},
	LightningStrikeImpact =
	{
		InheritFrom = { "ZeusColorProjectile", },
	},
	ChainLightning =
	{
		InheritFrom = { "ZeusColorProjectile", },
	},
	ZeusProjectile =
	{
		InheritFrom = { "NoSlowFrameProjectile", "ZeusColorProjectile" },
	},
	LightningSpark =
	{
		InheritFrom = { "NoSlowFrameProjectile", "ZeusColorProjectile" },
		NeverStore = true,
	},
	IceSpark =
	{
		InheritFrom = { "NoSlowFrameProjectile", "PoseidonColorProjectile" },
		NeverStore = true,

		RapidDamageType = true,
		CancelArmorSpark = true,
		CancelVulnerabilitySpark = true,
		CancelRumble = true,
		CancelHitSpark = true,
	},
	AphroditeProjectile =
	{
		InheritFrom = { "NoSlowFrameProjectile", "AphroditeColorProjectile" },

		StoreAmmoInLastHit = true,
	},
	AphroditeBeowulfProjectile =
	{
		InheritFrom = { "AphroditeProjectile" },
		StoreAmmoInLastHit = true,
	},
	AreaWeakenAphrodite =
	{
		InheritFrom = { "AphroditeColorProjectile" },
	},
	AphroditeMaxSuperCharm =
	{
		InheritFrom = { "AphroditeColorProjectile" },
	},
	DeathAreaWeakenAphrodite =
	{
		InheritFrom = { "AreaWeakenAphrodite" },
	},
	AphroditeSuperCharm =
	{
		InheritFrom = { "AphroditeColorProjectile" },
	},
	AresProjectile =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile", "AresColorProjectile" },
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/AresBladeSlice2",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/AresBladeSlice2",
				Brick = "/SFX/AresBladeSlice2",
				Stone = "/SFX/AresBladeSlice2",
				Organic = "/SFX/AresBladeSlice2",
				StoneObstacle = "/SFX/AresBladeSlice2",
				BrickObstacle = "/SFX/AresBladeSlice2",
				MetalObstacle = "/SFX/AresBladeSlice2",
				BushObstacle = "/SFX/AresBladeSlice2",
			},
		},
		CancelArmorSpark = true,
		CancelUnitHitFlash = true,
	},
	AresBeowulfProjectile =
	{
		InheritFrom = { "AresColorProjectile" },
		StoreAmmoInLastHit = true,
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/Player Sounds/AresDelayedDamageHit",
				Armored = "/SFX/Player Sounds/AresDelayedDamageHit",
				Bone = "/SFX/Player Sounds/AresDelayedDamageHit",
				Brick = "/SFX/Player Sounds/AresDelayedDamageHit",
				Stone = "/SFX/Player Sounds/AresDelayedDamageHit",
				Organic = "/SFX/Player Sounds/AresDelayedDamageHit",
				StoneObstacle = "/SFX/Player Sounds/AresDelayedDamageHit",
				BrickObstacle = "/SFX/Player Sounds/AresDelayedDamageHit",
				MetalObstacle = "/SFX/Player Sounds/AresDelayedDamageHit",
				BushObstacle = "/SFX/Player Sounds/AresDelayedDamageHit",
			},
		},
	},
	PoseidonAphroditeTouchWeapon =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
		CancelArmorSpark = true,
	},
	HermesProjectile =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},
	DionysusLobProjectile =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile", "DionysusColorProjectile" },
		NeverStore = true
	},
	DionysusField =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
		SpawnedProjectile = true,
	},
	DeathBallDash =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},
	AresRushProjectile =
	{
		InheritFrom = { "AresProjectile" },
	},
	AresInvisibleAoE =
	{
		InheritFrom = { "AresProjectile" },
	},
	PoseidonRushProjectile =
	{
		InheritFrom = { "PoseidonColorProjectile" },
		Sounds =
		{
			ImpactSounds =
			{
				Invulnerable = "/SFX/SwordWallHitClank",
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Brick = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Stone = "/SFX/Player Sounds/ZagreusBloodshotImpact",
				Organic = "/SFX/Player Sounds/ZagreusBloodshotImpact",
			},
		}
	},
	LightningDash =
	{
		InheritFrom = { "ZeusColorProjectile" },
		Sounds =
		{
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/ZeusLightningImpact",
				Brick = "/SFX/Player Sounds/ZeusLightningImpact",
				Stone = "/SFX/Player Sounds/ZeusLightningImpact",
				Organic = "/SFX/Player Sounds/ZeusLightningImpact",
			},
		}
	},
	LightningPerfectDash =
	{
		InheritFrom = { "LightningDash" },
	},
	ZeusDionysusCloudStrike =
	{
		InheritFrom = { "LightningDash" },
	},
	WaterBlastRam =
	{
		InheritFrom = { "PoseidonRushProjectile" },
	},
	AthenaRushProjectile =
	{
		InheritFrom = { "AthenaColorProjectile" },
		Sounds =
		{
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/AthenaDashImpact",
				Brick = "/SFX/Player Sounds/AthenaDashImpact",
				Stone = "/SFX/Player Sounds/AthenaDashImpact",
				Organic = "/SFX/Player Sounds/AthenaDashImpact",
				Invulnerable = "/SFX/SwordWallHitClank",
			},
		}
	},

	DemeterProjectile =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile", "NoShakeEffect", "DemeterColorProjectile" },
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelHitSpark = true,
		CancelUnitHitFlash = true,
		CancelVulnerabilitySpark = true,
	},
	DemeterRushProjectile =
	{
		Sounds =
		{
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/DemeterDashShardShatter",
				Brick = "/SFX/Player Sounds/DemeterDashShardShatter",
				Stone = "/SFX/Player Sounds/DemeterDashShardShatter",
				Organic = "/SFX/Player Sounds/DemeterDashShardShatter",
			},
		},
	},
	DemeterSuper =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile", "NoShakeEffect", "DemeterColorProjectile" },
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelHitSpark = true,
		CancelVulnerabilitySpark = true,
	},
	DemeterMaxSuper =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile", "NoShakeEffect", "DemeterColorProjectile" },
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelHitSpark = true,
		CancelVulnerabilitySpark = true,
	},
	MagicShieldRetaliate =
	{
		InheritFrom = { "AthenaRushProjectile" },
	},
	AphroditeRushProjectile =
	{
		InheritFrom = { "AphroditeColorProjectile" },
		Sounds =
		{
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/Player Sounds/AphroditeLoveImpact",
				Brick = "/SFX/Player Sounds/AphroditeLoveImpact",
				Stone = "/SFX/Player Sounds/AphroditeLoveImpact",
				Organic = "/SFX/Player Sounds/AphroditeLoveImpact",
			},
		}
	},
	DionysusDashProjectile =
	{
		InheritFrom = { "DionysusColorProjectile" },
		Sounds =
		{
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/BurnDamage",
				Brick = "/SFX/BurnDamage",
				Stone = "/SFX/BurnDamage",
				Organic = "/SFX/BurnDamage",
			},
		}
	},
	DionysusShoutProjectile =
	{
		InheritFrom = { "DionysusColorProjectile" },
		Sounds =
		{
			ImpactSounds =
			{
				Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
				Bone = "/SFX/BurnDamage",
				Brick = "/SFX/BurnDamage",
				Stone = "/SFX/BurnDamage",
				Organic = "/SFX/BurnDamage",
			},
		}
	},
	AphroditeInvisibleAoE =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},
	DionysusOnHit =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},
	ArtemisShoutWeapon =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},
	ThanatosWeapon2 =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},
	ApolloProjectile =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},
	DionysusDashField =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},
	AphroditeShoutWeapon =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},
	AresShoutWeapon =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},
	DionysusShoutField =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},
	DionysusContinuousField =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},
	DionysusDeathField =
	{
		InheritFrom = { "NoSlowFrameProjectile", "NoShakeProjectile" },
	},

	RangedWeapon =
	{
		AmmoDropKillForceMin = 900,
		AmmoDropKillForceMax = 950,
		AmmoDropKillUpwardForceMin = 300,
		AmmoDropKillUpwardForceMax = 300,
	},
	PoseidonProjectile =
	{
		InheritFrom = { "PoseidonColorProjectile" },

		AmmoDropForceMin = 100,
		AmmoDropForceMax = 200,
		AmmoDropUpwardForceMin = 1000,
		AmmoDropUpwardForceMax = 1000,

		AmmoDropKillForceMin = 900,
		AmmoDropKillForceMax = 950,
		AmmoDropKillUpwardForceMin = 300,
		AmmoDropKillUpwardForceMax = 300,
	},
	AthenaDeflectingProjectile =
	{
		InheritFrom = { "AthenaColorProjectile" },
		StoreAmmoInLastHit = true,
	},
	AthenaDeflectingBeowulfProjectile =
	{
		InheritFrom = { "AthenaDeflectingProjectile" },
	},
	ArtemisProjectile =
	{
		InheritFrom = { "ArtemisColorProjectile" },
	},
	ArtemisSuperProjectile =
	{
		InheritFrom = { "ArtemisColorProjectile" },
	},
	ArtemisLegendary =
	{
		InheritFrom = { "ArtemisColorProjectile" },
	},
	RubbleFall =
	{
		InheritFrom = { "RubbleColorProjectile" },
	},
	RubbleFallLarge =
	{
		InheritFrom = { "RubbleColorProjectile" },
	},
	RubbleFallElysium =
	{
		InheritFrom = { "RubbleColorProjectile" },
	},
	LavaTileWeapon =
	{
		IgnoreOnHitEffects = true,
		DamagedFx = "PlayerBurnDamage",
	},
	LavaTileTriangle01Weapon =
	{
		InheritFrom = { "LavaTileWeapon", },
	},
	LavaTileTriangle02Weapon =
	{
		InheritFrom = { "LavaTileWeapon", },
	},
	LavaPuddleLarge =
	{
		InheritFrom = { "LavaTileWeapon", },
	},
	ShadeDeathSpawn =
	{
		CarriesSpawns = true
	},
	ShadeDeathSpawnElite =
	{
		CarriesSpawns = true
	},
	NPC_Sisyphus_01_Assist =
	{
		DeathScreenShake = { Distance = 6, Speed = 300, FalloffSpeed = 4000, Duration = 0.25, Angle = 0 },
	},
	CharonMeleeArcLeft =
	{
		DamagedFx = "PlayerHitSparkCharonMelee",
	},
	CharonMeleeArcRight =
	{
		DamagedFx = "PlayerHitSparkCharonMelee",
	},
	CharonMeleeArcBack =
	{
		DamagedFx = "PlayerHitSparkCharonMelee",
	},
}

EffectData =
{
	NoShakeEffect =
	{
		CancelCameraShake = true,
	},
	NoSlowFrameEffect =
	{
		CancelSlowFrames = true,
	},
	BlockReloadEffect = 
	{
		BlockReload = true
	},
	DamageShare =
	{
		DamageTextStartColor = Color.RamaDamageStart,
		DamageTextColor = Color.RamaDamageEnd,
	},
	DelayedDamage =
	{
		InheritFrom = { "NoSlowFrameEffect", "NoShakeEffect"},
		DamageTextStartColor = Color.LightPink,
		DamageTextColor = Color.Red,
	},
	DamageOverTime =
	{
		InheritFrom = { "NoSlowFrameEffect", "NoShakeEffect"},
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelVulnerabilitySpark = true,
		CancelRumble = true,
		CancelHitSpark = true,
		CancelUnitHitFlash = true,
		DamageTextStartColor = Color.LightPurple,
		DamageTextColor = Color.Purple,
		DamageTextSize = 25,
		OnApplyFunctionName = "DamageOverTimeApply",
		OnClearFunctionName = "DamageOverTimeClear",
	},

	DamageOverDistance =
	{
		InheritFrom = { "NoSlowFrameEffect", "NoShakeEffect"},
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelHitSpark = true,
		CancelVulnerabilitySpark = true,
		CancelRumble = true,
		CancelUnitHitFlash = true,
		DamageTextStartColor = Color.LightCyan,
		DamageTextColor = Color.RoyalBlue,
		DamageTextSize = 25,
	},
	StyxPoison =
	{
		InheritFrom = { "NoSlowFrameEffect", "NoShakeEffect"},
		RapidDamageType = true,
		IgnoreOnHitEffects = true,
		IgnoreInvulnerabilityFrameTrigger = true,
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelHitSpark = true,
		CancelVulnerabilitySpark = true,
		CancelRumble = true,
		DamageTextSize = 25,
		NoRallyStore = true,
		OnApplyFunctionName = "StyxPoisonApply",
		OnClearFunctionName = "StyxPoisonClear",
	},
	ConsecrationDamage =
	{
		BlockDamageAnimation = true,
	},
	ConsecrationDamageOverTime =
	{
		InheritFrom = { "NoSlowFrameEffect", "NoShakeEffect"},
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelVulnerabilitySpark = true,
		CancelRumble = true,
		CancelHitSpark = true,
		DamageTextStartColor = Color.LightBlue,
		DamageTextColor = Color.LightBlue,
		DamageTextSize = 25,
	},
	LavaSlow =
	{
		OnApplyFunctionName = "LavaSlowApply",
		OnClearFunctionName = "LavaSlowClear",
	},
	ConsecrationDamageReduction =
	{
		OnApplyFunctionName = "ConsecrationDamageReductionApply",
		OnClearFunctionName = "ConsecrationDamageReductionClear",
	},
	AthenaBackstabVulnerability =
	{
		OnApplyFunctionName = "AthenaBackstabVulnerabilityApply",
		OnClearFunctionName = "AthenaBackstabVulnerabilityClear",
	},
	GrenadeSelfDamageOutput =
	{
		OnApplyFunctionName = "GrenadeSelfDamageOutputApply",
	},
	ManualReloadBonus =
	{
		OnApplyFunctionName = "ManualReloadBonusApply",
		OnClearFunctionName = "ManualReloadBonusClear",
	},
	
	MarkBondTarget =
	{
		OnApplyFunctionName = "MarkBondTargetApply",
		OnClearFunctionName = "MarkBondTargetClear",
	},
	MarkRuptureTargetApplicator =
	{
		OnApplyFunctionName = "OnRuptureDashHit",
	},
	PunchRuptureWeapon =
	{
		OnApplyFunctionName = "OnRuptureWeaponHit",
	},
	MarkRuptureTarget =
	{
		OnApplyFunctionName = "MarkRuptureTargetApply",
		OnClearFunctionName = "MarkRuptureTargetClear",
	},
	Charm =
	{
		OnApplyFunctionName = "CharmApply",
		OnClearFunctionName = "CharmClear",
	},
	HermesSlow =
	{
		OnApplyFunctionName = "HermesSlowApply",
		OnClearFunctionName = "HermesSlowClear",
	},
	DemeterSlow =
	{
		OnApplyFunctionName = "DemeterSlowApply",
		OnClearFunctionName = "DemeterSlowClear",
	},
	DemeterWorldChill =
	{
		DamageTextStartColor = Color.DemeterDamageLight,
		DamageTextColor = Color.DemeterDamage,
		OnApplyFunctionName = "HermesSlowApply",
		OnClearFunctionName = "HermesSlowClear",
		InheritFrom = { "NoSlowFrameEffect", "NoShakeEffect"},
		CancelArmorSpark = true,
		CancelArmorUnitShake = true,
		CancelUnitShake = true,
		CancelHitSpark = true,
		CancelVulnerabilitySpark = true,
		CancelRumble = true,
	},
	KillDamageBonus =
	{
		OnApplyFunctionName = "KillDamageBonusApply",
	},
	FistKillBonus =
	{
		OnApplyFunctionName = "FistKillBonusApply",
	},
	OnHitStun =
	{
		OnApplyFunctionName = "OnHitStunApply",
	},
	FreezeStun =
	{
		OnApplyFunctionName = "FreezeStunApply",
	},
	MarkTarget =
	{
		OnApplyFunctionName = "MarkTargetApply",
		OnClearFunctionName = "MarkTargetClear",
	},
	SpearRushBonus =
	{
		OnApplyFunctionName = "SpearRushBonusApply",
	},
	ShieldThrowDamageBonus =
	{
		OnApplyFunctionName = "ShieldThrowDamageBonusApply",
	},
	ShieldThrowProjectileBonus =
	{
		OnApplyFunctionName = "ShieldThrowProjectileBonusApply",
		OnClearFunctionName = "ShieldThrowProjectileBonusClear",
	},
	MarkTargetSpin =
	{
		OnApplyFunctionName = "MarkTargetSpinApply",
		OnClearFunctionName = "MarkTargetSpinClear",
	},
	ClearMarkTargetSpin =
	{
		OnApplyFunctionName = "ClearMarkTargetSpinApply",
	},
	AddHitShields =
	{
		OnApplyFunctionName = "EliteDeathAllyHitShields",
	},
	MarkTargetFist =
	{
		OnApplyFunctionName = "MarkTargetFistApply",
		OnClearFunctionName = "MarkTargetFistClear",
	},
	FistHeavyAttackTraitDefense =
	{
		OnApplyFunctionName = "AddSuperArmor",
		OnClearFunctionName = "ClearSuperArmor",
	},
	AspectHyperArmor =
	{
		OnApplyFunctionName = "AddSuperArmor",
		OnClearFunctionName = "ClearSuperArmor",
	},
	SpearWeaponSpinDefenseWeapon =
	{
		OnApplyFunctionName = "AddSuperArmor",
		OnClearFunctionName = "ClearSuperArmor",
	},
	OnHitStun =
	{
		BlockReload = true
	},
	HarpyLasso = 
	{
		BlockReload = true
	},
	ZagreusOnHitStun = 
	{
		BlockReload = true
	},
	GraspingHands = 
	{
		BlockReload = true
	},
}

GameData.WeaponEquipOrder =
{
	"RushWeapon",
	"RangedWeapon",
}

GameData.MissingPackages = ToLookup({
	"HermesUpgrade",
	"WeaponUpgrade",
	"StackUpgrade",
	"RushWeapon",
	"RangedWeapon",
	"GunWeapon",
	"FistWeapon",
})