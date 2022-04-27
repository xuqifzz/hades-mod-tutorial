RoomSetData.Elysium =
{
	BaseElysium =
	{
		DebugOnly = true,

		LegalEncounters = EncounterSets.ElysiumEncountersDefault,
		DevotionEncounters = {"DevotionTestElysium"},
		LocationText = "Location_Elysium",
		LocationTextShort = "Location_Elysium_Short",
		ResultText = "RunHistoryScreenResult_Elysium",
		RichPresence = "#RichPresence_Elysium",
		TargetMetaRewardsRatio = 0.33,
		SecretSpawnChance = 0.05,
		SecretDoorRequirements =
		{
			RequiredTextLines = { "HermesFirstPickUp" },
			-- run rollout prereqs
			RequiredFalseTextLinesThisRun = { "HermesFirstPickUp", "SisyphusFirstMeeting", "EurydiceFirstMeeting01_A", "EurydiceFirstMeeting01_B", "EurydiceFirstMeeting01_C", "PatroclusFirstMeeting", "ThanatosFirstAppearance" },
			RequiredMinRoomsSinceSecretDoor = 8,
		},
		ShrinePointDoorCost = 15,
		ShrinePointDoorSpawnChance = 0.15,
		ShrinePointDoorRequirements =
		{
			RequiredScreenViewed = "ShrineUpgrade",
			RequiredMinRoomsSinceShrinePointDoor = 8,
			RequiredCosmetics = { "ShrinePointGates", },
		},
		ChallengeSpawnChance = 0.30,
		ChallengeSwitchRequirements =
		{
			RequiredMinBiomeDepth = 2,
			RequiredMinRoomsSinceChallengeSwitch = 6,
		},
		WellShopSpawnChance = 0.35,
		WellShopRequirements =
		{
			RequiredMinCompletedRuns = 1,
			RequiredMinRoomsSinceWellShop = 3,
		},
		SellTraitShopChance = 0.15,
		SellTraitShopRequirements =
		{
			RequiredMinCompletedRuns = 1,
			RequiredUpgradeableGodTraits = 3,
			RequiredMinRoomsSinceSellTraitShop = 6,
			RequiredMinBiomeDepth = 4,
		},
		FishingPointChance = 0.1,
		FishingPointRequirements =
		{
			RequiredCosmetics = { "FishingUnlockItem" },
			RequiredMinRoomsSinceFishingPoint = 10,
		},
		StopSecretMusic = true,
		ShopSecretMusic = "/Music/CharonShopTheme",
		TrapOptions = EnemySets.TrapsBiome2,
		SwapSounds =
		{
			["/SFX/Player Sounds/FootstepsHardSurface"] = "/SFX/Player Sounds/FootstepsWheat2",
			["/SFX/Player Sounds/FootstepsHardSurfaceRun"] = "/SFX/Player Sounds/FootstepsWheatHeavy2",
		},
		MaxAppearancesThisBiome = 1,
		ZoomFraction = 0.95,
		SoftClamp = 0.75,
		BreakableOptions = { "BreakableElysiumIdle1", "BreakableElysiumIdle2", "BreakableElysiumIdle3" },
		BreakableValueOptions = { MaxHighValueBreakables = 3 },

		ChallengeEncounterName = "TimeChallengeElysium",
		WallSlamMultiplier = 2.0,
	},

	C_Combat01 =
	{
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 1,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "Right",
	},

	C_Combat02 =
	{
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "Right",
	},

	C_Combat03 =
	{
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 3,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "Left",
	},

	C_Combat04 =
	{
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 1,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "LeftRight",
		RushMaxRangeOverride = 510, -- for the top gap
	},

	C_Combat05 =
	{
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 1,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "LeftRight",
		RushMaxRangeOverride = 450,
	},

	C_Combat06 =
	{
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "Right",
		RushMaxRangeOverride = 510,
	},

	C_Combat07 =
	{
		DebugOnly = true,
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "Left",
	},

	C_Combat08 =
	{
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "Left",
	},

	C_Combat09 =
	{
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "Right",
	},

	C_Combat10 =
	{
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "Right",
		IneligibleRewards = { "Devotion" },
	},

	C_Combat11 =
	{
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "Right",

		RushMaxRangeOverride = 450,
	},

	C_Combat12 =
	{
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "Right",
	},

	C_Combat13 =
	{
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "Left",
	},

	C_Combat14 =
	{
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "Left",
		RushMaxRangeOverride = 450,
	},

	C_Combat15 =
	{
		DebugOnly = true,
		InheritFrom = { "BaseElysium", "RandomizeTrapTypes" },

		GameStateRequirements =
		{
			-- None
		},

		NumExits = 2,
		ZoomFraction = 0.80,
		ZoomFractionSwitch = 0.85,
		EntranceDirection = "Left",
	},

	C_PreBoss01 =
	{
		InheritFrom = { "BaseElysium" },

		NumExits = 1,
		EntranceDirection = "LeftRight",
		ZoomFraction = 0.92,

		LinkedRoom = "C_Boss01",
		ForceAtBiomeDepthMin = 9,
		ForceAtBiomeDepthMax = 9,
		ExitAmbience = "/Ambience/TheseusCrowdAmbientLoop",

		GameStateRequirements =
		{
			-- None
		},

		Binks =
		{
			"CharonIdleShop_Bink",
			"CharonIdleGreeting_Bink",
		},

		LegalEncounters = { "Shop" },
		ForcedFirstReward = "Shop",
		ForcedRewardStore = "RunProgress",
		IneligibleRewards = { "Devotion", "RoomRewardMoneyDrop", },
		SpawnRewardOnId = 543253,
		FlipHorizontalChance = 0.0,

		DisableRewardMagnetisim = true,

		InspectPoints =
		{
			[390000] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_C_PreBoss_01_01 =
					{
						-- Cheers for the vote of confidence, old man.
						EndCue = "/VO/ZagreusField_1658",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0226",
							Text = "{#DialogueItalicFormat}The magnificently ominous facade of the great Elysian Stadium looms tall above the rabble-rousing Prince, as if to goad him into such a competition which he cannot hope to win." },
					},
				},
			},
		},
	},

	C_Boss01 =
	{
		InheritFrom = { "BaseElysium" },
		RewardPreviewIcon = "RoomElitePreview4",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",
		ResultText = "RunHistoryScreenResult_C_Boss01",
		RichPresence = "#RichPresence_CBoss01",

		GameStateRequirements =
		{
			-- None
		},

		RequiresLinked = true,
		LinkedRoom = "C_PostBoss01",
		Milestone = true,
		MilestoneIcon = "BossIcon",
		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		Ambience = "/Ambience/TheseusCrowdAmbientLoop",
		LegalEncounters = { "BossTheseusAndMinotaur", },
		FirstClearRewardStore = "SuperMetaProgress",
		ForcedRewardStore = "MetaProgress",
		EligibleRewards = { "RoomRewardMetaPointDrop", "RoomRewardMetaPointDropRunProgress", "SuperGiftDrop" },
		NoReroll = true,
		RewardConsumableOverrides =
		{
			ValidRewardNames = { "RoomRewardMetaPointDrop", "RoomRewardMetaPointDropRunProgress", },
			AddResources =
			{
				MetaPoints = 150,
			},
		},
		EntranceDirection = "Right",
		BlockRunProgressUI = true,
		BlockTreasureImps = true,
		ZoomFraction = 0.875,
		NumExits = 1,
		SkipLastKillPresentation = true,
		LogShrineClears = true,

		FlipHorizontalChance = 0.0,

		EntranceFunctionName = "RoomEntranceBoss",
		IntroSequenceDuration = 2.7,
		BlockCameraReattach = true,

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntroElysium",
				Args =
				{
					[0] =
					{
						ProcessTextLinesIds = { 481705 },
						SetupBossIds = { 481705, 481706 },
					},
					[1] =
					{
						ProcessTextLinesIds = { 481705 },
						SetupBossIds = { 481705, 481706 },
					},
					[2] =
					{
						ProcessTextLinesIds = { 481705 },
						SetupBossIds = { 481705, 481706 },
					},
					[3] =
					{
						ProcessTextLinesIds = { 543036 },
						SetupBossIds = { 543036, 543035 },
					},
					[4] =
					{
						ProcessTextLinesIds = { 543036 },
						SetupBossIds = { 543036, 543035 },
					}
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
		ShrineMetaUpgradeName = "BossDifficultyShrineUpgrade",

		EnterVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				RequiredActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },

				-- ...This has to be some kind of bad dream.
				{ Cue = "/VO/ZagreusField_2749", PlayOnce = true },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.4,
				ChanceToPlayAgain = 0.05,
				RequiredActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
				ObjectType = "Theseus2",

				-- Brothers in Death!!
				{ Cue = "/VO/Theseus_0394" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.35,
				SuccessiveChanceToPlayAll = 0.33,

				-- Oh wow...
				{ Cue = "/VO/ZagreusField_1616", SuccessiveChanceToPlay = 0.01, },
				-- Gentlemen.
				{ Cue = "/VO/ZagreusField_1617", RequiredPlayed = { "/VO/ZagreusField_1616" } },
				-- Gentlemen?
				{ Cue = "/VO/ZagreusField_1618", RequiredPlayed = { "/VO/ZagreusField_1616" } },
				-- Rematch?
				{ Cue = "/VO/ZagreusField_1619", RequiredPlayed = { "/VO/ZagreusField_1616" } },
				-- Care for a rematch?
				{ Cue = "/VO/ZagreusField_1620", RequiredPlayed = { "/VO/ZagreusField_1616" } },
				-- Gentlemen, I'm back.
				{ Cue = "/VO/ZagreusField_1621", RequiredPlayed = { "/VO/ZagreusField_1616" } },
				-- These two.
				{ Cue = "/VO/ZagreusField_1622", RequiredPlayed = { "/VO/ZagreusField_1616" } },
				-- Time for the main event.
				{ Cue = "/VO/ZagreusField_1613", RequiredPlayed = { "/VO/ZagreusField_1616" } },
				-- Big crowd, huh.
				{ Cue = "/VO/ZagreusField_1614", RequiredPlayed = { "/VO/ZagreusField_1616" } },
				-- Hey everyone, I'm back!
				{ Cue = "/VO/ZagreusField_1615", RequiredPlayed = { "/VO/ZagreusField_1616" } },
				-- Asterius. Theseus.
				{ Cue = "/VO/ZagreusField_3887", RequiredPlayed = { "/VO/ZagreusField_1616" } },
				-- Asterius. Other guy.
				{ Cue = "/VO/ZagreusField_3888", RequiredPlayed = { "/VO/ZagreusField_1616", "/VO/ZagreusField_3887" } },
				-- Rematch?
				{ Cue = "/VO/ZagreusField_3889", RequiredPlayed = { "/VO/ZagreusField_1616" } },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.1,
				SuccessiveChanceToPlayAll = 0.33,
				ObjectType = "Theseus",
				RequiredFalseFlags = { "HeroesMuted" },

				-- You!
				{ Cue = "/VO/Theseus_0456" },
				-- You again!
				{ Cue = "/VO/Theseus_0457" },
				-- A challenger!
				{ Cue = "/VO/Theseus_0458" },
				-- A challenger?
				{ Cue = "/VO/Theseus_0459" },
				-- Ah, at last!
				{ Cue = "/VO/Theseus_0460" },
				-- He returns!
				{ Cue = "/VO/Theseus_0461" },
				-- Our sworn enemy!
				{ Cue = "/VO/Theseus_0462" },
				-- So...!
				{ Cue = "/VO/Theseus_0463" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.1,
				SuccessiveChanceToPlayAll = 0.33,
				ObjectType = "Theseus2",
				RequiredFalseFlags = { "HeroesMuted" },

				-- You!
				{ Cue = "/VO/Theseus_0456" },
				-- You again!
				{ Cue = "/VO/Theseus_0457" },
				-- A challenger!
				{ Cue = "/VO/Theseus_0458" },
				-- A challenger?
				{ Cue = "/VO/Theseus_0459" },
				-- Ah, at last!
				{ Cue = "/VO/Theseus_0460" },
				-- He returns!
				{ Cue = "/VO/Theseus_0461" },
				-- Our sworn enemy!
				{ Cue = "/VO/Theseus_0462" },
				-- So...!
				{ Cue = "/VO/Theseus_0463" },
			},
		},

		ObstacleData =
		{

			[543381] = {
				Template = "ElysiumPillar05",
				OnHitShake = { Distance = 6, Speed = 300, Duration = 0.15, RequireAttackerNames = { "Minotaur", "Minotaur2" }, },
				OnHitCrowdReaction =
				{
					RequireAttackerNames = { "Minotaur", "Minotaur2" },
					AnimationName = "StatusIconFear",
					ReactionChance = 0.55,
					Shake = true,
					Ids = { 543657, 543654, 543653, 543655, 543656, 543658, 543664, 543665, 543666, 543663, 543659, 543660, 543662, 543668, 543669, 543661, },
					Cooldown = 8.0,
				},
			},
			[543290] = {
				Template = "ElysiumPillar05",
				OnHitShake = { Distance = 6, Speed = 300, Duration = 0.15, RequireAttackerNames = { "Minotaur", "Minotaur2" }, },
				OnHitCrowdReaction =
				{
					RequireAttackerNames = { "Minotaur", "Minotaur2" },
					AnimationName = "StatusIconFear",
					ReactionChance = 0.55,
					Shake = true,
					Ids = { 543680, 543387, 543388, 543389, 543390, 543391, 543392, 543393, 543394, 543614, 543615, 543616, 543617, 543618, 543619, },
					Cooldown = 8.0,
				},
			},
			-- Diehard Fan
			[543023] =
			{
				Name = "DieHardFanShade",
				EmoteOffsetZ = 10,
				DistanceTriggers =
				{
					{
						WithinDistance = 450,
						Emote = "StatusIconSmile",
						TriggerOnceThisRun = true,
					},
					{
						Repeat = true,
						WithinDistance = 400,
						VoiceLines =
						{
							BreakIfPlayed = true,
							RandomRemaining = true,
							UsePlayerSource = true,
							RequiredSeenRooms = { "D_Hub" },
							PlayOnceFromTableThisRun = true,
							RequiredKillEnemiesNotFound = true,

							-- Thanks for believing in me, my good Shade!
							{ Cue = "/VO/ZagreusField_3024", RequiredPlayed = { "/VO/ZagreusField_3026" },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.5, Groups = { "SupportiveShade" }, }
							 },
							-- I dedicate this victory to you, good Shade!
							{ Cue = "/VO/ZagreusField_3025", RequiredPlayed = { "/VO/ZagreusField_3026" },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.5, Groups = { "SupportiveShade" }, }
							 },
							-- That shade there, have I got a fan?
							{ Cue = "/VO/ZagreusField_3026", PlayOnce =  true,
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.5, Groups = { "SupportiveShade" }, }
							},
							-- Hello, supportive Shade!
							{ Cue = "/VO/ZagreusField_3027", RequiredPlayed = { "/VO/ZagreusField_3026" },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.25, Groups = { "SupportiveShade" }, }
							},
							-- I won again, Shade, thanks to your support!
							{ Cue = "/VO/ZagreusField_3028", RequiredPlayed = { "/VO/ZagreusField_3026" },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.5, Groups = { "SupportiveShade" }, }
							},
							-- You are my biggest fan!
							{ Cue = "/VO/ZagreusField_3341", RequiredPlayed = { "/VO/ZagreusField_3026" },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.2, Groups = { "SupportiveShade" }, }
							 },
							-- To my greatest fan!
							{ Cue = "/VO/ZagreusField_3342", RequiredPlayed = { "/VO/ZagreusField_3026" },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1, Groups = { "SupportiveShade" }, }

							},
							-- There's my Shade!
							{ Cue = "/VO/ZagreusField_3343", RequiredPlayed = { "/VO/ZagreusField_3026" },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1, Groups = { "SupportiveShade" }, }
							},
							-- That was for you, good Shade!
							{ Cue = "/VO/ZagreusField_3344", RequiredPlayed = { "/VO/ZagreusField_3026" },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.5, Groups = { "SupportiveShade" }, }
							},
							-- Hope you enjoyed the show, my good Shade!
							{ Cue = "/VO/ZagreusField_3345", RequiredPlayed = { "/VO/ZagreusField_3026" },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.5, Groups = { "SupportiveShade" }, }
							},
							-- Thank you for your support, my Shade!
							{ Cue = "/VO/ZagreusField_3346", RequiredPlayed = { "/VO/ZagreusField_3026" },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.5, Groups = { "SupportiveShade" }, }
							},
							-- We got them, my good Shade!
							{ Cue = "/VO/ZagreusField_3347", RequiredPlayed = { "/VO/ZagreusField_3026" },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.5, Groups = { "SupportiveShade" }, }
							},
							-- Showed them who's boss, didn't we, Shade?
							{ Cue = "/VO/ZagreusField_3348", RequiredPlayed = { "/VO/ZagreusField_3026" },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.5, Groups = { "SupportiveShade" }, }
							},
							-- Got them again, my Shade!
							{ Cue = "/VO/ZagreusField_3349", RequiredPlayed = { "/VO/ZagreusField_3026" }, ConsecutiveClearsOfRoom = { Name = "C_Boss01", Count = 2, },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.5, Groups = { "SupportiveShade" }, }
							},
							-- Was not about to let you down, my Shade!
							{ Cue = "/VO/ZagreusField_3350", RequiredPlayed = { "/VO/ZagreusField_3026" }, ConsecutiveClearsOfRoom = { Name = "C_Boss01", Count = 1, },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.5, Groups = { "SupportiveShade" }, }
							},
							-- Makes up for last time I hope, my good Shade?
							{ Cue = "/VO/ZagreusField_3351", RequiredPlayed = { "/VO/ZagreusField_3026" }, ConsecutiveDeathsInRoom = { Name = "C_Boss01", Count = 1, },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.5, Groups = { "SupportiveShade" }, }
							},
							-- Until next time, good Shade!
							{ Cue = "/VO/ZagreusField_3352", RequiredPlayed = { "/VO/ZagreusField_3026" },
								PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationName = "StatusIconSmile", ReactionChance = 1, Delay = 1.5, Groups = { "SupportiveShade" }, }
							},

						}
					},
				},
			},
		},

		MusicSection = 1,
		MusicActiveStems = { "Bass", "Drums" },
		MusicMutedStems = { "Guitar" },
		MusicStartDelay = 0.25,

		ExitVoiceLines =
		{
			PreLineWait = 0.35,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.33,

			-- Hope you enjoyed the show!
			{ Cue = "/VO/ZagreusField_4402", RequiredPlayed = { "/VO/ZagreusField_4407" }, },
			-- Should be another such performance soon!
			{ Cue = "/VO/ZagreusField_4403", RequiredPlayed = { "/VO/ZagreusField_4407" }, },
			-- Enjoy the rest of your existence, shades!
			{ Cue = "/VO/ZagreusField_4404", RequiredPlayed = { "/VO/ZagreusField_4407" }, },
			-- You shades enjoy yourselves!
			{ Cue = "/VO/ZagreusField_4405", RequiredPlayed = { "/VO/ZagreusField_4407" }, },
			-- Guess I'll be going, then!
			{ Cue = "/VO/ZagreusField_4406", RequiredPlayed = { "/VO/ZagreusField_4407" }, },
			-- I'll take the service exit, thanks!
			{ Cue = "/VO/ZagreusField_4407" },
			-- Happy to entertain you, shades!
			{ Cue = "/VO/ZagreusField_4408", RequiredPlayed = { "/VO/ZagreusField_4407" }, },
			-- Be seeing all of you next time, all right?
			{ Cue = "/VO/ZagreusField_4409", RequiredPlayed = { "/VO/ZagreusField_4407" }, },
		},
	},

	C_PostBoss01 =
	{
		InheritFrom = { "BaseElysium" },
		LegalEncounters = { "Empty" },
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,

		BreakableOptions = { "BreakableIdle1", "BreakableIdle2", "BreakableIdle3" },

		GameStateRequirements =
		{
			-- None
		},

		RequiresLinked = true,
		NextRoomSet = { "Styx" },
		RichPresence = "#RichPresence_PostBoss",
		IgnoreMusic = true,
		UseBiomeMap = true,
		BlockRunProgressUI = true,
		Ambience = "/Leftovers/Ambience/CreepyHauntedWindLoop",
		EntranceDirection = "Right",
		NoReward = true,
		NoReroll = true,
		ZoomFraction = 0.75,
		NumExits = 1,
		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 0.9,
		
		ExitPath = { 560034 },

		SkipLastKillPresentation = true,
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 1.0,
		SellTraitShopChance = 1.0,
		ForceWellShop = true,
		ForceSellTraitShop = true,
		WellShopRequirements =
		{
			-- None
		},
		SecretSpawnChance = 0.0,
		SellTraitShrineUpgrade = true,

		ObstacleData =
		{
			[486511] =
			{
				Template = "HealthFountain",
				Activate = true,
				ActivateIds = { 486607, },
				SetupGameStateRequirements =
				{

				},
			},
			[486504] =
			{
				Template = "GiftRack",
				Activate = true,
				ActivateIds = { 486371, },
				SetupGameStateRequirements =
				{
					RequiredCosmetics = { "PostBossGiftRack", },
				},
			},
		},

		ThreadedEvents =
		{
			{ FunctionName = "HadesSpeakingPresentation", Args = { VoiceLines = GlobalVoiceLines.HadesPostBossVoiceLines, StartDelay = 1 } },
			{ FunctionName = "ProcessInterest", Args = { StartDelay = 1 } },
		},
		EnterVoiceLines =
		{
		},
		ExitVoiceLines =
		{
			PreLineWait = 0.5,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlayAll = 0.66,

			-- One last stop.
			{ Cue = "/VO/ZagreusField_2258", RequiredPlayed = { "/VO/ZagreusField_2260" }, },
			-- One more stop.
			{ Cue = "/VO/ZagreusField_2259", RequiredPlayed = { "/VO/ZagreusField_2260" }, },
			-- I can do this. I can do this.
			{ Cue = "/VO/ZagreusField_2260", TriggerCooldowns = { Name = "ZagreusBountyEarnedConfirmationVoiceLines" }, RequiredFalseTextLines = { "Ending01" }, },
			-- So close.
			{ Cue = "/VO/ZagreusField_2261", RequiredPlayed = { "/VO/ZagreusField_2260" }, },
			-- To the surface.
			{ Cue = "/VO/ZagreusField_2262", RequiredPlayed = { "/VO/ZagreusField_2260" }, },
			-- That was Elysium.
			{ Cue = "/VO/ZagreusField_4410", RequiredPlayed = { "/VO/ZagreusField_2260" }, },
			-- Got through Elysium.
			{ Cue = "/VO/ZagreusField_4411", RequiredPlayed = { "/VO/ZagreusField_2260" }, },
			-- I'm out of here.
			{ Cue = "/VO/ZagreusField_4412", RequiredPlayed = { "/VO/ZagreusField_2260" }, },
			-- I'm almost to the top.
			{ Cue = "/VO/ZagreusField_4413", RequiredPlayed = { "/VO/ZagreusField_2260" }, },
			-- I'm almost out of here.
			{ Cue = "/VO/ZagreusField_4414", RequiredPlayed = { "/VO/ZagreusField_2260" }, },
			-- I can do this again.
			{ Cue = "/VO/ZagreusField_4415", RequiredMinRunsCleared = 1, RequiredPlayed = { "/VO/ZagreusField_2260" }, },
		},
	},

	C_MiniBoss01 =
	{
		InheritFrom = { "BaseElysium" },
		IsMiniBossRoom = true,
		RewardPreviewIcon = "RoomElitePreview2",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",
		ResultText = "RunHistoryScreenResult_C_MiniBoss01",
		RichPresence = "#RichPresence_CMiniBoss01",

		GameStateRequirements =
		{
			RequiredFalseSeenRoomsThisRun = { "C_MiniBoss02", "C_MiniBoss03" },
		},

		LegalEncounters = { "MiniBossMinotaur" },
		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 2.5,
		BlockCameraReattach = true,
		EntranceFunctionName = "RoomEntranceBoss",

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { LegendaryChance = 0.1, EpicChance = 0.25, RareChance = 0.90 },

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 7,
		MaxAppearancesThisBiome = 1,
		NumExits = 1,
		EntranceDirection = "Right",
		ZoomFraction = 0.85,
		SkipLastKillSound = true,

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntroElysium",
				Args =
				{
					[0] =
					{
						ProcessTextLinesIds = { 522244 },
						SetupBossIds = { 522244 },
					},
					[1] =
					{
						ProcessTextLinesIds = { 522244 },
						SetupBossIds = { 522244 },
					},
					[2] =
					{
						ProcessTextLinesIds = { 522244 },
						SetupBossIds = { 522244 },
					},
					[3] =
					{
						ProcessTextLinesIds = { 543191 },
						SetupBossIds = { 543191 },
					},
					[4] =
					{
						ProcessTextLinesIds = { 543191 },
						SetupBossIds = { 543191 },
					}
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
		ShrineMetaUpgradeName = "BossDifficultyShrineUpgrade",

		EnterVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.75,
				RequiredActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },

				-- ...Asterius, you look absolutely smashing!
				{ Cue = "/VO/ZagreusField_2819", PlayOnce = true },

				-- Oh this is trouble.
				-- { Cue = "/VO/ZagreusField_1611", PlayOnce = true },
			},
			-- Zagreus Greetings
			{
				PreLineWait = 1.0,
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				UsePlayerSource = true,

				-- Asterius!
				{ Cue = "/VO/ZagreusField_4677", RequiredPlayed = { "/VO/ZagreusField_4680" }, RequiredMinTimesSeenRoom = { C_MiniBoss01 = 5 }, },
				-- Asterius.
				{ Cue = "/VO/ZagreusField_4678", RequiredPlayed = { "/VO/ZagreusField_4680" }, RequiredMinTimesSeenRoom = { C_MiniBoss01 = 3 }, },
				-- Oh, hi.
				{ Cue = "/VO/ZagreusField_4679", RequiredPlayed = { "/VO/ZagreusField_4680" }, },
				-- The Bull of Minos!
				{ Cue = "/VO/ZagreusField_4680", PlayOnce = true },
				-- The Bull of Minos.
				{ Cue = "/VO/ZagreusField_4681", RequiredPlayed = { "/VO/ZagreusField_4680" }, },
				-- Rematch?
				{ Cue = "/VO/ZagreusField_4682", RequiredPlayed = { "/VO/ZagreusField_4680" }, RequiredMinTimesSeenRoom = { C_MiniBoss01 = 5 }, },
				-- Rematch, then?
				{ Cue = "/VO/ZagreusField_4683", RequiredPlayed = { "/VO/ZagreusField_4680" }, RequiredMinTimesSeenRoom = { C_MiniBoss01 = 6 }, },
				-- Shall we, sir?
				{ Cue = "/VO/ZagreusField_4684", RequiredPlayed = { "/VO/ZagreusField_4680" }, RequiredMinTimesSeenRoom = { C_MiniBoss01 = 10 }, },
			},			
			-- Minotaur Greetings
			{
				PreLineWait = 1.0,
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				ObjectType = "Minotaur",

				-- <Snort>
				{ Cue = "/VO/Minotaur_0325" },
				-- You.
				{ Cue = "/VO/Minotaur_0326", RequiredPlayed = { "/VO/Minotaur_0325" }, },
				-- Hrm.
				{ Cue = "/VO/Minotaur_0327", RequiredPlayed = { "/VO/Minotaur_0325" }, },
				-- Ah.
				{ Cue = "/VO/Minotaur_0328", RequiredPlayed = { "/VO/Minotaur_0325" }, },
				-- Good.
				{ Cue = "/VO/Minotaur_0329", RequiredPlayed = { "/VO/Minotaur_0325" }, },
				-- A challenger.
				{ Cue = "/VO/Minotaur_0330", RequiredPlayed = { "/VO/Minotaur_0325" }, },
				-- You again.
				{ Cue = "/VO/Minotaur_0331", RequiredPlayed = { "/VO/Minotaur_0325" }, },
				-- It's you.
				{ Cue = "/VO/Minotaur_0332", RequiredPlayed = { "/VO/Minotaur_0325" }, },
			},
			-- Minotaur Greetings
			{
				PreLineWait = 1.0,
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				ObjectType = "Minotaur2",

				-- <Snort>
				{ Cue = "/VO/Minotaur_0325" },
				-- You.
				{ Cue = "/VO/Minotaur_0326", RequiredPlayed = { "/VO/Minotaur_0325" }, },
				-- Hrm.
				{ Cue = "/VO/Minotaur_0327", RequiredPlayed = { "/VO/Minotaur_0325" }, },
				-- Ah.
				{ Cue = "/VO/Minotaur_0328", RequiredPlayed = { "/VO/Minotaur_0325" }, },
				-- Good.
				{ Cue = "/VO/Minotaur_0329", RequiredPlayed = { "/VO/Minotaur_0325" }, },
				-- A challenger.
				{ Cue = "/VO/Minotaur_0330", RequiredPlayed = { "/VO/Minotaur_0325" }, },
				-- You again.
				{ Cue = "/VO/Minotaur_0331", RequiredPlayed = { "/VO/Minotaur_0325" }, },
				-- It's you.
				{ Cue = "/VO/Minotaur_0332", RequiredPlayed = { "/VO/Minotaur_0325" }, },
			},
		},
	},

	C_MiniBoss02 =
	{
		InheritFrom = { "BaseElysium" },
		IsMiniBossRoom = true,
		RewardPreviewIcon = "RoomElitePreview2",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",
		ResultText = "RunHistoryScreenResult_C_MiniBoss02",

		GameStateRequirements =
		{
			RequiredFalseSeenRoomsThisRun = { "C_MiniBoss01", "C_MiniBoss03" },
		},

		LegalEncounters = { "MiniBossNakedSpawners" },

		SpawnOnIds = { 522359 },

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { LegendaryChance = 0.1, EpicChance = 0.25, RareChance = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 7,
		MaxAppearancesThisBiome = 1,
		NumExits = 1,
		EntranceDirection = "Right",
		ZoomFraction = 0.77,
		ZoomFractionSwitch = 0.85,

		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,

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

		CombatResolvedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.6,
			SuccessiveChanceToPlayAll = 0.66,
			ThreadName = "RoomThread",

			-- I'll keep my soul for now, thanks.
			{ Cue = "/VO/ZagreusField_1980", RequiredPlayed = { "/VO/ZagreusField_1975" } },
			-- Butterflies, eugh.
			{ Cue = "/VO/ZagreusField_1981" },
			-- Farewell for now, sinister ball of butterflies.
			{ Cue = "/VO/ZagreusField_1982" },
			-- Butterflies better stay away from me.
			{ Cue = "/VO/ZagreusField_1983" },
			-- Won't catch this soul, thanks.
			{ Cue = "/VO/ZagreusField_1984", RequiredPlayed = { "/VO/ZagreusField_1975" } },
		},
	},

	C_MiniBoss03 =
	{
		DebugOnly = true,
		InheritFrom = { "BaseElysium" },
		IsMiniBossRoom = true,
		RewardPreviewIcon = "RoomElitePreview2",
		RewardPreviewFx = "RoomRewardAvailableRareSparkles",
		ResultText = "RunHistoryScreenResult_C_MiniBoss03",

		GameStateRequirements =
		{
			RequiredFalseSeenRoomsThisRun = { "C_MiniBoss01", "C_MiniBoss02" },
			RequiredSeenEncounter = "BossTheseusAndMinotaur",
		},

		LegalEncounters = { "MiniBossShadeMagic" },

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { LegendaryChance = 0.1, EpicChance = 0.25, RareChance = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 7,
		MaxAppearancesThisBiome = 1,
		NumExits = 1,
		EntranceDirection = "Left",
		ZoomFraction = 0.85,

		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,

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

	C_Shop01 =
	{
		InheritFrom = { "BaseElysium" },
		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 3,
		ForceAtBiomeDepthMax = 6,
		LegalEncounters = { "Shop" },
		ForcedReward = "Shop",
		NoReroll = true,

		GameStateRequirements =
		{
			RequiredMaxBiomeDepth = 6,
			RequiredMinExits = 2,
		},

		Binks =
		{
			"CharonIdleShop_Bink",
			"CharonIdleGreeting_Bink",
		},

		SpawnRewardOnId = 410005,

		NumExits = 2,
		ZoomFraction = 0.92,

		EntranceDirection = "Right",

		Ambience = "/Leftovers/Object Ambiences/ShipwreckAmbience",
		-- SpawnRewardGlobalVoiceLines = "FoundShopVoiceLines",

		InspectPoints =
		{
			[390000] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_C_Shop_01_01 =
					{
						-- He really gets around.
						EndCue = "/VO/ZagreusField_1657",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0225",
							Text = "{#DialogueItalicFormat}The vast and multitudinous riches of both the surface and the Underworld are hoarded by the river-boatman, Charon, whose services are often tendered to the wealthiest within Elysium." },
					},
				},
			},
		},
	},

	C_Reprieve01 =
	{
		InheritFrom = { "BaseElysium" },
		IneligibleRewards = { "Devotion", },
		SuppressRewardSpawnSounds = true,
		MaxCreationsThisRun = 1,
		
		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
			RequiredCosmetics = { "ElysiumReprieve" },
		},

		LegalEncounters = { "HealthRestore" },
		EntranceDirection = "Left",

		NumExits = 1,
		SpawnRewardOnId = 410000,

		SecretMusic = "/Music/BlankMusicCue",
		Ambience = "/Leftovers/Ambience/StillWaterAmbience",

		EnterGlobalVoiceLines = "EnteredReprieveRoomVoiceLines",

		InspectPoints =
		{
			[532789] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_C_Reprieve_01_01 =
					{
						-- Is this really as good as it gets for mortalkind?
						EndCue = "/VO/ZagreusField_1656",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0224",
							Text = "{#DialogueItalicFormat}Within the delicately hewn constructions of Elysium exist places of peace so utterly serene and absolute as mortalkind is seldom to experience during the average short and often-painful coil." },
					},
				},
			},
		},
	},

	C_Story01 =
	{
		InheritFrom = { "BaseElysium" },
		ForcedReward = "Story",
		NoReroll = true,
		MaxCreationsThisRun = 1,
		RichPresence = "#RichPresence_CStory01",

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
			RequiredMinCompletedRuns = 1,
			RequiredSeenRooms = { "C_Boss01" },
			-- run rollout prereqs
			RequiredFalseTextLinesThisRun = { "HermesFirstPickUp", "SisyphusFirstMeeting", "EurydiceFirstMeeting01_A", "EurydiceFirstMeeting01_B", "EurydiceFirstMeeting01_C", "ThanatosFirstAppearance" },
		},

		SecretMusic = "/Music/MusicExploration3_MC",

		Ambience = "/Ambience/ElysiumAmbientLoop",
		ZoomFraction = 0.85,
		TimerBlock = "StoryRoom",

		FlipHorizontalChance = 0.0,
		LegalEncounters = { "Story_Patroclus_01" },
		EntranceDirection = "LeftRight",
		NumExits = 2,

		--RushMaxRangeOverride = 200,
		RushMaxRangeOverride = 450,

		EnterVoiceLines =
		{
			PreLineWait = 2.0,
			IsIdAlive = 563036,
			PlayOnce = true,

			-- Hey, that's Achilles, isn't it!
			{ Cue = "/VO/ZagreusField_3554", RequiredFalsePlayedThisRun = { "/VO/Achilles_0222" } },
		},

		InspectPoints =
		{
			[532753] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_C_Story_01_01 =
					{
						-- This place is near as gloomy as the House.
						EndCue = "/VO/ZagreusField_1659",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0227",
							Text = "{#DialogueItalicFormat}Amid Elysium's moss-covered chambers, carved of stone, stand untold numbers of eternal monuments in tribute to the greatest heroes which mortality can offer, there to honor them in life as well as death." },
					},
				},
			},
		},
	},

	C_Intro =
	{
		InheritFrom = { "BaseElysium" },
		NumExits = 2,
		LegalEncounters = { "Empty" },
		IntroSequenceDuration = 1.0,
		ZoomFraction = 0.75,

		NoReward = true,
		NoReroll = true,
		HideRewardPreview = true,
		SkipLastKillPresentation = true,
		TimerBlock = "IntroRoom",
		RemoveTimerBlock = "InterBiome",
		EntranceDirection = "Left",

		ForceAtBiomeDepthMin = 0,
		ForceAtBiomeDepthMax = 1,
		MaxAppearancesThisBiome = 1,
		FlipHorizontalChance = 0.0,

		GameStateRequirements =
		{
			-- None
		},

		ThreadedEvents =
		{
			{ FunctionName = "DisplayLocationText", Args = { Text = "Location_Elysium" } },
			{ FunctionName = "CheckLocationUnlock", Args = { Biome = "Elysium" } },
		},

		-- Room Audio Below This Line
		MusicActiveStems = { "Guitar", "Bass", "Drums" },
		MusicStartDelay = 1.75,
		MusicMutedStems = { "Drums" },
		PlayBiomeMusic = true,
		MusicSection = 0,

		EnterVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 2.65,
			SuccessiveChanceToPlayAll = 0.5,

			-- The Fields of Elysium...
			{ Cue = "/VO/ZagreusField_1595" },
			-- Elysium....
			{ Cue = "/VO/ZagreusField_1596", RequiredPlayed = { "/VO/ZagreusField_1595" } },
			-- Nice and cool up here.
			{ Cue = "/VO/ZagreusField_1597", RequiredPlayed = { "/VO/ZagreusField_1595" } },
			-- This what the outside world is like...?
			{ Cue = "/VO/ZagreusField_1598", RequiredPlayed = { "/VO/ZagreusField_1595" }, RequiredFalseTextLines = { "PersephoneFirstMeeting" }, },
			-- Champions of Elysium, I have returned.
			{ Cue = "/VO/ZagreusField_1599", RequiredPlayed = { "/VO/ZagreusField_1595" } },
			-- Another day or night in paradise.
			{ Cue = "/VO/ZagreusField_1600", RequiredPlayed = { "/VO/ZagreusField_1595" } },
			-- Much nicer climate.
			{ Cue = "/VO/ZagreusField_4248", RequiredPlayed = { "/VO/ZagreusField_1595" } },
			-- Everything's so green...
			{ Cue = "/VO/ZagreusField_4249", RequiredPlayed = { "/VO/ZagreusField_1595" } },
			-- Time to pick a fight...
			{ Cue = "/VO/ZagreusField_4250", RequiredPlayed = { "/VO/ZagreusField_1595" } },
			-- Let's kill some heroes, then.
			{ Cue = "/VO/ZagreusField_4251", RequiredPlayed = { "/VO/ZagreusField_1595" } },
			-- The dead must have it pretty good up here.
			{ Cue = "/VO/ZagreusField_4252", RequiredPlayed = { "/VO/ZagreusField_1595" } },
			-- Pleasant temperature.
			{ Cue = "/VO/ZagreusField_4253", RequiredPlayed = { "/VO/ZagreusField_1595" } },
		},

		MusicActiveStems = { "Guitar", "Bass", "Drums" },
		MusicStartDelay = 1.75,
		MusicMutedStems = { "Drums" },

		InspectPoints =
		{
			[532752] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_C_Intro_01 =
					{
						-- Luxuriantly? Really?
						EndCue = "/VO/ZagreusField_1654",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0222",
							Text = "{#DialogueItalicFormat}The rare, heavenly splendors of Elysium, reserved for only the most great of mortal souls, spread forth luxuriantly all about the fire-stepping Prince." },
					},
				},
			},
			[532753] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTextLines = { "Inspect_C_Intro_01", },
				InteractTextLineSets =
				{
					Inspect_C_Intro_02 =
					{
						-- I'll have to give them new pains to recall.
						EndCue = "/VO/ZagreusField_1655",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0223",
							Text = "{#DialogueItalicFormat}The enshrouded river of forgetfulness, Lethe, flows through the hallowed chambers of Elysium, numbing old pains and memories of the most-noble shades residing there." },
					},
				},
			},
		},

		DistanceTriggers =
		{
			-- Overlook
			{
				TriggerGroup = "OverlookOut", WithinDistance = 150, FunctionName = "BiomeOverlook", Repeat = true, Args = { PanTargetId = 543081 },
			},
			{
				TriggerGroup = "OverlookIn", WithinDistance = 150, FunctionName = "BiomeBackToRoom", Repeat = true,
			},
		},
	},
}

OverwriteTableKeys( RoomData, RoomSetData.Elysium )