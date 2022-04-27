GlobalVoiceLines = GlobalVoiceLines or {}
GlobalVoiceLines.UsedFountainVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		RequiredMinHealthFraction = 1.0,
		SuccessiveChanceToPlay = 0.66,
		RequiredFalseRooms = { "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },

		-- To my health! Although I'm full.
		{ Cue = "/VO/ZagreusField_1819", },
		-- Too bad I can't bottle this stuff.
		{ Cue = "/VO/ZagreusField_1820", },
		-- No getting out without a drink.
		{ Cue = "/VO/ZagreusField_1821", },
		-- I'm healthy as can be, but cheers!
		{ Cue = "/VO/ZagreusField_1822", },
		-- Who makes door locks connected to a fountain?
		{ Cue = "/VO/ZagreusField_1823", },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.75,
		RequiredFalseRooms = { "A_PostBoss01", "B_PostBoss01", "C_PostBoss01" },

		-- That's better.
		{ Cue = "/VO/ZagreusField_0133", },
		-- Hmm.
		{ Cue = "/VO/ZagreusField_0134", },
		-- Good.
		{ Cue = "/VO/ZagreusField_0135", CooldownName = "SaidGoodRecently", CooldownTime = 40, },
		-- That's a relief.
		{ Cue = "/VO/ZagreusField_0299", },
		-- Much better.
		{ Cue = "/VO/ZagreusField_0300", },
		-- There we go.
		{ Cue = "/VO/ZagreusField_0301", },
		-- Mmph.
		{ Cue = "/VO/ZagreusField_0302", },
		-- Whew...
		{ Cue = "/VO/ZagreusField_0303", CooldownName = "SaidWhewRecently", CooldownTime = 30 },
		-- Mmm.
		{ Cue = "/VO/ZagreusField_0370", },
		-- Hit the spot.
		{ Cue = "/VO/ZagreusField_0372", },
		-- Ahh.
		{ Cue = "/VO/ZagreusField_4500", },
		-- Refreshing!
		{ Cue = "/VO/ZagreusField_4501", },
		-- Crisp.
		{ Cue = "/VO/ZagreusField_4502", },
		-- Nice and cool.
		{ Cue = "/VO/ZagreusField_4503", },
		-- That's good.
		{ Cue = "/VO/ZagreusField_4504", },
		-- Whew.
		{ Cue = "/VO/ZagreusField_4505", CooldownName = "SaidWhewRecently", CooldownTime = 30 },
	}
}

