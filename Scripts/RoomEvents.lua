function ActivateRandomGroups( eventSource, args )

	if args.Groups == nil then
		return
	end
	local groups = ShallowCopyTable( args.Groups )

	local count = args.Count or 1
	for i = 1, count do
		local groupToActivate = RemoveRandomValue( groups )
		Activate({ Name = groupToActivate })
		local ids = GetIds({ Name = groupToActivate })
		SetupEnemyObjects( ids )
	end
end

function ActivatePrePlacedByShrineLevel( eventSource, args )
	local shrineLevel = GetNumMetaUpgrades( eventSource.ShrineMetaUpgradeName )
	ActivatePrePlaced( eventSource, args[shrineLevel] )
end

function ActivatePrePlaced( eventSource, args )

	local doPresentation = true
	if args.SkipPresentation then
		doPresentation = false
	end
	if args.Types ~= nil then
		for k, type in pairs( args.Types ) do
			local typeIds = GetInactiveIdsByType({ Name = type })
			Activate({ Ids = typeIds, DoPresentation = doPresentation })
			SetupEnemyObjects( typeIds, args )
		end
		return
	end

	if args.FractionMin == nil then
		args.FractionMin = 1.0
	end
	if args.FractionMax == nil then
		args.FractionMax = 1.0
	end

	local currentRun = CurrentRun

	local toActivate = {}
	if args.Groups ~= nil then
		for k, groupName in pairs( args.Groups ) do
			local ids = GetInactiveIds({ Name = groupName })
			for j, id in pairs( ids ) do
				local name = GetName({ Id = id, CheckInactive = true })
				local enemyData = EnemyData[name]
				if IsActivationEligible( id, enemyData ) then
					toActivate[id] = enemyData
				end
			end
		end
	else
		for enemyName, enemyData in pairs( EnemyData ) do
			local enemyTypeIds = GetInactiveIdsByType({ Name = enemyName })
			if args.LegalTypes == nil or Contains( args.LegalTypes, enemyName ) then
				for k, id in pairs( enemyTypeIds ) do
					if IsActivationEligible( id, enemyData ) then
						toActivate[id] = enemyData
					end
				end
			end
		end
	end

	local prePlacedFraction = RandomFloat( args.FractionMin, args.FractionMax )
	local prePlacedCount = TableLength( toActivate )
	local activateCount = round( prePlacedCount * prePlacedFraction )

	for i = 1, activateCount, 1 do
		local enemyId = GetRandomKey( toActivate )
		local enemyData = toActivate[enemyId]
		local newEnemy = DeepCopyTable( enemyData )
		newEnemy.ObjectId = enemyId
		Activate({ Id = newEnemy.ObjectId, DoPresentation = doPresentation })
		SetupEnemyObject( newEnemy, currentRun, args )
		toActivate[enemyId] = nil

		if args.SpawnOverrides ~= nil then
			for key, value in pairs( args.SpawnOverrides ) do
				newEnemy[key] = value
			end
		end

	end

end

function ActivatePrePlacedObstacles( eventSource, args )
	Activate({ Ids = args.Ids, Names = args.Groups })
end

function FadeOutIds( eventSource, args )
	SetAlpha({ Ids = args.Ids, Fraction = 0.0, Duration = args.Duration or 0.3 })
end

function ActivatePrePlacedUnits( eventSource, args )
	for k, id in pairs( args.Ids ) do
		local name = GetName({ Id = id, CheckInactive = true })
		if name ~= nil then
			local enemyData = EnemyData[name]
			local newEnemy = DeepCopyTable( enemyData )
			newEnemy.ObjectId = id
			Activate({ Id = newEnemy.ObjectId, DoPresentation = args.DoPresentation })
			SetupEnemyObject( newEnemy, CurrentRun, args )
			if args.DistanceTrigger ~= nil then
				thread( CheckDistanceTrigger, args.DistanceTrigger, newEnemy )
			end
			if args.FadeInDuration ~= nil then
				SetAlpha({ Id = id, Fraction = 0 })
				SetAlpha({ Id = id, Fraction = 1, Duration = args.FadeInDuration })
			end
			if args.CheckConversations then
				CheckAvailableTextLines( newEnemy )
			end
			if args.AddEncounterEvent ~= nil then
				table.insert( CurrentRun.CurrentRoom.Encounter.UnthreadedEvents, args.AddEncounterEvent )
			end
		end
	end
end

function ActivateAnyPrePlaced( eventSource, args )
	Activate({ Ids = args.Ids, Names = args.Groups, DoPresentation = args.DoPresentation })
	for k, id in pairs( args.Ids ) do
		local name = GetName({ Id = id, CheckInactive = true })
		local enemyData = EnemyData[name]
		if enemyData ~= nil then
			local newEnemy = DeepCopyTable( enemyData )
			newEnemy.ObjectId = id
			args.PreLoadBinks = true
			SetupEnemyObject( newEnemy, CurrentRun, args )
		end
	end
end

function ActivateOneOfAPrePlacedGroupSet( eventSource, args )
	if args.ActivationChance then
		if not RandomChance( args.ActivationChance ) then
			return
		end
	end
	local randomGroup = RemoveRandomValue( args.Groups )
	Activate({ Name = randomGroup })
	local ids = GetIds({ Name = randomGroup })
	for k, id in pairs( ids ) do
		local unitName = GetName({ Id = id })
		local unitData = EnemyData[unitName]
		if unitData ~= nil then
			local newUnit = DeepCopyTable( unitData )
			newUnit.ObjectId = id
			SetupEnemyObject( newUnit, CurrentRun, args )
		end
	end
end

function ActivateRotatingNPCs( eventSource, args )

	local doPresentation = true
	if args.SkipPresentation then
		doPresentation = false
	end
	local numActivations = 0
	local activationCap = nil
	if args.ActivationCapMin ~= nil and args.ActivationCapMax ~= nil then
		activationCap = RandomInt( args.ActivationCapMin, args.ActivationCapMax )
	end

	local ids = {}
	ConcatTableValues( ids, args.Ids )
	if args.Types ~= nil then
		for k, type in ipairs( args.Types ) do
			local typeIds = GetInactiveIdsByType({ Name = type })
			ConcatTableValues( ids, typeIds )
		end
	end

	while not IsEmpty( ids ) do
		local id = RemoveRandomValue( ids )
		local name = GetName({ Id = id, CheckInactive = true })
		local unitData = EnemyData[name]
		if IsActivationEligible( id, unitData ) then
			if ShouldRotatorActivate( id, unitData, numActivations, activationCap ) then

				if unitData.Binks ~= nil then
					PreLoadBinks({ Names = unitData.Binks })
				end
				Activate({ Ids = id, DoPresentation = doPresentation })

				local newUnit = DeepCopyTable( unitData )
				newUnit.ObjectId = id
				SetupEnemyObject( newUnit, CurrentRun, args )
				if CurrentRun.AnimationState[newUnit.ObjectId] ~= nil then
					SetAnimation({ DestinationId = newUnit.ObjectId, Name = CurrentRun.AnimationState[newUnit.ObjectId] })
				end
				if CurrentRun.EventState ~= nil then
					local eventState = CurrentRun.EventState[newUnit.ObjectId]
					if eventState ~= nil then
						local eventFunction = _G[eventState.FunctionName]
						if eventFunction ~= nil then
							thread( eventFunction, newUnit, eventState.Args )
						end
					end
				end

				CurrentRun.ActivationRecord[id] = true
				numActivations = numActivations + 1
			else
				if unitData.MissingDistanceTrigger ~= nil then
					local missingUnit = {}
					missingUnit.Name = name
					missingUnit.ObjectId = SpawnObstacle({ Name = "BlankObstacle" })
					local location = GetLocation({ Id = id, CheckInactive = true })
					Teleport({ Id = missingUnit.ObjectId, OffsetX = location.X, OffsetY = location.Y })
					thread( CheckDistanceTrigger, unitData.MissingDistanceTrigger, missingUnit )
				end
			end
		else
			if unitData.ActivationFailedDistanceTrigger ~= nil then
				local missingUnit = {}
				missingUnit.Name = name
				missingUnit.ObjectId = SpawnObstacle({ Name = "BlankObstacle" })
				local location = GetLocation({ Id = id, CheckInactive = true })
				Teleport({ Id = missingUnit.ObjectId, OffsetX = location.X, OffsetY = location.Y })
				thread( CheckDistanceTrigger, unitData.ActivationFailedDistanceTrigger, missingUnit )
			end
		end
	end

end

function SetPersephoneAwayAtRunStart()
	if GameState.Flags.PersephoneAwayAtRunStart then
		GameState.Flags.PersephoneAway = true
		GameState.Flags.PersephoneAwayAtRunStart = false
	end
end

function SetPersephoneAway( eventSource, args )
	local completedRuns = GetCompletedRuns()
	GameState.LastPersephoneAwayRunCount = completedRuns
	GameState.Flags.PersephoneGoingAway = false
	GameState.Flags.PersephoneAwayAtRunStart = true
end

function CheckIsPersephoneAway( eventSource, args )
	if PreviousDeathAreaRoom ~= nil then
		return
	end
	local completedRuns = GetCompletedRuns()
	GameState.LastPersephoneReturnRunCount = GameState.LastPersephoneReturnRunCount or completedRuns
	if GameState.Flags.PersephoneAway then
		if GameState.LastPersephoneAwayRunCount ~= nil then
			if completedRuns - GameState.LastPersephoneAwayRunCount < 7 then
				return
			else
				GameState.Flags.PersephoneAway = false
				GameState.Flags.PersephoneJustReturned = true
				GameState.LastPersephoneReturnRunCount = completedRuns
			end
		end
	else
		if completedRuns - GameState.LastPersephoneReturnRunCount >= 7 then
			GameState.Flags.PersephoneGoingAway = true
		end
	end
	if completedRuns - GameState.LastPersephoneReturnRunCount > 0 then
		GameState.Flags.PersephoneJustReturned = false
	end
end

