Using "PortraitRespawnFill"
Using "PortraitRespawnFill_Goal"
Using "PortraitRespawnComplete"
Using "StarConnector"

-- |MELEE & RANGED WEAPONS| --
OnWeaponFired{ "SwordParry",
	function( triggerArgs )
		if HeroHasTrait("SwordCriticalParryTrait") then
			AddLimitedWeaponBonus({ AsCrit = true, EffectName = "SwordPostParryCritical", Amount = 100, CritBonus = GetTotalHeroTraitValue("SwordPostParryCriticalAmount")})
		end
	end
}

function CheckPlayerOnFirePowers( triggerArgs )
	local firedWeaponName = triggerArgs.name
	for i, data in pairs(GetHeroTraitValues("StoredAmmoWaveWeapon")) do
		if CurrentRun.Hero.StoredAmmoWave and Contains( data.ValidWeaponNames, firedWeaponName ) then
			FireWeaponFromUnit({ Weapon = data.Name, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		end
	end

	if CurrentRun.Hero.OnFireWeapons == nil then
		return
	end

	local weaponFireOverrides = {}
	for i, data in pairs(GetHeroTraitValues("OverrideWeaponFireNames")) do
		weaponFireOverrides = MergeTables( weaponFireOverrides, data )
	end

	if weaponFireOverrides[ firedWeaponName ] == "nil" then
		return
	elseif weaponFireOverrides[ firedWeaponName ] then
		firedWeaponName = weaponFireOverrides[ firedWeaponName ]
	end

	if CurrentRun.Hero.OnFireWeapons[firedWeaponName] ~= nil then
		for weaponName, weaponData in pairs( CurrentRun.Hero.OnFireWeapons[firedWeaponName] ) do
			if type(weaponData) == "table" then
				if weaponData.UseTargetLocation and triggerArgs.TargetX and triggerArgs.TargetY then
					local targetId = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.TargetX, LocationY = triggerArgs.TargetY })
					FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = targetId })
					Destroy({ Id = targetId })
				else
					FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
				end
			else
				FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
			end
		end
	end
end

function CheckWallSlamPowers( victim, triggerArgs )
	if CurrentRun.Hero.OnSlamWeapons == nil then
		return
	end
	local damageSourceName = triggerArgs.AttackerName
	if EnemyData[damageSourceName] == nil and triggerArgs.AttackerId ~= CurrentRun.Hero.ObjectId and not triggerArgs.EffectName and not EffectData[triggerArgs.EffectName] then
		for i, weaponName in pairs( CurrentRun.Hero.OnSlamWeapons ) do
			FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, AutoEquip = true})
		end
	end
end

function CheckOnHitPowers( victim, attacker, args )
	args = args or {}
	if victim == attacker or victim == nil or victim.OnHitWeapons == nil or ( victim.Health and args.DamageAmount and (victim.Health - args.DamageAmount) <= 0 and not HasLastStand( victim )) then
		return
	end

	local attackerId = nil
	if attacker ~= nil then
		attackerId = attacker.ObjectId
	end

	if args.SourceWeapon and WeaponData[args.SourceWeapon] and WeaponData[args.SourceWeapon].IgnoreOnHitEffects then
		return
	end
	if args.EffectName and EffectData[args.EffectName] and EffectData[args.EffectName].IgnoreOnHitEffects then
		return
	end

	if attackerId == nil or attacker.TriggersOnHitEffects then
		for onHitWeaponName, onHitWeaponData in pairs( victim.OnHitWeapons ) do
			if type(onHitWeaponData) == "table" then
				if (not args.Automatic or (not onHitWeaponData.IgnoreAutomatic and args.Automatic))
					and (not args.IsInvulnerable or (onHitWeaponData.AllowInvulnerable and args.IsInvulnerable )) then
					if onHitWeaponData.FunctionName then
						if _G[onHitWeaponData.FunctionName] then
							_G[onHitWeaponData.FunctionName]( attacker, args )
						end
					else
						FireWeaponFromUnit({ Weapon = onHitWeaponName, AutoEquip = true, Id = victim.ObjectId, DestinationId = attackerId })
					end
				end
			elseif not args.IsInvulnerable then
				FireWeaponFromUnit({ Weapon = onHitWeaponName, AutoEquip = true, Id = victim.ObjectId, DestinationId = attackerId })
			end
		end
	end
end

function CheckOnDamagedPowers( victim, attacker, args )
	local isCrit = args.IsCrit
	local weaponName = args.SourceWeapon
	local currentRun = CurrentRun

	if victim ~= nil and victim.OnDamagedWeapons ~= nil and ( victim.Health ~= nil and args.DamageAmount ~= nil and (victim.Health - args.DamageAmount) > 0 or HasLastStand( victim )) then
		if attackerId == nil or attacker.TriggersOnDamageEffects then
			for onDamagedWeaponName, onDamagedWeaponData in pairs( victim.OnDamagedWeapons ) do
				if type(onDamagedWeaponData) == "table" then
					if (not args.Automatic or (not onDamagedWeaponData.IgnoreAutomatic and args.Automatic))
						and (not args.IsInvulnerable or (onDamagedWeaponData.AllowInvulnerable and args.IsInvulnerable )) then
						if onDamagedWeaponData.Requirements == nil or IsGameStateEligible(CurrentRun, onDamagedWeaponData, onDamagedWeaponData.Requirements) then
							FireWeaponFromUnit({ Weapon = onDamagedWeaponName, AutoEquip = true, Id = victim.ObjectId, DestinationId = attackerId })
						end
					end
				elseif not args.IsInvulnerable then
					FireWeaponFromUnit({ Weapon = onDamagedWeaponName, AutoEquip = true, Id = victim.ObjectId, DestinationId = attackerId })
				end
			end
		end
	end

	if attacker ~= nil then
		local victimId = nil
		if victim ~= nil then
			victimId = victim.ObjectId
		end
		if attacker.OnDamageWeapons ~= nil and ( victim == nil or victim.TriggersOnDamageEffects ) then
			if attacker.OnDamageWeapons[weaponName] ~= nil then
				for weaponName, weaponData in pairs( attacker.OnDamageWeapons[weaponName] ) do
					if type(weaponData) == "table" then
						local passesCritCheck = weaponData.CritOnly == nil or (weaponData.CritOnly and isCrit)
						local passesHitCheck = weaponData.FirstHitOnly == nil or (weaponData.FirstHitOnly and args.FirstInVolley )
						local passesVelocityCheck = weaponData.RequireImpactMin == nil or (weaponData.RequireImpactMin and args.ImpactVelocity  ~= nil and args.ImpactVelocity >= weaponData.RequireImpactMin)
						local passesEffectCheck = weaponData.IncludeEffectDamage or args.EffectName == nil
						if passesCritCheck and passesHitCheck and passesVelocityCheck and passesEffectCheck then
							FireWeaponFromUnit({ Weapon = weaponName, AutoEquip = true, Id = attacker.ObjectId, DestinationId = victimId, FireFromTarget = weaponData.FireFromVictimLocation})
						elseif not weaponData.CritOnly and not weaponData.FirstHitOnly and not weaponData.RequireImpactMin and not weaponData.IncludeEffectDamage then
							FireWeaponFromUnit({ Weapon = weaponName, AutoEquip = true, Id = attacker.ObjectId, DestinationId = victimId, FireFromTarget = weaponData.FireFromVictimLocation})
						end
					elseif weaponData then
						FireWeaponFromUnit({ Weapon = weaponName, AutoEquip = true, Id = attacker.ObjectId, DestinationId = victimId })
					end
				end
			end
		end
		CheckOnImpactPowers( victim, attacker, args )
	end

	if isCrit and attacker ~= nil and attacker.ObjectId == CurrentRun.Hero.ObjectId and attacker ~= victim and victim ~= nil and victim.TriggersOnDamageEffects then
		for i, functionData in pairs(GetHeroTraitValues("OnEnemyCrittedFunction")) do
			if _G[functionData.Name] ~= nil then
				_G[functionData.Name](victim, functionData.Args)
			end
		end
	end

	if attacker == CurrentRun.Hero and victim ~= nil and victim.TriggersOnDamageEffects then
		for i, functionData in pairs(GetHeroTraitValues("OnEnemyDamagedFunction")) do
			if _G[functionData.Name] ~= nil then
				_G[functionData.Name](victim, functionData.Args, args)
			end
		end
	end

	if args ~= nil and attacker ~= nil and attacker.ObjectId == CurrentRun.Hero.ObjectId and HeroHasTrait("ZeusChargedBoltTrait") and args.FirstInVolley then
		if Contains({ "ZeusShieldLoadAmmoStrike", "LightningStrikeRetaliate", "ChainLightning", "LightningStrikeX", "LightningDash", "LightningStrikeSecondary", "ZeusAmmoWeapon", "ZeusDionysusCloudStrike", "LightningStrikeImpact" }, weaponName ) or ( weaponName == "RangedWeapon" and HeroHasTrait("ZeusRangedTrait")) then
			FireWeaponFromUnit({ Weapon = "ZeusLegendaryWeapon", AutoEquip = true, Id = attacker.ObjectId, DestinationId = victim.ObjectId, FireFromTarget = true })
		end
	end

	if args ~= nil and attacker ~= nil and victim ~= nil and attacker.ObjectId == CurrentRun.Hero.ObjectId then
		for value, traitData in pairs(GetHeroTraitValues("DislodgeAmmoProperties")) do
			if args.EffectName == nil and ( Contains( traitData.ValidWeapons, weaponName ) or WeaponData[weaponName] and Contains( traitData.ValidWeapons, WeaponData[weaponName].LinkedUpgrades )) then
				if not IsEmpty( victim.StoredAmmo ) then
					CreateAnimation({ Name = "ExitWoundsFx_Poseidon", DestinationId = victim.ObjectId })
				end
				while not IsEmpty( victim.StoredAmmo ) do
					local dropData = MergeTables(WeaponData[victim.StoredAmmo[1].WeaponName], { DropAmmoForceMin = traitData.ForceMin, DropAmmoForceMax = traitData.ForceMax, Angle = args.ImpactAngle, AmmoDropDelay = 0 })
					DropStoredAmmo( victim, dropData )
				end
			end
		end
	end


	TryUnloadAmmo( weaponName, victim, attacker, args )
