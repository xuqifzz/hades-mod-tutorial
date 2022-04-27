
function RunTraitThreads(source)
	for index, trait in pairs(CurrentRun.Hero.Traits) do
		if trait.DumbFireWeapons ~= nil then
			thread(DumbFireWeapon, source, trait.Name, trait.DumbFireWeapons)
		end
	end
end

function DumbFireWeapon(source, traitName, args)
	while UseTrait( CurrentRun.Hero, traitName ) do
		local randomStrikePointId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = RandomFloat(-1 * args.Radius, args.Radius), OffsetY = RandomFloat(-1 * args.Radius, args.Radius )})
		FireWeaponFromUnit({ Weapon = args.Weapon,  AutoEquip = true, Id = source.ObjectId, DestinationId = randomStrikePointId, })
		Destroy({Id = randomSTrikePointId})
		wait(RandomFloat(args.IntervalMin, args.IntervalMax))
	end
end

function AutoRetaliateSetup( hero, args )
	thread( AutoRetaliateThread, args )
end

function AutoRetaliateThread( args )
	while CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead do
		local interval = args.IntervalData
		if type(interval) == "table" then
			interval = RandomFloat( interval.Min, interval.Max )
		end
		wait(interval, RoomThreadName)
		if CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead and IsCombatEncounterActive( CurrentRun ) then
			local nearestEnemyId = nil
			local createdObstacle = false
			if args.Range then
				nearestEnemyId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = args.Range })
				if nearestEnemyId == 0 then
					local randomLightningTargetOffsetX = RandomFloat(-1 * args.Range/2, args.Range/2)
					local randomLightningTargetOffsetY = RandomFloat(-1 * args.Range/2, args.Range/2)
					targetId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = randomLightningTargetOffsetX, OffsetY = randomLightningTargetOffsetY })
					nearestEnemyId = targetId
					createdObstacle = true
				end
			end
			CheckOnHitPowers( CurrentRun.Hero, { TriggersOnHitEffects = true, ObjectId = nearestEnemyId }, { Automatic = true })
			if createdObstacle then
				Destroy({ Id = nearestEnemyId })
			end
		end
	end
end

function IncrementHitByShield( victim )
	if not victim.SkipModifiers and victim ~= CurrentRun.Hero then
		IncrementTableValue( CurrentRun.CurrentRoom, "ShieldThrowHits")
	end
end

function MaxChillOnTarget( victim, victimId, triggerArgs )
	for i = 1, GetTotalHeroTraitValue("RetaliateChillStacks") do
		-- Done during engine conversion otherwise stacks should be a argument to pass up -- @alice
		ApplyEffectFromWeapon({ Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, WeaponName = "ChillRetaliate", EffectName = "DemeterSlow" })
	end
end

function TrackMaximumChillBlast( hero, args )
	thread( MaximumChillThread, args )
end

function MaximumChillThread( args )
	while CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead do
		wait(0.2, RoomThreadName)
		if CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead and IsCombatEncounterActive( CurrentRun ) and not IsEmpty( RequiredKillEnemies ) then
			local allEnemiesFrozen = true
			for enemyId, enemy in pairs(RequiredKillEnemies) do
				if not enemy.Slowed then
					allEnemiesFrozen = false
				end
			end

			if allEnemiesFrozen then
				ApplyEffectFromWeapon({ Id = CurrentRun.Hero.ObjectId, DestinationIds = GetAllKeys( RequiredKillEnemies ), WeaponName = "DemeterWorldChill", EffectName = "DemeterWorldChill" })
			else
				ClearEffect({ Ids = GetAllKeys( RequiredKillEnemies ), Name = "DemeterWorldChill" })
			end
		end
	end
end

function CheckChillKill( args, attacker, victim )
	if attacker == CurrentRun.Hero and victim.Slowed and not victim.IsDead and victim.Health / victim.MaxHealth <= args.ChillDeathThreshold and ( victim.Phases == nil or victim.CurrentPhase == victim.Phases ) then
		FireWeaponFromUnit({ Weapon = "DemeterChillKill", AutoEquip = true, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, FireFromTarget = true })
		PlaySound({ Name = "/SFX/DemeterEnemyFreezeShatter", Id = victim.ObjectId })
		
		if victim.IsBoss then
	      BossChillKillPresentation( victim )
		end
		if victim.DeathAnimation ~= nil and not victim.ManualDeathAnimation then
			SetAnimation({ Name = victim.DeathAnimation, DestinationId = victim.ObjectId })
			-- @todo Notify on death animation finish
		end
		thread( Kill, victim, { ImpactAngle = 0, AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId })
	end
end

function FireAmmoWeapon( ammoId, args )
	local weaponName = args.WeaponName
	local intervalData = args.Interval

	while IdExists({ Id = ammoId }) do
		local interval = intervalData
		if type(intervalData) == "table" then
			interval = RandomFloat( intervalData.Min, intervalData.Max )
		end
		wait(interval, RoomThreadName)
		if IdExists({ Id = ammoId }) and IsCombatEncounterActive( CurrentRun ) then
			if args.Range then
				thread(FireWeaponWithinRange, { SourceId = ammoId, Range = args.Range, SeekTarget = true, WeaponName = weaponName, InitialDelay = 0, Delay = 0.21, Count = 1, BonusChance = GetTotalHeroTraitValue("BonusBolts") })
			else
				FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = ammoId })
			end
		end
	end
end

function FireAmmoDeathWeapon( args, locationX, locationY )
	local weaponName = args.WeaponName
	local intervalData = args.Interval
	local duration = args.Duration

	local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = locationX, LocationY = locationY })

	while duration > 0 do
		local interval = intervalData
		if type(intervalData) == "table" then
			interval = RandomFloat( intervalData.Min, intervalData.Max )
		end
		wait( interval, RoomThreadName )
		duration = duration - interval
		if IsCombatEncounterActive( CurrentRun ) then
			if args.Range then
				thread(FireWeaponWithinRange, { SourceId = dropLocation, Range = args.Range, SeekTarget = true, WeaponName = weaponName, InitialDelay = 0, Delay = 0.21, Count = 1, BonusChance = GetTotalHeroTraitValue("BonusBolts") })
			else
				FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation })
			end
		end
	end

	Destroy({ Id = dropLocation })
end

function GetProcessedTraitData( args )
	local traitData = ProcessTraitData( args )
	ReplaceDerivedValues(traitData)
	return traitData
end

function ReplaceDerivedValues(traitData)
	local changes = {}
	if traitData.PropertyChanges ~= nil then
		table.insert( changes, "PropertyChanges" )
	end
	if traitData.EnemyPropertyChanges ~= nil then
		table.insert( changes, "EnemyPropertyChanges" )
	end

	for i, changeKey in pairs(changes) do
		for s, propertyChange in pairs(traitData[changeKey]) do
			if propertyChange.DeriveValueFrom ~= nil then
				local referencedPropertyValue = nil
				-- Custom override for supers
				if propertyChange.DeriveValueFrom == "SuperDuration" then
					assert(traitData.AddShout.SuperDuration ~= nil, "SuperDuration not found on trait " .. traitData.Name )
					referencedPropertyValue = { ChangeValue = traitData.AddShout.SuperDuration }
				end
				if not referencedPropertyValue then
					for w, otherChangeKey in pairs ( changes ) do
						for t, otherPropertyChange in pairs(traitData[otherChangeKey]) do
							if referencedPropertyValue == nil then
								for key, value in pairs(otherPropertyChange) do
									if value == propertyChange.DeriveValueFrom then
										referencedPropertyValue = otherPropertyChange
									end
								end
							end
						end
					end
				end
				assert(referencedPropertyValue ~= nil, "UseValue " .. propertyChange.DeriveValueFrom .. " not found on trait " .. traitData.Name )
				propertyChange.ChangeValue = referencedPropertyValue.ChangeValue
				if propertyChange.ChangeType == nil then
					propertyChange.ChangeType = referencedPropertyValue.ChangeType
				end
				if propertyChange.ExcludeLinked == nil then
					propertyChange.ExcludeLinked = referencedPropertyValue.ExcludeLinked
				end
			end
		end
	end
	
	for key, value in pairs(traitData) do
		if type(value) == "table" and value.ReplaceWithKeyValue ~= nil then
			traitData[key] = traitData[value.ReplaceWithKeyValue]
		end
	end

	if traitData.SignOffData then
		for i, data in ipairs( traitData.SignOffData ) do
			if IsGameStateEligible( CurrentRun, data ) then
				traitData.SignoffText = data.Text
			end
		end
	end

	return traitData
end

function ApplyTraitAutoRamp( unit )
	for s, traitData in pairs(unit.Traits) do
		local changes = {}
		if traitData.PropertyChanges ~= nil then
			table.insert( changes, "PropertyChanges" )
		end
		if traitData.EnemyPropertyChanges ~= nil then
			table.insert( changes, "EnemyPropertyChanges" )
		end
		for i, changeKey in pairs(changes) do
			for s, propertyChange in pairs(traitData[changeKey]) do
				if propertyChange.AutoRamp then
					propertyChange.ChangeValue = GetProcessedValue(propertyChange)
				end
			end
		end
		ReplaceDerivedValues(traitData)
	end
end

function ProcessTraitData( args )
	if args == nil then
		return
	elseif ( args.TraitName == nil and args.TraitData == nil ) or args.Unit == nil then
		return
	end
	local traitName = args.TraitName
	local unit = args.Unit
	local rarity = args.Rarity
	local fakeStackNum = args.FakeStackNum

	local traitData = args.TraitData or DeepCopyTable(TraitData[traitName])
	if traitName == nil then
		traitName = args.TraitData.Name
	end
	traitData.Title = traitData.Name

	local numExisting = GetTraitCount( unit, traitData )

	if args.ForBoonInfo then
		numExisting = 0
	end

	local rarityMultiplier = args.RarityMultiplier or 1
	if rarity ~= nil and traitData.RarityLevels ~= nil and traitData.RarityLevels[rarity] ~= nil and traitData.RarityMultiplier == nil then
		local rarityData = traitData.RarityLevels[rarity]
		if rarityData.Multiplier ~= nil then
			rarityMultiplier = rarityData.Multiplier
		else
			rarityMultiplier = RandomFloat(rarityData.MinMultiplier, rarityData.MaxMultiplier)
		end
		traitData.Rarity = rarity
		traitData.RarityMultiplier = rarityMultiplier
	end

	-- NOTE(Dexter) GetProcessedValue makes calls to the RNG. For determinism, we must iterate in sorted order.
	local traitDataKVPs = CollapseTableAsOrderedKeyValuePairs(traitData)
	for i, kvp in ipairs( traitDataKVPs ) do
		local key = kvp.Key
		local value = kvp.Value
		if key ~= "PropertyChanges" and key ~= "EnemyPropertyChanges" and key ~= "WeaponDataOverride" then
			local propertyRarityMultiplier = rarityMultiplier or 1
			if traitData[key] and type(traitData[key]) == "table" and traitData[key].CustomRarityMultiplier then
				local rarityData = traitData[key].CustomRarityMultiplier[traitData.Rarity]
				if rarityData then
					if rarityData.Multiplier ~= nil then
						propertyRarityMultiplier = rarityData.Multiplier
					else
						propertyRarityMultiplier = RandomFloat(rarityData.MinMultiplier, rarityData.MaxMultiplier)
					end
				end
			end
			traitData[key] = GetProcessedValue(value, { NumExisting = numExisting, RarityMultiplier = propertyRarityMultiplier, FakeStackNum = fakeStackNum })
		end
	end

	if not IsEmpty( unit.Traits ) and traitData.RemainingUses ~= nil then
		for i, data in pairs( GetHeroTraitValues( "TraitDurationIncrease", { Unit = unit })) do
			if data.ValidTraits == nil or Contains( data.ValidTraits, traitName ) then
				if traitData.RemainingUses ~= nil then
					traitData.RemainingUses = traitData.RemainingUses + data.Amount
				end
			end
		end
	end

	if traitData.PropertyChanges == nil and traitData.EnemyPropertyChanges == nil then
		return traitData
	end

	local changes = {}
	if traitData.PropertyChanges ~= nil then
		table.insert( changes, "PropertyChanges" )
	end
	if traitData.EnemyPropertyChanges ~= nil then
		table.insert( changes, "EnemyPropertyChanges" )
	end

	for i, changeKey in ipairs(changes) do
		local sortedTraitDataAtChangeKey = CollapseTableOrdered(traitData[changeKey])
		for s, propertyChange in ipairs(sortedTraitDataAtChangeKey) do
			if propertyChange.BaseMin ~= nil or propertyChange.BaseValue ~= nil then
				local propertyRarityMultiplier = rarityMultiplier or 1
				if propertyChange.CustomRarityMultiplier then
					local rarityData = propertyChange.CustomRarityMultiplier[traitData.Rarity]
					if rarityData then
						if rarityData.Multiplier ~= nil then
							propertyRarityMultiplier = rarityData.Multiplier
						else
							propertyRarityMultiplier = RandomFloat(rarityData.MinMultiplier, rarityData.MaxMultiplier)
						end
					end
				end
				local newValue = GetProcessedValue(propertyChange, { Unit = unit, NumExisting = numExisting, RarityMultiplier = propertyRarityMultiplier, FakeStackNum = fakeStackNum  })
				propertyChange.ChangeValue = newValue
				propertyChange.BaseValue = newValue
				if propertyChange.ChangeType == nil then
					if numExisting > 0 then
						propertyChange.ChangeType = "Add"
					else
						propertyChange.ChangeType = "Absolute"
					end
				end
			end
		end
	end
	return traitData
