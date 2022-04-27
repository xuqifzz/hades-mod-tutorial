function SuperReachedPresentation( pipIndex, maxedOutMeter )
	if pipIndex == 1 then
		thread( HintSuper )
	end

	if maxedOutMeter then
		thread( InCombatText, CurrentRun.Hero.ObjectId, "MaxSuperCharged", 1.8, { ShadowScale = 0.8 } )
	end

	if ScreenAnchors.SuperMeterHint then
		if maxedOutMeter then
			SetAnimation({ Name = "WrathBarFullFxStart", DestinationId = ScreenAnchors.SuperMeterHint })
		end
	end

	if ScreenAnchors.SuperPipIds then
		SetColor({ Color = Color.White, Ids = ScreenAnchors.SuperPipIds, Duration = 0.5 })
	end
end

function SuperEndPresentation( pipIndex, isMax )
	if isMax then
		PlaySound({ Name = "/SFX/WrathOver", Id = CurrentRun.Hero.ObjectId })
	elseif ScreenAnchors.SuperPipIds and ScreenAnchors.SuperPipIds[index] then
		SetAnimation({ Name = "WrathPipEmpty", DestinationId = ScreenAnchors.SuperPipIds[index] })
	end
end

function SuperWarnPresentation( hero, isFullSuper )
	if not hero.SuperActive then
		return
	end
	if isFullSuper then
		PlaySound({ Name = "/SFX/WrathEndingWarning", Id = hero.ObjectId })
	end
	Flash({ Id = hero.ObjectId, Speed = 1/SuperUI.ExpiringSoundInterval, MinFraction = 0, MaxFraction = 0.5, Color = Color.White,  ExpireAfterCycle = true })
end

function PostEncounterDrainSuperPresentation( hasSuperToDrain )
	if hasSuperToDrain and ScreenAnchors.SuperMeterHint and CurrentRun.Hero.SuperMeter == CurrentRun.Hero.SuperMeterLimit then
		SetAnimation({ Name = "WrathBarFullFxEnd", DestinationId = ScreenAnchors.SuperMeterHint })
	end
end

function SuperUsedPresentation( traitData )
	DoSuperPresentation( traitData )
end

function FullSuperUsedPresentation( traitData )
	DoFullSuperPresentation( traitData )
	CheckAchievement( { Name = "AchGreaterCall" } )
	if CurrentRun.CurrentRoom.Encounter.EncounterType == "Devotion" then
		if CurrentRun.CurrentRoom.Encounter.SpurnedGodName == traitData.God.."Upgrade" then
			CheckAchievement( { Name = "AchGreaterCallSpurned" } )
		end
	end
end

function HintSuper()
	if SuperUI.HasHinted then
		return
	end

	SuperUI.HasHinted = true
	while IsSuperAvailable( CurrentRun.Hero ) and CanCommenceSuper( CurrentRun.Hero ) do
		if IsEmpty( ActiveScreens ) then
			local text = "SuperCharged"
			local tempShadowScale = 0.66
			if CurrentRun.Hero.SuperMeter >= CurrentRun.Hero.SuperMeterLimit then
				text = "MaxSuperCharged"
				tempShadowScale = 0.80
				thread( PlayVoiceLines, HeroVoiceLines.WrathStockGainedVoiceLines, true )
			end
			if CurrentRun.CurrentRoom.Name == "RoomOpening" then
				wait( 1.5 )
				thread( InCombatText, CurrentRun.Hero.ObjectId, text, 1.8, { ShadowScale = tempShadowScale } )
			else
				thread( InCombatText, CurrentRun.Hero.ObjectId, text, 1.8, { ShadowScale = tempShadowScale } )
			end
		end

		local cooldown = SuperUI.HintCooldown
		if CurrentRun.Hero.SuperMeter >= CurrentRun.Hero.SuperMeterLimit then
			cooldown = SuperUI.ExHintCooldown
		end
		wait(SuperUI.HintCooldown, RoomThreadName)
	end
	SuperUI.HasHinted = false
end

function InvisBreakPresentation()

	PlaySound({ Name = "/SFX/Player Sounds/HermesWhooshDashReverse", Id = CurrentRun.Hero.ObjectId })

end

function AtLastStandMaxPresentation( unit )
	-- stub method
end

function MoneyLossPresentation(amount, delta)
	MoneyGainPresentation( amount, delta )
end

function MoneyGainPresentation(amount, delta)
	if not ShowingCombatUI then
		return
	end

	local text = "MoneyAmount"
	local color = Color.Orange
	local lightColor = Color.LightGold
	if MoneyUI.Floating < 0 then
		text = "NegativeMoneyAmount"
		color = Color.CostUnaffordableLight
		lightColor = Color.CostUnaffordableLight
	end
	local floatingMoney = MoneyUI.Floating

	-- Color
	ModifyTextBox({ Id = ScreenAnchors.MoneyIcon, ScaleTarget = 1.8, ScaleDuration = 0.0, AutoSetDataProperties = false, })
	ModifyTextBox({ Id = ScreenAnchors.MoneyIcon, Color = lightColor, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0, AutoSetDataProperties = false, })
	waitScreenTime(0.05)
	ModifyTextBox({ Id = ScreenAnchors.MoneyIcon, ScaleTarget = 1.0, ScaleDuration = 1.25, Delay = 0.75, AutoSetDataProperties = false, })
	ModifyTextBox({ Id = ScreenAnchors.MoneyIcon, ColorTarget = color, ColorDuration = 0.1, AutoSetDataProperties = false, })

	-- Pulses the money text

	waitScreenTime(0.06)
	if not ShowingCombatUI then
		return
	end

	ModifyTextBox({ Id = ScreenAnchors.MoneyIcon, ColorTarget = Color.White, ColorDuration = 2.0, AutoSetDataProperties = false, })

	local digitSpacer = string.len(CurrentRun.Money) * MoneyUI.DigitSpacer
	if ScreenAnchors.MoneyDelta ~= nil then
		if ScreenAnchors.MoneyDeltaMoveTargetId ~= nil then
			Teleport({Id = ScreenAnchors.MoneyDeltaMoveTargetId , OffsetX = ConsumableUI.StartX + MoneyUI.StartSpacer + digitSpacer, OffsetY = ConsumableUI.StartY + ConsumableUI.SpacerY * 0 })
		else
			ScreenAnchors.MoneyDeltaMoveTargetId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = ConsumableUI.StartX + MoneyUI.StartSpacer + digitSpacer, Y = ConsumableUI.StartY + ConsumableUI.SpacerY * 0 })
		end
		Move({ Id = ScreenAnchors.MoneyDelta, DestinationId = ScreenAnchors.MoneyDeltaMoveTargetId, Duration = 0.5, EaseIn = 0, EaseOut = 1 })
		ModifyTextBox({ Id = ScreenAnchors.MoneyDelta, Text = text, LuaKey = "TempTextData", LuaValue = { Amount = floatingMoney }, AutoSetDataProperties = false })
	else
		ScreenAnchors.MoneyDelta = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = ConsumableUI.StartX + MoneyUI.StartSpacer + digitSpacer, Y = ConsumableUI.StartY + ConsumableUI.SpacerY * 0 })
		CreateTextBox({ Id = ScreenAnchors.MoneyDelta, Text = text,
				Font = "AlegreyaSansSCRegular", FontSize = 28, ShadowColor = { 0.1, 0.1, 0.1, 1.0 },
				Color = Color.White,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 3,
				ShadowBlur = 0, ShadowOffset = { 0, 4 }, Justification = "Right", TextSymbolScale = 0.5,
				LuaKey = "TempTextData", LuaValue = { Amount = floatingMoney },
				AutoSetDataProperties = false,
				})
	end

	-- Color pulse
	ModifyTextBox({ Id = ScreenAnchors.MoneyDelta, Color = lightColor, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0, AutoSetDataProperties = false, })
	waitScreenTime(0.05)
	ModifyTextBox({ Id = ScreenAnchors.MoneyDelta, ColorTarget = Color.White, ColorDuration = 1.6, AutoSetDataProperties = false, })

	thread(HideMoneyAfterDelay)
end

function HideMoneyAfterDelay()
	MoneyUI.RunningThreads = MoneyUI.RunningThreads + 1

	wait(MoneyUI.HideDelay)
	if ScreenAnchors.MoneyDelta ~= nil then
		ModifyTextBox({ Id = ScreenAnchors.MoneyDelta, FadeTarget = 0, FadeDuration = MoneyUI.FadeDuration, AutoSetDataProperties = false, })
	end
	wait(MoneyUI.FadeDuration)

	MoneyUI.RunningThreads = MoneyUI.RunningThreads - 1
	if MoneyUI.RunningThreads == 0 then
		MoneyUI.Floating = 0
	end
end
function CantAffordPresentation( object )
	if object ~= nil then
		Shake({ Id = object.ObjectId, Distance = 6, Speed = 300, Duration = 0.2 })
	end
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 }, } )
	thread( MoneyFlashRed )
	if object and object.NotEnoughCurrencyVoiceLines then
		thread( PlayVoiceLines, object.NotEnoughCurrencyVoiceLines, true )
	else
		thread( PlayVoiceLines, HeroVoiceLines.NotEnoughCurrencyVoiceLines, true )
	end
end

function CantPurchaseWorldItemPresentation( object )
	if object ~= nil then
		Shake({ Id = object.ObjectId, Distance = 6, Speed = 300, Duration = 0.2 })
	end
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 }, } )
	if object.CannotPurchaseCombatText and CheckCooldown("CannotPurchaseCombatText", 1.0 ) then
		thread( InCombatTextArgs, { TargetId = object.ObjectId, Text = object.CannotPurchaseCombatText, Duration = 2, OffsetY = -140, SkipRise = true })
	end
	if object.CannotPurchaseVoiceLines then
		thread( PlayVoiceLines, object.CannotPurchaseVoiceLines, true )
	else
		thread( PlayVoiceLines, HeroVoiceLines.CannotPurchaseVoiceLines, true )
	end
end

function CantPurchasePresentation( button )
	Flash({ Id = button.Id, Speed = 2.5, MinFraction = 0.5, MaxFraction = 0.0, Color = Color.CostCantPurchase, ExpireAfterCycle = true })
	thread( PlayVoiceLines, HeroVoiceLines.CannotPurchaseVoiceLines, true )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
end

function MoneyFlashRed()
	ModifyTextBox({ Id = ScreenAnchors.MoneyIcon, ScaleTarget = 1.2, ScaleDuration = 0.0, AutoSetDataProperties = false, })
	ModifyTextBox({ Id = ScreenAnchors.MoneyIcon, Color = Color.CostUnaffordable, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0, AutoSetDataProperties = false, })
	waitScreenTime(0.05)
	ModifyTextBox({ Id = ScreenAnchors.MoneyIcon, ColorTarget = Color.CostUnaffordable, ColorDuration = 2.0, AutoSetDataProperties = false, })

	-- Pulses the money text

	waitScreenTime(0.06)
	ModifyTextBox({ Id = ScreenAnchors.MoneyIcon, ScaleTarget = 1, ScaleDuration = 0.4, AutoSetDataProperties = false, })
	ModifyTextBox({ Id = ScreenAnchors.MoneyIcon, ColorTarget = Color.White, ColorDuration = 0.4, AutoSetDataProperties = false, })
end

function MarketPurchaseFailPresentation( item )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 }, } )
	if IsEmpty( ResourceData[item.CostName].BrokerCannotSpendVoiceLines ) then
		thread( PlayVoiceLines, HeroVoiceLines.NotEnoughCurrencyVoiceLines, true )
	else
		thread( PlayVoiceLines, ResourceData[item.CostName].BrokerCannotSpendVoiceLines, true )
	end
end

function MarketPurchaseSuccessPresentation( item )
	local brokerId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "BrokerGhost01", Distance = 800 })
	PlaySound({ Name = item.PurchaseSound or "/Leftovers/Menu Sounds/StoreSellingItem" })
	--thread( PlayRandomEligibleVoiceLines, { item.PurchasedLines } )
	if item.Priority then
		thread( PlayVoiceLines, GlobalVoiceLines.PurchasedMarketItemVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.PurchasedSpecialOfferVoiceLines, true )
	end
	if CheckCooldown( "PurchasedMarketItemRecently", 3 ) then
		PlaySound({ Name = "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = brokerId, Delay = 1.5 })
	end
end
function MarketPurchaseSuccessRepeatablePresentation( button )
	Flash({ Id = button.Id, Speed = 4, MinFraction = 1, MaxFraction = 0.0, Color = Color.LightGold, ExpireAfterCycle = true })
	CreateAnimation({ Name = "MarketPurchaseSparkles", DestinationId = button.Id, GroupName = "Overlay" })
end

function MetaPointSpendPresentation(spend, buttonId)
	local screen = ScreenAnchors.LevelUpScreen or ScreenAnchors.ShrineScreen
	CreateAnimation({ Name = "MetaPointTransactionHighlight", DestinationId = buttonId, GroupName = "Overlay" })
	CreateAnimationsBetween({ Animation = "MetapointRefundStreakReverse", DestinationId = screen.Components.SubTitle.Id, Id = buttonId,
		Stretch = true,
		WorldSpace = false,
		TargetXOffset = 317,
		TargetYOffset = -226,
	})
end

function UnlockedMetaUpgradesPresentation( screen, button )
	thread( PlayVoiceLines, HeroVoiceLines.MetaUpgradeUnlockedVoiceLines, true )
	CreateAnimation({ DestinationId = button.Id, Name = "LevelUpMirrorUnlockButton_Remove", GroupName = "Combat_Menu_TraitTray_Additive" })
	CreateAnimation({ DestinationId = button.Id, Name = "LevelUpMirrorUnlockButton_Remove_Glow", GroupName = "Combat_Menu_TraitTray_Additive" })
	for i = 1, 50 do
		CreateAnimation({ DestinationId = button.Id, Name = "LevelUpMirrorUnlockButtonRemoveParticles", GroupName = "Combat_Menu_TraitTray_Additive" })
	end


	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof", Id = button.Id })
end

function CannotUnlockMetaUpgradesPresentation( screen, button )
	-- Flash({ Id = button.Id, Speed = 0.85, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Red, Duration = 0.3, ExpireAfterCycle = true })
	-- Shake({ Id = button.Id, Distance = 3, Speed = 1000, Duration = 0.2 })
	CreateAnimation({ DestinationId = button.Id, Name = "LevelUpMirrorUnlockButton_CannotUnlock", GroupName = "Overlay" })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = button.Id })
	if CheckCountInWindow( "UnlockAttempt", 1.0, 2 ) then
		thread( PlayVoiceLines, HeroVoiceLines.NotEnoughLockKeysVoiceLines, true )
	end
end

function MetaPointRefundPresentation(refund, buttonId)
	local screen = ScreenAnchors.LevelUpScreen or ScreenAnchors.ShrineScreen
	CreateAnimation({ Name = "MetaPointTransactionHighlight-Refund", GroupName = "Overlay", DestinationId = screen.Components.SubTitle.Id, OffsetX = 317, OffsetY = -226 })
	CreateAnimationsBetween({ Animation = "MetapointRefundStreak", DestinationId = screen.Components.SubTitle.Id, Id = buttonId,
		Stretch = true,
		WorldSpace = false,
		TargetXOffset = 317,
		TargetYOffset = -226,
	})
end

function CannotRefundMetaUpgradesPresentation( button )
	Flash({ Id = button.Id, Speed = 4, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Red, Duration = 0.125, ExpireAfterCycle = true })
	thread(PulseText, {Id = button.Id, Color = Color.Red, OriginalColor = Color.White, ScaleTarget = 1.15, ScaleDuration = 0.1, HoldDuration = 0.05, PulseBias = 0.1 })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = button.Id })
	if CheckCountInWindow( "UnlockAttempt", 1.0, 2 ) then
		thread( PlayVoiceLines, HeroVoiceLines.NotEnoughLockKeysVoiceLines, true )
	end
end

function MetaPointGainedPresentation( gained, args )
	if not args.SkipOverheadText then
		thread( PopOverheadText, { Amount = gained, Text = "MetaPointAmount", Color = Color.DarknessPoint } )
	end
	thread( MetaPointGainedPresentationThread )
	if HeroHasTrait( "UnusedWeaponBonusTrait" ) then
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "Hint_UnusedWeaponBonusTrait", Duration = 1.3, PreDelay = 0.1 } )
	end
end

function MetaPointGainedPresentationThread()
	if ScreenAnchors.MetaPoint == nil then
		return
	end
	CreateAnimation({ Name = "SkillProcFeedbackFx-MetaPointsGained", DestinationId = ScreenAnchors.MetaPoint, GroupName = "Overlay" })
	ModifyTextBox({ Id = ScreenAnchors.MetaPoint, Color = {0.745, 0.420, 0.996, 1.0}, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0 })
	wait(0.15)
	ModifyTextBox({ Id = ScreenAnchors.MetaPoint, Color = { 254, 254, 254, 255 }, ColorChangeSpeed = 1.0 })
end

function ShrinePointSpendPresentation(spend, buttonId)
	if not ScreenAnchors.ShrineScreen then
		return
	end

	CreateAnimation({ Name = "ShrinePointTransactionHighlight-Refund", GroupName = "Overlay", DestinationId = ScreenAnchors.ShrineScreen.Components.SubTitle.Id, OffsetX = -194, OffsetY = -88 })
	CreateAnimationsBetween({ Animation = "ShrinePointRefundStreak", DestinationId = ScreenAnchors.ShrineScreen.Components.SubTitle.Id, Id = buttonId,
		Stretch = true,
		WorldSpace = false,
		TargetXOffset = -194,
		TargetYOffset = -88,
	})
end

function ShrinePointRefundPresentation(refund, buttonId)
	if not ScreenAnchors.ShrineScreen then
		return
	end

	CreateAnimation({ Name = "ShrinePointTransactionHighlight", DestinationId = buttonId, GroupName = "Overlay" })
	CreateAnimationsBetween({ Animation = "ShrinePointRefundStreakReverse", DestinationId = ScreenAnchors.ShrineScreen.Components.SubTitle.Id, Id = buttonId,
		Stretch = true,
		WorldSpace = false,
		TargetXOffset = -257,
		TargetYOffset = -132,
	})
end

function ShrinePointGainedPresentation( gained, args )
	if not args.SkipOverheadText then
		thread( PopOverheadText, { Amount = gained, Text = "ShrinePointAmount", Color = Color.ShrinePoint } )
	end
	thread( ShrinePointGainedPresentationThread )
end

function ShrinePointGainedPresentationThread()
	if ScreenAnchors.ShrinePoint == nil then
		return
	end
	CreateAnimation({ Name = "SkillProcFeedbackFx-ShrinePointsGained", DestinationId = ScreenAnchors.ShrinePoint, GroupName = "Overlay" })
	ModifyTextBox({ Id = ScreenAnchors.ShrinePoint, Color = {0.745, 1.0, 0.996, 1.0}, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0 })
	wait(0.15)
	ModifyTextBox({ Id = ScreenAnchors.ShrinePoint, Color = { 254, 254, 254, 255 }, ColorChangeSpeed = 1.0 })
end

function PulseShrineText( id, text, color )
	local scale = { 1.03, 0.99 }
	if string.match(GetDisplayName({Text = text}), "\\n") then
		scale = { 1.0, 1.0 }
	end
	ModifyTextBox({ Id = id, Color = Color.White, ScaleTarget = scale[1], ScaleDuration = 0.05, })
	wait( 0.05 )
	ModifyTextBox({ Id = id, Color = color, ScaleTarget = scale[2], ScaleDuration = 0.1, })
	wait( 0.1 )
	ModifyTextBox({ Id = id, Text = text, Color = color, ScaleTarget = 1.0, ScaleDuration = 0.4, ColorDuration = 0.4, ColorChangeSpeed = 1.0})
end

function SwitchWeaponImage( id, newImageName )
	SetAnimation({ DestinationId = id, Name = newImageName })
	CreateAnimation({ Name = "SwitchWeaponImageFlash", DestinationId = id, GroupName = "Combat_Menu_TraitTray_Additive" })
end

