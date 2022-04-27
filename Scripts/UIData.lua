ConstantsData = {}

TextFormats =
{
	-- note: 1080p livingroom recommendation font size is 28 - 32px

	-- for Boon Strings
	BaseFormat =
	{
		Font = "AlegreyaSansRegular",
		FontSize = 19.5,
		Color = { 160, 160, 160, 255 },
		VerticalJustification = "Top",
		TextSymbolScale = 0.85,
	},

	BoldFormat =
	{
		Font = "AlegreyaSansExtraBold",
		FontSize = 19.5,
		Color = { 210, 210, 210, 255 },
		VerticalJustification = "Top",
		TextSymbolScale = 0.85,
		Graft = true,
	},

	BoldFormatGraft =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = { 230, 230, 230, 255 },
		TextSymbolScale = 0.7,
	},

	BoldFormatGraftNoColor =
	{
		Graft = true,
		UseEmphasizedFont = true,
		TextSymbolScale = 0.7,
	},

	ItalicFormat =
	{
		Font = "AlegreyaSansItalic",
		Graft = true,
	},

	ItalicFormatDark =
	{
		Font = "AlegreyaSansItalic",
		Color = {132,83,50,255},
		Graft = true,
	},

	StatFormat =
	{
		Graft = true,
		Color = { 160, 190, 160, 255 },
		TextSymbolScale = 0.7,
	},

	WhiteFormat =
	{
		Graft = true,
		Color = Color.White,
	},

	DarkFormat =
	{
		Graft = true,
		Color = Color.Chocolate,
	},

	AltUpgradeFormat =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = Color.UpgradeGreen,
	},

	AltPenaltyFormat =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = Color.PenaltyRed,
	},

	CommonFormat =
	{
		Graft = true,
		Color = Color.BoonPatchCommon,
	},

	RareFormat =
	{
		Graft = true,
		Color = Color.BoonPatchRare,
	},

	EpicFormat =
	{
		Graft = true,
		Color = Color.BoonPatchEpic,
	},

	DuoFormat =
	{
		Graft = true,
		Color = Color.BoonPatchDuo,
	},

	HeroicFormat =
	{
		Graft = true,
		Color = Color.BoonPatchHeroic,
	},

	LegendaryFormat =
	{
		Graft = true,
		Color = Color.BoonPatchLegendary,
	},

	HighlightFormatGraft =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = Color.Gold,
	},

	MediumFormatGraft =
	{
		Graft = true,
		UseEmphasizedFont = false,
		Color = Color.White,
		Font = "AlegreyaSansSCMedium"
	},

	PactFormatGraft =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = Color.PactOrange,
	},

	VitalStatsFormat =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = Color.VitalStats,
	},

	PropertyFormat =
	{
		Font = "AlegreyaSansRegular",
		FontSize = 20,
		Color = Color.LightGray,
		VerticalJustification = "Top",
		Graft = true,
	},

	LockedFormat =
	{
		Graft = true,
		Color = { 155, 155, 155, 180 },
	},

	SlainByFormat =
	{
		Font = "AlegreyaSansExtraBold",
		FontSize = 20,
		Color = { 155, 155, 155, 180 },
		ShadowColor = Color.Black, ShadowOffset = {3, 3}, ShadowBlur = 3, ShadowAlpha = 1.0,
		VerticalJustification = "Top",
		Graft = true,
	},

	OldFormat =
	{
		Font = "AlegreyaSansExtraBold",
		Color = Color.SlateGray,
		BlockEmphasizedFont = true,
		VerticalJustification = "Top",
		Graft = true,
	},

	LevelFormat =
	{
		FontSize = 25,
		Color = Color.UpgradeGreen,
		Font = "AlegreyaSansSCBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
	},

	TeamFormat =
	{
		Graft = true,
		Color = {240, 240, 240, 255},
		Font = "AlegreyaSansSCMedium",
	},

	TeamZagFormat =
	{
		Graft = true,
		Color = {220,50,25,255},
		Font = "AlegreyaSansSCExtraBold",
	},
	TeamThanFormat =
	{
		Graft = true,
		Color = Color.ThanatosVoice,
		Font = "AlegreyaSansSCExtraBold",
	},

	--[[
	PreviousFormat =
	{
		Font = "AlegreyaSansExtraBold",
		FontSize = 20,
		Color = Color.SlateGray,
		VerticalJustification = "Top",
	},
	--]]

	UpgradeFormat =
	{
		Font = "AlegreyaSansExtraBold",
		BlockEmphasizedFont = true,
		Color = Color.UpgradeGreen,
		ShadowColor = Color.Black, ShadowOffset = {3, 3}, ShadowBlur = 3, ShadowAlpha = 1.0,
		VerticalJustification = "Top",
		Graft = true,
	},

	PenaltyFormat =
	{
		Font = "AlegreyaSansExtraBold",
		FontSize = 20,
		Color = Color.PenaltyRed,
		ShadowColor = Color.Black, ShadowOffset = {3, 3}, ShadowBlur = 3, ShadowAlpha = 1.0,
		VerticalJustification = "Top",
		Graft = true,
	},

	PenaltyFormatGraft =
	{
		Color = Color.PenaltyRed,
		ShadowColor = Color.Black, ShadowOffset = {3, 3}, ShadowBlur = 3, ShadowAlpha = 1.0,
		VerticalJustification = "Top",
		Graft = true,
	},

	HighlightFormat =
	{
		Font = "AlegreyaSansExtraBold",
		FontSize = 20,
		Color = Color.Gold,
		ShadowColor = Color.Black, ShadowOffset = {3, 3}, ShadowBlur = 3,
		OutlineThickness = 2.0, OutlineColor = {0.0, 0.0, 0.0, 1.0},
		VerticalJustification = "Top",
	},

	MetaUpgradeDisplayResultFormat =
	{
		Font = "AlegreyaSansSCBold",
		FontSize = 26,
		ShadowBlur = 0,
		ShadowColor = { 68, 68, 68, 255 },
		ShadowOffset = { 0, 6 },
		Color = Color.White,
	},

	MetaUpgradeDisplayInvalidFormat =
	{
		Font = "AlegreyaSansSCBold",
		FontSize = 26,
		Color = Color.MetaUpgradePointsInvalid,
		ShadowBlur = 0,
		ShadowColor = { 95, 44, 44, 255 },
		ShadowOffset = { 0, 6 },
	},

	MetaUpgradeDisplayMiscFormat =
	{
		Font = "AlegreyaSansSCBold",
		FontSize = 18,
		ShadowBlur = 0,
		ShadowColor = { 68, 68, 68, 255 },
		ShadowOffset = { 0, 6 },
		Graft = true,
	},

	ShrineUpgradeDisplayPenaltyFormat =
	{
		Font = "AlegreyaSansSCBold",
		FontSize = 26,
		Color = Color.PenaltyRed,
		ShadowBlur = 0,
		ShadowColor = { 95, 44, 44, 255 },
		ShadowOffset = { 0, 6 },
	},

	UpgradeTitleFormat =
	{
		Font = "SpectralSCLight",
		FontSize = 32,
		Color = Color.LimeGreen,
		ShadowBlur = 3, ShadowColor = {0.0, 0.0, 0.0, 1.0}, ShadowOffset = {0, 2},
		VerticalJustification = "Top",
	},

	-- AutoToolTip
	TooltipUpgradeFormat =
	{
		Font = "AlegreyaSansExtraBold",
		FontSize = 17,
		Color = Color.UpgradeGreen,
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 4},
		Graft = true,
	},
	TooltipPenaltyFormat =
	{
		Font = "AlegreyaSansExtraBold",
		FontSize = 17,
		Color = Color.PenaltyRed,
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 4},
		Graft = true,
	},
	TooltipBoldFormat =
	{
		Font = "AlegreyaSansSCBold",
		FontSize = 17,
		Graft = true,
	},

	-- AwardMenu
	AwardFlavorFormat =
	{
		FontSize = 20,
		Color = Color.FlavorText,
		Font = "AlegreyaSansItalic",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 4},
		Justification = "Left",
		Graft = true,
	},
	AwardMaxFlavorFormat =
	{
		FontSize = 20,
		Color = Color.MaxFlavorText,
		Font = "AlegreyaSansItalic",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 4},
		Justification = "Left",
		Graft = true,
	},
	AwardDarkFlavorFormat =
	{
		FontSize = 20,
		Color = {142, 131, 92, 255},
		Font = "AlegreyaSansItalic",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 4},
		Justification = "Left",
		Graft = true,
	},

	-- Misc
	CauseOfDeathFormat =
	{
		Graft = true,
		Color = Color.Tomato,
		ShadowBlur = 3, ShadowColor = {0.0, 0.0, 0.0, 1.0}, ShadowOffset = {0, 2},
		VerticalJustification = "Top",
	},
	OverlookFormat =
	{
		Font = "AlegreyaSansSCBold",
		FontSize = 28,
		Color = { 0.398, 0.802, 0.314, 0.6 },
	},

	-- for Dialogue
	DialogueItalicFormat =
	{
		Graft = true,
		UseEmphasizedFont = true,
		LineSpacingBottom = 4,
	},

	ChoiceFormat =
	{
		Font = "AlegreyaSansSCExtraBold",
		FontSize = 32,
		Color = Color.ChoiceText,
	},

	ChoiceBracketFormat =
	{
		Font = "AlegreyaSansSCExtraBold",
		FontSize = 32,
		Color = {33, 33, 33, 255},
	},

	-- for Codex
	-- @Gavin: adding this because {#PreviousFormat} did not work for strings such as Codex_Complete. [GK 6/14/18]
	CodexStandardFormat =
	{
		Font = "AlegreyaSansSCRegular",
		FontSize = 24,
		Color = Color.CodexTitleUnselected,
		LangFrScaleModifier = 0.90,
		LangRuScaleModifier = 0.90,
		LangPtBrScaleModifier = 0.95,
		LangKoScaleModifier = 0.80,
		LangJaScaleModifier = 0.825,
	},

	CodexBoldFormat =
	{
		Font = "AlegreyaSansExtraBold",
		FontSize = 20,
		Color = Color.CodexText,
		Graft = true,
	},

	CodexItalicFormat =
	{
		Font = "AlegreyaSansItalic",
		Graft = true,
	},

	CodexPreReqFormat =
	{
		Font = "AlegreyaSansSCBold",
		FontSize = 24,
		Color = {0.965, 0.702, 0.031, 1.0},
		LangFrScaleModifier = 0.90,
		LangRuScaleModifier = 0.90,
		LangPtBrScaleModifier = 0.95,
		LangKoScaleModifier = 0.80,
		LangJaScaleModifier = 0.825,
	},

	CodexPreReqNumberFormat =
	{
		Font = "AlegreyaSansSCBold",
		FontSize = 24,
		Color = {1.000, 0.984, 0.729, 1.0},
		LangFrScaleModifier = 0.90,
		LangRuScaleModifier = 0.90,
		LangPtBrScaleModifier = 0.95,
		LangKoScaleModifier = 0.80,
		LangJaScaleModifier = 0.825,
	},

	CodexChapterClearFormat =
	{
		Font = "AlegreyaSansSCBold",
		FontSize = 24,
		Color = {0.718, 0.596, 0.180, 1.0},
		LangDeScaleModifier = 0.85,
		LangRuScaleModifier = 0.85,
		LangKoScaleModifier = 0.80,
		LangJaScaleModifier = 0.825,
	},

	InstructionMainFormat =
	{
		Font = "Garamond",
		FontSize = 20,
		Color = Color.Orange,
		ShadowColor = Color.Black, ShadowOffset = {3, 3}, ShadowBlur = 3,
		OutlineThickness = 3.0, OutlineColor = {0.3, 0.29, 0.28, 1.0},
		TextSymbolScale = 0.3
	},

	InstructionSubFormat =
	{
		Font = "Garamond",
		FontSize = 20,
		Color = Color.Gold,
		ShadowColor = Color.Black, ShadowOffset = {3, 3}, ShadowBlur = 3,
		OutlineThickness = 3.0, OutlineColor = {0.3, 0.29, 0.28, 1.0},
		TextSymbolScale = 0.3
	},

	RatingFormat =
	{
		Font = "Garamond",
		FontSize = 20,
		Justification = "Left",
		Color = Color.White,
		ShadowColor = Color.Black, ShadowOffset = {3, 3}, ShadowBlur = 3,
		OutlineThickness = 1.0, OutlineColor = {0.3, 0.29, 0.28, 1.0},
		TextSymbolScale = 0.3
	},

	BossCounterFormat =
	{
		Font = "SpectralSCLight",
		FontSize = 18,
		Color = Color.White,
		ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
		OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 5,
		ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
	},

	BossDistanceFormat =
	{
		Font = "SpectralSCBold",
		FontSize = 32,
		OutlineColor = {0.113, 0.113, 0.113, 1},
		OutlineThickness = 5,
		ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
		ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
	},

	MythmakeOptionTitleFormat =
	{
		Font = "SpectralSCBold", FontSize = 32,
		Color = Color.Title,
		Width = 460,
		ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
		ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
	},

	DoorTextFormat =
	{
		Font = "AlegreyaSansSCBold",
		Color = Color.Crimson,
		FontSize = 96,
		OutlineColor = {0.113, 0.113, 0.113, 1},
		OutlineThickness = 2,
		Width = 460,
		ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
		ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
	},

	LootFormat =
	{
		FontSize = 24,
		Font = "AlegreyaSansSCBold",
		ShadowColor = Color.Green,
		ShadowOffset = {0, 2},
		ShadowBlur = 0,
		TextSymbolScale = 0.1,
	},

	UseTextFormat =
	{
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.White,
		Font = "AlegreyaSansExtraBold",
		FontSize = 26,
		TextSymbolScale = 0.75,
	},

	UseTextDamageFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.Red,
	},

	UseTextHealingFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.LimeGreen,
	},

	UseTextPreReqFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.Gold,
	},

	UseTextDisabledFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = { 155, 155, 155, 180 },
	},

	UseMetaPointFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = { 168, 0, 168, 255 },
	},

	UseMetaPointFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = { 168, 0, 168, 255 },
	},

	UseMoneyFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.LightGold,
	},

	UseShrinePointFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.ShrinePoint,
	},

	UseGiftPointFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = {1, 0.97, 0.7, 1},
	},

	UseLockKeyFormat =
	{
		Graft = true,
		ShadowBlur = 0,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.MetaUpgradePointsDisplay,
	},

	UseTextChallengeFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = Color.DarkViolet,
	},

	MetaPointFormat =
	{
		Graft = true,
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		OutlineThickness = 3,
		OutlineColor = {0.0, 0.0, 0.0,1},
		Color = { 168, 0, 168, 255 },
	},

	MarketScreenMainFormat =
	{
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		FontSize = 36,
		OffsetX = -360, OffsetY = 0,
		Width = 720,
		Color = Color.CostAffordableShop,
		Font = "AlegreyaSansSCRegular",
	},
	MarketScreenCostFormat =
	{
		ShadowBlur = 2,
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 3},
		FontSize = 36,
		OffsetX = -360, OffsetY = 0,
		Width = 720,
		Color = Color.White,
		Font = "AlegreyaSansSCRegular",
	},
	MarketScreenDescriptionFormat =
	{
		Font = "AlegreyaSansRegular",
		FontSize = 16,
		Color = { 160, 160, 160, 255 },
		VerticalJustification = "Top",
		TextSymbolScale = 0.7,
	},
	AltMarketScreenCostFormat =
	{
		Graft = true,
		UseEmphasizedFont = true,
		Color = Color.AntiqueWhite,
	},

	CombatTextHighlightFormat =
	{
		Graft = true,
		Color = Color.Orange,
	},

	DeemphasizedFormat =
	{
		Graft = true,
		FontSize = 18,
		Color = {0.5,0.5,0.5,1.0},
	},

	-- Taken from Audio.sjson, for use in ending credits song
	OrpheusSoloFormat =
	{
		Graft = true,
		Font = "AlegreyaSansExtraBoldItalic",
		Color = { 107, 115, 158, 255 },
	},
	EurydiceSoloFormat =
	{
		Graft = true,
		Font = "AlegreyaSansExtraBoldItalic",
		Color = { 238, 255, 100, 255 },
	}

}

