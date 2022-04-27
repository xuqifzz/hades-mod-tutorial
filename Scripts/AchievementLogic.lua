SessionAchivementUnlocks = {}

function CheckProgressAchievements( args )

	if GameState == nil then
		return
	end

	args = args or {}
	
	local threadName = "CheckAchievementStatus"
	if not args.Silent then
		if SetThreadWait( threadName, 0.3 ) then
			return
		end
		wait( 0.3, threadName )
	end

	for achievementName, achievementData in pairs( GameData.AchievementData ) do
		if not achievementData.DebugOnly and not SessionAchivementUnlocks[achievementName] then
			--DebugPrint({ Text="CHECK ACHIEVEMENT: "..achievementName })
			if achievementData.CompleteGameStateRequirements ~= nil and IsGameStateEligible( CurrentRun, achievementData, achievementData.CompleteGameStateRequirements ) then
				-- Completed
				UnlockAchievement({ Name = achievementName })
				--DebugPrint({ Text="ACHIEVEMENT UNLOCKED: "..achievementName })
				SessionAchivementUnlocks[achievementName] = true
				wait( 0.5, threadName )
			else
				wait( 0.02, threadName ) -- Distribute workload over frames
			end
		end
	end
end

function CheckAchievement( args )
	local achievementData = GameData.AchievementData[args.Name]
	if achievementData == nil then
		return
	end
	if SessionAchivementUnlocks[args.Name] then
		return
	end
	
	if args.CurrentValue ~= nil and achievementData.GoalValue ~= nil then
		if args.CurrentValue >= achievementData.GoalValue then
			UnlockAchievement({ Name = args.Name })
			--DebugPrint({ Text="ACHIEVEMENT UNLOCKED: "..args.Name })
			SessionAchivementUnlocks[args.Name] = true
		end
		return
	end

	local achievementData = GameData.AchievementData[args.Name]
	if achievementData.CompleteGameStateRequirements == nil or IsGameStateEligible( CurrentRun, achievementData, achievementData.CompleteGameStateRequirements ) then
		UnlockAchievement({ Name = args.Name })
		--DebugPrint({ Text="ACHIEVEMENT UNLOCKED: "..args.Name })
		SessionAchivementUnlocks[args.Name] = true
	end
end