function UnlockMetaupgradeSwapPresentation( components )
	local buttonId = components.RefundButton.Id
	SetAlpha({ Id = buttonId, Fraction = 0.0, Duration = 0.0 })
	SetScale({ Id = buttonId, Fraction = 2.0, Duration = 0.0 })
	for k, upgradeName in pairs( GameState.MetaUpgradesSelected ) do
		if GameState.MetaUpgradesUnlocked[upgradeName] and components["Backing"..k.."Swap"] then
			local buttonId = components["Backing"..k.."Swap"].Id
			SetAlpha({ Id = buttonId, Fraction = 0.0, Duration = 0.0 })
			SetScale({ Id = buttonId, Fraction = 1.0, Duration = 0.0 })
		end
	end
	wait( 0.5 )
	SetScale({ Id = buttonId, Fraction = 1.0, Duration = 0.0 })
	for k, upgradeName in pairs( GameState.MetaUpgradesSelected ) do
		if GameState.MetaUpgradesUnlocked[upgradeName] and components["Backing"..k.."Swap"] then
			local buttonId = components["Backing"..k.."Swap"].Id
			SetScale({ Id = buttonId, Fraction = 1.0, Duration = 0.5, EaseIn = 0, EaseOut = 0.1 })
			SetAlpha({ Id = buttonId, Fraction = 1.0, Duration = 0.3 })
			PlaySound({ Name = "/SFX/Menu Sounds/ObjectiveActivateShk", Id = buttonId })
			wait( 0.1 )
		end
	end
	wait(0.1)
	local buttonId = components.RefundButton.Id
	SetScale({ Id = buttonId, Fraction = 1.0, Duration = 0.5, EaseIn = 0, EaseOut = 0.1 })
	SetAlpha({ Id = buttonId, Fraction = 1.0, Duration = 0.3 })
	PlaySound({ Name = "/SFX/Menu Sounds/ObjectiveActivateShk", Id = buttonId })
end

function MetaPointRoomRewardPresentation(gained)
	thread( MetaPointRoomRewardPresentationThread, gained )
end

function MetaPointRoomRewardPresentationThread(gained)
	wait(0.5)
	thread( InCombatText, CurrentRun.Hero.ObjectId, "MetaPointGain", 1.5 , { LuaKey = "TempTextData", LuaValue = {Number = gained} })
end

function GiftPointGainedPresentation( gained, args )
	PlaySound({ Name = "/Leftovers/Menu Sounds/GetBallMenu" })
	if not args.SkipOverheadText then
		thread( PopOverheadText, { Amount = gained, Text = "GiftAmount", Color = Color.BoonGift } )
	end
end

function GiftPointSpentPresentation( amount, args )
	DebugPrint({Text = "Spent " .. amount .. " gift points!" })
end

function GetGiftIcon( entryName, index, args )
	args = args or {}
	local forceLocked = args.ForceLocked or false
	local giftIconData = GiftIconData.GiftPoints
	if GiftData[entryName][index] and GiftData[entryName][index].RequiredResource and GiftIconData[GiftData[entryName][index].RequiredResource] then
		giftIconData = GiftIconData[GiftData[entryName][index].RequiredResource]
	end

	local name = giftIconData.FilledWithGift
	if forceLocked then
		return giftIconData.Locked
	end
	local completelyUnlocked = IsGiftBarCompletelyUnlocked( entryName )

	if GameState.Gift[entryName].Value >= index then
		if GiftData[entryName][index] ~= nil and GiftData[entryName][index].Gift  ~= nil then
			name = giftIconData.FilledWithGift
		else
			name = giftIconData.Filled
		end
	else
		if completelyUnlocked or GameState.Gift[entryName].Value == index - 1 then
			if index < GetLockedLevel( entryName ) then
				if GiftData[entryName][index] ~= nil and GiftData[entryName][index].Gift ~= nil then
					name = giftIconData.EmptyWithGift
				else
					name = giftIconData.Empty
				end
			else
				if GiftData[entryName].UnlockGameStateRequirements then
					name = giftIconData.Locked
				else
					name = giftIconData.Unavailable
				end
			end
		else
			if GameState.Gift[entryName].Value == index - 2 then
				name = giftIconData.Mystery
			else
				name = "Blank"
			end
		end
	end
	return name
end

function CreateGiftTrack( args )

	local entryName = args.Name
	local iconXSpacer = CodexUI.SpacerX
	local offsetX = args.LocationX or 0
	local offsetY = args.LocationY or 0
	local giftTrackIds = {}
	local includeDividers = args.IncludeDividers or true
	local returnDividerId = args.ReturnDividerId or false
	local group = args.GroupName or "Combat_Menu_Overlay"

	for i = 1, GiftData[entryName].Maximum do
		local giftIconData = GiftIconData.GiftPoints

		if GiftData[entryName][i] and GiftData[entryName][i].RequiredResource and GiftIconData[GiftData[entryName][i].RequiredResource] then
			giftIconData = GiftIconData[GiftData[entryName][i].RequiredResource]
		end
		local name = GetGiftIcon( entryName, i )
		
		local newIconId = CreateScreenComponent({ Name = "BlankObstacle", Group = group }).Id
		table.insert( giftTrackIds, newIconId)

		offsetX = offsetX + iconXSpacer
		SetAnimation({ Name = name, DestinationId = newIconId, Scale = 0.5, OffsetY = offsetY, OffsetX = offsetX })

		if includeDividers and GiftData[entryName][i] and GiftData[entryName][i].HeartDividerAfter and ( GameState.Gift[entryName].Value >= i or (GiftData[entryName].UnlockGameStateRequirements and IsGameStateEligible(CurrentRun, GiftData[entryName].UnlockGameStateRequirements ))) then
			offsetX = offsetX + iconXSpacer + 20
			
			if returnDividerId then
				local newIconId2 = CreateScreenComponent({ Name = "BlankObstacle", Group = group }).Id
				SetAnimation({ Name = "HeartDivider", DestinationId = newIconId2, OffsetY = offsetY, OffsetX = offsetX })
				table.insert( giftTrackIds, newIconId2)
			else
				CreateAnimation({ Name = "HeartDivider", DestinationId = newIconId, Scale = 1, OffsetY = offsetY, OffsetX = offsetX })
			end
			offsetX = offsetX + 20
		end
	end
	return giftTrackIds
end

function GiftTrackUnlockedPresentation( entryName )

	local giftData = GiftData[entryName]
	if not giftData then
		return
	end

	if giftData.TrackUnlockedBlockInput then
		AddInputBlock({ Name = "GiftTrackUnlockedPresentation" })
	end

	wait(0.5)
	SetAnimation({ Name = "AffinityGaugeBacking", DestinationId = backingId })

	local giftLength = giftData.Maximum
	local startY = -400
	local startX = giftLength * CodexUI.SpacerX * -0.5
	for key, value in pairs( giftData ) do
		if type(value) == "table" and value.HeartDividerAfter then
			startX = startX - ( 50 + CodexUI.SpacerX ) + CodexUI.SpacerX * 0.5
			break
		end
	end
	local xPosition = startX
	local backingStartYOffset = -325

	local backingId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu", X = ScreenCenterX , Y = ScreenCenterY + backingStartYOffset })
	SetAnimation({ Name = "AffinityGaugeBacking", DestinationId = backingId, Scale = 0.5 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })

	local createdIds = CreateGiftTrack({ Name = entryName, LocationX = startX, LocationY = startY, IncludeDividers = true, GroupName = "Combat_Menu" })

	for i, id in pairs( createdIds ) do
		SetAlpha({ Id = id, Fraction = 0, Duration = 0 })
		SetAlpha({ Id = id, Fraction = 1, Duration = 0.1 })
		xPosition = xPosition + CodexUI.SpacerX
		if i >= giftData.Locked then
			SetAnimation({ Name = GetGiftIcon( entryName, i, { ForceLocked = true }), DestinationId = createdIds[i], Scale = 0.5, OffsetY = startY, OffsetX = xPosition })
		end
		if GiftData[entryName][i] and GiftData[entryName][i].HeartDividerAfter then
			xPosition = xPosition + 40 + CodexUI.SpacerX
		end
	end

	xPosition = startX + ( giftData.Locked - 1 ) * CodexUI.SpacerX
	for i = giftData.Locked, giftLength do
		wait(0.35)
		xPosition = xPosition + CodexUI.SpacerX
		CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = createdIds[i], GroupName = "Overlay", OffsetX = xPosition, OffsetY = startY })
		SetAnimation({ Name = GetGiftIcon( entryName, i ), DestinationId = createdIds[i], Scale = 0.5, OffsetY = startY, OffsetX = xPosition})
		PlaySound({ Name = "/SFX/Menu Sounds/HeartSlotUnlock", Id = createdIds[i] })
		if GiftData[entryName][i] and GiftData[entryName][i].HeartDividerAfter then
			xPosition = xPosition + 40 + CodexUI.SpacerX
		end
	end

	waitScreenTime(1)
	for i, id in pairs( createdIds ) do
		SetAlpha({ Ids = id, Fraction = 0, Duration = 0.33 })
	end
	SetAnimation({ Name = "AffinityGaugeBackingFade", DestinationId = backingId })
	waitScreenTime(0.33)
	Destroy({ Ids = createdIds })
	Destroy({ Id = backingId })
	if giftData.TrackUnlockedBlockInput then
		RemoveInputBlock({ Name = "GiftTrackUnlockedPresentation" })
	end
end

function LockKeyGainedPresentation( gained, args )
	PlaySound({ Name = "/SFX/KeyPickup" })
	if not args.SkipOverheadText then
		thread( PopOverheadText, { Amount = gained, Text = "LockKeyAmount", Color = Color.White } )
	end
end

function LockKeySpentPresentation( amount )
	DebugPrint({ Text = "Spent " .. amount .. " lock keys!" })
end

function ReceivedGiftPresentation( npc, giftAnimation )
	PlaySound({ Name = "/Leftovers/SFX/StaminaRefilled" })
	if GetGiftLevel(npc.Name) == 0 then
		thread( PlayVoiceLines, HeroVoiceLines.GiftGivenVoiceLines, true )
	end
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = npc.ObjectId })
	SetAnimation({ Name = "ZagreusInteractEquip", DestinationId = CurrentRun.Hero.ObjectId })
	wait(0.30)
	thread( ReceivedGiftPresentationHearts, npc, giftAnimation )
	wait(0.85)
end

function ReceivedGiftPresentationPost( npc )
	thread( PopOverheadText, { TargetId = npc.ObjectId, Amount = 1, Text = "HeartAmount", Color = Color.White, OffsetY = -20, HoldDuration = 1.25 } )
	PlaySound({ Name = "/SFX/Menu Sounds/HeartGained", Id = npc.ObjectId })
end

function ReceivedGiftPresentationHearts( npc, giftAnimation )
	local giftOffsetZ = 100
	if npc.AnimOffsetZ ~= nil then
		giftOffsetZ = npc.AnimOffsetZ + 80
	end
	CreateAnimation({ DestinationId = npc.ObjectId, Name = giftAnimation, OffsetY = -giftOffsetZ })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteAffection", Id = npc.ObjectId })
end

function PlayerReceivedGiftPresentation( npc, giftName )
	AdjustColorGrading({ Name = "Mythmaker", Duration = 0.66 })
	AdjustColorGrading({ Name = "Off", Duration = 1.0, Delay = 1.0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/StarSelectConfirm" })

	thread( PlayVoiceLines, npc.GiftGivenVoiceLines, true )
	thread( PlayVoiceLines, CurrentRun.Hero.GiftReceivedVoiceLines, true )
	local npcName = npc.Name
	DisplayUnlockText({
		Icon = TraitData[giftName].Icon,
		IconScale = 1.0,
		IconMoveSpeed = 0.0001,
		IconOffsetY = 0,
		HighlightIcon = true,
		TitleText = "NewTraitUnlocked_Title",
		AnimationName = "LocationTextBGRelationship",
		AnimationOutName = "LocationTextBGRelationshipOut",
		SubtitleText = "NewTraitUnlocked_Subtitle",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = { Name = npcName, Gift = giftName }},
	})

end

function WeaponUnlockedPresentation( weaponName )

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.4 }, } )
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	DisplayUnlockText({
		TitleText = "WeaponUnlocked_Title",
		SubtitleText = "WeaponUnlocked_Subtitle",
		SubtitleData = { LuaKey = "TempTextData", LuaValue = { Name = weaponData.UnlockName or weaponName }},
		FontScale = 0.85,
		AnimationName = "LocationTextBGGeneric_WeaponUnlock",
		AnimationOutName = "LocationTextBGGenericOut_WeaponUnlock"
	})

end

function RangedFailedNoAmmoPresentation()
	thread( UpdateAmmoUI )
	thread(PulseText, { ScreenAnchorReference = "AmmoIndicatorUI", Color = Color.White, OriginalColor = Color.Red, ScaleTarget = 1.5, ScaleDuration = 0.1, HoldDuration = 0.05, PulseBias = 0.1 })
end

function RangedLastAmmoPresentation()
	thread( UpdateAmmoUI )
	ModifyTextBox({ ScreenAnchorReference = "AmmoIndicatorUI", ColorTarget = Color.Red, ColorDuration = 0, AutoSetDataProperties = false, })
end

function ReloadAmmoPresentation()
	thread( UpdateAmmoUI )

	CreateAnimation({ Name = "QuickFlashRedSmall", DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = -90 })

	if ScreenAnchors.AmmoIndicatorUI ~= nil then
		ModifyTextBox({ Id = ScreenAnchors.AmmoIndicatorUI, ColorTarget = Color.White, ColorDuration = 0.5, AutoSetDataProperties = false, })
		thread( PulseText, { ScreenAnchorReference = "AmmoIndicatorUI", ScaleTarget = 1.3, ScaleDuration = 0.125, HoldDuration = 0.1, PulseBias = 0.2 } )
	end
end

function AddAmmoPresentation()
	thread( UpdateAmmoUI )

	CreateAnimation({ Name = "QuickFlashRedSmall", DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = -90 })

	if ScreenAnchors.AmmoIndicatorUI ~= nil then
		ModifyTextBox({ Id = ScreenAnchors.AmmoIndicatorUI, ColorTarget = Color.White, ColorDuration = 0.5, AutoSetDataProperties = false, })
		thread( PulseText, { ScreenAnchorReference = "AmmoIndicatorUI", ScaleTarget = 1.3, ScaleDuration = 0.125, HoldDuration = 0.1, PulseBias = 0.2 } )
	end
end

function AltWeaponFailedToFirePresentation()
	thread( FlashWeaponCooldown )
end

function FlashWeaponCooldown()

	if ScreenAnchors.MainWeaponCooldownDisplay == nil then
		return
	end
	SetColor({Id = ScreenAnchors.MainWeaponCooldownDisplay, Color = Color.Red, Duration = 0})

	PulseAnimation({ Id = ScreenAnchors.MainWeaponCooldownDisplay, ScaleTarget=1.1, ScaleDuration = 0.05, HoldDuration = 0.0, PulseBias = 0.01})
	wait(0.06)
	SetColor({Id = ScreenAnchors.MainWeaponCooldownDisplay, Color = Color.White, Duration = 0.02})
end

function ActivateTempInvulnerabilityPresentation()
	if ScreenAnchors.ShieldHitAnchor ~= nil then
		return
	end
	ScreenAnchors.ShieldHitAnchor = SpawnObstacle({ Name = "BlankGeoObstacle", Group = "Standing", DestinationId =  CurrentRun.Hero.ObjectId })
	Attach({ Id = ScreenAnchors.ShieldHitAnchor, DestinationId = CurrentRun.Hero.ObjectId })
	SetAnimation({ Name = "Invincibubble_Zag_Loop", DestinationId = ScreenAnchors.ShieldHitAnchor })
end

function DisableTempInvulnerabilityPresentation( delay )
	-- Shake({ Id = ScreenAnchors.ShieldHitAnchor, Distance = 4, Speed = 300, Duration = delay })
	-- wait(delay)
	SetAnimation({Name = "InvincibubbleOut_Zag", DestinationId = ScreenAnchors.ShieldHitAnchor })
	CreateAnimation({Name = "InvincibubbleShieldPop", DestinationId = ScreenAnchors.ShieldHitAnchor })
	wait(0.1)
	Destroy({ Id = ScreenAnchors.ShieldHitAnchor })
	ScreenAnchors.ShieldHitAnchor = nil
end

function HeroDamagePresentation( args, sourceWeaponData )
	local currentHealthFraction = (CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth)

	local rapidDamage = false
	if ((sourceWeaponData ~= nil and sourceWeaponData.RapidDamageType) or ( args.EffectName ~= nil and EffectData[args.EffectName] and EffectData[args.EffectName].RapidDamageType)) and not CheckCooldown( "RapidDamage", 0.6 ) then
		rapidDamage = true
	end
	args.PercentMaxDealt = args.DamageAmount / CurrentRun.Hero.MaxHealth

	thread( DisplayPlayerDamageText, args )
	if args ~= nil then
		if currentHealthFraction <= 0 then
			thread( HeroFinalDamagePresentationThread, args, sourceWeaponData )
		elseif not rapidDamage then
			if args.PercentMaxDealt > HealthUI.MajorHitThreshold then
				thread( HeroMajorDamagePresentationThread, args, sourceWeaponData )
			elseif args.HitArmor then
				thread( HeroArmorDamagePresentationThread, args, sourceWeaponData )
			else
				thread( HeroDamagePresentationThread, args, sourceWeaponData )
			end
		end
	end

	if not rapidDamage then
		if CurrentRun.Hero.Health <= GetLowHealthUIThreshold( CurrentRun.Hero.MaxHealth ) then
			HeroDamageLowHealthPresentation()
		else
			ModifyTextBox({ Id = ScreenAnchors.HealthBack, ColorTarget = Color.Red, ColorDuration = 0, AutoSetDataProperties = false })
			ModifyTextBox({ Id = ScreenAnchors.HealthBack, ColorTarget = Color.White, ColorDuration = 0.2, AutoSetDataProperties = false })
		end
		thread( PulseText, { ScreenAnchorReference = "HealthBack", ScaleTarget = 1.25, ScaleDuration = 0.15, HoldDuration = 0.0, PulseBias = 0} )
	end

	local victim = args.TriggeredByTable or CurrentRun.Hero
	local attacker = args.AttackerTable

	if not rapidDamage and victim.DamagedSound ~= nil and not victim.Mute then
		PlaySound({ Name = victim.DamagedSound, Id = victim.ObjectId })
	end
end

function HeroDamagePresentationThread( args, sourceWeaponData )
	Shake({ Id = args.triggeredById, Distance = 4, Speed = 800, Duration = 0.14 })
	Flash({ Id = args.triggeredById, Speed = 2.65, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.Red, Duration = 0.2, ExpireAfterCycle = true })
	CreateAnimation({ Name = "BloodFrame", UseScreenLocation = true, OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, GroupName = "Vignette", Duration = args.BloodFrameDuration or 0.3 })
	thread( DoRumble, CurrentRun.Hero.HeroHitRumbleParameters )
	if args ~= nil and sourceWeaponData ~= nil then
		thread( DoWeaponHitSimulationSlow, args )
		thread( DoWeaponScreenshake, sourceWeaponData.HitScreenshake, args.triggeredById, args.SourceProjectile, args.EffectName )
		if sourceWeaponData.OnHitCrowdReaction ~= nil then
			thread( CrowdReactionPresentation, sourceWeaponData.OnHitCrowdReaction )
		end
	end
end

function HeroArmorDamagePresentationThread( args, sourceWeaponData )
	Shake({ Id = args.triggeredById, Distance = 2, Speed = 800, Duration = 0.7 })
	Flash({ Id = args.triggeredById, Speed = 0.65, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Yellow, Duration = 0.2, ExpireAfterCycle = true })
	CreateAnimation({ Name = "BloodFrame", UseScreenLocation = true, OffsetX = ScreenCenterX, OffsetY = ScreenCenterY, Duration = args.BloodFrameDuration or 0.3 })
	thread( DoRumble, CurrentRun.Hero.HeroHitRumbleParameters )
	if args ~= nil and sourceWeaponData ~= nil then
		thread( DoWeaponHitSimulationSlow, args )
		thread( DoWeaponScreenshake, sourceWeaponData.HitScreenshake, args.triggeredById, args.SourceProjectile, args.EffectName )
		if sourceWeaponData.OnHitCrowdReaction ~= nil then
			thread( CrowdReactionPresentation, sourceWeaponData.OnHitCrowdReaction )
		end
	end
