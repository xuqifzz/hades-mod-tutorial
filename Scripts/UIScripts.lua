--[[ * UI LIBRARY * ]]

Import "UIData.lua"

Using "ClickPoof"
Using "FullscreenFadeIn"
Using "FullscreenFadeInFast"
Using "FullscreenFadeOut"
Using "FullscreenFadeOutFast"
Using "Vignette"
Using "VignetteTintable"
Using "RemBGIntro"
Using "RemBG"
Using "RemBG_Overlay"
Using "LowHealthShroud"


OnPreThingCreation
{
	function( triggerArgs )
		-- References survive to objects that cannot survive a load
		ScreenAnchors = {}
		ScreenAnchors.ResourceAnchorIds = {}
		ScreenAnchors.ResourceDeltaIds = {}
		ScreenAnchors.ResourceShowing = {}
		ScreenAnchors.ResourceOffsetYCache = {}
		ScreenAnchors.CallLock = {}
		ScreenPresentationData = {}
		ScreenPresentationData.ResourceRunningThreads = {}
		ScreenPresentationData.ResourceFloating = {}

		EnemyHealthDisplayAnchors = {}
		GamepadCursorRequests = {}
		UIScriptsDeferred =
		{
			SuperMeterDirty = false
		}
		DisableShopGamepadCursor()
	end
}

OnAnyLoad
{
	function( triggerArgs )
		FormatContainerIds = {}
		for formatName, formatTable in pairs( TextFormats ) do
			FormatContainerIds[formatName] = SpawnObstacle({ Name = "BlankObstacle" })
			formatTable.Name = formatName
			formatTable.Id = FormatContainerIds[formatName]
			formatTable.AutoSetDataProperties = true
			CreateTextBox( formatTable )
		end
		if GameState ~= nil then
			GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()
			UpdateActiveShrinePoints()
		end
	end
}

function DeferredUIScripts()
	if UIScriptsDeferred.SuperMeterDirty then
		thread( UpdateSuperMeterUIReal )
	end
end

function AddIcon( word, texturePath, useTooltip )
	Icons[word] = texturePath
	IconTooltips[word] = useTooltip
end

if IconTooltips == nil then
	IconTooltips = {}
end

if Icons == nil then
	Icons = {}
end

for iconName, iconData in pairs( IconData ) do
	Icons[iconName] = iconData.TexturePath
	IconTooltips[iconName] = iconData.UseTooltip
end

OnMenuOpened{ "PauseScreen",
	function( triggerArgs )
		CurrentRun.PrevEasyMode = ConfigOptionCache.EasyMode
		PauseSpeech({ })
		if AudioState.TraversalSoundId ~= nil then
			PauseSound({ Id = AudioState.TraversalSoundId })
		end
		if CurrentRun ~= nil and CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.PauseMusicOnPauseScreen then
			PauseMusic()
		end
	end
}

OnMenuCloseFinished{ "PauseScreen",
	function( triggerArgs )
		ResumeSpeech({ })
		if CurrentRun ~= nil and CurrentRun.CurrentRoom ~= nil and CurrentRun.CurrentRoom.PauseMusicOnPauseScreen then
			ResumeMusic()
		end
		if AudioState.TraversalSoundId ~= nil then
			ResumeSound({ Id = AudioState.TraversalSoundId })
		end
		if CurrentRun.PrevEasyMode ~= ConfigOptionCache.EasyMode then
			if ConfigOptionCache.EasyMode then
				if not HeroHasTrait( "GodModeTrait") and ScreenAnchors.TraitBacking then
					AddTraitToHero({ TraitName = "GodModeTrait" })
				end
				EasyModeEnabledPresentation()
			else
				if CurrentRun.Hero then
					while HeroHasTrait( "GodModeTrait" ) do
						RemoveTrait( CurrentRun.Hero, "GodModeTrait" )
					end
				end
				EasyModeDisabledPresentation()
			end
		end
		thread( MarkObjectiveComplete, "EasyModePrompt" )
	end
}

OnMenuCloseFinished{ "AnnouncementScreen",
	function( triggerArgs )
		notifyExistingWaiters( "AnnouncementScreen" )
	end
}

OnMenuOpened{ "MiscSettingsScreen",
	function( triggerArgs )
		TempTextData = { Resistance = round( (1.0 - CalcEasyModeMultiplier() ) * 100 ) }
	end
}

function UnblockCombatUI( flag )
	-- Don't want to show, just want to re-enable the option
	if flag == nil then
		flag = "Generic"
	end
	CombatUI.Hide[flag] = nil
end

function ShowCombatUI( flag )
	UnblockCombatUI( flag )
	if not IsEmpty(CombatUI.Hide) then
		--DebugPrint({Text = "Combat Show Blocked By " .. tostring(GetFirstKey(CombatUI.Hide))})
		return
	end

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	UnzeroMouseTether("AutoHide")

	if CombatUI.Hiding then
		DestroyCombatUI(nil, {IgnoreFlag = true})
	end

	-- Global needed to manage some UI states [GK 1/24/18]
	ShowingCombatUI = true

	UpdateActiveShrinePoints()
	if CurrentDeathAreaRoom == nil or not CurrentDeathAreaRoom.ShowResourceUIOnly then
		ShowHealthUI()
		ShowSuperMeter()
		ShowAmmoUI()
		ShowGunUI()
		ShowTraitUI()
	end

	local currentRoom = CurrentDeathAreaRoom or CurrentRun.CurrentRoom or {}
	ShowResourceUIs({ CombatOnly = not CurrentRun.Hero.IsDead, ShowResourceUIRequirements = currentRoom.ShowResourceUIRequirements })
	ShowObjectivesUI()

	thread(HideAfterDelay)
end

function ShowUIForDecision()
	ShowingCombatUI = true
	CombatUI.ShowUIForDecision = true
	ShowTraitUI()
	ShowHealthUI()
	ShowResourceUIs()
	killTaggedThreads( CombatUI.HideThreadName )
end

function ShowResourceUIs( args )

	args = args or {}

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	if args.ShowResourceUIRequirements ~= nil and not IsGameStateEligible( CurrentRun, args.ShowResourceUIRequirements) then
		return
	end

	local offsetY = ConsumableUI.StartY
	if CurrentRun.Money > 0 or ScreenAnchors.MoneyIcon ~= nil then
		ShowMoneyUI( offsetY )
		offsetY = offsetY - ConsumableUI.SpacerY
	end
	if CurrentRun.NumRerolls > 0 or ScreenAnchors.Reroll ~= nil then
		ShowRerollUI( offsetY )
		offsetY = offsetY - ConsumableUI.SpacerY
	else
		thread(HideRerollUI)
	end

	for k, resourceName in ipairs( ResourceOrderData ) do
		local amount = GameState.Resources[resourceName]
		if not args.CombatOnly or (args.CombatOnly and ResourceData[resourceName] and ResourceData[resourceName].CombatResource ) or args.ForceShowName == resourceName or ScreenAnchors.ResourceShowing[resourceName] then
			if ShowResourceUI( resourceName, offsetY, args ) then
				offsetY = offsetY - ConsumableUI.SpacerY
			end
		elseif args.UpdateIfShowing then
			if ShowResourceUI( resourceName, offsetY, { UpdateOnly = true } ) then
				offsetY = offsetY - ConsumableUI.SpacerY
			end
		end
	end

end

OnPlayerMoveStarted{
	function( args )
		killTaggedThreads( CombatUI.HideThreadName )
		if IsEmpty( CombatUI.Hide ) and not ShowingCombatUI then
			ShowCombatUI()
		end
	end
}

OnPlayerMoveStopped{
	function( args )
		StartHideAfterDelayThread()
	end
}

OnControlPressed{ "Rush Attack1 Attack2 Attack3 AutoLock Shout",
	function ( args )
		StartHideAfterDelayThread()
	end
}

function StartHideAfterDelayThread()
	thread( HideAfterDelay )

	-- Only show if there's nothing else hiding the UI
	if IsEmpty( CombatUI.Hide ) and not ShowingCombatUI then
		ShowCombatUI()
	end
end

function HideAfterDelay()
	if not CombatUI.AutoHideEnabled then
		return
	end

	if SetThreadWait( CombatUI.HideThreadName, CombatUI.HideDelay ) then
		return
	end

	wait( CombatUI.HideDelay, CombatUI.HideThreadName )

	if CombatUI.AutoHideEnabled and not CombatUI.ShowingTraitDescription and not CombatUI.ShowUIForDecision then
		HideCombatUI(nil, {IgnoreFlag = true})
		ZeroMouseTether("AutoHide")
	end
end

function HideCombatUI( flag, args )
	if args == nil or not args.IgnoreFlag then
		if flag == nil then
			flag = "Generic"
		end
		CombatUI.Hide[flag] = true
	end

	ShowingCombatUI = nil
	UpdateActiveShrinePoints()

	thread(HideCombatUIShadow)
	thread(HideTraitUI)
	thread(HideMoneyUI)
	thread(HideRerollUI)
	HideResourceUIs()

	thread(HideSuperMeter)
	thread(HideObjectivesUI)
	thread(HideHealthUI)
	thread(HideAmmoUI)
	thread(HideGunUI)

	thread(MarkCombatUIHiding)
end

function HideResourceUIs( args )
	for resourceName, amount in pairs( GameState.Resources ) do
		if args == nil or (args.NonCombatOnly and ResourceData[resourceName] and not ResourceData[resourceName].CombatResource ) then
			thread( HideResourceUI, resourceName )
		end
	end
end

function MarkCombatUIHiding()
	CombatUI.Hiding = true
	wait( CombatUI.FadeDuration + 0.1, "CombatUIHide" )
	CombatUI.Hiding = false
end

function DestroyCombatUI( flag, args )
	if args == nil or not args.IgnoreFlag then
		if flag == nil then
			flag = "Generic"
		end
		CombatUI.Hide[flag] = true
	end
	ShowingCombatUI = nil
	DestroyTraitUI()
	DestroyMoneyUI()
	DestroyRerollUI()

	for resourceName, amount in pairs( GameState.Resources ) do
		DestroyResourceUI( resourceName )
	end

	DestroySuperMeter()
	DestroyHealthUI()
	DestroyAmmoUI()
	DestroyGunUI()
	CombatUI.Hiding = false
end

function ResetUI()
	if CurrentRun then
		MoneyUI.LastValue = CurrentRun.Money
	end
	ResetHealthUI()
	ResetSuperUI()
	ResetAmmoUI()
	CreateVignette()
	ActiveScreens = {}
end

function HideCombatUIShadow()
	if ScreenAnchors.Shadow== nil then
		return
	end
	local id = ScreenAnchors.Shadow
	Move({ Id = id, Distance = CombatUI.FadeDistance.Shadow, Angle = 180, Duration = CombatUI.FadeDuration, SmoothStep = true })
	SetAlpha({ Id = id, Fraction = 0, Duration = CombatUI.FadeDuration })
	ScreenAnchors.Shadow = nil

	wait( CombatUI.FadeDuration, RoomThreadName)
	if ShowingCombatUI ~= nil then
		return
	end
	Destroy({ Id = id })
end

function DestroyCombatUIShadow()
	if ScreenAnchors.Shadow == nil then
		return
	end
	Destroy({ Id = ScreenAnchors.Shadow })
	ScreenAnchors.Shadow = nil
end

function ResetHealthUI()
	GameState.HealthUI = {}
	GameState.HealthUI.LowHealthPresentation = false
	ClearHealthShroud()
end

function GetLowHealthUIThreshold( maxHealth )
	maxHealth = maxHealth or CurrentRun.Hero.MaxHealth
	local healthThreshold = maxHealth * HealthUI.LowHealthThreshold
	if HealthUI.LowHealthMaximum ~= nil then
		healthThreshold = math.min( healthThreshold, HealthUI.LowHealthMaximum )
	end
	if HealthUI.LowHealthMinimum ~= nil then
		healthThreshold = math.max( healthThreshold, HealthUI.LowHealthMinimum )
	end
	return healthThreshold
end

function UpdateLifePips( heroUnit )
	local unit = heroUnit or CurrentRun.Hero
	if not ScreenAnchors.LifePipIds or not unit.LastStands then
		return
	end
	local lastSeenLives = UIData.LastSeenLives or 0
	local numLives = TableLength( unit.LastStands )
	for i, lifePipId in pairs( ScreenAnchors.LifePipIds ) do
		local lastStandData = unit.LastStands[i]
		if lastStandData then
			SetAnimation({ Name = lastStandData.Icon, DestinationId = ScreenAnchors.LifePipIds[i] })
		else
			if unit.IsDead then
				if IsMetaUpgradeActive("ExtraChanceReplenishMetaUpgrade") then
					SetAnimation({ Name = "ExtraLifeReplenish", DestinationId = ScreenAnchors.LifePipIds[i] })
				else
					SetAnimation({ Name = "ExtraLifeZag", DestinationId = ScreenAnchors.LifePipIds[i] })
				end
			else
				SetAnimation({ Name = "ExtraLifeEmpty", DestinationId = ScreenAnchors.LifePipIds[i] })
			end
		end
	end
end

function RecreateLifePips()
	ScreenAnchors.LifePipIds = {}
	local numLastStands = 0
	if CurrentRun.Hero.IsDead then
		numLastStands = TableLength( CurrentRun.Hero.LastStands ) + GetNumMetaUpgradeLastStands()
	elseif CurrentRun.Hero.MaxLastStands then
		numLastStands = CurrentRun.Hero.MaxLastStands
	end

	for i = 1, numLastStands do
		local obstacleId = CreateScreenObstacle({Name = "BlankObstacle", Group = "Combat_UI", X = 70 + i * 32, Y = ScreenHeight - 95})
		SetAnimation({ Name = "ExtraLifeEmpty", DestinationId = obstacleId })
		table.insert(ScreenAnchors.LifePipIds, obstacleId )
	end
	UpdateLifePips()
end

