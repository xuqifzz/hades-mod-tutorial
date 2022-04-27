function ApplyWeaponPropertyChanges( unit, weaponName, propertyChanges, reverse )

	if propertyChanges == nil then
		return
	end
	for k, propertyChange in ipairs( propertyChanges ) do

		local weaponPropertyName = weaponName
		if propertyChange.WeaponName ~= nil then
			weaponPropertyName = propertyChange.WeaponName
		end
		ApplyWeaponPropertyChange( unit, weaponPropertyName, propertyChange, reverse )

	end
end

function ApplyWeaponPropertyChange( unit, weaponName, propertyChange, reverse )

	if propertyChange.LegalWeapons ~= nil then
		if not Contains( propertyChange.LegalWeapons, weaponName ) then
			return
		end
	end

	if propertyChange.LegalWeapon ~= nil then
		if propertyChange.LegalWeapon ~= weaponName then
			return
		end
	end

	if propertyChange.LegalUnits ~= nil then
		if not Contains( propertyChange.LegalUnits, unit.Name ) then
			return
		end
	end

	local changeValue = propertyChange.ChangeValue
	if reverse then
		if propertyChange.ChangeType == "Multiply" then
			changeValue = 1 / changeValue
		elseif propertyChange.ChangeType == "Add" then
			changeValue = 0 - changeValue
		elseif type(changeValue) == "boolean" then
			changeValue = not changeValue
		else
			return
		end
	end

	if propertyChange.WeaponProperty ~= nil then
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = unit.ObjectId, Property = propertyChange.WeaponProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType })
		if propertyChange.WeaponProperty == "MaxAmmo" then

			if weaponName == "GunWeapon" then
				thread( UpdateGunUI )
			elseif weaponName == "RangedWeapon" then
				if propertyChange.ChangeType == "Add" and changeValue > 0 then
					RunWeaponMethod({ Id = unit.ObjectId, Weapon = "RangedWeapon", Method = "AddAmmo", Parameters = { math.ceil(changeValue) } })
				end
				thread( UpdateAmmoUI )
			end
		end
		if propertyChange.WeaponProperty == "ClipSize" then
			RunWeaponMethod({ Id = unit.ObjectId, Weapon = "RushWeapon", Method = "forceReload" })
		end
		if propertyChange.WeaponProperty == "ChargeTime" then
			RunWeaponMethod({ Id = unit.ObjectId, Weapon = weaponName, Method = "cancelCharge" })
		end
	end
	if propertyChange.ProjectileProperty ~= nil then
		SetProjectileProperty({ WeaponName = weaponName, ProjectileName = propertyChange.ProjectileName, ExcludeProjectileName = propertyChange.ExcludeProjectileName, DestinationId = unit.ObjectId, Property = propertyChange.ProjectileProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType })
	end
	if propertyChange.EffectProperty ~= nil then
		SetEffectProperty({ WeaponName = weaponName, EffectName = propertyChange.EffectName, DestinationId = unit.ObjectId, Property = propertyChange.EffectProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType })
	end

	local linkedWeapons = WeaponSets.LinkedWeaponUpgrades[weaponName]
	if linkedWeapons and not propertyChange.ExcludeLinked then
		for k, linkedWeaponName in pairs( linkedWeapons ) do
			--DebugPrint({ Text = "Applying linked upgrade to "..linkedWeaponName, LogOnly = true })
			ApplyWeaponPropertyChange( unit, linkedWeaponName, propertyChange, reverse )
		end
	end
end

function AddEnemyOnDeathWeapons(unit, newWeaponProperties)
	for k, newWeaponProperty in ipairs( newWeaponProperties ) do
		if newWeaponProperty.LegalUnits ~= nil then
			if not Contains( newWeaponProperty.LegalUnits, unit.Name ) then
				return
			end
		end

		if newWeaponProperty.Weapon ~= nil then
			AddOnDeathWeapon(unit, newWeaponProperty.Weapon)
		end
	end
