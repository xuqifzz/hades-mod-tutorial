-- Interactables

OnUsed{ "WeaponKit01",
	function( triggerArgs )

		local weaponKit = triggerArgs.AttachedTable
		if CurrentRun.Hero.Weapons[weaponKit.Name] ~= nil then
			if not IsGameStateEligible( CurrentRun, WeaponUpgradeData.DefaultGameStateRequirement ) then
				return
			else
				if weaponKit.KitInteractFunctionName ~= nil and IsGameStateEligible( CurrentRun, weaponKit.KitInteractGameStateRequirements ) then
					local interactFunction = _G[weaponKit.KitInteractFunctionName]
					if interactFunction ~= nil then
						interactFunction( CurrentRun.Hero, weaponKit )
					end
				else
					PlayInteractAnimation( triggerArgs.triggeredById )
				end
				CheckFirstTimeWeaponUpgradePresentation( weaponKit )
				ShowWeaponUpgradeScreen({ WeaponName = weaponKit.Name })
				thread( SpawnSkelly, 1.0 )
			end
		elseif IsWeaponUnlocked( weaponKit.Name ) then
			PickupWeaponKit( weaponKit )
			SetWeaponKitUseText( weaponKit )
			RefreshUseButton( weaponKit.ObjectId, weaponKit )
			wait( 0.3 )
			CheckAutoObjectiveSets( CurrentRun, "WeaponPickup" )
		else
			if HasResource( weaponKit.ResourceName, weaponKit.UnlockCost ) then
				AddInputBlock({ Name = "UnlockingWeaponKit" })
				thread(MarkObjectiveComplete, "UnlockWeapon")
				HideUseButton( weaponKit.ObjectId, weaponKit )
				SetAnimation({ DestinationId = weaponKit.TextAnchorId, Name = "LockedIconRelease" })
				Shake({ Id = triggerArgs.triggeredById, Distance = 3, Speed = 500, Duration = 0.65 })
				thread( PlayVoiceLines, HeroVoiceLines.WeaponKitUnlockedVoiceLines, true )
				SpendResource( weaponKit.ResourceName, weaponKit.UnlockCost, weaponKit.Name )
				PlayInteractAnimation( weaponKit.ObjectId )
				DestroyTextBox({Id = weaponKit.TextAnchorId})
				wait(0.8)
				PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof", Id = triggerArgs.triggeredById  })
				thread( WeaponUnlockedPresentation, weaponKit.Name )
				PickupWeaponKit( weaponKit )
				RemoveInputBlock({ Name = "UnlockingWeaponKit" })
				SetWeaponKitUseText( weaponKit )
				RefreshUseButton( weaponKit.ObjectId, weaponKit )
				wait( 1.5 )
				for k, enemy in pairs( ActiveEnemies ) do
					if enemy.WeaponUnlockReactionVoiceLines ~= nil then
						thread( PlayVoiceLines, enemy.WeaponUnlockReactionVoiceLines, true, enemy )
					end
				end
				CheckAutoObjectiveSets( CurrentRun, "WeaponPickup" )
			else
				PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = triggerArgs.triggeredById })
				Flash({ Id =  weaponKit.TextAnchorId, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
				Shake({ Id = triggerArgs.triggeredById, Distance = 6, Speed = 300, Duration = 0.2 })
				Shake({ Id = weaponKit.TextAnchorId, Distance = 6, Speed = 300, Duration = 0.2 })
				thread( PlayVoiceLines, HeroVoiceLines.NotEnoughLockKeysVoiceLines, true )
			end
		end
	end
}

function PickupWeaponKit( weaponKit )
	AddInputBlock({ Name = "PickupWeaponKit" })
	ClearObjectives()
	PlayWeaponEquipAnimation( weaponKit )
	local weaponUntouched = IsWeaponUntouched( weaponKit.Name )
	local weaponEquipArgs = {}
	if weaponKit.KitInteractFunctionName ~= nil and IsGameStateEligible( CurrentRun, weaponKit.KitInteractGameStateRequirements ) then
		weaponEquipArgs.SkipEquipLines = true
	end
	UnequipWeaponUpgrade()
	wait( 0.02 )-- Distribute workload
	EquipPlayerWeapon( weaponKit, weaponEquipArgs )
	wait( 0.02 )-- Distribute workload
	EquipWeaponUpgrade( CurrentRun.Hero )

	if SessionState.NeedWeaponPickupBinkLoad then
		local overrideWeaponData = GetWeaponData( CurrentRun.Hero, weaponKit.Name )
		if overrideWeaponData.Binks then
			PreLoadBinks({ Names = overrideWeaponData.Binks })
		elseif overrideWeaponData.WeaponBinks then
			local weaponBinks = CombineTables( overrideWeaponData.WeaponBinks, CurrentRun.Hero.WeaponBinks )
			PreLoadBinks({ Names = weaponBinks, Cache = "WeaponCache", Reset = true })
		end
	end

	if weaponUntouched then
		FirstTimeWeaponPickupPresentation( weaponKit )
	else
		wait( 0.02 ) -- Distribute workload
	end

	thread( UpdateWeaponKits )
	wait( 0.02 )-- Distribute workload
	thread( SpawnSkelly, 1.8 )

	RemoveInputBlock({ Name = "PickupWeaponKit" })

end

function PlayWeaponEquipAnimation( weaponKit )
	AddInputBlock({ Name = "ZagreusInteractEquip" })
	SetAnimation({ Name = weaponKit.OwnerEquipAnimation or "ZagreusInteractEquip", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet_Weapon", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = weaponKit.ObjectId })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.2 }, } )
	if interactableObjectId then
		wait( 0.08 )
		CreateAnimation({ Name = "ItemGet_Weapon", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.0 })
	end
	thread( RemoveInteractAnimationInputBlock )
	wait( 0.08 )
end

function PlayInteractAnimation( interactableObjectId, args )
	args = args or {}

	if not args.SkipInputBlock then
		AddTimerBlock( CurrentRun, "ZagreusInteractEquip" )
		AddInputBlock({ Name = "ZagreusInteractEquip" })
	end
	SetAnimation({ Name = "ZagreusInteractEquip", DestinationId = CurrentRun.Hero.ObjectId })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = interactableObjectId })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.1 }, } )
	if interactableObjectId then
		wait( 0.08 )
	end
	if not args.SkipInputBlock then
		thread( RemoveInteractAnimationInputBlock )
	end
	wait( 0.08 )
end

function RemoveInteractAnimationInputBlock()
	wait( 0.25 )
	RemoveInputBlock({ Name = "ZagreusInteractEquip" })
	RemoveTimerBlock( CurrentRun, "ZagreusInteractEquip" )
end

function SetWeaponKitUseText( weaponKit )
	if CurrentRun.Hero.Weapons[weaponKit.Name] ~= nil then
		if IsGameStateEligible( CurrentRun, WeaponUpgradeData.DefaultGameStateRequirement ) then
			weaponKit.UseText = "UseWeaponKit_Equipped"
		else
			weaponKit.UseText = "Blank"
		end
	elseif IsWeaponUnlocked( weaponKit.Name ) then
		if IsWeaponUnused( weaponKit.Name ) then
			if GameState.Cosmetics.UnusedWeaponBonusAddGems then
				weaponKit.UseText =  "UseWeaponKit_MetaPointBonus2"
			else
				weaponKit.UseText =  "UseWeaponKit_MetaPointBonus"
			end
		else
			weaponKit.UseText =  "UseWeaponKit"
		end
	end
end