function ShowHealthUI()
	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	if ScreenAnchors.HealthBack ~= nil then
		return
	end

	if ScreenAnchors.Shadow == nil then
		ScreenAnchors.Shadow = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI_Backing", X = 0, Y = ScreenHeight })
		SetAnimation({ Name = "BarShadow", DestinationId = ScreenAnchors.Shadow })
	end

	ScreenAnchors.HealthBack = CreateScreenObstacle({Name = "BlankObstacle", Group = "Combat_UI", X = 10 - CombatUI.FadeDistance.Health, Y = ScreenHeight - 50})
	ScreenAnchors.HealthRally = CreateScreenObstacle({Name = "BlankObstacle", Group = "Combat_UI", X = 10 - CombatUI.FadeDistance.Health, Y = ScreenHeight - 50})
	ScreenAnchors.HealthFill = CreateScreenObstacle({Name = "BlankObstacle", Group = "Combat_UI", X = 10 - CombatUI.FadeDistance.Health, Y = ScreenHeight - 50})
	ScreenAnchors.HealthFlash =  CreateScreenObstacle({Name = "BlankObstacle", Group = "Combat_UI", X = 10 - CombatUI.FadeDistance.Health, Y = ScreenHeight - 50})
	ScreenAnchors.StoredAmmo =  ScreenAnchors.StoredAmmo or {}
	ScreenAnchors.SelfStoredAmmo =  ScreenAnchors.SelfStoredAmmo or {}

	if GameState.BadgeRank ~= nil then
		local badgeData = GameData.BadgeData[GameData.BadgeOrderData[GameState.BadgeRank]]
		ScreenAnchors.BadgeId =  CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = 44, Y = ScreenHeight - 60, Scale = 0.5 })
		SetAnimation({ Name = badgeData.Icon, DestinationId = ScreenAnchors.BadgeId })
	end

	RecreateLifePips()

	CreateTextBox(MergeTables({ Id = ScreenAnchors.HealthBack, OffsetX = 366 + 8, OffsetY = -13,
			Font = "AlegreyaSansSCBold", FontSize = 24, ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
			OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 1,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0, Justification = "Left",
			}, LocalizationData.UIScripts.HealthUI ))

	SetAnimation({ Name = "HealthBar", DestinationId = ScreenAnchors.HealthBack })

	local frameTarget = 1 - (CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth)
	SetAnimation({ Name = "HealthBarFill", DestinationId = ScreenAnchors.HealthFill, FrameTarget = frameTarget, Instant = true, Color = Color.Black })
	SetAnimation({ Name = "HealthBarFillWhite", DestinationId = ScreenAnchors.HealthRally, FrameTarget = frameTarget, Instant = true, Color = Color.RallyHealth })

	thread(UpdateHealthUI)

	if CurrentRun.CurrentRoom.LoadedAmmo then
		for i = 1, CurrentRun.CurrentRoom.LoadedAmmo do
			local offsetX = 380
			local offsetY = -50
			offsetX = offsetX + ( #ScreenAnchors.SelfStoredAmmo * 22 )
			local screenId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", DestinationId = ScreenAnchors.HealthBack, X = 10 + offsetX, Y = ScreenHeight - 50 + offsetY })
			SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = screenId })
			table.insert( ScreenAnchors.SelfStoredAmmo, screenId )
			SetAnimation({ Name = "AmmoEmbeddedInEnemyIcon", DestinationId = screenId })
		end
	end

	FadeObstacleIn({ Id = ScreenAnchors.HealthBack, Duration = CombatUI.FadeInDuration, IncludeText = true, Distance = CombatUI.FadeDistance.Health, Direction = 0 })
	FadeObstacleIn({ Id = ScreenAnchors.HealthRally, Duration = CombatUI.FadeInDuration, IncludeText = false, Distance = CombatUI.FadeDistance.Health, Direction = 0 })
	FadeObstacleIn({ Id = ScreenAnchors.HealthFill, Duration = CombatUI.FadeInDuration, IncludeText = false, Distance = CombatUI.FadeDistance.Health, Direction = 0 })
	FadeObstacleIn({ Id = ScreenAnchors.HealthFlash, Duration = CombatUI.FadeInDuration, IncludeText = false, Distance = CombatUI.FadeDistance.Health, Direction = 0 })
	if ScreenAnchors.BadgeId ~= nil then
		FadeObstacleIn({ Id = ScreenAnchors.BadgeId, Duration = CombatUI.FadeInDuration, IncludeText = false, Distance = CombatUI.FadeDistance.Health, Direction = 0 })
	end
	
end

function UpdateHealthUI( damageEventArgs )
	local unit = CurrentRun.Hero
	if unit == nil then
		return
	end

	local currentHealth = unit.Health
	local maxHealth = unit.MaxHealth
	if currentHealth == nil or maxHealth == nil then
		return
	end

	local rallyHealth = CurrentRun.Hero.RallyHealth.Store
	if ScreenAnchors.HealthBack ~= nil then
		ModifyTextBox({ Id = ScreenAnchors.HealthBack, Text = "UI_PlayerHealth", LuaKey = "TempTextData", LuaValue = { Current = math.ceil(currentHealth), Maximum = math.ceil(maxHealth) }, AutoSetDataProperties = false })
	end

	if ScreenAnchors.HealthFill ~= nil then
		SetAnimationFrameTarget({ Name = "HealthBarFill", Fraction = 1 - (currentHealth) / maxHealth, DestinationId = ScreenAnchors.HealthFill })
	end
	SetAnimationFrameTarget({ Name = "HealthBarFillWhite", Fraction = 1 - (currentHealth + rallyHealth) / maxHealth, DestinationId = ScreenAnchors.HealthRally })
	CurrentRun.Hero.RallyHealth.Cache =
	{
		CurrentHealth = currentHealth,
		MaxHealth = maxHealth
	}
end

function UpdateRallyHealthUI( )
	local unit = CurrentRun.Hero
	local rallyHealth = CurrentRun.Hero.RallyHealth.Store
	local currentHealth = unit.Health
	local maxHealth = unit.MaxHealth
	if CurrentRun.Hero.RallyHealth.Cache ~= nil then
		currentHealth = CurrentRun.Hero.RallyHealth.Cache.CurrentHealth
		maxHealth = CurrentRun.Hero.RallyHealth.Cache.MaxHealth
	end

	SetAnimationFrameTarget({ Name = "HealthBarFillWhite", Fraction = 1 - (currentHealth + rallyHealth) / maxHealth, DestinationId = ScreenAnchors.HealthRally })
end

function HideHealthUI()
	if ScreenAnchors.HealthBack == nil then
		return
	end
	local healthIds = { "HealthBack", "HealthFill", "HealthFlash", "HealthRally", "BadgeId" }
	local healthAnchorIds = {}
	for i, id in pairs( healthIds ) do
		table.insert(healthAnchorIds, ScreenAnchors[id])
	end
	for i, id in pairs( ScreenAnchors.LifePipIds ) do
		table.insert(healthAnchorIds, id )
	end

	for i, id in pairs(  ScreenAnchors.SelfStoredAmmo ) do
		table.insert(healthAnchorIds, id )
	end

	ScreenAnchors.HealthBack = nil
	ScreenAnchors.HealthFill = nil
	ScreenAnchors.HealthFlash = nil
	ScreenAnchors.HealthRally = nil
	ScreenAnchors.LifePipIds = nil
	ScreenAnchors.SelfStoredAmmo = nil
	ScreenAnchors.BadgeId = nil

	HideObstacle({ Ids = healthAnchorIds, IncludeText = true, FadeTarget = 0, Duration = CombatUI.FadeDuration, Angle = 180, Distance = CombatUI.FadeDistance.Health })

	wait( CombatUI.FadeDuration, RoomThreadName )

	Destroy({ Ids = healthAnchorIds })
end

function DestroyHealthUI()
	local ids = CombineTables( { ScreenAnchors.HealthBack, ScreenAnchors.HealthFill, ScreenAnchors.HealthFlash }, ScreenAnchors.LifePipIds )
	if not IsEmpty( ids ) then
		Destroy({ Ids = ids })
	end
	ScreenAnchors.HealthBack = nil
	ScreenAnchors.HealthFill = nil
	ScreenAnchors.HealthFlash = nil
	ScreenAnchors.HealthRally = nil
	ScreenAnchors.LifePipIds = nil
	ScreenAnchors.BadgeId = nil
end

function ShowResourceUI( resourceName, offsetY, args )
	if not ConfigOptionCache.ShowUIAnimations or not ShowingCombatUI then
		return false
	end

	local resourceData = ResourceData[resourceName]
	if resourceData == nil then
		return false
	end

	if GameState.Resources[resourceName] == nil or GameState.Resources[resourceName] <= 0 then
		if ScreenAnchors.ResourceShowing[resourceName] then
			-- Still need to update position
			if ScreenAnchors.ResourceOffsetYCache[resourceName] ~= offsetY then
				local tempObstacleId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = ConsumableUI.StartX + ConsumableUI.SpacerX * 2 , Y = offsetY or 0 })
				Move({ Id = ScreenAnchors.ResourceAnchorIds[resourceName], DestinationId = tempObstacleId, Duration = CombatUI.FadeInDuration })
				Destroy({ Id = tempObstacleId })
				ScreenAnchors.ResourceOffsetYCache[resourceName] = offsetY
			end
		end
		-- Keep previous showing state once reduced to 0
		return ScreenAnchors.ResourceShowing[resourceName]
	end

	local anchorId = nil
	if ScreenAnchors.ResourceAnchorIds[resourceName] == nil then
		if args.UpdateOnly then
			return false
		end
		anchorId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = ConsumableUI.StartX + ConsumableUI.SpacerX * 2  + CombatUI.FadeDistance.ShrinePoint, Y = offsetY or 0 })
		ScreenAnchors.ResourceAnchorIds[resourceName] = anchorId
		FadeObstacleIn({ Id = anchorId, Duration = CombatUI.FadeInDuration, IncludeText = true, Distance = CombatUI.FadeDistance.ShrinePoint, Direction = 180 })
		SetAnimation({ Name = resourceData.Icon, DestinationId = anchorId })
		SetScale({ Id = anchorId, Fraction = 0.5, Duration = 0 })
		CreateTextBox({ Id = anchorId,
			Text = GameState.Resources[resourceName],
			OffsetX = -30, OffsetY = -2,
			Font = "AlegreyaSansSCBold", FontSize = 28,
			ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
			OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 3,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
			Justification = "Right",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		})
	else
		if not ScreenAnchors.ResourceShowing[resourceName] then
			if args and args.UpdateOnly then
				return false
			end
		end
		anchorId = ScreenAnchors.ResourceAnchorIds[resourceName]
		if ScreenAnchors.ResourceOffsetYCache[resourceName] ~= offsetY then
			local tempObstacleId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = ConsumableUI.StartX + ConsumableUI.SpacerX * 2 , Y = offsetY or 0 })
			Move({ Id = anchorId, DestinationId = tempObstacleId, Duration = CombatUI.FadeInDuration })
			Destroy({ Id = tempObstacleId })
		end
		SetAlpha({ Id = anchorId, Fraction = 1, Duration = CombatUI.FadeInDuration })
		ModifyTextBox({ Id = anchorId, Text = GameState.Resources[resourceName] })
	end

	ScreenAnchors.ResourceShowing[resourceName] = true
	ScreenAnchors.ResourceOffsetYCache[resourceName] = offsetY

	return true

end

function HideResourceUI( resourceName )
	if ScreenAnchors.ResourceAnchorIds[resourceName] == nil then
		return
	end

	local anchorId = ScreenAnchors.ResourceAnchorIds[resourceName]
	HideObstacle({ Id = anchorId, Distance = CombatUI.FadeDistance.ShrinePoint, Angle = 0, Duration = CombatUI.FadeDuration, SmoothStep = true })

	ScreenAnchors.ResourceShowing[resourceName] = false
	ScreenAnchors.ResourceOffsetYCache[resourceName] = nil
end


function DestroyResourceUI( resourceName )
	if ScreenAnchors.ResourceAnchorIds[resourceName] == nil then
		return
	end
	Destroy({ Ids = { ScreenAnchors.ResourceAnchorIds[resourceName], ScreenAnchors.ResourceDeltaIds[resourceName] }})
	ScreenAnchors.ResourceAnchorIds[resourceName] = nil
	ScreenAnchors.ResourceOffsetYCache[resourceName] = nil
end

function UpdateResourceUI( resourceName, newValue )
	if ScreenAnchors.ResourceAnchorIds[resourceName] == nil then
		return
	end
	ModifyTextBox({ Id = ScreenAnchors.ResourceAnchorIds[resourceName], Text = newValue, AutoSetDataProperties = false, })
end

function ShowRerollUI( offsetY )
	if not ConfigOptionCache.ShowUIAnimations or not ShowingCombatUI then
		return
	end

	if ScreenAnchors.Reroll ~= nil then
		-- Already visible, still need to update position
		if ScreenAnchors.ResourceOffsetYCache.Rerolls ~= offsetY then
			local tempObstacleId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = ConsumableUI.StartX + ConsumableUI.SpacerX * 2 , Y = offsetY or 0 })
			Move({ Id = ScreenAnchors.Reroll, DestinationId = tempObstacleId, Duration = CombatUI.FadeInDuration })
			Destroy({ Id = tempObstacleId })
			ScreenAnchors.ResourceOffsetYCache.Rerolls = offsetY
		end
		return
	end

	ScreenAnchors.Reroll = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = ConsumableUI.StartX + ConsumableUI.SpacerX * 2  + CombatUI.FadeDistance.ShrinePoint, Y = offsetY or 0 })
	SetAnimation({ Name = "RerollIcon", DestinationId = ScreenAnchors.Reroll })
	SetScale({ Id = ScreenAnchors.Reroll, Fraction = 0.5, Duration = 0})
	CreateTextBox({ Id = ScreenAnchors.Reroll, Text = CurrentRun.NumRerolls, OffsetX = -30, OffsetY = -2,
			Font = "AlegreyaSansSCBold", FontSize = 28, ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
			OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 3,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0, Justification = "Right" })
	FadeObstacleIn({ Id = ScreenAnchors.Reroll, Duration = CombatUI.FadeInDuration, IncludeText = true, Distance = CombatUI.FadeDistance.ShrinePoint, Direction = 180 })
	ScreenAnchors.ResourceOffsetYCache.Rerolls = offsetY

end

function HideRerollUI()
	if ScreenAnchors.Reroll == nil then
		return
	end
	local id = ScreenAnchors.Reroll
	HideObstacle({ Id = id, IncludeText = true, Distance = CombatUI.FadeDistance.ShrinePoint, Angle = 0, Duration = CombatUI.FadeDuration, SmoothStep = true })
	ScreenAnchors.Reroll = nil

	wait( CombatUI.FadeDuration, RoomThreadName )
	Destroy({ Id = id })
end

function DestroyRerollUI()
	if ScreenAnchors.Reroll == nil then
		return
	end
	Destroy({ Id = ScreenAnchors.Reroll })
	ScreenAnchors.Reroll = nil
end

function UpdateRerollUI( newValue )
	if ScreenAnchors.Reroll == nil then
		return
	end
	ModifyTextBox({ Id = ScreenAnchors.Reroll, Text = newValue, AutoSetDataProperties = false, })
end

function ShowMoneyUI( offsetY )
	if not ConfigOptionCache.ShowUIAnimations or not ShowingCombatUI then
		return
	end
	if ScreenAnchors.MoneyIcon ~= nil then
		-- Already visible
		return
	end

	ScreenAnchors.MoneyIcon = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = ConsumableUI.StartX + CombatUI.FadeDistance.Money, Y = offsetY })

	SetAnimation({ Name = "CurrencyIcon", DestinationId = ScreenAnchors.MoneyIcon })
	SetScale({ Id = ScreenAnchors.MoneyIcon, Fraction = 0.5, Duration = 0})

	CreateTextBox({ Id = ScreenAnchors.MoneyIcon, Text = CurrentRun.Money, OffsetX = -30, OffsetY = -2,
			Font = "AlegreyaSansSCBold", FontSize = 28, ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
			OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 3,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0, Justification = "Right" })

	FadeObstacleIn({ Id = ScreenAnchors.MoneyIcon, Duration = CombatUI.FadeInDuration, IncludeText = true, Distance = CombatUI.FadeDistance.Money, Direction = 180 })

end

function HideMoneyUI()
	if ScreenAnchors.MoneyIcon == nil then
		return
	end
	local ids = { ScreenAnchors.MoneyIcon, ScreenAnchors.MoneyDelta, ScreenAnchors.MoneyDeltaMoveTargetId }
	HideObstacle({ Ids = ids, IncludeText = true, Distance = CombatUI.FadeDistance.Money, Angle = 0, Duration = CombatUI.FadeDuration, SmoothStep = true })

	ScreenAnchors.MoneyIcon = nil
	ScreenAnchors.MoneyDelta = nil
	ScreenAnchors.MoneyDeltaMoveTargetId = nil

	wait( CombatUI.FadeDuration, RoomThreadName)
	if ShowingCombatUI ~= nil then
		return
	end
	Destroy({ Ids = ids })
end

function DestroyMoneyUI()
	local ids = { ScreenAnchors.MoneyIcon, ScreenAnchors.MoneyDelta, ScreenAnchors.MoneyDeltaMoveTargetId }
	if not IsEmpty( ids ) then
		Destroy({ Ids = ids })
	end
	ScreenAnchors.MoneyIcon = nil
	ScreenAnchors.MoneyDelta = nil
	ScreenAnchors.MoneyDeltaMoveTargetId = nil
end

function UpdateMoneyUI( newValue )
	if not ConfigOptionCache.ShowUIAnimations or not ShowingCombatUI then
		return
	end
	local valueDelta = newValue - MoneyUI.LastValue
	MoneyUI.LastValue = newValue
	MoneyUI.Floating = MoneyUI.Floating + valueDelta

	if valueDelta > 0 then
		thread(MoneyGainPresentation, newValue, valueDelta)
	elseif valueDelta < 0 then
		thread(MoneyLossPresentation, newValue, valueDelta)
	end

	if CurrentRun.CurrentRoom.Store ~= nil and CurrentRun.CurrentRoom.Store.SpawnedStoreItems ~= nil then
		for i, item in pairs(CurrentRun.CurrentRoom.Store.SpawnedStoreItems) do
			UpdateCostText( item, true )
		end
	end

	ModifyTextBox({ Id = ScreenAnchors.MoneyIcon, Text = CurrentRun.Money, AutoSetDataProperties = false, })

	if ScreenAnchors.MoneyIcon == nil then
		return
	end
