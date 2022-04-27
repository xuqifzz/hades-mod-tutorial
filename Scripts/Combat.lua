  OnProjectileReflect{
	function( triggerArgs )
		if CheckCooldown("ParryAttackPresentation", 0.25) then
			thread( ParryAttackPresentation, triggerArgs.triggeredById )
		end

		local reflectRumble =
		{
			{ ScreenPreWait = 0, Fraction = 0.25, Duration = 0.2 },
		}
		thread( DoRumble, reflectRumble )

		for i, weaponNames in pairs(GetHeroTraitValues("OnProjectileReflectWeapons")) do
			for s, weaponName in pairs(weaponNames) do
				local targetId = triggerArgs.AttackerId or CurrentRun.Hero.ObjectId
				FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, AutoEquip = true })
			end
		end

	end
}

OnProjectileBlock{
	function( triggerArgs )
		local weaponName = triggerArgs.WeaponName
		local unitName = triggerArgs.name
		if unitName ~= nil and EnemyData[unitName] then
			if weaponName == nil or WeaponData[weaponName] == nil or not WeaponData[weaponName].SkipBlockPresentation then
				if EnemyData[unitName].ProjectileBlockPresentationFunctionName then
					local blockFunction = _G[EnemyData[unitName].ProjectileBlockPresentationFunctionName]
					if blockFunction ~= nil then
						blockFunction( triggerArgs.triggeredById, triggerArgs.TriggeredByTable )
					end
				end

				if EnemyData[unitName] and EnemyData[unitName].ProjectileBlockSoundName then
					PlaySound({ Name = EnemyData[unitName].ProjectileBlockSoundName, Id = unitId })
				end
			end
		end

		if weaponName ~= nil and WeaponData[weaponName] ~= nil and WeaponData[weaponName].DoProjectileBlockPresentation then
			if CheckCooldown("BlockAttackPresentation", 0.25) then
				thread( BlockAttackPresentation, triggerArgs.triggeredById )
			end

			local blockRumble =
			{
				{ ScreenPreWait = 0, Fraction = 0.1, Duration = 0.2 },
			}
			thread( DoRumble, blockRumble )
		end

		if triggerArgs.triggeredById == CurrentRun.Hero.ObjectId then
			for i, functionName in pairs(GetHeroTraitValues("OnBlockDamageFunctionName")) do
				if _G[functionName] then
					_G[functionName]( weaponName )
				end
			end
		end
	end
}

OnDodge{ "_PlayerUnit",
	function( triggerArgs )
		PlayerDodgePresentation()
	end
}

OnWeaponFired{ "RangedWeapon",
	function( triggerArgs )
		if IsMetaUpgradeActive("ReloadAmmoMetaUpgrade") then
			local delay = GetBaseAmmoReloadTime()
			local ammoDivisor = GetTotalHeroTraitValue( "AmmoReloadTimeDivisor" )
			if ammoDivisor == 0 then
				ammoDivisor = 1
			end
			delay = delay / ammoDivisor
			thread( ReloadRangedAmmo, delay )
			StartAmmoReloadPresentation( delay )
		end

		if triggerArgs.Ammo == 0 then
			RangedLastAmmoPresentation()
		end
		thread( UpdateAmmoUI, triggerArgs )
	end
}

OnWeaponFired{ "GunWeapon GunWeaponDash SniperGunWeapon SniperGunWeaponDash",
	function( triggerArgs )
		thread( UpdateGunUI, triggerArgs )

		if triggerArgs.Ammo == 0 then
			for i, trait in pairs( CurrentRun.Hero.Traits ) do
				if trait.FireWeaponOnZeroGunAmmo then
					FireWeaponFromUnit({ Weapon = trait.FireWeaponOnZeroGunAmmo, Id = CurrentRun.Hero.ObjectId, DestinationId =  CurrentRun.Hero.ObjectId })
				end
				if trait.AddOutgoingDamageModifiers and trait.AddOutgoingDamageModifiers.FinalShotMultiplier then
					CurrentRun.CurrentRoom.ZeroAmmoVolley = CurrentRun.CurrentRoom.ZeroAmmoVolley or {}
					CurrentRun.CurrentRoom.ZeroAmmoVolley[ triggerArgs.Volley ] = true
				end
			end
		end

		if triggerArgs.name == "SniperGunWeapon" then
			SwapWeapon({ Name = triggerArgs.name, SwapWeaponName = "GunWeapon", StompOriginalWeapon = true, DestinationId = CurrentRun.Hero.ObjectId, RequireCurrentControl = true })
		elseif triggerArgs.name == "SniperGunWeaponDash" then
			SwapWeapon({ Name = triggerArgs.name, SwapWeaponName = "GunWeapon", StompOriginalWeapon = true, DestinationId = CurrentRun.Hero.ObjectId, RequireCurrentControl = true })
		end
	end
}

OnControlPressed{ "Reload",
	function( triggerArgs )
		ManualReload( CurrentRun.Hero )
	end
}

OnWeaponTriggerRelease{
	function( triggerArgs )

		local weaponData = GetWeaponData( attacker, triggerArgs.name)
		if weaponData == nil then
			return
		end

		local attacker = triggerArgs.OwnerTable
		StopWeaponSounds( "TriggerRelease", weaponData.Sounds, attacker )

		if triggerArgs.Ammo == 0 then
			local weaponData = GetWeaponData( attacker, triggerArgs.name)
			if weaponData ~= nil and weaponData.ActiveReloadTime ~= nil and not attacker.Reloading then
				local delay = weaponData.ReloadDelay
				if HeroHasTrait( "GunShotgunTrait" ) then -- @refactor Move to WeaponDataOverrides but doesn't work because it replaces instead of merges
					delay = delay + 0.15
				end
				wait( delay, "ReloadThread" )
				ReloadGun( attacker, weaponData )
			end
		end

	end
}

function ManualReload( attacker )

	if not IsInputAllowed({}) then
		return
	end

	if attacker.ActiveEffects then
		for effectName in pairs(attacker.ActiveEffects) do
			if EffectData[effectName] and EffectData[effectName].BlockReload then
				return
			end
		end
	end

	if CurrentDeathAreaRoom == nil and CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.DisableWeaponsExceptDash then
		return
	end

	for weaponName, v in pairs( attacker.Weapons ) do
		local weaponData = GetWeaponData( attacker, weaponName)
		if weaponData ~= nil and weaponData.ActiveReloadTime ~= nil then
			if attacker.Reloading then
				ReloadFailedMidReloadPresentation( attacker, weaponData )
				return
			end
			if RunWeaponMethod({ Id = attacker.ObjectId, Weapon = weaponData.Name, Method = "IsAmmoFull" }) and not HeroHasTrait("GunManualReloadTrait") then
				ReloadFailedAmmoFullPresentation( attacker, weaponData )
				return
			end

			thread( MarkObjectiveComplete, "GunWeaponManualReload" )
			ReloadGun( attacker, weaponData )

			if HeroHasTrait("GunManualReloadTrait") then
				thread( MarkObjectiveComplete, "ManualReload" )
				ApplyEffectFromWeapon({ Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId, WeaponName = "ManualReloadEffectApplicator", EffectName = "ManualReloadBonus" })
			end
			return
		end
	end
end

function ReloadGun( attacker, weaponData )
	if attacker.HandlingDeath or attacker.Reloading or attacker.SurgeActive then
		return false
	end

	attacker.Reloading = true
	local prevCooldownAnim = GetWeaponDataValue({ Id = attacker.ObjectId, WeaponName = "GunWeapon", Property = "FailedToFireCooldownAnimation" })
	if prevCooldownAnim ~= nil then
		SetWeaponProperty({ WeaponName = "GunWeapon", DestinationId = attacker.ObjectId, Property = "FailedToFireCooldownAnimation", Value = "null" })
	end
	SetWeaponProperty({ WeaponName = "GunWeapon", DestinationId = attacker.ObjectId, Property = "Enabled", Value = false })
	SetWeaponProperty({ WeaponName = "GunWeaponDash", DestinationId = attacker.ObjectId, Property = "Enabled", Value = false })
	SetWeaponProperty({ WeaponName = "SniperGunWeapon", DestinationId = attacker.ObjectId, Property = "Enabled", Value = false })
	SetWeaponProperty({ WeaponName = "SniperGunWeaponDash", DestinationId = attacker.ObjectId, Property = "Enabled", Value = false })

	RunWeaponMethod({ Id = attacker.ObjectId, Weapon = weaponData.Name, Method = "EmptyAmmo" })
	thread( UpdateGunUI )
	local presentationState = {}
	ReloadPresentationStart( attacker, weaponData, presentationState )
	wait( weaponData.ActiveReloadTime, RoomThreadName)
	if attacker.HandlingDeath then
		return false
	end
	ReloadPresentationComplete( attacker, weaponData, presentationState )
	if prevCooldownAnim ~= nil then
		SetWeaponProperty({ WeaponName = "GunWeapon", DestinationId = attacker.ObjectId, Property = "FailedToFireCooldownAnimation", Value = prevCooldownAnim })
	end
	RunWeaponMethod({ Id = attacker.ObjectId, Weapon = weaponData.Name, Method = "RefillAmmo" })
	SetWeaponProperty({ WeaponName = "GunWeapon", DestinationId = attacker.ObjectId, Property = "Enabled", Value = true })
	SetWeaponProperty({ WeaponName = "GunWeaponDash", DestinationId = attacker.ObjectId, Property = "Enabled", Value = true })
	SetWeaponProperty({ WeaponName = "SniperGunWeapon", DestinationId = attacker.ObjectId, Property = "Enabled", Value = true })
	SetWeaponProperty({ WeaponName = "SniperGunWeaponDash", DestinationId = attacker.ObjectId, Property = "Enabled", Value = true })
	thread( UpdateGunUI )
	attacker.Reloading = false
	return true
end

function Heal( victim, triggerArgs )

	if victim == nil or victim.Health == nil or victim.Health == victim.MaxHealth then
		return
	end

	local prevHealth = victim.Health

	if triggerArgs.HealFraction ~= nil then
		triggerArgs.HealAmount = round(victim.MaxHealth * triggerArgs.HealFraction)
	end
	if triggerArgs.HealAmount <= 0 then
		return
	end

	if triggerArgs.HealAmount ~= nil then

		victim.Health = victim.Health + triggerArgs.HealAmount
		if victim.Health > victim.MaxHealth then
			victim.Health = victim.MaxHealth
		end
	end

	triggerArgs.ActualHealAmount = victim.Health - prevHealth

	local sourceName = triggerArgs.AttackerName or "Unknown"

	if victim == CurrentRun.Hero then
		if not HealthRecord then
			HealthRecord = {}
		end
		HealthRecord[sourceName] = (HealthRecord[sourceName] or 0) + triggerArgs.ActualHealAmount
		CurrentRun.HealthRecord[sourceName] = (CurrentRun.HealthRecord[sourceName] or 0) + triggerArgs.HealAmount
		CurrentRun.ActualHealthRecord[sourceName] = (CurrentRun.ActualHealthRecord[sourceName] or 0) + triggerArgs.ActualHealAmount

		if HealthUI.ShowHealingText and not triggerArgs.Silent and not CurrentRun.CurrentRoom.HideEncounterText then
			OnPlayerHealed( triggerArgs )
			thread( UpdateHealthUI, triggerArgs )
		end

		for i, traitData in pairs( CurrentRun.Hero.Traits ) do
			local thresholdData = traitData.LowHealthThresholdText
			if thresholdData ~= nil and CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth > thresholdData.Threshold and (CurrentRun.Hero.Health - triggerArgs.ActualHealAmount ) / ( CurrentRun.Hero.MaxHealth) <= thresholdData.Threshold then
				TraitUIDeactivateTrait( traitData )
			end
		end
	else
		UpdateHealthBar( victim, -1 * triggerArgs.ActualHealAmount, triggerArgs )
		if triggerArgs.ActualHealAmount > 0 and not triggerArgs.Silent then
			DisplayEnemyHealingText( triggerArgs )
		end
	end

end

function AddIncomingDamageModifier( unit, data )
	if unit == nil then
		return
	end
	if unit.IncomingDamageModifiers == nil then
		unit.IncomingDamageModifiers = {}
	end
	if data.ValidWeapons and not data.ValidWeaponsLookup then
		data.ValidWeaponsLookup = ToLookup( data.ValidWeapons )
	end
	table.insert( unit.IncomingDamageModifiers, data )
end

function AddOutgoingLifestealModifier( unit, data )
	if unit == nil then
		return
	end
	if unit.OutgoingLifestealModifiers == nil then
		unit.OutgoingLifestealModifiers = {}
	end

	table.insert( unit.OutgoingLifestealModifiers, data )
end

function RecordSpeedModifier( modifier, duration )
	if CurrentRun.Hero.IsDead or not duration then
		return
	end
	CurrentRun.CurrentRoom.SpeedModifier = CurrentRun.CurrentRoom.SpeedModifier or 1
	if CurrentRun.CurrentRoom.SpeedModifier < modifier then
		CurrentRun.CurrentRoom.SpeedModifier = modifier
	end
	
	duration = duration + CurrentRun.Hero.DashManeuverTimeThreshold 
	if SetThreadWait( "SpeedModifierFalloff", duration ) then
		return
	end

	wait( duration, "SpeedModifierFalloff" )
	if CurrentRun.CurrentRoom and not CurrentRun.Hero.IsDead then
		CurrentRun.CurrentRoom.SpeedModifier = 1
	end
end

function AddOutgoingDamageModifier( unit, data )
	if unit == nil then
		return
	end
	if unit.OutgoingDamageModifiers == nil then
		unit.OutgoingDamageModifiers = {}
	end
	
	if data.ValidWeapons and not data.ValidWeaponsLookup then
		data.ValidWeaponsLookup = ToLookup( data.ValidWeapons )
	end

	table.insert( unit.OutgoingDamageModifiers, data )
end

function RemoveIncomingDamageModifier( unit, name )
	for i, data in pairs( unit.IncomingDamageModifiers ) do
		if data.Name == name then
			unit.IncomingDamageModifiers[i] = nil
			break
		end
	end
	unit.IncomingDamageModifiers = CollapseTable( unit.IncomingDamageModifiers )
end

function HasIncomingDamageModifier( unit, name )
	if unit == nil or unit.IncomingDamageModifiers == nil then
		return false
	end
	for i, data in pairs(unit.IncomingDamageModifiers) do
		if data.Name and data.Name == name then
			return true
		end
	end
	return false
end

function HasOutgoingDamageModifier( unit, name )
	if unit == nil or unit.OutgoingDamageModifiers == nil then
		return false
	end
	for i, data in pairs(unit.OutgoingDamageModifiers) do
		if data.Name and data.Name == name then
			return true
		end
	end
	return false
end

function CalculateDamageAdditions( attacker, victim, triggerArgs )
	local damageAddition = 0
	if attacker ~= nil and attacker.OutgoingDamageModifiers ~= nil then
		for i, modifierData in pairs(attacker.OutgoingDamageModifiers) do

			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )

			if validWeapon then
				if modifierData.TriggerEffectAddition ~= nil and triggerArgs.EffectName ~= nil and triggerArgs.EffectName == modifierData.TriggerEffectName and triggerArgs.EffectIsTriggered then
					damageAddition = damageAddition + modifierData.TriggerEffectAddition
				end
				if modifierData.GoldMultiplier and CurrentRun.Money then
					damageAddition = damageAddition + ( CurrentRun.Money * modifierData.GoldMultiplier )
				end
			end
		end
	end
	return damageAddition
end