function UpdateWeaponKits()

	if MapState.WeaponKits == nil then
		return
	end

	local fadeTime = 0.2

	for kitId, weaponData in pairs( MapState.WeaponKits ) do
		if weaponData ~= nil then
			weaponData.ObjectId = kitId
			if CurrentRun.Hero.Weapons[weaponData.Name] ~= nil then
				-- Equipped
				SetAlpha({ Id = kitId, Fraction = 0, Duration = fadeTime })
				wait( fadeTime )
				if IsWeaponUnused( weaponData.Name ) and GetWeaponKitAnimation( weaponData.Name, "BonusUnequipped") ~= nil then
					SetAnimation({ Name = GetWeaponKitAnimation( weaponData.Name, "BonusEquipped"), DestinationId = kitId })
				elseif GetWeaponKitAnimation( weaponData.Name, "Equipped") ~= nil then
					SetAnimation({ Name = GetWeaponKitAnimation( weaponData.Name, "Equipped"), DestinationId = kitId })
				end
				ModifyTextBox({ Id = kitId, FadeTarget = 0.5, Duration = fadeTime })
				SetAlpha({ Id = kitId, Fraction = 1, Duration = fadeTime })

				if IsGameStateEligible( CurrentRun, WeaponUpgradeData.DefaultGameStateRequirement ) then
					CreateAnimation({ Name = "WeaponTitanBlood", DestinationId = kitId })
					CreateAnimation({ Name = "WeaponTitanBloodBack", DestinationId = kitId })
				end
			elseif not IsWeaponUnlocked( weaponData.Name ) then
				UpdateLockedKeyPresentation( weaponData )
			else
				if IsWeaponUnused( weaponData.Name ) then
					if GameState.Cosmetics.UnusedWeaponBonusAddGems then
						weaponData.MetaPointPercentBonus = (TraitData.UnusedWeaponBonusTraitAddGems.MetaPointMultiplier - 1) * 100
						weaponData.GemPercentBonus = (TraitData.UnusedWeaponBonusTraitAddGems.GemMultiplier - 1) * 100
					else
						weaponData.MetaPointPercentBonus = (TraitData.UnusedWeaponBonusTrait.MetaPointMultiplier - 1) * 100
					end
				end
				StopAnimation({ Name = "WeaponTitanBlood", DestinationId = kitId })
				StopAnimation({ Name = "WeaponTitanBloodBack", DestinationId = kitId })
			end
			SetWeaponKitUseText( weaponData )
		end
	end


	for kitId, weaponData in pairs( MapState.WeaponKits ) do
		if weaponData ~= nil then
			if CurrentRun.Hero.Weapons[weaponData.Name] == nil then
				-- Unequipped
				UseableOn({ Id = kitId })

				if IsWeaponUnused( weaponData.Name ) and GetWeaponKitAnimation( weaponData.Name, "BonusUnequipped") ~= nil then
					SetAnimation({ Name = GetWeaponKitAnimation( weaponData.Name, "BonusUnequipped"), DestinationId = kitId })
				else
					if GetWeaponKitAnimation( weaponData.Name, "Unequipped") ~= nil then
						SetAnimation({ Name = GetWeaponKitAnimation( weaponData.Name, "Unequipped"), DestinationId = kitId })
					end
				end

				ModifyTextBox({ Id = kitId, FadeTarget = 1.0, Duration = fadeTime })
			end
		end
	end

end

OnUsed{ "NPCs",
	function( triggerArgs )

		if not CurrentRun.Hero.IsDead and triggerArgs.TriggeredByTable ~= nil and triggerArgs.TriggeredByTable.RequiresRoomCleared and not CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
			thread( CannotUseLootPresentation, triggerArgs.triggeredById, triggerArgs.TriggeredByTable )
			return
		end

		local npc = triggerArgs.AttachedTable

		if npc.ReceivingGift then
			return
		end

		if npc.UnuseableWhenDead and npc.IsDead then
			return
		end

		AngleTowardTarget({ Id = triggerArgs.UserId, DestinationId = triggerArgs.triggeredById })
		if npc ~= nil then
			npc.UserObjectId = triggerArgs.UserId
			local npcName = GetGenusName(npc)
			local checkingMeterUnlock = GiftData[npcName] and not IsGameStateEligible(CurrentRun, GiftData[npcName].UnlockGameStateRequirements )
			CurrentRun.NPCInteractions[npcName] = true

			if ForceEvent ~= nil and ForcePlayTextLines( npc, ForceEvent ) then
				DebugPrint({ Text = "ForcedEvent: "..ForceEvent })
				return
			end

			if npc.NextInteractLines ~= nil then
				-- Cancel all partner conversations immediately
				local source = npc
				local partner = nil
				local textLinesToPlay = npc.NextInteractLines
				for id, unit in pairs( ActiveEnemies ) do
					if unit ~= npc and unit.NextInteractLines ~= nil and unit.NextInteractLines.Name == npc.NextInteractLines.Name then
						if textLinesToPlay[1] == nil and unit.NextInteractLines[1] ~= nil then
							-- Actually lines are contained on the partner
							textLinesToPlay = unit.NextInteractLines
							source = unit
							partner = npc
						else
							partner = unit
						end
						break
					end
				end
				if partner ~= nil then
					StopStatusAnimation( partner, StatusAnimations.WantsToTalk )
				end

				if partner == nil and not IsTextLineEligible( CurrentRun, textLinesToPlay ) then
					npc.NextInteractLines = nil
					CheckAvailableTextLines( npc, { RequireNoPartner = true } )
					textLinesToPlay = npc.NextInteractLines
				end

				PlayTextLines( source, textLinesToPlay )
				npc.NextInteractLines = nil
				CheckAvailableTextLines( npc, { RequireNoPartner = true } )
				if partner ~= nil then
					partner.NextInteractLines = nil
					CheckAvailableTextLines( partner, { RequireNoPartner = true } )
					StopStatusAnimation( partner, StatusAnimations.WantsToTalk )
					RefreshUseButton( partner.ObjectId, partner )
					UseableOff({ Id = partner.ObjectId }) -- Will get turned back on by SetAvailableUseText() below if needed
				end

				ChooseCharacterInteraction( source, partner )
				if partner == nil then

					local sourceName = GetGenusName(source)
					IncrementTableValue( GameState.NPCInteractions, sourceName )

					CheckCodexUnlock( "ChthonicGods", sourceName )
					CheckCodexUnlock( "OtherDenizens", sourceName )
					CheckCodexUnlock( "Enemies", sourceName )
					if checkingMeterUnlock and IsGameStateEligible(CurrentRun, GiftData[sourceName].UnlockGameStateRequirements ) then
						thread( GiftTrackUnlockedPresentation, sourceName )
					end
				end

				SetAvailableUseText( npc )
				if partner ~= nil then
					SetAvailableUseText( partner )
				end
			end
		end
	end
}

function GetGenusName( npc )
	if npc.CodexWeaponName then
		return npc.CodexWeaponName
	end
	if npc.GenusName then
		return npc.GenusName
	end
	return npc.Name
end

OnUsed{ "InspectPoint",
	function( triggerArgs )
		AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = triggerArgs.triggeredById })
		UseableOff({ Id = triggerArgs.triggeredById })
		SetAlpha({ Id = triggerArgs.triggeredById, Fraction = 0.0, Duration = 0.25 })
		BlockVfx({ DestinationId = triggerArgs.triggeredById })
		local inspectPointData = triggerArgs.AttachedTable
		PlayFirstEligibleTextLines( inspectPointData, inspectPointData.InteractTextLineSets )

		local usee = triggerArgs.AttachedTable
		if usee ~= nil and usee.InspectMoveIds ~= nil then
			for id, destinationId in pairs( usee.InspectMoveIds ) do
				Move({ Id = id, DestinationId = destinationId, Duration = 3.0, SmoothStep = true })
			end
		end

	end
}

