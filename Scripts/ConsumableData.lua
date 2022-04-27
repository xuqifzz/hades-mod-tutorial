ConsumableData =
{
	BaseConsumable =
	{
		Icon = "Shop_Jug",
		UsePromptOffsetX = 65,
		UsePromptOffsetY = 0,
		DebugOnly = true,
	},

	Tier1Consumable =
	{
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.00,
				MaxMultiplier = 1.00,
			},
			Rare =
			{
				MinMultiplier = 1.3,
				MaxMultiplier = 1.5,
			},
			Epic =
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.5,
			}
		}
	},

	HealDropRange =
	{
		InheritFrom = { "BaseConsumable" },
		CustomNameWithMetaUpgrade =
		{
			MetaUpgradeName = "HealingReductionShrineUpgrade",
			Name = "HealDropRange_Reduced",
		},
		Icon = "Shop_Vase",
		HealCostPerPercent = 1,
		HealFraction =
		{
			BaseMin = 0.21,
			BaseMax = 0.39,
		},
		HideWorldText = true,
		UseText = "UseHealDrop",
		PurchaseText = "Shop_UseHealDrop",
		PurchaseRequirements =
		{
			PlayerMaxHealthFraction = 1,
		},
		ConsumeSound = "/Leftovers/Menu Sounds/TalismanPaperEquipLEGENDARY",
		OnConsumedGlobalVoiceLines = "UsedHealDropVoiceLines",
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealth",
			},
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHealPercent",
				Format = "Percent",
			},
			{
				ExtractAs = "HealingReduction",
				Format = "TotalMetaUpgradeChangeValue",
				MetaUpgradeName = "HealingReductionShrineUpgrade"
			}
		}
	},

	MetaDropRange =
	{
		InheritFrom = { "BaseConsumable" },
		Icon = "Shop_Pearl",
		-- OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Crystal",
		CostPerMetaPoint = 0.75,
		AddResources =
		{
			MetaPoints =
			{
				BaseMin = 20,
				BaseMax = 30,
				AsInt = true,
			},
		},
		UseText = "UseTakeItem",
	},
	GemDropRange =
	{
		InheritFrom = { "BaseConsumable" },
		Icon = "Shop_Treasure",
		-- OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Crystal",
		CostPerGem = 2.5,
		AddResources =
		{
			Gems =
			{
				BaseMin = 10,
				BaseMax = 15,
				AsInt = true,
			},
		},
		UseText = "UseTakeItem",
	},
	MetaPointSmall =
	{
		InheritFrom = { "MetaDropRange" },
		SpawnSound = "/SFX/Player Sounds/DarknessRewardDrop",
		ConsumeSound = "/SFX/Player Sounds/DarknessCollectionPickup",
		HideWorldText = true,
	},

	LastStandDrop =
	{
		InheritFrom = { "BaseConsumable" },
		RequiredInactiveMetaUpgrade = "ExtraChanceReplenishMetaUpgrade",
		ConsumeSound = "/EmptyCue",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Jar",
		Icon = "Shop_Jug",
		Cost = 200,
		RequiredMinMaximumLastStands = 1,
		NotMaxLastStands = true,
		PurchaseRequirements =
		{
			NotMaxLastStands = true,
		},
		UseFunctionNames =  { "AddLastStand", "GainLastStandPresentation"} ,
		UseFunctionArgs =
		{
			{
				Icon = "ExtraLifeStyx",
				WeaponName = "LastStandMetaUpgradeShield",
				HealFraction = 0.5
			},
			{}
		},
	},

	HealDropMinor =
	{
		InheritFrom = { "BaseConsumable" },
		Cost = 30,
		HealFixed = 10,
		UseText = "UseHealDrop",
		PurchaseText = "Shop_UseHealDrop",
		HideWorldText = true,
		OnConsumedGlobalVoiceLines = "UsedHealDropVoiceLines",
	},

	GiftDrop =
	{
		InheritFrom = { "BaseConsumable" },
		RequiredBiomes = { "Elysium", "Styx" },
		Cost = 200,
		AddResources =
		{
			GiftPoints = 1,
		},
		UseText = "UseTakeItem",
		UsePromptOffsetY = 30,
		UseText = "UseGiftPointDrop",
		PurchaseText = "Shop_UseGiftPointDrop",
		SpawnSound = "/SFX/GiftAmbrosiaBottleDrop",
		ConsumeSound = "/SFX/GiftAmbrosiaBottlePickup",
		PlayInteract = true,
		HideWorldText = true,
		RequiredMinCompletedRuns = 2,
		OnSpawnVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.75,
			SuccessiveChanceToPlay = 0.05,

			-- A bottle of nectar.
			{ Cue = "/VO/ZagreusField_2582" },
			-- Sweet nectar.
			{ Cue = "/VO/ZagreusField_2583", RequiredPlayed = { "/VO/ZagreusField_2582" } },
			-- Nectar bottle.
			{ Cue = "/VO/ZagreusField_2584", RequiredPlayed = { "/VO/ZagreusField_2582" } },
			-- Some nectar there.
			{ Cue = "/VO/ZagreusField_2585", RequiredPlayed = { "/VO/ZagreusField_2582" } },
		},
		ConsumedVoiceLines =
		{
			{
				PlayOnce = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				RequiredCosmetics = { "GiftDropRunProgress" },

				-- That Nectar also amplified one of my Boons.
				{ Cue = "/VO/ZagreusField_2922" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				SuccessiveChanceToPlayAll = 0.2,

				-- Who should I give this to...
				{ Cue = "/VO/ZagreusField_2586" },
				-- Sweet.
				{ Cue = "/VO/ZagreusField_2587", RequiredPlayed = { "/VO/ZagreusField_2586" } },
				-- Perfect.
				{ Cue = "/VO/ZagreusField_2588", RequiredPlayed = { "/VO/ZagreusField_2586" } },
				-- Looks like a good batch.
				{ Cue = "/VO/ZagreusField_2589", RequiredPlayed = { "/VO/ZagreusField_2586" } },
				-- Who doesn't love this stuff.
				{ Cue = "/VO/ZagreusField_2590", RequiredPlayed = { "/VO/ZagreusField_2586" } },
				-- The perfect gift.
				{ Cue = "/VO/ZagreusField_2591", RequiredPlayed = { "/VO/ZagreusField_2586" } },
			},
			[3] = GlobalVoiceLines.GiftDropPickUpVoiceLines,
		},
	},

	GiftDropRunProgress =
	{
		InheritFrom = { "GiftDrop", },
		GenusName = "GiftDrop",
		UseText = "UseGiftPointDropRunProgress",
		AddStackTraits = 1,
		AddStackTraitsThread = true,
		AddStackTraitsDelay = 0.5,
	},

	HarvestBoonDrop =
	{
		InheritFrom = { "BaseConsumable", "Tier1Consumable" },
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1,
				MaxMultiplier = 1,
			},
			Rare =
			{
				MinMultiplier = 2,
				MaxMultiplier = 2,
			},
			Epic =
			{
				MinMultiplier = 3,
				MaxMultiplier = 3,
			}
		},
		RequiredUpgradeableGodTraits = 1,
		RequiredFalseTrait = "HarvestBoonTrait",
		Icon = "Boon_Demeter_08",
		ConsumeSound = "/EmptyCue",
		ChanceToPlay = 0.7,
		Cost = 0,
		UseFunctionNames =  { "HarvestBoons" } ,
		UseFunctionArgs = {
			{
				NumTraits = { BaseValue = 1 },
			},
		},
		RoomsPerUpgrade = TraitData.HarvestBoonTrait.RoomsPerUpgrade,
		UpgradedTraitNum = { BaseValue = 1 },
		ExtractValues =
		{
			{
				Key = "UpgradedTraitNum",
				ExtractAs = "TooltipTraitNum",
			},
			{
				Key = "RoomsPerUpgrade",
				ExtractAs = "TooltipRoomInterval",
			}
		},
	},

	SuperGiftDrop =
	{
		InheritFrom = { "BaseConsumable" },
		IgnoreCostIncrease = true,
		Cost = 1100,
		Icon = "SuperGiftIconSmall",
		AddResources =
		{
			SuperGiftPoints = 1,
		},
		OnUsedFunctionName = "BountyEarnedPresentation",
		UsePromptOffsetY = 30,
		UseText = "UseSuperGiftPointDrop",
		PurchaseText = "Shop_UseSuperGiftPointDrop",
		SpawnSound = "/SFX/SuperGiftAmbrosiaBottleDrop",
		ConsumeSound = "/SFX/SuperGiftAmbrosiaBottlePickup",
		PlayInteract = true,
		HideWorldText = true,

		OnSpawnVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.7,
			SuccessiveChanceToPlay = 0.1,

			--That a genuine Ambrosia bottle there?
			{ Cue = "/VO/ZagreusField_2945", PlayOnce = true, },
			-- An Ambrosia bottle...
			{ Cue = "/VO/ZagreusField_0729", RequiredPlayed = { "/VO/ZagreusField_2945" }, },
			-- Oh...
			{ Cue = "/VO/ZagreusField_0287", RequiredPlayed = { "/VO/ZagreusField_2945" }, },
		},
		ConsumedVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				SuccessiveChanceToPlayAll = 0.2,

				-- Huh, I can't seem to open it...
				{ Cue = "/VO/ZagreusField_2946", PlayOnce = true, },
				-- Must be something I can do with this.
				{ Cue = "/VO/ZagreusField_2947", RequiredPlayed = { "/VO/ZagreusField_2946" } },
				-- Someone back home would practically die for this stuff.
				{ Cue = "/VO/ZagreusField_0730", SuccessiveChanceToPlay = 0.1, RequiredAnyTextLines = { "MegaeraBedroom02", "MegaeraBedroom02B", "ThanatosFieldBuildingTrust01", "SkellyTrueDeathQuestComplete", "SisyphusLiberationQuestComplete" }, RequiredPlayed = { "/VO/ZagreusField_2946" } },
				-- Look at this...
				{ Cue = "/VO/ZagreusField_0284", RequiredPlayed = { "/VO/ZagreusField_2946" } },
				-- What a find.
				{ Cue = "/VO/ZagreusField_0286", RequiredPlayed = { "/VO/ZagreusField_2946" } },
				-- A souvenir.
				{ Cue = "/VO/ZagreusField_0288", RequiredPlayed = { "/VO/ZagreusField_2946" } },
				-- Ambrosia.
				{ Cue = "/VO/ZagreusField_1035", RequiredPlayed = { "/VO/ZagreusField_2946" } },
				-- Very nice.
				{ Cue = "/VO/ZagreusField_0228", RequiredPlayed = { "/VO/ZagreusField_2946" } },
				-- I'll just help myself.
				{ Cue = "/VO/ZagreusField_0235", RequiredPlayed = { "/VO/ZagreusField_2946" } },
				-- The good stuff.
				{ Cue = "/VO/ZagreusField_1039", RequiredPlayed = { "/VO/ZagreusField_2946" } },
				-- Fit for a god.
				{ Cue = "/VO/ZagreusField_1040", RequiredPlayed = { "/VO/ZagreusField_2946" } },
			},
			[2] = GlobalVoiceLines.GiftDropPickUpVoiceLines
		},
	},

	LockKeyDrop =
	{
		InheritFrom = { "BaseConsumable" },
		Cost = 50,
		AddResources =
		{
			LockKeys = 1,
		},
		UseText = "UseLockKeyDrop",
		PurchaseText = "Shop_UseLockKeyDrop",
		SpawnSound = "/SFX/KeyDrop",
		ConsumeSound = "/SFX/KeyPickup",
		PlayInteract = true,
		HideWorldText = true,
		OnSpawnVoiceLines =
		{
			PlayOnce = true,
			PreLineWait = 0.85,

			-- It's a Skeleton Key...
			-- { Cue = "/VO/ZagreusField_0731", PlayOnce = true },
			-- It's a key...
			-- { Cue = "/VO/ZagreusField_0384", PlayOnce = true },

			-- A Chthonic Key...
			{ Cue = "/VO/ZagreusField_2571", SuccessiveChanceToPlay = 0.02 },
		},
		ConsumedVoiceLines =
		{
			{
				PlayOnce = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				RequiredCosmetics = { "LockKeyDropRunProgress" },
				RequiredMetaUpgradeSelected = "RerollPanelMetaUpgrade",
				RequiredFalsePlayed = { "/VO/ZagreusField_2920" },

				-- That key, it granted me Fated Persuasion.
				{ Cue = "/VO/ZagreusField_4096" },
			},
			{
				PlayOnce = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				RequiredCosmetics = { "LockKeyDropRunProgress" },
				RequiredFalsePlayed = { "/VO/ZagreusField_4096" },

				-- That key, it granted me Fated Authority.
				{ Cue = "/VO/ZagreusField_2920" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				PlayOnce = true,
				RequiredCompletedRuns = 0,

				-- Wonder where I can use this.
				{ Cue = "/VO/ZagreusField_0909" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				RequiredLifetimeResourcesGainedMax = { LockKeys = 8 },
				RequiredMinCompletedRuns = 1,

				-- This can unlock a weapon back at home.
				{ Cue = "/VO/ZagreusField_0381", RequiredPlayed = "/VO/ZagreusField_0656", RequiredMinNumLockedWeapons = 1 },
				-- I can use this to unlock a weapon.
				{ Cue = "/VO/ZagreusField_0382", RequiredPlayed = "/VO/ZagreusField_0656", RequiredMinNumLockedWeapons = 1 },
				-- This can unlock something back home.
				{ Cue = "/VO/ZagreusField_0656", },
				-- A key to a weapon...
				{ Cue = "/VO/ZagreusField_0383", RequiredPlayed = "/VO/ZagreusField_0656", RequiredMinNumLockedWeapons = 1 },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				SuccessiveChanceToPlay = 0.15,
				Cooldowns =
				{
					{ Name = "ZagreusAnyQuipSpeech" },
				},

				-- Should be useful.
				{ Cue = "/VO/ZagreusField_0380", },
				-- Should come in handy.
				{ Cue = "/VO/ZagreusField_0118b" },
				-- I'll just keep this on me.
				{ Cue = "/VO/ZagreusField_0658", },
				-- One for the stash.
				{ Cue = "/VO/ZagreusField_0915", },
				-- That's one more.
				{ Cue = "/VO/ZagreusField_0916", },
				-- How many have I got now?
				{ Cue = "/VO/ZagreusField_0917", RequiredResourcesMin = { LockKeys = 30 } },
				-- Another key.
				{ Cue = "/VO/ZagreusField_0918", },
				-- A key for back home.
				{ Cue = "/VO/ZagreusField_0657", RequiredLifetimeResourcesSpentMax = { LockKeys = 50 }, },
				-- I can use that back home.
				{ Cue = "/VO/ZagreusField_0436", RequiredLifetimeResourcesSpentMax = { LockKeys = 50 }, },
			}
		},
	},

	LockKeyDropRunProgress =
	{
		InheritFrom = { "LockKeyDrop", },
		GenusName = "LockKeyDrop",
		UseText = "UseLockKeyDropRunProgress",
		AddRerolls = 1,
		AddRerollArgs =
		{
			Thread = true,
			Delay = 0.5,
		}
	},

	AmmoPack =
	{
		InheritFrom = { "BaseConsumable" },
		Cost = 0,
		AddAmmo = 1,
		HideWorldText = true,
		CannotUseText = "AmmoPackCannotUse",
		CannotUseSound = "/Leftovers/SFX/OutOfAmmo",
		ConsumeSound = "/SFX/BloodstoneAmmoPickup",

		MagnetismEscalateDelay = 25.0,
		MagnetismHintRemainingTime = 5.0,
		MagnetismEscalateAmount = 99000,
	},

	MoneyDrop =
	{
		InheritFrom = { "BaseConsumable", "Tier1Consumable" },
		Icon = "Boon_Athena_09",
		Cost = 0,
		DropMoney = {
			BaseMin = 100,
			BaseMax = 100,
			DepthMult = 0.05,
			AsInt = true,
		},
		ConsumeSound = "/Leftovers/Menu Sounds/MakingMoneyChaChing",
		UpgradeChoiceText = "UpgradeChoiceMenu_PermanentItem",
		HideWorldText = true,
	},

	FallbackMoneyDrop =
	{
		InheritFrom = { "MoneyDrop" },
		Cost = 0,
		DropMoney = {
			BaseMin = 100,
			BaseMax = 100,
			DepthMult = 0.05,
			AsInt = true,
		},
		HideWorldText = true,
	},

	RoomRewardConsolationPrize =
	{
		InheritFrom = { "BaseConsumable", },
		UsePromptOffsetY = 30,
		Cost =
		{
			BaseValue = 10,
			DepthMult = 0,
			AsInt = true,
		},
		HealFraction = 0.01,
		UseText = "UseHealDrop",
		PurchaseText = "Shop_UseHealDrop",
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealth",
			},
		},
		BlockExitText = "ExitBlockedByHeal",
		PlayInteract = true,
		HideWorldText = true,
		SpawnSound = "/SFX/CrappyRewardDrop",
		ConsumeSound = "/SFX/CrappyRewardPickup",

		OnSpawnVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.75,
			SuccessiveChanceToPlayAll = 0.33,
			CooldownTime = 6,

			-- Hey, it's food!
			{ Cue = "/VO/ZagreusField_0734", RequiredPlayed = { "/VO/ZagreusField_1200" } },
			-- All I got was that stupid onion.
			{ Cue = "/VO/ZagreusField_1198", RequiredPlayed = { "/VO/ZagreusField_1200" } },
			-- An onion.
			{ Cue = "/VO/ZagreusField_1199", RequiredPlayed = { "/VO/ZagreusField_1200" } },
			-- An onion. Great.
			{ Cue = "/VO/ZagreusField_1200", },
			-- Father's famous sense of humor shining through again.
			{ Cue = "/VO/ZagreusField_1201", RequiredPlayed = { "/VO/ZagreusField_1200" } },
			-- I was robbed.
			{ Cue = "/VO/ZagreusField_1202", RequiredPlayed = { "/VO/ZagreusField_1200" } },
			-- Really...
			{ Cue = "/VO/ZagreusField_1203", RequiredPlayed = { "/VO/ZagreusField_1200" } },
		},
		ConsumedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.55,
			SuccessiveChanceToPlayAll = 0.33,
			CooldownTime = 6,

			-- An onion. Instead of... whatever I was supposed to get. Ugh.
			{ Cue = "/VO/ZagreusField_1206" },
			-- Five-second rule. That was five seconds right?
			{ Cue = "/VO/ZagreusField_0735", RequiredPlayed = { "/VO/ZagreusField_1206" }, RequiredFalseEncounters = { "Shop" } },
			-- Disgusting.
			{ Cue = "/VO/ZagreusField_1204", RequiredPlayed = { "/VO/ZagreusField_1206" } },
			-- I don't like it, but I'll eat it.
			{ Cue = "/VO/ZagreusField_1205", RequiredPlayed = { "/VO/ZagreusField_1206" } },
			-- Eugghh.
			{ Cue = "/VO/ZagreusField_1207", RequiredPlayed = { "/VO/ZagreusField_1206" } },
			-- Buuuhhh.
			{ Cue = "/VO/ZagreusField_1208", RequiredPlayed = { "/VO/ZagreusField_1206" } },
			-- Yuck.
			{ Cue = "/VO/ZagreusField_1209", RequiredPlayed = { "/VO/ZagreusField_1206" } },
			-- Acquired taste I guess.
			{ Cue = "/VO/ZagreusField_1210", RequiredPlayed = { "/VO/ZagreusField_1206" } },
			-- At least they peeled it for me.
			{ Cue = "/VO/ZagreusField_1211", RequiredPlayed = { "/VO/ZagreusField_1206" } },
			-- Oy...
			{ Cue = "/VO/ZagreusField_1212", RequiredPlayed = { "/VO/ZagreusField_1206" } },
			-- Mm that was terrible.
			{ Cue = "/VO/ZagreusField_1213", RequiredPlayed = { "/VO/ZagreusField_1206" } },
			-- Mm that was... not bad.
			{ Cue = "/VO/ZagreusField_1214", RequiredPlayed = { "/VO/ZagreusField_1206", "/VO/ZagreusField_1206", "/VO/ZagreusField_1207", "/VO/ZagreusField_1213" } },
		},
	},

	RoomRewardHealDrop =
	{
		InheritFrom = { "BaseConsumable", },
		UsePromptOffsetY = 30,
		Cost =
		{
			BaseValue = 50,
			DepthMult = 0,
			AsInt = true,
		},
		HealFraction = 0.4,
		UseText = "UseHealDrop",
		PurchaseText = "Shop_UseHealDrop",
		PurchaseRequirements =
		{
			PlayerMaxHealthFraction = 1,
		},
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealth",
			},
		},
		BlockExitText = "ExitBlockedByHeal",
		PlayInteract = true,
		HideWorldText = true,
		SpawnSound = "/Leftovers/Menu Sounds/TalismanPowderUpLEGENDARY",

		OnSpawnVoiceLines =
		{
			-- Hey, it's food!
			{ Cue = "/VO/ZagreusField_0734", PreLineWait = 0.65, SuccessiveChanceToPlay = 0.05, },
		},
		OnConsumedGlobalVoiceLines = "UsedHealDropVoiceLines",
	},


	CerberusKey =
	{
		InheritFrom = { "BaseConsumable", },
		BlockExitText = "ExitBlockedByHeal",
		UsePromptOffsetY = 30,
		PlayInteract = true,
		HideWorldText = true,
	},

	RoomRewardMaxHealthDrop =
	{
		InheritFrom = { "BaseConsumable", },
		Cost =
		{
			BaseValue = 125,
			DepthMult = 0,
			AsInt = true,
		},
		AddMaxHealth = 25,
		UseText = "UseMaxHealthDrop",
		UsePromptOffsetY = 30,
		PurchaseText = "Shop_UseMaxHealthDrop",
		BlockExitText = "ExitBlockedByHeal",
		SpawnSound = "/SFX/HealthIncreaseDrop",
		ConsumeSound = "/SFX/HealthIncreasePickup",
		PlayInteract = true,
		HideWorldText = true,

		OnSpawnVoiceLines =
		{
			-- A Centaur Heart...
			{ Cue = "/VO/ZagreusField_0939", ChanceToPlayAgain = 0.02, PreLineWait = 0.65, },
		},

		ConsumedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.55,
			SuccessiveChanceToPlayAll = 0.5,
			RequiredFalseEncounters = { "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", },
			Cooldowns =
			{
				{ Name = "ZagreusAnyQuipSpeech", Time = 60 },
			},

			-- That ought to keep me going for a bit.
			{ Cue = "/VO/ZagreusField_0737", },
			-- Strength of the Centaurs.
			{ Cue = "/VO/ZagreusField_0940", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- That's good.
			{ Cue = "/VO/ZagreusField_0386", RequiredPlayed = { "/VO/ZagreusField_0737" }, CooldownName = "SaidGoodRecently", CooldownTime = 40, },
			-- Yes.
			{ Cue = "/VO/ZagreusField_0387", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- Better.
			{ Cue = "/VO/ZagreusField_0388", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- Good for the health.
			{ Cue = "/VO/ZagreusField_0389", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- That's a relief.
			{ Cue = "/VO/ZagreusField_0299", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- Much better.
			{ Cue = "/VO/ZagreusField_0300", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- That's better.
			{ Cue = "/VO/ZagreusField_0133", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- I feel stronger.
			{ Cue = "/VO/ZagreusField_3995", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- Feeling stronger.
			{ Cue = "/VO/ZagreusField_3996", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- Feeling good.
			{ Cue = "/VO/ZagreusField_3997", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- Feeling tough.
			{ Cue = "/VO/ZagreusField_3998", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- Centaur strength.
			{ Cue = "/VO/ZagreusField_3999", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- Vitality.
			{ Cue = "/VO/ZagreusField_4000", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- That's life.
			{ Cue = "/VO/ZagreusField_4001", RequiredPlayed = { "/VO/ZagreusField_0737" } },
			-- Should keep me going.
			{ Cue = "/VO/ZagreusField_4002", RequiredPlayed = { "/VO/ZagreusField_0737" } },
		},
		ExtractValues =
		{
			{
				Key = "AddMaxHealth",
				ExtractAs = "TooltipMaxHealth",
				Format = "MaxHealth"
			},
		}
	},

	RoomRewardMoneyDrop =
	{
		InheritFrom = { "BaseConsumable", "Tier1Consumable" },
		Cost =
		{
			BaseValue = 100,
			DepthMult = 0,
			AsInt = true,
		},
		SpawnSound = "/SFX/GoldCoinRewardDrop",
		ConsumeSound = "/SFX/GoldCoinRewardUse",
		UseText = "UseMoneyDrop",
		BlockExitText = "ExitBlockedByMoney",
		PlayInteract = true,
		HideWorldText = true,
		ExitUnlockDelay = 1.1,

		DropMoney = 100,

		OnSpawnVoiceLines =
		{
			-- Coin from the dead...
			{ Cue = "/VO/ZagreusField_0738", ChanceToPlayAgain = 0.01, PreLineWait = 0.65, },
		},

		OnUsedGlobalVoiceLines = "UsedMoneyDropVoiceLines",
	},

	ForbiddenShopItem =
	{
		InheritFrom = { "BaseConsumable", "Tier1Consumable" },
		Cost = 0,
		HideWorldText = true,
		DropMoney = 300,
		DropMoneyRadius = 10,
		UseText = "UseForbiddenItem",
		OnUsedFunctionName = "ForbiddenShopItemTaken",
	},

	MinorMoneyDrop =
	{
		InheritFrom = { "BaseConsumable", "Tier1Consumable", "RoomRewardMoneyDrop" },
		DropMoney = 30,
	},

	RoomRewardMetaPointDrop =
	{
		InheritFrom = { "BaseConsumable", },
		Cost =
		{
			BaseValue = 25,
			DepthMult = 0,
			AsInt = true,
		},
		AddResources =
		{
			MetaPoints = 10,
		},
		SpawnSound = "/SFX/Player Sounds/DarknessRewardDrop",
		ConsumeSound = "/SFX/Player Sounds/DarknessCollectionPickup",
		UseText = "UseMetaPointDrop",
		PurchaseText = "Shop_UseMetaPointDrop",
		BlockExitText = "ExitBlockedByMetaPoint",
		PlayInteract = true,
		HideWorldText = true,

		OnSpawnVoiceLines =
		{
			RequiredFalseEncounters = { "BossHadesPeaceful" },

			-- The Underworld's power.
			{ Cue = "/VO/ZagreusField_0733", ChanceToPlayAgain = 0.01, PreLineWait = 0.65, CooldownName = "SaidUnderworldRecently", CooldownTime = 200, },
		},

		ConsumedVoiceLines =
		{
			{
				PlayOnce = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				RequiredCosmetics = { "RoomRewardMetaPointDropRunProgress" },
				RequiredFalseEncounters = { "BossHadesPeaceful", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", },

				-- That Darkness there felt different than before.
				{ Cue = "/VO/ZagreusField_2919" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				SuccessiveChanceToPlay = 0.5,
				RequiredFalseEncounters = { "BossHadesPeaceful", "ThanatosTartarus", "ThanatosAsphodel", "ThanatosElysium", "ThanatosElysiumIntro", },
				Cooldowns =
				{
					{ Name = "ZagreusAnyQuipSpeech", Time = 60 },
				},

				-- Good.
				{ Cue = "/VO/ZagreusField_0135", CooldownName = "SaidGoodRecently", CooldownTime = 40, },
				-- Nice.
				{ Cue = "/VO/ZagreusField_0229", },
				-- Mmm-hm.
				{ Cue = "/VO/ZagreusField_0275", },
				-- I'll take that.
				{ Cue = "/VO/ZagreusField_0276", },
				-- Sure.
				{ Cue = "/VO/ZagreusField_0277", },
				-- Right.
				{ Cue = "/VO/ZagreusField_0278", },
				-- Mine.
				{ Cue = "/VO/ZagreusField_0273", },
				-- All mine.
				{ Cue = "/VO/ZagreusField_0233", },
				-- Ah.
				{ Cue = "/VO/ZagreusField_1045" },
				-- Something for the Mirror.
				{ Cue = "/VO/ZagreusField_0433" },
				-- The Underworld's power.
				{ Cue = "/VO/ZagreusField_0733", CooldownName = "SaidUnderworldRecently", CooldownTime = 200, },
				-- Darkness.
				{ Cue = "/VO/ZagreusField_1041" },
				-- Hmm.
				{ Cue = "/VO/ZagreusField_1042" },
				-- For the Mirror.
				{ Cue = "/VO/ZagreusField_1043" },
				-- Felt something.
				{ Cue = "/VO/ZagreusField_1044" },
				-- For safe keeping.
				{ Cue = "/VO/ZagreusField_1046" },
				-- By my birthright.
				{ Cue = "/VO/ZagreusField_1047" },
				-- On my authority.
				{ Cue = "/VO/ZagreusField_1048" },
				-- More Darkness.
				{ Cue = "/VO/ZagreusField_3527" },
				-- Some Darkness.
				{ Cue = "/VO/ZagreusField_3528" },
				-- It's dark all right.
				{ Cue = "/VO/ZagreusField_3529" },
				-- Got it.
				{ Cue = "/VO/ZagreusField_3530" },
				-- That's mine.
				{ Cue = "/VO/ZagreusField_3531" },
				-- Mine now.
				{ Cue = "/VO/ZagreusField_3532" },
				-- Mine.
				{ Cue = "/VO/ZagreusField_3533" },
				-- Thank you.
				{ Cue = "/VO/ZagreusField_3534" },
				-- Nyx's power.
				{ Cue = "/VO/ZagreusField_3535", RequiredTextLines = { "NyxFirstMeeting" }, },
				-- Never enough.
				{ Cue = "/VO/ZagreusField_4125", RequiredAccumulatedMetaPoints = 6000 },
				-- Limitless Darkness.
				{ Cue = "/VO/ZagreusField_4126", RequiredAccumulatedMetaPoints = 8000 },
				-- Veiled in Darkness.
				{ Cue = "/VO/ZagreusField_4127", RequiredAccumulatedMetaPoints = 5000 },
				-- Pure Darkness.
				{ Cue = "/VO/ZagreusField_4128", RequiredAccumulatedMetaPoints = 2000 },
				-- Dark thirst.
				{ Cue = "/VO/ZagreusField_4129", RequiredOneOfTraits = { "UnusedWeaponBonusTrait", "UnusedWeaponBonusTraitAddGems" }, },
				-- More...
				{ Cue = "/VO/ZagreusField_4130", RequiredAccumulatedMetaPoints = 4000 },
			},
		},
	},

	StoreRewardMetaPointDrop =
	{
		InheritFrom = { "RoomRewardMetaPointDrop", },
		GenusName = "RoomRewardMetaPointDrop",
		UseText = "UseMetaPointDropRunProgress",
		AddResources =
		{
			MetaPoints = 25,
		},
	},

	StoreRewardLockKeyDrop =
	{
		InheritFrom = { "LockKeyDrop", },
		GenusName = "LockKeyDrop",
		RequiredMaxDepth = 25,
	},

	StoreRewardGemDrop =
	{
		InheritFrom = { "GemDrop", },
		GenusName = "GemDrop",
		UseText = "UseGemDrop",
		RequiredMinDepth = 10,
		RequiredMinCompletedRuns = 2,
		Cost =
		{
			BaseValue = 75,
			DepthMult = 0,
			AsInt = true,
		},
		
		AddResources =
		{
			Gems = 20,
		},
	},

	StoreTrialUpgradeDrop =
	{
		InheritFrom = { "BaseConsumable", },
		RequiredTextLines = { "ChaosGift05" },
		RequiredFalseBiome = "Styx",
		RequiredMinDepth = 20,
		Cost =
		{
			BaseValue = 150,
			DepthMult = 0,
			AsInt = true,
		},
		UseText = "UsePurchaseLoot",
	},
	
	StoreRewardConsolationDrop = 
	{
		InheritFrom = { "RoomRewardConsolationPrize", },
		RequireOneOfEncountersSeen = { "ShrineChallengeTartarus", "ShrineChallengeAsphodel", "ShrineChallengeElysium", },
		RequiredBiomes = { "Tartarus", "Asphodel", "Elysium" },
		RequiredFalseRooms = { "A_PreBoss01", "B_PreBoss01", "C_PreBoss01", "D_Hub" },
		Cost =
		{
			BaseValue = 10,
			DepthMult = 0,
			AsInt = true,
		},
		GenusName = "RoomRewardConsolationPrize",	
	},

	StoreRewardRandomStack = 
	{
		InheritFrom = { "BaseConsumable", },
		RequiredFalseBiome = "Tartarus",
		Cost =
		{
			BaseValue = 50,
			DepthMult = 0,
			AsInt = true,
		},
		ConsumeSound = "/SFX/PomegranatePowerUpDrop",
		UseFunctionName =  "UseStoreRewardRandomStack",
		UseFunctionArgs = { Thread = true, NumTraits = 1, NumStacks = 1, Delay = 0.25 },
		UseText = "UseStoreRewardRandomStack",
		PurchaseText = "UseStoreRewardRandomStack",
		HideWorldText = true,
		PlayInteract = true,

		OnPurchaseGlobalVoiceLines = "PurchasedRandomPomVoiceLines",
	},

	KeepsakeChargeDrop =
	{
		InheritFrom = { "BaseConsumable", },
		Icon = "Shop_Spindle",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Ting",
		RequiredSlottedTrait = "Assist",
		Cost =
		{
			BaseValue = 40,
			DepthMult = 0,
			AsInt = true,
		},
		UseFunctionName =  "AddKeepsakeCharge",
		UseFunctionArgs = { Thread = true, Delay = 0.25, NumCharges = 1 },
		UseText = "UsePurchaseLoot",
	},

	AspectRarityDrop =
	{
		InheritFrom = { "BaseConsumable", },
		RequiredLastInteractedWeaponUpgradeMinLevel = 1,
		RequiredLastInteractedWeaponUpgradeMaxLevel = 4,
		Cost =
		{
			BaseValue = 120,
			DepthMult = 0,
			AsInt = true,
		},
		UseFunctionName =  "AddAspectRarity",
		UseFunctionArgs = { Thread = true, Delay = 0.25 },
		UseText = "UsePurchaseLoot",
	},

	EmptyMaxHealthDrop = 
	{
		InheritFrom = { "BaseConsumable", },
		Icon = "Shop_Soul",
		Cost =
		{
			BaseValue = 100,
			DepthMult = 0,
			AsInt = true,
		},
		AddMaxHealth = 25,
		AddMaxHealthArgs =
		{
			Thread = true,
			Delay = 0.5,
			NoHealing = true,
		},
		ExtractValues =
		{
			{
				Key = "AddMaxHealth",
				ExtractAs = "TooltipMaxHealth",
				Format = "MaxHealth"
			},
		}
	
	},

	ChaosWeaponUpgrade = 
	{
		InheritFrom = { "BaseConsumable", },
		HideWorldText = true,
		PurchaseRequirements =
		{
			RequiredMinWeaponUpgrades = 1,
		},
		CannotPurchaseUseText = "CannotUseChaosWeaponUpgrade",
		CannotPurchaseCombatText = "ChaosAnvil_NeedsMore",
		CannotPurchaseVoiceLines = GlobalVoiceLines.InvalidResourceInteractionVoiceLines,
		Cost =
		{
			BaseValue = 275,
			DepthMult = 0,
			AsInt = true,
		},
		UseFunctionName =  "ChaosHammerUpgrade",
		UseFunctionArgs = { NumTraits = 2 },
		UseText = "UseChaosWeaponUpgrade",
		PurchaseText = "UseChaosWeaponUpgrade",

		ConsumeSound = "/SFX/AnvilOfFatesUse",
		OnPurchaseGlobalVoiceLines = "PurchasedChaosWeaponUpgradeVoiceLines",
	},

	DamageSelfDrop = 
	{
		InheritFrom = { "BaseConsumable", },
		Icon = "Shop_Gold_Blood",
		HideWorldText = true,
		PayoutPerHealthPoint = { BaseMin = 1.1, BaseMax = 1.8 },
		NotEnoughCurrencyVoiceLines = HeroVoiceLines.NotEnoughHealthVoiceLines,
		DropMoneyDelay = 0,
		Cost = 0,
		HealthCost =
		{
			BaseMin = 10,
			BaseMax = 50,
			AsInt = true,
		},
		UseText = "UsePurchaseLoot",

		OnPurchaseSound = "/SFX/StabSplatterSmall",
		OnPurchaseGlobalVoiceLines = "PurchasedDamageSelfDropVoicelines",

		ExtractValues =
		{
			{
				Key = "HealthCost",
				ExtractAs = "TooltipHealthCost",
			},
		}
	},

	RandomStoreItem = 
	{
		InheritFrom = { "BaseConsumable", },
		Icon = "Shop_Twist",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Fabric",
		HideWorldText = true,

		Cost =
		{
			BaseValue = 45,
			DepthMult = 0,
			AsInt = true,
		},
		CloseScreen = true,
		UseFunctionName =  "AwardRandomStoreItem",
		UseFunctionArgs = 
		{
			Traits = 
			{
				"TemporaryWeaponLifeOnKillTrait",
				"TemporaryDoorHealTrait",
				"TemporaryImprovedWeaponTrait",
				"TemporaryMoreAmmoTrait",
				"TemporaryImprovedRangedTrait",
				"TemporaryMoveSpeedTrait",
				"TemporaryBoonRarityTrait",
				"TemporaryLastStandHealTrait",
				"TemporaryArmorDamageTrait",
				"TemporaryAlphaStrikeTrait",
				"TemporaryBackstabTrait",
				"TemporaryImprovedSecondaryTrait",
				"TemporaryImprovedTrapDamageTrait",
				"TemporaryPreloadSuperGenerationTrait",
				"TemporaryForcedSecretDoorTrait",
				"TemporaryForcedChallengeSwitchTrait",
				"TemporaryForcedFishingPointTrait",				
			},
			Consumables = 
			{
				"LastStandDrop",
				--"MetaDropRange",
				--"GemDropRange",
				"EmptyMaxHealthDrop",
				"HealDropRange",
			},
		},
		UseText = "UsePurchaseLoot",
	},

	RandomKeepsake = 
	{
		InheritFrom = { "BaseConsumable", },
		HideWorldText = true,

		Cost =
		{
			BaseValue = 50,
			DepthMult = 0,
			AsInt = true,
		},
		CloseScreen = true,
		UseFunctionName =  "GiveRandomTemporaryKeepsake",
		UseFunctionArgs = 
		{
			Traits = 
			{
				-- row 1
				"MaxHealthKeepsakeTrait", -- cerberus
				"DirectionalArmorTrait", -- achilles
				"BackstabAlphaStrikeTrait", -- nyx
				--"BonusMoneyTrait", -- hypnos
				--"ShopDurationTrait", -- charon
				"LowHealthDamageTrait", -- megaera
				--"PerfectClearDamageBonusTrait", -- thanatos
				"DistanceDamageTrait", -- orpheus
				"LifeOnUrnTrait", -- dusa
				--"ReincarnationTrait", -- skelly
				"VanillaTrait", -- sisyphus
				--"ShieldBossTrait", -- eurydice
				"ShieldAfterHitTrait", -- patroclus
				"ChaosBoonTrait", -- primordial chaos
			},
			Duration = 3,
			ExtractValues = 
			{
				{
					Key = "Duration",
					ExtractAs = "TooltipDuration"
				}
			}
		},
		UseText = "UsePurchaseLoot",
	},

	RoomRewardMetaPointDropRunProgress =
	{
		InheritFrom = { "RoomRewardMetaPointDrop", },
		GenusName = "RoomRewardMetaPointDrop",
		UseText = "UseMetaPointDropRunProgress",
		AddMaxHealth = 5,
		AddMaxHealthArgs =
		{
			Thread = true,
			Delay = 0.5,
		},
		ExtractValues =
		{
			{
				Key = "AddMaxHealth",
				ExtractAs = "TooltipMaxHealth",
				Format = "MaxHealth"
			},
		}
	},

	GemDrop =
	{
		InheritFrom = { "BaseConsumable", },
		RequiredFalseBiome = "Tartarus",
		Cost =
		{
			BaseValue = 50,
			DepthMult = 0,
			AsInt = true,
		},
		AddResources =
		{
			Gems = 5,
		},
		SpawnSound = "/SFX/GemDropSFX",
		ConsumeSound = "/SFX/GemPickup",
		UseText = "UseGemDrop",
		PurchaseText = "Shop_UseGemDrop",
		BlockExitText = "ExitBlockedByShrinePoint",
		PlayInteract = true,
		HideWorldText = true,

		OnSpawnVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			CooldownTime = 40,
			SuccessiveChanceToPlay = 0.1,
			RequiredFalseEncounters = { "BossHadesPeaceful" },

			-- Gemstones.
			{ Cue = "/VO/ZagreusField_2549" },
			-- Assorted gems.
			{ Cue = "/VO/ZagreusField_2550", RequiredPlayed = { "/VO/ZagreusField_2549" } },
			-- There they are.
			{ Cue = "/VO/ZagreusField_2551", RequiredPlayed = { "/VO/ZagreusField_2549" } },
			-- For my trouble.
			{ Cue = "/VO/ZagreusField_2552", RequiredPlayed = { "/VO/ZagreusField_2549" } },
		},

		ConsumedVoiceLines =
		{
			{
				PlayOnce = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				RequiredCosmetics = { "BossAddGems" },
				RequiredRooms = { "A_Boss01", "A_Boss02", "A_Boss03", "B_Boss01", "B_Boss02", "C_Boss01" },

				-- Extra gemstones...! The Vanquisher's Keep.
				{ Cue = "/VO/ZagreusField_4655" },
			},
			{
				PlayOnce = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				RequiredCosmetics = { "GemDropRunProgress" },
				RequiredFalseEncounters = { "BossHadesPeaceful" },

				-- Gemstones, and a little extra for Charon.
				{ Cue = "/VO/ZagreusField_2921" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				SuccessiveChanceToPlay = 0.25,
				RequiredFalseEncounters = { "BossHadesPeaceful" },
				RequiredFalseRooms = { "A_Boss01", "A_Boss02", "A_Boss03", "B_Boss01", "B_Boss02", "C_Boss01", "D_Boss01" },
				Cooldowns =
				{
					{ Name = "ZagreusAnyQuipSpeech" },
				},

				-- Never enough of these back at the House.
				{ Cue = "/VO/ZagreusField_2553" },
				-- Colorful.
				{ Cue = "/VO/ZagreusField_2554" },
				-- I'll take 'em.
				{ Cue = "/VO/ZagreusField_2555" },
				-- Mine now.
				{ Cue = "/VO/ZagreusField_2556" },
				-- I'll hang onto these.
				{ Cue = "/VO/ZagreusField_2557" },
				-- For safe keeping.
				{ Cue = "/VO/ZagreusField_2558" },
				-- For the House.
				{ Cue = "/VO/ZagreusField_2559" },
				-- Claiming these.
				{ Cue = "/VO/ZagreusField_2560" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				ChanceToPlay = 0.2,
				RequiredFalseEncounters = { "BossHadesPeaceful" },
				RequiredFalseRooms = { "A_Boss01", "A_Boss02", "A_Boss03", "B_Boss01", "B_Boss02", "C_Boss01", "D_Boss01" },
				Cooldowns =
				{
					{ Name = "ZagreusAnyQuipSpeech" },
				},

				-- Earning my keep.
				{ Cue = "/VO/ZagreusField_1088" },
				-- Should fetch me something.
				{ Cue = "/VO/ZagreusField_0662" },
				-- I'll just take that.
				{ Cue = "/VO/ZagreusField_0663" },
				-- Shiny.
				{ Cue = "/VO/ZagreusField_0665" },
				-- Good.
				{ Cue = "/VO/ZagreusField_0135", CooldownName = "SaidGoodRecently", CooldownTime = 40, },
				-- Nice.
				{ Cue = "/VO/ZagreusField_0229" },
				-- Mmm-hm.
				{ Cue = "/VO/ZagreusField_0275" },
				-- I'll take that.
				{ Cue = "/VO/ZagreusField_0276" },
				-- Sure.
				{ Cue = "/VO/ZagreusField_0277" },
				-- Right.
				{ Cue = "/VO/ZagreusField_0278" },
				-- Mine.
				{ Cue = "/VO/ZagreusField_0273" },
				-- All mine.
				{ Cue = "/VO/ZagreusField_0233" },
				-- Ah.
				{ Cue = "/VO/ZagreusField_1045" },
			},
		},
	},

	GemDropRunProgress =
	{
		InheritFrom = { "GemDrop", },
		GenusName = "GemDrop",
		UseText = "UseGemDropRunProgress",
		DropMoneyDelay = 0.5,
		DropMoney =
		{
			BaseMin = 20,
			BaseMax = 20,
			AsInt = true,
		},
	},

	SuperGemDrop =
	{
		InheritFrom = { "BaseConsumable", },
		Icon = "SuperGemsIconSmall",
		IgnoreCostIncrease = true,
		Cost =
		{
			BaseValue = 1000,
			DepthMult = 0,
			AsInt = true,
		},
		AddResources =
		{
			SuperGems = 1,
		},
		SpawnSound = "/SFX/SuperGemDropSFX",
		ConsumeSound = "/SFX/SuperGemPickup",
		UseText = "UseSuperGemDrop",
		OnUsedFunctionName = "BountyEarnedPresentation",
		PurchaseText = "Shop_UseSuperGemDrop",
		BlockExitText = "ExitBlockedByShrinePoint",
		PlayInteract = true,
		HideWorldText = true,

		OnSpawnVoiceLines =
		{
			PreLineWait = 0.65,
			CooldownTime = 40,
			SuccessiveChanceToPlay = 0.02,

			-- A diamond...
			{ Cue = "/VO/ZagreusField_2561" },
		},

		ConsumedVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.55,
				SuccessiveChanceToPlayAll = 0.33,
				RequiredMinHealthFraction = 0.3,
				CooldownTime = 6,

				-- Ooh.
				{ Cue = "/VO/ZagreusField_2562", RequiredPlayed = { "/VO/ZagreusField_2565" } },
				-- Aw, for me?
				{ Cue = "/VO/ZagreusField_2563", RequiredPlayed = { "/VO/ZagreusField_2565" } },
				-- Beautiful.
				{ Cue = "/VO/ZagreusField_2564", RequiredPlayed = { "/VO/ZagreusField_2565" } },
				-- Should fetch me something good back home.
				{ Cue = "/VO/ZagreusField_2565" },
				-- Got some heft.
				{ Cue = "/VO/ZagreusField_2566", RequiredPlayed = { "/VO/ZagreusField_2565" } },
				-- It's brilliant.
				{ Cue = "/VO/ZagreusField_2567", PreLineWait = 0.8, RequiredPlayed = { "/VO/ZagreusField_2565" } },
				-- It's beautiful.
				{ Cue = "/VO/ZagreusField_2568", PreLineWait = 0.8, RequiredPlayed = { "/VO/ZagreusField_2565" } },
				-- I'll just tuck that away.
				{ Cue = "/VO/ZagreusField_2569", RequiredPlayed = { "/VO/ZagreusField_2565" } },
			},
			[2] = GlobalVoiceLines.BountyEarnedVoiceLines,
		},
	},

	SuperLockKeyDrop =
	{
		InheritFrom = { "BaseConsumable", },
		Icon = "SuperLockKeyIconSmall",
		IgnoreCostIncrease = true,
		Cost =
		{
			BaseValue = 1200,
			DepthMult = 0,
			AsInt = true,
		},
		AddResources =
		{
			SuperLockKeys = 1,
		},
		SpawnSound = "/SFX/TitanBloodDropSFX",
		ConsumeSound = "/SFX/TitanBloodPickupSFX",
		UseText = "UseSuperLockKeyDrop",
		OnUsedFunctionName = "BountyEarnedPresentation",
		PurchaseText = "Shop_UseSuperLockKeyDrop",
		PlayInteract = true,
		HideWorldText = true,

		OnSpawnVoiceLines =
		{
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.02,
			PreLineWait = 0.7,
			CooldownTime = 40,
			RequiredFalseEncounters = { "BossHadesPeaceful" },

			-- The ancient blood...
			{ Cue = "/VO/ZagreusField_2815" },
		},

		ConsumedVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.85,
				RequiredFalseEncounters = { "BossHadesPeaceful" },
				RequiredScreenViewedFalse = "WeaponUpgradeScreen",

				-- Achilles might know what to do with this.
				{ Cue = "/VO/ZagreusField_2943", PlayOnce = true },
				-- This holds some sort of power, but for what?
				{ Cue = "/VO/ZagreusField_2944", RequiredPlayed = { "/VO/ZagreusField_2943" }, PlayOnce = true, },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.85,
				SuccessiveChanceToPlay = 0.05,
				RequiredFalseEncounters = { "BossHadesPeaceful" },
				RequiredWeaponsUnlocked = { "SwordWeapon", "SpearWeapon", "ShieldWeapon", "BowWeapon", "GunWeapon", "FistWeapon", },

				-- Stygius shuddered as I picked it up...
				{ Cue = "/VO/ZagreusField_2574", RequiredWeapon = "SwordWeapon" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.85,
				ChanceToPlayAgain = 0.05,
				CooldownTime = 6,
				RequiredFalseEncounters = { "BossHadesPeaceful" },
				RequiredWeaponsUnlocked = { "SwordWeapon", "SpearWeapon", "ShieldWeapon", "BowWeapon", "GunWeapon", "FistWeapon", },

				-- I felt Aegis shudder...
				{ Cue = "/VO/ZagreusField_2575", RequiredWeapon = "ShieldWeapon" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.85,
				ChanceToPlayAgain = 0.05,
				CooldownTime = 6,
				RequiredFalseEncounters = { "BossHadesPeaceful" },
				RequiredWeaponsUnlocked = { "SwordWeapon", "SpearWeapon", "ShieldWeapon", "BowWeapon", "GunWeapon", "FistWeapon", },

				-- Varatha shuddered just now...
				{ Cue = "/VO/ZagreusField_2576", RequiredWeapon = "SpearWeapon" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.85,
				ChanceToPlayAgain = 0.05,
				CooldownTime = 6,
				RequiredFalseEncounters = { "BossHadesPeaceful" },
				RequiredWeaponsUnlocked = { "SwordWeapon", "SpearWeapon", "ShieldWeapon", "BowWeapon", "GunWeapon", "FistWeapon", },

				-- Coronacht shuddered when I picked this up...
				{ Cue = "/VO/ZagreusField_2577", RequiredWeapon = "BowWeapon" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.85,
				ChanceToPlayAgain = 0.05,
				CooldownTime = 6,
				RequiredFalseEncounters = { "BossHadesPeaceful" },
				RequiredWeaponsUnlocked = { "SwordWeapon", "SpearWeapon", "ShieldWeapon", "BowWeapon", "GunWeapon", "FistWeapon", },

				-- Did Malphon shudder...?
				{ Cue = "/VO/ZagreusField_3237", RequiredWeapon = "FistWeapon" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.85,
				ChanceToPlayAgain = 0.05,
				CooldownTime = 6,
				RequiredFalseEncounters = { "BossHadesPeaceful" },
				RequiredWeaponsUnlocked = { "SwordWeapon", "SpearWeapon", "ShieldWeapon", "BowWeapon", "GunWeapon", "FistWeapon", },

				-- Did Exagryph just shudder...?
				{ Cue = "/VO/ZagreusField_2578", RequiredWeapon = "GunWeapon" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.7,
				SuccessiveChanceToPlayAll = 0.33,
				RequiredFalseEncounters = { "BossHadesPeaceful" },
				Cooldowns =
				{
					{ Name = "ZagreusAnyQuipSpeech" },
				},

				-- A Chthonic Key...
				-- { Cue = "/VO/ZagreusField_2571" },
				-- A key of power.
				-- { Cue = "/VO/ZagreusField_2572" },
				-- Blood of the Titans...
				{ Cue = "/VO/ZagreusField_2816" },
				-- Blood...
				{ Cue = "/VO/ZagreusField_2817" },
				-- Titan Blood...
				{ Cue = "/VO/ZagreusField_2818" },
				-- Found you...
				{ Cue = "/VO/ZagreusField_2573" },
				-- My weapon shuddered at the touch of it...
				{ Cue = "/VO/ZagreusField_2579" },
				-- My weapons can grow even stronger now.
				{ Cue = "/VO/ZagreusField_2580", RequiredScreenViewed = "WeaponUpgradeScreen", RequiredLifetimeResourcesSpentMax = { SuperLockKeys = 250 }, },
				-- This can unlock a hidden aspect of my weapons.
				{ Cue = "/VO/ZagreusField_2581", RequiredMaxUnlockedWeaponEnchantments = 13 },
			},
			[7] = GlobalVoiceLines.BountyEarnedVoiceLines,
		},
	},

	RandomLoot =
	{
		InheritFrom = { "BaseConsumable", },
		Cost =
		{
			BaseValue = 150,
			DepthMult = 0,
			AsInt = true,
		},
		UseText = "UsePurchaseLoot",
		UseFunctionName = "GiveLoot",
	},

	BlindBoxLoot = 
	{
		InheritFrom = { "BaseConsumable", },
		Cost =
		{
			BaseValue = 125,
			DepthMult = 0,
			AsInt = true,
		},
		RequiredTextLines = {  
			"AthenaFirstPickUp",
			"ZeusFirstPickUp",
			"PoseidonFirstPickUp",
			"AphroditeFirstPickUp",
			"AresFirstPickUp",
			"ArtemisFirstPickUp",
			"DionysusFirstPickUp", 
		},
	
		UseText = "UseBlindBox",
		PurchaseText = "UseBlindBox",
		ReplaceWithRandomLoot = true,
		HideWorldText = true,
		BlockPurchasedVoiceLines = true,
	},

	StackUpgradeDrop =
	{
		InheritFrom = { "BaseConsumable", },
		Cost =
		{
			BaseValue = 100,
			DepthMult = 0,
			AsInt = true,
		},
		RequireUpgradableTraits = true,
		UseText = "UseStackUpgrade",
		UseFunctionName = "CreateStackLoot",
	},

	StackUpgradeDropRare =
	{
		InheritFrom = { "BaseConsumable", },
		Cost =
		{
			BaseValue = 300,
			DepthMult = 0,
			AsInt = true,
		},
	},

	BoostedRandomLoot =
	{
		InheritFrom = { "BaseConsumable", },
		Cost =
		{
			BaseValue = 450,
			DepthMult = 0,
			AsInt = true,
		},
	},

	WeaponUpgradeDrop =
	{
		InheritFrom = { "BaseConsumable", },
		Cost =
		{
			BaseValue = 200,
			DepthMult = 0,
			AsInt = true,
		},
		UseText = "UseWeaponUpgrade",
		UseFunctionName = "CreateWeaponLoot",
		RequiredMaxWeaponUpgrades = 0,
		RequiredMinCompletedRuns = 3,
	},

	HermesUpgradeDrop =
	{
		InheritFrom = { "BaseConsumable", },
		Cost =
		{
			BaseValue = 150,
			DepthMult = 0,
			AsInt = true,
		},
		UseText = "UsePurchaseLoot",
		UseFunctionName = "CreateHermesLoot",
		RequiredMaxHermesUpgrades = 0,
		RequiredTextLines = {  "HermesFirstPickUp" },
	},

	DionysusGiftDrop =
	{
		InheritFrom = { "BaseConsumable", "Tier1Consumable" },
		RequiredFalseTrait = "GiftHealthTrait",
		Icon = "Boon_Dionysus_05",
		Cost = 0,
		UseFunctionNames =  { "AddTraitToHero", "DionysusGiftDrop" } ,
		UseFunctionArgs =
		{
			{ TraitName = "GiftHealthTrait" },
			{},
		},
	},

	CharonStoreDiscount =
	{
		InheritFrom = { "BaseConsumable" },
		Icon = "BoonIcon",
		Cost = 0,
		SpawnSound = "/SFX/CharonMembershipCardDrop",
		ConsumeSound = "/SFX/CharonMembershipCardPickup",
		UseText = "UseCharonStoreDiscount",
		UseFunctionNames =  { "AddTraitToHero" } ,
		UseFunctionArgs =
		{
			{ TraitName = "DiscountTrait" },
		},
		UseThreadedFunctionNames = { "LeaveCharonFight" },
		UseThreadedFunctionArgs =
		{
		},
		HideWorldText = true,

		ConsumedVoiceLines =
		{
			PlayOnce = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.55,

			-- I look forward to making use of this.
			{ Cue = "/VO/ZagreusField_3767", RequiredPlayed = { "/VO/ZagreusField_3770" }, },
			-- Appreciate your generosity.
			{ Cue = "/VO/ZagreusField_3768", RequiredPlayed = { "/VO/ZagreusField_3770" }, },
			-- Looks like I'm back in the club.
			{ Cue = "/VO/ZagreusField_3769", RequiredPlayed = { "/VO/ZagreusField_3770" }, },
			-- Look at these savings!
			{ Cue = "/VO/ZagreusField_3770" },
			-- What a deal, mate.
			{ Cue = "/VO/ZagreusField_3771", RequiredPlayed = { "/VO/ZagreusField_3770" }, },
			-- It's a deal!
			{ Cue = "/VO/ZagreusField_3772", RequiredPlayed = { "/VO/ZagreusField_3770" }, },
		},

	},

	LastStandDurationDrop =
	{
		InheritFrom = { "BaseConsumable", "Tier1Consumable" },
		RequiredFalseTrait = "LastStandDurationTrait",
		RequiredOneOfTraits = { "AthenaWeaponTrait", "AthenaRangedTrait", "AthenaRushTrait", "AthenaSecondaryTrait" },
		RequiredMinMaximumLastStands = 1,
		Icon = "Boon_Athena_11",
		ConsumeSound = "/EmptyCue",
		Cost = 0,
		UseFunctionNames =  { "AddLastStand", "AddTraitToHero", "GainLastStandPresentation" } ,
		UseFunctionArgs = {
			{
				Icon = "ExtraLifeAthena",
				WeaponName = "LastStandMetaUpgradeShield",
				HealFraction = 0.5
			},
			{ TraitName = "LastStandDurationTrait" },
			{ },
		},
	},

	LastStandHealDrop =
	{
		InheritFrom = { "BaseConsumable", "Tier1Consumable" },
		RequiredFalseTrait = "LastStandHealTrait",
		RequiredOneOfTraits = { "AthenaWeaponTrait", "AthenaRangedTrait", "AthenaRushTrait", "AthenaSecondaryTrait" },
		RequiredMinMaximumLastStands = 1,
		Icon = "Boon_Athena_12",
		ConsumeSound = "/EmptyCue",
		Cost = 0,
		UseFunctionNames =  { "AddLastStand", "AddTraitToHero", "GainLastStandPresentation" } ,
		UseFunctionArgs = {
			{
				Icon = "ExtraLifeAthena",
				WeaponName = "LastStandMetaUpgradeShield",
				HealFraction = 0.5
			},
			{ TraitName = "LastStandHealTrait" },
			{ },
		},
	},
	HealingPotencyDrop =
	{
		InheritFrom = { "BaseConsumable", "Tier1Consumable" },
		RequiredFalseTrait = "HealingPotencyTrait",
		
		CustomNameWithMetaUpgrade =
		{
			MetaUpgradeName = "HealingReductionShrineUpgrade",
			Name = "HealingPotencyDrop_Reduced",
		},

		Icon = "Boon_Demeter_09",
		ConsumeSound = "/EmptyCue",
		Cost = 0,
		UseFunctionNames =  { "AddTraitToHero", "GiveRandomConsumables",  } ,
		UseFunctionArgs = {
			{ TraitName = "HealingPotencyTrait" },
			{
				Delay = 0.5,
				NotRequiredPickup = true,
				Range = 75,
				LootOptions =
				{
					{
						Name = "RoomRewardHealDrop",
						MinAmount = 1,
						MaxAmount = 1,
					},
				}
			},
		},
		ExtractValues =
		{
			{
				ExtractAs = "HealingReduction",
				Format = "TotalMetaUpgradeChangeValue",
				MetaUpgradeName = "HealingReductionShrineUpgrade",
				SkipAutoExtract = true,
			}
		},
	},
	RandomMinorLootDrop =
	{
		InheritFrom = { "BaseConsumable", "Tier1Consumable" },
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.00,
				MaxMultiplier = 1.00,
			},
			Rare =
			{
				MinMultiplier = 1.3,
				MaxMultiplier = 1.3,
			},
			Epic =
			{
				MinMultiplier = 1.6,
				MaxMultiplier = 1.6,
			},
			Heroic =
			{
				MinMultiplier = 1.9,
				MaxMultiplier = 1.9,
			},
		},
		Icon = "Boon_Poseidon_06",
		ExitUnlockDelay = 1.5,
		Cost = 0,
		UseText = "UseHealDrop",
		PurchaseText = "Shop_UseHealDrop",
		UseFunctionNames = { "GiveRandomConsumables", "AddTraitToHero" },
		UseFunctionArgs =
		{ 
			{
				Delay = 0.5,
				NotRequiredPickup = true,
				LootMultiplier = { BaseValue = 1 },
				LootOptions =
				{
					{
						Name = "Money",
						MinAmount = 90,
						MaxAmount = 90,
					},
					{
						Name = "HealDropMinor",
						MinAmount = 3,
						MaxAmount = 3,
					},
					{
						Name = "RoomRewardMetaPointDrop",
						MinAmount = 1,
						MaxAmount = 1,
					},
					{
						Name = "GemDrop",
						MinAmount = 2,
						MaxAmount = 2,
					},
					{
						Name = "GiftDrop",
						Chance = 0.1,
					},
					{
						Name = "SuperGemDrop",
						Chance = 0.003,
					},
				}
			},
			 { TraitName = "PoseidonPickedUpMinorLootTrait" },
		},
	},
}

ResourceData =
{
	LockKeys =
	{
		Icon = "LockKeyIcon",
		SpendText = "SpendLockKeyAmount",
		GainedText = "LockKeyAmount",
		RequirementText = "MetaUpgrade_Locked_Keys",
		OnAddedFunctionName = "OnLockKeysAdded",
		IconPath = "GUI\\Icons\\LockKey",
		IconString = "LockKey",
		SmallIconString = "LockKeySmall",
		SpendSound = "/SFX/KeyPickup",
		TitleName = "LockKeyDrop",
		TitleName_Singular = "LockKeyDrop_Singular",
		CostText = "LockKeyCost",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentLockKeysVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedLockKeysVoiceLines,
		},
		BrokerCannotSpendVoiceLines =
		{
			[1] = GlobalVoiceLines.InsufficientLockKeysVoiceLines,
		},
	},

	MetaPoints =
	{
		Icon = "MetaPointIcon",
		IconPath = "GUI\\Icons\\Darkness",
		OnAddedFunctionName = "OnMetaPointsAdded",
		SpendText = "SpendMetaPointAmount",
		GainedText = "MetaPointAmount",
		IconString = "MetaPoint",
		SmallIconString = "MetaPoint_Small",
		SpendSound = "/SFX/Player Sounds/DarknessCollectionPickup",
		TitleName = "RoomRewardMetaPointDrop",
		CostText = "MetaPointCost",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentMetaPointsVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedMetaPointsVoiceLines,
		},
		BrokerCannotSpendVoiceLines =
		{
			[1] = GlobalVoiceLines.InsufficientMetaPointsVoiceLines
		},
	},

	Gems =
	{
		IconPath = "GUI\\Icons\\Gems",
		Icon = "GemsIcon",
		SpendText = "SpendGemAmount",
		GainedText = "GemAmount",
		-- Color = Color.LimeGreen,
		IconString = "Gem",
		SmallIconString = "GemSmall",
		SpendSound = "/SFX/GemPickup",
		TitleName = "GemDrop",
		CostText = "GemCost",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentGemsVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedGemsVoiceLines,
		},
		BrokerCannotSpendVoiceLines =
		{
			[1] = GlobalVoiceLines.InsufficientGemsVoiceLines,
		},
	},

	GiftPoints =
	{
		Icon = "GiftIcon",
		IconPath = "GUI\\Icons\\Gift",
		SpendText = "SpendGiftAmount",
		GainedText = "GiftAmount",
		CombatResource = true,
		OnAddedFunctionName = "OnGiftPointsAdded",
		IconString = "GiftPoint",
		SmallIconString = "GiftPointSmall",
		SpendSound = "/SFX/GiftAmbrosiaBottlePickup",
		TitleName = "GiftDrop",
		CostText = "GiftPointCost",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentGiftPointsVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedGiftPointsVoiceLines,
		},
		BrokerCannotSpendVoiceLines =
		{
			[1] = GlobalVoiceLines.InsufficientGiftPointsVoiceLines,
		},
	},

	SuperGiftPoints =
	{
		SpendText = "SpendSuperGiftAmount",
		GainedText = "SuperGiftAmount",
		-- Color = Color.LimeGreen,
		GainedFx = "SkillProcFeedbackFx",
		Icon = "SuperGiftIcon",
		IconString = "SuperGiftPoint",
		SmallIconString = "SuperGiftPointSmall",
		IconPath = "GUI\\Icons\\SuperGift",
		SpendSound = "/SFX/SuperGiftAmbrosiaBottlePickup",
		RequirementText = "Locked_SuperGift",
		TitleName = "SuperGiftDrop",
		CostText = "SuperGiftPointCost",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentSuperGiftPointsVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedSuperGiftPointsVoiceLines,
		},
		BrokerCannotSpendVoiceLines =
		{
			[1] = GlobalVoiceLines.InsufficientSuperGiftPointsVoiceLines,
		},

	},

	SuperLockKeys =
	{
		RequirementText = "MetaUpgrade_Locked_SuperKeys",
		SpendText = "SpendSuperLockKeyAmount",
		GainedText = "SuperLockKeyAmount",
		-- Color = Color.LimeGreen,
		GainedFx = "SkillProcFeedbackFx",
		Icon = "SuperLockKeyIcon",
		IconString = "SuperLockKey",
		SmallIconString = "SuperLockKeySmall",
		IconPath = "GUI\\Icons\\Blood",
		SpendSound = "/SFX/TitanBloodPickupSFX",
		TitleName = "SuperLockKeyDrop",
		CostText = "SuperLockKeyCost",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentSuperLockKeysVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedSuperLockKeysVoiceLines,
		},
		BrokerCannotSpendVoiceLines =
		{
			[1] = GlobalVoiceLines.InsufficientSuperLockKeysVoiceLines,
		},

	},

	SuperGems =
	{
		IconPath = "GUI\\Icons\\SuperGems",
		Icon = "SuperGemsIcon",
		SpendText = "SpendSuperGemAmount",
		GainedText = "SuperGemAmount",
		-- Color = Color.LimeGreen,
		IconString = "SuperGem",
		SmallIconString = "SuperGemSmall",
		SpendSound = "/SFX/SuperGemPickup",
		TitleName = "SuperGemDrop",
		CostText = "SuperGemCost",
		BrokerSpentVoiceLines =
		{
			[1] = GlobalVoiceLines.SpentSuperGemsVoiceLines,
		},
		BrokerPurchaseVoiceLines =
		{
			[1] = GlobalVoiceLines.PurchasedSuperGemsVoiceLines,
		},
		BrokerCannotSpendVoiceLines =
		{
			[1] = GlobalVoiceLines.InsufficientSuperGemsVoiceLines,
		},
	},
}

ResourceOrderData =
{
	"GiftPoints",
	"MetaPoints",
	"Gems",
	"LockKeys",
	"SuperLockKeys",
	"SuperGems",
	"SuperGiftPoints",
}