function CalculateDamageMultipliers( attacker, victim, weaponData, triggerArgs )
	local damageReductionMultipliers = 1
	local damageMultipliers = 1.0
	local lastAddedMultiplierName = ""

	if ConfigOptionCache.LogCombatMultipliers then
		DebugPrint({Text = " SourceWeapon : " .. tostring( triggerArgs.SourceWeapon )})
	end

	local addDamageMultiplier = function( data, multiplier )
		if multiplier >= 1.0 then
			if data.Multiplicative then
				damageReductionMultipliers = damageReductionMultipliers * multiplier
			else
				damageMultipliers = damageMultipliers + multiplier - 1
			end
			if ConfigOptionCache.LogCombatMultipliers then
				lastAddedMultiplierName = data.Name or "Unknown"
				DebugPrint({Text = " Additive Damage Multiplier (" .. lastAddedMultiplierName .. "):" .. multiplier })
			end
		else
			if data.Additive then
				damageMultipliers = damageMultipliers + multiplier - 1
			else
				damageReductionMultipliers = damageReductionMultipliers * multiplier
			end
			if ConfigOptionCache.LogCombatMultipliers then
				lastAddedMultiplierName = data.Name or "Unknown"
				DebugPrint({Text = " Multiplicative Damage Reduction (" .. lastAddedMultiplierName .. "):" .. multiplier })
			end
		end
	end

	if triggerArgs.ProjectileAdditiveDamageMultiplier then
		damageMultipliers = damageMultipliers + triggerArgs.ProjectileAdditiveDamageMultiplier
	end

	if victim.IncomingDamageModifiers ~= nil then
		for i, modifierData in pairs(victim.IncomingDamageModifiers) do
			if modifierData.GlobalMultiplier ~= nil then
				addDamageMultiplier( modifierData, modifierData.GlobalMultiplier)
			end
			
			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )

			if validWeapon and ( not triggerArgs.AttackerIsObstacle and ( attacker and attacker.DamageType ~= "Neutral" ) or modifierData.IncludeObstacleDamage or modifierData.TrapDamageTakenMultiplier ) then
				if modifierData.ZeroRangedWeaponAmmoMultiplier and RunWeaponMethod({ Id = victim.ObjectId, Weapon = "RangedWeapon", Method = "GetAmmo" }) == 0 then
					addDamageMultiplier( modifierData, modifierData.ZeroRangedWeaponAmmoMultiplier)
				end
				if modifierData.ValidWeaponMultiplier then
					addDamageMultiplier( modifierData, modifierData.ValidWeaponMultiplier)
				end
				if modifierData.ProjectileDeflectedMultiplier and triggerArgs.ProjectileDeflected then
					addDamageMultiplier( modifierData, modifierData.ProjectileDeflectedMultiplier)
				end

				if modifierData.BossDamageMultiplier and attacker and ( attacker.IsBoss or attacker.IsBossDamage ) then
					addDamageMultiplier( modifierData, modifierData.BossDamageMultiplier)
				end
				if modifierData.LowHealthDamageTakenMultiplier ~= nil and (victim.Health / victim.MaxHealth) <= modifierData.LowHealthThreshold then
					addDamageMultiplier( modifierData, modifierData.LowHealthDamageTakenMultiplier)
				end
				if modifierData.TrapDamageTakenMultiplier ~= nil and (( attacker ~= nil and attacker.DamageType == "Neutral" ) or (attacker == nil and triggerArgs.AttackerName ~= nil and EnemyData[triggerArgs.AttackerName] ~= nil and EnemyData[triggerArgs.AttackerName].DamageType == "Neutral" )) then
					addDamageMultiplier( modifierData, modifierData.TrapDamageTakenMultiplier)
				end
				if modifierData.DistanceMultiplier and triggerArgs.DistanceSquared ~= nil and triggerArgs.DistanceSquared ~= -1 and ( modifierData.DistanceThreshold * modifierData.DistanceThreshold ) <= triggerArgs.DistanceSquared then
					addDamageMultiplier( modifierData, modifierData.DistanceMultiplier)
				end
				if modifierData.ProximityMultiplier and triggerArgs.DistanceSquared ~= nil and triggerArgs.DistanceSquared ~= -1 and ( modifierData.ProximityThreshold * modifierData.ProximityThreshold ) >= triggerArgs.DistanceSquared then
					addDamageMultiplier( modifierData, modifierData.ProximityMultiplier)
				end
				if modifierData.NonTrapDamageTakenMultiplier ~= nil and (( attacker ~= nil and attacker.DamageType ~= "Neutral" ) or (attacker == nil and triggerArgs.AttackerName ~= nil and EnemyData[triggerArgs.AttackerName] ~= nil and EnemyData[triggerArgs.AttackerName].DamageType ~= "Neutral" )) then
					addDamageMultiplier( modifierData, modifierData.NonTrapDamageTakenMultiplier)
				end
				if modifierData.HitVulnerabilityMultiplier and triggerArgs.HitVulnerability then
					addDamageMultiplier( modifierData, modifierData.HitVulnerabilityMultiplier )
				end
				if modifierData.HitArmorMultiplier and triggerArgs.HitArmor then
					addDamageMultiplier( modifierData, modifierData.HitArmorMultiplier )
				end
				if modifierData.NonPlayerMultiplier and attacker ~= CurrentRun.Hero and attacker ~= nil and not HeroData.DefaultHero.HeroAlliedUnits[attacker.Name] then
					addDamageMultiplier( modifierData, modifierData.NonPlayerMultiplier)
				end
				if modifierData.SelfMultiplier and attacker == victim then
					addDamageMultiplier( modifierData, modifierData.SelfMultiplier)
				end
				if modifierData.PlayerMultiplier and attacker == CurrentRun.Hero then
					addDamageMultiplier( modifierData, modifierData.PlayerMultiplier )
				end
			end
		end
	end

	if attacker ~= nil and attacker.OutgoingDamageModifiers ~= nil and ( not weaponData or not weaponData.IgnoreOutgoingDamageModifiers ) then
		local appliedEffectTable = {}
		for i, modifierData in pairs(attacker.OutgoingDamageModifiers) do
			if modifierData.GlobalMultiplier ~= nil then
				addDamageMultiplier( modifierData, modifierData.GlobalMultiplier)
			end

			local validEffect = modifierData.ValidEffects == nil or ( triggerArgs.EffectName ~= nil and Contains(modifierData.ValidEffects, triggerArgs.EffectName ))
			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )
			local validTrait = modifierData.RequiredTrait == nil or ( attacker == CurrentRun.Hero and HeroHasTrait( modifierData.RequiredTrait ) )
			local validUniqueness = modifierData.Unique == nil or not modifierData.Name or not appliedEffectTable[modifierData.Name]
			local validEnchantment = true
			if modifierData.ValidEnchantments and attacker == CurrentRun.Hero then
				validEnchantment = false
				if modifierData.ValidEnchantments.TraitDependentWeapons then
					for traitName, validWeapons in pairs( modifierData.ValidEnchantments.TraitDependentWeapons ) do
						if Contains( validWeapons, triggerArgs.SourceWeapon) and HeroHasTrait( traitName ) then
							validEnchantment = true
							break
						end
					end
				end

				if not validEnchantment and modifierData.ValidEnchantments.ValidWeapons and Contains( modifierData.ValidEnchantments.ValidWeapons, triggerArgs.SourceWeapon ) then
					validEnchantment = true
				end
			end

			if validUniqueness and validWeapon and validEffect and validTrait and validEnchantment then
				if modifierData.Name then
					appliedEffectTable[ modifierData.Name] = true
				end
				if modifierData.HighHealthSourceMultiplierData and attacker.Health / attacker.MaxHealth > modifierData.HighHealthSourceMultiplierData.Threshold then
					addDamageMultiplier( modifierData, modifierData.HighHealthSourceMultiplierData.Multiplier )
				end
				if modifierData.PerUniqueGodMultiplier and attacker == CurrentRun.Hero then
					addDamageMultiplier( modifierData, 1 + ( modifierData.PerUniqueGodMultiplier - 1 ) * GetHeroUniqueGodCount( attacker ))
				end
				if modifierData.BossDamageMultiplier and victim.IsBoss then
					addDamageMultiplier( modifierData, modifierData.BossDamageMultiplier)
				end
				if modifierData.ZeroRangedWeaponAmmoMultiplier and RunWeaponMethod({ Id = attacker.ObjectId, Weapon = "RangedWeapon", Method = "GetAmmo" }) == 0 then
					addDamageMultiplier( modifierData, modifierData.ZeroRangedWeaponAmmoMultiplier)
				end
				if modifierData.EffectThresholdDamageMultiplier and triggerArgs.MeetsEffectDamageMultiplier then
					addDamageMultiplier( modifierData, modifierData.EffectThresholdDamageMultiplier)
				end
				if modifierData.PerfectChargeMultiplier and triggerArgs.IsPerfectCharge then
					addDamageMultiplier( modifierData, modifierData.PerfectChargeMultiplier)
				end

				if modifierData.UseTraitValue and attacker == CurrentRun.Hero then
					addDamageMultiplier( modifierData, GetTotalHeroTraitValue( modifierData.UseTraitValue, { IsMultiplier = modifierData.IsMultiplier }))
				end
				if modifierData.HitVulnerabilityMultiplier and triggerArgs.HitVulnerability then
					addDamageMultiplier( modifierData, modifierData.HitVulnerabilityMultiplier )
				end
				if modifierData.HitMaxHealthMultiplier and victim.Health == victim.MaxHealth and (victim.MaxHealthBuffer == nil or victim.HealthBuffer == victim.MaxHealthBuffer ) then
					addDamageMultiplier( modifierData, modifierData.HitMaxHealthMultiplier )
				end
				if modifierData.MinRequiredVulnerabilityEffects and victim.VulnerabilityEffects and TableLength( victim.VulnerabilityEffects ) >= modifierData.MinRequiredVulnerabilityEffects then
					--DebugPrint({Text = " min required vulnerability " .. modifierData.PerVulnerabilityEffectAboveMinMultiplier})
					addDamageMultiplier( modifierData, modifierData.PerVulnerabilityEffectAboveMinMultiplier)
				end
				if modifierData.HealthBufferDamageMultiplier and victim.HealthBuffer ~= nil and victim.HealthBuffer > 0 then
					addDamageMultiplier( modifierData, modifierData.HealthBufferDamageMultiplier)
				end
				if modifierData.StoredAmmoMultiplier and victim.StoredAmmo ~= nil and not IsEmpty( victim.StoredAmmo ) then
					local hasExternalStoredAmmo = false
					for i, storedAmmo in pairs(victim.StoredAmmo) do
						if storedAmmo.WeaponName ~= "SelfLoadAmmoApplicator" then
							hasExternalStoredAmmo = true
						end
					end
					if hasExternalStoredAmmo then
						addDamageMultiplier( modifierData, modifierData.StoredAmmoMultiplier)
					end
				end
				if modifierData.UnstoredAmmoMultiplier and IsEmpty( victim.StoredAmmo ) then
					addDamageMultiplier( modifierData, modifierData.UnstoredAmmoMultiplier)
				end
				if modifierData.ValidWeaponMultiplier then
					addDamageMultiplier( modifierData, modifierData.ValidWeaponMultiplier)
				end
				if modifierData.RequiredSelfEffectsMultiplier and not IsEmpty(attacker.ActiveEffects) then
					local hasAllEffects = true
					for _, effectName in pairs( modifierData.RequiredEffects ) do
						if not attacker.ActiveEffects[ effectName ] then
							hasAllEffects = false
						end
					end
					if hasAllEffects then
						addDamageMultiplier( modifierData, modifierData.RequiredSelfEffectsMultiplier)
					end
				end

				if modifierData.RequiredEffectsMultiplier and victim and not IsEmpty(victim.ActiveEffects) then
					local hasAllEffects = true
					for _, effectName in pairs( modifierData.RequiredEffects ) do
						if not victim.ActiveEffects[ effectName ] then
							hasAllEffects = false
						end
					end
					if hasAllEffects then
						addDamageMultiplier( modifierData, modifierData.RequiredEffectsMultiplier)
					end
				end
				if modifierData.DistanceMultiplier and triggerArgs.DistanceSquared ~= nil and triggerArgs.DistanceSquared ~= -1 and ( modifierData.DistanceThreshold * modifierData.DistanceThreshold ) <= triggerArgs.DistanceSquared then
					addDamageMultiplier( modifierData, modifierData.DistanceMultiplier)
				end
				if modifierData.ProximityMultiplier and triggerArgs.DistanceSquared ~= nil and triggerArgs.DistanceSquared ~= -1 and ( modifierData.ProximityThreshold * modifierData.ProximityThreshold ) >= triggerArgs.DistanceSquared then
					addDamageMultiplier( modifierData, modifierData.ProximityMultiplier)
				end
				if modifierData.LowHealthDamageOutputMultiplier ~= nil and attacker.Health ~= nil and (attacker.Health / attacker.MaxHealth) <= modifierData.LowHealthThreshold then
					addDamageMultiplier( modifierData, modifierData.LowHealthDamageOutputMultiplier)
				end
				if modifierData.TargetHighHealthDamageOutputMultiplier ~= nil and (victim.Health / victim.MaxHealth) < modifierData.TargetHighHealthThreshold then
					addDamageMultiplier( modifierData, modifierData.TargetHighHealthDamageOutputMultiplier)
				end
				if modifierData.FriendMultiplier and ( victim == attacker or ( attacker.Charmed and victim == CurrentRun.Hero ) or ( not attacker.Charmed and victim ~= CurrentRun.Hero and not HeroData.DefaultHero.HeroAlliedUnits[victim.Name] )) then
					addDamageMultiplier( modifierData, modifierData.FriendMultiplier )
				end
				if modifierData.PlayerMultiplier and victim == CurrentRun.Hero then
					addDamageMultiplier( modifierData, modifierData.PlayerMultiplier )
				end
				if modifierData.NonPlayerMultiplier and victim ~= CurrentRun.Hero and not HeroData.DefaultHero.HeroAlliedUnits[victim.Name] then
					addDamageMultiplier( modifierData, modifierData.NonPlayerMultiplier )
				end
				if modifierData.FinalShotMultiplier and CurrentRun.CurrentRoom.ZeroAmmoVolley and CurrentRun.CurrentRoom.ZeroAmmoVolley[ triggerArgs.ProjectileVolley ] then
					addDamageMultiplier( modifierData, modifierData.FinalShotMultiplier)
				end
				if modifierData.LoadedAmmoMultiplier and CurrentRun.CurrentRoom.LoadedAmmo and CurrentRun.CurrentRoom.LoadedAmmo > 0 then
					addDamageMultiplier( modifierData, modifierData.LoadedAmmoMultiplier)
				end
				if modifierData.SpeedDamageMultiplier then
					local baseSpeed = GetBaseDataValue({ Type = "Unit", Name = "_PlayerUnit", Property = "Speed" })
					local speedModifier = CurrentRun.CurrentRoom.SpeedModifier or 1
					local currentSpeed = GetUnitDataValue({ Id = CurrentRun.Hero.ObjectId, Property = "Speed" }) * speedModifier
					if currentSpeed > baseSpeed then
						addDamageMultiplier( modifierData, 1 + modifierData.SpeedDamageMultiplier * ( currentSpeed/baseSpeed - 1 ))
					end
				end

				if modifierData.ActiveDashWeaponMultiplier and triggerArgs.BlinkWeaponActive then
					addDamageMultiplier( modifierData, modifierData.ActiveDashWeaponMultiplier )
				end

				if modifierData.EmptySlotMultiplier and modifierData.EmptySlotValidData then
					local filledSlots = {}

					for i, traitData in pairs( attacker.Traits ) do
						if traitData.Slot then
							filledSlots[traitData.Slot] = true
						end
					end

					for key, weaponList in pairs( modifierData.EmptySlotValidData ) do
						if not filledSlots[key] and Contains( weaponList, triggerArgs.SourceWeapon ) then
							addDamageMultiplier( modifierData, modifierData.EmptySlotMultiplier )
						end
					end
				end
			end
		end
	end

	if weaponData ~= nil then
		if attacker == victim and weaponData.SelfMultiplier then
			addDamageMultiplier( { Name = weaponData.Name, Multiplicative = true }, weaponData.SelfMultiplier)
		end

		if weaponData.OutgoingDamageModifiers ~= nil and not weaponData.IgnoreOutgoingDamageModifiers then
			for i, modifierData in pairs(weaponData.OutgoingDamageModifiers) do
				if modifierData.NonPlayerMultiplier and victim ~= CurrentRun.Hero and not HeroData.DefaultHero.HeroAlliedUnits[victim.Name] then
					addDamageMultiplier( modifierData, modifierData.NonPlayerMultiplier)
				end
				if modifierData.PlayerMultiplier and ( victim == CurrentRun.Hero or HeroData.DefaultHero.HeroAlliedUnits[victim.Name] ) then
					addDamageMultiplier( modifierData, modifierData.PlayerMultiplier)
				end
				if modifierData.PlayerSummonMultiplier and HeroData.DefaultHero.HeroAlliedUnits[victim.Name] then
					addDamageMultiplier( modifierData, modifierData.PlayerSummonMultiplier)
				end
			end
		end
	end

	if ConfigOptionCache.LogCombatMultipliers and triggerArgs and triggerArgs.AttackerName and triggerArgs.DamageAmount then
		DebugPrint({Text = triggerArgs.AttackerName .. ": Base Damage : " .. triggerArgs.DamageAmount .. " Damage Bonus: " .. damageMultipliers .. ", Damage Reduction: " .. damageReductionMultipliers })
	end
	return damageMultipliers * damageReductionMultipliers
end

function CalculateLifestealModifiers( attacker, victim, weaponData, triggerArgs )
	local lifesteal = 0
	if attacker ~= nil and attacker.OutgoingLifestealModifiers and victim ~= nil and not victim.BlockLifeSteal then
		for i, modifierData in pairs( attacker.OutgoingLifestealModifiers ) do
			local validWeapon = modifierData.ValidWeapons == nil or ( Contains( modifierData.ValidWeapons, triggerArgs.SourceWeapon ) and triggerArgs.EffectName == nil )
			if validWeapon then
				local modifierLifesteal = triggerArgs.DamageAmount * modifierData.ValidMultiplier
				if modifierData.MinLifesteal and modifierLifesteal < modifierData.MinLifesteal then
					modifierLifesteal = modifierData.MinLifesteal
				elseif modifierData.MaxLifesteal and modifierLifesteal > modifierData.MaxLifesteal then
					modifierLifesteal = modifierData.MaxLifesteal
				end

				lifesteal = lifesteal + modifierLifesteal
			end
		end
	end

	Heal( attacker, { HealAmount = lifesteal, SourceName = "CombatLifesteal", Silent = false } )
end

function HasStoredAmmoVulnerabilityMultiplier( victim, attacker )
	if attacker == nil or attacker.OutgoingDamageModifiers == nil or victim == nil or IsEmpty( victim.StoredAmmo ) then
		return false
	end
	for i, data in pairs( attacker.OutgoingDamageModifiers ) do
		if not IsEmpty( victim.StoredAmmo ) and data.StoredAmmoMultiplier then
			local hasExternalStoredAmmo = false
			for i, storedAmmo in pairs(victim.StoredAmmo) do
				if storedAmmo.WeaponName ~= "SelfLoadAmmoApplicator" then
					return true
				end
			end
		end
		if IsEmpty( victim.StoredAmmo ) and data.UnstoredAmmoMultiplier then
			return true
		end
	end
	return false
end

function HasVulnerabilityEffectApplied( victim )
	return victim.VulnerabilityEffects ~= nil and GetNumMetaUpgrades("VulnerabilityEffectBonusMetaUpgrade") > 0 and TableLength( victim.VulnerabilityEffects ) >= MetaUpgradeData.VulnerabilityEffectBonusMetaUpgrade.AddOutgoingDamageModifiers.MinRequiredVulnerabilityEffects
end

function Damage( victim, triggerArgs )

	if victim == nil or victim.Health == nil or ( victim.IsDead and not triggerArgs.PureDamage ) then
		return
	end

	triggerArgs.triggeredById = triggerArgs.triggeredById  or victim.ObjectId
	triggerArgs.TriggeredByTable = triggerArgs.TriggeredByTable or victim

	if not triggerArgs.PureDamage then
		if triggerArgs.IsInvulnerable or (victim.InvulnerableFlags ~= nil and not IsEmpty( victim.InvulnerableFlags )) or (victim.PersistentInvulnerableFlags ~= nil and not IsEmpty( victim.PersistentInvulnerableFlags )) then
			if not triggerArgs.Silent then
				thread( BlockedDamageInvulnerablePresentation, victim, triggerArgs )
			end
			return
		end

		local attacker = triggerArgs.AttackerTable
		local sourceProjectileData = nil
		local sourceEffectData = nil
		local sourceWeaponData = GetWeaponData( attacker, triggerArgs.SourceWeapon )
		if triggerArgs.SourceProjectile ~= nil then
			sourceProjectileData = ProjectileData[triggerArgs.SourceProjectile]
		end
		if triggerArgs.EffectName ~= nil then
			sourceEffectData = EffectData[triggerArgs.EffectName]
		end
		local baseDamage = triggerArgs.DamageAmount
		local multipliers = CalculateDamageMultipliers( attacker, victim, sourceWeaponData, triggerArgs )
		local additive = CalculateDamageAdditions( attacker, victim, triggerArgs )
		triggerArgs.DamageAmount = round(triggerArgs.DamageAmount * multipliers) + additive
		CalculateLifestealModifiers( attacker, victim, sourceWeaponData, triggerArgs )

		if victim.AIEndHealthThreshold ~= nil then
			local healthThreshold = victim.MaxHealth * victim.AIEndHealthThreshold
			local remainingThresholdHealth = (victim.Health - healthThreshold) + 1
			if triggerArgs.DamageAmount > remainingThresholdHealth then
				triggerArgs.DamageAmount = remainingThresholdHealth
			end
		end

		if ConfigOptionCache.EasyMode and victim == CurrentRun.Hero then
			triggerArgs.DamageAmount = math.ceil( triggerArgs.DamageAmount * CalcEasyModeMultiplier() )
			if CurrentRun.EasyModeLevel == nil then
				CurrentRun.EasyModeLevel = GameState.EasyModeLevel
			end
		end

		if triggerArgs.DamageAmount > 0 and not triggerArgs.Silent and (sourceEffectData == nil or not sourceEffectData.RapidDamageType ) and ( sourceWeaponData == nil or not sourceWeaponData.RapidDamageType ) then
			if victim.DamagedAnimation ~= nil then
				local damagedAnimBlocked = false
				if victim.ActiveEffects ~= nil then
					for effectName, v in pairs( victim.ActiveEffects ) do
						local effectData = EffectData[effectName]
						if effectData ~= nil and effectData.BlockDamageAnimation then
							damagedAnimBlocked = true
						end
					end
				end
				if not damagedAnimBlocked then
					SetAnimation({ DestinationId = victim.ObjectId, Name = victim.DamagedAnimation })
				end
			end
			thread( GenericDamagePresentation, victim, triggerArgs )
		end
	end

	if victim == CurrentRun.Hero then

		victim.Health = victim.Health - triggerArgs.DamageAmount
		if triggerArgs.MinHealth ~= nil and victim.Health < triggerArgs.MinHealth then
			victim.Health = triggerArgs.MinHealth
		end
		if victim.Health <= 0 then
			victim.Health = 0
			DamageHero( victim, triggerArgs )
			if CheckLastStand( victim, triggerArgs ) then
				return
			end
		else
			DamageHero( victim, triggerArgs )
		end
	else
		DamageEnemy( victim, triggerArgs )
	end

	if BlockHeroDeath and victim == CurrentRun.Hero then
		victim.CannotDieFromDamage = true
	end

	if victim.Health <= 0 and not victim.CannotDieFromDamage then
		if victim.ClearChillOnDeath then
			ClearEffect({ Id = victim.ObjectId, Name = "DemeterSlow" })
		end
		if victim.Phases ~= nil and victim.CurrentPhase < victim.Phases then
			SetUnitInvulnerable( victim )
			ClearEffect({ Id = victim.ObjectId, All = true, ExcludeNames = { "BeamRotation" } })
			return
		end
		triggerArgs.Killed = true
		if victim.DeathAnimation ~= nil and not victim.ManualDeathAnimation then
			SetAnimation({ Name = victim.DeathAnimation, DestinationId = victim.ObjectId })
			-- @todo Notify on death animation finish
		end

		if victim.PreDeathFunctionName ~= nil then
			local onDeathFunction = _G[victim.PreDeathFunctionName]
			onDeathFunction( victim, victim.PreDeathFunctionArgs )
		end
		Kill( victim, triggerArgs )
	end

end

function CalcEasyModeMultiplier( level )
	if GameState == nil then
		return 0
	end
	local easyModeMultiplier = HeroData.DefaultHero.EasyModeDamageMultiplierBase + (HeroData.DefaultHero.EasyModeDamageMultiplierPerDeath * math.min( HeroData.DefaultHero.EasyModeDamageMultiplierDeathCap, level or GameState.EasyModeLevel ) )
	return easyModeMultiplier
end

