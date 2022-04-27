function NarrativeInit()

	PlayingTextLines = false
	TextLinesRecord = TextLinesRecord or {} -- Sets of lines
	QueuedTextLines = QueuedTextLines or {}
	PlayedRandomTextLines = PlayedRandomTextLines or {}

end

function PlayTextLines( source, textLines )

	if textLines == nil then
		return
	end

	if not IsTextLineEligible( CurrentRun, textLines ) then
		-- First check requirements of the whole set
		return
	end

	if PlayingTextLines then
		table.insert( QueuedTextLines, textLines )
		return
	end

	if GetConfigOptionValue({ Name = "EditingMode" }) then
		waitUntil( "EditingModeOff" )
	end

	local playedSomething = false
	local parentLine = textLines

	UnblockCombatUI("Speech")
	CombatUI.HiddenBySpeechPanel = false
	AddInputBlock({ Name = "PlayTextLines" })
	FreezePlayerUnit( "PlayTextLines", { DisableTray = false, StopRotation = false } )
	SetPlayerInvulnerable( "PlayTextLines" )
	local startTime = _worldTime

	wait( textLines.PreEventWait )
	if textLines.PreEventFunctionName ~= nil then
		local preEventFunction = _G[textLines.PreEventFunctionName]
		preEventFunction( source, textLines.PreEventFunctionArgs, textLines )
	end
	StartedTextLinesPresentation( source, textLines )

	PlayingTextLines = true
	OnScreenOpened({Flag = "Dialog"})
	local screen = {}
	if PlayTextLine( screen, textLines, nil, nil, source ) then
		playedSomething = true
	end
	if screen.CurrentPortrait ~= nil then
		SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait.."_Exit" })
		wait(0.3)
		Destroy({ Id = screen.PortraitId })
	end
	if parentLine.AttachedDim and _G["Dim"..parentLine.AttachedDim] then
		_G["Dim"..parentLine.AttachedDim]()
	end
	OnScreenClosed({Flag = "Dialog"})
	FinishedTextLinesPresentation( source, textLines )
	if not source.TextLinesIgnoreQuests then
		thread( CheckQuestStatus )
	end
	RemoveInputBlock({ Name = "PlayTextLines" })
	UnfreezePlayerUnit( "PlayTextLines" )
	SetPlayerVulnerable( "PlayTextLines" )
	PlayingTextLines = false

	if textLines.UseableOffSource then
		source.NextInteractLines = nil
		UseableOff({ Id = source.ObjectId })
		StopStatusAnimation( source, StatusAnimations.WantsToTalk )
	end

	if CombatUI.HiddenBySpeechPanel then
		ShowCombatUI("Speech")
	end
	if CombatUI.ShowUIForDecision then
		CombatUI.ShowUIForDecision = nil
	end

	wait( textLines.EndWait )

	local args = {}
	args.ElapsedTime = _worldTime - startTime
	DebugPrint({ Text = "args.ElapsedTime = "..args.ElapsedTime })

	if textLines.EndCue ~= nil and (textLines.EndCueCooldownName == nil or CheckCooldown( textLines.EndCueCooldownName, textLines.EndCueCooldownTime ) ) then
		-- These EndCue lines should not repeat per run
		if not CurrentRun.SpeechRecord[textLines.EndCue] then
			-- EndCue always plays from the player
			local source = CurrentRun.Hero
			if textLines.EndCueSourceName ~= nil then
				local typeIds = GetIdsByType({ Name = textLines.EndCueSourceName })
				local objectId = typeIds[1]
				source = ActiveEnemies[objectId]
				if source == nil then
					source = {}
					source.ObjectId = objectId
				end
			end
			thread( PlayVoiceLines, { Cue = textLines.EndCue }, nil, source, args )
		end
	end
	if textLines.EndVoiceLines ~= nil then
		thread( PlayVoiceLines, textLines.EndVoiceLines, nil, source, args )
	end
	if textLines.EndGlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[textLines.EndGlobalVoiceLines], nil, source, args )
	end

	if not IsEmpty( QueuedTextLines ) then
		local nextTextLines = RemoveFirstValue( QueuedTextLines )
		if PlayTextLines( source, nextTextLines ) then
			playedSomething = true
		end
	end

	return playedSomething
