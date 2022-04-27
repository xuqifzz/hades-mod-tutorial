Import "CreditsData.lua"

function StartCredits( args )
	ScreenAnchors.Credits = {}
	local scrollDistance = 1080 + 3000
	local scrollSpeed = scrollDistance / 75
	local scroll = false

	local roomCredits = CreditsData[CurrentRun.CurrentRoom.Name] or {}
	DebugPrint({ Text=CurrentRun.CurrentRoom.Name })

	if args ~= nil then
		roomCredits = CreditsData[args] 
	end
	local creditLineBuffer = 0
	
	for index, creditsData in ipairs(roomCredits) do

		if creditsData.CreditLineBuffer then
			creditLineBuffer = creditLineBuffer + creditsData.CreditLineBuffer
		end

		if creditsData.ScrollOn then
			scroll = true
			if creditsData.ScrollSpeedOverride then
				scrollSpeed = creditsData.ScrollSpeedOverride
			end
			if creditsData.ScrollDistanceOverride then
				scrollDistance = creditsData.ScrollDistanceOverride
			end
			for k, creditId in pairs(ScreenAnchors.Credits) do
				Move({ Id = creditId, Angle = 90, Distance = scrollDistance, Duration = scrollSpeed })
			end		
		end
		if creditsData.ScrollOff then
			scroll = false
		end

		wait(creditsData.PreWait)

		if creditsData.CreateScreenObstacle ~= nil then
			creditsData.Id = CreateScreenObstacle({ Name = creditsData.CreateScreenObstacle, Group = "Combat_UI", X = creditsData.X, Y = creditsData.Y })
			if not creditsData.SkipScreenAnchors then
				table.insert(ScreenAnchors.Credits, creditsData.Id)
			end
		end

		if creditsData.Text ~= nil then
			--DebugPrint({ Text=creditsData.Text })
			local offsetY = 0
			local offsetX = 0
			if creditsData.Y then
				offsetY = creditsData.Y
			elseif creditLineBuffer > 0 then
				offsetY = creditLineBuffer
				--DebugPrint({ Text = "Using Buffer" })
			else
				offsetY = ScreenHeight
			end
			if creditsData.X then
				offsetX = creditsData.X
			else
				offsetX = ScreenCenterX - 530
			end
			--DebugPrint({ Text = creditsData.Text..tostring(offsetY) })
			creditsData.Id = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", X = offsetX, Y = offsetY })
			table.insert(ScreenAnchors.Credits, creditsData.Id)
			local textBoxData = MergeTables(creditsData, creditsData.Format)
			CreateTextBox(textBoxData)

			if scroll then
				Move({ Id = creditsData.Id, Angle = 90, Distance = ScreenHeight + scrollDistance, Duration = scrollSpeed })
			end
		end
		
		wait(creditsData.PostWait)

		if creditsData.ClearScreen then
			for k, textBoxId in pairs(ScreenAnchors.Credits) do
				DestroyTextBox({ Id = textBoxId })
				ScreenAnchors.Credits[k] = nil
			end
			creditLineBuffer = 0
		end
	end
end