function DamageEnemy( victim, triggerArgs )

	local sourceWeaponData = triggerArgs.AttackerWeaponData
	local attacker = triggerArgs.AttackerTable

	-- Used to detect death via artemis vulnerability crit even though it's cleared on a crit
	victim.ActiveEffectsAtDamageStart = {}
	if victim.ActiveEffects then
		victim.ActiveEffectsAtDamageStart = ShallowCopyTable( victim.ActiveEffects )
	end

	if triggerArgs.EffectName ~= nil and EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].NonPlayerDamageMultiplier then
		triggerArgs.DamageAmount = triggerArgs.DamageAmount * EffectData[triggerArgs.EffectName].NonPlayerDamageMultiplier
	end

	if triggerArgs.AttackerIsObstacle and CurrentRun and CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.WallSlamMultiplier then
		triggerArgs.DamageAmount = triggerArgs.DamageAmount * CurrentRun.CurrentRoom.WallSlamMultiplier
	end

	if sourceWeaponData ~= nil then
		if sourceWeaponData.ForceCrit then
			triggerArgs.IsCrit = true
		end
	end

	if triggerArgs.DamageAmount == 0 then
		return
	end

	thread( CheckWallSlamPowers, victim, triggerArgs )
	thread( CheckOnDamagedPowers, victim, attacker, triggerArgs )
	thread( CheckComboPowers, victim, attacker, triggerArgs, sourceWeaponData )

	local healthProtected = ProcessHealthBuffer( victim, triggerArgs )
	if not healthProtected then
		victim.Health = victim.Health - triggerArgs.DamageAmount
		if triggerArgs.MinHealth ~= nil and victim.Health < triggerArgs.MinHealth then
			victim.Health = triggerArgs.MinHealth
		end
		if victim.Health < 0 then
			victim.Health = 0
		end
	end

	if not victim.EarlyExit and not victim.IsDead and victim.Health > 0 and triggerArgs.DamageAmount > 0 then
		CreateHealthBar( victim )
	end
	thread( UpdateHealthBar, victim, triggerArgs.DamageAmount, triggerArgs )

	if not victim.SkipDamageText then
		local weaponData = GetWeaponData(triggerArgs.AttackerTable, triggerArgs.SourceWeapon)
		if triggerArgs.DamageAmount > 0 or weaponData == nil or not weaponData.SkipDamageTextIfNoDamage then
			thread( DisplayDamageText, victim, triggerArgs )

			if (victim.HitShields ~= nil and victim.HitShields > 0) or (victim.HealthBuffer ~= nil and victim.HealthBuffer > 0) then
				thread( ArmorDamagePresentation, triggerArgs )
			else
				thread( DamagePresentation, triggerArgs )
			end
			thread( SpecialHitPresentation, triggerArgs )
			thread( WallHitPresentation, victim, triggerArgs )
		end
	end

	if not triggerArgs.VictimIsTraitor then
		if triggerArgs.IsCrit then
			if CheckCooldown( "CritSuper", 0.5 ) then
				BuildSuperMeter( CurrentRun, GetTotalHeroTraitValue("CriticalSuperGainAmount"))
			end
		end

		if triggerArgs.DamageAmount ~= nil and triggerArgs.AttackerId == CurrentRun.Hero.ObjectId then
			CalculateSuperGain( triggerArgs, sourceWeaponData, victim )
		end
	end

	local currentHealthFraction = victim.Health / victim.MaxHealth
	if victim.CriticalHealthVoiceLines ~= nil and currentHealthFraction < (victim.CriticalHealthVoiceLineThreshold or 1.0) then
		thread( PlayVoiceLines, victim.CriticalHealthVoiceLines, nil, victim )
	elseif victim.LowHealthVoiceLines ~= nil and currentHealthFraction < (victim.LowHealthVoiceLineThreshold or 1.0) then
		thread( PlayVoiceLines, victim.LowHealthVoiceLines, nil, victim )
	end

	if victim.AIEndHealthThreshold ~= nil then
		if currentHealthFraction <= victim.AIEndHealthThreshold and victim.Health > 0 then
			SetUnitInvulnerable( victim )
			if victim.ExpireEffectOnThreshold then
				ClearEffect({ Id = victim.ObjectId, Name = victim.ExpireEffectOnThreshold })
			end
			if victim.BecameInvulnerableGlobalVoiceLines then
				thread( PlayVoiceLines, GlobalVoiceLines[victim.BecameInvulnerableGlobalVoiceLines], nil, victim )
			end
		end
	end

	for i, data in pairs( GetHeroTraitValues( "OnDamageEnemyFunction")) do
		if data.FunctionName and _G[data.FunctionName] then
			_G[data.FunctionName]( data.FunctionArgs, attacker, victim )
		end
	end

	if sourceWeaponData ~= nil and HeroHasTrait("BowBondTrait") and not triggerArgs.PureDamage and not IsEmpty(ActiveEnemies) and ( not victim.SkipModifiers or victim.BondAlwaysApplies) then
		local shareData = GetHeroTraitValues("BondDamageShareData")[1]
		local enemyIds = GetAllKeys( ActiveEnemies )
		for index, id in pairs(enemyIds) do
			local enemy = ActiveEnemies[id]
			if enemy and not enemy.IsDead and IsEmpty( enemy.InvulnerableFlags ) and IsEmpty ( enemy.PersistentInvulnerableFlags )
				and enemy.ActiveEffects and enemy.ActiveEffects.MarkBondTarget and Contains(shareData.WeaponNames, sourceWeaponData.Name ) and not triggerArgs.EffectName then
				local damageAmount = triggerArgs.DamageAmount * shareData.Multiplier
				if HeroData.DefaultHero.HeroAlliedUnits[ enemy.Name ] and shareData.AlliedDamageMultiplier then
					damageAmount = damageAmount * shareData.AlliedDamageMultiplier
				end
				Damage( enemy, { EffectName = "DamageShare", DamageAmount = damageAmount, Silent = false, PureDamage = true } )
			end
		end
	end

	if sourceWeaponData ~= nil and sourceWeaponData.CauseLeap then
		victim.NeedsRetreatLeap = true
	elseif victim.DefaultAIData ~= nil then
		if victim.DefaultAIData.LeapRetreatAtHealthPercent and currentHealthFraction <= victim.DefaultAIData.LeapRetreatAtHealthPercent then
			victim.NeedsRetreatLeap = true
		elseif victim.DefaultAIData.RetreatLeapWhenHitChance and RandomChance(victim.DefaultAIData.RetreatLeapWhenHitChance) and triggerArgs.AttackerId == CurrentRun.Hero.ObjectId then
			victim.NeedsRetreatLeap = true
		elseif victim.DefaultAIData.FlankLeapWhenHit and triggerArgs.AttackerId == CurrentRun.Hero.ObjectId then
			victim.NeedsFlankLeap = true
		end
	end

	if victim.RageChargeMultiplier ~= nil then
		victim.RageHit = true
		local meterAmount = triggerArgs.DamageAmount * victim.RageChargeMultiplier * 0.01
		BuildRageMeter( CurrentRun, meterAmount, victim )
	end

	if victim.AggroSpawnsOnHit then
		local spawnIds = GetIds({ Name = "Spawner"..victim.ObjectId })
		for k, id in pairs(spawnIds) do
			if ActiveEnemies[id] ~= nil and not ActiveEnemies[id].IsDead then
				thread(AggroUnit, ActiveEnemies[id])
			end
		end
	end

	if victim.OnDamagedFunctionName ~= nil then
		local onDamagedFunction = _G[victim.OnDamagedFunctionName]
		thread( onDamagedFunction, victim, attacker )
	end

	if victim.OnFinalDamageFunctionName ~= nil and victim.Health <= 0 then
		local onFinalDamagedFunction = _G[victim.OnFinalDamageFunctionName]
		onFinalDamagedFunction( victim )
	end

	if attacker ~= nil and attacker == CurrentRun.Hero then
		victim.TimeOfLastPlayerDamage = _worldTime
	end

end

function BuildRageMeter(currentRun, meterAmount, enemy)
	if enemy.Enraged then
		return
	end

	local screenId = ScreenAnchors.BossRageFill
	enemy.RageFraction = enemy.RageFraction or 0

	enemy.RageFraction = enemy.RageFraction + meterAmount
	enemy.LastRageGainTime = _worldTime
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1 - enemy.RageFraction, DestinationId = screenId })

	if enemy.RageFraction >= 1 then
		enemy.RageFraction = 0
		thread(EnrageUnit, enemy, currentRun)
	end
end

function DrainRallyHealth()
	if CurrentRun.Hero.RallyHealth.RallyDecayRateSeconds <= 0 then
		CurrentRun.Hero.RallyHealth.Store = 0
		return
	end
	local initialEnterState = CurrentRun.Hero.RallyHealth.State
	CurrentRun.Hero.RallyHealth.State = "Wait"
	if initialEnterState ~= nil and initialEnterState ~= "Idle" then
		return
	end

	local tickRate = 0.03
	local drainRate = 0
	while CurrentRun.Hero.RallyHealth.Store >= 0 do
		if CurrentRun.Hero.RallyHealth.State == nil or CurrentRun.Hero.RallyHealth.State =="Wait" then
			wait(CurrentRun.Hero.RallyHealth.RallyDecayHold)
			 CurrentRun.Hero.RallyHealth.State = "Draining"
			drainRate = tickRate * CurrentRun.Hero.RallyHealth.Store / CurrentRun.Hero.RallyHealth.RallyDecayRateSeconds
		elseif  CurrentRun.Hero.RallyHealth.State == "Draining" then
			CurrentRun.Hero.RallyHealth.Store = CurrentRun.Hero.RallyHealth.Store - drainRate
			thread(UpdateRallyHealthUI)
		end
		wait( tickRate, RoomThreadName )
	end
	RemoveRallyHealth()
end

function RemoveRallyHealth()
	CurrentRun.Hero.RallyHealth.Store = 0
	CurrentRun.Hero.RallyHealth.State = "Idle"
end

function GetWeaponData(unit, weaponName)
	if not unit or not unit.WeaponDataOverride or not unit.WeaponDataOverride[weaponName] then
		return WeaponData[weaponName]
	else
		return unit.WeaponDataOverride[weaponName]
	end
end

function ProcessHealthBuffer( enemy, damageEventArgs )

	local sourceWeaponData = WeaponData[damageEventArgs.SourceWeapon]
	if sourceWeaponData ~= nil and sourceWeaponData.IgnoreHealthBuffer then
		return false
	end

	if enemy.HitShields ~= nil and enemy.HitShields > 0 then
		enemy.HitShields = enemy.HitShields - 1
		return true
	end

	local damageAmount = damageEventArgs.DamageAmount
	if enemy.HealthBuffer ~= nil and enemy.HealthBuffer > 0 then
		local healthBufferDamageMultiplier = 1

		if damageEventArgs.IsCrit then
			healthBufferDamageMultiplier = healthBufferDamageMultiplier + GetTotalHeroTraitValue( "CriticalHealthBufferMultiplier", { IsMultiplier = true }) - 1
		end
		damageAmount = damageAmount * healthBufferDamageMultiplier
		damageEventArgs.DamageAmount = damageAmount
		if (damageAmount - enemy.HealthBuffer) < 0 then
			enemy.HealthBuffer = enemy.HealthBuffer - damageAmount
		else
			local prevHealthBuffer = enemy.HealthBuffer
			local leftOverDamage = 0
			enemy.HealthBuffer = 0
			DoEnemyHealthBufferDeplete( enemy )
			thread( ArmorBreakPresentation, enemy )
			damageEventArgs.DamageAmount = leftOverDamage + prevHealthBuffer
		end
		return true
	end

	return false

end

function DoEnemyHealthBuffered( enemy )
	if enemy.OnHealthBufferedFunctionName ~= nil then
		_G[enemy.OnHealthBufferedFunctionName]( enemy )
	end
	enemy.WasImmuneToStunWithoutArmor = GetUnitDataValue({ Id = enemy.ObjectId, Property = "ImmuneToStun" })
	SetUnitProperty({ Property = "ImmuneToStun", Value = true, DestinationId = enemy.ObjectId })
end

function DoEnemyHealthBufferDeplete( enemy )
	if enemy.OnHealthBufferDepleteFunctionName ~= nil then
		_G[enemy.OnHealthBufferDepleteFunctionName]( enemy )
	end
	RemoveOutline({ Id = enemy.ObjectId })
	if enemy.TetherIds ~= nil then
		for k, tetherId in ipairs( enemy.TetherIds ) do
			RemoveOutline({ Id = tetherId })
		end
	end
	if not enemy.WasImmuneToStunWithoutArmor then
		SetUnitProperty({ Property = "ImmuneToStun", Value = false, DestinationId = enemy.ObjectId })
	end
	ApplyEffectFromWeapon({ Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, WeaponName = "ArmorBreakAttack", EffectName = "ArmorBreakStun" })
end

function EnemyHitDuringRegen( enemy )
	enemy.HitDuringRegenTick = true
	wait( enemy.HealthBufferedRegenHitDelay )
	enemy.HitDuringRegenTick = false
end

OnHealed{ "_PlayerUnit",
	function( triggerArgs )
		Heal( triggerArgs.TriggeredByTable, triggerArgs )
	end
}

OnHealed{ "EnemyTeam",
	function( triggerArgs )
		Heal( triggerArgs.TriggeredByTable, triggerArgs )
	end
}

function DamageHero( victim, triggerArgs )
	local attacker = triggerArgs.AttackerTable
	local sourceWeaponData = GetWeaponData( attacker, triggerArgs.SourceWeapon )
	local sourceEffectData = nil
	if triggerArgs.EffectName then
		sourceEffectData = EffectData[triggerArgs.EffectName ]
	end

	thread( CheckOnDamagedPowers, victim, attacker, triggerArgs )
	CalculateSuperGain( triggerArgs, sourceWeaponData, victim )

	local currentHealth = victim.Health
	local currentHealthFraction = victim.Health / victim.MaxHealth
	if triggerArgs.DamageAmount ~= nil and triggerArgs.DamageAmount > 0 then
		CancelOpeningCodex()
		CancelFishing()
		if IsScreenOpen("Codex") then
			CloseCodexScreen()
		end
	end

	if triggerArgs.DamageAmount ~= nil and triggerArgs.DamageAmount > 0 and not triggerArgs.Silent then

		if sourceWeaponData == nil or not sourceWeaponData.IgnoreInvulnerabilityFrameTrigger then
			if sourceEffectData == nil or not sourceEffectData.IgnoreInvulnerabilityFrameTrigger then
				thread( CheckInvulnerabilityFrameTrigger, victim, triggerArgs )
			end
		end

		if attacker ~= nil then
			if currentHealthFraction < (attacker.PlayerInjuredVoiceLineThreshold or victim.PlayerInjuredVoiceLineThreshold or 1.0) then
				if attacker.PlayerInjuredVoiceLines ~= nil then
					thread( PlayVoiceLines, attacker.PlayerInjuredVoiceLines, nil, attacker )
				else
					for k, unit in pairs( ActiveEnemies ) do
						if unit.PlayerInjuredReactionVoiceLines ~= nil then
							thread( PlayVoiceLines, unit.PlayerInjuredReactionVoiceLines, nil, unit )
						end
					end
				end
			end
		end

		if CurrentRun.CurrentRoom.Encounter ~= nil and not triggerArgs.PureDamage then
			local hasPlayerTakenDamage = CurrentRun.CurrentRoom.Encounter.PlayerTookDamage
			CurrentRun.CurrentRoom.Encounter.PlayerTookDamage = true

			if CurrentRun.ActiveObjectives.PerfectClear ~= nil then
				thread( MarkObjectiveFailed, "PerfectClear" )
				PerfectClearObjectiveFailedPresentation( CurrentRun )
			end

			if not hasPlayerTakenDamage and not CurrentRun.CurrentRoom.BlockClearRewards and not CurrentRun.CurrentRoom.PerfectEncounterCleared and IsCombatEncounterActive( CurrentRun ) then
				for i, traitData in pairs(CurrentRun.Hero.Traits) do
					local perfectClearDamageData = traitData.PerfectClearDamageBonus
					if perfectClearDamageData ~= nil then
						PerfectClearTraitFailedPresentation( traitData )
					end
				end
			end
		end

		local adjustedDamageAmount = triggerArgs.DamageAmount

		local attackerName = triggerArgs.AttackerName
		if attackerName ~= nil then
			DamageRecord[attackerName] = (DamageRecord[attackerName] or 0) + adjustedDamageAmount
			CurrentRun.DamageRecord[attackerName] = (CurrentRun.DamageRecord[attackerName] or 0) + adjustedDamageAmount
			GameState.EnemyDamage[attackerName] = (GameState.EnemyDamage[attackerName] or 0) + adjustedDamageAmount
		end
		if CurrentRun.Hero.RallyHealth.RallyActive and (sourceEffectData == nil or not sourceEffectData.NoRallyStore) and not triggerArgs.PureDamage then
			if CurrentRun.Hero.RallyHealth.HitsDrainRallyHealthMultiplier then
				CurrentRun.Hero.RallyHealth.Store = CurrentRun.Hero.RallyHealth.Store * CurrentRun.Hero.RallyHealth.HitsDrainRallyHealthMultiplier
			end
			CurrentRun.Hero.RallyHealth.Store = CurrentRun.Hero.RallyHealth.Store + adjustedDamageAmount * CurrentRun.Hero.RallyHealth.ConversionPercent
			thread(UpdateRallyHealthUI)
			thread(DrainRallyHealth)
		end

		TriggerCooldown( "BlockPerfectDash" )

	end

	-- Must be last so changes can be made to triggerArgs
	if math.ceil(currentHealth) ~= math.ceil(currentHealth + triggerArgs.DamageAmount) then
		triggerArgs.DamageAmount = math.ceil(currentHealth + triggerArgs.DamageAmount) - math.ceil(currentHealth)
		if not triggerArgs.Silent then
			HeroDamagePresentation( triggerArgs, sourceWeaponData )
		end
	end

	local lowHealthText = {}
	for i, traitData in pairs(CurrentRun.Hero.Traits) do
		local thresholdData = traitData.LowHealthThresholdText
		if thresholdData ~= nil and currentHealthFraction <= thresholdData.Threshold and (currentHealth + triggerArgs.DamageAmount) / ( victim.MaxHealth) > thresholdData.Threshold then
			lowHealthText[traitData.Name] = thresholdData.Text
			TraitUIActivateTrait(traitData)
		end
	end

	if not IsEmpty( lowHealthText ) and not triggerArgs.Silent then
		thread( LowHealthCombatTextPresentation, victim.ObjectId, lowHealthText )
	end

	if triggerArgs.DamageAmount ~= nil and triggerArgs.DamageAmount > 0 then
		InvalidateCheckpoint()
	end
	if not triggerArgs.Silent then
		thread( UpdateHealthUI, triggerArgs )
	end

end

local recentHeroDamage = 0
function CheckInvulnerabilityFrameTrigger( victim, triggerArgs )
	local damage = triggerArgs.DamageAmount
	if damage == nil then
		return
	end
	if victim.Health <= 0 then
		-- Never trigger on death defiance or actual death
		return
	end

	if GetNumMetaUpgrades("NoInvulnerabilityShrineUpgrade") >= 1 then
		return
	end

	recentHeroDamage = recentHeroDamage + damage
	local maxHealth = CurrentRun.Hero.MaxHealth
	local heroHealthThreshold = math.max( maxHealth * victim.InvulnerableFrameThreshold, victim.InvulnerableFrameMinDamage or 0 )
	--DebugPrint({ Text = "Recent Damage: "..recentHeroDamage })
	if recentHeroDamage ~= nil and recentHeroDamage >= heroHealthThreshold then
		recentHeroDamage = 0
		SetPlayerInvulnerable( "Frame" )
		thread( InvulnerabilityFramePresentationStart, victim, damage, heroHealthThreshold )
		wait( victim.InvulnerableFrameDuration )
		if not victim.IsDead then
			SetPlayerVulnerable( "Frame" )
			thread( InvulnerabilityFramePresentationEnd )
		end
		return
	end
	wait( victim.InvulnerableFrameCumulativeDamageDuration or 0.5 )
	recentHeroDamage = recentHeroDamage - damage
	if recentHeroDamage < 0 then
		recentHeroDamage = 0
	end
end

function IsOnlyInvulnerableSource( flag )
	if flag == nil then
		return false
	end

	if TableLength(CurrentRun.InvulnerableFlags) == 1 and CurrentRun.InvulnerableFlags[flag] then
		return true
	end
	return false
end

function SetPlayerInvulnerable( flag )
	if flag == nil then
		flag = "Generic"
	end

	CurrentRun.Hero.InvulnerableFlags[flag] = true
	CurrentRun.InvulnerableFlags[flag] = true
	SetInvulnerable({ Id = CurrentRun.Hero.ObjectId })
end

function SetPlayerVulnerable( flag )
	if flag == nil then
		flag = "Generic"
	end

	CurrentRun.Hero.InvulnerableFlags[flag] = nil
	CurrentRun.InvulnerableFlags[flag] = nil
	if IsEmpty( CurrentRun.InvulnerableFlags ) then
		SetVulnerable({ Id = CurrentRun.Hero.ObjectId })
	end
end

function SetUnitInvulnerable( unit, flag )

	if flag == nil then
		flag = "Generic"
	end
	unit.InvulnerableFlags = unit.InvulnerableFlags or {}
	unit.InvulnerableFlags[flag] = true

	SetInvulnerable({ Id = unit.ObjectId })
end

function SetUnitVulnerable( unit, flag )
	if flag == nil then
		flag = "Generic"
	end
	unit.InvulnerableFlags = unit.InvulnerableFlags or {}
	unit.InvulnerableFlags[flag] = nil
	if IsEmpty( unit.InvulnerableFlags ) then
		SetVulnerable({ Id = unit.ObjectId })
	end
end

function SetPlayerPhasing( flag )
	if HasHeroTraitValue("PermanentNoUnitCollision") then
		return
	end

	if flag == nil then
		flag = "Generic"
	end

	CurrentRun.PhasingFlags[flag] = true
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = false })
end

function SetPlayerUnphasing( flag )
	if HasHeroTraitValue("PermanentNoUnitCollision") then
		return
	end

	if flag == nil then
		flag = "Generic"
	end

	CurrentRun.PhasingFlags[flag] = nil
	if IsEmpty( CurrentRun.PhasingFlags ) then
		SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = true })
	end
end

function VulnerableAfterDelay( delay )	
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "AthenaDefenseEffect"})
	wait( delay )
	SetPlayerVulnerable( "TraitInvulnerability" )
end

function ReactivateInvulnerability()
	if CurrentRun.CurrentRoom and CurrentRun.CurrentRoom.BlockTraitSetup then
		return
	end
	ApplyEffectFromWeapon({ WeaponName = "AthenaDefenseApplicator", EffectName = "AthenaDefenseEffect", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
					
	SetPlayerInvulnerable( "TraitInvulnerability" )
end

function AddLastStand( args )
	local unit = args.Unit or CurrentRun.Hero
	args.Unit = nil
	local count = args.Count or 1
	if not unit.LastStands then
		unit.LastStands = {}
	end

	for i = 1, count do
		if args.IncreaseMax then
			unit.MaxLastStands = unit.MaxLastStands or 0
			unit.MaxLastStands = unit.MaxLastStands + 1
			if ScreenAnchors.LifePipIds then
				local obstacleId = CreateScreenObstacle({Name = "BlankObstacle", Group = "Combat_UI", X = 70 + unit.MaxLastStands * 32, Y = ScreenHeight - 95})
				SetAnimation({ Name = "ExtraLifeEmpty", DestinationId = obstacleId })
				table.insert(ScreenAnchors.LifePipIds, obstacleId )
			end
		end

		if unit.MaxLastStands and TableLength( unit.LastStands ) >= unit.MaxLastStands and not args.Silent then
			UpdateLifePips( unit )
			AtLastStandMaxPresentation( unit )
			return
		end

		if args.InsertAtEnd or ( IsMetaUpgradeActive("ExtraChanceReplenishMetaUpgrade") and args.Name ~= "ExtraChanceReplenishMetaUpgrade" ) then
			table.insert( unit.LastStands, 1, args )
			if not args.Silent then
				GainLastStandPresentation(1)
			end
		else
			table.insert( unit.LastStands, args )

			if not args.Silent then
				GainLastStandPresentation()
			end
		end
	end

	if not args.Silent then
		UpdateLifePips( unit )
	end
end

function RemoveLastStand( heroUnit, name )
	local unit = heroUnit or CurrentRun.Hero
	for i, lastStandData in pairs(unit.LastStands) do
		if lastStandData.Name == name then
			table.remove(unit.LastStands, i )
			return
		end
	end
end
function CheckLastStand( victim, triggerArgs )

	if not HasLastStand( victim ) then
		return false
	end

	CancelOpeningCodex()
	CancelFishing()
	DisableCombatControls()

	local lastStandData = table.remove( victim.LastStands )
	local weaponName = lastStandData.WeaponName
	local lastStandHealth = lastStandData.HealAmount or 0
	local lastStandFraction = lastStandData.HealFraction or 0
	lastStandFraction = lastStandFraction + GetTotalHeroTraitValue( "LastStandHealFraction" )

	CurrentRun.Hero.LastStandsUsed = (CurrentRun.Hero.LastStandsUsed or 0) + 1

	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "StyxPoison" })
	BlockEffect({ Id = CurrentRun.Hero.ObjectId, Name = "StyxPoison", Duration = 0.75 })
	SetPlayerInvulnerable("LastStand")

	triggerArgs.HasLastStand = HasLastStand( victim )
	ExpireProjectiles({ ExcludeNames = WeaponSets.ExpireProjectileExcludeProjectileNames })

	PlayerLastStandPresentationStart( triggerArgs )

	PlayerLastStandHeal( victim, triggerArgs, lastStandHealth, lastStandFraction )

	if GetNumLastStands( victim ) <= 0 and lastStandData.LastStandTimer == nil then
		thread( InCombatText, CurrentRun.Hero.ObjectId, "Hint_LastChance", 1.5, { PreDelay = 0.5, ShadowScale = 0.66 })
		PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteFiredUpLASTCHANCE", Delay = 0.5 })
	end
	if lastStandData.LastStandTimer then
		thread( DamageAfterInterval, lastStandData.LastStandTimer, 1000 )
	end
	thread( UpdateHealthUI, triggerArgs )

	PlayerLastStandPresentationEnd()

	EnableCombatControls()
	if weaponName ~= nil then
		FireWeaponFromUnit({ Weapon = weaponName, Id= victim.ObjectId, DestinationId = victim.ObjectId, AutoEquip = true })
	end

	wait( 1.0, RoomThreadName )


	SetPlayerVulnerable("LastStand")
	return true