end

function CheckOnImpactPowers( victim, attacker, args )
	if attacker ~= nil and ( victim == nil or victim.TriggersOnDamageEffects ) then
		local victimId = nil
		if victim ~= nil then
			victimId = victim.ObjectId
		end
		for i, weaponData in pairs(GetHeroTraitValues("OnImpactWeapons")) do
			local passesVelocityCheck = weaponData.RequireImpactMin == nil or (weaponData.RequireImpactMin and args.ImpactVelocity  ~= nil and args.ImpactVelocity >= weaponData.RequireImpactMin)
			if passesVelocityCheck then
				FireWeaponFromUnit({ Weapon = weaponData.Weapon, Id = attacker.ObjectId, DestinationId = victimId, FireFromTarget = weaponData.FireFromVictimLocation})
			end
		end
	end
end

function CheckOnDeathPowers( victim, attacker, weaponName )
	if attacker ~= nil and attacker.OnKillWeapons ~= nil then
		if attacker.OnKillWeapons[weaponName] ~= nil then
			for weaponName, v in pairs( attacker.OnKillWeapons[weaponName] ) do
				FireWeaponFromUnit({ Weapon = weaponName, AutoEquip = true, Id = attacker.ObjectId, DestinationId = victim.ObjectId })
			end
		end
	end

	local attackerId = nil
	if attacker ~= nil then
		attackerId = attacker.ObjectId
	end

	if victim ~= nil and victim.OnDeathWeapons ~= nil then
		for onDeathWeaponName, v in pairs( victim.OnDeathWeapons ) do
			local weaponData = WeaponData[onDeathWeaponName]
			local destinationId = attackerId
			if weaponData ~= nil and weaponData.TargetSelf then
				destinationId = victim.ObjectId
			end
			FireWeaponFromUnit({ Weapon = onDeathWeaponName, AutoEquip = true, Id = victim.ObjectId, DestinationId = destinationId })
		end
	end
end

