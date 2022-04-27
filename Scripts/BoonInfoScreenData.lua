BoonInfoScreenData = 
{
	NumPerPage = 4,
	Ordering = 
	{
		"AthenaUpgrade",
		"ZeusUpgrade",
		"AresUpgrade",
		"ArtemisUpgrade",
		"AphroditeUpgrade",
		"DionysusUpgrade",
		"PoseidonUpgrade",
		"DemeterUpgrade",
		"HermesUpgrade",
		"TrialUpgrade",
	},
	TextBoxOffsetY = -25,
	DecriptionBoxOffsetY = -30,
	ButtonStartY = -125,
	ButtonYSpacer = 190,
	RequirementsYSpacer = 30,
	HiddenTraitData = 
	{
		SwordConsecrationTrait = {	RequiredTextLines = { "NyxRevealsArthurAspect01" },},
		SpearSpinTravel = {	RequiredTextLines = { "AchillesRevealsGuanYuAspect01" },},
		GunLoadedGrenadeTrait = {	RequiredTextLines = { "ZeusRevealsLuciferAspect01" },},
		BowBondTrait = {	RequiredTextLines = { "ArtemisRevealsRamaAspect01" },},
		ShieldLoadAmmoTrait = {	RequiredTextLines = { "ChaosRevealsBeowulfAspect01" },},
		-- TBD, needs to match in WeaponUpgradeData
		FistDetonateTrait = {	RequiredTextLines = {  },},
	},

	TraitDictionary = {}, -- Populated in RunData
	SortedTraitIndex = {}, -- Populated in RunData
	TraitRequirementsDictionary = {} -- Populated in RunData

}