end

function PlayTextLine( screen, textLines, prevLine, parentLine, source )

	DebugAssert({ Condition = textLines.Name ~= nil, Text = "TextLines being played without a name!" })
	if textLines.Name ~= nil then
		TextLinesRecord[textLines.Name] = true
		CurrentRun.TextLinesRecord[textLines.Name] = true
		if CurrentRun.CurrentRoom ~= nil then
			CurrentRun.CurrentRoom.TextLinesRecord[textLines.Name] = true
		end
	end

	local playedSomething = false

	--[[
	HotLoadInfo.CurrentTextLines = textLines
	local lineIndex = 0
	while HotLoadInfo ~= nil and HotLoadInfo.CurrentTextLines ~= nil do
	]]
	for lineIndex, line in ipairs( textLines ) do

		--[[
		lineIndex = lineIndex + 1
		local line = HotLoadInfo.CurrentTextLines[lineIndex]
		if line == nil then
			break
		end
		--]]

		local prevLine = nil
		if lineIndex >= 2 then
			prevLine = textLines[lineIndex - 1]
		end
		if IsTextLineEligible( CurrentRun, line, prevLine, parentLine ) then
			local playLine = line
			if line.SetFlagTrue ~= nil then
				GameState.Flags[line.SetFlagTrue] = true
			end
			if line.SetFlagFalse ~= nil then
				GameState.Flags[line.SetFlagFalse] = false
			end
			if line.PauseMusic ~= nil then
				PauseAmbientMusic()
			end
			if line.PauseAmbientMusicVocals ~= nil then
				SetSoundCueValue({ Names = { "Vocals", }, Id = AmbientMusicId, Value = 0 })
			end
			if line.ResumeMusic ~= nil then
				ResumeAmbientMusic()
			end
			if line.ResumeAmbientMusicVocals ~= nil then
				SetSoundCueValue({ Names = { "Vocals", }, Id = AmbientMusicId, Value = 1, Duration = 0.25 })
			end
			if line.EndSecretMusic ~= nil and SecretMusicId ~= nil then
				StopSound({ Id = SecretMusicId, Duration = 0.25 })
				SecretMusicId = nil
				SecretMusicName = nil
			end
			if line.SecretMusic ~= nil then
				SecretMusicPlayer( line.SecretMusic )
			end
			if line.SecretMusicSection ~= nil then
				SetSoundCueValue({ Names = { "Section", }, Id = SecretMusicId, Value = line.SecretMusicSection })
			end
			if line.SecretMusicActiveStems ~= nil then
				SetSoundCueValue({ Names = line.SecretMusicActiveStems, Id = SecretMusicId, Value = 1, Duration = line.SecretMusicActiveStemsDuration or 1 })
			end
			if line.SecretMusicMutedStems ~= nil then
				SetSoundCueValue({ Names = line.SecretMusicMutedStems, Id = SecretMusicId, Value = 0, Duration = line.SecretMusicMutedStemsDuration or 1 })
			end
			if line.MusicSection ~= nil then
				SetSoundCueValue({ Names = { "Section", }, Id = MusicId, Value = line.MusicSection })
			end
			if line.MusicActiveStems ~= nil then
				SetSoundCueValue({ Names = line.MusicActiveStems, Id = MusicId, Value = 1, Duration = line.MusicActiveStemsDuration or 1 })
			end
			if line.MusicMutedStems ~= nil then
				SetSoundCueValue({ Names = line.MusicMutedStems, Id = MusicId, Value = 0, Duration = line.MusicMutedStemsDuration or 1 })
			end
			if line.StartSound ~= nil then
				PlaySound({ Name = line.StartSound })
			end
			if line.FadeOutSound ~= nil then
				PlaySound({ Name = line.FadeOutSound or "/Leftovers/World Sounds/MapZoomInShortHigh" })
			end
			if line.FadeOutTime ~= nil then
				FadeOut({ Color = Color.Black, Duration = line.FadeOutTime })
				wait( line.FadeOutTime )
			end
			if line.FadeOutEndSound ~= nil then
				PlaySound({ Name = line.FadeOutEndSound })
			end
			if line.LoadMap ~= nil then
				CurrentRun.BlockDeathAreaTransitions = true -- @refactor
				screen.PortraitId = nil
				killTaggedThreads( RoomThreadName )
				LoadMap({ Name = line.LoadMap })
				wait(0.1)
			end
			if line.ActivateIds ~= nil then
				Activate({ Ids = line.ActivateIds })
			end
			if line.UseableOffIds ~= nil then
				UseableOff({ Ids = line.UseableOffIds })
				if line.BlockUseableToggle then
					for k, id in pairs( line.UseableOffIds ) do
						if MapState.ActiveObstacles[id] ~= nil then
							MapState.ActiveObstacles[id].UseableToggleBlocked = true
						end
					end
				end
			end
			if line.CollisionOffIds ~= nil then
				SetThingProperty({ Property = "StopsUnits", Value = false, DestinationIds = line.CollisionOffIds })
				SetThingProperty({ Property = "StopsLight", Value = false, DestinationIds = line.CollisionOffIds })
			end
			if line.FadeOutIds ~= nil then
				SetAlpha({ Ids = line.FadeOutIds, Fraction = 0.0, Duration = 0.3, })
			end
			if line.UseableOnIds ~= nil then
				UseableOn({ Ids = line.UseableOnIds })
			end
			if line.FadeInIds ~= nil then
				SetAlpha({ Ids = line.FadeInIds, Fraction = 1.0, Duration = 0.3, })
			end
			if line.AttachedDim and _G["Dim"..line.AttachedDim] then
				_G["UnDim"..line.AttachedDim]()
			end
			if CurrentRun.Hero ~= nil then
				if line.TeleportHeroToId ~= nil then
					Teleport({ Id = CurrentRun.Hero.ObjectId, DestinationId = line.TeleportHeroToId, OffsetX = line.TeleportHeroOffsetX, OffsetY = line.TeleportHeroOffsetY, })
				end
				if line.AngleHeroTowardTargetId ~= nil then
					AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = line.AngleHeroTowardTargetId })
				end
				if line.AngleHeroTowardSource ~= nil and source ~= nil then
					AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId })
				end
			end
			if source ~= nil then
				if line.TeleportToId ~= nil then
					Teleport({ Id = line.TeleportId or source.ObjectId, DestinationId = line.TeleportToId, OffsetX = line.TeleportOffsetX, OffsetY = line.TeleportOffsetY, })
				end
				if line.TeleportWithId ~= nil then
					Teleport({ Id = line.TeleportWithId, DestinationId = line.TeleportToId })
					Teleport({ Id = source.ObjectId, DestinationId = line.TeleportToId, OffsetX = line.TeleportOffsetX, OffsetY = line.TeleportOffsetY, })
				end
				if line.SpawnOnId ~= nil then
					source.ObjectId = SpawnUnit({ Name = source.Name, Group = "Standing", DestinationId = line.SpawnOnId })
					SetupEnemyObject( source, CurrentRun )
				end
				if line.AngleTowardTargetId ~= nil then
					AngleTowardTarget({ Id = line.AngleId or source.ObjectId, DestinationId = line.AngleTowardTargetId })
				end
				if line.AngleTowardHero ~= nil then
					AngleTowardTarget({ Id = line.AngleId or source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
				end
			end
			wait( line.FullFadeTime )
			if line.FadeInSound ~= nil then
				PlaySound({ Name = line.FadeInSound or "/Leftovers/World Sounds/MapZoomInShortHigh" })
			end
			if line.FadeInTime ~= nil then
				FadeIn({ Duration = line.FadeInTime })
				wait( line.FadeInTime )
			end
			if line.RandomRemaining then
				parentLine = line
				local eligibleUnplayedLines = {}
				local allEligibleLines = {}
				for k, subLine in ipairs( line ) do
					if IsTextLineEligible( CurrentRun, subLine, prevLine, line ) then
						table.insert( allEligibleLines, subLine )
						if not PlayedRandomTextLines[subLine.Text] then
							table.insert( eligibleUnplayedLines, subLine )
						end
					end
				end
				if not IsEmpty( allEligibleLines ) then
					if IsEmpty( eligibleUnplayedLines ) then
						-- All lines played, start the record over
						for k, subLine in ipairs( line ) do
							PlayedRandomTextLines[subLine.Text] = nil
						end
						playLine = GetRandomValue( allEligibleLines )
					else
						playLine = GetRandomValue( eligibleUnplayedLines )
					end
					PlayedRandomTextLines[playLine.Text] = true
				end
			end

			wait( line.InterSceneWaitTime or 0 )

			if playLine.Text ~= nil then

				wait( 0.1 )
				StopStatusAnimation( source, source.StatusAnimation or textLines.StatusAnimation or StatusAnimations.WantsToTalk )

				if playLine.PreLineThreadedFunctionName ~= nil then
					local preLineThreadedFunction = _G[playLine.PreLineThreadedFunctionName]
					thread( preLineThreadedFunction, source, playLine.PreLineThreadedFunctionArgs, screen, line )
				end
				if playLine.PreLineFunctionName ~= nil then
					local preLineFunction = _G[playLine.PreLineFunctionName]
					preLineFunction( source, playLine.PreLineFunctionArgs )
				end
				if playLine.PreLineFunction ~= nil then
					playLine.PreLineFunction( source, playLine.PreLineFunctionArgs )
				end
				if playLine.PreLineAnim ~= nil then
					local targetId = playLine.PreLineAnimTarget or source.ObjectId
					if playLine.PreLineAnimTarget == "Hero" then
						targetId = CurrentRun.Hero.ObjectId
					end
					SetAnimation({ Name = playLine.PreLineAnim, DestinationId = targetId })
				end

				wait( playLine.PreLineWait )
				if ShowingCombatUI and not CombatUI.ShowUIForDecision then
					HideCombatUI("Speech")
					CombatUI.HiddenBySpeechPanel = true
				end

				local played = DisplayTextLine( screen, source, playLine, textLines )
				if played then
					playedSomething = true
					-- Intentionally leaving this on raw data for now to be wiped out on load
					playLine.LastPlayTime = _worldTime

					wait( playLine.PostLineWait or 0.1 )

					if playLine.BreakIfPlayed or (parentLine ~= nil and parentLine.BreakIfPlayed) then
						break
					end
					if playLine.PostLineAnim ~= nil then
						local targetId = playLine.PostLineAnimTarget or source.ObjectId
						if playLine.PostLineAnimTarget == "Hero" then
							targetId = CurrentRun.Hero.ObjectId
						end
						SetAnimation({ Name = playLine.PostLineAnim, DestinationId = targetId })
					end
				end
				if playLine.TriggerCooldowns ~= nil then
					for k, cooldownName in pairs( playLine.TriggerCooldowns ) do
						TriggerCooldown( cooldownName )
					end
				end
				if playLine.EndSound ~= nil then
					PlaySound({ Name = playLine.EndSound })
				end
				if playLine.UseEventEndSound ~= nil and source.EventEndSound ~= nil then
					PlaySound({ Name = source.EventEndSound })
				end
				if playLine.PauseMusic ~= nil then
					ResumeAmbientMusic()
				end
				if line.PauseAmbientMusicVocals ~= nil then
					SetSoundCueValue({ Names = { "Vocals", }, Id = AmbientMusicId, Value = 1, Duration = 0.25 })
				end
				if line.PostLineSecretMusic ~= nil then
					SecretMusicPlayer( line.PostLineSecretMusic )
				end
			end

			if playLine.ClearPortraitId then
				screen.PortraitId = nil
			end

			if playLine.PostLineFunctionName ~= nil then
				local postLineFunction = _G[playLine.PostLineFunctionName]
				postLineFunction( source, playLine.PostLineFunctionArgs, textLines )
			end
			if playLine.PostLineThreadedFunctionName ~= nil then
				local postLineFunction = _G[playLine.PostLineThreadedFunctionName]
				thread( postLineFunction, source, playLine.PostLineFunctionArgs, textLines )
			end
			if playLine.PostLineGlobalVoiceLines ~= nil then
				thread( PlayVoiceLines, GlobalVoiceLines[playLine.PostLineGlobalVoiceLines], nil, source, args )
			end

		end
	end

	return playedSomething

end

function IsTextLineEligible( currentRun, line, prevLine, parentLine, args )

	if line == nil then
		return false
	end

	if args ~= nil then
		if args.RequirePartner and line.Partner == nil then
			return false
		end
		if args.RequireNoPartner and line.Partner ~= nil then
			return false
		end
	end

	if line.Partner ~= nil then
		local typeIds = GetIdsByType({ Name = line.Partner })
		if IsEmpty( typeIds ) then
			return false
		end
	end

	if line.Name ~= nil then
		if line.PlayOnce or ( parentLine ~= nil and parentLine.PlayOnce ) then
			if TextLinesRecord[line.Name] then
				return false
			end
		end
		if line.PlayOnceThisRun or ( parentLine ~= nil and parentLine.PlayOnceThisRun ) then
			if currentRun.TextLinesRecord[line.Name] then
				return false
			end
		end
	end

	if not IsGameStateEligible( currentRun, line ) then
		return false
	end

	return true

end

function DisplayTextLine( screen, source, line, parentLine )

	local text = line.Text
	if GetLanguage({}) ~= "en" then
		-- If the cue is defined, look up the translation without the '/VO/' prefix
		if line.Cue then
			local helpTextId = string.sub( line.Cue, 5 )
			text = helpTextId
			if not HasDisplayName({ Text = helpTextId }) then
				text = line.Text
			end
		end
	end

	local cue = line.Cue
	local portrait = line.Portrait
	local speakerName = line.Speaker or source.Speaker or source.Name
	local speakerLabelOffsetY = line.SpeakerLabelOffsetY or 5

	-- @hack
	if (source == CurrentRun.Hero or speakerName == "CharProtag") and IsEmpty( GameState.RunHistory ) and not CurrentRun.Hero.IsDead then
		speakerName = "PlayerUnit_Intro"
		speakerLabelOffsetY = 18
	end

	if CurrentSpeechId then
		StopSound({ Id = CurrentSpeechId, Duration = 0.15 })
	end

	StopStatusAnimation( source, StatusAnimations.WantsToTalk )

	local anchorId = nil
	local textColor = nil
	local narrationTextOffsetX = 0
	local narrationTextOffsetY = 0
	local narrationBoxOffsetX = 0
	local exitAnimation = nil
	local textShadowColor = {0.890, 0.871, 0.851, 1.0}

	local speechSource = source

	if portrait ~= nil or source.Portrait ~= nil then
		-- Dialogue with portrait
		if screen.PortraitId == nil then
			screen.PortraitId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX - 490, Y = ScreenCenterY + 105, Group = "Combat_Menu" })
		end
		local newPortrait = portrait or source.Portrait
		if screen.CurrentPortrait ~= nil and screen.CurrentPortrait ~= newPortrait then
			SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait.."_Exit" })
			wait( line.PortraitExitWait or 0.3 )
		end
		screen.CurrentPortrait = newPortrait
		SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait })
		speechSource = { Name = source.Name, ObjectId = screen.PortraitId }
		narrationBoxOffsetX = 198
	end

	if line.PreContentSound ~= nil then
		PlaySound({ Name = line.PreContentSound })
	end
	if line.Emote ~= nil and screen.PortraitId ~= nil then
		CreateAnimation({ Name = line.Emote, DestinationId = screen.PortraitId, OffsetX = source.EmoteOffsetX, OffsetY = source.EmoteOffsetY })
	end

	local speakerNameId = nil
	local promptOffsetY = 400

	if (portrait ~= nil or source.Portrait ~= nil) and not (line.IsNarration or parentLine.IsNarration) then
		-- Speech bubble
		anchorId = CreateScreenObstacle({ Name = line.BoxAnimation or "DialogueSpeechBubble", X = ScreenCenterX + (line.BoxOffsetX or narrationBoxOffsetX), Y = ScreenCenterY + (line.BoxOffsetY or 264), Group = "Combat_Menu" })
		exitAnimation = line.BoxExitAnimation or "DialogueSpeechBubbleOut"
		textColor = Color.DialogueText

		speakerNameId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX - 46, Y = ScreenCenterY + 123, Group = "Combat_Menu" })

		CreateTextBox(MergeTables({
			Id = speakerNameId,
			Text = speakerName,
			FontSize = 34,
			OffsetY = speakerLabelOffsetY + GetLocalizedValue( 0, LocalizationData.Narrative.SpeakerDisplayName.LangOffsetY ),
			Font = "CaesarDressing",
			Color = Color.DialogueSpeakerName,
			Justification = "CENTER",
		}, LocalizationData.Narrative.SpeakerDisplayName ))

		CreateTextBox(MergeTables({
			Id = speakerNameId,
			Text = speakerName,
			FontSize = 18,
			OffsetY = 38 + GetLocalizedValue( 0, LocalizationData.Narrative.SpeakerDescription.LangOffsetY ),
			Font = "AlegreyaSansSCMedium",
			Color = Color.Crimson,
			UseDescription = true,
		}, LocalizationData.Narrative.SpeakerDescription ))

	else
		-- Narration
		anchorId = CreateScreenObstacle({ Name = "NarrationBubble", X = ScreenCenterX + (line.BoxOffsetX or narrationBoxOffsetX), Y = ScreenCenterY + (line.BoxOffsetY or 304), Group = "Combat_Menu" })
		if line.BoxAnimation ~= nil then
			SetAnimation({ Name = line.BoxAnimation, DestinationId = anchorId })
		end
		exitAnimation = line.BoxExitAnimation or "NarrationBubbleOut"
		textColor = Color.NarrationText
		textShadowColor = {0,0,0, 1.0}
		narrationTextOffsetX = 0
		narrationTextOffsetY = -20
		promptOffsetY = 440
	end

	CreateTextBox(MergeTables({
		Id = anchorId,
		Text = text,
		Width = line.TextWidth or 833,
		OffsetX = line.TextOffsetX or (-395 + narrationTextOffsetX),
		OffsetY = line.TextOffsetY or (50 + narrationTextOffsetY),
		Font = "AlegreyaSansExtraBold",
		FontSize = line.FontSize or 27,
		Justification = "LEFT",
		VerticalJustification = "CENTER",
		Color = line.TextColor or textColor,
		LineSpacingBottom = 4,
		ShadowColor = textShadowColor,
		ShadowBlur = 0,
		ShadowOffsetX = 0,
		ShadowOffsetY = 4,
		--[[
		DataProperties =
		{
			CharacterFadeTime = 0.0025,
			CharacterFadeInterval = 0.0025,
			CommaFadeInterval = 0.0025,
			PeriodFadeInterval = 0.0025,
			RepeatPeriodFadeInterval = 0.0025,
			QuestionFadeInterval = 0.0025,
			ExclamationFadeInterval = 0.0025,
		},
		]]--
	}, LocalizationData.Narrative.DialogueText ))

	local anchorIds = { anchorId, speakerNameId }
	screen.PromptId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX + 390 + narrationBoxOffsetX, Y = ScreenCenterY + promptOffsetY, Group = "Combat_Menu" })
	table.insert( anchorIds, screen.PromptId )

	ModifySubtitles({ SuppressLyrics = true })

	local speechId = PlaySpeechCue( cue, nil, nil, "Interrupt", false )
	if source.SpeakingAnimation ~= nil and line.Portrait == nil and speechId ~= nil and speechId > 0 then
		SetAnimation({ DestinationId = screen.PortraitId, Name = source.SpeakingAnimation, SoundId = speechId })
		thread( CancelSpeakingAnimation, screen, source, cue )
	end
	thread( ShowContinueArrow, screen, source, cue )

	wait(0.01)

	local selectedChoice = nil
	local choiceMap = {}
	local choiceBackground = nil

	if line.Choices ~= nil then

		DestroyTextBox({ Ids = { anchorId, speakerNameId } })

		choiceBackground = CreateScreenObstacle({ Name = "DialogueChoiceBubble", X = ScreenCenterX + narrationBoxOffsetX + 8, Y = ScreenCenterY + 280, Group = "Combat_Menu" })

		local localizedTextOffsetY = 0.0
		local localizedWidthOverride = 755
		local localizedTextOffsetX = 0

		local lang = GetLanguage({})
		if lang == "zh-CN" then
			localizedTextOffsetY = -15
		elseif lang == "ko" then
			localizedTextOffsetY = -15
			if #GetDisplayName({ Text = text }) >= 19 then
				localizedTextOffsetX = -30
			end
		elseif lang == "pl" then
			localizedTextOffsetY = -5
		elseif lang == "ja" and #GetDisplayName({ Text = text }) >= 23 then
			localizedTextOffsetY = -15
			localizedWidthOverride = 675
		end

		CreateTextBox(MergeTables({
			Id = choiceBackground,
			Text = text,
			Width = localizedWidthOverride,
			OffsetX = -400 + localizedTextOffsetX,
			OffsetY = -133 + localizedTextOffsetY,
			Font = "AlegreyaSansExtraBold",
			FontSize = 28,
			Justification = "LEFT",
			VerticalJustification = "TOP",
			Color = Color.White,
		}, LocalizationData.Narrative.ChoiceBackground ))

		SetAlpha({ Id = anchorId, Fraction = 0 })
		local choiceLocationX = ScreenCenterX - 120
		local choiceLocationY = 820
		local firstChoice = false
		for k, choice in ipairs( line.Choices ) do
			if IsTextLineEligible( CurrentRun, choice, line, line ) then
				local choiceButtonId = CreateScreenObstacle({ Name = "ButtonDialogueChoice", X = choiceLocationX, Y = choiceLocationY, Group = "Combat_Menu" })
				choiceMap[choiceButtonId] = choice
				table.insert( anchorIds, choiceButtonId )
				CreateTextBox(MergeTables({
					Id = choiceButtonId,
					Text = choice.ChoiceText,
					Color = Color.NarrationText,
					Width = 755,
					OffsetX = -10,
					OffsetY = -4,
					Font = "AlegreyaSansSCExtraBold",
					FontSize = 28,
					Justification = "LEFT",
					VerticalJustification = "CENTER",
				}, LocalizationData.Narrative.ChoiceText))
				CreateTextBox({
					Id = choiceButtonId,
					Text = choice.ChoiceDescription,
					Color = Color.Black,
					Width = 755,
					OffsetX = -140,
					OffsetY = -4,
					Font = "AlegreyaSansSCExtraBold",
					FontSize = 28,
					Justification = "LEFT",
					VerticalJustification = "CENTER",
				})
				SetInteractProperty({ DestinationId = choiceButtonId, Property = "TooltipOffsetX", Value = 800})
				if not firstChoice then
					TeleportCursor({ OffsetX = choiceLocationX, OffsetY = choiceLocationY })
					firstChoice = true
				end
				choiceLocationY = choiceLocationY + 60
			end
		end

	end

	wait(0.03)
	-- Workaround for FMOD bug, after a long play-session VO played in 2D can become inaudible.  Pausing and unpausing the sound fixes it.
	PauseSound({ Id = speechId, Duration = 0 })
	ResumeSound({ Id = speechId, Duration = 0 })
	wait(0.17) -- Minimum input advance delay

	local advanceControls = { "Confirm", "Select", "ContinueText", }
	ToggleControl({ Names = advanceControls, Enabled = true })

	local notifyName = nil
	if IsEmpty( choiceMap ) then
		notifyName = "NarrativeLineNextInput"
		NotifyOnControlPressed({ Names = advanceControls, Notify = notifyName })
		waitUntil( notifyName )
	else
		RemoveInputBlock({ Name = "PlayTextLines" })
		EnableShopGamepadCursor()
		notifyName = "NarrativeLineChoiceInput"
		NotifyOnInteract({ Ids = GetAllKeys( choiceMap ), Notify = notifyName })
		GameState.WaitingForChoice = true
		--NotifyOnControlPressed({ Names = hotkeyControls, Notify = notifyName })
		waitUntil( notifyName )
		GameState.WaitingForChoice = false
		local selectedId = NotifyResultsTable[notifyName]
		selectedChoice = choiceMap[selectedId]
		AddInputBlock({ Name = "PlayTextLines" })
		DisableShopGamepadCursor()
	end
	ModifySubtitles({ SuppressLyrics = false })

	killTaggedThreads( NarrativeThreadName )

	DestroyTextBox({ Ids = anchorIds })

	SetAnimation({ DestinationId = anchorId, Name = exitAnimation })
	if line.PortraitExitAnimation ~= nil then
		SetAnimation({ DestinationId = screen.PortraitId, Name = line.PortraitExitAnimation })
		screen.CurrentPortrait = nil
	end

	wait(0.12)
	Destroy({ Ids = anchorIds })
	if choiceBackground ~= nil then
		Destroy({ Id = choiceBackground })
	end

	StopSound({ Id = speechId, Duration = 0.15 })

	if selectedChoice ~= nil then
		PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuClose" })
		selectedChoice.Name = parentLine.Name..selectedChoice.ChoiceText
		PlayTextLine( screen, selectedChoice, line, line, source )
	end

	return true

