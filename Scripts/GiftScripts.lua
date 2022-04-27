function InitializeGiftData()
	GameState.Gift = {}
	for key, value in pairs(GiftData) do
		GameState.Gift[key] = {}
		GameState.Gift[key].Value = GiftData[key].Value
	end
end

OnControlPressed{ "Gift",
	function( triggerArgs )
		local target = triggerArgs.UseTarget
		if target == nil then
			return
		end
		if target.ReadyToUse then
			if target.CanBeRerolled then
				AttemptReroll( CurrentRun, target )
				return
			elseif CurrentRun.NumRerolls > 0 and target.RerollFunctionName ~= nil and IsMetaUpgradeSelected( "RerollMetaUpgrade" ) then
				CannotRerollPresentation( run, target )
				return
			end
		end
		AttemptGift( CurrentRun, target )
	end
}

function AttemptGift( CurrentRun, target )

	if PlayingTextLines or not IsInputAllowed({ }) then
		return
	end

	if target == nil then
		-- thread( PlayVoiceLines, HeroVoiceLines.NotReadyVoiceLines, true )
		return
	end

	local name = GetGenusName( target )
	local resourceName = GetNextGiftResource( name )
	local resourceQuantity = GetNextGiftResourceQuantity( name )

	if not HasResource( resourceName, resourceQuantity ) then
		return
	end
	if CanReceiveGift( target ) then
		AddTimerBlock( CurrentRun, "ZagreusGift" )
		AddInputBlock({ Name = "Gifting" })
		SetPlayerInvulnerable( "Gift" )
		target.ReceivingGift = true
		CurrentRun.GiftRecord[name] = true
		HideUseButton( target.ObjectId, target )
		FreezePlayerUnit( "Gift" )
		SpendResource(  resourceName, resourceQuantity, name )
		thread( MarkObjectiveComplete, "GiftPrompt" )
		IncrementGiftMeter( name )
		local giftAnimation = "GiftNPC"
		if resourceName == "SuperGiftPoints" then
			giftAnimation = "SuperGiftNPC"
		end
		ReceivedGiftPresentation( target, giftAnimation )
		RemoveInputBlock({ Name = "Gifting" })
		if target.Name and GiftData[target.Name] and GiftData[target.Name].InfiniteGifts then
			PlayRandomRemainingTextLines( target, target.GiftTextLineSets )
		else
			PlayFirstEligibleTextLines( target, target.GiftTextLineSets )
		end
		ReceivedGiftPresentationPost( target )

		SelectCodexEntry( name )

		IncrementTableValue( GameState.NPCInteractions, name )
		CheckCodexUnlock( "OlympianGods", name )
		CheckCodexUnlock( "ChthonicGods", name )
		CheckCodexUnlock( "OtherDenizens", name )

		SetAvailableUseText( target )
		if not HasResource( "GiftPoints" ) and not IsEmpty( ActiveEnemies ) then
			for id, unit in pairs( ActiveEnemies ) do
				SetAvailableUseText( unit )
			end
		end

		if target.NextInteractLines and not target.StatusAnimation then
			SetStatusAnimationFromTextLines( target, target.NextInteractLines )
		end

		if GetGiftLevelData(name) ~= nil and GetGiftLevelData(name).Gift ~= nil then
			if GameState.Gift[name].NewTraits == nil then
				GameState.Gift[name].NewTraits = {}
			end
			table.insert( GameState.Gift[name].NewTraits, GetGiftLevelData(name).Gift )
			wait( 1.0, RoomThreadName )
			PlayerReceivedGiftPresentation( target, GetGiftLevelData(name).Gift )
			CheckAchievement( { Name = "AchFoundKeepsakes" } )
		end

		SetPlayerVulnerable( "Gift" )
		UnfreezePlayerUnit( "Gift" )
		RemoveTimerBlock( CurrentRun, "ZagreusGift" )
		target.ReceivingGift = false

		if HasCodexEntry( name ) then
			thread( ShowCodexUpdate, { Animation = "CodexHeartUpdateIn" })
		end
	else
		if target.InPartnerConversation then
			thread( PlayVoiceLines, HeroVoiceLines.CannotGiftVoiceLines )
		end
	end
end

function GetGiftLevel( npcName )
	if GameState.Gift[npcName] == nil then
		return 0
	end

	return GameState.Gift[npcName].Value