end

function GetProcessedValue( valueToRamp, args )
	args = args or {}
	local numExisting = args.NumExisting  or 0
	local rarityMultiplier = args.RarityMultiplier
	local unit = args.Unit

	if type( valueToRamp ) ~= "table" then
		return valueToRamp
	end

	rarityMultiplier = rarityMultiplier or 1
	if valueToRamp.IgnoreRarity then
		rarityMultiplier = 1
	end
	local hasIdentical = numExisting > 0
	local depth = GetRunDepth( CurrentRun )
	if valueToRamp.BaseMin ~= nil or valueToRamp.BaseValue ~= nil then
		local depthMultiplier = 1
		if valueToRamp.DepthMult ~= nil then
			depthMultiplier = 1 + depth * valueToRamp.DepthMult
		end

		local value = 0
		if valueToRamp.BaseValue ~= nil then
			value = valueToRamp.BaseValue * depthMultiplier
		else
			if hasIdentical then
				value = (valueToRamp.BaseMin + valueToRamp.BaseMax) / 2
			else
				value = RandomFloat(valueToRamp.BaseMin, valueToRamp.BaseMax) * depthMultiplier
			end
		end
		local baseValue = value

		if valueToRamp.SourceIsMultiplier then
			local delta = value - 1
			value = 1 + delta * rarityMultiplier
		elseif valueToRamp.SourceIsNegativeMultiplier then
			local delta = 1 - value * rarityMultiplier
			value = 1 + delta
		else
			value = value * rarityMultiplier
		end

		if args.FakeStackNum and args.FakeStackNum > 1 then
			value = 0
			if valueToRamp.SourceIsMultiplier or valueToRamp.SourceIsNegativeMultiplier then
				value = 1
			end
			if valueToRamp.IdenticalMultiplier ~= nil then
				local fakeStackNum = args.FakeStackNum - 1
				-- Brute force for the time being
				for i = numExisting, numExisting + fakeStackNum do
					local diminishingMultiplier = valueToRamp.IdenticalMultiplier.DiminishingReturnsMultiplier or TraitMultiplierData.DefaultDiminishingReturnsMultiplier
					local totalDiminishingMultiplier = math.pow(diminishingMultiplier, i - 1 )
					local minMultiplier = valueToRamp.MinMultiplier or TraitMultiplierData.DefaultMinMultiplier
					local totalMultiplier = (1 + valueToRamp.IdenticalMultiplier.Value) * totalDiminishingMultiplier

					if totalMultiplier < minMultiplier then
						totalMultiplier = minMultiplier
					end
					if i == 0 then
						if valueToRamp.SourceIsMultiplier then
							local delta = baseValue - 1
							value = 1 + delta * rarityMultiplier
						elseif valueToRamp.SourceIsNegativeMultiplier then
							local delta = 1 - baseValue * rarityMultiplier
							value = 1 + delta
						else
							value = baseValue * rarityMultiplier
						end
					else
						if valueToRamp.SourceIsMultiplier then
							local delta = baseValue - 1
							local adjustedValue = delta * totalMultiplier
							value = value + adjustedValue

						elseif valueToRamp.SourceIsNegativeMultiplier then
							local delta = 1 - baseValue * totalMultiplier
							value = value + delta
						else
							local adjustedValue = baseValue * totalMultiplier
							value = value + adjustedValue
						end
					end
					value = ProcessValue( value, valueToRamp )
				end
			else
				if valueToRamp.SourceIsMultiplier then
					value = value + ( baseValue - 1 ) * args.FakeStackNum
				else
					value = value + baseValue * args.FakeStackNum
				end
			end
		else
			if hasIdentical and valueToRamp.IdenticalMultiplier ~= nil then
				local diminishingMultiplier = valueToRamp.IdenticalMultiplier.DiminishingReturnsMultiplier or TraitMultiplierData.DefaultDiminishingReturnsMultiplier
				local totalDiminishingMultiplier = math.pow(diminishingMultiplier, numExisting - 1 )
				local minMultiplier = valueToRamp.MinMultiplier or TraitMultiplierData.DefaultMinMultiplier
				local totalMultiplier = (1 + valueToRamp.IdenticalMultiplier.Value) * totalDiminishingMultiplier
				if totalMultiplier < minMultiplier then
					totalMultiplier = minMultiplier
				end

				if valueToRamp.SourceIsMultiplier then
					local delta = value - 1
					local adjustedValue = delta * totalMultiplier
					value = 1 + adjustedValue
				elseif valueToRamp.SourceIsNegativeMultiplier then
					local delta = 1 - value * totalMultiplier
					value = 1 + delta
				else
					local adjustedValue = value * totalMultiplier
					value = adjustedValue
				end
			end
		end

		if valueToRamp.MultipliedByHeroValue then
			value = value * GetTotalHeroTraitValue( valueToRamp.MultipliedByHeroValue, { IsMultiplier = true })
		end

		if valueToRamp.ReducedByMetaupgradeValue then
			local metaupgradeName = valueToRamp.ReducedByMetaupgradeValue
			value = value * ( 1 - GetNumMetaUpgrades(metaupgradeName) * ( MetaUpgradeData[metaupgradeName].ChangeValue - 1 ))
		end

		if unit ~= nil and valueToRamp.LifeProperty ~= nil and valueToRamp.LuaProperty == "MaxHealth" and unit.MaxHealthMultiplier ~= nil then
			
			value = GetMaxHealthUpgradeIncrement( value )
		end

		return ProcessValue( value, valueToRamp )
	else
		local traitDataKVPs = CollapseTableAsOrderedKeyValuePairs(valueToRamp)
		for i, kvp in ipairs( traitDataKVPs ) do
			local key = kvp.Key
			local value = kvp.Value
			if key ~= "ExtractValue" and key ~= "ExtractValues" then
				valueToRamp[key] = GetProcessedValue( value, args )
			end
		end
		return valueToRamp
	end
end

function ProcessValue( value, rampData )
	if rampData.AsInt then
		value = round(value)
	elseif rampData.ToNearest then
		value = math.floor( value / rampData.ToNearest ) * rampData.ToNearest
	end

	if rampData.DecimalPlaces then
		value = round(value, rampData.DecimalPlaces)
	else
		-- otherwise round to the nearest percent
		value = round(value, 2)
	end
	return value
end

function GetTotalHeroTraitValue(propertyName, args)
	args = args or {}
	local offset = 0
	local output = 0
	local hero = args.Hero or CurrentRun.Hero

	if args.IsMultiplier then
		offset = 1
		output = 1
	end

	for k, trait in pairs( hero.Traits ) do
		if trait[propertyName] ~= nil then
			output = output + (trait[propertyName] - offset)
		end
	end
	return output
end

function GetHeroTraitValues(propertyName, args)
	args = args or {}
	local hero = args.Unit or CurrentRun.Hero

	if CurrentRun.Hero.HeroTraitValuesCache and CurrentRun.Hero.HeroTraitValuesCache[propertyName] and not args.UnlimitedOnly then
		return CurrentRun.Hero.HeroTraitValuesCache[propertyName]
	end

	local output = {}
	for k, trait in pairs( hero.Traits ) do
		if trait ~= nil and trait[propertyName] ~= nil and ( not args.UnlimitedOnly or trait.RemainingUses == nil ) then
			table.insert(output, trait[propertyName])
		end
	end
	if not args.UnlimitedOnly then
		if not CurrentRun.Hero.HeroTraitValuesCache then
			CurrentRun.Hero.HeroTraitValuesCache = {}
		end
		CurrentRun.Hero.HeroTraitValuesCache[propertyName] = ShallowCopyTable( output )
	end
	return output
end

function HasHeroTraitValue( propertyName )
	for k, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait ~= nil and trait[propertyName] ~= nil then
			return true
		end
	end
	return false
end

function UseHeroTraitsWithValue( propertyName, useFirst )
	local removedTraits = {}
	for k, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait ~= nil and trait[propertyName] ~= nil then
			UseTraitData(CurrentRun.Hero, trait)
			if trait.RemainingUses ~= nil and trait.RemainingUses <= 0 then
				table.insert( removedTraits, trait )
				if useFirst then
					break
				end
			end
		end
	end

	for _, trait in pairs( removedTraits ) do
		RemoveTraitData( CurrentRun.Hero, trait )
	end
end

function AddTraitToHero(args)
	local traitData = args.TraitData
	if traitData == nil then
		traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = args.TraitName, Rarity = args.Rarity })
	end

	GameState.LastPickedTraitName = traitData.Name

	if not args.PreProcessedForDisplay then
		ExtractValues(CurrentRun.Hero, traitData, traitData)
	end

	if traitData.Slot and CurrentRun.CurrentRoom then
		CurrentRun.CurrentRoom.AcquiredSlot = traitData.Slot
	end
	-- traits may have information that acts on weapons, so we must first equip all associated weapons to the player
	EquipReferencedWeapons( traitData )
	AddTraitData( CurrentRun.Hero, traitData, args )

	EquipSpecialWeapons( CurrentRun.Hero, traitData )
	AddAssistWeapons( CurrentRun.Hero, traitData )
	for weaponName, v in pairs( CurrentRun.Hero.Weapons ) do
		AddWallSlamWeapons( CurrentRun.Hero, traitData )
		AddOnDamageWeapons(CurrentRun.Hero, weaponName, traitData)
		AddOnFireWeapons(CurrentRun.Hero, weaponName, traitData)
		if traitData.UpgradeHeroWeapon ~= nil and Contains(traitData.UpgradeHeroWeapon.WeaponNames, weaponName) then
			AddHeroWeaponUpgrade(weaponName, traitData.UpgradeHeroWeapon.UpgradeName)
		end
	end

	if ( traitData.EnemyPropertyChanges or traitData.AddEnemyOnDeathWeapons ) and ActiveEnemies ~= nil then
		for enemyId, enemy in pairs( ActiveEnemies ) do
			EquipReferencedEnemyWeapons( currentRun, traitData, enemy )
			ApplyEnemyTrait( CurrentRun, traitData, enemy )
		end
	end

	if traitData.AddShout then
		if traitData.AddShout.Cost then
			CurrentRun.Hero.SuperCost = traitData.AddShout.Cost
		else
			CurrentRun.Hero.SuperCost = 25
		end
		ShowSuperMeter()
	end