function ShouldRotatorActivate( id, unitData, numActivations, activationCap )

	if activationCap == nil then
		return true
	end

	if numActivations < activationCap then
		return true
	end

	if not GameState.NPCInteractions[unitData.Name] then
		return true
	end

	if not IsEmpty( GameState.RunHistory ) then
		local prevRun = GameState.RunHistory[#GameState.RunHistory]
		if prevRun ~= nil and not prevRun.ActivationRecord[id] then
			return true
		end
	end

	return false

end

function RandomizeTrapTypes( eventSource, args )
	local room = eventSource
	local trapOptions = args.TrapOptions or room.TrapOptions
	local trapType = GetRandomValue(trapOptions)
	if room ~= nil then
		room.TrapType = trapType
	end

	if args.FractionMin == nil then
		args.FractionMin = 1.0
	end
	if args.FractionMax == nil then
		args.FractionMax = 1.0
	end
	local activateFraction = RandomFloat(args.FractionMin, args.FractionMax)

	local deactivatedTraps = GetMapThingsByType({ Names = {"TrapPadDisabled", "TrapFissureDisabled"} })
	local deactivatedCount = TableLength( deactivatedTraps )
	local activateCount = round( deactivatedCount * activateFraction )

	for i = 0, activateCount, 1 do
		local disabledId = RemoveRandomKey( deactivatedTraps )
		if disabledId ~= nil then
			ActivateTrap( disabledId, trapType )
		end
	end
end

function ActivateTrap( disabledId, trapType )
	SwapName({ DestinationId = disabledId, Name = trapType })
end

function IsActivationEligible( id, sourceData )

	if sourceData == nil then
		return false
	end

	if sourceData.ActivateRequirements ~= nil and not IsGameStateEligible( CurrentRun, sourceData.ActivateRequirements ) then
		return false
	end

	if sourceData.IdActivateRequirements ~= nil and sourceData.IdActivateRequirements[id] ~= nil and not IsGameStateEligible( CurrentRun, sourceData.IdActivateRequirements[id] ) then
		return false
	end

	return true

end

function SetupEnemyObjects( ids, args )

	for k, id in pairs( ids ) do
		local name = GetName({ Id = id })
		local enemyData = EnemyData[name]
		if enemyData ~= nil then
			local newEnemy = DeepCopyTable( enemyData )
			newEnemy.ObjectId = id
			SetupEnemyObject( newEnemy, CurrentRun )
			if args.CheckConversations then
				CheckConversations( newEnemy )
			end
		end
	end

end

function DisableObjects( eventSource, args )

	local thingIds = GetIdsByType({ Name = args.Type })
	UseableOff({ Ids = thingIds })
	for k, thingId in pairs( thingIds ) do
		ActivatedObjects[thingId] = nil
	end

end

function HandleThanatosSpawn( eventSource )
	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource

	local newUnit = DeepCopyTable( EnemyData.NPC_Thanatos_Field_01 )
	local spawnPointId = SelectSpawnPoint( currentRoom, newUnit, { SpawnNearId = currentRun.Hero.ObjectId, SpawnRadius = 500 })
	if spawnPointId == nil then
		DebugPrint({ Text = "Thanatos no spawn point; spawning on player." })
		spawnPointId = currentRun.Hero.ObjectId
	end
	newUnit.ObjectId = SpawnUnit({ Name = "NPC_Thanatos_Field_01", Group = "Standing", DestinationId = spawnPointId })
	currentEncounter.ThanatosId = newUnit.ObjectId
	SetupEnemyObject( newUnit, CurrentRun, { IgnoreAI = true, PreLoadBinks = true, } )
	UseableOff({ Id = newUnit.ObjectId })
	ActivatedObjects[newUnit.ObjectId] = newUnit
	ThanatosSpawnPresentation( newUnit )
	SetupAI( CurrentRun, newUnit )

	currentRun.ThanatosSpawns = currentRun.ThanatosSpawns + 1

end

function HandleEnemySpawns( eventSource )

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		waitUntil( "EditingModeOff" )
	end

	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource

	if currentEncounter.SpawnWaves == nil then
		if currentEncounter.Spawns ~= nil then
			currentEncounter.SpawnWaves = { {Spawns = currentEncounter.Spawns} }
		else
			DebugPrint({ Text = "Encounter has no spawns!" })
			return
		end
	end

	if currentEncounter.SpawnHazards then
		thread(HandleHazardSpawns, currentRoom, currentEncounter)
	end

	if currentEncounter.SpawnShadeWeapons then
		thread(HandleShadeWeaponSpawns, currentRoom)
	end

	CheckObjectiveSet( currentEncounter.EncounterType )
	CheckObjectiveSet( currentEncounter.ObjectiveSets )

	currentEncounter.ActiveEnemyCap = CalculateActiveEnemyCap( currentRun, currentRoom, currentEncounter )

	if currentEncounter.SpawnPassiveRoomWeapons ~= nil then
		currentEncounter.PassiveRoomWeapons = {}
		for k, name in pairs(currentEncounter.SpawnPassiveRoomWeapons) do
			local newEnemy = DeepCopyTable( EnemyData[name] )
			newEnemy.ObjectId = SpawnUnit({ Name = name, Group = "Standing", DestinationId = CurrentRun.Hero.ObjectId, DoActivatePresentation = false })
			SetupEnemyObject( newEnemy, CurrentRun )
			table.insert(currentEncounter.PassiveRoomWeapons, newEnemy.ObjectId)
		end
	end

	local waves = currentEncounter.SpawnWaves
	local waveCount = TableLength( waves )

	for waveNum, wave in ipairs( waves ) do
		DebugPrint({ Text = "Starting Wave "..waveNum })
		currentEncounter.CurrentWaveNum = waveNum

		if wave.MetaUpgradeDataOverrides and GetNumMetaUpgrades(currentEncounter.ShrineMetaUpgradeName) > 0 then
			OverwriteTableKeys(wave, wave.MetaUpgradeDataOverrides)
		end

		-- Start a new wave
		if currentEncounter.WaveStartPresentationFunction ~= nil then
			local waveStartFunction = _G[currentEncounter.WaveStartPresentationFunction]
			waveStartFunction(currentEncounter)
		end

		if GetConfigOptionValue({ Name = "EditingMode" }) then
			waitUntil( "EditingModeOff" )
		end
		wait( wave.StartDelay, currentEncounter.SpawnThreadName or RoomThreadName )

		if wave.OverrideValues ~= nil then
			OverwriteTableKeys(currentEncounter, wave.OverrideValues)
			currentEncounter.ActiveEnemyCap = CalculateActiveEnemyCap( currentRun, currentRoom, currentEncounter )
		end

		WaveStartChanges(wave, currentEncounter)

		currentEncounter.Spawns = {}
		AddEncounterLayer( currentRun, currentRoom, currentEncounter, wave )

		local ignoreSpawnPreferences = currentEncounter.IgnoreSpawnPreferences or false
		if currentEncounter.PreSpawnEnemies and waveNum == 1 then
			currentEncounter.PreSpawning = true
			currentEncounter.RequireMinPlayerDistance = currentEncounter.PreSpawnMinPlayerDistance
		end
		while GetRemainingSpawns( currentRun, currentRoom, currentEncounter ) > 0 and currentEncounter.InProgress do

			local waitForEnemeyKilled = false

			if currentEncounter.GroupReinforcements and currentEncounter.WaitingForAllDead then
				if GetActiveEnemyCount() == 0 then
					currentEncounter.WaitingForAllDead = false
					ignoreSpawnPreferences = true
				end
			end

			local nextSpawnInterval = RandomFloat( currentEncounter.SpawnIntervalMin, currentEncounter.SpawnIntervalMax )
			if currentEncounter.PreSpawnEnemies and currentEncounter.PreSpawning and waveNum == 1 then
				nextSpawnInterval = 0
			end

			local spawnedId = nil
			if GetActiveEnemyCount() < currentEncounter.ActiveEnemyCap and not currentEncounter.WaitingForAllDead then
				spawnedId = HandleNextSpawn( currentEncounter, ignoreSpawnPreferences )
				if spawnedId == nil or GetActiveEnemyCount() >= currentEncounter.ActiveEnemyCap then
					-- Hit cap
					waitForEnemeyKilled = true
					currentEncounter.RequireMinPlayerDistance = 0
					currentEncounter.PreSpawning = false

					if currentEncounter.ReinforcementsDataOverride ~= nil then
						OverwriteTableKeys(currentEncounter, currentEncounter.ReinforcementsDataOverride)
					end

					local minEnemiesLeft = 5
					if currentEncounter.GroupReinforcements and GetRemainingSpawns( currentRun, currentRoom, currentEncounter ) > minEnemiesLeft then
						currentEncounter.WaitingForAllDead = true
					end

					if currentEncounter.GroupReinforcements and currentEncounter.RequireNearPlayerDistance ~= nil then
						currentRoom.SpawnPointsUsed = {}
					end
				end
			end

			-- Prevent soft lock if no enemy spawned
			if spawnedId == nil and (nextSpawnInterval == nil or nextSpawnInterval <= 0) then
				nextSpawnInterval = 0.1
			end

			if waitForEnemeyKilled then
				waitUntil( "RequiredEnemyKilled" )
				if CheckCancelSpawns(currentRun, currentRoom, currentEncounter) then
					break
				end
				nextSpawnInterval = currentEncounter.SpawnCapHitReleaseDuration or nextSpawnInterval
				nextSpawnInterval = math.max( nextSpawnInterval, 0.03 ) -- Don't handle the next spawn on the same frame as the last kill
			end
			--DebugAssert({ Condition = nextSpawnInterval > 0, Text = "0 spawn interval may cause freeze." })
			if GetConfigOptionValue({ Name = "EditingMode" }) then
				waitUntil( "EditingModeOff" )
			end
			wait( nextSpawnInterval, currentEncounter.SpawnThreadName or RoomThreadName )

		end
		if waveNum < waveCount then
			CheckForEncounterEnemiesDead( eventSource )
		end
	end
end

function WaveStartChanges(wave, encounter)
	if wave.EnableRoomTraps then
		EnableRoomTraps( )
	end

	if wave.DisableRoomTraps then
		DisableRoomTraps( )
	end

	if wave.PauseHazards then
		encounter.PauseHazards = true
	end

	if wave.UnpauseHazards then
		encounter.PauseHazards = false
	end
end

function HandleNextSpawn( encounter, ignoreSpawnPreferences )
	local spawnInfo = GetNextSpawn( encounter )

	if spawnInfo == nil then
		DebugPrint({ Text = "Nothing spawned!" })
		return nil
	end

	if EnemyData[spawnInfo.Name] == nil then
		DebugPrint({ Text = "Invalid name: "..spawnInfo.Name })

		-- Back Compat: If the enemy we're trying to spawn is invalid, attempt
		-- to choose another one from the encounter's EnemySet
		local validEnemyName = spawnInfo.Name
		local tries = 0
		local maxTries = TableLength( encounter.EnemySet )
		while EnemyData[validEnemyName] == nil and tries < maxTries do
			validEnemyName = GetRandomValue(encounter.EnemySet)
			tries = tries + 1
		end

		DebugAssert({ Condition = tries < maxTries, Text = "Failed to find another enemy to spawn. The game may hang because there is nothing to spawn." })
		if tries >= maxTries then
			return
		end

		spawnInfo.Name = validEnemyName
	end

	local newEnemy = DeepCopyTable( EnemyData[spawnInfo.Name] )
	if encounter.SpawnAggroed then
		newEnemy.StartAggroed = true
	end

	if ignoreSpawnPreferences then
		newEnemy.PreferredSpawnPoint = nil
	end

	local spawnPointId = spawnInfo.SpawnOnId or RemoveRandomValue(CurrentRun.CurrentRoom.SpawnOnIds) or RemoveRandomValue(spawnInfo.SpawnOnIds) or SelectSpawnPoint(CurrentRun.CurrentRoom, newEnemy, encounter)

	if spawnPointId == nil then
		return nil
	end

	local spawnPointOffset = { X = RandomInt( -5, 5 ), Y = RandomInt( -5, 5 ) }

	local doActivatePresentation = true
	if encounter.PreSpawnEnemies and encounter.PreSpawning and encounter.CurrentWaveNum == 1 then
		doActivatePresentation = false

		newEnemy.AggroReactionTimeMin = newEnemy.PreSpawnAggroReactionTimeMin
		newEnemy.AggroReactionTimeMax = newEnemy.PreSpawnAggroReactionTimeMax
		newEnemy.AIWakeDelay = encounter.PreSpawnAIWakeDelay
	end

	newEnemy.ObjectId = SpawnUnit({ Name = newEnemy.Name, Group = "Standing", DestinationId = spawnPointId, OffsetX = spawnPointOffset.X, OffsetY = spawnPointOffset.Y, ForceToValidLocation = true, DoActivatePresentation = doActivatePresentation })
	SetupEnemyObject( newEnemy, CurrentRun )
	AddToGroup({ Id = newEnemy.ObjectId, Name = encounter.Name.."Spawns" })
	CurrentRun.CurrentRoom.SpawnPointsUsed[spawnPointId] = newEnemy.ObjectId
	newEnemy.OccupyingSpawnPointId = spawnPointId
	thread( UnoccupySpawnPointOnDistance, newEnemy, spawnPointId, 400 )

	if encounter.SpawnedUnitAnimation ~= nil then
		CreateAnimation({ Name = encounter.SpawnedUnitAnimation, DestinationId = newEnemy.ObjectId, Scale = 0.15 })
		newEnemy.SpawnedUnitAnimation = encounter.SpawnedUnitAnimation
	end

	if not spawnInfo.InfiniteSpawns then
		spawnInfo.RemainingSpawns = spawnInfo.RemainingSpawns - 1
	end

	if spawnInfo.SpawnOverrides ~= nil then
		for key, value in pairs( spawnInfo.SpawnOverrides ) do
			newEnemy[key] = value
		end
	end

	return newEnemy.ObjectId
end

function SelectSpawnPoint( currentRoom, enemy, encounter )

	local shuffledSpawnPointIds = {}
	if enemy.RequiredSpawnPoint ~= nil then
		if currentRoom.SpawnPoints[enemy.RequiredSpawnPoint] == nil then
			currentRoom.SpawnPoints[enemy.RequiredSpawnPoint] = ShallowCopyTable( GetIdsByType({ Name = enemy.RequiredSpawnPoint }) )
		end
		shuffledSpawnPointIds = FYShuffle( currentRoom.SpawnPoints[enemy.RequiredSpawnPoint] or MapState.SpawnPoints )
	elseif enemy.PreferredSpawnPoint ~= nil then
		if currentRoom.SpawnPoints[enemy.PreferredSpawnPoint] == nil then
			currentRoom.SpawnPoints[enemy.PreferredSpawnPoint] = ShallowCopyTable( GetIdsByType({ Name = enemy.PreferredSpawnPoint }) )
		end
		shuffledSpawnPointIds = FYShuffle( currentRoom.SpawnPoints[enemy.PreferredSpawnPoint] or MapState.SpawnPoints )
	else
		shuffledSpawnPointIds = FYShuffle( MapState.SpawnPoints )
	end

	for k, id in ipairs( shuffledSpawnPointIds ) do
		if IsSpawnPointEligible( id, encounter, currentRoom ) then
			return id
		end
	end

	-- Nothing eligible
	if enemy.PreferredSpawnPoint ~= nil then
		enemy.PreferredSpawnPoint = nil
		return SelectSpawnPoint( currentRoom, enemy, encounter )
	end

	if enemy.RequiredSpawnPoint ~= nil then
		enemy.RequiredSpawnPoint = nil
		--DebugPrint({ Text = "No eligible spawn point nearby, removing RequiredSpawnPoint on"..enemy.Name })
		return SelectSpawnPoint( currentRoom, enemy, encounter )
	end

	if encounter.RequireNearPlayerDistance ~= nil and encounter.RequireNearPlayerDistance < 5000 then
		--DebugPrint({ Text = "No eligible spawn point nearby, increasing eligible distance." })
		encounter.RequireNearPlayerDistance = encounter.RequireNearPlayerDistance * 1.5
		return SelectSpawnPoint(currentRoom, enemy, encounter)
	end

	--DebugPrint({ Text = "Resetting spawn points, no eligible ids found within 5000 units" })
	currentRoom.SpawnPointsUsed = {}

end

function UnoccupySpawnPoint(spawnPointId)
	CurrentRun.CurrentRoom.SpawnPointsUsed[spawnPointId] = nil
end

function UnoccupySpawnPointOnDistance(enemy, spawnPointId, distance)
	enemy.SpawnPointThread = "OutsideSpawnDistance"..enemy.ObjectId
	NotifyOutsideDistance({ Id = enemy.ObjectId, DestinationId = spawnPointId, Distance = distance, Notify = enemy.SpawnPointThread })
	waitUntil( enemy.SpawnPointThread )
	UnoccupySpawnPoint(spawnPointId)
end

function IsSpawnPointEligible( spawnPointId, encounter, currentRoom )

	if currentRoom.SpawnPointsUsed[spawnPointId] ~= nil then
		return false
	end

	if encounter.SpawnNearId ~= nil and encounter.SpawnRadius ~= nil then
		local distance = GetDistance({ Id = spawnPointId, DestinationId = encounter.SpawnNearId })
		if distance > encounter.SpawnRadius then
			return false
		end
		if encounter.SpawnRadiusMin ~= nil and distance < encounter.SpawnRadiusMin then
			return false
		end
	end

	if encounter.RequireMinPlayerDistance ~= nil and currentRoom.HeroEndPoint ~= nil then
		local distance = GetDistance({ Id = currentRoom.HeroEndPoint, DestinationId = spawnPointId })
		if distance < encounter.RequireMinPlayerDistance then
			return false
		end
	end

	if encounter.RequireNearPlayerDistance ~= nil then
		local distance = GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = spawnPointId })
		if distance > encounter.RequireNearPlayerDistance then
			return false
		end
	end

	return true
end

ConstantsData.MaxActiveEnemyCount = 10

function CalculateActiveEnemyCap( currentRun, currentRoom, currentEncounter )
	local enemyCap = currentEncounter.ActiveEnemyCapBase or ConstantsData.MaxActiveEnemyCount
	local maxEnemyCap = currentEncounter.ActiveEnemyCapMax or ConstantsData.MaxActiveEnemyCount

	if currentEncounter.ActiveEnemyCapDepthRamp then
		enemyCap = enemyCap + (currentRun.BiomeDepthCache * currentEncounter.ActiveEnemyCapDepthRamp)
	end
	if currentEncounter.ActiveEnemyCapMin ~= nil and currentEncounter.ActiveEnemyCapMax ~= nil then
		enemyCap = RandomInt(currentEncounter.ActiveEnemyCapMin, currentEncounter.ActiveEnemyCapMax)
	end

	if currentEncounter.EnemyCountShrineModifierName then
		local modifierName = currentEncounter.EnemyCountShrineModifierName
		enemyCap = math.floor( enemyCap + (GetNumMetaUpgrades(modifierName) * currentEncounter.EnemyCountShineModifierAmount ) )
	else
		enemyCap = math.floor( enemyCap + (GetNumMetaUpgrades("EnemyCountShrineUpgrade") * 0.4) )
	end

	for enemyName, attributes in pairs(currentRoom.EliteAttributes) do
		if Contains(attributes, "Disguise") then
			enemyCap = maxEnemyCap
			DebugPrint({ Text = "DISGUISE Active Enemy Cap: "..enemyCap })
			break
		end
	end

	if enemyCap > maxEnemyCap then
		enemyCap = maxEnemyCap
	end
	DebugPrint({ Text = "Active Enemy Cap: "..enemyCap })
	return enemyCap
end

