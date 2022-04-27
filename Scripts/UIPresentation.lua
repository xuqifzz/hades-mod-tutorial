function DisplayLocationText( eventSource, args )

	if not ConfigOptionCache.ShowUIAnimations then
		-- don't show this in Trailer Mode (normally this option is true)
		return
	end

	if args.Delay == nil then
		args.Delay = 2.0
	end

	wait( args.Delay, args.ThreadName or RoomThreadName )
	local layer = "Combat_Menu_TraitTray_Overlay"
	if args.Layer then
		layer = args.Layer
	end
	local locationX = ScreenCenterX
	local locationY = ScreenCenterY
	if args.OffsetY then
		locationY = ScreenCenterY + args.OffsetY
	else
		locationY = ScreenCenterY - 380
	end

	local textOffsetX = args.TextOffsetX or 0
	local textOffsetY = args.TextOffsetY or 0
	local textDelay = args.TextDelay or 0
	local locationTextBG = CreateScreenObstacle({ Name = "BlankObstacle", X = locationX, Y = locationY, Group = layer, Scale = args.Scale or 1 })
	local animationName = args.AnimationName or "LocationTextBGIn"
	local animationOutName = args.AnimationOutName or "LocationTextBGOut"
	local fontScale = args.FontScale or 1.0

	SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = locationTextBG })
	SetAnimation({ Name = animationName, DestinationId = locationTextBG })
	-- SetColor({ Id = locationTextBG, Color = args.FadeColor or Color.Red })
	if textDelay > 0 then
		wait(textDelay, args.ThreadName or RoomThreadName)
	end
	local textScale = 1.0
	if Contains(LocalizationData.UIPresentation.LocationTextSizeAwareScale, GetLanguage({})) then
	local textSize = string.len(args.Text)
		if textSize >= 12 then
			textScale = 0.95
		end
		if textSize >= 20 then
			textScale = 0.825
		end
		if textSize >= 22 then
			textScale = 0.75
		end
		if textSize >= 24 then
			textScale = 0.725
		end
		if textSize >= 28 then
			textScale = 0.65
		end
	end
	CreateTextBox(MergeTables({	Id = locationTextBG, Text = args.Text, Justification = "CENTER",
		ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 3}, ShadowBlur = 0, OffsetX = textOffsetX, OffsetY = textOffsetY,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		Font = "SpectralSCLightTitling", FontSize = 40 * fontScale, Color = args.Color or Color.White,
		CharacterFadeTime = 0, CharacterFadeInterval = 0,
		GroupName = layer,
		Scale = textScale,
		}, LocalizationData.UIPresentation.LocationText ))
	ModifyTextBox({ Id = locationTextBG, ScaleTarget = 1.2, ScaleDuration = 45 })


	PlaySound({ Name = "/SFX/Menu Sounds/HadesLocationTextDisappear", Id = locationTextBG })
	wait( args.Duration or 2.75, args.ThreadName or RoomThreadName )
	SetAnimation({ Name = animationOutName, DestinationId = locationTextBG })
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })

	ModifyTextBox({ Id = locationTextBG, FadeTarget = 0.0, FadeDuration = 0.5, ColorTarget = args.FadeColor or {1, 0, 0, 1}, ColorDuration = 0.5 })
	wait( 1.0, args.ThreadName or RoomThreadName )

	local ids = { locationTextBG, blackScreenId }
	if not IsEmpty( ids ) then
		Destroy({ Ids = ids })
	end

end