IconData =
{
	BlankIcon =
	{
		TexturePath = "Dev\\blank_invisible",
		UseTooltip = false,
	},

	SaveSymbol =
	{
		TexturePath = "GUI\\Icons\\Hades_Symbol_01",
		UseTooltip = false,
		TextSymbolScale = 0.5,
	},

	TraitExchange =
	{
		TexturePath = "GUI\\Icons\\TraitExchange",
		UseTooltip = true,
	},

	ScoreValue =
	{
		TexturePath = "GUI\\Icons\\Pyre\\Pyre_Generic_Small",
		UseTooltip = true,
	},

	ScoreValueLarge =
	{
		TexturePath = "GUI\\Icons\\Pyre\\Pyre_Generic",
		UseTooltip = true,
	},

	Quest =
	{
		TexturePath = "GUI\\Icons\\Map\\Sub_Icon_Quest",
		UseTooltip = true,
	},

	TallyDotPlus =
	{
		TexturePath = "GUI\\Screens\\XP_Tally_Dot_Plus",
	},

	TallyDotX =
	{
		TexturePath = "GUI\\Screens\\XP_Tally_Dot_X",
	},

	RightArrow =
	{
		TexturePath = "GUI\\HUD\\tooltip_arrow",
		UseTooltip = false,
	},

	Bullet =
	{
		TexturePath = "GUI\\Icons\\Bullet",
	},

	Div =
	{
		TexturePath = "GUI\\HorizontalDivider",
	},

	StandingsRankInfinite =
	{
		TexturePath = "GUI\\Screens\\StandingsRankInfinite",
		UseTooltip = true,
	},

	SaveSpinner =
	{
		TexturePath = "GUI\\Icons\\Hades_Symbol_01",
	},

	Damage =
	{
		TexturePath = "GUI\\Icons\\Pyre\\Pyre_Generic_Damage_Small",
		UseTooltip = true,
	},

	Health =
	{
		TexturePath = "GUI\\Icons\\Life",
		UseTooltip = true,
	},
	HealthHome =
	{
		TexturePath = "GUI\\Icons\\Life",
		UseTooltip = true,
	},
	HealthHome_Small =
	{
		TexturePath = "GUI\\Icons\\Life_Small",
		UseTooltip = true,
	},
	KEnemyHealth_Small =
	{
		TexturePath = "GUI\\Icons\\Life_Small",
		UseTooltip = true,
	},

	HealthRestore =
	{
		TexturePath = "GUI\\Icons\\LifeRestore",
		UseTooltip = true,
	},
	HealthRestoreHome =
	{
		TexturePath = "GUI\\Icons\\LifeRestore_Small",
		UseTooltip = true,
	},

	HealthUp =
	{
		TexturePath = "GUI\\Icons\\LifeUp",
		UseTooltip = true,
	},

	HealthUp_Small =
	{
		TexturePath = "GUI\\Icons\\LifeUp_Small",
		UseTooltip = true,
	},
	HealthUpAlt_Small =
	{
		TexturePath = "GUI\\Icons\\LifeUp_Small",
		UseTooltip = true,
	},
	HealthDown_Small =
	{
		TexturePath = "GUI\\Icons\\LifeUp_Small",
		UseTooltip = true,
	},

	ShieldHealth =
	{
		TexturePath = "GUI\\Icons\\UnLife",
		UseTooltip = true,
	},

	ShieldHealth_Small =
	{
		TexturePath = "GUI\\Icons\\UnLife_Small",
		UseTooltip = true,
	},

	Health_Small =
	{
		TexturePath = "GUI\\Icons\\Life_Small",
		UseTooltip = true,
	},
	Health_Small_Tooltip =
	{
		TexturePath = "GUI\\Icons\\Life_Small",
		UseTooltip = true,
	},

	HealthRestore_Small =
	{
		TexturePath = "GUI\\Icons\\LifeRestore_Small",
		UseTooltip = true,
	},
	HealthRestore_Small_Tooltip =
	{
		TexturePath = "GUI\\Icons\\LifeRestore_Small",
		UseTooltip = true,
	},

	Elite =
	{
		TexturePath = "GUI\\Icons\\Elite_Badge_01",
		UseTooltip = true,
	},

	MiniBoss =
	{
		TexturePath = "GUI\\Icons\\Elite_Badge_02",
		UseTooltip = true,
	},

	ElitePerk =
	{
		TexturePath = "GUI\\Icons\\Attributes\\Brawny",
		UseTooltip = false,
	},

	Ammo =
	{
		TexturePath = "GUI\\Icons\\Ammo",
		UseTooltip = true,
	},

	Ammo_Small =
	{
		TexturePath = "GUI\\Icons\\Ammo_Small",
		UseTooltip = true,
	},

	GunAmmo_Small =
	{
		TexturePath = "GUI\\Icons\\GunAmmo_Small",
		UseTooltip = true,
	},

	LuciferAmmo_Small =
	{
		TexturePath = "GUI\\Icons\\LaserAmmo_Small",
		UseTooltip = true,
	},

	ReRoll =
	{
		TexturePath = "GUI\\Icons\\ReRoll",
		UseTooltip = true,
	},
	ReRoll_Small =
	{
		TexturePath = "GUI\\Icons\\ReRoll_Small",
		UseTooltip = true,
	},
	ReRollAlt =
	{
		TexturePath = "GUI\\Icons\\ReRoll",
		UseTooltip = true,
	},
	ReRollAlt_Small =
	{
		TexturePath = "GUI\\Icons\\ReRoll_Small",
		UseTooltip = true,
	},
	ReRollPanelAlt =
	{
		TexturePath = "GUI\\Icons\\ReRoll",
		UseTooltip = true,
	},
	ReRollPanelAlt_Small =
	{
		TexturePath = "GUI\\Icons\\ReRoll_Small",
		UseTooltip = true,
	},

	Dash =
	{
		TexturePath = "GUI\\Icons\\Dash",
		UseTooltip = true,
	},

	Attack_Small =
	{
		TexturePath = "GUI\\Icons\\Attack_Small",
		UseTooltip = true,
	},

	GunAmmo =
	{
		TexturePath = "GUI\\Icons\\GunAmmo",
		UseTooltip = true,
	},

	GunAmmoHUD =
	{
		TexturePath = "GUI\\HUD\\GunAmmoIconHUD",
		UseTooltip = true,
	},

	ExtraChance =
	{
		TexturePath = "GUI\\Icons\\ExtraChance",
		UseTooltip = true,
	},
	ExtraChanceRegen =
	{
		TexturePath = "GUI\\Icons\\ExtraChanceRegen",
		UseTooltip = false,
	},

	WrathStock =
	{
		TexturePath = "GUI\\Icons\\WrathStock",
		UseTooltip = true,
	},

	Alert =
	{
		TexturePath = "GUI\\Icons\\Status\\WantsToFight",
		UseTooltip = true,
	},

	Aware =
	{
		TexturePath = "GUI\\Icons\\Status\\Aware",
		UseTooltip = true,
	},

	Startled  =
	{
		TexturePath = "GUI\\Icons\\Status\\Startled",
		UseTooltip = true,
	},

	AttackWarning =
	{
		TexturePath = "GUI\\Icons\\Status\\WantsToTalk",
		UseTooltip = true,
	},

	Super =
	{
		TexturePath = "GUI\\Icons\\Super",
		UseTooltip = true,
	},


	WrathPips25 =
	{
		TexturePath = "GUI\\Icons\\WrathPips25",
		UseTooltip = true,
	},

	WrathPips50 =
	{
		TexturePath = "GUI\\Icons\\WrathPips50",
		UseTooltip = true,
	},

	WrathPips75 =
	{
		TexturePath = "GUI\\Icons\\WrathPips75",
		UseTooltip = true,
	},

	WrathPips100 =
	{
		TexturePath = "GUI\\Icons\\WrathPips100",
		UseTooltip = true,
	},


	Currency =
	{
		TexturePath = "GUI\\Icons\\Currency",
		UseTooltip = true,
	},

	Currency_Small =
	{
		TexturePath = "GUI\\Icons\\Currency_Small",
		UseTooltip = true,
	},

	MetaPoint =
	{
		TexturePath = "GUI\\Icons\\Darkness",
		UseTooltip = true,
	},

	MetaPoint_Small =
	{
		TexturePath = "GUI\\Icons\\Darkness_Small",
		UseTooltip = true,
	},

	Gem =
	{
		TexturePath = "GUI\\Icons\\Gems",
		UseTooltip = true,
	},

	SuperGem =
	{
		TexturePath = "GUI\\Icons\\SuperGems",
		UseTooltip = true,
	},

	GemSmall =
	{
		TexturePath = "GUI\\Icons\\Gems_Small",
		UseTooltip = true,
	},

	SuperGemSmall =
	{
		TexturePath = "GUI\\Icons\\SuperGems_Small",
		UseTooltip = true,
	},

	SuperLockKey =
	{
		TexturePath = "GUI\\Icons\\Blood",
		UseTooltip = true,
	},

	SuperLockKeySmall =
	{
		TexturePath = "GUI\\Icons\\Blood_Small",
		UseTooltip = true,
	},

	PomSmall =
	{
		TexturePath = "GUI\\Icons\\Pom_Small",
		UseTooltip = false,
	},

	RandomPom =
	{
		TexturePath = "GUI\\Icons\\RandomPom",
		UseTooltip = true,
	},

	RandomPomSmall =
	{
		TexturePath = "GUI\\Icons\\RandomPom_Small",
		UseTooltip = true,
	},

	RandomHammerSmall =
	{
		TexturePath = "GUI\\Icons\\RandomHammer_Small",
		UseTooltip = true,
	},
	HammerSmall =
	{
		TexturePath = "GUI\\Icons\\Hammer_Small",
		UseTooltip = false,
	},	
	RandomLootSmall =
	{
		TexturePath = "GUI\\Icons\\RandomLoot_Small",
		UseTooltip = true,
	},
	LootSmall =
	{
		TexturePath = "GUI\\Icons\\Loot_Small",
	},

	FatedChoice =
	{
		TexturePath = "GUI\\Screens\\QuestLog\\QuestAdded_Small",
		UseTooltip = true,
	},

	ShrinePoint =
	{
		TexturePath = "GUI\\Icons\\ShrinePoint",
		UseTooltip = true,
	},

	ShrinePointSmall =
	{
		TexturePath = "GUI\\Icons\\ShrinePoint_Small",
		UseTooltip = true,
	},

	ShrinePointSmall_Active =
	{
		TexturePath = "GUI\\Icons\\ShrinePoint_Small_Active",
		UseTooltip = true,
	},
	ShrinePointSmall_Active_Grayscale =
	{
		TexturePath = "GUI\\Icons\\ShrinePoint_Small_Active_Grayscale",
	},
	VulnerabilityIcon =
	{
		TexturePath = "GUI\\HUD\\VulnerabilityIcon_Small",
		UseTooltip = true,
		TextSymbolScale = 0.3
	},
	PoisonIcon =
	{
		TexturePath = "GUI\\Icons\\PoisonIcon_Small",
		UseTooltip = false,
	},
	MythPoint =
	{
		TexturePath = "GUI\\Icons\\Contract",
		UseTooltip = true,
	},

	GiftPoint =
	{
		TexturePath = "GUI\\Icons\\Gift",
		UseTooltip = true,
	},

	GiftPointSmall =
	{
		TexturePath = "GUI\\Icons\\Gift_Small",
		UseTooltip = true,
	},

	SuperGiftPoint =
	{
		TexturePath = "GUI\\Icons\\SuperGift",
		UseTooltip = true,
	},

	SuperGiftPointSmall =
	{
		TexturePath = "GUI\\Icons\\SuperGift_Small",
		UseTooltip = false,
	},

	LockKey =
	{
		TexturePath = "GUI\\Icons\\LockKey",
		UseTooltip = true,
	},

	LockKeySmall =
	{
		TexturePath = "GUI\\Icons\\LockKey_Small",
		UseTooltip = true,
	},

	GoldLaurel =
	{
		TexturePath = "GUI\\Icons\\GoldLaurel",
		UseTooltip = true,
	},

	FavorPoint =
	{
		TexturePath = "GUI\\Icons\\Favor",
		UseTooltip = true,
	},

	SeasonalItem =
	{
		TexturePath = "GUI\\Screens\\SeasonalItem",
		UseTooltip = true,
	},

	SeasonalItemAlt =
	{
		TexturePath = "GUI\\Screens\\LimitedTimeOffer",
		UseTooltip = false,
	},

	LimitedTimeOffer =
	{
		TexturePath = "GUI\\Screens\\LimitedTimeOffer",
		UseTooltip = true,
	},
	SpecialOffer =
	{
		TexturePath = "GUI\\Screens\\LimitedTimeOffer",
		UseTooltip = true,
	},

	Locked =
	{
		TexturePath = "GUI\\Icons\\Locked",
	},

	PurchasedCheckmark =
	{
		TexturePath = "GUI\\Screens\\ContractorPurchasedCheckmark",
	},

	MirrorInactive =
	{
		TexturePath = "GUI\\Screens\\MirrorLockedB",
	},

	DefaultPurchasedCheckmark =
	{
		TexturePath = "GUI\\Screens\\MirrorUnlockedA",
	},

	MirrorPurchasedCheckmark =
	{
		TexturePath = "GUI\\Screens\\MirrorUnlockedB",
	},

	PactPurchasedCheckmark =
	{
		TexturePath = "GUI\\Screens\\MirrorUnlockedC",
	},

	CheckboxEmpty =
	{
		TexturePath = "GUI\\Shell\\settings_toggle_off",
	},
	CheckboxFilled =
	{
		TexturePath = "GUI\\Shell\\settings_toggle_on",
	},


	RewardLoot =
	{
		TexturePath = "GUI\\Icons\\RewardLoot",
		UseTooltip = true,
	},

	RewardBoon =
	{
		TexturePath = "GUI\\Icons\\Boon",
		UseTooltip = true,
	},

	RewardStackUpgrade =
	{
		TexturePath = "GUI\\Icons\\Contract_01",
		UseTooltip = true,
	},

	RewardMetaPoint =
	{
		TexturePath = "GUI\\Icons\\RewardDarkness",
		UseTooltip = true,
	},

	RewardMetaModifier =
	{
		TexturePath = "GUI\\Icons\\RewardMetaModifier",
		UseTooltip = true,
	},

	RewardShop =
	{
		TexturePath = "GUI\\Icons\\RewardShop",
		UseTooltip = true,
	},

	RewardStory =
	{
		TexturePath = "GUI\\Icons\\RewardStory",
		UseTooltip = true,
	},

	RewardDevotion =
	{
		TexturePath = "GUI\\Icons\\RewardDevotion",
		UseTooltip = true,
	},

	RewardRandom =
	{
		TexturePath = "GUI\\Icons\\RewardRandom",
		UseTooltip = true,
	},

	RewardUnknown =
	{
		TexturePath = "GUI\\Icons\\RewardUnknown",
		UseTooltip = true,
	},

	BuffHealing =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\hydralite_05_small",
		UseTooltip = true,

	},
	BuffWeapon =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\cyclops_jerky_01_small",
		UseTooltip = true,
	},
	BuffExtraChance =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\kiss_of_styx_13_small",
		UseTooltip = true,
	},
	BuffExtraChanceAlt =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\kiss_of_styx_13_small",
		UseTooltip = true,
	},

	BuffMegaPom =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\pom_porridge_small",
		UseTooltip = true,
	},
	BuffSlottedBoonRarity =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\ambrosia_delight_small",
		UseTooltip = true,
	},
	BuffFutureBoonRarity =
	{
		TexturePath = "GUI\\Screens\\ShopIcons\\refreshing_nectar_small",
		UseTooltip = true,
	},

	StarFull =
	{
		TexturePath = "GUI\\Icons\\StarFull",
		UseTooltip = false,
	},

	StarEmpty =
	{
		TexturePath = "GUI\\Icons\\StarEmpty",
		UseTooltip = false,
	},

	Infinite =
	{
		TexturePath = "GUI\\HUD\\InfiniteIcon",
		UseTooltip = false,
	},

	Slash =
	{
		TexturePath = "GUI\\HUD\\Slash",
		UseTooltip = false,
	},

	Clock =
	{
		TexturePath = "GUI\\HUD\\TimeIcon",
		UseTooltip = false,
	},

	Refresh =
	{
		TexturePath = "GUI\\HUD\\RefreshIcon",
		UseTooltip = false,
	},

	Shielded =
	{
		TexturePath = "GUI\\Icons\\Status\\MyrmidonBracer"
	},

	Champion =
	{
		TexturePath = "GUI\\Icons\\Hades_Symbol_01"
	},

	Elite =
	{
		TexturePath = "GUI\\Icons\\Elite_Badge_01"
	},
	EliteElusive =
	{
		TexturePath = "GUI\\Icons\\Attributes\\Elusive"
	},
	EliteFrenzied =
	{
		TexturePath = "GUI\\Icons\\Attributes\\Frenzied"
	},
	EliteBrawny =
	{
		TexturePath = "GUI\\Icons\\Attributes\\Brawny"
	},
	EliteMolten =
	{
		TexturePath = "GUI\\Icons\\Attributes\\Molten"
	},
	EliteSniper =
	{
		TexturePath = "GUI\\Icons\\Attributes\\Sniper"
	},
	EliteSavage =
	{
		TexturePath = "GUI\\Icons\\Attributes\\Savage"
	},
	EliteMorbid =
	{
		TexturePath = "GUI\\Icons\\Attributes\\Morbid"
	},
	EliteCloner =
	{
		TexturePath = "GUI\\Icons\\Attributes\\Doppelganger"
	},
	EliteSoulbound =
	{
		TexturePath = "GUI\\Icons\\Attributes\\Soulbound"
	},
	EliteDefender =
	{
		TexturePath = "GUI\\Icons\\Attributes\\Defender"
	},
	EliteSpawner =
	{
		TexturePath = "GUI\\Icons\\Attributes\\Spawner"
	},
	NoCanDo =
	{
		TexturePath = "GUI\\Icons\\NoCanDo",
	},

	AwardRank1 =
	{
		TexturePath = "GUI\\Screens\\AwardMenu\\altRank_1",
	},

	AwardRank2 =
	{
		TexturePath = "GUI\\Screens\\AwardMenu\\altRank_2",
	},

	AwardRank3 =
	{
		TexturePath = "GUI\\Screens\\AwardMenu\\altRank_3",
	},

	LegendaryAwardRank1 =
	{
		TexturePath = "GUI\\Screens\\AwardMenu\\legendRank_1",
	},

	LegendaryAwardRank2 =
	{
		TexturePath = "GUI\\Screens\\AwardMenu\\legendRank_2",
	},

	LegendaryAwardRank3 =
	{
		TexturePath = "GUI\\Screens\\AwardMenu\\legendRank_3",
	},

	LegendaryAwardRank4 =
	{
		TexturePath = "GUI\\Screens\\AwardMenu\\legendRank_4",
	},

	LegendaryAwardRank5 =
	{
		TexturePath = "GUI\\Screens\\AwardMenu\\rank_5",
	},

	EasyModeIcon =
	{
		TexturePath = "GUI\\Shell\\EasyMode"
	},
	HardModeIcon =
	{
		TexturePath = "GUI\\Shell\\HardMode"
	},

	RelationshipHeartIcon =
	{
		TexturePath = "GUI\\Icons\\RelationshipHeart",
	},

	QuestProgressIncomplete =
	{
		TexturePath = "GUI\\Graybox\\RadioButton_Unselected",
	},

	QuestProgressComplete =
	{
		TexturePath = "GUI\\Graybox\\RadioButton_Selected",
	},

	Music =
	{
		TexturePath = "GUI\\Icons\\Music",
	},

	RunClearStar =
	{
		TexturePath = "GUI\\Icons\\RunClearStar",
	},

	PerfectDashIcon =
	{
		TexturePath = "GUI\\Screens\\MirrorBIcons\\Greater_Celerity",
		TextSymbolScale = 0.5,
	},

	Pause =
	{
		TexturePath = "GUI\\Icons\\Pause",
	},
}

