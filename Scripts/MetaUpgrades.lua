function GetMetaUpgradePurchasePrice( metaUpgrade )
	return GetMetaUpgradePrice(metaUpgrade, GetNumMetaUpgrades( metaUpgrade.Name ))
end

function GetMetaUpgradeRefundPrice( metaUpgrade, args )
	local refund = GetMetaUpgradePrice( metaUpgrade, GetNumMetaUpgrades( metaUpgrade.Name, args ) - 1 )
	if not GameState.MetaUpgradeState[ metaUpgrade.Name ] then
		return refund
	end
	if not IsMetaUpgradeActive( metaUpgrade.Name, args ) then
		refund = GetMetaUpgradePrice( metaUpgrade, GameState.MetaUpgradeState[ metaUpgrade.Name ] - 1 )
	end
	return refund or 0
end

function GetMetaUpgradeTotalInvestment( metaUpgrade )
	local total = 0
	for i = 1, GetNumMetaUpgrades( metaUpgrade.Name ) do
		local price = GetMetaUpgradePrice( metaUpgrade, i - 1 )
		if price ~= nil then
			total = total + price
		end
	end
	return total
end

function GetMetaUpgradePrice( metaUpgrade, index )
	if metaUpgrade.CostTable then
		return metaUpgrade.CostTable[index + 1]
	else
		if metaUpgrade.MaxInvestment ~= nil and metaUpgrade.MaxInvestment <= index then
			return nil
		end
		local additionalCost = 0
		if metaUpgrade.CostIncreaseInterval ~= nil and metaUpgrade.CostIncreaseInterval > 0 then
			additionalCost = math.floor(index / metaUpgrade.CostIncreaseInterval) * metaUpgrade.CostIncrease
		end
		return metaUpgrade.Cost + additionalCost
	end
end

function GetBaseAmmoReloadTime()
	return MetaUpgradeData.ReloadAmmoMetaUpgrade.BaseValue + (GetNumMetaUpgrades("ReloadAmmoMetaUpgrade") * MetaUpgradeData.ReloadAmmoMetaUpgrade.ChangeValue)
end

function GetTotalMetaUpgradeChangeValue( metaUpgradeName )
	local numUpgrades = GetNumMetaUpgrades( metaUpgradeName )
	if MetaUpgradeData[metaUpgradeName].ChangeValues then
		return MetaUpgradeData[metaUpgradeName].ChangeValues [numUpgrades] or 0
	end
	return 1 + numUpgrades * ( MetaUpgradeData[metaUpgradeName].ChangeValue - 1 )
end

function GetNumMetaUpgradeLastStands()
	return GetNumMetaUpgrades("ExtraChanceMetaUpgrade") + GetNumMetaUpgrades("ExtraChanceReplenishMetaUpgrade")
end

function CalculateMetaPointMultiplier()
	local totalMetaPointMultiplier = 1.0
	for key, upgradeName in pairs( CurrentRun.EnemyUpgrades ) do
		local upgradeData = EnemyUpgradeData[upgradeName]
		if upgradeData.MetaPointMultiplier then
			totalMetaPointMultiplier = totalMetaPointMultiplier + (upgradeData.MetaPointMultiplier - 1)
		end
	end
	return totalMetaPointMultiplier * GetTotalHeroTraitValue("MetaPointMultiplier", {IsMultiplier = true})
end

function CalculateHealingMultiplier()
	return ( 1 - GetNumMetaUpgrades("HealingReductionShrineUpgrade") * ( MetaUpgradeData.HealingReductionShrineUpgrade.ChangeValue - 1 ) ) * GetTotalHeroTraitValue("TraitHealingBonus", {IsMultiplier = true })
end
function CalculatePositiveHealingMultiplier()
	return GetTotalHeroTraitValue("TraitHealingBonus", {IsMultiplier = true })
end

function CalculateMythPointMultiplier()
	local mythPointMultiplier = GetTotalHeroTraitValue("MythPointMultiplier", { IsMultiplier = true })

	for key, upgradeName in pairs( CurrentRun.EnemyUpgrades ) do
		local upgradeData = EnemyUpgradeData[upgradeName]
		if upgradeData.MythPointMultiplier then
			mythPointMultiplier = mythPointMultiplier + (upgradeData.MythPointMultiplier - 1)
		end
	end
	return mythPointMultiplier
end

function MetaUpgradePresentation( metaUpgrade )
	CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = 40002, Scale = 3.0 })
end

OnUsed{ "MetaUpgradeScreen",
	function( triggerArgs )
		-- give metapoints if it's the first run and the player still has none
		if GetTotalAccumulatedMetaPoints() < 10 then
			AddResource( "MetaPoints", 10 - GetTotalAccumulatedMetaPoints(), "FirstRunFreePoints" )
		end

		thread( MarkObjectiveComplete, "MetaPrompt")
		UseableOff({ Id = triggerArgs.triggeredById })
		OpenMetaUpgradeMenuPrePresentation( triggerArgs.triggeredById )
		OpenMetaUpgradeMenu()
		OpenMetaUpgradeMenuPostPresentation( triggerArgs.triggeredById )
		UseableOn({ Id = triggerArgs.triggeredById })
	end
}

function UseMetaUpgradeObject( usee, args )
	UseableOff({ Id = usee.ObjectId })
	OpenMetaUpgradeMenuPrePresentation( usee.ObjectId )
	OpenMetaUpgradeMenu( args )
	OpenMetaUpgradeMenuPostPresentation( usee.ObjectId )
	UseableOn({ Id = usee.ObjectId })
end

function UseShrineObject( usee, args )
	UseableOff({ Id = usee.ObjectId })
	OpenMetaUpgradeMenuPrePresentation( usee.ObjectId, "/SFX/Menu Sounds/HadesMainMenuWhoosh" )
	OpenShrineUpgradeMenu( args )
	OpenMetaUpgradeMenuPostPresentation( usee.ObjectId )
	UseableOn({ Id = usee.ObjectId })
end

function OpenMetaUpgradeMenu( args )

	ResetKeywords()

	ScreenAnchors.LevelUpScreen = { Components = {} }
	local screen = ScreenAnchors.LevelUpScreen
	OverwriteTableKeys( screen, args )
	local components = screen.Components
	screen.Name = "MetaUpgrade"
	screen.ResourceName = "MetaPoints"
	screen.InvestedColor = Color.UpgradeGreen
	screen.CloseAnimation = "LevelUpMirrorOut"
	screen.RefundPresentationName = "MetaPointRefundPresentation"
	screen.SpendPresentationName = "MetaPointSpendPresentation"
	screen.UnlockVoiceLines = HeroVoiceLines.MetaUpgradeUnlockedVoiceLines
	screen.CannotAffordVoiceLines = HeroVoiceLines.NotEnoughDarknessVoiceLines
	screen.TooltipOffsetX = LevelUpUI.RightArrowOffsetX
	screen.BackingOffsetX = 0
	screen.BackingTooltipOffsetX = 0
	screen.BackingTooltipOffsetY = 1
	screen.StatChangeX = -10
	screen.UpgradeCostX = 225
	screen.UpgradeCostJustification = "Left"
	screen.HighlightX = -196 + 34
	screen.IconX = 663
	screen.SwapButtonX = -310

	local lang = GetLanguage({})
	if lang == "ja" then
		screen.StatChangeX = screen.StatChangeX - 45
	end
	OnScreenOpened({ Flag = screen.Name, PersistCombatUI = true })
	FreezePlayerUnit()
	EnableShopGamepadCursor()
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = true })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16 })
	SetConfigOption({ Name = "FreeFormSelectSuccessDistanceStep", Value = 8 })
	SetConfigOption({ Name = "FreeFormSelecSearchFromId", Value = 0 })
	SetConfigOption({ Name = "FreeFormSelectRepeatDelay", Value = 0.6 })
	SetConfigOption({ Name = "FreeFormSelectRepeatInterval", Value = 0.1 })

	-- backward compatability
	if GameState.Flags.SubtractionEnabled and not GameState.Flags.SwapMetaupgradesEnabled then
		GameState.Flags.SwapMetaupgradesEnabled = true
	end

	screen.SubjectName = "MetaUpgrades"
	components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })
	components.ShopBackgroundSplatter = CreateScreenComponent({ Name = "LevelUpBackground", Group = "Combat_Menu" })
	components.ShopBackground = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })

	SetAnimation({ DestinationId = components.ShopBackground.Id, Name = "LevelUpMirrorIn" })

	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 4 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.090, 0.055, 0.157, 0.8} })

	PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuOpen" })

	thread( PlayVoiceLines, GlobalVoiceLines.OpenedMetaUpgradeMenuVoiceLines, true )

	-- wait for mirror animation before creating level up screen components
	wait(0.5)

	components.orbLeft = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu", X = 464, Y = 415 })
	components.orbRight = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu", X = 1446, Y = 415 })
	components.orbTopLeft = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu", X = 814, Y = 50 })
	components.orbTopRight = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu", X = 1096, Y = 50 })

	SetAnimation({ DestinationId = components.orbLeft.Id, Name = "LevelUpMirrorOrbShine"})
	SetAnimation({ DestinationId = components.orbRight.Id, Name = "LevelUpMirrorOrbShineFlipped"})
	SetAnimation({ DestinationId = components.orbTopLeft.Id, Name = "LevelUpMirrorOrbTopShine"})
	SetAnimation({ DestinationId = components.orbTopRight.Id, Name = "LevelUpMirrorOrbTopShineFlipped"})

	-- global for conditional VO on menu close
	screen.PointsAddedThisTime = 0

	-- Title
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "MetaUpgradeMenu", FontSize = 34, OffsetX = 0, OffsetY = -355, Color = Color.White, Font = "SpectralSCLight", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 1}, Justification = "Center" })
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "MetaUpgradeMenu_Flavor", FontSize = 15, OffsetX = 0, OffsetY = -315, Width = 840, Color = Color.SubTitle, Font = "CrimsonTextItalic", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 1}, Justification = "Center" })

	-- Subtitle / Headers

	local numCapUpgrades = GetNumMetaUpgrades("MetaPointCapShrineUpgrade")
	if numCapUpgrades > 0 then
		local metaPointCap = MetaUpgradeData.MetaPointCapShrineUpgrade.BaseValue + (numCapUpgrades * MetaUpgradeData.MetaPointCapShrineUpgrade.ChangeValue)
		local metaPointsSpent = GetTotalSpentMetaPoints()
		components.SubtitleCap = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu" })
		screen.SubtitleCapText = "MetaUpgradeMenu_Subtitle_Cap"
		CreateTextBox({ Id = components.SubtitleCap.Id, Text = screen.SubtitleCapText, FontSize = 26, OffsetX = -320, OffsetY = -225, Width = 840, Color = Color.Orange, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {68,68,68,255}, ShadowOffset={0, 2}, Justification = "Left", TextSymbolScale = 1.2, LuaKey = "TempTextData", LuaValue = { Spent = metaPointsSpent, Cap = metaPointCap }})
	end

	if not screen.ReadOnly then

		components.SubTitle = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu" })
		Attach({ Id = components.SubTitle, DestinationId = components.ShopBackground.Id })
		screen.SubtitleText = "MetaUpgradeMenu_Subtitle"
		CreateTextBox({ Id = components.SubTitle.Id, Text = screen.SubtitleText, FontSize = 26, OffsetX = 290, OffsetY = -225, Width = 840, Color = Color.MetaUpgradePointsDisplay, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {68,68,68,255}, ShadowOffset={0, 2}, Justification = "Right", TextSymbolScale = 0.8, LuaKey = "TempTextData", LuaValue = { CurrentAmount = GameState.Resources.MetaPoints }})

		local hasLockedUpgrades = false
		for k, upgradeName in pairs( GameState.MetaUpgradesSelected ) do
			if not GameState.MetaUpgradesUnlocked[upgradeName] then
				hasLockedUpgrades = true
				break
			end
		end

		if hasLockedUpgrades then
			components.SubTitleKeys = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu" })
			Attach({ Id = components.SubTitleKeys, DestinationId = components.ShopBackground.Id })

			local keyAmount = GameState.Resources.LockKeys or 0
			local superKeyAmount = GameState.Resources.SuperLockKeys or 0
			CreateTextBox({ Id = components.SubTitleKeys.Id, Text = "MetaUpgradeMenu_Subtitle_Key", FontSize = 26, OffsetX = 205, OffsetY = -225, Width = 840, Color = Color.White, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {68,68,68,255}, ShadowOffset={0, 2}, Justification = "Right", TextSymbolScale = 0.8, LuaKey = "TempTextData", LuaValue = { CurrentKeys = keyAmount, CurrentSuperKeys = superKeyAmount }})
		end
	end
	-- RefundButton
	if GameState.Flags.SwapMetaupgradesEnabled then
		local refundCost = 1
		local yOffset = 385
		if GameState.MetaUpgradeStagesUnlocked < 4 then
			yOffset = yOffset + 35
		end

		components.RefundButton = CreateScreenComponent({ Name = "ButtonRefund", Scale = 1.0, Group = "Combat_Menu_Overlay" })
		Attach({ Id = components.RefundButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = 220, OffsetY = yOffset })
		local color = Color.White
		if not HasResource("LockKeys", 1) then
			color = Color.CostUnaffordable
		end
		CreateTextBox({ Id = components.RefundButton.Id, Text = "MetaUpgrade_Locked_Keys", Font = "AlegreyaSansSCBold", Color = color, FontSize = 22, OffsetX = 30, OffsetY = 0, LuaKey = "TempTextData", LuaValue = { Amount = refundCost }})
		components.RefundButton.OnPressedFunctionName = "RefundMetaUpgradeInvestment"
		components.RefundButton.Cost = refundCost
		SetInteractProperty({ DestinationId = components.RefundButton.Id, Property = "TooltipOffsetX", Value = LevelUpUI.TooltipOffset - LevelUpUI.RightArrowOffsetX + 40 })
		CreateTextBox({ Id = components.RefundButton.Id, Text = "MetaUpgradeRefundHint",
			FontSize = 1,
			OffsetX = 0, OffsetY = 0,
			Font = "AlegreyaSansSCExtraBold",
			Justification = "LEFT",
			Color = Color.Transparent
		})
	end

	-- Close button

	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Scale = 0.7, Group = "Combat_Menu" })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = -6, OffsetY = 456 })
	components.CloseButton.OnPressedFunctionName = "CloseMetaUpgradeScreen"
	components.CloseButton.ControlHotkey = "Cancel"

	components.LevelUpStatHighlight = CreateScreenComponent({ Name = "LevelUpStatHighlight", Group = "Combat_Menu" })
	SetAlpha({ Id = components.LevelUpStatHighlight.Id, Fraction = 0.0 })
	ScreenAnchors.LevelUpStatHighlightId = components.LevelUpStatHighlight.Id

	local itemLocationX = ScreenCenterX - 40
	local itemLocationY = 400
	local firstUseable = false
	for k, upgradeName in ipairs( GameState.MetaUpgradesSelected ) do
		if k > GetNumLockedMetaUpgrades() then
			break
		end

		local upgradeData = MetaUpgradeData[upgradeName]
		local itemBackingKey = "Backing"..k
		components[itemBackingKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX, Y = itemLocationY, Group = "Combat_Menu" })

		local graphicKey = "Graphic"..k
		components[graphicKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX, Y = itemLocationY, Scale = 0.7, Group = "Combat_Menu" })
		Attach({ Id = components[graphicKey].Id, DestinationId = components[itemBackingKey].Id, OffsetX = -265 - 30, OffsetY = -30 })

		local strikeThroughCount = GetNulledMetaUpgradeCount()
		if not GameState.MetaUpgradesUnlocked[upgradeName] or ( k > TableLength(MetaUpgradeOrder) - strikeThroughCount) and not screen.ReadOnly then
			CreateMetaUpgradeEntry( { Screen = screen, Components = components, Data = upgradeData, Index = k, OffsetY = itemLocationY, Locked = true } )

			local strikethroughKey = "Strikethrough"..k
			components[strikethroughKey] = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
			Attach({ Id = components["Strikethrough"..k].Id, DestinationId = components[itemBackingKey].Id, OffsetX = -160, OffsetY = -30 })
			SetAnimation({ DestinationId = components["Strikethrough"..k].Id, Name = "LevelUpMirrorStrikethrough" })

			local lockIconKey = "LockIcon"..k
			components[lockIconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = itemLocationY, Group = "Combat_Menu" })
			Attach({ Id = components[lockIconKey].Id, DestinationId = components[itemBackingKey].Id, OffsetX = 345, OffsetY = -35 })
			SetAnimation({ Name = "LockedIcon", DestinationId = components[lockIconKey].Id, Scale = 1.0 })
		else
			CreateMetaUpgradeEntry( { Screen = screen, Components = components, Data = upgradeData, Index = k, OffsetY = itemLocationY, Swap = GameState.Flags.SwapMetaupgradesEnabled } )

			if not firstUseable and not screen.ReadOnly then
				TeleportCursor({ OffsetX = itemLocationX + LevelUpUI.RightArrowOffsetX, OffsetY = itemLocationY + LevelUpUI.RightArrowOffsetY })
				if not GetConfigOptionValue({ Name = "UseMouse" }) then
					RunInteractMethod({ Id = components["RightArrowButton"..k].Id, Method = "HighlightOn" })
				end
				firstUseable = true
			end
		end
		itemLocationY = itemLocationY + LevelUpUI.MetaUpgradeSpacer
	end

	local firstSlot = false
	for k = GameState.MetaUpgradeStagesUnlocked, TableLength(MetaUpgradeLockOrder.LockedSetCosts) - 1 do
		if not firstSlot then
			firstSlot = true
			local panelOffsetY = 400 + LevelUpUI.MetaUpgradeSpacer * MetaUpgradeLockOrder.BaseUnlocked + k * LevelUpUI.MetaUpgradeSpacer * 2
			components["LockBacking"..k] = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = panelOffsetY, Group = "Combat_Menu" })
			-- SetAnimation({ DestinationId = components["LockBacking"..k].Id, Name = "LevelUpMirrorCoverPanel" })
			local lockCost = MetaUpgradeLockOrder.LockedSetCosts[ k + 1 ]
			components.UnlockNextPanelButton = CreateScreenComponent({ Name = "ButtonMetaUpgradeUnlockPanel", Scale = 0.5, Group = "Combat_Menu" })
			Attach({ Id = components.UnlockNextPanelButton.Id, DestinationId = components["LockBacking"..k].Id, OffsetX = 0, OffsetY = 0 })
			components.UnlockNextPanelButton.OnPressedFunctionName = "UnlockNextMetaUpgradePanel"
			components.UnlockNextPanelButton.Cost = lockCost
			components.UnlockNextPanelButton.BackingId = components["LockBacking"..k].Id
			components.UnlockNextPanelButton.OffsetY = panelOffsetY

			local color = Color.White
			if not HasResource("LockKeys", lockCost) then
				color = Color.CostUnaffordable
			end
			CreateTextBox({ Id = components.UnlockNextPanelButton.Id, Text = "MetaUpgrade_Locked_Keys", Font = "AlegreyaSansSCBold", FontSize = 26, Color = color, OffsetX = 0, OffsetY = 0, LuaKey = "TempTextData", LuaValue = { Amount = lockCost }})

			SetInteractProperty({ DestinationId = components.UnlockNextPanelButton.Id, Property = "TooltipOffsetX", Value = 350 })
			CreateTextBox({ Id = components.UnlockNextPanelButton.Id, Text = "MetaUpgradeUnlockHint",
				FontSize = 1,
				OffsetX = 0, OffsetY = 0,
				Font = "AlegreyaSansSCExtraBold",
				Justification = "LEFT",
				Color = Color.Transparent,

				LuaKey = "TempTextData",
				LuaValue =
				{
					Amount = lockCost
				}
			})
		else
			local panelOffsetY = 400 + LevelUpUI.MetaUpgradeSpacer * MetaUpgradeLockOrder.BaseUnlocked + k * LevelUpUI.MetaUpgradeSpacer * 2
			components["LockBacking"..k] = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = panelOffsetY, Group = "Combat_Menu" })
			SetAnimation({ DestinationId = components["LockBacking"..k].Id, Name = "LevelUpMirrorCoverPanel" })
		end
	end

	UpdateButtonStates( screen )
	if GameState.Flags.SwapMetaupgradesEnabled and not GameState.Flags.SwapMetaupgradesEnabledPresentation then
		GameState.Flags.SwapMetaupgradesEnabledPresentation = true
		UnlockMetaupgradeSwapPresentation( components )
	end

	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )

end

function HandleWASDInput( screen )

	while screen.KeepOpen do
		local notifyName = "WASDInput"
		NotifyOnControlPressed({ Names = { "Up", "Down", "Left", "Right" }, Notify = notifyName })
		waitUntil( notifyName )
		if screen.KeepOpen then
			SetConfigOption({ Name = "UseMouse", Value = false })
			if screen.OnWASDInputFunctionName ~= nil then
				local wasdInputFunction = _G[screen.OnWASDInputFunctionName]
				if wasdInputFunction ~= nil then
					wasdInputFunction( screen )
				end
			end
		end
		wait( 0.01, RoomThreadName )
	end
end

function OpenShrineUpgradeMenu( args )
	args = args or {}
	GameState.Flags.ShrineUnlocked = true

	ScreenAnchors.ShrineScreen = { Components = {} }
	local screen = ScreenAnchors.ShrineScreen
	local components = screen.Components
	OverwriteTableKeys( screen, args )
	screen.Name = "ShrineUpgrade"
	screen.ResourceName = "ShrinePoints"
	screen.MaxShrinePoints = GetMaximumPossibleShrinePoints()
	screen.CloseAnimation = "ShrineOut"
	screen.SubtitleText = "ShrineMenu_Subtitle_CurrentMetaPoints"
	screen.InvestedColor = Color.MetaUpgradePointsInvalidPulseColor
	screen.UnlockVoiceLines = HeroVoiceLines.ShrineUpgradeUnlockedVoiceLines
	screen.FreeSpend = true
	screen.RefundPresentationName = "ShrinePointRefundPresentation"
	screen.SpendPresentationName = "ShrinePointSpendPresentation"
	screen.StatChangeX = 360 - 68
	screen.UpgradeCostX = 550 - 68
	screen.UpgradeCostJustification = "Left"
	screen.HighlightX = -196 + 80 - 68
	screen.TooltipOffsetX = 350
	screen.BackingOffsetX = -25 - 68

	local lang = GetLanguage({})
	if lang == "ja" then
		screen.StatChangeX = screen.StatChangeX - 45
	end

	screen.BackingTooltipOffsetX = 35 - 68
	screen.BackingTooltipOffsetY = 1

	screen.RightArrowOffsetX = LevelUpUI.RightArrowOffsetX + 10
	screen.LeftArrowOffsetX = LevelUpUI.LeftArrowOffsetX + 23
	screen.RightArrowOverride = "LevelUpArrowRight"
	screen.IconX = 970 - 68

	local firstView = not GameState.ScreensViewed[screen.Name]

	OnScreenOpened({ Flag = screen.Name, PersistCombatUI = false })
	FreezePlayerUnit()

	EnableShopGamepadCursor()
	HideCombatUI()
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = true })
	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16 })
	SetConfigOption({ Name = "FreeFormSelectSuccessDistanceStep", Value = 8 })
	SetConfigOption({ Name = "FreeFormSelecSearchFromId", Value = 0 })
	SetConfigOption({ Name = "FreeFormSelectRepeatDelay", Value = 0.6 })
	SetConfigOption({ Name = "FreeFormSelectRepeatInterval", Value = 0.1 })

	screen.SubjectName = "ShrineUpgrades"
	components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })
	components.ShopBackgroundSplatter = CreateScreenComponent({ Name = "LevelUpBackground", Group = "Combat_Menu" })
	components.ShopBackground = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })

	local thermometerCenter = 550
	components.ThermometerForeground = CreateScreenComponent({ Name = "ShrineMeterBarFill", Group = "Combat_Menu", X = thermometerCenter, Y = ScreenCenterY - 90 })
	SetScale({ Id = components.ThermometerForeground.Id, Fraction = 0.88 })
	local fraction = 1
	if GetShrinePointLimit() > 0 then
		fraction = GetTotalSpentShrinePoints() / GetShrinePointLimit()
	end
	SetAnimationFrameTarget({ Name = "ShrineMeterBarFill", Fraction = fraction, DestinationId = components.ThermometerForeground.Id, Instant = true })
	components.ThermometerEffects = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_Additive" })
	SetScale({ Id = components.ThermometerEffects.Id, Fraction = 0.88 })
	Attach({ Id = components.ThermometerEffects.Id, DestinationId = components.ThermometerForeground.Id })

	SetAnimation({ DestinationId = components.ShopBackground.Id, Name = "ShrineIn" })
	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 4 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.090, 0.055, 0.157, 0.8} })

	PlaySound({ Name = "/SFX/Menu Sounds/PactMenuOpenSFX" })

	thread( PlayVoiceLines, HeroVoiceLines.OpenedShrineVoiceLines, true )

	-- for conditional VO on menu close
	screen.PointsAddedThisTime = 0

	local yStart = -475
	-- Title
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "ShrineMenu", FontSize = 38, OffsetX = 0, OffsetY = yStart, Color = {1.000, 0.776, 0.000, 1.0}, Font = "SpectralSCExtraLight", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 1}, Justification = "Center" })
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "ShrineMenu_Flavor", FontSize = 15, OffsetX = 0, OffsetY = yStart + 45, Width = 840, Color = {1.000, 0.443, 0.110, 1.0}, Font = "CrimsonTextItalic", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 1}, Justification = "Center" })

	CreateTextBox({ Id = components.ShopBackground.Id, Text = "ShrineMenu_SubHead", FontSize = 24, OffsetX = -620, OffsetY = yStart + 130, Width = 1080, Color = Color.White, Font = "AlegreyaSansSCExtraBold", ShadowBlur = 0, ShadowColor = {0,0,0,255}, ShadowOffset={0, 1}, Justification = "Left", VerticalJustification = "CENTER", TextSymbolScale = 1.0 })

	if not screen.ReadOnly then
		CreateTextBox({ Id = components.ShopBackground.Id, Text = "ShrineMenu_Hint", FontSize = 18, OffsetX = -475, OffsetY = yStart + 825, Width = 540, Color = {255, 255, 255, 240}, Font = "AlegreyaSansRegular", ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 1}, ShadowAlpha=0.5, Justification = "Center", LineSpacingBottom = 10, Scale = 0 })
	end

	local weaponName = GetEquippedWeapon()
	components.WeaponTitle = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu" })
	Attach({ Id = components.WeaponTitle, DestinationId = components.ShopBackground.Id })

	components.WeaponImage = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu_TraitTray", X = 250, Y = 470 })
	SetAnimation({ DestinationId = components.WeaponImage.Id, Name = GetWeaponAspectImage( weaponName ) })

	SetThingProperty({ Property = "Ambient", Value = 0.0, DestinationId = components.WeaponImage.Id })

	local text = "RequiredShrineThreshold"
	local weaponName = GetEquippedWeapon()
	local currentShrineThreshold = GetCurrentRunClearedShrinePointThreshold( weaponName )
	if not IsShrinePointLevelFullyCleared( GetEquippedWeapon(), 0 ) and GetLastClearedShrinePointThreshold( weaponName ) <= 0 and not GameState.Flags.HardMode then
		text = "RequiredShrineThreshold_Zero"
	elseif currentShrineThreshold > GetMaximumAllocatableShrinePoints() then
		currentShrineThreshold = GetMaximumAllocatableShrinePoints()
		text = "RequiredShrineThreshold_AtSoftLimit"
		if not IsShrinePointLevelFullyCleared( GetEquippedWeapon(), 0 ) and not GameState.Flags.HardMode then
			text = "RequiredShrineThreshold_AtSoftLimit_ZeroLimitUncleared"
		end
	end

	CreateTextBox({ Id = components.WeaponTitle.Id, Text = text, FontSize = 20, OffsetX = -600, OffsetY = yStart + 235, Width = 540, Color = Color.White, Font = "AlegreyaSansSCRegular", ShadowBlur = 0, ShadowColor = {0,0,0,255}, ShadowOffset={0, 1}, Justification = "Left", VerticalJustification = "CENTER", LineSpacingBottom = 10, TextSymbolScale = 1.0, LuaKey = "TempTextData", LuaKey = "TempTextData", LuaValue = { Limit = GetShrinePointLimit(), WeaponName = weaponName },
		LangRuScaleModifier = 0.9,
		LangPlScaleModifier = 0.9,
		LangItScaleModifier = 0.9,
		LangKoScaleModifier = 0.9,
		LangCnScaleModifier = 0.9
	})
		-- Alert text
	components.LocationAlerts = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu" })
	Attach({ Id = components.LocationAlerts, DestinationId = components.ShopBackground.Id })

	components.LocationAlertHeader = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu" })
	Attach({ Id = components.LocationAlertHeader, DestinationId = components.ShopBackground.Id })

	components.ThresholdText = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX - 210, Y = ScreenCenterY - 15, Group = "Combat_Menu" })
	Attach({ Id = components.ThresholdText, DestinationId = components.ShopBackground.Id })
	CreateTextBox({ Id = components.ThresholdText.Id, Text = "Blank", FontSize = 18, Width = 600, Color = Color.White, Font = "AlegreyaSansRegular", ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 1}, Justification = "Center", VerticalJustification = "CENTER", TextSymbolScale = 1.0, LineSpacingBottom = 8, OffsetX = -155, OffsetY = -26,
		LangRuScaleModifier = 0.7,
		LangPlScaleModifier = 0.8,
		LangKoScaleModifier = 0.7,
	})


	-- location rewards

	local locationY = yStart + 678
	local locationMarkY = locationY - 35

	local locationXSpacer = 124
	local locationX = -548
	local iconOffsetX = -18
	local iconOffsetY = -22
	local checkMarkOffsetX = 18
	local checkMarkOffsetY = 16

	local rewardShrineAmount = GetTotalSpentShrinePoints()
	if rewardShrineAmount > GetCurrentRunClearedShrinePointThreshold( weaponName ) then
		rewardShrineAmount = GetCurrentRunClearedShrinePointThreshold( weaponName )
	end

	CreateTextBox({ Id = components.LocationAlertHeader.Id, Text = "ShrineRewardBiomeProgress", FontSize = 22, OffsetX = -580, OffsetY = locationY - 160, Width = 580, Color = Color.White, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {0,0,0,255}, ShadowOffset={0, 1}, Justification = "Left", VerticalJustification = "Top", TextSymbolScale = 0.75, LuaKey = "TempTextData", LineSpacingBottom = 12, LuaValue = { ShrinePointThreshold = rewardShrineAmount, WeaponName = WeaponData[GetEquippedWeapon()].ShortName },
		LangRuScaleModifier = 0.75,
		LangPlScaleModifier = 0.75,
		LangKoScaleModifier = 0.85,
	})

	screen.ClearIndicatorIds = {}

	if HasSeenRoom( "RoomOpening" ) then
		CreateTextBox({ Id = components.LocationAlerts.Id, Text = "Location_Tartarus", FontSize = 14, OffsetX = locationX, OffsetY = locationY, Width = 200, Color = Color.White, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 1}, Justification = "Center", VerticalJustification = "Top", TextSymbolScale = 1.0, LuaKey = "TempTextData", LuaValue = { TartarusCleared = tartarusText, AsphodelCleared = asphodelText, ElysiumCleared = elysiumText, StyxCleared = styxText } })
	end
	components.TartarusClearIndicator = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
	Attach({ Id = components.TartarusClearIndicator.Id, DestinationId = components.LocationAlerts.Id, OffsetX = locationX + checkMarkOffsetX, OffsetY = locationMarkY + checkMarkOffsetY})
	components.TartarusClearRewardIndicator = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
	SetScale({ Id = components.TartarusClearRewardIndicator.Id, Fraction = 0.8})
	Attach({ Id = components.TartarusClearRewardIndicator.Id, DestinationId = components.TartarusClearIndicator.Id, OffsetX = iconOffsetX, OffsetY = iconOffsetY })
	table.insert( screen.ClearIndicatorIds, components.TartarusClearIndicator.Id )
	table.insert( screen.ClearIndicatorIds, components.TartarusClearRewardIndicator.Id )
	locationX = locationX + locationXSpacer

	if HasSeenRoom( "B_Intro" ) then
		CreateTextBox({ Id = components.LocationAlerts.Id, Text = "Location_Asphodel", FontSize = 14, OffsetX = locationX, OffsetY = locationY, Width = 200, Color = Color.White, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 1}, Justification = "Center", VerticalJustification = "Top", TextSymbolScale = 1.0, LuaKey = "TempTextData", LuaValue = { TartarusCleared = tartarusText, AsphodelCleared = asphodelText, ElysiumCleared = elysiumText, StyxCleared = styxText } })
	end
	components.AsphodelClearIndicator = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
	Attach({ Id = components.AsphodelClearIndicator.Id, DestinationId = components.LocationAlerts.Id, OffsetX = locationX + checkMarkOffsetX, OffsetY = locationMarkY + checkMarkOffsetY})
	components.AsphodelClearRewardIndicator = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
	SetScale({ Id = components.AsphodelClearRewardIndicator.Id, Fraction = 0.8})
	Attach({ Id = components.AsphodelClearRewardIndicator.Id, DestinationId = components.AsphodelClearIndicator.Id, OffsetX = iconOffsetX, OffsetY = iconOffsetY })
	table.insert( screen.ClearIndicatorIds, components.AsphodelClearIndicator.Id )
	table.insert( screen.ClearIndicatorIds, components.AsphodelClearRewardIndicator.Id )
	locationX = locationX + locationXSpacer

	if HasSeenRoom( "C_Intro" ) then
		CreateTextBox({ Id = components.LocationAlerts.Id, Text = "Location_Elysium", FontSize = 14, OffsetX = locationX,	OffsetY = locationY, Width = 200, Color = Color.White, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 1}, Justification = "Center", VerticalJustification = "Top", TextSymbolScale = 1.0, LuaKey = "TempTextData", LuaValue = { TartarusCleared = tartarusText, AsphodelCleared = asphodelText, ElysiumCleared = elysiumText, StyxCleared = styxText } })
	end
	components.ElysiumClearIndicator = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
	Attach({ Id = components.ElysiumClearIndicator.Id, DestinationId = components.LocationAlerts.Id, OffsetX = locationX + checkMarkOffsetX, OffsetY = locationMarkY + checkMarkOffsetY})
	components.ElysiumClearRewardIndicator = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
	SetScale({ Id = components.ElysiumClearRewardIndicator.Id, Fraction = 0.8})
	Attach({ Id = components.ElysiumClearRewardIndicator.Id, DestinationId = components.ElysiumClearIndicator.Id, OffsetX = iconOffsetX, OffsetY = iconOffsetY })
	table.insert( screen.ClearIndicatorIds, components.ElysiumClearIndicator.Id )
	table.insert( screen.ClearIndicatorIds, components.ElysiumClearRewardIndicator.Id )
	locationX = locationX + locationXSpacer

	if HasSeenRoom( "D_Intro" ) then
		CreateTextBox({ Id = components.LocationAlerts.Id, Text = "Location_Styx_Short", FontSize = 14, OffsetX = locationX, OffsetY = locationY, Width = 150, Color = Color.White, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 1}, Justification = "Center", VerticalJustification = "Top", TextSymbolScale = 1.0, LuaKey = "TempTextData", LuaValue = { TartarusCleared = tartarusText, AsphodelCleared = asphodelText, ElysiumCleared = elysiumText, StyxCleared = styxText } })
	end
	components.StyxClearIndicator = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
	Attach({ Id = components.StyxClearIndicator.Id, DestinationId = components.LocationAlerts.Id, OffsetX = locationX + checkMarkOffsetX, OffsetY = locationMarkY + checkMarkOffsetY})
	components.StyxClearRewardIndicator = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu" })
	SetScale({ Id = components.StyxClearRewardIndicator.Id, Fraction = 0.8})
	Attach({ Id = components.StyxClearRewardIndicator.Id, DestinationId = components.StyxClearIndicator.Id, OffsetX = iconOffsetX, OffsetY = iconOffsetY })
	table.insert( screen.ClearIndicatorIds, components.StyxClearIndicator.Id )
	table.insert( screen.ClearIndicatorIds, components.StyxClearRewardIndicator.Id )
	-- Subtitle

	if not screen.ReadOnly then
		local pointsSpent = GetTotalSpentShrinePoints()
		local bonus = (pointsSpent * CurrentRun.Hero.ShrinePointMetaPointBonusMultiplier) * 100
		components.SubtitleMetaPointBonus = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu" })
		screen.SubtitleMetaPointBonusText = "ShrineMenu_Subtitle_MetaPointBonus"
		CreateTextBox({ Id = components.SubtitleMetaPointBonus.Id, Text = screen.SubtitleMetaPointBonusText, FontSize = 24, OffsetX = -232, OffsetY = yStart + 195, Width = 840, Color = Color.White, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {0,0,0,255}, ShadowOffset={0, 1}, Justification = "Right", TextSymbolScale = 1.0, LuaKey = "TempTextData", LuaValue = { Current = pointsSpent, Limit = GetShrinePointLimit()} })

		components.SubTitle = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu" })

		components.SpentShrinePoints = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu" })
		CreateTextBox({ Id = components.SpentShrinePoints.Id, Text = screen.SubtitleText, FontSize = 26, OffsetX = -165, OffsetY = yStart + 385, Width = 840, Color = Color.White, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {0,0,0,255}, ShadowOffset={0, 1}, Justification = "Center", TextSymbolScale = 1.0, LuaKey = "TempTextData", LuaValue = { CurrentAmount = pointsSpent, Limit = GetShrinePointLimit()},
			LangRuScaleModifier = 0.65,
			LangPlScaleModifier = 0.65
		})

		if GameState.Flags.HardMode and GameState.SpentShrinePointsCache < currentShrineThreshold then
			local shrinePointThreshold = GetCurrentRunClearedShrinePointThreshold( weaponName )
			local shrinePointsSpent = GameState.SpentShrinePointsCache or 5
			if shrinePointsSpent < shrinePointThreshold then
				thread( HardModeShrinePointThresholdIncreasedPresentation, screen )
			end
		end
	end

	if not screen.ReadOnly then
		local hasLockedUpgrades = false
		for k, upgradeName in pairs( ShrineUpgradeOrder ) do
			if not GameState.MetaUpgradesUnlocked[upgradeName] then
				hasLockedUpgrades = true
				break
			end
		end

		if hasLockedUpgrades then
			components.SubTitleKeys = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY, Group = "Combat_Menu" })
			Attach({ Id = components.SubTitleKeys, DestinationId = components.ShopBackground.Id })

			local keyAmount = GameState.Resources.LockKeys or 0
			local superKeyAmount = GameState.Resources.SuperLockKeys or 0
			CreateTextBox({ Id = components.SubTitleKeys.Id, Text = "MetaUpgradeMenu_Subtitle_Key", FontSize = 26, OffsetX = 205, OffsetY = -225, Width = 840, Color = Color.White, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {68,68,68,255}, ShadowOffset={0, 1}, Justification = "Right", TextSymbolScale = 0.8, LuaKey = "TempTextData", LuaValue = { CurrentKeys = keyAmount, CurrentSuperKeys = superKeyAmount }})
		end
	end

	-- Info button
	components.InfoButton = CreateScreenComponent({ Name = "ShrineUpgradeMenuInfo", Scale = 1.0, Group = "Combat_Menu" })
	Attach({ Id = components.InfoButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = -300, OffsetY = 456 })
	components.InfoButton.OnPressedFunctionName = "ShowShrineInfo"
	-- CreateTextBox({ Id = components.InfoButton.Id, Text = "ShrineMenu_Info", FontSize = 18, Color = Color.White, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {68,68,68,255}, ShadowOffset={0, 1}, Justification = "Center", TextSymbolScale = 0.8, })
	components.InfoButton.ControlHotkey = "MenuInfo"

	-- Close button
	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Scale = 1, Group = "Combat_Menu" })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = -440, OffsetY = 456 })
	components.CloseButton.OnPressedFunctionName = "CloseShrineUpgradeScreen"
	components.CloseButton.OnPressedGlobalVoiceLines = "SkellyClosedShrineReactionVoiceLines"
	components.CloseButton.ControlHotkey = "Cancel"

	if not args or not args.BlockRunStartButton then
		components.StartButton = CreateScreenComponent({ Name = "ShrineUpgradeMenuConfirm", Scale = 1, Group = "Combat_Menu" })
		Attach({ Id = components.StartButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = 300, OffsetY = 456 })
		components.StartButton.OnPressedFunctionName = "CloseShrineUpgradeScreenAndStartOver"
		CreateTextBox({ Id = components.StartButton.Id, Text = "ShrineMenu_Confirm", FontSize = 26, Color = Color.White, Font = "AlegreyaSansSCBold", ShadowBlur = 0, ShadowColor = {68,68,68,255}, ShadowOffset={0, 1}, Justification = "Center", TextSymbolScale = 0.8, })
		components.StartButton.ControlHotkey = "Confirm"
	end

	components.LevelUpStatHighlight = CreateScreenComponent({ Name = "ShrineStatHighlight", Group = "Combat_Menu" })
	SetAlpha({ Id = components.LevelUpStatHighlight.Id, Fraction = 0.0 })
	ScreenAnchors.LevelUpStatHighlightId = components.LevelUpStatHighlight.Id

	local itemLocationX = ScreenCenterX + 280 - 68
	local itemLocationY = yStart + 765
	local firstUseable = false
	for k, upgradeName in ipairs( ShrineUpgradeOrder ) do
		local upgradeData = MetaUpgradeData[upgradeName]
		local itemBackingKey = "Backing"..k
		components[itemBackingKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX, Y = itemLocationY, Group = "Combat_Menu" })

		local graphicKey = "Graphic"..k
		components[graphicKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX, Y = itemLocationY, Scale = 0.7, Group = "Combat_Menu" })
		Attach({ Id = components[graphicKey].Id, DestinationId = components[itemBackingKey].Id, OffsetX = -265 - 30, OffsetY = -30 })

		if ( upgradeData.GameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, upgradeData.GameStateRequirements ) and not args.IgnoreRequirements ) then
			-- Leave blank
		elseif GetNumMetaUpgrades( upgradeName ) > 0 or not upgradeData.RequiredHeatThreshold or GetHighestRunClearShrinePointThreshold() >= upgradeData.RequiredHeatThreshold or ( upgradeData.RequiredPreUpdateSevenHeatThreshold and GetPreUpdateSevenHighestShrinePointRunClear() > upgradeData.RequiredPreUpdateSevenHeatThreshold ) then
			if not GameState.MetaUpgradesUnlocked[upgradeName] and not screen.ReadOnly then
				CreateTextBox({ Id = components[itemBackingKey].Id, Text = upgradeData.Name,
					FontSize = 21,
					OffsetX = LevelUpUI.TextInfoBaseX, OffsetY = -30,
					Color = Color.ShrineAttributeLocked,
					Font = "AlegreyaSansSCExtraBold",
					ShadowBlur = 0, ShadowColor = {0,0,0,255}, ShadowOffset={0, 2},
					Justification = "Left" })

				local unlockId = "Locked"..k
				local metaUpgradeNextCostKey = "UpgradeCost"..k

				local button = CreateUnlockButton( upgradeData, { Screen = screen, OffsetX = itemLocationX, OffsetY = itemLocationY, Index = k, IsEnabled = HasResource( upgradeData.ResourceName, upgradeData.UnlockCost ), KeyCostKey = metaUpgradeNextCostKey } )
				button.ResourceName = screen.ResourceName

				components[metaUpgradeNextCostKey] = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = itemLocationY, Group = "Combat_Menu" })
				Attach({ Id = components[metaUpgradeNextCostKey].Id, DestinationId = components[unlockId].Id })

				local color = Color.White
				if not HasResource( upgradeData.ResourceName, upgradeData.UnlockCost ) then
					color = Color.MetaUpgradePointsInvalid
				end

				local text = "Blank"
				if ResourceData[ upgradeData.ResourceName ] and ResourceData[ upgradeData.ResourceName ].RequirementText then
					text = ResourceData[ upgradeData.ResourceName ].RequirementText
				end
				CreateTextBox({
					Id = components[metaUpgradeNextCostKey].Id, Text = text,
					LuaKey = "TempTextData", LuaValue = { Amount = tostring(upgradeData.UnlockCost) },
					FontSize = 26,
					OffsetX = 160, OffsetY = 0,
					TextSymbolScale = 0.85,
					Color = color,
					Font = "AlegreyaSansSCRegular",
					ShadowBlur = 0, ShadowColor = {96,96,96,255}, ShadowOffset={0, 1},
					Justification = "Right" })

				local lockIconKey = "LockIcon"..k
				components[lockIconKey] = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = itemLocationY, Group = "Combat_Menu" })
				Attach({ Id = components[lockIconKey].Id, DestinationId = components[unlockId].Id, OffsetX = -530, OffsetY = -2 })
				SetAnimation({ Name = "LockedIcon", DestinationId = components[lockIconKey].Id, Scale = 1.0 })
			else
				CreateMetaUpgradeEntry( { Screen = screen, Components = components, Data = upgradeData, Index = k, OffsetY = itemLocationY } )
			end
		elseif upgradeData.RequiredHeatThreshold and not screen.ReadOnly  then
			CreateTextBox({ Id = components[itemBackingKey].Id, Text = "UnknownShrineUpgrade",
				FontSize = 21,
				OffsetX = LevelUpUI.TextInfoBaseX, OffsetY = -30,
				Color = Color.ShrineAttribute,
				Font = "AlegreyaSansSCExtraBold",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 1},
				Justification = "Left",
				LuaKey = "TempTextData", LuaValue = { Amount = tostring(upgradeData.RequiredHeatThreshold) },
			})
		end
		itemLocationY = itemLocationY + LevelUpUI.MetaUpgradeSpacer
	end

	UpdateButtonStates( screen )

	if firstView then
		ShowShrineInfo( screen )
		TeleportCursor({ OffsetX = 1470, OffsetY = 280, ForceUseCheck = true })
	else
		TeleportCursor({ OffsetX = ScreenCenterX + 300, OffsetY = ScreenCenterY + 456, ForceUseCheck = true })
	end

	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )

end

function CreateMetaUpgradeEntry( args )
	local components = args.Components
	local upgradeData = args.Data
	local upgradeName = upgradeData.Name
	local k = args.Index
	local itemLocationY = args.OffsetY
	upgradeData.NextCost = GetMetaUpgradePurchasePrice( upgradeData )
	upgradeData.NextRefund = GetMetaUpgradeRefundPrice( upgradeData )

	local numUpgrades = GetNumMetaUpgrades( upgradeName )
	local metaUpgradeNumKey = "UpgradeTotal"..k
	components[metaUpgradeNumKey] = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = itemLocationY, Group = "Combat_Menu" })

	if upgradeData.Icon then
		components["Icon"..k] = CreateScreenComponent({ Name = "BlankObstacle", X = args.Screen.IconX, Y = itemLocationY - 33, Group = "Combat_Menu" })
		SetAnimation({ Name = upgradeData.Icon, DestinationId = components["Icon"..k].Id, Scale = 0.23 })
	end

	if not Contains( GameState.LastUnlockedMetaUpgrades, upgradeData.Name ) and not upgradeData.Starting and not args.Screen.ReadOnly then

		local itemBackingKey = "Backing"..k
		CreateTextBox({ Id = components[itemBackingKey].Id, Text = "MetaUpgrade_New",
			FontSize = 21,
			OffsetX = LevelUpUI.TextInfoBaseX - 115, OffsetY = -30,
			Color = Color.White,
			Font = "AlegreyaSansSCExtraBold",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 1},
			Justification = "Left" })
	end

	local metaUpgradeTotalKey = "UpgradeValueTotal"..k
	local totalStatChange = GetTotalStatChange( upgradeData )
	components[metaUpgradeTotalKey] = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = itemLocationY, Group = "Combat_Menu" })

	local text = GetMetaUpgradeShortTotalText( upgradeData )
	local color = Color.White
	if numUpgrades ~= 0 then
		color = args.Screen.InvestedColor
	elseif args.Locked then
		color = Color.MetaUpgradePointsInvalid
	end

	CreateTextBox({
		Id = components[metaUpgradeTotalKey].Id, Text = text,
		LuaKey = "TempTextData", LuaValue = { Amount = totalStatChange },
		TooltipKey = upgradeData.TotalTooltip, TooltipData = {Amount = totalStatChange },
		FontSize = 26,
		OffsetX = args.Screen.StatChangeX, OffsetY = -32,
		Color = color,
		Font = "AlegreyaSansSCBold",
		ShadowBlur = 0, ShadowColor = {96,96,96,255}, ShadowOffset={0, 1},
		LangDeScaleModifier = 0.8,
		LangFrScaleModifier = 0.9,
		LangItScaleModifier = 0.75,
		LangEsScaleModifier = 0.8,
		LangPtBrScaleModifier = 0.7,
		LangRuScaleModifier = 0.68,
		LangPlScaleModifier = 0.7,
		LangCnScaleModifier = 0.9,
		LangKoScaleModifier = 0.825,
		LangJaScaleModifier = 0.825,
		Justification = "Left" })

	local metaUpgradeNextCostKey = "UpgradeCost"..k
	components[metaUpgradeNextCostKey] = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = itemLocationY, Group = "Combat_Menu" })
	if not args.Screen.ReadOnly and not args.Locked then

		CreateTextBox({
			Id = components[metaUpgradeNextCostKey].Id, Text = tostring(upgradeData.NextCost),
			TooltipKey = upgradeData.TotalTooltip, TooltipData = {Amount = totalStatChange },
			FontSize = 26,
			OffsetX = args.Screen.UpgradeCostX, OffsetY = -30,
			Color = Color.DarknessPoint,
			Font = "AlegreyaSansSCMedium",
			ShadowBlur = 0, ShadowColor = {96,96,96,255}, ShadowOffset={0, 1},
			LangCnScaleModifier = 0.85,
			Justification = args.Screen.UpgradeCostJustification })
	end

	local itemBackingKey = "Backing"..k
	local componentColor = Color.ShrineAttribute
	if args.Swap and MetaUpgradeOrder[k] and MetaUpgradeOrder[k][2] == upgradeName then
		componentColor = Color.MirrorBAttribute
	end
	if ( upgradeData.GameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, upgradeData.GameStateRequirements )) then
		componentColor = Color.ShrineAttributeLocked
	elseif args.Locked then
		componentColor = Color.MetaUpgradePointsInvalid
	end
	CreateTextBox({ Id = components[itemBackingKey].Id, Text = upgradeData.Name,
		FontSize = 21,
		OffsetX = LevelUpUI.TextInfoBaseX, OffsetY = -30,
		Color = componentColor,
		Font = "AlegreyaSansSCExtraBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 1},
		LangDeScaleModifier = 0.9,
		LangFrScaleModifier = 0.9,
		LangEsScaleModifier = 0.95,
		LangPtBrScaleModifier = 0.85,
		LangRuScaleModifier = 0.82,
		LangPlScaleModifier = 0.85,
		LangCnScaleModifier = 0.9,
		Justification = "Left" })

	if not args.Screen.ReadOnly then
		if args.Locked then
			local button = CreateArrowButton( k, { Screen = args.Screen, Data = upgradeData, IsIncrease = true, IsEnabled = false, Locked = true })
			CreateTooltipTarget( args.Screen, k, upgradeData, { Locked = true } )
		else
			local button = CreateArrowButton( k, { Screen = args.Screen, Data = upgradeData, IsIncrease = true, IsEnabled = true })
			button.ResourceName = args.Screen.ResourceName
			if args.Screen.ResourceName == "ShrinePoints" then
				local button = CreateArrowButton( k, { Screen = args.Screen, Data = upgradeData, IsIncrease = false, IsEnabled = true })
				button.ResourceName = args.Screen.ResourceName
			end
			if args.Swap then
				components[itemBackingKey.."Swap"] = CreateScreenComponent({ Name = "ExchangeMetaupgrade", Scale = 1.0, Group = "Combat_Menu" })
				Attach({ Id = components[itemBackingKey.."Swap"].Id, DestinationId = components[itemBackingKey].Id, OffsetX = args.Screen.SwapButtonX, OffsetY = -29 })
				components[itemBackingKey.."Swap"].OnPressedFunctionName = "SwapMetaupgrade"
				components[itemBackingKey.."Swap"].OffsetY = itemLocationY
				components[itemBackingKey.."Swap"].Index = k
				components[itemBackingKey.."Swap"].Name = upgradeName

				-- hack: invisible textbox for autotooltips to trigger on the buttons
				local flipSideTooltip = "Blank"
				if MetaUpgradeOrder[k] then
					if MetaUpgradeOrder[k][1] == upgradeName then
						flipSideTooltip = MetaUpgradeOrder[k][2]
					else
						flipSideTooltip = MetaUpgradeOrder[k][1]
					end
				end
				local swapTooltipLuaValue =
				{
					BaseValue = GetMetaUpgradeStatDelta( upgradeData ),
					StartingValue = (upgradeData.BaseValue or 0),
					DisplayValue = (upgradeData.DisplayValue or 0),
					CurrentSide = upgradeName,
					FlipSide = flipSideTooltip,
				}
				SetInteractProperty({ DestinationId = components[itemBackingKey.."Swap"].Id, Property = "TooltipOffsetX", Value = 950 })
				CreateTextBox({ Id = components[itemBackingKey.."Swap"].Id, Text = upgradeName,
					FontSize = 1,
					OffsetX = 0, OffsetY = 0,
					Font = "AlegreyaSansSCExtraBold",
					Justification = "LEFT",
					Color = Color.Transparent,
					LuaKey = "TempTextData",
					LuaValue = swapTooltipLuaValue,
				})
				CreateTextBox({ Id = components[itemBackingKey.."Swap"].Id, Text = "MetaUpgradeSwapHint",
					FontSize = 1,
					OffsetX = 0, OffsetY = 0,
					Font = "AlegreyaSansSCExtraBold",
					Justification = "LEFT",
					Color = Color.Transparent,
					LuaKey = "TempTextData",
					LuaValue = swapTooltipLuaValue,
				})
				local hoverButton = CreateTooltipTarget( args.Screen, k, upgradeData )
				hoverButton.OnPressedFunctionName = "SwapMetaupgrade"
				hoverButton.OffsetY = itemLocationY
				hoverButton.Index = k
				hoverButton.Name = upgradeName
			else
				CreateTooltipTarget( args.Screen, k, upgradeData )
			end
		end
	end
