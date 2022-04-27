OnUsed{ "GhostInspectPoint",
	function( triggerArgs )
		UseableOff({ Id = triggerArgs.triggeredById })
		SetAlpha({ Id = triggerArgs.triggeredById, Fraction = 0.0, Duration = 0.25 })
		BlockVfx({ DestinationId = triggerArgs.triggeredById })
		thread( PlayVoiceLines, HeroVoiceLines.ShadeEavesdropVoiceLines )
		local closestEnemyIds = GetClosestIds({Id = CurrentRun.Hero.ObjectId, Distance = 200, MaximumCount = 1, DestinationNames = {"Ghost3D", "GhostEavesdropA", "GhostEavesdropB", "GhostEavesdropC", "GhostEavesdropD", "GhostEavesdropF"}, IgnoreSelf = true })
		if TableLength(closestEnemyIds) > 0 then
			PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/TarotCardSpecialInteract", Id = closestEnemyIds[1] })
			PlayCauseOfDeath( closestEnemyIds[1])
		end
	end
}


OnCollisionEnd{
	function( triggerArgs )
		local collidee = triggerArgs.CollideeTable
		if collidee ~= nil and collidee.EmoteReactionOnCollide then
			if RandomChance( 0.1 ) and ( CurrentDeathAreaRoom ~= nil and CurrentDeathAreaRoom.Name == "DeathArea" ) then
				PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/CandleBlow", Id = triggerArgs.triggeredById })
				PlayEmote( { TargetId = collidee.ObjectId, EmoteName = "Disgruntled", Shake = true } )
			end
		end
	end
}

function PickQuote()
	local eligibleGhostLines = {}
	local unheardAndEligibleGhostLines = {}
	for i, data in pairs(GhostData) do
		if data.GameStateRequirements == nil or IsGameStateEligible(CurrentRun, data, data.GameStateRequirements ) then
			if GameState.HeardGhostLines[data.Quote] == nil then
				table.insert( unheardAndEligibleGhostLines, data )
			end
			table.insert( eligibleGhostLines, data )
		end
	end
	if TableLength(unheardAndEligibleGhostLines) == 0 then
		unheardAndEligibleGhostLines = eligibleGhostLines
		ClearHeardGhosts()
	end
	return GetRandomValue( unheardAndEligibleGhostLines )
end

function ClearHeardGhosts()
	GameState.HeardGhostLines = {}
end

function PlayCauseOfDeath( targetId )
	local deathData = PickQuote()
	local quote = deathData.Quote
	local cause = deathData.Cause

	local fadeInDuration = 0.5
	local fadeOutDuration = 0.5
	local holdDuration = 4.0

	local speechbubble = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay", DestinationId = targetId, OffsetY = -150 })
	SetAnimation({ Name = "GhostDialogue", DestinationId = speechbubble, Scale = 0.55 })
	CreateTextBox({ Id = speechbubble, Text = quote, FontSize = 21, Width = 356, OffsetX = -204, OffsetY = -12, Justification = "Left", Font = "AlegreyaSansItalic", Color = White, OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2, LineSpacingBottom = 2 })

	local causeOfDeath = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", DestinationId = targetId, OffsetY = 0 })
	Attach({Id = causeOfDeath, DestinationId = speechbubble })
	CreateTextBox({ Id = causeOfDeath, Text = "GhostCauseOfDeath", FontSize = 16, Width = 287, OffsetX = 143, OffsetY = 54, Justification = "Right", Font = "AlegreyaSansSCMedium", Color = White, LuaKey = "TempTextData", LuaValue= { Cause = cause }, OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2 })

	Move({Id = speechbubble, Angle = 90, Distance = 30, Duration = fadeInDuration, SmoothStep = true })
	wait( fadeInDuration, RoomThreadName )

	wait( holdDuration, RoomThreadName )

	if deathData.Reactions ~= nil then
		local numReactions = 0
		local closestEnemyIds = GetClosestIds({Id = targetId, Distance = 300, MaximumCount = TableLength(deathData.Reactions),  DestinationNames = {"Ghost3D", "GhostEavesdropA", "GhostEavesdropB", "GhostEavesdropC", "GhostEavesdropD", "GhostEavesdropF", "GhostPatrol", "ActiveGhosts"}, IgnoreSelf = true })

		for i, reaction in pairs(deathData.Reactions) do
			if closestEnemyIds[i] ~= nil then
				thread( PlayEmote, { TargetId = closestEnemyIds[i], AnimationName = reaction } )
			end
		end
	end

	SetAlpha({ Id = speechbubble, Fraction = 0.0, Duration = fadeOutDuration })
	Move({Id = speechbubble, Angle = 90, Distance = 30, Duration = fadeOutDuration, EaseOut = 1 })
	ModifyTextBox({ Id = speechbubble, FadeTarget = 0, FadeDuration = fadeOutDuration})
	ModifyTextBox({ Id = causeOfDeath, FadeTarget = 0, FadeDuration = fadeOutDuration})
	wait( fadeOutDuration, RoomThreadName )
	Destroy({ Ids = {speechbubble, causeOfDeath}})