OnUsed{ "ChallengeSwitchBase",
	function( triggerArgs )

		local challengeSwitchId = triggerArgs.triggeredById
		local challengeSwitch = triggerArgs.TriggeredByTable

		DebugAssert({ Condition = challengeSwitch ~= nil, Text = "Challenge switch somehow nil" })
		if challengeSwitch == nil then
			return
		end

		-- Same requirements as exit doors
		if not challengeSwitch.ReadyToUse or not CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
			thread( CannotUseDoorPresentation, challengeSwitch )
			return
		end

		local interactionBlocked = false
		if challengeSwitch.BlockDuringChallenge and CurrentRun.CurrentRoom.ChallengeEncounter ~= nil then
			if CurrentRun.CurrentRoom.ChallengeEncounter.InProgress then
				interactionBlocked = true
			end
		end

		if interactionBlocked then
			local userTable = triggerArgs.TriggeredByTable
			if CheckCooldown( userTable.CooldownNamePrefix..userTable.ObjectId, userTable.CooldownDuration) then
				if userTable.CannotUseText then
					thread( InCombatText, CurrentRun.Hero.ObjectId, userTable.CannotUseText, 1 )
					thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
				else
					thread( CannotUseLootPresentation, triggerArgs.triggeredById, userTable )
				end
			end
			CreateAnimation({ Name = "ShoutFlare", DestinationId = triggerArgs.triggeredById })
			return
		elseif challengeSwitch.KeyCost ~= nil and challengeSwitch.KeyCost > 0 and not challengeSwitch.Purchased and not HasResource( "LockKeys", challengeSwitch.KeyCost ) then
			local userTable = triggerArgs.TriggeredByTable
			if CheckCooldown( userTable.CooldownNamePrefix..userTable.ObjectId, userTable.CooldownDuration) then
				if userTable.CannotAffordText then
					thread( InCombatText, CurrentRun.Hero.ObjectId, userTable.CannotAffordText, 1 )
					thread( PlayVoiceLines, HeroVoiceLines.NotEnoughLockKeysVoiceLines, true )
				else
					thread( CannotUseLootPresentation, triggerArgs.triggeredById, userTable )
				end
				CreateAnimation({ Name = "ShoutFlare", DestinationId = triggerArgs.triggeredById })
			end
			return
		end

		if challengeSwitch.ChallengeSwitchUseFunctionName ~= nil then
			local func = _G[challengeSwitch.ChallengeSwitchUseFunctionName]
			func( challengeSwitch, challengeSwitchId )
		end

	end
}

function UseChallengeSwitch( challengeSwitch, challengeSwitchId )
	if not CurrentRun.CurrentRoom.ChallengeEncounter.InProgress and not CurrentRun.CurrentRoom.ChallengeEncounter.Completed then
		challengeSwitch.ReadyToUse = false
		AddInputBlock({ Name = "UseChallengeSwitch" })
		PlayInteractAnimation( challengeSwitchId )

		if challengeSwitch.KeyCost ~= nil and challengeSwitch.KeyCost > 0 then
			SetAnimation({ DestinationId = challengeSwitch.TextAnchorId, Name = "LockedIconRelease" })
			wait(0.65)
			DestroyTextBox({Id = challengeSwitch.TextAnchorId})
			SpendResource( "LockKeys", challengeSwitch.KeyCost, "ChallengeSwitch")
			challengeSwitch.Purchased = true
		end

		RemoveInputBlock({ Name = "UseChallengeSwitch" })
		StartChallengeEncounter( challengeSwitch )
		CheckCodexUnlock( "Items", "ChallengeSwitch" )
	else
		if not challengeSwitch.IsOpen then
			PlayInteractAnimation( challengeSwitchId )
			HandleChallengeLoot( challengeSwitch, CurrentRun.CurrentRoom.ChallengeEncounter )
			challengeSwitch.IsOpen = true
			thread( MarkObjectiveComplete, "TimeChallengeReward" )
		end
	end
end

function UseWellShop( challengeSwitch, challengeSwitchId )
	PlayInteractAnimation( challengeSwitchId )
	StartUpStore()
end

OnUsed{ "FishingPoint",
	function( triggerArgs )
		if CheckCooldown( "UsedFishingPoint", 0.75 ) then
			local canFishInEncounter = true
			if CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BlockFishingBeforeStart and not CurrentRun.CurrentRoom.Encounter.Completed then
				canFishInEncounter = false
			end
			if IsCombatEncounterActive( CurrentRun ) or not canFishInEncounter then
				thread( InCombatText, CurrentRun.Hero.ObjectId, "UseBlockedByEnemies", 1.0, { ShadowScale = 0.6 } )
				thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
				PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = triggerArgs.triggeredById })
			elseif CurrentRun.Hero.OnLava then
				thread( InCombatText, CurrentRun.Hero.ObjectId, "UseBlockedByLava", 1.0, { ShadowScale = 0.6 } )
				thread( PlayVoiceLines, HeroVoiceLines.InteractionBlockedVoiceLines, true )
				PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = triggerArgs.triggeredById })
			else
				CurrentRun.Hero.FishingStarted = true
				FreezePlayerUnit( "FishingStartUp", { DisableTray = true, DisableCodex = true } )
				AddTimerBlock( CurrentRun, "Fishing" )
				wait( 0.25, "FishingStartDelay" )
				UnfreezePlayerUnit("FishingStartUp")
				if CurrentRun.Hero.FishingStarted and not CurrentRun.Hero.OnLava then
					UseableOff({ Id = triggerArgs.triggeredById })
					SetAlpha({ Id = triggerArgs.triggeredById, Fraction = 0.0, Duration = 0.25 })
					BlockVfx({ DestinationId = triggerArgs.triggeredById })
					StartFishing( triggerArgs.triggeredById )
				else
					RemoveTimerBlock( CurrentRun, "Fishing" )
				end
 			end
 		end
	end
}

function HasUsed( id )

	if UseRecord == nil then
		UseRecord = {}
	end
	local mapName = GetMapName({ })
	if UseRecord[mapName] == nil then
		UseRecord[mapName] = {}
	end
	return UseRecord[mapName][id]

end

function HasUsedThisRun( id )

	local mapName = GetMapName({ })
	if CurrentRun.UseRecord[mapName] == nil then
		CurrentRun.UseRecord[mapName] = {}
	end
	return CurrentRun.UseRecord[mapName][id]

end

function RecordUse( id )

	if UseRecord == nil then
		UseRecord = {}
	end
	local mapName = GetMapName({ })
	if UseRecord[mapName] == nil then
		UseRecord[mapName] = {}
	end
	UseRecord[mapName][id] = true

	if CurrentRun.UseRecord[mapName] == nil then
		CurrentRun.UseRecord[mapName] = {}
	end
	CurrentRun.UseRecord[mapName][id] = true

end

OnUsed{
	function( triggerArgs )
		local usee = triggerArgs.AttachedTable
		local user = triggerArgs.TriggeredByTable
		if usee == nil then
			return
		end
		if usee.UnuseableWhenDead and usee.IsDead then
			return
		end
		if usee.OnUsedGameStateRequirements == nil or IsGameStateEligible( CurrentRun, usee, usee.OnUsedGameStateRequirements ) then

			if usee.RecordUse then
				RecordUse( triggerArgs.triggeredById )
			end

			if usee.DisableOnUse then
				UseableOff({ Id = triggerArgs.triggeredById })
			end

			if usee.UseSound ~= nil then
				PlaySound({ Name = usee.UseSound, Id = triggerArgs.triggeredById })
			end
			if usee.ShakeSelf ~= nil then
				Shake({ Id = triggerArgs.triggeredById, Distance = 2, Speed = 300, Duration = 0.15 })
			end
			if usee.ShakeIds ~= nil then
				Shake({ Ids = usee.ShakeIds, Distance = 2, Speed = 300, Duration = 0.15 })
			end
			if usee.OnUsedVoiceLines ~= nil then
				thread( PlayVoiceLines, usee.OnUsedVoiceLines, true )
			end
			if usee.OnUsedGlobalVoiceLines ~= nil then
				thread( PlayVoiceLines, GlobalVoiceLines[usee.OnUsedGlobalVoiceLines], true )
			end
			if usee.OnUsedSpawnUnit ~= nil then
				local enemyData = EnemyData[usee.OnUsedSpawnUnit]
				local newEnemy = DeepCopyTable( enemyData )
				newEnemy.ObjectId = SpawnUnit({ Name = enemyData.Name, Group = "Standing", DestinationId = usee.OnUsedSpawnOnId or triggerArgs.triggeredById })
				SetupEnemyObject( newEnemy, CurrentRun )
				if newEnemy.Binks ~= nil then
					PreLoadBinks({ Names = newEnemy.Binks })
				end
			end
			if usee.OnUsedFunctionName ~= nil then
				local onUsedFunction = _G[triggerArgs.AttachedTable.OnUsedFunctionName]
				if onUsedFunction ~= nil then
					onUsedFunction( usee, usee.OnUsedFunctionArgs, user )
				end
			end
			if usee.OnUsedTextLineSets ~= nil then
				PlayFirstEligibleTextLines( usee, usee.OnUsedTextLineSets )
			end
			if usee.OnUsedClampIds ~= nil then
				SetCameraClamp({ Ids = usee.OnUsedClampIds })
			end
			if usee.OnUsedMoveIds ~= nil then
				for id, destinationId in pairs( usee.OnUsedMoveIds ) do
					Move({ Id = id, DestinationId = destinationId, Duration = 3.0, SmoothStep = true })
				end
			end
			if usee.NotifyName ~= nil then
				notifyExistingWaiters( usee.NotifyName )
			end
		end
	end
}