function DisplayUnlockText( args )
	local backColor = args.Color or Color.LocationTextGold
	local textColor = args.TextColor or Color.White
	local subTextColor = args.SubTextColor or Color.Gold
	local fontScale = args.FontScale or 1.0
	local titleFont = args.TitleFont or "SpectralSCLightTitling"
	local subtitleFont = args.SubtitleFont or "SpectralSCMedium"
	local supertitleFont = args.SupertitleFont or "SpectralSCMedium"
	local iconMoveSpeed = args.IconMoveSpeed or 1
	local additionalAnimation = args.AdditionalAnimation
	local highlightIcon = args.HighlightIcon
	local iconBacking = args.IconBacking or "BountyEarnedIconBacking"
	local iconScale = args.IconScale or 1.0
	local animationName = args.AnimationName or "LocationTextBGGeneric"
	local animationOutName = args.AnimationOutName or "LocationTextBGGenericOut"

	if args.Delay == nil then
		args.Delay = 0.25
	end

	if args.SubtitleData == nil then
		args.SubtitleData = {}
	end
	if args.SupertitleData == nil then
		args.SupertitleData = {}
	end

	local layer = args.Layer or "Combat_Menu_TraitTray_Overlay"

	wait( args.Delay, args.ThreadName or RoomThreadName )

	local textYOffset = ( -24 * fontScale ) + (args.TextOffsetY or 0)
	local supertitleYOffset = 60 * fontScale
	local subtitleYOffset = 50 * fontScale
	if args.SupertitleText ~= nil then
		textYOffset = -35 * fontScale
		subtitleYOffset = 45 * fontScale
	end

	local locationTextBG = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY - 420, Group = layer, })
	SetAnimation({ Name = animationName, DestinationId = locationTextBG })

	if args.AdditionalAnimation ~= nil then
		CreateAnimation({ Name = additionalAnimation, DestinationId = locationTextBG })
	end

	CreateTextBox(MergeTables({	Id = locationTextBG, Text = args.TitleText, Justification = "CENTER",
		ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 3}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		Font = titleFont, FontSize = 42 * fontScale, Color = args.SuperTitleTextColor or textColor,
		CharacterFadeTime = 0, CharacterFadeInterval = 0,
		OffsetY = textYOffset,
		GroupName = layer,
		}, LocalizationData.UIPresentation.UnlockText ))

	local iconBackingId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY - 315, Group = layer })
	local iconId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY - 315, Group = layer })
	if args.Icon then
		SetAnimation({ Name = iconBacking, DestinationId = iconBackingId, OffsetY = 10 })
		SetScale({ Id = iconId, Fraction = iconScale })
		SetAnimation({ Name = args.Icon, DestinationId = iconId, OffsetY = args.IconOffsetY, OffsetX = args.IconOffsetX })
		if highlightIcon then
			SetThingProperty({ Property = "AddColor", Value = true, DestinationId = iconId })
			SetColor({ Id = iconId, Color = { 255,200,196,0 } })
			SetColor({ Id = iconId, Color = { 0,0,0,255 }, Duration = 1.5 })
			SetAlpha({ Id = iconId, Fraction = 0 })
			SetAlpha({ Id = iconId, Fraction = 1, Duration = 0.125 })
			SetScale({ Id = iconId, Fraction = 0.5 * iconScale })
			SetScale({ Id = iconId, Fraction = 0.6 * iconScale, Duration = 3.5, EaseIn = 0, EaseOut = 1.0})
		end
		Move({ Id = iconId, Speed = iconMoveSpeed * 2, Angle = 0, Duration = 6, EaseOut = 1 })
	end
	CreateTextBox({	Id = iconId, Text = args.SubtitleText,
		Justification = "CENTER",
		OffsetY = -105 + textYOffset + subtitleYOffset,
		ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 3}, ShadowBlur = 0,
		OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
		Font = subtitleFont, FontSize = 30 * fontScale, Color = subTextColor,
		TextSymbolScale = 0.5,
		CharacterFadeTime = 0, CharacterFadeInterval = 0,
		LuaKey = args.SubtitleData.LuaKey, LuaValue = args.SubtitleData.LuaValue,
		GroupName = layer
		})

	ModifyTextBox({ Id = locationTextBG, ScaleTarget = 1.2, ScaleDuration = 60 })

	if args.TextRevealSound ~= nil then
		PlaySound({ Name = args.TextRevealSound })
	end

	if args.SubtitleData.UpdateDelay ~= nil then
		DebugPrint({ Text = "A" })
		wait( args.SubtitleData.UpdateDelay, args.ThreadName or RoomThreadName )
		DebugPrint({ Text = "B" })
		ModifyTextBox({ Id = iconId, LuaKey = args.SubtitleData.LuaKey, LuaValue = args.SubtitleData.LuaValueUpdate, })
		PulseText({ Id = iconId, ScaleTarget = 1.02, ScaleDuration = 0.60, HoldDuration = 0, PulseBias = 0.25 })
	end

	local supertitleTextId = nil
	if args.SupertitleText ~= nil then
		wait( args.SupertitleTextDelay, args.ThreadName or RoomThreadName )
		supertitleTextId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY - 400 + textYOffset + supertitleYOffset, Group = layer, })
		CreateTextBox({	Id = supertitleTextId, Text = args.SupertitleText, Justification = "CENTER",
			ShadowColor = {0, 0, 0, 240}, ShadowOffset = {0, 3}, ShadowBlur = 0,
			OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
			Font = supertitleFont, FontSize = 22 * fontScale, Color = args.SupertitleTextColor or textColor,
			CharacterFadeTime = 0, CharacterFadeInterval = 0,
			LuaKey = args.SupertitleData.LuaKey, LuaValue = args.SupertitleData.LuaValue,
			GroupName = layer
			})
	end

	PlaySound({ Name = "/SFX/Menu Sounds/HadesLocationTextDisappear", Id = promptId })
	-- to make Duration work properly, the UnlockTextBG anim needs to be split up
	wait( (args.Duration or 3.0) - (args.SupertitleTextDelay or 0) - (args.SubtitleData.UpdateDelay or 0), args.ThreadName or RoomThreadName )
	SetAnimation({ Name = animationOutName, DestinationId = locationTextBG })
	PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFadeLOCATION" })

	SetAlpha({ Id = iconId, Fraction = 0.0, Duration = 0.5 })
	SetAlpha({ Id = iconBackingId, Fraction = 0.0, Duration = 0.5 })
	ModifyTextBox({ Id = promptId, FadeTarget = 0.0, FadeDuration = 0.5, ColorTarget = backColor, ColorDuration = 0.5 })
	ModifyTextBox({ Id = iconId, FadeTarget = 0.0, FadeDuration = 0.5, ColorTarget = backColor, ColorDuration = 0.5 })
	ModifyTextBox({ Id = locationTextBG, FadeTarget = 0.0, FadeDuration = 0.5 })
	ModifyTextBox({ Id = supertitleTextId, FadeTarget = 0.0, FadeDuration = 0.5 })
	wait( 0.5, args.ThreadName or RoomThreadName )
	Destroy({ Id = iconBackingId })
	wait( 0.5, args.ThreadName or RoomThreadName )

	DestroyTextBox({ Id = promptId })
	Destroy({ Ids = { promptId, locationTextBG, iconId }})

