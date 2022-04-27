DeathLoopData =
{
	DeathArea =
	{
		ZoomFraction = 0.75,
		ZoomLerpTime = 4.0,
		CameraZoomWeights =
		{
			[40001] = 1.0,
			[210380] = 1.2,
			[50002] = 1.3,
			[555424] = 1.0,
		},
		SoftClamp = 0.75,
		CameraClamps = { 422050, 422043, 422045, 422046, 422047, 422048, 422049 },
		FullscreenEffectGroup = "LoungeHider_01",
		RichPresence = "#RichPresence_House",

		BinkSet = "NPCs",
		Binks =
		{
			"NPC_3DGhostAltFidget_Bink",
			"NPC_3DGhostAltIdle_Bink",
			"GhostChefChopOnion_Bink",
			"GhostChefChopOnion2_Bink",
			"ZagreusPetting_Bink",
		},

		ShowResourceUIOnly = true,

		IgnoreStemMixer = true,
		AmbientMusicParams =
		{
			LowPass = 0.0,
			Vocals = 1.0,
		},
		AmbientMusicVolume = 1.0,
		Ambience = "/Ambience/MusicExploration4Ambience",
		RemoveDashFireFx = true,
		SkipWeaponBinkPreLoading = true,

		FailedToFireFunctionName = "DeathAreaAttackFailPresentation",

		DistanceTriggers =
		{
			-- Hidden Inspect Point
			{
				TriggerObjectType = "InspectPoint", WithinDistance = 300, AlphaObjectIn = "Self", Repeat = true, RemoveNotifiedIds = true,
			},
			-- Lounge Closed
			{
				TriggerGroup = "LoungeReveal_01", WithinDistance = 6000, DeleteGroup = "LoungeReveal_01",
				RequiredMinCompletedRuns = 4,
				RequiredFalseFlags = { "InFlashback", },
			},
			-- Lounge Open VO
			{
				TriggerObjectType = "HouseTableRound01", WithinDistance = 425,
				RequiredMinCompletedRuns = 4,
				RequiredFalseFlags = { "InFlashback", },
				VoiceLines =
				{
					-- Hey the lounge is open.
					PreLineWait = 0.1,
					{ Cue = "/VO/ZagreusHome_0457", PlayOnce = true },
				},
			},
			{
				TriggerObjectType = "HouseTableRound01",
				RequiredFalseFlags = { "InFlashback", },
				RequiredFalseTextLinesThisRun = { "NyxAboutDusa03" },
				WithinDistance = 600,
				VoiceLines =
				{
					RandomRemaining = true,
					PreLineWait = 0.1,
					SuccessiveChanceToPlay = 0.1,
					RequiredHasFish = true,
					UsePlayerSource = true,

					-- Should visit the Head Chef.
					{ Cue = "/VO/ZagreusHome_1801", RequiredPlayed = { "/VO/ZagreusHome_1804" }, },
					-- The Head Chef always wants fish.
					{ Cue = "/VO/ZagreusHome_1802", RequiredPlayed = { "/VO/ZagreusHome_1804" }, },
					-- Fish delivery for the Head Chef.
					{ Cue = "/VO/ZagreusHome_1803", RequiredPlayed = { "/VO/ZagreusHome_1804" }, },
					-- The Head Chef is going to want this fish.
					{ Cue = "/VO/ZagreusHome_1804" },
				},
			},
			-- Top Hall Dim
			{
				TriggerGroup = "TopHallUnDim", WithinDistance = 300, FunctionName = "UnDimTopHall", Repeat = true,
			},
			{
				TriggerGroup = "TopHallDim", WithinDistance = 300, FunctionName = "DimTopHall", Repeat = true,
			},
			-- LoungeDim
			{
				TriggerGroup = "LoungeUnDim", WithinDistance = 400, FunctionName = "UnDimLounge", Repeat = true,
				RequiredMinCompletedRuns = 4,
			},
			{
				TriggerGroup = "LoungeDim", WithinDistance = 450, FunctionName = "DimLounge", Repeat = true,
				RequiredMinCompletedRuns = 4,
			},
			-- Lounge Shortcut Dim
			{
				TriggerGroup = "LoungeShortcutUnDim", WithinDistance = 200, FunctionName = "UnDimLounge", Repeat = true,
				RequiredCosmetics = { "Cosmetic_LoungeShortcut" },
			},
			{
				TriggerGroup = "LoungeShortcutDim", WithinDistance = 200, FunctionName = "DimLounge", Repeat = true,
				RequiredCosmetics = { "Cosmetic_LoungeShortcut" },
			},

			-- Ghosts
			{
				TriggerGroup = "Ghost3D", WithinDistance = 900, FunctionName = "GhostExpressiveEmote", Repeat = true,
			},
			-- Hades
			{
				TriggerObjectType = "NPC_Hades_01", WithinDistance = 1500, ScaleY = 0.75, RequiredCompletedRuns = 0, LockToCharacter = true,
				TriggerOnceThisRun = true, SetFlagTrue = "MetHades",
				-- Stinger = "/Music/HadesTheme",
				Stinger = "/Leftovers/World Sounds/MapZoomInShortHigh",
				RequiresFalseHadesProcession = true,
				VoiceLines =
				{
					-- Back already?
					{ Cue = "/VO/Hades_0087", PreLineWait = 0.65, RequiredCompletedRuns = 0, PlayOnceThisRun = true, },
				},
			},
			{
				TriggerObjectType = "NPC_Hades_01", WithinDistance = 1300, ScaleY = 0.5, RequiredMinCompletedRuns = 1,
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					{
						PlayOnce = true,
						IsIdAlive = 427173,
						PreLineWait = 0.35,
						TriggerOnceThisRun = true,
						UsePlayerSource = true,
						TriggerCooldowns = { "HouseNPCAnySpeech", },
						RequiredScreenViewedFalse = "GhostAdmin",
						UsePlayerSource = true,
						Cooldowns =
						{
							{ Name = "ZagreusMiscHouseSpeech", Time = 20 },
						},
						-- note: second line here is for Early Access players.

						-- Who's that new shade there next to Father?
						-- { Cue = "/VO/ZagreusHome_1061", RequiredFalsePlayed = { "/VO/ZagreusHome_1062" }, RequiredFalseTextLines = { "HadesAboutGhostAdmin01" } },
						-- Someone's at the desk next to the throne...
						{ Cue = "/VO/ZagreusHome_1524", RequiredFalsePlayed = { "/VO/ZagreusHome_1062" }, RequiredFalseTextLines = { "HadesAboutGhostAdmin01" } },
						-- Something's different about that shade next to Father.
						{ Cue = "/VO/ZagreusHome_1062", RequiredFalsePlayed = { "/VO/ZagreusHome_1524" }, RequiredMinCompletedRuns = 3 },
					},
				}
			},
			-- Persephone
			{
				TriggerObjectType = "NPC_Persephone_Home_01", WithinDistance = 1100, ScaleY = 0.5, RequiredQueuedTextLines = "OlympianReunionQuestComplete",
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					{
						UsePlayerSource = "true",

						-- Mother!
						{ Cue = "/VO/ZagreusField_3605" },
					},
					{
						BreakIfPlayed = true,
						PreLineWait = 0.2,
						ObjectType = "NPC_Persephone_Home_01",

						-- Zagreus!
						{ Cue = "/VO/Persephone_0300" },
					}
				},
			},
			-- GhostAdmin Hints: Early Game (Later On version below)
			{
				TriggerObjectType = "NPC_Hades_01", WithinDistance = 1200, ScaleY = 0.5,
				RequiredMinCompletedRuns = 2,
				RequiredMaxCompletedRuns = 8,
				RequiredResourcesMin = { Gems = 30 },
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					[1] = GlobalVoiceLines.GhostAdminUseHintVoiceLines,
				},
			},
			-- GhostAdmin Hints: Later On
			{
				TriggerObjectType = "NPC_Hades_01", WithinDistance = 1200, ScaleY = 0.5,
				RequiredMinCompletedRuns = 9,
				RequiredMaxCompletedRuns = 25,
				RequiredResourcesMin = { SuperGems = 3 },
				RequiredFalseCosmetics = { "RoomRewardMetaPointDropRunProgress", "ChallengeSwitches3" },
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					[1] = GlobalVoiceLines.GhostAdminUseHintVoiceLines,
				},
			},
			{
				TriggerObjectType = "NPC_Hades_01", WithinDistance = 1100, ScaleY = 0.5, RequiredMinCompletedRuns = 1, RequiredFalseQueuedTextLines = { "HadesPostEnding01", "OlympianReunionQuestComplete" },
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					TriggerCooldowns = { "ZagreusAnyQuipSpeech" },
					{
						RequiredTextLinesThisRun = "PersephoneFirstMeeting",
						BreakIfPlayed = true,
						RequiresRunCleared = true,
						PreLineWait = 0.35,
						RequiresFalseHadesProcession = true,
						Cooldowns =
						{
							{ Name = "HouseNPCAnySpeech", Time = 10 },
						},

						-- He's finally returned.
						{ Cue = "/VO/Hades_0218" },
					},
					{
						RequiredTextLinesThisRun = "PersephoneMeeting02",
						BreakIfPlayed = true,
						RequiresRunCleared = true,
						PreLineWait = 0.35,
						RequiresFalseHadesProcession = true,
						Cooldowns =
						{
							{ Name = "HouseNPCAnySpeech", Time = 10 },
						},

						-- Urgh, how could he... you.
						{ Cue = "/VO/Hades_0440" },
					},
					{
						RandomRemaining = true,
						BreakIfPlayed = true,
						RequiresRunCleared = true,
						PreLineWait = 0.35,
						RequiresFalseHadesProcession = true,
						RequiresNullAmbientMusicId = true,
						RequiredFalsePrevRooms = { "DeathAreaBedroom", "DeathAreaOffice", "DeathAreaBedroomHades" },
						Cooldowns =
						{
							{ Name = "HouseNPCAnySpeech", Time = 10 },
						},

						-- You'll go no further, boy; at least, not yet.
						-- { Cue = "/VO/Hades_0360", RequiredPlayed = { "/VO/Hades_0433" } },
						-- Alas for ongoing Underworld renovations.
						-- { Cue = "/VO/Hades_0435", RequiredPlayed = { "/VO/Hades_0433" } },
						-- Everything is as it always was.
						{ Cue = "/VO/Hades_0433" },
						-- He's finally returned.
						{ Cue = "/VO/Hades_0218", RequiredPlayed = { "/VO/Hades_0433" }, RequiredMinRunsCleared = 10 },
						-- Don't you see, boy? You are trapped.
						{ Cue = "/VO/Hades_0406", RequiredPlayed = { "/VO/Hades_0433" }, RequiredFalseTextLines = { "Ending01" }, },
						-- I didn't think you had it in you, boy.
						{ Cue = "/VO/Hades_0408", RequiredPlayed = { "/VO/Hades_0433" } },
						-- Hmph! I was looking all over for you.
						{ Cue = "/VO/Hades_0432", RequiredPlayed = { "/VO/Hades_0433" } },
						-- I just got back shortly before you did!
						{ Cue = "/VO/Hades_0436", RequiredPlayed = { "/VO/Hades_0433" } },
						-- Resolved the trouble with the Satyrs yet?
						{ Cue = "/VO/Hades_0437", RequiredPlayed = { "/VO/Hades_0433" } },
						-- You're bound to my domain, boy.
						{ Cue = "/VO/Hades_0438", RequiredPlayed = { "/VO/Hades_0433" }, RequiredFalseTextLines = { "Ending01" }, },
						-- So very tired...
						{ Cue = "/VO/Hades_0439", RequiredPlayed = { "/VO/Hades_0433" }, RequiredFalseTextLines = { "Ending01" }, },
						-- Urgh, how could he... you.
						{ Cue = "/VO/Hades_0440", RequiredPlayed = { "/VO/Hades_0433" }, RequiredFalseTextLines = { "Ending01" }, RequiredFalseTextLinesLastRun = { "PersephoneFirstMeeting" }, },
						-- Congratulations...!
						{ Cue = "/VO/Hades_0216", RequiredPlayed = { "/VO/Hades_0433" }, RequiredTextLines = { "Ending01" }, },
						-- Congratulations, boy.
						{ Cue = "/VO/Hades_0217", RequiredPlayed = { "/VO/Hades_0433" }, RequiredTextLines = { "Ending01" }, },
						-- Welcome home, boy!
						{ Cue = "/VO/Hades_0219", RequiredPlayed = { "/VO/Hades_0433" }, RequiredTextLines = { "Ending01" }, },
						-- Everyone, look who it is!
						{ Cue = "/VO/Hades_0358", RequiredPlayed = { "/VO/Hades_0433" }, RequiredTextLines = { "Ending01" }, },
						-- He did it again, Cerberus!
						{ Cue = "/VO/Hades_0357", IsIdAlive = 370007, RequiredPlayed = { "/VO/Hades_0359", "/VO/Hades_0433" } },
						-- He's done it, Cerberus!
						{ Cue = "/VO/Hades_0359", IsIdAlive = 370007, RequiredPlayed = { "/VO/Hades_0433" } },						
						-- Hrm.
						{ Cue = "/VO/Hades_1101", RequiredTextLines = { "Ending01" }, },
						-- Zagreus.
						{ Cue = "/VO/Hades_1102", RequiredTextLines = { "Ending01" }, },
						-- Our work is never done...
						{ Cue = "/VO/Hades_1103", RequiredTextLines = { "Ending01" }, },
						-- More to be done.
						{ Cue = "/VO/Hades_1104", RequiredTextLines = { "Ending01" }, },
						-- Thought I had you, there.
						{ Cue = "/VO/Hades_1105", RequiredTextLines = { "Ending01" }, },
						-- Boy.
						{ Cue = "/VO/Hades_1106", RequiredTextLines = { "Ending01" }, },
						-- Boy, erm. Zagreus.
						{ Cue = "/VO/Hades_1107", RequiredPlayed = { "/VO/Hades_1106" }, RequiredTextLines = { "Ending01" }, },
						-- There you are.
						{ Cue = "/VO/Hades_1108", RequiredTextLines = { "Ending01" }, },
						-- Returned, have you?
						{ Cue = "/VO/Hades_1109", RequiredTextLines = { "Ending01" }, },
					},
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						PreLineWait = 0.35,
						RequiresFalseHadesProcession = true,
						RequiresNullAmbientMusicId = true,
						RequiredFalsePrevRooms = { "DeathAreaBedroom", "DeathAreaOffice", "DeathAreaBedroomHades" },
						Cooldowns =
						{
							{ Name = "HouseNPCAnySpeech", Time = 10 },
						},

						-- <Laughter>
						{ Cue = "/VO/Hades_0072", PreLineAnim = "Hades_HouseWryLaughToGlaringToWriting", RequiredFalseTextLines = { "Ending01" }, PreLineThreadedFunctionName = "HadesLaughDisable" },
						-- <Laughter>
						-- { Cue = "/VO/Hades_0073" },
						-- <Laughter>
						{ Cue = "/VO/Hades_0074", PreLineAnim = "Hades_HouseWryLaughToGlaringToWriting", PreLineThreadedFunctionName = "HadesLaughDisable" },
						-- <Laughter>
						{ Cue = "/VO/Hades_0075", PreLineAnim = "Hades_HouseWryLaughToGlaringToWriting", PreLineThreadedFunctionName = "HadesLaughDisable" },
						-- <Laughter>
						{ Cue = "/VO/Hades_0076", PreLineAnim = "Hades_HouseWryLaughToGlaringToWriting", PreLineThreadedFunctionName = "HadesLaughDisable" },
						-- <Sigh>
						{ Cue = "/VO/Hades_0077" },
						-- <Groan>
						{ Cue = "/VO/Hades_0078" },
						-- <Scoffing>
						{ Cue = "/VO/Hades_0079" },
						-- Unnngghhh...
						{ Cue = "/VO/Hades_0080" },
						-- Urrnnggghhh....
						{ Cue = "/VO/Hades_0081" },
						-- Back again, hm?
						{ Cue = "/VO/Hades_0082" },
						-- <Tsk, tsk, tsk, tsk> Too bad, boy.
						{ Cue = "/VO/Hades_0083" },
						-- Hrrnn?
						{ Cue = "/VO/Hades_0084" },
						-- Euugghh...
						{ Cue = "/VO/Hades_0085" },
						-- Back already?
						{ Cue = "/VO/Hades_0087", RequiredFalseSeenRoomThisRun = "C_Intro" },
						-- Ahem.
						{ Cue = "/VO/Hades_0108" },
						-- Ahem?
						{ Cue = "/VO/Hades_0109" },
						-- Forget something again?
						{ Cue = "/VO/Hades_0110", RequiredFalseSeenRoomThisRun = "C_Intro" },
						-- Such a shame.
						{ Cue = "/VO/Hades_0111" },
						-- For shame.
						{ Cue = "/VO/Hades_0112" },
						-- Disgraceful.
						{ Cue = "/VO/Hades_0113", RequiredFalseTextLines = { "Ending01" }, },
						-- Had enough yet?
						{ Cue = "/VO/Hades_0114" },
						-- Ah, tough luck.
						{ Cue = "/VO/Hades_0115" },
						-- Didn't hear you come in.
						{ Cue = "/VO/Hades_0116" },
						-- Psh.
						{ Cue = "/VO/Hades_0117", RequiredFalseTextLines = { "Ending01" }, },
						-- You.
						{ Cue = "/VO/Hades_0118", RequiredFalseTextLines = { "Ending01" }, },
						-- You again.
						{ Cue = "/VO/Hades_0119", RequiredFalseTextLines = { "Ending01" }, },
						-- Pardon the interruption, everyone.
						{ Cue = "/VO/Hades_0120" },
						-- You never learn.
						{ Cue = "/VO/Hades_0121", RequiredFalseTextLines = { "Ending01" }, },
						-- Look who's back.
						{ Cue = "/VO/Hades_0122" },
						-- Oh it's only you.
						{ Cue = "/VO/Hades_0123", RequiredFalseTextLines = { "HadesGift04" }, },
						-- Grown any wiser yet?
						{ Cue = "/VO/Hades_0434", RequiredFalseTextLines = { "Ending01" }, },
						-- Well, well, well.
						{ Cue = "/VO/Hades_0431" },
						-- Pathetic.
						{ Cue = "/VO/Hades_0050", RequiredFalseSeenRoomThisRun = "C_Boss01", RequiredFalseTextLines = { "Ending01" }, },
						-- Useless.
						{ Cue = "/VO/Hades_0051", RequiredFalseTextLines = { "Ending01" }, },
						-- To suffer such indignity, from my own kin.
						{ Cue = "/VO/Hades_0058", RequiredFalseTextLines = { "Ending01" }, },
						-- A pitiful attempt.
						{ Cue = "/VO/Hades_0059", RequiredFalseSeenRoomThisRun = "C_Boss01", RequiredFalseTextLines = { "Ending01" }, },
						-- Elysium is up in arms again because of you.
						{ Cue = "/VO/Hades_0407", RequiredBiome = "Elysium", },
						-- Fought all the way out of Elysium, only to end up here.
						{ Cue = "/VO/Hades_0405", RequiredBiome = "Styx", },
						-- The Hydra shall grow back, boy.
						{ Cue = "/VO/Hades_0356", RequiredAnyRoomsThisRun = { "B_Boss01", "B_Boss02" }, RequiredFalseSeenRoomThisRun = "C_Boss01" },
					},
				},
			},
			-- Behind Hades
			{
				TriggerGroup = "BehindHadesPoints",
				WithinDistance = 150,
				RequiredFalseFlags = { "InFlashback", },
				RequiredFalseQueuedTextLines = GameData.HadesGardenTextLines,
				RequiredFalseTextLinesThisRun = { "HadesAboutOlympianReunionQuest01A" },
				VoiceLines =
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					CooldownTime = 200,
					ObjectType = "NPC_Hades_01",
					RequiresFalseHadesProcession = true,
					SuccessiveChanceToPlay = 0.75,

					-- Get away from back there.
					{ Cue = "/VO/Hades_0487" },
					-- Go about your business.
					{ Cue = "/VO/Hades_0488" },
					-- You are irritating me, boy.
					{ Cue = "/VO/Hades_0489" },
					-- Get where I can see you.
					{ Cue = "/VO/Hades_0490" },
					-- Back away from there.
					{ Cue = "/VO/Hades_0491" },
					-- Stop being a fool.
					{ Cue = "/VO/Hades_0492", RequiredFalseTextLines = { "Ending01" }, },
					-- Don't you have someplace else to be?
					{ Cue = "/VO/Hades_0493" },
					-- Begone from there.
					{ Cue = "/VO/Hades_0494" },
					-- Cease this, boy.
					{ Cue = "/VO/Hades_0495" },
					-- Have you no better way to pass the time?
					{ Cue = "/VO/Hades_0496" },
				},
			},
			-- Cerberus
			{
				TriggerObjectType = "NPC_Cerberus_01", WithinDistance = 500,
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					-- whine
					-- { Cue = "/VO/CerberusWhineHappy" },
				},
			},
			-- Nyx
			{
				TriggerObjectType = "NPC_Nyx_01", WithinDistance = 500,
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					{
						BreakIfPlayed = true,
						RequiredQueuedTextLines = "NyxGrantsRespec",
						SuccessiveChanceToPlay = 0.33,
						PreLineAnim = "NyxIdleGreeting",

						-- Here.
						{ Cue = "/VO/Nyx_0226" },
					},
					{
						BreakIfPlayed = true,
						RequiredAnyQueuedTextLines = { "NyxAboutPersephoneMeeting01", "NyxAboutPersephoneMeeting01B" },
						SuccessiveChanceToPlay = 0.33,
						PreLineAnim = "NyxIdleGreeting",

						-- Child?
						{ Cue = "/VO/Nyx_0227" },
					},
					{
						BreakIfPlayed = true,
						RequiredQueuedTextLines = "NyxAboutPersephoneMeeting03",
						SuccessiveChanceToPlay = 0.33,
						PreLineAnim = "NyxIdleGreeting",

						-- A word.
						{ Cue = "/VO/Nyx_0221" },
					},
					{
						SuccessiveChanceToPlay = 0.33,
						BreakIfPlayed = true,
						RequiresRunCleared = true,
						RequiredQueuedTextLines = "NyxAboutPersephoneMeeting05",
						RequiredFalseTextLines = { "Ending01" },
						PreLineAnim = "NyxIdleGreeting",

						-- Did you find her?
						{ Cue = "/VO/Nyx_0217" },
					},
					{
						BreakIfPlayed = true,
						RequiredQueuedTextLines = "NyxAboutPersephoneMeeting06",
						SuccessiveChanceToPlay = 0.33,
						PreLineAnim = "NyxIdleGreeting",

						-- Wait...
						{ Cue = "/VO/Nyx_0293" },
					},
					{
						BreakIfPlayed = true,
						RequiredQueuedTextLines = "NyxAboutPersephoneMeeting07",
						SuccessiveChanceToPlay = 0.33,
						PreLineAnim = "NyxIdleGreeting",

						-- Zagreus?
						{ Cue = "/VO/Nyx_0412" },
					},
					{
						BreakIfPlayed = true,
						RequiredQueuedTextLines = "NyxRevealsArthurAspect01",
						SuccessiveChanceToPlay = 0.33,
						PreLineAnim = "NyxIdleGreeting",

						-- A moment.
						{ Cue = "/VO/Nyx_0225" },
					},
					{
						BreakIfPlayed = true,
						RequiredQueuedTextLines = "NyxAboutChaos05",
						SuccessiveChanceToPlay = 0.33,
						PreLineAnim = "NyxIdleGreeting",

						-- A word, child?
						{ Cue = "/VO/Nyx_0222" },
					},
					{
						BreakIfPlayed = true,
						RequiredTextLinesThisRun = "Ending01",
						PreLineAnim = "NyxIdleGreeting",

						-- Ah.
						{ Cue = "/VO/Nyx_0212" },
					},
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.33,
						RequiresRunCleared = true,
						RequiredTextLines = { "PersephoneFirstMeeting" },
						RequiredFalseTextLinesThisRun = { "PersephoneFirstMeeting" },
						PreLineAnim = "NyxIdleGreeting",
						RequiresNullSecretMusicId = true,
						RequiresNullAmbientMusicId = true,
						RequiredFalsePrevRooms = { "DeathAreaBedroom", "DeathAreaOffice", "DeathAreaBedroomHades" },

						-- You have done well.
						{ Cue = "/VO/Nyx_0215", RequiredPlayed = { "/VO/Nyx_0217" }, RequiredTextLines = { "Ending01" }, },
						-- You broke free.
						{ Cue = "/VO/Nyx_0216", RequiredPlayed = { "/VO/Nyx_0217" }, RequiredTextLines = { "Ending01" }, },
						-- You reached the surface...
						{ Cue = "/VO/Nyx_0217" },
						-- Well done.
						{ Cue = "/VO/Nyx_0219", RequiredPlayed = { "/VO/Nyx_0217" }, RequiredTextLines = { "Ending01" }, },
						-- At last.
						{ Cue = "/VO/Nyx_0220", RequiredPlayed = { "/VO/Nyx_0217" }, },
						-- I never doubted you.
						{ Cue = "/VO/Nyx_0283", RequiredPlayed = { "/VO/Nyx_0217" }, },
						-- Excellently done.
						{ Cue = "/VO/Nyx_0285", RequiredPlayed = { "/VO/Nyx_0217" }, RequiredTextLines = { "Ending01" }, RequiredTextLines = { "Ending01" }, },
						-- I knew that you were more than capable.
						{ Cue = "/VO/Nyx_0282", RequiredPlayed = { "/VO/Nyx_0217" }, RequiredTextLines = { "Ending01" }, },
						-- I had envisioned that you would succeed.
						{ Cue = "/VO/Nyx_0284", RequiredPlayed = { "/VO/Nyx_0217" }, RequiredTextLines = { "Ending01" }, RequiredFalseTextLinesThisRun = { "Ending01" }, },
						-- Skillfully executed work.
						{ Cue = "/VO/Nyx_0286", RequiredPlayed = { "/VO/Nyx_0217" }, RequiredTextLines = { "Ending01" }, },
						-- Well done, child.
						{ Cue = "/VO/Nyx_0474", RequiredPlayed = { "/VO/Nyx_0217" }, RequiredTextLines = { "Ending01" }, },
						-- A commendable result.
						{ Cue = "/VO/Nyx_0475", RequiredPlayed = { "/VO/Nyx_0217" }, RequiredTextLines = { "Ending01" }, },
						-- You have done well.
						{ Cue = "/VO/Nyx_0476", RequiredPlayed = { "/VO/Nyx_0217" }, RequiredTextLines = { "Ending01" }, },
						-- Excellent work.
						{ Cue = "/VO/Nyx_0477", RequiredPlayed = { "/VO/Nyx_0217" }, RequiredTextLines = { "Ending01" }, },
						-- To your continued success.
						{ Cue = "/VO/Nyx_0478", RequiredPlayed = { "/VO/Nyx_0217" }, RequiredTextLines = { "Ending01" }, },
					},
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.25,
						PreLineAnim = "NyxIdleGreeting",
						RequiresNullSecretMusicId = true,
						RequiresNullAmbientMusicId = true,
						RequiredFalsePrevRooms = { "DeathAreaBedroom", "DeathAreaOffice", "DeathAreaBedroomHades" },

						-- You have come home.
						{ Cue = "/VO/Nyx_0054" },
						-- Hmm.
						{ Cue = "/VO/Nyx_0052", RequiredPlayed = { "/VO/Nyx_0054" } },
						-- You are home.
						{ Cue = "/VO/Nyx_0055", RequiredPlayed = { "/VO/Nyx_0054" } },
						-- Child.
						{ Cue = "/VO/Nyx_0204", RequiredPlayed = { "/VO/Nyx_0054" } },
						-- My child.
						{ Cue = "/VO/Nyx_0205", RequiredPlayed = { "/VO/Nyx_0054" } },
						-- You have returned.
						{ Cue = "/VO/Nyx_0206", RequiredPlayed = { "/VO/Nyx_0054" } },
						-- You are returned.
						{ Cue = "/VO/Nyx_0207", RequiredPlayed = { "/VO/Nyx_0054" } },
						-- It is you.
						{ Cue = "/VO/Nyx_0208", RequiredPlayed = { "/VO/Nyx_0054" } },
						-- You are back.
						{ Cue = "/VO/Nyx_0209", RequiredPlayed = { "/VO/Nyx_0054" } },
						-- You are here.
						{ Cue = "/VO/Nyx_0210", RequiredPlayed = { "/VO/Nyx_0054" } },
						-- A setback, then.
						{ Cue = "/VO/Nyx_0211", RequiredPlayed = { "/VO/Nyx_0054" }, RequiresRunNotCleared = true, },
						-- Ah.
						{ Cue = "/VO/Nyx_0212", RequiredPlayed = { "/VO/Nyx_0054" } },
						-- Be unseen.
						{ Cue = "/VO/Nyx_0213", RequiredPlayed = { "/VO/Nyx_0054" }, RequiredTextLines = { "NyxGift09" } },
						-- There you are.
						{ Cue = "/VO/Nyx_0214", RequiredPlayed = { "/VO/Nyx_0054" } },
						-- Zagreus.
						{ Cue = "/VO/Nyx_0411", RequiredPlayed = { "/VO/Nyx_0054" } },
						-- The Fates have been unkind.
						{ Cue = "/VO/Nyx_0261", RequiredPlayed = { "/VO/Nyx_0054" }, RequiredRoomThisRun = "D_Boss01", RequiresRunNotCleared = true, },
						-- Another setback to be overcome.
						{ Cue = "/VO/Nyx_0262", RequiredPlayed = { "/VO/Nyx_0054" }, RequiredRoomThisRun = "D_Boss01", RequiresRunNotCleared = true, },
						-- The realm is strong.
						{ Cue = "/VO/Nyx_0479", RequiredPlayed = { "/VO/Nyx_0217" }, RequiredTextLines = { "Ending01" }, },
						-- The House is in order.
						{ Cue = "/VO/Nyx_0480", RequiredTextLines = { "Ending01" }, },
						-- Haaaaah.
						-- { Cue = "/VO/Nyx_0053" },
						-- A welcome sight.
						-- { Cue = "/VO/Nyx_0056" },
					}
				},
			},
			-- Nyx Missing
			{
				TriggerGroup = "NyxMissingPoints",
				WithinDistance = 375,
				RequiredCompletedRuns = 3,
				RequiredFalseFlags = { "InFlashback", },
				VoiceLines =
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					UsePlayerSource = true,
					PlayOnceFromTableThisRun = true,

					-- Wonder where Nyx went.
					{ Cue = "/VO/ZagreusHome_0452" },
				},
			},
			-- Dusa
			{
				TriggerObjectType = "NPC_Dusa_01", WithinDistance = 680,
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					{
						BreakIfPlayed = true,
						RequiredQueuedTextLines = "DusaVsNyx03",
						SuccessiveChanceToPlay = 0.33,
						UsePlayerSource = true,

						-- Oh...
						{ Cue = "/VO/ZagreusHome_0561" },
					},
					{
						BreakIfPlayed = true,
						RequiredQueuedTextLines = "DusaVsNyx04",
						SuccessiveChanceToPlay = 0.33,
						UsePlayerSource = true,

						-- Dusa...?
						{ Cue = "/VO/ZagreusHome_0244" },
					},
					{
						BreakIfPlayed = true,
						RequiredQueuedTextLines = "DusaWithNyx03",
						SuccessiveChanceToPlay = 0.33,
						UsePlayerSource = true,

						-- Dusa!
						{ Cue = "/VO/ZagreusHome_2021" },
					},
				},
			},
			-- Orpheus
			{
				TriggerObjectType = "NPC_Orpheus_01", WithinDistance = 350,
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						ChanceToPlay = 0.4,
						SuccessiveChanceToPlay = 0.33,
						RequiresNullAmbientMusicId = true,
						PreLineAnim = "OrpheusFidget",
						Cooldowns =
						{
							{ Name = "HouseNPCAnySpeech", Time = 10 },
						},

						-- Hello...!
						{ Cue = "/VO/Orpheus_0060", RequiredPlayed = { "/VO/Orpheus_0061" }, },
						-- Hello...
						{ Cue = "/VO/Orpheus_0061", RequiredFalseTextLines = { "OrpheusAboutSingersReunionQuest01" }, },
						-- Hmm.
						{ Cue = "/VO/Orpheus_0062", RequiredPlayed = { "/VO/Orpheus_0061" }, },
						-- Ah.
						{ Cue = "/VO/Orpheus_0063", RequiredPlayed = { "/VO/Orpheus_0061" }, },
						-- Oh, um, hello.
						{ Cue = "/VO/Orpheus_0064", RequiredPlayed = { "/VO/Orpheus_0061" }, },
						-- Hello there.
						{ Cue = "/VO/Orpheus_0065", RequiredPlayed = { "/VO/Orpheus_0061" }, },
						-- Zagreus.
						-- { Cue = "/VO/Orpheus_0091", RequiredPlayed = { "/VO/Orpheus_0061" }, },
						-- Zagreus?
						-- { Cue = "/VO/Orpheus_0092", RequiredPlayed = { "/VO/Orpheus_0061" }, },
						-- Hello my friend.
						{ Cue = "/VO/Orpheus_0093", RequiredPlayed = { "/VO/Orpheus_0061" }, RequiredTextLines = { "OrpheusGift02" }, },
						-- Hello friend.
						{ Cue = "/VO/Orpheus_0094", RequiredPlayed = { "/VO/Orpheus_0061" }, RequiredTextLines = { "OrpheusGift06" }, },
						-- Greetings.
						{ Cue = "/VO/Orpheus_0095", RequiredPlayed = { "/VO/Orpheus_0061" }, RequiredTextLines = { "OrpheusGift02" }, },
					},
				},
			},
			-- Meg
			-- moved to NPCData / GlobalVoiceLines
		},

		StartUnthreadedEvents =
		{
			{
				FunctionName = "ActivateConditionalItems",
			},
			-- ending
			{
				FunctionName = "CheckGardenOpen",
				GameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
					RequiredTextLines = { "PersephoneReturnsHome01" },
				},
				Args =
				{
					DeleteGroups = { "GardenOpenDelete" },
					SetClamps = { 422050, 422043, 422045, 422046, 422047, 422048, 555425, 555424 },
				},
			},
			-- ending
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredFalseTextLines = { "Ending01" },
					RequiredRoomThisRun = "Return04",
				},
				Args =
				{
					Ids = { 555686, 555688, },
				},
			},
			{
				FunctionName = "SetupEndingScene",
				GameStateRequirements =
				{
					RequiredFalseTextLines = { "Ending01" },
					RequiredRoomThisRun = "Return04",
				},
				Args =
				{
					SetClamps = { 422050, 422043, 422045, 422046, 422047, 422048, 555425, 556837 },
					SetCameraZoomWeights =
					{
						[40001] = 1.0,
						[210380] = 1.2,
						[50002] = 1.3,
						[555424] = 0.85,
						[556836] = 0.85,
					},
				},
			},
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredFalseTextLines = { "Ending01" },
					RequiredFalseRooms = { "DeathAreaBedroomHades" },
					RequiredRoomThisRun = "Return04",
				},
				BreakIfPlayed = true,
				Args =
				{
					Ids = { 555687 },
					DistanceTrigger =
					{
						WithinDistance = 2000,
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							SkipPan = true,
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.85,
									UsePlayerSource = true,

						 			-- Wow...
						 			-- { Cue = "/VO/ZagreusField_0285" },
								},
								{
									PreLineWait = 0.35,
									BreakIfPlayed = true,
									PostLineWait = 0.65,

									-- Zagreus.
									-- { Cue = "/VO/MegaeraHome_0058" },
								},
							},
							TextLineSet =
							{
								Ending01 =
								{
									-- requirements are above
									EndVoiceLines =
									{
										PreLineWait = 2.35,
										BreakIfPlayed = true,

										-- Zagreus? Come here a moment, please.
										-- { Cue = "/VO/Persephone_0114" },
									},
									{ Cue = "/VO/Persephone_0101", Speaker = "NPC_Persephone_01", 
										Portrait = "Portrait_Persephone_Default_01",
										PostLineFunctionName = "GardenScenePan",
										PortraitExitAnimation = "Portrait_Persephone_Default_01_Exit",
										PreLineWait = 0.35,
										EndSound = "/VO/CerberusBarks",
										Text = "...I spent many days tending this garden... or nights? Quite difficult to tell the time here. But, it's held on longer than I would have expected..." },

									{ Cue = "/VO/Hades_0913",
										-- SecretMusicActiveStems = { "Room", "Strings", "WoodWinds", "Harp", "Trombones", "Percussion" },
										-- SecretMusicMutedStems = { "Room", "Strings", "WoodWinds", "Harp", "Trombones", "Percussion" },

										SecretMusicActiveStems = { "Trombones" },
										SecretMusicMutedStems = { "Percussion" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Hades_01", Portrait = "Portrait_Hades_Default_01",
										PreLineFunctionName = "HadesArmsCross",
										Text = "...Persephone... I..." },

									{ Cue = "/VO/Persephone_0103",

										SecretMusicActiveStems = { "Percussion" },
										SecretMusicMutedStems = { "Trombones" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Persephone_01", Portrait = "Portrait_Persephone_Joyful_01",
										Emote = "PortraitEmoteSurprise",
										PreLineAnim = "PersephoneGarden_Shocked", PreLineAnimTarget = 555688,
										PostLineAnim = "PersephoneGarden_Vulnerable_ShockToThoughtful", PostLineAnimTarget = 555688,
										Text = "Cerberus! I missed you so. And dutiful as ever, aren't you." },

									{ Cue = "/VO/Hades_0914",

										SecretMusicActiveStems = { "Trombones" },
										SecretMusicMutedStems = { "Percussion" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Hades_01", Portrait = "Portrait_Hades_Averted_01", PreLineWait = 0.35,
										PreLineFunctionName = "HadesArmsUnCross",
										Text = "...I'm sorry. Know that I am sorry." },

									{ Cue = "/VO/Persephone_0104",

										SecretMusicActiveStems = { "Percussion" },
										SecretMusicMutedStems = { "Trombones" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Persephone_01", Portrait = "Portrait_Persephone_Apprehensive_01",
										PreLineAnim = "PersephoneGarden_Vulnerable_ReturnToIdle", PreLineAnimTarget = 555688,
										Text = "Hades... you look tired. Though, I am not the only one you ought to be apologizing to." },

									{ Cue = "/VO/Hades_1202",

										SecretMusicActiveStems = { "Trombones" },
										SecretMusicMutedStems = { "Percussion" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Hades_01", Portrait = "Portrait_Hades_Averted_01",
										PreLineFunctionName = "HadesArmsCross",
										Text = "I know. I know, I.... Why have you returned? If Olympus... if your mother discovers what happened, not even Zeus, not even {#DialogueItalicFormat}he {#PreviousFormat}could stop what would transpire, here!" },

									{ Cue = "/VO/Persephone_0105",

										SecretMusicActiveStems = { "Percussion" },
										SecretMusicMutedStems = { "Trombones" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Persephone_01", Portrait = "Portrait_Persephone_Default_01",
										PreLineFunctionName = "HadesArmsUnCross",
										PreLineAnim = "PersephoneGarden_Vulnerable", PreLineAnimTarget = 555688,
										Text = "{#DialogueItalicFormat}Oh{#PreviousFormat}, I've a thought or two about how we can settle that. Though I shall need for you and Zagreus to cooperate with me on a solution. Or, if you'd rather, I could just return the way I came?" },

									{ Cue = "/VO/Hades_0916",

										SecretMusicActiveStems = { "Trombones" },
										SecretMusicMutedStems = { "Percussion" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Hades_01", Portrait = "Portrait_Hades_Default_01",
										PreLineFunctionName = "HadesArmsCross",
										Text = "A solution? What, do you intend to have them over for Ambrosia? Not even you can fix a broken family, Persephone." },

									{ Cue = "/VO/Persephone_0106",

										SecretMusicActiveStems = { "Percussion" },
										SecretMusicMutedStems = { "Trombones" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Persephone_01",
										Portrait = "Portrait_Persephone_FiredUp_01",
										PortraitExitAnimation = "Portrait_Persephone_FiredUp_01_Exit",
										PreLineAnim = "PersephoneGarden_Greeting",
										PreLineAnimTarget = 555688,
										Text = "You're right, Hades! I can't. Certainly not by myself. So, are you going to help me, or what?" },

									{ Cue = "/VO/Hades_0917",

										SecretMusicActiveStems = { "Trombones" },
										SecretMusicMutedStems = { "Percussion" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Hades_01", Portrait = "Portrait_Hades_Averted_01",
										PreLineFunctionName = "HadesArmsUnCross",
										PreLineWait = 0.9,
										Text = "...I would do anything that you would ask of me." },

									{ Cue = "/VO/Persephone_0107",

										SecretMusicActiveStems = { "Percussion" },
										SecretMusicMutedStems = { "Trombones" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Persephone_01",
										Portrait = "Portrait_Persephone_Apprehensive_01",
										PortraitExitAnimation = "Portrait_Persephone_Apprehensive_01_Exit",
										PreLineAnim = "PersephoneGarden_Dismiss", PreLineAnimTarget = 555688,
										Text = "Then, first, talk to your son." },

									{ Cue = "/VO/Hades_0918",

										SecretMusicActiveStems = { "Trombones" },
										SecretMusicMutedStems = { "Percussion" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Hades_01", Portrait = "Portrait_Hades_Default_01",
										PreLineWait = 1.31,
										PreLineFunctionName = "HadesArmsCross",
										Text = "...{#DialogueItalicFormat}Mm{#PreviousFormat}. Zagreus? You have already met Persephone, our Queen. I expect for you to show deference to her, at all times!" },

									{ Cue = "/VO/ZagreusHome_2678",

										SecretMusicActiveStems = { "WoodWinds" },
										SecretMusicMutedStems = { "Trombones", "Percussion" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "PlayerUnit", Portrait = "Portrait_Zag_Defiant_01",
										PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
										PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
										Text = "Wow, Father, you called me by my name! What is this strange sensation that I feel? Perhaps it's this {#DialogueItalicFormat}deference {#PreviousFormat}of which you speak?" },

									{ Cue = "/VO/Persephone_0109",

										SecretMusicActiveStems = { "Percussion" },
										SecretMusicMutedStems = { "WoodWinds", "Trombones" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Persephone_01", Portrait = "Portrait_Persephone_FiredUp_01",
										PortraitExitAnimation = "Portrait_Persephone_FiredUp_01_Exit",
										Emote = "PortraitEmoteDepressed",
										PreLineAnim = "PersephoneGarden_Dismiss", PreLineAnimTarget = 555688,
										Text = "Oh, stop it, both of you. Don't make me regret this, Hades. Speak honestly with him. About yourself, not me. Go on." },

									{ Cue = "/VO/Hades_0919",

										SecretMusicActiveStems = { "Trombones", "Room" },
										SecretMusicMutedStems = { "WoodWinds", "Percussion" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Hades_01", Portrait = "Portrait_Hades_Averted_01",
										SecretMusicSection = 2,
										PreLineWait = 0.8,
										PreLineFunctionName = "HadesArmsUnCross",
										Text = "Yes. I... Zagreus. I know there have been times... when I've let my mood reflect on you. I showed very little patience. Questioned your judgment, often, when my own was flawed. Thus, I apologize to you, my son. I have no excuses. And I ask no forgiveness." },

									{ Cue = "/VO/ZagreusHome_3267",

										SecretMusicActiveStems = { "WoodWinds" },
										SecretMusicMutedStems = { "Trombones", "Percussion" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "PlayerUnit", Portrait = "Portrait_Zag_Defiant_01",
										PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
										PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
										Text = "What about the part where you lied to me about Mother, do you apologize for that? Your foul moods, and venting them on me... I've long since come to expect that from you. And I resented you for it. But I always thought... you're honest." },

									{ Cue = "/VO/Hades_0943",

										SecretMusicActiveStems = { "Trombones" },
										SecretMusicMutedStems = { "WoodWinds", "Percussion" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Hades_01", Portrait = "Portrait_Hades_Averted_01",
										PreLineFunctionName = "HadesArmsCross",
										PreLineWait = 0.3,
										Text = "Your mother did not come here willingly when we originally met. When she left... believing you were stillborn... her decision was final. I believed that she was better off without the lot of us, Olympus included. Deceiving both of you... it tore against my being. But it needed to be done." },

									{ Cue = "/VO/ZagreusHome_3268",

										SecretMusicActiveStems = { "WoodWinds" },
										SecretMusicMutedStems = { "Trombones", "Percussion" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "PlayerUnit", Portrait = "Portrait_Zag_Empathetic_01",
										PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
										PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
										PreLineFunctionName = "HadesArmsUnCross",
										Text = "Well, you didn't need to vent all that inner turmoil onto me throughout my life. Though, I think I understand. I only wish I could have understood sooner. So, uh... what now? I've grown so used to ransacking your domain, I think I'm really going to miss it." },

									{ Cue = "/VO/Hades_0920",

										SecretMusicActiveStems = { "Trombones" },
										SecretMusicMutedStems = { "WoodWinds", "Percussion" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Hades_01", Portrait = "Portrait_Hades_Default_01",
										PreLineFunctionName = "HadesArmsCross",

										PreLineAnim = "CerberusHappyGreeting_ReturnToIdle", PreLineAnimTarget = 555687,
										Text = "About that... your {#DialogueItalicFormat}ransacking {#PreviousFormat}revealed many flaws in our security. The types that never get into reports. Our reputation rides on there being no escape from here. Would you... keep trying to break free? Not for my sake. But for this realm. For the Queen." },

									{ Cue = "/VO/Persephone_0328",

										SecretMusicActiveStems = { "Percussion" },
										SecretMusicMutedStems = { "WoodWinds", "Trombones" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Persephone_01", Portrait = "Portrait_Persephone_Default_01",
										PreLineAnim = "PersephoneGarden_Vulnerable", PreLineAnimTarget = 555688,
										Text = "Zagreus... If you keep fighting out of here... it shall help keep appearances that everything is as it always was." },

									{ Cue = "/VO/ZagreusHome_2681",

										SecretMusicActiveStems = { "WoodWinds" },
										SecretMusicMutedStems = { "Percussion", "Trombones" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "PlayerUnit", Portrait = "Portrait_Zag_Defiant_01",
										Text = "Question, Father. Let's say I accept. When next I reach the surface... is it still going to be you waiting up there?" },

									{ Cue = "/VO/Hades_0921",

										SecretMusicActiveStems = { "Trombones" },
										SecretMusicMutedStems = { "Percussion", "WoodWinds" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Hades_01", Portrait = "Portrait_Hades_Default_01",
										PreLineFunctionName = "HadesArmsUnCross",
										Text = "Ah, boy. If you think for an instant that I shall go easier on you because of this, you'll soon learn otherwise." },

									{ Cue = "/VO/ZagreusHome_2682",

										SecretMusicActiveStems = { "WoodWinds" },
										SecretMusicMutedStems = { "Percussion", "Trombones" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "PlayerUnit", Portrait = "Portrait_Zag_Defiant_01",
										SecretMusicSection = 3,
										Text = "So I just battle to the surface and repeatedly kill my own father, then?" },

									{ Cue = "/VO/Hades_0922",

										SecretMusicActiveStems = { "Trombones" },
										SecretMusicMutedStems = { "Percussion", "WoodWinds" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Hades_01", Portrait = "Portrait_Hades_Default_01",
										Emote = "PortraitEmoteFiredUp",
										PreLineFunctionName = "HadesArmsCross",
										Text = "You have it half-correct!" },

									{ Cue = "/VO/Persephone_0111",

										SecretMusicActiveStems = { "Percussion" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "NPC_Persephone_01", Portrait = "Portrait_Persephone_Default_01",
										Text = "Perhaps you'll also tend to my little cottage while you're in the area? The garden doesn't take much care at all. I'd like to keep the place in decent shape. In case I cannot suffer this for long." },

									{ Cue = "/VO/ZagreusHome_2683",

										SecretMusicActiveStems = { "WoodWinds" },
										SecretMusicActiveStemsDuration = 2,
										SecretMusicMutedStemsDuration = 3,

										Speaker = "PlayerUnit", Portrait = "Portrait_Zag_Default_01",
										PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
										Text = "{#DialogueItalicFormat}Hahaha{#PreviousFormat}, well! I guess I'll see what I can do." },

									{ Cue = "/VO/Persephone_0113",

										PreLineThreadedFunctionName = "EndAmbience",
										Speaker = "NPC_Persephone_01", Portrait = "Portrait_Persephone_Default_01",
										PortraitExitAnimation = "Portrait_Persephone_Default_01_Exit",
										EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
										SecretMusicSection = 10,
										PreLineFunctionName = "HadesArmsUnCross",
										PreLineAnim = "PersephoneGarden_Greeting", PreLineAnimTarget = 555688,
										Text = "Just do the best you can. And, clearly, I've work to do as well. We have a lot of it ahead of us, I'd say. So, shall we get started, then?" },

									-- to Hades Bedroom, Storyteller
									{ Cue = "/VO/ZagreusHome_3724",
										PreLineThreadedFunctionName = "PostEndingAmbience",
										Speaker = "PlayerUnit", Portrait = "Portrait_Zag_Default_01",
										PreLineFunctionName = "ViewPortraitPresentation",
										PreLineFunctionArgs = { PortraitAnimationName = "PortraitFamily", FadeInTime = 1.5, FadeOutWait = 38, PanDuration = 32,
											SecretMusic = "/Music/MusicExploration1_MC",
											PortraitGlobalVoiceLines = "StorytellerEndingVoiceLines" },
										FadeOutTime = 0.5, FullFadeTime = 2.5,
										LoadMap = "DeathAreaBedroomHades",
										-- SpawnOnId = 422138, AngleTowardHero = true,
										TeleportHeroToId = 555690, AngleHeroTowardTargetId = 421926,
										FadeInSound = "/Leftovers/Menu Sounds/EmoteAffection",
										PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
										PreLineWait = 0.35,
										-- PostLineFunctionName = "DisplayEndingMessage",
										-- PostLineFunctionArgs = { Delay = 0.5, MessageId = "GameCleared_Message01" },
										PostLineThreadedFunctionName = "KeyAchievementPresentation",
										PostLineFunctionArgs = { Title = "EndingComplete", Sound = "/Music/ARStinger_All_5" },
										-- PostLineFunctionArgs = { TextColor = Color.Red, AnimationName = "", AnimationOutName = "", TextRevealSound = "", Title = "", Text = "NPC_Eurydice_01" },
										Text = "{#DialogueItalicFormat}After all this time{#PreviousFormat}, it's only been a few days! But it's been good. Mother and Father are back together, made some new friends, got this fancy painting! Easy. All is well in the Underworld!" },
								},
							},
						},
					},
				},
			},
			{
				FunctionName = "ActivateConditionalItems",
			},
			-- hades almost always present
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
				},
				Args =
				{
					Ids = { 370006, },
				},
			},
			-- achilles in Flashback 02
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredTrueFlags = { "InFlashback", },
					RequiredTextLines = { "NyxFlashback01" },
				},
				Args =
				{
					Ids = { 370009, },
				},
			},
			-- Achilles always present for HadesBedroom first visit
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					RequiredTrueFlags = { "ZagSpecialEventInProgress" },
				},
				Args =
				{
					Types = { "NPC_Achilles_01", },
				},
			},
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					RequiredTextLinesThisRun = "AchillesAboutHadesBedroom01",
				},
				Args =
				{
					Types = { "NPC_Achilles_01", },
				},
			},
			{
				FunctionName = "SpecialEventDoorPresentation",
				GameStateRequirements =
				{
					RequiredTrueFlags = { "ZagSpecialEventInProgress" },
				},
			},

			-- Dusa Fired -- Nyx always present
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					RequiredTrueFlags = { "DusaNotYetReHired" },
				},
				Args =
				{
					Types = { "NPC_Nyx_01", },
				},
			},
			-- ending
			-- after first clear, nyx and achilles always appear
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
					RequiredTextLinesThisRun = "PersephoneFirstMeeting",
				},
				Args =
				{
					Types =
					{
						"NPC_Achilles_01",
						"NPC_Nyx_01",
					},
				},
			},
			-- nyx always appears after lord hades event
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
					RequiredAnyTextLinesThisRun = { "LordHadesAboutPersephoneMeeting02", "PersephoneMeeting05_A", "PersephoneMeeting05_B", "PersephoneMeeting06", "PersephoneMeeting07", "PersephoneMeeting09" },
				},
				Args =
				{
					Types =
					{
						"NPC_Nyx_01",
					},
				},
			},
			-- queen persephone always appears after ending01
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
					RequiredTextLinesThisRun = "PersephoneReturnsHome01",
				},
				Args =
				{
					Types =
					{
						"NPC_Persephone_Home_01",
					},
				},
			},
			-- persephone & nyx always present during OlympianReunionQuest
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredTextLines = { "PersephoneAboutOlympianReunionQuest01" },
					RequiredFalseTextLines = { "OlympianReunionQuestComplete" },
				},
				Args =
				{
					Types =
					{
						"NPC_Nyx_01",
						"NPC_Persephone_Home_01",
					},
				},
			},
			-- first run
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredMaxCompletedRuns = 0,
				},
				Args =
				{
					Types =
					{
						"NPC_Hypnos_01",
						-- "NPC_Hades_01",
						"NPC_Cerberus_01",
						"NPC_Nyx_01",
						"NPC_Achilles_01",
						-- "NPC_Dusa_01",
						-- "NPC_Orpheus_01",
						"NPC_FurySister_01",
						-- "NPC_Thanatos_01",
						-- "TrainingMelee",
					},
					ActivationCapMin = 5,
					ActivationCapMax = 5,
				},
			},
			-- before lounge opens
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
					RequiredMinCompletedRuns = 1,
					RequiredMaxCompletedRuns = 3,
				},
				Args =
				{
					Types =
					{
						"NPC_Hypnos_01",
						-- "NPC_Hades_01",
						"NPC_Cerberus_01",
						"NPC_Nyx_01",
						"NPC_Achilles_01",
						-- "NPC_Dusa_01",
						"NPC_Orpheus_01",
						"NPC_FurySister_01",
						-- "NPC_Thanatos_01",
						-- "TrainingMelee",
					},
					ActivationCapMin = 3,
					ActivationCapMax = 5,
				},
			},
			-- after lounge opens (before orpheus)
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
					RequiredFalseCosmetics = { "OrpheusUnlockItem" },
					RequiredFalseTextLines = { "Ending01" },
					RequiredMinCompletedRuns = 4,
				},
				Args =
				{
					Types =
					{
						"NPC_Hypnos_01",
						-- "NPC_Hades_01",
						"NPC_Cerberus_01",
						"NPC_Nyx_01",
						"NPC_Achilles_01",
						"NPC_Dusa_01",
						-- "NPC_Orpheus_01",
						"NPC_FurySister_01",
						"NPC_Thanatos_01",
						-- "TrainingMelee",
					},
					ActivationCapMin = 3,
					ActivationCapMax = 5,
				},
			},
			-- after orpheus
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
					RequiredCosmetics = { "OrpheusUnlockItem" },
					RequiredFalseTextLines = { "Ending01" },
					RequiredMinCompletedRuns = 4,
				},
				Args =
				{
					Types =
					{
						"NPC_Hypnos_01",
						-- "NPC_Hades_01",
						"NPC_Cerberus_01",
						"NPC_Nyx_01",
						"NPC_Achilles_01",
						"NPC_Dusa_01",
						"NPC_Orpheus_01",
						"NPC_FurySister_01",
						"NPC_Thanatos_01",
						-- "TrainingMelee",
					},
					ActivationCapMin = 4,
					ActivationCapMax = 6,
				},
			},
			-- after ending: check persephone away status
			{
				FunctionName = "CheckIsPersephoneAway",
				GameStateRequirements =
				{
					RequiredTextLines = { "PersephoneLeavesToOlympus01" },
				},
			},
			-- persephone always spawns immediately after being set to return
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredTrueFlags = { "PersephoneJustReturned", },
				},
				Args =
				{
					Ids = { 555714, },
				},
			},
			-- general NPC activation (with queen persephone present)
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", "PersephoneAway" },
					RequiredTextLines = { "Ending01" },
				},
				Args =
				{
					Types =
					{
						"NPC_Hypnos_01",
						-- "NPC_Hades_01",
						"NPC_Cerberus_01",
						"NPC_Nyx_01",
						"NPC_Achilles_01",
						"NPC_Dusa_01",
						"NPC_Orpheus_01",
						"NPC_FurySister_01",
						"NPC_Thanatos_01",
						"NPC_Persephone_Home_01",
						-- "TrainingMelee",
					},
					ActivationCapMin = 5,
					ActivationCapMax = 7,
				},
			},
			-- general NPC activation (while queen persephone is away)
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback" },
					RequiredTrueFlags = { "PersephoneAway" },
					RequiredTextLines = { "Ending01" },
				},
				Args =
				{
					Types =
					{
						"NPC_Hypnos_01",
						-- "NPC_Hades_01",
						"NPC_Cerberus_01",
						"NPC_Nyx_01",
						"NPC_Achilles_01",
						"NPC_Dusa_01",
						"NPC_Orpheus_01",
						"NPC_FurySister_01",
						"NPC_Thanatos_01",
						-- "NPC_Persephone_Home_01",
						-- "TrainingMelee",
					},
					ActivationCapMin = 4,
					ActivationCapMax = 6,
				},
			},
			-- force nyx and meg to appear for Ending
			{
				FunctionName = "ActivateAnyPrePlaced", Args = { Ids = { 370010, 390082 }, },
				GameStateRequirements =
				{
					RequiredTextLinesThisRun = "Ending01",
				},
			},
			-- force hypnos to appear for Brothers Quest
			{
				FunctionName = "ActivateAnyPrePlaced", Args = { Ids = { 370024 }, },
				GameStateRequirements =
				{
					IsIdAlive = 423052,
					RequiredTextLines = { "ThanatosAboutHypnos02" },
					RequiredFalseTextLines = { "HypnosAboutThanatos04" },
				},
			},
			{
				FunctionName = "ActivateAnyPrePlaced", Args = { Ids = { 370024 }, },
				GameStateRequirements =
				{
					RequiredTextLines = { "ThanatosWithHypnos03" },
					RequiredFalseTextLines = { "ThanatosWithHypnos07" },
				},
			},
			-- force persephone & hades to appear for Epilogue
			{
				FunctionName = "ActivateAnyPrePlaced", Args = { Ids = { 559274, 370006 }, },
				GameStateRequirements =
				{
					RequiredTextLines =
					{
						"PersephoneAboutOlympianReunionQuest01",
						"ZeusAboutOlympianReunionQuest01",
						"PoseidonAboutOlympianReunionQuest01",
						"AthenaAboutOlympianReunionQuest01",
						"AresAboutOlympianReunionQuest01",
						"AphroditeAboutOlympianReunionQuest01",
						"ArtemisAboutOlympianReunionQuest01",
						"DionysusAboutOlympianReunionQuest01",
						"DemeterAboutOlympianReunionQuest01",
						"HermesAboutOlympianReunionQuest01"
					},
					RequiredFalseTextLines =
					{
						"OlympianReunionQuestComplete"
					},
				},
			},
			-- additional start-up
			{
				FunctionName = "FadeOutIds",
				GameStateRequirements =
				{
					RequiredFalseCosmetics = { "GhostAdminDesk", },
				},
				Args =
				{
					Ids = { 210375 },
				},
			},
			{
				FunctionName = "ActivatePrePlacedObstacles",
				Args =
				{
					Groups = { "GhostWorker", "GhostLine", "GhostPatrol", "GhostBarPatrons", "GhostBartender", "GhostKitchen" },
				},
				GameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
				},
			},
			{
				FunctionName = "ActivatePrePlacedObstacles",
				Args =
				{
					Groups = { "GardenLights" },
				},
				GameStateRequirements =
				{
					RequiredTextLines = { "PersephoneReturnsHome01" },
				},
			},
			{
				FunctionName = "ActivateOneOfAPrePlacedGroupSet",
				Args =
				{
					ActivationChance = 0.7,
					Groups = { "GhostEavesdropA", "GhostEavesdropB", "GhostEavesdropC", "GhostEavesdropD", "GhostEavesdropE", "GhostEavesdropF" },
				},
				GameStateRequirements =
				{
					--RequiredMinCompletedRuns = 1,
					RequiredFalseFlags = { "InFlashback", },
				},
			},
			-- hides an in-lounge GhostInspectPoint until Lounge is open
			{
				FunctionName = "FadeOutIds",
				GameStateRequirements =
				{
					RequiredMaxCompletedRuns = 4,
				},
				Args =
				{
					Ids = { 421098 },
				},
			},
			{
				FunctionName = "UnlockDeathAreaInteractbles",
				Args = {},
			},
			{
				FunctionName = "UpdateEmployeeOfTheMonth",
				GameStateRequirements =
				{
					RequiredMinCompletedRuns = 4,
					RequiredFalseFlags = { "InFlashback", },
				},
				Args = { MinRunsPerEmployee = 1, MaxRunsPerEmployee = 3, ChangeChance = 0.5, },
			},
			{
				FunctionName = "CheckConversations",
				Args = {},
			},
			{
				FunctionName = "DisableWeapons",
				Args = {},
			},
			{
				FunctionName = "CheckDashOverride",
				Args = {},
			},
			{
				FunctionName = "StartCustomDeathAreaAmbience",
			},
		},

		ThreadedEvents =
		{
			{
				FunctionName = "FlashbackLeftBedroom",
				Args = {},
				GameStateRequirements =
				{
					RequiredTrueFlags = { "InFlashback" },
				}
			},
			{
				-- Hallway workers
				FunctionName = "PatrolPath",
				Args =
				{
					GroupName = "GhostWorker",
					NewGroupName= "ActiveGhosts",
					RemoveFromGroup = true,
					AddToGroup = true,
					MaxPatrols = 10,
					SendPatrolInterval = 0.1,
					SpeedMin = 120,
					SpeedMax = 180,
					Loop = true,
					Path =
					{

						{ Id = 393497, OffsetRadius = 200 },
						{
							Branch =
							{
								{
									{ Id = 393491, OffsetRadius = 30, },
									{
										Branch =
										{
											{
												{ Id = 393499, OffsetRadius = 10 },
												{ Id = 393485, OffsetRadius = 10, PostArriveWait = 2, EmoteOnEnd = "Smile", AngleTowardIdOnStop = 370010 },
												{ Id = 393499, OffsetRadius = 10 },
											},
											{
												{ Id = 393484, OffsetRadius = 100, },
												{ Id = 393483, OffsetRadius = 30, },
												{ Id = 424986, OffsetRadius = 30, },
												{ Id = 424987, OffsetRadius = 10, PostArriveWait = 4, EmoteOnEnd = "Smile" },
												{ Id = 424986, OffsetRadius = 30, },
												{ Id = 393483, OffsetRadius = 30, },
												{ Id = 393484, OffsetRadius = 30, },
											},
											{
												{ Id = 393499, OffsetRadius = 10 },
												{ Id = 393498, OffsetRadius = 10, PostArriveWait = 2, EmoteOnEnd = "Disgruntled" },
												{ Id = 393499, OffsetRadius = 30, },
											},
											{
												{ Id = 393493, OffsetRadius = 20, PostArriveWait = 2 },
											},
										},
									},
								},

								{
									{ Id = 393492, OffsetRadius = 10 },
									{
										Branch =
										{
											{
												{ Id = 393494, OffsetRadius = 10, PostArriveWait = 4 },
											},
											{
												{ Id = 393486, OffsetRadius = 50, },
												{
													Branch =
													{
														{
															{ Id = 393489, OffsetRadius = 10, PostArriveWait = 1.0 },
															{ Id = 393486, OffsetRadius = 10, PostArriveWait = 1.0 },

														},
														{
															{ Id = 393487, OffsetRadius = 10 },
															{ Id = 393488, OffsetRadius = 10, PostArriveWait = 3.0 },
															{ Id = 393487, OffsetRadius = 10 },
															{ Id = 393486, OffsetRadius = 10 },
														},
														{
															{ Id = 421074, OffsetRadius = 10 },
															{ Id = 393490, OffsetRadius = 10, PostArriveWait = 2.0 },
															{ Id = 421074, OffsetRadius = 10 },
															{ Id = 393486, OffsetRadius = 10 },
														},
														{
															{ Id = 421072, OffsetRadius = 10, PostArriveWait = 2.0, MinUseInterval = 2.0, EmoteOnEnd = "Smile" },
															{ Id = 393486, OffsetRadius = 10 },
														},
													},
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
			{
				-- Hades line
				FunctionName = "SetupGhostProcession",
				Args =
				{
					--ForceEligible = true,
					GhostOptionNames = { "MediumGhost01", "TallGhost01", "SmallGhost01", "TartarusGhost01", "TartarusGhost01", "TartarusGhost01", "TartarusGhost01" },
					BreakAfterNumJudgementsMin = 6,
					BreakAfterNumJudgementsMax = 15,
					BreakDurationMin = 60,
					BreakDurationMax = 120,
					Path =
					{
						{ Id = 393482, OffsetRadius = 10, SpeedMin = 200, SpeedMax = 250, },
						{
							Id = 393481,
							MinUseInterval = 2.1,
							--MinUseInterval = 12,
							SpeedMin = 200,
							SpeedMax = 250,

							-- Judgement Sequence // this turns on the V/O lines, the MinUseInterval, PostArriveWait and DestroyOnEnd values need to be flipped
							HadesJudgement = true,
							HadesJudgementPositiveChance = 0.2,

							JudgeSummoningPreWait = 0.6,
							JudgeSummoningPostWait = 1.5,
							JudgeAddressingPreWait = 0.7,
							JudgeAddressingPostWait = 3.0,

							GhostPreCaseWait = 0.4,
							GhostCaseEmotes = { "Fear", "Disgruntled", "Embarrassed" },

							JudgeListeningChance = 1.0,
							JudgeListeningPreWait = 0.6,
							JudgeListeningPostWait = 2.5,

							JudgePositiveVerdictPreWait = 2.6,
							JudgePositiveVerdictPostWait = 1.0,

							JudgeNegativeVerdictPreWait = 2.3,
							JudgeNegativeVerdictPostWait = 1.3,

							PostArriveWait = 2.0,
							--PostArriveWait = 0.1,
							DestroyOnEnd = true,
						},
					},
				},
				GameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
				},
			},

			{
				--FunctionName = "HiFiGhostPatrol",
				--Args = { },
				--GameStateRequirements = { },

				FunctionName = "PatrolPath",
				Args =
				{
					GroupName = "3DGhosts",
					NewGroupName= "Active3DGhosts",
					RemoveFromGroup = true,
					AddToGroup = true,
					MaxPatrols = 1,
					SendPatrolInterval = 2.0,
					SpeedMin = 40,
					SpeedMax = 80,
					Loop = true,
					Path =
					{
						{ Id = 391307, MinUseInterval = 7.0, SpeedMin = 20, SpeedMax = 20, PostArriveWait = 5.0, AnimateOnEnd = "3DGhostAltFidget", },
					},
				},
			},
		},

		UnthreadedEvents =
		{

		},

		RushMaxRangeOverride = 200,

		InspectPoints =
		{
			[391473] =
			{
				RequiredFalseFlags = { "InFlashback" },
				UseText = "UseGhostInspectPoint",
				RequiredMinCompletedRuns = 1,
			},

			-- misc inspect points
			[370016] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback", },
				InteractTextLineSets =
				{
					InspectHouse01 =
					{
						EndVoiceLines =
						{
							PreLineWait = 0.3,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							-- You know I can hear you, old man.
							{ Cue = "/VO/ZagreusHome_0339" },
						},
						{ Cue = "/VO/Storyteller_0119",
							Text = "{#DialogueItalicFormat}The House of Hades: That dark and lavishly appointed lair of the Underworld's King is home not just to him, but to his willful progeny." },
					},
				},
			},
			[421076] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback", },
				RequiredMinCompletedRuns = 1,
				RequiredMaxCompletedRuns = 3,
				InteractTextLineSets =
				{
					InspectLoungeClosed01 =
					{
						-- Least we can look forward to the grand reopening.
						-- Cerberus destroyed the lounge again?
						EndCue = "/VO/ZagreusHome_0409",
						EndWait = 0.3,
						{ Cue = "/VO/Storyteller_0192",
							Text = "{#DialogueItalicFormat}What once was a small lounging area within the House of Hades now is sealed off, in utter shambles since the multi-headed Cerberus tore the space apart, mourning the missing Prince." },
					},
				},
			},
			[391577] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredMinCompletedRuns = 3,
				RequiredMaxCompletedRuns = 6,
				RequiredFalseFlags = { "InFlashback", },
				InteractTextLineSets =
				{
					InspectShades01 =
					{
						-- I listen!
						EndCue = "/VO/ZagreusHome_0265",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0157",
							Text = "{#DialogueItalicFormat}Shades of the dead mill constantly within the House, complaining of their woes, and seeking audience from any who would listen." },
					},
				},
			},
			[391576] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredMinCompletedRuns = 4,
				RequiredFalseFlags = { "InFlashback", },
				RequiredTextLines = { "InspectEmployeeOfTheMonth01" },
				RequiredMaxAnyCosmetics =
				{
					Cosmetics = GameData.LoungeCosmetics,
					Count = 8,
				},
				InteractTextLineSets =
				{
					InspectLoungeOpen01 =
					{
						-- It's better than nothing.
						EndCue = "/VO/ZagreusHome_0264",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0156",
							Text = "{#DialogueItalicFormat}The lounging area within the House of Hades is a dismal place to be, in spite of its intended purpose to enliven the House's grim inhabitants." },
					},
				},
			},
			[424963] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredMinCompletedRuns = 4,
				RequiredFalseFlags = { "InFlashback", },
				InteractTextLineSets =
				{
					InspectEmployeeOfTheMonth01 =
					{
						EndVoiceLines =
						{
							PreLineWait = 0.35,
							UsePlayerSource = true,

							-- It's supposed to be updated every so often but it's always Thanatos.
							{ Cue = "/VO/ZagreusHome_0996", RequiredFalsePlayed = { "/VO/ZagreusHome_1284", "/VO/ZagreusHome_2477" }, RequiredTextLines = { "ThanatosFirstAppearance" }, RequiredFalseTextLines = { "Ending01" }, },
							-- Never made it up there myself!
							{ Cue = "/VO/ZagreusHome_1284", RequiredFalsePlayed = { "/VO/ZagreusHome_0996", "/VO/ZagreusHome_2477" }, RequiredTextLines = { "Ending01" } },
							-- Won't ever see my face up on that wall I guess.
							{ Cue = "/VO/ZagreusHome_2477", RequiredFalsePlayed = { "/VO/ZagreusHome_0996", "/VO/ZagreusHome_1284" } },
						},
						{ Cue = "/VO/Storyteller_0272",
							Text = "{#DialogueItalicFormat}A commemorative board adorns one of the stoic walls within the lounging area, celebrating and proclaiming the accomplishments of those who serve Lord Hades best of all." },
					},
				},
			},
			[370001] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				Hidden = true,
				RequiredMinCompletedRuns = 4,
				RequiredFalseFlags = { "InFlashback", },
				RequiredTextLines = { "InspectLoungeOpen01" },
				RequiredFalseTextLines = { "OlympianReunionQuestComplete" },
				InteractTextLineSets =
				{
					InspectCellar01 =
					{
						EndVoiceLines =
						{
							{
								PreLineWait = 0.45,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								-- Still waiting for the festive occasion when we'll open one of these.
								{ Cue = "/VO/ZagreusHome_3720" },
							},
						},
						{ Cue = "/VO/Storyteller_0388",
							Text = "{#DialogueItalicFormat}The ancient casks of wine hidden within the recesses of the House of Lord Hades... few have tasted the intoxicating vintage they contain, and fewer still are permitted anywhere near their vicinity." },
					},
				},
			},
			[556918] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTextLines = { "OlympianReunionQuestComplete" },
				InteractTextLineSets =
				{
					InspectCellar01 =
					{
						EndVoiceLines =
						{
							{
								PreLineWait = 0.45,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								-- They fought bravely, but Lord Dionysus was too strong.
								{ Cue = "/VO/ZagreusHome_3721" },
							},
						},
						{ Cue = "/VO/Storyteller_0413",
							Text = "{#DialogueItalicFormat}The stalwart casks of wine within the House of Hades now are almost entirely devoid of content, having bravely stood against the combined thirst of the Olympians during a certain feast." },
					},
				},
			},
			[556919] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTextLines = { "OlympianReunionQuestComplete" },
				InteractTextLineSets =
				{
					InspectOlympusSculpture01 =
					{
						EndVoiceLines =
						{
							{
								PreLineWait = 0.45,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								-- The handiwork of Lord Hephaestus, himself! Sounds like he's been rather busy.
								{ Cue = "/VO/ZagreusHome_3728" },
							},
						},
						{ Cue = "/VO/Storyteller_0414",
							Text = "{#DialogueItalicFormat}A majestic gilded edifice of Mount Olympus, crafted with the utmost care from the true mountain's stone, now shines forever brightly even in the dim light of the House of Hades, as a parting gift from the Lord Master's kin." },
					},
				},
			},			
			[427176] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				Hidden = true,
				RequiredFalseTextLinesThisRun = { "InspectHouse01" },
				RequiredFalseFlags = { "InFlashback", },
				InteractTextLineSets =
				{
					InspectMural01 =
					{
						EndVoiceLines =
						{
							{
								PreLineWait = 0.45,
								UsePlayerSource = true,
								-- He's not really that great.
								{ Cue = "/VO/ZagreusHome_1858" },
							},
							{
								PreLineWait = 0.25,
								ObjectType = "NPC_Hades_01",
								RequiresFalseHadesProcession = true,
								-- Keep it down!
								{ Cue = "/VO/Hades_0614" },
							},
						},
						{ Cue = "/VO/Storyteller_0286",
							Text = "{#DialogueItalicFormat}A vast and intricately crafted mosaic depicts the Underworld King presiding over the enormity of his domain, whilst its chthonic residents look on in awe of him." },
					},
				},
			},

			[423058] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				Hidden = true,
				RequiredDeathRoom = "D_Boss01",
				AreIdsNotAlive = { 370007 },
				RequiredFalseFlags = { "InFlashback", },
				InteractTextLineSets =
				{
					InspectThrone01 =
					{
						-- That thing doesn't look particularly comfortable.
						EndCue = "/VO/ZagreusHome_0932",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0252",
							Text = "{#DialogueItalicFormat}Seldom does the overbearing throne of grim Lord Hades sit unoccupied; thus the House's denizens all go about their business, daring not so much as to ask why." },
					},
				},
			},

			-- garden
			[556828] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTextLines = { "Ending01" },
				RequiredFalseFlags = { "InFlashback", },
				InteractTextLineSets =
				{
					InspectHouseGarden01 =
					{
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							-- Not like Mother's cottage, but not bad.
							{ Cue = "/VO/ZagreusHome_3534" },
						},
						{ Cue = "/VO/Storyteller_0405",
							Text = "{#DialogueItalicFormat}The garden of Persephone the Queen, off-limits to the Prince throughout his life, now is laid bare to him at last in all its splendor." },
					},
				},
			},

			-- Flashback 1
			[391518] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback01" },
				RequiredFalseTextLines = { "Flashback06" },
				InspectMoveIds =
				{
					[391553] = 391558,
					--[391571] = 391571,
				},
				InteractTextLineSets =
				{
					Flashback02 =
					{
						PlayOnce = true,
						-- I said, shut up, old man!
						EndCue = "/VO/ZagreusHome_0177",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0132", PostLineFunctionName = "AdvanceFlashback",
							UseableOffIds = { 391473 },
							FadeOutIds = { 391473 },
							Text = "{#DialogueItalicFormat}He ventures toward the stately throne of his Lord Father, half-expecting to be caught, but ill-expecting what he is about to find." },
					},
				},
			},
			[391542] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback02" },
				RequiredFalseTextLines = { "Flashback06" },
				InspectMoveIds =
				{
					[391553] = 391560,
					[391571] = 391470,
				},
				InteractTextLineSets =
				{
					Flashback03 =
					{
						PlayOnce = true,
						-- I'm not listening!
						EndCue = "/VO/ZagreusHome_0335",
						EndWait = 0.4,
						{ Cue = "/VO/Storyteller_0133", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}He does not know exactly what he seeks. He only knows that something always has felt off to him, that he does not belong. Who is he, really? Lord Hades never would indulge such questions. So, Prince Zagreus would find out for himself." },
					},
				},
			},
			[391517] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback03" },
				RequiredFalseTextLines = { "Flashback06" },
				InteractTextLineSets =
				{
					Flashback04 =
					{
						PlayOnce = true,
						{ Cue = "/VO/Storyteller_0134", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}He rifles through his Lord Father's possessions. There is not much of any import there. Ledgers and administrative parchmentwork. Correspondence from Olympus which he had ignored. No trace of any reference to his son." },
					},
				},
			},
			[391544] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback04" },
				RequiredFalseTextLines = { "Flashback06" },
				InspectMoveIds =
				{
					--[391553] = 391560,
					[391571] = 420897,
				},
				InteractTextLineSets =
				{
					Flashback05 =
					{
						PlayOnce = true,
						{ Cue = "/VO/Storyteller_0135", EndSecretMusic = true, SecretMusic = "/Music/MusicHadesReset2_MC", SecretMusicSection = 0, SecretMusicActiveStems = { "Guitar", }, SecretMusicMutedStems = { "Drums", "Bass" },
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}But then, there is the note... written finely in a hand and voice the likes of which the Prince had never seen or heard." },
						{ Cue = "/VO/Persephone_0018", BoxAnimation = "PersephoneLetter", BoxExitAnimation = "PersephoneLetterOut", BoxOffsetY = 120, TextOffsetX = -390,
							TextOffsetY = GetLocalizedValue(-20, {
 								{ Code = "de", Value = -65 },
 								{ Code = "pl", Value = -40 },
 								{ Code = "pt-BR", Value = -50 },
								{ Code = "it", Value = -50 },
 								{ Code = "ko", Value = -70 },
 								{ Code = "ja", Value = -40 },
 							}),
							TextWidth = 780, TextColor = Color.Black,
							Text = "{#DialogueItalicFormat}'Hades: I can no longer tolerate my life here in this place. So, I am leaving, even if it kills me. I won't be returning to Olympus. If there is a place where I belong in this world, it must be somewhere between heaven and hell. Perhaps it's on the coast and has a little garden. Take care of Cerberus; I shall miss him.'" },
						{ Cue = "/VO/Storyteller_0125",
							Text = "{#DialogueItalicFormat}Thus did Prince of the Underworld Zagreus absorb the contents of this hidden letter, written in his mother's hand." },
						{ Cue = "/VO/ZagreusHome_0178", StartSound = "/Leftovers/SFX/TextReveal", Speaker = "PlayerUnit", Portrait = "Portrait_Zag_Defiant_01", PortraitExitAnimation = "Portrait_Zag_Defiant_01_Exit", EndSecretMusic = true,
							Emote = "PortraitEmoteSurprise",
							PreLineAnim = "ZagreusTalkDenial_Full", PreLineAnimTarget = "Hero",
							Text = "His mother's hand, my mother's hand, wait, {#DialogueItalicFormat}what{#PreviousFormat}?! You're saying this Persephone, that she's my... mother...? But, but Father always said that Nyx was my.... That liar. He lied to me, they both did. All my life!" },
						{ Cue = "/VO/Storyteller_0126ALT", PostLineFunctionName = "AdvanceFlashback", PostLineSecretMusic = "/Music/MainThemeQuiet",
							Text = "{#DialogueItalicFormat}Uhhh erm thus did the Prince discover, inadvertently, the well-kept truth about his lineage. Entirely by chance, this did occur...." },
					},
				},
			},
			[391515] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback05" },
				RequiredFalseTextLines = { "Flashback06" },
				InspectMoveIds =
				{
					[391553] = 420900,
					[391571] = 420899,
				},
				InteractTextLineSets =
				{
					Flashback06 =
					{
						PlayOnce = true,
						{ Cue = "/VO/Storyteller_0128ALT", PostLineFunctionName = "AdvanceFlashback",
							Text = "{#DialogueItalicFormat}Persephone... the one-time Queen of all the Underworld... where had she gone, and why? Engulfed by newfound questions and his rage, the Prince decided to confront his Lord and Master." },
					},
				},
				OnUsedFunctionName = "ActivatePrePlaced",
				OnUsedFunctionArgs =
				{
					Types = { "NPC_Nyx_01", },
					CheckConversations = true,
				},
			},

			-- Flashback 2
			[427207] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_01" },
				InspectMoveIds =
				{
					[391553] = 391560,
					--[391571] = 391571,
				},
				InteractTextLineSets =
				{
					Flashback_DayNightJob_02 =
					{
						PlayOnce = true,
						-- Going as fast as I can, you hurry up!
						EndCue = "/VO/ZagreusHome_2116",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0304", PostLineFunctionName = "AdvanceFlashback",
							UseableOnIds = { 420896 },
							FadeInIds = { 390325 },
							Text = "{#DialogueItalicFormat}Responsibility-rejecting Zagreus strides down his Father's hall, quite unconcerned about the urgency with which he is expected to behave under a set of circumstances such as this." },
					},
				},
			},
			[427208] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_02" },
				InspectMoveIds =
				{
					[391553] = 427209,
					[391571] = 427210,
				},
				InteractTextLineSets =
				{
					Flashback_DayNightJob_03 =
					{
						PlayOnce = true,
						-- You better not give me away, old man.
						EndCue = "/VO/ZagreusHome_2117",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0305", PostLineFunctionName = "AdvanceFlashback",
							ActivateIds = { 427199, 555677 },
							UseableOffIds = { 391473, 427213 },
							FadeOutIds = { 391473, 427213 },
							Text = "{#DialogueItalicFormat}The door to the administrative chamber beckons just beyond the hall. The prince perchance believes that he may enter quietly, without drawing the notice of those laboring within." },
					},
				},
			},
			-- see DeathAreaOffice for more

			-- cosmetics inspect points
			-- pillars
			[424958] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				RequiredCosmetics = { "Cosmetic_HousePillars", },
				InteractTextLineSets =
				{
					Inspect_HousePillars_01 =
					{
						PlayOnce = true,
						-- I guess there are a lot of gemstones here.
						EndCue = "/VO/ZagreusHome_0993",
						EndWait = 0.4,
						{ Cue = "/VO/Storyteller_0269",
							Text = "{#DialogueItalicFormat}Among the countless splendid gemstones hidden underneath the earth, a great many are used to decorate the House of Hades, god of the dead, god of riches." },
					},
				},
			},
			-- north fountain
			[424960] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				RequiredCosmetics = { "Cosmetic_NorthHallFountain", },
				InteractTextLineSets =
				{
					Inspect_NorthFountain_01 =
					{
						PlayOnce = true,
						-- Now I feel bad.
						EndCue = "/VO/ZagreusHome_0994",
						EndWait = 0.55,
						{ Cue = "/VO/Storyteller_0270",
							Text = "{#DialogueItalicFormat}Water is the source of life, yet still it flows within the darkest Underworld recesses, whilst restless shades of mortals look upon it and recall the short days they could drink it and draw breath." },
					},
				},
			},
			-- south fountain
			[424961] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				RequiredCosmetics = { "Cosmetic_SouthHallFountain", },
				InteractTextLineSets =
				{
					Inspect_SouthFountain_01 =
					{
						PlayOnce = true,
						-- Ever since? It's not been that long.
						EndCue = "/VO/ZagreusHome_0995",
						EndWait = 0.45,
						{ Cue = "/VO/Storyteller_0271",
							Text = "{#DialogueItalicFormat}The gemstone-bearing Prince commissioned such a finely crafted fountain for the House, that all the shades who witnessed it still think of him quite fondly, ever since." },
					},
				},
			},
			-- cauldron
			[424962] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				RequiredCosmetics = { "Cosmetic_KitchenStoveCauldron", },
				InteractTextLineSets =
				{
					Inspect_Cauldron_01 =
					{
						PlayOnce = true,
						-- I wish I did not know that.
						EndCue = "/VO/ZagreusHome_0997",
						EndWait = 0.4,
						{ Cue = "/VO/Storyteller_0273",
							Text = "{#DialogueItalicFormat}The dead have utterly no use for sustenance, although they try to feast upon it anyway, as though imagining the customs of the mortal life brings them some sense of peace." },
					},
				},
			},
			-- kitchen island
			[425000] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				RequiredCosmetics = { "Cosmetic_KitchenIsland", },
				InteractTextLineSets =
				{
					Inspect_KitchenIsland =
					{
						PlayOnce = true,
						-- It's all right, wasn't hungry anyway.
						EndCue = "/VO/ZagreusHome_1315",
						EndWait = 0.45,
						{ Cue = "/VO/Storyteller_0274",
							Text = "{#DialogueItalicFormat}Having invested heavily into the cooking-area within the House of Hades, the empty-stomached Zagreus can nonetheless find nothing fit to eat." },
					},
				},
			},

			-- poet bust
			[427177] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				RequiredCosmetics = { "Cosmetic_NorthHallBust", },
				InteractTextLineSets =
				{
					Inspect_PoetBust_01 =
					{
						PlayOnce = true,
						-- Never heard of him.
						EndCue = "/VO/ZagreusHome_1900",
						EndWait = 0.45,
						{ Cue = "/VO/Storyteller_0290",
							Text = "{#DialogueItalicFormat}Within the House's gallery now sits the bust of a distinguished poet, ruggedly handsome in his age, who, although yet to earn his fated fame, shall probably be better known someday." },
					},
				},
			},
			-- asphodel statue
			[427178] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				RequiredCosmetics = { "Cosmetic_NorthHallPedestalBust", },
				InteractTextLineSets =
				{
					Inspect_AsphodelStatue_01 =
					{
						PlayOnce = true,
						-- I could take him.
						EndCue = "/VO/ZagreusHome_1903",
						EndWait = 0.45,
						{ Cue = "/VO/Storyteller_0293",
							Text = "{#DialogueItalicFormat}The frightful countenance of a bleached Bloodless warrior decorates the hall forever more, eternally in tribute to the savage servants of the House's lord." },
					},
				},
			},
			-- warrior statue
			[427179] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				RequiredCosmetics = { "Cosmetic_NorthHallWarriorStatue", },
				InteractTextLineSets =
				{
					Inspect_WarriorStatue_01 =
					{
						PlayOnce = true,
						-- He sure looks tall...
						EndCue = "/VO/ZagreusHome_1906",
						EndWait = 0.45,
						{ Cue = "/VO/Storyteller_0296",
							Text = "{#DialogueItalicFormat}The perfect-chiseled physicality of one of Greece's greatest-ever heroes now adorns the House's gallery, reminding most onlookers of many ways in which they fail to compare." },
					},
				},
			},
			-- lounge fireplace
			[555808] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				RequiredCosmetics = { "Cosmetic_LoungeFireplace" },
				InteractTextLineSets =
				{
					Inspect_MainHallFireplace01 =
					{
						PlayOnce = true,
						-- It's really quite cozy.
						EndCue = "/VO/ZagreusHome_2856",
						EndWait = 0.55,
						{ Cue = "/VO/Storyteller_0364",
							Text = "{#DialogueItalicFormat}The light provided by the flames of deepest hell enhances the lounging area with a soft glow; and their warmth soothes the few living denizens there." },
					},
				},
			},
			-- sundial
			[555809] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				RequiredCosmetics = { "Cosmetic_NorthHallSundial" },
				InteractTextLineSets =
				{
					Inspect_Sundial01 =
					{
						PlayOnce = true,
						-- Looks like it's 7:48...
						EndCue = "/VO/ZagreusHome_2857",
						EndWait = 0.55,
						{ Cue = "/VO/Storyteller_0365",
							Text = "{#DialogueItalicFormat}Time seems to stand quite still within the eternal realm of the dead, evidenced even by the means of measuring its passage." },
					},
				},
			},

		},

		ObstacleData =
		{
			-- Ghost Secretary / GhostAdmin / Ghost Admin / House Contractor
			-- note: this is the desk itself
			[210158] =
			{
				Name = "GhostAdmin",
				InteractDistance = 200,
				UseText = "UseGhostAdmin",
				OnUsedFunctionName = "UseGhostAdmin",
				AnimOffsetZ = 250,
				--DestroyIfNotSetup = true,
				NoSaleEmote = "StatusIconEyeRoll",
				NoSaleEmoteTargetId = 427173,
				MadeSaleEmote = "StatusIconSmile",
				MadeSaleEmoteTargetId = 427173,
				-- EmoteOffsetZ = 50,
				SetupGameStateRequirements =
				{
					RequiredMinCompletedRuns = 1,
					RequiredFalseFlags = { "InFlashback", },
				},
				SetupFunctions =
				{
					{ Name = "ActivateAnyPrePlaced", Args = { Ids = { 425703, 425709, 421735, 425708, 427174, 427173, 427175, }, }, },
					{
						Name = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							RequiredScreenViewedFalse = "GhostAdmin",
							RequiredFalseFlags = { "InFlashback", },
						},
					},
					{
						Name = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							AnyAffordableGhostAdminItem = "Critical",
							RequiredFalseFlags = { "InFlashback", },
						},
					},
				},
			},
			-- Contractor Coffee Fizz
			[210375] =
			{
				SetupGameStateRequirements =
				{
					RequiredCosmetics = { "GhostAdminDesk" },
				},
				DestroyIfNotSetup = true,
			},
			-- Ghost Admin Character / Ghost Secretary Character / House Contractor
			[427173] =
			{
				Name = "GhostAdminCharacter",
				EmoteOffsetZ = 125,
				DistanceTrigger =
				{
					WithinDistance = 600,
					Emote = "StatusIconFear",
					TriggerOnceThisRun = true,
				},
			},
			-- Market / Trade/ Exchange / Ghost Broker / Wretched Broker
			[423390] =
			{
				Name = "Market",
				InteractDistance = 150,
				InteractOffsetX = -225,
				InteractOffsetY = -100,
				UseText = "UseMarket",
				-- UseSound = "/Leftovers/World Sounds/CaravanCreak",
				OnUsedFunctionName = "UseMarketObject",
				NoSaleEmote = "StatusIconDisgruntled",
				MadeSaleEmote = "StatusIconSmile",
				EmoteOffsetZ = 100,
				SetupGameStateRequirements =
				{
					RequiredMinCompletedRuns = 4,
				},
				DistanceTriggers =
				{
					{
						WithinDistance = 600,
						Emote = "StatusIconOhBoy",
						TriggerOnceThisRun = true,
					},
					{
						WithinDistance = 100,
						Repeat = true,
						VoiceLines =
						{
							BreakIfPlayed = true,
							RandomRemaining = true,
							CooldownTime = 20,
							UsePlayerSource = true,

							-- Pardon.
							{ Cue = "/VO/ZagreusHome_0663" },
							-- Pardon me!
							{ Cue = "/VO/ZagreusHome_0664" },
							-- Oop my mistake.
							{ Cue = "/VO/ZagreusHome_0665" },
							-- Excuse me.
							{ Cue = "/VO/ZagreusHome_0666" },
							-- Beg your pardon.
							{ Cue = "/VO/ZagreusHome_0667" },
							-- Sorry.
							{ Cue = "/VO/ZagreusHome_0668" },
							-- Sorry!
							{ Cue = "/VO/ZagreusHome_0669" },
							-- My fault.
							{ Cue = "/VO/ZagreusHome_0670" },
						},
					},
				}
			},
			-- Lounge Ambience Generator
			[425014] =
			{
				SetupGameStateRequirements =
				{
					RequiredMinCompletedRuns = 4,
					RequiredFalseFlags = { "InFlashback", },
				},
				DestroyIfNotSetup = true,
			},
			-- Ghost Chef / House Chef
			[423399] =
			{
				Name = "GhostChefCharacter",
				UseText = "Fishing_ChefInteract",
				OnUsedFunctionName = "TurnInFish",
				EmoteOffsetZ = 290,
				AnimOffsetZ = 375,
				SetupFunctions =
				{
					{
						Name = "DisableObjects",
						Args = { Type = "ChefGhost01" },
						GameStateRequirements =
						{
							RequiredFalseFlags = { "InFlashback", },
							RequiredHasNoFish = true,
						},

					},
					{
						Name = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalk", },
						GameStateRequirements =
						{
							RequiredFalseFlags = { "InFlashback", },
							RequiredHasFish = true,
						},
					},
				},
				DistanceTriggers =
				{
					{
						WithinDistance = 500,
						Emote = "StatusIconEmbarrassed",
						TriggerOnceThisRun = true,
					},
					{
						WithinDistance = 350,
						Repeat = true,
						VoiceLines =
						{
							BreakIfPlayed = true,
							RandomRemaining = true,
							CooldownTime = 8,
							PlayOnceFromTableThisRun = true,
							UsePlayerSource = true,
							SuccessiveChanceToPlay = 0.33,

							-- What's cooking?
							{ Cue = "/VO/ZagreusHome_1291", RequiredPlayed = { "/VO/ZagreusHome_1294" } },
							-- Head Chef.
							{ Cue = "/VO/ZagreusHome_1292", RequiredPlayed = { "/VO/ZagreusHome_1294" } },
							-- Chef.
							{ Cue = "/VO/ZagreusHome_1293", RequiredPlayed = { "/VO/ZagreusHome_1294" } },
							-- Greetings, Chef.
							{ Cue = "/VO/ZagreusHome_1294" },
							-- What's for breakfast?
							{ Cue = "/VO/ZagreusHome_1295", RequiredPlayed = { "/VO/ZagreusHome_1294" } },
							-- What's for breakfast? Dinner maybe?
							{ Cue = "/VO/ZagreusHome_1296", RequiredPlayed = { "/VO/ZagreusHome_1294" } },
							-- Something smells good.
							{ Cue = "/VO/ZagreusHome_1297", RequiredPlayed = { "/VO/ZagreusHome_1294" } },
							-- How's that knife set working out?
							{ Cue = "/VO/ZagreusHome_1298", RequiredCosmetics = { "Cosmetic_Knives", }, RequiredPlayed = { "/VO/ZagreusHome_1294" } },
							-- Those spices working out all right?
							{ Cue = "/VO/ZagreusHome_1299", RequiredCosmetics = { "Cosmetic_SpiceRack", }, RequiredPlayed = { "/VO/ZagreusHome_1294" } },
							-- Cooking's one way to pass the time.
							{ Cue = "/VO/ZagreusHome_1300", RequiredPlayed = { "/VO/ZagreusHome_1294" } },
						},
					}
				},
			},

			-- Employee of the Month
			[423452] =
			{
				UseText = "UseEmployeeSign01",
				OnUsedGameStateRequirements =
				{
					-- RequiredFalseFlags = { "InFlashback" },
					RequiredTextLines = { "InspectEmployeeOfTheMonth01" },
				},
				OnUsedFunctionName = "UseEmployeeSign",
				OnUsedFunctionArgs = { },
				DisableIfUnuseable = true,
				InteractDistance = 190,
				InteractOffsetY = 60,
				InteractOffsetX = -150,
			},

			-- DeathArea Cosmetics
			-- Poet Bust
			[425947] =
			{
				UseText = "UsePoetBust01",
				OnUsedFunctionName = "UsePoetBust",
			},

			-- Asphodel Statue
			[426443] =
			{
				UseText = "UseStatue01",
				OnUsedFunctionName = "UseStatue",
			},

			-- Warrior Statue
			[426368] =
			{
				UseText = "UseStatue01",
				OnUsedFunctionName = "UseStatue",
			},

			-- Mechanism
			[426321] =
			{
				UseText = "UseStatue01",
				OnUsedFunctionName = "UseStatue",
			},

			-- Sundial
			-- see ConditionalItemData
			-- Bedroom Door
			[391697] =
			{
				Name = "BedroomDoor",
				OnUsedGameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", "ZagSpecialEventInProgress", },
				},
				OnUsedFunctionName = "DeathAreaSwitchRoom",
				OnUsedFunctionArgs = { Name = "DeathAreaBedroom", HeroStartPoint = 40009, HeroEndPoint = 40012, },
				InteractDistance = 140,
				AutoActivate = true,
				DistanceTrigger =
				{
					WithinDistance = 500,
					VoiceLines =
					{
						PlayOnce = true,
						RequiredTrueFlags = { "ZagSpecialEventInProgress" },
						TriggerCooldowns =
						{
							{ Name = "ZagreusMiscHouseSpeech", Time = 10 },
						},
						-- No. Can't go this way just yet...
						{ Cue = "/VO/ZagreusHome_3671", Queue = "Always" },
					},
					FunctionName = "HandleAchillesBedroomObjective"
				}
			},
			[391025] =
			{
				SetupGameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
					AreIdsNotAlive = { 390000 },
				},
				UseText = "UseChair",
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				ShakeSelf = true,
				OnUsedGlobalVoiceLines = "TakeASeatVoiceLines",
				InteractDistance = 110,
				InteractOffsetY = 10,
			},
			[210467] =
			{
				SetupGameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
				},
				UseText = "UseChair",
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				ShakeSelf = true,
				OnUsedGlobalVoiceLines = "TakeASeatVoiceLines",
				InteractDistance = 110,
				InteractOffsetY = 10,
			},
			[210075] =
			{
				UseText = "UseChair",
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				ShakeSelf = true,
				OnUsedGlobalVoiceLines = "TakeASeatVoiceLines",
				InteractDistance = 110,
				InteractOffsetY = 10,
			},
			[210353] =
			{
				UseText = "UseChair",
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				ShakeSelf = true,
				OnUsedGlobalVoiceLines = "TakeASeatVoiceLines",
				InteractDistance = 110,
				InteractOffsetY = 10,
			},
			-- Hades Throne
			[422028] =
			{
				UseText = "UseChair",
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				ShakeSelf = true,
				ShakeIds = { 426236, 422027 },
				OnUsedGlobalVoiceLines = "UsedThroneVoiceLines",
				InteractDistance = 180,
				InteractOffsetY = -50,
				InteractOffsetX = 40,
				SetupGameStateRequirements =
				{
					AreIdsNotAlive = { 370006 },
					RequiredFalseFlags = { "InFlashback" },
				},
			},
			-- Garden Entrance
			[555445] =
			{
				Name = "GardenEntrance",
				DistanceTriggers =
				{
					{
						WithinDistance = 1500,
						VoiceLines =
						{
							{
								PlayOnceFromTableThisRun = true,
								RandomRemaining = true,
								UsePlayerSource = true,
								RequiredTextLines = { "Ending01" },
								Cooldowns =
								{
									{ Name = "ZagreusGardenSpeech", Time = 20 },
								},
								-- The garden's always open now...
								{ Cue = "/VO/ZagreusHome_3723", PlayOnce = true, },
								-- Should check the garden.
								{ Cue = "/VO/ZagreusHome_3722", RequiredAnyQueuedTextLines = GameData.GardenTextLines, ChanceToPlayAgain = 0.66 },
							},
						},
					},
				}
			},
			-- Garden Tree
			[556400] =
			{
				Name = "GardenTree",
				DistanceTriggers =
				{
					{
						WithinDistance = 700,
						VoiceLines =
						{
							PlayOnceFromTableThisRun = true,
							RandomRemaining = true,
							SuccessiveChanceToPlay = 0.25,
							UsePlayerSource = true,
							RequiredTextLines = { "Ending01" },
							Cooldowns =
							{
								{ Name = "ZagreusGardenSpeech", Time = 20 },
							},

							-- <Inhale... Exhale>
							{ Cue = "/VO/ZagreusHome_3607", RequiredPlayed = { "/VO/ZagreusHome_3610" } },
							-- <Deep Breath>
							{ Cue = "/VO/ZagreusHome_3608", RequiredPlayed = { "/VO/ZagreusHome_3610" } },
							-- Can't believe Father kept this place locked up...
							{ Cue = "/VO/ZagreusHome_3609", RequiredPlayed = { "/VO/ZagreusHome_3610" } },
							-- <Sigh> It's nice here...
							{ Cue = "/VO/ZagreusHome_3610" },
							-- Pom trees are coming in nicely.
							{ Cue = "/VO/ZagreusHome_3611", RequiredPlayed = { "/VO/ZagreusHome_3610" } },
							-- Mother's taken good care of this place since she got back.
							{ Cue = "/VO/ZagreusHome_3612", RequiredPlayed = { "/VO/ZagreusHome_3610" } },
							-- Peace and quiet...
							{ Cue = "/VO/ZagreusHome_3613", RequiredPlayed = { "/VO/ZagreusHome_3610" } },
							-- ...I like it here.
							{ Cue = "/VO/ZagreusHome_3614", RequiredPlayed = { "/VO/ZagreusHome_3610" } },
						},
					},
				}
			},
			-- Olympus Statue / Olympus Sculpture / EpilogueReunionQuest
			[556697] =
			{
				Name = "HouseStatueMtOlympus01",
				UseText = "UseShrinePointClear_QuestCleared",
				OnUsedFunctionName = "UseOlympusSculpture",

				SetupGameStateRequirements =
				{
					RequiredTextLines = { "OlympianReunionQuestComplete" },
				},
				Activate = true,
				DistanceTriggers =
				{
					{
						WithinDistance = 1200,
						VoiceLines =
						{
							PlayOnce = true,
							UsePlayerSource = true,
							-- Still can't get over our gift from the Olympians. It's glorious!
							{ Cue = "/VO/ZagreusHome_3688" },
						},
					},
				}
			},
		}
	},

	DeathAreaBedroom =
	{
		ZoomFraction = 1.0,
		SoftClamp = 0.75,

		AmbientMusicParams =
		{
			LowPass = 1.0,
			Vocals = 1.0,
		},
		AmbientMusicVolume = 1.0,
		Ambience = "/Ambience/MusicExploration4Ambience",

		RemoveDashFireFx = true,
		IgnoreStemMixer = true,
		IntroSequenceDuration = 0.5,
		DebugOnly = true,
		LinkedRoom = "RoomOpening",
		NoAutoEquip = true,
		ShowResourceUIOnly = true,
		FullscreenEffectGroup = "Foreground_01",
		SkipWeaponBinkPreLoading = true,
		RichPresence = "#RichPresence_Bedroom",

		LegalEncounters = { "Empty", },

		ReverbValue = 2.0,

		FailedToFireFunctionName = "DeathAreaAttackFailPresentation",

		CheckObjectives = { "MetaPrompt", "BedPrompt" },

		StartUnthreadedEvents =
		{
			{
				FunctionName = "ActivateBedroomConditionalItems",
			},
			-- Meg (Bedroom) / Meg in Bedroom / Bedroom Scenes
			-- variant tbd below for Megaera max relationship
			-- alt ids: { 422142 (m), 422255 (t), }
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredNotActivatedThisRun = 390082,
					RequiredFalseTextLinesThisRun = { "Ending01" },
					RequiredAnyKillsThisRun = { "Harpy", "Harpy2" },
					RequiredTextLines = { "MegaeraGift04" },
					RequiredFalseTextLines = { "MegaeraBedroom01" },
					AreIdsNotAlive = { 422255 },
				},
				BreakIfPlayed = true,
				Args =
				{
					Ids = { 422142, },
					DistanceTrigger =
					{
						WithinDistance = 1000,
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.85,
									UsePlayerSource = true,

									-- Um, Meg...?
									{ Cue = "/VO/ZagreusHome_0184" },
								},
								{
									PreLineWait = 0.35,
									BreakIfPlayed = true,
									PostLineWait = 0.65,

									-- Hmm.
									{ Cue = "/VO/MegaeraHome_0061" },
								},
							},
							TextLineSet =
							{
								MegaeraBedroom01 =
								{
									-- requirements are above
									{ Cue = "/VO/ZagreusHome_0754", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
										AngleHeroTowardSource = true,
										Text = "Meg. {#DialogueItalicFormat}Oh{#PreviousFormat}. I was not expecting company. Were you, just, casually snooping, or... is there something I can help you with?" },
									{ Cue = "/VO/MegaeraHome_0010",
										PostLineFunctionName = "ExitNPCPresentation", PostLineFunctionArgs = { ObjectId = 422142, TeleportToId = 421563 },
										PortraitExitAnimation = "Portrait_FurySister01_Standoffish_01_Exit",
										PreLineWait = 0.35,
										PreLineAnim = "FuryIdleInHouseFidgetGreeting",
										Text = "...I was just leaving, Zagreus. Happened to be in the area, no thanks to you, and thought I'd go retrieve the last of my possessions. I have to say, you've really let this place go to hell." },
									{ Cue = "/VO/ZagreusHome_0755", PreLineWait = 1.85, Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
										Text = "...She left. Great. Wonderful! I guess we'll just go back to killing each other repeatedly, then." },
								},
							},
						},
					},
				},
			},

			-- Meg (Bedroom) / Meg in Bedroom / Bedroom Scenes
			-- variant below for if you've cleared the game already
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredNotActivatedThisRun = 390082,
					-- RequiredAnyKillsThisRun = { "Harpy", "Harpy2" },
					RequiredTextLines = { "Fury2FirstAppearance", "Fury3FirstAppearance" },
					RequiredAnyTextLines = { "MegaeraBuildingTrust01", "MegaeraBuildingTrust01_B" },
					RequiredFalseTextLinesThisRun = { "Ending01" },
					RequiredFalseTextLinesLastRun = { "MegaeraBuildingTrust01", "MegaeraBuildingTrust01_B" },
					RequiredFalseTextLines = { "MegaeraBedroom02", "MegaeraBedroom02B" },
					RequiredRunsCleared = 0,
					AreIdsNotAlive = { 422255 },
				},
				BreakIfPlayed = true,
				Args =
				{
					Ids = { 422142, },
					DistanceTrigger =
					{
						WithinDistance = 1000,
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.85,
									UsePlayerSource = true,

									-- ...Oh.
									{ Cue = "/VO/ZagreusHome_0818" },
								},
								{
									PreLineWait = 0.35,
									BreakIfPlayed = true,
									PostLineWait = 0.65,

									-- Zagreus.
									{ Cue = "/VO/MegaeraHome_0058" },
								},
							},
							TextLineSet =
							{
								MegaeraBedroom02 =
								{
									-- requirements are above
									{ Cue = "/VO/ZagreusHome_0759", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
										PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
										PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
										AngleHeroTowardSource = true,
										Text = "Forget another something in my bedchambers, there, Meg?" },
									{ Cue = "/VO/MegaeraHome_0090",
										Text = "No. We need to talk, again. My sisters are involved now, in all this. You've really stirred up quite a mess." },
									{ Cue = "/VO/ZagreusHome_0760", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
										Text = "I'm sorry. My mother's out there, somewhere. I won't rest until I can find her. You wouldn't understand." },
									{ Cue = "/VO/MegaeraHome_0091",
										Text = "You wouldn't know. What I'm trying to say is... with my sisters involved, it changes things. Takes some of the pressure off of me." },
									{ Cue = "/VO/ZagreusHome_0761", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
										PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
										PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
										Text = "What are you saying?" },
									{ Cue = "/VO/MegaeraHome_0092",	PostLineFunctionName = "ExitNPCPresentation", PostLineFunctionArgs = { ObjectId = 422142, TeleportToId = 421563 },
										PortraitExitAnimation = "Portrait_FurySister01_Standoffish_01_Exit",
										Text = "I'm saying... I know you need to find your mother, Zagreus. I have my part to play in all of this, but let me see what I can do, if anything." },
									{ Cue = "/VO/ZagreusHome_1354", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
										Text = "Meg...! She... {#DialogueItalicFormat}ah{#PreviousFormat}." },
								},
							},
						},
					},
				},
			},

			-- Meg (Bedroom) / Meg in Bedroom / Bedroom Scenes
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredNotActivatedThisRun = 390082,
					-- RequiredAnyKillsThisRun = { "Harpy", "Harpy2" },
					RequiredTextLines = { "Fury2FirstAppearance", "Fury3FirstAppearance" },
					RequiredAnyTextLines = { "MegaeraBuildingTrust01", "MegaeraBuildingTrust01_B" },
					RequiredFalseTextLines = { "MegaeraBedroom02", "MegaeraBedroom02B" },
					RequiredFalseTextLinesThisRun = { "Ending01" },
					RequiredMinRunsCleared = 1,
					RequiredFalseTextLinesLastRun = { "MegaeraBuildingTrust01", "MegaeraBuildingTrust01_B" },
					AreIdsNotAlive = { 422255 },
				},
				BreakIfPlayed = true,
				Args =
				{
					Ids = { 422142, },
					DistanceTrigger =
					{
						WithinDistance = 1000,
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.85,
									UsePlayerSource = true,

									-- ...Oh.
									{ Cue = "/VO/ZagreusHome_0818" },
								},
								{
									PreLineWait = 0.35,
									BreakIfPlayed = true,
									PostLineWait = 0.65,

									-- Zagreus.
									{ Cue = "/VO/MegaeraHome_0058" },
								},
							},
							TextLineSet =
							{
								MegaeraBedroom02B =
								{
									-- requirements are above
									{ Cue = "/VO/ZagreusHome_0759", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
										PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
										PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
										AngleHeroTowardSource = true,
										Text = "Forget another something in my bedchambers, there, Meg?" },
									{ Cue = "/VO/MegaeraHome_0090",
										Text = "No. We need to talk, again. My sisters are involved now, in all this. You've really stirred up quite a mess." },
									{ Cue = "/VO/ZagreusHome_1495", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
										Text = "I know. I'm sorry. But this is something that I have to do. You wouldn't understand." },
									{ Cue = "/VO/MegaeraHome_0091",
										Text = "You wouldn't know. What I'm trying to say is... with my sisters involved, it changes things. Takes some of the pressure off of me." },
									{ Cue = "/VO/ZagreusHome_1353", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
										PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
										PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
										Text = "Some of the pressure... wait, what are you going to do?" },
									{ Cue = "/VO/MegaeraHome_0139",	PostLineFunctionName = "ExitNPCPresentation", PostLineFunctionArgs = { ObjectId = 422142, TeleportToId = 421563 },
										PortraitExitAnimation = "Portrait_FurySister01_Standoffish_01_Exit",
										Text = "I'm saying... I know you're doing what you have to do, here, Zagreus. And, my sisters and I will always try to stop you. But I am only doing it because I have to. Understand?" },
									{ Cue = "/VO/ZagreusHome_1354", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
										Text = "Meg...! She... {#DialogueItalicFormat}ah{#PreviousFormat}." },
								},
							},
						},
					},
				},
			},

			-- Meg (Bedroom) / Meg in Bedroom / Bedroom Scenes / Meg Relationship / max relationship
			-- variant tbd below for Thanatos max relationship
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredNotActivatedThisRun = 390082,
					-- RequiredAnyKillsThisRun = { "Harpy", "Harpy2" },
					RequiredTextLines = { "MegaeraGift10" },
					RequiredFalseTextLines = { "BecameCloseWithMegaera01", "BecameCloseWithMegaera01_B", "BecameCloseWithThanatos01Than_GoToHim" },
					AreIdsNotAlive = { 422255 },
					RequiredFalseTextLinesThisRun = { "BecameCloseWithThanatos01", "BecameCloseWithThanatos01_B", "BecameCloseWithDusa01", "Ending01" },
					RequiredFalseSeenRoomThisRun = "A_Boss01",
					RequiredFalseQueuedTextLines = { "BecameCloseWithDusa01", "ThanatosHomeIntermissionChat01", "ThanatosHomeIntermissionChat02", "ThanatosHomeIntermissionChat03", "ThanatosHomeIntermissionChat04", "ThanatosHomeIntermissionChat05", "ThanatosHomeIntermissionChat06" },
				},
				BreakIfPlayed = true,
				Args =
				{
					Ids = { 422142, },
					DistanceTrigger =
					{
						WithinDistance = 1000,
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.75,
									BreakIfPlayed = true,
									PostLineWait = 0.15,
									ObjectType = "NPC_FurySister_01",

									-- Come here.
									{ Cue = "/VO/MegaeraHome_0195" },
								},

							},
							TextLineSet =
							{
								BecameCloseWithMegaera01 =
								{
									EndGlobalVoiceLines = "PostBedroomIntermissionVoiceLines",
									-- requirements are above
									{ Cue = "/VO/ZagreusHome_1370", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
										PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
										PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
										AngleHeroTowardSource = true,
										AngleTowardTargetId = 390058,
										-- Emote = "PortraitEmoteSurprise",
										Text = "Meg... what a surprise. Again. What is it? ...What's the matter? Wait. Why are you looking at me like that?" },

									{ Cue = "/VO/MegaeraHome_0152",
										PreLineAnim = "FuryIdleInHouseFidgetWhipTaunt_Start",
										Text = "Zagreus, would you shut up already with your idiotic questions, and get over here? Right now." },

									{ Cue = "/VO/ZagreusHome_1371", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
										PortraitExitAnimation = "Portrait_Zag_Empathetic_01_Exit",
										PreLineWait = 0.35,
										Emote = "PortraitEmoteSurprise",
										Text = "...I... you really... oh..." },

									{ Text = "Megaera_ChoiceText01",
										Choices =
										{
											{
												ChoiceText = "Meg_GoToHer",
												{ Cue = "/VO/ZagreusHome_2804", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PostLineAnim = "FuryIdleInHouseFidgetWhipTaunt_ReturnToIdle",
													PreLineThreadedFunctionName = "BedroomIntermissionApproach",
													PortraitExitAnimation = "Portrait_Zag_Default_01_Exit",
													PostLineThreadedFunctionName = "BedroomIntermissionPresentation",
													PostLineFunctionArgs = { ExtraWaitTime = 1.2 },
													PreLineWait = 0.35,
													Text = "...I thought you'd never ask. But I'm glad you did." },
												-- intermission
												{ Cue = "/VO/ZagreusHome_1372", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
													PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
													FadeOutTime = 0.5, FadeOutSound = "/Leftovers/World Sounds/MapText", FullFadeTime = 9.5,
													FadeInTime = 2.5, FadeInSound = "/Leftovers/Menu Sounds/EmoteAffection",
													PreLineWait = 0.4,
													InterSceneWaitTime = 0.5,
													AngleTowardHero = true,	TeleportHeroToId = 422138,
													TeleportHeroOffsetX = 100, TeleportHeroOffsetY = 170,
													AngleHeroTowardSource = true,
													Text = "Um, Meg, I... what I'm trying to say is, are you... are we good, or...?" },

												{ Cue = "/VO/MegaeraHome_0153", Portrait = "Portrait_FurySister01_Pleased_01",
													PreLineAnim = "FuryIdleInHouseFidgetGreeting",
													Text = "Stop being insecure around me, Zag. You should know better than that by now. Though, yes, if you must know... I think we're good. But if you tell another living soul, or even a dead one, I will kill you, understand?" },

												{ Cue = "/VO/ZagreusHome_1373", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
													PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
													Text = "I... loud and clear, Meg, yes, I understand. So then... what happens now?" },

												{ Cue = "/VO/MegaeraHome_0154", Portrait = "Portrait_FurySister01_Pleased_01",
													Text = "What happens now? I'll see you at the edge of Tartarus, I guess. Or maybe here. However long we keep this up." },

												{ Cue = "/VO/ZagreusHome_1374", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
													PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
													Text = "However long we keep this up?" },

												{ Cue = "/VO/MegaeraHome_0155", Portrait = "Portrait_FurySister01_Standoffish_01",
													PostLineFunctionName = "ExitNPCPresentation", PostLineFunctionArgs = { ObjectId = 422142, TeleportToId = 421563 },
													PortraitExitAnimation = "Portrait_FurySister01_Standoffish_01_Exit",
													Text = "You ask too many questions, Zag. I don't have the answers, and besides: You know more about living in the moment than I do. See you around." },

												{ Cue = "/VO/ZagreusHome_1375", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PreLineAnim = "ZagreusTalkEmpathy_Return", PreLineAnimTarget = "Hero",
													PreLineWait = 0.35,
													Text = "...See you around! ...Yes." },
											},
											{
												ChoiceText = "Meg_BackOff",
												{ Cue = "/VO/ZagreusHome_1521", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
													PreLineAnim = "FuryIdleInHouseFidgetWhipTaunt_ReturnToIdle",
													PreLineWait = 0.35,
													Text = "...I... Meg, I'm deeply flattered, and you're very dear to me, it's just... this isn't what I want from our relationship. I fear I must have led you on. Forgive me. Please say you'll still be my friend?" },
												{ Cue = "/VO/MegaeraHome_0390", Portrait = "Portrait_FurySister01_Pleased_01",
													PortraitExitAnimation = "Portrait_FurySister01_Pleased_01_Exit", PreLineWait = 0.8,
													PostLineFunctionName = "ExitNPCPresentation", PostLineFunctionArgs = { ObjectId = 422142, TeleportToId = 421563 },
													Text = "...That's all you really want...? To be my friend? {#DialogueItalicFormat}Heh. {#PreviousFormat}You're hard to figure out sometimes, Zag. But, you know what, we've tried a lot of things. Why don't we try it like you said? I'll see you out there, then." },
											},
										},
									},
								},
							},
						},
					},
				},
			},

			-- Meg (Bedroom) / Meg in Bedroom / Bedroom Scenes / Meg Relationship / max relationship
			-- Re: Thanatos variant
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredNotActivatedThisRun = 390082,
					-- RequiredAnyKillsThisRun = { "Harpy", "Harpy2" },
					RequiredTextLines = { "MegaeraGift10", "BecameCloseWithThanatos01Than_GoToHim" },
					RequiredFalseTextLines = { "BecameCloseWithMegaera01", "BecameCloseWithMegaera01_B" },
					AreIdsNotAlive = { 422255 },
					RequiredFalseTextLinesThisRun = { "BecameCloseWithThanatos01", "BecameCloseWithThanatos01_B", "BecameCloseWithDusa01", "Ending01" },
					RequiredFalseTextLinesLastRun = { "BecameCloseWithThanatos01", "BecameCloseWithThanatos01_B" },
					RequiredFalseSeenRoomThisRun = "A_Boss01",
					RequiredFalseQueuedTextLines = { "BecameCloseWithDusa01", "ThanatosHomeIntermissionChat01", "ThanatosHomeIntermissionChat02", "ThanatosHomeIntermissionChat03", "ThanatosHomeIntermissionChat04", "ThanatosHomeIntermissionChat05", "ThanatosHomeIntermissionChat06" },
				},
				BreakIfPlayed = true,
				Args =
				{
					Ids = { 422142, },
					DistanceTrigger =
					{
						WithinDistance = 1000,
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.65,
									BreakIfPlayed = true,
									PostLineWait = 0.15,
									ObjectType = "NPC_FurySister_01",

									-- I need to trouble you for something, Zag.
									{ Cue = "/VO/MegaeraHome_0344" },
								},

							},
							TextLineSet =
							{
								BecameCloseWithMegaera01_B =
								{
									EndGlobalVoiceLines = "PostBedroomIntermissionVoiceLines",
									-- requirements are above
									{ Cue = "/VO/ZagreusHome_1370", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
										PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
										PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
										AngleHeroTowardSource = true,
										AngleTowardTargetId = 390058,
										-- Emote = "PortraitEmoteSurprise",
										Text = "Meg... what a surprise. Again. What is it? ...What's the matter? Wait. Why are you looking at me like that?" },

									{ Cue = "/VO/MegaeraHome_0156",
										PreLineAnim = "FuryIdleInHouseFidgetWhipTaunt_Start",
										Text = "Shut up already, Zagreus. And come here." },

									{ Cue = "/VO/ZagreusHome_1371", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
										PortraitExitAnimation = "Portrait_Zag_Empathetic_01_Exit",
										PreLineWait = 0.35,
										Emote = "PortraitEmoteSurprise",
										Text = "...I... you really... oh..." },

									{ Text = "Megaera_ChoiceText02",
										Choices =
										{
											{
												ChoiceText = "Meg_GoToHer",
												{ Cue = "/VO/ZagreusHome_2804", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PostLineAnim = "FuryIdleInHouseFidgetWhipTaunt_ReturnToIdle",
													PreLineThreadedFunctionName = "BedroomIntermissionApproach",
													PortraitExitAnimation = "Portrait_Zag_Default_01_Exit",
													PostLineThreadedFunctionName = "BedroomIntermissionPresentation",
													PostLineFunctionArgs = { ExtraWaitTime = 1.2 },
													PreLineWait = 0.35,
													Text = "...I thought you'd never ask. But I'm glad you did." },
												-- intermission
												{ Cue = "/VO/ZagreusHome_1372", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
													PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
													FadeOutTime = 0.5, FadeOutSound = "/Leftovers/World Sounds/MapText", FullFadeTime = 9.5,
													FadeInTime = 2.5, FadeInSound = "/Leftovers/Menu Sounds/EmoteAffection",
													PreLineWait = 0.4,
													InterSceneWaitTime = 0.5,
													AngleTowardHero = true,	TeleportHeroToId = 422138,
													TeleportHeroOffsetX = 100, TeleportHeroOffsetY = 170,
													AngleHeroTowardSource = true,
													Text = "Um, Meg, I... what I'm trying to say is, are you... are we good, or...?" },

												{ Cue = "/VO/MegaeraHome_0157", Portrait = "Portrait_FurySister01_Pleased_01",
													PreLineAnim = "FuryIdleInHouseFidgetGreeting",
													Text = "You ask too many questions, Zag. But yes, I'd say we are again, for now. But if you tell another soul, I'll kill you, understand?" },

												{ Cue = "/VO/ZagreusHome_1376", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
													PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
													Text = "But... no, wait... not even Than...?" },

												{ Cue = "/VO/MegaeraHome_0158", Portrait = "Portrait_FurySister01_Pleased_01",
													Text = "Than's not an idiot. He wants what's best for you. And he isn't the jealous type. Besides, I have a good working relationship with him, as you well know." },

												{ Cue = "/VO/ZagreusHome_1377", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
													PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
													PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
													Text = "Yeah, but... what about you, you're the punisher of jealousy. What if I..." },

												{ Cue = "/VO/MegaeraHome_0159", Portrait = "Portrait_FurySister01_Pleased_01",
													PostLineFunctionName = "ExitNPCPresentation", PostLineFunctionArgs = { ObjectId = 422142, TeleportToId = 421563 },
													PortraitExitAnimation = "Portrait_FurySister01_Pleased_01_Exit",
													Text = "We're not mere mortals, Zag. Mortals cling to one another viciously because their lives are short. What do we care? If Nyx has taught me one thing, it's that the heart has no bounds. Now quit your worrying, and get prepared for when we meet again out there. See you around." },

												{ Cue = "/VO/ZagreusHome_1375", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PreLineAnim = "ZagreusTalkEmpathy_Return", PreLineAnimTarget = "Hero",
													PreLineWait = 0.35,
													Text = "...See you around! ...Yes." },
											},
											{
												ChoiceText = "Meg_BackOff",
												{ Cue = "/VO/ZagreusHome_1521", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
													PreLineAnim = "FuryIdleInHouseFidgetWhipTaunt_ReturnToIdle",
													PreLineWait = 0.35,
													Text = "...I... Meg, I'm deeply flattered, and you're very dear to me, it's just... this isn't what I want from our relationship. I fear I must have led you on. Forgive me. Please say you'll still be my friend?" },
												{ Cue = "/VO/MegaeraExtra_0001", Portrait = "Portrait_FurySister01_Pleased_01",
													PortraitExitAnimation = "Portrait_FurySister01_Pleased_01_Exit", PreLineWait = 0.8,
													PostLineFunctionName = "ExitNPCPresentation", PostLineFunctionArgs = { ObjectId = 422142, TeleportToId = 421563 },
													Text = "...You're sure? Look, I... it's totally all right. I'll see you out there, then." },
											},
										},
									},
								},
							},
						},
					},
				},
			},

			-- Thanatos (Bedroom) / Thanatos in Bedroom / Bedroom Scenes / Thanatos Relationship / max relationship
			-- variant tbd below for Megaera max relationship
			-- alt ids: { 422142 (m), 422255 (t), }
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredNotActivatedThisRun = 423052,
					RequiredTextLines = { "ThanatosFieldAboutRelationship01", "ThanatosGift10" },
					RequiredFalseTextLines = { "BecameCloseWithThanatos01", "BecameCloseWithThanatos01_B", "BecameCloseWithMegaera01Meg_GoToHer" },
					AreIdsNotAlive = { 422142 },
					RequiredFalseTextLinesThisRun = { "BecameCloseWithMegaera01", "BecameCloseWithMegaera01_B", "BecameCloseWithDusa01", "Ending01" },
					RequiredFalseQueuedTextLines = { "BecameCloseWithDusa01", "MegIntermissionChat01", "MegIntermissionChat02", "MegIntermissionChat03", "MegIntermissionChat04", "MegIntermissionChat05", "MegIntermissionChat06" },
				},
				BreakIfPlayed = true,
				Args =
				{
					Ids = { 422255, },

					DistanceTrigger =
					{
						WithinDistance = 1000,
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.55,
									BreakIfPlayed = true,
									ObjectType = "NPC_Thanatos_01",

									-- I need to ask something of you.
									{ Cue = "/VO/Thanatos_0534" },
								},

							},
							TextLineSet =
							{
								BecameCloseWithThanatos01 =
								{
									EndGlobalVoiceLines = "PostBedroomIntermissionVoiceLines",
									-- requirements are above
									{ Cue = "/VO/ZagreusHome_1476", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
										PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
										PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
										-- Emote = "PortraitEmoteSurprise",
										Text = "Thanatos...! I'd ask you to come in, but... you're already here. It's really good to see you." },

									{ Cue = "/VO/Thanatos_0417",
										AngleTowardHero = true,
										Text = "Just tell me one thing, Zagreus. Did you really mean what you told me before, that... maybe we ought to... take our time?" },

									{ Text = "Thanatos_ChoiceText01",
										PortraitExitAnimation = "Portrait_Thanatos_Default_01_Exit",
										Choices =
										{
											{
												ChoiceText = "Than_GoToHim",
												{ Cue = "/VO/ZagreusHome_1477", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
													PreLineThreadedFunctionName = "BedroomIntermissionApproach",
													PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
													Text = "I just... don't mean to push you, Than. I know all this is kind of a lot. And I wanted you to know... this isn't some impulsive thing for me. I'll wait for you however long it takes." },

												{ Cue = "/VO/Thanatos_0418",
													AngleTowardHero = true,
													PreLineAnim = "ThanatosIdleInhouseFidget_HairFlick",
													Text = "{#DialogueItalicFormat}Khh! {#PreviousFormat}You have no concept of which impulses to act upon, and which to keep in check. You say you'll wait, well, let me ask you this: What are you waiting for? What are you waiting for, I'm here, already. Right...?" },

												{ Cue = "/VO/ZagreusHome_1478", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PreLineThreadedFunctionName = "StopScriptedMove",
													PortraitExitAnimation = "Portrait_Zag_Default_01_Exit",
													PreLineAnim = "ZagreusInteractionComeHither_Start", PreLineAnimTarget = "Hero",
													PostLineThreadedFunctionName = "BedroomIntermissionPresentation",
													PostLineFunctionArgs = { ExtraWaitTime = 1.2, Partner = "Thanatos" },
													Text = "Than...! {#DialogueItalicFormat}Hahaha{#PreviousFormat}, oh, you're right!" },

												-- intermission
												{ Cue = "/VO/ZagreusHome_1479", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
													PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
													FadeOutTime = 0.5, FadeOutSound = "/Leftovers/World Sounds/MapText", FullFadeTime = 9.5,
													FadeInTime = 2.5, FadeInSound = "/Leftovers/Menu Sounds/EmoteAffection",
													PreLineWait = 0.4,
													InterSceneWaitTime = 0.5,
													AngleTowardHero = true,	TeleportHeroToId = 422138,
													TeleportHeroOffsetX = 100, TeleportHeroOffsetY = 170,
													AngleHeroTowardSource = true,
													Text = "Hey, Than, look... speak up, already, I don't like it when you're quiet for too long, what's on your mind?" },

												{ Cue = "/VO/Thanatos_0419", Portrait = "Portrait_Thanatos_Pleased_01",
													Text = "A lot of things. And you will have to grow to like it, Zag. Or, what I mean is... don't take my silence the wrong way, all right? I'd better get going, though, I'm way behind on work, but... see you again. If that's all right." },

												{ Cue = "/VO/ZagreusHome_1480", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PostLineThreadedFunctionName = "ThanatosExit", PostLineFunctionArgs = { AnimationState = "NPCThanatosExited", WaitTime = 0.3 },
													Text = "It is. It is." },
											},
											{
												ChoiceText = "Than_BackOff",
												{ Cue = "/VO/ZagreusHome_1520", Portrait = "Portrait_Zag_Serious_01", Speaker = "CharProtag",
													PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
													PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero", PreLineWait = 0.8,
													Text = "...I did. Sometimes I need to slow things down. I'm thankful that we've been on better terms, lately. But, I've been coming on too strong. Forgive me. You're my dear friend. I don't want to do anything to hurt you. Or anybody else." },
												{ Cue = "/VO/Thanatos_0627", Portrait = "Portrait_Thanatos_Pleased_01",
													PortraitExitAnimation = "Portrait_Thanatos_Pleased_01_Exit", PreLineWait = 0.5,
													PostLineThreadedFunctionName = "ThanatosExit", PostLineFunctionArgs = { AnimationState = "NPCThanatosExited", WaitTime = 0.3 },
													Text = "I... oh. I see. I understand. You're my dear friend, as well. Though we have done an awful lot to jeopardize that lately, haven't we? Look, take care, Zag. Be seeing you." },
												{ Cue = "/VO/ZagreusHome_2531", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PreLineWait = 0.8,
													Text = "...Be seeing you, too." },
											},
										},
									},
								},
							},
						},
					},
				},
			},

			-- Thanatos (Bedroom) / Thanatos in Bedroom / Bedroom Scenes / Thanatos Relationship / max relationship
			-- Re: Meg Variant
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredNotActivatedThisRun = 423052,
					RequiredTextLines = { "ThanatosFieldAboutRelationship01", "ThanatosGift10", "BecameCloseWithMegaera01Meg_GoToHer" },
					RequiredFalseTextLines = { "BecameCloseWithThanatos01", "BecameCloseWithThanatos01_B", },
					AreIdsNotAlive = { 422142 },
					RequiredFalseTextLinesThisRun = { "BecameCloseWithMegaera01", "BecameCloseWithMegaera01_B", "BecameCloseWithDusa01", "Ending01" },
					RequiredFalseTextLinesLastRun = { "BecameCloseWithMegaera01", "BecameCloseWithMegaera01_B" },
					RequiredFalseQueuedTextLines = { "BecameCloseWithDusa01", "MegIntermissionChat01", "MegIntermissionChat02", "MegIntermissionChat03", "MegIntermissionChat04", "MegIntermissionChat05", "MegIntermissionChat06" },
				},
				BreakIfPlayed = true,
				Args =
				{
					Ids = { 422255, },

					DistanceTrigger =
					{
						WithinDistance = 1000,
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.55,
									BreakIfPlayed = true,
									ObjectType = "NPC_Thanatos_01",

									-- I need to ask something of you.
									{ Cue = "/VO/Thanatos_0534" },
								},

							},
							TextLineSet =
							{
								BecameCloseWithThanatos01_B =
								{
									EndGlobalVoiceLines = "PostBedroomIntermissionVoiceLines",
									-- requirements are above
									{ Cue = "/VO/ZagreusHome_1476", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
										PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
										PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
										-- Emote = "PortraitEmoteSurprise",
										Text = "Thanatos...! I'd ask you to come in, but... you're already here. It's really good to see you." },

									{ Cue = "/VO/Thanatos_0417",
										AngleTowardHero = true,
										Text = "Just tell me one thing, Zagreus. Did you really mean what you told me before, that... maybe we ought to... take our time?" },

									{ Text = "Thanatos_ChoiceText02",
										PortraitExitAnimation = "Portrait_Thanatos_Default_01_Exit",
										Choices =
										{
											{
												ChoiceText = "Than_GoToHim",
												{ Cue = "/VO/ZagreusHome_1477", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
													PreLineThreadedFunctionName = "BedroomIntermissionApproach",
													PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
													Text = "I just... don't mean to push you, Than. I know all this is kind of a lot. And I wanted you to know... this isn't some impulsive thing for me. I'll wait for you however long it takes." },

												{ Cue = "/VO/Thanatos_0418",
													AngleTowardHero = true,
													PreLineAnim = "ThanatosIdleInhouseFidget_HairFlick",
													Text = "{#DialogueItalicFormat}Khh! {#PreviousFormat}You have no concept of which impulses to act upon, and which to keep in check. You say you'll wait, well, let me ask you this: What are you waiting for? What are you waiting for, I'm here, already. Right...?" },

												{ Cue = "/VO/ZagreusHome_1481", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													Text = "Than... {#DialogueItalicFormat}hahaha{#PreviousFormat}, I'm so glad! It's just... you know that Megaera has been here, too...?" },

												{ Cue = "/VO/Thanatos_0420", Portrait = "Portrait_Thanatos_Pleased_01",
													Text = "{#DialogueItalicFormat}Tsch. {#PreviousFormat}I've known Megaera much longer than you. Who do you think talked me into this?" },

												{ Cue = "/VO/ZagreusHome_1482", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PreLineThreadedFunctionName = "StopScriptedMove",
													PortraitExitAnimation = "Portrait_Zag_Default_01_Exit",
													PreLineAnim = "ZagreusInteractionComeHither_Start", PreLineAnimTarget = "Hero",
													PostLineThreadedFunctionName = "BedroomIntermissionPresentation",
													PostLineFunctionArgs = { ExtraWaitTime = 1.2, Partner = "Thanatos" },
													Text = "Hah! She did, did she? That's good! That's good." },

												-- intermission
												{ Cue = "/VO/ZagreusHome_1479", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
													PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
													FadeOutTime = 0.5, FadeOutSound = "/Leftovers/World Sounds/MapText", FullFadeTime = 9.5,
													FadeInTime = 2.5, FadeInSound = "/Leftovers/Menu Sounds/EmoteAffection",
													PreLineWait = 0.4,
													InterSceneWaitTime = 0.5,
													AngleTowardHero = true,	TeleportHeroToId = 422138,
													TeleportHeroOffsetX = 100, TeleportHeroOffsetY = 170,
													AngleHeroTowardSource = true,
													Text = "Hey, Than, look... speak up, already, I don't like it when you're quiet for too long, what's on your mind?" },

												{ Cue = "/VO/Thanatos_0419", Portrait = "Portrait_Thanatos_Pleased_01",
													Text = "A lot of things. And you will have to grow to like it, Zag. Or, what I mean is... don't take my silence the wrong way, all right? I'd better get going, though, I'm way behind on work, but... see you again. If that's all right." },

												{ Cue = "/VO/ZagreusHome_1480", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PostLineThreadedFunctionName = "ThanatosExit", PostLineFunctionArgs = { AnimationState = "NPCThanatosExited", WaitTime = 0.3 },
													Text = "It is. It is." },
											},
											{
												ChoiceText = "Than_BackOff",
												{ Cue = "/VO/ZagreusHome_1520", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
													PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
													PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero", PreLineWait = 0.8,
													Text = "...I did. Sometimes I need to slow things down. I'm thankful that we've been on better terms, lately. But, I've been coming on too strong. Forgive me. You're my dear friend. I don't want to do anything to hurt you. Or anybody else." },

												{ Cue = "/VO/ThanatosExtra_0001", Portrait = "Portrait_Thanatos_Pleased_01",
													PortraitExitAnimation = "Portrait_Thanatos_Pleased_01_Exit", PreLineWait = 0.5,
													PostLineThreadedFunctionName = "ThanatosExit", PostLineFunctionArgs = { AnimationState = "NPCThanatosExited", WaitTime = 0.3 },
													Text = "You're certain? Well... I understand. I'd best get back to my responsibilities for now." },

												{ Cue = "/VO/ZagreusHome_0822", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PreLineWait = 0.8,
													Text = "...See you, Than." },
											},
										},
									},
								},
							},
						},
					},
				},
			},

			-- Meg + Thanatos (Bedroom) / max relationship
			{
				FunctionName = "ActivatePrePlacedUnits",
				-- mirrored below
				GameStateRequirements =
				{
					RequiredFalseTextLines = { "MegaeraWithThanatosBedroom01" },
					RequiredAnyEncountersThisRun = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", },
					RequiredIdsNotActivatedThisRun = { 423052, 390082 },
					RequiredTextLines = { "ThanatosAboutMegaera02" },
					RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" },
					RequiredAnyOtherTextLines = { "BecameCloseWithThanatos01Than_GoToHim", "BecameCloseWithThanatos01_BThan_GoToHim", },
					RequiredFalseTextLinesThisRun = { "Ending01" },
					MinRunsSinceAnyTextLines = { TextLines = GameData.MegThanIntermissionTextLines, Count = 8 },
				},
				Args =
				{
					Ids = { 422255 },
					DistanceTrigger =
					{
						WithinDistance = 1000,
						FunctionName = "SetupNPCPresentation",
						Args =
						{
							OffsetX = 150,
							OffsetY = 130,
						},
					}
				},
			},
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredFalseTextLines = { "MegaeraWithThanatosBedroom01" },
					RequiredAnyEncountersThisRun = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", },
					RequiredIdsNotActivatedThisRun = { 423052, 390082 },
					RequiredTextLines = { "ThanatosAboutMegaera02" },
					RequiredAnyTextLines = { "BecameCloseWithMegaera01Meg_GoToHer", "BecameCloseWithMegaera01_BMeg_GoToHer" },
					RequiredAnyOtherTextLines = { "BecameCloseWithThanatos01Than_GoToHim", "BecameCloseWithThanatos01_BThan_GoToHim", },
					RequiredFalseTextLinesThisRun = { "Ending01" },
					MinRunsSinceAnyTextLines = { TextLines = GameData.MegThanIntermissionTextLines, Count = 8 },
				},
				BreakIfPlayed = true,
				Args =
				{
					Ids = { 422142 },

					DistanceTrigger =
					{
						WithinDistance = 1000,
						FunctionName = "SurpriseNPCPresentation",
						Args =
						{
							-- ActivateIds = { },
							VoiceLines =
							{
								Queue = "Interrupt",
								{
									PreLineWait = 0.5,
									UsePlayerSource = true,

									-- Hoh...
									{ Cue = "/VO/ZagreusField_0287" },
								},
								{
									PreLineWait = 0.35,
									ObjectType = "NPC_Thanatos_01",
									PreLineAnim = "ThanatosIdleInhouseFidget_HairFlick",

									-- Hey Zag.
									{ Cue = "/VO/Thanatos_0426" },
								},
								{
									PreLineWait = 0.05,
									ObjectType = "NPC_FurySister_01",
									PreLineAnim = "FuryIdleInHouseFidgetWhipTaunt_Start",

									-- <Laughter>
									{ Cue = "/VO/MegaeraHome_0227",  },
								},
								{
									PreLineWait = 0.2,
									PostLineWait = 2.0,
									UsePlayerSource = true,

									-- Hi you two.
									{ Cue = "/VO/ZagreusField_2596" },
								},
							},
							TextLineSet =
							{
								MegaeraWithThanatosBedroom01 =
								{
									EndGlobalVoiceLines = "PostBedroomIntermissionVoiceLines",
									-- requirements are above

									{ Cue = "/VO/MegaeraHome_0352",
										Portrait = "Portrait_FurySister01_Pleased_01",
										Text = "Zagreus, you don't have any doors. Why are you always so surprised?" },

									{ Cue = "/VO/ZagreusHome_1517", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
										PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
										PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
										-- Emote = "PortraitEmoteSurprise",
										Text = "{#DialogueItalicFormat}Erm{#PreviousFormat}, Meg, Than, what... what are you two... what's going on? Whatever it is, I can explain, or... wait, you're both smiling. Oh... let me just... take this in a moment here." },

									{ Cue = "/VO/MegaeraHome_0353",
										Portrait = "Portrait_FurySister01_Pleased_01",
										Text = "You give Thanatos and me too little credit, Zag. We've known each other longer than you've been alive." },

									{ Cue = "/VO/Thanatos_0424",
										PreLineAnim = "FuryIdleInHouseFidgetWhipTaunt_ReturnToIdle",
										Portrait = "Portrait_Thanatos_Pleased_01",
										Speaker = "NPC_Thanatos_01",
										Text = "I'd say we know quite a bit by now, all things considered. Isn't that right, Megaera?" },

									{ Cue = "/VO/MegaeraHome_0187",
										PreLineAnim = "FuryIdleInHouseFidgetGreeting",
										Portrait = "Portrait_FurySister01_Pleased_01",
										Text = "Can't you see we're off duty right now, Zagreus?" },

									{ Text = "MegaeraWithThanatos_ChoiceText01",
										Portrait = "Portrait_FurySister01_Pleased_01",
										PortraitExitAnimation = "Portrait_FurySister01_Pleased_01_Exit",
										Choices =
										{
											{
												ChoiceText = "MegThan_GoToThem",
												{ Cue = "/VO/ZagreusHome_1518", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													PortraitExitAnimation = "Portrait_Zag_Default_01_Exit",
													PreLineThreadedFunctionName = "BedroomIntermissionApproach",
													PostLineThreadedFunctionName = "BedroomIntermissionPresentation",
													PostLineFunctionArgs = { ExtraWaitTime = 0.8, Partner = "MegThan" },
													PreLineWait = 0.8,
													Text = "{#DialogueItalicFormat}Hah{#PreviousFormat}! Well then... if this turns out to be some sort of dream, I will be very, very mad. Though... I guess there's one good way to find out." },

												-- intermission
												{ Cue = "/VO/ZagreusHome_1519", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
													PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
													PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
													FadeOutTime = 0.5, FadeOutSound = "/Leftovers/World Sounds/MapText", FullFadeTime = 12.8,
													FadeInTime = 2.5, FadeInSound = "/Leftovers/Menu Sounds/EmoteAffection",
													PreLineWait = 0.4,
													InterSceneWaitTime = 0.5,
													AngleTowardHero = true,	TeleportHeroToId = 422138,
													TeleportHeroOffsetX = -100, TeleportHeroOffsetY = 170,
													AngleHeroTowardSource = true,
													Text = "Whew, well, now, um, where was I..." },
												{ Cue = "/VO/MegaeraHome_0354", Portrait = "Portrait_FurySister01_Pleased_01",
													PreLineAnim = "FuryIdleInHouseFidgetGreeting",
													PostLineFunctionName = "ExitNPCPresentation", PostLineFunctionArgs = { ObjectId = 422142, AltObjectId = 422255, TeleportToId = 421563, UseThanatosExitSound = true, FullFadeTime = 3.0, },
													PortraitExitAnimation = "Portrait_FurySister01_Pleased_01_Exit",
													Text = "Well! I think we've reached an understanding here. I should be off. Until the next one, Zag. And Thanatos." },
												{ Cue = "/VO/ZagreusHome_1523", PreLineWait = 1.0, Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
													Text = "Whew, well, that was... that was... {#DialogueItalicFormat}ahem{#PreviousFormat}." },
											},
											{
												ChoiceText = "MegThan_BackOff",
												{ Cue = "/VO/ZagreusHome_3118", Portrait = "Portrait_Zag_Empathetic_01", Speaker = "CharProtag",
													PreLineWait = 0.8,
													PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
													PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
													Text = "...Hey... look. I care about you. Both of you. A lot. I'm happy we're this close... you're this close, rather than being at each other's throats like before. But, I think it's all a little much for me, right now." },
												{ Cue = "/VO/MegaeraHome_0392", Portrait = "Portrait_FurySister01_Pleased_01",
													PortraitExitAnimation = "Portrait_FurySister01_Pleased_01_Exit", PreLineWait = 0.8,
													Text = "...You're sure? Look... it's totally all right. You've got enough pressure on you as it is. We'll see you out there, then." },
												{ Cue = "/VO/Thanatos_0480",
													Portrait = "Portrait_Thanatos_Pleased_01",
													PortraitExitAnimation = "Portrait_Thanatos_Pleased_01_Exit",
													Speaker = "NPC_Thanatos_01",
													PreLineWait = 0.4,
													PostLineFunctionName = "ExitNPCPresentation", PostLineFunctionArgs = { ObjectId = 422142, AltObjectId = 422255, TeleportToId = 421563, UseThanatosExitSound = true, FullFadeTime = 3.3, },
													Text = "Catch up with you some other time, all right?" },
											},
										}
									},

								},

							},
						},
					},
				},
			},

		},
		UnthreadedEvents =
		{
			{
				FunctionName = "RemoveLastAwardTrait",
				Args = {},
			},
			{
				FunctionName = "UnequipWeaponUpgrade",
				Args = {},
			},
			{
				FunctionName = "RemoveLastAssistTrait",
				Args = {},
			},
			{
				FunctionName = "DisableWeapons",
				Args = {},
			},
		},
		ObstacleData =
		{
			[420897] =
			{
				OnUsedFunctionName = "DeathAreaSwitchRoom",
				OnUsedFunctionArgs = { Name = "RoomPreRun", HeroStartPoint = 40009, HeroEndPoint = 40012, CheckBinkSetChange = true, },
				InteractDistance = 150,
				AutoActivate = true,
			},
			[420896] =
			{
				OnUsedFunctionName = "DeathAreaSwitchRoom",
				OnUsedFunctionArgs = { Name = "DeathArea", HeroStartPoint = 390004, HeroEndPoint = 390002, CheckBinkSetChange = true },
				InteractDistance = 100,
				AutoActivate = true,
			},

			-- DeathAreaBedroom Cosmetics
			-- Scrying Pool
			[390197] =
			{
				Name = "HouseWaterBowl01",
				SetupGameStateRequirements =
				{
					RequiredCosmetics = { "HouseWaterBowl01", },
				},
				UseText = "UseExamineMisc",
				OnUsedFunctionName = "UseWaterBowl",
			},
			-- Lyre
			[426208] =
			{
				Name = "HouseLyre01",
				SetupGameStateRequirements =
				{
					RequiredCosmetics = { "HouseLyre01", },
				},
				InteractDistance = 130,
				InteractOffsetX = 20,
				InteractOffsetY = -70,
				UseText = "UseLute01",
				OnUsedFunctionName = "UseLyre",
			},
			-- Gaming Table
			[426222] =
			{
				Name = "HouseGamingTable01",
				SetupGameStateRequirements =
				{
					RequiredCosmetics = { "HouseGamingTable01", },
				},
				InteractDistance = 150,
				InteractOffsetX = 0,
				InteractOffsetY = -50,
				UseText = "UseGamingTable01",
				OnUsedFunctionName = "UseGamingTable",
			},
			-- Barbell / Weights
			[426209] =
			{
				Name = "HouseWeights01",
				SetupGameStateRequirements =
				{
					RequiredCosmetics = { "HouseWeights01", },
				},
				InteractDistance = 150,
				UseText = "UseWeights01",
				OnUsedFunctionName = "UseBarbell",
			},
			-- Bedroom Couch
			[422261] =
			{
				Name = "HouseCouch02A",
				SetupGameStateRequirements =
				{
					RequiredCosmetics = { "HouseCouch02A", },
				},
				InteractDistance = 150,
				UseText = "UseBed",
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				ShakeSelf = true,
				OnUsedGlobalVoiceLines = "TakeANapVoiceLines",
			},
			-- Bed
			[310036] =
			{
				InteractDistance = 200,
				UseText = "UseBed",
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				ShakeSelf = true,
				ShakeIds = { 426236, },
				OnUsedGlobalVoiceLines = "TakeANapVoiceLines",
				OnUsedTextLineSets =
				{
					Flashback_Mother_01 =
					{
						UseableOffSource = true,
						PlayOnce = true,
						RequiredTrueFlags = { "AllowFlashback" },
						-- Mischief, me? I was just going to have a little look through Father's stuff.
						EndCue = "/VO/ZagreusHome_0175",
						EndWait = 0.35,
						{
							StartSound = "/Leftovers/Menu Sounds/EmoteExcitement",
							PreLineFunctionName = "SetupFlashback", PreLineFunctionArgs = { FlashbackMessage = "FlashbackMessage", SecretMusic = "/Music/MusicExploration3_MC" },
							FadeOutTime = 0.5, FullFadeTime = 1, SetFlagTrue = "InFlashback", PostLineFunctionName = "AdvanceFlashback",
							BlockUseableToggle = true,
							UseableOffIds =
							{
								421158, 390197, 390000, 310036, 370000, 390021, 390446, 390325, 420896, 420897, 420898, 421071, 421070, 421072, 421074, 390197, 422257, 426224, 426229, 426231, 426230, 426228, 426222, 426213, 426209, 426220, 426220, 390197, 390224, 390314, 390227, 422261, 310037, 421320, 310039, 310038, 421296, 421295, 426208, 426236, 555810, 555811,
							},
							FadeOutIds =
							{
								421158, 390000, 390325, 390021, 391715, 391713, 391712, 391714, 420898, 310028, 310038, 310024, 390197, 390224, 390314, 421071, 421070, 421072, 421074, 422257, 426224, 426229, 426231, 426230, 426228,
								426222, 426213, 426209, 426220, 426220, 390197, 390224, 390314, 390227, 422261, 310037, 421320, 310039, 310038, 421296, 421295, 426208, 555810, 555811, 426239
							},
							CollisionOffIds =
							{
								426209, 426222, 422261, 390179, 390197, 426208,
							},
							Cue = "/VO/Storyteller_0162", PreLineWait = 1.5,
							PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}It is the dead of night, or the approximation of it in the realm of Hades. Prince of the Underworld Zagreus rises from a fitful slumber, with much mischief on his mind."
						},
					},

					-- Flashback 2
					Flashback_DayNightJob_01 =
					{
						UseableOffSource = true,
						PlayOnce = true,
						RequiredTrueFlags = { "AllowFlashback" },
						RequiredTextLines = { "Flashback_Mother_01" },
						-- Ungh, I'm late for work... Father's going to kill me.
						EndCue = "/VO/ZagreusHome_2115",
						EndWait = 0.35,
						{
							StartSound = "/Leftovers/Menu Sounds/EmoteExcitement",
							PreLineFunctionName = "SetupFlashback", PreLineFunctionArgs = { FlashbackMessage = "FlashbackMessage02", SecretMusic = "/Music/MusicExploration1_MC" },
							FadeOutTime = 0.5, FullFadeTime = 1, SetFlagTrue = "InFlashback", PostLineFunctionName = "AdvanceFlashback",
							BlockUseableToggle = true,
							UseableOffIds =
							{
								421158, 390197, 390000, 310036, 370000, 390021, 390446, 390325, 420896, 420897, 420898, 421071, 421070, 421072, 421074, 390197, 422257, 426224, 426229, 426231, 426230, 426228, 426222, 426213, 426209, 426220, 426220, 390197, 390224, 390314, 390227, 422261, 310037, 421320, 310039, 310038, 421296, 421295, 426208, 426236, 555810, 555811
							},
							FadeOutIds =
							{
								421158, 390000, 390325, 390021, 391715, 391713, 391712, 391714, 420898, 310028, 310038, 310024, 390197, 390224, 390314, 421071, 421070, 421072, 421074, 422257, 426224, 426229, 426231, 426230, 426228,
								426222, 426213, 426209, 426220, 426220, 390197, 390224, 390314, 390227, 422261, 310037, 421320, 310039, 310038, 421296, 421295, 426208, 555810, 555811, 426239
							},
							CollisionOffIds =
							{
								426209, 426222, 422261, 390179, 390197, 426208,
							},
							Cue = "/VO/Storyteller_0303", PreLineWait = 1.5,
							UseableOnIds = { 420896 },
							FadeInIds = { 390325 },
							Text = "{#DialogueItalicFormat}The heavy-sleeping Underworld Prince arises, with the feeling that the brief nap he intended as a respite from the rigors of the day or night apparently was none-too-brief, at all..."
						},
					},

				},
			},

			-- Desk Scroll / QuestLog / Fated List
			[421158] =
			{
				Name = "QuestLog",
				InteractDistance = 200,
				AnimOffsetZ = 150,
				UseableWhilePending = true,
				UseText = "UseQuestLog",
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				OnUsedFunctionName = "UseQuestLog",
				SetupGameStateRequirements =
				{
					RequiredCosmetics = { "QuestLog", },
				},
				SetupFunctions =
				{
					{
						Name = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							RequiredScreenViewedFalse = "QuestLog",
							RequiredFalseFlags = { "InFlashback", },
						},
					},
					{
						Name = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							AnyQuestWithStatus = "Complete",
							RequiredFalseFlags = { "InFlashback", },
						},
					},
				},
				DestroyIfNotSetup = true,
				DistanceTrigger =
				{
					WithinDistance = 500,
					TriggerOnceThisRun = true,
					VoiceLines =
					{
						PlayOnce = true,
						AreIdsNotAlive = { 422142, 422255, 426227, },
						Cooldowns =
						{
							{ Name = "ZagreusMiscHouseSpeech", Time = 10 },
						},

						-- Hey that must be the Fated List...
						{ Cue = "/VO/ZagreusHome_1337", PreLineWait = 0.6, Queue = "Always" },
						-- What's that on my desk?
						-- { Cue = "/VO/ZagreusHome_0588", PreLineWait = 0.4, Queue = "Always" },
					},
				},
			},

			-- @when adding new InspectPoints, remember to add their data to Flashback_Mother_01 & any other flasbacks

		},

		InspectPoints =
		{
			-- renovate / cosmetic interact point
			[420898] =
			{
				UseText = "UseCosmetic",
				RequiredFalseFlags = { "InFlashback" },
				RequiresPendingCosmeticItems = true,
				OnUsedFunctionName = "RevealPendingItems",
			},
			[390000] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				InteractTextLineSets =
				{
					InspectBedroom01 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							RequiredMinElapsedTime = 3,
							UsePlayerSource = true,
							-- Oh come on, it's not that bad, is it?
							{ Cue = "/VO/ZagreusHome_0066" },
						},
						{ Cue = "/VO/Storyteller_0114",
							Text = "{#DialogueItalicFormat}The bedchambers of Prince Zagreus lie in a perpetual state of utter disarray, despite his Lord and master of the House repeatedly insisting that he pick everything up." },
					},
				},
			},

			-- trojan arms
			[421072] =
			{
				RequiredCosmeticItemVisible = "HouseDagger01",
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				InteractTextLineSets =
				{
					InspectBedroom_TrojanArms =
					{
						PlayOnce = true,
						{ Cue = "/VO/Storyteller_0191",
							Text = "{#DialogueItalicFormat}The shattered weapons of the siege of Ilion are now reduced to window-dressings in the Prince's ever-cluttered lair." },
						-- Bronze weapons... made crudely, but they had the right idea.
						EndCue = "/VO/ZagreusHome_0420",
						EndWait = 0.3,
					}
				}
			},

			-- achilles poster
			[421071] =
			{
				RequiredCosmeticItemVisible = "HousePoster01",
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				InteractTextLineSets =
				{
					InspectBedroom_AchillesPoster =
					{
						PlayOnce = true,
						{ Cue = "/VO/Storyteller_0189",
							Text = "{#DialogueItalicFormat}The valor of the great-hearted Achilles is immortalized upon the Prince's wall, as though it might stir up more courage from within." },
						-- Achilles must have been incredible back when he was alive.
						EndCue = "/VO/ZagreusHome_0418",
						EndWait = 0.3,
					}
				}
			},

			-- aphrodite poster
			[421070] =
			{
				RequiredCosmeticItemVisible = "HousePoster02",
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				InteractTextLineSets =
				{
					InspectBedroom_AphroditePoster =
					{
						PlayOnce = true,
						{ Cue = "/VO/Storyteller_0190",
							Text = "{#DialogueItalicFormat}The visage of the goddess Aphrodite now adorns the Prince's bedchambers, perhaps to provide consolation after when next he dies." },
						-- Aphrodite herself. Wonder if I could get this signed.
						EndCue = "/VO/ZagreusHome_0419",
						EndWait = 0.3,
					}
				}
			},

			-- dionysus poster
			[555811] =
			{
				RequiredCosmeticItemVisible = "HousePoster05",
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				InteractTextLineSets =
				{
					InspectBedroom_DionysusPoster =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							PreLineWait = 0.35,
							RequiredMinElapsedTime = 3,
							UsePlayerSource = true,
							-- It's like we share a bond, man!
							{ Cue = "/VO/ZagreusHome_2854" },
						},
						{ Cue = "/VO/Storyteller_0362",
							Text = "{#DialogueItalicFormat}The ever-smiling, wine-washed countenance of the great Lord Dionysus now adorns the Prince's chamber-wall, thus radiating questionable influence." },
					}
				}
			},

			-- scrying pool
			[421074] =
			{
				RequiredCosmeticItemVisible = "HouseWaterBowl01",
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				InteractTextLineSets =
				{
					InspectBedroom_ScryingPool =
					{
						PlayOnce = true,
						{ Cue = "/VO/Storyteller_0203",
							Text = "{#DialogueItalicFormat}A beautifully decorated, subtly enchanted bowl containing traces of the hapless Prince's past attempts to flee the Underworld now accents a particularly cluttered corner of his room." },
						-- Always wanted my own scrying pool.
						EndCue = "/VO/ZagreusHome_0421",
						EndWait = 0.3,
					}
				}
			},

			-- lyre
			[426224] =
			{
				RequiredCosmeticItemVisible = "HouseLyre01",
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				InteractTextLineSets =
				{
					InspectBedroom_Lyre =
					{
						PlayOnce = true,
						{ Cue = "/VO/Storyteller_0291",
							Text = "{#DialogueItalicFormat}A delicately crafted instrument of music-making now resides within the clamor-causing Prince's chambers, doubtless fearing, if it could, his heavy-handed touch." },
						-- Can't be that hard to play can it?
						EndCue = "/VO/ZagreusHome_1901",
						EndWait = 0.35,
					}
				}
			},

			-- gaming table
			[426229] =
			{
				RequiredCosmeticItemVisible = "HouseGamingTable01",
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				InteractTextLineSets =
				{
					InspectBedroomGamingTable01 =
					{
						PlayOnce = true,
						{ Cue = "/VO/Storyteller_0289",
							Text = "{#DialogueItalicFormat}An object intricately carven solely for the purposes of recreation now resides within the pleasure-seeking Prince's chambers, although his lack for an opponent limits its appeal." },
						-- Face me yourself, old man.
						EndCue = "/VO/ZagreusHome_1899",
						EndWait = 0.35,
					}
				}
			},

			-- bedroom rug
			[426231] =
			{
				RequiredCosmeticItemVisible = "HouseRug03B",
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				InteractTextLineSets =
				{
					InspectBedroomRug01 =
					{
						PlayOnce = true,
						{ Cue = "/VO/Storyteller_0292",
							Text = "{#DialogueItalicFormat}Much of the softness of the richly woven rug the Prince procured cannot be fully felt beneath his flame-licked feet." },
						-- I guess it's soft?
						EndCue = "/VO/ZagreusHome_1902",
						EndWait = 0.35,
					}
				}
			},

			-- fancy bed
			[555810] =
			{
				RequiredCosmeticItemVisible = "HouseBed01a",
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				RequiredTextLines = { "InspectBedroom01" },
				InteractTextLineSets =
				{
					InspectBedroom_FancyBed =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							PreLineWait = 0.35,
							RequiredMinElapsedTime = 3,
							UsePlayerSource = true,
							-- Already bought it, no need to sell me on it, old man.
							{ Cue = "/VO/ZagreusHome_2855" },
						},
						{ Cue = "/VO/Storyteller_0363",
							Text = "{#DialogueItalicFormat}With its just-right softness and death-themed embroidery, the new bedding of Prince Zagreus is the envy of all those who wish to rest in peace." },
					}
				}
			},

			-- bedroom couch
			[426230] =
			{
				RequiredCosmeticItemVisible = "HouseCouch02A",
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				InteractTextLineSets =
				{
					InspectBedroomCouch01 =
					{
						PlayOnce = true,
						{ Cue = "/VO/Storyteller_0287",
							Text = "{#DialogueItalicFormat}The ever-energetic Prince alas remains incapable of sitting still, even with such a supple, comfortable seating arrangement nestled in his chambers now." },
						-- I just prefer to stand, all right?
						EndCue = "/VO/ZagreusHome_1897",
						EndWait = 0.35,
					}
				}
			},

			-- bedroom barbell / weights
			[426228] =
			{
				RequiredCosmeticItemVisible = "HouseWeights01",
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				InteractTextLineSets =
				{
					InspectBedroomWeights01 =
					{
						PlayOnce = true,
						{ Cue = "/VO/Storyteller_0288",
							Text = "{#DialogueItalicFormat}A massive set of weights positioned carefully in line of sight of any visitors shall doubtless make them think the Prince is stronger and in better shape than in reality." },
						-- I get lots of exercise, OK?
						EndCue = "/VO/ZagreusHome_1898",
						EndWait = 0.35,
					}
				}
			},

			-- questLog / fated list
			[422257] =
			{
				RequiredCosmetics = { "QuestLog", },
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				InteractTextLineSets =
				{
					InspectBedroom_QuestLog =
					{
						PlayOnce = true,
						{ Cue = "/VO/Storyteller_0282",
							Text = "{#DialogueItalicFormat}The fate-abetting Prince perhaps believes it was through his own choice that he procured the Fated List of Minor Prophecies, but it was preordained." },
						-- Oh no, not this determinism thing again...
						EndCue = "/VO/ZagreusHome_1510",
						EndWait = 0.4,
					}
				}
			},

			-- @when adding new InspectPoints, remember to add their data to Flashback_Mother_01 & any other flasbacks

			-- Flashback 1
			[390511] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_Mother_01" },
				RequiredFalseTextLines = { "Flashback06" },
				InteractTextLineSets =
				{
					Flashback01 =
					{
						PlayOnce = true,
						-- Lower your voice, old man, I'm trying to be sneaky here...!
						EndCue = "/VO/ZagreusHome_0176",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0131", PostLineFunctionName = "AdvanceFlashback",
							UseableOnIds = { 420896 },
							FadeInIds = { 390325 },
							Text = "{#DialogueItalicFormat}All is quiet at this time; ever-dreaming Hypnos put a spell upon the House, as willful Zagreus had asked of him. All are fast asleep, save for the Prince. It is exactly as he planned." },
					},
				},
			},

		},

		EnteredVoiceLines =
		{
			-- Should turn around. My escape route's in the courtyard I just left.
			{ Cue = "/VO/ZagreusHome_1522", RequiredCompletedRuns = 0, RequiredPlayed = { "/VO/ZagreusHome_0458" }, PreLineWait = 0.35, BreakIfPlayed = true, PlayOnce = true, },
			-- My escape route's back the other way.
			{ Cue = "/VO/ZagreusHome_0461", RequiredCompletedRuns = 0, RequiredPlayed = { "/VO/ZagreusHome_0458", "/VO/ZagreusHome_1522" }, PreLineWait = 0.35, BreakIfPlayed = true, PlayOnce = true, RequiredFalsePrevRooms = { "DeathArea" }, },
			-- Hey Room, I'm back.
			{ Cue = "/VO/ZagreusHome_0042b", PreLineWait = 0.85, PlayOnceThisRun = true, RequiredCompletedRuns = 0 },
			-- I'm back, Room, did you miss me?
			-- { Cue = "/VO/ZagreusHome_0045", PreLineWait = 0.85, PlayOnceThisRun = true, RequiredCompletedRuns = 0 },
			-- I want to go lie down.
			{ Cue = "/VO/ZagreusHome_0266", PreLineWait = 0.85, PlayOnceThisRun = true, BreakIfPlayed = true, RequiredTextLines = { "HadesFirstMeeting" }, RequiredFalseTextLines = { "Flashback_Mother_01" }, RequiredTrueFlags = { "AllowFlashback" }, ChanceToPlayAgain = 0.1, AreIdsNotAlive = { 422255, 422142, }, },
			-- Could maybe use some rest...
			{ Cue = "/VO/ZagreusHome_2113", PreLineWait = 0.85, PlayOnceThisRun = true, BreakIfPlayed = true, RequiredTextLines = { "Flashback_Mother_01" }, RequiredTrueFlags = { "AllowFlashback" }, ChanceToPlayAgain = 0.1, AreIdsNotAlive = { 422255, 422142, }, },
			-- Hey what happened to the Pact of Punishment?
			{ Cue = "/VO/ZagreusHome_1055", PlayOnce = true, BreakIfPlayed = true, PreLineWait = 0.65, RequiredMinShrinePointThresholdClear = 0, RequiredPlayed = { "/VO/ZagreusHome_0588" }, RequiredFalsePlayed = { "/VO/ZagreusHome_1056", "/VO/ZagreusHome_1057", "/VO/ZagreusHome_1126" }, RequiredFalseCosmetics = { "QuestLog" }, AreIdsNotAlive = { 422255, 422142, }, },
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PlayOnceFromTableThisRun = true,
				RequiredMinCompletedRuns = 1,
				PreLineWait = 0.65,
				RequiredFalseFlags = { "InFlashback" },
				RequiredFalseTextLinesThisRun = { "Flashback_Mother_01", "Ending01" },
				RequiredFalsePlayedThisRoom = { "/VO/ZagreusHome_0588" },
				AreIdsNotAlive = { 422255, 422142, },
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "ZagreusMiscHouseSpeech", Time = 10 },
				},

				-- Hey Room, I'm back.
				{ Cue = "/VO/ZagreusHome_0042b", RequiredMinCompletedRuns = 8 },
				-- Hey Room, I'm back.
				{ Cue = "/VO/ZagreusHome_0042a", RequiredMinCompletedRuns = 12 },
				-- <Sigh.>
				{ Cue = "/VO/ZagreusHome_0043", RequiredFalseTextLines = { "Ending01" }, },
				-- <Sigh...>
				{ Cue = "/VO/ZagreusHome_0104", RequiredFalseTextLines = { "Ending01" }, },
				-- Hey, Room.
				{ Cue = "/VO/ZagreusHome_0044" },
				-- I'm back, Room, did you miss me?
				{ Cue = "/VO/ZagreusHome_0045", RequiredMinCompletedRuns = 4, ChanceToPlay = 0.5 },
				-- Gods...
				{ Cue = "/VO/ZagreusHome_0046", RequiredFalseTextLines = { "Ending01" }, },
				-- Hey Room, I'm back.
				{ Cue = "/VO/ZagreusHome_3743", RequiredTextLines = { "Ending01" }, },
				-- Greetings, Room.
				{ Cue = "/VO/ZagreusHome_3744", RequiredTextLines = { "Ending01" }, },
				-- Hey Room.
				{ Cue = "/VO/ZagreusHome_3745", RequiredTextLines = { "Ending01" }, },
				-- Whew.
				{ Cue = "/VO/ZagreusHome_3746", RequiredTextLines = { "Ending01" }, },
				-- I'm back, Room.
				{ Cue = "/VO/ZagreusHome_3747", RequiredTextLines = { "Ending01" }, },
				-- I missed you, Room.
				{ Cue = "/VO/ZagreusHome_3748", RequiredTextLines = { "Ending01" }, },
				-- Miss me, Room?
				{ Cue = "/VO/ZagreusHome_3749", RequiredTextLines = { "Ending01" }, },
				-- It's me, Room.
				{ Cue = "/VO/ZagreusHome_3750", RequiredTextLines = { "Ending01" }, },
			},
		},
	},

	-- ending
	-- Hades Bedroom
	DeathAreaBedroomHades =
	{
		ZoomFraction = 1.0,
		SoftClamp = 0.75,

		AmbientMusicParams =
		{
			LowPass = 1.0,
			Vocals = 1.0,
		},
		AmbientMusicVolume = 1.0,
		Ambience = "/Ambience/MusicExploration4Ambience",

		NextRoomEntranceFunctionName = "LeavingBedroomHadesPresentation",

		RemoveDashFireFx = true,
		IgnoreStemMixer = true,
		IntroSequenceDuration = 0.2,
		DebugOnly = true,
		NoAutoEquip = true,
		ShowResourceUIOnly = true,
		ShowResourceUIRequirements =
		{
			RequiredTextLines = { "HadesRevealsBadgeSeller01" },
		},
		FullscreenEffectGroup = "Foreground_01",
		SkipWeaponBinkPreLoading = true,
		RichPresence = "#RichPresence_House",

		LegalEncounters = { "Empty", },

		ReverbValue = 2.0,

		FailedToFireFunctionName = "DeathAreaAttackFailPresentation",

		CheckObjectives = { "MetaPrompt", "BedPrompt" },

		UnthreadedEvents =
		{
			{
				FunctionName = "DisableWeapons",
				Args = {},
			},
			-- Persephone's Bag
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					RequiredTextLines = { "PersephoneReturnsHome01" },
				},
				Args =
				{
					Groups = { "TravelBags" },
				},
			},
			-- Updated Bed
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					RequiredTextLines = { "PersephoneReturnsHome01" },
				},
				Args =
				{
					Groups = { "Bedding" },
				},
			},
			-- BadgeSeller / Badge Seller / Resources Director
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					RequiredTextLines = { "HadesRevealsBadgeSeller01" },
					CurrentRunValueFalse = "BadgePurchased",
				},
				Args =
				{
					Types = { "BadgeSellerGhost01", },
				},
			},
		},
		ObstacleData =
		{
			-- room exit
			[488298] =
			{
				OnUsedGameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
					RequiredAnyTextLines = { "Inspect_DeathAreaBedroomHades_Portrait_01", "Ending01" },
				},
				OnUsedFunctionName = "DeathAreaSwitchRoom",
				OnUsedFunctionArgs = { Name = "DeathArea", HeroStartPoint = 555684, HeroEndPoint = 555685 },
				InteractDistance = 140,
				AutoActivate = true,
			},

			-- BadgeSeller / Badge Seller / Resources Director
			[555853] =
			{
				Name = "BadgeSeller",
				UseText = "UseGreetNPC",
				UseTextInitial = "UseGreetNPC",
				OnUsedFunctionName = "UseBadgeSeller",
				NoSaleEmote = "StatusIconEyeRoll",
				MadeSaleEmote = "StatusIconSmile",
				InteractDistance = 140,
				AnimOffsetZ = 150,
				EmoteOffsetZ = 200,
				DestroyIfNotSetup = true,
				SetupFunctions =
				{
					{
						Name = "ShowNextBadgeForPurchase",
						Args = {},
						GameStateRequirements =
						{
							RequiredTextLines = { "BadgeSellerInfo01" },
							RequiredFalseFlags = { "InFlashback", },
						},
					},
				},
				DistanceTriggers =
				{
					{
						WithinDistance = 300,
						Emote = "StatusIconSmile",
						RequiredMinValues = { BadgeRank = 50 },
						TriggerOnceThisRun = true,
						VoiceLines =
						{
							BreakIfPlayed = true,
							RandomRemaining = true,
							SuccessiveChanceToPlayAll = 0.33,

							-- I can still rank up within my heart, I guess.
							{ Cue = "/VO/ZagreusHome_3651" },
							-- I'm at the highest rank achievable!
							{ Cue = "/VO/ZagreusHome_3652", RequiredPlayed = { "/VO/ZagreusHome_3651" }, },
							-- Suppose I'm overdue to take a break...
							{ Cue = "/VO/ZagreusHome_3653", RequiredPlayed = { "/VO/ZagreusHome_3651" }, },
							-- Keeping busy, Resources Director?
							{ Cue = "/VO/ZagreusHome_3654", RequiredPlayed = { "/VO/ZagreusHome_3651" }, },
							-- Just checking in, Resources Director.
							{ Cue = "/VO/ZagreusHome_3655", RequiredPlayed = { "/VO/ZagreusHome_3651" }, },
							-- Hey, Resources Director.
							{ Cue = "/VO/ZagreusHome_3656", RequiredPlayed = { "/VO/ZagreusHome_3651" }, },
						},
					},
					{
						WithinDistance = 400,
						Emote = "StatusIconDisgruntled",
						RequiredMaxValues = { BadgeRank = 49 },
						TriggerOnceThisRun = true,
					},
				},

				OnUsedTextLineSets =
				{
					BadgeSellerInfo01 =
					{
						PlayOnce = true,
						{ Cue = "/VO/ZagreusHome_3551", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
							PreLineAnim = "ZagreusTalkDenialStart", PreLineAnimTarget = "Hero",
							PostLineAnim = "ZagreusTalkDenialReturnToIdle", PostLineAnimTarget = "Hero",
							PreLineFunctionName = "ShowNextBadgeForPurchase",
							PostLineFunctionName = "DisplayEndingMessage",
							PostLineFunctionArgs = { Delay = 0.5, MessageId = "BadgeSystem_Message01" },
							Text = "It's been a while, Resources Director. I'll be sure to pay you a visit whenever I'm swimming in Underworld valuables and want to feel better about myself in my new role." },
					},
				},
			},

		},
		EnterVoiceLines =
		{
			{
				PlayOnce = true,
				PlayOnceContext = "HadesBedroomFirstEntry",
				BreakIfPlayed = true,
				PreLineWait = 1.0,
				UsePlayerSource = true,
				RequiredTextLinesThisRun = { "AchillesAboutHadesBedroom01" },

				-- Must be something worth a damn in here.
				{ Cue = "/VO/ZagreusHome_0336" },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "BadgeSellerFirstMeeting",
				BreakIfPlayed = true,
				PreLineWait = 1.0,
				UsePlayerSource = true,
				AreIdsAlive = { 555853 },

				-- Keeping busy, Resources Director?
				{ Cue = "/VO/ZagreusHome_3654" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 1.0,
				UsePlayerSource = true,
				RequiredTextLines = { "Ending01" },
				-- RequiredFalseTextLinesThisRun = { "Ending01" },
				SuccessiveChanceToPlay = 0.2,

				-- Father keeps things orderly I guess...
				{ Cue = "/VO/ZagreusHome_3729", PlayOnce = true },
				-- The master chambers...
				{ Cue = "/VO/ZagreusHome_3730" },
				-- Mother didn't change the decor much.
				{ Cue = "/VO/ZagreusHome_3731", PlayOnce = true },
				-- Resources Director!
				{ Cue = "/VO/ZagreusHome_3732",	AreIdsAlive = { 555853 }, },
				-- Hello, Director.
				{ Cue = "/VO/ZagreusHome_3733",	AreIdsAlive = { 555853 }, },
				-- Just me, Director.
				{ Cue = "/VO/ZagreusHome_3734",	AreIdsAlive = { 555853 }, },
				-- I'm back, Director.
				{ Cue = "/VO/ZagreusHome_3735",	AreIdsAlive = { 555853 }, },
				-- Director.
				{ Cue = "/VO/ZagreusHome_3736",	AreIdsAlive = { 555853 }, },
				-- Director?
				{ Cue = "/VO/ZagreusHome_3737",	AreIdsAlive = { 555853 }, },
			},
		},

		InspectPoints =
		{
			-- portrait
			[555700] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				RequiredFalseTextLinesThisRun = { "Ending01" },
				InteractTextLineSets =
				{
					Inspect_DeathAreaBedroomHades_Portrait_01 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							UsePlayerSource = true,
							PreLineWait = 0.45,
							-- He's never stopped thinking of her. Ugh, what a fool.
							{ Cue = "/VO/ZagreusHome_3281" },
						},
						{ Cue = "/VO/Storyteller_0350",
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							SetFlagFalse = "ZagSpecialEventInProgress",
							Text = "{#DialogueItalicFormat}In his Lord Father's very private chambers, Zagreus, the lock-removing prince, discovers a most delicately painted likeness of none other than Persephone, herself. A coat of dust suggests it has remained here for some time." },
					},
				},
			},

			-- capes
			[555701] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback" },
				InteractTextLineSets =
				{
					Inspect_DeathAreaBedroomHades_Capes_01 =
					{
						EndVoiceLines =
						{
							{
								UsePlayerSource = true,
								PreLineWait = 0.35,
								RequiredTextLines = { "LordHadesMiscEncounter05" },
								-- I knew it. It's just capes!
								{ Cue = "/VO/ZagreusHome_3282" },
							},
							{
								UsePlayerSource = true,
								PreLineWait = 0.45,
								RequiredFalseTextLines = { "LordHadesMiscEncounter05" },
								-- Tsch.
								{ Cue = "/VO/ZagreusHome_0976" },
							},
						},
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0351",
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}The stoic Lord and Master of the House possesses wealth beyond imagining, a portion of which he has used for a crisp set of attire for every passing day." },
					},
				},
			},

		},

	},

	-- Office / Administrative Room
	DeathAreaOffice =
	{
		ZoomFraction = 1.0,
		SoftClamp = 0.75,

		AmbientMusicParams =
		{
			LowPass = 1.0,
			Vocals = 1.0,
		},
		AmbientMusicVolume = 1.0,
		Ambience = "/Ambience/AdministrativeOfficeAmbience",

		RemoveDashFireFx = true,
		IgnoreStemMixer = true,
		IntroSequenceDuration = 0.5,
		DebugOnly = true,
		LinkedRoom = "RoomOpening",
		NoAutoEquip = true,
		ShowResourceUIOnly = true,
		FullscreenEffectGroup = "Foreground_01",
		SkipWeaponBinkPreLoading = true,
		RichPresence = "#RichPresence_Office",

		LegalEncounters = { "Empty", },

		ReverbValue = 1.3,

		NextRoomEntranceFunctionName = "LeavingOfficePresentation",

		FailedToFireFunctionName = "DeathAreaAttackFailPresentation",

		CheckObjectives = { "MetaPrompt", "BedPrompt" },

		StartUnthreadedEvents =
		{
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredTrueFlags = { "InFlashback", },
				},
				Args =
				{
					Types =
					{
						"NPC_Hades_Story_01",
					},
					ActivationCapMin = 1,
					ActivationCapMax = 1,
					SkipPresentation = true,
				},
			},
			{
				FunctionName = "FadeOutIds",
				GameStateRequirements =
				{
					RequiredTrueFlags = { "InFlashback", },
				},
				Args =
				{
					Ids = { 488651, 488692 },
				},
			},
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
					RequiredCosmetics = { "NyxQuestItem", },
				},
				Args =
				{
					Ids = { 488608, 488637, 488639, 488635, },
				},
			},
		},

		UnthreadedEvents =
		{
			{
				FunctionName = "DisableWeapons",
				Args = {},
			},
		},

		PostUnthreadedEvents =
		{
			{
				FunctionName = "CheckConversations",
				Args = {},
			},
		},

		ObstacleData =
		{
			[487886] =
			{
				OnUsedGameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
				},
				OnUsedFunctionName = "DeathAreaSwitchRoom",
				OnUsedFunctionArgs = { Name = "DeathArea", HeroStartPoint = 427202, HeroEndPoint = 427201 },
				InteractDistance = 140,
				AutoActivate = true,
			},

			-- RunHistory / Run History / Security Log
			[488633] =
			{
				OnUsedGameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
				},
				DisableIfUnuseable = true,
				UseText = "UseRunHistory",
				OnUsedFunctionName = "ShowRunHistoryScreen",
				OnUsedFunctionArgs = { },
				InteractDistance = 125,
				InteractOffsetX = -50,
				InteractOffsetY = -30,
			},
			-- GameStats / Game Stats / Permanent Record
			[488699] =
			{
				OnUsedGameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback", },
				},
				DisableIfUnuseable = true,
				UseText = "UseWeaponKit_LockedNoKey",
				OnUsedFunctionName = "ShowGameStatsScreen",
				OnUsedFunctionArgs = { },
				InteractDistance = 125,
				InteractOffsetX = -50,
				InteractOffsetY = -30,
			},

			-- teleporter / eldest sigil
			[487882] =
			{
				Name = "Teleporter",
				DistanceTriggers =
				{
					{
						WithinDistance = 580,
						VoiceLines =
						{
							BreakIfPlayed = true,
							RandomRemaining = true,
							CooldownTime = 8,
							PlayOnce  = true,
							UsePlayerSource = true,
							SuccessiveChanceToPlay = 0.33,

							-- The Eldest Sigil. Nyx needs it upgraded, huh.
							{ Cue = "/VO/ZagreusHome_2302", RequiredTextLines = { "NyxAboutChaos06" }, RequiredFalseCosmetics = { "NyxQuestItem" }, },
							-- The Eldest Sigil should be fully powered up for Nyx.
							{ Cue = "/VO/ZagreusHome_2303", RequiredCosmetics = { "NyxQuestItem" }, RequiredFalseTextLines = { "ChaosAboutNyx06" }, },
						},
					}
				},

			},

			-- water cooler
			[488624] =
			{
				UseText = "UseWaterCooler01",
				OnUsedGameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback" },
					RequiredTextLines = { "Inspect_DeathAreaOffice_Poster_01" },
				},
				DisableIfUnuseable = true,
				OnUsedFunctionName = "UseWaterCooler",
				OnUsedFunctionArgs = { },
				InteractDistance = 140,
			},

			-- motivational poster / office poster (thanatos)
			[488611] =
			{
				UseText = "UseOfficePoster01",
				OnUsedGameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback" },
					RequiredTextLines = { "Inspect_DeathAreaOffice_Poster_01" },
				},
				DisableIfUnuseable = true,
				OnUsedFunctionName = "UseOfficePoster",
				OnUsedFunctionArgs = { },
				InteractDistance = 130,
				InteractOffsetY = 60,
				InteractOffsetX = 25,
			},
			-- motivational poster / office poster (rope)
			[488047] =
			{
				UseText = "UseOfficePoster01",
				OnUsedGameStateRequirements =
				{
					RequiredFalseFlags = { "InFlashback" },
					RequiredTextLines = { "Inspect_DeathAreaOffice_Poster_01" },
				},
				DisableIfUnuseable = true,
				OnUsedFunctionName = "UseOfficePoster",
				OnUsedFunctionArgs = { },
				InteractDistance = 125,
				InteractOffsetY = 120,
				InteractOffsetX = 25,
			},

		},

		InspectPoints =
		{
			-- teleporter / eldest sigil
			[487903] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback", },
				RequiredAnyTextLines = { "Inspect_DeathAreaOffice_WaterCooler01", "Inspect_DeathAreaOffice_Poster_01" },
				InteractTextLineSets =
				{
					Inspect_DeathAreaOffice_Teleporter_01 =
					{
						PlayOnce = true,
						-- Could never get the blasted thing to work for me...
						EndCue = "/VO/ZagreusHome_2073",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0330",
							Text = "{#DialogueItalicFormat}Within the recesses of the administrative chamber lies the Eldest Sigil of the Master's House: a symbol of the Fate-given authority to rule beneath the earth, and means by which to travel the entirety of all that dark domain." },
					},
				},
			},
			-- water cooler
			[488662] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_01" },
				InteractTextLineSets =
				{
					Inspect_DeathAreaOffice_WaterCooler01 =
					{
						PlayOnce = true,
						-- The job's number one perk... no thanks.
						EndCue = "/VO/ZagreusHome_2389",
						RequiredMinElapsedTime = 6,
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0337",
							Text = "{#DialogueItalicFormat}The cool, purified waters of the Styx are available in limitless supply to all servants of the god of the dead authorized to work endlessly within the House administrative chamber." },
					},
				},
			},
			-- motivational poster / office poster
			[488661] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_01" },
				-- Hidden = true,
				InteractTextLineSets =
				{
					Inspect_DeathAreaOffice_Poster_01 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							UsePlayerSource = true,
							PreLineWait = 0.45,
							-- Everybody hang in there!
							{ Cue = "/VO/ZagreusHome_2400", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationName = "StatusIconDisgruntled", ReactionChance = 0.66 } },
						},
						{ Cue = "/VO/Storyteller_0336",
							Text = "{#DialogueItalicFormat}The administrative chamber's ever-working shades remain utterly dedicated to their thankless toil all because of an inspiring rendition of how dedicated they ideally should be." },
					},
				},
			},

			-- contract 1
			[488045] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback", },
				RequiredTextLines = { "NyxAboutSisyphusLiberationQuest01" },
				InteractTextLineSets =
				{
					Inspect_DeathAreaOffice_SealedContract_01 =
					{
						PlayOnce = true,
						-- I'll just patch this through to the House Contractor, then.
						EndCue = "/VO/ZagreusHome_2074",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0331",
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}Amongst the parchment-records of the dead and punished are the sealed documents known as the Knave-King's Sentence, forcing said king to endlessly toil with a boulder till the end of time." },
					},
				},
			},

			-- contract 2
			[488044] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback", },
				RequiredTextLines = { "NyxAboutSingersReunionQuest01" },
				InteractTextLineSets =
				{
					Inspect_DeathAreaOffice_SealedContract_02 =
					{
						PlayOnce = true,
						-- OK, it should be dispatched over to the House Contractor now.
						EndCue = "/VO/ZagreusHome_2075",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0332",
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}Nestled among the towering administrative parchmentwork of the long-since-deceased lies an old document concerning a special pact signed by a once-living court musician, who attempted vainly to rescue his wife from death." },
					},
				},
			},

			-- contract 3
			[488043] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredFalseFlags = { "InFlashback", },
				RequiredTextLines = { "NyxAboutMyrmidonReunionQuest01" },
				InteractTextLineSets =
				{
					Inspect_DeathAreaOffice_SealedContract_03 =
					{
						PlayOnce = true,
						-- Should be able to approve a few revisions to that one with the House Contractor I think.
						EndCue = "/VO/ZagreusHome_2570",
						EndWait = 0.35,
						{ Cue = "/VO/Storyteller_0339",
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}Buried deep within the archives, holding many binding pacts between Lord Hades and the dead, resides an old agreement; an exchange for services from an extraordinary warrior, for eternity within Elysium for his dear partner." },
					},
				},
			},

			-- Flashback 2
			[487892] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_03" },
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_01 =
					{
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.666,
								-- Oh, gods....
								{ Cue = "/VO/ZagreusHome_2119" },
							},
							[3] =
							{
								PreLineWait = 0.5,
								ObjectType = "NPC_Hades_Story_01",

								-- Get on with your responsibilities.
								{ Cue = "/VO/Hades_0807" },
							},
						},
						{ Cue = "/VO/Storyteller_0306", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							EndSecretMusic = true, PostLineSecretMusic = "/Music/MusicPlayer/HadesThemeMusicPlayer",
							Text = "{#DialogueItalicFormat}The day or night's duties are sheer simplicity itself; at least at first, as when the prince simply signs in to signal the commencement of his shift." },
					},
				},
			},

			[487904] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_02 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								-- Damn it...
								{ Cue = "/VO/ZagreusHome_2120" },
							},
							[3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0307", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}The often-failing prince attempts to sort the ledgers in the fashion necessary for the proper keeping of his father's realm." },
					},
				},
			},
			[487902] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_03 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								-- Ungh...
								{ Cue = "/VO/ZagreusHome_2121" },
							},
							[3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0308", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}The training-lacking prince's efforts to administer approvals to the judgment terms ultimately leave a lot to be desired." },
					},
				},
			},
			[487905] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_04 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								-- Oh come on.
								{ Cue = "/VO/ZagreusHome_2122" },
							},
							[3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0309", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}The hard-laboring shades responsible for the administration of the prince's father's realm merely look on at the prince's ill-fated attempts." },
					},
				},
			},
			[487906] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_05 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								-- Doesn't make any sense.
								{ Cue = "/VO/ZagreusHome_2123" },
							},
							[3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0310", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}The relaxation-loving prince never paid suitably enough attention to learn properly how to arrange the record-bookings of the regions of his father's realm." },
					},
				},
			},
			[487896] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_06 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								-- What...
								{ Cue = "/VO/ZagreusHome_2124" },
							},
							[3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0311", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}This set of delicate responsibilities is easily achieved, at least by someone capable and trained to do the work, unlike the oft-distracted Underworld Prince." },
					},
				},
			},
			[487893] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_07 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								-- I... ungh.
								{ Cue = "/VO/ZagreusHome_2125" },
							},
							[3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0312", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}A careful record must be kept of all expenses paid within the House; a delicately-handled tabulation process which the prince is ill-equipped to fully undertake." },
					},
				},
			},
			[487894] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_08 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								-- I'll do it later.
								{ Cue = "/VO/ZagreusHome_2126" },
							},
							[3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0313", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}A steadily-updated ledger of the House's income in the form of brilliant gemstones, diamonds, Darkness, and the like, is merely one among the prince's least-liked aspects of his work." },
					},
				},
			},
			[487895] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_09 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								RequiredMinElapsedTime = 8,
								-- None whatsoever, yes.
								{ Cue = "/VO/ZagreusHome_2127" },
							},
							-- [3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0314", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}Records of expired House Contractor renovations line a desk in the administrative chamber, though the prince has absolutely no desire now to organize them alphabetically, by date." },
					},
				},
			},
			[487907] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_10 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								RequiredMinElapsedTime = 8,
								-- I haven't forgotten, no one told me!
								{ Cue = "/VO/ZagreusHome_2128" },
							},
							-- [3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0315", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}Attendance records of the working-shades who toil for the House need to be verified; the shades' due compensation, rapidly approved; and yet the prince cannot remember all the necessary steps." },
					},
				},
			},
			[487897] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_11 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								RequiredMinElapsedTime = 8,
								-- Oh it's faded...
								{ Cue = "/VO/ZagreusHome_2129" },
							},
							-- [3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0316", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}Disorderly Prince Zagreus gazes upon the endless stacks of parchment-paper, each containing work-details to be registered and neatly organized, and starts to feel his optimism fade." },
					},
				},
			},
			[487898] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_12 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								RequiredMinElapsedTime = 8,
								-- Correct...
								{ Cue = "/VO/ZagreusHome_2130" },
							},
							[3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0317", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}Prince Zagreus must have some favored tasks in the administrative chamber of the House; but surely none of them include the tasks demanding his attention, here." },
					},
				},
			},
			[487899] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_13 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								-- Can't understand any of this.
								{ Cue = "/VO/ZagreusHome_2131" },
							},
							[3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0318", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}Reviewing lists of claims from shades with grievances is a very important service of the House, or so Lord Hades once attempted to impress upon his willful son." },
					},
				},
			},
			[487901] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_14 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								-- Can't understand any of this.
								{ Cue = "/VO/ZagreusHome_2131" },
							},
							[3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0333", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}A litany of complaints submitted by restless shades across the Underworld must be evaluated, organized, and processed, but Prince Zagreus does not even know where to begin." },
					},
				},
			},
			[487900] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_15 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								-- Eugh...
								{ Cue = "/VO/ZagreusField_1139" },
							},
							[3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0334", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}Supplies on all the desks in the administrative chamber must be carefully maintained and neatly placed in a specific way, which the forgetful prince has not yet memorized in full." },
					},
				},
			},
			[488698] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback" },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMaxAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 6 },
				DeactivateIfIneligible = true,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_16 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.25,
								-- Eh...
								{ Cue = "/VO/ZagreusField_1142" },
							},
							[3] = GlobalVoiceLines.HadesFeedbackVoiceLines,
						},
						{ Cue = "/VO/Storyteller_0335", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}Security reports concerning failed escape attempts from Tartarus require timely verification and official response, neither of which Prince Zagreus is fit to give." },
					},
				},
			},

			[487908] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTrueFlags = { "InFlashback", },
				RequiredTextLines = { "Flashback_DayNightJob_Office_01" },
				RequiredMinAnyTextLines = { TextLines = GameData.Flashback2WorkLines, Count = 7 },
				DeactivateIfIneligible = true,
				ClearNextInteractLinesOnActivate = 487891,
				InteractTextLineSets =
				{
					Flashback_DayNightJob_Office_Conclusion_01 =
					{
						PlayOnce = true,
						EndVoiceLines =
						{
							[1] = GlobalVoiceLines.RushedStorytellerVoiceLines,
							[2] =
							{
								UsePlayerSource = true,
								PreLineWait = 0.5,
								-- OK, I'm done, so... can I go yet, Father?
								{ Cue = "/VO/ZagreusHome_2132" },
							},
							[3] =
							{
								PreLineWait = 0.6,
								ObjectType = "NPC_Hades_Story_01",
								-- <Scoffing>
								{ Cue = "/VO/Hades_0079" },
							},
						},
						{ Cue = "/VO/Storyteller_0319", PostLineFunctionName = "AdvanceFlashback",
							PreLineAnim = "ZagreusInteractEquip", PreLineAnimTarget = "Hero",
							Text = "{#DialogueItalicFormat}At last, the work-disliking prince records a summary of the results of his attempts to be of any use to the administrative needs of his grim father's House." },
					},
				},
			},

		},

		EnteredVoiceLines =
		{
			{
				PlayOnce = true,
				RequiredFalseFlags = { "InFlashback" },
				PreLineWait = 1.0,
				BreakIfPlayed = true,
				RequiredFalseCosmetics = { "SisyphusQuestItem" },
				RequiredTextLines = { "NyxAboutSisyphusLiberationQuest01" },
				RequiredFalseTextLines = { "SisyphusLiberationQuestComplete" },

				-- Should check that stack of contracts back there.
				{ Cue = "/VO/ZagreusHome_2084" },
			},
			{
				PlayOnce = true,
				RequiredFalseFlags = { "InFlashback" },
				PreLineWait = 1.0,
				BreakIfPlayed = true,
				RequiredFalseCosmetics = { "OrpheusEurydiceQuestItem" },
				RequiredTextLines = { "NyxAboutSingersReunionQuest01" },

				-- Contract I'm looking for should be back there.
				{ Cue = "/VO/ZagreusHome_2085" },
			},
			{
				PlayOnce = true,
				RequiredFalseFlags = { "InFlashback" },
				PreLineWait = 1.0,
				BreakIfPlayed = true,
				RequiredFalseCosmetics = { "AchillesPatroclusQuestItem" },
				RequiredTextLines = { "NyxAboutMyrmidonReunionQuest01" },

				-- Should check the admin chamber for the pact Nyx mentioned...
				{ Cue = "/VO/ZagreusHome_2569" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				RequiredFalseFlags = { "InFlashback" },
				PreLineWait = 1.0,
				SuccessiveChanceToPlay = 0.5,
				PlayOnceFromTableThisRun = true,

				-- Never thought I'd come back here again...
				{ Cue = "/VO/ZagreusHome_2076", PlayOnce = true },
				-- Greetings everyone! Just visiting...
				{ Cue = "/VO/ZagreusHome_2077", RequiredPlayed = { "/VO/ZagreusHome_2076" }, PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationName = "StatusIconDisgruntled", ReactionChance = 0.5 } },
				-- How's everybody doing?
				{ Cue = "/VO/ZagreusHome_2078", PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationName = "StatusIconDisgruntled", ReactionChance = 0.5 } },
				-- Hello, I'll only be a moment!
				{ Cue = "/VO/ZagreusHome_2079", RequiredPlayed = { "/VO/ZagreusHome_2076" }, PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationName = "StatusIconDisgruntled", ReactionChance = 0.4 } },
				-- Just checking up on things!
				{ Cue = "/VO/ZagreusHome_2080", RequiredPlayed = { "/VO/ZagreusHome_2076" }, PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationName = "StatusIconDisgruntled", ReactionChance = 0.4 } },
				-- Just thought I'd say hello!
				{ Cue = "/VO/ZagreusHome_2081", RequiredPlayed = { "/VO/ZagreusHome_2076" }, PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationName = "StatusIconDisgruntled", ReactionChance = 0.5 } },
				-- Oh don't mind me!
				{ Cue = "/VO/ZagreusHome_2082", RequiredPlayed = { "/VO/ZagreusHome_2076" }, PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationName = "StatusIconDisgruntled", ReactionChance = 0.3 } },
				-- Just me, pretend I'm not even here.
				{ Cue = "/VO/ZagreusHome_2083", RequiredPlayed = { "/VO/ZagreusHome_2076" }, PostLineFunctionName = "CrowdReactionPresentationEventSource", PostLineFunctionArgs = { AnimationName = "StatusIconDisgruntled", ReactionChance = 0.3 } },
			},
			{
				{
					-- Sorry...!
					{ Cue = "/VO/ZagreusHome_2118", RequiredTrueFlags = { "InFlashback" }, PreLineWait = 0.6 },
				},
				{
					PreLineWait = 0.7,
					ObjectType = "NPC_Hades_Story_01",

					-- You're late, boy! Again.
					{ Cue = "/VO/Hades_0806" },
				},
			},
		},

	},

	-- RoomPreRun / Courtyard
	RoomPreRun =
	{
		InheritFrom = { "BaseTartarus" },
		SkipLastKillPresentation = true,
		CheckWeaponHistory = true,
		UseBiomeMap = true,
		BiomeMapArea = "Home",
		RichPresence = "#RichPresence_RoomPreRun",
		ZoomFraction = 0.95,
		IgnoreStemMixer = true,
		Ambience = "/Ambience/MusicExploration4Ambience",
		KeepsakeFreeSwap = true,
		ShowShrinePoints = true,
		AllowAssistFailedPresentation = true,
		IntroSequenceDuration = 0.80,
		CameraZoomWeights =
		{
			[420907] = 1.0,
			[420906] = 0.75,
		},
		SoftClamp = 0.75,
		LowSpeedThreshold = 0.0,

		BinkSet = "Weapons",

		AmbientMusicParams =
		{
			LowPass = 1.0,
			Vocals = 0.0,
		},
		AmbientMusicVolume = 0.0,

		SkipWeaponBinkPreLoading = true,

		StartUnthreadedEvents =
		{
			{
				FunctionName = "AssignWeaponKits",
				Args =
				{
					PreLoadBinks = true,
					BinkCacheOverrides =
					{
						SpearWeapon = "WeaponCache",
					}
				},
			},
			-- skelly activation requirements
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredTrueFlags = { "SkellyUnlocked", },
					RequiredRunsCleared = 0,
				},
				Args =
				{
					Types =
					{
						"TrainingMelee",
					},
					ActivationCapMin = 0,
					ActivationCapMax = 1,
					SkipPresentation = true,
				},
			},
			-- skelly: always spawn after first clear
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredTextLinesThisRun = "PersephoneFirstMeeting",
				},
				Args =
				{
					Types =
					{
						"TrainingMelee",
					},
					ActivationCapMin = 0,
					ActivationCapMax = 1,
					SkipPresentation = true,
				},
			},
			-- skelly: always spawn on returns to PreRun if already spawned that run
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					CurrentRunValueTrue = "SkellySpawned",
				},
				Args =
				{
					Types =
					{
						"TrainingMelee",
					},
					ActivationCapMin = 1,
					ActivationCapMax = 1,
					SkipPresentation = true,
				},
			},
			-- skelly: once trophy quest is available/started, he is always present
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredTrueFlags = { "SkellyUnlocked", },
					RequiredMinRunsCleared = 5,
				},
				Args =
				{
					Types =
					{
						"TrainingMelee",
					},
					ActivationCapMin = 1,
					ActivationCapMax = 1,
					SkipPresentation = true,
				},
			},
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredTrueFlags = { "SkellyUnlocked", },
					RequiredTextLines = { "TrophyQuest_Beginning_01" },
					RequiredFalseTextLines = { "TrophyQuest_GoldUnlocked_01" },
				},
				Args =
				{
					Types =
					{
						"TrainingMelee",
					},
					ActivationCapMin = 1,
					ActivationCapMax = 1,
					SkipPresentation = true,
				},
			},
			-- skelly: if trophy quest is completed, he may resume not spawning in again
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					RequiredTrueFlags = { "SkellyUnlocked", },
					RequiredTextLines = { "TrophyQuest_GoldUnlocked_01" },
				},
				Args =
				{
					Types =
					{
						"TrainingMelee",
					},
					ActivationCapMin = 0,
					ActivationCapMax = 1,
					SkipPresentation = true,
				},
			},
			{
				FunctionName = "CheckConversations",
				Args = {},
			},
			{
				FunctionName = "EquipLastAwardTrait",
				Args = {},
			},
			{
				FunctionName = "EquipLastAssistTrait",
				Args = {},
			},
			{
				FunctionName = "EquipLastWeaponUpgrade",
				Args = {},
			},
			{
				FunctionName = "UpdateGiftRackShineStatus"
			},
			{
				FunctionName = "SetupExitDoor"
			},
		},

		ThreadedEvents =
		{
			{
				FunctionName = "HandleWeaponAspectsRevealObjective",
			},
		},

		ObstacleData =
		{
			-- Bronze ShrinePoint Clear / Statue
			[487422] =
			{
				UseText = "UseShrinePointClear_Available",
				InProgressUseText = "UseShrinePointClear_InProgress",
				CompleteUseText = "UseShrinePointClear_Complete",
				AllCompleteUseText = "UseShrinePointClear_QuestCleared",
				InteractDistance = 300,
				SetupFunctionName = "SetupShrinePointClearObject",
				OnUsedFunctionName = "UseShrinePointClearObject",
				OnHitFunctionName = "StatueHitPresentation",
				GoalShrinePointClear = 8,
				AttractAnimation = "TrophySparkleEmitter",
				CompleteAnimation = "HouseStatueSkelly01",
				NextGoalId = 487421,
				SetupGameStateRequirements =
				{
					RequiredTrueFlags = { "ShrineUnlocked", "SkellyUnlocked", },
					RequiredMinRunsCleared = 5,
				},
				DestroyIfNotSetup = true,

				OnTrophyRevealedTextLineSets =
				{
					TrophyQuest_Beginning_01 =
					{
						PlayOnce = true,

						-- Yes, a little bit, if you must know.
						EndCue = "/VO/ZagreusHome_0676",
						EndWait = 0.55,
						{ Cue = "/VO/Skelly_0178", Portrait = "Portrait_Skelly_Default_01", Speaker = "NPC_Skelly_01",
							Text = "I'll level with you, pal. You have impressed somebody well above my pay grade here, and so... they have a little proposition for you, you listening?" },
						{ Cue = "/VO/ZagreusHome_1054", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
							Text = "Let me guess... they want me to fight all the way through the Underworld, having used the Pact of Punishment over there to make the going even more treacherous than it already is, and if I succeed, they'll reward me with some sort of useless trinket?" },
						{ Cue = "/VO/Skelly_0179", Portrait = "Portrait_Skelly_Default_01", Speaker = "NPC_Skelly_01",
							SetFlagTrue = "TrophyQuestActive",
							Emote = "PortraitEmoteFiredUp",
							Text = "Wrong! We're talking something really big, here, pal, you see that thing back there? Trinket. Come on, what are you, scared?" },
					},
				},

				SourceName = "TrainingMelee",
				OnTrophyUnlockedTextLineSets =
				{
					TrophyQuest_BronzeUnlocked_01 =
					{
						PlayOnce = true,

						-- I'll temper my expectations just in case.
						EndCue = "/VO/ZagreusHome_0679",
						EndWait = 0.5,
						{ Cue = "/VO/Skelly_0183", Portrait = "Portrait_Skelly_Default_01", Speaker = "NPC_Skelly_01",
							Emote = "PortraitEmoteSparkly",
							Text = "I just knew you had it in you, pal, enjoying your new prize? Pact of Punishment, {#DialogueItalicFormat}Shmact {#PreviousFormat}of Punishment, no problem, know what I mean? 'Course, that was just the easy one you got there, pretty sure I could've got that one, myself." },
						{ Cue = "/VO/ZagreusHome_0678", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
							PreLineAnim = "ZagreusInteractionThoughtful", PreLineAnimTarget = "Hero",
							Text = "Wait, just so I understand. I literally toiled through hell and back, and my reward is just... a statue of you? Don't get me wrong, it's lovely, it's just... I don't know what I expected." },
						{ Cue = "/VO/Skelly_0184",
							Emote = "PortraitEmoteNervous",	
							Portrait = "Portrait_Skelly_Default_01", Speaker = "NPC_Skelly_01",
							PostLineThreadedFunctionName = "StatueUnlockedPresentation", PostLineFunctionArgs = { Subtitle = "ShrinePointStatue_Unlocked_Subtitle_01" },
							Text = "Look, boyo, there was a little mix-up when we put in the request for that thing, see? I told 'em to make something that'll make me look good with my sources, and anyway that's how it all turned out. The other ones turned out much better, though, you'll see!" },
					},
				},

			},
			-- Silver ShrinePoint Clear / Statue
			[487421] =
			{
				UseText = "UseShrinePointClear_Available",
				InProgressUseText = "UseShrinePointClear_InProgress",
				CompleteUseText = "UseShrinePointClear_Complete",
				AllCompleteUseText = "UseShrinePointClear_QuestCleared",
				InteractDistance = 300,
				SetupFunctionName = "SetupShrinePointClearObject",
				OnUsedFunctionName = "UseShrinePointClearObject",
				OnHitFunctionName = "StatueHitPresentation",
				GoalShrinePointClear = 16,
				AttractAnimation = "TrophySparkleEmitter",
				CompleteAnimation = "HouseStatueSkelly02",
				FlipHorizontalOnComplete = true,
				PrevGoalId = 487422,
				NextGoalId = 487120,
				SetupGameStateRequirements =
				{
					RequiredTrueFlags = { "ShrineUnlocked", "SkellyUnlocked", },
					RequiredMinRunsCleared = 5,
				},
				DestroyIfNotSetup = true,

				SourceName = "TrainingMelee",
				OnTrophyUnlockedTextLineSets =
				{
					TrophyQuest_SilverUnlocked_01 =
					{
						PlayOnce = true,
						-- I guess they're stuck here then just like we are.
						EndCue = "/VO/ZagreusHome_0683",
						EndWait = 0.5,
						{ Cue = "/VO/ZagreusHome_0681", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
							Text = "Skelly, let me ask you something. Did you really commission three nearly-identical statues of yourself to goad me into using the Pact of Punishment?" },
						{ Cue = "/VO/Skelly_0188", Portrait = "Portrait_Skelly_Default_01", Speaker = "NPC_Skelly_01",
							Emote = "PortraitEmoteFiredUp",
							Text = "I am offended, pal! You haven't even seen the third one yet, so how can you insinuate a thing like that?! Maybe I was wrong about you. I thought you really were the one!" },
						{ Cue = "/VO/ZagreusHome_0682", Portrait = "Portrait_Zag_Defiant_01", Speaker = "CharProtag",
							PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
							PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
							Text = "You're only saying that to get me to apologize and try and unlock the last of your three identical statues, aren't you." },
						{ Cue = "/VO/Skelly_0189", Portrait = "Portrait_Skelly_Default_01", Speaker = "NPC_Skelly_01",
							Emote = "PortraitEmoteSurprise",
							PostLineThreadedFunctionName = "StatueUnlockedPresentation", PostLineFunctionArgs = { Subtitle = "ShrinePointStatue_Unlocked_Subtitle_02" },
							Text = "{#DialogueItalicFormat}How could you{#PreviousFormat}--? I would return those statues for a full refund right here and now, if I could move! And if there was a refund policy on them." },
					},
				}
			},
			-- Gold ShrinePoint Clear / Statue
			[487120] =
			{
				UseText = "UseShrinePointClear_Available",
				InProgressUseText = "UseShrinePointClear_InProgress",
				CompleteUseText = "UseShrinePointClear_Complete",
				AllCompleteUseText = "UseShrinePointClear_QuestCleared",
				InteractDistance = 300,
				SetupFunctionName = "SetupShrinePointClearObject",
				OnUsedFunctionName = "UseShrinePointClearObject",
				OnHitFunctionName = "StatueHitPresentation",
				GoalShrinePointClear = 32,
				AttractAnimation = "TrophySparkleEmitter",
				CompleteAnimation = "HouseStatueSkelly04",
				PrevGoalId = 487421,
				SetupGameStateRequirements =
				{
					RequiredTrueFlags = { "ShrineUnlocked", "SkellyUnlocked", },
					RequiredMinRunsCleared = 5,
				},
				DestroyIfNotSetup = true,

				SourceName = "TrainingMelee",
				OnTrophyUnlockedTextLineSets =
				{
					TrophyQuest_GoldUnlocked_01 =
					{
						PlayOnce = true,

						-- We certainly have, Mate. And we certainly do.
						EndCue = "/VO/ZagreusHome_0687",
						EndWait = 0.5,
						{ Cue = "/VO/Skelly_0193", Portrait = "Portrait_Skelly_Default_01", Speaker = "NPC_Skelly_01",
							SetFlagFalse = "TrophyQuestActive",
							Emote = "PortraitEmoteDepressed",
							Text = "Look I'm sorry I messed up your statues, boyo. Really. When I saw them, I just kind of freaked. But then I figured there's no way he's going to see how they turned out, so, I just rolled with it, you know?" },
						{ Cue = "/VO/ZagreusHome_0686", Portrait = "Portrait_Zag_Default_01", Speaker = "CharProtag",
							PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
							PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
							Text = "You shouldn't have underestimated me, mate. But... I shouldn't have said such awful things about your statues. You must have really gone out of your way to get them here." },
						{ Cue = "/VO/Skelly_0194", Portrait = "Portrait_Skelly_Default_01", Speaker = "NPC_Skelly_01",
							PostLineThreadedFunctionName = "StatueUnlockedPresentation", PostLineFunctionArgs = { Subtitle = "ShrinePointStatue_Unlocked_Subtitle_03" },
							Emote = "PortraitEmoteFiredUp",
							Text = "Oh you better believe it, pal! So how about we call it even. We've been through a lot. Both of us! Really learned from this experience, and now, we share a deeper understanding, yeah?" },
					},
				}
			},

			-- Run Start Door / New Run Door / Pact Door
			[420947] =
			{
				UseText = "UseReviveDoors",
				ShrineUseText = "UsePactDoors",
				OnUsedFunctionName = "UseEscapeDoor",
			},
			-- SeedController
			[487568] =
			{
				UseText = "UseSeedController",
				AvailableAnimation = "ShrinePointDoor_Revealed",
				OnUsedFunctionName = "UseSeedController",
				SetupGameStateRequirements =
				{
					RequiredCosmetics = { "SeedController" },
				},
				Activate = true,
				--DestroyIfNotSetup = true,
			},
			--[[
			-- Onslaught Door1
			[487567] =
			{
				UseText = "UseOnslaughtDoor",
				UseTextLocked = "UseOnslaughtDoor_Recharging",
				AvailableAnimation = "ShrinePointDoor_Revealed",
				SetupFunctionName = "SetupOnslaught",
				OnUsedFunctionName = "StartOnslaught",
				Slot = 1,
				SetupGameStateRequirements =
				{
					RequiredSeenRooms = { "B_Boss01" },
				},
				DestroyIfNotSetup = true,
			},
			-- Onslaught Door3
			[487569] =
			{
				UseText = "UseOnslaughtDoor",
				UseTextLocked = "UseOnslaughtDoor_Recharging",
				AvailableAnimation = "ShrinePointDoor_Revealed",
				SetupFunctionName = "SetupOnslaught",
				OnUsedFunctionName = "StartOnslaught",
				Slot = 3,
				SetupGameStateRequirements =
				{
					RequiredSeenRooms = { "B_Boss01" },
				},
				DestroyIfNotSetup = true,
			},
			--]]
			[421119] =
			{
				SetupGameStateRequirements =
				{
					RequiredFalseConfigOptions = { "KioskMode" },
				},
				DestroyIfNotSetup = true,

				OnUsedFunctionName = "DeathAreaSwitchRoom",
				OnUsedFunctionArgs = { Name = "DeathAreaBedroom", HeroStartPoint = 390514, HeroEndPoint = 390515 },
				InteractDistance = 140,
				AutoActivate = true,
				OnUsedVoiceLines =
				{
					PlayOnceFromTableThisRun = true,
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 2.5,

					-- My escape route's back the other way.
					{ Cue = "/VO/ZagreusHome_0461", RequiredCompletedRuns = 0 },
					-- I can escape from the courtyard back there.
					-- { Cue = "/VO/ZagreusHome_0462", RequiredCompletedRuns = 0 },
				},
			},
		},

		EnterVoiceLines =
		{
			-- Trophy Quest
			{
				{
					PlayOnce = true,
					PreLineWait = 1.0,
					RequiredTrueFlags = { "ShrineUnlocked", "SkellyUnlocked", },
					RequiredMinRunsCleared = 5,
 					ObjectType = "TrainingMelee",
					CooldownName = "SkellySpeechCooldown",
					CooldownTime = 12,

					-- Good, just the boyo I wanted to see, c'mere!
					-- { Cue = "/VO/Skelly_0175" },
					-- Get a load of them prizes over there.
					{ Cue = "/VO/Skelly_0177", PlayOnce = true, },
				},
				{
					PreLineWait = 0.3,
					PlayOnce = true,
					BreakIfPlayed = true,
					RequiredTrueFlags = { "ShrineUnlocked", "SkellyUnlocked", },
					RequiredMinRunsCleared = 5,
					Cooldowns =
					{
						{ Name = "ZagreusMiscHouseSpeech", Time = 10 },
					},

					-- What's all this...?
					{ Cue = "/VO/ZagreusHome_0674" },
				}
			},
			{
				PlayOnceFromTableThisRun = true,
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.65,
				ChanceToPlayAgain = 0.1,
				AreIdsNotAlive = { 420928 },

				-- OK...
				{ Cue = "/VO/ZagreusField_0258",
					Cooldowns =
					{
						{ Name = "ZagreusMiscHouseSpeech", Time = 10 },
					},
				},
				-- I should go.
				{ Cue = "/VO/ZagreusScratch_0024", RequiredPlayed = { "/VO/ZagreusField_0258" },
					Cooldowns =
					{
						{ Name = "ZagreusMiscHouseSpeech", Time = 10 },
						{ Name = "SaidGoRecently", Time = 40 },
					},
				},
			},
		},

		DistanceTriggers =
		{
			-- Overlook
			{
				TriggerGroup = "OverlookOut", WithinDistance = 300, FunctionName = "PreRunOverlook", Repeat = true,
			},
			{
				TriggerGroup = "OverlookIn", WithinDistance = 150, FunctionName = "PreRunBackToRoom", Repeat = true,
			},
			-- NewRunDoor / Exit Door
			{
				TriggerObjectType = "NewRunDoor", WithinDistance = 1050,
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					Queue = "Always",
					Cooldowns =
					{
						{ Name = "ZagreusPreRunExitHintVoiceLines", Time = 8 },
					},
					{
						-- I can escape through that pink window there.
						{ Cue = "/VO/ZagreusHome_0458", PreLineWait = 0.5, RequiredCompletedRuns = 0, RequiredFalseFlags = { "HardMode" } },
						-- I can escape through that sinister window there.
						{ Cue = "/VO/ZagreusHome_1434", PreLineWait = 0.5, RequiredCompletedRuns = 0, RequiredTrueFlags = { "HardMode" } },
						-- That's my way out.
						-- { Cue = "/VO/ZagreusHome_0459", PreLineWait = 0.5, RequiredCompletedRuns = 0 },
						-- There's my escape.
						-- { Cue = "/VO/ZagreusHome_0460", PreLineWait = 0.5, RequiredCompletedRuns = 0 },
						-- The exit... that's a Pact of Punishment on it.
						{ Cue = "/VO/ZagreusHome_1056", RequiredMinRunsCleared = 1, PlayOnce = true, RequiredScreenViewedFalse = "ShrineUpgrade", RequiredFalsePlayed = { "/VO/ZagreusHome_1055", "/VO/ZagreusHome_1057", "/VO/Skelly_0273", "/VO/ZagreusHome_1126" }, AreIdsNotAlive = { 420928 } },
						-- Is that the Pact of Punishment...?
						{ Cue = "/VO/ZagreusHome_1057", RequiredMinRunsCleared = 1, PlayOnce = true, RequiredScreenViewedFalse = "ShrineUpgrade", RequiredPlayed = { "/VO/ZagreusHome_1055", "/VO/Skelly_0273" }, RequiredFalsePlayed = { "/VO/ZagreusHome_1056", "/VO/ZagreusHome_1126" }, AreIdsNotAlive = { 420928 } },
					},
				},
			},
			-- Onslaught Doors
			{
				TriggerObjectType = "ShrinePointDoor", WithinDistance = 500,
				VoiceLines =
				{
					-- Hey look at that.
					-- { Cue = "/VO/ZagreusField_0707" },
				},
			},

			-- Fists / FistWeapon
			{
				TriggerObjectType = "WeaponKit01", WithinDistance = 325,
				TriggerOnceThisRun = true,
				RequiredTrueFlags = { "FistUnlocked" },
				RequiredFalseWeaponsUnlocked = { "FistWeapon" },
				VoiceLines =
				{
					-- Another weapon...
					{ Cue = "/VO/ZagreusHome_2033", RequiredPlayedThisRoom = { "/VO/Skelly_0458" } },
					-- It's the Twin Fists...
					-- { Cue = "/VO/ZagreusHome_2032", RequiredPlayedThisRoom = { "/VO/Skelly_0458" } },
				},
			},
			-- Rail
			{
				TriggerObjectType = "WeaponKit01", WithinDistance = 325,
				TriggerOnceThisRun = true,
				RequiredTrueFlags = { "GunUnlocked" },
				RequiredFalseWeaponsUnlocked = { "GunWeapon" },
				VoiceLines =
				{
					-- Hey look at that.
					{ Cue = "/VO/ZagreusField_0707", RequiredPlayedThisRoom = { "/VO/Skelly_0243" } },
				},
			},

			-- Skelly
			{
				TriggerObjectType = "TrainingMelee", WithinDistance = 700,
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					-- True Death Quest
					{
						BreakIfPlayed = true,
						CooldownName = "SkellySpeechCooldown",
						CooldownTime = 12,
						RequiredQueuedTextLines = "SkellyTrueDeathQuest_Beginning_01",
						RequiredFalseTextLines = { "SkellyTrueDeathQuest_Beginning_01" },

						-- Hey, pal, wanted to talk to you...
						{ Cue = "/VO/Skelly_0306" },
					},
					{
						BreakIfPlayed = true,
						CooldownName = "SkellySpeechCooldown",
						CooldownTime = 12,
						RequiredQueuedTextLines = "SkellyTrueDeathQuest_Beginning_01B",
						RequiredFalseTextLines = { "SkellyTrueDeathQuest_Beginning_01B" },

						-- Hey, pal, wanted to talk to you...
						{ Cue = "/VO/Skelly_0306" },
					},
					-- FistWeapon
					{
						BreakIfPlayed = true,
						RequiredTrueFlags = { "FistUnlocked" },
						RequiredFalseWeaponsUnlocked = { "FistWeapon" },

						-- Hey, uh, something back there for you, pal!
						{ Cue = "/VO/Skelly_0458", PlayOnce = true, },
					},
					-- GunWeapon
					{
						BreakIfPlayed = true,
						RequiredTrueFlags = { "GunUnlocked" },
						RequiredFalseWeaponsUnlocked = { "GunWeapon" },

						-- Special delivery for you back there, boyo!
						{ Cue = "/VO/Skelly_0243", PlayOnce = true, },
					},
					-- Easy Mode
					{
						PlayOnce = true,
						PlayOnceContext = "SkellyEasyMode",
						BreakIfPlayed = true,
						RequiredQueuedTextLines = { "SkellyHintMeeting_EasyMode01" },

						-- Hey, may I have your attention for a sec?
						{ Cue = "/VO/Skelly_0401" },
					},
					-- New Pact
					{
						RequiredMinRunsCleared = 1,
						CooldownName = "SkellySpeechCooldown",
						CooldownTime = 12,
						RequiredScreenViewedFalse = "ShrineUpgrade",
						-- Uh, might want to see this, boyo, over to my left?
						-- { Cue = "/VO/Skelly_0272", PlayOnce = true, },
						-- Look what they did to your pink window, pal!!
						{ Cue = "/VO/Skelly_0273", RequiredQueuedTextLines = "SkellyAboutPact01", PlayOnce = true, RequiredFalsePlayed = { "/VO/ZagreusHome_1056", "/VO/ZagreusHome_1057", "/VO/ZagreusHome_1126" } },
						{
							BreakIfPlayed = true,
							PreLineWait = 0.35,
							UsePlayerSource = true,
							-- The exit... that's a Pact of Punishment on it.
							{ Cue = "/VO/ZagreusHome_1056", PlayOnce = true, RequiredFalsePlayed = { "/VO/ZagreusHome_1055", "/VO/ZagreusHome_1057" } },
							-- Is that the Pact of Punishment...?
							{ Cue = "/VO/ZagreusHome_1057", PlayOnce = true, RequiredPlayed = { "/VO/ZagreusHome_1055" }, RequiredFalsePlayed = { "/VO/ZagreusHome_1056" } },
						}
					},
					{
						BreakIfPlayed = true,
						RequiresRunCleared = true,
						RequiredActiveShrinePointsMin = 1,
						RequiredMinShrinePointThresholdClear = 1,
						RequiredMinCompletedRuns = 1,
						RequiredScreenViewed = "ShrineUpgrade",
						CooldownName = "SkellySpeechCooldown",
						CooldownTime = 12,
						-- Hey, the Pact lit up, you must have done something!
						{ Cue = "/VO/Skelly_0275", PlayOnce = true, },
					},
					-- Weapon Enchantments / Weapon Aspects
					{
						BreakIfPlayed = true,
						RequiredQueuedTextLines = "SkellyAboutWeaponEnchantments01",

						-- Might want to check your stash of weapons over there...
						{ Cue = "/VO/Skelly_0249", PlayOnce = true, },
					},
					-- Trophy Quest
					{
						BreakIfPlayed = true,
						RequiredTrueFlags = { "TrophyQuestActive" },

						-- Hah you did it, boyo! Reward's right over there!
						{ Cue = "/VO/Skelly_0180", RequiredMinShrinePointThresholdClear = 8, RequiredFalseTextLines = { "TrophyQuest_BronzeUnlocked_01" }, PlayOnce = true, },
						-- Whoa-hoh you earned yourself another one, congrats!
						{ Cue = "/VO/Skelly_0185", RequiredMinShrinePointThresholdClear = 16, RequiredFalseTextLines = { "TrophyQuest_BronzeUnlocked_01", "TrophyQuest_SilverUnlocked_01" }, PlayOnce = true, },
						-- Well I'll be a hellhound's hindquarters, you really pulled it off.
						{ Cue = "/VO/Skelly_0186", RequiredMinShrinePointThresholdClear = 32, RequiredFalseTextLines = { "TrophyQuest_BronzeUnlocked_01", "TrophyQuest_SilverUnlocked_01", "TrophyQuest_GoldUnlocked_01" }, PlayOnce = true, },
					},

					-- Relationship Improved
					{
						RandomRemaining = true,
						UsePlayerSource = true,
						SuccessiveChanceToPlay =  0.25,
						RequiredPlayed = { "/VO/ZagreusField_0258" },
						RequiredFalseTextLinesThisRun = { "PersephoneMeeting05_A", "PersephoneMeeting05_B" },

						-- Hey mate.
						{ Cue = "/VO/ZagreusField_0340", RequiredTextLines = { "SkellyGift02" }, },
						-- Hey Skelly.
						{ Cue = "/VO/ZagreusField_0345", RequiredTextLines = { "SkellyGift05" }, },
						-- Hey, I'm back.
						{ Cue = "/VO/ZagreusHome_1398", RequiredTextLines = { "SkellyGift02" }, },
						-- Skelly!
						{ Cue = "/VO/ZagreusHome_1399", RequiredTextLines = { "SkellyGift03" }, },
						-- What's going on, Skelly?
						{ Cue = "/VO/ZagreusHome_1400", RequiredTextLines = { "SkellyGift06" }, },
						-- How's it going, Skelly?
						{ Cue = "/VO/ZagreusHome_1401", RequiredTextLines = { "SkellyGift05" }, },
						-- What's new, Skelly?
						{ Cue = "/VO/ZagreusHome_1402", RequiredTextLines = { "SkellyGift06" }, },
						-- Schelemeus.
						{ Cue = "/VO/ZagreusHome_3524", RequiredTextLines = { "SkellyBackstory03" }, },
						-- Captain.
						{ Cue = "/VO/ZagreusHome_3525", RequiredTextLines = { "SkellyBackstory05" }, },
						-- Skelly.
						{ Cue = "/VO/ZagreusHome_3526", RequiredTextLines = { "SkellyFirstMeeting" }, },
						-- What's going on, Skelly.
						{ Cue = "/VO/ZagreusHome_3527", RequiredTextLines = { "SkellyGift01" }, },
						-- Hey.
						{ Cue = "/VO/ZagreusHome_3528", RequiredTextLines = { "SkellyFirstMeeting" }, },
						-- How's it going.
						{ Cue = "/VO/ZagreusHome_3529", RequiredTextLines = { "SkellyFirstMeeting" }, },
					},
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						PreLineWait = 0.3,
						SuccessiveChanceToPlay =  0.33,
						RequiredFalseTextLinesThisRun = { "PersephoneMeeting05_A", "PersephoneMeeting05_B" },

						-- What's up, boyo.
						{ Cue = "/VO/Skelly_0048" },
						-- 'Bout time you showed up!
						{ Cue = "/VO/Skelly_0122" },
						-- They always come back.
						{ Cue = "/VO/Skelly_0123" },
						-- Been waiting over here!
						{ Cue = "/VO/Skelly_0124" },
						-- Right on schedule!
						{ Cue = "/VO/Skelly_0125" },
						-- Hey!
						{ Cue = "/VO/Skelly_0126" },
						-- Been here the whole time!
						{ Cue = "/VO/Skelly_0127" },
						-- Haven't moved a muscle!
						{ Cue = "/VO/Skelly_0128" },
						-- There he is!
						{ Cue = "/VO/Skelly_0133" },
						-- Oh hey.
						{ Cue = "/VO/Skelly_0134" },
						-- What's the good word?
						{ Cue = "/VO/Skelly_0135" },
						-- Any luck last time?
						{ Cue = "/VO/Skelly_0136" },
						-- Looking good!
						{ Cue = "/VO/Skelly_0137" },
						-- Who's this handsome fellow?
						{ Cue = "/VO/Skelly_0148", RequiredTextLines = { "SkellyGift09" } },
						-- Hey I know that guy.
						{ Cue = "/VO/Skelly_0150", RequiredTextLines = { "SkellyGift06" } },
						-- Look at this guy over here.
						{ Cue = "/VO/Skelly_0151", RequiredTextLines = { "SkellyGift05" } },
						-- Hey how's it going?
						{ Cue = "/VO/Skelly_0152", RequiredTextLines = { "SkellyGift05" } },
						-- Heya.
						{ Cue = "/VO/Skelly_0506" },
						-- Hey, pal.
						{ Cue = "/VO/Skelly_0507" },
						-- Boyo.
						{ Cue = "/VO/Skelly_0508" },
						-- Boyo!
						{ Cue = "/VO/Skelly_0509" },
						-- Hey.
						{ Cue = "/VO/Skelly_0510" },
						-- There you are.
						{ Cue = "/VO/Skelly_0511" },
						-- I knew it.
						{ Cue = "/VO/Skelly_0512" },
						-- Back, huh.
						{ Cue = "/VO/Skelly_0513" },
						-- Need some practicing?
						{ Cue = "/VO/Skelly_0514" },
						-- Finally!
						{ Cue = "/VO/Skelly_0515" },
					}
				},
			},
		},

		ReverbValue = 1.5,

		InspectPoints =
		{
			[390005] =
			{
				PlayOnce = true,
				RequiredMinCompletedRuns = 2,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					InspectPreRun01 =
					{
						-- It's not that orderly really.
						EndCue = "/VO/ZagreusHome_0340",
						EndWait = 0.3,
						{ Cue = "/VO/Storyteller_0117",
							Text = "{#DialogueItalicFormat}The courtyard of the House of Hades is kept neat and orderly, in contrast to the terrifying sprawl that lies beyond." },
					},
				},
			},
		},
	},
}

GlobalVoiceLines = GlobalVoiceLines or {}
GlobalVoiceLines.DeathVoiceLines =
{
	Queue = "Interrupt",
	RequiredFalseRooms = { "E_Story_01" },
	-- Unnggh!
	{ Cue = "/VO/ZagreusField_0079", RequiredCompletedRuns = 0, BreakIfPlayed = true, SkipAnim = true },
	{
		{
			RandomRemaining = true,
			-- BreakIfPlayed = true,
			-- PreLineWait = 0.25,
			SkipAnim = true,
			RequiredFalseRooms = { "E_Story_01" },

			-- No...!
			{ Cue = "/VO/ZagreusScratch_0009b"},
			-- No...
			{ Cue = "/VO/ZagreusField_0067" },
			-- Aahh!
			{ Cue = "/VO/ZagreusField_0068" },
			-- Wha--?
			{ Cue = "/VO/ZagreusField_0069" },
			-- Wha?!
			{ Cue = "/VO/ZagreusField_0070" },
			-- Again?!
			{ Cue = "/VO/ZagreusField_0071" },
			-- Anngh.
			{ Cue = "/VO/ZagreusField_0072" },
			-- Aarrgh!
			{ Cue = "/VO/ZagreusField_0073" },
			-- No, no!
			{ Cue = "/VO/ZagreusField_0074" },
			-- Ah, damn it!
			{ Cue = "/VO/ZagreusField_0075" },
			-- Why, you...!
			{ Cue = "/VO/ZagreusField_0076" },
			-- Unh, no!
			{ Cue = "/VO/ZagreusField_0077" },
			-- Wha, how?
			{ Cue = "/VO/ZagreusField_0078" },
			-- Unnggh!
			{ Cue = "/VO/ZagreusField_0079" },
			-- No, wait...!
			{ Cue = "/VO/ZagreusField_0080" },
			-- Ugh, no!
			{ Cue = "/VO/ZagreusField_0290" },
			-- Aughh!
			{ Cue = "/VO/ZagreusField_0292" },
			-- Gaaah!
			-- { Cue = "/VO/ZagreusField_4003" },
			-- Daaah!
			{ Cue = "/VO/ZagreusField_4004" },
			-- Graah!
			{ Cue = "/VO/ZagreusField_4005" },
			-- Argh, you!
			-- { Cue = "/VO/ZagreusField_4006" },
			-- No, you!
			-- { Cue = "/VO/ZagreusField_4007" },
			-- Guh, argh!
			{ Cue = "/VO/ZagreusField_4008" },
			-- Huh--?
			{ Cue = "/VO/ZagreusField_4009" },
		},
	},
}

GlobalVoiceLines.EnteredDeathAreaVoiceLines =
{
	-- ending
	{
		PlayOnce = true,
		PlayOnceContext = "EndingEvents",
		BreakIfPlayed = true,
		RequiresRunCleared = true,
		PreLineWait = 1.25,
		Queue = "Always",

		-- Ungh... Mother... I have to get back there.
		{ Cue = "/VO/ZagreusHome_2668", RequiredTextLines = { "PersephoneFirstMeeting" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Unff, Father, you...
		{ Cue = "/VO/ZagreusHome_2669", RequiredTextLines = { "PersephoneMeeting02" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Urgh... Father wanted her to leave, didn't he...
		{ Cue = "/VO/ZagreusHome_2670", RequiredTextLines = { "PersephoneMeeting03" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Nghh... hold that thought, Mother...
		{ Cue = "/VO/ZagreusHome_2671", RequiredTextLines = { "PersephoneMeeting04" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Augh... Olympus complicating things...
		{ Cue = "/VO/ZagreusHome_2672", RequiredTextLines = { "PersephoneMeeting05" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Ungh, I... need to fix this...
		{ Cue = "/VO/ZagreusHome_2673", RequiredTextLines = { "PersephoneMeeting06" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Grr, she... can't do this to me...
		{ Cue = "/VO/ZagreusHome_2674", RequiredTextLines = { "PersephoneMeeting07" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Guh... damn it all... again!
		{ Cue = "/VO/ZagreusHome_2675", RequiredTextLines = { "PersephoneMeeting08" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Y... you are the Queen....
		{ Cue = "/VO/ZagreusHome_2676", RequiredTextLines = { "PersephoneMeeting09" }, RequiredFalseTextLines = { "Ending01" }, },
		-- Urgh, I'm sure Mother's cottage is perfectly fine...
		{ Cue = "/VO/ZagreusHome_2677", RequiredTextLines = { "Ending01" }, },
	},	
	-- orpheus song 1 intro
	{
		BreakIfPlayed = true,
		RequiresAmbientMusicId = true,
		RequiredAmbientTrackName = "/Music/OrpheusSong1VACOUSTIC",
		PreLineWait = 3.25,
		PlayOnce = true,
		Queue = "Always",

		-- Is that... music?
		{ Cue = "/VO/ZagreusHome_0373", RequiredFalsePlayed = { "/VO/ZagreusHome_0728" } },
		-- No way... Orpheus?
		{ Cue = "/VO/ZagreusHome_0374", PreLineWait = 1.0, RequiredFalsePlayed = { "/VO/ZagreusHome_1164" }, RequiredPlayedThisRoom = { "/VO/ZagreusHome_0373" }, RequiredFalseQueuedTextLines = { "OrpheusSingsAgain01_D" }, BreakIfPlayed = true },
	},
	-- orpheus song 2 intro
	{
		BreakIfPlayed = true,
		RequiresAmbientMusicId = true,
		RequiredAmbientTrackName = "/Music/OrpheusSong2",
		PreLineWait = 2.25,
		PlayOnce = true,
		Queue = "Always",

		-- That's Orpheus' singing...
		{ Cue = "/VO/ZagreusHome_0728", },
		-- Wait, he's singing about me...
		{ Cue = "/VO/ZagreusHome_0729", PreLineWait = 1.0, RequiredPlayedThisRoom = { "/VO/ZagreusHome_0728" }, BreakIfPlayed = true },
	},
	-- orpheus song 3 intro
	{
		BreakIfPlayed = true,
		RequiresAmbientMusicId = true,
		RequiredAmbientTrackName = "/Music/EurydiceSong1_Orpheus",
		PreLineWait = 3.0,
		PlayOnce = true,
		Queue = "Always",

		-- That's Eurydice's song...
		{ Cue = "/VO/ZagreusHome_1164", },
	},
	-- run cleared lines
	{
		BreakIfPlayed = true,
		RequiresRunCleared = true,
		RandomRemaining = true,
		PreLineWait = 2.25,
		SuccessiveChanceToPlayAll = 0.33,
		Queue = "Always",

		-- Well this is going to be awkward.
		{ Cue = "/VO/ZagreusHome_0905", RequiredFalseTextLines = { "HadesGift05" }, },
		-- Well that was interesting.
		{ Cue = "/VO/ZagreusHome_0367", RequiredPlayed = { "/VO/ZagreusHome_0905" } },
		-- Thank you, thank you.
		{ Cue = "/VO/ZagreusHome_0369", RequiredPlayed = { "/VO/ZagreusHome_0905" } },
		-- Did pretty well that time.
		{ Cue = "/VO/ZagreusHome_0371", RequiredPlayed = { "/VO/ZagreusHome_0905" } },
		-- Think that's about as far as I can get for now.
		-- { Cue = "/VO/ZagreusHome_0372", RequiredPlayed = { "/VO/ZagreusHome_0905" } },
		-- I'm counting that one as a victory.
		{ Cue = "/VO/ZagreusHome_0871", RequiredPlayed = { "/VO/ZagreusHome_0905" } },
		-- Feels like it's been a while, everybody.
		{ Cue = "/VO/ZagreusHome_0874", RequiredPlayed = { "/VO/ZagreusHome_0905" } },
		-- Urgh, well that was pretty good, all in all.
		{ Cue = "/VO/ZagreusHome_0875", RequiredPlayed = { "/VO/ZagreusHome_0905" } },
		-- Not bad at all, really.
		{ Cue = "/VO/ZagreusHome_0877", RequiredPlayed = { "/VO/ZagreusHome_0905" } },
		-- Please, everybody, hold your applause.
		{ Cue = "/VO/ZagreusHome_0878", RequiredPlayed = { "/VO/ZagreusHome_0905" } },
		-- Finally showed you, Father.
		{ Cue = "/VO/ZagreusHome_0902", RequiredPlayed = { "/VO/ZagreusHome_0905" }, RequiresLastRunNotCleared = true, },
		-- Showed you that time, Father.
		{ Cue = "/VO/ZagreusHome_0903", RequiredPlayed = { "/VO/ZagreusHome_0905" } },
		-- I did it! I think?
		{ Cue = "/VO/ZagreusHome_0904", RequiredPlayed = { "/VO/ZagreusHome_0905" } },
		-- I'm back, huh.
		{ Cue = "/VO/ZagreusHome_0906", RequiredPlayed = { "/VO/ZagreusHome_0905" } },
		-- Thank you, thank you, everyone, you're too kind.
		{ Cue = "/VO/ZagreusHome_0706", RequiredPlayed = { "/VO/ZagreusHome_0905" } },
		-- I can't believe I actually pulled this off.
		{ Cue = "/VO/ZagreusHome_2996", RequiredPlayed = { "/VO/ZagreusHome_0905" }, RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 4 }, },
		-- Wonder if I can get out even faster.
		{ Cue = "/VO/ZagreusHome_2997",	RequiredPlayed = { "/VO/ZagreusHome_0905" }, },
	},
	{
		-- Urrggh... damn it.
		-- { Cue = "/VO/ZagreusScratch_0010b", PreLineWait = 1.9, PostLineWait = 3.0, Queue = "Always", RequiredCompletedRuns = 0, PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { AnimationNames = { "StatusIconDisgruntled", "StatusIconEmbarrassed" }, ReactionChance = 0.15, IntervalDuration = 0.2, Groups = { "GhostProcession", "GhostWorker" }, Delay = 2.25 }, },
		{ Cue = "/VO/ZagreusScratch_0010b", PreLineWait = 1.9, PostLineWait = 3.0, Queue = "Always", RequiredCompletedRuns = 0 },
		-- I'm home.
		{ Cue = "/VO/ZagreusHome_0002a", PostLineWait = 3.0, Queue = "Always", RequiredCompletedRuns = 0, RequiredFalseFlags = { "MetHades" }, RequiredFalsePlayed = { "/VO/Hades_0087" } },
		-- Aha, yes, carry on, everyone, don't mind me...!
		{ Cue = "/VO/ZagreusScratch_0012b", RequiredCompletedRuns = 0, RequiredFalseFlags = { "MetHades" }, RequiredLastLinePlayed = { "/VO/ZagreusHome_0002a" }, BreakIfPlayed = true },
	},
	-- Killed in God Mode
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 2.25,
		SuccessiveChanceToPlay = 0.02,
		RequiredMinCompletedRuns = 1,

		-- ...Each time I die like that, I come back stronger.
		{ Cue = "/VO/ZagreusHome_1442", RequiredTrueConfigOptions = { "EasyMode" } },
	},
	-- Killed Early On
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 2.25,
		SuccessiveChanceToPlayAll = 0.5,
		RequiredMinCompletedRuns = 1,
		RequiredMaxDepth = 5,

		-- Ahem, I, uh, forgot something.
		{ Cue = "/VO/ZagreusHome_2331" },
		-- Hm, had to come back for something right quick.
		{ Cue = "/VO/ZagreusHome_2332", RequiredPlayed = { "/VO/ZagreusHome_2331" }, },
		-- Forgot something again!
		{ Cue = "/VO/ZagreusHome_2333", RequiredPlayed = { "/VO/ZagreusHome_2331" }, },
		-- Thought I'd just pop back in.
		{ Cue = "/VO/ZagreusHome_2334", RequiredPlayed = { "/VO/ZagreusHome_2331" }, },
	},
	-- Killed By Pact Biome Timer
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredMinCompletedRuns = 1,
		RequiredLastKilledByWeaponNames = { "BiomeTimer" },
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Ugh, well then I guess I missed my deadline.
		{ Cue = "/VO/ZagreusHome_1344" },
		-- Oomph, that was a little too much Heat.
		{ Cue = "/VO/ZagreusHome_1345" },
		-- Nrgh, ran out of time back there I guess.
		{ Cue = "/VO/ZagreusHome_1346" },
		-- Augh, blasted Pact of Punishment...
		{ Cue = "/VO/ZagreusHome_1347" },
	},
	-- Killed while Blessed by Hermes
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		SuccessiveChanceToPlayAll = 0.1,
		RequiredRunHasOneOfTraits =
		{
			"MoveSpeedTrait",
			"RushSpeedBoostTrait",
			"BonusDashTrait",
			"TemporaryMoveSpeedTrait",
		},
		Queue = "Always",

		-- Ungh, so much for the swiftness of Hermes...
		{ Cue = "/VO/ZagreusHome_1886" },
		-- Rngh, I miss being ridiculously fast....
		{ Cue = "/VO/ZagreusHome_1887" },
	},
	-- Killed in B_Wrapping
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredDeathRoom = "B_Wrapping01",
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Ungh, blasted river of flame.
		{ Cue = "/VO/ZagreusHome_0545" },
		-- Just couldn't take the heat back there.
		{ Cue = "/VO/ZagreusHome_0546" },
		-- Urgh that was not a pleasant journey.
		{ Cue = "/VO/ZagreusHome_0547" },
	},
	-- Killed by Witches Circle
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredDeathRoom = "B_MiniBoss02",
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Eugh, guess Witches don't like company.
		{ Cue = "/VO/ZagreusHome_2759" },
		-- Augh, don't mess with Witches, then, I guess...
		{ Cue = "/VO/ZagreusHome_2760" },
		-- Kkh, blasted Witches got me...
		{ Cue = "/VO/ZagreusHome_2761" },
	},
	-- Killed by Megagorgon
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredDeathRoom = "B_MiniBoss01",
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Urgh, that blasted giant gorgon head.
		{ Cue = "/VO/ZagreusHome_0621" },
		-- Eugh, not a word of this to Dusa...
		{ Cue = "/VO/ZagreusHome_0622", RequiredAnyTextLines = { "DusaFirstMeeting", "DusaFirstMeeting_Alt" } },
		-- Augh, gorgons, what can you do...
		{ Cue = "/VO/ZagreusHome_0623" },
	},
	-- Killed by Multiple Furies
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredAnyDeathRooms = { "A_Boss01", "A_Boss02", "A_Boss03" },
		RequiredMinActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 1 },
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Ugh, more Fury Sisters than I bargained for...
		{ Cue = "/VO/ZagreusHome_1249" },
		-- Urgh, that's one sister too many...
		{ Cue = "/VO/ZagreusHome_1250" },
		-- Mmph, that didn't seem particularly fair.
		{ Cue = "/VO/ZagreusHome_1251" },
		-- Ungh, I guess I should be flattered in a way...
		{ Cue = "/VO/ZagreusHome_1252" },
		-- Augh, don't the Furies have somebody else they could be torturing...
		{ Cue = "/VO/ZagreusHome_1253" },
	},
	-- Killed by Meg
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredDeathRoom = "A_Boss01",
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- OK she got me.
		{ Cue = "/VO/ZagreusHome_0392", RequiredPlayed = { "/VO/ZagreusHome_0464" } },
		-- Damn you, Meg.
		{ Cue = "/VO/ZagreusHome_0393", RequiredPlayed = { "/VO/ZagreusHome_0464" } },
		-- I'll get you for that, Meg.
		{ Cue = "/VO/ZagreusHome_0394", RequiredPlayed = { "/VO/ZagreusHome_0464" } },
		-- Urgh, you win this round, Meg.
		{ Cue = "/VO/ZagreusHome_0463", RequiredPlayed = { "/VO/ZagreusHome_0464" } },
		-- Unf, cheers for that, Meg.
		{ Cue = "/VO/ZagreusHome_0464", },
	},
	-- Killed by Alecto
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredDeathRoom = "A_Boss02",
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Urgh, cheers for that, Alecto.
		{ Cue = "/VO/ZagreusHome_0793" },
		-- Augh, that wasn't very kind of her, was it.
		{ Cue = "/VO/ZagreusHome_0794" },
		-- Unf, I guess Alecto wins this round.
		{ Cue = "/VO/ZagreusHome_0795" },
		-- I much prefer Meg's whip, I have to say...
		{ Cue = "/VO/ZagreusHome_0796" },
		-- Well I hope she's happy.
		{ Cue = "/VO/ZagreusHome_0797" },
		-- I'll get you back, Alecto.
		{ Cue = "/VO/ZagreusHome_0798" },
	},
	-- Killed by Tisiphone
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredDeathRoom = "A_Boss03",
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- That Tisiphone, ughh...
		{ Cue = "/VO/ZagreusHome_0799" },
		-- She murdered me all right...
		{ Cue = "/VO/ZagreusHome_0800" },
		-- Eugh, I miss Meg...
		{ Cue = "/VO/ZagreusHome_0801", RequiredTextLines = { "MegaeraGift01" } },
		-- That... was disturbing.
		{ Cue = "/VO/ZagreusHome_0802" },
		-- Was that a murder...?
		{ Cue = "/VO/ZagreusHome_0803" },
	},

	-- Killed during Thanatos Encounter
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredAnyDeathEncounters = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", },
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Sorry, Thanatos...
		{ Cue = "/VO/ZagreusHome_0804" },
		-- Not even Than could get me out of that one.
		{ Cue = "/VO/ZagreusHome_0805" },
		-- Than tried to help at least.
		{ Cue = "/VO/ZagreusHome_0806" },
		-- Than won't be happy about that.
		{ Cue = "/VO/ZagreusHome_0807" },
		-- Thanatos couldn't save me there.
		{ Cue = "/VO/ZagreusHome_0808" },
		-- Than tried his best at least...
		{ Cue = "/VO/ZagreusHome_0809", RequiredTextLines = { "ThanatosGift01" } },
	},
	-- Killed by Tartarus Miniboss (Skeleton Twins)
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredAnyDeathRooms = { "A_MiniBoss01", },
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Ugh. Skeletons.
		{ Cue = "/VO/ZagreusHome_0395", },
		-- Stupid skeleton twins.
		{ Cue = "/VO/ZagreusHome_0396", },
		-- Bloodless bastards got me.
		{ Cue = "/VO/ZagreusHome_0397", },
	},
	-- Killed by Tartarus Miniboss (Wretch Assassin)
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredAnyDeathRooms = { "A_MiniBoss03" },
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Nng, that Sneak is tough...
		{ Cue = "/VO/ZagreusHome_2756", },
		-- Augh, my back...
		{ Cue = "/VO/ZagreusHome_2757", },
		-- Argh, I hate that Sneak...
		{ Cue = "/VO/ZagreusHome_2758", },
	},
	-- Killed by Tartarus Miniboss (HeavyRangedSplitterMiniboss)
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredAnyDeathRooms = { "A_MiniBoss02", "A_MiniBoss04" },
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Augh, that's why it's called a Doomstone.
		{ Cue = "/VO/ZagreusHome_2753", },
		-- Oof, damn giant evil crystal.
		{ Cue = "/VO/ZagreusHome_2754", },
		-- Urgh, that blasted Doomstone.
		{ Cue = "/VO/ZagreusHome_2755", },
	},
	-- Killed by Hydra
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredAnyDeathRooms = { "B_Boss01", "B_Boss02" },
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Ugh, Lernie, why...?
		{ Cue = "/VO/ZagreusHome_1888", RequiredPlayed = { "/VO/ZagreusField_3147" } },
		-- Urgh, that Lernie, augh.
		{ Cue = "/VO/ZagreusHome_1889", RequiredPlayed = { "/VO/ZagreusField_3147" } },
		-- Ngh, how could Lernie do this?
		{ Cue = "/VO/ZagreusHome_1890", RequiredPlayed = { "/VO/ZagreusField_3147" } },
		-- Ugh, that stupid Hydra...
		{ Cue = "/VO/ZagreusHome_0398", RequiredPlayed = { "/VO/ZagreusHome_0399" }, RequiredFalsePlayed = { "/VO/ZagreusField_3147" } },
		-- Urgh, I'll get that Hydra.
		{ Cue = "/VO/ZagreusHome_0399", RequiredFalsePlayed = { "/VO/ZagreusField_3147" } },
		-- I hate that Hydra...
		{ Cue = "/VO/ZagreusHome_0400", RequiredPlayed = { "/VO/ZagreusHome_0399" }, RequiredFalsePlayed = { "/VO/ZagreusField_3147" } },
	},
	-- Killed by Minotaur2
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredLastKilledByUnits = { "Minotaur2" },
		RequiredActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Urgh, blasted heavily armored half-bull...
		{ Cue = "/VO/ZagreusHome_1338" },
		-- Rrng, where can I get armor like that?
		{ Cue = "/VO/ZagreusHome_1339" },
		-- Nngh, how do I get through all that armor?
		{ Cue = "/VO/ZagreusHome_1340" },
	},
	-- Killed by Minotaur
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredLastKilledByUnits = { "Minotaur", "Minotaur2" },
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Urgh, that's one bad bull.
		{ Cue = "/VO/ZagreusHome_0823", RequiredPlayed = { "/VO/ZagreusHome_0827" } },
		-- Ungh, I got the horns.
		{ Cue = "/VO/ZagreusHome_0824", RequiredPlayed = { "/VO/ZagreusHome_0827" } },
		-- Argh, the dreaded Minotaur.
		{ Cue = "/VO/ZagreusHome_0825", RequiredPlayed = { "/VO/ZagreusHome_0827" } },
		-- Uff, blasted ghost Minotaur.
		{ Cue = "/VO/ZagreusHome_0826", RequiredPlayed = { "/VO/ZagreusHome_0827" } },
		-- Nghh, that bull hits rather hard.
		{ Cue = "/VO/ZagreusHome_0827" },
	},
	-- Killed by Theseus2
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredLastKilledByUnits = { "Theseus", "Theseus2" },
		RequiredActiveMetaUpgradeLevel = { Name = "BossDifficultyShrineUpgrade", Count = 3 },
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Oof, turns out I can like Theseus even less.
		{ Cue = "/VO/ZagreusHome_1341" },
		-- Mmrn, Theseus can't just run over me like that...
		{ Cue = "/VO/ZagreusHome_1342" },
		-- Augh, how come he gets the Macedonian...
		{ Cue = "/VO/ZagreusHome_1343" },
	},
	-- Killed by Theseus
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredLastKilledByUnits = { "Theseus", "Theseus2" },
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Rngh, I swear, that Theseus...
		{ Cue = "/VO/ZagreusHome_0828", RequiredPlayed = { "/VO/ZagreusHome_0831" } },
		-- Khh, losing to Theseus...
		{ Cue = "/VO/ZagreusHome_0829", RequiredPlayed = { "/VO/ZagreusHome_0831" } },
		-- Guh, that no-good loudmouth Theseus.
		{ Cue = "/VO/ZagreusHome_0830", RequiredPlayed = { "/VO/ZagreusHome_0831" } },
		-- Ungh, I want a rematch, now.
		{ Cue = "/VO/ZagreusHome_0831" },
		-- Rmm, how could I lose to him.
		{ Cue = "/VO/ZagreusHome_0832", RequiredPlayed = { "/VO/ZagreusHome_0831" } },
	},
	-- Killed by Lord Hades
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredDeathRoom = "D_Boss01",
		RequiresRunNotCleared = true,
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",
		TriggerCooldowns = { "ZagreusAnyQuipSpeech" },

		-- Ungh, damn you, Father.
		{ Cue = "/VO/ZagreusHome_0895" },
		-- Urgh, Father...
		{ Cue = "/VO/ZagreusHome_0896", RequiredPlayed = { "/VO/ZagreusHome_0895" } },
		-- Angh, he's strong, I'll give him that.
		{ Cue = "/VO/ZagreusHome_0897", RequiredPlayed = { "/VO/ZagreusHome_0895" } },
		-- Ough, he's tough for an old man.
		{ Cue = "/VO/ZagreusHome_0898", RequiredPlayed = { "/VO/ZagreusHome_0895" } },
		-- Guh, how am I going to beat him.
		{ Cue = "/VO/ZagreusHome_0899", RequiredPlayed = { "/VO/ZagreusHome_0895" } },
		-- Mmph, got me again, damn it.
		{ Cue = "/VO/ZagreusHome_0900", RequiredPlayed = { "/VO/ZagreusHome_0895" } },
		-- Augh, I'll get you for this, Father.
		{ Cue = "/VO/ZagreusHome_0901", RequiredPlayed = { "/VO/ZagreusHome_0895" } },
		-- I'll make it out of here yet.
		{ Cue = "/VO/ZagreusHome_0872", RequiredPlayed = { "/VO/ZagreusHome_0895" }, RequiredFalseTextLines = { "PersephoneFirstMeeting" }, },
	},
	-- Killed by Charon
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredDeathRoom = "CharonFight01",
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Mm, damn it, Charon...
		{ Cue = "/VO/ZagreusHome_2748" },
		-- Augh, Charon, I am going to pay you back.
		{ Cue = "/VO/ZagreusHome_2749" },
		-- Nrgh, how'd he get so strong?
		{ Cue = "/VO/ZagreusHome_2750" },
		-- Eugh, Charon wasn't too agreeable back there.
		{ Cue = "/VO/ZagreusHome_2751" },
		-- Mph, he just lost himself a customer.
		{ Cue = "/VO/ZagreusHome_2752" },
	},
	-- Killed by Spikes
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredLastKilledByUnits = { "SpikeTrap" },
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- I've got to stop walking on spikes like that.
		{ Cue = "/VO/ZagreusHome_0473", RequiredPlayed = { "/VO/ZagreusHome_0475" } },
		-- Spikes continue to be painful.
		{ Cue = "/VO/ZagreusHome_0474", RequiredPlayed = { "/VO/ZagreusHome_0475" } },
		-- Rngh, blasted spike traps everywhere...
		{ Cue = "/VO/ZagreusHome_0475" },
	},
	-- Killed by Darts
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredLastKilledByUnits = { "DartTrapEmitter" },
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Damn dart traps shot me all to hell.
		{ Cue = "/VO/ZagreusHome_0476", RequiredPlayed = { "/VO/ZagreusHome_0477" } },
		-- Stupid dart trap, ungh.
		{ Cue = "/VO/ZagreusHome_0477" },
		-- I really shouldn't step on dart traps anymore...
		{ Cue = "/VO/ZagreusHome_0478", RequiredPlayed = { "/VO/ZagreusHome_0477" } },
	},
	-- Killed by Satyrs
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredLastKilledByUnits = { "SatyrRanged", "SatyrRangedElite", "SatyrRangedMiniboss" },
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.05,
		Queue = "Always",

		-- Blasted Satyrs.
		{ Cue = "/VO/ZagreusHome_0937" },
	},
	-- Killed by Tiny Vermin
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		RequiredAnyDeathEncounters = { "MiniBossCrawler" },
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.05,
		Queue = "Always",

		-- Ungh, how can something so small be so evil?
		{ Cue = "/VO/ZagreusHome_2335" },
		-- Mmph, that blasted tiny vermin...
		{ Cue = "/VO/ZagreusHome_2336" },
		-- Augh, I'll have my vengeance yet, you tiny vermin.
		{ Cue = "/VO/ZagreusHome_2337" },
		-- Oof, well, not my proudest battle...
		{ Cue = "/VO/ZagreusHome_2338" },
	},
	-- Killed in Survival Encounter
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		CurrentEncounterValueTrue = "HadesDeathTaunt",
		CurrentRoomValueFalse = "StartedChallengeEncounter",
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Ung, damn it, Father.
		{ Cue = "/VO/ZagreusHome_0465", },
		-- You called, Father...?
		{ Cue = "/VO/ZagreusHome_0466", },
		-- All those wretches got the best of me.
		{ Cue = "/VO/ZagreusHome_0467", },
		-- Mmph, that was too much...
		{ Cue = "/VO/ZagreusHome_0468", },
	},
	-- Killed in Challenge Encounter
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.25,
		CurrentRoomValueTrue = "StartedChallengeEncounter",
		RequiredMinCompletedRuns = 1,
		SuccessiveChanceToPlayAll = 0.5,
		Queue = "Always",

		-- Got just a little greedy I suppose.
		{ Cue = "/VO/ZagreusHome_0469", },
		-- That's what I get for messing with a trove.
		{ Cue = "/VO/ZagreusHome_0470", },
		-- Rngh, that trove should've been mine.
		{ Cue = "/VO/ZagreusHome_0471", },
		-- That did not go as planned.
		{ Cue = "/VO/ZagreusHome_0472", },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		-- ChanceToPlay = 0.66,
		PreLineWait = 1.9,
		RequiredMinCompletedRuns = 1,
		Queue = "Always",

		-- How'd I do that time.
		-- { Cue = "/VO/ZagreusHome_0010b", PreLineWait = 3.0, Queue = "Always" },
		-- Ow...
		-- { Cue = "/VO/ZagreusHome_0061", },
		-- Father...?
		-- { Cue = "/VO/ZagreusHome_0004", PreLineWait = 3.0, Queue = "Always", },
		-- Showed that stupid Hydra, at least.
		{ Cue = "/VO/ZagreusHome_0368", RequiredRoomThisRun = "C_Intro", RequiresRunNotCleared = true, },
		-- Buhhh....
		{ Cue = "/VO/ZagreusHome_0099", },
		-- I... can't get used to that.
		{ Cue = "/VO/ZagreusHome_0100", },
		-- Brrr...
		{ Cue = "/VO/ZagreusHome_0101", },
		-- Well...
		{ Cue = "/VO/ZagreusHome_0102", },
		-- I'm home!
		{ Cue = "/VO/ZagreusHome_0003c", },
		-- I'm back. Again.
		{ Cue = "/VO/ZagreusHome_0005a", RequiresRunNotCleared = true },
		-- Uh, so, did everybody miss me...?
		{ Cue = "/VO/ZagreusHome_0006", },
		-- Back again.
		{ Cue = "/VO/ZagreusHome_0007b", },
		-- That really hurt.
		{ Cue = "/VO/ZagreusHome_0008a", },
		-- <Laugh>
		{ Cue = "/VO/ZagreusHome_0009", },
		-- <Laughter>
		{ Cue = "/VO/ZagreusHome_1512", RequiredTextLines = { "Ending01" }, },
		-- <Laughter>
		{ Cue = "/VO/ZagreusHome_1513", RequiredTextLines = { "Ending01" }, },
		-- <Laughter>
		{ Cue = "/VO/ZagreusHome_1514", RequiredTextLines = { "Ending01" }, },
		-- <Chuckle>
		{ Cue = "/VO/ZagreusHome_1516", RequiredTextLines = { "Ending01" }, },
		-- Eughh...
		{ Cue = "/VO/ZagreusHome_0062", },
		-- Auggh...
		{ Cue = "/VO/ZagreusHome_0063", },
		-- Erm, all right then.
		{ Cue = "/VO/ZagreusHome_0064", RequiresRunNotCleared = true },
		-- Urghh, surprise...!
		{ Cue = "/VO/ZagreusHome_0065", },
		-- Not too bad that time.
		{ Cue = "/VO/ZagreusHome_0011a", RequiredRoomThisRun = "C_Intro" },
		-- That could have gone better.
		{ Cue = "/VO/ZagreusHome_0012d", RequiredMaxDepth = 8, },
		-- I can do better than that.
		{ Cue = "/VO/ZagreusHome_0146", RequiresRunNotCleared = true },
		-- Like to think I learned something back there.
		{ Cue = "/VO/ZagreusHome_0147", RequiresRunNotCleared = true },
		-- Ouch, all right, again?
		{ Cue = "/VO/ZagreusHome_0148" },
		-- Just have to try again.
		{ Cue = "/VO/ZagreusHome_0149", RequiresRunNotCleared = true },
		-- Got to keep at it.
		{ Cue = "/VO/ZagreusHome_0150", RequiresRunNotCleared = true },
		-- Tough break.
		{ Cue = "/VO/ZagreusHome_2775", PreLineWait = 2.0, RequiresRunNotCleared = true },
		-- Someday I'll go even farther.
		{ Cue = "/VO/ZagreusHome_0370", RequiredFalseSeenRooms = { "D_Boss01" }, },
		-- Fought to Elysium and back.
		{ Cue = "/VO/ZagreusHome_0876", RequiredRoomThisRun = "C_Intro",
				RequiredFalseSeenRoomThisRun = "D_Intro", },
	},
}

GlobalVoiceLines.SecretDoorLockedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	CooldownTime = 8,

	-- It's locked.
	{ Cue = "/VO/ZagreusHome_0037" },
	-- No use.
	{ Cue = "/VO/ZagreusHome_0036" },
	-- Can't do it.
	{ Cue = "/VO/ZagreusHome_0038" },
	-- I better not.
	{ Cue = "/VO/ZagreusHome_0039" },
	-- Won't open.
	{ Cue = "/VO/ZagreusHome_0040" },
	-- No way.
	{ Cue = "/VO/ZagreusHome_0041" },
}

GlobalVoiceLines.TakeASeatVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.3,
	CooldownTime = 12,
	RequiredFalseFlags = { "InFlashback" },

	-- No time to rest.
	{ Cue = "/VO/ZagreusHome_0077" },
	-- If I sit down I won't want to get back up.
	{ Cue = "/VO/ZagreusHome_0078" },
	-- Not as comfy as it looks.
	{ Cue = "/VO/ZagreusHome_0079" },
}
GlobalVoiceLines.TakeANapVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.3,
	CooldownTime = 12,
	RequiredFalseFlags = { "InFlashback" },

	-- Who needs sleep?
	{ Cue = "/VO/ZagreusHome_1795" },
	-- Not even tired, thanks.
	{ Cue = "/VO/ZagreusHome_1796" },
	-- Can't sleep.
	{ Cue = "/VO/ZagreusHome_1797" },
	-- I'll sleep when I'm dead.
	{ Cue = "/VO/ZagreusHome_1798" },
	-- I'm wide awake.
	{ Cue = "/VO/ZagreusHome_1799" },
	-- It's never bedtime here.
	{ Cue = "/VO/ZagreusHome_1800" },
}
GlobalVoiceLines.UsedThroneVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.33,
	Cooldowns =
	{
		{ Name = "ZagreusUsedThroneVoiceLines", Time = 8 },
	},

	-- No way.
	{ Cue = "/VO/ZagreusHome_3582", RequiredPlayed = { "/VO/ZagreusHome_3583" } },
	-- Uh, no.
	{ Cue = "/VO/ZagreusHome_3583" },
	-- Not sitting on that.
	{ Cue = "/VO/ZagreusHome_3584", RequiredPlayed = { "/VO/ZagreusHome_3583" } },
	-- I'll stand, thanks.
	{ Cue = "/VO/ZagreusHome_3585", RequiredPlayed = { "/VO/ZagreusHome_3583" } },
	-- No thanks.
	{ Cue = "/VO/ZagreusHome_3586", RequiredPlayed = { "/VO/ZagreusHome_3583" } },
	-- No way whatsoever.
	{ Cue = "/VO/ZagreusHome_3587", RequiredPlayed = { "/VO/ZagreusHome_3583" } },
}

GlobalVoiceLines.LockedDoorMiscVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.45,
	RequiredFalseFlags = { "InFlashback" },
	RequiredFalseTextLinesThisRun = { "AchillesAboutHadesBedroom01" },
	Cooldowns =
	{
		{ Name = "ZagreusLockedOfficeDoorSpeech", Time = 8 },
		{ Name = "ZagreusLockedHadesBedroomDoorSpeech", Time = 8 },
	},

	-- It's locked.
	{ Cue = "/VO/ZagreusHome_0037" },
	-- No use.
	{ Cue = "/VO/ZagreusHome_0036", RequiredPlayed = "/VO/ZagreusHome_0037" },
	-- Can't do it.
	{ Cue = "/VO/ZagreusHome_0038", RequiredPlayed = "/VO/ZagreusHome_0037" },
	-- I better not.
	{ Cue = "/VO/ZagreusHome_0039", RequiredPlayed = "/VO/ZagreusHome_0037" },
	-- Won't open.
	{ Cue = "/VO/ZagreusHome_0040", RequiredPlayed = "/VO/ZagreusHome_0037" },
	-- No way.
	{ Cue = "/VO/ZagreusHome_0041", RequiredPlayed = "/VO/ZagreusHome_0037" },
}
GlobalVoiceLines.LockedDoorReactionVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.4,
		CooldownTime = 8,
		SuccessiveChanceToPlay = 0.5,
		RequiredFalseFlags = { "InFlashback" },
		RequiredPlayed = { "/VO/Hades_0048" },
		UseOcclusion = true,
		RequiresFalseHadesProcession = true,
		RequiredFalseTextLinesThisRun = { "AchillesAboutHadesBedroom01" },
		RequiredSourceValueFalse = "InPartnerConversation",
		ObjectType = "NPC_Achilles_01",

		-- Can't let you in there, lad.
		{ Cue = "/VO/Achilles_0187" },
		-- Off limits, I'm afraid.
		{ Cue = "/VO/Achilles_0188" },
		-- You know your father's rules.
		{ Cue = "/VO/Achilles_0189" },
		-- Come on, lad.
		{ Cue = "/VO/Achilles_0190" },
		-- Locked for a reason, lad.
		{ Cue = "/VO/Achilles_0191" },
		-- Not permitted there.
		{ Cue = "/VO/Achilles_0192" },
		-- House rules, lad.
		{ Cue = "/VO/Achilles_0193" },
		-- Has to stay shut like that.
		{ Cue = "/VO/Achilles_0194" },
		-- No use in trying, lad.
		{ Cue = "/VO/Achilles_0195" },
		-- Not going to open, lad.
		{ Cue = "/VO/Achilles_0196" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.4,
		CooldownTime = 8,
		RequiredFalseFlags = { "InFlashback" },
		UseOcclusion = true,
		RequiresFalseHadesProcession = true,
		RequiredSourceValueFalse = "InPartnerConversation",
		ObjectType = "NPC_Hades_01",

		-- That's well off limits, boy.
		{ Cue = "/VO/Hades_0040", RequiredPlayed = { "/VO/Hades_0048" } },
		-- Turn yourself around.
		{ Cue = "/VO/Hades_0042", RequiredPlayed = { "/VO/Hades_0048" } },
		-- Cease with your endless snooping.
		{ Cue = "/VO/Hades_0044", RequiredPlayed = { "/VO/Hades_0048" } },
		-- Keep out of there, I said.
		{ Cue = "/VO/Hades_0045", RequiredPlayed = { "/VO/Hades_0048" } },
		-- You stay away from there.
		{ Cue = "/VO/Hades_0046", RequiredPlayed = { "/VO/Hades_0048" } },
		-- Quit meddling back there.
		{ Cue = "/VO/Hades_0047", RequiredPlayed = { "/VO/Hades_0048" } },
		-- Stay out of there.
		{ Cue = "/VO/Hades_0048" },
	},
}
GlobalVoiceLines.LockedOfficeDoorVoiceLines =
{
	{
		PreLineWait = 0.45,
		PlayOnceFromTableThisRun = true,
		RequiredFalseFlags = { "InFlashback" },
		SuccessiveChanceToPlay = 0.01,
		Cooldowns =
		{
			{ Name = "ZagreusLockedOfficeDoorSpeech", Time = 8 },
		},

		-- Don't think I'm welcome in there.
		{ Cue = "/VO/ZagreusHome_2891" },
	},
	[2] = GlobalVoiceLines.LockedDoorMiscVoiceLines,
	[3] = GlobalVoiceLines.LockedDoorReactionVoiceLines,
}
GlobalVoiceLines.LockedHadesBedroomDoorVoiceLines =
{
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		RequiredFalseFlags = { "InFlashback" },
		RequiredTextLines = { "AchillesAboutHadesBedroom01" },
		RequiredFalseTextLinesThisRun = { "AchillesAboutHadesBedroom01 "},
		RequiredFalseTextLines = { "Ending01" },
		Cooldowns =
		{
			{ Name = "ZagreusLockedHadesBedroomDoorSpeech", Time = 8 },
		},

		-- Father changed the blasted lock already?
		{ Cue = "/VO/ZagreusHome_3689", RequiredFalseTextLinesThisRun = { "AchillesAboutHadesBedroom01" }, },
	},
	{
		PreLineWait = 0.45,
		PlayOnceFromTableThisRun = true,
		RequiredFalseFlags = { "InFlashback" },
		SuccessiveChanceToPlay = 0.01,
		Cooldowns =
		{
			{ Name = "ZagreusLockedHadesBedroomDoorSpeech", Time = 8 },
		},

		-- Father's chambers, always locked.
		{ Cue = "/VO/ZagreusHome_2892" },
	},
	[2] = GlobalVoiceLines.LockedDoorMiscVoiceLines,
	[3] = GlobalVoiceLines.LockedDoorReactionVoiceLines,
}

GlobalVoiceLines.OpenedMetaUpgradeMenuVoiceLines =
{
	{
		PlayOnce = true,
		PreLineWait = 1.65,
		RequiredTrueFlags = { "SwapMetaupgradesEnabled", "SubtractionEnabled" },
		RequiredFalseFlags = { "SwapMetaupgradesEnabledPresentation" },
		Queue = "Always",
		Cooldowns =
		{
			{ Name = "ZagreusMetaUpgradeScreenOpenedSpeech", Time = 30 },
		},

		-- Nyx updated my mirror...
		{ Cue = "/VO/ZagreusHome_2300", },
	},
	{
		PlayOnce = true,
		PreLineWait = 1.35,
		RequiredTrueFlags = { "SwapMetaupgradesEnabled" },
		RequiredFalseFlags = { "SwapMetaupgradesEnabledPresentation" },
		Queue = "Always",
		Cooldowns =
		{
			{ Name = "ZagreusMetaUpgradeScreenOpenedSpeech", Time = 30 },
		},

		-- The Mirror's grown in power.
		{ Cue = "/VO/ZagreusHome_0341", },
		-- Thank you Nyx.
		{ Cue = "/VO/ZagreusHome_0107", PreLineWait = 0.9, BreakIfPlayed = true, },
	},
	{
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.65,
			RequiredFalsePlayedThisRoom = { "/VO/ZagreusHome_0107" },
			SuccessiveChanceToPlay = 0.33,
			Cooldowns =
			{
				{ Name = "ZagreusMetaUpgradeScreenOpenedSpeech", Time = 30 },
			},

			-- Hmm.
			-- { Cue = "/VO/ZagreusHome_0058" },
			-- Ready to face the Underworld...
			-- { Cue = "/VO/ZagreusHome_0069" },
			-- Hello handsome.
			-- { Cue = "/VO/ZagreusHome_0072" },
			-- Night and Darkness, guide me.
			{ Cue = "/VO/ZagreusHome_0105" },
			-- Let's see.
			{ Cue = "/VO/ZagreusHome_0056", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- Let's have a look here.
			{ Cue = "/VO/ZagreusHome_0057", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- How am I looking...
			{ Cue = "/VO/ZagreusHome_0070", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- Darkness, give me strength.
			{ Cue = "/VO/ZagreusHome_0157", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- Night, give me strength.
			{ Cue = "/VO/ZagreusHome_0158", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- Darkness is power.
			{ Cue = "/VO/ZagreusHome_0159", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- Night and Darkness.
			{ Cue = "/VO/ZagreusHome_0160", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- I can do anything.
			{ Cue = "/VO/ZagreusHome_0343", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- Nyx's Mirror...
			{ Cue = "/VO/ZagreusHome_2090", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- The Mirror of Night...
			{ Cue = "/VO/ZagreusHome_2091", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- Mirror of Night...
			{ Cue = "/VO/ZagreusHome_2092", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- Hello, Mirror...
			{ Cue = "/VO/ZagreusHome_2093", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- I'm growing stronger.
			{ Cue = "/VO/ZagreusHome_2094", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- I can grow stronger.
			{ Cue = "/VO/ZagreusHome_2095", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- I can be stronger.
			{ Cue = "/VO/ZagreusHome_2096", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- I can get stronger.
			{ Cue = "/VO/ZagreusHome_2097", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- I can be more.
			{ Cue = "/VO/ZagreusHome_2098", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- I can do better.
			{ Cue = "/VO/ZagreusHome_2099", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- Night, protect me.
			{ Cue = "/VO/ZagreusHome_2100", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
			-- The Mirror of Night...
			{ Cue = "/VO/ZagreusHome_2299", RequiredPlayed = { "/VO/ZagreusHome_0105" } },
		},
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.65,
			RequiredFalsePlayedLastRun = { "/VO/ZagreusHome_0071" },
			Cooldowns =
			{
				{ Name = "ZagreusMetaUpgradeScreenOpenedSpeech", Time = 30 },
			},

			-- Think I need a shave...
			{ Cue = "/VO/ZagreusHome_0071", RequiredPlayed = { "/VO/ZagreusHome_0105" }, ChanceToPlay = 0.01 },
		},
	}
}
GlobalVoiceLines.MetaUpgradeSwappedVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PlayOnceFromTableThisRun = true,
	RequiredMinCompletedRuns = 0,
	ChanceToPlay = 0.1,
	PreLineWait = 0.4,
	Cooldowns =
	{
		{ Name = "ZagreusMirrorScreenSpeech", Time = 20 },
	},

	-- Let's try this.
	{ Cue = "/VO/ZagreusHome_2628", },
	-- Maybe this.
	{ Cue = "/VO/ZagreusHome_2629", },
	-- Maybe the other.
	{ Cue = "/VO/ZagreusHome_2630", },
	-- Maybe this way.
	{ Cue = "/VO/ZagreusHome_2631", },
	-- Maybe like so.
	{ Cue = "/VO/ZagreusHome_2632", },
	-- Maybe like this?
	{ Cue = "/VO/ZagreusHome_2633", },
	-- Other side.
	{ Cue = "/VO/ZagreusHome_2634", },
	-- This one then?
	{ Cue = "/VO/ZagreusHome_2635", },
	-- How about like this.
	{ Cue = "/VO/ZagreusHome_2636", },
	-- Hmm...
	{ Cue = "/VO/ZagreusHome_2637", },
}
GlobalVoiceLines.MetaUpgradeSelectedVoiceLines =
{
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PlayOnceFromTableThisRun = true,
		RequiredAllMetaUpgradesMaxed = true,
		PreLineWait = 0.75,
		RequiredFalsePlayedLastRun = { "/VO/ZagreusHome_0576", "/VO/ZagreusHome_0577", "/VO/ZagreusHome_2627" },

		-- The Mirror... at last I see myself for what I am.
		{ Cue = "/VO/ZagreusHome_0576", },
		-- Every facet of the Mirror, now within my grasp.
		{ Cue = "/VO/ZagreusHome_0577", },
		-- That's everything... at last I see myself for what I am.
		{ Cue = "/VO/ZagreusHome_2627", },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		RequiredMinCompletedRuns = 0,
		PreLineWait = 0.75,

		-- There.
		{ Cue = "/VO/ZagreusHome_0106", },
		-- All right.
		{ Cue = "/VO/ZagreusHome_0108", },
		-- Now we're talking.
		{ Cue = "/VO/ZagreusHome_0049" },
		-- All right I'm ready.
		{ Cue = "/VO/ZagreusHome_0073" },
		-- All set.
		{ Cue = "/VO/ZagreusHome_0074" },
		-- Good to go.
		{ Cue = "/VO/ZagreusHome_0075" },
		-- Excellent.
		{ Cue = "/VO/ZagreusHome_0076" },
		-- Power.
		{ Cue = "/VO/ZagreusHome_0422" },
		-- My power grows.
		{ Cue = "/VO/ZagreusHome_0423" },
		-- Done.
		{ Cue = "/VO/ZagreusHome_0424" },
		-- Looking good.
		{ Cue = "/VO/ZagreusHome_0425" },
		-- I feel different.
		{ Cue = "/VO/ZagreusHome_2101" },
		-- Felt that I think.
		{ Cue = "/VO/ZagreusHome_2102" },
		-- Feeling good.
		{ Cue = "/VO/ZagreusHome_2103" },
		-- Ready I think.
		{ Cue = "/VO/ZagreusHome_2104" },
		-- OK.
		{ Cue = "/VO/ZagreusHome_2105" },
		-- The power of Darkness.
		{ Cue = "/VO/ZagreusHome_2106" },
		-- Whew, felt that.
		{ Cue = "/VO/ZagreusHome_2107" },
		-- Think that should do it.
		{ Cue = "/VO/ZagreusHome_2108" },
		-- The power of Night.
		{ Cue = "/VO/ZagreusHome_2109" },
		-- Nyx's power....
		{ Cue = "/VO/ZagreusHome_2110" },
		-- Nyx's strength...
		{ Cue = "/VO/ZagreusHome_2111" },
		-- See you, Mirror...
		{ Cue = "/VO/ZagreusHome_2112" },
	},
}

GlobalVoiceLines.OpenedAwardMenuVoiceLines =
{
	{
		PlayOnceFromTableThisRun = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		RequiredRooms = { "A_PostBoss01", "B_PostBoss01", "C_PreBoss01" },
		CooldownTime = 200,
		CooldownName = "KeepsakesMentionedRecently",
		SuccessiveChanceToPlay = 0.2,
		PreLineWait = 0.6,

		-- My Keepsake Collection! Just what the House Contractor ordered.
		{ Cue = "/VO/ZagreusField_2918", PlayOnce = true },
		-- What's my collection doing here?
		-- { Cue = "/VO/ZagreusField_0920" },
		-- Hey what's that doing here?
		-- { Cue = "/VO/ZagreusField_0921" },
		-- Should I change things up?
		{ Cue = "/VO/ZagreusHome_3543", RequiredPlayed = { "/VO/ZagreusField_2918" }, },
		-- Maybe I should switch.
		{ Cue = "/VO/ZagreusHome_3544", RequiredPlayed = { "/VO/ZagreusField_2918" }, },
		-- Try another one maybe...
		{ Cue = "/VO/ZagreusHome_3545", RequiredPlayed = { "/VO/ZagreusField_2918" }, },
		-- Could try a different one...
		{ Cue = "/VO/ZagreusHome_3546", RequiredPlayed = { "/VO/ZagreusField_2918" }, },
	},
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlayAll = 0.33,
		CooldownTime = 200,
		CooldownName = "KeepsakesMentionedRecently",
		PreLineWait = 0.6,

		-- Keepsakes hold power.
		{ Cue = "/VO/ZagreusHome_0130", },
		-- Let's see here.
		{ Cue = "/VO/ZagreusHome_0129", },
		-- Which to choose.
		{ Cue = "/VO/ZagreusHome_0132", },
		-- Which one.
		{ Cue = "/VO/ZagreusHome_0133", },
		-- My keepsakes...
		{ Cue = "/VO/ZagreusField_0922", },
		-- Won't bother asking how come all my keepsakes are here.
		{ Cue = "/VO/ZagreusField_0923", PlayOnce = true, RequiredRooms = { "A_PostBoss01", "B_PostBoss01", "C_PreBoss01" }, },
		-- Hey it's my keepsakes.
		{ Cue = "/VO/ZagreusField_0924", PlayOnce = true, RequiredRooms = { "A_PostBoss01", "B_PostBoss01", "C_PreBoss01" }, },
		-- Maybe I should switch things up.
		{ Cue = "/VO/ZagreusField_0925", RequiredMinAwardTraits = 2, },
	},
}
GlobalVoiceLines.AwardSelectedVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlay = 0.5,
		PreLineWait = 0.45,
		RequiredAnyTrueFlags = { "DusaFiredFromJob", "DusaNotYetReHired" },
		RequiredAnyKeepsakes = { "LifeOnUrnTrait", "DusaAssistTrait" },

		-- Dusa's not around to help me now...
		{ Cue = "/VO/ZagreusField_3773", },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		PreLineWait = 0.45,

		-- Go with that one.
		{ Cue = "/VO/ZagreusHome_0135", },
		-- All set.
		{ Cue = "/VO/ZagreusHome_0136", },
		-- Might help.
		{ Cue = "/VO/ZagreusHome_0137", },
		-- OK!
		{ Cue = "/VO/ZagreusHome_0364", },
		-- Should help.
		{ Cue = "/VO/ZagreusHome_0365", },
	},
}
GlobalVoiceLines.AwardMenuEmptyVoiceLines =
{
	SkipAnim = true,
	BreakIfPlayed = true,
	RandomRemaining = true,
	PlayOnceFromTableThisRun = true,
	SuccessiveChanceToPlayAll = 0.5,
	PreLineWait = 0.4,

	-- Nothing here yet.
	{ Cue = "/VO/ZagreusHome_0131" },
	-- Empty for now.
	{ Cue = "/VO/ZagreusHome_0361" },
	-- I'll have to come back later.
	{ Cue = "/VO/ZagreusHome_0362" },
	-- No keepsakes yet.
	{ Cue = "/VO/ZagreusHome_0363" },
}
GlobalVoiceLines.AwardMenuNewLegendaryVoiceLines =
{
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PlayOnceFromTableThisRun = true,
		PreLineWait = 0.6,
		PlayOnce = true,

		-- I got a new Companion! I can bring it along with my other Keepsake.
		{ Cue = "/VO/ZagreusHome_1493" },
	},
	[2] = GlobalVoiceLines.AwardMenuNewAvailableVoiceLines
}
GlobalVoiceLines.AwardMenuLegendaryUpgradedVoiceLines =
{
	{
		SkipAnim = true,
		PlayOnce = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		Queue = "Always",

		-- Battie, you're all set!
		{ Cue = "/VO/ZagreusHome_1575", RequiresMaxAssistTrait = "FuryAssistTrait" },
		-- Shady, you're all set!
		{ Cue = "/VO/ZagreusHome_1576", RequiresMaxAssistTrait = "SisyphusAssistTrait" },
		-- Rib, you are all set!
		{ Cue = "/VO/ZagreusHome_1577", RequiresMaxAssistTrait = "SkellyAssistTrait" },
		-- Mort, you are all set!
		{ Cue = "/VO/ZagreusHome_1578", RequiresMaxAssistTrait = "ThanatosAssistTrait" },
		-- Fidi, you're all set!
		{ Cue = "/VO/ZagreusHome_2058", RequiresMaxAssistTrait = "DusaAssistTrait" },
		-- Antos, you're all set!
		{ Cue = "/VO/ZagreusHome_2766", RequiresMaxAssistTrait = "AchillesPatroclusAssistTrait" },
	},
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		PlayOnce = true,
		Queue = "Always",

		-- There you go, Battie!
		{ Cue = "/VO/ZagreusHome_1564", RequiredAssistKeepsake = "FuryAssistTrait" },
		-- Here you go, Shady!
		{ Cue = "/VO/ZagreusHome_1565", RequiredAssistKeepsake = "SisyphusAssistTrait" },
		-- Rib, this one's for you!
		{ Cue = "/VO/ZagreusHome_1566", RequiredAssistKeepsake = "SkellyAssistTrait" },
		-- Drink up, there, Mort!
		{ Cue = "/VO/ZagreusHome_1567", RequiredAssistKeepsake = "ThanatosAssistTrait" },
		-- There you go, Fidi!
		{ Cue = "/VO/ZagreusHome_2057", RequiredAssistKeepsake = "DusaAssistTrait" },
		-- Drink up, Antos!
		{ Cue = "/VO/ZagreusHome_2765", RequiredAssistKeepsake = "AchillesPatroclusAssistTrait" },
	},
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.5,

		-- Here you go!
		{ Cue = "/VO/ZagreusHome_1568" },
		-- There.
		{ Cue = "/VO/ZagreusHome_1569" },
		-- Upgraded!
		{ Cue = "/VO/ZagreusHome_1570" },
		-- Better than new.
		{ Cue = "/VO/ZagreusHome_1571" },
		-- There we go!
		{ Cue = "/VO/ZagreusHome_1572" },
		-- Better.
		{ Cue = "/VO/ZagreusHome_1573" },
		-- Powered up.
		{ Cue = "/VO/ZagreusHome_1574" },
	},
}
GlobalVoiceLines.AwardMenuNewAvailableVoiceLines =
{
	SkipAnim = true,
	BreakIfPlayed = true,
	RandomRemaining = true,
	PlayOnceFromTableThisRun = true,
	PreLineWait = 0.6,
	RequiredScreenOpen = "AwardMenu",
	RequiredFalseRooms = { "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },

	-- One for the old collection.
	-- { Cue = "/VO/ZagreusField_0430", },
	-- Got something new to try.
	{ Cue = "/VO/ZagreusHome_0356" },
	-- Another keepsake.
	{ Cue = "/VO/ZagreusField_0429", RequiredPlayed = { "/VO/ZagreusHome_0356" } },
	-- That's a new one.
	{ Cue = "/VO/ZagreusField_0431", RequiredPlayed = { "/VO/ZagreusHome_0356" } },
	-- Excellent.
	{ Cue = "/VO/ZagreusField_0432", RequiredPlayed = { "/VO/ZagreusHome_0356" } },
	-- A new addition to the old collection.
	{ Cue = "/VO/ZagreusHome_0134", RequiredPlayed = { "/VO/ZagreusHome_0356" } },
	-- What's this one here.
	{ Cue = "/VO/ZagreusHome_0357", RequiredPlayed = { "/VO/ZagreusHome_0356" } },
	-- What's that one there.
	{ Cue = "/VO/ZagreusHome_0358", RequiredPlayed = { "/VO/ZagreusHome_0356" } },
	-- That one looks interesting.
	{ Cue = "/VO/ZagreusHome_0359", RequiredPlayed = { "/VO/ZagreusHome_0356" } },
	-- What's this one do.
	{ Cue = "/VO/ZagreusHome_0360", RequiredPlayed = { "/VO/ZagreusHome_0356" } },
	-- New one there.
	{ Cue = "/VO/ZagreusHome_3539", RequiredPlayed = { "/VO/ZagreusHome_0356" } },
	-- What's that one do?
	{ Cue = "/VO/ZagreusHome_3540", RequiredPlayed = { "/VO/ZagreusHome_0356" } },
	-- New keepsake.
	{ Cue = "/VO/ZagreusHome_3541", RequiredPlayed = { "/VO/ZagreusHome_0356" } },
	-- Let's see what that one does.
	{ Cue = "/VO/ZagreusHome_3542", RequiredPlayed = { "/VO/ZagreusHome_0356" } },
}
GlobalVoiceLines.OpenedWeaponUpgradeMenuVoiceLines =
{
	Cooldowns =
	{
		{ Name = "ZagreusWeaponUpgradeScreenOpenedSpeech", Time = 60 },
	},
	{
		PlayOnce = true,
		SkipAnim = true,
		BreakIfPlayed = true,
		PreLineWait = 1.4,
		RequiredTextLines = { "AchillesRevealsGuanYuAspect01" },
		RequiredPlayed = { "/VO/ZagreusHome_2027", },
		Queue = "Always",

		-- Varatha... who's this... Guan Yu?
		-- { Cue = "/VO/ZagreusHome_1624", RequiredWeapon = "SpearWeapon", },
		-- A new aspect... who's Guan Yu?
		{ Cue = "/VO/ZagreusHome_2028", RequiredWeapon = "SpearWeapon", },
	},
	{
		PlayOnce = true,
		SkipAnim = true,
		BreakIfPlayed = true,
		PreLineWait = 1.4,
		RequiredTextLines = { "NyxRevealsArthurAspect01" },
		RequiredPlayed = { "/VO/ZagreusHome_2047", },
		Queue = "Always",

		-- A future aspect... what sort of name is Arthur?
		{ Cue = "/VO/ZagreusHome_2048", RequiredWeapon = "SwordWeapon", },
	},
	{
		PlayOnce = true,
		SkipAnim = true,
		BreakIfPlayed = true,
		PreLineWait = 1.4,
		RequiredTextLines = { "ArtemisRevealsRamaAspect01" },
		RequiredPlayed = { "/VO/ZagreusHome_2052", },
		Queue = "Always",

		-- A hidden aspect... Rama, who are you...?
		{ Cue = "/VO/ZagreusHome_2053", RequiredWeapon = "BowWeapon", },
	},
	{
		PlayOnce = true,
		SkipAnim = true,
		BreakIfPlayed = true,
		PreLineWait = 1.5,
		RequiredTextLines = { "ChaosRevealsBeowulfAspect01" },
		RequiredPlayed = { "/VO/ZagreusHome_2648", },
		Queue = "Always",

		-- A future aspect... Beowulf is going to be tough...
		{ Cue = "/VO/ZagreusHome_2649", RequiredWeapon = "ShieldWeapon", },
	},
	{
		PlayOnce = true,
		SkipAnim = true,
		BreakIfPlayed = true,
		PreLineWait = 1.4,
		RequiredTextLines = { "MinotaurRevealsGilgameshAspect01" },
		RequiredPlayed = { "/VO/ZagreusHome_3490", },
		Queue = "Always",

		-- The hidden aspect of an ancient god-king... Gilgamesh.
		{ Cue = "/VO/ZagreusHome_3491", RequiredWeapon = "FistWeapon", },
	},
	{
		PlayOnce = true,
		SkipAnim = true,
		BreakIfPlayed = true,
		PreLineWait = 1.5,
		RequiredTextLines = { "ZeusRevealsLuciferAspect01" },
		RequiredPlayed = { "/VO/ZagreusHome_2653", },
		Queue = "Always",

		-- A hidden aspect... this Lucifer won't be needing it.
		{ Cue = "/VO/ZagreusHome_2654", RequiredWeapon = "GunWeapon", },
	},
	{
		SkipAnim = true,
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.9,
		SuccessiveChanceToPlay = 0.6,

		-- Stygius... you're revealing your past?
		{ Cue = "/VO/ZagreusHome_1165", RequiredWeapon = "SwordWeapon", RequiredLastInteractedWeaponUpgradeMaxLevel = 0 },
		-- Stygius.
		{ Cue = "/VO/ZagreusHome_1272", RequiredWeapon = "SwordWeapon", RequiredPlayed = { "/VO/ZagreusHome_1165" }, RequiredLastInteractedWeaponUpgradeMinLevel = 1, },
		-- Stygius.
		{ Cue = "/VO/ZagreusHome_1273", RequiredWeapon = "SwordWeapon", RequiredPlayed = { "/VO/ZagreusHome_1165" }, RequiredLastInteractedWeaponUpgradeMinLevel = 3, },
		-- Coronacht... is this what you really are?
		{ Cue = "/VO/ZagreusHome_1166", RequiredWeapon = "BowWeapon", RequiredLastInteractedWeaponUpgradeMaxLevel = 0 },
		-- Coronacht.
		{ Cue = "/VO/ZagreusHome_1278", RequiredWeapon = "BowWeapon", RequiredPlayed = { "/VO/ZagreusHome_1166" }, RequiredLastInteractedWeaponUpgradeMinLevel = 1, },
		-- Coronacht.
		{ Cue = "/VO/ZagreusHome_1279", RequiredWeapon = "BowWeapon", RequiredPlayed = { "/VO/ZagreusHome_1166" }, RequiredLastInteractedWeaponUpgradeMinLevel = 3, },
		-- Aegis... you are as old as time...
		{ Cue = "/VO/ZagreusHome_1167", RequiredWeapon = "ShieldWeapon", RequiredLastInteractedWeaponUpgradeMaxLevel = 0 },
		-- Aegis.
		{ Cue = "/VO/ZagreusHome_1276", RequiredWeapon = "ShieldWeapon", RequiredPlayed = { "/VO/ZagreusHome_1167" }, RequiredLastInteractedWeaponUpgradeMinLevel = 1, },
		-- Aegis.
		{ Cue = "/VO/ZagreusHome_1277", RequiredWeapon = "ShieldWeapon", RequiredPlayed = { "/VO/ZagreusHome_1167" }, RequiredLastInteractedWeaponUpgradeMinLevel = 3, },
		-- Varatha... you once were Father's spear...
		{ Cue = "/VO/ZagreusHome_1168", RequiredWeapon = "SpearWeapon", RequiredLastInteractedWeaponUpgradeMaxLevel = 0 },
		-- Varatha.
		{ Cue = "/VO/ZagreusHome_1274", RequiredWeapon = "SpearWeapon", RequiredPlayed = { "/VO/ZagreusHome_1168" }, RequiredLastInteractedWeaponUpgradeMinLevel = 1, },
		-- Varatha.
		{ Cue = "/VO/ZagreusHome_1275", RequiredWeapon = "SpearWeapon", RequiredPlayed = { "/VO/ZagreusHome_1168" }, RequiredLastInteractedWeaponUpgradeMinLevel = 3, },
		-- Malphon... I see everything you are.
		{ Cue = "/VO/ZagreusHome_2035", RequiredWeapon = "FistWeapon", RequiredLastInteractedWeaponUpgradeMaxLevel = 0 },
		-- Malphon.
		{ Cue = "/VO/ZagreusHome_2044", RequiredWeapon = "FistWeapon", RequiredPlayed = { "/VO/ZagreusHome_2035" }, RequiredLastInteractedWeaponUpgradeMinLevel = 1, },
		-- Malphon.
		{ Cue = "/VO/ZagreusHome_2045", RequiredWeapon = "FistWeapon", RequiredPlayed = { "/VO/ZagreusHome_2035" }, RequiredLastInteractedWeaponUpgradeMinLevel = 3, },
		-- Exagryph... you're telling me your secrets...
		{ Cue = "/VO/ZagreusHome_1169", RequiredWeapon = "GunWeapon", RequiredLastInteractedWeaponUpgradeMaxLevel = 0 },
		-- Exagryph.
		{ Cue = "/VO/ZagreusHome_1280", RequiredWeapon = "GunWeapon", RequiredPlayed = { "/VO/ZagreusHome_1169" }, RequiredLastInteractedWeaponUpgradeMinLevel = 1, },
		-- Exagryph.
		{ Cue = "/VO/ZagreusHome_1281", RequiredWeapon = "GunWeapon", RequiredPlayed = { "/VO/ZagreusHome_1169" }, RequiredLastInteractedWeaponUpgradeMinLevel = 3, },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.9,

		-- Let me see you now for what you truly are.
		{ Cue = "/VO/ZagreusHome_1170", },
		-- You are bound to me, and I am your host.
		{ Cue = "/VO/ZagreusHome_1171", },
		-- Let's test the bond between us.
		{ Cue = "/VO/ZagreusHome_1172", },
		-- What are the limits of your power?
		{ Cue = "/VO/ZagreusHome_1173", },
		-- You're no mere weapon, are you.
		{ Cue = "/VO/ZagreusHome_1174", },
		-- What infernal forge created you...?
		{ Cue = "/VO/ZagreusHome_1175", },
		-- Far greater gods than I once wielded you.
		{ Cue = "/VO/ZagreusHome_1176", },
		-- You are as multifaceted as anyone I know.
		{ Cue = "/VO/ZagreusHome_1177", },
		-- Let me see into your past.
		{ Cue = "/VO/ZagreusHome_1178", },
		-- I have returned.
		{ Cue = "/VO/ZagreusHome_1270" },
		-- I've returned.
		{ Cue = "/VO/ZagreusHome_1271" },
	},
}

-- these need to be initialized before they are called below
GlobalVoiceLines.SkellyWeaponUpgradePurchasedReactionVoiceLines =
{
	{
		PreLineWait = 1.0,
		BreakIfPlayed = true,
		-- SkellyTrueDeathQuestCompleteRequirements
		RequiredWeapon = "SwordWeapon",
		-- RequiredLastInteractedWeaponUpgradeMinLevel = 5,
		RequiredAnyTextLines = { "SkellyTrueDeathQuest_Beginning_01", "SkellyTrueDeathQuest_Beginning_01B"  },
		RequiredFalseTextLines = { "SkellyTrueDeathQuestComplete" },
		RequiredLastInteractedWeaponUpgrade = "SwordBaseUpgradeTrait",
		RequiredLastInteractedWeaponUpgradeMaxed = true,
		ObjectType = "TrainingMelee",

		-- That's it... the blade... you got to let me have it with that thing.
		{ Cue = "/VO/Skelly_0312" },
	},
	{
		PreLineWait = 1.0,
		PlayOnce = true,
		PlayOnceContext = "GuanYuUnlock",
		BreakIfPlayed = true,
		RequiredWeapon = "SpearWeapon",
		RequiredLastInteractedWeaponUpgrade = "SpearSpinTravel",
		ObjectType = "TrainingMelee",

		-- Whoa what in the world is that?
		{ Cue = "/VO/Skelly_0446" },
	},
	{
		PreLineWait = 1.0,
		PlayOnce = true,
		PlayOnceContext = "ArthurUnlock",
		BreakIfPlayed = true,
		RequiredWeapon = "SwordWeapon",
		RequiredLastInteractedWeaponUpgrade = "SwordConsecrationTrait",
		ObjectType = "TrainingMelee",

		-- Whoaa that's a nifty sword!
		{ Cue = "/VO/Skelly_0466" },
	},
	{
		PreLineWait = 1.0,
		PlayOnce = true,
		PlayOnceContext = "RamaUnlock",
		BreakIfPlayed = true,
		RequiredWeapon = "BowWeapon",
		RequiredLastInteractedWeaponUpgrade = "BowBondTrait",
		ObjectType = "TrainingMelee",

		-- Hoh now that's a shiny bow you got right there!
		{ Cue = "/VO/Skelly_0467" },
	},
	{
		PreLineWait = 1.0,
		PlayOnce = true,
		PlayOnceContext = "BeowulfUnlock",
		BreakIfPlayed = true,
		RequiredWeapon = "BowWeapon",
		RequiredLastInteractedWeaponUpgrade = "ShieldLoadAmmoTrait",
		ObjectType = "TrainingMelee",

		-- Your serving platter, what did you just do?
		{ Cue = "/VO/Skelly_0470" },
	},
	{
		PreLineWait = 1.0,
		PlayOnce = true,
		PlayOnceContext = "GilgameshUnlock",
		BreakIfPlayed = true,
		RequiredWeapon = "FistWeapon",
		RequiredLastInteractedWeaponUpgrade = "FistDetonateTrait",
		ObjectType = "TrainingMelee",

		-- Eugh, what happened to your mitts, boyo?
		{ Cue = "/VO/Skelly_0584" },
	},	
	{
		PreLineWait = 1.0,
		PlayOnce = true,
		PlayOnceContext = "LuciferUnlock",
		BreakIfPlayed = true,
		RequiredWeapon = "BowWeapon",
		RequiredLastInteractedWeaponUpgrade = "GunLoadedGrenadeTrait",
		ObjectType = "TrainingMelee",

		-- Uh that's no shooty thing I recognize.
		{ Cue = "/VO/Skelly_0472" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		CooldownTime = 16,
		ObjectType = "TrainingMelee",
		SuccessiveChanceToPlay = 0.25,

		-- Hey what just happened?
		{ Cue = "/VO/Skelly_0252", },
		-- Whoa what was that?
		{ Cue = "/VO/Skelly_0253", },
		-- Hey what's going on back there?
		{ Cue = "/VO/Skelly_0254", },
		-- What's all the racket over there?
		{ Cue = "/VO/Skelly_0255", },
		-- Hey whoa what?
		{ Cue = "/VO/Skelly_0256", },
		-- What did you do, boyo?
		{ Cue = "/VO/Skelly_0257", },
		-- Whoa can I see?
		{ Cue = "/VO/Skelly_0258", },
		-- What did you just do?
		{ Cue = "/VO/Skelly_0259", },
		-- You all right back there pal?
		{ Cue = "/VO/Skelly_0260", },
		-- What kind of sorcery was that?
		{ Cue = "/VO/Skelly_0261", },
	},
}
GlobalVoiceLines.WeaponUpgradePurchasedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		Cooldowns =
		{
			{ Name = "ZagreusWeaponUpgradeScreenSpeech", Time = 3 },
		},

		-- Grant me the aspect of Nemesis!
		{ Cue = "/VO/ZagreusHome_1195", RequiredLastInteractedWeaponUpgrade = "SwordCriticalParryTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Poseidon!
		{ Cue = "/VO/ZagreusHome_1196", RequiredLastInteractedWeaponUpgrade = "DislodgeAmmoTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Arthur!
		{ Cue = "/VO/ZagreusHome_2049", RequiredLastInteractedWeaponUpgrade = "SwordConsecrationTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Hera!
		{ Cue = "/VO/ZagreusHome_1197", RequiredLastInteractedWeaponUpgrade = "BowLoadAmmoTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Chiron!
		{ Cue = "/VO/ZagreusHome_1198", RequiredLastInteractedWeaponUpgrade = "BowMarkHomingTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Rama!
		{ Cue = "/VO/ZagreusHome_2054", RequiredLastInteractedWeaponUpgrade = "BowBondTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Achilles himself!
		{ Cue = "/VO/ZagreusHome_1199", RequiredLastInteractedWeaponUpgrade = "SpearTeleportTrait", Queue = "Interrupt" },
		-- Grant me the aspect of my father!
		{ Cue = "/VO/ZagreusHome_1200", RequiredLastInteractedWeaponUpgrade = "SpearWeaveTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Guan Yu!
		{ Cue = "/VO/ZagreusHome_1625", RequiredLastInteractedWeaponUpgrade = "SpearSpinTravel", Queue = "Interrupt" },
		-- Grant me the aspect of Zeus!
		{ Cue = "/VO/ZagreusHome_1201", RequiredLastInteractedWeaponUpgrade = "ShieldTwoShieldTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Chaos!
		{ Cue = "/VO/ZagreusHome_1202", RequiredLastInteractedWeaponUpgrade = "ShieldRushBonusProjectileTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Beowulf!
		{ Cue = "/VO/ZagreusHome_2650", RequiredLastInteractedWeaponUpgrade = "ShieldLoadAmmoTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Talos!
		{ Cue = "/VO/ZagreusHome_2038", RequiredLastInteractedWeaponUpgrade = "FistVacuumTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Demeter!
		{ Cue = "/VO/ZagreusHome_2039", RequiredLastInteractedWeaponUpgrade = "FistWeaveTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Gilgamesh!
		{ Cue = "/VO/ZagreusHome_3492", RequiredLastInteractedWeaponUpgrade = "FistDetonateTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Hestia!
		{ Cue = "/VO/ZagreusHome_1203", RequiredLastInteractedWeaponUpgrade = "GunManualReloadTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Eris!
		{ Cue = "/VO/ZagreusHome_1204", RequiredLastInteractedWeaponUpgrade = "GunGrenadeSelfEmpowerTrait", Queue = "Interrupt" },
		-- Grant me the aspect of Lucifer!
		{ Cue = "/VO/ZagreusHome_2655", RequiredLastInteractedWeaponUpgrade = "GunLoadedGrenadeTrait", Queue = "Interrupt" },
		-- My aspect of Stygius grows stronger.
		{ Cue = "/VO/ZagreusHome_2008", RequiredLastInteractedWeaponUpgrade = "SwordBaseUpgradeTrait" },
		-- My aspect of Coronacht is stronger now.
		{ Cue = "/VO/ZagreusHome_2010", RequiredLastInteractedWeaponUpgrade = "BowBaseUpgradeTrait" },
		-- My aspect of Varatha grows in power.
		{ Cue = "/VO/ZagreusHome_2009", RequiredLastInteractedWeaponUpgrade = "SpearBaseUpgradeTrait" },
		-- My aspect of Aegis became stronger.
		{ Cue = "/VO/ZagreusHome_2011", RequiredLastInteractedWeaponUpgrade = "ShieldBaseUpgradeTrait" },
		-- My aspect of Malphon grows stronger still.
		{ Cue = "/VO/ZagreusHome_2046", RequiredLastInteractedWeaponUpgrade = "FistBaseUpgradeTrait" },
		-- My aspect of Exagryph feels even stronger.
		{ Cue = "/VO/ZagreusHome_2012", RequiredLastInteractedWeaponUpgrade = "GunBaseUpgradeTrait" },
	},
	[2] = GlobalVoiceLines.SkellyWeaponUpgradePurchasedReactionVoiceLines,
}

GlobalVoiceLines.UpgradedWeaponUpgradePurchasedVoiceLines =
{
	-- once upgrade is maxed
	{
		Queue = "Interrupt",
		{
			PlayOnce = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			RequiredLastInteractedWeaponUpgradeMaxed = true,
			RequiredWeapon = "SwordWeapon",
			RequiredLastInteractedWeaponUpgrade = "SwordConsecrationTrait",

			-- The full might of Holy Excalibur...
			{ Cue = "/VO/ZagreusHome_3563" },
		},
		{
			PlayOnce = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			RequiredLastInteractedWeaponUpgradeMaxed = true,
			RequiredWeapon = "BowWeapon",
			RequiredLastInteractedWeaponUpgrade = "BowBondTrait",

			-- The pure essence of Celestial Sharanga...
			{ Cue = "/VO/ZagreusHome_3566" },
		},
		{
			PlayOnce = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			RequiredLastInteractedWeaponUpgradeMaxed = true,
			RequiredWeapon = "ShieldWeapon",
			RequiredLastInteractedWeaponUpgrade = "ShieldLoadAmmoTrait",

			-- The true strength of Naegling's Board...
			{ Cue = "/VO/ZagreusHome_3565" },
		},
		{
			PlayOnce = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			RequiredLastInteractedWeaponUpgradeMaxed = true,
			RequiredWeapon = "SpearWeapon",
			RequiredLastInteractedWeaponUpgrade = "SpearSpinTravel",

			-- The sheer bloodthirst of the Frost Fair Blade...
			{ Cue = "/VO/ZagreusHome_3564" },
		},
		{
			PlayOnce = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			RequiredLastInteractedWeaponUpgradeMaxed = true,
			RequiredWeapon = "FistWeapon",
			RequiredLastInteractedWeaponUpgrade = "FistDetonateTrait",

			-- The raw savagery of the Claws of Enkidu...
			{ Cue = "/VO/ZagreusHome_3567" },
		},
		{
			PlayOnce = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			RequiredLastInteractedWeaponUpgradeMaxed = true,
			RequiredWeapon = "GunWeapon",
			RequiredLastInteractedWeaponUpgrade = "GunLoadedGrenadeTrait",

			-- The infernal fury of Igneus Eden...
			{ Cue = "/VO/ZagreusHome_3568" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			RequiredLastInteractedWeaponUpgradeMaxed = true,
			Cooldowns =
			{
				{ Name = "ZagreusWeaponUpgradeScreenSpeech", Time = 2 },
			},

			-- That's as far as we can go.
			{ Cue = "/VO/ZagreusHome_1262" },
			-- That's everything.
			{ Cue = "/VO/ZagreusHome_1263" },
			-- I see everything about you now.
			{ Cue = "/VO/ZagreusHome_1264" },
			-- Your entire past.
			{ Cue = "/VO/ZagreusHome_1265" },
			-- Our bond is now complete.
			{ Cue = "/VO/ZagreusHome_1266" },
			-- Thus we are bound forever.
			{ Cue = "/VO/ZagreusHome_1267" },
			-- Now you are awake.
			{ Cue = "/VO/ZagreusHome_1268" },
			-- We've reached the limit.
			{ Cue = "/VO/ZagreusHome_1269" },
			-- We know each other, Stygius.
			{ Cue = "/VO/ZagreusHome_2658", RequiredWeapon = "SwordWeapon" },
			-- Good to get to know you better, Coronacht.
			{ Cue = "/VO/ZagreusHome_2659", RequiredWeapon = "BowWeapon" },
			-- Always a pleasure, Aegis.
			{ Cue = "/VO/ZagreusHome_2660", RequiredWeapon = "ShieldWeapon" },
			-- Let's do this again sometime, Varatha.
			{ Cue = "/VO/ZagreusHome_2661", RequiredWeapon = "SpearWeapon" },
			-- Glad we could do this, Malphon.
			{ Cue = "/VO/ZagreusHome_2663", RequiredWeapon = "FistWeapon" },
			-- Appreciate your support, Exagryph.
			{ Cue = "/VO/ZagreusHome_2662", RequiredWeapon = "GunWeapon" },
			-- I see this aspect clearly now.
			{ Cue = "/VO/ZagreusHome_2664" },
			-- Our bond is forged forever.
			{ Cue = "/VO/ZagreusHome_2665" },
			-- I see you truly now.
			{ Cue = "/VO/ZagreusHome_2666" },
			-- We are inseparable now.
			{ Cue = "/VO/ZagreusHome_2667" },
		},
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.33,
			Cooldowns =
			{
				{ Name = "ZagreusWeaponUpgradeScreenSpeech", Time = 2 },
			},

			-- Stygius: Awaken!
			{ Cue = "/VO/ZagreusHome_1179", RequiredLastInteractedWeaponName = "SwordWeapon" },
			-- Stygius, reveal your secrets!
			{ Cue = "/VO/ZagreusHome_1180", RequiredLastInteractedWeaponName = "SwordWeapon" },
			-- Coronacht: Awaken!
			{ Cue = "/VO/ZagreusHome_1181", RequiredLastInteractedWeaponName = "BowWeapon" },
			-- Coronacht, reveal your secrets!
			{ Cue = "/VO/ZagreusHome_1182", RequiredLastInteractedWeaponName = "BowWeapon" },
			-- Aegis: Awaken!
			{ Cue = "/VO/ZagreusHome_1183", RequiredLastInteractedWeaponName = "ShieldWeapon" },
			-- Aegis, reveal your secrets!
			{ Cue = "/VO/ZagreusHome_1184", RequiredLastInteractedWeaponName = "ShieldWeapon" },
			-- Varatha: Awaken!
			{ Cue = "/VO/ZagreusHome_1185", RequiredLastInteractedWeaponName = "SpearWeapon" },
			-- Varatha, reveal your secrets!
			{ Cue = "/VO/ZagreusHome_1186", RequiredLastInteractedWeaponName = "SpearWeapon" },
			-- Malphon: Awaken!
			{ Cue = "/VO/ZagreusHome_2036", RequiredLastInteractedWeaponName = "FistWeapon" },
			-- Malphon, reveal your secrets!
			{ Cue = "/VO/ZagreusHome_2037", RequiredLastInteractedWeaponName = "FistWeapon" },
			-- Exagryph: Awaken!
			{ Cue = "/VO/ZagreusHome_1187", RequiredLastInteractedWeaponName = "GunWeapon" },
			-- Exagryph, reveal your secrets!
			{ Cue = "/VO/ZagreusHome_1188", RequiredLastInteractedWeaponName = "GunWeapon" },
		},
		{
			RandomRemaining = true,
			PreLineWait = 0.35,
			SuccessiveChanceToPlay = 0.66,
			Cooldowns =
			{
				{ Name = "ZagreusWeaponUpgradeScreenSpeech", Time = 2 },
			},

			-- Our bond grows stronger.
			{ Cue = "/VO/ZagreusHome_1190" },
			-- Hidden power.
			{ Cue = "/VO/ZagreusHome_1191" },
			-- Together, we grow stronger.
			{ Cue = "/VO/ZagreusHome_1192" },
			-- Show yourself.
			{ Cue = "/VO/ZagreusHome_1193" },
			-- Our bond strengthens.
			{ Cue = "/VO/ZagreusHome_1194" },
			-- Show me your power.
			{ Cue = "/VO/ZagreusHome_1254" },
			-- Remember your past.
			{ Cue = "/VO/ZagreusHome_1255" },
			-- Power beyond time.
			{ Cue = "/VO/ZagreusHome_1256" },
			-- Recover your ancient strength.
			{ Cue = "/VO/ZagreusHome_1257" },
			-- I see you.
			{ Cue = "/VO/ZagreusHome_1258" },
			-- We are one.
			{ Cue = "/VO/ZagreusHome_1259" },
			-- Live through me again.
			{ Cue = "/VO/ZagreusHome_1260" },
			-- Aid me, and live again.
			{ Cue = "/VO/ZagreusHome_1261" },
		},
	},
	[2] = GlobalVoiceLines.SkellyWeaponUpgradePurchasedReactionVoiceLines,
}

GlobalVoiceLines.SwitchedWeaponUpgradeVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.8,
		Cooldowns =
		{
			{ Name = "ZagreusWeaponUpgradeScreenSpeech", Time = 1 },
		},
		RequiredFalseTraits = { "SwordCriticalParryTrait", "DislodgeAmmoTrait", "SwordConsecrationTrait", "BowLoadAmmoTrait", "BowMarkHomingTrait", "SpearTeleportTrait", "SpearWeaveTrait", "ShieldTwoShieldTrait", "ShieldRushBonusProjectileTrait", "GunManualReloadTrait", "GunGrenadeSelfEmpowerTrait", "SpearSpinTravel", "FistVacuumTrait", "FistWeaveTrait", "FistDetonateTrait", "ShieldLoadAmmoTrait", "GunLoadedGrenadeTrait", "BowBondTrait" },

		-- Zagreus.
		{ Cue = "/VO/ZagreusHome_1221" },
		-- Me.
		{ Cue = "/VO/ZagreusHome_1222" },
		-- Myself...!
		{ Cue = "/VO/ZagreusHome_1223" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.8,
		Cooldowns =
		{
			{ Name = "ZagreusWeaponUpgradeScreenSpeech", Time = 1 },
		},

		-- Nemesis.
		{ Cue = "/VO/ZagreusHome_1205", RequiredLastInteractedWeaponUpgrade = "SwordCriticalParryTrait"  },
		-- Nemesis...!
		{ Cue = "/VO/ZagreusHome_1206", RequiredLastInteractedWeaponUpgrade = "SwordCriticalParryTrait"  },
		-- Poseidon.
		{ Cue = "/VO/ZagreusHome_1207", RequiredLastInteractedWeaponUpgrade = "DislodgeAmmoTrait" },
		-- Poseidon...!
		{ Cue = "/VO/ZagreusHome_1208", RequiredLastInteractedWeaponUpgrade = "DislodgeAmmoTrait" },
		-- Arthur.
		{ Cue = "/VO/ZagreusHome_2050", RequiredLastInteractedWeaponUpgrade = "SwordConsecrationTrait" },
		-- Arthur...!
		{ Cue = "/VO/ZagreusHome_2051", RequiredLastInteractedWeaponUpgrade = "SwordConsecrationTrait" },
		-- Hera.
		{ Cue = "/VO/ZagreusHome_1209", RequiredLastInteractedWeaponUpgrade = "BowLoadAmmoTrait" },
		-- Hera...!
		{ Cue = "/VO/ZagreusHome_1210", RequiredLastInteractedWeaponUpgrade = "BowLoadAmmoTrait" },
		-- Chiron.
		{ Cue = "/VO/ZagreusHome_1211", RequiredLastInteractedWeaponUpgrade = "BowMarkHomingTrait" },
		-- Chiron...!
		{ Cue = "/VO/ZagreusHome_1212", RequiredLastInteractedWeaponUpgrade = "BowMarkHomingTrait" },
		-- Rama.
		{ Cue = "/VO/ZagreusHome_2055", RequiredLastInteractedWeaponUpgrade = "BowBondTrait" },
		-- Rama...!
		{ Cue = "/VO/ZagreusHome_2056", RequiredLastInteractedWeaponUpgrade = "BowBondTrait" },
		-- Achilles.
		{ Cue = "/VO/ZagreusHome_1213", RequiredLastInteractedWeaponUpgrade = "SpearTeleportTrait" },
		-- Achilles...!
		{ Cue = "/VO/ZagreusHome_1214", RequiredLastInteractedWeaponUpgrade = "SpearTeleportTrait" },
		-- Hades.
		{ Cue = "/VO/ZagreusHome_1215", RequiredLastInteractedWeaponUpgrade = "SpearWeaveTrait" },
		-- Hades...!
		{ Cue = "/VO/ZagreusHome_1216", RequiredLastInteractedWeaponUpgrade = "SpearWeaveTrait" },
		-- Guan Yu.
		{ Cue = "/VO/ZagreusHome_1626", RequiredLastInteractedWeaponUpgrade = "SpearSpinTravel" },
		-- Guan Yu...!
		{ Cue = "/VO/ZagreusHome_1627", RequiredLastInteractedWeaponUpgrade = "SpearSpinTravel" },
		-- Zeus.
		{ Cue = "/VO/ZagreusHome_1217", RequiredLastInteractedWeaponUpgrade = "ShieldTwoShieldTrait" },
		-- Zeus...!
		{ Cue = "/VO/ZagreusHome_1218", RequiredLastInteractedWeaponUpgrade = "ShieldTwoShieldTrait" },
		-- Chaos.
		{ Cue = "/VO/ZagreusHome_1219", RequiredLastInteractedWeaponUpgrade = "ShieldRushBonusProjectileTrait" },
		-- Chaos...!
		{ Cue = "/VO/ZagreusHome_1220", RequiredLastInteractedWeaponUpgrade = "ShieldRushBonusProjectileTrait" },
		-- Beowulf.
		{ Cue = "/VO/ZagreusHome_2651", RequiredLastInteractedWeaponUpgrade = "ShieldLoadAmmoTrait" },
		-- Beowulf...!
		{ Cue = "/VO/ZagreusHome_2652", RequiredLastInteractedWeaponUpgrade = "ShieldLoadAmmoTrait" },
		-- Talos.
		{ Cue = "/VO/ZagreusHome_2040", RequiredLastInteractedWeaponUpgrade = "FistVacuumTrait" },
		-- Talos...!
		{ Cue = "/VO/ZagreusHome_2041", RequiredLastInteractedWeaponUpgrade = "FistVacuumTrait" },
		-- Demeter.
		{ Cue = "/VO/ZagreusHome_2042", RequiredLastInteractedWeaponUpgrade = "FistWeaveTrait" },
		-- Demeter...!
		{ Cue = "/VO/ZagreusHome_2043", RequiredLastInteractedWeaponUpgrade = "FistWeaveTrait" },
		-- Gilgamesh.
		{ Cue = "/VO/ZagreusHome_3493", RequiredLastInteractedWeaponUpgrade = "FistDetonateTrait" },
		-- Gilgamesh...!
		{ Cue = "/VO/ZagreusHome_3494", RequiredLastInteractedWeaponUpgrade = "FistDetonateTrait" },
		-- Hestia.
		{ Cue = "/VO/ZagreusHome_1234", RequiredLastInteractedWeaponUpgrade = "GunManualReloadTrait" },
		-- Hestia...!
		{ Cue = "/VO/ZagreusHome_1235", RequiredLastInteractedWeaponUpgrade = "GunManualReloadTrait" },
		-- Eris.
		{ Cue = "/VO/ZagreusHome_1236", RequiredLastInteractedWeaponUpgrade = "GunGrenadeSelfEmpowerTrait" },
		-- Eris...!
		{ Cue = "/VO/ZagreusHome_1237", RequiredLastInteractedWeaponUpgrade = "GunGrenadeSelfEmpowerTrait" },
		-- Lucifer.
		{ Cue = "/VO/ZagreusHome_2656", RequiredLastInteractedWeaponUpgrade = "GunLoadedGrenadeTrait" },
		-- Lucifer...!
		{ Cue = "/VO/ZagreusHome_2657", RequiredLastInteractedWeaponUpgrade = "GunLoadedGrenadeTrait" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		Cooldowns =
		{
			{ Name = "ZagreusWeaponUpgradeScreenSpeech", Time = 1 },
		},

		-- Transform.
		{ Cue = "/VO/ZagreusHome_1224" },
		-- Transform...!
		-- { Cue = "/VO/ZagreusHome_1225" },
		-- Change form.
		{ Cue = "/VO/ZagreusHome_1226" },
	},
}

GlobalVoiceLines.ClosedWeaponUpgradeMenuVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.75,
	SuccessiveChanceToPlay = 0.33,
	Cooldowns =
	{
		{ Name = "ZagreusAnyQuipSpeech" },
	},

	-- All right.
	{ Cue = "/VO/ZagreusHome_0108", },
	-- All right I'm ready.
	{ Cue = "/VO/ZagreusHome_0073" },
	-- All set.
	{ Cue = "/VO/ZagreusHome_0074" },
	-- Good to go.
	{ Cue = "/VO/ZagreusHome_0075" },
	-- Done.
	{ Cue = "/VO/ZagreusHome_0424" },
	-- Looking good.
	{ Cue = "/VO/ZagreusHome_0425" },
}

GlobalVoiceLines.StartNewRunVoiceLines =
{
	Cooldowns =
	{
		{ Name = "ZagreusStartNewRunSpeech", Time = 10 },
	},
	-- pact unlocked; engaging above threshold
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlayAll = 0.05,
		RequiredTrueFlags = { "ShrineUnlocked" },
		RequiredMinShrinePointsAboveThreshold = 1,

		-- Won't get extra Bounties this way, but why not.
		{ Cue = "/VO/ZagreusHome_1317", },
		-- Won't get Bounties any faster with this extra Heat.
		{ Cue = "/VO/ZagreusHome_1320", },
		-- Time to put in extra work for those Bounties.
		{ Cue = "/VO/ZagreusHome_1321", },
	},
	-- lower priority of the above
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.85,
		RequiredTrueFlags = { "ShrineUnlocked" },
		RequiredMinShrinePointsAboveThreshold = 8,

		-- I'm asking for it.
		{ Cue = "/VO/ZagreusHome_1147",	Cooldowns = { { Name = "ZagreusPactMiscSpeech", Time = 300 }, }, },
		-- Hah, why not.
		{ Cue = "/VO/ZagreusHome_1148",	Cooldowns = { { Name = "ZagreusPactMiscSpeech", Time = 300 }, }, },
		-- Should be simple!
		{ Cue = "/VO/ZagreusHome_1149",	Cooldowns = { { Name = "ZagreusPactMiscSpeech", Time = 300 }, }, },
		-- I have this.
		{ Cue = "/VO/ZagreusHome_1150",	Cooldowns = { { Name = "ZagreusPactMiscSpeech", Time = 300 }, }, },
		-- The Pact is sealed.
		{ Cue = "/VO/ZagreusHome_1151" },
		-- Do your worst, Father.
		{ Cue = "/VO/ZagreusHome_0607", },
		-- What's the worst that could happen?
		{ Cue = "/VO/ZagreusHome_0611", },
		-- What could go wrong.
		{ Cue = "/VO/ZagreusHome_0612", },
		-- My choice is made.
		{ Cue = "/VO/ZagreusHome_0608", RequiredTrueFlags = { "HardMode" }, },
		-- Wretches of the Underworld, take heed.
		{ Cue = "/VO/ZagreusHome_0609", RequiredTrueFlags = { "HardMode" }, },
		-- That ought to liven things up.
		{ Cue = "/VO/ZagreusHome_0610", RequiredTrueFlags = { "HardMode" }, },
		-- What's life without a little pain.
		{ Cue = "/VO/ZagreusHome_0614", RequiredTrueFlags = { "HardMode" }, },
	},
	-- Post Ending
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.25,
		RequiredTextLines = { "Ending01" },

		-- Let's get to work.
		{ Cue = "/VO/ZagreusField_4374", RequiredTextLines = { "Ending01" }, RequiredPlayed = { "/VO/ZagreusField_4382" }, },
		-- All right, let's get to work.
		{ Cue = "/VO/ZagreusField_4375", RequiredTextLines = { "Ending01" }, RequiredPlayed = { "/VO/ZagreusField_4382" }, },
		-- On to business, then.
		{ Cue = "/VO/ZagreusField_4376", RequiredTextLines = { "Ending01" }, RequiredPlayed = { "/VO/ZagreusField_4382" }, },
		-- Starting assignment now.
		{ Cue = "/VO/ZagreusField_4377", RequiredTextLines = { "Ending01" }, RequiredPlayed = { "/VO/ZagreusField_4382" }, },
		-- Starting assignment... now.
		{ Cue = "/VO/ZagreusField_4378", RequiredTextLines = { "Ending01" }, RequiredPlayed = { "/VO/ZagreusField_4382" }, },
		-- OK let's get this done.
		{ Cue = "/VO/ZagreusField_4379", RequiredTextLines = { "Ending01" }, RequiredPlayed = { "/VO/ZagreusField_4382" }, },
		-- Time to break out again.
		{ Cue = "/VO/ZagreusField_4380", RequiredTextLines = { "Ending01" }, RequiredPlayed = { "/VO/ZagreusField_4382" }, },
		-- Time to break out of here.
		{ Cue = "/VO/ZagreusField_4381", RequiredTextLines = { "Ending01" }, RequiredPlayed = { "/VO/ZagreusField_4382" }, },
		-- Time to go to work.
		{ Cue = "/VO/ZagreusField_4382", RequiredTextLines = { "Ending01" }, },
		-- All right, it's time to shine.
		{ Cue = "/VO/ZagreusField_4383", RequiredTextLines = { "Ending01" }, RequiredPlayed = { "/VO/ZagreusField_4382" }, },
		-- This one's for you, Mother.
		{ Cue = "/VO/ZagreusField_4384", RequiredTextLines = { "Ending01" }, RequiredPlayed = { "/VO/ZagreusField_4382" }, },
		-- Well then, let's get to work!
		{ Cue = "/VO/ZagreusField_4545", RequiredTextLines = { "Ending01" }, RequiredPlayed = { "/VO/ZagreusField_4382" }, },
		-- No stopping me this time.
		{ Cue = "/VO/ZagreusField_4385", RequiredTextLines = { "Ending01" }, RequiresLastRunCleared = true, RequiredPlayed = { "/VO/ZagreusField_4382" }, },
	},
	-- pact unlocked; engaging at threshold
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.75,
		RequiredTrueFlags = { "ShrineUnlocked" },
		RequiresShrinePointsAtThreshold = true,
		RequiredFalseFlags = { "HardMode" },

		-- Let's see what happens.
		{ Cue = "/VO/ZagreusHome_0594", },
		-- Do your worst, Father.
		{ Cue = "/VO/ZagreusHome_0607", },
		-- My choice is made.
		{ Cue = "/VO/ZagreusHome_0608", },
		-- Wretches of the Underworld, take heed.
		{ Cue = "/VO/ZagreusHome_0609", },
		-- That ought to liven things up.
		{ Cue = "/VO/ZagreusHome_0610", },
		-- What's the worst that could happen?
		{ Cue = "/VO/ZagreusHome_0611", },
		-- What could go wrong.
		{ Cue = "/VO/ZagreusHome_0612", },
		-- This ought to be interesting.
		{ Cue = "/VO/ZagreusHome_0613", },
		-- What's life without a little pain.
		{ Cue = "/VO/ZagreusHome_0614", },
		-- Let's see what happens.
		{ Cue = "/VO/ZagreusHome_0594", },
		-- Wretches of the Underworld, take heed.
		{ Cue = "/VO/ZagreusHome_0609", },
		-- That ought to liven things up.
		{ Cue = "/VO/ZagreusHome_0610", },
	},
	-- pact unlocked; not engaging pact
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.5,
		RequiredTrueFlags = { "ShrineUnlocked" },
		RequiredActiveShrinePointsMax = 0,

		-- No thank you.
		{ Cue = "/VO/ZagreusHome_1143" },
		-- No thanks.
		{ Cue = "/VO/ZagreusHome_1144" },
		-- Not this time.
		{ Cue = "/VO/ZagreusHome_1145" },
		-- I don't think so.
		{ Cue = "/VO/ZagreusHome_1146" },
		-- I'm through with Father's dirty work.
		{ Cue = "/VO/ZagreusHome_0589", RequiredFalseTextLines = { "Ending01" }, },
		-- I don't think so.
		{ Cue = "/VO/ZagreusHome_0590" },
		-- Not a chance.
		{ Cue = "/VO/ZagreusHome_0591" },
	},
	-- Well, time to go get killed again.
	{ Cue = "/VO/ZagreusHome_0103", PreLineWait = 0.3, BreakIfPlayed = true, RequiredCompletedRuns = 0 },
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		RequiredMinCompletedRuns = 1,
		PreLineWait = 0.3,
		SuccessiveChanceToPlay = 0.75,

		-- Well, time to go get killed again.
		{ Cue = "/VO/ZagreusScratch_0021b", RequiredMinCompletedRuns = 20 },
		-- All right one more time.
		{ Cue = "/VO/ZagreusHome_0033" },
		-- Ready as I'll ever be.
		{ Cue = "/VO/ZagreusHome_0034" },
		-- Time to go.
		{ Cue = "/VO/ZagreusHome_0035", CooldownName = "SaidGoRecently", CooldownTime = 40 },
		-- Here we go.
		{ Cue = "/VO/ZagreusField_0356", CooldownName = "SaidGoRecently", CooldownTime = 40 },
		-- Let's go.
		{ Cue = "/VO/ZagreusField_0357", CooldownName = "SaidGoRecently", CooldownTime = 40 },
		-- One more time.
		{ Cue = "/VO/ZagreusHome_0151" },
		-- Let's go.
		{ Cue = "/VO/ZagreusHome_0152", CooldownName = "SaidGoRecently", CooldownTime = 40 },
		-- Here we go.
		{ Cue = "/VO/ZagreusHome_0153", CooldownName = "SaidGoRecently", CooldownTime = 40 },
		-- Out we go.
		{ Cue = "/VO/ZagreusHome_0154", CooldownName = "SaidGoRecently", CooldownTime = 40 },
		-- No turning back.
		{ Cue = "/VO/ZagreusHome_0155" },
		-- Bye, everyone.
		{ Cue = "/VO/ZagreusHome_0156" },
		-- Darkness, give me strength.
		{ Cue = "/VO/ZagreusHome_0157" },
		-- Ready.
		{ Cue = "/VO/ZagreusHome_0345" },
		-- I'm ready.
		{ Cue = "/VO/ZagreusHome_0346" },
		-- Again.
		{ Cue = "/VO/ZagreusHome_0347" },
		-- Again!
		{ Cue = "/VO/ZagreusHome_0348" },
		-- Away we go.
		{ Cue = "/VO/ZagreusHome_0349", CooldownName = "SaidGoRecently", CooldownTime = 40 },
		-- Off we go.
		{ Cue = "/VO/ZagreusHome_0350", CooldownName = "SaidGoRecently", CooldownTime = 40 },
		-- Let's see what happens.
		{ Cue = "/VO/ZagreusHome_0594", RequiredTrueFlags = { "HardMode" }, },
		-- Do your worst, Father.
		{ Cue = "/VO/ZagreusHome_0607", RequiredTrueFlags = { "HardMode" }, },
		-- Wretches of the Underworld, take heed.
		{ Cue = "/VO/ZagreusHome_0609", RequiredTrueFlags = { "HardMode" }, },
		-- What's the worst that could happen?
		{ Cue = "/VO/ZagreusHome_0611", RequiredTrueFlags = { "HardMode" }, },
		-- What could go wrong.
		{ Cue = "/VO/ZagreusHome_0612", RequiredTrueFlags = { "HardMode" }, },
		-- This ought to be interesting.
		{ Cue = "/VO/ZagreusHome_0613", RequiredTrueFlags = { "HardMode" }, },
		-- Let's see what happens.
		{ Cue = "/VO/ZagreusHome_0594", RequiredTrueFlags = { "HardMode" }, },
	},
}

-- Market / Broker / Wretched Broker
GlobalVoiceLines.OpenedMarketVoiceLines =
{
	{
		SkipAnim = true,
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		RequiredCosmetics = { "Cosmetic_LoungeBrokerRug" },
		Cooldowns =
		{
			{ Name = "ZagreusBrokerInteractSpeech", Time = 200 },
		},

		-- Enjoying that new rug, there, Broker?
		-- { Cue = "/VO/ZagreusHome_2007" },
	},
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.5,
		PreLineWait = 0.6,
		Cooldowns =
		{
			{ Name = "ZagreusBrokerInteractSpeech", Time = 200 },
		},

		-- What's new?
		{ Cue = "/VO/ZagreusHome_0635", RequiredPlayed = { "/VO/ZagreusHome_1307" } },
		-- What's new.
		{ Cue = "/VO/ZagreusHome_0636", RequiredPlayed = { "/VO/ZagreusHome_1307" } },
		-- What's in stock?
		{ Cue = "/VO/ZagreusHome_0637", RequiredPlayed = { "/VO/ZagreusHome_1307" } },
		-- What's in stock.
		{ Cue = "/VO/ZagreusHome_0638", RequiredPlayed = { "/VO/ZagreusHome_1307" } },
		-- What's up for barter?
		{ Cue = "/VO/ZagreusHome_0639", RequiredPlayed = { "/VO/ZagreusHome_1307" } },
		-- What's for sale.
		{ Cue = "/VO/ZagreusHome_0640", RequiredPlayed = { "/VO/ZagreusHome_1307" } },
		-- Give me the best deal you've got.
		{ Cue = "/VO/ZagreusHome_0641", RequiredPlayed = { "/VO/ZagreusHome_1307" } },
		-- What's on the old exchange.
		{ Cue = "/VO/ZagreusHome_0642", RequiredPlayed = { "/VO/ZagreusHome_1307" } },
		-- Wretched Broker, what's new, my friend?
		{ Cue = "/VO/ZagreusHome_0643", RequiredPlayed = { "/VO/ZagreusHome_1307" } },
		-- This Broker sure reminds me of a guy who's killed me once or twice.
		{ Cue = "/VO/ZagreusHome_0644", RequiredPlayed = { "/VO/ZagreusHome_1307" }, RequiredLastKilledByUnits = { "PunchingBagUnit", "PunchingBagUnitElite" }, },
		-- Let's see here.
		{ Cue = "/VO/ZagreusHome_0645", RequiredPlayed = { "/VO/ZagreusHome_1307" } },
		-- Greetings, Broker.
		{ Cue = "/VO/ZagreusHome_1307" },
		-- Got anything good?
		{ Cue = "/VO/ZagreusHome_1308", RequiredPlayed = { "/VO/ZagreusHome_1307" } },
		-- I've come for questionable deals.
		{ Cue = "/VO/ZagreusHome_1309", RequiredPlayed = { "/VO/ZagreusHome_1307" } },
		-- Anything good?
		{ Cue = "/VO/ZagreusHome_1310", RequiredPlayed = { "/VO/ZagreusHome_1307" } },
	},
}
GlobalVoiceLines.MarketSoldOutVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	CooldownTime = 60,
	PreLineWait = 0.65,
	SkipAnim = true,

	-- Bought 'em all up.
	{ Cue = "/VO/ZagreusHome_0658" },
	-- Nothing left to trade for now.
	{ Cue = "/VO/ZagreusHome_0659" },
	-- I'll have to come back later.
	{ Cue = "/VO/ZagreusHome_0660" },
	-- Fresh out of stock for now.
	{ Cue = "/VO/ZagreusHome_0661" },
	-- Scooped up every offer.
	{ Cue = "/VO/ZagreusHome_0662" },
}
GlobalVoiceLines.PurchasedSpecialOfferVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.35,
		SuccessiveChanceToPlay = 0.66,
		Cooldowns =
		{
			{ Name = "ZagreusResourceInteractionSpeech", Time = 8 },
		},

		-- I'll take the Special, please.
		{ Cue = "/VO/ZagreusHome_1686" },
		-- That's too good a deal to pass up.
		{ Cue = "/VO/ZagreusHome_1687" },
		-- I'll take that deal.
		{ Cue = "/VO/ZagreusHome_1688" },
		-- Give me the current Special.
		{ Cue = "/VO/ZagreusHome_1689" },
		-- Good deal, here's the fee.
		{ Cue = "/VO/ZagreusHome_1690" },
	},
	[2] = GlobalVoiceLines.PurchasedMarketItemVoiceLines,
}
GlobalVoiceLines.PurchasedMarketItemVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.45,
	CooldownTime = 6,

	-- I'll take it!
	{ Cue = "/VO/ZagreusHome_0646" },
	-- Fair trade.
	{ Cue = "/VO/ZagreusHome_0647" },
	-- I'll take it.
	{ Cue = "/VO/ZagreusHome_0648" },
	-- I'll buy that.
	{ Cue = "/VO/ZagreusHome_0649" },
	-- I'll take that deal.
	{ Cue = "/VO/ZagreusHome_0650" },
	-- Seems like a good deal.
	{ Cue = "/VO/ZagreusHome_0651" },
	-- Sure, why not.
	{ Cue = "/VO/ZagreusHome_0652" },
	-- Think I'll take it.
	{ Cue = "/VO/ZagreusHome_0653" },
	-- Fair and square.
	{ Cue = "/VO/ZagreusHome_0654" },
	-- You trying to fleece me here?
	{ Cue = "/VO/ZagreusHome_0655" },
	-- It's a deal!
	{ Cue = "/VO/ZagreusHome_0656" },
	-- Here you go.
	{ Cue = "/VO/ZagreusHome_0657" },
	-- I could use that.
	{ Cue = "/VO/ZagreusHome_1311" },
	-- Need more of those, so here.
	{ Cue = "/VO/ZagreusHome_1312" },
	-- Just what I was looking for.
	{ Cue = "/VO/ZagreusHome_1313" },
	-- Too good to pass up.
	{ Cue = "/VO/ZagreusHome_1314" },
}

-- Ghost Admin / Cosmetics / House Contractor
GlobalVoiceLines.OpenedGhostAdminScreenVoiceLines =
{
	{
		SkipAnim = true,
		PlayOnce = true,
		BreakIfPlayed = true,
		CooldownTime = 200,
		PreLineWait = 0.4,
		RequiredFalseCosmeticPurchaseable = "OrpheusEurydiceQuestItem",
		RequiredTextLines = { "Inspect_DeathAreaOffice_SealedContract_02" },
		RequiredFalseCosmetics = { "OrpheusEurydiceQuestItem" },
		RequiredFalseTextLines = { "OrpheusAboutSingersReunionQuest01" },
		Cooldowns =
		{
			{ Name = "ZagreusGhostAdminScreenOpenedSpeech", Time = 200 },
		},

		-- It'll take some time for Orpheus' contract to show up.
		{ Cue = "/VO/ZagreusHome_2316"  },
	},
	{
		SkipAnim = true,
		PlayOnce = true,
		BreakIfPlayed = true,
		CooldownTime = 200,
		PreLineWait = 0.4,
		RequiredFalseCosmeticPurchaseable = "SisyphusQuestItem",
		RequiredTextLines = { "Inspect_DeathAreaOffice_SealedContract_01" },
		RequiredFalseCosmetics = { "SisyphusQuestItem" },
		RequiredFalseTextLines = { "SisyphusLiberationQuestComplete" },
		Cooldowns =
		{
			{ Name = "ZagreusGhostAdminScreenOpenedSpeech", Time = 200 },
		},

		-- Should check back later for the Sisyphus contract.
		{ Cue = "/VO/ZagreusHome_2314"  },
	},
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		CooldownTime = 200,
		PreLineWait = 0.4,
		Cooldowns =
		{
			{ Name = "ZagreusGhostAdminScreenOpenedSpeech", Time = 200 },
		},

		-- Some sort of special offer for me, my good Shade?
		{ Cue = "/VO/ZagreusHome_1525", PlayOnce = true, PreLineWait = 0.8, RequiredFalseCosmetics = { "TartarusReprieve" },  },
	},
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlayAll = 0.75,
		CooldownTime = 200,
		Cooldowns =
		{
			{ Name = "ZagreusGhostAdminScreenOpenedSpeech", Time = 200 },
		},

		-- Greetings, House Contractor.
		{ Cue = "/VO/ZagreusHome_1108" },
		-- Any new updates for the House?
		{ Cue = "/VO/ZagreusHome_1109" },
		-- What's on your mind, Contractor?
		{ Cue = "/VO/ZagreusHome_1110" },
		-- Let's see what the Contractor has.
		{ Cue = "/VO/ZagreusHome_1111" },
		-- What's new, Contractor?
		{ Cue = "/VO/ZagreusHome_1112" },
		-- Pick something up for the House maybe?
		{ Cue = "/VO/ZagreusHome_1113" },
		-- What can we do for this stodgy House.
		{ Cue = "/VO/ZagreusHome_1114" },
		-- Best give this shade some work.
		{ Cue = "/VO/ZagreusHome_1115" },
		-- What's new?
		{ Cue = "/VO/ZagreusHome_0635" },
		-- What's new.
		{ Cue = "/VO/ZagreusHome_0636" },
		-- Let's see here.
		{ Cue = "/VO/ZagreusHome_0645" },
		-- Let's see what we can do with this place.
		{ Cue = "/VO/ZagreusHome_0596" },
		-- Let's make some adjustments.
		{ Cue = "/VO/ZagreusHome_0599" },
	},
}
GlobalVoiceLines.GhostAdminSoldOutVoiceLines =
{
	--[[ @removed for now due to Ghost Admin screen tabbing
	BreakIfPlayed = true,
	RandomRemaining = true,
	PlayOnceFromTableThisRun = true,
	PreLineWait = 0.65,
	SkipAnim = true,

	-- No more jobs for now.
	{ Cue = "/VO/ZagreusHome_1123" },
	-- I'll have to come back later.
	{ Cue = "/VO/ZagreusHome_1124" },
	-- No more for now huh?
	{ Cue = "/VO/ZagreusHome_1125" },
	-- I'll have to come back later.
	{ Cue = "/VO/ZagreusHome_0660" },
	]]--
}
GlobalVoiceLines.GhostAdminCantAffordAnyVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PlayOnceFromTableThisRun = true,
	PreLineWait = 0.65,
	SkipAnim = true,
	SuccessiveChanceToPlay = 0.5,
	Cooldowns =
	{
		{ Name = "ZagreusGhostAdminScreenOpenedSpeech", Time = 200 },
	},

	-- Prices are a little steep there, I must say.
	{ Cue = "/VO/ZagreusHome_1285" },
	-- I can't afford any of this.
	{ Cue = "/VO/ZagreusHome_1286", SuccessiveChanceToPlay = 0.2 },
	-- What am I, composed entirely of gemstones?
	{ Cue = "/VO/ZagreusHome_1287" },
	-- Too pricey for me.
	{ Cue = "/VO/ZagreusHome_1288", SuccessiveChanceToPlay = 0.2 },
	-- Maybe you'll have something more affordable next time.
	{ Cue = "/VO/ZagreusHome_1289" },
	-- That's a lot of gemstones.
	{ Cue = "/VO/ZagreusHome_1290", SuccessiveChanceToPlay = 0.2 },
}
GlobalVoiceLines.PurchasedGhostAdminItemVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.35,

	-- Here's the fee.
	{ Cue = "/VO/ZagreusHome_1116" },
	-- Let's do it.
	{ Cue = "/VO/ZagreusHome_1117" },
	-- Let's go with this.
	{ Cue = "/VO/ZagreusHome_1118" },
	-- Here are the gems.
	{ Cue = "/VO/ZagreusHome_1119", RequiredLifetimeResourcesSpentMax = { Gems = 5000, SuperGiftPoints = 35, SuperLockKeys = 35 }, },
	-- Work approved.
	{ Cue = "/VO/ZagreusHome_1120" },
	-- Approved.
	{ Cue = "/VO/ZagreusHome_1121" },
	-- Here's the commission.
	{ Cue = "/VO/ZagreusHome_1122" },
	-- Here you go.
	{ Cue = "/VO/ZagreusHome_0657" },
	-- Contractor, work approved.
	{ Cue = "/VO/ZagreusHome_1699" },
	-- I think we'll go with this.
	{ Cue = "/VO/ZagreusHome_1700", Cooldowns =	{ { Name = "SaidThinkRecently", Time = 40 }, }, },
	-- Contractor, I've another job.
	{ Cue = "/VO/ZagreusHome_1701" },
	-- Let's go with this one, then.
	{ Cue = "/VO/ZagreusHome_1702" },
	-- This should be good I think.
	{ Cue = "/VO/ZagreusHome_1703", Cooldowns =	{ { Name = "SaidThinkRecently", Time = 40 }, }, },
	-- Well, I don't see why not.
	{ Cue = "/VO/ZagreusHome_1704" },
	-- No need to overthink this one I guess.
	{ Cue = "/VO/ZagreusHome_1705", Cooldowns =	{ { Name = "SaidThinkRecently", Time = 40 }, }, },
	-- How 'bout this, Contractor?
	{ Cue = "/VO/ZagreusHome_1706" },
}

-- Music Player
GlobalVoiceLines.OpenedMusicPlayerMenuVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.5,
		PreLineWait = 0.6,
		RequiresNewMusicTracks = true,
		Cooldowns =
		{
			{ Name = "OpenedMusicPlayerMenuSpeech", Time = 60 },
		},

		-- New piece there.
		{ Cue = "/VO/ZagreusHome_1156" },
		-- New piece of music.
		{ Cue = "/VO/ZagreusHome_1157" },
		-- New music.
		{ Cue = "/VO/ZagreusHome_1158" },
		-- Some new music.
		{ Cue = "/VO/ZagreusHome_1159" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.4,
		SuccessiveChanceToPlay = 0.5,
		ObjectType = "NPC_Orpheus_01",
		RequiredSourceValueFalse = "InPartnerConversation",
		Cooldowns =
		{
			{ Name = "OpenedMusicPlayerMenuSpeech", Time = 60 },
		},

		-- Perhaps a song would be in order at this time?
		{ Cue = "/VO/Orpheus_0034" },
		-- Would you be interested in one of my songs?
		{ Cue = "/VO/Orpheus_0035" },
		-- What might I do for you, my friend?
		{ Cue = "/VO/Orpheus_0036" },
		-- Is there a song which you would like to hear?
		{ Cue = "/VO/Orpheus_0037" },
		-- How about a little song, is that all right?
		{ Cue = "/VO/Orpheus_0038" },
		-- I am your humble court musician, Zagreus.
		{ Cue = "/VO/Orpheus_0039" },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.5,
		PreLineWait = 0.6,
		Cooldowns =
		{
			{ Name = "OpenedMusicPlayerMenuSpeech", Time = 60 },
		},

		-- What to listen to...
		{ Cue = "/VO/ZagreusHome_1152", RequiredPlayed = { "/VO/ZagreusHome_1154" } },
		-- Sweet music...
		{ Cue = "/VO/ZagreusHome_1153", RequiredPlayed = { "/VO/ZagreusHome_1154" } },
		-- The music stand...
		{ Cue = "/VO/ZagreusHome_1154", RequiredPlayed = { "/VO/ZagreusHome_1154" } },
		-- Chamber music...
		{ Cue = "/VO/ZagreusHome_1155" },
		-- Let's see here.
		{ Cue = "/VO/ZagreusHome_0645", RequiredPlayed = { "/VO/ZagreusHome_1154" } },
	}
}

GlobalVoiceLines.PlayedMusicTrackVoiceLines =
{
	{
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			CooldownTime = 45,
			SuccessiveChanceToPlay = 0.5,
			ObjectType = "NPC_Orpheus_01",
			RequiredSourceValueFalse = "InPartnerConversation",
			Cooldowns =
			{
				{ Name = "PlayedMusicTrackSpeech", Time = 30 },
			},

			-- OK I like that one.
			{ Cue = "/VO/Orpheus_0041" },
			-- Why certainly, of course.
			{ Cue = "/VO/Orpheus_0042" },
			-- Why, very well.
			{ Cue = "/VO/Orpheus_0043" },
			-- Good, let's begin, my friend!
			{ Cue = "/VO/Orpheus_0044" },
			-- All right I like that one!
			-- { Cue = "/VO/Orpheus_0045" },
			-- I thought you might say that.
			{ Cue = "/VO/Orpheus_0046" },
			-- Once more, then, I suppose?
			{ Cue = "/VO/Orpheus_0047" },
			-- You like that one, do you?
			{ Cue = "/VO/Orpheus_0048" },
			-- I'm happy to oblige you.
			{ Cue = "/VO/Orpheus_0049" },
			-- Why, I don't see why not!
			{ Cue = "/VO/Orpheus_0050" },
			-- A fine selection.
			{ Cue = "/VO/Orpheus_0170" },
			-- Fancy that one, do you?
			{ Cue = "/VO/Orpheus_0171" },
			-- Oh, that one.
			{ Cue = "/VO/Orpheus_0172" },
			-- That one, then.
			{ Cue = "/VO/Orpheus_0173" },
			-- Ah, yes.
			{ Cue = "/VO/Orpheus_0174" },
			-- Oh, indeed.
			{ Cue = "/VO/Orpheus_0175" },
			-- This makes me think of her.
			{ Cue = "/VO/Orpheus_0176" },
			-- If you insist, my friend.
			{ Cue = "/VO/Orpheus_0177", RequiredFalsePlayedThisRun = { "/VO/Orpheus_0177" }, RequiredFalsePlayedLastRun = { "/VO/Orpheus_0177" }, },
		},
		{
			SkipAnim = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.25,
			CooldownTime = 200,
			PreLineWait = 0.35,
			Cooldowns =
			{
				{ Name = "PlayedMusicTrackSpeech", Time = 30 },
			},
			-- This one.
			{ Cue = "/VO/ZagreusHome_1160" },
			-- This.
			{ Cue = "/VO/ZagreusHome_1161" },
			-- Let's listen.
			{ Cue = "/VO/ZagreusHome_1162" },
			-- Let's hear it.
			{ Cue = "/VO/ZagreusHome_1163" },
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.25,
		CooldownTime = 15,
		SuccessiveChanceToPlay = 0.25,
		ObjectType = "NPC_Hades_01",
		RequiredSourceValueFalse = "InPartnerConversation",
		Cooldowns =
		{
			{ Name = "HadesPlayedMusicTrackSpeech", Time = 30 },
		},

		-- I'm attempting to work here.
		{ Cue = "/VO/Hades_0537" },
		-- You turn that down this instant.
		{ Cue = "/VO/Hades_0538" },
		-- It is not music hour yet!
		{ Cue = "/VO/Hades_0539" },
		-- Keep it down.
		{ Cue = "/VO/Hades_0540" },
		-- Keep it down, I say.
		{ Cue = "/VO/Hades_0541" },
		-- ...A decent choice for once.
		{ Cue = "/VO/Hades_0542", RequiredPlayed = { "/VO/Hades_0537", "/VO/Hades_0538", "/VO/Hades_0539", "/VO/Hades_0540", "/VO/Hades_0541", "/VO/Hades_0542" } },
	},
}

GlobalVoiceLines.ClosedMusicPlayerVoiceLines =
{

}

GlobalVoiceLines.OpenedRunHistoryScreenVoiceLines =
{
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.66,
		Cooldowns =
		{
			{ Name = "ZagreusRunHistorySpeech", Time = 10 },
			{ Name = "ZagreusRunHistoryScreenOpenSpeech", Time = 60 },
		},

		-- Check my record here...
		{ Cue = "/VO/ZagreusHome_2352", RequiredScreenOpen = "GameStats" },
		-- Just a quick peek.
		{ Cue = "/VO/ZagreusHome_2353" },
		-- Just minding my own business.
		{ Cue = "/VO/ZagreusHome_2354" },
		-- How am I doing...
		{ Cue = "/VO/ZagreusHome_2355" },
		-- Let me see here.
		{ Cue = "/VO/ZagreusHome_2356" },
		-- Father keeping tabs.
		{ Cue = "/VO/ZagreusHome_2357" },
		-- Every one of my escape attempts...
		{ Cue = "/VO/ZagreusHome_2358", RequiredScreenOpen = "RunHistory" },
		-- How've I been doing.
		{ Cue = "/VO/ZagreusHome_2359" },
		-- Let's see how I'm doing.
		{ Cue = "/VO/ZagreusHome_2360" },
		-- Check my file here.
		{ Cue = "/VO/ZagreusHome_2361", RequiredScreenOpen = "GameStats" },
		-- All my escape attempts...
		{ Cue = "/VO/ZagreusHome_2413", RequiredScreenOpen = "RunHistory" },
		-- The Security Log...
		{ Cue = "/VO/ZagreusHome_2414", RequiredScreenOpen = "RunHistory" },
		-- What's the latest, Security Log?
		{ Cue = "/VO/ZagreusHome_2415", RequiredScreenOpen = "RunHistory" },
		-- We meet again, Security Log.
		{ Cue = "/VO/ZagreusHome_2416", RequiredScreenOpen = "RunHistory" },
		-- The Security Log keeping up?
		{ Cue = "/VO/ZagreusHome_2417", RequiredScreenOpen = "RunHistory" },
		-- There is no escape.
		{ Cue = "/VO/ZagreusHome_2418", RequiredScreenOpen = "RunHistory" },
		-- There is no escape...
		{ Cue = "/VO/ZagreusHome_2419", RequiredScreenOpen = "RunHistory" },
		-- Is there no escape?
		{ Cue = "/VO/ZagreusHome_2420", RequiredScreenOpen = "RunHistory" },
		-- What do they have on me.
		{ Cue = "/VO/ZagreusHome_2421" },
		-- Let's see what they have on me.
		{ Cue = "/VO/ZagreusHome_2422" },
		-- Let's check the numbers.
		{ Cue = "/VO/ZagreusHome_2423" },
		-- Let's see my rap sheet.
		{ Cue = "/VO/ZagreusHome_2424", RequiredScreenOpen = "GameStats" },
		-- Check the rap sheet...
		{ Cue = "/VO/ZagreusHome_2425", RequiredScreenOpen = "GameStats" },
		-- My permanent record.
		{ Cue = "/VO/ZagreusHome_2426", RequiredScreenOpen = "GameStats" },
		-- Take a quick look then.
		{ Cue = "/VO/ZagreusHome_2427" },
		-- Tracking my every move...
		{ Cue = "/VO/ZagreusHome_2428" },
		-- Let's see some numbers, then.
		{ Cue = "/VO/ZagreusHome_2429" },
	},
}

GlobalVoiceLines.PositiveRunHistoryScreenVoiceLines =
{
	SkipAnim = true,
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.65,
	ChanceToPlay = 0.15,
	Cooldowns =
	{
		{ Name = "ZagreusRunHistorySpeech", Time = 10 },
	},

	-- Good.
	{ Cue = "/VO/ZagreusHome_2376" },
	-- Mm-hm.
	{ Cue = "/VO/ZagreusHome_2377" },
	-- Hm.
	{ Cue = "/VO/ZagreusHome_2378" },
	-- Did it.
	{ Cue = "/VO/ZagreusHome_2379" },
	-- That's how it's done.
	{ Cue = "/VO/ZagreusHome_2380" },
	-- Made it that time.
	{ Cue = "/VO/ZagreusHome_2381" },
	-- Nice.
	-- { Cue = "/VO/ZagreusHome_2382" },
	-- Not bad.
	{ Cue = "/VO/ZagreusHome_2383" },
	-- Not too bad.
	{ Cue = "/VO/ZagreusHome_2384" },
	-- Made it out.
	{ Cue = "/VO/ZagreusHome_2385" },
	-- Fine work, Zagreus.
	{ Cue = "/VO/ZagreusHome_2386", ChanceToPlay = 0.02 },
	-- Good job, boy.
	{ Cue = "/VO/ZagreusHome_2387", ChanceToPlay = 0.02 },
	-- Simple.
	{ Cue = "/VO/ZagreusField_1128" },
	-- Easy.
	{ Cue = "/VO/ZagreusField_1129" },
	-- No problem.
	{ Cue = "/VO/ZagreusField_1130" },
	-- No problem!
	{ Cue = "/VO/ZagreusField_1131" },
	-- Short work.
	{ Cue = "/VO/ZagreusField_1137" },
}

GlobalVoiceLines.NegativeRunHistoryScreenVoiceLines =
{
	SkipAnim = true,
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.65,
	ChanceToPlay = 0.15,
	Cooldowns =
	{
		{ Name = "ZagreusRunHistorySpeech", Time = 10 },
	},

	-- Did not go well.
	{ Cue = "/VO/ZagreusHome_2362" },
	-- Oof, that one...
	{ Cue = "/VO/ZagreusHome_2363" },
	-- Oh, this one...
	{ Cue = "/VO/ZagreusHome_2364" },
	-- Ehh...
	{ Cue = "/VO/ZagreusHome_2365" },
	-- Think I remember this one.
	{ Cue = "/VO/ZagreusHome_2366" },
	-- What happened that time...
	{ Cue = "/VO/ZagreusHome_2367" },
	-- That was painful.
	{ Cue = "/VO/ZagreusHome_2368" },
	-- Not a good time.
	{ Cue = "/VO/ZagreusHome_2369" },
	-- Not my best.
	{ Cue = "/VO/ZagreusHome_2370" },
	-- Ouch...
	{ Cue = "/VO/ZagreusHome_2371" },
	-- Mmm....
	{ Cue = "/VO/ZagreusHome_2372" },
	-- Tsk...
	{ Cue = "/VO/ZagreusHome_2373" },
	-- Augh...
	{ Cue = "/VO/ZagreusHome_2374" },
	-- Yeah...
	{ Cue = "/VO/ZagreusHome_2375" },
	-- Ah, well...
	{ Cue = "/VO/ZagreusField_1141" },
	-- Eh...
	{ Cue = "/VO/ZagreusField_1142" },
	-- Not my best.
	{ Cue = "/VO/ZagreusField_1143" },
	-- Well moving on.
	{ Cue = "/VO/ZagreusField_1144" },
	-- Oof.
	{ Cue = "/VO/ZagreusField_1146" },
	-- Sloppy of me.
	{ Cue = "/VO/ZagreusField_1147" },
}

GlobalVoiceLines.ClosedRunHistoryScreenVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		SuccessiveChanceToPlayAll = 0.5,
		Cooldowns =
		{
			{ Name = "ZagreusRunHistorySpeech", Time = 10 },
			{ Name = "ZagreusRunHistoryScreenClosedSpeech", Time = 30 },
		},

		-- Till next time.
		{ Cue = "/VO/ZagreusHome_2438" },
		-- That's enough numbers.
		{ Cue = "/VO/ZagreusHome_2439" },
		-- Enough numbers for now.
		{ Cue = "/VO/ZagreusHome_2440" },
		-- Enough of that.
		{ Cue = "/VO/ZagreusHome_2441" },
		-- I'm good on numbers for now.
		{ Cue = "/VO/ZagreusHome_2442" },
		-- Well, back to it.
		{ Cue = "/VO/ZagreusHome_2443" },
		-- All right then.
		{ Cue = "/VO/ZagreusHome_2444" },
		-- Good info.
		{ Cue = "/VO/ZagreusHome_2445" },
		-- Good to know.
		{ Cue = "/VO/ZagreusHome_2446" },
		-- Enlightening!
		{ Cue = "/VO/ZagreusField_2812" },
		-- All right!
		{ Cue = "/VO/ZagreusField_2813" },
		-- OK?
		{ Cue = "/VO/ZagreusField_2952" },
		-- Huh.
		{ Cue = "/VO/ZagreusField_2957" },
		-- I've seen enough.
		{ Cue = "/VO/ZagreusHome_2430" },
		-- Enough snooping for now.
		{ Cue = "/VO/ZagreusHome_2431" },
		-- Informative.
		{ Cue = "/VO/ZagreusHome_2432" },
		-- Interesting.
		{ Cue = "/VO/ZagreusHome_2433" },
		-- Well, back to not looking at the Security Log.
		{ Cue = "/VO/ZagreusHome_2434", RequiredScreenOpen = "UseRunHistory" },
		-- Farewell, Security Log.
		{ Cue = "/VO/ZagreusHome_2435", RequiredScreenOpen = "UseRunHistory" },
		-- Well, back to not looking at my Permanent Record.
		{ Cue = "/VO/ZagreusHome_2436", RequiredScreenOpen = "GameStats" },
		-- Farewell, Permanent Record.
		{ Cue = "/VO/ZagreusHome_2437", RequiredScreenOpen = "GameStats" },
	},
}
GlobalVoiceLines.RunHistoryScreenBoonVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.6,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.33,
		PlayOnceFromTableThisRun = true,
		Cooldowns =
		{
			{ Name = "ZagreusRunHistorySpeech", Time = 8 },
		},

		-- Boons...
		{ Cue = "/VO/ZagreusHome_2447" },
		-- My Boons...
		{ Cue = "/VO/ZagreusHome_2448" },
		-- Boon records...
		{ Cue = "/VO/ZagreusHome_2449" },
		-- All my Boons...
		{ Cue = "/VO/ZagreusHome_2450" },
	},
}
GlobalVoiceLines.RunHistoryScreenWeaponVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.6,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.33,
		PlayOnceFromTableThisRun = true,
		Cooldowns =
		{
			{ Name = "ZagreusRunHistorySpeech", Time = 8 },
		},

		-- Infernal Arms...
		{ Cue = "/VO/ZagreusHome_2451" },
		-- My weapons...
		{ Cue = "/VO/ZagreusHome_2452" },
		-- Records of my weapons...
		{ Cue = "/VO/ZagreusHome_2453" },
		-- Weapon records...
		{ Cue = "/VO/ZagreusHome_2454" },
	},
}
GlobalVoiceLines.RunHistoryScreenHammerVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.6,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.33,
		PlayOnceFromTableThisRun = true,
		Cooldowns =
		{
			{ Name = "ZagreusRunHistorySpeech", Time = 8 },
		},

		-- Daedalus Hammer records...
		{ Cue = "/VO/ZagreusHome_2455" },
		-- My Hammer enchantments...
		{ Cue = "/VO/ZagreusHome_2456" },
		-- Daedalus Hammer enchantments...
		{ Cue = "/VO/ZagreusHome_2457" },
		-- Hammer records...
		{ Cue = "/VO/ZagreusHome_2458" },
	},
}
GlobalVoiceLines.RunHistoryScreenAspectVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.6,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.33,
		PlayOnceFromTableThisRun = true,
		Cooldowns =
		{
			{ Name = "ZagreusRunHistorySpeech", Time = 8 },
		},

		-- Aspects of my weapons...
		{ Cue = "/VO/ZagreusHome_2459" },
		-- My Aspect records...
		{ Cue = "/VO/ZagreusHome_2460" },
		-- Records of my Aspects...
		{ Cue = "/VO/ZagreusHome_2461" },
		-- My Weapon Aspects...
		{ Cue = "/VO/ZagreusHome_2462" },
	},
}
GlobalVoiceLines.RunHistoryScreenKeepsakeVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.6,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.33,
		PlayOnceFromTableThisRun = true,
		Cooldowns =
		{
			{ Name = "ZagreusRunHistorySpeech", Time = 8 },
		},

		-- Keepsake records...
		{ Cue = "/VO/ZagreusHome_2463" },
		-- Records of my Keepsakes...
		{ Cue = "/VO/ZagreusHome_2464" },
		-- All my Keepsakes....
		{ Cue = "/VO/ZagreusHome_2465" },
		-- My Keepsakes, huh...
		{ Cue = "/VO/ZagreusHome_2466" },
	},
}
GlobalVoiceLines.RunHistoryScreenEmptyVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.6,
		UsePlayerSource = true,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlayAll = 0.5,
		Cooldowns =
		{
			{ Name = "ZagreusRunHistorySpeech", Time = 4 },
		},

		-- Nothing here yet.
		{ Cue = "/VO/ZagreusHome_2467" },
		-- Nothing here.
		{ Cue = "/VO/ZagreusHome_2468" },
	},
}

GlobalVoiceLines.UsedHouseFountainVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.35,
	CooldownTime = 8,

	-- Ah, my incredibly expensive fountain.
	{ Cue = "/VO/ZagreusHome_1301" },
	-- This is the most decadent thing I've ever bought.
	{ Cue = "/VO/ZagreusHome_1302" },
	-- I won't ever grow weary of this!
	{ Cue = "/VO/ZagreusHome_1303" },
	-- I won't ever grow weary of this... will I?
	{ Cue = "/VO/ZagreusHome_1304" },
	-- Rather soothing really.
	{ Cue = "/VO/ZagreusHome_1305" },
	-- Hello, Fountain.
	{ Cue = "/VO/ZagreusHome_1306" },
}

BiomeList = { "Home", "Tartarus", "Asphodel", "Elysium", "Styx", "???" }

BiomeMapGraphics =
{
	Home =
	{
		Name = "Home",
		MapGraphic = "BiomeMapLocalePin",
		OffsetX = 0,
		OffsetY = -600,
		--PinOffsetX = -80,
		--PinOffsetY = 0,
		Index = 0
	},

	Tartarus =
	{
		Name = "Tartarus",
		MapGraphic = "BiomeMapLocalePin",
		TraversalGraphic = "BiomeMapTraversalAtoB",
		PreviousFillGraphic = "BiomeMapFill_Tartarus_Previous",
		FillGraphic = "BiomeMapFill_Asphodel",
		OffsetX = 0,
		OffsetY = -360,
		--PinOffsetX = 500,
		--PinOffsetY = 400,
		--PinStartOffsetX = -25,
		--PinStartOffsetY = 25,
		--PinMoveDuration = 0.8,
		PactRewardOffsetX = -100,
		PactRewardOffsetY = 250,
		TraversalOffsetX = 65,
		TraversalOffsetY = -305,
		PactRewardRoomName = "A_Boss",
		Index = 1,
		BiomePanDurationIncrease = 1.2,
	},

	Asphodel =
	{
		Name = "Asphodel",
		MapGraphic = "BiomeMapLocalePin",
		TraversalGraphic = "BiomeMapTraversalBtoC",
		PreviousFillGraphic = "BiomeMapFill_Asphodel_Previous",
		FillGraphic = "BiomeMapFill_Elysium",
		OffsetX = 0,
		OffsetY = 200,
		--PinOffsetX = 0,
		--PinOffsetY = 0,
		--PinStartOffsetX = -210,
		--PinStartOffsetY = -461,
		--PinMoveDuration = 3.5,
		PactRewardOffsetX = 350,
		PactRewardOffsetY = 150,
		TraversalOffsetX = -62,
		TraversalOffsetY = -560,
		PactRewardRoomName = "B_Boss01",
		Index = 2,
		BiomePanDurationIncrease = 2.1,
	},

	Elysium =
	{
		Name = "Elysium",
		MapGraphic = "BiomeMapLocalePin",
		TraversalGraphic = "BiomeMapTraversalCtoD",
		PreviousFillGraphic = "BiomeMapFill_Elysium_Previous",
		FillGraphic = "BiomeMapFill_Styx",
		OffsetX = 0,
		OffsetY = 1190,
		--PinOffsetX = -250,
		--PinOffsetY = 40,
		--PinStartOffsetX = -490,
		--PinStartOffsetY = -170,
		--PinMoveDuration = 3.5,
		PactRewardOffsetX = -300,
		PactRewardOffsetY = 200,
		TraversalOffsetX = 40,
		TraversalOffsetY = -215,
		PactRewardRoomName = "C_Boss01",
		Index = 3,
		BiomePanDurationIncrease = 2.3,
	},

	Styx =
	{
		Name = "Styx",
		MapGraphic = "BiomeMapLocalePin",
		TraversalGraphic = "BiomeMapTraversalDtoE",
		PreviousFillGraphic = "BiomeMapFill_Elysium_Previous",
		FillGraphic = "BiomeMapFill_Styx",
		OffsetX = 0,
		OffsetY = 1675,
		--PinOffsetX = 0,
		--PinOffsetY = 0,
		--PinStartOffsetX = 0,
		--PinStartOffsetY = 0,
		--PinMoveDuration = 3.5,
		PactRewardOffsetX = 200,
		PactRewardOffsetY = 400,
		TraversalOffsetX = 0,
		TraversalOffsetY = 0,
		PactRewardRoomName = "D_Boss01",
		Index = 4,
		BiomePanDurationIncrease = 0,
	},
}

GameData.EmployeeOfTheMonthOptions =
{
	Thanatos =
	{
		Animation = "HouseEmployeeOfMonthThanatos01",
		-- Requirements
		-- RequiredTextLines = { "ThanatosFirstAppearance" },
		RequiredFalseTextLinesLastRun = { "ThanatosWithHades01", "ThanatosWithHades02", "ThanatosWithHades03" },
	},
	Megaera =
	{
		Animation = "HouseEmployeeOfMonthMegaera01",
		RequiredFalseTextLinesLastRun = { "MegaeraWithHades01", "MegaeraWithHades02", "MegaeraWithHades03" },
		RequiredFalseKillsThisRun = { "Harpy" },
	},
	Cerberus =
	{
		Animation = "HouseEmployeeOfMonthCerberus01",
		RequiredSeenRooms = { "D_Hub" },
	},

	Achilles =
	{
		Animation = "HouseEmployeeOfMonthAchilles01",
		RequiredFalseTextLinesLastRun = { "PersephoneMeeting08", "PersephoneMeeting09" },
	},
	Orpheus =
	{
		Animation = "HouseEmployeeOfMonthOrpheus01",
		RequiredAnyTextLines = { "OrpheusSingsAgain01", "OrpheusSingsAgain01_B", "OrpheusSingsAgain01_C", "OrpheusSingsAgain01_D", "OrpheusSingsAgain03" },
	},
	HouseContractor =
	{
		Animation = "HouseEmployeeOfMonthContractor01",
		RequiredLifetimeResourcesSpentMin = { Gems = 250, SuperGems = 1 },
		RequiredNumCosmeticsMin = 10,
	},
	WretchedBroker =
	{
		Animation = "HouseEmployeeOfMonthBroker01",
		RequiredLifetimeResourcesSpentMin = { LockKeys = 10, GiftPoints = 5 },
	},
	HeadChef =
	{
		Animation = "HouseEmployeeOfMonthChef01",
		RequiredMinTotalCaughtFish = 10,
	},
	Dusa =
	{
		Animation = "HouseEmployeeOfMonthDusa01",
		RequiredTextLines = { "BecameCloseWithDusaAftermath01", "DusaAboutWorkLifeBalance01" },
	},
	Hypnos =
	{
		Animation = "HouseEmployeeOfMonthHypnos01",
		RequiredTextLines = { "ThanatosWithHypnos07" },
	},
	Zagreus =
	{
		Animation = "HouseEmployeeOfMonthZag01",
		RequiredTextLines = { "OlympianReunionQuestComplete" },
		-- RequiredMinShrinePointThresholdClear = 5,
	},

}

GameData.FlashbackRequirements =
{
	-- Flashback 1 Requirements
	[1] = {
		RequiredFalseTextLines = { "Flashback_Mother_01" },
		RequiredAccumulatedMetaPoints = 150,
		RequiredMinCompletedRuns = 5,
	},
	-- Flashback 2 Requirements
	[2] = {
		RequiredMinCompletedRuns = 26,
		RequiredTextLines = { "Flashback_Mother_01" },
		RequiredFalseTextLines = { "Flashback_DayNightJob_01" },
		RequiredFalseTextLinesThisRun = { "PersephoneFirstMeeting", "PersephoneMeeting07", "PersephoneMeeting08", "Ending01", "OlympianReunionQuestComplete" },
	},
}