function ChooseCharacterInteraction( npc, partner )
	if npc == nil then
		return
	end
	local heroId = CurrentRun.Hero.ObjectId

	local interactionName = npc.CharacterInteraction
	local interaction = nil
	if npc.CharacterInteractions ~= nil then
		interactionName = GetRandomKey( npc.CharacterInteractions )
		interaction = npc.CharacterInteractions[interactionName]
	end

	if interactionName == "Rescue" then
		RescueCharacterPresentation( heroId, npc, interaction )
	end

	ActivatedObjects[npc.ObjectId] = nil
	if partner ~= nil then
		ActivatedObjects[partner.ObjectId] = nil
	end

	wait( 0.2, RoomThreadName )
	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
	end

end

function SisyphusHealing( source, args )
	SetAnimation({ DestinationId = source.ObjectId, Name = "SisyphusElbowing" })
	DropHealth( "RoomRewardHealDrop", source.ObjectId, 130, 0, true )
end

function SisyphusMetaPoints( source, args )
	local consumableId = SpawnObstacle({ Name = "RoomRewardMetaPointDrop", DestinationId = source.ObjectId, Group = "Standing" })
	local cost = 0
	local consumable = CreateConsumableItem( consumableId, "RoomRewardMetaPointDrop", cost )
	local amount = RandomInt( source.MetaPointMin, source.MetaPointMax )
	consumable.AddResources = { MetaPoints = round( amount * CalculateMetaPointMultiplier() ) }
	SetAnimation({ DestinationId = source.ObjectId, Name = "SisyphusElbowing" })
	ApplyUpwardForce({ Id = consumableId, Speed = 700 })
	local forceAngle = GetAngleBetween({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	ApplyForce({ Id = consumableId, Speed = 100, Angle = forceAngle, SelfApplied = true })
end

function SisyphusMoney( source, args )
	local amount = RandomInt(  source.MoneyMin, source.MoneyMax )
	local moneyMultiplier = GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } )
	amount = round( amount * moneyMultiplier )
	SetAnimation({ DestinationId = source.ObjectId, Name = "SisyphusElbowing" })
	thread( GushMoney, { Amount = amount, LocationId = CurrentRun.Hero.ObjectId, Radius = 100, Source = "Sisyphus", } )
end

function PatroclusBuff( source, args )
	PatroclusPreBuffPresentation( source, args )
	if args.TraitName ~= nil then
		AddTraitToHero({ TraitData = TraitData[args.TraitName] })
	end
	if args.LastStand ~= nil then
		AddLastStand( args.LastStand )
	end
	PatroclusPostBuffPresentation( source, args )
end

function EurydiceBuff( source, args )
	EurydicePreBuffPresentation( source, args )
	if args.BoonRarity ~= nil then
		AddRarityToTraits( source, { NumTraits = 2 } )
	end
	if args.StackTraits ~= nil then
		AddStackToTraits( source, { NumTraits = 4, NumStacks = 1 } )
	end
	if args.BuffFutureRarity ~= nil then
		AddSuperRarityBoost()
	end
	EurydicePostBuffPresentation( source, args )
end