end

function ApplyUnitPropertyChanges( unit, propertyChanges, applyLuaUpgrades, reverse )

	if propertyChanges == nil then
		return
	end

	for k, propertyChange in ipairs( propertyChanges ) do
		ApplyUnitPropertyChange( unit, propertyChange, applyLuaUpgrades, reverse )
	end
end

function ApplyUnitPropertyChange( unit, propertyChange, applyLuaUpgrades, reverse )
	if propertyChange.LegalUnits ~= nil then
		if not Contains( propertyChange.LegalUnits, unit.Name ) then
			return
		end
	elseif unit.SkipModifiers then
		return
	end

	if propertyChange.TraitName ~= nil then
		if not HeroHasTrait(propertyChange.TraitName) then
			return
		end
	end

	local changeValue = propertyChange.ChangeValue
	if reverse then
		if type(changeValue) == "number" then
			if propertyChange.ChangeType == "Multiply" then
				changeValue = 1 / changeValue
			elseif propertyChange.ChangeType == "Add" then
				changeValue = 0 - changeValue
			end
		elseif type(changeValue) == "boolean" then
			changeValue = not changeValue
		else
			return
		end
	end

	if propertyChange.ThingProperty ~= nil then
		SetThingProperty({ DestinationId = unit.ObjectId, Property = propertyChange.ThingProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType })
	end
	if propertyChange.LifeProperty ~= nil then
		ApplyLifePropertyChange( unit, propertyChange, changeValue )
	end
	if propertyChange.UnitProperty ~= nil then
		SetUnitProperty({ DestinationId = unit.ObjectId, Property = propertyChange.UnitProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType })
	end

	if applyLuaUpgrades and propertyChange.LuaProperty ~= nil and ( unit[propertyChange.LuaProperty] ~= nil or propertyChange.ChangeType == "Absolute" ) then
		local delta = nil
		if propertyChange.LuaProperty == "MaxHealth" and propertyChange.MaintainDelta and unit.Health ~= nil and unit.MaxHealth ~= nil then
			delta = changeValue
		end

		if propertyChange.LuaTable ~= nil then
			if propertyChange.ChangeType == "Absolute" then
				unit[propertyChange.LuaTable][propertyChange.LuaProperty] = changeValue
			elseif propertyChange.ChangeType == "Multiply" then
				unit[propertyChange.LuaTable][propertyChange.LuaProperty] = unit[propertyChange.LuaTable][propertyChange.LuaProperty] * changeValue
			elseif propertyChange.ChangeType == "Add" then
				unit[propertyChange.LuaTable][propertyChange.LuaProperty] = unit[propertyChange.LuaTable][propertyChange.LuaProperty] + changeValue
			elseif type(changeValue) == "boolean" then
				unit[propertyChange.LuaTable][propertyChange.LuaProperty] = not unit[propertyChange.LuaTable][propertyChange.LuaProperty]
			end
		else
			if propertyChange.ChangeType == "Absolute" then
				unit[propertyChange.LuaProperty] = changeValue
			elseif propertyChange.ChangeType == "Multiply" then
				unit[propertyChange.LuaProperty] = unit[propertyChange.LuaProperty] * changeValue
			elseif propertyChange.ChangeType == "Add" then
				unit[propertyChange.LuaProperty] = unit[propertyChange.LuaProperty] + changeValue
			elseif type(changeValue) == "boolean" then
				unit[propertyChange.LuaProperty] = not unit[propertyChange.LuaProperty]
			end
		end

		if propertyChange.LuaProperty == "MaxHealth" then
			if ( changeValue < 0 and propertyChange.ChangeType == "Add" ) or ( propertyChange.ChangeType == "Multiply" and changeValue < 1 ) then
				local currentHealth = unit.Health
				local maxHealth = unit.MaxHealth
				if currentHealth ~= nil and maxHealth ~= nil then

					if propertyChange.MaintainDelta then
						if propertyChange.ChangeType == "Add" then
							if delta < 0 then
								Damage( unit, { DamageAmount = math.abs(delta), MinHealth = 1, Silent = true, PureDamage = true } )
							else
								Heal( unit, { HealAmount = delta, SourceName = "MaxLifeChange", Silent = true})
							end
							currentHealth = math.max( 1, currentHealth + delta )
						else
							currentHealth = currentHealth * changeValue
							Damage( unit, { DamageAmount = math.abs(unit.Health - currentHealth), MinHealth = 1, Silent = true, PureDamage = true } )
						end
					end

					if currentHealth > maxHealth then
						unit.Health = maxHealth
					end
				end
			elseif not propertyChange.BlockHealing then
				if ( changeValue > 0 and propertyChange.ChangeType == "Add" ) then
					Heal( unit, { HealAmount = changeValue, Silent = true })
				elseif ( changeValue > 1 and propertyChange.ChangeType == "Multiply" ) then
					local currentHealth = unit.Health
					if currentHealth ~= nil then
						Heal( unit, { HealAmount = currentHealth * (changeValue - 1), Silent = true })
					end
				end
			end
		end
		if propertyChange.LuaProperty == "MaxHealth" or propertyChange.LuaProperty == "Health" then
			ValidateMaxHealth( propertyChange.BlockHealing )
			thread( UpdateHealthUI )
		end
		if propertyChange.LuaProperty == "SuperMeterLimit" or propertyChange.LuaProperty == "SuperCost" then
			DestroySuperMeter()
			ShowSuperMeter()
		end
	end

	if propertyChange.WeaponName ~= nil then
		ApplyWeaponPropertyChange( unit, propertyChange.WeaponName, propertyChange, reverse)
	end

	if propertyChange.WeaponNames ~= nil then
		for k, weaponName in pairs( propertyChange.WeaponNames ) do
			ApplyWeaponPropertyChange( unit, weaponName, propertyChange, reverse)
		end
	end

