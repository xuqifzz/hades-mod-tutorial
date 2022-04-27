CodexOrdering =
{
	Order = { "ChthonicGods", "OlympianGods", "OtherDenizens", "Biomes", "Weapons", "Enemies", "Items", "Fish", "Keepsakes" },
	ChthonicGods =
	{
		Order = { "NPC_Hades_01", "NPC_Nyx_01", "PlayerUnit", "NPC_Charon_01", "NPC_Hypnos_01", "NPC_Thanatos_01", "NPC_FurySister_01", "Harpy2", "Harpy3", "TrialUpgrade", },
	},
	OlympianGods =
	{
		Order = { "ZeusUpgrade", "PoseidonUpgrade", "AthenaUpgrade", "AphroditeUpgrade", "ArtemisUpgrade", "AresUpgrade", "DionysusUpgrade", "HermesUpgrade", "DemeterUpgrade" },
	},
	OtherDenizens =
	{
		Order = { "NPC_Achilles_01", "NPC_Orpheus_01", "NPC_Sisyphus_01", "NPC_Eurydice_01", "NPC_Patroclus_01", "Theseus", "Minotaur", "NPC_Cerberus_01", "NPC_Dusa_01", "NPC_Skelly_01", "NPC_Persephone_Home_01" },
	},
	Weapons =
	{
		Order = {"SwordWeapon", "SpearWeapon", "BowWeapon", "ShieldWeapon", "FistWeapon", "GunWeapon", }
	},
	Enemies =
	{
		Order = { "HeavyMelee", "LightRanged", "PunchingBagUnit", "ThiefMineLayer", "WretchAssassinMiniboss", "Swarmer", "LightSpawner", "DisembodiedHand", "HeavyRanged", "HeavyRangedSplitterMiniboss", "ShieldRanged", "BloodlessNaked", "BloodlessNakedBerserker", "BloodlessGrenadier", "BloodlessSelfDestruct", "BloodlessPitcher", "BloodlessWaveFist", "RangedBurrower", "SpreadShotUnit", "FreezeShotUnit", "CrusherUnit", "HitAndRunUnit", "HydraHeadImmortal", "SplitShotUnit", "Chariot", "ChariotSuicide", "ShadeSwordUnit", "ShadeSpearUnit", "ShadeBowUnit", "ShadeShieldUnit", "FlurrySpawner", "Crawler", "RatThug", "CrawlerMiniBoss", "ThiefImpulseMineLayer", "HeavyRangedForked", "SatyrRanged", },
	},
	Biomes =
	{
		Order = { "DeathArea", "Tartarus", "Asphodel", "Elysium", "Styx", "Secrets", "Challenge", "Surface" },
	},
	Items =
	{
		Order = { "RoomRewardMetaPointDrop", "AmmoPack", "ChallengeSwitch", "RoomRewardMoneyDrop", "RoomRewardMaxHealthDrop", "StackUpgrade", "WeaponUpgrade", "ChaosWeaponUpgrade", "LockKeyDrop", "SuperLockKeyDrop", "GemDrop", "SuperGemDrop", "GiftDrop", "SuperGiftDrop", "CharonStoreDiscount", "RoomRewardConsolationPrize" }
	},
	Fish =
	{
		Order = { "Fish_Chaos_Common_01", "Fish_Chaos_Rare_01", "Fish_Chaos_Legendary_01", "Fish_Tartarus_Common_01", "Fish_Tartarus_Rare_01", "Fish_Tartarus_Legendary_01", "Fish_Asphodel_Common_01", "Fish_Asphodel_Rare_01", "Fish_Asphodel_Legendary_01", "Fish_Elysium_Common_01", "Fish_Elysium_Rare_01", "Fish_Elysium_Legendary_01", "Fish_Styx_Common_01", "Fish_Styx_Rare_01", "Fish_Styx_Legendary_01", "Fish_Surface_Common_01", "Fish_Surface_Rare_01", "Fish_Surface_Legendary_01" },
	},
	Keepsakes =
	{
		Order = { "FuryAssistTrait", "ThanatosAssistTrait", "SisyphusAssistTrait", "SkellyAssistTrait", "DusaAssistTrait", "AchillesPatroclusAssistTrait" },
	}
}

