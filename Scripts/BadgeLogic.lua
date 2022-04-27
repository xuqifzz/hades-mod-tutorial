function UseBadgeSeller( usee, args )

	if not TextLinesRecord.BadgeSellerInfo01 then
		return
	end
	
	local nextRank = (GameState.BadgeRank or 0) + 1
	local nextBadgeData = GameData.BadgeData[GameData.BadgeOrderData[nextRank]]
	if nextBadgeData == nil then
		-- Maxed out
		return
	end

	if nextBadgeData.ResourceCost ~= nil then
		local hasAllResources = true
		for k, resourceCost in pairs( nextBadgeData.ResourceCost ) do
			if not HasResource( resourceCost.Name, resourceCost.Amount ) then
				hasAllResources = false
				break
			end
		end

		if not hasAllResources then
			BadgeCannotAffordPresentation( usee, nextBadgeData )
			return
		end
		
		AddInputBlock({ Name = "BadgeResourceSpend" })
		for k, resourceCost in pairs( nextBadgeData.ResourceCost ) do
			SpendResource( resourceCost.Name, resourceCost.Amount )
			BadgeResourceSpendPresentation( usee, resourceCost )
		end
		RemoveInputBlock({ Name = "BadgeResourceSpend" })
	end

	GameState.BadgeRank = nextRank
	CurrentRun.BadgePurchased = true
	
	BadgePurchasePresentation( usee, nextBadgeData )
	UseableOff({ Id = usee.ObjectId })

end
