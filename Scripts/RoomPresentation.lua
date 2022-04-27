function StartRoomPresentation( currentRun, currentRoom, metaPointsAwarded )
	ShowingCombatUI = nil
	ZeroMouseTether( "StartRoomPresentation" )
	local prevRoom = GetPreviousRoom( currentRun )

	SetConfigOption({ Name = "FullscreenEffectGroup", Value = currentRoom.FullscreenEffectGroup or "Vignette" })

	GatherRoomPresentationObjects( currentRun, currentRoom )

	if currentRoom.CameraZoomWeights ~= nil then
		for id, weight in pairs( currentRoom.CameraZoomWeights ) do
			SetCameraZoomWeight({ Id = id, Weight = weight, ZoomSpeed = 1.0 })
		end
	end
	if currentRoom.ZoomFraction then
		AdjustZoom({ Fraction = currentRoom.ZoomFraction })
	else
		AdjustZoom({ Fraction = 1.0 })
	end

	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or 0.8
	if not currentRoom.IgnoreClamps then
		local cameraClamps = currentRoom.CameraClamps or GetDefaultClampIds()
		DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is non-sensical" })
		SetCameraClamp({ Ids = cameraClamps, SoftClamp = currentRoom.SoftClamp })
	end

	if currentRoom.CameraStartPoint ~= nil and currentRoom.CameraStartPoint > 0 then
		LockCamera({ Id = currentRoom.CameraStartPoint, Duration = 0 })
	else
		LockCamera({ Id = currentRun.Hero.ObjectId })
	end
	if currentRoom.HeroStartPoint ~= nil then
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroStartPoint })
	end

	StartRoomAmbience( currentRun, currentRoom )
	thread( StartRoomMusic, currentRun, currentRoom )

	if AsphodelBoatSoundId ~= nil and currentRoom.EntranceFunctionName ~= "AsphodelEnterRoomPresentation" and currentRoom.EntranceFunctionName ~= "RoomEntranceBossHydra" then -- @hack
		--DebugPrint({ Text = "Stopping AsphodelBoatSoundId for currentRoom.EntranceFunctionName = "..tostring(currentRoom.EntranceFunctionName) })
		StopSound({ Id = AsphodelBoatSoundId, Duration = 0.2 })
		AsphodelBoatSoundId = nil
	end

	local roomEntranceFunctionName = currentRoom.EntranceFunctionName or "RoomEntranceStandard"
	if prevRoom ~= nil and prevRoom.NextRoomEntranceFunctionName ~= nil then
		roomEntranceFunctionName = prevRoom.NextRoomEntranceFunctionName
	end
	local args = currentRoom.EntranceFunctionArgs
	local entranceFunction = _G[roomEntranceFunctionName]
	entranceFunction( currentRun, currentRoom, args )

	if metaPointsAwarded ~= nil and metaPointsAwarded > 0 then
		MetaPointRoomRewardPresentation(metaPointsAwarded)
	end

	TeleportCursor({ OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })

	if not currentRoom.BlockCameraReattach then
		thread( ReattachCameraOnInput, currentRun )
	else
		UnzeroMouseTether( "StartRoomPresentation" )
	end

end

function GetDefaultClampIds()
	local clampIds = GetIdsByType({ Name = "CameraClamp" })
	table.sort( clampIds )
	return clampIds
end

function RestoreUnlockRoomExitsPresentation( currentRun, currentRoom )
	ZeroMouseTether( "StartRoomPresentation" )

	GatherRoomPresentationObjects( currentRun, currentRoom )

	if currentRoom.CameraZoomWeights ~= nil then
		for id, weight in pairs( currentRoom.CameraZoomWeights ) do
			SetCameraZoomWeight({ Id = id, Weight = weight, ZoomSpeed = 1.0 })
		end
	end
	if currentRoom.ZoomFraction then
		AdjustZoom({ Fraction = currentRoom.ZoomFraction })
	else
		AdjustZoom({ Fraction = 1.0 })
	end

	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or 0.8
	local cameraClamps = currentRoom.CameraClamps or GetDefaultClampIds()
	DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is non-sensical" })
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = currentRoom.SoftClamp })

	LockCamera({ Id = currentRun.Hero.ObjectId })

	StartRoomAmbience( currentRun, currentRoom )

	TeleportCursor({ OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })

	UnzeroMouseTether( "StartRoomPresentation" )

	wait(0.2) -- Let camera transitions finish before fade in
	FadeIn({ Duration = 0.5 })

end

function RoomEntranceOpening( currentRun, currentRoom )
	HideCombatUI( "RoomEntranceOpening" )
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	WindowDropEntrance( currentRun, currentRoom )
end

function WindowDropEntrance( currentRun, currentRoom )

	ZeroMouseTether( "RoomEntranceOpening" )
	wait(0.03)

	FadeIn({ Duration = 1.0 })
	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0 })
	thread( InvalidatePerfectLanding )

	if( currentRun.Hero.AttachedLightId ~= nil ) then
		SetAlpha({ Id = currentRun.Hero.AttachedLightId, Fraction = 0 })
	end
	FullScreenFadeInAnimation()
	if currentRoom.HeroEndPoint ~= nil then
		thread( DropHeroToRoomPosition, currentRun.Hero.ObjectId, currentRun.Hero.AttachedLightId, currentRoom.HeroEndPoint, true, 1, 1.8, 50 )
	end
	AdjustZoom({ Fraction = 0.5, LerpTime = 0.02 })
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 0.0, OffsetX = 0 })
	wait(0.02)
	AdjustZoom({ Fraction = currentRun.CurrentRoom.ZoomFraction or 0.75, LerpTime = 8.0 })
	wait(1.2)
	thread( PlayVoiceLines, currentRoom.EnterVoiceLines )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )
	thread( RoomOpeningUIDelay )
	wait(1.28)
	--thread( CheckPerfectLanding )
	wait(1.22)
	UnzeroMouseTether( "RoomEntranceOpening" )
end

function RoomOpeningUIDelay()
	wait( 2.42 )
	ShowCombatUI( "RoomEntranceOpening" )
end

function InvalidatePerfectLanding( )
	local notifyName = "PerfectLandingInvalid"
	NotifyOnControlPressed({ Names = { "Rush", "Attack1", "Attack2", "Attack3" }, Notify = notifyName, Timeout = 2.5 })
	waitUntil( notifyName )
	if _eventTimeoutRecord[notifyName] then
		--DebugPrint({ Text = "Perfect Landing Can Be Valid" })
	else
		--DebugPrint({ Text = "Perfect Landing Invalid" })
		perfectLandingInvalid = true
	end
end

function CheckPerfectLanding()
	--DebugPrint({ Text = "Perfect Landing Window" })
	local notifyName = "PerfectLandingInput"

	if perfectLandingInvalid then
		return
	end

	NotifyOnControlPressed({ Names = { "Rush", "Attack1", "Attack2", "Attack3" }, Notify = notifyName, Timeout = 0.14 })
	waitUntil( notifyName )
	if _eventTimeoutRecord[notifyName] then
		--DebugPrint({ Text = "Perfect Landing Window Closed" })
	else
		thread( PerfectLandingFeedback )
	end

	perfectLandingInvalid = nil
end

function PerfectLandingFeedback()
	--DebugPrint({ Text = "Perfect Landing Hit" })
	SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "TouchdownGraphic", Value = "ZagreusLanding", ValueChangeType = "ABSOLUTE" })
	thread( SendCritters, { MinCount = 10, MaxCount = 20, StartX = 0, StartY = 500, MinAngle = 115, MaxAngle = 75, MinSpeed = 1200, MaxSpeed = 2200, MinInterval = 0.02, MaxInterval = 0.04, } )
	thread( InCombatText, CurrentRun.Hero.ObjectId, "PerfectLanding", 1 )
	wait(5.0)
	SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "TouchdownGraphic", Value = "ZagreusDash", ValueChangeType = "ABSOLUTE" })
end


function DropHeroToRoomPosition( heroId, lightId, heroDestination, disableCollision, dropDelay, landDelay, speedAdjustment )
	AddInputBlock({ Name = "MoveHeroToRoomPosition" })
	AddTimerBlock( CurrentRun, "MoveHeroToRoomPosition" )
	wait( dropDelay )
	SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "SuppressSounds", Value = true, DataValue = false })
	if disableCollision then
		SetUnitProperty({ DestinationId = heroId, Property = "CollideWithObstacles", Value = false })
	end
	if speedAdjustment then
		SetUnitProperty({ DestinationId = heroId, Property = "Speed", Value = speedAdjustment })
	end
	SetAlpha({ Id = heroId, Fraction = 1.0 })
	if( lightId ~= nil ) then
		SetAlpha({ Id = lightId, Fraction = 1.0 })
	end
	SetAnimation({ Name = "ZagreusHeroLanding_Air", DestinationId = heroId })
	SetThingProperty({ DestinationId = heroId, Property = "TouchdownGraphic", Value = "ZagreusHeroLanding_ReturnToIdle" })
	AdjustZLocation({ Id = heroId, Distance = 1500, Duration = 0 })
	wait(0.02)
	AdjustZLocation({ Id = heroId, Distance = 1500, Duration = 1.0 })
	Move({ Id = heroId, DestinationId = heroDestination, Mode = "Precise" })
	PlaySound({ Name = "/SFX/Player Sounds/ZagreusWhooshDropIn", Id = heroId, Delay = 0.5 })
	thread( DustLanding, 1.62 )
	wait( landDelay )
	Stop({ Id = heroId })
	AngleTowardTarget({ Id = heroId, DestinationId = 553377 })
	SetThingProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "SuppressSounds", Value = false, DataValue = false })
	if disableCollision then
		SetUnitProperty({ DestinationId = heroId, Property = "CollideWithObstacles", Value = true })
	end
	if speedAdjustment then
		SetUnitProperty({ DestinationId = heroId, Property = "Speed", Value = 540 })
	end
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.2, Duration = 0.15 }, } )
	RemoveInputBlock({ Name = "MoveHeroToRoomPosition" })
	RemoveTimerBlock( CurrentRun, "MoveHeroToRoomPosition" )
end

function AsphodelEnterRoomPresentation(currentRun, currentRoom, endLookAtId, skipCameraLockOnEnd)
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.8

	AddInputBlock({ Name = "EnterRoomPresentation" })
	SetPlayerInvulnerable( "EnterRoomPresentation" )
	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()

	if currentRoom.HeroStartPoint ~= nil then
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroStartPoint })
	end

	local heroStartPointId = currentRoom.HeroStartPoint or GetClosest({ Id = currentRun.Hero.ObjectId, DestinationIds = GetIdsByType({ Name = "HeroStart" }) })
	local boatId = GetClosest({ Id = heroStartPointId, DestinationIds = GetIdsByType({ Name = "AsphodelBoat01" }) })
	local boatMovePoint = GetClosest({ Id = boatId, DestinationIds = GetIdsByType({ Name = "BoatMovePoint" }) })
	local boatMovePointExit = SpawnObstacle({ Name = "BlankObstacle", DestinationId = boatId, Group = "Scripting" })
	LockCamera({ Id = boatId, Duration = 1.0 })

	for k, unusedBoatId in pairs(GetIdsByType({ Name = "AsphodelBoat01" })) do
		if boatId ~= unusedBoatId then
			Destroy({ Id = unusedBoatId })
		end
	end

	local offset = CalcOffset( math.rad(GetAngleBetween({ Id = boatId, DestinationId = heroStartPointId })), GetDistance({ Id = boatId, DestinationId = heroStartPointId }) )
	Attach({ Id = currentRun.Hero.ObjectId, DestinationId = boatId, OffsetX = offset.X, OffsetY = offset.Y })
	AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = boatMovePoint })
	AdjustZLocation({ Id = boatId, Distance = 10, Duration = 0.0 })
	Move({ Id = boatId, DestinationId = boatMovePoint, Duration = 1.0, EaseOut = 1.0 })
	Shake({ Id = raftMovePoint, Distance = 2, Speed = 100, Duration = 0.3 })
	wait(0.9)

	AdjustZLocation({ Id = boatId, Distance = -10, Duration = 0.5 })
	SetAnimation({ DestinationId = boatId, Name = "AsphodelBoatSink" })

	wait(0.35)

	StopSound({ Id = AsphodelBoatSoundId, Duration = 0.2 })
	AsphodelBoatSoundId = nil
	PlaySound({ Name = "/Leftovers/World Sounds/CaravanWaterBuck2", Id = raftMovePoint })
	local rumbleParams = { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.3 }, }
	thread( DoRumble, rumbleParams )

	wait(0.15)
	AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
	wait(0.03)

	if currentRoom.CameraEndPoint ~= nil then
		PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomIntroSequenceDuration, EaseIn = 0.0, EaseOut = 0.0 })
	end
	if currentRoom.HeroEndPoint ~= nil then
		CreateGroup({ Name = "Standing_Front" })
		InsertGroupInFront({ Name = "Standing_Front", DestinationName = "Standing" })
		AddToGroup({ Id = currentRun.Hero.ObjectId, Name = "Standing_Front", DrawGroup = true })
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true, AngleTowardsIdOnEnd = endLookAtId } )
	end
	wait(0.03)

	RemoveFromGroup({ Id = currentRun.Hero.ObjectId, Name = "Standing_Front" })
	AddToGroup({ Id = currentRun.Hero.ObjectId, Name = "Standing", DrawGroup = true })
	Unattach({ Id = currentRun.Hero.ObjectId, DestinationId = boatId })
	thread( PlayVoiceLines, currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )
	wait( roomIntroSequenceDuration - 0.03 )

	if not skipCameraLockOnEnd then
		LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 0.5 })
	end

	RemoveInputBlock({ Name = "EnterRoomPresentation" })
	SetPlayerVulnerable( "EnterRoomPresentation" )
end

function AsphodelLeaveRoomPresentation( currentRun, exitDoor )

	local exitDoorId = exitDoor.ObjectId
	AddInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })
	SetPlayerInvulnerable( "LeaveRoomPresentation" )
	HideCombatUI()

	local door = OfferedExitDoors[exitDoorId]
	local boatId = exitDoorId

	if door ~= nil then
		if door.AdditionalIcons ~= nil and not IsEmpty( door.AdditionalIcons ) then
			Destroy({ Ids = door.AdditionalIcons })
			door.AdditionalIcons = nil
		end
		DestroyDoorRewardPresenation( door )
		if door.ExitDoorOpenAnimation ~= nil then
			SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorOpenAnimation })
			thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
			wait( 0.5 )
		end
	end

	if currentRun.CurrentRoom.ExitVoiceLines ~= nil then
		thread( PlayVoiceLines, currentRun.CurrentRoom.ExitVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.ExitedAsphodelRoomVoiceLines, true )
	end

	local heroExitPointId = GetClosest({ Id = exitDoorId, DestinationIds = GetIdsByType({ Name = "HeroExit" }), Distance = 600 })

	local boatMovePoint = GetClosest({ Id = boatId, DestinationIds = GetIdsByType({ Name = "BoatMovePoint" }), Distance = 500 })
	if heroExitPointId > 0 then
		local angleToExit = GetAngleBetween({ Id = exitDoorId, DestinationId = boatMovePoint })
		if angleToExit < 90 or angleToExit > 270 then
			currentRun.CurrentRoom.ExitDirection = "Right"
		else
			currentRun.CurrentRoom.ExitDirection = "Left"
		end

		PanCamera({ Id = heroExitPointId, Duration = 10.0 })
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })

		CreateGroup({ Name = "Standing_Front" })
		InsertGroupInFront({ Name = "Standing_Front", DestinationName = "Standing" })
		AddToGroup({ Id = currentRun.Hero.ObjectId, Name = "Standing_Front", DrawGroup = true })

		thread( MoveHeroToRoomPosition, { DestinationId = heroExitPointId, DisableCollision =  false, UseDefaultSpeed = true } )
	end
	SetAnimation({ DestinationId = boatId, Name = "AsphodelBoatRise" })

	wait( 1.0 )

	AdjustZLocation({ Id = boatId, Distance = 10, Duration = 0.5 })

	--AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = boatMovePoint })
	Move({ Id = boatId, DestinationId = boatMovePoint, Duration = 2.0, EaseIn = 0.4 })
	Shake({ Id = boatMovePoint, Distance = 4, Speed = 100, Duration = 3 })
	PlaySound({ Name = "/SFX/AsphodelIslandTransitionStart", Id = currentRun.Hero.ObjectId })
	AsphodelBoatSoundId = PlaySound({ Name = "/SFX/AsphodelIslandTransitionLoop" })

	RemoveFromGroup({ Id = currentRun.Hero.ObjectId, Name = "Standing_Front" })
	AddToGroup({ Id = currentRun.Hero.ObjectId, Name = "Standing", DrawGroup = true })
	local offset = CalcOffset( math.rad(GetAngleBetween({ Id = boatId, DestinationId = currentRun.Hero.ObjectId })), GetDistance({ Id = boatId, DestinationId = currentRun.Hero.ObjectId }) )
	Attach({ Id = currentRun.Hero.ObjectId, DestinationId = boatId, OffsetX = offset.X, OffsetY = offset.Y })
	SetThingProperty({ Property = "SortMode", Value = "FromParent", DestinationId = currentRun.Hero.ObjectId })

	LeaveRoomAudio( currentRun, exitDoor )

	wait(0.2)

	if door ~= nil and door.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorCloseAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end

	wait(1.0)

	FullScreenFadeOutAnimation()
	ShowInterMapComponents()

	AllowShout = false

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })
	SetPlayerVulnerable( "LeaveRoomPresentation" )
end

function DustLanding( dustDelay )
	wait( dustDelay )
	CreateAnimation({ Name = "DustPuffALarge", DestinationId = CurrentRun.Hero.ObjectId })
end

function LeavingOfficePresentation( currentRun, currentRoom )
	SetAnimation({ DestinationId = 427199, Name = "HouseDoor01a_Open" })
	RoomEntranceStandard( currentRun, currentRoom )
	SetAnimation({ DestinationId = 427199, Name = "HouseDoor01a_Close" })

	thread( PlayVoiceLines, GlobalVoiceLines["ThanatosLeftOfficeVoiceLines"], true )
end

function LeavingBedroomHadesPresentation( currentRun, currentRoom )
	if TextLinesRecord["Ending01"] ~= nil then
		SetAnimation({ DestinationId = 555678, Name = "HouseDoor03_Open" })
		RoomEntranceStandard( currentRun, currentRoom )
		SetAnimation({ DestinationId = 555678, Name = "HouseDoor03_Close" })
	else
		SetAlpha({ Id = 555678, Fraction = 0.0 })
		SetAnimation({ DestinationId = 555681, Name = "HouseDoor03_Open" })
		RoomEntranceStandard( currentRun, currentRoom )
		SetAnimation({ DestinationId = 555681, Name = "HouseDoor03_Close" })
	end

	thread( PlayVoiceLines, GlobalVoiceLines["AchillesLeftHadesBedroomVoiceLines"], true )

end

function RoomEntranceStandard( currentRun, currentRoom )
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	-- Disable immediately, could be sitting on top of impassibility
	if currentRoom.HeroEndPoint ~= nil then
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = false })
	end
	wait(0.03)

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()
	FlashbackPresentation()
	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true } )
	end
	if currentRoom.CameraEndPoint ~= nil then
		PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomIntroSequenceDuration })
	end

	wait(0.03)

	thread( PlayVoiceLines, currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )
	wait( roomIntroSequenceDuration )
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })

end

function RoomEntranceBoss( currentRun, currentRoom, args )
	args = args or {}

	HideCombatUI("BossEntrance")
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	wait(0.03)

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()
	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true, AngleTowardsIdOnEnd = args.AngleTowardsIdOnEnd } )
	end
	if currentRoom.CameraEndPoint ~= nil then
		PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomIntroSequenceDuration })
	end

	wait(0.03)

	thread( PlayVoiceLines, currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )
	wait( roomIntroSequenceDuration )
	--LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
	UnblockCombatUI("BossEntrance")
end

function RoomEntranceBossHydra( currentRun, currentRoom )
	local hydraId = currentRoom.BossId
	local hydra = ActiveEnemies[hydraId] or {}
	HideCombatUI("BossEntrance")

	for k, id in pairs(GetIds({ Name = currentRoom.ExitGroupName })) do
		local offset = CalcOffset(math.rad(-30), -1000)
		Teleport({ Id = id, DestinationId = id, OffsetX = offset.X, OffsetY = offset.Y })
	end

	wait(0.05)
	-- Move hydra into position
	local acutalSpeed = GetUnitDataValue({ Id = hydraId, Property = "Speed" })
	SetUnitProperty({ Property = "Speed", Value = 7000, DestinationId = hydraId })
	Move({ Id = hydraId, DestinationId = currentRoom.HydraStartingPosition or 554461, Duration = 0.01, SuccessDistance = 50 })
	wait(0.35)
	Stop({ Id = hydraId })
	wait(0.05)
	AngleTowardTarget({ Id = hydraId , DestinationId = currentRoom.HeroEndPoint or 510172 })
	if hydra.SwapAnimations ~= nil then
		SetAnimation({ Name = hydra.SwapAnimations["EnemyHydraSleep_Loop"] or "EnemyHydraSleep_Loop", DestinationId = hydraId })
	end
	thread( AsphodelEnterRoomPresentation, currentRun, currentRoom, hydraId, true )
	wait(3.0)
	SetUnitProperty({ Property = "Speed", Value = acutalSpeed, DestinationId = hydraId })
	if hydra.SwapAnimations ~= nil then
		SetAnimation({ Name = hydra.SwapAnimations["EnemyHydraSleep_Wake"] or "EnemyHydraSleep_Wake", DestinationId = hydraId })
	end
	PlaySound({ Name = "/SFX/QuickSnap" })
	PlaySound({ Name = "/SFX/Enemy Sounds/HydraHead/EmoteAlerted", Id = hydraId })
	thread( InCombatText, hydraId, "Alerted", 0.45, { SkipShadow = true } )
	wait(3.4)
	if hydra.SwapAnimations ~= nil then
		SetAnimation({ DestinationId = hydraId, Name = hydra.SwapAnimations["EnemyHydraTaunt"] or "EnemyHydraTaunt" })
	end

	thread( HydraRoarPresentation )
	wait( 0.5 )
	UnblockCombatUI("BossEntrance")
end

function HydraRoarPresentation( )
	wait( 0.30 )
	AdjustRadialBlurDistance({ Fraction = 2.0, Duration = 0.3 })
	AdjustRadialBlurStrength({ Fraction = 1.0, Duration = 0.3 })
	--AdjustFullscreenBloom({ Name = "WrathPhase2", Duration = 0.3 })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 1000, Duration = 1.5 })
	thread( DoRumble, { { ScreenPreWait = 0.04, RightFraction = 0.17, Duration = 1.5 } } )
	wait( 1.0 )
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.75 })
	AdjustRadialBlurDistance({ Fraction = 0.0, Duration = 0.75 })
	AdjustRadialBlurStrength({ Fraction = 0.0, Duration = 0.75 })
end

function RoomEntranceHades( currentRun, currentRoom )
	local hadesId = 510857
	if currentRoom.Encounter.Name == "BossHadesPeaceful" then
		hadesId = 552710
	end

	HideCombatUI("BossEntrance")
	ZeroMouseTether("BossEntrance")
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0

	FadeOut({ Color = Color.White, Duration = 0 })
	AdjustFullscreenBloom({ Name = "LightningStrike", Duration = 0 })
	AdjustFullscreenBloom({ Name = "WrathPhase2", Duration = 0.1, Delay = 0 })

	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0 })
	AdjustRadialBlurDistance({ Fraction = 0.125, Duration = 0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.03, Delay=0 })
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.03, Delay=0 })

	AdjustFullscreenBloom({ Name = "Off", Duration = 5.0, Delay = 0.1 })

	SetVolume({ Id = OutdoorAmbientSoundId, Value = 0.0, Duration = 5 })
	OutdoorAmbientSoundId = nil

	wait(0.03)

	AdjustZoom({ Fraction = CurrentRun.CurrentRoom.IntroZoomFraction or 0.7, Duration = 0.0 })
	FadeIn({ Duration = 5.5 })
	LockCamera({ Id = hadesId, Duration = roomIntroSequenceDuration })
	FullScreenFadeInAnimation()
	AdjustColorGrading({ Name = "Rain", Duration = 0 })
	AdjustColorGrading({ Name = "Off", Duration = 4 })

	AddInputBlock({ Name = "MoveHeroToRoomPosition" })
	local initialSpeed = GetUnitDataValue({ Id = currentRun.Hero.ObjectId, Property = "Speed" })
	SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })

	SetUnitProperty({ Property = "StartGraphic", Value = nil, DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "ZagreusWalk", DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "Speed", Value = 130, DestinationId = currentRun.Hero.ObjectId })

	thread( PlayVoiceLines, currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	if currentRoom.HeroEndPoint ~= nil then
		Move({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint, Mode = "Precise" })

		local notifyName = "WithinDistance"..currentRoom.HeroEndPoint
		NotifyWithinDistance({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint, Distance = 30, Notify = notifyName })
		waitUntil( notifyName )
	end
	Stop({ Id = currentRun.Hero.ObjectId })

	SetUnitProperty({ Property = "StartGraphic", Value = "ZagreusStart", DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "ZagreusRun", DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "StopGraphic", Value = "ZagreusStop", DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "Speed", Value = initialSpeed, DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = true, DestinationId = currentRun.Hero.ObjectId })
	RemoveInputBlock({ Name = "MoveHeroToRoomPosition" })

	wait( 0.3 )
	--LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
	UnzeroMouseTether("BossEntrance")
	UnblockCombatUI("BossEntrance")
end

function RoomEntranceCrawlerMiniBoss( currentRun, currentRoom )
	local crawlerId = 552394

	HideCombatUI("BossEntrance")
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or 2.0
	wait(0.03)

	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()
	PanCamera({ Id = 545309, Duration = roomIntroSequenceDuration + 1, EaseOut = 0, OffsetX = 150, OffsetY = -200 })
	if currentRoom.HeroEndPoint ~= nil then
		thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true } )
	end

	thread( PlayVoiceLines, GlobalVoiceLines.CrawlerMiniBossEncounterStartVoiceLines, true )

	wait(roomIntroSequenceDuration)

	wait( 0.5 )

	SecretMusicPlayer( "/EmptyCue" )

	if GameState.EncountersOccurredCache.MiniBossCrawler > 1 then
		wait( 0.5 )
	else
		SetAnimation({ Name = "ZagreusInteractionThoughtful", DestinationId = CurrentRun.Hero.ObjectId })
		wait( 2.5 )
	end

	AngleTowardTarget({ Id = crawlerId , DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/QuickSnap", Id = crawlerId })
	thread( InCombatText, crawlerId, "Alerted", 0.45, { SkipShadow = true } )
	CreateAnimation({ Name = "EliteUnitStatus2", DestinationId = crawlerId })
	wait( 0.25 )
	PlaySound({ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar", Id = crawlerId })
	SetAnimation({ Name = "EnemyCrawlerHowling", DestinationId = crawlerId })
	wait( 0.02 )

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.2 })
	Shake({ Id = crawlerId, Distance = 2, Speed = 300, Duration = 3, FalloffSpeed = 3000 })
	ShakeScreen({ Speed = 500, Distance = 5, FalloffSpeed = 2000, Duration = 1.0 })
	FocusCamera({ Fraction = 1.0, ZoomType = "Overshoot", Duration = 0.17 })
	thread( DoRumble, { { ScreenPreWait = 0.1, Fraction = 0.23, Duration = 1.0 }, } )

	SecretMusicPlayer( "/Music/MusicExploration2_MC" )
	SetSoundCueValue({ Names = { "Section", }, Id = SecretMusicId, Value = 2 })

	wait( 0.5 )
	ResumeMusic( 0, 0 )
	EndMusic( MusicId, MusicName, 0.0 )
	thread( EndTinyVerminRadialBlur )

	if GameState.EncountersOccurredCache.MiniBossCrawler > 1 then
		LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.0 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, ZoomType = "Ease", Duration = 1.0 })
		wait( 1.0 )
	else
		LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
		FocusCamera({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, ZoomType = "Ease", Duration = 2.0 })
		wait( 2.0 )
	end

	UnblockCombatUI("BossEntrance")
end

function EndTinyVerminRadialBlur()
	wait(0.8)
	AdjustRadialBlurDistance({ Fraction = 0.0, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 0.0, Duration = 0.2 })
end

function CrawlerMiniBossEndPresentation( eventSource )

	SetSoundCueValue({ Names = { "Section", }, Id = SecretMusicId, Value = 10 })
	SecretMusicId = nil
	SecretMusicName = nil

end

function RoomEntranceE_Intro( currentRun, currentRoom )

	HideCombatUI("Surface")
	ZeroMouseTether("RoomEntrance")
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0

	FadeOut({ Color = Color.Black, Duration = 0 })
	AdjustFullscreenBloom({ Name = "LightningStrike", Duration = 0 })
	AdjustFullscreenBloom({ Name = "WrathPhase2", Duration = 0.1, Delay = 0 })

	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0 })
	AdjustRadialBlurDistance({ Fraction = 0.125, Duration = 0 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.03, Delay=0 })
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.03, Delay=0 })

	AdjustFullscreenBloom({ Name = "Off", Duration = 5.0, Delay = 0.1 })

	SetVolume({ Id = OutdoorAmbientSoundId, Value = 0.0, Duration = 5 })
	OutdoorAmbientSoundId = nil

	wait(0.03)

	AddInputBlock({ Name = "MoveHeroToRoomPosition" })
	local initialSpeed = GetUnitDataValue({ Id = currentRun.Hero.ObjectId, Property = "Speed", Destination})
	SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })

	if TextLinesRecord["PersephoneFirstMeeting"] == nil then
		SetUnitProperty({ Property = "StartGraphic", Value = nil, DestinationId = currentRun.Hero.ObjectId })
		SetUnitProperty({ Property = "MoveGraphic", Value = "ZagreusWalk2", DestinationId = currentRun.Hero.ObjectId })
		SetUnitProperty({ Property = "StopGraphic", Value = "ZagreusWalkStop2", DestinationId = currentRun.Hero.ObjectId })
		SetUnitProperty({ Property = "Speed", Value = 115, DestinationId = currentRun.Hero.ObjectId })
	else
		roomIntroSequenceDuration = 0.95
	end

	AdjustZoom({ Fraction = CurrentRun.CurrentRoom.IntroZoomFraction or 0.7, Duration = 0.0 })
	FadeIn({ Duration = 4.9 })
	PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomIntroSequenceDuration, EaseIn = 0.0, EaseOut = 0.0 })
	FullScreenFadeInAnimation()

	thread( PlayVoiceLines, currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	if currentRoom.HeroEndPoint ~= nil then
		Move({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint, Mode = "Precise" })

		local notifyName = "WithinDistance"..currentRoom.HeroEndPoint
		NotifyWithinDistance({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint, Distance = 30, Notify = notifyName })
		waitUntil( notifyName )
	end
	Stop({ Id = currentRun.Hero.ObjectId })

	if TextLinesRecord["PersephoneFirstMeeting"] == nil then
		currentRoom.DisableWeapons = true -- This makes the room disable the dash as well
	else
		thread( ResetPlayerMoveData, currentRun, initialSpeed, 2.0 )
	end

	SetUnitProperty({ Property = "CollideWithObstacles", Value = true, DestinationId = currentRun.Hero.ObjectId })
	RemoveInputBlock({ Name = "MoveHeroToRoomPosition" })

	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
	UnzeroMouseTether("RoomEntrance")

	thread( DisplaySurfaceLocationText, currentRun, currentRoom )

end

function DisplaySurfaceLocationText( currentRun, currentRoom )

	wait( 0.5 )

	local locationTextColor = currentRoom.LocationTextColor or { 255, 0, 0, 255 }
	if currentRoom.LocationText then
		thread( DisplayLocationText, nil, { Text = currentRoom.LocationText, Delay = 0.65, FadeColor = locationTextColor } )
	end

	wait( 1.2 )

	thread( CheckLocationUnlock, nil, { Biome = "Surface" } )

end

function DisplayGodModeHint()
	CheckObjectiveSet( "EasyModePrompt" )
end

function RoomEntranceSurface( currentRun, currentRoom )
	HideCombatUI("Surface")
	AdjustZoom({ Fraction = CurrentRun.CurrentRoom.IntroZoomFraction or 0.7, Duration = 0.0 })
	FadeIn({ Duration = 5.5 })
	PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomIntroSequenceDuration, EaseIn = 0.0, EaseOut = 0.0 })
	FullScreenFadeInAnimation( "RoomTransitionOutBlack" )

	AddInputBlock({ Name = "MoveHeroToRoomPosition" })
	local initialSpeed = GetUnitDataValue({ Id = currentRun.Hero.ObjectId, Property = "Speed", Destination})
	SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })

	if TextLinesRecord["PersephoneFirstMeeting"] == nil then
		SetUnitProperty({ Property = "StartGraphic", Value = nil, DestinationId = currentRun.Hero.ObjectId })
		SetUnitProperty({ Property = "MoveGraphic", Value = "ZagreusWalk2", DestinationId = currentRun.Hero.ObjectId })
		SetUnitProperty({ Property = "StopGraphic", Value = "ZagreusWalkStop2", DestinationId = currentRun.Hero.ObjectId })
		SetUnitProperty({ Property = "Speed", Value = 115, DestinationId = currentRun.Hero.ObjectId })
	end

	thread( PlayVoiceLines, currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	if currentRoom.HeroEndPoint ~= nil then
		Move({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint, Mode = "Precise" })

		local notifyName = "WithinDistance"..currentRoom.HeroEndPoint
		NotifyWithinDistance({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint, Distance = 30, Notify = notifyName })
		waitUntil( notifyName )
	end
	Stop({ Id = currentRun.Hero.ObjectId })

	if TextLinesRecord["PersephoneFirstMeeting"] == nil then
		thread( ResetPlayerMoveData, currentRun, initialSpeed, 2.0 )
	end

	SetUnitProperty({ Property = "CollideWithObstacles", Value = true, DestinationId = currentRun.Hero.ObjectId })
	RemoveInputBlock({ Name = "MoveHeroToRoomPosition" })

	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
	UnzeroMouseTether("RoomEntrance")
end

function ResetPlayerMoveData( currentRun, initialSpeed, delay )
	wait(delay)
	SetUnitProperty({ Property = "StartGraphic", Value = "ZagreusStart", DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "ZagreusRun", DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "StopGraphic", Value = "ZagreusStop", DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "Speed", Value = initialSpeed, DestinationId = currentRun.Hero.ObjectId })
end

function RoomEntrancePortal( currentRun, currentRoom )
	AddInputBlock({ Name = "RoomEntrancePortal" })
	local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
	AdjustFullscreenBloom({ Name = "NewType09" })
	wait(0.03)

	if currentRoom.HeroEndPoint ~= nil then
		AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
		Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = currentRoom.HeroEndPoint })
	end
	LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 0 })
	AdjustZLocation({ Id = currentRun.Hero.ObjectId, Distance = 1800, Duration = 0.0 })
	wait(0.03)
	ApplyUpwardForce({ Id = currentRun.Hero.ObjectId, Speed = -100 })
	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimation()

	-- Asphodel boats
	for k, unusedBoatId in pairs(GetIdsByType({ Name = "AsphodelBoat01" })) do
		Destroy({ Id = unusedBoatId })
	end

	wait(0.3)

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 1.0, Duration = 1.0 })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = currentRoom.EntranceAnimation or RoomData.BaseSecret.EntranceAnimation })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })

	wait(0.03)

	thread( PlayVoiceLines, currentRoom.EnterVoiceLines, true )
	thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )

	local locationTextColor = currentRoom.LocationTextColor or { 255, 0, 0, 255 }
	if currentRoom.LocationText then
		thread( DisplayLocationText, nil, { Text = currentRoom.LocationText, Delay = 0.65, FadeColor = locationTextColor, Duration = 2.0 } )
	end
	if currentRoom.BiomeName then
		thread( CheckLocationUnlock, nil, { Biome = currentRoom.BiomeName } )
	end
	thread(DelayedRemoveInputBlock, 0.35, "RoomEntrancePortal")
end

function DelayedRemoveInputBlock( delay, inputBlockName )
	wait( delay )
	RemoveInputBlock({ Name = inputBlockName })
end

function FullScreenFadeInAnimation( animationName )
	if ScreenAnchors.Transition ~= nil then
		Destroy({Id = ScreenAnchors.Transition})
	end
	AdjustColorGrading({ Name = "Dusk", Duration = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1 })
	AdjustColorGrading({ Name = "Off", Duration = 1 })
	ScreenAnchors.Transition = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Overlay" })
	SetAnimation({ DestinationId = ScreenAnchors.Transition, Name = animationName or "RoomTransitionOut" })
