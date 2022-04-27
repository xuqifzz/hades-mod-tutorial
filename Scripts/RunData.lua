GameData = GameData or {}

RoomData = RoomData or {}
RoomSetData = RoomSetData or {}

EnemyData = EnemyData or {}
UnitSetData = UnitSetData or {}

Import "WeaponSets.lua"
Import "EncounterSets.lua"
Import "EnemySets.lua"
Import "EnemyAI.lua"
Import "GiftScripts.lua"
Import "RoomEvents.lua"
Import "Interactables.lua"
Import "Objectives.lua"
Import "Powers.lua"
Import "AssistScripts.lua"
Import "ShoutScripts.lua"

Import "GiftData.lua"
Import "TextLineSets.lua"
Import "AudioData.lua"
Import "GameStateFlagData.lua"
Import "KeywordData.lua"
Import "EnemyData.lua"
Import "NPCData.lua"
Import "EncounterData.lua"
Import "RoomData.lua"
Import "RoomDataTartarus.lua"
Import "RoomDataAsphodel.lua"
Import "RoomDataElysium.lua"
Import "RoomDataStyx.lua"
Import "RoomDataSurface.lua"
Import "RoomDataSecrets.lua"
Import "HeroData.lua"
Import "LootData.lua"
Import "MetaUpgradeData.lua"
Import "TraitData.lua"
Import "BoonInfoScreenData.lua"
Import "TraitScripts.lua"
Import "WeaponData.lua"
Import "EnemyUpgradeData.lua"
Import "ConsumableData.lua"
Import "ConditionalItemData.lua"
Import "QuestData.lua"
Import "AchievementData.lua"
Import "RunClearMessageData.lua"
Import "BadgeData.lua"
Import "ObstacleData.lua"
Import "UpgradeChoice.lua"
Import "MetaUpgrades.lua"
Import "ObjectiveData.lua"

Import "DeathLoopData.lua"

GlobalVoiceLines = GlobalVoiceLines or {}

