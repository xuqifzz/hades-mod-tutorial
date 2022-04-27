function GetKeepsakeLevel( traitName )
	local level = 1

	if TraitData[traitName].KeepsakeRarityGameStateRequirements then
		for i, requirements in ipairs( TraitData[traitName].KeepsakeRarityGameStateRequirements ) do
			if IsGameStateEligible( CurrentRun, requirements ) then
				level = i
			end
		end
		return level
	end

	if not GameState.KeepsakeChambers[traitName] or TraitData[traitName].ChamberThresholds == nil then
		return level
	end

	local threshold = 0
	for i, value in pairs(TraitData[traitName].ChamberThresholds) do
		threshold = threshold + value
		if threshold > GameState.KeepsakeChambers[traitName] then
			break;
		end
		level = level + 1
	end

	return level
end

function GetKeepsakeProgress( traitName )
	local currentLevel = GetKeepsakeLevel( traitName )
	if not GameState.KeepsakeChambers[traitName] or not TraitData[traitName].ChamberThresholds then
		return 0
	end

	if IsKeepsakeMaxed( traitName ) then
		return 1
	end
	local lastThreshold = 0
	if currentLevel > 1 then
		lastThreshold = TraitData[traitName].ChamberThresholds[currentLevel - 1]
	end
	return (GameState.KeepsakeChambers[traitName] - lastThreshold) / TraitData[traitName].ChamberThresholds[currentLevel]
end

function GetKeepsakeChambersToNextLevel( traitName )
	if IsKeepsakeMaxed( traitName ) then
		return 0
	end

	local currentLevel = GetKeepsakeLevel( traitName )
	local currentChambers = GameState.KeepsakeChambers[traitName] or 0
	local lastThreshold = 0
	if currentLevel > 1 then
		lastThreshold = TraitData[traitName].ChamberThresholds[currentLevel - 1]
	end
	return TraitData[traitName].ChamberThresholds[currentLevel] - ( currentChambers - lastThreshold )
end

function IsKeepsakeMaxed( traitName )
	if TraitData[ traitName ].KeepsakeRarityGameStateRequirements then
		for i, requirements in ipairs( TraitData[traitName].KeepsakeRarityGameStateRequirements ) do
			if not IsGameStateEligible( CurrentRun, requirements ) then
				return false
			end
		end
		return true
	end

	if not GameState.KeepsakeChambers[traitName] then
		return false
	end

	if TraitData[traitName].ChamberThresholds == nil or TraitData[traitName].ChamberThresholds[GetKeepsakeLevel( traitName )] == nil then
		return true
	end

	return false
end

function EquipKeepsake( heroUnit, traitName, args )
	local unit = heroUnit or CurrentRun.Hero
	traitName = traitName or GameState.LastAwardTrait
	if traitName == nil then
		return
	end

	AddTrait( unit, traitName, GetRarityKey(GetKeepsakeLevel( traitName )), args)
	if not CurrentRun.Hero.IsDead then
		CurrentRun.TraitCache = CurrentRun.TraitCache or {}
		CurrentRun.TraitCache[traitName] = CurrentRun.TraitCache[traitName] or 1
	end

	if traitName == "ReincarnationTrait" then
		AddLastStand({
			Name = "ReincarnationTrait",
			InsertAtEnd = true,
			IncreaseMax = true,
			Icon = "ExtraLifeSkelly",
			WeaponName = "LastStandReincarnateShield",
			HealAmount = GetTotalHeroTraitValue( "KeepsakeLastStandHealAmount" ),
		})
	end
end

function UnequipKeepsake( heroUnit, traitName )
	local unit = heroUnit or CurrentRun.Hero
	RemoveTrait( unit, traitName )
	if traitName == "ReincarnationTrait" then
		RemoveLastStand( unit, "ReincarnationTrait" )
		unit.MaxLastStands = unit.MaxLastStands - 1
	end
	if traitName == "HadesShoutKeepsake" then
		RemoveTrait(CurrentRun.Hero, "HadesShoutTrait")
	end
end

function EquipAssist( heroUnit, traitName, args )
	local unit = heroUnit or CurrentRun.Hero
	traitName = traitName or GameState.LastAssistTrait
	if traitName == nil then
		return
	end

	AddTrait( unit, traitName, GetRarityKey(GetKeepsakeLevel( traitName )), args )
end

function UnequipAssist( heroUnit, traitName )
	local unit = heroUnit or CurrentRun.Hero
	RemoveTrait( unit, traitName )
end

function AdvanceKeepsake()
	local traitName = GameState.LastAwardTrait
	if GameState.LastAwardTrait ~= nil and HeroHasTrait(traitName) then
		local startingKeepsakeLevel = GetKeepsakeLevel( traitName )
		IncrementTableValue( GameState.KeepsakeChambers, traitName )
		if CurrentRun and CurrentRun.Hero and startingKeepsakeLevel ~= GetKeepsakeLevel( traitName ) then
			local accumulatedDamageBonus = 1
			local accumulatedDodgeBonus = 0
			local lastUses = 0
			local lastRoomNumber = 0
			for i, traitData in pairs( CurrentRun.Hero.Traits ) do
				if traitData.Name == traitName then
					accumulatedDamageBonus = traitData.AccumulatedDamageBonus
					accumulatedDodgeBonus = traitData.AccumulatedDodgeBonus
					lastUses = traitData.Uses
					lastRoomNumber = traitData.CurrentRoom
					break
				end
			end
			
			UnequipKeepsake( CurrentRun.Hero, traitName )			
			EquipKeepsake( CurrentRun.Hero, traitName )
			if traitName == "ReincarnationTrait" then
				RecreateLifePips()
			end
			for i, traitData in pairs( CurrentRun.Hero.Traits ) do
				if traitData.Name == traitName then
					if accumulatedDodgeBonus then
						traitData.AccumulatedDodgeBonus = accumulatedDodgeBonus
						SetLifeProperty({ Property = "DodgeChance", Value = traitData.AccumulatedDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
						SetUnitProperty({ Property = "Speed", Value = 1 + traitData.AccumulatedDodgeBonus, ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
					end
					traitData.AccumulatedDamageBonus = accumulatedDamageBonus
					traitData.Uses = lastUses
					traitData.CurrentRoom = lastRoomNumber
					UpdateTraitNumber(traitData)
					break
				end
			end
			thread( KeepsakeLevelUpPresentation, traitName )
			CheckAchievement({ Name = "AchLeveledKeepsakes" })
		end
	end
end

function SetupDodgeBonus( encounter, dodgeTraitData )
	if CurrentRun == nil or CurrentRun.Hero == nil or CurrentRun.Hero.IsDead then
		return
	end
	SetLifeProperty({ Property = "DodgeChance", Value = dodgeTraitData.AccumulatedDodgeBonus, ValueChangeType = "Add", DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	SetUnitProperty({ Property = "Speed", Value = 1 + dodgeTraitData.AccumulatedDodgeBonus, ValueChangeType = "Multiply", DestinationId = CurrentRun.Hero.ObjectId })
	local clearTimeThreshold = encounter.FastClearThreshold or dodgeTraitData.FastClearThreshold
	FastClearTraitStartPresentation( clearTimeThreshold, dodgeTraitData )

	thread( FastClearThread, clearTimeThreshold, dodgeTraitData )
end

function FastClearThread( clearTimeThreshold, dodgeTraitData )
	wait( clearTimeThreshold, RoomThreadName )
	if CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.Encounter and not CurrentRun.CurrentRoom.Encounter.Completed and not CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
		FastClearTraitFailedPresentation(dodgeTraitData)
	end
end