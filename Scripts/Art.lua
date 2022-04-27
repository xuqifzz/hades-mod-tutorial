local checkShadows = false
function DoPlayerShadows( currentRun )
	local shadowIds = GetIds({ Name = "PlayerShadows" })
	local heroId = currentRun.Hero.ObjectId

	local inShadow = "InShadow"
	local outOfShadow = "OutOfShadow"
	checkShadows = true
	while( checkShadows ) do

		NotifyOnCollide({ Id = heroId, DestinationIds = shadowIds, Notify = inShadow })
		waitUntil( inShadow )
		SetThingProperty({ Property = "Ambient", Value = 0.7, DestinationId = currentRun.Hero.ObjectId })

		if checkShadows then
			NotifyNotColliding({ Id = heroId, DestinationIds = shadowIds, Notify = outOfShadow })
			waitUntil( outOfShadow )
			SetThingProperty({ Property = "Ambient", Value = 0.0, DestinationId = currentRun.Hero.ObjectId })
		end

	end
end

function SetupRoomArt( currentRun, currentRoom )
	local currentArea = currentRun.CurrentRoom.RoomSetName

	if currentArea == "Secrets" then
		thread( DoPlayerShadows, currentRun )
		CreateAnimation({ Name = "ReflectionBlob", DestinationId = currentRun.Hero.ObjectId, OffsetY = 100, Scale = 1 })
	elseif currentArea == "Tartarus" then
		thread( DoPlayerShadows, currentRun )
	end

	if currentRoom.FootstepAnimationL ~= nil then
		SwapAnimation({ Name = "FireFootstepL-Spawner", DestinationName = currentRoom.FootstepAnimationL })
	end
	if currentRoom.FootstepAnimationR ~= nil then
		SwapAnimation({ Name = "FireFootstepR-Spawner", DestinationName = currentRoom.FootstepAnimationR })
	end

	if currentRoom.SwapAnimations ~= nil then
		for fromAnim, toAnim in pairs( currentRoom.SwapAnimations ) do
			SwapAnimation({ Name = fromAnim, DestinationName = toAnim })
		end
	end

	if currentRoom.SwapSounds ~= nil then
		for fromSound, toSound in pairs( currentRoom.SwapSounds ) do
			SwapSound({ Name = fromSound, DestinationName = toSound })
		end
	end

end

function TeardownRoomArt( currentRun, currentRoom )

	checkShadows = false
	killWaitUntilThreads("InShadow")
	killWaitUntilThreads("OutOfShadow")

	SetThingProperty({ Property = "Ambient", Value = 0.0, DestinationId = currentRun.Hero.ObjectId })
end