end

function HeroHasTrait( traitName )
	if traitName == nil then
		return false
	end
	if TraitData[traitName] == nil then
		DebugAssert({ Condition = (TraitData[traitName] ~= nil), Text = "TraitData is missing value for '"..traitName.."'" })
	end

	if CurrentRun.Hero.TraitDictionary then
		if CurrentRun.Hero.TraitDictionary[traitName] ~= nil then
			return true
		end
		return false
	end

	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.Name == traitName then
			return true
		end
	end
	return false
end

function HeroSlotFilled( slotName )
	for i, traitData in pairs(CurrentRun.Hero.Traits ) do
		if traitData.Slot == slotName then
			return true
		end
		if traitData.AltSlot and traitData.AltSlot == slotName then
			return true
		end
	end

	return false
end

function GetTotalTraitCount( unit )
	if unit.Traits == nil then
		return 0
	end
	local num = 0
	for k, currentTrait in pairs( unit.Traits ) do
		if not currentTrait.Hidden then
            num = num + 1
        end
	end
	return num
end

function GetTraitNameCount( unit, traitName )
	if unit == nil or unit.Traits == nil then
		return 0
	end

	if unit.TraitDictionary then
		if unit.TraitDictionary[traitName] == nil then
			return 0
		end
		return TableLength( unit.TraitDictionary[traitName] )
	end

	local num = 0
	for k, currentTrait in pairs( unit.Traits ) do
		if currentTrait.Name == traitName then
			num = num + 1
		end
	end
	return num
end

function GetTraitCount( unit, trait )
	if trait == nil or unit == nil or unit.Traits == nil then
		return 0
	end

	if unit.TraitDictionary then
		if unit.TraitDictionary[trait.Name] == nil then
			return 0
		end

		local num = 0
		if trait.RemainingUses == nil and trait.LastCurseName == nil and trait.OnExpire == nil then
			return TableLength( unit.TraitDictionary[trait.Name] )
		else
			for k, currentTrait in pairs( unit.TraitDictionary[trait.Name]) do
				if AreTraitsIdentical( trait, currentTrait ) then
					num = num + 1
				end
			end
		end
		return num
	end

	local num = 0
	for k, currentTrait in pairs( unit.Traits ) do
		if AreTraitsIdentical(trait, currentTrait) then
			num = num + 1
		end
	end
	return num
end

function AreTraitsIdentical( traitA, traitB )
	if traitA == nil or traitB == nil then
		local traitAName = "nil"
		local traitBName = "nil"
		if traitA ~= nil then
			traitAName = tostring(traitA.Name)
		end
		if traitB ~= nil then
			traitBName = tostring(traitB.Name)
		end
		DebugAssert({ Condition = false, Text = "Comparing nil traits(s) " .. traitAName .. " and " .. traitBName })
		return false
	end

	if traitA.ForBoonInfo or traitB.ForBoonInfo then
		return false
	end
	if traitA == traitB then
		return true
	end

	if ( traitA.LastCurseName and traitB.LastCurseName ) or ( traitA.LastBlessingName and traitB.LastBlessingName ) then
		return traitB.Name == traitA.Name and traitB.Id == traitA.Id
	end

	if traitA.RemainingUses or traitB.RemainingUses then
		return traitB.Name == traitA.Name and traitB.Id == traitA.Id
	end
	return traitB.Name == traitA.Name
end

function GetTraitUniqueId()
	if CurrentRun then
		return TableLength(CurrentRun.Hero.Traits) .. GetRunDepth( CurrentRun ) .. tostring( _worldTime ) .. RandomFloat(0, 1)
	end
	return tostring(_worldTime)
end

function GetHeroUniqueGodCount( hero )
	if not hero then
		return 0
	end

	if hero.UniqueGodCount then
		return hero.UniqueGodCount
	end

	local godDictionary = {}
	for traitName in pairs( hero.TraitDictionary ) do
		if GetLootSourceName( traitName ) then
			godDictionary[GetLootSourceName( traitName )] = true
		end
	end
	
	hero.UniqueGodCount = TableLength( godDictionary )
	return hero.UniqueGodCount
end

function UpdateHeroTraitDictionary( )

	if IsEmpty(CurrentRun.Hero.Traits) then
		CurrentRun.Hero.TraitDictionary = {}
		CurrentRun.Hero.HeroTraitValuesCache = {}
		CurrentRun.Hero.UniqueGodCount = 0
		return
	end

	local cache = {}
	local heroTraitValuesCache = {}
	local godDictionary = {}
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		if cache[trait.Name] == nil then
			cache[trait.Name] = {}
		end
		table.insert( cache[trait.Name], trait )

		if CurrentRun.Hero.HeroTraitValuesCache then
			for key, value in pairs(trait) do
				if CurrentRun.Hero.HeroTraitValuesCache[key] then
					if not heroTraitValuesCache[key] then
						heroTraitValuesCache[key] = {}
					end
					table.insert(heroTraitValuesCache[key], value)
				end
			end
		end

		if GetLootSourceName( trait.Name ) then
			godDictionary[GetLootSourceName( trait.Name )] = true
		end
	end
	CurrentRun.Hero.HeroTraitValuesCache = heroTraitValuesCache
	CurrentRun.Hero.TraitDictionary = cache
	CurrentRun.Hero.UniqueGodCount = TableLength( godDictionary )
	UpdateNumHiddenTraits()
end

function AddTrait( unit, traitName, rarity, args)
	local traitData = GetProcessedTraitData({ Unit = unit, TraitName = traitName, Rarity = rarity })
	if args and args.Id then
		traitData.Id = args.Id
	end
	ExtractValues( unit, traitData, traitData )
	AddTraitData( unit, traitData, args )
end

function AddTraitData( unit, traitData, args )
	args = args or {}
	local isDuplicate = false
	local newTrait = DeepCopyTable( traitData )
	local traitName = newTrait.Name
	if unit.Traits == nil then
		unit.Traits = {}
	end
	if unit.TraitAnimationAnchors == nil then
		unit.TraitAnimationAnchors = {}
	end

	GameState.TraitsTaken[traitName] = true
	thread( CheckQuestStatus )
	thread( CheckProgressAchievements )

	-- Check if this is a "dummy trait" used by transforming traits to run one-off events or to hide the "traitiness" of certain systems
	if traitData.DummyTrait then
		if traitData.HealOnAcquire then
			Heal( unit.Hero, { HealAmount = traitData.HealOnAcquire, Name = traitName.."Acquire" } )
		end
		if traitData.AddTrait and TraitData[traitData.AddTrait] then
			AddTrait( unit, traitData.AddTrait )
		end
		if traitData.AddLastStand then
			AddLastStand( traitData.AddLastStand )
		end
		return
	end
	
	newTrait.Id =  newTrait.Id or GetTraitUniqueId()

	table.insert( unit.Traits, newTrait )

	if not args.SkipPriorityTray then
		PriorityTrayTraitAdd( newTrait, { DeferSort = true })
	end
	if IsScreenOpen("TraitTrayScreen") then
		CloseAdvancedTooltipScreen()
	end
	if unit == CurrentRun.Hero and not args.SkipUIUpdate then
		UpdateHeroTraitDictionary()
		local showingTrait = nil
		local rarityValue = 0
		for s, existingTrait in pairs( CurrentRun.Hero.Traits) do
			if (AreTraitsIdentical(existingTrait, newTrait) and rarityValue < GetRarityValue( existingTrait.Rarity )) then
				showingTrait = existingTrait
				rarityValue = GetRarityValue( showingTrait.Rarity )
			end
		end
		if showingTrait then
			TraitUIAdd( showingTrait, true )
		end
		SortPriorityTraits()
		
		if newTrait.AnchorId and not args.SkipNewTraitHighlight then
			CreateAnimation({ Name = "NewTraitHighlight", DestinationId = newTrait.AnchorId })
		end
	end
	
	AddOnHitWeapons( unit, newTrait )
	if newTrait.AddIncomingDamageModifiers then
		if unit.IncomingDamageModifiers == nil then
			unit.IncomingDamageModifiers = {}
		end
		local data = DeepCopyTable( newTrait.AddIncomingDamageModifiers )
		data.Name = newTrait.Name
		table.insert( unit.IncomingDamageModifiers, data )
	end

	if newTrait.AddOutgoingLifestealModifiers then	
		local data = DeepCopyTable( newTrait.AddOutgoingLifestealModifiers )
		data.Name = newTrait.Name
		AddOutgoingLifestealModifier( unit, data )
	end

	if newTrait.AddOutgoingDamageModifiers then
		if unit.OutgoingDamageModifiers == nil then
			unit.OutgoingDamageModifiers = {}
		end
		local data = DeepCopyTable( newTrait.AddOutgoingDamageModifiers )
		data.Name = newTrait.Name
		table.insert( unit.OutgoingDamageModifiers, data )
	end

	local isDuplicate = GetTraitCount( unit, newTrait ) > 1
	if isDuplicate and newTrait.OnDuplicatePropertyChanges ~= nil then
		ApplyUnitPropertyChanges( unit, traitData.OnDuplicatePropertyChanges, true )
	else
		ApplyUnitPropertyChanges( unit, traitData.PropertyChanges, true )
		if GetTraitCount( unit, newTrait ) <= 1 and traitData.AnimationName ~= nil then
			unit.TraitAnimationAnchors[traitName] = SpawnObstacle({ Name = "BlankObstacle", Group = "Events", DestinationId = unit.ObjectId })
			Attach({ Id = unit.TraitAnimationAnchors[traitName], DestinationId = unit.ObjectId })
			SetAnimation({ Name = traitData.AnimationName, DestinationId = unit.TraitAnimationAnchors[traitName]})
		end
	end

	if not isDuplicate then
		ApplyLinkedTraitPropertyChanges(unit, newTrait )
	end

	if traitData.WeaponDataOverride then
		if not unit.WeaponDataOverride then
			unit.WeaponDataOverride = {}
		end
		for key, data in pairs(traitData.WeaponDataOverride) do
			if unit.WeaponDataOverride[key] then
				unit.WeaponDataOverride[key] = MergeTables(unit.WeaponDataOverride[key], data )
			else
				unit.WeaponDataOverride[key] = MergeTables(WeaponData[key], data )
			end
		end
	end

	if traitData.AddEffectMultiplier then
		if not unit.EffectMultipliers then
			unit.EffectMultipliers = {}
		end
		local effectMultiplierData = traitData.AddEffectMultiplier
		if effectMultiplierData.WeaponName then
			if unit.EffectMultipliers[effectMultiplierData.WeaponName] and unit.EffectMultipliers[effectMultiplierData.WeaponName][effectMultiplierData.EffectName] then
				unit.EffectMultipliers[effectMultiplierData.WeaponName][effectMultiplierData.EffectName].Multiplier = unit.EffectMultipliers[effectMultiplierData.WeaponName][effectMultiplierData.EffectName].Multiplier + (effectMultiplierData.Multiplier - 1)
			else
				unit.EffectMultipliers[effectMultiplierData.WeaponName] =
				{
				[effectMultiplierData.EffectName] =
					{
					TraitName = effectMultiplierData.RequiredTraitName,
					Multiplier = effectMultiplierData.Multiplier
					}
				}
			end
		end
		if effectMultiplierData.WeaponNames then
			for i, weaponName in pairs(effectMultiplierData.WeaponNames) do
				if unit.EffectMultipliers[weaponName] and unit.EffectMultipliers[weaponName][effectMultiplierData.EffectName] then
					unit.EffectMultipliers[weaponName][effectMultiplierData.EffectName].Multiplier = unit.EffectMultipliers[weaponName][effectMultiplierData.EffectName].Multiplier + (effectMultiplierData.Multiplier - 1)
				else
					unit.EffectMultipliers[weaponName] =
					{
					[effectMultiplierData.EffectName] =
						{
						TraitName = effectMultiplierData.RequiredTraitName,
						Multiplier = effectMultiplierData.Multiplier
						}
					}
				end
			end
		end
	end

	if newTrait.SetupFunction ~= nil and (not newTrait.SetupFunction.RunOnce or not isDuplicate) and not newTrait.SetupFunction.SkipSetupOnAdd then
		_G[newTrait.SetupFunction.Name](unit, newTrait.SetupFunction.Args)
	end

	if (traitData.Duration ~= nil) then
		thread(RemoveTraitAfterDuration, unit, traitName, traitData.Duration)
	end

	if traitData.LoadBinks ~= nil then
		PreLoadBinks({ Names = traitData.LoadBinks })
	end
