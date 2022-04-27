GameData.BadgeData =
{
	BaseBadge =
	{
		PanDuration = 2,
		DoVerticalPan = true,
		UseUnlockText = true,
		PreActivationHoldDuration = 1.5,
		PostActivationHoldDuration = 1.5,
		SetPlayerAnimation = "ZagreusTalkDenial_Full",
		RevealVoiceLines =
		{
			[1] = GlobalVoiceLines.UpgradedBadgeVoiceLines,
		},
	},

	Tier1Badge =
	{
		BadgeIconScale = 0.42,
		BadgeIconOffsetX = 27,
		BadgeIconOffsetY = 8,
	},

	Tier2Badge =
	{
		BadgeIconScale = 0.45,
		BadgeIconOffsetX = 14,
		BadgeIconOffsetY = 12,
	},

	Tier3Badge =
	{
		BadgeIconScale = 0.45,
		BadgeIconOffsetX = 14,
		BadgeIconOffsetY = 12,
	},

	Tier4Badge =
	{
		BadgeIconScale = 0.40,
		BadgeIconOffsetX = 2,
		BadgeIconOffsetY = 12,
	},

	Tier5Badge =
	{
		BadgeIconScale = 0.4,
		BadgeIconOffsetX = 20,
		BadgeIconOffsetY = 14,
	},

	-- Warden
	Badge_Rank01_Tier01 =
	{
		InheritFrom = { "BaseBadge", "Tier1Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 1000, },
			{ Name = "LockKeys", Amount = 10, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Warden_Alpha",
	},

	Badge_Rank01_Tier02 =
	{
		InheritFrom = { "BaseBadge", "Tier2Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 1500, },
			{ Name = "GiftPoints", Amount = 5, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Warden_Delta",
	},

	Badge_Rank01_Tier03 =
	{
		InheritFrom = { "BaseBadge", "Tier3Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 2000, },
			{ Name = "SuperGems", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Warden_Gamma",
	},

	Badge_Rank01_Tier04 =
	{
		InheritFrom = { "BaseBadge", "Tier4Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 2500, },
			{ Name = "SuperGiftPoints", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Warden_Sigma",
	},

	Badge_Rank01_Tier05 =
	{
		InheritFrom = { "BaseBadge", "Tier5Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 3000, },
			{ Name = "SuperLockKeys", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Warden_Unseen",
	},

	-- Fixer
	Badge_Rank02_Tier01 =
	{
		InheritFrom = { "BaseBadge", "Tier1Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 2000, },
			{ Name = "LockKeys", Amount = 10, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Fixer_Alpha",
	},

	Badge_Rank02_Tier02 =
	{
		InheritFrom = { "BaseBadge", "Tier2Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 2500, },
			{ Name = "GiftPoints", Amount = 5, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Fixer_Delta",
	},

	Badge_Rank02_Tier03 =
	{
		InheritFrom = { "BaseBadge", "Tier3Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 3000, },
			{ Name = "SuperGems", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Fixer_Gamma",
	},

	Badge_Rank02_Tier04 =
	{
		InheritFrom = { "BaseBadge", "Tier4Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 3500, },
			{ Name = "SuperGiftPoints", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Fixer_Sigma",
	},

	Badge_Rank02_Tier05 =
	{
		InheritFrom = { "BaseBadge", "Tier5Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 4000, },
			{ Name = "SuperLockKeys", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Fixer_Unseen",
	},

	-- Agent
	Badge_Rank03_Tier01 =
	{
		InheritFrom = { "BaseBadge", "Tier1Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 3000, },
			{ Name = "LockKeys", Amount = 10, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Agent_Alpha",
	},

	Badge_Rank03_Tier02 =
	{
		InheritFrom = { "BaseBadge", "Tier2Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 3500, },
			{ Name = "GiftPoints", Amount = 5, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Agent_Delta",
	},

	Badge_Rank03_Tier03 =
	{
		InheritFrom = { "BaseBadge", "Tier3Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 4000, },
			{ Name = "SuperGems", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Agent_Gamma",
	},

	Badge_Rank03_Tier04 =
	{
		InheritFrom = { "BaseBadge", "Tier4Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 4500, },
			{ Name = "SuperGiftPoints", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Agent_Sigma",
	},

	Badge_Rank03_Tier05 =
	{
		InheritFrom = { "BaseBadge", "Tier5Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 5000, },
			{ Name = "SuperLockKeys", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Agent_Unseen",
	},

	-- Cleaner
	Badge_Rank04_Tier01 =
	{
		InheritFrom = { "BaseBadge", "Tier1Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 4000, },
			{ Name = "LockKeys", Amount = 10, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Cleaner_Alpha",
	},

	Badge_Rank04_Tier02 =
	{
		InheritFrom = { "BaseBadge", "Tier2Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 4500, },
			{ Name = "GiftPoints", Amount = 5, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Cleaner_Delta",
	},

	Badge_Rank04_Tier03 =
	{
		InheritFrom = { "BaseBadge", "Tier3Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 5000, },
			{ Name = "SuperGems", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Cleaner_Gamma",
	},

	Badge_Rank04_Tier04 =
	{
		InheritFrom = { "BaseBadge", "Tier4Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 5500, },
			{ Name = "SuperGiftPoints", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Cleaner_Sigma",
	},

	Badge_Rank04_Tier05 =
	{
		InheritFrom = { "BaseBadge", "Tier5Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 6000, },
			{ Name = "SuperLockKeys", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Cleaner_Unseen",
	},

	-- Shadow
	Badge_Rank05_Tier01 =
	{
		InheritFrom = { "BaseBadge", "Tier1Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 5000, },
			{ Name = "LockKeys", Amount = 10, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Shadow_Alpha",
	},

	Badge_Rank05_Tier02 =
	{
		InheritFrom = { "BaseBadge", "Tier2Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 5500, },
			{ Name = "GiftPoints", Amount = 5, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Shadow_Delta",
	},

	Badge_Rank05_Tier03 =
	{
		InheritFrom = { "BaseBadge", "Tier3Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 6000, },
			{ Name = "SuperGems", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Shadow_Gamma",
	},

	Badge_Rank05_Tier04 =
	{
		InheritFrom = { "BaseBadge", "Tier5Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 6500, },
			{ Name = "SuperGiftPoints", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Shadow_Sigma",
	},

	Badge_Rank05_Tier05 =
	{
		InheritFrom = { "BaseBadge", "Tier5Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 7000, },
			{ Name = "SuperLockKeys", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Shadow_Unseen",
	},

	-- Dusk
	Badge_Rank06_Tier01 =
	{
		InheritFrom = { "BaseBadge", "Tier1Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 6000, },
			{ Name = "LockKeys", Amount = 10, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Dusk_Alpha",
	},

	Badge_Rank06_Tier02 =
	{
		InheritFrom = { "BaseBadge", "Tier2Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 6500, },
			{ Name = "GiftPoints", Amount = 5, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Dusk_Delta",
	},

	Badge_Rank06_Tier03 =
	{
		InheritFrom = { "BaseBadge", "Tier3Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 7000, },
			{ Name = "SuperGems", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Dusk_Gamma",
	},

	Badge_Rank06_Tier04 =
	{
		InheritFrom = { "BaseBadge", "Tier4Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 7500, },
			{ Name = "SuperGiftPoints", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Dusk_Sigma",
	},

	Badge_Rank06_Tier05 =
	{
		InheritFrom = { "BaseBadge", "Tier5Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 8000, },
			{ Name = "SuperLockKeys", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Dusk_Unseen",
	},

	-- Wraith
	Badge_Rank07_Tier01 =
	{
		InheritFrom = { "BaseBadge", "Tier1Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 7000, },
			{ Name = "LockKeys", Amount = 10, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Wraith_Alpha",
	},

	Badge_Rank07_Tier02 =
	{
		InheritFrom = { "BaseBadge", "Tier2Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 7500, },
			{ Name = "GiftPoints", Amount = 5, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Wraith_Delta",
	},

	Badge_Rank07_Tier03 =
	{
		InheritFrom = { "BaseBadge", "Tier3Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 8000, },
			{ Name = "SuperGems", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Wraith_Gamma",
	},

	Badge_Rank07_Tier04 =
	{
		InheritFrom = { "BaseBadge", "Tier4Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 8500, },
			{ Name = "SuperGiftPoints", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Wraith_Sigma",
	},

	Badge_Rank07_Tier05 =
	{
		InheritFrom = { "BaseBadge", "Tier5Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 9000, },
			{ Name = "SuperLockKeys", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Wraith_Unseen",
	},

	-- Overseer
	Badge_Rank08_Tier01 =
	{
		InheritFrom = { "BaseBadge", "Tier1Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 8000, },
			{ Name = "LockKeys", Amount = 10, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Overseer_Alpha",
	},

	Badge_Rank08_Tier02 =
	{
		InheritFrom = { "BaseBadge", "Tier2Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 8500, },
			{ Name = "GiftPoints", Amount = 5, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Overseer_Delta",
	},

	Badge_Rank08_Tier03 =
	{
		InheritFrom = { "BaseBadge", "Tier3Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 9000, },
			{ Name = "SuperGems", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Overseer_Gamma",
	},

	Badge_Rank08_Tier04 =
	{
		InheritFrom = { "BaseBadge", "Tier4Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 9500, },
			{ Name = "SuperGiftPoints", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Overseer_Sigma",
	},

	Badge_Rank08_Tier05 =
	{
		InheritFrom = { "BaseBadge", "Tier5Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 10000, },
			{ Name = "SuperLockKeys", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Overseer_Unseen",
	},

	-- Specter
	Badge_Rank09_Tier01 =
	{
		InheritFrom = { "BaseBadge", "Tier1Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 9000, },
			{ Name = "LockKeys", Amount = 10, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Specter_Alpha",
	},

	Badge_Rank09_Tier02 =
	{
		InheritFrom = { "BaseBadge", "Tier2Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 9500, },
			{ Name = "GiftPoints", Amount = 5, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Specter_Delta",
	},

	Badge_Rank09_Tier03 =
	{
		InheritFrom = { "BaseBadge", "Tier3Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 10000, },
			{ Name = "SuperGems", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Specter_Gamma",
	},

	Badge_Rank09_Tier04 =
	{
		InheritFrom = { "BaseBadge", "Tier4Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 10500, },
			{ Name = "SuperGiftPoints", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Specter_Sigma",
	},

	Badge_Rank09_Tier05 =
	{
		InheritFrom = { "BaseBadge", "Tier5Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 11000, },
			{ Name = "SuperLockKeys", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_Specter_Unseen",
	},

	-- One
	Badge_Rank10_Tier01 =
	{
		InheritFrom = { "BaseBadge", "Tier1Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 10000, },
			{ Name = "LockKeys", Amount = 10, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_One_Alpha",
	},

	Badge_Rank10_Tier02 =
	{
		InheritFrom = { "BaseBadge", "Tier2Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 10500, },
			{ Name = "GiftPoints", Amount = 5, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_One_Delta",
	},

	Badge_Rank10_Tier03 =
	{
		InheritFrom = { "BaseBadge", "Tier3Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 11000, },
			{ Name = "SuperGems", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_One_Gamma",
	},

	Badge_Rank10_Tier04 =
	{
		InheritFrom = { "BaseBadge", "Tier4Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 11500, },
			{ Name = "SuperGiftPoints", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_One_Sigma",
	},

	Badge_Rank10_Tier05 =
	{
		InheritFrom = { "BaseBadge", "Tier5Badge" },
		ResourceCost =
		{
			{ Name = "MetaPoints", Amount = 12000, },
			{ Name = "SuperLockKeys", Amount = 1, },
		},
		Icon = "GUI\\HUD\\Badges\\UI_PlayerBadge_One_Unseen",
	},
}

GameData.BadgeOrderData =
{
	"Badge_Rank01_Tier01",
	"Badge_Rank01_Tier02",
	"Badge_Rank01_Tier03",
	"Badge_Rank01_Tier04",
	"Badge_Rank01_Tier05",

	"Badge_Rank02_Tier01",
	"Badge_Rank02_Tier02",
	"Badge_Rank02_Tier03",
	"Badge_Rank02_Tier04",
	"Badge_Rank02_Tier05",

	"Badge_Rank03_Tier01",
	"Badge_Rank03_Tier02",
	"Badge_Rank03_Tier03",
	"Badge_Rank03_Tier04",
	"Badge_Rank03_Tier05",

	"Badge_Rank04_Tier01",
	"Badge_Rank04_Tier02",
	"Badge_Rank04_Tier03",
	"Badge_Rank04_Tier04",
	"Badge_Rank04_Tier05",

	"Badge_Rank05_Tier01",
	"Badge_Rank05_Tier02",
	"Badge_Rank05_Tier03",
	"Badge_Rank05_Tier04",
	"Badge_Rank05_Tier05",

	"Badge_Rank06_Tier01",
	"Badge_Rank06_Tier02",
	"Badge_Rank06_Tier03",
	"Badge_Rank06_Tier04",
	"Badge_Rank06_Tier05",

	"Badge_Rank07_Tier01",
	"Badge_Rank07_Tier02",
	"Badge_Rank07_Tier03",
	"Badge_Rank07_Tier04",
	"Badge_Rank07_Tier05",

	"Badge_Rank08_Tier01",
	"Badge_Rank08_Tier02",
	"Badge_Rank08_Tier03",
	"Badge_Rank08_Tier04",
	"Badge_Rank08_Tier05",

	"Badge_Rank09_Tier01",
	"Badge_Rank09_Tier02",
	"Badge_Rank09_Tier03",
	"Badge_Rank09_Tier04",
	"Badge_Rank09_Tier05",

	"Badge_Rank10_Tier01",
	"Badge_Rank10_Tier02",
	"Badge_Rank10_Tier03",
	"Badge_Rank10_Tier04",
	"Badge_Rank10_Tier05",
}