function CheckComboPowers( victim, attacker, triggerArgs, sourceWeaponData )

	if sourceWeaponData == nil or sourceWeaponData.ComboPoints == nil or sourceWeaponData.ComboPoints <= 0 then
		return
	end

	if triggerArgs.EffectName ~= nil then
		-- Effects never generate combo points for now
		return
	end

	if victim.NoComboPoints then
		return
	end

	if not HeroHasTrait( "FistWeaveTrait" ) then
		return
	end

	attacker.ComboCount = (attacker.ComboCount or 0) + sourceWeaponData.ComboPoints

	if attacker.ComboCount >= attacker.ComboThreshold and not attacker.ComboReady then
		attacker.ComboReady = true
		SetWeaponProperty({ WeaponName = "FistWeaponSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectiles", Value = 2 + GetTotalHeroTraitValue("BonusSpecialHits") })
		SetWeaponProperty({ WeaponName = "FistWeaponSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "FireFx2", Value = "FistUppercutSpecial" })
		if HeroHasTrait( "FistSpecialFireballTrait" ) then
			SetWeaponProperty({ WeaponName = "FistWeaponSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "ProjectileInterval", Value = 0.08 })
		else
			SetWeaponProperty({ WeaponName = "FistWeaponSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "ProjectileInterval", Value = 0.03 })
		end
		SetWeaponProperty({ WeaponName = "FistWeaponSpecialDash", DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectiles", Value = 1 + GetTotalHeroTraitValue("BonusSpecialHits") })
		SetWeaponProperty({ WeaponName = "FistWeaponSpecialDash", DestinationId = CurrentRun.Hero.ObjectId, Property = "ProjectileInterval", Value = 0.03 })
		SetWeaponProperty({ WeaponName = "FistWeaponSpecialDash", DestinationId = CurrentRun.Hero.ObjectId, Property = "FireFx2", Value = "FistUppercutSpecial" })

		ComboReadyPresentation( attacker, triggerArgs )
	end

end

function CheckComboPowerReset( attacker, weaponData, args )
	if weaponData ~= nil and attacker.ComboReady then
		thread(MarkObjectiveComplete, "FistWeaponFistWeave")
		attacker.ComboReady = false
		attacker.ComboCount = 0
		SetWeaponProperty({ WeaponName = "FistWeaponSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectiles", Value = 2 })
		if HeroHasTrait( "FistSpecialFireballTrait" ) then
			SetWeaponProperty({ WeaponName = "FistWeaponSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectiles", Value = 1 })
		end
		SetWeaponProperty({ WeaponName = "FistWeaponSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "ProjectileInterval", Value = 0.13 })
		SetWeaponProperty({ WeaponName = "FistWeaponSpecial", DestinationId = CurrentRun.Hero.ObjectId, Property = "FireFx2", Value = "null" })
		SetWeaponProperty({ WeaponName = "FistWeaponSpecialDash", DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectiles", Value = 1 })
		SetWeaponProperty({ WeaponName = "FistWeaponSpecialDash", DestinationId = CurrentRun.Hero.ObjectId, Property = "ProjectileInterval", Value = 0 })
		SetWeaponProperty({ WeaponName = "FistWeaponSpecialDash", DestinationId = CurrentRun.Hero.ObjectId, Property = "FireFx2", Value = "null" })
		if not args or not args.Undelivered then
			ComboDeliveredPresentation( attacker, triggerArgs )
		end
	end
end

function AddBlockEmpower( weaponName )
	if weaponName == "ShieldWeaponRush" then
		FireWeaponFromUnit({ Weapon = "BlockEmpowerApplicator", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	end
end

function ShieldBounceEmpower( triggerArgs, traitDataArgs )

	if triggerArgs.name == "ShieldThrow" or triggerArgs.name == "ShieldThrowDash" then
		local validFlight = CurrentRun.CurrentRoom.ShieldThrowHits and CurrentRun.CurrentRoom.ShieldThrowHits > 0

		if validFlight then
			FireWeaponFromUnit({ Weapon = "ShieldThrowEmpowerApplicator", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		else
			ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "ShieldThrowDamageBonus" })
		end
		CurrentRun.CurrentRoom.ShieldThrowHits = 0
	end
end

function DamageOverTimeApply( triggerArgs )
	UpdatePoisonEffectStacks( triggerArgs )
end

function DamageOverTimeClear( triggerArgs )
	ClearPoisonEffectStacks( triggerArgs )
end

function FreezeStunApply( triggerArgs )
	thread( HitByFreezeWeapon, triggerArgs.TriggeredByTable )
end

function OnHitStunApply( triggerArgs )
	thread( FinishTargetMarker, triggerArgs.TriggeredByTable )
end

function SpearRushBonusApply( triggerArgs )
	if not triggerArgs.Reapplied then
		local validWeapons = ConcatTableValues( DeepCopyTable( WeaponSets.HeroRangedWeapons ), AddLinkedWeapons( WeaponSets.HeroPhysicalWeapons ))
		AddLimitedWeaponBonus({ AsMultiplier = true, EffectName = triggerArgs.EffectName, Amount = 4, DamageBonus = triggerArgs.Modifier, WeaponNames = validWeapons } )
	end
end

function ShieldThrowDamageBonusApply( triggerArgs )
	if not triggerArgs.Reapplied then
		local validWeapons = AddLinkedWeapons( WeaponSets.HeroPhysicalWeapons )
		local bonus = 2
		if bonus > 0 then
			AddLimitedWeaponBonus({ AsMultiplier = true, EffectName = triggerArgs.EffectName, Amount = bonus, DamageBonus = triggerArgs.Modifier, WeaponNames = validWeapons } )
		end

		CurrentRun.Hero.ShieldThrowHits = 0
	end
end

function MarkTargetApply( triggerArgs )
	if not triggerArgs.Reapplied then
		if CurrentRun.CurrentRoom.LastMarkedTargetId ~= nil then
			ClearEffect({ Id = CurrentRun.CurrentRoom.LastMarkedTargetId, Name = "MarkTarget" })
			BlockEffect({ Id = CurrentRun.CurrentRoom.LastMarkedTargetId, Name = "MarkTarget", Duration = 0.1 })
		end
		CurrentRun.CurrentRoom.LastMarkedTargetId = triggerArgs.triggeredById
		SetWeaponProperty({ WeaponName = "BowSplitShot", DestinationId = CurrentRun.Hero.ObjectId, Property = "OverrideFireRequestTarget", Value = triggerArgs.triggeredById, DataValue = false})
	end
end

function MarkTargetClear( triggerArgs )
	SetWeaponProperty({ WeaponName = "BowSplitShot", DestinationId = CurrentRun.Hero.ObjectId, Property = "OverrideFireRequestTarget", Value = -1, DataValue = false})
end

function MarkTargetSpinApply( triggerArgs )
	if not triggerArgs.Reapplied then
		local validWeapons =
		{
			"SpearWeapon",
			"SpearWeapon2",
			"SpearWeapon3",
			"SpearWeaponDash",
			"SpearWeaponThrow",
			"SpearWeaponThrowReturn",
		}

		AddIncomingDamageModifier( triggerArgs.TriggeredByTable,
		{
			Name = triggerArgs.EffectName,
			ValidWeapons =  validWeapons,
			ValidWeaponMultiplier = triggerArgs.Modifier
		})
	end
end

function MarkTargetSpinClear( triggerArgs )
	if triggerArgs.TriggeredByTable.IncomingDamageModifiers then
		RemoveIncomingDamageModifier( triggerArgs.TriggeredByTable, triggerArgs.EffectName )
	end
end

function ClearMarkTargetSpinApply( triggerArgs )
	if HasIncomingDamageModifier( triggerArgs.TriggeredByTable, "MarkTargetSpin" ) then
		ClearEffect({ Id = triggerArgs.TriggeredByTable.ObjectId, Name = "MarkTargetSpin" })
	end
end

function MarkTargetFistApply( triggerArgs )
	if not triggerArgs.Reapplied then
		local validWeapons =
		{
			"FistWeapon",
			"FistWeapon2",
			"FistWeapon3",
			"FistWeapon4",
			"FistWeapon5",
			"FistWeaponDash",
			"RangedWeapon",
		}

		AddIncomingDamageModifier( triggerArgs.TriggeredByTable,
		{
			Name = triggerArgs.EffectName,
			ValidWeapons =  validWeapons,
			ValidWeaponMultiplier = triggerArgs.Modifier
		})
	end
end

function MarkTargetFistClear( triggerArgs )
	if triggerArgs.TriggeredByTable.IncomingDamageModifiers then
		RemoveIncomingDamageModifier( triggerArgs.TriggeredByTable, triggerArgs.EffectName )
	end
end

function StyxPoisonApply( triggerArgs )
	if not triggerArgs.Reapplied and triggerArgs.TriggeredByTable == CurrentRun.Hero then
		StartStyxPoisonPresentation()
	end
end

function StyxPoisonClear( triggerArgs )
	local unit = triggerArgs.TriggeredByTable
	if unit == CurrentRun.Hero then
		EndStyxPoisonPresentation()
	end
end

function CheckLavaPresentation( victim, victimId, triggerArgs )
	if triggerArgs.DamageAmount and triggerArgs.DamageAmount > 0 and CurrentRun.Hero and victim == CurrentRun.Hero and not CurrentRun.Hero.IsDead and not CurrentRun.Hero.LavaPresentationActive then
		if not HasIncomingDamageModifier( CurrentRun.Hero, "ConsecerationLavaDefense" ) then
			CurrentRun.Hero.LavaPresentationActive = true
			StartLavaPresentation()
		end
	end
end

function CheckLavaSplashPresentation( victim, victimId, triggerArgs )
	if triggerArgs.DamageAmount and triggerArgs.DamageAmount > 0 and CurrentRun.Hero and victim == CurrentRun.Hero and not CurrentRun.Hero.IsDead and not CurrentRun.Hero.LavaPresentationActive and triggerArgs.SourceProjectile and triggerArgs.SourceProjectile == "LavaPuddleLarge" then
		if not HasIncomingDamageModifier( CurrentRun.Hero, "ConsecerationLavaDefense" ) then
			CurrentRun.Hero.LavaPresentationActive = true
			StartLavaPresentation()
		end
	end
end

function LavaSlowApply( triggerArgs )
	local unit = triggerArgs.TriggeredByTable
	if unit == CurrentRun.Hero then
		CurrentRun.Hero.OnLava = true
	end
end

function LavaSlowClear( triggerArgs )
	local unit = triggerArgs.TriggeredByTable
	if unit == CurrentRun.Hero then
		CurrentRun.Hero.LavaPresentationActive = nil
		CurrentRun.Hero.OnLava = nil
		EndLavaPresentation()
	end
end

function HermesSlowApply( triggerArgs )
	local victim = triggerArgs.TriggeredByTable
	if not triggerArgs.Reapplied then
		if victim.SpeedMultiplier then
			victim.SpeedMultiplier = victim.SpeedMultiplier * triggerArgs.ElapsedTimeMultiplier
		else
			victim.SpeedMultiplier = triggerArgs.ElapsedTimeMultiplier
		end
	end
end

function HermesSlowClear( triggerArgs )
	local unit = triggerArgs.TriggeredByTable
	if unit.SpeedMultiplier then
		unit.SpeedMultiplier = unit.SpeedMultiplier / triggerArgs.ElapsedTimeMultiplier
	else
		unit.SpeedMultiplier = 1
	end
end

function MarkBondTargetApply( triggerArgs )
	local victim = triggerArgs.TriggeredByTable
	if not triggerArgs.Reapplied then
		local offset = victim.HealthBarOffsetY or -180
		if victim.CustomEffectOffsetY and victim.CustomEffectOffsetY[triggerArgs.EffectName] then
			offset = victim.CustomEffectOffsetY[triggerArgs.EffectName]
		end
		CreateAnimation({ Name = "MarkTargetRama", DestinationId = victim.ObjectId, OffsetY = offset + 100, Group = "Combat_UI_World" })
	end
end

function MarkBondTargetClear( triggerArgs )
	local victim = triggerArgs.TriggeredByTable
	StopAnimation({ Name = "MarkTargetRama", DestinationId = victim.ObjectId })
end

function MarkRuptureTargetApply( triggerArgs )
	UpdateRuptureEffectStacks( triggerArgs )
end

function MarkRuptureTargetClear( triggerArgs )
	local victim = triggerArgs.TriggeredByTable
	StopAnimation({ Name = "PoseidonAresProjectileGlow", DestinationId = victim.ObjectId })
	ClearRuptureEffectStacks( triggerArgs )
end

function DemeterSlowApply( triggerArgs )
	local victim = triggerArgs.TriggeredByTable
	ChillApplyPresentation( victim, victim.ObjectId, triggerArgs.Stacks )

	victim.Slowed = true
	victim.SpeedMultiplier = triggerArgs.UnitElapsedTimeMultiplier
	if triggerArgs.Stacks >= 10 and HeroHasTrait("MaximumChillBlast") then
		ClearEffect({ Id = victim.ObjectId, Name = "DemeterSlow" })
		BlockEffect({ Id = victim.ObjectId, Name = "DemeterSlow", Duration = 0.1 })
		triggerArgs.BlockedEffect = "DemeterSlow"
		FireWeaponFromUnit({ Weapon = "DemeterMaxChill", Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, AutoEquip = true, FireFromTarget = true })
	end
end

function DemeterSlowClear( triggerArgs )
	local unit = triggerArgs.TriggeredByTable
	if unit.Slowed then
		ChillClearPresentation( unit, unit.ObjectId )
	end
	unit.Slowed = nil
	if unit.SpeedMultiplier then
		unit.SpeedMultiplier = unit.SpeedMultiplier / triggerArgs.ElapsedTimeMultiplier
	else
		unit.SpeedMultiplier = 1
	end
end

function KillDamageBonusApply( triggerArgs )
	AddLimitedWeaponBonus({ AsMultiplier = true, EffectName = triggerArgs.EffectName, Amount = 1, DamageBonus = GetTotalHeroTraitValue("OnEnemyDeathKillBonus"), WeaponNames = WeaponSets.HeroPrimarySecondaryWeapons } )
end

function GrenadeSelfDamageOutputApply(triggerArgs)
	thread(MarkObjectiveComplete, "GunEmpower")
end

function ManualReloadBonusApply( triggerArgs )
	SwapWeapon({ Name = "GunWeapon", SwapWeaponName = "SniperGunWeapon", ClearFireRequest = true, StompOriginalWeapon = false, GainedControlFrom = "GunWeapon", DestinationId = CurrentRun.Hero.ObjectId, ExtendControlIfSwapActive = true, RequireCurrentControl = true })
	SwapWeapon({ Name = "GunWeaponDash", SwapWeaponName = "SniperGunWeaponDash", ClearFireRequest = true, StompOriginalWeapon = false, GainedControlFrom = "SniperGunWeapon", DestinationId = CurrentRun.Hero.ObjectId, ExtendControlIfSwapActive = true, RequireCurrentControl = true })
end

function ShieldFireClear( triggerArgs, args )
	if HeroHasTrait("ShieldLoadAmmoTrait") and CurrentRun.CurrentRoom.LoadedAmmo and CurrentRun.CurrentRoom.LoadedAmmo > 0 and triggerArgs.name == "ShieldWeaponRush" and CurrentRun.Hero.StoredAmmo and CurrentRun.CurrentRoom.LoadedAmmo then
		local numAmmo = CurrentRun.CurrentRoom.LoadedAmmo
		if HeroHasTrait("ShieldLoadAmmo_ZeusRangedTrait" ) then
			local targetId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY })
			for i = 1, numAmmo do
				thread(FireWeaponWithinRange, { SourceId = targetId, Range = 350, SeekTarget = true, WeaponName = "ZeusShieldLoadAmmoStrike", InitialDelay = 0.1 * i, Delay = 0.25, Count = 1, BonusChance = GetTotalHeroTraitValue("BonusBolts") })
			end
			thread( DestroyOnDelay, { targetId }, 3 )
		end
		
		thread( UnloadAmmoThread, { Count = numAmmo , Attacker = CurrentRun.Hero, Angle = GetAngle({Id = CurrentRun.Hero.ObjectId}), LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY, Interval = args.Interval })
		
		while numAmmo  > 0 do
			for i, ammoData in pairs( CurrentRun.Hero.StoredAmmo ) do
				if ammoData.WeaponName == "SelfLoadAmmoApplicator" then
					local ammoAnchors = ScreenAnchors.SelfStoredAmmo
					if ammoAnchors ~= nil and ammoAnchors[#ammoAnchors] ~= nil then
						Destroy({ Id = ammoAnchors[#ammoAnchors] })
						ammoAnchors[#ammoAnchors] = nil
					end
					CurrentRun.Hero.StoredAmmo[i] = nil
					break
				end
			end
			numAmmo  = numAmmo  - 1
		end
		CurrentRun.Hero.StoredAmmo = CollapseTable( CurrentRun.Hero.StoredAmmo )

		thread(MarkObjectiveComplete, "BeowulfTackle")
		ShieldFireClearPresentation( triggerArgs )
	end
end

function ShieldThrowProjectileBonusApply( triggerArgs )
	if not triggerArgs.Reapplied then
		AddOnFireWeapons( CurrentRun.Hero, "ShieldThrow" , { LegalOnFireWeapons = {"ShieldThrow", "ShieldThrowDash" }, AddOnFireWeapons = { "ChaosShieldThrow" }} )
		AddOnFireWeapons( CurrentRun.Hero, "ShieldThrowDash" , { LegalOnFireWeapons = {"ShieldThrow", "ShieldThrowDash" }, AddOnFireWeapons = { "ChaosShieldThrow" }} )
		AddLimitedWeaponBonus({ AsMultiplier = true, EffectName = triggerArgs.EffectName, Amount = 1, DamageBonus = 0, WeaponNames = { "ShieldThrow", "ShieldThrowDash"} } )
	end
end

function FistKillBonusApply( triggerArgs )
	if not triggerArgs.Reapplied then
		local healFraction = GetTotalHeroTraitValue("FistKillHeal")
		Heal( CurrentRun.Hero, { HealFraction = healFraction, SourceName = "FistKillBonus" } )
		thread( UpdateHealthUI )
	end
end

function ShieldThrowProjectileBonusClear( triggerArgs )

		RemoveOnFireWeapons( CurrentRun.Hero, { LegalOnFireWeapons = {"ShieldThrow", "ShieldThrowDash" }, AddOnFireWeapons = { "ChaosShieldThrow" }} )
end

-- |DASH WEAPONS| --
OnWeaponFired{ "ShieldWeaponRush",
	function(triggerArgs)
		SetPlayerPhasing("ShieldWeaponRush")
		if HeroHasTrait("ShieldRushBonusProjectileTrait") then
			FireWeaponFromUnit({ Weapon = "ShieldThrowProjectileBonusApplicator", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		end
		if HeroHasTrait("ShieldLoadAmmoTrait") then

			local parentTrait = nil
			for i, traitData in pairs( CurrentRun.Hero.Traits ) do
				if traitData.Name == "ShieldLoadAmmoTrait" then
					parentTrait = traitData
					break
				end
			end
			SetProjectileProperty({ WeaponName = "ShieldWeaponRush", DestinationId = CurrentRun.Hero.ObjectId, Property = "Scale", Value = 1 })
			SetProjectileProperty({ WeaponName = "ShieldWeaponRush", DestinationId = CurrentRun.Hero.ObjectId, Property = "ExtentScale", Value = 1 })

			local parentAnimData = parentTrait.AnimDefinitions.Default
			for traitName, animData in pairs( parentTrait.AnimDefinitions ) do
				if traitName == "Default" or HeroHasTrait(traitName) then
					parentAnimData = animData
				end
			end
			if parentAnimData and parentAnimData.Unloaded then
				for changeKey, changeValue in pairs( parentAnimData.Unloaded ) do
					SetProjectileProperty({ WeaponName = "ShieldWeaponRush", DestinationId = CurrentRun.Hero.ObjectId, Property = changeKey, Value = changeValue })
				end
			end
		end
	end
}

OnComeToRest{ "_PlayerUnit",
	function( triggerArgs )
		SetPlayerUnphasing("ShieldWeaponRush")
	end
}

OnWeaponFired{ "RamWeapon",
	function(triggerArgs)
		SetPlayerPhasing("RamWeapon")
		ToggleControl({ Names = { "Rush" }, Enabled = false })
		DashManeuver( GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = "RamWeapon", Property = "Duration" }) + CurrentRun.Hero.DashManeuverTimeThreshold )
		SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToForce", Value = true })
		SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToStun", Value = true })
	end
}

OnRamWeaponComplete{ "RamWeapon",
	function(triggerArgs)
		SetPlayerUnphasing("RamWeapon")
		ToggleControl({ Names = { "Rush" }, Enabled = true })
		SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToForce", Value = false })
		SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "ImmuneToStun", Value = false })
		for i, dashData in pairs(GetHeroTraitValues("DashProperties")) do
			PostProcessDashProperties( dashData )
		end
	end
}

function SetupRamWeapon()
	local hasBeenApplied = false
	for i=1, GetNumMetaUpgrades("StaminaMetaUpgrade") do
		local upgradeData = MetaUpgradeData.StaminaMetaUpgrade
		ApplyMetaUpgrade( upgradeData, true, hasBeenApplied )
		hasBeenApplied = true
	end
end

OnWeaponFired{ "RushWeapon RamWeapon",
	function(triggerArgs)
		local runFunctions = {}

		for i, dashData in pairs( GetHeroTraitValues("AddRush") ) do
			local dashFunction = _G[dashData.FunctionName]
			if dashFunction ~= nil and ( not dashData.RunOnce or ( dashData.RunOnce and not runFunctions[ dashData.FunctionName ])) then
				thread( dashFunction, dashData.FunctionArgs, triggerArgs )
				runFunctions[dashData.FunctionName] = true
			end
		end
		for i, dashData in pairs( GetHeroTraitValues("DashProperties") ) do
			ProcessDashProperties( dashData )
			thread( PostProcessDashThread, dashData )
		end
	end
}


-- for charged dashes
OnWeaponCharging{ "RushWeapon",
	function( triggerArgs )
		for i, dashData in pairs(GetHeroTraitValues("DashChargeProperties")) do
			ProcessDashProperties( dashData )
		end
	end
}

OnWeaponChargeCanceled{ "RushWeapon",
	function(triggerArgs)
		for i, dashData in pairs(GetHeroTraitValues("DashChargeProperties")) do
			PostProcessDashProperties( dashData )
		end
	end
}

function ProcessDashProperties( args )
	if args == nil then
		return
	end
	if args.MoveGraphic then
		SetUnitProperty({ Property = "MoveGraphic", Value = args.MoveGraphic, DestinationId = CurrentRun.Hero.ObjectId })
	end
	if args.StopGraphic then
		SetUnitProperty({ Property = "StopGraphic", Value = args.StopGraphic, DestinationId = CurrentRun.Hero.ObjectId })
	end
	if args.CosmeticRotationSpeed then
		SetUnitProperty({ Property = "CosmeticRotationSpeed", Value = args.CosmeticRotationSpeed, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	end
	if args.ColorGrade then
		AdjustColorGrading({ Name = args.ColorGrade, Duration = args.ColorGradeStartDuration or 0 })
	end
	if args.RadialBlurStrength then
		AdjustRadialBlurStrength({ Fraction = args.RadialBlurStrength, Duration = args.RadialBlurStartDuration or 0 })
	end
	if args.RadialBlurDistance then
		AdjustRadialBlurStrength({ Fraction = args.RadialBlurDistance, Duration = args.RadialBlurStartDuration or 0 })
	end
	if args.FullscreenBloom then
		AdjustFullscreenBloom({ Name = args.FullscreenBloom, Duration = args.FullscreenBloodStartDuration or 0 })
	end
	if args.StartCue then
		PlaySound({ Name = args.StartCue, Id = CurrentRun.Hero.ObjectId })
	end
	if args.AudioFilter then
		SetSoundCueValue({ Id = GetMixingId({}), Names = { args.AudioFilter }, Value = 1.0 })
	end
	if args.ElapsedTimeMultiplier then
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = args.ElapsedTimeMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "EnemyTeam" } })
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = args.ElapsedTimeMultiplier, DataValue = false, AllProjectiles = true })
		if CurrentRun.CurrentRoom.ElapsedTimeMultiplier == nil then
			CurrentRun.CurrentRoom.ElapsedTimeMultiplier = 1
		end

		CurrentRun.CurrentRoom.ElapsedTimeMultiplier = CurrentRun.CurrentRoom.ElapsedTimeMultiplier * args.ElapsedTimeMultiplier
	end
	if args.TimeModifierFraction then
		SetThingProperty({ Property = "TimeModifierFraction", Value = args.TimeModifierFraction, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	end
	if args.SimulationSlowSpeed then
		AddSimSpeedChange( "Dash", { Fraction = args.SimulationSlowSpeed, LerpTime = args.SimulationSlowSpeedLerp or 0 } )
	end
end

function PostProcessDashThread( args )
	wait( args.Duration, RoomThreadName )
	PostProcessDashProperties( args )
end

function PostProcessDashProperties( args )
	if args == nil then
		return
	end
	if args.MoveGraphic then
		SetUnitProperty({ Property = "MoveGraphic", Value = "ZagreusRun", DestinationId = CurrentRun.Hero.ObjectId })
	end
	if args.StopGraphic then
		SetUnitProperty({ Property = "StopGraphic", Value = "ZagreusStop", DestinationId = CurrentRun.Hero.ObjectId })
	end
	if args.CosmeticRotationSpeed then
		SetUnitProperty({ Property = "CosmeticRotationSpeed", Value = 1340, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	end
	if args.ColorGrade then
		AdjustColorGrading({ Name = "Off", Duration = 0.1 })
	end
	if args.FullscreenBloom then
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.1 })
	end
	if args.RadialBlurStrength then
		AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.1 })
	end
	if args.RadialBlurDistance then
		AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.1 })
	end
	if args.EndCue then
		PlaySound({ Name = args.EndCue, Id = CurrentRun.Hero.ObjectId })
	end
	if args.AudioFilter then
		SetSoundCueValue({ Id = GetMixingId({}), Names = { args.AudioFilter }, Value = 0.0 })
	end
	if args.ElapsedTimeMultiplier then
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1/args.ElapsedTimeMultiplier, ValueChangeType = "Multiply", DataValue = false, DestinationNames = { "EnemyTeam" } })
		CurrentRun.CurrentRoom.ElapsedTimeMultiplier = CurrentRun.CurrentRoom.ElapsedTimeMultiplier * 1/args.ElapsedTimeMultiplier
		SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = CurrentRun.CurrentRoom.ElapsedTimeMultiplier, DataValue = false, AllProjectiles = true })
	end
	if args.TimeModifierFraction then
		SetThingProperty({ Property = "TimeModifierFraction", Value = 1.0, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	end
	if args.SimulationSlowSpeed then
		RemoveSimSpeedChange( "Dash", { LerpTime = args.SimulationSlowSpeedRestoreLerp or 0 } )
	end
end

function WalkingRetaliate()
	AddTraitToHero({ TraitName = "AphroditeWalkingRetaliateTrait" })
end

function FireWeaponWithinRange( args )
	if args.InitialDelay then
		wait(args.InitialDelay)
	end

	local sourceTargetId = args.SourceId or CurrentRun.Hero.ObjectId
	local count = args.Count or 1
	local bonusChance = args.BonusChance or 0
	local range = args.Range or 200
	local seekTarget = args.SeekTarget
	local chooseTarget = args.TargetId
	local weaponName = args.WeaponName
	local createdObstacleId = nil
	if not weaponName then
		return
	end

	count = count + math.floor(bonusChance)
	if RandomChance( bonusChance ) then
		count = count + 1
	end

	for i = 1, count do
		local nearestEnemyTarget = 0
		local targetId = 0
		if chooseTarget ~= nil then
			targetId = chooseTarget
		else
			if seekTarget then
				nearestEnemyTarget = GetClosest({ Id = sourceTargetId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = range })
			end
			if nearestEnemyTarget == 0 then
				local randomLightningTargetOffsetX = RandomFloat(-1 * range/2, range/2)
				local randomLightningTargetOffsetY = RandomFloat(-1 * range/2, range/2)
				targetId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting", DestinationId = sourceTargetId, OffsetX = randomLightningTargetOffsetX, OffsetY = randomLightningTargetOffsetY })
				createdObstacleId = targetId
			else
				targetId = nearestEnemyTarget
			end
		end
		if targetId ~= 0 then
			FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = targetId })
			Destroy({ Id = createdObstacleId })
		end
		if args.Delay then
			wait(args.Delay)
		end
	end
end


function MarkRandomNearby( victim, args )
	ClearEffect({ Id = victim.ObjectId, Name = "CritVulnerability" })
	BlockEffect({ Id = victim.ObjectId, Name = "CritVulnerability", Duration = 0.05 })
	local range = args.Range or 800
	local nearbyTargetIds = GetClosestIds({ Id = victim.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, IgnoreSelf = true, Distance = range })
	if not IsEmpty(nearbyTargetIds) then
		local nearbyTargetId = GetRandomValue(nearbyTargetIds)
		FireWeaponFromUnit({ Weapon = "CritVulnerabilityWeapon", AutoEquip = true, Id = CurrentRun.Hero.ObjectId, DestinationId = nearbyTargetId, FireFromTarget = true})
	end
end

function DionysusGiftDrop()
	local dropItemName = "GiftDrop"
	if GameState.Cosmetics and GameState.Cosmetics.GiftDropRunProgress then
		dropItemName = "GiftDropRunProgress"
	end
	GiveRandomConsumables({
		Delay = 0.5,
		NotRequiredPickup = true,
		LootOptions =
		{
			{
				Name = dropItemName,
				Chance = 1,
			}
		}
	})
end

function ZeusDash()
	thread(FireWeaponWithinRange, { Range = 350, SeekTarget = true, WeaponName = "LightningDash", InitialDelay = 0, Delay = 0.25, Count = 1, BonusChance = GetTotalHeroTraitValue("BonusBolts") })
end

function ZeusPerfectDash( traitArgs, triggerArgs )
	if triggerArgs.NearbyDangerId ~= nil and triggerArgs.NearbyDangerId > 0 and CheckCooldownNoTrigger( "BlockPerfectDash", CurrentRun.Hero.PerfectDashHitDisableDuration ) then
		local hasPerfectDashMetaupgrade = IsMetaUpgradeActive( "PerfectDashMetaUpgrade" ) and GetNumMetaUpgrades("PerfectDashMetaUpgrade") > 0
		if not hasPerfectDashMetaupgrade then
			PerfectDashStartPresentation( triggerArgs )
			PerfectDashEndPresentation( triggerArgs, traitArgs.Text )
		end
		thread(FireWeaponWithinRange, { Range = traitArgs.Range, SeekTarget = true, WeaponName = "LightningPerfectDash", InitialDelay = 0, Delay = 0.25, Count = 1, BonusChance = GetTotalHeroTraitValue("BonusBolts") })
	end
end

function AddLimitedWeaponBonus( args )
	args = args or {}
	local isCrit = args.AsCrit or false
	local isMultiplier = args.AsMultiplier or false
	local effectName = args.EffectName
	local critBonus = args.CritBonus
	local damageBonus = args.DamageBonus
	local instances = args.Amount
	local weaponNames = args.WeaponNames or DeepCopyTable(WeaponSets.HeroMeleeWeapons)

	for weaponName, v in pairs( CurrentRun.Hero.Weapons ) do
		if Contains(weaponNames, weaponName) then
			local methodName = nil
			local parameters = nil
			if isCrit then
				methodName = "SetCritBonus"
				parameters = { instances, critBonus }

			end
			if isMultiplier then
				methodName = "SetAdditiveDamageBonus"
				parameters = { instances, damageBonus }
			end

			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = methodName, Parameters = parameters })
			local linkedWeaponNames = WeaponSets.LinkedWeaponUpgrades[weaponName]
			if linkedWeaponNames ~= nil then
				for k, linkedWeaponName in pairs( linkedWeaponNames ) do
					RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = linkedWeaponName, Method = methodName, Parameters = parameters })
					table.insert(weaponNames, linkedWeaponName)
				end
			end
		end
	end
	CurrentRun.Hero.GuaranteedCrit[ effectName ] = ShallowCopyTable(args)
	CurrentRun.Hero.GuaranteedCrit[ effectName ].ValidWeapons = ShallowCopyTable(weaponNames)
	NotifyOnEffectExpired({ Id = CurrentRun.Hero.ObjectId, Notify = effectName.."Expired", EffectName = effectName })
	waitUntil( effectName.."Expired" )
	CheckCritWeaponsExpired( effectName )
	CurrentRun.Hero.GuaranteedCrit[ effectName ] = nil
end

function RemoveCritWeapons( firedWeaponName )
	if not IsEmpty(CurrentRun.Hero.GuaranteedCrit) then
		for key, data in pairs(CurrentRun.Hero.GuaranteedCrit) do
			if Contains(data.ValidWeapons, firedWeaponName) then
				data.Amount = data.Amount - 1

				local methodName = nil
				local parameters = nil
				if data.AsCrit then
					methodName = "SetCritBonus"
					parameters = { data.Amount, data.CritBonus }
				end
				if data.AsMultiplier then
					methodName = "SetAdditiveDamageBonus"
					parameters = { data.Amount, data.DamageBonus }
				end
				for i, weaponName in pairs(data.ValidWeapons) do
					RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = methodName, Parameters = parameters })
				end
			end
		end

		for effectName, effectData in pairs( CurrentRun.Hero.GuaranteedCrit ) do
			if effectData.Amount <= 0 then
				ClearEffect({Id = CurrentRun.Hero.ObjectId, Name = effectName })
				CurrentRun.Hero.GuaranteedCrit[effectName] = nil
			end
		end
	end
