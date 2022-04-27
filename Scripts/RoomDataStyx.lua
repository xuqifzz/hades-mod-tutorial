RoomSetData.Styx =
{
	BaseStyx =
	{
		DebugOnly = true,

		--DevotionEncounters = {"DevotionTestElysium"},
		LocationText = "Location_Styx",
		LocationTextShort = "Location_Styx_Short",
		ResultText = "RunHistoryScreenResult_Styx",
		RichPresence = "#RichPresence_Styx",
		BlockHadesOverlay = true,
		TargetMetaRewardsRatio = 0.33,
		SecretSpawnChance = 0.0,
		SecretDoorRequirements =
		{
			RequiredTextLines = { "HermesFirstPickUp" },
			RequiredFalseTextLinesThisRun = { "HermesFirstPickUp" },
			RequiredMinRoomsSinceSecretDoor = 8,
			RequiredMaxBiomeDepth = 6,
		},
		ShrinePointDoorCost = 20,
		ShrinePointDoorSpawnChance = 0.0,
		ShrinePointDoorRequirements =
		{
			RequiredScreenViewed = "ShrineUpgrade",
			RequiredMinRoomsSinceShrinePointDoor = 8,
			RequiredCosmetics = { "ShrinePointGates", },
		},
		ChallengeSpawnChance = 0,
		ChallengeSwitchRequirements =
		{
			RequiredMinBiomeDepth = 2,
			RequiredMinRoomsSinceChallengeSwitch = 6,
		},
		WellShopSpawnChance = 0.20,
		WellShopRequirements =
		{
			RequiredMinCompletedRuns = 1,
			RequiredMinRoomsSinceWellShop = 6,
		},
		SellTraitShopChance = 0.15,
		SellTraitShopRequirements =
		{
			RequiredMinCompletedRuns = 1,
			RequiredUpgradeableGodTraits = 3,
			RequiredMinRoomsSinceSellTraitShop = 6,
		},
		FishingPointChance = 0.1,
		FishingPointRequirements =
		{
			RequiredCosmetics = { "FishingUnlockItem" },
			RequiredMinRoomsSinceFishingPoint = 10,
		},
		StopSecretMusic = true,

		RandomStemMixerOptions = 4,

		ZoomFraction = 0.95,
		SoftClamp = 0.75,
		BreakableOptions = { "BreakableStyxIdle1", "BreakableStyxIdle2", "BreakableStyxIdle3" },
		BreakableValueOptions = { MaxHighValueBreakables = 6 },

		ForcedRewardStore = "RunProgress",
		OptionalOverrides =
		{
			RequireWingEndMiniBoss = true,
			RewardPreviewIcon = "RoomElitePreview2",
			RewardPreviewFx = "RoomRewardAvailableRareSparkles",
			RewardBoostedAnimation = "RoomRewardAvailableRareSparkles",
			BoonRaritiesOverride =
			{
				LegendaryChance = 0.1,
				EpicChance = 0.25,
				RareChance = 0.90
			},
			StackNumOverride = 2,
			RewardConsumableOverrides =
			{
				AddMaxHealth = 50,
				DropMoney = 200,
			},
			IneligibleRewards = { "WeaponUpgrade" },
		},

		LegalEncounters = { "GeneratedStyx" },
		ChallengeEncounterName = "TimeChallengeStyx",

		WallSlamMultiplier = 2.5,

		SwapSounds =
		{
			["/SFX/Enemy Sounds/Brimstone/CrystalBeamAttackLoop"] = "/SFX/Enemy Sounds/HeavyRangedForked/CrystalBeamAttackLoop",
			["/SFX/Enemy Sounds/Brimstone/CrystalBeamFireStart"] = "/SFX/Enemy Sounds/HeavyRangedForked/CrystalBeamFireStart",
			["/SFX/Enemy Sounds/Brimstone/CrystalBeamPreAttack"] = "/SFX/Enemy Sounds/HeavyRangedForked/CrystalBeamPreAttack",
		},
	},

	BaseStyxWingEnd =
	{
		DebugOnly = true,
		WingRoom = true,
		WingEndRoom = true,
		MaxAppearancesThisBiome = 1,
		LinkedRoom = "D_Hub",
		NextRoomEntranceFunctionName = "RoomEntrancePortal",

		GameStateRequirements =
		{
			RequiredMinWingDepth = 3,
		},

		MusicSection = 1,
		IgnoreStemMixer = true,
		MusicActiveStems = { "Bass", "Drums", "Guitar", },
	},

	D_Combat01 =
	{
		DebugOnly = true,
		InheritFrom = { "BaseStyxWingEnd", "BaseStyx", "RandomizeTrapTypes" },

		NumExits = 1,
		ZoomFraction = 0.85,
		EntranceDirection = "Left",
		RushMaxRangeOverride = 535,

		RemoteTrapChains =
		{
			[510795] = {
				Chains =
				{
					{ 510921, 510919, 510920, 510922, },
				},
			},
			[510995] = {
				Chains =
				{
					{ 510999, 511001, 510996, 510998, },
				},
			},
		},
	},

	D_Combat02 =
	{
		InheritFrom = { "BaseStyxWingEnd", "BaseStyx", "RandomizeTrapTypes" },

		NumExits = 1,
		ZoomFraction = 0.85,
		EntranceDirection = "Left",

		RemoteTrapChains =
		{
			[511198] = {
				Chains =
				{
					{ 546150, 511200, 546046, 546047, 511199, 511202, }
				},
			},
			[546136] = {
				Chains =
				{
					{ 510924, 510926, 510923, 511191, 511190, 511189, }
				},
			},
		},
	},

	D_Combat03 =
	{
		InheritFrom = { "BaseStyxWingEnd", "BaseStyx", "RandomizeTrapTypes" },

		NumExits = 1,
		ZoomFraction = 0.85,
		EntranceDirection = "Right",

		RemoteTrapChains =
		{
		},
	},

	D_Combat04 =
	{
		DebugOnly = true,
		InheritFrom = { "BaseStyxWingEnd", "BaseStyx", "RandomizeTrapTypes" },

		NumExits = 1,
		ZoomFraction = 0.85,
		EntranceDirection = "Left",
	},

	D_Combat05 =
	{
		DebugOnly = true,
		InheritFrom = { "BaseStyxWingEnd", "BaseStyx", "RandomizeTrapTypes" },

		NumExits = 1,
		ZoomFraction = 0.85,
		EntranceDirection = "Right",
	},

	D_Combat06 =
	{
		InheritFrom = { "BaseStyxWingEnd", "BaseStyx", "RandomizeTrapTypes" },

		NumExits = 1,
		ZoomFraction = 0.85,
		EntranceDirection = "Left",

		RemoteTrapChains =
		{
			[546153] = {
				Chains =
				{
					{ 546161, 546162, }
				},
			},
			[546177] = {
				Chains =
				{
					{ 546175, 546176, }
				},
			},
		},
	},

	BaseStyxMiniBoss =
	{
		DebugOnly = true,
		WingEndMiniBoss = true,
		MaxCreationsThisRun = 1,
		MaxAppearancesThisBiome = 1,

		WellShopSpawnChance = 0.0,
		IsMiniBossRoom = true,
		RewardPreviewIcon = "RoomElitePreview2",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",

		UnthreadedEvents =
		{
			{
				FunctionName = "CheckAssistHint",
				Args =
				{
					Delay = 10.0,
				}
			},
		},
	},

	D_MiniBoss01 =
	{
		InheritFrom = { "BaseStyxMiniBoss", "BaseStyxWingEnd", "BaseStyx", },

		LegalEncounters = { "MiniBossSatyr" },

		NumExits = 1,

		Ambience = "/Leftovers/Object Ambiences/EvilLairAmbienceMatchSiteE",

		EntranceDirection = "Left",
		ZoomFraction = 0.95,

		CombatResolvedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.6,
			SuccessiveChanceToPlayAll = 0.05,
			ThreadName = "RoomThread",

			-- Go clop your hooves in hell.
			{ Cue = "/VO/ZagreusField_2877" },
			-- Get out of here!
			{ Cue = "/VO/ZagreusField_2878" },
		},
	},

	D_MiniBoss02 =
	{
		InheritFrom = { "BaseStyxMiniBoss", "BaseStyxWingEnd", "BaseStyx", },

		LegalEncounters = { "MiniBossRatThug" },

		NumExits = 1,

		Ambience = "/Leftovers/Object Ambiences/EvilLairAmbienceMatchSiteE",

		EntranceDirection = "Left",
		ZoomFraction = 0.95,

		RemoteTrapChains =
		{
			[430005] = {
				Chains =
				{
					{ 547458, 547459, 547460, 430004, },
				},
			},
			[547473] = {
				Chains =
				{
					{ 547458, 547459, 547460, 430004, },
				},
			},
			[547474] = {
				Chains =
				{
					{ 547458, 547459, 547460, 430004, },
				},
			},
			[547601] = {
				Chains =
				{
					{ 547458, 547459, 547460, 430004, },
				},
			},
			[547476] = {
				Chains =
				{
					{ 547600, 547599, 547597, 547598, },
				},
			},
		},

		CombatResolvedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.6,
			SuccessiveChanceToPlayAll = 0.05,
			ThreadName = "RoomThread",

			-- Yeugh, those things...
			{ Cue = "/VO/ZagreusField_2881" },
			-- Where are they coming from...
			{ Cue = "/VO/ZagreusField_2882" },
		},

		InspectPoints =
		{
			[554226] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTextLines = { "CerberusBossDoorUnlock01" },
				InteractTextLineSets =
				{
					Inspect_D_MiniBoss_02_01 =
					{
						-- This gigantic vermin head deserves a lot more credit if you ask me.
						EndCue = "/VO/ZagreusField_2913",
						EndWait = 0.4,
						{ Cue = "/VO/Storyteller_0284",
							Text = "{#DialogueItalicFormat}Inside the filth-encrusted lairs carved into the looming edifices of the Underworld lie such terrible abominations that not even grim Lord Hades is inclined to speak of them." },
					},
				},
			},
		},

	},

	D_MiniBoss03 =
	{
		InheritFrom = { "BaseStyxMiniBoss", "BaseStyxWingEnd", "BaseStyx", },

		LegalEncounters = { "MiniBossCrawler", "MiniBossHeavyRangedForked" },

		EncounterSpecificDataOverwrites =
		{
			MiniBossCrawler =
			{
				EntranceFunctionName = "RoomEntranceCrawlerMiniBoss",
				UnthreadedEvents =
				{
					{
						FunctionName = "BossIntro",
						Args =
						{
							ProcessTextLinesIds = { 552394 },
							SetupBossIds = { 552394 },
						},
					},
					{
						FunctionName = "CheckAssistHint",
						Args =
						{
							Delay = 10.0,
						}
					},
				},
				--IntroSequenceDuration = 4.0,
				SkipLastKillSound = true,
			}
		},

		NumExits = 1,
		ZoomFraction = 0.85,
		EntranceDirection = "Left",

		CombatResolvedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.6,
			SuccessiveChanceToPlayAll = 0.05,
			ThreadName = "RoomThread",
			RequiredEncounters = { "MiniBossHeavyRangedForked" },

			-- The Satyrs must be fashioning those things...
			{ Cue = "/VO/ZagreusField_2885" },
			-- It's quiet, finally...
			{ Cue = "/VO/ZagreusField_2886" },
		},
	},

	D_MiniBoss04 =
	{
		InheritFrom = { "BaseStyxMiniBoss", "BaseStyxWingEnd", "BaseStyx", },

		LegalEncounters = { "MiniBossMineLayer" },

		NumExits = 1,
		ZoomFraction = 0.85,
		EntranceDirection = "Right",

		CombatResolvedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.6,
			SuccessiveChanceToPlayAll = 0.05,
			ThreadName = "RoomThread",

			-- Whew, looks like I'm clear.
			{ Cue = "/VO/ZagreusField_2889" },
			-- What even are those things...
			{ Cue = "/VO/ZagreusField_2890" },
		},
	},

	BaseStyxMini =
	{
		DebugOnly = true,

		LegalEncounters = EncounterSets.StyxEncountersMini,
		DeferReward = true,
		WingRoom = true,
		BlockClearRewards = true,
		MaxAppearancesThisBiome = 2,

		GameStateRequirements =
		{
			RequiredMaxWingDepth = 3,
		},

		NumExits = 1,
		ZoomFraction = 1.0,

		RandomStemMixerOptions = 4,
	},

	D_Mini01 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		EntranceDirection = "Right",
	},

	D_Mini02 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		EntranceDirection = "Right",
	},

	D_Mini03 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		EntranceDirection = "Right",

		PassiveTrapChains =
		{
			{
				StartDelay = 0.0,
				ChainInterval = 0.3,
				Chains =
				{
					{ 510935, },
				},
				ChainCooldown = 2.0,
			},
		},
	},

	D_Mini04 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		EntranceDirection = "Left",
	},

	D_Mini05 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		EntranceDirection = "Right",
	},

	D_Mini06 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		EntranceDirection = "Right",
	},

	D_Mini07 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		EntranceDirection = "Right",

		PassiveTrapChains =
		{
			{
				StartDelay = 0.0,
				ChainInterval = 0.3,
				Chains =
				{
					{ 511345, },
				},
				ChainCooldown = 2.0,
			},
		},
	},

	D_Mini08 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		EntranceDirection = "Right",
	},

	D_Mini09 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		EntranceDirection = "Right",
		LegalEncounters = { "GeneratedStyxMiniSingle" },
	},

	D_Mini10 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		RushMaxRangeOverride = 535,
		EntranceDirection = "Right",
	},

	D_Mini11 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		RushMaxRangeOverride = 535,
		EntranceDirection = "Left",
	},

	D_Mini12 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		RushMaxRangeOverride = 535,
		EntranceDirection = "Right",
	},

	D_Mini13 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		EntranceDirection = "Right",
	},

	D_Mini14 =
	{
		InheritFrom = { "BaseStyxMini", "BaseStyx", },

		EntranceDirection = "Right",
	},

	D_Reprieve01 =
	{
		InheritFrom = { "BaseStyxWingEnd", "BaseStyx", },
		RichPresence = "#RichPresence_StyxHub",
		IneligibleRewards = { "Devotion", },
		SuppressRewardSpawnSounds = true,
		ForceChanceByRemainingWings = true,
		AllowAsAnyWingEnd = true,
		LegalEncounters = { "HealthRestore" },
		EntranceDirection = "Right",
		ZoomFraction = 0.85,

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 7,
			RequiredMinWingDepth = 3,
		},

		SecretMusic = "/Music/BlankMusicCue",
		Ambience = "/Leftovers/Ambience/StillWaterAmbience",

		NumExits = 1,
		SpawnRewardOnId = 40055,

		StartUnthreadedEvents =
		{
			{
				FunctionName = "SpawnConsumables",
				Args =
				{
					Spawns =
					{
						{
							ConsumableName = "CerberusKey",
							DestinationId = 543188,
						}
					}
				},
			},
		},

		EnterVoiceLines =
		{
			{
				-- found early
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				SuccessiveChanceToPlayAll = 0.5,
				RequiredMaxDoorsClosedInRoom = 2,
				RequiredMaxDoorsClosedRoom = "D_Hub",

				-- Found it fast this time.
				{ Cue = "/VO/ZagreusField_3974", RequiredPlayed = { "/VO/ZagreusField_2104" } },
				-- Found it already.
				{ Cue = "/VO/ZagreusField_3975", RequiredPlayed = { "/VO/ZagreusField_2104" } },
				-- Hey, a Satyr sack already.
				{ Cue = "/VO/ZagreusField_3976", RequiredPlayed = { "/VO/ZagreusField_2104" }, CooldownName = "SaidSatyrSackRecently", CooldownTime = 30, },
				-- Satyr sack already, what do you know.
				{ Cue = "/VO/ZagreusField_3977", RequiredPlayed = { "/VO/ZagreusField_2104" }, CooldownName = "SaidSatyrSackRecently", CooldownTime = 30, },
				-- There it is already.
				{ Cue = "/VO/ZagreusField_3978", RequiredPlayed = { "/VO/ZagreusField_2104" } },
			},
			{
				-- found late
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				SuccessiveChanceToPlayAll = 0.5,
				RequiredMinDoorsClosedInRoom = 5,
				RequiredMinDoorsClosedRoom = "D_Hub",

				-- Eugh, finally.
				{ Cue = "/VO/ZagreusField_3979", RequiredPlayed = { "/VO/ZagreusField_2104" } },
				-- There's the Sack, finally.
				{ Cue = "/VO/ZagreusField_3980", RequiredPlayed = { "/VO/ZagreusField_2104" } },
				-- Been looking all over for you.
				{ Cue = "/VO/ZagreusField_3981", RequiredPlayed = { "/VO/ZagreusField_2104" } },
				-- Cerberus must be starving.
				{ Cue = "/VO/ZagreusField_3982", RequiredPlayed = { "/VO/ZagreusField_2104" } },
				-- Finally found it.
				{ Cue = "/VO/ZagreusField_3983", RequiredPlayed = { "/VO/ZagreusField_2104" } },
			},
			{
				RandomRemaining = true,
				PreLineWait = 1.2,
				SuccessiveChanceToPlayAll = 0.5,

				-- Here we are.
				{ Cue = "/VO/ZagreusField_2099", RequiredPlayed = { "/VO/ZagreusField_2104" } },
				-- Ah, good.
				{ Cue = "/VO/ZagreusField_2100", RequiredPlayed = { "/VO/ZagreusField_2104" } },
				-- A Satyr sack.
				{ Cue = "/VO/ZagreusField_2101", RequiredPlayed = { "/VO/ZagreusField_2104" }, CooldownName = "SaidSatyrSackRecently", CooldownTime = 30, },
				-- Another Satyr sack.
				{ Cue = "/VO/ZagreusField_2102", RequiredPlayed = { "/VO/ZagreusField_2104" }, CooldownName = "SaidSatyrSackRecently", CooldownTime = 30, },
				-- There's the Satyr sack.
				{ Cue = "/VO/ZagreusField_2103", RequiredPlayed = { "/VO/ZagreusField_2104" }, CooldownName = "SaidSatyrSackRecently", CooldownTime = 30, },
				-- Satyr storage.
				{ Cue = "/VO/ZagreusField_2104" },
				-- Storage chamber.
				{ Cue = "/VO/ZagreusField_2105", RequiredPlayed = { "/VO/ZagreusField_2104" } },
				-- Should be the place.
				{ Cue = "/VO/ZagreusField_2106", RequiredPlayed = { "/VO/ZagreusField_2104" } },
				-- No Satyrs.
				{ Cue = "/VO/ZagreusField_2096", RequiredPlayed = { "/VO/ZagreusField_2104" } },
				-- No Satyrs?
				{ Cue = "/VO/ZagreusField_2097", RequiredPlayed = { "/VO/ZagreusField_2104" } },
				-- No Satyrs here.
				{ Cue = "/VO/ZagreusField_2098", RequiredPlayed = { "/VO/ZagreusField_2104" } },
			},
		},

		InspectPoints =
		{
			[543192] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTextLines = { "CerberusBossDoorUnlock01" },
				InteractTextLineSets =
				{
					Inspect_D_Reprieve_01_01 =
					{
						-- Cerberus just loves the stuff.
						EndCue = "/VO/ZagreusField_2256",
						EndWait = 0.5,
						{ Cue = "/VO/Storyteller_0251",
							Text = "{#DialogueItalicFormat}Deep within the desecrated lair of the god-defiling Satyrs lie the noisome contents of their profane rituals, so foul as to be indescribable." },
					},
				},
			},
		},
	},

	D_Boss01 =
	{
		InheritFrom = { "BaseStyx" },
		RewardPreviewIcon = "RoomElitePreview4",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",
		ResultText = "RunHistoryScreenResult_D_Boss01",
		RichPresence = "#RichPresence_DBoss01",
		ReverbValue = 0.75,
		BlockHeroLight = true,
		GameStateRequirements =
		{
			-- None
		},

		SpawnRewardOnId = 553271,

		RequiresLinked = true,
		LinkedRoom = "E_Intro",
		Milestone = true,
		MilestoneIcon = "BossIcon",
		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		LoadBackgroundColor = Color.White,
		LegalEncounters = { "BossHades", "BossHadesPeaceful" },
		FirstClearRewardStore = "SuperMetaProgress",
		ForcedRewardStore = "MetaProgress",
		EligibleRewards = { "RoomRewardMetaPointDrop", "RoomRewardMetaPointDropRunProgress", "SuperLockKeyDrop" },
		NoReroll = true,
		RewardConsumableOverrides =
		{
			ValidRewardNames = { "RoomRewardMetaPointDrop", "RoomRewardMetaPointDropRunProgress", },
			AddResources =
			{
				MetaPoints = 250,
			},
		},
		EntranceDirection = "Right",
		BlockRunProgressUI = true,
		BlockTreasureImps = true,
		ZoomFraction = 0.75,
		IntroZoomFraction = 0.7,
		NumExits = 1,
		SkipLastKillPresentation = true,
		LogShrineClears = true,

		FlipHorizontalChance = 0.0,
		BreakableValueOptions = { MaxHighValueBreakables = 0 },

		EntranceFunctionName = "RoomEntranceHades",
		IntroSequenceDuration = 10.0,
		BlockCameraReattach = true,

		FishingPointChance = 0.20,
		FishingPointRequirements =
		{
			RequiredCosmetics = { "FishingUnlockItem" },
			RequiredMinRoomsSinceFishingPoint = 1,
			RequiredTextLines = { "Ending01" },
		},
		FishingPointForceRequirements =
		{
			RequiredCosmetics = { "FishingUnlockItem" },
			RequiredTextLines = { "Ending01" },
			RequiredFalseTextLines = { "LordHadesPostEnding01" },
		},
		FishBiome = "Surface",

		SwapAnimations =
		{
			["DashCrack"] = "DashCrackSnow",
			["RadialNovaRubble"] = "RadialNovaRubbleSnow",
			["InvincibleHitSparkDynamic"] = "InvincibleHitSparkDynamicSnow",
			["FireFootstepL-Spawner"] = "SnowFootstepL-Spawner",
			["FireFootstepR-Spawner"] = "SnowFootstepR-Spawner",
		},

		SwapSounds =
		{
			["/SFX/Player Sounds/FootstepsHardSurface"] = "/SFX/Player Sounds/FootstepsSnow",
			["/SFX/Player Sounds/FootstepsHardSurfaceRun"] = "/SFX/Player Sounds/FootstepsSnow",

			["/SFX/Enemy Sounds/Brimstone/CrystalBeamAttackLoop"] = "/SFX/Enemy Sounds/HeavyRangedForked/CrystalBeamAttackLoop",
			["/SFX/Enemy Sounds/Brimstone/CrystalBeamFireStart"] = "/SFX/Enemy Sounds/HeavyRangedForked/CrystalBeamFireStart",
			["/SFX/Enemy Sounds/Brimstone/CrystalBeamPreAttack"] = "/SFX/Enemy Sounds/HeavyRangedForked/CrystalBeamPreAttack",
		},

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntroHades",
				Args =
				{
					ProcessTextLinesIds = { 510857 },
					SkipAngleTowardTarget = true,
					SkipBossMusic = true,
					SetupBossIds = { 510857 },
					ResetRoomZoom = true,
					UnlockDelay = 4.5,
					DelayedStart = true,
				},
			},
			{
				FunctionName = "CheckAssistHint",
				Args =
				{
					Delay = 10.0,
				}
			},
		},

		EnterVoiceLines =
		{
			{
				RequiredFalseTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
				PreLineWait = 2.25,

				-- Wow...
				{ Cue = "/VO/ZagreusField_2308" },
				-- Oh. Of course.
				{ Cue = "/VO/ZagreusField_2309", PreLineWait = 3.25, BreakIfPlayed = true },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				RequiredTextLines = { "AchillesRevealsGuanYuAspect01" },
				RequiredWeapon = "SpearWeapon",
				RequiredLastInteractedWeaponUpgrade = "SpearSpinTravel",
				PreLineWait = 2.25,
				-- Well, Guan Yu...? Take good care of Varatha for me.
				{ Cue = "/VO/ZagreusField_3231", PreLineThreadedFunctionName = "LegendaryAspectPresentation", PreLineThreadedFunctionArgs = { WaitTime = 4.3, WeaponAnimation = "LegendaryAspectImage-GuanYu", AdditionalAnimation = "LegendaryAspectSnow" }, },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				RequiredTextLines = { "NyxRevealsArthurAspect01" },
				RequiredWeapon = "SwordWeapon",
				RequiredLastInteractedWeaponUpgrade = "SwordConsecrationTrait",
				PreLineWait = 2.25,
				-- We made it, Stygius. I hope this Arthur serves you well someday.
				{ Cue = "/VO/ZagreusField_3250", PreLineThreadedFunctionName = "LegendaryAspectPresentation", PreLineThreadedFunctionArgs = { WaitTime = 4.3, WeaponAnimation = "LegendaryAspectImage-Arthur", AdditionalAnimation = "LegendaryAspectSnow" }, },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				RequiredTextLines = { "ArtemisRevealsRamaAspect01" },
				RequiredWeapon = "BowWeapon",
				RequiredLastInteractedWeaponUpgrade = "BowBondTrait",
				PreLineWait = 2.25,
				-- We're here, Coronacht. May you serve Rama well... if you haven't already done so, I guess...
				{ Cue = "/VO/ZagreusField_3251", PreLineThreadedFunctionName = "LegendaryAspectPresentation", PreLineThreadedFunctionArgs = { WaitTime = 4.3, WeaponAnimation = "LegendaryAspectImage-Rama", AdditionalAnimation = "LegendaryAspectSnow" }, },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "BeowulfAspect",
				BreakIfPlayed = true,
				RequiredTextLines = { "ChaosRevealsBeowulfAspect01" },
				RequiredWeapon = "ShieldWeapon",
				RequiredLastInteractedWeaponUpgrade = "ShieldLoadAmmoTrait",
				PreLineWait = 2.25,
				-- Here we are, then, Aegis. This Beowulf will be most fortunate to have your protection.
				{ Cue = "/VO/ZagreusField_3691", PreLineThreadedFunctionName = "LegendaryAspectPresentation", PreLineThreadedFunctionArgs = { WaitTime = 4.3, WeaponAnimation = "LegendaryAspectImage-Beowulf", AdditionalAnimation = "LegendaryAspectSnow" }, },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "MalphonAspect",
				BreakIfPlayed = true,
				RequiredTextLines = { "MinotaurRevealsGilgameshAspect01" },
				RequiredWeapon = "FistWeapon",
				RequiredLastInteractedWeaponUpgrade = "FistDetonateTrait",
				PreLineWait = 2.25,
				-- All right, we made it, Malphon. Appreciate you lending me the might of Gilgamesh.
				{ Cue = "/VO/ZagreusField_4656", PreLineThreadedFunctionName = "LegendaryAspectPresentation", PreLineThreadedFunctionArgs = { WaitTime = 4.3, WeaponAnimation = "LegendaryAspectImage-Gilgamesh", AdditionalAnimation = "LegendaryAspectSnow" }, },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "LuciferAspect",
				BreakIfPlayed = true,
				RequiredTextLines = { "ZeusRevealsLuciferAspect01" },
				RequiredWeapon = "GunWeapon",
				RequiredLastInteractedWeaponUpgrade = "GunLoadedGrenadeTrait",
				PreLineWait = 2.25,
				-- Here's the surface, Exagryph. Maybe it's as rare a sight for that Lucifer as it is for me.
				{ Cue = "/VO/ZagreusField_3690", PreLineThreadedFunctionName = "LegendaryAspectPresentation", PreLineThreadedFunctionArgs = { WaitTime = 4.3, WeaponAnimation = "LegendaryAspectImage-Lucifer", AdditionalAnimation = "LegendaryAspectSnow" }, },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 4.35,
				PlayOnce = true,

				-- Haven't you had enough?
				{ Cue = "/VO/ZagreusField_4516", RequiredTextLines = { "PersephoneMeeting06" }, RequiredFalseTextLines = { "Ending01" }, },
				-- You still don't understand...
				{ Cue = "/VO/ZagreusField_4519", RequiredTextLines = { "PersephoneMeeting09" }, RequiredFalseTextLines = { "Ending01" }, },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 4.35,
				SuccessiveChanceToPlayAll = 0.65,
				RequiredFalseEncounters = { "BossHadesPeaceful" },

				-- Father.
				{ Cue = "/VO/ZagreusField_2167", PreLineWait = 5.0 },
				-- Nice night, no?
				{ Cue = "/VO/ZagreusField_2168", PreLineWait = 5.0, RequiredKills = { Hades = 5 }, },
				-- I guess there's only one thing left to do. Isn't that so, Father?
				{ Cue = "/VO/ZagreusField_2169", RequiredFalseTextLines = { "Ending01" }, },
				-- I don't think I'll ever get accustomed to the breeze.
				{ Cue = "/VO/ZagreusField_2170" },
				-- Crisp, cold air.
				{ Cue = "/VO/ZagreusField_2171" },
				-- One last bit of business to take care of, then.
				{ Cue = "/VO/ZagreusField_2172" },
				-- I'm back, Father.
				{ Cue = "/VO/ZagreusField_4507", PreLineWait = 5.0 },
				-- Been waiting long?
				{ Cue = "/VO/ZagreusField_4508", PreLineWait = 5.0 },
				-- Every blasted time.
				{ Cue = "/VO/ZagreusField_4509", RequiredFalseTextLines = { "Ending01" }, },
				-- Out of my damn way.
				{ Cue = "/VO/ZagreusField_4510", RequiredFalseTextLines = { "Ending01" }, PreLineWait = 5.0 },
				-- I'm here, Father. Come on.
				{ Cue = "/VO/ZagreusField_4511", PreLineWait = 5.0 },
				-- You're not going to stop me.
				{ Cue = "/VO/ZagreusField_4512", RequiredFalseTextLines = { "Ending01" }, PreLineWait = 5.0 },
				-- ...I'll just keep coming back...
				{ Cue = "/VO/ZagreusField_4513", RequiredFalseTextLines = { "Ending01" }, PreLineWait = 5.0 },
				-- You're never late, Father.
				{ Cue = "/VO/ZagreusField_4514", PreLineWait = 5.0 },
				-- It's kind of nice out here.
				{ Cue = "/VO/ZagreusField_4515", RequiredTextLines = { "Ending01" }, },
				-- <Deep Breath>
				{ Cue = "/VO/ZagreusField_4517" },
				-- All right... this is it...
				{ Cue = "/VO/ZagreusField_4518" },
				-- Looks like the realm needs some adjustments still!
				{ Cue = "/VO/ZagreusField_4521", RequiredTextLines = { "Ending01" }, },
				-- Got here as quickly as I could.
				{ Cue = "/VO/ZagreusField_4522", RequiredTextLines = { "Ending01" }, RequiredGodLoot = "HermesUpgrade", },
				-- Hate to keep you from your parchmentwork.
				{ Cue = "/VO/ZagreusField_4523", RequiredTextLines = { "Ending01" }, },
				-- Oh hi, Father!
				{ Cue = "/VO/ZagreusField_4524", RequiredTextLines = { "Ending01" }, PreLineWait = 5.0 },
				-- You're looking very stately, there, Father.
				{ Cue = "/VO/ZagreusField_4525", RequiredTextLines = { "Ending01" }, RequiredTextLines = { "HadesGift05" }, PreLineWait = 5.0 },
				-- You ready for another go?
				{ Cue = "/VO/ZagreusField_4526", RequiredTextLines = { "Ending01" }, PreLineWait = 5.0 },
				-- Think you can beat me this time, Father?
				{ Cue = "/VO/ZagreusField_4527", RequiredTextLines = { "Ending01" }, ConsecutiveClearsOfRoom = { Name = "D_Boss01", Count = 2 }, PreLineWait = 5.0 },
				-- I'm going to get you back for last time, you know.
				{ Cue = "/VO/ZagreusField_4528", RequiredTextLines = { "Ending01" }, ConsecutiveDeathsInRoom = { Name = "D_Boss01", Count = 1, }, PreLineWait = 5.0 }, 
				-- Still chilly out here thanks to Grandmother...
				{ Cue = "/VO/ZagreusField_4529", RequiredTextLines = { "DemeterLiftsWinterCurse01" }, },
			},
		},

		Ambience = "/Leftovers/Ambience/OceanWavesWaterAmbience",
		IgnoreMusic = true,

		NextRoomSet = { "Surface" },

		ExitFunctionName = "CheckRunEndPresentation",
	},

	D_Intro =
	{
		InheritFrom = { "BaseStyx" },
		RichPresence = "#RichPresence_StyxHub",
		NumExits = 1,
		LegalEncounters = { "Empty" },
		IntroSequenceDuration = 0.3,
		ZoomFraction = 0.85,
		LinkedRoom = "D_Hub",

		GameStateRequirements =
		{
			-- None
		},

		RushMaxRangeOverride = 250,

		NoReward = true,
		NoReroll = true,
		HideRewardPreview = true,
		SkipLastKillPresentation = true,
		TimerBlock = "IntroRoom",
		RemoveTimerBlock = "InterBiome",
		EntranceDirection = "Right",

		ForceAtBiomeDepthMin = 0,
		ForceAtBiomeDepthMax = 1,
		MaxAppearancesThisBiome = 1,
		FlipHorizontalChance = 0.0,

		ThreadedEvents =
		{
			{ FunctionName = "DisplayLocationText", Args = { Text = "Location_Styx" } },
			{ FunctionName = "CheckLocationUnlock", Args = { Biome = "Styx" } },
		},

		-- Room Audio Below This Line
		MusicActiveStems = { "Guitar", },
		MusicMutedStems = { "Bass", "Drums" },
		PlayBiomeMusic = true,
		MusicStartDelay = 1.75,
		MusicSection = 0,

		EnterVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 2.65,
			SuccessiveChanceToPlayAll = 0.5,

			-- Ground floor...
			{ Cue = "/VO/ZagreusField_2257" },
			-- The Temple of Styx...
			{ Cue = "/VO/ZagreusField_2046", RequiredPlayed = { "/VO/ZagreusField_2257" } },
			-- What's with the air up here.
			{ Cue = "/VO/ZagreusField_2047", RequiredPlayed = { "/VO/ZagreusField_2257" } },
			-- The edge of Father's realm.
			{ Cue = "/VO/ZagreusField_2048", RequiredPlayed = { "/VO/ZagreusField_2257" } },
			-- The Temple...
			{ Cue = "/VO/ZagreusField_2049", RequiredPlayed = { "/VO/ZagreusField_2257" } },
			-- The Underworld's entryway...
			{ Cue = "/VO/ZagreusField_2050", RequiredPlayed = { "/VO/ZagreusField_2257" } },
			-- I've reached the surface...
			{ Cue = "/VO/ZagreusField_2051", RequiredPlayed = { "/VO/ZagreusField_2257" } },
			-- Hope it's nicer outside than it is in here.
			{ Cue = "/VO/ZagreusField_2052", RequiredPlayed = { "/VO/ZagreusField_2257" } },
			-- I'm sure the Satyrs are back...
			{ Cue = "/VO/ZagreusField_4254", RequiredPlayed = { "/VO/ZagreusField_2257" }, RequiredKills = { SatyrRanged = 3 }, },
			-- Almost out of here...
			{ Cue = "/VO/ZagreusField_4255", RequiredPlayed = { "/VO/ZagreusField_2257" } },
			-- Watch out, vermin...
			{ Cue = "/VO/ZagreusField_4256", RequiredPlayed = { "/VO/ZagreusField_2257" }, RequiredKills = { RatThug = 3 }, },
			-- No more dead to deal with at least.
			{ Cue = "/VO/ZagreusField_4257", RequiredPlayed = { "/VO/ZagreusField_2257" }, RequiredSeenRooms = { "D_Boss01" }, },
			-- Just got to get through Cerberus up there.
			{ Cue = "/VO/ZagreusField_4258", RequiredPlayed = { "/VO/ZagreusField_2257" }, RequiredSeenRooms = { "D_Boss01" }, },
			-- Gods grant me a swift Satyr sack.
			{ Cue = "/VO/ZagreusField_4259", RequiredPlayed = { "/VO/ZagreusField_2257" }, RequiredSeenRooms = { "D_Boss01" }, RequiredMinTimesSeenRoom = { D_Boss01 = 5 }, },
		},

		InspectPoints =
		{
			[543193] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_D_Intro_01_01 =
					{
						-- We'll see about that.
						EndCue = "/VO/ZagreusField_2251",
						EndWait = 0.45,
						{ Cue = "/VO/Storyteller_0246",
							Text = "{#DialogueItalicFormat}At last the willful prince has ventured all the way up to the surface of the mortal realm, yet still he is encased within the earth itself: the gateway to the Underworld, a threshold from which there is no escape." },
					},
				},
			},
		},
	},

	D_Hub =
	{
		InheritFrom = { "BaseStyx" },
		RichPresence = "#RichPresence_StyxHub",
		NumExits = 7,
		LegalEncounters = { "Shop" },
		ForcedReward = "Shop",
		StoreDataName = "D_WorldShop",
		IntroSequenceDuration = 0.95,
		ZoomFraction = 0.75,
		ZoomFractionSwitch = 0.90,
		PersistentStore = true,
		PersistentFishing = true,
		PersistentExitDoorRewards = true,
		BlockCameraReattach = true,

		EntranceFunctionName = "RoomEntranceD_Hub",

		GameStateRequirements =
		{
			-- None
		},

		Binks =
		{
			"CharonIdleShop_Bink",
			"CharonIdleGreeting_Bink",
			"Cerberus_HubIdle_Bink",
		},

		HideRewardPreview = true,
		NoReroll = true,
		SkipLastKillPresentation = true,
		--EntranceDirection = "Right",
		CloseDoorsOnUse = true,

		FirstAppearanceNumExitOverrides = 2,

		ForceAtBiomeDepthMin = 2,
		ForceAtBiomeDepthMax = 2,
		MaxAppearancesThisBiome = 1,
		FlipHorizontalChance = 0.0,

		FishingPointChance = 0.30,
		FishingPointRequirements =
		{
			RequiredCosmetics = { "FishingUnlockItem" },
			RequiredMinRoomsSinceFishingPoint = 1,
		},

		-- Room Audio
		IgnoreStemMixer = true,
		MusicActiveStems = { "Guitar", },
		MusicMutedStems = { "Bass", "Drums" },
		MusicSection = 0,
		Ambience = "/Leftovers/Ambience/MatchSiteIPoolAmbience",

		RewardOverrides =
		{
			ValidRewardNames = { "RoomRewardMetaPointDrop", "RoomRewardMetaPointDropRunProgress", },
			AddResources =
			{
				MetaPoints = 50,
			},
		},

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				GameStateRequirements =
				{
					RequiredFalseTextLines = { "CerberusStyxMeeting01" },
				},
				Args =
				{
					ProcessTextLinesIds = { 547487 },
					SkipBossMusic = true,
					DurationIn = 3.5,
					DurationOut = 3.5,
					UsePanSound = true,
				},
			},
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Cerberus_Field_01", WithinDistance = 1500,
				Stinger = "/VO/CerberusBarks",
				GameStateRequirements =
				{
					RequiredRoomThisRun = "D_Reprieve01",
				}
			},
			{
				TriggerObjectType = "NPC_Cerberus_Field_01", WithinDistance = 600,
				LeaveDistanceBuffer = 60,
				VoiceLines =
				{
					Cooldowns =
					{
						{ Name = "ApproachedCerberusSpeech", Time = 15 },
					},
					{
						UsePlayerSource = true,
						RandomRemaining = true,
						PlayOnceFromTableThisRun = true,
						RequiredFalseTextLinesThisRun = { "CerberusStyxMeeting01" },
						RequiredFalseSeenRoomThisRun = "D_Reprieve01",
						SuccessiveChanceToPlay = 0.33,

						-- Hey boy, just checking in.
						{ Cue = "/VO/ZagreusField_2150", RequiredMinDoorsClosedInRoom = 1, },
						-- Hey boy.
						{ Cue = "/VO/ZagreusField_2151" },
						-- Back on duty, huh.
						{ Cue = "/VO/ZagreusField_2152" },
						-- Father must have put you up to this.
						{ Cue = "/VO/ZagreusField_2153" },
						-- Working on getting you your treat still, boy.
						{ Cue = "/VO/ZagreusField_2154", RequiredMinDoorsClosedInRoom = 1, },
						-- Hey boy!
						{ Cue = "/VO/ZagreusField_2155" },
					},
					{
						UsePlayerSource = true,
						RandomRemaining = true,
						PlayOnceFromTableThisRun = true,
						RequiredRoomThisRun = "D_Reprieve01",
						SuccessiveChanceToPlay = 0.33,

						-- You must be hungry, huh.
						{ Cue = "/VO/ZagreusField_2156" },
						-- Want something to eat, boy? Huh?
						{ Cue = "/VO/ZagreusField_2320" },
						-- You hungry, Cerberus? I bet you are!
						{ Cue = "/VO/ZagreusField_2321" },
						-- One Satyr sack for one good boy.
						{ Cue = "/VO/ZagreusField_2069" },
						-- Got this delicious sack of meal for you, boy.
						{ Cue = "/VO/ZagreusField_2072" },
						-- Chow time, boy, you hungry?
						{ Cue = "/VO/ZagreusField_2073" },
					},
				},
			},
			{
				TriggerObjectType = "NPC_Charon_01", WithinDistance = 300,
				Repeat = true,
				LeaveDistanceBuffer = 60,
				VoiceLines =
				{
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						PreLineWait = 0.65,
						PlayOnceFromTableThisRun = true,
						UsePlayerSource = true,
						RequiredRoomMinValues = { StoreItemsPurchased = 6 },

						-- You're out of stock, Charon!
						{ Cue = "/VO/ZagreusField_4444" },
						-- What else you got, Charon?!
						{ Cue = "/VO/ZagreusField_4445" },
					}
				}
			},
			{
				TriggerObjectType = "NPC_Charon_01", WithinDistance = 600,
				LeaveDistanceBuffer = 60,
				VoiceLines =
				{
					{
						UsePlayerSource = true,
						RandomRemaining = true,
						PlayOnceFromTableThisRun = true,
						SuccessiveChanceToPlay = 0.2,
						RequireRoomMaxValues = { StoreItemsPurchased = 1 },

						-- That's quite a stash there, Charon!
						{ Cue = "/VO/ZagreusField_2145", CooldownName = "MentionedCharon", CooldownTime = 40, },
						-- Lots on offer here.
						{ Cue = "/VO/ZagreusField_2146" },
						-- Charon.
						{ Cue = "/VO/ZagreusField_2147", CooldownName = "MentionedCharon", CooldownTime = 40, },
						-- Something I can use?
						{ Cue = "/VO/ZagreusField_2148" },
						-- Should stock up for the road ahead.
						{ Cue = "/VO/ZagreusField_2149" },
					},
				},
			},
			{
				TriggerObjectType = "TravelDoor03", WithinDistance = 360,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},

		EnterVoiceLines =
		{
			-- when you return to the Hub with the key item
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.35,
				PlayOnceFromTableThisRun = true,
				RequiredRoomThisRun = "D_Reprieve01",
				SuccessiveChanceToPlay = 0.33,

				-- Now for a chat with Cerberus.
				{ Cue = "/VO/ZagreusField_2060" },
				-- Oh, Cerberus!
				{ Cue = "/VO/ZagreusField_2061" },
				-- Time to deliver the goods.
				{ Cue = "/VO/ZagreusField_2062" },
				-- One Satyr sack coming right up!
				{ Cue = "/VO/ZagreusField_2074" },
			},
			-- when you return to the Hub with the Key item with Wings open
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.35,
				RequiredRoomThisRun = "D_Reprieve01",
				PlayOnceFromTableThisRun = true,
				SuccessiveChanceToPlayAll = 0.5,
				-- RequiredMinDoorsClosedInRoom = 1,
				RequiredMaxDoorsClosedInRoom = 4,

				-- I can leave, or explore more tunnels.
				{ Cue = "/VO/ZagreusField_2311" },
				-- Should I go fight some Satyrs, or get out of here?
				{ Cue = "/VO/ZagreusField_2083" },
				-- Maybe I should check the other passageways before I leave.
				{ Cue = "/VO/ZagreusField_2084" },
				-- Could check the other passageways before I go.
				{ Cue = "/VO/ZagreusField_2085" },
			},
			-- when you return to the Hub in the same run
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.35,
				RequiredRoomThisRun = "D_Hub",
				RequiredFalseSeenRoomThisRun = "D_Reprieve01",
				SuccessiveChanceToPlay = 0.25,

				-- I'm back, huh.
				{ Cue = "/VO/ZagreusField_2055" },
				-- Need to keep looking down those passageways.
				{ Cue = "/VO/ZagreusField_2056" },
				-- Got to find something for Cerberus.
				{ Cue = "/VO/ZagreusField_2057" },
				-- Got to keep searching.
				{ Cue = "/VO/ZagreusField_2058" },
				-- A moment's rest.
				{ Cue = "/VO/ZagreusField_2059", PreLineWait = 1.75 },
			},
			-- when you first enter the Hub
			{
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				RequiredFalseTextLines = { "CerberusStyxMeeting01" },

				-- Oh no. Not this.
				{ Cue = "/VO/ZagreusField_2053" },
			},
			-- subsequent first-time visits
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.45,
				PlayOnceFromTableThisRun = true,
				RequiredTextLines = { "CerberusStyxMeeting01" },
				RequiredFalseSeenRoomThisRun = "D_Hub",
				SuccessiveChanceToPlayAll = 0.33,

				-- Cerberus is back on duty. Got to find him something to eat.
				{ Cue = "/VO/ZagreusField_2312" },
				-- Time to feed the beast.
				{ Cue = "/VO/ZagreusField_2313" },
				-- There's Cerberus. Won't budge till I find him a treat.
				{ Cue = "/VO/ZagreusField_2314", RequiredTextLines = { "CerberusBossDoorUnlock01" } },
				-- Time to find old Cerberus a Satyr sack.
				{ Cue = "/VO/ZagreusField_2315" },
				-- Won't get out of here until I find something for Cerberus.
				{ Cue = "/VO/ZagreusField_2316" },
				-- Cerberus guarding the gates as always.
				{ Cue = "/VO/ZagreusField_2317" },
				-- Time to clear some Satyr tunnels and get out of here.
				{ Cue = "/VO/ZagreusField_2318" },
				-- Now to get Cerberus to step aside.
				{ Cue = "/VO/ZagreusField_2319" },
			},
		},

		InspectPoints =
		{
			[551566] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseTextLinesThisRun = { "CerberusStyxMeeting01", "Inspect_D_Hub_02", "Inspect_D_Hub_03" },
				InteractTextLineSets =
				{
					-- statue in front
					Inspect_D_Hub_01 =
					{
						-- I've almost made it...
						EndCue = "/VO/ZagreusField_2252",
						EndWait = 0.5,
						{ Cue = "/VO/Storyteller_0247",
							Text = "{#DialogueItalicFormat}The vast Temple of Styx and its innumerable dangers now are all that separate the Underworld Prince from the land outside, which he so desperately longs to see." },
					},
				},
			},
			[551563] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTextLines = { "Inspect_D_Hub_01" },
				RequiredMinRunsCleared = 1,
				InteractTextLineSets =
				{
					-- mega shop
					Inspect_D_Hub_02 =
					{
						-- Generous selection of his wares.
						EndCue = "/VO/ZagreusField_2253",
						EndWait = 0.5,
						{ Cue = "/VO/Storyteller_0248",
							Text = "{#DialogueItalicFormat}Not far from here, the dead begin their journey to their final resting-place down in the depths below; and so the river-boatman Charon often passes through." },
					},
				},
			},
			[551565] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTextLines = { "CerberusBossDoorUnlock01", "Inspect_D_Hub_01" },
				RequiredFalseTextLinesThisRun = { "Inspect_D_Hub_01", "Inspect_D_Hub_03" },
				InteractTextLineSets =
				{
					-- near cerberus
					Inspect_D_Hub_03 =
					{
						-- He loves to eat. Can you blame him?
						EndCue = "/VO/ZagreusField_2254",
						EndWait = 0.5,
						{ Cue = "/VO/Storyteller_0249",
							Text = "{#DialogueItalicFormat}The widely-feared and many-headed Cerberus, the Underworld's sentinel, presides over the entrance to this realm, devouring whole those fool enough to make attempts to flee." },
					},
				},
			},
			[551564] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredSeenRooms = { "D_Reprieve01" },
				RequiredKills = { SatyrRangedMiniboss = 1, RatThugMiniboss = 1 },
				RequiredFalseTextLinesThisRun = { "Inspect_D_Hub_01", "Inspect_D_Hub_02", "Inspect_D_Hub_03" },
				InteractTextLineSets =
				{
					-- near wings
					Inspect_D_Hub_04 =
					{
						-- Satyr markings...
						EndCue = "/VO/ZagreusField_2255",
						EndWait = 0.5,
						{ Cue = "/VO/Storyteller_0250",
							Text = "{#DialogueItalicFormat}A crudely-hewn network of tunnels grows from one of the cold Temple's flanks, containing vicious denizens unwelcome in this realm, even in death." },
					},
				},
			},
		},
	},
}

OverwriteTableKeys( RoomData, RoomSetData.Styx )