function HandleTimedSpawns( eventSource, args )

	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource

	local newSpawns = currentEncounter.SpawnWaves
	local nextLayerIndex = 1

	local timeLimit = currentEncounter.TimeLimit
	local startingTime = _worldTime
	currentEncounter.RemainingTime = timeLimit
	currentEncounter.TimeModifier = currentEncounter.TimeModifier or 0

	CheckObjectiveSet( currentEncounter.EncounterType )
	CheckObjectiveSet( currentEncounter.ObjectiveSets )

	UpdateObjective( currentEncounter.EncounterType, "RemainingSeconds", math.ceil(currentEncounter.RemainingTime))
	thread( SurvivalObjectivePresentation, currentEncounter )

	currentEncounter.ActiveEnemyCap = CalculateActiveEnemyCap(currentRun, currentRoom, currentEncounter)

	if currentEncounter.SpawnHazards then
		thread(HandleHazardSpawns, currentRoom, currentEncounter)
	end

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		waitUntil( "EditingModeOff" )
	end
	wait( 1.0, RoomThreadName )

	local spawnIntervalStart = 0
	local nextSpawnInterval = 0

	local lastTrapActivateTime = 0
	local trapType = GetRandomValue(currentEncounter.TrapTypes)
	currentEncounter.DisabledTrapIds = GetIds({ Name = "Traps" })
	currentEncounter.EnabledTrapIds = {}

	-- While there is still time
	currentEncounter.TimeIsUp = false
	while currentEncounter.RemainingTime > 0 do
		-- Check if there are new spawn layers to add
		if newSpawns ~= nil and newSpawns[nextLayerIndex] ~= nil and currentEncounter.RemainingTime <= newSpawns[nextLayerIndex].AddAtTime then
			AddEncounterLayer(currentRun, currentRoom, currentEncounter, newSpawns[nextLayerIndex])
			nextLayerIndex = nextLayerIndex + 1
		end

		-- Spawn a new unit
		if _worldTime > spawnIntervalStart + nextSpawnInterval then
			if currentEncounter.ActiveEnemyCap == nil or GetActiveEnemyCount() < currentEncounter.ActiveEnemyCap then
				HandleNextSpawn(currentEncounter)
			elseif GetActiveEnemyCount() >= currentEncounter.ActiveEnemyCap then
				if currentEncounter.SpawnIntervalMin == 0 and currentEncounter.SpawnIntervalMax == 0 then
					nextSpawnInterval = 0.2
				end
			end

			nextSpawnInterval = RandomFloat( currentEncounter.SpawnIntervalMin, currentEncounter.SpawnIntervalMax )
			spawnIntervalStart = _worldTime
		end

		if CurrentRun.CurrentRoom.ElapsedTimeMultiplier then
			startingTime = startingTime + ( 1 - CurrentRun.CurrentRoom.ElapsedTimeMultiplier) * 0.25
		end
		if GetConfigOptionValue({ Name = "EditingMode" }) then
			waitUntil( "EditingModeOff" )
		end
		wait( 0.25, RoomThreadName )
		currentEncounter.RemainingTime = timeLimit - (_worldTime - startingTime) + currentEncounter.TimeModifier
	end
	currentEncounter.TimeIsUp = true
	thread( HadesSpeakingPresentation, eventSource, { VoiceLines = GlobalVoiceLines.SurvivalEncounterSurvivedVoiceLines } )

	if currentEncounter.EncounterType == "SurvivalChallenge" then
		thread(DestroyRequiredKills, ({ BlockLoot = true, DestroyInterval = currentEncounter.DestroyEnemyInterval or 0.05, BlockDeathWeapons = true }) )
	end
	thread( MarkObjectiveComplete, currentEncounter.EncounterType )
end

function AddEncounterLayer( currentRun, currentRoom, currentEncounter, layerData )

	for k, spawnInfo in pairs( layerData.Spawns ) do
		spawnInfo.RemainingSpawns = CalcTotalSpawns( currentRun, currentRoom, currentEncounter, spawnInfo )

		if spawnInfo.Name == nil then
			spawnInfo.Name = k
			DebugPrint({ Text = "WARNING "..k.."'s spawnInfo had no name, adding now" })
		end

		currentEncounter.Spawns[spawnInfo.Name] = spawnInfo
		--DebugPrint({ Text = spawnInfo.Name.." added to encounter ("..spawnInfo.RemainingSpawns..")" })
	end
end

function GetActiveEnemyCount()
	local count = 0
	for id, enemy in pairs( RequiredKillEnemies ) do
		if not enemy.SkipActiveCount then
			local activeCapWeight = enemy.ActiveCapWeight or 1
			count = count + activeCapWeight
		end
	end
	count = count + (MapState.PlaceholderEnemyCount or 0)
	return count
end

function CheckForAllEnemiesDead( eventSource, args )
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource or CurrentRun.CurrentRoom.Encounter
	local notifyName = "AllRequiredKillEnemiesDead"

	NotifyOnAllDead({ Names = { "RequiredKillEnemies" }, Notify = notifyName })
	waitUntil( notifyName, RoomThreadName )
	currentEncounter.InProgress = false
	if currentEncounter.TimerBlock ~= nil then
		RemoveTimerBlock( CurrentRun, currentEncounter.TimerBlock )
	end

	if ShouldDoLastKillPresentation(currentEncounter) then
		local lastKillFunctionName = currentEncounter.LastKillPresentationFunction or "LastKillPresentation"
		local lastKillFunction = _G[lastKillFunctionName]
		lastKillFunction( LastEnemyKilled )
	end

	ExpireProjectiles({ Names = { "PoisonPuddle", "PoisonPuddleSmall", "RatPoisonShake", "RatDeathPuddle", "LavaPuddleLarge", "LavaSplash", "PoisonTrapWeapon", "ArcherTrapWeapon" } })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "StyxPoison" })
	ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "DamageOverTime" })
	if currentEncounter.PassiveRoomWeapons ~= nil then
		Destroy({ Ids = currentEncounter.PassiveRoomWeapons })
	end

	local killHazardEnemies = { "LavaSplash" }
	for k, enemyType in pairs(killHazardEnemies) do
		for k, enemyId in pairs( GetIdsByType({ Name = enemyType }) ) do
			if ActiveEnemies[enemyId] ~= nil then
				Kill( ActiveEnemies[enemyId] )
			end
		end
	end

	thread(MarkObjectiveComplete, "KillRequiredEnemies")
	if currentEncounter.EncounterType == "PerfectClear" then
		thread( HadesSpeakingPresentation, eventSource, { VoiceLines = GlobalVoiceLines.PerfectClearEncounterClearedVoiceLines, ColorGrade = "PerfectClear" } )
		if not currentEncounter.PlayerTookDamage then
			thread(MarkObjectiveComplete, "PerfectClear")
		end
		thread(MarkObjectiveComplete, "PerfectClearCleanup")
	end
end

function CheckForEncounterEnemiesDead( eventSource, args )
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = eventSource or CurrentRun.CurrentRoom.Encounter
	local notifyName = "AllEncounterEnemiesDead"

	NotifyOnAllDead({ Names = { currentEncounter.Name.."Spawns" }, Notify = notifyName })
	waitUntil( notifyName )
end

function ShouldDoLastKillPresentation( currentEncounter )
	if currentEncounter.SkipLastKillPresentation then
		return false
	end
	if CurrentRun.CurrentRoom.SkipLastKillPresentation then
		return false
	end
	if LastEnemyKilled == nil then
		return false
	end
	if CurrentRun.Hero.HandlingDeath then
		return false
	end
	local currentWaveNum = currentEncounter.CurrentWaveNum or 1
	if currentEncounter.SpawnWaves ~= nil and TableLength(currentEncounter.SpawnWaves) > currentWaveNum then
		return false
	end

	return true
end

function EncounterAudio( eventSource )

	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = CurrentRun.CurrentRoom.Encounter

	if currentEncounter.StartVoiceLines ~= nil then
		thread( PlayVoiceLines, currentEncounter.StartVoiceLines )
	end
	if currentEncounter.StartGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[currentEncounter.StartGlobalVoiceLines] )
	elseif not currentEncounter.SkipCombatBeginsVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines.CombatBeginsVoiceLines, true )
	end
	local music = currentEncounter.Music
	if music ~= nil then
		if currentEncounter.MusicTarget then
			local musicTargetId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationNames = currentEncounter.MusicTarget, Distance = 99999 })
			MusicPlayer( music, nil, musicTargetId )
			SetSoundCueValue({ Id = MusicId, Names = { "LowPass" }, Value = 0.0, Duration = 0.5 })
		else
			MusicPlayer( music )
		end
	end
	if currentEncounter.MusicianMusic ~= nil and currentEncounter.MusicTarget ~= nil then
		MusicianMusic( currentEncounter, { TrackName = currentEncounter.MusicianMusic, TargetName = currentEncounter.MusicTarget } )
		SetSoundCueValue({ Id = AmbientMusicId, Names = { "LowPass" }, Value = 0.0, Duration = 0.5 })
	end
	thread( MusicMixer, currentEncounter )
end

function PostCombatAudio( eventSource )

	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = CurrentRun.CurrentRoom.Encounter

	local endMusicDuration = currentRoom.EndMusicOnCombatOver or currentEncounter.EndMusicOnCombatOver
	if endMusicDuration ~= nil then
		EndMusic( MusicId, MusicName, endMusicDuration )
	end

	if currentEncounter.Spawns ~= nil then
		-- VO
		if currentEncounter.ThanatosId == nil then
			local currentHealth = currentRun.Hero.Health
			local currentHealthFraction = currentRun.Hero.Health / currentRun.Hero.MaxHealth
			local prevRoom = GetPreviousRoom( currentRun )
			if currentRoom.CombatResolvedVoiceLines ~= nil then
				thread( PlayVoiceLines, currentRoom.CombatResolvedVoiceLines, true )
			else
				-- if you suffered a lot of damage and were reduced to low health
				if prevRoom ~= nil and prevRoom.EndingHealth ~= nil and prevRoom.EndingHealth - currentHealth >= 25 and currentHealthFraction < 0.3 then
					thread( PlayVoiceLines, GlobalVoiceLines.CombatResolvedLowHealthVoiceLines, true )
				end
				thread( PlayVoiceLines, GlobalVoiceLines.CombatResolvedVoiceLines, true )
			end
		else
			for k, unit in pairs( ActiveEnemies ) do
				if unit.EncounterEndVoiceLines ~= nil then
					thread( PlayVoiceLines, unit.EncounterEndVoiceLines, nil, unit )
				end
			end
		end

		if MusicSection ~= 2 then
			SetSoundCueValue({ Names = { "Guitar" }, Id = MusicId, Value = 0, Duration = 0.25 })
		end
		if currentEncounter.MuteSecretMusicDrumsOnCombatOver and SecretMusicId ~= nil then
			SetSoundCueValue({ Names = { "Drums" }, Id = SecretMusicId, Value = 0 })
		end

		CheckMusicEvents( currentRun, CombatOverMusicEvents )

	end

	if currentEncounter.EncounterResolvedGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[currentEncounter.EncounterResolvedGlobalVoiceLines] )
	end

end

function GrantLoot(eventSource, args)
	CreateLoot( LootData[args.ConsumableName] )
end

function ActivateObjects( eventSource, args )
	if args.ObjectType == nil then
		return nil
	end

	local ids = GetInactiveIdsByType({ Name = args.ObjectType })
	Activate({ Ids = ids })

end

function ActivateConditionalItems( eventSource, args )

	args = args or {}

	for name, itemData in pairs( ConditionalItemData ) do
		if itemData.Slot == "CosmeticBedroom" then
			-- Not for this room
		elseif GameState.Cosmetics[name] and not itemData.Disabled and not GameState.Flags.InFlashback then
			ActivateConditionalItem( itemData )
		elseif not GetConfigOptionValue({ Name = "EditingMode" }) then
			DeactivateConditionalItem( itemData )
		end
	end
end

function ActivateBedroomConditionalItems()
	local ids = GetIds({ Names = { "Conditional" } })
	local hiddenItems = {}
	for k, id in pairs( ids ) do
		local name = GetName({ Id = id })
		local itemData = ConditionalItemData[name]
		if itemData ~= nil then
			if ( not GameState.Cosmetics[name]
				and not IsGameStateEligible(CurrentRun, ConditionalItemData[name].AlwaysOnIf ))
				or GameState.Cosmetics[name] == UIData.Constants.PENDING_REVEAL then

				if ConditionalItemData[name].ConnectedIds ~= nil then
					SetAlpha({ Ids = ConditionalItemData[name].ConnectedIds, Fraction = 0, Duration = 0 })
					SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = ConditionalItemData[name].ConnectedIds})
					SetThingProperty({ Property = "StopsLight", Value = false, DestinationIds = ConditionalItemData[name].ConnectedIds})
					BlockVfx({ DestinationIds = ConditionalItemData[name].ConnectedIds })
					UseableOff({ Ids = ConditionalItemData[name].ConnectedIds })
				end
				SetAlpha({ Id = id, Fraction = 0, Duration = 0 })
				BlockVfx({ DestinationIds = ConditionalItemData[name].ConnectedIds })
				SetThingProperty({ Property = "StopsUnits", Value = false, DestinationId = id})
				SetThingProperty({ Property = "StopsLight", Value = false, DestinationId = id})
				UseableOff({ Id = id })
			else
				if itemData.DeactivateIds ~= nil then
					SetAlpha({ Ids = itemData.DeactivateIds, Fraction = 0, Duration = 0 })
				end
			end
		end
	end
end