end

function CheckCritWeaponsExpired( effectName )
	local data = CurrentRun.Hero.GuaranteedCrit[effectName]
	if data ~= nil and data.ValidWeapons ~= nil then
		for i, weaponName in pairs(data.ValidWeapons) do
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponName, Method = "SetCritBonus", Parameters = { 0, 0 } })
		end
	end
end

function PoseidonDash()
	EquipWeapon({ Name = "WaterBlastDash", DestinationId = CurrentRun.Hero.ObjectId })
	--FireWeaponFromUnit({ Weapon = "WaterBlastDash", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.07)
	FireWeaponFromUnit({ Weapon = "WaterBlastDash", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
end

function HermesDash()
	AddTraitToHero( {TraitName = "HermesBonusSpeedTrait" })
end

OnWeaponFired{ "RushWeapon",
	function( triggerArgs )
		DashManeuver()
		if triggerArgs.NearbyDangerId ~= nil and triggerArgs.NearbyDangerId > 0 and IsMetaUpgradeActive( "PerfectDashMetaUpgrade" ) and GetNumMetaUpgrades("PerfectDashMetaUpgrade") > 0 and CheckCooldownNoTrigger( "BlockPerfectDash", CurrentRun.Hero.PerfectDashHitDisableDuration ) then
			PerfectDashStartPresentation( triggerArgs )
			FireWeaponFromUnit({ Weapon = "PerfectDashEmpowerApplicator", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
			PerfectDashEndPresentation( triggerArgs )
		end
	end
}

function DashManeuver( duration )
	if CurrentRun.Hero.RallyHealth.RallyActive and CurrentRun.Hero.RallyHealth.RallyHealOnDash and not CurrentRun.Hero.IsDead then
		if CurrentRun.Hero.RallyHealth.Store > 0 then
			rallyHeal = round( CurrentRun.Hero.RallyHealth.Store )
			CurrentRun.Hero.RallyHealth.Store = CurrentRun.Hero.RallyHealth.Store - rallyHeal
			Heal( CurrentRun.Hero, { HealAmount = rallyHeal, SourceName = "RallyHeal", Silent = false } )
			RallyHealPresentation()
			thread( UpdateHealthUI )
		end
	end

	if HeroHasTrait("GunLoadedGrenadeTrait") then
		return
	end

	for equippedWeapon, k in pairs( CurrentRun.Hero.Weapons ) do
		local weaponData = GetWeaponData( CurrentRun.Hero, equippedWeapon )
		local dashWeapon = weaponData.DashWeapon
		if dashWeapon ~= nil and (not HeroHasTrait("FistSpecialFireballTrait") or equippedWeapon ~= "FistWeaponSpecial" ) then
			if weaponData.ExpireDashWeaponOnDash then
				ExpireProjectiles({ WeaponName = dashWeapon })
			end

			for i, replaceWeapons in pairs( GetHeroTraitValues("ReplaceMeleeWeapon") ) do
				weaponData = WeaponData[replaceWeapons]
			end

			if HasEffect({Id = CurrentRun.Hero.ObjectId, EffectName = "ManualReloadBonus" }) then
				SwapWeapon({ Name = "SniperGunWeapon", SwapWeaponName = "SniperGunWeaponDash", GainedControlFrom = "SniperGunWeapon", DestinationId = CurrentRun.Hero.ObjectId, ExtendControlIfSwapActive = true, RequireCurrentControl = true, ClearFireRequest = true,  })
			else
				SwapWeapon({ Names = weaponData.DashSwaps or { weaponData.Name }, SwapWeaponName = dashWeapon, DestinationId = CurrentRun.Hero.ObjectId, ExtendControlIfSwapActive = true, RequireCurrentControl = true })
			end
		end
	end

	if HeroHasTrait( "GunDashAmmoTrait" ) and GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = "GunWeapon", Property = "Ammo" }) > 0 then
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "GunWeapon", Method = "AddAmmo", Parameters = { 3 } })
		UpdateGunUI()
	end

end

function SetupAmmoLoad( unit, args )

	if CurrentRun and CurrentRun.CurrentRoom then
		CurrentRun.CurrentRoom.LoadedAmmo = 0
		CurrentRun.CurrentRoom.MaxLoadedAmmo = args.MaxCount
		CurrentRun.CurrentRoom.ValidVolleys = {}
		CurrentRun.Hero.StoredAmmo = {}
	end
	Destroy({Ids = ScreenAnchors.SelfStoredAmmo})
	SwapWeapon({ Name = "RangedWeapon", SwapWeaponName = "LoadAmmoApplicator", DestinationId = unit.ObjectId })
end

function SetupSelfAmmoLoad( unit, args )

	if CurrentRun and CurrentRun.CurrentRoom then
		CurrentRun.CurrentRoom.LoadedAmmo = 0
		CurrentRun.Hero.StoredAmmo = {}
	end
	Destroy({Ids = ScreenAnchors.SelfStoredAmmo})

	SwapWeapon({ Name = "RangedWeapon", SwapWeaponName = "SelfLoadAmmoApplicator", DestinationId = unit.ObjectId })
end

function RemoveManualReloadBonus( unit )
	ClearEffect({ Id = unit.ObjectId, Name = "ManualReloadBonus" })
end

function RemoveSpearBase( unit )
	if TableLength(GetIdsByType({ Name = "SpearReturnPoint" })) > 0 then
		FireWeaponFromUnit({ Weapon = "SpearWeaponThrowInvisibleReturn", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true })
	end
end

function RemoveSpearTeleport( unit )
	ClearEffect({ Id = unit.ObjectId, Name = "SpearRushBonus" })
	if TableLength(GetIdsByType({ Name = "SpearReturnPointAlt01" })) > 0 then
		FireWeaponFromUnit({ Weapon = "SpearWeaponThrowInvisibleReturn", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true })
	end
end

function RemoveSpearWeave( unit )
	if TableLength(GetIdsByType({ Name = "SpearReturnPointAlt02" })) > 0 then
		FireWeaponFromUnit({ Weapon = "SpearWeaponThrowInvisibleReturn", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, AutoEquip = true })
	end
end

function RemoveSpearGuanYu( unit )
	Destroy({ Ids = GetIdsByType({ Name = "SpearReturnPointAlt03" })})
end

function RemoveAmmoLoad( unit )
	UnequipWeapon({ DestinationId = unit.ObjectId, Name = "LoadAmmoApplicator" })
	UnequipWeapon({ DestinationId = unit.ObjectId, Name = "RangedWeapon" })
	EquipWeapon({ DestinationId = unit.ObjectId, Name = "RangedWeapon" })

	local ammoIds = GetIdsByType({ Name = "AmmoPack" })
	Destroy({ Ids = ammoIds })
	RunWeaponMethod({ Id = unit.ObjectId, Weapon = "RangedWeapon", Method = "RefillAmmo" })
	thread( UpdateAmmoUI )
	CurrentRun.CurrentRoom.ValidVolleys = {}

		for upgradeName, amount in pairs( CurrentRun.MetaUpgrades or GameState.MetaUpgrades ) do
			local upgradeData = MetaUpgradeData[upgradeName]
			local hasAffectedMetaUpgrade = false
			if upgradeData and upgradeData.PropertyChanges ~= nil then
				for _, propertyChange in pairs( upgradeData.PropertyChanges) do
					if ( propertyChange.WeaponNames ~= nil and Contains(propertyChange.WeaponNames, "RangedWeapon" )) or ( propertyChange.WeaponName ~= nil and propertyChange.WeaponName == "RangedWeapon" ) then
						hasAffectedMetaUpgrade = true
						break
					end
				end

				if hasAffectedMetaUpgrade then
					for i = 1, amount do
						ApplyMetaUpgrade( upgradeData, false, i == 1 )
					end
				end
			elseif not upgradeData then
				DebugPrint({Text = " Unable to find metaupgrade " .. upgradeName .. ", skipping." })
			end
		end
end

function RemoveSelfAmmoLoad( unit )

	UnequipWeapon({ DestinationId = unit.ObjectId, Name = "SelfLoadAmmoApplicator" })
	UnequipWeapon({ DestinationId = unit.ObjectId, Name = "RangedWeapon" })
	EquipWeapon({ DestinationId = unit.ObjectId, Name = "RangedWeapon" })

	local ammoIds = GetIdsByType({ Name = "AmmoPack" })
	Destroy({ Ids = ammoIds })
	RunWeaponMethod({ Id = unit.ObjectId, Weapon = "RangedWeapon", Method = "RefillAmmo" })
    CurrentRun.CurrentRoom.LoadedAmmo = 0
    CurrentRun.Hero.StoredAmmo = {}

   Destroy({ Ids = ScreenAnchors.SelfStoredAmmo })
   thread( UpdateAmmoUI )

	for upgradeName, amount in pairs( CurrentRun.MetaUpgrades or GameState.MetaUpgrades ) do
		local upgradeData = MetaUpgradeData[upgradeName]
		local hasAffectedMetaUpgrade = false
		if upgradeData and upgradeData.PropertyChanges ~= nil then
			for _, propertyChange in pairs( upgradeData.PropertyChanges) do
				if ( propertyChange.WeaponNames ~= nil and Contains(propertyChange.WeaponNames, "RangedWeapon" )) or ( propertyChange.WeaponName ~= nil and propertyChange.WeaponName == "RangedWeapon" ) then
					hasAffectedMetaUpgrade = true
					break
				end
			end

			if hasAffectedMetaUpgrade then
				for i = 1, amount do
					ApplyMetaUpgrade( upgradeData, false, i == 1 )
				end
			end
		end
	end
end


function ReloadRangedAmmo( delay )
	wait( delay, RoomThreadName )
	if IsMetaUpgradeActive("ReloadAmmoMetaUpgrade") then
		EndAmmoReloadPresentation()
	end

	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "RangedWeapon", Method = "AddAmmo", Parameters = { 1 } })
	if IsMetaUpgradeActive("ReloadAmmoMetaUpgrade") then
		ReloadAmmoPresentation()
	else
		AddAmmoPresentation()
	end