end

function ApplyLifePropertyChange( unit, propertyChange, changeValue )
	SetLifeProperty({ DestinationId = unit.ObjectId, Property = propertyChange.LifeProperty, Value = changeValue, ValueChangeType = propertyChange.ChangeType, DataValue = propertyChange.DataValue })
end

function ApplyAllTraitWeapons( hero )
	for k, traitData in pairs( hero.Traits ) do
		EquipSpecialWeapons( hero, traitData )
		AddAssistWeapons( hero, traitData )
		for weaponName, v in pairs( hero.Weapons ) do
			AddWallSlamWeapons( hero, traitData )
			AddOnDamageWeapons( hero, weaponName, traitData)
			AddOnFireWeapons( hero, weaponName, traitData)
		end
	end
end

function AddWallSlamWeapons( hero, traitData )
	if traitData.AddOnSlamWeapons == nil then
		return
	end

	if hero.OnSlamWeapons == nil then
		hero.OnSlamWeapons = {}
	end
	hero.OnSlamWeapons = MergeTables( hero.OnSlamWeapons, traitData.AddOnSlamWeapons )
end

function RemoveWallSlamWeapons( hero, traitData )
	if hero.OnSlamWeapons == nil or traitData.AddOnSlamWeapons == nil then
		return
	end
	for i, weaponName in pairs( traitData.AddOnSlamWeapons ) do
		RemoveValue( hero.OnSlamWeapons, weaponName )
	end
end