function SetupRunData()

	TextLinesCache = {}

	ProcessDataStore( HeroData )

	local enableConsoleMenus = GetConfigOptionValue({ Name = "EnableConsoleMenus" })

	for roomName, roomData in pairs( RoomData ) do
		roomData.Name = roomName
		ProcessDataInheritance( roomData, RoomData )
		roomData.UseText = roomData.UseText or "UseLeaveRoom"
		if roomData.LegalEncounters ~= nil then
			roomData.LegalEncountersDictionary = {}
			for k, encounterName in pairs( roomData.LegalEncounters ) do
				roomData.LegalEncountersDictionary[encounterName] = true
			end
		end
		if roomData.IllegalEncounters ~= nil then
			roomData.IllegalEncountersDictionary = {}
			for k, encounterName in pairs( room.IllegalEncounters ) do
				roomData.IllegalEncountersDictionary[encounterName] = true
			end
		end
		if enableConsoleMenus and roomData.ZoomFractionSwitch ~= nil then
			roomData.ZoomFraction = roomData.ZoomFractionSwitch
		end
	end
	for roomSetName, roomSetData in pairs( RoomSetData ) do
		for roomName, roomData in pairs( roomSetData ) do
			roomData.RoomSetName = roomSetName
		end
	end

	for deathAreaName, deathAreaData in pairs( DeathLoopData ) do
		deathAreaData.Name = deathAreaName
	end

	for encounterName, encounterData in pairs( EncounterData ) do
		encounterData.Name = encounterName
		ProcessDataInheritance( encounterData, EncounterData )
		if encounterData.Spawns ~= nil then
			if encounterData.RequiredKills == nil then
				encounterData.RequiredKills = {}
				for k, spawnData in pairs( encounterData.Spawns ) do
					if EnemyData[spawnData.Name] ~= nil and EnemyData[spawnData.Name].AppearAfterKilled ~= nil then
						encounterData.RequiredKills[EnemyData[spawnData.Name].AppearAfterKilled] = 1
					end
				end
			end
		end

		if encounterData.EncounterType == nil then
			encounterData.EncounterType = "Default"
		end
	end

	for enemyName, enemyData in pairs( EnemyData ) do
		enemyData.Name = enemyName
		ProcessDataInheritance( enemyData, EnemyData )
		enemyData.UseText = enemyData.UseText or "UseGreetNPC"
		if enemyData.CharacterInteractions ~= nil then
			for interactionName, interactionData in pairs( enemyData.CharacterInteractions ) do
				interactionData.Name = interactionName
			end
		end
		if enemyData.OutgoingDamageModifiers then
			for i, modifierData in pairs(enemyData.OutgoingDamageModifiers) do
				if modifierData.ValidWeapons and not modifierData.ValidWeaponsLookup then
					modifierData.ValidWeaponsLookup = ToLookup( modifierData.ValidWeapons )
				end
			end
		end
		if enemyData.IncomingDamageModifiers then
			for i, modifierData in pairs(enemyData.IncomingDamageModifiers) do
				if modifierData.ValidWeapons then
					modifierData.ValidWeaponsLookup = ToLookup( modifierData.ValidWeapons )
				end
			end
		end
		ProcessTextLines( enemyData.RepeatableTextLineSets )
		ProcessTextLines( enemyData.GiftTextLineSets )
		ProcessTextLines( enemyData.InteractTextLineSets, StatusAnimations.WantsToTalk )
	end

	for traitName, traitData in pairs( TraitData ) do
		traitData.Name = traitName
		ProcessDataInheritance( traitData, TraitData )
		if traitData.PropertyChanges ~= nil then
			for k, propertyChange in pairs( traitData.PropertyChanges ) do
				AddFormattedPercentageChangeValues(propertyChange)
			end
		end
		if traitData.EnemyPropertyChanges ~= nil then
			for k, propertyChange in pairs( traitData.EnemyPropertyChanges ) do
				AddFormattedPercentageChangeValues(propertyChange)
			end
		end
		AddFormattedPercentageChangeValues(traitData)

		if not traitData.ExcludeLinked then
			traitData.LegalOnFireWeapons = AddLinkedWeapons( traitData.LegalOnFireWeapons )
			traitData.LegalOnDamageWeapons = AddLinkedWeapons( traitData.LegalOnDamageWeapons )
			if traitData.DamageOnFireWeapons and not traitData.DamageOnFireWeapons.ExcludeLinked then
				traitData.DamageOnFireWeapons.WeaponNames = AddLinkedWeapons( traitData.DamageOnFireWeapons.WeaponNames )
			end
			if traitData.AddOutgoingDamageModifiers then
				if traitData.AddOutgoingDamageModifiers.ValidWeapons then
					if not traitData.AddOutgoingDamageModifiers.ExcludeLinked then
						traitData.AddOutgoingDamageModifiers.ValidWeapons = AddLinkedWeapons( traitData.AddOutgoingDamageModifiers.ValidWeapons )
					end
					traitData.AddOutgoingDamageModifiers.ValidWeaponsLookup = ToLookup( traitData.AddOutgoingDamageModifiers.ValidWeapons )
				end
				if traitData.AddOutgoingDamageModifiers.ValidEnchantments and not traitData.AddOutgoingDamageModifiers.ExcludeLinked then
					for key, weaponNames in pairs(traitData.AddOutgoingDamageModifiers.ValidEnchantments.TraitDependentWeapons ) do
						traitData.AddOutgoingDamageModifiers.ValidEnchantments.TraitDependentWeapons[key] = AddLinkedWeapons( weaponNames )
					end

					if traitData.AddOutgoingDamageModifiers.ValidEnchantments.ValidWeapons then
						traitData.AddOutgoingDamageModifiers.ValidEnchantments.ValidWeapons = AddLinkedWeapons( traitData.AddOutgoingDamageModifiers.ValidEnchantments.ValidWeapons )
					end
				end
				if traitData.AddOutgoingDamageModifiers.EmptySlotValidData then
					for key, weaponNames in pairs(traitData.AddOutgoingDamageModifiers.EmptySlotValidData) do
						traitData.AddOutgoingDamageModifiers.EmptySlotValidData[key] = AddLinkedWeapons( weaponNames )
					end
				end

			end
		end

		if traitData.WeaponDataOverride then
			for weaponName, weaponData in pairs(traitData.WeaponDataOverride) do

				if weaponData.Sounds ~= nil and weaponData.Sounds.ChargeSounds ~= nil then
					for k, soundElement in pairs( weaponData.Sounds.ChargeSounds ) do
						if soundElement.StoppedBy ~= nil then
							soundElement.StoppedByLookup = soundElement.StoppedByLookup or {}
							for k, eventName in pairs( soundElement.StoppedBy ) do
								soundElement.StoppedByLookup[eventName] = true
							end
						end
					end
				end
			end
		end
	end

	for lootName, lootData in pairs( LootData ) do
		lootData.Name = lootName
		ProcessDataInheritance( lootData, LootData )
		lootData.UseText = lootData.UseText or "UseRoomLoot"
		lootData.MythmakeUseText = lootData.MythmakeUseText or "UseRoomLoot_MythmakeAvailable"
		if lootData.PropertyChanges ~= nil then
			for k, propertyChange in pairs( lootData.PropertyChanges ) do
				AddFormattedPercentageChangeValues(propertyChange)
			end
		end

		local traitDictionary = {}
		BoonInfoScreenData.TraitDictionary[lootName] = {}
		if lootData.WeaponUpgrades ~= nil then
			for i, traitName in pairs (lootData.WeaponUpgrades) do
				traitDictionary[traitName] = true
				BoonInfoScreenData.TraitDictionary[lootName][traitName] = true
			end
		end
		if lootData.Traits ~= nil then
			for i, traitName in pairs (lootData.Traits) do
				traitDictionary[traitName] = true
				BoonInfoScreenData.TraitDictionary[lootName][traitName] = true
			end
		end
		if lootData.PermanentTraits ~= nil then
			for i, traitName in pairs (lootData.PermanentTraits) do
				traitDictionary[traitName] = true
				BoonInfoScreenData.TraitDictionary[lootName][traitName] = true
			end
		end
		if lootData.TemporaryTraits ~= nil then
			for i, traitName in pairs (lootData.TemporaryTraits) do
				traitDictionary[traitName] = true
				BoonInfoScreenData.TraitDictionary[lootName][traitName] = true
			end
		end
		if lootData.LinkedUpgrades ~= nil then
			for traitName, linkedData in pairs (lootData.LinkedUpgrades) do
				traitDictionary[traitName] = true
				BoonInfoScreenData.TraitDictionary[lootName][traitName] = true
				-- Process type of link
				BoonInfoScreenData.TraitRequirementsDictionary[traitName] = DeepCopyTable( linkedData )
				if linkedData.OneOf then
					BoonInfoScreenData.TraitRequirementsDictionary[traitName].Type = "OneOf"
				elseif linkedData.OneFromEachSet then
					BoonInfoScreenData.TraitRequirementsDictionary[traitName].Type = "OneFromEachSet"
					if TableLength(linkedData.OneFromEachSet) == 3 and #(linkedData.OneFromEachSet[1]) == #(linkedData.OneFromEachSet[2]) and #(linkedData.OneFromEachSet[2]) == #(linkedData.OneFromEachSet[3]) then
						BoonInfoScreenData.TraitRequirementsDictionary[traitName].Type = "TwoOf"
					end
				end
			end
		end
		if lootData.Consumables ~= nil then
			for i, consumableName in pairs( lootData.Consumables ) do 
				BoonInfoScreenData.TraitDictionary[lootName][consumableName] = true
			end
		end
		lootData.TraitIndex = traitDictionary
		ProcessTextLines( lootData.DuoPickupTextLineSets )
		ProcessTextLines( lootData.SuperPriorityPickupTextLineSets )
		ProcessTextLines( lootData.PriorityPickupTextLineSets )
		ProcessTextLines( lootData.PickupTextLineSets )
		ProcessTextLines( lootData.RejectionTextLines )
		ProcessTextLines( lootData.MakeUpTextLines )
		ProcessTextLines( lootData.BoughtTextLines )
		ProcessTextLines( lootData.GiftTextLineSets )
	end

	for consumableName, consumableData in pairs( ConsumableData ) do
		consumableData.Name = consumableName
		ProcessDataInheritance( consumableData, ConsumableData )
		consumableData.UseText = consumableData.UseText or "UseConsumable"
		AddFormattedPercentageChangeValues(consumableData, "HealFraction")
	end

	ProcessDataStore( ConditionalItemData )
	ProcessDataStore( QuestData )
	ProcessDataStore( MusicPlayerTrackData )
	ProcessDataStore( GameData.RunClearMessageData )
	ProcessDataStore( ScreenData )

	for obstacleName, obstacleData in pairs( ObstacleData ) do
		obstacleData.Name = obstacleName
		ProcessDataInheritance( obstacleData, ObstacleData )
		obstacleData.UseText = obstacleData.UseText or "InGameUI_Use"

		if obstacleData.Material == nil then
			for nameFragment, material in pairs( MaterialDefaults ) do
				if string.match( obstacleName, nameFragment ) then
					obstacleData.Material = material
					break
				end
			end
		end

	end

	for upgradeName, upgradeData in pairs( MetaUpgradeData ) do
		upgradeData.Name = upgradeName
		ProcessDataInheritance( upgradeData, MetaUpgradeData )
		if upgradeData.PropertyChanges ~= nil then
			for k, propertyChange in pairs( upgradeData.PropertyChanges ) do
				AddFormattedPercentageChangeValues(propertyChange)
			end
		end

		if upgradeData.AddOutgoingDamageModifiers and upgradeData.AddOutgoingDamageModifiers.ValidWeapons and not upgradeData.AddOutgoingDamageModifiers.ExcludeLinked then
			upgradeData.AddOutgoingDamageModifiers.ValidWeapons = AddLinkedWeapons( upgradeData.AddOutgoingDamageModifiers.ValidWeapons )
		end
		AddFormattedPercentageChangeValues(upgradeData)
	end

	for weaponName, weaponData in pairs( WeaponData ) do
		weaponData.Name = weaponName
		ProcessDataInheritance( weaponData, WeaponData )
		if weaponData.Upgrades ~= nil then
			for upgradeName, upgradeData in pairs( weaponData.Upgrades ) do
				upgradeData.Name = upgradeName
				upgradeData.OwnerName = weaponName
			end
		end
		if weaponData.Sounds ~= nil and weaponData.Sounds.ChargeSounds ~= nil then
			for k, soundElement in pairs( weaponData.Sounds.ChargeSounds ) do
				if soundElement.StoppedBy ~= nil then
					soundElement.StoppedByLookup = soundElement.StoppedByLookup or {}
					for k, eventName in pairs( soundElement.StoppedBy ) do
						soundElement.StoppedByLookup[eventName] = true
					end
				end
			end
		end
		ObjectiveData[weaponName] = { } -- automatically generate an objective for each weapon
	end

	for projectileName, projectileData in pairs( ProjectileData ) do
		projectileData.Name = projectileName
		ProcessDataInheritance( projectileData, ProjectileData )
	end

	for effectName, effectData in pairs( EffectData ) do
		effectData.Name = effectName
		ProcessDataInheritance( effectData, EffectData)
	end
	-- Pre-create links back as well
	for weaponName, weaponLinks in pairs( WeaponSets.LinkedWeaponUpgrades ) do
		for k, weaponLink in pairs( weaponLinks ) do
			WeaponData[weaponLink].LinkedUpgrades = weaponName
		end
	end

	for upgradeName, upgradeData in pairs( EnemyUpgradeData ) do
		upgradeData.Name = upgradeName
		ProcessDataInheritance( upgradeData, EnemyUpgradeData )
		if upgradeData.PropertyChanges ~= nil then
			for k, propertyChange in pairs( upgradeData.PropertyChanges ) do
				AddFormattedPercentageChangeValues(propertyChange)
			end
		end
		AddFormattedPercentageChangeValues(upgradeData, "MoneyMultiplier")
		AddFormattedPercentageChangeValues(upgradeData, "MetaPointMultiplier")
		AddFormattedPercentageChangeValues(upgradeData, "MythPointMultiplier")
	end

	for objectiveSetName, objectiveSetData in pairs( ObjectiveSetData ) do
		objectiveSetData.Name = objectiveSetName
		ProcessDataInheritance( objectiveSetData, ObjectiveSetData )
	end

	for objectiveName, objectiveData in pairs( ObjectiveData ) do
		objectiveData.Name = objectiveName
		ProcessDataInheritance( objectiveData, ObjectiveData )
		if objectiveData.Description == nil then
			objectiveData.Description = "Objective_"..objectiveName
		end
	end

	ProcessDataStore( GiftData )

	GiftOrderingReverseLookup = {}
	for index, name in pairs(GiftOrdering) do
		GiftOrderingReverseLookup[name] = index
	end
	
	BoonInfoScreenData.SortedTraitIndex = {}
	for i, lootName in ipairs(BoonInfoScreenData.Ordering) do
		BoonInfoScreenData.SortedTraitIndex[lootName] = {}		
		if BoonInfoScreenData.TraitDictionary[lootName] then
			BoonInfoScreenData.SortedTraitIndex[lootName] = GetAllKeys( BoonInfoScreenData.TraitDictionary[lootName] )
			table.sort( BoonInfoScreenData.SortedTraitIndex[lootName], BoonInfoSort )
			BoonInfoScreenData.TraitDictionary[lootName] = nil
		end
	end

	for k, textLineHolder in pairs( GlobalTextLines ) do
		if textLineHolder.InteractTextLineSets ~= nil then
			for textLinesName, textLines in pairs( textLineHolder.InteractTextLineSets ) do
				textLines.Name = textLinesName
			end
		end
	end

	for name, data in pairs( FishingData.FishValues ) do
		data.Name = name
		ProcessDataInheritance( data, FishingData.FishValues )
	end

	for name, data in pairs( GameData.BadgeData ) do
		data.Name = name
		ProcessDataInheritance( data, GameData.BadgeData )
	end

	ResetKeywords()

	ValidateOrderData( QuestData, QuestOrderData )
	ValidateOrderData( MusicPlayerTrackData, MusicPlayerTrackOrderData )