-- Remembrances
RunIntroData =
{
	-- game intro
	{
		RequiredCompletedRuns = 0,
		Header = "Remembrance_Hades",
		FadeOutWait = 12.25,
		PauseMusic = true,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			-- Few tales are told of Hades, whose very name inspires fear and penitence, reminding us of the inevitable fate which we all share.
			{ Cue = "/VO/Scratch_0002_A", PreLineWait = 0.8, NoTarget = true },
			-- I, however, mean to tell you such a tale. Listen carefully...
			{ Cue = "/VO/Scratch_0002_B", PreLineWait = 0.72, NoTarget = true },
		},
	},
	-- misc. runs
	{
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredMinCompletedRuns = 1,
		Header = "Remembrance_Family",
		FadeOutWait = 6,
		RequiredTextLines = { "Flashback_Mother_01" },
		VoiceLines =
		{
			-- Family? Death is your only family. Death, and I. Best get accustomed to the both of us.
			{ Cue = "/VO/Hades_0062", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Death",
		FadeOutWait = 5,
		RequiredFalseTextLinesLastRun = { "Flashback_Mother_01" },
		RequiredPlayed = { "/VO/Hades_0062" },
		VoiceLines =
		{
			-- Death is inescapable. If you think otherwise... why, then, don't let me stop you.
			{ Cue = "/VO/Hades_0061", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Nobody",
		FadeOutWait = 6,
		VoiceLines =
		{
			-- Nobody gets out of here, boy, whether alive or dead. You think I jest? You think I haven't tried?!
			{ Cue = "/VO/Hades_0063", PreLineWait = 0.8, NoTarget = true, },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredTextLines = { "CerberusMiscMeeting01" },
		Header = "Remembrance_Dog",
		FadeOutWait = 6,
		VoiceLines =
		{
			-- That dog is not your plaything, boy! Cerberus defends our realm so that no-one gets in alive, or gets out either way.
			{ Cue = "/VO/Hades_0064", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		RequiredFalseTextLines = { "Ending01" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Weakling",
		FadeOutWait = 6,
		VoiceLines =
		{
			-- You are a weakling, boy! Disgraceful!! Now, strike again, and make it hurt, this time!
			{ Cue = "/VO/Hades_0065", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		RequiredFalseTextLines = { "Ending01" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Oaf",
		FadeOutWait = 6,
		VoiceLines =
		{
			-- Watch where you step, you oaf! My House is not a sty through which to track your filth!
			{ Cue = "/VO/Hades_0066", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Mortal",
		FadeOutWait = 4.2,
		VoiceLines =
		{
			-- A mortal's life is short, and fraught with pain; is that truly the life you yearn for, boy?
			{ Cue = "/VO/Hades_0067", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		RequiredFalseTextLines = { "Ending01" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Brat",
		FadeOutWait = 5,
		VoiceLines =
		{
			-- What have I wrought, that such a witless, careless brat would be my progeny?
			{ Cue = "/VO/Hades_0068", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Fear",
		FadeOutWait = 4.1,
		VoiceLines =
		{
			-- The fear of death keeps mortals well in check. You'd best learn to fear something yourself, you hear me, boy?
			{ Cue = "/VO/Hades_0069", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		RequiredFalseTextLines = { "Ending01" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredMinCompletedRuns = 10,
		Header = "Remembrance_Dare",
		FadeOutWait = 6,
		VoiceLines =
		{
			-- How dare you, boy! Learn well to shut that foolish mouth of yours, or I shall shut it for you!
			{ Cue = "/VO/Hades_0070", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Questions",
		FadeOutWait = 7,
		VoiceLines =
		{
			-- You have a tendency to ask too many questions, boy. Would that you had a tendency to wonder silently, instead.
			{ Cue = "/VO/Hades_0196", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		RequiredFalseTextLines = { "Ending01" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Olympus",
		FadeOutWait = 7.5,
		VoiceLines =
		{
			-- You're not to speak of that accursed Mount Olympus in this household, do you hear me? Nor shall you invoke the names of its inhabitants.
			{ Cue = "/VO/Hades_0197", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Curse",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- Say it: Blood and darkness. It's a curse, boy. Say it with me. Blood. And. Darkness. Each available in high abundance here.
			{ Cue = "/VO/Hades_0198", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredMinCompletedRuns = 10,
		RequiredTextLines = { "AchillesFirstMeeting" },
		Header = "Remembrance_Bearing",
		FadeOutWait = 7.5,
		VoiceLines =
		{
			-- Time you learned the bearing of the gods, and to assert yourself. For this I have employed the greatest of the Greeks, or what became of him.
			{ Cue = "/VO/Hades_0199", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Domain",
		FadeOutWait = 6,
		VoiceLines =
		{
			-- Where do you think you are? Who do you think you're talking to? Nobody gets out of my domain, whether alive or dead.
			{ Cue = "/VO/Hades_0200", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Zeus",
		RequiredTextLines = { "ZeusFirstPickUp" },
		FadeOutWait = 7,
		VoiceLines =
		{
			-- You wish to meet your uncle Zeus someday? Imagine me, with a luxurious white mane, without a modicum of self-control. That's your Zeus.
			{ Cue = "/VO/Hades_0201", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Place",
		FadeOutWait = 7,
		VoiceLines =
		{
			-- In my domain, you either find your place, or learn your place. There's work enough to go around, believe you me.
			{ Cue = "/VO/Hades_0202", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Belong",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- This is where you belong. You feel out of place? Where would you even go, what would you have me do? Your place is here.
			{ Cue = "/VO/Hades_0203", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredTextLines = { "MegaeraGift01" },
		RequiredKills = { Harpy = 5 },
		Header = "Remembrance_Fury",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- One thing the mortals have on us is that they quickly become men. This is the Fury, Megaera. She shall accelerate the process in your case.
			{ Cue = "/VO/Hades_0204", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredRoomLastRun = "B_Intro",
		Header = "Remembrance_Judged",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- The dead are judged and sent to Asphodel, Elysium, or Tartarus. We keep the process neat and orderly. Everyone gets in, no one gets out.
			{ Cue = "/VO/Hades_0205", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredTextLines = { "ThanatosFirstAppearance" },
		RequiredFalseTextLinesThisRun = { "AchillesAboutZagreus01" }, 
		RequiredFalseTextLinesLastRun = { "AchillesAboutZagreus01" }, 
		RequiredMinNPCInteractions = { NPC_Hypnos_01 = 1, NPC_Nyx_01 = 1 },
		Header = "Remembrance_You",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- Nyx is the Night herself; her twin sons, Sleep, and Death! But, you? I cannot think of anything, I fear! Except the god of talking back to me.
			{ Cue = "/VO/Hades_0629", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Here",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- Your place is here, and nowhere else. The same as it is mine. There's naught of any worth to see beyond this realm, besides.
			{ Cue = "/VO/Hades_0366", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredTextLines = { "PoseidonWrathIntro01", },
		Header = "Remembrance_Poseidon",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- Poseidon's an incomparable fool I am ashamed to call my brother. He can shake the earth up there all he pleases; he is unwelcome here.
			{ Cue = "/VO/Hades_0367", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredTextLines = { "HadesRunProgress03", },
		RequiredRoomLastRun = "C_Intro",
		Header = "Remembrance_Elysium",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- Elysium? It isn't for the good; it's for the great. Great kings or killers. Oft one and the same. They left their mark upon the world. Shall you?
			{ Cue = "/VO/Hades_0368", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Mistakes",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- For their mistakes in life, the wretched shades of Tartarus are bound to me in death, however hatefully. They answer to me; quite unlike you.
			{ Cue = "/VO/Hades_0369", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Explain",
		RequiredTrueFlags = { "ShrineUnlocked" },
		RequiredActiveShrinePointsMin = 1,
		RequiredMinRunsCleared = 1,
		FadeOutWait = 8,
		VoiceLines =
		{
			-- How many times must I explain this, boy? Each Pact of Punishment needs to be promptly signed, and sealed, and filed. Rather than pile up!
			{ Cue = "/VO/Hades_0370", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		RequiredFalseTextLines = { "Ending01" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Disrespect",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- What exactly is it, boy, that makes you feel entitled to show me such disrespect? You dare not say such things to Mother Nyx!
			{ Cue = "/VO/Hades_0371", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Asphodel",
		RequiredRoomLastRun = "B_Intro",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- Asphodel has flooded once again, with flame! Not quite the afterlife experience promised to the dead residing there, now, is it, boy?
			{ Cue = "/VO/Hades_0372", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Lack",
		RequiredAnyTextLines = { "ThanatosFirstAppearance" },
		RequiredMinNPCInteractions = { NPC_Hypnos_01 = 1 },
		FadeOutWait = 7,
		VoiceLines =
		{
			-- Upon my name, you lack the cheerfulness of Hypnos and the competence of Thanatos, but have more willfulness than both, combined!
			{ Cue = "/VO/Hades_0373", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Mess",
		FadeOutWait = 6,
		VoiceLines =
		{
			-- Sometimes I think this mess you call your chambers is one which you've cultivated with great pride, is that the way of it?
			{ Cue = "/VO/Hades_0374", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Stray",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- Do not stray far again into the pits of Tartarus, or become lost like all its residents. Content yourself to look upon it from afar.
			{ Cue = "/VO/Hades_0375", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Sulk",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- Sulk in your chambers all you like, for I care not! I have eternity to finish with this work, so your assistance is entirely unneeded.
			{ Cue = "/VO/Hades_0376", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Bleed",
		RequiredTextLines = { "Fury2MiscEncounter02" },
		FadeOutWait = 8,
		VoiceLines =
		{
			-- Why do you bleed like mortals do? An aberration, nothing more! And nothing to be proud of. I suggest you keep it to yourself.
			{ Cue = "/VO/Hades_0377", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Eyes",
		RequiredTextLines = { "Fury2MiscEncounter02" },
		FadeOutWait = 8,
		VoiceLines =
		{
			-- Don't you dare look at me like that, boy, with your mismatched eyes. You save it for yourself. You have a mirror in your chambers, don't you?
			{ Cue = "/VO/Hades_0378", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Disgusting",
		RequiredTextLines = { "Fury2MiscEncounter02" },
		FadeOutWait = 8,
		VoiceLines =
		{
			-- How suitably disgusting. Fling your blood at me like that again, boy, and I'll have you cast into the Styx, where you can drown in it.
			{ Cue = "/VO/Hades_0379", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Forbidden",
		RequiredRoomLastRun = "D_Intro",
		FadeOutWait = 7,
		VoiceLines =
		{
			-- The surface is off limits. And furthermore, you are forbidden from the Temple of Styx, until such time as you are fit to tend the situation there.
			{ Cue = "/VO/Hades_0467", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Breeze",
		RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
		RequiredRoomLastRun = "D_Intro",
		FadeOutWait = 7,
		VoiceLines =
		{
			-- You wish to feel the breeze against your skin? Perhaps the coolness of the seas? You shall writhe from such sensations, I assure you.
			{ Cue = "/VO/Hades_0468", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Immortal",
		RequiredAnyTextLines = { "LordHadesEncounter01", "LordHadesEncounter01_B" },
		FadeOutWait = 7,
		VoiceLines =
		{
			-- You are immortal, boy, but in a manner, you can die; as you now understand. A most unpleasant feeling, is it not?
		{ Cue = "/VO/Hades_0469", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Divide",
		RequiredRoomLastRun = "C_Intro",
		FadeOutWait = 7,
		VoiceLines =
		{
			-- The rivers flowing through this realm divide its regions suitably enough. And every shade knows better than to try and cross them!
		{ Cue = "/VO/Hades_0470", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Limits",
		RequiredTextLines = { "CerberusStyxMeeting01" },
		FadeOutWait = 7,
		VoiceLines =
		{
			-- Why are some chambers in my House off limits? Someone deserving access would not ask. You can't always go where you please.
			{ Cue = "/VO/Hades_0471", PreLineWait = 0.8, NoTarget = true },
		},
	},

	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredWeaponsUnlocked = { "SwordWeapon", "SpearWeapon", "ShieldWeapon", "BowWeapon", "GunWeapon", "FistWeapon", },
		Header = "Remembrance_Arms",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- The Infernal Arms are sealed away for a reason, boy! Your curiosity exceeds your common sense, but heed my words, you stay away from those accursed things!
			{ Cue = "/VO/Hades_0832", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredSeenRooms = { "C_Boss01" },
		Header = "Remembrance_Heroes",
		FadeOutWait = 10,
		VoiceLines =
		{
			-- Heroes? Mere mortals, same as all the rest. Someday you shall visit Elysium and meet some of these heroes, and discover that they are quite different than the songs suggest.
			{ Cue = "/VO/Hades_0833", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredTextLines = { "PoseidonFirstPickUp" },
		RequiredCosmetics = { "FishingUnlockItem" },
		Header = "Remembrance_Rivers",
		FadeOutWait = 10,
		VoiceLines =
		{
			-- How dare you to insinuate Poseidon has the slightest jurisdiction, here! Once waters from the surface flow beneath the earth, they become mine. Each of the rivers, they are mine, not his!
			{ Cue = "/VO/Hades_0834", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredTextLines = { "CharonGift01" },
		RequiredSeenRooms = { "D_Hub" },
		Header = "Remembrance_Boatman",
		FadeOutWait = 8,
		VoiceLines =
		{
			-- You would have better conversation with your chamber-walls than with the boatman Charon, boy. Not all those of the Underworld are prone to ceaseless chatter quite like you.
			{ Cue = "/VO/Hades_0835", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredSeenRooms = { "D_Hub" },
		Header = "Remembrance_Anger",
		FadeOutWait = 9,
		VoiceLines =
		{
			-- Now, fling the blasted thing again, I said! And put your anger into it, this time, like so. Or if you've not anger enough for it yet, you'll learn, I promise you.
			{ Cue = "/VO/Hades_0836", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredTextLines = { "LordHadesHasGuanYuAspect01" },
		Header = "Remembrance_Spear",
		FadeOutWait = 9,
		VoiceLines =
		{
			-- Never lay hands upon Gigaros, boy, ever again. The power in that spear could tear you to pieces finer than the ones to which some of your ancestors were once reduced.
			{ Cue = "/VO/Hades_0837", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredAccumulatedMetaPoints = 10000,
		Header = "Remembrance_Darkness",
		FadeOutWait = 11,
		VoiceLines =
		{
			-- All of this realm are born of darkness, boy. It's part of everything you'll ever see. The mortals on the surface, they all fear it, foolish as they are. Unable to even see its power.
			{ Cue = "/VO/Hades_0838", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		RequiredLifetimeResourcesSpentMin = { Gems = 2000 },
		Header = "Remembrance_Gemstones",
		FadeOutWait = 10,
		VoiceLines =
		{
			-- These gemstones that you mock, boy, are a symbol of the power of this realm. To you they're merely trinkets, but to mortals, gemstones hold more value than their very lives.
			{ Cue = "/VO/Hades_0839", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Vermin",
		RequiredKills = { SatyrRanged = 2, RatThug = 2, Crawler = 2 },
		FadeOutWait = 9.3,
		VoiceLines =
		{
			-- Another vermin outbreak near the surface, then. Would that I had someone dependable to deal with it. Where are those blasted satyrs coming from, and to what end? The vile things.
			{ Cue = "/VO/Hades_0840", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Obscurity",
		RequiredMinRunsCleared = 1,
		FadeOutWait = 10.3,
		VoiceLines =
		{
			-- You seek such fame as your great relatives upon their mountaintop? Seek to be valuable, not to be known. Obscurity is not what makes you weak. Worship from mortals is a nuisance, not a boon.
			{ Cue = "/VO/Hades_0841", PreLineWait = 0.8, NoTarget = true },
		},
	},
	-- post ending
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Sturdy",
		RequiredTextLines = { "Ending01" },
		FadeOutWait = 6.6,
		VoiceLines =
		{
			-- You need to learn to hold a spear, observe! A sturdy grip is necessary, here and here. Though, we must find for you an instructor with more time to spare.
			{ Cue = "/VO/Hades_0950", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Differences",
		RequiredTextLines = { "Ending01" },
		FadeOutWait = 6.3,
		VoiceLines =
		{
			-- You must accept that you are not like all the others here. Your differences do not make you deficient. They can make you strong. It's up to you.
			{ Cue = "/VO/Hades_0951", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Time",
		RequiredTextLines = { "Ending01" },
		FadeOutWait = 7.6,
		VoiceLines =
		{
			-- I have no idle time to spare you, boy! Have you observed the parchmentwork upon my desk? Go play with Thanatos, or Hypnos, or the dog. I need to finish this!
			{ Cue = "/VO/Hades_0952", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Titans",
		RequiredTextLines = { "Ending01" },
		FadeOutWait = 7.9,
		VoiceLines =
		{
			-- Your grandparents? The Titans, they were called. Long since passed from this world, boy. You have my assurance, however, that you did not miss much, in having never met.
			{ Cue = "/VO/Hades_0953", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Boundaries",
		RequiredTextLines = { "Ending01" },
		FadeOutWait = 8.9,
		VoiceLines =
		{
			-- Keep to yourself, then! Our House is not so great in size, thus boundaries must be set. I shall refrain from entering your chambers, as you shall never again try to enter mine.
			{ Cue = "/VO/Hades_0954", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Learn",
		RequiredTextLines = { "Ending01" },
		FadeOutWait = 7.9,
		VoiceLines =
		{
			-- Waste not your time, though it is limitless. Busy yourself in doing things of use. Learn. Learn how to learn. I cannot teach you everything myself.
			{ Cue = "/VO/Hades_0955", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Sigil",
		RequiredTextLines = { "Ending01", "Inspect_DeathAreaOffice_Teleporter_01" },
		FadeOutWait = 6.9,
		VoiceLines =
		{
			-- The Eldest Sigil shall never work for you, boy. Only a privileged few have unconstrained authority to traverse this realm, and you are not among them, I'm afraid.
			{ Cue = "/VO/Hades_0956", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Shouting",
		RequiredTextLines = { "Ending01" },
		FadeOutWait = 6.8,
		VoiceLines =
		{
			-- You call this shouting?! This is not shouting, boy. This is merely having certain expectations, which you have not met. Now, try once again.
			{ Cue = "/VO/Hades_0957", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Standard",
		RequiredTextLines = { "Ending01" },
		FadeOutWait = 6.5,
		VoiceLines =
		{
			-- Look to me for clear instruction, boy! Not for the embodiment of the standard to which you are held. Set your aim higher than to be like me.
			{ Cue = "/VO/Hades_0958", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Surface",
		RequiredTextLines = { "Ending01" },
		FadeOutWait = 7.5,
		VoiceLines =
		{
			-- Forget about the surface, boy! You are not missing much. Here we have warmth, and wealth. Stability! Up there? Nothing of the sort.
			{ Cue = "/VO/Hades_0959", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Failure",
		RequiredTextLines = { "Ending01" },
		FadeOutWait = 7.8,
		VoiceLines =
		{
			-- Speak not to me of failure! Failure is the greatest instructor of all. Your existence is a sequence of mistakes; avoid making the same one twice.
			{ Cue = "/VO/Hades_0960", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Nyx",
		RequiredTextLines = { "Ending01" },
		FadeOutWait = 6.7,
		VoiceLines =
		{
			-- Ask Nyx about such things, do not ask me! She is the one born to this realm. I am a foreigner. Moved here to take this job, can you believe it, boy?
			{ Cue = "/VO/Hades_0961", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Mortals",
		RequiredTextLines = { "Ending01" },
		FadeOutWait = 7.3,
		VoiceLines =
		{
			-- Mortals believe that there is no return from here. They are correct! And we all must do our part to keep it that way. We have a certain reputation to uphold. 
			{ Cue = "/VO/Hades_0962", PreLineWait = 0.8, NoTarget = true },
		},
	},
	{
		RequiredPlayed = { "/VO/Hades_0062" },
		BackgroundAnimation = "RemBGHadesIntro",
		Header = "Remembrance_Pride",
		RequiredTextLines = { "Ending01" },
		FadeOutWait = 9.8,
		VoiceLines =
		{
			-- Why am I never proud of you? Don't take it personally, boy. I'm never proud of anything. Pride is perhaps our family's worst trait. See how many mortals are with us, because of it? 
			{ Cue = "/VO/Hades_0963", PreLineWait = 0.8, NoTarget = true },
		},
	},

}

ConstantsData.DefaultUseText = "InGameUI_Use"

-- Multilock system to see if any menus are open
ActiveScreens =
{
}

CodexUI =
{
	SpacerX = 68,
	BaseIconOffsetX = 60,
	MaxEntries = 11,
	MaxChapters = 5,
	EntryX = 510,
	StartingEntryY = 210,
	EntryYSpacer = 50,
	EntryY = 120,
	ArrowLeftSpacerX = 120,
	ArrowRightSpacerX = 240,
}

CombatUI =
{
	HiddenBySpeechPanel = false,
	AutoHideEnabled = true,
	HideDelay = 16,
	HealthBarFalloffDelay = 0.25,
	SmallHealthBarScale = 0.6,
	MediumHealthBarScale = 1.0,
	MediumLargeHealthBarScale = 1.5,
	LargeHealthBarScale = 2.0,
	ExtraLargeHealthBarScale = 2.5,
	SmallHeathBarThreshold = 80,
	MediumHealthBarThreshold = 250,
	MediumLargeHealthBarThreshold = 320,
	DeathHoldDuration = 0.0,
	PoisonPipSpacing= 20,
	PoisonPipMaxWidth= 75,
	AmmoPipSpacing= 22,
	AmmoPipMaxWidth= 66,
	PoisonPipBossSpacing= 30,
	FadeDistance =
	{
		-- left ui
		Shadow = 20,
		Trait = 0,
		Health = 30,
		Super = 20,
		Ammo = 20,
		-- right ui
		ShrinePoint = 50,
		MetaPoint = 40,
		Money = 30,
		GiftPoint = 20,
		LockKey = 10,
	},
	TraitUIStart = 50,
	FadeDuration = 0.5,
	TraitFadeDuration = 0.15,
	FadeInDuration = 0.5,
	HideThreadName = "CombatUIHide",
	Hiding = false,
	Hide = {},
	DamageTextHoldTime = 0.25,
	DamageTweenSpeed = 0.5,				-- Min amount to increment towards the final number
	DamageTextCoalesceAll = false,
}

ScreenCenterX = 1920/2
ScreenCenterY = 1080/2

ScreenWidth = 1920
ScreenHeight = 1080

UIData =
{
	BoonMenuId = "BoonMenu",
	Constants =
	{
		PENDING_REVEAL = "pending",
		VISIBLE = "visible",
	},
	AwardMenu =
	{
		CurrentPage = 0,
		ItemsPerPage = 4,
		BaseIconScale = 0.5,
		HoverIconScale = 0.6,
		AvailableTraits = {},
		NormalSelectionFrame = "AwardMenuItemEquipped",
		LegendarySelectionFrame = "LegendaryMenuItemEquipped",
	},
	ZeroMouseFlags =
	{

	},
	BlockTimerFlags =
	{

	},
	LastSeenLives = 0,
	LastSeenSkellyLives = 0,
	UsePrompt =
	{
		X = 960,
		Y = 1090,
		AttractAnim = "InteractBacking",
		AttractAnimOff = "InteractBackingFade",
		--AttractFlash = { Speed = 1.25, MinFraction = 0, MaxFraction = 0.2, Color = Color.White },
		TextFormat =
		{
			Justification = "CENTER",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 5},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = Color.White,
			Font = "AlegreyaSansSCExtraBold",
			FontSize = 30,
			TextSymbolScale = 0.8,
			LangCnScaleModifier = 0.85,
			LangKoScaleModifier = 0.85,
			LangJaScaleModifier = 0.85,
		}
	},

	CurrentRunDepth =
	{
		X = 1740,
		Y = 30,
		TextFormat =
		{
			Justification = "Right",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 5},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = {220, 220, 220, 255},
			Font = "AlegreyaSansSCBold",
			FontSize = 20,
			TextSymbolScale = 0.8,
		}
	}

}

ShopUI =
{
	ShopItemStartX = ScreenCenterX,
	ShopItemSpacerX = 820,
	ShopItemStartY = 340,
	ShopItemSpacerY = 220,
}

LevelUpUI =
{
	RightArrowOffsetX = 235,
	RightArrowOffsetY = -28,
	LeftArrowOffsetX = 188,
	LeftArrowOffsetY = -28,
	TextInfoBaseX = -230,
	TooltipInfoBaseX = -510,
	TooltipOffset = 640,
	MetaUpgradeSpacer = 45,
}

HealthUI =
{
	LowHealthThreshold = 0.35,
	LowHealthMaximum = 50, -- if you have a lot of max health, its only considered low heatlh below this absolute value
	LowHealthMinimum = 10, -- if you have a very low max health, any health below this absolute value is considered low health
	ShowHealingText = true,
	MajorHitThreshold = 0.1,
}

SuperUI =
{
	-- The threshold that would equate to a x scale of 1 for pips
	BaseMoveThreshold = 20,
	PipXStart = 60,
	PipXWidth = 60,
	PipY = ScreenHeight - 25,
	HasHinted = false,
	HintCooldown = 45,
	ExHintCooldown = 25,
	ExpiringShortCount = 1,
	ExpiringSoundCount = 3,
	ExpiringSoundInterval = 0.6,
	PostEncounterDrainRates =
	{
		{
			Rate = 30,
			Threshold = 0,
		},
		{
			Rate = 40,
			Threshold = 0.6,
		},
		{
			Rate = 60,
			Threshold = 1.2,
		},
	}
}

TraitUI =
{
	RecentTraitSize = 5,
	StartX = 40,
	StartY = ScreenCenterY - 7,
	SpacerX = 0,
	OddSpacerX = 35,
	IconStartY = ScreenCenterY - 240,
	IconStartX = 27 + 64 - 40,
	SpacerY = 93.5,
	SpacerX = 128,
 	PipOffsetX = 12,
	PipOffsetY = 12,
	NEW_TRAIT_TOKEN = "NEW",
}

ConsumableUI =
{
	StartY = ScreenHeight - 30,
	SpacerY = 50,
	StartX = ScreenWidth - 30,
	SpacerX = 0,
	FloatingCountSpacerX = -120
}

AmmoUI =
{
	StartX = -20,
	StartY = 60,
	HideDelay = 3,
}

GunUI =
{
	StartX = 630,
	StartY = 1018,
	HideDelay = 3,
	ReloadingOffsetX = 194,
	ReloadingOffsetY = -2,
}

MoneyUI =
{
	HideDelay = 2.2,
	FadeDuration = 0.4,
	LastValue = 0,
	Floating = 0,
	RunningThreads = 0,
	DigitSpacer = -25,
	StartSpacer = -60
}

ScreenData =
{
	TraitTrayScreen =
	{
		Components = {},
		Icons = {},
		Frames = {},
		PrimaryFrames = {},
		Columns = {},
		Pins = {},
		PinOffsetX = 254,
		PinOffsetY = 32,
		PinSpacing = 168,
		PinCollapseSpeed = 1000,
		MaxPins = 5,
	},
}