end

function ResourceGainPresentation( resourceName, delta )
	if ScreenAnchors.ResourceAnchorIds[resourceName] == nil then
		return
	end
	if not ScreenAnchors.ResourceShowing[resourceName] then
		return
	end

	local resourceData = ResourceData[resourceName]

	local text = "GainGenericResource"
	local color = Color.Orange
	local lightColor = Color.LightGold
	if not ScreenPresentationData.ResourceFloating[resourceName] then
		ScreenPresentationData.ResourceFloating[resourceName] = 0
	end

	ScreenPresentationData.ResourceFloating[resourceName] = ScreenPresentationData.ResourceFloating[resourceName] + delta

	if ScreenPresentationData.ResourceFloating[resourceName] < 0 then
		text = "SpendGenericResource"
		color = Color.CostUnaffordableLight
		lightColor = Color.CostUnaffordableLight
	end
	local floatingMoney = ScreenPresentationData.ResourceFloating[resourceName]

	-- Color
	ModifyTextBox({ Id = ScreenAnchors.ResourceAnchorIds[resourceName], ScaleTarget = 1.8, ScaleDuration = 0.0, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0 })
	waitScreenTime(0.05)
	ModifyTextBox({ Id = ScreenAnchors.ResourceAnchorIds[resourceName], ScaleTarget = 1.0, ScaleDuration = 2, ColorTarget = color, ColorDuration = 0.1, AutoSetDataProperties = false, })

	if delta > 0 then
		CreateAnimation({ Name = "ResourceGainedHighlight", DestinationId = ScreenAnchors.ResourceAnchorIds[resourceName] })
	end

	waitScreenTime(0.06)
	if not ShowingCombatUI then
		return
	end
	ModifyTextBox({ Id = ScreenAnchors.ResourceAnchorIds[resourceName], ColorTarget = Color.White, ColorDuration = 2.0, AutoSetDataProperties = false, })
	local currentAmount = GameState.Resources[resourceName] or 0
	local digitSpacer = string.len(currentAmount) * MoneyUI.DigitSpacer

	if ScreenAnchors.ResourceDeltaIds[resourceName] ~= nil then
		Attach({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], DestinationId = ScreenAnchors.ResourceAnchorIds[resourceName], OffsetX = MoneyUI.StartSpacer + digitSpacer, OffsetY = 0 })
		ModifyTextBox({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], Text = text, LuaKey = "TempTextData", LuaValue = { Amount = math.abs( floatingMoney ) }, AutoSetDataProperties = false })
	else
		ScreenAnchors.ResourceDeltaIds[resourceName] = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI" })
		Attach({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], DestinationId = ScreenAnchors.ResourceAnchorIds[resourceName], OffsetX = MoneyUI.StartSpacer + digitSpacer, OffsetY = 0 })

		CreateTextBox({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], Text = text,
				Font = "AlegreyaSansSCRegular", FontSize = 28, ShadowColor = { 0.1, 0.1, 0.1, 1.0 },
				Color = Color.White,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 3,
				ShadowBlur = 0, ShadowOffset = { 0, 4 }, Justification = "Right", TextSymbolScale = 0.5,
				LuaKey = "TempTextData", LuaValue = { Amount = math.abs( floatingMoney ) },
				AutoSetDataProperties = false,
				})
	end

	-- Color pulse
	ModifyTextBox({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], Color = lightColor, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0, AutoSetDataProperties = false, })
	waitScreenTime(0.05)
	ModifyTextBox({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], ColorTarget = Color.White, ColorDuration = 1.6, AutoSetDataProperties = false, })

	thread( HideResourceAfterDelay, resourceName )
end

function HideResourceAfterDelay( resourceName )
	ScreenPresentationData.ResourceRunningThreads[resourceName] = ScreenPresentationData.ResourceRunningThreads[resourceName] or 0
	ScreenPresentationData.ResourceRunningThreads[resourceName] = ScreenPresentationData.ResourceRunningThreads[resourceName] + 1

	wait(MoneyUI.HideDelay, RoomThreadName )
	if ScreenAnchors.ResourceDeltaIds[resourceName] ~= nil then
		ModifyTextBox({ Id = ScreenAnchors.ResourceDeltaIds[resourceName], FadeTarget = 0, FadeDuration = MoneyUI.FadeDuration, AutoSetDataProperties = false, })
	end
	wait(MoneyUI.FadeDuration, RoomThreadName )

	ScreenPresentationData.ResourceRunningThreads[resourceName] = ScreenPresentationData.ResourceRunningThreads[resourceName] - 1
	if ScreenPresentationData.ResourceRunningThreads[resourceName] == 0 then
		ScreenPresentationData.ResourceFloating[resourceName] = 0
	end
end

function ResetAmmoUI()
	GameState.AmmoUI =
	{
		RunningThreads = 0
	}
end

function ShowAmmoUI()
	if ScreenAnchors.AmmoIndicatorUI ~= nil then
		return
	end
	ScreenAnchors.AmmoIndicatorUI = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = 512, Y = ScreenHeight - 62 })
	SetAnimation({ Name = "AmmoIndicatorIcon", DestinationId = ScreenAnchors.AmmoIndicatorUI})
	CreateTextBox(MergeTables({ Id = ScreenAnchors.AmmoIndicatorUI, OffsetX = 24, OffsetY = -2,
			Font = "AlegreyaSansSCBold", FontSize = 24, ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
			OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 1,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0, Justification = "Left",
			}, LocalizationData.UIScripts.AmmoUI ))
	thread( UpdateAmmoUI )

	FadeObstacleIn({ Id = ScreenAnchors.AmmoIndicatorUI, Duration = CombatUI.FadeInDuration, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Direction = 0 })
end

function UpdateAmmoUI( triggerArgs )
	if ScreenAnchors.AmmoIndicatorUI == nil or CurrentRun.Hero == nil then
		return
	end
	triggerArgs = triggerArgs or {}
	local ammoData =
	{
		Current = triggerArgs.Ammo or GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = "RangedWeapon", Property = "Ammo" }),
		Maximum = triggerArgs.MaxAmmo or GetWeaponMaxAmmo({ Id = CurrentRun.Hero.ObjectId, WeaponName = "RangedWeapon" })
	}
	PulseText({ ScreenAnchorReference = "AmmoIndicatorUI", ScaleTarget = 1.04, ScaleDuration = 0.05, HoldDuration = 0.05, PulseBias = 0.02})
	ModifyTextBox({ Id = ScreenAnchors.AmmoIndicatorUI, Text = "UI_AmmoText", OffsetY = -2, LuaKey = "TempTextData", LuaValue = ammoData, AutoSetDataProperties = false, })
end

function HideAmmoUI()
	if ScreenAnchors.AmmoIndicatorUI == nil then
		return
	end
	ScreenAnchors.AmmoIndicatorUIReloads = ScreenAnchors.AmmoIndicatorUIReloads or {}

	local ids = CombineTables( { ScreenAnchors.AmmoIndicatorUI }, ScreenAnchors.AmmoIndicatorUIReloads )

	for i, reloadId in pairs( ids ) do
		HideObstacle({ Id = reloadId, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Angle = 180, Duration = CombatUI.FadeDuration, SmoothStep = true })
	end
	ScreenAnchors.AmmoIndicatorUI = nil
	ScreenAnchors.AmmoIndicatorUIReloads = nil

	wait( CombatUI.FadeDuration, RoomThreadName )

	Destroy({ Ids = ids })
end

function DestroyAmmoUI()
	if ScreenAnchors.AmmoIndicatorUI == nil then
		return
	end
	Destroy({ Id = ScreenAnchors.AmmoIndicatorUI })
	Destroy({ Ids = ScreenAnchors.AmmoIndicatorUIReloads })
	ScreenAnchors.AmmoIndicatorUI = nil
end

function ShowGunUI( gunData )

	if not CurrentRun.Hero.Weapons.GunWeapon then
		return
	end
	if ScreenAnchors.GunUI ~= nil then
		return
	end

	if ScreenAnchors.Shadow ~= nil then
		SetScaleX({ Id = ScreenAnchors.Shadow, Fraction = 1.3 })
	end

	ScreenAnchors.GunUI = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = GunUI.StartX, Y = GunUI.StartY })


	if HeroHasTrait( "GunLoadedGrenadeTrait" ) then
		SetAnimation({ Name = "GunLaserIndicatorIcon", DestinationId = ScreenAnchors.GunUI})
	else
		SetAnimation({ Name = "GunAmmoIndicatorIcon", DestinationId = ScreenAnchors.GunUI})
	end

	local offsetX = 20
	CreateTextBox(MergeTables({ Id = ScreenAnchors.GunUI, OffsetX = offsetX, OffsetY = -2,
			Font = "AlegreyaSansSCBold", FontSize = 24, ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
			OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 1,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0, Justification = "Left",},
			LocalizationData.UIScripts.GunUI ))
	thread( UpdateGunUI )

	FadeObstacleIn({ Id = ScreenAnchors.GunUI, Duration = CombatUI.FadeInDuration, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Direction = 0 })

end

function UpdateGunUI( triggerArgs )

	triggerArgs = triggerArgs or {}
	local ammoData =
	{
		Current = triggerArgs.Ammo or GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = "GunWeapon", Property = "Ammo" }),
		Maximum = triggerArgs.MaxAmmo or GetWeaponMaxAmmo({ Id = CurrentRun.Hero.ObjectId, WeaponName = "GunWeapon" })
	}

	if ammoData.Current == nil then
		-- No longer carrying gun
		return
	end

	PulseText({ ScreenAnchorReference = "GunUI", ScaleTarget = 1.04, ScaleDuration = 0.05, HoldDuration = 0.05, PulseBias = 0.02 })
	if ammoData.Current > 0 then
		ModifyTextBox({ Id = ScreenAnchors.GunUI, Text = "UI_GunText", Color = Color.White, ColorDuration = 0.04 })
	else
		ModifyTextBox({ Id = ScreenAnchors.GunUI, Text = "UI_GunText", Color = Color.Red, ColorDuration = 0.04 })
	end

	ModifyTextBox({ Id = ScreenAnchors.GunUI, Text = "UI_GunText", FadeTarget = 1 })
	if HeroHasTrait( "GunInfiniteAmmoTrait" ) or HeroHasTrait("GunLoadedGrenadeInfiniteAmmoTrait") then
		ModifyTextBox({ Id = ScreenAnchors.GunUI, Text = "UI_Gun_Text_Infinity", OffsetY = -2, LuaKey = "TempTextData", LuaValue = ammoData, AutoSetDataProperties = false, })
	else
		ModifyTextBox({ Id = ScreenAnchors.GunUI, Text = "UI_GunText", OffsetY = -2, LuaKey = "TempTextData", LuaValue = ammoData, AutoSetDataProperties = false, })
	end
	if HeroHasTrait( "GunLoadedGrenadeTrait" ) then
		SetAnimation({ Name = "GunLaserIndicatorIcon", DestinationId = ScreenAnchors.GunUI})
	else
		SetAnimation({ Name = "GunAmmoIndicatorIcon", DestinationId = ScreenAnchors.GunUI})
	end
end

function HideGunUI( forceDestroy )
	if ScreenAnchors.GunUI == nil then
		return
	end

	local id = ScreenAnchors.GunUI
	HideObstacle({ Id = id, IncludeText = true, Distance = CombatUI.FadeDistance.Ammo, Angle = 180, Duration = CombatUI.FadeDuration, SmoothStep = true })


	ScreenAnchors.GunUI = nil

	wait( CombatUI.FadeDuration , RoomThreadName)
	Destroy({ Id = id })
	ModifyTextBox({ Id = id, FadeTarget = 0, FadeDuration = 0, AutoSetDataProperties = false, })
end

function DestroyGunUI()
	if ScreenAnchors.GunUI == nil then
		return
	end
	Destroy({ Id = ScreenAnchors.GunUI })
	ScreenAnchors.GunUI = nil
end

function ResetSuperUI()
end