end

function PlayerLastStandHeal( victim, args, lastStandHealth, lastStandFraction )
	if lastStandHealth > 0 then
		Heal( victim, { HealAmount = lastStandHealth, SourceName = "LastStandHealTrait", Silent = true } )
	elseif lastStandFraction > 0 then
		local healAmount = round( lastStandFraction * victim.MaxHealth )
		Heal( victim, { HealAmount = healAmount, SourceName = "LastStandHealTrait", Silent = true } )
	end
	PlayerLastStandHealingPresentation( args )
end

function HasLastStand( unit )
	return not IsEmpty( unit.LastStands )
end

function GetNumLastStands( unit )
	return TableLength( unit.LastStands )
end

function DamageAfterInterval( timer, damage )
	local encounter = nil
	if CurrentRun and CurrentRun.CurrentRoom then
		if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.InProgress then
			encounter = CurrentRun.CurrentRoom.Encounter
		elseif CurrentRun.CurrentRoom.ChallengeEncounter and CurrentRun.CurrentRoom.ChallengeEncounter.InProgress then
			encounter = CurrentRun.CurrentRoom.ChallengeEncounter
		end
	end

	if encounter == nil then
		return
	end

	local tollTimes = math.floor(timer)
	while tollTimes > 0 do
		thread( HeroicStandPulse, tollTimes - 1 )
		wait (1)
		tollTimes = tollTimes - 1
	end

	if not encounter.Completed then
		SacrificeHealth({SacrificeHealthMin = damage, SacrificeHealthMax = damage, MinHealth = 0 })
	else
		-- Encounter completed before death
	end
end

OnCollisionReaction{
	function( triggerArgs )
		local collider = triggerArgs.TriggeredByTable
		local collidee = triggerArgs.CollideeTable
		if collidee ~= nil then
			DoReaction( collidee, collidee.ImpactReaction )
		end
	end
}
OnAllegianceFlip{
	function( triggerArgs )
		local enemy = triggerArgs.TriggeredByTable
		local weaponData = WeaponData[enemy.WeaponName]
		if weaponData ~= nil and not weaponData.BlockInterrupt then
			enemy.ForcedWeaponInterrupt = enemy.WeaponName
		end
		if enemy.PreAttackLoopingSoundId ~= nil then
			StopSound({ Id = enemy.PreAttackLoopingSoundId, Duration = 0.2 })
			enemy.PreAttackLoopingSoundId = nil
		end
		notifyExistingWaiters( enemy.AINotifyName )
		SetThreadWait( enemy.AIThreadName, 0.1 )
	end
}

OnObstacleCollision{
	function( triggerArgs )
		local collider = triggerArgs.TriggeredByTable
		local collidee = triggerArgs.CollideeTable
		if collider ~= nil and collider.CollisionReaction then
			if collider.CollisionReaction.MinVelocity == nil or triggerArgs.Velocity >= collider.CollisionReaction.MinVelocity then
				DoReaction( collider, collider.CollisionReaction )
			end
		end
		if collidee ~= nil and collidee.CollisionReaction then
			if collidee.CollisionReaction.MinVelocity == nil or triggerArgs.Velocity >= collidee.CollisionReaction.MinVelocity then
				if collidee.CollisionReaction.RequireColliderName == nil or (collider.Name ~= nil and collidee.CollisionReaction.RequireColliderName == collider.Name) then
					DoReaction( collidee, collidee.CollisionReaction )
				end
			end
		end
	end
}

OnUnitCollision{
	function( triggerArgs )
		local collider = triggerArgs.TriggeredByTable
		local collidee = triggerArgs.CollideeTable
		if collider ~= nil and collider.CollisionReaction then
			if collider.CollisionReaction.MinVelocity == nil or triggerArgs.Velocity >= collider.CollisionReaction.MinVelocity then
				DoReaction( collider, collider.CollisionReaction )
			end
		end
		if collidee ~= nil and collidee.CollisionReaction then
			if collidee.CollisionReaction.MinVelocity == nil or triggerArgs.Velocity >= collidee.CollisionReaction.MinVelocity then
				DoReaction( collidee, collidee.CollisionReaction )
			end
		end
	end
}

OnMovementReaction{
	function( triggerArgs )
		local mover = triggerArgs.TriggeredByTable
		local observer = triggerArgs.ObserverTable
		if observer ~= nil then
			DoReaction( observer, observer.MovementReaction )
		end
	end
}

function DoReaction( victim, reaction )

	if victim == nil or reaction == nil then
		return
	end

	if reaction.CausesOcclusion ~= nil then
		SetThingProperty({ Property = "CausesOcclusion", Value = reaction.CausesOcclusion, DestinationId = victim.ObjectId })
	end

	if reaction.DisableOnHitShake then
		victim.OnHitShakeDisabled = true
	end

	if reaction.Animation ~= nil then
		SetAnimation({ DestinationId = victim.ObjectId, Name = reaction.Animation })
		RecordObjectState( CurrentRun.CurrentRoom, victim.ObjectId, "Animation", reaction.Animation )
	end

	if reaction.Weapon ~= nil then
		if reaction.FireFromSelf then
			FireWeaponFromUnit({ Weapon = reaction.Weapon, AutoEquip = true, Id = victim.ObjectId, DestinationId = victim.ObjectId })
		else
			FireWeaponFromUnit({ Weapon = reaction.Weapon, AutoEquip = true, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId })
		end
	end

	if reaction.DropMoney ~= nil then
		CheckMoneyDrop(CurrentRun, CurrentRun.CurrentRoom, victim, reaction.DropMoney)
	end

	if reaction.SpawnObstacle ~= nil or reaction.SpawnRandomObstacle ~= nil then
		thread( SpawnImpactReactionObstacles, victim, reaction )
	end

	if reaction.GlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[reaction.GlobalVoiceLines], true )
	end

	if reaction.SwapData ~= nil then
		local newData = ObstacleData[reaction.SwapData]
		local newObject = DeepCopyTable( newData )
		newObject.ObjectId = victim.ObjectId
		AttachLua({ Id = victim.ObjectId, Table = newObject })
		if newObject.SpawnPropertyChanges ~= nil then
			ApplyUnitPropertyChanges( newObject, newObject.SpawnPropertyChanges, true )
		end
		if newObject.OnSpawnFireFunction ~= nil then
			local fireFunction = _G[newObject.OnSpawnFireFunction]
			thread(fireFunction, newObject, currentRun)
		end
		RecordObjectState( CurrentRun.CurrentRoom, victim.ObjectId, "SwapData", reaction.SwapData )
	end

	thread( DoReactionPresentation, victim, reaction )

	if reaction.KillSelf then
		Kill( victim )
	end

end

function DestroyOnDelay( ids, delay )
	wait( delay, RoomThreadName )
	Destroy({ Ids = ids })
end

function SpawnImpactReactionObstacles( victim, reaction )
	local limit = reaction.SpawnAmount or 1
	for index = 1, limit, 1 do
		SpawnImpactReactionObstacle( victim, reaction )
		local waitTime = RandomFloat( reaction.SpawnTimeMin or 0.04, reaction.SpawnTimeMax or 0.08 )
		wait( waitTime )
	end
end

function SpawnImpactReactionObstacle( victim, reaction )
	local offsetX = RandomFloat( reaction.SpawnOffsetXMin, reaction.SpawnOffsetXMax )
	if CoinFlip() then
		offsetX = offsetX * -1
	end
	local offsetY = RandomFloat( reaction.SpawnOffsetYMin, reaction.SpawnOffsetYMax )
	if CoinFlip() then
		offsetY = offsetY * -1
	end

	local obstacleName = reaction.SpawnObstacle or GetRandomValue( reaction.SpawnRandomObstacle )
	local obstacleId = SpawnObstacle({ Name = obstacleName, DestinationId = victim.ObjectId, OffsetX = offsetX, OffsetY = offsetY, ForceToValidLocation = reaction.ForceSpawnToValidLocation, SkipIfBlocked = true, Group = "Standing", })
	AddToGroup({ Id = obstacleId, Name = "DestructibleGeo"})

	local obstacleData = ObstacleData[obstacleName] or {}
	local spawnScale = reaction.SpawnScale or obstacleData.SpawnScale
	if reaction.SpawnScaleMin ~= nil and reaction.SpawnScaleMax ~= nil then
		spawnScale = RandomFloat( reaction.SpawnScaleMin, reaction.SpawnScaleMax )
	end
	if spawnScale == nil and obstacleData.SpawnScaleMin ~= nil and obstacleData.SpawnScaleMax ~= nil then
		spawnScale = RandomFloat( obstacleData.SpawnScaleMin, obstacleData.SpawnScaleMax )
	end
	if spawnScale ~= nil then
		SetScale({ Id = obstacleId, Fraction = spawnScale })
	end

	if CoinFlip() then
		FlipHorizontal({ Id = obstacleId })
	end
	if reaction.SpawnOffsetZ ~= nil then
		AdjustZLocation({ Id = obstacleId, Distance = reaction.SpawnOffsetZ })
	end
	if reaction.FallForce ~= nil then
		ApplyUpwardForce({ Id = obstacleId, Speed = -reaction.FallForce })
	end
end

OnTouchdown{
	function( triggerArgs )

		local touchdowner = triggerArgs.TriggeredByTable
		if touchdowner ~= nil and touchdowner.OnTouchdown ~= nil then
			if touchdowner.OnTouchdown.LeapIfBlocked and IsLocationBlocked({ Id = touchdowner.ObjectId }) then
				Leap(touchdowner, touchdowner.DefaultAIData, CurrentRun.Hero.ObjectId)
			end
			if touchdowner.OnTouchdown.KillIfBlocked and IsLocationBlocked({ Id = touchdowner.ObjectId }) then
				SetUnitProperty({ Property = "OnDeathWeapon", Value = "null", DestinationId = touchdowner.ObjectId })
				touchdowner.SpawnObstaclesOnDeath = nil
				Kill(touchdowner)
			end
			if touchdowner.OnTouchdown.Weapon ~= nil then
				FireWeaponFromUnit({ Weapon = touchdowner.OnTouchdown.Weapon, AutoEquip = true, Id = CurrentRun.Hero.ObjectId, DestinationId = touchdowner.ObjectId })
			end
			if touchdowner.OnTouchdown.CrushTypes ~= nil then
				local typeIds = GetIdsByType({ Names = touchdowner.OnTouchdown.CrushTypes })
				local crushIds = GetIntersectingIds({ Id = touchdowner.ObjectId, DestinationIds = typeIds })
				Destroy({ Ids = crushIds })
			end
			if touchdowner.OnTouchdown.DestroyOnDelay ~= nil then
				wait( touchdowner.OnTouchdown.DestroyOnDelay, RoomThreadName )
				Destroy({ Id = touchdowner.ObjectId })
			end

		end

	end
}

function KillEnemy( victim, triggerArgs )
	local killer = triggerArgs.AttackerTable
	local killingWeapon = triggerArgs.SourceWeapon

	if victim ~= nil then
		victim.IsDead = true
	end

	if killer == CurrentRun.Hero  then
		killer.LastKillTime = _worldTime
		if victim ~= nil and victim.RequiredKill then
			AllowShout = true
		end
	end

	local currentRoom = CurrentRun.CurrentRoom
	local challengeEncounter = currentRoom.ChallengeEncounter
	if currentRoom.TauntTargetId == victim.ObjectId then
		currentRoom.TauntTargetId = nil
	end

	if victim.KillSpawnsOnDeath then
		local killInterval = victim.KillSpawnsInterval or 0.1
		local delay = 0
		local spawns = GetIds({ Name = "Spawner"..victim.ObjectId })
		for k, spawnId in pairs(spawns) do
			if ActiveEnemies[spawnId] ~= nil then
				delay = delay + killInterval
				thread(DelayedKill, ActiveEnemies[spawnId], nil, delay )
			end
		end
	end

	if victim.SupportAIUnitId ~= nil then
		thread(Kill, ActiveEnemies[victim.SupportAIUnitId])
	end

	if victim.ModifyTimerOnDeath and currentRoom.Encounter.TimeModifier ~= nil and not currentRoom.Encounter.TimeIsUp then
		thread(ModifyEncounterTimerPresentation, victim.ModifyTimerOnDeath)
	end

	if victim.EndThreadWaitsOnDeath ~= nil then
		SetThreadWait( victim.EndThreadWaitsOnDeath, 0.01 )
	end

	if victim.ComboPartnerId ~= nil and ActiveEnemies[victim.ComboPartnerId] ~= nil and not ActiveEnemies[victim.ComboPartnerId].IsDead then
		if ActiveEnemies[victim.ComboPartnerId].WaitingForPartner then
			SetThreadWait( ActiveEnemies[victim.ComboPartnerId].AIThreadName, 0.0 )
		end

		if victim.ExpireComboPartnerEffectOnDeath ~= nil then
			ClearEffect({ Id = victim.ComboPartnerId, Name = victim.ExpireComboPartnerEffectOnDeath })
		end
	end

	if victim.StopAnimationsOnDeath ~= nil then
		StopAnimation({ DestinationId = victim.ObjectId, Name = victim.StopAnimationsOnDeath })
	end

	if victim.FuseSpawnsOnDeath then
		thread( FuseSpawns, victim )
	end

	if victim.WipeEnemiesOnKill then
		DestroyRequiredKills( { BlockLoot = true, SkipIds = { victim.ObjectId } } )
	end

	if victim.WipeEnemyTypesOnKill ~= nil then
		for k, enemyType in pairs(victim.WipeEnemyTypesOnKill) do
			for k, enemyId in pairs( GetIdsByType({ Name = enemyType }) ) do
				if ActiveEnemies[enemyId] ~= nil then
					Kill( ActiveEnemies[enemyId] )
				end
			end
		end
	end

	if victim.ExpireProjectilesOnKill ~= nil then
		ExpireProjectiles({ Names = victim.ExpireProjectilesOnKill })
	end

	if victim.CancelWeaponFireRequestsOnKill ~= nil then
		CancelWeaponFireRequests({ Id = victim.ObjectId })
	end

	if victim.EnrageOnDeath ~= nil then
		local unitIdToEnrage = GetClosestUnitOfType({ Id = victim.ObjectId, DestinationName = victim.EnrageOnDeath })
		if unitIdToEnrage ~= 0 and ActiveEnemies[unitIdToEnrage] ~= nil then
			ActiveEnemies[unitIdToEnrage].PermanentEnraged = true
			thread( EnrageUnit, ActiveEnemies[unitIdToEnrage], CurrentRun, victim.EnrageOnDeathStartDelay)
		end
	end

	if victim.OnDeathSpawnEncounter ~= nil and not victim.SkipOnDeathSpawnEncounter and not CurrentRun.Hero.IsDead then
		local encounter = DeepCopyTable( EncounterData[victim.OnDeathSpawnEncounter] )
		victim.SpawnedEncounter = encounter
		thread( StartEncounter, CurrentRun, CurrentRun.CurrentRoom, encounter )
	end

	if victim.TraitAnimationAnchors ~= nil then
		for i, anchorId in pairs(victim.TraitAnimationAnchors) do
			Destroy({Id = anchorId})
		end
	end

	if not victim.SkipModifiers and killer ~= nil and killer == CurrentRun.Hero then
		for i, weaponData in pairs(GetHeroTraitValues("OnEnemyDeathWeapon")) do
			if not weaponData.RequiredKillWeapons or Contains( weaponData.RequiredKillWeapons, killingWeapon ) then
				if weaponData.FireAtDeathLocation then
					FireWeaponFromUnit({ Weapon = weaponData.Weapon, Id = CurrentRun.Hero.ObjectId, DestinationId = victim.ObjectId, FireFromTarget = true })
				else
					FireWeaponFromUnit({ Weapon = weaponData.Weapon, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
				end
			end
		end
		for i, functionName in pairs(GetHeroTraitValues("OnEnemyDeathFunction")) do
			if _G[functionName] ~= nil then
				_G[functionName]()
			end
		end
	end

	StopStatusAnimation( victim )

	if victim.AttackWarningAnimation ~= nil then
		StopAnimation({ Name = victim.AttackWarningAnimation, DestinationId = victim.AttackWarningDestinationId })
		Destroy({ Id = victim.AttackWarningDestinationId })
	end

	thread( CheckOnDeathPowers, victim, killer, killingWeapon)
	if victim.Name ~= nil then
		GameState.EnemyKills[victim.Name] = (GameState.EnemyKills[victim.Name] or 0) + 1
		if victim.EliteAttributes ~= nil then
			for k, attributeName in pairs( victim.EliteAttributes ) do
				GameState.EnemyEliteAttributeKills[attributeName] = (GameState.EnemyEliteAttributeKills[attributeName] or 0) + 1
			end
		end
		CurrentRun.CurrentRoom.CodexUpdates = CurrentRun.CurrentRoom.CodexUpdates or { Enemies = {}, ChthonicGods = {}, OtherDenizens = {}, Weapons = {}}
		IncrementTableValue(CurrentRun.CurrentRoom.CodexUpdates.Enemies, victim.Name )
		IncrementTableValue(CurrentRun.CurrentRoom.CodexUpdates.ChthonicGods, victim.Name )
		IncrementTableValue(CurrentRun.CurrentRoom.CodexUpdates.OtherDenizens, victim.Name )
		if victim.GenusName and victim.GenusName ~= victim.Name then
			GameState.EnemyKills[victim.GenusName] = (GameState.EnemyKills[victim.GenusName] or 0) + 1
			IncrementTableValue(CurrentRun.CurrentRoom.CodexUpdates.Enemies, victim.GenusName )
		end
	end

	if victim.DeathVoiceLines ~= nil and not triggerArgs.Silent then
		thread( PlayVoiceLines, victim.DeathVoiceLines, nil, victim )
	end

	if RequiredKillEnemies[victim.ObjectId] ~= nil and TableLength( RequiredKillEnemies ) > 1 then
		if killer ~= nil and killer.KillingEnemyVoiceLines ~= nil then
			thread( PlayVoiceLines, killer.KillingEnemyVoiceLines, nil, killer )
		elseif LastKilledByUnitName ~= nil and LastKilledByUnitName == victim.Name then
			thread( PlayVoiceLines, GlobalVoiceLines.RevengeKillingEnemyVoiceLines, true )
		else
			thread( PlayVoiceLines, GlobalVoiceLines.KillingEnemyVoiceLines, true )
		end

		if killer ~= nil and victim ~= nil and victim.ObjectId == killer.KillStealVictimId then
			local killStolenFrom = ActiveEnemies[killer.KillStolenFromId]
			if killStolenFrom ~= nil and killStolenFrom.KillStolenVoiceLines ~= nil then
				thread( PlayVoiceLines, killStolenFrom.KillStolenVoiceLines, nil, killStolenFrom )
			end
		end
	end

	thread( PostEnemyKillPresentation, victim, triggerArgs )

end

function FuseSpawns( killedUnit )
	local fuseInterval = killedUnit.FuseSpawnsInterval or 0.3
	local spawns = killedUnit.Spawns
	if spawns ~= nil then
		for id, spawn in pairs( spawns ) do
			thread( ActivateFuse, spawn )
			wait( fuseInterval )
		end
	end
end

function CalculateSuperGain( triggerArgs, sourceWeaponData, victim )
	local damageAmount = triggerArgs.DamageAmount
	if triggerArgs.PureDamage then
		return 0
	end
	if victim ~= nil and victim.BlockWrathGain then
		return 0
	end
	if sourceWeaponData ~= nil and sourceWeaponData.BlockWrathGain then
		return 0
	end
	local meterAmount = 0
	if victim == CurrentRun.Hero then
		meterAmount = ( damageAmount / victim.MaxHealth ) * CurrentRun.Hero.Super.DamageTakenMultiplier
		meterAmount = meterAmount * (1 + GetTotalHeroTraitValue("SuperGainMultiplier", { IsMultiplier = true }) - 1 + GetTotalHeroTraitValue("DefensiveSuperGainMultiplier", { IsMultiplier = true }) - 1)
	else
		local stepdownCutoff = 60
		if damageAmount > stepdownCutoff then
			damageAmount = stepdownCutoff + math.sqrt(damageAmount - stepdownCutoff)
		end

		meterAmount = damageAmount * CurrentRun.Hero.Super.DamageDealtMultiplier
		meterAmount = meterAmount * MetaUpgradeData.LimitMetaUpgrade.ChangeValue * (1 + GetNumMetaUpgrades("LimitMetaUpgrade"))
		meterAmount = meterAmount * GetTotalHeroTraitValue("SuperGainMultiplier", { IsMultiplier = true })
		if victim.MeterMultiplier then
			thread( MarkObjectiveComplete, "BuildSuper" )
			meterAmount = meterAmount * victim.MeterMultiplier
		end
	end
	BuildSuperMeter( CurrentRun, meterAmount )
end

OnWeaponFailedToFire{
	function( triggerArgs )
		local attacker = triggerArgs.TriggeredByTable
		local weaponData = GetWeaponData( attacker, triggerArgs.name )

		if weaponData == nil then
			return
		end

		if weaponData.RecallOnFailToFire then
			RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = weaponData.RecallOnFailToFire, Method = "RecallProjectiles" })
		end
		
		if weaponData.FailToFireFunctionName and _G[weaponData.FailToFireFunctionName ] then
			_G[weaponData.FailToFireFunctionName ]( triggerArgs )
		end

		if attacker ~= nil and attacker == CurrentRun.Hero and weaponData.NotReadyText ~= nil and triggerArgs.Controllable and triggerArgs.FreshInput then
			if CheckCountInWindow( "AttackNotReady", 1.0, 4 ) and CheckCooldown( "AttackNotReady", 1.0 ) then
				if not Contains(WeaponSets.HeroMeleeWeapons, weaponData.Name ) then
					if weaponData.NotReadyText ~= nil and GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponData.Name, Property = "Enabled" }) then
						thread( InCombatTextArgs, { TargetId = attacker.ObjectId, Text = weaponData.NotReadyText, SkipRise = true, PreDelay = 0.35, Duration = 1.25, OffsetY = 80, Cooldown = 2.0 } )
					end
				end
				if CurrentDeathAreaRoom == nil or CurrentDeathAreaRoom.ExpressiveAnimation == nil then
					thread( PlayVoiceLines, HeroVoiceLines.NotReadyVoiceLines, true )
				end
			end
		end

		if IsMetaUpgradeActive("AmmoMetaUpgrade") then
			if weaponData.NotReadyPulseStoredAmmo then
				for enemyId, enemy in pairs( ActiveEnemies ) do
					if EnemyHealthDisplayAnchors[enemy.ObjectId.."storedAmmo"] ~= nil and not enemy.IsInvisible then
						for k, ammoData in pairs( EnemyHealthDisplayAnchors[enemy.ObjectId.."storedAmmo"] ) do
							local pipId = ammoData.Id
							Flash({ Id = pipId, Speed = 4, MinFraction = 0.5, MaxFraction = 0.6, Color = Color.White, Duration = 0.3 })
							if not enemy.UseBossHealthBar and CheckCountInWindow( "AmmoInEnemy", 1.0, 3 ) then
								thread( InCombatTextArgs, { TargetId = enemyId, Text = weaponData.NotReadyAmmoInEnemyText, SkipRise = true, PreDelay = 0.35, Duration = 2, Cooldown = 3.0, ShadowScale = 0.66 } )
							end
						end
					end
				end
			end

			if weaponData.NotReadyAmmoPackText ~= nil and weaponData.NotReadyAmmoPackText ~= "" then
				if CheckCountInWindow( "AmmoNotRetrieved", 2.0, 6 ) then
					local ammoIds = GetIdsByType({ Name = "AmmoPack" })
					for k, ammoId in pairs( ammoIds ) do
						thread( InCombatTextArgs, { TargetId = ammoId, Text = weaponData.NotReadyAmmoPackText, SkipRise = true, PreDelay = 0.35, Duration = 2, OffsetY = -120, Cooldown = 3.0, ShadowScale = 0.66 } )
					end
				end
			end
		end

		if CurrentDeathAreaRoom == nil or CurrentDeathAreaRoom.FailedToFireFunctionName == nil then
			if weaponData.NotReadySound ~= nil and CheckCooldown( "NotReadySound", 0.15 ) then
				PlaySound({ Name = weaponData.NotReadySound, Id = triggerArgs.triggeredById })
			end
			if weaponData.NoControlSound ~= nil and not triggerArgs.Controllable then
				PlaySound({ Name = weaponData.NoControlSound, Id = triggerArgs.triggeredById })
			end
		end

		if CurrentDeathAreaRoom ~= nil and CurrentDeathAreaRoom.FailedToFireFunctionName ~= nil then
			local failedToFireFunction = _G[CurrentDeathAreaRoom.FailedToFireFunctionName]
			if failedToFireFunction ~= nil then
				failedToFireFunction( weaponData, triggerArgs )
			end
		else
			if triggerArgs.Ammo == 0 and weaponData.NoAmmoFunctionName ~= nil then
				local noAmmoFunction = _G[weaponData.NoAmmoFunctionName]
				if noAmmoFunction ~= nil then
					noAmmoFunction( weaponData )
				end
			end
		end

	end
}

