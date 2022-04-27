function BadgePurchasePresentation( usee, badgeData )

	DebugPrint({ Text = "Badge level = "..GameState.BadgeRank })

	local args = { WaitTime = 0.5 }
	thread( PowerWordPresentationWorld )

	StopAnimation({ Name = badgeData.Icon, DestinationId = usee.ObjectId })
	DestroyTextBox({ Id = usee.ObjectId })

	AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = usee.ObjectId })

	FreezePlayerUnit()
	AddInputBlock({ Name = "BadgePurchasePresentation" })
	--ZeroMouseTether( "BadgePurchasePresentation" )

	GameState.Flags.CosmeticPresentationActive = true

	local ghostAdminId = GetClosestUnitOfType({ Id = CurrentRun.Hero.ObjectId, DestinationName = "BartenderGhost01", Distance = 400 })
	PlaySound({ Name = "/SFX/GhostEvaporate", Id = ghostAdminId, Delay = 1.5 })

	--PlaySound({ Name = "/SFX/Menu Sounds/ContractorItemPurchase" }) -- moved to BadgeResourceSpendPresentation

	-- preactivate presentation
	--local cameraTarget = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, OffsetY = -200 })
	--PanCamera({ Id = cameraTarget, Duration = badgeData.PanDuration or 1.0, Retarget = true, FromCurrentLocation = true })

	if badgeData.RevealGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines[badgeData.RevealGlobalVoiceLines] )
		wait(0.25)
	elseif badgeData.RevealVoiceLines then
		thread( PlayVoiceLines, badgeData.RevealVoiceLines )
	end

	if badgeData.UseUnlockText then
		DebugPrint({ Text="BadgePresentation.lua:33 "..badgeData.BadgeIconOffsetX })
		thread( DisplayUnlockText, {
			TitleText = badgeData.UnlockTextId or "BadgePurchased",
			SubtitleText = badgeData.Name,
			Icon = badgeData.Icon,
			TextRevealSound = "/SFX/Menu Sounds/WeaponUnlockBoom",
			Delay = 1.2,
			Duration = 3.5,
			FontScale = 1,
			IconMoveSpeed = 0.00001,
			IconScale = badgeData.BadgeIconScale or 0.4,
			IconOffsetX = badgeData.BadgeIconOffsetX or 0,
			IconOffsetY = badgeData.BadgeIconOffsetY or 14,
		})
	end
	if badgeData.SetPlayerAnimation then
		SetAnimation({ Name = badgeData.SetPlayerAnimation, DestinationId = CurrentRun.Hero.ObjectId })
	end

	wait( badgeData.PreActivationHoldDuration or 0.5 )

	if badgeData.ItemPreActivationVfx then
		CreateAnimation({ Name = badgeData.ItemPreActivationVfx, DestinationId = id })
	end

	wait(0.5)

	if badgeData.UseItemActivationVfx then
		CreateAnimation({ Name = badgeData.ItemActivationVfx or "CosmeticUnlockFx", DestinationId = badgeData.ItemActivationVfxId or id, OffsetY = badgeData.ItemActivationVfxOffsetY or 0 })
	end

	if badgeData.RevealReactionGlobalVoiceLines and not badgeData.SkipRevealReactionGlobalVoiceLines then
		thread( PlayVoiceLines, GlobalVoiceLines[badgeData.RevealReactionGlobalVoiceLines] )
	elseif badgeData.RevealReactionVoiceLines then
		thread ( PlayVoiceLines, badgeData.RevealReactionVoiceLines, true )
	end

	wait( badgeData.PostActivationHoldDuration or 0.5 )

	--wait(0.25)

	--PanCamera({ Id = CurrentRun.Hero.ObjectId, Duration = 1.0 })
	wait(0.75)
	RemoveInputBlock({ Name = "BadgePurchasePresentation" })
	GameState.Flags.CosmeticPresentationActive = false
	UnfreezePlayerUnit()
	--UnzeroMouseTether( "BadgePurchasePresentation" )

	thread( PlayEmote, { TargetId = usee.ObjectId, AnimationName = usee.MadeSaleEmote, OffsetZ = usee.EmoteOffsetZ } )

end

function BadgeResourceSpendPresentation( usee, resourceCost )
	PlayInteractAnimation( usee.ObjectId, { SkipInputBlock = true })
	local resourceData = ResourceData[resourceCost.Name]
	PlaySound({ Name = resourceData.SpendSound or "/SFX/Menu Sounds/ContractorItemPurchase" })
	wait(0.35)
end

function ShowNextBadgeForPurchase( source, args )
	local nextRank = (GameState.BadgeRank or 0) + 1
	local nextBadgeData = GameData.BadgeData[GameData.BadgeOrderData[nextRank]]
	if nextBadgeData == nil then
		-- Maxed out
		UseableOff({ Id = source.ObjectId })
		return
	end

	--DebugPrint({ Text = "nextRank = "..nextRank })

	source.NextBadgeIcon = nextBadgeData.Icon
	source.UseText = "UseBadgeSeller"
	--CreateAnimation({ Name = nextBadgeData.Icon, DestinationId = source.ObjectId, OffsetZ = 380, Group = "Standing" })

	local costOffsetY = -230
	for k, resourceCost in pairs( nextBadgeData.ResourceCost ) do
		local costFontColor = Color.CostAffordable
		if not HasResource( resourceCost.Name, resourceCost.Amount ) then
			costFontColor = Color.CostUnaffordable
		end
		CreateTextBox({
			Id = source.ObjectId,
			Text = ResourceData[resourceCost.Name].CostText,
			TextSymbolScale = 0.8,
			LuaKey = "TempTextData",
			LuaValue = { Amount = resourceCost.Amount },
			FontSize = 24,
			OffsetY = costOffsetY,
			Color = costFontColor,
			Justification = "CENTER",
			Font="AlegreyaSansSCBold",
			FontSize = 36,
			ShadowColor = {0,0,0,1},
			ShadowOffset = {0,2},
			ShadowAlpha = 1,
			ShadowBlur = 0,
			OutlineColor= {0,0,0,1},
			OutlineThickness = 2,
		})
		costOffsetY = costOffsetY - 50
	end

end

function BadgeCannotAffordPresentation( usee, nextBadgeData )

	PlaySound({ Name = "/Leftovers/SFX/OutOfAmmo" })
	ModifyTextBox({ Id = usee.ObjectId, ColorTarget = Color.GhostWhite, ScaleTarget = 1.05 })
	ModifyTextBox({ Id = usee.ObjectId, ColorTarget = Color.Red, ColorDuration = 0.2, ScaleTarget = 1.0, Delay = 0.1 })
	Shake({ Id = usee.ObjectId, Distance = 1, Speed = 100, Duration = 0.3 })
	thread( DoRumble, { { ScreenPreWait = 0.02, RightFraction = 0.15, Duration = 0.15 }, } )
	thread( PlayVoiceLines,  GlobalVoiceLines.CannotAffordBadgeVoiceLines, true )
	if CheckCooldown( "FailedToBuyBadge", 4.0 ) then
		thread( PlayEmote, { TargetId = usee.ObjectId, AnimationName = usee.NoSaleEmote, OffsetZ = usee.EmoteOffsetZ, Delay = 0.4 } )
	end

end