function ShowSuperMeter()
	if not IsSuperValid() then
		return
	end

	if ScreenAnchors.SuperMeterIcon ~= nil then
		-- Already visible
		return
	end
	ScreenAnchors.SuperMeterIcon = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = 10 - CombatUI.FadeDistance.Super, Y = ScreenHeight - 10})
	ScreenAnchors.SuperMeterCap = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu", X = 10 - CombatUI.FadeDistance.Super, Y = ScreenHeight - 10})
	ScreenAnchors.SuperMeterHint = CreateScreenObstacle({ Name = "BlankObstacle", X = 10 , Y = ScreenHeight - 10, Group = "Combat_Menu_Additive"})

	SetAnimation({ Name = "WrathBar", DestinationId = ScreenAnchors.SuperMeterIcon })

	if HasHeroTraitValue("SuperMeterCap") then
		SetAnimation({ Name = "WrathBarRegenCap", DestinationId = ScreenAnchors.SuperMeterCap })
	end

	local superMeterPoints = CurrentRun.Hero.SuperMeter
	if superMeterPoints == nil then
		superMeterPoints = 0
	end

	if CurrentRun.Hero.SuperMeter == CurrentRun.Hero.SuperMeterLimit and IsSuperAvailable( CurrentRun.Hero ) and CanCommenceSuper() then
		SetAnimation({ Name = "WrathBarFullFx", DestinationId = ScreenAnchors.SuperMeterHint })
	end

	--[[
	CreateTextBox({ Id = ScreenAnchors.SuperMeterIcon, OffsetX = 366 + 8, OffsetY = -15,
			Font = "AlegreyaSansSCBold", FontSize = 24, ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
			OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 1,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0, Justification = "Left" })
	]]--

	ScreenAnchors.SuperPipBackingIds = {}
	ScreenAnchors.SuperPipIds = {}
	local pipXSize = SuperUI.PipXWidth * CurrentRun.Hero.SuperCost/SuperUI.BaseMoveThreshold
	for i = 1, math.ceil(CurrentRun.Hero.SuperMeterLimit / CurrentRun.Hero.SuperCost) do
		table.insert( ScreenAnchors.SuperPipBackingIds, CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = SuperUI.PipXStart + ( i - 1 ) * pipXSize - CombatUI.FadeDistance.Super, Y = SuperUI.PipY}) )
		table.insert( ScreenAnchors.SuperPipIds, CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_Additive", X = SuperUI.PipXStart + ( i - 1 ) * pipXSize - CombatUI.FadeDistance.Super, Y = SuperUI.PipY}) )
		local fillPercent = 0
		if superMeterPoints > (i - 1) * CurrentRun.Hero.SuperCost then
			if CurrentRun.Hero.SuperMeterLimit < CurrentRun.Hero.SuperCost * i and i == math.ceil(CurrentRun.Hero.SuperMeterLimit / CurrentRun.Hero.SuperCost) then
				fillPercent = math.min(1, (superMeterPoints - (i - 1) * CurrentRun.Hero.SuperCost) / ( CurrentRun.Hero.SuperMeterLimit % CurrentRun.Hero.SuperCost ))
			else
				fillPercent = math.min(1, (superMeterPoints - (i - 1) * CurrentRun.Hero.SuperCost) / CurrentRun.Hero.SuperCost )
			end
		end
		UpdateSuperUIComponent(i, fillPercent )
	end

	UpdateSuperMeterUI()

	FadeObstacleIn({ Id = ScreenAnchors.SuperMeterIcon, Duration = CombatUI.FadeInDuration, IncludeText = true, Distance = CombatUI.FadeDistance.Super, Direction = 0 })
	FadeObstacleIn({ Id = ScreenAnchors.SuperMeterCap, Duration = CombatUI.FadeInDuration, IncludeText = true, Distance = CombatUI.FadeDistance.Super, Direction = 0 })
	for i, pipId in pairs(ScreenAnchors.SuperPipIds) do
		FadeObstacleIn({ Id = pipId, Duration = CombatUI.FadeInDuration, IncludeText = false, Distance = CombatUI.FadeDistance.Super, Direction = 0 })
	end
	for i, pipId in pairs(ScreenAnchors.SuperPipBackingIds) do
		FadeObstacleIn({ Id = pipId, Duration = CombatUI.FadeInDuration, IncludeText = false, Distance = CombatUI.FadeDistance.Super, Direction = 0 })
	end
end

function HideSuperMeter()
	if ScreenAnchors.SuperMeterIcon == nil then
		-- Already hidden
		return
	end

	HideObstacle({ Id = ScreenAnchors.SuperMeterIcon, IncludeText = true, Distance = CombatUI.FadeDistance.Super, Angle = 180, Duration = CombatUI.FadeDuration, SmoothStep = true })
	HideObstacle({ Id = ScreenAnchors.SuperMeterCap, IncludeText = true, Distance = CombatUI.FadeDistance.Super, Angle = 180, Duration = CombatUI.FadeDuration, SmoothStep = true })

	for i, pipId in pairs(ScreenAnchors.SuperPipIds) do
		Move({ Id = pipId, Distance = CombatUI.FadeDistance.Super, Angle = 180, Duration = CombatUI.FadeDuration, SmoothStep = true })
		SetAlpha({ Id = pipId, Fraction = 0, Duration = CombatUI.FadeDuration })
	end

	for i, pipId in pairs(ScreenAnchors.SuperPipBackingIds) do
		Move({ Id = pipId, Distance = CombatUI.FadeDistance.Super, Angle = 180, Duration = CombatUI.FadeDuration, SmoothStep = true })
		SetAlpha({ Id = pipId, Fraction = 0, Duration = CombatUI.FadeDuration })
	end

	local ids = CombineTables( ScreenAnchors.SuperPipIds, ScreenAnchors.SuperPipBackingIds ) or {}
	table.insert( ids, ScreenAnchors.SuperMeterIcon )
	table.insert( ids, ScreenAnchors.SuperMeterCap )
	table.insert( ids, ScreenAnchors.SuperMeterHint )


	ScreenAnchors.SuperMeterIcon = nil
	ScreenAnchors.SuperMeterCap = nil
	ScreenAnchors.SuperMeterHint = nil
	ScreenAnchors.SuperPipIds = nil
	ScreenAnchors.SuperPipBackingIds = nil

	wait (CombatUI.FadeDuration, RoomThreadName)

	Destroy({ Ids = ids })
end

function DestroySuperMeter()
	local ids = CombineTables( ScreenAnchors.SuperPipIds, ScreenAnchors.SuperPipBackingIds ) or {}
	table.insert( ids, ScreenAnchors.SuperMeterIcon )
	table.insert( ids, ScreenAnchors.SuperMeterCap )
	table.insert( ids, ScreenAnchors.SuperMeterHint )
	if not IsEmpty( ids ) then
		Destroy({ Ids = ids })
	end
	ScreenAnchors.SuperMeterIcon = nil
	ScreenAnchors.SuperMeterCap = nil
	ScreenAnchors.SuperMeterHint = nil
	ScreenAnchors.SuperPipIds = nil
	ScreenAnchors.SuperPipBackingIds = nil
end

function UpdateSuperUIComponent( index , filled )
	local animationName = "WrathPipEmpty"
	if filled >= 1 then
		animationName = "WrathPipFull"
	elseif filled > 0 then
		animationName = "WrathPipPartial"
	end

	SetAnimation({ Name = "WrathPipEmpty", DestinationId = ScreenAnchors.SuperPipBackingIds[index] })
	SetAnimation({ Name = animationName, DestinationId = ScreenAnchors.SuperPipIds[index] })
	local baseFraction = CurrentRun.Hero.SuperCost/SuperUI.BaseMoveThreshold * 1.0

	if CurrentRun.Hero.SuperMeterLimit < CurrentRun.Hero.SuperCost * index then
		baseFraction = (CurrentRun.Hero.SuperMeterLimit % CurrentRun.Hero.SuperCost) /SuperUI.BaseMoveThreshold * 1.0
	end
	SetScaleX({ Id = ScreenAnchors.SuperPipBackingIds[index], Fraction = baseFraction, Duration = 0})
	SetScaleX({ Id = ScreenAnchors.SuperPipIds[index], Fraction = baseFraction * filled , Duration = 0})
end

function UpdateSuperMeterUI()
	UIScriptsDeferred.SuperMeterDirty = true
end

function UpdateSuperMeterUIReal()
	if ScreenAnchors.SuperMeterIcon == nil then
		return
	end

	local superMeterPoints = CurrentRun.Hero.SuperMeter
	if superMeterPoints == nil then
		superMeterPoints = 0
	end

	for i = 1, TableLength( ScreenAnchors.SuperPipBackingIds) do
		local fillPercent = 0
		if superMeterPoints > (i - 1) * CurrentRun.Hero.SuperCost then
			if CurrentRun.Hero.SuperMeterLimit < CurrentRun.Hero.SuperCost * i and i == math.ceil(CurrentRun.Hero.SuperMeterLimit / CurrentRun.Hero.SuperCost) then
				fillPercent = math.min(1, (superMeterPoints - (i - 1) * CurrentRun.Hero.SuperCost) / ( CurrentRun.Hero.SuperMeterLimit % CurrentRun.Hero.SuperCost ))
			else
				fillPercent = math.min(1, (superMeterPoints - (i - 1) * CurrentRun.Hero.SuperCost) / CurrentRun.Hero.SuperCost )
			end
		end
		UpdateSuperUIComponent(i, fillPercent )
	end
	ModifyTextBox({ Id = ScreenAnchors.SuperMeterIcon, Text = "UI_SuperText", LuaKey = "TempTextData", LuaValue = { Current = math.floor(superMeterPoints), Maximum = CurrentRun.Hero.SuperMeterLimit } })

	UIScriptsDeferred.SuperMeterDirty = false
end

function SuperMeterFeedback( currentRun, full )
	local newValue = currentRun.Hero.SuperMeter
	if full then
		if not SuperMeterFull then
			-- global variable used for meter feedback
			SuperMeterFull = true
			UpdateSuperMeterUI()
			ModifyTextBox({ Id = ScreenAnchors.SuperMeterIcon, ColorTarget = Color.Orange, ColorDuration = 0.25, ScaleTarget = 2.15, ScaleDuration = 0.25 })
			ModifyTextBox({ Id = ScreenAnchors.SuperMeterIcon, ColorTarget = Color.White, ColorDuration = 0.35, ScaleTarget = 1.0, ScaleDuration = 0.35, Delay = 0.25 })
			PlaySound({ Name = "/Leftovers/SFX/FieldReviveSFX", Id = ScreenAnchors.SuperMeterIcon })
			PlaySound({ Name = "/Leftovers/SFX/AuraOff", Id = ScreenAnchors.SuperMeterIcon })
			while currentRun.Hero.SuperMeter == currentRun.Hero.SuperMeterLimit do
				ModifyTextBox({ Id = ScreenAnchors.SuperMeterIcon, ColorTarget = Color.White, ColorDuration = 0.15, ScaleTarget = 1.65, ScaleDuration = 0.15 })
				wait(0.15)
				ModifyTextBox({ Id = ScreenAnchors.SuperMeterIcon, ColorTarget = Color.Orange, ColorDuration = 0.25, ScaleTarget = 1.0, ScaleDuration = 0.25 })
				wait(0.25)
				ModifyTextBox({ Id = ScreenAnchors.SuperMeterIcon, ColorTarget = Color.White, ColorDuration = 1.5, ScaleTarget = 2.0, ScaleDuration = 1.5 })
				wait(0.15)
				ModifyTextBox({ Id = ScreenAnchors.SuperMeterIcon, ColorTarget = Color.Orange, ColorDuration = 0.25, ScaleTarget = 1.0, ScaleDuration = 2.0 })
				wait(2.0)
			end
		end
	else
		UpdateSuperMeterUI()
		if currentRun.Hero.SuperMeter >= ( currentRun.Hero.SuperMeterLimit * 0.75 ) then
			-- nearly full
			ModifyTextBox({ Id = ScreenAnchors.SuperMeterIcon, ColorTarget = Color.Orange, ColorDuration = 0.15, ScaleTarget = 1.65, ScaleDuration = 0.15 })
			ModifyTextBox({ Id = ScreenAnchors.SuperMeterIcon, ColorTarget = Color.White, ColorDuration = 0.35, ScaleTarget = 1.0, ScaleDuration = 0.35, Delay = 0.15 })
		elseif currentRun.Hero.SuperMeter >= ( currentRun.Hero.SuperMeterLimit * 0.25 ) and currentRun.Hero.SuperMeter < ( currentRun.Hero.SuperMeterLimit * 0.75 ) then
			-- half full
			ModifyTextBox({ Id = ScreenAnchors.SuperMeterIcon, ColorTarget = Color.Orange, ColorDuration = 0.15, ScaleTarget = 1.45, ScaleDuration = 0.15 })
			ModifyTextBox({ Id = ScreenAnchors.SuperMeterIcon, ColorTarget = Color.White, ColorDuration = 0.35, ScaleTarget = 1.0, ScaleDuration = 0.35, Delay = 0.15 })
		else
			-- otherwise
			ModifyTextBox({ Id = ScreenAnchors.SuperMeterIcon, ColorTarget = Color.Orange, ColorDuration = 0.15, ScaleTarget = 1.25, ScaleDuration = 0.15 })
			ModifyTextBox({ Id = ScreenAnchors.SuperMeterIcon, ColorTarget = Color.White, ColorDuration = 0.35, ScaleTarget = 1.0, ScaleDuration = 0.35, Delay = 0.15 })
		end
	end
end

function ShowTraitUI()
	if ScreenAnchors.TraitBacking ~= nil then
		-- Already visible
		return
	end

	ScreenAnchors.TraitAnchorIds = {}

	local locationY = TraitUI.StartY
	local obstacleName = "TraitTray_Slots_"..GetTraitTraySize()
	for cosmeticName, status in pairs( GameState.Cosmetics ) do
		local cosmeticData = ConditionalItemData[cosmeticName]
		if cosmeticData ~= nil and cosmeticData.TraitBacking ~= nil then
			obstacleName = cosmeticData.TraitBacking
			break
		end
	end
	ScreenAnchors.TraitBacking = SpawnObstacle({ Name = obstacleName, Group = "Combat_UI_Backing", OffsetX = CombatUI.TraitUIStart - CombatUI.FadeDistance.Trait, OffsetY = locationY })
	FadeObstacleIn({ Id = ScreenAnchors.TraitBacking, Duration = CombatUI.FadeInDuration, Distance = CombatUI.FadeDistance.Trait, Direction = 0 })

	ScreenAnchors.TraitPlaceholderIcons = {}
	ScreenAnchors.TraitPlaceholderFrames = {}

	locationY = TraitUI.IconStartY
	local attackIcon = SpawnObstacle({ Name = "TraitTray_SlotIcon_Attack", Group = "Combat_UI_Backing", OffsetX = TraitUI.IconStartX - CombatUI.FadeDistance.Trait, OffsetY = locationY })
	FadeObstacleIn({ Id = attackIcon, Duration = CombatUI.FadeInDuration, Distance = CombatUI.FadeDistance.Trait, Direction = 0 })
	locationY = locationY + TraitUI.SpacerY
	local secondaryIcon = SpawnObstacle({ Name = "TraitTray_SlotIcon_Secondary", Group = "Combat_UI_Backing", OffsetX = TraitUI.IconStartX - CombatUI.FadeDistance.Trait, OffsetY = locationY })
	FadeObstacleIn({ Id = secondaryIcon, Duration = CombatUI.FadeInDuration, Distance = CombatUI.FadeDistance.Trait, Direction = 0 })
	locationY = locationY + TraitUI.SpacerY
	local rangedIcon = SpawnObstacle({ Name = "TraitTray_SlotIcon_Ranged", Group = "Combat_UI_Backing", OffsetX = TraitUI.IconStartX - CombatUI.FadeDistance.Trait, OffsetY = locationY })
	FadeObstacleIn({ Id = rangedIcon, Duration = CombatUI.FadeInDuration, Distance = CombatUI.FadeDistance.Trait, Direction = 0 })
	locationY = locationY + TraitUI.SpacerY
	local dashIcon = SpawnObstacle({ Name = "TraitTray_SlotIcon_Dash", Group = "Combat_UI_Backing", OffsetX = TraitUI.IconStartX - CombatUI.FadeDistance.Trait, OffsetY = locationY })
	FadeObstacleIn({ Id = dashIcon, Duration = CombatUI.FadeInDuration, Distance = CombatUI.FadeDistance.Trait, Direction = 0 })

	table.insert( ScreenAnchors.TraitPlaceholderIcons, attackIcon )
	table.insert( ScreenAnchors.TraitPlaceholderIcons, secondaryIcon )
	table.insert( ScreenAnchors.TraitPlaceholderIcons, rangedIcon )
	table.insert( ScreenAnchors.TraitPlaceholderIcons, dashIcon )

	if HasUnlockedWrath() then
		locationY = locationY + TraitUI.SpacerY
		local wrathIcon = SpawnObstacle({ Name = "TraitTray_SlotIcon_Wrath", Group = "Combat_UI_Backing", OffsetX = TraitUI.IconStartX - CombatUI.FadeDistance.Trait, OffsetY = locationY })
		FadeObstacleIn({ Id = wrathIcon, Duration = CombatUI.FadeInDuration, Distance = CombatUI.FadeDistance.Trait, Direction = 0 })
		table.insert( ScreenAnchors.TraitPlaceholderIcons, wrathIcon )
	end

	locationY = TraitUI.IconStartY
	for i, icon in pairs(ScreenAnchors.TraitPlaceholderIcons) do
		local frameIcon = SpawnObstacle({ Name = "TraitTray_SlotFrame", Group = "Combat_UI_Backing", OffsetX = TraitUI.IconStartX - CombatUI.FadeDistance.Trait, OffsetY = locationY })
		FadeObstacleIn({ Id = frameIcon, Duration = CombatUI.FadeInDuration, Distance = CombatUI.FadeDistance.Trait, Direction = 0 })
		locationY = locationY + TraitUI.SpacerY
		table.insert( ScreenAnchors.TraitPlaceholderFrames, frameIcon )
	end
	if HasUnlockedKeepsakes() then
		local frameIcon = SpawnObstacle({ Name = "TraitTray_KeepsakeBacking", Group = "Combat_UI_Backing", OffsetX = TraitUI.IconStartX - CombatUI.FadeDistance.Trait, OffsetY = locationY })
		FadeObstacleIn({ Id = frameIcon, Duration = CombatUI.FadeInDuration, Distance = CombatUI.FadeDistance.Trait, Direction = 0 })

		table.insert( ScreenAnchors.TraitPlaceholderFrames, frameIcon )
	end

	local showingTraits = {}

	for index, traitData in pairs (CurrentRun.Hero.Traits) do
		if showingTraits[traitData.Name] == nil or not AreTraitsIdentical(traitData, showingTraits[traitData.Name]) or ( AreTraitsIdentical(traitData, showingTraits[traitData.Name]) and GetRarityValue(showingTraits[traitData.Name].Rarity) < GetRarityValue(traitData.Rarity) ) then
			if not showingTraits[traitData.Name] then
				showingTraits[traitData.Name] = {}
			end
			table.insert( showingTraits[traitData.Name], traitData )
		end
	end

	for traitName, traitDatas in pairs( showingTraits ) do
		for i, traitData in pairs( traitDatas ) do
			TraitUIAdd( traitData, true )
		end
	end


	for k, upgradeName in pairs( CurrentRun.EnemyUpgrades ) do
		local upgradeData = EnemyUpgradeData[upgradeName]
		TraitUIAdd( upgradeData, true )
	end


	local numHidden = GetNumHiddenTraits()
	if numHidden > 0 then
		UpdateAdditionalTraitHint( numHidden )
		FadeObstacleIn({ Id = ScreenAnchors.AdditionalTraitHint, Duration = CombatUI.FadeInDuration, Distance = CombatUI.FadeDistance.Trait, Direction = 0 })
	end

	TraitUIActivateTraits()
end

function UpdateAdditionalTraitHint( numHidden )
	numHidden = numHidden or GetNumHiddenTraits()
	if ScreenAnchors.AdditionalTraitHint == nil and CurrentRun.Hero.RecentTraits ~= nil and ScreenAnchors.TraitBacking then
		local frameIcon = CreateScreenObstacle({ Name = "TraitTray_EmptyBacking", Group = "Combat_UI_Backing",
			X = 6 + CombatUI.TraitUIStart - CombatUI.FadeDistance.Trait + 0.5 * TraitUI.SpacerX,
			Y = TraitUI.StartY + TraitUI.SpacerY * (-2 + TableLength(CurrentRun.Hero.RecentTraits))})
		CreateTextBox({ Id = frameIcon, Text = "+"..numHidden, FontSize = 30, Color = Color.White, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })
		ScreenAnchors.AdditionalTraitHint = frameIcon
	elseif ScreenAnchors.AdditionalTraitHint then
		Teleport({ Id = ScreenAnchors.AdditionalTraitHint, OffsetX = 6 + CombatUI.TraitUIStart - CombatUI.FadeDistance.Trait + 0.5 * TraitUI.SpacerX, OffsetY = TraitUI.StartY + TraitUI.SpacerY * (-2 + TableLength(CurrentRun.Hero.RecentTraits))})
		ModifyTextBox({ Id = ScreenAnchors.AdditionalTraitHint , Text = "+"..numHidden })
	end
end

function IsExistingTraitShown( trait )
	local searchTable = CurrentRun.Hero.Traits
	if CurrentRun.Hero.TraitDictionary then
		searchTable = CurrentRun.Hero.TraitDictionary[trait.Name]
	end
	if not searchTable then
		return false
	end

	for k, existingTrait in pairs( searchTable ) do
		if existingTrait.AnchorId ~= nil and AreTraitsIdentical(trait, existingTrait) then
			return true
		end
	end
	return false
end

function GetExistingUITraitName( traitName )
	for k, existingTrait in pairs( CurrentRun.Hero.Traits ) do
		if existingTrait.Name == traitName and existingTrait.AnchorId ~= nil then
			return existingTrait
		end
	end
	return nil
end

function GetExistingUITrait( trait )
	if not trait then
		return nil
	end
	local searchTable = CurrentRun.Hero.Traits
	if CurrentRun.Hero.TraitDictionary then
		searchTable = CurrentRun.Hero.TraitDictionary[trait.Name]
	end
	if not searchTable then
		return nil
	end

	for k, existingTrait in pairs( searchTable ) do
		if AreTraitsIdentical(trait, existingTrait) then
			if existingTrait.AnchorId ~= nil then
				return existingTrait
			end
		end
	end
	return nil
end

function UpdateTraitNumber( trait )
	local existingTraitData = GetExistingUITrait( trait )
	if existingTraitData ~= nil then
		DestroyTextBox({ Id = existingTraitData.AnchorId })
		TraitUICreateText( existingTraitData )
		if GetRarityValue( existingTraitData.Rarity ) < GetRarityValue ( trait.Rarity ) then
			Destroy({ Id = existingTraitData.TraitIconOverlay })
			local traitFrameId = CreateScreenObstacle({ Name = "BaseBoonFrame", Group = "Combat_UI"  })
			Attach({ Id = traitFrameId, DestinationId = existingTraitData.AnchorId })
			if trait.Frame ~= nil then
				SetAnimation({ Name = "BoonIcon_Frame_"..trait.Frame, DestinationId = traitFrameId })
			elseif trait.Rarity ~= nil then
				SetAnimation({ Name = "BoonIcon_Frame_"..trait.Rarity, DestinationId = traitFrameId })
			else
				SetAnimation({ Name = "BoonIcon_Frame_Common", DestinationId = traitFrameId })
			end
			existingTraitData.TraitIconOverlay = traitFrameId

		end
	end
end

function TraitUICreateText( trait, layer )
	if not trait.AnchorId or not IdExists({ Id = trait.AnchorId }) then
		return
	end
	local xOffset = 0
	local yOffset = 0
	local traitCount = GetTraitCount(CurrentRun.Hero, trait)
	local time = trait.RemainingUses or trait.Uses
	local hasSubtitle = ( time ~= nil and time > 0 ) or ( traitCount > 1) or ( trait.Slot == "Keepsake" ) or ( trait.Slot == "Assist" )
	layer = layer or "Combat_UI"
	if not hasSubtitle then
		return
	end

	if trait.TraitInfoCardId then
		Destroy({ Id = trait.TraitInfoCardId })
		trait.TraitInfoCardId = nil
	end
	trait.TraitInfoCardId = CreateScreenObstacle({ Name = "TraitTray_LevelBacking", Group = layer})
	Attach({ Id = trait.TraitInfoCardId, DestinationId = trait.AnchorId, OffsetY = 32 })

	if trait.Slot == "Keepsake" or trait.Slot == "Assist" then
		SetAnimation({ DestinationId = trait.TraitInfoCardId, Name = "KeepsakeRank" .. GetKeepsakeLevel( trait.Name ), Scale = 1.25 })
		yOffset = yOffset + 15
	end

	if time ~= nil and time > 0 then
		if ( trait.UsesAsRooms and trait.RemainingUses ~= nil ) then
			CreateTextBox({ Id = trait.TraitInfoCardId, Text = "UI_Time", Font = "AlegreyaSansSCBold", Color = Color.White, ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2}, FontSize = 18, OffsetX = xOffset, OffsetY = yOffset, Justification = "Center", LuaKey = "TempTextData", LuaValue = { Time = math.floor(time)} })
			xOffset = xOffset + 40
		elseif ( trait.RemainingUses ~= nil or trait.Uses ~= nil ) and not trait.UsesAsRooms then
			if traitCount > 1 then
				time = 0
				for i, ownedTrait in pairs(CurrentRun.Hero.Traits) do
					if ownedTrait.Name == trait.Name then
						if ownedTrait.RemainingUses then
							time = time + ownedTrait.RemainingUses
						elseif ownedTrait.Uses then
							time = time + ownedTrait.Uses
						end
					end
				end
			end

			CreateTextBox({ Id = trait.TraitInfoCardId, Text = "UI_Uses", Font = "AlegreyaSansSCBold", Color = Color.White, ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2}, FontSize = 18, OffsetX = xOffset, OffsetY = yOffset, Justification = "Center", LuaKey = "TempTextData", LuaValue = { Time = math.floor(time)} })
			xOffset = xOffset + 40
		end
	elseif trait.RoomsPerUpgrade and trait.CurrentRoom then
		local countdown = trait.RoomsPerUpgrade - trait.CurrentRoom
		CreateTextBox({ Id = trait.TraitInfoCardId, Text = "UI_Time", Font = "AlegreyaSansSCBold", Color = Color.White, ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2}, FontSize = 18, OffsetX = xOffset, OffsetY = yOffset, Justification = "Center", LuaKey = "TempTextData", LuaValue = { Time = math.floor(countdown)} })
	elseif trait.BossEncounterShieldHits and CurrentRun.Hero.HitShields and CurrentRun.Hero.HitShields > 0 then
		-- TODO: make this generic. let it be a key on the traitdata or something @alice
		CreateTextBox({ Id = trait.TraitInfoCardId, Text = "UI_Uses", Font = "AlegreyaSansSCBold", Color = Color.White, ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2}, FontSize = 18, OffsetX = xOffset, OffsetY = yOffset, Justification = "Center", LuaKey = "TempTextData", LuaValue = { Time = math.floor(CurrentRun.Hero.HitShields)} })
	elseif traitCount > 1 then
		CreateTextBox({ Id = trait.TraitInfoCardId, Text = "UI_TraitLevel", Font = "AlegreyaSansSCBold", Color = Color.White, ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2}, FontSize = 16, OffsetX = xOffset, OffsetY = 0 , Justification = "Center", LuaKey = "TempTextData", LuaValue = { Amount = traitCount } })
		xOffset = xOffset + 45
	end

	ModifyTextBox({ Id = trait.TraitInfoCardId, FadeTarget = 1, FadeDuration = 0.0 })
	local traitName = trait.Name
	if not IsTraitActive( trait ) then
		traitName = trait.Name .. "_Inactive"
	end