function DropStoredAmmo( enemy, weaponData, id )
	if IsMetaUpgradeActive("StoredAmmoSlowMetaUpgrade") and enemy then
		FireWeaponFromUnit({ Weapon = "StoredAmmoSlowApplicator", Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, FireFromTarget = true })
	end

	local ammoDelay = weaponData.AmmoDropDelay or 12
	local ammoDivisor = GetTotalHeroTraitValue( "AmmoReclaimTimeDivisor" )
	if ammoDivisor == 0 then
		ammoDivisor = 1
	end
	ammoDelay = math.max(0.1, ammoDelay / ammoDivisor)
	wait( ammoDelay, RoomThreadName )
	while enemy.InSky do
		wait( 0.5, RoomThreadName )
	end

	if IsEmpty(enemy.StoredAmmo) then
		return
	end
	local ammoData = enemy.StoredAmmo[1]
	if id ~= nil then
		ammoData = nil
		for i, ammo in pairs(enemy.StoredAmmo) do
			if ammo.Id == id then
				ammoData = ammo
			end
		end
	end
	if not ammoData then
		return
	end
	ammoData.ForceMin = weaponData.DropAmmoForceMin or 75
	ammoData.ForceMax = weaponData.DropAmmoForceMax or 200
	ammoData.UpwardForceMin = 500
	ammoData.UpwardForceMax = 700
	ammoData.Angle = weaponData.Angle
	ammoData.LocationX = nil
	ammoData.LocationY = nil
	local num = 1
	if weaponData.AmmoDropNumOverride then
		num = AmmoDropNumOverride
	end

	CheckAmmoDrop( CurrentRun, enemy.ObjectId, ammoData, 1 )
	local ammoAnchors = EnemyHealthDisplayAnchors[enemy.ObjectId.."storedAmmo"]
	if not IsEmpty( ammoAnchors ) then
		local foundAmmo = false
		for i, ammoAnchorData in pairs(ammoAnchors) do
			if ammoAnchorData.Data.Id == ammoData.Id then
				Destroy({ Id = ammoAnchors[i].Id })
				EnemyHealthDisplayAnchors[enemy.ObjectId.."storedAmmo"][i] = nil
				EnemyHealthDisplayAnchors[enemy.ObjectId.."storedAmmo"] = CollapseTable(EnemyHealthDisplayAnchors[enemy.ObjectId.."storedAmmo"])
				foundAmmo = true
				break
			end
		end

		if not foundAmmo then
			Destroy({ Id = ammoAnchors[#ammoAnchors].Id })
			EnemyHealthDisplayAnchors[enemy.ObjectId.."storedAmmo"][#ammoAnchors] = nil
			EnemyHealthDisplayAnchors[enemy.ObjectId.."storedAmmo"] = CollapseTable(EnemyHealthDisplayAnchors[enemy.ObjectId.."storedAmmo"])
		end
	end
	if IsEmpty( ammoAnchors ) and enemy then
		ClearEffect({ Id = enemy.ObjectId, Name = "StoredAmmoSlowReduceDamageOutput" })
		ClearEffect({ Id = enemy.ObjectId, Name = "StoredAmmoSlow" })
	end


	if not enemy.IsDead then
		if weaponData.AmmoDropFireWeapon then
			FireWeaponFromUnit({ Weapon = weaponData.AmmoDropFireWeapon, Id = ammoData.AttackerId, DestinationId = enemy.ObjectId, AutoEquip = true, FireFromTarget = true })
		end

		for i, weaponNames in pairs(GetHeroTraitValues("AmmoDropWeapons")) do
			for s, weaponName in pairs(weaponNames) do
				FireWeaponFromUnit({ Weapon = weaponName, Id = CurrentRun.Hero.ObjectId, DestinationId = enemy.ObjectId, AutoEquip = true })
			end
		end
	end
	RemoveValueAndCollapse( enemy.StoredAmmo, ammoData )
end

function DropStoredAmmoHero( weaponData, id )
	local hero = CurrentRun.Hero
	local ammoDelay = weaponData.AmmoDropDelay or 12

	wait( ammoDelay, RoomThreadName )

	if IsEmpty(hero.StoredAmmo) then
		return
	end
	local ammoData = hero.StoredAmmo[1]
	if id ~= nil then
		ammoData = nil
		for i, ammo in pairs(hero.StoredAmmo) do
			if ammo.Id == id then
				ammoData = ammo
			end
		end
	end
	if not ammoData then
		return
	end

	CreateAnimation({ Name = "ExitWoundsFx", DestinationId = CurrentRun.Hero.ObjectId })
	ammoData.ForceMin = ammoData.ForceMin or 75
	ammoData.ForceMax = ammoData.ForceMax or 200
	ammoData.UpwardForceMin = ammoData.UpwardForceMin or 500
	ammoData.UpwardForceMax = ammoData.UpwardForceMax or 700
	ammoData.Angle = nil
	ammoData.LocationX = nil
	ammoData.LocationY = nil
	if weaponData.AmmoDropFireWeapon then
		FireWeaponFromUnit({ Weapon = weaponData.AmmoDropFireWeapon, Id = ammoData.AttackerId, DestinationId = hero.ObjectId, AutoEquip = true, FireFromTarget = true })
	end
	local ammoAnchors = ScreenAnchors.StoredAmmo
	if ammoAnchors ~= nil and ammoAnchors[#ammoAnchors] ~= nil then
		Destroy({ Id = ammoAnchors[#ammoAnchors] })
		ammoAnchors[#ammoAnchors] = nil
	end
	if #ammoAnchors == 0 then
		CastEmbeddedPresentationEnd()
	end

	RemoveValueAndCollapse( hero.StoredAmmo, ammoData )
end

function ClearStoredAmmoHero()
	local hero = CurrentRun.Hero
	if hero ~= nil and hero.StoredAmmo ~= nil then
		for i, ammoData in pairs( hero.StoredAmmo ) do 
			if ammoData.WeaponName ~= "SelfLoadAmmoApplicator" then
				hero.StoredAmmo[i] = nil
			end
		end
		hero.StoredAmmo = CollapseTable( hero.StoredAmmo )
	end
	if ScreenAnchors.StoredAmmo ~= nil then
		Destroy({ Ids = ScreenAnchors.StoredAmmo })
		ScreenAnchors.StoredAmmo = nil
	end

	thread( CastEmbeddedPresentationEnd )
end

OnWeaponCharging{
    function( triggerArgs )

		local weaponData = WeaponData[triggerArgs.name]
		if weaponData == nil then
			return
		end
		if weaponData.RushOverride then
			for i, rushWeaponName in pairs(WeaponSets.HeroRushWeapons) do
				SetWeaponProperty({ WeaponName = rushWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
			end
		end
		thread( DoWeaponChargeRumble, weaponData )
		for i, traitData in pairs( GetHeroTraitValues("OnWeaponChargeFunctions")) do
			if ( traitData.ValidWeapons == nil or Contains(traitData.ValidWeapons, triggerArgs.name )) and traitData.FunctionName and _G[traitData.FunctionName] then
				thread( _G[traitData.FunctionName], weaponData, traitData.FunctionArgs )
			end
		end
    end
}

OnWeaponChargeCanceled{
	function( triggerArgs )
		local weaponData = GetWeaponData( triggerArgs.OwnerTable, triggerArgs.name )
		if weaponData == nil then
			return
		end

		thread( DoCameraMotion, weaponData.ChargeCancelCameraMotion )

		if weaponData.RushOverride then
			for i, rushWeaponName in pairs(WeaponSets.HeroRushWeapons) do
				SetWeaponProperty({ WeaponName = rushWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
			end
		end

		StopWeaponSounds( "ChargeCancel", weaponData.Sounds, triggerArgs.OwnerTable )

		if weaponData.Name == "SwordParry" and not triggerArgs.OnCooldown and CurrentRun.CurrentRoom.RecallObstacleId then
			Destroy({ Id = CurrentRun.CurrentRoom.RecallObstacleId })
			CurrentRun.CurrentRoom.RecallObstacleId = nil
			CurrentRun.CurrentRoom.LastTeleport = nil
		end
	end
}

OnPerfectChargeWindowEntered{
	function( triggerArgs )

		Flash({ Id = triggerArgs.OwnerTable.ObjectId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.2 })
		PlaySound({ Name = "/SFX/Player Sounds/ZagreusBowCriticalTimingFlash", Id = triggerArgs.OwnerTable.ObjectId })

		local weaponData = WeaponData[triggerArgs.name]
		if weaponData == nil then
			return
		end

	end
}

OnWeaponFired{
	function( triggerArgs )

        if triggerArgs.OwnerTable.ObjectId == CurrentRun.Hero.ObjectId then
            CheckPlayerOnFirePowers( triggerArgs )
        end

        -- chaos curse effects
		if triggerArgs.OwnerTable == CurrentRun.Hero and not CurrentRun.Hero.Frozen then
			for i, data in pairs(GetHeroTraitValues("DamageOnFireWeapons")) do
				if Contains( data.WeaponNames, triggerArgs.name ) then
					thread( PlayVoiceLines, HeroVoiceLines.SelfDamageVoiceLines, false )
					SacrificeHealth({SacrificeHealthMin = data.Damage, SacrificeHealthMax = data.Damage, MinHealth = 1 })
					if CurrentRun.CurrentRoom.Encounter ~= nil then
						CurrentRun.CurrentRoom.Encounter.TookChaosCurseDamage = true
					end
				end
			end
		end
		local weaponData = GetWeaponData(triggerArgs.OwnerTable, triggerArgs.name)
		if weaponData == nil then
			return
		end

		CurrentRun.WeaponsFiredRecord[weaponData.Name] = (CurrentRun.WeaponsFiredRecord[weaponData.Name] or 0) + 1

		if triggerArgs.ProjectileName and ProjectileData[triggerArgs.ProjectileName] and ProjectileData[triggerArgs.ProjectileName].CarriesSpawns then
			CurrentRun.CurrentRoom.ProjectilesCarryingSpawns = (CurrentRun.CurrentRoom.ProjectilesCarryingSpawns or 0) + 1
			notifyExistingWaiters( "RequiredKillEnemyKilledOrSpawned" )
		end
		if weaponData.RushOverride then
			for i, rushWeaponName in pairs( WeaponSets.HeroRushWeapons ) do
				SetWeaponProperty({ WeaponName = rushWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
			end
		end
		RemoveCritWeapons( triggerArgs.name)
		thread( DoCameraMotion, weaponData.FireCameraMotion )
		thread( DoWeaponScreenshake, weaponData.FireScreenshake, CurrentRun.Hero.ObjectId, triggerArgs.SourceProjectile )

		if triggerArgs.IsPerfectCharge then
			CreateAnimation({ Name = "PerfectShotShroud", UseScreenLocation = true, OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, GroupName = "Combat_UI_World_Add" })
			CreateAnimation({ Name = "PerfectShotShroud_Dark", UseScreenLocation = true, OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, GroupName = "Combat_UI_World" })
		end


		if weaponData.Sounds ~= nil and weaponData.Sounds.FireSounds ~= nil then
			if triggerArgs.IsPerfectCharge then
				DoWeaponSounds( weaponData.Sounds.FireSounds.PerfectChargeSounds, triggerArgs.OwnerTable, weaponData )
			else
				DoWeaponSounds( weaponData.Sounds.FireSounds.ImperfectChargeSounds, triggerArgs.OwnerTable, weaponData )
			end

			if IsLoadedVolley( triggerArgs.OwnerTable, triggerArgs.name, triggerArgs.Volley ) then
				DoWeaponSounds( weaponData.Sounds.FireSounds.LoadedSounds, triggerArgs.OwnerTable, weaponData )
			end

			if weaponData.Sounds.LowAmmoFireSounds ~= nil and triggerArgs.Ammo < weaponData.LowAmmoSoundThreshold then
				DoWeaponSounds( weaponData.Sounds.LowAmmoFireSounds, triggerArgs.OwnerTable, weaponData )
			else
				DoWeaponSounds( weaponData.Sounds.FireSounds, triggerArgs.OwnerTable, weaponData )
			end
		end
		StopWeaponSounds( "Fired", weaponData.Sounds, triggerArgs.OwnerTable )

		thread( DoWeaponFireSimulationSlow, weaponData )
		thread( DoWeaponFireRumble, weaponData )
		thread( DoWeaponFireRadialBlur, weaponData )

		if weaponData.OnFireCrowdReaction ~= nil then
			thread( CrowdReactionPresentation, weaponData.OnFireCrowdReaction )
		end

		thread( MarkObjectiveComplete, weaponData.CompleteObjectiveOnFire or triggerArgs.name )
		thread( MarkObjectivesComplete, weaponData.CompleteObjectivesOnFire )

		if triggerArgs.IsPerfectCharge then
			thread(MarkObjectiveComplete, "PerfectCharge")
		end

		if triggerArgs.Ammo == 0 and weaponData.OutOfAmmoFunctionName ~= nil then
			local outofAmmoFunction = _G[weaponData.OutOfAmmoFunctionName]
			if outofAmmoFunction ~= nil then
				outofAmmoFunction( triggerArgs.OwnerTable, weaponData )
			end
		end

		if weaponData.FiredHeroVoiceLines ~= nil then
			thread( PlayVoiceLines, HeroVoiceLines[weaponData.FiredHeroVoiceLines], true )
		end

		if weaponData.OnFiredFunctionName ~= nil then
			local onFiredFunction = _G[weaponData.OnFiredFunctionName]
			if onFiredFunction ~= nil then
				thread( onFiredFunction, triggerArgs.OwnerTable, weaponData, weaponData.OnFiredFunctionArgs )
			end
		end

		for i, traitData in pairs( GetHeroTraitValues("OnWeaponFiredFunctions")) do
			if ( traitData.ValidWeapons == nil or Contains(traitData.ValidWeapons, triggerArgs.name )) and traitData.FunctionName and _G[traitData.FunctionName] then
				thread( _G[traitData.FunctionName], weaponData, traitData.FunctionArgs )
			end
		end

	end
}

function AddPlaceholderEnemyCount()
	MapState.PlaceholderEnemyCount = (MapState.PlaceholderEnemyCount or 0) + 1
	wait( 3.0, RoomThreadName )
	MapState.PlaceholderEnemyCount = MapState.PlaceholderEnemyCount - 1
end


function GetPlayerAngle()
	local playerAngleDegrees = GetAngle({ Id = CurrentRun.Hero.ObjectId })
	return playerAngleDegrees
end



OnWeaponCharging{ "SpearWeaponSpin",
	function( triggerArgs )
		DoSpearCharge()
	end
}

function DoSpearCharge()
	local spearDisplayOffsetY = -240
	thread( DoRumble, {{ RightFraction = 0.17, Duration = 0.3 }} )

	local spearWeaponStages =
	{
		{ OverrideFire = "SpearWeaponSpin2", Wait = 0.33 },
		{ OverrideFire = "SpearWeaponSpin3", Wait = 0.66 },
	}

	if HeroHasTrait( "SpearSpinChargeLevelTime" ) then
		spearWeaponStages =
			{
				{ OverrideFire = "SpearWeaponSpin2", Wait = 0.15 },
				{ OverrideFire = "SpearWeaponSpin3", Wait = 0.30 },
			}
	end

	local notifyName = "EmptySpearCharge"
	local stageReached = 0
	local maxStage = #spearWeaponStages
	for stage = 1, maxStage do
		local stageData = spearWeaponStages[stage]

		NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = "SpearWeaponSpin", ChargeFraction = 0.0, Comparison = "<=", Timeout = stageData.Wait })
		waitUntil( notifyName )
		if not _eventTimeoutRecord[notifyName] then
			EmptySpearCharge( stageReached )
			return
		end

		PlaySound({ Name = "/Leftovers/SFX/AuraOnLoud" })
		Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 4, MinFraction = 0.5, MaxFraction = 0.6, Color = Color.White, Duration = 0.3 })
		local updateString = tostring(stage + 1)
		if stage == maxStage then
			WeaponData.SpearWeaponSpin.MaxChargeText.TargetId = CurrentRun.Hero.ObjectId
			thread( InCombatTextArgs, WeaponData.SpearWeaponSpin.MaxChargeText )
		end
		thread( DoRumble, {{ RightFraction = 0.17, Duration = 0.3 }} )

		OverrideWeaponFire({ Id = CurrentRun.Hero.ObjectId, InitialWeaponName = "SpearWeaponSpin", OverrideWeaponName = stageData.OverrideFire })
		stageReached = stage
	end

	NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = "SpearWeaponSpin", ChargeFraction = 0.0, Comparison = "<=" })
	waitUntil( notifyName )

	EmptySpearCharge( stageReached )

end

function EmptySpearCharge( stageReached )
	if stageReached >= 1 then
		Rumble({ RightFraction = 0.7, Duration = 0.3 })
	end
	OverrideWeaponFire({ Id = CurrentRun.Hero.ObjectId, InitialWeaponName = "SpearWeaponSpin", OverrideWeaponName = nil })
end

OnWeaponCharging{ "BowWeapon BowWeaponDash",
	function( triggerArgs )
		if HeroHasTrait("BowBondTrait") then
		--	DoBowCharge()
		end
	end
}

OnWeaponFired{ "BowWeapon BowWeaponDash",
	function( triggerArgs )
		if HeroHasTrait("BowBondTrait") then
		--	EmptyBowCharge( math.floor( CurrentRun.CurrentRoom.ChargeTicksReached / 10 ) )
		--	CurrentRun.CurrentRoom.BowCharging = false
		end
	end
}
OnWeaponFired{ "ShieldThrow ShieldThrowDash",
	function( triggerArgs )
		if HeroHasTrait("ShieldThrowEmpowerTrait") then
			CurrentRun.CurrentRoom.ShieldThrowHits = 0
		end
	end
}
function DoBowChargeX()
	if CurrentRun.CurrentRoom.BowCharging then
		return
	end

	local tickRate = 0.1
	local ticksPerStage = 10
	local maxStage = 2

	wait(0.1, RoomThreadName )
	CurrentRun.CurrentRoom.BowCharging = true
	CurrentRun.CurrentRoom.ChargeTicksReached = CurrentRun.CurrentRoom.ChargeTicksReached or 0
	SetWeaponProperty({ WeaponName = "RushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "FireGraphic", Value = "ZagreusBowDashFireEndLoop" })
	SetWeaponProperty({ WeaponName = "RushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "PostBlinkAnim", Value = "ZagreusBowDashFireEndLoop" })
	while GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = "BowWeapon", Property = "Charging" }) do
		local stage = math.floor( CurrentRun.CurrentRoom.ChargeTicksReached / ticksPerStage )
		if CurrentRun.CurrentRoom.ChargeTicksReached % ticksPerStage == 0 then
			PlaySound({ Name = "/Leftovers/SFX/AuraOnLoud" })
			Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 4, MinFraction = 0.5, MaxFraction = 0.6, Color = Color.White, Duration = 0.3 })
			local updateString = tostring(stage + 1)
			if stage == maxStage then
				if  CheckCooldown("MaxCharge", 1.0) then
					WeaponData.SpearWeaponSpin.MaxChargeText.TargetId = CurrentRun.Hero.ObjectId
					thread( InCombatTextArgs, WeaponData.SpearWeaponSpin.MaxChargeText )
				end
			elseif stage > 0 then
				thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = updateString, Duration = 1.0 })
			end
			Rumble({ LeftFraction = 0.45, Duration = 0.3 })

			local stageScaleModifier = 0.6
			SetWeaponProperty({ WeaponName = "BowWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectileWaves", Value = 1 + stage })
			SetProjectileProperty({ WeaponName = "BowWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "Scale", Value = 1 + stage * stageScaleModifier })
			SetProjectileProperty({ WeaponName = "BowWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "ExtentScale", Value = 1 + stage * 0.25 })

		end
		if stage ~= maxStage then
			CurrentRun.CurrentRoom.ChargeTicksReached = CurrentRun.CurrentRoom.ChargeTicksReached + 1
		end
		wait(tickRate, RoomThreadName)
	end
	CurrentRun.CurrentRoom.BowCharging = false
end

function EmptyBowChargeX( stageReached )
	if stageReached >= 1 then
		Rumble({ RightFraction = 0.7, Duration = 0.3 })
		FireWeaponFromUnit({ Weapon = "ChargeBowWeapon1", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	end
	if stageReached >= 2 then
		FireWeaponFromUnit({ Weapon = "MaxChargeBowWeapon", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	end
	SetWeaponProperty({ WeaponName = "BowWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectileWaves", Value = 1 })
	SetProjectileProperty({ WeaponName = "BowWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "Scale", Value = 1 })
	SetProjectileProperty({ WeaponName = "BowWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "ExtentScale", Value = 1 })
	SetWeaponProperty({ WeaponName = "RushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "FireGraphic", Value = "ZagreusDashNoCollide" })
	SetWeaponProperty({ WeaponName = "RushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "PostBlinkAnim", Value = "null" })
	CurrentRun.CurrentRoom.ChargeTicksReached = 0
end

function DoBowCharge()
	if CurrentRun.CurrentRoom.BowCharging then
		return
	end

	local tickRate = 0.02
	local ticksPerStage = 1
	local maxStage = 30

	wait(0.02, RoomThreadName )
	CurrentRun.CurrentRoom.BowCharging = true
	CurrentRun.CurrentRoom.ChargeTicksReached = CurrentRun.CurrentRoom.ChargeTicksReached or 0
	while GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = "BowWeapon", Property = "Charging" }) or GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = "BowWeaponDash", Property = "Charging" }) do
		local stage = math.floor( CurrentRun.CurrentRoom.ChargeTicksReached / ticksPerStage )
		--if CurrentRun.CurrentRoom.ChargeTicksReached % ticksPerStage == 0 then
			local stageScaleModifier = 0.1
			SetProjectileProperty({ WeaponName = "BowWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "Scale", Value = 1 + stage * stageScaleModifier })
			SetProjectileProperty({ WeaponName = "BowWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "ExtentScale", Value = 1 + stage * 0.25 })
			SetProjectileProperty({ WeaponName = "BowWeaponDash", DestinationId = CurrentRun.Hero.ObjectId, Property = "Scale", Value = 1 + stage * stageScaleModifier })
			SetProjectileProperty({ WeaponName = "BowWeaponDash", DestinationId = CurrentRun.Hero.ObjectId, Property = "ExtentScale", Value = 1 + stage * 0.25 })
		--end
		if stage ~= maxStage then
			CurrentRun.CurrentRoom.ChargeTicksReached = CurrentRun.CurrentRoom.ChargeTicksReached + 1
		end
		wait(tickRate, RoomThreadName)
	end
	CurrentRun.CurrentRoom.BowCharging = false
end

function EmptyBowCharge( stageReached )
	SetProjectileProperty({ WeaponName = "BowWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "Scale", Value = 1 })
	SetProjectileProperty({ WeaponName = "BowWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "ExtentScale", Value = 1 })
	SetProjectileProperty({ WeaponName = "BowWeaponDash", DestinationId = CurrentRun.Hero.ObjectId, Property = "Scale", Value = 1 })
	SetProjectileProperty({ WeaponName = "BowWeaponDash", DestinationId = CurrentRun.Hero.ObjectId, Property = "ExtentScale", Value = 1 })
	CurrentRun.CurrentRoom.ChargeTicksReached = 0
end


function CleanupEnemies()
	for enemyId, enemy in pairs( ActiveEnemies ) do
		CleanupEnemy( enemy )
	end
	ActiveEnemies = {}
	RequiredKillEnemies = {}
	ActiveGroupAIs = {}
	SurroundEnemiesAttacking = {}
	MapState.LeapPointsOccupied = {}
	for obstacleId, obstacle in pairs( MapState.ActiveObstacles ) do
		if obstacle.AIThreadName ~= nil then
			killTaggedThreads( obstacle.AIThreadName )
		end
		if obstacle.AINotifyName ~= nil then
			killWaitUntilThreads( obstacle.AINotifyName )
		end
	end
end

function CleanupEnemy( enemy )
	killTaggedThreads( "EnemyHealthBarFalloff"..enemy.ObjectId )
	killTaggedThreads( enemy.AIThreadName )
	killWaitUntilThreads( enemy.AINotifyName )
	FinishTargetMarker( enemy )
	if enemy.DisplayAttackTimer and enemy.AttackTimerId ~= nil then
		Destroy({ Id = enemy.AttackTimerId })
	end
	if enemy.ReloadSoundId ~= nil then
		StopSound({ Id = enemy.ReloadSoundId, Duration = 0.2 })
	end
	if enemy.PreAttackLoopingSoundId ~= nil then
		StopSound({ Id = enemy.PreAttackLoopingSoundId, Duration = 0.2 })
	end
	RemoveEnemyUI( enemy )
	SurroundEnemiesAttacking[enemy.ObjectId] = nil
	killWaitUntilThreads( enemy.SpawnPointThread )
	if enemy.OccupyingSpawnPointId ~= nil then
		UnoccupySpawnPoint(enemy.OccupyingSpawnPointId)
	end
	if enemy.PickupTarget ~= nil then
		if enemy.PickupTarget.PickupFailedAnimation ~= nil then
			SetAnimation({ Name = enemy.PickupTarget.PickupFailedAnimation, DestinationId = enemy.PickupTarget.ObjectId })
		end
		enemy.PickupTarget = nil
	end
	if enemy.CleanupAnimation ~= nil then
		SetAnimation({ Name = enemy.CleanupAnimation, DestinationId = enemy.ObjectId })
	end
end

OnHit{
	function( triggerArgs )
		local attacker = triggerArgs.AttackerTable
		local attackerId = triggerArgs.AttackerId
		local attackerName = triggerArgs.AttackerName
		local attackerWeaponName = triggerArgs.SourceWeapon
		triggerArgs.AttackerWeaponData = GetWeaponData(attacker, attackerWeaponName)
		local attackerWeaponData = triggerArgs.AttackerWeaponData
		local victim = triggerArgs.TriggeredByTable
		local victimName = triggerArgs.name
		local victimId = triggerArgs.triggeredById

		if victim ~= nil then

			if victim.UseableOnHit then
				UseableOn({ Id = victimId })
			end
			if victim.OnHitAnimation ~= nil then
				SetAnimation({ DestinationId = victimId, Name = victim.OnHitAnimation })
			end
			if victim.FirstOnHitSound ~= nil and victim.FirstOnHitSoundPlayed == nil then
				PlaySound({ Name = victim.FirstOnHitSound, Id = victimId })
				victim.FirstOnHitSoundPlayed = true
			end

			if victim.OnHitShake and not victim.OnHitShakeDisabled then
				victim.OnHitShake.Id = victim.ObjectId
				if victim.OnHitShake.RequireAttackerNames == nil or (attacker ~= nil and attacker.Name ~= nil and Contains(victim.OnHitShake.RequireAttackerNames, attacker.Name)) then
					thread( OnHitShakePresentation, victim.OnHitShake )
				end
			end

			if CheckImpactReaction( attackerWeaponData, victim ) then
				DoReaction( victim, victim.ImpactReaction )
			end

			thread( CheckOnHitPowers, victim, attacker, triggerArgs )

			if victim.OnHitForcedWeapon ~= nil and CheckCooldown("OnHitForcedWeapon"..victim.ObjectId, victim.OnHitForcedWeaponCooldown or 0) then
				victim.ForcedWeaponInterrupt = victim.OnHitForcedWeapon
			end

			if triggerArgs.IsInvulnerable and not victim.SkipInvulnerableOnHitPresentation then
				if not victim.IsDead and victim.HitInvulnerableText and victim ~= nil and victim.AIBehavior ~= nil and attackerWeaponData ~= nil and not attackerWeaponData.NoHitInvulnerableText and triggerArgs.DealsDamageOrControlEffect then
					-- Enemy must be fully spawned and active
					if CheckCooldown( "HitInvulnerableText", 0.25) then
						thread( InCombatText, victimId, victim.HitInvulnerableText, 0.4, { SkipShadow = true } )
					end
					if attacker ~= nil and attacker.HitInvulnerableVoiceLines and not attacker.IsDead then
						thread( PlayVoiceLines, attacker.HitInvulnerableVoiceLines, true, attacker )
					end
				end

				if victim.InvulnerableVoiceLines then
					thread( PlayVoiceLines, victim.InvulnerableVoiceLines, nil, victim )
				end
				if victim.InvulnerableHitSound ~= nil then
					PlaySound({ Name = victim.InvulnerableHitSound, Id = victim.ObjectId })
				end
				if victim.RepulseOnMeleeInvulnerableHit and attackerWeaponName ~= nil and triggerArgs.EffectName == nil then
					local repulsed = false
					if Contains( WeaponSets.HeroMeleeRangeWeapons, attackerWeaponName ) then
						local distanceToPlayer = GetDistance({ Id = victim.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
						if distanceToPlayer < victim.RepulseOnMeleeInvulnerableHit then
							RepulseFromObject( victim, { Scale = victim.InvincibubbleScale } )
							repulsed = true
						end
					end
					if not repulsed and not victim.IgnoreInvincibubbleOnHit then
						ShowInvincibubbleOnObject( victim, { Scale = victim.InvincibubbleScale } )
					end
				elseif victim.AlwaysShowInvulnerabubbleOnInvulnerableHit then
					ShowInvincibubbleOnObject( victim, { Scale = victim.InvincibubbleScale } )
				end
			end

			if victim.IsInvisible then
				if victim.InvisibilityOnHitFx ~= nil then
					CreateAnimation({ Name = victim.InvisibilityOnHitFx, DestinationId = victim.ObjectId })
				end

				if victim.InvisibilityAlphaFlashOnHit then
					InvisibleAlphaFlash(victim, 0.5)
				end
			end

			if victim.OnHitVoiceLines ~= nil or (victim.OnHitByWeaponVoiceLines ~= nil and victim.OnHitByWeaponVoiceLines[attackerWeaponName] ~= nil) then
				thread( QueueOnHitVoiceLines, victim, triggerArgs )
			end
			if victim == CurrentRun.Hero and not triggerArgs.InvulnerableFromCoverage then
				if HeroHasTrait("ShieldHitTrait") and triggerArgs.DealsDamageOrControlEffect and not ( victim == attacker and ( not attackerWeaponData or attackerWeaponData.SelfMultiplier == 0 )) then
					-- Player hit
					local tempInvulnerabilityTrait = nil
					for k, currentTrait in pairs( CurrentRun.Hero.Traits ) do
						if currentTrait.Name == "ShieldHitTrait" and IsOnlyInvulnerableSource("TraitInvulnerability") then
							tempInvulnerabilityTrait = currentTrait
						end
					end

					if tempInvulnerabilityTrait ~= nil and IsTraitActive( tempInvulnerabilityTrait ) then
						triggerArgs.IsInvulnerable = true
						PutTraitOnCooldown( tempInvulnerabilityTrait )
						thread( VulnerableAfterDelay, 1 )
					end
				end
			else
				-- Enemy hit
				if victim.CanBeAggroed and victim.IsAggroed == false and attackerId == CurrentRun.Hero.ObjectId then
					thread( AggroUnit, victim )
				end
			end

			if victim.OnHitFunctionName ~= nil then
				local onHitFunction = _G[victim.OnHitFunctionName]
				if onHitFunction ~= nil then
					thread( onHitFunction, victim )
				end
			end
		end

		if victim == CurrentRun.Hero and triggerArgs.DamageAmount ~= nil and triggerArgs.DamageAmount > 0 and not triggerArgs.IsInvulnerable and not triggerArgs.InvulnerableFromCoverage and CurrentRun.Hero.HitShields and CurrentRun.Hero.HitShields > 0  and attackerName and EnemyData[attackerName] and ( EnemyData[attackerName].DamageType ~= "Neutral" or EnemyData[attackerName].IsBossDamage ) then
			CurrentRun.Hero.HitShields = CurrentRun.Hero.HitShields - 1
			thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "HitShields", Duration = 1.0 } )
			PlaySound({ Name = "/SFX/EurydiceKeepsakeProc", Id = CurrentRun.Hero.ObjectId })
			if CurrentRun.Hero.HitShields <= 0 then
				ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "EurydiceDefenseEffect"})
				PlaySound({ Name = "/Leftovers/SFX/PlayerProjectileDeflect", Id = CurrentRun.Hero.ObjectId })
				thread( PlayVoiceLines, HeroVoiceLines.ShieldDepletedVoiceLines, true )
			end

			local traitData = GetExistingUITraitName( "ShieldBossTrait" )
			if traitData then
				UpdateTraitNumber( traitData )
			end

			return
		end

		if triggerArgs.EffectName == nil then
			thread( DoImpactSound, triggerArgs )
		end
		if attackerWeaponData ~= nil and attackerWeaponData.OnHitFunctionNames ~= nil and not triggerArgs.IsInvulnerable then
			for k, functionName in pairs( attackerWeaponData.OnHitFunctionNames ) do
				local onHitFunction = _G[functionName]
				thread( onHitFunction, victim, victimId, triggerArgs )
			end
		end

		if triggerArgs.DamageAmount ~= nil and triggerArgs.DamageAmount > 0 then
			Damage( victim, triggerArgs )
		end

		if victim ~= nil and victim.TetherIds ~= nil and not victim.IsDead then
			for k, tetherId in ipairs( victim.TetherIds ) do
				if victim.Tethers[k] ~= nil and victim.Tethers[k].OwnerHitVelocity ~= nil then
					ApplyForce({ Id = tetherId, Speed = victim.Tethers[k].OwnerHitVelocity, Angle = RandomFloat( 0, 360 ) })
				end
			end
		end

		if victim.OnHitCrowdReaction ~= nil and CheckCooldown( victim.ObjectId.."Reaction", victim.OnHitCrowdReaction.Cooldown or 1.0 ) then
			if victim.OnHitCrowdReaction.RequireAttackerNames == nil or (attacker ~= nil and attacker.Name ~= nil and Contains(victim.OnHitCrowdReaction.RequireAttackerNames, attacker.Name)) then
				thread(CrowdReactionPresentation, victim.OnHitCrowdReaction)
			end
		end

	end
}

function QueueOnHitVoiceLines( victim, triggerArgs )

	if victim.OnHitVoiceLinesRequireAttackerName ~= nil and triggerArgs.AttackerName ~= victim.OnHitVoiceLinesRequireAttackerName then
		return
	end

	local threadName = "OnHitVO"..victim.ObjectId
	if victim.OnHitVoiceLinesQueueDelay ~= nil and SetThreadWait( threadName, victim.OnHitVoiceLinesQueueDelay ) then
		return
	end
	wait( victim.OnHitVoiceLinesQueueDelay, threadName )

	if victim.Dead then
		return
	end

	if victim.OnHitByWeaponVoiceLines ~= nil and victim.OnHitByWeaponVoiceLines[triggerArgs.SourceWeapon] ~= nil then
		PlayVoiceLines( victim.OnHitByWeaponVoiceLines[triggerArgs.SourceWeapon], true, victim )
	elseif victim.OnHitVoiceLines ~= nil then
		PlayVoiceLines( victim.OnHitVoiceLines, true, victim )
	end

end

OnProjectileDeath{
	function( triggerArgs )

		local victimId = triggerArgs.triggeredById
		local victim = triggerArgs.TriggeredByTable
		local attacker = triggerArgs.AttackerTable
		local weaponData = GetWeaponData( attacker, triggerArgs.WeaponName)
		local projectileData = ProjectileData[triggerArgs.name]
		TryUnloadAmmo( triggerArgs.WeaponName, victim, attacker, triggerArgs )

		if weaponData ~= nil then
			local storeInUnit = victim
			local storeInUnitId = victimId
			if storeInUnit == nil and projectileData ~= nil and projectileData.StoreAmmoInLastHit and triggerArgs.LastHitUnitTable ~= nil then
				storeInUnit = triggerArgs.LastHitUnitTable
				storeInUnitId = storeInUnit.ObjectId
			end
			if storeInUnit ~= nil and storeInUnit.ObjectId == nil then
				storeInUnit.ObjectId = storeInUnitId
			end


			if weaponData.StoreAmmoOnHit ~= nil and weaponData.StoreAmmoOnHit > 0 and not triggerArgs.IsDeflected then
				if projectileData == nil or ( not projectileData.NeverStore and ( not projectileData.StoreInFirstHit and triggerArgs.FireIndex == 0 ) or ( projectileData.StoreInFirstHit and triggerArgs.LastProjectileDeath )) then
					if projectileData ~= nil and projectileData.StoreInFirstHit then
						storeInUnit = triggerArgs.FirstUnitInVolley
					end

					local storedAmmo = nil
					if storeInUnit == nil then
						storedAmmo = {}
					else
						if storeInUnit.StoredAmmo == nil then
							storeInUnit.StoredAmmo = {}
						end
						storedAmmo = {}
						table.insert( storeInUnit.StoredAmmo, storedAmmo )
					end

					storedAmmo.Count = storedAmmo.Count or 0
					storedAmmo.Count = storedAmmo.Count + weaponData.StoreAmmoOnHit
					storedAmmo.AttackerId = attacker.ObjectId
					storedAmmo.WeaponName = weaponData.Name
					storedAmmo.Id = _worldTime
					if storeInUnit == nil or storeInUnit.IsDead or not storeInUnit.CanStoreAmmo or triggerArgs.InvulnerableImpact or ( weaponData.Name == "RangedWeapon" and HeroHasTrait("ShieldLoadAmmoTrait")) then
						if storeInUnit ~= nil and storeInUnit.ObjectId == CurrentRun.Hero.ObjectId then
							RemoveValueAndCollapse( storeInUnit.StoredAmmo, storedAmmo )
						elseif projectileData == nil or not projectileData.SpawnedProjectile or triggerArgs.FireIndex == 0 then
							-- Drop immediately if no victim to store this on or victim can never be killed or already was
							storedAmmo.LocationX = triggerArgs.LocationX
							storedAmmo.LocationY = triggerArgs.LocationY
							if projectileData ~= nil then
								if triggerArgs.KilledVictim then
									storedAmmo.ForceMin = projectileData.AmmoDropKillForceMin
									storedAmmo.ForceMax = projectileData.AmmoDropKillForceMax
								else
									storedAmmo.ForceMin = projectileData.AmmoDropForceMin
									storedAmmo.ForceMax = projectileData.AmmoDropForceMax
								end

								if triggerArgs.KilledVictim then
									storedAmmo.UpwardForceMin = projectileData.AmmoDropKillUpwardForceMin
									storedAmmo.UpwardForceMax = projectileData.AmmoDropKillUpwardForceMax
								else
									storedAmmo.UpwardForceMin = projectileData.AmmoDropUpwardForceMin
									storedAmmo.UpwardForceMax = projectileData.AmmoDropUpwardForceMax
								end
								if HeroHasTrait("ShieldLoadAmmoTrait") and not triggerArgs.KilledVictim then
									local ammoDropVelocityData = {}
									for i, traitData in pairs(CurrentRun.Hero.Traits) do
										if traitData.Name == "ShieldLoadAmmoTrait" and traitData.AmmoDropData then
											storedAmmo.ForceMin = traitData.AmmoDropData.AmmoDropForceMin or storedAmmo.ForceMin
											storedAmmo.ForceMax = traitData.AmmoDropData.AmmoDropForceMax or storedAmmo.ForceMax
											storedAmmo.UpwardForceMin = traitData.AmmoDropData.AmmoDropUpwardForceMin or storedAmmo.UpwardForceMin
											storedAmmo.UpwardForceMax = traitData.AmmoDropData.AmmoDropUpwardForceMax or storedAmmo.UpwardForceMax
										end
									end
								end

								if projectileData.AmmoDropDistance then
									local offset = CalcOffset( math.rad(triggerArgs.Angle), projectileData.AmmoDropDistance )
									storedAmmo.LocationX = storedAmmo.LocationX + offset.X
									storedAmmo.LocationY = storedAmmo.LocationY + offset.Y
								end
							end
							storedAmmo.Angle = triggerArgs.Angle

							if not weaponData.SkipAmmoDropOnMiss then
								local droppedAmmo = 1
								CheckAmmoDrop( CurrentRun, storeInUnitId, storedAmmo, droppedAmmo )

								if storeInUnit ~= nil then								
									RemoveValueAndCollapse( storeInUnit.StoredAmmo, storedAmmo )
								end
							elseif weaponData.AmmoDropFireWeapon and not attacker.InTransition then
								if storeInUnit ~= nil then								
									RemoveValueAndCollapse( storeInUnit.StoredAmmo, storedAmmo )
								end
								local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = storedAmmo.LocationX, LocationY = storedAmmo.LocationY })
								FireWeaponFromUnit({ Weapon = weaponData.AmmoDropFireWeapon, Id = attacker.ObjectId, DestinationId = dropLocation, AutoEquip = true, FireFromTarget = true })
								Destroy({Id = dropLocation })
							end
						end
					else
						-- Stored in the victim for later extraction or dropped on death
						if storeInUnit.UseBossHealthBar then
							local screenId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu", DestinationId = EnemyHealthDisplayAnchors[storeInUnit.ObjectId] })
							local offsetX = 330
							if storeInUnit.BarXScale then
								offsetX = offsetX * storeInUnit.BarXScale
							end
							local offsetY = -30
							if EnemyHealthDisplayAnchors[storeInUnit.ObjectId] ~= nil then
								SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = screenId })
								EnemyHealthDisplayAnchors[storeInUnit.ObjectId.."storedAmmo"] = EnemyHealthDisplayAnchors[storeInUnit.ObjectId.."storedAmmo"] or {}
								table.insert( EnemyHealthDisplayAnchors[storeInUnit.ObjectId.."storedAmmo"], { Data = storedAmmo, Id = screenId })
								SetAnimation({ Name = "AmmoEmbeddedInEnemyIcon", DestinationId = screenId })

								local numAmmo = #EnemyHealthDisplayAnchors[storeInUnit.ObjectId.."storedAmmo"]
								for i = 1, numAmmo do
									local offsetX = 330  * storeInUnit.BarXScale - i * 22

									Attach({ Id = EnemyHealthDisplayAnchors[storeInUnit.ObjectId.."storedAmmo"][i].Id, DestinationId = EnemyHealthDisplayAnchors[storeInUnit.ObjectId], OffsetX = offsetX, OffsetY = offsetY })
								end
							end
						elseif storeInUnit.ObjectId == CurrentRun.Hero.ObjectId then
							
							DebugPrint({Text = " drop hero 2"})
							local offsetX = 350
							local offsetY = -50
							ScreenAnchors.StoredAmmo =  ScreenAnchors.StoredAmmo or {}
							offsetX = offsetX - ( #ScreenAnchors.StoredAmmo * 22 )
							local screenId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu", DestinationId = ScreenAnchors.HealthBack, X = 10 + offsetX, Y = ScreenHeight - 50 + offsetY })
							SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = { Data = storedAmmo, Id = screenId } })

							table.insert( ScreenAnchors.StoredAmmo, screenId )
							SetAnimation({ Name = "AmmoEmbeddedInPlayerIcon", DestinationId = screenId })

							CastEmbeddedPresentationStart()
							thread( DropStoredAmmoHero, weaponData, storedAmmo.Id )
							return
						else
							AddStoredAmmoIcon( storeInUnit, storedAmmo, weaponData )
						end


						thread( DropStoredAmmo, storeInUnit, weaponData, storedAmmo.Id )
					end
				end
			end
		end

		if weaponData ~= nil and triggerArgs.IsDeflected and weaponData.FireAmmoDropWeaponOnDeflect then
			if weaponData.AmmoDropFireWeapon and not attacker.InTransition then
				local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY })
				FireWeaponFromUnit({ Weapon = weaponData.AmmoDropFireWeapon, Id = attacker.ObjectId, DestinationId = dropLocation, AutoEquip = true, FireFromTarget = true })
				Destroy({Id = dropLocation })
			end
		end
		if projectileData ~= nil then
			if projectileData.DeathScreenShake then
				ShakeScreen( projectileData.DeathScreenShake )
			end

			if projectileData.CarriesSpawns and CurrentRun.CurrentRoom.ProjectilesCarryingSpawns then
				DecrementTableValue(CurrentRun.CurrentRoom, "ProjectilesCarryingSpawns" )
				notifyExistingWaiters( "RequiredKillEnemyKilledOrSpawned" )
			end
		end

		if CurrentRun.Hero and attacker == CurrentRun.Hero then
			-- Remove clause after optimizations
			if HeroHasTrait("LightningCloudTrait") then
				for i, data in pairs(GetHeroTraitValues("AmmoDeathWeapon")) do
					if triggerArgs.name == data.ValidProjectileName then
						FireAmmoDeathWeapon( data, triggerArgs.LocationX, triggerArgs.LocationY )
					end
				end
			end

			for i, data in pairs(GetHeroTraitValues( "OnProjectileDeathFunction" )) do
				if data.Name and _G[data.Name] then
					_G[data.Name]( triggerArgs, data.Args )
				end
			end
		end
	end
}

function CheckImpactReaction( attackerWeaponData, victim )
	if attackerWeaponData == nil then
		return false
	end
	local victimImpactReactionData = victim.ImpactReaction
	if victimImpactReactionData == nil then
		return false
	end
	if victim.HitsTaken == nil then
		victim.HitsTaken = 0
	end
	if attackerWeaponData.ImpactReactionHitsOverride then
		victim.HitsTaken = victim.HitsTaken + attackerWeaponData.ImpactReactionHitsOverride
	else
		victim.HitsTaken = victim.HitsTaken + 1
	end
	if victimImpactReactionData.RequiredHitsForImpactReaction and victim.HitsTaken < victimImpactReactionData.RequiredHitsForImpactReaction then
		return false
	end
	return true
end



function GetMaterial( objectName, object )

	if object ~= nil and object.Material ~= nil then
		return object.Material
	end

	for nameFragment, material in pairs( MaterialDefaults ) do
		if string.match( objectName, nameFragment ) then
			return material
		end
	end

	return nil

end

function DelayedKill( victim, triggerArgs, delay )
	wait( delay, RoomThreadName )
	if ActiveEnemies[victim.ObjectId] ~= nil then
		thread( Kill, victim, triggerArgs )
	end
end

function Kill( victim, triggerArgs )

	if victim.IsDead then
		-- Already killed
		return
	end

	if CurrentRun.Hero.HandlingDeath then
		-- No one can be killed after the hero dies, they can only be cleaned up directly
		return
	end

	triggerArgs = triggerArgs or {}

	local victimName = victim.Name
	local killer = triggerArgs.AttackerTable
	local destroyerId = triggerArgs.AttackerId
	local killingWeaponName = triggerArgs.SourceWeapon
	local currentRoom = CurrentRun.CurrentRoom

	if victim.DeathForce ~= nil and triggerArgs.ImpactAngle ~= nil and triggerArgs.ImpactAngle >= 0 then
		ApplyForce({ Id = victim.ObjectId, Speed = victim.DeathForce, Angle = triggerArgs.ImpactAngle })
	end
	if victim.HaltOnDeath then
		Halt({ Id = victim.ObjectId })
		Stop({ Id = victim.ObjectId })
	end

	for i, traitData in pairs ( CurrentRun.Hero.Traits ) do
		local data = traitData.GoldBonusDrop
		if data then
			currentRoom.MoneyDropActivations = currentRoom.MoneyDropActivations or 0
			if currentRoom.MoneyDropActivations < data.RoomCap and data.RequiredEffect and (( victim.ActiveEffects and victim.ActiveEffects[data.RequiredEffect] ) or (victim.ActiveEffectsAtDamageStart and victim.ActiveEffectsAtDamageStart[data.RequiredEffect] )) then
				currentRoom.MoneyDropActivations = currentRoom.MoneyDropActivations + 1
				CheckMoneyDrop( CurrentRun, currentRoom, victim, { Chance = 1, IgnoreRoomMoneyStore = true, MinParcels =1, MaxParcels = 1, MinValue = data.Amount, MaxValue = data.Amount} )
				CreateAnimation({ Name = "MoneyShower", DestinationId = victim.ObjectId })
			end

			if currentRoom.MoneyDropActivations >= data.RoomCap then
				TraitUIDeactivateTrait( traitData )
			end
		end
	end

	if victim.KillingWeaponBlockDeathWeapons ~= nil and Contains(victim.KillingWeaponBlockDeathWeapons , killingWeaponName) then
		SetUnitProperty({ Property = "OnDeathWeapon", Value = "null", DestinationId = victim.ObjectId })
		victim.SpawnsEnemyOnDeath = false
	end

	ClearEffect({ Id = victim.ObjectId, All = true, BlockAll = true, })

	if victim ~= CurrentRun.Hero then
		KillEnemy( victim, triggerArgs )
	end

	-- Kill Tracker
	currentRoom.Kills = currentRoom.Kills or {}
	currentRoom.Kills[victimName] = (currentRoom.Kills[victimName] or 0) + 1

	if currentRoom.RequiredKillsObject == victimName then
		if currentRoom.Kills[victimName] == currentRoom.RequiredKillsCount then
			if currentRoom.RequiredKillsWeapons == nil or Contains( currentRoom.RequiredKillsWeapons, triggerArgs.SourceWeapon ) then
				thread( PlayVoiceLines, currentRoom.RequiredKillVoiceLines or GlobalVoiceLines[victim.OnKillGlobalVoiceLines], true, nil, { Defer = true } )
			end
		end
	end

	if currentRoom.Encounter ~= nil then
		if currentRoom.Encounter.WipeEnemiesOnKill == victimName then
			DestroyRequiredKills( { BlockLoot = true, SkipIds = { victim.ObjectId } } )
		end
		if currentRoom.Encounter.SpawnThreadName ~= nil and CheckCancelSpawns( CurrentRun, currentRoom, currentRoom.Encounter ) then
			SetThreadWait( currentRoom.Encounter.SpawnThreadName, 0 )
		end
	end

	if victim ~= nil then
		if victim.OnKillGlobalVoiceLines ~= nil and currentRoom.Kills[victimName] >= victim.KillsRequiredForVoiceLines then
			thread( PlayVoiceLines, GlobalVoiceLines[victim.OnKillGlobalVoiceLines], true, nil, { Defer = true } )
		end
		if victim.OnKillVoiceLines ~= nil then
			thread( PlayVoiceLines, victim.OnKillVoiceLines, false )
		end
	end

	if victim.OnDeathCrowdReaction ~= nil then
		thread(CrowdReactionPresentation, victim.OnDeathCrowdReaction)
	end

	if victim.InSky then
		ObeyGravity({ Id = victim.ObjectId })
		SetAlpha({ Id = victim.ObjectId, Fraction = 1.0 })
	end

	if killingWeaponName ~= nil and EnemyData[victimName] ~= nil and not victim.SkipModifiers then
		GameState.WeaponKills[killingWeaponName] = (GameState.WeaponKills[killingWeaponName] or 0) + 1
		CurrentRun.CurrentRoom.CodexUpdates = CurrentRun.CurrentRoom.CodexUpdates or { Enemies = {}, CthonicGods = {}, OtherDenizens = {}, Weapons = {}}
		IncrementTableValue(CurrentRun.CurrentRoom.CodexUpdates.Weapons, killingWeaponName )

		CheckCodexUnlock( "Weapons", killingWeaponName )
		if WeaponData[killingWeaponName] and WeaponData[killingWeaponName].CodexWeaponName and WeaponData[killingWeaponName].CodexWeaponName ~= killingWeaponName then
			local codexName = WeaponData[killingWeaponName].CodexWeaponName
			GameState.WeaponKills[codexName] = (GameState.WeaponKills[codexName] or 0) + 1
			IncrementTableValue(CurrentRun.CurrentRoom.CodexUpdates.Weapons, codexName )
		end
	end

	if killer ~= nil and victim ~= nil and killer.NonHeroKillCombatText ~= nil and not victim.HideHealthBar and victim ~= CurrentRun.Hero then
		thread( InCombatText, killer.ObjectId, killer.NonHeroKillCombatText, 0.8, { SkipShadow = true } )
	end
	CheckOnKillWeaponUpgrades( destroyerId, victim, killingWeaponName )

	if ActiveEnemies[victim.ObjectId] ~= nil then
		if not victim.SkipRecordDestroyedState then
			RecordObjectState( CurrentRun.CurrentRoom, victim.ObjectId, "Destroyed", true )
		end
		LastEnemyKilled = victim
		CleanupEnemy( victim )
	end
	local obstacle = MapState.ActiveObstacles[victim.ObjectId]
	if obstacle ~= nil then
		if obstacle.AIThreadName ~= nil then
			killTaggedThreads( obstacle.AIThreadName )
		end
		if obstacle.AINotifyName ~= nil then
			killWaitUntilThreads( obstacle.AINotifyName )
		end
	end

	CheckMoneyDrop( CurrentRun, currentRoom, victim, victim.MoneyDropOnDeath )

	if victim.HealDropOnDeath ~= nil and RandomChance(victim.HealDropOnDeath.Chance) then
		DropHealth( victim.HealDropOnDeath.Name, victim.ObjectId, victim.HealDropOnDeath.Radius or 130, 0 )
	end

	if not IsEmpty( victim.StoredAmmo) then
		for i = 1, TableLength( victim.StoredAmmo ) do
			local ammoData = victim.StoredAmmo[i]
			ammoData.ForceMin = 75
			ammoData.ForceMax = 200
			ammoData.UpwardForceMin = 500
			ammoData.UpwardForceMax = 700
			ammoData.Angle = nil
			ammoData.LocationX = nil
			ammoData.LocationY = nil
			ammoData.Count = ammoData.Count
			CheckAmmoDrop( CurrentRun, victim.ObjectId, ammoData )
		end
	end

	if victim.ReloadSoundId ~= nil then
		StopSound({ Id = victim.ReloadSoundId, Duration = 0.2 })
	end
	if victim.PreAttackLoopingSoundId ~= nil then
		StopSound({ Id = victim.PreAttackLoopingSoundId, Duration = 0.2 })
	end

	if not triggerArgs.SkipOnDeathFunction then
		if victim.OnDeathFunctionName ~= nil then
			local onDeathFunction = _G[victim.OnDeathFunctionName]
			onDeathFunction( victim, victim.OnDeathFunctionArgs )
		end
		if victim.OnDeathThreadedFunctionName ~= nil then
			local onDeathThreadedFunction = _G[victim.OnDeathThreadedFunctionName]
			thread( onDeathThreadedFunction, victim, victim.OnDeathFunctionArgs )
		end
	end

	if victim.OnDeathShakeScreenSpeed ~= nil then
		local distanceToPlayer = GetDistance({ Id = triggerArgs.triggeredById, DestinationId = CurrentRun.Hero.ObjectId })
		local shakeSpeed = victim.OnDeathShakeScreenSpeed or 0
		local shakeDistance = victim.OnDeathShakeScreenDistance or 0
		local shakeDuration = victim.OnDeathShakeScreenDuration or 0
		if distanceToPlayer > 500 and distanceToPlayer <= 1000 then
			shakeSpeed = shakeSpeed * 0.75
			shakeDistance = shakeDistance * 0.75
			shakeDuration = shakeDuration * 0.75
		elseif distanceToPlayer > 1000 then
			shakeSpeed = shakeSpeed * 0.5
			shakeDistance = shakeDistance * 0.5
			shakeDuration = shakeDuration * 0.5
		end
		ShakeScreen({ Speed = shakeSpeed, Distance = shakeDistance, Duration = shakeDuration, FalloffSpeed = victim.OnDeathShakeScreenFalloff, Angle = victim.OnDeathShakeScreenAngle })
	end

	if victim.RespawnInPlaceOnDeath then
		local deathLocationId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = victim.ObjectId })
		thread( RespawnVictim, victim.Name, deathLocationId, victim.RespawnDelay, { DestroySpawnLocation = true, } )
	end

	if victim.RespawnAtIdOnDeath then
		thread( RespawnVictim, victim.Name, victim.RespawnAtIdOnDeath, victim.RespawnDelay )
	end

	if victim.RespawnOnDeath and victim.OriginalSpawnLocationId ~= nil then
		thread( RespawnVictim, victim.Name, victim.OriginalSpawnLocationId, victim.RespawnDelay )
	end

	if victim.SpawnedUnitAnimation ~= nil then
		StopAnimation({ Name = victim.SpawnedUnitAnimation, DestinationId = victim.ObjectId })
	end

	if victim.FuseWarningAnimation then
		StopAnimation({ Name = victim.FuseWarningAnimation, DestinationId = victim.ObjectId })
	end

	if victim.MultiFuryObstacleIds ~= nil then
		for name, id in pairs(victim.MultiFuryObstacleIds) do
			Destroy({ Ids = id })
		end
	end

	thread( HandleTetherParentDeath, victim )

	if victim.SpawnObstaclesOnDeath ~= nil then
		for k, spawnData in pairs(victim.SpawnObstaclesOnDeath) do
			local spawnId = SpawnObstacle({ Name = spawnData.Name, Group = spawnData.GroupName or "Standing", DestinationId = victim.ObjectId })
			if spawnData.UpwardForce ~= nil and spawnData.UpwardForce > 0 then
				SetThingProperty({ Property = "OffsetZ", Value = 0, DestinationId = spawnId })
				SetThingProperty({ Property = "StopsProjectiles", Value = true, DestinationId = spawnId })
				SetThingProperty({ Property = "StopsUnits", Value = true, DestinationId = spawnId })
				ApplyUpwardForce({ Id = spawnId, Speed = spawnData.UpwardForce })
				ApplyForce({ Id = spawnId, Speed = RandomFloat( spawnData.RandomForceMin or 0, spawnData.RandomForceMax or 0 ), Angle = RandomFloat( 0, 360 ) })
			end
			if spawnData.HSV ~= nil then
				SetHSV({ Id = spawnId, HSV = spawnData.HSV })
			end
			if spawnData.Color ~= nil then
				SetColor({ Id = spawnId, Color = spawnData.Color })
			end
			if spawnData.Outline ~= nil then
				spawnData.Outline.Id = spawnId
				AddOutline( spawnData.Outline )
			end
		end
	end

	if victim.SpawnUnitOnDeath ~= nil then
		local newUnit = DeepCopyTable( EnemyData[victim.SpawnUnitOnDeath] )
		newUnit.ObjectId = SpawnUnit({ Name = victim.SpawnUnitOnDeath, Group = "Standing", DestinationId = victim.ObjectId, DoActivatePresentation = false })
		SetupEnemyObject( newUnit, CurrentRun)
	end

	if victim.SpawnBossOnDeath ~= nil then
		local newUnit = DeepCopyTable( EnemyData[victim.SpawnBossOnDeath] )
		newUnit.ObjectId = SpawnUnit({ Name = victim.SpawnBossOnDeath, Group = "Standing", DestinationId = victim.ObjectId, DoActivatePresentation = false })
		SetupEnemyObject( newUnit, CurrentRun)
		SetupBoss( newUnit, CurrentRun)
	end

	if victim.GroupAI ~= nil and ActiveGroupAIs[victim.GroupAI] ~= nil then
		RemoveValueAndCollapse( ActiveGroupAIs[victim.GroupAI], victim )
	end

	if victim.OnDeathVoiceLines then
		thread( PlayVoiceLines, victim.OnDeathVoiceLines, nil, victim )
	end

	if victim.StopBiomeTimerIfComboPartnerDead and not victim.CannotDieFromDamage then
		local bothBossesDead = false
		local partnerId = GetClosestUnitOfType({ Id = victim.ObjectId, DestinationName = victim.ComboPartnerName })
		if partnerId == 0 or RequiredKillEnemies[partnerId] == nil or RequiredKillEnemies[partnerId].IsDead or RequiredKillEnemies[partnerId].Health <= 0 then
			bothBossesDead = true
		end
	end

	MapState.ActiveObstacles[victim.ObjectId] = nil
	ActiveEnemies[victim.ObjectId] = nil
	if RequiredKillEnemies[victim.ObjectId] ~= nil then
		RequiredKillEnemies[victim.ObjectId] = nil
		GameState.TotalRequiredEnemyKills = (GameState.TotalRequiredEnemyKills or 0) + 1
		if not victim.SpawnsEnemyOnDeath then
			notifyExistingWaiters( "RequiredKillEnemyKilledOrSpawned" )
			notifyExistingWaiters("RequiredEnemyKilled")
		end
		if currentRoom.Encounter.RequiredKillFunctionName ~= nil then
			local requiredKillFunction = _G[currentRoom.Encounter.RequiredKillFunctionName]
			if requiredKillFunction ~= nil then
				requiredKillFunction( currentRoom.Encounter, victim, killer )
			end
		end
	end

	if victim.UnuseableWhenDead then
		RefreshUseButton( victim.ObjectId, victim )
	end

	if victim == CurrentRun.Hero then
		KillHero( victim, triggerArgs )
	else
		KillPresentation( victim, triggerArgs )
		if not triggerArgs.SkipDestroyDelay then
			wait( victim.DestroyDelay )
		end
		if not triggerArgs.SkipDestroy then
			Destroy({ Id = victim.ObjectId })
		end
	end

end

function HandleTetherParentDeath( victim, skipTetherCount, skipTetherAnimation )

	if victim.TetherIds == nil then
		return
	end

	for k, id in ipairs( victim.TetherIds ) do
		if skipTetherCount == nil or k > skipTetherCount then
			if victim.OnDeathTetherUpwardForce ~= nil then
				SetThingProperty({ Property = "OffsetZ", Value = 0, DestinationId = id })
				SetThingProperty({ Property = "StopsProjectiles", Value = true, DestinationId = id })
				SetThingProperty({ Property = "StopsUnits", Value = true, DestinationId = id })
				ApplyUpwardForce({ Id = id, Speed = victim.OnDeathTetherUpwardForce })
				ApplyForce({ Id = id, Speed = RandomFloat( victim.OnDeathTetherRandomForceMin, victim.OnDeathTetherRandomForceMax ), Angle = RandomFloat( 0, 360 ) })
			end
			if victim.DestroyTethersOnDeath then
				Destroy({ Id = id })
			end
			if victim.Tethers[k] ~= nil and victim.Tethers[k].ParentDeathAnimation ~= nil then
				SetAnimation({ DestinationId = id, Name = victim.Tethers[k].ParentDeathAnimation })
			end
			wait( 0.04, RoomThreadName )
		else
			if skipTetherAnimation ~= nil then
				SetAnimation({ DestinationId = id, Name = skipTetherAnimation })
				wait( 0.25, RoomThreadName )
			end
		end
	end
end

function RespawnVictim( victimName, location, delay, args )
	args = args or {}
	local threadName = RoomThreadName
	if CurrentDeathAreaRoom == nil then
		threadName = CurrentRun.CurrentRoom.Encounter.SpawnThreadName or RoomThreadName
	end
	wait( delay or 1.0, threadName )

	local enemyData = EnemyData[victimName]
	local newEnemy = DeepCopyTable( enemyData )
	newEnemy.ObjectId = SpawnUnit({ Name = enemyData.Name, Group = "Standing", DestinationId = location, OffsetX = 0, OffsetY = 0 })
	SetupEnemyObject( newEnemy, CurrentRun, { SkipSpawnVoiceLines = true } )
	UseableOff({ Id = newEnemy.ObjectId })
	thread( PlayVoiceLines, newEnemy.OnRespawnVoiceLines, nil, newEnemy )
	if args.DestroySpawnLocation then
		Destroy({ Id = location })
	end
end

function CheckOnKillWeaponUpgrades( killerId, victim, killingWeapon )

	local weaponData = WeaponData[killingWeapon]
	if weaponData == nil or victim == nil then
		return
	end

	local totalChance = 0
	local dropCap = {}
	local dropChance = {}
	for i, dropData in pairs(GetHeroTraitValues("DropOnKill")) do
		local checkValidLifeOnKill = ( dropData.ValidEnemies == nil and victim.DropItemsOnDeath ) or (dropData.ValidEnemies ~= nil and Contains( dropData.ValidEnemies, victim.GenusName ) or Contains( dropData.ValidEnemies, victim.Name ))
		if checkValidLifeOnKill then
			IncrementTableValue(dropChance, dropData.Name, dropData.Chance)
			if dropData.DropCap then
				IncrementTableValue(dropCap, dropData.Name, dropData.DropCap)
			else
				-- arbitrarily high value if there's no cap
				IncrementTableValue(dropCap, dropData.Name, 1000)
			end
		end
	end

	for key, dropChances in pairs(dropChance) do
		while dropChances > 0 do
			local validDrop = true
			if LifeOnKillRecord[key] ~= nil and LifeOnKillRecord[key] >= dropCap[key] then
				validDrop = false
				dropChances = 0
			end
			if RandomChance(dropChances) and validDrop then
				local id = SpawnObstacle({ Name = key, DestinationId = victim.ObjectId, Group = "Standing" })
				CreateConsumableItem( id, key, 0)
				ApplyUpwardForce({ Id = id, Speed = RandomFloat( 500, 700 ) })
				ApplyForce({ Id = id, Speed = RandomFloat( 75, 260 ), Angle = RandomFloat( 0, 360 ) })
				PlaySound({ Name = "/Leftovers/Menu Sounds/CoinFlash", Id = id })

				IncrementTableValue( LifeOnKillRecord, key)
			end
			dropChances = dropChances - 1
		end
	end

	if weaponData.LinkedUpgrades ~= nil then
		CheckOnKillWeaponUpgrades( killerId, victim, weaponData.LinkedUpgrades )
	end

end

function DropHealth( healthObjectName, targetId, radius, angle, dropTowardHero )
	if targetId == nil then
		targetId = CurrentRun.Hero.ObjectId
	end

	local offset = CalcOffset( angle or RandomFloat( 0, 360 ), radius or 5 )
	local healDropId = SpawnObstacle({ Name = healthObjectName, DestinationId = targetId, OffsetX = offset.X, OffsetY = offset.Y, Group = "Standing" })
	local consumableData = ConsumableData[healthObjectName]
	local consumable = GetRampedConsumableData( consumableData )
	consumable.ObjectId = healDropId
	consumable.Cost = 0
	AddToGroup({ Id = healDropId, Name = "ConsumableItems" })
	AttachLua({ Id = healDropId, Table = consumable })
	ApplyUpwardForce({ Id = healDropId, Speed = RandomFloat( 500, 700 ) })
	if not dropTowardHero then
		ApplyForce({ Id = healDropId, Speed = RandomFloat( 75, 260 ), Angle = RandomFloat( 0, 360 ) })
	else
		local forceAngle = GetAngleBetween({ Id = healDropId, DestinationId = CurrentRun.Hero.ObjectId })
		ApplyForce({ Id = healDropId, Speed = 100, Angle = forceAngle, SelfApplied = true })
	end
	PlaySound({ Name = "/Leftovers/Menu Sounds/CoinFlash", Id = healDropId })
end

OnEffectApply{
	function( triggerArgs )

		local victim = triggerArgs.TriggeredByTable
		if not victim or ( victim.IsDead and victim ~= CurrentRun.Hero ) then
			return
		end

		victim.ActiveEffects = victim.ActiveEffects or {}
		victim.ActiveEffects[triggerArgs.EffectName] = triggerArgs.Stacks

		for i, traitData in pairs( GetHeroTraitValues("AddOnEffectWeapons")) do
			if triggerArgs.EffectName == traitData.EffectName and (traitData.AffectChance == nil or RandomChance(traitData.AffectChance)) then

				local enemyIsValid = true
				if triggerArgs.TriggeredByTable ~= nil and triggerArgs.TriggeredByTable.Name ~= nil then
					if traitData.IgnoreEnemies ~= nil and ( Contains(traitData.IgnoreEnemies, triggerArgs.TriggeredByTable.Name) or Contains(traitData.IgnoreEnemies, triggerArgs.TriggeredByTable.GenusName)) then
						enemyIsValid = false
					end
				end

				if enemyIsValid then
					FireWeaponFromUnit({ Weapon = traitData.Weapon, Id = CurrentRun.Hero.ObjectId, DestinationId = triggerArgs.triggeredById, AutoEquip = true })
				end
			end
		end

		if EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].OnApplyFunctionName and _G[EffectData[triggerArgs.EffectName].OnApplyFunctionName ] then
			_G[EffectData[triggerArgs.EffectName].OnApplyFunctionName ](triggerArgs)
		end

		if not triggerArgs.Reapplied then
			local unit = triggerArgs.TriggeredByTable
			if triggerArgs.EffectType == "DAMAGE_OUTPUT" then
				AddOutgoingDamageModifier( unit,
				{
					Name = triggerArgs.EffectName,
					GlobalMultiplier = triggerArgs.Modifier,
					Temporary = true,
				})
			elseif triggerArgs.EffectType == "DAMAGE_TAKEN" then
				AddIncomingDamageModifier( unit,
				{
					Name = triggerArgs.EffectName,
					GlobalMultiplier = triggerArgs.Modifier,
					Temporary = true,
				})
			elseif triggerArgs.EffectType == "SPEED" and victim == CurrentRun.Hero then
				RecordSpeedModifier( triggerArgs.Modifier, triggerArgs.Duration )
			elseif triggerArgs.EffectType == "INVULNERABLE" and victim ~= CurrentRun.Hero then
				SetUnitInvulnerable( victim , triggerArgs.EffectName )
			end
		end

		if triggerArgs.IsVulnerabilityEffect and triggerArgs.BlockedEffect ~= triggerArgs.EffectName then
			triggerArgs.TriggeredByTable.VulnerabilityEffects = triggerArgs.TriggeredByTable.VulnerabilityEffects or {}
			triggerArgs.TriggeredByTable.VulnerabilityEffects[ triggerArgs.EffectName ] = true
			if TableLength(triggerArgs.TriggeredByTable.VulnerabilityEffects) >= MetaUpgradeData.VulnerabilityEffectBonusMetaUpgrade.AddOutgoingDamageModifiers.MinRequiredVulnerabilityEffects then
				AddVulnerabilityIndicator( triggerArgs.TriggeredByTable )
			end
		end
	end
}

OnEffectCleared{
	function( triggerArgs )
		if not triggerArgs.Exists then
			return
		end

		local unit = triggerArgs.TriggeredByTable
		if unit == nil then
			return
		end

		unit.ActiveEffects = unit.ActiveEffects or {}
		unit.ActiveEffects[triggerArgs.EffectName] = nil

		if triggerArgs.IsVulnerabilityEffect and triggerArgs.TriggeredByTable.VulnerabilityEffects then
			--DebugPrint({Text = " nilling out effect " .. triggerArgs.EffectName })
			triggerArgs.TriggeredByTable.VulnerabilityEffects[ triggerArgs.EffectName ] = nil
			if TableLength(triggerArgs.TriggeredByTable.VulnerabilityEffects) < MetaUpgradeData.VulnerabilityEffectBonusMetaUpgrade.AddOutgoingDamageModifiers.MinRequiredVulnerabilityEffects then
				RemoveVulnerabilityIndicator( triggerArgs.TriggeredByTable )
			end
		end


		if EffectData[triggerArgs.EffectName] and EffectData[triggerArgs.EffectName].OnClearFunctionName and _G[EffectData[triggerArgs.EffectName].OnClearFunctionName ] then
			_G[EffectData[triggerArgs.EffectName].OnClearFunctionName ](triggerArgs)
		end

		if triggerArgs.EffectType == "DAMAGE_OUTPUT" and unit.OutgoingDamageModifiers ~= nil then
			for i, data in pairs( unit.OutgoingDamageModifiers ) do
				if data.Name == triggerArgs.EffectName then
					unit.OutgoingDamageModifiers[i] = nil
					break
				end
			end
		elseif triggerArgs.EffectType == "DAMAGE_TAKEN" and unit.IncomingDamageModifiers ~= nil then
			RemoveIncomingDamageModifier( unit, triggerArgs.EffectName )
		elseif triggerArgs.EffectType == "INVULNERABLE" then
			SetUnitVulnerable( unit , triggerArgs.EffectName )
		end
	end
}


function ClearManualReloadVFX( owner )
	ClearEffect({ Id = owner.ObjectId, Name = "ManualReloadBonus" })
end

function ClearSwordWaveVFX( owner )
	ClearEffect({ Id = owner.ObjectId, Name = "AmmoWaveActive" })
	CurrentRun.Hero.StoredAmmoWave = false
end

function AthenaBackstabVulnerabilityApply( triggerArgs )
	local victim = triggerArgs.TriggeredByTable
	if not triggerArgs.Reapplied then
		AddIncomingDamageModifier( victim,
		{
			Name = triggerArgs.EffectName,
			HitVulnerabilityMultiplier = triggerArgs.Modifier
		})
	end
end

function AthenaBackstabVulnerabilityClear( triggerArgs )
	local unit = triggerArgs.TriggeredByTable
	if unit.IncomingDamageModifiers ~= nil then
		RemoveIncomingDamageModifier( unit, "AthenaBackstabVulnerability" )
	end
end

function ConsecrationDamageReductionApply( triggerArgs )
	local victim = triggerArgs.TriggeredByTable
	if not triggerArgs.Reapplied then
		AddIncomingDamageModifier( victim,
		{
			Name = "ConsecerationLavaDefense",
			ValidWeaponMultiplier = 0,
			ValidWeapons = WeaponSets.LavaWeaponNames,
			Temporary = true,
		})
	end

	BlockEffect({ Id = victim.ObjectId, Name = "LavaSlow", Duration = 0.25 })
	SetLifeProperty({ DestinationId = victim.ObjectId, Property = "ConsecutiveHits", Value = 0, DataValue = false })
end

function ConsecrationDamageReductionClear( triggerArgs )
	local unit = triggerArgs.TriggeredByTable
	if unit.IncomingDamageModifiers ~= nil then
		RemoveIncomingDamageModifier( unit, "ConsecerationLavaDefense" )
	end
end

function CharmApply( triggerArgs )
	local victim = triggerArgs.TriggeredByTable
	if not triggerArgs.Reapplied and victim then
		triggerArgs.TriggeredByTable.Charmed = true
		FinishTargetMarker( victim )
		OnCharmStartPresentation( triggerArgs.TriggeredByTable )
		UpdateHealthBar( triggerArgs.TriggeredByTable, 0, { Force = true })
		AddOutgoingDamageModifier(
			victim,
			{
				Name = triggerArgs.EffectName,
				NonPlayerMultiplier = 10
			})
	end
end

function CharmClear( triggerArgs )
	local victim = triggerArgs.TriggeredByTable
	triggerArgs.TriggeredByTable.Charmed = false
	OnCharmEndPresentation( triggerArgs.TriggeredByTable )
	UpdateHealthBar( triggerArgs.TriggeredByTable, 0, { Force = true })
	FinishTargetMarker( victim )
	for i, data in pairs( victim.OutgoingDamageModifiers ) do
		if data.Name == triggerArgs.EffectName then
			victim.OutgoingDamageModifiers[i] = nil
			break
		end
	end
end

OnEffectStackDecrease{
	function( triggerArgs )
		if triggerArgs.EffectName == "DamageOverTime" then
			UpdatePoisonEffectStacks(triggerArgs)
		end
	end
}

OnEffectDelayedKnockbackForce{
	function( triggerArgs )
		if triggerArgs.EffectName == "DelayedKnockback" then
			PoseidonLegendaryPresentation( triggerArgs )
		end
		if triggerArgs.triggeredById ~= CurrentRun.Hero.ObjectId then
			CheckOnImpactPowers( triggerArgs.TriggeredByTable, CurrentRun.Hero, triggerArgs )
		end
	end
}

function FizzleOldSpawn( unit )
	thread( ActivateFuse, unit )
end

function ActivateFuse( enemy )
	if enemy.FuseActivated or enemy.IsDead then
		return
	end
	CleanupEnemy( enemy )
	enemy.FuseActivated = true
	enemy.CannotDieFromDamage = true
	ActivateFusePresentation( enemy )
	wait( enemy.FuseDuration )
	PostActivatFusePresentation( enemy )
	if enemy.PostFuseWeapon ~= nil then
		FireWeaponFromUnit({ Weapon = enemy.PostFuseWeapon, Id = enemy.ObjectId, DestinationId = enemy.ObjectId, AutoEquip = true })
	end
	Kill( enemy, { SkipDestroy = enemy.PostFuseRevive } )
	wait( enemy.FuseDormantDuration, RoomThreadName )
	if enemy.PostFuseRevive then
		PostFuseRevivePresentation( enemy )
		enemy.FuseActivated = false
		enemy.IsDead = false
	end
end

function ActivateLuciferFuse( enemy )
	if enemy.FuseActivated or enemy.IsDead then
		return
	end
	enemy.FuseActivated = true
	ActivateFusePresentation( enemy )
	local delay = 0
	CurrentRun.CurrentRoom.FusedBombs = CurrentRun.CurrentRoom.FusedBombs  or {}
	while CurrentRun.CurrentRoom.FusedBombs[_worldTime + enemy.FuseDuration + delay ] and delay < 2 do
		delay = delay + 0.1
	end
	local key = _worldTime + enemy.FuseDuration + delay
	CurrentRun.CurrentRoom.FusedBombs[_worldTime + enemy.FuseDuration + delay] = enemy
	wait( enemy.FuseDuration + delay, RoomThreadName )
	PostActivatFusePresentation( enemy )
	Kill( enemy, { SkipDestroy = false } )
	CurrentRun.CurrentRoom.FusedBombs[key] = nil
end
function CheckDashOverride( source )
	if source.RushMaxRangeOverride ~= nil then
		--DebugPrint({ Text = "Overriding Rush Weapon in "..source.Name })
		SetWeaponProperty({ WeaponName = "RushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "BlinkMaxRange", Value = source.RushMaxRangeOverride, ValueChangeType = "Absolute" })
	else
		--DebugPrint({ Text = "Setting Default Rush Weapon" })
		SetWeaponProperty({ WeaponName = "RushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "BlinkMaxRange", Value = CurrentRun.Hero.RushWeaponMaxRange, ValueChangeType = "Absolute" })
	end
end

function EquipPlayerWeapon( weaponData, args )

	args = args or {}
	GameState.WeaponsUnlocked[weaponData.Name] = true
	GameState.WeaponsTouched[weaponData.Name] = true
	thread( CheckQuestStatus )

	local heroId = CurrentRun.Hero.ObjectId
	local newWeaponEquipped = false
	if not CurrentRun.Hero.Weapons[weaponData.Name] then
		newWeaponEquipped = true
	end
	CurrentRun.Hero.Weapons[weaponData.Name] = true
	if weaponData.SecondaryWeapon then
		CurrentRun.Hero.Weapons[weaponData.SecondaryWeapon] = true
	end

	local toEquip = {}
	table.insert( toEquip, weaponData.Name )
	ConcatTableValues( toEquip, WeaponSets.HeroWeaponSets[weaponData.Name] )
	EquipWeapon({ DestinationId = heroId, Names = toEquip, LoadPackages = args.LoadPackages })

	if CurrentRun.Hero.WeaponSpawns ~= nil then
		for spawnId, spawn in pairs( CurrentRun.Hero.WeaponSpawns ) do
			Kill( spawn )
		end
		CurrentRun.Hero.WeaponSpawns = nil
	end

	local toUnequip = {}
	for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
		if weaponName ~= weaponData.Name then
			CurrentRun.Hero.Weapons[weaponName] = nil
			if WeaponData[weaponName].SecondaryWeapon then
				CurrentRun.Hero.Weapons[WeaponData[weaponName].SecondaryWeapon] = nil
			end
			table.insert( toUnequip, weaponName )
			ConcatTableValues( toUnequip, WeaponSets.HeroWeaponSets[weaponName] )
		end
	end
	UnequipWeapon({ DestinationId = heroId, Names = toUnequip, UnloadPackages = false })

	if newWeaponEquipped then
		ReapplyWeaponSwitchMetaUpgrades()

		RemoveTrait( CurrentRun.Hero, "UnusedWeaponBonusTrait" )
		RemoveTrait( CurrentRun.Hero, "UnusedWeaponBonusTraitAddGems" )
		if IsWeaponUnused(weaponData.Name) then
			if GameState.Cosmetics.UnusedWeaponBonusAddGems then
				AddTraitToHero({ TraitName = "UnusedWeaponBonusTraitAddGems" })
			else
				AddTraitToHero({ TraitName = "UnusedWeaponBonusTrait" })
			end
		end
	end
	
	thread( EquipPlayerWeaponPresentation, weaponData, args )

end

function SelfDestruct( owner )
	thread( Kill, owner )
end

function HitByFreezeWeapon( victim )

	if victim == nil or victim.IsDead then
		return
	end

	if not victim.CanBeFrozen then
		return
	end

	victim.FreeEscapeAttempts = 0
	FrozenPresentation( victim )
	if victim.Frozen then
		-- Already frozen
		return
	end
	victim.Frozen = true
	victim.Mute = true
	wait(0.02)

	thread( FreezeEscape, victim )
	if victim.Frozen then
		local notifyName = "FreezeStunExpired"..victim.ObjectId
		NotifyOnEffectExpired({ Id = victim.ObjectId, Notify = notifyName, EffectName = "FreezeStun" })
		waitUntil( notifyName )
	end
	UnfrozenPresentation( victim )
	victim.Frozen = false
	victim.Mute = false

end

function FreezeEscape( victim )

	while victim.Frozen do

		local didEscapeAttempt = false
		if victim == CurrentRun.Hero then
			local notifyName = "FreezeEscape"
			NotifyOnControlPressed({ Names = { "Rush", "Shout", "Attack2", "Attack1", "Attack3", "AutoLock" }, Notify = notifyName, Timeout = 1.0 })
			waitUntil( notifyName )
			if not _eventTimeoutRecord[notifyName] then
				didEscapeAttempt = true
				victim.FreeEscapeAttempts = victim.FreeEscapeAttempts + 1
			end
		else
			-- Simulate enemies trying to break free every on an interval
			local freezeBreakDuration = victim.FreezeBreakDuration or 0.5
			wait( freezeBreakDuration, RoomThreadName )
			didEscapeAttempt = true
		end

		if didEscapeAttempt then
			ModifyEffect({ Id = victim.ObjectId, Names = { "FreezeStun" }, AddTime = -(victim.FreezeTimeReductionPerInput or 0.5) })
			FreezeEscapeInputPresentation( victim )
		end
		wait( 0.02, RoomThreadName )
	end

end

function AddSuperArmor()
	CurrentRun.Hero.DamagedAnimation = nil
end

function ClearSuperArmor()
	CurrentRun.Hero.DamagedAnimation = HeroData.DefaultHero.DamagedAnimation
end

GlobalCooldowns = {}
GlobalCounts = {}

SessionState = {}

OnAnyLoad
{
	function( triggerArgs )

		ActiveEnemies = {}
		RequiredKillEnemies = {}
		ActiveGroupAIs = {}
		SurroundEnemiesAttacking = {}
		ActivatedObjects = {}
		LootObjects = {}

		MapState = {}
		MapState.SimSpeedChanges = {}
		MapState.ActiveObstacles = {}
		-- Hard-coded buckets
		MapState.SpawnPoints = GetIds({ Name = "SpawnPoints" })

		--ValidateIdLeaks( "_G", _G )
		--ValidateLoops( "_G", _G )

	end
}