end

function RunInterstitialPresentation( data, skipSound )

	if data == nil then
		return
	end

	AddInputBlock({ Name = "ShowingInterstitial" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })

	HideCombatUI("ShowingInterstitial")
	if data.PauseMusic then
		PauseMusic()
	end

	local text = data.Header
	local color = Color.White

	local blackScreenId = nil
	if not data.SkipBackgrounds then
		blackScreenId = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY })
		SetScale({ Id = blackScreenId, Fraction = 10 })
		SetColor({ Id = blackScreenId, Color = Color.Black })
		SetAlpha({ Id = blackScreenId, Fraction = 1.0, Duration = 0 })
	end

	wait(0.25)

	local source = {} -- Dummy source for disembodied voice
	source.SubtitleColor = data.SubtitleColor or Color.HadesVoice
	thread( PlayVoiceLines, data.VoiceLines, false, source )
	FadeIn({ Duration = 0 })

	local remBG = nil
	if not data.SkipBackgrounds then
		remBG = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY, Group = "Overlay" })
		SetScale({ Id = remBG, Fraction = 1 })
		SetAlpha({ Id = remBG, Fraction = 1.0, Duration = 0 })
		SetAnimation({ Name = data.BackgroundAnimation or "RemBGIntro", DestinationId = remBG })
	end

	local hadesOverlay = nil
	if data.RemembranceAnimation ~= nil then
		hadesOverlay = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX - 420, Y = ScreenCenterY, Group = "Overlay" })
		SetScale({ Id = hadesOverlay, Fraction = 1 })
		SetAlpha({ Id = hadesOverlay, Fraction = 0.0, Duration = 0 })
		Move({ Id = hadesOverlay, Angle = 270, Speed = 5 })
		SetAnimation({ Name = data.RemembranceAnimation, DestinationId = hadesOverlay })
		SetAlpha({ Id = hadesOverlay, Fraction = 1.0, Duration = 0 })
	end

	if data.Animations ~= nil then
		CreateGroup({ Name = "Events_Additive", BlendMode = "Additive" })
		InsertGroupInFront({ Name = "Events_Additive", DestinationName = "Events" })
		for index, animationData in ipairs(data.Animations) do
			animationData.Id = CreateScreenObstacle({ Name = "BlankObstacle", X = animationData.X or ScreenCenterX , Y = animationData.Y or ScreenCenterY, Group = animationData.Group or "Events" })
			table.insert(ScreenAnchors.Epilogue, animationData.Id)
			thread( DelayedScreenObstacle, animationData )
		end
	end

	wait(2.2)
	if ambienceId ~= nil then
		StopSound({ Id = ambienceId, Duration = 15.8 })
	end

	local promptId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX , Y = ScreenCenterY + 270, Group = "Overlay" })
	CreateTextBox({	Id = promptId, Text = text, Justification = "CENTER",
			ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
			OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
			Font = "SpectralSCLightTitling", FontSize = "86", Color = {0.729,0.702,0.631,255},
			CharacterFadeTime = 0, CharacterFadeInterval = 0,
			})
	ModifyTextBox({ Id = promptId, ScaleTarget = 1.2, ScaleDuration = 70 })

	-- local remBG_Overlay = CreateScreenObstacle({ Name = "rectangle01", X = ScreenCenterX, Y = ScreenCenterY + 280, Group = "Overlay" })
	-- SetAnimation({ Name = "RemBG_Overlay", DestinationId = remBG_Overlay })

	if not skipSound then
		PlaySound({ Name = "/Leftovers/World Sounds/MapText", Id = promptId })
	end

	wait(data.FadeOutWait or 5)

	ModifyTextBox({ Id = promptId, FadeTarget = 0.0, FadeDuration = 1.0, ColorTarget = {1,0,0,1}, ColorDuration=0.5 })


	if not skipSound then
		local fadeSoundId = PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade", Id = promptId })
		SetVolume({ Id = fadeSoundId, Value = 0.3 })
	end
	wait(1.0)
	SetAlpha({ Id = hadesOverlay, Fraction = 0.0, Duration = 1 })
	wait(1.0)
	FadeOut({ Color = Color.Black, Duration = 1.0 })
	wait(2.2)
	DestroyTextBox({ Id = promptId })
	Destroy({ Id = promptId })
	Destroy({ Id = remBG })
	-- Destroy({ Id = remBG_Overlay })
	Destroy({ Id = hadesOverlay })
	Destroy({ Id = blackScreenId })
	Destroy({ Ids = ScreenAnchors.Epilogue })

	ResumeMusic()

	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })
	RemoveInputBlock({ Name = "ShowingInterstitial" })
	UnblockCombatUI("ShowingInterstitial")
