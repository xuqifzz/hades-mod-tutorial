function IsSuperValid()
	if IsEmpty( GetHeroTraitValues("AddShout") ) then
		return false
	end

	return true
end

function BuildSuperMeter( currentRun, meterAmount )
	if not IsSuperValid() then
		return
	end

	if CurrentRun.Hero.SuperActive then
		return
	end
	local lastSuperMeter = currentRun.Hero.SuperMeter
	currentRun.Hero.SuperMeter = currentRun.Hero.SuperMeter + meterAmount

	local maxedOutMeter = false
	if currentRun.Hero.SuperMeter >= currentRun.Hero.SuperMeterLimit then
		currentRun.Hero.SuperMeter = currentRun.Hero.SuperMeterLimit
		maxedOutMeter = true
	end
	local superCap = nil
	for i, cap in pairs( GetHeroTraitValues( "SuperMeterCap" )) do
		if not superCap or cap < superCap then
			superCap = cap
		end
	end
	if superCap and currentRun.Hero.SuperMeter > superCap then
		currentRun.Hero.SuperMeter = superCap
	end

	local currentSuperMeter = math.floor(currentRun.Hero.SuperMeter/CurrentRun.Hero.SuperCost)
	if math.floor(lastSuperMeter/CurrentRun.Hero.SuperCost) ~= currentSuperMeter or ( maxedOutMeter and lastSuperMeter ~= currentRun.Hero.SuperMeter) then
		UpdateSuperDamageBonus()
		SuperReachedPresentation( currentSuperMeter,  maxedOutMeter )
	end

	UpdateSuperMeterUI()
end

OnControlPressed{ "Shout",
	function( triggerArgs )
		if not IsSuperValid() then
			return
		end

		if not CanCommenceSuper() then
			return
		end

		if IsSuperAvailable( CurrentRun.Hero ) then
			CommenceSuperMove( )
			UpdateSuperDamageBonus()
			thread( MarkObjectiveComplete, "EXMove" )
		else
			ShoutFailedPresentation( CurrentRun.Hero )
		end

	end
}

function CanCommenceSuper()

	if CurrentRun.Hero.IsDead then
		return false
	end
	if CurrentRun.Hero.SuperActive then
		return false
	end
	if not IsInputAllowed({}) then
		return false
	end
	if not IsEmpty(ActiveEnemies) then
		for i, enemy in pairs(ActiveEnemies) do
			if enemy.InTransition then
				return false
			end
		end
	end

	if CurrentRun.CurrentRoom.AllowSuperOutsideEncounter then
		return true
	end
	if CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.InProgress and CurrentRun.CurrentRoom.Encounter.EncounterType ~= "NonCombat" then
		return true
	end
	if CurrentRun.CurrentRoom.ChallengeEncounter ~= nil and CurrentRun.CurrentRoom.ChallengeEncounter.InProgress then
		return true
	end

	return false

end

function IsSuperAvailable( attacker )
	if attacker.SuperCost == nil then
		return false
	end
	if attacker.SuperMeter < attacker.SuperCost then
		return false
	end

	return true

end

