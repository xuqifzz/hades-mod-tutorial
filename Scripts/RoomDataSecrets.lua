RoomSetData.Secrets =
{
	BaseSecret =
	{
		DebugOnly = true,

		EntranceFunctionName = "RoomEntrancePortal",
		NextRoomEntranceFunctionName = "RoomEntrancePortal",
		EntranceAnimation = "ZagreusDashEntrance",
		EntranceVfx = "ZagreusSecretDoorDiveFadeFx",
		ExitAnimation = "ZagreusSecretDoorExit",
		ExitVfx = "ZagreusSecretDoorDiveFadeFx",
		ExitDoorOpenAnimation = "ExitDoorLinesSpecial",
		ExitDoorCloseAnimation = "ExitDoorLinesSpecial",
		SkipLastKillPresentation = true,
		UsePromptOffsetY = 120,
		LocationText = "Location_Secret",
		ResultText = "RunHistoryScreenResult_Secret",
		RichPresence = "#RichPresence_Chaos",
		BiomeName = "Secrets",
		LocationTextColor = { 20, 0, 255, 255 },
		Ambience = "/Leftovers/Ambience/MountainAmbience",
		SecretMusic = "/Music/ChaosTheme_MC",
		SkipLeavePrevRoomSFX = true,
		UsePreviousRoomSet = true,
		BlockHeroLight = true,
		ForcedRewardStore = "Secrets",
		LegalEncounters = { "Secret" },
		ZoomFraction = 0.75,
		BreakableOptions = { "BreakableIdle1", "BreakableIdle2", "BreakableIdle3" },
		BreakableValueOptions = { MaxHighValueBreakables = 3 },
		SoftClamp = 0.75,
		FishingPointChance = 0.07,
		FishingPointRequirements =
		{
			RequiredCosmetics = { "FishingUnlockItem" },
			RequiredMinRoomsSinceFishingPoint = 5,
			RequiredAccumulatedMetaPoints = 1000,
		},
		EnterVoiceLines =
		{
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.34,
					NoTarget = true,
					RequiredTextLines = { "ChaosGift07" },
					SuccessiveChanceToPlay = 0.33,
					Source = { SubtitleColor = Color.ChaosVoice },
					RequiredUnitNotAlive = "NPC_Nyx_Story_01",
					PlayOnceFromTableThisRun = true,
					Cooldowns =
					{
						{ Name = "EnteredSecretRoomSpeech", Time = 20 },
					},

					-- Welcome.
					{ Cue = "/VO/Chaos_0199",  },
					-- Welcome back.
					{ Cue = "/VO/Chaos_0200",  },
					-- It is you.
					{ Cue = "/VO/Chaos_0201",  },
					-- You have returned.
					{ Cue = "/VO/Chaos_0202",  },
					-- You have arrived.
					{ Cue = "/VO/Chaos_0203",  },
					-- You are back.
					{ Cue = "/VO/Chaos_0204",  },
					-- Son of Hades.
					{ Cue = "/VO/Chaos_0205",  },
					-- You have come.
					{ Cue = "/VO/Chaos_0206",  },
					-- I have a guest.
					{ Cue = "/VO/Chaos_0207",  },
					-- You are expected here.
					{ Cue = "/VO/Chaos_0208",  },
					-- There you are.
					{ Cue = "/VO/Chaos_0209",  },
					-- Ah.
					{ Cue = "/VO/Chaos_0210",  },
				},
				{
					RandomRemaining = true,
					PreLineWait = 1.1,
					PlayOnceContext = "NyxChaosReunionQuest",
					RequiredTextLines = { "NyxAboutChaos07" },
					SuccessiveChanceToPlayAll = 0.33,
					RequiredAnyUnitAlive = { "NPC_Nyx_Story_01" },

					-- Nyx, you're here...!
					{ Cue = "/VO/ZagreusField_3459" },
					-- Nyx...!
					{ Cue = "/VO/ZagreusField_3460", RequiredPlayed = { "/VO/ZagreusField_3459" }, },
					-- Sorry to interrupt.
					{ Cue = "/VO/ZagreusField_3461", RequiredPlayed = { "/VO/ZagreusField_3459" }, },
					-- Nyx, Master Chaos.
					{ Cue = "/VO/ZagreusField_3462", RequiredPlayed = { "/VO/ZagreusField_3459" }, },
					-- Hello, Nyx...!
					{ Cue = "/VO/ZagreusField_3463", RequiredPlayed = { "/VO/ZagreusField_3459" }, },
				},	
				{
					BreakIfPlayed = true,
					PreLineWait = 1.0,
					PlayOnce = true,
					PlayOnceContext = "NyxInChaos",
					ObjectType = "NPC_Nyx_Story_01",
					Queue = "Always",

					-- I thank you for this, child.
					{ Cue = "/VO/Nyx_0242" },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.1,
					PlayOnce = true,
					PlayOnceContext = "NyxInChaos",
					ObjectType = "NPC_Nyx_Story_01",
					Queue = "Always",
					SuccessiveChanceToPlayAll = 0.15,

					-- Welcome to Chaos.
					{ Cue = "/VO/Nyx_0414" },
					-- You found us.
					{ Cue = "/VO/Nyx_0415" },
					-- All of us, here.
					{ Cue = "/VO/Nyx_0416" },
					-- You are here.
					{ Cue = "/VO/Nyx_0417" },
					-- What a surprise.
					{ Cue = "/VO/Nyx_0418" },
				},
				{
					BreakIfPlayed = true,
					PreLineWait = 0.1,
					PlayOnce = true,
					PlayOnceContext = "NyxInChaos",
					ObjectType = "NPC_Nyx_Story_01",
					Queue = "Always",
					SuccessiveChanceToPlayAll = 0.15,

					-- Child?
					{ Cue = "/VO/Nyx_0227" },
					-- Child.
					{ Cue = "/VO/Nyx_0204" },
					-- My child.
					{ Cue = "/VO/Nyx_0205" },
					-- It is you.
					{ Cue = "/VO/Nyx_0208" },
					-- You are here.
					{ Cue = "/VO/Nyx_0210" },
					-- Ah.
					{ Cue = "/VO/Nyx_0212" },
					-- Mmm.
					{ Cue = "/VO/Nyx_0255" },
				},
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.4,
				PlayOnce = true,
				PlayOnceContext = "NyxChaosReunionQuest",
				RequiredTextLines = { "NyxAboutChaos07" },
				RequiredFalseTextLines = { "ChaosAboutNyx06" },
				RequiredUnitNotAlive = "NPC_Nyx_Story_01",

				-- Hope Nyx is all right...
				{ Cue = "/VO/ZagreusField_3468" },
			},			
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.4,
				PlayOnce = true,
				-- Who or what is that...?
				{ Cue = "/VO/ZagreusField_1068", RequiredFalseTextLines = { "ChaosFirstPickUp" } },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.4,
				ChanceToPlay = 0.75,
				SuccessiveChanceToPlay = 0.33,
				RequiredUnitNotAlive = "NPC_Nyx_Story_01",

				Cooldowns =
				{
					{ Name = "EnteredSecretRoomSpeech", Time = 20 },
				},

				-- Huh...
				-- { Cue = "/VO/ZagreusField_0200" },
				-- Interesting.
				{ Cue = "/VO/ZagreusField_0201" },
				-- Where in the...
				{ Cue = "/VO/ZagreusField_0202", RequiredFalseTextLines = { "ChaosGift03"} },
				-- Let's see...
				{ Cue = "/VO/ZagreusField_0203" },
				-- Well then...
				{ Cue = "/VO/ZagreusField_0204" },
				-- All right then.
				{ Cue = "/VO/ZagreusField_0205" },
				-- Oof.
				{ Cue = "/VO/ZagreusField_0206", RequiredFalseTraits = { "ChaosBoonTrait" }, },
				-- Where am I?
				{ Cue = "/VO/ZagreusField_0425", RequiredFalseTextLines = { "ChaosGift03"} },
				-- Darkness...
				{ Cue = "/VO/ZagreusField_0122" },
				-- Master Chaos! I've returned.
				{ Cue = "/VO/ZagreusField_0426", RequiredTextLines = { "ChaosGift02" } },
				-- The heart of the Underworld.
				{ Cue = "/VO/ZagreusField_0427" },
				-- I'm back here.
				{ Cue = "/VO/ZagreusField_0428" },
			},
		},
	},

	RoomSecret01 =
	{
		InheritFrom = { "BaseSecret" },
		SpawnRewardOnId = 412405,
		NumExits=1,

		InspectPoints =
		{
			[505097] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_RoomSecret01_01 =
					{
						-- Could you keep it down?
						EndCue = "/VO/ZagreusField_0535",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0161",
							Text = "{#DialogueItalicFormat}The deepest reaches of the Underworld... the void from which all life and consciousness sprang forth during the dawn of time... the realm of Chaos. A land almost unseen even to denizens of death's kingdom." },
					},
				},
			},
		},
	},

	RoomSecret02 =
	{
		InheritFrom = { "BaseSecret" },
		SpawnRewardOnId = 412428,
		NumExits=1,

		InspectPoints =
		{
			[505099] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_RoomSecret02_01 =
					{
						-- It wasn't all that hard to find really.
						EndCue = "/VO/ZagreusField_0937",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0201",
							Text = "{#DialogueItalicFormat}The fathomless expanses hidden in darkest corners of the Underworld stretch well past the notice of Lord Hades himself; and yet, the interfering Prince somehow discovers passage there." },
					},
				},
			},
		},
	},

	RoomSecret03 =
	{
		InheritFrom = { "BaseSecret" },
		SpawnRewardOnId = 412426,
		NumExits=1,

		InspectPoints =
		{
			[505098] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_RoomSecret03_01 =
					{
						-- I'd best take all the evidence I find.
						EndCue = "/VO/ZagreusField_0938",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0202",
							Text = "{#DialogueItalicFormat}Within the Underworld's quietest, most solitary, darkest abyss lies hidden evidence of the beginning of all things, of Chaos! The most ancient sculptor that has shaped this world." },
					},
				},
			},
		},
	},
}

OverwriteTableKeys( RoomData, RoomSetData.Secrets )