function ActivateConditionalItem( itemData )
	-- On
	if itemData.DestroyIds ~= nil then
		Destroy({ Ids = itemData.DestroyIds })
	end
	if itemData.DestroyNames ~= nil then
		Destroy({ Ids = GetIdsByType({ Name = itemData.DestroyNames }) })
	end
	if itemData.ActivateIds ~= nil then
		Activate({ Ids = itemData.ActivateIds })
		SetAlpha({ Ids = itemData.ActivateIds, Fraction = 1 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = true, DestinationIds = itemData.ActivateIds })
			SetThingProperty({ Property = "StopsLight", Value = true, DestinationIds = itemData.ActivateIds })
		end
		if itemData.ToggleVfx then
			UnblockVfx({ DestinationIds = itemData.ActivateIds, ResetCap = true })
		end
	end
	if itemData.ToggleUseability then
		UseableOn({ Ids = itemData.ToggleUseabilityIds or itemData.ActivateIds })
	end
	if itemData.DeactivateIds ~= nil and not GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAlpha({ Ids = itemData.DeactivateIds, Fraction = 0 })
		if itemData.ActivateStopAnimations then
			StopAnimation({ Names = itemData.ActivateStopAnimations, DestinationIds = itemData.DeactivateIds, PreventChain = true })
		end
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = itemData.DeactivateIds })
			SetThingProperty({ Property = "StopsLight", Value = false, DestinationIds = itemData.DeactivateIds })
		end
	end
	if itemData.ToggleUseabilityOffIds then
		UseableOff({ Ids = itemData.ToggleUseabilityOffIds })
	end
	if itemData.DeactivateCosmetics ~= nil then
		for k, name in pairs( itemData.DeactivateCosmetics ) do
			DeactivateConditionalItem( ConditionalItemData[name] )
		end
	end
	if itemData.ActivateNames ~= nil then
		local activateNameIds = GetIdsByType({ Name = itemData.ActivateNames })
		Activate({ Ids = activateNameIds })
		SetAlpha({ Ids = activateNameIds, Fraction = 1 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = true, DestinationIds = activateNameIds })
			SetThingProperty({ Property = "StopsLight", Value = true, DestinationIds = activateNameIds })
		end
	end
	if itemData.DeactivateNames ~= nil and not GetConfigOptionValue({ Name = "EditingMode" }) then
		local deactivateNameIds = GetIdsByType({ Name = itemData.DeactivateNames })
		SetAlpha({ Ids = deactivateNameIds, Fraction = 0 })
	end
	if itemData.ActivateGroups ~= nil then
		Activate({ Names = itemData.ActivateGroups })
		SetAlpha({ Ids = GetIds({ Names = itemData.ActivateGroups }), Fraction = 1 })
		if itemData.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = true, DestinationNames = itemData.ActivateGroups })
			SetThingProperty({ Property = "StopsLight", Value = true, DestinationNames = itemData.ActivateGroups })
		end
	end
	if itemData.DeactivateGroups ~= nil and not GetConfigOptionValue({ Name = "EditingMode" }) then
		SetAlpha({ Ids = GetIds({ Names = itemData.DeactivateGroups }), Fraction = 0 })
	end
	if itemData.ActivateObstacles ~= nil then
		for id, obstacleData in pairs( itemData.ActivateObstacles ) do
			local obstacle = DeepCopyTable( obstacleData )
			obstacle.ObjectId = id
			Activate({ Id = obstacle.ObjectId })
			SetAlpha({ Id = obstacle.ObjectId, Fraction = 1 })
			SetupObstacle( obstacle )
		end
	end
	if itemData.InspectPoint and CurrentDeathAreaRoom.InspectPoints[itemData.InspectPoint] and not HasUsed( itemData.InspectPoint ) then
		Activate({ Id = itemData.InspectPoint })
		SetAlpha({ Id = itemData.InspectPoint, Fraction = 1 })
		UseableOn({ Id = itemData.InspectPoint })
		local inspectPointData = CurrentDeathAreaRoom.InspectPoints[itemData.InspectPoint]
		inspectPointData.RecordUse = true
		AttachLua({ Id = itemData.InspectPoint, Table = inspectPointData })
	end

	if itemData.SetAnimations ~= nil then
		for name, animation in pairs( itemData.SetAnimations ) do
			SetAnimation({ DestinationIds = GetIdsByType({ Name = name }), Name = animation })
		end
	end
	if itemData.SetAnimationIds ~= nil then
		for id, animation in pairs( itemData.SetAnimationIds ) do
			SetAnimation({ DestinationId = id, Name = animation })
		end
	end
	if itemData.SetHSVs ~= nil then
		for name, hsv in pairs( itemData.SetHSVs ) do
			SetHSV({ Ids = GetIdsByType({ Name = name }), HSV = hsv, ValueChangeType = "Absolute" })
		end
	end
	if itemData.SetColorIds ~= nil then
		SetColor({ Ids = itemData.SetColorIds, Color = itemData.SetColorValue, SetBase = true, })
	end
	if itemData.DistanceTriggers ~= nil then
		StartTriggers( itemData, itemData.DistanceTriggers )
	end
end

function DeactivateConditionalItem( itemData )

	if itemData == nil then
		return
	end

	-- Off
	if itemData.RemoveCosmetics == nil or not ContainsAnyKey( GameState.Cosmetics, itemData.RemoveCosmetics ) or itemData.IndependentToggle then
		if itemData.ActivateIds ~= nil then
			SetAlpha({ Ids = itemData.ActivateIds, Fraction = 0 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = itemData.ActivateIds })
				SetThingProperty({ Property = "StopsLight", Value = false, DestinationIds = itemData.ActivateIds })
			end
			if itemData.ToggleVfx then
				BlockVfx({ DestinationIds = itemData.ActivateIds })
			end
			if itemData.DeactivateStopAnimations then
				StopAnimation({ Names = itemData.DeactivateStopAnimations, DestinationIds = itemData.ActivateIds, PreventChain = true })
			end
		end
		if itemData.ToggleUseability then
			UseableOff({ Ids = itemData.ToggleUseabilityIds or itemData.ActivateIds })
		end
		if itemData.ActivateNames ~= nil then
			local activateNameIds = GetIdsByType({ Name = itemData.ActivateNames })
			SetAlpha({ Ids = activateNameIds, Fraction = 0 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = activateNameIds })
				SetThingProperty({ Property = "StopsLight", Value = false, DestinationIds = activateNameIds })
			end
		end
		if itemData.ActivateGroups ~= nil then
			SetAlpha({ Ids = GetIds({ Names = itemData.ActivateGroups }), Fraction = 0 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = false, DestinationNames = itemData.ActivateGroups })
				SetThingProperty({ Property = "StopsLight", Value = false, DestinationNames = itemData.ActivateGroups })
			end
		end
		if itemData.RemovalDeactivateIds ~= nil or itemData.DeactivateIds ~= nil then
			SetAlpha({ Ids = itemData.RemovalDeactivateIds or itemData.DeactivateIds, Fraction = 1 })
			if itemData.ToggleCollision then
				SetThingProperty({ Property = "StopsUnits", Value = true, DestinationIds = itemData.RemovalDeactivateIds or itemData.DeactivateIds })
				SetThingProperty({ Property = "StopsLight", Value = true, DestinationIds = itemData.RemovalDeactivateIds or itemData.DeactivateIds })
			end
		end
		if itemData.ConnectedIds then
			SetAlpha({ Ids = itemData.ConnectedIds, Fraction = 0 })
		end
		if itemData.InspectPoint and CurrentDeathAreaRoom.InspectPoints[itemData.InspectPoint] and not HasUsed( itemData.InspectPoint ) then
			UseableOff({ Id = itemData.InspectPoint })
			SetAlpha({ Id = itemData.InspectPoint, Fraction = 0 })
		end
		if itemData.DeactivateAnimations ~= nil then
			for name, animation in pairs( itemData.DeactivateAnimations ) do
				SetAnimation({ DestinationIds = GetIdsByType({ Name = name }), Name = animation })
			end
		end
		if itemData.DeactivateAnimationIds ~= nil then
			for id, animation in pairs( itemData.DeactivateAnimationIds ) do
				SetAnimation({ DestinationId = id, Name = animation })
			end
		end
	end
end

-- ending
function ActivateHadesBedroomDoor( source, args )
	SetAlpha({ Id = 555678, Fraction = 1.0 })
	SetThingProperty({ Property = "StopsUnits", Value = true, Id = 555678 })
	SetThingProperty({ Property = "StopsLight", Value = true, Id = 555678 })
	UseableOn({ Id = 555678 })
	Destroy({ Id = 555681 })
end

function RestoreActivateHadesBedroomDoor()
	wait( 2.0, RoomThreadName )
	ActivateHadesBedroomDoor()
end

-- New Run Door / Pact of Punishment
function SetupExitDoor( source )
	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end

	if GetNumRunsCleared() > 0 or GameState.Flags.HardMode then
		SetAlpha({ Ids = GetIds({ Name = "ExitDoorBasic" }), Fraction = 0.0, Duration = 0 })
		local entranceId = 487596
		local contractId = 487586
		SetAnimation({ Name = "HouseContractClosed", DestinationId = contractId })
		thread( SetupPactDoor, source, entranceId, contractId )
	else
		SetAlpha({ Ids = GetIds({ Name = "ExitDoorPact" }), Fraction = 0.0, Duration = 0 })
	end
end

function SetupPactDoor( source, entranceId, contractId )
	local activationDistance = 600
	local repeatBufferDistance = 30
	while CurrentDeathAreaRoom and CurrentDeathAreaRoom.Name == source.Name do
		NotifyWithinDistance({ Id = entranceId, DestinationId = CurrentRun.Hero.ObjectId, Distance = activationDistance - repeatBufferDistance, Notify = "ContractOpen" })
		waitUntil( "ContractOpen" )
		SetAnimation({ Name = "HouseContractOpen", DestinationId = contractId })
		NotifyOutsideDistance({ Id = entranceId, DestinationId = CurrentRun.Hero.ObjectId, Distance = activationDistance + repeatBufferDistance, Notify = "ContractClose" })
		waitUntil( "ContractClose" )
		SetAnimation({ Name = "HouseContractClose", DestinationId = contractId })
		wait(0.01)
	end
end

OnUsed{ "CosmeticRevealPoint",
	function(triggerArgs)
		CreateAnimation({ Name = "ProjectileTempFlare", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
		PlaySound({ Name = "/SFX/Menu Sounds/ObjectiveCompletedSparkles", Id = CurrentRun.Hero.ObjectId })
		UseableOff({ Id = triggerArgs.triggeredById })
		BlockVfx({ DestinationId = triggerArgs.triggeredById })
		SetAlpha({ Id = triggerArgs.triggeredById, Fraction = 0.0, Duration = 0.25 })
	end
}

function RevealPendingItems()
	AddInputBlock({ Name = "RevealPendingItems" })
	local ids = GetIds({ Names = { "Conditional" }})
	local revealedItems = {}
	for k, id in pairs (ids) do
		local name = GetName({ Id = id })
		if GameState.Cosmetics[name] == UIData.Constants.PENDING_REVEAL then
			table.insert( revealedItems, { Name = name, Id = id, DoReveal = true, InspectPoint = ConditionalItemData[name].InspectPoint, ToggleCollision = ConditionalItemData[name].ToggleCollision })
			if ConditionalItemData[name].ConnectedIds ~= nil then
				for i, connectedId in pairs(ConditionalItemData[name].ConnectedIds) do
					table.insert( revealedItems, { Name = name, Id = connectedId, DoReveal = false })
				end
			end
			GameState.Cosmetics[name] = UIData.Constants.VISIBLE
		end
	end
	thread( PlayVoiceLines, GlobalVoiceLines.CosmeticUnlockedVoiceLines, true )
	for i, data in pairs( revealedItems ) do
		local itemData =  ConditionalItemData[data.Name]
		if data.DoReveal then
			local sparkleId = SpawnObstacle({ Name = "GenericSparkles", Group = "FX_Standing", DestinationId = data.Id })
			PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement", Id = data.Id })
			PanCamera({ Id = data.Id, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3 })
			AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = data.Id })
			SetAnimation({ Name = "ZagreusInteractionThoughtful", DestinationId = CurrentRun.Hero.ObjectId })
			wait(1.5)
			SetAlpha({ Id = data.Id, Fraction = 1, Duration = 1.75 })
			PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow", Id = data.Id })
			if itemData.DeactivateIds ~= nil then
				SetAlpha({ Ids = itemData.DeactivateIds, Fraction = 0.0, Duration = 1.75 })
			end
			if ConditionalItemData[data.Name].BedroomRevealGlobalVoiceLines then
				local voiceData = ConditionalItemData[data.Name].BedroomRevealGlobalVoiceLines
				thread( PlayVoiceLines, GlobalVoiceLines[voiceData], true )
				wait(0.25)
			elseif ConditionalItemData[data.Name].BedroomRevealVoiceLines then
				thread( PlayVoiceLines, ConditionalItemData[data.Name].BedroomRevealVoiceLines, true )
				wait(0.25)
			else
				wait(2.5)
			end
			Destroy({ Id = sparkleId })
		end

		if data.InspectPoint then
			Activate({ Id = data.InspectPoint })
			local inspectPointData = CurrentDeathAreaRoom.InspectPoints[data.InspectPoint]
			inspectPointData.RecordUse = true
			AttachLua({ Id = data.InspectPoint, Table = inspectPointData })
		end

		UnblockVfx({ DestinationId = data.Id })
		SetAlpha({ Id = data.Id, Fraction = 1, Duration = 3 })
		if itemData.DeactivateIds ~= nil then
			SetAlpha({ Ids = itemData.DeactivateIds, Fraction = 0.0, Duration = 3.0 })
		end
		UseableOn({ Id = data.Id })
		if data.ToggleCollision then
			SetThingProperty({ Property = "StopsUnits", Value = true, DestinationId = data.Id })
		end
	end
	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.75 })
	RemoveInputBlock({ Name = "RevealPendingItems" })
end

function SpawnRoomReward( eventSource, args )

	local currentRun = CurrentRun
	local currentRoom = CurrentRun.CurrentRoom
	local currentEncounter = CurrentRun.CurrentRoom.Encounter

	local rewardType = currentRoom.ChangeReward or currentRoom.ChosenRewardType

	if rewardType == nil or rewardType == "Story" or currentRoom.DeferReward then
		if args ~= nil and args.VoiceLines ~= nil then
			thread( PlayVoiceLines, args.VoiceLines, true )
		end
		return
	end

	if currentRoom.SpawnRewardGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.SpawnRewardGlobalVoiceLines], true )
	end

	if rewardType == "Shop" then
		if args ~= nil and args.VoiceLines ~= nil then
			thread( PlayVoiceLines, args.VoiceLines, true )
		end

		-- @refactor Move to data
		SpawnStoreItemsInWorld()
		ActivatePrePlaced( eventSource, { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Charon_01" } } )
		local shopIds = GetInactiveIds({ Name = "Shop" })
		for k, id in pairs( shopIds ) do
			Activate({ Id = id })
		end
		local boatIds = GetInactiveIds({ Name = "Boat" })
		for k, id in pairs( boatIds ) do
			Activate({ Id = id })
		end
		return
	end

	local offsetTowardId = SelectRoomRewardSpawnPoint( CurrentRun.CurrentRoom )
	local lootPointId = currentRoom.SpawnRewardOnId or currentRun.Hero.ObjectId
	local angle = 0
	local lootOffset = {X=0, Y=0}

	local reward = nil

	if currentRoom.SpawnRewardOnId == nil then
		angle = GetAngleBetween({ Id = currentRun.Hero.ObjectId, DestinationId = offsetTowardId })
		lootOffset = CalcOffset( math.rad(angle), 110 )
	end

	wait( currentRoom.SpawnRewardDelay, RoomThreadName )

	if rewardType == "StackUpgrade" then
		reward = CreateStackLoot({ SpawnPoint = lootPointId, SuppressSpawnSounds = currentRoom.SuppressRewardSpawnSounds, OffsetX = lootOffset.X, OffsetY = lootOffset.Y, SuppressSpawnSounds = currentRoom.SuppressRewardSpawnSounds })
	elseif rewardType == "WeaponUpgrade" then
		reward = CreateWeaponLoot({ SpawnPoint = lootPointId, SuppressSpawnSounds = currentRoom.SuppressRewardSpawnSounds, OffsetX = lootOffset.X, OffsetY = lootOffset.Y, SuppressSpawnSounds = currentRoom.SuppressRewardSpawnSounds })
	elseif rewardType == "HermesUpgrade" then
		reward = GiveLoot({ ForceLootName = "HermesUpgrade", SpawnPoint = lootPointId, OffsetX = lootOffset.X, OffsetY = lootOffset.Y, SuppressSpawnSounds = currentRoom.SuppressRewardSpawnSounds })
	elseif rewardType == "Boon" then
		reward = GiveLoot({ ForceLootName = currentRoom.ForceLootName, SpawnPoint = lootPointId, OffsetX = lootOffset.X, OffsetY = lootOffset.Y, SuppressSpawnSounds = currentRoom.SuppressRewardSpawnSounds })
		if currentRoom.ForcedReward ~= nil then
			if currentRoom.ForcedReward.ForcedTextLines ~= nil then
				ProcessTextLines( currentRoom.ForcedReward.ForcedTextLines )
				reward.ForcedTextLines = currentRoom.ForcedReward.ForcedTextLines
			end
			if currentRoom.ForcedReward.ForcedUpgradeOptions ~= nil then
				reward.UpgradeOptions = currentRoom.ForcedReward.ForcedUpgradeOptions
				reward.BlockReroll = true
			end
			if currentRoom.ForcedReward.PostPickupFunction ~= nil then
				reward.PostPickupFunction = currentRoom.ForcedReward.PostPickupFunction
			end
		end
		local lootSpacing = 100
		local numBonusLoot = GetTotalHeroTraitValue("BonusLootAmount")
		UseHeroTraitsWithValue("BonusLootAmount")
		while numBonusLoot > 0 do
			numBonusLoot = numBonusLoot - 1
			GiveLoot({ OffsetX = lootOffset.X, OffsetY = lootOffset.Y })
			lootOffset.X = lootOffset.X + lootSpacing
		end
	elseif rewardType == "TrialUpgrade" then
		reward = GiveLoot({ ForceLootName = "TrialUpgrade", SpawnPoint = lootPointId, OffsetX = lootOffset.X, OffsetY = lootOffset.Y })
	elseif rewardType == "Devotion" then
		reward = GiveLoot({ ForceLootName = currentEncounter.SpurnedGodName, ExchangeOnlyFromLootName = currentEncounter.ChosenGodName, SpawnPoint = lootPointId, OffsetX = lootOffset.X, OffsetY = lootOffset.Y })
		reward.CanReceiveGift = false
		-- Reconcile presentation
	else
		local consumableId = SpawnObstacle({ Name = rewardType, DestinationId = lootPointId, Group = "Standing", OffsetX = lootOffset.X, OffsetY = lootOffset.Y })
		reward = CreateConsumableItem( consumableId, rewardType, 0 )
		if reward ~= nil then
			ApplyConsumableItemResourceMultiplier( currentRoom, reward )
			ExtractValues( CurrentRun.Hero, reward, reward )
			ActivatedObjects[consumableId] = reward

			if reward.SpawnSound ~= nil then
				PlaySound({ Name = reward.SpawnSound, Id = reward.ObjectId })
			end
			thread( PlayRandomEligibleVoiceLines, { reward.OnSpawnVoiceLines, GlobalVoiceLines.MiscRewardGrantedVoiceLines } )
		end

	end

	local rewardOverrides = currentRoom.BoonRaritiesOverride or currentRoom.RewardConsumableOverrides or currentRoom.RewardOverrides or {}
	local rewardBoostedAnimation = rewardOverrides.RewardBoostedAnimation or currentEncounter.RewardBoostedAnimation or currentRoom.RewardBoostedAnimation
	if currentRoom.ChangeReward == nil and rewardBoostedAnimation ~= nil then
		CreateAnimation({ DestinationId = reward.ObjectId, Name = rewardBoostedAnimation })
	end

	if currentRoom.DisableRewardMagnetisim then
		SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = reward.ObjectId })
	end

	if args ~= nil and args.VoiceLines ~= nil then
		thread( PlayVoiceLines, args.VoiceLines, true )
	end

	if args ~= nil and args.WaitUntilPickup then
		if reward.MenuNotify ~= nil then
			waitUntil( UIData.BoonMenuId )
		else
			reward.NotifyName = "OnUsed"..reward.ObjectId
			waitUntil( reward.NotifyName )
		end
	end

