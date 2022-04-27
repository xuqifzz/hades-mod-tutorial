WeaponUpgradeData =
{
	DefaultGameStateRequirement =
	{
		RequiredTrueFlags = { "AspectsUnlocked" },
	},
	SwordWeapon =
	{
		{
			Costs = { 1, 1, 1, 1, 1, },
			MaxUpgradeLevel = 5,
			UpgradeUnequippedId = "SwordWeapon_Unequipped",
			StartsUnlocked = true,
			RequiredInvestmentTraitName = "SwordBaseUpgradeTrait",
			Image = "Codex_Portrait_Sword"
		},
		{
			Costs = { 1, 2, 3, 4, 5 },
			MaxUpgradeLevel = 5,
			--TraitName = "SwordAmmoWaveTrait"
			TraitName = "SwordCriticalParryTrait",
			EquippedKitAnimation = "WeaponSwordAlt01FloatingIdleOff",
			UnequippedKitAnimation = "WeaponSwordAlt01FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponSwordAlt01FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponSwordAlt01FloatingIdleOffBonus",
			Image = "Codex_Portrait_SwordAlt01"
		},
		{
			Costs = { 2, 2, 3, 4, 5 },
			MaxUpgradeLevel = 5,
			TraitName = "DislodgeAmmoTrait",
			EquippedKitAnimation = "WeaponSwordAlt02FloatingIdleOff",
			UnequippedKitAnimation = "WeaponSwordAlt02FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponSwordAlt02FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponSwordAlt02FloatingIdleOffBonus",
			Image = "Codex_Portrait_SwordAlt02"
		},
		{
			Costs = { 3, 3, 3, 3, 3 },
			MaxUpgradeLevel = 5,
			GameStateRequirements =
			{
				RequiredTextLines = { "NyxRevealsArthurAspect01" },
			},
			TraitName = "SwordConsecrationTrait",
			EquippedKitAnimation = "WeaponSwordAlt03FloatingIdleOff",
			UnequippedKitAnimation = "WeaponSwordAlt03FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponSwordAlt03FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponSwordAlt03FloatingIdleOffBonus",
			Image = "Codex_Portrait_SwordAlt03"
		},
	},
	SpearWeapon =
	{
		{
			Costs = { 1, 1, 1, 1, 1 },
			MaxUpgradeLevel = 5,
			UpgradeUnequippedId = "SpearWeapon_Unequipped",
			StartsUnlocked = true,
			RequiredInvestmentTraitName = "SpearBaseUpgradeTrait",
			UnequipFunctionName = "RemoveSpearBase",
			Image = "Codex_Portrait_Spear"
		},
		{
			Costs = { 1, 2, 3, 4, 5 },
			MaxUpgradeLevel = 5,
			TraitName = "SpearTeleportTrait",
			UnequipFunctionName = "RemoveSpearTeleport",
			EquippedKitAnimation = "WeaponSpearAlt01FloatingIdleOff",
			UnequippedKitAnimation = "WeaponSpearAlt01FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponSpearAlt01FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponSpearAlt01FloatingIdleOffBonus",
			Image = "Codex_Portrait_SpearAlt01"
		},
		{
			Costs = { 2, 2, 3, 4, 5 },
			MaxUpgradeLevel = 5,
			TraitName = "SpearWeaveTrait",
			UnequipFunctionName = "RemoveSpearWeave",
			EquippedKitAnimation = "WeaponSpearAlt02FloatingIdleOff",
			UnequippedKitAnimation = "WeaponSpearAlt02FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponSpearAlt02FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponSpearAlt02FloatingIdleOffBonus",
			Image = "Codex_Portrait_SpearAlt02"
		},
		{
			Costs = { 3, 3, 3, 3, 3 },
			TraitName = "SpearSpinTravel",
			MaxUpgradeLevel = 5,
			GameStateRequirements =
			{
				RequiredTextLines = { "AchillesRevealsGuanYuAspect01" },
			},
			UnequipFunctionName = "RemoveSpearGuanYu",
			-- To be replaced
			EquippedKitAnimation = "WeaponSpearAlt03FloatingIdleOff",
			UnequippedKitAnimation = "WeaponSpearAlt03FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponSpearAlt03FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponSpearAlt03FloatingIdleOffBonus",
			Image = "Codex_Portrait_SpearAlt03"
		},

	},
	GunWeapon =
	{
		{
			Costs = { 1, 1, 1, 1, 1 },
			MaxUpgradeLevel = 5,
			UpgradeUnequippedId = "GunWeapon_Unequipped",
			StartsUnlocked = true,
			RequiredInvestmentTraitName = "GunBaseUpgradeTrait",
			Image = "Codex_Portrait_Gun"
		},
		{
			Costs = { 1, 2, 3, 4, 5 },
			MaxUpgradeLevel = 5,
			TraitName = "GunGrenadeSelfEmpowerTrait",
			EquippedKitAnimation = "WeaponGunAlt02FloatingIdleOff",
			UnequippedKitAnimation = "WeaponGunAlt02FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponGunAlt02FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponGunAlt02FloatingIdleOffBonus",
			Image = "Codex_Portrait_GunAlt02"
		},
		{
			Costs = { 2, 2, 3, 4, 5 },
			MaxUpgradeLevel = 5,
			TraitName = "GunManualReloadTrait",
			UnequipFunctionName = "RemoveManualReloadBonus",
			EquippedKitAnimation = "WeaponGunAlt01FloatingIdleOff",
			UnequippedKitAnimation = "WeaponGunAlt01FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponGunAlt01FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponGunAlt01FloatingIdleOffBonus",
			Image = "Codex_Portrait_GunAlt01"
		},
		{
			Costs = { 3, 3, 3, 3, 3 },
			MaxUpgradeLevel = 5,
			GameStateRequirements =
			{
				RequiredTextLines = { "ZeusRevealsLuciferAspect01" },
			},
			TraitName = "GunLoadedGrenadeTrait",
			EquippedKitAnimation = "WeaponGunAlt03FloatingIdleOff",
			UnequippedKitAnimation = "WeaponGunAlt03FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponGunAlt03FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponGunAlt03FloatingIdleOffBonus",
			Image = "Codex_Portrait_GunAlt03"
		},

	},
	BowWeapon =
	{
		{
			Costs = { 1, 1, 1, 1, 1 },
			MaxUpgradeLevel = 5,
			UpgradeUnequippedId = "BowWeapon_Unequipped",
			StartsUnlocked = true,
			RequiredInvestmentTraitName = "BowBaseUpgradeTrait",
			Image = "Codex_Portrait_Bow"
		},
		{
			Costs = { 1, 2, 3, 4, 5 },
			MaxUpgradeLevel = 5,
			TraitName = "BowMarkHomingTrait",
			EquippedKitAnimation = "WeaponBowAlt01FloatingIdleOff",
			UnequippedKitAnimation = "WeaponBowAlt01FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponBowAlt01FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponBowAlt01FloatingIdleOffBonus",
			Image = "Codex_Portrait_BowAlt01",
			MaxedTraitDescription = "BowMarkHomingTrait_Max"
		},
		{
			Costs = { 2, 2, 3, 4, 5 },
			MaxUpgradeLevel = 5,
			TraitName = "BowLoadAmmoTrait",
			UnequipFunctionName = "RemoveAmmoLoad",
			EquippedKitAnimation = "WeaponBowAlt02FloatingIdleOff",
			UnequippedKitAnimation = "WeaponBowAlt02FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponBowAlt02FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponBowAlt02FloatingIdleOffBonus",
			Image = "Codex_Portrait_BowAlt02"
		},
		{
			Costs = { 3, 3, 3, 3, 3 },
			MaxUpgradeLevel = 5,
			GameStateRequirements =
			{
				RequiredTextLines = { "ArtemisRevealsRamaAspect01" },
			},
			TraitName = "BowBondTrait",
			EquippedKitAnimation = "WeaponBowAlt03FloatingIdleOff",
			UnequippedKitAnimation = "WeaponBowAlt03FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponBowAlt03FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponBowAlt03FloatingIdleOffBonus",
			Image = "Codex_Portrait_BowAlt03"
		},
	},
	ShieldWeapon =
	{
		{
			Costs = { 1, 1, 1, 1, 1 },
			MaxUpgradeLevel = 5,
			UpgradeUnequippedId = "ShieldWeapon_Unequipped",
			StartsUnlocked = true,
			RequiredInvestmentTraitName = "ShieldBaseUpgradeTrait",
			Image = "Codex_Portrait_Shield"
		},
		{
			Costs = { 1, 2, 3, 4, 5 },
			MaxUpgradeLevel = 5,
			TraitName = "ShieldRushBonusProjectileTrait",
			EquippedKitAnimation = "WeaponShieldAlt01FloatingIdleOff",
			UnequippedKitAnimation = "WeaponShieldAlt01FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponShieldAlt01FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponShieldAlt01FloatingIdleOffBonus",
			Image = "Codex_Portrait_ShieldAlt01"
		},
		{
			Costs = { 2, 2, 3, 4, 5 },
			MaxUpgradeLevel = 5,
			TraitName = "ShieldTwoShieldTrait",
			EquippedKitAnimation = "WeaponShieldAlt02FloatingIdleOff",
			UnequippedKitAnimation = "WeaponShieldAlt02FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponShieldAlt02FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponShieldAlt02FloatingIdleOffBonus",
			Image = "Codex_Portrait_ShieldAlt02"
		},
		{
			Costs = { 3, 3, 3, 3, 3 },
			MaxUpgradeLevel = 5,
			GameStateRequirements =
			{
				RequiredTextLines = { "ChaosRevealsBeowulfAspect01" },
			},
			UnequipFunctionName = "RemoveSelfAmmoLoad",
			TraitName = "ShieldLoadAmmoTrait",
			EquippedKitAnimation = "WeaponShieldAlt03FloatingIdleOff",
			UnequippedKitAnimation = "WeaponShieldAlt03FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponShieldAlt03FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponShieldAlt03FloatingIdleOffBonus",
			Image = "Codex_Portrait_ShieldAlt03"
		},

	},

	FistWeapon =
	{
		{
			Costs = { 1, 1, 1, 1, 1, },
			MaxUpgradeLevel = 5,
			UpgradeUnequippedId = "FistWeapon_Unequipped",
			StartsUnlocked = true,
			RequiredInvestmentTraitName = "FistBaseUpgradeTrait",
			Image = "Codex_Portrait_Fist"
		},
		{
			Costs = { 1, 2, 3, 4, 5 },
			MaxUpgradeLevel = 5,
			TraitName = "FistVacuumTrait",
			EquippedKitAnimation = "WeaponFistsAlt02FloatingIdleOff",
			UnequippedKitAnimation = "WeaponFistsAlt02FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponFistsAlt02FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponFistsAlt02FloatingIdleOffBonus",
			Image = "Codex_Portrait_FistAlt01",
			-- MaxedTraitDescription = "FistWeaveTrait_Max"
		},
		{
			Costs = { 2, 2, 3, 4, 5 },
			MaxUpgradeLevel = 5,
			TraitName = "FistWeaveTrait",
			EquippedKitAnimation = "WeaponFistsAlt01FloatingIdleOff",
			UnequippedKitAnimation = "WeaponFistsAlt01FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponFistsAlt01FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponFistsAlt01FloatingIdleOffBonus",
			Image = "Codex_Portrait_FistAlt02",
			UnequipFunctionName = "RemoveFistWeaveBuff",
			-- MaxedTraitDescription = "FistWeaveTrait_Max"
		},
		{
			Costs = { 3, 3, 3, 3, 3 },
			MaxUpgradeLevel = 5,
			GameStateRequirements =
			{
				RequiredTextLines = { "MinotaurRevealsGilgameshAspect01" },
			},
			TraitName = "FistDetonateTrait",
			EquippedKitAnimation = "WeaponFistsAlt03FloatingIdleOff",
			UnequippedKitAnimation = "WeaponFistsAlt03FloatingIdle",
			BonusUnequippedKitAnimation = "WeaponFistsAlt03FloatingIdleBonus",
			BonusEquippedKitAnimation = "WeaponFistsAlt03FloatingIdleOffBonus",
			Image = "Codex_Portrait_FistAlt03",
			UnequipFunctionName = "RemoveFistDetonateDash",
		},
	},
}