end

function RemoveTraitAfterDuration(unit, traitName, duration)
	wait(duration)
	RemoveTrait(unit, traitName)
end

function RemoveWeaponTrait( traitName )
	local weaponName = nil
	if TraitData[traitName].Slot == "Melee" then
		for k, baseWeaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
			if CurrentRun.Hero.Weapons[baseWeaponName] then
				weaponName = baseWeaponName
				break
			end
		end
	elseif TraitData[traitName].Slot == "Secondary" then
		for k, baseWeaponName in ipairs( WeaponSets.HeroSecondaryWeapons ) do
			if CurrentRun.Hero.Weapons[baseWeaponName] then
				weaponName = baseWeaponName
				break
			end
		end
	elseif TraitData[traitName].Slot == "Rush" then
		for k, baseWeaponName in ipairs( WeaponSets.HeroRushWeapons ) do
			if CurrentRun.Hero.Weapons[baseWeaponName] then
				weaponName = baseWeaponName
				break
			end
		end
	elseif TraitData[traitName].Slot == "Ranged" then
		for k, baseWeaponName in ipairs( WeaponSets.HeroNonPhysicalWeapons ) do
			if CurrentRun.Hero.Weapons[baseWeaponName] then
				weaponName = baseWeaponName
				break
			end
		end
	elseif TraitData[traitName].Slot == "Shout" then
		-- no weapon
	elseif TraitData[traitName].RequiredWeapon or TraitData[traitName].RequiredWeapons then
		for k, baseWeaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
			if CurrentRun.Hero.Weapons[baseWeaponName] then
				weaponName = baseWeaponName
				break
			end
		end
	end

	if weaponName == nil and TraitData[traitName].LinkedBaseWeapon then
		weaponName = TraitData[traitName].LinkedBaseWeapon
	end

	thread(TraitSacrificedPresentation, GetExistingUITraitName( traitName ))
	while HeroHasTrait( traitName ) do
		RemoveTrait( CurrentRun.Hero, traitName )
	end

	if weaponName then
		UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })
		local weaponSetNames = WeaponSets.HeroWeaponSets[weaponName]
		if weaponSetNames ~= nil then
			for k, linkedWeaponName in pairs( weaponSetNames ) do
				UnequipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName })
			end
		end

		-- remove all weapon traits
		local removedWeaponTraits = {}
		for i, traitData in pairs(CurrentRun.Hero.Traits) do

			local traitToRemove = nil
			if traitData.RequiredWeapon == weaponName or Contains(weaponSetNames, traitData.RequiredWeapon) then
				traitToRemove = traitData
			end

			if traitData.RequiredWeapons and ( Contains( traitData.RequiredWeapons, weaponName) or ContainsAny(weaponSetNames, traitData.RequiredWeapons )) then
				traitToRemove = traitData
			end
			if traitToRemove then
				local hasDuplicate = false
				for s, removedTraitData in pairs( removedWeaponTraits ) do
					if AreTraitsIdentical( removedTraitData, traitToRemove ) then
						hasDuplicate = true
						break
					end
				end
				if not hasDuplicate then
					table.insert( removedWeaponTraits, traitData )
				end
			end
		end

		for i, removedTraitData in pairs(removedWeaponTraits) do
			RemoveTraitData( CurrentRun.Hero, removedTraitData, { SkipUIUpdate = true } )
		end

		PreLoadBinks({ Names = WeaponData[weaponName].Binks })
		local affectedWeapons = { weaponName }
		EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = weaponName })
		if weaponSetNames ~= nil then
			for k, linkedWeaponName in pairs( weaponSetNames ) do
				EquipWeapon({ DestinationId = CurrentRun.Hero.ObjectId, Name = linkedWeaponName })
				table.insert( affectedWeapons, linkedWeaponName )
			end
		end
		for _, affectedWeaponName in pairs( affectedWeapons ) do
			for i, traitData in pairs(CurrentRun.Hero.Traits) do
				if traitData.PropertyChanges ~= nil then
					for _, propertyChange in pairs(traitData.PropertyChanges) do
						if propertyChange.WeaponName == affectedWeaponName or ( propertyChange.WeaponNames ~= nil and Contains( propertyChange.WeaponNames, affectedWeaponName )) then
							ApplyUnitPropertyChange( CurrentRun.Hero, propertyChange, false )
						end
					end
				end
			end

			-- reverse any synergy traits that acted on the removed trait
			for i, traitData in pairs(CurrentRun.Hero.Traits) do
				if traitData.PropertyChanges ~= nil then
					for _, propertyChange in pairs(traitData.PropertyChanges) do
						if propertyChange.TraitName == traitName and ( propertyChange.WeaponName == affectedWeaponName or ( propertyChange.WeaponNames ~= nil and Contains( propertyChange.WeaponNames, affectedWeaponName ))) then
							ApplyUnitPropertyChange( CurrentRun.Hero, propertyChange, false, true )
						end
					end
				end
			end

			for upgradeName, amount in pairs( CurrentRun.MetaUpgrades or GameState.MetaUpgrades ) do
				local upgradeData = MetaUpgradeData[upgradeName]
				local hasAffectedMetaUpgrade = false
				if IsMetaUpgradeActive(upgradeName) and upgradeData and upgradeData.PropertyChanges ~= nil then
					for _, propertyChange in pairs( upgradeData.PropertyChanges) do
						if ( propertyChange.WeaponNames ~= nil and Contains(propertyChange.WeaponNames, affectedWeaponName )) or ( propertyChange.WeaponName ~= nil and propertyChange.WeaponName == affectedWeaponName ) then
							hasAffectedMetaUpgrade = true
							break
						end
					end

					if hasAffectedMetaUpgrade then
						for i = 1, amount do
							ApplyMetaUpgrade( upgradeData, applyLuaUpgrades, i == 1 )
						end
					end
				end
			end
		end 

		for i, removedTraitData in pairs(removedWeaponTraits) do
			if removedTraitData.IsWeaponEnchantment and CurrentRun.CurrentRoom.LoadedAmmo then
				RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "RangedWeapon", Method = "RefillAmmo" })
				CurrentRun.CurrentRoom.ValidVolleys = {}
				CurrentRun.CurrentRoom.LoadedAmmo = 0
				CurrentRun.Hero.StoredAmmo = {}
				Destroy({ Ids = ScreenAnchors.SelfStoredAmmo })
				thread( UpdateAmmoUI )
			end
			AddTraitToHero({ TraitData = removedTraitData, SkipPriorityTray = true })
		end
		

		UpdateHeroTraitDictionary()
	end
end

function RemoveDashBoons()
	local traitName = nil
	for i, trait in pairs(CurrentRun.Hero.Traits) do
		if trait.Slot == "Rush" then
			traitName = trait.Name
			break
		end
	end
	if traitName then
		RemoveWeaponTrait(traitName)
	end
end

function RemoveTrait( unit, traitName, args )
	for k, trait in pairs( unit.Traits ) do
		if trait.Name == traitName then
			RemoveTraitData( unit, trait, args )
			return
		end
	end
end

