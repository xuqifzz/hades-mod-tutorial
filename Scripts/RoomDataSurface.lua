RoomSetData.Surface =
{
	BaseSurface =
	{
		UnthreadedEvents = {},
		LegalEncounters = { "Surface" },
		RichPresence = "#RichPresence_Surface",

		FadeOutAnimation = "RoomTransitionInBlack",
		EntranceFunctionName = "RoomEntranceSurface",
		LocationText = "Location_Surface",
		LocationTextShort = "Location_Surface",
		DisableWeaponsExceptDash = true,
		HideCombatUI = true,
		HideEncounterText = true,
		HideLowHealthShroud = true,
		BlockDoorHealFromPrevious = true,
		HideGoldGainFx = true,
		BlockTraitSetup = true,
		FlipHorizontalChance = 0.0,
		NumExits = 1,
		
		BlockHeroLight = true,

		FishingPointChance = 0.2,
		FishingPointRequirements =
		{
			RequiredCosmetics = { "FishingUnlockItem" },
			RequiredMinRoomsSinceFishingPoint = 2,

			RequiredTextLines = { "PersephoneFirstMeeting" },
		},
		SwapAnimations =
		{
			["DashCrack"] = "DashCrackSnow",
			["FireFootstepL-Spawner"] = "SnowFootstepL-Spawner",
			["FireFootstepR-Spawner"] = "SnowFootstepR-Spawner",
			["FishingPoint"] = "FishingPoint_NoShadow",
			["FishingPointActive"] = "FishingPointActive_NoShadow",
		},		

		Binks =
		{
			"ZagreusWalk2_Bink",
			"ZagreusWalkStop2_Bink",
			"ZagreusInjured_IdleToSick_Bink",
			"ZagreusInjured_SickStandingSet_Bink",
			"ZagreusInjured_SickKneelingSet_Bink",
		},
	},

	E_Intro =
	{
		InheritFrom = { "BaseSurface" },
		EntranceFunctionName = "RoomEntranceE_Intro",
		IntroZoomFraction = 0.78,
		ZoomFraction = 0.78,

		IntroSequenceDuration = 4.5,

		LinkedRoom = "E_Story01",

		Music = "/Music/PersephoneTheme_MC",
		MusicActiveStems = { "Room", "Strings", "WoodWinds", "Harp", "Trombones", "Percussion" },
		-- MusicMutedStems = { "Room", "Strings", "Percussion" },
		MusicSection = 1,

		Ambience = "/Leftovers/Ambience/ShoreAmbienceGentleWind",

		ObstacleData =
		{
			[552607] =
			{
				OnUsedFunctionName = "LeaveRoomWithNoDoor",
				OnUsedFunctionArgs = { NextMap = "E_Story01", ObjectId = 552607 },
				InteractDistance = 175,
				AutoActivate = true,
			},

		},

		StartUnthreadedEvents =
		{
			{ FunctionName = "RemoveDashBoons" },
			{ FunctionName = "RoomStartAlphaChanges", Args = { Ids = { 556917, 556918, 556914, 556925, 556905, 556921, 556912, 556910, 556908, 556909, 556911, 556515, 556284, 556760, 556119 }, Fraction = 0.0 } },
		},

		DistanceTriggers =
		{
			-- Overlook
			{
				TriggerGroup = "OverlookOut", WithinDistance = 150, FunctionName = "SunriseOverlook", Repeat = true,
				Args =
				{
					SunriseStartDelay = 1.0,
					PanTargetId = 552630,
					ZoomFraction = 0.6 ,
					Duration = 8.0,
					ObstacleChanges =
					{
						-- Terrain light casts
						{
							ObstacleIds = { 556484, 556460, 556372, 556373, 556374, 556375, 556376, 556378, 556379, 556380, 556415, 556456, 556458, 556459, 556471, 556817, 556819, },
							ChangeColor = { 74, 0, 0, 255 },
							
						},
						-- Terrain cast shadows
						{
							ObstacleIds = { 556358, 556354, 556355, 556356, 556357, 556359, 556360, 556361, 556363, 556364, 556365, 556366, 556367, 556368, 556369, 556370, 556416, 556454, 556455, 556469, 556470, 556485, 556486, },
							ChangeColor = { 76, 79, 36, 255 },
							
						},
						-- Shadow
						{
							ObstacleIds = { 555798, 556464, 556465, 556466, 556467, 556468, 556148, 556149, 556150, 556151, 556310, 556311, 556312, 556322, 556323, 556401, 556402, 556461, 556462, 556633, 556634, 556635, },
							ChangeColor = { 148, 153, 96, 255 },
							
						},
						-- Ocean shadow
						{
							ObstacleIds = { 556545, 557014, 557015, 557016, 557017, 557018, 557019, 557020, 557021, 557022, 557023, 557024, 557025, },
							ChangeColor = { 77, 72, 125, 255 },
							
						},
						-- Ocean shadow 2
						{
							ObstacleIds = { 556548, 556519, 556544, 556947 },
							ChangeColor = { 70, 67, 102, 255 },
							
						},
						-- Ocean light reflection
						{
							ObstacleIds = { 556552, 556549, 556551, 556550, 556953 },
							ChangeColor = { 255, 164, 74, 255 },
							
						},
						-- Clouds
						{
							ObstacleIds = { 556524, 556283, 556523, 556957, 556958, 556960 },
							ChangeColor = { 116, 121, 153, 255 },
							ChangeHSV = { 11, -38, 100 },
						},
						-- Moon
						--[[
						{
							ObstacleIds = { 556284, },
							Movement = { Angle = 45, Distance = 1600 },
							Duration = 12
						},
						]]
						-- Sun
						{
							ObstacleIds = { 556517, },
							Movement = { Angle = 65, Distance = 300 },
						},
						-- Sun Light
						{
							ObstacleIds = { 556460, 556591 },
							ChangeColor = { 168, 40, 40, 150 },
							
						},
						-- Sun Highrise glow
						{
							ObstacleIds = { 556512, 556513, },
							ChangeColor = { 255, 125, 102, 180 },
							
						},
						-- Sun Highrise Overlay
						{
							ObstacleIds = { 556636 },
							ChangeColor = { 255, 125, 102, 170 },
							
						},
						-- Sky
						{
							ObstacleIds = { 556118, },
							Movement = { Angle = 90, Distance = 700 },
						},
						-- Ocean
						{
							ObstacleIds = { 556117 },
							ChangeColor = { 168, 76, 76, 255 },
							ChangeHSV = { 149, -31, 100 },
						},
						-- Ocean Highrise glow shadow
						{
							ObstacleIds = { 556580, 556581, 556582, 556592, 556927 },
							ChangeColor = { 9, 54, 97, 255 }
							
						},
						-- Background fade out
						{
							ObstacleIds = { 556629, 556628, 556913, 556624, 556754, 556755, 556756, 556757, 556631, 556904, 556630, },
							ChangeAlpha = 0.0,
						},
						-- Background fade in
						{
							ObstacleIds = { 556917, 556918, 556914, 556925, 556905, 556921, 556912, 556910, 556908, 556909, 556911 },
							ChangeAlpha = 1.0,
						},
						{
							ObstacleIds = { 556119 },
							ChangeAlpha = 1.0,
							Duration = 4,
							Delay = 4,
						},
					},
				},
			},
			{
				TriggerGroup = "OverlookIn", WithinDistance = 150, FunctionName = "SunriseOverlookBackToRoom", Repeat = true,
			},
			{
				Name = "Bloom", TriggerId = 555889, WithinDistance = 600, Repeat = false,
				VoiceLines = 
				{
					PlayOnce = true,
					UsePlayerSource = true,
					RequiredMinElapsedTime = 3,
					BreakIfPlayed = true,
					-- <Cough> Ungh...
					{ Cue = "/VO/ZagreusField_4672" },
					-- <Cough> Ugh, I... cold...
					{ Cue = "/VO/ZagreusField_4671", PreLineWait = 2 },
				}
			},
		},

		EnterVoiceLines =
		{
			{
				-- BreakIfPlayed = true,
				-- RandomRemaining = true,
				PlayOnce = true,
				PlayOnceContext = "AboutToMeetPersephone",
				PreLineWait = 4.65,

				-- I made it...
				{ Cue = "/VO/ZagreusField_3588", SuccessiveChanceToPlay = 0.2 },
				-- Beyond the frozen overlook... await the first glimpse of the sun to your left... then onward through the cold.
				{ Cue = "/VO/ZagreusField_3589", PreLineWait = 2.0, SuccessiveChanceToPlay = 0.2 },
				-- Sure hope this works, Nyx.
				{ Cue = "/VO/ZagreusField_3590", PreLineWait = 1.5, BreakIfPlayed = true },
			},
			{
				PreLineWait = 2.1,
				BreakIfPlayed = true,
				PlayOnce = true,
				RequiredTextLines = { "PersephoneFirstMeeting" },
				RequiredFalseTextLines = { "PersephoneMeeting07" },

				-- Beyond the frozen overlook... await the first glimpse of the sun to your left... then onward through the cold.
				{ Cue = "/VO/ZagreusField_3591", RequiredTextLines = { "PersephoneMeeting02" }, },
				-- Beyond the frozen overlook... await the first glimpse of the sun to your left... then onward through the cold.
				{ Cue = "/VO/ZagreusField_3589", RequiredTextLines = { "PersephoneMeeting03" }, },
				-- Beyond the frozen overlook... and all that.
				{ Cue = "/VO/ZagreusField_4700", RequiredTextLines = { "PersephoneMeeting04" }, },
				-- Just up ahead...
				{ Cue = "/VO/ZagreusField_4699", RequiredTextLines = { "PersephoneMeeting06" }, },
				-- Oof, it's cold...
				{ Cue = "/VO/ZagreusField_4701", RequiredTextLines = { "PersephoneMeeting07" }, },
				-- Just a bit farther...
				{ Cue = "/VO/ZagreusField_4702", RequiredTextLines = { "PersephoneMeeting08" }, },
				-- Almost there...
				{ Cue = "/VO/ZagreusField_4703", RequiredTextLines = { "PersephoneMeeting09" }, },
			},
		},

		InspectPoints =
		{
			[554421] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					Inspect_E_Intro_01_01 =
					{
						EndVoiceLines =
						{
							PreLineWait = 0.8,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							-- It's... beautiful.
							{ Cue = "/VO/ZagreusField_4322" },
						},
						{ Cue = "/VO/Storyteller_0374",
							Text = "{#DialogueItalicFormat}The surface, wind-swept, wracked by freezing cold, nonetheless instills within the prince a sense of awe, and the sublime. For it is unlike anything that he has seen." },
					},
				},
			},
		},

	},

	E_Story01 =
	{
		InheritFrom = { "BaseSurface" },
		LegalEncounters = { "Story_Persephone_01" },

		IntroZoomFraction = 0.9,
		ZoomFraction = 0.9,
		MusicSection = 2,

		Ambience = "/Leftovers/Ambience/FarmAmbience",

		RunOverrides =
		{
			DeathPresentationFunctionName = "SurfaceDeathPresentation",
		},
		ExitFunctionName = "SurfaceToBoatRideExit",

		EnterVoiceLines =
		{
			{
				BreakIfPlayed = true,
				PreLineWait = 2.65,
				SuccessiveChanceToPlayAll = 0.5,
				RequiredFalseTextLines = { "PersephoneMeeting07" },

				-- Is this... it can't...
				{ Cue = "/VO/ZagreusField_3596", PlayOnce = true, PreLineWait = 4.5 },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 2.65,
				SuccessiveChanceToPlayAll = 0.25,
				RequiredFalseTextLines = { "PersephoneMeeting07" },

				-- <Gasp>
				{ Cue = "/VO/ZagreusField_3597" },
				-- I'm here...
				{ Cue = "/VO/ZagreusField_3598", RequiredPlayed = { "/VO/ZagreusField_3597" }, },
				-- Warmer, finally...
				{ Cue = "/VO/ZagreusField_3599", RequiredPlayed = { "/VO/ZagreusField_3597" }, PlayOnce = true },
			},
		},

		DistanceTriggers =
		{
			{
				Name = "Bloom", TriggerId = 560952, WithinDistance = 600, FunctionName = "CottageBloom", Repeat = false,
			},
		},

		InspectPoints =
		{
			[560881] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				RequiredTextLines = { "PersephoneFirstMeeting" },
				InteractTextLineSets =
				{
					Inspect_E_Intro_01_01 =
					{
						EndVoiceLines =
						{
							PreLineWait = 0.6,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							-- What are these things...
							{ Cue = "/VO/ZagreusField_4323" },
						},
						{ Cue = "/VO/Storyteller_0375",
							Text = "{#DialogueItalicFormat}All manner of fruits and vegetables thrive within the hidden gardens of Persephone, the one-time Queen of all the Underworld. A world of life, far from the realm of death." },
					},
				},
			},
		},

		Binks = 
		{
			"NPC_PersephoneGardenDismiss_Bink",
			"NPC_PersephoneGardenGreeting_Bink",
			"NPC_PersephoneGardenIdleHip_Bink",
			"NPC_PersephoneGardenVulnerable_Bink",
			"NPC_PersephoneGardenWalk_Bink",
			"NPC_PersephoneGardenWalkStop_Bink"
		}
	},
}

OverwriteTableKeys( RoomData, RoomSetData.Surface )