end

function TraitUIActivateTraits()
	if not CurrentRun or not CurrentRun.Hero then
		return
	end

	for i, traitData in pairs(CurrentRun.Hero.Traits) do
		local thresholdData = traitData.LowHealthThresholdText
		if thresholdData ~= nil and ( CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth ) < thresholdData.Threshold then
			TraitUIActivateTrait( traitData )
		end

		if not CurrentRun.CurrentRoom.BlockClearRewards then
			local currentRoom = CurrentRun.CurrentRoom
			local perfectClearDamageData = traitData.PerfectClearDamageBonus
			if not CurrentRun.Hero.IsDead and perfectClearDamageData ~= nil then
				if currentRoom and currentRoom.Encounter ~= nil and currentRoom.Encounter.EncounterType ~= "NonCombat" and not currentRoom.Encounter.Completed and not currentRoom.Encounter.PlayerTookDamage then
					TraitUIActivateTrait( traitData )
				end
			end
			local fastClearData = traitData.FastClearSpeedBonus
			if fastClearData ~= nil then
				if not CurrentRun.Hero.IsDead and currentRoom and currentRoom.Encounter ~= nil and currentRoom.Encounter.StartTime and currentRoom.Encounter.EncounterType ~= "NonCombat" and not currentRoom.Encounter.Completed then
					local currentEncounter = currentRoom.Encounter
					local elapsedTime = _worldTime - currentEncounter.StartTime
					local clearTimeThreshold = currentEncounter.FastClearThreshold or traitData.FastClearThreshold
					TraitUIActivateTrait( traitData, { CustomAnimation = "ActiveTraitSingle", PlaySpeed = 30 / clearTimeThreshold })
					local existingTraitData = GetExistingUITrait( traitData )
					SetAnimation({ Name = "ActiveTraitSingle", StartFrameFraction = 1 - elapsedTime/clearTimeThreshold, DestinationId = existingTraitData.TraitActiveOverlay })
				end
			end
		end
	end
end

function TraitUIActivateTrait( trait, args )
	args = args or {}
	local customAnimation = args.CustomAnimation or "ActiveTrait"
	local groupName = args.GroupName or "Combat_UI"
	local playSpeed = args.PlaySpeed
	local existingTraitData = GetExistingUITrait( trait )
	if existingTraitData ~= nil and existingTraitData.TraitActiveOverlay == nil then
		local traitFrameId = CreateScreenObstacle({ Name = "BlankObstacle", Group = groupName })
		SetAnimation({ Name = customAnimation, DestinationId = traitFrameId, PlaySpeed = playSpeed })
		Attach({ Id = traitFrameId, DestinationId = existingTraitData.AnchorId })
		existingTraitData.TraitActiveOverlay = traitFrameId
	end
end

function TraitUIDeactivateTrait( trait )
	local existingTraitData = GetExistingUITrait( trait )
	if existingTraitData ~= nil and existingTraitData.TraitActiveOverlay ~= nil then
		Destroy({ Id = existingTraitData.TraitActiveOverlay })
		existingTraitData.TraitActiveOverlay = nil
	end
end

function TraitUICreateComponent( trait, useFade )
	local offsetX = 0
	if useFade then
		offsetX = CombatUI.FadeDistance.Trait
	end
	ScreenAnchors.TraitAnchorIds = ScreenAnchors.TraitAnchorIds or {}

	local offsetX = CombatUI.TraitUIStart - offsetX
	local offsetY = TraitUI.IconStartY + GetTraitIndex(trait) * TraitUI.SpacerY
	if trait.Slot == nil then
		offsetX = 8 + offsetX + TraitUI.SpacerX * 0.5
		offsetY = offsetY - TraitUI.SpacerY * 0.5
	end

	trait.AnchorId = CreateScreenObstacle({ Name = "BaseBoonIcon", X = offsetX, Y = offsetY, Group = "Combat_UI" })

	TraitUICreateText( trait )
	SetAnimation({ Name = GetTraitIcon(trait), DestinationId = trait.AnchorId })
	local traitFrameId = CreateScreenObstacle({ Name = "BaseBoonFrame", Group = "Combat_UI"  })

	Attach({ Id = traitFrameId, DestinationId = trait.AnchorId })

	if trait.Frame ~= nil then
		SetAnimation({ Name = "BoonIcon_Frame_"..trait.Frame, DestinationId = traitFrameId })
	elseif trait.Rarity ~= nil then
		SetAnimation({ Name = "BoonIcon_Frame_"..trait.Rarity, DestinationId = traitFrameId })
	else
		SetAnimation({ Name = "BoonIcon_Frame_Common", DestinationId = traitFrameId })
	end
	trait.TraitIconOverlay = traitFrameId

	AttachLua({ Id = trait.AnchorId, Table = trait })
	table.insert( ScreenAnchors.TraitAnchorIds, trait.AnchorId )
end

function TraitUIUpdateText( trait )
	if trait.AnchorId then
		DestroyTextBox({ Id = trait.AnchorId })
		TraitUICreateText( trait )
	end
end

function GetTraitIcon( trait, getLarge )
	getLarge = getLarge or false
	if trait.Icon ~= nil then
		if getLarge then
			if trait.LargeIconOverride then
				return trait.Icon
			elseif trait.Slot == "Keepsake" or trait.Slot == "Assist" then
				return trait.Icon
			else
				return trait.Icon.."_Large"
			end
		else
			return trait.Icon.."_Small"
		end
	end
	if trait.Slot ~= nil then
		if trait.Slot == "Melee" then
			return "BoonIconMelee"
		elseif trait.Slot == "Ranged" then
			return "BoonIconRanged"
		elseif trait.Slot == "Rush" then
			return "BoonIconDash"
		elseif trait.Slot == "Shout" then
			return "BoonIconWrath"
		else
			return "BoonIconBlessing"
		end
	end

	return "BoonIconBlessing"
end

function GetTraitFrame( trait )
	if trait.Frame ~= nil then
		return "BoonIcon_Frame_"..trait.Frame
	elseif trait.Rarity ~= nil then
		return "BoonIcon_Frame_"..trait.Rarity
	else
		return"BoonIcon_Frame_Common"
	end
end

function GetTraitTooltip( trait, args )
	args = args or {}
	if trait.OnExpire ~= nil and trait.OnExpire.TraitData ~= nil then
		return "ChaosBlessingFormat"
	end

	if trait.TraitDependencyTextOverrides then
		for traitName, traitDependencyData in pairs( trait.TraitDependencyTextOverrides ) do
			if HeroHasTrait( traitName ) then
				args.CheckingOverrides = true
				return GetTraitTooltip( traitDependencyData, args )
			end
		end
	end

	if CurrentRun.Hero.IsDead and trait.CustomNameWhileDead then
		return trait.CustomNameWhileDead
	elseif CurrentRun.Hero.IsDead and args.ForTraitTray and trait.CustomTrayNameWhileDead then
		return trait.CustomTrayNameWhileDead
		
	elseif args.ForTraitTray and trait.CustomTrayNameWithMetaUpgrade and GetNumMetaUpgrades( trait.CustomTrayNameWithMetaUpgrade.MetaUpgradeName ) > 0 then
		return trait.CustomTrayNameWithMetaUpgrade.Name
	elseif trait.CustomNameWithMetaUpgrade and GetNumMetaUpgrades( trait.CustomNameWithMetaUpgrade.MetaUpgradeName ) > 0 then
		return trait.CustomNameWithMetaUpgrade.Name
	elseif args.UnequippedKeepsakePreview and trait.UnequippedKeepsakeTitle then
		return trait.UnequippedKeepsakeTitle
	elseif args.InKeepsakePreview and trait.InRackTitle then
		return trait.InRackTitle
	elseif args.ForTraitTray and trait.CustomTrayText then
		return trait.CustomTrayText
	elseif trait.CustomName then
		return trait.CustomName
	elseif not args.CheckingOverrides and not IsTraitActive( trait ) then
		return trait.Name .. "_Inactive"
	elseif args.Initial and HasDisplayName({ Text = trait.Name.."_Initial"  }) then
		return trait.Name.."_Initial"
	elseif args.Default then
		return args.Default
	end
	return trait.Name