end

function HeroFinalDamagePresentationThread( args, sourceWeaponData )

end

function HeroMajorDamagePresentationThread( args, sourceWeaponData )

	args.BloodFrameDuration = 1.0
	thread(HeroDamagePresentationThread, args, sourceWeaponData)
	thread(PulseAnimation, { Id = ScreenAnchors.HealthFill, ScaleTarget = 1.1, ScaleDuration = 0.1, HoldDuration = 0.01, PulseBias = 0.1 })
	thread(PulseAnimation, { Id = ScreenAnchors.HealthBack, ScaleTarget = 1.1, ScaleDuration = 0.1, HoldDuration = 0.01, PulseBias = 0.1 })

	thread( DoRumble, CurrentRun.Hero.HeroMajorHitRumbleParameters )
end

function DisplayPlayerDamageText( args )

	if not ConfigOptionCache.ShowDamageNumbers then
		return
	end

	local objectId = args.triggeredById
	local amount = args.DamageAmount
	local isCritical = args.IsCrit
	local hitVulnerable = args.HitVulnerability
	local sourceId = args.AttackerId

	local sizeAdjust = math.max( args.PercentMaxDealt / HealthUI.MajorHitThreshold * 2, 1 )
	local roundedAmount = round( amount )
	local damageTextAnchor = SpawnObstacle({ Name = "BlankObstacleNoTimeModifier", DestinationId = objectId, Group = "Overlay", OffsetX = 0, OffsetY = -180 })

	local randomFontSize = RandomInt( 170, 180 )
	local holdDuration = 0.4
	if HasStoredAmmoVulnerabilityMultiplier( args.TriggeredByTable, args.AttackerTable) then
		CreateTextBox({
			Id = damageTextAnchor,
			Text = "CombatDamageVulnerable",
			Justification = "CENTER",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = {255,0,0,255},
			Font = "AlegreyaSansSCBold",
			FontSize = randomFontSize,
			OffsetY = 85,
			OffsetX = 80,
			Scale = 0.8 * sizeAdjust,
			ScaleTarget = 0.8,
			LuaKey = "TempTextData",
			LuaValue = {Amount = roundedAmount},
			AutoSetDataProperties = false,
		})
		holdDuration = 0.6
	elseif args.HitArmor then
		CreateTextBox({
			Id = damageTextAnchor,
			Text = "CombatDamageShielded",
			Justification = "CENTER",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = {255,0,0,255},
			Font = "AlegreyaSansSCBold",
			FontSize = randomFontSize,
			OffsetY = 85,
			OffsetX = 80,
			Scale = 0.6 * sizeAdjust,
			ScaleTarget = 0.6,
			LuaKey = "TempTextData",
			LuaValue = {Amount = roundedAmount},
			AutoSetDataProperties = false,
		})
	elseif args.UseCustomText then
		CreateTextBox({
			Id = damageTextAnchor,
			Text = args.UseCustomText,
			Justification = "CENTER",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = {255,0,0,255},
			Font = "AlegreyaSansSCBold",
			FontSize = randomFontSize,
			OffsetY = 85,
			OffsetX = 80,
			Scale = 0.8 * sizeAdjust,
			ScaleTarget = 0.8,
			LuaKey = "TempTextData",
			LuaValue = {Amount = roundedAmount},
			AutoSetDataProperties = false,
		})
		holdDuration = 0.6
	elseif isCritical then
		
		CreateTextBox({
			Id = damageTextAnchor,
			Text = "CombatDamageVulnerable",
			Justification = "CENTER",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = {255,0,0,255},
			Font = "AlegreyaSansSCBold",
			FontSize = randomFontSize,
			OffsetY = 85,
			OffsetX = 80,
			Scale = 0.8 * sizeAdjust,
			ScaleTarget = 0.8,
			LuaKey = "TempTextData",
			LuaValue = {Amount = roundedAmount},
			AutoSetDataProperties = false,
		})
		holdDuration = 0.6
	else
		CreateTextBox({
			Id = damageTextAnchor,
			RawText = roundedAmount,
			Justification = "CENTER",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 3},
			OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
			Color = {255,0,0,255},
			Font = "AlegreyaSansSCBold",
			FontSize = randomFontSize,
			OffsetY = 85,
			OffsetX = 80,
			Scale = 0.6 * sizeAdjust,
			ScaleTarget = 0.6,
			AutoSetDataProperties = false,
		})
	end




	waitScreenTime(0.1)

	local randomOffsetX = RandomInt( -30, 30 )
	Shift({ Id = damageTextAnchor, OffsetX = randomOffsetX, OffsetY = -100, Duration = 0.5, EaseIn = 0.99, EaseOut = 1.0, TimeModifierFraction = 0.0 })
	ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 0.3, ScaleDuration = 0.15, ColorTarget = {254,0,0,255}, ColorDuration = 1.0, AutoSetDataProperties = false })
	waitScreenTime(holdDuration)
	ModifyTextBox({ Id = damageTextAnchor, FadeTarget = 0.0, FadeDuration = 0.05, AutoSetDataProperties = false })
	waitScreenTime(0.25)
	Destroy({ Ids = { damageTextAnchor } })

end

function HeroDamageLowHealthPresentation( skipStartPresentation )
	thread(HeroLowHealthPresentationThread, skipStartPresentation )
	thread(HeroLowHealthShroudPulseThread)
	thread(HeroLowHealthBarPulseThread)
end

function StartHeroLowHealthPresentation()
	PlaySound({ Name = "/SFX/LowHealthShroudAppear" })
end

function HeroLowHealthPresentationThread( skipStartPresentation )
	if GameState.HealthUI.LowHealthPresentation then
		return
	end
	if not skipStartPresentation then
		StartHeroLowHealthPresentation()
	end
	GameState.HealthUI.LowHealthPresentation = true
	while CurrentRun.Hero.Health <= GetLowHealthUIThreshold() and not IsScreenOpen("RunClear") and not CurrentRun.Hero.IsDead and CurrentRun.CurrentRoom.Encounter and ( not CurrentRun.CurrentRoom.Encounter.Completed or ( CurrentRun.CurrentRoom.ChallengeEncounter ~= nil and CurrentRun.CurrentRoom.ChallengeEncounter.InProgress )) do
		wait(1)
	end
	GameState.HealthUI.LowHealthPresentation = false
end

function HeroLowHealthBarPulseThread()
	if GameState.HealthUI.LowHealthBarPulsing then
		return
	end
	GameState.HealthUI.LowHealthBarPulsing = true
	while GameState.HealthUI.LowHealthPresentation and not CurrentRun.Hero.IsDead do
		if ScreenAnchors.HealthBack ~= nil and not CombatUI.Hiding then
			CreateAnimation({ Name = "HealthBarLowPulseA", DestinationId = ScreenAnchors.HealthBack, GroupName = "Combat_UI_Additive" })
			ModifyTextBox({ Id = ScreenAnchors.HealthBack, ColorTarget = Color.Red, ColorDuration = 0.5 })
			PulseText({ ScreenAnchorReference = "HealthBack", ScaleTarget = 1.25, ScaleDuration = 0.1, HoldDuration = 0.0, PulseBias = 0.02})
		end
		wait( 0.15, RoomThreadName )
		if ScreenAnchors.HealthBack ~= nil and not CombatUI.Hiding then
			CreateAnimation({ Name = "HealthBarLowPulseB", DestinationId = ScreenAnchors.HealthBack, GroupName = "Combat_Menu_Overlay" })
			PulseText({ ScreenAnchorReference = "HealthBack", ScaleTarget = 1.15, ScaleDuration = 0.15, HoldDuration = 0.05, PulseBias = 0.3})
		end
		wait( 1.5, RoomThreadName )
	end
	if ScreenAnchors.HealthBack ~= nil then
		ModifyTextBox({ Id = ScreenAnchors.HealthBack, ColorTarget = Color.White, ColorDuration = 0.5 })
	end
	GameState.HealthUI.LowHealthBarPulsing = false
end

function HeroTraitTransformPresentation( expiringTrait )
	wait(1)
	if CheckCooldown( "ChaosBoonTransformed", 5 ) then
		CreateAnimation({ Name = "ChaosShiftFx", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
		thread( PlayVoiceLines, HeroVoiceLines.TrialUpgradeTransformedVoiceLines, true )
		ShakeScreen({ Speed = 500, Distance = 4, Duration = 0.3 })
		AdjustColorGrading({ Name = expiringTrait.ColorGrade or "Team02", Duration = 0.2 })
		wait(0.25)
		AdjustColorGrading({ Name = "Off", Duration = 0.5 })
	end
end

function KeepsakeLevelUpPresentation( traitName )
	wait(1.25)
	local existingTraitData = GetExistingUITraitName( traitName )
	if existingTraitData ~= nil and existingTraitData.AnchorId ~= nil then
		CreateAnimation({ Name = "KeepsakeSparkleEmitter", DestinationId = existingTraitData.AnchorId, GroupName = "Overlay" })
		PlaySound({ Name = existingTraitData.EquipSound or "/Leftovers/Menu Sounds/TalismanPowderDownLEGENDARY", Id = CurrentRun.Hero.ObjectId })
	end
	CreateAnimation({ Name = "KeepsakeLevelUpFlare", DestinationId = CurrentRun.Hero.ObjectId, Scale = 1.0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement", Id = CurrentRun.Hero.ObjectId })
	thread( InCombatText, CurrentRun.Hero.ObjectId, "KeepsakeAdvance", 2.0 , { ShadowScaleX = 1.35, LuaKey = "TempTextData", LuaValue = { Name = tostring(traitName) } })
end

function HeroLowHealthShroudPulseThread()
	if GameState.HealthUI.LowHealthShouldPulsing then
		return
	end
	GameState.HealthUI.LowHealthShouldPulsing = true
	while GameState.HealthUI.LowHealthPresentation and not CurrentRun.Hero.IsDead do
		if CurrentRun.CurrentRoom.Encounter and ( not CurrentRun.CurrentRoom.Encounter.Completed or ( CurrentRun.CurrentRoom.ChallengeEncounter ~= nil and CurrentRun.CurrentRoom.ChallengeEncounter.InProgress )) then
			CreateHealthShroud()
		else
			DestroyHealthShroud()
		end
		-- how often to check health shroud status
		wait(1)
	end
	DestroyHealthShroud()
	GameState.HealthUI.LowHealthShouldPulsing = false
end

function ChillApplyPresentation( victim, victimId, chillStacks )
	if chillStacks == 1 then
		SetHSV({ Id = victimId or victim.ObjectId, HSV = { 0, -0.4, -0.1 }, ValueChangeType = "Add" })
	end
	if victim then
		-- tetherIds have no health bar to update
		UpdateChillEffectStacks( victim, victimId, chillStacks )
	end
	SetColor({ Id = victimId or victim.ObjectId, Color = { 8/10 * chillStacks, 48/10 * chillStacks , 130/10 * chillStacks, 255 }, Duration = 0.125 })
	SetThingProperty({ Property = "AddColor", Value = true, DestinationId = victimId or victim.ObjectId })
	if victim ~= nil and victim.TetherIds ~= nil then
		for k, tetherId in ipairs( victim.TetherIds ) do
			ChillApplyPresentation( nil, tetherId, chillStacks )
		end
	end
end

function ChillClearPresentation( victim, victimId )
	if victim == nil or ((not victim.IsDead and (victim.Health or 0) > 0) or victim.ClearChillOnDeath) then
		ClearChillEffectStacks( victimId )
		SetHSV({ Id = victimId or victim.ObjectId, HSV = { 0, 0.4, 0.1 }, ValueChangeType = "Add" })
		SetColor({ Id = victimId or victim.ObjectId, Color = { 255, 255, 255, 255 }, Duration = 0.125 })
		SetThingProperty({ Property = "AddColor", Value = false, DestinationId = victimId or victim.ObjectId })
		if victim ~= nil and victim.TetherIds ~= nil then
			for k, tetherId in ipairs( victim.TetherIds ) do
				ChillClearPresentation( nil, tetherId )
			end
		end
	end
end

function FrozenPresentation( victim )
	Shake({ Id = victim.ObjectId, Distance = 2, Speed = 100, Duration = 0.5 })
	thread( DisplayFreezeEscapeHint, victim )
	if victim.Frozen then
		-- Already frozen
		return
	end
	SetHSV({ Id = victim.ObjectId, HSV = { 0, -1, 0 }, ValueChangeType = "Add" })
	SetColor({ Id = victim.ObjectId, Color = { 128, 128, 128, 255 }, Duration = 0.125 })
	if not victim.IgnoreFrozenAnimFreeze then
		SetThingProperty({ Property = "AnimFreeze", Value = true, DestinationId = victim.ObjectId, DataValue = false })
	end
	CreateAnimation({ Name = "UnitFrozenFx", DestinationId = victim.ObjectId, Group = "Overlay" })
	PlaySound({ Name = "/SFX/PetrificationStart", Id = victim.ObjectId })
	if victim.FrozenSound ~= nil then
		PlaySound({ Name = victim.FrozenSound, Id = victim.ObjectId })
	end
end

function UnfrozenPresentation( victim, args )
	args = args or {}
	Flash({ Id = victim.ObjectId, Speed = 6, MinFraction = 0, MaxFraction = 1, Color = Color.White, ExpireAfterCycle = true })
	SetHSV({ Id = victim.ObjectId, HSV = { 0, 1, 0 }, ValueChangeType = "Add" })
	SetColor({ Id = victim.ObjectId, Color = { 255, 255, 255, 255 }, Duration = 0.125 })
	SetThingProperty({ Property = "AnimFreeze", Value = false, DestinationId = victim.ObjectId, DataValue = false })
	if args.SkipPresentation then
		return
	end
	if victim.UnfreezeAnimation ~= nil then
		SetAnimation({ Name = victim.UnfreezeAnimation, DestinationId = victim.ObjectId })
	end
	StopAnimation({ Name = "UnitFrozenFx", DestinationId = victim.ObjectId })
	CreateAnimation({ Name = "UnitUnfrozen", DestinationId = victim.ObjectId })
	PlaySound({ Name = "/SFX/PetrificationFree", Id = victim.ObjectId })
	if victim.UnFrozenSound ~= nil then
		PlaySound({ Name = victim.UnFrozenSound, Id = victim.ObjectId })
	end
end

function FreezeEscapeInputPresentation( victim )
	Shake({ Id = victim.ObjectId, Distance = 2, Speed = 300, Duration = 0.2 })
	CreateAnimation({ Name = "PetrifyCrumble", DestinationId = victim.ObjectId,  })
	PlaySound({ Name = "/SFX/PetrificationStruggle", Id = victim.ObjectId })
end

function DisplayFreezeEscapeHint( victim )
	if victim ~= CurrentRun.Hero then
		return
	end
	wait(1.5)
	if victim.FreeEscapeAttempts >= 3 then
		return
	end

	if CheckCooldown("FreezeEscapeHint", 2.0) and HasEffect({ Id = victim.ObjectId, EffectName = "FreezeStun" }) then
		thread( InCombatText, victim.ObjectId, "PlayerUnitFrozen", 1.75 )
	end
end

function TraitAcquiredPresentation( traitAnchorId )
	thread( PulseAnimation, {Id = traitAnchorId, ScaleTarget = 1.25, ScaleDuration = 0.2, HoldDuration = 0.01, PulseBias = 0.1} )
	Flash({ Id = traitAnchorId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, ExpireAfterCycle = true })
	CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = traitAnchorId, GroupName = "Overlay" })
end

function NewTraitAcquiredPresentation( traitAnchorId )
end

function DuplicateTraitAcquiredPresentation( traitAnchorId )
end

function TraitSacrificedPresentation( traitData )
	if traitData == nil or not traitData.AnchorId then
		return
	end

	local sacrificeIcon = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay" })
	Teleport({ Id = sacrificeIcon.Id, DestinationId = traitData.AnchorId })
	SetAnimation({ Name = GetTraitIcon(traitData), DestinationId = sacrificeIcon.Id, Group = "Combat_Menu_Overlay" })

	local sacrificeFrame = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay" })
	SetAnimation({ DestinationId = sacrificeFrame.Id, Name = "BoonIcon_Frame_".. (traitData.Rarity or "Common")})
	Attach({ Id = sacrificeFrame.Id, DestinationId = sacrificeIcon.Id})

	wait(1.2, RoomThreadName)

	CreateAnimation({ Name = "TraitUpdate", DestinationId = sacrificeIcon.Id, GroupName = "Combat_Menu_Additive" })
	if traitData.Icon then
		SetAnimation({ DestinationId = sacrificeIcon.Id, Name = traitData.Icon .. "_Small" })
	end

	local fadeDuration = 1
	SetScale({ Id = sacrificeIcon.Id, Fraction = 0, Duration = fadeDuration, })
	SetColor({ Id = sacrificeIcon.Id, Color = Color.TransparentRed, Duration = fadeDuration, EaseOut = 1})
	SetColor({ Id = sacrificeFrame.Id, Color = Color.TransparentRed, Duration = fadeDuration, EaseOut = 1})
	wait(fadeDuration, RoomThreadName)
	Destroy({ Ids = { sacrificeIcon.Id, sacrificeFrame.Id }})
end

function TraitLockedPresentation( args )
	local purchaseButtonKey = args.Id
	local offsetX = args.OffsetX
	local offsetY = args.OffsetY
	local components = args.Components
	components[purchaseButtonKey.."Lock"] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Overlay", X = offsetX, Y = offsetY })
	wait(0.25)

	PlaySound({ Name = "/Leftovers/Menu Sounds/TitanToggleLong" })

	if components[purchaseButtonKey.."Patch"] then
		SetColor({ Id = components[purchaseButtonKey.."Patch"].Id, Color = Color.DimGray })
	end

	SetAnimation({ DestinationId = components[purchaseButtonKey.."Lock"].Id, Name = "BoonSlotLocked" })
end

function CannotUseDoorPresentation( door )
	local text = door.CannotUseText
	local voiceLines = door.ExitBlockedVoiceLines or HeroVoiceLines.InteractionBlockedVoiceLines

	if not IsEmpty( RequiredKillEnemies ) then
		text = "ExitBlockedByEnemies"
		voiceLines = HeroVoiceLines.ExitBlockedByEnemiesVoiceLines
		--for id, blockedByEnemy in pairs( RequiredKillEnemies ) do
			--DebugPrint({ Text = "blockedByEnemy = "..GetTableString( nil, blockedByEnemy ) })
		--end
	else
		for objectId, objectTable in pairs( ActivatedObjects ) do
			if objectTable.BlockExitText ~= nil then
				text = objectTable.BlockExitText
				thread( DirectionHintPresentation, objectTable )
			end
		end

		if text == nil then
			local failedRequirement = CheckSpecialDoorRequirement( door )
			if failedRequirement ~= nil then
				text = failedRequirement
				if failedRequirement == "ExitBlockedByShrinePointReq" then
					voiceLines = door.ExitBlockedByShrinePointsVoiceLines
					PulseActiveShrinePoints()
				elseif failedRequirement == "ExitBlockedByHealthReq" or failedRequirement == "ExitBlockedByMaxHealthReq" then
					voiceLines = HeroVoiceLines.ExitBlockedByHealthVoiceLines
				end
			end
		end
	end

	if text == nil then
		text = "ExitNotActive"
	end

	if CheckCooldown( "DoorLocked", 1.0 ) then
		PlaySound({ Name = door.LockedUseSound or RoomData.BaseRoom.LockedUseSound, Id = door.ObjectId })
		thread( PlayVoiceLines, voiceLines, true )
		thread( InCombatText, CurrentRun.Hero.ObjectId, text, 1.5, { ShadowScale = 0.66 } )
	end
end

function CannotUseRackPresentation( rackId )
	Shake({ Id = rackId, Distance = 1, Speed = 300, Duration = 0.2 })
	PlaySound({ Name = RoomData.BaseRoom.LockedUseSound, Id = rackId })
	thread( PlayVoiceLines, HeroVoiceLines.GiftRackLockedVoiceLines, true )
	if CheckCooldown( "RackLocked", 1.0 ) then
		thread( InCombatText, CurrentRun.Hero.ObjectId, "AwardMenuLocked", 2.0 )
	end
end

function BlockedKeepsakePresentation( screen, button )
	Shake({ Id = button.Id, Distance = 3, Speed = 1000, Duration = 0.2 })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = button.Id })
	if CheckCountInWindow( "KeepsakeBlocked", 1.0, 2 ) then
		thread( PlayVoiceLines, HeroVoiceLines.CannotSwitchKeepsakeVoiceLines, true )
	end