end

NarrativeThreadName = "NarrativeThreadName"

function CheckHurryTextLine( anchorId, notifyName )

	NotifyOnControlPressed({ Names = { "Confirm", "Select", "ContinueText", "Use", }, Notify = notifyName })
	waitUntil( notifyName, hurryThreadName )

	ModifyTextBox({
		Id = anchorId,
		CharacterFadeTime = 0.01,
		CharacterFadeInterval = 0.001,
		CommaFadeInterval = 0.001,
		PeriodFadeInterval = 0.001,
		RepeatPeriodFadeInterval = 0.001,
		QuestionFadeInterval = 0.001,
		ExclamationFadeInterval = 0.001,
	})

end

function PlayFirstEligibleTextLines( source, textLineSets )

	if textLineSets == nil then
		return
	end

	for textLinesName, textLines in pairs( textLineSets ) do
		local playedSomething = PlayTextLines( source, textLines )
		if playedSomething then
			return
		end
	end

end

function PlayRandomRemainingTextLinesOnceThisRun( source, textLineSets )

	if textLineSets == nil then
		return false
	end

	if HasPlayedAnyTextLines( CurrentRun, textLineSet ) then
		return false
	end

	return PlayRandomRemainingTextLines( source, textLineSets )

end

function HasPlayedAnyTextLines( run, textLineSets )

	if textLineSets == nil then
		return
	end

	for textLinesName, textLines in pairs( textLineSets ) do
		if run.TextLinesRecord[textLinesName] then
			return true
		end
	end

	return false