end

function SpawnPerfectClearRoomReward( eventSource, args )
	local encounter = CurrentRun.CurrentRoom.Encounter

	if encounter.PlayerTookDamage then
		CurrentRun.CurrentRoom.ChangeReward = "RoomRewardConsolationPrize"
	else
		CheckAchievement( { Name = "AchClearHeatGate" })
	end
	SpawnRoomReward(eventSource, args)
end

function CalcMetaProgressRatio( run )

	local metaProgressCount = 0
	local totalCount = 0

	if run.CurrentRoom.ChosenRewardType ~= nil then
		totalCount = totalCount + 1
		if run.CurrentRoom.RewardStoreName == "MetaProgress" then
			metaProgressCount = metaProgressCount + 1
		end
	end

	for k, room in ipairs( run.RoomHistory ) do
		if room.ChosenRewardType ~= nil then
			totalCount = totalCount + 1
			if room.RewardStoreName == "MetaProgress" then
				metaProgressCount = metaProgressCount + 1
			end
		end
	end

	if totalCount == 0 then
		--DebugPrint({ Text = "CalcMetaProgressRatio = 0.0 (0/0)" })
		return nil
	end

	local ratio = metaProgressCount / totalCount
	--DebugPrint({ Text = "CalcMetaProgressRatio = "..ratio.." ("..metaProgressCount.."/"..totalCount..")" })
	return ratio

end

function HandleChallengeLoot( challengeSwitch, challengeEncounter )
	if challengeEncounter ~= nil then
		Destroy({ Id = challengeSwitch.ValueTextAnchor })
		SetAnimation({ DestinationId = challengeSwitch.ObjectId, Name = "ChallengeSwitchOpen" })

		-- presentation
		PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ChestOpen", Id = challengeSwitch.ObjectId })
		PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection" })
		local healingMultiplier = CalculateHealingMultiplier()
		if ( challengeSwitch.RewardType == "Health" and healingMultiplier == 0 ) or (challengeSwitch.RewardType == "Money" and HasHeroTraitValue("BlockMoney")) then
			thread( PlayVoiceLines, GlobalVoiceLines.ChallengeSwitchEmptyVoiceLines, true )
		else
			thread( PlayVoiceLines, GlobalVoiceLines.ChallengeSwitchOpenedVoiceLines, true )
		end

		UseableOff({ Id = challengeSwitch.ObjectId })

		local lootPointId = CurrentRun.Hero.ObjectId
		--local angle = GetAngleBetween({ Id = challengeSwitch.ObjectId, DestinationId = lootPointId })
		local angle = GetAngleBetween({ Id = challengeSwitch.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		local distance = GetDistance({ Id = challengeSwitch.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		local dropOffset = CalcOffset(math.rad(angle), distance/2)

		for lootName, lootData in pairs(challengeEncounter.LootDrops) do
			if lootData.DropChance == nil or RandomChance(lootData.DropChance) then
				local minDrop = lootData.MinDrop or 1
				local maxDrop = lootData.MaxDrop or 1
				local dropCount = lootData.DropCount or RandomInt(minDrop, maxDrop)
				for index = 1, dropCount, 1 do
					local consumableId = SpawnObstacle({ Name = lootName, DestinationId = CurrentRun.Hero.ObjectId, Group = "Standing", ForceToValidLocation = true, })
					local cost = 0 -- All challenge loot is free
					CreateConsumableItem( consumableId, lootName, cost )
					ApplyUpwardForce({ Id = consumableId, Speed = RandomFloat( 500, 700 ) })
					ApplyForce({ Id = consumableId, Speed = RandomFloat( 50, 100 ), Angle = angle, SelfApplied = true })
				end
			end
		end
		if challengeSwitch.RewardType == "Money" then
			local moneyMultiplier = GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } )
			local amount = round( challengeSwitch.CurrentValue * moneyMultiplier )
			thread( GushMoney, { Amount = amount, LocationId = challengeSwitch.ObjectId, Radius = 50, Source = challengeSwitch.Name, Offset = dropOffset } )
		elseif challengeSwitch.RewardType == "Health" then
			Heal( CurrentRun.Hero, { HealAmount = challengeSwitch.CurrentValue, Name = "HealthChallengeSwitch" } )
		elseif challengeSwitch.RewardType == "MetaPoints" then
			local consumableId = SpawnObstacle({ Name = "RoomRewardMetaPointDrop", DestinationId = CurrentRun.Hero.ObjectId, Group = "Standing", ForceToValidLocation = true, })
			local cost = 0
			local consumable = CreateConsumableItem( consumableId, "RoomRewardMetaPointDrop", cost )
			consumable.AddResources = consumable.AddResources or {}
			consumable.AddResources.MetaPoints = round( challengeSwitch.CurrentValue * CalculateMetaPointMultiplier() )
			ApplyUpwardForce({ Id = consumableId, Speed = RandomFloat( 500, 700 ) })
			ApplyForce({ Id = consumableId, Speed = RandomFloat( 50, 100 ), Angle = angle, SelfApplied = true })
		elseif challengeSwitch.RewardType == "Gems" then
			local gemMultiplier = GetTotalHeroTraitValue( "GemMultiplier", { IsMultiplier = true } )
			local consumableId = SpawnObstacle({ Name = "GemDrop", DestinationId = CurrentRun.Hero.ObjectId, Group = "Standing", ForceToValidLocation = true, })
			local cost = 0
			local consumable = CreateConsumableItem( consumableId, "GemDrop", cost )
			consumable.AddResources = consumable.AddResources or {}
			consumable.AddResources.Gems = round(challengeSwitch.CurrentValue * gemMultiplier )
			ApplyUpwardForce({ Id = consumableId, Speed = RandomFloat( 500, 700 ) })
			ApplyForce({ Id = consumableId, Speed = RandomFloat( 50, 100 ), Angle = angle, SelfApplied = true })
		end
	end
end

function HandleChallengeLootDecay( challengeSwitch, challengeEncounter )
	local startingValue = challengeSwitch.StartingValue
	local rewardMultiplier = challengeSwitch.RewardMultiplier or 1
	local minValue = round( challengeEncounter.MinValue * rewardMultiplier )
	if challengeSwitch.RewardType == "Health" then
		minValue = round( minValue * CalculateHealingMultiplier())
	end
	if challengeSwitch.RewardType == "Money" and HasHeroTraitValue("BlockMoney") then
		minValue = 0
	end
	challengeSwitch.CurrentValue = startingValue
	local decayMultiplier = challengeSwitch.DecayMultiplier or 1
	local decayAmount = challengeEncounter.ValueDecayAmount * decayMultiplier * GetTotalHeroTraitValue("ChallengeDecayIncrease", {IsMultiplier = true})

	local challengeSwitchId = challengeSwitch.ObjectId

	wait( challengeEncounter.DecayStartDelay, RoomThreadName )

	ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, ColorTarget = {1, 0.8, 0, 1}, ColorDuration = 0.2 })
	ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, ColorTarget = {1, 1, 1, 1}, ColorDuration = 2, Delay = 0.2 })
	thread(PulseText, {Id = challengeEncounter.ValueTextAnchor, ScaleTarget = 1.8, ScaleDuration = 0.15, HoldDuration = 0.0})
	ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, Text = challengeSwitch.ChallengeText, LuaKey = "Amount", LuaValue = round(challengeSwitch.CurrentValue), Format = "LootFormat" })

	while( challengeSwitch.CurrentValue > minValue and challengeEncounter.InProgress and not CurrentRun.Hero.IsDead ) do

		challengeSwitch.CurrentValue = challengeSwitch.CurrentValue - decayAmount

		if challengeSwitch.CurrentValue < minValue then
			challengeSwitch.CurrentValue = minValue
		end
		ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, Text = challengeSwitch.ChallengeText, LuaKey = "Amount", LuaValue = round(challengeSwitch.CurrentValue), Format = "LootFormat" })
		if challengeSwitch.CurrentValue % 10 == 0 then
			thread(PulseText, {Id = challengeEncounter.ValueTextAnchor, ScaleTarget = 1.5, ScaleDuration = 0.15, HoldDuration = 0.0})
			PlaySound({ Name = "/Leftovers/Menu Sounds/RosterPickup" })
		end

		local intervalMultiplier = challengeSwitch.IntervalMultiplier or 1
		local ticks = 10
		for i = 1, ticks do
			local tickTime = (challengeEncounter.LootDecayInterval * intervalMultiplier) / ticks
			if CurrentRun.CurrentRoom.ElapsedTimeMultiplier then
				tickTime  = tickTime / CurrentRun.CurrentRoom.ElapsedTimeMultiplier
			end
			wait( tickTime, RoomThreadName )
		end

	end
end

function StartDevotionTest( currentRun, currentRoom, currentEncounter )
	currentRun = currentRun or CurrentRun
	currentRoom = currentRoom or CurrentRun.CurrentRoom
	currentEncounter = currentEncounter or CurrentRun.CurrentRoom.Encounter

	thread( PlayVoiceLines, GlobalVoiceLines.DevotionLootGrantedVoiceLines )

	local lootA = GiveLoot({ OffsetX = -85, OffsetY = 35, ForceLootName = currentEncounter.LootAName, SuppressSpawnSounds = true })
	lootA.CanReceiveGift = false
	SetThingProperty({ Property = "SortBoundsScale", Value = 1, DestinationId = lootA.ObjectId })
	SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = lootA.ObjectId })

	local lootB = GiveLoot({ OffsetX = 85, OffsetY = -35, ForceLootName = currentEncounter.LootBName, SuppressSpawnSounds = true })
	lootB.CanReceiveGift = false
	SetThingProperty({ Property = "SortBoundsScale", Value = 1, DestinationId = lootB.ObjectId })
	SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = lootB.ObjectId })

	waitUntil( UIData.BoonMenuId )

	local lootAId = lootA.ObjectId
	local lootBId = lootB.ObjectId
	local newLoots = { lootAId, lootBId }
	-- upgrade enemies with alternate upgrade
	local chosenLootName = NotifyResultsTable[ UIData.BoonMenuId ]
	local alternateLootId = nil
	local alternateLootData = nil
	if lootA.Name == chosenLootName then
		alternateLootId = lootBId
		alternateLootData = lootB
	else
		alternateLootId = lootAId
		alternateLootData = lootA
	end
	currentEncounter.ChosenGodName = chosenLootName
	currentEncounter.SpurnedGodName = alternateLootData.Name

	-- wait until slot upgrade is done
	DebugPrint({ Text = "Apply "..alternateLootData.Name.." to Enemies" })
	AddEnemyUpgrade( alternateLootData.Name, CurrentRun )
	currentEncounter.RemoveUpgradeOnEnd = alternateLootData.Name
	if EnemyData[alternateLootData.Name.."RoomWeapon"] ~= nil then
		currentEncounter.SpawnPassiveRoomWeapons = currentEncounter.SpawnPassiveRoomWeapons or {}
		table.insert(currentEncounter.SpawnPassiveRoomWeapons, alternateLootData.Name.."RoomWeapon")
	end
	CurrentRun.CurrentRoom.RejectedLootData = alternateLootData
	UseableOff({ Ids = newLoots })
	StartDevotionTestPresentation( CurrentRun.CurrentRoom, alternateLootData, alternateLootId )
	Destroy({ Ids = newLoots })
	EnableRoomTraps()
	ActivatedObjects[alternateLootId] = nil
	RemoveInputBlock({ Name = "DevotionTest" })
	StartEncounterEffects( CurrentRun )
end

function BossIntroHydra( eventSource, args )
	args.ProcessTextLinesIds = { eventSource.BossId }
	args.SetupBossIds = { eventSource.BossId }
	BossIntro( eventSource, args )
end

function BossIntroElysium( eventSource, args )
	local shrineLevel = GetNumMetaUpgrades( eventSource.ShrineMetaUpgradeName )
	BossIntro( eventSource, args[shrineLevel] )
end