function HandleThanatosEncounterReward( thanatos, args )
	local encounter = CurrentRun.CurrentRoom.Encounter

	if (encounter.ThanatosKills or 0) > (encounter.PlayerKills or 0) then
		-- Player loss
		thread( MarkObjectiveComplete, "ThanatosKills" )
		thread( MarkObjectiveFailed, "PlayerKills" )
	else
		-- Player win
		thread( MarkObjectiveFailed, "ThanatosKills" )
		thread( MarkObjectiveComplete, "PlayerKills" )
		CheckAchievement( { Name = "AchCrushedThanatos", CurrentValue = encounter.PlayerKills - encounter.ThanatosKills })

		local consumableId = SpawnObstacle({ Name = "RoomRewardMaxHealthDrop", DestinationId = thanatos.ObjectId, Group = "Standing" })
		local cost = 0
		local consumable = CreateConsumableItem( consumableId, "RoomRewardMaxHealthDrop", cost )
		SetAnimation({ DestinationId = thanatos.ObjectId, Name = "ThanatosTalkDismissal_Return" })
		ActivatedObjects[consumable.ObjectId] = consumable
		ApplyUpwardForce({ Id = consumableId, Speed = 450 })
		local forceAngle = GetAngleBetween({ Id = thanatos.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		ApplyForce({ Id = consumableId, Speed = 200, Angle = forceAngle, SelfApplied = true })
		PlaySound({ Name = "/Leftovers/World Sounds/TrainingMontageWhoosh", Id = consumableId })

		if encounter.ThanatosKills == encounter.PlayerKills then
			thread( PlayVoiceLines, thanatos.EncounterTiedVoiceLines, nil, thanatos )
		else
			thread( PlayVoiceLines, thanatos.EncounterLostVoiceLines, nil, thanatos )
		end

	end

	CheckAvailableTextLines( thanatos )
	AngleTowardTarget({ Id = thanatos.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	if thanatos.NextInteractLines ~= nil then
		UseableOn({ Id = thanatos.ObjectId })
	else
		CheckDistanceTrigger( PresetEventArgs.ThanatosFarewells, thanatos )
		ActivatedObjects[thanatos.ObjectId] = nil
		wait( 0.2, RoomThreadName )
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
			UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
		end
	end

end

OnUsed{ "Loot",
    function( triggerArgs )
		local interactionBlocked = false
		if not CurrentRun.CurrentRoom.AlwaysAllowLootInteraction then
			for enemyId, enemy in pairs( ActiveEnemies ) do
				if enemy.BlocksLootInteraction then
					interactionBlocked = true
					break
					--DebugPrint({ Text = "blockedByEnemy = "..GetTableString( nil, enemy ) })
				end
			end
		end

		if interactionBlocked then
			local userTable = triggerArgs.TriggeredByTable
			thread( CannotUseLootPresentation, triggerArgs.triggeredById, userTable )
			CreateAnimation({ Name = "ShoutFlare", DestinationId = triggerArgs.triggeredById })
        elseif not AreScreensActive() then

			if triggerArgs.AttachedTable.Cost ~= nil and triggerArgs.AttachedTable.Cost > CurrentRun.Money then
				CantAffordPresentation( triggerArgs.AttachedTable )
				return
			end
			if triggerArgs.AttachedTable.Cost ~= nil and triggerArgs.AttachedTable.Cost > 0 then
				triggerArgs.AttachedTable.Purchased = true
				SpendMoney( triggerArgs.AttachedTable.Cost, triggerArgs.AttachedTable.Name or "Loot" )
				RemoveStoreItem({Name = triggerArgs.AttachedTable.Name, IsBoon = true, BoonRaritiesOverride = triggerArgs.AttachedTable.BoonRaritiesOverride, StackNum = triggerArgs.AttachedTable.StackNum })
				PlaySound({ Name = "/Leftovers/Menu Sounds/StoreBuyingItem" })
				thread( PlayVoiceLines, GlobalVoiceLines.PurchasedConsumableVoiceLines, true )
			end

			if triggerArgs.AttachedTable.RarityBoosted then
				UseHeroTraitsWithValue("RarityBonus", true )
			end
			
			SetPlayerInvulnerable( "HandleLootPickupAnimation" )
			PlayInteractAnimation( triggerArgs.triggeredById )
            HandleLootPickup( CurrentRun, triggerArgs.AttachedTable )
        	SetPlayerVulnerable( "HandleLootPickupAnimation" )
		end
    end
}

function HandleLootPickup( currentRun, loot )
	local checkingMeterUnlock = GiftData[loot.Name] and not IsGameStateEligible(CurrentRun, GiftData[loot.Name].UnlockGameStateRequirements )
	SetPlayerInvulnerable( "HandleLootPickup" )
	AddTimerBlock( currentRun, "HandleLootPickup" )

	local lootId = loot.ObjectId

	CurrentLootData = loot
	SetLightBarColor({ PlayerIndex = 1, Color = loot.LootColor });

	local hasDuoBoon = false
	if loot.UpgradeOptions ~= nil then
		for i, itemData in pairs(loot.UpgradeOptions) do
			if itemData.Type == "Trait" and TraitData[itemData.ItemName] and TraitData[itemData.ItemName].IsDuoBoon then
				hasDuoBoon = true
			end
		end
	end

	PlaySound({ Name = loot.PickupSound or "/SFX/Menu Sounds/GodBoonInteract" })
	thread( PlayVoiceLines, loot.PickupVoiceLines, true )

	if ForceEvent ~= nil and ForcePlayTextLines( loot, ForceEvent ) then
		-- Skip normal lines
	elseif loot.ForcedTextLines ~= nil then
		PlayRandomRemainingTextLines( loot, loot.ForcedTextLines )
	elseif hasDuoBoon and not currentRun.HadDuoConversation then
		currentRun.HadDuoConversation = PlayRandomRemainingTextLinesOnceThisRun( loot, loot.DuoPickupTextLineSets )
	elseif loot.BoughtFromShop and loot.BoughtTextLines then
		PlayRandomRemainingTextLinesOnceThisRun( loot, loot.BoughtTextLines )
	elseif CurrentRun.CurrentRoom.RejectedLootData ~= nil and CurrentRun.CurrentRoom.RejectedLootData.Name == loot.Name then
		PlayRandomRemainingTextLines( loot, loot.MakeUpTextLines )
		CurrentRun.CurrentRoom.RejectedLootData = nil
	elseif not HasPlayedAnyTextLines( CurrentRun, loot.SuperPriorityPickupTextLineSets ) and not HasPlayedAnyTextLines( CurrentRun, loot.PriorityPickupTextLineSets ) and not HasPlayedAnyTextLines( CurrentRun, loot.PickupTextLineSets ) then
		if not PlayRandomRemainingTextLines( loot, loot.SuperPriorityPickupTextLineSets ) then
			if not PlayRandomRemainingTextLines( loot, loot.PriorityPickupTextLineSets ) then
				PlayRandomRemainingTextLines( loot, loot.PickupTextLineSets )
			end
		end
	else
		AddInputBlock({ Name = "LootPickupFunction" })
		local globalVoiceLines = GlobalVoiceLines[loot.PickupGlobalVoiceLines or "BoonUsedVoiceLines"]
		if globalVoiceLines ~= nil then
			thread( PlayVoiceLines, globalVoiceLines, true )
		end
		local pickupFunction = _G[loot.PickupFunctionName or "BoonInteractPresentation"]
		if pickupFunction ~= nil then
			pickupFunction( loot, { PickupWait = 1.15 } )
		end
		RemoveInputBlock({ Name = "LootPickupFunction" })
	end

	AddInputBlock({ Name = "HandleLootPickup" })

	if CurrentRun.LootTypeHistory[loot.Name] == nil then
		CurrentRun.LootTypeHistory[loot.Name] = 0
	end
	currentRun.LootTypeHistory[loot.Name] = currentRun.LootTypeHistory[loot.Name] + 1

	if loot.RespawnAfterUse then
		local newLoot = CreateLoot({ Name = loot.Name, LootData = loot, SpawnPoint = lootId })
		newLoot.UpgradeOptions = nil
	end
	if loot.WipeRecordsAfterUse then
		TextLinesRecord = {}
		CurrentRun.TextLinesRecord = {}
	end
	Destroy({ Id = lootId })
	ActivatedObjects[lootId] = nil

	RemoveInputBlock({ Name = "HandleLootPickup" })
	RemoveTimerBlock( currentRun, "HandleLootPickup" )

	if HasExchangeOnLoot( loot ) and GetNumMetaUpgrades("ReducedLootChoicesShrineUpgrade") == 0 then
		thread( PlayVoiceLines, HeroVoiceLines.UpgradeMenuOpenVoiceLines, true )
	else
		thread( PlayVoiceLines, loot.UpgradeMenuOpenVoiceLines, true )
	end

	if not GameData.MissingPackages[loot.Name] then
		LoadPackages({ Name = loot.Name })
	end
	OpenUpgradeChoiceMenu( loot )

	if loot.PostPickupFunction ~= nil then
		local postPickupFunction = _G[loot.PostPickupFunction]
		postPickupFunction(loot, loot.PostPickupFunctionArgs)
	end

	SetPlayerVulnerable( "HandleLootPickup" )
	if checkingMeterUnlock and IsGameStateEligible(CurrentRun, GiftData[loot.Name].UnlockGameStateRequirements ) then
		thread( GiftTrackUnlockedPresentation, loot.Name )
	end
end

function ProcessLoot( currentRun, lootName, weaponName )

	AddHeroWeaponUpgrade(weaponName, lootName)

	DebugPrint({ Text = "    ApplyWeaponUpgrade: "..lootName.." to "..weaponName })

	local lootData = LootData[lootName]
	AddOnDamageWeapons( currentRun.Hero, weaponName, lootData )
	ApplyWeaponPropertyChanges( currentRun.Hero, weaponName, lootData.PropertyChanges )
	PlaySound({ Name = lootData.PurchaseSound or "/Leftovers/SFX/StaminaSkillProc", Id = lootId })
	thread( PlayVoiceLines, lootData.SlottedVoiceLines, true )

end

OnUsed{ "HealthFountain HealthFountainAsphodel HealthFountainElysium HealthFountainStyx",
	function( triggerArgs )

		local used = triggerArgs.AttachedTable

		UseableOff({ Id = triggerArgs.triggeredById })
		PlayInteractAnimation( triggerArgs.triggeredById )

		if used.HealingSpentAnimation then
			SetAnimation({ Name = used.HealingSpentAnimation, DestinationId = used.ObjectId })
		end

		ActivatedObjects[triggerArgs.triggeredById] = nil

		wait(0.4)

		PlaySound({ Name = "/Leftovers/SFX/StaminaRefilled", Id = CurrentRun.Hero.ObjectId })

		if used.UsedText ~= nil then
			thread( InCombatText, CurrentRun.Hero.ObjectId, used.UsedText, 2.5, {Group = "Overlay" })
		end

		local healFraction = used.HealFraction + GetTotalHeroTraitValue( "FountainHealFractionBonus" )
		local healFractionOverride = GetTotalHeroTraitValue("FountainHealFractionOverride") 
		if healFractionOverride > 0 then
			healFraction = healFractionOverride
		end

		healFraction = healFraction * CalculateHealingMultiplier()
		Heal( CurrentRun.Hero, { HealFraction = healFraction, SourceName = "HealthFountain" } )
		thread(UpdateHealthUI)

		wait( 0.2, RoomThreadName )
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
			UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
		end

		local hasDamageBonus = false
		for k, traitData in pairs(CurrentRun.Hero.Traits) do
			if traitData.FountainDamageBonus then
				hasDamageBonus = true
				traitData.AccumulatedFountainDamageBonus = traitData.AccumulatedFountainDamageBonus + (traitData.FountainDamageBonus - 1)
				ExtractValues( CurrentRun.Hero, traitData, traitData )
			end
		end
		if hasDamageBonus then
			FountainDamagePresentation()
		end
	end
}

function UseStyxFountain( usee, args )
	local fountain = usee
	if CheckCooldown(fountain.CooldownNamePrefix..fountain.ObjectId, fountain.CooldownDuration) then
		ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "StyxPoison" })
		BlockEffect({ Id = CurrentRun.Hero.ObjectId, Name = "StyxPoison", Duration = 0.75 })
		SetAnimation({ DestinationId = fountain.ObjectId, Name = fountain.OnCooldownAnimation })
		UseableOff({ Id = fountain.ObjectId })
		CureFountainReady( fountain )
	end
end


function CureFountainReady(fountain)
	wait( fountain.CooldownDuration, RoomThreadName )
	SetAnimation({ DestinationId = fountain.ObjectId, Name = fountain.IdleAnimation })
	UseableOn({ Id = fountain.ObjectId })
end


function CreateConsumableItem( consumableId, consumableName, costOverride )
	if consumableName == nil then
		return
	end

	local consumableData = ConsumableData[consumableName]
	if consumableData == nil then
		DebugAssert({ Condition = consumableData ~= nil, Text = "Missing ConsumableData for "..consumableName })
		return
	end
	local consumableItem = GetRampedConsumableData( consumableData )
	if consumableData ~= nil and consumableData.SpawnSound ~= nil then
		PlaySound({ Name = consumableData.SpawnSound, Id = consumableId })
	end
	return CreateConsumableItemFromData( consumableId, consumableItem, costOverride )
end

function CreateConsumableItemFromData( consumableId, consumableItem, costOverride, args )
	args = args or {}
	consumableItem.ObjectId = consumableId
	AttachLua({ Id = consumableId, Table = consumableItem })
	AddToGroup({ Id = consumableId, Name = "ConsumableItems" })

	if args ~= nil and args.HideWorldTextOverride ~= nil then
		consumableItem.HideWorldText = args.HideWorldTextOverride
	end

	if not consumableItem.HideWorldText then
		CreateTextBox({ Id = consumableId, Text = consumableItem.Name, FontSize = 20, OffsetY = 50, Color = Color.White, Justification = "CENTER" })
	end

	if costOverride then
		consumableItem.Cost = costOverride
	end

	local costMultiplier = 1 + ( GetNumMetaUpgrades( "ShopPricesShrineUpgrade" ) * ( MetaUpgradeData.ShopPricesShrineUpgrade.ChangeValue - 1 ) )
	costMultiplier = costMultiplier * GetTotalHeroTraitValue("StoreCostMultiplier", {IsMultiplier = true})
	if costMultiplier ~= 1 and ( consumableItem.IgnoreCostIncrease == nil or costMultiplier < 1 ) then
		consumableItem.Cost = round( consumableItem.Cost * costMultiplier )
	end

	if consumableItem.AddResources ~= nil and consumableItem.AddResources.MetaPoints ~= nil then
		consumableItem.AddResources.MetaPoints = round( consumableItem.AddResources.MetaPoints * CalculateMetaPointMultiplier() )
	end
	if consumableItem.AddResources ~= nil and consumableItem.AddResources.Gems ~= nil then
		consumableItem.AddResources.Gems = round( consumableItem.AddResources.Gems * GetTotalHeroTraitValue( "GemMultiplier", { IsMultiplier = true } ))
	end

	UpdateCostText( consumableItem )

	return consumableItem
end

function ApplyConsumableItemResourceMultiplier( currentRoom, reward )
	local gemRewardMultiplier = GetTotalHeroTraitValue("GemRewardBonus", { IsMultiplier = true })
	local metapointRewardMultiplier = GetTotalHeroTraitValue("MetapointRewardBonus", { IsMultiplier = true })
	local coinRewardMultiplier = GetTotalHeroTraitValue("MoneyRewardBonus", { IsMultiplier = true })
	local healthRewardMultiplier = GetTotalHeroTraitValue("HealthRewardBonus", { IsMultiplier = true })
	if reward.AddResources ~= nil then
		if reward.AddResources.Gems ~= nil then
			reward.AddResources.Gems = round( reward.AddResources.Gems * gemRewardMultiplier )
		end
		if reward.AddResources.MetaPoints ~= nil then
			reward.AddResources.MetaPoints = round( reward.AddResources.MetaPoints * metapointRewardMultiplier )
		end
	end
	if reward.AddMaxHealth ~= nil then
		reward.AddMaxHealth = round( reward.AddMaxHealth * healthRewardMultiplier )
	end
	
	local rewardOverrides = currentRoom.RewardConsumableOverrides or currentRoom.RewardOverrides
	if rewardOverrides ~= nil and ( rewardOverrides.ValidRewardNames == nil or Contains( rewardOverrides.ValidRewardNames, reward.Name )) then
		for key, value in pairs( rewardOverrides ) do
			if reward[key] ~= nil then
				reward[key] = value
				if key == "AddResources"  then
					if reward.AddResources.MetaPoints ~= nil and not currentRoom.IgnoreMetaPointMultiplier then
						reward.AddResources.MetaPoints = round( reward.AddResources.MetaPoints * ( 1 + (  CalculateMetaPointMultiplier() - 1 ) + ( metapointRewardMultiplier - 1 )))
					end
					if reward.AddResources.Gems ~= nil then
						reward.AddResources.Gems = round( reward.AddResources.Gems * gemRewardMultiplier )

						local gemMultiplier = GetTotalHeroTraitValue( "GemMultiplier", { IsMultiplier = true } )
						reward.AddResources.Gems = round( reward.AddResources.Gems * ( 1 + ( gemMultiplier - 1 ) + ( gemRewardMultiplier - 1 )))
					end
				elseif key == "AddMaxHealth" and reward.AddMaxHealth ~= nil then
					reward.AddMaxHealth = round( reward.AddMaxHealth * healthRewardMultiplier )
					ExtractValues( CurrentRun.Hero, reward, reward )
				end
			end
		end
	end

	if reward.DropMoney ~= nil then
		local moneyMultiplier = GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } )
		reward.DropMoney = round( reward.DropMoney * ( 1 + ( moneyMultiplier - 1 ) + ( coinRewardMultiplier - 1 )))
	end