end

function LoadAmmo()
	if not CurrentRun.CurrentRoom.LoadedAmmo or not HeroHasTrait( "BowLoadAmmoTrait" ) then
		return
	end

	CurrentRun.CurrentRoom.ValidVolleys = CurrentRun.CurrentRoom.ValidVolleys or {}
	local currentBowVolley = GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = "BowWeapon", Property = "Volley" }) or 0
	local currentBowDashVolley = GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = "BowWeaponDash", Property = "Volley" }) or 0
	local nextLoadedAmmoVolley = 0

	for i, value in pairs( CurrentRun.CurrentRoom.ValidVolleys ) do
		if value.BowWeapon == currentBowVolley + 1 and value.BowWeaponDash == currentBowDashVolley + 1 then
			nextLoadedAmmoVolley = nextLoadedAmmoVolley + 1
		end
	end

	PlaySound({ Name = "/Leftovers/SFX/HarpDash", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.LoadingAmmoVoiceLines, true )
		if ScreenAnchors.AmmoIndicatorUI then
		local offsetX = 380
		local offsetY = -50
		ScreenAnchors.SelfStoredAmmo =  ScreenAnchors.SelfStoredAmmo or {}
		offsetX = offsetX + ( #ScreenAnchors.SelfStoredAmmo * 22 )
		local screenId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", DestinationId = ScreenAnchors.HealthBack, X = 10 + offsetX, Y = ScreenHeight - 50 + offsetY })
		SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = screenId })
		table.insert( ScreenAnchors.SelfStoredAmmo, screenId )
		SetAnimation({ Name = "SelfStoredAmmoIcon", DestinationId = screenId })
	end

	local storedAmmoData =
	{
		Count = 1,
		ForceMin = 300,
		ForceMax = 500,
		AttackerId = CurrentRun.Hero.ObjectId,
		WeaponName = "SelfLoadAmmoApplicator",
		Id = _worldTime
	}
	CurrentRun.Hero.StoredAmmo = CurrentRun.Hero.StoredAmmo or {}
	table.insert( CurrentRun.Hero.StoredAmmo, storedAmmoData )
	thread( UpdateAmmoUI )


	if nextLoadedAmmoVolley < CurrentRun.CurrentRoom.MaxLoadedAmmo then
		IncrementTableValue( CurrentRun.CurrentRoom, "LoadedAmmo" )
		table.insert( CurrentRun.CurrentRoom.ValidVolleys,
		{
			BowWeapon = currentBowVolley + 1,
			BowWeaponDash = currentBowDashVolley + 1,
		})
		thread( UpdateAmmoUI )
	else
		thread( InCombatText, CurrentRun.Hero.ObjectId, "CombatText_MaxLoaded" )
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "RangedWeapon", Method = "AddAmmo", Parameters = { 1 } })
	end