end

function CreateUnlockButton( upgradeData, args )
	local itemBackingKey = "Backing"..args.Index
	local unlockId = "Locked"..args.Index
	local components = args.Screen.Components
	local isEnabled = args.IsEnabled
	local name = "LevelUpArrowRight"

	if not isEnabled then
		name = name.."Disabled"
	end

	if components[unlockId] ~= nil then
		Destroy({ Id = components[unlockId].Id })
	end

	components[unlockId] = CreateScreenComponent({ Name = name, Scale = 1.0, Group = "Combat_Menu" })
	Attach({ Id = components[unlockId].Id, DestinationId = components[itemBackingKey].Id, OffsetX = LevelUpUI.RightArrowOffsetX, OffsetY = -30 })
	components[unlockId].OnPressedFunctionName = "AttemptUnlock"
	components[unlockId].Data = upgradeData
	components[unlockId].ParentIndex = args.Index
	components[unlockId].OffsetY = args.OffsetY
	components[unlockId].OffsetX = args.OffsetX
	components[unlockId].HandleType = "Unlock"
	components[unlockId].UnlockCost = upgradeData.UnlockCost
	components[unlockId].LastEnabled = args.IsEnabled
	components[unlockId].KeyCostKey = args.KeyCostKey

	-- hack: invisible textbox for autotooltips to trigger on the buttons
	SetInteractProperty({ DestinationId = components[unlockId].Id, Property = "TooltipOffsetX", Value = LevelUpUI.TooltipOffset - LevelUpUI.RightArrowOffsetX})
	CreateTextBox({ Id = components[unlockId].Id, Text = upgradeData.Name,
			FontSize = 36,
			OffsetX = LevelUpUI.TooltipInfoBaseX + LevelUpUI.RightArrowOffsetY, OffsetY = 0,
			Font = "AlegreyaSansSCExtraBold",
			Justification = "LEFT",
			Color = Color.Transparent
		})
	return components[unlockId]
end

function CreateArrowButton( index, args )
	local components = args.Screen.Components
	local upgradeData = args.Data
	local itemBackingKey = "Backing"..index
	local metaUpgradeNumKey = "UpgradeTotal"..index
	local metaUpgradeTotalKey = "UpgradeValueTotal"..index
	local metaUpgradeNextCostKey = "UpgradeCost"..index
	local isIncrease = args.IsIncrease
	local isEnabled = args.IsEnabled

	local name = args.Screen.RightArrowOverride or "LevelUpPlus"
	local offsetX = args.Screen.RightArrowOffsetX or LevelUpUI.RightArrowOffsetX
	local offsetY = LevelUpUI.RightArrowOffsetY
	local key = "RightArrowButton"..index
	local handleType = "Add"
	local tooltipValue = upgradeData.IncreaseTooltip

	if not isIncrease then
		name = "LevelUpArrowLeft"
		offsetX = args.Screen.LeftArrowOffsetX or LevelUpUI.LeftArrowOffsetX
		offsetY = LevelUpUI.LeftArrowOffsetY
		key = "LeftArrowButton"..index
		handleType = "Remove"
		tooltipValue = upgradeData.DecreaseTooltip
	end

	if not isEnabled then
		name = name.."Disabled"
	end

	if components[key] ~= nil then
		Destroy({ Id = components[key].Id })
	end

	components[key] = CreateScreenComponent({ Name = name, Scale = 1.0, Group = "Combat_Menu" })
	Attach({ Id = components[key].Id, DestinationId = components[itemBackingKey].Id, OffsetX = offsetX, OffsetY = offsetY })
	components[key].OnPressedFunctionName = "HandleMetaUpgradeInput"
	components[key].HandleType = handleType
	components[key].TextBoxId = components[metaUpgradeNumKey].Id
	components[key].TotalTextBoxId = components[metaUpgradeTotalKey].Id
	components[key].NextCostId = components[metaUpgradeNextCostKey].Id
	components[key].Data = upgradeData
	components[key].ParentIndex = index
	components[key].LastEnabled = isEnabled
	SetInteractProperty({ DestinationId = components[key].Id, Property = "TooltipId", Value = upgradeData.IncreaseTooltip })
	AttachLua({ Id = components[key].Id, Table = upgradeData })




	-- hack: invisible textbox for autotooltips to trigger on the buttons
	local tooltipX = LevelUpUI.TooltipInfoBaseX
	local tooltipOffsetX = args.Screen.TooltipOffsetX
	local justification = "LEFT"
	if not isIncrease then
		offsetX = offsetX
		tooltipOffsetX = tooltipOffsetX - 34
		tooltipX = tooltipX + 450
		justification = "RIGHT"
	end
	SetInteractProperty({ DestinationId = components[key].Id, Property = "TooltipOffsetX", Value = LevelUpUI.TooltipOffset - tooltipOffsetX })
	SetInteractProperty({ DestinationId = components[key].Id, Property = "TooltipOffsetY", Value = -1 })
	CreateTextBox({ Id = components[key].Id, Text = upgradeData.Name,
			FontSize = 1,
			OffsetX = tooltipX, OffsetY = 0,
			Font = "AlegreyaSansSCExtraBold",
			Justification = justification,
			Color = Color.Transparent,
			LuaKey = "TempTextData",
			LuaValue =
			{
				BaseValue = GetMetaUpgradeStatDelta(upgradeData) ,
				StartingValue = (upgradeData.BaseValue or 0),
				DisplayValue = (upgradeData.DisplayValue or 0)
			}
		})
	if args.Locked then
		CreateTextBox({ Id = components[key].Id, Text = "MetaUpgrade_Sealed",
			FontSize = 1,
			OffsetX = tooltipX, OffsetY = 0,
			Font = "AlegreyaSansSCExtraBold",
			Justification = justification,
			Color = Color.Transparent,
			LuaKey = "TempTextData",
			LuaValue =
			{
				BaseValue = GetMetaUpgradeStatDelta(upgradeData) ,
				StartingValue = (upgradeData.BaseValue or 0),
				DisplayValue = (upgradeData.DisplayValue or 0)
			}
		})
	end


	return components[key]