end

function FullScreenFadeOutAnimation( animationName )
	if ScreenAnchors.Transition ~= nil then
		Destroy({Id = ScreenAnchors.Transition})
	end
	AdjustColorGrading({ Name = "Dusk", Duration = 1 })
	ScreenAnchors.Transition = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Overlay" })
	SetAnimation({ DestinationId = ScreenAnchors.Transition, Name = animationName or "RoomTransitionIn"})
	PlaySound({ Name = "/Leftovers/Menu Sounds/InfoPanelOutURSA" })
	wait( 0.7 ) -- Duration of RoomTransitionIn buffered by a couple frames
end

function FullScreenFadeInAnimationReroll( color )
	if ScreenAnchors.Transition ~= nil then
		Destroy({Id = ScreenAnchors.Transition})
	end
	--AdjustFullscreenBloom({ Name = "Blur", Duration = 0 })
	--AdjustColorGrading({ Name = "Dusk", Duration = 0 })
	--AdjustFullscreenBloom({ Name = "Off", Duration = 1 })
	--AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	ScreenAnchors.Transition = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_TraitTray" })
	SetAnimation({ DestinationId = ScreenAnchors.Transition, Name = "RerollTransitionOut"})
	SetColor({ Id = ScreenAnchors.Transition, Color = Color.Black, Duration = 0 })
	SetColor({ Id = ScreenAnchors.Transition, Color = color or Color.DarknessPoint, Duration = 0.5 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/InfoPanelInURSA" })
end

function FullScreenFadeOutAnimationReroll( color )
	if ScreenAnchors.Transition ~= nil then
		Destroy({Id = ScreenAnchors.Transition})
	end
	--AdjustFullscreenBloom({ Name = "Blur", Duration = 1 })
	--AdjustColorGrading({ Name = "Dusk", Duration = 0.3 })
	ScreenAnchors.Transition = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_TraitTray" })
	SetAnimation({ DestinationId = ScreenAnchors.Transition, Name = "RerollTransitionIn"})
	SetColor({ Id = ScreenAnchors.Transition, Color = color or Color.DarknessPoint })
	SetColor({ Id = ScreenAnchors.Transition, Color = Color.Black, Duration = 1 })
	wait(0.3)
end

function FullScreenFadeInAnimationBoatRide()
	if ScreenAnchors.Transition ~= nil then
		Destroy({Id = ScreenAnchors.Transition})
	end
	AdjustColorGrading({ Name = "Dusk", Duration = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1 })
	AdjustColorGrading({ Name = "Off", Duration = 1 })
	ScreenAnchors.Transition = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Overlay" })
	SetAnimation({ DestinationId = ScreenAnchors.Transition, Name = "RoomTransitionOutBoatRide" })
end

function FullScreenFadeOutAnimationBoatRide( color )
	if ScreenAnchors.Transition ~= nil then
		Destroy({Id = ScreenAnchors.Transition})
	end
	AdjustColorGrading({ Name = "Dusk", Duration = 1 })
	ScreenAnchors.Transition = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Overlay" })
	SetAnimation({ DestinationId = ScreenAnchors.Transition, Name = "RoomTransitionInBoatRide"})
	PlaySound({ Name = "/Leftovers/Menu Sounds/InfoPanelOutURSA" })
	wait( 2.0 )


	ShowCombatUI( "BoatRide" )
	RemoveInputBlock({ Name = "BoatRide" })
	SetPlayerVulnerable( "BoatRide" )
end

function StartRoomMusic( currentRun, currentRoom )

	if currentRoom.IgnoreMusic then
		return
	end

	local musicTrackName = nil
	if currentRoom.MusicRequirements == nil or IsGameStateEligible( currentRun, currentRoom.MusicRequirements ) then
		musicTrackName = currentRoom.Music
	end

	local useRandomStems = true
	if currentRoom.BlockRandomStems or (currentRoom.Encounter ~= nil and currentRoom.Encounter.BlockRandomStems) then
		useRandomStems = false
	end

	local lastRoom = GetPreviousRoom( currentRun )
	if lastRoom ~= nil then
		if lastRoom.NextRoomResumeMusic or (lastRoom.Encounter ~= nil and lastRoom.Encounter.NextRoomResumeMusic) then
			ResumeMusic()
		elseif lastRoom.NextRoomMusic ~= nil then
			if lastRoom.Encounter.NextRoomMusic then
				musicTrackName = lastRoom.Encounter.NextRoomMusic
			elseif lastRoom.NextRoomMusic then
				musicTrackName = lastRoom.NextRoomMusic
			end
		end
	end
	if currentRoom.StopSecretMusic and SecretMusicId ~= nil then
		StopSecretMusic()
		ResumeMusic()
	end
	if currentRoom.EndMusicOnEnterDuration ~= nil and MusicId ~= nil then
		EndMusic( MusicId, MusicName, currentRoom.EndMusicOnEnterDuration )
		musicTrackName = nil
	end

	if musicTrackName ~= nil then
		-- A custom track was requested, don't mix randomly
		useRandomStems = false
	end

	wait( currentRoom.MusicStartDelay )

	local secretMusic = currentRoom.SecretMusic
	if secretMusic == nil and currentRoom.Encounter ~= nil then
		secretMusic = currentRoom.Encounter.SecretMusic
	end
	if currentRoom.ChosenRewardType == "Shop" then
		secretMusic = currentRoom.ShopSecretMusic
	end
	if secretMusic ~= nil then
		SecretMusicPlayer( secretMusic )
	else

		if musicTrackName ~= nil then
			MusicPlayer( musicTrackName )
		end

		if useRandomStems then
			thread( RandomStemMixer, currentRoom, MusicId )
		end

		thread( MusicMixer, currentRoom )

	end

	CheckMusicEvents( currentRun, RoomStartMusicEvents )

end

function ReattachCameraOnInput( currentRun )
	local notifyName = "ReattachCameraOnInput"
	NotifyOnPlayerInput({ Notify = notifyName })
	waitUntil( notifyName )
	PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
	UnzeroMouseTether( "StartRoomPresentation" )

end

function MoveHeroToRoomPosition( args )
	AddInputBlock({ Name = "MoveHeroToRoomPosition" })
	local heroId = CurrentRun.Hero.ObjectId

	local initialSpeed = GetUnitDataValue({ Id = heroId, Property = "Speed" })
	local defaultSpeed = 540
	if args.UseDefaultSpeed and initialSpeed ~= defaultSpeed then
		SetUnitProperty({ Property = "Speed", Value = defaultSpeed, DestinationId = heroId })
	end

	if args.DisableCollision then
		SetUnitProperty({ DestinationId = heroId, Property = "CollideWithObstacles", Value = false })
		SetUnitProperty({ DestinationId = heroId, Property = "CollideWithUnits", Value = false })
	end

	Move({ Id = heroId, DestinationId = args.DestinationId, SuccessDistance = args.NodeSuccessDistance or 32, StopAtEnd = true })
	local notifyName = "WithinDistance"..args.DestinationId

	NotifyWithinDistance({ Id = heroId, DestinationId = args.DestinationId, Distance = 45, Notify = notifyName, Timeout = args.Timeout or 5.0 })
	waitUntil( notifyName )
	Stop({ Id = heroId })
	if args.DisableCollision then
		SetUnitProperty({ DestinationId = heroId, Property = "CollideWithObstacles", Value = true })
		SetUnitProperty({ DestinationId = heroId, Property = "CollideWithUnits", Value = true })
	end

	if args.UseDefaultSpeed and initialSpeed ~= defaultSpeed then
		SetUnitProperty({ Property = "Speed", Value = initialSpeed, DestinationId = heroId })
		Halt({ Id = heroId })
	end

	if args.AngleTowardsIdOnEnd ~= nil then
		AngleTowardTarget({ Id = heroId, DestinationId = args.AngleTowardsIdOnEnd })
	end

	RemoveInputBlock({ Name = "MoveHeroToRoomPosition" })
end

function MoveHeroAlongPath( path, args )
	for k, id in ipairs( path ) do
		args.DestinationId = id
		MoveHeroToRoomPosition( args )
	end
end

function LeaveRoomAudio( currentRun, exitDoor )
	if currentRun == nil then
		return
	end
	if currentRun.Hero.IsDead then
		return
	end

	if exitDoor.ExitVoiceLines ~= nil then
		thread( PlayVoiceLines, exitDoor.ExitVoiceLines, true )
	elseif currentRun.CurrentRoom.Encounter.ExitVoiceLines ~= nil then
		thread( PlayVoiceLines, currentRun.CurrentRoom.Encounter.ExitVoiceLines, true )
	elseif currentRun.CurrentRoom.ExitVoiceLines ~= nil then
		thread( PlayVoiceLines, currentRun.CurrentRoom.ExitVoiceLines, true )
	else
		-- VO to be refactored [GK]
		if RandomChance( 0.17 ) then
			thread( PlayVoiceLines, GlobalVoiceLines.GeneralExitVoiceLines, true )

			-- health status lines
			local playerHealth = currentRun.Hero.Health
			if playerHealth <= 50 then
				thread( PlayVoiceLines, GlobalVoiceLines.HealthStatusPostExitVoiceLines )
			end
		end
	end

	thread( PlayVoiceLines, GlobalVoiceLines.SkellySummonExitReactionVoiceLines, true )

	if currentRun.CurrentRoom.EndAmbienceOnExit then
		StopSound({ Id = AmbienceId, Duration = 0.5 })
		AmbienceId = nil
	end
	if currentRun.CurrentRoom.EndMusicOnExit ~= nil then
		EndMusic( MusicId, MusicName, currentRun.CurrentRoom.EndMusicOnExit)
	end

	local exitAmbience = currentRun.CurrentRoom.ExitAmbience
	if exitAmbience ~= nil and exitAmbience ~= AmbienceName then
		StopSound({ Id = AmbienceId, Duration = 0.5 })
		AmbienceId = PlaySound({ Name = exitAmbience })
		AmbienceName = exitAmbience
		SetVolume({ Id = AmbienceId, Value = 0.0 })
		SetVolume({ Id = AmbienceId, Value = 1.0, Duration = 0.5 })
	end

end

function LeaveRoomPresentation( currentRun, exitDoor )

	local exitDoorId = exitDoor.ObjectId
	local door = OfferedExitDoors[exitDoorId]

	AddInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })

	HideCombatUI()

	if door ~= nil then
		if door.AdditionalIcons ~= nil and not IsEmpty( door.AdditionalIcons ) then
			Destroy({ Ids = door.AdditionalIcons })
			door.AdditionalIcons = nil
		end
		DestroyDoorRewardPresenation( door )
		if door.ExitDoorOpenAnimation ~= nil then
			SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorOpenAnimation })
			thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
			wait( 0.7 )
		end
	end

	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = GetClosest({ Id = exitDoorId, DestinationIds = heroExitIds, Distance = 600 })
	if heroExitPointId > 0 then

		local angleToExit = GetAngleBetween({ Id = exitDoorId, DestinationId = heroExitPointId })
		if angleToExit < 90 or angleToExit > 270 then
			currentRun.CurrentRoom.ExitDirection = "Right"
		else
			currentRun.CurrentRoom.ExitDirection = "Left"
		end

		PanCamera({ Id = heroExitPointId, Duration = 10.0 })
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
		local args = {}
		args.NodeSuccessDistance = 30
		local exitPath = exitDoor.ExitPath or currentRun.CurrentRoom.ExitPath or {}
		if door ~= nil and door.ExitThroughCenter then
			table.insert( exitPath, door.ObjectId )
		end
		table.insert( exitPath, heroExitPointId )
		thread( MoveHeroAlongPath, exitPath, args )
	else
		if exitDoorId ~= nil then
			AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = exitDoorId })
		end
		SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 1.0 })
		SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = currentRun.CurrentRoom.ExitAnimation or RoomData.BaseSecret.ExitAnimation })
		CreateAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = currentRun.CurrentRoom.ExitVfx or RoomData.BaseSecret.ExitVfx })
		if door ~= nil and door.ExitPortalSound then
			PlaySound({ Name = door.ExitPortalSound or "/SFX/Menu Sounds/ChaosRoomEnterExit" })
		end
	end

	--[[local nextZoom = exitDoor.Room.ZoomFraction or exitDoor.Room.PreviousRoomAdjustToZoomFraction
	if currentRun.CurrentRoom.ZoomFractionAdjustForWeights then
		nextZoom = 1 + (1 - nextZoom)
	end
	if nextZoom ~= nil then
		AdjustZoom({ Fraction = nextZoom or 1.0, LerpTime = currentRun.CurrentRoom.ZoomFractionAdjustTime or 1.4 })
	end]]

	LeaveRoomAudio( currentRun, exitDoor )

	wait(0.4)

	if door ~= nil and door.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = door.ExitDoorCloseAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end

	wait(0.2)

	--SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.3 })
	FullScreenFadeOutAnimation( currentRun.CurrentRoom.FadeOutAnimation )
	ShowInterMapComponents()

	AllowShout = false

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })
end

function ExitToHadesPresentation( currentRun, exitDoor )

	local exitDoorId = exitDoor.ObjectId

	AddInputBlock({ Name = "ExitToHadesPresentation" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })

	-- SetSoundCueValue({ Names = { "Guitar", "Drums", "Bass" }, Id = MusicId, Value = 1 })
	EndMusic()
	HideCombatUI()

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = exitDoorId })
	SetAnimation({ Name = "ZagreusInteractEquip", DestinationId = CurrentRun.Hero.ObjectId })
	ClearCameraClamp({ LerpTIme = 0.4 })

	wait(0.3)

	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockBoom", Id = exitDoorId })

	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.3, Delay = 0.45 })

	if exitDoor ~= nil then
		if exitDoor.AdditionalIcons ~= nil and not IsEmpty( exitDoor.AdditionalIcons ) then
			Destroy({ Ids = exitDoor.AdditionalIcons })
			exitDoor.AdditionalIcons = nil
		end
		DestroyDoorRewardPresenation( exitDoor )
		if exitDoor.ExitDoorOpenAnimation ~= nil then
			SetAnimation({ DestinationId = exitDoorId, Name = exitDoor.ExitDoorOpenAnimation })
			thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
			wait( 0.5 )
		end
	end

	OutdoorAmbientSoundId = PlaySound({ Name = "/Leftovers/Ambience/WhippingWindLoop" })
	SetVolume({ Id = OutdoorAmbientSoundId, Value = 0.1 })
	SetVolume({ Id = OutdoorAmbientSoundId, Value = 1.0, Duration = 8 })

	LeaveRoomAudio( currentRun, exitDoor )

	local cameraId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = exitDoorId, OffsetY = -700, OffsetX = 600, Group = "Standing" })

	LockCamera({ Id = cameraId, Duration = 1.25, EaseIn = 0.04, EaseOut = 0.275, Duration = 10 })

	wait(1.75)

	FadeOut({ Color = Color.White, Duration = 2 })

	wait(1.1)

	SetUnitProperty({ Property = "StartGraphic", Value = nil, DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "ZagreusWalk", DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "Speed", Value = 130, DestinationId = currentRun.Hero.ObjectId })

	SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = GetClosest({ Id = currentRun.Hero.ObjectId, DestinationIds = heroExitIds, Distance = 600 })
	thread( MoveHeroToRoomPosition, { DestinationId = heroExitPointId } )

	wait(4.0)

	FullScreenFadeOutAnimation()
	ShowInterMapComponents()

	AllowShout = false

	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })
	RemoveInputBlock({ Name = "ExitToHadesPresentation" })

end

function StartFinalBossRoomIntroMusic()
	MusicPlayer( "/Music/BossFightMusic" )
	SetMusicSection( 8, MusicId )
end

function RoomEntranceD_Hub(  eventSource, args  )
	currentRun = CurrentRun
	currentRoom = CurrentRun.CurrentRoom
	if TextLinesRecord["CerberusStyxMeeting01"] == nil then
		local cerberusId = 547487

		LockCamera({ Id = cerberusId, Duration = 0, OffsetX = -1400, OffsetY = 750 })
		
		HideCombatUI()

		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = false })
		wait(0.03)

		FadeIn({ Duration = 0.2 })
		FullScreenFadeInAnimation()
		FlashbackPresentation()

		thread( MoveHeroToRoomPosition, { DestinationId = 557124, DisableCollision =  true, UseDefaultSpeed = true, Timeout = 5.0 } )
		PanCamera({ Id = cerberusId, Duration = 5.3, EaseIn = 0.0, EaseOut = 0, OffsetX = -410, OffsetY = 110, Retarget = true })

		thread( PlayVoiceLines, currentRoom.EnterVoiceLines, true )
		thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )
	
		--wait( 2.5 )
		wait( 2.15 )

		SecretMusicPlayer( "/Music/HadesTheme" )

		wait( 2.9 )
	else

		local currentRun = CurrentRun
		local currentRoom = CurrentRun.CurrentRoom

		local roomIntroSequenceDuration = currentRoom.IntroSequenceDuration or RoomData.BaseRoom.IntroSequenceDuration or 0.0
		-- Disable immediately, could be sitting on top of impassibility
		if currentRoom.HeroEndPoint ~= nil then
			SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
			SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithUnits", Value = false })
		end
		wait(0.7) -- This is the wait before fade in to cover the boon fx

		FadeIn({ Duration = 0.0 })
		FullScreenFadeInAnimation()
		FlashbackPresentation()
		if currentRoom.HeroEndPoint ~= nil then
			thread( MoveHeroToRoomPosition, { DestinationId = currentRoom.HeroEndPoint, DisableCollision =  true, UseDefaultSpeed = true } )
		end
		if currentRoom.CameraEndPoint ~= nil then
			PanCamera({ Id = currentRoom.CameraEndPoint, Duration = roomIntroSequenceDuration })
		end

		wait(0.03)

		thread( PlayVoiceLines, currentRoom.EnterVoiceLines, true )
		thread( PlayVoiceLines, GlobalVoiceLines[currentRoom.EnterGlobalVoiceLines], true )
		wait( roomIntroSequenceDuration )
		LockCamera({ Id = currentRun.Hero.ObjectId, Duration = 2.0 })
	end
end

function ResumeStyxMusic()
	wait(1.1)
	ResumeSound({ Id = MusicId, Duration = 0.2 })
	SetVolume({ Id = MusicId, Value = 1.0 })
end

function StartFinalBossRoomMusic()
	MusicPlayer( "/Music/BossFightMusic" )
	SetMusicSection( 0, MusicId )
end
function StartCharonBossRoomMusic()
	MusicPlayer( "/Music/CharonFightTheme" )
	SetMusicSection( 0, MusicId )
end

function LeaveDeathAreaRoomPresentation( currentRun, exitDoor )

	local exitDoorId = exitDoor.ObjectId

	AddInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })

	local dashedIntoDoor = false
	if HasEffect({ Id = CurrentRun.Hero.ObjectId, EffectName = "RushWeaponDisableCancelable" }) then
		ClearEffect({ Id = CurrentRun.Hero.ObjectId, Name = "RushWeaponDisableCancelable" })
		dashedIntoDoor = true
	end

	HideCombatUI()
	
	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	if exitDoor.ExitDoorOpenAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = exitDoor.ExitDoorOpenAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.4 }, } )
		wait( 0.5 )
	end


	local heroExitIds = GetIdsByType({ Name = "HeroExit" })
	local heroExitPointId = GetClosest({ Id = currentRun.Hero.ObjectId, DestinationIds = heroExitIds, Distance = 600 })
	if heroExitPointId > 0 then

		local angleToExit = GetAngleBetween({ Id = exitDoorId, DestinationId = heroExitPointId })
		if angleToExit < 90 or angleToExit > 270 then
			currentRun.CurrentRoom.ExitDirection = "Right"
		else
			currentRun.CurrentRoom.ExitDirection = "Left"
		end

		SetCameraClamp({ SoftClampOnly = true, SoftClamp = 0.001 })
		PanCamera({ Id = heroExitPointId, Duration = 10.0, FromCurrentLocation = true })
		SetUnitProperty({ DestinationId = currentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })

		local args = {}
		args.NodeSuccessDistance = 30
		local exitPath = exitDoor.ExitPath or {}
		if exitDoor ~= nil and exitDoor.ExitThroughCenter then
			table.insert( exitPath, exitDoor.ObjectId )
		end
		table.insert( exitPath, heroExitPointId )
		thread( MoveHeroAlongPath, exitPath, args )
	else
		if exitDoorId ~= nil then
			AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = exitDoorId })
		end
		SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 1.0 })
	end

	LeaveRoomAudio( currentRun, exitDoor )

	if not dashedIntoDoor then
		local notifyName = "DashToSkip"
		NotifyOnControlPressed({ Names = { "Rush" }, Notify = notifyName, Timeout = 0.6 })
		waitUntil( notifyName )
		local didSkip = not _eventTimeoutRecord[notifyName]
		if didSkip then
			FireWeaponFromUnit({ Weapon = "RushWeapon", Id = CurrentRun.Hero.ObjectId })
		end
	end

	if exitDoor ~= nil and exitDoor.ExitDoorCloseAnimation ~= nil then
		SetAnimation({ DestinationId = exitDoorId, Name = exitDoor.ExitDoorCloseAnimation })
		thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	end

	SetAlpha({ Id = currentRun.Hero.ObjectId, Fraction = 0, Duration = 0.3 })
	FullScreenFadeOutAnimation()
	ShowInterMapComponents()

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })

end

function PlayerEnterSecretDoorPresentation( secretDoor )
	SetAnimation({ Name = "ZagreusSecretDoorDive", DestinationId = CurrentRun.Hero.ObjectId })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.7 }, } )
	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 0.5, MinFraction = 0, MaxFraction = 1.0, Color = Color.White, Duration = 1.0, ExpireAfterCycle = false })
	AdjustColorGrading({ Name = secretDoor.EntranceColorGrade or "Chaos", Duration = 0.7 })
	wait(0.7)
	CreateAnimation({ Name = secretDoor.EntranceVfx or "ZagreusSecretDoorDiveFadeFx", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0, Duration = 0.13 })
end

function ExitSecretRoomPresentation( currentRun, exitDoor )

	AddInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })
	HideCombatUI()
	LeaveRoomAudio( currentRun, exitDoor )
	thread( PlayerEnterSecretDoorPresentation, exitDoor )
	wait(0.3)
	FullScreenFadeOutAnimation()
	ShowInterMapComponents()

	AllowShout = false

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })

end

function ExitDoorUnlockedPresentation( exitDoor )

	if exitDoor.UnlockedAnimationMetaReward ~= nil and exitDoor.Room ~= nil and exitDoor.Room.RewardStoreName == "MetaProgress" then
		SetAnimation({ Name = exitDoor.UnlockedAnimationMetaReward, DestinationId = exitDoor.ObjectId })
	elseif exitDoor.UnlockedAnimation ~= nil then
		SetAnimation({ Name = exitDoor.UnlockedAnimation, DestinationId = exitDoor.ObjectId })
	end
	if exitDoor.DoorIconId then
		SetColor({ Id = exitDoor.DoorIconId, Color = {1.0, 1.0, 1.0, 0}, Duration = 0})
		SetColor({ Id = exitDoor.DoorIconId, Color = {0, 0, 0, 1}, Duration = 0.2})
	end
	if exitDoor.UnlockedSound ~= nil then
		PlaySound({ Name = exitDoor.UnlockedSound, Id = exitDoor.ObjectId })
	end
	if exitDoor.UnlockedGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[exitDoor.UnlockedGlobalVoiceLines], true )
	end
	wait(0.1)
	thread( PlayVoiceLines, HeroVoiceLines.ExitsUnlockedVoiceLines )

end

function SecretDoorUsedPresentation( secretDoorId, secretDoor )

	FreezePlayerUnit("SecretDoor")
	HideCombatUI()
	AddInputBlock({ Name = "SecretDoorEnter" })

	PlaySound({ Name = "/SFX/Menu Sounds/ChaosRoomEnterExit" })
	ZeroMouseTether("SecretDoor")
	PanCamera({ Id = secretDoorId, Duration = 7.0 })
	FocusCamera({ Fraction = 1.05, Duration = 7.0, ZoomType = "Ease" })
	thread( PlayVoiceLines, HeroVoiceLines.SecretUnlockedVoiceLines, true )

	SetAnimation({ DestinationId = secretDoorId, Name = "SecretDoor_RevealedWalkable" })
	thread( InCombatText, secretDoorId, "SecretPassageOpened", 1 )
	local notifyName = "SecretDoorEnter"
	Move({ Id = CurrentRun.Hero.ObjectId, DestinationId = secretDoorId, Mode = "Precise", SuccessDistance = 25 })
	SetColor({ Id = CurrentRun.Hero.ObjectId, Color = {0.2, 0, 1.0, 1.0}, Duration = 2.0 })
	NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = secretDoorId, Distance = 32, Notify = notifyName, Timeout = 3 })
	waitUntil( notifyName )
	Stop({ Id = CurrentRun.Hero.ObjectId })
	if TextLinesRecord.ChaosFirstPickUp then
		wait( 1.1 )
	else
		wait( 4.5 )
	end

	AdjustFullscreenBloom({ Name = "NewType09", Duration = 0.1 })
	if secretDoor.HealthCost ~= nil and not HeroHasTrait( "ChaosBoonTrait" ) then
		CreateAnimation({ Name = "SacrificeHealthFx", DestinationId = CurrentRun.Hero.ObjectId })
		thread( DisplayPlayerDamageText, { triggeredById = CurrentRun.Hero.ObjectId, PercentMaxDealt = secretDoor.HealthCost/CurrentRun.Hero.MaxHealth, DamageAmount = secretDoor.HealthCost } )
	end
	UseableOff({ Id = secretDoorId })
	HideUseButton( secretDoorId, secretDoor )
	wait( 0.2 )

	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })
	thread( PlayerEnterSecretDoorPresentation, secretDoor )
	PlaySound({ Name = "/Leftovers/SFX/PlayerRespawn" })
	wait( 1.0 )

	PlaySound({ Name = "/Leftovers/SFX/FieldReviveSFX" })
	AdjustFullscreenBloom({ Name = "SaturatedLight", Duration = 0.8 })
	UnfreezePlayerUnit("SecretDoor")

	wait( 0.35 )
	RemoveInputBlock({ Name = "SecretDoorEnter" })
	--UnzeroMouseTether("SecretDoor")

end

function ShrinePointDoorUsedPresentation( secretDoorId, secretDoor )

	FreezePlayerUnit("SecretDoor")
	HideCombatUI()
	AddInputBlock({ Name = "SecretDoorEnter" })

	PlaySound({ Name = "/SFX/HeatRewardDrop" })
	ZeroMouseTether("SecretDoor")
	PanCamera({ Id = secretDoorId, Duration = 7.0 })
	FocusCamera({ Fraction = 1.05, Duration = 7.0, ZoomType = "Ease" })
	thread( PlayVoiceLines, HeroVoiceLines.ShrineDoorUnlockedVoiceLines, true )
	SetAnimation({ DestinationId = secretDoorId, Name = "ShrinePointDoor_RevealedWalkable" })

	DestroyDoorRewardPresenation( secretDoor )

	SetAnimation({ Name = "Blank", DestinationId = secretDoor.DoorIconBackingId })
	thread( InCombatText, secretDoorId, "SecretPassageOpened", 1 )
	local notifyName = "SecretDoorEnter"
	Move({ Id = CurrentRun.Hero.ObjectId, DestinationId = secretDoorId, Mode = "Precise" })
	NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = secretDoorId, Distance = 15, Notify = notifyName, Timeout = 3 })
	waitUntil( notifyName )
	Stop({ Id = CurrentRun.Hero.ObjectId })
	wait( 1.1 )

	AdjustFullscreenBloom({ Name = "NewType09", Duration = 0.1 })
	UseableOff({ Id = secretDoorId })
	HideUseButton( secretDoorId, secretDoor )
	wait( 0.2 )

	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })
	thread( PlayerEnterSecretDoorPresentation, secretDoor )
	PlaySound({ Name = "/Leftovers/SFX/PlayerRespawn" })
	wait( 1.0 )

	PlaySound({ Name = "/Leftovers/SFX/FieldReviveSFX" })
	AdjustFullscreenBloom({ Name = "SaturatedLight", Duration = 0.8 })
	UnfreezePlayerUnit("SecretDoor")

	wait( 0.35 )
	RemoveInputBlock({ Name = "SecretDoorEnter" })
	--UnzeroMouseTether("SecretDoor")

end

function CreateDoorRewardPreview( exitDoor )

	local room = exitDoor.Room

	if exitDoor.HideRewardPreview or room.HideRewardPreview then
		return
	end

	local doorIconOffsetZ = exitDoor.RewardPreviewOffsetZ or CurrentRun.CurrentRoom.ExitDoorIconOffzetZ or 210
	local doorIconOffsetY = exitDoor.RewardPreviewOffsetY or CurrentRun.CurrentRoom.ExitDoorIconOffzetY or 30
	local doorIconOffsetX = exitDoor.RewardPreviewOffsetX or CurrentRun.CurrentRoom.ExitDoorIconOffzetX or 0
	if IsHorizontallyFlipped({ Id = exitDoor.ObjectId }) then
		doorIconOffsetX = doorIconOffsetX * -1
	end
	exitDoor.AdditionalAttractIds = exitDoor.AdditionalAttractIds or {}
	exitDoor.AdditionalIcons = {}

	if exitDoor.BackingAnimation ~= nil then
		exitDoor.DoorIconBackingId = SpawnObstacle({ Name = "BlankGeoObstacle", Group = "Standing" })
		Attach({ Id = exitDoor.DoorIconBackingId, DestinationId = exitDoor.ObjectId, OffsetZ = doorIconOffsetZ, OffsetY = doorIconOffsetY - 2, OffsetX = doorIconOffsetX, DynamicScaleOffset = true })
		SetThingProperty({ Property = "SortMode", Value = exitDoor.IconSortMode or "FromParent", DestinationId = exitDoor.DoorIconBackingId })
		SetThingProperty({ Property = "SortBoundsScale", Value = 10, DestinationId = exitDoor.DoorIconBackingId })
		table.insert( exitDoor.AdditionalIcons, exitDoor.DoorIconBackingId )
		SetAnimation({ Name = exitDoor.BackingAnimation, DestinationId = exitDoor.DoorIconBackingId })
	end

	exitDoor.DoorIconId = SpawnObstacle({ Name = "BlankGeoObstacle", Group = "Standing" })
	table.insert( exitDoor.AdditionalAttractIds, exitDoor.DoorIconId )
	Attach({ Id = exitDoor.DoorIconId, DestinationId = exitDoor.ObjectId, OffsetZ = doorIconOffsetZ, OffsetY = doorIconOffsetY, OffsetX = doorIconOffsetX, DynamicScaleOffset = true })
	SetThingProperty({ Property = "SortMode", Value = exitDoor.IconSortMode or "FromParent", DestinationId = exitDoor.DoorIconId })
	SetThingProperty({ Property = "SortBoundsScale", Value = 5, DestinationId = exitDoor.DoorIconId })

	if room.NextRoomSet then
		SetAnimation({ DestinationId = exitDoor.DoorIconId, Name = "ExitPreview" })
	elseif HasHeroTraitValue("HiddenRoomReward") then
		SetAnimation({ DestinationId = exitDoor.DoorIconId, Name = "ChaosPreview" })
	elseif room.ChosenRewardType == nil then
		SetAnimation({ DestinationId = exitDoor.DoorIconId, Name = "StoryPreview" })
	elseif room.ChosenRewardType == "Boon" and room.ForceLootName then
		if LootData[room.ForceLootName].DoorIcon ~= nil then
			SetAnimation({ DestinationId = exitDoor.DoorIconId, Name = LootData[room.ForceLootName].DoorIcon })
		else
			SetAnimation({ DestinationId = exitDoor.DoorIconId, Name = LootData[room.ForceLootName].Icon })
		end
	elseif room.ChosenRewardType == "Devotion" and room.Encounter.LootAName and room.Encounter.LootBName then
		local doorAIconId = SpawnObstacle({ Name = "BlankGeoObstacle", Group = "Standing" })
		SetAnimation({ DestinationId = doorAIconId, Name = LootData[ room.Encounter.LootAName].DoorIcon })
		Attach({ Id = doorAIconId, DestinationId = exitDoor.DoorIconId, DynamicScaleOffset = true, OffsetZ = 15, OffsetX = 15, OffsetY = -1 })
		SetScale({ Id = doorAIconId, Fraction = 0.85 })
		SetThingProperty({ Property = "SortMode", Value = "FromParent", DestinationId = doorAIconId })
		table.insert( exitDoor.AdditionalIcons, doorAIconId )
		table.insert( exitDoor.AdditionalAttractIds, doorAIconId )

		local doorBIconId = SpawnObstacle({ Name = "BlankGeoObstacle", Group = "Standing" })
		SetAnimation({ DestinationId = doorBIconId, Name = LootData[ room.Encounter.LootBName].DoorIcon })
		Attach({ Id = doorBIconId, DestinationId = exitDoor.DoorIconId, DynamicScaleOffset = true, OffsetZ = -15, OffsetX = -15 })
		SetScale({ Id = doorBIconId, Fraction = 0.85 })
		SetThingProperty({ Property = "SortMode", Value = "FromParent", DestinationId = doorBIconId })
		table.insert( exitDoor.AdditionalIcons, doorBIconId )
		table.insert( exitDoor.AdditionalAttractIds, doorBIconId )
	else
		SetAnimation({ DestinationId = exitDoor.DoorIconId, Name = room.ChosenRewardType.."Preview" })
	end


	exitDoor.DoorIconFront = SpawnObstacle({ Name = "BlankGeoObstacle", Group = "Standing" })
	table.insert( exitDoor.AdditionalAttractIds, exitDoor.DoorIconFront )
	Attach({ Id = exitDoor.DoorIconFront, DestinationId = exitDoor.DoorIconId, DynamicScaleOffset = true })
	SetThingProperty({ Property = "SortMode", Value = exitDoor.IconSortMode or "FromParent", DestinationId = exitDoor.DoorIconFront })
	SetThingProperty({ Property = "SortBoundsScale", Value = 2, DestinationId = exitDoor.DoorIconFront })

	local rewardContainerAnim = "RoomRewardAvailable-Front"
	if room.RewardStoreName == "MetaProgress" then
		rewardContainerAnim = rewardContainerAnim.."_MetaReward"
	end

	SetAnimation({ Name = rewardContainerAnim, DestinationId = exitDoor.DoorIconFront, Scale = 1 })

	if not HasHeroTraitValue("HiddenRoomReward") then
		CreateDoorPreviewIcon( exitDoor, { RoomData = room } )
	end

	if IsHorizontallyFlipped({ Id = exitDoor.ObjectId }) then
		local ids = CombineTables( { exitDoor.DoorIconId, exitDoor.DoorIconFront }, exitDoor.AdditionalIcons )
		if not IsEmpty( ids ) then
			FlipHorizontal({ Ids = ids })
		end
	end
end

function CreateDoorPreviewIcon( exitDoor, args )
	if exitDoor.AdditionalIcons == nil then
		exitDoor.AdditionalIcons = {}
	end

	args = args or {}
	args.RoomData = args.RoomData or {}
	local rewardOverrides = args.RoomData.RewardOverrides or {}
	local encounterData = args.RoomData.Encounter or {}

	offsetX = args.OffsetX or -13
	offsetY = args.OffsetY or 55

	if IsHorizontallyFlipped({ Id = exitDoor.ObjectId }) then
		offsetX = offsetX * -1
	end

	local previewIcon = rewardOverrides.RewardPreviewIcon or encounterData.RewardPreviewIcon or args.RoomData.RewardPreviewIcon
	local previewFx = rewardOverrides.RewardPreviewFx or encounterData.RewardPreviewFx or args.RoomData.RewardPreviewFx

	if previewIcon ~= nil then
		local doorEliteIconId = SpawnObstacle({ Name = "BlankGeoObstacle", Group = "Standing" })
		SetThingProperty({ Property = "SortMode", Value = "FromParent", DestinationId = doorEliteIconId })
		SetAnimation({ DestinationId = doorEliteIconId, Name = previewIcon })
		SetScale({ Id = doorEliteIconId, Fraction = 1.5 })
		Attach({ Id = doorEliteIconId, DestinationId = exitDoor.DoorIconId, DynamicScaleOffset = true, OffsetY = offsetY, OffsetX = offsetX })
		table.insert(exitDoor.AdditionalIcons, doorEliteIconId)
	end
	if previewFx ~= nil then
		CreateAnimation({ Name = previewFx, DestinationId = exitDoor.DoorIconFront, Scale = 1 })
	end
end