function CommenceSuperMove()

	CurrentRun.Hero.SuperActive = true

	if CurrentRun.Hero.Frozen then
		ClearEffect({Id = CurrentRun.Hero.ObjectId, Name = "FreezeStun" })
		CurrentRun.Hero.Frozen = false
	end

	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "NonMultiFireRequestWeapons", Method = "cancelCharge" })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "NonMultiFireRequestWeapons", Method = "ForceControlRelease" })

	local isFullSuper = false
	local useSuperOverPresentation = false
	local currentRun = CurrentRun
	local shoutEffects = { }
	local endShoutEffects = { }
	if currentRun.Hero.SuperMeter == currentRun.Hero.SuperMeterLimit then
		isFullSuper = true
		useSuperOverPresentation = true
	end
	FreezePlayerUnit("SuperPresentation")
	for i, traitData in pairs(CurrentRun.Hero.Traits) do
		if traitData.AddShout then
			if IsEmpty(shoutEffects) then
				if isFullSuper then
					FullSuperUsedPresentation( traitData )
				else
					SuperUsedPresentation( traitData )
				end
			end
			table.insert(shoutEffects, traitData.AddShout)
		end
		if traitData.EndShout then
			table.insert(endShoutEffects, traitData.EndShout)
		end
	end
	UnfreezePlayerUnit("SuperPresentation")

	AudioState.PersistentShoutEffectSoundId = PlaySound({ Name = "/SFX/WrathPersistentLoop", Id = CurrentRun.Hero.ObjectId })

	if IsEmpty(shoutEffects) then
		thread( FireShoutEffects, nil )
	else
		for i, shoutData in pairs(shoutEffects) do
			if isFullSuper and shoutData.MaxFunctionName then
				thread( FireShoutEffects, shoutData.MaxFunctionName )
			else
				thread( FireShoutEffects, shoutData.FunctionName )
			end
		end
	end
	for i, weaponNames in pairs(GetHeroTraitValues("OnSuperWeapons")) do
		for s, weaponName in pairs(weaponNames) do
			FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		end
	end

	local superMeterDecrement = CurrentRun.Hero.SuperCost
	if isFullSuper then
		superMeterDecrement = CurrentRun.Hero.SuperMeterLimit
	end

	local superMeterDuration = 0
	for i, traitData in pairs(CurrentRun.Hero.Traits) do
		local shoutData = traitData.AddShout
		if shoutData ~= nil then
			if shoutData.IsBurst then
				useSuperOverPresentation = false
			end
			if shoutData.MaxWeaponDataOverride then
				if not CurrentRun.Hero.WeaponDataOverride then
					CurrentRun.Hero.WeaponDataOverride = {}
				end
				for key, data in pairs(shoutData.MaxWeaponDataOverride) do
					if isFullSuper then
						CurrentRun.Hero.WeaponDataOverride[key] = MergeTables(WeaponData[key], data )
					else
						CurrentRun.Hero.WeaponDataOverride[key] = nil
					end
				end
			end

			if isFullSuper and shoutData.MaxDurationMultiplier then
				if shoutData.AddDuration then
					superMeterDuration = superMeterDuration + shoutData.SuperDuration * shoutData.MaxDurationMultiplier
				else
					superMeterDuration = shoutData.SuperDuration * shoutData.MaxDurationMultiplier
					break
				end
			else
				if shoutData.AddDuration then
					superMeterDuration = superMeterDuration + shoutData.SuperDuration
				else
					superMeterDuration = shoutData.SuperDuration
					break
				end
			end
		end
	end
	
	for i, superDurationData in pairs(GetHeroTraitValues("AddSuperDurationData")) do
		if HeroHasTrait( superDurationData.RequiredTrait ) then
			superMeterDuration = superMeterDuration + superDurationData.Amount
		end
	end

	DecrementSuperMeter( currentRun, superMeterDecrement, superMeterDuration, isFullSuper )
	thread( SuperEndPresentation, math.floor(currentRun.Hero.SuperMeter/currentRun.Hero.SuperCost) + 1, useSuperOverPresentation)

	StopSuper()
end