end

function CreateTooltipTarget( screen, index, upgradeData, args )
	local args = args or {}
	local components = screen.Components

	if components["BackingTooltip"..index] then
		Destroy({ Id = components["BackingTooltip"..index].Id })
	end

	components["BackingTooltip"..index] = CreateScreenComponent({ Name = "MetaUpgradeInvisibleHoverTarget", Scale = 1.0, Group = "Combat_Menu_Backing" })
	Attach({ Id = components["BackingTooltip"..index].Id, DestinationId = components["Backing"..index].Id, OffsetX = -30 + screen.BackingOffsetX, OffsetY = -30 })
	local components = screen.Components

	-- hack: invisible textbox for autotooltips to trigger on the buttons
	local tooltipX = LevelUpUI.TooltipInfoBaseX
	local tooltipOffsetX = screen.TooltipOffsetX - 265

	SetInteractProperty({ DestinationId = components["BackingTooltip"..index].Id, Property = "TooltipOffsetX", Value = LevelUpUI.TooltipOffset - tooltipOffsetX + screen.BackingTooltipOffsetX })
	SetInteractProperty({ DestinationId = components["BackingTooltip"..index].Id, Property = "TooltipOffsetY", Value = screen.BackingTooltipOffsetY })
	CreateTextBox({ Id = components["BackingTooltip"..index].Id, Text = upgradeData.Name,
			FontSize = 1,
			OffsetX = tooltipX, OffsetY = 0,
			Font = "AlegreyaSansSCExtraBold",
			Justification = justification,
			Color = Color.Transparent,
			LuaKey = "TempTextData",
			LuaValue =
			{
				BaseValue = GetMetaUpgradeStatDelta(upgradeData) ,
				StartingValue = (upgradeData.BaseValue or 0),
				DisplayValue = (upgradeData.DisplayValue or 0)
			}
		})
	if args.Locked then
		CreateTextBox({ Id = components["BackingTooltip"..index].Id, Text = "MetaUpgrade_Sealed",
			FontSize = 1,
			OffsetX = tooltipX, OffsetY = 0,
			Font = "AlegreyaSansSCExtraBold",
			Justification = justification,
			Color = Color.Transparent,
			LuaKey = "TempTextData",
			LuaValue =
			{
				BaseValue = GetMetaUpgradeStatDelta(upgradeData) ,
				StartingValue = (upgradeData.BaseValue or 0),
				DisplayValue = (upgradeData.DisplayValue or 0)
			}
		})
	end
	return components["BackingTooltip"..index]
end
function FindMetaUpgradeButton( buttonId )
	local screen = ScreenAnchors.LevelUpScreen or ScreenAnchors.ShrineScreen
	local button = nil
	if not screen then
		return
	end
	for i, component in pairs( screen.Components ) do
		if component.Id == buttonId then
			button = component
		end
	end
	return button
end

function UpdateSubtitle( button )
	local screen = ScreenAnchors.LevelUpScreen or ScreenAnchors.ShrineScreen
	if not screen then
		return
	end

	ModifyTextBox({ Id = screen.Components.SubTitle.Id, Text = screen.SubtitleText, LuaKey = "TempTextData", LuaValue = { CurrentAmount = GameState.Resources[screen.ResourceName] } })

	if screen.Components.SubtitleCap ~= nil then
		local numCapUpgrades = GetNumMetaUpgrades("MetaPointCapShrineUpgrade")
		local metaPointCap = MetaUpgradeData.MetaPointCapShrineUpgrade.BaseValue + (numCapUpgrades * MetaUpgradeData.MetaPointCapShrineUpgrade.ChangeValue)
		local metaPointsSpent = GetTotalSpentMetaPoints()
		ModifyTextBox({ Id = screen.Components.SubtitleCap.Id, Text = screen.SubtitleCapText, LuaKey = "TempTextData", LuaValue = { Spent = metaPointsSpent, Cap = metaPointCap } })
	end

	if screen.Components.SubtitleMetaPointBonus ~= nil then
		local pointsSpent = GetTotalSpentShrinePoints()
		local bonus = (pointsSpent * CurrentRun.Hero.ShrinePointMetaPointBonusMultiplier) * 100
		ModifyTextBox({ Id = screen.Components.SubtitleMetaPointBonus.Id, Text = screen.SubtitleMetaPointBonusText, LuaKey = "TempTextData", LuaValue = { Current = pointsSpent, Limit = GetShrinePointLimit()} })
	end

end

function UpdateRewardObtained( screen, weaponName, targetShrineThreshold )
	local components = screen.Components
	if ObtainedRoomShrineReward( weaponName, "A_Boss", targetShrineThreshold ) then
		SetAnimation({ DestinationId = components.TartarusClearIndicator.Id, Name = "PactBiomeComplete" })
	else
		SetAnimation({ DestinationId = components.TartarusClearIndicator.Id, Name = "Blank" })
	end
	SetAnimation({ DestinationId = components.TartarusClearRewardIndicator.Id, Name = GetRoomShrineRewardIcon( weaponName, "A_Boss", targetShrineThreshold ) })

	if ObtainedRoomShrineReward( weaponName, "B_Boss01", targetShrineThreshold ) then
		SetAnimation({ DestinationId = components.AsphodelClearIndicator.Id, Name = "PactBiomeComplete" })
	else
		SetAnimation({ DestinationId = components.AsphodelClearIndicator.Id, Name = "Blank" })
	end
	SetAnimation({ DestinationId = components.AsphodelClearRewardIndicator.Id, Name = GetRoomShrineRewardIcon( weaponName, "B_Boss01", targetShrineThreshold ) })


	if ObtainedRoomShrineReward( weaponName, "C_Boss01", targetShrineThreshold ) then
		SetAnimation({ DestinationId = components.ElysiumClearIndicator.Id, Name = "PactBiomeComplete" })
	else
		SetAnimation({ DestinationId = components.ElysiumClearIndicator.Id, Name = "Blank" })
	end
	SetAnimation({ DestinationId = components.ElysiumClearRewardIndicator.Id, Name = GetRoomShrineRewardIcon( weaponName, "C_Boss01", targetShrineThreshold ) })

	if ObtainedRoomShrineReward( weaponName, "D_Boss01", targetShrineThreshold ) then
		SetAnimation({ DestinationId = components.StyxClearIndicator.Id, Name = "PactBiomeComplete" })
	else
		SetAnimation({ DestinationId = components.StyxClearIndicator.Id, Name = "Blank" })
	end
	SetAnimation({ DestinationId = components.StyxClearRewardIndicator.Id, Name = GetRoomShrineRewardIcon( weaponName, "D_Boss01", targetShrineThreshold ) })
end