function RemoveTraitData( unit, trait, args )
	args = args or {}
	local traitName = trait.Name
	RemoveValue( unit.Traits, trait )
	if GetTraitCount( unit, trait ) >= 1 and trait.OnDuplicatePropertyChanges ~= nil then
		ApplyUnitPropertyChanges( unit, trait.OnDuplicatePropertyChanges, true, true )
	else
		ApplyUnitPropertyChanges( unit, trait.PropertyChanges, true, true )
		if GetTraitCount( unit, trait ) <= 0 then
			Destroy({ Id = unit.TraitAnimationAnchors[traitName]})
		end
	end
	if unit == CurrentRun.Hero and not args.SkipUIUpdate then
		UpdateHeroTraitDictionary()
		PriorityTrayTraitRemove( trait )
		TraitUIRemove( trait )
	end
	
	if trait.AddOutgoingLifestealModifiers and unit.OutgoingLifestealModifiers then	
		for modifierIndex, modifier in pairs(unit.OutgoingLifestealModifiers) do
			if modifier.Name == trait.Name then
				unit.OutgoingLifestealModifiers[modifierIndex] = nil
				break
			end
		end
	end

	if trait.AddIncomingDamageModifiers and unit.IncomingDamageModifiers ~= nil then
		RemoveIncomingDamageModifier( unit, trait.Name )
	end
	if trait.AddOutgoingDamageModifiers then
		for modifierIndex, modifier in pairs(unit.OutgoingDamageModifiers) do
			if modifier.Name == trait.Name then
				unit.OutgoingDamageModifiers[modifierIndex] = nil
				break
			end
		end
	end
	if trait.AccumulatedDodgeBonus then
		SetLifeProperty({ Property = "DodgeChance", Value = -1 * trait.AccumulatedDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
		SetUnitProperty({ Property = "Speed", Value = 1/( 1 + trait.AccumulatedDodgeBonus ), ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
	end
	RemoveAssistWeapons( unit, trait )
	RemoveWallSlamWeapons( unit, trait )
	RemoveOnHitWeapons( unit, trait )
	RemoveOnFireWeapons( unit, trait )
	for weaponName, v in pairs( unit.Weapons ) do
		RemoveOnDamageWeapons(unit, weaponName, trait )
	end
	if trait.WeaponDataOverride then
		if unit.WeaponDataOverride then
			for key, data in pairs(trait.WeaponDataOverride) do
				unit.WeaponDataOverride[key] = nil
			end

			-- reapply any other weapon data overrides
			for i, traitData in pairs( unit.Traits ) do
				if traitData.WeaponDataOverride then
					for key, data in pairs(traitData.WeaponDataOverride) do
						if unit.WeaponDataOverride[key] then
							unit.WeaponDataOverride[key] = MergeTables(unit.WeaponDataOverride[key], data )
						else
							unit.WeaponDataOverride[key] = MergeTables(WeaponData[key], data )
						end
					end
				end
			end
		end
	end

	if trait.OnExpire ~= nil then
		local expiringActions = trait.OnExpire
		thread( HeroTraitTransformPresentation, trait )
		if expiringActions.Traits then
			for i, onExpireTraitName in pairs(expiringActions.Traits) do
				AddTrait(unit, onExpireTraitName, nil, { Id = trait.Id })
			end
		end
		if expiringActions.TraitData then
			expiringActions.TraitData.TraitTitle = trait.TraitTitle
			expiringActions.TraitData.Id = trait.Id
			AddTraitData( unit, expiringActions.TraitData )
		end

		-- Act on properties after properties have changed
		if expiringActions.HealAmount ~= nil then
			Heal( unit, { HealAmount = expiringActions.HealAmount, Name = traitName.."Expire" } )
			thread( UpdateHealthUI )
		end
	end
end

function UseTrait( unit, traitName )
	local removedTraits = {}
	for k, trait in pairs( unit.Traits ) do
		if trait.Name == traitName then
			UseTraitData( unit, trait )
			if trait.RemainingUses ~= nil and trait.RemainingUses <= 0 then
				table.insert( removedTraits, trait )
			end
		end
	end
	for _, trait in pairs( removedTraits ) do
		RemoveTraitData( unit, trait )
	end
	return nil
end

function UseTraitData( unit, trait )
	if trait.AffectChance ~= nil and RandomChance( trait.AffectChance ) then
		return trait
	elseif trait.RemainingUses ~= nil then
		trait.RemainingUses = trait.RemainingUses - 1
		return trait
	elseif trait.CurrentCooldown ~= nil then
		PutTraitOnCooldown(trait)
		return trait
	end
	return nil
end

function PutTraitOnCooldown( traitData )
	DebugAssert({ Condition = traitData.CurrentCooldown ~= nil and (traitData.TimeCooldown ~= nil or traitData.RoomCooldown ~= nil), Text = "Putting on cooldown a trait (" .. traitData.Name ..") that has no cooldown data!"})
	traitData.CurrentCooldown = 0
	TraitUIUpdateText(traitData)
	if traitData.TimeCooldown then
		thread(WaitAndReactivate, traitData )
	end
end

function WaitAndReactivate( traitData )
	wait( traitData.TimeCooldown, RoomThreadName )
	IncrementTraitCooldown( traitData, traitData.TimeCooldown)
end

function IsTraitActive( traitData )

	if traitData.Uses ~= nil and traitData.Uses <= 0 then
		return false
	end

	if traitData.CurrentCooldown == nil or ( traitData.RoomCooldown == nil and traitData.TimeCooldown == nil ) then
		return true
	end

	if traitData.RoomCooldown ~= nil then
		return traitData.CurrentCooldown >= traitData.RoomCooldown
	end

	if traitData.TimeCooldown ~= nil then
		return traitData.CurrentCooldown >= traitData.TimeCooldown
	end
	return true
end

function IncrementTraitCooldown( traitData, increment )
	increment = increment or 1
	if traitData.CurrentCooldown == nil or ( traitData.RoomCooldown == nil and traitData.TimeCooldown == nil ) then
		return
	end

	if traitData.RoomCooldown ~= nil then
		local wasActive = traitData.CurrentCooldown == traitData.RoomCooldown
		traitData.CurrentCooldown = math.min(traitData.CurrentCooldown + increment, traitData.RoomCooldown)
		local nowActive = traitData.CurrentCooldown == traitData.RoomCooldown

		if nowActive and not wasActive and traitData.ReactivateFunction ~= nil then
			_G[traitData.ReactivateFunction]()
			TraitUIUpdateText(traitData)
		end
	else
		local wasActive = traitData.CurrentCooldown == traitData.TimeCooldown
		traitData.CurrentCooldown = math.min(traitData.CurrentCooldown + increment, traitData.TimeCooldown)
		local nowActive = traitData.CurrentCooldown == traitData.TimeCooldown

		if nowActive and not wasActive and traitData.ReactivateFunction ~= nil then
			_G[traitData.ReactivateFunction]()
			TraitUIUpdateText(traitData)
		end
	end
end

function ApplyLinkedTraitPropertyChanges(unit, newTraitData )
	if not Contains( unit.Traits, newTraitData ) then
		DebugPrint({Text = "Warning! ApplyLinkedTraitPropertyChanges only works for traits have already been applied!"})
	end

	for i, traitData in pairs( unit.Traits ) do
		if traitData ~= newTraitData and traitData.PropertyChanges ~= nil then
			for s, propertyChange in pairs(traitData.PropertyChanges) do
				if propertyChange.TraitName == newTraitData.Name then
					ApplyUnitPropertyChange( unit, propertyChange, true )
				end
			end
		end
	end
end

function SetupSuperDamageBonus()
	CurrentRun.Hero.LastSuperDamageBonus = 0
	UpdateSuperDamageBonus()
end

function UpdateSuperDamageBonus()
	local bonus = GetTotalHeroTraitValue("DamagePerSuperStock") * math.floor(CurrentRun.Hero.SuperMeter/CurrentRun.Hero.SuperCost)
	if CurrentRun.Hero.LastSuperDamageBonus == nil then
		CurrentRun.Hero.LastSuperDamageBonus = 0
	end

	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "DamageOutputMultiplier", Value = bonus - CurrentRun.Hero.LastSuperDamageBonus, ValueChangeType = "Add" })
	CurrentRun.Hero.LastSuperDamageBonus = bonus
end

function EquipReferencedWeapons( traitData )
	local weaponKeys = {"PreEquipWeapons", "AddOnHitWeapons", "AddOnDamageWeapons", "AddOnSlamWeapons", "AddOnFireWeapons", "AmmoDropWeapons", "OnSuperWeapons", "OnProjectileReflectWeapons" }
	for i, weaponKey in pairs(weaponKeys) do
		if traitData[weaponKey] ~= nil then
			for i, weaponName in pairs(traitData[weaponKey]) do
				EquipWeapon({ Name = weaponName, DestinationId = CurrentRun.Hero.ObjectId })
				local weaponData = WeaponData[weaponName]
				if weaponData ~= nil and weaponData.Binks ~= nil then
					PreLoadBinks({ Names = weaponData.Binks })
				end
			end
		end
	end

	if traitData.AddAssist and traitData.AddAssist.WeaponName then
		local weaponName = traitData.AddAssist.WeaponName
		EquipWeapon({ Name = weaponName, DestinationId = CurrentRun.Hero.ObjectId })
		local weaponData = WeaponData[weaponName]
		if weaponData ~= nil and weaponData.Binks ~= nil then
			PreLoadBinks({ Names = weaponData.Binks })
		end
	end

	local weaponTableKeys = { "AddOnEnemySpawnWeapon", "AddOnEffectWeapons", "OnEnemyDeathWeapon", "OnImpactWeapons" }
	for i, weaponTableKey in pairs(weaponTableKeys) do
		if traitData[weaponTableKey] ~= nil then
			EquipWeapon({ Name = traitData[weaponTableKey].Weapon, DestinationId = CurrentRun.Hero.ObjectId })
			local weaponData = WeaponData[weaponName]
			if weaponData ~= nil and weaponData.Binks ~= nil then
				PreLoadBinks({ Names = weaponData.Binks })
			end
		end
	end
end

function ApplyTraitSetupFunctions( unit )
	local appliedFunctionNames = {}
	for i, traitData in pairs( unit.Traits ) do
		if traitData.SetupFunction ~= nil and ( not traitData.SetupFunction.RunOnce or appliedFunctionNames[traitData.SetupFunction.Name] == nil ) then
			_G[traitData.SetupFunction.Name]( unit, traitData.SetupFunction.Args)
			appliedFunctionNames[traitData.SetupFunction.Name] = true
		end
		if traitData.LoadBinks ~= nil then
			PreLoadBinks({ Names = traitData.LoadBinks })
		end
	end
end

function IsGodTrait( traitName, args )
	args = args or {}
	for i, god in pairs(LootData) do
		if ( god.GodLoot or ( args.ForShop and god.TreatAsGodLootByShops )) and not god.DebugOnly and god.TraitIndex[traitName] then
			return true
		end
	end

	return false
end

function GetLootSourceName( traitName )
	for lootName, god in pairs(LootData) do
		if ( god.GodLoot or god.TreatAsGodLootByShops ) and not god.DebugOnly and god.TraitIndex[traitName] then
			return lootName
		end
	end
	if TraitData[traitName] and TraitData[traitName].LootSource then
		return TraitData[traitName].LootSource
	end
	return false
end

function GetUpgradableGodTraitName()
	return GetRandomKey( GetAllUpgradeableGodTraits() )
end

function UpgradableGodTraitCountAtLeast( num )
	local count = 0
	local traitNames = {}
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.RemainingUses == nil and IsGodTrait(trait.Name) and not traitNames[trait.Name] then
			traitNames[ trait.Name ] = true
			count = count + 1
			if count >= num then
				return true
			end
		end
	end
	return false
end

function GetAllUpgradeableGodTraits()
	local traitNames = {}
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.RemainingUses == nil and IsGodTrait(trait.Name) then
			traitNames[trait.Name] = true
		end
	end
	return traitNames
end

function GetEligibleTransformingTrait( traitNames )
	local output = {}
	for i, traitName in pairs(traitNames) do
		if IsGameStateEligible(CurrentRun, TraitData[traitName]) then
			table.insert(output, traitName)
		end
	end
	return output
end

function SetTransformingTraitsOnLoot( lootData, upgradeChoiceData )
	DebugAssert({ Condition = not IsEmpty(upgradeChoiceData.PermanentTraits) and not IsEmpty(upgradeChoiceData.TemporaryTraits), Text = "Transforming Loot data is invalid!" })
	local upgradeOptions = {}
	local permanentTraits = GetEligibleTransformingTrait( upgradeChoiceData.PermanentTraits )
	local temporaryTraits = GetEligibleTransformingTrait( upgradeChoiceData.TemporaryTraits )
	lootData.Rarity = {}

	while TableLength( upgradeOptions ) < GetTotalLootChoices() do
		local permanentTraitName = nil
		local temporaryTraitName = nil
		permanentTraitName = RemoveRandomValue(permanentTraits)

		if RandomChance(0.7) then
			temporaryTraitName = RemoveRandomValue(temporaryTraits)
		else
			temporaryTraitName = GetRandomValue(temporaryTraits)
		end

		local upgradeData = { ItemName = permanentTraitName, SecondaryItemName = temporaryTraitName, Type = "TransformingTrait" }

		if TraitData[permanentTraitName].RarityLevels and TableLength( TraitData[permanentTraitName].RarityLevels ) == 1 then
			upgradeData.Rarity = GetFirstKey( TraitData[permanentTraitName].RarityLevels )
		elseif RandomChance( lootData.RarityChances.Epic ) then
			upgradeData.Rarity = "Epic"
		elseif RandomChance( lootData.RarityChances.Rare ) then
			upgradeData.Rarity = "Rare"
		else
			upgradeData.Rarity = "Common"
		end

		table.insert( upgradeOptions, upgradeData )
	end
	lootData.UpgradeOptions = upgradeOptions
end

function CalcNumLootChoices()
	local numChoices = 3 - GetNumMetaUpgrades("ReducedLootChoicesShrineUpgrade")
	return numChoices
end

function GetTotalLootChoices()
	return 3
end

function SetTraitsOnLoot( lootData, args )
	local upgradeName = lootData.Name
	local upgradeChoiceData = LootData[upgradeName]

	if upgradeChoiceData.TransformingTraits then
		return SetTransformingTraitsOnLoot( lootData, upgradeChoiceData )
	end

	local upgradeOptions = {}
	local chosenPriorityTraits = ShallowCopyTable( lootData.PriorityUpgrades )
	if CurrentRun.CurrentRoom.ForceLootTableFirstRun and GetCompletedRuns() == 0 then
		upgradeOptions = GetPriorityTraits( CurrentRun.CurrentRoom.ForceLootTableFirstRun, lootData )
	elseif IsGameStateEligible( CurrentRun, CurrentRun.Hero.BoonData.GameStateRequirements) and RandomChance( CurrentRun.Hero.BoonData.ReplaceChance ) and not lootData.ForceCommon then
		upgradeOptions = GetReplacementTraits( lootData.PriorityUpgrades )
	end

	if IsEmpty( upgradeOptions ) then
		upgradeOptions = GetPriorityTraits( lootData.PriorityUpgrades, lootData )
	else
		for i, upgradeOption in pairs( upgradeOptions ) do
			if IsGameStateEligible(CurrentRun, TraitData[upgradeOption.ItemName]) then
				RemoveValueAndCollapse( chosenPriorityTraits, upgradeOption.ItemName )
			end
		end
	end

	local priorityLinkedTraits = GetPriorityDependentTraits( lootData )
	if priorityLinkedTraits ~= nil then
		for i, linkedTraitData in ipairs( priorityLinkedTraits ) do
			if TableLength( upgradeOptions ) >= GetTotalLootChoices() then
				break
			end
			if RandomChance( linkedTraitData.PriorityChance ) then
				table.insert( upgradeOptions, { ItemName = linkedTraitData.TraitName, Type = "Trait" })
			end
		end
	end
	
	if args and args.ExclusionNames then
		-- Remove values that are excluded
		for i, name in pairs( args.ExclusionNames ) do
			for i, upgradeData in pairs(upgradeOptions) do
				if upgradeData.ItemName == name then
					upgradeOptions[i] = nil
				end
			end
		end
		upgradeOptions = CollapseTable( upgradeOptions )
	end
	local eligibleOptions = {}

	if TableLength( upgradeOptions ) < GetTotalLootChoices() then
		-- don't bother with this expensive calculation if we've filled up on priority traits
		eligibleOptions = GetEligibleUpgrades(upgradeOptions, lootData, upgradeChoiceData)
	end

	-- build legal rarity table
	local rarityTable =
	{
		Common = {},
		Rare = {},
		Epic = {},
		Heroic = {},
		Legendary = {},
	}

	for s, options in pairs({ upgradeOptions, eligibleOptions }) do
		for i, upgradeData in pairs(options) do
			local rarityLevels = nil
			if upgradeData.Type == "Trait" then
				rarityLevels = TraitData[upgradeData.ItemName].RarityLevels
			end
			if upgradeData.Type == "Consumable" then
				rarityLevels = ConsumableData[upgradeData.ItemName].RarityLevels
			end

			if rarityLevels == nil then
				rarityLevels = { Common = true }
			end

			for key, table in pairs( rarityTable ) do
				if rarityLevels[key] ~= nil then
					table[upgradeData.ItemName] = upgradeData
				end
			end
		end
	end

	if args and args.ExclusionNames then
		-- Remove values that are excluded
		for i, name in pairs( args.ExclusionNames ) do
			for key, table in pairs( rarityTable ) do
				table[name] = nil
			end
		end
		upgradeOptions = CollapseTable( upgradeOptions )
	end

	lootData.Rarity = {}
	-- process priority traits. priority traits determine rarity instead of the other way around
	for i, upgradeData in ipairs(upgradeOptions) do
		if upgradeData.Rarity then
			upgradeOptions[i].Rarity = upgradeData.Rarity
		elseif rarityTable.Legendary[upgradeData.ItemName] and lootData.RarityChances.Legendary and RandomChance( lootData.RarityChances.Legendary ) then
			upgradeOptions[i].Rarity = "Legendary"
		elseif rarityTable.Epic[upgradeData.ItemName] and lootData.RarityChances.Heroic and RandomChance( lootData.RarityChances.Heroic) then
			upgradeOptions[i].Rarity = "Heroic"
		elseif rarityTable.Epic[upgradeData.ItemName] and lootData.RarityChances.Epic and RandomChance( lootData.RarityChances.Epic ) then
			upgradeOptions[i].Rarity = "Epic"
		elseif rarityTable.Rare[upgradeData.ItemName] and lootData.RarityChances.Rare and RandomChance( lootData.RarityChances.Rare ) then
			upgradeOptions[i].Rarity = "Rare"
		else
			upgradeOptions[i].Rarity = "Common"
		end
		rarityTable.Legendary[upgradeData.ItemName] = nil
		rarityTable.Heroic[upgradeData.ItemName] = nil
		rarityTable.Epic[upgradeData.ItemName] = nil
		rarityTable.Rare[upgradeData.ItemName] = nil
		rarityTable.Common[upgradeData.ItemName] = nil
	end

	-- fill rest with eligible traits
	for i = TableLength(upgradeOptions), GetTotalLootChoices() - 1 do
		local validRarities =
		{
			Rare = not IsEmpty(rarityTable.Rare),
			Epic = not IsEmpty(rarityTable.Epic),
			Heroic = not IsEmpty(rarityTable.Heroic),
			Legendary = not IsEmpty(rarityTable.Legendary),
		}

		local chosenUpgrade = nil
		local chosenRarity = "Common"
		if validRarities.Legendary and lootData.RarityChances.Legendary and RandomChance( lootData.RarityChances.Legendary ) then
			chosenRarity = "Legendary"
			chosenUpgrade = GetRandomValue( rarityTable.Legendary )
		elseif validRarities.Heroic and lootData.RarityChances.Heroic and RandomChance( lootData.RarityChances.Heroic ) then
			chosenRarity = "Heroic"
			chosenUpgrade = GetRandomValue( rarityTable.Heroic )
		elseif validRarities.Epic and lootData.RarityChances.Epic and RandomChance( lootData.RarityChances.Epic ) then
			chosenRarity = "Epic"
			chosenUpgrade = GetRandomValue( rarityTable.Epic )
		elseif validRarities.Rare and lootData.RarityChances.Rare and RandomChance( lootData.RarityChances.Rare ) then
			chosenRarity = "Rare"
			chosenUpgrade = GetRandomValue( rarityTable.Rare )
		else
			chosenRarity = "Common"
			chosenUpgrade = GetRandomValue( rarityTable.Common )
		end

		if chosenUpgrade then
			chosenUpgrade.Rarity = chosenRarity
			table.insert(upgradeOptions, chosenUpgrade)
			rarityTable.Legendary[chosenUpgrade.ItemName] = nil
			rarityTable.Heroic[chosenUpgrade.ItemName] = nil
			rarityTable.Epic[chosenUpgrade.ItemName] = nil
			rarityTable.Rare[chosenUpgrade.ItemName] = nil
			rarityTable.Common[chosenUpgrade.ItemName] = nil
		end
	end

	-- Fill empty spots with exchange traits
	for i = TableLength(upgradeOptions), GetTotalLootChoices() - 1 do
		if IsEmpty(chosenPriorityTraits) then
			break
		end
		local chosenUpgrades =  GetReplacementTraits( chosenPriorityTraits )
		if chosenUpgrades == nil or chosenUpgrades[1] == nil then
			break
		end
		local chosenUpgrade = chosenUpgrades[1]
		table.insert( upgradeOptions, chosenUpgrade )
		RemoveValueAndCollapse( chosenPriorityTraits, chosenUpgrade.ItemName )
	end

	-- Fill empty spots with any traits that failed the rarity check the first time around
	for i = TableLength(upgradeOptions), GetTotalLootChoices() - 1 do
		local validRarities =
		{
			Rare = not IsEmpty(rarityTable.Rare),
			Epic = not IsEmpty(rarityTable.Epic),
			Heroic = not IsEmpty(rarityTable.Heroic),
			Legendary = not IsEmpty(rarityTable.Legendary),
		}

		local chosenUpgrade = nil
		local chosenRarity = "Common"
		if validRarities.Rare and lootData.RarityChances.Rare then
			chosenRarity = "Rare"
			chosenUpgrade = GetRandomValue( rarityTable.Rare )
		elseif validRarities.Epic and lootData.RarityChances.Epic then
			chosenRarity = "Epic"
			chosenUpgrade = GetRandomValue( rarityTable.Epic )
		elseif validRarities.Heroic and lootData.RarityChances.Heroic then
			chosenRarity = "Heroic"
			chosenUpgrade = GetRandomValue( rarityTable.Heroic )
		elseif validRarities.Legendary and lootData.RarityChances.Legendary then
			chosenRarity = "Legendary"
			chosenUpgrade = GetRandomValue( rarityTable.Legendary )
		else
			chosenRarity = "Common"
			chosenUpgrade = GetRandomValue( rarityTable.Common )
		end
		
		if chosenUpgrade then
			chosenUpgrade.Rarity = chosenRarity
			table.insert(upgradeOptions, chosenUpgrade)
			rarityTable.Legendary[chosenUpgrade.ItemName] = nil
			rarityTable.Heroic[chosenUpgrade.ItemName] = nil
			rarityTable.Epic[chosenUpgrade.ItemName] = nil
			rarityTable.Rare[chosenUpgrade.ItemName] = nil
			rarityTable.Common[chosenUpgrade.ItemName] = nil
		end
	end

	-- Block rerolling if we truly have no options left
	local blockReroll = IsEmpty( chosenPriorityTraits ) and ( not args or IsEmpty( args.ExclusionNames ))
	for rarity, validTraits in pairs(rarityTable ) do
		if blockReroll and not IsEmpty( validTraits ) then
			blockReroll = false
		end
	end
	lootData.BlockReroll = blockReroll
	lootData.UpgradeOptions = upgradeOptions
end

function ExtractValues( unit, topLevelTable, table )
	local mergeBackValues = false
	if topLevelTable == table then
		topLevelTable = {}
		mergeBackValues = true
	end

	if table.ExtractValues ~= nil then
		for i, extractData in pairs(table.ExtractValues) do
			ExtractValue(unit, topLevelTable, table, extractData)
		end
	end

	if table.ExtractValue ~= nil then
		ExtractValue( unit, topLevelTable, table )
	end

	for key, value in pairs( table ) do
		if type( value ) == "table" then
			ExtractValues(unit, topLevelTable, value )
		end
	end

	if mergeBackValues then
		for key, value in pairs(topLevelTable) do
			table[key] = value
		end
	end
end

function ExtractValue( unit, extractToTable, table, extractData)
	if extractData == nil then
		if table.ExtractValue == nil then
			return
		end
		extractData = table.ExtractValue
	end
	local value = nil

	if extractData.External then
		DebugAssert({Condition = extractData.BaseType ~= nil, Text = "Extracting a PercentOfBase value without valid type reference (Projectile, Weapon, or WeaponEffect)" })
		DebugAssert({Condition = extractData.BaseName ~= nil, Text = "Extracting a PercentOfBase value without a name." })
		DebugAssert({Condition = extractData.BaseProperty ~= nil, Text = "Extracting a PercentOfBase value without a property." })
		if extractData.BaseType == "Projectile" then
			value = GetProjectileProperty({ Id = unit.ObjectId, WeaponName = extractData.BaseName, Property = extractData.BaseProperty })
		elseif extractData.BaseType == "Effect" then
			value = GetEffectDataValue({ WeaponName = extractData.WeaponName, EffectName = extractData.BaseName, Property = extractData.BaseProperty })
		elseif extractData.BaseType == "ProjectileBase" then
			value = GetBaseDataValue({ Type = "Projectile", Name = extractData.BaseName, Property = extractData.BaseProperty })
		elseif extractData.BaseType == "Weapon" then
			value = GetBaseDataValue({ Type = extractData.BaseType, Name = extractData.BaseName, Property = extractData.BaseProperty })
		else
			DebugAssert({Condition = false, Text = "Trying to find an external value on unsupported type " .. extractData.BaseType})
		end
	elseif extractData.Format == "EasyModeMultiplier" then
		value = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel ) ) * 100 )
	elseif extractData.Format == "TotalMetaUpgradeChangeValue" then
		local name = extractData.MetaUpgradeName
		local numUpgrades = GetNumMetaUpgrades( name )
		local upgradeData = MetaUpgradeData[name]
		value = GetTotalStatChange( upgradeData )
	elseif extractData.Format == "ExistingAmmoDropDelay" then
		local ammoDivisor = GetTotalHeroTraitValue( "AmmoReclaimTimeDivisor" )
		if ammoDivisor == 0 then
			ammoDivisor = 1
		end
		value = math.max(0.1, WeaponData.RangedWeapon.AmmoDropDelay / ammoDivisor)
	elseif extractData.Format == "ExistingAmmoReloadDelay" then
		local ammoDivisor = GetTotalHeroTraitValue( "AmmoReloadTimeDivisor" )
		if ammoDivisor == 0 then
			ammoDivisor = 1
		end
		value = math.max(0.1, GetBaseAmmoReloadTime() / ammoDivisor)
	elseif extractData.Format == "ExistingWrathStocks" then
		if not CurrentRun or not CurrentRun.Hero or not CurrentRun.Hero.SuperMeterLimit or not CurrentRun.Hero.SuperCost then
			value = 1
		else
			value = CurrentRun.Hero.SuperMeterLimit / CurrentRun.Hero.SuperCost
		end
	elseif extractData.Format == "EXWrathDuration" then
		value = table.SuperDuration * table.MaxDurationMultiplier
	else
		if extractData.Key == nil then
			extractData.Key = "ChangeValue"
		end
		local keyToExtract = extractData.Key
		if table[keyToExtract] == nil then
			DebugPrint({Text = "Attempting to extract nonexistent key" .. keyToExtract .. " from " .. tostring(extractData.ExtractAs)})
			return
		end
		value = table[keyToExtract]
		if extractData.Format == "MaxHealth" then
			value = GetMaxHealthUpgradeIncrement( value )
		end
	end

	if value ~= nil then
		extractToTable[extractData.ExtractAs] = FormatExtractedValue(value, extractData)
	end