end

function DirectionHintPresentation( goal )

	if CheckCooldown( "DirectionHint", 0.75 ) then

		wait( 0.5, RoomThreadName )
		if not IsAlive({ Id = goal.ObjectId }) then
			return
		end

		local indicatorId = SpawnObstacle({ Name = "DirectionHintArrow", Group = "FX_Standing_Add", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0, OffsetZ = 0 })
		AdjustZLocation({ Id = indicatorId, Distance = 100 })
		SetScale({ Id = indicatorId, Fraction = 2.0 })
		local angle = GetAngleBetween({ Id = CurrentRun.Hero.ObjectId, DestinationId = goal.ObjectId })
		SetAngle({ Id = indicatorId, Angle = angle })
		local moveDuration = 1
		Move({ Id = indicatorId, DestinationId = goal.ObjectId, Duration = moveDuration, SmoothStep = true })
		PlaySound({ Name = "/Leftovers/SFX/PowerUpFwoosh", id = indicatorId })

		wait( moveDuration, RoomThreadName )

		Destroy({ Id = indicatorId })

	end

end

function CannotDecrementMetaUpgradePresentation( costTextboxId )

	local screen = ScreenAnchors.LevelUpScreen or ScreenAnchors.ShrineScreen
	if not screen then
		return
	end

	if CheckCooldown( "BlockedByHardMode", 1.45 ) then
		thread( InCombatTextArgs, { ShadowScaleX = 1.2, TargetId = costTextboxId, Text = "BlockedByHardMode", Duration = 1.3, Group = "Overlay", ScreenSpace = true, OffsetX = 745, OffsetY = -160 } )
	end

	if CheckCountInWindow( "BlockedByHardMode", 1.0, 2 ) then
		thread( PlayVoiceLines, HeroVoiceLines.ShrineUpgradeHardModeRestrictionVoiceLines, true )
	end

	PlaySound({ Name = "/SFX/Menu Sounds/MirrorCannotUpgrade" })
	thread(PulseText, { Id = costTextboxId, ScaleTarget = 1.5, ScaleDuration = 0.25, HoldDuration = 0, PulseBias = 0.1 })
	thread(PulseText, { Id = screen.Components.SubTitle.Id, ScaleTarget = 1.1, ScaleDuration = 0.25, HoldDuration = 0, PulseBias = 0.1 })
	ModifyTextBox({ Id = costTextboxId, ColorTarget = Color.MetaUpgradePointsInvalidPulseColor, ColorDuration = 0.0})
	ModifyTextBox({ Id = screen.Components.SubTitle.Id, ColorTarget = Color.MetaUpgradePointsInvalidPulseColor, ColorDuration = 0.0})
	wait(0.1)
	ModifyTextBox({ Id = costTextboxId, ColorTarget = Color.MetaUpgradePointsInvalid, ColorDuration = 0.8})
	ModifyTextBox({ Id = screen.Components.SubTitle.Id, ColorTarget = Color.MetaUpgradePointsDisplay, ColorDuration = 0.8})

end

function CannotAffordMetaUpgradePresentation( costTextboxId )
	local screen = ScreenAnchors.LevelUpScreen or ScreenAnchors.ShrineScreen
	if not screen then
		return
	end
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorCannotUpgrade" })
	thread(PulseText, { Id = costTextboxId, ScaleTarget = 1.5, ScaleDuration = 0.25, HoldDuration = 0, PulseBias = 0.1 })
	thread(PulseText, { Id = screen.Components.SubTitle.Id, ScaleTarget = 1.1, ScaleDuration = 0.25, HoldDuration = 0, PulseBias = 0.1 })
	thread( PlayVoiceLines, screen.CannotAffordVoiceLines, true )
	ModifyTextBox({ Id = costTextboxId, ColorTarget = Color.MetaUpgradePointsInvalidPulseColor, ColorDuration = 0.0})
	ModifyTextBox({ Id = screen.Components.SubTitle.Id, ColorTarget = Color.MetaUpgradePointsInvalidPulseColor, ColorDuration = 0.0})
	wait(0.1)
	ModifyTextBox({ Id = costTextboxId, ColorTarget = Color.MetaUpgradePointsInvalid, ColorDuration = 0.8})
	ModifyTextBox({ Id = screen.Components.SubTitle.Id, ColorTarget = Color.MetaUpgradePointsDisplay, ColorDuration = 0.8})
end

function MetaUpgradeIneligiblePresentation( screen, button, upgradeData )
	if CheckCountInWindow( "ShrineUpgradeChange", 0.5, 2 ) then
		thread( PlayVoiceLines, HeroVoiceLines.ShrineUpgradeLockedVoiceLines, true )
	end
end

function MetaUpgradeAtMaxPresentation( costTextboxId )
	local screen = ScreenAnchors.LevelUpScreen or ScreenAnchors.ShrineScreen
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorCannotUpgrade" })
	thread(PulseText, { Id = costTextboxId, ScaleTarget = 1.5, ScaleDuration = 0.25, HoldDuration = 0, PulseBias = 0.1 })
	thread(PulseText, { Id = screen.Components.SubTitle.Id, ScaleTarget = 1.1, ScaleDuration = 0.25, HoldDuration = 0, PulseBias = 0.1 })
	if CheckCountInWindow( "MaxButtonPress", 1.0, 2 ) then
		if screen == ScreenAnchors.LevelUpScreen then
			thread( PlayVoiceLines, HeroVoiceLines.MetaUpgradeAtMaxVoiceLines, true )
		else
			thread( PlayVoiceLines, HeroVoiceLines.ShrineUpgradeAtMaxVoiceLines, true )
		end
	end
	ModifyTextBox({ Id = costTextboxId, ColorTarget = Color.MetaUpgradePointsInvalidPulseColor, ColorDuration = 0.0})
	ModifyTextBox({ Id = screen.Components.SubTitle.Id, ColorTarget = Color.MetaUpgradePointsInvalidPulseColor, ColorDuration = 0.0})
	wait(0.1)
	ModifyTextBox({ Id = costTextboxId, ColorTarget = Color.MetaUpgradePointsInvalid, ColorDuration = 0.8})
	ModifyTextBox({ Id = screen.Components.SubTitle.Id, ColorTarget = Color.MetaUpgradePointsDisplay, ColorDuration = 0.8})
end

function MetaUpgradesAtGlobalCapPresentation( costTextboxId )
	local screen = ScreenAnchors.LevelUpScreen or ScreenAnchors.ShrineScreen
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorCannotUpgrade" })
	thread(PulseText, { Id = costTextboxId, ScaleTarget = 1.5, ScaleDuration = 0.25, HoldDuration = 0, PulseBias = 0.1 })
	if screen.Components.SubtitleCap ~= nil then
		thread(PulseText, { Id = screen.Components.SubtitleCap.Id, ScaleTarget = 1.1, ScaleDuration = 0.25, HoldDuration = 0, PulseBias = 0.1 })
	end
	thread( PlayVoiceLines, HeroVoiceLines.MetaUpgradeAtGlobalCapVoiceLines, true )
	ModifyTextBox({ Id = costTextboxId, ColorTarget = Color.MetaUpgradePointsInvalidPulseColor, ColorDuration = 0.0})
	if screen.Components.SubtitleCap ~= nil then
		ModifyTextBox({ Id = screen.Components.SubtitleCap.Id, ColorTarget = Color.MetaUpgradePointsInvalidPulseColor, ColorDuration = 0.0})
	end
	wait(0.1)
	ModifyTextBox({ Id = costTextboxId, ColorTarget = Color.MetaUpgradePointsCappedColor, ColorDuration = 0.8})
	if screen.Components.SubtitleCap ~= nil then
		ModifyTextBox({ Id = screen.Components.SubtitleCap.Id, ColorTarget = Color.Orange, ColorDuration = 0.8})
	end
end

function CannotUnlockMetaupgrade( costTextboxId )
	local screen = ScreenAnchors.LevelUpScreen or ScreenAnchors.ShrineScreen
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorCannotUpgrade" })
	thread(PulseText, { Id = costTextboxId, ScaleTarget = 1.25, ScaleDuration = 0.25, HoldDuration = 0, PulseBias = 0.1 })
	thread(PulseText, { Id = screen.Components.SubTitleKeys.Id, ScaleTarget = 1.25, ScaleDuration = 0.25, HoldDuration = 0, PulseBias = 0.1 })
	ModifyTextBox({ Id = costTextboxId, ColorTarget = Color.MetaUpgradePointsInvalidPulseColor, ColorDuration = 0.0})
	ModifyTextBox({ Id = screen.Components.SubTitleKeys.Id, ColorTarget = Color.MetaUpgradePointsInvalidPulseColor, ColorDuration = 0.0})
	wait(0.1)
	ModifyTextBox({ Id = costTextboxId, ColorTarget = Color.MetaUpgradePointsInvalid, ColorDuration = 0.8})
	ModifyTextBox({ Id = screen.Components.SubTitleKeys.Id, ColorTarget = Color.MetaUpgradePointsDisplay, ColorDuration = 0.8})
end

function CannotRefundMetaupgrade( totalTextboxId )
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorCannotUpgrade" })
	thread(PulseText, { Id = totalTextboxId, ScaleTarget = 1.25, ScaleDuration = 0.25, HoldDuration = 0, PulseBias = 0.1 })
	ModifyTextBox({ Id = totalTextboxId, ColorTarget = Color.MetaUpgradePointsInvalidPulseColor, ColorDuration = 0.0})
	wait(0.1)
	ModifyTextBox({ Id = totalTextboxId, ColorTarget = Color.White, ColorDuration = 0.8})
end

function CannotRerollPanelPresentation( button )
	Flash({ Id = button.Id, Speed = 2.64, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Red, Duration = 0.15, ExpireAfterCycle = true })
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" , Id = button.Id })
	if CheckCountInWindow( "RerollAttempt", 1.0, 2 ) then
		thread( PlayVoiceLines, HeroVoiceLines.CannotRerollVoiceLines, true )
	end
end

function RerollPanelPresentation( screen, button )
	PlaySound({ Name = "/Leftovers/Menu Sounds/AscensionConfirm" })
	local rerollSoundId = PlaySound({ Name = "/Leftovers/Menu Sounds/StoryRecapTextAppear" })
	FullScreenFadeOutAnimationReroll( button.RerollColor )
	SetVolume({ Id = rerollSoundId, Value = 0.3 })

	thread( PlayVoiceLines, HeroVoiceLines.UsedRerollPanelVoiceLines, true )
	wait(0.8)

	StopSound({ Id = rerollSoundId, Duration = 0.3 })

	FullScreenFadeInAnimationReroll( button.RerollColor)
	-- thread( PlayVoiceLines, HeroVoiceLines.RerollOutcomeVoiceLines, true )
end

function OnPlayerHealed( args )
	CreateAnimation({ Name = "HealthSparkleShower", DestinationId = CurrentRun.Hero.ObjectId, Group = "Overlay" })
	thread( DisplayPlayerHealingText, args )
end

function DisplayPlayerHealingText( args )

	if not ConfigOptionCache.ShowDamageNumbers then
		return
	end

	local amount = args.ActualHealAmount

	local healthColor = Color.UpgradeGreen
	thread(PopOverheadText, {Amount = amount, Text = "HealingAmount", Color = healthColor, SkipShadow = true })

	if ScreenAnchors.HealthFlash ~= nil then
		CreateAnimation({ Name = "HealthBarFlash", DestinationId = ScreenAnchors.HealthFlash, Group = "Overlay", OffsetY = -12, OffsetX = 40})
		SetScaleX({ Id = ScreenAnchors.HealthFlash, Fraction = CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth, Duration = 0 })
	end

	PulseText({ ScreenAnchorReference = "HealthBack", ScaleTarget = 1.25, ScaleDuration = 0.35, HoldDuration = 0.0, PulseBias = 0 })
end

function DisplayEnemyHealingText( args )
	local objectId = args.triggeredById
	local amount = args.ActualHealAmount
	local healthColor = Color.UpgradeGreen
	thread(PopOverheadText, {TargetId = objectId, Amount = amount, Text = "HealingAmount", Color = healthColor, SkipShadow = true })
end

function FirstTimeWeaponPickupPresentation( weaponKit )
	CreateAnimation({ Name = "HitSparkA", DestinationId = weaponKit.ObjectId })
	wait( 0.75 )
	ShakeScreen({ Speed = 1000, Distance = 8, Duration = 0.3 })
	AdjustColorGrading({ Name = "Team02", Duration = 0.2 })
	CreateAnimation({ Name = "ItemGet_Weapon", DestinationId = weaponKit.ObjectId, Scale = 2.0 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal3" })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.2 }, } )
	--wait( 0.25 )
	AdjustColorGrading({ Name = "Off", Duration = 0.5 })
	wait(0.1)
	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 40107 })
	local playerKitAnimation = weaponKit.FirstTimeEquipAnimation
	SetAnimation({ Name = playerKitAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = weaponKit.FirstTimeEquipSound or "/EmptyCue" })
end

function BiomeTimerAboutToExpirePresentation()
	if CheckCooldown( "BiomeTimerAboutToExpire", 60 ) then
		-- Pulse Timer
		PlaySound({ Name = "/SFX/ThanatosEntranceSound" })
		thread( PlayVoiceLines, HeroVoiceLines.BiomeTimerAboutToExpireVoiceLines, true )
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "BiomeTimerAboutToExpire", Duration = 1.3, PreDelay = 0.2 } )
	end
end

function BiomeTimerExpiredPresentation()

	AdjustColorGrading({ Name = "Thanatos", Duration = 0.5 })
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.5 })
	ShakeScreen({ Distance = 7, Speed = 400, FalloffSpeed = 2000, Duration = 0.5 })
	PlaySound({ Name = "/SFX/ThanatosEntranceSound" })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "BiomeTimerExpired", Duration = 1.3, PreDelay = 0.2 } )
	thread( PlayVoiceLines, HeroVoiceLines.BiomeTimerExpiredVoiceLines, true )

	AdjustColorGrading({ Name = "Off", Duration = 3.0, Delay = 1.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.5, Delay = 1.0 })
end