function AddOnDamageWeapons( hero, weaponName, upgradeData )
	if upgradeData.AddOnDamageWeapons == nil then
		return
	end

	if upgradeData.LegalOnDamageWeapons == nil or Contains( upgradeData.LegalOnDamageWeapons, weaponName ) then
		for k, onDamageWeapon in pairs( upgradeData.AddOnDamageWeapons ) do
			if hero.OnDamageWeapons == nil then
				hero.OnDamageWeapons = {}
			end
			if hero.OnDamageWeapons[weaponName] == nil then
				hero.OnDamageWeapons[weaponName] = {}
			end
			if not hero.OnDamageWeapons[weaponName][onDamageWeapon] then
				hero.OnDamageWeapons[weaponName][onDamageWeapon] = upgradeData.OnDamageWeaponProperties or true
			end
		end
		local linkedWeapon = GetWeaponDataValue({ Id = hero.ObjectId, WeaponName = weaponName, Property = "PostFireWeapon" })
		if linkedWeapon ~= nil then
			AddOnDamageWeapons( hero, linkedWeapon, upgradeData )
		end
	end

	local linkedWeapons = WeaponSets.LinkedWeaponUpgrades[weaponName]
	if linkedWeapons then
		for k, linkedWeaponName in pairs( linkedWeapons ) do
			AddOnDamageWeapons( hero, linkedWeaponName, upgradeData )
		end
	end
end

function RemoveOnDamageWeapons( hero, weaponName, upgradeData )
	if upgradeData.AddOnDamageWeapons == nil or hero.OnDamageWeapons == nil then
		return
	end

	if upgradeData.LegalOnDamageWeapons == nil or Contains( upgradeData.LegalOnDamageWeapons, weaponName ) then
		for k, onDamageWeapon in pairs( upgradeData.AddOnDamageWeapons ) do
			if hero.OnDamageWeapons[weaponName] ~= nil then
				hero.OnDamageWeapons[weaponName] = {}
			end
		end
		local linkedWeapon = GetWeaponDataValue({ Id = hero.ObjectId, WeaponName = weaponName, Property = "PostFireWeapon" })
		if linkedWeapon ~= nil then
			RemoveOnDamageWeapons( hero, linkedWeapon, upgradeData )
		end
	end

	local linkedWeapons = WeaponSets.LinkedWeaponUpgrades[weaponName]
	if linkedWeapons then
		for k, linkedWeaponName in pairs( linkedWeapons ) do
			RemoveOnDamageWeapons( hero, linkedWeaponName, upgradeData )
		end
	end
end

function AddOnFireWeapons( hero, weaponName, upgradeData )
	if upgradeData.AddOnFireWeapons == nil then
		return
	end

	for k, onFireWeapon in pairs( upgradeData.AddOnFireWeapons ) do
		if hero.OnFireWeapons == nil then
			hero.OnFireWeapons = {}
		end
		if hero.OnFireWeapons[weaponName] == nil then
			hero.OnFireWeapons[weaponName] = {}
		end
		if not hero.OnFireWeapons[weaponName][onFireWeapon] and Contains( upgradeData.LegalOnFireWeapons, weaponName ) then
			if upgradeData.AddOnFireWeaponArgs then
				hero.OnFireWeapons[weaponName][onFireWeapon] = DeepCopyTable( upgradeData.AddOnFireWeaponArgs )
			else
				hero.OnFireWeapons[weaponName][onFireWeapon] = true
			end
		end
	end
	local linkedWeapon = GetWeaponDataValue({ Id = hero.ObjectId, WeaponName = weaponName, Property = "PostFireWeapon" })
	if linkedWeapon ~= nil then
		AddOnFireWeapons( hero, linkedWeapon, upgradeData )
	end

	local linkedWeapons = WeaponSets.LinkedWeaponUpgrades[weaponName]
	if linkedWeapons then
		for k, linkedWeaponName in pairs( linkedWeapons ) do
			AddOnFireWeapons( hero, linkedWeaponName, upgradeData )
		end
	end
end