function GatherRoomPresentationObjects( currentRun, currentRoom )

	if NextHeroStartPoint ~= nil and NextHeroEndPoint ~= nil then
		currentRoom.HeroStartPoint = NextHeroStartPoint
		NextHeroStartPoint = nil
		currentRoom.HeroEndPoint = NextHeroEndPoint
		NextHeroEndPoint = nil
	elseif currentRoom.HeroStartPoint == nil or currentRoom.HeroEndPoint == nil then
		local heroStartIds = GetIdsByType({ Name = "HeroStart" })
		table.sort( heroStartIds )
		local heroEndIds = GetIdsByType({ Name = "HeroEnd" })
		table.sort( heroEndIds )
		for k, startId in ipairs( heroStartIds ) do
			local endId = GetClosest({ Id = startId, DestinationIds = heroEndIds })
			local entranceEndId = endId
			if currentRoom.EntranceDirectionEndIdObstacleName ~= nil then
				entranceEndId = GetClosest({ Id = startId, DestinationIds = GetIdsByType({ Name = currentRoom.EntranceDirectionEndIdObstacleName }) })
			end
			local entranceDirectation = nil
			local entranceAngle = GetAngleBetween({ Id = startId, DestinationId = entranceEndId })
			if entranceAngle < 90 or entranceAngle > 270 then
				entranceDirectation = "Right"
			else
				entranceDirectation = "Left"
			end
			local prevRoom = GetPreviousRoom( currentRun )
			if prevRoom == nil or prevRoom.ExitDirection == nil or prevRoom.ExitDirection == entranceDirectation then
				currentRoom.HeroStartPoint = startId
				currentRoom.HeroEndPoint = endId
				break
			end
		end
		currentRoom.HeroStartPoint = currentRoom.HeroStartPoint or GetFirstValue(heroStartIds)
		currentRoom.HeroEndPoint = currentRoom.HeroEndPoint or GetFirstValue(heroEndIds)
	end

	local roomCameraIntroStartIds = GetIdsByType({ Name = "CameraIntroStart" })
	currentRoom.CameraStartPoint = GetClosest({ Id = currentRoom.HeroStartPoint, DestinationIds = roomCameraIntroStartIds })

	local roomCameraIntroEndIds = GetIdsByType({ Name = "CameraIntroEnd" })
	currentRoom.CameraEndPoint = GetClosest({ Id = currentRoom.HeroStartPoint, DestinationIds = roomCameraIntroEndIds })

end

function MaxHealthIncreaseText( args )
	if not args.SpecialText then
		return
	end
	local maxHealthGained = args.MaxHealthGained
	if maxHealthGained == nil then
		local traitData = GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = args.MaxHealthTraitName })
		ExtractValues( CurrentRun.Hero, traitData, traitData )
		maxHealthGained = traitData.TooltipHealth
	end
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = args.SpecialText, Duration = 0.7, LuaKey = "TooltipData", ShadowScale = 0.7, OffsetY = -100,  LuaValue = { TooltipHealth = maxHealthGained }})
end

function DevotionTestPresentation()

	HideCombatUI("Devotion")
	thread( DisplayLocationText, nil, { Text = "DevotionMessage", Delay = 0.95 } )
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
	AdjustColorGrading({ Name = "Devotion", Duration = 1.0 })
	local devotionSoundId = PlaySound({ Name = "/SFX/GodFavorBattleStart" })
	SetVolume({ Id = devotionSoundId, Value = 0.3 })

	wait(3.5)
	AdjustColorGrading({ Name = "Off", Duration = 2.0 })
	StopSound({ Id = devotionSoundId, Duration = 2.0 })
	wait(2.0)
	ShowCombatUI("Devotion")
end

function SurvivalEncounterStartPresentation( eventSource, tollTimes, colorGrade, colorFx, playerGlobalVoiceLines, opponentGlobalVoiceLines )
	local survivalEncounter = eventSource

	AdjustColorGrading({ Name = colorGrade or "Alert", Duration = 0 })
	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = colorFx or "FullscreenAlertColor", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	AdjustFullscreenBloom({ Name = "AlertBloom", Duration = 0.25 })

	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	local hadesOverlay = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX - 420, Y = ScreenCenterY, Group = "Events" })
	SetScale({ Id = hadesOverlay, Fraction = 1 })
	SetAlpha({ Id = hadesOverlay, Fraction = 0.0, Duration = 0 })
	Move({ Id = hadesOverlay, Angle = 270, Speed = 5 })

	SetAnimation({ Name = "HadesOverlay", DestinationId = hadesOverlay })

	if not CurrentRun.CurrentRoom.BlockHadesOverlay then
		SetAlpha({ Id = hadesOverlay, Fraction = 1.0, Duration = 0 })
	end

	wait( 0.4, RoomThreadName )

	if playerGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[playerGlobalVoiceLines], true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.SurvivalAboutToStartVoiceLines, true )
	end

	wait( 1.4, RoomThreadName )
	local source = {} -- Dummy source for disembodied voice
	source.SubtitleColor = Color.HadesVoice
	if opponentGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[opponentGlobalVoiceLines], false, source )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.SurvivalEncounterStartVoiceLines, false, source )
	end

	thread( HadesVoicelineBlur )
	for index = 1, tollTimes or 3, 1 do
		SurvivalTollPulse()
	end
	AdjustFullscreenBloom({ Name = "NewType10", Duration = 1.4 })
	PlaySound({ Name = "/SFX/SurvivalChallengeStart" })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )
	if tollTimes == 0 then
		wait( 2.4, RoomThreadName )
	else
		wait( 1.4, RoomThreadName )
	end

	local activeStemTable = { "Guitar", "Bass", "Drums" }
	SetSoundCueValue({ Names = activeStemTable, Id = MusicId, Value = 1, Duration = 0.75 })

	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = hadesOverlay, Fraction = 0.0, Duration = 1 })
	wait( 1.0, RoomThreadName )
	Destroy({ Id = hadesOverlay })
	Destroy({ Ids = { fullscreenAlertColorFx, fullscreenAlertDisplacementFx } })
end

function HadesVoicelineBlur( args )
	wait( 0.85, RoomThreadName )
	if args == nil or not args.BlockScreenshake then
		ShakeScreen({ Speed = 900, Distance = 8, FalloffSpeed = 2000, Duration = 1.05 })
	end
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 1.1 }, } )
	AdjustRadialBlurDistance({ Fraction = 0.4, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 0.4, Duration = 0.2 })
	wait( 1.3, RoomThreadName )
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.2 })
end

function SurvivalTollPulse()
	PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulse" })
	ShakeScreen({ Speed = 300, Distance = 3, FalloffSpeed = 2000, Duration = 0.3 })
	AdjustColorGrading({ Name = "Alert", Duration = 0.02 })
	AdjustFullscreenBloom({ Name = "AlertBloom", Duration = 0.02 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.2 }, } )
	wait( 0.02, RoomThreadName )
	AdjustColorGrading({ Name = "Alert", Duration = 1.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })
	wait( 1.0, RoomThreadName )
end

function HeroicStandPulse( remainingPulses )
	PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulse" })
	ShakeScreen({ Speed = 300, Distance = 3, FalloffSpeed = 2000, Duration = 0.3 })
	AdjustColorGrading({ Name = "Alert", Duration = 0.02 })
	AdjustFullscreenBloom({ Name = "AlertBloom", Duration = 0.02 })
	wait( 0.02, RoomThreadName )
	if remainingPulses <= 3 then
		AdjustColorGrading({ Name = "Off", Duration = 1 })
		AdjustFullscreenBloom({ Name = "Off", Duration = 1 })
	else
		AdjustColorGrading({ Name = "Off", Duration = 0.25 })
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.25 })
	end
end

function SurvivalObjectivePresentation( survivalEncounter )
	local playedHurryLines = false

	while survivalEncounter.RemainingTime > 0 and not survivalEncounter.TimeIsUp and not survivalEncounter.Completed do
		if survivalEncounter.RemainingTime <= 10 then
			if not playedHurryLines and survivalEncounter.TimeExpiringGlobalVoiceLines ~= nil then
				thread( PlayVoiceLines, GlobalVoiceLines[survivalEncounter.TimeExpiringGlobalVoiceLines], true )
				playedHurryLines = true
			end

			UpdateObjective( survivalEncounter.EncounterType, "RemainingSeconds", math.ceil(survivalEncounter.RemainingTime), {Pulse = true } )
			PlaySound({ Name = "/Leftovers/SFX/FieldReviveSFX" })
			wait( 1.0, RoomThreadName )
		else
			UpdateObjective( survivalEncounter.EncounterType, "RemainingSeconds", math.ceil(survivalEncounter.RemainingTime))
			PlaySound({ Name = "/Leftovers/SFX/PowerToggleNew" })
			wait( 1.0, RoomThreadName )
		end
	end
	UpdateObjective( survivalEncounter.EncounterType, "RemainingSeconds", 1)
end

GlobalVoiceLines.PerfectClearEncounterStartVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 1.25,
	NoTarget = true,

	-- Let's see if you're as skillful as you think.
	{ Cue = "/VO/Intercom_0289" },
	-- Wretches of the Underworld, take him.
	{ Cue = "/VO/Intercom_0290" },
	-- We shall see how good you really are.
	{ Cue = "/VO/Intercom_0291" },
	-- How about a little contest, boy.
	{ Cue = "/VO/Intercom_0292" },
	-- My wretches have come to collect.
	{ Cue = "/VO/Intercom_0293" },
	-- Let's see you avoid this.
	{ Cue = "/VO/Intercom_0294" },
	-- I have a challenge for you, boy.
	{ Cue = "/VO/Intercom_0295" },
	-- Can you evade my wretches, boy?
	{ Cue = "/VO/Intercom_0296" },
	-- Get him, wretches, now!
	{ Cue = "/VO/Intercom_0297" },
	-- Time now to pay your dues.
	{ Cue = "/VO/Intercom_0298" },
	-- I'd like to see you dodge the following.
	{ Cue = "/VO/Intercom_0299" },
	-- Don't let yourself get hit, or else, boy!
	{ Cue = "/VO/Intercom_0300" },
	-- I know where you are.
	{ Cue = "/VO/Intercom_0413" },
	-- You shall not escape.
	{ Cue = "/VO/Intercom_0414" },
	-- Where do you think you're going?
	{ Cue = "/VO/Intercom_0415" },
	-- Stop right there.
	{ Cue = "/VO/Intercom_0416" },
	-- You should know when to quit.
	{ Cue = "/VO/Intercom_0417", RequiredFalseTextLines = { "Ending01" }, },
	-- You're trapped, boy. Don't you understand?
	{ Cue = "/VO/Intercom_0418", RequiredFalseTextLines = { "Ending01" }, },
	-- So you've returned.
	{ Cue = "/VO/Intercom_0583", RequireCurrentEncounterCompleted = true },
	-- Welcome to Erebus.
	{ Cue = "/VO/Intercom_0584" },
	-- What sort of fool goes into Erebus at will?
	{ Cue = "/VO/Intercom_0585", RequiredFalseTextLines = { "Ending01" }, },
	-- I see that you've returned.
	{ Cue = "/VO/Intercom_0586", RequireCurrentEncounterCompleted = true },
	-- One scratch and all your efforts will be lost.
	{ Cue = "/VO/Intercom_0587" },
	-- Remember not to get too nervous, boy.
	{ Cue = "/VO/Intercom_0588" },
	-- I've a delicious onion waiting for you, boy.
	{ Cue = "/VO/Intercom_1136", RequiredCodexEntry = { EntryName = "RoomRewardConsolationPrize", EntryIndex = 1, }, },
	-- Let's see you put your youthful reflexes to work.
	{ Cue = "/VO/Intercom_1137" },
	-- I doubt you'll outmaneuver all this lot.
	{ Cue = "/VO/Intercom_1138" },
	-- Longing for the bitter taste of onion, boy?
	{ Cue = "/VO/Intercom_1139", RequiredCodexEntry = { EntryName = "RoomRewardConsolationPrize", EntryIndex = 1, }, },
	-- One false move is all it takes here, boy.	
	{ Cue = "/VO/Intercom_1140" },
}
GlobalVoiceLines.PerfectClearEncounterFailedVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 1.25,
	NoTarget = true,
	CooldownTime = 200,

	-- As expected.
	{ Cue = "/VO/Intercom_0304", RequiredFalseTextLines = { "Ending01" }, },
	-- Another failure.
	{ Cue = "/VO/Intercom_0305", RequiredFalseTextLines = { "Ending01" }, },
	-- Oh, too bad.
	{ Cue = "/VO/Intercom_0306" },
	-- You've always been slow, boy.
	{ Cue = "/VO/Intercom_0307", RequiredFalseTextLines = { "Ending01" }, },
	-- You failed.
	{ Cue = "/VO/Intercom_0308" },
	-- I knew you couldn't do it.
	{ Cue = "/VO/Intercom_0309", RequiredFalseTextLines = { "Ending01" }, },
	-- Predictable.
	{ Cue = "/VO/Intercom_0310" },
	-- Laughable.
	{ Cue = "/VO/Intercom_0311", RequiredFalseTextLines = { "Ending01" }, },
	-- Aww.
	{ Cue = "/VO/Intercom_0312" },
	-- Not quite nimble enough.
	{ Cue = "/VO/Intercom_1141", RequiredTextLines = { "Ending01" }, },
	-- I was more spry than that when I was young.
	{ Cue = "/VO/Intercom_1142", RequiredTextLines = { "Ending01" }, },
	-- Too slow!
	{ Cue = "/VO/Intercom_1143" },
	-- An onion you shall have!
	{ Cue = "/VO/Intercom_1144", RequiredCodexEntry = { EntryName = "RoomRewardConsolationPrize", EntryIndex = 1, }, },
	-- Fell short of expectations.
	{ Cue = "/VO/Intercom_1145", RequiredTextLines = { "Ending01" }, },
	-- A failed attempt.
	{ Cue = "/VO/Intercom_1146" },
	-- You could do better than that.
	{ Cue = "/VO/Intercom_1147", RequiredTextLines = { "Ending01" }, },
}
GlobalVoiceLines.PerfectClearEncounterQuicklyFailedVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 1.25,
	NoTarget = true,
	CooldownTime = 200,

	-- Hah, already?
	{ Cue = "/VO/Intercom_0851" },
	-- Pah, haha.
	{ Cue = "/VO/Intercom_0852", RequiredPlayed = { "/VO/Intercom_0851" }, },
	-- Ah, too bad.
	{ Cue = "/VO/Intercom_0853", RequiredPlayed = { "/VO/Intercom_0851" }, },
	-- You already failed?
	{ Cue = "/VO/Intercom_0854", RequiredPlayed = { "/VO/Intercom_0851" }, RequiredFalseTextLines = { "Ending01" }, },
	-- Well that was quick.
	{ Cue = "/VO/Intercom_0855", RequiredPlayed = { "/VO/Intercom_0851" }, },
	-- Already?
	{ Cue = "/VO/Intercom_0856", RequiredPlayed = { "/VO/Intercom_0851" }, },
	-- Hah, haha.
	{ Cue = "/VO/Intercom_0857", RequiredPlayed = { "/VO/Intercom_0851" }, },
	-- An immediate failure.
	{ Cue = "/VO/Intercom_0858", RequiredPlayed = { "/VO/Intercom_0851" }, },
}

GlobalVoiceLines.PerfectClearEncounterClearedVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.35,
	NoTarget = true,

	-- <Laugh>
	{ Cue = "/VO/Intercom_0301", PreLineWait = 0.3, CurrentEncounterValueTrue = "PlayerTookDamage" },
	-- <Laugh>
	{ Cue = "/VO/Intercom_0302", PreLineWait = 0.3, CurrentEncounterValueTrue = "PlayerTookDamage" },
	-- <Laugh>
	{ Cue = "/VO/Intercom_0303", PreLineWait = 0.3, CurrentEncounterValueTrue = "PlayerTookDamage" },

	-- You thank the Fates for this.
	{ Cue = "/VO/Intercom_0313", CurrentEncounterValueFalse = "PlayerTookDamage", RequiredFalseTextLines = { "Ending01" }, },
	-- Useless lot.
	{ Cue = "/VO/Intercom_0314", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- Miserable fools.
	{ Cue = "/VO/Intercom_0315", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- Mere luck is all.
	{ Cue = "/VO/Intercom_0316", CurrentEncounterValueFalse = "PlayerTookDamage", RequiredFalseTextLines = { "Ending01" }, },
	-- How fortunate for you.
	{ Cue = "/VO/Intercom_0317", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- Enough of this.
	{ Cue = "/VO/Intercom_0318", CurrentEncounterValueFalse = "PlayerTookDamage", RequiredFalseTextLines = { "Ending01" }, },
	-- Grr...
	{ Cue = "/VO/Intercom_0319", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- <Scoff>
	{ Cue = "/VO/Intercom_0320", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- Blast.
	{ Cue = "/VO/Intercom_0321", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- Gloat all you like.
	{ Cue = "/VO/Intercom_0322", CurrentEncounterValueFalse = "PlayerTookDamage", RequiredFalseTextLines = { "Ending01" }, },
	-- Feh, the dead are useless.
	{ Cue = "/VO/Intercom_0323", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- Fine, keep your trinket, then.
	{ Cue = "/VO/Intercom_0324", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- You're quick, I'll give you that.
	{ Cue = "/VO/Intercom_1148", CurrentEncounterValueFalse = "PlayerTookDamage", RequiredTextLines = { "Ending01" }, },
	-- A perfectly good onion gone to waste!
	{ Cue = "/VO/Intercom_1149", CurrentEncounterValueFalse = "PlayerTookDamage", RequiredCodexEntry = { EntryName = "RoomRewardConsolationPrize", EntryIndex = 1, }, },
	-- Hapless wretches.
	{ Cue = "/VO/Intercom_1150", CurrentEncounterValueFalse = "PlayerTookDamage" },
	-- All right, I've seen enough.
	{ Cue = "/VO/Intercom_1151", CurrentEncounterValueFalse = "PlayerTookDamage", RequiredTextLines = { "Ending01" }, },
	-- Deft on your feet as ever.
	{ Cue = "/VO/Intercom_1152", CurrentEncounterValueFalse = "PlayerTookDamage", RequiredTextLines = { "Ending01" }, },
	-- Eluded all of them...
	{ Cue = "/VO/Intercom_1153", CurrentEncounterValueFalse = "PlayerTookDamage", RequiredTextLines = { "Ending01" }, },
}

function PerfectClearEncounterStartPresentation( eventSource )
	local encounter = eventSource

	EndMusic( MusicId, MusicName, 0.3 )
	SecretMusicPlayer( "/Music/ErebusChallengeMusic_MC" )
	SetSoundCueValue({ Names = { "Guitar", "Bass", "Drums" }, Id = SecretMusicId, Value = 1 })
	-- SetSoundCueValue({ Names = { "Section", }, Id = SecretMusicId, Value = 2 })

	SurvivalEncounterStartPresentation( encounter, 0, "PerfectClear", "FullscreenAlertColorDark", "PerfectClearAboutToStartVoiceLines", "PerfectClearEncounterStartVoiceLines" )

end

function PerfectClearEncounterEndPresentation( eventSource )
	local encounter = eventSource
	EndMusic( SecretMusicId, SecretMusicName )
	SecretMusicId = nil
	SecretMusicName = nil
end

-- some of this is in StartChallengeEncounter()
function ChallengeEncounterStartPresentation( eventSource )
	local challengeEncounter = eventSource
	local challengeSwitchId = challengeEncounter.Switch.ObjectId
	SecretMusicPlayer( "/Music/MusicExploration1_MC" )
	SetSoundCueValue({ Names = { "Section", }, Id = SecretMusicId, Value = 2 })

	thread( PlayVoiceLines, GlobalVoiceLines.ChallengeSwitchActivatedLines, true )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAnger" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3" })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 0.4 }, } )

	CurrentRun.CurrentRoom.Encounter.HadesDeathTaunt = true

	SurvivalEncounterStartPresentation( challengeEncounter, 0 )
	thread( TrackChallengeProgress, challengeEncounter )
end

function TrackChallengeProgress( challengeEncounter )
	local notifyName = "RequiredKillEnemyKilledOrSpawned"

	wait( 3.0, RoomThreadName )
	local remainingEnemies = math.ceil(GetRemainingSpawns( CurrentRun, CurrentRun.CurrentRoom, challengeEncounter ) + TableLength( RequiredKillEnemies ))
	if remainingEnemies <= 10 then
		UpdateObjectiveDescription("TimeChallenge", "Objective_TimeChallengeRemaining", "RemainingEnemies", remainingEnemies)
		UpdateObjective( "TimeChallenge", "RemainingEnemies", remainingEnemies )
	end

	local lastRemainingEnemies = remainingEnemies
	while not challengeEncounter.Completed do
		waitUntil( notifyName, RoomThreadName )
		lastRemainingEnemies = remainingEnemies
		remainingEnemies = math.ceil(GetRemainingSpawns( CurrentRun, CurrentRun.CurrentRoom, challengeEncounter ) + TableLength( RequiredKillEnemies ))
		if CurrentRun.CurrentRoom.ProjectilesCarryingSpawns ~= nil then
			remainingEnemies = remainingEnemies + CurrentRun.CurrentRoom.ProjectilesCarryingSpawns
		end
		if remainingEnemies == 10 then
			UpdateObjectiveDescription( "TimeChallenge", "Objective_TimeChallengeRemaining", "RemainingEnemies", remainingEnemies )
		end
		if remainingEnemies <= 10 then
			UpdateObjective( "TimeChallenge", "RemainingEnemies", remainingEnemies, {Pulse = lastRemainingEnemies ~= remainingEnemies} )
		end
	end
end

function ChallengeEncounterEndPresentation( eventSource )

	thread( PlayVoiceLines, GlobalVoiceLines.SurvivalResolvedVoiceLines, true )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })

	EndMusic( SecretMusicId, SecretMusicName )
	SecretMusicId = nil
	SecretMusicName = nil

	thread( HadesSpeakingPresentation, eventSource, { VoiceLines = GlobalVoiceLines.SurvivalEncounterSurvivedVoiceLines } )
	thread( ResumeMusic, 0.2, 3.0 )
	wait(3.0, RoomThreadName)

end

function HadesSpeakingPresentation( eventSource, args )

	wait( args.StartDelay, RoomThreadName )

	eventSource.SubtitleColor = eventSource.SubtitleColor or Color.HadesVoice
	PlayVoiceLines( args.VoiceLines, false, eventSource, { OnPlayedSomethingFunctionName = "DoHadesSpeakingPresentation", OnPlayedSomethingFunctionArgs = args } )

end

function DoHadesSpeakingPresentation( eventSource, args )

	AdjustColorGrading({ Name = args.ColorGrade or "Alert", Duration = 0 })
	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Scripting", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "FullscreenAlertColor", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	if not args.BlockScreenshake then
		ShakeScreen({ Speed = 100, Distance = 2, FalloffSpeed = 2000, Duration = 0.3 })
	end

	local hadesOverlay = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX - 420, Y = ScreenCenterY, Group = "Overlay" })
	SetScale({ Id = hadesOverlay, Fraction = 1 })
	SetAlpha({ Id = hadesOverlay, Fraction = 0.0, Duration = 0 })
	Move({ Id = hadesOverlay, Angle = 270, Speed = 5 })
	SetAnimation({ Name = args.OverlayAnim or "HadesOverlay", DestinationId = hadesOverlay })
	if not CurrentRun.CurrentRoom.BlockHadesOverlay then
		SetAlpha({ Id = hadesOverlay, Fraction = 1.0, Duration = 0 })
	end

	thread( HadesVoicelineBlur, args )
	wait( 3.0, RoomThreadName )

	AdjustFullscreenBloom({ Name = "NewType10", Duration = 1.4 })

	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = hadesOverlay, Fraction = 0.0, Duration = 1 })
	wait( 1.0, RoomThreadName )
	Destroy({ Id = hadesOverlay })
	Destroy({ Ids = { fullscreenAlertColorFx, fullscreenAlertDisplacementFx } })

end

function WrappingEncounterStartPresentation( eventSource )
	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end

	thread( HandleWrapping, eventSource )
	wait( 2.0, RoomThreadName )
	Activate({ Ids = { 548133, 548134 } })

	ShakeScreen({ Speed = 100, Distance = 2, FalloffSpeed = 2000, Duration = 3.0 })
	PlaySound({ Name = "/SFX/DeathBoatMoveStart" })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 1.0 }, } )

	wait( 3.0, RoomThreadName )
	SecretMusicPlayer( "/Music/MusicExploration2_MC" )
	SetSoundCueValue({ Names = { "Section", }, Id = SecretMusicId, Value = 2 })

	wait( 3.0, RoomThreadName )
end

function HandleWrapping( encounter )
	local wrappingData = encounter.WrappingData
	wrappingData.StartingIds = GetIds({ Name = wrappingData.StartingGroupName })
	wrappingData.EndingIds = GetIds({ Name = wrappingData.EndingGroupName })

	local offset = CalcOffset(math.rad(-155), -2000)
	Teleport({ Ids = wrappingData.EndingIds, DestinationIds = wrappingData.EndingIds, OffsetX = offset.X, OffsetY = offset.Y, ShiftThingsByOffset = true })

	wait( 3.0, RoomThreadName )

	Move({ Ids = wrappingData.StartingIds, Angle = -155, Speed = 300, EaseIn = 0.5 })
	thread( DestroyOnDelay, wrappingData.StartingIds, 5.0 )

	for k, obstacleWrapData in pairs( wrappingData.ObstacleWrapData ) do
		if obstacleWrapData.Destroy then
			Destroy({ Ids = obstacleWrapData.Ids })
		else
			if (obstacleWrapData.FirstWrapDelay or 0) == 0 then
				Move({ Ids = obstacleWrapData.Ids, Angle = -155, Speed = 500, EaseIn = 0.5 })
			end
			for k, id in pairs( obstacleWrapData.Ids ) do
				offset = CalcOffset(math.rad(-155), obstacleWrapData.ResetOffsetDistance)
				local resetTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = id, OffsetX = offset.X, OffsetY = offset.Y })
				thread( WrapObstacle, id, obstacleWrapData, 24, encounter, resetTargetId, 0 )
			end
		end
	end
end

function WrapObstacle( id, obstacleWrapData, repeatDelay, encounter, resetTargetId, wrapCount )
	
	local moveTime = obstacleWrapData.MoveTime
	if wrapCount == 0 then
		wait( obstacleWrapData.FirstWrapDelay, RoomThreadName )
		moveTime = obstacleWrapData.FirstMoveTime or moveTime
		repeatDelay = obstacleWrapData.FirstRepeatDelay or repeatDelay
	end

	if not encounter.InProgress then
		return
	end	
	-- Get in position right before platform
	if obstacleWrapData.FirstTeleport or wrapCount > 0 then
		Teleport({ Id = id, DestinationId = resetTargetId })
		--DebugPrint({ Text = "Teleport: "..obstacleWrapData.Name })
	end
	Move({ Id = id, Angle = -155, Speed = 500 })
	wait( moveTime, RoomThreadName )

	Stop({ Id = id })
	if not encounter.InProgress then
		return
	end
	wait( repeatDelay - moveTime, RoomThreadName )

	thread( WrapObstacle, id, obstacleWrapData, 24, encounter, resetTargetId, wrapCount + 1 )

end

function WrappingEncounterEndPresentation( eventSource )
	ShakeScreen({ Speed = 100, Distance = 2, FalloffSpeed = 2000, Duration = 4.0 })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.17, Duration = 1.0 }, } )
	PlaySound({ Name = "/Leftovers/SFX/AnnouncementThunder" })
	PlaySound({ Name = "/SFX/PillarDestroyed" })

	SetSoundCueValue({ Names = { "Section", }, Id = SecretMusicId, Value = 10 })
	SecretMusicId = nil
	SecretMusicName = nil

	local wrappingData = eventSource.WrappingData
	for k, obstacleWrapData in pairs( wrappingData.ObstacleWrapData ) do
		Move({ Ids = obstacleWrapData.Ids, Angle = -155, Speed = 300, Distance = 900 })
	end

	for k, id in pairs(wrappingData.EndingIds) do
		local offset = CalcOffset(math.rad(-155), 2000)
		Move({ Id = id, DestinationId = id, OffsetX = offset.X, OffsetY = offset.Y, Duration = 3.0, EaseOut = 0.999 })
	end

	wait( 2.8, RoomThreadName )
	PlaySound({ Name = "/SFX/PillarDestroyed" })
	ShakeScreen({ Speed = 100, Distance = 2, FalloffSpeed = 2000, Duration = 1.0 })

	Destroy({ Ids = GetIds({ Name = "WaterEndingObjectsDestroy" }) })

	wait( 0.7, RoomThreadName )
	SetAnimation({ DestinationId = 548134, Name = "MurderBoatGateReverse" })
end

function WrappingPostCombatReloadPresentation( eventSource )
	local encounter = eventSource.Encounter
	Destroy({ Ids = GetIds({ Name = encounter.WrappingData.StartingGroupName }) })
end

function MiniBossRoomPresentation( eventSource, args )
	AdjustColorGrading({ Name = "Team10", Duration = 0.1 })
	wait(0.8)
	AdjustColorGrading({ Name = "Off", Duration = 1.0 })
end

function DeathPresentation( currentRun, killer, killingUnitWeapon )

	AddInputBlock({ Name = "DeathPresentation" })
	ClearCameraClamp({ LerpTime = 0.4 })
	PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 0.4 })
	FocusCamera({ Fraction = 1.1, Duration = 0.4 })
	ZeroMouseTether("DeathPresentation")
	DisableCombatControls()
	DestroyCombatUI( "Death" )
	ClearStoredAmmoHero()
	SetConfigOption({ Name = "UseOcclusion", Value = false })

	if IsScreenOpen("Codex") then
		CloseCodexScreen()
	end

	-- had to move this above CleanUpEnemies() for the RequiredKillEnemies check to work
	local deathPresentation = 0
	if CurrentRun.CurrentRoom.Encounter ~= nil then
		if CurrentRun.CurrentRoom.Encounter.HadesDeathTaunt then
			-- Hades Death Taunt
			deathPresentation = 1
		elseif CurrentRun.CurrentRoom.Encounter.SpurnedGodName ~= nil and not IsEmpty( RequiredKillEnemies ) then
			-- Olympian Death Taunt
			deathPresentation = 2
		elseif CurrentRun.CurrentRoom.Encounter.ThanatosId ~= nil and not not IsEmpty( RequiredKillEnemies ) then
			-- Thanatos Death Taunt
			deathPresentation = 3
		elseif CurrentRun.CurrentRoom.Encounter.TookChaosCurseDamage ~= nil and not IsEmpty( RequiredKillEnemies ) then
			-- Chaos Death Taunt
			deathPresentation = 4
		end
	end

	CleanupEnemies()
	ExpireProjectiles({ })
	ClearEffect({ Id = killer.ObjectId, All = true, BlockAll = true })
	SetThingProperty({ Property = "AllowAnyFire", Value = false, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	StopAmbientSound({ All = true })
	StopSound({ Id = SecretMusicId, Duration = 0.25 })
	SecretMusicId = nil
	SecretMusicName = nil

	Stop({ Id = currentRun.Hero.ObjectId })
	Halt({ Id = currentRun.Hero.ObjectId })
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, DataValue = false, DestinationNames = { "GroundEnemies", "FlyingEnemies" } })

	RemoveFromGroup({ Id = killer.ObjectId, Names = { "Standing", "GroundEnemies", "FlyingEnemies" } })
	AddToGroup({ Id = killer.ObjectId, Name = "Combat_Menu", DrawGroup = true })

	if currentRun.Hero.AttachedAnimationName ~= nil then
		StopAnimation({ Name = currentRun.Hero.AttachedAnimationName, DestinationId = currentRun.Hero.ObjectId })
	end

	if currentRun.Hero.HitShields ~= nil and currentRun.Hero.HitShields > 0 then
		CurrentRun.Hero.HitShields = 0
		for i, traitData in pairs(currentRun.Hero.Traits) do
			if traitData.BossEncounterShieldHits then
				UpdateTraitNumber( traitData )
			end
		end
	end

	currentRun.Hero.Mute = false
	SetPlayerInvulnerable( "PlayerDeath" )
	PlaySound({ Name = "/SFX/Player Sounds/PlayerDeath" })

	thread( PlayVoiceLines, GlobalVoiceLines.DeathVoiceLines )

	if killer.CauseOfDeathVoiceLines ~= nil then
		thread( PlayVoiceLines, killer.CauseOfDeathVoiceLines, nil, killer )
	elseif currentRun.CurrentRoom.Encounter.CauseOfDeathVoiceLines ~= nil then
		thread( PlayVoiceLines, currentRun.CurrentRoom.Encounter.CauseOfDeathVoiceLines )
	elseif currentRun.CurrentRoom.CauseOfDeathVoiceLines ~= nil then
		thread( PlayVoiceLines, currentRun.CurrentRoom.CauseOfDeathVoiceLines )
	end

	-- black out world
	StopAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "HadesReverseDarknessVignetteHold" })
	StopAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "HadesReverseDarknessGroundFog" })
	AdjustFrame({ Color = Color.TransparentRed, Duration = 0.0, Fraction = 0 })
	ScreenAnchors.DeathBackground = CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = ScreenAnchors.DeathBackground, Fraction = 10 })
	SetColor({ Id = ScreenAnchors.DeathBackground, Color = Color.Black })
	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 1.0, Duration = 0 })

	RemoveFromGroup({ Id = currentRun.Hero.ObjectId, Name = "Standing" })
	thread( DoRumble, currentRun.Hero.HeroFinalHitRumbleParameters )

	wait( 0.15 )
	SetAlpha({ Id = killer.ObjectId, Fraction = 0, Duration = 0.3 })

	if CurrentRun.Cleared then
		thread( DisplayLocationText, nil, { Text = "OutroDeathMessageAlt", Delay = 0.95, Color = Color.Red, Layer = "Overlay", AnimationName = "LocationTextBGDeath", AnimationOutName = "LocationTextBGDeathOut", ThreadName = "Outro", Duration = 4.25 } )
	else
		thread( DisplayLocationText, nil, { Text = "DeathMessage", Delay = 0.95, Color = Color.Red, Layer = "Overlay", AnimationName = "LocationTextBGDeath", AnimationOutName = "LocationTextBGDeathOut" } )
	end

	local criticalSlowHoldTime = 0
	FocusCamera({ Fraction = 1.0, Duration = 0.3, ZoomType = "Ease" })
	SetThingProperty({ Property = "Grip", Value = 99999, DestinationId = CurrentRun.Hero.ObjectId })
	SetThingProperty({ Property = "Graphic", Value = "ZagreusOnHitFinal", DestinationId = CurrentRun.Hero.ObjectId })
	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 1.65, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Red, Duration = 0.15, ExpireAfterCycle = true })
	thread( DeathFrameHold )

	for k, simData in ipairs( CurrentRun.Hero.FinalHitSlowParameters ) do
		if( damageVulnerability or damageCrit ) then
			if( k == 2) then
				criticalSlowHoldTime = 0.04
			end
		end
		waitScreenTime( simData.ScreenPreWait + criticalSlowHoldTime )
		if simData.Fraction < 1.0 then
			AddSimSpeedChange( "Death", { Fraction = simData.Fraction, LerpTime = simData.LerpTime } )
		else
			RemoveSimSpeedChange( "Death", { LerpTime = simData.LerpTime } )
		end
	end
	wait(0.15)
	SetThingProperty({ Property = "Grip", Value = "Default", DestinationId = CurrentRun.Hero.ObjectId })
	StopFlashing({ Id = CurrentRun.Hero.ObjectId })
	local zagreusDeathFlash = CreateScreenComponent({ Name = "rectangle01", Group = "Overlay" })
	SetAnimation({ DestinationId = zagreusDeathFlash.Id, Name = "ZagreusDeathFlash" })

	local deathAnimation = "ZagreusDeathFullscreen"
	if CurrentRun.Cleared then
		deathAnimation = "ZagreusDeathPostEndingFullscreen"
	end
	SetThingProperty({ Property = "Graphic", Value = deathAnimation, DestinationId = currentRun.Hero.ObjectId })

	wait( 0.3 )
	Teleport({ Id = killer.ObjectId, OffsetX = 0, OffsetY = 0 })
	ClearLootDrops( killer )
	Destroy({ Id = zagreusDeathFlash.Id })

	wait(0.55)
	if CurrentRun.Cleared then
		PlaySound({ Name = "/Music/HadesThemeStingerINTENSE" })
	else
		PlaySound({ Name = "/Music/HadesThemeStinger" })
	end

	if ConfigOptionCache.EasyMode and not currentRun.Cleared then
		thread( EasyModeLevelUpPresentation )
		wait( 3.0 )
	end

	if deathPresentation == 1 then
		-- Hades Death Taunt
		thread( HadesSpeakingPresentation, {}, { BlockScreenshake = true, VoiceLines = GlobalVoiceLines.HadesDeathTauntVoiceLines } )
	elseif deathPresentation == 2 then
		-- Olympian Death Taunt
		local spurnedGodName = CurrentRun.CurrentRoom.Encounter.SpurnedGodName
		local spurnedGodData = LootData[spurnedGodName]
		thread( HadesSpeakingPresentation, { SubtitleColor = spurnedGodData.SubtitleColor }, { OverlayAnim = spurnedGodData.OverlayAnim, BlockScreenshake = true, VoiceLines = spurnedGodData.DeathTauntVoiceLines } )
	elseif deathPresentation == 3 then
		-- Thanatos Death Taunt
		thread( HadesSpeakingPresentation, ActiveEnemies[ThanatosId] or { SubtitleColor = Color.ThanatosVoice }, { OverlayAnim = "ThanatosOverlay", BlockScreenshake = true, VoiceLines = GlobalVoiceLines.ThanatosDeathTauntVoiceLines } )
	elseif deathPresentation == 4 then
		-- Chaos Death Taunt
		thread( HadesSpeakingPresentation, { SubtitleColor = LootData.TrialUpgrade.SubtitleColor }, { OverlayAnim = "ChaosOverlay", BlockScreenshake = true, VoiceLines = LootData.TrialUpgrade.DeathTauntVoiceLines } )
	end

	for index, requirements in pairs(GameData.FlashbackRequirements) do
		if IsGameStateEligible( CurrentRun, requirements ) then
			GameState.Flags.AllowFlashback = true
		end
	end

	wait(7.2)

	SetThingProperty({ Property = "AllowAnyFire", Value = true, DestinationId = CurrentRun.Hero.ObjectId, DataValue = false })
	RemoveInputBlock({ Name = "DeathPresentation" })
	UnblockCombatUI("Death")
	SetConfigOption({ Name = "UseOcclusion", Value = true })