end

function IsGhostProcessionEligible( args, hades )
	if hades == nil then -- Ghost Procession will crash if Hades does not exist.
		return false
	end

	if args.ForceEligible then
		return true
	end

	if IsGameStateEligible( CurrentRun, hades, hades.GhostProcessionRequirements ) then
		
		if hades.NextInteractLines ~= nil then
			return false
		end

		local canGift = ( GetTextLinesUseableStatus( hades, hades.GiftTextLineSets ) and CanReceiveGift( hades ) and ( HasResource( GetNextGiftResource( hades.Name ), GetNextGiftResourceQuantity( hades.Name ))))
		if canGift then
			return false
		end

		return true
	end

	return false
end

function SetupGhostProcession( source, args )

	local lineStart = 393482
	CurrentDeathAreaRoom.GhostLine = {}
	CurrentDeathAreaRoom.ProcessionFinalPath = args.Path
	CurrentDeathAreaRoom.ProcessionSortedLineIds = {}
	CurrentDeathAreaRoom.ProcessionSortedLineIds[1] = lineStart
	CurrentDeathAreaRoom.LineLength = 25
	local lineSpacing = 55
	local offsetVariance = 30
	local offsetX = 0
	local offsetY = 0
	for i = 1, CurrentDeathAreaRoom.LineLength do
		offsetX = offsetX - lineSpacing
		offsetY = offsetY + lineSpacing/2
		CurrentDeathAreaRoom.ProcessionSortedLineIds[i + 1] = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = lineStart, OffsetX = offsetX + RandomFloat(-offsetVariance, offsetVariance), OffsetY = offsetY + RandomFloat(-offsetVariance, offsetVariance) })

		CurrentDeathAreaRoom.GhostLine[i] = SpawnObstacle({ Name = GetRandomValue(args.GhostOptionNames), DestinationId = CurrentDeathAreaRoom.ProcessionSortedLineIds[i + 1], Group = "Standing" })
		AddToGroup({ Id = CurrentDeathAreaRoom.GhostLine[i], Name = "GhostProcession" })
	end

	wait( 0.5, RoomThreadName )

	local hadesId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Hades_01" })
	local hades = ActiveEnemies[hadesId]
	if not IsGhostProcessionEligible( args, hades ) then
		CurrentDeathAreaRoom.HadesProcessionActive = true
		DeactivateGhostProcession( true )
	else
		CurrentDeathAreaRoom.HadesProcessionActive = false

		wait( 5.0, RoomThreadName )
		ActivateGhostProcession( )
	end

	HandleGhostProcession( args )
end

