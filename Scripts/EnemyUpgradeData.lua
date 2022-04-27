EnemyUpgradeData =
{
	EnemyDeathBombUpgrade =
	{
		ScreenPanel = "Harder",
		TreasureValue = 1,
		HideFromNameplate = true,
		MythPointMultiplier = 2.0,
		AddEnemyOnDeathWeapons =
		{
			{
				Weapon = "EnemyDeathWeapon"
			}
		},
	},

	HeroRegen =
	{
		ScreenPanel = "Easier",
		MetaPointMultiplier = -1.0,
		PropertyChanges =
		{

		},
	},

	EnemySpeedReduction =
	{
		ScreenPanel = "Easier",
		MythPointAddition = -1.0,
		PropertyChanges =
		{
			{
				LuaProperty = "SpeedMin",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
			},
			{
				LuaProperty = "SpeedMax",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
			},
		},
	},

	EnemyVolumeReduction =
	{
		ScreenPanel = "Easier",
		MoneyMultiplier = -1.0,
		SpawnMultiplier = 0.5,
		PropertyChanges =
		{

		},
	},

	SampleUpgrade8 =
	{
		ScreenPanel = "Different",
		PropertyChanges =
		{

		},
	},

	SampleUpgrade9 =
	{
		ScreenPanel = "Different",
		PropertyChanges =
		{

		},
	},


	-- God Boon Devotion / Spurn Upgrades --

	ZeusUpgrade =
	{
		ScreenPanel = nil,
		UpgradeString = "LtUpgrade_Zeus",
		--AddSpecialWeapons = { ContinuousWeapon = "DevotionZeus" },
		LieutenantsOnly = true,
		Hidden = true,
		PropertyChanges = { },
	},

	ArtemisUpgrade =
	{
		ScreenPanel = nil,
		UpgradeString = "LtUpgrade_Artemis",
		LieutenantsOnly = true,
		Hidden = true,
		--AddSpecialWeapons = { ContinuousWeapon = "DevotionArtemis" },
		PropertyChanges = { },
	},

	AresUpgrade =
	{
		ScreenPanel = nil,
		UpgradeString = "LtUpgrade_Ares",
		LieutenantsOnly = true,
		Hidden = true,
		--AddSpecialWeapons = { ContinuousWeapon = "DevotionAres" },
		PropertyChanges = {	},
	},

	AthenaUpgrade =
	{
		ScreenPanel = nil,
		UpgradeString = "LtUpgrade_Athena",
		LieutenantsOnly = true,
		Hidden = true,
		--AddSpecialWeapons = { ContinuousWeapon = "EnemyAthenaWeapon" },
		PropertyChanges = {	},
	},

	AphroditeUpgrade =
	{
		ScreenPanel = nil,
		UpgradeString = "LtUpgrade_Aphrodite",
		LieutenantsOnly = true,
		Hidden = true,
		--AddSpecialWeapons = { ContinuousWeapon = "DevotionAphrodite" },
		--AddSpecialWeapons = { ContinuousWeapon = "EnemyAphroditeWeapon" },
		PropertyChanges = {	},
	},

	DionysusUpgrade =
	{
		ScreenPanel = nil,
		UpgradeString = "LtUpgrade_Dionysus",
		LieutenantsOnly = true,
		Hidden = true,
		--AddSpecialWeapons = { ContinuousWeapon = "DevotionDionysus" },
		PropertyChanges = {	},
	},

	PoseidonUpgrade =
	{
		ScreenPanel = nil,
		UpgradeString = "LtUpgrade_Poseidon",
		LieutenantsOnly = true,
		Hidden = true,
		--AddSpecialWeapons = { ContinuousWeapon = "DevotionPoseidon" },
		--AddSpecialWeapons = { ContinuousWeapon = "EnemyPoseidonWeapon" },
		PropertyChanges = {	},
	},

	DemeterUpgrade =
	{
		ScreenPanel = nil,
		UpgradeString = "LtUpgrade_Dionysus",
		LieutenantsOnly = true,
		Hidden = true,
		--AddSpecialWeapons = { ContinuousWeapon = "DevotionDemeter" },
		PropertyChanges = {	},
	},

}

GlobalTextLines = GlobalTextLines or {}

GlobalVoiceLines = GlobalVoiceLines or {}
GlobalVoiceLines.ChallengeSwitchActivatedLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlayAll = 0.33,

		-- Whatever, let's try it.
		{ Cue = "/VO/ZagreusHome_0052" },
		-- Sure, why not.
		{ Cue = "/VO/ZagreusHome_0053" },
		-- How bad could it be?
		{ Cue = "/VO/ZagreusHome_0054" },
		-- Eh, might as well.
		{ Cue = "/VO/ZagreusHome_0055" },
		-- I'll take what's mine.
		{ Cue = "/VO/ZagreusField_0213" },
		-- Open up.
		{ Cue = "/VO/ZagreusField_0214" },
	},
}