end

-- ending
GlobalVoiceLines.EndingDeathVoiceLines =
{
	{
		SkipAnim = true,
		NoTarget = true,
		RandomRemaining = true,
		PreLineWait = 6,

		-- Urgh... can't... hold... on...
		{ Cue = "/VO/ZagreusField_4646" },
		-- Grr... I... can't...
		{ Cue = "/VO/ZagreusField_4647" },
		-- Won't... go... back...!
		{ Cue = "/VO/ZagreusField_4648" },
		-- No... not... yet...
		{ Cue = "/VO/ZagreusField_4649" },
		-- I'll... be... back...
		{ Cue = "/VO/ZagreusField_4650" },
		-- Urgh... mmm... ungh...
		{ Cue = "/VO/ZagreusField_4651" },
		-- Khh... uhhh... urgh...
		{ Cue = "/VO/ZagreusField_4652" },
		-- Mmph... rrkh... ungh...
		{ Cue = "/VO/ZagreusField_4653" },
	},
}
function SurfaceDeathPresentation( currentRun )

	AddInputBlock({ Name = "DeathPresentation" })
	ClearCameraClamp({ LerpTime = 1.5 })
	PanCamera({ Id = currentRun.Hero.ObjectId, Duration = 1.5, })
	FocusCamera({ Fraction = 1.1, Duration = 1.5, ZoomType = "Ease" })
	ZeroMouseTether("DeathPresentation")
	DisableCombatControls()
	UnblockCombatUI("Surface")
	DestroyCombatUI( "Death" )
	ClearStoredAmmoHero()
	SetConfigOption({ Name = "UseOcclusion", Value = false })

	StopAmbientSound({ All = true })

	Stop({ Id = currentRun.Hero.ObjectId })
	Halt({ Id = currentRun.Hero.ObjectId })

	currentRun.Hero.Mute = false
	SetPlayerInvulnerable( "PlayerDeath" )
	-- PlaySound({ Name = "/SFX/Player Sounds/PlayerDeath" })

	-- thread( PlayVoiceLines, GlobalVoiceLines.EndingDeathVoiceLines )

	-- black out world
	AdjustFrame({ Color = Color.TransparentRed, Duration = 0.0, Fraction = 0 })
	ScreenAnchors.DeathBackground = CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = ScreenAnchors.DeathBackground, Fraction = 10 })
	SetColor({ Id = ScreenAnchors.DeathBackground, Color = Color.Black })
	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 0, Duration = 0 })
	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 1.0, Duration = 0.3 })

	RemoveFromGroup({ Id = currentRun.Hero.ObjectId, Name = "Standing" })
	thread( DoRumble, currentRun.Hero.HeroSurfaceDeathRumbleParameters )

	--Flash({ Id = currentRun.Hero.ObjectId, Speed = 4, MinFraction = 1.0, MaxFraction = 1.0, Color = Color.Red, Duration = 0.15 })
	--SetGoalAngle({ Id = currentRun.Hero.ObjectId, Angle = 200, CompleteAngle = true }) -- this was causing a snap
	local deathAngleFace = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = currentRun.Hero.ObjectId, OffsetX = -200, OffsetY = 100 })	
	wait( 0.02 )
	AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = deathAngleFace })
	wait( 0.08 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })

	SetThingProperty({ Property = "Graphic", Value = "ZagreusInjured_SickStanding_ToDeath", DestinationId = currentRun.Hero.ObjectId })

    -- local criticalSlowHoldTime = 0
	-- FocusCamera({ Fraction = 1.0, Duration = 0.3, ZoomType = "Ease" })
	-- SetThingProperty({ Property = "Grip", Value = 99999, DestinationId = CurrentRun.Hero.ObjectId })
	-- SetThingProperty({ Property = "Graphic", Value = "ZagreusOnHitFinal", DestinationId = CurrentRun.Hero.ObjectId })
	-- Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 1.65, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Red, Duration = 0.15, ExpireAfterCycle = true })
	-- thread( DeathFrameHold )

	--[[
	for k, simData in ipairs( CurrentRun.Hero.FinalHitSlowParameters ) do
		if( damageVulnerability or damageCrit ) then
			if( k == 2) then
				criticalSlowHoldTime = 0.04
			end
		end
		waitScreenTime( simData.ScreenPreWait + criticalSlowHoldTime )
		if simData.Fraction < 1.0 then
			AddSimSpeedChange( "Death", { Fraction = simData.Fraction, LerpTime = simData.LerpTime } )
		else
			RemoveSimSpeedChange( "Death", { LerpTime = simData.LerpTime } )
		end
	end
	]]
	wait(0.15)

	--SetThingProperty({ Property = "Grip", Value = "Default", DestinationId = CurrentRun.Hero.ObjectId })
	-- StopFlashing({ Id = CurrentRun.Hero.ObjectId })
	-- local zagreusDeathFlash = CreateScreenComponent({ Name = "rectangle01", Group = "Overlay" })
	-- SetAnimation({ DestinationId = zagreusDeathFlash.Id, Name = "ZagreusDeathFlash" })
	
	thread( DisplayLocationText, nil, { Text = "OutroDeathMessageAlt", Delay = 1.15, Color = Color.Red, Layer = "Overlay", AnimationName = "LocationTextBGDeath", AnimationOutName = "LocationTextBGDeathOut", Duration = 4.25 } )


	wait( 0.3 )
	-- Destroy({ Id = zagreusDeathFlash.Id })

	wait(0.55)

	local ambientSoundId = PlaySound({ Name = "/Leftovers/Object Ambiences/WaterRushingBloodFall" })

	for index, requirements in pairs(GameData.FlashbackRequirements) do
		if IsGameStateEligible( CurrentRun, requirements ) then
			GameState.Flags.AllowFlashback = true
		end
	end

	wait(11.8)

	StopSound({ Id = ambientSoundId, Duration = 4 })

	RemoveInputBlock({ Name = "DeathPresentation" })
	UnblockCombatUI("Death")
	SetConfigOption({ Name = "UseOcclusion", Value = true })

end

function EasyModeLevelUpPresentation()

	wait( 3.9, RoomThreadName )

	local prevResistance = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel - 1 ) ) * 100 )
	local resistance = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel ) ) * 100 )
	DisplayUnlockText( {
		--SupertitleText = "EasyModeUpgradedSupertitle",
		TitleText = "EasyModeUpgradedTitle",
		SubtitleText = "EasyModeLevelUp",
		TextRevealSound = "/Leftovers/Menu Sounds/TextReveal2",
		Color = {0, 255, 168, 255},
		--SupertitleTextColor = {190, 190, 190, 255},
		--SupertitleTextDelay = 1.0,
		TextColor = Color.White,
		SubTextColor = {23, 255, 187, 255},
		Icon = "EasyModeIcon",
		IconOffsetY = 10,
		Duration = 4.35,
		IconMoveSpeed = 0.00001,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		--SupertitleFont = "AlegreyaSansSCRegular",
		Layer = "Overlay",
		AdditionalAnimation = "GodHoodRays",
		AnimationName = "LocationTextBGGeneric_GodHood",
		AnimationOutName = "LocationTextBGGenericOut_GodHood",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = { Resistance = prevResistance }, LuaValueUpdate = { Resistance = "{#HighlightFormatGraft}" .. resistance}, UpdateDelay = 1.25, },
		} )

end

function EasyModeEnabledPresentation()
	local resistance = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel ) ) * 100 )
	wait(0.4)
	-- PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonChoiceConfirm" })
	wait( 0.02 )
	ShakeScreen({ Speed = 1000, Distance = 2, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.3, Duration = 0.3 }, } )
	AdjustColorGrading({ Name = "ItemGet", Duration = 0.2 })
	SetAnimation({ Name = "ZagreusLanding", DestinationId = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "ItemGet", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	CreateAnimation({ Name = "ItemGetVignette", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	wait( 0.25 )
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })
	if ConfigOptionCache.EasyMode then
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "EasyModeEnabled", Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Resistance = resistance }, ShadowScaleX = 1.25 } )
	end
end

function EasyModeDisabledPresentation()
	local resistance = round( (1.0 - CalcEasyModeMultiplier( GameState.EasyModeLevel ) ) * 100 )
	wait(0.4)
	-- PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteDepressed" })
	if not ConfigOptionCache.EasyMode then
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "EasyModeDisabled", Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Resistance = resistance }, ShadowScaleX = 1.25 } )
	end
end

function DeathFrameHold()
	waitScreenTime( 0.4 )
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 0.0, DataValue = false, DestinationNames = { "HeroTeam" } })
	waitScreenTime( 0.3 )
	SetThingProperty({ Property = "ElapsedTimeMultiplier", Value = 1.0, DataValue = false, DestinationNames = { "HeroTeam" } })
end

function StartDeathLoopPresentation( currentRun )

	AddInputBlock({ Name = "DeathWalkBlock" })
	ZeroMouseTether("DeathPresentation")
	TeleportCursor({ OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })

	-- unit
	local initialSpeed = GetUnitDataValue({ Id = currentRun.Hero.ObjectId, Property = "Speed", Destination})
	SetUnitProperty({ Property = "Speed", Value = 0, DestinationId = currentRun.Hero.ObjectId })
	SetGoalAngle({ Id = currentRun.Hero.ObjectId, Angle = 45 })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = false, DestinationId = currentRun.Hero.ObjectId })

	PanCamera({ Id = 391310, Duration = 0.01 })
	AdjustZoom({ Fraction = 1.0 })
	local cameraClamps = CurrentDeathAreaRoom.CameraClamps or GetDefaultClampIds()
	DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is non-sensical" })

	SetSoundCueValue({ Names = { "Drums" }, Id = MusicId, Value = 0 })

	wait(0.1)
	FadeIn({ Duration = 0.5 })
	SetAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "Blank" })

	-- audio
	local prevRoom = GetPreviousRoom( currentRun )
	if prevRoom == nil or not prevRoom.SkipEnteredDeathAreaVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines.EnteredDeathAreaVoiceLines )
	end
	SetAudioEffectState({ Name = "Reverb", Value = 1.0 })
	StartRoomAmbience( currentRun, CurrentDeathAreaRoom )
	StartCustomDeathAreaAmbience()

	local heroDestination = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = currentRun.Hero.ObjectId, OffsetX = 400, OffsetY = -260 })
	PanCamera({ Id = 391309, Duration = 6.0, EaseOut = 1.0 })

	if GetCompletedRuns() <= 1 then
		wait(1.0)
	else
		wait(0.7)
	end

	AdjustZoom({ Fraction = CurrentDeathAreaRoom.ZoomFraction or 1.0, LerpTime = CurrentDeathAreaRoom.ZoomLerpTime })

	SetAnimation({ DestinationId = currentRun.Hero.ObjectId, Name = "ZagreusDeadWalk" })
	SetUnitProperty({ Property = "Speed", Value = 95, DestinationId = currentRun.Hero.ObjectId })

	Move({ Id = currentRun.Hero.ObjectId, DestinationId = heroDestination, Mode = "Precise" })
	ToggleControl({ Names = { "Rush" }, Enabled = true })

	local notifyName = "DashToSkip"

	NotifyOnControlPressed({ Names = { "Rush" }, Notify = notifyName, Timeout = 5.22 })
	waitUntil( notifyName )
	if not _eventTimeoutRecord[notifyName] then
		Stop({ Id = currentRun.Hero.ObjectId })
		FireWeaponFromUnit({ Weapon = "RushWeapon", Id = currentRun.Hero.ObjectId })
		CreateAnimation({ Name = "BloodPoolSkipSplash", DestinationId = CurrentRun.Hero.ObjectId })
		CreateAnimation({ Name = "DeathAreaBloodSplashStairs", DestinationId = 423935 })
		-- Finish pan quickly
		PanCamera({ Id = 391309, Duration = 0.74, Retarget = true, FromCurrentLocation = true })
		wait(0.22)
	else
		DebugPrint({ Text = "Zag Arrived" })
		Stop({ Id = currentRun.Hero.ObjectId })
		wait(0.74)
	end
	DebugPrint({ Text = "Input Restored" })
	RemoveInputBlock({ Name = "DeathWalkBlock" })

	SetUnitProperty({ Property = "Speed", Value = initialSpeed, DestinationId = currentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = true, DestinationId = currentRun.Hero.ObjectId })
	UnzeroMouseTether( "DeathPresentation" )
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = 0.8 })
	if CurrentDeathAreaRoom.CameraWalls then
		CreateCameraWalls({ })
	end

	thread( DisplayLocationText, nil, { Text = "Location_Home", Delay = 0.65, Color = Color.White, FadeColor = Color.Red } )
	thread( CheckLocationUnlock, nil, { Biome = "DeathArea", CheckPlayerUnitEntry = true } )

	-- Early Access
	--[[
	if GetConfigOptionValue({ Name = "KioskMode" }) and GetCompletedRuns() + 1 >= GetConfigOptionValue({ Name = "KioskModeNumLives" }) then
		-- Demo end
		PlaySound({ Name = "/Music/VictoryStinger" })
		OpenMenu({ Name = "AnnouncementScreen", MessageId = "KioskModeEnd" })
	elseif currentRun.Cleared then
		-- if you cleared the run successfully
		PlaySound({ Name = "/Music/VictoryStinger" })
		if GameState.Flags.HardMode then
			OpenMenu({ Name = "AnnouncementScreen", MessageId = "RunCleared_Message02" })
		else
			OpenMenu({ Name = "AnnouncementScreen", MessageId = "RunCleared_Message01" })
		end
	end
	]]--

end

-- ending (from here down)
function StartDeathLoopFromBoatPresentation( currentRun )
	AddInputBlock({ Name = "DeathWalkBlock" })
	ZeroMouseTether("DeathPresentation")
	TeleportCursor({ OffsetX = ScreenCenterX, OffsetY = ScreenCenterY })

	local zagStartId = 555661
	local persephoneId = 555688

	PanCamera({ Id = 555661, Duration = 0.01 })
	AdjustZoom({ Fraction = 1.0 })
	-- AdjustZoom({ Fraction = 0.75, LerpTime = 3 })

	local cameraClamps = CurrentDeathAreaRoom.CameraClamps or GetDefaultClampIds()
	DebugAssert({ Condition = #cameraClamps ~= 1, Text = "Exactly one camera clamp on a map is non-sensical" })

	Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = zagStartId })
	AngleTowardTarget({ Id = currentRun.Hero.ObjectId, DestinationId = persephoneId })
	AngleTowardTarget({ Id = persephoneId, DestinationId = currentRun.Hero.ObjectId })

	wait(0.1)
	FadeIn({ Duration = 0.5 })

	DebugPrint({ Text = "Input Restored" })
	RemoveInputBlock({ Name = "DeathWalkBlock" })

	--SetUnitProperty({ Property = "Speed", Value = initialSpeed, DestinationId = currentRun.Hero.ObjectId })
	--SetUnitProperty({ Property = "CollideWithObstacles", Value = true, DestinationId = currentRun.Hero.ObjectId })
	UnzeroMouseTether( "DeathPresentation" )
	SetCameraClamp({ Ids = cameraClamps, SoftClamp = 0.8 })
end

GlobalVoiceLines.SurfaceBoatSightedVoiceLines =
{
	{
		PreLineWait = 2.35,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,

		-- Charon?!
		{ Cue = "/VO/ZagreusField_3672" },
	},
	{
		ObjectType = "NPC_Charon_01",
		AllowTalkOverTextLines = true,
		PreLineAnim = "Charon_IdleGreeting",

		-- Haaahhhhh....
		{ Cue = "/VO/Charon_0010" },
	},
}
function SurfaceBoatScenePan( eventSource )

	local zagreusId = CurrentRun.Hero.ObjectId
	local persephoneId = 559274
	local charonId = 559285
	local boatId = 559284

	ActivatePrePlacedUnits( eventSource, { Ids = { 559285 }, CheckConversations = false } )
	SetAnimation({ DestinationId = 559285, Name = "Charon_IdleShop" })

	--PlaySound({ Name = "/SFX/Enemy Sounds/EnemyActivationSpawnSeal", Id = charonId })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/NauticalBellCharon", Id = charonBoatId })
	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 0.0, Duration = 0.5 })

	PanCamera({ Id = 560953, Duration = 13.0, OffsetX = -500, OffsetY = -60 })
	FocusCamera({ Fraction = 1.0, Duration = 13.0 })

	wait( 1.0 )
	PlaySound({ Name = "/Leftovers/World Sounds/BigSplash", Id = charonId })
	-- AdjustZoom({ Fraction = 0.75, LerpTime = 5 })

	thread( PlayVoiceLines, GlobalVoiceLines.SurfaceBoatSightedVoiceLines )

	wait(1.5)
	AngleTowardTarget({ Id = zagreusId, DestinationId = charonId })

	wait(4.5)

	--PanCamera({ Id = zagreusId, Duration = 3 })

	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 1.0, Duration = 0.5 })

end

GlobalVoiceLines.HadesSighVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.9,
	AllowTalkOverTextLines = true,
	ObjectType = "NPC_Hades_Story_02",

	-- <Sigh>
	{ Cue = "/VO/HadesField_0617" },
}
function DoHadesSigh()
	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 0.0, Duration = 0.5 })
	thread( PlayVoiceLines, GlobalVoiceLines.HadesSighVoiceLines )
	wait( 2.0 )

	thread( MusicPlayer, "/Music/PersephoneTheme_MC" )
	SetSoundCueValue({ Names = { "Strings", "Harp", "Percussion", "Room" }, Id = MusicId, Value = 1, Duration = 0.75 })
	SetSoundCueValue({ Names = { "WoodWinds", "Trombones" }, Id = MusicId, Value = 0, Duration = 0.75 })
	-- SetVolume({ Id = MusicId, Value = 0.7 })
	wait( 3.6 )
	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 1.0, Duration = 0.5 })
end

GlobalVoiceLines.EndingReunionVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.85,
		PlayOverTextLines = true,
		ObjectType = "NPC_Persephone_01",
		AllowTalkOverTextLines = true,

		-- <Gasp> Cerberus...?
		{ Cue = "/VO/Persephone_0102" },
	},
}
function SetupEndingScene( source, args )
	StartCustomDeathAreaLoungeAmbience()
	StartRoomAmbience( CurrentRun, CurrentDeathAreaRoom )

	if args.SetClamps ~= nil then
		CurrentDeathAreaRoom.CameraClamps = args.SetClamps
	end
	if args.SetCameraZoomWeights ~= nil then
		for id, weight in pairs( args.SetCameraZoomWeights ) do
			SetCameraZoomWeight({ Id = id, Weight = weight, ZoomSpeed = 1.0 })
		end
	end
	HideCombatUI()
	LockCamera({ Id = 555661 })
end
function DisplayEndingMessage( source, args )
	wait( args.Delay or 0 )
	PlaySound({ Name = "/Music/VictoryStinger" })
	OpenMenu({ Name = "AnnouncementScreen", MessageId = args.MessageId or "KioskModeEnd" })
end
function GardenScenePan()

	local zagreusId = CurrentRun.Hero.ObjectId
	local persephoneId = 555688
	local cerberusId = 555687
	local hadesId = 555686

	HideCombatUI()

	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 0.0, Duration = 0.5 })

	PlaySound({ Name = "/VO/CerberusBarks", Id = cerberusId, Delay = 1 })

	wait(0.55)

	PanCamera({ Id = 556836, Duration = 3.0, OffsetX = -30, OffsetY = -160 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh", Delay = 0.5 })
	FocusCamera({ Fraction = 1.25, Duration = 3, ZoomType = "Ease" })
	thread( GardenSceneSecondCameraPush )
	-- AdjustZoom({ Fraction = 0.75, LerpTime = 5 })

	SetAnimation({ Name = "Hades_StandingIdle_ShameLoop", DestinationId = hadesId })

	thread( PlayVoiceLines, GlobalVoiceLines.EndingReunionVoiceLines )

	wait(1.5)

	SetAnimation({ Name = "CerberusHappyGreeting_Start", DestinationId = cerberusId })

	SecretMusicPlayer( "/Music/PersephoneTheme_MC" )
	SetSoundCueValue({ Names = { "Harp", "Strings", "WoodWinds", "Trombones", "Percussion" }, Id = SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Room" }, Id = SecretMusicId, Value = 0, Duration = 0.75 })
	SetVolume({ Id = SecretMusicId, Value = 0.8 })

	SetUnitProperty({ Property = "Speed", Value = 320, DestinationId = persephoneId })
	Move({ Id = persephoneId, DestinationId = 556839, SuccessDistance = 32, StopAtEnd = true })


	wait(1.0)

	SetUnitProperty({ Property = "StartGraphic", Value = nil, DestinationId = zagreusId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "ZagreusWalk2", DestinationId = zagreusId })
	SetUnitProperty({ Property = "StopGraphic", Value = "ZagreusWalkStop2", DestinationId = zagreusId })
	SetUnitProperty({ Property = "Speed", Value = 115, DestinationId = zagreusId })
	SetUnitProperty({ DestinationId = zagreusId, Property = "CollideWithObstacles", Value = false })
	thread( MoveHeroToRoomPosition, { DestinationId = 555690, Timeout = 9999, AngleTowardsIdOnEnd = 556841 } )

	NotifyWithinDistance({ Id = persephoneId, DestinationId = 556839, Distance = 40, Notify = "PersephoneGardenMove", Timeout = 10.0 })
	waitUntil( "PersephoneGardenMove" )

	Move({ Id = persephoneId, DestinationId = 555689, SuccessDistance = 32, StopAtEnd = true })
	thread( SlowDownPersephoneAndZagreus, persephoneId, zagreusId )
	--wait(3.4)
	NotifyWithinDistance({ Id = persephoneId, DestinationId = 555689, Distance = 40, Notify = "PersephoneGardenMove", Timeout = 10.0 })
	waitUntil( "PersephoneGardenMove" )

	Stop({ Id = persephoneId })
	AngleTowardTarget({ Id = persephoneId, DestinationId = cerberusId })

	wait(1)

	SetAlpha({ Id = ScreenAnchors.DialogueBackgroundId, Fraction = 1.0, Duration = 0.5 })

end
function PostEndingAmbience()
	AmbienceId = PlaySound({ Name = "/Ambience/MusicExploration4Ambience", Duration = 0.5 })
	StartCustomDeathAreaLoungeAmbience()
end

function SlowDownPersephoneAndZagreus( persephoneId, zagreusId )
	wait( 0.47 )
	SetUnitProperty({ Property = "Speed", Value = 175, DestinationId = persephoneId })
	SetUnitProperty({ Property = "Speed", Value = 115, DestinationId = zagreusId })
end

function GardenSceneSecondCameraPush( )
	wait( 4.0 )
	PanCamera({ Id = 556836, Duration = 12.0, OffsetX = 115, OffsetY = -10, Retarget = true })
	FocusCamera({ Fraction = 1.15, Duration = 12, ZoomType = "Ease" })
end

function SetupHadesInGarden( eventSource, args )

	args = args or {}

	ActivatePrePlaced( nil, { LegalTypes = { "NPC_Hades_Story_01" } } )

	local hadesThroneId = 370006
	local hadesGardenId = 555686

	local source = ActiveEnemies[555686]

	if args.WithPersephone then
		Teleport({ Id = hadesGardenId, DestinationId = 555689 })
	else
		Teleport({ Id = hadesGardenId, DestinationId = 556885 })
	end

	if args.UseStatusAnim then
		PlayStatusAnimation( source, { Animation = StatusAnimations.WantsToTalk } )
	end

	SetAnimation({ Name = "Hades_StandingIdle_ShameLoop", DestinationId = hadesGardenId  })
	UseableOff({ Id = hadesGardenId })

	wait( 1 )
	Teleport({ Id = hadesThroneId, DestinationId = 423389 })

end
function StopHadesInGardenStatusSpeaking( eventSource, args )
	args = args or {}
	local source = ActiveEnemies[555686]

	StopStatusAnimation( source, StatusAnimations.WantsToTalk )
end

function HadesArmsCross()
	local hadesId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationNames = { "NPC_Hades_01", "NPC_Hades_Story_01" } })
	SetAnimation({ Name = "Hades_StandingIdle_ToArmCross", DestinationId = hadesId })
end

function HadesArmsUnCross()
	local hadesId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationNames = { "NPC_Hades_01", "NPC_Hades_Story_01" } })
	SetAnimation({ Name = "Hades_StandingIdle_ToShame", DestinationId = hadesId })
end

function OpenMetaUpgradeMenuPrePresentation( menuObjectId, soundCue )
	PlaySound({ Name = soundCue or "/SFX/Menu Sounds/MirrorFlash", Id = menuObjectId })
	ZeroMouseTether("MetaupgradeMenuPresentation")

	AdjustColorGrading({ Name = "Team03", Duration = 0.3 })
	AdjustFullscreenBloom({ Name = "Default", Duration = 0.3 })
	PlayInteractAnimation( menuObjectId )
	wait( 0.12 )
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.30 })
	AdjustColorGrading({ Name = "Off", Duration = 0.30 })
end

function OpenMetaUpgradeMenuPostPresentation( menuObjectId )
	UnzeroMouseTether("MetaupgradeMenuPresentation")
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.3 })
end

function StartNewRunPresentation( currentRun )
	FadeOut({ Duration = 0.3, Color = Color.Black })
	thread( PlayVoiceLines, GlobalVoiceLines.StartNewRunVoiceLines )
	EndMusic( MusicId, MusicName, 0.5 )
	EndAmbience( 0.5 )
	wait(0.5)
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/ChestClose" })
	wait(0.5)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter" })
	wait(1.0)
end

function StartDemoPresentation()

	AddInputBlock({ Name = "StartDemoPresentation" })
	ToggleControl({ Names = { "Gift", "Emote", }, Enabled = false })
	MusicPlayer( "/Music/MainTheme" )

	HideCombatUI()

	local blackScreenId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = blackScreenId, Fraction = 10 })
	SetColor({ Id = blackScreenId, Color = Color.Black })
	SetAlpha({ Id = blackScreenId, Fraction = 1.0, Duration = 0 })

	wait(1.0)

	FadeIn({ Duration = 0 })
	local backgroundId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY })
	SetAlpha({ Id = backgroundId, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = backgroundId, Fraction = 1.0, Duration = 0.5 })
	SetAnimation({ Name = "MainMenuLoopKiosk", DestinationId = backgroundId })

	wait(2.0)

	local promptId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY + 350 })
	CreateTextBox({	Id = promptId, Text = "Menu_PressAnyButton", Justification = "CENTER",
			ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
			OutlineThickness = 1, OutlineColor = {1, 1, 1, 1},
			Font = "SpectralSCLightTitling", FontSize = "36", Color = {255,255,255,255},
			CharacterFadeTime = 0, CharacterFadeInterval = 0,
			})

	PlaySound({ Name = "/SFX/Menu Sounds/HadesLocationTextDisappear", Id = promptId })

	local notifyName = "StartDemoPressAnyButton"
	NotifyOnControlPressed({ Names = { "Confirm", "Rush", "Attack1", "Attack2", "Attack3", "Attack4", "MoveLeft", "MoveRight", "MoveUp", "MoveDown", "Interact", "Codex", "Shout", "AutoLock", }, Notify = notifyName })
	waitUntil( notifyName )

	EndMusic( MusicId, MusicName, 2.5 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3" })

	SetAlpha({ Id = backgroundId, Fraction = 0.0, Duration = 1.0 })
	ModifyTextBox({ Id = promptId, FadeTarget = 0.0, FadeDuration = 0.25, ScaleTarget = 1.2, ScaleDuration = 7 })
	wait(1.0)

	FadeOut({ Color = Color.Black, Duration = 0.5 })
	wait(1.0)

	Destroy({ Ids = { blackScreenId, backgroundId, promptId } })

	RemoveInputBlock({ Name = "StartDemoPresentation" })
	ToggleControl({ Names = { "Gift", "Emote", }, Enabled = true })

end

GlobalVoiceLines.EndDemoVoiceLines =
{
	-- Death is inescapable. If you think otherwise... why, then, don't let me stop you.
	{ Cue = "/VO/Hades_0061", PreLineWait = 1.5, NoTarget = true },
	-- Wasn't planning on it.
	{ Cue = "/VO/ZagreusField_0002b", PreLineWait = 0.35, NoTarget = true },
}

function EndDemoPresentation()

	EndMusic( MusicId, MusicName, 1.0 )
	StopSound({ Id = AmbienceId, Duration = 1.0 })

	AddInputBlock({ Name = "EndDemoPresentation" })
	FreezePlayerUnit( "EndDemoPresentation" )
	HideCombatUI()

	local blackScreenId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = blackScreenId, Fraction = 10 })
	SetColor({ Id = blackScreenId, Color = Color.Black })
	SetAlpha({ Id = blackScreenId, Fraction = 1.0, Duration = 0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3", Delay = 0.25 })

	thread( PlayVoiceLines, GlobalVoiceLines.EndDemoVoiceLines )

	wait(9.25)

	FadeIn({ Duration = 0 })
	local backgroundId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY })
	SetAlpha({ Id = backgroundId, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = backgroundId, Fraction = 1.0, Duration = 0.5 })
	SetAnimation({ Name = "BootImage", DestinationId = backgroundId })

	local endScreen = CreateScreenComponent({ Name = "rectangle01", Group = "Overlay" })
	SetAnimation({ Name = "EndScreen", DestinationId = endScreen.Id })

	wait(2)

	PlaySound({ Name = "/Music/DemoEndAmbience" })

	wait(5.5)

	MusicPlayer( "/Music/MusicExploration4_MC" )
	SetSoundCueValue({ Names = { "Drums" }, Id = MusicId, Value = 0 })

	-- Halt demo
	wait(99999)

end

GlobalVoiceLines.BossHadesPeacefulExitVoiceLines =
{
	PreLineWait = 1.45,
	SuccessiveChanceToPlay = 0.33,
	RequiredTextLines = { "LordHadesBeforePersephoneReturn01" },
	UsePlayerSource = true,

	-- Goodbye, Father...
	{ Cue = "/VO/ZagreusField_3687" },
}
function CheckRunEndPresentation(currentRun, door)
	AddInputBlock({ Name = "CheckRunEndPresentation" })
	if TextLinesRecord["Ending01"] ~= nil then
		currentRun.CurrentRoom.SkipLoadNextMap = true
		EndEarlyAccessPresentation()
	else
		local heroExitPointId = GetClosest({ Id = door.ObjectId, DestinationIds = GetIdsByType({ Name = "HeroExit" }), Distance = 600 })
		thread( MoveHeroToRoomPosition, { DestinationId = heroExitPointId, DisableCollision =  true, UseDefaultSpeed = true } )
		FullScreenFadeOutAnimation()
		if TextLinesRecord["LordHadesBeforePersephoneReturn01"] ~= nil then
			thread( PlayVoiceLines, GlobalVoiceLines.BossHadesPeacefulExitVoiceLines )
		end
		wait( 3.5 )
	end
	RemoveInputBlock({ Name = "CheckRunEndPresentation" })
end

function EndEarlyAccessPresentation()

	AddInputBlock({ Name = "EndEarlyAccessPresentation" })
	SetPlayerInvulnerable( "EndEarlyAccessPresentation" )

	CurrentRun.ActiveBiomeTimer = false
	DisableCombatControls()
	local eligibleOutroData = {}
	local eligibleUnplayedOutroData = {}
	for k, outroData in pairs( GameOutroData ) do
		if outroData.Header ~= nil and IsGameStateEligible( CurrentRun, outroData ) then
			table.insert( eligibleOutroData, outroData )
			if not GameState.PlayedRandomRunOutroData[outroData.Header] then
				table.insert( eligibleUnplayedOutroData, outroData )
			end
		end
	end
	local gameOutroData = nil
	if IsEmpty( eligibleUnplayedOutroData ) then
		-- All played, start the record over
		for index, outroData in pairs( GameOutroData ) do
			if outroData.Header ~= nil then
				GameState.PlayedRandomRunOutroData[outroData.Header] = nil
			end
		end
		gameOutroData = GetRandomValue( eligibleOutroData )
	else
		gameOutroData = GetRandomValue( eligibleUnplayedOutroData )
	end
	
	GameState.PlayedRandomRunOutroData[gameOutroData.Header] = true

	wait( 0.1 )
	FadeOut({ Duration = 0.375, Color = Color.Black })
	wait( 0.5 )

	RunInterstitialPresentation( gameOutroData )

	wait( 0.5 )

	-- destroy the player / back to DeathArea
	SetPlayerVulnerable( "EndEarlyAccessPresentation" )
	RemoveInputBlock({ Name = "EndEarlyAccessPresentation" })
	EnableCombatControls()
	thread( Kill, CurrentRun.Hero )
	wait( 0.15 )

	FadeIn({ Duration = 0.5 })
end

function SendCritters( args )

	args = args or {}

	if args.ChanceToPlay ~= nil and not RandomChance( args.ChanceToPlay ) then
		return
	end

	local startId = args.StartId or CurrentRun.Hero.ObjectId
	if args.PreserveStartLocation then
		startId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = startId })
	end


	wait( args.StartDelay )

	local limit = RandomInt( args.MinCount or 1, args.MaxCount or 1 )
	for index = 1, limit, 1 do
		local startX = args.StartX or -1000
		local startY = args.StartY or -500
		if args.RandomStartOffsetX then
			startX = RandomInt( -args.RandomStartOffsetX, args.RandomStartOffsetX )
		end
		if args.RandomStartOffsetY then
			startY = RandomInt( -args.RandomStartOffsetY, args.RandomStartOffsetY )
		end


		local critterId = SpawnObstacle({ Name = args.CritterName or "SingleBat", DestinationId = startId, OffsetX = startX, OffsetY = startY, Group = args.GroupName or "FX_Standing_Top" })
		local moveAngle = RandomFloat( args.MinAngle or 45, args.MaxAngle or 135 )
		local moveSpeed = RandomFloat( args.MinSpeed or 10, args.MaxSpeed or 1000 )
		--DebugPrint({ Text = tostring(moveAngle).." | "..tostring(moveSpeed) })
		if args.CritterScaleMin and args.CritterScaleMax then
			local scale = RandomFloat( args.CritterScaleMin, args.CritterScaleMax )
			SetScale({ Id = critterId, Fraction = scale })
		end
		SetAngle({ Id = critterId, Angle = moveAngle, Speed = moveSpeed })
		Move({ Id = critterId, Angle = moveAngle, Speed = moveSpeed })
		thread( KillCritter, critterId, args.KillTime or 5.0 )
		local nextCritterWait = RandomFloat( args.MinInterval or 0.02, args.MaxInterval or 0.5 )
		wait( nextCritterWait )
	end

	if args.PreserveStartLocation then
		Destroy({ Id = startId })
	end

end

function KillCritter( objectId, killWait )
	wait( killWait )
	SetAlpha({ Id = objectId, Fraction = 0, Duration = 0.3 })
	wait(0.35)
	Destroy({ Id = objectId })
end

function BreakableCritters( source, args )
	args.StartId = source.ObjectId
	-- SendCritters( args )
	CreateAnimation({ DestinationId = source.ObjectId, Name = "MouseScurrySpawner"})