function DecrementSuperMeter( currentRun, superMeterDecrement, superMeterDuration, isFullSuper )
	local elapsedTime = 0
	CurrentRun.Hero.CurrentSuperMeterDecrement = 0
	CurrentRun.Hero.SuperMeterDecrement = superMeterDecrement
	local tickInterval = superMeterDuration / CurrentRun.Hero.SuperMeterDecrement
	local warnStartTime = (superMeterDuration - SuperUI.ExpiringSoundInterval * (SuperUI.ExpiringSoundCount + 1))
	if not isFullSuper then
		warnStartTime = (superMeterDuration - SuperUI.ExpiringSoundInterval * (SuperUI.ExpiringShortCount + 1))
	end
	-- global variable used for meter feedback
	SuperMeterFull = nil
	while CurrentRun.Hero.CurrentSuperMeterDecrement < CurrentRun.Hero.SuperMeterDecrement do
		CurrentRun.Hero.CurrentSuperMeterDecrement = CurrentRun.Hero.CurrentSuperMeterDecrement + 1
		currentRun.Hero.SuperMeter = currentRun.Hero.SuperMeter - 1
		if currentRun.Hero.SuperMeter <= 0 then
			currentRun.Hero.SuperMeter = 0
		end
		UpdateSuperMeterUI()
		elapsedTime = elapsedTime + tickInterval
		wait(tickInterval, RoomThreadName )
		if warnStartTime > 0 and ( CurrentRun.Hero.CurrentSuperMeterDecrement + 1 ) < CurrentRun.Hero.SuperMeterDecrement and elapsedTime > warnStartTime and ( elapsedTime - warnStartTime ) % SuperUI.ExpiringSoundInterval > ( elapsedTime - warnStartTime + tickInterval ) % SuperUI.ExpiringSoundInterval then
			SuperWarnPresentation( currentRun.Hero, isFullSuper )
		end
	end
end

function StopSuper()
	if ScreenAnchors.SuperMeterHint and ( CurrentRun.Hero.SuperMeter == CurrentRun.Hero.SuperMeterLimit ) then
		SetAnimation({ Name = "WrathBarFullFxEnd", DestinationId = ScreenAnchors.SuperMeterHint })
	end

	local endShoutEffects = {}
	for i, traitData in pairs(CurrentRun.Hero.Traits) do
		if traitData.EndShout then
			table.insert(endShoutEffects, traitData.EndShout)
		end
	end

	for i, endShoutFunctionName in pairs(endShoutEffects) do
			if _G[endShoutFunctionName] ~= nil then
				_G[endShoutFunctionName]()
			end
	end

	if CurrentRun.Hero.SuperActive then
		Rumble({ Duration = 0 })
	end
	StopSound({ Id = AudioState.PersistentShoutEffectSoundId, Duration = 0.2 })
	StopSound({ Id = AudioState.ShoutEffectSoundId, Duration = 0.2 })
	CurrentRun.Hero.SuperActive = false
end

function PostEncounterDrainSuper()
	local elapsed = 0
	thread( PostEncounterDrainSuperPresentation, IsSuperAvailable( CurrentRun.Hero ))
	while CurrentRun.Hero.SuperMeter > 0 and ( CurrentRun.CurrentRoom.ChallengeEncounter == nil or not CurrentRun.CurrentRoom.ChallengeEncounter.InProgress ) do
		local drainRate = 1
		for i, thresholdData in ipairs(SuperUI.PostEncounterDrainRates) do
			if elapsed >= thresholdData.Threshold and ( SuperUI.PostEncounterDrainRates[i + 1] == nil or elapsed < SuperUI.PostEncounterDrainRates[i + 1].Threshold ) then
				drainRate = 1 / thresholdData.Rate
				break
			end
		end

		CurrentRun.Hero.SuperMeter = CurrentRun.Hero.SuperMeter - 1
		UpdateSuperMeterUI()
		elapsed = elapsed + drainRate
		wait(drainRate, RoomThreadName )
	end
	if CurrentRun.Hero.SuperMeter < 0 then
		CurrentRun.Hero.SuperMeter = 0
		UpdateSuperMeterUI()
	end
end

function FireShoutEffects( superName )

	if superName == nil then
		-- Do nothing
	else
		local shoutFunction = _G[superName]
		if shoutFunction ~= nil then
			thread( shoutFunction )
		end
	end
end