end

function DelayedScreenObstacle( animationData )
	wait(animationData.Delay)
	SetAnimation({ DestinationId = animationData.Id, Name = animationData.AnimationName })
	SetScale({ Id = animationData.Id, Fraction = animationData.Scale or 1.1 })

	if animationData.AlphaDuration ~= nil or animationData.StartAlpha ~= nil then
		SetAlpha({ Id = animationData.Id, Fraction = animationData.StartAlpha or 0.0, Duration = 0 })
		SetAlpha({ Id = animationData.Id, Fraction = animationData.EndAlpha or 1.0, Duration = animationData.AlphaDuration or 1.0 })
	end

	if animationData.StartColor ~= nil then
		SetColor({ Id = newObstacleId, Color = animationData.StartColor, Duration = 0 })
		SetColor({ Id = newObstacleId, Color = animationData.EndColor or Color.White, Duration = animationData.ColorDuration or 1, EaseIn = 0, EaseOut = 1 })
	end
end

function ShowCodexUpdate( args )
	args = args or {}
	if not ConfigOptionCache.ShowUIAnimations then
		return
	end
	if not CodexStatus.Enabled then
		return
	end

	wait(0.5)

	local callLockName = "CodexUpdate"
	if not CheckCallLock( callLockName ) then
		return
	end

	local toastAnchor = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = 770, Group = "Combat_UI", })
	SetAnimation({ Name = args.Animation or "CodexUpdateIn", DestinationId = toastAnchor })
	PlaySound({ Name = "/SFX/Menu Sounds/CodexUpdatedShk", Id = toastAnchor })

	CreateTextBox({
		Id = toastAnchor,
		Text = "Codex_EntryUnlocked",
		Group = "Combat_UI",
		Justification = "Center",
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 1},
		OutlineThickness = 2,
		OutlineColor = {0.113, 0.113, 0.113, 1},
		Color = Color.White,
		Font="AlegreyaSansSCExtraBold",
		TextSymbolScale = 1,
		FontSize = 28,
		CharFadeTime = 0.02,
		CharFadeInterval = .002,
		CharFadeColor = Color.White,
		CharFadeColorLag = 0.25,
		OffsetX = 0,
		OffsetY = 80,
	})

	wait(1.0)

	ModifyTextBox({ Id = toastAnchor, ColorTarget = Color.White, ColorDuration = 2.0 })

	wait(2.0)

	ModifyTextBox({ Id = toastAnchor, FadeTarget = 0.0, FadeDuration = 1.0 })

	wait(1.0)

	Destroy({ Id = toastAnchor })
	ReleaseCallLock( callLockName )

end