function RemoveOnFireWeapons( hero, upgradeData )
	if upgradeData.AddOnFireWeapons == nil then
		return
	end

	if hero.OnFireWeapons == nil then
		hero.OnFireWeapons = {}
	end
	for k, weaponName in pairs( upgradeData.LegalOnFireWeapons ) do
		hero.OnFireWeapons[weaponName] = nil


		local linkedWeapon = GetWeaponDataValue({ Id = hero.ObjectId, WeaponName = weaponName, Property = "PostFireWeapon" })
		if linkedWeapon ~= nil then
			hero.OnFireWeapons[linkedWeapon] = nil
		end

		local linkedWeapons = WeaponSets.LinkedWeaponUpgrades[weaponName]
		if linkedWeapons then
			for k, linkedWeaponName in pairs( linkedWeapons ) do
				hero.OnFireWeapons[linkedWeaponName] = nil
			end
		end
	end
end

function AddOnHitWeapons( hero, upgradeData )
	if upgradeData.AddOnHitWeapons == nil then
		return
	end

	if upgradeData.AddOnHitWeapons ~= nil then
		if hero.OnHitWeapons == nil then
			hero.OnHitWeapons = {}
		end
		for k, onHitWeaponName in pairs( upgradeData.AddOnHitWeapons ) do
			hero.OnHitWeapons[onHitWeaponName] = upgradeData.OnHitWeaponProperties or true
		end
	end
end

function RemoveOnHitWeapons( hero, upgradeData )
	if upgradeData.AddOnHitWeapons == nil then
		return
	end
	if upgradeData.AddOnHitWeapons ~= nil then
		if hero.OnHitWeapons == nil then
			hero.OnHitWeapons = {}
		end
		for k, onHitWeaponName in pairs( upgradeData.AddOnHitWeapons ) do
			hero.OnHitWeapons[onHitWeaponName] = nil
		end
	end
end

function AddOnDeathWeapon( unit, weaponName )
	if weaponName == nil then
		return
	end

	if unit.OnDeathWeapons == nil then
		unit.OnDeathWeapons = {}
	end
	unit.OnDeathWeapons[weaponName] = true
end

function RemoveOnDeathWeapons( unit )
	unit.OnDeathWeapons = nil
end

function ApplyMetaUpgrades( hero, applyLuaUpgrades )
	local hasBeenApplied = {}
	for upgradeName in pairs( CurrentRun.MetaUpgrades or GameState.MetaUpgrades ) do
		local upgradeData = MetaUpgradeData[upgradeName]
		if upgradeData ~= nil then
			for i = 1, GetNumMetaUpgrades(upgradeName) do
				ApplyMetaUpgrade( upgradeData, applyLuaUpgrades, hasBeenApplied[upgradeName] == nil )
				hasBeenApplied[upgradeName] = true
			end
		end
	end
end

function ReapplyWeaponSwitchMetaUpgrades()
	local hasBeenApplied = {}
	for upgradeName in pairs( CurrentRun.MetaUpgrades or GameState.MetaUpgrades ) do
		local upgradeData = MetaUpgradeData[upgradeName]
		if upgradeData ~= nil and upgradeData.ReapplyOnWeaponSwitch then
			for i = 1, GetNumMetaUpgrades(upgradeName) do
				ApplyMetaUpgrade( upgradeData, applyLuaUpgrades, hasBeenApplied[upgradeName] == nil )
				hasBeenApplied[upgradeName] = true
			end
		end
	end
end