end

OnUsed{ "ConsumableItems",
	function( triggerArgs )
		local currentRun = CurrentRun
		if currentRun.Hero.HandlingDeath then
			return
		end

		local consumableItem = triggerArgs.AttachedTable

		if consumableItem.Cost ~= nil and consumableItem.Cost > CurrentRun.Money then
			CantAffordPresentation( consumableItem )
			return
		end
		if consumableItem.Cost ~= nil and consumableItem.Cost > 0 and consumableItem.PurchaseRequirements ~= nil and not IsGameStateEligible( currentRun, consumableItem.PurchaseRequirements ) then
			CantPurchaseWorldItemPresentation( consumableItem )
			return
		end
		PurchaseConsumableItem( currentRun, consumableItem, triggerArgs )
	end
}

function PurchaseConsumableItem( currentRun, consumableItem, args )

	if not consumableItem.IgnorePurchase then
		ConsumableUsedPresentation( currentRun, consumableItem, args )

		IncrementTableValue( GameState.ItemInteractions, consumableItem.Name )
		CheckCodexUnlock( "Items", GetGenusName( consumableItem ))

		currentRun.ConsumableRecord[consumableItem.Name] = (currentRun.ConsumableRecord[consumableItem.Name] or 0) + 1

		RemoveStoreItem({ Name = consumableItem.Name })
		SpendMoney( consumableItem.Cost, consumableItem.Name or "Item" )
	end

	if consumableItem.AddAmmo ~= nil then
		RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "RangedWeapon", Method = "AddAmmo", Parameters = { consumableItem.AddAmmo } })
		if HeroHasTrait("SwordAmmoWaveTrait") then
			FireWeaponFromUnit({ Weapon = "AmmoWaveEffectApplicator", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
			CurrentRun.Hero.StoredAmmoWave = true
		end
		AddAmmoPresentation()
	end

	if consumableItem.AddMeter ~= nil then
		BuildSuperMeter( currentRun, consumableItem.AddMeter )
	end

	if consumableItem.HealFraction ~= nil then
		local healFraction = consumableItem.HealFraction
		healFraction = healFraction * CalculateHealingMultiplier()
		Heal( CurrentRun.Hero, { HealFraction = healFraction, SourceName = consumableItem.Name or "Item" } )
		thread( UpdateHealthUI )
	end

	if consumableItem.HealFixed ~= nil then
		local healAmount = consumableItem.HealFixed * CalculateHealingMultiplier()
		healAmount = round( healAmount * GetTotalHeroTraitValue("MaxHealthMultiplier", { IsMultiplier = true }) )
		Heal( CurrentRun.Hero, { HealAmount = healAmount, SourceName = consumableItem.Name or "Item" } )
		thread( UpdateHealthUI )
	end

	if consumableItem.AddMoney ~= nil then
		AddMoney( consumableItem.AddMoney, consumableItem.Name or "Item" )
	end

	if consumableItem.AddMaxHealth ~= nil then
		AddMaxHealth( consumableItem.AddMaxHealth, consumableItem, consumableItem.AddMaxHealthArgs )
	end

	if consumableItem.HealthCost ~= nil then
		SacrificeHealth({ SacrificeHealth = consumableItem.HealthCost, MinHealth = 1 })
	end

	if consumableItem.DropMoney ~= nil then
		thread( GushMoney, { Amount = consumableItem.DropMoney, LocationId = consumableItem.ObjectId, Source = consumableItem.Name, Delay = consumableItem.DropMoneyDelay, Radius = consumableItem.DropMoneyRadius } )
	end

	if consumableItem.AddResources ~= nil then
		for resourceName, count in pairs( consumableItem.AddResources ) do
			AddResource( resourceName, count, consumableItem.Name, { Silent = false, ApplyMultiplier = not consumableItem.PreApplyMetaPointMultiplier } )
		end
	end

	if consumableItem.AddRerolls ~= nil then
		AddRerolls( consumableItem.AddRerolls, consumableItem, consumableItem.AddRerollArgs )
	end

	if consumableItem.AddStackTraits ~= nil then
		AddStackToTraits( consumableItem, { NumTraits = consumableItem.AddStackTraits, NumStacks = 1, Thread = consumableItem.AddStackTraitsThread, Delay = consumableItem.AddStackTraitsDelay } )
	end

	if consumableItem.GiveObjectiveSet ~= nil then
		CheckObjectiveSet( consumableItem.GiveObjectiveSet )
	end

	if consumableItem.UseFunctionName ~= nil then
		_G[consumableItem.UseFunctionName]( consumableItem.UseFunctionArgs )
	end

	if consumableItem.ReplaceWithRandomLoot ~= nil then
		thread( UnwrapRandomLoot, consumableItem.ObjectId )
	end

	if consumableItem.UseFunctionNames ~= nil then
		for i, functionName in ipairs(consumableItem.UseFunctionNames) do
			_G[functionName]( consumableItem.UseFunctionArgs[i] )
		end
	end

	if consumableItem.UseThreadedFunctionNames ~= nil then
		for i, functionName in ipairs(consumableItem.UseThreadedFunctionNames) do
			thread(_G[functionName], consumableItem.UseThreadedFunctionArgs[i] )
		end
	end

	ActivatedObjects[consumableItem.ObjectId] = nil

	Destroy({ Id = consumableItem.ObjectId })

	wait( 0.2, RoomThreadName )
	if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
		UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom, consumableItem.ExitUnlockDelay )
	end

end

function GushMoney( args )
	-- source might be destroyed after this is called so we create a target
	if args.Radius == nil then
		args.Radius = 100
	end
	local generatedSpawnId = nil
	if args.LocationId then
		generatedSpawnId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = args.LocationId, Group = "Standing" })
		args.LocationId = generatedSpawnId
	end

	wait( args.Delay )
	local money = round( args.Amount )
	local minDrop = math.max( 5, money / 10 )
	local maxDrop = math.max( 25, money / 4)
	while money > 0 do
		local moneyDrop = RandomInt( math.min( money, minDrop ), math.min( money, maxDrop ) )
		DropMoney( moneyDrop, args )
		money = money - moneyDrop
		wait( RandomFloat( 0.03, 0.07 ) )
	end

	if generatedSpawnId then
		Destroy({ Id = generatedSpawnId })
	end
