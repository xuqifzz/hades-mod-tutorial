ConstantsData.TierSCosmeticCount = 54
ConstantsData.TierACosmeticCount = 44
ConstantsData.TierBCosmeticCount = 24
ConstantsData.TierCCosmeticCount = 14
ConstantsData.TierDCosmeticCount = 7

ConditionalItemData =
{
	DefaultCriticalItem =
	{
		DebugOnly = true,
		Icon = "Shop_BedroomDecor",
		Slot = "Critical",
		ResourceName = "Gems",
		ResourceCost = 10,
		PanDuration = 2,
		-- UsePanSound = true,
		DoVerticalPan = true,
		UseUnlockText = true,
		PreActivationHoldDuration = 1.5,
		PostActivationHoldDuration = 1.5,
		SetPlayerAnimation = "ZagreusCosmeticPurchase",
		-- UseReturnPanSound = true,
		SkipFade = true,
		SkipPurchaseGlobalVoiceLines = true,
		-- SkipRevealReactionGlobalVoiceLines = true,

		RevealVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.35,
			TriggerCooldowns = { "ZagreusCannotAffordMenuSpeech", },

			-- This one, Contractor. Ought to make the Underworld a better place, I think.
			{ Cue = "/VO/ZagreusHome_1323", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- Let's make it happen. I'll have to keep an eye out for this next I'm out there.
			{ Cue = "/VO/ZagreusHome_1324", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- I like the sound of this. Work approved and here's the fee, good Contractor!
			{ Cue = "/VO/ZagreusHome_1691", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- Here you go! I'll be on the lookout for this when I'm in the area.
			{ Cue = "/VO/ZagreusHome_1326", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- Here! The Underworld could always use a little extra renovating, right?
			{ Cue = "/VO/ZagreusHome_1327", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- I like the sound of this one here, good Contractor. Go make it happen!
			{ Cue = "/VO/ZagreusHome_1692", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- Work is approved, upon my father's name! Not like he's paying any heed.
			{ Cue = "/VO/ZagreusHome_1329", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- I'm hereby authorizing this expenditure! And I look forward to seeing the result.
			{ Cue = "/VO/ZagreusHome_1330", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- House Contractor, my good shade, I've yet another job for your distinguished team.
			{ Cue = "/VO/ZagreusHome_1331", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- Let's go with this assignment, Contractor! My father surely would approve.
			{ Cue = "/VO/ZagreusHome_1332", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- This looks to be an excellent investment, Contractor! Go on and make it so.
			{ Cue = "/VO/ZagreusHome_1333", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- The ever-shifting chambers of the Underworld ought be a little livelier with this.
			{ Cue = "/VO/ZagreusHome_1334" },
			-- Contractor, I would ask that you pursue this job. I'll be excited to see the result!
			{ Cue = "/VO/ZagreusHome_1693", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- Your asking price, good Contractor. Well worth the fruits of your hard work, I'm sure.
			{ Cue = "/VO/ZagreusHome_1694", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- Since Father's not paying us any heed, what say with go with this assignment, Contractor?
			{ Cue = "/VO/ZagreusHome_1695", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- I grant you funding and autonomy to do this job upon your earliest convenience, Contractor.
			{ Cue = "/VO/ZagreusHome_1696", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- All right! If this isn't a good expenditure of resources, then I don't know what is.
			{ Cue = "/VO/ZagreusHome_1697", RequiredPlayed = { "/VO/ZagreusHome_1334" } },
			-- On my authority, I'd like it if you did this job for me, is that all right?
			{ Cue = "/VO/ZagreusHome_1698", RequiredPlayed = { "/VO/ZagreusHome_1334" } },

		},
		RevealReactionGlobalVoiceLines = "HadesGhostAdminCriticalItemPurchaseReactionVoiceLines",
	},

	DefaultCosmeticItem =
	{
		DebugOnly = true,
		Icon = "Shop_BedroomDecor",
		Slot = "CosmeticMainHall",
		ResourceName = "Gems",
		ResourceCost = 10,
		PanDuration = 2.5,
		UsePanSound = true,
		PreActivationHoldDuration = 3,
		PostActivationHoldDuration = 3,
		DeathAreaFocusId = 424957, -- hall from bloodpool
		-- UseItemPreActivationVfx = true,
		-- ItemPreActivationVfx = "someAnimation",
		UseItemActivationVfx = true,
		-- ItemActivationVfx = "someAnimation",
		UseReturnPanSound = true,
		Removable = true,

		RevealVoiceLines =
		{
			RandomRemaining = true,
			PreLineWait = 0.35,

			-- All set.
			{ Cue = "/VO/ZagreusHome_0136" },
			-- Paid in full up front, let's see what we get!
			{ Cue = "/VO/ZagreusHome_1092" },
			-- House Contractor, I have a new job for you.
			{ Cue = "/VO/ZagreusHome_1093" },
			-- All right, House Contractor, go do your thing.
			{ Cue = "/VO/ZagreusHome_1094" },
			-- Let's lighten things up a little around here.
			{ Cue = "/VO/ZagreusHome_1095" },
			-- Let's see how this one turns out.
			{ Cue = "/VO/ZagreusHome_1096" },
			-- All right, let's see what we got.
			{ Cue = "/VO/ZagreusHome_1097" },
			-- This should help liven the mood a bit.
			{ Cue = "/VO/ZagreusHome_1098" },
			-- One more embellishment for the old House.
			{ Cue = "/VO/ZagreusHome_1099" },
		},
		RemoveGlobalVoiceLines = "CosmeticRemovedVoiceLines",
		ReEquipGlobalVoiceLines = "CosmeticReAddedVoiceLines",
	},

	LoungeItem =
	{
		AttachedDim = "Lounge",
		Slot = "CosmeticLounge",
	},

	NorthHallItem =
	{
		AttachedDim = "TopHall",
		Slot = "CosmeticNorthHall",
	},

	GhostAdminDesk =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_GhostAdminDesk",
		ResourceName = "SuperGems",
		ResourceCost = 2,
		SkipFade = false,
		UseUnlockText = false,
		DoVerticalPan = false,
		UseUnlockText = false,
		UseItemActivationVfx = true,
		ItemActivationVfxId = 555806,

		SetAnimations =
		{
			HouseContractorTable02 = "HouseContractorTable01",
		},

		GameStateRequirements =
		{
			RequiredCosmetics = { "ElysiumReprieve", "PostBossGiftRack", "QuestLog", "ChallengeSwitches1", "BreakableValue1", "OrpheusUnlockItem" },
		},

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.3,
				-- You've done so much for us, House Contractor. Why don't you do a little something for yourself?
				{ Cue = "/VO/ZagreusHome_2812" },
			},
			{
				PreLineWait = 0.5,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- If that mess of a table enhances the Contractor's productivity, then so be it.
				{ Cue = "/VO/Hades_1025" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	TartarusReprieve =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_LayoutUpgrade",
		ResourceName = "Gems",
		ResourceCost = 0,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Work authorized! A fountain chamber in the depths of Tartarus sounds like an excellent idea.
				{ Cue = "/VO/ZagreusHome_1526" },
			},
		},
		RevealReactionGlobalVoiceLines = "HadesTartarusReprieveReactionVoiceLines",
	},

	CodexBoonList =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_CodexBoonList",
		ResourceName = "Gems",
		ResourceCost = 50,
		GameStateRequirements =
		{
			RequiredCosmetics = { "QuestLog" },
			RequiredTextLines = { "AchillesGrantsCodex", "AthenaFirstPickUp", "ZeusFirstPickUp", "PoseidonFirstPickUp", "AphroditeFirstPickUp", "ArtemisFirstPickUp", "AresFirstPickUp", "DionysusFirstPickUp", "HermesFirstPickUp" },
			RequiredAnyTraitsTaken = GameData.AllSynergyTraits,
		},

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- The more I know about the Boons I'm offered, the better off I'll be.
				{ Cue = "/VO/ZagreusHome_3535" },
			},
			{
				PreLineWait = 0.8,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",

				-- You won't be better off, believe you me.
				{ Cue = "/VO/Hades_1163", RequiredFalseTextLines = { "Ending01" }, },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},
		
	HadesEMFight =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_HadesEMFight",
		ResourceName = "Gems",
		ResourceCost = 100,
		GameStateRequirements =
		{
			RequiredTextLines = { "LordHadesPostEnding01" },
		},

		OfferedVoiceLines =
		{
			CooldownTime = 200,
			PreLineWait = 0.45,
			PlayOnce = true,

			-- What is this...
			{ Cue = "/VO/ZagreusField_3339" },
		},

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- If my father can be even more frustrating, that's something I have to see.
				{ Cue = "/VO/ZagreusHome_3536" },
			},
			{
				PreLineWait = 0.8,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",

				-- Oh, you are in for it, now, boy...
				{ Cue = "/VO/Hades_1162" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	HealthFountainHeal1 =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_LayoutUpgrade",
		GameStateRequirements =
		{
			RequiredCosmetics = { "TartarusReprieve", "QuestLog" },
		},
		ResourceName = "Gems",
		ResourceCost = 20,
		AddHealFraction = 0.1,
	},
	HealthFountainHeal2 =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_LayoutUpgrade",
		GameStateRequirements =
		{
			RequiredCosmetics = { "TartarusReprieve", "HealthFountainHeal1", },
		},
		ResourceName = "Gems",
		ResourceCost = 40,
		AddHealFraction = 0.1,
	},

	AsphodelReprieve =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_LayoutUpgrade",
		ResourceName = "Gems",
		ResourceCost = 20,
		GameStateRequirements =
		{
			RequiredSeenRooms = { "B_Intro", },
			RequiredCosmetics = { "TartarusReprieve", "PostBossGiftRack" },
		},
	},
	--[[
	AsphodelStory =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_LayoutUpgrade",
		ResourceName = "SuperGems",
		ResourceCost = 1,
		GameStateRequirements =
		{
			RequiredSeenRooms = { "B_Intro", },
			RequiredCosmetics = { "TartarusReprieve", "PostBossGiftRack" },
		},
	},
	]]

	ElysiumReprieve =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_LayoutUpgrade",
		ResourceName = "Gems",
		ResourceCost = 40,
		GameStateRequirements =
		{
			RequiredSeenRooms = { "C_Intro", },
			RequiredCosmetics = {
								"TartarusReprieve", "PostBossGiftRack",
								},
		},
	},

	--[[
	ElysiumStory =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_LayoutUpgrade",
		ResourceName = "SuperGems",
		ResourceCost = 2,
		GameStateRequirements =
		{
			RequiredSeenRooms = { "C_Intro", },
			RequiredCosmetics = {
								"TartarusReprieve",
								},
		},
	},
	]]

	ChallengeSwitches1 =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_ChallengeSwitch",
		ResourceName = "Gems",
		ResourceCost = 10,
		GameStateRequirements =
		{
			RequiredCosmetics = { },
		},
	},
	ChallengeSwitches2 =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_ChallengeSwitch",
		ResourceName = "Gems",
		ResourceCost = 150,
		GameStateRequirements =
		{
			RequiredCosmetics = {
								"ChallengeSwitches1",
								"PostBossGiftRack",
								"TartarusReprieve",
								"AsphodelReprieve",
								"ElysiumReprieve",
			 					},
		},
	},
	ChallengeSwitches3 =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_ChallengeSwitch",
		ResourceName = "Gems",
		ResourceCost = 500,
		GameStateRequirements =
		{
			RequiredCosmetics = { "ChallengeSwitches2",
								"PostBossGiftRack",
								"TartarusReprieve",
								"AsphodelReprieve",
								"ElysiumReprieve",
								"GhostAdminDesk",
								 },
		},
	},

	BreakableValue1 =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_GoldUrn",
		ResourceName = "Gems",
		ResourceCost = 30,
		GameStateRequirements =
		{
			RequiredCosmetics = { "TartarusReprieve" },
		},
	},
	BreakableValue2 =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_GoldUrn",
		ResourceName = "Gems",
		ResourceCost = 60,
		GameStateRequirements =
		{
			RequiredCosmetics = { "BreakableValue1" },
		},
	},
	BreakableValue3 =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_GoldUrn",
		ResourceName = "Gems",
		ResourceCost = 120,
		GameStateRequirements =
		{
			RequiredCosmetics = { "BreakableValue2" },
		},
	},
	PostBossGiftRack =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_GiftRack",
		ResourceName = "Gems",
		ResourceCost = 10,
		GameStateRequirements =
		{
			RequiredCosmetics = { "TartarusReprieve" },
			RequiredSeenRooms = { "A_PostBoss01", },
		},
	},
	RoomRewardMetaPointDropRunProgress =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_MetaPointDrop",
		ResourceName = "SuperGems",
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "GhostAdminDesk" },
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.5,
			PlayOnce = true,

			-- Hey that sounds handy, there...
			{ Cue = "/VO/ZagreusHome_3562" },
		},
	},
	LockKeyDropRunProgress =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_LockKeyDrop",
		ResourceName = "SuperGems",
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "GhostAdminDesk" },
		},
	},
	GemDropRunProgress =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_GemDrop",
		ResourceName = "SuperGems",
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "GhostAdminDesk" },
		},
	},
	GiftDropRunProgress =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_GiftDrop",
		ResourceName = "SuperGems",
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredCosmetics = { "GhostAdminDesk" },
		},
	},

	UnusedWeaponBonusAddGems =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_WeaponBonus",
		ResourceName = "SuperGems",
		ResourceCost = 2,
		GameStateRequirements =
		{
			RequiredCosmetics = { "GhostAdminDesk" },
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Approved! Wouldn't mind an extra helping of gemstones while I'm ransacking out there.
				{ Cue = "/VO/ZagreusHome_3119" },
			},
			{
				PreLineWait = 0.8,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You wish to mine my realm for gemstones, be my guest.
				{ Cue = "/VO/Hades_1065" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	BossAddGems =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_BossAddGems",
		ResourceName = "SuperGems",
		ResourceCost = 4,
		GameStateRequirements =
		{
			RequiredCosmetics = { "GhostAdminDesk" },
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Sign me up, Contractor. This ought to pay for itself in no time at all!
				{ Cue = "/VO/ZagreusHome_3658" },
			},
			{
				PreLineWait = 0.8,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Counting on resources you have not yet earned?
				{ Cue = "/VO/Hades_1171" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	ShrinePointGates =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "RunUpgrade_ShrinePointGate",
		ResourceName = "SuperGems",
		ResourceCost = 5,
		GameStateRequirements =
		{
			RequiredCosmetics = { "GhostAdminDesk" },
			RequiredMinRunsCleared = 1,
		},
	},

	QuestLog =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "KeyItem_QuestLog",
		InspectPoint = 422257,
		DoVerticalPan = false,
		PanDuration = 2.5,
		UsePanSound = true,
		PreActivationHoldDuration = 3,
		PostActivationHoldDuration = 3,
		DeathAreaFocusId = 424948, -- zag's bedroom doorway
		UseItemActivationVfx = true,
		-- ItemActivationVfx = "someAnimation",
		UseReturnPanSound = true,
		OnPurchasedFunctionName = "CheckQuestStatus",
		OnPurchasedFunctionArgs = { Silent = true, },

		SkipFade = true,
		ResourceName = "Gems",
		ResourceCost = 20,
		GameStateRequirements =
		{
			RequiredCosmetics = { "TartarusReprieve" },
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.5,
			PlayOnce = true,
			RequiredFalsePlayedThisRoom = { "/VO/ZagreusHome_1526" },

			-- What's that, there, something from the Fates?
			{ Cue = "/VO/ZagreusHome_3561" },
		},
		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- The Fated List of Minor Prophecies... that sounds somewhat exciting, I suppose.
				{ Cue = "/VO/ZagreusHome_1336" },
			},
		},

		RevealReactionGlobalVoiceLines = "HadesQuestLogReactionVoiceLines",
	},

	FishingUnlockItem =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "CosmeticIcon_FishingRod",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 4,
			RequiredSeenRooms = { "D_Intro", },
			RequiredCosmetics = { "TartarusReprieve", "QuestLog" },
		},
		ResourceName = "SuperGems",
		ResourceCost = 1,

		OfferedVoiceLines =
		{
			PreLineWait = 0.5,
			PlayOnce = true,

			-- Whoa, a Rod of Fishing? Here?
			{ Cue = "/VO/ZagreusHome_3523" },
		},

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I positively cannot wait to see what sorts of foul creatures I'll dredge up with this!
				{ Cue = "/VO/ZagreusHome_1709" },
			},
			{
				PreLineWait = 0.8,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Cheap blessing from Poseidon on a stick, and nothing more.
				{ Cue = "/VO/Hades_0647" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	OfficeDoorUnlockItem =
	{
		InheritFrom = { "DefaultCriticalItem", "NorthHallItem" },
		Icon = "KeyItem_SealedDoc",
		ResourceName = "SuperGems",
		ResourceCost = 2,
		GameStateRequirements =
		{
			RequiredTextLines = { "Flashback_DayNightJob_01" },
		},
		DeathAreaFocusId = 421122, -- southwest hall
		UsePanSound = true,
		UseReturnPanSound = true,
		PreActivationHoldDuration = 3,
		PostActivationHoldDuration = 3,
		DoVerticalPan = false,
		UseUnlockText = false,
		-- SkipFade = false,
		UseItemActivationVfx = true,
		ItemActivationVfxId = 393488,
		ItemActivationVfxOffsetY = -300,
		SkipPurchaseGlobalVoiceLines = true,
		SkipRevealReactionGlobalVoiceLines = true,

		ActivateIds = { 427199 },
		DeactivateIds = { 427213 },
		ToggleUseabilityOffIds = { 427213 },

		OfferedVoiceLines =
		{
			PreLineWait = 0.5,
			PlayOnce = true,

			-- Access to the administrative chamber, huh...
			{ Cue = "/VO/ZagreusHome_2059" },
		},

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Father always said if I wanted privileged access again, I'd have to earn it.
				{ Cue = "/VO/ZagreusHome_2060" },
			},
			{
				PreLineWait = 0.6,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Do not touch anything again in the administrative chamber.
				{ Cue = "/VO/Hades_0831" },
			},
		},

	},

	OrpheusUnlockItem =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "KeyItem_SealedDoc",
		ResourceName = "SuperGems",
		ResourceCost = 1,
		GameStateRequirements =
		{
			RequiredCosmetics =
			{
				"QuestLog",	"TartarusReprieve",
			},
			RequiredSeenRooms = { "B_Intro", },
			RequiredTextLines = { "HadesAboutOrpheusUnlockItem01" },
		},
		SetPlayerAnimation = "ZagreusTalkDenial_Full",
		PreActivateFunctionName = "GenericPresentation",
		PreActivateFunctionArgs =
		{
			DisableIds = { 391025 },
		},
		ItemPreActivationVfx = "EnemySummonRune",
		DeathAreaFocusId = 426764, -- Orpheus' chair
		ActivateUnits = { 390000, },
		FadeInDuration = 2.0,
		PreActivationHoldDuration = 4,
		PostActivationHoldDuration = 5,
		DoVerticalPan = false,
		UseUnlockText = false,
		UnlockTextId = "GhostAdminUnlock_KeyItem",
		SkipFade = true,
		SkipPurchaseGlobalVoiceLines = true,
		SkipRevealReactionGlobalVoiceLines = true,

		OfferedVoiceLines =
		{
			PreLineWait = 0.5,
			PlayOnce = true,
			PlayOnceContext = "FoundOrpheusContract",

			-- Hey that's the Court Musician's sentence, long past due...
			{ Cue = "/VO/ZagreusHome_1587", RequiredFalseTextLinesThisRun = { "HadesAboutOrpheusUnlockItem01" }, },
			-- There we go!
			{ Cue = "/VO/ZagreusHome_0143", RequiredTextLinesThisRun = "HadesAboutOrpheusUnlockItem01" },
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- In the name of Hades, I commute our court musician's sentencing, effective now!
				{ Cue = "/VO/ZagreusHome_3573", PreLineThreadedFunctionName = "PowerWordPresentationWorld", PreLineThreadedFunctionArgs = { WaitTime = 1.5 }, },
			},
			{
				PreLineWait = 0.88,
				ObjectType = "NPC_Orpheus_01",
				-- Oh, um, hello.
				{ Cue = "/VO/Orpheus_0064" },
			},
			{
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Ah, Orpheus.
				{ Cue = "/VO/Hades_0830" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	SisyphusQuestItem =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "KeyItem_SealedDoc",
		GameStateRequirements =
		{
			RequiredTextLines = { "Inspect_DeathAreaOffice_SealedContract_01" },
			-- RequiredFalseTextLinesThisRun = { "Inspect_DeathAreaOffice_SealedContract_01" }
		},
		ResourceName = "SuperGems",
		ResourceCost = 4,
		UseUnlockText = true,
		UnlockTextId = "GhostAdminUnlock_KeyItem",
		SetPlayerAnimation = "ZagreusTalkDenial_Full",

		OfferedVoiceLines =
		{
			CooldownTime = 200,
			PreLineWait = 0.45,
			PlayOnce = true,

			-- A sealed document, regarding Sisyphus?
			-- { Cue = "/VO/ZagreusHome_1586" },
			-- The Sisyphus contract. I can buy it out...
			{ Cue = "/VO/ZagreusHome_2313" },
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- In the name of Hades, I hereby release Sisyphus from the terms of his pact!
				{ Cue = "/VO/ZagreusHome_2317", PreLineThreadedFunctionName = "PowerWordPresentationWorld", PreLineThreadedFunctionArgs = { WaitTime = 1.5 }, },
			},
			{
				PreLineWait = 0.5,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You what? All this, just for that wretched shade.
				{ Cue = "/VO/Hades_0845" },
			},
		},
		-- RevealReactionGlobalVoiceLines = "HadesGhostAdminPurchaseReactionVoiceLines",
		SkipRevealReactionGlobalVoiceLines = true,
	},

	-- singersreunionquest
	OrpheusEurydiceQuestItem =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "KeyItem_SealedDoc",
		GameStateRequirements =
		{
			RequiredTextLines = { "Inspect_DeathAreaOffice_SealedContract_02" },
			-- RequiredFalseTextLinesThisRun = { "Inspect_DeathAreaOffice_SealedContract_02" },
		},
		ResourceName = "SuperGems",
		ResourceCost = 3,
		UseUnlockText = true,
		UnlockTextId = "GhostAdminUnlock_KeyItem",
		SetPlayerAnimation = "ZagreusTalkDenial_Full",

		OfferedVoiceLines =
		{
			CooldownTime = 200,
			PreLineWait = 0.45,
			PlayOnce = true,

			-- Orpheus' contract. I can release him...
			{ Cue = "/VO/ZagreusHome_2315" },
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- In the name of Hades, I hereby release Orpheus from the terms of his pact!
				{ Cue = "/VO/ZagreusHome_2318", PreLineThreadedFunctionName = "PowerWordPresentationWorld", PreLineThreadedFunctionArgs = { WaitTime = 1.5 }, },
			},
			{
				PreLineWait = 0.5,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- What, where did you unearth that blasted contract?
				{ Cue = "/VO/Hades_0846" },
			},
		},
		-- RevealReactionGlobalVoiceLines = "HadesGhostAdminPurchaseReactionVoiceLines",
		SkipRevealReactionGlobalVoiceLines = true,
	},

	-- myrmidonreunionquest
	AchillesPatroclusQuestItem =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "KeyItem_SealedDoc",
		GameStateRequirements =
		{
			RequiredTextLines = { "Inspect_DeathAreaOffice_SealedContract_03" },
			-- RequiredFalseTextLinesThisRun = { "Inspect_DeathAreaOffice_SealedContract_03" },
		},
		ResourceName = "SuperGems",
		ResourceCost = 5,
		UseUnlockText = true,
		UnlockTextId = "GhostAdminUnlock_KeyItem",
		SetPlayerAnimation = "ZagreusTalkDenial_Full",

		OfferedVoiceLines =
		{
			CooldownTime = 200,
			PreLineWait = 0.45,
			PlayOnce = true,

			-- It's the revised Achilles Pact...
			{ Cue = "/VO/ZagreusHome_2571" },
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- In the name of Hades, the shade of Achilles is hereby no longer barred from visiting Elysium!
				{ Cue = "/VO/ZagreusHome_2572", PreLineThreadedFunctionName = "PowerWordPresentationWorld", PreLineThreadedFunctionArgs = { WaitTime = 1.5 }, },
			},
			{
				PreLineWait = 0.5,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Such leniency with binding pacts shall tarnish our good reputation at this rate.
				{ Cue = "/VO/Hades_0862" },
			},
		},
		-- RevealReactionGlobalVoiceLines = "HadesGhostAdminPurchaseReactionVoiceLines",
		SkipRevealReactionGlobalVoiceLines = true,
	},

	-- nyxchaosreunionquest
	NyxQuestItem =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "KeyItem_Transporter",
		GameStateRequirements =
		{
			RequiredTextLines = { "NyxAboutChaos06" },
			RequiredFalseTextLinesThisRun = { "NyxAboutChaos06" },
		},
		ResourceName = "MetaPoints",
		ResourceCost = 3142,
		UnlockTextId = "GhostAdminUnlock_KeyItem",
		SetPlayerAnimation = "ZagreusTalkDenial_Full",

		UsePanSound = true,
		UseReturnPanSound = true,
		DeathAreaFocusId = 421122, -- southwest hall
		PreActivationHoldDuration = 3,
		PostActivationHoldDuration = 3,
		DoVerticalPan = false,
		UseUnlockText = false,
		-- SkipFade = false,
		UseItemActivationVfx = true,
		ItemActivationVfxId = 393488,
		ItemActivationVfxOffsetY = -300,
		SkipPurchaseGlobalVoiceLines = true,
		SkipRevealReactionGlobalVoiceLines = true,

		-- ActivateNames = "HouseTerrainTransporterBlood",
		-- ConnectedIds = { 488349, 488348, }

		OfferedVoiceLines =
		{
			CooldownTime = 200,
			PreLineWait = 0.45,
			PlayOnce = true,

			-- There's Nyx's work order...
			{ Cue = "/VO/ZagreusHome_2301" },
		},
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- House Contractor? With this gift of Darkness, I decree the Eldest Sigil shall be restored!
				{ Cue = "/VO/ZagreusHome_3129", PreLineThreadedFunctionName = "PowerWordPresentationWorld", PreLineThreadedFunctionArgs = { WaitTime = 4.5 }, },
			},
			{
				PreLineWait = 0.5,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You waste your time; the Sigil shall never work for you.
				{ Cue = "/VO/Hades_0859" },
			},
			{
				PreLineWait = 0.5,
				ObjectType = "NPC_Nyx_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- How very thoughtful, child.
				{ Cue = "/VO/Nyx_0245" },
			},
		},
		-- RevealReactionGlobalVoiceLines = "HadesGhostAdminPurchaseReactionVoiceLines",
	},

	Cosmetic_MusicPlayer =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "KeyItem_MusicStand",
		GameStateRequirements =
		{
			RequiredCosmeticsAdded = { "HouseWaterBowl01" },
			RequiredAnyTextLines = { "OrpheusFirstMeeting", "OrpheusFirstMeeting_Alt" },
			RequiredFalseTextLinesThisRun = { "OrpheusFirstMeeting", "OrpheusFirstMeeting_Alt" },
		},
		ActivateObstacles =
		{
			[424035] =
			{
				-- MusicPlayer
				Name = "MusicPlayer",
				InteractDistance = 200,
				UseText = "UseMusicPlayer",
				OnUsedFunctionName = "UseMusicPlayer",
			}
		},
		DeathAreaFocusId = 424984,
		ResourceName = "SuperGems",
		ResourceCost = 1,
		Removable = false,

		UsePanSound = true,
		UseReturnPanSound = true,
		PreActivationHoldDuration = 3,
		PostActivationHoldDuration = 3,
		DoVerticalPan = false,
		UseUnlockText = false,
		SkipFade = false,
		UseItemActivationVfx = true,
		ItemActivationVfxId = 424035,
		ItemActivationVfxOffsetX = -100,
		SkipPurchaseGlobalVoiceLines = true,
		SkipRevealReactionGlobalVoiceLines = true,

		OfferedVoiceLines =
		{
			PreLineWait = 0.5,
			PlayOnce = true,

			-- Hey that's new...
			{ Cue = "/VO/ZagreusHome_3522" },
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- This ought to help Orpheus keep his boundless libraries of music in order. Just have to fill it in.
				{ Cue = "/VO/ZagreusHome_1091" },
			},
			{
				ObjectType = "NPC_Orpheus_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Oh, my...
				{ Cue = "/VO/Orpheus_0156" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Our court musician need not be so indulged.
				{ Cue = "/VO/Hades_0531" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_UISkinDefault =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "UISkin_Default",
		RotateOnly = true,
		GameStateRequirements =
		{
			RequiredCosmetics = { "UnusedWeaponBonusAddGems", "BossAddGems", "GemDropRunProgress", "RoomRewardMetaPointDropRunProgress", "LockKeyDropRunProgress", "GiftDropRunProgress" },
			RequiredLifetimeResourcesSpentMin = { Gems = 5000, SuperLockKeys = 30 },
			RequiredLifetimeResourcesGainedMin = { MetaPoints = 15000 },
		},
		
		SortName = "UISkins",
		IgnoreAffordable = true,
		ResourceName = "SuperGems",
		ResourceCost = 1,
		RemoveCosmetics =
		{
			"Cosmetic_UISkinArtemis",
			"Cosmetic_UISkinChaos",
			"Cosmetic_UISkinHades",
			"Cosmetic_UISkinBlood",
			"Cosmetic_UISkinHeat",
			"Cosmetic_UISkinLove",
			"Cosmetic_UISkinChthonic",
			"Cosmetic_UISkinStone",
			"Cosmetic_UISkinOrphic",
		},
		Removable = true,
		RemoveGlobalVoiceLines = "CosmeticRemovedVoiceLines",
		ReEquipGlobalVoiceLines = "CosmeticReAddedVoiceLines",
	},

	Cosmetic_UISkinArtemis =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "UISkin_Woodland",
		RotateOnly = true,
		SetPlayerAnimation = "ZagreusTalkDenial_Full",
		GameStateRequirements =
		{
			RequiredCosmetics = { "UnusedWeaponBonusAddGems", "BossAddGems", "GemDropRunProgress", "RoomRewardMetaPointDropRunProgress", "LockKeyDropRunProgress", "GiftDropRunProgress" },
			RequiredLifetimeResourcesSpentMin = { Gems = 5000, SuperLockKeys = 30 },
			RequiredLifetimeResourcesGainedMin = { MetaPoints = 15000 },
		},
		
		SortName = "UISkins",
		IgnoreAffordable = true,
		ResourceName = "GiftPoints",
		ResourceCost = 100,
		RemoveCosmetics =
		{
			"Cosmetic_UISkinDefault",
			"Cosmetic_UISkinChaos",
			"Cosmetic_UISkinHades",
			"Cosmetic_UISkinBlood",
			"Cosmetic_UISkinHeat",
			"Cosmetic_UISkinLove",
			"Cosmetic_UISkinChthonic",
			"Cosmetic_UISkinStone",
			"Cosmetic_UISkinOrphic",
		},
		Removable = true,
		RemoveGlobalVoiceLines = "CosmeticRemovedVoiceLines",
		ReEquipGlobalVoiceLines = "CosmeticReAddedVoiceLines",

		OfferedVoiceLines =
		{
			PreLineWait = 0.5,
			PlayOnce = true,
			PlayOnceContext = "UISkinsAvailable",

			-- Hoh, what's this.
			{ Cue = "/VO/ZagreusField_1470" },
		},

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- This style reminds me of the surface. Good motivating factor!
				{ Cue = "/VO/ZagreusHome_3557" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You spend exorbitant resources on festoonery?
				{ Cue = "/VO/Hades_1164" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

		TraitBacking = "TraitTray_Slots_6_Artemis",
		TraitBackingDecor = "TraitTrayDecor_Artemis",
		TraitTrayTop = "TraitTrayTop_Artemis",
		TraitTrayBottom = "TraitTrayBottom_Artemis",
		ShrineUpgradeBacking = "ShrineIconBacking_ArtemisTop",
		MetaUpgradeBacking = "ShrineIconBacking_ArtemisBottom",
		RunClearScreenBacking = "EndPanelBox_Artemis",
	},

	Cosmetic_UISkinChthonic =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "UISkin_Chthonic",
		RotateOnly = true,
		SetPlayerAnimation = "ZagreusTalkDenial_Full",
		GameStateRequirements =
		{
			RequiredCosmetics = { "UnusedWeaponBonusAddGems", "BossAddGems", "GemDropRunProgress", "RoomRewardMetaPointDropRunProgress", "LockKeyDropRunProgress", "GiftDropRunProgress" },
			RequiredLifetimeResourcesSpentMin = { Gems = 5000, SuperLockKeys = 30 },
			RequiredLifetimeResourcesGainedMin = { MetaPoints = 15000 },
		},
		
		SortName = "UISkins",
		IgnoreAffordable = true,
		ResourceName = "LockKeys",
		ResourceCost = 200,
		RemoveCosmetics =
		{
			"Cosmetic_UISkinDefault",
			"Cosmetic_UISkinArtemis",
			"Cosmetic_UISkinChaos",
			"Cosmetic_UISkinHades",
			"Cosmetic_UISkinBlood",
			"Cosmetic_UISkinHeat",
			"Cosmetic_UISkinStone",
			"Cosmetic_UISkinLove",
			"Cosmetic_UISkinOrphic",
		},
		Removable = true,
		RemoveGlobalVoiceLines = "CosmeticRemovedVoiceLines",
		ReEquipGlobalVoiceLines = "CosmeticReAddedVoiceLines",

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Have to admit, this style really suits me, right?
				{ Cue = "/VO/ZagreusHome_3555" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- I'll have no part in paying for such things.
				{ Cue = "/VO/Hades_1168" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

		TraitBacking = "TraitTray_Slots_6_Chthonic",
		TraitBackingDecor = "TraitTrayDecor_Chthonic",
		TraitTrayTop = "TraitTrayTop_Chthonic",
		TraitTrayBottom = "TraitTrayBottom_Chthonic",
		ShrineUpgradeBacking = "ShrineIconBacking_ChthonicTop",
		MetaUpgradeBacking = "ShrineIconBacking_ChthonicBottom",
		RunClearScreenBacking = "EndPanelBox_Chthonic",
	},

	Cosmetic_UISkinHades =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "UISkin_Hades",
		RotateOnly = true,
		SetPlayerAnimation = "ZagreusTalkDenial_Full",
		GameStateRequirements =
		{
			RequiredCosmetics = { "UnusedWeaponBonusAddGems", "BossAddGems", "GemDropRunProgress", "RoomRewardMetaPointDropRunProgress", "LockKeyDropRunProgress", "GiftDropRunProgress" },
			RequiredLifetimeResourcesSpentMin = { Gems = 5000, SuperLockKeys = 30 },
			RequiredLifetimeResourcesGainedMin = { MetaPoints = 15000 },
		},
		
		SortName = "UISkins",
		IgnoreAffordable = true,
		ResourceName = "Gems",
		ResourceCost = 5000,
		RemoveCosmetics =
		{
			"Cosmetic_UISkinDefault",
			"Cosmetic_UISkinArtemis",
			"Cosmetic_UISkinChaos",
			"Cosmetic_UISkinBlood",
			"Cosmetic_UISkinHeat",
			"Cosmetic_UISkinLove",
			"Cosmetic_UISkinChthonic",
			"Cosmetic_UISkinStone",
			"Cosmetic_UISkinOrphic",
		},
		Removable = true,
		RemoveGlobalVoiceLines = "CosmeticRemovedVoiceLines",
		ReEquipGlobalVoiceLines = "CosmeticReAddedVoiceLines",

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- This style's a bit formal for my tastes, but I can get used to it!
				{ Cue = "/VO/ZagreusHome_3558" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You wish to throw away your gemstones, fine by me.
				{ Cue = "/VO/Hades_1167" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

		TraitBacking = "TraitTray_Slots_6_Hades",
		TraitBackingDecor = "TraitTrayDecor_Hades",
		TraitTrayTop = "TraitTrayTop_Hades",
		TraitTrayBottom = "TraitTrayBottom_Hades",
		ShrineUpgradeBacking = "ShrineIconBacking_HadesTop",
		MetaUpgradeBacking = "ShrineIconBacking_HadesBottom",
		RunClearScreenBacking = "EndPanelBox_Hades",
	},

	Cosmetic_UISkinHeat =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "UISkin_Heat",
		RotateOnly = true,
		SetPlayerAnimation = "ZagreusTalkDenial_Full",
		GameStateRequirements =
		{
			RequiredCosmetics = { "UnusedWeaponBonusAddGems", "BossAddGems", "GemDropRunProgress", "RoomRewardMetaPointDropRunProgress", "LockKeyDropRunProgress", "GiftDropRunProgress" },
			RequiredLifetimeResourcesSpentMin = { Gems = 5000, SuperLockKeys = 30 },
			RequiredLifetimeResourcesGainedMin = { MetaPoints = 15000 },
		},
		
		SortName = "UISkins",
		IgnoreAffordable = true,
		ResourceName = "SuperGems",
		ResourceCost = 10,
		RemoveCosmetics =
		{
			"Cosmetic_UISkinDefault",
			"Cosmetic_UISkinArtemis",
			"Cosmetic_UISkinChaos",
			"Cosmetic_UISkinHades",
			"Cosmetic_UISkinChthonic",
			"Cosmetic_UISkinBlood",
			"Cosmetic_UISkinStone",
			"Cosmetic_UISkinLove",
			"Cosmetic_UISkinOrphic",
		},
		Removable = true,
		RemoveGlobalVoiceLines = "CosmeticRemovedVoiceLines",
		ReEquipGlobalVoiceLines = "CosmeticReAddedVoiceLines",

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- They say this one's the hottest style this side of Elysium.
				{ Cue = "/VO/ZagreusHome_3725" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Who are these self-appointed judges, I would like to know!
				{ Cue = "/VO/Hades_1204" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

		TraitBacking = "TraitTray_Slots_6_Heat",
		TraitBackingDecor = "TraitTrayDecor_Heat",
		TraitTrayTop = "TraitTrayTop_Heat",
		TraitTrayBottom = "TraitTrayBottom_Heat",
		ShrineUpgradeBacking = "ShrineIconBacking_HeatTop",
		MetaUpgradeBacking = "ShrineIconBacking_HeatBottom",
		RunClearScreenBacking = "EndPanelBox_Heat",
	},

	Cosmetic_UISkinStone =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "UISkin_Stone",
		RotateOnly = true,
		SetPlayerAnimation = "ZagreusTalkDenial_Full",
		GameStateRequirements =
		{
			RequiredCosmetics = { "UnusedWeaponBonusAddGems", "BossAddGems", "GemDropRunProgress", "RoomRewardMetaPointDropRunProgress", "LockKeyDropRunProgress", "GiftDropRunProgress" },
			RequiredLifetimeResourcesSpentMin = { Gems = 5000, SuperLockKeys = 30 },
			RequiredLifetimeResourcesGainedMin = { MetaPoints = 15000 },
		},
		
		SortName = "UISkins",
		IgnoreAffordable = true,
		ResourceName = "SuperLockKeys",
		ResourceCost = 10,
		RemoveCosmetics =
		{
			"Cosmetic_UISkinDefault",
			"Cosmetic_UISkinArtemis",
			"Cosmetic_UISkinChaos",
			"Cosmetic_UISkinHades",
			"Cosmetic_UISkinChthonic",
			"Cosmetic_UISkinBlood",
			"Cosmetic_UISkinHeat",
			"Cosmetic_UISkinLove",
			"Cosmetic_UISkinOrphic",
		},
		Removable = true,
		RemoveGlobalVoiceLines = "CosmeticRemovedVoiceLines",
		ReEquipGlobalVoiceLines = "CosmeticReAddedVoiceLines",

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- This style seems appropriately grim for the job, I think
				{ Cue = "/VO/ZagreusHome_3726" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Are you quite finished with your decorating yet?
				{ Cue = "/VO/Hades_1205" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

		TraitBacking = "TraitTray_Slots_6_Stone",
		TraitBackingDecor = "TraitTrayDecor_Stone",
		TraitTrayTop = "TraitTrayTop_Stone",
		TraitTrayBottom = "TraitTrayBottom_Stone",
		ShrineUpgradeBacking = "ShrineIconBacking_StoneTop",
		MetaUpgradeBacking = "ShrineIconBacking_StoneBottom",
		RunClearScreenBacking = "EndPanelBox_Stone",
	},

	Cosmetic_UISkinLove =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "UISkin_Love",
		RotateOnly = true,
		SetPlayerAnimation = "ZagreusTalkDenial_Full",
		GameStateRequirements =
		{
			RequiredCosmetics = { "UnusedWeaponBonusAddGems", "BossAddGems", "GemDropRunProgress", "RoomRewardMetaPointDropRunProgress", "LockKeyDropRunProgress", "GiftDropRunProgress" },
			RequiredLifetimeResourcesSpentMin = { Gems = 5000, SuperLockKeys = 30 },
			RequiredLifetimeResourcesGainedMin = { MetaPoints = 15000 },
		},
		
		SortName = "UISkins",
		IgnoreAffordable = true,
		ResourceName = "SuperGiftPoints",
		ResourceCost = 15,
		RemoveCosmetics =
		{
			"Cosmetic_UISkinDefault",
			"Cosmetic_UISkinArtemis",
			"Cosmetic_UISkinHades",
			"Cosmetic_UISkinBlood",
			"Cosmetic_UISkinHeat",
			"Cosmetic_UISkinChthonic",
			"Cosmetic_UISkinStone",
			"Cosmetic_UISkinChaos",
			"Cosmetic_UISkinOrphic",
		},
		Removable = true,
		RemoveGlobalVoiceLines = "CosmeticRemovedVoiceLines",
		ReEquipGlobalVoiceLines = "CosmeticReAddedVoiceLines",

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Soon as I saw this lovely style, I knew I had to have it!
				{ Cue = "/VO/ZagreusHome_3560" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- It would be lovely if you let me work in peace!
				{ Cue = "/VO/Hades_1206" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

		TraitBacking = "TraitTray_Slots_6_Love",
		TraitBackingDecor = "TraitTrayDecor_Love",
		TraitTrayTop = "TraitTrayTop_Love",
		TraitTrayBottom = "TraitTrayBottom_Love",
		ShrineUpgradeBacking = "ShrineIconBacking_LoveTop",
		MetaUpgradeBacking = "ShrineIconBacking_LoveBottom",
		RunClearScreenBacking = "EndPanelBox_Love",
	},

	Cosmetic_UISkinChaos =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "UISkin_Chaos",
		RotateOnly = true,
		SetPlayerAnimation = "ZagreusTalkDenial_Full",
		GameStateRequirements =
		{
			RequiredCosmetics = { "UnusedWeaponBonusAddGems", "BossAddGems", "GemDropRunProgress", "RoomRewardMetaPointDropRunProgress", "LockKeyDropRunProgress", "GiftDropRunProgress" },
			RequiredLifetimeResourcesSpentMin = { Gems = 5000, SuperLockKeys = 30 },
			RequiredLifetimeResourcesGainedMin = { MetaPoints = 15000 },
		},
		
		SortName = "UISkins",
		IgnoreAffordable = true,
		ResourceName = "MetaPoints",
		ResourceCost = 25000,
		RemoveCosmetics =
		{
			"Cosmetic_UISkinDefault",
			"Cosmetic_UISkinArtemis",
			"Cosmetic_UISkinHades",
			"Cosmetic_UISkinBlood",
			"Cosmetic_UISkinHeat",
			"Cosmetic_UISkinLove",
			"Cosmetic_UISkinChthonic",
			"Cosmetic_UISkinStone",
			"Cosmetic_UISkinOrphic",
		},
		Removable = true,
		RemoveGlobalVoiceLines = "CosmeticRemovedVoiceLines",
		ReEquipGlobalVoiceLines = "CosmeticReAddedVoiceLines",

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I'd like to think Master Chaos would approve of this style.
				{ Cue = "/VO/ZagreusHome_3559" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Your resources to waste the way you please.
				{ Cue = "/VO/Hades_1169" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

		TraitBacking = "TraitTray_Slots_6_Chaos",
		TraitBackingDecor = "TraitTrayDecor_Chaos",
		TraitTrayTop = "TraitTrayTop_Chaos",
		TraitTrayBottom = "TraitTrayBottom_Chaos",
		ShrineUpgradeBacking = "ShrineIconBacking_ChaosTop",
		MetaUpgradeBacking = "ShrineIconBacking_ChaosBottom",
		RunClearScreenBacking = "EndPanelBox_Chaos",
	},

	Cosmetic_UISkinOrphic =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "UISkin_Music",
		RotateOnly = true,
		SetPlayerAnimation = "ZagreusTalkDenial_Full",
		GameStateRequirements =
		{
			RequiredCosmetics = { "UnusedWeaponBonusAddGems", "BossAddGems", "GemDropRunProgress", "RoomRewardMetaPointDropRunProgress", "LockKeyDropRunProgress", "GiftDropRunProgress" },
			RequiredLifetimeResourcesSpentMin = { Gems = 5000, SuperLockKeys = 30 },
			RequiredLifetimeResourcesGainedMin = { MetaPoints = 15000 },
		},
		
		SortName = "UISkins",
		IgnoreAffordable = true,
		ResourceName = "SuperGiftPoints",
		ResourceCost = 10,
		RemoveCosmetics =
		{
			"Cosmetic_UISkinDefault",
			"Cosmetic_UISkinArtemis",
			"Cosmetic_UISkinHades",
			"Cosmetic_UISkinBlood",
			"Cosmetic_UISkinHeat",
			"Cosmetic_UISkinLove",
			"Cosmetic_UISkinChthonic",
			"Cosmetic_UISkinStone",
			"Cosmetic_UISkinChaos",
		},
		Removable = true,
		RemoveGlobalVoiceLines = "CosmeticRemovedVoiceLines",
		ReEquipGlobalVoiceLines = "CosmeticReAddedVoiceLines",

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I rather like this style, so let's go ahead and make it official.
				{ Cue = "/VO/ZagreusHome_3556" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- To trifles such as that, in times such as these!
				{ Cue = "/VO/Hades_1166" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

		TraitBacking = "TraitTray_Slots_6_Music",
		TraitBackingDecor = "TraitTrayDecor_Music",
		TraitTrayTop = "TraitTrayTop_Music",
		TraitTrayBottom = "TraitTrayBottom_Music",
		ShrineUpgradeBacking = "ShrineIconBacking_MusicTop",
		MetaUpgradeBacking = "ShrineIconBacking_MusicBottom",
		RunClearScreenBacking = "EndPanelBox_Music",
	},

	-- cut themes; they did not pass muster according to the House Contractor
	Cosmetic_UISkinBlood =
	{
		InheritFrom = { "DefaultCriticalItem" },
		Icon = "KeyItem_MusicStand",
		RotateOnly = true,
		DebugOnly = true,
		GameStateRequirements =
		{
			RequiredCosmetics = { "UnusedWeaponBonusAddGems", "BossAddGems", "GemDropRunProgress", "RoomRewardMetaPointDropRunProgress", "LockKeyDropRunProgress", "GiftDropRunProgress" },
			RequiredLifetimeResourcesSpentMin = { Gems = 5000, SuperLockKeys = 30 },
			RequiredLifetimeResourcesGainedMin = { MetaPoints = 15000 },
		},
		
		SortName = "UISkins",
		IgnoreAffordable = true,
		ResourceName = "SuperLockKeys",
		ResourceCost = 25,
		RemoveCosmetics =
		{
			"Cosmetic_UISkinDefault",
			"Cosmetic_UISkinArtemis",
			"Cosmetic_UISkinChaos",
			"Cosmetic_UISkinHades",
			"Cosmetic_UISkinHeat",
			"Cosmetic_UISkinLove",
			"Cosmetic_UISkinChthonic",
			"Cosmetic_UISkinStone",
			"Cosmetic_UISkinOrphic",
		},
		Removable = true,
		RemoveGlobalVoiceLines = "CosmeticRemovedVoiceLines",
		ReEquipGlobalVoiceLines = "CosmeticReAddedVoiceLines",

		PlayPurchaseGlobalVoiceLines = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I rather like this style, so let's go ahead and make it official.
				{ Cue = "/VO/ZagreusHome_3556" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- To trifles such as that, in times such as these!
				{ Cue = "/VO/Hades_1166" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

		TraitBacking = "TraitTray_Slots_6_Blood",
		TraitBackingDecor = "TraitTrayDecor_Blood",
		TraitTrayTop = "TraitTrayTop_Blood",
		TraitTrayBottom = "TraitTrayBottom_Blood",
		ShrineUpgradeBacking = "ShrineIconBacking_BloodTop",
		MetaUpgradeBacking = "ShrineIconBacking_BloodBottom",
		RunClearScreenBacking = "EndPanelBox_Blood",
	},

	HousePoster01 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Slot = "CosmeticBedroom",
		Icon = "Cosmetic_AchillesPoster",
		InspectPoint = 421071,
		DeathAreaFocusId = 424948, -- zag's bedroom doorway
		ActivateNames = "HousePoster01",
		ResourceName = "Gems",
		ResourceCost = 60,
		SkipFade = true,
		GameStateRequirements =
		{
			RequiredMinNPCInteractions = { NPC_Achilles_01 = 1 },
			RequiredCosmeticsAdded = { "HouseWaterBowl01" },
		},
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- If I'm to keep seeing my chamber walls, they might as well not be completely barren.
				{ Cue = "/VO/ZagreusHome_1068" },

			},
			{
				PreLineWait = 0.75,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Why don't you clean your chambers rather than adorn them?
				{ Cue = "/VO/Hades_0509" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	HousePoster02 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Slot = "CosmeticBedroom",
		Icon = "Cosmetic_AphroditePoster",
		InspectPoint = 421070,
		DeathAreaFocusId = 424948, -- zag's bedroom doorway
		ResourceName = "Gems",
		ResourceCost = 90,
		ActivateNames = "HousePoster02",
		SkipFade = true,
		GameStateRequirements =
		{
			RequiredTextLines = { "AphroditeGift02" },
			RequiredCosmeticsAdded = { "HouseWaterBowl01" },
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Hey, they're my bedchambers, I can have whatever wall-scrolls I want.
				{ Cue = "/VO/ZagreusHome_1069" },

			},
			{
				PreLineWait = 0.75,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- If that is how you wish to spend your wealth.
				{ Cue = "/VO/Hades_0520" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	HousePoster05 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Slot = "CosmeticBedroom",
		Icon = "Cosmetic_DionysusPoster",
		InspectPoint = 555811,
		DeathAreaFocusId = 424948, -- zag's bedroom doorway
		ResourceName = "Gems",
		ResourceCost = 80,
		ActivateNames = "HousePoster05",
		SkipFade = true,
		GameStateRequirements =
		{
			RequiredTextLines = { "DionysusGift02" },
			RequiredCosmeticsAdded = { "HouseWaterBowl01" },
			--RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- My mate Lord Dionysus can inspire me to keep a bright and healthy attitude toward life.
				{ Cue = "/VO/ZagreusHome_2833" },
			},
			{
				PreLineWait = 0.5,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Hahaha, healthy attitude? From him?
				{ Cue = "/VO/Hades_1045", PreLineAnim = "Hades_HouseWryLaugh" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	HouseDagger01 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Slot = "CosmeticBedroom",
		Icon = "CosmeticIcon_WeaponSet",
		ConnectedIds = { 310039, 310038 },
		InspectPoint = 421072,
		DeathAreaFocusId = 424948, -- zag's bedroom doorway
		ResourceName = "Gems",
		ResourceCost = 200,
		ActivateNames = "HouseDagger01",
		SkipFade = true,
		GameStateRequirements =
		{
			RequiredCosmeticsAdded = { "HouseWaterBowl01" },
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},

		RevealVoiceLines =
		{
			PreLineWait = 0.45,
			-- Should help make my messy chambers even messier.
			{ Cue = "/VO/ZagreusHome_1070" },
		},
		RevealReactionGlobalVoiceLines = "HadesGhostAdminPurchaseReactionVoiceLines",
	},

	-- scrying pool
	HouseWaterBowl01 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Slot = "CosmeticBedroom",
		Icon = "CosmeticIcon_WaterBowl",
		ActivateNames = "HouseWaterBowl01",
		ConnectedIds = { 390314, 390224, 390227 },
		InspectPoint = 421074,
		DeathAreaFocusId = 424948, -- zag's bedroom doorway
		ResourceName = "Gems",
		ResourceCost = 10,
		SkipFade = true,

		RevealVoiceLines =
		{
			PreLineWait = 0.45,
			-- Should make a nice enough addition to my chambers.
			{ Cue = "/VO/ZagreusHome_1071" },
		},
		RevealReactionGlobalVoiceLines = "HadesGhostAdminPurchaseReactionVoiceLines",
	},

	HouseLyre01 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Slot = "CosmeticBedroom",
		Icon = "CosmeticIcon_Lyre",
		ActivateNames = "HouseLyre01",
		ToggleCollision = true,
		InspectPoint = 426224,
		DeathAreaFocusId = 424948, -- zag's bedroom doorway
		ResourceName = "SuperGems",
		ResourceCost = 1,
		SkipFade = true,
		GameStateRequirements =
		{
			RequiredCosmetics = { "OrpheusUnlockItem" },
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
			RequiredTextLines = { "OrpheusAboutMusicPlaying01" },
		},

		RevealVoiceLines =
		{
			PreLineWait = 0.45,
			-- Least we have a backup singer if we need one.
			{ Cue = "/VO/ZagreusHome_0992" },
		},
		RevealReactionGlobalVoiceLines = "HadesGhostAdminPurchaseReactionVoiceLines",
	},

	HouseBed01a =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Slot = "CosmeticBedroom",
		Icon = "CosmeticIcon_BedA",
		ActivateNames = "HouseBed01a",
		ToggleCollision = true,
		InspectPoint = 555810,
		DeactivateIds = { 310036, },
		DeathAreaFocusId = 424948, -- zag's bedroom doorway
		ResourceName = "Gems",
		ResourceCost = 150,
		SkipFade = true,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
			RequiredTextLines = { "Flashback_DayNightJob_01" },
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Think I've outgrown my other bed, not that there's been a lot of time for sleep of late.
				{ Cue = "/VO/ZagreusHome_2834" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You do not need another blasted bed!
				{ Cue = "/VO/Hades_1046" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_HousePillars =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_Pillar_Olympic",
		SetAnimations =
		{
			HousePillar05 = "HousePillar04B",
		},
		DeathAreaFocusId = 424959,
		AddConstructionPresentation = true,
		ResourceName = "Gems",
		ResourceCost = 800,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		RemoveCosmetics =
		{
			"Cosmetic_HousePillarsA",
			"Cosmetic_HousePillarsB",
		},
		RotateOnly = true,

		RevealVoiceLines =
		{
			PreLineWait = 0.45,
			-- Anything to liven things up even the slightest bit around here.
			{ Cue = "/VO/ZagreusHome_1074" },
		},
		RevealReactionGlobalVoiceLines = "HadesGhostAdminPurchaseReactionVoiceLines",
		ReEquipGlobalVoiceLines = "ColumnsReAddedVoiceLines",
	},

	Cosmetic_HousePillarsA =
	{
		InheritFrom = { "DefaultCosmeticItem", },
		Icon = "Cosmetic_Pillar_Chthonic",
		SetAnimations =
		{
			HousePillar05 = "HousePillar04A",
		},
		DeathAreaFocusId = 424959,
		AddConstructionPresentation = true,
		ResourceName = "Gems",
		ResourceCost = 800,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		RemoveCosmetics =
		{
			"Cosmetic_HousePillars",
			"Cosmetic_HousePillarsB",
		},
		RotateOnly = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I think those columns still could use some sprucing up.
				{ Cue = "/VO/ZagreusHome_1759" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- The columns were just fine the way they were.
				{ Cue = "/VO/Hades_0676" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
		ReEquipGlobalVoiceLines = "ColumnsReAddedVoiceLines",
	},

	Cosmetic_HousePillarsB =
	{
		InheritFrom = { "DefaultCosmeticItem", },
		Icon = "Cosmetic_Pillar_Ornate",
		SetAnimations =
		{
			HousePillar05 = "HousePillar04",
		},
		InspectPoint = 424958,
		DeathAreaFocusId = 424959,
		AddConstructionPresentation = true,
		ResourceName = "Gems",
		ResourceCost = 800,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		RemoveCosmetics =
		{
			"Cosmetic_HousePillars",
			"Cosmetic_HousePillarsA",
		},
		RotateOnly = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Was thinking it'd be good to change those columns up a bit.
				{ Cue = "/VO/ZagreusHome_1760" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Those columns are for function not for show!
				{ Cue = "/VO/Hades_0677" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
		ReEquipGlobalVoiceLines = "ColumnsReAddedVoiceLines",
	},

	Cosmetic_NorthHallMirror =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_NorthHallMirror_01",
		ResourceName = "Gems",
		ResourceCost = 140,
		ActivateIds = { 425144, 425415, 425416, 425417 },
		DeathAreaFocusId = 425144,
		GameStateRequirements =
		{
			RequiredCosmeticsAdded = { "HouseWaterBowl01" },
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
			RequiredAnyTextLines = { "AchillesGift04", "AchillesGift04_A" },
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- If anybody needs to see their own reflection down the hall, well, now they can!
				{ Cue = "/VO/ZagreusHome_1719" },
			},
			{
				ObjectType = "NPC_Achilles_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Heh.
				{ Cue = "/VO/Achilles_0244" },
			},
			{
				{
					PreLineWait = 0.85,
					ObjectType = "NPC_Hades_01",
					RequiredFalseTextLines = { "Ending01" },
					RequiredSourceValueFalse = "InPartnerConversation",
					-- Reflect upon your many failings with that, boy.
					{ Cue = "/VO/Hades_0655" },
				},
				{
					PreLineWait = 0.85,
					ObjectType = "NPC_Hades_01",
					RequiredTextLines = { "Ending01" },
					RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
					RequiredSourceValueFalse = "InPartnerConversation",
					-- Leave that poor Contractor alone.
					{ Cue = "/VO/Hades_0903" },
				},
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_NorthHallCouch =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "CosmeticIcon_MainHallCouch",
		ResourceName = "Gems",
		ResourceCost = 25,
		RequiredNumCosmeticsMin = 10,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		ActivateIds = { 425084, },
		DeathAreaFocusId = 425084,
		ToggleCollision = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				RequiredFalseTextLines = { "Ending01" },
				-- Let us hereby have better seating, on which I shall never rest, you mark my words!
				{ Cue = "/VO/ZagreusHome_1720" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredTextLines = { "Ending01" },
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Hrm.
				{ Cue = "/VO/Hades_1101" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_NorthHallRug =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "CosmeticIcon_MainHallRug_01",
		ResourceName = "Gems",
		ResourceCost = 80,
		GameStateRequirements =
		{
			RequiredCosmeticsAdded = { "HouseWaterBowl01" },
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		ActivateIds = { 426793, },
		SetAnimationIds =
		{
			[426793] = "HouseRug04",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallRugA",
			"Cosmetic_NorthHallRugB",
			"Cosmetic_NorthHallRugC",
		},
		DeathAreaFocusId = 426793,
		RevealGlobalVoiceLines = "RugPurchaseResponseVoiceLines",
	},

	Cosmetic_NorthHallRugA =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "CosmeticIcon_MainHallRug_02",
		ResourceName = "Gems",
		ResourceCost = 90,
		GameStateRequirements =
		{
			RequiredCosmeticsAdded = { "HouseWaterBowl01" },
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		ActivateIds = { 426793, },
		SetAnimationIds =
		{
			[426793] = "HouseRug04A",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallRug",
			"Cosmetic_NorthHallRugB",
			"Cosmetic_NorthHallRugC",
		},
		DeathAreaFocusId = 426793,
		RevealGlobalVoiceLines = "RugPurchaseResponseVoiceLines",
	},

	Cosmetic_NorthHallRugB =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "CosmeticIcon_MainHallRug_03",
		ResourceName = "Gems",
		ResourceCost = 95,
		GameStateRequirements =
		{
			RequiredCosmeticsAdded = { "HouseWaterBowl01" },
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		ActivateIds = { 426793, },
		SetAnimationIds =
		{
			[426793] = "HouseRug04B",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallRug",
			"Cosmetic_NorthHallRugA",
			"Cosmetic_NorthHallRugC",
		},
		DeathAreaFocusId = 426793,
		RevealGlobalVoiceLines = "RugPurchaseResponseVoiceLines",
	},

	Cosmetic_NorthHallRugC =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "CosmeticIcon_MainHallRug_04",
		ResourceName = "Gems",
		ResourceCost = 85,
		GameStateRequirements =
		{
			RequiredCosmeticsAdded = { "HouseWaterBowl01" },
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		ActivateIds = { 426793, },
		SetAnimationIds =
		{
			[426793] = "HouseRug04C",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallRug",
			"Cosmetic_NorthHallRugA",
			"Cosmetic_NorthHallRugB",
		},
		DeathAreaFocusId = 426793,
		RevealGlobalVoiceLines = "RugPurchaseResponseVoiceLines",
	},

	Cosmetic_NorthHallPaintingZagreus =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_Painting_Mood",
		ResourceName = "SuperGems",
		ResourceCost = 2,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		ActivateIds = { 426081, },
		DeathAreaFocusId = 555807,
		SetAnimationIds =
		{
			[426081] = "HousePaintingMood01",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPaintingHades",
			"Cosmetic_NorthHallPaintingFury",
			"Cosmetic_NorthHallPaintingMysteryWoman",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- It seems my princely duty to commission this fine portrait of myself!
				{ Cue = "/VO/ZagreusHome_1722" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- I ought have named you Narcissus instead.
				{ Cue = "/VO/Hades_0657" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	Cosmetic_NorthHallPaintingHades =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_Painting_Hades",
		ResourceName = "SuperGems",
		ResourceCost = 5,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		ActivateIds = { 426081, },
		DeathAreaFocusId = 555807,
		SetAnimationIds =
		{
			[426081] = "HousePaintingHades01",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPaintingZagreus",
			"Cosmetic_NorthHallPaintingFury",
			"Cosmetic_NorthHallPaintingMysteryWoman",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Since this is Father's House it's only fair the walls be slathered with his sour look.
				{ Cue = "/VO/ZagreusHome_1723" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You dare to thusly mock me, boy?
				{ Cue = "/VO/Hades_0658" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_NorthHallPaintingFury =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_Painting_Fury",
		ResourceName = "SuperGems",
		ResourceCost = 4,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
			RequiredSeenRooms = { "A_Boss01", "A_Boss02", "A_Boss03" },
		},
		ActivateIds = { 426081, },
		DeathAreaFocusId = 555807,
		SetAnimationIds =
		{
			[426081] = "HousePaintingFury01",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPaintingZagreus",
			"Cosmetic_NorthHallPaintingHades",
			"Cosmetic_NorthHallPaintingMysteryWoman",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Wonder how they got Meg to pose with the other two. They look downright civil!
				{ Cue = "/VO/ZagreusHome_2772" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You wish to see the Fury Sisters, go to Tartarus.
				{ Cue = "/VO/Hades_0911" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_NorthHallPaintingMysteryWoman =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "CosmeticIcon_Painting_MysteryWoman",
		ResourceName = "Gems",
		ResourceCost = 1100,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		ActivateIds = { 426081, },
		DeathAreaFocusId = 555807,
		SetAnimationIds =
		{
			[426081] = "HousePaintingMysteryWoman01",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPaintingZagreus",
			"Cosmetic_NorthHallPaintingHades",
			"Cosmetic_NorthHallPaintingFury",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Nyx deserves a place of honor around here. How about... right over there on that wall?
				{ Cue = "/VO/ZagreusHome_2773" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Nyx surely is unwanting of attention such as that.
				{ Cue = "/VO/Hades_0912" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_NorthHallPaintingMysteryGirl =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "CosmeticIcon_Painting_MysteryGirl",
		ResourceName = "Gems",
		ResourceCost = 775,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		ActivateIds = { 426085, },
		DeathAreaFocusId = 555807,
		SetAnimationIds =
		{
			[426085] = "HousePaintingAriadne01",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPaintingTheseus",
			"Cosmetic_NorthHallPaintingTots",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Every self-respecting House needs a portrait of a girl from Crete.
				{ Cue = "/VO/ZagreusHome_1727" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Another tastelessly constructed piece.
				{ Cue = "/VO/Hades_0664" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_NorthHallPaintingTots =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_Painting_Tots",
		ResourceName = "Gems",
		ResourceCost = 725,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		ActivateIds = { 426085, },
		DeathAreaFocusId = 555807,
		SetAnimationIds =
		{
			[426085] = "HousePaintingTots01",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPaintingTheseus",
			"Cosmetic_NorthHallPaintingMysteryGirl",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- This piece has the power to embarrass several members of this House all in one swoop.
				{ Cue = "/VO/ZagreusHome_1725" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- I much prefer the walls to remain bare.
				{ Cue = "/VO/Hades_0660" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_NorthHallPaintingTheseus =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_Painting_Theseus",
		ResourceName = "Gems",
		ResourceCost = 750,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
			RequiredSeenRooms = { "C_Boss01", },
		},
		ActivateIds = { 426085, },
		DeathAreaFocusId = 555807,
		SetAnimationIds =
		{
			[426085] = "HousePaintingTheseus01",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPaintingTots",
			"Cosmetic_NorthHallPaintingMysteryGirl",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Oh gods, am I becoming hopelessly obsessed with Theseus...?
				{ Cue = "/VO/ZagreusHome_1726" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You'll never be a match for such a champion.
				{ Cue = "/VO/Hades_0661" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	Cosmetic_NorthHallPaintingTartarus =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_Painting_Tartarus",
		ResourceName = "Gems",
		ResourceCost = 325,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		ActivateIds = { 426082, },
		DeathAreaFocusId = 555807,
		SetAnimationIds =
		{
			[426082] = "HousePaintingTartarus01",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPaintingAsphodel",
			"Cosmetic_NorthHallPaintingElysium",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I'd like to see the depths of Tartarus adorn those walls back there!
				{ Cue = "/VO/ZagreusHome_1728" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Why don't you go see Tartarus firsthand?
				{ Cue = "/VO/Hades_0663" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	Cosmetic_NorthHallPaintingAsphodel =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_Painting_Asphodel",
		ResourceName = "Gems",
		ResourceCost = 330,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
			RequiredSeenRooms = { "B_Intro" },
		},
		ActivateIds = { 426082, },
		DeathAreaFocusId = 555807,
		SetAnimationIds =
		{
			[426082] = "HousePaintingAsphodel01",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPaintingTartarus",
			"Cosmetic_NorthHallPaintingElysium",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- This artful piece of terrifying Asphodel should add some atmosphere.
				{ Cue = "/VO/ZagreusHome_1729" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- What are you doing to my hall up there?
				{ Cue = "/VO/Hades_0662" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_NorthHallPaintingElysium =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_Painting_Elysium",
		ResourceName = "Gems",
		ResourceCost = 335,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
			RequiredSeenRooms = { "C_Intro" },
		},
		ActivateIds = { 426082, },
		DeathAreaFocusId = 555807,
		SetAnimationIds =
		{
			[426082] = "HousePaintingElysium01",
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPaintingTartarus",
			"Cosmetic_NorthHallPaintingAsphodel",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- A painting of the finest spot in all the Underworld seems suitable to have in here.
				{ Cue = "/VO/ZagreusHome_2826" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Why settle for a painting when you could just go get yourself killed there, now?
				{ Cue = "/VO/Hades_1038" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_NorthHallPedestalMechanism =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Icon = "CosmeticIcon_Mechanism",
		Slot = "CosmeticNorthHall",
		ResourceName = "Gems",
		ResourceCost = 300,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPedestalHammer",
		},
		ActivateIds = { 425563, 426321, },
		DeactivateIds = { 426567, },
		DeathAreaFocusId = 425563,
		ToggleCollision = true,

		ActivateObstacles =
		{
			[426321] =
			{
				InteractDistance = 150,
				UseText = "UseStatue01",
				OnUsedFunctionName = "UseStatue",
			},
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- This thought-provoking piece seems like a decent conversation-starter for the hall.
				{ Cue = "/VO/ZagreusHome_1741" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- What is that utterly preposterous design?
				{ Cue = "/VO/Hades_0670" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	--[[
	Cosmetic_NorthHallPedestalHammer =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_Hammer",
		ResourceName = "SuperGems",
		ResourceCost = 1,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierSCosmeticCount,
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPedestalMechanism",
		},
		ActivateIds = { 425563, 426567, },
		DeactivateIds = { 426321, },
		DeathAreaFocusId = 425563,
		ToggleCollision = true,
		Disabled = true,
	},
	]]

	-- asphodel statue
	Cosmetic_NorthHallPedestalBust =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "CosmeticIcon_SkeletonStatue",
		ResourceName = "Gems",
		ResourceCost = 140,
		GameStateRequirements =
		{
			RequiredSeenRooms = { "B_Boss01", },
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPedestalArtifact",
		},
		ActivateIds = { 425944, 426443, },
		DeactivateIds = { 426569, },
		InspectPoint = 427178,
		DeathAreaFocusId = 425944,
		ToggleCollision = true,

		ActivateObstacles =
		{
			[426443] =
			{
				InteractDistance = 150,
				UseText = "UseStatue01",
				OnUsedFunctionName = "UseStatue",
			},
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- A hideous rendition of a grizzled skeleton seems suitable decor.
				{ Cue = "/VO/ZagreusHome_1740" },
			},
			{
				PreLineWait = 0.6,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- May it strike fear into these worthless shades.
				{ Cue = "/VO/Hades_0669" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	--[[
	Cosmetic_NorthHallPedestalArtifact =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_Artifact",
		ResourceName = "SuperGems",
		ResourceCost = 2,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierSCosmeticCount,
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallPedestalBust",
		},
		ActivateIds = { 425944, 426569, },
		DeactivateIds = { 426443, },
		DeathAreaFocusId = 425944,
		ToggleCollision = true,
		Disabled = true,
	},
	]]

	Cosmetic_NorthHallPedestalSphere =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_StarSphere",
		ResourceName = "SuperGems",
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierSCosmeticCount,
		},
		ActivateIds = { 426785, },
		DeactivateIds = { 425301, },
		DeathAreaFocusId = 426785,
		ToggleCollision = true,
		Disabled = true,
	},

	-- Sundial
	Cosmetic_NorthHallSundial =
	{
		InheritFrom = { "NorthHallItem", "DefaultCosmeticItem", },
		Icon = "Cosmetic_Sundial",
		ResourceName = "Gems",
		ResourceCost = 590,
		GameStateRequirements =
		{
			RequiredAnyTextLines = { "HadesMiscMeeting04", "HadesMiscMeeting04_B", "HadesGift05" },
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},

		ActivateIds = { 426789, },
		ActivateObstacles =
		{
			[426789] =
			{
				InteractDistance = 180,
				InteractOffsetX = 25,
				InteractOffsetY = -85,
				UseText = "UseSundial01",
				OnUsedFunctionName = "UseSundial",
			},
		},

		DeathAreaFocusId = 426789,
		InspectPoint = 555809,
		ToggleCollision = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				RequiredFalseTextLines = { "Ending01" },
				-- Father always wanted a sundial, though that aside, let's have a sundial back there, posthaste!
				{ Cue = "/VO/ZagreusHome_1732" },
			},
			{
				PreLineWait = 0.35,
				RequiredTextLines = { "Ending01" },
				-- Perhaps the mystery of whether it's day or night around here will finally be solved?
				{ Cue = "/VO/ZagreusHome_2597" },
			},
			{
				ObjectType = "NPC_Thanatos_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- So be it.
				{ Cue = "/VO/Thanatos_0165" },
			},
			{
				PreLineWait = 0.5,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- A sundial, at last? Indeed?
				{ Cue = "/VO/Hades_0874" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_NorthHallPedestalA =
	{
		InheritFrom = { "NorthHallItem", "DefaultCosmeticItem", },
		Icon = "CosmeticIcon_PedestalA",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		DeathAreaFocusId = 425569,
		ResourceName = "Gems",
		ResourceCost = 160,
		SetAnimations =
		{
			HousePedestal01 = "HousePedestal02",
		},
		DeactivateAnimations =
		{
			HousePedestal01 = "HousePedestal01",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I think those pedestals over there are just a bit too modest for my tastes.
				{ Cue = "/VO/ZagreusHome_2820" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Hrm, I do suppose that gold suits those sufficiently...
				{ Cue = "/VO/Hades_1032" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	CosmeticAchillesRug =
	{
		InheritFrom = { "NorthHallItem", "DefaultCosmeticItem", },
		Icon = "CosmeticIcon_AchillesRug",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
			RequiredTextLines = { "AchillesGift03" },
		},
		ActivateIds = { 555729, },
		DeathAreaFocusId = 555729,
		ResourceName = "Gems",
		ResourceCost = 145,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- If Achilles is going to stand around eternally, it might as well take place on something soft.
				{ Cue = "/VO/ZagreusHome_2819" },
			},
			{
				ObjectType = "NPC_Achilles_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Ah.
				{ Cue = "/VO/Achilles_0352" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- He is a shade, boy! What use has he for supple carpeting?
				{ Cue = "/VO/Hades_1031" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_ThanatosCouch =
	{
		InheritFrom = { "NorthHallItem", "DefaultCosmeticItem", },
		Icon = "Cosmetic_ThanatosCouch",
		ResourceName = "Gems",
		ResourceCost = 220,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierSCosmeticCount,
			RequiredTextLines = { "ThanatosGift09" },
		},
		ActivateIds = { 555418, },
		DeathAreaFocusId = 423056,
		ToggleCollision = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Oh I think Thanatos would love this one. Or totally ignore it?
				{ Cue = "/VO/ZagreusHome_2822" },
			},
			{
				ObjectType = "NPC_Thanatos_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- What is this, Zag.
				{ Cue = "/VO/Thanatos_0525" },
			},
			{
				PreLineWait = 0.55,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Thanatos is far too industrious to require such a thing!
				{ Cue = "/VO/Hades_1034" },
			},
		},
	},

	Cosmetic_ThanatosRug =
	{
		InheritFrom = { "NorthHallItem", "DefaultCosmeticItem", },
		Icon = "Cosmetic_ThanatosRug",
		ResourceName = "Gems",
		ResourceCost = 240,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierSCosmeticCount,
			RequiredTextLines = { "ThanatosGift05" },
		},
		ActivateIds = { 555651, },
		DeathAreaFocusId = 423056,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Should soften up that corridor down there.
				{ Cue = "/VO/ZagreusHome_2768" },
			},
			{
				ObjectType = "NPC_Thanatos_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Heh.
				{ Cue = "/VO/Thanatos_0181" },
			},
			{
				PreLineWait = 0.55,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Thanatos has no need for such embellishments!
				{ Cue = "/VO/Hades_0908" },
			},
		},
	},

	Cosmetic_ThanatosTable =
	{
		InheritFrom = { "NorthHallItem", "DefaultCosmeticItem", },
		Icon = "Cosmetic_ThanatosTable",
		ResourceName = "Gems",
		ResourceCost = 250,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierSCosmeticCount,
			RequiredTextLines = { "ThanatosGift10" },
		},
		ActivateIds = { 555422, },
		DeathAreaFocusId = 423056,
		ToggleCollision = true,

		RevealVoiceLines =
		{
			{
				{
					PreLineWait = 0.35,
					AreIdsNotAlive = { 423052 },
					-- Where else is Thanatos going to stash loose odds and ends?
					{ Cue = "/VO/ZagreusHome_2823" },
				},
				{
					PreLineWait = 0.35,
					AreIdsAlive = { 423052 },
					-- Here, Thanatos, why don't you have yourself this little table?
					{ Cue = "/VO/ZagreusHome_2769" },
				}
			},
			{
				ObjectType = "NPC_Thanatos_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- This can't be...
				{ Cue = "/VO/Thanatos_0518" },
			},
			{
				PreLineWait = 0.55,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- What use has Death Incarnate for such things?
				{ Cue = "/VO/Hades_1035" },
			},
		},
	},

	Cosmetic_ThanatosBrazier =
	{
		InheritFrom = { "NorthHallItem", "DefaultCosmeticItem", },
		Icon = "Cosmetic_ThanatosBrazier",
		ResourceName = "Gems",
		ResourceCost = 260,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierSCosmeticCount,
			RequiredTextLines = { "ThanatosGift08" },
		},
		ActivateIds = { 555419, 555646, 555647, 555649, 555648, 555650, 555421, },
		DeathAreaFocusId = 423056,
		ToggleCollision = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Let's lighten up that southwest hall a bit.
				{ Cue = "/VO/ZagreusHome_2824" },
			},
			{
				ObjectType = "NPC_Thanatos_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- What?
				{ Cue = "/VO/Thanatos_0515" },
			},
			{
				PreLineWait = 0.55,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- The prior dimness of that hall was entirely intentional!
				{ Cue = "/VO/Hades_1036" },
			},
		},
	},

	Cosmetic_ThanatosChair =
	{
		InheritFrom = { "NorthHallItem", "DefaultCosmeticItem", },
		Icon = "Cosmetic_ThanatosChair",
		ResourceName = "Gems",
		ResourceCost = 210,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierSCosmeticCount,
			RequiredTextLines = { "ThanatosGift05" },
		},
		ActivateIds = { 555423, 555417, },
		DeathAreaFocusId = 423056,
		ToggleCollision = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Perhaps Death Incarnate would like to take a load off every now and then.
				{ Cue = "/VO/ZagreusHome_2821" },
			},
			{
				ObjectType = "NPC_Thanatos_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Appreciate that.
				{ Cue = "/VO/Thanatos_0487" },
			},
			{
				PreLineWait = 0.55,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Thanatos would never sit down on the job!
				{ Cue = "/VO/Hades_1033" },
			},
		},
	},

	Cosmetic_NorthHallFountain =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem"  },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_Fountain",
		ActivateIds = { 424285, 424292, 424904, 424285, 424849, 424850, 424851, 424853, 424854, 424900, 424901, 424902, 424903, 424905, 424906, 424908, 424909, },
		DeactivateCosmetics = { "Cosmetic_NorthHallWarriorStatue", },
		InspectPoint = 424960,
		DeathAreaFocusId = 421081,
		AddConstructionPresentation = true,
		ActivateObstacles =
		{
			[424285] =
			{
				InteractDistance = 200,
				UseText = "UseSouthHallFountain",
				OnUsedFunctionName = "UseSouthHallFountain",
				OnUsedGlobalVoiceLines = "UsedHouseFountainVoiceLines",
			},
		},
		SetAnimationIds =
		{
			[424285] = "HouseFountain01",
		},
		DeactivateAnimationIds =
		{
			[424285] = "Blank",
		},

		ResourceName = "Gems",
		ResourceCost = 3000,
		GameStateRequirements =
		{
			RequiredCosmeticsAdded = { "Cosmetic_HousePillars" },
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallWarriorStatue",
		},
		ToggleCollision = true,
		IndependentToggle = true,
		ToggleUseability = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- What is it about fountains that makes everything feel a little fancier?
				{ Cue = "/VO/ZagreusHome_1075" },
			},
			{
				ObjectType = "NPC_Thanatos_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Really?
				{ Cue = "/VO/Thanatos_0076" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- What good shall that do all the way down there?
				{ Cue = "/VO/Hades_0907" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_NorthHallWarriorStatue =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem"  },
		Icon = "CosmeticIcon_WarriorStatue",
		Slot = "CosmeticNorthHall",
		ActivateIds = { 426371, 426368, 426373, 426372, },
		DeactivateCosmetics = { "Cosmetic_NorthHallFountain", },
		InspectPoint = 427179,
		DeathAreaFocusId = 421081,
		AddConstructionPresentation = true,
		ResourceName = "Gems",
		ResourceCost = 1500,
		GameStateRequirements =
		{
			RequiredCosmeticsAdded = { "Cosmetic_HousePillars" },
			RequiredNumCosmeticsMin = ConstantsData.TierSCosmeticCount,
		},
		RemoveCosmetics =
		{
			"Cosmetic_NorthHallFountain",
		},
		ToggleCollision = true,
		IndependentToggle = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I've not seen the famous Heracles about, and so, let's have a marble effigy of him, instead!
				{ Cue = "/VO/ZagreusHome_1730" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Daedalus ought stick to chamber work.
				{ Cue = "/VO/Hades_0665" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	Cosmetic_SouthHallFountain =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_Fountain",
		ActivateIds = { 424329, },
		InspectPoint = 424961,
		DeathAreaFocusId = 424978,
		AddConstructionPresentation = true,
		ActivateObstacles =
		{
			[424328] =
			{
				InteractDistance = 200,
				UseText = "UseSouthHallFountain",
				OnUsedFunctionName = "UseSouthHallFountain",
				OnUsedGlobalVoiceLines = "UsedHouseFountainVoiceLines",
			},
		},
		SetAnimationIds =
		{
			[424328] = "HouseFountain01",
		},
		DeactivateAnimationIds =
		{
			[424328] = "Blank",
		},

		ResourceName = "Gems",
		ResourceCost = 1500,
		GameStateRequirements =
		{
			RequiredCosmeticsAdded = { "Cosmetic_NorthHallFountain" },
		},
		ToggleCollision = true,

		RevealVoiceLines =
		{
			PreLineWait = 0.45,
			-- Always hoped we'd have fountain here precisely in that location.
			{ Cue = "/VO/ZagreusHome_1076" },
		},
		RevealReactionGlobalVoiceLines = "HadesGhostAdminPurchaseReactionVoiceLines",
	},

	Cosmetic_SeatCushions =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem" },
		Slot = "CosmeticLounge",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		Icon = "Cosmetic_Cushion",
		ActivateNames = { "HouseCushion01", },
		DeathAreaFocusId = 424951,
		ResourceName = "Gems",
		ResourceCost = 60,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Ah yes, more comfortable seating I shall never use.
				{ Cue = "/VO/ZagreusHome_1072" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- I'd better not catch anybody sitting down on that.
				{ Cue = "/VO/Hades_0906" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_LoungeChairsA =
	{
		InheritFrom = { "LoungeItem", "DefaultCosmeticItem", },
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		Icon = "CosmeticIcon_ChairsA",
		DeathAreaFocusId = 210354,
		ResourceName = "Gems",
		ResourceCost = 70,
		SetAnimations =
		{
			HouseChair01 = "HouseChair03",
		},
		DeactivateAnimations =
		{
			HouseChair01 = "HouseChair01",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Think this is going to be a better look for the lounge seating.
				{ Cue = "/VO/ZagreusHome_2827" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Green is perhaps last among the list of colors I would have selected!
				{ Cue = "/VO/Hades_1039" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_LoungeTablesA =
	{
		InheritFrom = { "LoungeItem", "DefaultCosmeticItem", },
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		Icon = "CosmeticIcon_TableA",
		DeathAreaFocusId = 210302,
		ResourceName = "Gems",
		ResourceCost = 80,
		SetAnimations =
		{
			HouseTableRound01 = "HouseTableRound01a",
		},
		DeactivateAnimations =
		{
			HouseTableRound01 = "HouseTableRound01",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I think the lounge will be better off for these tables here.
				{ Cue = "/VO/ZagreusHome_2829" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- There were no complaints on record of the prior tables!
				{ Cue = "/VO/Hades_1041" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_Aquarium =
	{
		InheritFrom = { "LoungeItem", "DefaultCosmeticItem", },
		GameStateRequirements =
		{
			RequiredMinTotalCaughtFish = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
		},
		Icon = "CosmeticIcon_Aquarium",
		DeathAreaFocusId = 423249,
		ResourceName = "Gems",
		ResourceCost = 330,
		ActivateObstacles =
		{
			[423249] =
			{
				InteractDistance = 200,
				UseText = "UseAquarium",
				OnUsedFunctionName = "UseAquarium",
			},
		},
		ToggleUseability = true,
		ToggleUseabilityIds = { 423249, },
		SetAnimationIds =
		{
			[423249] = "HouseAquarium",
		},
		DeactivateAnimationIds =
		{
			[423249] = "HouseCounter02",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- The Head Chef certainly is going to need a place to safely care for all the fish I've been hauling in.
				{ Cue = "/VO/ZagreusHome_2830" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Last that I checked, this was not Poseidon's domain!
				{ Cue = "/VO/Hades_1042" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_HangingFood =
	{
		InheritFrom = { "LoungeItem", "DefaultCosmeticItem", },
		Icon = "CosmeticIcon_HangingFood",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		ActivateIds = { 555733, },
		DeathAreaFocusId = 555733,
		ResourceName = "Gems",
		ResourceCost = 65,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- A fine display of dead meats seems very much in theme, I have to say!
				{ Cue = "/VO/ZagreusHome_2831" },
			},
			{
				PreLineWait = 0.6,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You ought to be displayed with all the rest.
				{ Cue = "/VO/Hades_1043" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_KitchenIsland =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem" },
		Slot = "CosmeticLounge",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
		},
		Icon = "Cosmetic_KitchenIsland",
		-- ConnectedIds = { 423122, 423131 },
		ActivateIds = { 423122, 423131, },
		InspectPoint = 425000,
		DeathAreaFocusId = 424971,
		AddConstructionPresentation = true,
		ResourceName = "Gems",
		ResourceCost = 130,
		Removable = false,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Who am I to stop the shades there in the lounge from cooking up whatever it is they're making?
				{ Cue = "/VO/ZagreusHome_1077" },
			},
		},
		RevealReactionGlobalVoiceLines = "HadesGhostAdminPurchaseReactionVoiceLines",
	},

	Cosmetic_SpiceRack =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem"  },
		Slot = "CosmeticLounge",
		Icon = "Cosmetic_SpiceRack_01",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		Icon = "Cosmetic_SpiceRack",
		ActivateIds = { 424930, },
		DeathAreaFocusId = 424999,
		ResourceName = "Gems",
		ResourceCost = 60,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_KitchenIsland", },
		},
		Icon = "Cosmetic_SpiceRack",

		RevealReactionGlobalVoiceLines = "HadesGhostAdminPurchaseReactionVoiceLines",
	},

	Cosmetic_Knives =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem"  },
		Slot = "CosmeticLounge",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
		},
		Icon = "Cosmetic_Knives",
		ActivateIds = { 424931, },
		DeathAreaFocusId = 424998,
		ResourceName = "Gems",
		ResourceCost = 70,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_KitchenIsland", },
		},
		Icon = "Cosmetic_Knives",

		RevealReactionGlobalVoiceLines = "HadesGhostAdminPurchaseReactionVoiceLines",
	},

	Cosmetic_ClearFur =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem"  },
		Slot = "CosmeticLounge",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		DestroyNames = { "TravelFur01", "TravelFur02", },
		DeathAreaFocusId = 424954,
		ResourceName = "Gems",
		ResourceCost = 15,
		Removable = false,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Whew. It's a big job, having to sweep up after Cerberus sheds everywhere.
				{ Cue = "/VO/ZagreusHome_1078" },
			},
			{
				PreLineWait = 0.6,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- It wasn't your fault, Cerberus.
				{ Cue = "/VO/Hades_0526", IsIdAlive = 370007 },
				-- Blame yourself for that, not Cerberus.
				{ Cue = "/VO/Hades_0605", AreIdsNotAlive = { 370007 } },
			},
		},

	},

	Cosmetic_ClearScratches =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem"  },
		Slot = "CosmeticLounge",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		DestroyNames = { "HouseClawmarks01", },
		DeathAreaFocusId = 424954,
		AddConstructionPresentation = true,
		ResourceName = "Gems",
		ResourceCost = 25,
		Removable = false,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- This ought to make the lounge a little more presentable. Until Cerberus wrecks it again.
				{ Cue = "/VO/ZagreusHome_1079" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Finally you cleared the mess you caused.
				{ Cue = "/VO/Hades_0525" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_LoungeRug =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem" },
		Slot = "CosmeticLounge",
		Icon = "CosmeticIcon_MainHallRug_01",
		ResourceName = "Gems",
		ResourceCost = 40,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
			RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur" },
		},
		ActivateIds = { 426721, },
		SetAnimationIds =
		{
			[426721] = "HouseRug04",
		},
		RemoveCosmetics =
		{
			"Cosmetic_LoungeRugA",
			"Cosmetic_LoungeRugB",
			"Cosmetic_LoungeRugC",
		},
		DeathAreaFocusId = 426721,
		RevealGlobalVoiceLines = "LoungeRugPurchaseResponseVoiceLines",
	},

	Cosmetic_LoungeRugA =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem" },
		Slot = "CosmeticLounge",
		Icon = "CosmeticIcon_MainHallRug_02",
		ResourceName = "Gems",
		ResourceCost = 45,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
			RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur" },
		},
		ActivateIds = { 426721, },
		SetAnimationIds =
		{
			[426721] = "HouseRug04A",
		},
		RemoveCosmetics =
		{
			"Cosmetic_LoungeRug",
			"Cosmetic_LoungeRugB",
			"Cosmetic_LoungeRugC",
		},
		DeathAreaFocusId = 426721,
		RevealGlobalVoiceLines = "LoungeRugPurchaseResponseVoiceLines",
	},

	Cosmetic_LoungeRugB =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem" },
		Slot = "CosmeticLounge",
		Icon = "CosmeticIcon_MainHallRug_03",
		ResourceName = "Gems",
		ResourceCost = 50,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
			RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur" },
		},
		ActivateIds = { 426721, },
		SetAnimationIds =
		{
			[426721] = "HouseRug04B",
		},
		RemoveCosmetics =
		{
			"Cosmetic_LoungeRug",
			"Cosmetic_LoungeRugA",
			"Cosmetic_LoungeRugC",
		},
		DeathAreaFocusId = 426721,
		RevealGlobalVoiceLines = "LoungeRugPurchaseResponseVoiceLines",
	},

	Cosmetic_LoungeRugC =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem" },
		Slot = "CosmeticLounge",
		Icon = "CosmeticIcon_MainHallRug_04",
		ResourceName = "Gems",
		ResourceCost = 55,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
			RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur" },
		},
		ActivateIds = { 426721, },
		SetAnimationIds =
		{
			[426721] = "HouseRug04C",
		},
		RemoveCosmetics =
		{
			"Cosmetic_LoungeRug",
			"Cosmetic_LoungeRugA",
			"Cosmetic_LoungeRugB",
		},
		DeathAreaFocusId = 426721,
		RevealGlobalVoiceLines = "LoungeRugPurchaseResponseVoiceLines",
	},

	Cosmetic_LoungeAdditionalSeating =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem" },
		Slot = "CosmeticLounge",
		Icon = "CosmeticIcon_MainHallCouch",
		ResourceName = "Gems",
		ResourceCost = 35,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
			RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur" },
		},
		ActivateIds = { 425463, 425464, 425465, },
		DeathAreaFocusId = 425463,
		ToggleCollision = true,
	},

	Cosmetic_LoungeBrokerRug =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem" },
		Slot = "CosmeticLounge",
		Icon = "CosmeticIcon_SquareRug_01",
		ResourceName = "Gems",
		ResourceCost = 30,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
			RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur" },
		},
		ActivateIds = { 425385 },
		DeathAreaFocusId = 425385,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Should make the entryway into the lounge a bit more welcoming.
				{ Cue = "/VO/ZagreusHome_2810" },
			},
			{
				PreLineWait = 0.8,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- I welcome you to go about your business, boy!
				{ Cue = "/VO/Hades_1023" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_LoungeDiscoBall =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem" },
		Slot = "CosmeticLounge",
		Icon = "Cosmetic_DiscoBall",
		ResourceName = "SuperGems",
		ResourceCost = 5,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierSCosmeticCount,
			RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur" },
		},
		ActivateIds = { 426181, 426187, 426186, 426183, 426182, 426188, 426185 },
		ToggleVfx = true,
		DeactivateStopAnimations = { "ElysiumButterflyCycleRandomA", "ElysiumButterflyCycleRandomB", "ElysiumButterflyCycleRandomC", "ElysiumButterflyCycleRandomD", },
		DeathAreaFocusId = 426181,
		AddConstructionPresentation = true,

		SetAnimations =
		{
			HouseDiscoBall01 = "HouseDiscoBall01",
		},

		RemoveCosmetics =
		{
			"Cosmetic_LoungeDiscoBallA",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- If some big light-refracting orb won't fill the lounge with revelry, I don't know what will.
				{ Cue = "/VO/ZagreusHome_1776" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Blood and darkness, what have you done now?
				{ Cue = "/VO/Hades_0689" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_LoungeDiscoBallA =
	{
		InheritFrom = { "LoungeItem", "DefaultCosmeticItem", },
		Icon = "CosmeticIcon_DiscoBallA",
		ResourceName = "SuperGems",
		ResourceCost = 5,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			--RequiredNumCosmeticsMin = ConstantsData.TierSCosmeticCount,
			RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur", },
			RequiredCosmeticsAdded = { "Cosmetic_LoungeDiscoBall", },
		},

		ActivateIds = { 426181, 426182, 426186, 426187, },
		DeactivateIds = { 426183, 426188, 426185 },
		RemovalDeactivateIds = {},
		ActivateStopAnimations = { "ElysiumButterflyCycleRandomA", "ElysiumButterflyCycleRandomB", "ElysiumButterflyCycleRandomC", "ElysiumButterflyCycleRandomD", },

		SetAnimations =
		{
			HouseDiscoBall01 = "HouseDiscoBall02",
		},

		RemoveCosmetics =
		{
			"Cosmetic_LoungeDiscoBall",
		},

		DeathAreaFocusId = 426181,
		AddConstructionPresentation = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Now this is just the sort of outlandish purchase that makes me briefly feel slightly better about myself.
				{ Cue = "/VO/ZagreusHome_2832" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- I pity those who have depended on our lounge for its formal, understated atmosphere.
				{ Cue = "/VO/Hades_1044" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_BatCage =
	{
		InheritFrom = { "LoungeItem", "DefaultCosmeticItem", },
		Icon = "Cosmetic_BatCage",
		ResourceName = "SuperGems",
		ResourceCost = 3,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
			RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur" },
		},
		ActivateIds = { 427342, 427343, },
		DeathAreaFocusId = 391469,
		ToggleUseability = true,
		ToggleCollision = true,

		ActivateObstacles =
		{
			[427342] =
			{
				InteractDistance = 200,
				UseText = "UseLoungeTelescope",
				OnUsedFunctionName = "UseLoungeTelescope",
			},
		},
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- These adorable little creatures forced to live in a cage ought to lighten the mood.
				{ Cue = "/VO/ZagreusHome_2596" },
			},
			{
				ObjectType = "NPC_FurySister_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Oh, hey.
				{ Cue = "/VO/MegaeraHome_0194", PreLineAnim = "FuryIdleInHouseFidgetGreeting" },
			},
			{
				PreLineWait = 0.6,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Those bats are for reconnaissance not for your mood!
				{ Cue = "/VO/Hades_0873" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_LoungeCakeDisplay =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem" },
		Slot = "CosmeticLounge",
		Icon = "Cosmetic_CakeDisplay",
		ResourceName = "Gems",
		ResourceCost = 75,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
			RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur" },
		},
		ActivateIds = { 426724 },
		DeathAreaFocusId = 426724,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- It can't be eaten, as I understand, but it can be displayed for all to see!
				{ Cue = "/VO/ZagreusHome_1782" },
			},
			{
				PreLineWait = 0.6,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- I see you're cultivating quite the mess.
				{ Cue = "/VO/Hades_0687" },
			},
		},
	},

	Cosmetic_LoungeTreatJar =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem" },
		Slot = "CosmeticLounge",
		Icon = "Cosmetic_Treats",
		ResourceName = "Gems",
		ResourceCost = 55,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
			RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur" },
			RequiredTextLines = { "CerberusGift02" },
		},
		ActivateNames = { "HouseCerberusTreats01", },
		DeathAreaFocusId = 426723,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Cerberus won't touch these things, although some shades seem to enjoy them fine.
				{ Cue = "/VO/ZagreusHome_1783" },
			},
		},
	},

	Cosmetic_LoungeClayOven =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem" },
		Slot = "CosmeticLounge",
		Icon = "Cosmetic_KitchenOven",
		ResourceName = "Gems",
		ResourceCost = 150,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
			RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur" },
		},
		ActivateIds = { 426726, 426729, 426730, 426733, 424897, 426737, 426758, 426761, 426735, },
		DeathAreaFocusId = 426726,
		ToggleCollision = true,
	},

	Cosmetic_LoungeFireplace =
	{
		InheritFrom = { "LoungeItem", "DefaultCosmeticItem", },
		Icon = "Cosmetic_LoungeFireplace",
		ResourceName = "Gems",
		ResourceCost = 790,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
			RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur" },
		},
		ActivateIds = { 426109, 426189, 426190, },
		DeathAreaFocusId = 426109,
		InspectPoint = 555808,
		ToggleCollision = true,
		Removable = false,

		SetAnimationIds =
		{
			[426109] = "HouseFireplace",
		},
		DeactivateAnimationIds =
		{
			[426109] = "Blank",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- The comfort and the safety hazard of a roaring fire seems the perfect touch for our fine lounge, I say.
				{ Cue = "/VO/ZagreusHome_2599" },
			},
			{
				{
					PreLineWait = 0.5,
					ObjectType = "NPC_Hades_01",
					RequiredSourceValueFalse = "InPartnerConversation",
					-- Go cast yourself in there, why don't you, boy.
					{ Cue = "/VO/Hades_0876", RequiredFalseTextLines = { "Ending01" }, },
				},
				{
					PreLineWait = 0.5,
					ObjectType = "NPC_Hades_01",
					RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
					RequiredSourceValueFalse = "InPartnerConversation",
					-- What are we supposed to do with that?
					{ Cue = "/VO/Hades_0534", RequiredTextLines = { "Ending01" }, },
				},
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_LoungePaintingSkelly =
	{
		InheritFrom = { "LoungeItem", "DefaultCosmeticItem", },
		Icon = "Cosmetic_LoungePaintingSkelly",
		ResourceName = "Gems",
		ResourceCost = 460,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
			--RequiredCosmetics = { "Cosmetic_ClearScratches", "Cosmetic_ClearFur" },
			RequiredCosmetics = { "Cosmetic_LoungeFireplace", },
			RequiredTextLines = { "SkellyGift01" },
		},
		ActivateIds = { 392527, },
		DeathAreaFocusId = 392527,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- At least somebody will enjoy it around here, even if it's just a painted skeleton.
				{ Cue = "/VO/ZagreusHome_2598" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Would that you were a painted skeleton yourself.
				{ Cue = "/VO/Hades_0875" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_CerberusBed =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_DogBed_01",
		ResourceName = "Gems",
		ResourceCost = 50,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
			RequiredTextLines = { "CerberusGift01" },
		},
		ActivateIds = { 425359, },
		SetAnimations =
		{
			HouseDogBed01 = "HouseDogBed01",
		},
		RemoveCosmetics =
		{
			"Cosmetic_CerberusBedA",
		},
		DeathAreaFocusId = 425359,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- This seems a suitably fine resting-pad for Cerberus.
				{ Cue = "/VO/ZagreusHome_1753" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- The dog is perfectly content such as it is.
				{ Cue = "/VO/Hades_0673" },
			},
			{
				ObjectType = "NPC_Cerberus_01",
				{ Cue = "/VO/CerberusCuteGrowl_2" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
		ReEquipGlobalVoiceLines = "CerberusBedReAddedVoiceLines",
	},

	Cosmetic_CerberusBedA =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_DogBed_02",
		ResourceName = "Gems",
		ResourceCost = 55,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
			RequiredTextLines = { "CerberusGift01" },
		},
		ActivateIds = { 425359, },
		SetAnimations =
		{
			HouseDogBed01 = "HouseDogBed01A",
		},
		RemoveCosmetics =
		{
			"Cosmetic_CerberusBed",
		},
		DeathAreaFocusId = 425359,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- For Cerberus, only the greatest bed will do.
				{ Cue = "/VO/ZagreusHome_1752" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Don't you disturb the dog, you hear me, boy?
				{ Cue = "/VO/Hades_0674" },
			},
			{
				ObjectType = "NPC_Cerberus_01",
				{ Cue = "/VO/CerberusCuteWhine_3" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
		ReEquipGlobalVoiceLines = "CerberusBedReAddedVoiceLines",
	},

	Cosmetic_CerberusBall =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_DogBall",
		ResourceName = "Gems",
		ResourceCost = 60,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
			RequiredTextLines = { "CerberusGift03" },
		},
		ActivateIds = { 425358, },
		DeathAreaFocusId = 425358,
		ToggleCollision = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- For Cerberus, only the greatest bed will do.
				{ Cue = "/VO/ZagreusHome_1763" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- What do you think the dog shall do with that?
				{ Cue = "/VO/Hades_0678" },
			},
			{
				ObjectType = "NPC_Cerberus_01",
				{ Cue = "/VO/CerberusCuteWhine_1" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_CerberusToy =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_DogToy",
		ResourceName = "Gems",
		ResourceCost = 65,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
			RequiredTextLines = { "CerberusGift03" },
		},
		ActivateIds = { 555730, },
		DeathAreaFocusId = 555730,
		ToggleCollision = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Maybe this knitted effigy of some sort of surface creature will keep Cerberus occupied.
				{ Cue = "/VO/ZagreusHome_2809" },
			},
			{
				PreLineWait = 0.55,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Cerberus has much better things to do than play with toys!
				{ Cue = "/VO/Hades_1022" },
			},
			{
				ObjectType = "NPC_Cerberus_01",
				{ Cue = "/VO/CerberusCuteWhine_3" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	-- hypnos chaise
	Cosmetic_MainHallCouch =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_BedroomCouch_02",
		ResourceName = "Gems",
		ResourceCost = 160,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
			RequiredTextLines = { "HypnosGift04" },
		},
		ToggleCollision = true,
		ActivateIds = { 425490, 425492, 425491, },
		DeathAreaFocusId = 425490,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- If Hypnos is going to be sleeping on the job, he ought to do it in the lap of luxury.
				{ Cue = "/VO/ZagreusHome_1764" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Hypnos has an important job to do!
				{ Cue = "/VO/Hades_0679" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_MainHallTowels =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_Towels",
		ResourceName = "Gems",
		ResourceCost = 80,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		ToggleCollision = true,
		ActivateIds = { 425538, 425536, 425537, 425535, 425534, 425532, 425533, 425531, 425539, },
		DeathAreaFocusId = 425535,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I won't be needing these but anyone emerging from the Pool of Styx might like them I suppose.
				{ Cue = "/VO/ZagreusHome_1771" },
			},
			{
				PreLineWait = 0.6,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- A fair enough adjustment I should say.
				{ Cue = "/VO/Hades_0684" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	-- Poet Bust
	Cosmetic_NorthHallBust =
	{
		InheritFrom = { "DefaultCosmeticItem", "NorthHallItem" },
		Slot = "CosmeticNorthHall",
		Icon = "Cosmetic_PoetBust",
		ResourceName = "Gems",
		ResourceCost = 800,
		InspectPoint = 427177,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
		},
		ActivateIds = { 425946, 425947, },
		DeathAreaFocusId = 425946,
		ToggleCollision = true,

		ActivateObstacles =
		{
			[425947] =
			{
				InteractDistance = 150,
				UseText = "UsePoetBust01",
				OnUsedFunctionName = "UsePoetBust",
			},
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- A marble bust of some old man seems just the thing to liven this place up.
				{ Cue = "/VO/ZagreusHome_1758" },
			},
			{
				PreLineWait = 0.6,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Exactly whose unwanted countenance is that?
				{ Cue = "/VO/Hades_0675" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	Cosmetic_MainHallPetals =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_ElysiumPetals",
		ResourceName = "Gems",
		ResourceCost = 70,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
		},
		RemoveCosmetics =
		{
			"Cosmetic_MainHallBones",
			"Cosmetic_MainHallFlowers",
		},
		IndependentToggle = true,
		ActivateGroups = { "TerrainPetals_01" },
		DeactivateGroups = { "TerrainFlowers_01", "TerrainSkeletons_01", },
		DeathAreaFocusId = 423528,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- These undead flower petals ought to add an extra touch of elegance I think.
				{ Cue = "/VO/ZagreusHome_1768" },
			},
			{
				PreLineWait = 0.6,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- What are you doing to my central hall?
				{ Cue = "/VO/Hades_0683" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	Cosmetic_MainHallFlowers =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_ElysiumFlowers",
		ResourceName = "Gems",
		ResourceCost = 70,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
		},
		RemoveCosmetics =
		{
			"Cosmetic_MainHallPetals",
			"Cosmetic_MainHallBones",
		},
		IndependentToggle = true,
		ActivateGroups = { "TerrainFlowers_01" },
		DeactivateGroups = { "TerrainPetals_01", "TerrainSkeletons_01", },
		DeathAreaFocusId = 423528,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Let's get some undead flower petals over there, posthaste!
				{ Cue = "/VO/ZagreusHome_1770" },
			},
		},

	},

	Cosmetic_MainHallBones =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_SkullPile",
		ResourceName = "Gems",
		ResourceCost = 75,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
		},
		RemoveCosmetics =
		{
			"Cosmetic_MainHallPetals",
			"Cosmetic_MainHallFlowers",
		},
		ToggleCollision = true,
		IndependentToggle = true,
		ActivateGroups = { "TerrainSkeletons_01" },
		DeactivateGroups = { "TerrainPetals_01", "TerrainFlowers_01", },
		DeathAreaFocusId = 423528,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- The hall to Father ought to look more sinister, I think.
				{ Cue = "/VO/ZagreusHome_1766" },
			},
			{
				PreLineWait = 0.9,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- A fair enough adjustment I should say.
				{ Cue = "/VO/Hades_0681" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	Cosmetic_MainHallPetalFlyers =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_PetalFlyers",
		ResourceName = "Gems",
		ResourceCost = 500,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		DeathAreaFocusId = 393494,
		ActivateIds = { 426311, },

		RevealVoiceLines =
		{
			PreLineWait = 0.35,
			-- Can't have too many undead flower petals around here.
			{ Cue = "/VO/ZagreusHome_1769" },
		},

	},

	Cosmetic_MainHallTikiTorches =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_Brazier",
		ResourceName = "Gems",
		ResourceCost = 95,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		ActivateIds = { 426450, 426451, 426452, 426453, 426454, 426455, 426405, 426406, 426407, 426447, 426448, 426449, 426444, 426445, 426446, 426408, 426409, 426410, 426420, 426421, 426422, 426465, 426464, 426463, },
		DeactivateIds = { 423625, 423627, 423628, 423626, 423624, 393295, 393296, 393311, 393312, 393297, 423085, 423087, },
		ToggleCollision = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- A bit more mood lighting in the main hall is certainly in order, isn't it?
				{ Cue = "/VO/ZagreusHome_1767" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- The light of Ixion is bright enough.
				{ Cue = "/VO/Hades_0682" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	Cosmetic_MainHallFireplace =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_MainHallFireplace",
		ResourceName = "Gems",
		ResourceCost = 850,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		ActivateIds = { 426786, 421596, 392400, 392398, 392399, 392403, 392617, 392618, 392402, 423088, 393090, 393091, 393089, 424008, 424724, 423091, 424010, 424715, 392619, 426360, 426359, 426358, 426357, 425676, },
		RemovalDeactivateIds = { 423088, 393090, 393091, 393089, 424008, 424724, 421596, 392400, 392398, 392399, 392403, 392617, 392618, 392402, 423091, 424010, 424715, 392619, 426360, 426359, 426358, 426357, 425676, },
		DeactivateIds = { 421596, 392398, 392402, 392618, 392617, 392403, 392399, 392400, 392619, 555770 },
		DeathAreaFocusId = 426786,

		SetAnimationIds =
		{
			[426786] = "HouseFireplace2",
		},
		DeactivateAnimationIds =
		{
			[426786] = "Blank",
		},

		RemoveCosmetics =
		{
			"Cosmetic_MainHallFireplaceA",
		},
		IndependentToggle = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I would like only the brightest-burning, most ornate fireplace available, thanks.
				{ Cue = "/VO/ZagreusHome_2816" },
			},
			{
				PreLineWait = 0.5,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- There is sufficient warmth already in that hall.
				{ Cue = "/VO/Hades_0909" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_MainHallFireplaceA =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_MainHallFireplaceA",
		ResourceName = "Gems",
		ResourceCost = 1120,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		ActivateIds = { 555770, },
		DeactivateIds = { 426786, 393089, 423088, 393090, 393091, 424008, 424724, 421596, 392400, 392398, 392399, 392403, 392617, 392618, 392402, 423091, 424010, 424715, 392619, 426360, 426359, 426358, 426357, 425676, 392679, 392683, 392682, 392680, 392681, 392674, 392678, 392677, 392675, 392676, 392684, 392688, 392687, 392685, 392686, 425625, 425624, },
		RemovalDeactivateIds = { 393089, 423088, 393090, 393091, 424008, 424724, 421596, 392400, 392398, 392399, 392403, 392617, 392618, 392402, 423091, 424010, 424715, 392619, 426360, 426359, 426358, 426357, 425676, 392679, 392683, 392682, 392680, 392681, 392674, 392678, 392677, 392675, 392676, 392684, 392688, 392687, 392685, 392686, 425625, 425624, },
		DeathAreaFocusId = 555770,

		SetAnimationIds =
		{
			[555770] = "HouseFireplace3",
		},
		DeactivateAnimationIds =
		{
			[555770] = "Blank",
		},

		RemoveCosmetics =
		{
			"Cosmetic_MainHallFireplace",
		},
		IndependentToggle = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- This elegant countenance should look perfect above a roaring inferno in the hall back there.
				{ Cue = "/VO/ZagreusHome_2817" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLines = { "Ending01" },
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You'll not be burning down this House, you hear me, boy?
				{ Cue = "/VO/Hades_0645" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredTextLines = { "Ending01" },
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- The climate in this House is perfectly attuned as it is!
				{ Cue = "/VO/Hades_1029" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_CharonPillars =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_CharonPillars",
		ResourceName = "Gems",
		ResourceCost = 1410,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
			RequireEncounterCompleted = "BossCharon",
		},
		ActivateIds = { 555768, 555769, },
		DeactivateIds = { 391635, 391638, 391639, 391640, 425435, 392461, 392462, 392463, 392464, },
		DeathAreaFocusId = 555768,
		ToggleCollision = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- These ought to add a little sparkle each time I revive from the Pool of Styx.
				{ Cue = "/VO/ZagreusHome_2835" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",				
				-- Such an ignoble way to step into this House needs no adornment!
				{ Cue = "/VO/Hades_1047" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
		ReEquipGlobalVoiceLines = "ColumnsReAddedVoiceLines",
	},

	Cosmetic_MainHallCenterpieceA =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_CenterpieceA",
		ResourceName = "Gems",
		ResourceCost = 950,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		DeathAreaFocusId = 555719,
		ActivateIds = { 555719, },
		DeactivateIds = { 423853, 425482, },
		AddConstructionPresentation = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I think we can spruce up the centerpiece of the great hall just a bit.
				{ Cue = "/VO/ZagreusHome_2825" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- This is my blasted hall, rather than yours!
				{ Cue = "/VO/Hades_1037" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	Cosmetic_MainHallThroneA =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_ThroneA",
		ResourceName = "Gems",
		ResourceCost = 2000,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierSCosmeticCount,
		},
		SetAnimations =
		{
			HouseThroneBack01 = "HouseThroneBack02",
		},
		DeactivateAnimations =
		{
			HouseThroneBack01 = "HouseThroneBack01",
		},
		DeathAreaFocusId = 422027,
		AddConstructionPresentation = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- You look a bit uncomfortable, Father. Here, why don't you have a seat?
				{ Cue = "/VO/ZagreusHome_2818" },
			},
			{
				PreLineWait = 0.8,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- What, what happened to my... nrgh, another of your foolish pranks.
				{ Cue = "/VO/Hades_1030" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_MainHallSarcophagi =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_Sarcophagi",
		ResourceName = "Gems",
		ResourceCost = 530,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		ActivateIds = { 426589, 426587, 426586, 426588, },
		DeathAreaFocusId = 426587,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Let's set some decadent old tombs right smack in the middle of the hall back there.
				{ Cue = "/VO/ZagreusHome_1772" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- The dead need not be coddled with such things.
				{ Cue = "/VO/Hades_0685" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	Cosmetic_SouthHallTrimBrown =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_SwatchGold",
		ResourceName = "Gems",
		ResourceCost = 5,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		SetColorIds =
		{
			425240, 425241, 425242, 425243, 392530, 392529, 392528, 392531, 392535, 392532, 392533, 392534, 392543, 392540, 392541, 392542, 425244,
			425245, 425246, 425247, 425248, 425249, 425250, 425251, 425252, 425253, 425254, 425255, 425983, 425982, 425981, 425980, 425987, 425986,
			425985, 425984, 425991, 425990, 425989, 425988, 426066, 426065, 426064, 426063,
		},
		SetColorValue = { 148, 99, 27, 255 },
		DeathAreaFocusId = 425986,
		RemoveCosmetics =
		{
			"Cosmetic_SouthHallTrimPurple",
			"Cosmetic_SouthHallTrimGrey",
			--"Cosmetic_SouthHallTrimBlue",
			"Cosmetic_SouthHallTrimRed",
			--"Cosmetic_SouthHallTrimGreen",
		},
		RotateOnly = true,
		RevealGlobalVoiceLines = "TrimColorResponseVoiceLines",
		RevealReactionGlobalVoiceLines = "HadesTrimColorReactionVoiceLines",
	},

	Cosmetic_SouthHallTrimPurple =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_SouthHallTrimBrown", },
		Icon = "CosmeticIcon_SwatchPurple",
		ResourceName = "Gems",
		ResourceCost = 10,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		SetColorValue = { 110, 105, 207, 255 },
		DeathAreaFocusId = 425986,
		RemoveCosmetics =
		{
			"Cosmetic_SouthHallTrimBrown",
			"Cosmetic_SouthHallTrimGrey",
			--"Cosmetic_SouthHallTrimBlue",
			"Cosmetic_SouthHallTrimRed",
			--"Cosmetic_SouthHallTrimGreen",
		},
		RotateOnly = true,
		RevealGlobalVoiceLines = "TrimColorResponseVoiceLines",
		RevealReactionGlobalVoiceLines = "HadesTrimColorReactionVoiceLines",
	},

	Cosmetic_SouthHallTrimGrey =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_SouthHallTrimBrown", },
		Icon = "CosmeticIcon_SwatchGrey",
		SetColorValue = { 125, 125, 125, 255 },
		ResourceName = "Gems",
		ResourceCost = 5,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		DeathAreaFocusId = 425986,
		RemoveCosmetics =
		{
			"Cosmetic_SouthHallTrimBrown",
			"Cosmetic_SouthHallTrimPurple",
			--"Cosmetic_SouthHallTrimBlue",
			"Cosmetic_SouthHallTrimRed",
			--"Cosmetic_SouthHallTrimGreen",
		},
		RotateOnly = true,
		RevealGlobalVoiceLines = "TrimColorResponseVoiceLines",
		RevealReactionGlobalVoiceLines = "HadesTrimColorReactionVoiceLines",
	},

	--[[
	Cosmetic_SouthHallTrimBlue =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_SouthHallTrimBrown", },
		SetColorValue = { 115, 189, 199, 255 },
		DeathAreaFocusId = 425986,
		RemoveCosmetics =
		{
			"Cosmetic_SouthHallTrimBrown",
			"Cosmetic_SouthHallTrimGrey",
			"Cosmetic_SouthHallTrimPurple",
			"Cosmetic_SouthHallTrimRed",
			--"Cosmetic_SouthHallTrimGreen",
		},
		RotateOnly = true,
	},
	]]

	Cosmetic_SouthHallTrimRed =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_SouthHallTrimBrown" },
		Icon = "CosmeticIcon_SwatchRed",
		SetColorValue = { 194, 57, 45, 255 },
		DeathAreaFocusId = 425986,
		ResourceName = "Gems",
		ResourceCost = 10,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		RemoveCosmetics =
		{
			"Cosmetic_SouthHallTrimBrown",
			"Cosmetic_SouthHallTrimGrey",
			"Cosmetic_SouthHallTrimPurple",
			--"Cosmetic_SouthHallTrimBlue",
			--"Cosmetic_SouthHallTrimGreen",
		},
		RotateOnly = true,
		RevealGlobalVoiceLines = "TrimColorResponseVoiceLines",
		RevealReactionGlobalVoiceLines = "HadesTrimColorReactionVoiceLines",
	},

	--[[
	Cosmetic_SouthHallTrimGreen =
	{
		InheritFrom = { "DefaultCosmeticItem", "Cosmetic_SouthHallTrimBrown", },
		SetColorValue = { 105, 138, 84, 255 },
		DeathAreaFocusId = 425986,
		RemoveCosmetics =
		{
			"Cosmetic_SouthHallTrimBrown",
			"Cosmetic_SouthHallTrimGrey",
			"Cosmetic_SouthHallTrimPurple",
			--"Cosmetic_SouthHallTrimBlue",
			"Cosmetic_SouthHallTrimRed",
		},
		RotateOnly = true,
	},
	]]

	Cosmetic_SouthHallFlowers =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_VasePurple",
		ResourceName = "Gems",
		ResourceCost = 20,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
			RequiredTextLines =  { "NyxGift01" },
		},
		RemoveCosmetics =
		{
			"Cosmetic_SouthHallFlowersA",
		},
		ActivateIds = { 426783, 426779, 426781, 426782, 426868, },
		SetAnimations =
		{
			HouseVase07 = "HouseVase07",
		},
		DeathAreaFocusId = 426783,
		ToggleCollision = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- A nice floral arrangement ought to lighten up the mood a little bit.
				{ Cue = "/VO/ZagreusHome_1742" },
			},
			{
				PreLineWait = 0.2,
				ObjectType = "NPC_Nyx_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You are too kind.
				{ Cue = "/VO/Nyx_0243" },
			},
			{
				PreLineWait = 0.6,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You would associate my House with flowers, boy?
				{ Cue = "/VO/Hades_0671" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	Cosmetic_SouthHallFlowersA =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_VaseRed",
		ResourceName = "Gems",
		ResourceCost = 20,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
			RequiredTextLines =  { "NyxGift01" },
		},
		RemoveCosmetics =
		{
			"Cosmetic_SouthHallFlowers",
		},
		ActivateIds = { 426783, 426779, 426781, 426782, 426868, },
		SetAnimations =
		{
			HouseVase07 = "HouseVase07A",
		},
		DeathAreaFocusId = 426783,
		ToggleCollision = true,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I'm sure nobody's going to mind some lovely flowers there.
				{ Cue = "/VO/ZagreusHome_1743" },
			},
			{
				PreLineWait = 0.2,
				ObjectType = "NPC_Nyx_01",
				RequiredSourceValueFalse = "InPartnerConversation",
				-- It is appreciated, child.
				{ Cue = "/VO/Nyx_0241" },
			},
			{
				PreLineWait = 0.6,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- That is no place for flowers, clean that up!
				{ Cue = "/VO/Hades_0672" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	Cosmetic_SouthHallMosaic =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_MosaicWall",
		ResourceName = "Gems",
		ResourceCost = 250,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
			RequiredTextLines = { "MegaeraGift06", "ThanatosGift06", "HypnosGift06",  },
		},
		ActivateIds = { 425850, },
		SetAnimationIds =
		{
			[425850] = "HouseMosaicWall01",
		},

		DeathAreaFocusId = 425850,
		RemoveCosmetics =
		{
			"Cosmetic_SouthHallMosaicB",
		},

		AddConstructionPresentation = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- An intricate mosaic just above my bedchambers should make having to go in feel less bad I think.
				{ Cue = "/VO/ZagreusHome_2600" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- No mosaic shall eliminate your shame, boy!
				{ Cue = "/VO/Hades_0877" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_SouthHallMosaicB =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_MosaicWallB",
		ResourceName = "Gems",
		ResourceCost = 325,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierBCosmeticCount,
			RequiredTextLines = { "TheseusEncounter05" },
		},
		ActivateIds = { 425850, },
		SetAnimationIds =
		{
			[425850] = "HouseMosaicWall02",
		},

		DeathAreaFocusId = 425850,
		RemoveCosmetics =
		{
			"Cosmetic_SouthHallMosaic",
		},

		AddConstructionPresentation = true,
		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Nothing like a mosaic depicting my arch-enemy and the Bull of Minos to spur me on.
				{ Cue = "/VO/ZagreusHome_2815" },
			},
			{
				PreLineWait = 0.7,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Do give the champion of Elysium my best regards when next you're slain by him.
				{ Cue = "/VO/Hades_1028" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_SkullFloorTiles =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_SkullFloorTiles",
		ResourceName = "Gems",
		ResourceCost = 85,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		ActivateIds = { 555753, 555754, 555750, 555752, 555751, },
		DeathAreaFocusId = 555750,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- This should instill a sense of fear in anyone approaching my bedchambers.
				{ Cue = "/VO/ZagreusHome_2811" },
			},
			{
				PreLineWait = 0.6,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- What you do with your wretched bedchambers is your business alone.
				{ Cue = "/VO/Hades_1024" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_KitchenStoveFlame =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem"  },
		Slot = "CosmeticLounge",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		Icon = "Cosmetic_KitchenFlame",
		ActivateIds = { 424276, 424277, 424266, 424278, 424895, 424898, 424897, 424896, 426736, },
		ToggleCollision = true,
		DeathAreaFocusId = 424983,
		AddConstructionPresentation = true,
		ResourceName = "Gems",
		ResourceCost = 180,
		Removable = false,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Should make the climate in the lounge a bit more comfortable for some of us.
				{ Cue = "/VO/ZagreusHome_1080" },
			},
			{
				PreLineWait = 0.9,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You wish for warmth, go visit Asphodel.
				{ Cue = "/VO/Hades_0527" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},
	Cosmetic_KitchenStoveCauldron =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem"  },
		Slot = "CosmeticLounge",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		Icon = "Cosmetic_Cauldron",
		ActivateIds = { 424268, 424282, 424281, 424280, },
		DeathAreaFocusId = 424268,
		InspectPoint = 424983,
		ResourceName = "Gems",
		ResourceCost = 220,
		GameStateRequirements =
		{
			RequiredCosmetics = { "Cosmetic_KitchenStoveFlame", },
		},

		RevealVoiceLines =
		{
			PreLineWait = 0.45,
			-- There's not much on the menu in the lounge but maybe this will help.
			{ Cue = "/VO/ZagreusHome_1081" },
		},
		RevealReactionGlobalVoiceLines = "HadesGhostAdminPurchaseReactionVoiceLines",
	},

	Cosmetic_LoungeLiquor =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem"  },
		Slot = "CosmeticLounge",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredNumCosmeticsMin = ConstantsData.TierSCosmeticCount,
		},
		Icon = "Cosmetic_LiquorShelf",
		ActivateIds = { 424270, 426120, },
		DeathAreaFocusId = 424980,
		AddConstructionPresentation = true,
		ResourceName = "Gems",
		ResourceCost = 1500,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- This one's for all the solitary shades hanging around forever in the lounge.
				{ Cue = "/VO/ZagreusHome_1073" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Now I suppose no work will ever be complete.
				{ Cue = "/VO/Hades_0524" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_LoungeShortcut =
	{
		InheritFrom = { "DefaultCosmeticItem", "LoungeItem"  },
		Slot = "CosmeticLounge",
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 5,
			RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		DeactivateIds = { 426106, 426870, 555846, 555845, 555850 },
		ToggleCollision = true,
		DeathAreaFocusId = 424955,
		AddConstructionPresentation = true,
		ResourceName = "SuperGems",
		ResourceCost = 3,

		DistanceTriggers =
		{
			{
				TriggerGroup = "LoungeShortcutUnDim", WithinDistance = 200, FunctionName = "UnDimLounge", Repeat = true,
				RequiredCosmetics = { "Cosmetic_LoungeShortcut" },
			},
			{
				TriggerGroup = "LoungeShortcutDim", WithinDistance = 200, FunctionName = "DimLounge", Repeat = true,
				RequiredCosmetics = { "Cosmetic_LoungeShortcut" },
			},
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Huh maybe I can use this to avoid Father's withering gaze and unwanted feedback.
				{ Cue = "/VO/ZagreusHome_1082" },
			},
			{
				PreLineWait = 0.75,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You think you can avoid me through there, boy?
				{ Cue = "/VO/Hades_0528" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_DrapesBlue  =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_DrapesTeal",
		RotateOnly = true,
		SetAnimations =
		{
			HouseDrapes01A = "HouseDrapes01E",
		},
		GameStateRequirements =
		{
			-- None
		},
		DeathAreaFocusId = 424956,
		ResourceName = "Gems",
		ResourceCost = 15,
		RemoveCosmetics =
		{
			"Cosmetic_DrapesRed",
			"Cosmetic_DrapesGreen",
			"Cosmetic_DrapesGrey",
		},
		RevealGlobalVoiceLines = "DraperyColorResponseVoiceLines",
		RevealReactionGlobalVoiceLines = "HadesDraperyColorReactionVoiceLines",
	},
	Cosmetic_DrapesGreen  =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_DrapesGreen",
		RotateOnly = true,
		SetAnimations =
		{
			HouseDrapes01A = "HouseDrapes01B",
		},
		GameStateRequirements =
		{
			-- None
		},
		DeathAreaFocusId = 424956,
		ResourceName = "Gems",
		ResourceCost = 15,
		RemoveCosmetics =
		{
			"Cosmetic_DrapesBlue",
			"Cosmetic_DrapesRed",
			"Cosmetic_DrapesGrey",
		},
		RevealGlobalVoiceLines = "DraperyColorResponseVoiceLines",
		RevealReactionGlobalVoiceLines = "HadesDraperyColorReactionVoiceLines",
	},
	Cosmetic_DrapesRed =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_DrapesRed",
		RotateOnly = true,
		SetAnimations =
		{
			HouseDrapes01A = "HouseDrapes01A",
		},
		GameStateRequirements =
		{
			-- None
		},
		DeathAreaFocusId = 424956,
		ResourceName = "Gems",
		ResourceCost = 15,
		RemoveCosmetics =
		{
			"Cosmetic_DrapesBlue",
			"Cosmetic_DrapesGreen",
			"Cosmetic_DrapesGrey",
		},
		RevealGlobalVoiceLines = "DraperyColorResponseVoiceLines",
		RevealReactionGlobalVoiceLines = "HadesDraperyColorReactionVoiceLines",
	},
	Cosmetic_DrapesGrey =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_DrapesBone",
		RotateOnly = true,
		SetAnimations =
		{
			HouseDrapes01A = "HouseDrapes01D",
		},
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = 8,
		},
		DeathAreaFocusId = 424956,
		ResourceName = "Gems",
		ResourceCost = 15,
		RemoveCosmetics =
		{
			"Cosmetic_DrapesRed",
			"Cosmetic_DrapesBlue",
			"Cosmetic_DrapesGreen",
		},
		RevealGlobalVoiceLines = "DraperyColorResponseVoiceLines",
		RevealReactionGlobalVoiceLines = "HadesDraperyColorReactionVoiceLines",
	},

	Cosmetic_LaurelsRed =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_LaurelsRed",
		RotateOnly = true,
		SetAnimations =
		{
			HouseFlourish01 = "HouseFlourish01",
		},
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		DeathAreaFocusId = 424956,
		ResourceName = "Gems",
		ResourceCost = 30,
		RemoveCosmetics =
		{
			"Cosmetic_LaurelsSkulls",
			"Cosmetic_LaurelsBlue",
		},
	},

	Cosmetic_LaurelsBlue =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_LaurelsBlue",
		RotateOnly = true,
		SetAnimations =
		{
			HouseFlourish01 = "HouseFlourish01b",
		},
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		DeathAreaFocusId = 424956,
		ResourceName = "Gems",
		ResourceCost = 30,
		RemoveCosmetics =
		{
			"Cosmetic_LaurelsSkulls",
			"Cosmetic_LaurelsRed",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- These decorative laurels ought to give us an appreciable touch of dignity no doubt.
				{ Cue = "/VO/ZagreusHome_2601" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You would squander your earnings on that?
				{ Cue = "/VO/Hades_0878" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_LaurelsSkulls =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_LaurelsSkulls",
		RotateOnly = true,
		SetAnimations =
		{
			HouseFlourish01 = "HouseFlourish01a",
		},
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		DeathAreaFocusId = 424956,
		ResourceName = "Gems",
		ResourceCost = 35,
		RemoveCosmetics =
		{
			"Cosmetic_LaurelsRed",
			"Cosmetic_LaurelsBlue",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I swear, who would purchase laurels, when they could earn them in sporting competition?
				{ Cue = "/VO/ZagreusHome_2602" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Only those with pure contempt for honest victory.
				{ Cue = "/VO/Hades_0879" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_WallWeaponBident =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_WallWeaponBident",
		RotateOnly = true,
		SetAnimations =
		{
			HouseBident01 = "HouseBident01",
		},
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		DeathAreaFocusId = 422524,
		ResourceName = "Gems",
		ResourceCost = 150,
		RemoveCosmetics =
		{
			"Cosmetic_WallWeaponSword",
			"Cosmetic_WallWeaponAxe",
		},
	},

	Cosmetic_WallWeaponSword =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_WallWeaponSword",
		RotateOnly = true,
		SetAnimations =
		{
			HouseBident01 = "HouseSword01",
		},
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		DeathAreaFocusId = 422524,
		ResourceName = "Gems",
		ResourceCost = 130,
		RemoveCosmetics =
		{
			"Cosmetic_WallWeaponBident",
			"Cosmetic_WallWeaponAxe",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Perhaps my chambers will look even better with these blades ominously displayed on either side.
				{ Cue = "/VO/ZagreusHome_2813" },
			},
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Those blades don't even work. No wonder you prefer them so.
				{ Cue = "/VO/Hades_1026" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_WallWeaponAxe =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "Cosmetic_WallWeaponAxe",
		RotateOnly = true,
		SetAnimations =
		{
			HouseBident01 = "HouseAxe01",
		},
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		DeathAreaFocusId = 422524,
		ResourceName = "Gems",
		ResourceCost = 140,
		RemoveCosmetics =
		{
			"Cosmetic_WallWeaponBident",
			"Cosmetic_WallWeaponSword",
		},

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- You know I've always had a thing for double-bladed axes?
				{ Cue = "/VO/ZagreusHome_2814" },
			},
			{
				PreLineWait = 0.4,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- I've always had a thing for silence around here!
				{ Cue = "/VO/Hades_1027" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	HouseCouch02A =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Slot = "CosmeticBedroom",
		Icon = "Cosmetic_BedroomCouch_01",
		ResourceName = "Gems",
		ResourceCost = 40,
		SkipFade = true,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierCCosmeticCount,
		},
		ActivateIds = { 422261, },
		ToggleCollision = true,
		DeathAreaFocusId = 424948, -- zag's bedroom doorway
		InspectPoint = 426230,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- I have this crippling compulsion to commission objects I am never, ever going to sit on.
				{ Cue = "/VO/ZagreusHome_1774" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- None shall sit besides myself and Cerberus!
				{ Cue = "/VO/Hades_0910" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	HouseRug03B =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Icon = "CosmeticIcon_SmallRug_02",
		Slot = "CosmeticBedroom",
		ResourceName = "Gems",
		ResourceCost = 20,
		SkipFade = true,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		ActivateIds = { 426220, },
		DeathAreaFocusId = 424948, -- zag's bedroom doorway
		InspectPoint = 426231,
		RevealGlobalVoiceLines = "RugPurchaseResponseVoiceLines",
	},

	HouseWeights01 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Slot = "CosmeticBedroom",
		Icon = "Cosmetic_Weights_01",
		ResourceName = "Gems",
		ResourceCost = 300,
		SkipFade = true,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		ActivateIds = { 426209, },
		ToggleCollision = true,
		DeathAreaFocusId = 424948, -- zag's bedroom doorway
		InspectPoint = 426228,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- They say that only Heracles himself can lift these things? I'll take them, then!
				{ Cue = "/VO/ZagreusHome_1765" },
			},
			{
				PreLineWait = 0.8,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- You think you have the necessary strength?
				{ Cue = "/VO/Hades_0680" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,

	},

	HouseGamingTable01 =
	{
		InheritFrom = { "DefaultCosmeticItem" },
		Slot = "CosmeticBedroom",
		Icon = "Cosmetic_GamingTable",
		ResourceName = "Gems",
		ResourceCost = 430,
		SkipFade = true,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierACosmeticCount,
		},
		ActivateIds = { 426213, 426210, 426222, },
		ConnectedIds = { 426213, },
		ToggleCollision = true,
		DeathAreaFocusId = 424948, -- zag's bedroom doorway
		InspectPoint = 426229,

		RevealVoiceLines =
		{
			{
				PreLineWait = 0.35,
				-- Always wanted my own entertainment table, and I can finally afford one, I suppose.
				{ Cue = "/VO/ZagreusHome_1775" },
			},
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Hades_01",
				RequiredFalseTextLinesThisRoom = { "HadesAboutOlympianReunionQuest01A" },
				RequiredSourceValueFalse = "InPartnerConversation",
				-- Keep entertaining yourself, boy.
				{ Cue = "/VO/Hades_0688" },
			},
		},
		SkipRevealReactionGlobalVoiceLines = true,
	},

	Cosmetic_HouseCandles01 =
	{
		InheritFrom = { "DefaultCosmeticItem", },
		Icon = "CosmeticIcon_HouseCandles",
		ResourceName = "Gems",
		ResourceCost = 20,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		ActivateGroups = { "Foreground_Candles_01", },
		DeactivateGroups = { "Foreground_Candles_02", },
		RemoveCosmetics =
		{
			"Cosmetic_HouseCandles02",
		},
		DeathAreaFocusId = 555853,
		RotateOnly = true,
	},

	Cosmetic_HouseCandles02 =
	{
		InheritFrom = { "DefaultCosmeticItem", },
		Icon = "CosmeticIcon_CandleLarge",
		ResourceName = "Gems",
		ResourceCost = 25,
		GameStateRequirements =
		{
			RequiredNumCosmeticsMin = ConstantsData.TierDCosmeticCount,
		},
		ActivateGroups = { "Foreground_Candles_02", },
		DeactivateGroups = { "Foreground_Candles_01", },
		RemoveCosmetics =
		{
			"Cosmetic_HouseCandles01",
		},
		DeathAreaFocusId = 555852,
		RotateOnly = true,
	},

	GiftRack =
	{

	},
}

ScreenData.GhostAdmin =
{
	DisplayOrder =
	{
		"Critical",
		"CosmeticMainHall",
		"CosmeticNorthHall",
		"CosmeticLounge",
		"CosmeticBedroom",
		"Music",
	},
	ResourceOrder =
	{
		"UISkins",
		"Gems",
		"MetaPoints",
		"LockKeys",
		"SuperGems",
		"SuperLockKeys",
		"GiftPoints",
		"SuperGiftPoints",
	},
	ItemStartX = 980,
	ItemStartY = 345,
	IconOffsetX = -400,
	IconOffsetY = 0,
	EntryYSpacer = 97,
	ItemsPerPage = 6,
	ScrollOffset = 0,
}