function BiomeDamagePresentation( damageAmount )

	thread( DisplayPlayerDamageText, { triggeredById = CurrentRun.Hero.ObjectId, UseCustomText = "BiomeTimerDamage", PercentMaxDealt = damageAmount/CurrentRun.Hero.MaxHealth, DamageAmount = damageAmount } )
	CreateAnimation({ Name = "ThanatosDeathsHead_Small", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	PlaySound({ Name = "/SFX/HeartPulsate1" })
	PlaySound({ Name = "/SFX/HeartPulsate2", Delay = 0.35 })

end

OnAutoUseFailed{
	function( triggerArgs )
		if not triggerArgs.OnCooldown then
			AutoUseFailedPresentation( triggerArgs.TriggeredByTable, triggerArgs.UserId )
		end
	end
}

function AutoUseFailedPresentation( useTarget, userId )

	if useTarget == nil or CurrentRun.Hero.HandlingDeath then
		return
	end
	PlaySound({ Name = useTarget.CannotUseSound or "/Leftovers/SFX/OutOfAmmo" , Id = useTarget.ObjectId })
	if CheckCooldown( "AutoUseFailed", 1 ) then
		thread( InCombatText, userId, useTarget.CannotUseText, 0.75 )
	end
end

function RelationshipChangedPresentation( entryName, sourceIds, finalGiftLevel )
	local hiddenIconId = nil
	local componentIds = ShallowCopyTable(sourceIds)
	if not IsGiftBarCompletelyUnlocked( entryName ) then
		hiddenIconId = componentIds[finalGiftLevel + 2]
	end
	if hiddenIconId then
		SetAlpha({ Id = hiddenIconId, Fraction = 0, Duration = 0 })
	end
	wait( 0.5 )
	local postDivider = false
	
	for index, componentId in pairs(componentIds) do
		if GiftData[entryName][index] and GiftData[entryName][index].HeartDividerAfter then
			componentIds[index + 1] = nil
			break
		end
	end
	componentIds = CollapseTableOrdered(componentIds)
	for index, componentId in pairs(componentIds) do
		if index > finalGiftLevel then
			break
		end
		wait( 0.1)
		thread(RelationshipChangedIconPresentation, componentId, index, postDivider, index == finalGiftLevel )
		if GiftData[entryName][index] and GiftData[entryName][index].HeartDividerAfter then
			postDivider = true
		end
	end
	wait(0.1)
	if hiddenIconId then
		SetAlpha({ Id = hiddenIconId, Fraction = 1, Duration = 0.3 })
	end
end

function RelationshipChangedIconPresentation( componentId, index, postDivider, isFinal )
	local scaleTarget = 1.3
	local dividerOffset = 0
	if postDivider then
		dividerOffset = 108
	end
	if isFinal then
		scaleTarget = 2
		CreateAnimation({ Name = "CodexFilledHeartShine", DestinationId = componentId, OffsetX = CodexUI.BaseIconOffsetX + CodexUI.SpacerX * index + dividerOffset })
	end
	if CodexUI.Screen and CodexUI.Screen.Components and CodexUI.Screen.Components.RelationshipIcons and CodexUI.Screen.Components.RelationshipIcons[index] then
		PlaySound({ Name = "/SFX/Menu Sounds/HeartsAddedCodex", Id = componentId })
		thread( PulseAnimation, { Id = componentId, StartGroup = "Combat_Menu_Overlay", TargetGroup = "Combat_Menu_TraitTray_Backing", ScaleTarget= scaleTarget, ScaleDuration = 0.3, HoldDuration = 0.3 })
	end
end

-- Utilities below

function RepulseFromObject( object, args )
	if object.IsInvisible then
		return
	end
	if not object.IgnoreInvincibubbleOnHit then
		CreateAnimation({ Name = object.InvincibubbleAnim or "Invincibubble", DestinationId = object.ObjectId, OffsetZ = args.OffsetZ, Scale = args.Scale })
	end
	CreateAnimation({ Name = "RadialNovaRepulsion", DestinationId = object.ObjectId, OffsetZ = args.OffsetZ, Scale = args.Scale })
	PlaySound({ Name = "/Leftovers/SFX/InvincibleOnHit", Id = object.ObjectId })
	local playerAngle = GetPlayerAngle()
	ApplyForce({ Id = CurrentRun.Hero.ObjectId, Speed = args.Speed or 950, MaxSpeed = args.MaxSpeed or 950, Angle = playerAngle + 180 })
	thread( DoRumble, { { ScreenPreWait = 0.02, LeftFraction = 0.17, Duration = 0.2 }, } )
	if args.VoiceLines ~= nil then
		thread( PlayVoiceLines, args.VoiceLines, true )
	end
	-- grip change to get the feel of sudden knockback
	SetThingProperty({ Property = "Grip", Value = 7000, DestinationId = CurrentRun.Hero.ObjectId, })
	ShakeScreen({ Speed = 1000, Distance = 8, Duration = 0.12 })
	AdjustRadialBlurDistance({ Fraction = 0.2, Duration = 0.002 })
	AdjustRadialBlurStrength({ Fraction = 2, Duration = 0.002 })
	waitScreenTime( 0.1 )
	AdjustRadialBlurStrength({ Fraction = 0, Duration = 0.06 })

	if args.Text ~= nil and CheckCooldown( "RepulseFromObject", 1.25 ) then
		thread( InCombatText, CurrentRun.Hero.ObjectId, args.Text, 1.5 )
	end
	waitScreenTime( 0.10 )
	if not object.IgnoreInvincibubbleOnHit then
		StopAnimation({ Name = object.InvincibubbleAnim or "Invincibubble", DestinationId = object.ObjectId })
	end
	SetThingProperty({ Property = "Grip", Value = "Default", DestinationId = CurrentRun.Hero.ObjectId })
end

function ShowInvincibubbleOnObject( object, args )
	if object.IsInvisible then
		return
	end
	CreateAnimation({ Name = object.InvincibubbleAnim or "Invincibubble", DestinationId = object.ObjectId, OffsetZ = args.OffsetZ, Scale = args.Scale })
	PlaySound({ Name = "/Leftovers/SFX/InvincibleOnHit", Id = object.ObjectId })
	if args.Text ~= nil and CheckCooldown( "RepulseFromObject", 1.25 ) then
		thread( InCombatText, CurrentRun.Hero.ObjectId, args.Text, 1.5 )
	end
	waitScreenTime( 0.10 )
	StopAnimation({ Name = object.InvincibubbleAnim or "Invincibubble", DestinationId = object.ObjectId })
end

function PopOverheadText( args )
	if not ConfigOptionCache.ShowUIAnimations then
		return
	end

	if not args.TargetId and ( not CurrentRun or not CurrentRun.Hero ) then
		return
	end

	local objectId = args.TargetId or CurrentRun.Hero.ObjectId
	local amount = args.Amount
	local text = args.Text

	local randomOffsetX = RandomInt( -10, 10 )
	local randomFontSize = RandomInt( 170, 180 )
	local offsetY = args.OffsetY or 0

	local roundedAmount = round( amount )

	local textHold = SpawnObstacle({ Name = "InvisibleTargetNoTimeModifier", DestinationId = objectId, Group = "Overlay", OffsetX = randomOffsetX, OffsetY = -270 })
	local textAnchor = SpawnObstacle({ Name = "BlankObstacleNoTimeModifier", DestinationId = objectId, Group = "Overlay", OffsetX = 0, OffsetY = -190 })
	local textEnd = SpawnObstacle({ Name = "InvisibleTargetNoTimeModifier", DestinationId = objectId, Group = "Overlay", OffsetX = randomOffsetX, OffsetY = -200 })

	local color = args.Color

	local holdDuration = args.HoldDuration or 0

	CreateTextBox({
		Id = textAnchor, Text = text, GroupName = "Overlay",
		Justification = "CENTER",
		ShadowBlur = 0, ShadowColor = {60,100,70,1}, ShadowOffset = {0, 5},
		OutlineThickness = 3, OutlineColor = {0.0, 0.0, 0.0,1},
		Color = color,
		Font = "AlegreyaSansSCBold",
		FontSize = randomFontSize,
		OffsetY = 20 + offsetY,
		OffsetX = 0,
		Scale = 0.6,
		ScaleTarget = 0.6,
		LuaKey = "TempTextData",
		LuaValue = { Amount = roundedAmount },
		AutoSetDataProperties = false,
	})

	if not args.SkipShadow then
		SetAnimation({  Name = "InCombatTextShadow_Short", DestinationId = textAnchor, OffsetY = 10 + offsetY, Scale = args.ShadowScale or 0.6, Group = "Combat_UI_World" })
	end

	waitScreenTime(0.1)
	SetColor({ Id = textAnchor, Color = Color.White, Duration = 0 })
	SetColor({ Id = textAnchor, Color = color, Duration = 0.4, EaseIn=0.99, EaseOut=1.0 })
	Move({ Id = textAnchor, DestinationId = textHold, Speed = 200, EaseIn = 0.99, EaseOut = 1.0, TimeModifierFraction = 0.0 })
	ModifyTextBox({ Id = textAnchor, ScaleTarget = 0.3, ScaleDuration = 0.2, AutoSetDataProperties = false, })
	waitScreenTime(0.45)
	Move({ Id = textAnchor, DestinationId = textEnd, Speed = 10, EaseIn = 0, EaseOut = 1.0, TimeModifierFraction = 0.0 })
	waitScreenTime(holdDuration)
	ModifyTextBox({ Id = textAnchor, FadeTarget = 0.0, FadeDuration = 0.4, AutoSetDataProperties = false, })
	if not args.SkipShadow then
		SetAnimation({  Name = "InCombatTextShadowFade_Short", DestinationId = textAnchor, OffsetY = 10 + offsetY, Scale = args.ShadowScale or 0.6, Group = "Combat_UI_World" })
	end
	waitScreenTime(0.4)
	Destroy({ Ids = { textAnchor, textHold, textEnd } })
end

function PulseText( args )
	if args.Id == nil and args.ScreenAnchorReference == nil then
		return
	end
	if args.ScaleOriginal == nil then
		args.ScaleOriginal = 1
	end
	if args.ScaleDuration == nil then
		args.ScaleDuration = 0.05
	end
	if args.PulseBias == nil then
		args.PulseBias = 0.5
	end

	-- ModifyTextBox ScaleDuration is actually seconds per 1 unit of scale
	local textBoxScaleDuration = args.ScaleDuration / (args.ScaleTarget - args.ScaleOriginal)
	local id = args.Id or ScreenAnchors[args.ScreenAnchorReference]
	ModifyTextBox({ Id = id, ScaleTarget = args.ScaleTarget, ScaleDuration = textBoxScaleDuration * args.PulseBias, AutoSetDataProperties = false, ColorTarget = args.Color or nil, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0 })
	wait( (args.ScaleDuration * args.PulseBias) + args.HoldDuration, RoomThreadName )

	id = args.Id or ScreenAnchors[args.ScreenAnchorReference]
	ModifyTextBox({ Id = id, ScaleTarget = args.ScaleOriginal, ScaleDuration = textBoxScaleDuration * (1 - args.PulseBias), AutoSetDataProperties = false, ColorTarget = args.OriginalColor or nil, ColorChangeSpeed = 1.0, FadeTarget = 1, FadeDuration = 0 })
end

function PulseCombatText( damageTextAnchor )
	ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 1.1, ScaleDuration = 0})
	waitScreenTime( 0.05, RoomThreadName )
	ModifyTextBox({ Id = damageTextAnchor, ScaleTarget = 1, ScaleDuration = 0.1})
end

function PulseAnimation(args)
	if args.PulseBias == nil then
		args.PulseBias = 0.5
	end
	if args.StartGroup and args.TargetGroup then
		RemoveFromGroup({ Id = args.Id, Names = { args.StartGroup } })
		AddToGroup({ Id = args.Id, Name = args.TargetGroup, DrawGroup = true })
	end

	if args.ScaleTarget ~= nil then
		if args.ScaleOriginal == nil then
			args.ScaleOriginal = 1
		end
		SetScale({ Id = args.Id, Fraction = args.ScaleTarget, Duration = args.ScaleDuration * args.PulseBias})
		wait(args.ScaleDuration + args.HoldDuration)
		SetScale({ Id = args.Id, Fraction = args.ScaleOriginal, Duration = args.ScaleDuration * (1 - args.PulseBias)})
	else
		if args.ScaleOriginalX == nil then
			args.ScaleOriginalX = 1
		end

		if args.ScaleTargetX == nil then
			args.ScaleTargetX = args.ScaleOriginalX
		end

		if args.ScaleOriginalY == nil then
			args.ScaleOriginalY = 1
		end

		if args.ScaleTargetY == nil then
			args.ScaleTargetY = args.ScaleTargetY
		end
		SetScaleX({ Id = args.Id, Fraction = args.ScaleTargetX, Duration = args.ScaleDuration * args.PulseBias})
		SetScaleY({ Id = args.Id, Fraction = args.ScaleTargetY, Duration = args.ScaleDuration * args.PulseBias})
		wait(args.ScaleDuration + args.HoldDuration)
		SetScaleX({ Id = args.Id, Fraction = args.ScaleOriginalX, Duration = args.ScaleDuration * (1 - args.PulseBias)})
		SetScaleY({ Id = args.Id, Fraction = args.ScaleOriginalY, Duration = args.ScaleDuration * (1 - args.PulseBias)})
	end

	if args.StartGroup and args.TargetGroup then
		RemoveFromGroup({ Id = args.Id, Name = args.TargetGroup })
		AddToGroup({ Id = args.Id, Names = { args.StartGroup }, DrawGroup = true })
	end
end

function CannotUseLootPresentation( id, table )
	RepulseFromObject( table, { Text = "UseBlockedByEnemies", OffsetZ = -70, Scale = 0.65, VoiceLines = HeroVoiceLines.InteractionBlockedVoiceLines, ShadowScale = 0.66 } )
end

function StartedTextLinesPresentation( source, textLines )
	if source ~= nil and source.TextLinesPauseAmbientMusicVocals then
		SetSoundCueValue({ Names = { "Vocals", }, Id = AmbientMusicId, Value = 0 })
	end
	if source ~= nil and source.TextLinesPauseAmbientMusicVocals2 then
		SetSoundCueValue({ Names = { "Vocals2", }, Id = AmbientMusicId, Value = 0 })
	end
	if textLines ~= nil and textLines.TextLinesPauseAmbientMusicVocals then
		SetSoundCueValue({ Names = { "Vocals", }, Id = AmbientMusicId, Value = 0 })
		SetSoundCueValue({ Names = { "Vocals2", }, Id = AmbientMusicId, Value = 1 })
	end
	if textLines ~= nil and textLines.TextLinesPauseAmbientMusicVocals2 then
		SetSoundCueValue({ Names = { "Vocals", }, Id = AmbientMusicId, Value = 1 })
		SetSoundCueValue({ Names = { "Vocals2", }, Id = AmbientMusicId, Value = 0 })
	end
	if textLines ~= nil and source.TextLinesPauseSingingFx then
		StopAnimation({ DestinationId = source.ObjectId, Name = source.SingingFx })
	end
	if CurrentDeathAreaRoom ~= nil and AmbientMusicId ~= nil then
		SetVolume({ Id = AmbientMusicId, Value = math.min( CurrentDeathAreaRoom.AmbientMusicVolume or 1.0, 0.5 ), Duration = 0.25 })
	end

	if source ~= nil and source.StartTextLinesAnimation and not textLines.IgnoreSourceStartEndAnimations then
		SetAnimation({ DestinationId = source.ObjectId, Name = source.StartTextLinesAnimation })
	end
	if source ~= nil and textLines.StartPartnerTextLinesAnimation and source.PartnerObjectId then
		SetAnimation({ DestinationId = source.PartnerObjectId, Name = textLines.StartPartnerTextLinesAnimation })
	end
	if source.StartTextLinesAngleTowardHero ~= nil and not textLines.IgnoreStartTextLinesAngleTowardHero then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	end

	CreateDialogueBackground()
end