end

function GetGiftLevelData( npcName, level )
	if GiftData[npcName] == nil then
		return
	end

	if level == nil then
		level = GetGiftLevel( npcName )
	end

	return GiftData[npcName][level]
end

function CanReceiveGift( npcData )
	local textLineSets = npcData.InteractTextLineSets or {}
	local repeatableLineSets = npcData.RepeatableTextLineSets or {}
	local name = GetGenusName( npcData )
	textLineSets = CombineTables( textLineSets, repeatableLineSets )
	if GameState.Flags.InFlashback then
		return false
	end
	for k, textLineSet in pairs( textLineSets ) do
		if CurrentRun.TextLinesRecord[textLineSet.Name] and textLineSet.GiftableOffSource then
			return false
		end
	end
	if npcData.NextInteractLines ~= nil and npcData.NextInteractLines.InitialGiftableOffSource ~= nil then
		return false
	end
	if npcData.GiftableOffInGhostProcession and CurrentDeathAreaRoom ~= nil and (CurrentDeathAreaRoom.HadesProcessionActivating or CurrentDeathAreaRoom.HadesProcessionActive) then
		return false
	end

	if npcData.SkipInitialGiftRequirement then

		return npcData.CanReceiveGift
			and (( GiftData[name] and GiftData[name].InfiniteGifts ) or ((GetGiftLevel(name) + 1) <= GetMaxGiftLevel(name)))
			and not CurrentRun.GiftRecord[name]

	else

		return ( GameState.NPCInteractions[name] ~= nil or GameState.LootPickups [name] ~= nil )
			and npcData.CanReceiveGift
			and (( GiftData[name] and GiftData[name].InfiniteGifts ) or ((GetGiftLevel(name) + 1) <= GetMaxGiftLevel(name)))
			and not CurrentRun.GiftRecord[name]

	end
end

function GetNextGiftResource( npcName )
	local resource = "GiftPoints"
	local giftLevel = GetGiftLevel( npcName )
	local nextLevel = ( giftLevel + 1 )
	if GiftData[npcName] and GiftData[npcName][nextLevel] and GiftData[npcName][nextLevel].RequiredResource then
		resource = GiftData[npcName][nextLevel].RequiredResource
	end
	return resource
end

function GetNextGiftResourceQuantity( npcName )
	local quantity = 1
	local giftLevel = GetGiftLevel( npcName )
	local nextLevel = ( giftLevel + 1 )
	if GiftData[npcName] and GiftData[npcName][nextLevel] and GiftData[npcName][nextLevel].RequiredResourceAmount then
		quantity = GiftData[npcName][nextLevel].RequiredResourceAmount
	end
	return quantity
end

function GetMaxGiftLevel( npcName )
	if GameState.Gift[npcName] == nil or GiftData[npcName] == nil then
		return 0
	end
	if GiftData[npcName].Locked == nil or CurrentRun.DebugUnlockGifts then
		return GiftData[npcName].Maximum
	end
	-- Subtract one from Locked since it's the index at which the pips start being locked
	return math.min(GiftData[npcName].Maximum, GetLockedLevel( npcName ) - 1)
end

function GetLockedLevel( npcName )
	if GiftData[npcName] then
		if ( CurrentRun and CurrentRun.CurrentRoom and string.match( CurrentRun.CurrentRoom.Name, "Test" ) ~= nil ) or ( GiftData[npcName].UnlockGameStateRequirements and IsGameStateEligible(CurrentRun, GiftData[npcName].UnlockGameStateRequirements )) then
			return GiftData[npcName].Maximum + 1
		end
		return GiftData[npcName].Locked
	end
end

function IsGiftBarCompletelyUnlocked( entryName )
	return ( GiftData[entryName].UnlockGameStateRequirements and IsGameStateEligible(CurrentRun, GiftData[entryName].UnlockGameStateRequirements ))
end

function IncrementGiftMeter( npcName, amount)
	if amount == nil then
		amount = 1
	end

	GameState.Gift[npcName].Value = GameState.Gift[npcName].Value + amount
	if GiftData[npcName] and GiftData[npcName].InfiniteGifts and GameState.Gift[npcName].Value == GetMaxGiftLevel(name) then
		GameState.Gift[npcName].Value = 1
	end
end