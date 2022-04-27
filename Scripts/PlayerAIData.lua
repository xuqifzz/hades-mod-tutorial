PlayerAIPersonaData =
{
	Default =
	{
		--DefaultTargetWeight = 1.0f
		--RecentTargetWeightMultiplier = 1.0f
		Maps =
		{
			-- Valid for all maps
			{
				Name = ".*",
				Weight = 1.0
			}
		},
	},
	Shopper =
	{
		Maps =
		{
			{
				Name = "[ABCD]_Shop.*",
				Weight = 100.0
			}
		},
		TargetPriorities =
		{
			{
				Name = "LootPoint",
				Weight = 10.0
			},
		}
	},
	ReprieveRoom =
	{
		Maps =
		{
			{
				Name = "[ABCD]_Reprieve.*",
				Weight = 100.0
			}
		},
		TargetPriorities =
		{
			{
				Name = "HealthFountain",
				Weight = 11.0
			},
			{
				Name = "GiftDrop",
				Weight = 10.0
			}
		}
	},
	SlightlyMoreCompetentAI =
	{
		Maps =
		{
			{
				Name = "[ABCD]_Combat.*",
				Weight = 50.0
			},
			{
				Name = "[ABCD]_Boss.*",
				Weight = 50.0
			},
			{
				Name = "RoomOpening",
				Weight = 50.0
			}
		},
		TargetPriorities =
		{
			{
				Name = "[\\w]*Elite",
				Weight = 75.0
			},
			{
				Name = "Enemy[\\w]*",
				Weight = 100.0
			},
			{
				Name = "Heavy.*",
				Weight = 100.0
			},
			{
				Name = "Light.*",
				Weight = 100.0
			},
			{
				Name = "Bloodless.*",
				Weight = 100.0
			},
			{
				Name = "AmmoPack",
				Weight = 10.0
			},
			{
				Name = "RoomReward[\\w\\d]*",
				Weight = 1.1
			},
			{
				Name = "[\\w\\d]*Loot",
				Weight = 1.1
			},
			{
				Name = "[\\w\\d]*Upgrade",
				Weight = 1.1
			},
			-- The AI runs at Doors a little too often
			{
				Name = ".*Door.*",
				Weight = 0.85
			},
			{
				Name = "WellShop",
				Weight = 1.25
			},
			{
				Name = "BlastCube.*",
				Weight = 0.01
			}
		}
	},
	DeathAreaPrioritizeRuns =
	{
		RecentTargetWeightMultiplier = 0.25, -- 75% less likely to choose recent targets
		Maps =
		{
			{
				Name = "DeathArea$",
				Weight = 1000.0
			}
		},
		TargetPriorities =
		{
			{
				-- Door to DeathAreaBedroom
				Id = 391697,
				Weight = 20,
			},
			{
				Name = "InvisibleTarget",
				Weight = 1.5 -- 2X more likely to pick than anything else
			},
			{
				Name = "MetaUpgradeScreen",
				Weight = 2.0
			},
			{
				Name = "HouseChair[\\d]*",
				Weight = 0.15
			},
			-- Prioritize upgrades over downgrades
			{
				Name = "LevelUpArrowRight",
				Weight = 1.25
			},
			{
				Name = "LevelUpArrowLeft",
				Weight = 0.05
			},
			{
				Name = "InspectPoint",
				Weight = 0.15
			}
		}
	},
	DeathAreaPreRunPrioritizeRuns =
	{
		Maps =
		{
			{
				Name = "RoomPreRun",
				Weight = 1000.0
			}
		},
		TargetPriorities =
		{
			{
				Name = "WeaponKit01",
				Weight = 2.0
			},
			{
				Name = "NewRunDoor",
				Weight = 5.0
			},
			{
				Name = "InvisibleTarget",
				Weight = 0.001
			},
			{
				Name = "ShrineUpgradeMenuConfirm",
				Weight = 100.0,
			}
		}
	},
	DeathAreaBedroomPrioritizeUpgrades =
	{
		RecentTargetWeightMultiplier = 0.25, -- 75% less likely to choose recent targets
		Maps =
		{
			{
				Name = "DeathAreaBedroom",
				Weight = 1000.0
			}
		},
		TargetPriorities =
		{
			{
				-- Door leading back to DeathArea
				Id = 420896,
				Weight = 0.1
			},
			{
				-- Door leading to PreRun area
				Id = 420897,
				Weight = 5.0
			},
			{
				Name = "InvisibleTarget",
				Weight = 1.0
			},
			{
				Name = "MetaUpgradeScreen",
				Weight = 6.0
			},
			{
				Name = "HousePapers02",
				Weight = 1.25
			},
			-- Prioritize upgrades over downgrades (unfortunately this also means a higher Pain level)
			{
				Name = "LevelUpArrowRight",
				Weight = 10.0
			},
			{
				Name = "LevelUpArrowLeft",
				Weight = 2.0
			},
			{
				Name = "InspectPoint",
				Weight = 0.15
			}
		}
	},
}