function ZeusShout()

	EquipWeapon({ Name = "LightningStrikeX", DestinationId = CurrentRun.Hero.ObjectId })
	--AdjustColorGrading({ Name = "ZeusLightning", Duration = 0.05 })

	while CurrentRun.Hero.SuperActive do
		thread(FireWeaponWithinRange, { Range = 400, SeekTarget = true, WeaponName = "LightningStrikeX", InitialDelay = 0, Delay = 0.21, Count = 1, BonusChance = GetTotalHeroTraitValue("BonusBolts") })
		wait(0.25)
	end

	AdjustColorGrading({ Name = "Off", Duration = 0.5 })
end

function AresShout()
	FireWeaponFromUnit({ Weapon = "AresSurgeWeapon", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true, ClearAllFireRequests = true })
end

function AthenaShout()
	FireWeaponFromUnit({ Weapon = "AthenaShoutWeapon", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true, ClearAllFireRequests = true })
end
function EndAthenaShout()
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "MagicShieldShoutInvincible" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "MagicShieldShout" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "MagicShieldShoutReflection" })
end

function HadesShoutInvisibility()
	SetPlayerPhasing("HadesShout")
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0.4, Duration = 0.3 })
	CurrentRun.Hero.Invisible = true
	CurrentRun.CurrentRoom.InvisTargetId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting", DestinationId = CurrentRun.Hero.ObjectId })

	CreateAnimation({ Name = "HadesDisappear_Player", DestinationId = CurrentRun.Hero.ObjectId, Scale = 0.6 })
	for enemyId, enemy in pairs(ActiveEnemies) do
		if not enemy.SkipModifiers then
			thread( InCombatText, enemy.ObjectId, "Startled", 0.45, { OffsetY = enemy.HealthBarOffsetY, SkipFlash = true, PreDelay = RandomFloat(0.1, 0.15), SkipShadow = true } )

			FinishTargetMarker( enemy )
			local weaponData = WeaponData[enemy.WeaponName]
			if weaponData ~= nil and not weaponData.BlockInterrupt then
				enemy.ForcedWeaponInterrupt = enemy.WeaponName
			end
			notifyExistingWaiters( enemy.AINotifyName )
			SetThreadWait( enemy.AIThreadName, 0.1 )
			
			thread( OnInvisStartPresentation, enemy )
		end
	end
	FireWeaponFromUnit({ Weapon = "HadesShoutWeapon", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true, ClearAllFireRequests = true })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Names = {					
		"StyxPoison",
		"ZagreusOnHitStun",
		"GraspingHands",
		"FreezeStun",
		"ZagreusDemeterSpeedPenalty",
		"ZagreusAphroditeStun",} })
end

function HadesShoutMax()
	HadesShoutInvisibility()
end

function HadesShout()
	HadesShoutInvisibility()
	
	local validWeapons = ConcatTableValues( DeepCopyTable( WeaponSets.HeroRangedWeapons ), AddLinkedWeapons( WeaponSets.HeroPhysicalWeapons ))
	local validWeapons = ConcatTableValues( validWeapons, AddLinkedWeapons( WeaponSets.HeroSecondaryWeapons))
	AddLimitedWeaponBonus({ AsMultiplier = true, EffectName = "HadesShieldShout", Amount = 1, DamageBonus = 0, WeaponNames = validWeapons } )
	NotifyOnEffectExpired({ Id = CurrentRun.Hero.ObjectId, Notify = "StealthBroken", EffectName = "HadesShieldShout"})
	
	waitUntil( "StealthBroken" )
	if CurrentRun.Hero.ActiveEffects.HadesShieldShoutInvincible then
		FireWeaponFromUnit({ Weapon = "HadesBreakStealthBuff", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true, })
		InvisBreakPresentation()
	end
	EndHadesShout()
end

function EndHadesShout()
	CurrentRun.Hero.Invisible = false
	SetPlayerUnphasing("HadesShout")
	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.Encounter and not CurrentRun.CurrentRoom.Encounter.BossKillPresentation then
		SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 1, Duration = 0.3 })
	end
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "HadesShieldShoutInvincible" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "HadesShieldShout" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "HadesShieldShoutSpeed" })
	if CurrentRun.CurrentRoom.InvisTargetId then
		Destroy({ Id = CurrentRun.CurrentRoom.InvisTargetId })
		CurrentRun.CurrentRoom.InvisTargetId = nil
	end