function ApplyMetaUpgrade( upgradeData, applyLuaUpgrade, firstApplied, reverse )

	if upgradeData.OnDuplicatePropertyChanges == nil or firstApplied then
		if upgradeData.PreEquipWeapon then
			EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = upgradeData.PreEquipWeapon })
		end
		ApplyUnitPropertyChanges( CurrentRun.Hero, upgradeData.PropertyChanges, applyLuaUpgrade, reverse )
	else
		ApplyUnitPropertyChanges( CurrentRun.Hero, upgradeData.OnDuplicatePropertyChanges, applyLuaUpgrade, reverse )
	end

	if applyLuaUpgrade and upgradeData.AddOutgoingDamageModifiers then
		if CurrentRun.Hero.OutgoingDamageModifiers == nil then
			CurrentRun.Hero.OutgoingDamageModifiers = {}
		end
		if reverse then
			for i, modifier in pairs(CurrentRun.Hero.OutgoingDamageModifiers) do
				if modifier.Name == upgradeData.Name then
					CurrentRun.Hero.OutgoingDamageModifiers[i] = nil
					break
				end
			end
		else

			local data = DeepCopyTable( upgradeData.AddOutgoingDamageModifiers )
			data.Name = upgradeData.Name
			table.insert( CurrentRun.Hero.OutgoingDamageModifiers, data )
		end
	end

	if not IsScreenOpen("MetaUpgrade") then
		if upgradeData.KeywordOverride then
			local keywordData = upgradeData.KeywordOverride
			Keywords[keywordData.Key] = keywordData.Value
		end
		if upgradeData.KeywordOverrides then
			for key, keywordData in pairs(upgradeData.KeywordOverrides) do
				Keywords[keywordData.Key] = keywordData.Value
			end
		end
	end
end


function ApplyTraitUpgrade( unit, applyLuaUpgrades )
	local appliedTraitDictionary = {}
	local traitList = DeepCopyTable( unit.Traits )
	local iterations = 0
	while not IsEmpty(traitList) and iterations < 100 do
		local appliedTraits = {}
		for k, trait in pairs( traitList) do
			EquipReferencedWeapons( trait )

			AddOnHitWeapons( unit, trait )
			local referencedPropertyChanges = nil
			local referencedPropertyChangeName = nil

			referencedPropertyChanges = trait.PropertyChanges
			referencedPropertyChangeName = "PropertyChanges"

			if referencedPropertyChanges ~= nil then
				local hasDependencies = false
				for i, propertyChange in pairs( referencedPropertyChanges ) do
					if not hasDependencies and propertyChange.TraitName ~= nil and HeroHasTrait(propertyChange.TraitName) and not appliedTraitDictionary[propertyChange.TraitName] then
						hasDependencies = true
					end
				end

				if not hasDependencies then
					for i, propertyChange in pairs( referencedPropertyChanges ) do
						if propertyChange.ChangeType and not TraitData[trait.Name][referencedPropertyChangeName][i].ChangeType and not TraitData[trait.Name][referencedPropertyChangeName][i].DeriveValueFrom then
							if appliedTraitDictionary[trait.Name] then
								propertyChange.ChangeType = "Add"
							else
								propertyChange.ChangeType = "Absolute"
							end
						end
					end

					ApplyUnitPropertyChanges( unit, referencedPropertyChanges, applyLuaUpgrades )
					table.insert( appliedTraits, trait )
					appliedTraitDictionary[trait.Name] = true
				end
			else
				table.insert( appliedTraits, trait )
				appliedTraitDictionary[trait.Name] = true
			end
		end
		for i, trait in pairs( appliedTraits ) do
			RemoveValue( traitList, trait )
		end
		iterations = iterations + 1
	end

	if not IsEmpty(traitList) then
		DebugAssert({ Condition = false , Text = TableLength(traitList) .. " traits are still waiting to be applied. See Debug dump!" })
		for i, trait in pairs(traitList) do
			DebugPrint({Text = "--" .. trait.Name })
		end
	end
end

function ApplyEnemyTraits( currentRun, enemy )
	for k, trait in pairs( currentRun.Hero.Traits ) do
		EquipReferencedEnemyWeapons( currentRun, trait, enemy )
	end

	for k, trait in pairs( currentRun.Hero.Traits ) do
		ApplyEnemyTrait( currentRun, trait, enemy )
	end
end

