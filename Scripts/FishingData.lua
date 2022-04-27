GlobalVoiceLines = GlobalVoiceLines or {}
-- Chaos
GlobalVoiceLines.ChaosComplimentVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.89,
		NoTarget = true,
		RequiredTextLines = { "ChaosFirstPickUp" },
		SuccessiveChanceToPlayAll = 0.5,
		Source = { SubtitleColor = Color.ChaosVoice },
		RequiredBiome = "Secrets",

		-- A good procurement.
		{ Cue = "/VO/Chaos_0241", },
		-- A perfect specimen.
		{ Cue = "/VO/Chaos_0242", },
		-- Keep it, Son of Hades.
		{ Cue = "/VO/Chaos_0243", },
		-- Specimen received.
		{ Cue = "/VO/Chaos_0244", },
		-- Specimen procured.
		{ Cue = "/VO/Chaos_0245", },
		-- You caught a specimen.
		{ Cue = "/VO/Chaos_0246", },
		-- You have outsmarted it.
		{ Cue = "/VO/Chaos_0247", },
		-- A fine display.
		{ Cue = "/VO/Chaos_0248", },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.89,
		NoTarget = true,
		RequiredTextLines = { "ChaosFirstPickUp" },
		Source = { SubtitleColor = Color.ChaosVoice },
		RequiredBiome = "Secrets",

		-- That was commendable.
		{ Cue = "/VO/Chaos_0148", },
		-- A praiseworthy attempt.
		{ Cue = "/VO/Chaos_0149", },
		-- You have provided me amusement.
		{ Cue = "/VO/Chaos_0150", },
		-- You are quite different, Son of Hades.
		{ Cue = "/VO/Chaos_0151", },
		-- Amusingly accomplished.
		{ Cue = "/VO/Chaos_0152", },
		-- That was enjoyable I have to say.
		{ Cue = "/VO/Chaos_0153", },
		-- Most interesting.
		{ Cue = "/VO/Chaos_0096", },
		-- How unexpected.
		{ Cue = "/VO/Chaos_0097", },
	}
}
GlobalVoiceLines.PatroclusFishCaughtVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.8,
	RequiredTextLines = { "PatroclusFirstMeeting" },
	ObjectType = "NPC_Patroclus_01",
	RequiredRoom = "C_Story01",
	Actor = "StrangerOcclusionP",

	-- You caught one there, did you?
	{ Cue = "/VO/Patroclus_0243" },
	-- Did you just catch another?
	{ Cue = "/VO/Patroclus_0244" },
	-- Good fishing, stranger.
	{ Cue = "/VO/Patroclus_0245" },
	-- You showed that fish all right.
	{ Cue = "/VO/Patroclus_0246" },
	-- Very clever, stranger.
	{ Cue = "/VO/Patroclus_0247" },
	-- Another catch.
	{ Cue = "/VO/Patroclus_0248" },
	-- Another catch, huh.
	{ Cue = "/VO/Patroclus_0249" },
	-- Please leave me be.
	{ Cue = "/VO/Patroclus_0250", RequiredFalseTextLines = { "MyrmidonReunionQuestComplete" } },
	-- A noble victory.
	{ Cue = "/VO/Patroclus_0251" },
	-- Skilfully done.
	{ Cue = "/VO/Patroclus_0252" },
	-- What good's a fish down here?
	{ Cue = "/VO/Patroclus_0253" },
	-- Fool of a fish.
	{ Cue = "/VO/Patroclus_0254" },
	-- It should have been more careful.
	{ Cue = "/VO/Patroclus_0255" },
	-- At last, the rivers are safe.
	{ Cue = "/VO/Patroclus_0256" },
}

GlobalVoiceLines.PersephoneFishCaughtVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.8,
	RequiredTextLines = { "PersephoneFirstMeeting" },
	ObjectType = "NPC_Persephone_01",
	RequiredRoom = "E_Story01",
	Actor = "StrangerOcclusionP",
	PreLineAnim = "PersephoneGarden_Greeting",
	SubtitleMinDistance = 1200,

	-- Good catch!
	{ Cue = "/VO/Persephone_0284" },
	-- Oh, good catch!
	{ Cue = "/VO/Persephone_0285" },
	-- Well caught.
	{ Cue = "/VO/Persephone_0286" },
	-- Nicely done!
	{ Cue = "/VO/Persephone_0287" },
	-- Ooh look at that!
	{ Cue = "/VO/Persephone_0288" },
	-- Got that one all right!
	{ Cue = "/VO/Persephone_0289" },
}

