ScreenData.SeedControl =
{
	ItemStartX = 1400,
	ItemStartY = 560,
	ItemSpacing = 100,
	EntryYSpacer = 50,
	ItemsPerPage = 12,
	ScrollOffset = 0,
	Digits = { 1, 2, 3, 4, 5, 6 },
}

function UseSeedController( usee, args )
	PlayInteractAnimation( usee.ObjectId )
	UseableOff({ Id = usee.ObjectId })
	StopStatusAnimation( usee )
	local screen = OpenSeedControlScreen()
	UseableOn({ Id = usee.ObjectId })
end

function OpenSeedControlScreen( args )

	local screen = DeepCopyTable( ScreenData.SeedControl )
	screen.Components = {}
	local components = screen.Components
	screen.CloseAnimation = "QuestLogBackground_Out"

	OnScreenOpened({ Flag = screen.Name, PersistCombatUI = true })
	FreezePlayerUnit()
	EnableShopGamepadCursor()
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 8 })
	SetConfigOption({ Name = "FreeFormSelectSuccessDistanceStep", Value = 8 })

	components.ShopBackgroundDim = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })
	components.ShopBackgroundSplatter = CreateScreenComponent({ Name = "LevelUpBackground", Group = "Combat_Menu" })
	components.ShopBackground = CreateScreenComponent({ Name = "rectangle01", Group = "Combat_Menu" })

	SetAnimation({ DestinationId = components.ShopBackground.Id, Name = "QuestLogBackground_In", OffsetY = 30 })

	SetScale({ Id = components.ShopBackgroundDim.Id, Fraction = 4 })
	SetColor({ Id = components.ShopBackgroundDim.Id, Color = {0.090, 0.055, 0.157, 0.8} })

	PlaySound({ Name = "/SFX/Menu Sounds/FatedListOpen" })

	wait(0.2)

	-- Title
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "QuestLogScreen_Title", FontSize = 34, OffsetX = 0, OffsetY = -460, Color = Color.White, Font = "SpectralSCLightTitling", ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2}, Justification = "Center" })
	CreateTextBox({ Id = components.ShopBackground.Id, Text = "QuestLogScreen_Flavor", FontSize = 15, OffsetX = 0, OffsetY = -410, Width = 840, Color = {120, 120, 120, 255}, Font = "CrimsonTextItalic", ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2}, Justification = "Center" })

	-- Description Box
	--components.DescriptionBox = CreateScreenComponent({ Name = "BlankObstacle", X = 815, Y = 290, Group = "Combat_Menu" })

	local itemLocationX = screen.ItemStartX
	local itemLocationY = screen.ItemStartY

	SeedControlScreenSyncDigits( screen )

	for digit, digitValue in ipairs( screen.Digits ) do
		components["DigitUp"..digit] = CreateScreenComponent({ Name = "ButtonCodexUp", X = itemLocationX, Y = itemLocationY - 100, Scale = 1.0, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
		components["DigitUp"..digit].OnPressedFunctionName = "SeedDigitUp"
		components["DigitUp"..digit].ControlHotkey = "MenuLeft"
		components["DigitUp"..digit].Digit = digit

		local digitKey = "DigitButton"..digit
		components[digitKey] = CreateScreenComponent({ Name = "ButtonQuestLogEntry", Scale = 1, X = itemLocationX, Y = itemLocationY, Group = "Combat_Menu" })
		components[digitKey].Digit = digit
		AttachLua({ Id = components[digitKey].Id, Table = components[digitKey] })

		CreateTextBox({ Id = components[digitKey].Id,
			Text = digitValue,
			Color = {245, 200, 47, 255},
			FontSize = 48,
			OffsetX = 0, OffsetY = 0,
			Font = "AlegreyaSansSCBold",
			OutlineThickness = 0,
			OutlineColor = {255, 205, 52, 255},
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
			Justification = "Center",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
			})

		components["DigitDown"..digit] = CreateScreenComponent({ Name = "ButtonCodexDown", X = itemLocationX, Y = itemLocationY + 100, Scale = 1.0, Sound = "/SFX/Menu Sounds/GeneralWhooshMENU", Group = "Combat_Menu" })
		components["DigitDown"..digit].OnPressedFunctionName = "SeedDigitDown"
		components["DigitDown"..digit].ControlHotkey = "MenuRight"
		components["DigitDown"..digit].Digit = digit

		itemLocationX = itemLocationX - screen.ItemSpacing
	end

	UpdateDigitDisplay( screen )

	-- Randomize button
	components.RandomizeButton = CreateScreenComponent({ Name = "ButtonDefault", Scale = 1.0, Group = "Combat_Menu", X = 550, Y = 470 })
	components.RandomizeButton.OnPressedFunctionName = "SeedControlScreenRandomize"
	CreateTextBox({ Id = components.RandomizeButton.Id,
			Text = "SeedControlScreen_Randomize",
			OffsetX = 0, OffsetY = 0,
			FontSize = 22,
			Color = Color.White,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Center",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		})

	-- Lock button
	components.LockButton = CreateScreenComponent({ Name = "ButtonDefault", Scale = 1.0, Group = "Combat_Menu", X = 550, Y = 665 })
	components.LockButton.OnPressedFunctionName = "SeedControlScreenLock"
	CreateTextBox({ Id = components.LockButton.Id,
			OffsetX = 0, OffsetY = 0,
			FontSize = 22,
			Color = Color.White,
			Font = "AlegreyaSansSCRegular",
			ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
			Justification = "Center",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		})

	UpdateLockDisplay( screen )

	-- Close button
	components.CloseButton = CreateScreenComponent({ Name = "ButtonClose", Scale = 0.7, Group = "Combat_Menu" })
	Attach({ Id = components.CloseButton.Id, DestinationId = components.ShopBackground.Id, OffsetX = -6, OffsetY = 456 })
	components.CloseButton.OnPressedFunctionName = "CloseSeedControlScreen"
	components.CloseButton.ControlHotkey = "Cancel"

	wait(0.1)
	--TeleportCursor({ OffsetX = screen.ItemStartX - 30, OffsetY = screen.ItemStartY, ForceUseCheck = true })

	screen.KeepOpen = true
	thread( HandleWASDInput, screen )
	HandleScreenInput( screen )

end

function SeedDigitUp( screen, button )
	local newDigitValue = screen.Digits[button.Digit]
	newDigitValue = newDigitValue - 1
	if newDigitValue < 0 then
		newDigitValue = 9
	end
	screen.Digits[button.Digit] = newDigitValue
	local newSeed = 0
	for digit, digitValue in ipairs( screen.Digits ) do
		newSeed = newSeed + (digitValue * math.pow(10, digit - 1))
	end
	GameState.RunSeed = newSeed
	UpdateDigitDisplay( screen )
end

function SeedDigitDown( screen, button )
	local newDigitValue = screen.Digits[button.Digit]
	newDigitValue = newDigitValue + 1
	if newDigitValue > 9 then
		newDigitValue = 0
	end
	screen.Digits[button.Digit] = newDigitValue
	local newSeed = 0
	for digit, digitValue in ipairs( screen.Digits ) do
		newSeed = newSeed + (digitValue * math.pow(10, digit - 1))
	end
	GameState.RunSeed = newSeed
	UpdateDigitDisplay( screen )
end

function SeedControlScreenSyncDigits( screen )
	local displayNumber = GameState.RunSeed
	for digit = 1, #screen.Digits do
		local digitValue = displayNumber % 10
		screen.Digits[digit] = digitValue
		displayNumber = math.floor( displayNumber / 10 )
	end
end

function UpdateDigitDisplay( screen )
	--[[
	local displayNumber = GameState.RunSeed
	for digit = 1, screen.NumDigits do
		local digitKey = "DigitButton"..digit
		local digitValue = displayNumber % 10
		ModifyTextBox({ Id = screen.Components["DigitButton"..digit].Id, Text = digitValue })
		displayNumber = math.floor( displayNumber / 10 )
	end
	--]]
	for digit, digitValue in ipairs( screen.Digits ) do
		local digitKey = "DigitButton"..digit
		ModifyTextBox({ Id = screen.Components["DigitButton"..digit].Id, Text = digitValue })
	end
end

function UpdateLockDisplay( screen )
	if GameState.Flags.SeedLocked then
		ModifyTextBox({ Id = screen.Components.LockButton.Id, Text = "SeedControlScreen_Locked" })
	else
		ModifyTextBox({ Id = screen.Components.LockButton.Id, Text = "SeedControlScreen_Unlocked" })
	end
end

function SeedControlScreenRandomize( screen, button )
	GameState.RunSeed = RandomInt(0, 999999)
	SeedControlScreenSyncDigits( screen )
	UpdateDigitDisplay( screen )
end

function SeedControlScreenLock( screen, button )
	GameState.Flags.SeedLocked = not GameState.Flags.SeedLocked
	UpdateLockDisplay( screen )
end

function CloseSeedControlScreen( screen, button )

	DisableShopGamepadCursor()
	SetConfigOption({ Name = "FreeFormSelectWrapY", Value = false })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16 })
	SetConfigOption({ Name = "FreeFormSelectSuccessDistanceStep", Value = 8 })
	SetAnimation({ DestinationId = screen.Components.ShopBackground.Id, Name = screen.CloseAnimation })
	PlaySound({ Name = "/SFX/Menu Sounds/FatedListClose" })
	CloseScreen( GetAllIds( screen.Components ), 0.1 )
	UnfreezePlayerUnit()
	screen.KeepOpen = false
	OnScreenClosed({ Flag = screen.Name })

end