function CreateDialogueBackground( )
	ScreenAnchors.DialogueBackgroundId = CreateScreenObstacle({ Name = "DialogueBackground", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu" })
end

function FinishedTextLinesPresentation( source, textLines )
	if source ~= nil and source.TextLinesPauseAmbientMusicVocals then
		SetSoundCueValue({ Names = { "Vocals", }, Id = AmbientMusicId, Value = 1, Duration = 0.25 })
	end
	if source ~= nil and source.TextLinesPauseAmbientMusicVocals2 then
		SetSoundCueValue({ Names = { "Vocals2", }, Id = AmbientMusicId, Value = 1, Duration = 0.25 })
	end
	if textLines ~= nil and textLines.TextLinesPauseAmbientMusicVocals then
		SetSoundCueValue({ Names = { "Vocals", }, Id = AmbientMusicId, Value = 1, Duration = 0.25 })
		SetSoundCueValue({ Names = { "Vocals2", }, Id = AmbientMusicId, Value = 1 })
	end
	if textLines ~= nil and textLines.TextLinesPauseAmbientMusicVocals2 then
		SetSoundCueValue({ Names = { "Vocals", }, Id = AmbientMusicId, Value = 1 })
		SetSoundCueValue({ Names = { "Vocals2", }, Id = AmbientMusicId, Value = 1, Duration = 0.25 })
	end
	if textLines ~= nil and source.TextLinesPauseSingingFx and AmbientMusicId ~= nil then
		CreateAnimation({ Name = source.SingingFx, DestinationId = source.ObjectId, OffsetX = source.SingingAnimOffsetX or source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
	end	
	if CurrentDeathAreaRoom ~= nil and AmbientMusicId ~= nil then
		SetVolume({ Id = AmbientMusicId, Value = CurrentDeathAreaRoom.AmbientMusicVolume or 1.0, Duration = 0.25 })
	end
	if source ~= nil and source.EndTextLinesAnimation and not textLines.IgnoreSourceStartEndAnimations then
		SetAnimation({ DestinationId = source.ObjectId, Name = source.EndTextLinesAnimation })
	end
	if source ~= nil and textLines.EndPartnerTextLinesAnimation and source.PartnerObjectId then
		SetAnimation({ DestinationId = source.PartnerObjectId, Name = textLines.EndPartnerTextLinesAnimation })
	end	
	if source ~= nil and source.EndTextLinesVfx and not textLines.IgnoreSourceStartEndAnimations then
		CreateAnimation({ Name = source.EndTextLinesVfx, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
	end
	if source ~= nil and source.EndTextLinesThreadedFunctionName and not textLines.IgnoreSourceEndTextLinesThreadedFunctionName then
		local threadedFunction = _G[source.EndTextLinesThreadedFunctionName]
		if threadedFunction ~= nil then
			thread( threadedFunction, source, source.EndTextLinesFunctionArgs, textLines )
		end
	end
	SetAnimation({ DestinationId = ScreenAnchors.DialogueBackgroundId, Name = "DialogueBackgroundOut" })

	wait( 0.1, RoomThreadName )
	Destroy({ Id = ScreenAnchors.DialogueBackgroundId })
end

function CannotUnlockShrinePresentation( usee )
	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo", Id = usee.ObjectId })
	Flash({ Id = usee.TextAnchorId, Speed = 2, MinFraction = 1, MaxFraction = 0.0, Color = Color.CostUnaffordable, ExpireAfterCycle = true })
	Shake({ Id = usee.ObjectId, Distance = 6, Speed = 300, Duration = 0.2 })
	Shake({ Id = usee.TextAnchorId, Distance = 6, Speed = 300, Duration = 0.2 })
	thread( PlayVoiceLines, HeroVoiceLines.CannotUnlockShrineVoiceLines, true )
end

function ShrineUnlockPresentation( usee )
	AddInputBlock({ Name = "UnlockinShrine" })
	HideUseButton( usee.ObjectId, usee )
	SetAnimation({ DestinationId = usee.TextAnchorId, Name = "LockedIconRelease" })
	Shake({ Id = usee.ObjectId, Distance = 2, Speed = 300, Duration = 0.65 })
	PlaySound({ Name = "/Leftovers/SFX/AnnouncementThunder", Id = usee.ObjectId })
	thread( PlayVoiceLines, HeroVoiceLines.ShrineUnlockedVoiceLines, true )

	PlayInteractAnimation( usee.ObjectId )
	wait(0.8)
	PlaySound({ Name = "/SFX/Menu Sounds/WeaponUnlockPoof", Id = usee.ObjectId  })
	DestroyTextBox({ Id = usee.TextAnchorId })
	usee.UseText = usee.UnlockedUseText
	RemoveInputBlock({ Name = "UnlockinShrine" })
end

function MarketSessionCompletePresentation( usee, screen )
	if screen.NumItemsOffered == 0 then
		return
	end
	if screen.NumSales == 0 then
		if CheckCooldown( "MarketNoSale", 60 ) then
			PlayEmote( { TargetId = usee.NoSaleEmoteTargetId or usee.ObjectId, AnimationName = usee.NoSaleEmote, OffsetZ = usee.EmoteOffsetZ } )
		end
	else
		if CheckCooldown( "MarketMadeSale", 60 ) then
			PlayEmote( { TargetId = usee.MadeSaleEmoteTargetId or usee.ObjectId, AnimationName = usee.MadeSaleEmote, OffsetZ = usee.EmoteOffsetZ } )
		end
	end
end

function GhostAdminScreenOpenedPresentation( screen )

	if screen.OfferedVoiceLines ~= nil then
		if PlayVoiceLines( screen.OfferedVoiceLines, true ) then
			return
		end
	end

	if screen.NumItemsPurchaseable == 0 then
		thread( PlayVoiceLines, GlobalVoiceLines.GhostAdminSoldOutVoiceLines, true )
	elseif screen.NumItemsAffordable == 0 then
		thread( PlayVoiceLines, GlobalVoiceLines.GhostAdminCantAffordAnyVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.OpenedGhostAdminScreenVoiceLines, true )
	end

end

function GhostAdminSessionCompletePresentation( usee, screen )
	if screen == nil then
		return
	end
	if screen.NumSales == 0 then
		if CheckCooldown( "MarketNoSale", 60 ) then
			PlayEmote( { TargetId = usee.NoSaleEmoteTargetId or usee.ObjectId, AnimationName = usee.NoSaleEmote, OffsetZ = usee.EmoteOffsetZ } )
		end
	else
		if CheckCooldown( "MarketMadeSale", 60 ) then
			PlayEmote( { TargetId = usee.MadeSaleEmoteTargetId or usee.ObjectId, AnimationName = usee.MadeSaleEmote, OffsetZ = usee.EmoteOffsetZ } )
		end
	end
end

function RefundMetaUpgradesPressedPresentation( screen, button )
	PlaySound({ Name = "/SFX/KeyDrop" })
end

function MetaPointCapRefundPresentation( refundAmount )
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuRefundSFX" })

	CreateAnimation({ DestinationId = 390021, Name = "HouseMirrorDarknessRefundFx" })
	wait(0.2)
	for i = 1, 5 do
		CreateAnimationsBetween({ Animation = "MetapointRefundStreakReverse", DestinationId = 390021, Id = 40000,
			Stretch = true,
			WorldSpace = false,
			UseZLocation = true,
			TargetXOffset = math.random(200) - 50,
			TargetYOffset = math.random(300) - 430,
			GroupName = "FX_Standing_Add",
			AngleOffset = math.random(10) - 5,
		})
		wait(0.1)
	end

	thread( PlayVoiceLines, HeroVoiceLines.MetaUpgradesResetVoiceLines, true )
	thread( InCombatText, CurrentRun.Hero.ObjectId, "MetaPointCapRefund", 1.15, { PreDelay = 0.5, LuaKey = "TempTextData", LuaValue = { RefundAmount = refundAmount } })
	PlaySound({ Name = "/SFX/Menu Sounds/MirrorFlash", Delay = 0.5 })
end

function SurpriseNPCPresentation( source, args )

	if args.SourceId ~= nil then
		source = ActiveEnemies[args.SourceId]
	end

	local checkingMeterUnlock = GiftData[source.Name] and not IsGameStateEligible(CurrentRun, GiftData[source.Name].UnlockGameStateRequirements )

	AddInputBlock({ Name = "SurpriseNPCPresentation" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })

	killWaitUntilThreads( "ReattachCameraOnInput" )

	PlayVoiceLines( args.VoiceLines, false, source )
	wait( args.IntroWait or 0.4, RoomThreadName )

	AngleTowardTarget({ Id = source.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	if not args.SkipPan then
		PanCamera({ Ids = args.PanIds or { source.ObjectId, CurrentRun.Hero.ObjectId }, Duration = 1.5, EaseIn = 0.05, EaseOut = 0.3 })
	end
	RemoveInputBlock({ Name = "SurpriseNPCPresentation" })

	if args.TextLineSet ~= nil then
		ProcessTextLines( args.TextLineSet )
		PlayRandomRemainingTextLines( source, args.TextLineSet )
	end

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })

	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })

	if checkingMeterUnlock and GiftData[source.Name] and IsGameStateEligible(CurrentRun, GiftData[source.Name].UnlockGameStateRequirements ) then
		thread( GiftTrackUnlockedPresentation, source.Name )
	end
end
function SetupNPCPresentation( source, args )

	Teleport({ Id = source.ObjectId, DestinationId = source.ObjectId, OffsetX = args.OffsetX or 0, OffsetY = args.OffsetY or 0 })

end

GlobalVoiceLines = GlobalVoiceLines or {}
GlobalVoiceLines.ThanatosSpecialExitVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.5,
	Source = { SubtitleColor = Color.ThanatosVoice },
	AllowTalkOverTextLines = true,

	-- Bye, Zag.
	{ Cue = "/VO/ThanatosField_0236" },
}
function ExitNPCPresentation( source, args )

	AddInputBlock({ Name = "NPCExit" })
	wait( args.InitialWaitTime or 0 )

	FadeOut({ Color = Color.Black, Duration = args.FadeOutTime or 0.5 })

	PlaySound({ Name = args.InitialExitSound or "/EmptyCue", Delay = 0.7 })

	wait( (args.FadeOutTime or 0.5) + 0.3 )

	if args.DeleteId ~= nil then
		Destroy({ Id = args.DeleteId })
	end

	PlaySound({ Name = args.FootstepSound or "/Leftovers/SFX/FootstepsConcreteMedium" })
	PlaySound({ Name = args.FootstepSound or "/Leftovers/SFX/FootstepsConcreteMedium", Delay = 0.3 })
	PlaySound({ Name = args.MoveSound or "/SFX/Enemy Sounds/Megaera/MegaeraWingFlap", Delay = 0.4 })
	PlaySound({ Name = args.FootstepSound or "/Leftovers/SFX/FootstepsConcreteMedium", Delay = 0.6 })
	PlaySound({ Name = args.FootstepSound or "/Leftovers/SFX/FootstepsConcreteMedium", Delay = 0.9 })
	PlaySound({ Name = args.MoveSound or "/SFX/Enemy Sounds/Megaera/MegaeraWingFlap", Delay = 1.0 })
	if args.UseAdditionalFootstepSounds then
		PlaySound({ Name = args.FootstepSound or "/Leftovers/SFX/FootstepsConcreteMedium", Delay = 1.2 })
		PlaySound({ Name = args.FootstepSound or "/Leftovers/SFX/FootstepsConcreteMedium", Delay = 1.5 })
	end

	if args.UseThanatosExitSound then
		thread( PlayVoiceLines, GlobalVoiceLines.ThanatosSpecialExitVoiceLines, true )
		PlaySound({ Name = "/Leftovers/SFX/BeaconTeleportSFX2", Delay = 2.2 })
	end

	LockCamera({ Id = CurrentRun.Hero.ObjectId })
	Teleport({ Id = args.ObjectId or source.ObjectId, DestinationId = args.TeleportToId })
	if args.AltObjectId ~= nil then
		Teleport({ Id = args.AltObjectId, DestinationId = args.TeleportToId })
	end

	wait( args.FullFadeTime or 1.5 )

	thread( PlayVoiceLines, HeroVoiceLines[args.HeroVoiceLines] )

	FadeIn({ Duration = args.FadeInTime or 1.0 })

	RemoveInputBlock({ Name = "NPCExit" })

	PlaySound({ Name = args.EndSound or "/EmptyCue", Delay = 0.3 })

	if args.EndUnlockText ~= nil then
		thread( DisplayUnlockText, {
			TitleText = args.EndUnlockText.."_Title",
			SubtitleText = args.EndUnlockText.."_Subtitle",
			AnimationName = args.AnimationName or "LocationTextBGGeneric",
			AnimationOutName = args.AnimationOutName or "LocationTextBGGenericOut",
			FontScale = args.FontScale or 1.0,
			SubtitleData = { LuaKey = "TempTextData", LuaValue = { Name = CurrentRun.CurrentRoom.EndUnlockText }},
			Delay = 0.6,
		})
	elseif args.EndUnlockTextTable ~= nil then
		local text = GetRandomValue( args.EndUnlockTextTable )
		thread( DisplayUnlockText, {
			TitleText = text.."_Title",
			SubtitleText = text.."_Subtitle",
			AnimationName = args.AnimationName or "LocationTextBGGeneric",
			AnimationOutName = args.AnimationOutName or "LocationTextBGGenericOut",
			FontScale = args.FontScale or 1.0,
			SubtitleData = { LuaKey = "TempTextData", LuaValue = { Name = CurrentRun.CurrentRoom.EndUnlockText }},
			Delay = 0.6,
		})
	end

end

function MinotaurEarlyExitPresentation( boss, currentRun )
	HideCombatUI("MinotaurEarlyExit")
	boss.CanStoreAmmo = false
	boss.EarlyExit = true
	-- PlaySound({ Name = "/SFX/FightGong" })
	thread(LastKillPresentation, boss )
	PlaySound({ Name = "/SFX/FightBell" })
	ZeroSuperMeter()

	AddTimerBlock( CurrentRun, "MinotaurEarlyExitPresentation" )
	AddInputBlock({ Name = "MinotaurEarlyExit" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })
	ExpireProjectiles({ })
	SetUnitVulnerable( boss )

	thread( PlayVoiceLines, boss.EarlyExitVoiceLines, nil, boss )

	SetAnimation({ DestinationId = boss.ObjectId, Name = GetThingDataValue({ Id = boss.ObjectId, Property = "Graphic" }) })
	LockCamera({ Id = boss.ObjectId, Duration = 1.25 })
	Move({ Id = boss.ObjectId, DestinationId = 522283, SuccessDistance = 50 })
	local notifyName = "WithinDistance"..boss.ObjectId
	NotifyWithinDistance({ Id = boss.ObjectId, DestinationId = 522283, Distance = 50, Notify = notifyName, Timeout = 9.0, })
	waitUntil( notifyName, boss.AIThreadName )

	thread( PlayVoiceLines, boss.PostMatchTauntVoiceLines, true, boss )

	Stop({ Id = boss.ObjectId })
	AngleTowardTarget({ Id = boss.ObjectId, DestinationId = currentRun.Hero.ObjectId })
	--PlayVoiceLines( args.VoiceLines )

	ProcessTextLines( boss.BossPresentationOutroTextLineSets )
	ProcessTextLines( boss.BossPresentationOutroRepeatableTextLineSets )

	EndMusic( MusicId, MusicName )
	RemoveEnemyUI( boss )

	if TextLinesRecord["MinotaurFirstExit"] then
		wait( 0.5, RoomThreadName )
	else
		wait( 2.0, RoomThreadName )
	end

	if not PlayRandomRemainingTextLines( boss, boss.BossPresentationOutroTextLineSets ) then
		PlayRandomRemainingTextLines( boss, boss.BossPresentationOutroRepeatableTextLineSets )
	end

	wait( 1.5, RoomThreadName )

	thread( PlayVoiceLines, HeroVoiceLines.MinotaurDefeatedVoiceLines )

	LockCamera({ Ids = { 521115, 522283 }, Duration = 1.25 })
	local exitDoor = MapState.ActiveObstacles[521115]
	Move({ Id = boss.ObjectId, DestinationId = 522284, SuccessDistance = 50 })
	wait( 0.4, RoomThreadName )
	SetAnimation({ DestinationId = exitDoor.ObjectId, Name = exitDoor.ExitDoorOpenAnimation })

	SetUnitProperty({ DestinationId = boss.ObjectId, Property = "CollideWithUnits", Value = false })
	SetUnitProperty({ DestinationId = boss.ObjectId, Property = "CollideWithObstacles", Value = false })
	wait( 2.5, RoomThreadName )

	SetAnimation({ DestinationId = exitDoor.ObjectId, Name = exitDoor.ExitDoorCloseAnimation })
	wait( 1.5, RoomThreadName )

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
	Teleport({ Id = boss.ObjectId, DestinationId = 522243 })

	RemoveInputBlock({ Name = "MinotaurEarlyExit" })
	RemoveTimerBlock( CurrentRun, "MinotaurEarlyExitPresentation" )
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })
	ShowCombatUI("MinotaurEarlyExit")
end

function CharonFightEndPresentation( boss, currentRun )
	AddTimerBlock( CurrentRun, "CharonEarlyExitPresentation" )
	AddInputBlock({ Name = "CharonFightEnd" })
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = false })
	ExpireProjectiles({ })
	DestroyRequiredKills( { BlockLoot = true, SkipIds = { boss.ObjectId }, BlockDeathWeapons = true } )
	notifyExistingWaiters("AllRequiredKillEnemiesDead")
	HideCombatUI("CharonFightEnd")
	boss.AIDisabled = true

	SetUnitProperty({ Property = "Speed", Value = 500, DestinationId = boss.ObjectId })

	thread(LastKillPresentation, boss )
	PlaySound({ Name = "/Leftovers/SFX/AnnouncementPing3" })
	SetSoundCueValue({ Names = { "Section", }, Id = MusicId, Value = 10 })
	MusicName = nil
	MusicSection = nil
	MusicId = nil

	ZeroSuperMeter()

	thread( PlayVoiceLines, boss.EarlyExitVoiceLines, nil, boss )

	wait( 0.5, RoomThreadName )

	StopAnimation({ Name = "Invincibubble_Charon", DestinationId = boss.ObjectId })
	SetLifeProperty({ DestinationId = boss.ObjectId, Property = "InvulnerableFx", Value = nil })
	SetAnimation({ DestinationId = boss.ObjectId, Name = GetThingDataValue({ Id = boss.ObjectId, Property = "Graphic" }) })
	LockCamera({ Id = boss.ObjectId, Duration = 1.25 })
	Move({ Id = boss.ObjectId, DestinationId = 40055, SuccessDistance = 32 })
	local notifyName = "WithinDistance"..boss.ObjectId
	NotifyWithinDistance({ Id = boss.ObjectId, DestinationId = 40055, Distance = 32, Notify = notifyName, Timeout = 9.0, })
	waitUntil( notifyName, boss.AIThreadName )

	thread( PlayVoiceLines, boss.PostMatchTauntVoiceLines, true, boss )
	Stop({ Id = boss.ObjectId })

	wait( 0.2, RoomThreadName )
	AngleTowardTarget({ Id = boss.ObjectId, DestinationId = 50065 })

	wait( 0.70, RoomThreadName )

	local consumableId = SpawnObstacle({ Name = "CharonStoreDiscount", DestinationId = boss.ObjectId, Group = "Standing" })
	local consumable = CreateConsumableItem( consumableId, "CharonStoreDiscount", 0 )
	ActivatedObjects[consumable.ObjectId] = consumable

	SetAnimation({ DestinationId = boss.ObjectId, Name = "CharonMeleeFront_ReturnToIdleLeft" })

	ApplyUpwardForce({ Id = consumableId, Speed = 700 })
	local forceAngle = GetAngleBetween({ Id = boss.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
	ApplyForce({ Id = consumableId, Speed = 300, Angle = forceAngle, SelfApplied = true })

	PlaySound({ Name = "/Leftovers/World Sounds/TrainingMontageWhoosh", Id = consumableId })

	wait( 2.0, RoomThreadName )

	ProcessTextLines( boss.BossPresentationOutroTextLineSets )
	ProcessTextLines( boss.BossPresentationOutroRepeatableTextLineSets )

	RemoveEnemyUI( boss )

	if not PlayRandomRemainingTextLines( boss, boss.BossPresentationOutroTextLineSets ) then
		PlayRandomRemainingTextLines( boss, boss.BossPresentationOutroRepeatableTextLineSets )
	end

	thread( PlayVoiceLines, GlobalVoiceLines.CharonFightRewardVoiceLines, true )

	LockCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.25 })
	AngleTowardTarget({ Id = boss.ObjectId, DestinationId = 50065 })

	wait( 0.5, RoomThreadName )

	RemoveInputBlock({ Name = "CharonFightEnd" })
	RemoveTimerBlock( CurrentRun, "CharonEarlyExitPresentation" )
	ToggleControl({ Names = { "AdvancedTooltip", }, Enabled = true })
	ShowCombatUI("CharonFightEnd")
end

function LeaveCharonFight( eventSource, args )
	args = args or {}
	AddInputBlock({ Name = "LeaveCharonFight" })
	wait(args.Delay or 1.0, RoomThreadName)

	PlaySound({ Name = "/Leftovers/SFX/NomadSprint", DestinationId = CurrentRun.Hero.ObjectId })

	RemoveInputBlock({ Name = "LeaveCharonFight" })
	LeaveRoom( CurrentRun, { Room = CreateRoom( ChooseNextRoomData( CurrentRun ) ) } )
end

function DoNPCInteractionPresentation( heroId, npc, interaction )

	FreezePlayerUnit()
	AngleTowardTarget({ Id = heroId, DestinationId = npc.ObjectId })
	wait(0.25)
	SetAnimation({ Name = "ZagreusInteractEquip", DestinationId = heroId })

	if interaction.VoiceLines ~= nil then
		thread( PlayVoiceLines, interaction.VoiceLines, true, npc )
	elseif CurrentRun.CurrentRoom.Encounter.GreetedVoiceLines ~= nil then
		thread( PlayVoiceLines, CurrentRun.CurrentRoom.Encounter.GreetedVoiceLines )
	elseif CurrentRun.CurrentRoom.GreetedVoiceLines ~= nil then
		thread( PlayVoiceLines, CurrentRun.CurrentRoom.GreetedVoiceLines )
	end
	if interaction.Animation ~= nil then
		SetAnimation({ Name = interaction.Animation, DestinationId = npc.ObjectId })
		PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract", DestinationId = npc.ObjectId })
		Shake({ Id = npc, Distance = 3, Speed = 900, Duration = 0.15 })
	end
	wait(0.75)
	thread( PlayVoiceLines, HeroVoiceLines.ThankingCharacterVoiceLines, true )
	StopStatusAnimation( npc, StatusAnimations.WantsToTalk )
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
--	thread( InCombatText, npc.ObjectId, "CharacterRescued", 3 )
	CreateAnimation({ Name = "StatusIconNPCRescued", DestinationId = npc.ObjectId })

	SetAnimation({ Name = "ZagreusIdle", DestinationId = heroId })
	wait(0.1)
	UnfreezePlayerUnit()
	wait(0.75)
end

function PatroclusPreBuffPresentation( source, args )
	wait(1.0)
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
end

function PatroclusPostBuffPresentation( source, args )
	if args.TraitName ~= nil then
		local traitData = TraitData[args.TraitName]
		if traitData.LastStandWeapon ~= nil then
			GainLastStandPresentation()
			thread( InCombatText, CurrentRun.Hero.ObjectId, "GainedExtraChance" )
		end
	end
end

function EurydicePreBuffPresentation( source, args )
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	wait(1.6)
	PlaySound({ Name = "/SFX/GyroHealthPickupMunch", Id = CurrentRun.Hero.ObjectId })
	CreateAnimation({ Name = "HealthSparkleBurst", DestinationId = CurrentRun.Hero.ObjectId, OffsetZ = 50 })
end

function EurydicePostBuffPresentation( source, args )
	if args.TraitName ~= nil then
		local traitData = TraitData[args.TraitName]
		if traitData.LastStandWeapon ~= nil then
			GainLastStandPresentation()
			thread( InCombatText, CurrentRun.Hero.ObjectId, "GainedExtraChance" )
		end
	end
end

function StyxFountainPresentation()

	local preFountainBloom = GetBloomSettingName({ })
	local preFountainCamera = GetCameraZoom({ })

	AdjustFullscreenBloom({ Name = "BlurryLight", Duration = 0.5 })
	PlaySound({ Name = "/Leftovers/World Sounds/Caravan Interior/SwallowDrink", Id = CurrentRun.Hero.ObjectId })

	Rumble({ Duration = 0.3, RightFraction = 0.17 })

	AdjustRadialBlurDistance({ Fraction = 1.5, Duration = 1.5 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 1.5 })

	ShakeScreen({ Distance = 30, Speed = 4, FalloffSpeed = 10, Duration = 3.0 })
	FocusCamera({ Fraction = preFountainCamera * 1.05, Duration = 3.0 })

	wait(1.0)

	SetAnimation({ Name = "ZagreusInteractionThoughtful", DestinationId = CurrentRun.Hero.ObjectId })

	AdjustRadialBlurDistance({ Fraction = 0, Duration = 0.4 })
	AdjustRadialBlurStrength({ Fraction = 1.5, Duration = 0.4 })
	AdjustFullscreenBloom({ Name = preFountainBloom, Duration = 0.4 })
	FocusCamera({ Fraction = preFountainCamera, Duration = 0.8 })

end

function PlayedMusicPlayerTrackPresentation( trackName )
	wait( 0.85, RoomThreadName )
	if not MusicPlayerTrackPaused then
		thread( PlayVoiceLines, GlobalVoiceLines.PlayedMusicTrackVoiceLines, true )
	end
end