end

function GetSecretDoorCost()
	local multiplier = 1
	local traitEffects = GetHeroTraitValues("SecretDoorCostMultiplier")
	for i, value in pairs(traitEffects) do
		multiplier = multiplier * value
	end
	local costBase = CurrentRun.Hero.SecretDoorCostBase or 10
	local costScalar = CurrentRun.Hero.SecretDoorCostDepthScalar or 0.5
	local costRamp = GetRunDepth( CurrentRun ) * costScalar
	return math.ceil( multiplier * ( costBase + costRamp ) )
end

function GetRampedConsumableData( consumableData, rarity )
	-- TODO(Dexter) Determinism?
	local rampedData = DeepCopyTable( consumableData )
	local rarityMultiplier = 1
	if rarity ~= nil and rampedData.RarityLevels[rarity] then
		local rarityData = rampedData.RarityLevels[rarity]
		if rarityData.Multiplier ~= nil then
			rarityMultiplier = rarityData.Multiplier
		else
			rarityMultiplier = RandomFloat(rarityData.MinMultiplier, rarityData.MaxMultiplier)
		end
	end

	for key, value in pairs( rampedData ) do
		if key ~= "ConsumedVoiceLines" and key ~= "OnSpawnVoiceLines" then
			rampedData[key] = GetProcessedValue(value, { NumExisting = 0, RarityMultiplier = rarityMultiplier })
		end
	end
	if rampedData.AddResources ~= nil then
		for key, value in pairs( rampedData.AddResources ) do
			rampedData.AddResources[key] = GetProcessedValue(value, { NumExisting = 0, RarityMultiplier = rarityMultiplier })
		end
	end

	ExtractValues( CurrentRun.Hero, rampedData, rampedData )
	if rampedData.HealCostPerPercent ~= nil then
		rampedData.Cost = round(rampedData.HealCostPerPercent * rampedData.HealFraction * 100)
	end
	if rampedData.CostPerMetaPoint ~= nil then
		rampedData.Cost = round(rampedData.CostPerMetaPoint * rampedData.AddResources.MetaPoints)
	end
	if rampedData.CostPerGem ~= nil then
		rampedData.Cost = round(rampedData.CostPerGem * rampedData.AddResources.Gems)
	end
	if rampedData.PayoutPerHealthPoint ~= nil then
		if HasHeroTraitValue("BlockMoney") then
			rampedData.DropMoney = 0
		else
			rampedData.DropMoney = round(rampedData.PayoutPerHealthPoint * rampedData.HealthCost)
		end
	end

	if rampedData.UseFunctionArgs ~= nil then
		if rampedData.UseFunctionName ~= nil then
			if rampedData.UseFunctionArgs.TraitName ~= nil then
				local processedTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = rampedData.UseFunctionArgs.TraitName })
				SetTraitTextData( processedTraitData )
				rampedData.TraitData = processedTraitData
			end
		end
		if rampedData.UseFunctionNames ~= nil then
			for i, data in pairs(rampedData.UseFunctionArgs) do
				if data.TraitName ~= nil then
					local processedTraitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = data.TraitName })
					SetTraitTextData( processedTraitData )
					rampedData.TraitData = processedTraitData
				end
			end
		end
	end

	return rampedData
end

function DelayedHeal( delay, amount, source )
	wait( delay )
	Heal( CurrentRun.Hero, { HealAmount = amount, SourceName = source } )
end

function SacrificeHealth( args )
	if args.SacrificeHealth == nil and ( args.SacrificeHealthMin == nil or args.SacrificeHealthMax == nil )then
		return 0
	end
	local randomDamageValue = args.SacrificeHealth
	if randomDamageValue == nil then
		randomDamageValue = RandomInt( args.SacrificeHealthMin, args.SacrificeHealthMax )
	end
	if randomDamageValue <= 0 then
		return randomDamageValue
	end
	Damage( CurrentRun.Hero, { triggeredById = CurrentRun.Hero.ObjectId, DamageAmount = randomDamageValue, MinHealth = args.MinHealth, PureDamage = true, Silent = args.Silent } )
	if not args.Silent then
		CreateAnimation({ Name = "SacrificeHealthFx", DestinationId = CurrentRun.Hero.ObjectId })
	end
	return randomDamageValue