end

function PreRunOverlook()
	if not GameState.Flags.Overlook then
		GameState.Flags.Overlook = true

		SetSoundCueValue({ Id = MusicId, Names = { "LowPass" }, Value = 1.0, Duration = 0.5 })
		SetSoundCueValue({ Id = MusicId, Names = { "Keys" }, Value = 0.0, Duration = 3.0 })
		SetVolume({ Id = MusicId, Value = 0.7, Duration = 1.5 })

		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow", Delay = 1.5 })

		thread( PlayVoiceLines, HeroVoiceLines.OverlookVoiceLines, true )
		SetCameraFocusOverride()
		HideCombatUI("Overlook")
		DisableCombatControls()

		wait( 0.6, "OverlookThread" )
		if GameState.Flags.Overlook then
			PanCamera({ Id = 420906, Duration = 12, EaseOut = 3, OffsetX = -20, OffsetY = -20, Retarget = true })
		end

		thread( SendCritters, { CritterName = "SingleBat", MinCount = 30, MaxCount = 70, StartX = -1150, StartY = 800, MinAngle = 15, MaxAngle = 85, MinSpeed = 300, MaxSpeed = 1000, MinInterval = 0.1, MaxInterval = 0.3, } )

		wait( 8.2, "OverlookThread" )
		ShowOverlookText()

	end
end

function ShowOverlookText()
	ScreenAnchors.OverlookText = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu_Overlay" })
	CreateTextBox({ Id = ScreenAnchors.OverlookText, Text = "OverlookText", OffsetX = -900, OffsetY = 480,
			Font = "AlegreyaSansSCRegular", FontSize = 28, Justification = "Left",
			LuaKey = "TempTextData", LuaValue = { FurthestRunProgress = math.max( CurrentRun.RunDepthCache, GetHighestPrevRunRepth() ) },
			Color = { 0.698, 0.702, 0.514, 0.6 },
		})
end

function MetHades()
	GameState.Flags.MetHades = true
end

function PreRunBackToRoom()
	if GameState.Flags.Overlook then
		GameState.Flags.Overlook = false
		UnblockCombatUI("Overlook")
		EnableCombatControls()
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.5, FromCurrentLocation = true })
		FocusCamera({ Fraction = 1.0, Duration = 1.5, ZoomType = "Ease" })

		SetSoundCueValue({ Id = MusicId, Names = { "LowPass" }, Value = 0.0, Duration = 0.5 })
		SetSoundCueValue({ Id = MusicId, Names = { "Keys" }, Value = 1.0, Duration = 1.5 })
		SetVolume({ Id = MusicId, Value = 1, Duration = 1.5 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
		thread( PlayVoiceLines, HeroVoiceLines.OverlookLeaveVoiceLines )
		ClearCameraFocusOverride()
		ShowCombatUI()
		ModifyTextBox({ Id = ScreenAnchors.OverlookText, FadeTarget = 0, FadeDuration = 0.2 })

		killTaggedThreads( "OverlookThread" )
	end
end


local loungeDim = false
function DimLounge()
	if not loungeDim then
		loungeDim = true
		SetAlpha({ Ids = GetIds({ Name = "LoungeDimmer_01" }), Fraction = 1.0, Duration = 0.3 })
		thread( StartCustomDeathAreaAmbience )
	end
end

function UnDimLounge()
	if loungeDim then
		loungeDim = false
		SetAlpha({ Ids = GetIds({ Name = "LoungeDimmer_01" }), Fraction = 0.0, Duration = 0.3 })
		thread( StartCustomDeathAreaLoungeAmbience )
	end
end

local topHallDim = false
function DimTopHall()
	if not topHallDim then
		topHallDim = true
		SetAlpha({ Ids = GetIds({ Name = "TopHallDimmer_01" }), Fraction = 1.0, Duration = 0.3 })
	end
end

function UnDimTopHall()
	if topHallDim then
		topHallDim = false
		SetAlpha({ Ids = GetIds({ Name = "TopHallDimmer_01" }), Fraction = 0.0, Duration = 0.3 })
	end
end

function UnDimTopHallRoomStart()
	topHallDim = false
	SetAlpha({ Ids = GetIds({ Name = "TopHallDimmer_01" }), Fraction = 0.0, Duration = 0.3 })
end

function PetCerberusThread()
	thread( PetCerberus )
end

function PetCerberus()

	if not CurrentRun.Hero.IsDead then
		return
	end
	local cerberusId = 370007
	local cameraPanPoint = 423060
	local zagMovePoint = 423059
	local zagMovePrePoint = 422956
	local zagAnimation = "ZagreusPetting"
	local cerberusAnimation = "Cerberus_HousePetting"
	local zagAngle = 30.0
	local waitDuration1 = 4.0
	local waitDuration2 = 6.0

	AddInputBlock({ Name = "PetCerberus" })

	ZeroMouseTether("PetCerberus")
	PanCamera({ Id = cameraPanPoint, Duration = 8.0, EaseOut = 0.5 })
	thread( PlayVoiceLines, HeroVoiceLines.PetCerberusVoiceLines )

	thread( DoRumble, { { ScreenPreWait = 0.0, Duration = 1.3,
		LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.125, LeftTriggerFrequencyFraction = 0.0175, LeftTriggerTimeout = waitDuration1 - 1.3,
		RightTriggerStart = 2, RightTriggerStrengthFraction = 0.125, RightTriggerFrequencyFraction = 0.0175, RightTriggerTimeout = waitDuration1 - 1.3}, } )

	if GetDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = zagMovePrePoint }) > 30 then
		MoveHeroToRoomPosition( { DestinationId = zagMovePrePoint, DisableCollision = true } )
		NotifyWithinDistance({ Id = CurrentRun.Hero.ObjectId, DestinationId = zagMovePrePoint, Distance = 35, Notify = "ZagCerberusPetPreMove", Timeout = 0.8 })
		waitUntil( "ZagCerberusPetPreMove" )
		MoveHeroToRoomPosition( { DestinationId = zagMovePoint, DisableCollision = true } )
	end
	wait(0.4)
	Stop({ Id = CurrentRun.Hero.ObjectId })
	SetAngle({ Id = CurrentRun.Hero.ObjectId, Angle = zagAngle, Duration = 0 })

	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = zagAnimation })
	SetAnimation({ DestinationId = cerberusId, Name = cerberusAnimation })

	thread( DoRumble, { { ScreenPreWait = 0.0, Duration = 0.5,
		LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.125, LeftTriggerFrequencyFraction = 0.05, LeftTriggerTimeout = 0.55,
		RightTriggerStart = 2, RightTriggerStrengthFraction = 0.125, RightTriggerFrequencyFraction = 0.05, RightTriggerTimeout = 0.55}, } )

	thread( DoRumble, { { ScreenPreWait = 0.5, Duration = waitDuration1 - 0.5,
		LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.15, LeftTriggerFrequencyFraction = 0.05, LeftTriggerTimeout = waitDuration1 - 0.45,
		RightTriggerStart = 2, RightTriggerStrengthFraction = 0.15, RightTriggerFrequencyFraction = 0.05, RightTriggerTimeout = waitDuration1 - 0.45}, } )

	wait(waitDuration1)
	
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 1.4,
		LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.3, LeftTriggerFrequencyFraction = 0.15, LeftTriggerTimeout = 1.4,
		RightTriggerStart = 2, RightTriggerStrengthFraction = 0.3, RightTriggerFrequencyFraction = 0.15, RightTriggerTimeout = 1.4}, } )

	thread( DoRumble, { { ScreenPreWait = 1.4, Duration = 1.25,
		LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.15, LeftTriggerFrequencyFraction = 0.05, LeftTriggerTimeout = 1.25,
		RightTriggerStart = 2, RightTriggerStrengthFraction = 0.15, RightTriggerFrequencyFraction = 0.05, RightTriggerTimeout = 1.25}, } )

	thread( DoRumble, { { ScreenPreWait = 2.65, Duration = 0.7,
		LeftTriggerStart = 2, LeftTriggerStrengthFraction = 0.06, LeftTriggerFrequencyFraction = 0.015, LeftTriggerTimeout = 0.7,
		RightTriggerStart = 2, RightTriggerStrengthFraction = 0.06, RightTriggerFrequencyFraction = 0.015, RightTriggerTimeout = 0.7}, } )

	wait(waitDuration2)

	GameState.NumCerberusPettings = (GameState.NumCerberusPettings or 0) + 1

	PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0, EaseOut = 0.3 })
	UnzeroMouseTether("PetCerberus")

	RemoveInputBlock({ Name = "PetCerberus" })

	CheckAchievement( { Name = "AchCerberusPets" } )
end

function BoonInteractPresentation( source, args, textLines )

	if textLines ~= nil and not textLines.IgnoreInteractAnimation then
		local interactAnim = textLines.InteractAnimation or source.InteractAnimation
		if interactAnim == nil and textLines.PlayOnce then
			interactAnim = "StatusIconWantsToTalkBoon"
		end
		if interactAnim ~= nil then
			CreateAnimation({ Name = interactAnim, DestinationId = source.ObjectId, OffsetZ = source.AnimOffsetZ })
		end
	end

	Shake({ Id = source.ObjectId, Distance = 2, Speed = 300, Duration = 3, FalloffSpeed = 3000 })

	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.3 })
	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })
	AdjustColorGrading({ Name = "BoonInteract", Duration = 0.3 })
	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "BoonInteractDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "BoonInteractFx", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	local boonSound = PlaySound({ Name = "/SFX/Player Sounds/ZagreusWeaponChargeup" })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.5 }, } )

	wait( 0.5 )
	PlaySound({ Name = "/SFX/SurvivalChallengeStart2" })
	StopSound({ Id = boonSound, Duration = 0.3 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscended" })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 0.5 }, } )

	AdjustColorGrading({ Name = "Devotion", Duration = 0.1 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.1 })

	wait(0.06)

	AdjustColorGrading({ Name = "Off", Duration = 3.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 3.0 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertColorFx, fullscreenAlertDisplacementFx }, 3.0 )

	if args ~= nil then
		wait( args.PickupWait )
	end

end

function CheckFirstTimeWeaponUpgradePresentation( usee )
	if not GameState.ScreensViewed.WeaponUpgradeScreen then

		thread( MarkObjectiveComplete, "AspectsRevealPrompt" )

		AddInputBlock({ Name = "WeaponKitSpecialInteractPresentation" })

		PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweepSubtle"  })

		thread( PlayVoiceLines, HeroVoiceLines.WeaponUpgradesRevealedVoiceLines )
		PlayInteractAnimation( usee.ObjectId )

		wait(1.5)

		thread( PowerWordPresentationWorld )

		wait(1.5)

		RemoveInputBlock({ Name = "WeaponKitSpecialInteractPresentation" })

	end
end

function WeaponKitSpecialInteractPresentation( user, weaponKit, args )

	AddInputBlock({ Name = "WeaponKitSpecialInteractPresentation" })
	thread( PlayVoiceLines, HeroVoiceLines.WeaponKitSpecialInteractVoiceLines )

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2LOUD"  })

	Shake({ Id = user.ObjectId, Distance = 1, Speed = 200, Duration = 3, FalloffSpeed = 3000 })
	AngleTowardTarget({ Id = user.ObjectId, DestinationId = weaponKit.ObjectId })
	SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "ZagreusCosmeticPurchase" })

	wait( 0.6 )

	PanCamera({ Ids = weaponKit.ObjectId, Duration = 5, EaseIn = 0.05, EaseOut = 0.3 })

	AdjustColorGrading({ Name = "WeaponKitInteract", Duration = 0.2 })
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.2 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweep"  })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })

	local interactVignette = CreateAnimation({ Name = "WeaponKitInteractVignette", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = interactVignette })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "FullscreenAlertColorInvert", Group = "FX_Add_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	local boonSound = PlaySound({ Name = "/SFX/Player Sounds/ZagreusWeaponChargeup" })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.5 }, } )

	wait( 2.4 )

	PlaySound({ Name = "/SFX/SurvivalChallengeStart" })
	StopSound({ Id = boonSound, Duration = 0.3 })
	PlaySound({ Name = weaponKit.KitInteractSpecialUnlockSound or "/Leftovers/Menu Sounds/EmoteAscended" })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 0.5 }, } )

	AdjustColorGrading({ Name = "Team02", Duration = 0.02 })
	AdjustFullscreenBloom({ Name = "DeathDefiance", Duration = 0.02 })

	wait(0.2)
	PlaySound({ Name = weaponKit.KitInteractSpecialUnlockSound2 or "/EmptyCue"  })

	AdjustColorGrading({ Name = "Off", Duration = 0.8 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.8 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertColorFx, fullscreenAlertDisplacementFx }, 1.0 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscended" })

	if args ~= nil then
		wait( args.PickupWait )
	end

	wait( 0.6 )

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })

	RemoveInputBlock({ Name = "WeaponKitSpecialInteractPresentation" })

end

function LegendaryAspectPresentation( source, args )

	wait( args.WaitTime or 0 )

	AdjustColorGrading({ Name = "LegendaryProphecy", Duration = 0.2 })
	AdjustFullscreenBloom({ Name = "WeaponAspect", Duration = 0.2 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2LOUD"  })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })

	local interactVignette = CreateAnimation({ Name = "WeaponKitInteractVignette_Prophecy", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = interactVignette })

	if args.AdditionalAnimation ~= nil then
		local additionalAnimation = CreateAnimation({ Name = args.AdditionalAnimation, DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
		DrawScreenRelative({ Id = additionalAnimation })
	end

	if args.WeaponAnimation ~= nil then
		local weaponAnimation = CreateAnimation({ Name = args.WeaponAnimation, DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
		DrawScreenRelative({ Id = weaponAnimation })
	end

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "FullscreenAlertColorInvert", Group = "FX_Add_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	ShakeScreen({ Speed = 600, Distance = 9, FalloffSpeed = 2000, Duration = 0.3 })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.5 }, } )

	ShakeScreen({ Speed = 800, Distance = 3, FalloffSpeed = 500, Duration = 1.3, Delay = 0.3 })

	wait( 2.4 )

	AdjustColorGrading({ Name = "Off", Duration = 0.8 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.8 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertColorFx, fullscreenAlertDisplacementFx }, 1.0 )

end

function FirstTimeFreeWrath( source, args )
	wait( 1.5 )
	if ScreenAnchors.SuperMeterHint then
		PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegaeraHealthFillUp", Id = ScreenAnchors.SuperMeterHint })
	end
	while CurrentRun.Hero.SuperMeter < 50 do
		BuildSuperMeter(CurrentRun, 1)
		wait(0.01)
	end
end

function ChaosInteractPresentation( source, args, textLines )

	if textLines ~= nil and not textLines.IgnoreInteractAnimation then
		local interactAnim = textLines.InteractAnimation or source.InteractAnimation
		if interactAnim == nil and textLines.PlayOnce then
			interactAnim = "StatusIconWantsToTalkBoon"
		end
		if interactAnim ~= nil then
			CreateAnimation({ Name = interactAnim, DestinationId = source.ObjectId, OffsetZ = source.AnimOffsetZ })
		end
	end

	Shake({ Id = source.ObjectId, Distance = 2, Speed = 300, Duration = 3, FalloffSpeed = 3000 })
	AdjustColorGrading({ Name = "ChaosInversion", Duration = 0 })
	AdjustColorGrading({ Name = "Chaos", Duration = 1 })
	AdjustFullscreenBloom({ Name = "FullscreenFlash", Duration = 0.6 })
	AdjustRadialBlurDistance({ Fraction = 8, Duration = 0.2 })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = 0.2 })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })

	local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenChaosDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "FullscreenAlertColorDark", Group = "FX_Standing_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor})
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	local boonSound = PlaySound({ Name = "/SFX/Menu Sounds/ChaosBoonConfirm" })
	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.5 }, } )

	wait( 0.5 )
	ChaosBassStart()

	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 0.5 }, } )

	wait(0.06)

	AdjustRadialBlurDistance({ Fraction = 8, Duration = 2 })
	AdjustRadialBlurStrength({ Fraction = 1, Duration = 2 })
	AdjustColorGrading({ Name = "Off", Duration = 3.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 3.0 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertColorFx, fullscreenAlertDisplacementFx }, 5.0 )

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })

	if args ~= nil then
		wait( args.PickupWait )
	end

end

function EmoteShockPresentation( source, args, screen, line )

	wait( args.WaitTime, NarrativeThreadName )

	Flash({ Id = screen.PortraitId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.5, ExpireAfterCycle = true })
	Shake({ Id = screen.PortraitId, Distance = 2, Speed = 200, Duration = 1.0, Angle = 0 })

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAnger" })

	ShakeScreen({ Speed = 900, Distance = 8, FalloffSpeed = 2000, Duration = 1.05 })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 1.0 }, } )
	wait(0.5)
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })
	AdjustColorGrading({ Name = "Off", Duration = 3.0 })

end

GlobalVoiceLines.SetupFlashbackVoiceLines =
{
	-- Not as comfy as it looks.
	{ Cue = "/VO/ZagreusHome_0079", PreLineWait = 0.25 },
}

function SetupFlashback( source, args )
	CurrentRun.StoredNPCInteractions = DeepCopyTable(CurrentRun.NPCInteractions)
	CurrentRun.StoredTextLinesRecord = DeepCopyTable(CurrentRun.TextLinesRecord)

	CurrentRun.NPCInteractions = {}
	CurrentRun.TextLinesRecord = {}

	local flashbackMessage = args.FlashbackMessage
	local secretMusic = args.SecretMusic

 	FreezePlayerUnit("FlashbackStarted")
	-- disabling for now pending other changes since it slows this down a lot [GK]
	-- SetupPlayerUnitInFlashback()
	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 310036, OffsetX = -300 })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 390001 })
	-- SetAnimation({ DestinationId = CurrentRun.Hero.ObjectId, Name = "ZagreusTalkDenial_WeightShift2" })
	HideCombatUI( "Flashback" )
	StopStatusAnimation( MapState.ActiveObstacles[421158] )
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	thread( PlayVoiceLines, GlobalVoiceLines.SetupFlashbackVoiceLines )
	FadeIn({ Duration = 1.25 })
	AdjustColorGrading({ Name = "Sepia", Duration = 0.0 })
	StopSecretMusic()
	StopMusicianMusic( nil, { Duration = 0.2 } )
	wait(0.3)
	SecretMusicPlayer( secretMusic )
	thread( DisplayLocationText, nil, { Text = flashbackMessage, Delay = 0.5, Layer = "Overlay" } )
	UnfreezePlayerUnit("FlashbackStarted")
end

function AdvanceFlashback( args )
	CheckInspectPoints( CurrentRun, CurrentDeathAreaRoom )
	CheckConversations()
end

function ConcludeFlashback()
	CurrentRun.NPCInteractions = DeepCopyTable(CurrentRun.StoredNPCInteractions)
	CurrentRun.TextLinesRecord = DeepCopyTable(CurrentRun.StoredTextLinesRecord)

	GameState.Flags.InFlashback = false
	GameState.Flags.AllowFlashback = false
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	StopSound({ Id = SecretMusicId, Duration = 5 })
	SecretMusicId = nil
	SecretMusicName = nil
	FullScreenFadeOutAnimation()
	wait(2.5)
	AdjustColorGrading({ Name = "Off", Duration = 0.3 })
	DestroyCameraWalls({ })
	ShowCombatUI( "Flashback" )
	LoadMap({ Name = "DeathAreaBedroom", ResetBinks = false })
	wait(0.1)
	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 310036, OffsetY = 150 })
	wait(0.5)
	ResumeMusic()
	thread( PlayVoiceLines, HeroVoiceLines.FlashbackEndedVoiceLines )
end

function ConcludeEpilogue( args )
	CheckInspectPoints( CurrentRun, CurrentDeathAreaRoom )
	-- CheckConversations()
end

function SetupPlayerUnitInFlashback()
	SetUnitProperty({ Property = "StartGraphic", Value = nil, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "ZagreusWalk", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "StopGraphic", Value = "ZagreusWalkStop", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "Speed", Value = 110, DestinationId = CurrentRun.Hero.ObjectId })
	SetThingProperty({ Property = "Graphic", Value = "ZagreusIdle", DestinationId = CurrentRun.Hero.ObjectId })
end

function RestorePlayerUnitAfterFlashback()
	SetThingProperty({ Property = "Graphic", Value = "ZagreusIdle", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "StartGraphic", Value = "ZagreusStart", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "ZagreusRun", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "StopGraphic", Value = "ZagreusStop", DestinationId = CurrentRun.Hero.ObjectId })
	SetThingProperty({ Property = "Graphic", Value = "ZagreusIdle", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "Speed", Value = 540, DestinationId = CurrentRun.Hero.ObjectId })
end

function FlashbackPresentation()
	if GameState.Flags.InFlashback then
		HideCombatUI()
		AdjustColorGrading({ Name = "Sepia", Duration = 0.0 })
	end
end

function DoBiomePresentation()
	if CurrentRun.Hero.IsDead or not CurrentRun.CurrentRoom.UseBiomeMap then
		return
	end
	OnScreenOpened("BiomePresentation")
	RunBiomePresentation( CurrentRun )
	wait(3.0)
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	AudioState.TraversalSoundId = nil
	FullScreenFadeOutAnimation()
	OnScreenClosed("BiomePresentation")
	CleanupRunMapPresentation()
end

function RunBiomePresentation( currentRun )
	FullScreenFadeInAnimation()
	local runDepth = GetBiomeDepth( currentRun )

	ScreenAnchors.RunDepthDisplayAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Overlay", X = ScreenCenterX, Y = ScreenCenterY })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.1 })

	local currentArea = currentRun.CurrentRoom.BiomeMapArea or currentRun.CurrentRoom.RoomSetName
	local nextArea = nil
	local cameraY = nil
	local scaleMap = 1.0

	if ScreenAnchors.BiomePresentation ~= nil then
		Destroy({Id = ScreenAnchors.BiomePresentation})
	end

	ScreenAnchors.BiomePresentation = CreateScreenObstacle({ Name = "rectangle01", Group = "Combat_UI", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = ScreenAnchors.BiomePresentation , Fraction = 10 })
	SetColor({ Id = ScreenAnchors.BiomePresentation , Color = Color.Black })
	SetAlpha({ Id = ScreenAnchors.BiomePresentation , Fraction = 1, Duration = 0 })

	CreateGroup({ Name = "MapBackground", BlendMode = "Normal" })
	InsertGroupInFront({ Name = "MapBackground", DestinationName = "Combat_UI" })
	CreateGroup({ Name = "MapBackgroundFill", BlendMode = "Normal" })
	InsertGroupInFront({ Name = "MapBackgroundFill", DestinationName = "MapBackground" })
	CreateGroup({ Name = "MapLocales", BlendMode = "Normal" })
	InsertGroupInFront({ Name = "MapLocales", DestinationName = "MapBackgroundFill" })
	CreateGroup({ Name = "RewardPreviews", BlendMode = "Normal" })
	InsertGroupInFront({ Name = "RewardPreviews", DestinationName = "MapLocales" })
	CreateGroup({ Name = "MapPinDots", BlendMode = "Normal" })
	InsertGroupBehind({ Name = "MapPin", DestinationName = "RewardPreviews" })
	CreateGroup({ Name = "MapPin", BlendMode = "Normal" })
	InsertGroupInFront({ Name = "MapPin", DestinationName = "MapPinDots" })

	local biomeMapBottom = SpawnObstacle({ Name = "BiomeMapBottom", Group = "MapBackground", DestinationId = ScreenAnchors.RunDepthDisplayAnchor})
	local biomeMapTop = SpawnObstacle({ Name = "BiomeMapTop", Group = "MapBackground", DestinationId = ScreenAnchors.RunDepthDisplayAnchor})
	--local locationPin = SpawnObstacle({ Name = "BiomeMapLocationPin", Group = "MapPin", DestinationId = ScreenAnchors.RunDepthDisplayAnchor})

	DrawScreenRelative({ Id = biomeMapBottom })
	DrawScreenRelative({ Id = biomeMapTop })
	--DrawScreenRelative({ Id = locationPin })

	SetScale({ Id = biomeMapBottom, Fraction = scaleMap })
	SetScale({ Id = biomeMapTop, Fraction = scaleMap })
	SetScale({ Id = locationPin, Fraction = scaleMap })

	Attach({ Id = biomeMapBottom, DestinationId = ScreenAnchors.RunDepthDisplayAnchor, OffsetX = 0, OffsetY = 680 * scaleMap})
	Attach({ Id = biomeMapTop, DestinationId = ScreenAnchors.RunDepthDisplayAnchor, OffsetX = 0, OffsetY = -1192 * scaleMap })

	--Attach({ Id = locationPin, DestinationId = ScreenAnchors.RunDepthDisplayAnchor, OffsetX = 0, OffsetY = -1192 * scaleMap })

	SetThingProperty({ DestinationId = biomeMapBackgroundTexture, Property = "Ambient", Value = 0.0 })
	SetThingProperty({ DestinationId = biomeMapBottom, Property = "Ambient", Value = 0.0 })
	SetThingProperty({ DestinationId = biomeMapTop, Property = "Ambient", Value = 0.0 })
	--local pinOffsetX = 0
	--local pinOffsetY = 0
	--local pinDestination = nil

	local firstTimeReward = false
	local firstTimeRewardAreaName = nil
	local mapGraphics = {}
	local rewardGraphics = {}
	local rewardClaimedGraphics = {}
	local weaponGraphics = {}
	local rewardBackingGraphics = {}
	local currentAreaIndex = 0
	local panDurationIncrease = 0

	-- setup map art
	for areaName, area in pairs( BiomeMapGraphics ) do
		local mapGraphic = SpawnObstacle({ Name = area.MapGraphic, Group = "MapLocales", DestinationId = ScreenAnchors.RunDepthDisplayAnchor })
		mapGraphics[areaName] = mapGraphic
		SetScale({ Id = mapGraphic, Fraction = scaleMap })
		DrawScreenRelative({ Id = mapGraphic })
		Attach({ Id = mapGraphic, DestinationId = ScreenAnchors.RunDepthDisplayAnchor, OffsetX = area.OffsetX * scaleMap, OffsetY = -area.OffsetY * scaleMap + 540 })
		SetThingProperty({ DestinationId = mapGraphic, Property = "Ambient", Value = 0.0 })

		local shrinePointThreshold = GameState.SpentShrinePointsCache
		if CurrentRun.TargetShrinePointThreshold and shrinePointThreshold > CurrentRun.TargetShrinePointThreshold then
			shrinePointThreshold = CurrentRun.TargetShrinePointThreshold
		end

		local rewardGraphic = nil

		if area.PactRewardOffsetX ~= nil then

			if shrinePointThreshold <= GetMaximumAllocatableShrinePoints() then

				local rewardScale = 1.0
				local rewardBackingGraphic = SpawnObstacle({ Name = "BiomeMapRewardBacking", Group = "RewardPreviews", DestinationId = ScreenAnchors.RunDepthDisplayAnchor })
				rewardBackingGraphics[areaName] = rewardBackingGraphic
				SetScale({ Id = rewardBackingGraphic, Fraction = rewardScale })
				DrawScreenRelative({ Id = rewardBackingGraphic })
				SetThingProperty({ DestinationId = rewardBackingGraphic, Property = "Ambient", Value = 0.0 })
				SetThingProperty({ DestinationId = rewardBackingGraphic, Property = "SortMode", Value = "Id" })

				local weaponName = GetEquippedWeapon()
				local weaponGraphic = SpawnObstacle({ Name = "BiomeMap"..weaponName, Group = "RewardPreviews", DestinationId = ScreenAnchors.RunDepthDisplayAnchor })
				weaponGraphics[areaName] = weaponGraphic
				SetScale({ Id = weaponGraphic, Fraction = 1.05 })
				DrawScreenRelative({ Id = weaponGraphic })
				SetThingProperty({ DestinationId = weaponGraphic, Property = "Ambient", Value = 0.0 })
				SetThingProperty({ DestinationId = weaponGraphic, Property = "SortMode", Value = "Id" })

				rewardGraphic = SpawnObstacle({ Name = "BiomeMapRewardPreview", Group = "RewardPreviews", DestinationId = ScreenAnchors.RunDepthDisplayAnchor })
				rewardGraphics[areaName] = rewardGraphic
				SetScale({ Id = rewardGraphic, Fraction = rewardScale })
				DrawScreenRelative({ Id = rewardGraphic })
				local icon = GetRoomShrineRewardIcon( weaponName, area.PactRewardRoomName, shrinePointThreshold )
				SetAnimation({ DestinationId = rewardGraphic, Name = icon, OffsetX = 10 })
				SetThingProperty({ DestinationId = rewardGraphic, Property = "Ambient", Value = 0.0 })
				SetThingProperty({ DestinationId = rewardGraphic, Property = "SortMode", Value = "Id" })
				SetAlpha({ Id = rewardGraphic, Fraction = 0, Duration = 0 })


				rewardClaimedGraphic = SpawnObstacle({ Name = "SuperRewardClaimed", Group = "RewardPreviews", DestinationId = ScreenAnchors.RunDepthDisplayAnchor })
				rewardClaimedGraphics[areaName] = rewardClaimedGraphic
				SetScale({ Id = rewardClaimedGraphic, Fraction = rewardScale })
				DrawScreenRelative({ Id = rewardClaimedGraphic })
				SetThingProperty({ DestinationId = rewardClaimedGraphic, Property = "Ambient", Value = 0.0 })
				SetThingProperty({ DestinationId = rewardClaimedGraphic, Property = "SortMode", Value = "Id" })
				SetAlpha({ Id = rewardClaimedGraphic, Fraction = 0, Duration = 0 })

				Attach({ Id = rewardBackingGraphic, DestinationId = mapGraphic, OffsetX = area.PactRewardOffsetX * scaleMap, OffsetY = -area.PactRewardOffsetY * scaleMap })
				Attach({ Id = rewardGraphic, DestinationId = rewardBackingGraphic, OffsetX = 30, OffsetY = 0 })
				Attach({ Id = weaponGraphic, DestinationId = rewardBackingGraphic, OffsetX = -43, OffsetY = 2 })
				Attach({ Id = rewardClaimedGraphic, DestinationId = rewardBackingGraphic, OffsetX = 45, OffsetY = 25 })

			end

			if area.Name == currentArea then
				currentAreaIndex = area.Index
				local previousRoom = currentRun.RoomHistory[#currentRun.RoomHistory]
				if previousRoom.RewardStoreName == "SuperMetaProgress" then
					firstTimeRewardAreaName = areaName
					firstTimeReward = true
				end

				thread( ShowTraversal, area, mapGraphic, scaleMap )
				panDurationIncrease = area.BiomePanDurationIncrease or 0
			end

			if not firstTimeReward then
				SetAlpha({ Id = rewardGraphic, Fraction = 1.0 })
			end
		end

		if area.Name == currentArea then
			for biomeListIndex, biomes in ipairs(BiomeList) do
				if BiomeList[biomeListIndex] == currentArea then
					nextArea = BiomeList[biomeListIndex + 1]
				end
			end

			--Teleport({ Id = locationPin, DestinationId = mapGraphic, OffsetX = area.PinStartOffsetX * scaleMap, OffsetY = area.PinStartOffsetY * scaleMap })
		end
	end

	for areaName, area in pairs( BiomeMapGraphics ) do
		local weaponName = GetEquippedWeapon()
		local shrinePointThreshold = GameState.SpentShrinePointsCache
		if CurrentRun.TargetShrinePointThreshold and shrinePointThreshold > CurrentRun.TargetShrinePointThreshold then
			shrinePointThreshold = CurrentRun.TargetShrinePointThreshold
		end

		if area.Index ~= nil and ( not firstTimeReward or ( firstTimeReward and area.Index ~= currentAreaIndex )) then
			if ( not firstTimeReward and ObtainedRoomShrineReward( weaponName, area.PactRewardRoomName, shrinePointThreshold )) or ( firstTimeReward and area.Index < currentAreaIndex ) then
				SetAlpha({ Id = rewardClaimedGraphics[areaName], Fraction = 1.0, Duration = 0 })
			end
			SetAlpha({ Id = rewardGraphics[areaName], Fraction = 1.0, Duration = 0 })
		end
	end

	--[[local pinMoveDuration = 3.0
	for index, area in pairs( BiomeMapGraphics ) do
		if area.Name == nextArea then
			pinOffsetX = area.PinOffsetX * scaleMap + area.OffsetX * scaleMap
			pinOffsetY = area.PinOffsetY * scaleMap + area.OffsetY * scaleMap
			pinMoveDuration = area.PinMoveDuration or pinMoveDuration
		end
	end]]

	-- Camera Pan
	Teleport({ Id = ScreenAnchors.RunDepthDisplayAnchor, OffsetX = 960, OffsetY = BiomeMapGraphics[currentArea].OffsetY * scaleMap })
	Move({ Id = ScreenAnchors.RunDepthDisplayAnchor, DestinationId = ScreenAnchors.RunDepthDisplayAnchor, OffsetY = BiomeMapGraphics[nextArea].OffsetY * scaleMap - BiomeMapGraphics[currentArea].OffsetY * scaleMap, Duration = 7.4, EaseOut = 1.0, EaseIn = 0.1 })

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	if firstTimeReward then
		thread( FirstTimeRewardPresentation, rewardGraphics[firstTimeRewardAreaName], rewardClaimedGraphics[firstTimeRewardAreaName] )
	end


	--Move({ Id = locationPin, DestinationId = ScreenAnchors.RunDepthDisplayAnchor, OffsetX = pinOffsetX, OffsetY = pinOffsetY + 200, Duration = pinMoveDuration, EaseIn = 0, EaseOut = 1 })
	--local pinMoveSoundId = PlaySound({ Name = "/Leftovers/Menu Sounds/DialogueLoop5" })
	--wait(pinMoveDuration - 0.6)
	--StopSound({ Id = pinMoveSoundId, Duration = 0.2 })
	wait( 2.45 + panDurationIncrease )
end

function ShowTraversal( area, mapGraphic, scaleMap )

	local previousFillGraphic = SpawnObstacle({ Name = "BiomeMapFill", Group = "MapBackgroundFill", DestinationId = ScreenAnchors.RunDepthDisplayAnchor })
	SetAnimation({ Name = area.PreviousFillGraphic, DestinationId = previousFillGraphic })
	SetScale({ Id = previousFillGraphic, Fraction = scaleMap })
	DrawScreenRelative({ Id = previousFillGraphic })
	Attach({ Id = previousFillGraphic, DestinationId = mapGraphic })
	SetThingProperty({ DestinationId = previousFillGraphic, Property = "Ambient", Value = 0.0 })

	wait( 1.5 )

	local traversalGraphic = SpawnObstacle({ Name = "BiomeMapTraversal", Group = "MapLocales", DestinationId = ScreenAnchors.RunDepthDisplayAnchor })
	AudioState.TraversalSoundId = PlaySound({ Name = "/SFX/Menu Sounds/BiomeMapMovementCanned", Id = traversalGraphic })
	SetAnimation({ Name = area.TraversalGraphic, DestinationId = traversalGraphic })
	SetScale({ Id = traversalGraphic, Fraction = scaleMap })
	DrawScreenRelative({ Id = traversalGraphic })
	Attach({ Id = traversalGraphic, DestinationId = mapGraphic, OffsetX = area.TraversalOffsetX, OffsetY = area.TraversalOffsetY })
	SetThingProperty({ DestinationId = traversalGraphic, Property = "Ambient", Value = 0.0 })

	wait ( 2.0 )

	local fillGraphic = SpawnObstacle({ Name = "BiomeMapFill", Group = "MapBackgroundFill", DestinationId = ScreenAnchors.RunDepthDisplayAnchor })
	SetAnimation({ Name = area.FillGraphic, DestinationId = fillGraphic })
	SetScale({ Id = fillGraphic, Fraction = scaleMap })
	DrawScreenRelative({ Id = fillGraphic })
	Attach({ Id = fillGraphic, DestinationId = mapGraphic })
	SetThingProperty({ DestinationId = fillGraphic, Property = "Ambient", Value = 0.0 })

	SetAlpha({ Id = previousFillGraphic, Fraction = 0.0, Duration = 1.0 })

end

function FirstTimeRewardPresentation( graphics, checkmark )
	wait(0.72)
	SetAlpha({ Ids = { graphics, checkmark }, Fraction = 1.0, Duration = 0.5 })
	SetScale({ Ids = { graphics, checkmark }, Fraction = 4.0 })
	wait(0.02)
	SetScale({ Ids = { graphics, checkmark }, Fraction = 1.0, Duration = 0.25 })
	PlaySound({ Name = "/SFX/Menu Sounds/BiomeMapRewardIcon", Ids = { graphics, checkmark } })
	wait(0.25)
	Shake({ Ids = { graphics, checkmark }, Distance = 1.5, Speed = 120, Duration = 0.3 })
	CreateAnimation({ Name = "RoomRewardAvailableRareSparkles", DestinationIds = { graphics, checkmark } })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	thread( PlayVoiceLines, HeroVoiceLines.BountyEarnedConfirmationVoiceLines, true )

	wait(0.04)
	if firstTimeReward then
		SetColor({ Id = mapGraphics[firstTimeRewardAreaName], Color = { 0.3, 0.3, 0.3, 1.0 }, Duration = 0.35 })
		SetColor({ Id = rewardGraphics[firstTimeRewardAreaName], Color = { 1.0, 1.0, 1.0, 1.0 }, Duration = 0.35 })
		SetColor({ Id = rewardClaimedGraphics[firstTimeRewardAreaName], Color = { 1.0, 1.0, 1.0, 1.0 }, Duration = 0.35 })
		SetColor({ Id = weaponGraphics[firstTimeRewardAreaName], Color = { 0.3, 0.3, 0.3, 1.0 }, Duration = 0.35 })
		SetColor({ Id = rewardBackingGraphics[firstTimeRewardAreaName], Color = { 0.3, 0.3, 0.3, 1.0, Duration = 0.5 } })
	end
end

function CleanupRunMapPresentation()
	Destroy({ Ids = { ScreenAnchors.RunDepthDisplayAnchor } })
	Destroy({ Ids = GetIds({ Names = { "Boxen", "MapBackground", "MapLocales", "MapPin", "RewardPreviews" } }) })
	Destroy({ Id = ScreenAnchors.BiomePresentation })
end

GlobalVoiceLines.StorytellerEndingVoiceLines =
{
	{
		PreLineWait = 1.2,
		NoTarget = true,

		-- Thus was Hades, feared ruler of the dead, reunited with his long-lost bride, Persephone, the Queen; and, together with their firstborn son, Prince Zagreus, they would go on to reign eternally beneath the Earth, in relative harmony.
		{ Cue = "/VO/Storyteller_0340", SubtitleColor = Color.NarratorVoice, },
		-- The Queen's return marked an occasion of enthusiastic joy... so much as possible, in that dark, gloom-filled realm of the dead.
		{ Cue = "/VO/Storyteller_0341", SubtitleColor = Color.NarratorVoice, PreLineWait = 1 },
		-- And, even after all this time, Olympus never did discover what transpired there in the Underworld.
		{ Cue = "/VO/Storyteller_0342", SubtitleColor = Color.NarratorVoice, PreLineWait = 1 },
	},
}
GlobalVoiceLines.StorytellerEpilogueVoiceLines =
{
	{
		NoTarget = true,
		Queue = "Always",

		-- I say, Big Brother! You and your better half put on a positively smashing night! It's a relief, for all of us, knowing Persephone is safe and sound. And mother to as noble of a son as my good nephew, there!
		{ Cue = "/VO/Zeus_0232", Source = { SubtitleColor = Color.ZeusVoice }, PreLineWait = 1 },

		-- Well, Little Brother. The Queen and I, in turn, appreciate you all taking time out of your doubtless-busy lives, to come all this distance to my House.
		{ Cue = "/VO/Hades_0926", Source = { SubtitleColor = Color.HadesVoice }, PreLineWait = 0.3 },

		-- I'm certain it is very modest in comparison to Mount Olympus, but... I trust that you were suitably entertained.
		{ Cue = "/VO/Hades_1207", Source = { SubtitleColor = Color.HadesVoice }, PreLineWait = 0.3 },

		-- Oh, haha, of course, of course, Hades! Now, then, farewell! And let us keep in better touch, from here!
		{ Cue = "/VO/Zeus_0247", Source = { SubtitleColor = Color.ZeusVoice }, PreLineWait = 0.3 },

		-- Hrm. Farewell, indeed, Lord Zeus.
		{ Cue = "/VO/Hades_0940", Source = { SubtitleColor = Color.HadesVoice }, PreLineWait = 0.3 },
	},
}
EpilogueData =
{
	-- Olympus
	[1] =
	{
		--Header = "Remembrance_Olympus",
		FadeOutWait = 51.8,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			PreLineWait = 0.8,
			NoTarget = true,

			-- Thus did all of Olympus journey deep into the Underworld, all together, for the very first time. 
			{ Cue = "/VO/Storyteller_0343", },
			-- The Queen Persephone revealed herself in all her splendor, much to their surprise, and told them everything she indicated to her son.
			{ Cue = "/VO/Storyteller_0344" },
			-- She eloped with grim Lord Hades, she said; mothering a fire-stepping prince who sought to reconnect with his extended family.
			{ Cue = "/VO/Storyteller_0407" },
			-- Hades and Persephone at first refused his wish. But, so moved were they by his relentless struggles to the surface, that at last, they decided to heed their willful Zagreus, and reach out. For his and everybody's sake.
			{ Cue = "/VO/Storyteller_0408" },
			-- The Olympians listened to all this in stunned silence. Then Zeus, himself, began to laugh. Welcome back into the family, he said.
			{ Cue = "/VO/Storyteller_0409" },
			-- After the shock subsided... the festivities began.
			{ Cue = "/VO/Storyteller_0345", PreLineWait = 2.0 },
		},

		BackgroundAnimation = "Blank",
		SkipBackgrounds = true,
		Animations = 
		{
			{
				AnimationName = "Olympus_00_Backing",
				Delay = 0,
				X = ScreenCenterX,
				Y = ScreenCenterY,
				Group = "Combat_Menu_TraitTray_Overlay",
			},
						{
				AnimationName = "Olympus_01_OuterCircle",
				Delay = 0,
				X = ScreenCenterX,
				Y = ScreenCenterY,
				Group = "Combat_Menu_TraitTray_Overlay",
			},
			{
				AnimationName = "Olympus_01a_InnerCircle",
				Delay = 0,
				X = ScreenCenterX,
				Y = ScreenCenterY,
				Group = "Combat_Menu_TraitTray_Overlay",
			},
			{
				AnimationName = "Olympus_02_Vignette",
				Delay = 0,
				X = ScreenCenterX,
				Y = ScreenCenterY,
				Group = "Combat_Menu_TraitTray_Overlay",
			},
			{
				AnimationName = "Olympus_03_Background",
				Delay = 0,
				X = ScreenCenterX,
				Y = ScreenCenterY,
				Group = "Combat_Menu_TraitTray_Overlay",
			},
			{
				AnimationName = "OlympianSigil_Hades",
				Delay = 49,
				X = ScreenCenterX,
				Y = ScreenCenterY,
				Group = "Combat_Menu_TraitTray_Overlay",
			},
			{
				AnimationName = "OlympianSigil_Zeus",
				Delay = 3,
				X = 960,
				Y = 177,
				Group = "Combat_Menu_TraitTray_Overlay_Additive",
			}, 
			{
				AnimationName = "OlympianSigil_Poseidon",
				Delay = 6,
				X = 1230,
				Y = 260,
				Group = "Combat_Menu_TraitTray_Overlay_Additive",
			}, 
			{
				AnimationName = "OlympianSigil_Athena",
				Delay = 9,
				X = 1350,
				Y = 507,
				Group = "Combat_Menu_TraitTray_Overlay_Additive",
			}, 
			{
				AnimationName = "OlympianSigil_Aphrodite",
				Delay = 12,
				X = 1300,
				Y = 747,
				Group = "Combat_Menu_TraitTray_Overlay_Additive",
			}, 
			{
				AnimationName = "OlympianSigil_Artemis",
				Delay = 15,
				X = 1096,
				Y = 942,
				Group = "Combat_Menu_TraitTray_Overlay_Additive",
			}, 
			{
				AnimationName = "OlympianSigil_Ares",
				Delay = 18,
				X = 810,
				Y = 942,
				Group = "Combat_Menu_TraitTray_Overlay_Additive",
			}, 
			{
				AnimationName = "OlympianSigil_Dionysus",
				Delay = 21,
				X = 610,
				Y = 747,
				Group = "Combat_Menu_TraitTray_Overlay_Additive",
			}, 
			{
				AnimationName = "OlympianSigil_Hermes",
				Delay = 24,
				X = 546,
				Y = 507,
				Group = "Combat_Menu_TraitTray_Overlay_Additive",
			}, 
			{
				AnimationName = "OlympianSigil_Demeter",
				Delay = 27,
				X = 670,
				Y = 260,
				Group = "Combat_Menu_TraitTray_Overlay_Additive",
			},  
		},
	},
	-- Handshake
	[2] =
	{
		Animations = {
			{ AnimationName = "HandShake_08_BG", X = ScreenCenterX, Y = ScreenCenterY, StartColor = Color.Black, EndColor = Color.White, ColorDuration = 1.5 },
			{ AnimationName = "HandShake_07_Pillars_Right", X = ScreenCenterX, Y = ScreenCenterY, StartColor = Color.Black, EndColor = Color.White, ColorDuration = 1.7 },
			{ AnimationName = "HandShake_06_Pillars_Left", X = ScreenCenterX, Y = ScreenCenterY, StartColor = Color.Black, EndColor = Color.White, ColorDuration = 1.9 },
			{ AnimationName = "HandShake_05_Trees", X = ScreenCenterX, Y = ScreenCenterY, StartColor = Color.Black, EndColor = Color.White, ColorDuration = 2.1 },
			{ AnimationName = "HandShake_04_BGChars", X = ScreenCenterX, Y = ScreenCenterY, StartColor = Color.Black, EndColor = Color.White, ColorDuration = 2.3 },
			{ AnimationName = "HandShake_03_Vignette", X = ScreenCenterX, Y = ScreenCenterY, StartColor = Color.Black, EndColor = Color.White, ColorDuration = 2.5 },
			{ AnimationName = "HandShake_02_Gradient", X = ScreenCenterX, Y = ScreenCenterY, StartColor = Color.Black, EndColor = Color.White, ColorDuration = 2.7 },
			{ AnimationName = "HandShake_01_Characters", X = ScreenCenterX, Y = ScreenCenterY, StartColor = Color.Black, EndColor = Color.White, ColorDuration = 2.9 },
			{ AnimationName = "HandShake_00_FrontFx", X = ScreenCenterX, Y = ScreenCenterY, StartColor = Color.Black, EndColor = Color.White, ColorDuration = 6.1 },
		},
	},
	-- Hades
	[3] =
	{
		Header = "Remembrance_Hades",
		FadeOutWait = 30,
		SubtitleColor = Color.NarratorVoice,
		VoiceLines =
		{
			PreLineWait = 1.2,
			NoTarget = true,

			-- When finally the great feast ended, all the Olympians returned to their mountain abode, fully satisfied; as for the House of Hades, it required thorough cleansing, from the rafters to the floor.
			{ Cue = "/VO/Storyteller_0346", PreLineWait = 1 },
			-- Such revelry, of course, is unbecoming of the name of Hades, and the fearsome reputation of the Underworld. For, if mortals were to have no fear of death, then they would have no fear of anything at all.
			{ Cue = "/VO/Storyteller_0347", PreLineWait = 1 },
			-- A well-kept family secret, then, this would live on to be.
			{ Cue = "/VO/Storyteller_0348", PreLineWait = 1 },
		},
	},
}