function LoungeRevelryPresentation( source, args )

	args = args or {}
	wait(1)
	PlaySound({ Name = args.Sound or "/SFX/Menu Sounds/Lounge_GlassWithIce" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/SFX/Menu Sounds/Lounge_BottleCork" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/SFX/Menu Sounds/Lounge_BottlePour" })
	wait(1.0)
	PlaySound({ Name = args.Sound2 or "/VO/MegaeraHome_0230" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)

	thread( DisplayUnlockText, {
		--SupertitleText = "EasyModeUpgradedSupertitle",
		TitleText = "LoungeIntermissionMessage",
		-- SubtitleText = args.Text,
		TextRevealSound = "/Leftovers/Menu Sounds/EmoteExcitement",
		Color = Color.Gold,
		--SupertitleTextColor = {190, 190, 190, 255},
		--SupertitleTextDelay = 1.0,
		TextColor = Color.White,
		TextOffsetY = 20,
		-- SubTextColor = {23, 255, 187, 255},
		-- Icon = EasyModeIcon,
		-- Duration = 4.35,
		-- IconMoveSpeed = 0.00001,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		--SupertitleFont = "AlegreyaSansSCRegular",
		Layer = "ScreenOverlay",
		AdditionalAnimation = "GodHoodRays",
		} )

	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	PlaySound({ Name = args.Sound or "/SFX/Menu Sounds/Lounge_GlassesClinking" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	PlaySound({ Name = args.Sound3 or "/VO/ZagreusHome_1516" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(0.5)
	AdjustFullscreenBloom({ Name = "Menu", Duration = 0.3 })
	AdjustColorGrading({ Name = "Ascension", Duration = 0.3 })
	AdjustColorGrading({ Name = "Off", Duration = 5.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 5.0 })
	PlaySound({ Name = args.Sound or "/Leftovers/World Sounds/Caravan Interior/SwallowDrink" })
	wait(1.0)
end

-- ending
GlobalVoiceLines = GlobalVoiceLines or {}
GlobalVoiceLines.PersephoneFirstMeetingIntermissionVoiceLines =
{
	{
		PreLineWait = 0.35,
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,

		-- Mother...!
		{ Cue = "/VO/ZagreusField_3605" },
	}
}
function TimePassesPresentation( source, args )

	if args.GlobalVoiceLines ~= nil then
		thread( PlayVoiceLines, GlobalVoiceLines[args.GlobalVoiceLines] )
	end

	if args.PersephoneMusicFullBlast ~= nil then
		SetSoundCueValue({ Names = { "Harp", "Strings", "Room", "Trombones", "WoodWinds", "Percussion" }, Id = MusicId, Value = 1, Duration = 1.2 })
		SetVolume({ Id = MusicId, Value = 1.0, Duration = 1.2 })
	end

	wait( args.PreTextWait or 1 )

	if args.HeroAnim ~= nil then
		SetAnimation({ Name = args.HeroAnim, DestinationId = CurrentRun.Hero.ObjectId })
	end

	thread( DisplayUnlockText, {
		--SupertitleText = "EasyModeUpgradedSupertitle",
		TitleText = args.Text or "LoungeIntermissionMessage",
		-- SubtitleText = args.Text,
		TextRevealSound = "/Leftovers/Menu Sounds/EmoteExcitement",
		Color = Color.Gold,
		--SupertitleTextColor = {190, 190, 190, 255},
		--SupertitleTextDelay = 1.0,
		TextColor = Color.White,
		TextOffsetY = 20,
		-- SubTextColor = {23, 255, 187, 255},
		-- Icon = EasyModeIcon,
		-- Duration = 4.35,
		-- IconMoveSpeed = 0.00001,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		--SupertitleFont = "AlegreyaSansSCRegular",
		Layer = "ScreenOverlay",
		AdditionalAnimation = "GodHoodRays",
		} )

	wait( args.PostTextWait or 5)

	-- AdjustFullscreenBloom({ Name = "Menu", Duration = 0.5 })
	-- AdjustColorGrading({ Name = "Ascension", Duration = 0.5 })
	-- AdjustColorGrading({ Name = "Off", Duration = 5.0 })
	-- AdjustFullscreenBloom({ Name = "Off", Duration = 5.0 })

	wait(1.0)
end

function MusicPracticePresentation()
	wait(1)
	PlaySound({ Name = "/SFX/LyreGood" })
	wait(2)

	thread( DisplayUnlockText, {
		--SupertitleText = "EasyModeUpgradedSupertitle",
		TitleText = "LoungeIntermissionMessage",
		-- SubtitleText = args.Text,
		TextRevealSound = "/Leftovers/Menu Sounds/EmoteExcitement",
		Color = Color.Gold,
		--SupertitleTextColor = {190, 190, 190, 255},
		--SupertitleTextDelay = 1.0,
		TextColor = Color.White,
		TextOffsetY = 20,
		-- SubTextColor = {23, 255, 187, 255},
		-- Icon = EasyModeIcon,
		-- Duration = 4.35,
		-- IconMoveSpeed = 0.00001,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		--SupertitleFont = "AlegreyaSansSCRegular",
		Layer = "ScreenOverlay",
		AdditionalAnimation = "GodHoodRays",
		} )

	wait(2)
	AdjustFullscreenBloom({ Name = "Menu", Duration = 0.3 })
	AdjustColorGrading({ Name = "Ascension", Duration = 0.3 })
	AdjustColorGrading({ Name = "Off", Duration = 5.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 5.0 })
	wait(1.0)
end

function BedroomIntermissionApproach( source, args )

	wait( 0.35 )

	AddInputBlock({ Name = "MoveHeroToRoomPosition" })
	local initialSpeed = GetUnitDataValue({ Id = CurrentRun.Hero.ObjectId, Property = "Speed", Destination})
	SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ Property = "StartGraphic", Value = nil, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "ZagreusWalk", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "Speed", Value = 130, DestinationId = CurrentRun.Hero.ObjectId })

	Move({ Id = CurrentRun.Hero.ObjectId, DestinationId = 422258, Mode = "Precise" })

	local notifyName = "ApproachStopped"
	NotifyOnStopped({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName })
	waitUntil( notifyName )

	SetUnitProperty({ Property = "StartGraphic", Value = "ZagreusStart", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "MoveGraphic", Value = "ZagreusRun", DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "Speed", Value = initialSpeed, DestinationId = CurrentRun.Hero.ObjectId })
	SetUnitProperty({ Property = "CollideWithObstacles", Value = true, DestinationId = CurrentRun.Hero.ObjectId })
	RemoveInputBlock({ Name = "MoveHeroToRoomPosition" })

	wait( 0.1 )

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = 422138 })
end

GlobalVoiceLines.MegaeraFlirtVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.55,
	ObjectType = "NPC_FurySister_01",

	-- Let's see, now...
	{ Cue = "/VO/MegaeraHome_0232" },
	-- What are we going to do.
	{ Cue = "/VO/MegaeraHome_0233" },
	-- What am I going to do with you.
	{ Cue = "/VO/MegaeraHome_0234" },
	-- Get over here, right now.
	{ Cue = "/VO/MegaeraHome_0235" },
	-- Oh I have an idea.
	{ Cue = "/VO/MegaeraHome_0236" },
	-- Ah, I know just the thing.
	{ Cue = "/VO/MegaeraHome_0237" },
}
function BedroomIntermissionPresentation( source, args )
	args = args or {}

	local megSound1 = nil
	local megSound2 = nil
	local thanSound1 = nil
	local thanSound2 = nil
	local zagSound1 = nil
	local zagSound2 = nil
	if args.UseRandomSounds then
		local megLaughSounds =
		{
			"/VO/MegaeraHome_0228",
			"/VO/MegaeraHome_0229",
			"/VO/MegaeraHome_0230",
			"/VO/MegaeraHome_0231",
		}
		megSound1 = RemoveRandomValue( megLaughSounds )
		megSound2 = RemoveRandomValue( megLaughSounds )
		local thanLaughSounds =
		{
			"/VO/Thanatos_0468",
			"/VO/Thanatos_0469",
			"/VO/Thanatos_0470",
			"/VO/Thanatos_0471",
			"/VO/Thanatos_0472",
		}
		thanSound1 = RemoveRandomValue( thanLaughSounds )
		thanSound2 = RemoveRandomValue( thanLaughSounds )
		local zagLaughSounds =
		{
			"/VO/ZagreusHome_1512",
			"/VO/ZagreusHome_1513",
			"/VO/ZagreusHome_1514",
			"/VO/ZagreusHome_1515",
			"/VO/ZagreusHome_1516",
		}
		zagSound1 = RemoveRandomValue( zagLaughSounds )
		zagSound2 = RemoveRandomValue( zagLaughSounds )
	end

	if args ~= nil and args.ExtraWaitTime ~= nil then
		wait( args.ExtraWaitTime )
	end

	if args ~= nil and args.Partner == "Thanatos" then
		wait(1)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		PlaySound({ Name = zagSound1 or "/VO/ZagreusField_2137" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		PlaySound({ Name = thanSound1 or "/VO/Thanatos_0469" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		PlaySound({ Name = zagSound2 or "/VO/ZagreusHome_1514" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = thanSound2 or "/VO/Thanatos_0468" })
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(3.0)
	elseif args ~= nil and args.Partner == "MegThan" then
		thread( PlayVoiceLines, GlobalVoiceLines.MegaeraFlirtVoiceLines, true )
		wait(2)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		PlaySound({ Name = "/VO/MegaeraHome_0228" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/VO/Thanatos_0472" })
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/VO/ZagreusHome_1516" })
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegaeraWhipFlurryAttack" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		PlaySound({ Name = "/VO/ZagreusField_2137" })
		wait(0.3)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/VO/MegaeraHome_0231" })
		wait(1.5)
		PlaySound({ Name = "/VO/ZagreusField_2308" })
		wait(2.0)
	else
		thread( PlayVoiceLines, GlobalVoiceLines.MegaeraFlirtVoiceLines, true )
		-- Megaera
		wait(2)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		PlaySound({ Name = megSound1 or "/VO/MegaeraHome_0228" })
		wait(0.5)
		PlaySound({ Name = "/SFX/Enemy Sounds/Megaera/MegaeraWhipFlurryAttack" })
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.6)
		PlaySound({ Name = "/VO/ZagreusEmotes/EmoteHurt" })
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		wait(0.5)
		PlaySound({ Name = "/Leftovers/World Sounds/CaravanCreak" })
		PlaySound({ Name = megSound2 or "/VO/MegaeraHome_0227" })
		wait(0.8)
		PlaySound({ Name = "/VO/ZagreusField_2308" })
		wait(1.5)
	end
	if args ~= nil and args.ExtraWaitTime ~= nil then
		wait( args.ExtraWaitTime )
	end
	SetThingProperty({ Property = "Graphic", Value = "ZagreusIdle", DestinationId = CurrentRun.Hero.ObjectId })
	AdjustFullscreenBloom({ Name = "Menu", Duration = 0.3 })
	AdjustColorGrading({ Name = "Ascension", Duration = 0.3 })
	AdjustColorGrading({ Name = "Off", Duration = 5.0 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 5.0 })
	wait(2.0)
	DisplayUnlockText( {
		--SupertitleText = "EasyModeUpgradedSupertitle",

		TitleText = "BedroomIntermissionMessage",
		-- SubtitleText = args.Text,
		TextRevealSound = "/Leftovers/Menu Sounds/EmoteExcitement",
		Color = Color.Pink,
		--SupertitleTextColor = {190, 190, 190, 255},
		--SupertitleTextDelay = 1.0,
		TextColor = Color.White,
		-- SubTextColor = {23, 255, 187, 255},
		-- Icon = EasyModeIcon,
		-- Duration = 4.35,
		-- IconMoveSpeed = 0.00001,
		TextOffsetY = 25,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		--SupertitleFont = "AlegreyaSansSCRegular",
		Layer = "Overlay",
		AdditionalAnimation = "GodHoodRays",
		} )

end

function StopScriptedMove( source, args )
	--@ to be extended later (maybe)
	Stop({ Id = CurrentRun.Hero.ObjectId })
end

function IncreasedTraitLevelPresentation( traitNamesImproved, numStacks )
	numStacks = numStacks or 1
	local offsetY = 0
	for traitName in pairs( traitNamesImproved ) do
		local traitTitle = traitName
		if TraitData[traitName] then 
			traitTitle = GetTraitTooltipTitle(TraitData[traitName])
		end
		CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "MegaPom_CombatText", SkipRise = false, SkipFlash = true, ShadowScale = 0.66, Duration = 1.5, OffsetY = -100 + offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitTitle, Amount = numStacks }})
		PlaySound({ Name = "/SFX/PomegranateLevelUpSFX", DestinationId = CurrentRun.Hero.ObjectId })
		offsetY = offsetY - 60
		wait(0.75)
	end
end

function ChaosHammerPresentation( traitRemoved, traitsAdded )
	CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ChaosAnvilRemove_CombatText", SkipRise = false, SkipFlash = false, ShadowScale = 0.75, Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Name = traitRemoved }})
	wait(0.75)
	local offsetY = -200
	for _, traitName in pairs( traitsAdded ) do
		PlaySound({ Name = "/SFX/WeaponUpgradeHammerPickup", DestinationId = CurrentRun.Hero.ObjectId })
		CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
		thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ChaosAnvilAdd_CombatText", SkipRise = false, SkipFlash = false, ShadowScale = 0.75, OffsetY = offsetY, Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(0.75)
		offsetY = offsetY - 60
	end
end

function RandomStoreItemPresentation( itemData )

	thread( PlayVoiceLines, GlobalVoiceLines.PurchasedRandomItemVoiceLines, true )

	wait( 0.50 )
	--AdjustColorGrading({ Name = "Mythmaker", Duration = 0.3 })

	wait( 0.5 )

	-- PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulse", DestinationId = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/Leftovers/Menu Sounds/AscensionConfirm" })
	CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "RandomStoreItem_CombatText", SkipRise = false, SkipFlash = false, Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Name = itemData.Name }})

	wait( 0.3 )
	--AdjustColorGrading({ Name = "None", Duration = 0 })
end

function StoreRewardRandomStackPresentation()

	-- CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
	-- PlaySound({ Name = "/Leftovers/SFX/TeamWipedPulse", DestinationId = CurrentRun.Hero.ObjectId })

end

function IncreasedTraitRarityPresentation( traitNamesImproved, delay )
	if delay then
		wait( delay )
	end
	local offsetY = -100
	for traitName in pairs( traitNamesImproved ) do
		PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "AmbrosiaDelight_CombatText", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScale = 0.75, ShadowScaleX = 1.28, OffsetY = offsetY, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(0.75)
		offsetY = offsetY - 60
	end
end

function HarvestBoonTraitPresentation( traitNamesImproved, delay )
	if delay then
		wait( delay )
	end
	local offsetY = -100
	for traitName in pairs( traitNamesImproved ) do
		PlaySound({ Name = "/SFX/Player Sounds/DemeterRushImpactPoof", Id = CurrentRun.Hero.ObjectId })
		thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "HarvestBoonTrait_CombatText_Initial", SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScale = 0.75, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
		wait(0.75)
		offsetY = offsetY - 60
	end
end

function BouldyBlessingPresentation( traitName )

	thread( InCombatTextArgs, { TargetId= CurrentRun.Hero.ObjectId, Text = "GainedBouldyBlessing", SkipRise = false, SkipFlash = false, Duration = 1.0, ShadowScale = 0.75, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
end

function RescueCharacterPresentation( heroId, npc, interaction )
	FreezePlayerUnit()
	AngleTowardTarget({ Id = heroId, DestinationId = npc.ObjectId })
	wait(0.25)
	SetAnimation({ Name = "ZagreusInteractEquip", DestinationId = heroId })
	-- CreateAnimation({ Name = "StatusIconSpeaking", DestinationId = heroId })
	if interaction.VoiceLines ~= nil then
		thread( PlayVoiceLines, interaction.VoiceLines, true, npc )
	elseif CurrentRun.CurrentRoom.Encounter.GreetedVoiceLines ~= nil then
		thread( PlayVoiceLines, CurrentRun.CurrentRoom.Encounter.GreetedVoiceLines )
	elseif CurrentRun.CurrentRoom.GreetedVoiceLines ~= nil then
		thread( PlayVoiceLines, CurrentRun.CurrentRoom.GreetedVoiceLines )
	end
	if interaction.Animation ~= nil then
		SetAnimation({ Name = interaction.Animation, DestinationId = npc.ObjectId })
		PlaySound({ Name = "/Leftovers/Menu Sounds/RobesInteract", DestinationId = npc.ObjectId })
		Shake({ Id = npc, Distance = 3, Speed = 900, Duration = 0.15 })
	end
	wait(0.25)
	thread( PlayVoiceLines, HeroVoiceLines.ThankingCharacterVoiceLines, true )
	StopStatusAnimation( npc, StatusAnimations.WantsToTalk )
	PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
	--thread( InCombatText, npc.ObjectId, "CharacterRescued", 3 )
	CreateAnimation({ Name = "StatusIconNPCRescued", DestinationId = npc.ObjectId })
	wait(0.1)
	UnfreezePlayerUnit()
	wait(0.75)
	CheckCodexUnlock("ChthonicGods", npc.Name, GameState.NPCInteractions[npc.Name], true )
	CheckCodexUnlock("OtherDenizens", npc.Name, GameState.NPCInteractions[npc.Name], true )
end

function SetupMegWhipTaunt( source, args )
	local megId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "NPC_FurySister_01", Distance = 800 })
	SetAnimation({ DestinationId = megId, Name = "FuryIdleInHouseFidgetWhipTaunt_Start" })
end

function DusaSuperGiftPointRefundPresentation()

	wait(1.1)

	PlaySound({ Name = "/SFX/SuperGiftAmbrosiaBottlePickup", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/SuperGiftAmbrosiaBottlePickup", Id = CurrentRun.Hero.ObjectId, Delay = 0.4 })
	PlaySound({ Name = "/SFX/SuperGiftAmbrosiaBottlePickup", Id = CurrentRun.Hero.ObjectId, Delay = 0.8 })
	PlaySound({ Name = "/SFX/SuperGiftAmbrosiaBottlePickup", Id = CurrentRun.Hero.ObjectId, Delay = 1.2 })
	AddResource( "SuperGiftPoints", 10, "Item" )
	-- thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "Dusa_Refund", SkipRise = false, SkipFlash = false, Duration = 1.5 })

end

function HadesGiftPointRefundPresentation()

	wait(1.1)

	PlaySound({ Name = "/SFX/GiftAmbrosiaBottlePickup", Id = CurrentRun.Hero.ObjectId })
	PlaySound({ Name = "/SFX/GiftAmbrosiaBottlePickup", Id = CurrentRun.Hero.ObjectId, Delay = 0.4 })
	PlaySound({ Name = "/SFX/GiftAmbrosiaBottlePickup", Id = CurrentRun.Hero.ObjectId, Delay = 0.8 })
	AddResource( "GiftPoints", 5, "Item" )

end

function SpecialAudioPresentation( source, args )

	wait( args.Delay or 0 )

	PlaySound({ Name = args.SoundName or "/EmptyCue"  })

end

function MaxedRelationshipPresentation( source, args )

	wait( args.Delay or 2.0 )

	DisplayUnlockText( {
		--SupertitleText = "EasyModeUpgradedSupertitle",
		TitleText = args.Title or "MaxedRelationship",
		SubtitleText = args.Text,
		TextRevealSound = args.TextRevealSound or "/Leftovers/Menu Sounds/EmoteAffection",
		TextOffsetY = args.TextOffsetY,
		Color = {0, 255, 168, 255},
		--SupertitleTextColor = {190, 190, 190, 255},
		--SupertitleTextDelay = 1.0,
		TextColor = args.TextColor or Color.White,
		SubTextColor = {23, 255, 187, 255},
		Icon = args.Icon,
		IconOffsetY = args.IconOffsetY or 6,
		IconScale = args.IconScale or 0.635,
		Duration = 4.35,
		IconMoveSpeed = 0.00001,
		TitleFont = "SpectralSCLightTitling",
		SubtitleFont = "SpectralSCLightTitling",
		--SupertitleFont = "AlegreyaSansSCRegular",
		Layer = "Combat_Menu_TraitTray_Overlay",
		AdditionalAnimation = "GodHoodRays",
		AnimationName = args.AnimationName or "LocationTextBGRelationship",
		AnimationOutName = args.AnimationOutName or "LocationTextBGRelationshipOut",
		} )

	if args.DoHadesRefund then
		thread( HadesGiftPointRefundPresentation )
	end

end

function KeyAchievementPresentation( source, args )

	AddInputBlock({ Name = "KeyAchievementPresentation" })
	HideCombatUI("KeyAchievementPresentation")

	wait( args.Delay or 0.2 )

	PlaySound({ Name = args.Sound or "/Music/VictoryStinger" })

	thread( DisplayLocationText, nil, { Text = args.Title, Delay = 0.2, OffsetY = 0, Color = Color.White, FadeColor = Color.Gold, TextDelay = 2.5, Duration = 4, TextOffsetY = -180, AnimationName = "EndFrameIn", AnimationOutName = "EndFrameOut", Layer = "ScreenOverlay" } )

	wait( 7.3 )

	RemoveInputBlock({ Name = "KeyAchievementPresentation" })
	UnblockCombatUI("KeyAchievementPresentation")

end


function PlayEmoteAnimFromSource( source, args, screen, line )

	wait( args.WaitTime, NarrativeThreadName )

	local newPortrait = args.Portrait
	if args.Portrait ~= nil then
		if screen.CurrentPortrait ~= nil and screen.CurrentPortrait ~= newPortrait then
			SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait.."_Exit" })
			wait( line.PortraitExitWait or 0.3 )

			screen.CurrentPortrait = newPortrait
			SetAnimation({ DestinationId = screen.PortraitId, Name = screen.CurrentPortrait })
		end
	end

	if args.Anim ~= nil then
		local targetId = args.AnimTarget or source.ObjectId
		if args.AnimTarget == "Hero" then
			targetId = CurrentRun.Hero.ObjectId
		end
		SetAnimation({ Name = args.Anim, DestinationId = targetId })
	end

	if args.DoShake then
		Flash({ Id = screen.PortraitId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.5, ExpireAfterCycle = true })
		Shake({ Id = screen.PortraitId, Distance = 5, Speed = 600, Duration = 1.0, FalloffSpeed = 2000, })
	end

	if args.DoFlash then

		AdjustColorGrading({ Name = "Team02", Duration = 0.1 })
		AdjustFullscreenBloom({ Name = "NewType07", Duration = 0.1 })

		wait(0.3)
		PlaySound({ Name = "/SFX/Player Sounds/ZagreusGuanYuSpearSpin"  })

		AdjustColorGrading({ Name = "Off", Duration = 0.75 })
		AdjustFullscreenBloom({ Name = "Off", Duration = 0.75 })

	end

	if args.Emote ~= "None" then
		CreateAnimation({ Name = args.Emote, DestinationId = screen.PortraitId, OffsetX = source.EmoteOffsetX, OffsetY = source.EmoteOffsetY })
	end

end

function PowerWordPresentation( source, args, screen, line )

	wait( args.WaitTime, NarrativeThreadName )

	Flash({ Id = screen.PortraitId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.5, ExpireAfterCycle = true })
	Shake({ Id = screen.PortraitId, Distance = 2, Speed = 200, Duration = 1.0, Angle = 0 })

	PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuOpenREMEMBRANCE" })
	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	AdjustColorGrading({ Name = "Mythmaker", Duration = 0.3 })
	AdjustFullscreenBloom({ Name = "NewType07", Duration = 0.1 })

	ShakeScreen({ Speed = 900, Distance = 8, FalloffSpeed = 2000, Duration = 1.05 })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 1.0 }, } )
	wait(0.5)
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })
	AdjustColorGrading({ Name = "Off", Duration = 3.0 })

end