end

function IsLoadedVolley( attacker, weaponName, volleyIndex)
	if weaponName ~= nil and volleyIndex ~= nil and attacker ~= nil
		and attacker.ObjectId == CurrentRun.Hero.ObjectId
		and CurrentRun.CurrentRoom.LoadedAmmo
		and CurrentRun.CurrentRoom.LoadedAmmo > 0
		and CurrentRun.CurrentRoom.ValidVolleys  then

		for i, volleyData in pairs( CurrentRun.CurrentRoom.ValidVolleys ) do
			if volleyData[weaponName] and volleyIndex == volleyData[weaponName] then
				return true
			end
		end
	end
	return false
end

function TryUnloadAmmo( weaponName, victim, attacker, triggerArgs )
	if	attacker ~= nil and attacker.ObjectId == CurrentRun.Hero.ObjectId
		and CurrentRun.CurrentRoom.LoadedAmmo and CurrentRun.CurrentRoom.LoadedAmmo > 0
		and triggerArgs.FireIndex and triggerArgs.FireIndex == 0
		and CurrentRun.CurrentRoom.ValidVolleys and triggerArgs.ProjectileVolley then
		local count = 0
		local toDelete = {}
		for i, volleyData in pairs( CurrentRun.CurrentRoom.ValidVolleys ) do
			if volleyData[weaponName] and triggerArgs.ProjectileVolley == volleyData[weaponName] then
				count = count + 1
				table.insert( toDelete, volleyData )
			end
		end
		for i, condemnedData in pairs( toDelete ) do
			RemoveValue( CurrentRun.CurrentRoom.ValidVolleys, condemnedData )
			-- remove ammo indicator
			for i, ammoData in pairs( CurrentRun.Hero.StoredAmmo ) do
				if ammoData.WeaponName == "SelfLoadAmmoApplicator" then
					local ammoAnchors = ScreenAnchors.SelfStoredAmmo
					if ammoAnchors ~= nil and ammoAnchors[#ammoAnchors] ~= nil then
						Destroy({ Id = ammoAnchors[#ammoAnchors] })
						ammoAnchors[#ammoAnchors] = nil
					end
					CurrentRun.Hero.StoredAmmo[i] = nil
					break
				end
			end
		end
		CurrentRun.Hero.StoredAmmo = CollapseTable( CurrentRun.Hero.StoredAmmo )
		if count > 0 then
			thread( UnloadAmmoThread, { Count = count, Victim = victim, Attacker = attacker, LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY, Angle = triggerArgs.ImpactAngle or triggerArgs.Angle })
		end
	end
end

function UnloadAmmoThread( args )
	local victim = args.Victim
	local attacker = args.Attacker
	local locationX = args.LocationX
	local locationY = args.LocationY
	local angle = args.Angle
	local count = args.Count
	local spread = 0
	local spreadIncrement = 10
	local spreadMax = 30
	local interval = args.Interval or 0.05
	CurrentRun.CurrentRoom.LoadedAmmo = CurrentRun.CurrentRoom.LoadedAmmo - count
	for i = 1, count do
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "RangedWeapon", Method = "AddAmmo", Parameters = { 1 } })
		if HeroHasTrait("SelfLaserTrait") then
			LockRangedToPlayer()
		end
		local fireAngle = ( angle + RandomFloat(-spread, spread))* math.pi / 180
		
		if not locationX or not locationY then
			local location = {0,0}
			if victim ~= nil then
				location = GetLocation({ Id = victim.ObjectId })
			else
				location = GetLocation({ Id = attacker.ObjectId})
			end
			local offset = CalcOffset( fireAngle, GetTotalHeroTraitValue( "UnloadAmmoOffset" ))
			locationX = location.X + offset.X
			locationY = location.Y + offset.Y
		end
		if locationX and locationY then
			local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = locationX, LocationY = locationY })
			FireWeaponFromUnit({ Weapon = "RangedWeapon", AutoEquip = true, Id = attacker.ObjectId, DestinationId = dropLocation, FireFromTarget = true, Angle = fireAngle })
			Destroy({Id = dropLocation })
		end
		spread = math.min( spread + spreadIncrement, spreadMax )
		wait( interval, RoomThreadName )
	end
end

function SelfLoadAmmo()
	if not CurrentRun.CurrentRoom.LoadedAmmo or not HeroHasTrait( "ShieldLoadAmmoTrait" ) then
		return
	end

	PlaySound({ Name = "/Leftovers/SFX/HarpDash", Id = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.LoadingAmmoVoiceLines, true )

	if ScreenAnchors.AmmoIndicatorUI then
		local offsetX = 380
		local offsetY = -50
		ScreenAnchors.SelfStoredAmmo =  ScreenAnchors.SelfStoredAmmo or {}
		offsetX = offsetX + ( #ScreenAnchors.SelfStoredAmmo * 22 )
		local screenId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", DestinationId = ScreenAnchors.HealthBack, X = 10 + offsetX, Y = ScreenHeight - 50 + offsetY })
		SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = screenId })
		table.insert( ScreenAnchors.SelfStoredAmmo, screenId )
		SetAnimation({ Name = "SelfStoredAmmoIcon", DestinationId = screenId })
	end

	CurrentRun.CurrentRoom.LoadedAmmo = CurrentRun.CurrentRoom.LoadedAmmo + 1
	CurrentRun.Hero.StoredAmmo = CurrentRun.Hero.StoredAmmo or {}

	local storedAmmoData =
	{
		Count = 1,
		ForceMin = 300,
		ForceMax = 500,
		AttackerId = CurrentRun.Hero.ObjectId,
		WeaponName = "SelfLoadAmmoApplicator",
		Id = _worldTime
	}
	table.insert( CurrentRun.Hero.StoredAmmo, storedAmmoData )
	thread( UpdateAmmoUI )

	-- Changes to extents
	local parentTrait = nil
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if traitData.Name == "ShieldLoadAmmoTrait" then
			parentTrait = traitData
			break
		end
	end

	if parentTrait then
		local loadedRushScale = parentTrait.BaseLoadedRushScale
		local loadedRushRarityMultiplier = ( GetRarityValue(parentTrait.Rarity) * parentTrait.LoadedRushRarityMultiplier )
		SetProjectileProperty({ WeaponName = "ShieldWeaponRush", DestinationId = CurrentRun.Hero.ObjectId, Property = "Scale", Value =  1 + ( loadedRushScale - 1 ) * loadedRushRarityMultiplier })
		SetProjectileProperty({ WeaponName = "ShieldWeaponRush", DestinationId = CurrentRun.Hero.ObjectId, Property = "ExtentScale", Value = 1 + ( loadedRushScale - 1 ) * loadedRushRarityMultiplier })


		local parentAnimData = parentTrait.AnimDefinitions.Default
		for traitName, animData in pairs( parentTrait.AnimDefinitions ) do
			if traitName == "Default" or HeroHasTrait(traitName) then
				parentAnimData = animData
			end
		end
		if parentAnimData and parentAnimData.Loaded then
			for changeKey, changeValue in pairs( parentAnimData.Loaded ) do
				SetProjectileProperty({ WeaponName = "ShieldWeaponRush", DestinationId = CurrentRun.Hero.ObjectId, Property = changeKey, Value = changeValue })
			end
		end
	end

end

function TryRetaliateAmmo( enemy, triggerArgs )
	thread( UnloadAmmoThread, { Count = CurrentRun.CurrentRoom.LoadedAmmo, Victim = enemy, Attacker = CurrentRun.Hero, Angle = triggerArgs.ImpactAngle +180 })
end

function RemoveFistDetonateDash()
	SetWeaponProperty({ WeaponName = "RushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "FireGraphic", Value = "ZagreusDashNoCollide" })
end

function RemoveFistWeaveBuff()
	StopAnimation({ Name = "FistComboReadyFx", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "PowerUpComboReady", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "FistComboReadyGlow", DestinationId = CurrentRun.Hero.ObjectId })
	CheckComboPowerReset( CurrentRun.Hero, WeaponData.FistWeapon, { Undelivered = true } )
end

function BuildLastStandWrath( unit, weaponData, args )
	BuildSuperMeter( CurrentRun, args.Amount )
end

function EliteDeathAllyHitShields( triggerArgs )
	local victim = triggerArgs.TriggeredByTable
	if not victim or victim == CurrentRun.Hero or HeroData.DefaultHero.HeroAlliedUnits[victim.Name] then
		return
	end
	local count = 1
	victim.HitShields = victim.HitShields  or 0
	victim.HitShields = math.min(victim.HitShields + count, victim.MaxHitShields )
	if not victim.HasHealthBar then
		CreateHealthBar( victim )
	end
	UpdateHealthBar( victim, 0, { Force = true } )
end

function GetNearestEnemyArgs( args )
	-- Approximates autolock
	args = args or {}
	local range = args.Range or 600
	local count = args.Count or 4
	local arc = args.Arc or 90
	local nearestEnemyTargetIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = range, MaximumCount = count })
	local facingAngle = GetAngle({ Id = CurrentRun.Hero.ObjectId })
	local closestFacingTarget = nil
	local closestFacingTargetDistance = range * 2
	local closestTarget = nil
	local closestTargetDistance = range * 2
	for _, id in pairs( nearestEnemyTargetIds ) do
		local enemy = ActiveEnemies[id]
		if enemy ~= nil and not enemy.IsDead and not enemy.IgnoreAutoLock then
			local angleToTarget = GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = id })
			local distance = GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = id })
			if CalcArcDistance( facingAngle, angleToTarget ) <= arc then
				if closestFacingTarget == nil or distance < closestFacingTargetDistance then
					closestFacingTarget = id
					closestFacingTargetDistance = distance
				end
			elseif not args.RequireFacing then
				if closestTarget == nil or distance < closestTargetDistance then
					closestTarget = id
					closestTargetDistance = distance
				end
			end
		end
	end
	return closestFacingTarget or closestTarget or 0