end

function ExtractTotalValues(unit, newTraitData )
	local isOnUnit = Contains(unit.Traits, newTraitData)
	local heroHasIdenticalTrait = HeroHasTrait( newTraitData.Name )
	if newTraitData.ForBoonInfo then
		heroHasIdenticalTrait = false
	end
	local extractedData = GetExtractData(newTraitData)
	newTraitData.NewTotals = {}

	for i, data in pairs(extractedData) do
		local key = data.ExtractAs
		local total = 0
		local incrementedTotal = 0
		if data.Format == "NegativePercentDelta" then
			total = 1
			for s, traitData in pairs(CurrentRun.Hero.Traits) do
				if AreTraitsIdentical(traitData, newTraitData) then
					total = total * (1 - traitData[key]/100.0)
				end
			end
			newTraitData[data.ExtractAs.."Total"] = FormatExtractedValue(total, data)
			if not isOnUnit then
				incrementedTotal = total * (1 - newTraitData[key]/100.0)

				newTraitData[data.ExtractAs.."NewTotal"] = FormatExtractedValue(incrementedTotal, data)
			end
		elseif data.Format == "AmmoDelayDivisor" then
			total = 0
			for s, traitData in pairs(CurrentRun.Hero.Traits) do
				if traitData.AmmoReclaimTimeDivisor then
					total = total + traitData.AmmoReclaimTimeDivisor
				end
			end
			if total ~= 0 then
				newTraitData[data.ExtractAs.."Total"] = FormatExtractedValue(total, data)
			else
				newTraitData[data.ExtractAs.."Total"] = FormatExtractedValue(1, data)
			end

			if not isOnUnit then
				if newTraitData.AmmoReclaimTimeDivisor then
					incrementedTotal = total + newTraitData.AmmoReclaimTimeDivisor
				end
				if incrementedTotal ~= 0 then
					newTraitData[data.ExtractAs.."NewTotal"] = FormatExtractedValue(incrementedTotal, data)
				end
			end
		elseif data.Format == "AmmoReloadDivisor" then
			total = 0
			for s, traitData in pairs(CurrentRun.Hero.Traits) do
				if traitData.AmmoReloadTimeDivisor then
					total = total + traitData.AmmoReloadTimeDivisor
				end
			end
			if total ~= 0 then
				newTraitData[data.ExtractAs.."Total"] = FormatExtractedValue(total, data)
			else
				newTraitData[data.ExtractAs.."Total"] = FormatExtractedValue(1, data)
			end

			if not isOnUnit then
				if newTraitData.AmmoReloadTimeDivisor then
					incrementedTotal = total + newTraitData.AmmoReloadTimeDivisor
				end
				if incrementedTotal ~= 0 then
					newTraitData[data.ExtractAs.."NewTotal"] = FormatExtractedValue(incrementedTotal, data)
				end
			end
		else
			for s, traitData in pairs(CurrentRun.Hero.Traits) do
				if AreTraitsIdentical(traitData, newTraitData) then
					total = total + traitData[key]
				end
			end
			newTraitData[data.ExtractAs.."Total"] = total
			if not isOnUnit then
				incrementedTotal = total + newTraitData[key]
				newTraitData[data.ExtractAs.."NewTotal"] = incrementedTotal
			end
		end

		if not isOnUnit then
			if  not heroHasIdenticalTrait then
				newTraitData[data.ExtractAs.."TotalPercentIncrease"] = TraitUI.NEW_TRAIT_TOKEN
			else
				newTraitData[data.ExtractAs.."TotalPercentIncrease"] = round((newTraitData[data.ExtractAs.."NewTotal"] - newTraitData[data.ExtractAs.."Total"])/newTraitData[data.ExtractAs.."Total"] * 100)
			end
		end
	end