end

function GetTraitTooltipTitle( trait )

	if trait.TraitDependencyTextOverrides and not trait.ForBoonInfo then
		for traitName, traitDependencyData in pairs( trait.TraitDependencyTextOverrides ) do
			if HeroHasTrait( traitName ) then
				return GetTraitTooltipTitle( traitDependencyData )
			end
		end
	end
	if CurrentRun.Hero.IsDead and trait.CustomNameWhileDead then
		return trait.CustomNameWhileDead
	elseif trait.CustomTitle then
		return trait.CustomTitle
	else
		if trait.OnExpire ~= nil and trait.OnExpire.TraitData ~= nil then
			return GetDisplayName({ Text = "ChaosCombo_"..trait.Name.."_"..trait.OnExpire.TraitData.Name })
		elseif trait.LastCurseName and trait.LastBlessingName then
			return GetDisplayName({ Text = "ChaosCombo_"..trait.LastCurseName.."_"..trait.LastBlessingName })
		else
			return trait.Name
		end
	end
end

function GetGodPipIcon( godName )
	return "BoonIcon"..godName
end

function TraitUIRemove( trait )
	if trait == nil then
		return
	end

	if trait.TraitIconOverlay ~= nil then
		Destroy({ Id = trait.TraitIconOverlay })
		trait.TraitIconOverlay = nil
	end
	if trait.TraitActiveOverlay ~= nil then
		Destroy({ Id = trait.TraitActiveOverlay })
		trait.TraitActiveOverlay = nil
	end

	if trait.AnchorId ~= nil then
		Destroy({ Id = trait.AnchorId })
		trait.AnchorId = nil
	end
	if trait.TraitInfoCardId ~= nil then
		Destroy({ Id = trait.TraitInfoCardId })
		trait.TraitInfoCardId = nil
	end
	RemoveValueAndCollapse( ScreenAnchors.TraitAnchorIds, trait.AnchorId )
end

function HideTraitUI()
	if ScreenAnchors.TraitBacking == nil or CombatUI.ShowingTraitDescription then
		return
	end
	-- save ids for later disposal
	local ids = {}
	for k, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.TraitIconOverlay ~= nil then
			table.insert( ids, trait.TraitIconOverlay )
		end
		if trait.TraitActiveOverlay ~= nil then
			table.insert( ids, trait.TraitActiveOverlay )
		end
		if trait.TraitInfoCardId ~= nil then
			table.insert( ids, trait.TraitInfoCardId )
		end
	end
	ids = CombineTables( ids, ScreenAnchors.TraitAnchorIds )
	ids = CombineTables( ids, ScreenAnchors.TraitPlaceholderIcons )
	ids = CombineTables( ids, ScreenAnchors.TraitPlaceholderFrames )
	table.insert( ids, ScreenAnchors.TraitBacking )
	table.insert( ids, ScreenAnchors.AdditionalTraitHint )

	for k, trait in pairs( CurrentRun.Hero.Traits ) do
		if trait.AnchorId ~= nil then
			HideObstacle({ Id = trait.AnchorId, IncludeText = true, Distance = CombatUI.FadeDistance.Trait, Angle = 180, Duration = CombatUI.TraitFadeDuration, SmoothStep = true })

		end
		if trait.TraitIconOverlay ~= nil then
			SetAlpha({ Id = trait.TraitIconOverlay, Fraction = 0, Duration = CombatUI.TraitFadeDuration })
		end
		if trait.TraitInfoCardId ~= nil then
			HideObstacle({ Id = trait.TraitInfoCardId, IncludeText = true, Distance = CombatUI.FadeDistance.Trait, Angle = 180, Duration = CombatUI.TraitFadeDuration, SmoothStep = true })
		end
	end

	HideObstacle({ Id = ScreenAnchors.TraitBacking, IncludeText = true, Distance = CombatUI.FadeDistance.Trait, Angle = 180, Duration = CombatUI.TraitFadeDuration, SmoothStep = true })
	HideObstacle({ Id = ScreenAnchors.AdditionalTraitHint, IncludeText = true, Distance = CombatUI.FadeDistance.Trait, Angle = 180, Duration = CombatUI.TraitFadeDuration, SmoothStep = true })
	HideObstacle({ Ids = ScreenAnchors.TraitPlaceholderIcons, Distance = CombatUI.FadeDistance.Trait, Angle = 180, Duration = CombatUI.TraitFadeDuration, SmoothStep = true })
	HideObstacle({ Ids = ScreenAnchors.TraitPlaceholderFrames, Distance = CombatUI.FadeDistance.Trait, Angle = 180, Duration = CombatUI.TraitFadeDuration, SmoothStep = true })

	for k, trait in pairs( CurrentRun.Hero.Traits ) do
		trait.AnchorId = nil
		trait.TraitIconOverlay = nil
		trait.TraitActiveOverlay = nil
		trait.TraitInfoCardId = nil
	end

	ScreenAnchors.TraitAnchorIds = nil
	ScreenAnchors.TraitPlaceholderIcons = nil
	ScreenAnchors.TraitPlaceholderFrames = nil
	ScreenAnchors.TraitBacking = nil
	ScreenAnchors.AdditionalTraitHint = nil

	wait( CombatUI.TraitFadeDuration, RoomThreadName )
	Destroy({ Ids = ids })
end

function DestroyTraitUI()
	for k, trait in pairs( CurrentRun.Hero.Traits ) do
		trait.AnchorId = nil
		if trait.TraitIconOverlay ~= nil then
			Destroy({Id = trait.TraitIconOverlay})
			trait.TraitIconOverlay = nil
		end
		if trait.TraitActiveOverlay ~= nil then
			Destroy({Id = trait.TraitActiveOverlay })
			trait.TraitActiveOverlay = nil
		end
		if trait.TraitInfoCardId ~= nil then
			Destroy({ Id = trait.TraitInfoCardId })
			trait.TraitInfoCardId = nil
		end
	end

	if ScreenAnchors.TraitAnchorIds ~= nil and not IsEmpty( ScreenAnchors.TraitAnchorIds ) then
		Destroy({ Ids = ScreenAnchors.TraitAnchorIds })
		ScreenAnchors.TraitAnchorIds = nil
	end
	if ScreenAnchors.TraitPlaceholderIcons ~= nil then
		Destroy({ Ids = ScreenAnchors.TraitPlaceholderIcons })
		ScreenAnchors.TraitPlaceholderIcons = nil
	end
	if ScreenAnchors.TraitPlaceholderFrames ~= nil then
		Destroy({ Ids = ScreenAnchors.TraitPlaceholderFrames })
		ScreenAnchors.TraitPlaceholderFrames = nil
	end

	if ScreenAnchors.TraitBacking ~= nil then
		Destroy({ Id = ScreenAnchors.TraitBacking })
		ScreenAnchors.TraitBacking = nil
	end

	if ScreenAnchors.AdditionalTraitHint ~= nil then
		Destroy({ Id = ScreenAnchors.AdditionalTraitHint })
		ScreenAnchors.AdditionalTraitHint = nil
	end
end

function ShowInterMapComponents()
	DoBiomePresentation()
end

function CheckHintsEligible()
	local currentRoom = CurrentRun.CurrentRoom

	if currentRoom.LoadHints == nil then
		return false
	end

	if IsEmpty( currentRoom.LoadHints ) then
		return false
	end

	if currentRoom.BlockLoadHints then
		return false
	end

	if CurrentRun.Hero.IsDead then
		return false
	end

	local eligibleHints = 0
	for k, hintName in pairs(currentRoom.LoadHints) do
		if not Contains(GameState.HintsShown, hintName) then
			eligibleHints = eligibleHints + 1
		end
	end
	if eligibleHints == 0 then
		return false
	end

	return true
end

function HideObjectiveLog()

	if IsEmpty( ActiveObjectives ) then
		return
	end

	objectiveLogVisible = false

	for objectiveName, activeObjective in pairs( ActiveObjectives ) do
		ModifyTextBox({ Id = activeObjective.AnchorId, FadeTarget = 0.35 })
		StopAnimation({ DestinationId = activeObjective.AnchorId })
	end
end

function ShowObjectiveLog()

	if IsEmpty( ActiveObjectives ) then
		return
	end

	if objectiveLogVisible then
		return
	end

	objectiveLogVisible = true

	for objectiveName, activeObjective in pairs( ActiveObjectives ) do
		ModifyTextBox({ Id = activeObjective.AnchorId, FadeTarget = 1.0 })
		DisplayObjectiveBacking( activeObjective.AnchorId )
	end

	if ProppedObjectiveQueue ~= nil then
		for objectiveName, v in pairs( ProppedObjectiveQueue ) do
			wait(0.3)
			DisplayObjective( objectiveName )
			wait(0.3)
		end
	end
	ProppedObjectiveQueue = { }

	if CompletedObjectiveQueue ~= nil then
		for objectiveName, v in pairs( CompletedObjectiveQueue ) do
			wait(0.3)
			MarkObjectiveComplete( objectiveName )
			wait(0.3)
		end
	end
	CompletedObjectiveQueue = { }
end



function ShowRunIntro()

	-- skip this except for every fourth run since the last remembrance, starting after Flashback
	local completedRuns = GetCompletedRuns()
	if completedRuns > 0 and not TextLinesRecord["Flashback_Mother_01"] then
		return
	end
	if GameState.LastRemembranceCompletedRunCount ~= nil then
		if completedRuns - GameState.LastRemembranceCompletedRunCount < 4 then
			return
		end
	else
		-- proceed
	end

	local currentRun = CurrentRun
	local eligibleRunIntroData = {}
	local eligibleUnplayedRunIntroData = {}
	for index, entryData in pairs( RunIntroData ) do
		if IsGameStateEligible( currentRun, entryData ) then
			table.insert( eligibleRunIntroData, entryData )
			if not GameState.PlayedRandomRunIntroData[entryData.Header] then
				table.insert( eligibleUnplayedRunIntroData, entryData )
			end
		end
	end

	if IsEmpty( eligibleRunIntroData ) then
		return
	end

	AddTimerBlock( currentRun, "RunIntro" )

	local runIntroData = nil
	if IsEmpty( eligibleUnplayedRunIntroData ) then
		-- All played, start the record over
		for index, entryData in pairs( RunIntroData ) do
			GameState.PlayedRandomRunIntroData[entryData.Header] = nil
		end
		runIntroData = GetRandomValue( eligibleRunIntroData )
	else
		runIntroData = GetRandomValue( eligibleUnplayedRunIntroData )
	end
	GameState.PlayedRandomRunIntroData[runIntroData.Header] = true

	RunInterstitialPresentation( runIntroData )
	GameState.LastRemembranceCompletedRunCount = completedRuns

	RemoveTimerBlock( currentRun, "RunIntro" )

end

function ClearHealthShroud()
	if ScreenAnchors.HealthShroudAnchor == nil then
		return
	end
	Destroy({ Id = ScreenAnchors.HealthShroudAnchor })
	ScreenAnchors.HealthShroudAnchor = nil
end

function CreateHealthShroud()
	if ScreenAnchors.HealthShroudAnchor ~= nil then
		return
	end
	ScreenAnchors.HealthShroudAnchor = CreateScreenObstacle({Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_UI_World" })
	SetAnimation({ DestinationId = ScreenAnchors.HealthShroudAnchor, Name = "LowHealthShroud"})
end

function DestroyHealthShroud()
	if ScreenAnchors.HealthShroudAnchor == nil then
		return
	end
	Destroy({ Id = ScreenAnchors.HealthShroudAnchor })
	ScreenAnchors.HealthShroudAnchor = nil
end

OnActiveUseTarget{
	function( triggerArgs )
		if triggerArgs.AutoActivate then
			return
		end
		ShowUseButton( triggerArgs.triggeredById, triggerArgs.AttachedTable )
	end
}

OnActiveUseTargetLost{
	function( triggerArgs )
		if triggerArgs.AutoActivate then
			return
		end
		HideUseButton( triggerArgs.triggeredById, triggerArgs.AttachedTable )
	end
}

function GetUseText( useTarget )

	if useTarget == nil then
		return ConstantsData.DefaultUseText
	end

	local useText = useTarget.UseText or ConstantsData.DefaultUseText
	if useTarget.AddAmmo ~= nil and useTarget.AddAmmo > 0 and IsWeaponAmmoFull({ Id = CurrentRun.Hero.ObjectId, WeaponName = "RangedWeapon" }) and useTarget.UseTextFull ~= nil then
		useText = useTarget.UseTextFull
	end

	if useTarget.UnlockedUseText ~= nil and OfferedExitDoors[useTarget.ObjectId] ~= nil then
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) and CheckSpecialDoorRequirement( useTarget ) == nil then
			if useTarget.RerollFunctionName ~= nil and CurrentRun.NumRerolls > 0 and IsMetaUpgradeSelected( "RerollMetaUpgrade" ) then
				if useTarget.CanBeRerolled then
					useText = useTarget.UnlockedUseTextReroll
				else
					useText = useTarget.UnlockedUseTextCannotReroll
				end
			else
				useText = useTarget.UnlockedUseText
			end
		end
	end

	if useTarget.FishUnlockedUseText ~= nil then
		if IsCombatEncounterActive( CurrentRun ) then
			useText = useTarget.UseText
		else
			useText = useTarget.FishUnlockedUseText
		end
	end

	if useTarget.LockedUseText ~= nil and OfferedExitDoors[useTarget.ObjectId] ~= nil then
		if CheckRoomExitsReady( CurrentRun.CurrentRoom ) and CheckSpecialDoorRequirement( useTarget ) ~= nil then
			useText = useTarget.LockedUseText
		end
	end
	
	if useTarget.CanReceiveGift then
		local canTalk = false
		local canGift = false
		if  useTarget.AlwaysShowDefaultUseText or useTarget.NextInteractLines ~= nil then
			canTalk = true
		end
		local genusName = GetGenusName( useTarget )
		if HasResource( GetNextGiftResource( genusName ), GetNextGiftResourceQuantity( genusName )) and CanReceiveGift( useTarget ) then
			canGift = true
		end

		if canTalk then
			if useTarget.InteractText then
				return useTarget.InteractText
			else
				return "NPCInteractText"
			end
		elseif canGift and CanReceiveGift( useTarget ) and ( HasResource( GetNextGiftResource( genusName ), GetNextGiftResourceQuantity( genusName )) or useTarget.GiftText )then
			if useTarget.GiftText then
				if type( useTarget.GiftText ) == "table" then
					return useTarget.GiftText[ GetNextGiftResource( genusName )]
				else
					return useTarget.GiftText
				end
			else
				return GiftIconData[ GetNextGiftResource( genusName ) ].GiftText
			end
		elseif useTarget.AssistInteractText then
			return useTarget.AssistInteractText
		end
	end

	if useTarget.ShrineUseText ~= nil and ( GetNumRunsCleared() > 0 or GameState.Flags.HardMode ) then
 		useText = useTarget.ShrineUseText
	end

	if useTarget.Cost and useTarget.CannotPurchaseUseText and useTarget.PurchaseRequirements and not IsGameStateEligible(CurrentRun, useTarget, useTarget.PurchaseRequirements) then
		useText = useTarget.CannotPurchaseUseText
	end

	if useTarget.AssistInteractText and useTarget.InPartnerConversation then
		if  useTarget.AlwaysShowDefaultUseText or useTarget.NextInteractLines ~= nil then
			if useTarget.InteractText then
				return useTarget.InteractText
			else
				return "NPCInteractText"
			end
		end
			
		return useTarget.AssistInteractText
	end
	return useText

end

function GetUseData( useTarget )

	if useTarget.CanReceiveGift then
		local data = {}

		if  useTarget.AlwaysShowDefaultUseText or useTarget.NextInteractLines ~= nil then
			data.BaseUseText = useTarget.UseText
		else
			data.BaseUseText = "Blank"
		end

		local genusName = GetGenusName( useTarget)
		local canGift = false
		if HasResource( GetNextGiftResource( genusName ), GetNextGiftResourceQuantity( genusName )) and CanReceiveGift( useTarget ) then
			if useTarget.GiftText then
				if type( useTarget.GiftText ) == "table" then
					data.GiftAvailable = useTarget.GiftText[ GetNextGiftResource( genusName )]
				else
					data.GiftAvailable = useTarget.GiftText
				end
			else
				data.GiftAvailable = GiftIconData[ GetNextGiftResource( genusName ) ].GiftText
			end
			data.GiftResourceAmount = GetNextGiftResourceQuantity( genusName )
			canGift = true
		elseif useTarget.AssistInteractText then
			data.GiftAvailable = useTarget.AssistInteractText
		else
			data.GiftAvailable = "Blank"
		end

		if useTarget.AssistInteractText then
			-- Collapses the use text upwards into unused line variables
			if data.BaseUseText ~= "Blank" and canGift then
				data.GiftAvailable = GiftIconData[ GetNextGiftResource( genusName ) ].GiftText
			end
			if data.GiftAvailable ~= useTarget.AssistInteractText then
				data.AssistText = useTarget.AssistInteractText
			else
				data.AssistText = "Blank"
			end
		end
		return data
	end

	if useTarget.AssistInteractText and useTarget.InPartnerConversation then
		local data = {}
		if  useTarget.AlwaysShowDefaultUseText or useTarget.NextInteractLines ~= nil then
			data.BaseUseText = useTarget.UseText
			data.GiftAvailable = useTarget.AssistInteractText
			data.AssistText = "Blank"
		end
		return data
	end

	if useTarget.RefreshExtractValuesOnApproach then
		ExtractValues( CurrentRun.Hero, useTarget, useTarget)
	end
	return useTarget

end

function ShowUseButton( objectId, useTarget )

	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	if ScreenAnchors.UsePrompts == nil then
		ScreenAnchors.UsePrompts = {}
	end

	if useTarget == nil then
		return
	end
	if useTarget.UnuseableWhenDead and useTarget.IsDead then
		return
	end

	if useTarget.OnUsedGameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, useTarget, useTarget.OnUsedGameStateRequirements ) then
		return
	end

	if ScreenAnchors.UsePrompts[objectId] ~= nil then
		return
	end
	if not IsEmpty( ActiveScreens ) then
		return
	end

	if not IsAlive({ Id = objectId }) then
		return
	end

	local useData = GetUseData( useTarget )
	local useText = GetUseText( useTarget, useData )

	local offset = {}
	offset.X = useTarget.UsePromptOffsetX or 0
	offset.Y = useTarget.UsePromptOffsetY or 0
	ScreenAnchors.UsePrompts[objectId] = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu", X = UIData.UsePrompt.X, Y = UIData.UsePrompt.Y })
	if UIData.UsePrompt.AttractAnim ~= nil then
		SetAnimation({ Name = UIData.UsePrompt.AttractAnim, DestinationId = ScreenAnchors.UsePrompts[objectId], OffsetX = 0, OffsetY = 0 })
	end
	if UIData.UsePrompt.AttractFlash ~= nil then
		UIData.UsePrompt.AttractFlash.Ids = useTarget.AdditionalAttractIds or {}
		table.insert( UIData.UsePrompt.AttractFlash.Ids, objectId  )
		Flash( UIData.UsePrompt.AttractFlash )
	end

	local textBox = ShallowCopyTable( UIData.UsePrompt.TextFormat )

	textBox.Id = ScreenAnchors.UsePrompts[objectId]
	textBox.Text = useText
	textBox.LuaKey = "TempTextData"
	textBox.LuaValue = useData
	textBox.AutoSetDataProperties = false
	textBox.OffsetY = -80
	CreateTextBox( textBox )