function EquipReferencedEnemyWeapons( currentRun, trait, enemy )
	if trait == nil or enemy.SkipModifiers then
		return
	end

	if trait.PreEquipEnemyWeapon ~= nil then
		EquipWeapon({ Name = trait.PreEquipEnemyWeapon, DestinationId = enemy.ObjectId })
	end

	if trait.AddEnemyOnDeathWeapons ~= nil then
		for i, weaponData in pairs( trait.AddEnemyOnDeathWeapons ) do
			EquipWeapon({ Name = weaponData.Weapon, DestinationId = enemy.ObjectId })
		end
	end
end

function ApplyEnemyTrait( currentRun, trait, enemy )
	if trait ~= nil then
		if trait.EnemyPropertyChanges ~= nil then
			ApplyUnitPropertyChanges( enemy, trait.EnemyPropertyChanges, true )
		end
		
		if trait.AddEnemyOnDeathWeapons ~= nil and not enemy.SkipModifiers then
			AddEnemyOnDeathWeapons(enemy, trait.AddEnemyOnDeathWeapons)
		end
		if trait.EnemyIncomingDamageModifiers and not enemy.SkipModifiers then
			local modifierData = DeepCopyTable( trait.EnemyIncomingDamageModifiers )
			modifierData.Name = trait.Name
			AddIncomingDamageModifier( enemy, modifierData )
		end
	end
end

function ApplyMetaModifierHeroUpgrades( hero, applyLuaUpgrades )
	for k, upgradeName in pairs( CurrentRun.EnemyUpgrades ) do
		local upgradeData = EnemyUpgradeData[upgradeName]
		if upgradeData.HeroPropertyChanges ~= nil then
			ApplyUnitPropertyChanges( hero, upgradeData.HeroPropertyChanges, applyLuaUpgrades )
		end
	end
end

function HasMeleeWeapon( currentRun )

	for k, meleeWeaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
		if currentRun.Hero.Weapons[meleeWeaponName] then
			return true
		end
	end
	return false

end

function PermanentSwitchWeapon( unit, args )
	for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
		if unit.Weapons[weaponName] then
			SwapWeapon({ DestinationId = unit.ObjectId, Name = weaponName, SwapWeaponName = args, StompOriginalWeapon = true })
			return
		end
	end
end

function GatherAndEquipWeapons( currentRun )

	if not currentRun.CurrentRoom.NoAutoEquip and not HasMeleeWeapon( currentRun ) then
		local defaultWeaponName = currentRun.Hero.DefaultWeapon
		currentRun.Hero.Weapons[defaultWeaponName] = true
		currentRun.Hero.Weapons[WeaponData[defaultWeaponName].SecondaryWeapon] = true
		GameState.WeaponsUnlocked[defaultWeaponName] = true
		GameState.WeaponsTouched[defaultWeaponName] = true
	end
	EquipWeapon({ Name = "ArmorBreakAttack", DestinationId = currentRun.Hero.ObjectId })

	local weaponNames = ShallowCopyTable( GameData.WeaponEquipOrder )
	local remainingWeaponNames = GetAllKeys( currentRun.Hero.Weapons )
	table.sort( remainingWeaponNames )
	for k, weaponName in ipairs( remainingWeaponNames ) do
		if not Contains( weaponNames, weaponName ) then
			table.insert( weaponNames, weaponName )
		end
	end
	for k, weaponName in ipairs( weaponNames ) do
		--DebugPrint({ Text = "Equipping = "..weaponName })
		EquipWeapon({ Name = weaponName, DestinationId = currentRun.Hero.ObjectId, LoadPackages = not GameData.MissingPackages[weaponName] })
		local linkedWeaponNames = WeaponSets.HeroWeaponSets[weaponName]
		if linkedWeaponNames ~= nil then
			for k, linkedWeaponName in ipairs( linkedWeaponNames ) do
				EquipWeapon({ DestinationId = currentRun.Hero.ObjectId, Name = linkedWeaponName })
			end
		end
	end
end