end

function FormatExtractedValue(value, extractData)
	if extractData.Format ~= nil then
		if extractData.Format == "MultiplyByBase" then
			DebugAssert({Condition = extractData.BaseType ~= nil, Text = "Extracting a PercentOfBase value without valid type reference (Projectile, Weapon, or WeaponEffect)" })
			DebugAssert({Condition = extractData.BaseName ~= nil, Text = "Extracting a PercentOfBase value without a name." })
			DebugAssert({Condition = extractData.BaseProperty ~= nil, Text = "Extracting a PercentOfBase value without a property." })
			local baseDataValue = GetBaseDataValue({Type = extractData.BaseType, Name = extractData.BaseName, Property = extractData.BaseProperty })
			value = value * baseDataValue
		elseif extractData.Format == "PercentOfBase" then
			DebugAssert({Condition = extractData.BaseType ~= nil, Text = "Extracting a PercentOfBase value without valid type reference (Projectile, Weapon, or WeaponEffect)" })
			DebugAssert({Condition = extractData.BaseName ~= nil, Text = "Extracting a PercentOfBase value without a name." })
			DebugAssert({Condition = extractData.BaseProperty ~= nil, Text = "Extracting a PercentOfBase value without a property." })
			local baseDataValue = GetBaseDataValue({Type = extractData.BaseType, Name = extractData.BaseName, Property = extractData.BaseProperty })
			value = (value / baseDataValue) * 100
		elseif extractData.Format == "Percent" then
			-- eg 0.5 becomes "50"
			value = value * 100
		elseif extractData.Format == "AmmoDelayDivisor" then
			DebugAssert({ Condition = value ~= 0, Text = "A divisor formatted value is zero!" .. value .. " " .. tostring(extractData.Key) })
			value = WeaponData.RangedWeapon.AmmoDropDelay / value
		elseif extractData.Format == "AmmoReloadDivisor" then
			DebugAssert({ Condition = value ~= 0, Text = "A divisor formatted value is zero!" .. value .. " " .. tostring(extractData.Key) })
			value = GetBaseAmmoReloadTime() / value
		elseif extractData.Format == "PercentDelta" then
			-- eg 1.3 becomes "30"
			value = (value - 1) * 100
		elseif extractData.Format == "NegativePercentDelta" then
			-- eg. 0.7 becomes "-30"
			value = (1 - value) * 100
		elseif extractData.Format == "PercentHeal" then
			value = value * CalculateHealingMultiplier()
			value = value * 100
		elseif extractData.Format == "PercentPlayerHealth" or extractData.Format == "PercentPlayerHealthFountain" then
			if CurrentRun.Hero ~= nil then
				local maxLife = CurrentRun.Hero.MaxHealth
				if maxLife == nil then
					return 0
				else
					if extractData.Format == "PercentPlayerHealthFountain" then
						value = value + GetTotalHeroTraitValue( "FountainHealFractionBonus" )
						local healFractionOverride = GetTotalHeroTraitValue("FountainHealFractionOverride") 
						if healFractionOverride > 0 then
							value = healFractionOverride
						end
					end
					value = value * CalculateHealingMultiplier()
					if value > 1 then 
						value = 1 
					end
					value = maxLife * value
				end
			else
				value = value * 100 .. "%"
			end
		elseif extractData.Format == "HealingDrop" then
			local baseHealFraction = ConsumableData[extractData.ConsumableName].HealFraction
			local healingMultiplier = CalculatePositiveHealingMultiplier() + ( value - 1 )
			healingMultiplier = healingMultiplier * ( 1 - GetNumMetaUpgrades("HealingReductionShrineUpgrade") * ( MetaUpgradeData.HealingReductionShrineUpgrade.ChangeValue - 1 ) )
			if CurrentRun.Hero ~= nil then
				local maxLife = CurrentRun.Hero.MaxHealth
				if maxLife == nil then
					return 0
				else
					value = maxLife * baseHealFraction
					-- @hack More special casing that probably doesn't belong here and may not always be wanted.  Sorry back at you Alice!
					value = value * healingMultiplier
				end
			else
				value = value * 100 .. "%"
			end

		elseif extractData.Format == "DamageOverTime" then
			DebugAssert({Condition = extractData.BaseProperty ~= nil or extractData.BaseValue ~= nil, Text = "Extracting a DamageOverTime value without a property." })
			local fuse = 1
			if extractData.BaseValue ~= nil then
				fuse = extractData.BaseValue
			elseif extractData.WeaponName ~=  nil then
				if extractData.BaseName ~= nil then
					fuse = GetEffectDataValue({ WeaponName = extractData.WeaponName, EffectName = extractData.BaseName, Property = extractData.BaseProperty })
				else
					fuse = GetBaseDataValue({ Type = "Weapon", Name = extractData.WeaponName, Property = extractData.BaseProperty })
				end
			else
				fuse = GetBaseDataValue({Type = "Projectile", Name = extractData.BaseName, Property = extractData.BaseProperty })
			end
			value = value / fuse
		elseif extractData.Format == "SeekDuration" then
			local deceleration = -1 * GetBaseDataValue({Type = "Projectile", Name = extractData.BaseName, Property = "AdjustRateAcceleration" })
			value = value / deceleration
		elseif extractData.Format == "WrathStocks" then
			value = CalculateSuperMeter() / value
		end
	end

	local precision = 0
	if extractData.DecimalPlaces ~= nil then
		precision = extractData.DecimalPlaces
	end
	if extractData.AbsoluteValue ~= nil then
		value = math.abs(value)
	end
	return round( value, precision )
end

function GetExtractData(newTraitData, includeExternal)
	local extractedData = {}
	if newTraitData.ExtractValues ~= nil then
		for i, extractData in pairs(newTraitData.ExtractValues) do
			if (includeExternal or not extractData.External) then
				table.insert(extractedData, extractData)
			end
		end
	end

	local extractData = newTraitData.ExtractValue
	if extractData ~= nil and (includeExternal or not extractData.External) then
		table.insert(extractedData, extractData)
	end

	for key, value in pairs( newTraitData ) do
		if type( value ) == "table" and key ~= "ExtractValue" and key ~= "ExtractValues" and key ~= "RarityLevels" then
			local data = GetExtractData( value, includeExternal )
			extractedData = CombineTables( extractedData, data )
		end
	end

	return extractedData
end