GlobalVoiceLines.FishCaughtVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.35,
	Queue = "Interrupt",

	-- Got you!
	{ Cue = "/VO/ZagreusField_3044" },
	-- You're mine.
	{ Cue = "/VO/ZagreusField_3045" },
	-- Come on up!
	{ Cue = "/VO/ZagreusField_3046" },
	-- Right there!
	{ Cue = "/VO/ZagreusField_3047" },
	-- That's a bite!
	{ Cue = "/VO/ZagreusField_3048" },
	-- Got a bite!
	{ Cue = "/VO/ZagreusField_3049" },
	-- Now!
	{ Cue = "/VO/ZagreusField_3050" },
	-- Mine!
	{ Cue = "/VO/ZagreusField_3051" },
	-- There!
	{ Cue = "/VO/ZagreusField_3052" },
	-- Fish!
	{ Cue = "/VO/ZagreusField_3053" },
	-- Bite this!
	{ Cue = "/VO/ZagreusField_3054" },
	-- Come on out!
	{ Cue = "/VO/ZagreusField_3055" },
	-- Got it!
	{ Cue = "/VO/ZagreusField_3056" },
	-- Think I got one!
	{ Cue = "/VO/ZagreusField_3057" },
	-- I got one!
	{ Cue = "/VO/ZagreusField_3058" },
}
GlobalVoiceLines.FishIdentifiedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 1.0,
		Cooldowns =
		{
			{ Name = "ZagreusGlobalFishCaughtVoiceLinesPlayed", Time = 30 },
		},

		-- Huzzah!
		{ Cue = "/VO/ZagreusField_3109" },
		-- Victory!
		{ Cue = "/VO/ZagreusField_3110" },
		-- A sea-creature!
		{ Cue = "/VO/ZagreusField_3111" },
		-- I caught one!
		{ Cue = "/VO/ZagreusField_3112" },
		-- A fine catch!
		{ Cue = "/VO/ZagreusField_3113" },
		-- That's one more fish for me!
		{ Cue = "/VO/ZagreusField_3114" },
		-- I am victorious.
		{ Cue = "/VO/ZagreusField_3115" },
		-- I win this round, Fish.
		{ Cue = "/VO/ZagreusField_3116" },
	},
}

