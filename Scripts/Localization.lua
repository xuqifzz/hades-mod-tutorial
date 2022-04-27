--[[ **LOCALIZATION SCRIPTS** ]]

LocalizationData = 
{
	-- Codex
	CodexScripts =
	{
		EntryNameText =
		{
			LangRuScaleModifier = 0.90,
			LangPtBrScaleModifier = 0.95,
			LangJaScaleModifier = 0.90,
		},
		EntryText =
		{
			LangRuScaleModifier = 0.85,
			LangKoScaleModifier = 0.80,
			LangDeScaleModifier = 0.8625,
			LangPtBrScaleModifier = 0.85,
			LangItScaleModifier = 0.90,
			LangPlScaleModifier = 0.90,
			LangEsScaleModifier = 0.95,
			LangFrScaleModifier = 0.95,
			LangCnScaleModifier = 0.80,
			LangJaScaleModifier = 0.825,
		},
		EntryCompleteSkipNewLines =
		{
			"de",
			"ru",
			"ko",
			"fr",
			"ja",
		},
		ChapterName =
		{
			LangDeScaleModifier = 0.75,
			LangEsScaleModifier = 0.8,
			LangFrScaleModifier = 0.8,
			LangKoScaleModifier = 0.9,
			LangPlScaleModifier = 0.8,
			LangPtBrScaleModifier = 0.85,
			LangRuScaleModifier = 0.7,
			LangJaScaleModifier = 0.9,
		},
	},
	-- House Contractor Screen
	GhostAdminScreen =
	{
		FlavorText =
		{
			LangDeScaleModifier = 0.8,
			LangEsScaleModifier = 0.9,
			LangJaScaleModifier = 0.9,
		},
		CosmeticCost =
		{
		},
		CosmeticTitle =
		{
		},
		CosmeticDescription =
		{
			LangFrScaleModifier = 1.0,
			LangItScaleModifier = 1.0,
			LangDeScaleModifier = 1.0,
			LangEsScaleModifier = 1.0,
			LangRuScaleModifier = 1.0,
			LangPlScaleModifier = 1.0,
			LangPtBrScaleModifier = 1.0,
			LangCnScaleModifier = 1.0,
			LangKoScaleModifier = 0.90,
		},
	},
	-- Character narrative / dialog events
	Narrative =
	{
		SpeakerDisplayName =
		{
			LangOffsetY =
			{
				{ Code = "en", Value = 0 },
				{ Code = "ja", Value = -2 },
			},
		},
		SpeakerDescription =
		{
			LangRuScaleModifier = 0.75,
			LangOffsetY =
			{
				{ Code = "en", Value = 0 },
				{ Code = "ja", Value = 2 },
			},
		},
		-- ex: "Sisyphus furtively offers a choice of benefits."
		ChoiceBackground =
		{
			LangRuScaleModifier = 0.6,
			LangPtBrScaleModifier = 0.75,
			LangKoScaleModifier = 0.9,
			LangDeScaleModifier = 0.9,
			LangJaScaleModifier = 0.825,
		},
		ChoiceText =
		{
			LangJaScaleModifier = 0.9,
		},
		DialogueText =
		{
			LangDeScaleModifier = 0.85,
			LangFrScaleModifier = 0.9,
			LangEsScaleModifier = 0.95,
			LangRuScaleModifier = 0.8,
			LangPlScaleModifier = 0.9,
			LangKoScaleModifier = 0.8,
			LangCnScaleModifier = 0.8,
			LangJaScaleModifier = 0.9,
			LangPtBrScaleModifier = 0.9,
		},
	},
	-- Global UI presentation
	UIPresentation =
	{
		LocationTextSizeAwareScale =
		{
			"de", "es", "fr",
		},
		-- Full-screen banner at start of biome, ex: "Tartarus"
		LocationText =
		{
			LangDeScaleModifier = 0.88,
			LangEsScaleModifier = 0.95,
			LangFrScaleModifier = 0.95,
		},
		-- Full-screen banner text when unlocking something
		UnlockText =
		{
			LangFrScaleModifier = 0.85
		}
	},
	UIScripts =
	{
		HealthUI =
		{
			LangCnScaleModifier = 0.8,
			LangJaScaleModifier = 0.8,
		},
		AmmoUI =
		{
			LangCnScaleModifier = 0.8,
			LangJaScaleModifier = 0.8,
		},
		GunUI =
		{
			LangCnScaleModifier = 0.8,
			LangJaScaleModifier = 0.8,
		},
	},
	-- Mid-run boon info screen
	TraitTrayScripts =
	{
		DetailsBacking =
		{
			LangRuScaleModifier = 0.75,
			LangCnScaleModifier = 0.80,
			LangKoScaleModifier = 0.8,
			LangJaScaleModifier = 0.85,
			LangFrScaleModifier = 0.8,
			LangDeScaleModifier = 0.8,
			LangItScaleModifier = 0.8,
			LangPtBrScaleModifier = 0.9,
			LangEsScaleModifier = 0.8,
		},
		DetailsBackingXOffset = 
		{
			["es"] = -290,
		},
		DetailsBackingYOffset =
		{
			["ko"] = -10,
			["zh-CN"] = -10,
			["ja"] = -12,
		},
		DetailsBackingWidth = 
		{
			["es"] = 720,
		},
		TitleBoxXOffset = 
		{		
			["es"] = 140,
		},
		TitleBoxYOffset =
		{
			["ko"] = -5,
			["zh-CN"] = -5,
			["ja"] = -7,
		},
		TitleBox =
		{
			LangKoScaleModifier = 0.90,
		},
		RarityBox =
		{
			LangKoScaleModifier = 0.90,
		},
	},
	BoonInfoScreenScripts =
	{
		RequirementsTitle =
		{
			LangRuScaleModifier = 0.90,
		}
	},
	-- Boon choice / UpgradeChoice screen
	UpgradeChoice =
	{
		FlavorText =
		{
			LangFrScaleModifier = 0.95,
		},
		BoonLootButton =
		{
			LangRuScaleModifier = 0.75,
			LangCnScaleModifier = 0.80,
			LangKoScaleModifier = 0.8,
			LangJaScaleModifier = 0.95,
			LangPlScaleModifier = 0.95,
			LangFrScaleModifier = 0.8,
			LangDeScaleModifier = 0.8,
			LangItScaleModifier = 0.8,
			LangPtBrScaleModifier = 0.9,
			LangEsScaleModifier = 0.8,
		},
		ExchangeText =
		{
			LangRuScaleModifier = 0.75,
			LangCnScaleModifier = 0.80,
			LangKoScaleModifier = 0.8,
			LangJaScaleModifier = 0.95,
			LangPlScaleModifier = 0.95,
			LangFrScaleModifier = 0.8,
			LangDeScaleModifier = 0.8,
			LangItScaleModifier = 0.8,
			LangPtBrScaleModifier = 0.9,
			LangEsScaleModifier = 0.8,
			LangOffsetX =
			{
				["ja"] = 75,
			},
			LangOffsetY = 
			{
				["de"] = 0,
				["en"] = 0,
				["es"] = 0,
				["fr"] = 0,
				["it"] = 0,
				["ja"] = 5,
				["ko"] = 0,
				["pl"] = 3,
				["pt-BR"] = 0,
				["ru"] = 0,
				["zh-CN"] = 0,
			},
		},
	},
	-- Permanent Record
	GameStatsScreen =
	{
		Nav =
		{
			LangCnScaleModifier = 0.95,
			LangKoScaleModifier = 0.95,
			LangPtBrScaleModifier = 0.85,
		},
		WeaponTextHeader = 
		{
			LangDeScaleModifier = 0.85,
			LangRuScaleModifier = 0.85,
		},
		WeaponText = 
		{
			LangDeScaleModifier = 0.90,
			LangPtBrScaleModifier = 1.0,
		},
		BoonText =
		{
			LangDeScaleModifier = 0.90,
			LangItScaleModifier = 0.90,
			LangPlScaleModifier = 0.90,
			LangEsScaleModifier = 0.90,
			LangJaScaleModifier = 0.95,
		},
	},
	MusicPlayerScreen =
	{
		LabelText =
		{
			LangEsScaleModifier = 0.95,
			LangDeScaleModifier = 0.9,
			LangFrScaleModifier = 0.85,
		}
	},
	-- VictoryScreen / RunClearScreen
	RunClearScreen =
	{
		TitleText =
		{
			LangFrScaleModifier = 0.9,
			LangEsScaleModifier = 0.85,
			LangPlScaleModifier = 0.75,
		},
		ColumnHeader =
		{
			LangDeScaleModifier = 0.75,
			LangEsScaleModifier = 0.80,
			LangPlScaleModifier = 0.75,
			LangItScaleModifier = 0.75,
			LangPtBrScaleModifier = 0.75,
			LangRuScaleModifier = 0.75,
			LangJaScaleModifier = 0.75,
		},
		WeaponText =
		{
			LangDeScaleModifier = 0.85,
			LangPtBrScaleModifier = 1.0,
		},
		NewRecordText =
		{
			LangEsScaleModifier = 0.95,
		},
	},
	-- Well of Charon / StoreScripts.lua
	-- Pool of Purging / SellTraitScripts.lua
	SellTraitScripts =
	{
		TitleText =
		{
			LangDeScaleModifier = 0.85,
		},
		FlavorText =
		{
 			LangDeScaleModifier = 0.9,
			LangRuScaleModifier = 0.9,
			LangFrScaleModifier = 0.95, 
			LangJaScaleModifier = 0.9,
		},
		UpgradeTitle =
		{
			TraitNameOffsetX = 
			{
				["de"] = 125,
				["en"] = 75,
				["es"] = 95,
				["fr"] = 95,
				["it"] = 95,
				--["ko"] = 75,
				["pl"] = 125,
				--["pt-BR"] = 0,
				["ru"] = 125,
				--["zh-CN"] = 75,
			},
		},
		ShopButton =
		{
			LangRuScaleModifier = 0.75,
			LangCnScaleModifier = 0.80,
			LangKoScaleModifier = 0.8,
			LangPlScaleModifier = 0.95,
			LangFrScaleModifier = 0.8,
			LangDeScaleModifier = 0.8,
			LangItScaleModifier = 0.8,
			LangPtBrScaleModifier = 0.9,
			LangEsScaleModifier = 0.8,
		},
	},
	-- Fated List of Minor Prophecies / QuestLogScreen
	QuestLogScreen =
	{
		TitleText = 
		{
			LangDeScaleModifier = 0.90,
			LangEsScaleModifier = 0.98,
		},
		-- Left-hand side menu items
		QuestName = 
		{
			LangDeScaleModifier = 0.90,
			LangEsScaleModifier = 0.875,
			LangPtBrScaleModifier = 0.875,
			LangJaScaleModifier = 0.85,
		},
		QuestDescription =
		{
			LangDeScaleModifier = 0.85,
			LangEsScaleModifier = 0.95,
			LangJaScaleModifier = 0.90,
			LangKoScaleModifier = 0.85,
		},
		QuestLogRewardText =
		{
			LangDeScaleModifier = 0.87,
			LangEsScaleModifier = 0.85,
			LangItScaleModifier = 0.87,
			LangPtBrScaleModifier = 0.85,
			LangJaScaleModifier = 0.90,
			LangKoScaleModifier = 0.85,
		}
	},
	-- Wretched Broker
	MarketScreen =
	{
		FlavorText =
		{
			LangDeScaleModifier = 0.90,
		},
	},
	-- WeaponUpgradeScripts / Aspect / Weapon Select
	WeaponUpgradeScripts =
	{
		WeaponDisplayName =
		{
			--LangJaScaleModifier = 0.9,
		},
		WeaponDescription =
		{
			LangCnScaleModifier = 0.8,
			LangRuScaleModifier = 0.8,
			LangDeScaleModifier = 0.8,
			LangEsScaleModifier = 0.9,
			LangFrScaleModifier = 0.8,
			LangPtBrScaleModifier = 0.8,
			LangItScaleModifier = 0.8,
			LangKoScaleModifier = 0.80,
			LangJaScaleModifier = 0.85,
		}
	},
}