end

function PlayRandomRemainingTextLines( source, textLineSets )

	if textLineSets == nil then
		return false
	end

	local superPriorityTextLines = {}
	local priorityTextLines = {}
	local eligibleUnplayedLines = {}
	local allEligibleLines = {}
	for textLinesName, textLines in pairs( textLineSets ) do
		if IsTextLineEligible( CurrentRun, textLines ) then
			table.insert( allEligibleLines, textLines )
			if not PlayedRandomTextLines[textLinesName] then
				table.insert( eligibleUnplayedLines, textLines )
				if textLines.SuperPriority then
					table.insert( superPriorityTextLines, textLines )
				elseif textLines.Priority then
					table.insert( priorityTextLines, textLines )
				end
			end
		end
	end

	if IsEmpty( allEligibleLines ) then
		return false
	end

	local randomLines = nil
	if not IsEmpty( superPriorityTextLines ) then
		randomLines = GetRandomValue( superPriorityTextLines )
	elseif not IsEmpty( priorityTextLines ) then
		randomLines = GetRandomValue( priorityTextLines )
	elseif IsEmpty( eligibleUnplayedLines ) then
		-- All lines played, start the record over
		for textLinesName, textLines in pairs( textLineSets ) do
			PlayedRandomTextLines[textLinesName] = nil
		end
		randomLines = GetRandomValue( allEligibleLines )
	else
		randomLines = GetRandomValue( eligibleUnplayedLines )
	end
	PlayedRandomTextLines[randomLines.Name] = true
	PlayTextLines( source, randomLines )
	return true

end

function CancelSpeakingAnimation( screen, source, cue )
	if cue ~= nil then
		waitUntil( cue )
	end
	SetAnimation({ DestinationId = screen.PortraitId, Name = source.Portrait })
end

function ShowContinueArrow( screen, source, cue )
	if cue ~= nil then
		waitUntil( cue )
	end
	SetAnimation({ DestinationId = screen.PromptId, Name = "DialogueContinueArrowIn" })

end