function BossIntroCharon( eventSource, args )
	AddInputBlock({ Name = "BossIntro" })
	AddTimerBlock(CurrentRun, "CharonIntro")

	if not TextLinesRecord.BossCharonEncounter01 then
		wait( 4 )
	else
		wait( 1.5 )
	end

	RemoveInputBlock({ Name = "BossIntro" })	
	RemoveTimerBlock(CurrentRun, "CharonIntro")
	BossIntro( eventSource, args )
end

function BossIntroHades(eventSource, args)

	if eventSource.Encounter.Name == "BossHadesPeaceful" then
		args.ProcessTextLinesIds = { 552710 }
		args.UnlockDelay = 0.0
		args.SetupBossIds = nil
		args.ResetRoomZoom = nil

		eventSource.SpawnRewardDelay = 1.32
	end

	if TextLinesRecord["HadesAllowsLegendaryKeepsakes01"] ~= nil then
		eventSource.BlockHadesAssistTraits = false
	else
		eventSource.BlockHadesAssistTraits = true
	end
	
	BossIntro( eventSource, args )	

	if eventSource.Encounter.Name == "BossHadesPeaceful" then
		CurrentRun.ActiveBiomeTimer = false
	end
end

function BossIntro( eventSource, args )

	HideCombatUI("BossIntro")
	AddInputBlock({ Name = "BossIntro" })
	AddTimerBlock( CurrentRun, "BossIntro" )
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })

	PlayVoiceLines( args.VoiceLines )
	wait( 0.4, RoomThreadName )

	if args.ProcessTextLinesIds ~= nil then
		for k, id in ipairs(args.ProcessTextLinesIds) do
			if ActiveEnemies[id] ~= nil then
				local enemy = ActiveEnemies[id]
				if not args.SkipAngleTowardTarget then
					AngleTowardTarget({ Id = id, DestinationId = CurrentRun.Hero.ObjectId })
				end
				PanCamera({ Ids = id, Duration = args.DurationIn or 1.5, EaseIn = 0.05, EaseOut = 0.3 })
				if args.UsePanSound then
					PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })
				end
				ProcessTextLines( enemy.BossPresentationSuperPriorityIntroTextLineSets )
				ProcessTextLines( enemy.BossPresentationPriorityIntroTextLineSets )
				ProcessTextLines( enemy.BossPresentationIntroTextLineSets )
				ProcessTextLines( enemy.BossPresentationTextLineSets )
				ProcessTextLines( enemy.BossPresentationRepeatableTextLineSets )
				if not PlayRandomRemainingTextLines( enemy, enemy.BossPresentationSuperPriorityIntroTextLineSets ) then
					if not PlayRandomRemainingTextLines( enemy, enemy.BossPresentationPriorityIntroTextLineSets ) then
						if not PlayRandomRemainingTextLines( enemy, enemy.BossPresentationIntroTextLineSets ) then
							if not PlayRandomRemainingTextLines( enemy, enemy.BossPresentationTextLineSets ) then
								PlayRandomRemainingTextLines( enemy, enemy.BossPresentationRepeatableTextLineSets )
							end
						end
					end
				end
				if not args.SkipBossMusic then
					StartBossRoomMusic()
				end
			end
		end
	end
	if args.ResetRoomZoom then
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction or 1.0, Duration = 6.0, ZoomType = "Ease" })
	end

	if args.SetupBossIds ~= nil then
		for k, id in ipairs(args.SetupBossIds) do
			if ActiveEnemies[id] ~= nil then
				thread(SetupBoss, ActiveEnemies[id])
				-- used for Final Boss EM4
				CurrentRun.CurrentRoom.BossId = id
			end
		end
	end

	if args.UnlockDelay ~= nil then
		wait(args.UnlockDelay)
	end
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = args.DurationOut or 1.25, EaseIn = 0.04, EaseOut = 0.275 })

	RemoveInputBlock({ Name = "BossIntro" })
	RemoveTimerBlock( CurrentRun, "BossIntro" )
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })
	ShowCombatUI("BossIntro")
	if args.DelayedStart then
		StartEncounterEffects( CurrentRun )
	end
end

function SetupBoss(enemy)
	if enemy.FightStartGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[enemy.FightStartGlobalVoiceLines], nil, boss )
	end
	CreateBossHealthBar(enemy)
	wait(enemy.AISetupDelay)
	SetupAI( CurrentRun, enemy )
end

function BossStageTransition(boss, currentRun, aiStage)
	local bossId = boss.ObjectId
	SetUnitInvulnerable( boss )

	if aiStage.MoveToId ~= nil then
		MoveWithinRange(boss, aiStage.MoveToId, boss)
	end

	if aiStage.TransitionAnimation then
		SetAnimation({ DestinationId = bossId, Name = aiStage.TransitionAnimation })
	end
	if aiStage.CombatText ~= nil then
		thread(InCombatText, bossId, aiStage.CombatText, 3)
	end

	if aiStage.StageTransitionVoiceLines ~= nil and IsAlive({ Id = bossId }) then
		thread( PlayVoiceLines, aiStage.StageTransitionVoiceLines, nil, boss )
	end
	if aiStage.StageTransitionGlobalVoiceLines ~= nil and IsAlive({ Id = bossId }) then
		thread( PlayVoiceLines, GlobalVoiceLines[aiStage.StageTransitionGlobalVoiceLines], nil, boss )
	end

	if aiStage.FireWeapon ~= nil then
		boss.WeaponName = aiStage.FireWeapon
		local weaponAIData = GetWeaponAIData(boss)

		boss.ForcedWeaponInterrupt = nil
		DoAttackerAILoop( boss, currentRun, nil, weaponAIData )
	end

	if aiStage.TransitionUnthreadedFunctionNames ~= nil then
		for i, functionName in ipairs(aiStage.TransitionUnthreadedFunctionNames) do
			_G[functionName](boss, aiStage.TransitionUnthreadedFunctionArgs[i])
		end
	end

	-- Fire passive weapons
	if aiStage.DumbFireWeapons ~= nil then
		for k, weaponName in pairs(aiStage.DumbFireWeapons) do
			local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
			weaponData.Name = weaponName
			thread( DumbFireAttack, boss, currentRun, weaponData )
		end
	end

	wait( aiStage.WaitDuration or 2.0)

	SetUnitVulnerable( boss )
	StopAnimation({ Name = "Invincibubble", DestinationId = bossId })
end

function MinotaurFinalStageTransition( boss, currentRun, aiStage )
	if boss.CannotDieFromDamage then
		currentRun.CurrentRoom.Encounter.CancelSpawns = true
		boss.SkipOnDeathSpawnEncounter = true
		DestroyRequiredKills( { BlockLoot = true, SkipIds = { boss.ObjectId } } )
		MinotaurEarlyExitPresentation( boss, currentRun )
		Kill( boss, { SkipOnDeathFunction = true, Silent = true, SkipDestroyDelay = true, } )
	else
		BossStageTransition( boss, currentRun, aiStage )
	end
end

function MinotaurArmorBreak( boss, currentRun, aiStage )
	SetHSV({ Id = boss.ObjectId, HSV = { 0, 0, 0 }, ValueChangeType = "Absolute" })

	BossStageTransition( boss, currentRun, aiStage )
end

function CharonFightEnd( boss, currentRun, aiStage )
	currentRun.CurrentRoom.Encounter.CancelSpawns = true
	boss.SkipOnDeathSpawnEncounter = true
	DestroyRequiredKills( { BlockLoot = true, SkipIds = { boss.ObjectId } } )
	CharonFightEndPresentation( boss, currentRun )
	Kill( boss, { SkipOnDeathFunction = true, Silent = true, SkipDestroyDelay = true, } )
end

function StartChallengeEncounter( challengeSwitch )
	local challengeSwitchId = challengeSwitch.ObjectId
	SetAnimation({ DestinationId = challengeSwitch.ObjectId, Name = "ChallengeSwitchInProgress" })
	challengeSwitch.IsOpen = false
	challengeSwitch.UseText = "UseChallengeSwitchInProgress"
	RefreshUseButton( challengeSwitch.ObjectId, challengeSwitch )

	ModifyTextBox({ Id = challengeSwitch.ValueTextAnchor, Text = challengeSwitch.ChallengeText, LuaKey = "Amount", LuaValue = round(challengeSwitch.StartingValue), Format = "LootFormat", FadeTarget = 1.0, FadeDuration = 0.5 })
	SetAnimation({  Name = "InCombatTextShadow", DestinationId = challengeSwitch.ValueTextAnchor, OffsetY = -227, OffsetX = -40  })
	SetScaleX({ Id = challengeSwitch.ValueTextAnchor, Fraction = 0.66 })

	if CurrentRun.CurrentRoom.WellShop then
		SetAnimation({ DestinationId = CurrentRun.CurrentRoom.WellShop.ObjectId, Name = "WellShopRelock" })
		UseableOff({ Id = CurrentRun.CurrentRoom.WellShop.ObjectId })
	end
	if CurrentRun.CurrentRoom.SellTraitShop ~= nil then
		SetAnimation({ DestinationId = CurrentRun.CurrentRoom.SellTraitShop.ObjectId, Name = "SellTraitShopRelock" })
		UseableOff({ Id = CurrentRun.CurrentRoom.SellTraitShop.ObjectId })
	end

	local encounter = CurrentRun.CurrentRoom.ChallengeEncounter
	CurrentRun.CurrentRoom.StartedChallengeEncounter = true
	encounter.InProgress = true
	local difficultyModifer = challengeSwitch.DifficultyModifier or 1
	encounter.DifficultyRating = encounter.DifficultyRating * difficultyModifer
	RecordEncounter( CurrentRun, CurrentRun.CurrentRoom.ChallengeEncounter )

	EnableRoomTraps()
	HandleTrapChains( encounter )

	thread( HandleChallengeLootDecay, challengeSwitch, CurrentRun.CurrentRoom.ChallengeEncounter )
	StartEncounter( CurrentRun, CurrentRun.CurrentRoom, CurrentRun.CurrentRoom.ChallengeEncounter )
end

function EndChallengeEncounter( eventSource )
	local challengeEncounter = eventSource
	local challengeSwitch = challengeEncounter.Switch

	if challengeEncounter.EndedEarly then
		return
	end

	thread(MarkObjectiveComplete, "TimeChallenge")

	ChallengeEncounterEndPresentation( eventSource )

	SetAnimation({ DestinationId = challengeSwitch.ObjectId, Name = challengeSwitch.ReadyToOpenAnimationName })
	UseableOn({ Id = challengeSwitch.ObjectId })
	challengeSwitch.UseText = challengeSwitch.ChallengeResolvedUseText
	RefreshUseButton( challengeSwitch.ObjectId, challengeSwitch )
	challengeSwitch.ReadyToUse = true

	if CurrentRun.CurrentRoom.WellShop then
		SetAnimation({ DestinationId = CurrentRun.CurrentRoom.WellShop.ObjectId, Name = "WellShopUnlocked" })
		UseableOn({ Id = CurrentRun.CurrentRoom.WellShop.ObjectId })
	end
	if CurrentRun.CurrentRoom.SellTraitShop then
		SetAnimation({ DestinationId = CurrentRun.CurrentRoom.SellTraitShop.ObjectId, Name = "SellTraitShopUnlocked" })
		UseableOn({ Id = CurrentRun.CurrentRoom.SellTraitShop.ObjectId })
	end
end

function EnableCodex()
	CodexStatus.Enabled = true
	wait(0.25)
	DisplayUnlockText({
		TitleText = "Codex_Unlocked",
		SubtitleText = "Codex_Unlocked_Subtitle",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = { Name = weaponName }},
		-- Duration = 4.5,
	})

	wait(0.25)
	thread( ShowCodexUpdate )
end

function EnableMirrorSwap()
	GameState.Flags.SwapMetaupgradesEnabled = true
	wait(0.25)
	DisplayUnlockText({
		TitleText = "MetaUpgradeRespec_Unlocked",
		SubtitleText = "MetaUpgradeRespec_Unlocked_Subtitle",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = { Name = weaponName }},
		AnimationName = "LocationTextBGGeneric_Mirror",
		AnimationOutName = "LocationTextBGGenericOut_Mirror",
		-- Duration = 4.5,
	})
end

function SquelchHermes( source, args )
	CurrentRun.SquelchedHermes = true
	if args ~= nil and args.Permanent then
		CurrentRun.SquelchedHermesPermanently = true
	end
end

function AssignWeaponKits( eventSource, args )

	local kitIds = GetIdsByType({ Name = "WeaponKit01" })
	table.sort( kitIds )
	MapState.WeaponKits = {}

	--[[
	if SessionState.NeedWeaponPickupBinkLoad then
		PreLoadBinks({ Reset = true })
		SessionState.NeedWeaponPickupBinkLoad = false
	end
	]]

	local packages = {}
	for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
		table.insert( packages, weaponName )
		local linkdWeaponNames = WeaponSets.HeroWeaponSets[weaponName]
		if linkdWeaponNames ~= nil then
			ConcatTableValues( packages, linkedWeaponNames )
		end
	end
	LoadPackages({ Names = packages })

	local kitBinks = {}
	local weaponPrefixes = { "WeaponBow", "WeaponFists", "WeaponGun", "WeaponShield", "WeaponSpear", "WeaponSword" }
	for k, weaponPrefix in ipairs( weaponPrefixes ) do
		local weaponPostFixes = { "", "01", "02", "03" }
		for j, weaponPostFix in ipairs( weaponPostFixes ) do
			local kitBink = weaponPrefix..weaponPostFix
			table.insert( kitBinks, kitBink.."FloatingIdle" )
			table.insert( kitBinks, kitBink.."FloatingIdleOff" )
		end
	end
	PreLoadBinks({ Names = kitBinks })
	PreLoadBinks({ Names = TraitData.SkellyAssistTrait.LoadBinks })

	for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do

		local weaponData = WeaponData[weaponName]
		local kitId = RemoveFirstIndexValue( kitIds )

		if args.IgnoreRequirements or IsWeaponEligible( CurrentRun, weaponData ) then

			AttachLua({ Id = kitId, Table = weaponData })
			weaponData.ObjectId = kitId
			MapState.WeaponKits[kitId] = weaponData

			weaponData.TextAnchorId = SpawnObstacle({ Name = "BlankObstacle", Group = "Standing", DestinationId = kitId, OffsetZ = 81 })
			if IsWeaponUnlocked( weaponName ) then
				if IsWeaponUnused( weaponData.Name ) then
					if GameState.Cosmetics.UnusedWeaponBonusAddGems then
						weaponData.MetaPointPercentBonus = (TraitData.UnusedWeaponBonusTraitAddGems.MetaPointMultiplier - 1) * 100
						weaponData.GemPercentBonus = (TraitData.UnusedWeaponBonusTraitAddGems.GemMultiplier - 1) * 100
						weaponData.UseText = "UseWeaponKit_MetaPointBonus2"
					else
						weaponData.MetaPointPercentBonus = (TraitData.UnusedWeaponBonusTrait.MetaPointMultiplier - 1) * 100
						weaponData.UseText = "UseWeaponKit_MetaPointBonus"
					end
				end
			else
				if HasResource( weaponData.ResourceName, weaponData.UnlockCost ) then
					if weaponData.ResourceName == "LockKeys" then
						weaponData.UseText = "UseWeaponKit_LockedHasKey"
					elseif weaponData.ResourceName == "SuperLockKeys" then
						weaponData.UseText = "UseWeaponKit_LockedHasSuperKey"
					end
					SetAnimation({ Name="LockedIconHasKey", DestinationId = weaponData.TextAnchorId })
				else
						weaponData.UseText = "UseWeaponKit_LockedNoKey"
					SetAnimation({ Name="LockedIconNoKey", DestinationId = weaponData.TextAnchorId })
				end
			end

			if args.PreLoadBinks and not SessionState.NeedWeaponPickupBinkLoad then
				local overrideWeaponData = WeaponData[weaponName] --GetWeaponData( CurrentRun.Hero, weaponName )
				if GameState.LastWeaponUpgradeData[weaponName] ~= nil then
					local weaponUpgradeIndex = GameState.LastWeaponUpgradeData[weaponName].Index or 1
					local weaponUpgradeData = WeaponUpgradeData[weaponName][weaponUpgradeIndex]
					if weaponUpgradeData ~= nil and weaponUpgradeData.TraitName ~= nil then
						--DebugPrint({ Text = "weaponUpgradeData.TraitName = "..weaponUpgradeData.TraitName })
						overrideWeaponData = TraitData[weaponUpgradeData.TraitName].WeaponDataOverride[weaponName] or overrideWeaponData
					end
				end
				if overrideWeaponData.Binks then
					PreLoadBinks({ Names = overrideWeaponData.Binks, Cache = args.BinkCacheOverrides[weaponName] })
				elseif overrideWeaponData.WeaponBinks then
					local weaponBinks = CombineTables( overrideWeaponData.WeaponBinks, CurrentRun.Hero.WeaponBinks )
					PreLoadBinks({ Names = weaponBinks, Cache = args.BinkCacheOverrides[weaponName], Reset = (args.BinkCacheOverrides[weaponName] ~= nil) })
				end
			end
		else
			Destroy({ Id = kitId })
		end

	end

	-- Remove any unused kits
	Destroy({ Ids = CollapseTable( kitIds ) })

	UpdateWeaponKits()