function EpilogueAmbience( eventSource, args )
	wait( 56.8 )

	PortraitAmbienceId = PlaySound({ Name = "/Leftovers/SFX/ReunionAmbience", Duration = 0.5 })

	wait( 45 )

	StopSound({ Id = PortraitAmbienceId, Duration = 6 })
end
function EpilogueMusic( eventSource, args )
	SecretMusicPlayer( "/Music/PersephoneTheme_MC" )
	SetSoundCueValue({ Names = { "Harp", "Strings", "Room", "Trombones", "Percussion" }, Id = SecretMusicId, Value = 1, Duration = 1.25 })
	SetSoundCueValue({ Names = { "WoodWinds" }, Id = SecretMusicId, Value = 0, Duration = 1.25 })
	SetVolume({ Id = SecretMusicId, Value = 1.0 })

	wait(46)

	SetSoundCueValue({ Names = { "Section", }, Id = SecretMusicId, Value = 10 })
	SetVolume({ Id = SecretMusicId, Value = 0.0, Duration = 10 })

end

function ViewPortraitPresentation( eventSource, args )

	if not PlayingTextLines then
		UseableOff({ Id = eventSource.ObjectId })
	end

	AddInputBlock({ Name = "ShowingInterstitial" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })

	HideCombatUI("ShowingInterstitial")
	if args.PauseMusic then
		PauseMusic()
	end

	if args.PortraitGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines[args.PortraitGlobalVoiceLines] )
	else
		thread( PlayVoiceLines, HeroVoiceLines.UsedFamilyPortraitVoiceLines )		
	end

	wait( args.StartDelay or 0 )

	if args.FadeInTime then
		FadeIn({ Duration = args.FadeInTime })
	end

	if args.SecretMusic then
		SecretMusicPlayer( args.SecretMusic )
		SetSoundCueValue({ Names = { "Section", }, Id = SecretMusicId, Value = args.SecretMusicSection })
		SetSoundCueValue({ Names = args.SecretMusicActiveStems, Id = SecretMusicId, Value = 1, Duration = args.SecretMusicActiveStemsDuration or 1 })
		SetSoundCueValue({ Names = args.SecretMusicMutedStems, Id = SecretMusicId, Value = 0, Duration = args.SecretMusicMutedStemsDuration or 1 })
	end

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })

	ScreenAnchors.PortraitDisplayAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Overlay", X = ScreenCenterX, Y = ScreenCenterY })
	local blackScreenId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = blackScreenId, Fraction = 10 })
	SetColor({ Id = blackScreenId, Color = Color.Black })
	SetAlpha({ Id = blackScreenId, Fraction = 1.0, Duration = 0 })

	local portraitId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY, Group = "Overlay" })
	SetScale({ Id = portraitId, Fraction = 1.1 })
	SetAlpha({ Id = portraitId, Fraction = 0.0, Duration = 0 })
	SetAlpha({ Id = portraitId, Fraction = 1.0, Duration = 1.0 })
	SetAnimation({ Name = args.PortraitAnimationName, DestinationId = portraitId })

	Attach({ Id = blackScreenId, DestinationId = ScreenAnchors.PortraitDisplayAnchor })
	Attach({ Id = portraitId, DestinationId = ScreenAnchors.PortraitDisplayAnchor })

	-- Camera Pan
	AdjustFullscreenBloom({ Name = "NewType06", Duration = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1, Delay = 0 })
	Teleport({ Id = ScreenAnchors.PortraitDisplayAnchor, DestinationId = ScreenAnchors.PortraitDisplayAnchor, OffsetX = 0, OffsetY = 0 })
	-- Move({ Id = ScreenAnchors.PortraitDisplayAnchor, DestinationId = ScreenAnchors.PortraitDisplayAnchor, OffsetX = 0, OffsetY = 50, Duration = args.PanDuration or 9.4, EaseOut = 1.0, EaseIn = 0.0 })
	SetScale({ Id = portraitId, Fraction = 0.58, Duration = args.PanDuration or 9.8, EaseOut = 1.0, EaseIn = 0.0 })

	wait( args.FadeOutWait or 12.0 )

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })

	wait(0.375)
	
	SetAlpha({ Id = blackScreenId, Fraction = 0.0, Duration = 0.375 })
	SetAlpha({ Id = portraitId, Fraction = 0.0, Duration = 0.375 })

	wait(0.625)
	Destroy({ Id = portraitId })
	Destroy({ Id = blackScreenId })
	Destroy({ Id = ScreenAnchors.PortraitDisplayAnchor })

	if args.SecretMusic then
		StopSound({ Id = SecretMusicId, Duration = 2 })
		ResumeMusic()
		SecretMusicId = nil
		SecretMusicName = nil
	end

	if args.PauseMusic then
		ResumeMusic()
	end

	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })

	RemoveInputBlock({ Name = "ShowingInterstitial" })
	UnblockCombatUI("ShowingInterstitial")

	thread( FamilyPortraitUsabilityToggle, eventSource )

end

function FamilyPortraitUsabilityToggle( eventSource )

	if not PlayingTextLines then
		wait( 15.0, RoomThreadName )
		UseableOn({ Id = eventSource.ObjectId })
	else
		wait( 10.0, RoomThreadName )
		UseableOn({ Id = eventSource.ObjectId })
	end

end

function EpilogueScenePresentation( eventSource, args )
	if not PlayingTextLines then
		UseableOff({ Id = eventSource.ObjectId })
	end

	AddInputBlock({ Name = "ShowingInterstitial" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })

	HideCombatUI("ShowingInterstitial")
	if args.PauseMusic then
		PauseMusic()
	end

	ScreenAnchors.Epilogue = {}

	wait( args.EpilogueStartDelay or 0 )

	----------- SCENE 1 - Olympus -------------------
	thread( EpilogueAmbience )
	thread( EpilogueMusic )

	FadeOut({ Duration = 0.375, Color = Color.Black })

	wait( 0.5 )

	-- get rid of poor Cerberus and his loud breathing
	Teleport({ Id = 370007, DestinationId = 424983, OffsetX = 5000 })

	PlaySound({ Name = "/SFX/ZeusLaugh", Delay = 48.3 })
	FullScreenFadeInAnimation( "RoomTransitionOutSlow" )
	RunInterstitialPresentation( EpilogueData[1], true )

	wait( 0.65 )
	EndAmbience()

	SetSoundCueValue({ Names = { "Section" }, Id = 10, Value = SecretMusicId })

	----------- SCENE 2 - Handshake -------------------

	AdjustFullscreenBloom({ Name = "NewType06", Duration = 0 })

	if args.PortraitGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines[args.PortraitGlobalVoiceLines] )
	else
		thread( PlayVoiceLines, HeroVoiceLines.UsedFamilyPortraitVoiceLines )		
	end

	wait( args.StartDelay or 0 )

	if args.FadeInTime then
		FadeIn({ Duration = args.FadeInTime })
	end

	if args.SecretMusic then
		SecretMusicPlayer( args.SecretMusic )
		SetSoundCueValue({ Names = { "Section", }, Id = SecretMusicId, Value = args.SecretMusicSection })
		SetSoundCueValue({ Names = args.SecretMusicActiveStems, Id = SecretMusicId, Value = 1, Duration = args.SecretMusicActiveStemsDuration or 1 })
		SetSoundCueValue({ Names = args.SecretMusicMutedStems, Id = SecretMusicId, Value = 0, Duration = args.SecretMusicMutedStemsDuration or 1 })
	end

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })

	local blackScreenId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY })
	SetScale({ Id = blackScreenId, Fraction = 10 })
	SetColor({ Id = blackScreenId, Color = Color.Black })
	SetAlpha({ Id = blackScreenId, Fraction = 1.0, Duration = 0 })
	
	for index, animationData in ipairs(EpilogueData[2].Animations) do
		animationData.Id = CreateScreenObstacle({ Name = "BlankObstacle", X = animationData.X or ScreenCenterX , Y = animationData.Y or ScreenCenterY, Group = animationData.Group or "Events" })
		table.insert(ScreenAnchors.Epilogue, animationData.Id)
		thread( DelayedScreenObstacle, animationData )
	end

	-- Camera Pan
	AdjustFullscreenBloom({ Name = "NewType06", Duration = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1, Delay = 0 })
	--SetScale({ Id = portraitId, Fraction = 0.58, Duration = args.PanDuration or 9.8, EaseOut = 1.0, EaseIn = 0.0 })

	wait( args.FadeOutWait or 12.0 )

	FadeOut({ Duration = 0.375, Color = Color.Black })

	wait(0.375)
	
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	SetAlpha({ Id = blackScreenId, Fraction = 0.0, Duration = 0.375 })

	wait(0.625)
	Destroy({ Id = blackScreenId })
	Destroy({ Ids = ScreenAnchors.Epilogue })

	if args.SecretMusic then
		StopSound({ Id = SecretMusicId, Duration = 2 })
		ResumeMusic()
		SecretMusicId = nil
		SecretMusicName = nil
	end

	if args.PauseMusic then
		ResumeMusic()
	end

	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })

	----------- SCENE 3 - Hades -------------------
	wait( 0.5 )

	RunInterstitialPresentation( EpilogueData[3] )

	wait( 0.2 )

	thread( KeyAchievementPresentation, nil, { Title = "EpilogueComplete", Sound = "/Music/ARStinger_All_6", Layer = "ScreenOverlay" } )

	wait( 6.6 )

	PostEndingAmbience()

	FadeIn({ Duration = 0.75 })

	RemoveInputBlock({ Name = "ShowingInterstitial" })
	UnblockCombatUI("ShowingInterstitial")

	thread( FamilyPortraitUsabilityToggle, eventSource )
end

OnUsed{ "HouseBed01",
	function( triggerArgs )
		thread( MarkObjectiveComplete, "BedPrompt")
	end
}

function ShrinePointClearAvailablePresentation( usee, source )
	HideUseButton( usee.ObjectId, usee )
	Shake({ Id = usee.ObjectId, Distance = 1.5, Speed = 80, Duration = 0.3 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract", Id = usee.ObjectId })
	PlayInteractAnimation( usee.ObjectId )
	thread( PlayVoiceLines, HeroVoiceLines.TrophyClearAvailableVoiceLines, true )
	wait(1.0)
	UpdateShrinePointClearText( usee )
	PlaySound({ Name = "/SFX/Menu Sounds/HadesLocationTextAppear" })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "ShrinePointClearGoal_NewObjective", 2 )
end

function UpdateShrinePointClearText( usee )
	local recordShrinePoints = GetHighestShrinePointRunClear( CurrentRun )
	local costFontColor = Color.CostAffordable
	if usee.GoalShrinePointClear > recordShrinePoints then
		costFontColor = Color.CostUnaffordable
	end

	CreateTextBox({ Id = usee.ObjectId, Text = "ShrinePointClearRequirement",
		TextSymbolScale = 0.6,
		LuaKey = "TempTextData", LuaValue = { GoalAmount = usee.GoalShrinePointClear },
		FontSize = 24,
		OffsetY = -420,
		Color = costFontColor,
		Justification = "CENTER",
		Font="AlegreyaSansSCBold",
		FontSize=36,
		ShadowColor = {0,0,0,1},
		ShadowOffsetY=2,
		ShadowOffsetX=0,
		ShadowAlpha=1,
		ShadowBlur=0,
		OutlineColor={0,0,0,1},
		OutlineThickness=2,
	})

	ModifyTextBox({ Id = usee.ObjectId, FadeTarget = 0, FadeDuration = 0.0})
	ModifyTextBox({ Id = usee.ObjectId, FadeTarget = 1, FadeDuration = 0.5 })
	ModifyTextBox({ Id = usee.ObjectId, ScaleTarget = 1.65, ScaleDuration = 0.15 })
	ModifyTextBox({ Id = usee.ObjectId, ScaleTarget = 1.0, ScaleDuration = 0.35, Delay = 0.15 })

end

function ShrinePointClearIncompletePresentation( usee, source )

	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "ZagreusUsingLockedStatue" })

	Flash({ Id = usee.ObjectId, Speed = 1, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.White, ExpireAfterCycle = true })
	Shake({ Id = usee.ObjectId, Distance = 2, Speed = 150, Duration = 0.65 })

	local activeShrinePoints = GetTotalSpentShrinePoints()
	if usee.GoalShrinePointClear > activeShrinePoints then
		if CheckCooldown( "ShrinePointClearIncompletePresentation", 2.0 ) then
			thread( RepulseFromObject, usee, { Text = "ShrinePointClearGoal_NotEnough", OffsetZ = 70, Scale = 1.5 })
		end
		thread( PlayVoiceLines, HeroVoiceLines.TrophyLockedNotEnoughHeatVoiceLines, true )
		thread( PlayVoiceLines, source.TrophyLockedNotEnoughHeatVoiceLines, true, source )
	else
		if CheckCooldown( "ShrinePointClearIncompletePresentation", 2.0 ) then
			thread( RepulseFromObject, usee, { Text = "ShrinePointClearGoal_Enough", OffsetZ = 70, Scale = 1.5 })
		end
		thread( PlayVoiceLines, HeroVoiceLines.TrophyLockedEnoughHeatVoiceLines, true )
		thread( PlayVoiceLines, source.TrophyLockedEnoughHeatVoiceLines, true, source )
	end

	RemoveInputBlock({ Name = "ZagreusUsingLockedStatue" })
	wait( 8.0, RoomThreadName )
	UseableOn({ Id = usee.ObjectId })

end

function ShrinePointClearCompletePresentation( usee, source )

	AddInputBlock({ Name = "ShrinePointClearComplete" })
	FreezePlayerUnit("ShrinePointClearComplete")

	local waitTime = 3.5
	if TextLinesRecord["TrophyQuest_BronzeUnlocked_01"] then
		waitTime = 10.5
	elseif TextLinesRecord["TrophyQuest_SilverUnlocked_01"] then
	end

	thread( PlayVoiceLines, source.TrophyUnlockedVoiceLines, true, source )

	PlayInteractAnimation( usee.ObjectId )
	StopAnimation({ Name = usee.AttractAnimation, DestinationId = usee.ObjectId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection" })

	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	FullScreenFadeOutAnimation()
	wait(0.5)
	PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract", Id = usee.ObjectId })
	wait(0.3)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter", Id = usee.ObjectId })
	wait(0.2)
	PlaySound({ Name = "/Leftovers/SFX/RobeFlutter", Id = usee.ObjectId })
	wait(3.0)
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection", Id = usee.ObjectId })
	SetAnimation({ DestinationId = usee.ObjectId, Name = usee.CompleteAnimation })
	SetHSV({ Id = usee.ObjectId, HSV = { 0, 0, 0 }, ValueChangeType = "Multiply" })
	if usee.FlipHorizontalOnComplete then
		FlipHorizontal({ Id = usee.ObjectId })
	end
	DestroyTextBox({ Id = usee.ObjectId })
	Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = 487565, OffsetX = -30, OffsetY = -30 })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 487565 })
	FullScreenFadeInAnimation()
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	wait(waitTime)
	UnfreezePlayerUnit("ShrinePointClearComplete")
	RemoveInputBlock({ Name = "ShrinePointClearComplete" })
	if usee.OnTrophyUnlockedTextLineSets ~= nil then
		PlayFirstEligibleTextLines( source, usee.OnTrophyUnlockedTextLineSets )
	end
end

function StatueUnlockedPresentation( source, args, screen, line )
	wait(1.35)
	DisplayUnlockText({
		TitleText = "ShrinePointStatue_Unlocked",
		SubtitleText = args.Subtitle or "ShrinePointStatue_Unlocked_Subtitle_04",
		-- Duration = 4.5,
	})
	CheckAchievement( { Name = "AchBronzeSkellyTrophy" } )
	CheckAchievement( { Name = "AchSilverSkellyTrophy" } )
end

function StatueHitPresentation( victim )
	local source = ActiveEnemies[ GetClosestUnitOfType({ Id = victim.ObjectId, DestinationName = victim.SourceName, Distance = 9999 }) ]
	if source == nil then
		return
	end
	thread( PlayVoiceLines, source.TrophyAttackReactionVoiceLines, true, source )
end

function StatueAdmirePresentation( usee )
	UseableOff({ Ids = { 487422, 487421, 487120 } })
	AddInputBlock({ Name = "AdmiringStatue" })
	FreezePlayerUnit("AdmiringStatue")
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "ZagreusTalkEmpathyStart", DestinationId = CurrentRun.Hero.ObjectId })
	PlayVoiceLines( HeroVoiceLines.TrophyAdmirationVoiceLines, true )
	SetAnimation({ Name = "ZagreusTalkEmpathy_Return", DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.75)
	UnfreezePlayerUnit("AdmiringStatue")
	RemoveInputBlock({ Name = "AdmiringStatue" })
	wait( 8.0, RoomThreadName )
	UseableOn({ Ids = { 487422, 487421, 487120 } })
end

function CheckSkellyTrueDeathQuestCompletePresentation( source, args )
	if not IsGameStateEligible( CurrentRun, PresetEventArgs.SkellyTrueDeathQuestCompleteRequirements ) then
		return
	end
	local sourceName = GetGenusName( source )
	local checkingMeterUnlock = GiftData[sourceName] and not IsGameStateEligible(CurrentRun, GiftData[sourceName].UnlockGameStateRequirements )

	ProcessTextLines( source.OnDeathTextLineSets )
	AddInputBlock({ Name = "SkellyTrueDeathQuestCompletePresentation" })

	source.RespawnDelay = 9.5

	HarpyKillPresentation( source, { Message = "SkellyDefeatedMessage", CameraPanTime = 1.5, StartSound = "/Leftovers/Menu Sounds/EmoteShocked", FlashRed = true } )
	-- AdjustColorGrading({ Name = "Sepia", Duration = 5.0 })
	-- AdjustFullscreenBloom({ Name = "Off", Duration = 0.5 })

	wait(6.6)

	SetAlpha({ Id = ScreenAnchors.DeathBackground, Fraction = 0.0, Duration = 0.3 })

	RemoveInputBlock({ Name = "SkellyTrueDeathQuestCompletePresentation" })
	PlayRandomRemainingTextLines( source, source.OnDeathTextLineSets )
	if checkingMeterUnlock and IsGameStateEligible(CurrentRun, GiftData[sourceName].UnlockGameStateRequirements ) then
		thread( GiftTrackUnlockedPresentation, sourceName )
	end
	source.RespawnDelay = 4.85

end

function SetUpBouldyConversation()
	local source = ActiveEnemies[ GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Bouldy_01", Distance = 3000 }) ]
	CheckAvailableTextLines( source )
	SetAvailableUseText( source )
end

function BouldyHitPresentation( victim )
	local source = ActiveEnemies[ GetClosestUnitOfType({ Id = victim.ObjectId, DestinationName = "NPC_Sisyphus_01", Distance = 9999 }) ]
	thread( PlayVoiceLines, source.BouldyAttackReactionVoiceLines, true, source )
end

function CannotRerollPresentation( run, target )

	Shake({ Id = target.ObjectId, Distance = 1, Speed = 300, Duration = 0.3, FalloffSpeed = 3000 })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = target.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.CannotRerollVoiceLines, true )

end

function PreRerollPresentation( run, target )

	PlaySound({ Name = "/Leftovers/Menu Sounds/AscensionConfirm" })

	AdjustColorGrading({ Name = "Mythmaker", Duration = 0.66 })
	target.RerollSoundId = PlaySound({ Name = "/Leftovers/Menu Sounds/StoryRecapTextAppear" })
	SetVolume({ Id = target.RerollSoundId, Value = 0.3 })

	thread( PlayVoiceLines, HeroVoiceLines.UsedRerollVoiceLines, true )

	wait(0.5)

	PlayInteractAnimation( target.ObjectId )
	Destroy({ Ids = target.AdditionalIcons })
	target.AdditionalIcons = nil
	AdjustColorGrading({ Name = "None", Duration = 0 })
	AdjustFullscreenBloom({ Name = "NewType06", Duration = 0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 1, Delay = 0 })

	if target.DoorIconId ~= nil then
		Destroy({ Id = target.DoorIconId })
		RemoveFromGroup({ Name = "Standing", Id =  target.DoorIconFront })
		AddToGroup({ Name = "FX_Standing", Id = target.DoorIconFront, DrawGroup = true })
		SetAnimation({ Name = "RoomRewardShatterReRoll", DestinationId = target.DoorIconFront, Scale = 1 })
		StopAnimation({ Names = { "RoomRewardAvailableRareSparkles", "RoomRewardAvailableGlow", "RoomRewardStreaks" }, DestinationId = target.DoorIconFront })
	end
end

function DestroyDoorRewardPresenation( door )
	if door.DoorIconId ~= nil then
		SetAlpha({ Id = door.DoorIconId, Fraction = 0, Duration = 0.1 })
		RemoveFromGroup({ Name = "Standing", Id =  door.DoorIconFront })
		AddToGroup({ Name = "FX_Standing", Id = door.DoorIconFront, DrawGroup = true })
		local rewardContainerAnim = "RoomRewardShatter"
		 if door.Room ~= nil and door.Room.RewardStoreName == "MetaProgress" then
		 	rewardContainerAnim = "RoomRewardShatter_MetaReward"
		end
		SetAnimation({ Name = rewardContainerAnim, DestinationId = door.DoorIconFront, Scale = 1 })
		StopAnimation({ Names = { "RoomRewardAvailableRareSparkles", "RoomRewardAvailableGlow", "RoomRewardStreaks" }, DestinationId = door.DoorIconFront })
	end
	if door.AdditionalIcons ~= nil and not IsEmpty( door.AdditionalIcons ) then
		SetAlpha({ Ids = door.AdditionalIcons, Fraction = 0, Duration = 0.1 })
		door.AdditionalIcons = nil
	end
end

function PostRerollPresentation( run, target )
	AdjustColorGrading({ Name = "Off", Duration = 1.0 })
	StopSound({ Id = target.RerollSoundId, Duration = 0.3 })
	thread( PlayVoiceLines, HeroVoiceLines.RerollOutcomeVoiceLines, true )
	wait(0.5)
end

function ThanatosPreSpawnPresentation( eventSource )

	HideCombatUI("ThanatosIntro")

	AdjustColorGrading({ Name = "Thanatos", Duration = 0.5 })
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.5 })
	ShakeScreen({ Distance = 7, Speed = 400, FalloffSpeed = 2000, Duration = 0.5 })
	PlaySound({ Name = "/SFX/ThanatosEntranceSound" })

	wait( 0.5, RoomThreadName )

	thread( PlayVoiceLines, HeroVoiceLines.ThanatosSpawningVoiceLines, true )

	wait( 1.5, RoomThreadName )
	thread( DisplayLocationText, nil, { Text = "ThanatosMessage", Delay = 0.95, FadeColor = {0, 1, 0.7, 1} } )
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAscendedDark" })

	AdjustColorGrading({ Name = "Off", Duration = 3.0, Delay = 3.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.5, Delay = 3.0 })

	wait( 0.5, RoomThreadName )

	SecretMusicPlayer( "/Music/ThanatosTheme_MC" )
	SetSoundCueValue({ Names = { "Keys" }, Id = SecretMusicId, Value = 1 })
	SetSoundCueValue({ Names = { "Drums" }, Id = SecretMusicId, Value = 0 })

end

function ThanatosSpawnPresentation( thanatos )

	AddInputBlock({ Name = "ThanatosSpawnPresentation" })
	SetPlayerInvulnerable( "ThanatosSpawnPresentation" )

	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = thanatos.ObjectId })

	thread( PlayVoiceLines, thanatos.EntranceVoiceLines, nil, thanatos )
	wait( 0.5, RoomThreadName )

	PanCamera({ Ids = thanatos.ObjectId, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	AngleTowardTarget({ Id = thanatos.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })

	wait( 0.35, RoomThreadName )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = thanatos.ObjectId })

	wait( 2.0, RoomThreadName )

	ProcessTextLines( thanatos.BossPresentationIntroTextLineSets )
	ProcessTextLines( thanatos.BossPresentationTextLineSets )
	ProcessTextLines( thanatos.BossPresentationRepeatableTextLineSets )

	if TextLinesRecord["ThanatosFirstAppearance"] then
		wait( 0.5, RoomThreadName )
	else
		wait( 2.0, RoomThreadName )
	end

	if not PlayRandomRemainingTextLines( thanatos, thanatos.BossPresentationIntroTextLineSets ) then
		if not PlayRandomRemainingTextLines( thanatos, thanatos.BossPresentationTextLineSets ) then
			PlayRandomRemainingTextLines( thanatos, thanatos.BossPresentationRepeatableTextLineSets )
		end
	end

	ShowCombatUI("ThanatosIntro")

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

	wait( 0.8, RoomThreadName )

	RemoveInputBlock({ Name = "ThanatosSpawnPresentation" })
	SetPlayerVulnerable( "ThanatosSpawnPresentation" )
end


function ThanatosEncounterStartPresentation( eventSource )

	for k, unit in pairs( ActiveEnemies ) do
		if unit.EncounterStartVoiceLines ~= nil then
			thread( PlayVoiceLines, unit.EncounterStartVoiceLines, nil, unit )
		end
	end

	wait( 0.5, RoomThreadName )

	SetSoundCueValue({ Names = { "Drums" }, Id = SecretMusicId, Value = 1 })

end

function DusaExit( source, args )

	SetAnimationState( source, args )

	source.NextInteractLines = nil
	UseableOff({ Id = source.ObjectId })
	RefreshUseButton( source.ObjectId, source )
	StopStatusAnimation( source )

end

