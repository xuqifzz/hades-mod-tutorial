HeroData =
{
	DefaultHero =
	{
		DefaultWeapon = "SwordWeapon",
		MaxHealth = 50,
		MaxHealthMultiplier = 1,
		LastStands = {},
		UnusedWeaponThreshold = 3,
		DashManeuverTimeThreshold = 0.4,
		Super =
		{
			DamageDealtMultiplier = 0.01,		-- Percent of damage dealt to convert to wrath
			DamageTakenMultiplier = 60,		-- every 100% of max health taken charges your super by this much
			Active = false,
		},
		RallyHealth =
		{
			HitsDrainRallyHealthMultiplier = 0.5,	-- Whether getting hit changes the amount of rally health already stored. 0 = completely zero it out, 1 = keep all rally health.
			ConversionPercent = 1.0,		-- Percent of taken damage that can be rallied back from
			RallyDecayHold = 0.04,				-- Seconds rally health does not decay after a hit
			RallyDecayRateSeconds = 1.3,		-- How long after a hit rally health lasts
			Store = 0,						-- Data variable
			State = "Idle",					-- Data variable
		},
		GuaranteedCrit = {},
		GuaranteedCritWeapons = {},

		InvulnerableFrameThreshold = 0.25,
		InvulnerableFrameMinDamage = 10,
		InvulnerableFrameCumulativeDamageDuration = 0.6,
		InvulnerableFrameDuration = 1.3,
		PerfectDashHitDisableDuration = 0.3,

		TriggersOnDamageEffects = true,
		TriggersOnHitEffects = true,

		ComboThreshold = 12,

		CanBeFrozen = true,
		FreezeTimeReductionPerInput = 1.3,
		UnfreezeAnimation = "ZagreusIdle",

		AnimOffsetZ = 170,
		-- EmoteOffsetX = -80,
		-- EmoteOffsetY = -100,
		SpeechCooldownTime = 9,

		EasyModeDamageMultiplierBase = 0.8,
		EasyModeDamageMultiplierPerDeath = -0.02,
		EasyModeDamageMultiplierDeathCap = 30,

		MaxShrinePointThreshold = 20,
		MaxShrinePointThresholdHardMode = 25,
		HardModeForcedMetaUpgrades =
		{
			EnemyDamageShrineUpgrade = 1,
			EnemyCountShrineUpgrade = 1,
			EnemyHealthShrineUpgrade = 1,
			HealingReductionShrineUpgrade = 1,
			NoInvulnerabilityShrineUpgrade = 1,
		},
		HardModeStartingResources =
		{
			--MetaPoints = 2500,
			--Gems = 500,
			--LockKeys = 10,
		},

		TargetMetaRewardsRatio = 0.45,
		TargetMetaRewardsAdjustSpeed = 2.0,
		ShrinePointMetaPointBonusMultiplier = 0.02,

		SecretDoorCostBase = 20,
		SecretDoorCostDepthScalar = 0.2,

		LeaveRoomAmmoMangetismSpeed = 2000,

		DamagedSound = "/VO/ZagreusEmotes/EmoteHurt",
		ChokingSound = "/VO/ZagreusEmotes/EmoteChoking",
		FrozenSound = "VO/ZagreusEmotes/EmotePetrified",
		UnFrozenSound = "VO/ZagreusEmotes/EmoteUnpetrified",

		PlayerInjuredVoiceLineThreshold = 0.65,

		OnDeathShakeScreenSpeed = 250,
		OnDeathShakeScreenDistance = 5,
		OnDeathShakeScreenDuration = 0.25,
		OnDeathShakeScreenAngle = 90,

		DamagedAnimation = "ZagreusOnHit",
		DamagedFxStyles =
		{
			Default = "PlayerHitSpark",
		},
		InvulnerableHitFx = "PlayerArmorHitSpark",

		CanBeStyxPoisoned = true,
		CanStoreAmmo = true,

		FinalHitSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.00001, LerpTime = 0 },
			--{ ScreenPreWait = 0.80, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.6, Fraction = 1.0, LerpTime = 0.1 },
		},
		ShoutSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 1.20, Fraction = 1.0, LerpTime = 0.1 },
		},

		HeroHitRumbleParameters =
		{
			{ ScreenPreWait = 0.0, LeftFraction = 0.2, Duration = 0.2 },
		},

		HeroMajorHitRumbleParameters =
		{
			{ ScreenPreWait = 0.0, RightFraction = 0.4, Duration = 0.35 },
		},

		HeroFinalHitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.4, Duration = 0.6 },
			{ ScreenPreWait = 0.85, RightFraction = 0.4, Duration = 0.5 },
			{ ScreenPreWait = 2.45, LeftFraction = 0.4, Duration = 0.5 },
		},

		HeroSurfaceDeathRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.4, Duration = 0.8 },
			{ ScreenPreWait = 0.70, LeftFraction = 0.3, Duration = 0.4 },
			{ ScreenPreWait = 6.05, LeftFraction = 0.6, Duration = 0.5 },
			{ ScreenPreWait = 3.50, RightFraction = 0.12, Duration = 2.4 },
			--{ ScreenPreWait = 2.45, LeftFraction = 0.12, Duration = 3 },
		},

		EnemyMoneyDropBaseValue = 1.0,

		Weapons =
		{
			RushWeapon = true,
			RangedWeapon = true,
		},

		BoonData =
		{
			GameStateRequirements =
			{
				RequiredMinCompletedRuns = 2
			},
			ForceCommon = false,
			RareChance = 0.10,
			EpicChance = 0.05,
			LegendaryChance = 0.12,
			ReplaceChance = 0.1,
		},
		HermesData =
		{
			ForceCommon = false,
			RareChance = 0.06,
			EpicChance = 0.03,
			LegendaryChance = 0.01,
		},
		StackData =
		{
			ForceCommon = true,
			AllowRarityOverride = false,
		},
		WeaponData =
		{
			ForceCommon = true,
		},
		RushWeaponMaxRange = 400,
		HeroAlliedUnits =
		{
			NPC_Thanatos_Field_01 = true,
			DusaSummon = true,
			TrainingMeleeSummon = true,
		},
		AttachedAnimationName = "LaurelCindersSpawner",
		AttachedLightName = "LightCharacterEllipse01",
		AttachedLightScale = 1.2,
		AttachedLightColor = { 232, 131, 0, 255 },
		VoiceLineBufferTime = 9,
		LowHealthVoiceLineThreshold = 0.35,
		LowHealthVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			-- PlayOnceFromTableThisRun = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.25,
			CooldownTime = 100,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiresInRun = true,
			},

			-- I'm hurt.
			-- { Cue = "/VO/ZagreusField_0055" },
			-- Ungh got me.
			-- { Cue = "/VO/ZagreusField_0058" },
			-- My spirit's fading.
			-- { Cue = "/VO/ZagreusField_0065" },
			-- Not dead yet!
			-- { Cue = "/VO/ZagreusField_0294" },
			-- No no no!
			{ Cue = "/VO/ZagreusField_0293" },
			-- Got me good.
			{ Cue = "/VO/ZagreusField_0056b" },
			-- Damn this smarts.
			{ Cue = "/VO/ZagreusField_0057b", GameStateRequirements = { RequiredMaxHealthFraction = 0.25 }, },
			-- Can't take much more.
			{ Cue = "/VO/ZagreusField_0059", GameStateRequirements = { RequiredMaxHealthFraction = 0.25 }, },
			-- Ungh, damn it.
			{ Cue = "/VO/ZagreusField_0060" },
			-- OK that hurt.
			{ Cue = "/VO/ZagreusField_0061" },
			-- Oh this isn't good.
			{ Cue = "/VO/ZagreusField_0062", GameStateRequirements = { RequiredMaxHealthFraction = 0.25 }, },
			-- Am I dead or what?
			{ Cue = "/VO/ZagreusField_0064", GameStateRequirements = { RequiredMaxHealthFraction = 0.25, RequiredMaxLastStands = 0 }, },
			-- I'm fading!
			{ Cue = "/VO/ZagreusField_0289" },
			-- Not good!
			{ Cue = "/VO/ZagreusField_0291" },
			-- Dah...!
			{ Cue = "/VO/ZagreusField_0620" },
			-- Augh, ow.
			{ Cue = "/VO/ZagreusField_0621" },
			-- Why you...
			{ Cue = "/VO/ZagreusField_0622" },
			-- Not again.
			{ Cue = "/VO/ZagreusField_0623", GameStateRequirements = { RequiredMinCompletedRuns = 1, RequiredMaxHealthFraction = 0.25 }, },
			-- Not good.
			{ Cue = "/VO/ZagreusField_0624", GameStateRequirements = { RequiredMaxHealthFraction = 0.25 }, },
			-- Ow...
			{ Cue = "/VO/ZagreusField_0625" },
			-- Can't keep this up.
			{ Cue = "/VO/ZagreusField_0626", GameStateRequirements = { RequiredMaxHealthFraction = 0.25, RequiredMaxLastStands = 1 }, },
			-- Got to hang on.
			{ Cue = "/VO/ZagreusField_0627" },
			-- Ungh, no.
			{ Cue = "/VO/ZagreusField_0628" },
			-- Damn you.
			{ Cue = "/VO/ZagreusField_0629" },
			-- Left myself open.
			{ Cue = "/VO/ZagreusField_0630" },
		},
		HitInvulnerableVoiceLines =
		{
			PlayOnce = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.85,
			CooldownTime = 40,
			SuccessiveChanceToPlayAll = 0.33,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- No effect!
			{ Cue = "/VO/ZagreusField_1092" },
			-- Didn't work!
			{ Cue = "/VO/ZagreusField_1093" },
			-- Not a scratch!
			{ Cue = "/VO/ZagreusField_1094" },
			-- Protected!
			{ Cue = "/VO/ZagreusField_1095" },
		},
		Binks =
		{
			"ZagreusIdle_Bink",
			"ZagreusOnHit_Bink",
			"ZagreusStart_Bink",
			"ZagreusStop_Bink",
			"ZagreusRun_Bink",
			"ZagreusStun_Bink",
			"ZagreusInteractionFishing_Bink",
			"ZagreusInteractionFishingFail_Bink",
			"ZagreusWalk_Bink",
			"ZagreusWalkStop_Bink",
			"ZagreusHeroLanding_Bink",
			"ZagreusInteractEquip_Bink",
			"RoomTransition",
			"ZagreusDash_Bink",
			"ZagreusDashVFX_Bink",
		},
		WeaponBinks =
		{
			"ZagreusWrath_Bink",
		},
		LightBarColor = { 0, 0, 255, 255 }
	},
}
HeroVoiceLines =
{
	NotReadyVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.15,
		CooldownTime = 5,

		-- I'm out.
		{ Cue = "/VO/ZagreusField_0081", RequiredKillEnemiesNotFound = true, },
		-- I can't.
		{ Cue = "/VO/ZagreusField_0083", RequiredKillEnemiesNotFound = true, },
		-- I'm empty.
		{ Cue = "/VO/ZagreusField_0085", RequiredKillEnemiesNotFound = true, },
		-- Can't do that.
		{ Cue = "/VO/ZagreusField_0087", RequiredKillEnemiesNotFound = true, },
		-- Not now.
		{ Cue = "/VO/ZagreusField_0089", RequiredKillEnemiesNotFound = true, },
		-- Not yet.
		{ Cue = "/VO/ZagreusField_0238", RequiredKillEnemiesNotFound = true, },

		-- I'm out!
		{ Cue = "/VO/ZagreusField_0082", RequiredKillEnemiesFound = true, },
		-- I can't!
		{ Cue = "/VO/ZagreusField_0084", RequiredKillEnemiesFound = true, },
		-- I'm empty!
		{ Cue = "/VO/ZagreusField_0086", RequiredKillEnemiesFound = true, },
		-- Can't do that!
		{ Cue = "/VO/ZagreusField_0088", RequiredKillEnemiesFound = true, },
		-- Not now!
		{ Cue = "/VO/ZagreusField_0090", RequiredKillEnemiesFound = true, },
		-- Not yet!
		{ Cue = "/VO/ZagreusField_0239", RequiredKillEnemiesFound = true, },
	},

	InteractionBlockedVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			CooldownTime = 5,
			CooldownName = "InteractBlockedRecently",

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredFalseRooms = { "A_Reprieve01", "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },
				RequiredMaxHealthFraction = 0.3,
				RequiredKillEnemiesNotFound = true,
			},

			-- Are you serious?
			{ Cue = "/VO/ZagreusField_1058" },
			-- This can't be happening.
			{ Cue = "/VO/ZagreusField_1059" },
			-- Oh great.
			{ Cue = "/VO/ZagreusField_1060" },
			-- This is perfect.
			{ Cue = "/VO/ZagreusField_1061" },
			-- Wonderful.
			{ Cue = "/VO/ZagreusField_1062" },
			-- That's unfortunate.
			{ Cue = "/VO/ZagreusField_1063" },
			-- I am not amused.
			{ Cue = "/VO/ZagreusField_1064" },
			-- What, seriously?
			{ Cue = "/VO/ZagreusField_1065" },
			-- Oh come on.
			{ Cue = "/VO/ZagreusField_1066" },
			-- Ah really?
			{ Cue = "/VO/ZagreusField_1067" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			CooldownTime = 5,
			CooldownName = "InteractBlockedRecently",
			RequiredFalseRooms = { "A_Reprieve01", "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },

			-- I can't.
			{ Cue = "/VO/ZagreusField_0390", RequiredKillEnemiesNotFound = true, },
			-- Can't do that.
			{ Cue = "/VO/ZagreusField_0391", RequiredKillEnemiesNotFound = true, },
			-- It's no use.
			{ Cue = "/VO/ZagreusField_0392", RequiredKillEnemiesNotFound = true, },
			-- No use.
			{ Cue = "/VO/ZagreusField_0393", RequiredKillEnemiesNotFound = true, },
			-- No way.
			{ Cue = "/VO/ZagreusField_0394", RequiredKillEnemiesNotFound = true, },
			-- Not now.
			{ Cue = "/VO/ZagreusField_0395", RequiredKillEnemiesNotFound = true, },
			-- Not yet.
			{ Cue = "/VO/ZagreusField_0238", RequiredKillEnemiesNotFound = true, },

			-- I can't!
			{ Cue = "/VO/ZagreusField_0084", RequiredKillEnemiesFound = true, },
			-- Can't do that!
			{ Cue = "/VO/ZagreusField_0088", RequiredKillEnemiesFound = true, },
			-- Not now!
			{ Cue = "/VO/ZagreusField_0090", RequiredKillEnemiesFound = true, },
			-- Not yet!
			{ Cue = "/VO/ZagreusField_0239", RequiredKillEnemiesFound = true, },
			-- Got to fight!
			{ Cue = "/VO/ZagreusField_0246", RequiredKillEnemiesFound = true, },
		},
	},
	CannotSwitchKeepsakeVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 5,
		CooldownName = "InteractBlockedRecently",

		-- I can't.
		{ Cue = "/VO/ZagreusField_0390", RequiredKillEnemiesNotFound = true, },
		-- Can't do that.
		{ Cue = "/VO/ZagreusField_0391", RequiredKillEnemiesNotFound = true, },
		-- It's no use.
		{ Cue = "/VO/ZagreusField_0392", RequiredKillEnemiesNotFound = true, },
		-- No use.
		{ Cue = "/VO/ZagreusField_0393", RequiredKillEnemiesNotFound = true, },
		-- No way.
		{ Cue = "/VO/ZagreusField_0394", RequiredKillEnemiesNotFound = true, },
		-- Not now.
		{ Cue = "/VO/ZagreusField_0395", RequiredKillEnemiesNotFound = true, },
		-- Not yet.
		{ Cue = "/VO/ZagreusField_0238", RequiredKillEnemiesNotFound = true, },
		-- Ah really?
		{ Cue = "/VO/ZagreusField_1067" },
	},
	NotEnoughCurrencyVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 6,

		-- Can't afford that.
		{ Cue = "/VO/ZagreusField_0490" },
		-- Not enough coin.
		{ Cue = "/VO/ZagreusField_0491", RequiresInRun = true },
		-- I'm short of coin.
		{ Cue = "/VO/ZagreusField_0492", RequiresInRun = true },
		-- Can't buy that.
		{ Cue = "/VO/ZagreusField_0493" },
		-- Poor me.
		{ Cue = "/VO/ZagreusField_0494" },
		-- No way.
		{ Cue = "/VO/ZagreusField_0394" },
		-- I can't.
		{ Cue = "/VO/ZagreusField_0390" },

	},
	NotEnoughHealthVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 5,
		CooldownName = "InteractBlockedRecently",

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- Are you serious?
		{ Cue = "/VO/ZagreusField_1058" },
		-- Oh great.
		{ Cue = "/VO/ZagreusField_1060" },
		-- This is perfect.
		{ Cue = "/VO/ZagreusField_1061" },
		-- Wonderful.
		{ Cue = "/VO/ZagreusField_1062" },
		-- That's unfortunate.
		{ Cue = "/VO/ZagreusField_1063" },
		-- What, seriously?
		{ Cue = "/VO/ZagreusField_1065" },
		-- Oh come on.
		{ Cue = "/VO/ZagreusField_1066" },
		-- Ah really?
		{ Cue = "/VO/ZagreusField_1067" },
		-- No use.
		{ Cue = "/VO/ZagreusField_0393" },
		-- I'm in no shape.
		{ Cue = "/VO/ZagreusField_0207" },
		-- I'm too scratched up.
		{ Cue = "/VO/ZagreusField_0208" },
	},
	NotEnoughDarknessVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 6,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- I've no more Darkness.
		{ Cue = "/VO/ZagreusHome_0426" },
		-- I need more Darkness.
		{ Cue = "/VO/ZagreusHome_0427" },
		-- That's beyond my means.
		{ Cue = "/VO/ZagreusHome_0428" },
		-- I can't do that yet.
		{ Cue = "/VO/ZagreusHome_0429" },
		-- Can't afford that.
		{ Cue = "/VO/ZagreusField_0490" },
		-- No way.
		{ Cue = "/VO/ZagreusField_0394" },
		-- I can't.
		{ Cue = "/VO/ZagreusField_0390" },
	},
	MetaUpgradeAtMaxVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 12,

		-- I've mastered that.
		{ Cue = "/VO/ZagreusHome_0572" },
		-- Reached the limit.
		{ Cue = "/VO/ZagreusHome_0573" },
		-- Hit the limit.
		{ Cue = "/VO/ZagreusHome_0574" },
		-- Maxed out already.
		{ Cue = "/VO/ZagreusHome_0575" },
	},
	MetaUpgradeAtGlobalCapVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 12,

		-- Reached the limit.
		{ Cue = "/VO/ZagreusHome_0573" },
		-- Hit the limit.
		{ Cue = "/VO/ZagreusHome_0574" },
		-- Maxed out already.
		{ Cue = "/VO/ZagreusHome_0575" },
	},
	MetaUpgradeReachedCapVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 12,

		-- My power grows.
		{ Cue = "/VO/ZagreusHome_0423" },
		-- OK.
		{ Cue = "/VO/ZagreusHome_2105" },
	},
	InvalidInteractionVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 6,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- I can't.
		{ Cue = "/VO/ZagreusField_0390" },
		-- Can't do that.
		{ Cue = "/VO/ZagreusField_0391" },
		-- It's no use.
		{ Cue = "/VO/ZagreusField_0392" },
		-- No use.
		{ Cue = "/VO/ZagreusField_0393" },
		-- No good.
		{ Cue = "/VO/ZagreusHome_0430" },
		-- Not possible.
		{ Cue = "/VO/ZagreusHome_0431" },
		-- Nothing happened.
		{ Cue = "/VO/ZagreusHome_0432" },
		-- Didn't work.
		{ Cue = "/VO/ZagreusHome_0433" },
		-- Nothing.
		{ Cue = "/VO/ZagreusHome_0434" },
	},
	CannotPurchaseVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 10,

		-- Don't need that right now.
		{ Cue = "/VO/ZagreusField_1096" },
		-- I don't need that.
		{ Cue = "/VO/ZagreusField_1097" },
		-- No need for that.
		{ Cue = "/VO/ZagreusField_1098" },
		-- Should save my coin for something I need.
		{ Cue = "/VO/ZagreusField_1099" },
		-- I'm already full.
		{ Cue = "/VO/ZagreusField_1100" },
	},
	CannotGiftVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 10,

		-- I'd better try some other time.
		{ Cue = "/VO/ZagreusHome_0583" },
		-- They seem busy at the moment.
		{ Cue = "/VO/ZagreusHome_0584" },
		-- Doesn't seem like a good time.
		{ Cue = "/VO/ZagreusHome_0585" },
		-- They're in the middle of something.
		{ Cue = "/VO/ZagreusHome_0586" },
	},
	ExitBlockedByEnemiesVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.25,
			CooldownTime = 5,
			RequiredFalseBossPhase = 3,

			-- Not yet.
			{ Cue = "/VO/ZagreusField_0238", RequiredKillEnemiesNotFound = true, },
			-- Oh right.
			{ Cue = "/VO/ZagreusField_0250", PreLineWait = 0.55, RequiredKillEnemiesNotFound = true, },
			-- Forgot something.
			{ Cue = "/VO/ZagreusField_0251", RequiredKillEnemiesNotFound = true, },
			-- Still shut.
			{ Cue = "/VO/ZagreusField_0252", RequiredKillEnemiesNotFound = true, },
			-- Still shut?
			{ Cue = "/VO/ZagreusField_0253", RequiredKillEnemiesNotFound = true, },
			-- What now.
			{ Cue = "/VO/ZagreusField_0254", RequiredKillEnemiesNotFound = true, },
			-- What now?
			{ Cue = "/VO/ZagreusField_0255", RequiredKillEnemiesNotFound = true, },

			-- I can't!
			{ Cue = "/VO/ZagreusField_0084", RequiredKillEnemiesFound = true, },
			-- Can't do that!
			{ Cue = "/VO/ZagreusField_0088", RequiredKillEnemiesFound = true, },
			-- Not now!
			{ Cue = "/VO/ZagreusField_0090", RequiredKillEnemiesFound = true, },
			-- Can't escape!
			{ Cue = "/VO/ZagreusField_0244", RequiredKillEnemiesFound = true, },
			-- No escape!
			{ Cue = "/VO/ZagreusField_0245", RequiredKillEnemiesFound = true, },
			-- Got to fight!
			{ Cue = "/VO/ZagreusField_0246", RequiredKillEnemiesFound = true, },
			-- Stuck!
			{ Cue = "/VO/ZagreusField_0247", RequiredKillEnemiesFound = true, },
			-- No use!
			{ Cue = "/VO/ZagreusField_0248", RequiredKillEnemiesFound = true, },
			-- It's no use!
			{ Cue = "/VO/ZagreusField_0249", RequiredKillEnemiesFound = true, },
		},
		{
			ObjectType = "Hades",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				RequiredRoom = "D_Boss01",
				PlayOnceFromTableThisRun = true,
				RequiredKillEnemiesFound = true,
				TriggerCooldowns = { Name = "HadesAnyQuipSpeech" },
				RequiredFalseBossPhase = 3,

				-- You're not getting out of here.
				{ Cue = "/VO/HadesField_0183" },
				-- You're not leaving.
				{ Cue = "/VO/HadesField_0184" },
				-- I don't think so.
				{ Cue = "/VO/HadesField_0185" },
				-- I think not.
				{ Cue = "/VO/HadesField_0186" },
				-- You're not going anywhere.
				{ Cue = "/VO/HadesField_0187" },
				-- Did you really think you could just walk away?
				{ Cue = "/VO/HadesField_0188" },
			}
		}
	},
	GunWeaponNeedToReloadVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		ChanceToPlay = 0.05,
		RequiredFalseTrait = "GunInfiniteAmmoTrait",
		SuccessiveChanceToPlay = 0.33,
		RequiredFalseRooms = { "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },
		Cooldowns =
		{
			{ Name = "ZagreusAnyQuipSpeech" },
			{ Name = "ZagreusGunQuipVoiceLines", Time = 400 },
		},

		-- Got to reload.
		{ Cue = "/VO/ZagreusField_1281", RequiredKillEnemiesNotFound = true, },
		-- Got to reload...!
		{ Cue = "/VO/ZagreusField_1282", RequiredKillEnemiesFound = true, },
		-- Need to reload.
		{ Cue = "/VO/ZagreusField_1288", RequiredKillEnemiesNotFound = true, },
		-- Need to reload...!
		{ Cue = "/VO/ZagreusField_1289", RequiredKillEnemiesFound = true, },
		-- I have to reload.
		{ Cue = "/VO/ZagreusField_1290", RequiredKillEnemiesNotFound = true, },
		-- I have to reload...!
		{ Cue = "/VO/ZagreusField_1291", RequiredKillEnemiesFound = true, },
		-- Got to reload.
		{ Cue = "/VO/ZagreusField_1292", RequiredKillEnemiesNotFound = true, },
		-- Got to reload...!
		{ Cue = "/VO/ZagreusField_1293", RequiredKillEnemiesFound = true, },
		-- Have to rearm.
		{ Cue = "/VO/ZagreusField_1294", RequiredKillEnemiesNotFound = true, },
		-- Have to rearm...!
		{ Cue = "/VO/ZagreusField_1295", RequiredKillEnemiesFound = true, },
		-- Got to reload this thing.
		{ Cue = "/VO/ZagreusField_1296", RequiredKillEnemiesNotFound = true, },
		-- Got to reload this thing...!
		{ Cue = "/VO/ZagreusField_1297", RequiredKillEnemiesFound = true, },
		-- I'm out, got to reload.
		{ Cue = "/VO/ZagreusField_1300", RequiredKillEnemiesNotFound = true, },
		-- I'm out, got to reload...!
		{ Cue = "/VO/ZagreusField_1301", RequiredKillEnemiesFound = true, },
		-- Out of ammo.
		{ Cue = "/VO/ZagreusField_1302", RequiredKillEnemiesNotFound = true, },
		-- Out of ammo...!
		{ Cue = "/VO/ZagreusField_1303", RequiredKillEnemiesFound = true, },
		-- Chamber's empty.
		{ Cue = "/VO/ZagreusField_1304", RequiredKillEnemiesNotFound = true, },
		-- Chamber's empty...!
		{ Cue = "/VO/ZagreusField_1305", RequiredKillEnemiesFound = true, },
	},
	GunWeaponReloadingStartVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		ChanceToPlay = 0.075,
		RequiredFalseTrait = "GunInfiniteAmmoTrait",
		RequiredFalseRooms = { "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },
		Cooldowns =
		{
			{ Name = "ZagreusAnyQuipSpeech" },
			{ Name = "ZagreusGunQuipVoiceLines", Time = 300 },
		},

		-- Reloading.
		{ Cue = "/VO/ZagreusField_1270", RequiredKillEnemiesNotFound = true, },
		-- Reloading...!
		{ Cue = "/VO/ZagreusField_1271", RequiredKillEnemiesFound = true, },
		-- It's reloading.
		{ Cue = "/VO/ZagreusField_1272", RequiredKillEnemiesNotFound = true, },
		-- It's reloading...!
		{ Cue = "/VO/ZagreusField_1273", RequiredKillEnemiesFound = true, },
		-- Rearming.
		{ Cue = "/VO/ZagreusField_1274", RequiredKillEnemiesNotFound = true, },
		-- Rearming...!
		{ Cue = "/VO/ZagreusField_1275", RequiredKillEnemiesFound = true, },
	},
	GunWeaponReloadingInProgressVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		RequiredFalseTrait = "GunInfiniteAmmoTrait",
		RequiredFalseRooms = { "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },
		Cooldowns =
		{
			{ Name = "ZagreusAnyQuipSpeech" },
			{ Name = "ZagreusGunQuipVoiceLines", Time = 300 },
		},

		-- Come on.
		{ Cue = "/VO/ZagreusField_1276", RequiredKillEnemiesNotFound = true, },
		-- Come on...!
		{ Cue = "/VO/ZagreusField_1277", RequiredKillEnemiesFound = true, },
		-- Almost.
		{ Cue = "/VO/ZagreusField_1278", RequiredKillEnemiesNotFound = true, },
		-- Almost...!
		{ Cue = "/VO/ZagreusField_1279", RequiredKillEnemiesFound = true, },
		-- Need to wait.
		{ Cue = "/VO/ZagreusField_1280", RequiredKillEnemiesNotFound = true, },
		-- Anytime...!
		{ Cue = "/VO/ZagreusField_1283", RequiredKillEnemiesFound = true, },
		-- Need a moment...!
		{ Cue = "/VO/ZagreusField_1284", RequiredKillEnemiesFound = true, },
		-- Hurry...!
		{ Cue = "/VO/ZagreusField_1285", RequiredKillEnemiesFound = true, },
		-- Hurry up...!
		{ Cue = "/VO/ZagreusField_1286", RequiredKillEnemiesFound = true, },
		-- Recharge already...!
		{ Cue = "/VO/ZagreusField_1287", RequiredKillEnemiesFound = true, },
		-- Have to reload first.
		{ Cue = "/VO/ZagreusField_1298", RequiredKillEnemiesNotFound = true, },
		-- Have to reload first...!
		{ Cue = "/VO/ZagreusField_1299", RequiredKillEnemiesFound = true, },
	},
	GunWeaponReloadCompleteVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.15,
		ChanceToPlay = 0.15,
		
		Cooldowns =
		{
			{ Name = "ZagreusAnyQuipSpeech" },
			{ Name = "ZagreusGunQuipVoiceLines", Time = 300 },
		},

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			RequiredKillEnemiesFound = true,
			RequiredFalseRooms = { "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },
		},

		-- Nice.
		{ Cue = "/VO/ZagreusField_1308" },
		-- Heh.
		{ Cue = "/VO/ZagreusField_1309" },
		-- Hm.
		{ Cue = "/VO/ZagreusField_1310" },
		-- Hm!
		{ Cue = "/VO/ZagreusField_1311" },
		-- Ready.
		{ Cue = "/VO/ZagreusField_1312" },
		-- Ready!
		{ Cue = "/VO/ZagreusField_1313" },
		-- OK!
		{ Cue = "/VO/ZagreusField_1314" },
		-- Set.
		{ Cue = "/VO/ZagreusField_1315" },
		-- Right there.
		{ Cue = "/VO/ZagreusField_1316" },
		-- Rearmed.
		{ Cue = "/VO/ZagreusField_1317" },
		-- Yes.
		{ Cue = "/VO/ZagreusField_1318" },
		-- There we go.
		{ Cue = "/VO/ZagreusField_1319" },
		-- Good.
		{ Cue = "/VO/ZagreusField_1320" },
		-- Loaded up.
		{ Cue = "/VO/ZagreusField_1321" },
	},
	LoadingAmmoVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.2,
		SuccessiveChanceToPlay = 0.05,
		Cooldowns =
		{
			{ Name = "ZagreusLoadedAmmoSpeech", Time = 200 },
		},

		-- Hm.
		{ Cue = "/VO/ZagreusField_1310" },
		-- Ready.
		{ Cue = "/VO/ZagreusField_1312" },
		-- OK!
		{ Cue = "/VO/ZagreusField_1314", RequiredKillEnemiesFound = true },
		-- Set.
		{ Cue = "/VO/ZagreusField_1315" },
		-- Loaded up.
		{ Cue = "/VO/ZagreusField_1321" },
		-- Loaded.
		{ Cue = "/VO/ZagreusField_4483", RequiredKillEnemiesNotFound = true },
		-- Loaded!
		{ Cue = "/VO/ZagreusField_4484", RequiredKillEnemiesFound = true },
		-- Right.
		{ Cue = "/VO/ZagreusField_4485", RequiredKillEnemiesNotFound = true },
		-- It's in.
		{ Cue = "/VO/ZagreusField_4486", RequiredKillEnemiesFound = true },
		-- OK.
		-- { Cue = "/VO/ZagreusField_4487" },
		-- OK!
		{ Cue = "/VO/ZagreusField_4488", RequiredKillEnemiesFound = true },
	},
	ExitBlockedByHealthVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 7,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- I'm in no shape.
		{ Cue = "/VO/ZagreusField_0207" },
		-- I'm too scratched up.
		{ Cue = "/VO/ZagreusField_0208", RequiredFalseTraits = { "SpearSpinTravel" }, },
		-- Took a beating I guess.
		{ Cue = "/VO/ZagreusField_0209", RequiredFalseTraits = { "SpearSpinTravel" }, },
		-- Not letting me in.
		{ Cue = "/VO/ZagreusField_0210" },
		-- Seriously?
		{ Cue = "/VO/ZagreusField_0211" },
		-- Ahh heaven.
		-- { Cue = "/VO/ZagreusField_0212" },
	},
	FleeingEncounterVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- Got to go!
		{ Cue = "/VO/ZagreusField_2930" },
		-- I'll just be going!
		{ Cue = "/VO/ZagreusField_2931" },
		-- Well, see you!
		{ Cue = "/VO/ZagreusField_2932" },
		-- Oops I got to run!
		{ Cue = "/VO/ZagreusField_2933" },
		-- Bye-bye!
		{ Cue = "/VO/ZagreusField_2934" },
		-- Begging your pardon!
		{ Cue = "/VO/ZagreusField_2935" },
	},

	TheseusWrathReactionVoiceLines_F =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,
		PlayOnceFromTableThisRun = true,

		-- The gods are helping _him_?
		{ Cue = "/VO/ZagreusField_1807", RequiredFalseTextLines = { "PoseidonAboutTheseus02" } },
		-- Whose side is she on...
		{ Cue = "/VO/ZagreusField_1808", RequiredPlayed = { "/VO/ZagreusField_1807" } },
		-- Whose side is he on...
		-- { Cue = "/VO/ZagreusField_1809" },
		-- Oh, gods.
		{ Cue = "/VO/ZagreusField_1810", RequiredPlayed = { "/VO/ZagreusField_1807" } },
		-- I guess they're testing me!
		{ Cue = "/VO/ZagreusField_1811", RequiredPlayed = { "/VO/ZagreusField_1807" } },
	},
	TheseusWrathReactionVoiceLines_M =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.33,
		UsePlayerSource = true,
		PlayOnceFromTableThisRun = true,

		-- The gods are helping _him_?
		{ Cue = "/VO/ZagreusField_1807", RequiredFalseTextLines = { "PoseidonAboutTheseus02" } },
		-- Whose side is she on...
		-- { Cue = "/VO/ZagreusField_1808" },
		-- Whose side is he on...
		{ Cue = "/VO/ZagreusField_1809", RequiredPlayed = { "/VO/ZagreusField_1807" } },
		-- Oh, gods.
		{ Cue = "/VO/ZagreusField_1810", RequiredPlayed = { "/VO/ZagreusField_1807" } },
		-- I guess they're testing me!
		{ Cue = "/VO/ZagreusField_1811", RequiredPlayed = { "/VO/ZagreusField_1807" } },
	},

	SecretUnlockedVoiceLines =
	{
		{
			PreLineWait = 0.35,
			RequiredFalseTextLines = { "ChaosFirstPickUp" },

			-- So all I need to do is sacrifice some of my life essence to go in here?
			{ Cue = "/VO/ZagreusField_2870", Queue = "Interrupt" },
			-- Aaugh, don't see why not!
			{ Cue = "/VO/ZagreusField_2871", PreLineWait = 1.0 },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.35,
			RequiredTextLines = { "ChaosFirstPickUp" },

			-- Let me have it.
			{ Cue = "/VO/ZagreusField_0194", RequiredFalseTrait = "ChaosBoonTrait" },
			-- Going in.
			{ Cue = "/VO/ZagreusField_0195" },
			-- Hit me.
			{ Cue = "/VO/ZagreusField_0196", RequiredFalseTrait = "ChaosBoonTrait" },
			-- I can take it.
			{ Cue = "/VO/ZagreusField_0197", RequiredFalseTrait = "ChaosBoonTrait" },
			-- Might as well.
			{ Cue = "/VO/ZagreusField_0198" },
			-- All right.
			{ Cue = "/VO/ZagreusField_0199" },
			-- I bear the Cosmic Egg.
			{ Cue = "/VO/ZagreusField_1364", RequiredTrait = "ChaosBoonTrait" },
			-- Let's go meet Master Chaos.
			{ Cue = "/VO/ZagreusField_1365", RequiredTrait = "ChaosBoonTrait" },
			-- Let's check on Master Chaos.
			{ Cue = "/VO/ZagreusField_1366", RequiredTrait = "ChaosBoonTrait" },
			-- Can't hurt me.
			-- { Cue = "/VO/ZagreusField_1367", RequiredTrait = "ChaosBoonTrait" },
			-- My keepsake from Chaos will protect me.
			{ Cue = "/VO/ZagreusField_1368", RequiredTrait = "ChaosBoonTrait" },
			-- Let's pay Chaos a visit then.
			{ Cue = "/VO/ZagreusField_1369", RequiredTrait = "ChaosBoonTrait" },
		},
	},

	ShrineDoorUnlockedVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.35,

		-- Well here goes nothing.
		{ Cue = "/VO/ZagreusField_1354" },
		-- Punishment has its perks.
		{ Cue = "/VO/ZagreusField_1355", RequiredPlayed = { "/VO/ZagreusField_1354" } },
		-- Exclusive access.
		{ Cue = "/VO/ZagreusField_1356", RequiredPlayed = { "/VO/ZagreusField_1354" } },
		-- Time for more pain.
		{ Cue = "/VO/ZagreusField_1357", RequiredPlayed = { "/VO/ZagreusField_1354" } },
		-- Erebus, here I come.
		{ Cue = "/VO/ZagreusField_1358", RequiredPlayed = { "/VO/ZagreusField_1354" } },
		-- I'm in.
		{ Cue = "/VO/ZagreusField_1359", RequiredPlayed = { "/VO/ZagreusField_1354" } },
		-- I'm authorized.
		{ Cue = "/VO/ZagreusField_1360", RequiredPlayed = { "/VO/ZagreusField_1354" } },
		-- Let me in.
		{ Cue = "/VO/ZagreusField_1361", RequiredPlayed = { "/VO/ZagreusField_1354" } },
		-- Let's go make Father mad.
		{ Cue = "/VO/ZagreusField_1362", RequiredPlayed = { "/VO/ZagreusField_1354" } },
	},

	UsedRerollVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.3,
			CooldownTime = 7,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- Time to make some changes around here.
			{ Cue = "/VO/ZagreusField_0147" },
			-- Time for a change.
			{ Cue = "/VO/ZagreusField_0177" },
			-- My fate is mine.
			{ Cue = "/VO/ZagreusField_0129" },
			-- I won't have it.
			{ Cue = "/VO/ZagreusField_0130" },
			-- I have a better idea.
			{ Cue = "/VO/ZagreusField_0131" },
			-- Whatever, let's try it.
			{ Cue = "/VO/ZagreusHome_0052" },
			-- In the name of Hades.
			{ Cue = "/VO/ZagreusField_0176" },
			-- Hear me, on my authority.
			{ Cue = "/VO/ZagreusField_0178" },
			-- Let's try this instead.
			{ Cue = "/VO/ZagreusField_0132" },
			-- What else we got.
			{ Cue = "/VO/ZagreusField_1222" },
			-- What else we got?
			{ Cue = "/VO/ZagreusField_1223" },
			-- How about another.
			{ Cue = "/VO/ZagreusField_1224" },
			-- How about another?
			{ Cue = "/VO/ZagreusField_1225" },
			-- I don't think so.
			{ Cue = "/VO/ZagreusField_1226" },
			-- Not what I need right now.
			{ Cue = "/VO/ZagreusField_1227" },
			-- Change of plan.
			{ Cue = "/VO/ZagreusField_1228" },
			-- How about, no.
			{ Cue = "/VO/ZagreusField_1229" },
			-- Mmm, no thanks.
			{ Cue = "/VO/ZagreusField_1230" },
			-- By the Three Fates.
			{ Cue = "/VO/ZagreusField_1231" },
			-- I implore the Fates.
			{ Cue = "/VO/ZagreusField_1232" },
			-- Give me another.
			{ Cue = "/VO/ZagreusField_1233", GameStateRequirements = { RequiredFalseScreensOpen = { "BoonMenu", "Store", "SellTraitMenu" }, }, },
			-- Something else.
			{ Cue = "/VO/ZagreusField_1234" },
			-- I'll take another.
			{ Cue = "/VO/ZagreusField_1235", GameStateRequirements = { RequiredFalseScreensOpen = { "BoonMenu", "Store", "SellTraitMenu" }, }, },
			-- Let's see what else.
			{ Cue = "/VO/ZagreusField_3405" },
			-- What else is there?
			{ Cue = "/VO/ZagreusField_3406" },
			-- I'd like to see more options.
			{ Cue = "/VO/ZagreusField_3407", GameStateRequirements = { RequiredScreenOpen = "BoonMenu", }, },
			-- What about these?
			{ Cue = "/VO/ZagreusField_3408", GameStateRequirements = { RequiredScreenOpen = "BoonMenu", }, },
			-- What else?
			{ Cue = "/VO/ZagreusField_3409" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.83,
			SuccessiveChanceToPlay = 0.5,
			CooldownTime = 30,
			Source = { SubtitleColor = Color.ChaosVoice },
			NoTarget = true,
			
			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredRooms = { "RoomSecret01", "RoomSecret02", "RoomSecret03" },
			},

			-- Is this preferable?
			{ Cue = "/VO/Chaos_0232",  },
			-- This, perhaps?
			{ Cue = "/VO/Chaos_0233",  },
			-- Perhaps this.
			{ Cue = "/VO/Chaos_0234",  },
			-- This, then?
			{ Cue = "/VO/Chaos_0235",  },
			-- This outcome, then.
			{ Cue = "/VO/Chaos_0236",  },
			-- Then, this?
			{ Cue = "/VO/Chaos_0237",  },
			-- Done.
			{ Cue = "/VO/Chaos_0238",  },
			-- Very well.
			{ Cue = "/VO/Chaos_0239",  },
			-- Granted.
			{ Cue = "/VO/Chaos_0240",  },

			-- How predictable.
			{ Cue = "/VO/Chaos_0127" },
			-- Entirely expected.
			{ Cue = "/VO/Chaos_0128" },
			-- An inevitable outcome.
			{ Cue = "/VO/Chaos_0129" },
			-- I suppose that this was unavoidable.
			{ Cue = "/VO/Chaos_0130" },
			-- This was the only way.
			{ Cue = "/VO/Chaos_0131" },
			-- That was not what I had in mind.
			{ Cue = "/VO/Chaos_0132" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.83,
			SuccessiveChanceToPlay = 0.5,
			CooldownTime = 30,
			Source = { SubtitleColor = Color.ChaosVoice },
			NoTarget = true,
			Source = { SubtitleColor = Color.ChaosVoice },

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredFalseBiome = "Styx",
				RequiredFalseRooms = { "RoomSecret01", "RoomSecret02", "RoomSecret03" },
				RequiredTextLines = { "ChaosAboutWeaponEnchantments01", "ChaosGift01" },
				RequiredTrait = "ShieldRushBonusProjectileTrait",
				RequiredWeapon = "ShieldWeapon",
			},

			-- Is this preferable?
			{ Cue = "/VO/Chaos_0232",  },
			-- This, perhaps?
			{ Cue = "/VO/Chaos_0233",  },
			-- Perhaps this.
			{ Cue = "/VO/Chaos_0234",  },
			-- This, then?
			{ Cue = "/VO/Chaos_0235",  },
			-- This outcome, then.
			{ Cue = "/VO/Chaos_0236",  },
			-- Then, this?
			{ Cue = "/VO/Chaos_0237",  },
			-- How predictable.
			{ Cue = "/VO/Chaos_0127" },
			-- Entirely expected.
			{ Cue = "/VO/Chaos_0128" },
			-- An inevitable outcome.
			{ Cue = "/VO/Chaos_0129" },
			-- I suppose that this was unavoidable.
			{ Cue = "/VO/Chaos_0130" },
			-- This was the only way.
			{ Cue = "/VO/Chaos_0131" },
			-- That was not what I had in mind.
			{ Cue = "/VO/Chaos_0132" },
		},
	},
	RerollOutcomeVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		CooldownTime = 30,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- Right.
		{ Cue = "/VO/ZagreusField_0278" },
		-- Hmm.
		{ Cue = "/VO/ZagreusField_1042" },
		-- Ah.
		{ Cue = "/VO/ZagreusField_1045" },
		-- By my birthright.
		{ Cue = "/VO/ZagreusField_1047" },
		-- On my authority.
		{ Cue = "/VO/ZagreusField_1048" },
		-- OK...
		{ Cue = "/VO/ZagreusField_0258" },
		-- Hmm.
		{ Cue = "/VO/ZagreusField_1249" },

		--[[
		-- All right.
		{ Cue = "/VO/ZagreusField_1247" },
		-- Huh.
		{ Cue = "/VO/ZagreusField_1248" },
		-- Oh.
		{ Cue = "/VO/ZagreusField_1250" },
		-- <Inhale>
		{ Cue = "/VO/ZagreusField_1251" },
		-- Not what I wanted.
		{ Cue = "/VO/ZagreusField_1252" },
		-- That'll do.
		{ Cue = "/VO/ZagreusField_1253" },
		-- Better.
		{ Cue = "/VO/ZagreusField_1254" },
		-- Fine.
		{ Cue = "/VO/ZagreusField_1255" },
		-- Good.
		{ Cue = "/VO/ZagreusField_1256" },
		-- OK.
		{ Cue = "/VO/ZagreusField_1257" },
		]]--
	},

	UsedRerollPanelVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.3,
			CooldownTime = 12,

			-- How about a different set of choices?
			{ Cue = "/VO/ZagreusField_3912" },
			-- How about a different set of choices, then.
			{ Cue = "/VO/ZagreusField_3913" },
			-- Hmm, let's see what else.
			{ Cue = "/VO/ZagreusField_3914" },
			-- Any other blessings, maybe?
			{ Cue = "/VO/ZagreusField_3915", RequiredScreenOpen = "BoonMenu" },
			-- Hate to be ungrateful here...
			{ Cue = "/VO/ZagreusField_3916" },
			-- Erm, got anything else?
			{ Cue = "/VO/ZagreusField_3917" },
			-- How about some other Boons instead.
			{ Cue = "/VO/ZagreusField_3918", RequiredScreenOpen = "BoonMenu" },
			-- Hey, got anything else?
			{ Cue = "/VO/ZagreusField_3919" },
			-- Any other Boons for me?
			{ Cue = "/VO/ZagreusField_3920", RequiredScreenOpen = "BoonMenu" },
			-- I would like none of these.
			{ Cue = "/VO/ZagreusField_3921" },
			-- What else we got.
			{ Cue = "/VO/ZagreusField_1222" },
			-- What else we got?
			{ Cue = "/VO/ZagreusField_1223" },
			-- Not what I need right now.
			{ Cue = "/VO/ZagreusField_1227" },
			-- Mmm, no thanks.
			{ Cue = "/VO/ZagreusField_1230" },
			-- Something else.
			{ Cue = "/VO/ZagreusField_1234" },
			-- Let's see what else.
			{ Cue = "/VO/ZagreusField_3405" },
			-- What else is there?
			{ Cue = "/VO/ZagreusField_3406" },
			-- I'd like to see more options.
			{ Cue = "/VO/ZagreusField_3407" },
			-- What about these?
			{ Cue = "/VO/ZagreusField_3408", PreLineWait = 1.2 },
			-- What else?
			{ Cue = "/VO/ZagreusField_3409" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.83,
			SuccessiveChanceToPlay = 0.5,
			CooldownTime = 45,
			Source = { SubtitleColor = Color.ChaosVoice },
			NoTarget = true,
			RequiredRooms = { "RoomSecret01", "RoomSecret02", "RoomSecret03" },

			-- Is this preferable?
			{ Cue = "/VO/Chaos_0232",  },
			-- This, perhaps?
			{ Cue = "/VO/Chaos_0233",  },
			-- Perhaps this.
			{ Cue = "/VO/Chaos_0234",  },
			-- This, then?
			{ Cue = "/VO/Chaos_0235",  },
			-- This outcome, then.
			{ Cue = "/VO/Chaos_0236",  },
			-- Then, this?
			{ Cue = "/VO/Chaos_0237",  },
			-- Done.
			{ Cue = "/VO/Chaos_0238",  },
			-- Very well.
			{ Cue = "/VO/Chaos_0239",  },
			-- Granted.
			{ Cue = "/VO/Chaos_0240",  },

			-- How predictable.
			{ Cue = "/VO/Chaos_0127" },
			-- Entirely expected.
			{ Cue = "/VO/Chaos_0128" },
			-- An inevitable outcome.
			{ Cue = "/VO/Chaos_0129" },
			-- I suppose that this was unavoidable.
			{ Cue = "/VO/Chaos_0130" },
			-- This was the only way.
			{ Cue = "/VO/Chaos_0131" },
			-- That was not what I had in mind.
			{ Cue = "/VO/Chaos_0132" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.83,
			SuccessiveChanceToPlay = 0.5,
			CooldownTime = 45,
			Source = { SubtitleColor = Color.ChaosVoice },
			NoTarget = true,
			RequiredFalseBiome = "Styx",
			RequiredFalseRooms = { "RoomSecret01", "RoomSecret02", "RoomSecret03" },
			RequiredTextLines = { "ChaosAboutWeaponEnchantments01", "ChaosGift01" },
			RequiredTrait = "ShieldRushBonusProjectileTrait",
			RequiredWeapon = "ShieldWeapon",
			Source = { SubtitleColor = Color.ChaosVoice },

			-- Is this preferable?
			{ Cue = "/VO/Chaos_0232",  },
			-- This, perhaps?
			{ Cue = "/VO/Chaos_0233",  },
			-- Perhaps this.
			{ Cue = "/VO/Chaos_0234",  },
			-- This, then?
			{ Cue = "/VO/Chaos_0235",  },
			-- This outcome, then.
			{ Cue = "/VO/Chaos_0236",  },
			-- Then, this?
			{ Cue = "/VO/Chaos_0237",  },
			-- Done.
			{ Cue = "/VO/Chaos_0238",  },
			-- Very well.
			{ Cue = "/VO/Chaos_0239",  },
			-- Granted.
			{ Cue = "/VO/Chaos_0240",  },
		},
	},

	CannotRerollVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.3,
			CooldownTime = 7,
			RequiredScreenOpen = "BoonMenu",

			-- The Fates aren't having it.
			{ Cue = "/VO/ZagreusField_3412" },
			-- The Fates won't budge.
			{ Cue = "/VO/ZagreusField_3413" },
			-- The Fates won't let me.
			{ Cue = "/VO/ZagreusField_3414" },
			-- The Fates aren't letting me.
			{ Cue = "/VO/ZagreusField_3415" },
			-- The Fates say no.
			{ Cue = "/VO/ZagreusField_3416" },
			-- The Fates say no I guess.
			{ Cue = "/VO/ZagreusField_3417" },
			-- The Fates won't have it.
			{ Cue = "/VO/ZagreusField_3418" },
			-- Ah, come on.
			{ Cue = "/VO/ZagreusField_3419" },
			-- I guess the Fates won't let me try that here.
			{ Cue = "/VO/ZagreusField_3420" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.3,
			CooldownTime = 7,
			-- RequiredFalseScreenOpen = "BoonMenu",

			-- Can't do that here.
			{ Cue = "/VO/ZagreusField_1236", RequiredPlayed = { "/VO/ZagreusField_1244" } },
			-- The Fates aren't listening to me.
			{ Cue = "/VO/ZagreusField_1237", RequiredPlayed = { "/VO/ZagreusField_1244" } },
			-- Not here.
			{ Cue = "/VO/ZagreusField_1238", RequiredPlayed = { "/VO/ZagreusField_1244" } },
			-- Not going to work here.
			{ Cue = "/VO/ZagreusField_1239", RequiredPlayed = { "/VO/ZagreusField_1244" } },
			-- My authority's no good here.
			{ Cue = "/VO/ZagreusField_1240", RequiredPlayed = { "/VO/ZagreusField_1244" } },
			-- The Fates aren't having it.
			{ Cue = "/VO/ZagreusField_1241", RequiredPlayed = { "/VO/ZagreusField_1244" } },
			-- That won't work here.
			{ Cue = "/VO/ZagreusField_1242", RequiredPlayed = { "/VO/ZagreusField_1244" } },
			-- I only wish.
			{ Cue = "/VO/ZagreusField_1243", RequiredPlayed = { "/VO/ZagreusField_1244" } },
			-- Can't change that one.
			{ Cue = "/VO/ZagreusField_1244" },
			-- I'm stuck with that one.
			{ Cue = "/VO/ZagreusField_1245", RequiredPlayed = { "/VO/ZagreusField_1244" } },
			-- My authority does have its limitations.
			{ Cue = "/VO/ZagreusField_1246", RequiredPlayed = { "/VO/ZagreusField_1244" } },
		},
	},
	CannotFightVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.4,
			CooldownTime = 10,

			-- Can't do that here.
			{ Cue = "/VO/ZagreusField_1236" },
			-- Not here.
			{ Cue = "/VO/ZagreusField_1238" },
			-- Not going to work here.
			{ Cue = "/VO/ZagreusField_1239" },
			-- That won't work here.
			{ Cue = "/VO/ZagreusField_1242" },
			-- I only wish.
			{ Cue = "/VO/ZagreusField_1243" },
			-- My authority does have its limitations.
			{ Cue = "/VO/ZagreusField_1246" },
			-- Wonderful.
			{ Cue = "/VO/ZagreusField_1062" },
			-- That's unfortunate.
			{ Cue = "/VO/ZagreusField_1063" },
			-- Ah really?
			{ Cue = "/VO/ZagreusField_1067" },
			-- I can't.
			{ Cue = "/VO/ZagreusField_0390", RequiredKillEnemiesNotFound = true, },
			-- Can't do that.
			{ Cue = "/VO/ZagreusField_0391", RequiredKillEnemiesNotFound = true, },
			-- It's no use.
			{ Cue = "/VO/ZagreusField_0392", RequiredKillEnemiesNotFound = true, },
			-- No use.
			{ Cue = "/VO/ZagreusField_0393", RequiredKillEnemiesNotFound = true, },
			-- No way.
			{ Cue = "/VO/ZagreusField_0394", RequiredKillEnemiesNotFound = true, },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.6,
			CooldownTime = 10,
			SuccessiveChanceToPlay = 0.5,
			ObjectType = "NPC_Hades_01",
			UseOcclusion = true,
			RequiredSourceValueFalse = "InPartnerConversation",
			RequiredFalseTextLines = { "Ending01" },

			-- Not a chance.
			{ Cue = "/VO/Hades_0052" },
			-- What is it that you're trying now to do?
			{ Cue = "/VO/Hades_0055" },
			-- Don't make me laugh.
			{ Cue = "/VO/Hades_0060" },
			-- Do not so much as think about it.
			{ Cue = "/VO/Hades_0041" },
			-- Not a chance.
			{ Cue = "/VO/Hades_0052" },
			-- I do not think so, boy.
			{ Cue = "/VO/Hades_0043" },
		}
	},

	StruckArmorVoiceLines =
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.66,
		CooldownTime = 500,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- They absorbed my blow!
		{ Cue = "/VO/ZagreusField_1160", },
		-- They're armored.
		{ Cue = "/VO/ZagreusField_1161", },
	},

	GotPoisonedVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		CooldownTime = 200,
		SuccessiveChanceToPlay = 0.33,

		-- Feel sick.
		{ Cue = "/VO/ZagreusField_2121", RequiredPlayed = { "/VO/ZagreusField_2122" } },
		-- Poisoned.
		{ Cue = "/VO/ZagreusField_2122", },
		-- I'm burning up.
		{ Cue = "/VO/ZagreusField_2123", RequiredPlayed = { "/VO/ZagreusField_2122" } },
		-- Need a cure.
		{ Cue = "/VO/ZagreusField_2124", RequiredPlayed = { "/VO/ZagreusField_2122" } },
		-- Blasted poison.
		{ Cue = "/VO/ZagreusField_2125", RequiredPlayed = { "/VO/ZagreusField_2122" } },
		-- I'm sick.
		{ Cue = "/VO/ZagreusField_2126", RequiredPlayed = { "/VO/ZagreusField_2122" } },
		-- Poisoned, again.
		{ Cue = "/VO/ZagreusField_2127", RequiredPlayed = { "/VO/ZagreusField_2122" } },
		-- Eeugghh.
		{ Cue = "/VO/ZagreusField_2128", RequiredPlayed = { "/VO/ZagreusField_2122" } },
		-- Augh I hate this stuff.
		{ Cue = "/VO/ZagreusField_2129", RequiredPlayed = { "/VO/ZagreusField_2122" } },
		-- Poison...
		{ Cue = "/VO/ZagreusField_2130", RequiredPlayed = { "/VO/ZagreusField_2122" } },
	},

	LastStandVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.15,
		CooldownTime = 60,

		-- Where's all my blood huh?
		-- { Cue = "/VO/ZagreusField_0066", },
		-- Oh no you don't.
		-- { Cue = "/VO/ZagreusField_0619", },
		-- My fate is mine.
		-- { Cue = "/VO/ZagreusField_0129" },
		-- I won't have it.
		-- { Cue = "/VO/ZagreusField_0130" },
		-- I have a better idea.
		-- { Cue = "/VO/ZagreusField_0131" },
		-- No you don't.
		{ Cue = "/VO/ZagreusField_0951", RequiredKillEnemiesFound = true },
		-- We're not finished.
		{ Cue = "/VO/ZagreusField_0953", RequiredKillEnemiesFound = true },
		-- Never.
		{ Cue = "/VO/ZagreusField_0954", RequiredKillEnemiesFound = true },
		-- Hrrrrr!!
		{ Cue = "/VO/ZagreusField_0955" },
		-- Not so fast!
		{ Cue = "/VO/ZagreusField_0956", RequiredKillEnemiesFound = true },
		-- I don't think so.
		{ Cue = "/VO/ZagreusField_0957", RequiredKillEnemiesFound = true },
		-- Damn it.
		{ Cue = "/VO/ZagreusField_0958", RequiredKillEnemiesFound = true },
		-- Nrgh, no!
		{ Cue = "/VO/ZagreusField_1912", RequiredKillEnemiesFound = true },
		-- Urgh, no.
		{ Cue = "/VO/ZagreusField_1913", RequiredKillEnemiesFound = true },
		-- Ungh, damn it!
		{ Cue = "/VO/ZagreusField_1914", RequiredKillEnemiesFound = true },
		-- Khh, blast!
		{ Cue = "/VO/ZagreusField_1915", RequiredKillEnemiesFound = true },
		-- Uff, blood and darkness!
		{ Cue = "/VO/ZagreusField_1916", RequiredKillEnemiesFound = true },
		-- Augh, you!
		{ Cue = "/VO/ZagreusField_1917", RequiredKillEnemiesFound = true },
		-- Urgh, that hurt.
		{ Cue = "/VO/ZagreusField_1918", RequiredKillEnemiesFound = true },
		-- Rnng that hurt damn it!
		{ Cue = "/VO/ZagreusField_1920", RequiredKillEnemiesFound = true },
		-- Urgh, back!!
		{ Cue = "/VO/ZagreusField_2630", RequiredKillEnemiesFound = true },
		-- Mph, hraah!
		{ Cue = "/VO/ZagreusField_2631" },
		-- Mmph, t'heh!
		{ Cue = "/VO/ZagreusField_2632" },
		-- Tsch, fine!
		{ Cue = "/VO/ZagreusField_2633", RequiredKillEnemiesFound = true },
		-- Nng, nrraagh!
		{ Cue = "/VO/ZagreusField_2634" },

	},
	LastStandLastLifeVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.75,
			CooldownTime = 20,
			RequiredKeepsake = "ReincarnationTrait",
			SuccessiveChanceToPlayAll = 0.33,

			-- By the power of Skelly!
			{ Cue = "/VO/ZagreusField_1474" },
			-- By Skelly's Lucky Tooth!
			{ Cue = "/VO/ZagreusField_1475" },
			-- Skelly power!
			{ Cue = "/VO/ZagreusField_1476" },
		},		
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.75,
			CooldownTime = 20,

			-- Urgh, last chance...
			{ Cue = "/VO/ZagreusField_1148", },
			-- Unf, this is it...
			{ Cue = "/VO/ZagreusField_1149", },
			-- Rngh one last shot...
			{ Cue = "/VO/ZagreusField_1150", RequiredKillEnemiesFound = true },
			-- Nrgh I won't go back!
			{ Cue = "/VO/ZagreusField_1151", RequiredKillEnemiesFound = true },
			-- It's my last chance!
			{ Cue = "/VO/ZagreusField_1152", },
			-- It's do or die!
			{ Cue = "/VO/ZagreusField_1152", RequiredKillEnemiesFound = true },
			-- I'm near death.
			{ Cue = "/VO/ZagreusField_0063", },
			-- Not. Yet.
			{ Cue = "/VO/ZagreusField_0952" },
			-- Grr, no!
			{ Cue = "/VO/ZagreusField_1911", RequiredKillEnemiesFound = true },
			-- Oof, close call!
			{ Cue = "/VO/ZagreusField_1919", RequiredKillEnemiesFound = true },
		},
	},
	SelfDamageVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.05,
			CooldownTime = 100,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- Ow I shouldn't have done that.
			{ Cue = "/VO/ZagreusField_1190", },
			-- Augh that was from Chaos.
			{ Cue = "/VO/ZagreusField_1191", },
			-- Ungh the Curse of Chaos.
			{ Cue = "/VO/ZagreusField_1192", },
			-- Ah I'm cursed!
			{ Cue = "/VO/ZagreusField_1193", },
			-- Uff should not have done that!
			{ Cue = "/VO/ZagreusField_1194", },
			-- Ack damn it!
			{ Cue = "/VO/ZagreusField_1195", },
		},
		{
			PreLineWait = 0.28,
			RandomRemaining = true,
			NoTarget = true,
			SuccessiveChanceToPlay = 0.33,
			Source = { SubtitleColor = Color.ChaosVoice },
			CooldownTime = 400,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredTextLines = { "ChaosAboutWeaponEnchantments01", "ChaosGift01" },
				RequiredTrait = "ShieldRushBonusProjectileTrait",
				RequiredWeapon = "ShieldWeapon",
			},

			-- <Laughter>
			{ Cue = "/VO/Chaos_0211" },
			-- <Laughter>
			{ Cue = "/VO/Chaos_0212" },
			-- <Laughter>
			{ Cue = "/VO/Chaos_0213" },
			-- Uh-uh!
			{ Cue = "/VO/Chaos_0214" },
			-- Have you forgotten?
			{ Cue = "/VO/Chaos_0215" },
			-- I think not.
			{ Cue = "/VO/Chaos_0216" },
			-- Inadvisable.
			{ Cue = "/VO/Chaos_0217" },
			-- No.
			{ Cue = "/VO/Chaos_0218" },
			-- That was perhaps unwise.
			{ Cue = "/VO/Chaos_0134" },
			-- You are exhibiting a lack of judgment.
			{ Cue = "/VO/Chaos_0139" },
			-- How amusing.
			{ Cue = "/VO/Chaos_0098" },
			-- That was unfortunate.
			{ Cue = "/VO/Chaos_0101" },
		},
	},
	HitByGraveHandsVoiceLines =
	{
		{
			RandomRemaining = true,
			Queue = "Interrupt",
			TriggerCooldowns = { "ZagreusAnyQuipSpeech" },
			RequiredFalseTraits = { "StatusImmunityTrait" },
			RequiredFalseBossPhase = 3,
			Cooldowns =
			{
				{ Name = "ZagreusHitByGraveHandsSpeech", Time = 10 }
			},

			-- Let me go!
			{ Cue = "/VO/ZagreusField_2360", RequiredPlayed = { "/VO/ZagreusField_2362" } },
			-- Let go of me!
			{ Cue = "/VO/ZagreusField_2361", RequiredPlayed = { "/VO/ZagreusField_2362" } },
			-- Get off me!
			{ Cue = "/VO/ZagreusField_2362", },
			-- Aah!
			{ Cue = "/VO/ZagreusField_2363", RequiredPlayed = { "/VO/ZagreusField_2362" } },
			-- Ah, stuck!
			{ Cue = "/VO/ZagreusField_2364", RequiredPlayed = { "/VO/ZagreusField_2362" } },
			-- Stuck!
			{ Cue = "/VO/ZagreusField_2365", RequiredPlayed = { "/VO/ZagreusField_2362" } },
			-- I'm stuck!
			{ Cue = "/VO/ZagreusField_2366", RequiredPlayed = { "/VO/ZagreusField_2362" } },
			-- Can't move!
			{ Cue = "/VO/ZagreusField_2367", RequiredPlayed = { "/VO/ZagreusField_2362" } },
			-- Not again!
			{ Cue = "/VO/ZagreusField_2368", RequiredPlayed = { "/VO/ZagreusField_2362" } },
			-- Augh again?
			{ Cue = "/VO/ZagreusField_2369", RequiredPlayed = { "/VO/ZagreusField_2362" } },
		},
		{
			ObjectType = "Hades",
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.3,
				RequiredFalseBossPhase = 3,
				Cooldowns =
				{
					{ Name = "HadesAnyQuipSpeech" },
					{ Name = "HadesGhostHandsSpeech", Time = 100 }
				},

				ExplicitRequirements = true,
				GameStateRequirements =
				{
					-- None
				},

				-- What's the matter, boy?
				{ Cue = "/VO/HadesField_0199" },
				-- You're stuck.
				{ Cue = "/VO/HadesField_0200" },
				-- You're trapped.
				{ Cue = "/VO/HadesField_0201" },
				-- Hold still...!
				{ Cue = "/VO/HadesField_0202" },
				-- No squirming out of this.
				{ Cue = "/VO/HadesField_0203" },
				-- Be careful where you step.
				{ Cue = "/VO/HadesField_0204" },
				-- You stepped in something, boy.
				{ Cue = "/VO/HadesField_0205" },
				-- Even my wretches don't want you to leave.
				{ Cue = "/VO/HadesField_0206" },
				-- You wait right there.
				{ Cue = "/VO/HadesField_0207" },
			}
		}
	},
	HitByHadesAmmoVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.15,
			SuccessiveChanceToPlay = 0.33,
			RequiredFalseBossPhase = 3,
			Cooldowns =
			{
				{ Name = "ZagreusAnyQuipSpeech" },
				{ Name = "ZagHitByHadesAmmoSpeech", Time = 100 }
			},
			-- Ngh, I'm hit!
			{ Cue = "/VO/ZagreusField_2370", RequiredPlayed = { "/VO/ZagreusField_2376" } },
			-- Ungh, trouble...
			{ Cue = "/VO/ZagreusField_2371", RequiredPlayed = { "/VO/ZagreusField_2376" } },
			-- Rngh, no.
			{ Cue = "/VO/ZagreusField_2372", RequiredPlayed = { "/VO/ZagreusField_2376" } },
			-- Ah, got me!
			{ Cue = "/VO/ZagreusField_2373", RequiredPlayed = { "/VO/ZagreusField_2376" } },
			-- Khh, you!
			{ Cue = "/VO/ZagreusField_2374", RequiredPlayed = { "/VO/ZagreusField_2376" } },
			-- Unf not this.
			{ Cue = "/VO/ZagreusField_2375", RequiredPlayed = { "/VO/ZagreusField_2376" } },
			-- Augh, wha--?
			{ Cue = "/VO/ZagreusField_2376" },
			-- Mph get out!
			{ Cue = "/VO/ZagreusField_2377", RequiredPlayed = { "/VO/ZagreusField_2376" } },
		},
		{
			ObjectType = "Hades",
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
				SuccessiveChanceToPlay = 0.5,
				RequiredFalseBossPhase = 3,
				Cooldowns =
				{
					{ Name = "HadesAnyQuipSpeech" },
					{ Name = "HadesGhostHandsSpeech", Time = 100 }
				},
				
				ExplicitRequirements = true,
				GameStateRequirements =
				{
					-- None
				},

				-- Prepare...!
				{ Cue = "/VO/HadesField_0189" },
				-- Do you feel your blood beginning to boil?
				{ Cue = "/VO/HadesField_0190" },
				-- Too slow.
				{ Cue = "/VO/HadesField_0191" },
				-- Beware, boy.
				{ Cue = "/VO/HadesField_0192" },
				-- I'll boil your blood.
				{ Cue = "/VO/HadesField_0193" },
				-- You should have avoided that.
				{ Cue = "/VO/HadesField_0194" },
				-- Got you.
				{ Cue = "/VO/HadesField_0195" },
				-- What's wrong, boy?
				{ Cue = "/VO/HadesField_0196" },
				-- Wake up, boy!
				{ Cue = "/VO/HadesField_0197" },
				-- Surely you could have avoided that?
				{ Cue = "/VO/HadesField_0198" },
			}
		}
	},
	ExitsUnlockedVoiceLines =
	{
		-- Low Health context
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 3.15,
			RequiredMaxHealthFraction = 0.6,
			RequiredMaxLastStands = 0,
			PlayOnceFromTableThisRun = true,
			RequiredMaxCompletedRuns = 2,
			RequiredBiome = "Tartarus",
			PlayOnce = true,
			RequiresInRun = true,

			-- They got me. No way to patch up. Got to keep going.
			{ Cue = "/VO/ZagreusField_0906", RequiredPlayed = { "/VO/ZagreusField_0907" } },
			-- I'm hurt. Can't heal myself. But I can fight.
			{ Cue = "/VO/ZagreusField_0907" },
			-- Nngh, what I wouldn't give for, say, a healing flask of some sort.
			{ Cue = "/VO/ZagreusField_0908", RequiredPlayed = { "/VO/ZagreusField_0906", "/VO/ZagreusField_0907" } },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 3.55,
			ChanceToPlay = 0.5,
			RequiredMaxHealthFraction = 0.3,
			RequiredMaxLastStands = 0,
			PlayOnceFromTableThisRun = true,
			RequiredMinCompletedRuns = 3,
			RequiresInRun = true,
			-- these lines are only meant to play after combat in standard rooms so the following is for safety
			RequiredFalseRooms = { "A_Boss01", "B_Boss01", "B_Boss02", "C_Boss01", "D_Boss01", "A_PreBoss01", "B_PreBoss01", "A_Reprieve01", "B_Reprieve01", "C_Repreive01", "D_Repreive01",
				"A_Story01", "B_Story01", "C_Story01",
				"A_Shop01", "B_Shop01", "C_Shop01", },

			-- Still alive.
			{ Cue = "/VO/ZagreusField_0965" },
			-- Have to keep going.
			{ Cue = "/VO/ZagreusField_0966" },
			-- Not dead yet.
			{ Cue = "/VO/ZagreusField_0967" },
			-- One more chamber?
			{ Cue = "/VO/ZagreusField_0968" },
			-- Not finished yet.
			{ Cue = "/VO/ZagreusField_0969" },
			-- I can still fight.
			{ Cue = "/VO/ZagreusField_0970" },
			-- Here goes nothing.
			{ Cue = "/VO/ZagreusField_0971" },
			-- Got to keep pushing.
			{ Cue = "/VO/ZagreusField_0972" },
			-- Can't give up yet.
			{ Cue = "/VO/ZagreusField_0973" },
			-- I can do this.
			{ Cue = "/VO/ZagreusField_0974" },
			-- Got to focus.
			{ Cue = "/VO/ZagreusField_0975" },
		},
	},

	ExamineVoiceLines =
	{
		RandomRemaining = true,
		CooldownTime = 5,
		PreLineWait = 0.45,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- Let's see.
		{ Cue = "/VO/ZagreusHome_0056" },
		-- Let's have a look here.
		{ Cue = "/VO/ZagreusHome_0057" },
		-- Hmm.
		{ Cue = "/VO/ZagreusHome_0058" },
	},
	WrathStockGainedVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		-- PlayOnceFromTableThisRun = true,
		PreLineWait = 0.35,
		CooldownTime = 100,
		CooldownName = "ZagQuipped",

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			RequiredMinHealthFraction = 0.15,
		},

		-- Now...
		{ Cue = "/VO/ZagreusField_0091", },
		-- There it is.
		{ Cue = "/VO/ZagreusField_0092", GameStateRequirements = { RequiredMinCompletedRuns = 1 }, },
		-- Ha, hah...
		{ Cue = "/VO/ZagreusField_0295", },
		-- Now we're talking.
		{ Cue = "/VO/ZagreusField_0297", },
		-- Fired up.
		{ Cue = "/VO/ZagreusField_0298", },
		-- Ready for Wrath.
		-- { Cue = "/VO/ZagreusField_1496", },
		-- Wrath time.
		-- { Cue = "/VO/ZagreusField_1497", },
		-- Oh, I'm mad.
		{ Cue = "/VO/ZagreusField_1498", },
		-- Grrr...!
		{ Cue = "/VO/ZagreusField_1499", },
		-- Gods help you.
		{ Cue = "/VO/ZagreusField_1500", },
		-- Anger...
		-- { Cue = "/VO/ZagreusField_1501", },
		-- Time for Wrath.
		-- { Cue = "/VO/ZagreusField_1502", },
		-- That's it.
		{ Cue = "/VO/ZagreusField_1503", },
	},
	SuperActivatedVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.2,
			SuccessiveChanceToPlay = 0.5,
			Cooldowns =
			{
				-- { Name = "ZagreusAnyQuipSpeech", Time = CurrentRun.Hero.VoiceLineBufferTime },
				{ Name = "ZagreusWrathSpeech", Time = 6.5 },
			},

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredTrait = "ZeusShoutTrait",
				RequiredSpurnedGodName = "ZeusUpgrade",
				RequireCurrentEncounterNotComplete = true,
			},

			-- Sorry!
			{ Cue = "/VO/ZagreusField_2544", },
			-- I'm sorry!
			{ Cue = "/VO/ZagreusField_2545", },
			-- Sorry?
			{ Cue = "/VO/ZagreusField_2546", },
			-- This is awkward!
			{ Cue = "/VO/ZagreusField_2547", },
			-- Olympus?
			-- { Cue = "/VO/ZagreusField_2548", },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.2,
			SuccessiveChanceToPlay = 0.5,
			Cooldowns =
			{
				-- { Name = "ZagreusAnyQuipSpeech", Time = CurrentRun.Hero.VoiceLineBufferTime },
				{ Name = "ZagreusWrathSpeech", Time = 6.5 },
			},

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredTrait = "PoseidonShoutTrait",
				RequiredSpurnedGodName = "PoseidonUpgrade",
				RequireCurrentEncounterNotComplete = true,
			},

			-- Sorry!
			{ Cue = "/VO/ZagreusField_2544", },
			-- I'm sorry!
			{ Cue = "/VO/ZagreusField_2545", },
			-- Sorry?
			{ Cue = "/VO/ZagreusField_2546", },
			-- This is awkward!
			{ Cue = "/VO/ZagreusField_2547", },
			-- Olympus?
			-- { Cue = "/VO/ZagreusField_2548", },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.2,
			SuccessiveChanceToPlay = 0.5,
			Cooldowns =
			{
				-- { Name = "ZagreusAnyQuipSpeech", Time = CurrentRun.Hero.VoiceLineBufferTime },
				{ Name = "ZagreusWrathSpeech", Time = 6.5 },
			},

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredTrait = "AthenaShoutTrait",
				RequiredSpurnedGodName = "AthenaUpgrade",
				RequireCurrentEncounterNotComplete = true,
			},

			-- Sorry!
			{ Cue = "/VO/ZagreusField_2544", },
			-- I'm sorry!
			{ Cue = "/VO/ZagreusField_2545", },
			-- Sorry?
			{ Cue = "/VO/ZagreusField_2546", },
			-- This is awkward!
			{ Cue = "/VO/ZagreusField_2547", },
			-- Olympus?
			-- { Cue = "/VO/ZagreusField_2548", },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.2,
			SuccessiveChanceToPlay = 0.5,
			Cooldowns =
			{
				-- { Name = "ZagreusAnyQuipSpeech", Time = CurrentRun.Hero.VoiceLineBufferTime },
				{ Name = "ZagreusWrathSpeech", Time = 6.5 },
			},

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredTrait = "AphroditeShoutTrait",
				RequiredSpurnedGodName = "AphroditeUpgrade",
				RequireCurrentEncounterNotComplete = true,
			},

			-- Sorry!
			{ Cue = "/VO/ZagreusField_2544", },
			-- I'm sorry!
			{ Cue = "/VO/ZagreusField_2545", },
			-- Sorry?
			{ Cue = "/VO/ZagreusField_2546", },
			-- This is awkward!
			{ Cue = "/VO/ZagreusField_2547", },
			-- Olympus?
			-- { Cue = "/VO/ZagreusField_2548", },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.2,
			SuccessiveChanceToPlay = 0.5,
			Cooldowns =
			{
				-- { Name = "ZagreusAnyQuipSpeech", Time = CurrentRun.Hero.VoiceLineBufferTime },
				{ Name = "ZagreusWrathSpeech", Time = 6.5 },
			},

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredTrait = "ArtemisShoutTrait",
				RequiredSpurnedGodName = "ArtemisUpgrade",
				RequireCurrentEncounterNotComplete = true,
			},

			-- Sorry!
			{ Cue = "/VO/ZagreusField_2544", },
			-- I'm sorry!
			{ Cue = "/VO/ZagreusField_2545", },
			-- Sorry?
			{ Cue = "/VO/ZagreusField_2546", },
			-- This is awkward!
			{ Cue = "/VO/ZagreusField_2547", },
			-- Olympus?
			-- { Cue = "/VO/ZagreusField_2548", },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.2,
			SuccessiveChanceToPlay = 0.5,
			Cooldowns =
			{
				-- { Name = "ZagreusAnyQuipSpeech", Time = CurrentRun.Hero.VoiceLineBufferTime },
				{ Name = "ZagreusWrathSpeech", Time = 6.5 },
			},

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredTrait = "AresShoutTrait",
				RequiredSpurnedGodName = "AresUpgrade",
				RequireCurrentEncounterNotComplete = true,
			},

			-- Sorry!
			{ Cue = "/VO/ZagreusField_2544", },
			-- I'm sorry!
			{ Cue = "/VO/ZagreusField_2545", },
			-- Sorry?
			{ Cue = "/VO/ZagreusField_2546", },
			-- This is awkward!
			{ Cue = "/VO/ZagreusField_2547", },
			-- Olympus?
			-- { Cue = "/VO/ZagreusField_2548", },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.2,
			SuccessiveChanceToPlay = 0.5,
			Cooldowns =
			{
				-- { Name = "ZagreusAnyQuipSpeech", Time = CurrentRun.Hero.VoiceLineBufferTime },
				{ Name = "ZagreusWrathSpeech", Time = 6.5 },
			},

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredTrait = "DionysusShoutTrait",
				RequiredSpurnedGodName = "DionysusUpgrade",
				RequireCurrentEncounterNotComplete = true,
			},

			-- Sorry!
			{ Cue = "/VO/ZagreusField_2544", },
			-- I'm sorry!
			{ Cue = "/VO/ZagreusField_2545", },
			-- Sorry?
			{ Cue = "/VO/ZagreusField_2546", },
			-- This is awkward!
			{ Cue = "/VO/ZagreusField_2547", },
			-- Olympus?
			-- { Cue = "/VO/ZagreusField_2548", },
		},
	},
	FullSuperActivatedVoiceLines =
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		UsePlayerSource = true,
		Cooldowns =
		{
			-- { Name = "ZagreusAnyQuipSpeech", Time = CurrentRun.Hero.VoiceLineBufferTime },
			{ Name = "ZagreusWrathSpeech", Time = 4.5 },
		},

		-- Zeus!!
		{ Cue = "/VO/ZagreusField_2234", RequiredTrait = "ZeusShoutTrait", RequiredFalseSpurnedGodName = "ZeusUpgrade" },
		-- Poseidon!!
		{ Cue = "/VO/ZagreusField_2236", RequiredTrait = "PoseidonShoutTrait", RequiredFalseSpurnedGodName = "PoseidonUpgrade" },
		-- Athena!!
		{ Cue = "/VO/ZagreusField_2238", RequiredTrait = "AthenaShoutTrait", RequiredFalseSpurnedGodName = "AthenaUpgrade" },
		-- Ares!!
		{ Cue = "/VO/ZagreusField_2240", RequiredTrait = "AresShoutTrait", RequiredFalseSpurnedGodName = "AresUpgrade" },
		-- Artemis!
		{ Cue = "/VO/ZagreusField_2242", RequiredTrait = "ArtemisShoutTrait", RequiredFalseSpurnedGodName = "ArtemisUpgrade" },
		-- Aphrodite!!
		{ Cue = "/VO/ZagreusField_2244", RequiredTrait = "AphroditeShoutTrait", RequiredFalseSpurnedGodName = "AphroditeUpgrade" },
		-- Dionysus!!
		{ Cue = "/VO/ZagreusField_2246", RequiredTrait = "DionysusShoutTrait", RequiredFalseSpurnedGodName = "DionysusUpgrade" },
		-- Demeter!!
		{ Cue = "/VO/ZagreusField_2997", RequiredTrait = "DemeterShoutTrait", RequiredFalseSpurnedGodName = "DemeterUpgrade" },
		-- Father!!
		{ Cue = "/VO/ZagreusField_4345", RequiredTrait = "HadesShoutTrait" },
	},

	NextWaveVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 2.15,
		SuccessiveChanceToPlay = 0.25,
		Cooldowns =
		{
			{ Name = "ZagreusAnyQuipSpeech" },
			{ Name = "ZagNextWaveVoiceLines", Time = 360 }
		},

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "BossHarpy1", "BossHarpy2", "BossHarpy3", "BossHydra" },
		},

		-- Hello mates.
		{ Cue = "/VO/ZagreusField_0320", CooldownName = "SaidHelloRecently", CooldownTime = 80 },
		-- You want to die again?
		{ Cue = "/VO/ZagreusField_0018", GameStateRequirements = { RequiredFalseBiome = "Styx" }, },
		-- Look who.
		{ Cue = "/VO/ZagreusField_0318" },
		-- Surprise.
		{ Cue = "/VO/ZagreusField_0322" },
		-- Come try me.
		{ Cue = "/VO/ZagreusField_0022" },
		-- Come on, then.
		{ Cue = "/VO/ZagreusField_0026" },
		-- Who's next.
		{ Cue = "/VO/ZagreusField_0360" },
		-- Next!
		{ Cue = "/VO/ZagreusField_0361" },
		-- More?
		{ Cue = "/VO/ZagreusField_0631" },
		-- More.
		{ Cue = "/VO/ZagreusField_0632" },
		-- More, huh.
		{ Cue = "/VO/ZagreusField_0633" },
		-- More coming.
		{ Cue = "/VO/ZagreusField_0634" },
		-- Next up.
		{ Cue = "/VO/ZagreusField_0635" },
		-- You're just in time.
		{ Cue = "/VO/ZagreusField_0636" },
		-- You're late.
		{ Cue = "/VO/ZagreusField_0637" },
		-- Don't keep me waiting.
		{ Cue = "/VO/ZagreusField_0638" },
		-- Oh good.
		{ Cue = "/VO/ZagreusField_0639" },
		-- Come on in.
		{ Cue = "/VO/ZagreusField_0640" },
		-- Just getting started huh.
		{ Cue = "/VO/ZagreusField_0641" },
		-- Good, come on in.
		{ Cue = "/VO/ZagreusField_0642" },
		-- Show yourselves.
		{ Cue = "/VO/ZagreusField_0643" },
		-- How many now?
		{ Cue = "/VO/ZagreusField_0644" },
		-- Just getting warmed up.
		{ Cue = "/VO/ZagreusField_0296", },
		-- Just in time.
		{ Cue = "/VO/ZagreusField_1015", },
		-- Welcome.
		{ Cue = "/VO/ZagreusField_1016", },
		-- Come, wretches.
		{ Cue = "/VO/ZagreusField_1017", },
		-- Come die again.
		{ Cue = "/VO/ZagreusField_1018", },
		-- Think you can stop me?
		{ Cue = "/VO/ZagreusField_1019", CooldownName = "SaidStopRecently", CooldownTime = 80 },
		-- Right on cue.
		{ Cue = "/VO/ZagreusField_1020", },
		-- You want a go?
		{ Cue = "/VO/ZagreusField_1021", },
		-- This won't end well for you.
		{ Cue = "/VO/ZagreusField_1022", },
		-- Do your worst.
		{ Cue = "/VO/ZagreusField_1023", },
		-- Who dies next?
		{ Cue = "/VO/ZagreusField_1024", },
		-- Let's deal some death.
		{ Cue = "/VO/ZagreusField_1025", },
		-- More souls for Stygius.
		{ Cue = "/VO/ZagreusField_1026", GameStateRequirements = { RequiredWeapon = "SwordWeapon", }, },
		-- Come meet my blade.
		{ Cue = "/VO/ZagreusField_1027", GameStateRequirements = { RequiredWeapon = "SwordWeapon", }, },
		-- Come get shot.
		{ Cue = "/VO/ZagreusField_1028", GameStateRequirements = { RequiredWeapon = "BowWeapon", }, },
		-- Coronacht will find you.
		{ Cue = "/VO/ZagreusField_1029", GameStateRequirements = { RequiredWeapon = "BowWeapon", }, },
		-- Ready, Aegis?
		{ Cue = "/VO/ZagreusField_1030", GameStateRequirements = { RequiredWeapon = "ShieldWeapon", }, },
		-- A feast for Aegis.
		{ Cue = "/VO/ZagreusField_1031", GameStateRequirements = { RequiredWeapon = "ShieldWeapon", }, },
		-- Die by Varatha.
		{ Cue = "/VO/ZagreusField_1032", GameStateRequirements = { RequiredWeapon = "SpearWeapon", }, },
		-- I'll run you through.
		{ Cue = "/VO/ZagreusField_1033", GameStateRequirements = { RequiredWeapon = "SpearWeapon", }, },
		-- Come face Malphon and me.
		{ Cue = "/VO/ZagreusField_3246", GameStateRequirements = { RequiredWeapon = "FistWeapon", }, },
		-- More punching practice then.
		{ Cue = "/VO/ZagreusField_3247", GameStateRequirements = { RequiredWeapon = "FistWeapon", }, },
		-- Who's getting punched.
		{ Cue = "/VO/ZagreusField_3248", GameStateRequirements = { RequiredWeapon = "FistWeapon", }, },
		-- These Fists are going to do the talking, soon.
		{ Cue = "/VO/ZagreusField_3249", GameStateRequirements = { RequiredWeapon = "FistWeapon", }, SuccessiveChanceToPlay = 0.01 },
		-- More target practice.
		{ Cue = "/VO/ZagreusField_1322", GameStateRequirements = { RequiredWeapon = "GunWeapon", }, },
		-- Let's fire it up.
		{ Cue = "/VO/ZagreusField_1323", GameStateRequirements = { RequiredWeapon = "GunWeapon", }, },
		-- Multiple foes sighted.
		{ Cue = "/VO/ZagreusField_1324", GameStateRequirements = { RequiredWeapon = "GunWeapon", }, },
		-- Exagryph, prepare to fire.
		{ Cue = "/VO/ZagreusField_1325", GameStateRequirements = { RequiredWeapon = "GunWeapon", }, },
		-- May I help you?
		{ Cue = "/VO/ZagreusField_1034", },
		-- Bring it.
		{ Cue = "/VO/ZagreusField_3252", },
		-- Come.
		{ Cue = "/VO/ZagreusField_3253", },
		-- More coming.
		{ Cue = "/VO/ZagreusField_3254", },
		-- More to fight.
		{ Cue = "/VO/ZagreusField_3255", },
		-- There's more.
		{ Cue = "/VO/ZagreusField_3256", },
		-- Here they come.
		{ Cue = "/VO/ZagreusField_3257", },
		-- Keep them coming.
		{ Cue = "/VO/ZagreusField_3258", },
		-- Welcome.
		{ Cue = "/VO/ZagreusField_3259", },
		-- Heh, good.
		{ Cue = "/VO/ZagreusField_3260", },
		-- Ready for them.
		{ Cue = "/VO/ZagreusField_3261", },
	},
	FinalWaveVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		
		CooldownTime = 600,
		PreLineWait = 2.0,
		SuccessiveChanceToPlay = 0.2,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
			RequiredFalseBiome = "Tartarus",
		},

		-- Almost there...
		{ Cue = "/VO/ZagreusField_0188" },
		-- Got to hold on...
		{ Cue = "/VO/ZagreusField_0190" },
		-- Just a bit longer...!
		{ Cue = "/VO/ZagreusField_0554" },
		-- So close...!
		{ Cue = "/VO/ZagreusField_0555" },
		-- Nearly made it...!
		{ Cue = "/VO/ZagreusField_0556" },
		-- Haven't you learned your lesson yet?
		{ Cue = "/VO/ZagreusField_2388" },
		-- More of you, huh?
		{ Cue = "/VO/ZagreusField_2389" },
		-- Has to be the last of this lot.
		{ Cue = "/VO/ZagreusField_2390" },
		-- How many more of these are there.
		{ Cue = "/VO/ZagreusField_2391" },
		-- More coming, then?
		{ Cue = "/VO/ZagreusField_2392" },
		-- This Temple's positively crawling.
		{ Cue = "/VO/ZagreusField_2393", GameStateRequirements = { RequiredBiome = "Styx" }, },
		-- Place is crawling with these.
		{ Cue = "/VO/ZagreusField_2394" },
		-- Not had enough yet?
		{ Cue = "/VO/ZagreusField_2395" },
		-- Come on out!
		{ Cue = "/VO/ZagreusField_2396" },
		-- Almost finished with these.
		{ Cue = "/VO/ZagreusField_2397", GameStateRequirements = { RequiredMinHealthFraction = 0.6 }, },
		-- They're slowing down.
		{ Cue = "/VO/ZagreusField_2398" },
		-- Must be the last of them.
		{ Cue = "/VO/ZagreusField_2399" },
	},

	MinotaurDefeatedVoiceLines =
	{
		RandomRemaining = true,
		CooldownTime = 60,
		PreLineWait = 2.25,
		SuccessiveChanceToPlayAll = 0.5,

		-- I beat the Bull of Minos.
		{ Cue = "/VO/ZagreusField_1788" },
		-- Well fought, Asterius.
		{ Cue = "/VO/ZagreusField_1789", RequiredPlayed = { "/VO/ZagreusField_1788" } },
		-- I guess I win this round.
		{ Cue = "/VO/ZagreusField_1790", RequiredPlayed = { "/VO/ZagreusField_1788" } },
		-- Got him that time.
		{ Cue = "/VO/ZagreusField_1791", RequiredPlayed = { "/VO/ZagreusField_1788" } },
		-- Who's the short one now, huh?!
		{ Cue = "/VO/ZagreusField_1792", RequiredTextLines = { "MinotaurEncounter01" }, RequiredFalseTextLines = { "MinotaurOutro05" }, RequiredKills = { Minotaur = 10 }, },
		-- Got you, Asterius.
		{ Cue = "/VO/ZagreusField_1793", RequiredPlayed = { "/VO/ZagreusField_1788" } },
		-- Till next time, sir.
		{ Cue = "/VO/ZagreusField_4685", RequiredPlayed = { "/VO/ZagreusField_1788" }, RequiredMinTimesSeenRoom = { C_MiniBoss01 = 4 }, },
		-- See you soon!
		{ Cue = "/VO/ZagreusField_4686", RequiredPlayed = { "/VO/ZagreusField_1788" }, RequiredKills = { Theseus = 4 }, },
		-- Got you, Bull-man.
		{ Cue = "/VO/ZagreusField_4687", RequiredPlayed = { "/VO/ZagreusField_1788" }, ConsecutiveClearsOfRoom = { Name = "C_MiniBoss01", Count = 2 }, },
		-- Tell Theseus I said hi!
		{ Cue = "/VO/ZagreusField_4688", RequiredPlayed = { "/VO/ZagreusField_1788" }, ConsecutiveClearsOfRoom = { Name = "C_MiniBoss01", Count = 2 }, RequiredKills = { Theseus = 8 }, },
		-- Cheers for the fight!
		{ Cue = "/VO/ZagreusField_4689", RequiredPlayed = { "/VO/ZagreusField_1788" }, ConsecutiveClearsOfRoom = { Name = "C_MiniBoss01", Count = 2 }, },
		-- Got him again.
		{ Cue = "/VO/ZagreusField_4690", RequiredPlayed = { "/VO/ZagreusField_1788" }, ConsecutiveClearsOfRoom = { Name = "C_MiniBoss01", Count = 2 }, },
		-- I got him.
		{ Cue = "/VO/ZagreusField_4691", RequiredPlayed = { "/VO/ZagreusField_1788" } },
		-- A warm-up for later.
		{ Cue = "/VO/ZagreusField_4692", RequiredPlayed = { "/VO/ZagreusField_1788" }, RequiredKills = { Theseus = 6 }, },
	},

	ShadeRespawnHintVoiceLines =
	{
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			PlayOnce = true,
			Cooldowns =
			{
				{ Name = "ZagreusRespawnHintSpeech", Time = 300 },
			},

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- That eyeball, is that him?
			{ Cue = "/VO/ZagreusField_1689", },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.025,
			Cooldowns =
			{
				{ Name = "ZagreusRespawnHintSpeech", Time = 300 },
			},

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- Got to finish him off.
			{ Cue = "/VO/ZagreusField_1685" },
			-- I've disarmed him!
			{ Cue = "/VO/ZagreusField_1687" },
			-- He's going for his weapon!
			{ Cue = "/VO/ZagreusField_1688" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PlayOnceThisRun = true,
			PreLineWait = 0.45,
			
			Cooldowns =
			{
				{ Name = "ZagreusRespawnHintSpeech", Time = 300 },
			},

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				ChanceToPlay = 0.01,
			},

			-- Now for the juicy center.
			{ Cue = "/VO/ZagreusField_1686" },
		}
	},
	ShieldDepletedVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- Shield's down.
		{ Cue = "/VO/ZagreusField_2657" },
		-- Shield's down!
		{ Cue = "/VO/ZagreusField_2658" },
		-- There goes my shield.
		{ Cue = "/VO/ZagreusField_2659" },
		-- Uh oh.
		{ Cue = "/VO/ZagreusField_2660" },
		-- No more Acorn!
		{ Cue = "/VO/ZagreusField_2661" },
		-- No more Acorn!
		{ Cue = "/VO/ZagreusField_2662" },
		-- Aah!
		{ Cue = "/VO/ZagreusField_2455" },
		-- Nrgh!
		{ Cue = "/VO/ZagreusField_2463" },
		-- Gah.
		{ Cue = "/VO/ZagreusField_2464" },
	},
	ExitBlockedBySellWellVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		Cooldowns =
		{
			{ Name = "ZagreusAnyQuipSpeech" },
		},

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- I need to purge a Boon to get out of here.
		{ Cue = "/VO/ZagreusField_2670" },
		-- I have to use the Purging Pool back there.
		{ Cue = "/VO/ZagreusField_2671" },
		-- I need to purge one of my Boons first.
		{ Cue = "/VO/ZagreusField_2672" },
		-- Underworld Customs, got to purge a Boon.
		{ Cue = "/VO/ZagreusField_2673" },
		-- Blasted Underworld Customs.
		{ Cue = "/VO/ZagreusField_2674" },
		-- Urgh forgot to purge a Boon.
		{ Cue = "/VO/ZagreusField_2675" },
		-- Have to give up one of my Boons first.
		{ Cue = "/VO/ZagreusField_2676" },
		-- Oh right, the Purging Pool.
		{ Cue = "/VO/ZagreusField_2677" },
	},

	UpgradeMenuOpenVoiceLines =
	{
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.35,
			PreLineWait = 1.35,
			RequiresSwappedGodLoot = true,
			CooldownTime = 300,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },

			-- An exchange...
			{ Cue = "/VO/ZagreusField_1852" },
			-- A boon for a boon...
			{ Cue = "/VO/ZagreusField_1853" },
			-- I can switch to a different boon.
			{ Cue = "/VO/ZagreusField_1854" },
			-- She's offering an exchange.
			{ Cue = "/VO/ZagreusField_1856", RequiredLastGodGender = "Female" },
			-- He's offering an exchange.
			{ Cue = "/VO/ZagreusField_1855", RequiredLastGodGender = "Male" },
		},
	},
	SwapUpgradePickedVoiceLines =
	{
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
			RequiredSwappedGodLoot = "ZeusUpgrade",
			CooldownName = "SaidZeusRecently",
			CooldownTime = 40,

			-- I'm sure Lord Uncle Zeus won't mind.
			{ Cue = "/VO/ZagreusField_1863" },
			-- Surely Zeus won't mind.
			{ Cue = "/VO/ZagreusField_1864" },
			-- Lord Uncle Zeus won't mind, will he?
			{ Cue = "/VO/ZagreusField_1865" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
			RequiredSwappedGodLoot = "PoseidonUpgrade",
			CooldownName = "SaidPoseidonRecently",
			CooldownTime = 40,

			-- I'm sure Uncle Poseidon won't mind.
			{ Cue = "/VO/ZagreusField_1869" },
			-- Poseidon won't mind.
			{ Cue = "/VO/ZagreusField_1870" },
			-- Poseidon won't mind, will he?
			{ Cue = "/VO/ZagreusField_1871" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
			RequiredSwappedGodLoot = "AthenaUpgrade",
			CooldownName = "SaidAthenaRecently",
			CooldownTime = 40,

			-- I'm sure Lady Athena won't mind.
			{ Cue = "/VO/ZagreusField_1857" },
			-- Athena won't mind.
			{ Cue = "/VO/ZagreusField_1858" },
			-- Athena won't mind, will she?
			{ Cue = "/VO/ZagreusField_1859" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
			RequiredSwappedGodLoot = "AresUpgrade",
			CooldownName = "SaidAresRecently",
			CooldownTime = 40,

			-- I'm sure Lord Ares won't mind.
			{ Cue = "/VO/ZagreusField_1875" },
			-- Ares won't mind.
			{ Cue = "/VO/ZagreusField_1876" },
			-- Ares won't mind will he?
			{ Cue = "/VO/ZagreusField_1877" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
			RequiredSwappedGodLoot = "AphroditeUpgrade",
			CooldownName = "SaidAphroditeRecently",
			CooldownTime = 40,

			-- I'm sure Lady Aphrodite won't mind.
			{ Cue = "/VO/ZagreusField_1881" },
			-- Aphrodite won't mind.
			{ Cue = "/VO/ZagreusField_1882" },
			-- Aphrodite won't mind, will she?
			{ Cue = "/VO/ZagreusField_1883" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
			RequiredSwappedGodLoot = "ArtemisUpgrade",
			CooldownName = "SaidArtemisRecently",
			CooldownTime = 40,

			-- I'm sure Lady Artemis won't mind.
			{ Cue = "/VO/ZagreusField_1887" },
			-- Artemis won't mind.
			{ Cue = "/VO/ZagreusField_1888" },
			-- Artemis won't mind, will she?
			{ Cue = "/VO/ZagreusField_1889" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
			RequiredSwappedGodLoot = "DionysusUpgrade",
			CooldownName = "SaidDionysusRecently",
			CooldownTime = 40,

			-- I'm sure Lord Dionysus won't mind.
			{ Cue = "/VO/ZagreusField_1893" },
			-- Dionysus won't mind.
			{ Cue = "/VO/ZagreusField_1894" },
			-- Dionysus won't mind, will he?
			{ Cue = "/VO/ZagreusField_1895" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.33,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", },
			RequiredSwappedGodLoot = "DemeterUpgrade",
			CooldownName = "SaidDemeterRecently",
			CooldownTime = 40,

			-- I'm sure that Demeter won't mind.
			{ Cue = "/VO/ZagreusField_2991" },
			-- Hope Demeter won't mind.
			{ Cue = "/VO/ZagreusField_2992" },
			-- Lady Demeter won't mind, will she?
			{ Cue = "/VO/ZagreusField_2993" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlayAll = 0.5,
			RequiresLastUpgradeSwapped = true,

			-- This boon should serve me better.
			{ Cue = "/VO/ZagreusField_1899" },
			-- A better boon for the circumstances.
			{ Cue = "/VO/ZagreusField_1901" },
			-- A change of boons was in order.
			{ Cue = "/VO/ZagreusField_1902" },
			-- Too tempting of a trade.
			{ Cue = "/VO/ZagreusField_1903" },
			-- Too good an offer to pass up.
			{ Cue = "/VO/ZagreusField_1904" },
			-- Playing me against each other, aren't they.
			{ Cue = "/VO/ZagreusField_1905" },
			-- I can't say no to that.
			{ Cue = "/VO/ZagreusField_1906" },
			-- A worthy exchange.
			{ Cue = "/VO/ZagreusField_1907" },
		},
	},
	UpgradePickedVoiceLines =
	{
		RequiredFalseRooms = { "TestAllThings" },
		Cooldowns =
		{
			{ Name = "ZagreusBoonPickUpSpeech", Time = 60 },
		},
		{
			BreakIfPlayed = true,
			PreLineWait = 1.1,
			Queue = "Always",

			-- All right, then, let's get mad.
			-- { Cue = "/VO/ZagreusField_1471", RequiredTextLinesThisRun = "PoseidonWrathIntro01", RequiredLastGodLoot = "PoseidonUpgrade", PlayOnce = true },
			-- The wrath of Poseidon at my beck and call.
			{ Cue = "/VO/ZagreusField_2250", RequiredRoom = "RoomOpening", RequiredTextLinesThisRun = "PoseidonWrathIntro01", RequiredLastGodLoot = "PoseidonUpgrade", PlayOnce = true },
		},
		{
			BreakIfPlayed = true,
			PreLineWait = 1.1,
			Queue = "Always",

			-- All right, let's catch some fish.
			{ Cue = "/VO/ZagreusField_3340", RequiredRoom = "RoomOpening", RequiredTextLinesThisRun = "PoseidonFishQuest01", RequiredLastGodLoot = "PoseidonUpgrade", PlayOnce = true, PlayOnceContext = "FishQuestIntro", },
		},
		{
			PlayOnce = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "Shop" },

			-- I know you can't hear me all the way where you are, Goddess. But thank you.
			{ Cue = "/VO/ZagreusField_4077", RequiredLastGodLoot = "AthenaUpgrade", RequiredTextLinesThisRun = "AthenaFirstPickUp" },

			-- Lord Uncle Zeus lending his support... I never thought I'd see the day. Or night. Whenever.
			{ Cue = "/VO/ZagreusField_0777", RequiredLastGodLoot = "ZeusUpgrade", RequiredTextLinesThisRun = "ZeusFirstPickUp" },

			-- Looks like I caught a big one! The power of the seas should be of help.
			{ Cue = "/VO/ZagreusField_0780", RequiredLastGodLoot = "PoseidonUpgrade", RequiredTextLinesThisRun = "PoseidonFirstPickUp" },

			-- Interested? In the power to break hearts? Sure, I don't see why not.
			{ Cue = "/VO/ZagreusField_0783", RequiredLastGodLoot = "AphroditeUpgrade", RequiredTextLinesThisRun = "AphroditeFirstPickUp" },

			-- I sure could use some company now that she mentions it. The power of the hunt sounds handy too!
			-- { Cue = "/VO/ZagreusField_0787", RequiredLastGodLoot = "ArtemisUpgrade", RequiredTextLinesThisRun = "ArtemisFirstPickUp" },
			-- The power of the hunt sounds like good company to keep.
			{ Cue = "/VO/ZagreusField_4328", RequiredLastGodLoot = "ArtemisUpgrade", RequiredTextLinesThisRun = "ArtemisFirstPickUp" },

			-- With your power, Lord Ares, maybe I'll get out of here yet.
			{ Cue = "/VO/ZagreusField_0790", RequiredLastGodLoot = "AresUpgrade", RequiredTextLinesThisRun = "ArtemisFirstPickUp" },

			-- Leave it to the god of wine to liven things up around here.
			{ Cue = "/VO/ZagreusField_1217", RequiredLastGodLoot = "DionysusUpgrade", RequiredTextLinesThisRun = "DionysusFirstPickUp" },

			-- I've the power of the freezing surface, now.
			{ Cue = "/VO/ZagreusField_2967", RequiredLastGodLoot = "DemeterUpgrade", RequiredTextLinesThisRun = "DemeterFirstPickUp" },

			-- Appreciate the lift, Lord Hermes sir. Now let's go!
			{ Cue = "/VO/ZagreusField_1924", RequiredLastGodLoot = "HermesUpgrade", RequiredTextLinesThisRun = "HermesFirstPickUp" },
		},
		{
			Queue = "Always",
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlayAll = 0.5,
			PreLineWait = 0.8,
			RequiredAnyLastPickedTraits = GameData.AllSynergyTraits,

			-- Two blessings are better than one.
			{ Cue = "/VO/ZagreusField_4113" },
			-- What a team.
			{ Cue = "/VO/ZagreusField_4114" },
			-- Let's go, team!
			{ Cue = "/VO/ZagreusField_4115" },
			-- Teamwork!
			{ Cue = "/VO/ZagreusField_4116" },
			-- Thanks, Family.
			{ Cue = "/VO/ZagreusField_4117" },
			-- Cheers, you two.
			{ Cue = "/VO/ZagreusField_4118" },
			-- Thanks, you two!
			{ Cue = "/VO/ZagreusField_4119" },
			-- Two for one.
			{ Cue = "/VO/ZagreusField_4120" },
			-- Duo power.
			{ Cue = "/VO/ZagreusField_4121" },
			-- Both their might.
			{ Cue = "/VO/ZagreusField_4122" },
			-- Combined might.
			{ Cue = "/VO/ZagreusField_4123" },
			-- Combined power.
			{ Cue = "/VO/ZagreusField_4124" },
		},		
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.33,
			PreLineWait = 0.75,
			RequiredLastGodLoot = "AthenaUpgrade",

			-- Athena's power...
			{ Cue = "/VO/ZagreusField_0794", CooldownName = "SaidAthenaRecently", CooldownTime = 40, },
			-- The shield of light.
			{ Cue = "/VO/ZagreusField_0795" },
			-- The wisdom of Athena.
			{ Cue = "/VO/ZagreusField_0796", CooldownName = "SaidAthenaRecently", CooldownTime = 40, },
			-- Divine protection.
			{ Cue = "/VO/ZagreusField_0797" },
			-- The might of Athena.
			{ Cue = "/VO/ZagreusField_0798", CooldownName = "SaidAthenaRecently", CooldownTime = 40, },
			-- Strength of the goddess.
			{ Cue = "/VO/ZagreusField_0799" },
			-- Thank you, Athena.
			{ Cue = "/VO/ZagreusField_4018", CooldownName = "SaidAthenaRecently", CooldownTime = 40, },
			-- Athena's strength.
			{ Cue = "/VO/ZagreusField_4019", CooldownName = "SaidAthenaRecently", CooldownTime = 40, },
			-- Your wisdom guide me.
			{ Cue = "/VO/ZagreusField_4020" },
			-- Appreciate the backup.
			{ Cue = "/VO/ZagreusField_4021" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.5,
			PreLineWait = 0.75,
			RequiredLastGodLoot = "ZeusUpgrade",

			-- Lord Zeus's strength.
			{ Cue = "/VO/ZagreusField_0800", CooldownName = "SaidZeusRecently", CooldownTime = 40, },
			-- The thunder-god's might.
			{ Cue = "/VO/ZagreusField_0801" },
			-- Thunder and lightning.
			{ Cue = "/VO/ZagreusField_0802" },
			-- Thunder time.
			{ Cue = "/VO/ZagreusField_0803" },
			-- I feel all tingly.
			{ Cue = "/VO/ZagreusField_0804" },
			-- Is my hair sticking up?
			{ Cue = "/VO/ZagreusField_0805" },
			-- All right, Lord Zeus.
			{ Cue = "/VO/ZagreusField_4010" },
			-- Electric.
			{ Cue = "/VO/ZagreusField_4011" },
			-- Shocking.
			{ Cue = "/VO/ZagreusField_4012" },
			-- The might of the heavens.
			{ Cue = "/VO/ZagreusField_4013" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.5,
			PreLineWait = 0.75,
			RequiredLastGodLoot = "PoseidonUpgrade",

			-- Let's make some waves, right, Uncle?
			{ Cue = "/VO/ZagreusField_0806" },
			-- Let's make some waves.
			{ Cue = "/VO/ZagreusField_0807" },
			-- The power of the sea.
			{ Cue = "/VO/ZagreusField_0808" },
			-- The ocean's fury.
			{ Cue = "/VO/ZagreusField_0809" },
			-- The sea-god's might.
			{ Cue = "/VO/ZagreusField_0810" },
			-- It's high tide.
			{ Cue = "/VO/ZagreusField_0811" },
			-- Poseidon's strength.
			{ Cue = "/VO/ZagreusField_4014" },
			-- Cheers, Uncle.
			{ Cue = "/VO/ZagreusField_4015" },
			-- Whew, felt that.
			{ Cue = "/VO/ZagreusField_4016" },
			-- Might of the sea.
			{ Cue = "/VO/ZagreusField_4017" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.5,
			PreLineWait = 0.75,
			RequiredLastGodLoot = "AphroditeUpgrade",

			-- Love and loss.
			{ Cue = "/VO/ZagreusField_0812" },
			-- Strength and beauty.
			{ Cue = "/VO/ZagreusField_0813" },
			-- Heartbreak time.
			{ Cue = "/VO/ZagreusField_0814" },
			-- No love without pain.
			{ Cue = "/VO/ZagreusField_0815" },
			-- Let's break some hearts.
			{ Cue = "/VO/ZagreusField_0816" },
			-- I feel fabulous.
			{ Cue = "/VO/ZagreusField_0817" },
			-- My heart is full.
			{ Cue = "/VO/ZagreusField_4022" },
			-- Beautiful.
			{ Cue = "/VO/ZagreusField_4023" },
			-- Love it.
			{ Cue = "/VO/ZagreusField_4024" },
			-- I'm all worked up...
			{ Cue = "/VO/ZagreusField_4025" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.5,
			PreLineWait = 0.75,
			RequiredLastGodLoot = "ArtemisUpgrade",

			-- The might of the huntress.
			{ Cue = "/VO/ZagreusField_0818" },
			-- Time to hunt.
			{ Cue = "/VO/ZagreusField_0819" },
			-- My senses sharpen.
			{ Cue = "/VO/ZagreusField_0820" },
			-- The dead had better hide.
			{ Cue = "/VO/ZagreusField_0821", RequiredFalseBiome = "Styx" },
			-- Artemis guide my hand.
			{ Cue = "/VO/ZagreusField_0822", CooldownName = "SaidArtemisRecently", CooldownTime = 40, },
			-- I'll make every strike count.
			{ Cue = "/VO/ZagreusField_0823" },
			-- Let's hunt some dead.
			{ Cue = "/VO/ZagreusField_4030", RequiredFalseBiome = "Styx" },
			-- On the prowl.
			{ Cue = "/VO/ZagreusField_4031" },
			-- The hunt is on.
			{ Cue = "/VO/ZagreusField_4506" },
			-- Thank you, Artemis.
			{ Cue = "/VO/ZagreusField_4033", CooldownName = "SaidArtemisRecently", CooldownTime = 40, },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.5,
			PreLineWait = 0.75,
			RequiredLastGodLoot = "AresUpgrade",

			-- The war-god's power.
			{ Cue = "/VO/ZagreusField_0824" },
			-- The will to fight.
			{ Cue = "/VO/ZagreusField_0825" },
			-- I will keep fighting.
			{ Cue = "/VO/ZagreusField_0826" },
			-- Violence...
			{ Cue = "/VO/ZagreusField_0827" },
			-- It's me or them.
			{ Cue = "/VO/ZagreusField_0828" },
			-- This means war.
			{ Cue = "/VO/ZagreusField_0829" },
			-- Kill or be killed.
			{ Cue = "/VO/ZagreusField_4026" },
			-- More bloodshed, then.
			{ Cue = "/VO/ZagreusField_4027" },
			-- The war is on.
			{ Cue = "/VO/ZagreusField_4028" },
			-- This is my fight.
			{ Cue = "/VO/ZagreusField_4029" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.5,
			PreLineWait = 0.75,
			RequiredLastGodLoot = "DionysusUpgrade",

			-- To my health.
			{ Cue = "/VO/ZagreusField_0830" },
			-- Let's liven things up.
			{ Cue = "/VO/ZagreusField_0831" },
			-- Time to feast.
			{ Cue = "/VO/ZagreusField_0832" },
			-- Cheers to that.
			{ Cue = "/VO/ZagreusField_0833" },
			-- Strong stuff.
			{ Cue = "/VO/ZagreusField_0834" },
			-- How about another?
			{ Cue = "/VO/ZagreusField_0835" },
			-- Whew, that's good.
			{ Cue = "/VO/ZagreusField_4034" },
			-- Cheers, mate.
			{ Cue = "/VO/ZagreusField_4035" },
			-- Feeling good!
			{ Cue = "/VO/ZagreusField_4036" },
			-- Perked me right up.
			{ Cue = "/VO/ZagreusField_4037" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.5,
			PreLineWait = 0.75,
			RequiredLastGodLoot = "DemeterUpgrade",

			-- Brr, that's brisk!!
			{ Cue = "/VO/ZagreusField_2977" },
			-- Mm, that's cold.
			{ Cue = "/VO/ZagreusField_2978" },
			-- Whoo, that woke me up!
			{ Cue = "/VO/ZagreusField_2979" },
			-- Brr, perks you right up!
			{ Cue = "/VO/ZagreusField_2980" },
			-- The winter's chill.
			{ Cue = "/VO/ZagreusField_2981", RequiredAnyTextLines = { "DemeterMiscPickup11", "DemeterMiscPickupAboutWinter01", "DemeterMiscPickupAboutWinter02", "DemeterMiscPickupAboutWinter03", "DemeterRejection09", "DemeterMakeUp06", "DemeterMakeUp07", "DemeterMakeUp10" }, },
			-- Ice cold.
			{ Cue = "/VO/ZagreusField_2982" },
			-- That beats the heat.
			{ Cue = "/VO/ZagreusField_2983", RequiredBiome = "Asphodel" },
			-- Icy.
			{ Cue = "/VO/ZagreusField_2984" },
			-- Cool, cool.
			{ Cue = "/VO/ZagreusField_2985", RequiredTextLines = { "DemeterGift03" }, },
			-- Very cool.
			{ Cue = "/VO/ZagreusField_2986" },
			-- Desolation.
			{ Cue = "/VO/ZagreusField_4038", RequiredTextLines = { "DemeterGift02" }, },
			-- Shivering...
			{ Cue = "/VO/ZagreusField_4039" },
			-- Cooled me off...
			{ Cue = "/VO/ZagreusField_4040" },
			-- It's freezing...
			{ Cue = "/VO/ZagreusField_4041" },
			-- Brr, that's cold...
			{ Cue = "/VO/ZagreusField_2962" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.5,
			PreLineWait = 0.75,
			RequiredLastGodLoot = "HermesUpgrade",

			-- The haste of Hermes.
			{ Cue = "/VO/ZagreusField_1938", CooldownName = "SaidHermesRecently", CooldownTime = 60 },
			-- Hermes, send me on.
			{ Cue = "/VO/ZagreusField_1939", CooldownName = "SaidHermesRecently", CooldownTime = 60 },
			-- Let's move, Hermes.
			{ Cue = "/VO/ZagreusField_1940", CooldownName = "SaidHermesRecently", CooldownTime = 60 },
			-- That's godspeed all right.
			{ Cue = "/VO/ZagreusField_1941" },
			-- Godspeed.
			{ Cue = "/VO/ZagreusField_1942" },
			-- Faster than ever.
			{ Cue = "/VO/ZagreusField_1943" },
			-- Time to pick up the pace.
			{ Cue = "/VO/ZagreusField_1944" },
			-- Cheers, Hermes.
			{ Cue = "/VO/ZagreusField_1945", CooldownName = "SaidHermesRecently", CooldownTime = 60 },
			-- Whew, felt that!
			{ Cue = "/VO/ZagreusField_1946" },
			-- That's the stuff.
			{ Cue = "/VO/ZagreusField_1947" },
			-- Time to go.
			{ Cue = "/VO/ZagreusField_1948" },
			-- And here we go.
			{ Cue = "/VO/ZagreusField_1949" },
			-- Moving right along.
			{ Cue = "/VO/ZagreusField_4042" },
			-- Swift as Hermes.
			{ Cue = "/VO/ZagreusField_4043", CooldownName = "SaidHermesRecently", CooldownTime = 60 },
			-- Now here goes.
			{ Cue = "/VO/ZagreusField_4044" },
			-- Let's go, let's go!
			{ Cue = "/VO/ZagreusField_4045" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.5,
			PreLineWait = 0.75,
			RequiredLastGodLoot = "StackUpgrade",

			-- They must have lots of these upon Olympus.
			{ Cue = "/VO/ZagreusField_0728", PlayOnce = true, CooldownName = "SaidOlympusRecently", CooldownTime = 40 },
			-- Pommed up.
			{ Cue = "/VO/ZagreusField_4078", RequiredPlayed = { "/VO/ZagreusField_0728" }, },
			-- Powered up.
			{ Cue = "/VO/ZagreusField_4079", RequiredPlayed = { "/VO/ZagreusField_0728" }, },
			-- Zesty.
			{ Cue = "/VO/ZagreusField_4080", RequiredPlayed = { "/VO/ZagreusField_0728" }, },
			-- Stronger still.
			{ Cue = "/VO/ZagreusField_4081", RequiredPlayed = { "/VO/ZagreusField_0728" }, },
			-- Better blessing.
			{ Cue = "/VO/ZagreusField_4082", RequiredPlayed = { "/VO/ZagreusField_0728" }, },
			-- Got some zest.
			{ Cue = "/VO/ZagreusField_4083", RequiredPlayed = { "/VO/ZagreusField_0728" }, },
			-- Sharpened my senses.
			{ Cue = "/VO/ZagreusField_4084", RequiredPlayed = { "/VO/ZagreusField_0728" }, },
			-- Extra blessing.
			{ Cue = "/VO/ZagreusField_4085", RequiredPlayed = { "/VO/ZagreusField_0728" }, },
			-- Pom power.
			{ Cue = "/VO/ZagreusField_4086", RequiredPlayed = { "/VO/ZagreusField_0728" }, },
			-- Juicy.
			{ Cue = "/VO/ZagreusField_4087", RequiredPlayed = { "/VO/ZagreusField_0728" }, },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.8,
			RequiredLastGodLoot = "TrialUpgrade",
			SuccessiveChanceToPlay = 0.75,

			-- I'll have to withstand the whims of Chaos to extract the benefits a few chambers from now.
			{ Cue = "/VO/ZagreusField_1070", PlayOnce = true },
			-- The whims of Master Chaos.
			{ Cue = "/VO/ZagreusField_1071", RequiredPlayed = { "/VO/ZagreusField_1070" } },
			-- Let's see how this goes...
			{ Cue = "/VO/ZagreusField_1072", RequiredPlayed = { "/VO/ZagreusField_1070" } },
			-- The power of Primordial Chaos.
			{ Cue = "/VO/ZagreusField_1073", RequiredPlayed = { "/VO/ZagreusField_1070" } },
			-- Chaotic strength...
			{ Cue = "/VO/ZagreusField_1074", RequiredPlayed = { "/VO/ZagreusField_1070" } },
			-- Chaos flows through me.
			{ Cue = "/VO/ZagreusField_1075", RequiredPlayed = { "/VO/ZagreusField_1070" } },
			-- Chaos, guide me.
			{ Cue = "/VO/ZagreusField_4046", RequiredPlayed = { "/VO/ZagreusField_1070" } },
			-- Let's see what happens.
			{ Cue = "/VO/ZagreusField_4047", RequiredPlayed = { "/VO/ZagreusField_1070" } },
			-- Let's shake this curse.
			{ Cue = "/VO/ZagreusField_4048", RequiredPlayed = { "/VO/ZagreusField_1070" } },
			-- I can handle this.
			{ Cue = "/VO/ZagreusField_4049", RequiredPlayed = { "/VO/ZagreusField_1070" } },
			-- Should be worth it soon enough.
			{ Cue = "/VO/ZagreusField_4050", RequiredPlayed = { "/VO/ZagreusField_1070" } },
			-- Sounds like a trade to me.
			{ Cue = "/VO/ZagreusField_4051", RequiredPlayed = { "/VO/ZagreusField_1070" } },
			-- A worthy trade-off.
			{ Cue = "/VO/ZagreusField_4052", RequiredPlayed = { "/VO/ZagreusField_1070" } },

			-- So shall it be.
			{ Cue = "/VO/Chaos_0023", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- I see no reason not to make it so.
			{ Cue = "/VO/Chaos_0024", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- If that is your desire, we shall call it done.
			{ Cue = "/VO/Chaos_0025", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- Very well, O Son of Hades.
			{ Cue = "/VO/Chaos_0026", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- That is acceptable.
			{ Cue = "/VO/Chaos_0027", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- I had suspected you would choose the same.
			{ Cue = "/VO/Chaos_0028", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- It shall be done.
			{ Cue = "/VO/Chaos_0029", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- Well then, why not.
			{ Cue = "/VO/Chaos_0030", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- This should be interesting.
			{ Cue = "/VO/Chaos_0031", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- Go forth, then, Son of Hades.
			{ Cue = "/VO/Chaos_0032", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- My mark be with you.
			{ Cue = "/VO/Chaos_0033", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- I appreciate your patronage.
			{ Cue = "/VO/Chaos_0034", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- You shall have it.
			{ Cue = "/VO/Chaos_0035", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- Be careful, Son of Hades.
			{ Cue = "/VO/Chaos_0039", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- How circumspect of you.
			{ Cue = "/VO/Chaos_0040", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- An acceptable decision.
			{ Cue = "/VO/Chaos_0044", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- Do what you think is best.
			{ Cue = "/VO/Chaos_0045", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- It shall be so.
			{ Cue = "/VO/Chaos_0111", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- Very well.
			{ Cue = "/VO/Chaos_0112", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },
			-- Certainly.
			{ Cue = "/VO/Chaos_0114", NoTarget = true, RequiredPlayed = { "/VO/ZagreusField_1070" }, Source = { SubtitleColor = Color.ChaosVoice } },

		},
	},
	GenericUpgradePickedVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.05,
		RequiredFalseEncounters = { "DevotionTestTartarus", "DevotionTestAsphodel", "DevotionTestElysium", "Shop" },
		RequiredFalseRooms = { "TestAllThings" },
		SuccessiveChanceToPlayAll = 0.33,
		Cooldowns =
		{
			{ Name = "ZagreusBoonPickUpSpeech", Time = 60 },
		},

		-- CooldownName = "UpgradeLinesPlayedRecently",
		-- CooldownTime = 30,

		-- I feel stronger.
		{ Cue = "/VO/ZagreusField_0112", },
		-- I accept this gift.
		{ Cue = "/VO/ZagreusField_0113", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Very good.
		{ Cue = "/VO/ZagreusField_0115", RequiredPlayed = { "/VO/ZagreusField_0112" }, CooldownName = "SaidGoodRecently", CooldownTime = 40, },
		-- Better.
		{ Cue = "/VO/ZagreusField_0116", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Good.
		{ Cue = "/VO/ZagreusField_0117", RequiredPlayed = { "/VO/ZagreusField_0112" }, CooldownName = "SaidGoodRecently", CooldownTime = 40, },
		-- Excellent.
		{ Cue = "/VO/ZagreusField_0230", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Cheers.
		{ Cue = "/VO/ZagreusField_0236", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Much appreciated.
		{ Cue = "/VO/ZagreusHome_0050", RequiredPlayed = { "/VO/ZagreusField_0112" }, RequiredMinCompletedRuns = 1 },
		-- Thank you, gods.
		{ Cue = "/VO/ZagreusHome_0051", RequiredPlayed = { "/VO/ZagreusField_0112" }, RequiredMinCompletedRuns = 1 },
		-- Thank the gods.
		{ Cue = "/VO/ZagreusScratch_0007", RequiredPlayed = { "/VO/ZagreusField_0112" }, RequiredMinCompletedRuns = 1 },
		-- I'll earn your favor yet.
		{ Cue = "/VO/ZagreusHome_0048", RequiredPlayed = { "/VO/ZagreusField_0112" }, RequiredMinCompletedRuns = 1 },
		-- I grow stronger.
		{ Cue = "/VO/ZagreusField_0692", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- You honor me.
		{ Cue = "/VO/ZagreusField_0693", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- I'm honored.
		{ Cue = "/VO/ZagreusField_0694", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Thank you for your support.
		{ Cue = "/VO/ZagreusField_0695", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- I'm grateful for this.
		{ Cue = "/VO/ZagreusField_0696", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Thank you, Goddess.
		{ Cue = "/VO/ZagreusScratch_0008_ALT", RequiredPlayed = { "/VO/ZagreusField_0112" }, RequiredLastGodGender = "Female", },
		-- I'm blessed.
		{ Cue = "/VO/ZagreusField_4204", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Truly blessed.
		{ Cue = "/VO/ZagreusField_4205", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Thank you for that.
		{ Cue = "/VO/ZagreusField_4206", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Help from on high.
		{ Cue = "/VO/ZagreusField_4207", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Thanks, Olympus.
		{ Cue = "/VO/ZagreusField_4208", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Message received.
		{ Cue = "/VO/ZagreusField_4209", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- All right.
		{ Cue = "/VO/ZagreusField_4210", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Might of Olympus.
		{ Cue = "/VO/ZagreusField_4211", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Whoo.
		{ Cue = "/VO/ZagreusField_4212", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- I owe you one.
		{ Cue = "/VO/ZagreusField_4213", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
		-- Handy.
		{ Cue = "/VO/ZagreusField_4214", RequiredPlayed = { "/VO/ZagreusField_0112" }, },
	},
	TrialUpgradeTransformedVoiceLines =
	{
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.7,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredFalseEncounters = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro" },
			},

			-- My boon from Chaos has transformed.
			{ Cue = "/VO/ZagreusField_1076" },
			-- The boon I got from Chaos has a new effect.
			{ Cue = "/VO/ZagreusField_1077" },
			-- My Chaos Boon switched to a new effect.
			{ Cue = "/VO/ZagreusField_1078" },
			-- A curse of Chaos has been lifted.
			{ Cue = "/VO/ZagreusField_1079" },
			-- A curse of Chaos has expired.
			{ Cue = "/VO/ZagreusField_1080" },
			-- My Chaos Boon evolved a new effect.
			{ Cue = "/VO/ZagreusField_1081" },
			-- My boon from Master Chaos has evolved.
			{ Cue = "/VO/ZagreusField_1082" },
		},
		{
			PreLineWait = 0.05,
			RandomRemaining = true,
			NoTarget = true,
			SuccessiveChanceToPlay = 0.33,
			
			Source = { SubtitleColor = Color.ChaosVoice },
			CooldownTime = 400,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				RequiredTextLines = { "ChaosAboutWeaponEnchantments01", "ChaosGift01" },
				RequiredTrait = "ShieldRushBonusProjectileTrait",
				RequiredWeapon = "ShieldWeapon",
				RequiredFalseEncounters = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro" },
			},

			-- Here.
			{ Cue = "/VO/Chaos_0219" },
			-- There.
			{ Cue = "/VO/Chaos_0220" },
			-- Behold.
			{ Cue = "/VO/Chaos_0221" },
			-- Live.
			{ Cue = "/VO/Chaos_0222" },
			-- I give you power.
			{ Cue = "/VO/Chaos_0223" },
			-- I have something for you.
			{ Cue = "/VO/Chaos_0122" },
			-- This is for you.
			{ Cue = "/VO/Chaos_0123" },
			-- Take this with my compliments.
			{ Cue = "/VO/Chaos_0124" },
			-- A small token of my appreciation.
			{ Cue = "/VO/Chaos_0125" },
			-- I wish for you to have this.
			{ Cue = "/VO/Chaos_0126" },
		},
	},
	PerfectClearDamageBonusUpgradedVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.7,
		SuccessiveChanceToPlay = 0.2,
		CooldownTime = 200,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			RequiredFalseRooms = { "A_Boss01", "A_Boss02", "A_Boss03", "B_Boss01", "B_Boss02", "C_MiniBoss01", "C_Boss01", "D_Boss01" },
			RequiredFalseEncounters = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro" },
		},

		-- The Pierced Butterfly grows stronger.
		{ Cue = "/VO/ZagreusField_1638" },
		-- Than's Keepsake grew stronger.
		{ Cue = "/VO/ZagreusField_1639" },
		-- Than's Keepsake...
		{ Cue = "/VO/ZagreusField_1640" },
		-- My Keepsake powered up.
		{ Cue = "/VO/ZagreusField_1641" },
		-- My Keepsake...
		{ Cue = "/VO/ZagreusField_1642" },
		-- That was my Keepsake.
		{ Cue = "/VO/ZagreusField_1643", PreLineWait = 0.85 },
		-- The Pierced Butterfly...
		{ Cue = "/VO/ZagreusField_1644" },
		-- The power of Thanatos.
		{ Cue = "/VO/ZagreusField_1645" },
		-- Than's power.
		{ Cue = "/VO/ZagreusField_1646" },
		-- Got through without a scratch.
		{ Cue = "/VO/ZagreusField_1647" },
	},
	FastClearDodgeBonusUpgradedVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.7,
		SuccessiveChanceToPlay = 0.2,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			RequiredFalseRooms = { "A_Boss01", "A_Boss02", "A_Boss03", "B_Boss01", "B_Boss02", "C_MiniBoss01", "C_Boss01", "D_Boss01" },
		},

		-- My Keepsake powered up.
		{ Cue = "/VO/ZagreusField_1641" },
		-- My Keepsake...
		{ Cue = "/VO/ZagreusField_1642" },
		-- That was my Keepsake.
		{ Cue = "/VO/ZagreusField_1643", PreLineWait = 0.85 },
		-- That was the Lambent Plume.
		{ Cue = "/VO/ZagreusField_1991" },
		-- My Plume grew stronger.
		{ Cue = "/VO/ZagreusField_1992" },
		-- The Lambent Plume.
		{ Cue = "/VO/ZagreusField_1993" },
		-- The power of Hermes.
		{ Cue = "/VO/ZagreusField_1994", CooldownName = "SaidHermesRecently", CooldownTime = 60 },
		-- Swift as Hermes.
		{ Cue = "/VO/ZagreusField_1995", CooldownName = "SaidHermesRecently", CooldownTime = 60 },
		-- Hermes would approve.
		{ Cue = "/VO/ZagreusField_1996", CooldownName = "SaidHermesRecently", CooldownTime = 60 },
		-- Short work.
		{ Cue = "/VO/ZagreusField_1997" },
	},
	KeepsakeChallengeFailedVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.2,
		RequiredFalseRooms = { "A_Boss01", "A_Boss02", "A_Boss03", "B_Boss01", "B_Boss02", "C_MiniBoss01", "C_Boss01", "D_Boss01" },
		RequiredFalseBiome = "Styx",
		Cooldowns =
		{
			{ Name = "ZagreusAnyQuipSpeech" },
		},

		-- Damn it...!
		{ Cue = "/VO/ZagreusField_3439" },
		-- Damn.
		{ Cue = "/VO/ZagreusField_3440" },
		-- Ah.
		{ Cue = "/VO/ZagreusField_3441" },
		-- Blast.
		{ Cue = "/VO/ZagreusField_3442" },
		-- Blood and...
		{ Cue = "/VO/ZagreusField_3443" },
		-- Nrgh...
		{ Cue = "/VO/ZagreusField_3444" },
		-- <Tsk>
		{ Cue = "/VO/ZagreusField_3445" },
		-- <Scoff>
		{ Cue = "/VO/ZagreusField_3446" },
		-- Not quite...
		{ Cue = "/VO/ZagreusField_3447" },
		-- The Butterfly...
		{ Cue = "/VO/ZagreusField_3448", RequiredTrait = "PerfectClearDamageBonusTrait", },
		-- Sorry, Than...
		{ Cue = "/VO/ZagreusField_3449", RequiredTrait = "PerfectClearDamageBonusTrait", },
		-- The Plume...
		{ Cue = "/VO/ZagreusField_3450", RequiredTrait = "FastClearDodgeBonusTrait", },
		-- Sorry, Hermes...
		{ Cue = "/VO/ZagreusField_3451", RequiredTrait = "FastClearDodgeBonusTrait", },
	},
	ThanatosExitReactionVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.6,
		SuccessiveChanceToPlay = 0.25,
		RequiredFalseTextLinesThisRun = { "BecameCloseWithThanatos01Than_GoToHim", "BecameCloseWithThanatos01_BThan_GoToHim" },
		Cooldowns =
		{
			{ Name = "ZagreusThanatosExitReactionSpeech", Time = 10 },
		},

		-- Bye...?
		{ Cue = "/VO/ZagreusField_1629", PreLineWait = 1.4, RequiredFalseTextLines = { "ThanatosGift06" } },
		-- Well, see you!
		{ Cue = "/VO/ZagreusField_1630", PreLineWait = 1.3, RequiredTextLines = { "ThanatosGift04" } },
		-- See you, Than.
		{ Cue = "/VO/ZagreusField_1631", RequiredTextLines = { "ThanatosGift05" } },
		-- Rude...!
		{ Cue = "/VO/ZagreusField_1632", PreLineWait = 0.7, RequiredFalseTextLines = { "ThanatosGift06" } },
		-- Typical.
		{ Cue = "/VO/ZagreusField_1633", RequiredFalseTextLines = { "ThanatosGift05" } },
		-- Wait, I...
		{ Cue = "/VO/ZagreusField_1634", PreLineWait = 0.5 },
		-- Oh, Than.
		{ Cue = "/VO/ZagreusField_1635", RequiredTextLines = { "ThanatosGift05" } },
		-- Poof.
		-- { Cue = "/VO/ZagreusField_1636", PreLineWait = 1.1, RequiredFalseTextLinesThisRun = { "ThanatosHomeChat18" } },
		-- Ugh.
		{ Cue = "/VO/ZagreusField_1637", PreLineWait = 1.1, RequiredFalseTextLines = { "ThanatosGift05" } },
		-- Bye, Than.
		{ Cue = "/VO/ZagreusField_3425", PreLineWait = 1.1, RequiredTextLines = { "ThanatosGift06" } },
		-- See you, Than...
		{ Cue = "/VO/ZagreusField_3426", PreLineWait = 1.1, RequiredTextLines = { "ThanatosGift05" } },
		-- There he goes.
		{ Cue = "/VO/ZagreusField_3427", RequiredTextLines = { "ThanatosGift03" } },
		-- And he's off.
		{ Cue = "/VO/ZagreusField_3428", RequiredTextLines = { "ThanatosGift07_A" } },
		-- Wish I could do that.
		{ Cue = "/VO/ZagreusField_3429", PreLineWait = 1.3, RequiredTextLines = { "ThanatosGift04" } },
		-- Thanks for the help.
		{ Cue = "/VO/ZagreusField_3430", PreLineWait = 1.1, RequiredTextLines = { "ThanatosGift06" } },
		-- <Sigh>
		{ Cue = "/VO/ZagreusField_4446", PreLineWait = 0.7, RequiredFalseTextLines = { "ThanatosGift06" } },
		-- <Scoff>
		{ Cue = "/VO/ZagreusField_4447", PreLineWait = 1.0, RequiredFalseTextLines = { "ThanatosGift06" } },
		-- Oh.
		{ Cue = "/VO/ZagreusField_4448", PreLineWait = 1.0, RequiredFalseTextLines = { "ThanatosGift06" } },
		-- How does he...
		{ Cue = "/VO/ZagreusField_4449", PreLineWait = 1.1 },
		-- Gone.
		{ Cue = "/VO/ZagreusField_4450", PreLineWait = 1.2 },
		-- Bye.
		{ Cue = "/VO/ZagreusField_4451", PreLineWait = 1.3 },
	},

	BiomeTimerAboutToExpireVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.75,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- I'm running out of time...!
		{ Cue = "/VO/ZagreusField_2617" },
		-- Time's running out...
		{ Cue = "/VO/ZagreusField_2618" },
		-- Time's almost up...
		{ Cue = "/VO/ZagreusField_2619" },
		-- Not much time left...
		{ Cue = "/VO/ZagreusField_2620" },
		-- I got to hurry it up...
		{ Cue = "/VO/ZagreusField_2621" },
		-- Oh no, the time...
		{ Cue = "/VO/ZagreusField_2622" },
	},
	BiomeTimerExpiredVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.75,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- Damn, time's up!
		{ Cue = "/VO/ZagreusField_2623" },
		-- Time's up!
		{ Cue = "/VO/ZagreusField_2624" },
		-- Oh no...
		{ Cue = "/VO/ZagreusField_2625" },
		-- I'm out of time!
		{ Cue = "/VO/ZagreusField_2626" },
		-- Out of time!
		{ Cue = "/VO/ZagreusField_2627" },
		-- The Pact!
		{ Cue = "/VO/ZagreusField_2628" },
		-- Ah, no time!
		{ Cue = "/VO/ZagreusField_2629" },
	},

	ForbiddenShopItemTakenVoiceLines =
	{
		Queue = "Interrupt",
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			PreLineWait = 1.5,

			-- Hey, free money! Whoops!
			{ Cue = "/VO/ZagreusField_3741", PreLineWait = 0.1, TriggerCooldowns = { "CharonSurprisedSpeech" }, RequiredPlayed = { "/VO/ZagreusField_3746" } },
			-- This must be here for me. Right?
			{ Cue = "/VO/ZagreusField_3742", PreLineWait = 0.1, TriggerCooldowns = { "CharonSurprisedSpeech" }, RequiredPlayed = { "/VO/ZagreusField_3746" } },
			-- Charon won't mind, will he?
			{ Cue = "/VO/ZagreusField_3743", PreLineWait = 0.1, TriggerCooldowns = { "CharonSurprisedSpeech" }, RequiredPlayed = { "/VO/ZagreusField_3746" } },
			-- Hey Charon, want to fight?
			{ Cue = "/VO/ZagreusField_3744", RequiredPlayed = { "/VO/ZagreusField_3746" } },
			-- Hey Charon, look at me!
			{ Cue = "/VO/ZagreusField_3745", RequiredPlayed = { "/VO/ZagreusField_3746" } },
			-- Wow, thank you, Charon!
			{ Cue = "/VO/ZagreusField_3746" },
			-- Whoops!
			{ Cue = "/VO/ZagreusHome_0091", RequiredPlayed = { "/VO/ZagreusField_3746" } },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.2,
			ObjectType = "NPC_Charon_01",

			-- Nrraaauuuggghhh!!
			{ Cue = "/VO/Charon_0041" },
			-- Hhhaaaauuuhhhhh!!
			{ Cue = "/VO/Charon_0042" },
			-- Hrrrauuugggghhhh!
			{ Cue = "/VO/Charon_0043" },
			-- Grrraauuuggggghhh!
			{ Cue = "/VO/Charon_0044" },
			-- Haaahhhhhhhhh....
			{ Cue = "/VO/Charon_0005" },
		},
	},
	ForbiddenShopItemCaughtVoiceLines =
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		PreLineWait = 0.73,
		UsePlayerSource = true,

		-- Sorry?
		{ Cue = "/VO/ZagreusField_2546", RequiredFalsePlayedThisRoom = { "/VO/ZagreusField_3743", "/VO/ZagreusField_3744", "/VO/ZagreusField_3745" } },
	},

	AssistActivatedVoiceLines =
	{
		Queue = "Interrupt",
		{
			{
				{
					RandomRemaining = true,
					PreLineWait = 0.05,
					UsePlayerSource = true,

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "FuryAssistTrait",
					},

					-- Megaera!
					{ Cue = "/VO/ZagreusField_2762" },
					-- Megaera?
					{ Cue = "/VO/ZagreusField_2763" },
					-- Meg, help!
					{ Cue = "/VO/ZagreusField_2764" },
					-- Meg!!
					{ Cue = "/VO/ZagreusField_2765" },
					-- Meg!!
					{ Cue = "/VO/ZagreusField_2766" },
					-- Hey Meg?
					{ Cue = "/VO/ZagreusField_2767" },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.05,
					UsePlayerSource = true,

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "SkellyAssistTrait",
					},

					-- Skelly!
					{ Cue = "/VO/ZagreusField_2768" },
					-- Skelly?
					{ Cue = "/VO/ZagreusField_2769" },
					-- Come forth, Skelly!
					{ Cue = "/VO/ZagreusField_2770" },
					-- Oh Skelly?!
					{ Cue = "/VO/ZagreusField_2771" },
					-- Skelly, help!
					{ Cue = "/VO/ZagreusField_2772" },
					-- To me, Skelly!
					{ Cue = "/VO/ZagreusField_2773" },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.05,
					UsePlayerSource = true,

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "ThanatosAssistTrait",
					},

					-- Thanatos!
					{ Cue = "/VO/ZagreusField_2820" },
					-- Thanatos?
					{ Cue = "/VO/ZagreusField_2821" },
					-- Than, help!
					{ Cue = "/VO/ZagreusField_2822" },
					-- Than!!
					{ Cue = "/VO/ZagreusField_2823" },
					-- Than!!
					{ Cue = "/VO/ZagreusField_2824" },
					-- Hey Than?
					{ Cue = "/VO/ZagreusField_2825" },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.05,
					UsePlayerSource = true,

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "SisyphusAssistTrait",
					},

					-- Sisyphus!
					{ Cue = "/VO/ZagreusField_2826" },
					-- Sisyphus?
					{ Cue = "/VO/ZagreusField_2827" },
					-- Bouldy!
					{ Cue = "/VO/ZagreusField_2828" },
					-- Bouldy?
					{ Cue = "/VO/ZagreusField_2829" },
					-- Go Sisyphus!
					{ Cue = "/VO/ZagreusField_2830" },
					-- Hey Bouldy!
					{ Cue = "/VO/ZagreusField_2831" },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.05,
					UsePlayerSource = true,

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "DusaAssistTrait",
					},

					-- Dusa!
					{ Cue = "/VO/ZagreusField_3006" },
					-- Dusa?
					{ Cue = "/VO/ZagreusField_3007" },
					-- Need you, Dusa!
					{ Cue = "/VO/ZagreusField_3008" },
					-- You hear me, Dusa?
					{ Cue = "/VO/ZagreusField_3009" },
					-- Dusa, you there?
					{ Cue = "/VO/ZagreusField_3010" },
					-- Dusa, help!
					{ Cue = "/VO/ZagreusField_3011" },
				},
				{
					RandomRemaining = true,
					PreLineWait = 0.05,
					UsePlayerSource = true,
					RequiredTrait = "AchillesPatroclusAssistTrait",

					-- Achilles!
					{ Cue = "/VO/ZagreusField_3583", RequiredPlayed = { "/VO/ZagreusField_3584" }, },
					-- Achilles!!
					{ Cue = "/VO/ZagreusField_3584" },
					-- Achilles?
					{ Cue = "/VO/ZagreusField_3585", RequiredPlayed = { "/VO/ZagreusField_3584" }, },
					-- Achilles, help!
					{ Cue = "/VO/ZagreusField_3586", RequiredPlayed = { "/VO/ZagreusField_3584" }, },
					-- Achilles, sir!
					{ Cue = "/VO/ZagreusField_3587", RequiredPlayed = { "/VO/ZagreusField_3584" }, },
				},

			},
			-- Megaera / Battie
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.MegVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredRooms = { "B_Boss01", "B_Boss02" },
						RequiredTrait = "FuryAssistTrait",
					},

					-- This monster, huh.
					{ Cue = "/VO/MegaeraField_0469" },
					-- Too hot for you here, Zag?
					{ Cue = "/VO/MegaeraField_0470" },
					-- Hydra trouble, Zagreus?
					{ Cue = "/VO/MegaeraField_0471" },
					-- Hello, Hydra.
					{ Cue = "/VO/MegaeraField_0472" },
					-- Back, Hydra!
					{ Cue = "/VO/MegaeraField_0473" },
					-- How can you stand this heat?
					{ Cue = "/VO/MegaeraField_0474" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.MegVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredRooms = { "C_MiniBoss01", },
						RequiredTrait = "FuryAssistTrait",
					},

					-- Hail, Asterius!
					{ Cue = "/VO/MegaeraField_0475" },
					-- Asterius!
					{ Cue = "/VO/MegaeraField_0476" },
					-- Pardon the interruption.
					{ Cue = "/VO/MegaeraField_0477" },
					-- So much for a fair fight.
					{ Cue = "/VO/MegaeraField_0478" },
					-- Looks like you have your hands full, Zagreus.
					{ Cue = "/VO/MegaeraField_0479" },
					-- Beware, Bull of Minos.
					{ Cue = "/VO/MegaeraField_0480" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.MegVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredRooms = { "C_Boss01", },
						RequiredTrait = "FuryAssistTrait",
						RequiredAnyUnitAlive = { "Theseus", "Theseus2" },
					},

					-- Beware me, Champion!
					{ Cue = "/VO/MegaeraField_0481" },
					-- Hail, King of Athens!
					{ Cue = "/VO/MegaeraField_0482" },
					-- Mind if I drop in?
					{ Cue = "/VO/MegaeraField_0483" },
					-- Let's even this up.
					{ Cue = "/VO/MegaeraField_0484" },
					-- Theseus!!
					{ Cue = "/VO/MegaeraField_0485" },
					-- Don't you touch him!
					{ Cue = "/VO/MegaeraField_0486" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.MegVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "FuryAssistTrait",
						RequiredRooms = { "D_Boss01", },
					},

					-- Forgive me, Lord Hades.
					{ Cue = "/VO/MegaeraField_0493" },
					-- Forgive me, lord.
					{ Cue = "/VO/MegaeraField_0494" },
					-- Lord Hades!
					{ Cue = "/VO/MegaeraField_0495" },
					-- I have to help him, lord!
					{ Cue = "/VO/MegaeraField_0496" },
					-- Really, Zagreus?!
					{ Cue = "/VO/MegaeraField_0497" },
					-- You are embarrassing me, Zag!
					{ Cue = "/VO/MegaeraField_0498" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.MegVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "FuryAssistTrait",
						RequiredEncounters = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro" },
						RequiredAnyUnitAlive = { "NPC_Thanatos_Field_01" },
					},

					-- Thanatos.
					{ Cue = "/VO/MegaeraField_0487" },
					-- Hi Than.
					{ Cue = "/VO/MegaeraField_0488" },
					-- How much help do you need?
					{ Cue = "/VO/MegaeraField_0489" },
					-- Don't you have enough help?
					{ Cue = "/VO/MegaeraField_0490" },
					-- You don't need me if he's here, Zagreus.
					{ Cue = "/VO/MegaeraField_0491" },
					-- Am I interrupting something?
					{ Cue = "/VO/MegaeraField_0492" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredRooms = { "CharonFight01", },
					RequiredTrait = "FuryAssistTrait",
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.MegVoice },

					-- Charon!
					{ Cue = "/VO/MegaeraField_0736", RequiredPlayed = { "/VO/MegaeraField_0738" }, },
					-- Hail, Charon!
					{ Cue = "/VO/MegaeraField_0737", RequiredPlayed = { "/VO/MegaeraField_0738" }, },
					-- Making me fight Charon?
					{ Cue = "/VO/MegaeraField_0738" },
					-- Here, Charon!
					{ Cue = "/VO/MegaeraField_0739", RequiredPlayed = { "/VO/MegaeraField_0738" }, },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.MegVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "FuryAssistTrait",
						RequiresUsedAssistLastRoom = true,
					},

					-- Not had enough of me?
					{ Cue = "/VO/MegaeraField_0499" },
					-- What, again?
					{ Cue = "/VO/MegaeraField_0500" },
					-- More help already?
					{ Cue = "/VO/MegaeraField_0501" },
					-- What is it now?
					{ Cue = "/VO/MegaeraField_0502" },
					-- Tsch already?
					{ Cue = "/VO/MegaeraField_0503" },
					-- You miss me, Zagreus?
					{ Cue = "/VO/MegaeraField_0504" },
					-- I'm here again.
					{ Cue = "/VO/MegaeraField_0505" },
					-- What, already?
					{ Cue = "/VO/MegaeraField_0506" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					Source = { SubtitleColor = Color.MegVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "FuryAssistTrait",
					},

					-- Hold on!
					{ Cue = "/VO/MegaeraField_0448" },
					-- I got you.
					{ Cue = "/VO/MegaeraField_0449" },
					-- I'm here.
					{ Cue = "/VO/MegaeraField_0450" },
					-- Get back.
					{ Cue = "/VO/MegaeraField_0451" },
					-- Zagreus!
					{ Cue = "/VO/MegaeraField_0452" },
					-- Zag!
					{ Cue = "/VO/MegaeraField_0453" },
					-- You called?
					{ Cue = "/VO/MegaeraField_0454" },
					-- Look at this mess!
					{ Cue = "/VO/MegaeraField_0455" },
					-- What a mess!
					{ Cue = "/VO/MegaeraField_0456" },
					-- Fine mess, Zag.
					{ Cue = "/VO/MegaeraField_0457" },
					-- I have this.
					{ Cue = "/VO/MegaeraField_0458" },
					-- Need help, Zag?
					{ Cue = "/VO/MegaeraField_0459" },
					-- I'll take care of this.
					{ Cue = "/VO/MegaeraField_0460" },
					-- No problem.
					{ Cue = "/VO/MegaeraField_0461" },
					-- Got your message.
					{ Cue = "/VO/MegaeraField_0462" },
					-- Keep fighting.
					{ Cue = "/VO/MegaeraField_0463" },
					-- Get away from him!
					{ Cue = "/VO/MegaeraField_0464" },
					-- Back off!
					{ Cue = "/VO/MegaeraField_0465" },
					-- Back. Off.
					{ Cue = "/VO/MegaeraField_0466" },
					-- Here!
					{ Cue = "/VO/MegaeraField_0467" },
					-- Get off him!
					{ Cue = "/VO/MegaeraField_0468" },
				},
			},

			-- Thanatos / Mort
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredRooms = { "A_Boss01", "A_Boss02", "A_Boss03" },
					RequiredTrait = "ThanatosAssistTrait",
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.ThanatosVoice },

					-- Megaera!
					{ Cue = "/VO/ThanatosField_0026", RequiredRoom = "A_Boss01" },
					-- Hate to have to do this.
					{ Cue = "/VO/ThanatosField_0027" },
					-- Pardon me!
					{ Cue = "/VO/ThanatosField_0028" },
					-- Forgive my rudeness here.
					{ Cue = "/VO/ThanatosField_0029" },
					-- Hate to butt in.
					{ Cue = "/VO/ThanatosField_0030", RequiredRoom = "A_Boss01" },
					-- Don't make me do this, Zag.
					{ Cue = "/VO/ThanatosField_0031" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.ThanatosVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredRooms = { "B_Boss01", "B_Boss02" },
						RequiredTrait = "ThanatosAssistTrait",
					},

					-- That thing causing trouble?
					{ Cue = "/VO/ThanatosField_0032" },
					-- Bad spot, there, Zag?
					{ Cue = "/VO/ThanatosField_0033" },
					-- Just won't stay dead will it.
					{ Cue = "/VO/ThanatosField_0034" },
					-- Hydra!
					{ Cue = "/VO/ThanatosField_0035" },
					-- Ugh this heat.
					{ Cue = "/VO/ThanatosField_0036" },
					-- What a mess.
					{ Cue = "/VO/ThanatosField_0037" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.ThanatosVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredRooms = { "C_MiniBoss01", },
						RequiredTrait = "ThanatosAssistTrait",
					},

					-- Bull of Minos!
					{ Cue = "/VO/ThanatosField_0038" },
					-- Greetings, Bull.
					{ Cue = "/VO/ThanatosField_0039" },
					-- Hail, Bull-man!
					{ Cue = "/VO/ThanatosField_0040" },
					-- Back off him, Bull.
					{ Cue = "/VO/ThanatosField_0041" },
					-- You'll die again, Bull-man.
					{ Cue = "/VO/ThanatosField_0042" },
					-- The Bull of Minos?
					{ Cue = "/VO/ThanatosField_0043" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.ThanatosVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredRooms = { "C_Boss01", },
						RequiredTrait = "ThanatosAssistTrait",
						RequiredAnyUnitAlive = { "Theseus", "Theseus2" },
					},

					-- King Theseus!
					{ Cue = "/VO/ThanatosField_0044" },
					-- Remember me, O King?
					{ Cue = "/VO/ThanatosField_0045" },
					-- Hail, King!
					{ Cue = "/VO/ThanatosField_0046" },
					-- The Champion himself!
					{ Cue = "/VO/ThanatosField_0047" },
					-- I'm back, King Theseus.
					{ Cue = "/VO/ThanatosField_0048" },
					-- Let's even up the odds.
					{ Cue = "/VO/ThanatosField_0049" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.ThanatosVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "ThanatosAssistTrait",
						RequiredRooms = { "D_Boss01", },
					},

					-- My lord!
					{ Cue = "/VO/ThanatosField_0050" },
					-- Forgive me, lord!
					{ Cue = "/VO/ThanatosField_0051" },
					-- Lord Hades!
					{ Cue = "/VO/ThanatosField_0052" },
					-- I must assist him, lord!
					{ Cue = "/VO/ThanatosField_0053" },
					-- This isn't what it looks like, lord!
					{ Cue = "/VO/ThanatosField_0054" },
					-- Really, Zagreus?!
					{ Cue = "/VO/ThanatosField_0055" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.ThanatosVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "ThanatosAssistTrait",
						RequiredRooms = { "CharonFight01", },
					},

					-- Charon!
					{ Cue = "/VO/ThanatosField_0210" },
					-- Greetings, Charon.
					{ Cue = "/VO/ThanatosField_0211" },
					-- Hail, Brother!
					{ Cue = "/VO/ThanatosField_0212" },
					-- Apologies, Brother.
					{ Cue = "/VO/ThanatosField_0213" },
					-- Leave him alone, Charon.
					{ Cue = "/VO/ThanatosField_0214" },
					-- Back off, Brother.
					{ Cue = "/VO/ThanatosField_0215" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.ThanatosVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "ThanatosAssistTrait",
						RequiresUsedAssistLastRoom = true,
					},

					-- Again?
					{ Cue = "/VO/ThanatosField_0056" },
					-- Once more then!
					{ Cue = "/VO/ThanatosField_0057" },
					-- Miss me, Zagreus?
					{ Cue = "/VO/ThanatosField_0058" },
					-- Can't get enough of me?
					{ Cue = "/VO/ThanatosField_0059" },
					-- More Death to go around.
					{ Cue = "/VO/ThanatosField_0060" },
					-- Already?
					{ Cue = "/VO/ThanatosField_0061" },
					-- Already huh.
					{ Cue = "/VO/ThanatosField_0062" },
					-- I'm back.
					{ Cue = "/VO/ThanatosField_0063" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					Source = { SubtitleColor = Color.ThanatosVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "ThanatosAssistTrait",
					},

					-- I'll take care of it.
					{ Cue = "/VO/Thanatos_0156" },
					-- Good as done.
					{ Cue = "/VO/Thanatos_0159" },
					-- I'll take care of it.
					{ Cue = "/VO/Thanatos_0161" },
					-- Death approaches!
					{ Cue = "/VO/ThanatosField_0009" },
					-- I got you.
					{ Cue = "/VO/ThanatosField_0010" },
					-- Hold on!
					{ Cue = "/VO/ThanatosField_0011" },
					-- Stand back.
					{ Cue = "/VO/ThanatosField_0012" },
					-- You called?
					{ Cue = "/VO/ThanatosField_0013" },
					-- I got this.
					{ Cue = "/VO/ThanatosField_0014" },
					-- No problem.
					{ Cue = "/VO/ThanatosField_0015" },
					-- I'm here.
					{ Cue = "/VO/ThanatosField_0016" },
					-- Zagreus.
					{ Cue = "/VO/ThanatosField_0017" },
					-- Need a hand?
					{ Cue = "/VO/ThanatosField_0018" },
					-- Look at this mess.
					{ Cue = "/VO/ThanatosField_0019" },
					-- Prepare to die!
					{ Cue = "/VO/ThanatosField_0020" },
					-- Death!
					{ Cue = "/VO/ThanatosField_0021" },
					-- Death Sentence!
					{ Cue = "/VO/ThanatosField_0022" },
					-- Time to die!
					{ Cue = "/VO/ThanatosField_0023" },
					-- Who's coming with me?
					{ Cue = "/VO/ThanatosField_0024" },
					-- It's time!
					{ Cue = "/VO/ThanatosField_0025" },
				},
			},

			-- Sisyphus & Bouldy
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.SisyphusVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredRooms = { "A_Boss01", "A_Boss02", "A_Boss03" },
						RequiredTrait = "SisyphusAssistTrait",
					},

					-- Pardon, Madam!!
					{ Cue = "/VO/Sisyphus_0290" },
					-- Payback time, Bouldy!
					{ Cue = "/VO/Sisyphus_0291" },
					-- It's the Fury Sisters!
					{ Cue = "/VO/Sisyphus_0292" },
					-- Ahoy, Madam!!
					{ Cue = "/VO/Sisyphus_0293" },
					-- Get her, Bouldy!
					{ Cue = "/VO/Sisyphus_0294" },
					-- Let's get the drop on her!
					{ Cue = "/VO/Sisyphus_0295" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.SisyphusVoice },
					
					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "SisyphusAssistTrait",
						RequiredEncounters = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro" },
						RequiredAnyUnitAlive = { "NPC_Thanatos_Field_01" },
					},

					-- It's Master Thanatos!
					{ Cue = "/VO/Sisyphus_0296" },
					-- Ahoy there, Master Thanatos!
					{ Cue = "/VO/Sisyphus_0297" },
					-- How goes it, Master Thanatos?!
					{ Cue = "/VO/Sisyphus_0298" },
					-- How's business, Master Thanatos?
					{ Cue = "/VO/Sisyphus_0299" },
					-- Don't mind me, Master Thanatos!
					{ Cue = "/VO/Sisyphus_0300" },
					-- Why if it isn't Master Thanatos!
					{ Cue = "/VO/Sisyphus_0301" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.SisyphusVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "SisyphusAssistTrait",
						RequiredRooms = { "D_Boss01", },
					},

					-- Why, Master Hades, sir!
					{ Cue = "/VO/Sisyphus_0302" },
					-- Ahoy Lord Hades sir!!
					{ Cue = "/VO/Sisyphus_0303" },
					-- Beg pardon Master Hades sir!
					{ Cue = "/VO/Sisyphus_0304" },
					-- Lord Hades himself!!
					{ Cue = "/VO/Sisyphus_0305" },
					-- Your Highnesses!!
					{ Cue = "/VO/Sisyphus_0306" },
					-- Now you two get along!
					{ Cue = "/VO/Sisyphus_0307" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.SisyphusVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "SisyphusAssistTrait",
						RequiredRooms = { "CharonFight01", },
					},

					-- Oh, Charon!
					{ Cue = "/VO/Sisyphus_0447" },
					-- It's Charon!
					{ Cue = "/VO/Sisyphus_0448" },
					-- Well if it isn't Charon!
					{ Cue = "/VO/Sisyphus_0449" },
					-- Here's something, Charon!
					{ Cue = "/VO/Sisyphus_0450" },
					-- Flatten him, Bouldy!
					{ Cue = "/VO/Sisyphus_0451" },
					-- Here's the fee, Charon!
					{ Cue = "/VO/Sisyphus_0452" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.SisyphusVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "SisyphusAssistTrait",
						RequiresUsedAssistLastRoom = true,
					},

					-- We're here for you, Highness!
					{ Cue = "/VO/Sisyphus_0308" },
					-- Prince Z., we're back!
					{ Cue = "/VO/Sisyphus_0309" },
					-- Get them again, Bouldy!
					{ Cue = "/VO/Sisyphus_0310" },
					-- We got you, Prince!
					{ Cue = "/VO/Sisyphus_0311" },
					-- Right here beside you, Prince!
					{ Cue = "/VO/Sisyphus_0312" },
					-- Time for another go, Bouldy!
					{ Cue = "/VO/Sisyphus_0313" },
					-- Bouldy coming through!
					{ Cue = "/VO/Sisyphus_0314" },
					-- Once more, Bouldy!
					{ Cue = "/VO/Sisyphus_0315" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					Source = { SubtitleColor = Color.SisyphusVoice },

					ExplicitRequirements = true,
					GameStateRequirements =
					{
						RequiredTrait = "SisyphusAssistTrait",
					},

					-- Look out below!
					{ Cue = "/VO/Sisyphus_0268" },
					-- Heads up!
					{ Cue = "/VO/Sisyphus_0269" },
					-- Prince Z.!
					{ Cue = "/VO/Sisyphus_0270" },
					-- Hang on, Prince!
					{ Cue = "/VO/Sisyphus_0271" },
					-- Gangway!!
					{ Cue = "/VO/Sisyphus_0272" },
					-- Bouldy!
					{ Cue = "/VO/Sisyphus_0273" },
					-- Here we go!
					{ Cue = "/VO/Sisyphus_0274" },
					-- Here goes!
					{ Cue = "/VO/Sisyphus_0275" },
					-- Coming through!
					{ Cue = "/VO/Sisyphus_0276" },
					-- Whoopsie!
					{ Cue = "/VO/Sisyphus_0277" },
					-- Ahoy, Prince!
					{ Cue = "/VO/Sisyphus_0278" },
					-- Ahoy!!
					{ Cue = "/VO/Sisyphus_0279" },
					-- Aaand, here!
					{ Cue = "/VO/Sisyphus_0280" },
					-- We got you, Highness!
					{ Cue = "/VO/Sisyphus_0281" },
					-- Happy to help!
					{ Cue = "/VO/Sisyphus_0282" },
					-- Coming right up!
					{ Cue = "/VO/Sisyphus_0283" },
					-- Here comes Bouldy!
					{ Cue = "/VO/Sisyphus_0284" },
					-- Bouldy, now!
					{ Cue = "/VO/Sisyphus_0285" },
					-- Hah, haaah!!
					{ Cue = "/VO/Sisyphus_0286" },
					-- Begging your pardon!!
					{ Cue = "/VO/Sisyphus_0287" },
					-- Hullo there Prince!!
					{ Cue = "/VO/Sisyphus_0288" },
					-- Got you covered!!
					{ Cue = "/VO/Sisyphus_0289" },
				},
				--[[ @ to be implemented "MissedTargetVoiceLines"
				{

					-- Whoops!
					{ Cue = "/VO/Sisyphus_0316" },
					-- Sorry!
					{ Cue = "/VO/Sisyphus_0317" },
					-- My fault!
					{ Cue = "/VO/Sisyphus_0318" },
					-- Bouldy!!
					{ Cue = "/VO/Sisyphus_0319" },
					-- Ah well!
					{ Cue = "/VO/Sisyphus_0320" },
					-- My mistake!
					{ Cue = "/VO/Sisyphus_0321" },
					-- Missed!
					{ Cue = "/VO/Sisyphus_0322" },
					-- We missed?
					{ Cue = "/VO/Sisyphus_0323" },
				}
				]]--
			},
			-- Skelly
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredTrait = "SkellyAssistTrait",
					RequiresUsedAssistLastRoom = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.SkellyVoice },

					-- I'm back, what did I miss?
					{ Cue = "/VO/Skelly_0382" },
					-- Need something else from me?
					{ Cue = "/VO/Skelly_0383" },
					-- Oh I will be right back!
					{ Cue = "/VO/Skelly_0384" },
					-- Be back in just a sec!
					{ Cue = "/VO/Skelly_0385" },
					-- You called again, boyo?
					{ Cue = "/VO/Skelly_0386" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredTrait = "SkellyAssistTrait",
					Source = { SubtitleColor = Color.SkellyVoice },

					-- Here you go!
					{ Cue = "/VO/Skelly_0143" },
					-- Oh hey guys.
					{ Cue = "/VO/Skelly_0154" },
					-- Hey who's your friend?
					{ Cue = "/VO/Skelly_0149" },
					-- Don't think I'm supposed to be here.
					{ Cue = "/VO/Skelly_0096" },
					-- What'd I miss?
					{ Cue = "/VO/Skelly_0107" },
					-- Miss me, boyo?
					{ Cue = "/VO/Skelly_0111" },
					-- Heeey.
					{ Cue = "/VO/Skelly_0112" },
					-- Oh hi.
					{ Cue = "/VO/Skelly_0113" },
					-- All right I'm back!
					{ Cue = "/VO/Skelly_0114" },
					-- Somebody messing with you, boyo?!
					{ Cue = "/VO/Skelly_0372" },
					-- You need a skeleton to stand around?
					{ Cue = "/VO/Skelly_0373" },
					-- Be there in just a second or two, pal!
					{ Cue = "/VO/Skelly_0374" },
					-- I shall answer the call, boyo!
					{ Cue = "/VO/Skelly_0375" },
					-- I hear you, pal, hang on!
					{ Cue = "/VO/Skelly_0376" },
					-- You called, boyo?
					{ Cue = "/VO/Skelly_0377" },
					-- Hey hey, what's going on?
					{ Cue = "/VO/Skelly_0378" },
					-- Thank you for calling pal!
					{ Cue = "/VO/Skelly_0379" },
					-- It's time to get beat up!
					{ Cue = "/VO/Skelly_0380" },
					-- Don't need to tell me twice!
					{ Cue = "/VO/Skelly_0381" },
				},
			},
			-- Dusa
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredTrait = "DusaAssistTrait",
					RequiresUsedAssistLastRoom = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.DusaVoice },

					-- Don't worry, Prince, I'm back!
					{ Cue = "/VO/Dusa_0254" },
					-- It's good to be back!!
					{ Cue = "/VO/Dusa_0255" },
					-- Need help with something else?
					{ Cue = "/VO/Dusa_0256" },
					-- Something else I can do for you?
					{ Cue = "/VO/Dusa_0257" },
					-- What else needs doing, Prince?
					{ Cue = "/VO/Dusa_0258" },
					-- Got more need taking care of, Prince?
					{ Cue = "/VO/Dusa_0259" },
					-- Aw, you called me back!
					{ Cue = "/VO/Dusa_0260" },
					-- Oh hi, remember me?!
					{ Cue = "/VO/Dusa_0261" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredTrait = "DusaAssistTrait",
					Source = { SubtitleColor = Color.DusaVoice },

					-- I got here right away!
					{ Cue = "/VO/Dusa_0191" },
					-- Something need cleaning up?
					{ Cue = "/VO/Dusa_0192" },
					-- You called, Prince Zagreus?
					{ Cue = "/VO/Dusa_0193" },
					-- Oh hi, I'm here, I'm here!
					{ Cue = "/VO/Dusa_0194" },
					-- Your gal's right here!
					{ Cue = "/VO/Dusa_0197" },
					-- Need a gorgon, Prince?
					{ Cue = "/VO/Dusa_0198" },
					-- Gorgon coming through!!
					{ Cue = "/VO/Dusa_0199" },
					-- I'm here, I-- here I am!
					{ Cue = "/VO/Dusa_0206" },
					-- It's my big chance!!
					{ Cue = "/VO/Dusa_0210" },
					-- It's time for me to shine!
					{ Cue = "/VO/Dusa_0211" },
					-- You got it, on the double!
					{ Cue = "/VO/Dusa_0213" },
				},
			},

			-- Achilles / Antos
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredTrait = "AchillesPatroclusAssistTrait",
					RequiresUsedAssistLastRoom = true,
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.AchillesVoice },

					-- We've returned!
					{ Cue = "/VO/Achilles_0303" },
					-- We heed you, lad.
					{ Cue = "/VO/Achilles_0304" },
					-- Once more, then!
					{ Cue = "/VO/Achilles_0305" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredRooms = { "C_MiniBoss01" },
					RequiredTrait = "AchillesPatroclusAssistTrait",
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.AchillesVoice },

					-- Asterius!
					{ Cue = "/VO/Achilles_0293" },
					-- The Bull of Minos!
					{ Cue = "/VO/Achilles_0294" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredRooms = { "C_Boss01" },
					RequiredAnyUnitAlive = { "Theseus", "Theseus2" },
					RequiredTrait = "AchillesPatroclusAssistTrait",
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.AchillesVoice },

					-- Why, it's the champion!
					{ Cue = "/VO/Achilles_0295" },
					-- Theseus causing trouble, lad?
					{ Cue = "/VO/Achilles_0296" },
					-- Time we unseated the champion.
					{ Cue = "/VO/Achilles_0297" },
				},
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					RequiredRooms = { "D_Boss01" },
					RequiredTrait = "AchillesPatroclusAssistTrait",
					SuccessiveChanceToPlayAll = 0.5,
					Source = { SubtitleColor = Color.AchillesVoice },

					-- You sure about this, lad?!
					{ Cue = "/VO/Achilles_0374" },
					-- Apologies, Master...
					{ Cue = "/VO/Achilles_0375" },
					-- Hope your father doesn't mind...!
					{ Cue = "/VO/Achilles_0376" },
					-- Your father won't like this!
					{ Cue = "/VO/Achilles_0377" },
				},
				{
					{
						RandomRemaining = true,
						RequiredTrait = "AchillesPatroclusAssistTrait",
						Source = { SubtitleColor = Color.AchillesVoice },

						-- Here!
						{ Cue = "/VO/Achilles_0272" },
						-- On our way!
						{ Cue = "/VO/Achilles_0273" },
						-- Ready!
						{ Cue = "/VO/Achilles_0274" },
						-- We hear you!
						{ Cue = "/VO/Achilles_0275" },
						-- We hear you, lad!
						{ Cue = "/VO/Achilles_0276" },
						-- Yes, lad!
						{ Cue = "/VO/Achilles_0277" },
						-- We'll be right there!
						{ Cue = "/VO/Achilles_0278" },
						-- Be right there!
						{ Cue = "/VO/Achilles_0279" },
						-- Steady, lad!
						{ Cue = "/VO/Achilles_0280" },
						-- This shall be quick.
						{ Cue = "/VO/Achilles_0281" },
						-- Patroclus!
						{ Cue = "/VO/Achilles_0282" },
						-- Now, Patroclus!
						{ Cue = "/VO/Achilles_0283" },
						-- Let's go, Pat!
						{ Cue = "/VO/Achilles_0284" },
						-- Now, Pat!
						{ Cue = "/VO/Achilles_0285" },
						-- Let's go!
						{ Cue = "/VO/Achilles_0286" },
						-- Now!
						{ Cue = "/VO/Achilles_0287" },
						-- Attack!
						{ Cue = "/VO/Achilles_0288" },
						-- To battle!
						{ Cue = "/VO/Achilles_0289" },
						-- Shall we?
						{ Cue = "/VO/Achilles_0290" },
						-- Come on, Pat!
						{ Cue = "/VO/Achilles_0291" },
						-- Ready!
						{ Cue = "/VO/Achilles_0292" },
					},
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						RequiredRooms = { "A_Boss01", "A_Boss02", "A_Boss03", "D_Boss01", "CharonFight01" },
						RequiredTrait = "AchillesPatroclusAssistTrait",
						SuccessiveChanceToPlayAll = 0.1,
						Source = { SubtitleColor = Color.PatroclusVoice },

						-- Let's fight a god, I guess!
						{ Cue = "/VO/Patroclus_0373", RequiredRoom = "D_Boss01" },
						-- Quite an adversary there!
						{ Cue = "/VO/Patroclus_0374" },
						-- Don't think this is our fight.
						{ Cue = "/VO/Patroclus_0375", RequiredRoom = "D_Boss01" },
						-- Fearsome opponent there!
						{ Cue = "/VO/Patroclus_0376" },
					},
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						RequiredRooms = { "C_MiniBoss01" },
						RequiredTrait = "AchillesPatroclusAssistTrait",
						SuccessiveChanceToPlayAll = 0.5,
						Source = { SubtitleColor = Color.PatroclusVoice },

						-- The bull himself!
						{ Cue = "/VO/Patroclus_0368" },
						-- Ah, the Bull of Minos!
						{ Cue = "/VO/Patroclus_0369" },
					},
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						RequiredRooms = { "C_Boss01" },
						RequiredAnyUnitAlive = { "Theseus", "Theseus2" },
						RequiredTrait = "AchillesPatroclusAssistTrait",
						SuccessiveChanceToPlayAll = 0.5,
						Source = { SubtitleColor = Color.PatroclusVoice },

						-- Why, it's the champion!
						{ Cue = "/VO/Patroclus_0370" },
						-- Hail, Theseus!
						{ Cue = "/VO/Patroclus_0371" },
						-- Ah, the champion...!
						{ Cue = "/VO/Patroclus_0372" },
					},
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						RequiredTrait = "AchillesPatroclusAssistTrait",
						RequiresUsedAssistLastRoom = true,
						SuccessiveChanceToPlayAll = 0.5,
						Source = { SubtitleColor = Color.PatroclusVoice },

						-- We're back!
						{ Cue = "/VO/Patroclus_0382" },
						-- Once more, then!
						{ Cue = "/VO/Patroclus_0383" },
						-- One more time!
						{ Cue = "/VO/Patroclus_0384" },
					},
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						RequiredTrait = "AchillesPatroclusAssistTrait",
						Source = { SubtitleColor = Color.PatroclusVoice },

						-- Here!
						{ Cue = "/VO/Patroclus_0347" },
						-- On our way!
						{ Cue = "/VO/Patroclus_0348" },
						-- Ready!
						{ Cue = "/VO/Patroclus_0349" },
						-- We hear you!
						{ Cue = "/VO/Patroclus_0350" },
						-- We hear you, stranger!
						{ Cue = "/VO/Patroclus_0351" },
						-- Yes, stranger!
						{ Cue = "/VO/Patroclus_0352" },
						-- We'll be right there!
						{ Cue = "/VO/Patroclus_0353" },
						-- Be right there!
						{ Cue = "/VO/Patroclus_0354" },
						-- Steady, stranger!
						{ Cue = "/VO/Patroclus_0355" },
						-- This shall be quick.
						{ Cue = "/VO/Patroclus_0356" },
						-- Achilles!
						{ Cue = "/VO/Patroclus_0357" },
						-- Achilles, together!
						{ Cue = "/VO/Patroclus_0358" },
						-- Together, Achilles!
						{ Cue = "/VO/Patroclus_0359" },
						-- Together, my friend!
						{ Cue = "/VO/Patroclus_0360" },
						-- Indeed, my friend!
						-- { Cue = "/VO/Patroclus_0361" },
						-- Indeed!
						{ Cue = "/VO/Patroclus_0362" },
						-- We have this!
						{ Cue = "/VO/Patroclus_0363" },
						-- Right behind you!
						{ Cue = "/VO/Patroclus_0364" },
						-- Just like old times!
						{ Cue = "/VO/Patroclus_0365" },
						-- Yes!
						{ Cue = "/VO/Patroclus_0366" },
						-- Ready here!
						{ Cue = "/VO/Patroclus_0367" },
					}
				},
			},
		},
	},

	AssistUnavailableVoiceLines =
	{
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.5,
				SuccessiveChanceToPlayAll = 0.33,
				RequiredAnyTrueFlags = { "DusaFiredFromJob", "DusaNotYetReHired" },
				RequiredTrait = "DusaAssistTrait",
				Cooldowns =
				{
					{ Name = "ZagreusAssistFailedSpeech", Time = 10 },
				},

				-- No sign of Dusa!
				{ Cue = "/VO/ZagreusField_3555" },
				-- Is Dusa really gone?
				{ Cue = "/VO/ZagreusField_3556" },
				-- Where's Dusa?
				{ Cue = "/VO/ZagreusField_3557" },
				-- Is Dusa really gone?
				{ Cue = "/VO/ZagreusField_3774" },
				-- I miss Dusa...!
				{ Cue = "/VO/ZagreusField_3775" },
				-- No word from Dusa?
				{ Cue = "/VO/ZagreusField_3776" },
				-- Dusa, where are you?
				{ Cue = "/VO/ZagreusField_3777" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.5,
				SuccessiveChanceToPlayAll = 0.2,
				RequiredRoom = "CharonFight01",
				RequiredTrait = "SkellyAssistTrait",
				Cooldowns =
				{
					{ Name = "ZagreusAssistFailedSpeech", Time = 10 },
				},

				-- Where's Skelly when you need him?
				{ Cue = "/VO/ZagreusField_3856" },
				-- Skelly, where are you?
				{ Cue = "/VO/ZagreusField_3857" },
				-- Blast, Skelly?!
				{ Cue = "/VO/ZagreusField_3858" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.5,
				SuccessiveChanceToPlay = 0.5,
				RequiredKillEnemiesFound = true,
				Cooldowns =
				{
					{ Name = "ZagreusAssistFailedSpeech", Time = 10 },
				},

				-- Don't think that's going to work!
				{ Cue = "/VO/ZagreusField_2936" },
				-- Can't do that here!
				{ Cue = "/VO/ZagreusField_2937" },
				-- You sure you won't assist me here, Meg?
				{ Cue = "/VO/ZagreusField_2938", RequiredTrait = { "FuryAssistTrait" }, RequiredRoom = "A_Boss01" },
				-- That doesn't work right now!
				{ Cue = "/VO/ZagreusField_2939" },
				-- Than can't help me here!
				{ Cue = "/VO/ZagreusField_2940", RequiredTrait = { "ThanatosAssistTrait" } },
				-- Meg can't help me here!
				{ Cue = "/VO/ZagreusField_2941", RequiredTrait = { "FuryAssistTrait" }, RequiredFalseRooms = { "A_Boss01" } },
				-- I can't do that right now!
				{ Cue = "/VO/ZagreusField_2942" },
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ObjectType = "Harpy",
			RequiredTrait = "FuryAssistTrait",
			SuccessiveChanceToPlay = 0.5,
			CooldownTime = 15,

			-- Nice try.
			{ Cue = "/VO/MegaeraField_0515" },
			-- What did you expect to happen there?
			{ Cue = "/VO/MegaeraField_0516" },
			-- That's not going to work.
			{ Cue = "/VO/MegaeraField_0517" },
			-- I don't think so.
			{ Cue = "/VO/MegaeraField_0518" },
			-- No saving you from this one.
			{ Cue = "/VO/MegaeraField_0519" },
			-- Hahaha, no.
			{ Cue = "/VO/MegaeraField_0520" },
			-- No way, Zag.
			{ Cue = "/VO/MegaeraField_0521" },
			-- Don't be absurd.
			{ Cue = "/VO/MegaeraField_0522" },
			-- Not a chance.
			{ Cue = "/VO/MegaeraField_0523" },
			-- Really?
			{ Cue = "/VO/MegaeraField_0524" },
			-- Come off it, Zag.
			{ Cue = "/VO/MegaeraField_0525" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			RequiredTrait = "FuryAssistTrait",
			RequiredRooms = { "A_Boss02", "A_Boss03" },
			RequiredSupportAINames = { "Megaera" },
			SuccessiveChanceToPlay = 0.5,
			CooldownTime = 15,

			-- Nice try.
			{ Cue = "/VO/MegaeraField_0515" },
			-- What did you expect to happen there?
			{ Cue = "/VO/MegaeraField_0516" },
			-- That's not going to work.
			{ Cue = "/VO/MegaeraField_0517" },
			-- I don't think so.
			{ Cue = "/VO/MegaeraField_0518" },
			-- No saving you from this one.
			{ Cue = "/VO/MegaeraField_0519" },
			-- Hahaha, no.
			{ Cue = "/VO/MegaeraField_0520" },
			-- No way, Zag.
			{ Cue = "/VO/MegaeraField_0521" },
			-- Don't be absurd.
			{ Cue = "/VO/MegaeraField_0522" },
			-- Not a chance.
			{ Cue = "/VO/MegaeraField_0523" },
			-- Really?
			{ Cue = "/VO/MegaeraField_0524" },
			-- Come off it, Zag.
			{ Cue = "/VO/MegaeraField_0525" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ObjectType = "NPC_Thanatos_Field_01",
			RequiredTrait = "ThanatosAssistTrait",
			SuccessiveChanceToPlay = 0.5,
			CooldownTime = 15,

			-- I think not.
			{ Cue = "/VO/ThanatosField_0072" },
			-- I'm already here!
			{ Cue = "/VO/ThanatosField_0073" },
			-- I'm here already, Zag!
			{ Cue = "/VO/ThanatosField_0074" },
			-- Don't be absurd.
			{ Cue = "/VO/ThanatosField_0075" },
			-- Really?
			{ Cue = "/VO/ThanatosField_0076" },
			-- Seriously?
			{ Cue = "/VO/ThanatosField_0077" },
			-- Come on, Zag.
			{ Cue = "/VO/ThanatosField_0078" },
			-- Really, Zagreus?
			{ Cue = "/VO/ThanatosField_0079" },
			-- Come off it, Zag.
			{ Cue = "/VO/ThanatosField_0080" },
			-- Only one of me, Zag!
			{ Cue = "/VO/ThanatosField_0081" },
			-- Quit messing around.
			{ Cue = "/VO/ThanatosField_0082" },
			-- Stop it.
			{ Cue = "/VO/ThanatosField_0083" },
			-- Cut it out.
			{ Cue = "/VO/ThanatosField_0084" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ObjectType = "Hades",
			SuccessiveChanceToPlay = 0.5,
			CooldownTime = 15,

			-- That won't be working here.
			{ Cue = "/VO/HadesField_0255" },
			-- No one shall help you here.
			{ Cue = "/VO/HadesField_0256" },
			-- Face me yourself!
			{ Cue = "/VO/HadesField_0257" },
			-- What is the matter, boy?
			{ Cue = "/VO/HadesField_0258" },
			-- No help is coming, boy!
			{ Cue = "/VO/HadesField_0259" },
			-- I do not think so.
			{ Cue = "/VO/HadesField_0260" },
			-- You think that Megaera would aid you, here?!
			{ Cue = "/VO/HadesField_0261", RequiredTrait = "FuryAssistTrait", },
			-- You truly think that Thanatos would defy me?!
			{ Cue = "/VO/HadesField_0262", RequiredTrait = "ThanatosAssistTrait", },
			-- What did you think would happen, boy?
			{ Cue = "/VO/HadesField_0263" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ObjectType = "NPC_Sisyphus_01",
			RequiredTrait = "SisyphusAssistTrait",
			SuccessiveChanceToPlay = 0.5,
			CooldownTime = 15,

			-- Not here, Prince!
			{ Cue = "/VO/Sisyphus_0324", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
			-- Haha, nice try there!
			{ Cue = "/VO/Sisyphus_0325" },
			-- Fraid not, Prince Z.
			{ Cue = "/VO/Sisyphus_0326", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
			-- What good would that do here?
			{ Cue = "/VO/Sisyphus_0327" },
			-- Oh come now.
			{ Cue = "/VO/Sisyphus_0328" },
			-- Already here to help!
			{ Cue = "/VO/Sisyphus_0329" },
			-- Call on us almost anytime!
			{ Cue = "/VO/Sisyphus_0330" },
			-- We're right here, Prince!
			{ Cue = "/VO/Sisyphus_0331", Cooldowns = { { Name = "SisyphusSaidPrinceRecently", Time = 10 }, }, },
			-- Come now, Highness!
			{ Cue = "/VO/Sisyphus_0332" },
			-- Call us when you need us!
			{ Cue = "/VO/Sisyphus_0333" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ObjectType = "NPC_Achilles_Story_01",
			RequiredTrait = "AchillesPatroclusAssistTrait",
			RequiredRoom = "C_Story01",
			SuccessiveChanceToPlay = 0.5,
			CooldownTime = 15,
			IsIdAlive = 563036,

			-- Yes, lad?
			{ Cue = "/VO/Achilles_0042" },
			-- Zagreus?
			{ Cue = "/VO/Achilles_0044" },
			-- Something you require?
			{ Cue = "/VO/Achilles_0045" },
			-- I'll give it my all.
			{ Cue = "/VO/Achilles_0054" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ObjectType = "NPC_Patroclus_01",
			RequiredTrait = "AchillesPatroclusAssistTrait",
			RequiredRoom = "C_Story01",
			SuccessiveChanceToPlay = 0.5,
			CooldownTime = 15,

			-- Already here.
			{ Cue = "/VO/Patroclus_0385" },
			-- Won't work here.
			{ Cue = "/VO/Patroclus_0386" },
			-- Hah, what would that even do.
			{ Cue = "/VO/Patroclus_0387" },
			-- I'm here already, thanks.
			{ Cue = "/VO/Patroclus_0388" },
			-- It's like you've summoned me.
			{ Cue = "/VO/Patroclus_0389" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ObjectType = "TrainingMelee",
			RequiredTrait = "SkellyAssistTrait",
			RequiredRoom = "RoomPreRun",
			SuccessiveChanceToPlay = 0.5,
			CooldownTime = 15,

			-- So you want to give it a rest, or what?
			{ Cue = "/VO/Skelly_0091" },
			-- All right, pal, you can stop!
			{ Cue = "/VO/Skelly_0092" },
			-- Anytime you want to stop, there, boyo.
			{ Cue = "/VO/Skelly_0093" },
			-- Well this is awkward!
			{ Cue = "/VO/Skelly_0094" },
			-- Uh kind of stuck here, pal.
			{ Cue = "/VO/Skelly_0097" },
		},
		{
			Queue = "Interrupt",
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			Cooldowns =
			{
				{ Name = "ZagreusAssistFailedSpeech", Time = 10 },
			},

			-- Not here.
			{ Cue = "/VO/ZagreusField_2779" },
			-- Not right now.
			{ Cue = "/VO/ZagreusField_2780", RequiredKillEnemiesFound = true },
			-- I wish.
			{ Cue = "/VO/ZagreusField_2781" },
			-- It's spent.
			-- { Cue = "/VO/ZagreusField_2782" },
			-- Out of charges.
			-- { Cue = "/VO/ZagreusField_2783" },
			-- I'm on my own.
			{ Cue = "/VO/ZagreusField_2784" },
			-- I'm out.
			-- { Cue = "/VO/ZagreusField_0081" },
			-- I can't.
			{ Cue = "/VO/ZagreusField_0083" },
			-- I'm empty.
			-- { Cue = "/VO/ZagreusField_0085" },
			-- Can't do that.
			{ Cue = "/VO/ZagreusField_0087" },
			-- Not now.
			{ Cue = "/VO/ZagreusField_0089" },
			-- Not yet.
			{ Cue = "/VO/ZagreusField_0238" },
		},
	},
	AssistCompletedVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlay = 0.75,
			RequiredTrait = "FuryAssistTrait",
			Source = { SubtitleColor = Color.MegVoice },

			-- Don't die.
			{ Cue = "/VO/MegaeraField_0507" },
			-- Keep going.
			{ Cue = "/VO/MegaeraField_0508" },
			-- See you.
			{ Cue = "/VO/MegaeraField_0509" },
			-- Got to go.
			{ Cue = "/VO/MegaeraField_0510" },
			-- Take it away.
			{ Cue = "/VO/MegaeraField_0511" },
			-- I have to go.
			{ Cue = "/VO/MegaeraField_0512" },
			-- Fight on.
			{ Cue = "/VO/MegaeraField_0513" },
			-- Got to get back.
			{ Cue = "/VO/MegaeraField_0514" },
		},
		{
			RandomRemaining = true,
			PreLineWait = 1.5,
			SuccessiveChanceToPlay = 0.75,
			RequiredTrait = "ThanatosAssistTrait",
			Source = { SubtitleColor = Color.ThanatosVoice },

			-- Don't die.
			{ Cue = "/VO/ThanatosField_0064" },
			-- Keep going.
			{ Cue = "/VO/ThanatosField_0065" },
			-- See you.
			{ Cue = "/VO/ThanatosField_0066" },
			-- I'm out.
			{ Cue = "/VO/ThanatosField_0067" },
			-- Got to go.
			{ Cue = "/VO/ThanatosField_0068" },
			-- Finish this.
			{ Cue = "/VO/ThanatosField_0069" },
			-- Farewell.
			{ Cue = "/VO/ThanatosField_0070" },
			-- Fight on!
			{ Cue = "/VO/ThanatosField_0071" },
		},
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.5,
				SuccessiveChanceToPlay = 0.5,
				RequiredTrait = "AchillesPatroclusAssistTrait",
				Source = { SubtitleColor = Color.AchillesVoice },

				-- We're off.
				{ Cue = "/VO/Achilles_0298" },
				-- Keep fighting!
				{ Cue = "/VO/Achilles_0299" },
				-- Fight on, lad!
				{ Cue = "/VO/Achilles_0300" },
				-- Keep going!
				{ Cue = "/VO/Achilles_0301" },
				-- Now finish this!
				{ Cue = "/VO/Achilles_0302" },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.5,
				SuccessiveChanceToPlay = 0.75,
				RequiredTrait = "AchillesPatroclusAssistTrait",
				Source = { SubtitleColor = Color.PatroclusVoice },
				RequiredFalsePlayedThisRoom = { "/VO/Achilles_0298", "/VO/Achilles_0299", "/VO/Achilles_0300", "/VO/Achilles_0301", "/VO/Achilles_0302" },

				-- Farewell!
				{ Cue = "/VO/Patroclus_0377" },
				-- Fight on!
				{ Cue = "/VO/Patroclus_0378" },
				-- Fight on, stranger!
				{ Cue = "/VO/Patroclus_0379" },
				-- Godspeed!
				{ Cue = "/VO/Patroclus_0380" },
				-- Godspeed, stranger!
				{ Cue = "/VO/Patroclus_0381" },
			},
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.4,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.2,
			RequiredFalseTraits = { "SkellyAssistTrait", "DusaAssistTrait" },

			-- Cheers!
			{ Cue = "/VO/ZagreusField_2774" },
			-- Bye now!
			{ Cue = "/VO/ZagreusField_2775" },
			-- See you!
			{ Cue = "/VO/ZagreusField_2776" },
			-- See you at home?
			{ Cue = "/VO/ZagreusField_2777", RequiredFalseTraits = { "SisyphusAssistTrait", "AchillesPatroclusAssistTrait" } },
			-- Thanks!
			{ Cue = "/VO/ZagreusField_2778" },
			-- Thank you!!
			{ Cue = "/VO/ZagreusField_3012" },
			-- I owe you one!
			{ Cue = "/VO/ZagreusField_3013" },
			-- OK good-bye!
			{ Cue = "/VO/ZagreusField_3014" },
			-- We'll chat later OK?
			{ Cue = "/VO/ZagreusField_3015" },
			-- Thank you for that!
			{ Cue = "/VO/ZagreusField_3016" },
		},
	},

	OverlookVoiceLines =
	{
		{
			PlayOnce = true,
			PreLineWait = 1.05,
			RequiresNotInRun = true,
			Queue = "Always",
			RequiredRunsCleared = 0,
			RequiredFalseTextLines = { "MegaeraGift06", "PersephoneFirstMeeting" },

			-- ...I can do this.
			{ Cue = "/VO/ZagreusField_0349", PreLineWait = 2.0, RequiredTrueFlags = { "Overlook" }, SetFlagTrue = "OverlookSpeech" },
			-- First, get past the wretched shades of Tartarus.
			{ Cue = "/VO/ZagreusField_0350", RequiredTrueFlags = { "Overlook" }, RequiredPlayedThisRoom = { "/VO/ZagreusField_0349" } },
			-- Easier said than done, and doubtless I'll be running into Meg.
			{ Cue = "/VO/ZagreusField_0351", RequiredTrueFlags = { "Overlook" }, RequiredPlayedThisRoom = { "/VO/ZagreusField_0350" } },
			-- The river of flame ought to be just beyond.
			{ Cue = "/VO/ZagreusField_0352", RequiredTrueFlags = { "Overlook" }, RequiredPlayedThisRoom = { "/VO/ZagreusField_0351" } },
			-- Find a way up to Elysium from there, and after that...
			{ Cue = "/VO/ZagreusField_0353", RequiredTrueFlags = { "Overlook" }, RequiredPlayedThisRoom = { "/VO/ZagreusField_0352" } },
			-- ...All right, let's give it another shot.
			{ Cue = "/VO/ZagreusField_0354", RequiredTrueFlags = { "Overlook" }, RequiredPlayedThisRoom = { "/VO/ZagreusField_0352" }, PreLineWait = 1.35, SetFlagFalse = "OverlookSpeech" },
			-- I can escape from the courtyard back there.
			{ Cue = "/VO/ZagreusHome_0462", RequiredCompletedRuns = 0, PlayOnce = true, PreLineWait = 1.1, RequiredFalsePlayed = { "/VO/ZagreusHome_0458" }, TriggerCooldowns = { Name = "ZagreusPreRunExitHintVoiceLines" }, },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 2.35,
			PlayOnceFromTableThisRun = true,
			RequiredRoom = "B_Intro",
			SuccessiveChanceToPlayAll = 0.4,

			-- Wasn't this whole expanse once lush and green?
			{ Cue = "/VO/ZagreusField_3017", RequiredTrueFlags = { "Overlook" }, },
			-- The Bloodless lie in wait out there I guess.
			{ Cue = "/VO/ZagreusField_3018", RequiredTrueFlags = { "Overlook" }, RequiredKills = { BloodlessNaked = 3 }, },
			-- It's nice and warm out here, I'll give it that.
			{ Cue = "/VO/ZagreusField_3019", RequiredTrueFlags = { "Overlook" }, },
			-- Just a few rides across the Phlegethon, and up we go.
			{ Cue = "/VO/ZagreusField_3020", RequiredTrueFlags = { "Overlook" }, RequiredSeenRooms = { "B_Wrapping01" }, },
			-- That blasted Hydra must be back by now.
			{ Cue = "/VO/ZagreusField_3021", RequiredTrueFlags = { "Overlook" }, RequiredRoomLastRun = "B_PostBoss01", },
			-- This place has definitely seen better days.
			{ Cue = "/VO/ZagreusField_3022", RequiredTrueFlags = { "Overlook" }, },
			-- This place has definitely seen better days. Or nights?
			{ Cue = "/VO/ZagreusField_3023", RequiredTrueFlags = { "Overlook" }, RequiredPlayed = { "/VO/ZagreusField_3022" } },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 2.35,
			PlayOnceFromTableThisRun = true,
			RequiredRoom = "C_Intro",
			SuccessiveChanceToPlayAll = 0.4,

			-- Lovely place to have to smash my way through.
			{ Cue = "/VO/ZagreusField_2705", RequiredTrueFlags = { "Overlook" }, },
			-- Lots of Exalted Shades between me and the exit.
			{ Cue = "/VO/ZagreusField_2706", RequiredTrueFlags = { "Overlook" }, RequiredSeenRooms = { "C_Boss01" } },
			-- Asterius and Theseus are probably expecting me.
			{ Cue = "/VO/ZagreusField_2707", RequiredTrueFlags = { "Overlook" }, RequiredSeenRooms = { "C_Boss01" } },
			-- Just need to storm my way through that eternal paradise.
			{ Cue = "/VO/ZagreusField_2708", RequiredTrueFlags = { "Overlook" }, },
			-- You know, if I was permanently dead maybe I wouldn't mind all this.
			{ Cue = "/VO/ZagreusField_2709", RequiredTrueFlags = { "Overlook" }, },
			-- For all his faults, Father did make this place look good.
			{ Cue = "/VO/ZagreusField_2710", RequiredTrueFlags = { "Overlook" }, },
			-- Wow...
			{ Cue = "/VO/ZagreusField_0285", RequiredTrueFlags = { "Overlook" }, },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 2.35,
			PlayOnceFromTableThisRun = true,
			RequiredFalsePlayedThisRoom = { "/VO/ZagreusField_0349", "/VO/ZagreusField_0350", "/VO/ZagreusField_0351", "/VO/ZagreusField_0352", "/VO/ZagreusField_0353", "/VO/ZagreusField_0354", "/VO/ZagreusHome_3533" },

			-- Another day in Tartarus. Or night, I have no idea.
			{ Cue = "/VO/ZagreusField_0348", RequiredTrueFlags = { "Overlook" }, RequiresNotInRun = true },
			-- Tartarus... I won't be stuck here all my life.
			{ Cue = "/VO/ZagreusField_0926", RequiredTrueFlags = { "Overlook" }, RequiresNotInRun = true, RequiredFalseTextLines = { "PersephoneFirstMeeting" }, },
			-- Just need to get from here across all that.
			{ Cue = "/VO/ZagreusField_0927", RequiredTrueFlags = { "Overlook" }, },
			-- I've gone farther than I can see from here.
			{ Cue = "/VO/ZagreusField_0928", RequiredTrueFlags = { "Overlook" }, RequiredRoomThisRun = "B_Intro" },
			-- The chambers of Tartarus have probably all rearranged themselves by now.
			{ Cue = "/VO/ZagreusField_0929", RequiredTrueFlags = { "Overlook" }, RequiresNotInRun = true,},
			-- I'm going to get through all this.
			{ Cue = "/VO/ZagreusField_0930", RequiredTrueFlags = { "Overlook" }, },
			-- Long way to go. Think I'm ready.
			{ Cue = "/VO/ZagreusField_0362", RequiredTrueFlags = { "Overlook" }, },
			-- The path toward the surface lies somewhere beyond all that.
			{ Cue = "/VO/ZagreusField_0363", RequiredTrueFlags = { "Overlook" }, RequiredFalseTextLines = { "Ending01" }, },
			-- I can do this. I can do this. I can do this.
			{ Cue = "/VO/ZagreusField_0364", RequiredTrueFlags = { "Overlook" }, TriggerCooldowns = { Name = "ZagreusBountyEarnedConfirmationVoiceLines" }, RequiredFalseTextLines = { "Ending01" }, },
			-- Through all that... the way to the surface...
			{ Cue = "/VO/ZagreusField_0365", RequiredTrueFlags = { "Overlook" }, },
			-- Wretches of the damned, beware. I'm coming back.
			{ Cue = "/VO/ZagreusField_0990", RequiredTrueFlags = { "Overlook" }, RequiredSeenRooms = { "C_Intro" }, RequiresNotInRun = true },
			-- Tartarus... strong enough to seal away the Titans. But not me.
			{ Cue = "/VO/ZagreusField_0991", RequiredTrueFlags = { "Overlook" }, RequiredSeenRooms = { "B_Intro" }, RequiresNotInRun = true },
			-- Fine day or whenever to get me out of here.
			{ Cue = "/VO/ZagreusField_0992", RequiredTrueFlags = { "Overlook" }, },
			-- I won't back down. Not now or ever.
			{ Cue = "/VO/ZagreusField_0993", RequiredTrueFlags = { "Overlook" }, },
			-- I know you're out there, Mother.
			{ Cue = "/VO/ZagreusField_0994", RequiredAnyTextLines = { "Flashback_Mother_01", "CerberusStyxMeeting01" }, RequiredFalseTextLines = { "Ending01" }, RequiredTrueFlags = { "Overlook" }, },
			-- The ever-shifting hell of Tartarus... you can't contain me, don't you know by now?
			{ Cue = "/VO/ZagreusHome_3533", PreLineWait = 2.0, RequiredTextLines = { "Ending01" }, RequiredTrueFlags = { "Overlook" }, RequiresNotInRun = true },
		}
	},
	OverlookLeaveVoiceLines =
	{
		PlayOnce = true,
		PreLineWait = 1.05,
		Queue = "Interrupt",
		RequiredPlayedThisRoom = { "/VO/ZagreusField_0349" },

		-- Eh I'll figure something out.
		{ Cue = "/VO/ZagreusField_0355", RequiredTrueFlags = { "OverlookSpeech" }, SetFlagFalse = "OverlookSpeech" },
	},
	RunAttemptsVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.6,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlay = 0.33,

		-- How many times has it been?
		{ Cue = "/VO/ZagreusHome_0301", RequiredMinCompletedRuns = 5 },
		-- How many times has it been now?
		{ Cue = "/VO/ZagreusHome_0302", RequiredMinCompletedRuns = 15 },
		-- As many chances as it takes.
		{ Cue = "/VO/ZagreusHome_0303", },
		-- Just need to keep at it.
		{ Cue = "/VO/ZagreusHome_0304", CooldownName = "SaidKeepAtItRecently", CooldownTime = 200 },
		-- That many tries so far?
		{ Cue = "/VO/ZagreusHome_0305", RequiredMinCompletedRuns = 20 },
	},
	UsedTelescopeVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.4,
		Cooldowns =
		{
			{ Name = "ZagreusUsedTelescopeVoiceLines", Time = 10 },
		},

		-- Let's have a bat's-eye view.
		{ Cue = "/VO/ZagreusHome_2740" },
		-- What do you see, bat friends?
		{ Cue = "/VO/ZagreusHome_2741", RequiredPlayed = { "/VO/ZagreusHome_2740" }, },
		-- You're free, bats!
		{ Cue = "/VO/ZagreusHome_2742", RequiredPlayed = { "/VO/ZagreusHome_2740" }, },
		-- You're free, bats! Temporarily.
		{ Cue = "/VO/ZagreusHome_2743", RequiredPlayed = { "/VO/ZagreusHome_2740", "/VO/ZagreusHome_2742" }, },
		-- Let's have a look at all this.
		{ Cue = "/VO/ZagreusHome_2744", RequiredPlayed = { "/VO/ZagreusHome_2740" }, },
		-- How's this place looking?
		{ Cue = "/VO/ZagreusHome_2745", RequiredPlayed = { "/VO/ZagreusHome_2740" }, },
		-- The House of Hades...
		{ Cue = "/VO/ZagreusHome_2746", RequiredPlayed = { "/VO/ZagreusHome_2740" }, PreLineWait = 1.0 },
		-- Go, bats, enjoy yourselves!
		{ Cue = "/VO/ZagreusHome_2747", RequiredPlayed = { "/VO/ZagreusHome_2740" }, },
	},
	UsedSundialVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		RequiredTextLines = { "Inspect_Sundial01" },
		Cooldowns =
		{
			{ Name = "ZagreusUsedSundialVoiceLines", Time = 60 },
		},

		-- I think it says it's 48 minutes past the seventh hour.
		{ Cue = "/VO/ZagreusHome_1868", RequiredPlayed = { "/VO/ZagreusHome_1872" }, },
		-- It's 7:48 right now I guess.
		{ Cue = "/VO/ZagreusHome_1869", RequiredPlayed = { "/VO/ZagreusHome_1872" }, },
		-- Looks like it's about 7:50.
		{ Cue = "/VO/ZagreusHome_1870", RequiredPlayed = { "/VO/ZagreusHome_1872" }, },
		-- It's almost 8 o'clock?
		{ Cue = "/VO/ZagreusHome_1871", RequiredPlayed = { "/VO/ZagreusHome_1872" }, },
		-- It's 7:48.
		{ Cue = "/VO/ZagreusHome_1872" },
		-- 7:48, that's a coincidence.
		{ Cue = "/VO/ZagreusHome_1873", RequiredPlayed = { "/VO/ZagreusHome_1872" }, },
		-- Still 7:48.
		{ Cue = "/VO/ZagreusHome_1874", RequiredPlayed = { "/VO/ZagreusHome_1872" }, },
		-- Let me guess... 7:48? It was.
		{ Cue = "/VO/ZagreusHome_1875", RequiredPlayed = { "/VO/ZagreusHome_1872" }, },
		-- It's still exactly 7:48.
		{ Cue = "/VO/ZagreusHome_1876", RequiredPlayed = { "/VO/ZagreusHome_1872" }, },
		-- It's 48 past seven.
		{ Cue = "/VO/ZagreusHome_1877", RequiredPlayed = { "/VO/ZagreusHome_1872" }, },
	},
	UsedLyreVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.2,
			SuccessiveChanceToPlay = 0.2,
			RequiredTextLines = { "OrpheusMusicProgress03" },
			RequiredMinItemInteractions = { HouseLyre01 = 200 },
			CooldownTime = 50,

			-- Mm-hmm.
			{ Cue = "/VO/ZagreusHome_1852" },
			-- I can play...
			{ Cue = "/VO/ZagreusHome_1853" },
			-- That's music...
			{ Cue = "/VO/ZagreusHome_1854" },
			-- Like that...
			{ Cue = "/VO/ZagreusHome_1855" },
			-- All right.
			{ Cue = "/VO/ZagreusHome_1856" },
			-- Whew.
			{ Cue = "/VO/ZagreusHome_1857" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.2,
			SuccessiveChanceToPlay = 0.2,
			RequiredAnyTextLines = { "OrpheusMusicProgress02", "OrpheusMusicProgress03" },
			RequiredMinItemInteractions = { HouseLyre01 = 110 },
			CooldownTime = 35,

			-- Decent.
			{ Cue = "/VO/ZagreusHome_1847" },
			-- Getting there.
			{ Cue = "/VO/ZagreusHome_1848" },
			-- Musical, right?
			{ Cue = "/VO/ZagreusHome_1849" },
			-- Hmm.
			{ Cue = "/VO/ZagreusHome_1850" },
			-- There.
			{ Cue = "/VO/ZagreusHome_1851" },
			-- Practice, practice.
			{ Cue = "/VO/ZagreusHome_1839" },
			-- Just need to keep at it.
			{ Cue = "/VO/ZagreusHome_0304", CooldownName = "SaidKeepAtItRecently", CooldownTime = 200 },
			-- Need practice.
			{ Cue = "/VO/ZagreusHome_1838" },
			-- OK...
			{ Cue = "/VO/ZagreusHome_1842" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.2,
			SuccessiveChanceToPlay = 0.25,
			RequiredTextLines = { "OrpheusMusicProgress02" },
			RequiredFalseTextLines = { "OrpheusMusicProgress03" },
			RequiredMinItemInteractions = { HouseLyre01 = 70 },
			CooldownTime = 25,

			-- OK...
			{ Cue = "/VO/ZagreusHome_1842" },
			-- It's something...
			{ Cue = "/VO/ZagreusHome_1843" },
			-- Any better?
			{ Cue = "/VO/ZagreusHome_1844" },
			-- Close enough.
			{ Cue = "/VO/ZagreusHome_1845" },
			-- Not quite there.
			{ Cue = "/VO/ZagreusHome_1846" },
			-- Just need to keep at it.
			{ Cue = "/VO/ZagreusHome_0304", CooldownName = "SaidKeepAtItRecently", CooldownTime = 200 },
			-- Need practice.
			{ Cue = "/VO/ZagreusHome_1838" },
			-- Practice, practice.
			{ Cue = "/VO/ZagreusHome_1839" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.2,
			SuccessiveChanceToPlay = 0.25,
			RequiredTextLines = { "OrpheusMusicProgress01" },
			RequiredFalseTextLines = { "OrpheusMusicProgress02", "OrpheusMusicProgress03" },
			RequiredMinItemInteractions = { HouseLyre01 = 30 },
			CooldownTime = 15,

			-- <Scoff>
			{ Cue = "/VO/ZagreusHome_1836" },
			-- This is hard.
			{ Cue = "/VO/ZagreusHome_1837" },
			-- Need practice.
			{ Cue = "/VO/ZagreusHome_1838" },
			-- Practice, practice.
			{ Cue = "/VO/ZagreusHome_1839" },
			-- I hate this thing.
			{ Cue = "/VO/ZagreusHome_1840" },
			-- That is a sound!
			{ Cue = "/VO/ZagreusHome_1841" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.2,
			SuccessiveChanceToPlay = 0.25,
			RequiredFalseTextLines = { "OrpheusMusicProgress01", "OrpheusMusicProgress02", "OrpheusMusicProgress03" },
			CooldownTime = 12,

			-- Yuck.
			{ Cue = "/VO/ZagreusField_1209" },
			-- Oy...
			{ Cue = "/VO/ZagreusField_1212" },
			-- Well....?
			{ Cue = "/VO/ZagreusHome_1832" },
			-- Eh...
			{ Cue = "/VO/ZagreusHome_1833" },
			-- Hrm...
			{ Cue = "/VO/ZagreusHome_1834" },
			-- Mm...
			{ Cue = "/VO/ZagreusHome_1835" },
		},
	},
	UsedPoetBustVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.65,
			RequiredTextLines = { "Inspect_PoetBust_01" },
			Cooldowns =
			{
				{ Name = "ZagreusUsedPoetBustVoiceLines", Time = 10 },
			},

			-- Erm... hello?
			{ Cue = "/VO/ZagreusField_0447" },
			-- You there, old man?
			{ Cue = "/VO/ZagreusHome_1908", RequiredPlayed = { "/VO/ZagreusHome_1913" } },
			-- Come out of there.
			{ Cue = "/VO/ZagreusHome_1909", RequiredPlayed = { "/VO/ZagreusHome_1913" } },
			-- Show yourself.
			{ Cue = "/VO/ZagreusHome_1910", RequiredPlayed = { "/VO/ZagreusHome_1913" } },
			-- I know you're in there.
			{ Cue = "/VO/ZagreusHome_1911", RequiredPlayed = { "/VO/ZagreusHome_1913" } },
			-- Say something.
			{ Cue = "/VO/ZagreusHome_1912", RequiredPlayed = { "/VO/ZagreusHome_1913" } },
			-- Hello?
			{ Cue = "/VO/ZagreusHome_1913" },
			-- Who is this swarthy looking character?
			{ Cue = "/VO/ZagreusHome_1914", RequiredPlayed = { "/VO/ZagreusHome_1913" } },
			-- I bet there were far greater poets.
			{ Cue = "/VO/ZagreusHome_1915", RequiredPlayed = { "/VO/ZagreusHome_1913" } },
			-- Hello....?
			{ Cue = "/VO/ZagreusHome_1916", RequiredPlayed = { "/VO/ZagreusHome_1913" } },
			-- Helloooo?
			{ Cue = "/VO/ZagreusHome_1917", RequiredPlayed = { "/VO/ZagreusHome_1913" } },
			-- I know you can hear me, old man.
			{ Cue = "/VO/ZagreusHome_1918", RequiredPlayed = { "/VO/ZagreusHome_1913" } },
			-- Say something!
			{ Cue = "/VO/ZagreusHome_1919", RequiredPlayed = { "/VO/ZagreusHome_1913" } },
		},
		{
			PreLineWait = 1.5,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlayAll = 0.25,
			NoTarget = true,
			RequiredPlayed = { "/VO/ZagreusHome_1908", "/VO/ZagreusHome_1909", "/VO/ZagreusHome_1910", "/VO/ZagreusHome_1911", "/VO/ZagreusHome_1912", "/VO/ZagreusHome_1913", "/VO/ZagreusHome_1914", "/VO/ZagreusHome_1915", "/VO/ZagreusHome_1916", "/VO/ZagreusHome_1917", "/VO/ZagreusHome_1918", "/VO/ZagreusHome_1919" },
			Cooldowns =
			{
				{ Name = "PoetSpokeRecently", Time = 40 },
			},
			Source = { SubtitleColor = Color.NarratorVoice },

			-- The vastly irritating Prince gets no response.
			{ Cue = "/VO/Storyteller_0298" },
			-- The Prince decides he's better things to do.
			{ Cue = "/VO/Storyteller_0299", RequiredPlayed = { "/VO/Storyteller_0298" }, },
			-- The often-dying Prince but wastes his time.
			{ Cue = "/VO/Storyteller_0300", RequiredPlayed = { "/VO/Storyteller_0298", "/VO/Storyteller_0299" }, },
			-- Should maybe the good Prince do something else?
			{ Cue = "/VO/Storyteller_0301", RequiredPlayed = { "/VO/Storyteller_0298", "/VO/Storyteller_0299", "/VO/Storyteller_0300", "/VO/Storyteller_0415", "/VO/Storyteller_0416", "/VO/Storyteller_0417" }, },
			-- The stone-inspecting Prince gleans nothing more.
			{ Cue = "/VO/Storyteller_0415", RequiredPlayed = { "/VO/Storyteller_0298" }, },
			-- Prince Zagreus decides to go about his business.
			{ Cue = "/VO/Storyteller_0416", RequiredPlayed = { "/VO/Storyteller_0298" }, },
			-- The Underworld Prince gawks needlessly at the visage of a distinguished poet.
			{ Cue = "/VO/Storyteller_0417", RequiredPlayed = { "/VO/Storyteller_0298", "/VO/Storyteller_0299", "/VO/Storyteller_0300" }, },
			-- Surely the Prince has more important objects to inspect?
			{ Cue = "/VO/Storyteller_0418", RequiredPlayed = { "/VO/Storyteller_0298", "/VO/Storyteller_0299", "/VO/Storyteller_0300", "/VO/Storyteller_0415", "/VO/Storyteller_0416", "/VO/Storyteller_0417" }, },
		}
	},
	UsedStatueVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		Cooldowns =
		{
			{ Name = "ZagreusUsedStatueVoiceLines", Time = 30 },
		},

		-- Poke.
		{ Cue = "/VO/ZagreusHome_3574", RequiredPlayed = { "/VO/ZagreusHome_3576", "/VO/ZagreusHome_3575" }, },
		-- Poke!
		{ Cue = "/VO/ZagreusHome_3575", RequiredPlayed = { "/VO/ZagreusHome_3576" }, },
		-- I paid for it, I can mess with it.
		{ Cue = "/VO/ZagreusHome_3576" },
		-- Greetings, Costly Artwork.
		{ Cue = "/VO/ZagreusHome_3577", RequiredPlayed = { "/VO/ZagreusHome_3576" }, },
		-- Hello, Decorative Object.
		{ Cue = "/VO/ZagreusHome_3578", RequiredPlayed = { "/VO/ZagreusHome_3576" }, },
		{ Cue = "/VO/ZagreusHome_3579", RequiredPlayed = { "/VO/ZagreusHome_3576" }, },
		-- Interesting texture.
		{ Cue = "/VO/ZagreusHome_3580", RequiredPlayed = { "/VO/ZagreusHome_3576" }, },
		-- Still fancy.
		{ Cue = "/VO/ZagreusHome_3581", RequiredPlayed = { "/VO/ZagreusHome_3576" }, },
	},
	UsedWaterCoolerVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		Cooldowns =
		{
			{ Name = "ZagreusAnyQuipSpeech" },
		},

		-- Not thirsty.
		{ Cue = "/VO/ZagreusHome_2390", },
		-- Still not thirsty.
		{ Cue = "/VO/ZagreusHome_2391", RequiredPlayed = { "/VO/ZagreusHome_2390" }, },
		-- Still definitely not thirsty.
		{ Cue = "/VO/ZagreusHome_2392", RequiredPlayed = { "/VO/ZagreusHome_2391" }, },
		-- Mm, no.
		{ Cue = "/VO/ZagreusHome_2393", RequiredPlayed = { "/VO/ZagreusHome_2390" }, },
		-- I've had enough Stygian water, thanks.
		{ Cue = "/VO/ZagreusHome_2394", RequiredPlayed = { "/VO/ZagreusHome_2390" }, },
		-- Never seen anyone drink this stuff.
		{ Cue = "/VO/ZagreusHome_2395", RequiredPlayed = { "/VO/ZagreusHome_2390" }, },
		-- I can wait till the next Fountain Chamber.
		{ Cue = "/VO/ZagreusHome_2396", RequiredPlayed = { "/VO/ZagreusHome_2390" }, RequiredAnyCosmetics = { "TartarusReprieve", "AsphodelReprieve", "ElysiumReprieve" } },
		-- No...
		{ Cue = "/VO/ZagreusHome_2397", RequiredPlayed = { "/VO/ZagreusHome_2390" }, },
		-- Not happening.
		{ Cue = "/VO/ZagreusHome_2398", RequiredPlayed = { "/VO/ZagreusHome_2390" }, },
		-- Never.
		{ Cue = "/VO/ZagreusHome_2399", RequiredPlayed = { "/VO/ZagreusHome_2390" }, },
	},
	UsedFamilyPortraitVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.0,
		SuccessiveChanceToPlayAll = 0.33,
		Cooldowns =
		{
			{ Name = "ZagreusAnyQuipSpeech" },
		},

		-- I could look at this painting all day or night.
		{ Cue = "/VO/ZagreusHome_2689", RequiredPlayed = { "/VO/ZagreusHome_2695" } },
		-- Can't believe Father's actually almost smiling.
		{ Cue = "/VO/ZagreusHome_2690", RequiredPlayed = { "/VO/ZagreusHome_2695" } },
		-- Cerberus looks so happy! Really perked up since Mother's been back.
		{ Cue = "/VO/ZagreusHome_2691", RequiredPlayed = { "/VO/ZagreusHome_2695" } },
		-- Father let me hold Gigaros for once.
		{ Cue = "/VO/ZagreusHome_2692", RequiredPlayed = { "/VO/ZagreusHome_2695" } },
		-- Was pretty awkward posing for this though it turned out quite nice.
		{ Cue = "/VO/ZagreusHome_2693", RequiredPlayed = { "/VO/ZagreusHome_2695" } },
		-- Father said I could admire the painting whenever I wanted, so I am!
		{ Cue = "/VO/ZagreusHome_2694", RequiredPlayed = { "/VO/ZagreusHome_2695" } },
		-- I can't entirely get used to seeing us together like this.
		{ Cue = "/VO/ZagreusHome_2695" },
		-- Mother looks beautiful. And right at home.
		{ Cue = "/VO/ZagreusHome_2696", RequiredPlayed = { "/VO/ZagreusHome_2695" } },
	},
	UsedOlympusSculptureVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		-- RequiredTextLines = { "InspectOlympusSculpture01" },

		-- Uncle Zeus and the others got us this lovely gift.
		{ Cue = "/VO/ZagreusHome_3672", RequiredPlayed = { "/VO/ZagreusHome_3676" }, },
		-- It's Mount Olympus...
		{ Cue = "/VO/ZagreusHome_3673", RequiredPlayed = { "/VO/ZagreusHome_3676" }, },
		-- Olympus must be bigger in real life.
		{ Cue = "/VO/ZagreusHome_3674", RequiredPlayed = { "/VO/ZagreusHome_3676" }, },
		-- Sure must be cold up there.
		{ Cue = "/VO/ZagreusHome_3675", RequiredPlayed = { "/VO/ZagreusHome_3676" }, },
		-- A little slice of Olympus.
		{ Cue = "/VO/ZagreusHome_3676" },
		-- Made of real Olympian stone.
		{ Cue = "/VO/ZagreusHome_3677", RequiredPlayed = { "/VO/ZagreusHome_3676" }, },
		-- Guess I made it to Olympus after all.
		{ Cue = "/VO/ZagreusHome_3678", RequiredPlayed = { "/VO/ZagreusHome_3676" }, },
		-- Wonder what the real Olympus is like.
		{ Cue = "/VO/ZagreusHome_3679", RequiredPlayed = { "/VO/ZagreusHome_3676" }, },
		-- So detailed...
		{ Cue = "/VO/ZagreusHome_3680", RequiredPlayed = { "/VO/ZagreusHome_3676" }, },
		-- Glad Father decided to keep this.
		{ Cue = "/VO/ZagreusHome_3681", RequiredPlayed = { "/VO/ZagreusHome_3676" }, },
	},

	-- employee of the month
	UsedEmployeeSignVoiceLines =
	{
		Queue = "Interrupt",
		{
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			BreakIfPlayed = true,
			PreLineWait = 0.45,

			-- Looks like Meg's the featured Houseservant right now.
			{ Cue = "/VO/ZagreusHome_2893", RequiredValues = { CurrentEmployeeOfTheMonth = "Megaera" }, RequiredPlayed = { "/VO/ZagreusHome_2472" }, PostLineFunctionName = "MegEmployeeSignReaction" },
			-- Meg's in the spotlight.
			{ Cue = "/VO/ZagreusHome_2894", RequiredValues = { CurrentEmployeeOfTheMonth = "Megaera" }, RequiredPlayed = { "/VO/ZagreusHome_2472" }, PostLineFunctionName = "MegEmployeeSignReaction" },
			-- Good for Megaera I guess.
			{ Cue = "/VO/ZagreusHome_2895", RequiredValues = { CurrentEmployeeOfTheMonth = "Megaera" }, RequiredPlayed = { "/VO/ZagreusHome_2472" }, PostLineFunctionName = "MegEmployeeSignReaction" },
			-- Megaera's always up there...
			{ Cue = "/VO/ZagreusHome_2896", RequiredValues = { CurrentEmployeeOfTheMonth = "Megaera" }, RequiredPlayed = { "/VO/ZagreusHome_2893", "/VO/ZagreusHome_2894", "/VO/ZagreusHome_2895", "/VO/ZagreusHome_2896" }, PostLineFunctionName = "MegEmployeeSignReaction" },
			-- Well done, then, Meg...
			{ Cue = "/VO/ZagreusHome_2897", RequiredValues = { CurrentEmployeeOfTheMonth = "Megaera" }, RequiredPlayed = { "/VO/ZagreusHome_2472" }, PostLineFunctionName = "MegEmployeeSignReaction" },
			-- Say, Meg's the featured servant of the House.
			{ Cue = "/VO/ZagreusHome_2469", RequiredValues = { CurrentEmployeeOfTheMonth = "Megaera" }, RequiredPlayed = { "/VO/ZagreusHome_2472" }, PostLineFunctionName = "MegEmployeeSignReaction" },
			-- Looks like Meg's the featured servant of the House.
			{ Cue = "/VO/ZagreusHome_2470", RequiredValues = { CurrentEmployeeOfTheMonth = "Megaera" }, RequiredPlayed = { "/VO/ZagreusHome_2472" }, PostLineFunctionName = "MegEmployeeSignReaction" },
			-- Meg's the featured servant of the House again.
			{ Cue = "/VO/ZagreusHome_2471", RequiredValues = { CurrentEmployeeOfTheMonth = "Megaera" }, RequiredPlayed = { "/VO/ZagreusHome_2893", "/VO/ZagreusHome_2894", "/VO/ZagreusHome_2895", "/VO/ZagreusHome_2896" }, PostLineFunctionName = "MegEmployeeSignReaction" },
			-- Megaera, the featured servant of the House.
			{ Cue = "/VO/ZagreusHome_2472", RequiredValues = { CurrentEmployeeOfTheMonth = "Megaera" }, PostLineFunctionName = "MegEmployeeSignReaction" },
			-- It's only ever Thanatos or Meg up there.
			{ Cue = "/VO/ZagreusHome_2478", RequiredValues = { CurrentEmployeeOfTheMonth = "Megaera" }, RequiredFalsePlayed = { "/VO/ZagreusHome_2903", "/VO/ZagreusHome_2908", "/VO/ZagreusHome_2913", "/VO/ZagreusHome_2915", "/VO/ZagreusHome_2922", "/VO/ZagreusHome_2926", "/VO/ZagreusHome_2927", "/VO/ZagreusHome_2931", "/VO/ZagreusHome_2935"  } },
			-- Thanatos, the featured Houseservant...
			{ Cue = "/VO/ZagreusHome_2898", RequiredValues = { CurrentEmployeeOfTheMonth = "Thanatos" }, RequiredPlayed = { "/VO/ZagreusHome_2476" } },
			-- Thanatos in the spotlight.
			{ Cue = "/VO/ZagreusHome_2899", RequiredValues = { CurrentEmployeeOfTheMonth = "Thanatos" }, RequiredPlayed = { "/VO/ZagreusHome_2476" } },
			-- Good for Thanatos.
			{ Cue = "/VO/ZagreusHome_2900", RequiredValues = { CurrentEmployeeOfTheMonth = "Thanatos" }, RequiredPlayed = { "/VO/ZagreusHome_2476" } },
			-- Thanatos does it again.
			{ Cue = "/VO/ZagreusHome_2901", RequiredValues = { CurrentEmployeeOfTheMonth = "Thanatos" }, RequiredPlayed = { "/VO/ZagreusHome_2476" } },
			-- Fine job, Thanatos.
			{ Cue = "/VO/ZagreusHome_2902", RequiredValues = { CurrentEmployeeOfTheMonth = "Thanatos" }, RequiredPlayed = { "/VO/ZagreusHome_2476" } },
			-- Than's the featured servant of the House again.
			{ Cue = "/VO/ZagreusHome_2473", RequiredValues = { CurrentEmployeeOfTheMonth = "Thanatos" }, RequiredPlayed = { "/VO/ZagreusHome_2476" } },
			-- Than's the featured servant, once again.
			{ Cue = "/VO/ZagreusHome_2474", RequiredValues = { CurrentEmployeeOfTheMonth = "Thanatos" }, RequiredPlayed = { "/VO/ZagreusHome_2476" } },
			-- Than's got the top honors again I guess.
			{ Cue = "/VO/ZagreusHome_2475", RequiredValues = { CurrentEmployeeOfTheMonth = "Thanatos" }, RequiredPlayed = { "/VO/ZagreusHome_2476" } },
			-- Thanatos, featured servant of the House.
			{ Cue = "/VO/ZagreusHome_2476", RequiredValues = { CurrentEmployeeOfTheMonth = "Thanatos" }, },
			-- It's only ever Thanatos or Meg up there.
			{ Cue = "/VO/ZagreusHome_2478", RequiredValues = { CurrentEmployeeOfTheMonth = "Thanatos" }, RequiredFalsePlayed = { "/VO/ZagreusHome_2903", "/VO/ZagreusHome_2908", "/VO/ZagreusHome_2913", "/VO/ZagreusHome_2915", "/VO/ZagreusHome_2922", "/VO/ZagreusHome_2926", "/VO/ZagreusHome_2927", "/VO/ZagreusHome_2931", "/VO/ZagreusHome_2935"  } },
			-- Cerberus, featured Houseservant!
			{ Cue = "/VO/ZagreusHome_2903", RequiredValues = { CurrentEmployeeOfTheMonth = "Cerberus" }, },
			-- Excellent work, Cerberus.
			{ Cue = "/VO/ZagreusHome_2904", RequiredValues = { CurrentEmployeeOfTheMonth = "Cerberus" }, RequiredPlayed = { "/VO/ZagreusHome_2903" } },
			-- Look who's officially the best boy.
			{ Cue = "/VO/ZagreusHome_2905", RequiredValues = { CurrentEmployeeOfTheMonth = "Cerberus" }, RequiredPlayed = { "/VO/ZagreusHome_2903" } },
			-- Cerberus in the spotlight.
			{ Cue = "/VO/ZagreusHome_2906", RequiredValues = { CurrentEmployeeOfTheMonth = "Cerberus" }, RequiredPlayed = { "/VO/ZagreusHome_2903" } },
			-- Achilles making the rounds!
			{ Cue = "/VO/ZagreusHome_2907", RequiredValues = { CurrentEmployeeOfTheMonth = "Achilles" }, RequiredPlayed = { "/VO/ZagreusHome_2908" } },
			{ Cue = "/VO/ZagreusHome_2908", RequiredValues = { CurrentEmployeeOfTheMonth = "Achilles" }, },
			-- The featured Houseservant, Achilles!
			{ Cue = "/VO/ZagreusHome_2909", RequiredValues = { CurrentEmployeeOfTheMonth = "Achilles" }, RequiredPlayed = { "/VO/ZagreusHome_2908" } },
			-- Good for Achilles.
			{ Cue = "/VO/ZagreusHome_2910", RequiredValues = { CurrentEmployeeOfTheMonth = "Achilles" }, RequiredPlayed = { "/VO/ZagreusHome_2908" } },
			-- Orpheus, our featured Houseservant!
			{ Cue = "/VO/ZagreusHome_2911", RequiredValues = { CurrentEmployeeOfTheMonth = "Orpheus" }, RequiredPlayed = { "/VO/ZagreusHome_2914" } },
			-- Orpheus made the board!
			{ Cue = "/VO/ZagreusHome_2912", RequiredValues = { CurrentEmployeeOfTheMonth = "Orpheus" }, RequiredPlayed = { "/VO/ZagreusHome_2914" } },
			-- Nice work, Orpheus!
			{ Cue = "/VO/ZagreusHome_2913", RequiredValues = { CurrentEmployeeOfTheMonth = "Orpheus" }, RequiredPlayed = { "/VO/ZagreusHome_2914" } },
			-- Orpheus got on the board!
			{ Cue = "/VO/ZagreusHome_2914", RequiredValues = { CurrentEmployeeOfTheMonth = "Orpheus" }, },
			-- The House Contractor, up in lights!
			{ Cue = "/VO/ZagreusHome_2915", RequiredValues = { CurrentEmployeeOfTheMonth = "HouseContractor" }, },
			-- House Contractor, you did it!
			{ Cue = "/VO/ZagreusHome_2916", RequiredValues = { CurrentEmployeeOfTheMonth = "HouseContractor" }, RequiredPlayed = { "/VO/ZagreusHome_2915" } },
			-- Fine work from the House Contractor.
			{ Cue = "/VO/ZagreusHome_2917", RequiredValues = { CurrentEmployeeOfTheMonth = "HouseContractor" }, RequiredPlayed = { "/VO/ZagreusHome_2915" } },
			-- We're proud of you, House Contractor.
			{ Cue = "/VO/ZagreusHome_2918", RequiredValues = { CurrentEmployeeOfTheMonth = "HouseContractor" }, RequiredPlayed = { "/VO/ZagreusHome_2915" } },
			-- Hey, nice one, Wretched Broker!
			{ Cue = "/VO/ZagreusHome_2919", RequiredValues = { CurrentEmployeeOfTheMonth = "WretchedBroker" }, RequiredPlayed = { "/VO/ZagreusHome_2922" }, PostLineFunctionName = "WretchedBrokerReaction" },
			-- The Wretched Broker did it!
			{ Cue = "/VO/ZagreusHome_2920", RequiredValues = { CurrentEmployeeOfTheMonth = "WretchedBroker" }, RequiredPlayed = { "/VO/ZagreusHome_2922" }, PostLineFunctionName = "WretchedBrokerReaction" },
			-- Fine work, Wretched Broker.
			{ Cue = "/VO/ZagreusHome_2921", RequiredValues = { CurrentEmployeeOfTheMonth = "WretchedBroker" }, RequiredPlayed = { "/VO/ZagreusHome_2922" }, PostLineFunctionName = "WretchedBrokerReaction" },
			-- Congratulations, Wretched Broker.
			{ Cue = "/VO/ZagreusHome_2922", RequiredValues = { CurrentEmployeeOfTheMonth = "WretchedBroker" }, PostLineFunctionName = "WretchedBrokerReaction" },
			-- The Head Chef pulled it off!
			{ Cue = "/VO/ZagreusHome_2923", RequiredValues = { CurrentEmployeeOfTheMonth = "HeadChef" }, RequiredPlayed = { "/VO/ZagreusHome_2926" } },
			-- The Head Chef is on the board!
			{ Cue = "/VO/ZagreusHome_2924", RequiredValues = { CurrentEmployeeOfTheMonth = "HeadChef" }, RequiredPlayed = { "/VO/ZagreusHome_2926" } },
			-- Good service from the Head Chef.
			{ Cue = "/VO/ZagreusHome_2925", RequiredValues = { CurrentEmployeeOfTheMonth = "HeadChef" }, RequiredPlayed = { "/VO/ZagreusHome_2926" } },
			-- Hey, not bad, Head Chef!
			{ Cue = "/VO/ZagreusHome_2926", RequiredValues = { CurrentEmployeeOfTheMonth = "HeadChef" }, },
			-- Hey Dusa's featured Houseservant!
			{ Cue = "/VO/ZagreusHome_2927", RequiredValues = { CurrentEmployeeOfTheMonth = "Dusa" }, RequiredPlayed = { "/VO/ZagreusHome_2930" }, },
			-- Dusa made the board!
			{ Cue = "/VO/ZagreusHome_2928", RequiredValues = { CurrentEmployeeOfTheMonth = "Dusa" }, RequiredPlayed = { "/VO/ZagreusHome_2930" }, },
			-- Hey, it's Dusa again!
			{ Cue = "/VO/ZagreusHome_2929", RequiredValues = { CurrentEmployeeOfTheMonth = "Dusa" }, RequiredPlayed = { "/VO/ZagreusHome_2930" }, },
			-- Dusa, you did it!
			{ Cue = "/VO/ZagreusHome_2930", RequiredValues = { CurrentEmployeeOfTheMonth = "Dusa" } },
			-- I must be dreaming. Hypnos?!
			{ Cue = "/VO/ZagreusHome_2931", RequiredValues = { CurrentEmployeeOfTheMonth = "Hypnos" }, },
			-- Wow, Hypnos made the board!
			{ Cue = "/VO/ZagreusHome_2932", RequiredValues = { CurrentEmployeeOfTheMonth = "Hypnos" }, RequiredPlayed = { "/VO/ZagreusHome_2931" }, },
			-- Nice work, Hypnos.
			{ Cue = "/VO/ZagreusHome_2933", RequiredValues = { CurrentEmployeeOfTheMonth = "Hypnos" }, RequiredPlayed = { "/VO/ZagreusHome_2931" }, },
			-- Hypnos, making us proud.
			{ Cue = "/VO/ZagreusHome_2934", RequiredValues = { CurrentEmployeeOfTheMonth = "Hypnos" }, RequiredPlayed = { "/VO/ZagreusHome_2931" }, },
			-- There must be some mistake...
			{ Cue = "/VO/ZagreusHome_2935", RequiredValues = { CurrentEmployeeOfTheMonth = "Zagreus" }, },
			-- Now who's this dashing fellow?
			{ Cue = "/VO/ZagreusHome_2936", RequiredValues = { CurrentEmployeeOfTheMonth = "Zagreus" }, RequiredPlayed = { "/VO/ZagreusHome_2935" }, },
			-- Hey, what do you know!
			{ Cue = "/VO/ZagreusHome_2937", RequiredValues = { CurrentEmployeeOfTheMonth = "Zagreus" }, RequiredPlayed = { "/VO/ZagreusHome_2935" }, },
			-- That's really me up there.
			{ Cue = "/VO/ZagreusHome_2938", RequiredValues = { CurrentEmployeeOfTheMonth = "Zagreus" }, RequiredPlayed = { "/VO/ZagreusHome_2935" }, },
		},
	},
	UsedOfficePosterVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,

		-- What a joke.
		{ Cue = "/VO/ZagreusHome_2388", RequiredPlayed = { "/VO/ZagreusHome_2882", "/VO/ZagreusHome_2883", "/VO/ZagreusHome_2884", "/VO/ZagreusHome_2889", "/VO/ZagreusHome_2890" } },
		-- Some mortals don't believe in ghosts, but I believe in you!
		{ Cue = "/VO/ZagreusHome_2882", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconDisgruntled", "StatusIconEyeRoll" }, ReactionChance = 0.5 } },
		-- Sleep is for the living, am I right?
		{ Cue = "/VO/ZagreusHome_2883", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconDisgruntled", "StatusIconEyeRoll" }, ReactionChance = 0.5 } },
		-- Mistakes are proof that you're doing you best!
		{ Cue = "/VO/ZagreusHome_2884", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconDisgruntled", "StatusIconEyeRoll" }, ReactionChance = 0.5 } },
		-- Remember: Hang in there!
		{ Cue = "/VO/ZagreusHome_2885", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconDisgruntled", "StatusIconEyeRoll" }, ReactionChance = 0.5 } },
		-- This poster's awful.
		-- { Cue = "/VO/ZagreusHome_2886", },
		-- These wall-scrolls are awful!
		{ Cue = "/VO/ZagreusHome_3097" },
		-- I don't know how you shades handle it honestly.
		{ Cue = "/VO/ZagreusHome_2887" },
		-- You shades hang in there.
		{ Cue = "/VO/ZagreusHome_2888" },
		-- Hanging in there still?
		{ Cue = "/VO/ZagreusHome_2889", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationName = "StatusIconDisgruntled", ReactionChance = 0.5 } },
		-- Everybody hanging in there, I take it?
		{ Cue = "/VO/ZagreusHome_2890", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationName = "StatusIconDisgruntled", ReactionChance = 0.5 } },
		-- Everybody hang in there!
		{ Cue = "/VO/ZagreusHome_2400", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconDisgruntled", "StatusIconEyeRoll" }, ReactionChance = 0.5 } },
		-- Limitless work, limitless time, am I right?
		{ Cue = "/VO/ZagreusHome_3093", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconDisgruntled", "StatusIconEyeRoll" }, ReactionChance = 0.5 } },
		-- Together, we can achieve anything my Father wants!
		{ Cue = "/VO/ZagreusHome_3094", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationName = "StatusIconDisgruntled", ReactionChance = 0.5 } },
		-- Who wants to hear a humorous jest of some sort?
		{ Cue = "/VO/ZagreusHome_3095", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationName = "StatusIconDisgruntled", ReactionChance = 0.5 } },
		-- Remember, work more intelligently, rather than with more ferocity!
		{ Cue = "/VO/ZagreusHome_3096", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconDisgruntled", "StatusIconEyeRoll" }, ReactionChance = 0.5 } },
		-- Seriously, you shades keep it up.
		{ Cue = "/VO/ZagreusHome_3098" },
		-- At least you're not working with me, though, right?
		{ Cue = "/VO/ZagreusHome_3099", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationNames = { "StatusIconDisgruntled", "StatusIconEmbarrassed" }, ReactionChance = 0.1 } },
	},
	UsedBarbellVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.65,
		Cooldowns =
		{
			{ Name = "ZagreusUsedBarbellVoiceLines", Time = 10 },
		},

		-- Won't budge at all.
		{ Cue = "/VO/ZagreusHome_1860" },
		-- They are completely stuck.
		{ Cue = "/VO/ZagreusHome_1861" },
		-- Utterly immovable.
		{ Cue = "/VO/ZagreusHome_1862" },
		-- Not even going to try.
		{ Cue = "/VO/ZagreusHome_1863" },
		-- These are unliftable.
		{ Cue = "/VO/ZagreusHome_1864" },
		-- Alas I am no Heracles.
		{ Cue = "/VO/ZagreusHome_1865" },
		-- Won't budge.
		{ Cue = "/VO/ZagreusHome_1866" },
		-- No way I'm lifting these.
		{ Cue = "/VO/ZagreusHome_1867" },
	},
	UsedGamingTableVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.85,
		Cooldowns =
		{
			{ Name = "ZagreusUsedGamingTableVoiceLines", Time = 12 },
		},

		-- Wait this requires a second player, doesn't it.
		{ Cue = "/VO/ZagreusHome_1878", PlayOnce = true },
		-- Don't have a player two.
		{ Cue = "/VO/ZagreusHome_1879", RequiredPlayed = { "/VO/ZagreusHome_1878" } },
		-- No one around here likes this stuff but me.
		{ Cue = "/VO/ZagreusHome_1880", RequiredPlayed = { "/VO/ZagreusHome_1878" } },
		-- It's unplayable in its current state.
		{ Cue = "/VO/ZagreusHome_1881", RequiredPlayed = { "/VO/ZagreusHome_1878" } },
		-- I don't have time for leisurely activities like this.
		{ Cue = "/VO/ZagreusHome_1882", RequiredPlayed = { "/VO/ZagreusHome_1878" } },
		-- It's probably not that fun.
		{ Cue = "/VO/ZagreusHome_1883", RequiredPlayed = { "/VO/ZagreusHome_1878" } },
		-- Not in the mood right now.
		{ Cue = "/VO/ZagreusHome_1884", RequiredPlayed = { "/VO/ZagreusHome_1878" } },
		-- Perhaps I'll never meet my match.
		{ Cue = "/VO/ZagreusHome_1885", RequiredPlayed = { "/VO/ZagreusHome_1878" } },
	},
	UsedAquariumVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.85,
		Cooldowns =
		{
			{ Name = "ZagreusUsedAquariumVoiceLines", Time = 12 },
		},

		-- Ooh look at all those.
		{ Cue = "/VO/ZagreusHome_2858" },
		-- You take good care of them, Head Chef!
		{ Cue = "/VO/ZagreusHome_2859" },
		-- Hello, fishies!
		{ Cue = "/VO/ZagreusHome_2860" },
		-- It is I, fishies!
		{ Cue = "/VO/ZagreusHome_2861" },
		-- Look at them go...
		{ Cue = "/VO/ZagreusHome_2862" },
		-- Fishies looking right at home.
		{ Cue = "/VO/ZagreusHome_2863" },
		-- Keep an eye on that Chef for me, fishies.
		{ Cue = "/VO/ZagreusHome_2864" },
		-- Hail, fishies.
		{ Cue = "/VO/ZagreusHome_2865" },
		-- How do you do, fishies?
		{ Cue = "/VO/ZagreusHome_2866" },
		-- They're really having a good time.
		{ Cue = "/VO/ZagreusHome_2867" },
		-- Greetings, river denizens.
		{ Cue = "/VO/ZagreusHome_3090" },
		-- Greetings, river denizens. Former.
		{ Cue = "/VO/ZagreusHome_3091", RequiredPlayed = { "/VO/ZagreusHome_3090" }, },
		-- How goes it, fishies?
		{ Cue = "/VO/ZagreusHome_3092" },
		-- That a Knucklehead in there?
		{ Cue = "/VO/ZagreusHome_2868", RequiredAnyCaughtFishTypes = { "Fish_Tartarus_Common_01" }, SuccessiveChanceToPlay = 0.02 },
		-- Hello, Hellfish!
		{ Cue = "/VO/ZagreusHome_2869", RequiredAnyCaughtFishTypes = { "Fish_Tartarus_Rare_01" }, SuccessiveChanceToPlay = 0.02 },
		-- Scyllascion swimming around.
		{ Cue = "/VO/ZagreusHome_2870", RequiredAnyCaughtFishTypes = { "Fish_Tartarus_Legendary_01" }, SuccessiveChanceToPlay = 0.02 },
		-- Look at that little Slavug.
		{ Cue = "/VO/ZagreusHome_2871", RequiredAnyCaughtFishTypes = { "Fish_Asphodel_Common_01" }, SuccessiveChanceToPlay = 0.02 },
		-- Chrustacean hanging in there I see.
		{ Cue = "/VO/ZagreusHome_2872", RequiredAnyCaughtFishTypes = { "Fish_Asphodel_Rare_01" }, SuccessiveChanceToPlay = 0.02 },
		-- That Flameater's acclimating well.
		{ Cue = "/VO/ZagreusHome_3089", RequiredAnyCaughtFishTypes = { "Fish_Asphodel_Legendary_01" }, SuccessiveChanceToPlay = 0.02 },
		-- That Chlam's doing fine in there.
		{ Cue = "/VO/ZagreusHome_2878", RequiredAnyCaughtFishTypes = { "Fish_Elysium_Common_01" }, SuccessiveChanceToPlay = 0.02 },
		-- That Charp seems to be doing well.
		{ Cue = "/VO/ZagreusHome_2873", RequiredAnyCaughtFishTypes = { "Fish_Elysium_Rare_01" }, SuccessiveChanceToPlay = 0.02 },
		-- Ooh look at the Seamare.
		{ Cue = "/VO/ZagreusHome_2874", RequiredAnyCaughtFishTypes = { "Fish_Elysium_Legendary_01" }, SuccessiveChanceToPlay = 0.02 },
		-- Nice place to be a Gupp.
		{ Cue = "/VO/ZagreusHome_2875", RequiredAnyCaughtFishTypes = { "Fish_Styx_Common_01" }, SuccessiveChanceToPlay = 0.02 },
		-- Hope that Scuffer likes the scenery.
		{ Cue = "/VO/ZagreusHome_2876", RequiredAnyCaughtFishTypes = { "Fish_Styx_Rare_01" }, SuccessiveChanceToPlay = 0.02 },
		-- Look at that Stonewhal...!
		{ Cue = "/VO/ZagreusHome_2877", RequiredAnyCaughtFishTypes = { "Fish_Styx_Legendary_01" }, SuccessiveChanceToPlay = 0.02 },
		-- That Mati seems to be adapting.
		{ Cue = "/VO/ZagreusHome_2879", RequiredAnyCaughtFishTypes = { "Fish_Chaos_Common_01" }, SuccessiveChanceToPlay = 0.02 },
		-- Pretty colors on that Projelly.
		{ Cue = "/VO/ZagreusHome_2880", RequiredAnyCaughtFishTypes = { "Fish_Chaos_Rare_01" }, SuccessiveChanceToPlay = 0.02 },
		-- Look at that Voidskate...
		{ Cue = "/VO/ZagreusHome_2881", RequiredAnyCaughtFishTypes = { "Fish_Chaos_Legendary_01" }, SuccessiveChanceToPlay = 0.02 },
		-- That Trout in there seems to be doing fine!
		{ Cue = "/VO/ZagreusHome_3530", RequiredAnyCaughtFishTypes = { "Fish_Surface_Common_01" }, SuccessiveChanceToPlay = 0.02 },
		-- Look at that Bass swishing about in there.
		{ Cue = "/VO/ZagreusHome_3531", RequiredAnyCaughtFishTypes = { "Fish_Surface_Rare_01" }, SuccessiveChanceToPlay = 0.02 },
		-- This Sturgeon's found himself a decent home.
		{ Cue = "/VO/ZagreusHome_3532", RequiredAnyCaughtFishTypes = { "Fish_Surface_Legendary_01" }, SuccessiveChanceToPlay = 0.02 },
	},

	GiftGivenVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.15,

		-- commented out, didn't seem needed [GK 3/10/19]
		-- Hey mate.
		-- { Cue = "/VO/ZagreusField_0340", },
		-- How's it going?
		-- { Cue = "/VO/ZagreusField_0342", },
		-- Hey there.
		-- { Cue = "/VO/ZagreusField_0344", },
	},
	PetCerberusVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.4,
			Cooldowns =
			{
				{ Name = "PetCerberusSpeechPlayed", Time = 15 },
			},

			-- There's a good boy.
			{ Cue = "/VO/ZagreusHome_0916" },

			-- You don't like it when I pet your other heads, huh? No!
			{ Cue = "/VO/ZagreusHome_1620", RequiredPlayed = { "/VO/ZagreusHome_0916" } },
			-- Here boy, just as long as one of your three heads enjoy these pets!
			{ Cue = "/VO/ZagreusHome_1621", RequiredPlayed = { "/VO/ZagreusHome_0916" } },
			-- If I don't pet your other heads, don't bite my arm off, deal?
			{ Cue = "/VO/ZagreusHome_1622", RequiredPlayed = { "/VO/ZagreusHome_0916" } },
			-- Not everybody knows exactly how to give you pets and live to tell of it, right, boy?
			{ Cue = "/VO/ZagreusHome_1623", RequiredPlayed = { "/VO/ZagreusHome_0916" } },

			-- Always have more pets for the greatest boy.
			{ Cue = "/VO/ZagreusHome_0917", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- How's my favorite boy doing, huh?
			{ Cue = "/VO/ZagreusHome_0918", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- Who's the best three-headed boy?
			{ Cue = "/VO/ZagreusHome_0919", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- You've always been there for me, boy.
			{ Cue = "/VO/ZagreusHome_0920", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- You are the best, you know that, don't you, boy?
			{ Cue = "/VO/ZagreusHome_0921", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- My mean old father's nice to you at least, isn't he, boy?
			{ Cue = "/VO/ZagreusHome_0922", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- You had enough to eat lately, haven't you boy?
			{ Cue = "/VO/ZagreusHome_0923", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- You like it when you get pets like this, don't you boy.
			{ Cue = "/VO/ZagreusHome_0924", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- You want more pets, I got more pets here, boy.
			{ Cue = "/VO/ZagreusHome_0925", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- Always feel better talking to you, boy.
			{ Cue = "/VO/ZagreusHome_0926", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- You don't let anybody in or out of this place, do you, boy.
			{ Cue = "/VO/ZagreusHome_0927", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- More pets? More pets.
			{ Cue = "/VO/ZagreusHome_0928", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- Circumstances call for more pets.
			{ Cue = "/VO/ZagreusHome_0929", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- More pets are certainly in order here.
			{ Cue = "/VO/ZagreusHome_0930", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
			-- You're my good boy! Yes you are.
			{ Cue = "/VO/ZagreusHome_0931", RequiredPlayed = { "/VO/ZagreusHome_1620" } },
		},
		{
			RandomRemaining = true,
			PreLineWait = 1.85,
			CooldownTime = 40,
			SuccessiveChanceToPlay = 0.33,
			ObjectType = "NPC_Hades_01",
			RequiredSourceValueFalse = "InPartnerConversation",

			-- I'm sorry he disturbed you, Cerberus.
			{ Cue = "/VO/Hades_0497" },
			-- Cease bothering the dog.
			{ Cue = "/VO/Hades_0498" },
			-- Permit the dog his rest.
			{ Cue = "/VO/Hades_0499" },
			-- Cerberus merely feigns concern for you.
			{ Cue = "/VO/Hades_0500", RequiredFalseTextLines = { "Ending01" }, },
			-- Do not let him manipulate you, Cerberus.
			{ Cue = "/VO/Hades_0501", RequiredFalseTextLines = { "Ending01" }, },
			-- Seek pity someplace else.
			{ Cue = "/VO/Hades_0502" },
			-- I grow nauseous merely listening to this.
			{ Cue = "/VO/Hades_0503" },
			-- Oh, please.
			{ Cue = "/VO/Hades_0504" },
			-- You're fortunate Cerberus sees something in you.
			{ Cue = "/VO/Hades_0505", RequiredFalseTextLines = { "Ending01" }, },
			-- The dog has enough troubles of his own.
			{ Cue = "/VO/Hades_0506" },
			-- <Scoff>
			{ Cue = "/VO/Hades_0507" },
			-- Eughh....
			{ Cue = "/VO/Hades_0508" },
		},
	},
	ClearedCerberusVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.5,

		-- Thanks, boy.
		{ Cue = "/VO/ZagreusField_2076", RequiredPlayed = { "/VO/ZagreusField_2079" } },
		-- Bye for now, boy.
		{ Cue = "/VO/ZagreusField_2077", RequiredPlayed = { "/VO/ZagreusField_2079" } },
		-- Thank you, boy.
		{ Cue = "/VO/ZagreusField_2078", RequiredPlayed = { "/VO/ZagreusField_2079" } },
		-- I owe you one, boy.
		{ Cue = "/VO/ZagreusField_2079" },
		-- See you, boy.
		{ Cue = "/VO/ZagreusField_2080", RequiredPlayed = { "/VO/ZagreusField_2079" } },
		-- I can go.
		{ Cue = "/VO/ZagreusField_2081", RequiredPlayed = { "/VO/ZagreusField_2079" } },
	},

	WellShopUsedVoiceLines =
	{
		Cooldowns =
		{
			{ Name = "ZagreusWellShopUsedSpeech", Time = 90 },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.8,
			SuccessiveChanceToPlayAll = 0.5,
			RequiredInStore = "LastStandDrop",
			RequiredInStoreUnaffordable = "LastStandDrop",

			-- Damn it, can't get that.
			{ Cue = "/VO/ZagreusField_4421" },
			-- I needed one of those...
			{ Cue = "/VO/ZagreusField_4422" },
			-- Bad time to be a little short of coin.
			{ Cue = "/VO/ZagreusField_4423" },
			-- Just what I need, except...
			{ Cue = "/VO/ZagreusField_4424" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.8,
			SuccessiveChanceToPlayAll = 0.5,
			RequiredInStore = "LastStandDrop",
			RequiredInStoreAffordable = "LastStandDrop",

			-- Exactly what I need.
			{ Cue = "/VO/ZagreusField_4416" },
			-- That'll keep me alive.
			{ Cue = "/VO/ZagreusField_4417" },
			-- Beats dying.
			{ Cue = "/VO/ZagreusField_4418" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.33,
			PreLineWait = 0.65,
			SkipAnim = true,
			RequiredFalseRooms = { "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },

			-- What's on offer.
			{ Cue = "/VO/ZagreusField_0417", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- Let's see what's in here.
			{ Cue = "/VO/ZagreusField_0418" },
			-- Something I can use?
			{ Cue = "/VO/ZagreusField_0419", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- Should be something useful here.
			{ Cue = "/VO/ZagreusField_0420", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- Some of Charon's wares.
			{ Cue = "/VO/ZagreusField_0421", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- What's for sale.
			{ Cue = "/VO/ZagreusField_0422", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- What's for sale?
			{ Cue = "/VO/ZagreusField_0423", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- Let's see...
			{ Cue = "/VO/ZagreusField_0203", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- Let's see.
			{ Cue = "/VO/ZagreusHome_0056", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- Let's have a look here.
			{ Cue = "/VO/ZagreusHome_0057", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- Hmm.
			{ Cue = "/VO/ZagreusHome_0058", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- What's in the pool this time.
			{ Cue = "/VO/ZagreusField_4053", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- What's in the Well this time?
			{ Cue = "/VO/ZagreusField_4054", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- What do we have.
			{ Cue = "/VO/ZagreusField_4055", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- Show me, Charon.
			{ Cue = "/VO/ZagreusField_4056", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- Anything I need?
			{ Cue = "/VO/ZagreusField_4057", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- Something I need?
			{ Cue = "/VO/ZagreusField_4058", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- Hm, let's see here.
			{ Cue = "/VO/ZagreusField_4059", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
			-- Check the old Well...
			{ Cue = "/VO/ZagreusField_4060", RequiredPlayed = { "/VO/ZagreusField_0418" }, },
		},
	},
	WellShopSoldOutVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		CooldownTime = 60,
		PreLineWait = 0.65,
		SkipAnim = true,

		-- Sold out.
		{ Cue = "/VO/ZagreusField_0878" },
		-- Out of stock.
		{ Cue = "/VO/ZagreusField_0879" },
		-- They're fresh out.
		{ Cue = "/VO/ZagreusField_0880" },
		-- Bought them out.
		{ Cue = "/VO/ZagreusField_0881" },
		-- Nothing left.
		{ Cue = "/VO/ZagreusField_0882" },
		-- Bought it all up.
		{ Cue = "/VO/ZagreusField_0883" },
		-- Bought 'em all up.
		{ Cue = "/VO/ZagreusHome_0658" },
		-- Fresh out of stock for now.
		{ Cue = "/VO/ZagreusHome_0661" },
	},
	SellTraitShopUsedVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		CooldownTime = 60,
		SuccessiveChanceToPlay = 0.5,
		PreLineWait = 0.65,
		SkipAnim = true,

		-- Can wash away my boons.
		{ Cue = "/VO/ZagreusField_2026" },
		-- Purge boons for coin.
		{ Cue = "/VO/ZagreusField_2027", RequiredPlayed = { "/VO/ZagreusField_2026" } },
		-- Any boons worth giving up?
		{ Cue = "/VO/ZagreusField_2028", RequiredPlayed = { "/VO/ZagreusField_2026" } },
		-- Let's think about this.
		{ Cue = "/VO/ZagreusField_2029", RequiredPlayed = { "/VO/ZagreusField_2026" } },
		-- Do I still need these?
		{ Cue = "/VO/ZagreusField_2030", RequiredPlayed = { "/VO/ZagreusField_2026" } },
		-- Should I take the trade.
		{ Cue = "/VO/ZagreusField_2031", RequiredPlayed = { "/VO/ZagreusField_2026" } },
		-- Should I take the trade?
		{ Cue = "/VO/ZagreusField_2032", RequiredPlayed = { "/VO/ZagreusField_2026" } },
	},
	SoldTraitVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 0.45,
			CooldownTime = 30,
			SuccessiveChanceToPlay = 0.75,
			RequiredActiveMetaUpgrade = "ForceSell",
			RequiredRooms = { "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },
			PlayOnceFromTableThisRun = true,

			-- Underworld Customs...
			{ Cue = "/VO/ZagreusField_3907" },
			-- There you go, Underworld Customs.
			{ Cue = "/VO/ZagreusField_3908" },
			-- This one's for you, Underworld Customs.
			{ Cue = "/VO/ZagreusField_3909" },
			-- Only way to get through Customs.
			{ Cue = "/VO/ZagreusField_3910" },
			-- Got to get through Customs.
			{ Cue = "/VO/ZagreusField_3911" },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.45,
			CooldownTime = 30,
			SuccessiveChanceToPlay = 0.75,

			-- That's one less boon.
			{ Cue = "/VO/ZagreusField_2033" },
			-- Feel cleaner already.
			{ Cue = "/VO/ZagreusField_2034" },
			-- There goes that one.
			{ Cue = "/VO/ZagreusField_2035" },
			-- Won't be needing that.
			{ Cue = "/VO/ZagreusField_2036" },
			-- Could use the extra coin.
			{ Cue = "/VO/ZagreusField_2037", RequiredFalseTraits = { "ChaosCurseNoMoneyTrait" }, },
			-- Whoo, that's cold.
			{ Cue = "/VO/ZagreusField_2038" },
			-- The gods won't mind.
			{ Cue = "/VO/ZagreusField_2039" },
		},
	},
	SellTraitShopSoldOutVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		CooldownTime = 60,
		PreLineWait = 0.65,
		SkipAnim = true,

		-- No boons I can purge.
		{ Cue = "/VO/ZagreusField_2040" },
		-- Can't use this now.
		{ Cue = "/VO/ZagreusField_2041" },
		-- Looks like I'm clean.
		{ Cue = "/VO/ZagreusField_2042" },
		-- Not much I can do with this now.
		{ Cue = "/VO/ZagreusField_2043" },
		-- No coin left in this pool.
		{ Cue = "/VO/ZagreusField_2044" },
		-- Nothing to do here.
		{ Cue = "/VO/ZagreusField_2045" },
	},

	-- Fishing
	FishingInitiatedVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.85,
		TriggerCooldowns = { Name = "ApproachedCerberusSpeech" },
		Cooldowns =
		{
			{ Name = "ZagreusStartedFishingSpeech", Time = 5 },
		},

		-- Here, fishies.
		{ Cue = "/VO/ZagreusField_3032", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Come forth, fishes.
		{ Cue = "/VO/ZagreusField_3033", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Let's fish.
		{ Cue = "/VO/ZagreusField_3034" },
		-- Looks like a good spot.
		{ Cue = "/VO/ZagreusField_3035", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Fishing time.
		{ Cue = "/VO/ZagreusField_3036", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Fishing time, then.
		{ Cue = "/VO/ZagreusField_3037", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Come to me, fishies.
		{ Cue = "/VO/ZagreusField_3038", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Come, fishies.
		{ Cue = "/VO/ZagreusField_3039", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Time to fish.
		{ Cue = "/VO/ZagreusField_3040", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Always time to fish.
		{ Cue = "/VO/ZagreusField_3041", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Sure, why not.
		{ Cue = "/VO/ZagreusField_3042", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- I know you're out there, fish.
		{ Cue = "/VO/ZagreusField_3043", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- It's you or me, fishies.
		{ Cue = "/VO/ZagreusField_3217", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Come on, you Knuckleheads.
		{ Cue = "/VO/ZagreusField_3218", RequiredBiome = "Tartarus", RequiredPlayed = { "/VO/ZagreusField_3034", "/VO/ZagreusField_3064" } },
		-- Denizens of the deep, arise.
		{ Cue = "/VO/ZagreusField_3219", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Got to hold nice and still.
		{ Cue = "/VO/ZagreusField_3220", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- What lurks in the River Styx?
		{ Cue = "/VO/ZagreusField_3221", RequiredBiome = "Tartarus", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Hard to see in all that red.
		{ Cue = "/VO/ZagreusField_3222", RequiredBiome = "Tartarus", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- What lurks in the River Phlegethon?
		{ Cue = "/VO/ZagreusField_3223", RequiredBiome = "Asphodel", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- I'll save you from the lava, fishes.
		{ Cue = "/VO/ZagreusField_3224", RequiredBiome = "Asphodel", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- What lurks in the River Lethe?
		{ Cue = "/VO/ZagreusField_3225", RequiredBiome = "Elysium", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Here's something to remember, fishies.
		{ Cue = "/VO/ZagreusField_3226", RequiredBiome = "Elysium", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- What lurks in this surface river here?
		{ Cue = "/VO/ZagreusField_3227", RequiredBiome = "Styx", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- What lurks in the waters of the surface?
		{ Cue = "/VO/ZagreusField_3228", RequiredBiome = "Styx", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- What lurks in the waters of chaos?
		{ Cue = "/VO/ZagreusField_3229", RequiredBiome = "Secrets", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- Fish swimming in primordial ooze, my favorite.
		{ Cue = "/VO/ZagreusField_3230", RequiredBiome = "Secrets", RequiredPlayed = { "/VO/ZagreusField_3034" } },
		-- All right, let's catch some fish.
		{ Cue = "/VO/ZagreusField_3340", RequiredTextLines = { "PoseidonFishQuest01" }, MinRunsSinceAnyTextLines = { TextLines = { "PoseidonFishQuest01" }, Count = 10 }, },
	},
	FishNotCaughtVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 1.4,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- Drat.
			{ Cue = "/VO/ZagreusField_3117" },
			-- Ah well.
			{ Cue = "/VO/ZagreusField_3118" },
			-- Missed...
			{ Cue = "/VO/ZagreusField_3119" },
			-- Tsk...
			{ Cue = "/VO/ZagreusField_3120" },
			-- Got away.
			{ Cue = "/VO/ZagreusField_3121" },
			-- You win this round, fish.
			{ Cue = "/VO/ZagreusField_3122", PreLineWait = 1.8 },
			-- Blood and...
			{ Cue = "/VO/ZagreusField_3123" },
			-- Argh.
			{ Cue = "/VO/ZagreusField_3124" },
			-- Missed it.
			{ Cue = "/VO/ZagreusField_3125" },
			-- Not quite.
			{ Cue = "/VO/ZagreusField_3126" },
			-- I missed...
			{ Cue = "/VO/ZagreusField_3127" },
			-- Blasted little...
			{ Cue = "/VO/ZagreusField_3128" },
			-- Damn.
			{ Cue = "/VO/ZagreusField_3129" },
			-- That little...
			{ Cue = "/VO/ZagreusField_3130" },
			-- I'll get you next time, fish!
			{ Cue = "/VO/ZagreusField_3131", PreLineWait = 1.8 },
			-- Lost it.
			{ Cue = "/VO/ZagreusField_3132" },
			-- No good.
			{ Cue = "/VO/ZagreusField_3133" },
			-- Curses!
			{ Cue = "/VO/ZagreusField_3134" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.89,
			NoTarget = true,
			RequiredTextLines = { "ChaosFirstPickUp" },
			Source = { SubtitleColor = Color.ChaosVoice },
			RequiredBiome = "Secrets",

			-- You are eluded.
			{ Cue = "/VO/Chaos_0249",  },
			-- Thwarted.
			{ Cue = "/VO/Chaos_0250",  },
			-- Thwarted again.
			{ Cue = "/VO/Chaos_0251",  },
			-- Defeated.
			{ Cue = "/VO/Chaos_0252",  },
			-- Defeated, once again.
			{ Cue = "/VO/Chaos_0253",  },
			-- Denied of victory.
			{ Cue = "/VO/Chaos_0254",  },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.8,
			RequiredTextLines = { "PatroclusFirstMeeting" },
			ObjectType = "NPC_Patroclus_01",
			RequiredRoom = "C_Story01",
			Actor = "StrangerOcclusionP",

			-- Too bad, stranger.
			{ Cue = "/VO/Patroclus_0257",  },
			-- <Chuckle>
			{ Cue = "/VO/Patroclus_0258",  },
			-- It got away, did it?
			{ Cue = "/VO/Patroclus_0259",  },
			-- My sympathies, stranger.
			{ Cue = "/VO/Patroclus_0260",  },
			-- Good fortune never lasts...
			{ Cue = "/VO/Patroclus_0261",  },
			-- You keep on trying, stranger.
			{ Cue = "/VO/Patroclus_0262",  },
			-- Figured as much...
			{ Cue = "/VO/Patroclus_0263",  },
			-- You'll get him yet I'm sure...
			{ Cue = "/VO/Patroclus_0264",  },
			-- I saw nothing, stranger.
			{ Cue = "/VO/Patroclus_0265",  },
			-- You missed, did you?
			{ Cue = "/VO/Patroclus_0266",  },
			-- Tough fortune, there, stranger.
			{ Cue = "/VO/Patroclus_0267",  },
			-- I thought you had that one...
			{ Cue = "/VO/Patroclus_0268",  },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.8,
			RequiredTextLines = { "PersephoneFirstMeeting" },
			ObjectType = "NPC_Persephone_01",
			RequiredRoom = "E_Story01",
			Actor = "StrangerOcclusionP",
			PreLineAnim = "PersephoneGarden_Vulnerable",

			-- Alas for that.
			{ Cue = "/VO/Persephone_0290",  },
			-- Next time, my son.
			{ Cue = "/VO/Persephone_0291",  },
			-- Ah, well.
			{ Cue = "/VO/Persephone_0292",  },
			-- Oof, almost!
			{ Cue = "/VO/Persephone_0293",  },
			-- Can't win them all.
			{ Cue = "/VO/Persephone_0294",  },
			-- Wasn't meant to be.
			{ Cue = "/VO/Persephone_0295",  },
		},		
	},
	FishNotCaughtTooLateVoiceLines =
	{
		{
			RandomRemaining = true,
			PreLineWait = 2,
			Cooldowns =
			{
				{ Name = "ZagreusFishingSpeech", Time = 8 },
			},

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- Ah well.
			{ Cue = "/VO/ZagreusField_3135" },
			-- Oh well.
			{ Cue = "/VO/ZagreusField_3136" },
			-- Better move on.
			{ Cue = "/VO/ZagreusField_3137" },
			-- Think that's enough.
			{ Cue = "/VO/ZagreusField_3138" },
			-- No use I guess.
			{ Cue = "/VO/ZagreusField_3139" },
			-- No fish this time.
			{ Cue = "/VO/ZagreusField_3140" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.89,
			NoTarget = true,
			RequiredTextLines = { "ChaosFirstPickUp" },
			Source = { SubtitleColor = Color.ChaosVoice },
			RequiredBiome = "Secrets",

			-- You are eluded.
			{ Cue = "/VO/Chaos_0249" },
			-- Thwarted.
			{ Cue = "/VO/Chaos_0250" },
			-- Thwarted again.
			{ Cue = "/VO/Chaos_0251" },
			-- Defeated.
			{ Cue = "/VO/Chaos_0252" },
			-- Defeated, once again.
			{ Cue = "/VO/Chaos_0253" },
			-- Denied of victory.
			{ Cue = "/VO/Chaos_0254" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.8,
			RequiredTextLines = { "PatroclusFirstMeeting" },
			ObjectType = "NPC_Patroclus_01",
			RequiredRoom = "C_Story01",
			Actor = "StrangerOcclusionP",

			-- Too bad, stranger.
			{ Cue = "/VO/Patroclus_0257",  },
			-- <Chuckle>
			{ Cue = "/VO/Patroclus_0258",  },
			-- It got away, did it?
			{ Cue = "/VO/Patroclus_0259",  },
			-- My sympathies, stranger.
			{ Cue = "/VO/Patroclus_0260",  },
			-- Good fortune never lasts...
			{ Cue = "/VO/Patroclus_0261",  },
			-- You keep on trying, stranger.
			{ Cue = "/VO/Patroclus_0262",  },
			-- Figured as much...
			{ Cue = "/VO/Patroclus_0263",  },
			-- You'll get him yet I'm sure...
			{ Cue = "/VO/Patroclus_0264",  },
			-- I saw nothing, stranger.
			{ Cue = "/VO/Patroclus_0265",  },
			-- You missed, did you?
			{ Cue = "/VO/Patroclus_0266",  },
			-- Tough fortune, there, stranger.
			{ Cue = "/VO/Patroclus_0267",  },
			-- I thought you had that one...
			{ Cue = "/VO/Patroclus_0268",  },
		},
	},
	FishNotCaughtWayTooLateVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		RequiresFalseFishingInput = true,
		Cooldowns =
		{
			{ Name = "ZagreusFishingSpeech", Time = 14 },
		},

		-- Think I missed my chance here.
		{ Cue = "/VO/ZagreusField_3559" },
		-- Hmm, no bites I guess...
		{ Cue = "/VO/ZagreusField_3560" },
		-- Don't think I'll get a bite at this rate.
		{ Cue = "/VO/ZagreusField_3561" },
		-- ...I think I've waited long enough.
		{ Cue = "/VO/ZagreusField_3562" },
		-- No river denizens about I think.
		{ Cue = "/VO/ZagreusField_3563" },
		-- I should probably go...
		{ Cue = "/VO/ZagreusField_3564" },
	},
	FishTransactionStartVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		CooldownTime = 6,

		-- Here's what I caught lately.
		{ Cue = "/VO/ZagreusHome_1805" },
		-- Here's what I caught.
		{ Cue = "/VO/ZagreusHome_1806" },
		-- Here's all I caught.
		{ Cue = "/VO/ZagreusHome_1807" },
		-- Freshly caught just for you, Chef.
		{ Cue = "/VO/ZagreusHome_1808" },
		-- Here's the latest catch, Chef.
		{ Cue = "/VO/ZagreusHome_1809" },
		-- Here's the catch of the day.
		{ Cue = "/VO/ZagreusHome_1810" },
		-- Here's the catch of the day... or night?
		{ Cue = "/VO/ZagreusHome_1811" },
		-- Trade you these horrid things.
		{ Cue = "/VO/ZagreusHome_1812", RequiredMinHeldFish = 2 },
		-- Please take these, will you, Chef?
		{ Cue = "/VO/ZagreusHome_1813", RequiredMinHeldFish = 2 },
		-- I come to you bearing aquatic beasts.
		{ Cue = "/VO/ZagreusHome_1814", RequiredMinHeldFish = 2 },
		-- Here, you can have these, Chef.
		{ Cue = "/VO/ZagreusHome_1815", RequiredMinHeldFish = 2 },
		-- Do what you will with these, my good Chef.
		{ Cue = "/VO/ZagreusHome_1816", RequiredMinHeldFish = 2 },
		-- Some water-dwelling beasts for you, good Chef.
		{ Cue = "/VO/ZagreusHome_1817", RequiredMinHeldFish = 2 },
		-- This is my latest haul.
		{ Cue = "/VO/ZagreusHome_1818" },
		-- Look at what I caught, Chef!
		{ Cue = "/VO/ZagreusHome_1819" },
	},
	FishTransactionEndVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.85,
		CooldownTime = 6,

		-- Why thank you!
		{ Cue = "/VO/ZagreusHome_1820", RequiredPlayed = { "/VO/ZagreusHome_1831" } },
		-- Pleasure doing business.
		{ Cue = "/VO/ZagreusHome_1821", RequiredPlayed = { "/VO/ZagreusHome_1831" } },
		-- I'm much obliged.
		{ Cue = "/VO/ZagreusHome_1822", RequiredPlayed = { "/VO/ZagreusHome_1831" } },
		-- Seems fair enough.
		{ Cue = "/VO/ZagreusHome_1823", RequiredPlayed = { "/VO/ZagreusHome_1831" } },
		-- Fair market value.
		{ Cue = "/VO/ZagreusHome_1824", RequiredPlayed = { "/VO/ZagreusHome_1831" } },
		-- Totally worth it.
		{ Cue = "/VO/ZagreusHome_1825", RequiredPlayed = { "/VO/ZagreusHome_1831" } },
		-- All right, then!
		{ Cue = "/VO/ZagreusHome_1826", RequiredPlayed = { "/VO/ZagreusHome_1831" } },
		-- We're settled up.
		{ Cue = "/VO/ZagreusHome_1827", RequiredPlayed = { "/VO/ZagreusHome_1831" } },
		-- Always a pleasure.
		{ Cue = "/VO/ZagreusHome_1828", RequiredPlayed = { "/VO/ZagreusHome_1831" } },
		-- Till next time!
		{ Cue = "/VO/ZagreusHome_1829", RequiredPlayed = { "/VO/ZagreusHome_1831" } },
		-- Use them wisely, my friend.
		{ Cue = "/VO/ZagreusHome_1830", RequiredPlayed = { "/VO/ZagreusHome_1831" } },
		-- Done deal!
		{ Cue = "/VO/ZagreusHome_1831" },
	},

	-- Home Events
	FlashbackEndedVoiceLines =
	{
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.65,
				RequiredTextLines = { "Flashback_Mother_01" },
				RequiredFalseTextLines = { "Flashback_DayNightJob_01", "PersephoneFirstMeeting" },

				-- Mother... I wonder... will you even remember me?
				{ Cue = "/VO/ZagreusHome_0067", PreLineAnim = "ZagreusInteractionThoughtful" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.75,
				RequiredTextLines = { "Flashback_Mother_01", "PersephoneFirstMeeting" },
				RequiredFalseTextLines = { "Flashback_DayNightJob_01", "Ending01" },

				-- Urgh, Father...
				{ Cue = "/VO/ZagreusHome_0896", PreLineAnim = "ZagreusInteractionThoughtful" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.75,
				RequiredTextLines = { "Flashback_Mother_01", "Ending01" },
				RequiredFalseTextLines = { "Flashback_DayNightJob_01" },

				-- Still can't entirely believe Mother's come home....
				{ Cue = "/VO/ZagreusHome_3589", PreLineAnim = "ZagreusInteractionThoughtful" },
			}
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			RequiredTextLines = { "Flashback_DayNightJob_01" },

			-- ...Ugh... at least I can't be late for that job anymore.
			{ Cue = "/VO/ZagreusHome_2137", },
		},
	},
	ShadeEavesdropVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		CooldownTime = 30,
		SuccessiveChanceToPlayAll = 0.5,

		-- What's the good word.
		{ Cue = "/VO/ZagreusHome_0267", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- What are those shades muttering about.
		{ Cue = "/VO/ZagreusHome_0268", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- Moaning and groaning.
		{ Cue = "/VO/ZagreusHome_0269", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- Those shades are always milling about.
		{ Cue = "/VO/ZagreusHome_0270", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- Let's just have a listen.
		{ Cue = "/VO/ZagreusHome_0453", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- What are they on about now.
		{ Cue = "/VO/ZagreusHome_0454", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- What are these shades up to now?
		{ Cue = "/VO/ZagreusHome_0455", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- What do these shades have to say for themselves.
		{ Cue = "/VO/ZagreusHome_0456", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- What news, Spirit?
		{ Cue = "/VO/ZagreusField_0104", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- Please make yourselves at home!
		{ Cue = "/VO/ZagreusHome_3067", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- How's it going?
		{ Cue = "/VO/ZagreusHome_3068", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- Thank you for waiting.
		{ Cue = "/VO/ZagreusHome_3069", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- Appreciate your patience.
		{ Cue = "/VO/ZagreusHome_3070", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- How goes it, shades?
		{ Cue = "/VO/ZagreusHome_3071" },
		-- What's the latest?
		{ Cue = "/VO/ZagreusHome_3072", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- What's new?
		{ Cue = "/VO/ZagreusHome_3073", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- Hey, welcome!
		{ Cue = "/VO/ZagreusHome_3074", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- Hey, I know you!
		{ Cue = "/VO/ZagreusHome_3075", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
		-- You shades doing all right?
		{ Cue = "/VO/ZagreusHome_3076", RequiredPlayed = { "/VO/ZagreusHome_3071" } },
	},

	GoofingOffVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		CooldownTime = 20,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- T'heh.
		{ Cue = "/VO/ZagreusField_0038" },
		-- Just minding my own business.
		{ Cue = "/VO/ZagreusHome_0296" },
		-- Cheer up, everybody.
		{ Cue = "/VO/ZagreusHome_0297" },
		-- Dum-de-dum...
		{ Cue = "/VO/ZagreusHome_0298" },
		-- La-di-dah...
		{ Cue = "/VO/ZagreusHome_0299" },
		-- Hm-hmm-hmmm.
		{ Cue = "/VO/ZagreusHome_0300" },
	},

	EnteringOnslaughtVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		-- SuccessiveChanceToPlay = 0.75,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- Here we go.
		{ Cue = "/VO/ZagreusField_0356" },
		-- Let's go.
		{ Cue = "/VO/ZagreusField_0357" },
		-- Let's go.
		{ Cue = "/VO/ZagreusHome_0152" },
		-- Here we go.
		{ Cue = "/VO/ZagreusHome_0153" },
		-- Away we go.
		{ Cue = "/VO/ZagreusHome_0349" },
		-- Off we go.
		{ Cue = "/VO/ZagreusHome_0350" },
	},
	OnslaughtVictoryVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		-- SuccessiveChanceToPlay = 0.75,

		-- Time to go.
		{ Cue = "/VO/ZagreusHome_0035" },
	},
	ReturningFromOnslaughtVictoryVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		-- SuccessiveChanceToPlay = 0.75,

		-- How'd I do that time.
		{ Cue = "/VO/ZagreusHome_0010b" },
		-- Not too bad that time.
		{ Cue = "/VO/ZagreusHome_0011a" },
	},
	ReturningFromOnslaughtDefeatVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		-- SuccessiveChanceToPlay = 0.75,

		-- Ow...
		{ Cue = "/VO/ZagreusHome_0061" },
		-- That could have gone better.
		{ Cue = "/VO/ZagreusHome_0012d" },
	},

	-- Interaction Events
	NotEnoughLockKeysVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		CooldownTime = 8,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- Need to find a key.
		{ Cue = "/VO/ZagreusHome_0138" },
		-- Need a key.
		{ Cue = "/VO/ZagreusHome_0139" },
		-- It's sealed shut.
		{ Cue = "/VO/ZagreusHome_0140" },
		-- Can't open this yet.
		{ Cue = "/VO/ZagreusHome_0141" },
		-- Locked.
		{ Cue = "/VO/ZagreusHome_0142" },
		-- Need more of those keys.
		{ Cue = "/VO/ZagreusField_0910" },
		-- This needs more keys to open.
		{ Cue = "/VO/ZagreusField_0911" },
		-- Don't have enough keys.
		{ Cue = "/VO/ZagreusField_0912" },
		-- That's going to take more keys.
		{ Cue = "/VO/ZagreusField_0913" },
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
	},

	WeaponUpgradeLockedVoiceLines =
	{
		[1] = GlobalVoiceLines.NotEnoughSuperLockKeysVoiceLines,
	},
	GiftRackLockedVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		CooldownTime = 8,

		ExplicitRequirements = true,
		GameStateRequirements =
		{
			-- None
		},

		-- It's sealed shut.
		{ Cue = "/VO/ZagreusHome_0140" },
		-- Locked.
		{ Cue = "/VO/ZagreusHome_0142" },
		-- Oh great.
		{ Cue = "/VO/ZagreusField_1060" },
		-- Ah really?
		{ Cue = "/VO/ZagreusField_1067" },
		-- It's no use.
		{ Cue = "/VO/ZagreusField_0392" },
		-- No use.
		{ Cue = "/VO/ZagreusField_0393" },
	},
	WeaponKitUnlockedVoiceLines =
	{
		{
			BreakIfPlayed = true,
			PlayOnce = true,
			PlayOnceContext = "WeaponKitUnlockLines",
			PreLineWait = 0.35,
			CooldownTime = 5,

			-- There we go!
			{ Cue = "/VO/ZagreusHome_0143" },
			-- Open up.
			{ Cue = "/VO/ZagreusHome_0144" },
			-- Let's see what's in here.
			{ Cue = "/VO/ZagreusHome_0355" },
			-- This one!
			{ Cue = "/VO/ZagreusHome_3077" },
			-- Let's try it.
			{ Cue = "/VO/ZagreusHome_0352" },
			-- This one, then.
			{ Cue = "/VO/ZagreusHome_3078" },
		},
	},
	WeaponUpgradesRevealedVoiceLines =
	{
		BreakIfPlayed = true,
		PreLineWait = 0.35,

		-- What in blazes...
		{ Cue = "/VO/ZagreusHome_0677" },
	},
	WeaponKitSpecialInteractVoiceLines =
	{
		PreLineWait = 0.55,
		Queue = "Interrupt",
		{
			BreakIfPlayed = true,
			RequiredWeapon = "SpearWeapon",

			-- Varatha: I see you through the eyes of the crimson phoenix!
			{ Cue = "/VO/ZagreusHome_2027" },
		},
		{
			BreakIfPlayed = true,
			RequiredWeapon = "SwordWeapon",

			-- Stygius: I see your kingly pardon from a prison of stone!
			{ Cue = "/VO/ZagreusHome_2047" },
		},
		{
			BreakIfPlayed = true,
			RequiredWeapon = "BowWeapon",

			-- Coronacht: I see you drawn in the arms of the seventh avatar!
			{ Cue = "/VO/ZagreusHome_2052" },
		},
		{
			BreakIfPlayed = true,
			RequiredWeapon = "ShieldWeapon",

			-- Aegis: I see you stand your ground against the serpent's flame!
			{ Cue = "/VO/ZagreusHome_2648" },
		},
		{
			BreakIfPlayed = true,
			RequiredWeapon = "FistWeapon",

			-- Malphon: I see you overcome the wild and make peace with death!
			{ Cue = "/VO/ZagreusHome_3490" },
		},
		{
			BreakIfPlayed = true,
			RequiredWeapon = "GunWeapon",

			-- Exagryph: I see your prideful fall down from the heavens to the flames!
			{ Cue = "/VO/ZagreusHome_2653" },
		},
	},
	MetaUpgradeUnlockedVoiceLines =
	{
		PlayOnce = true,
		PlayOnceContext = "MirrorUnlocks",
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		CooldownTime = 5,

		-- Show me something new.
		{ Cue = "/VO/ZagreusHome_2309" },
		-- How else can I improve?
		{ Cue = "/VO/ZagreusHome_2310" },
		-- What more potential do I have?
		{ Cue = "/VO/ZagreusHome_2311" },
		-- Let's see the last of them.
		{ Cue = "/VO/ZagreusHome_2312" },

		--[[
		-- Something for the Mirror.
		-- { Cue = "/VO/ZagreusField_0433" },
		-- A facet for the Mirror.
		-- { Cue = "/VO/ZagreusField_0434" },
		-- That's for the Mirror.
		-- { Cue = "/VO/ZagreusField_0435" },
		-- The Mirror's grown in power.
		{ Cue = "/VO/ZagreusHome_0341" },
		-- The Mirror's even stronger.
		{ Cue = "/VO/ZagreusHome_0342", RequiredPlayed = { "/VO/ZagreusHome_0341" } },
		-- More ways to grow my strength.
		{ Cue = "/VO/ZagreusHome_0344", RequiredPlayed = { "/VO/ZagreusHome_0341" } },
		-- And, click.
		{ Cue = "/VO/ZagreusHome_0351", RequiredPlayed = { "/VO/ZagreusHome_0341" } },
		-- That should do it.
		{ Cue = "/VO/ZagreusHome_0145", RequiredPlayed = { "/VO/ZagreusHome_0341" } },
		-- Let's try it.
		{ Cue = "/VO/ZagreusHome_0352", RequiredPlayed = { "/VO/ZagreusHome_0341" } },
		-- This one, why not.
		{ Cue = "/VO/ZagreusHome_0353", RequiredPlayed = { "/VO/ZagreusHome_0341" } },
		-- This one then.
		{ Cue = "/VO/ZagreusHome_0354", RequiredPlayed = { "/VO/ZagreusHome_0341" } },
		]]--
	},
	MetaUpgradesResetVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.75,
			CooldownTime = 20,
			SuccessiveChanceToPlayAll = 0.75,

			-- I'd like my Darkness back.
			{ Cue = "/VO/ZagreusHome_2305" },
			-- How about a new beginning.
			{ Cue = "/VO/ZagreusHome_2306" },
			-- Let's try this Mirror stuff again.
			{ Cue = "/VO/ZagreusHome_2307" },
			-- Return my Darkness to me.
			{ Cue = "/VO/ZagreusHome_2308" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.75,
			CooldownTime = 20,

			-- All right.
			{ Cue = "/VO/ZagreusHome_1856" },
			-- That should do it.
			{ Cue = "/VO/ZagreusHome_0145" },
		},
	},
	-- Shrine
	CannotUnlockShrineVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		CooldownTime = 5,
		SuccessiveChanceToPlayAll = 0.33,

		-- I'm through with Father's dirty work.
		{ Cue = "/VO/ZagreusHome_0589" },
		-- I don't think so.
		{ Cue = "/VO/ZagreusHome_0590", RequiredPlayed = { "/VO/ZagreusHome_0589" } },
		-- Not a chance.
		{ Cue = "/VO/ZagreusHome_0591", RequiredPlayed = { "/VO/ZagreusHome_0589" } },
		-- Can't even open this yet.
		{ Cue = "/VO/ZagreusHome_0592", RequiredPlayed = { "/VO/ZagreusHome_0589" } },
	},
	ShrineUnlockedVoiceLines =
	{
		PreLineWait = 0.35,

		-- Time for a change.
		{ Cue = "/VO/ZagreusField_0177" },
		-- An infernal contract...
		{ Cue = "/VO/ZagreusHome_0587", PreLineWait = 1.0, PlayOnce = true },
	},
	OpenedShrineVoiceLines =
	{
		{
			SkipAnim = true,
			PlayOnce = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			RequiredCosmetics = { "HadesEMFight" },
			Cooldowns =
			{
				{ Name = "ZagreusPactOpenedSpeech", Time = 200 },
			},

			-- I can take on Father now using Extreme Measures... if I so dare.
			{ Cue = "/VO/ZagreusHome_3657" },
		},		
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.65,
			PlayOnce = true,
			Cooldowns =
			{
				{ Name = "ZagreusPactOpenedSpeech", Time = 200 },
			},

			-- Looks like Father's changed the terms of our relationship.
			{ Cue = "/VO/ZagreusHome_1126", RequiredFalseFlags = { "HardMode" } },
			-- Looks like Father's not going to make this easy on me.
			{ Cue = "/VO/ZagreusHome_1435", RequiredTrueFlags = { "HardMode" } },
		},
		-- Hard Mode: Pact has a higher Heat Level than before
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.9,
			RequiredTrueFlags = { "HardMode" },
			RequiresRunCleared = true,
			PlayOnceFromTableThisRun = true,
			-- @ search other instances of ZagreusPactMiscSpeech to remove temp cooldowns
			Cooldowns =
			{
				{ Name = "ZagreusPactMiscSpeech", Time = 300 },
			},

			-- I'm asking for it.
			{ Cue = "/VO/ZagreusHome_1147" },
			-- Hah, why not.
			{ Cue = "/VO/ZagreusHome_1148" },
			-- Should be simple!
			{ Cue = "/VO/ZagreusHome_1149" },
			-- I have this.
			{ Cue = "/VO/ZagreusHome_1150" },
		},
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			ChanceToPlayAgain = 0.03,
			PlayOnce = true,
			Cooldowns =
			{
				{ Name = "ZagreusPactOpenedSpeech", Time = 200 },
			},

			-- It knows I've chosen Stygius.
			{ Cue = "/VO/ZagreusHome_1127", RequiredWeapon = "SwordWeapon" },
			-- It can tell I have Varatha.
			{ Cue = "/VO/ZagreusHome_1128", RequiredWeapon = "SpearWeapon" },
			-- It's detected Aegis.
			{ Cue = "/VO/ZagreusHome_1129", RequiredWeapon = "ShieldWeapon" },
			-- It can sense Coronacht.
			{ Cue = "/VO/ZagreusHome_1130", RequiredWeapon = "BowWeapon" },
			-- The Pact can tell I have Malphon this time.
			{ Cue = "/VO/ZagreusHome_2034", RequiredWeapon = "FistWeapon" },
			-- It sees I chose Exagryph.
			{ Cue = "/VO/ZagreusHome_1131", RequiredWeapon = "GunWeapon" },
		},
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.66,
			RequiresNewlyAddedShrineUpgrade = true,
			Cooldowns =
			{
				{ Name = "ZagreusPactOpenedSpeech", Time = 200 },
			},

			-- New stipulations added to the Pact.
			{ Cue = "/VO/ZagreusHome_1136" },
			-- There's a new condition on the Pact.
			{ Cue = "/VO/ZagreusHome_1137" },
		},
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.66,
			RequiresLessActiveShrinePointsThanPrevRun = true,
			Cooldowns =
			{
				{ Name = "ZagreusPactOpenedSpeech", Time = 200 },
			},

			-- Should I risk it?
			{ Cue = "/VO/ZagreusHome_1132", RequiredPlayed = { "/VO/ZagreusHome_1126" } },
			-- Maybe I ought to risk it.
			{ Cue = "/VO/ZagreusHome_1133", RequiredPlayed = { "/VO/ZagreusHome_1126" } },
			-- Should I do it?
			{ Cue = "/VO/ZagreusHome_1134", RequiredPlayed = { "/VO/ZagreusHome_1126" } },
		},
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.66,
			Cooldowns =
			{
				{ Name = "ZagreusPactOpenedSpeech", Time = 200 },
			},

			-- Father's Pact.
			{ Cue = "/VO/ZagreusHome_1135" },
			-- All right, let's see here.
			{ Cue = "/VO/ZagreusHome_0593" },
			-- In the name of Hades.
			{ Cue = "/VO/ZagreusHome_0595" },
			-- On my authority.
			{ Cue = "/VO/ZagreusHome_0597" },
			-- Father always said never to take the easy way.
			{ Cue = "/VO/ZagreusHome_0598" },
			-- Time for some meddling.
			{ Cue = "/VO/ZagreusHome_0600" },
			-- I can make life even more miserable here.
			{ Cue = "/VO/ZagreusHome_0601" },
		},
	},
	ShrineUpgradeAtMaxVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 12,

		-- That's as bad as this gets.
		{ Cue = "/VO/ZagreusHome_1138" },
		-- Can't push it any further.
		{ Cue = "/VO/ZagreusHome_1139" },
		-- Maximum punishment.
		{ Cue = "/VO/ZagreusHome_1140" },
		-- That's as far as it goes.
		{ Cue = "/VO/ZagreusHome_1141" },
		-- That's as much Heat as I can get from this.
		{ Cue = "/VO/ZagreusHome_1142" },
	},
	NotEnoughShrinePointsVoiceLines =
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlay = 0.1,
			Cooldowns =
			{
				{ Name = "ZagreusMenuInteractVoiceLines", Time = 8 },
			},

			-- Can't get out of here till I turn up the Heat.
			{ Cue = "/VO/ZagreusHome_1494" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			SuccessiveChanceToPlayAll = 0.66,
			Cooldowns =
			{
				{ Name = "ZagreusMenuInteractVoiceLines", Time = 8 },
			},

			-- I need to turn up the Heat.
			{ Cue = "/VO/ZagreusHome_1579" },
			-- Not getting out of here without more Heat.
			{ Cue = "/VO/ZagreusHome_1580" },
			-- I need to add Conditions to the Pact.
			{ Cue = "/VO/ZagreusHome_1581" },
			-- I need to change the Pact before I go.
			{ Cue = "/VO/ZagreusHome_1582" },
			-- Oh bloody hell.
			{ Cue = "/VO/ZagreusHome_1583" },
			-- I have to modify the Pact.
			{ Cue = "/VO/ZagreusHome_1584" },
			-- I need to add more Heat.
			{ Cue = "/VO/ZagreusHome_1585" },
		},
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			Cooldowns =
			{
				{ Name = "ZagreusMenuInteractVoiceLines", Time = 8 },
			},

			-- Not authorized.
			{ Cue = "/VO/ZagreusHome_0602" },
			-- Not enough Heat.
			{ Cue = "/VO/ZagreusHome_0603" },
			-- I don't have enough Heat.
			{ Cue = "/VO/ZagreusHome_0604" },
			-- I'm not authorized.
			{ Cue = "/VO/ZagreusHome_0605" },
			-- I'm not cleared to do that.
			{ Cue = "/VO/ZagreusHome_0606" },
		},
	},
	ShrineUpgradeLockedVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		Cooldowns =
		{
			{ Name = "ZagreusMenuInteractVoiceLines", Time = 8 },
		},

		-- Not authorized.
		{ Cue = "/VO/ZagreusHome_0602", RequiredPlayed = { "/VO/ZagreusHome_0605" }, },
		-- I'm not authorized.
		{ Cue = "/VO/ZagreusHome_0605" },
		-- I'm not cleared to do that.
		{ Cue = "/VO/ZagreusHome_0606", RequiredPlayed = { "/VO/ZagreusHome_0605" }, },
		-- I can't.
		{ Cue = "/VO/ZagreusField_0390", RequiredPlayed = { "/VO/ZagreusHome_0605" }, },
		-- Can't do that.
		{ Cue = "/VO/ZagreusField_0391", RequiredPlayed = { "/VO/ZagreusHome_0605" }, },
		-- It's no use.
		{ Cue = "/VO/ZagreusField_0392", RequiredPlayed = { "/VO/ZagreusHome_0605" }, },
		-- No use.
		{ Cue = "/VO/ZagreusField_0393", RequiredPlayed = { "/VO/ZagreusHome_0605" }, },
	},
	ShrineUpgradeHardModeRestrictionVoiceLines =
	{
		RandomRemaining = true,
		PreLineWait = 0.25,
		CooldownTime = 8,

		-- No getting out of that one.
		{ Cue = "/VO/ZagreusHome_1436", RequiredPlayed = { "/VO/ZagreusHome_1439" } },
		-- I'll have to live with that.
		{ Cue = "/VO/ZagreusHome_1437", RequiredPlayed = { "/VO/ZagreusHome_1439" } },
		-- Kkh, Father...
		{ Cue = "/VO/ZagreusHome_1438", RequiredPlayed = { "/VO/ZagreusHome_1439" } },
		-- That Condition's non-negotiable.
		{ Cue = "/VO/ZagreusHome_1439" },
		-- I'm stuck with that.
		{ Cue = "/VO/ZagreusHome_1440", RequiredPlayed = { "/VO/ZagreusHome_1439" } },
		-- I only wish.
		{ Cue = "/VO/ZagreusHome_1441", RequiredPlayed = { "/VO/ZagreusHome_1439" } },

	},
	ShrineHeatThresholdExceededVoiceLines =
	{
		PlayOnce = true,
		PlayOnceFromTableThisRun = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		SuccessiveChanceToPlay = 0.33,

		-- Blowing out the Heat Gauge isn't going to do me any favors here.
		{ Cue = "/VO/ZagreusHome_1318" },
		-- Don't need to turn the Heat Gauge so high to earn those Bounties.
		{ Cue = "/VO/ZagreusHome_1319" },
		-- If it's Bounties I'm after, no need to turn the Heat up this high.
		{ Cue = "/VO/ZagreusHome_1322" },
	},

	ShrineUpgradeUnlockedVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		CooldownTime = 5,

		-- And, click.
		{ Cue = "/VO/ZagreusHome_0351" },
		-- That should do it.
		{ Cue = "/VO/ZagreusHome_0145" },
		-- Let's try it.
		{ Cue = "/VO/ZagreusHome_0352" },
		-- This one, why not.
		{ Cue = "/VO/ZagreusHome_0353" },
		-- This one then.
		{ Cue = "/VO/ZagreusHome_0354" },
	},
	-- Bounties
	BountyEarnedConfirmationVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.55,
		Cooldowns =
		{
			{ Name = "ZagreusBountyEarnedConfirmationVoiceLines", Time = 60 },
		},

		-- Check.
		{ Cue = "/VO/ZagreusField_2635" },
		-- Check!
		{ Cue = "/VO/ZagreusField_2636" },
		-- And, check.
		{ Cue = "/VO/ZagreusField_2637" },
		-- Done.
		{ Cue = "/VO/ZagreusField_2638" },
		-- In the bag.
		{ Cue = "/VO/ZagreusField_2639" },
		-- Got it.
		{ Cue = "/VO/ZagreusField_2640" },
		-- Clear.
		{ Cue = "/VO/ZagreusField_2641" },
		-- Mm-hm.
		{ Cue = "/VO/ZagreusField_2642" },
		-- Thank you.
		{ Cue = "/VO/ZagreusField_2643" },
		-- Cheers.
		{ Cue = "/VO/ZagreusField_2644" },
		-- Courtesy of the Pact.
		{ Cue = "/VO/ZagreusField_2645", RequiresShrinePointsAtThreshold = true },
		-- Yes.
		{ Cue = "/VO/ZagreusField_2646" },
		-- There.
		{ Cue = "/VO/ZagreusField_2647" },
		-- Good.
		{ Cue = "/VO/ZagreusField_2648" },
	},
	-- QuestLog
	OpenedQuestLogSingleQuestCompleteVoiceLines =
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		Cooldowns =
		{
			{ Name = "ZagreusQuestLogOpenedSpeech", Time = 200 },
		},

		-- Who am I to question Fate?
		{ Cue = "/VO/ZagreusHome_1430" },
		-- The prophecy has been fulfilled.
		{ Cue = "/VO/ZagreusHome_1431" },
		-- That definitely came to pass.
		{ Cue = "/VO/ZagreusHome_1432" },
		-- Was bound to happen, really.
		{ Cue = "/VO/ZagreusHome_1433" },
		-- Prophecy fulfilled.
		{ Cue = "/VO/ZagreusHome_1594" },
		-- Another prophecy fulfilled.
		{ Cue = "/VO/ZagreusHome_1595", RequiredPlayed = { "/VO/ZagreusHome_1594" } },
		-- This one's for you, Three Fates!
		{ Cue = "/VO/ZagreusHome_1596" },
		-- That's one more prophecy fulfilled.
		{ Cue = "/VO/ZagreusHome_1597", RequiredPlayed = { "/VO/ZagreusHome_1594" } },
		-- Pleasure doing business with you, Fates.
		{ Cue = "/VO/ZagreusHome_1598" },
		-- Prophecy fulfilled!
		{ Cue = "/VO/ZagreusHome_2339" },
		-- Scratch one off the Fated List.
		{ Cue = "/VO/ZagreusHome_2340" },
		-- Was only a matter of time I suppose.
		{ Cue = "/VO/ZagreusHome_2341" },
		-- That's one prophecy out of the way.
		{ Cue = "/VO/ZagreusHome_2342" },
		-- I guess this came to pass!
		{ Cue = "/VO/ZagreusHome_2343" },
		-- What do you know, this came true.
		{ Cue = "/VO/ZagreusHome_2344" },
	},
	OpenedQuestLogMultiQuestsCompleteVoiceLines =
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		Cooldowns =
		{
			{ Name = "ZagreusQuestLogOpenedSpeech", Time = 200 },
		},

		-- Who am I to question Fate?
		{ Cue = "/VO/ZagreusHome_1430" },
		-- The prophecy has been fulfilled.
		{ Cue = "/VO/ZagreusHome_1431" },
		-- That definitely came to pass.
		{ Cue = "/VO/ZagreusHome_1432" },
		-- Was bound to happen, really.
		{ Cue = "/VO/ZagreusHome_1433" },
		-- Pleasure doing business with you, Fates.
		{ Cue = "/VO/ZagreusHome_1598" },
		-- Was only a matter of time I suppose.
		{ Cue = "/VO/ZagreusHome_2341" },
	},
	OpenedQuestLogNewQuestsAddedVoiceLines =
	{
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			Cooldowns =
			{
				{ Name = "ZagreusQuestLogOpenedSpeech", Time = 200 },
			},

			-- A prophecy...!
			{ Cue = "/VO/ZagreusHome_1423", RequiredPlayed = { "/VO/ZagreusHome_1589" } },
			-- Another prophecy...
			{ Cue = "/VO/ZagreusHome_1424", RequiredPlayed = { "/VO/ZagreusHome_1589" } },
			-- The Fates have spoken.
			{ Cue = "/VO/ZagreusHome_1425", RequiredPlayed = { "/VO/ZagreusHome_1589" } },
			-- The Fated List of Minor Prophecies...
			{ Cue = "/VO/ZagreusHome_1589", SuccessiveChanceToPlay = 0.02 },
			-- Something new in store for me?
			{ Cue = "/VO/ZagreusHome_1426", RequiredPlayed = { "/VO/ZagreusHome_1589" } },
			-- Something's added to the Fated List.
			{ Cue = "/VO/ZagreusHome_1427", RequiredPlayed = { "/VO/ZagreusHome_1589" } },
			-- A prophecy's appeared.
			{ Cue = "/VO/ZagreusHome_1428", RequiredPlayed = { "/VO/ZagreusHome_1589" } },
			-- New details of another prophecy.
			{ Cue = "/VO/ZagreusHome_1592", RequiredPlayed = { "/VO/ZagreusHome_1589" } },
			-- A prophecy's been added to the List.
			{ Cue = "/VO/ZagreusHome_1593", RequiredPlayed = { "/VO/ZagreusHome_1589" } },
		},
	},

	OpenedQuestLogVoiceLines =
	{
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.33,
			Cooldowns =
			{
				{ Name = "ZagreusQuestLogOpenedSpeech", Time = 200 },
			},

			-- Is this all that the Fates have planned for me...?
			{ Cue = "/VO/ZagreusHome_1419" },
			-- Let's have a look at the old Fated List.
			{ Cue = "/VO/ZagreusHome_1420" },
			-- What do the Three Fates have in mind?
			{ Cue = "/VO/ZagreusHome_1421" },
			-- Something inevitable I can do?
			{ Cue = "/VO/ZagreusHome_1422" },
			-- The Fated List...
			{ Cue = "/VO/ZagreusHome_1590" },
			-- Anything on the List?
			{ Cue = "/VO/ZagreusHome_1591" },
		},
	},
	CashedOutQuestVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.55,
		CooldownTime = 5,

		-- It was inevitable, thanks.
		{ Cue = "/VO/ZagreusHome_1429" },
		-- Who am I to question Fate?
		{ Cue = "/VO/ZagreusHome_1430" },
		-- The prophecy has been fulfilled.
		{ Cue = "/VO/ZagreusHome_1431" },
		-- That definitely came to pass.
		{ Cue = "/VO/ZagreusHome_1432" },
		-- Was bound to happen, really.
		{ Cue = "/VO/ZagreusHome_1433" },
		-- Prophecy fulfilled.
		{ Cue = "/VO/ZagreusHome_1594" },
		-- Another prophecy fulfilled.
		{ Cue = "/VO/ZagreusHome_1595", RequiredPlayed = { "/VO/ZagreusHome_1594" } },
		-- This one's for you, Three Fates!
		{ Cue = "/VO/ZagreusHome_1596" },
		-- That's one more prophecy fulfilled.
		{ Cue = "/VO/ZagreusHome_1597", RequiredPlayed = { "/VO/ZagreusHome_1594" } },
		-- Pleasure doing business with you, Fates.
		{ Cue = "/VO/ZagreusHome_1598" },
		-- Prophecy fulfilled!
		{ Cue = "/VO/ZagreusHome_2339" },
		-- Scratch one off the Fated List.
		{ Cue = "/VO/ZagreusHome_2340" },
		-- Was only a matter of time I suppose.
		{ Cue = "/VO/ZagreusHome_2341" },
		-- That's one prophecy out of the way.
		{ Cue = "/VO/ZagreusHome_2342" },
		-- I guess this came to pass!
		{ Cue = "/VO/ZagreusHome_2343" },
		-- What do you know, this came true.
		{ Cue = "/VO/ZagreusHome_2344" },
	},

	-- Trophy Quest
	TrophyClearAvailableVoiceLines =
	{
		{
			PreLineWait = 0.35,
			RequiredTextLines = { "TrophyQuest_Beginning_01" },
			RequiredFalseTextLines = { "TrophyQuest_SilverUnlocked_01" },

			-- Let's see here.
			{ Cue = "/VO/ZagreusHome_0645" },
			-- Oh come on.
			{ Cue = "/VO/ZagreusField_1066", RequiredMaxShrinePointThresholdClear = 59, PreLineWait = 1.2 },
		},
		{
			PreLineWait = 0.35,
			RequiredTextLines = { "TrophyQuest_SilverUnlocked_01" },
			RequiredFalseTextLines = { "TrophyQuest_GoldUnlocked_01" },

			-- This one then.
			{ Cue = "/VO/ZagreusHome_0354" },
			-- Are you serious?
			{ Cue = "/VO/ZagreusField_1058", RequiredMaxShrinePointThresholdClear = 119, PreLineWait = 1.2 },
		}
	},
	TrophyLockedNotEnoughHeatVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		CooldownTime = 6,

		-- I need to do what now?
		{ Cue = "/VO/ZagreusHome_0688" },
		-- I need to fire up the Pact of Punishment to reveal this.
		{ Cue = "/VO/ZagreusHome_0689" },
		-- The Pact of Punishment is the key to this, huh.
		{ Cue = "/VO/ZagreusHome_0692" },
		-- It's some sort of ridiculous challenge huh.
		{ Cue = "/VO/ZagreusHome_0693" },
		-- Someone's trying to goad me into using the Pact of Punishment.
		{ Cue = "/VO/ZagreusHome_0694" },
		-- I need to use the Pact on my way out.
		{ Cue = "/VO/ZagreusHome_1059" },
		-- The Pact over there is the key to revealing this.
		{ Cue = "/VO/ZagreusHome_1060" },
		-- I need to use the Pact back in my Chambers.
		-- { Cue = "/VO/ZagreusHome_0690" },
		-- Sounds like the Pact in my Chambers is the only way I'm going to earn this thing.
		-- { Cue = "/VO/ZagreusHome_0691" },
	},
	TrophyLockedEnoughHeatVoiceLines =
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		CooldownTime = 6,

		-- I'll have to survive the worst the Underworld has to offer before I can open this.
		{ Cue = "/VO/ZagreusHome_0695" },
		-- I haven't earned this yet.
		{ Cue = "/VO/ZagreusHome_0696", RequiredPlayed = { "/VO/ZagreusHome_0695" } },
		-- I've yet to earn the right to look upon whatever this is.
		{ Cue = "/VO/ZagreusHome_0697", RequiredPlayed = { "/VO/ZagreusHome_0695" } },
		-- I'll need to survive the horrors of the Underworld first.
		{ Cue = "/VO/ZagreusHome_0698", RequiredPlayed = { "/VO/ZagreusHome_0695" } },
		-- I have to earn this I guess.
		{ Cue = "/VO/ZagreusHome_0699", RequiredPlayed = { "/VO/ZagreusHome_0695" } },
		-- The Pact is fired up, just have to earn this.
		{ Cue = "/VO/ZagreusHome_0700", RequiredPlayed = { "/VO/ZagreusHome_0695" } },
		-- Earning this is going to be tough.
		{ Cue = "/VO/ZagreusHome_0701", RequiredPlayed = { "/VO/ZagreusHome_0695" } },
	},
	TrophyAdmirationVoiceLines =
	{
		{
			Queue = "Always",
			RandomRemaining = true,
			PreLineWait = 0.45,

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- Beautiful craftwork I must say.
			{ Cue = "/VO/ZagreusHome_0708" },
			-- Exquisite use of form.
			{ Cue = "/VO/ZagreusHome_0709" },
			-- Breathtaking detail in the rib-cage area.
			{ Cue = "/VO/ZagreusHome_0710" },
			-- The subtlety of the expression is a fascinating touch.
			{ Cue = "/VO/ZagreusHome_0711" },
			-- There's so much tension in the shape of it.
			{ Cue = "/VO/ZagreusHome_0712" },
			-- Wonderful use of color.
			{ Cue = "/VO/ZagreusHome_0713" },
			-- The raw emotion there is rather striking isn't it.
			{ Cue = "/VO/ZagreusHome_0714" },
			-- I practically can feel the anguish in this piece.
			{ Cue = "/VO/ZagreusHome_0715" },
			-- The use of light and shadow is exceptional.
			{ Cue = "/VO/ZagreusHome_0716" },
			-- I think it represents... the plight of mortal life.
			{ Cue = "/VO/ZagreusHome_0717" },
			-- I think it signifies the duality in all of us.
			{ Cue = "/VO/ZagreusHome_0718" },
			-- I think it speaks to how our pride can be our downfall?
			{ Cue = "/VO/ZagreusHome_0719" },
			-- How did they get the fingerbones to look so real.
			{ Cue = "/VO/ZagreusHome_0720" },
			-- Truly the work of a great master.
			{ Cue = "/VO/ZagreusHome_0721" },
			-- Didn't catch the name of the artist...
			{ Cue = "/VO/ZagreusHome_0722" },
			-- Such meticulous craft.
			{ Cue = "/VO/ZagreusHome_3079" },
			-- The sense of poise is truly extraordinary.
			{ Cue = "/VO/ZagreusHome_3080" },
			-- It looks distinctly different from this angle.
			{ Cue = "/VO/ZagreusHome_3081" },
			-- It's like a new experience every time I look.
			{ Cue = "/VO/ZagreusHome_3082" },
		},
		{
			Queue = "Always",
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.35,
			ObjectType = "TrainingMelee",

			ExplicitRequirements = true,
			GameStateRequirements =
			{
				-- None
			},

			-- I'll say!
			{ Cue = "/VO/Skelly_0195", },
			-- Isn't it, though?
			{ Cue = "/VO/Skelly_0196", },
			-- And have I mentioned that it cost a lot of coin?
			{ Cue = "/VO/Skelly_0197", },
			-- It weighs an awful lot, too.
			{ Cue = "/VO/Skelly_0198", },
			-- I know what you mean pal.
			{ Cue = "/VO/Skelly_0199", },
			-- Definitely yeah.
			{ Cue = "/VO/Skelly_0200", },
			-- You said it, boyo.
			{ Cue = "/VO/Skelly_0201", },
			-- Isn't she beautiful?
			{ Cue = "/VO/Skelly_0202", },
			-- I was just thinking the same.
			{ Cue = "/VO/Skelly_0203", },
			-- You got taste, pal, I will give you that.
			{ Cue = "/VO/Skelly_0204", },
			-- She's definitely pretty good!
			{ Cue = "/VO/Skelly_0205", },
			-- Only the best for you, pal.
			{ Cue = "/VO/Skelly_0206", },
			-- That is an excellent interpretation boyo.
			{ Cue = "/VO/Skelly_0207", },
			-- I see exactly what you mean.
			{ Cue = "/VO/Skelly_0208", },
			-- I knew you would appreciate that aspect.
			{ Cue = "/VO/Skelly_0209", },
			-- I know, right?
			{ Cue = "/VO/Skelly_0210", },
			-- Oh absolutely, yeah.
			{ Cue = "/VO/Skelly_0211", },
			-- You earned it, pal.
			{ Cue = "/VO/Skelly_0241", },
			-- I feel exactly the same way.
			{ Cue = "/VO/Skelly_0531", },
			-- Can't get over how tall they are!
			{ Cue = "/VO/Skelly_0532", },
			-- That is one keen eye.
			{ Cue = "/VO/Skelly_0533", },
			-- I can't get over it, myself.
			{ Cue = "/VO/Skelly_0534", },
		},
	},

	ThankingCharacterVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.65,
		CooldownTime = 5,
		SuccessiveChanceToPlay = 0.75,
		RequiredFalseRooms = { "B_Story01", "C_Story01" },

		-- moved to NPCData
	},

	-- Run Cleared
	RunClearedVoiceLines =
	{
		Queue = "Always",
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.15,
			SkipAnim = true,
			RequiresBestClearTime = true,
			RequiredMinRunsCleared = 2,
			RequiredFalseTextLinesThisRun = { "LordHadesDefeated01" },

			-- Made short work that time.
			{ Cue = "/VO/ZagreusField_1648" },
			-- Now that was quick.
			{ Cue = "/VO/ZagreusField_1649" },
			-- That was as fast as I've gone.
			{ Cue = "/VO/ZagreusField_1650" },
			-- Done with time to spare.
			{ Cue = "/VO/ZagreusField_1651" },
			-- Quick as a flash that time.
			{ Cue = "/VO/ZagreusField_1652" },
			-- Hermes would be proud.
			{ Cue = "/VO/ZagreusField_1653" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.15,
			SuccessiveChanceToPlay = 0.75,
			SkipAnim = true,
			RequiredFalseTextLinesThisRun = { "LordHadesDefeated01" },

			-- In my father's name.
			{ Cue = "/VO/ZagreusField_2181", RequiredPlayed = { "/VO/ZagreusField_2185" } },
			-- In the name of someone very sore right now.
			{ Cue = "/VO/ZagreusField_2182", RequiredPlayed = { "/VO/ZagreusField_2185", "/VO/ZagreusField_2181"}, ChanceToPlay = 0.5 },
			-- By my father's name.
			{ Cue = "/VO/ZagreusField_2183", RequiredPlayed = { "/VO/ZagreusField_2185" } },
			-- I did it.
			{ Cue = "/VO/ZagreusField_2184", RequiredPlayed = { "/VO/ZagreusField_2185" }, CooldownName = "SaidIDidItRecently", CooldownTime = 40, },
			-- I did it!
			{ Cue = "/VO/ZagreusField_2185", CooldownName = "SaidIDidItRecently", CooldownTime = 40, },
		},
		{
			RandomRemaining = true,
			PreLineWait = 1.15,
			SkipAnim = true,
			RequiredFalseTextLinesThisRun = { "LordHadesDefeated01" },

			-- In the name of Hades.
			{ Cue = "/VO/ZagreusField_0176" },
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
			-- In the name of Hades...!
			{ Cue = "/VO/ZagreusField_0986" },
		},
	},

	-- Field Events
	ThanatosSpawningVoiceLines =
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlayAll = 0.5,

		-- I hear something.
		{ Cue = "/VO/ZagreusField_0124" },
		-- Something's off...
		{ Cue = "/VO/ZagreusField_0157", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredFalseTextLines = { "ThanatosGift07_A" }, },
		-- Something's amiss...
		{ Cue = "/VO/ZagreusField_0158", RequiredFalseTextLines = { "ThanatosGift07_A" }, },
		-- Thanatos.
		{ Cue = "/VO/ZagreusField_1432", RequiredPlayed = { "/VO/ZagreusField_0124" } },
		-- Thanatos...
		{ Cue = "/VO/ZagreusField_1433", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredFalseTextLines = { "ThanatosGift06" }, },
		-- Thanatos!
		-- { Cue = "/VO/ZagreusField_1434", RequiredPlayed = { "/VO/ZagreusField_0124" } },
		-- Than!
		{ Cue = "/VO/ZagreusField_1435", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredTextLines = { "ThanatosGift05" } },
		-- Thanatos...!
		{ Cue = "/VO/ZagreusField_1436", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredTextLines = { "ThanatosGift07_A" }, },
		-- Thanatos...?
		{ Cue = "/VO/ZagreusField_1437", RequiredPlayed = { "/VO/ZagreusField_0124" } },
		-- It's him.
		{ Cue = "/VO/ZagreusField_2923", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredFalseTextLines = { "ThanatosGift05" }, },
		-- It's him...!
		{ Cue = "/VO/ZagreusField_2924", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredTextLines = { "ThanatosGift03" } },
		-- Than...!
		{ Cue = "/VO/ZagreusField_2925", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredTextLines = { "ThanatosGift04" } },
		-- Here he comes.
		{ Cue = "/VO/ZagreusField_2926", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredTextLines = { "ThanatosGift10" } },
		-- Death approaches?
		{ Cue = "/VO/ZagreusField_2927", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredTextLines = { "ThanatosGift05" } },
		-- I know that toll.
		{ Cue = "/VO/ZagreusField_2928", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredTextLines = { "ThanatosGift03" } },
		-- Come on in, Than.
		{ Cue = "/VO/ZagreusField_2929", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredTextLines = { "ThanatosGift10" } },
		-- Hey, Than.
		{ Cue = "/VO/ZagreusField_4071", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredTextLines = { "ThanatosGift10" } },
		-- Ah, yes.
		{ Cue = "/VO/ZagreusField_4072", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredTextLines = { "ThanatosGift10" } },
		-- Was just thinking about you.
		{ Cue = "/VO/ZagreusField_4073", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredAnyTextLines = { "BecameCloseWithThanatos01Than_GoToHim", "BecameCloseWithThanatos01_BThan_GoToHim" } },
		-- Just in time.
		{ Cue = "/VO/ZagreusField_4074", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredTextLines = { "ThanatosGift10" } },
		-- Guh-dong...
		{ Cue = "/VO/ZagreusField_4075", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredTextLines = { "ThanatosGift10" } },
		-- Hi there.
		{ Cue = "/VO/ZagreusField_4076", RequiredPlayed = { "/VO/ZagreusField_0124" }, RequiredTextLines = { "ThanatosGift10" }, },
	},
}

GlobalModifiers =
{
	WeaponSimulationSlowPreWaitMultiplier = 1.0,
	WeaponSimulationSlowLerpTimeMultiplier = 1.0,
}

GameOutroData =
{
	{
		Header = "Outro_PostEnding01",
		FadeOutWait = 21.6,
		RequiredTextLines = { "Ending01" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0371" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Thus having once more gained the surface of his grim-faced father's realm beneath the earth, resourceful Zagreus makes his way toward the one-time abode of radiant Persephone.
			{ Cue = "/VO/Storyteller_0371", PreLineWait = 0.8, NoTarget = true },
			-- It is a journey of considerable distances, which he has already completed many times, and which has always ended in the same result. So... imagine he made it there with just time enough to water the crops and tidy up a bit, before...
			{ Cue = "/VO/Storyteller_0372", PreLineWait = 0.6, NoTarget = true },
		},
	},
	{
		Header = "Outro_PostEnding02",
		FadeOutWait = 7.2,
		RequiredTextLines = { "Ending01" },
		RequiredPlayed = { "/VO/Storyteller_0372" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0385" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Once more, tenacious Zagreus achieves his lofty goal, and, just as every time before, except with some sort of new twist of Fate, perhaps, he goes a little distance, then he dies.
			{ Cue = "/VO/Storyteller_0385", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_PostEnding03",
		FadeOutWait = 7.0,
		RequiredTextLines = { "Ending01" },
		RequiredPlayed = { "/VO/Storyteller_0385" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0386" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Having already seen the splendid cottage of Persephone sufficient times, the stubborn Underworld Prince nevertheless attempts to go there once again. Although, his memory of it shall have to do.
			{ Cue = "/VO/Storyteller_0386", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_PostEnding04",
		FadeOutWait = 4.2,
		RequiredTextLines = { "Ending01" },
		RequiredPlayed = { "/VO/Storyteller_0386" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0387" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Reflecting on his victory, Prince Zagreus observes how death can take hold in so many different ways, at times quite slowly, and at other times --
			{ Cue = "/VO/Storyteller_0387", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Inescapable",
		FadeOutWait = 3.5,
		SubtitleColor = Color.NarratorVoice,
		RequiredPlayed = { "/VO/Storyteller_0387" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0218" },
		VoiceLines =
		{
			-- The master of this realm, Lord Hades, states that death is inescapable. There is considerable credence to his claim.
			{ Cue = "/VO/Storyteller_0218", PreLineWait = 1.0, NoTarget = true },
		},
	},	
	{
		Header = "Outro_Prince",
		FadeOutWait = 1.5,
		RequiredPlayed = { "/VO/Storyteller_0218" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0182" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Imagine, if you will, the Underworld Prince soon meets one of his typical, ignoble deaths.
			{ Cue = "/VO/Storyteller_0182", PreLineWait = 1.0, NoTarget = true },
		},
	},
	{
		Header = "Outro_RatherGood",
		FadeOutWait = 2.4,
		RequiredPlayed = { "/VO/Storyteller_0182" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0204" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- The Underworld Prince is getting rather good at this. But let us say he perished anyhow.
			{ Cue = "/VO/Storyteller_0204", PreLineWait = 1.0, NoTarget = true },
		},
	},	
	{
		Header = "Outro_Glorious",
		FadeOutWait = 8.5,
		RequiredPlayed = { "/VO/Storyteller_0204" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0280" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- There are a myriad of tales to be told, of both great deeds and of vainglorious defeats, and this has been a tale that falls somewhere in the middle, overall.
			{ Cue = "/VO/Storyteller_0280", PreLineWait = 0.8, NoTarget = true },
		},
	},
	-- end of initial linear series of 8 (18 clears)
	{
		Header = "Outro_Perfume",
		FadeOutWait = 9,
		RequiredTextLines = { "Ending01" },
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0376" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Having gained the surface once again, Prince Zagreus breaths deeply of the wildflowers, and the roses, and the like, among which one of them contains an allergen so intolerably potent, that it causes this:
			{ Cue = "/VO/Storyteller_0376", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Avalanche",
		FadeOutWait = 10,
		RequiredTextLines = { "Ending01" },
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0377" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- As he journeys to his mother's cottage in the cold, loudly-speaking Zagreus calls out to hear the echo of his voice, the blast of sound causing a substantive amount of ice and snow to break off from a nearby mountaintop, and fall, and fall, and...
			{ Cue = "/VO/Storyteller_0377", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_WrongTurn",
		FadeOutWait = 9,
		RequiredTextLines = { "Ending01" },
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0378" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- So complicated is the path to the well-hidden cottage of Persephone that surface-walking Zagreus on this particular occasion sadly zigs instead of zags, plummeting from off a precipice into most-familiar waters...
			{ Cue = "/VO/Storyteller_0378", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Cactus",
		FadeOutWait = 8.3,
		RequiredTextLines = { "Ending01" },
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0379" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Amid the wondrous ever-springing garden of Persephone, Prince Zagreus discovers a greenish plant of some sort, supple-skinned and covered all in spines, a bit too small to see, until it is too late...
			{ Cue = "/VO/Storyteller_0379", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Bear",
		FadeOutWait = 10.5,
		RequiredTextLines = { "Ending01" },
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0380" },
		RequiredMinRunsCleared = 20,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- The limitless variety of fauna dwelling on the surface brings to Zagreus no shortage of delight.
			{ Cue = "/VO/Storyteller_0380", PreLineWait = 0.8, NoTarget = true },
			-- Though, when he makes an effort to communicate with one, its eyes so full of calm intelligence, he learns that bears are not as gentle as they seem.
			{ Cue = "/VO/Storyteller_0410", PreLineWait = 0.3, NoTarget = true },
		},
	},
	{
		Header = "Outro_MountainGoat",
		FadeOutWait = 8.3,
		RequiredTextLines = { "Ending01" },
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0382" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Horned creatures are familiar to Zagreus, having fought countless Satyrs and the like; but he discovers, this time, that not even Satyrs possess the sheer, ferocious power of a startled mountain-goat...
			{ Cue = "/VO/Storyteller_0382", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Snake",
		FadeOutWait = 12,
		RequiredTextLines = { "Ending01" },
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0383" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Snakes and serpents rank amongst the creatures somewhat known to Zagreus, due to their presence in the Underworld.
			{ Cue = "/VO/Storyteller_0383", PreLineWait = 0.8, NoTarget = true },
			-- So it is with delight that he approaches one upon the surface, greeting it as a familiar friend. It greets him venomously back, using its fangs.
			{ Cue = "/VO/Storyteller_0384", PreLineWait = 0.6, NoTarget = true },
		},
	},
	{
		Header = "Outro_Spears",
		FadeOutWait = 2.75,
		RequiredMinRunsCleared = 30,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0206" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Alas, the wisely-spoken Zagreus... stumbled upon a pit of deadly spears, perhaps?
			{ Cue = "/VO/Storyteller_0206", PreLineWait = 1.0, NoTarget = true },
		},
	},
	{
		Header = "Outro_Doom",
		FadeOutWait = 2.55,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0209" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Prince Zagreus proceeded onward toward his certain doom, entirely too graphic to describe.
			{ Cue = "/VO/Storyteller_0209", PreLineWait = 1.0, NoTarget = true },
		},
	},
	{
		Header = "Outro_Horrifying",
		FadeOutWait = 2.55,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0210" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Beyond this point lies such a horrifying fate that we had better speak no more of it for now.
			{ Cue = "/VO/Storyteller_0210", PreLineWait = 1.0, NoTarget = true },
		},
	},
	{
		Header = "Outro_Beetle",
		FadeOutWait = 4,
		RequiredMinRunsCleared = 35,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0211" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Just then, erm, how about a very small yet very deadly beetle landed upon Hydra-slaying Zagreus, ending his attempt?
			{ Cue = "/VO/Storyteller_0211", PreLineWait = 1.0, NoTarget = true },
		},
	},
	{
		Header = "Outro_Precipice",
		FadeOutWait = 3.5,
		RequiredMinRunsCleared = 30,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0212" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- The never-learning Zagreus then... carelessly fell off a precipice, or something, plunging him into the rapids of the Styx.
			{ Cue = "/VO/Storyteller_0212", PreLineWait = 1.0, NoTarget = true },
		},
	},
	{
		Header = "Outro_Variety",
		FadeOutWait = 3.5,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0216" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Although there are innumerable ways for one to die, our danger-seeking Prince has come to know a sizable variety.
			{ Cue = "/VO/Storyteller_0216", PreLineWait = 1.0, NoTarget = true },
		},
	},
	{
		Header = "Outro_Clever",
		FadeOutWait = 5.2,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0217" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- The clever-minded Prince again eluded certain death, up to a certain point, but then, predictably made one of his fatal mistakes, again.
			{ Cue = "/VO/Storyteller_0217", PreLineWait = 1.0, NoTarget = true },
		},
	},
	{
		Header = "Outro_Another",
		FadeOutWait = 3.5,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0219" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- The oft-impatient Zagreus appears to take repeated deaths in stride, and so, here comes another one for him.
			{ Cue = "/VO/Storyteller_0219", PreLineWait = 1.0, NoTarget = true },
		},
	},
	{
		Header = "Outro_Setbacks",
		FadeOutWait = 4.25,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0230" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Having ventured successfully much farther than before, the surface-seeking Prince encounters setbacks far too hideous to be described.
			{ Cue = "/VO/Storyteller_0230", PreLineWait = 1.0, NoTarget = true },
		},
	},
	{
		Header = "Outro_Wall",
		FadeOutWait = 5.0,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0236" },
		RequiredMinRunsCleared = 30,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Just then, the carefree-running Underworld Prince runs headlong into a thick and deadly wall of stone, painted to look like the way out.
			{ Cue = "/VO/Storyteller_0236", PreLineWait = 1.0, NoTarget = true },
		},
	},
	{
		Header = "Outro_Fungus",
		FadeOutWait = 5.0,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0238" },
		RequiredMinRunsCleared = 30,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Filled with such confidence, the Prince neglected to avoid, erm, stepping on a toxic strain of fungus, so rare you'd not have heard of it.
			{ Cue = "/VO/Storyteller_0238", PreLineWait = 1.0, NoTarget = true },
		},
	},
	{
		Header = "Outro_Dream",
		FadeOutWait = 7.75,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0263" },
		RequiredMinRunsCleared = 30,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Having somehow defeated grim Lord Hades in a thrilling fight, Prince Zagreus discovers... it was all a dream! A rather deadly nightmare, actually.
			{ Cue = "/VO/Storyteller_0263", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Confines",
		FadeOutWait = 6.25,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0264" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Despite having transcended past the confines of the Underworld yet again, Prince Zagreus proves utterly unable to get past this point.
			{ Cue = "/VO/Storyteller_0264", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Change",
		FadeOutWait = 6.9,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0265" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Imagine that Prince Zagreus experiences some sort of joyous outcome, for a change, in contrast to the arbitrary and unfortunately painful death he shall experience... now.
			{ Cue = "/VO/Storyteller_0265", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Shiver",
		FadeOutWait = 7,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0266" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- After defeating his lord father, yet again, Prince Zagreus begins to shiver, and catch cold. And, as is well known, there sadly is no cure for such a thing.
			{ Cue = "/VO/Storyteller_0266", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Tool",
		FadeOutWait = 8.5,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0267" },
		RequiredMinRunsCleared = 30,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- As he explores the wonders of the world, Prince Zagreus discovers a quaint farm, in which he carelessly trespasses, stepping on a farming-tool, which swoops up and strikes him in the forehead, fatally.
			{ Cue = "/VO/Storyteller_0267", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Tale",
		FadeOutWait = 2.5,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0268" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- One might suppose the Prince's tale most likely ends akin to other tales of the heroes of our time, like so:
			{ Cue = "/VO/Storyteller_0268", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Sure",
		FadeOutWait = 10.3,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0276" },
		RequiredMinRunsCleared = 30,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- The favor-doing Zagreus then walks into a chamber, black as night, but with a blood-red pool, and from it comes a voice which says: Would you mind diving in these waters, Prince? To which the Prince replies, Oh! Sure.
			{ Cue = "/VO/Storyteller_0276", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Chariot",
		FadeOutWait = 8.1,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0277" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Mere moments from his final victory, the Prince, in his great haste, ignored surveying each side of a rather busy crossing, where a swiftly-passing chariot collided with him, very forcefully.
			{ Cue = "/VO/Storyteller_0277", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Demises",
		FadeOutWait = 8.1,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0278" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- The often-dying Prince, having achieved his purpose, then reflects upon his life and deeds, remembering his many past demises with such vivid clarity, that this occurs:
			{ Cue = "/VO/Storyteller_0278", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Peel",
		FadeOutWait = 9.6,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0279" },
		RequiredMinRunsCleared = 30,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- In his great hurry to explore the country-side, the hapless-footed Prince steps on the peel of a most-exotic sallow-colored fruit, and tumbles backward with such sudden, violent force that you-know-what occurs.
			{ Cue = "/VO/Storyteller_0279", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Ideas",
		FadeOutWait = 7.6,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0281" },
		RequiredMinRunsCleared = 50,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- He cannot kill me like this every time, believes the Underworld Prince. He shall eventually have no more ideas. But the Prince, as often is the case, is wrong.
			{ Cue = "/VO/Storyteller_0281", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Steam",
		FadeOutWait = 9.1,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0283" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Just when his victory was all but certain, a fissure opens underneath the feet of the ill-fated Prince, and from it vents a cloud of superheated water-vapor; steam, as it is known! And probably you know what happens next.
			{ Cue = "/VO/Storyteller_0283", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Waiting",
		FadeOutWait = 11.75,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0302" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Upon the surface realm, the mortal-loving Prince would doubtless find that death still comes in a variety of different forms. One of the most common, yet perhaps least interesting, involves simply waiting... long... enough... until...
			{ Cue = "/VO/Storyteller_0302", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Mundanity",
		FadeOutWait = 10.75,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0338" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Having achieved his goal, the Underworld Prince discovers that the mortal realm is utterly bereft of the life-threatening excitement to which he has grown accustomed, and the lack of anything of note to do, the sheer mundanity, results in this:
			{ Cue = "/VO/Storyteller_0338", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		Header = "Outro_Bloodless",
		FadeOutWait = 5.65,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0207" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Then, erm, valiantly striding Zagreus was set upon by seven Bloodless Slam-Dancers, and slain. Or something of the sort.
			{ Cue = "/VO/Storyteller_0207", PreLineWait = 1.0, NoTarget = true },
		},
	},	
	{
		Header = "Outro_Joy",
		FadeOutWait = 5.3,
		SubtitleColor = Color.NarratorVoice,
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0239" },
		VoiceLines =
		{
			-- So joyfully did Zagreus attempt to gain the surface that, why, he just rose too quickly; and we know how that one goes, from Icarus' tale.
			{ Cue = "/VO/Storyteller_0239", PreLineWait = 1.0, NoTarget = true },
		},
	},
	{
		PlayOnce = true,
		Header = "Outro_StartingOver",
		FadeOutWait = 8.6,
		RequiredTextLines = { "Ending01" },
		RequiredPlayed = { "/VO/Storyteller_0371", "/VO/Storyteller_0385", "/VO/Storyteller_0386", "/VO/Storyteller_0387", "/VO/Storyteller_0376", "/VO/Storyteller_0377", "/VO/Storyteller_0378", "/VO/Storyteller_0379", "/VO/Storyteller_0380", "/VO/Storyteller_0382", "/VO/Storyteller_0383", "/VO/Storyteller_0204", "/VO/Storyteller_0206", "/VO/Storyteller_0209", "/VO/Storyteller_0210", "/VO/Storyteller_0211", "/VO/Storyteller_0212", "/VO/Storyteller_0216", "/VO/Storyteller_0217", "/VO/Storyteller_0219", "/VO/Storyteller_0230", "/VO/Storyteller_0236", "/VO/Storyteller_0238", "/VO/Storyteller_0263", "/VO/Storyteller_0264", "/VO/Storyteller_0265", "/VO/Storyteller_0266", "/VO/Storyteller_0267", "/VO/Storyteller_0268", "/VO/Storyteller_0276", "/VO/Storyteller_0277", "/VO/Storyteller_0278", "/VO/Storyteller_0279", "/VO/Storyteller_0280", "/VO/Storyteller_0281", "/VO/Storyteller_0283", "/VO/Storyteller_0302", "/VO/Storyteller_0338", "/VO/Storyteller_0182", "/VO/Storyteller_0207", "/VO/Storyteller_0218", "/VO/Storyteller_0239" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0381" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- ...I have no new tales left to tell. But do not think that you have won, Prince Zagreus... for any tale worth telling... is a tale worth telling again, and again, and again. Bye-bye!
			{ Cue = "/VO/Storyteller_0381", PreLineWait = 0.8, NoTarget = true },
		},
	},

	-- end of endings

	-- retired / from Early Access
	{
		Header = "Outro_Duty",
		FadeOutWait = 1.75,
		RequiredFalseTextLines = { "LordHadesDefeated01", "PersephoneFirstMeeting" },
		RequiredPlayed = { "/VO/Storyteller_0280" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0208" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- The duty-shirking Prince then met another of his fated deaths, in fashion best left to imagination.
			{ Cue = "/VO/Storyteller_0208", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- retired / from Early Access
	{
		Header = "Outro_NotThis",
		FadeOutWait = 7.5,
		RequiredFalseTextLines = { "LordHadesDefeated01", "PersephoneFirstMeeting" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0285" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- One of these days, or nights, not so very long from now, the Prince may finally traverse beyond this point. And then, what shall become of him and I? Well, hopefully, not this:
			{ Cue = "/VO/Storyteller_0285", PreLineWait = 0.8, NoTarget = true },
		},
	},
	-- retired
	{
		Header = "Outro_Unrelenting",
		FadeOutWait = 2.85,
		RequiredFalseTextLines = { "LordHadesDefeated01", "PersephoneFirstMeeting" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0213" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- The unrelenting Underworld Prince again vainly attempted to proceed beyond the current limits of this tale.
			{ Cue = "/VO/Storyteller_0213", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- retired
	{
		Header = "Outro_Transgress",
		FadeOutWait = 3.75,
		RequiredFalseTextLines = { "LordHadesDefeated01", "PersephoneFirstMeeting" },
		RequiredFalsePlayedLastRun = { "/VO/Storyteller_0214" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- The hint-ignoring Prince again attempted to transgress, to no avail, into domains not yet prepared for his arrival.
			{ Cue = "/VO/Storyteller_0214", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- first ending: styx last biome
	-- retired
	{
		PlayOnce = true,
		Header = "Outro_Father",
		RequiredKills = { Hades = 1 },
		RequiredFalseTextLines = { "LordHadesDefeated01", "PersephoneFirstMeeting" },
		FadeOutWait = 21,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Thus having somehow vanquished his own father, the grim god of the dead, defiant Zagreus is finally set free to seek the hidden place in which his long-lost birthmother resides.
			{ Cue = "/VO/Storyteller_0260", PreLineWait = 0.8, NoTarget = true },
			-- How shall that all work out for him? Alas, it is as yet too soon to say.
			{ Cue = "/VO/Storyteller_0261", PreLineWait = 0.6, NoTarget = true },
			-- Pretend for now that the Lord Hades absolutely clobbered him.
			{ Cue = "/VO/Storyteller_0262", PreLineWait = 0.5, NoTarget = true },
		},
	},
	-- retired
	{
		RequiredRunsCleared = 2,
		Header = "Outro_Prince",
		RequiredFalseTextLines = { "LordHadesDefeated01", "PersephoneFirstMeeting" },
		FadeOutWait = 17.2,
		-- so that 'first ending: styx' is guaranteed to play first
		RequiredPlayed = { "/VO/Storyteller_0260" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Beyond this point, our tale of the Underworld's determined Prince cannot further continue at this time. But time does not stand still, and more, much more, shall someday be revealed....
			{ Cue = "/VO/Storyteller_0184", PreLineWait = 0.8, NoTarget = true },
			-- For now, there is no more to say or show from here, so let us say instead that Zagreus was cruelly killed, again.
			{ Cue = "/VO/Storyteller_0183", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- retired
	{
		PlayOnce = true,
		RequiredMinRunsCleared = 3,
		RequiredFalseTextLines = { "LordHadesDefeated01", "PersephoneFirstMeeting" },
		Header = "Outro_Trials",
		FadeOutWait = 1.75,
		-- so that 'first ending: styx' is guaranteed to play first
		RequiredPlayed = { "/VO/Storyteller_0260" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- The trials of Prince Zagreus have only just begun...
			{ Cue = "/VO/Storyteller_0185", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- retired
	{
		PlayOnce = true,
		RequiredMinRunsCleared = 3,
		RequiredFalseTextLines = { "LordHadesDefeated01", "PersephoneFirstMeeting" },
		Header = "Outro_Underworld",
		FadeOutWait = 5,
		-- so that 'first ending: styx' is guaranteed to play first
		RequiredPlayed = { "/VO/Storyteller_0260" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Our tale of the Underworld Prince is far from finished. But the rest of it shall have to wait until another time.
			{ Cue = "/VO/Storyteller_0186", PreLineWait = 0.8, NoTarget = true },
		},
	},
	-- retired
	{
		PlayOnce = true,
		RequiredMinRunsCleared = 3,
		RequiredFalseTextLines = { "LordHadesDefeated01", "PersephoneFirstMeeting" },
		Header = "Outro_Defying",
		FadeOutWait = 2.5,
		-- so that 'first ending: styx' is guaranteed to play first
		RequiredPlayed = { "/VO/Storyteller_0260" },
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- The tale of death-defying Zagreus shall continue at a later time.
			{ Cue = "/VO/Storyteller_0187", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- first ending: asphodel last biome
	-- retired
	{
		RequiredRunsCleared = 0,
		RequiredFalseSeenRoomThisRun = "C_Boss01",
		Header = "Outro_Zagreus",
		FadeOutWait = 25.3,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Thus having stilled the deathless raging of the bone-forged Hydra, willful Zagreus now presses ever forward, upward, toward his goal: the surface, where his long-lost birthmother resides.
			{ Cue = "/VO/Storyteller_0179", PreLineWait = 0.8, NoTarget = true },
			-- The myriad of challenges and dangers that await beyond the flame-hot river shall be revealed and overcome upon a later time.
			{ Cue = "/VO/Storyteller_0180", PreLineWait = 0.9, NoTarget = true },
			-- Let us imagine that the Prince did not go far, before falling once more into his father's house....
			{ Cue = "/VO/Storyteller_0181", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- first ending: elysium last biome
	-- retired
	{
		PlayOnce = true,
		Header = "Outro_Zagreus",
		RequiredKills = { Theseus = 1 },
		FadeOutWait = 16.75,
		RequiredFalseSeenRoomThisRun = "D_Boss01",
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Thus having vanquished the heroic king of Athens, willful Zagreus now presses ever forward, upward, toward his goal: the surface, where his long-lost birthmother resides.
			{ Cue = "/VO/Storyteller_0240", PreLineWait = 0.8, NoTarget = true },
			-- Our tale of the Underworld Prince is far from finished. But the rest of it shall have to wait until another time.
			{ Cue = "/VO/Storyteller_0186", PreLineWait = 0.8, NoTarget = true },
		},
	},
	-- retired
	{
		RequiredMinRunsCleared = 6,
		Header = "Outro_Pretend",
		FadeOutWait = 2.35,
		RequiredFalseSeenRoomThisRun = "D_Boss01",
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Pretend our deftly-footed Prince did not survive the boastings of the Champion back there.
			{ Cue = "/VO/Storyteller_0241", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- retired
	{
		RequiredMinRunsCleared = 6,
		Header = "Outro_Misfortune",
		FadeOutWait = 4.5,
		RequiredFalseSeenRoomThisRun = "C_Boss01",
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- The burning fields of Asphodel again proved unable to stop the flame-resistant Prince, but then, misfortune struck, just like it always does.
			{ Cue = "/VO/Storyteller_0215", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- retired
	{
		RequiredMinRunsCleared = 6,
		Header = "Outro_Dismay",
		FadeOutWait = 6.0,
		RequiredFalseSeenRoomThisRun = "D_Boss01",
		VoiceLines =
		{
			-- Thus did the fate-confronting Prince traverse Elysium, where he discovers to his great dismay such horrors as can only be detailed at some other, later time.
			{ Cue = "/VO/Storyteller_0231", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- retired
	{
		RequiredMinRunsCleared = 6,
		Header = "Outro_Hero",
		FadeOutWait = 4.0,
		RequiredFalseSeenRoomThisRun = "D_Boss01",
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- As hero-thwarting Zagreus approaches perilously closer to the surface, he... perhaps gets caught within a rockfall of some sort.
			{ Cue = "/VO/Storyteller_0232", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- retired
	{
		RequiredMinRunsCleared = 6,
		Header = "Outro_Dangers",
		FadeOutWait = 5.0,
		RequiredFalseSeenRoomThisRun = "D_Boss01",
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- With oft-undocumented dangers of Elysium well behind him, now Prince Zagreus faces an even greater threat... one which I shall get back to you about.
			{ Cue = "/VO/Storyteller_0233", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- retired
	{
		RequiredMinRunsCleared = 6,
		Header = "Outro_Stifling",
		FadeOutWait = 3.35,
		RequiredFalseSeenRoomThisRun = "D_Boss01",
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- So stifling is the thick darkness past Elysium, that the ill-fated Prince there bumps his head extremely hard, and dies.
			{ Cue = "/VO/Storyteller_0235", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- retired
	{
		RequiredMinRunsCleared = 6,
		Header = "Outro_BehindYou",
		FadeOutWait = 3.75,
		RequiredFalseSeenRoomThisRun = "D_Boss01",
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Beyond the splendors of Elysium, the ever-patient Prince shall find his fate, eventually, but not right now, because--oh no, watch out!
			{ Cue = "/VO/Storyteller_0237", PreLineWait = 1.0, NoTarget = true },
		},
	},
	-- retired
	{
		RequiredMinRunsCleared = 6,
		Header = "Outro_Victory",
		FadeOutWait = 5.0,
		RequiredFalseSeenRoomThisRun = "D_Boss01",
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Whilst well within arm's reach of victory, the bull-defeating Prince succumbs to a large pack of sinisterly harmless-seeming rodents.
			{ Cue = "/VO/Storyteller_0234", PreLineWait = 1.0, NoTarget = true },
		},
	},
}

GameData.DamageNumberTextScales =
{
	{ Min = 0, Max = 19, Scale = 0.8 },
	{ Min = 20, Max = 49, Scale = 0.9 },
	{ Min = 50, Max = 99, Scale = 1.0 },
	{ Min = 100, Max = 399, Scale = 1.2 },
	{ Min = 400, Max = 999, Scale = 1.4 },
	{ Min = 1000, Max = 99999, Scale = 1.6 },
}