end

function CheckTeleportToNearbyEnemy( weaponData, args )
	args = args or {}
	local targetId = GetNearestEnemyArgs({ Arc = args.AutoLockArc, Range = args.Range })
	if targetId ~= 0 and ActiveEnemies[targetId] ~= nil and not ActiveEnemies[targetId].IsDead then
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, CompleteAngle = true })
		FireWeaponFromUnit({ Weapon = "FistSpecialMiniDash", Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, PreferMouseOver = true })
	end
end

function CheckSpearTeleport()
	if MapState.BufferSpearRush then
		FireWeaponFromUnit({ Weapon = "SpearRushWeapon", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		MapState.BufferSpearRush = false
	end
end

function SetSpearTeleportBuffer()
	if ProjectileExists({ Names = { "SpearWeaponThrow" }}) then
		MapState.BufferSpearRush = true
	end
end
function CheckSpearTeleportBuffer()
	MapState.BufferSpearRush = false
end

function CheckGrappleToNearbyEnemy( weaponData, args )
	args = args or {}
	local nearestEnemyTargetIds = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = args.ThrowRange, MaximumCount = 2 })
	local nearestEnemyId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = args.Range })
	if TableLength( nearestEnemyTargetIds ) == 2 then
		local otherEnemyId = nearestEnemyTargetIds[1]
		if otherEnemyId == nearestEnemyId then
			otherEnemyId = nearestEnemyTargetIds[2]
		end
		if IsAlive({ Id = otherEnemyId }) and IsAlive({ Id = nearestEnemyId }) then
			AngleTowardTarget({ Id = nearestEnemyId, DestinationId = otherEnemyId, CompleteAngle = true })
			local force =  GetRequiredForceToEnemy( nearestEnemyId, otherEnemyId, args.OverThrowDistance )
			if force < args.MinForce then
				force = args.MinForce
			end
			ApplyForce({ Id = nearestEnemyId, Speed = force, Angle = GetAngleBetween( { Id = nearestEnemyId, DestinationId = otherEnemyId }) })
		end
	elseif nearestEnemyId ~= 0 and IsAlive({ Id = nearestEnemyId }) then
		ApplyForce({ Id = nearestEnemyId, Speed = args.MinForce, Angle = GetAngleBetween( { Id = CurrentRun.Hero.ObjectId, DestinationId = nearestEnemyId }) })
	end