function UpdateLockedKeyPresentation( obstacle )

	local cost = obstacle.UnlockCost or obstacle.KeyCost
	local resourceName = obstacle.ResourceName or "LockKeys"

	if cost == nil or cost <= 0 then
		return
	end

	if obstacle.TextAnchorId == nil then
		obstacle.TextAnchorId = SpawnObstacle({ Name = "BlankObstacle", Group = obstacle.LockGroupName or "Standing", DestinationId = obstacle.ObjectId, OffsetZ = obstacle.LockOffsetZ })
	end

	local costColor = Color.CostAffordable
	if HasResource( resourceName, cost ) then
		obstacle.UseText = obstacle.UnlockUseText or obstacle.UseText
		SetAnimation({ Name = "LockedIconHasKey", DestinationId = obstacle.TextAnchorId })
	else
		obstacle.UseText = obstacle.LockedUseText or obstacle.UseText
		SetAnimation({ Name = "LockedIconNoKey", DestinationId = obstacle.TextAnchorId })
		costColor = Color.CostUnaffordable
	end

	local unlockCostText = "WeaponLockKeyRequirement"
	if ResourceData[resourceName] then
		unlockCostText = ResourceData[resourceName].RequirementText
	end
	CreateTextBox({ Id = obstacle.TextAnchorId, Text = unlockCostText,
		TextSymbolScale = 0.6,
		OffsetX = obstacle.LockKeyTextOffsetX, OffsetY = obstacle.LockKeyTextOffsetY or -75,
		LuaKey = "TempTextData", LuaValue = { Amount = cost },
		FontSize = 24,
		Color = costColor,
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
end

function GetCosmeticFocusId( saleData )
	local id = nil
	if saleData.DeathAreaFocusId then
		id = saleData.DeathAreaFocusId
	elseif saleData.SetAnimations then
		id = GetIdsByType({ Name = GetFirstKey( saleData.SetAnimations ) })[1]
	elseif saleData.ActivateIds then
		id = saleData.ActivateIds[1]
	elseif saleData.ActivateNames then
		id = GetInactiveIds({ Names = saleData.ActivateNames })[1]
	elseif saleData.ActivateObstacles then
		id = GetFirstKey( saleData.ActivateObstacles )
	elseif saleData.SetHSVs then
		id = GetIdsByType({ Name = GetFirstKey( saleData.SetHSVs ) })[1]
	elseif saleData.DestroyIds then
		id = saleData.DestroyIds[1]
	elseif saleData.DestroyNames then
		id = GetIdsByType({ Name = saleData.DestroyNames })[1]
	end
	return id
end

function PreActivateCosmeticItemsPresentation( button, saleData, args )

	args = args or {}

	FreezePlayerUnit()
	AddInputBlock({ Name = "ActivateCosmeticPresentation" })
	GameState.Flags.CosmeticPresentationActive = true

	local ghostAdminId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "AdminGhost01", Distance = 400 })
	PlaySound({ Name = "/SFX/GhostEvaporate", Id = ghostAdminId, Delay = 1.5 })

	local id = GetCosmeticFocusId( saleData )
	-- preactivate presentation
	if saleData.DoVerticalPan then
		local cameraTarget = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, OffsetY = -200 })
		PanCamera({ Id = cameraTarget, Duration = saleData.PanDuration or 1.0, EaseIn = 0.05, EaseOut = 0.3, Retarget = true, FromCurrentLocation = true })
	else
		PanCamera({ Id = id, Duration = saleData.PanDuration or 1.0, EaseIn = 0.05, EaseOut = 0.3, Retarget = true, FromCurrentLocation = true })
	end
	if saleData.AttachedDim and _G["Dim"..saleData.AttachedDim] then
		_G["UnDim"..saleData.AttachedDim]()
	end
	if saleData.UsePanSound then
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	end
	if args.Removal then
		thread( PlayVoiceLines, GlobalVoiceLines[saleData.RemoveGlobalVoiceLines] )
	elseif button.Free then
		thread( PlayVoiceLines, GlobalVoiceLines[saleData.ReEquipGlobalVoiceLines] )
	else
		if saleData.RevealGlobalVoiceLines then
			thread( PlayVoiceLines, GlobalVoiceLines[saleData.RevealGlobalVoiceLines] )
			wait(0.25)
		elseif saleData.RevealVoiceLines then
			thread( PlayVoiceLines, saleData.RevealVoiceLines )
		end
	end
	if saleData.UseUnlockText then
		thread( DisplayUnlockText, {
			TitleText = saleData.UnlockTextId or "GhostAdminUnlock",
			SubtitleText = saleData.Name,
			Icon = saleData.Icon,
			Delay = 0.6,
			FontScale = 0.76,
			IconScale = 0.7,
			IconMoveSpeed = 0.00001,
			IconOffsetY = 6,
		})
	end
	if saleData.SetPlayerAnimation then
		SetAnimation({ Name = saleData.SetPlayerAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	end
	if saleData.PreActivateFunctionName ~= nil then
		local preActiveFunction = _G[saleData.PreActivateFunctionName]
		if preActiveFunction ~= nil then
			preActiveFunction( button, saleData.PreActivateFunctionArgs )
		end
	end
	wait( saleData.PreActivationHoldDuration or 0.5 )
	if not saleData.SkipFade then
		PlaySound({ Name = "/SFX/Menu Sounds/HadesTextDisappearFade" })
		FullScreenFadeOutAnimation()
	end
	if saleData.ItemPreActivationVfx then
		CreateAnimation({ Name = saleData.ItemPreActivationVfx, DestinationId = id })
	end
	wait(0.5)
	if not saleData.SkipFade and saleData.AddConstructionPresentation then
		PlaySound({ Name = "/SFX/Menu Sounds/AdminConstructionSound" })
		wait(1.5)
	end
	PlaySound({ Name = saleData.ItemActivationSound or "/Leftovers/Menu Sounds/EmoteExcitement" })
end

function PostActivateCosmeticItemsPresentation( button, saleData )
	-- post activation presentation
	local id = GetCosmeticFocusId( saleData )
	if saleData.UseItemActivationVfx then
		CreateAnimation({ Name = saleData.ItemActivationVfx or "CosmeticUnlockFx", DestinationId = saleData.ItemActivationVfxId or id, OffsetY = saleData.ItemActivationVfxOffsetY or 0 })
	end
	if not saleData.SkipFade then
		FullScreenFadeInAnimation()
	end
	if saleData.RevealReactionGlobalVoiceLines and not saleData.SkipRevealReactionGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines[saleData.RevealReactionGlobalVoiceLines] )
	elseif saleData.RevealReactionVoiceLines then
		thread ( PlayVoiceLines, saleData.RevealReactionVoiceLines, true )
	end
	wait( saleData.PostActivationHoldDuration or 0.5 )

	wait(0.25)
	if saleData.UseReturnPanSound then
		PlaySound({ Name = "/Leftovers/World Sounds/MapZoomInShortHigh" })
	end
	if saleData.AttachedDim and _G["Dim"..saleData.AttachedDim] then
		_G["Dim"..saleData.AttachedDim]()
	end
	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 0.75 })
	wait(0.75)
	RemoveInputBlock({ Name = "ActivateCosmeticPresentation" })
	GameState.Flags.CosmeticPresentationActive = false
	UnfreezePlayerUnit()
end

