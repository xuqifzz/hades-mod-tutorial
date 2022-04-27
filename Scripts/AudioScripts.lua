-- **MINOS AUDIO**
AudioState = {}

OnAnyLoad{
	function( triggerArgs )

		DeferredPlayVoiceLines = {}

		if MusicName ~= nil and MusicId == nil then
			-- Out of sync (presumably from a load)
			local restoreTrackName = MusicName
			local restoreMusicSection = MusicSection
			MusicName = nil
			MusicSection = nil
			MusicPlayer( restoreTrackName )
			SetMusicSection( restoreMusicSection )
			if MusicId ~= nil then
				if MusicActiveStems ~= nil then
					SetSoundCueValue({ Names = MusicActiveStems, Id = MusicId, Value = 1 })
				end
				if MusicMutedStems ~= nil then
					SetSoundCueValue({ Names = MusicMutedStems, Id = MusicId, Value = 0 })
				end
			else
				MusicActiveStems = nil
				MusicMutedStems = nil
			end
			if MusicPlayerTrackPaused and MusicPlayerTrackData[MusicName] ~= nil then
				PauseMusic()
			end
		end

		if AmbientTrackName ~= nil and AmbientMusicSource ~= nil and AmbientMusicId == nil then
			-- Out of sync (presumably from a load)
			local restoreTrackName = AmbientTrackName
			AmbientTrackName = nil
			wait(0.02) -- Need to wait for potential stored targets to spawn
			local source = ActiveEnemies[AmbientMusicSource.ObjectId]
			if source ~= nil then
				MusicianMusic( source, { TrackName = restoreTrackName } )
				if CurrentDeathAreaRoom ~= nil then
					if CurrentDeathAreaRoom.AmbientMusicParams ~= nil then
						for param, value in pairs( CurrentDeathAreaRoom.AmbientMusicParams ) do
							SetSoundCueValue({ Id = AmbientMusicId, Name = param, Value = value, Duration = 0.5 })
						end
					end
					SetVolume({ Id = AmbientMusicId, Value = CurrentDeathAreaRoom.AmbientMusicVolume, Duration = 0.5 })
				end
			end
		end
	end
}


function DeferredAudioScripts()
	for index, params in ipairs(DeferredPlayVoiceLines) do
		thread( PlayVoiceLinesReal, params[1], params[2], params[3], params[4] )
	end
	DeferredPlayVoiceLines = {}
end

-- **Music**

function MusicPlayerEvent( source, args )
	MusicPlayer( args.TrackName, args.MusicInfo, args.DestinationId )
end

function MusicPlayer( trackName, musicInfo, destinationId )

	if trackName == nil then
		return false
	end

	if MusicName ~= nil and MusicName == trackName then
		-- Don't play an identical track that's already playing
		-- But do still update the source if it is being changed
		SetSoundSource({ Id = MusicId, DestinationId = destinationId })
		return false
	end

	if MusicId ~= nil then
		-- Quick cut any music still playing
		StopSound({ Id = MusicId, Duration = 0.25 })
		MusicId = nil
	end
	if StoppingMusicId ~= nil then
		-- Quick cut any music still fading out
		StopSound({ Id = StoppingMusicId, Duration = 0.25 })
		StoppingMusicId = nil
	end

	MusicName = trackName
	MusicId = PlaySound({ Name = MusicName, AddCallbacks = true, Id = destinationId })
	SetDefaultMusicParams( MusicName, MusicId )

	if musicInfo ~= nil then
		musicInfo.Id = MusicId
		musicInfo.Name = MusicName
	end

	if SecretMusicId ~= nil then
		-- Secret music has priority and is mutually exclusive so this must wait
		SetVolume({ Id = MusicId, Value = 0.0, Duration = 0.0 })
		PauseSound({ Id = MusicId, Duration = 0.0 })
	end

	return true

end

function SecretMusicPlayer( trackName, musicInfo )

	if trackName == nil then
		return false
	end

	if SecretMusicName == trackName then
		-- Don't play an identical track that's already playing
		return
	end

	if MusicId ~= nil then
		-- Quick cut any music still playing
		PauseMusic()
	end
	if SecretMusicId ~= nil then
		-- Quick cut any music still playing
		StopSound({ Id = SecretMusicId, Duration = 0.25 })
	end

	SecretMusicName = trackName
	SecretMusicId = PlaySound({ Name = SecretMusicName, AddCallbacks = true })
	SetDefaultMusicParams( SecretMusicName, SecretMusicId )

	if musicInfo ~= nil then
		musicInfo.Id = SecretMusicId
		musicInfo.Name = SecretMusicName
	end

	return true

end

function StopSecretMusic( smoothStop )

	if SecretMusicId == nil then
		return
	end

	if smoothStop then
		EndMusic( SecretMusicId, SecretMusicName )
	else
		StopSound({ Id = SecretMusicId, Duration = 0.25 })
	end
	SecretMusicId = nil
	SecretMusicName = nil