function ThanatosExit( source, args )

	args = args or {}
	if args.UseMaxedPresentation then
		AddInputBlock({ Name = "ThanatosExit" })
	end
	UseableOff({ Id = source.ObjectId })
	source.CanReceiveGift = false
	source.InteractTextLineSets = nil
	wait( args.WaitTime or 0 )

	SetAnimation({ Name = "NPCThanatosExit", DestinationId = source.ObjectId })
	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = source.ObjectId })
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.35 })
	AdjustColorGrading({ Name = "Thanatos", Duration = 0.25 })

	if not args.IgnoreMusic then
		StopSecretMusic( true )
	end

	source.NextInteractLines = nil
	RefreshUseButton( source.ObjectId, source )
	StopStatusAnimation( source )

	if not args.SkipExitReaction then
		thread( PlayVoiceLines, HeroVoiceLines.ThanatosExitReactionVoiceLines, true )
	end

	wait( 0.5, RoomThreadName )
	AdjustColorGrading({ Name = "Off", Duration = 1.35 })

	if args.UseMaxedPresentation then
		MaxedRelationshipPresentation( source, { Text = "NPC_Thanatos_01", Icon = "Keepsake_ThanatosSticker_Max" } )
	end

	source.Mute = true
	CurrentRun.EventState[source.ObjectId] = { FunctionName = "ThanatosExitSilent", Args = args }

	if args.UseMaxedPresentation then
		RemoveInputBlock({ Name = "ThanatosExit" })
	end

	wait( 1.0, RoomThreadName )

	if ActivatedObjects[source.ObjectId] ~= nil and not CurrentRun.Hero.IsDead then
		ActivatedObjects[source.ObjectId] = nil
		wait( 0.2, RoomThreadName )
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
			UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
		end
	end

end

function ThanatosTeleportToExit( enemy, exitId )
	wait(4.0, enemy.AIThreadName)
	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = enemy.ObjectId })
	wait(0.05, enemy.AIThreadName)
	Teleport({ Id = enemy.ObjectId, DestinationId = exitId })
	wait(0.05, enemy.AIThreadName)
	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = enemy.ObjectId })
	wait(0.5, enemy.AIThreadName)
	thread( DirectionHintPresentation, enemy )
end

function ThanatosExitSilent( source, args )
	source.Mute = true
	source.InteractTextLineSets = nil
	source.CanReceiveGift = false
	SetAnimation({ Name = "NPCThanatosExited", DestinationId = source.ObjectId })
end

function OrpheusExit( source, args )

	args = args or {}
	wait( args.WaitTime or 0 )

	SetAnimation({ Name = "NPCOrpheusExit", DestinationId = source.ObjectId })

	source.NextInteractLines = nil
	UseableOff({ Id = source.ObjectId })
	RefreshUseButton( source.ObjectId, source )
	StopStatusAnimation( source )

	source.Mute = true
	if args.AnimationState ~= nil then
		CurrentRun.AnimationState[source.ObjectId] = args.AnimationState
	end

	wait( 1.0, RoomThreadName )

	thread( MaxedRelationshipPresentation, source, { Delay = 1, Title = "MainSubPlotComplete", Text = "OrpheusEurydiceQuestItem", TextRevealSound = "/Leftovers/Menu Sounds/TextReveal3", AnimationName = "LocationTextBG", AnimationOutName = "LocationTextBGOut" } )

	if ActivatedObjects[source.ObjectId] ~= nil and not CurrentRun.Hero.IsDead then
		ActivatedObjects[source.ObjectId] = nil
		wait( 0.2, RoomThreadName )
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
			UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
		end
	end

end

function AchillesExit( source, args )

	args = args or {}
	wait( args.WaitTime or 0 )

	SetAnimation({ Name = "NPCAchillesExit", DestinationId = source.ObjectId })

	source.NextInteractLines = nil
	UseableOff({ Id = source.ObjectId })
	RefreshUseButton( source.ObjectId, source )
	StopStatusAnimation( source )

	source.Mute = true
	if args.AnimationState ~= nil then
		CurrentRun.AnimationState[source.ObjectId] = args.AnimationState
	end

	wait( 1.0, RoomThreadName )

	if args.UseMaxedPresentation ~= nil then
		thread( MaxedRelationshipPresentation, source, { Delay = 1, Title = "MainSubPlotComplete", Text = "AchillesPatroclusQuestItem", TextRevealSound = "/Leftovers/Menu Sounds/TextReveal3", AnimationName = "LocationTextBG", AnimationOutName = "LocationTextBGOut" } )
	end

	if ActivatedObjects[source.ObjectId] ~= nil and not CurrentRun.Hero.IsDead then
		ActivatedObjects[source.ObjectId] = nil
		wait( 0.2, RoomThreadName )
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
			UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
		end
	end
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.2 })
end

function NyxExit( source, args )

	args = args or {}
	wait( args.WaitTime or 0 )

	SetAnimation({ Name = "NPCNyxExit", DestinationId = source.ObjectId })
	CreateAnimation({ Name = "ThanatosTeleport", DestinationId = source.ObjectId })
	SetAlpha({ Id = source.ObjectId, Fraction = 0.0, Duration = 0.35 })

	StopSecretMusic( true )

	source.NextInteractLines = nil
	UseableOff({ Id = source.ObjectId })
	RefreshUseButton( source.ObjectId, source )
	StopStatusAnimation( source )

	wait( 0.5, RoomThreadName )
	AdjustColorGrading({ Name = "Off", Duration = 1.35 })

	wait( 1.0, RoomThreadName )

	source.Mute = true
	if args.AnimationState ~= nil then
		CurrentRun.AnimationState[source.ObjectId] = args.AnimationState
	end

	if ActivatedObjects[source.ObjectId] ~= nil and not CurrentRun.Hero.IsDead then
		ActivatedObjects[source.ObjectId] = nil
		wait( 0.2, RoomThreadName )
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) then
			UnlockRoomExits( CurrentRun, CurrentRun.CurrentRoom )
		end
	end

end

function ThanatosExitAndMaxRelationshipPresentation( source, args )
	ThanatosExit( source, args )
	MaxedRelationshipPresentation( source, args )
end

function Harpy3MapTransition(enemy, currentRun)
	local currentRoom = currentRun.CurrentRoom
	currentRoom.InStageTransition = true

	if currentRoom.Name ~= "A_Boss03" then
		return
	end

	AdjustColorGrading({ Name = "Team02", Duration = 0.5 })

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteDepressed" })
	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	ShakeScreen({ Speed = 1000, Distance = 10, FalloffSpeed = 2000, Duration = 1.5 })
	FocusCamera({ Fraction = 0.97, ZoomType = "Ease", Duration = 2.5 })
	--PanCamera({ Id =  enemy.ObjectId, Duration = 4.0 })

	AdjustRadialBlurDistance({ Fraction = 2.0, Duration = 2.0 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 2.0 })
	thread( DoRumble, { { ScreenPreWait = 0.04, RightFraction = 0.17, Duration = 1.5 } } )
	thread( Harpy3MapRubbleFall )

	for k, simData in ipairs( CurrentRun.Hero.FinalHitSlowParameters ) do
		if simData.Fraction < 1.0 then
			AddSimSpeedChange( "Harpy3MapTransition", { Fraction = simData.Fraction, LerpTime = simData.LerpTime } )
		else
			RemoveSimSpeedChange( "Harpy3MapTransition", { LerpTime = simData.LerpTime } )
		end
	end

	ExpireProjectiles({ ExcludeNames = WeaponSets.MapTransitionExpireProjectileExcludeNames })
	wait( 0.75 )

	ExpireProjectiles({ ExcludeNames = WeaponSets.MapTransitionExpireProjectileExcludeNames })
	AddInputBlock({ Name = "Harpy3MapTransition" })
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	FullScreenFadeOutAnimation()

	wait(0.4)

	FocusCamera({ Fraction = currentRoom.ZoomFraction, Duration = 0.02 })

	if enemy.MapTransitionReactionVoiceLines ~= nil then
		thread( PlayVoiceLines, enemy.MapTransitionReactionVoiceLines, nil, enemy )
	end

	PlaySound({ Name = "/SFX/A_Boss03_RoomTransitionSFX" })
	wait(0.3)
	Teleport({ Id = currentRun.Hero.ObjectId, DestinationId = 40012 })
	Teleport({ Id = enemy.ObjectId, DestinationId = 410021 })
	-- Skelly Summon
	local skellyId = GetIdsByType({ Name = "TrainingMeleeSummon" })
	Teleport({ Id = skellyId, DestinationId = 520857 })
	-- Dusa Summon
	local dusaId = GetIdsByType({ Name = "DusaSummon" })
	Teleport({ Id = dusaId, DestinationId = 520857 })

	local activateObstacles = {}
	local deactivateObstacles = {}

	if currentRoom.CurrentPhase == nil then
		currentRoom.CurrentPhase = 2
	end

	if currentRoom.CurrentPhase == 1 then
		--activateObstacles = GetInactiveIds({ Name = "Phase2Add" })
		--deactivateObstacles = GetIds({ Name = "Phase2Remove" })
	elseif currentRoom.CurrentPhase == 2 then
		activateObstacles = CombineTables( GetInactiveIds({ Name = "Phase3Add" }), GetInactiveIds({ Name = "Phase2Add" }) )
		deactivateObstacles = CombineTables( GetIds({ Name = "Phase3Remove" }), GetIds({ Name = "Phase2Remove" }) )
	elseif currentRoom.CurrentPhase == 3 then
		activateObstacles = GetInactiveIds({ Name = "Phase4Add" })
		deactivateObstacles = GetIds({ Name = "Phase4Remove" })
	else
		DebugPrint({ Text = "Harpy 3: No more phases" })
	end

	for k, id in pairs(activateObstacles) do
		Activate({ Id = id })
	end

	for k, id in pairs(deactivateObstacles) do
		SetAlpha({ Id = id, Fraction = 0.0, Duration = 1.5 })
	end

	currentRoom.CurrentPhase = currentRoom.CurrentPhase + 1
	if currentRoom.CurrentPhase ~= nil then
		thread( Harpy3MapReturnSmoke, currentRoom.CurrentPhase )
	end
	wait( 0.1 )

	local ammoIds = GetIdsByType({ Name = "AmmoPack" })
	SetObstacleProperty({ Property = "Magnetism", Value = 3000, DestinationIds = ammoIds })
	SetObstacleProperty({ Property = "MagnetismSpeedMax", Value = currentRun.Hero.LeaveRoomAmmoMangetismSpeed, DestinationIds = ammoIds })
	StopAnimation({ DestinationIds = ammoIds, Name = "AmmoReturnTimer" })

	RemoveInputBlock({ Name = "Harpy3MapTransition" })
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
	FullScreenFadeInAnimation()
	ShakeScreen({ Speed = 300, Distance = 3, FalloffSpeed = 1000, Duration = 0.65 })
	AdjustRadialBlurDistance({ Fraction = 0.0, Duration = 1.4 })
	AdjustRadialBlurStrength({ Fraction = 0.0, Duration = 1.4 })

	wait(1.3)

	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	currentRoom.InStageTransition = false
end

function Harpy3MapRubbleFall()
	local rubbleLimit = 15
	for index = 1, rubbleLimit, 1 do
		local offsetX = RandomFloat( -400, 400 )
		local offsetY = RandomFloat( -400, 400 )
		local targetId =  SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = offsetX, OffsetY = offsetY })
		FireWeaponFromUnit({ Weapon = "RubbleFall", Id = CurrentRun.Hero.ObjectId, DestinationId = targetId, FireFromTarget = true })
		local rubbleWait = RandomFloat( 0.06, 0.12 )
		wait( rubbleWait )
	end
end

local phaseSmokeObstacles =
{
	[3] = { 519116, 520677, 519118, 518995, 519033, 519037, 519220, 519970, 519010, 519097, 519039, 519074, 519123, 519124, 520676, 519126, 520128, 519020, 519104, 519052, 519082, 511073 },
	[4] = { 518874, 518857, 518880, 518890, 518896, 518902, 518906, 518910, 518914, 520866, 520862, 518948, 518870, 520872, 518894, 518892, 520866, 518864, 518885, 518862 },
}
function Harpy3MapReturnSmoke( currentPhase )
	if currentPhase == nil then
		return
	end
	DebugPrint({ Text = tostring(currentPhase) })
	wait( 0.1 )
	local smokeTable = phaseSmokeObstacles[currentPhase]
	if smokeTable ~= nil then
		for k, obstacleId in pairs( smokeTable ) do
			local randomScale = RandomFloat( 0.8, 1.2 )
			CreateAnimation({ Name = "SmokeTrapLoopDissipate", DestinationId = obstacleId, Group = "FX_Standing_Top", Scale = randomScale })
		end
	end
end

function Harpy3MapRestore()
	local activateObstacles = GetInactiveIds({ Names = { "Phase2Add", "Phase3Add", "Phase4Add", } })
	local deactivateObstacles = GetIds({ Names = { "Phase2Remove", "Phase3Remove", "Phase4Remove", } })

	for k, id in pairs(activateObstacles) do
		Activate({ Id = id })
	end

	for k, id in pairs(deactivateObstacles) do
		SetAlpha({ Id = id, Fraction = 0.0, Duration = 1.5 })
	end

end

function MultiFuryActivations( eventSource, args )
	local boss = ActiveEnemies[args.BossId]
	boss.MultiFuryObstacleIds = {}

	for k, supportAIName in pairs (boss.SupportAINames) do
		Activate({ Id = args.ObstacleIds[supportAIName] })
		boss.MultiFuryObstacleIds[supportAIName] = args.ObstacleIds[supportAIName]
	end
end

function MultiFuryIntro( eventSource, args )
	local boss = ActiveEnemies[args.BossId]
	for k, supportAIName in pairs (boss.SupportAINames) do
		local obstacleName = "MultiFury"..supportAIName.."Intro"
		SetAnimation({ DestinationIds = GetIdsByType({ Name = obstacleName }) , Name = ObstacleData[obstacleName].ExitAnimation })
		wait(0.3)
	end
end

function BiomeOverlook( room, args )
	if not GameState.Flags.Overlook then
		GameState.Flags.Overlook = true

		SetSoundCueValue({ Id = MusicId, Names = { "LowPass" }, Value = 1.0, Duration = 0.5 })
		SetSoundCueValue({ Id = MusicId, Names = { "Keys" }, Value = 0.0, Duration = 3.0 })
		SetVolume({ Id = MusicId, Value = 0.7, Duration = 1.5 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

		thread( PlayVoiceLines, HeroVoiceLines.OverlookVoiceLines, true )
		SetCameraFocusOverride()
		HideCombatUI("Overlook")
		DisableCombatControls()

		wait( 0.6, "OverlookThread" )
		if GameState.Flags.Overlook then
			PanCamera({ Id = args.PanTargetId, Duration = 8, EaseIn = 1, EaseOut = 3, Retarget = true })
			if args.ZoomFraction then
				FocusCamera({ Fraction = args.ZoomFraction, Duration = 8, ZoomType = "Ease" })
			end
		end
	end
end

function BiomeBackToRoom( room, args )
	if GameState.Flags.Overlook then
		GameState.Flags.Overlook = false
		UnblockCombatUI("Overlook")
		EnableCombatControls()
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.5, FromCurrentLocation = true })
		FocusCamera({ Fraction = room.ZoomFraction, Duration = 1.5, ZoomType = "Ease" })

		SetSoundCueValue({ Id = MusicId, Names = { "LowPass" }, Value = 0.0, Duration = 0.5 })
		SetSoundCueValue({ Id = MusicId, Names = { "Keys" }, Value = 1.0, Duration = 1.5 })
		SetVolume({ Id = MusicId, Value = 1, Duration = 1.5 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
		thread( PlayVoiceLines, HeroVoiceLines.OverlookLeaveVoiceLines )
		ClearCameraFocusOverride()
		ShowCombatUI()

		killTaggedThreads( "OverlookThread" )
	end
end

function SunriseOverlook( room, args )
	if not GameState.Flags.Overlook then
		GameState.Flags.Overlook = true

		SetSoundCueValue({ Id = MusicId, Names = { "LowPass" }, Value = 1.0, Duration = 0.5 })
		SetSoundCueValue({ Id = MusicId, Names = { "Keys" }, Value = 0.0, Duration = 3.0 })
		SetVolume({ Id = MusicId, Value = 0.7, Duration = 1.5 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

		thread( PlayVoiceLines, GlobalVoiceLines.SunriseOverlookVoiceLines, true )
		SetCameraFocusOverride()
		HideCombatUI("Overlook")

		wait( 0.6, "OverlookThread" )
		if GameState.Flags.Overlook then
			PanCamera({ Id = args.PanTargetId, Duration = args.CameraPanDuration or 8, EaseIn = 0, EaseOut = 1, Retarget = true })
			FocusCamera({ Fraction = args.ZoomFraction, Duration = args.CameraPanDuration or 8, ZoomType = "Ease" })
		end

		wait( args.SunriseStartDelay or 6.0, "OverlookThread" )
		HandleSunrise( room, args )
	end
end

function HandleSunrise( room, args )
	if room.SunriseActivated then
		return
	end
	room.SunriseActivated = true
	for k, changeData in pairs(args.ObstacleChanges) do
		thread( SunriseChange, args, changeData )
	end
end

function SunriseChange( args, changeData )
	if changeData.Delay ~= nil then
		wait(changeData.Delay)
	end
	if changeData.ChangeColor ~= nil then
		SetColor({ Ids = changeData.ObstacleIds, Color = changeData.ChangeColor, Duration = changeData.Duration or args.Duration, SetBase = true, EaseIn = 0, EaseOut = 1 })
	end
	if changeData.ChangeHSV ~= nil then
		changeData.ChangeHSV[1] = changeData.ChangeHSV[1] / 360
		changeData.ChangeHSV[2] = changeData.ChangeHSV[2] / 100
		changeData.ChangeHSV[3] = changeData.ChangeHSV[3] / 100
		SetHSV({ Ids = changeData.ObstacleIds, HSV = changeData.ChangeHSV, ValueChangeType = "Absolute", Duration = changeData.Duration or args.Duration, EaseIn = 0, EaseOut = 1 })
	end
	if changeData.ChangeAlpha ~= nil then
		SetAlpha({ Ids = changeData.ObstacleIds, Fraction = changeData.ChangeAlpha, Duration = changeData.Duration or args.Duration, EaseIn = args.EaseIn or 0, EaseOut = args.EaseOut or 1 })
	end
	if changeData.Movement ~= nil then
		Move({ Ids = changeData.ObstacleIds, Angle = changeData.Movement.Angle, Distance = changeData.Movement.Distance, Duration = changeData.Movement.Duration or args.Duration, EaseIn = 0, EaseOut = 1 })
	end
end

function RoomStartAlphaChanges( source, args )
	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end
	SetAlpha({ Ids = args.Ids, Fraction = args.Fraction })
end

function SunriseOverlookBackToRoom( room, args )
	if GameState.Flags.Overlook then
		GameState.Flags.Overlook = false
		UnblockCombatUI("Overlook")
		PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.5, FromCurrentLocation = true })
		FocusCamera({ Fraction = room.ZoomFraction, Duration = 1.5, ZoomType = "Ease" })

		SetSoundCueValue({ Id = MusicId, Names = { "LowPass" }, Value = 0.0, Duration = 0.5 })
		SetSoundCueValue({ Id = MusicId, Names = { "Keys" }, Value = 1.0, Duration = 1.5 })
		SetVolume({ Id = MusicId, Value = 1, Duration = 1.5 })
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
		thread( PlayVoiceLines, HeroVoiceLines.OverlookLeaveVoiceLines )
		ClearCameraFocusOverride()

		killTaggedThreads( "OverlookThread" )
	end
end

function AngleIdsTowardPlayer( eventSource, args )
	AngleTowardTarget({ Ids = args.Ids , DestinationId = CurrentRun.Hero.ObjectId })
end
function AngleIds( eventSource, args )
	AngleTowardTarget({ Ids = args.Ids , DestinationId = args.DestinationId })
end

function BountyEarnedPresentation( item )

	if not CurrentRun.CurrentRoom.Milestone then
		return
	end

	local supertitleText = "BountyEarnedSuperTitle"
	if GameState.SpentShrinePointsCache >= GetCurrentRunClearedShrinePointThreshold( GetEquippedWeapon() ) then
		supertitleText = "BountyEarnedSuperTitle_Pact"
	end

	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteThoughtful" })

	-- thread( PlayVoiceLines, GlobalVoiceLines.BountyEarnedVoiceLines )

	thread( DisplayUnlockText, {
		SupertitleText = supertitleText,
		TitleText = "BountyEarnedMessage",
		SubtitleText = item.Name,
		TextRevealSound = "/Leftovers/Menu Sounds/TextReveal2",
		FontScale = 0.8,
		Delay = 0.8,
		Color = {194, 88, 255, 255},
		SupertitleTextColor = {190, 190, 190, 255},
		SupertitleTextDelay = 1.0,
		TextColor = Color.White,
		SubTextColor = {194, 88, 255, 255},
		Icon = item.Name.."Preview",
		Duration = 5.35,
		IconMoveSpeed = 0.00001,
		IconOffsetY = 0,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		SupertitleFont = "AlegreyaSansSCRegular",
		AdditionalAnimation = "BountySparkles",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = { BiomeName = CurrentRun.CurrentRoom.RoomSetName, WeaponName = GetEquippedWeapon() }},
		SupertitleData = { LuaKey = "TempTextData", LuaValue = { BiomeName = CurrentRun.CurrentRoom.RoomSetName, WeaponName = GetEquippedWeapon() }} } )
end

function ModifyEncounterTimerPresentation(amount)
	local encounter = CurrentRun.CurrentRoom.Encounter
	local activeObjective = CurrentRun.ActiveObjectives[CurrentRun.CurrentRoom.Encounter.EncounterType]

	ModifyTextBox({ Id = activeObjective.ObjectId, ColorTarget = {1, 0.8, 0, 1}, ColorDuration = 0.2 })
	ModifyTextBox({ Id = activeObjective.ObjectId, ColorTarget = {1, 1, 1, 1}, ColorDuration = 0.5, Delay = 0.2 })
	thread(PulseText, {Id = activeObjective.ObjectId, ScaleOriginal = 0.4, ScaleTarget = 1.0, ScaleDuration = 0.5, HoldDuration = 0.6})
	wait(0.5)
	CurrentRun.CurrentRoom.Encounter.TimeModifier = CurrentRun.CurrentRoom.Encounter.TimeModifier + amount
	UpdateObjective( encounter.EncounterType, "RemainingSeconds", math.ceil(encounter.RemainingTime))
	PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulse" })
end

function CrowdReactionPresentation( args )

	if args.Chance ~= nil and RandomChance(args.Chance) then
		return
	end

	if not CheckCooldown( "CrowdReactionPresentationPlaying", 8.0 ) and not args.SkipCooldown then
		return
	end

	if args.Requirements ~= nil and not IsGameStateEligible( CurrentRun, args, args.Requirements ) then
		return
	end

	local reactionIds = nil
	if args.Ids ~= nil then
		reactionIds = args.Ids
	elseif args.Groups then
		reactionIds = GetIds({ Names = args.Groups })
	else
		reactionIds = GetIds({ Name = args.Group or "CrowdReaction" })
	end

	wait(args.Delay, RoomThreadName)

	if args.Sound ~= nil then
		PlaySound({ Name = args.Sound })
	end
	for k, id in pairs(reactionIds) do
		if RandomChance(args.ReactionChance) then
			local animationName = args.AnimationName
			if args.AnimationNames ~= nil then
				animationName = GetRandomValue(args.AnimationNames)
			end
			thread(PlayEmote, { TargetId = id, AnimationName = animationName, Shake = args.Shake } )
		end
	end

	if args.RadialBlur then
		AdjustRadialBlurDistance({ Fraction = 0.25, Duration = 0.1 })
		AdjustRadialBlurStrength({ Fraction = 0.45, Duration = 0.1 })
	end

	wait(args.Duration or 0.8, RoomThreadName)

	if args.RadialBlur then
		AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.1 })
		AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.1 })
	end

	for k, enemy in pairs( ActiveEnemies ) do
		if enemy.CrowdReactionVoiceLines ~= nil then
			thread( PlayVoiceLines, enemy.CrowdReactionVoiceLines, true, enemy )
		end
	end

end

function CrowdReactionPresentationEventSource( eventSource, args )
	CrowdReactionPresentation( args )
end

function UpdateEmployeeOfTheMonth( eventSource, args )

	local oldSignId = 555811
	local newSignId = 423452
	if TextLinesRecord["Ending01"] then
		SetAlpha({ Id = oldSignId, Fraction = 0.0, Duration = 0 })
	else
		SetAlpha({ Id = newSignId, Fraction = 0.0, Duration = 0 })
	end
	CurrentRun.EmployeeOfTheMonth = GameState.CurrentEmployeeOfTheMonth

	GameState.LastEmployeeOfTheMonthChange = GameState.LastEmployeeOfTheMonthChange or 0
	local runsSinceLastEmployeeChange = GetCompletedRuns() - GameState.LastEmployeeOfTheMonthChange
	if runsSinceLastEmployeeChange < args.MinRunsPerEmployee or (runsSinceLastEmployeeChange < args.MaxRunsPerEmployee and not RandomChance(args.ChangeChance)) then
		if GameState.CurrentEmployeeOfTheMonth ~= nil and GameData.EmployeeOfTheMonthOptions[GameState.CurrentEmployeeOfTheMonth] ~= nil then
			SetAnimation({ DestinationId = 424933, Name = GameData.EmployeeOfTheMonthOptions[GameState.CurrentEmployeeOfTheMonth].Animation })
		end
		return
	end

	local eligibleEmployees = {}
	for employeeName, employeeData in pairs( GameData.EmployeeOfTheMonthOptions ) do
		if IsEmployeeOfTheMonthEligible(employeeName, employeeData) then
			table.insert(eligibleEmployees, employeeName)
		end
	end

	local newEmployeeOfTheMonth = GetRandomValue(eligibleEmployees)
	GameState.CurrentEmployeeOfTheMonth = newEmployeeOfTheMonth
	CurrentRun.EmployeeOfTheMonth = newEmployeeOfTheMonth
	GameState.LastEmployeeOfTheMonthChange = GetCompletedRuns()
	SetAnimation({ DestinationId = 424933, Name = GameData.EmployeeOfTheMonthOptions[newEmployeeOfTheMonth].Animation })
end

function IsEmployeeOfTheMonthEligible( employeeName, employeeData )
	if GameState.CurrentEmployeeOfTheMonth == employeeName then
		return false
	end

	if not IsGameStateEligible( CurrentRun, employeeData ) then
		return false
	end

	return true
end
function DeathAreaAttackFailPresentation( weaponData, args )

	if weaponData.NoExpressiveAnim then
		return
	end
	if not args.FreshInput then
		return
	end

	if CheckCooldown( "AttackCheck", 0.2 ) then
		-- PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = triggerArgs.triggeredById })
		if CheckCountInWindow( "CannotAttack", 1.0, 3 ) and CheckCooldown( "CannotAttack", 10.0 ) then
			SetAnimation({ Name = "ZagreusInteractionThoughtful", DestinationId = CurrentRun.Hero.ObjectId })
			thread( PlayVoiceLines, HeroVoiceLines.CannotFightVoiceLines, true )
			thread( InCombatText, args.triggeredById, "NoWeaponsInTheHouse", 1.35, { ShadowScaleX = 1.25 } )
		end
	end

end

function PassiveGoldGainPresentation( amount )
	wait(1)
	PlaySound({ Name = "/Leftovers/Menu Sounds/CoinLand", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "GoldPerRoomText", Duration = 1, LuaKey = "TempTextData", LuaValue = { TraitName = "ChamberGoldTrait", Amount = amount }})
end

function FountainDamagePresentation()
	PlaySound({ Name = "/SFX/Player Sounds/DionysusBlightWineDash", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "FountainDamageText_Alt", Duration = 1, LuaKey = "TempTextData", LuaValue = { TraitName = "FountainDamageBonusTrait", Amount = (GetTotalHeroTraitValue("FountainDamageBonus", {IsMultiplier = true}) - 1) * 100 } })
end

function ActivateMegDusaGossiping( source, args )
	if not IsGameStateEligible( CurrentRun, GameData.MegDusaGossipRequirements ) then
		return
	end
	wait( args.Delay or 2.0, RoomThreadName )
	CurrentDeathAreaRoom.GossipingActive = true
	thread( PlayVoiceLines, source.MegDusaGossipingVoiceLines, false, source )
end

function DeactivateMegDusaGossiping( source, args )
	CurrentDeathAreaRoom.GossipingActive = false
end

function UseWaterBowl( usee, args )
	if CheckCooldown( "WaterBowl", 3) then
		local numRuns = 1 + TableLength( GameState.RunHistory )
		local numKills = GameState.TotalRequiredEnemyKills
		thread( PlayVoiceLines, HeroVoiceLines.RunAttemptsVoiceLines, true )
		local lines = {}
		table.insert( lines, GetDisplayName({ Text = "ScryingPoolMessage" })..numRuns )
		table.insert( lines, GetDisplayName({ Text = "ScryingPoolMessage_2" })..numKills )
		DisplayCosmeticInfo( usee, lines )
	end
end

function UseLyre( usee, args )
	local coolDown = 2
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "ZagreusUsingLyre" })
	CreateAnimation({ DestinationId = usee.ObjectId, Name = "HouseMusicNotesShower" })
	IncrementTableValue( GameState.ItemInteractions, "HouseLyre01", 1 )
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "ZagreusInteractEquip", DestinationId = CurrentRun.Hero.ObjectId })
	Shake({ Id = usee.ObjectId, Distance = 1.5, Speed = 150, Duration = 0.15 })
	thread( PlayVoiceLines, HeroVoiceLines.UsedLyreVoiceLines, true )
	if TextLinesRecord.OrpheusMusicProgress03 and GameState.ItemInteractions.HouseLyre01 >= 200 then
		coolDown = 12
		PlaySound({ Name = "/SFX/LyreGood", Id = usee.ObjectId })
		Shake({ Id = usee.ObjectId, Distance = 0.5, Speed = 30, Duration = 5, FalloffSpeed = 30  })
	elseif TextLinesRecord.OrpheusMusicProgress02 and GameState.ItemInteractions.HouseLyre01 >= 80 then
		coolDown = 5
		PlaySound({ Name = "/SFX/LyreMedium", Id = usee.ObjectId })
	else
		PlaySound({ Name = "/SFX/LyreSuck", Id = usee.ObjectId })
	end
	wait( 0.5, RoomThreadName )
	RemoveInputBlock({ Name = "ZagreusUsingLyre" })

	wait( coolDown - 0.5, RoomThreadName )

	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end
end

function MuteHades()
	local hades = ActiveEnemies[370006]
	if hades ~= nil then
		hades.Mute = true
	end
end

function UnmuteHades()
	local hades = ActiveEnemies[370006]
	if hades ~= nil then
		hades.Mute = false
	end
end

function UsePoetBust( usee, args )
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "ZagreusUsingPoetBust" })
	MuteHades()
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "ZagreusTalkEmpathy", DestinationId = CurrentRun.Hero.ObjectId })
	local statueSound = PlaySound({ Name = "/Leftovers/World Sounds/StatueInteract", Id = usee.ObjectId })
	Shake({ Id = usee.ObjectId, Distance = 1, Speed = 100, Duration = 0.3 })
	thread( PlayVoiceLines, HeroVoiceLines.UsedPoetBustVoiceLines, true )
	wait(0.4)
	StopSound({ Id = statueSound, Duration = 0.2 })
	wait(2.6)
	RemoveInputBlock({ Name = "ZagreusUsingPoetBust" })
	wait( 5.0, RoomThreadName )

	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end
	UnmuteHades()
end

function UseStatue( usee, args )
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "ZagreusUsingStatue" })
	MuteHades()
	PlayInteractAnimation( usee.ObjectId )
	local statueSound = PlaySound({ Name = "/Leftovers/World Sounds/StatueInteract", Id = usee.ObjectId })
	Shake({ Id = usee.ObjectId, Distance = 1, Speed = 100, Duration = 0.3 })
	thread( PlayVoiceLines, HeroVoiceLines.UsedStatueVoiceLines, true )
	wait(0.4)
	StopSound({ Id = statueSound, Duration = 0.2 })
	wait(0.5)
	RemoveInputBlock({ Name = "ZagreusUsingStatue" })
	wait( 3.0, RoomThreadName )

	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end
	UnmuteHades()
end

function UseOlympusSculpture( usee, args )
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "ZagreusUsingStatue" })
	MuteHades()
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "ZagreusTalkEmpathy", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.UsedOlympusSculptureVoiceLines, true )
	wait( 3.0 )
	RemoveInputBlock({ Name = "ZagreusUsingStatue" })
	wait( 6.0, RoomThreadName )
	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end
	UnmuteHades()
end

function UseGamingTable( usee, args )
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "ZagreusUsingGamingTable" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "ZagreusInteractionThoughtful", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak", Id = usee.ObjectId })
	Shake({ Id = usee.ObjectId, Distance = 1.5, Speed = 200, Duration = 0.15 })
	thread( PlayVoiceLines, HeroVoiceLines.UsedGamingTableVoiceLines, true )
	wait( 3.25 )
	RemoveInputBlock({ Name = "ZagreusUsingGamingTable" })
	wait( 6.75, RoomThreadName )

	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end
end

function UseBarbell( usee, args )
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	-- AddInputBlock({ Name = "ZagreusUsingPoetBust" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	Shake({ Id = usee.ObjectId, Distance = 1, Speed = 200, Duration = 0.15 })
	PlaySound({ Name = "/SFX/ChainRattleQuiet", Id = usee.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.UsedBarbellVoiceLines, true )
	-- RemoveInputBlock({ Name = "ZagreusUsingPoetBust" })
	wait( 2.0, RoomThreadName )

	if not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end
end

function UseWaterCooler( usee, args )
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "ZagreusUsingWaterCooler" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	PlayInteractAnimation( usee.ObjectId )
	PlaySound({ Name = "/Leftovers/SFX/GeyserSplash", Id = usee.ObjectId })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract", Id = usee.ObjectId })
	Shake({ Id = usee.ObjectId, Distance = 0.75, Speed = 50, Duration = 0.3, FalloffSpeed = 1000 })
	Flash({ Id = usee.ObjectId, Speed = 5, MinFraction = 0, MaxFraction = 0.1, Color = Color.White, Duration = 0.1, ExpireAfterCycle = false })
	thread( PlayVoiceLines, HeroVoiceLines.UsedWaterCoolerVoiceLines, true )
	wait(0.4)
	RemoveInputBlock({ Name = "ZagreusUsingWaterCooler" })
	wait( 3.0, RoomThreadName )
	UseableOn({ Id = usee.ObjectId })
end

function UseOfficePoster( usee, args )
	UseableOff({ Ids = { 488047, 488611, } })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "ZagreusUsingOfficePoster" })
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 423417 })
	SetAnimation({ Name = "ZagreusTalkDenialStart", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.UsedOfficePosterVoiceLines, true )
	wait(2)
	SetAnimation({ Name = "ZagreusTalkDenialReturnToIdle", DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.5)
	RemoveInputBlock({ Name = "ZagreusUsingOfficePoster" })
	wait( 8.0, RoomThreadName )
	UseableOn({ Ids = { 488047, 488611, } })
end

function UseEmployeeSign( usee, args )
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "ZagreusUsingOfficePoster" })
	MuteHades()
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "ZagreusTalkEmpathy", DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.UsedEmployeeSignVoiceLines, true )
	wait( 3 )
	RemoveInputBlock({ Name = "ZagreusUsingOfficePoster" })
	UnmuteHades()
	wait( 999.0, RoomThreadName )
	UseableOn({ Id = usee.ObjectId })
end

function UseLoungeTelescope( usee, args, user )
	UseableOff({ Id = usee.ObjectId })
	thread( HideUseButton, usee.ObjectId, usee )
	AddInputBlock({ Name = "ZagreusUsingTelescope" })
	MuteHades()
	HideCombatUI( "Telescope" )
	PlaySound({ Name = "/SFX/BatFullScreenSFX" })
	SetAudioListener({ Id = usee.ObjectId })

	UnDimTopHall()

	PlayInteractAnimation( usee.ObjectId )

	thread( PlayVoiceLines, HeroVoiceLines.UsedTelescopeVoiceLines, true )

	thread( SendCritters, { MinCount = 45, MaxCount = 45, RandomStartOffsetX = 3200, StartY = 300, MinAngle = 90, MaxAngle = 90, MinSpeed = 4800, MaxSpeed = 5200, MinInterval = 0.01, MaxInterval = 0.01, StartDelay = 0.1, CritterScaleMin = 7.0, CritterScaleMax = 10.0, DrawLayer = "" } )

	local zoomOutTime = 1.8
	PanCamera({ Id = 427344, Duration = zoomOutTime, EaseIn = 0.12, EaseOut = 0.4, })
	FocusCamera({ Fraction = 0.25, Duration = zoomOutTime, ZoomType = "Ease" })

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShort" })
	wait( zoomOutTime, RoomThreadName )

	local notifyName = "PressAnyButton"
	NotifyOnControlPressed({ Names = { "Confirm", "Rush", "Attack1", "Attack2", "Attack3", "Attack4", "MoveLeft", "MoveRight", "MoveUp", "MoveDown", "Interact", "Codex", "Shout", "AutoLock", }, Notify = notifyName })
	waitUntil( notifyName )

	local zoomInTime = 1.0
	PanCamera({ Ids = { CurrentRun.Hero.ObjectId }, Duration = zoomInTime, EaseIn = 0.12, EaseOut = 0.4, })
	FocusCamera({ Fraction = CurrentDeathAreaRoom.ZoomFraction, Duration = zoomInTime, ZoomType = "Ease", })
	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	wait( zoomInTime, RoomThreadName )

	DimTopHall()

	ClearAudioListener({ })
	ShowCombatUI( "Telescope" )
	RemoveInputBlock({ Name = "ZagreusUsingTelescope" })
	UseableOn({ Id = usee.ObjectId })
	UnmuteHades()