end

function ResetKeywords()
	Keywords = Keywords or {}
	for k, keyword in pairs( KeywordList ) do
		Keywords[keyword] = keyword
	end
end

function AddLinkedWeapons(weaponData)
	if weaponData == nil then
		return
	end
	local output = {}

	for i, weaponName in pairs(weaponData) do
		output[ weaponName ] = true
		if WeaponSets.LinkedWeaponUpgrades[weaponName] ~= nil then
			for s, linkedWeaponName in pairs(WeaponSets.LinkedWeaponUpgrades[weaponName]) do
				output[ linkedWeaponName ] = true
			end
		end
	end
	return GetAllKeys( output )
end

function AddFormattedPercentageChangeValues(table, key)
	if key == nil then
		key = "ChangeValue"
	end
	if table == nil or table[key] == nil or type(table[key]) ~= "number" then
		return
	end
	table[key.."Percent"] = round( table[key] * 100 )
	table[key.."PercentDelta"] = round((table[key] - 1) * 100)
	table[key.."NegativePercentDelta"] = -1 * round((table[key] - 1) * 100)
end

local inheritanceIgnores =
{
	"DebugOnly",
}

function ProcessDataStore( dataStore )
	if dataStore == nil then
		return
	end
	for name, data in pairs( dataStore ) do
		data.Name = name
		ProcessDataInheritance( data, dataStore )
	end
