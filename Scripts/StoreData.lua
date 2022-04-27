StoreData =
{
	RoomShop =
	{
		MaxOffers = 3,
		HealingOffers =
		{
			Min = 1,
			Max = 1,
			WeightedList =
			{
				{
					Name = "HealDropRange",
					Type = "Consumable",
					Weight = 1,
				},
				{
					Name = "HealDropRange",
					Type = "Consumable",
					Weight = 1,
				},
				{
					Name = "EmptyMaxHealthDrop",
					Type = "Consumable",
					Weight = 0.2,
				},
				{
					Name = "DamageSelfDrop",
					Type = "Consumable",
					Weight = 0.2,
				},
				{
					Name = "TemporaryDoorHealTrait",
					Type = "Trait",
					Weight = 1,
				},
				{
					Name = "TemporaryWeaponLifeOnKillTrait",
					Type = "Trait",
					Weight = 1,
				},
				{
					
					Name = "LastStandDrop",
					Type = "Consumable",
					Weight = 2,
				},
				{
					Name = "TemporaryLastStandHealTrait",
					Type = "Trait",
					Weight = 0.5,
				}
			}
		},
		Traits =
		{
			"TemporaryImprovedWeaponTrait",
			"TemporaryMoreAmmoTrait",
			"TemporaryImprovedRangedTrait",
			"TemporaryMoveSpeedTrait",
			"TemporaryBoonRarityTrait",
			"TemporaryArmorDamageTrait",
			"TemporaryAlphaStrikeTrait",
			"TemporaryBackstabTrait",
			"TemporaryImprovedSecondaryTrait",
			"TemporaryImprovedTrapDamageTrait",
			"TemporaryPreloadSuperGenerationTrait",
			"TemporaryForcedSecretDoorTrait",
			"TemporaryForcedChallengeSwitchTrait",
			"TemporaryForcedFishingPointTrait",
			"TemporaryBlockExplodingChariotsTrait",			
		},
		Consumables =
		{
			"MetaDropRange",
			"GemDropRange",
			"KeepsakeChargeDrop",
			"RandomStoreItem",
		},
	},
	WorldShop =
	{
		GroupsOf = 
		{
			{
				WeightedList = true,
				Offers = 1,
				OptionsData =
				{
					--{ Name = "StoreTrialUpgradeDrop", },
					{ Name = "BlindBoxLoot", },
					{ Name = "RandomLoot", Weight = 5 },
				},
			},
			{
				WeightedList = true,
				Offers = 1,
				OptionsData =
				{
					{ Name = "StoreRewardMetaPointDrop", Weight = 1.0 },
					{ Name = "StoreRewardLockKeyDrop", Weight = 0.50 },
					{ Name = "StoreRewardGemDrop", Weight = 0.75 },
					{ Name = "GiftDrop", Weight = 0.25 },
					{ Name = "RoomRewardHealDrop", Weight = 2.5 },
				},
			},
			{
				WeightedList = true,
				Offers = 1,
				OptionsData =
				{
					{ Name = "WeaponUpgradeDrop", },
					{ Name = "HermesUpgradeDrop", },
					{ Name = "StackUpgradeDrop", },
					{ Name = "RoomRewardMaxHealthDrop", },
					{ Name = "StoreRewardConsolationDrop", Weight = 0.1 },
					{ Name = "StoreRewardRandomStack", Weight = 0.5 },
				},
			},
	
		}
	},
	D_WorldShop =
	{
		GroupsOf =
		{
			{
				Offers = 2,
				Options =
				{
					"RoomRewardMaxHealthDrop",
					"StackUpgradeDrop",
					"RandomLoot",
					"RandomLoot",
				},
			},
			{
				Offers = 1,
				Options =
				{
					"SuperGemDrop",
					"SuperLockKeyDrop",
				},
			},
			{
				Offers = 2,
				Options =
				{
					"StackUpgradeDropRare",
					"StackUpgradeDropRare",
					"BoostedRandomLoot",
				},
			},
			{
				Offers = 1,
				OptionsData =
				{
					{ Name = "HermesUpgradeDrop", Cost = 500, UpgradeChance = 1.0, UpgradedCost = 500, ReplaceRequirements = { RequiredTextLines = {  "HermesFirstPickUp" },}},
					{ Name = "ChaosWeaponUpgrade", Cost = 650 },
					--{ Name = "WeaponUpgradeDrop", Cost = 650, SkipRequirements = true },
				},
			}
		}
	},
}

BrokerScreenData = 
{
	MaxOptions = 6,
	MaxNonPriorityOffers = 1,
}