function UpdateButtonStates( screen )
	local components = screen.Components
	local capApplies = (GetNumMetaUpgrades( "MetaPointCapShrineUpgrade" ) > 0 and screen.ResourceName == "MetaPoints") or screen.ResourceName == "ShrinePoints"
	local pointCap = 0
	local currentPoints = 0
	if screen.ResourceName == "ShrinePoints" then
		pointCap = screen.MaxShrinePoints
		currentPoints = GetTotalSpentShrinePoints()
		local rewardPoints = currentPoints
		local currentShrineThreshold = GetShrinePointLimit()
		local percentFill = 1
		if currentShrineThreshold > 0 then
			percentFill = currentPoints / currentShrineThreshold
		end
		if rewardPoints > currentShrineThreshold then
			rewardPoints = currentShrineThreshold
		end

		UpdateRewardObtained( screen, GetEquippedWeapon(), rewardPoints )
		SetAnimationFrameTarget({ Name = "ShrineMeterBarFill", Fraction = percentFill, DestinationId = components.ThermometerForeground.Id })
		local text = "Blank"
		local shrineThresholdColor = Color.White

		if ( not screen.LastPoints or screen.LastPoints < currentShrineThreshold )and currentPoints >= currentShrineThreshold then
			SetAnimation({ DestinationId = components.ThermometerEffects.Id, Name = "HeatThresholdReached"})
		end
		if ( not screen.LastPoints or screen.LastPoints - currentShrineThreshold < 1 ) and ( currentPoints - currentShrineThreshold ) >= 1 then
			CreateAnimation({ Name = "PactThermometerExcessHeat1", DestinationId = components.ThermometerEffects.Id })
		end
		if ( not screen.LastPoints or  screen.LastPoints - currentShrineThreshold < 8 ) and ( currentPoints - currentShrineThreshold ) >= 8 then
			CreateAnimation({ Name = "PactThermometerExcessHeat2", DestinationId = components.ThermometerEffects.Id })
		end
		if ( not screen.LastPoints or screen.LastPoints - currentShrineThreshold < 16 ) and ( currentPoints - currentShrineThreshold ) >= 16 then
			CreateAnimation({ Name = "PactThermometerExcessHeat3", DestinationId = components.ThermometerEffects.Id })
		end
		if( not screen.LastPoints or  screen.LastPoints - currentShrineThreshold < 39 ) and ( currentPoints - currentShrineThreshold ) >= 39 then
			CreateAnimation({ Name = "PactThermometerExcessHeat4", DestinationId = components.ThermometerEffects.Id })
		end

		if screen.LastPoints then
			if screen.LastPoints - currentShrineThreshold >= 1 and ( currentPoints - currentShrineThreshold ) < 1 then
				StopAnimation({ Name = "PactThermometerExcessHeat1", DestinationId = components.ThermometerEffects.Id })
			end
			if screen.LastPoints - currentShrineThreshold >= 8 and ( currentPoints - currentShrineThreshold ) < 8 then
				StopAnimation({ Name = "PactThermometerExcessHeat2", DestinationId = components.ThermometerEffects.Id })
			end
			if screen.LastPoints - currentShrineThreshold >= 16 and ( currentPoints - currentShrineThreshold ) < 16 then
				StopAnimation({ Name = "PactThermometerExcessHeat3", DestinationId = components.ThermometerEffects.Id })
			end
			if screen.LastPoints - currentShrineThreshold >= 39 and ( currentPoints - currentShrineThreshold ) < 39 then
				StopAnimation({ Name = "PactThermometerExcessHeat4", DestinationId = components.ThermometerEffects.Id })
			end
		end


		if GetCurrentRunClearedShrinePointThreshold( GetEquippedWeapon() )> GetMaximumAllocatableShrinePoints() then
			-- At soft limit
			if ( currentPoints - currentShrineThreshold ) > 0 then
				if ( currentPoints - currentShrineThreshold ) >= 39 then
					text = "AboveSoftShrineCapThreshold_3"
					shrineThresholdColor = Color.OrangeRed
				elseif ( currentPoints - currentShrineThreshold ) >= 20 then
					text = "AboveSoftShrineCapThreshold_2"
					shrineThresholdColor = Color.Orange
				elseif ( currentPoints - currentShrineThreshold ) >= 8 then
					text = "AboveSoftShrineCapThreshold_1"
					shrineThresholdColor = Color.Yellow
				elseif ( currentPoints - currentShrineThreshold ) >= 1 then
					text = "AboveSoftShrineCapThreshold"
					shrineThresholdColor = Color.LightGold
				elseif ( currentPoints - currentShrineThreshold ) == 0 then
					text = "AtSoftShrineCapThreshold"
					shrineThresholdColor = Color.LightGold
				end
				if not IsShrinePointLevelFullyCleared( GetEquippedWeapon(), 0 ) and not GameState.Flags.HardMode then
					text = "BelowSoftShrineCapThreshold_ZeroLimitUncleared"
				end
			elseif not IsShrinePointLevelFullyCleared( GetEquippedWeapon(), 0 ) and currentPoints == 0 and not GameState.Flags.HardMode then
				text = "BelowSoftShrineCapThreshold_ZeroLimitUncleared_BountiesAvailable"
				shrineThresholdColor = Color.LightGold
			else
				text = "BelowSoftShrineCapThreshold"
				if not IsShrinePointLevelFullyCleared( GetEquippedWeapon(), 0 ) and not GameState.Flags.HardMode then
					text = "BelowSoftShrineCapThreshold_ZeroLimitUncleared"
				end
				shrineThresholdColor = Color.LightGold
			end
			if currentPoints < currentShrineThreshold and screen.LastPoints and ( screen.LastPoints - currentShrineThreshold >= 0 ) then
				SetAnimation({ DestinationId = components.ThermometerEffects.Id, Name = "HeatThresholdNotMet"})
			end
		else
			if currentPoints > currentShrineThreshold then
				text = "AboveShrineRewardThreshold"

				if ( currentPoints - currentShrineThreshold ) >= 39 then
					text = "AboveShrineRewardThreshold_3"
					shrineThresholdColor = Color.OrangeRed
				elseif ( currentPoints - currentShrineThreshold ) >= 16 then
					text = "AboveShrineRewardThreshold_2"
					shrineThresholdColor = Color.Orange
				elseif ( currentPoints - currentShrineThreshold ) >= 8 then
					text = "AboveShrineRewardThreshold_1"
					shrineThresholdColor = Color.Yellow
				elseif ( currentPoints - currentShrineThreshold ) >= 1 then
					text = "AboveShrineRewardThreshold"
					shrineThresholdColor = Color.LightGold
				end
			elseif currentPoints < currentShrineThreshold then
				if ( currentPoints - currentShrineThreshold ) < 0 then
					if currentPoints == 0 and not IsShrinePointLevelFullyCleared( GetEquippedWeapon(), 0 ) then
						text = "BelowShrineRewardThreshold_RewardEligible"
						shrineThresholdColor = Color.White
					else
						text = "BelowShrineRewardThreshold"
						shrineThresholdColor = Color.Crimson
					end
					if screen.LastPoints and ( screen.LastPoints - currentShrineThreshold >= 0 ) then
						SetAnimation({ DestinationId = components.ThermometerEffects.Id, Name = "HeatThresholdNotMet"})
					end
				end
			else
				text = "AtShrineRewardThreshold"
				PlaySound({ Name = "/SFX/HeatRewardDrop" })
				if not screen.LastPoints or screen.LastPoints < currentShrineThreshold then
					SetAnimation({ DestinationId = components.ThermometerEffects.Id, Name = "HeatThresholdReached"})
				end
			end
		end
		thread( PulseShrineText, components.ThresholdText.Id, text, shrineThresholdColor )

		local color = Color.White
		-- other presentation around being below / above the threshold
		if currentPoints >= GetMaximumAllocatableShrinePoints() and IsShrinePointLevelFullyCleared( GetEquippedWeapon(), GetMaximumAllocatableShrinePoints()) and GetCurrentRunClearedShrinePointThreshold( GetEquippedWeapon() )> GetMaximumAllocatableShrinePoints() then
			ModifyTextBox({ Id = components.LocationAlertHeader.Id, Text = "ShrineRewardBiomeProgress_Inactive",  ColorTarget = Color.DimGray, ColorDuration = 0.5, LuaKey = "TempTextData", LuaValue = { ShrinePointThreshold = currentPoints, WeaponName = WeaponData[GetEquippedWeapon()].ShortName } })
			ModifyTextBox({ Id = components.LocationAlerts.Id, ColorTarget = Color.DimGray, ColorDuration = 0.5, LuaKey = "TempTextData", LuaValue = { ShrinePointThreshold = currentPoints, WeaponName = WeaponData[GetEquippedWeapon()].ShortName } })
			SetColor({ Ids = screen.ClearIndicatorIds, Color = Color.DarkSlateGray, Duration = 0.5 })
			color = Color.Red
		elseif currentPoints == currentShrineThreshold or ( currentPoints == 0 and not IsShrinePointLevelFullyCleared( GetEquippedWeapon(), 0 ) ) then
			ModifyTextBox({ Id = components.LocationAlertHeader.Id, Text = "ShrineRewardBiomeProgress", ColorTarget = Color.White, ColorDuration = 0.5, LuaKey = "TempTextData", LuaValue = { ShrinePointThreshold = currentPoints, WeaponName = WeaponData[GetEquippedWeapon()].ShortName } })
			ModifyTextBox({ Id = components.LocationAlerts.Id, ColorTarget = Color.White, ColorDuration = 0.5, LuaKey = "TempTextData", LuaValue = { ShrinePointThreshold = currentPoints, WeaponName = WeaponData[GetEquippedWeapon()].ShortName } })
			SetColor({ Ids = screen.ClearIndicatorIds, Color = Color.White, Duration = 0.5 })
		elseif currentPoints < currentShrineThreshold then
			ModifyTextBox({ Id = components.LocationAlertHeader.Id, Text = "ShrineRewardBiomeProgress_Inactive",  ColorTarget = Color.DimGray, ColorDuration = 0.5, LuaKey = "TempTextData", LuaValue = { ShrinePointThreshold = currentPoints, WeaponName = WeaponData[GetEquippedWeapon()].ShortName } })
			ModifyTextBox({ Id = components.LocationAlerts.Id, ColorTarget = Color.DimGray, ColorDuration = 0.5, LuaKey = "TempTextData", LuaValue = { ShrinePointThreshold = currentPoints, WeaponName = WeaponData[GetEquippedWeapon()].ShortName } })
			SetColor({ Ids = screen.ClearIndicatorIds, Color = Color.DarkSlateGray, Duration = 0.5 })
			color = Color.Red
		elseif currentPoints > currentShrineThreshold then
			ModifyTextBox({ Id = components.LocationAlertHeader.Id, Text = "ShrineRewardBiomeProgress", ColorTarget = Color.White, ColorDuration = 0.5, LuaKey = "TempTextData", LuaValue = { ShrinePointThreshold = currentShrineThreshold, WeaponName = WeaponData[GetEquippedWeapon()].ShortName } })
			ModifyTextBox({ Id = components.LocationAlerts.Id, ColorTarget = Color.White, ColorDuration = 0.5, LuaKey = "TempTextData", LuaValue = { ShrinePointThreshold = currentShrineThreshold, WeaponName = WeaponData[GetEquippedWeapon()].ShortName } })
			SetColor({ Ids = screen.ClearIndicatorIds, Color = Color.White, Duration = 0.5 })
			color = Color.Orange
			thread( PlayVoiceLines, HeroVoiceLines.ShrineHeatThresholdExceededVoiceLines, true )
		end
		ModifyTextBox({ Id = screen.Components.SpentShrinePoints.Id, Text = screen.SubtitleText, ColorTarget = color, ColorDuration = 0.5, LuaKey = "TempTextData", LuaValue = { CurrentAmount = GetTotalSpentShrinePoints(), TargetAmount = currentShrineThreshold } })

		--[[
		if GameState.Flags.HardMode and components.StartButton then
			if  currentPoints < currentShrineThreshold then
				ModifyTextBox({ Id = components.StartButton.Id, Text = "ShrineMenu_Blocked", Color = Color.Red })
			else
				ModifyTextBox({ Id = components.StartButton.Id, Text = "ShrineMenu_Confirm", Color = Color.White})
			end
		end
		]]

		screen.LastPoints = currentPoints
	elseif screen.ResourceName == "MetaPoints" then
		pointCap = MetaUpgradeData.MetaPointCapShrineUpgrade.BaseValue + (GetNumMetaUpgrades( "MetaPointCapShrineUpgrade" ) * MetaUpgradeData.MetaPointCapShrineUpgrade.ChangeValue)
		currentPoints = GetTotalSpentMetaPoints()
	end

	for i, component in pairs( components ) do
		if component.HandleType == "Add" then
			local isEnabled = IsMetaUpgradeValid ( screen, component, currentPoints, capApplies, pointCap )
			if component.LastEnabled ~= isEnabled then
				local button = CreateArrowButton( component.ParentIndex, { Screen = screen, Data = component.Data, IsIncrease = true, IsEnabled = isEnabled } )
				button.ResourceName = screen.ResourceName
			end
			if not isEnabled then
				if component.Data.NextCost ~= nil then
					local costText = "MetaUpgradeMenu_InvalidCost"
					local color = Color.MetaUpgradePointsInvalid
					if screen.ResourceName == "ShrinePoints" then
						costText = "ShrineMenu_InvalidCost"
					end
					if capApplies and ( currentPoints + component.Data.NextCost ) > pointCap then
						color = Color.MetaUpgradePointsCappedColor
					end

					ModifyTextBox({ Id = component.NextCostId, Text = costText, LuaKey = "TempTextData", LuaValue = { Amount = component.Data.NextCost }, ColorTarget = color, ColorDuration = 0.0, ShadowAlpha = 0})
				else
					ModifyTextBox({ Id = component.NextCostId, Text = "MetaUpgradeMenu_Maxed", ColorTarget = Color.MetaUpgradePointsInvalid })
				end
			else
				local icon = "{!Icons.MetaPoint_Small}"
				if screen.ResourceName == "ShrinePoints" then
					icon = "{!Icons.ShrinePointSmall}"
				end
				ModifyTextBox({ Id = component.NextCostId, Text = component.Data.NextCost..icon, ColorTarget = Color.White, ColorDuration = 0.0, ShadowAlpha = 1})
			end
		elseif component.HandleType == "Remove" and screen.ResourceName == "ShrinePoints" then
			local isEnabled = GetNumMetaUpgrades( component.Data.Name ) >= 1 and CanDecrementValue( component.Data, currentPoints, screen.ResourceName )
			if component.LastEnabled ~= isEnabled then
				local button = CreateArrowButton( component.ParentIndex, { Screen = screen, Data = component.Data, IsIncrease = false, IsEnabled = isEnabled } )
				button.ResourceName = screen.ResourceName
			end
		elseif component.HandleType == "Unlock" then
			local isEnabled = HasResource( component.Data.ResourceName, component.Data.UnlockCost )
			if component.LastEnabled ~= isEnabled then
				local button = CreateUnlockButton( component.Data, { Screen = screen, OffsetX = component.OffsetX, OffsetY = component.OffsetY, Index = component.ParentIndex, IsEnabled = isEnabled, KeyCostKey = "UpgradeCost"..component.ParentIndex } )
				button.ResourceName = screen.ResourceName
			end

			if not isEnabled then
				ModifyTextBox({ Id = components[component.KeyCostKey].Id, Color = Color.MetaUpgradePointsInvalid })
			end
		end
	end

	if components.StartButton ~= nil then
		local currentShrineThreshold = GetCurrentRunClearedShrinePointThreshold( GetEquippedWeapon() )
		if GameState.SpentShrinePointsCache < currentShrineThreshold then
			SetColor({ Id = components.StartButton.Id, Color = Color.Gray })
		else
			SetColor({ Id = components.StartButton.Id, Color = Color.White })
		end
	end

end

OnMouseOver{ "ShrineUpgradeMenuConfirm ShrineUpgradeMenuInfo",
	function( triggerArgs )
		PlaySound({ Name = "/SFX/Menu Sounds/DialoguePanelOutMenu", Id = ScreenAnchors.LevelUpStatHighlightId })
	end
}

OnMouseOver{ "LevelUpPlus LevelUpPlusDisabled ExchangeMetaupgrade ButtonRefund",
	function( triggerArgs )
		if not triggerArgs.CreatedThisFrame then
			PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuToggle", Id = triggerArgs.triggeredById })
		end
	end
}

OnMouseOver{ "LevelUpArrowLeft LevelUpArrowLeftDisabled",
	function( triggerArgs )
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuToggle", Id = ScreenAnchors.LevelUpStatHighlightId })
		local button = FindMetaUpgradeButton( triggerArgs.triggeredById )
		local screen = ScreenAnchors.LevelUpScreen or ScreenAnchors.ShrineScreen
		if not screen or not button then
			return
		end
		local offsetX = screen.HighlightX
		Teleport({ Id = ScreenAnchors.LevelUpStatHighlightId,  DestinationId = triggerArgs.triggeredById, OffsetX = offsetX, OffsetY = -4 })
		SetAlpha({ Id = ScreenAnchors.LevelUpStatHighlightId, Fraction = 1.0, Duration = 0.2 })
		UpdateSubtitle( button )
	end
}

OnMouseOver{ "LevelUpArrowRight LevelUpArrowRightDisabled",
	function( triggerArgs )
		local button = FindMetaUpgradeButton( triggerArgs.triggeredById )
		local screen = ScreenAnchors.LevelUpScreen or ScreenAnchors.ShrineScreen
		if not screen or not button then
			return
		end
		local offsetX = screen.HighlightX
		if button.HandleType == "Add" then
			offsetX = offsetX - 34
		end
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuToggle", Id = ScreenAnchors.LevelUpStatHighlightId })
		Teleport({ Id = ScreenAnchors.LevelUpStatHighlightId,  DestinationId = triggerArgs.triggeredById, OffsetX = offsetX, OffsetY = -4 })
		SetAlpha({ Id = ScreenAnchors.LevelUpStatHighlightId, Fraction = 1.0, Duration = 0.2 })
		UpdateSubtitle( button )
	end
}

OnMouseOff{ "LevelUpArrowLeft LevelUpArrowLeftDisabled",
	function( triggerArgs )
		SetAlpha({ Id = ScreenAnchors.LevelUpStatHighlightId, Fraction = 0.0, Duration = 0.2 })
		UpdateSubtitle( FindMetaUpgradeButton( triggerArgs.triggeredById ))
	end
}

OnMouseOff{ "LevelUpArrowRight LevelUpArrowRightDisabled",
	function( triggerArgs )
		SetAlpha({ Id = ScreenAnchors.LevelUpStatHighlightId, Fraction = 0.0, Duration = 0.2 })
		UpdateSubtitle( FindMetaUpgradeButton( triggerArgs.triggeredById ))
	end
}