end

function SacrificeHealthAndHeal( args )
	local healAmount = math.ceil(SacrificeHealth( args ) * args.HealMultiplier)
	wait(1.5)
	local currentHealthFraction = CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth
	if currentHealthFraction < 1.0 then
		Heal( CurrentRun.Hero, { HealAmount = healAmount, SourceName = "SacrificeHealthAndHeal" } )
		thread( InCombatText, CurrentRun.Hero.ObjectId, "PlayerHealed_Amount", 1.5 , { LuaKey = "TempTextData", LuaValue = {Amount = healAmount} })
		thread(UpdateHealthUI)
	end
end

function SacrificeDoubleBoon( args )
	SacrificeHealth( args )
	wait(1.0)
	GiveLoot({ OffsetX = 0 })
	GiveLoot({ OffsetX = 100 })
end

function AttemptPanelReroll( screen, button )

	local cost = button.Cost
	if CurrentRun.NumRerolls < cost or cost < 0 then
		CannotRerollPanelPresentation( button )
		return
	end

	AddInputBlock({ Name = "AttemptPanelReroll" })
	HideTopMenuScreenTooltips({ Id = button.Id })
	CurrentRun.NumRerolls = CurrentRun.NumRerolls - cost
	CurrentRun.CurrentRoom.SpentRerolls = CurrentRun.CurrentRoom.SpentRerolls or {}
	IncrementTableValue( CurrentRun.CurrentRoom.SpentRerolls, button.RerollId, RerollCosts.ReuseIncrement )
	UpdateRerollUI( CurrentRun.NumRerolls )

	RandomSynchronize( CurrentRun.NumRerolls )
	InvalidateCheckpoint()

	if button.RerollFunctionName and _G[button.RerollFunctionName] then
		RerollPanelPresentation( screen, button )
		_G[button.RerollFunctionName](  )
	end
	RemoveInputBlock({ Name = "AttemptPanelReroll" })
end

function AttemptReroll( run, target )

	if run.NumRerolls <= 0 then
		return
	end

	if target == nil or not target.CanBeRerolled then
		return
	end

	local rerollFunction = _G[target.RerollFunctionName]
	if rerollFunction == nil then
		return
	end

	run.NumRerolls = run.NumRerolls - 1
	UpdateRerollUI( run.NumRerolls )

	RandomSynchronize( run.NumRerolls )

	AddInputBlock({ Name = "AttemptReroll" })
	PreRerollPresentation( run, target )
	rerollFunction( run, target )
	PostRerollPresentation( run, target )

	InvalidateCheckpoint()

	RemoveInputBlock({ Name = "AttemptReroll" })
end

function AttemptRerollDoor( run, door )

	local room = door.Room

	local rewardsChosen = {}
	if room.OriginalChosenRewardType == nil then
		room.OriginalChosenRewardType = room.ChosenRewardType
	end
	if room.OriginalForceLootName == nil then
		room.OriginalForceLootName = room.ForceLootName
	end
	table.insert( rewardsChosen, { RewardType = room.OriginalChosenRewardType, ForceLootName = room.OriginalForceLootName })
	for index, offeredDoor in pairs( OfferedExitDoors ) do
		if offeredDoor.Room ~= nil then
			table.insert( rewardsChosen, { RewardType = offeredDoor.Room.ChosenRewardType, ForceLootName = offeredDoor.Room.ForceLootName })
		end
	end

	-- Remove the existing reward
	room.ForceLootName = nil
	room.RewardOverrides = nil
	if room.Encounter ~= nil then
		room.Encounter.LootAName = nil
		room.Encounter.LootBName = nil
		room.Encounter = nil
	end

	run.CurrentRoom.DeferReward = false
	room.ChosenRewardType = ChooseRoomReward( run, room, room.RewardStoreName, rewardsChosen, { IgnoreGameStateRequirements = true, } )
	SetupRoomReward( run, room, rewardsChosen )
	run.CurrentRoom.OfferedRewards[door.ObjectId] = { Type = room.ChosenRewardType, ForceLootName = room.ForceLootName, UseOptionalOverrides = room.UseOptionalOverrides }

	CreateDoorRewardPreview( door )

	RefreshUseButton( door.ObjectId, door )

end

function AttemptRerollStoreItemInWorld( run, item )

	-- Remove the existing item
	Destroy({ Id = item.ObjectId })

	local replacementStore = FillInShopOptions({ RoomName = CurrentRun.CurrentRoom.Name, StoreData = StoreData.WorldShop })
	local replacementItem = RemoveRandomValue( replacementStore.StoreOptions )
	DebugPrint({ Text = "replacementItem.Name = "..replacementItem.Name })
	SpawnStoreItemInWorld( replacementItem, item.SpawnPointId )

end

function PressAndHold( interactId, controlName, callbackFunctionName )
	local ticks = 0
	local displayOffsetY = -190
	local holdComplete = false

	ScreenAnchors.HoldDisplayId = SpawnObstacle({ Name = "BlankObstacle", Group = "Events", DestinationId = interactId })
	Attach({ Id = ScreenAnchors.HoldDisplayId, DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.1)

	while IsControlDown({ Name = controlName }) do
		ticks = ticks + 1
		if ticks == 1 then
			CreateAnimation({ Name = "PortraitRespawnFillHalfSec", DestinationId = ScreenAnchors.HoldDisplayId, OffsetX = 0, OffsetY = doorDisplayOffsetY, Scale = 0.5 })

			CreateTextBox({ Id = ScreenAnchors.HoldDisplayId, Text = "UseDoorGeneric", FontSize = 16, OffsetX = 0, OffsetY = displayOffsetY + 40, Color = Color.Gold, Font = "AlegreyaSCRegular", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })

			PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract", Id = ScreenAnchors.HoldDisplayId })
		elseif ticks == 7 then
			CreateAnimation({ Name = "PortraitRespawnComplete", DestinationId = ScreenAnchors.HoldDisplayId, Scale = 1.0, OffsetX = 0, OffsetY = displayOffsetY, Scale = 0.5 })

			wait(0.32)

			local callbackFunction = _G[callbackFunctionName]
			callbackFunction( interactId )
			holdComplete = true
			break
		end

		wait(0.1)
	end

	if not holdComplete then
		StopAnimation({ DestinationId = ScreenAnchors.HoldDisplayId, Names = openAnim, PreventChain = true })
		ModifyTextBox({ Ids = ScreenAnchors.HoldDisplayId, FadeTarget = 0.0, Duration = 0.25 })
		ScreenAnchors.HoldDisplayId = nil
	end
end

function AddKeepsakeCharge( args )
	args = args or {}
	if args.Thread then
		args.Thread = false
		thread( AddKeepsakeCharge, args )
		return
	end
	wait( args.Delay )

	local numCharges = args.NumCharges or 1

	for i, traitData in pairs( CurrentRun.Hero.Traits ) do
		if traitData.AddAssist then
			AddKeepsakeChargePresentation( traitData )
			traitData.RemainingUses = traitData.RemainingUses or 0
			traitData.RemainingUses = traitData.RemainingUses + numCharges
			UpdateTraitNumber(traitData)
			break
		end
	end
end

function AddAspectRarity( args )
	args = args or {}
	if args.Thread then
		args.Thread = false
		thread( AddAspectRarity, args )
		return
	end
	wait( args.Delay )

	local numCharges = args.NumCharges or 1
	local currentWeaponInSlot = GetEquippedWeapon()
	local traitName = GetWeaponUpgradeTrait(currentWeaponInSlot, GameState.LastWeaponUpgradeData[currentWeaponInSlot].Index)
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.Name == traitName then
			local rarity = trait.Rarity
			if rarity == "Heroic" then
				-- Normally legendary isn't a valid upgrade from heroic, but for aspects they are
				rarity = "Legendary"
			else
				rarity = GetUpgradedRarity(trait.Rarity)
			end
			RemoveTraitData( CurrentRun.Hero, trait )
			AddTraitToHero({ TraitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = trait.Name, Rarity = rarity }) })
			break
		end
	end
end