BrokerData = 
{
	-- Standard Trades

	{ 
		BuyName = "LockKeys", BuyAmount = 1,
		CostName = "Gems", CostAmount = 10, 
		Priority = true, 
		PurchaseSound = "/SFX/KeyPickup",
	},

	{ 
		BuyName = "GiftPoints", BuyAmount = 1,
		CostName = "LockKeys", CostAmount = 5, 
		Priority = true, 
		PurchaseSound = "/SFX/GiftAmbrosiaBottlePickup",
	},

	{ 
		BuyName = "SuperGems", BuyAmount = 1,
		CostName = "GiftPoints", CostAmount = 10, 
		Priority = true,
		PurchaseSound = "/SFX/SuperGemPickup",
		GameStateRequirements = { RequiredKills = { HydraHeadImmortal = 1 }, },
	},

	{ 
		BuyName = "SuperGiftPoints", BuyAmount = 1,
		CostName = "SuperGems", CostAmount = 2, 
		Priority = true,
		PurchaseSound = "/SFX/SuperGiftAmbrosiaBottlePickup",
		GameStateRequirements = { RequiredKills = { Theseus = 1 }, },
	},

	{ 
		BuyName = "SuperLockKeys", BuyAmount = 1,
		CostName = "SuperGiftPoints", CostAmount = 1, 
		Priority = true, 
		PurchaseSound = "/SFX/TitanBloodPickupSFX",
		GameStateRequirements = { RequiredKills = { Theseus = 1 }, },
	},

	-- Limited Time Trades

	{ 
		BuyName = "GiftPoints", BuyAmount = 1,
		CostName = "Gems", CostAmount = 10, 
		PurchaseSound = "/SFX/GiftAmbrosiaBottlePickup",
	},

	{ 
		BuyName = "LockKeys", BuyAmount = 3,
		CostName = "MetaPoints", CostAmount = 25, 
		PurchaseSound = "/SFX/KeyPickup",
	},

	{ 
		BuyName = "MetaPoints", BuyAmount = 50,
		CostName = "GiftPoints", CostAmount = 1, 
		PurchaseSound = "/SFX/Player Sounds/DarknessCollectionPickup",
	},

	{ 
		BuyName = "Gems", BuyAmount = 20,
		CostName = "LockKeys", CostAmount = 2, 
		PurchaseSound = "/SFX/GemPickup",
	},

	{ 
		BuyName = "SuperLockKeys", BuyAmount = 1,
		CostName = "LockKeys", CostAmount = 15, 
		PurchaseSound = "/SFX/TitanBloodPickupSFX",
		GameStateRequirements = { RequiredKills = { Harpy = 1 }, },
	},

	{ 
		BuyName = "Gems", BuyAmount = 200,
		CostName = "SuperLockKeys", CostAmount = 1, 
		PurchaseSound = "/SFX/GemPickup",
		GameStateRequirements = { RequiredKills = { Harpy = 1 }, },
	},

	{ 
		BuyName = "SuperGiftPoints", BuyAmount = 1,
		CostName = "GiftPoints", CostAmount = 10, 
		PurchaseSound = "/SFX/SuperGiftAmbrosiaBottlePickup",
		GameStateRequirements = { RequiredKills = { Theseus = 1 }, },
	},

	{ 
		BuyName = "SuperGiftPoints", BuyAmount = 1,
		CostName = "SuperLockKeys", CostAmount = 2, 
		PurchaseSound = "/SFX/SuperGiftAmbrosiaBottlePickup",
		GameStateRequirements = { RequiredKills = { Hades = 1 }, },
	},

	{ 
		BuyName = "SuperGems", BuyAmount = 1,
		CostName = "SuperLockKeys", CostAmount = 1, 
		PurchaseSound = "/SFX/SuperGemPickup",
		GameStateRequirements = { RequiredKills = { Hades = 1 }, },
	},

	{ 
		BuyName = "SuperGems", BuyAmount = 1,
		CostName = "Gems", CostAmount = 100, 
		PurchaseSound = "/SFX/SuperGemPickup",
		GameStateRequirements = { RequiredKills = { HydraHeadImmortal = 1 }, },
	},

	{ 
		BuyName = "MetaPoints", BuyAmount = 500,
		CostName = "SuperGiftPoints", CostAmount = 1, 
		PurchaseSound = "/SFX/Player Sounds/DarknessCollectionPickup",
		GameStateRequirements = { RequiredKills = { Theseus = 1 }, },
	},

	{ 
		BuyName = "Gems", BuyAmount = 50,
		CostName = "MetaPoints", CostAmount = 300, 
		PurchaseSound = "/SFX/GemPickup",
		GameStateRequirements = { RequiredMinShrinePointThresholdClear = 1 },
	},
}