end

function SpawnAllLoot( eventSource, args )

	local lootPointIds = GetIdsByType({ Name = "LootPoint" })
	table.sort( lootPointIds )
	local lootNames = GetAllKeys( LootData )
	table.sort( lootNames )
	for k, lootName in ipairs( lootNames ) do
		if not LootData[lootName].DebugOnly then
			local lootPointId = RemoveFirstIndexValue( lootPointIds )
			local loot = GiveLoot({ ForceLootName = lootName, SpawnPoint = lootPointId })
			SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = loot.ObjectId })
			loot.RespawnAfterUse = args.RespawnAfterUse
			loot.StripRequirements = args.StripInteractTextRequirements
			loot.WipeRecordsAfterUse = args.WipeRecordsAfterUse
			BlockVfx({ DestinationId = loot.ObjectId })
			if args.StopAnimations ~= nil then
				StopAnimation({ Names = args.StopAnimations, DestinationId = loot.ObjectId })
			end
			if args.StripInteractTextRequirements and loot.PickupTextLineSets ~= nil then
				for lineSetName, lineSet in pairs( loot.PickupTextLineSets ) do
					StripRequirements( lineSet )
				end
			end
		end
	end
	local weaponLoot = CreateWeaponLoot({ SpawnPoint = RemoveFirstIndexValue( lootPointIds )})
	weaponLoot.RespawnAfterUse = args.RespawnAfterUse
	weaponLoot.WipeRecordsAfterUse = args.WipeRecordsAfterUse
	weaponLoot.UpgradeOptions = nil
	SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = weaponLoot.ObjectId })

	local stackLoot = CreateStackLoot({ SpawnPoint = RemoveFirstIndexValue( lootPointIds )})
	stackLoot.RespawnAfterUse = args.RespawnAfterUse
	stackLoot.WipeRecordsAfterUse = args.WipeRecordsAfterUse
	stackLoot.StripRequirements = args.StripInteractTextRequirements
	stackLoot.UpgradeOptions = nil
	SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = stackLoot.ObjectId })

end

function SpawnAllConsumables( eventSource, args )

	local spawnPointIds = GetIds({ Name = "ConsumablePoints" })
	table.sort( spawnPointIds )
	local names = GetAllKeys( ConsumableData )
	for k, excludeName in pairs( args.ExcludeNames ) do
		RemoveValueAndCollapse( names, excludeName )
	end
	table.sort( names )
	for k, name in ipairs( names ) do
		local consumableId = SpawnObstacle({ Name = name, DestinationId = spawnPointIds[k], Group = "Standing" })
		local rampedData = GetRampedConsumableData( ConsumableData[name] )
		local consumable = CreateConsumableItemFromData( consumableId, rampedData, 0, args )
		SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = consumable.ObjectId })
		if args.StopAnimations ~= nil then
			StopAnimation({ Names = args.StopAnimations, DestinationId = consumable.ObjectId })
		end
	end

end

function CreateEnemySpawnButtons( eventSource, args )

	local spawnButtonIds = GetIds({ Name = args.SpawnButtonGroup })
	for k, name in ipairs( args.Names ) do
		local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = spawnButtonIds })
		RemoveValueAndCollapse( spawnButtonIds, spawnPointId )
		local spawnButton = { OnUsedSpawnUnit = name, OnUsedSpawnOnId = args.SpawnOnId, }
		AttachLua({ Id = spawnPointId, Table = spawnButton })
		local textOffsetY = 50
		local enemyData = EnemyData[name]
		local codexEntry = Codex.Enemies.Entries[enemyData.GenusName or enemyData.Name]
		if codexEntry ~= nil and codexEntry.Image ~= nil then
			SetAnimation({ DestinationId = spawnPointId, Name = codexEntry.Image })
			SetScale({ Id = spawnPointId, Fraction = 0.5 })
			textOffsetY = 80
			if enemyData.HealthBuffer ~= nil and enemyData.HealthBuffer > 0 then
				CreateTextBox({ Id = spawnPointId, Text = "(Elite)", FontSize = 16, OffsetY = textOffsetY, Color = Color.White, OutlineColor = Color.Black, OutlineThickness = 1, Justification = "CENTER" })
			end
		else
			CreateTextBox({ Id = spawnPointId, Text = name, FontSize = 16, OffsetY = textOffsetY, Color = Color.White, OutlineColor = Color.Black, OutlineThickness = 1, Justification = "CENTER" })
		end
	end

end

function CreateNPCSpawnButtons( eventSource, args )

	local names = GetAllKeys( UnitSetData.NPCs )
	for k, excludeName in pairs( args.ExcludeNames ) do
		RemoveValueAndCollapse( names, excludeName )
	end
	table.sort( names )

	local spawnButtonIds = ShallowCopyTable( args.SpawnButtonIds )
	for k, name in ipairs( names ) do
		local spawnPointId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = spawnButtonIds })
		RemoveValueAndCollapse( spawnButtonIds, spawnPointId )
		local spawnButton = { OnUsedSpawnUnit = name, OnUsedSpawnOnId = args.SpawnOnId, DisableOnUse = true, OnUsedFunctionName = "CheckConversations", }
		AttachLua({ Id = spawnPointId, Table = spawnButton })
		CreateTextBox({ Id = spawnPointId, Text = name, FontSize = 16, OffsetY = 50, Color = Color.White, OutlineColor = Color.Black, OutlineThickness = 1, Justification = "CENTER" })
	end

end

function EnemyNamePlates( eventSource, args )

	for enemyId, enemy in pairs( ActiveEnemies ) do
		CreateTextBox({ Id = enemyId, Text = enemy.Name, FontSize = 18, Font = "MonospaceTypewriterBold", ShadowOffset = {0, 2}, ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 4}, OutlineThickness = 2, OutlineColor = {0.0, 0.0, 0.0,1} })
	end

end

function ShowMaterialText( eventSource, args )

	local ids = GetIds({ Name = args.Group })
	for k, id in pairs( ids ) do
		local obstacle = MapState.ActiveObstacles[id]
		local name = nil
		if obstacle ~= nil then
			name = obstacle.Name
		else
			name = GetName({ Id = id })
		end
		local material = GetMaterial( name, obstacle )
		local text = "Material = "..tostring(material)
		CreateTextBox({ Id = id, Text = text, FontSize = 18, Font = "MonospaceTypewriterBold", ShadowOffset = {0, 2}, ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 4}, OutlineThickness = 2, OutlineColor = {0.0, 0.0, 0.0,1} })
	end

end

function StripInteractTextRequirements( eventSource, args )

	for enemyId, enemy in pairs( ActiveEnemies ) do
		if enemy.InteractTextLineSets ~= nil then
			for lineSetName, lineSet in pairs( enemy.InteractTextLineSets ) do
				lineSet.UseableOffSource = false
				StripRequirements( lineSet )
			end
		end
	end

end

function StripRequirements( source )

	if not GetConfigOptionValue({ Name = "AllowStripRequirements" }) then
		return
	end

	--@refactor Make more universal
	source.RequiredTextLinesThisRun = nil
	source.RequiredFalseTextLinesThisRun = nil
	source.RequiredMinCompletedRuns = nil
	source.RequiredMinDepth = nil
	source.RequiredRoom = nil
	source.RequiredRooms = nil
	source.RequiredTextLines = nil
end

function AddResources( eventSource, args )
	for name, amount in pairs( args ) do
		AddResource( name, amount, "AddResources" )
	end
end

function HandleCoverSpawns( eventSource )
	local encounter = eventSource.Encounter or eventSource
	local coverData = encounter.CoverData
	if coverData == nil then
		return
	end

	coverData.SpawnIds = GetIds({ Name = coverData.SpawnPointGroupName })

	if coverData.StartDelay ~= nil then
		wait(coverData.StartDelay, RoomThreadName)
	end

	for i=1, coverData.StartingCount do
		local destinationId = RemoveRandomValue(coverData.SpawnIds)
		if IsEmpty(coverData.SpawnIds) then
			coverData.SpawnIds = GetIds({ Name = coverData.SpawnPointGroupName })
		end
		SpawnMovingObstacle(coverData.ObstacleName, destinationId, coverData)
	end

	thread(HandleObstacleSpawns, encounter, encounter.CoverData)
end

function HandleObstacleSpawns( encounter, spawnData )
	if spawnData == nil then
		return
	end

	local spawnRate = spawnData.SpawnRate or 0.3
	while not encounter.Completed do
		wait(spawnRate, RoomThreadName)

		if encounter.Completed then
			break
		end

		local spawnsPerBurst = spawnData.SpawnsPerBurst
		if spawnData.SpawnsPerBurstMin ~= nil and spawnData.SpawnsPerBurstMax ~= nil then
			spawnsPerBurst = RandomInt(spawnData.SpawnsPerBurstMin, spawnData.SpawnsPerBurstMax)
		end
		for i=1, spawnsPerBurst do
			local destinationId = RemoveRandomValue(spawnData.SpawnIds)
			if IsEmpty(spawnData.SpawnIds) then
				spawnData.SpawnIds = GetIds({ Name = spawnData.SpawnPointGroupName or "SpawnPoints" })
			end
			SpawnMovingObstacle(spawnData.ObstacleName, destinationId, spawnData)
		end
	end
end

function HandleShadeWeaponSpawns( currentRoom, currentEncounter )
	local spawnData = currentRoom.ShadeWeaponSpawnData
	if spawnData == nil then
		DebugPrint({ Text = "No Weapon Spawn Data in"..currentRoom.Name.."'s RoomData" })
		return
	end

	currentEncounter = currentEncounter or currentRoom.Encounter
	currentRoom.WeaponSpawnPointIds = GetIds({ Name = spawnData.SpawnPointGroupName or "WeaponSpawnPoints" })
	currentRoom.WeaponSpawnPointsUsed = currentRoom.WeaponSpawnPointsUsed or {}
	if IsEmpty(currentRoom.WeaponSpawnPointIds) or currentEncounter == nil then
		return
	end

	if spawnData.StartDelay ~= nil then
		wait( spawnData.StartDelay, RoomThreadName )
	end

	local spawnRate = spawnData.SpawnRate or 0.3
	if spawnData.SpawnRateMin ~= nil and spawnData.SpawnRateMax ~= nil then
		spawnRate = RandomFloat(spawnData.SpawnRateMin, spawnData.SpawnRateMax)
	end
	if currentEncounter == nil then
		return
	end

	local startingSpawnCount = spawnData.StartingSpawnCount or 0
	if spawnData.StartingSpawnCountMin ~= nil and spawnData.StartingSpawnCountMax ~= nil then
		startingSpawnCount = RandomInt(spawnData.StartingSpawnCountMin, spawnData.StartingSpawnCountMax)
	end
	for i=1, startingSpawnCount do
		local weaponId = SpawnEnemyWeapon(currentRoom, spawnData, true)
		if weaponId == nil then
			break
		end
	end

	while not currentEncounter.Completed do
		if currentEncounter.PauseWeaponSpawns or TableLength(GetIds({ Name = spawnData.SpawnGroup })) > spawnData.MaxSpawns then
			wait(0.5)
		else
			wait( spawnRate, RoomThreadName )
			if currentRoom.Encounter == nil or currentRoom.Encounter.Completed then
				break
			elseif not currentEncounter.PauseWeaponSpawns then
				local spawnsPerBurst = spawnData.SpawnsPerBurst or 1
				if spawnData.SpawnsPerBurstMin ~= nil and spawnData.SpawnsPerBurstMax ~= nil then
					spawnsPerBurst = RandomInt(spawnData.SpawnsPerBurstMin, spawnData.SpawnsPerBurstMax)
				end
				for i=1, spawnsPerBurst do
					SpawnEnemyWeapon(currentRoom, spawnData)
				end
			end
		end
	end
end

function SpawnEnemyWeapon(currentRoom, spawnData, useRandomSpawn)
	local spawnPointOptions = {}
	local spawnPointIds = currentRoom.WeaponSpawnPointIds or GetIds({ Name = "WeaponSpawnPoints" })
	for k, id in pairs(spawnPointIds) do
		if currentRoom.WeaponSpawnPointsUsed[id] == nil then
			table.insert(spawnPointOptions, id)
		end
	end
	local destinationId = nil
	if useRandomSpawn then
		destinationId = GetRandomValue( spawnPointOptions )
	else
		destinationId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = spawnPointOptions })
	end

	if destinationId == nil then
		DebugPrint({ Text = "No weapon spawn points remaining" })
		return nil
	end

	local spawnName = GetRandomValue(spawnData.SpawnOptions)

	local newWeaponId = SpawnMovingObstacle( spawnName, destinationId, spawnData)
	--local newWeaponId = SpawnObstacle({ Name = spawnName, Group = "Standing", DestinationId = destinationId })

	AddToGroup({ Id = newWeaponId, Name = spawnData.SpawnGroup })
	currentRoom.WeaponSpawnPointsUsed[destinationId] = true
	return newWeaponId
end