function PowerWordPresentationFlashback( source, args, screen, line )

	wait( args.WaitTime, NarrativeThreadName )

	Flash({ Id = screen.PortraitId, Speed = 0.85, MinFraction = 0.7, MaxFraction = 0.0, Color = Color.White, Duration = 0.5, ExpireAfterCycle = true })
	Shake({ Id = screen.PortraitId, Distance = 2, Speed = 200, Duration = 1.0, Angle = 0 })

	PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuOpenREMEMBRANCE" })
	PlaySound({ Name = "/Leftovers/World Sounds/ThunderHuge" })
	AdjustColorGrading({ Name = "Mythmaker", Duration = 0.3 })
	AdjustFullscreenBloom({ Name = "NewType07", Duration = 0.1 })

	ShakeScreen({ Speed = 900, Distance = 8, FalloffSpeed = 2000, Duration = 1.05 })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 1.0 }, } )
	wait(0.5)
	AdjustFullscreenBloom({ Name = "Off", Duration = 1.0 })
	AdjustColorGrading({ Name = "Sepia", Duration = 3.0 })

end

-- copied from LegendaryAspectPresentation()
function PowerWordPresentationWorld( source, args )

	args = args or {}
	wait( args.WaitTime or 0 )

	AdjustColorGrading({ Name = "WeaponKitInteract", Duration = 0.2 })
	AdjustFullscreenBloom({ Name = "Subtle", Duration = 0.2 })
	PlaySound({ Name = "/Leftovers/Menu Sounds/TextReveal5FilterSweep"  })

	ScreenAnchors.FullscreenAlertFxAnchor = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Events", X = ScreenCenterX, Y = ScreenCenterY })

	local interactVignette = CreateAnimation({ Name = "WeaponKitInteractVignette", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = interactVignette })

	--local fullscreenAlertDisplacementFx = SpawnObstacle({ Name = "FullscreenAlertDisplace", Group = "FX_Displacement", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	--DrawScreenRelative({ Id = fullscreenAlertDisplacementFx })

	local fullscreenAlertColorFx = SpawnObstacle({ Name = "FullscreenAlertColorInvert", Group = "FX_Add_Top", DestinationId = ScreenAnchors.FullscreenAlertFxAnchor })
	DrawScreenRelative({ Id = fullscreenAlertColorFx })

	ShakeScreen({ Speed = 600, Distance = 6, FalloffSpeed = 2000, Duration = 0.3 })

	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.5 }, } )

	wait( 2.4 )

	AdjustColorGrading({ Name = "Off", Duration = 0.8 })
	AdjustFullscreenBloom({ Name = "Off", Duration = 0.8 })
	SetAlpha({ Id = fullscreenAlertColorFx, Fraction = 0, Duration = 0.45 })
	SetAlpha({ Id = fullscreenAlertDisplacementFx, Fraction = 0, Duration = 0.45 })
	thread( DestroyOnDelay, { fullscreenAlertColorFx, fullscreenAlertDisplacementFx }, 1.0 )

end

function SkellyBackstoryPresentationStart()

	StopSecretMusic()
	StopMusicianMusic( nil, { Duration = 0.2 } )

	SecretMusicPlayer( "/Music/MusicExploration3_MC" )
	SetSoundCueValue({ Names = { "Drums" }, Id = SecretMusicId, Value = 0 })

	AdjustColorGrading({ Name = "Sepia", Duration = 4.0 })

	PlaySound({ Name = "/Leftovers/World Sounds/MapZoomSlow" })

end

function SkellyBackstoryPresentationEnd()

	AdjustColorGrading({ Name = "Off", Duration = 4.0 })

end

function PlayPreLineTauntAnimFromSource( source, args )
	if source ~= nil and source.TauntAnimation ~= nil then
		SetAnimation({ Name = source.TauntAnimation, DestinationId = source.ObjectId })
	end
end

function PlayFistSlamAnimFromSource( source, args )
	if source ~= nil then
		SetAnimation({ Name = "Hades_HouseFistSlam", DestinationId = source.ObjectId })
		wait(0.55)
		ShakeScreen({ Speed = 500, Distance = 2, Duration = 0.3 })
		Shake({ Id = 392231, Distance = 1, Speed = 100, Duration = 0.3 })
	end
end

function HadesBattleKnockDownPreRecoverPresentation( boss )
	SetAnimation({ Name = "HadesBattleKnockDown_PreRecover", DestinationId = boss.ObjectId })
	wait(0.25)
	ShakeScreen({ Speed = 600, Distance = 2, Duration = 0.8, FalloffSpeed = 2000 })
end

function HydraStageTransition(boss, currentRun, aiStage)
	local bossId = boss.ObjectId

	Move({ Id = boss.ObjectId, DestinationId = boss.ResetPositionId, SuccessDistance = 100, Mode = "Default" })
	wait( 0.6, boss.AIThreadName )
	Stop({ Id = boss.ObjectId })
	AngleTowardTarget({ Id = boss.ObjectId, DestinationId = currentRun.Hero.ObjectId })

	if aiStage.TransitionAnimation then
		SetAnimation({ DestinationId = bossId, Name = boss.SwapAnimations[aiStage.TransitionAnimation] or aiStage.TransitionAnimation })
	end
	if aiStage.TransitionSound then
		PlaySound({ Name = aiStage.TransitionSound })
	end
	if aiStage.CombatText ~= nil then
		thread( InCombatText, bossId, aiStage.CombatText, 1.0 )
	end

	if aiStage.StageTransitionVoiceLines ~= nil and not boss.IsDead then
		thread( PlayVoiceLines, aiStage.StageTransitionVoiceLines, nil, boss )
	end
	if aiStage.StageTransitionGlobalVoiceLines ~= nil and not boss.IsDead then
		thread( PlayVoiceLines, GlobalVoiceLines[aiStage.StageTransitionGlobalVoiceLines], nil, boss )
	end

	wait( aiStage.StartDelay or 4.0, boss.AIThreadName )
	SetAI( AttackerAI, boss, currentRun )
end

function HydraFinalStageTransition(boss, currentRun, aiStage)
	HandleTetherParentDeath( boss, boss.DetachedNeckCount, boss.DetachedNeckAnimation )
	SetUnitProperty({ Property = "Speed", Value = boss.DetachedMoveSpeed, DestinationId = boss.ObjectId })
	HydraStageTransition(boss, currentRun, aiStage)
end

function TheseusChariotDismount( boss, currentRun, aiStage )
	Stop({ Id = boss.ObjectId })
	boss.AIDisabled = true
	if boss.PreAttackLoopingSoundId ~= nil then
		StopSound({ Id = boss.PreAttackLoopingSoundId, Duration = 0.2 })
	end
    SetUnitProperty({ Property = "MoveGraphic", Value = "Theseus_Walk", DestinationId = boss.ObjectId })
    SetUnitProperty({ Property = "CanOnlyMoveForward", Value = false, DestinationId = boss.ObjectId })
    SetUnitProperty({ Property = "CollisionWeaponRequiredVelocity", Value = "500", DestinationId = boss.ObjectId })
    SetUnitProperty({ Property = "HaltOnSlowMovement", Value = true, DestinationId = boss.ObjectId })
    SetUnitProperty({ Property = "InitiatedCollisionWeapon", Value = "null", DestinationId = boss.ObjectId })
    SetUnitProperty({ Property = "RotationSpeed", Value = "1500", DestinationId = boss.ObjectId })
    SetUnitProperty({ Property = "Speed", Value = "300", DestinationId = boss.ObjectId })
    SetLifeProperty({ Property = "InvulnerableCoverage", Value = math.rad(140), DestinationId = boss.ObjectId, DataValue = false })
    SetLifeProperty({ Property = "HitSound", Value = "/SFX/Enemy Sounds/Theseus/EmoteHurt", DestinationId = boss.ObjectId})
    SetThingProperty({ Property = "Graphic", Value = "Theseus_Idle", DestinationId = boss.ObjectId })
    boss.Material = "Organic"
	SetAnimation({ DestinationId = boss.ObjectId, Name = "TheseusChariot_Fall" })
	local dismountLocation = SpawnObstacle({ DestinationId = boss.ObjectId, Name = "BlankObstacle", Group = "Standing" })
	CreateAnimation({ DestinationId = dismountLocation, Name = "GrenadeExplosion" })
	ApplyForce({ Id = boss.ObjectId, Speed = GetVelocity({ Id = boss.ObjectId }) * boss.DismountSpeedMultiplier, Angle = GetAngle({ Id = boss.ObjectId }) })
	boss.Dismounted = true
	boss.ChainedWeapon = nil
	thread(LastKillPresentation, boss )
	thread( PlayVoiceLines, GlobalVoiceLines.TheseusChariotRuinedVoiceLines, true )

	thread( CrowdReactionPresentation, { AnimationNames = { "StatusIconEmbarrassed", "StatusIconOhBoy" }, Sound = "/SFX/TheseusCrowdBoo", ReactionChance = 0.1, Delay = 1, Requirements = { RequiredRoom = "C_Boss01" } } )

	wait(boss.DismountWaitDuration)

	boss.AIDisabled = false
	BossStageTransition( boss, currentRun, aiStage )

	Destroy({ Id = dismountLocation })
end

function HypnosReturnToSleep( source, args )

	if CurrentRun.EventState[source.ObjectId] ~= nil then
		-- Already running
		return
	end

	if TextLinesRecord["ThanatosWithHypnos06"] then
		if args.LowChanceToPlay ~= nil and not RandomChance( args.LowChanceToPlay ) then
			return
		end
	else
		if args.HighChanceToPlay ~= nil and not RandomChance( args.HighChanceToPlay ) then
			return
		end
	end

	CurrentRun.EventState[source.ObjectId] = { FunctionName = "HypnosReturnToSleep", Args = args }

	while true do

		wait( RandomFloat( args.RandomWaitMin, args.RandomWaitMax ), RoomThreadName )

		local notifyName = "HypnosReturnToSleep"
		NotifyOutsideDistanceAll({ Id = CurrentRun.Hero.ObjectId, DestinationId = source.ObjectId, Distance = args.OutsideDistance, Notify = notifyName })
		waitUntil( notifyName )

		-- Back to Sleep
		SetAnimation({ Name = args.OutsideAnimation, DestinationId = source.ObjectId })
		CreateAnimation({ Name = args.OutsideVfx, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
		thread( PlayVoiceLines, GlobalVoiceLines[args.OutsideGlobalVoiceLines], true )
		wait( 2.0, RoomThreadName )

		SetAnimation({ Name = args.OutsideAnimation, DestinationId = source.ObjectId })

		notifyName = "HypnosWakeup"
		NotifyWithinDistanceAny({ Ids = { CurrentRun.Hero.ObjectId }, DestinationIds = { source.ObjectId }, Distance = args.InsideDistance, Notify = notifyName })
		waitUntil( notifyName )

		-- Wakeup
		SetAnimation({ Name = args.InsideAnimation, DestinationId = source.ObjectId })
		StopAnimation({ Name = args.OutsideVfx, DestinationId = source.ObjectId })
		CreateAnimation({ Name = args.InsideVfx, DestinationId = source.ObjectId, OffsetX = source.AnimOffsetX, OffsetZ = source.AnimOffsetZ, Group = "Combat_UI_World" })
		thread( PlayVoiceLines, GlobalVoiceLines[args.InsideGlobalVoiceLines], true )
		Flash({ Id = source.ObjectId, Speed = 1, MinFraction = 0.8, MaxFraction = 0.0, Color = Color.White, ExpireAfterCycle = true })
		Shake({ Id = source.ObjectId, Distance = 3, Speed = 150, Duration = 0.65 })

	end
end

function WretchedBrokerReaction( args )

	PlaySound({ Name = "/SFX/Enemy Sounds/PunchingBag/EmoteDizzy", Id = 423390 })
	thread( PlayEmote, { TargetId = 423390, AnimationName = "StatusIconSmile", OffsetZ = 100 })

end

GlobalVoiceLines.MegEmployeeSignReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.55,
	ObjectType = "NPC_FurySister_01",
	PreLineAnim = "FuryIdleInHouseFidgetWhipTaunt",
	RequiredSourceValueFalse = "InPartnerConversation",
	SubtitleMinDistance = 1200,

	-- <Laughter>
	{ Cue = "/VO/MegaeraHome_0229", RequiredTextLines = { "MegaeraGift05" }, },
	-- <Laughter>
	{ Cue = "/VO/MegaeraHome_0230", RequiredTextLines = { "MegaeraGift05" }, },
	-- How very thoughtful, I guess?
	{ Cue = "/VO/MegaeraHome_0335", RequiredFalseTextLines = { "MegaeraGift10" }, PreLineAnim = "FuryIdleInHouseFidgetGreeting" },
	-- Get away from me.
	{ Cue = "/VO/MegaeraHome_0281", RequiredFalseTextLines = { "MegaeraGift05" }, PreLineAnim = "FuryIdleInHouseFidgetGreeting" },
	-- Leave me alone.
	{ Cue = "/VO/MegaeraHome_0282", RequiredFalseTextLines = { "MegaeraGift05" }, PreLineAnim = "FuryIdleInHouseFidgetGreeting" },
	-- Get out of here.
	{ Cue = "/VO/MegaeraHome_0283", RequiredFalseTextLines = { "MegaeraGift05" }, PreLineAnim = "FuryIdleInHouseFidgetGreeting" },
	-- Yes.
	{ Cue = "/VO/MegaeraHome_0255", PreLineAnim = "FuryIdleInHouseFidgetGreeting" },
	-- Appreciate it.
	{ Cue = "/VO/MegaeraHome_0257", RequiredTextLines = { "MegaeraGift07" }, PreLineAnim = "FuryIdleInHouseFidgetGreeting" },
	-- Thanks.
	{ Cue = "/VO/MegaeraHome_0259", RequiredTextLines = { "MegaeraGift05" }, PreLineAnim = "FuryIdleInHouseFidgetGreeting" },
	-- Thanks.
	{ Cue = "/VO/MegaeraHome_0260", RequiredTextLines = { "MegaeraGift05" }, PreLineAnim = "FuryIdleInHouseFidgetGreeting" },
}
function MegEmployeeSignReaction( args )
	thread( PlayVoiceLines, GlobalVoiceLines.MegEmployeeSignReactionVoiceLines, true )
end

function HouseContractorReaction( args )

	wait( 1.4 )
	thread( PlayEmote, { TargetId = 427173, AnimationName = "StatusIconEmbarrassed", OffsetZ = 125 })

end

function ActivateOlympusSculpture()

	local obstacle = DeepCopyTable( DeathLoopData.DeathArea.ObstacleData[556697] )
	obstacle.ObjectId = 556697
	obstacle.SetupGameStateRequirements = nil
	SetupObstacle( obstacle )
end

function PlayEmote( args )
	args.TargetId = args.TargetId or args.Target.ObjectId
	args.Target = args.Target or MapState.ActiveObstacles[args.TargetId]
	if args.Target == nil or args.Target.Emotes == nil then
		DebugPrint({ Text="PlayEmote Target data does not exist" })
		return
	end

	local emoteData = args.Target.Emotes[args.EmoteName] or {}
	local animationName = args.AnimationName or emoteData.AnimationName
	local soundName = args.SoundName or emoteData.SoundName

	if animationName == nil then
		return
	end

	local delay = RandomFloat( args.delayMin or 0.1, args.DelayMax or 0.4 )
	local duration = RandomFloat( args.DurationMin or 1, args.DurationMax or 2 )

	wait( delay, RoomThreadName )

	if MapState.ActiveObstacles[args.TargetId] == nil then
		return
	end

	CreateAnimation({ Name = animationName, DestinationId = args.TargetId, Group = "Combat_UI_World", OffsetZ = args.OffsetZ or args.Target.EmoteOffsetZ })
	if args.PlaySound and soundName ~= nil then
		PlaySound({ Name = soundName, Id = args.TargetId })
	end
	if args.Shake then
		Shake({ Id = args.TargetId, Speed = 150, Distance = 1.25, Duration = duration })
	end

	-- Clean up
	wait( duration, RoomThreadName )
	if MapState.ActiveObstacles[args.TargetId] == nil then
		return
	end
	StopAnimation({ Name = animationName, DestinationId = args.TargetId, Group = "Combat_UI_World" })
	CreateAnimation({ Name = animationName.."_End", DestinationId = args.TargetId, Group = "Combat_UI_World", OffsetZ = args.OffsetZ or args.Target.EmoteOffsetZ })
end

function CheckResumeGhostProcession( source, args, textLines )
	if textLines.UseableOffSource and not textLines.IgnoreResumeGhostProcessionOnUseableOff then
		thread( ActivateGhostProcession )
	end
end

function CheckMegDusaGossiping( source, args, textLines )
	if textLines.UseableOffSource and textLines.BeginGossipingOnUseableOff then
		thread( ActivateMegDusaGossiping, source, args )
	end
end

function GenericPresentation( source, args )

	if args.OverwriteSourceKeys ~= nil then
		for key, value in pairs( args.OverwriteSourceKeys ) do
			source[key] = value
		end
	end

	if args.SetAnimation ~= nil then
		SetAnimation({ Name = args.SetAnimation, DestinationId = source.ObjectId })
	end

	if args.Sound ~= nil then
		PlaySound({ Name = args.Sound, Id = source.ObjectId })
	end

	if args.FadeOutIds ~= nil then
		SetAlpha({ Ids = args.FadeOutIds, Fraction = 0.0, Duration = args.Duration or 0.3 })
	end

	if args.DisableIds ~= nil then
		UseableOff({ Ids = args.DisableIds })
	end

	if args.ActivateIds ~= nil then
		Activate({ Ids = args.ActivateIds })
	end

	if args.AngleTowardTarget ~= nil then
		AngleTowardTarget({ Id = source.ObjectId, DestinationId = args.AngleTowardTarget })
	end

end

GlobalVoiceLines.UnwrappedLootVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.55,
	SuccessiveChanceToPlayAll = 0.2,
	UsePlayerSource = true,

	-- Who is it?
	{ Cue = "/VO/ZagreusField_3798" },
	-- Let's see who I get.
	{ Cue = "/VO/ZagreusField_3799" },
	-- Show yourself, Mystery God.
	{ Cue = "/VO/ZagreusField_3800" },
	-- Who's this, then?
	{ Cue = "/VO/ZagreusField_3801" },
	-- Still in their packaging.
	{ Cue = "/VO/ZagreusField_3802" },
	-- Who'd I get?
	{ Cue = "/VO/ZagreusField_3803" },
}
function UnwrapLootPresentation( reward )

	thread( PlayVoiceLines, reward.BlindBoxOpenedVoiceLines, true )

	--[[
	if CoinFlip() then
		thread( PlayVoiceLines, reward.BlindBoxOpenedVoiceLines, true )
	else
		thread( PlayVoiceLines, GlobalVoiceLines.UnwrappedLootVoiceLines, true )
	end


	thread( PlayVoiceLines, GlobalVoiceLines.UnwrappedLootVoiceLines, true )

	wait( 0.5 )

	thread( PlayVoiceLines, reward.BlindBoxOpenedVoiceLines, true )

	wait( 2.5 )
	]]--

end

function SetupPersephoneMusic( eventSource, args )
	args = args or {}
	local stems = { "Room", "Trombones", "Percussion", "WoodWinds" }
	if args.FullBlast then
		SetSoundCueValue({ Names = { "Harp", "Strings", "Room", "WoodWinds", "Trombones", "Percussion" }, Id = MusicId, Value = 1, Duration = 1.25 })
		SetVolume({ Id = MusicId, Value = 1, Duration = 10 })
	elseif args.Mom then
		stems = { "Room", "Trombones", "WoodWinds" }
		SetSoundCueValue({ Names = stems, Id = MusicId, Value = 0, Duration = 3 })
		SetVolume({ Id = MusicId, Value = 0.95, Duration = 3 })
	elseif args.Son then
		stems = { "Room", "Trombones", "Percussion" }
		SetSoundCueValue({ Names = stems, Id = MusicId, Value = 0, Duration = 3 })
		SetVolume({ Id = MusicId, Value = 0.95, Duration = 3 })
	else
		SetSoundCueValue({ Names = stems, Id = MusicId, Value = 0, Duration = 3 })
		SetVolume({ Id = MusicId, Value = 0.95, Duration = 3 })
	end
end

function AddKeepsakeChargePresentation( traitData )
	local existingUITrait = GetExistingUITrait( traitData )
	if existingUITrait then
		CreateAnimation({ Name = "NewTraitHighlight", DestinationId = existingUITrait.AnchorId })
	end
end