function HandleGhostProcession( args )
	local hadesData = UnitSetData.NPCs.NPC_Hades_01
	local numJudgements = 0

	while CurrentDeathAreaRoom.GhostLine ~= nil do
		if CurrentDeathAreaRoom.HadesProcessionActive then
			local preSummonWait = RandomFloat(1, 1.3)
			wait( preSummonWait, RoomThreadName )
			thread( PlayVoiceLines, hadesData.JudgeSummoningVoiceLines )
			local preJudgmentWait = RandomFloat(0.5, 1.5)
			wait( preJudgmentWait, RoomThreadName )

			local updatedGhostLine = {}
			for linePosition, ghostId in pairs(CurrentDeathAreaRoom.GhostLine) do
				local mover = MapState.ActiveObstacles[ghostId]
				if mover ~= nil then
					if linePosition ~= 1 then
						updatedGhostLine[linePosition - 1] = ghostId
						local path = { { Id = CurrentDeathAreaRoom.ProcessionSortedLineIds[linePosition - 1], OffsetRadius = 10, SpeedMin = 8, SpeedMax = 16, }, }
						thread( FollowPath, mover, path, false )
					end
				end
			end
			updatedGhostLine[CurrentDeathAreaRoom.LineLength] = SpawnObstacle({ Name = GetRandomValue(args.GhostOptionNames), DestinationId = CurrentDeathAreaRoom.ProcessionSortedLineIds[CurrentDeathAreaRoom.LineLength + 1] })
			FollowPath( MapState.ActiveObstacles[CurrentDeathAreaRoom.GhostLine[1]], CurrentDeathAreaRoom.ProcessionFinalPath, false )

			CurrentDeathAreaRoom.GhostLine = updatedGhostLine
			numJudgements = numJudgements + 1
		end

		local postJudgmentWait = RandomFloat(2.5, 4.0)
		wait( postJudgmentWait, RoomThreadName )

		local maxJudgments = RandomInt( args.BreakAfterNumJudgementsMin, args.BreakAfterNumJudgementsMax )

		if maxJudgments ~= nil and numJudgements >= maxJudgments then
			local breakDuration = args.BreakDuration or RandomFloat( args.BreakDurationMin, args.BreakDurationMax ) or 120
			DeactivateGhostProcession( )
			thread(ActivateGhostProcession, breakDuration)
			numJudgements = 0
		end
	end
end

function ActivateGhostProcession( delay )

	if CurrentDeathAreaRoom.HadesProcessionActivating or CurrentDeathAreaRoom.HadesProcessionActive then
		return
	end

	local hadesData = UnitSetData.NPCs.NPC_Hades_01
	local hadesId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Hades_01" })
	local hades = ActiveEnemies[hadesId]
	if not IsGhostProcessionEligible( {}, hades ) then
		return
	end
	CurrentDeathAreaRoom.HadesProcessionActivating = true

	wait( delay or 2.0, RoomThreadName )

	if CurrentDeathAreaRoom.GhostLine == nil then
		--SetupGhostProcession( source, args )
	else

		local preCommenceProcessionWait = RandomFloat( 1.6, 3.7 )
		wait( preCommenceProcessionWait, RoomThreadName )

		thread( PlayVoiceLines, hadesData.JudgeCommenceProcessionVoiceLines, true, hades )

		wait( 1.0, RoomThreadName )

		for linePosition, ghostId in pairs(CurrentDeathAreaRoom.GhostLine) do
			local mover = MapState.ActiveObstacles[ghostId]
			if mover ~= nil then
				local path = { { Id = CurrentDeathAreaRoom.ProcessionSortedLineIds[linePosition], OffsetRadius = 10, SpeedMin = 64, SpeedMax = 92, AngleTowardIdOnStop = hadesId }, }
				thread( FollowPath, mover, path, false )
			end
		end
	end

	wait( 2.5, RoomThreadName )

	CurrentDeathAreaRoom.HadesProcessionActivating = false
	CurrentDeathAreaRoom.HadesProcessionActive = true
end

function DeactivateGhostProcession( skipVoiceLines )
	if CurrentDeathAreaRoom.HadesProcessionActive then
		CurrentDeathAreaRoom.HadesProcessionActive = false
	else
		return
	end

	local hadesData = UnitSetData.NPCs.NPC_Hades_01
	local hadesId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Hades_01" })
	local hades = ActiveEnemies[hadesId]

	if not skipVoiceLines then
		thread( PlayVoiceLines, hadesData.JudgeAdjournedVoiceLines, true, hades )
	end

	wait( 1.0, RoomThreadName )

	local usedPoints = {}

	for linePosition, ghostId in pairs(CurrentDeathAreaRoom.GhostLine) do

		local pointIds = GetClosestIds({ Id = ghostId, DestinationName = "GhostLineWaitPoints", Distance = 450 })
		RemoveValuesFromTable( pointIds, usedPoints )
		local waitPointId = GetRandomValue(pointIds)
		table.insert(usedPoints, waitPointId)
		
		local mover = MapState.ActiveObstacles[ghostId]
		if mover ~= nil then
			local path = { { Id = waitPointId, OffsetRadius = 10, SpeedMin = 32, SpeedMax = 64, AngleTowardNodeOnStop = true, StopAngleDuration = 0.5, StartAngleDuration = 0.5, StartDelayMin = 0.0, StartDelayMax = 1.0 }, }
			thread( FollowPath, mover, path, false )
		end
	end