function WeaponAspectRevealPresentation( components, itemName, purchaseButtonKey )
	CreateAnimation({ Name = "WeaponEnchantmentSlotReveal", DestinationId = components[purchaseButtonKey].Id })
	wait(1)
	-- set icons and name
	local itemIcon = TraitData[itemName].Icon .. "_Large"
	local traitData =  GetProcessedTraitData({ Unit = CurrentRun.Hero, TraitName = itemName, Rarity = GetRarityKey(1)})
	SetTraitTextData( traitData )

	SetAnimation({ DestinationId = components[purchaseButtonKey.."Icon"].Id, Name = itemIcon })
	ModifyTextBox({ Id = components[purchaseButtonKey].Id, UseDescription = true, Text = itemName, LuaKey = "TooltipData", LuaValue = traitData })
	ModifyTextBox({ Id = components[purchaseButtonKey .. "Title"].Id, Text = itemName })
end

function QuestIncompletePresentation( button )

end

function MouseOffQuestPresentation( button )
	if GetConfigOptionValue({ Name = "UseMouse" }) then

		local text ="QuestLog_SelectHint"
		if HasAllQuestsWithStatus( "CashedOut" ) then
			text ="QuestLog_SelectHintAllClear"
		end
		CreateTextBox({ Id = ScreenAnchors.QuestLogScreen.Components.DescriptionBox.Id,
			Text = text,
			FontSize = 34,
			OffsetX = 330, OffsetY = 120,
			Color = Color.White,
			TextSymbolScale = textSymbolScale,
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
			Justification = "Center" })
	end
end


function QuestAddedPresentation( questData, threadName )

	wait( 0.5, threadName )

	local toastAnchor = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX + 400, Y = 770 })
	SetAnimation({ Name = "QuestAdded", DestinationId = toastAnchor })
	PlaySound({ Name = "/SFX/Menu Sounds/NewQuestToast", Id = toastAnchor })

	CreateTextBox({
		Id = toastAnchor,
		Text = "QuestLog_QuestAdded",
		Group = "ScreenOverlay",
		Justification = "Center",
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 1},
		OutlineThickness = 2,
		OutlineColor = {0.113, 0.113, 0.113, 1},
		Color = Color.White,
		Font="AlegreyaSansSCExtraBold",
		TextSymbolScale = 1,
		FontSize = 28,
		CharFadeTime = 0.02,
		CharFadeInterval = .002,
		CharFadeColor = Color.White,
		CharFadeColorLag = 0.25,
		OffsetX = 0,
		OffsetY = 120,
	})
	wait( 1.0, threadName )

	ModifyTextBox({ Id = toastAnchor, ColorTarget = Color.White, ColorDuration = 2.0 })
	wait( 0.5, threadName )

	ModifyTextBox({ Id = toastAnchor, FadeTarget = 0.0, FadeDuration = 1.0 })
	wait( 1.0, threadName )

	Destroy({ Id = toastAnchor })

end

function QuestCompletedPresentation( questData, threadName )

	wait( 0.5, threadName )

	local toastAnchor = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX + 400, Y = 770 })
	SetAnimation({ Name = "QuestComplete", DestinationId = toastAnchor })
	PlaySound({ Name = "/SFX/Menu Sounds/QuestCompleteToast", Id = toastAnchor })

	CreateTextBox({
		Id = toastAnchor,
		Text = "QuestLog_QuestComplete",
		Group = "ScreenOverlay",
		Justification = "Center",
		ShadowColor = {0,0,0,1},
		ShadowOffset = {0, 1},
		OutlineThickness = 2,
		OutlineColor = {0.113, 0.113, 0.113, 1},
		Color = Color.White,
		Font="AlegreyaSansSCExtraBold",
		TextSymbolScale = 1,
		FontSize = 28,
		CharFadeTime = 0.02,
		CharFadeInterval = .002,
		CharFadeColor = Color.White,
		CharFadeColorLag = 0.25,
		OffsetX = 0,
		OffsetY = 120,
	})
	wait( 1.0, threadName )

	ModifyTextBox({ Id = toastAnchor, ColorTarget = Color.White, ColorDuration = 2.0 })
	wait( 0.5, threadName )

	ModifyTextBox({ Id = toastAnchor, FadeTarget = 0.0, FadeDuration = 1.0 })
	wait( 1.0, threadName )

	Destroy({ Id = toastAnchor })

end

function QuestCashedOutPresentation( screen, button )

	local newButtonKey = "NewIcon"..button.Index
	if screen.Components[newButtonKey] ~= nil then
		SetAlpha({ Id = screen.Components[newButtonKey].Id, Fraction = 0, Duration = 0.1 })
	end

	PlaySound({ Name = "/SFX/Menu Sounds/QuestCashIn" })
	thread( PlayVoiceLines, button.Data.CashedOutVoiceLines, true )
	thread( PlayVoiceLines, HeroVoiceLines.CashedOutQuestVoiceLines, true )

end