function HandleHazardSpawns( currentRoom, currentEncounter )
	local spawnData = currentRoom.HazardData
	if spawnData == nil then
		return
	end
	spawnData.SpawnIds = GetIds({ Name = spawnData.SpawnPointGroupName or "Hazards" })
	if IsEmpty(spawnData.SpawnIds) then
		return
	end

	if spawnData.StartDelay ~= nil then
		wait( spawnData.StartDelay, RoomThreadName )
	end

	spawnData.TimesSpawned = 0
	local spawnRate = spawnData.SpawnRate or 0.3
	local spawnStagger = spawnData.SpawnStagger or 0.1
	currentEncounter = currentEncounter or currentRoom.Encounter
	while currentEncounter ~= nil and not currentEncounter.Completed do
		if currentEncounter.PauseHazards then
			wait(0.5, RoomThreadName)
		else
			spawnRate = spawnData.SpawnRate or 0.3
			if spawnData.SkipInitialDelay and spawnData.TimesSpawned == 0 then
				spawnRate = 0.1
			end
			wait( spawnRate, RoomThreadName )

			if currentRoom.Encounter == nil or currentRoom.Encounter.Completed then
				break
			elseif not currentEncounter.PauseHazards then
				local spawnsPerBurst = spawnData.SpawnsPerBurst
				if spawnData.SpawnsPerBurstMin ~= nil and spawnData.SpawnsPerBurstMax ~= nil then
					spawnsPerBurst = RandomInt(spawnData.SpawnsPerBurstMin, spawnData.SpawnsPerBurstMax)
				end
				spawnData.SpawnIds = GetIds({ Name = spawnData.SpawnPointGroupName or "Hazards" })
				for i=1, spawnsPerBurst do
					if not currentEncounter.InProgress then
						return
					end
					local destinationId = RemoveRandomValue(spawnData.SpawnIds)
					if IsEmpty(spawnData.SpawnIds) then
						spawnData.SpawnIds = GetIds({ Name = spawnData.SpawnPointGroupName or "Hazards" })
					end

					local newHazard = DeepCopyTable( EnemyData[spawnData.ObstacleName] )
					newHazard.ObjectId = SpawnUnit({ Name = spawnData.ObstacleName, Group = "Standing", DestinationId = destinationId })
					SetupEnemyObject( newHazard, CurrentRun )
					wait(spawnStagger, RoomThreadName)
				end
				spawnData.TimesSpawned = spawnData.TimesSpawned + 1
			end
		end
	end
end

function SpawnMovingObstacle( obstacleName, destinationId, spawnData )
	local spawnGroup = spawnData.SpawnGroupName or "Standing"
	local obstacleId = SpawnObstacle({ Name = obstacleName, DestinationId = destinationId, Group = spawnGroup })

	local spawnScale = spawnData.SpawnScale
	if spawnData.SpawnScaleMin ~= nil and spawnData.SpawnScaleMax ~= nil then
		spawnScale = RandomFloat(spawnData.SpawnScaleMin, spawnData.SpawnScaleMax)
	end
	if spawnScale ~= nil then
		SetScale({ Id = obstacleId, Fraction = spawnScale })
	end
	if spawnData.SpawnOffsetZ ~= nil then
		AdjustZLocation({ Id = obstacleId, Distance = spawnData.SpawnOffsetZ })
	end
	if spawnData.FallForce ~= nil then
		ApplyUpwardForce({ Id = obstacleId, Speed = -spawnData.FallForce })
	end
	if spawnData.LerpMovement then
		local offset = CalcOffset(math.rad(-145), 3000)
		SetObstacleProperty({ DestinationId = obstacleId, Property = "CollidesWithObstacles", Value = false })
		Move({ Id = obstacleId, DestinationId = obstacleId, OffsetX = offset.X, OffsetY = offset.Y, Duration = 10.0 })
	elseif spawnData.MoveSpeed ~= nil then
		ApplyForce({ Id = obstacleId, Speed = spawnData.MoveSpeed, Angle = spawnData.MoveAngle })
	end
	if spawnData.AllowFlip and CoinFlip() then
		FlipHorizontal({ Id = obstacleId })
	end

	return obstacleId
end

function SetAnimationState( source, args )
	SetAnimation({ DestinationId = source.ObjectId, Name = args.Animation })
	CurrentRun.AnimationState[source.ObjectId] = args.Animation
end

function RelockAllDoors( source, args )
	for id, door in pairs( OfferedExitDoors ) do
		if id ~= args.DoorId then
			DestroyDoorRewardPresenation( door )
			SetAnimation({ DestinationId = id, Name = GetThingDataValue({ Id = id, Property = "Graphic" }) })
			door.UseText = door.LockedUseText
			door.ReadyToUse = false
		end
	end
	OfferedExitDoors = {}
end

function UnlockDoor( source, args )

	if args.RelockAllDoors then
		RelockAllDoors( source, args )
	end

	local door = MapState.ActiveObstacles[args.DoorId]
	local roomForDoorData = nil
	if door.ForceRoomName ~= nil then
		roomForDoorData = RoomData[door.ForceRoomName]
	else
		roomForDoorData = ChooseNextRoomData( CurrentRun )
	end
	local roomForDoor = CreateRoom( roomForDoorData )
	AssignRoomToExitDoor( door, roomForDoor )
	CreateDoorRewardPreview( door )
	thread( ExitDoorUnlockedPresentation, door )
	door.ReadyToUse = true
end

function SetupShrinePointClearObject( usee, args )

	if GameState.ShrinePointClearsComplete[usee.ObjectId] then
		-- Already completed
		SetAnimation({ DestinationId = usee.ObjectId, Name = usee.CompleteAnimation })
		SetHSV({ Id = usee.ObjectId, HSV = { 0, 0, 0 }, ValueChangeType = "Multiply" })
		if usee.FlipHorizontalOnComplete then
			FlipHorizontal({ Id = usee.ObjectId })
		end
		if AreAllShrinePointClearsComplete() then
			usee.UseText = usee.AllCompleteUseText
			return
		end
		UseableOff({ Id = usee.ObjectId })
		return
	end

	if GameState.ShrinePointClearObjectId == usee.ObjectId then
		UpdateShrinePointClearText( usee, args )
		CreateAnimation({ Name = usee.AttractAnimation, DestinationId = usee.ObjectId, OffsetY = -100 })
		local recordShrinePoints = GetHighestShrinePointRunClear( CurrentRun )
		if recordShrinePoints >= usee.GoalShrinePointClear then
			usee.UseText = usee.CompleteUseText
			return
		end
		usee.UseText = usee.InProgressUseText
	elseif usee.PrevGoalId ~= nil and not GameState.ShrinePointClearsComplete[usee.PrevGoalId] then
		-- Not available until prev goal has been completed
		UseableOff({ Id = usee.ObjectId })
	else
		CreateAnimation({ Name = usee.AttractAnimation, DestinationId = usee.ObjectId, OffsetY = -100 })
	end
end

function UseShrinePointClearObject( usee, args )

	local source = ActiveEnemies[ GetClosestUnitOfType({ Id = usee.ObjectId, DestinationName = usee.SourceName, Distance = 9999 }) ]
	if source == nil then
		return
	end
	UseableOff({ Id = usee.ObjectId })

	if AreAllShrinePointClearsComplete() then
		StatueAdmirePresentation( usee )
		UseableOn({ Id = usee.ObjectId })
		return
	end

	if GameState.ShrinePointClearObjectId == nil then
		-- Set as active goal
		if usee.OnTrophyRevealedTextLineSets ~= nil then
			PlayFirstEligibleTextLines( usee, usee.OnTrophyRevealedTextLineSets )
		end
		ShrinePointClearAvailablePresentation( usee, source )
		GameState.ShrinePointClearObjectId = usee.ObjectId
		local recordShrinePoints = GetHighestShrinePointRunClear( CurrentRun, { IgnoreSameMode = true } )
		if recordShrinePoints >= usee.GoalShrinePointClear then
			usee.UseText = usee.CompleteUseText
		else
			usee.UseText = usee.InProgressUseText
		end
		RefreshUseButton( usee.ObjectId, usee )
		UseableOn({ Id = usee.ObjectId })
		return
	end

	if GameState.ShrinePointClearObjectId == usee.ObjectId then
		local recordShrinePoints = GetHighestShrinePointRunClear( CurrentRun, { IgnoreSameMode = true } )
		DebugPrint({ Text = "recordShrinePoints = "..recordShrinePoints })
		if recordShrinePoints >= usee.GoalShrinePointClear then
			-- Cash in
			ShrinePointClearCompletePresentation( usee, source )
			UseableOff({ Id = usee.ObjectId })
			GameState.ShrinePointClearsComplete[usee.ObjectId] = true
			GameState.ShrinePointClearObjectId = nil

			if usee.NextGoalId ~= nil then
				UseableOn({ Id = usee.NextGoalId })
				CreateAnimation({ Name = usee.AttractAnimation, DestinationId = usee.NextGoalId, OffsetY = -100 })
			else
				if AreAllShrinePointClearsComplete() then
					for id, v in pairs( GameState.ShrinePointClearsComplete ) do
						local shrinePointClearObject = MapState.ActiveObstacles[id]
						shrinePointClearObject.UseText = shrinePointClearObject.AllCompleteUseText
						UseableOn({ Id = id })
					end
				end
			end
		else
			-- Condition not satisfied
			ShrinePointClearIncompletePresentation( usee, source )
			UseableOn({ Id = usee.ObjectId })
		end
	end
end

function AreAllShrinePointClearsComplete()
	if TableLength( GameState.ShrinePointClearsComplete ) >= 3 then
		return true
	end
	return false
end

function RegenerateElysiumPillar(pillar, currentRun)

	wait(pillar.RegenerateStartDelay, RoomThreadName)

	if pillar.RegenerateStartAnimation ~= nil then
		CreateAnimation({ DestinationId = pillar.ObjectId, Name = pillar.RegenerateStartAnimation, OffsetZ = 200 })
	end

	wait(pillar.RegenerateDuration, RoomThreadName)

	if pillar.RegenerateAnimation ~= nil then
		SetAnimation({ DestinationId = pillar.ObjectId, Name = pillar.RegenerateAnimation })
		local notifyName = "RegenWaitForAnimation"..pillar.ObjectId
		NotifyOnAnimationTimeRemaining({ Id = pillar.ObjectId, Animation = pillar.RegenerateAnimation, Remaining = 0, Notify = notifyName })
		waitUntil( notifyName )
	end

	local newData = ObstacleData[pillar.RegenerateAs]
	local newObject = DeepCopyTable( newData )
	newObject.ObjectId = pillar.ObjectId
	AttachLua({ Id = pillar.ObjectId, Table = newObject })
	if pillar.RegenPropertyChanges ~= nil then
		ApplyUnitPropertyChanges( newObject, pillar.RegenPropertyChanges, true )
	end
	if newObject.SpawnPropertyChanges ~= nil then
		ApplyUnitPropertyChanges( newObject, newObject.SpawnPropertyChanges, true )
	end
	RecordObjectState( CurrentRun.CurrentRoom, pillar.ObjectId, "SwapData", pillar.RegenerateAs )

	--local newPillar = SpawnObstacle({ Name = pillar.RegenerateAs, DestinationId = pillar.ObjectId, Group = "Standing" })
	--DebugPrint({ Text = GetThingDataValue({ Id = pillar.ObjectId, Property = "Scale" }) })
	--SetScale({ Id = newPillar, Fraction = GetThingDataValue({ Id = pillar.ObjectId, Property = "Scale" }) })
	--Destroy({ Id = pillar.ObjectId })
end

function TrackThanatosChallengeProgress( encounter, victim, killer )
	if victim.IgnoreThanatosChallengeTracker then
		return
	end

	local maxTimeSincePlayerDamage = encounter.MaxTimeSincePlayerDamage or 5
	if killer ~= nil and killer.ObjectId == encounter.ThanatosId then
		encounter.ThanatosKills = encounter.ThanatosKills + 1
		UpdateObjectiveDescription( "ThanatosKills", "Objective_ThanatosKills", "ThanatosKills", encounter.ThanatosKills )
	elseif killer ~= nil and killer == CurrentRun.Hero then
		encounter.PlayerKills = encounter.PlayerKills + 1
		UpdateObjectiveDescription( "PlayerKills", "Objective_PlayerKills", "PlayerKills", encounter.PlayerKills )
	elseif victim ~= nil and victim.TimeOfLastPlayerDamage ~= nil and _worldTime - victim.TimeOfLastPlayerDamage < maxTimeSincePlayerDamage then
		encounter.PlayerKills = encounter.PlayerKills + 1
		UpdateObjectiveDescription( "PlayerKills", "Objective_PlayerKills", "PlayerKills", encounter.PlayerKills )
	end
end

function HandleTrapChains( eventSource )
	local roomTrapChainData = CurrentRun.CurrentRoom.PassiveTrapChains
	if roomTrapChainData == nil then
		return
	end
	for k, trapChainData in ipairs(roomTrapChainData) do
		thread( HandleTrapChain, trapChainData, eventSource )
	end
end

function HandleTrapChain( trapChainData, encounter )
	wait( trapChainData.StartDelay, RoomThreadName )
	while encounter.InProgress do
		for k, chain in ipairs(trapChainData.Chains) do
			for k, trapId in ipairs(chain) do
				local chainedEnemy = ActiveEnemies[trapId]
				notifyExistingWaiters("WithinDistance"..trapId)

				local chainedWeaponAIData = ShallowCopyTable(chainedEnemy.DefaultAIData) or chainedEnemy
				if WeaponData[chainedEnemy.WeaponName] ~= nil and WeaponData[chainedEnemy.WeaponName].AIData ~= nil then
					OverwriteTableKeys( chainedWeaponAIData, WeaponData[chainedEnemy.WeaponName].AIData)
				end
				chainedWeaponAIData.WeaponName = chainedEnemy.WeaponName

				if not chainedEnemy.AIDisabled then
					thread(AttackOnce, chainedEnemy, CurrentRun, nil, chainedWeaponAIData )
				end
			end
			wait( trapChainData.ChainInterval, RoomThreadName )
		end
		wait( trapChainData.ChainCooldown, RoomThreadName )
	end
end

function SpawnConsumables( eventSource, args )
	for k, spawnData in pairs( args.Spawns ) do
		DebugPrint({ Text= spawnData.ConsumableName })
		local consumableId = SpawnObstacle({ Name = spawnData.ConsumableName, DestinationId = spawnData.DestinationId, Group = "Standing", })
		local consumable = CreateConsumableItem( consumableId, spawnData.ConsumableName, 0 )
		ActivatedObjects[consumableId] = consumable
	end
end

function AllAIStop( usee, args )
	for id, enemy in pairs( ActiveEnemies ) do
		killTaggedThreads( enemy.AIThreadName )
		killWaitUntilThreads( enemy.AINotifyName )
		Stop({ Id = enemy.ObjectId })
		StopAnimation({ DestinationId = enemy.ObjectId })
	end
end

function AllAIFollow( usee, args )
	AllAIStop( usee, args )
	for id, enemy in pairs( ActiveEnemies ) do
		thread( SetAI, FollowAI, enemy, CurrentRun )
	end
end

function ActivateHydra(eventSource, args)
	args.LegalTypes = { eventSource.HydraVariant }

	eventSource.BossId = GetFirstValue(GetInactiveIdsByType({ Name = eventSource.HydraVariant }))
	ActivatePrePlaced(eventSource, args)
end