end

function CheckFistDetonation( victim, functionArgs, triggerArgs )
	if ( not victim.ActiveEffects or not victim.ActiveEffects.MarkRuptureTarget ) and triggerArgs.SourceWeapon == "FistWeaponSpecialDash" then
		local delay = 0.1
		MapState.QueuedDetonations = MapState.QueuedDetonations  or {}
		while MapState.QueuedDetonations[_worldTime + delay ] and delay < 2 do
			delay = delay + 0.1
		end
		local key = _worldTime + delay
		MapState.QueuedDetonations[_worldTime + delay] = victim
		wait( delay, RoomThreadName )
		FireWeaponFromUnit({ Weapon = "FistDetonationWeapon", Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, FireFromTarget = true, AutoEquip = true })
		MapState.QueuedDetonations[key] = nil
		victim.LastRuptureTime = _worldTime
	end
end

function FistVacuumRush( args )
	CurrentRun.Hero.VacuumRush = true
	wait( args.Duration, RoomThreadName )
	CurrentRun.Hero.VacuumRush = false
end

function CheckVacuumNearbyEnemy( weaponData, args )
	local targetId = GetNearestEnemyArgs({ Arc = args.AutoLockArc, Range = args.Range, RequireFacing = true })
	if targetId ~= 0 and ActiveEnemies[targetId] ~= nil and not ActiveEnemies[targetId].IsDead then
		local distanceBuffer = args.DistanceBuffer
		if CurrentRun.Hero.VacuumRush then
			distanceBuffer = args.RushDistanceBuffer
		end
		ApplyForce({ Id = targetId, Speed = GetRequiredForceToEnemy( targetId, CurrentRun.Hero.ObjectId, -1 * distanceBuffer ), Angle = GetAngleBetween({ Id = targetId, DestinationId = CurrentRun.Hero.ObjectId }) })
		FireWeaponFromUnit({ Weapon = "FistSpecialVacuum", Id = CurrentRun.Hero.ObjectId, DestinationId = targetId })
		FistVacuumPullPresentation( targetId, args )
	end
end

function LockRangedToPlayer( args )
	if HeroHasTrait( "DemeterRangedTrait" ) then
		SetWeaponProperty({ WeaponName = "RangedWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "OverrideFireRequestTarget", Value = CurrentRun.Hero.ObjectId, DataValue = false})
	end
end

function GetRequiredForceToEnemy( nearById, id, distanceScalar )
	distanceScalar = distanceScalar or 0
	local distance = GetDistance({ Id = nearById, DestinationId = id }) + distanceScalar
	local force = RunPhysicsMethod({ Id = nearById, Method = "GetRequiredForce", Parameters = { distance } })
	return force
end

function GetTotalGodEnhancement()
	local perGodMultiplier = GetTotalStatChange( MetaUpgradeData.GodEnhancementMetaUpgrade )
	local godDictionary = {}
	for traitName in pairs( CurrentRun.Hero.TraitDictionary ) do
		if GetLootSourceName( traitName ) then
			godDictionary[GetLootSourceName( traitName )] = true
		end
	end
	return  perGodMultiplier * TableLength( godDictionary )
end

function GunBombDetonate( bomb )
	FireWeaponFromUnit({ Weapon = "GunBombWeapon", Id = CurrentRun.Hero.ObjectId, DestinationId = bomb.ObjectId, FireFromTarget = true })
	thread(MarkObjectiveComplete, "GunGrenadeLuciferBlast")
end

function SetUpGunBombImmolation( enemy, currentRun, args )
	local hasGodGraphic = false
	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if traitData.Slot == "Secondary" then
			hasGodGraphic = true
			break
		end
	end
	if not hasGodGraphic then
		SetAnimation({ Name = "LuciferBomb", DestinationId = enemy.ObjectId })
	end
	CurrentRun.Hero.WeaponSpawns = CurrentRun.Hero.WeaponSpawns or {}
	CurrentRun.Hero.WeaponSpawns[enemy.ObjectId] = enemy

	while not enemy.IsDead do
		FireWeaponFromUnit({ Weapon = "GunBombImmolation", Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, FireFromTarget = true })
		if EnemyData[enemy.Name] and EnemyData[enemy.Name].ImmolationInterval then
			wait( EnemyData[enemy.Name].ImmolationInterval, RoomThreadName )
		else
			wait( 0.5, RoomThreadName )
		end
	end
end

function SetUpSpearImmolation( unit, args )
	thread( SpearImmolationThread, unit, args )
end

function SpearImmolationThread( unit, args )
	while CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead do
		wait( args.Interval, RoomThreadName)
		if CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead and IsCombatEncounterActive( CurrentRun ) then
			local spearPoints = GetIdsByType({ Names = {"SpearReturnPoint", "SpearReturnPointAlt01", "SpearReturnPointAlt02"} })
			if not IsEmpty(spearPoints) then
				FireWeaponFromUnit({ Weapon = "SpearThrowImmolation", Id = CurrentRun.Hero.ObjectId, DestinationId = spearPoints[1], FireFromTarget = true })
			end
		end
	end
end

function CheckRecallTeleportToNearbyEnemy( weaponData, args )
	args = args or {}
	local targetId = GetNearestEnemyArgs({ Arc = args.AutoLockArc, Range = args.Range })
	if targetId ~= 0 and ActiveEnemies[targetId] ~= nil and not ActiveEnemies[targetId].IsDead then
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, CompleteAngle = true })
		FireWeaponFromUnit({ Weapon = "SwordSpecialMiniDash", Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, PreferMouseOver = true })
	else

		local offset = CalcOffset( math.rad( GetAngle({ Id = CurrentRun.Hero.ObjectId }) ), args.NoTargetRange )
		local tempObstacle = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
		FireWeaponFromUnit({ Weapon = "SwordSpecialMiniDash", Id = CurrentRun.Hero.ObjectId, DestinationId = tempObstacle })
		thread( DestroyOnDelay, { tempObstacle }, 0.05 )
	end
	SetWeaponProperty({ WeaponName = "RushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	local delay = 0.19
	if SetThreadWait( "RushWeaponDisable", delay ) then
		return
	end
	wait( delay, "RushWeaponDisable" )
	SetWeaponProperty({ WeaponName = "RushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
end

function SetUpNoLastStandRegeneration( unit, args )
	thread( NoLastStandRegeneration, unit, args )
end

function NoLastStandRegeneration( unit, args )
	while CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead do
		wait( args.Interval, RoomThreadName)
		if CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead and IsCombatEncounterActive( CurrentRun ) and not HasLastStand( CurrentRun.Hero ) and CurrentRun.Hero.Health < CurrentRun.Hero.MaxHealth then
			Heal( CurrentRun.Hero, { HealAmount = args.Amount, SourceName = "NoLastStandRegenerationTrait", Silent = true })
			thread( UpdateHealthUI )
			CreateAnimation({ Name = "HealthSparkleShower", DestinationId = CurrentRun.Hero.ObjectId, Group = "Overlay" })
		end
	end
end

function SetUpSuperRegeneration( unit, args )

	if args.CapAnimation then
		SetAnimation({ Name = args.CapAnimation, DestinationId = ScreenAnchors.SuperMeterCap })
	end
	thread( SuperRegeneration, unit, args )
end

function SuperRegeneration( unit, args )

	while CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead do
		wait( args.Interval, RoomThreadName)
		if CurrentRun and CurrentRun.Hero and not CurrentRun.Hero.IsDead and IsCombatEncounterActive( CurrentRun ) then
			BuildSuperMeter( CurrentRun, args.Amount )
			thread( UpdateHealthUI )
		end
	end
end

function AddEffectImmunities( unit, args )
	AddEffectImmunity({ Id = CurrentRun.Hero.ObjectId, Names = args.EffectNames })
end

function OnRuptureDashHit( args )
	local victim = args.TriggeredByTable
	if victim.TriggersOnDamageEffects and victim ~= CurrentRun.Hero then
		if not victim.ActiveEffects or not victim.ActiveEffects.MarkRuptureTarget  then
			ApplyEffectFromWeapon({ WeaponName = "MarkRuptureApplicator", EffectName = "MarkRuptureTarget", Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId })
		end
	end
end

function OnRuptureWeaponHit( args )
	local victim = args.TriggeredByTable
	if victim.TriggersOnDamageEffects and victim ~= CurrentRun.Hero then
		if victim.ActiveEffects and victim.ActiveEffects.MarkRuptureTarget  then
			ApplyEffectFromWeapon({ WeaponName = "MarkRuptureApplicator", EffectName = "MarkRuptureTarget", Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId })
		end
	end
end

function SetupHadesShout( unit, args )
	if HeroHasTrait(args.TraitName) then
		return
	end
	AddTraitToHero({ TraitName = args.TraitName, Rarity = GetRarityKey(GetKeepsakeLevel(args.KeepsakeTraitName))})
end