function HardModeShrinePointThresholdIncreasedPresentation( screen )
	wait(0.85)
	thread( PulseText, { Id = screen.Components.SpentShrinePoints.Id, ScaleTarget = 1.1, ScaleDuration = 0.6, Color = Color.White, HoldDuration = 0, PulseBias = 0.2 })
	PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulseAlt", Id = screen.Components.SpentShrinePoints.Id })
	wait(0.6)
	thread( PulseText, { Id = screen.Components.SpentShrinePoints.Id, ScaleTarget = 1.1, ScaleDuration = 0.6, Color = Color.White, HoldDuration = 0, PulseBias = 0.2 })
	PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulseAlt", Id = screen.Components.SpentShrinePoints.Id })
	wait(0.6)
	thread( PulseText, { Id = screen.Components.SpentShrinePoints.Id, ScaleTarget = 1.1, ScaleDuration = 0.6, Color = Color.White, HoldDuration = 0, PulseBias = 0.2 })
	PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulseAlt", Id = screen.Components.SpentShrinePoints.Id })
end

function HardModeInsufficientShrinePointsPresentation( screen )
	thread( PulseText, { Id = screen.Components.SpentShrinePoints.Id, ScaleTarget = 1.2, ScaleDuration = 0.25, Color = Color.Yellow, HoldDuration = 0, PulseBias = 0.5 })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = screen.Components.SpentShrinePoints.Id })
	if CheckCountInWindow( "HardModeFailedRunStart", 1.0, 2 ) then
		thread( PlayVoiceLines, HeroVoiceLines.NotEnoughShrinePointsVoiceLines, true )
	end
end

function SwapMetaUpgradePresentation( screen, button, isSwapToBSide )
	if isSwapToBSide then
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuStatLower" })
	else
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuStatIncrease" })
	end
	CreateAnimation({ Name = "MirrorUpgradeSwap", DestinationId = button.Id })
	thread( PlayVoiceLines, GlobalVoiceLines.MetaUpgradeSwappedVoiceLines, true )
	--[[
	if CheckCountInWindow( "HardModeFailedRunStart", 1.0, 2 ) then
		thread( PlayVoiceLines, HeroVoiceLines.NotEnoughShrinePointsVoiceLines, true )
	end
	]]--
end

function FinalMetaUpgradePresentation( button, metaupgradeName )
	CurrentMetaUpgradeName = metaupgradeName

	if IsScreenOpen( "ShrineUpgrade" ) then
	else
		PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweepSubtle", Id = button.NextCostId })
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorFlash2", Id = button.NextCostId })
	end

	ModifyTextBox({ Id = button.NextCostId, Color = Color.Orange, ColorTarget = Color.Orange, ColorDuration = 0.3 })
	thread(PulseText, {Id = button.NextCostId, Color = Color.Orange, OriginalColor = Color.Gray, ScaleTarget = 1.5, ScaleDuration = 0.1, HoldDuration = 0.1 })

	if IsScreenOpen( "ShrineUpgrade" ) then
	else
		AdjustColorGrading({ Name = "Team03", Duration = 0.3 })
		AdjustFullscreenBloom({ Name = "Default", Duration = 0.3 })
		wait( 0.12 )
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.30 })
		AdjustColorGrading({ Name = "Off", Duration = 0.30 })
	end
end

function CannotAffordKeepsakeUpgrade( button )
	Flash({ Id = button.Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = button.Id })
	if CheckCountInWindow( "CannotAffordKeepsakeUpgradeCheck", 1.0, 2 ) then
		thread( PlayVoiceLines, GlobalVoiceLines.InsufficientSuperGiftPointsVoiceLines, false )
	end
end

function MaxxedOutKeepsakeUpgrade( button )
	Flash({ Id = button.Id, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = button.Id })
	if CheckCountInWindow( "MaxedOutKeepsakeCheck", 1.0, 2 ) then
		thread( PlayVoiceLines, HeroVoiceLines.MetaUpgradeAtGlobalCapVoiceLines, true )
	end
end

function UpgradeKeepsakePresentation( button )
	local parentButton = button.ParentButton
	local level = GetKeepsakeLevel( button.GiftName )

	PlaySound({ Name = "/Leftovers/SFX/StaminaSkillProc", Id = button.Id })
	thread( PlayVoiceLines, GlobalVoiceLines.AwardMenuLegendaryUpgradedVoiceLines, false )

	thread( PulseText, { Id = ScreenAnchors.AwardMenuScreen.Components.CurrentLevel.Id, ScaleTarget = 1.2, ScaleDuration = 0.25, HoldDuration = 0, PulseBias = 0.5 } )
	local target2 = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Overlay" })
	Attach({ Id = target2, DestinationId = ScreenAnchors.AwardMenuScreen.Components.CurrentLevel.Id })
	Flash({ Id = parentButton.Id, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, ExpireAfterCycle = true })
	SetAnimation({ Name = "SkillProcFeedbackFx", DestinationId = target2, Scale = 1.0, GroupName = "Overlay", OffsetY = 197, OffsetX = 105 + 5 * level, Color = Color.Gold })

	local target = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Overlay" })
	Attach({ Id = target, DestinationId = parentButton.Id })
	Flash({ Id = parentButton.Id, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, ExpireAfterCycle = true })
	SetAnimation({ Name = "ZagreusWrathFire_Keepsake", DestinationId = target, Scale = 1.0, OffsetY = 60, GroupName = "Overlay", Color = Color.Gold })
	Shake({ Id = parentButton.Id, Distance = 3, Speed = 500, Duration = 0.35 })

	waitScreenTime(0.8)
	Destroy({ Ids ={ target, target2 }})