end

function ProcessDataInheritance( data, dataStore )

	if data.InheritFrom == nil then
		return
	end

	local originalValues = {}
	for k, ignoreKey in pairs( inheritanceIgnores ) do
		originalValues[ignoreKey] = data[ignoreKey]
	end

	for k, inheritFromName in ipairs( data.InheritFrom ) do
		local parentData = dataStore[inheritFromName]
		if parentData ~= nil then
			ProcessDataInheritance( parentData, dataStore )
			DeepInheritData( data, parentData )
		end
	end

	for k, ignoreKey in pairs( inheritanceIgnores ) do
		data[ignoreKey] = originalValues[ignoreKey]
	end

end

function DeepInheritData( data, parentData )

	for parentKey, parentValue in pairs( parentData ) do
		if data[parentKey] == nil then
			if type(parentValue) == "table" then
				data[parentKey] = DeepCopyTable( parentValue )
			else
				data[parentKey] = parentValue
			end
		elseif type(parentValue) == "table" and parentValue.DeepInheritance then
			DeepInheritData( data[parentKey], parentValue )
		end
	end

end

function ProcessDirecetInheritance( data, parentData )

	if parentData == nil then
		return
	end

	local originalValues = {}
	for k, ignoreKey in pairs( inheritanceIgnores ) do
		originalValues[ignoreKey] = data[ignoreKey]
	end

	for parentKey, parentValue in pairs( parentData ) do
		if data[parentKey] == nil then
			if type(parentValue) == "table" then
				data[parentKey] = DeepCopyTable( parentValue )
			else
				data[parentKey] = parentValue
			end
		end
	end

	for k, ignoreKey in pairs( inheritanceIgnores ) do
		data[ignoreKey] = originalValues[ignoreKey]
	end