function EquipSpecialWeapons( newEnemy, upgradeData )
	if upgradeData == nil then
		return
	end

	if upgradeData.AddSpecialWeapons == nil or type(upgradeData.AddSpecialWeapons) ~= "table" then
		return
	end

	for weaponType, weaponName in pairs( upgradeData.AddSpecialWeapons ) do
		EquipWeapon({ Name = weaponName, DestinationId = newEnemy.ObjectId })
		SetUnitProperty({ Property = weaponType, Value = weaponName, DestinationId = newEnemy.ObjectId })
	end
end

function EquipDumbFireWeapons( newEnemy, upgradeData )
	if upgradeData == nil then
		return
	end

	if upgradeData.AddDumbFireWeapons == nil or type(upgradeData.AddDumbFireWeapons) ~= "table" then
		return
	end

	for weaponType, weaponName in pairs( upgradeData.AddDumbFireWeapons ) do
		newEnemy.DumbFireWeapons = newEnemy.DumbFireWeapons or {}
		EquipWeapon({ Name = weaponName, DestinationId = newEnemy.ObjectId })
		table.insert( newEnemy.DumbFireWeapons, weaponName )
	end
end

function IsWeaponUnused(weaponName)
	if weaponName == CurrentRun.BonusDarknessWeapon then
		return true
	end
	return false
end

function GetRandomUnequippedWeapon()
	local unusedWeapons = {}
	local hasWeaponEquipped = HasMeleeWeapon( CurrentRun )
	for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
		if ( not hasWeaponEquipped and weaponName ~= CurrentRun.Hero.DefaultWeapon) or (hasWeaponEquipped and CurrentRun.Hero.Weapons[weaponName] == nil and IsWeaponEligible(CurrentRun, WeaponData[weaponName])) then
			table.insert(unusedWeapons, weaponName)
		end
	end
	return GetRandomValue(unusedWeapons)
end

function IsWeaponUntouched( weaponName )
	return GameState.WeaponsTouched[weaponName] == nil
end

function IsWeaponUnlocked( weaponName )
	return GameState.WeaponsUnlocked[weaponName]
end

function GetNumLockedWeapons()
	local numLocked = 0
	for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
		if not IsWeaponUnlocked( weaponName ) then
			numLocked = numLocked + 1
		end
	end
	return numLocked
end

function SetHeroProperties( currentRun )

	if not currentRun.Hero.IsDead then
		SetUnitProperty({ Property = "LowSpeedThreshold", Value = 0, DestinationId = currentRun.Hero.ObjectId, DataValue = false })
	else
		if CurrentDeathAreaRoom ~= nil and CurrentDeathAreaRoom.LowSpeedThreshold ~= nil then
			SetUnitProperty({ Property = "LowSpeedThreshold", Value = CurrentDeathAreaRoom.LowSpeedThreshold, DestinationId = currentRun.Hero.ObjectId, DataValue = false })
		end
	end

end

function AddEnemyUpgrade( upgradeName)

	table.insert( CurrentRun.EnemyUpgrades, upgradeName )
	local upgradeData = EnemyUpgradeData[upgradeName]
	if upgradeData.HeroPropertyChanges ~= nil then
		ApplyUnitPropertyChanges( CurrentRun.Hero, upgradeData.HeroPropertyChanges, true )
		SetHeroProperties( CurrentRun )
	end
	TraitUIAdd(upgradeData)
end

function RemoveEnemyUpgrade( upgradeName )
	RemoveValue( CurrentRun.EnemyUpgrades, upgradeName )
	local upgradeData = EnemyUpgradeData[upgradeName]
	if upgradeData.HeroPropertyChanges ~= nil then
		ApplyUnitPropertyChanges( CurrentRun.Hero, upgradeData.HeroPropertyChanges, true, true )
		SetHeroProperties( CurrentRun )
	end
	TraitUIRemove(upgradeData)
end