CodexUnlockTypes =
{
	Interact = "Interact",
	Slay = "Slay",
	SlayAlt = "SlayAlt",
	Boon = "Boon",
	Wield = "Wield",
	Collect = "Collect",
	Unseal = "Unseal",
	Fish = "Fish",
	Enter = "Enter",
	Summon = "Summon",
	Mystery = "Mystery",
}

Codex =
{
	ChthonicGods =
	{
		UnlockType = CodexUnlockTypes.Interact,
		TitleText = "Codex_ChthonicGodsChapter",
		Entries =
		{
			PlayerUnit =
			{
				Entries =
				{
					{
						Text = "CodexData_0000"
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "PersephoneFirstMeeting" } },
						CustomUnlockText = "Codex_Custom_Story_Requirement",
						Text = "CodexData_Zagreus_02",
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "Ending01" } },
						CustomUnlockText = "Codex_Custom_Story_Requirement",
						Text = "CodexData_Zagreus_03",
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "OlympianReunionQuestComplete" } },
						CustomUnlockText = "Codex_Custom_Story_Requirement",
						Text = "CodexData_Zagreus_04",
					},
				},
				UnlockType = CodexUnlockTypes.Mystery,
				Image = "Codex_Portrait_Zagreus",
			},

			NPC_Hades_01 =
			{
				Entries =
				{
					{
						Text = "CodexData_Hades_01"
					},
					{
						UnlockThreshold = 1,
						Text = "CodexData_Hades_02"
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_Hades_03"
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_Hades_04"
					},
				},
				Image = "Codex_Portrait_Hades",
			},

			NPC_Nyx_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0011",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0012",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0013",
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "NyxChaosReunionQuestComplete" } },
						CustomUnlockText = "Codex_Custom_Relationship_Requirement",
						Text = "CodexData_Nyx_04",
					},
				},
				Image = "Codex_Portrait_Nyx",
			},

			NPC_Hypnos_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0014",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0015",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0016",
					},
				},
				Image = "Codex_Portrait_Hypnos",
			},

			NPC_Thanatos_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Thanatos_01",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_Thanatos_02",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_Thanatos_03",
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "ThanatosFieldAboutRelationship01" } },
						CustomUnlockText = "Codex_Custom_Relationship_Requirement",
						-- UnlockThreshold = 30,
						Text = "CodexData_Thanatos_04",
					},
				},
				Image = "Codex_Portrait_Thanatos",
				EntryReadVoiceLines =
				{
					PlayOnce = true,
					PreLineWait = 1.8,
					RequiredCodexEntry =
					{
					  EntryName = "NPC_Thanatos_01",
					  EntryIndex = 4,
					},

					-- Achilles thinks that I'm the... god of blood?
					{ Cue = "/VO/ZagreusHome_1588", PlayOnce = true, },
				},
			},

			NPC_FurySister_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Megaera_01",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_Megaera_02",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_Megaera_03",
					},
					{
						Text = "CodexData_Megaera_04",
						UnlockGameStateRequirements = { RequiredAnyTextLines = { "MegaeraBedroom02", "MegaeraBedroom02B" } },
						-- UnlockThreshold = 30,
						CustomUnlockText = "Codex_Custom_Relationship_Requirement",
					},
				},
				Image = "Codex_Portrait_Megaera",
			},

			Harpy2 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0023",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0024",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0025",
					},
				},
				UnlockType = CodexUnlockTypes.SlayAlt,
				Image = "Codex_Portrait_Alecto",
			},

			Harpy3 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Tisiphone_01",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_Tisiphone_02",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_Tisiphone_03",
					},
				},
				UnlockType = CodexUnlockTypes.SlayAlt,
				Image = "Codex_Portrait_Tisiphone",
			},

			NPC_Charon_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0029",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0030",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0031",
					},
				},
				Image = "Codex_Portrait_Charon",
			},

			TrialUpgrade =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0032"
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0033"
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0034"
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "ChaosAboutNyx04" } },
						CustomUnlockText = "Codex_Custom_Relationship_Requirement",
						Text = "CodexData_Chaos_04",
					},
				},
				UnlockType = CodexUnlockTypes.Boon,
				Image = "Codex_Portrait_Chaos",
			},
		},
	},

	OtherDenizens =
	{
		UnlockType = CodexUnlockTypes.Interact,
		TitleText = "Codex_OtherDenizensChapter",
		Entries =
		{
			NPC_Cerberus_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0035",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0036",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0037",
					},
				},
				Image = "Codex_Portrait_Cerberus",
			},

			NPC_Achilles_01 =
			{
				Entries =
				{
					{
						Text = "CodexData_0038",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0039",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0040",
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "AchillesAfterMyrmidonReunionQuestComplete01" } },
						CustomUnlockText = "Codex_Custom_Relationship_Requirement",
						-- UnlockThreshold = 30,
						Text = "CodexData_Achilles_04",
					},
				},
				Image = "Codex_Portrait_Achilles",
			},

			NPC_Skelly_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Skelly_01",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_Skelly_02",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_Skelly_03",
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "SkellyTrueDeathQuestComplete" } },
						CustomUnlockText = "Codex_Custom_Relationship_Requirement",
						-- UnlockThreshold = 30,
						Text = "CodexData_Skelly_04",
					},
				},
				Image = "Codex_Portrait_Skelly",
			},

			NPC_Sisyphus_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Sisyphus_01",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_Sisyphus_02",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_Sisyphus_03",
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "SisyphusLiberationQuestComplete" } },
						CustomUnlockText = "Codex_Custom_Relationship_Requirement",
						-- UnlockThreshold = 30,
						Text = "CodexData_Sisyphus_04",
					},
				},
				Image = "Codex_Portrait_Sisyphus",
			},

			NPC_Orpheus_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0047",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0048",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0049",
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "OrpheusAboutSingersReunionQuestComplete01" } },
						CustomUnlockText = "Codex_Custom_Relationship_Requirement",
						-- UnlockThreshold = 30,
						Text = "CodexData_Orpheus_04",
					},
				},
				Image = "Codex_Portrait_Orpheus",
			},

			Theseus =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0050",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0051",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0052",
					},
				},
				UnlockType = CodexUnlockTypes.SlayAlt,
				Image = "Codex_Portrait_Theseus",
			},

			Minotaur =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0053",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0054",
					},
					{
						UnlockThreshold = 15,
					Text = "CodexData_0055",
					},
				},
				UnlockType = CodexUnlockTypes.SlayAlt,
				Image = "Codex_Portrait_Minotaur",
			},

			NPC_Eurydice_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Eurydice_01"
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_Eurydice_02"

					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_Eurydice_03"
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "OrpheusWithEurydice01" } },
						CustomUnlockText = "Codex_Custom_Relationship_Requirement",
						-- UnlockThreshold = 30,
						Text = "CodexData_Eurydice_04",
					},
				},
				Image = "Codex_Portrait_Eurydice",
			},

			NPC_Patroclus_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0059"
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0060"

					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0061"
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "PatroclusWithAchilles01" } },
						CustomUnlockText = "Codex_Custom_Relationship_Requirement",
						-- UnlockThreshold = 30,
						Text = "CodexData_Patroclus_04",
					},
				},
				Image = "Codex_Portrait_Patroclus",
				EntryReadVoiceLines =
				{
					PlayOnce = true,
					PreLineWait = 1.0,
					RequiredFalseTextLines = { "PatroclusAboutBracer01C", "PatroclusAboutBracer01D" },
					RequiredCodexEntry =
					{
					  EntryName = "NPC_Patroclus_01",
					  EntryIndex = 1,
					},

					-- Patroclus... so that's his name.
					{ Cue = "/VO/ZagreusField_1908", RequiredFalseTextLines = { "AchillesGift08", "AchillesGift06_A", "PatroclusAboutBracer01A", "PatroclusAboutBracer01B", }, RequiredFalsePlayed = { "/VO/ZagreusField_1909" } },

					-- That shade... that was Patroclus...?
					{ Cue = "/VO/ZagreusField_1909", RequiredAnyTextLines = { "AchillesGift08", "AchillesGift06_A", "PatroclusAboutBracer01A", "PatroclusAboutBracer01B" }, RequiredFalsePlayed = { "/VO/ZagreusField_1908" } },
				},
			},

			NPC_Dusa_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Dusa_01",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_Dusa_02",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_Dusa_03",
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "DusaLoungeRenovationQuestComplete" } },
						CustomUnlockText = "Codex_Custom_Relationship_Requirement",
						-- UnlockThreshold = 30,
						Text = "CodexData_Dusa_04",
					},
				},
				Image = "Codex_Portrait_Medusa",
			},

			NPC_Persephone_Home_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Persephone_01"
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_Persephone_02"
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_Persephone_03"
					},
					{
						UnlockGameStateRequirements = { RequiredTextLines = { "PersephoneWithNyx01", "PersephoneWithHades01" } },
						CustomUnlockText = "Codex_Custom_Relationship_Requirement",
						-- UnlockThreshold = 30,
						Text = "CodexData_Persephone_04",
					},
				},
				Image = "Codex_Portrait_Persephone",
			},

		},
	},

	Enemies =
	{
		UnlockType = CodexUnlockTypes.Slay,
		TitleText = "Codex_EnemiesChapter",
		Entries =
		{
			Swarmer =
			{
				Entries =
				{
					{
						UnlockThreshold = 10,
						Text = "CodexData_0065",
					},
					{
						UnlockThreshold = 100,
						Text = "CodexData_0066",
					}
				},
				Image = "Codex_Portrait_Numbskull",
			},
			LightSpawner =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0067",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0068",
					},
				},
				Image = "Codex_Portrait_Skullomat",
			},
			DisembodiedHand =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_DisembodiedHand_01",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_DisembodiedHand_02",
					},
				},
				Image = "Codex_Portrait_DisembodiedHand",
			},
			HeavyMelee =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0069",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0070",
					},
				},
				Image = "Codex_Portrait_Thug",
			},
			LightRanged =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0071",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0072",
					},
				},
				Image = "Codex_Portrait_Witch",
			},
			PunchingBagUnit =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0073",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0074",
					},
				},
				Image = "Codex_Portrait_Lout",
			},
			ThiefMineLayer =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0075",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0076",
					},
				},
				Image = "Codex_Portrait_Thief",
			},
			WretchAssassinMiniboss =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_WretchAssassin_01",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_WretchAssassin_02",
					},
				},
				Image = "Codex_Portrait_WretchAssassin",
			},
			HeavyRanged =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0077",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0078",
					},
				},
				Image = "Codex_Portrait_Brimstone",
			},
			HeavyRangedSplitterMiniboss =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_HeavyRangedSplitter_01",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_HeavyRangedSplitter_02",
					},
				},
				Image = "Codex_Portrait_HeavyRangedSplitter",
			},
			ShieldRanged =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0079",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0080",
					},
				},
				Image = "Codex_Portrait_Shieldstone",
			},
			BloodlessNaked =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0081",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0082",
					},
					{
						UnlockThreshold = 150,
						Text = "CodexData_0083",
					},
				},
				Image = "Codex_Portrait_Bloodless",
			},
			BloodlessNakedBerserker =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_BloodlessBerserker_01",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_BloodlessBerserker_02",
					},
				},
				Image = "Codex_Portrait_BloodlessBerserker",
			},
			BloodlessWaveFist =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0084",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0085",
					},
				},
				Image = "Codex_Portrait_WaveFist",
			},
			BloodlessGrenadier =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0086",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0087",
					},
				},
				Image = "Codex_Portrait_Grenadier",
			},
			BloodlessSelfDestruct =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0088",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0089",
					},
				},
				Image = "Codex_Portrait_SelfDestruct",
			},
			BloodlessPitcher =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0090",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0091",
					},
				},
				Image = "Codex_Portrait_Pitcher",
			},
			RangedBurrower =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_RangedBurrower_01",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_RangedBurrower_02",
					},
				},
				Image = "Codex_Portrait_RangedBurrower",
			},
			SplitShotUnit =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0092",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0093",
					},
				},
				Image = "Codex_Portrait_SplitShotUnit",
			},

			FreezeShotUnit =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FreezeShotUnit_01",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_FreezeShotUnit_02",
					},
				},
				Image = "Codex_Portrait_FreezeShot",
			},

			CrusherUnit =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0096",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0097",
					},
				},
				Image = "Codex_Portrait_Crusher",
			},

			HitAndRunUnit =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_MegaGorgon_01",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_MegaGorgon_02",
					},
				},
				Image = "Codex_Portrait_HitAndRun",
			},
			HydraHeadImmortal =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0100",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0101",
					},
				},
				Image = "Codex_Portrait_Hydra",
			},

			SpreadShotUnit =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0102",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0103",
					}
				},
				Image = "Codex_Portrait_SpreadShotUnit",
			},
			Chariot =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0104",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0105",
					},
				},
				Image = "Codex_Portrait_Chariot",
			},
			ChariotSuicide =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0106",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0107",
					},
				},
				Image = "Codex_Portrait_ChariotSuicide",
			},
			ShadeSwordUnit =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0108",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0109",
					},
				},
				Image = "Codex_Portrait_ShadeSwordUnit",
			},
			ShadeSpearUnit =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0110",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0111",
					},
				},
				Image = "Codex_Portrait_ShadeSpearUnit",
			},
			ShadeBowUnit =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0112",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0113",
					},
				},
				Image = "Codex_Portrait_ShadeBowUnit",
			},
			ShadeShieldUnit =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0114",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0115",
					},
				},
				Image = "Codex_Portrait_ShadeShieldUnit",
			},
			FlurrySpawner =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0116",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0117",
					},
				},
				Image = "Codex_Portrait_FlurrySpawner",
			},
			Crawler =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0118",
					},
					{
						UnlockThreshold = 150,
						Text = "CodexData_0119",
					},
				},
				Image = "Codex_Portrait_Crawler",
			},
			RatThug =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0120",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0121",
					},
				},
				Image = "Codex_Portrait_RatThug",
			},
			CrawlerMiniBoss =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_CrawlerMiniBoss_01",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_CrawlerMiniBoss_02",
					},
				},
				Image = "Codex_Portrait_CrawlerMiniBoss",
			},
			ThiefImpulseMineLayer =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0122",
					},
					{
						UnlockThreshold = 50,
							Text = "CodexData_0123",
					},
				},
				Image = "Codex_Portrait_ThiefImpulseMineLayer",
			},
			HeavyRangedForked =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0124"
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0125",
					},
				},
				Image = "Codex_Portrait_HeavyRangedForked",
			},
			SatyrRanged =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0126",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0127",
					},
				},
				Image = "Codex_Portrait_SatyrRanged",
			},
		},
	},

	OlympianGods =
	{
		UnlockType = CodexUnlockTypes.Boon,
		TitleText = "Codex_OlympianGodsChapter",
		Entries =
		{
			ZeusUpgrade =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0128",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0129",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0130" },
				},
				Image = "Codex_Portrait_Zeus",
			},

			PoseidonUpgrade =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0131",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0132",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0133",
					},
				},
				Image = "Codex_Portrait_Poseidon",
			},

			AthenaUpgrade =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0134",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0135",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0136",
					},
				},
				Image = "Codex_Portrait_Athena",
			},

			AresUpgrade =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0137",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0138",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0139",
					},
				},
				Image = "Codex_Portrait_Ares",
			},

			AphroditeUpgrade =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0140",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0141",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0142",
					},
				},
				Image = "Codex_Portrait_Aphrodite",
			},

			ArtemisUpgrade =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0143",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0144",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0145",
					},
				},
				Image = "Codex_Portrait_Artemis",
			},

			DionysusUpgrade =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0146",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0147",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0148",
					},
				},
				Image = "Codex_Portrait_Dionysus",
			},

			HermesUpgrade =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0149",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0150",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_0151",
					},
				},
				Image = "Codex_Portrait_Hermes",
			},

			DemeterUpgrade =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Demeter_01",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_Demeter_02",
					},
					{
						UnlockThreshold = 15,
						Text = "CodexData_Demeter_03",
					},
					{
						UnlockThreshold = 30,
						Text = "CodexData_Demeter_04",
					},
				},
				Image = "Codex_Portrait_Demeter",
			},
		},
	},

	Weapons =
	{
		UnlockType = CodexUnlockTypes.Wield,
		TitleText = "Codex_WeaponsChapter",
		Entries =
		{
			SwordWeapon =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_SwordWeapon_01",
					},
					{
						UnlockThreshold = 100,
						Text = "CodexData_SwordWeapon_02",
					},
					{
						UnlockThreshold = 250,
						Text = "CodexData_SwordWeapon_03",
					},
					{
						UnlockThreshold = 500,
						Text = "CodexData_SwordWeapon_04",
					},
				},
				Image = "Codex_Portrait_Sword",
			},

			SpearWeapon =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_SpearWeapon_01",
					},
					{
						UnlockThreshold = 100,
						Text = "CodexData_SpearWeapon_02",
					},
					{
						UnlockThreshold = 250,
						Text = "CodexData_SpearWeapon_03",
					},
					{
						UnlockThreshold = 500,
						Text = "CodexData_SpearWeapon_04",
					},
				},
				Image = "Codex_Portrait_Spear",
			},

			BowWeapon =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_BowWeapon_01",
					},
					{
						UnlockThreshold = 100,
						Text = "CodexData_BowWeapon_02",
					},
					{
						UnlockThreshold = 250,
						Text = "CodexData_BowWeapon_03",
					},
					{
						UnlockThreshold = 500,
						Text = "CodexData_BowWeapon_04",
					},
				},
				Image = "Codex_Portrait_Bow",
			},

			ShieldWeapon =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_ShieldWeapon_01",
					},
					{
						UnlockThreshold = 100,
						Text = "CodexData_ShieldWeapon_02",
					},
					{
						UnlockThreshold = 250,
						Text = "CodexData_ShieldWeapon_03",
					},
					{
						UnlockThreshold = 500,
						Text = "CodexData_ShieldWeapon_04",
					},
				},
				Image = "Codex_Portrait_Shield",
			},

			FistWeapon =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FistWeapon_01",
					},
					{
						UnlockThreshold = 100,
						Text = "CodexData_FistWeapon_02",
					},
					{
						UnlockThreshold = 250,
						Text = "CodexData_FistWeapon_03",
					},
					{
						UnlockThreshold = 500,
						Text = "CodexData_FistWeapon_04",
					},
				},
				Image = "Codex_Portrait_Fist",
			},

			GunWeapon =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_GunWeapon_01",
					},
					{
						UnlockThreshold = 100,
						Text = "CodexData_GunWeapon_02",
					},
					{
						UnlockThreshold = 250,
						Text = "CodexData_GunWeapon_03",
					},
					{
						UnlockThreshold = 500,
						Text = "CodexData_GunWeapon_04",
					},
				},
				Image = "Codex_Portrait_Gun",
			},
		},
	},

	Items =
	{
		UnlockType = CodexUnlockTypes.Collect,
		TitleText = "Codex_ItemsChapter",
		Entries =
		{
			RoomRewardMetaPointDrop =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0167",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_0168",
					},
					{
						UnlockThreshold = 100,
						Text = "CodexData_0169",
					},
				},
				Image = "Codex_Portrait_Darkness",
			},

			AmmoPack =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Ammo_01",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_Ammo_02",
					},
					{
						UnlockThreshold = 100,
						Text = "CodexData_Ammo_03",
					},
				},
				Image = "Codex_Portrait_AmmoPack",
			},

			ChallengeSwitch =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_ChallengeSwitch_01",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_ChallengeSwitch_02",
					},
				},
				UnlockType = CodexUnlockTypes.Unseal,
				Image = "Codex_Portrait_ChallengeSwitch",
			},

			WeaponUpgrade =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0170",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_0171",
					},
				},
				Image = "Codex_Portrait_Hammer",
			},

			ChaosWeaponUpgrade =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_ChaosWeaponUpgrade_01",
					},
					{
						UnlockThreshold = 10,
						Text = "CodexData_ChaosWeaponUpgrade_02",
					},
				},
				Image = "Codex_Portrait_ChaosWeaponUpgrade",
			},

			StackUpgrade =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0172",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_0173",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0174",
					},
				},
				Image = "Codex_Portrait_Pom",
			},
			GemDrop =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_GemDrop_01",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_GemDrop_02",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_GemDrop_03",
					},
				},
				Image = "Codex_Portrait_Gem",
			},
			LockKeyDrop =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_LockKeyDrop_01",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_LockKeyDrop_02",
					},
				},
				Image = "Codex_Portrait_LockKey",
			},
			GiftDrop =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0177",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_0178",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0179",
					},
				},
				Image = "Codex_Portrait_Ambrosia",
			},
			RoomRewardMaxHealthDrop =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0180",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_0181",
					},
				},
				Image = "Codex_Portrait_Heart",
			},
			RoomRewardMoneyDrop =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0182",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_0183",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_0184",
					},
				},
				Image = "Codex_Portrait_Coin",
			},
			SuperGemDrop =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_SuperGemDrop_01",
					},
					{
						UnlockThreshold = 10,
						Text = "CodexData_SuperGemDrop_02",
					},
				},
				Image = "Codex_Portrait_SuperGem",
			},
			SuperLockKeyDrop =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_SuperLockKeyDrop_01",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_SuperLockKeyDrop_02",
					},
				},
				Image = "Codex_Portrait_SuperLockKey",
			},
			SuperGiftDrop =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_SuperGiftDrop_01",
					},
					{
						UnlockThreshold = 10,
						Text = "CodexData_SuperGiftDrop_02",
					},
				},
				Image = "Codex_Portrait_SuperGiftDrop",
			},
			CharonStoreDiscount =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_CharonStoreDiscount_01",
					},
					{
						UnlockThreshold = 10,
						Text = "CodexData_CharonStoreDiscount_02",
					},
				},
				Image = "Codex_Portrait_CharonStoreDiscount",
			},
			RoomRewardConsolationPrize =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_0188",
					},
					{
						UnlockThreshold = 5,
						Text = "CodexData_0189",
					},
					{
						UnlockThreshold = 10,
						Text = "CodexData_0190",
					},
				},
				Image = "Codex_Portrait_Onion",
			},
		}
	},
	Fish =
	{
		UnlockType = CodexUnlockTypes.Fish,
		TitleText = "Codex_FishChapter",
		Entries =
		{

			Fish_Chaos_Common_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishChaosCommon01_01",
					},
					{
						UnlockThreshold = 2,
						Text = "CodexData_FishChaosCommon01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Chaos_Common_01",
			},
			Fish_Chaos_Rare_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishChaosRare01_01",
					},
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishChaosRare01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Chaos_Rare_01",
			},
			Fish_Chaos_Legendary_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishChaosLegendary01_01",
					},
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishChaosLegendary01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Chaos_Legendary_01",
			},
			Fish_Tartarus_Common_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishTartarusCommon01_01",
					},
					{
						UnlockThreshold = 3,
						Text = "CodexData_FishTartarusCommon01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Tartarus_Common_01",
			},
			Fish_Tartarus_Rare_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishTartarusRare01_01",
					},
					{
						UnlockThreshold = 2,
						Text = "CodexData_FishTartarusRare01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Tartarus_Rare_01",
			},
			Fish_Tartarus_Legendary_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishTartarusLegendary01_01",
					},
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishTartarusLegendary01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Tartarus_Legendary_01",
			},
			Fish_Asphodel_Common_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishAsphodelCommon01_01",
					},
					{
						UnlockThreshold = 3,
						Text = "CodexData_FishAsphodelCommon01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Asphodel_Common_01",
			},
			Fish_Asphodel_Rare_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishAsphodelRare01_01",
					},
					{
						UnlockThreshold = 2,
						Text = "CodexData_FishAsphodelRare01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Asphodel_Rare_01",
			},
			Fish_Asphodel_Legendary_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishAsphodelLegendary01_01",
					},
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishAsphodelLegendary01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Asphodel_Legendary_01",
			},
			Fish_Elysium_Common_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishElysiumCommon01_01",
					},
					{
						UnlockThreshold = 3,
						Text = "CodexData_FishElysiumCommon01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Elysium_Common_01",
			},
			Fish_Elysium_Rare_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishElysiumRare01_01",
					},
					{
						UnlockThreshold = 2,
						Text = "CodexData_FishElysiumRare01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Elysium_Rare_01",
			},
			Fish_Elysium_Legendary_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishElysiumLegendary01_01",
					},
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishElysiumLegendary01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Elysium_Legendary_01",
			},
			Fish_Styx_Common_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishStyxCommon01_01",
					},
					{
						UnlockThreshold = 3,
						Text = "CodexData_FishStyxCommon01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Styx_Common_01",
			},
			Fish_Styx_Rare_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishStyxRare01_01",
					},
					{
						UnlockThreshold = 2,
						Text = "CodexData_FishStyxRare01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Styx_Rare_01",
			},
			Fish_Styx_Legendary_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishStyxLegendary01_01",
					},
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishStyxLegendary01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Styx_Legendary_01",
			},
			Fish_Surface_Common_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishSurfaceCommon01_01",
					},
					{
						UnlockThreshold = 3,
						Text = "CodexData_FishSurfaceCommon01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Surface_Common_01",
			},
			Fish_Surface_Rare_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishSurfaceRare01_01",
					},
					{
						UnlockThreshold = 2,
						Text = "CodexData_FishSurfaceRare01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Surface_Rare_01",
			},
			Fish_Surface_Legendary_01 =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishSurfaceLegendary01_01",
					},
					{
						UnlockThreshold = 1,
						Text = "CodexData_FishSurfaceLegendary01_02",
					},
				},
				Image = "Codex_Portrait_Fish_Surface_Legendary_01",
			},
		},
	},

	Biomes =
	{
		UnlockType = CodexUnlockTypes.Enter,
		TitleText = "Codex_BiomesChapter",
		Entries =
		{
			DeathArea = 
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_DeathArea_01",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_DeathArea_02",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_DeathArea_03",
					},
				},
				Image = "Codex_Portrait_DeathAreaBiome",
			},
			Secrets =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Chaos_01",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_Chaos_02",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_Chaos_03",
					},
				},
				Image = "Codex_Portrait_ChaosBiome",
			},
			Challenge =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Erebus_01",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_Erebus_02",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_Erebus_03",
					},
				},
				Image = "Codex_Portrait_ErebusBiome",
			},			
			Tartarus =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Tartarus_01",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_Tartarus_02",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_Tartarus_03",
					},
				},
				Image = "Codex_Portrait_TartarusBiome",
			},
			Asphodel =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Asphodel_01",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_Asphodel_02",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_Asphodel_03",
					},
				},
				Image = "Codex_Portrait_AsphodelBiome",
			},
			Elysium =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Elysium_01",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_Elysium_02",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_Elysium_03",
					},
				},
				Image = "Codex_Portrait_ElysiumBiome",
			},
			Styx =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Styx_01",
					},
					{
						UnlockThreshold = 20,
						Text = "CodexData_Styx_02",
					},
					{
						UnlockThreshold = 50,
						Text = "CodexData_Styx_03",
					},
				},
				Image = "Codex_Portrait_StyxBiome",
			},
			Surface =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_Surface_01",
					},
					{
						UnlockThreshold = 9,
						Text = "CodexData_Surface_02",
					},
				},
				Image = "Codex_Portrait_SurfaceBiome",
			},
		}
	},

	Keepsakes =
	{
		UnlockType = CodexUnlockTypes.Summon,
		TitleText = "Codex_GiftChapter",
		Entries =
		{
			AchillesPatroclusAssistTrait =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_AchillesPatroclusAssistTrait_01",
					},
					{
						UnlockThreshold = 10,
						Text = "CodexData_AchillesPatroclusAssistTrait_02",
					},
				},
				Image = "Codex_Portrait_AchillesPatroclusAssistTrait",
			},			
			FuryAssistTrait =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_FuryAssistTrait_01",
					},
					{
						UnlockThreshold = 10,
						Text = "CodexData_FuryAssistTrait_02",
					},
				},
				Image = "Codex_Portrait_FuryAssistTrait",
			},
			ThanatosAssistTrait =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_ThanatosAssistTrait_01",
					},
					{
						UnlockThreshold = 10,
						Text = "CodexData_ThanatosAssistTrait_02",
					},
				},
				Image = "Codex_Portrait_ThanatosAssistTrait",
			},
			DusaAssistTrait =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_DusaAssistTrait_01",
					},
					{
						UnlockThreshold = 10,
						Text = "CodexData_DusaAssistTrait_02",
					},
				},
				Image = "Codex_Portrait_DusaAssistTrait",
			},
			SisyphusAssistTrait =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_SisyphusAssistTrait_01",
					},
					{
						UnlockThreshold = 10,
						Text = "CodexData_SisyphusAssistTrait_02",
					},
				},
				Image = "Codex_Portrait_SisyphusAssistTrait",
			},
			SkellyAssistTrait =
			{
				Entries =
				{
					{
						UnlockThreshold = 1,
						Text = "CodexData_SkellyAssistTrait_01",
					},
					{
						UnlockThreshold = 10,
						Text = "CodexData_SkellyAssistTrait_02",
					},
				},
				Image = "Codex_Portrait_SkellyAssistTrait",
			},				
		}
	},
}