end

function TraitTrayHoverOnPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonToggle", Id = button.Id })
end

function TraitTrayPinOnPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonPin", Id = button.Id })
end

function TraitTrayPinOffPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonUnpin", Id = button.Id })
end

function MouseOverMetaIconTray( button )
	SetColor({ Id = button.Id, Color = Color.DimGray })
	PlaySound({ Name = "/SFX/Menu Sounds/VictoryScreenBoonToggle", Id = button.Id })
	Flash({ Id = button.Id, Speed = 1.5, MinFraction = 0.7, MaxFraction = 0, Color = Color.White, ExpireAfterCycle = true })
end

function MouseOffMetaIconTray( button )
	SetColor({ Id = button.Id, Color = Color.Black })
end


function RunClearMessagePresentation( screen, message, args )

	if message == nil then
		return
	end

	args = args or {}

	wait( args.Delay or 1.0 )

	local components = screen.Components
	CreateTextBox({
		Id = args.ComponentId or components.ShopBackground.Id,
		Text = message.Name,
		FontSize = 20,
		OffsetX = args.OffsetX or 0, OffsetY = args.OffsetY or -327,
		Color = {1.000, 0.910, 0.510, 1.0},
		Font = "AlegreyaSansItalic",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		OutlineThickness = 2, OutlineColor = {0,0,0,1},
		Justification = "Center",
		ScaleModifier = 1.4,
		ScaleTarget = 1.4,
	})
	if args.Silent then
		ModifyTextBox({ Id = args.ComponentId or components.ShopBackground.Id, ScaleTarget = 1, ScaleDuration = 0.0 })
	else
		ModifyTextBox({ Id = args.ComponentId or components.ShopBackground.Id, ScaleTarget = 1, ScaleDuration = 0.25 })
		PlaySound({ Name = message.DisplaySound or "/SFX/Menu Sounds/BiomeMapRewardIcon" })
	end
	wait( 1.0 )

end

function GhostAdminSelectCategoryPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
end

function GhostAdminPostDisplayCategoryPresentation( screen )
	if screen.NumItems == 0 then
		CreateTextBox({ Id = screen.Components.ShopBackgroundDim.Id,
			Text = "GhostAdmin_CategoryEmpty",
			FontSize = 34,
			OffsetX = 0, OffsetY = 0,
			Color = Color.White,
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
			Justification = "Center" })
	end
end

function RunHistoryScreenOpenPresentation( screen )
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelIn" })
	thread( PlayVoiceLines, GlobalVoiceLines.OpenedRunHistoryScreenVoiceLines, true )
end

function ShowRunHistoryPresentation( screen, run, index )
	if run.Cleared then
		thread( PlayVoiceLines, GlobalVoiceLines.PositiveRunHistoryScreenVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.NegativeRunHistoryScreenVoiceLines, true )
	end
end

function RunHistorySwitchPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
end

function RunHistoryScreenClosedPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	thread( PlayVoiceLines, GlobalVoiceLines.ClosedRunHistoryScreenVoiceLines, true )
end

-- GameStatsScreen

function GameStatsScreenOpenPresentation( screen )
	PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelIn" })
	thread( PlayVoiceLines, GlobalVoiceLines.OpenedRunHistoryScreenVoiceLines, true )
end

function GameStatsScreenShowCategoryPresentation( screen )
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })

	if not GameState.ScreensViewed["WeaponUpgradeScreen"] or not GameState.ScreensViewed["AwardMenu"] then
		thread( PlayVoiceLines, GlobalVoiceLines.RunHistoryScreenEmptyVoiceLines, true )
	end

	if screen.CurrentFilter == "GameStats_Weapons" then
		thread( PlayVoiceLines, GlobalVoiceLines.RunHistoryScreenWeaponVoiceLines, true )
	elseif screen.CurrentFilter == "GameStats_Boons" then
		thread( PlayVoiceLines, GlobalVoiceLines.RunHistoryScreenBoonVoiceLines, true )
	elseif screen.CurrentFilter == "GameStats_WeaponUpgrades" then
		thread( PlayVoiceLines, GlobalVoiceLines.RunHistoryScreenHammerVoiceLines, true )
	elseif screen.CurrentFilter == "GameStats_Aspects" then
		thread( PlayVoiceLines, GlobalVoiceLines.RunHistoryScreenAspectVoiceLines, true )
	elseif screen.CurrentFilter == "GameStats_Keepsakes" then
		thread( PlayVoiceLines, GlobalVoiceLines.RunHistoryScreenKeepsakeVoiceLines, true )
	end
end

function GameStatsScreenScrollPresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GodBoonMenuToggle" })
end

function GameStatScreenClosePresentation( screen, button )
	PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	thread( PlayVoiceLines, GlobalVoiceLines.ClosedRunHistoryScreenVoiceLines, true )
end