end


function AphroditeMaxShout()
	FireWeaponFromUnit({ Weapon = "AphroditeMaxSuperCharm", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true, ClearAllFireRequests = true })
end

function AphroditeShout()
	FireWeaponFromUnit({ Weapon = "AphroditeSuperCharm", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true, ClearAllFireRequests = true })
end

function DemeterMaxShout()
	FireWeaponFromUnit({ Weapon = "DemeterMaxSuper", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true, ClearAllFireRequests = true })
end

function DemeterShout()
	FireWeaponFromUnit({ Weapon = "DemeterSuper", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true, ClearAllFireRequests = true })
end

function ArtemisShout()
	FireWeaponFromUnit({ Weapon = "ArtemisShoutWeapon", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true, ClearAllFireRequests = true })
end

function ArtemisMaxShout()
	FireWeaponFromUnit({ Weapon = "ArtemisMaxShoutWeapon", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true, ClearAllFireRequests = true })
end

function PoseidonShout()
	FireWeaponFromUnit({ Weapon = "PoseidonSurfWeapon", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true, ClearAllFireRequests = true })
end

function EndSurge()
	EndRamWeapons({ Id = CurrentRun.Hero.ObjectId })
end

function EndDemeter()
	ExpireProjectiles({ Names = { "DemeterSuper", "DemeterMaxSuper" } })
end

OnWeaponFired{ "PoseidonSurfWeapon AresSurgeWeapon",
	function(triggerArgs)
		ToggleControl({ Names = { "Use", "Gift", "Reload", "Assist" }, Enabled = false })
		SetPlayerPhasing("SurfWeapon")
		CurrentRun.Hero.SurgeActive = true
		SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToForce", Value = true })
		SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToStun", Value = true })
	end
}

OnRamWeaponComplete{ "PoseidonSurfWeapon AresSurgeWeapon",
	function(triggerArgs)
		ToggleControl({ Names = { "Use", "Gift", "Reload", "Assist" }, Enabled = true })
		SetPlayerUnphasing("SurfWeapon")
		CurrentRun.Hero.SurgeActive = false
		SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToForce", Value = false })
		SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToStun", Value = false })
		StopAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "AresBladeSpinShadow_Shout" })
	end
}

function PoseidonShoutVacuum( weaponData, args )
	while CurrentRun.Hero.SuperActive do
		local leadOffset = CalcOffset( math.rad( GetAngle({ Id = CurrentRun.Hero.ObjectId })), args.LeadAmount )
		local leadLocation = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = leadOffset.X, OffsetY = leadOffset.Y })

		local targetIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = args.Range  })
		for i, targetId in pairs(targetIds) do
			if ActiveEnemies[targetId] ~= nil and not ActiveEnemies[targetId].IsDead then
				ApplyForce({ Id = targetId, Speed = GetRequiredForceToEnemy( targetId, leadLocation, args.OverShoot ), Angle = GetAngleBetween({ Id = targetId, DestinationId = leadLocation }) })
			end
		end
		Destroy({ Id = leadLocation })

		if not args.Interval or args.Interval == 0 then
			return
		else
			wait(args.Interval, RoomThreadName )
		end
	end
end

function DionysusShout()
	EquipWeapon({ Name = "DionysusShoutWeapon", DestinationId = CurrentRun.Hero.ObjectId })
	while CurrentRun.Hero.SuperActive do
		thread(FireWeaponWithinRange, { Range = 600, SeekTarget = true, WeaponName = "DionysusShoutWeapon", InitialDelay = 0, Delay = 0.21, Count = 1 })
		waitScreenTime(0.32)
	end
end