end

function ProcessTextLines( textLineSet, defaultStatusAnimation )

	if textLineSet ~= nil then
		for textLinesName, textLines in pairs( textLineSet ) do
			textLines.Name = textLinesName
			TextLinesCache[textLines.Name] = textLines
			if textLines.StatusAnimation == nil then
				textLines.StatusAnimation = defaultStatusAnimation
			end
		end
	end
end

function BoonInfoSort( itemA, itemB )
	local traitA = TraitData[itemA] or ConsumableData[itemA]
	local traitB = TraitData[itemB] or ConsumableData[itemB]
	local slotToInt = 
		function( trait )
			if trait ~= nil then
				local slotType = trait.Slot

				if slotType == "Melee" then
					return 0
				elseif slotType == "Secondary" then
					return 1
				elseif slotType == "Ranged" then
					return 2
				elseif slotType == "Rush" then
					return 3
				elseif slotType == "Shout" then
					return 4
				end

				if BoonInfoScreenData.TraitRequirementsDictionary[trait.Name] then
					return 99
				end
			end
			
			return 5
		end
	local rarityToInt = 
		function ( trait )
			if trait ~= nil then
				if trait.IsDuoBoon then
					return 4
				elseif trait.RarityLevels and trait.RarityLevels.Legendary and not Contains( trait.InheritFrom, "ChaosBlessingTrait" ) then
					return 3
				end
				return 1
			else
				return 2
			end
		end
		
	local weaponToInt = 
		function ( trait )
			if trait ~= nil then
				local value = 99
				if trait.RequiredWeapon == "SwordWeapon" or Contains(trait.RequiredWeapons, "SwordWeapon") then
					value = 0
				elseif trait.RequiredWeapon == "BowWeapon" or Contains(trait.RequiredWeapons, "BowWeapon") then
					value = 10
				elseif trait.RequiredWeapon == "BowSplitShot" or Contains(trait.RequiredWeapons, "BowSplitShot") then
					value = 11
				elseif trait.RequiredWeapon == "ShieldWeapon" or Contains(trait.RequiredWeapons, "ShieldWeapon") then
					value = 20
				elseif trait.RequiredWeapon == "SpearWeapon" or Contains(trait.RequiredWeapons, "SpearWeapon") then
					value = 30
				elseif trait.RequiredWeapon == "SpearWeaponThrow" or Contains(trait.RequiredWeapons, "SpearWeaponThrow") then
					value = 31
				elseif trait.RequiredWeapon == "GunWeapon" or Contains(trait.RequiredWeapons, "GunWeapon") then
					value = 40
				elseif trait.RequiredWeapon == "FistWeapon" or Contains(trait.RequiredWeapons, "FistWeapon") then
					value = 50
				end
				if trait.RequiredTrait then
					value = value + 2
				end
				return value
			end
			return 99
		end
		
	local chaosToInt = 
		function ( trait )
			if trait ~= nil then
				if trait.RarityLevels and trait.RarityLevels.Legendary then
					return 2
				end
				if Contains( trait.InheritFrom, "ChaosBlessingTrait" ) then
					return 1
				elseif Contains( trait.InheritFrom, "ChaosCurseTrait" ) then
					return 3
				end
			end
			return 99
		end
	if slotToInt(traitA) ~= slotToInt(traitB) then
		return slotToInt(traitA) < slotToInt(traitB)
	end
	if rarityToInt(traitA) ~= rarityToInt(traitB) then
		return rarityToInt(traitA) < rarityToInt(traitB)
	end
	if weaponToInt(traitA) ~= weaponToInt(traitB) then
		return weaponToInt(traitA) < weaponToInt(traitB)
	end
	if chaosToInt(traitA) ~= chaosToInt(traitB) then
		return chaosToInt(traitA) < chaosToInt(traitB)
	end
	
	if traitA.Name ~= traitB.Name then
		return traitA.Name < traitB.Name
	end
	return false
end

SetupRunData()