ObstacleData =
{
	BaseDestructible =
	{
		HideHealthBar = true,
		SkipDamageText = true,
		SkipModifiers = true,
		BlockWrathGain = true,
		BlockLifeSteal = true,
		NoComboPoints = true,
	},
	ExitDoor =
	{
		IsDefaultDoor = true,

		UseText = "UseExitDoorWhileLocked",
		UnlockedAnimation = "DoorExitLight",
		UnlockedUseText = "UseLeaveRoom",
		UnlockedUseTextReroll = "UseLeaveRoom_Reroll",
		UnlockedUseTextCannotReroll = "UseLeaveSpecialRoom_CannotReroll",
		RerollFunctionName = "AttemptRerollDoor",
		AllowReroll = true,

		LockedUseSound = "/Leftovers/World Sounds/Caravan Interior/ChestClose",
		UnlockedUseSound = "/Leftovers/World Sounds/PostBossLeaveSFX",

		AddToGroup = "ExitDoors",

		ExitBlockedVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.25,
			CooldownTime = 6,

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
			-- Stuck!
			{ Cue = "/VO/ZagreusField_0247", RequiredKillEnemiesFound = true, },
			-- No use!
			{ Cue = "/VO/ZagreusField_0248", RequiredKillEnemiesFound = true, },
			-- It's no use!
			{ Cue = "/VO/ZagreusField_0249", RequiredKillEnemiesFound = true, },
		},
	},

	TartarusDoor03b =
	{
		InheritFrom = { "ExitDoor", },

		UsePromptOffsetX = 20,
		UsePromptOffsetY = -30,
		ExitThroughCenter = true,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		MetaRewardAnimation = "DoorLocked_MetaReward",
		UnlockedAnimation = "DoorUnlocked",
		UnlockedAnimationMetaReward = "DoorUnlocked_MetaReward",
		ExitDoorOpenAnimation = "DoorOpen",
		ExitDoorCloseAnimation = "DoorClose",

		-- intentionally blank, on the anim
		UnlockedUseSound = "",
	},

	AsphodelBoat01b =
	{
		InheritFrom = { "ExitDoor", },

		UnlockedUseText = "UseLeaveRoomAsphodel",
		UnlockedUseTextReroll = "UseLeaveRoomAsphodel_Reroll",
		UnlockedUseTextCannotReroll = "UseLeaveRoomAsphodel_CannotReroll",
		RerollFunctionName = "AttemptRerollDoor",
		UnlockedAnimation = "AsphodelBoatSunkUnlocked",
		ExitDoorOpenAnimation = "AsphodelBoatSunk",
		AllowReroll = true,

		RewardPreviewOffsetZ = 410,

		LockedUseSound = "/Leftovers/SFX/OutOfAmmo",
		UnlockedUseSound = "/SFX/WeaponUnlock",

		ExitFunctionName = "AsphodelLeaveRoomPresentation",
	},

	ElysiumExitDoor =
	{
		InheritFrom = { "ExitDoor", },

		ExitThroughCenter = true,
		RewardPreviewOffsetZ = 0,
		RewardPreviewOffsetY = -360,
		RewardPreviewOffsetX = 0,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		MetaRewardAnimation = "ElysiumDoorLocked_MetaReward",
		UnlockedAnimation = "ElysiumDoorUnlocked",
		ExitDoorOpenAnimation = "ElysiumDoorOpen",
		ExitDoorCloseAnimation = "ElysiumDoorClose",

		-- intentionally blank, on the anim
		UnlockedUseSound = "",
	},

	StyxDoor01 =
	{
		InheritFrom = { "ExitDoor", },

		ExitThroughCenter = true,
		RewardPreviewOffsetZ = 642,
		RewardPreviewOffsetY = 0,
		RewardPreviewOffsetX = 0,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		--MetaRewardAnimation = "ElysiumDoorLocked_MetaReward",
		UnlockedAnimation = "StyxDoorUnlocked",
		ExitDoorOpenAnimation = "StyxDoorOpen",
		ExitDoorCloseAnimation = "StyxDoorClose",

		-- intentionally blank, on the anim
		UnlockedUseSound = "",
	},

	-- Styx: Doors to Wings from D_Hub
	TravelDoor03 =
	{
		InheritFrom = { "ExitDoor", },

		ExitThroughCenter = true,
		RewardPreviewOffsetZ = 0,
		RewardPreviewOffsetY = -1050,
		RewardPreviewOffsetX = 0,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		LockedUseText = "UseExitDoorWhileLocked",
		UnlockedAnimation = "TravelDoor03Unlocked",
		UnlockedSound = "/EmptyCue",
		ExitDoorOpenAnimation = "TravelDoor03Open",
		ExitDoorCloseAnimation = "TravelDoor03Close",

		ExitVoiceLines =
		{
			PreLineWait = 0.25,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.33,

			-- Let's see what's in here.
			{ Cue = "/VO/ZagreusField_2054" },
			-- This one I guess.
			{ Cue = "/VO/ZagreusField_2268" },
			-- Here goes.
			{ Cue = "/VO/ZagreusField_2269" },
			-- Maybe it's in here.
			{ Cue = "/VO/ZagreusField_2270", RequiredFalseSeenRoomThisRun = "D_Reprieve01", RequiredMinDoorsClosedInRoom = 1, RequiredFalsePrevRooms = { "D_Intro" } },
			-- Should check this way.
			{ Cue = "/VO/ZagreusField_2271" },
			-- I bet it's in here.
			{ Cue = "/VO/ZagreusField_2272", RequiredFalseSeenRoomThisRun = "D_Reprieve01", RequiredMinDoorsClosedInRoom = 1, RequiredFalsePrevRooms = { "D_Intro" } },
			-- Try this way.
			{ Cue = "/VO/ZagreusField_2273" },
			-- Maybe this way.
			{ Cue = "/VO/ZagreusField_2274" },
		},

		ExitBlockedVoiceLines =
		{
			PreLineWait = 0.35,
			RandomRemaining = true,
			BreakIfPlayed = true,
			Cooldowns =
			{
				--{ Name = "ZagreusAnyQuipSpeech", Time = CurrentRun.Hero.VoiceLineBufferTime },
				{ Name = "ZagreusAnyQuipSpeech", Time = 9 },
			},
			-- Shut.
			{ Cue = "/VO/ZagreusField_2322" },
			-- It's shut.
			{ Cue = "/VO/ZagreusField_2323" },
			-- Locked.
			{ Cue = "/VO/ZagreusField_2324" },
			-- It's locked.
			{ Cue = "/VO/ZagreusField_2325" },
			-- Cleared it out.
			{ Cue = "/VO/ZagreusField_2326" },
			-- Nothing else back there.
			{ Cue = "/VO/ZagreusField_2327" },
			-- Done with that.
			{ Cue = "/VO/ZagreusField_2328" },
			-- Done back there.
			{ Cue = "/VO/ZagreusField_2329" },
		},

		-- intentionally blank, on the anim
		UnlockedUseSound = "",
	},

	-- Styx: Warps from D_Combat rooms back to D_Hub
	StyxWarpDoor =
	{
		InheritFrom = { "ExitDoor", },
		HideRewardPreview = true,

		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		-- UseSound = "/Leftovers/SFX/NomadSprint",
		UnlockedUseText = "UseStyxWarpDoor",
		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/Leftovers/SFX/NomadSprint",

		ExitFunctionName = "ExitSecretRoomPresentation",

		ExitDoorOpenAnimation = "StyxWarpDoor_Revealed",
		ExitDoorCloseAnimation = "StyxWarpDoor_Revealed",
		UnlockedAnimation = "StyxWarpDoor_Revealed",
		UnlockedSound = "/Leftovers/Menu Sounds/TitanToggleShort",

		ExitVoiceLines =
		{
			PreLineWait = 0.35,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.33,

			-- Hope this can get me out of here.
			{ Cue = "/VO/ZagreusField_2282", SuccessiveChanceToPlay = 0.02 },
			-- Should be able to get back through here.
			{ Cue = "/VO/ZagreusField_2283", RequiredPlayed = { "/VO/ZagreusField_2282" } },
			-- Let's just go down this Satyr hole.
			{ Cue = "/VO/ZagreusField_2284", RequiredPlayed = { "/VO/ZagreusField_2282" } },
			-- Back I go.
			{ Cue = "/VO/ZagreusField_2285", RequiredPlayed = { "/VO/ZagreusField_2282" } },
			-- Enough of this place.
			{ Cue = "/VO/ZagreusField_2286", RequiredPlayed = { "/VO/ZagreusField_2282" } },
			-- Going back.
			{ Cue = "/VO/ZagreusField_2287", RequiredPlayed = { "/VO/ZagreusField_2282" } },
			-- Heading back.
			{ Cue = "/VO/ZagreusField_2288", RequiredPlayed = { "/VO/ZagreusField_2282" } },
			-- Had quite enough here, thanks.
			{ Cue = "/VO/ZagreusField_2289", RequiredPlayed = { "/VO/ZagreusField_2282" } },
			-- Down the chute.
			{ Cue = "/VO/ZagreusField_2290", RequiredPlayed = { "/VO/ZagreusField_2282" } },
		},

	},

	-- Styx: Exit from Underworld / Exit to D_Boss01
	TravelDoor01 =
	{
		InheritFrom = { "ExitDoor", },

		-- ExitThroughCenter = true,
		UnlockedAnimation = "TravelDoor01Unlocked",
		UnlockedUseText = "UseCerberusDoor",
		UnlockedUseTextCannotReroll = "UseCerberusDoor",
		UnlockedUseSound = "/EmptyCue",
		HideRewardPreview = true,

		AvailableRequirements =
		{
			RequiredRoomThisRun = "D_Reprieve01",
			RequiredAnyTextLines = { "CerberusBossDoorUnlock", "CerberusBossDoorUnlockRepeatable01", "CerberusBossDoorUnlockRepeatable02", "CerberusBossDoorUnlockRepeatable03", "CerberusBossDoorUnlockRepeatable04", "CerberusBossDoorUnlockRepeatable05", "CerberusBossDoorUnlockRepeatable06", "CerberusBossDoorUnlockRepeatable07" },
		},
		ForceRoomName = "D_Boss01",

		ExitFunctionName = "ExitToHadesPresentation",
		ExitDoorOpenAnimation = "HubBossDoorOpen",

		OnUsedVoiceLines =
		{
			{
				PreLineWait = 0.35,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.33,

				-- I did it...
				{ Cue = "/VO/ZagreusField_2086" },
				-- I made it...
				{ Cue = "/VO/ZagreusField_2087", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- Made it.
				{ Cue = "/VO/ZagreusField_2088", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- Now...
				{ Cue = "/VO/ZagreusField_2089", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- Bye.
				{ Cue = "/VO/ZagreusField_2090", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- Heading out.
				{ Cue = "/VO/ZagreusField_2091", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- Be right with you, Father.
				{ Cue = "/VO/ZagreusField_3546", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- Get you for last time, Father.
				{ Cue = "/VO/ZagreusField_3547", RequiredPlayed = { "/VO/ZagreusField_2086" }, ConsecutiveDeathsInRoom = { Name = "D_Boss01", Count = 1, }, RequiredRoomLastRun = "D_Boss01" },
				-- Made it again.
				{ Cue = "/VO/ZagreusField_3548", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- Time to go.
				{ Cue = "/VO/ZagreusField_3549", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- Cold out there.
				{ Cue = "/VO/ZagreusField_3550", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- I'm leaving, Father. Try and stop me.
				{ Cue = "/VO/ZagreusField_3551", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- To hell with this place.
				{ Cue = "/VO/ZagreusField_3552", RequiredPlayed = { "/VO/ZagreusField_2086" }, RequiredFalseTextLines = { "PersephoneMeeting07" }, },
				-- I'll find you, Mother.
				{ Cue = "/VO/ZagreusField_3553", RequiredPlayed = { "/VO/ZagreusField_2086" }, RequiredFalseTextLines = { "Ending01" }, },
				-- I'm out.
				{ Cue = "/VO/ZagreusField_4196", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- I'm out of here.
				{ Cue = "/VO/ZagreusField_4197", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- Here goes.
				{ Cue = "/VO/ZagreusField_4198", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- All right, Father.
				{ Cue = "/VO/ZagreusField_4199", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- Into the cold.
				{ Cue = "/VO/ZagreusField_4200", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- I can do this.
				{ Cue = "/VO/ZagreusField_4201", RequiredPlayed = { "/VO/ZagreusField_2086" } },
				-- Have to do this.
				{ Cue = "/VO/ZagreusField_4202", RequiredPlayed = { "/VO/ZagreusField_2086" }, RequiredFalseTextLines = { "Ending01" }, },
				-- Got this far.
				{ Cue = "/VO/ZagreusField_4203", RequiredPlayed = { "/VO/ZagreusField_2086" } },
			},
		},
	},

	-- Styx: Exit from D_Boss01 to end
	FinalBossExitDoor =
	{
		InheritFrom = { "ExitDoor", },
		HideRewardPreview = true,
		AllowReroll = false,

		UnlockedUseText = "UseFinalBossDoor",
		UnlockedUseTextCannotReroll = "UseFinalBossDoor",

		LockedUseSound = "/Leftovers/SFX/OutOfAmmo",
		UnlockedUseSound = "/Leftovers/Menu Sounds/EmoteThoughtful",

		UnlockedAnimation = "FinalBossExitDoorLinesUnlocked",
		ExitDoorOpenAnimation = "FinalBossExitDoorLinesOpen",
		ExitDoorCloseAnimation = "FinalBossExitDoorLinesUsed",
	},

	HouseOfficeDoor =
	{
		UseText = "UseLeaveRoom",

		UsePromptOffsetX = 20,
		UsePromptOffsetY = -30,

		ExitDoorOpenAnimation = "HouseDoor01a_Open",
		ExitDoorCloseAnimation = "HouseDoor01a_Close",

		ExitPath = { 427356 },
		OnUsedFunctionName = "DeathAreaSwitchRoom",
		OnUsedFunctionArgs = { Name = "DeathAreaOffice" },

		OnUsedGameStateRequirements =
		{
			RequiredFalseFlags = { "ZagSpecialEventInProgress", },
		},
		Name = "OfficeDoor",
		OnUsedGlobalVoiceLines = "ThanatosEnteredOfficeVoiceLines",
		DistanceTriggers =
		{
			{
				WithinDistance = 800,
				Repeat = true,
				VoiceLines =
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					CooldownTime = 8,
					PlayOnceFromTableThisRun = true,
					RequiredTextLines = { "NyxAboutSingersReunionQuest01" },
					RequiredFalseTextLines = { "Inspect_DeathAreaOffice_SealedContract_02" },
					UsePlayerSource = true,
					SuccessiveChanceToPlay = 0.33,

					-- Should check the admin chamber just in case.
					-- { Cue = "/VO/ZagreusHome_2086" },
					-- Should have a look in the administrative chamber there.
					{ Cue = "/VO/ZagreusHome_2087" },
					-- Thinking I ought to check the old administrative chamber now.
					{ Cue = "/VO/ZagreusHome_2088" },
					-- I ought to check the old administrative chamber there.
					-- { Cue = "/VO/ZagreusHome_2089" },
				},
			},
			{
				WithinDistance = 800,
				Repeat = true,
				VoiceLines =
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					CooldownTime = 8,
					PlayOnceFromTableThisRun = true,
					RequiredTextLines = { "NyxAboutSisyphusLiberationQuest01" },
					RequiredFalseTextLines = { "Inspect_DeathAreaOffice_SealedContract_01" },
					UsePlayerSource = true,
					SuccessiveChanceToPlay = 0.33,

					-- Should check the admin chamber just in case.
					{ Cue = "/VO/ZagreusHome_2086" },
					-- Should have a look in the administrative chamber there.
					-- { Cue = "/VO/ZagreusHome_2087" },
					-- Thinking I ought to check the old administrative chamber now.
					-- { Cue = "/VO/ZagreusHome_2088" },
					-- I ought to check the old administrative chamber there.
					{ Cue = "/VO/ZagreusHome_2089" },
				},
			},
			{
				WithinDistance = 800,
				Repeat = true,
				VoiceLines =
				{
					BreakIfPlayed = true,
					CooldownTime = 8,
					PlayOnceFromTableThisRun = true,
					RequiredTextLines = { "NyxAboutMyrmidonReunionQuest01" },
					RequiredFalseTextLines = { "Inspect_DeathAreaOffice_SealedContract_03" },
					UsePlayerSource = true,
					SuccessiveChanceToPlay = 0.33,

					-- Should check the admin chamber just in case.
					-- { Cue = "/VO/ZagreusHome_2086" },
					-- Should have a look in the administrative chamber there.
					-- { Cue = "/VO/ZagreusHome_2087" },
					-- Thinking I ought to check the old administrative chamber now.
					{ Cue = "/VO/ZagreusHome_2088" },
					-- I ought to check the old administrative chamber there.
					{ Cue = "/VO/ZagreusHome_2089" },
				},
			},
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
	},

	HouseOfficeDoorLocked =
	{
		UseText = "UseLockedDoor",
		UseSound = "/Leftovers/World Sounds/CaravanJostle2",
		ShakeSelf = true,
		InteractDistance = 190,
		InteractOffsetX = 60,
		InteractOffsetY = 30,
		OnUsedGlobalVoiceLines = "LockedOfficeDoorVoiceLines",
	},

	HouseHadesDoor =
	{
		UseText = "UseLeaveRoom",

		InteractDistance = 190,
		UsePromptOffsetX = 20,
		UsePromptOffsetY = -30,

		ExitDoorOpenAnimation = "HouseDoor03_Open",
		ExitDoorCloseAnimation = "HouseDoor03_Close",

		ExitPath = { 555683 },
		OnUsedFunctionName = "DeathAreaSwitchRoom",
		OnUsedFunctionArgs = { Name = "DeathAreaBedroomHades" },

		ActivateGameStateRequirements =
		{
			RequiredTextLines = { "Ending01" },
		},
	},

	HouseHadesDoorLocked =
	{
		ActivateGameStateRequirements =
		{
			RequiredFalseTextLines = { "Ending01" },
		},

		UseText = "UseLockedDoor",
		UseSound = "/Leftovers/World Sounds/CaravanJostle2",
		ShakeSelf = true,
		InteractDistance = 190,
		InteractOffsetX = 60,
		InteractOffsetY = 30,
		OnUsedGlobalVoiceLines = "LockedHadesBedroomDoorVoiceLines",
	},

	TartarusCubeBrick03 =
	{
		Material = "StoneObstacle",
		OnHitShake = { Distance = 3, Speed = 100, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "TartarusCubeBrick03a",
			RequiredHitsForImpactReaction = 3,
			DisableOnHitShake = true
		},
	},

	TartarusCubeBrick05 =
	{
		Material = "StoneObstacle",
	},

	TartarusPillarBase09 =
	{
		Material = "StoneObstacle",
	},

	TartarusFencePicket02 =
	{
		Material = "StoneObstacle",
	},

	TartarusWallBrick13 =
	{
		Material = "StoneObstacle",
	},
	TartarusWallBrick10 =
	{
		Material = "StoneObstacle",
	},

	HousePillar01 =
	{
		Material = "StoneObstacle",
	},

	ElysiumBush01 =
	{
		Material = "BushObstacle",
		OnHitShake = { Distance = 3, Speed = 100, Duration = 0.15 },
	},

	ElysiumBush02 =
	{
		Material = "BushObstacle",
		OnHitShake = { Distance = 3, Speed = 100, Duration = 0.15 },
	},

	ElysiumPlanter01 =
	{
		Material = "StoneObstacle",
	},

	ElysiumPlanter02 =
	{
		Material = "StoneObstacle",
	},

	WeaponShop =
	{
		UseText = "UseStore",

		OverheadTextFontSize = 20,
		OverheadTextOffset = -110,
		OverheadTextColor = Color.Gold,
	},

	GiftRack =
	{
		UseText = "UseAwardMenu",
		UsePromptOffsetX = 65,
		UsePromptOffsetY = -50,
	},

	MetaUpgradeScreen =
	{
		UseText = "UseMetaUpgradeScreen",
	},

	HealthFountain =
	{
		UseText = "UseFountainHeal",
		UseSound = "/Leftovers/Menu Sounds/AscensionConfirm",
		BlockExitUntilUsed = true,
		BlockExitText = "ExitBlockedByReprieve",
		HealingSpentAnimation = "HealthFountainEmpty",
		HealFraction = 0.20,
		RefreshExtractValuesOnApproach = true,
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealthFountain",
			},
		},
		OnUsedVoiceLines =
		{
			[1] = GlobalVoiceLines.UsedFountainVoiceLines,
		},
	},

	HealthFountainAsphodel =
	{
		UseText = "UseFountainHeal",
		UseSound = "/Leftovers/Menu Sounds/AscensionConfirm",
		BlockExitUntilUsed = true,
		BlockExitText = "ExitBlockedByReprieve",
		HealingSpentAnimation = "HealthFountainEmptyAsphodel",
		HealFraction = 0.20,
		RefreshExtractValuesOnApproach = true,
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealthFountain",
			},
		},
		OnUsedVoiceLines =
		{
			[1] = GlobalVoiceLines.UsedFountainVoiceLines,
		},
	},

	HealthFountainElysium =
	{
		UseText = "UseFountainHeal",
		UseSound = "/Leftovers/Menu Sounds/AscensionConfirm",
		BlockExitUntilUsed = true,
		BlockExitText = "ExitBlockedByReprieve",
		HealingSpentAnimation = "HealthFountainEmptyElysium",
		HealFraction = 0.40,
		RefreshExtractValuesOnApproach = true,
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealthFountain",
			},
		},
		OnUsedVoiceLines =
		{
			[1] = GlobalVoiceLines.UsedFountainVoiceLines,
		},
	},

	HealthFountainStyx =
	{
		UseText = "UseFountainHeal",
		UseSound = "/SFX/Menu Sounds/PortraitEmoteDepressedDrink",
		OnUsedFunctionName = "StyxFountainPresentation",
		BlockExitUntilUsed = true,
		BlockExitText = "ExitBlockedByReprieve",
		HealingSpentAnimation = "HealthFountainEmptyStyx",
		HealFraction = 0.20,
		RefreshExtractValuesOnApproach = true,
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealthFountain",
			},
		},
		OnUsedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.45,
			RequiredBiome = "Styx",
			Cooldowns =
			{
				{ Name = "ZagreusAnyQuipSpeech" },
			},

			-- ...Yum...!
			{ Cue = "/VO/ZagreusField_2443", },
			-- ...Goes down smooth.
			{ Cue = "/VO/ZagreusField_2444", },
			-- ...Acquired taste.
			{ Cue = "/VO/ZagreusField_2445", },
			-- ...Refreshing...!
			{ Cue = "/VO/ZagreusField_2446", },
			-- ...OK I'm good.
			{ Cue = "/VO/ZagreusField_2447", },
			-- ...Much better.
			{ Cue = "/VO/ZagreusField_2448", },
			-- ...Mmph, whew.
			{ Cue = "/VO/ZagreusField_2449", },
			-- ...What's in this stuff?
			{ Cue = "/VO/ZagreusField_2450", },
			-- ...<Cough> Whew...
			{ Cue = "/VO/ZagreusField_2451", },
			-- ...That's something.
			{ Cue = "/VO/ZagreusField_2452", },
			-- ...Bit of an aftertaste.
			{ Cue = "/VO/ZagreusField_2453", },
		}
	},

	PoisonCureFountainStyx =
	{
		UseText = "UsePoisonCure",
		UseSound = "/SFX/PoisonCureFountainDrink",
		CooldownNamePrefix = "PoisonCureFountain",
		CooldownDuration = 3.0,
		OnCooldownAnimation = "PoisonCureFountainEmpty",
		IdleAnimation = "PoisonCureFountainFull",
		OnUsedFunctionName = "UseStyxFountain",

		OnUsedVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "ZagreusAnyQuipSpeech" },
				{ Name = "ZagCuredPoisonSpeech", Time = 15 }
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.45,
				RequiredHasEffect = "StyxPoison",
				SuccessiveChanceToPlay = 0.5,

				-- Whew.
				{ Cue = "/VO/ZagreusField_2131", },
				-- Better.
				{ Cue = "/VO/ZagreusField_2132", },
				-- There.
				{ Cue = "/VO/ZagreusField_2133", },
				-- Cured.
				{ Cue = "/VO/ZagreusField_2134", },
				-- Good.
				{ Cue = "/VO/ZagreusField_2135", },
				-- OK.
				{ Cue = "/VO/ZagreusField_2136", },
				-- Mmm.
				{ Cue = "/VO/ZagreusField_2137", },
				-- Clean.
				{ Cue = "/VO/ZagreusField_2138", },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.45,
				RequiredFalseHasEffect = "StyxPoison",
				RequiredKillEnemiesFound = true,

				-- No effect.
				{ Cue = "/VO/ZagreusField_2139", RequiredPlayed = { "/VO/ZagreusField_2143" }, },
				-- Nothing.
				{ Cue = "/VO/ZagreusField_2140", RequiredPlayed = { "/VO/ZagreusField_2143" }, },
				-- No need.
				{ Cue = "/VO/ZagreusField_2141", RequiredPlayed = { "/VO/ZagreusField_2143" }, },
				-- Don't need a cure.
				{ Cue = "/VO/ZagreusField_2142", RequiredPlayed = { "/VO/ZagreusField_2143" }, },
				-- A poison cure.
				{ Cue = "/VO/ZagreusField_2143" },
				-- Curing water.
				{ Cue = "/VO/ZagreusField_2144", RequiredPlayed = { "/VO/ZagreusField_2143" }, },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.45,
				CooldownTime = 15,
				RequiredFalseHasEffect = "StyxPoison",
				RequiredKillEnemiesNotFound = true,

				-- Not bad.
				{ Cue = "/VO/ZagreusField_2436", RequiredPlayed = { "/VO/ZagreusField_2437"}, },
				-- Not poisoned at the moment, thanks.
				{ Cue = "/VO/ZagreusField_2437" },
				-- Doesn't taste like anything.
				{ Cue = "/VO/ZagreusField_2438", RequiredPlayed = { "/VO/ZagreusField_2437"}, },
				-- What is this stuff.
				{ Cue = "/VO/ZagreusField_2439", RequiredPlayed = { "/VO/ZagreusField_2437"}, },
				-- Tasty.
				{ Cue = "/VO/ZagreusField_2440", RequiredPlayed = { "/VO/ZagreusField_2437"}, },
				-- Tasty. Sort of.
				{ Cue = "/VO/ZagreusField_2441", RequiredPlayed = { "/VO/ZagreusField_2437"}, },
				-- No thanks.
				{ Cue = "/VO/ZagreusField_2442", RequiredPlayed = { "/VO/ZagreusField_2437"}, },
			},
		},
	},

	CerberusKey =
	{
		UseSound = "/Leftovers/World Sounds/Unmask",
		ConsumeSound = "/SFX/Enemy Sounds/RatThug/PoisonShake",

		OnUsedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,

			-- Disgusting. Cerberus will love it!
			{ Cue = "/VO/ZagreusField_2107" },
			-- Something for Cerberus.
			{ Cue = "/VO/ZagreusField_2108", RequiredPlayed = { "/VO/ZagreusField_2107" } },
			-- Eugh, what is this stuff?
			{ Cue = "/VO/ZagreusField_2109", RequiredPlayed = { "/VO/ZagreusField_2107" } },
			-- Now back to Cerberus.
			{ Cue = "/VO/ZagreusField_2110", RequiredPlayed = { "/VO/ZagreusField_2107" } },
			-- A Satyr sack for my boy Cerberus.
			{ Cue = "/VO/ZagreusField_2111", RequiredPlayed = { "/VO/ZagreusField_2107" }, CooldownName = "SaidSatyrSackRecently", CooldownTime = 30, },
			-- Cerberus just loves... whatever this stuff is.
			{ Cue = "/VO/ZagreusField_2112", RequiredPlayed = { "/VO/ZagreusField_2107" } },
			-- A whole entire sack of something!
			{ Cue = "/VO/ZagreusField_2113", RequiredPlayed = { "/VO/ZagreusField_2107" } },
			-- A sack fit for a huge three-headed hound.
			{ Cue = "/VO/ZagreusField_2114", RequiredPlayed = { "/VO/ZagreusField_2107" } },
			-- A special treat for Cerberus.
			{ Cue = "/VO/ZagreusField_2115", RequiredPlayed = { "/VO/ZagreusField_2107" } },
			-- Ah good, it's still fresh!
			{ Cue = "/VO/ZagreusField_2116", RequiredPlayed = { "/VO/ZagreusField_2107" } },
			-- Just what I need, a foul sack!
			{ Cue = "/VO/ZagreusField_2117", RequiredPlayed = { "/VO/ZagreusField_2107" }, CooldownName = "SaidSatyrSackRecently", CooldownTime = 30, },
			-- Just the foul sack I need.
			{ Cue = "/VO/ZagreusField_2118", RequiredPlayed = { "/VO/ZagreusField_2107" } },
			-- Cerberus can never get enough of this stuff.
			{ Cue = "/VO/ZagreusField_2119", RequiredPlayed = { "/VO/ZagreusField_2107" } },
			-- I'll just tuck that away.
			{ Cue = "/VO/ZagreusField_2120", RequiredPlayed = { "/VO/ZagreusField_2107" } },
		},
	},

	BaseEmotes =
	{
		Emotes =
		{
			Smile =
			{
				AnimationName = "StatusIconSmile",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
			Fear =
			{
				AnimationName = "StatusIconFear",
				SoundName = "/SFX/GhostEmotes/Fear"
			},
			Disgruntled =
			{
				AnimationName = "StatusIconDisgruntled",
				SoundName = "/SFX/GhostEmotes/Disgruntled"
			},
			Embarrassed =
			{
				AnimationName = "StatusIconEmbarrassed",
				SoundName = "/SFX/GhostEmotes/Embarrassed"
			},
			Grief =
			{
				AnimationName = "StatusIconGrief",
				SoundName = "/SFX/GhostEmotes/Grief"
			},
			OhBoy =
			{
				AnimationName = "StatusIconOhBoy",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
		},
	},

	TinyEmotes =
	{
		Emotes =
		{
			Smile =
			{
				AnimationName = "StatusIconSmile",
				SoundName = "/SFX/GhostEmotes/SmileTINY"
			},
			Fear =
			{
				AnimationName = "StatusIconFear",
				SoundName = "/SFX/GhostEmotes/FearTINY"
			},
			Disgruntled =
			{
				AnimationName = "StatusIconDisgruntled",
				SoundName = "/SFX/GhostEmotes/DisgruntledTINY"
			},
			Embarrassed =
			{
				AnimationName = "StatusIconEmbarrassed",
				SoundName = "/SFX/GhostEmotes/EmbarrassedTINY"
			},
			Grief =
			{
				AnimationName = "StatusIconGrief",
				SoundName = "/SFX/GhostEmotes/GriefTINY"
			},
			OhBoy =
			{
				AnimationName = "StatusIconOhBoy",
				SoundName = "/SFX/GhostEmotes/SmileTINY"
			},
		},
	},

	SmallEmotes =
	{
		Emotes =
		{
			Smile =
			{
				AnimationName = "StatusIconSmile",
				SoundName = "/SFX/GhostEmotes/SmileSMALL"
			},
			Fear =
			{
				AnimationName = "StatusIconFear",
				SoundName = "/SFX/GhostEmotes/FearSMALL"
			},
			Disgruntled =
			{
				AnimationName = "StatusIconDisgruntled",
				SoundName = "/SFX/GhostEmotes/DisgruntledSMALL"
			},
			Embarrassed =
			{
				AnimationName = "StatusIconEmbarrassed",
				SoundName = "/SFX/GhostEmotes/EmbarrassedSMALL"
			},
			Grief =
			{
				AnimationName = "StatusIconGrief",
				SoundName = "/SFX/GhostEmotes/GriefSMALL"
			},
			OhBoy =
			{
				AnimationName = "StatusIconOhBoy",
				SoundName = "/SFX/GhostEmotes/SmileSMALL"
			},
		},
	},

	LargeEmotes =
	{
		Emotes =
		{
			Smile =
			{
				AnimationName = "StatusIconSmile",
				SoundName = "/SFX/GhostEmotes/SmileLARGE"
			},
			Fear =
			{
				AnimationName = "StatusIconFear",
				SoundName = "/SFX/GhostEmotes/FearLARGE"
			},
			Disgruntled =
			{
				AnimationName = "StatusIconDisgruntled",
				SoundName = "/SFX/GhostEmotes/DisgruntledLARGE"
			},
			Embarrassed =
			{
				AnimationName = "StatusIconEmbarrassed",
				SoundName = "/SFX/GhostEmotes/EmbarrassedLARGE"
			},
			Grief =
			{
				AnimationName = "StatusIconGrief",
				SoundName = "/SFX/GhostEmotes/GriefLARGE"
			},
			OhBoy =
			{
				AnimationName = "StatusIconOhBoy",
				SoundName = "/SFX/GhostEmotes/SmileLARGE"
			},
		},
	},

	BaseGhost =
	{
		InheritFrom = { "BaseDestructible", "BaseEmotes" },
		OnKillGlobalVoiceLines = "ShadeKilledVoiceLines",
		KillsRequiredForVoiceLines = 10,
		EmoteReactionOnCollide = true,
	},

	TartarusGhost01 =
	{
		InheritFrom = { "BaseGhost" },

		MaxHealth = 1,

		AlphaMin = 0.5,
		AlphaMax = 1.0,
	},

	BigGhost01 =
	{
		InheritFrom = { "BaseGhost", "LargeEmotes" },
		AlphaMin = 0.5,
		AlphaMax = 1.0,
	},

	MediumGhost01 =
	{
		InheritFrom = { "BaseGhost", "LargeEmotes" },
		AlphaMin = 0.5,
		AlphaMax = 1.0,
	},

	BartenderGhost01 =
	{
		InheritFrom = { "BaseGhost" },
	},

	BrokerGhost01 =
	{
		InheritFrom = { "BaseGhost" },
	},

	BadgeSellerGhost01 =
	{
		InheritFrom = { "BaseGhost" },
	},

	ChefGhost01 =
	{
		InheritFrom = { "BaseGhost" },
		InteractDistance = 220,
		InteractOffsetX = -30,
		InteractOffsetY = -90,
	},

	SmallGhost01 =
	{
		InheritFrom = { "BaseGhost", "TinyEmotes" },
		AlphaMin = 0.5,
		AlphaMax = 1.0,
	},

	TallGhost01 =
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
		AlphaMin = 0.5,
		AlphaMax = 1.0,
		EmoteOffsetZ = 90,
	},

	AdminGhost01 =
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
		EmoteOffsetZ = 120,
	},

	AsphodelGhost01 =
	{
		InheritFrom = { "BaseGhost" },
	},

	ElysiumGhost01 =
	{
		InheritFrom = { "BaseGhost" },
	},

	GhostInspectPoint =
	{
		UseText = "UseGhostInspectPoint",
	},

	TartarusPillarBase04 =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "TartarusPillarBase04A-Fx",
			RequiredHitsForImpactReaction = 1,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "TartarusPillarBase04A",
		},
	},

	TartarusPillarBase04A =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "TartarusPillarBase04B-Fx",
			RequiredHitsForImpactReaction = 2,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 2,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "TartarusPillarBase04B",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
		},
	},

	TartarusPillarBase04B =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "TartarusPillarBase04C-Fx",
			RequiredHitsForImpactReaction = 3,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 4,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 3000,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "TartarusPillarBase04C",
			CausesOcclusion = false,
		},
	},

	TartarusPillarBase04C =
	{
		Material = "Stone",

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = false,
			},
			{
				ThingProperty = "DrawVfxOnTop",
				ChangeValue = true,
			},
		},
	},

	TartarusHalfPillarBase04 =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "Tilesets\\Tartarus\\Tartarus_HalfPillarBase_04A",
			RequiredHitsForImpactReaction = 3,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "TartarusHalfPillarBase04A",
		},
	},

	TartarusHalfPillarBase04A =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "Tilesets\\Tartarus\\Tartarus_HalfPillarBase_04B",
			RequiredHitsForImpactReaction = 5,
			SpawnAmount = 2,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "TartarusHalfPillarBase04B",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
		},
	},

	TartarusHalfPillarBase04B =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "Tilesets\\Tartarus\\Tartarus_HalfPillarBase_04C",
			RequiredHitsForImpactReaction = 7,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 4,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 3000,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "TartarusHalfPillarBase04C",
		},
	},

	TartarusHalfPillarBase04C =
	{
		Material = "Stone",

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = false,
			},
			{
				ThingProperty = "DrawVfxOnTop",
				ChangeValue = true,
			},
		},
	},

	ElysiumRubble04 =
	{
		MaxHealth = 1,
		InheritFrom = { "BaseDestructible" },

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		OnTouchdown =
		{
			Weapon = "RubbleFallElysium",
			DestroyOnDelay = 0.02,
		},
	},

	TartarusRubble02 =
	{
		MaxHealth = 1,
		InheritFrom = { "BaseDestructible" },
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		OnTouchdown =
		{
			Weapon = "RubbleFall",
			CrushTypes = { "TartarusCandles01", "TartarusCandles01b", },
		},

		AmmoDropOnDeath =
		{
			Chance = 0.20,
			MinAmmo = 1,
			MaxAmmo = 1,
		},
	},

	TartarusRubble02b =
	{
		InheritFrom = { "TartarusRubble02", },
	},

	TartarusRubble02c =
	{
		InheritFrom = { "TartarusRubble02", },
	},

	TartarusWallBrick03 =
	{
		RandomSwaps = { "TartarusWallPillar01", "TartarusWallMural01"},
	},

	TartarusRubble05 =
	{
		MaxHealth = 10,
		InheritFrom = { "BaseDestructible" },
	},

	TartarusRubble06 =
	{
		MaxHealth = 10,
		InheritFrom = { "BaseDestructible" },
	},

	-- Bouldy
	TartarusRubble03 =
	{
		-- OnHitFunctionName = "BouldyHitPresentation",
	},

	AsphodelRock02 =
	{
		MaxHealth = 75,
		InheritFrom = { "BaseDestructible" },
	},

	AsphodelBoulder01 =
	{
		MaxHealth = 150,
		InheritFrom = { "BaseDestructible" },
	},

	AsphodelPillar06 =
	{
		Material = "Stone",

		OnTouchdown =
		{
			Weapon = "RubbleFall",
		},

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "AsphodelPillar06A",
			RequiredHitsForImpactReaction = 1,
			SpawnRandomObstacle = {"AsphodelTerrainRock01", "AsphodelTerrainRock02", "AsphodelTerrainRock03"},
			ForceSpawnToValidLocation = true,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.10,
			SpawnScaleMax = 0.15,
			SwapData = "AsphodelPillar06A",
		},
	},

	AsphodelPillar06A =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "AsphodelPillar06B",
			RequiredHitsForImpactReaction = 4,
			SpawnRandomObstacle = {"AsphodelTerrainRock01", "AsphodelTerrainRock02", "AsphodelTerrainRock03"},
			ForceSpawnToValidLocation = true,
			SpawnAmount = 2,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SpawnScaleMin = 0.10,
			SpawnScaleMax = 0.15,
			SwapData = "AsphodelPillar06B",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
			CausesOcclusion = false,
		},
	},

	AsphodelPillar06B =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "AsphodelPillar06C",
			RequiredHitsForImpactReaction = 5,
			SpawnObstacle = "AsphodelSkull",
			ForceSpawnToValidLocation = true,
			SpawnAmount = 1,
			SpawnOffsetXMin = 0,
			SpawnOffsetXMax = 0,
			SpawnOffsetYMin = -100,
			SpawnOffsetYMax = -100,
			SpawnOffsetZ = 2000,
			ShakeScreenSpeed = 100,
			ShakeScreenDistance = 5,
			ShakeScreenFalloffSpeed = 1000,
			ShakeScreenDuration = 0.5,
			FallForce = 8000,
			SpawnScaleMin = 1.0,
			SpawnScaleMax = 1.0,
			SwapData = "AsphodelPillar06C",
			CausesOcclusion = false,
		},
	},

	AsphodelPillar06C =
	{
		Material = "Stone",

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = false,
			},
			{
				ThingProperty = "DrawVfxOnTop",
				ChangeValue = true,
			},
		},
	},

	AsphodelBricksquare02 =
	{
		Material = "StoneObstacle",
	},

	AsphodelPillar08 =
	{
		Material = "StoneObstacle",
	},

	AsphodelWallRock05 =
	{
		Material = "StoneObstacle",
	},

	AsphodelWallRock04 =
	{
		Material = "StoneObstacle",
	},

	AsphodelWallRock12 =
	{
		Material = "StoneObstacle",
	},

	AsphodelBricksquare02 =
	{
		Material = "StoneObstacle",
	},

	AsphodelTombstone01 =
	{
		Material = "StoneObstacle",
	},

	AsphodelTombstone01b =
	{
		Material = "StoneObstacle",
	},

	AsphodelBrazier01 =
	{
		Material = "Bone",
	},

	AsphodelBrazier02 =
	{
		Material = "Bone",
	},

	AsphodelBrazier03 =
	{
		Material = "Bone",
	},

	ElysiumPillar06 =
	{
		OnHitShake = { Distance = 6, Speed = 300, Duration = 0.15, RequireAttackerNames = { "Minotaur", "Minotaur2" }, },
		CollisionReaction =
		{
			MinVelocity = 1200,
			Animation = "ElysiumPillar06B",
			SwapData = "ElysiumPillar06B",
			CausesOcclusion = false,
			RequireColliderName = "Minotaur2",
		}
	},

	ElysiumPillar06B =
	{
		Material = "Stone",

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = false,
			},
			{
				ThingProperty = "DrawVfxOnTop",
				ChangeValue = true,
			},
		},
	},

	ElysiumPillar05 =
	{
		Material = "Stone",
	},

	ElysiumDestructiblePillar =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "ElysiumPillarB",
			RequiredHitsForImpactReaction = 1,
			SpawnRandomObstacle = { "ElysiumRubble04", },
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "ElysiumDestructiblePillarB",
		},
	},

	ElysiumDestructiblePillarB =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "ElysiumPillarC",
			RequiredHitsForImpactReaction = 3,
			SpawnRandomObstacle = { "ElysiumRubble04", },
			SpawnAmount = 3,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "ElysiumDestructiblePillarC",
			CausesOcclusion = false,
		},
	},

	ElysiumDestructiblePillarC =
	{
		Material = "Stone",

		OnSpawnFireFunction = "RegenerateElysiumPillar",
		RegenerateStartDelay = 1.0,
		RegenerateDuration = 5.0,
		RegenerateAs = "ElysiumDestructiblePillar",
		RegenerateAnimation = "ElysiumPillarRegenerate-Fx",

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = false,
			},
			{
				ThingProperty = "DrawVfxOnTop",
				ChangeValue = true,
			},
		},

		RegenPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = true,
			},
			{
				ThingProperty = "DrawVfxOnTop",
				ChangeValue = false,
			},
		},
	},

	StyxWingDoor =
	{
		InheritFrom = { "ExitDoor", },

		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		RewardPreviewOffsetZ = 120,
		RewardPreviewOffsetY = 0,
		BackingAnimation = "UnattachedRoomRewardAvailable-Back",
		IconSortMode = "Isometric",

		OverheadTextFontSize = 14,
		OverheadTextOffset = -150,
		OverheadTextColor = Color.DarkOrange,

		UseText = "UseExitDoorWhileLocked",
		UnlockedUseText = "UseLeaveRoom",
		UnlockedUseTextReroll = "UseLeaveRoom_Reroll",
		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",
		RerollFunctionName = "AttemptRerollDoor",
		AllowReroll = true,

		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/Leftovers/SFX/NomadSprint",
		ExitPortalSound = "/SFX/HeatCollectionPickup",

		ExitFunctionName = "ExitSecretRoomPresentation",
		EntranceVfx = "ZagreusSecretDoorDiveFadeFx_Shrine",
		EntranceColorGrade = "SmokeTrap",

		ExitDoorOpenAnimation = "ShrinePointDoor_Revealed",
		ExitDoorCloseAnimation = "ShrinePointDoor_Revealed",
		UnlockedAnimation = "ShrinePointDoor_Revealed",
		UnlockedSound = "/SFX/HeatCollectionPickup",
	},

	StyxDestructiblePillar =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "StyxPillarB",
			RequiredHitsForImpactReaction = 1,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnOffsetXMin = 150,
			SpawnOffsetXMax = 450,
			SpawnOffsetYMin = 150,
			SpawnOffsetYMax = 390,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "StyxDestructiblePillarA",
		},
	},

	StyxDestructiblePillarA =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "StyxPillarC",
			RequiredHitsForImpactReaction = 2,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 4,
			SpawnTimeMin = 0.12,
			SpawnTimeMax = 0.24,
			SpawnOffsetXMin = 150,
			SpawnOffsetXMax = 450,
			SpawnOffsetYMin = 150,
			SpawnOffsetYMax = 390,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "StyxDestructiblePillarB",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
		},
	},

	StyxDestructiblePillarB =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "StyxPillarD",
			RequiredHitsForImpactReaction = 3,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 8,
			SpawnTimeMin = 0.12,
			SpawnTimeMax = 0.24,
			SpawnOffsetXMin = 150,
			SpawnOffsetXMax = 450,
			SpawnOffsetYMin = 150,
			SpawnOffsetYMax = 390,
			SpawnOffsetZ = 1000,
			FallForce = 3000,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "StyxDestructiblePillarC",
			CausesOcclusion = false,
		},
	},

	StyxDestructiblePillarC =
	{
		Material = "Stone",

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = false,
			},
			{
				ThingProperty = "DrawVfxOnTop",
				ChangeValue = true,
			},
		},
	},

	SurfaceDestructiblePillar =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "BossPillarB",
			RequiredHitsForImpactReaction = 1,
			SpawnRandomObstacle = { "SurfaceRubble02b" },
			ForceSpawnToValidLocation = true,
			SpawnOffsetXMin = 150,
			SpawnOffsetXMax = 450,
			SpawnOffsetYMin = 150,
			SpawnOffsetYMax = 390,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SwapData = "SurfaceDestructiblePillarA",
		},
	},

	SurfaceDestructiblePillarA =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "BossPillarC",
			RequiredHitsForImpactReaction = 2,
			SpawnRandomObstacle = { "SurfaceRubble02b" },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 5,
			SpawnTimeMin = 0.16,
			SpawnTimeMax = 0.32,
			SpawnOffsetXMin = 150,
			SpawnOffsetXMax = 450,
			SpawnOffsetYMin = 150,
			SpawnOffsetYMax = 390,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SwapData = "SurfaceDestructiblePillarB",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
		},
	},

	SurfaceDestructiblePillarB =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "BossPillarD",
			RequiredHitsForImpactReaction = 3,
			SpawnRandomObstacle = { "SurfaceRubble02b" },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 8,
			SpawnTimeMin = 0.16,
			SpawnTimeMax = 0.32,
			SpawnOffsetXMin = 150,
			SpawnOffsetXMax = 450,
			SpawnOffsetYMin = 150,
			SpawnOffsetYMax = 390,
			SpawnOffsetZ = 1000,
			FallForce = 3000,
			SwapData = "SurfaceDestructiblePillarC",
			CausesOcclusion = false,
		},
	},

	SurfaceDestructiblePillarC =
	{
		Material = "Stone",

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = false,
			},
			{
				ThingProperty = "DrawVfxOnTop",
				ChangeValue = true,
			},
		},
	},

	SurfaceGravemarker01 =
	{
		InheritFrom = { "TartarusRubble02", },
		SpawnScale = 0.5,
	},

	SurfaceGravemarker02 =
	{
		InheritFrom = { "TartarusRubble02", },
	},

	SurfaceGravemarker04 =
	{
		InheritFrom = { "TartarusRubble02", },
	},

	SurfaceGravemarker06 =
	{
		InheritFrom = { "TartarusRubble02", },
	},

	SurfaceRubble02b =
	{
		InheritFrom = { "TartarusRubble02", },
		SpawnScale = 0.25,
	},

	AsphodelDestructibleStalagmite =
	{
		Material = "Stone",

		OnTouchdown =
		{
			Weapon = "RubbleFall",
		},

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "AsphodelDestructibleStalagmiteA",
			RequiredHitsForImpactReaction = 1,
			SpawnRandomObstacle = {"AsphodelTerrainRock01", "AsphodelTerrainRock02", "AsphodelTerrainRock03"},
			ForceSpawnToValidLocation = true,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 200,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 150,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.10,
			SpawnScaleMax = 0.15,
			SwapData = "AsphodelDestructibleStalagmiteA",
		},
	},

	AsphodelDestructibleStalagmiteA =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "AsphodelDestructibleStalagmiteB",
			RequiredHitsForImpactReaction = 4,
			SpawnRandomObstacle = {"AsphodelTerrainRock01", "AsphodelTerrainRock02", "AsphodelTerrainRock03"},
			ForceSpawnToValidLocation = true,
			SpawnAmount = 2,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 200,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 150,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SpawnScaleMin = 0.10,
			SpawnScaleMax = 0.15,
			SwapData = "AsphodelDestructibleStalagmiteB",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
			CausesOcclusion = false,
		},
	},

	AsphodelDestructibleStalagmiteB =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "AsphodelDestructibleStalagmiteC",
			RequiredHitsForImpactReaction = 4,
			SpawnRandomObstacle = {"AsphodelTerrainRock01", "AsphodelTerrainRock02", "AsphodelTerrainRock03"},
			ForceSpawnToValidLocation = true,
			SpawnAmount = 2,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 200,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 150,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SpawnScaleMin = 0.10,
			SpawnScaleMax = 0.15,
			SwapData = "AsphodelDestructibleStalagmiteC",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
			CausesOcclusion = false,
		},
	},

	AsphodelDestructibleStalagmiteC =
	{
		Material = "Stone",

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = false,
			},
		},
	},

	AsphodelBoulder01 =
	{
		OnTouchdown =
		{
			Weapon = "RubbleFallLarge",
		},

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},
	},

	AsphodelTerrainRock01 =
	{
		MaxHealth = 1,
		InheritFrom = { "BaseDestructible" },


		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		OnTouchdown =
		{
			Weapon = "RubbleFall",
		},

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},
	},

	AsphodelTerrainRock02 =
	{
		InheritFrom = {"AsphodelTerrainRock01"},
	},

	AsphodelTerrainRock03 =
	{
		InheritFrom = {"AsphodelTerrainRock01"},
	},

	AsphodelSkull =
	{
		MaxHealth = 100,
		InheritFrom = { "BaseDestructible" },

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		OnTouchdown =
		{
			Weapon = "RubbleFallLarge",
		},

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},
	},

	AsphodelLavaJelly01 =
	{
		InheritFrom = { "BaseDestructible" },
		MaxHealth = 1,
	},

	CharonTogglePillar =
	{
		ToggleOnAnimation = "CharonTogglePillarToggleOn",
		ToggleOffAnimation = "CharonTogglePillarToggleOff",
		ToggledOn = true,
	},

	ChallengeSwitch =
	{
		UseText = "UseChallengeSwitch_Locked",
		ChallengeText = "ChallengeSwitch_Value",
		--ChallengeAvailableUseText = "UseChallengeSwitch_Unlocked",
		--ChallengeResolvedUseText = "UseChallengeSwitch_RewardAvailable",
		ChallengeSwitchUseFunctionName = "UseChallengeSwitch",
		CannotUseText = "ChallengeSwitchBlockedByEncounter",
		CannotAffordText = "ChallengeSwitchCannotAfford",
		LockedAnimationName = "ChallengeSwitchLocked",
		ReadyToOpenAnimationName = "ChallengeSwitchReadyToOpen",
		UnlockedAnimationName = "ChallengeSwitchUnlocked",
		ReadyAnimationName = "ChallengeSwitchReadyToOpen",
		BlockDuringChallenge = true,
		UsePromptOffsetX = 40,
		RewardType = "Money",
		CooldownNamePrefix = "ChallengeSwitch",
		CooldownDuration = 1.5,

		LockKeyTextOffsetY = -75,
		LockKeyTextOffsetX = 0,
		TextAnchorIdOffsetX = -40,
		TextAnchorIdOffsetY = -50,

		DistanceTrigger =
		{
			GameStateRequirements =
			{
				RequiredCosmetics = { "ChallengeSwitches1", },
			},
			WithinDistance = 500,
			VoiceLines =
			{
				Queue = "Always",
				CooldownTime = 5,

				-- That must be one of those Infernal Troves!
				{ Cue = "/VO/ZagreusField_2917", PlayOnce = true, },
			}
		},

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "Tallness",
				ChangeValue = 225,
			},
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = true,
			},
		},
	},

	-- StartingValue in EncounterData is the base value
	MoneyChallengeSwitch =
	{
		InheritFrom = { "ChallengeSwitch" },
		ChallengeAvailableUseText = "UseChallengeSwitch_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_MoneyRewardAvailable",
		RewardMultiplier = 1.0,
		IntervalMultiplier = 0.4,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches1" },
			RequiredFalseCosmetics = { "ChallengeSwitches2" },
		},
	},

	MoneyChallengeSwitch2 =
	{
		InheritFrom = { "MoneyChallengeSwitch" },
		RewardMultiplier = 1.25,
		IntervalMultiplier = 0.3,
		DifficultyModifier = 1.3,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches2" },
			RequiredFalseCosmetics = { "ChallengeSwitches3" },
		},
	},

	MoneyChallengeSwitch3 =
	{
		InheritFrom = { "MoneyChallengeSwitch" },
		RewardMultiplier = 1.5,
		IntervalMultiplier = 0.2,
		DifficultyModifier = 1.6,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches3" },
		},
	},

	HealthChallengeSwitch =
	{
		InheritFrom = { "ChallengeSwitch" },
		ChallengeText = "ChallengeSwitch_HealthValue",
		ChallengeAvailableUseText = "UseHealthChallengeSwitch_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_HealthRewardAvailable",
		RewardType = "Health",
		IntervalMultiplier = 0.4,
		DifficultyModifier = 0.7,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches1" },
			RequiredFalseCosmetics = { "ChallengeSwitches2" },
		},

	},

	HealthChallengeSwitch2 =
	{
		InheritFrom = { "HealthChallengeSwitch" },
		RewardMultiplier = 1.25,
		DifficultyModifier = 1.2,
		IntervalMultiplier = 0.3,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches2" },
			RequiredFalseCosmetics = { "ChallengeSwitches3" },
		},
	},

	HealthChallengeSwitch3 =
	{
		InheritFrom = { "HealthChallengeSwitch" },
		RewardMultiplier = 1.50,
		DifficultyModifier = 1.4,
		IntervalMultiplier = 0.2,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches3" },
		},
	},

	DarknessChallengeSwitch =
	{
		InheritFrom = { "ChallengeSwitch" },
		UseText = "UseChallengeSwitch_Locked",
		ChallengeText = "ChallengeSwitch_DarknessValue",
		ChallengeAvailableUseText = "UseDarknessChallengeSwitch_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_DarknessRewardAvailable",
		RewardMultiplier = 0.5,
		RewardType = "MetaPoints",
		IntervalMultiplier = 0.9,
		DifficultyModifier = 0.7,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches1" },
			RequiredFalseCosmetics = { "ChallengeSwitches2" },
		},
	},

	DarknessChallengeSwitch2 =
	{
		InheritFrom = { "DarknessChallengeSwitch" },
		RewardMultiplier = 1.0,
		IntervalMultiplier = 0.6,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches2" },
			RequiredFalseCosmetics = { "ChallengeSwitches3" },
		},
	},

	DarknessChallengeSwitch3 =
	{
		InheritFrom = { "DarknessChallengeSwitch" },
		RewardMultiplier = 1.5,
		IntervalMultiplier = 0.3,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches3" },
		},
	},

	GemChallengeSwitch =
	{
		InheritFrom = { "ChallengeSwitch" },
		UseText = "UseChallengeSwitch_Locked",
		ChallengeText = "ChallengeSwitch_GemValue",
		ChallengeAvailableUseText = "UseGemChallengeSwitch_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_GemRewardAvailable",
		RewardMultiplier = 0.25,
		RewardType = "Gems",
		IntervalMultiplier = 1.4,
		DifficultyModifier = 0.7,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches1" },
			RequiredFalseCosmetics = { "ChallengeSwitches2" },
		},
	},

	GemChallengeSwitch2 =
	{
		InheritFrom = { "GemChallengeSwitch" },
		RewardMultiplier = 0.50,
		IntervalMultiplier = 0.9,
		DifficultyModifier = 1.1,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches2" },
			RequiredFalseCosmetics = { "ChallengeSwitches3" },
		},
	},

	GemChallengeSwitch3 =
	{
		InheritFrom = { "GemChallengeSwitch" },
		RewardMultiplier = 0.75,
		IntervalMultiplier = 0.5,
		DifficultyModifier = 1.4,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches3" },
		},
	},

	WellShop =
	{
		UseText = "UseWell_Locked",
		AvailableUseText = "UseWell_Unlocked",
		ChallengeSwitchUseFunctionName = "UseWellShop",
		CannotUseText = "WellShopBlockedByEncounter",
		BlockDuringChallenge = true,

		UsePromptOffsetX = 40,

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "Tallness",
				ChangeValue = 225,
			},
		},
	},

	SellTraitShop =
	{
		UseText = "UseTraitShop_Locked",
		AvailableUseText = "UseTraitShop_Unlocked",
		ChallengeSwitchUseFunctionName = "OpenSellTraitMenu",
		CannotUseText = "SellTraitShopBlockedByEncounter",
		BlockDuringChallenge = true,
		UsePromptOffsetX = 40,

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "Tallness",
				ChangeValue = 225,
			},
		},
	},

	SecretDoor =
	{
		HideRewardPreview = true,

		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		--OverheadText = "RoomReward_Random",
		OverheadTextFontSize = 14,
		OverheadTextOffset = -150,
		OverheadTextColor = Color.DarkOrange,

		UseText = "UseSecretDoor_Locked_PreReward",
		LockedUseText = "UseSecretDoor_Locked_PostReward",
		UnlockedUseText = "UseSecretDoor_Unlocked",

		-- UseSound = "/Leftovers/SFX/NomadSprint",
		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/Leftovers/SFX/NomadSprint",

		ExitFunctionName = "ExitSecretRoomPresentation",

		ExitDoorOpenAnimation = "SecretDoor_Revealed",
		ExitDoorCloseAnimation = "SecretDoor_Revealed",
		UnlockedAnimation = "SecretDoor_Revealed",
		UnlockedSound = "/SFX/Menu Sounds/ChaosBoonChange",
		UnlockedGlobalVoiceLines = "ChaosSecretUnlockedVoiceLines",

		DistanceTrigger =
		{
			GameStateRequirements =
			{
				RequiredFalseTextLines = { "ChaosFirstPickUp", },
			},
			WithinDistance = 500,
			VoiceLines =
			{
				Queue = "Always",
				PreLineWait = 0.3,

				-- That is an ominous-looking portal on the ground right there.
				{ Cue = "/VO/ZagreusField_2868", RequiredKillEnemiesNotFound = true, PlayOnce = true,RequiredFalsePlayedThisRoom = { "/VO/ZagreusField_2869" } },
				-- What is that portal thing there on the ground?
				{ Cue = "/VO/ZagreusField_2869", RequiredKillEnemiesFound = true, PlayOnce = true, RequiredFalsePlayedThisRoom = { "/VO/ZagreusField_2868" } },
			}
		}
	},

	SecretExitDoor =
	{
		IsDefaultDoor = true,

		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		RewardPreviewOffsetZ = 120,
		RewardPreviewOffsetY = 0,
		BackingAnimation = "UnattachedRoomRewardAvailable-Back",
		IconSortMode = "Isometric",

		UseText = "UseSecretDoor_Locked_PreReward",
		LockedUseText = "UseSecretDoor_Locked_PostReward",
		UnlockedUseText = "UseExitSecretRoom",

		UnlockedUseTextReroll = "UseExitSecretRoom_Reroll",
		UnlockedUseTextCannotReroll = "UseExitSecretRoom_CannotReroll",
		RerollFunctionName = "AttemptRerollDoor",
		AllowReroll = true,

		-- UseSound = "/Leftovers/SFX/NomadSprint",
		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/Leftovers/SFX/NomadSprint",
		ExitPortalSound = "/SFX/Menu Sounds/SecretDoorExitShimmer",

		ExitDoorOpenAnimation = "SecretDoor_Revealed",
		ExitDoorCloseAnimation = "SecretDoor_Revealed",
		UnlockedAnimation = "SecretDoor_Revealed"
	},

	ShrinePointDoor =
	{
		CostBase = 2,
		CostPerDepth = 2,

		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		RewardPreviewOffsetZ = 120,
		RewardPreviewOffsetY = 1,
		BackingAnimation = "UnattachedRoomRewardAvailable-Back",
		IconSortMode = "Isometric",

		OverheadTextFontSize = 14,
		OverheadTextOffset = -150,
		OverheadTextColor = Color.DarkOrange,

		UseText = "UseShrinePointDoor_Locked_PreReward",
		LockedUseText = "UseShrinePointDoor_Locked_PostReward",
		UnlockedUseText = "UseShrinePointDoor_Unlocked",
		UnlockedUseTextReroll = "UseShrinePointDoor_Unlocked_Reroll",
		UnlockedUseTextCannotReroll = "UseShrinePointDoor_Unlocked_CannotReroll",
		RerollFunctionName = "AttemptRerollDoor",
		AllowReroll = true,

		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/Leftovers/SFX/NomadSprint",
		ExitPortalSound = "/SFX/HeatCollectionPickup",

		ExitFunctionName = "ExitSecretRoomPresentation",
		EntranceVfx = "ZagreusSecretDoorDiveFadeFx_Shrine",
		EntranceColorGrade = "SmokeTrap",

		ExitDoorOpenAnimation = "ShrinePointDoor_Revealed",
		ExitDoorCloseAnimation = "ShrinePointDoor_Revealed",
		UnlockedAnimation = "ShrinePointDoor_Revealed",
		UnlockedSound = "/SFX/HeatCollectionPickup",

		ExitBlockedByShrinePointsVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			CooldownTime = 9,

			-- I need a higher Pain Level with the Pact of Punishment to go in this.
			-- { Cue = "/VO/ZagreusField_1340", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- I need to power up the Pact of Punishment back home to go in this.
			{ Cue = "/VO/ZagreusField_1341" },
			-- My Pain Level isn't high enough.
			-- { Cue = "/VO/ZagreusField_1342", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- My Pain Level's too low.
			-- { Cue = "/VO/ZagreusField_1343", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- I need a higher Pain Level to go in.
			-- { Cue = "/VO/ZagreusField_1344", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- My Pain Level's too low to get in.
			-- { Cue = "/VO/ZagreusField_1345", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- Need a higher Pain Level to go in there.
			-- { Cue = "/VO/ZagreusField_1346", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- Not getting in without a higher Pain Level.
			-- { Cue = "/VO/ZagreusField_1347", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- I'm not authorized.
			{ Cue = "/VO/ZagreusField_1348", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- Not letting me in.
			{ Cue = "/VO/ZagreusField_1349", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- I don't have access.
			{ Cue = "/VO/ZagreusField_1350", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- I can't get in.
			{ Cue = "/VO/ZagreusField_1351", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- Not authorized to go in there.
			{ Cue = "/VO/ZagreusField_1352", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- The Pact back home's the key to getting into this.
			{ Cue = "/VO/ZagreusField_1353", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- Not authorized.
			{ Cue = "/VO/ZagreusHome_0602", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- Not enough Heat.
			{ Cue = "/VO/ZagreusHome_0603", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- I don't have enough Heat.
			{ Cue = "/VO/ZagreusHome_0604", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- I'm not authorized.
			{ Cue = "/VO/ZagreusHome_0605", RequiredPlayed = { "/VO/ZagreusField_1341" } },
			-- I'm not cleared to do that.
			{ Cue = "/VO/ZagreusHome_0606", RequiredPlayed = { "/VO/ZagreusField_1341" } },
		},
	},

	ShrinePointExitDoor =
	{
		IsDefaultDoor = true,

		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		RewardPreviewOffsetZ = 120,
		RewardPreviewOffsetY = 0,
		BackingAnimation = "UnattachedRoomRewardAvailable-Back",
		IconSortMode = "Isometric",

		UseText = "UseSecretDoor_Locked_PreReward",
		LockedUseText = "UseSecretDoor_Locked_PostReward",
		UnlockedUseText = "UseExitSecretRoom",
		UnlockedUseTextReroll = "UseExitSecretRoom_Reroll",
		UnlockedUseTextCannotReroll = "UseExitSecretRoom_CannotReroll",
		RerollFunctionName = "AttemptRerollDoor",
		AllowReroll = true,

		-- UseSound = "/Leftovers/SFX/NomadSprint",
		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/Leftovers/SFX/NomadSprint",
		ExitPortalSound = "/SFX/HeatCollectionPickup",

		ExitDoorOpenAnimation = "ShrinePointDoor_Revealed",
		ExitDoorCloseAnimation = "ShrinePointDoor_Revealed",
		UnlockedAnimation = "ShrinePointDoor_Revealed"
	},

	FishingPoint =
	{
		UseText = "UseFishingPointLocked",
		FishUnlockedUseText = "UseFishingPoint",

		DistanceTrigger =
		{
			GameStateRequirements =
			{
				-- RequiredCosmetics = { "FishingUnlockItem", },
			},
			WithinDistance = 500,
			VoiceLines =
			{
				TriggerCooldowns = { "ZagreusStartedFishingSpeech", },
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					SuccessiveChanceToPlayAll = 0.25,
					RequiredKillEnemiesNotFound = true,
					CooldownTime = 600,
					RequiresNotFishing = true,
					AreIdsNotAlive = { 554419, 554420, 554421 },
					RequiredBiome = "Secrets",
					PreLineWait = 1.0,

					-- That a fishing point?
					{ Cue = "/VO/ZagreusField_3410" },
					-- A fishing point, here?
					{ Cue = "/VO/ZagreusField_3411" },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					SuccessiveChanceToPlayAll = 0.25,
					RequiredKillEnemiesNotFound = true,
					CooldownTime = 600,
					RequiresNotFishing = true,
					AreIdsNotAlive = { 554419, 554420, 554421 },

					-- Could use the Rod of Fishing there.
					{ Cue = "/VO/ZagreusField_3212" },
					-- A fishing point.
					{ Cue = "/VO/ZagreusField_3213", RequiredPlayed = { "/VO/ZagreusField_3212" } },
					-- Hey think I see a fish.
					{ Cue = "/VO/ZagreusField_3214", RequiredPlayed = { "/VO/ZagreusField_3212" } },
					-- Fishing point there.
					{ Cue = "/VO/ZagreusField_3215", RequiredPlayed = { "/VO/ZagreusField_3212" } },
					-- Fishing time...?
					{ Cue = "/VO/ZagreusField_3216", RequiredPlayed = { "/VO/ZagreusField_3212" } },
				},
			}
		},
	},

	MetaUpgradeViewer =
	{
		UseText = "UseMetaUpgradeViewer",
		UseSound = "/Leftovers/SFX/NomadSprint",
		OnUsedFunctionName = "UseMetaUpgradeObject",
		OnUsedFunctionArgs = { ReadOnly = true, },
	},

	ShrineUpgradeViewer =
	{
		UseText = "UseShrineUpgradeViewer",
		UseSound = "/Leftovers/SFX/NomadSprint",
		OnUsedFunctionName = "UseShrineObject",
		OnUsedFunctionArgs = { ReadOnly = true, },
	},

	OnslaughtStartButton =
	{
		UseText = "UseOnslaughtStartButton",
		UseSound = "/Leftovers/SFX/NomadSprint",

		OnUsedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.6,

			-- Come try me.
			{ Cue = "/VO/ZagreusField_0022" },
			-- Come on, then.
			{ Cue = "/VO/ZagreusField_0026" },
			-- How do you do.
			{ Cue = "/VO/ZagreusField_0028" },
			-- Look who.
			{ Cue = "/VO/ZagreusField_0318" },
			-- Hello mates.
			{ Cue = "/VO/ZagreusField_0320" },
			-- Come and get it.
			{ Cue = "/VO/ZagreusField_0571" },
			-- You wretches.
			{ Cue = "/VO/ZagreusField_0573" },
			-- Oh hello.
			{ Cue = "/VO/ZagreusField_0577" },
			-- May I help you?
			{ Cue = "/VO/ZagreusField_0579" },
			-- Want to fight?
			{ Cue = "/VO/ZagreusField_0581" },
			-- Come.
			{ Cue = "/VO/ZagreusField_0591" },
		},

	},

	BoatGate =
	{
		UseText = "UseEnterBoat",
		UseSound = "/Leftovers/SFX/NomadSprint",
		ExitDoorOpenAnimation = "HealthGate_Revealed",
		ExitDoorCloseAnimation = "HealthGate_Revealed",
	},

	GlowPulseBSlow =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	CandleWisp =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	CandleFlame =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
			ReactionSound = "/Leftovers/World Sounds/Caravan Interior/CandleBlow",
		},
		ReappearSound =	"/Leftovers/World Sounds/Caravan Interior/CandleBlow",
	},
	LightEllipse02Anim =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	TartarusFlame =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
			ReactionSound = "/Leftovers/World Sounds/Caravan Interior/CandleBlow",
		},
		ReappearSound =	"/Leftovers/World Sounds/Caravan Interior/CandleBlow",
	},
	TorchFlame =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
			ReactionSound = "/Leftovers/World Sounds/Caravan Interior/CandleBlow",
		},
		ReappearSound =	"/Leftovers/World Sounds/Caravan Interior/CandleBlow",
	},
	AtmosphereGlow01 =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	LightAngularCircle01 =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	LightEllipse02 =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	TartarusFireGlow =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	SmokeRising =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	SmokeRisingHardBright =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},

	-- Enemy Equipment Obstacles
	EnemyJavelin =
	{
		AddWeaponOptionOnPickup = "BloodlessJavelin",
		AttachAnimation = "BloodlessJavelin",
		IsEnemyWeapon = true,
		UseText = "UseEnemyWeapon",
	},

	EnemyShield =
	{
		SwapToUnitOnPickup = "ShadeShieldUnit",
		IsEnemyWeapon = true,
		UseText = "UseEnemyWeapon",
		BeginPickupAnimation = "EnemyShieldPickupContainer",
		PickupFailedAnimation = "EnemyShieldIdleContainer",
	},

	EnemyBow =
	{
		SwapToUnitOnPickup = "ShadeBowUnit",
		IsEnemyWeapon = true,
		UseText = "UseEnemyWeapon",
		BeginPickupAnimation = "EnemyBowPickupContainer",
		PickupFailedAnimation = "EnemyBowIdleContainer",
	},

	SpearReturnPointAlt01 = 
	{
		SetupFunctionName = "CheckSpearTeleport",
	},
	
	EnemySpear =
	{
		SwapToUnitOnPickup = "ShadeSpearUnit",
		IsEnemyWeapon = true,
		UseText = "UseEnemyWeapon",
		BeginPickupAnimation = "EnemySpearPickupContainer",
		PickupFailedAnimation = "EnemySpearIdleContainer",
	},

	EnemySword =
	{
		SwapToUnitOnPickup = "ShadeSwordUnit",
		IsEnemyWeapon = true,
		UseText = "UseEnemyWeapon",
		BeginPickupAnimation = "EnemySwordPickupContainer",
		PickupFailedAnimation = "EnemySwordIdleContainer",
	},

	EnemyDagger =
	{
		SwapToUnitOnPickup = "ShadeSwordUnit",
		IsEnemyWeapon = true,
		UseText = "UseEnemyWeapon",
	},

	MultiFuryMegaeraIntro =
	{
		ExitAnimation = "MegaeraMultiFuryTakeOff",
	},

	MultiFuryAlectoIntro =
	{
		ExitAnimation = "AlectoMultiFuryTakeOff",
	},

	MultiFuryTisiphoneIntro =
	{
		ExitAnimation = "TisiphoneMultiFuryTakeOff",
	},

	HouseFirecrackers01 =
	{
		SetupGameStateRequirements =
		{
			RequiredTrueFlags = { "Disabled", },
		},
		DestroyIfNotSetup = true,
	},
	-- hades bed (pre-ending)
	HouseBed02 =
	{
		SetupGameStateRequirements =
		{
			RequiredFalseTextLines = { "PersephoneReturnsHome01" },
		},
		DestroyIfNotSetup = true,
	},
	HouseBed02a =
	{
		SetupGameStateRequirements =
		{
			RequiredTextLines = { "PersephoneReturnsHome01" },
		},
		DestroyIfNotSetup = true,
	},

	-- ending
	HousePaintingFamily01 =
	{
		UseText = "UseShrinePointClear_QuestCleared",
		InteractDistance = 350,
		SetupGameStateRequirements =
		{
			RequiredTextLines = { "Ending01" },
		},
		DestroyIfNotSetup = true,
		OnUsedFunctionName = "ViewPortraitPresentation",
		OnUsedFunctionArgs = { PortraitAnimationName = "PortraitFamily" },
	},

	-- Walls
	_Impassable_Tile64IsoUnitsOnly_Tall =
	{
		HitText = "PitSlamHit",
	},
	_Impassable_Tile64IsoUnitsOnly_Short =
	{
		HitText = "PitSlamHit",
	},
	ClampWall_Left =
	{
		HitText = "PitSlamHit",
	},
	ClampWall_Right =
	{
		HitText = "PitSlamHit",
	},
	ClampWall_Top =
	{
		HitText = "PitSlamHit",
	},
	ClampWall_Bottom =
	{
		HitText = "PitSlamHit",
	},
}

MaterialDefaults =
{
	Chains = "MetalObstacle",
	Sword = "MetalObstacle",
	Brick = "BrickObstacle",
	Pedestal = "StoneObstacle",
	Fence = "StoneObstacle",
	Door = "StoneObstacle",
	Gable = "StoneObstacle",
	Brick = "StoneObstacle",
	Pillar = "StoneObstacle",
	Rubble = "StoneObstacle",
	Brazier = "StoneObstacle",
	Statue = "StoneObstacle",
	Planter = "StoneObstacle",
	Bush = "BushObstacle",
	Urn = "PorcelainObstacle",
	Vase = "MetalObstacle",
	Wall = "StoneObstacle",
	Planter = "StoneObstacle",
	Tile = "StoneObstacle",
	Impassable = "StoneObstacle",
}