FishingData =
{
	NumFakeDunks = { Min = 0, Max = 3 },
	FakeDunkInterval = { Min = 2, Max = 5 },
	--WaitInterval = { Min = 1, Max = 5 },
	WarnInterval = { Min = 1, Max = 2 },
	GoodInterval = 0.34,
	PerfectInterval = 0.34,
	WayLateInterval = 1,
	GiveUpInterval = 3,

	BiomeFish =
	{
		Defaults =
		{
			Good =
			{
				{ Name = "Fish_Tartarus_Common_01" },
				{ Weight = 0.05, Name = "Fish_Tartarus_Rare_01" },
			},
			Perfect =
			{
				{ Name = "Fish_Tartarus_Rare_01" },
				{ Weight = 0.05, Name = "Fish_Tartarus_Legendary_01" },
			},
		},
		Tartarus =
		{
			Good =
			{
				{ Name = "Fish_Tartarus_Common_01" },
				{ Weight = 0.05, Name = "Fish_Tartarus_Rare_01" },
			},
			Perfect =
			{
				{ Name = "Fish_Tartarus_Rare_01" },
				{ Weight = 0.05, Name = "Fish_Tartarus_Legendary_01" },
			},
		},
		Asphodel =
		{
			Good =
			{
				{ Name = "Fish_Asphodel_Common_01" },
				{ Weight = 0.05, Name = "Fish_Asphodel_Rare_01" },
			},
			Perfect =
			{
				{ Name = "Fish_Asphodel_Rare_01" },
				{ Weight = 0.05, Name = "Fish_Asphodel_Legendary_01" },
			},
		},
		Elysium =
		{
			Good =
			{
				{ Name = "Fish_Elysium_Common_01" },
				{ Weight = 0.05, Name = "Fish_Elysium_Rare_01" },
			},
			Perfect =
			{
				{ Name = "Fish_Elysium_Rare_01" },
				{ Weight = 0.05, Name = "Fish_Elysium_Legendary_01" },
			},
		},
		Styx =
		{
			Good =
			{
				{ Name = "Fish_Styx_Common_01" },
				{ Weight = 0.05, Name = "Fish_Styx_Rare_01" },
			},
			Perfect =
			{
				{ Name = "Fish_Styx_Rare_01" },
				{ Weight = 0.05, Name = "Fish_Styx_Legendary_01" },
			},
		},
		Secrets =
		{
			Good =
			{
				{ Name = "Fish_Chaos_Common_01" },
				{ Weight = 0.05, Name = "Fish_Chaos_Rare_01" },
			},
			Perfect =
			{
				{ Name = "Fish_Chaos_Rare_01" },
				{ Weight = 0.05, Name = "Fish_Chaos_Legendary_01" },
			},
		},
		Surface =
		{
			Good =
			{
				{ Name = "Fish_Surface_Common_01" },
				{ Weight = 0.05, Name = "Fish_Surface_Rare_01" },
			},
			Perfect =
			{
				{ Name = "Fish_Surface_Rare_01" },
				{ Weight = 0.05, Name = "Fish_Surface_Legendary_01" },
			},
		},
	},

	FishValues =
	{
		DefaultCommon =
		{
			Award = {
				{ Gems = 5 },
				-- { MetaPoints = 10 },
				-- { GiftPoints = 1 },
			},
			FishCaughtVoiceLines =
			{
				[1] = GlobalVoiceLines.FishCaughtVoiceLines,
			},
			FishIdentifiedVoiceLines =
			{
				[1] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},

		DefaultRare =
		{
			Award = {
				{ Gems = 10 },
				-- { MetaPoints = 20 },
				-- { GiftPoints = 1 },
			},
			FishCaughtVoiceLines =
			{
				[1] = GlobalVoiceLines.FishCaughtVoiceLines
			},
			FishIdentifiedVoiceLines =
			{
				[1] = GlobalVoiceLines.FishIdentifiedVoiceLines
			},
		},

		DefaultLegendary =
		{
			Award = {
				{ Gems = 100 },
				-- { MetaPoints = 150 },
				-- { SuperGems = 1 },
				-- { SuperGiftPoints = 1 },
			},
			FishCaughtVoiceLines =
			{
				[1] = GlobalVoiceLines.FishCaughtVoiceLines
			},
			FishIdentifiedVoiceLines =
			{
				[1] = GlobalVoiceLines.FishIdentifiedVoiceLines
			},
		},

		Fish_Tartarus_Common_01 =
		{
			InheritFrom = { "DefaultCommon" },
			Award = {
				{ Gems = 5 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- I caught a Hellfish!
					{ Cue = "/VO/ZagreusField_3059" },
					-- Another Hellfish.
					{ Cue = "/VO/ZagreusField_3060", RequiredPlayed = { "/VO/ZagreusField_3059" } },
					-- Hellfish.
					{ Cue = "/VO/ZagreusField_3061", RequiredPlayed = { "/VO/ZagreusField_3059" } },
					-- A Hellfish!
					{ Cue = "/VO/ZagreusField_3062", RequiredPlayed = { "/VO/ZagreusField_3059" } },
					-- What do you know, a Hellfish.
					{ Cue = "/VO/ZagreusField_3063", RequiredPlayed = { "/VO/ZagreusField_3059" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		Fish_Tartarus_Rare_01 =
		{
			InheritFrom = { "DefaultRare" },
			Award = {
				{ Gems = 20 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- I caught a Knucklehead!
					{ Cue = "/VO/ZagreusField_3064" },
					-- Another Knucklehead.
					{ Cue = "/VO/ZagreusField_3065", RequiredPlayed = { "/VO/ZagreusField_3064" } },
					-- Looks like a Knucklehead.
					{ Cue = "/VO/ZagreusField_3066", RequiredPlayed = { "/VO/ZagreusField_3064" } },
					-- A Knucklehead!
					{ Cue = "/VO/ZagreusField_3067", RequiredPlayed = { "/VO/ZagreusField_3064" } },
					-- Got me a Knucklehead.
					{ Cue = "/VO/ZagreusField_3068", RequiredPlayed = { "/VO/ZagreusField_3064" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		Fish_Tartarus_Legendary_01 =
		{
			InheritFrom = { "DefaultLegendary" },
			Award = {
				{ Gems = 30 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- Wow, a Scyllascion!
					{ Cue = "/VO/ZagreusField_3069" },
					-- I caught a Scyllascion!
					{ Cue = "/VO/ZagreusField_3070", RequiredPlayed = { "/VO/ZagreusField_3069" } },
					-- Another Scyllascion?
					{ Cue = "/VO/ZagreusField_3071", RequiredPlayed = { "/VO/ZagreusField_3069" } },
					-- A Scyllascion!
					{ Cue = "/VO/ZagreusField_3072", RequiredPlayed = { "/VO/ZagreusField_3069" } },
					-- It's a Scyllascion!
					{ Cue = "/VO/ZagreusField_3073", RequiredPlayed = { "/VO/ZagreusField_3069" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		Fish_Asphodel_Common_01 =
		{
			InheritFrom = { "DefaultCommon" },
			Award = {
				{ LockKeys = 1 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- Caught a Slavug!
					{ Cue = "/VO/ZagreusField_3074" },
					-- Another Slavug.
					{ Cue = "/VO/ZagreusField_3075", RequiredPlayed = { "/VO/ZagreusField_3074" } },
					-- Slavug.
					{ Cue = "/VO/ZagreusField_3076", RequiredPlayed = { "/VO/ZagreusField_3074" } },
					-- A Slavug!
					{ Cue = "/VO/ZagreusField_3077", RequiredPlayed = { "/VO/ZagreusField_3074" } },
					-- Slavug, go figure.
					{ Cue = "/VO/ZagreusField_3078", RequiredPlayed = { "/VO/ZagreusField_3074" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		Fish_Asphodel_Rare_01 =
		{
			InheritFrom = { "DefaultRare" },
			Award = {
				{ LockKeys = 3 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- Caught a Chrustacean!
					{ Cue = "/VO/ZagreusField_3079" },
					-- Another Chrustacean.
					{ Cue = "/VO/ZagreusField_3080", RequiredPlayed = { "/VO/ZagreusField_3079" } },
					-- Just a Chrustacean.
					{ Cue = "/VO/ZagreusField_3081", RequiredPlayed = { "/VO/ZagreusField_3079" } },
					-- A Chrustacean.
					{ Cue = "/VO/ZagreusField_3082", RequiredPlayed = { "/VO/ZagreusField_3079" } },
					-- It's a Chrustacean.
					{ Cue = "/VO/ZagreusField_3083", RequiredPlayed = { "/VO/ZagreusField_3079" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		Fish_Asphodel_Legendary_01 =
		{
			InheritFrom = { "DefaultLegendary" },
			Award = {
				{ LockKeys = 5 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- Flaaaameeaaaterrrr!
					{ Cue = "/VO/ZagreusField_3186", ChanceToPlay = 0.0075, PlayOnce = true, RequiredPlayed = { "/VO/ZagreusField_3181" } },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- I caught a Flameater...?
					{ Cue = "/VO/ZagreusField_3181" },
					-- It's a Flameater!
					{ Cue = "/VO/ZagreusField_3182", RequiredPlayed = { "/VO/ZagreusField_3181" } },
					-- Whoa a Flameater!
					{ Cue = "/VO/ZagreusField_3183", RequiredPlayed = { "/VO/ZagreusField_3181" } },
					-- Another Flameater?
					{ Cue = "/VO/ZagreusField_3184", RequiredPlayed = { "/VO/ZagreusField_3181" } },
					-- Hey a Flameater!
					{ Cue = "/VO/ZagreusField_3185", RequiredPlayed = { "/VO/ZagreusField_3181" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},

		},
		Fish_Elysium_Common_01 =
		{
			InheritFrom = { "DefaultCommon" },
			Award = {
				{ GiftPoints = 1 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- I caught a Chlam!
					{ Cue = "/VO/ZagreusField_3187" },
					-- Got a Chlam.
					{ Cue = "/VO/ZagreusField_3188", RequiredPlayed = { "/VO/ZagreusField_3187" } },
					-- Another Chlam.
					{ Cue = "/VO/ZagreusField_3189", RequiredPlayed = { "/VO/ZagreusField_3187" } },
					-- Looks like a Chlam.
					{ Cue = "/VO/ZagreusField_3190", RequiredPlayed = { "/VO/ZagreusField_3187" } },
					-- It's a Chlam.
					{ Cue = "/VO/ZagreusField_3191", RequiredPlayed = { "/VO/ZagreusField_3187" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
				[3] = GlobalVoiceLines.PatroclusFishCaughtVoiceLines,
			},

		},
		Fish_Elysium_Rare_01 =
		{
			InheritFrom = { "DefaultRare" },
			Award = {
				{ GiftPoints = 2 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- I caught a Charp!
					{ Cue = "/VO/ZagreusField_3084" },
					-- Another Charp.
					{ Cue = "/VO/ZagreusField_3085", RequiredPlayed = { "/VO/ZagreusField_3084" } },
					-- Caught me a Charp.
					{ Cue = "/VO/ZagreusField_3086", RequiredPlayed = { "/VO/ZagreusField_3084" } },
					-- It's a Charp.
					{ Cue = "/VO/ZagreusField_3087", RequiredPlayed = { "/VO/ZagreusField_3084" } },
					-- That's a Charp all right.
					{ Cue = "/VO/ZagreusField_3088", RequiredPlayed = { "/VO/ZagreusField_3084" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
				[3] = GlobalVoiceLines.PatroclusFishCaughtVoiceLines,
			},
		},
		Fish_Elysium_Legendary_01 =
		{
			InheritFrom = { "DefaultLegendary" },
			Award = {
				{ GiftPoints = 3 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- I caught a Seamare!
					{ Cue = "/VO/ZagreusField_3089" },
					-- Another Seamare?
					{ Cue = "/VO/ZagreusField_3090", RequiredPlayed = { "/VO/ZagreusField_3089" } },
					-- A beautiful Seamare!
					{ Cue = "/VO/ZagreusField_3091", RequiredPlayed = { "/VO/ZagreusField_3089" } },
					-- It's a Seamare!
					{ Cue = "/VO/ZagreusField_3092", RequiredPlayed = { "/VO/ZagreusField_3089" } },
					-- Ooh a Seamare!
					{ Cue = "/VO/ZagreusField_3093", RequiredPlayed = { "/VO/ZagreusField_3089" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
				[3] = GlobalVoiceLines.PatroclusFishCaughtVoiceLines,
			},
		},
		Fish_Styx_Common_01 =
		{
			InheritFrom = { "DefaultCommon" },
			Award = {
				{ Gems = 20 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- I caught a Gupp...!
					{ Cue = "/VO/ZagreusField_3094" },
					-- Another Gupp, huh.
					{ Cue = "/VO/ZagreusField_3095", RequiredPlayed = { "/VO/ZagreusField_3094" } },
					-- It's a Gupp.
					{ Cue = "/VO/ZagreusField_3096", RequiredPlayed = { "/VO/ZagreusField_3094" } },
					-- Just a Gupp.
					{ Cue = "/VO/ZagreusField_3097", RequiredPlayed = { "/VO/ZagreusField_3094" } },
					-- Looks like a Gupp.
					{ Cue = "/VO/ZagreusField_3098", RequiredPlayed = { "/VO/ZagreusField_3094" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		Fish_Styx_Rare_01 =
		{
			InheritFrom = { "DefaultRare" },
			Award = {
				{ Gems = 40 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- I caught a Scuffer!
					{ Cue = "/VO/ZagreusField_3099" },
					-- It's a Scuffer all right.
					{ Cue = "/VO/ZagreusField_3100", RequiredPlayed = { "/VO/ZagreusField_3099" } },
					-- Another Scuffer.
					{ Cue = "/VO/ZagreusField_3101", RequiredPlayed = { "/VO/ZagreusField_3099" } },
					-- That is a Scuffer.
					{ Cue = "/VO/ZagreusField_3102", RequiredPlayed = { "/VO/ZagreusField_3099" } },
					-- A Scuffer.
					{ Cue = "/VO/ZagreusField_3103", RequiredPlayed = { "/VO/ZagreusField_3099" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		Fish_Styx_Legendary_01 =
		{
			InheritFrom = { "DefaultLegendary" },
			Award = {
				{ Gems = 150 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- I caught a Stonewhal!
					{ Cue = "/VO/ZagreusField_3104" },
					-- Another Stonewhal?
					{ Cue = "/VO/ZagreusField_3105", RequiredPlayed = { "/VO/ZagreusField_3104" } },
					-- It's a Stonewhal!
					{ Cue = "/VO/ZagreusField_3106", RequiredPlayed = { "/VO/ZagreusField_3104" } },
					-- Now that's a Stonewhal!
					{ Cue = "/VO/ZagreusField_3107", RequiredPlayed = { "/VO/ZagreusField_3104" } },
					-- A Stonewhal!
					{ Cue = "/VO/ZagreusField_3108", RequiredPlayed = { "/VO/ZagreusField_3104" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
			},
		},
		Fish_Chaos_Common_01 =
		{
			InheritFrom = { "DefaultCommon" },
			Award = {
				{ MetaPoints = 100 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- I caught a Mati!
					{ Cue = "/VO/ZagreusField_3192" },
					-- It's a Mati.
					{ Cue = "/VO/ZagreusField_3193", RequiredPlayed = { "/VO/ZagreusField_3192" } },
					-- Another Mati.
					{ Cue = "/VO/ZagreusField_3194", RequiredPlayed = { "/VO/ZagreusField_3192" } },
					-- Another Mati, huh?
					{ Cue = "/VO/ZagreusField_3195", RequiredPlayed = { "/VO/ZagreusField_3192" } },
					-- That's a Mati.
					{ Cue = "/VO/ZagreusField_3196", RequiredPlayed = { "/VO/ZagreusField_3192" } },
					-- Looks like a Mati.
					{ Cue = "/VO/ZagreusField_3197", RequiredPlayed = { "/VO/ZagreusField_3192" } },
					-- Caught a Mati.
					{ Cue = "/VO/ZagreusField_3198", RequiredPlayed = { "/VO/ZagreusField_3192" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
				[3] = GlobalVoiceLines.ChaosComplimentVoiceLines,
			},

		},
		Fish_Chaos_Rare_01 =
		{
			InheritFrom = { "DefaultRare" },
			Award = {
				{ MetaPoints = 250 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- I caught a Projelly!
					{ Cue = "/VO/ZagreusField_3199" },
					-- It's a Projelly.
					{ Cue = "/VO/ZagreusField_3200", RequiredPlayed = { "/VO/ZagreusField_3199" } },
					-- Got a Projelly.
					{ Cue = "/VO/ZagreusField_3201", RequiredPlayed = { "/VO/ZagreusField_3199" } },
					-- Another Projelly.
					{ Cue = "/VO/ZagreusField_3202", RequiredPlayed = { "/VO/ZagreusField_3199" } },
					-- That's a Projelly.
					{ Cue = "/VO/ZagreusField_3203", RequiredPlayed = { "/VO/ZagreusField_3199" } },
					-- That's a Projelly all right.
					{ Cue = "/VO/ZagreusField_3204", RequiredPlayed = { "/VO/ZagreusField_3199" } },
					-- Hey a Projelly.
					{ Cue = "/VO/ZagreusField_3205", RequiredPlayed = { "/VO/ZagreusField_3199" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
				[3] = GlobalVoiceLines.ChaosComplimentVoiceLines,
			},

		},
		Fish_Chaos_Legendary_01 =
		{
			InheritFrom = { "DefaultLegendary" },
			Award = {
				{ MetaPoints = 500 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- Whoa I caught a Voidskate?
					{ Cue = "/VO/ZagreusField_3206" },
					-- Wow a Voidskate!
					{ Cue = "/VO/ZagreusField_3207", RequiredPlayed = { "/VO/ZagreusField_3206" } },
					-- It's another Voidskate!
					{ Cue = "/VO/ZagreusField_3208", RequiredPlayed = { "/VO/ZagreusField_3206" } },
					-- Ooh it's a Voidskate!
					{ Cue = "/VO/ZagreusField_3209", RequiredPlayed = { "/VO/ZagreusField_3206" } },
					-- It's a Voidskate!
					{ Cue = "/VO/ZagreusField_3210", RequiredPlayed = { "/VO/ZagreusField_3206" } },
					-- Hey a Voidskate!
					{ Cue = "/VO/ZagreusField_3211", RequiredPlayed = { "/VO/ZagreusField_3206" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
				[3] = GlobalVoiceLines.ChaosComplimentVoiceLines,
			},

		},
		Fish_Surface_Common_01 =
		{
			InheritFrom = { "DefaultCommon" },
			Award = {
				{ SuperGems = 1 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- Is this a Trout?
					{ Cue = "/VO/ZagreusField_4359" },
					-- Caught me a Trout.
					{ Cue = "/VO/ZagreusField_4360", RequiredPlayed = { "/VO/ZagreusField_4359" } },
					-- Another Trout.
					{ Cue = "/VO/ZagreusField_4361", RequiredPlayed = { "/VO/ZagreusField_4359" } },
					-- Yep, that's a Trout.
					{ Cue = "/VO/ZagreusField_4362", RequiredPlayed = { "/VO/ZagreusField_4359" } },
					-- Looks like a Trout.
					{ Cue = "/VO/ZagreusField_4363", RequiredPlayed = { "/VO/ZagreusField_4359" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
				[3] = GlobalVoiceLines.PersephoneFishCaughtVoiceLines,
			},
		},
		Fish_Surface_Rare_01 =
		{
			InheritFrom = { "DefaultRare" },
			Award = {
				{ SuperGiftPoints = 1 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- I caught a Bass?
					{ Cue = "/VO/ZagreusField_4364" },
					-- Another Bass, huh.
					{ Cue = "/VO/ZagreusField_4365", RequiredPlayed = { "/VO/ZagreusField_4364" } },
					-- Hey, it's a Bass.
					{ Cue = "/VO/ZagreusField_4366", RequiredPlayed = { "/VO/ZagreusField_4364" } },
					-- Got me a Bass.
					{ Cue = "/VO/ZagreusField_4367", RequiredPlayed = { "/VO/ZagreusField_4364" } },
					-- That's one more Bass.
					{ Cue = "/VO/ZagreusField_4368", RequiredPlayed = { "/VO/ZagreusField_4364" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
				[3] = GlobalVoiceLines.PersephoneFishCaughtVoiceLines,
			},
		},
		Fish_Surface_Legendary_01 =
		{
			InheritFrom = { "DefaultLegendary" },
			Award = {
				{ SuperLockKeys = 1 },
			},

			FishIdentifiedVoiceLines =
			{
				{
					RandomRemaining = true,
					PreLineWait = 1.0,
					SuccessiveChanceToPlayAll = 0.66,
					TriggerCooldowns = { "ZagreusGlobalFishCaughtVoiceLinesPlayed" },

					-- Wow, a Sturgeon!
					{ Cue = "/VO/ZagreusField_4369" },
					-- I caught a Sturgeon?
					{ Cue = "/VO/ZagreusField_4370", RequiredPlayed = { "/VO/ZagreusField_4369" } },
					-- This is a Sturgeon!
					{ Cue = "/VO/ZagreusField_4371", RequiredPlayed = { "/VO/ZagreusField_4369" } },
					-- That's one big Sturgeon.
					{ Cue = "/VO/ZagreusField_4372", RequiredPlayed = { "/VO/ZagreusField_4369" } },
					-- What now, another Sturgeon?!
					{ Cue = "/VO/ZagreusField_4373", RequiredPlayed = { "/VO/ZagreusField_4369" } },
				},
				[2] = GlobalVoiceLines.FishIdentifiedVoiceLines,
				[3] = GlobalVoiceLines.PersephoneFishCaughtVoiceLines,
			},
		},

	}
}