function HandleMetaUpgradeInput( screen, button )

	local buttonId = button.Id
	local upgradeData = button.Data
	local currentRun = CurrentRun
	local hasAction = false

	local capApplies = (GetNumMetaUpgrades( "MetaPointCapShrineUpgrade" ) > 0 and screen.ResourceName == "MetaPoints") or screen.ResourceName == "ShrinePoints"
	local pointCap = 0
	local currentPoints = 0

	if screen.ResourceName == "ShrinePoints" then
		pointCap = screen.MaxShrinePoints
		currentPoints = GetTotalSpentShrinePoints()
	elseif screen.ResourceName == "MetaPoints" then
		pointCap = MetaUpgradeData.MetaPointCapShrineUpgrade.BaseValue + (GetNumMetaUpgrades( "MetaPointCapShrineUpgrade" ) * MetaUpgradeData.MetaPointCapShrineUpgrade.ChangeValue)
		currentPoints = GetTotalSpentMetaPoints()
	end

	upgradeData.NextCost = GetMetaUpgradePurchasePrice( upgradeData )
	upgradeData.NextRefund = GetMetaUpgradeRefundPrice( upgradeData )
	if button.HandleType == "Add" then
		if upgradeData.RankGameStateRequirements and upgradeData.RankGameStateRequirements[GetNumMetaUpgrades( upgradeData.Name ) + 1 ] and not IsGameStateEligible( CurrentRun, upgradeData.RankGameStateRequirements[GetNumMetaUpgrades( upgradeData.Name ) + 1 ]  ) then
			thread( MetaUpgradeIneligiblePresentation, button, upgradeData )
			thread( CannotAffordMetaUpgradePresentation, button.NextCostId )
		elseif upgradeData.GameStateRequirements and not IsGameStateEligible( CurrentRun, upgradeData.GameStateRequirements ) then
			thread( MetaUpgradeIneligiblePresentation, button, upgradeData )
			thread( CannotAffordMetaUpgradePresentation, button.NextCostId )
		elseif upgradeData.NextCost == nil then
			-- Maxed out
			thread( MetaUpgradeAtMaxPresentation, button.NextCostId )
		elseif capApplies and currentPoints + upgradeData.NextCost > pointCap then
			-- Shrine cap
			thread( MetaUpgradesAtGlobalCapPresentation, button.NextCostId )
		elseif not HasResource( button.ResourceName, upgradeData.NextCost ) and not screen.FreeSpend  then
			-- Not enough darkness
			thread( CannotAffordMetaUpgradePresentation, button.NextCostId )
		elseif upgradeData.RequiredTotalInvestment ~= nil and currentPoints < upgradeData.RequiredTotalInvestment then
			-- Needs more investment before it unlocks
			thread( InCombatTextArgs, { Text = "ShrineNeedsMoreInvestment", TargetId = CurrentRun.Hero.ObjectId, SkipRise = false, SkipFlash = false, SkipShadow = true, Duration = 1.25, Group = "Combat_Menu_Overlay", LuaKey = "TempTextData", LuaValue = { Amount = upgradeData.RequiredTotalInvestment }} )

			thread( CannotAffordMetaUpgradePresentation, button.NextCostId )
		else
			DebugPrint({ Text = "    ApplyMetaUpgrade: "..upgradeData.Name })
			PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuStatIncrease" })
			if not screen.FreeSpend then
				GameState.Resources[button.ResourceName] = GameState.Resources[button.ResourceName] - upgradeData.NextCost
				UpdateResourceUI( button.ResourceName, GameState.Resources[button.ResourceName] )
			end
			_G[screen.SpendPresentationName](upgradeData.NextCost, buttonId)

			IncrementTableValue( GameState.MetaUpgrades, upgradeData.Name )
			ApplyMetaUpgrade( upgradeData, true, GameState.MetaUpgrades[upgradeData.Name] > 1 )

			if GetMetaUpgradePurchasePrice( upgradeData ) == nil then
				FinalMetaUpgradePresentation( button, upgradeData.Name )
			end

			if upgradeData.DisablesMetaUpgrades then
				local startIndex = TableLength(MetaUpgradeOrder) - GetNulledMetaUpgradeCount() - upgradeData.ChangeValue
				for i = startIndex, startIndex + upgradeData.ChangeValue + 1, -1 do
					local metaUpgradeData = MetaUpgradeData[GameState.MetaUpgradesSelected[i]]
					if GameState.MetaUpgradeState[metaUpgradeData.Name] then
						for s = 1, GameState.MetaUpgradeState[metaUpgradeData.Name] do
							ApplyMetaUpgrade( metaUpgradeData, true, s == 1, true)
						end
					end
				end
			end

			screen.PointsAddedThisTime = screen.PointsAddedThisTime + 1
			hasAction = true
		end
	elseif button.HandleType == "Remove" then
		if not CanDecrementValue( upgradeData, currentPoints, button.ResourceName ) then
			thread( CannotDecrementMetaUpgradePresentation, button.NextCostId )
		elseif GetNumMetaUpgrades( upgradeData.Name ) > 0 then
			DebugPrint({ Text = "    RemoveMetaUpgrade: "..upgradeData.Name })
			PlaySound({ Name = "/SFX/Menu Sounds/MirrorMenuStatLower" })
			if not screen.FreeSpend then
				GameState.Resources[button.ResourceName] = GameState.Resources[button.ResourceName] + upgradeData.NextRefund
				UpdateResourceUI( button.ResourceName, GameState.Resources[button.ResourceName] )
			end
			_G[screen.RefundPresentationName](upgradeData.NextRefund, buttonId)
			DecrementTableValue( GameState.MetaUpgrades, upgradeData.Name )
			ApplyMetaUpgrade( upgradeData, true, GameState.MetaUpgrades[upgradeData.Name] <= 0, true )

			if upgradeData.DisablesMetaUpgrades then
				local startIndex = TableLength(MetaUpgradeOrder) - GetNulledMetaUpgradeCount()
				for i = startIndex, startIndex + upgradeData.ChangeValue + 1, -1 do
					local metaUpgradeData = MetaUpgradeData[GameState.MetaUpgradesSelected[i]]
					if GameState.MetaUpgradeState[metaUpgradeData.Name] then
						for s = 1, GameState.MetaUpgradeState[metaUpgradeData.Name] do
							ApplyMetaUpgrade( metaUpgradeData, true, s == 1 )
						end
					end
				end
			end
			screen.PointsAddedThisTime = screen.PointsAddedThisTime - 1
			hasAction = true
		else
			thread( CannotRefundMetaupgrade, button.TotalTextBoxId )
			if screen.ResourceName == "MetaPoints" then
				thread( PlayVoiceLines, HeroVoiceLines.InvalidInteractionVoiceLines, true )
			end
		end

	end
	if not hasAction then
		return
	end

	Heal( currentRun.Hero, { HealAmount = currentRun.Hero.MaxHealth, Silent = true } )
	thread( UpdateHealthUI )
	upgradeData.NextCost = GetMetaUpgradePurchasePrice( upgradeData )
	upgradeData.NextRefund = GetMetaUpgradeRefundPrice( upgradeData )
	local numUpgrades = GetNumMetaUpgrades( upgradeData.Name )
	local totalStatChange = GetTotalStatChange( upgradeData )
	local text = GetMetaUpgradeShortTotalText( upgradeData )
	local color = Color.White
	if numUpgrades ~= 0 then
		color = screen.InvestedColor
	end

	ModifyTextBox({ Id = button.TextBoxId, Text = tostring( numUpgrades ) })
	ModifyTextBox({ Id = button.TotalTextBoxId, Text = text, LuaKey = "TempTextData", LuaValue = { Amount = totalStatChange }, ColorTarget = color, ColorDuration = 0.1 })

	UpdateButtonStates( screen )
	UpdateSubtitle( button )
	UpdateResourceUI( "MetaPoints", GameState.MetaPoints )
	-- Can be refilled at the mirror
	CurrentRun.NumRerolls = GetNumMetaUpgrades( "RerollMetaUpgrade" ) + GetNumMetaUpgrades("RerollPanelMetaUpgrade")
	if CurrentRun.NumRerolls > 0 then
		ShowResourceUIs({ CombatOnly = false })
	end
	UpdateRerollUI( CurrentRun.NumRerolls )

	GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()
	if button.ResourceName == "ShrinePoints" then
		UpdateActiveShrinePoints()
	end

end

function AttemptUnlock( screen, button )
	local index = button.ParentIndex
	local itemBackingKey = "Backing"..index
	local unlockId = "Locked"..index
	local lockIconKey = "LockIcon"..index
	local metaUpgradeNextCostKey = "UpgradeCost"..index
	local components = screen.Components

	if HasResource( button.Data.ResourceName, button.Data.UnlockCost ) then
		SpendResource( button.Data.ResourceName, button.Data.UnlockCost, "MetaUpgradeScreen", { Silent = true })
		GameState.MetaUpgradesUnlocked[button.Data.Name] = true
		if screen.Name == "MetaUpgrade" then
			for i, upgradeName in pairs( MetaUpgradeOrder[index] ) do
				GameState.MetaUpgradesUnlocked[upgradeName] = true
			end
		end

		DestroyTextBox({Id = components[itemBackingKey].Id })
		Destroy({ Id = components[unlockId].Id })
		Destroy({ Id = components[metaUpgradeNextCostKey].Id })
		components[unlockId] = nil
		components[metaUpgradeNextCostKey] = nil
		thread( FadeAndDestroyLock, components[lockIconKey].Id )
		thread( PlayVoiceLines, screen.UnlockVoiceLines, true )
		CreateMetaUpgradeEntry( { Screen = screen, Components = components, Data = button.Data, Index = index, OffsetY = button.OffsetY, Swap = ( GameState.Flags.SwapMetaupgradesEnabled and screen.Name == "MetaUpgrade" )} )
		UpdateButtonStates( screen )

		TeleportCursor({ OffsetX = button.OffsetX + LevelUpUI.RightArrowOffsetX, OffsetY = button.OffsetY + LevelUpUI.RightArrowOffsetY })
		if not GetConfigOptionValue({ Name = "UseMouse" }) then
			RunInteractMethod({ Id = components["RightArrowButton"..index].Id, Method = "HighlightOn" })
		end

		local keyAmount = GameState.Resources.LockKeys or 0
		local superKeyAmount = GameState.Resources.SuperLockKeys or 0
		ModifyTextBox({ Id = screen.Components.SubTitleKeys.Id, Text = "MetaUpgradeMenu_Subtitle_Key", LuaKey = "TempTextData",  LuaValue = { CurrentKeys = keyAmount, CurrentSuperKeys = superKeyAmount }})
		-- Fade out keys if no unlocked entries
		local hasLockedUpgrades = false
		local ordering = GameState.MetaUpgradesSelected
		if screen.Name ==  "ShrineUpgrade" then
			ordering = ShrineUpgradeOrder
		end

		for k, upgradeName in pairs( ordering ) do
			if not GameState.MetaUpgradesUnlocked[upgradeName] then
				hasLockedUpgrades = true
				break
			end
		end

		if not hasLockedUpgrades then
			Destroy({ Id = screen.Components.SubTitleKeys.Id })
		end
	else

		thread( PulseAnimation, {Id = components[lockIconKey].Id, ScaleTarget = 1.4, ScaleDuration = 0.25, HoldDuration = 0, PulseBias = 0.1 })
		thread( CannotUnlockMetaupgrade, components[metaUpgradeNextCostKey].Id )
		thread( PlayVoiceLines, HeroVoiceLines.NotEnoughLockKeysVoiceLines, true )
	end
end

function SwapMetaupgrade( screen, button )
	local index = button.Index
	local itemBackingKey = "Backing"..index
	local unlockId = "Locked"..index
	local lockIconKey = "LockIcon"..index
	local metaUpgradeNextCostKey = "UpgradeCost"..index
	local upgradeName = button.Name
	local components = screen.Components
	local isSwapToBSide = ( MetaUpgradeOrder[index][1] == upgradeName )

	SwapMetaUpgradePresentation( screen, components[itemBackingKey.."Swap"], isSwapToBSide )

	DestroyTextBox({Id = components[itemBackingKey].Id })
	Destroy({ Id = components["Icon"..index].Id })
	Destroy({ Id = components["UpgradeValueTotal"..index].Id })
	Destroy({ Id = components["UpgradeCost"..index].Id })
	Destroy({ Ids = { components[itemBackingKey.."Swap"].Id, components[metaUpgradeNextCostKey].Id }})
	components[unlockId] = nil
	components[metaUpgradeNextCostKey] = nil
	components[itemBackingKey.."Swap"] = nil

	GameState.MetaUpgradeState = GameState.MetaUpgradeState or {}

	local numUpgrades = GetNumMetaUpgrades( upgradeName )
	GameState.MetaUpgradeState[upgradeName] = numUpgrades
	for i = 1, numUpgrades, 1 do
		DecrementTableValue( GameState.MetaUpgrades, upgradeName )
		ApplyMetaUpgrade( MetaUpgradeData[upgradeName], true, GameState.MetaUpgrades[upgradeName] <= 0, true )
	end

	local metaupgradeData = nil
	for i, entryName in pairs(MetaUpgradeOrder[index]) do
		if entryName ~= upgradeName then
			metaupgradeData = MetaUpgradeData[entryName]
			GameState.MetaUpgradesSelected[index] = entryName
			local savedUpgrades = GameState.MetaUpgradeState[ entryName ] or 0
			for i = 1, savedUpgrades, 1 do
				IncrementTableValue( GameState.MetaUpgrades, entryName )
				ApplyMetaUpgrade( MetaUpgradeData[ entryName ], true, GameState.MetaUpgrades[entryName] > 1 )
			end
		end
	end
	wait( 0.01 )
	CreateMetaUpgradeEntry( { Screen = screen, Components = components, Data = metaupgradeData, Index = index, OffsetY = button.OffsetY, Swap = GameState.Flags.SwapMetaupgradesEnabled } )
	UpdateButtonStates( screen )
	CurrentRun.NumRerolls = GetNumMetaUpgrades( "RerollMetaUpgrade" ) + GetNumMetaUpgrades("RerollPanelMetaUpgrade")
	if CurrentRun.NumRerolls > 0 then
		ShowResourceUIs({ CombatOnly = false })
	end
	UpdateRerollUI( CurrentRun.NumRerolls )

end

function CloseMetaUpgradeScreen( screen, button )

	if screen.PointsAddedThisTime > 0 then
		thread( PlayVoiceLines, GlobalVoiceLines.MetaUpgradeSelectedVoiceLines )
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorCloseWithUpgrade" })
	else
		PlaySound({ Name = "/SFX/Menu Sounds/MirrorCloseNoUpgrade" })
	end

	UpdateSeenMetaUpgrades()
	DisableShopGamepadCursor()
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "FreeFormSelectRepeatDelay", Value = 0.0 })
	SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = screen.CloseAnimation })
	CloseScreen( GetAllIds( screen.Components ), 0.1 )
	ScreenAnchors.LevelUpScreen = nil
	UnfreezePlayerUnit()
	screen.KeepOpen = false
	OnScreenClosed({ Flag = screen.Name })

end

function CloseShrineUpgradeScreen( screen, button )

	UpdateSeenMetaUpgrades()
	DisableShopGamepadCursor()
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "FreeFormSelectRepeatDelay", Value = 0.0 })
	SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = screen.CloseAnimation })
	CloseScreen( GetAllIds( screen.Components ), 0.1 )
	ScreenAnchors.ShrineScreen = nil
	UnfreezePlayerUnit()
	screen.KeepOpen = false
	OnScreenClosed({ Flag = screen.Name })
	ShowCombatUI()

	StopAnimation({ Names = { "PactThermometerExcessHeat1", "PactThermometerExcessHeat2", "PactThermometerExcessHeat3", "PactThermometerExcessHeat4"}, DestinationId = screen.Components.ThermometerEffects.Id })
	RefundMetaUpgradesOverCap()
	SaveShrineLoadout( GetEquippedWeapon() )
end

function ShowShrineInfo( screen, button )
	if GameState.Flags.HardMode then
		OpenMenu({ Name = "AnnouncementScreen", MessageId = "ShrineIntro_HardMode" })
	else
		OpenMenu({ Name = "AnnouncementScreen", MessageId = "ShrineIntro_ReturningPlayers" })
	end
	waitUntil( "AnnouncementScreen" )
	wait( 0.3 )
end


function CloseShrineUpgradeScreenAndStartOver( screen, button )

	--[[
	local currentShrineThreshold = GetCurrentRunClearedShrinePointThreshold( GetEquippedWeapon() )
	if GameState.Flags.HardMode and GameState.SpentShrinePointsCache < currentShrineThreshold then
		HardModeInsufficientShrinePointsPresentation( screen )
		return
	end
	]]

	PlaySound({ Name = "/SFX/Menu Sounds/TextReveal4" })
	HideCombatUI("RestartRunLoop")
	CloseShrineUpgradeScreen( screen, button )
	SaveShrineLoadout( GetEquippedWeapon() )
	StartOver()
	UnblockCombatUI("RestartRunLoop")
end

function RefundMetaUpgradesOverCap()

	local numCapUpgrades = GetNumMetaUpgrades( "MetaPointCapShrineUpgrade" )
	if numCapUpgrades <= 0 then
		return
	end

	local metaPointCap = MetaUpgradeData.MetaPointCapShrineUpgrade.BaseValue + (numCapUpgrades * MetaUpgradeData.MetaPointCapShrineUpgrade.ChangeValue)
	local metaPointsSpent = GetTotalSpentMetaPoints()
	local overCapBy = metaPointsSpent - metaPointCap
	DebugPrint({ Text = "overCapBy = "..overCapBy })
	if overCapBy <= 0 then
		return
	end

	-- Refund in reverse order
	local totalRefund = 0
	for i = #GameState.MetaUpgradesSelected, 1, -1 do
		local upgradeName = GameState.MetaUpgradesSelected[i]
		local upgradeData = MetaUpgradeData[upgradeName]
		local numUpgrades = GetNumMetaUpgrades( upgradeData.Name )
		for j = 1, numUpgrades, 1 do
			local refund = GetMetaUpgradeRefundPrice( upgradeData )
			DebugPrint({ Text = "    RemoveMetaUpgrade: "..upgradeData.Name })
			AddResource( "MetaPoints", refund, "MetaPointCapRefund", { Silent = true, ApplyMultiplier = false, NoLifetimeEffect = true, } )
			DecrementTableValue( GameState.MetaUpgrades, upgradeData.Name )
			ApplyMetaUpgrade( upgradeData, true, GameState.MetaUpgrades[upgradeData.Name] <= 0, true )
			overCapBy = overCapBy - refund
			totalRefund = totalRefund + refund
			if overCapBy <= 0 then
				MetaPointCapRefundPresentation( totalRefund )
				return
			end
		end
	end