end

function ChaosBassStart()
	SetSoundCueValue({ Names = { "ChaosBass" }, Id = SecretMusicId, Value = 1, Duration = 0.5 })
end
function ChaosBassStop()
	SetSoundCueValue({ Names = { "ChaosBass" }, Id = SecretMusicId, Value = 0, Duration = 3 })
end

function SingingPresentation( source, ars )
	if source.SingingFx ~= nil then
		CreateAnimation({ Name = source.SingingFx, DestinationId = source.ObjectId, OffsetX = source.SingingAnimOffsetX or source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
	end
	if source.SingingAnimation ~= nil then
		SetAnimation({ Name = source.SingingAnimation, DestinationId = source.ObjectId })
	end
	if source.PartnerSingingAnimation ~= nil and source.PartnerObjectId ~= nil then
		SetAnimation({ Name = source.PartnerSingingAnimation, DestinationId = source.PartnerObjectId })
	end
end

function MusicianMusic( source, args )

	if CurrentRun.BlockAmbientMusic then
		return
	end

	CurrentRun.EventState[source.ObjectId] = { FunctionName = "SingingPresentation", Args = args }
	SingingPresentation( source, args )

	if args.TrackName == AmbientTrackName then
		-- Don't play an identical track that's already playing
		-- But do still update the source if it is being changed
		SetSoundSource({ Id = AmbientMusicId, DestinationId = source.ObjectId })
		AmbientMusicSource = source
		return
	end

	if AmbientMusicId ~= nil then
		-- Quick cut the previously playing id
		StopSound({ Id = AmbientMusicId, Duration = 0.25 })
		AmbientMusicId = nil
	end

	--Shake({ Id = source.ObjectId, Distance = 1, Speed = 3, Duration = 9999, Angle = 0 })

	AmbientMusicSource = source
	AmbientMusicId = PlaySound({ Name = args.TrackName, Id = source.ObjectId })
	SetSoundCueValue({ Names = { "Vocals", }, Id = AmbientMusicId, Value = 1 })
	AmbientTrackName = args.TrackName
	SetVolume({ Id = AmbientMusicId, Value = 1 })
	if args.TrackOffsetMin ~= nil then
		SetSoundPosition({ Id = AmbientMusicId, Position = RandomFloat( args.TrackOffsetMin, args.TrackOffsetMax ) })
	end
	-- Workaround for FMOD bug, after a long play-session VO played in 2D can become inaudible.  Pausing and unpausing the sound fixes it.
	thread( PauseUnpauseSoundWorkaround, AmbientMusicId )

end

-- Workaround for FMOD bug, after a long play-session VO played in 2D can become inaudible.  Pausing and unpausing the sound fixes it.
function PauseUnpauseSoundWorkaround( soundId )
	wait( 0.03 )
	PauseSound({ Id = soundId, Duration = 0 })
	ResumeSound({ Id = soundId, Duration = 0 })
end

function StopMusicianMusic( source, args )
	StopSound({ Id = AmbientMusicId, Duration = args.Duration or 0.2 })
	AmbientMusicId = nil
	AmbientTrackName = nil
	if source ~= nil and source.ObjectId ~= nil then
		CurrentRun.EventState[source.ObjectId] = nil
	end
end

function SetDefaultMusicParams( trackName, musicId )

	SetSoundCueValue({ Names = { "Keys" }, Id = musicId, Value = 1 })
	SetSoundCueValue({ Names = { "Guitar", "Drums", "Bass" }, Id = musicId, Value = 1 })

	SetMusicSection( 1, musicId )

end

function RandomStemMixer( currentRoom, musicId )
	if musicId == nil then
		return
	end
	if currentRoom.IgnoreStemMixer then
		return
	end
	local musicSetup = RandomInt( 1, currentRoom.RandomStemMixerOptions or 3 )
	if musicSetup == 1 then
		-- guitar, bass, drums
		SetSoundCueValue({ Names = { "Guitar" }, Id = musicId, Value = 1, Duration = 2.5 })
		SetSoundCueValue({ Names = { "Bass" }, Id = musicId, Value = 1, Duration = 2.5 })
		SetSoundCueValue({ Names = { "Drums" }, Id = musicId, Value = 1, Duration = 0.25 })
	elseif musicSetup == 2 then
		-- drums only
		SetSoundCueValue({ Names = { "Guitar" }, Id = musicId, Value = 0, Duration = 10 })
		SetSoundCueValue({ Names = { "Bass" }, Id = musicId, Value = 0, Duration = 10 })
		SetSoundCueValue({ Names = { "Drums" }, Id = musicId, Value = 1, Duration = 0.25 })
	elseif musicSetup == 3 then
		-- bass and drums only
		SetSoundCueValue({ Names = { "Guitar" }, Id = musicId, Value = 0, Duration = 10 })
		SetSoundCueValue({ Names = { "Bass" }, Id = musicId, Value = 1, Duration = 2.5 })
		SetSoundCueValue({ Names = { "Drums" }, Id = musicId, Value = 1, Duration = 0.25 })
	else
		-- guitar and drums only
		SetSoundCueValue({ Names = { "Guitar" }, Id = musicId, Value = 1, Duration = 10 })
		SetSoundCueValue({ Names = { "Bass" }, Id = musicId, Value = 0, Duration = 2.5 })
		SetSoundCueValue({ Names = { "Drums" }, Id = musicId, Value = 1, Duration = 0.25 })
	end
end

function MusicMixer( mixArgs )
	if mixArgs == nil then
		return
	end

	if mixArgs.MusicMixerRequirements ~= nil and not IsGameStateEligible( CurrentRun, mixArgs, mixArgs.MusicMixerRequirements ) then
		return
	end

	wait( mixArgs.MusicStartDelay )

	if mixArgs.PlayBiomeMusic then
		local biomeName = CurrentRun.CurrentRoom.RoomSetName
		local biomeMusicTracks = MusicTrackData[biomeName]
		if biomeMusicTracks ~= nil then
			if BiomeMusicPlayCounts[biomeName] == nil then
				BiomeMusicPlayCounts[biomeName] = 0
			end
			local trackIndex = (BiomeMusicPlayCounts[biomeName] % #biomeMusicTracks) + 1
			local trackData = biomeMusicTracks[trackIndex]
			MusicPlayer( trackData.Name, trackData )
			BiomeMusicPlayCounts[biomeName] = BiomeMusicPlayCounts[biomeName] + 1
		end
	end

	if MusicId == nil then
		return
	end
	if mixArgs.MusicActiveStems ~= nil then
		MusicActiveStems = mixArgs.MusicActiveStems
		SetSoundCueValue({ Names = mixArgs.MusicActiveStems, Id = MusicId, Value = 1, Duration = 0.75 })
	end
	if mixArgs.MusicMutedStems ~= nil then
		MusicMutedStems = mixArgs.MusicMutedStems
		SetSoundCueValue({ Names = mixArgs.MusicMutedStems, Id = MusicId, Value = 0, Duration = mixArgs.MusicMutedStemsDuration or 0.75 })
	end
	if mixArgs.MusicSection ~= nil then
		SetMusicSection( mixArgs.MusicSection )
	end
	if mixArgs.UseRoomMusicSection ~= nil and CurrentRun.CurrentRoom.MusicSection ~= nil then
		SetMusicSection( CurrentRun.CurrentRoom.MusicSection )
	end

end

function CheckMusicEvents( currentRun, musicEvents )

	if musicEvents == nil then
		return
	end

	for k, musicEvent in ipairs( musicEvents ) do

		if IsGameStateEligible( currentRun, musicEvent, musicEvent.GameStateRequirements ) then

			if musicEvent.EndMusic then
				EndMusic()
			end

			thread( MusicMixer, musicEvent )

		end

	end

end

function StartBossRoomMusic()
	SetMusicSection( 2 )
	local activeStemTable = { "Guitar", "Bass", "Drums" }
	SetSoundCueValue({ Names = activeStemTable, Id = MusicId, Value = 1, Duration = 0.75 })
end

function EndMusic( musicId, musicName, hardStopTime )
	if musicId == nil then
		musicId = MusicId
	end
	if musicName == nil then
		musicName = MusicName
	end
	if hardStopTime == nil then
		hardStopTime = 20
	end

	if musicId == nil then
		return
	end

	SetMusicSection( 10, musicId )

	if hardStopTime ~= nil then
		StopSound({ Id = musicId, Value = 0.0, Duration = hardStopTime })
		StoppingMusicId = musicId
	end

	if musicId == MusicId then
		MusicId = nil
		MusicName = nil
		MusicSection = nil
	end

end

function PauseMusic()
	PauseSound({ Id = MusicId, Duration = 0.2 })
end

function ResumeMusic( duration, delay )
	if MusicId == nil then
		return
	end
	wait( delay )
	ResumeSound({ Id = MusicId, Duration = duration or 0.2 })
end

function PauseAmbientMusic()
	PauseSound({ Id = AmbientMusicId, Duration = 0.2 })
	PauseSound({ Id = SecretMusicId, Duration = 0.2 })
end

function ResumeAmbientMusic()
	ResumeSound({ Id = AmbientMusicId, Duration = 0.2 })
	SetVolume({ Id = AmbientMusicId, Value = 1.0 })
	ResumeSound({ Id = SecretMusicId, Duration = 0.2 })
end

function SetMusicSection( section, musicId )
	if section == nil then
		return
	end
	if musicId == nil then
		musicId = MusicId
	end
	SetSoundCueValue({ Names = { "Section", }, Id = musicId, Value = section })
	if musicId == MusicId then
		MusicSection = section
		MusicSectionStartDepth = CurrentRun.RunDepthCache
	end
end

function SetAdvancedTooltipMixing( value )
	value = value or 0
	SetSoundCueValue({ Id = GetMixingId({}), Names = { "Wagon" }, Value = value })
end

function IsMusicPlaying()
	if MusicId ~= nil and MusicId > 0 then
		return true
	end
	return false
end

-- Music Marker logic
OnMusicMarker{ "Marker End",
	function( triggerArgs )
		local markerName = triggerArgs.name
		if markerName == "Marker End" then
			notifyExistingWaiters( "MusicTrackEnded" )
		end
	end
}

OnMusicMarker{ "Shout",
	function( triggerArgs )

		if not AllowShout then
			return
		end

		if MusicName ~= "/Music/MusicExploration4_MC" and MusicName ~= "/Music/MusicHadesReset_MC" then
			return
		end

		if CurrentRun.Hero.LastKillTime == nil or _worldTime > CurrentRun.Hero.LastKillTime + 20 then
			return
		end

		if IsEmpty( RequiredKillEnemies ) then
			return
		end

		PlaySound({ Name = "/SFX/Shout1" })
		AllowShout = false

	end
}

-- **AMBIENCE**
function StartRoomAmbience( currentRun, currentRoom )

	local newTrackName = nil
	if currentRoom.Encounter then
		newTrackName = currentRoom.Encounter.Ambience
	end

	newTrackName = newTrackName or currentRoom.Ambience

	if newTrackName == "None" then
		-- Silence requested
		StopSound({ Id = AmbienceId, Duration = 0.5 })
		AmbienceId = nil
		AmbienceName = nil
	elseif newTrackName ~= nil then
		-- Specific track requested
		if newTrackName ~= AmbienceName then
			StopSound({ Id = AmbienceId, Duration = 0.5 })
			AmbienceId = PlaySound({ Name = newTrackName, Duration = 0.5 })
			AmbienceName = newTrackName
		end
	else
		-- Nothing requested, use default biome track
		local ambienceTrackName = nil
		local biomeAmbienceTracks = AmbienceTracks[currentRoom.RoomSetName]
		if biomeAmbienceTracks ~= nil then
			local trackIndex = (GetCompletedRuns() % #biomeAmbienceTracks) + 1
			local trackData = biomeAmbienceTracks[trackIndex]
			if trackData.Name ~= nil and trackData.Name ~= AmbienceName then
				StopSound({ Id = AmbienceId, Duration = 0.5 })
				AmbienceId = PlaySound({ Name = trackData.Name, Duration = 0.5 })
				AmbienceName = trackData.Name
			end
			if trackData.ReverbValue ~= nil then
				SetAudioEffectState({ Name = "Reverb", Value = trackData.ReverbValue })
			end
		end
	end

	if currentRoom.ReverbValue ~= nil then
		SetAudioEffectState({ Name = "Reverb", Value = currentRoom.ReverbValue })
	end

end

function EndAmbience( duration )
	StopSound({ Id = AmbienceId, Duration = duration or 0.2 })
	AmbienceId = nil
	StopSound({ Id = AmbientMusicId, Duration = duration or 0.2 })
	AmbientMusicId = nil
	AmbientTrackName = nil
end

-- **VO**
-- Minos Voice Debug
OnKeyPressed{ "Alt V", Name = "ToggleVoice",
	function( triggerArgs )
		if CurrentRun.CurrentRoom.IntroVO ~= nil then
			PlayRemainingSpeech( CurrentRun.CurrentRoom.IntroVO )
		end
	end
}

function AudioInit()

	PlayedRandomLines = PlayedRandomLines or {}
	AllowShout = true
	BiomeMusicPlayCounts = BiomeMusicPlayCounts or {}

end

function PlayRandomEligibleVoiceLines( voiceLineSets )

	while not IsEmpty( voiceLineSets ) do
		local voiceLines = RemoveRandomValue( voiceLineSets )
		local playedSomething = PlayVoiceLines( voiceLines, true )
		if playedSomething then
			return
		end
	end

end

function PlayFirstEligibleVoiceLines( voiceLineSets )

	local highestIndex = GetHighestIndex( voiceLineSets )
	for index = 1, highestIndex do
		local voiceLines = voiceLineSets[index]
		if voiceLines ~= nil then
			local playedSomething = PlayVoiceLines( voiceLines, true )
			if playedSomething then
				return
			end
		end
	end

end

function PlayVoiceLines( voiceLines, neverQueue, source, args )
	if args ~= nil and args.Defer then
		for k, v in pairs(DeferredPlayVoiceLines) do
			if v[1] == voiceLines then
				--DebugPrint({ Text = "voice lines play request de-duped"})
				return
			end
		end
		table.insert( DeferredPlayVoiceLines, { voiceLines, neverQueue, source, args } )
		return
	end

	return PlayVoiceLinesReal( voiceLines, neverQueue, source, args )
end

function PlayVoiceLinesReal( voiceLines, neverQueue, source, args )

	if voiceLines == nil then
		return
	end

	args = args or {}

	source = GetLineSource( voiceLines, source, args )
	if source == nil then
		-- Never play a line if the source doesn't exist
		return
	end

	if not IsVoiceLineEligible( CurrentRun, voiceLines, nil, nil, source, args ) then
		-- First check requirements of the whole set
		if voiceLines.PlayedNothingFunctionName ~= nil then
			local playedNothingFunction = _G[voiceLines.PlayedNothingFunctionName]
			if playedNothingFunction ~= nil then
				playedNothingFunction( source, voiceLines.PlayedNothingFunctionArgs )
			end
		end
		return
	end

	if source.PlayingVoiceLines then
		if voiceLines.Queue == "Interrupt" then
			-- Play as normal
		else
			if neverQueue then
				--DebugPrint({ Text = "Skipped voiceLines on "..GetTableString( source.Name, source ) })
				return
			end
			if source.QueuedVoiceLines == nil then
				source.QueuedVoiceLines = {}
			end
			table.insert( source.QueuedVoiceLines, voiceLines )
			--DebugPrint({ Text = "Queued voiceLines on "..GetTableString( source.Name, source ) })
			return
		end
	end

	local playedSomething = false
	local parentLine = voiceLines

	source.PlayingVoiceLines = true
	if PlayVoiceLine( voiceLines, nil, nil, source, args ) then
		playedSomething = true
	else
		if voiceLines.PlayedNothingFunctionName ~= nil then
			local playedNothingFunction = _G[voiceLines.PlayedNothingFunctionName]
			if playedNothingFunction ~= nil then
				playedNothingFunction( source, voiceLines.PlayedNothingFunctionArgs )
			end
		end
	end
	source.PlayingVoiceLines = false

	if not IsEmpty( source.QueuedVoiceLines ) then
		local nextVoiceLines = RemoveFirstValue( source.QueuedVoiceLines )
		if PlayVoiceLines( nextVoiceLines, false, source, args ) then
			playedSomething = true
		end
	end

	return playedSomething

end

function GetLineSource( line, source, args )

	if line.ObjectType ~= nil then
		local typeIds = GetIdsByType({ Name = line.ObjectType })
		if IsEmpty( typeIds ) then
			return nil
		end
		local objectId = typeIds[1]
		source = ActiveEnemies[objectId]
		if source == nil then
			return nil
		else
			if line.RequiredSourceValue ~= nil and not source[line.RequiredSourceValue] then
				return nil
			end
			if line.RequiredSourceValueFalse ~= nil and source[line.RequiredSourceValueFalse] then
				return nil
			end
			return source
		end
	end

	if line.UsePlayerSource then
		return CurrentRun.Hero
	end

	if line.Source ~= nil then
		return line.Source
	end

	if source ~= nil then
		return source
	end

	return CurrentRun.Hero

end

function PlayVoiceLine( line, prevLine, parentLine, source, args )

	local playedSomething = false

	if parentLine == nil then
		parentLine = line
	end

	args = args or {}
	args.ThreadName = line.ThreadName or args.ThreadName
	args.Queue = line.Queue or args.Queue
	args.BreakIfPlayed = line.BreakIfPlayed or args.BreakIfPlayed
	args.PlayOnceContext = line.PlayOnceContext or args.PlayOnceContext
	args.SubtitleMinDistance = line.SubtitleMinDistance or args.SubtitleMinDistance
	args.Actor = line.Actor or args.Actor
	args.AllowTalkOverTextLines = line.AllowTalkOverTextLines or args.AllowTalkOverTextLines
	-- By default, the player object is the ListenerId, though could be something else
	args.ListenerId = line.ListenerId or args.ListenerId or CurrentRun.Hero.ObjectId

	source = GetLineSource( line, source, args )
	if source == nil then
		-- Never play a line if the source doesn't exist
		return
	end

	if line.SetFlagTrue ~= nil then
		GameState.Flags[line.SetFlagTrue] = true
	end
	if line.SetFlagFalse ~= nil then
		GameState.Flags[line.SetFlagFalse] = false
	end

	if line.TriggerCooldowns ~= nil then
		for k, cooldownName in pairs( line.TriggerCooldowns ) do
			TriggerCooldown( cooldownName )
		end
	end

	-- Play this line
	if line.Cue ~= nil then

		if args.OnPlayedSomethingFunctionName ~= nil and not args.PlayedSomething then
			local onPlayedSomethingFunction = _G[args.OnPlayedSomethingFunctionName]
			if onPlayedSomethingFunction ~= nil then
				thread( onPlayedSomethingFunction, source, args.OnPlayedSomethingFunctionArgs )
			end
		end

		if line.PreLineThreadedFunctionName ~= nil then
			local preLineThreadedFunction = _G[line.PreLineThreadedFunctionName]
			thread(preLineThreadedFunction, source, line.PreLineThreadedFunctionArgs )
		end
		wait( line.PreLineWait or parentLine.PreLineWait, args.ThreadName )
		local preLineAnim = line.PreLineAnim or parentLine.PreLineAnim
		if preLineAnim ~= nil then
			SetAnimation({ Name = preLineAnim, DestinationId = source.ObjectId })
		end

		local playedSpeechId = 0
		local useSubtitles = false
		if not source.Mute then
			if args.SubtitleMinDistance then
				local dist = GetDistance({ Id = args.ListenerId, DestinationId = source.ObjectId })
				if dist > args.SubtitleMinDistance then
					useSubtitles = false
				else
					useSubtitles = true
				end
			else
				useSubtitles = true
			end
			if line.NoTarget or parentLine.NoTarget then
				playedSpeechId = PlaySpeech({ Name = line.Cue, Queue = args.Queue, SubtitleColor = source.SubtitleColor, UseSubtitles = useSubtitles, Actor = args.Actor })
			elseif line.SkipAnim or parentLine.SkipAnim then
				playedSpeechId = PlaySpeechCueFromSource( line.Cue, source, false, args.Queue, useSubtitles, source.SubtitleColor, args )
			else
				playedSpeechId = PlaySpeechCueFromSource( line.Cue, source, true, args.Queue, useSubtitles, source.SubtitleColor, args )
			end
		end
		if line.UseOcclusion then
			SetSoundCueValue({ Id = playedSpeechId, Names = { "VoiceOcclusion" }, Value = 1.0, Duration = 0.01 })
		end
		if playedSpeechId > 0 then
			prevLine = line
			LastLinePlayed = line.Cue
			table.insert( CurrentRun.CurrentRoom.VoiceLinesPlayed, line.Cue )
			playedSomething = true
			args.PlayedSomething = true
			-- @refactor The SpeechRecord recording is pretty scattered / redundant
			SpeechRecord[line.Cue] = true
			CurrentRun.SpeechRecord[line.Cue] = true
			if args.PlayOnceContext ~= nil then
				GameState.SpeechRecordContexts[args.PlayOnceContext] = GameState.SpeechRecordContexts[args.PlayOnceContext] or {}
				GameState.SpeechRecordContexts[args.PlayOnceContext][line.Cue] = true
			end
			-- Intentionally leaving this on raw data for now to be wiped out on load
			line.LastPlayTime = _worldTime
			parentLine.LastPlayTime = _worldTime
			waitUntil( line.Cue )
			wait( line.PostLineWait or parentLine.PostLineWait, args.ThreadName )
			if line.PostLineFunctionName ~= nil then
				local postLineFunction = _G[line.PostLineFunctionName]
				postLineFunction( source, line.PostLineFunctionArgs )
			end
			if args.BreakIfPlayed then
				return playedSomething
			end
		else
			--DebugAssert({ Condition = playedSpeechId > 0, Text = "Speech failed to play: "..line.Cue })
		end
	end

	-- Play sublines
	if line.RandomRemaining then
		local eligibleUnplayedLines = {}
		local allEligibleLines = {}
		for k, subLine in ipairs( line ) do
			if IsVoiceLineEligible( CurrentRun, subLine, prevLine, line, source, args ) then
				table.insert( allEligibleLines, subLine )
				if not PlayedRandomLines[subLine.Cue] then
					table.insert( eligibleUnplayedLines, subLine )
				end
			end
		end
		if not IsEmpty( allEligibleLines ) then
			local randomLine = nil
			if IsEmpty( eligibleUnplayedLines ) then
				-- All lines played, start the record over
				for k, subLine in ipairs( line ) do
					PlayedRandomLines[subLine.Cue] = nil
				end
				randomLine = GetRandomValue( allEligibleLines )
			else
				randomLine = GetRandomValue( eligibleUnplayedLines )
			end
			PlayedRandomLines[randomLine.Cue] = true
			-- Effectively pass down by value rather than reference
			local subLineArgs = ShallowCopyTable( args )
			if PlayVoiceLine( randomLine, prevLine, line, source, subLineArgs ) then
				prevLine = randomLine
				playedSomething = true
				args.PlayedSomething = true
				if args.BreakIfPlayed or randomLine.BreakIfPlayed or subLineArgs.BreakIfPlayed then
					return playedSomething
				end
			end
		end
	else
		for k, subLine in ipairs( line ) do
			if IsVoiceLineEligible( CurrentRun, subLine, prevLine, line, source, args ) then
				-- Effectively pass down by value rather than reference
				local subLineArgs = ShallowCopyTable( args )
				if PlayVoiceLine( subLine, prevLine, line, source, subLineArgs ) then
					prevLine = subLine
					playedSomething = true
					args.PlayedSomething = true
					if args.BreakIfPlayed or subLine.BreakIfPlayed or subLineArgs.BreakIfPlayed then
						return playedSomething
					end
				end
			end
		end
	end

	return playedSomething

end

function CleanUpCurrentSpeechId( cue, speechId, source, animation )
	if speechId == nil then
		return
	end
	waitUntil( cue )
	if animation ~= nil then
		if StopStatusAnimation( source, animation ) and not source.BlockStatusAnimations and ConfigOptionCache.ShowUIAnimations and ConfigOptionCache.ShowSpeechBubble then
			local endAnimation = animation.."_End"
			CreateAnimation({ Name = endAnimation, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ })
		end
	end
	if CurrentSpeechId == speechId then
		CurrentSpeechId = nil
	end
end

function PlaySpeechCue( cue, source, animation, queue, useSubtitles, subtitleColor, args )

	if cue == nil or cue == "" then
		return 0
	end

	args = args or {}

	local sourceId = nil
	if source ~= nil then
		sourceId = source.ObjectId
	end

	local speechId = PlaySpeech({ Name = cue, Id = sourceId, Queue = queue, UseSubtitles = useSubtitles, SubtitleColor = subtitleColor, Actor = args.Actor })
	if speechId > 0 then
		if source ~= nil and animation ~= nil and ConfigOptionCache.ShowUIAnimations and ConfigOptionCache.ShowSpeechBubble then
			PlayStatusAnimation( source, { Animation = animation } )
		end
		CurrentSpeechId = speechId
		-- @refactor The SpeechRecord recording is pretty scattered / redundant
		SpeechRecord[cue] = true
		CurrentRun.SpeechRecord[cue] = true
		thread( CleanUpCurrentSpeechId, cue, speechId, source, animation )
	end
	return speechId

end

function PlaySpeechCueFromSource( cue, source, useDefaultAnim, queue, useSubtitles, subtitleColor, args )
	if PlayingTextLines and not args.AllowTalkOverTextLines then
		return 0
	end
	if source == nil then
		source = CurrentRun.Hero
	end
	if useDefaultAnim == nil then
        useDefaultAnim = true
    end
	local anim = nil
    if useDefaultAnim then
        anim = StatusAnimations.Speaking
    end
    return PlaySpeechCue( cue, source, anim, queue, useSubtitles, subtitleColor, args )
end

function IsVoiceLineEligible( currentRun, line, prevLine, parentLine, source, args )

	if line == nil then
		return false
	end

	args = args or {}

	if source ~= nil then
		if line.RequiresFalseCharmed ~= nil and source.Charmed then
			return false
		end
		if line.RequiresCharmed ~= nil and not source.Charmed then
			return false
		end
		if line.RequiredSourceValue ~= nil and not source[line.RequiredSourceValue] then
			return false
		end
		if line.RequiredSourceValueFalse ~= nil and source[line.RequiredSourceValueFalse] then
			return false
		end
	end

	if args ~= nil and args.ElapsedTime ~= nil then
		if line.RequiredMinElapsedTime ~= nil and args.ElapsedTime < line.RequiredMinElapsedTime then
			return false
		end
		if line.RequiredMaxElapsedTime ~= nil and args.ElapsedTime > line.RequiredMaxElapsedTime then
			return false
		end
	end

	if line.ExplicitRequirements or ( parentLine ~= nil and parentLine.ExplicitRequirements ) then
		if line.GameStateRequirements ~= nil and not IsGameStateEligible( currentRun, line, line.GameStateRequirements ) then
			return false
		end
	else
		if not IsGameStateEligible( currentRun, line, line.GameStateRequirements ) then
			return false
		end
	end

	if line.PlayOnceFromTableThisRun then
		for k, subLine in ipairs( line ) do
			if subLine.Cue ~= nil and currentRun.SpeechRecord[subLine.Cue] then
				return false
			end
		end
	end

	if line.SuccessiveChanceToPlay ~= nil then
		local anyLinePlayed = false
		for k, subLine in ipairs( line ) do
			if subLine.Cue ~= nil and SpeechRecord[subLine.Cue] then
				anyLinePlayed = true
				break
			end
		end
		if anyLinePlayed and not RandomChance( line.SuccessiveChanceToPlay ) then
			return false
		end
	end

	if line.SuccessiveChanceToPlayAll ~= nil then
		local allLinesPlayed = true
		for k, subLine in ipairs( line ) do
			if subLine.Cue ~= nil and not SpeechRecord[subLine.Cue] then
				allLinesPlayed = false
				break
			end
		end
		if allLinesPlayed and not RandomChance( line.SuccessiveChanceToPlayAll ) then
			return false
		end
	end

	if line.Cue ~= nil then

		if line.PlayOnce or ( parentLine ~= nil and parentLine.PlayOnce ) then
			if args.PlayOnceContext ~= nil then
				DebugPrint({ Text = "checking context = "..tostring(args.PlayOnceContext) })
				GameState.SpeechRecordContexts[args.PlayOnceContext] = GameState.SpeechRecordContexts[args.PlayOnceContext] or {}
				if GameState.SpeechRecordContexts[args.PlayOnceContext][line.Cue] then
					return false
				end
			elseif SpeechRecord[line.Cue] then
				return false
			end
		end

		if line.PlayOnceThisRun or ( parentLine ~= nil and parentLine.PlayOnceThisRun ) then
			if currentRun.SpeechRecord[line.Cue] then
				return false
			end
		end

		local chanceToPlayAgain = line.ChanceToPlayAgain or ( parentLine ~= nil and parentLine.ChanceToPlayAgain )
		if chanceToPlayAgain and SpeechRecord[line.Cue] and not RandomChance( chanceToPlayAgain ) then
			return false
		end

		if line.CooldownTime ~= nil then
			if not CheckCooldown( line.CooldownName or line.Cue, line.CooldownTime ) then
				--DebugPrint({ Text = "VO blocked from cooldown: "..tostring(line.CooldownName or line.Cue) })
				return false
			end
		end
		if line.Cooldowns ~= nil then
			for k, cooldown in pairs( line.Cooldowns ) do
				local cooldownTime = cooldown.Time or line.CooldownTime
				if cooldownTime == nil and source ~= nil then
					cooldownTime = source.SpeechCooldownTime
				end
				if not CheckCooldown( cooldown.Name, cooldownTime ) then
					--DebugPrint({ Text = "VO blocked from cooldown: "..tostring(cooldown.Name) })
					return false
				end
			end
		end

	else

		if line.CooldownTime ~= nil then
			local cooldownName = line.CooldownName
			if cooldownName == nil and line[1] ~= nil then
				cooldownName = line[1].CooldownName or line[1].Cue
			end
			if cooldownName ~= nil and not CheckCooldown( cooldownName, line.CooldownTime ) then
				--DebugPrint({ Text = "VO blocked from cooldown: "..tostring(cooldownName) })
				return false
			end
		end
		if line.Cooldowns ~= nil then
			for k, cooldown in pairs( line.Cooldowns ) do
				local cooldownTime = cooldown.Time or line.CooldownTime
				if cooldownTime == nil and source ~= nil then
					cooldownTime = source.SpeechCooldownTime
				end
				if not CheckCooldown( cooldown.Name, cooldownTime ) then
					--DebugPrint({ Text = "VO blocked from cooldown: "..tostring(cooldown.Name) })
					return false
				end
			end
		end

	end

	if line.RequiresSourceAlive then
		if line.ObjectType ~= nil then
			local typeIds = GetIdsByType({ Name = line.ObjectType })
			local objectId = typeIds[1]
			source = ActiveEnemies[objectId]
		end
		if source == nil or source.IsDead then
			return false
		end
	end

	return true

end

function SometimesPlayCombatResolvedVoiceLines()
	if not RandomChance( 0.25 ) then
		return
	end
	local currentHealthFraction = CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth
	if currentHealthFraction >= 0.95 then
		thread( PlayVoiceLines, GlobalVoiceLines.CombatResolvedHighHealthLines, true )
	elseif currentHealthFraction >= 0.3 and currentHealthFraction < 0.95 then
		thread( PlayVoiceLines, GlobalVoiceLines.CombatResolvedMediumHealthLines, true )
	elseif currentHealthFraction < 0.3 then
		thread( PlayVoiceLines, GlobalVoiceLines.CombatResolvedLowHealthLines, true )
	end
end

function AmbientChatting( source, args )

	-- play a random line from ChattingRepeatable or similar table, from the character source position, with speech bubble; when player gets sufficiently close, play an 'interrupt' line, interrupting the ambient line if it's still playing

	if args.StartDistance ~= nil then
		local notifyName = "StartDistance"..source.Name
		NotifyWithinDistanceAny({ Ids = { CurrentRun.Hero.ObjectId }, DestinationIds = { source.ObjectId }, Distance = args.StartDistance, Notify = notifyName })
		waitUntil( notifyName )
	end

	thread( CheckDistanceTrigger, args.DistanceTrigger, source )
	PlayVoiceLines( args.VoiceLines, nil, source )
	-- source.BlockStatusAnimations = true
	wait( 1.5 )
	-- source.BlockStatusAnimations = false

end