end

function HideUseButton( objectId, useTarget, fadeDuration )

	if ScreenAnchors.UsePrompts == nil then
		return
	end

	if ScreenAnchors.UsePrompts[objectId] == nil then
		return
	end

	local anchorId = ScreenAnchors.UsePrompts[objectId]
	ScreenAnchors.UsePrompts[objectId] = nil

	fadeDuration = fadeDuration or 0.25
	ModifyTextBox({ Id = anchorId, FadeTarget = 0.0, FadeDuration = fadeDuration, AutoSetDataProperties = false, })
	if UIData.UsePrompt.AttractAnimOff ~= nil then
		SetAnimation({ Name = UIData.UsePrompt.AttractAnimOff, DestinationId = anchorId })
	end
	if UIData.UsePrompt.AttractFlash ~= nil then
		local ids = {}
		if useTarget ~= nil then
			ids = useTarget.AdditionalAttractIds or ids
		end
		table.insert( ids, objectId )
		StopFlashing({ Id = ids })
	end
	wait( fadeDuration, RoomThreadName )

	Destroy({ Id = anchorId })

end

function HideAllUseButtons()
	if not IsEmpty(ScreenAnchors.UsePrompts) then
		for i, id in pairs(ScreenAnchors.UsePrompts) do
			SetAlpha({ Id = id, Fraction = 0, Duration = 0.1 })
			ModifyTextBox({ Id = id, FadeTarget = 0, FadeDuration = 0.1})
		end
	end
end

function ShowAllUseButtons()
	if not IsEmpty(ScreenAnchors.UsePrompts) then
		for i, id in pairs(ScreenAnchors.UsePrompts) do
			SetAlpha({ Id = id, Fraction = 1, Duration = 0.1 })
			ModifyTextBox({ Id = id, FadeTarget = 1, FadeDuration = 0.1})
		end
	end
end

function RefreshUseButton( objectId, useTarget )
	if ScreenAnchors ~= nil and ScreenAnchors.UsePrompts~= nil and ScreenAnchors.UsePrompts[objectId] ~= nil then
		HideUseButton( objectId, useTarget, 0 )
		ShowUseButton( objectId, useTarget )
	end
end

function CreateScreenComponent( params )
	local component = {}
	component.Id = CreateScreenObstacle( params )
	return component
end

function GetButtonIds( components )
	local buttonIds = {}
	for k, component in pairs( components ) do
		if component.OnPressedFunctionName ~= nil then
			table.insert( buttonIds, component.Id )
		end
	end
	return buttonIds
end

function GetAllIds( components )
	local componentIds = {}
	for k, component in pairs( components ) do
		table.insert( componentIds, component.Id )
	end
	return componentIds
end

function GetComponentById( components, id )
	for k, component in pairs( components ) do
		if component.Id == id then
			return component
		end
	end
	return nil
end

function GetComponentByHotkey( components, hotkey )
	for k, component in pairs( components ) do
		if component.ControlHotkey == hotkey then
			return component
		end
		if component.ControlHotkeys ~= nil and Contains( component.ControlHotkeys, hotkey ) then
			return component
		end
	end
	return nil
end

function CreateScreenObstacle( params )

	if params.Group == nil then
		params.Group = "Events"
	end
	if params.X == nil and params.Y == nil then
		params.X = ScreenCenterX
		params.Y = ScreenCenterY
	end
	if params.Scale == nil then
		params.Scale = 1.0
	end

	local obstacleId = SpawnObstacle({ Name = params.Name, Group = params.Group, OffsetX = params.X, OffsetY = params.Y, UseScreenLocation = true, SortById = true, TriggerOnSpawn = false })
	if params.Scale ~= 1.0 then
		SetScale({ Id = obstacleId, Fraction = params.Scale })
	end

	return obstacleId

end

