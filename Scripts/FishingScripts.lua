function StartFishing( fishingPointId )
	InvalidateCheckpoint()
	FreezePlayerUnit( "Fishing", { DisableTray = true, DisableCodex = true } )
	CurrentRun.Hero.FishingInput = false
	CurrentRun.Hero.FishingState = "TooEarly"
	local fishingFailed = false
	local fishingAnimationPointId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = fishingPointId, Group = GetGroupName({ Id = fishingPointId, DrawGroup = true }) })
	
	FishingStartPresentation( fishingPointId, fishingAnimationPointId )
	-- zag fishing pose
	wait(1.5, "Fishing")
	thread( WaitForFishingInput, fishingAnimationPointId )
	
	local numfakedunks = RandomInt( FishingData.NumFakeDunks.Min, FishingData.NumFakeDunks.Max )
	for i = 1, numfakedunks do
		wait( RandomFloat( FishingData.FakeDunkInterval.Min, FishingData.FakeDunkInterval.Max ), "Fishing" )
		SetAnimation({ Name = "FishingBobberFakeDunkA", DestinationId = fishingAnimationPointId })
		thread( DoRumble, { { ScreenPreWait = 0.01, LeftFraction = 0.17, Duration = 0.17 }, } )
	end

	local warnTime = RandomFloat( FishingData.WarnInterval.Min, FishingData.WarnInterval.Max )
	wait( warnTime , "Fishing" )
	SetAnimation({ Name = "FishingBobberDunk", DestinationId = fishingAnimationPointId })
	thread( DoRumble, { { ScreenPreWait = 0.01, RightFraction = 0.4, Duration = 0.3 }, } )

	if not CurrentRun.Hero.FishingInput then
		CurrentRun.Hero.FishingState = "Perfect"
	end
	wait( FishingData.PerfectInterval, "Fishing" )

	if not CurrentRun.Hero.FishingInput then
		CurrentRun.Hero.FishingState = "Good"
	end
	wait( FishingData.GoodInterval, "Fishing" )

	if not CurrentRun.Hero.FishingInput then
		CurrentRun.Hero.FishingState = "TooLate"
	end

	SetAnimation({ Name = "FishingBobberResurface", DestinationId = fishingAnimationPointId })

	wait( FishingData.WayLateInterval, "Fishing" )
	if not CurrentRun.Hero.FishingInput then
		CurrentRun.Hero.FishingState = "WayLate"
		thread( CheckForFishNotCaughtWayTooLateVoiceLines )
	end
	wait( FishingData.GiveUpInterval, "Fishing" )
	notify("FishingInput")
end

function WaitForFishingInput( fishingAnimationPointId )

	ToggleControl({ Names = { "Use" }, Enabled = true })
	thread( DoRumble, { { RightTriggerStart = 0, RightTriggerFrequencyFraction = 0.7 , RightTriggerStrengthFraction = 0.5 }, } )
	NotifyOnControlPressed({ Names = { "Use", }, Notify = "FishingInput" })
	waitUntil( "FishingInput" )
	FishingEndPresentation( fishingAnimationPointId )
	thread( DoRumble, { { RightTriggerStrengthFraction = 0.0}, } )
end

function GetFish( biome, fishingState )
	local fishName = nil
	local biomeData = FishingData.BiomeFish.Defaults
	if FishingData.BiomeFish[biome] then
		biomeData = FishingData.BiomeFish[biome]
	end

	if biomeData[fishingState] then
		local fishingTable = {}
		for _, fishData in ipairs(biomeData[fishingState]) do
			fishingTable[fishData.Name] = fishingTable.Weight or 1
		end

		fishName = GetRandomValueFromWeightedList( fishingTable )
	end

	return fishName
end

function RecordFish( fishName )
	GameState.TotalCaughtFish = GameState.TotalCaughtFish or {}
	IncrementTableValue( GameState.TotalCaughtFish, fishName )

	GameState.CaughtFish = GameState.CaughtFish or {}
	IncrementTableValue( GameState.CaughtFish, fishName )

	CurrentRun.CaughtFish = CurrentRun.CaughtFish or {}
	IncrementTableValue( CurrentRun.CaughtFish, fishName )
end

function GetNumHeldFish()
	if IsEmpty( GameState.CaughtFish ) then
		return 0
	end
	local totalFish = 0
	for fishName, numFish in pairs( GameState.CaughtFish ) do
		totalFish = totalFish + numFish
	end
	return totalFish
end

function GetNumLifetimeFish()
	if IsEmpty( GameState.TotalCaughtFish ) then
		return 0
	end
	local totalFish = 0
	for fishName, numFish in pairs( GameState.TotalCaughtFish ) do
		totalFish = totalFish + numFish
	end
	return totalFish
end

function GetNumFishCaught( run )
	if IsEmpty( run.CaughtFish ) then
		return 0
	end
	local totalFish = 0
	for fishName, numFish in pairs( run.CaughtFish ) do
		totalFish = totalFish + numFish
	end
	return totalFish
end

function CancelFishing()
	CurrentRun.Hero.FishingStarted = false
	RemoveTimerBlock( CurrentRun, "Fishing" )
	UnblockCombatUI( "Fishing" )
	notifyExistingWaiters("FishingInput")
	if HasThread("FishingStartDelay") then
		killTaggedThreads( "FishingStartDelay")		
		UnfreezePlayerUnit("FishingStartUp")
	end
end

function TurnInFish( usee, args )
	UseableOff({ Id = usee.ObjectId })
	if not GameState.CaughtFish then
		return
	end

	FreezePlayerUnit( "Fishing" )
	thread( MarkObjectiveComplete, "FishPrompt" )

	PlayInteractAnimation( usee.ObjectId )

	StopStatusAnimation( usee )

	thread( PlayVoiceLines, HeroVoiceLines.FishTransactionStartVoiceLines, true )
	SetAnimation({ DestinationId = usee.ObjectId, Name = "ChefGhostChopOnion2_Start" })

	local earnedResources = {}
	local offsetY = 0
	for fishName, fishNum in pairs( GameState.CaughtFish ) do
		if fishNum > 1 then
			thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "Fishing_TurnIn_Plural", SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = fishName, Amount = fishNum }})
		else
			thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "Fishing_TurnIn", SkipRise = false, SkipFlash = false, Duration = 1.5, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = fishName, Amount = fishNum }})
		end
		offsetY = offsetY - 60
		PlaySound({ Name = "/Leftovers/SFX/BallLandWet" })
		wait(0.75)
		for i = 1, fishNum do
			local fishData = FishingData.FishValues[fishName]
			if fishData and fishData.Award then
				local reward = GetRandomValue( fishData.Award )
				for resourceName, resourceAmount in pairs( reward ) do
					IncrementTableValue( earnedResources, resourceName, resourceAmount )
				end
			end
		end
	end
	wait(0.75)
	for resourceName, resourceAmount in pairs( earnedResources ) do
		AddResource( resourceName, resourceAmount, "Fishing" )
		PlaySound({ Name = "/SFX/Menu Sounds/SellTraitShopConfirm" })
		wait(0.75)
	end

	thread( PlayVoiceLines, HeroVoiceLines.FishTransactionEndVoiceLines, true )

	GameState.CaughtFish = {}
	UnfreezePlayerUnit("Fishing")
end