end

function PatrolPath( source, args )

	local numPatrols = 0
	while args.MaxPatrols == nil or numPatrols < args.MaxPatrols do
		local availableIds = GetIds({ Name = args.GroupName })
		if IsEmpty( availableIds ) then
			return
		end
		wait( args.SendPatrolInterval, RoomThreadName )
		local moverId = RemoveRandomValue( availableIds )
		if args.RemoveFromGroup then
			RemoveFromGroup({ Id = moverId, Name = args.GroupName })
		end
		if args.AddToGroup then
			AddToGroup({ Id = moverId, Name = args.NewGroupName })
		end

		local mover = MapState.ActiveObstacles[moverId]
		if mover ~= nil then

			-- Take over from MapThing angle
			local mapAngle = GetAngle({ Id = mover.ObjectId })
			SetAngle({ Id = mover.ObjectId, Angle = 0, Duration = 0.0 })
			SetGoalAngle({ Id = mover.ObjectId, Angle = mapAngle, Duration = 0.0 })

			mover.Speed = RandomFloat( args.SpeedMin, args.SpeedMax )
			thread( FollowPath, mover, args.Path, true )
			numPatrols = numPatrols + 1

		end
	end

end

function FollowPath( mover, path, loop )

	if mover == nil then
		return
	end

	mover.AIThreadName = "MoverAIThread"..mover.ObjectId

	for index, node in ipairs( path ) do

		if node.MinUseInterval == nil or node.LastUsedTime == nil or _worldTime > node.LastUsedTime + node.MinUseInterval then

			node.LastUsedTime = _worldTime

			if node.Id ~= nil then

				local startDelay = node.StartDelay
				if node.StartDelayMin ~= nil and node.StartDelayMax ~= nil then
					startDelay = RandomFloat(node.StartDelayMin, node.StartDelayMax)
				end
				wait(startDelay, mover.AIThreadName)

				local startDelay = node.StartDelay
				if node.StartDelayMin ~= nil and node.StartDelayMax ~= nil then
					startDelay = RandomFloat(node.StartDelayMin, node.StartDelayMax)
				end
				wait(startDelay, mover.AIThreadName)

				if not IsAlive({ Id = mover.ObjectId }) then
					return
				end

				local offset = {}
				if node.OffsetRadius ~= nil then
					offset = CalcOffset( RandomFloat( 0.0, math.pi * 2 ), node.OffsetRadius )
				end
				local speed = mover.Speed
				if node.SpeedMin ~= nil and node.SpeedMax ~= nil then
					speed = RandomFloat( node.SpeedMin, node.SpeedMax )
				end
				AngleTowardTarget({ Id = mover.ObjectId, DestinationId = node.Id, Duration = node.StartAngleDuration or 0.3, SmoothStep = true })
				Move({ Id = mover.ObjectId, DestinationId = node.Id, OffsetX = offset.X, OffsetY = offset.Y, Speed = speed, EaseIn = node.EaseIn or 0.01, EaseOut = node.EaseOut or 1.0, })

				mover.AINotifyName = "OnStopped"..mover.ObjectId
				wait( 0.1, mover.AIThreadName )

				NotifyOnStopped({ Id = mover.ObjectId, Notify = mover.AINotifyName })
				waitUntil( mover.AINotifyName )

				if node.AngleTowardIdOnStop then
					AngleTowardTarget({ Id = mover.ObjectId, DestinationId = node.AngleTowardIdOnStop, Duration = node.StopAngleDuration or 0.3, SmoothStep = true })
					wait( 0.3, mover.AIThreadName )
				end

				if node.AngleTowardNodeOnStop then
					AngleTowardTarget({ Id = mover.ObjectId, DestinationId = node.Id, Duration = node.StopAngleDuration or 0.3, SmoothStep = true })
					wait( 0.3, mover.AIThreadName )
				end

				wait( node.PostArriveWait or 0.1, mover.AIThreadName )

				if node.HadesJudgement and CurrentDeathAreaRoom.HadesProcessionActive then

					local hades = ActiveEnemies[ GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Hades_01" }) ]

					wait( node.JudgeAddressingPreWait or 0.02, mover.AIThreadName )
					thread( PlayVoiceLines, hades.JudgeAddressingVoiceLines, nil, hades )
					wait( node.JudgeAddressingPostWait or 0.02, mover.AIThreadName )

					if CurrentDeathAreaRoom.HadesProcessionActive then
						wait( node.GhostPreCaseWait or 0.02, mover.AIThreadName )
						local randomEmote = GetRandomValue( node.GhostCaseEmotes )
						PlayEmote( { Target = mover, EmoteName = randomEmote, PlaySound = true } )
						if RandomChance( node.JudgeListeningChance ) then
							wait( node.JudgeListeningPreWait or 0.02, mover.AIThreadName )
							thread( PlayVoiceLines, hades.JudgeListeningVoiceLines, nil, hades )
							wait( node.JudgeListeningPostWait or 0.02, mover.AIThreadName )
							PlayEmote( { Target = mover, EmoteName = randomEmote } )
						end
					end

					if CurrentDeathAreaRoom.HadesProcessionActive then
						if RandomChance( node.HadesJudgementPositiveChance ) then
							wait( node.JudgePositiveVerdictPreWait or 0.02, mover.AIThreadName )
							thread( PlayVoiceLines, hades.JudgePositiveVerdictVoiceLines, nil, hades )
							wait( node.JudgePositiveVerdictPostWait or 0.02, mover.AIThreadName )
							PlayEmote( { Target = mover, EmoteName = "Smile", PlaySound = true } )
						else
							wait( node.JudgeNegativeVerdictPreWait or 0.02, mover.AIThreadName )
							thread( PlayVoiceLines, hades.JudgeNegativeVerdictVoiceLines, nil, hades )
							wait( node.JudgeNegativeVerdictPostWait or 0.02, mover.AIThreadName )
							PlayEmote( { Target = mover, EmoteName = "Grief", PlaySound = true } )
							Destroy({ Id = mover.ObjectId })
						end
					end
				end

				if node.EmoteOnEnd ~= nil then
					PlayEmote( { Target = mover, EmoteName = node.EmoteOnEnd, PlaySound = node.PlaySound } )
				end

				if node.DestroyOnEnd then
					Destroy({ Id = mover.ObjectId })
					return
				end

			end

			if node.Branch ~= nil then
				local randomBranchPath = GetRandomValue( node.Branch )
				FollowPath( mover, randomBranchPath )
			end

		end

	end

	if loop and IsAlive({ Id = mover.ObjectId }) then
		return FollowPath( mover, path, loop )
	end

end

function GhostExpressiveEmote()
	local legalEmotes =
	{
		"StatusIconEmbarrassed",
		"StatusIconDisgruntled",
		"StatusIconEyeRoll",
		"StatusIconFear",
		"StatusIconGrief",
		"StatusIconOhBoy",
		"StatusIconSmile",
	}
	local closestGhosts = GetClosestIds({ Id = CurrentRun.Hero.ObjectId, DestinationName = "Ghost3D", Distance = 1000 })
	local closestGhostInspectPoint = GetClosest({ Ids = closestGhosts, DestinationName = "GhostInspectPoint", Distance = 300 })
	if closestGhostInspectPoint ~= nil and closestGhostInspectPoint > 0 then
		AngleTowardTarget({ Ids = closestGhosts, DestinationId = closestGhostInspectPoint })
	else
		AngleTowardTarget({ Ids = closestGhosts, DestinationId = CurrentRun.Hero.ObjectId })
	end

	local ghostReactionTime = RandomFloat( 0.3, 3.0 )
	wait( ghostReactionTime, RoomThreadName )
	SetAnimation({ DestinationIds = closestGhosts, Name = "3DGhostAltFidget" })
	wait( 1.0, RoomThreadName )
	local randomEmote = GetRandomValue( legalEmotes )
	for k, ghostId in pairs(closestGhosts) do
		PlayEmote( { TargetId = ghostId, AnimationName = randomEmote } )
	end
end