function DisableWeapons()
	for k, weaponName in ipairs( WeaponSets.HeroPhysicalWeapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		local weaponNames = WeaponSets.HeroWeaponSets[weaponName]
		if weaponNames ~= nil then
			for k, linkedWeaponName in ipairs( weaponNames ) do
				SetWeaponProperty({ WeaponName = linkedWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
			end
		end
	end
	for k, weaponName in ipairs( WeaponSets.HeroNonPhysicalWeapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
		local weaponNames = WeaponSets.HeroWeaponSets[weaponName]
		if weaponNames ~= nil then
			for k, linkedWeaponName in ipairs( weaponNames ) do
				SetWeaponProperty({ WeaponName = linkedWeaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
			end
		end
	end
	for k, weaponName in pairs( WeaponSets.HeroTraitWeapons ) do
		SetWeaponProperty({ WeaponName = weaponName, DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
	end
	ToggleControl({ Names = { "Reload", }, Enabled = false })
end

function DisableCombatControls()
	if not CurrentRun or not CurrentRun.Hero then
		return
	end
	
	if flag == nil then
		flag = "Generic"
	end
	
	CurrentRun.Hero.DisableCombatControlsKeys = CurrentRun.Hero.DisableCombatControlsKeys or {}
	CurrentRun.Hero.DisableCombatControlsKeys[flag] = true

	ToggleControl({ Names = { "Rush", "Shout", "Assist", "Attack2", "Attack1", "Attack3", "AutoLock" }, Enabled = false })
end

function EnableCombatControls()
	if not CurrentRun or not CurrentRun.Hero or not CurrentRun.Hero.DisableCombatControlsKeys then
		return
	end
	
	if flag == nil then
		flag = "Generic"
	end
	
	CurrentRun.Hero.DisableCombatControlsKeys[flag] = nil

	if IsEmpty( CurrentRun.Hero.DisableCombatControlsKeys ) and IsEmpty( CurrentRun.Hero.FreezeInputKeys )  then
		ToggleControl({ Names = { "Rush", "Shout", "Assist", "Attack2", "Attack1", "Attack3", "AutoLock" }, Enabled = true })
	end
end

function OnScreenOpened( args )

	local flag = args.Flag
	if flag == nil then
		flag = "Generic"
	end

	GameState.ScreensViewed[flag] = true

	ActiveScreens[flag] = { PersistCombatUI = args.PersistCombatUI }
	if args.PersistCombatUI then
		ShowCombatUI()
		CombatUI.AutoHideEnabled = false
	end
	HideAllUseButtons()
	ZeroMouseTether( flag )
	SetConfigOption({ Name = "UseOcclusion", Value = false })
	if not args.SkipBlockTimer then
		AddTimerBlock( CurrentRun, flag )
	end
end

function IsScreenOpen( flag )
	return ActiveScreens[flag] ~= nil
end

function OnScreenClosed( args )
	local flag = args.Flag
	if flag == nil then
		flag = "Generic"
	end

	ActiveScreens[flag] = nil


	ShowAllUseButtons()
	local startCombatHide = true
	for flag, screenData in pairs(ActiveScreens) do
		if screenData.PersistCombatUI then
			startCombatHide = false
		end
	end

	if startCombatHide then
		CombatUI.AutoHideEnabled = true
		StartHideAfterDelayThread()
	end

	UnzeroMouseTether( flag )
	RemoveTimerBlock( CurrentRun, flag )
	if IsEmpty( ActiveScreens ) then
		SetConfigOption({ Name = "UseOcclusion", Value = true })
	end
end

function IsPauseBlocked()

	if CurrentRun ~= nil then
		if CurrentRun.Hero.HandlingDeath or CurrentRun.Hero.FishingStarted then
			return true
		end
	end

	local blockingScreens =
	{
		"Codex", "MetaUpgrade", "ShrineUpgrade", "Store", "Market", "MusicPlayer", "QuestLog", "Mutator", "GhostAdmin", "AwardMenu", "RunClear", "RunHistory", "GameStats", "TraitTrayScreen", "SellTraitMenu", "WeaponUpgradeScreen",
		"SeedControl",
	}
	for k, name in pairs( blockingScreens ) do
		if ActiveScreens[name] then
			return true
		end
	end

	return false

end

function SetCameraFocusOverride()
	UIData.CameraFocusOverride = true
	SetConfigOption({ Name = "ZeroMouseTether", Value = false })
end

function ClearCameraFocusOverride()
	UIData.CameraFocusOverride = false
	SetConfigOption({ Name = "ZeroMouseTether", Value = false })
	if not IsEmpty(UIData.ZeroMouseFlags) then
		SetConfigOption({ Name = "ZeroMouseTether", Value = true })
	end
end

function ZeroMouseTether( flag )
	if flag == nil then
		flag = "Generic"
	end

	UIData.ZeroMouseFlags[flag] = true
	if not UIData.CameraFocusOverride then
		SetConfigOption({ Name = "ZeroMouseTether", Value = true })
	end
end

function UnzeroMouseTether( flag )
	if flag == nil then
		flag = "Generic"
	end

	UIData.ZeroMouseFlags[flag] = nil
	if IsEmpty(UIData.ZeroMouseFlags) then
		SetConfigOption({ Name = "ZeroMouseTether", Value = false })
	end
end

function AreScreensActive( flag )
	if flag == nil then
		return not IsEmpty(ActiveScreens)
	end
	return ActiveScreens[flag] ~= nil
end

function FreezePlayerUnit(flag, args)
	if not CurrentRun or not CurrentRun.Hero then
		return
	end
	
	if flag == nil then
		flag = "Generic"
	end
	args = args or { DisableTray = true }
	CurrentRun.Hero.FreezeInputKeys[flag] = ShallowCopyTable(args)
	if args.DisableTray then
		ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })
	end
	if args.DisableCodex then
		ToggleControl({ Names = { "Codex", }, Enabled = false })
	end
	Stop({ Id = CurrentRun.Hero.ObjectId, StopRotation = args.StopRotation })
	ToggleControl({ Names = { "Use", "Move", "Rush", "Shout", "Assist", "Attack1", "Attack2", "Attack3", "AutoLock", "Gift", "Emote", "Reload", }, Enabled = false })
	ToggleMove({ Enabled = false })
end

function UnfreezePlayerUnit(flag)
	if not CurrentRun or not CurrentRun.Hero or not CurrentRun.Hero.FreezeInputKeys then
		return
	end
	if flag == nil then
		flag = "Generic"
	end
	if CurrentRun.Hero.FreezeInputKeys[flag] and CurrentRun.Hero.FreezeInputKeys[flag].DisableTray then
		ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })
	end
	if CurrentRun.Hero.FreezeInputKeys[flag] and CurrentRun.Hero.FreezeInputKeys[flag].DisableCodex then
		ToggleControl({ Names = { "Codex", }, Enabled = true })
	end
	CurrentRun.Hero.FreezeInputKeys[flag] = nil

	if IsEmpty( CurrentRun.Hero.FreezeInputKeys ) then
		if CurrentDeathAreaRoom == nil and ( CurrentRun.CurrentRoom.DisableWeaponsExceptDash or CurrentRun.CurrentRoom.DisableWeapons ) then
		
			if CurrentRun.CurrentRoom.DisableWeapons then
				ToggleControl({ Names = { "Use", "Gift", "Emote" }, Enabled = true })
			elseif CurrentRun.CurrentRoom.DisableWeaponsExceptDash then
				ToggleControl({ Names = { "Use", "Rush", "Gift", "Emote" }, Enabled = true })
			end
		else
			if IsEmpty( CurrentRun.Hero.DisableCombatControlsKeys ) then
				ToggleControl({ Names = { "Use", "Rush", "Shout", "Assist", "Attack1", "Attack2", "Attack3", "AutoLock", "Gift", "Emote", "Reload", }, Enabled = true })
			else
				ToggleControl({ Names = { "Use", "Gift", "Emote", "Reload", }, Enabled = true })
			end
		end
		ToggleMove({ Enabled = true })
	end
end

function TemporaryDisableUse( waitDuration )
	ToggleControl({ Names = { "Use"}, Enabled = false })
	waitDuration = waitDuration or 0.5
	wait(waitDuration)
	ToggleControl({ Names = { "Use"}, Enabled = true })
end

function HandleScreenInput( screen )
	screen.KeepOpen = true
	screen.AllowHold = false
	while screen.KeepOpen do
		local notifyName = "ScreenInput"
		if screen.Name ~= nil then
			notifyName = notifyName..screen.Name
		end
		local buttonIds = {}
		local hotkeyControls = {}
		for k, component in pairs( screen.Components ) do
			if component.OnPressedFunctionName ~= nil then
				table.insert( buttonIds, component.Id )
			end
			if component.ControlHotkey ~= nil then
				table.insert( hotkeyControls, component.ControlHotkey )
			end
			if component.ControlHotkeys ~= nil then
				for k, controlHotkey in pairs( component.ControlHotkeys ) do
					table.insert( hotkeyControls, controlHotkey )
				end
			end
		end
		NotifyOnInteract({ Ids = buttonIds, Notify = notifyName })
		NotifyOnControlPressed({ Names = hotkeyControls, Notify = notifyName, AllowHold = screen.AllowHold })
		waitUntil( notifyName )
		local inputResult = NotifyResultsTable[notifyName]
		local button = nil
		if type(inputResult) == "string" then
			button = GetComponentByHotkey( screen.Components, inputResult )
		else
			button = GetComponentById( screen.Components, inputResult )
		end
		if button ~= nil and button.OnPressedFunctionName ~= nil then
			local onPressedFunction = _G[button.OnPressedFunctionName]
			if onPressedFunction ~= nil then
				onPressedFunction( screen, button )
			end
			if button.Sound ~= nil then
				PlaySound({ Name = button.Sound })
			end
		end
		if button ~= nil and button.OnPressedGlobalVoiceLines ~= nil then
			thread( PlayVoiceLines, GlobalVoiceLines[button.OnPressedGlobalVoiceLines], true )
		end
		wait( 0.05 )
		if screen.AllowInputRepeat then
			thread( CheckInputRepeat, screen, notifyName, hotkeyControls )
		end
	end
end

function CheckInputRepeat( screen, notifyName, hotkeyControls )
	local threadName = "RepeatThread"
	if HasThread( threadName ) then
		return
	end
	wait( 0.1, threadName )
	if IsControlDown({ Names = hotkeyControls }) then
		if not screen.AllowHold then
			wait( 0.5, threadName )
			if IsControlDown({ Names = hotkeyControls }) then
				screen.AllowHold = true
			else
				screen.AllowHold = false
			end
		end
	else
		screen.AllowHold = false
	end
	if screen.AllowHold then
		NotifyOnControlPressed({ Names = hotkeyControls, Notify = notifyName, AllowHold = screen.AllowHold })
	end
end

function CloseScreen( componentIds, delay )
	HideTopMenuScreenTooltips( {Ids = componentIds} )
	ModifyTextBox({ Ids = componentIds, BlockTooltip = true })
	if delay ~= nil and delay > 0 then
		wait( delay )
	end
	local fadeOutTime = 0.2
	SetAlpha({ Ids = componentIds, Fraction = 0, Duration = fadeOutTime })
	ModifyTextBox({ Ids = componentIds, FadeTarget = 0, FadeDuration = fadeOutTime })
	waitScreenTime( fadeOutTime )
	Destroy({ Ids = componentIds })
	ClearUseTarget({})
end

function EnableShopGamepadCursor( flag )
	flag = flag or "Generic"
	GamepadCursorRequests[flag] = flag
	SetConfigOption({ Name = "GamepadCursorControl", Value = true })
end

function DisableShopGamepadCursor( flag )

	flag = flag or "Generic"
	GamepadCursorRequests[flag] = nil
	if IsEmpty( GamepadCursorRequests ) then
		SetConfigOption({ Name = "GamepadCursorControl", Value = false })
	end
end

function CreateTextBoxWithFormat( args )

	local format = TextFormats[args.Format]
	DebugAssert({ Condition = format ~= nil, Text = "Asking for non-existent TextFormat ("..args.Format..")!" })
	local textBoxParams = MergeTables( format, args )
	textBoxParams.AutoSetDataProperties = true
	CreateTextBox( textBoxParams )
	HotLoadInfo.TextBoxCache = HotLoadInfo.TextBoxCache or {}
	HotLoadInfo.TextBoxCache[args.Id] = args.Format

end

function CreateBossHealthBar( boss )
	if boss.HasHealthBar then
		return
	end
	boss.HasHealthBar = true

	if ScreenAnchors.BossHealthTitles == nil then
		ScreenAnchors.BossHealthTitles = {}
	end
	local index = TableLength(ScreenAnchors.BossHealthTitles)
	local numBars = GetNumBossHealthBars()
	local yOffset = 0
	local xScale = 1 / numBars
	boss.BarXScale = xScale
	local totalWidth = ScreenWidth * xScale
	local xOffset = ( totalWidth / ( 2 * numBars )) * ( 1 + index * 2 ) + (ScreenWidth - totalWidth) / 2

	ScreenAnchors.BossHealthBack = CreateScreenObstacle({Name = "BossHealthBarBack", Group = "Combat_UI_Backing", X = xOffset , Y = 70 + yOffset})
	ScreenAnchors.BossHealthTitles[ boss.ObjectId ] = ScreenAnchors.BossHealthBack
	ScreenAnchors.BossHealthFill = CreateScreenObstacle({Name = "BossHealthBarFill", Group = "Combat_UI", X = xOffset , Y = 72 + yOffset})

	local fallOffBar = CreateScreenObstacle({Name = "BossHealthBarFillFalloff", Group = "Combat_UI_Backing", X = xOffset , Y = 72 + yOffset})

	SetColor({ Id = fallOffBar, Color = Color.HealthFalloff })
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlowBoss", Fraction = 0, DestinationId = fallOffBar, Instant = true })

	CreateAnimation({ Name = "BossNameShadow", DestinationId = ScreenAnchors.BossHealthBack })

	SetScaleX({ Ids = { ScreenAnchors.BossHealthBack, ScreenAnchors.BossHealthFill, fallOffBar }, Fraction = xScale, Duration = 0 })

	local bossName = boss.HealthBarTextId or boss.Name

	if boss.AltHealthBarTextIds ~= nil then
		local eligibleTextIds = {}
		for k, altTextIdData in pairs(boss.AltHealthBarTextIds) do
			if IsGameStateEligible( CurrentRun, altTextIdData.Requirements) then
				table.insert(eligibleTextIds, altTextIdData.TextId)
			end
		end
		if not IsEmpty(eligibleTextIds) then
			bossName = GetRandomValue(eligibleTextIds)
		end
	end

	CreateTextBox({ Id = ScreenAnchors.BossHealthBack, Text = bossName,
			Font = "CaesarDressing", FontSize = 22, ShadowRed = 0, ShadowBlue = 0, ShadowGreen = 0,
			OutlineColor = {0, 0, 0, 1}, OutlineThickness = 2,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 3, ShadowOffsetX = 0, Justification = "Center", OffsetY = -30,
			OpacityWithOwner = false,
			AutoSetDataProperties = true,
			})

	ModifyTextBox({ Id = ScreenAnchors.BossHealthBack, FadeTarget = 0, FadeDuration = 0 })
	SetAlpha({ Id = ScreenAnchors.BossHealthBack, Fraction = 0.01, Duration = 0.0 })
	SetAlpha({ Id = ScreenAnchors.BossHealthBack, Fraction = boss.Health / boss.MaxHealth, Duration = 2.0 })
	EnemyHealthDisplayAnchors[boss.ObjectId.."back"] = ScreenAnchors.BossHealthBack

	boss.HealthBarFill = "EnemyHealthBarFillBoss"
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = boss.Health / boss.MaxHealth, DestinationId = screenId })
	SetAlpha({ Ids = { ScreenAnchors.BossHealthFill, fallOffBar }, Fraction = 0.01, Duration = 0.0 })
	SetAlpha({ Ids = { ScreenAnchors.BossHealthFill, fallOffBar }, Fraction = 1, Duration = 2.0 })
	EnemyHealthDisplayAnchors[boss.ObjectId] = ScreenAnchors.BossHealthFill
	EnemyHealthDisplayAnchors[boss.ObjectId.."falloff"] = fallOffBar

	thread( BossHealthBarPresentation, boss )
end

function BossHealthBarPresentation( boss )
	local screenId = EnemyHealthDisplayAnchors[boss.ObjectId]
	local falloffId = EnemyHealthDisplayAnchors[boss.ObjectId.."falloff"]
	local healthFraction = 0
	local bossHealthBarSoundId = PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegaeraHealthFillUp", Id = screenId })
	if boss.HitShields > 0 then
		SetColor({ Id = screenId, Color = Color.HitShield})
	else
		SetColor({ Id = screenId, Color = Color.Red })
	end
	ModifyTextBox({ Id = ScreenAnchors.BossHealthBack, FadeTarget = 1, FadeDuration = 2 })
	while healthFraction < boss.Health / boss.MaxHealth do
		healthFraction = healthFraction + 0.01
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1 - healthFraction, DestinationId = screenId })
		SetAnimationFrameTarget({ Name = "EnemyHealthBarFillSlowBoss", Fraction = 1 - healthFraction, DestinationId = falloffId, Instant = true })
		wait(0.005)
	end
	StopSound({ Id = bossHealthBarSoundId, Duration = 0.25 })
	thread( UpdateHealthBar, boss, 0, { Force = true })
end

function CreateBossRageMeter(boss)
	ScreenAnchors.BossRageTitle = CreateScreenObstacle({Name = "BlankObstacle", Group = "Combat_UI", X = ScreenCenterX, Y = 130, Scale = 1.0})
	ScreenAnchors.BossRageBack = CreateScreenObstacle({Name = "BlankObstacle", Group = "Combat_UI", X = ScreenCenterX, Y = 150, Scale = 0.5})
	ScreenAnchors.BossRageFill = CreateScreenObstacle({Name = "BlankObstacle", Group = "Combat_UI", X = ScreenCenterX, Y = 152, Scale = 0.5})

	CreateTextBox({ Id = ScreenAnchors.BossRageTitle, Text = "RageMeter",
			Font = "AlegreyaSansSCBold", FontSize = 14, ShadowRed = 0, ShadowBlue = 0, ShadowGreen = 0,
			OutlineColor = {0, 0, 0, 1}, OutlineThickness = 2,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 3, ShadowOffsetX = 0, Justification = "Center" })
	SetAlpha({ Id = ScreenAnchors.BossRageTitle, Fraction = 0.01, Duration = 0.0 })
	SetAlpha({ Id = ScreenAnchors.BossRageTitle, Fraction = 1, Duration = 2.0 })

	SetAnimation({ Name = "EnemyHealthBarBoss", DestinationId = ScreenAnchors.BossRageBack })
	SetAlpha({ Id = ScreenAnchors.BossRageBack, Fraction = 0.01, Duration = 0.0 })
	SetAlpha({ Id = ScreenAnchors.BossRageBack, Fraction = 1, Duration = 2.0 })

	boss.RageBarFill = "EnemyHealthBarFillBoss"
	SetAnimation({ Name = "EnemyHealthBarFillBoss", DestinationId = ScreenAnchors.BossRageFill })
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1, DestinationId = screenId })
	SetAlpha({ Id = ScreenAnchors.BossRageFill, Fraction = 0.01, Duration = 0.0 })
	SetAlpha({ Id = ScreenAnchors.BossRageFill, Fraction = 1, Duration = 2.0 })
end

function CheckCallLock( name )
	if ScreenAnchors.CallLock[name] then
		return false
	end
	ScreenAnchors.CallLock[name] = true
	return true
end

function ReleaseCallLock( name )
	ScreenAnchors.CallLock[name] = nil
end

OnControlPressed{ "AdvancedTooltip",
	function( triggerArgs )
		if IsScreenOpen("Codex") then
			AttemptOpenCodexBoonInfo()
			return
		end

		if ScreenAnchors.RunDepthId == nil then
			ShowDepthCounter()
		else
			HideDepthCounter()
		end

		if ( not IsInputAllowed({}) and not GameState.WaitingForChoice ) or ( CurrentRun ~= nil and CurrentRun.Hero ~= nil and ( IsEmpty( CurrentRun.Hero.Traits ) and GetTotalSpentMetaPoints() == 0 ) ) or ( CurrentDeathAreaRoom ~= nil and CurrentDeathAreaRoom.ShowResourceUIOnly ) then
			return
		end

		if ScreenAnchors.TraitTrayScreen ~= nil and ScreenAnchors.TraitTrayScreen.CanClose then
			CloseAdvancedTooltipScreen()
		else
			ShowDepthCounter()
			ShowAdvancedTooltip( { AutoPin = false, } )
		end
	end
}

OnMouseOver{
	function( triggerArgs )
		local button = triggerArgs.TriggeredByTable
		if button == nil then
			return
		end
		if button.OnMouseOverFunctionName == nil then
			return
		end
		local mouseOverFunction = _G[button.OnMouseOverFunctionName]
		if mouseOverFunction ~= nil then
			mouseOverFunction( button )
		end
	end
}

OnMouseOff{
	function( triggerArgs )
		local button = triggerArgs.TriggeredByTable
		if button == nil then
			return
		end
		if button.OnMouseOffFunctionName == nil then
			return
		end
		local mouseOffFunction = _G[button.OnMouseOffFunctionName]
		if mouseOffFunction ~= nil then
			mouseOffFunction( button )
		end
	end
}

function UpdateActiveShrinePoints()

	if not ConfigOptionCache.ShowUIAnimations or not ShowingCombatUI or GameState.SpentShrinePointsCache <= 0 then
		if ScreenAnchors.ShrinePointIconId ~= nil then
			HideObstacle({ Id = ScreenAnchors.ShrinePointIconId, Duration = 0.2, IncludeText = true, })
		end
		return
	end

	if CurrentDeathAreaRoom ~= nil and not CurrentDeathAreaRoom.ShowShrinePoints then
		if ScreenAnchors.ShrinePointIconId ~= nil then
			HideObstacle({ Id = ScreenAnchors.ShrinePointIconId, Duration = 0.2, IncludeText = true, })
		end
		return
	end

	if ScreenAnchors.ShrinePointIconId == nil then
		ScreenAnchors.ShrinePointIconId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray", X = 26, Y = 54 })
		CreateTextBox({ Id = ScreenAnchors.ShrinePointIconId, Text = "InGameUI_ActiveShrinePoints",
			Font = "AlegreyaSansSCBold", FontSize = 22,
			Justification = "Left", TextSymbolScale = 1.6,
			TextRed = 0.85,
			TextGreen = 0.85,
			TextBlue = 0.85,
			OffsetX = GetLocalizedValue(0, { { Code = "ja", Value = 20 } }),
			TextOutlineRed = 0.25,
			TextOutlineGreen = 0.22,
			TextOutlineBlue = 0.19,
			OutlineThickness = 1.0,
			ShadowRed = 0,
			ShadowBlue = 0,
			ShadowGreen = 0,
			ShadowAlpha = 1,
			ShadowBlur = 0,
			ShadowOffsetY = 3,
			ShadowOffsetX = 0,
			OpacityWithOwner = true,
			})
	else
		FadeObstacleIn({ Id = ScreenAnchors.ShrinePointIconId, Duration = 0.2, IncludeText = true, })
		ModifyTextBox({ Id = ScreenAnchors.ShrinePointIconId, Text = "InGameUI_ActiveShrinePoints", ReReadImmedaitely = true, })
		thread( PulseText, { ScreenAnchorReference = "ShrinePointIconId", ScaleTarget = 1.2, ScaleDuration = 0.3, HoldDuration = 0, PulseBias = 0.5 } )
	end

end

function PulseActiveShrinePoints()
	if ScreenAnchors.ShrinePointIconId == nil then
		return
	end
	thread( PulseText, { ScreenAnchorReference = "ShrinePointIconId", ScaleTarget = 1.2, ScaleDuration = 0.3, HoldDuration = 0, PulseBias = 0.5 } )
end

OnControlHotSwap
{
	function( triggerArgs )
		if ScreenAnchors.TraitTrayScreen ~= nil then
			SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
		end
	end
}