function SetTraitTextData ( traitData, args )
	if args == nil then
		args = {}
	end

	ExtractValues( CurrentRun.Hero, traitData, traitData )
	ExtractTotalValues( CurrentRun.Hero, traitData)

	if args.ReplacementTraitData then
		ExtractValues( CurrentRun.Hero, args.ReplacementTraitData, args.ReplacementTraitData )
		ExtractTotalValues( CurrentRun.Hero, args.ReplacementTraitData )
		GameState.InspectData = args.ReplacementTraitData
	end

	local extractedData = GetExtractData( traitData )
	-- needs to be ordered properly @alice
	traitData.Additional = {}
	traitData.OldTotal = {}
	traitData.NewTotal = {}
	traitData.PercentIncrease = {}
	local extractedIndex = 0
	for i, data in pairs(extractedData) do
		if data.SkipAutoExtract == nil then
			extractedIndex = extractedIndex + 1
			local key = data.ExtractAs
			traitData.Additional[extractedIndex] = traitData[key]
			traitData.OldTotal[extractedIndex] = traitData[key.."Total"]
			if args.ReplacementTraitData then
				traitData.OldTotal[extractedIndex] = traitData[key]
				traitData.NewTotal[extractedIndex] = args.ReplacementTraitData[key]
			elseif args.OldOnly then
				traitData.NewTotal[extractedIndex] = traitData[key.."Total"]
			else
				traitData.NewTotal[extractedIndex] = traitData[key.."NewTotal"]
			end
			traitData.PercentIncrease[extractedIndex] = traitData[key.."TotalPercentIncrease"]
			traitData["DisplayDelta"..extractedIndex] = "Increase"..extractedIndex

			if data.Format ~= nil and Contains({ "Percent", "PercentDelta", "NegativePercentDelta", "PercentOfBase", "Divisor"}, data.Format ) then
				traitData["OldTotal"..extractedIndex] = "PercentOldTotal"..extractedIndex
				traitData["Increase"..extractedIndex] = "PercentIncrease"..extractedIndex
				traitData["NewTotal"..extractedIndex] = "PercentNewTotal"..extractedIndex
				if args.OldOnly then
					traitData["NewTotal"..extractedIndex] = "PercentTotal"..extractedIndex
					traitData["DisplayDelta"..extractedIndex] = "PercentTotal"..extractedIndex
				end
			else
				traitData["Increase"..extractedIndex] = "Increase"..extractedIndex
				traitData["OldTotal"..extractedIndex] = "OldTotal"..extractedIndex
				traitData["NewTotal"..extractedIndex] = "NewTotal"..extractedIndex
				if args.OldOnly then
					traitData["NewTotal"..extractedIndex] = "Total"..extractedIndex
					traitData["DisplayDelta"..extractedIndex] = "Total"..extractedIndex
				end
			end

			if traitData[key.."TotalPercentIncrease"] == TraitUI.NEW_TRAIT_TOKEN then
				traitData["TotalPercentIncrease"..extractedIndex] = "NewTraitPrefix"
			else
				traitData["TotalPercentIncrease"..extractedIndex] = "TotalPercentIncrease"..extractedIndex
			end
		end
	end
end

function AddStackToTraits( source, args )
	if not args then
		args = ShallowCopyTable(source)
		source = {}
	end

	if args.Thread then
		args.Thread = false
		thread( AddStackToTraits, source, args )
		return
	end
	wait( args.Delay )

	local numStacks = args.NumStacks
	local numTraits = args.NumTraits

	-- do we need to freeze the player?
	local upgradableTraits = {}
	local upgradedTraits = {}

	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if IsGodTrait(traitData.Name) and TraitData[traitData.Name] and IsGameStateEligible(CurrentRun, TraitData[traitData.Name]) then
			upgradableTraits[traitData.Name] = true
		end
	end

	while numTraits > 0 and not IsEmpty( upgradableTraits ) do
		local name = RemoveRandomKey( upgradableTraits )
		upgradedTraits[name] = true
		for s = 1, numStacks do
			AddTraitToHero({ TraitName = name, SkipUIUpdate = true })
		end
		numTraits = numTraits - 1
	end

	UpdateHeroTraitDictionary()
	SortPriorityTraits()

	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if upgradedTraits[traitData.Name] then
			wait(0.1)
			TraitUIUpdateText( traitData )
		end
	end
	
	thread( IncreasedTraitLevelPresentation, upgradedTraits, numStacks )
end

function ChaosHammerUpgrade( args )
	args = args or {}
	local hammerTraits = {}
	local addedTraits = {}
	local numTraits = args.NumTraits or 2
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if LootData.WeaponUpgrade.TraitIndex[trait.Name] then
			table.insert(hammerTraits, trait.Name )
		end
	end

	-- remove one weapon trait
	local removedTraitName = nil
	if not IsEmpty( hammerTraits ) then
		removedTraitName = RemoveRandomValue( hammerTraits )
		RemoveWeaponTrait( removedTraitName )
	end

	for i = 1, numTraits do
		local validTraitNames = {}
		for i, traitName in pairs( LootData.WeaponUpgrade.Traits ) do
			if IsTraitEligible(CurrentRun, TraitData[traitName]) and traitName ~= removedTraitName and not Contains(hammerTraits, traitName) then
				table.insert( validTraitNames, traitName )
			end
		end

		if not IsEmpty( validTraitNames ) then
			local newTraitName = RemoveRandomValue( validTraitNames )
			AddTraitToHero({ TraitName =  newTraitName })
			table.insert( hammerTraits, newTraitName )
			table.insert( addedTraits, newTraitName )
		end
	end
		
	thread( ChaosHammerPresentation, removedTraitName, addedTraits )
end

function UseStoreRewardRandomStack( args )
	args = args or {}
	if args.NumStacks then
		args.NumStacks = args.NumStacks + GetTotalHeroTraitValue("PomLevelBonus")
	end
	AddStackToTraits( args )
	StoreRewardRandomStackPresentation()
end

function HarvestBoons( args )
	numTraits = args.NumTraits
	local traitRarity = "Common"
	local traitDictionary = {}
	local upgradableTraits = {}
	local upgradedTraits = {}
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if not traitDictionary[traitData.Name] and IsGodTrait(traitData.Name) and TraitData[traitData.Name] and traitData.Rarity ~= nil and GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil then
			table.insert(upgradableTraits, traitData )
			traitDictionary[traitData.Name] = true
		end
	end
	
	local harvestTraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = "HarvestBoonTrait", Rarity = traitRarity })

	harvestTraitData.HarvestBoons = {}

	while numTraits > 0 and not IsEmpty( upgradableTraits ) do
		local traitData = RemoveRandomValue( upgradableTraits )
		local persistentKeys = { "AccumulatedFountainDamageBonus" }
		local persistentValues = {}
		for i, key in pairs( persistentKeys ) do
			persistentValues[key] = traitData[key]
		end

		upgradedTraits[traitData.Name] = true
		table.insert( harvestTraitData.HarvestBoons, traitData.Name )
		local numOldTrait = GetTraitNameCount( CurrentRun.Hero, traitData.Name )
		RemoveWeaponTrait( traitData.Name )

		local processedData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, Rarity = "Common" }) 
		for i, key in pairs( persistentKeys ) do
			processedData[key] = persistentValues[key]
		end
		AddTraitToHero({ TraitData = processedData })

		for i=1, numOldTrait-1 do
			AddTraitToHero({ TraitName = traitData.Name })
		end
		numTraits = numTraits - 1
	end

	
	harvestTraitData.TraitListTextString = "HarvestBoonTraitList"..tostring(TableLength(harvestTraitData.HarvestBoons))
	thread( HarvestBoonTraitPresentation, upgradedTraits, 2.0 )
	AddTraitToHero({TraitData = harvestTraitData })
end

function UpgradeChamberStacks()
	RandomSynchronize( GetRunDepth( CurrentRun ))
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.Name == "ChamberStackTrait" then
			IncrementTableValue( trait, "CurrentRoom" )
			if trait.RoomsPerUpgrade and trait.CurrentRoom < trait.RoomsPerUpgrade then			
				UpdateTraitNumber( trait )
				return
			else
				trait.CurrentRoom = 0			
				UpdateTraitNumber( trait )
			end

			AddStackToTraits({ NumTraits = 1, NumStacks = 1 }) 
		end
	end
end

function UpgradeHarvestBoon()

	local upgradableTraitNames = {}
	local upgradableTraits = {}
	local upgradedTraits = {}
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.HarvestBoons then
			if trait.CurrentRoom then
				trait.CurrentRoom = trait.CurrentRoom + 1
			end
			if trait.RoomsPerUpgrade and trait.CurrentRoom < trait.RoomsPerUpgrade then
				return
			else
				trait.CurrentRoom = 0
			end
		end
	end

	for i, value in pairs(GetHeroTraitValues("HarvestBoons")) do
		for s, boonName in pairs(value) do
			upgradableTraitNames[boonName] = true
		end
	end
	
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if upgradableTraitNames[traitData.Name] and TraitData[traitData.Name] and traitData.Rarity ~= nil and GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil then
			table.insert(upgradableTraits, traitData )
		end
	end
	if not IsEmpty(upgradableTraits) then
		 while not IsEmpty( upgradableTraits ) do
			local traitData = RemoveRandomValue( upgradableTraits )
			local persistentKeys = { "AccumulatedFountainDamageBonus" }
			local persistentValues = {}
			for i, key in pairs( persistentKeys ) do
				persistentValues[key] = traitData[key]
			end

			upgradedTraits[GetTraitTooltipTitle(traitData)] = true
			local numOldTrait = GetTraitNameCount( CurrentRun.Hero, traitData.Name )
			RemoveWeaponTrait( traitData.Name )
			
			local processedData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, Rarity = GetUpgradedRarity(traitData.Rarity) }) 
			for i, key in pairs( persistentKeys ) do
				processedData[key] = persistentValues[key]
			end
			AddTraitToHero({ TraitData = processedData })

			for i=1, numOldTrait-1 do
				AddTraitToHero({ TraitName = traitData.Name })
			end
		end

		thread( IncreasedTraitRarityPresentation, upgradedTraits, 2.0 )
	end
	
	for itemId, item in pairs( LootObjects ) do
		item.UpgradeOptions = nil
	end
end

function AddSuperRarityBoost()
	AddTraitToHero({ TraitName = "SuperTemporaryBoonRarityTrait" })
end

function AddRarityToTraits( source, args )
	local numTraits = args.NumTraits
	local upgradableTraits = {}
	local upgradedTraits = {}
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if IsGodTrait(traitData.Name, { ForShop = true }) and TraitData[traitData.Name] and traitData.Rarity ~= nil and GetUpgradedRarity(traitData.Rarity) ~= nil and traitData.RarityLevels[GetUpgradedRarity(traitData.Rarity)] ~= nil then
			table.insert(upgradableTraits, traitData )
		end
	end

	while numTraits > 0 and not IsEmpty( upgradableTraits ) do
		local traitData = RemoveRandomValue( upgradableTraits )
		local persistentKeys = { "AccumulatedFountainDamageBonus" }
		local persistentValues = {}
		for i, key in pairs( persistentKeys ) do
			persistentValues[key] = traitData[key]
		end

		upgradedTraits[GetTraitTooltipTitle(traitData)] = true
		local numOldTrait = GetTraitNameCount( CurrentRun.Hero, traitData.Name )
		RemoveWeaponTrait( traitData.Name )
		local processedData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitData.Name, Rarity = GetUpgradedRarity(traitData.Rarity) }) 
		for i, key in pairs( persistentKeys ) do
			processedData[key] = persistentValues[key]
		end
		AddTraitToHero({ TraitData = processedData })
		for i=1, numOldTrait-1 do
			AddTraitToHero({ TraitName = traitData.Name })
		end
		numTraits = numTraits - 1
	end

	thread( IncreasedTraitRarityPresentation, upgradedTraits )
end

function AddRandomBouldyBlessing( source, args )
	local traitName = GetRandomValue(args)
	AddTraitToHero({TraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = traitName, Rarity = "Common"}) })
	BouldyBlessingPresentation( traitName )
end

function GetNumUniqueGodTraitsTaken( )
	local godTraitsTaken = 0
	for traitName, hasBeenTaken in pairs(GameState.TraitsTaken) do
		if IsGodTrait(traitName, { ForShop = true } ) then
			godTraitsTaken = godTraitsTaken + 1
		end
	end
	return godTraitsTaken
end

function GetNumUniqueWeaponUpgradesTaken( )
	local weaponUpgradesTaken = 0
	for traitName, hasBeenTaken in pairs(GameState.TraitsTaken) do
		if Contains(LootData.WeaponUpgrade.Traits, traitName) then
			weaponUpgradesTaken = weaponUpgradesTaken + 1
		end
	end
	return weaponUpgradesTaken
end