end

function FadeAndDestroyLock( lockId )
	SetAnimation({ DestinationId = lockId, Name = "LockedIconRelease"})
	wait(1)
	Destroy({Id = lockId})
end

function GetMetaUpgradeStatDelta(upgradeData)
	local topLevelTable = upgradeData;
	if topLevelTable.ChangeValue == nil then
		topLevelTable = upgradeData.PropertyChanges[1]
	end

	if topLevelTable ~= nil then
		local key = "ChangeValue"
		if not isint(topLevelTable[key]) or topLevelTable.FormatAsPercent then
			key = "ChangeValuePercentDelta"
		end
		if topLevelTable.FormatAsAbsoluteValue then
			key = math.abs(key)
		end
		if topLevelTable.DecimalPlaces then
			if key == "ChangeValuePercentDelta" then
				-- Value is pre-rounded so extract unrounded values
				return round( (topLevelTable.ChangeValue - 1) * 100, topLevelTable.DecimalPlaces )
			else
				return round( topLevelTable[key], topLevelTable.DecimalPlaces )
			end
		else
			return topLevelTable[key]
		end
	end
	return 0
end

function GetTotalStatChange( upgradeData, numUpgradesOverride )
	local numUpgrades = numUpgradesOverride or GetNumMetaUpgrades( upgradeData.Name )
	if upgradeData.ChangeValues and numUpgrades > 0 then
		if upgradeData.FormatAsPercent then
			return ( upgradeData.ChangeValues[numUpgrades] - 1 ) * 100
		else
			return upgradeData.ChangeValues[numUpgrades]
		end
	end
	return (upgradeData.BaseValue or 0) + GetMetaUpgradeStatDelta(upgradeData) * numUpgrades
end

function UpdateSeenMetaUpgrades()
	GameState.LastUnlockedMetaUpgrades = {}
	for k, upgradeName in pairs( GameState.MetaUpgradesSelected ) do
		if GameState.MetaUpgradesUnlocked[upgradeName] then
			table.insert( GameState.LastUnlockedMetaUpgrades, upgradeName )
		end
	end
	for k, upgradeName in pairs( ShrineUpgradeOrder ) do
		if GameState.MetaUpgradesUnlocked[upgradeName] then
			table.insert( GameState.LastUnlockedMetaUpgrades, upgradeName )
		end
	end
end

function SaveShrineLoadout()
	if GameState.MetaUpgradeState == nil then
		GameState.MetaUpgradeState = {}
	end

	-- Save shrine MetaUpgrades
	for metaUpgradeName, metaUpgradeCount in pairs(GameState.MetaUpgrades) do
		if Contains(ShrineUpgradeOrder, metaUpgradeName) then
			GameState.MetaUpgradeState[metaUpgradeName] = metaUpgradeCount
		end
	end
end

function ClearShrineLoadout( )
	for metaUpgradeName, metaUpgradeCount in pairs(GameState.MetaUpgrades) do
		if Contains(ShrineUpgradeOrder, metaUpgradeName) then
			if metaUpgradeCount > 0 then
				for i = 1, metaUpgradeCount do
					DecrementTableValue( GameState.MetaUpgrades, metaUpgradeName, 1 )
				end
			end
		end
	end

	GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()
	UpdateActiveShrinePoints()
end

function GetMetaUpgradeShortTotalText( upgradeData, useNoIcon, numUpgradesOverride )
	local numUpgrades = numUpgradesOverride or GetNumMetaUpgrades( upgradeData.Name )
	if upgradeData.NoPointsHelpTextId and numUpgrades == 0 then
		return upgradeData.NoPointsHelpTextId
	elseif upgradeData.HelpTextTable then
		if upgradeData.HelpTextTable[numUpgrades] then
			return upgradeData.HelpTextTable[numUpgrades]
		end
	elseif useNoIcon and upgradeData.ShortTotalNoIcon then
		return upgradeData.ShortTotalNoIcon
	elseif upgradeData.ShortTotal then
		return upgradeData.ShortTotal
	end
	return tostring(numUpgrades)
end

function IsMetaUpgradeValid ( screen, component, currentPoints, capApplies, pointCap )
	if component.Data.RankGameStateRequirements then
		local upgradeData = component.Data
		local rankRequirements = component.Data.RankGameStateRequirements 
		if rankRequirements[GetNumMetaUpgrades( upgradeData.Name ) + 1 ] and not IsGameStateEligible( CurrentRun, rankRequirements[GetNumMetaUpgrades( upgradeData.Name ) + 1 ]  ) then
			return false
		end
	end
	return component.Data.NextCost ~= nil
	and	( screen.FreeSpend or HasResource( component.ResourceName, component.Data.NextCost ) )
	and ( not capApplies or ( currentPoints + component.Data.NextCost ) <= pointCap )
	and ( not component.Data.RequiredTotalInvestment or currentPoints >= component.Data.RequiredTotalInvestment )
	and ( component.Data.GameStateRequirements == nil or IsGameStateEligible( CurrentRun, component.Data.GameStateRequirements ))
end

function GetNulledMetaUpgradeCount( )
	local numUpgrades = GetNumMetaUpgrades("MetaUpgradeStrikeThroughShrineUpgrade", { UnModified = true })
	if  numUpgrades > 0 then
		return math.abs( numUpgrades * MetaUpgradeData.MetaUpgradeStrikeThroughShrineUpgrade.ChangeValue)
	end
	return 0
end

function IsMetaUpgradeActive( upgradeName, args )
	args = args or {}
	local nulledMetaUpgradeCount = GetNulledMetaUpgradeCount()

	if Contains(ShrineUpgradeOrder, upgradeName) then
		return true
	end

	for k, selectedUpgradeName in pairs( GameState.MetaUpgradesSelected ) do
		if k > (#MetaUpgradeOrder - nulledMetaUpgradeCount) and not args.UnModified then
			return false
		end
		if selectedUpgradeName == upgradeName then
			return true
		end
	end
	return false
end

function IsMetaUpgradeSelected( upgradeName )
	return Contains( GameState.MetaUpgradesSelected, upgradeName )
end

function CanDecrementValue( upgradeData, currentPoints, resourceName )
	if GameState.Flags.HardMode and HeroData.DefaultHero.HardModeForcedMetaUpgrades[upgradeData.Name] ~= nil and GetNumMetaUpgrades( upgradeData.Name ) <= HeroData.DefaultHero.HardModeForcedMetaUpgrades[upgradeData.Name] then
		return false
	end
	return true
end


function BiomeSpeedTimerLoop()
	while not CurrentRun.Hero.IsDead do
		if not HasTimerBlock( CurrentRun ) and not IsBiomeTimerPaused() and CurrentRun.ActiveBiomeTimer then
			if GetNumMetaUpgrades("BiomeSpeedShrineUpgrade") > 0 and CurrentRun.BiomeTime <= 0 and not CurrentRun.Hero.IsDead then
				local minHealth = 0
				if (CurrentRun.Hero.InvulnerableFlags ~= nil and not IsEmpty( CurrentRun.Hero.InvulnerableFlags )) or (CurrentRun.Hero.PersistentInvulnerableFlags ~= nil and not IsEmpty( CurrentRun.Hero.PersistentInvulnerableFlags )) then
					minHealth = 1
				end 
				Damage( CurrentRun.Hero, { SourceWeapon = "BiomeTimer", DamageAmount = BiomeTimeLimits.Penalty.Damage, MinHealth = minHealth, PureDamage = true, Silent = true } )			
				thread( UpdateHealthUI )
				if not CurrentRun.Hero.IsDead then
					BiomeDamagePresentation( BiomeTimeLimits.Penalty.Damage )
					SetMenuOptions({ Name = "InGameUI", Properties = { Run = "PulseExpiredBiomeTimeText" } })
				end
			elseif CurrentRun.BiomeTime <= 30 then
				-- critical time remaining
				SetMenuOptions({ Name = "InGameUI", Properties = { Run = "PulseElapsedBiomeTimeText" } })
			end
		end
		wait( BiomeTimeLimits.Penalty.Interval, RoomThreadName )
	end
end

function IsBiomeTimerPaused()
	if not CurrentRun.CurrentRoom or not CurrentRun.CurrentRoom.Encounter then
		return false
	end

	if CurrentRun.CurrentRoom.Encounter.PauseBiomeTimer then
		return true
	end

	return false
end

function RefundMetaUpgradeInvestment( screen, button )
	if not HasResource("LockKeys", button.Cost ) then
		CannotRefundMetaUpgradesPresentation( button )
		return
	end
	SpendResource( "LockKeys", button.Cost, "UnlockMetaUpgradePanel" )
	RefundMetaUpgradesPressedPresentation( screen, button )
	CloseMetaUpgradeScreen( screen, button )

	FreezePlayerUnit()
	wait(0.2)
	local totalRefund = 0

	-- Refund in reverse order
	for i, setData in pairs( MetaUpgradeOrder ) do
		for k, upgradeName in pairs( setData ) do
			local upgradeData = MetaUpgradeData[upgradeName]
			local numUpgrades = GetNumMetaUpgrades( upgradeName, { UnModified = true })
			if not IsMetaUpgradeActive(upgradeName, { UnModified = true }) then
				numUpgrades = GameState.MetaUpgradeState[ upgradeName ] or 0
			end
			for j = 1, numUpgrades, 1 do
				local refund = GetMetaUpgradeRefundPrice( upgradeData, { UnModified = true } )
				if IsMetaUpgradeActive( upgradeName, { UnModified = true }) then
					DecrementTableValue( GameState.MetaUpgrades, upgradeData.Name )
					ApplyMetaUpgrade( upgradeData, true, GameState.MetaUpgrades[upgradeData.Name] <= 0, true )
				else
					DecrementTableValue( GameState.MetaUpgradeState, upgradeData.Name )
				end
				if refund ~= nil then
					totalRefund = totalRefund + refund
				end
			end
		end
	end
	AddResource( "MetaPoints", totalRefund, "MetaPointCapRefund", { Silent = true, ApplyMultiplier = false, NoLifetimeEffect = true, } )
	MetaPointCapRefundPresentation( totalRefund )
	UnfreezePlayerUnit()
end

function GetNumLockedMetaUpgrades()
	return MetaUpgradeLockOrder.BaseUnlocked + GameState.MetaUpgradeStagesUnlocked * MetaUpgradeLockOrder.LockedSetsCount
end

function UnlockNextMetaUpgradePanel( screen, button )
	if not HasResource("LockKeys", button.Cost ) then
		CannotUnlockMetaUpgradesPresentation( screen, button )
		return
	end
	UnlockedMetaUpgradesPresentation( screen, button )
	SpendResource( "LockKeys", button.Cost, "UnlockMetaUpgradePanel" )

	local components = screen.Components
	for i = 1, MetaUpgradeLockOrder.LockedSetsCount do
		local index = GetNumLockedMetaUpgrades() + i
		local name = MetaUpgradeOrder[index][1]
		local itemLocationY = button.OffsetY + ( i - 1 ) * LevelUpUI.MetaUpgradeSpacer
		local itemLocationX = ScreenCenterX - 40
		local itemBackingKey = "Backing"..index
		local graphicKey = "Graphic"..index


		components[itemBackingKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX, Y = itemLocationY, Group = "Combat_Menu" })

		components[graphicKey] = CreateScreenComponent({ Name = "BlankObstacle", X = itemLocationX, Y = itemLocationY, Scale = 0.7, Group = "Combat_Menu" })
		Attach({ Id = components[graphicKey].Id, DestinationId = components[itemBackingKey].Id, OffsetX = -265 - 30, OffsetY = -30 })

		CreateMetaUpgradeEntry( { Screen = screen, Components = components, Data = MetaUpgradeData[name], Index = index, OffsetY = itemLocationY, Swap = GameState.Flags.SwapMetaupgradesEnabled } )
	end

	UpdateButtonStates( screen )
	GameState.MetaUpgradeStagesUnlocked  = GameState.MetaUpgradeStagesUnlocked + 1

	Destroy({ Ids = { button.BackingId, button.Id }})

	-- Create next set of panels
	if GameState.MetaUpgradeStagesUnlocked < TableLength(MetaUpgradeLockOrder.LockedSetCosts) then
		local nextIndex = GameState.MetaUpgradeStagesUnlocked
		local panelOffsetY = 400 + LevelUpUI.MetaUpgradeSpacer * MetaUpgradeLockOrder.BaseUnlocked + nextIndex * LevelUpUI.MetaUpgradeSpacer * 2

		if components["LockBacking"..nextIndex] then
			Destroy({Id = components["LockBacking"..nextIndex].Id })
		end
		components["LockBacking"..nextIndex] = CreateScreenComponent({ Name = "BlankObstacle", X = ScreenCenterX, Y = panelOffsetY, Group = "Combat_Menu" })
		SetAnimation({ DestinationId = components["LockBacking"..nextIndex].Id, Name = "LevelUpMirrorCoverPanel" })

		local lockCost = MetaUpgradeLockOrder.LockedSetCosts[ nextIndex + 1 ]
		components.UnlockNextPanelButton = CreateScreenComponent({ Name = "ButtonMetaUpgradeUnlockPanel", Scale = 0.5, Group = "Combat_Menu" })
		Attach({ Id = components.UnlockNextPanelButton.Id, DestinationId = components["LockBacking"..nextIndex].Id, OffsetX = 0, OffsetY = 0 })
		components.UnlockNextPanelButton.OnPressedFunctionName = "UnlockNextMetaUpgradePanel"
		components.UnlockNextPanelButton.Cost = lockCost
		components.UnlockNextPanelButton.BackingId = components["LockBacking"..nextIndex].Id
		components.UnlockNextPanelButton.OffsetY = button.OffsetY + LevelUpUI.MetaUpgradeSpacer * 2
		local color = Color.White
		if not HasResource("LockKeys", lockCost) then
			color = Color.CostUnaffordable
		end
		CreateTextBox({ Id = components.UnlockNextPanelButton.Id, Text = "MetaUpgrade_Locked_Keys", Font = "AlegreyaSansSCBold", FontSize = 26, Color = color, OffsetX = 0, OffsetY = 0, LuaKey = "TempTextData", LuaValue = { Amount = lockCost }})

		SetInteractProperty({ DestinationId = components.UnlockNextPanelButton.Id, Property = "TooltipOffsetX", Value = 350 })
		CreateTextBox({ Id = components.UnlockNextPanelButton.Id, Text = "MetaUpgradeUnlockHint",
			FontSize = 1,
			OffsetX = 0, OffsetY = 0,
			Font = "AlegreyaSansSCExtraBold",
			Justification = "LEFT",
			Color = Color.Transparent,

			LuaKey = "TempTextData",
			LuaValue =
			{
				Amount = lockCost
			}
		})

		-- update refund button state
		if components.RefundButton ~= nil then
			local refundColor = Color.White
			if not HasResource("LockKeys", 1) then
				refundColor = Color.CostUnaffordable
			end
			ModifyTextBox({ Id = components.RefundButton.Id, ColorTarget = refundColor, ColorDuration = 0.2 })
		end
	end
end