end

function UseSundial( usee, args )
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "ZagreusUsingSunDial" })
	MuteHades()
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "ZagreusTalkEmpathy", DestinationId = CurrentRun.Hero.ObjectId })
	local statueSound = PlaySound({ Name = "/Leftovers/World Sounds/StatueInteract", Id = usee.ObjectId })
	Shake({ Id = usee.ObjectId, Distance = 1, Speed = 100, Duration = 0.3 })
	thread( PlayVoiceLines, HeroVoiceLines.UsedSundialVoiceLines, true )
	wait(0.4)
	StopSound({ Id = statueSound, Duration = 0.2 })
	wait(2.6)
	RemoveInputBlock({ Name = "ZagreusUsingSunDial" })
	UnmuteHades()
	wait( 60.0, RoomThreadName )
	UseableOn({ Id = usee.ObjectId })
end

function UseAquarium( usee, args )

	args = args or {}
	UseableOff({ Id = usee.ObjectId })
	HideUseButton( usee.ObjectId, usee )
	AddInputBlock({ Name = "ZagreusUsingAquarium" })
	MuteHades()
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })
	SetAnimation({ Name = "ZagreusTalkEmpathy", DestinationId = CurrentRun.Hero.ObjectId })
	local statueSound = PlaySound({ Name = "/Leftovers/World Sounds/StatueInteract", Id = usee.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/GeyserSplash", Id = usee.ObjectId })
	Shake({ Id = usee.ObjectId, Distance = 0.5, Speed = 50, Duration = 0.3 })
	thread( PlayVoiceLines, HeroVoiceLines.UsedAquariumVoiceLines, true )

	local lines = { "UseAquariumInfo" }
	usee.TotalCaught = GetNumLifetimeFish()
	args.IgnoreUseableToggle = true
	DisplayCosmeticInfo( usee, lines, args )

	wait(0.4)
	StopSound({ Id = statueSound, Duration = 0.2 })
	RemoveInputBlock({ Name = "ZagreusUsingAquarium" })
	wait( 12.0, RoomThreadName )
	UseableOn({ Id = usee.ObjectId })
	UnmuteHades()
end

function HadesLaughDisable( source )
	UseableOff({ Id = source.ObjectId })
	HideUseButton( source.ObjectId, source )
	wait( 5, RoomThreadName )
	UseableOn({ Id = source.ObjectId })
end

function SpecialEventDoorPresentation()
	SetAlpha({ Id = 391709, Fraction = 0.0, Duration = 0.3 })
end

function DisplayCosmeticInfo( usee, lines, args )

	args = args or {}

	if not args.IgnoreUseableToggle then
		UseableOff({ Id = usee.ObjectId })
	end

	local fadeInDuration = 0.5
	local fadeOutDuration = 0.5
	local holdDuration = 2

	local speechbubbleId = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_UI_World_Backing", DestinationId = usee.ObjectId, OffsetY = -150 })
	Shake({ Id = usee.ObjectId, Distance = 2, Speed = 200, Duration = 0.15 })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/DishesInteract", Id = usee.ObjectId })
	PlaySound({ Name = "/Leftovers/World Sounds/ClickSplash", Id = usee.ObjectId })
	CreateAnimation({ Name = "ScryingPoolInteract", DestinationId = usee.ObjectId, Group = "Overlay" })
	SetAnimation({ Name = "GhostDialogue", DestinationId = speechbubbleId, Scale = 1.0 })

	local offsetY = -15
	for k, line in ipairs( lines ) do
		CreateTextBox({
			Id = speechbubbleId,
			Text = line,
			FontSize = 20, Width = 265,
			OffsetX = -157,
			OffsetY = offsetY,
			Justification = "Left",
			Font = "AlegreyaSansSCMedium",
			Color = White,
			OutlineColor = {0.113, 0.113, 0.113, 1},
			OutlineThickness = 2,
			LuaKey = "TempTextData",
			LuaValue = usee,
			LangEsScaleModifier = 0.80,
			LangDeScaleModifier = 0.80,
			LangRuScaleModifier = 0.85,
			LangFrScaleModifier = 0.85,
			LangPtBrScaleModifier = 0.85,
			LangPlScaleModifier = 0.85
			})
		offsetY = offsetY + 32
	end

	Move({ Ids = { speechbubbleId }, Angle = 90, Distance = 20, Duration = fadeInDuration, SmoothStep = true })
	wait( fadeInDuration + holdDuration )

	SetAlpha({ Ids = { speechbubbleId }, Fraction = 0.0, Duration = fadeOutDuration })
	Move({ Ids = { speechbubbleId }, Angle = 90, Distance = 20, Duration = fadeOutDuration, EaseOut = 1 })
	ModifyTextBox({ Ids = { speechbubbleId }, FadeTarget = 0, FadeDuration = fadeOutDuration})
	wait( fadeOutDuration )

	Destroy({ Ids = { speechbubble } })
	wait( 0.25 )
	if not args.IgnoreUseableToggle and not usee.UseableToggleBlocked then
		UseableOn({ Id = usee.ObjectId })
	end

end

function UseSouthHallFountain( usee, args )
	local lines = { "SouthHallFountainMessage" }
	usee.UseCount = (GameState.RoomCountCache.A_Reprieve01 or 0) + (GameState.RoomCountCache.B_Reprieve01 or 0) + (GameState.RoomCountCache.C_Reprieve01 or 0) + (GameState.RoomCountCache.D_Reprieve01 or 0)
	DisplayCosmeticInfo( usee, lines, args )
end

function FishingStartPresentation( fishingPointId, fishingAnimationPointId )
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = fishingPointId })
	wait(0.25)

	thread( PlayVoiceLines, HeroVoiceLines.FishingInitiatedVoiceLines, true )

	SetAnimation({ Name = "ZagreusInteractionFishing_Start", DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.4)

	Destroy({ Id = fishingPointId })

	SetAnimation({ Name = "FishingBobberIdle", DestinationId = fishingAnimationPointId })
	CreateAnimation({ Name = "FishingSplashA", DestinationId = fishingAnimationPointId })
	PlaySound({ Name = "/Leftovers/World Sounds/BigSplash", Id = fishingAnimationPointId })
	thread( DoRumble, { { ScreenPreWait = 0.06, RightFraction = 0.18, Duration = 0.2 }, } )

	-- zag fishing pose
	local showedObjective = CheckObjectiveSet("Fishing")
	if not showedObjective then
		HideCombatUI("Fishing")
		thread( InCombatTextArgs, { Text = "Fishing_Hint", TargetId = CurrentRun.Hero.ObjectId, OffsetY = -205, SkipRise = true, SkipFlash = true, Duration = 1.5, PreDelay = 1.0, ShadowScaleX = 0.66 } )
	end
	if CurrentRun.CurrentRoom.ZoomFraction ~= nil then
		AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction + 0.03, LerpTime = 2.5 })
	else
		AdjustZoom({ Fraction = 1.03, LerpTime = 2.5 })
	end
end

function FishingEndPresentation( fishingAnimationPointId )
	CreateAnimation({ Name = "FishingSplashB", DestinationId = fishingAnimationPointId })
	SetAlpha({ Id = fishingAnimationPointId, Fraction = 0, Duration = 0 })

	CurrentRun.Hero.FishingInput = true
	killTaggedThreads( "Fishing")
	local fishingState = CurrentRun.Hero.FishingState
	local fishName = nil
	local biomeName = CurrentRun.CurrentRoom.FishBiome or CurrentRun.CurrentRoom.RoomSetName or "None"
	fishName = GetFish( biomeName, fishingState )
	local fishData = FishingData.FishValues[fishName]

	if fishName then
		thread( MarkObjectiveComplete, "Fishing" )
		thread( PlayVoiceLines, fishData.FishCaughtVoiceLines )

		--Shake({ Id = CurrentRun.Hero.ObjectId, Distance = 2, Speed = 200, Duration = 0.35 })
		PlaySound({ Name = "/SFX/CriticalHit" })
		PlaySound({ Name = "/VO/ZagreusEmotes/EmotePowerAttacking_Sword" })
		thread( DoRumble, { { ScreenPreWait = 0.04, RightFraction = 0.28, Duration = 0.4 }, } )
		wait(0.1)
		PlaySound({ Name = "/SFX/Player Sounds/ZagreusWhooshDropIn" })
		wait(0.2)
		--Shake({ Id = CurrentRun.Hero.ObjectId, Distance = 2, Speed = 200, Duration = 0.35 })
		PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegDeathSplash", Id = fishingAnimationPointId })
		PlaySound({ Name = "/VO/ZagreusEmotes/EmoteRanged" })
		SetAnimation({ Name = "ZagreusInteractionFishing_PullSuccess", DestinationId = CurrentRun.Hero.ObjectId })
		thread( DoRumble, { { ScreenPreWait = 0.7, LeftFraction = 0.35, Duration = 0.4 }, } )

		RecordFish(fishName)

		PlaySound({ Name = "/Leftovers/SFX/VictoryScreenUpdateSFX", Delay = 1 })

		local fishingText = "Fishing_SuccessGoodTitle"
		if fishingState == "Perfect" then
			fishingText = "Fishing_SuccessPerfectTitle"
		end

		thread( PlayVoiceLines, fishData.FishIdentifiedVoiceLines )

		DisplayUnlockText({
			Icon = fishName,
			TitleText = fishingText,
			SubtitleText = "Fishing_SuccessSubtitle",
			SubtitleData = { LuaKey = "TempTextData", LuaValue = { Name = fishName }},
			IconOffsetY = 20,
			HighlightIcon = true,
			IconMoveSpeed = 0.1,
			IconScale = 0.64,
			AdditionalAnimation = "FishCatchPresentationSparkles",
			IconBacking = "FishCatchIconBacking",
			AnimationName = "LocationTextBGFish",
			AnimationOutName = "LocationTextBGFishOut",
		})

		CheckCodexUnlock( "Fish", fishName )

	else
		thread( MarkObjectiveFailed, "Fishing" )
		--Shake({ Id = CurrentRun.Hero.ObjectId, Distance = 2, Speed = 200, Duration = 0.35 })
		SetAnimation({ Name = "ZagreusInteractionFishing_PullFailure", DestinationId = CurrentRun.Hero.ObjectId })
		PlaySound({ Name = "/Leftovers/SFX/BigSplashRing", Delay = 0.3 })
		PlaySound({ Name = "/SFX/CrappyRewardDrop", Delay = 0.5 })

		PlaySound({ Name = "/Leftovers/SFX/ImpCrowdLaugh" })
		thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.7 }, } )

		if CurrentRun.Hero.FishingState == "TooEarly" then
			thread( PlayVoiceLines, HeroVoiceLines.FishNotCaughtVoiceLines, true )

			thread( DisplayUnlockText, {
			TitleText = "Fishing_FailedTitle",
			SubtitleText = "Fishing_FailedEarly",
			})

		else
			if CurrentRun.Hero.FishingState == "TooLate" then
				thread( PlayVoiceLines, HeroVoiceLines.FishNotCaughtVoiceLines, true )
			elseif CurrentRun.Hero.FishingState == "WayLate" then
				thread( PlayVoiceLines, HeroVoiceLines.FishNotCaughtTooLateVoiceLines, true )
			end

			thread( DisplayUnlockText, {
			TitleText = "Fishing_FailedTitle",
			SubtitleText = "Fishing_FailedLate",
			})
		end
		wait( 2 )
	end
	CurrentRun.CurrentRoom.CompletedFishing = true
	CurrentRun.Hero.FishingStarted = false
	RemoveTimerBlock( CurrentRun, "Fishing" )
	UnfreezePlayerUnit("Fishing")
	UnblockCombatUI("Fishing")

	if CurrentRun.CurrentRoom.ZoomFraction ~= nil then
		AdjustZoom({ Fraction = CurrentRun.CurrentRoom.ZoomFraction, LerpTime = 1.5 })
	else
		AdjustZoom({ Fraction = 1.0, LerpTime = 1.5 })
	end
end

function CheckForFishNotCaughtWayTooLateVoiceLines()
	wait( 14, RoomThreadName )
	while not CurrentRun.Hero.FishingInput do
		thread( PlayVoiceLines, HeroVoiceLines.FishNotCaughtWayTooLateVoiceLines, true )
		wait( 1.5, RoomThreadName )
		if not CurrentRun.Hero.FishingInput then
			thread( InCombatTextArgs, { Text = "Fishing_StopHint", TargetId = CurrentRun.Hero.ObjectId, Duration = 1.25 } )
		end
		wait( 28.0, RoomThreadName )
		if CurrentRun.Hero.FishingInput then
			break
		end
	end
end

function AssistHintPresentation( source, args )
	for traitName, traitDatas in pairs( CurrentRun.Hero.TraitDictionary ) do
		if TraitData[traitName] and TraitData[traitName].Slot == "Assist" and not IsEmpty(traitDatas) and traitDatas[1] and traitDatas[1].AnchorId then
			local existingTraitData = GetExistingUITraitName( traitName )
			local offsetX = 220
			if GetLanguage({}) == "ja" then
				offsetX = offsetX + 30
			end
			thread( InCombatTextArgs, { TargetId = traitDatas[1].AnchorId, Text = "AssistAvailableHint", Duration = 1.25, ScreenSpace = true, OffsetX = offsetX, OffsetY = 0 })
			PlaySound({ Name = existingTraitData.EquipSound or "/Leftovers/SFX/PositiveTalismanProc_1", Id = traitDatas[1].AnchorId })
			return
		end
	end
	thread( InCombatText, CurrentRun.Hero.ObjectId, "AssistAvailableHint", 1 )
end

function ReturnRoomEntrance( currentRun, currentRoom )
	wait(0.03)
	FadeIn({ Duration = 0.0 })
	FullScreenFadeInAnimationBoatRide()
	FlashbackPresentation()
end

-- ending functions from here down
function HandleReturnBoatRideAnimationSetup( eventSource, args  )

	local heroId = CurrentRun.Hero.ObjectId
	local heroBoatId = GetClosest({ Id = heroId, DestinationIds = invisibleTargets })
	local persephoneId = GetClosestUnitOfType({ Id = heroId, DestinationName = "NPC_Persephone_01" })
	local charonId = GetClosestUnitOfType({ Id = heroId, DestinationName = "NPC_Charon_01" })

	SetAnimation({ DestinationId = heroId, Name = CurrentRun.CurrentRoom.BoatAnimData.Zagreus or "ZagreusEndingBoat_IdleLoop" })
	SetAnimation({ DestinationId = persephoneId, Name = CurrentRun.CurrentRoom.BoatAnimData.Persephone or "PersephoneEndingBoat_IdleLoop" })
	CurrentRun.CurrentRoom.BoatRideAnimationsSet = true
	
	SetAnimation({ DestinationId = charonId, Name = "CharonEndingBoatRowIdle" })
end

function HandleReturnBoatRideIntro( eventSource, args )
	AddInputBlock({ Name = "BoatRideIntro" })

	local heroId = CurrentRun.Hero.ObjectId
	local heroBoatId = GetClosest({ Id = heroId, DestinationIds = invisibleTargets })
	local persephoneId = GetClosestUnitOfType({ Id = heroId, DestinationName = "NPC_Persephone_01" })
	local charonId = GetClosestUnitOfType({ Id = heroId, DestinationName = "NPC_Charon_01" })

	ProcessTextLines( ActiveEnemies[persephoneId].InteractTextLineSets )

	BoatSoundId = PlaySound({ Name = "/Leftovers/World Sounds/CaravanWaterMovingLoop", Id = heroBoatId })

	StopSound({ Id = AmbienceId, Duration = 26 })
	AmbienceId = nil
	AmbienceName = nil

	wait( 2 )

	-- this plays from the event PersephoneReturnsHome01
	-- PlayRandomRemainingTextLines( ActiveEnemies[persephoneId], ActiveEnemies[persephoneId].InteractTextLineSets )

	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/NauticalBellCharonCenter", Id = heroBoatId })

	thread( HandleReturnBoatRideEndTheme )
	RemoveInputBlock({ Name = "BoatRideIntro" })
	HandleReturnBoatRide( eventSource, { NextMap = "Return02" } )
end

GlobalVoiceLines.StartingBoatRideVoiceLines =
{
	--[[
	{
		ObjectType = "NPC_Persephone_01",
		SkipAnim = true,

		-- Charon, sir... have anything to listen to along the way?
		{ Cue = "/VO/Persephone_0094", PreLineWait = 3 },
		-- Gguhhhhhh...
		{ Cue = "/VO/Charon_0003", ObjectType = "NPC_Charon_01", PreLineWait = 0.5 },
		-- Oh, I like this one.
		-- { Cue = "/VO/Persephone_0095", PreLineWait = 1.2 },
	},
	]]--
	{
		PreLineWait = 21.5,
		UsePlayerSource = true,
		SkipAnim = true,

		-- Wait, isn't this... Eurydice and Orpheus?
		{ Cue = "/VO/ZagreusField_3676", RequiredTextLines = { "EurydiceAboutOrpheus03" } },
		-- Wait, isn't this Orpheus?
		{ Cue = "/VO/ZagreusField_3677", RequiredFalseTextLines = { "EurydiceAboutOrpheus03" } },
	},
	{
		PreLineWait = 4,
		ObjectType = "NPC_Persephone_01",
		SkipAnim = true,

		-- Mm-hm!
		-- { Cue = "/VO/Persephone_0096", RequiredTextLines = { "EurydiceAboutOrpheus03" } },
		-- Mm-hm! Eurydice and Orpheus.
		-- { Cue = "/VO/Persephone_0097", RequiredFalseTextLines = { "EurydiceAboutOrpheus03" } },
		-- Snow everywhere... Mother...
		{ Cue = "/VO/Persephone_0098" },
	},
}
function HandleReturnBoatRideEndTheme( eventSource, args )

	wait( 2.5 )
	StopSound({ Id = BoatSoundId, Duration = 12 })
	BoatSoundId = nil
	thread( PlayVoiceLines, GlobalVoiceLines.StartingBoatRideVoiceLines )
	wait( 7 )
	thread( MusicPlayer, "/Music/EndTheme" )
end

GlobalVoiceLines.ReturnBoatRideVoiceLines =
{
	{
		PreLineWait = 4.0,
		UsePlayerSource = true,
		RequiredRoom = "Return06",
		SkipAnim = true,

		-- We're here!
		{ Cue = "/VO/ZagreusField_3678" },
	},
	{
		PreLineWait = 1.2,
		ObjectType = "NPC_Persephone_01",
		RequiredRoom = "Return06",
		SkipAnim = true,

		-- We're here!
		{ Cue = "/VO/Persephone_0099" },
	},
}
function HandleReturnBoatRideAudio( eventSource, args )
	thread( PlayVoiceLines, GlobalVoiceLines.ReturnBoatRideVoiceLines, true )
end
function HandleReturnBoatRideOutro( eventSource, args )

	local heroId = CurrentRun.Hero.ObjectId
	local heroBoatId = GetClosest({ Id = heroId, DestinationIds = invisibleTargets })
	local persephoneId = GetClosestUnitOfType({ Id = heroId, DestinationName = "NPC_Persephone_01" })

	thread( PlayVoiceLines, GlobalVoiceLines.EndBoatRideVoiceLines, true )

	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/NauticalBellCharonCenter", Id = heroBoatId })

	wait( 1 )

	local heroId = CurrentRun.Hero.ObjectId
	local persephoneId = GetClosestUnitOfType({ Id = heroId, DestinationName = "NPC_Persephone_01" })
	PlayRandomRemainingTextLines( ActiveEnemies[persephoneId], ActiveEnemies[persephoneId].InteractTextLineSets )

	
	UnblockCombatUI("Surface")
end

function HandleReturnBoatRide( eventSource, args )
	if GetConfigOptionValue({ Name = "EditingMode" }) then
		return
	end
	
	thread( StartCredits )

	HideCombatUI( "BoatRide" )
	AddInputBlock({ Name = "BoatRide" })
	SetPlayerInvulnerable( "BoatRide" )

	local currentRoom = eventSource
	local invisibleTargets = GetIdsByType({ Name = "InvisibleTarget" })

	local heroId = CurrentRun.Hero.ObjectId
	local heroBoatId = GetClosest({ Id = heroId, DestinationIds = invisibleTargets })
	local persephoneId = GetClosestUnitOfType({ Id = heroId, DestinationName = "NPC_Persephone_01" })
	local persephoneBoatId = GetClosest({ Id = persephoneId, DestinationIds = invisibleTargets })
	local charonId = GetClosestUnitOfType({ Id = heroId, DestinationName = "NPC_Charon_01" })
	local charonBoatId = GetClosest({ Id = charonId, DestinationIds = invisibleTargets })
	local boatId = GetClosest({ Id = heroId, DestinationIds = GetIdsByType({ Name = "ReturnShip01" }) })
	local boatFrontId = GetClosest({ Id = heroId, DestinationIds = GetIdsByType({ Name = "ReturnShip01Front" }) })
	local boatMoveTargetId =  GetClosest({ Id = boatId, DestinationIds = GetIdsByType({ Name = "BoatMovePoint" }) })

	StopAmbientSound({ Id = charonId })

	local cameraCreditPoint = SpawnObstacle({ Name = "InvisibleTarget" })
	Attach({ Id = cameraCreditPoint, DestinationId = heroBoatId, OffsetY = 60, OffsetX = -450 })
	if CurrentRun.CurrentRoom.Name == "Return01" then
		PanCamera({ Id = cameraCreditPoint, Duration = 20.5, EaseIn = 0 })
	else
		LockCamera({ Id = cameraCreditPoint, Duration = 0.0 })
	end
	
	Attach({ Id = heroId, DestinationId = heroBoatId })
	Attach({ Id = charonId, DestinationId = charonBoatId })
	Attach({ Id = persephoneId, DestinationId = persephoneBoatId })
	Attach({ Id = boatFrontId, DestinationId = boatId })

	if not CurrentRun.CurrentRoom.BoatRideAnimationsSet then
		SetAnimation({ DestinationId = heroId, Name = CurrentRun.CurrentRoom.BoatAnimData.Zagreus or "ZagreusEndingBoat_IdleLoop" })
		SetAnimation({ DestinationId = persephoneId, Name = CurrentRun.CurrentRoom.BoatAnimData.Persephone or "PersephoneEndingBoat_IdleLoop" })
		CurrentRun.CurrentRoom.BoatRideAnimationsSet = true
	end
	SetAnimation({ DestinationId = charonId, Name = "CharonEndingBoatRow_StartRowing" })

	Move({ Id = boatId, DestinationId = boatMoveTargetId, Speed = 125, SuccessDistance = 30 })

	local notifyName = "WithinDistance"..boatMoveTargetId
	NotifyWithinDistance({ Id = boatId, DestinationId = boatMoveTargetId, Distance = 200, Notify = notifyName })
	waitUntil( notifyName )

	if args.NextMap ~= nil then
		LeaveRoomWithNoDoor( eventSource, args )
	else
		SetAnimation({ DestinationId = charonId, Name = "CharonEndingBoatRow_StopRowing" })
	end
end

function DelayedFidget( data )
	wait(data.Delay)
	SetAnimation({ DestinationId = data.Id, Name = data.AnimationName })
end

function ReturnRoomExit( currentRun, exitDoor )
	AddInputBlock({ Name = "RoomExit" })
	FullScreenFadeOutAnimationBoatRide()
	RemoveInputBlock({ Name = "RoomExit" })
end

function BoatToDeathAreaTransition( eventSource, args )

	local heroId = CurrentRun.Hero.ObjectId
	local persephoneId = GetClosestUnitOfType({ Id = heroId, DestinationName = "NPC_Persephone_01" })
	local houseDoorId = GetClosest({ Id = heroId, DestinationIds = GetIdsByType({ Name = "HouseDoor02" }) })

	AddInputBlock({ Name = "ExitToDeathAreaPresentation" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })

	wait(0.8)

	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockBoom", Id = houseDoorId })

	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.3, Delay = 0.45 })

	LockCamera({ Id = houseDoorId, EaseIn = 0.04, EaseOut = 0.275, Duration = 13 })
	wait(0.5)
	SetAnimation({ DestinationId = houseDoorId, Name = "HouseDoor02Open" })

	wait(1.75)

	FullScreenFadeOutAnimationBoatRide()

	wait(3.0)
	
	ShowInterMapComponents()

	AllowShout = false

	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })
	RemoveInputBlock({ Name = "ExitToDeathAreaPresentation" })

end

function StartCustomDeathAreaAmbience()

	-- start echoey / wet
	local reverbValue = 2.0
	local numTrue = 0
	-- reduce echoey / wetness as more cosmetics added to main hall
	for k, name in pairs( GameData.MiscCosmetics ) do
		if GameState.CosmeticsAdded[name] ~= nil then
			numTrue = numTrue + 1
		end
	end
	if numTrue >= 6 and numTrue < 12 then
		reverbValue = 1.7
	elseif numTrue >= 12 and numTrue < 22 then
		reverbValue = 1.5
	elseif numTrue >= 22 and numTrue < 32 then
		reverbValue = 1.3
	elseif numTrue >= 32 then
		reverbValue = 1.0
	end
	SetAudioEffectState({ Name = "Reverb", Value = reverbValue })

end
function StartCustomDeathAreaLoungeAmbience()

	-- start echoey / wet
	local reverbValue = 1.5
	local numTrue = 0
	-- reduce echoey / wetness as more cosmetics added to main hall
	for k, name in pairs( GameData.LoungeCosmetics ) do
		if GameState.CosmeticsAdded[name] ~= nil then
			numTrue = numTrue + 1
		end
	end
	if numTrue >= 3 and numTrue < 6 then
		reverbValue = 1.3
	elseif numTrue >= 6 and numTrue < 10 then
		reverbValue = 1.0
	elseif numTrue >= 10 and numTrue < 14 then
		reverbValue = 0.7
	elseif numTrue >= 18 then
		reverbValue = 0.5
	end
	SetAudioEffectState({ Name = "Reverb", Value = reverbValue })

end

OnUsed{ "ForbiddenShopItem",
	function( triggerArgs )
		PlayInteractAnimation( triggerArgs.triggeredById )
	end
}
function ForbiddenShopItemTaken( source, args )
	args = args or {}
	local charonId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_Charon_01" })
	
	AddTimerBlock(CurrentRun, "StealPresentation")
	AddInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })

	HideCombatUI()

	thread( PlayVoiceLines, HeroVoiceLines.ForbiddenShopItemTakenVoiceLines )

	wait(0.1)

	StopSecretMusic()
	EndAmbience( 0.1 )
	StopAmbientSound({ All = true })

	wait(0.2)
	PlaySound({ Name = "/SFX/Menu Sounds/RecordScratch" })
	SetThingProperty({ Property = "AmbientSound", Value = "/EmptyCue", DestinationId = charonId })

	LockCamera({ Ids = { CurrentRun.Hero.ObjectId, charonId }, Duration = 0.22 })
	FocusCamera({ Fraction = 0.975, Duration = 0.3, ZoomType = "Overshoot" })

	wait(0.2)

	AngleTowardTarget({ Id = charonId, DestinationId = CurrentRun.Hero.ObjectId })
	thread( PlayVoiceLines, GlobalVoiceLines.CharonSurprisedVoiceLines )

	wait(0.8)

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = charonId })
	wait(0.10)
	SetAnimation({ Name = "ZagreusTalkEmpathy", DestinationId = CurrentRun.Hero.ObjectId })

	wait(2.0)
	thread( PlayVoiceLines, HeroVoiceLines.ForbiddenShopItemCaughtVoiceLines )

	local soundId = PlaySound({ Name = "/Leftovers/Object Ambiences/ThunderLoop" })

	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 3000, Duration = 5.0 })

	StopSound({ Id = soundId, Duration = 5 })
	soundId = nil

	AdjustFullscreenBloom({ Name = "LightningStrike", Duration = 0.1 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.1 })
	AdjustRadialBlurDistance({ Fraction = 0.125, Duration = 0.1 })

	LockCamera({ Ids = { CurrentRun.Hero.ObjectId }, Duration = 7 })

	wait(2.7)

	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.03 })
	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.03 })


	SetAnimation({ Name = "ZagreusSecretDoorDive", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/AscensionConfirm" })
	thread( DoRumble, { { ScreenPreWait = 0.02, Fraction = 0.15, Duration = 0.7 }, } )
	Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 0.5, MinFraction = 0, MaxFraction = 1.0, Color = Color.White, Duration = 1.0, ExpireAfterCycle = false })
	AdjustColorGrading({ Name = "Chaos", Duration = 0.7 })

	wait(0.7)

	CreateAnimation({ Name = "ZagreusSecretDoorDiveFadeFx", DestinationId = CurrentRun.Hero.ObjectId })
	SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0, Duration = 0.13 })

	wait(0.4)
	FullScreenFadeOutAnimation()
	wait(0.2)

	RemoveInputBlock({ Name = "LeaveRoomPresentation" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })

	RemoveTimerBlock(CurrentRun, "StealPresentation")
	args.NextMap = "CharonFight01"
	CurrentRun.CurrentRoom.ExitFunctionName = "ExitToCharonFightPresentation"
	LeaveRoomWithNoDoor( source, args )
end

function ExitToCharonFightPresentation( currentRun, exitDoor )
	ShowInterMapComponents()
	-- Mostly handled in ForbiddenShopItemTaken()
end

function ConsumableUsedPresentation( run, consumableItem, args )

	if consumableItem.OnConsumedGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[consumableItem.OnConsumedGlobalVoiceLines], true )
	end
	if consumableItem.Cost ~= nil and consumableItem.Cost > 0 then
		PlaySound({ Name = "/Leftovers/Menu Sounds/StoreBuyingItem" })
		if consumableItem.PurchasedVoiceLines ~= nil then
			thread( PlayVoiceLines, consumableItem.PurchasedVoiceLines, true )
		elseif consumableItem.OnPurchaseGlobalVoiceLines ~= nil then
			thread( PlayVoiceLines, GlobalVoiceLines[consumableItem.OnPurchaseGlobalVoiceLines], true )
		else
			if not consumableItem.BlockPurchasedVoiceLines then
				thread( PlayVoiceLines, GlobalVoiceLines.PurchasedConsumableVoiceLines, true )
			end
		end
	end
	if consumableItem.PlayInteract then
		PlayInteractAnimation( args.triggeredById )
	end
	if consumableItem.AcquireText then
		thread( InCombatText, args.triggeredById, consumableItem.AcquireText )
	end

	PlaySound({ Name = consumableItem.ConsumeSound or "/SFX/GyroHealthPickupMunch", Id = consumableItem.ObjectId })
	thread( PlayVoiceLines, consumableItem.ConsumedVoiceLines, true )

end

function StorePurchasePresentation( screen, button, upgradeData )
	-- thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "Player_Purchase", Group = "Combat_UI_World_Backing", Duration = 1, LuaKey = "TempTextData", LuaValue = { Name = upgradeData.Name }})
	PlaySound({ Name = upgradeData.OnPurchaseSound or "/Leftovers/Menu Sounds/StoreSellingItem" })
	if upgradeData.OnPurchaseGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines[upgradeData.OnPurchaseGlobalVoiceLines], true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.PurchasedWellShopItemVoiceLines, true )
	end
end

function FishingPointAvailablePresentation( currentRoom )
	SetAnimation({ Name = "FishingPointActive", DestinationId = currentRoom.FishingPointId })
	wait( 0.25, RoomThreadName )
	PlaySound({ Name = "/Leftovers/SFX/AnnouncementPing7", Id = currentRoom.FishingPointId })
end

function StartDevotionTestPresentation( currentRoom, alternateLootData, alternateLootId )
	AddInputBlock({ Name = "DevotionTest" })
	wait(1.0)
	Shake({ Id = alternateLootData.ObjectId, Distance = 2, Speed = 250, Duration = 1.0  })
	PanCamera({ Ids = alternateLootData.ObjectId, Duration = 3.5, EaseIn = 0.05, EaseOut = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.15, LeftFraction = 0.17, Duration = 1.0 }, } )
	-- thread( InCombatText, alternateLootId, "Player_GodDispleased_"..alternateLootData.Name, 2.5 )
	-- AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = alternateLootId })

	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3", Id = alternateLootId })
	wait(0.5)
	PlaySound({ Name = "/SFX/Menu Sounds/PortraitEmoteAngerSFX" })

	PlayRandomRemainingTextLines( alternateLootData, alternateLootData.RejectionTextLines )
	PanCamera({ Ids = CurrentRun.Hero.ObjectId, Duration = 1.0, EaseIn = 0.05, EaseOut = 0.3 })

	if alternateLootData.RejectionVoiceLines ~= nil then
		thread( PlayVoiceLines, alternateLootData.RejectionVoiceLines )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.GodRejectedVoiceLines, true )
	end
	wait(1.0)
	if alternateLootData.LootRejectionAnimation then
		CreateAnimation({ Name = alternateLootData.LootRejectionAnimation, DestinationId = alternateLootId })
	else
		CreateAnimation({ Name = "BoonOrbDissipate", DestinationId = alternateLootId, Color = Color.Red })
	end
	PlaySound({ Name = "/SFX/GodFavorBattleStart" })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal2" })
end

function BiomeTimeCheckpointPresentation( run, additionalTime )

	wait( 1.0, RoomThreadName )

	local textAnchorId = CreateScreenObstacle({ Name = "BlankObstacle", X = 88, Y = 905, Group = "Overlay" })

	CreateTextBox({
		Id = textAnchorId,
		Text = "BiomeTimeCheckpoint",
		LuaKey = "TempTextData",
		LuaValue = { Minutes = round(additionalTime / 60) },
		OffsetX = 0,
		OffsetY = 0,
		Font = "AlegreyaSansExtraBoldItalic",
		FontSize = 22,
		Color = Color.White,
		OutlineThickness = 0,
		OutlineColor = {0.0, 0.0, 0.0,1},
		ShadowColor = {0,0,0,1},
		ShadowOffsetY=2,
		ShadowOffsetX=0,
		ShadowAlpha=1,
		ShadowBlur=0,
	})


	SetAnimation({ Name = "BiomeTimerTimeAdded", DestinationId = textAnchorId })

	wait( 2.0, RoomThreadName )

	Move({ Id = textAnchorId, OffsetX = 88, OffsetY = 930, Duration = 0.5, EaseIn = 0, EaseOut = 1 })
	ModifyTextBox({ Id = textAnchorId, FadeTarget = 0, FadeDuration = 0.5 })

	wait( 0.5, RoomThreadName )

	Destroy({ Id = textAnchorId })
end

function SurfaceToBoatRideExit( currentRun, exitDoor )
	FullScreenFadeOutAnimationBoatRide()
end

function CottageBloom( )
	wait( 0.30 )
	--AdjustRadialBlurDistance({ Fraction = 2.5, Duration = 0.6 })
	--AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.6 })
	AdjustColorGrading({ Name = "CottageTrellis", Duration = 2, Delay = 0.0, })
	AdjustFullscreenBloom({ Name = "CottageBloom", Duration = 2.0 })
	wait( 2.5 )
	AdjustColorGrading({ Name = "Off", Duration = 3, Delay = 0.0, })
	AdjustFullscreenBloom({ Name = "Off", Duration = 3.0 })
	--AdjustRadialBlurDistance({ Fraction = 0.0, Duration = 1.5 })
	--AdjustRadialBlurStrength({ Fraction = 0.0, Duration = 1.5 })
end

function HandleAchillesBedroomObjective()
	CheckObjectiveSet("AchillesBedroomPrompt")
end

function HandleWeaponAspectsRevealObjective()
	wait(2.3)
	CheckObjectiveSet("AspectsRevealPrompt")
end

function BoatRideSupportiveShadeReact(  eventSource, args  )
	CrowdReactionPresentation(args)
end