AIThreadName = "AIThread"

function AggressiveAI( enemy, currentRun )

	local attackDistance = 250
	local bufferDistance = 50

	while IsAIActive( enemy, currentRun ) do

		-- Move to player
		Move({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId, Mode = "Precise" })

		-- Wait until within attack range
		enemy.AINotifyName = "WithinDistance"..enemy.ObjectId

		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId, Distance = attackDistance, Notify = enemy.AINotifyName, Timeout = 5.0 })
		waitUntil( enemy.AINotifyName )

		-- Prepare to attack
		Stop({ Id = enemy.ObjectId })
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId })
		wait( CalcEnemyWait( enemy, 0.5), enemy.AIThreadName )

		local distanceToPlayer = GetDistance({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId })
		if distanceToPlayer < attackDistance + bufferDistance then
			-- Player still in range, fire weapon
			FireWeaponFromUnit({ Weapon = enemy.WeaponName, Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId })
			-- Post-attack recover window
			wait( CalcEnemyWait( enemy, 1.0), enemy.AIThreadName )
		else
			-- Player moved out of range while preparing to attack, start over
		end

	end

end

function FollowAI( enemy, currentRun )
	local followDistance = 300
	local bufferDistance = 50
	while IsAIActive( enemy, currentRun ) do

		-- Move to player
		Move({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId, Mode = "Precise" })

		-- Wait until within attack range
		enemy.AINotifyName = "WithinDistance"..enemy.ObjectId
		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId, Distance = followDistance, Notify = enemy.AINotifyName, Timeout = 5.0 })
		waitUntil( enemy.AINotifyName )

		Stop({ Id = enemy.ObjectId })

		enemy.AINotifyName = "OutsideDistance"..enemy.ObjectId
		NotifyOutsideDistance({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId, Distance = followDistance + bufferDistance, Notify = enemy.AINotifyName })
		waitUntil( enemy.AINotifyName )

	end
end

function TrainingAI( enemy, currentRun )

end

function AttackOnlyGroups( enemy, currentRun )
	if enemy.IdleAnimation ~= nil then
		SetAnimation({ Name = enemy.IdleAnimation, DestinationId = enemy.ObjectId })
	end

	local aiData = enemy.DefaultAIData or enemy
	local searchId = enemy.ObjectId
	local searchOffsetId = nil
	if aiData.SearchDistanceOffset ~= nil then
		local offset = CalcOffset( math.rad( GetAngle({ Id = enemy.ObjectId }) ), aiData.SearchDistanceOffset )
		searchOffsetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })
		searchId = searchOffsetId
	end

	while IsAIActive( enemy, currentRun ) do
		-- Wait for target to come within range, no timeout
		enemy.AINotifyName = "WithinDistance"..enemy.ObjectId
		NotifyWithinDistanceAny({ Ids = { searchId }, DestinationNames = enemy.TargetGroups, Distance = aiData.AIAttackDistance, ScaleY = aiData.AttackDistanceScaleY or 0.5, Notify = enemy.AINotifyName, UseLocationZ = true })
		waitUntil( enemy.AINotifyName )
		local nearbyTargetId = NotifyResultsTable[enemy.AINotifyName]

		if aiData.GroupTrigger then
			local enemyIds = GetIdsByType({ Name = enemy.Name })
			for k, enemyId in pairs(enemyIds) do
				if ActiveEnemies[enemyId] ~= nil then
					notifyExistingWaiters(ActiveEnemies[enemyId].AINotifyName)
				end
			end
		end

		-- If disabled while waiting
		if not IsAIActive( enemy, currentRun ) then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DisabledAnimation })
			break
		end

		-- Prepare to attack
		if aiData.PreAttackAnimation ~= nil then
			SetAnimation({ Name = aiData.PreAttackAnimation, DestinationId = enemy.ObjectId })
		end
		if enemy.AttackWarningAnimation ~= nil then
			CreateAnimation({ Name = aiData.AttackWarningAnimation, DestinationId = enemy.ObjectId, ScaleRadius = aiData.AttackWarningAnimationRadius })
		end
		Shake({ Id = enemy.ObjectId, Speed = 350, Distance = 2, Duration = aiData.PreAttackDuration })
		if enemy.PreAttackFlash ~= nil and aiData.PreAttackDuration ~= nil then
			Flash({ Id = enemy.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = aiData.PreAttackDuration, ExpireAfterCycle = true })
		end
		if enemy.PreAttackColor ~= nil then
			SetColor({ Color = enemy.PreAttackColor, Id = enemy.ObjectId, Duration = aiData.PreAttackDuration / 3 })
		end
		if aiData.PreAttackSound ~= nil then
			PlaySound({ Name = aiData.PreAttackSound, Id = enemy.ObjectId })
		end
		if aiData.PreAttackFx ~= nil then
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackFx })
		end
		wait( CalcEnemyWait( enemy, aiData.PreAttackDuration), enemy.AIThreadName )

		if aiData.AttackWarningAnimation ~= nil then
			StopAnimation({ Name = aiData.AttackWarningAnimation, DestinationId = enemy.ObjectId })
		end

		if not IsAIActive( enemy, currentRun ) then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DisabledAnimation })
			break
		end

		-- Attack
		FireWeaponFromUnit({ Weapon = enemy.WeaponName, Id = enemy.ObjectId, DestinationId = nearbyTargetId })
		if enemy.FireAnimation ~= nil then
			SetAnimation({ Name = enemy.FireAnimation, DestinationId = enemy.ObjectId })
		end
		wait( CalcEnemyWait( enemy, aiData.FireDuration ), enemy.AIThreadName )

		if not IsAIActive( enemy, currentRun ) then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DisabledAnimation })
			break
		end

		-- Post-attack recover window
		if aiData.PreAttackColor ~= nil then
			Flash({ Id = enemy.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = aiData.PostAttackCooldown })
		end
		if aiData.ReloadingLoopSound ~= nil then
			enemy.ReloadSoundId = PlaySound({ Name = aiData.ReloadingLoopSound, Id = enemy.ObjectId })
		end
		if aiData.PostAttackAnimation ~= nil then
			SetAnimation({ Name = aiData.PostAttackAnimation, DestinationId = enemy.ObjectId })
		end
		wait( CalcEnemyWait( enemy, aiData.PostAttackCooldown ), enemy.AIThreadName )
		SetColor({ Color = enemy.White, Id = enemy.ObjectId })
		StopSound({ Id = enemy.ReloadSoundId, Duration = 0.2 })

		if aiData.AIResetDistance ~= nil then
			-- Wait until target leaves before resetting
			enemy.AINotifyName = "OutsideDistance"..enemy.ObjectId
			NotifyOutsideDistance({ Id = searchId, DestinationId = nearbyTargetId, Distance = aiData.AIResetDistance, Notify = enemy.AINotifyName })
			waitUntil( enemy.AINotifyName )

			if not IsAIActive( enemy, currentRun ) then
				break
			end

			if aiData.IdleAnimation ~= nil then
				SetAnimation({ Name = aiData.IdleAnimation, DestinationId = enemy.ObjectId })
			end
			if aiData.ReloadedSound ~= nil then
				PlaySound({ Name = aiData.ReloadedSound, Id = enemy.ObjectId })
			end
		end

		if aiData.KillAfterAttack then
			Kill(enemy)
		end
	end

	if searchOffsetId ~= nil then
		Destroy({ Id = searchOffsetId })
	end

end

function FireAndQuit( enemy, currentRun )
	FireWeaponFromUnit({ Weapon = enemy.WeaponName, Id = enemy.ObjectId })
end

function GroupCollisionRetaliate( enemies, currentRun )

	wait( CalcEnemyWait( enemy, 0.1 ), RoomThreadName )

	while not IsEmpty( enemies ) do

		local enemy = enemies[1]
		local enemyIds = {}
		for k, enemy in pairs( enemies ) do
			table.insert( enemyIds, enemy.ObjectId )
		end
		local aiData = enemy.DefaultAIData or enemy

		-- Wait for player to come within range, no timeout
		enemy.AINotifyName = "CollisionWith"..enemy.ObjectId

		NotifyOnCollide({ Ids = enemyIds, DestinationNames = enemy.TargetGroups, PointOnly = aiData.PointOnlyCollision, Notify = enemy.AINotifyName })
		waitUntil( enemy.AINotifyName )
		local colliderId = NotifyResultsTable[enemy.AINotifyName]

		local velocity = GetVelocity({ Id = colliderId })
		if enemy.RequiredVictimVelocity ~= nil and velocity < enemy.RequiredVictimVelocity then
			wait( CalcEnemyWait( enemy, 0.1), enemy.AIThreadName )
		else
			-- Prepare to attack
			if enemy.PreAttackAnimation ~= nil then
				SetAnimation({ Name = enemy.PreAttackAnimation, DestinationId = enemy.ObjectId })
			end
			if enemy.AttackWarningAnimation ~= nil then
				CreateAnimation({ Name = enemy.AttackWarningAnimation, DestinationId = enemy.ObjectId, ScaleRadius = enemy.AttackWarningAnimationRadius })
			end
			Shake({ Id = enemy.ObjectId, Speed = 350, Distance = 2, Duration = enemy.PreAttackDuration })
			if enemy.PreAttackColor ~= nil then
				SetColor({ Color = enemy.PreAttackColor, Id = enemy.ObjectId, Duration = enemy.PreAttackDuration / 3 })
			end
			if enemy.PreAttackSound ~= nil then
				PlaySound({ Name = enemy.PreAttackSound, Id = enemy.ObjectId })
			end
			wait( CalcEnemyWait( enemy, enemy.PreAttackDuration), enemy.AIThreadName )

			if enemy.AttackWarningAnimation ~= nil then
				StopAnimation({ Name = enemy.AttackWarningAnimation, DestinationId = enemy.ObjectId })
			end

			-- Attack
			FireWeaponFromUnit({ Weapon = enemy.WeaponName, Id = enemy.ObjectId, DestinationId = colliderId })

			-- Post-attack recover window
			if enemy.PreAttackColor ~= nil then
				Flash({ Id = enemy.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = enemy.PostAttackCooldown })
			end
			if enemy.ReloadingLoopSound ~= nil then
				enemy.ReloadSoundId = PlaySound({ Name = enemy.ReloadingLoopSound, Id = enemy.ObjectId })
			end
			if enemy.PostAttackAnimation ~= nil then
				SetAnimation({ Name = enemy.PostAttackAnimation, DestinationId = enemy.ObjectId })
			end
			wait( CalcEnemyWait( enemy, enemy.PostAttackCooldown), enemy.AIThreadName )
			SetColor({ Color = enemy.White, Id = enemy.ObjectId })
			StopSound({ Id = enemy.ReloadSoundId, Duration = 0.2 })

			if enemy.AIResetDistance ~= nil then
				DebugPrint({ Text = "WAIT" })
				-- Wait until target leaves before resetting
				enemy.AINotifyName = "OutsideDistance"..enemy.ObjectId

				NotifyOutsideDistance({ Id = enemy.ObjectId, DestinationId = nearbyTargetId, Distance = enemy.AIResetDistance, Notify = enemy.AINotifyName })
				waitUntil( enemy.AINotifyName )

				if enemy.IdleAnimation ~= nil then
					SetAnimation({ Name = enemy.IdleAnimation, DestinationId = enemy.ObjectId })
				end
				if enemy.ReloadedSound ~= nil then
					PlaySound({ Name = enemy.ReloadedSound, Id = enemy.ObjectId })
				end
			end
		end

	end


end

function CollisionRetaliate( enemy, currentRun )
	if enemy.IdleAnimation ~= nil then
		SetAnimation({ Name = enemy.IdleAnimation, DestinationId = enemy.ObjectId })
	end

	local aiData = enemy.DefaultAIData or enemy

	while IsAIActive( enemy, currentRun ) do

		-- Wait for player to come within range, no timeout
		enemy.AINotifyName = "CollisionWith"..enemy.ObjectId

		NotifyOnCollide({ Id = enemy.ObjectId, DestinationNames = enemy.TargetGroups, PointOnly = aiData.PointOnlyCollision, Notify = enemy.AINotifyName })
		waitUntil( enemy.AINotifyName )
		local colliderId = NotifyResultsTable[enemy.AINotifyName]

		local velocity = GetVelocity({ Id = colliderId })
		if enemy.RequiredVictimVelocity ~= nil and velocity < enemy.RequiredVictimVelocity then
			wait( CalcEnemyWait( enemy, 0.1), enemy.AIThreadName )
		else
			-- If disabled while waiting
			if not IsAIActive( enemy, currentRun ) then
				if enemy.DisabledAnimation ~= nil then
					SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DisabledAnimation })
				end
				return
			end

			-- Prepare to attack
			if enemy.PreAttackAnimation ~= nil then
				SetAnimation({ Name = enemy.PreAttackAnimation, DestinationId = enemy.ObjectId })
			end
			if enemy.AttackWarningAnimation ~= nil then
				CreateAnimation({ Name = enemy.AttackWarningAnimation, DestinationId = enemy.ObjectId, ScaleRadius = enemy.AttackWarningAnimationRadius })
			end
			Shake({ Id = enemy.ObjectId, Speed = 350, Distance = 2, Duration = enemy.PreAttackDuration })
			if enemy.PreAttackColor ~= nil then
				SetColor({ Color = enemy.PreAttackColor, Id = enemy.ObjectId, Duration = enemy.PreAttackDuration / 3 })
			end
			if enemy.PreAttackSound ~= nil then
				PlaySound({ Name = enemy.PreAttackSound, Id = enemy.ObjectId })
			end
			wait( CalcEnemyWait( enemy, enemy.PreAttackDuration), enemy.AIThreadName )

			if enemy.AttackWarningAnimation ~= nil then
				StopAnimation({ Name = enemy.AttackWarningAnimation, DestinationId = enemy.ObjectId })
			end

			AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = colliderId })

			-- Attack
			FireWeaponFromUnit({ Weapon = enemy.WeaponName, Id = enemy.ObjectId, DestinationId = colliderId })

			-- Post-attack recover window
			if enemy.PreAttackColor ~= nil then
				Flash({ Id = enemy.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = enemy.PostAttackCooldown })
			end
			if enemy.ReloadingLoopSound ~= nil then
				enemy.ReloadSoundId = PlaySound({ Name = enemy.ReloadingLoopSound, Id = enemy.ObjectId })
			end
			if enemy.PostAttackAnimation ~= nil then
				SetAnimation({ Name = enemy.PostAttackAnimation, DestinationId = enemy.ObjectId })
			end
			wait( CalcEnemyWait( enemy, enemy.PostAttackCooldown), enemy.AIThreadName )
			SetColor({ Color = enemy.White, Id = enemy.ObjectId })
			StopSound({ Id = enemy.ReloadSoundId, Duration = 0.2 })

			if enemy.AIResetDistance ~= nil then
				DebugPrint({ Text = "WAIT" })
				-- Wait until target leaves before resetting
				enemy.AINotifyName = "OutsideDistance"..enemy.ObjectId

				NotifyOutsideDistance({ Id = enemy.ObjectId, DestinationId = nearbyTargetId, Distance = enemy.AIResetDistance, Notify = enemy.AINotifyName })
				waitUntil( enemy.AINotifyName )

				if not IsAIActive( enemy, currentRun ) then
					break
				end

				if enemy.IdleAnimation ~= nil then
					SetAnimation({ Name = enemy.IdleAnimation, DestinationId = enemy.ObjectId })
				end
				if enemy.ReloadedSound ~= nil then
					PlaySound({ Name = enemy.ReloadedSound, Id = enemy.ObjectId })
				end
			end
		end

	end


end

function SeekingCollisionRetaliate( enemy, currentRun )

	local attackDistance = 110

	while IsAIActive( enemy, currentRun ) do

		-- Move to player
		Move({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId, Mode = "Precise" })

		-- Wait until within attack range
		enemy.AINotifyName = "WithinDistance"..enemy.ObjectId

		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId, Distance = attackDistance, Notify = enemy.AINotifyName, Timeout = enemy.AIMoveWithinRangeTimeout or 5.0 })
		waitUntil( enemy.AINotifyName )

		-- Prepare to attack
		Stop({ Id = enemy.ObjectId })

		if enemy.PreAttackAnimation ~= nil then
			SetAnimation({ Name = enemy.PreAttackAnimation, DestinationId = enemy.ObjectId })
		end
		Shake({ Id = enemy.ObjectId, Speed = 350, Distance = 2, Duration = enemy.PreAttackDuration })
		if enemy.PreAttackColor ~= nil then
			SetColor({ Color = enemy.PreAttackColor, Id = enemy.ObjectId, Duration = enemy.PreAttackDuration / 3 })
		end
		if enemy.PreAttackSound ~= nil then
			PlaySound({ Name = enemy.PreAttackSound, Id = enemy.ObjectId })
		end
		wait( CalcEnemyWait( enemy, enemy.PreAttackDuration), enemy.AIThreadName )

		-- Attack
		FireWeaponFromUnit({ Weapon = enemy.WeaponName, Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId })

		-- Post-attack recover window
		if enemy.PreAttackColor ~= nil then
			SetColor({ Color = enemy.White, Id = enemy.ObjectId, Duration = enemy.PostAttackCooldown })
		end
		if enemy.ReloadingLoopSound ~= nil then
			enemy.ReloadSoundId = PlaySound({ Name = enemy.ReloadingLoopSound, Id = enemy.ObjectId })
		end
		wait( CalcEnemyWait( enemy, enemy.PostAttackCooldown ), enemy.AIThreadName )
		StopSound({ Id = enemy.ReloadSoundId, Duration = 0.2 })
		if enemy.ReloadedSound ~= nil then
			PlaySound({ Name = enemy.ReloadedSound, Id = enemy.ObjectId })
		end

	end

end

function PassiveAttack( enemy, currentRun )
	local weaponAIData = GetWeaponAIData(enemy)
	if weaponAIData.PreAttackAnimation ~= nil then
		SetAnimation({ Name = weaponAIData.PreAttackAnimation, DestinationId = enemy.ObjectId })
	end
	if enemy.WakeUpDelay ~= nil or (enemy.WakeUpDelayMin ~= nil and enemy.WakeUpDelayMax ~= nil) then
		local wakeUpDelay = enemy.WakeUpDelay or RandomFloat(enemy.WakeUpDelayMin, enemy.WakeUpDelayMax)
		wait( CalcEnemyWait( enemy, wakeUpDelay ), enemy.AIThreadName )
	end

	while IsAIActive( enemy, currentRun ) do
		if weaponAIData.AIResetDistance ~= nil then
			-- Check if target within range
			enemy.AINotifyName = "WithinDistance"..enemy.ObjectId

			NotifyWithinDistanceAny({ Ids = { enemy.ObjectId }, DestinationNames = weaponAIData.TargetGroups, Distance = weaponAIData.AIAttackDistance, ScaleY = 0.5, Notify = enemy.AINotifyName, Timeout = 0.1 })
			waitUntil( enemy.AINotifyName )
			local nearbyTargetId = NotifyResultsTable[enemy.AINotifyName]

			if nearbyTargetId ~= nil and targetId ~= 0 then
				-- Wait until target leaves before resetting
				enemy.AINotifyName = "OutsideDistance"..enemy.ObjectId

				NotifyOutsideDistance({ Id = enemy.ObjectId, DestinationId = nearbyTargetId, Distance = weaponAIData.AIResetDistance, Notify = enemy.AINotifyName })
				waitUntil( enemy.AINotifyName )
				if weaponAIData.IdleAnimation ~= nil then
					SetAnimation({ Name = weaponAIData.IdleAnimation, DestinationId = enemy.ObjectId })
				end
				if weaponAIData.ReloadedSound ~= nil then
					PlaySound({ Name = weaponAIData.ReloadedSound, Id = enemy.ObjectId })
				end
			end
		end

		local preAttackDuration = weaponAIData.PreAttackDuration or 0.5
		if weaponAIData.PreAttackDuration == nil and weaponAIData.PreAttackDurationMin ~= nil and weaponAIData.PreAttackDurationMax ~= nil then
			preAttackDuration = RandomFloat(weaponAIData.PreAttackDurationMin, weaponAIData.PreAttackDurationMax)
		end

		local preAttackEndDuration = weaponAIData.PreAttackEndDuration or math.min(0.5, preAttackDuration)
		local preAttackStartDuration = math.max(preAttackDuration - preAttackEndDuration, 0)

		-- Prepare to attack
		if weaponAIData.PreAttackAnimation ~= nil then
			SetAnimation({ Name = weaponAIData.PreAttackAnimation, DestinationId = weaponAIData.ObjectId })
		end
		if weaponAIData.AttackWarningAnimation ~= nil then
			CreateAnimation({ Name = weaponAIData.AttackWarningAnimation, DestinationId = enemy.ObjectId, ScaleRadius = weaponAIData.AttackWarningAnimationRadius })
		end
		if weaponAIData.PreAttackSound ~= nil then
			PlaySound({ Name = weaponAIData.PreAttackSound, Id = weaponAIData.ObjectId })
		end

		local originalColor = weaponAIData.Color
		if weaponAIData.PreAttackColor ~= nil then
			SetColor({ Color = weaponAIData.PreAttackColor, Id = enemy.ObjectId, Duration = weaponAIData.PreAttackDuration })
		end
		wait( CalcEnemyWait( enemy, preAttackStartDuration), enemy.AIThreadName )

		if weaponAIData.PreAttackEndShake then
			Shake({ Id = enemy.ObjectId, Speed = 400, Distance = 3, Duration = preAttackEndDuration })
			Flash({ Id = enemy.ObjectId, Speed = 1, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = preAttackEndDuration })
		end
		if weaponAIData.PreAttackEndShakeSound ~= nil then
			PlaySound({ Name = weaponAIData.PreAttackEndShakeSound, Id = enemy.ObjectId })
		end

		wait( CalcEnemyWait( enemy, preAttackEndDuration), enemy.AIThreadName )

		local targetId = nil
		if weaponAIData.TargetSelf then
			targetId = enemy.ObjectId
		end
		if weaponAIData.TargetOffsetForward then
			local offset = CalcOffset(math.rad(GetAngle({ Id = enemy.ObjectId })), weaponAIData.TargetOffsetForward)
			targetId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting", DestinationId = targetId, OffsetX = offset.X, OffsetY = offset.Y })
		end

		if weaponAIData.AttackWarningAnimation ~= nil then
			StopAnimation({ Name = weaponAIData.AttackWarningAnimation, DestinationId = enemy.ObjectId })
		end

		if not enemy.DisableAIWhenReady then
			-- Attack
			if weaponAIData.FireAnimation ~= nil then
				SetAnimation({ Name = weaponAIData.FireAnimation, DestinationId = enemy.ObjectId })
			end
			FireWeaponFromUnit({ Weapon = enemy.WeaponName, Id = enemy.ObjectId, DestinationId = targetId })

			-- Post-attack recover window
			if weaponAIData.PreAttackColor ~= nil then
				SetColor({ Color = originalColor, Id = enemy.ObjectId, Duration = weaponAIData.PostAttackCooldown })
			end
			if weaponAIData.PostAttackFlash then
				Flash({ Id = enemy.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = weaponAIData.PostAttackCooldown })
			end
			if weaponAIData.PostAttackAnimation ~= nil then
				SetAnimation({ Name = weaponAIData.PostAttackAnimation, DestinationId = enemy.ObjectId })
			end
			if weaponAIData.ReloadingLoopSound ~= nil then
				enemy.ReloadSoundId = PlaySound({ Name = weaponAIData.ReloadingLoopSound, Id = enemy.ObjectId })
			end

			local postAttackCooldown = weaponAIData.PostAttackCooldown
			if weaponAIData.PostAttackCooldown == nil and weaponAIData.PostAttackCooldownMin ~= nil and weaponAIData.PostAttackCooldownMax ~= nil then
				postAttackCooldown = RandomFloat(weaponAIData.PostAttackCooldownMin, weaponAIData.PostAttackCooldownMax)
			end
			wait( CalcEnemyWait( enemy, postAttackCooldown), enemy.AIThreadName )

			StopSound({ Id = weaponAIData.ReloadSoundId, Duration = 0.2 })
			if weaponAIData.ReloadedSound ~= nil then
				PlaySound({ Name = weaponAIData.ReloadedSound, Id = enemy.ObjectId })
			end

		end

		if weaponAIData.TargetOffsetForward then
			Destroy({ Id = targetId })
		end
	end

end

function RemoteAttack( enemy, currentRun )
	if enemy.IdleAnimation ~= nil then
		SetAnimation({ Name = enemy.IdleAnimation, DestinationId = enemy.ObjectId })
	end

	while IsAIActive( enemy, currentRun ) do
		local weaponAIData = GetWeaponAIData(enemy)

		-- Wait for target to come within range, no timeout
		enemy.AINotifyName = "WithinDistance"..enemy.ObjectId

		NotifyWithinDistanceAny({ Ids = { enemy.ObjectId }, DestinationNames = enemy.TargetGroups, Distance = weaponAIData.AIAttackDistance, ScaleY = 0.5, MaxZ = weaponAIData.MaxVictimZ, Notify = enemy.AINotifyName })
		waitUntil( enemy.AINotifyName )
		local nearbyTargetId = NotifyResultsTable[enemy.AINotifyName]

		local targetId = enemy.ObjectId
		if weaponAIData.RemoteAttackTarget then
			targetId = nearbyTargetId
		end

		-- If disabled while waiting
		if not IsAIActive( enemy, currentRun ) then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.DisabledAnimation })
			return
		end

		local trapChainData = nil
		if currentRun.CurrentRoom.RemoteTrapChains ~= nil then
			trapChainData = currentRun.CurrentRoom.RemoteTrapChains[enemy.ObjectId]
		end

		local linkedEnemyId = nil
		local linkedEnemy = nil
		local linkedEnemyData = EnemyData[enemy.LinkedEnemy]
		if weaponAIData.LinkedEnemy ~= nil then
			linkedEnemyId = GetClosestUnitOfType({ Id = enemy.ObjectId, DestinationName = weaponAIData.LinkedEnemy, Distance = 2000 })
			linkedEnemy = ActiveEnemies[linkedEnemyId]
		end

		if not weaponAIData.SkipAngleTowardTarget then
			if trapChainData ~= nil and trapChainData.Chains ~= nil then
				for k, linkTable in ipairs(trapChainData.Chains) do
					for k, trapId in ipairs(linkTable) do
						AngleTowardTarget({ Id = id, DestinationId = enemy.ObjectId })
					end
				end
			else
				AngleTowardTarget({ Id = linkedEnemyId, DestinationId = enemy.ObjectId })
			end
		end

		-- Prepare to attack
		if weaponAIData.PreAttackAnimation ~= nil then
			SetAnimation({ Name = weaponAIData.PreAttackAnimation, DestinationId = enemy.ObjectId })
		end

		if weaponAIData.PreAttackColor ~= nil then
			SetColor({ Color = enemy.PreAttackColor, Id = enemy.ObjectId, Duration = enemy.PreAttackDuration / 3 })
		end
		if weaponAIData.PreAttackSound ~= nil then
			PlaySound({ Name = enemy.PreAttackSound, Id = enemy.ObjectId })
		end
		wait( CalcEnemyWait( enemy, weaponAIData.PreAttackDuration), enemy.AIThreadName )

		-- Attack
		if trapChainData ~= nil and trapChainData.Chains ~= nil then
			for k, chain in ipairs(trapChainData.Chains) do
				for k, trapId in ipairs(chain) do
					notifyExistingWaiters("WithinDistance"..trapId)
					local chainedEnemy = ActiveEnemies[trapId]
					if chainedEnemy ~= nil then
						local chainedWeaponAIData = ShallowCopyTable(chainedEnemy.DefaultAIData) or chainedEnemy
						if WeaponData[chainedEnemy.WeaponName] ~= nil and WeaponData[chainedEnemy.WeaponName].AIData ~= nil then
							OverwriteTableKeys( chainedWeaponAIData, WeaponData[chainedEnemy.WeaponName].AIData)
						end
						chainedWeaponAIData.WeaponName = chainedEnemy.WeaponName

						thread(AttackOnce, chainedEnemy, currentRun, targetId, chainedWeaponAIData )
					end
				end
				wait( CalcEnemyWait( enemy, trapChainData.ChainInterval), enemy.AIThreadName )
			end
		end

		if linkedEnemy ~= nil then
			local linkedWeaponAIData = ShallowCopyTable(linkedEnemy.DefaultAIData) or linkedEnemy
			if WeaponData[linkedEnemy.WeaponName] ~= nil and WeaponData[linkedEnemy.WeaponName].AIData ~= nil then
				OverwriteTableKeys( linkedWeaponAIData, WeaponData[linkedEnemy.WeaponName].AIData)
			end
			linkedWeaponAIData.WeaponName = linkedEnemy.WeaponName
			thread(AttackOnce, linkedEnemy, currentRun, targetId, linkedWeaponAIData )
		end

		if not IsAIActive( enemy, currentRun ) then
			break
		end

		-- Post-attack recover window
		if weaponAIData.PreAttackColor ~= nil then
			SetColor({ Color = enemy.PreAttackColor, Id = enemy.ObjectId })
			SetColor({ Color = enemy.White, Id = enemy.ObjectId, Duration = enemy.PostAttackCooldown })
		end
		if weaponAIData.PostAttackAnimation ~= nil then
			SetAnimation({ Name = enemy.PostAttackAnimation, DestinationId = enemy.ObjectId })
		end

		if weaponAIData.ReloadingLoopSound ~= nil then
			enemy.ReloadSoundId = PlaySound({ Name = enemy.ReloadingLoopSound, Id = enemy.ObjectId })
		end
		wait( CalcEnemyWait( enemy, weaponAIData.PostAttackCooldown), enemy.AIThreadName )
		StopSound({ Id = weaponAIData.ReloadSoundId, Duration = 0.2 })

		if weaponAIData.AIResetDistance ~= nil then
			-- Wait until target leaves before resetting
			enemy.AINotifyName = "OutsideDistance"..enemy.ObjectId

			NotifyOutsideDistance({ Id = enemy.ObjectId, DestinationId = nearbyTargetId, Distance = weaponAIData.AIResetDistance, Notify = enemy.AINotifyName })
			waitUntil( enemy.AINotifyName )

			if not IsAIActive( enemy, currentRun ) then
				break
			end

			if weaponAIData.IdleAnimation ~= nil then
				SetAnimation({ Name = enemy.IdleAnimation, DestinationId = enemy.ObjectId })
			end
			if weaponAIData.ReloadedSound ~= nil then
				PlaySound({ Name = enemy.ReloadedSound, Id = enemy.ObjectId })
			end
		end
	end
end

function RemoteFire(enemy, remoteEnemyId)
	local fireTicks = 1
	if enemy.AIFireTicksMin ~= nil and enemy.AIFireTicksMax ~= nil then
		fireTicks = RandomInt( enemy.AIFireTicksMin, enemy.AIFireTicksMax )
	end
	for fireTick = 1, fireTicks, 1 do
		FireWeaponFromUnit({ Weapon = enemy.WeaponName, Id = remoteEnemyId, DestinationId = enemy.ObjectId })
		wait( CalcEnemyWait( enemy, enemy.AIFireTicksCooldown), enemy.AIThreadName )
	end
end

function RemoteAttackPassive( enemy, currentRun )

	while IsAIActive( enemy, currentRun ) do

		-- check for brain enemy; disable this if it's destroyed
		local brainEnemyId = nil
		if enemy.BrainEnemy ~= nil then
			brainEnemyId = GetClosestUnitOfType({ Id = enemy.ObjectId, DestinationName = enemy.BrainEnemy, Distance = 1200 })
		end
		if brainEnemyId ~= nil and not IsAlive({ Id = brainEnemyId }) then
			return
		end

		-- find closest linked emitter, angle it toward this
		local linkedEnemyId = nil
		if enemy.LinkedEnemy ~= nil then
			linkedEnemyId = GetClosestUnitOfType({ Id = enemy.ObjectId, DestinationName = enemy.LinkedEnemy, Distance = 500 })
		end
		AngleTowardTarget({ Id = linkedEnemyId, DestinationId = enemy.ObjectId })

		wait( CalcEnemyWait( enemy, enemy.PreAttackDuration), enemy.AIThreadName )

		-- Attack
		for clipShot = 1, enemy.ClipSize, 1 do
			FireWeaponFromUnit({ Weapon = enemy.WeaponName, Id = linkedEnemyId, DestinationId = enemy.ObjectId })
			wait( CalcEnemyWait( enemy, enemy.Cooldown), enemy.AIThreadName )
		end

		-- Post-attack recover window
		if enemy.PreAttackColor ~= nil then
			Flash({ Id = enemy.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = enemy.PostAttackCooldown })
		end
		if enemy.ReloadingLoopSound ~= nil then
			enemy.ReloadSoundId = PlaySound({ Name = enemy.ReloadingLoopSound, Id = enemy.ObjectId })
		end
		wait( CalcEnemyWait( enemy, enemy.PostAttackCooldown), enemy.AIThreadName )
		SetColor({ Color = enemy.White, Id = enemy.ObjectId })
		StopSound({ Id = enemy.ReloadSoundId, Duration = 0.2 })
		if enemy.ReloadedSound ~= nil then
			PlaySound({ Name = enemy.ReloadedSound, Id = enemy.ObjectId })
		end

	end

end

function AttackerAI( enemy, currentRun )

	if enemy.WakeUpDelay ~= nil or (enemy.WakeUpDelayMin ~= nil and enemy.WakeUpDelayMax ~= nil) then
		local wakeUpDelay = enemy.WakeUpDelay or RandomFloat(enemy.WakeUpDelayMin, enemy.WakeUpDelayMax)
		wait( CalcEnemyWait( enemy, wakeUpDelay ), enemy.AIThreadName )
	end

	while IsAIActive( enemy, currentRun ) do
		if enemy.PostCombatAI and currentRun.CurrentRoom.Encounter.InProgress ~= nil and currentRun.CurrentRoom.Encounter.InProgress == false then
			SetAI( enemy.PostCombatAI, enemy, CurrentRun )
			return
		end

		local continue = DoAttackerAILoop( enemy, currentRun )
		if not continue then
			return
		end

	end
end

function DoAttackerAILoop( enemy, currentRun, targetId, weaponAIData )

	if weaponAIData == nil then
		enemy.WeaponName = SelectWeapon( enemy )
		--DebugAssert({ Condition = enemy.WeaponName ~= nil, Text = "Enemy has no weapon!" })
		table.insert(enemy.WeaponHistory, enemy.WeaponName)

		weaponAIData = GetWeaponAIData(enemy)
	end

	if weaponAIData.UseRamAILoop then
		RamAILoop(enemy, currentRun, weaponAIData)
		return true
	end

	if weaponAIData.PartnerForceWeaponInterrupt then
		if enemy.ComboPartnerId ~= nil and ActiveEnemies[enemy.ComboPartnerId] ~= nil and not ActiveEnemies[enemy.ComboPartnerId].IsDead then
			ActiveEnemies[enemy.ComboPartnerId].ForcedWeaponInterrupt = weaponAIData.PartnerForceWeaponInterrupt.."_"..enemy.ComboPartnerName
		end
	end

	if targetId == nil then
		targetId = GetTargetId(enemy, weaponAIData)
	end

	if weaponAIData.TeleportToTargetId ~= nil then
		Teleport({ Id = enemy.ObjectId, DestinationId = targetId })
	end

	-- Pickup Missing Equipment
	if weaponAIData.AIPickupType ~= nil then
		DoPickup( enemy, weaponAIData, currentRun )
	end

	if weaponAIData.ChainedWeapon ~= nil then
		enemy.ChainedWeapon = weaponAIData.ChainedWeapon
	end

	if not CanAttack({ Id = enemy.ObjectId }) then
		if weaponAIData.AttackFailWeapon ~= nil then
			FireWeaponFromUnit({ Weapon = weaponAIData.AttackFailWeapon, Id = enemy.ObjectId, DestinationId = targetId, AutoEquip = true })
			wait( CalcEnemyWait( enemy, 0.1 ), enemy.AIThreadName )
			return true
		end
		enemy.AINotifyName = "CanAttack"..enemy.ObjectId
		NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
		waitUntil( enemy.AINotifyName )
	end

	if targetId ~= nil and targetId ~= 0 then
		-- Pre-Attack Movement
		if weaponAIData.RetreatBeforeAttack then
			Retreat(enemy, weaponAIData, targetId)
			wait( CalcEnemyWait( enemy, 0.05 ), enemy.AIThreadName )
		end

		if weaponAIData.PreMoveFunctionName then
			local preMoveFunction = _G[weaponAIData.PreMoveFunctionName]
			preMoveFunction( enemy, weaponAIData, currentRun, weaponAIData.PreMoveFunctionArgs )
		end

		if weaponAIData.PreMoveVoiceLines ~= nil then
			thread( PlayVoiceLines, weaponAIData.PreMoveVoiceLines, nil, enemy )
		end

		-- Teleportation
		if weaponAIData.TeleportToSpawnPoints then
			HandleEnemyTeleportation(enemy, weaponAIData, currentRun, targetId)
		end

		-- Movement
		local moveToId = weaponAIData.MoveToId or targetId
		if weaponAIData.MoveToRandomSpawnPoint then
			local spawnNearId = targetId
			if weaponAIData.MoveToSpawnPointFromSelf then
				spawnNearId = enemy.ObjectId
			end
			moveToId = SelectSpawnPoint(currentRun.CurrentRoom, { Name = weaponAIData.Name, RequiredSpawnPoint = weaponAIData.MoveToSpawnPointType }, { SpawnNearId = spawnNearId, SpawnRadius = weaponAIData.MoveToSpawnPointDistanceMax, SpawnRadiusMin = weaponAIData.MoveToSpawnPointDistanceMin } )
			--moveToId = GetRandomValue( GetIds({ Name = "SpawnPoints" }) )
		end
		if weaponAIData.MoveToClosestSpawnPoint then
			moveToId = GetClosest({ Id = enemy.ObjectId, DestinationName = "SpawnPoints" })
		end
		if weaponAIData.MoveToRandomLocation then
			MoveToRandomLocation( enemy, enemy.ObjectId, weaponAIData.MoveToRandomLocationRadius, weaponAIData.MoveToRandomLocationRadiusMin, weaponAIData.MoveToRandomLocationTimeout )
		end
		if weaponAIData.MoveToComboPartner then
			if enemy.ComboPartnerId ~= nil then
				moveToId = enemy.ComboPartnerId
			end
		end

		if weaponAIData.OnlyClosestOfTypesMove then
			local closestId = GetClosestUnitOfType({ Id = targetId, DestinationNames = weaponAIData.OnlyClosestOfTypesMove })
			if closestId ~= enemy.ObjectId then
				wait( CalcEnemyWait( enemy, weaponAIData.NotClosestSleepTime ), enemy.AIThreadName )
				return true
			end
		end

		if not weaponAIData.SkipMovement then
			local didTimeout = MoveWithinRange( enemy, moveToId, weaponAIData )

			if weaponAIData.EndPartnerWaitOnMoveEnd and enemy.ComboPartnerId ~= nil then
				if ActiveEnemies[enemy.ComboPartnerId] ~= nil and not ActiveEnemies[enemy.ComboPartnerId].IsDead then
					SetThreadWait( ActiveEnemies[enemy.ComboPartnerId].AIThreadName, 0.0 )
				else
					return true
				end
			end

			if didTimeout and weaponAIData.SkipAttackAfterMoveTimeout then
				return true
			end
		end

		if weaponAIData.RemoveFromGroups then
			for k, groupName in pairs( weaponAIData.RemoveFromGroups ) do
				RemoveFromGroup({ Id = enemy.ObjectId, Name = groupName })
			end
		end

		-- PreAttack Dash
		if weaponAIData.PreAttackDash ~= nil and weaponAIData.PreAttackDashChance ~= nil and RandomChance(weaponAIData.PreAttackDashChance) then
			enemy.WeaponName = weaponAIData.PreAttackDash
			local dashWeaponAIData = GetWeaponAIData(enemy)

			AttackOnce( enemy, CurrentRun, targetId, dashWeaponAIData )
			enemy.WeaponName = weaponAIData.WeaponName
		end

		-- Attack
		local attackSuccess = false
		while not attackSuccess do
			attackSuccess = AttackOnce( enemy, currentRun, targetId, weaponAIData )
			FinishTargetMarker( enemy )
			if weaponAIData.ForcedEarlyExit then
				return true
			end
			if not attackSuccess then
				if weaponAIData.AttackFailWeapon ~= nil then
					FireWeaponFromUnit({ Weapon = weaponAIData.AttackFailWeapon, Id = enemy.ObjectId, DestinationId = targetId, AutoEquip = true })
					wait( CalcEnemyWait( enemy, 0.1 ), enemy.AIThreadName )
					return true
				end
				enemy.AINotifyName = "CanAttack"..enemy.ObjectId
				NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
				waitUntil( enemy.AINotifyName )
			end
		end

		if weaponAIData.PostAttackAI ~= nil then
			local args = { TargetId = targetId }
			local fireFunction = _G[weaponAIData.PostAttackAI]
			fireFunction( enemy, weaponAIData, currentRun, args )
			wait( CalcEnemyWait( enemy, weaponAIData.PostAttackAIWait ), enemy.AIThreadName )
		end

		if enemy.AggroTetherId ~= nil and IsAlive({ Id = enemy.AggroTetherId }) then
			local distance = GetDistance({ Id = targetId, DestinationId = enemy.AggroTetherId })
			local tetherDistance = enemy.AggroTetherDistance or 500
			if distance > tetherDistance then
				enemy.ChainAggroAllEnemies = false
				return SetAI( AggroAI, enemy, CurrentRun )
			end
		end

		if weaponAIData.RemoveFromGroups then
			for k, groupName in pairs( weaponAIData.RemoveFromGroups ) do
				AddToGroup({ Id = enemy.ObjectId, Name = groupName })
			end
		end

		-- Post-Attack Movement
		if weaponAIData.RetreatAfterAttack then
			Retreat(enemy, weaponAIData, targetId)
			wait( CalcEnemyWait( enemy, 0.05 ), enemy.AIThreadName )
		end

		-- Teleportation
		if weaponAIData.PostAttackTeleportToSpawnPoints then
			HandleEnemyTeleportation(enemy, weaponAIData, currentRun, targetId)
		end

		if weaponAIData.CreateOwnTarget then
			Destroy({ Id = targetId })
		end
	else
		if enemy.SelfDestructIfNoAllies and GetRemainingSpawns(currentRun, currentRun.CurrentRoom, currentRun.CurrentRoom.Encounter) <= 0 then
			-- Wait to make sure nothing is mid-spawn
			wait(1.0, enemy.AIThreadName)
			targetId = GetTargetId(enemy, weaponAIData)
			if targetId == nil or targetId == 0 then
				if enemy.SelfDestructWeapon then
					enemy.WeaponName = enemy.SelfDestructWeapon
					table.insert(enemy.WeaponHistory, enemy.WeaponName)

					local weaponAIData = GetWeaponAIData(enemy)

					AttackOnce(enemy, currentRun, enemy.ObjectId, weaponAIData)
				end
				Kill( enemy )
			end
		elseif enemy.NoTargetMoveTowardsPlayer then
			MoveWithinRange( enemy, CurrentRun.Hero.ObjectId, weaponAIData )
		else
			MoveToRandomLocation( enemy, enemy.ObjectId, enemy.NoTargetWanderDistance or 100, enemy.NoTargetWanderDuration )
		end
		wait( CalcEnemyWait( enemy, enemy.NoTargetWanderDuration or 0.5), enemy.AIThreadName )
	end

	return true

end

function HandleEnemyTeleportation( enemy, weaponAIData, currentRun, targetId )
	weaponAIData.TeleportationInterval = weaponAIData.TeleportationInterval or RandomFloat( weaponAIData.TeleportationIntervalMin, weaponAIData.TeleportationIntervalMax )
	enemy.LastTeleportTime = enemy.LastTeleportTime or 0

	if _worldTime - enemy.LastTeleportTime >= weaponAIData.TeleportationInterval then
		local targetPointId = SelectSpawnPoint(currentRun.CurrentRoom, { Name = weaponAIData.Name, RequiredSpawnPoint = weaponAIData.TeleportToSpawnPointType }, { SpawnNearId = targetId or currentRun.Hero.ObjectId, SpawnRadius = weaponAIData.TeleportMaxDistance or 1000, SpawnRadiusMin = weaponAIData.TeleportMinDistance } )
		if targetPointId ~= nil then
			if weaponAIData.StopBeforeTeleport then
				Stop({ Id = enemy.ObjectId })
			end
			if weaponAIData.TeleportPreWaitFx ~= nil then
				CreateAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.TeleportPreWaitFx })
			end
			if weaponAIData.TeleportPreWaitAnimation ~= nil then
				SetAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.TeleportPreWaitAnimation })
			end
			if weaponAIData.AngleTowardsTeleportTarget then
				AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = targetPointId })
			end

			if enemy.OccupyingSpawnPointId ~= nil then
				UnoccupySpawnPoint(enemy.OccupyingSpawnPointId)
			end
			enemy.OccupyingSpawnPointId = targetPointId
			currentRun.CurrentRoom.SpawnPointsUsed[targetPointId] = enemy.ObjectId
			
			wait( CalcEnemyWait( enemy, weaponAIData.PreTeleportWait ), enemy.AIThreadName )

			if weaponAIData.TeleportSound ~= nil then
				PlaySound({ Name = weaponAIData.TeleportSound, Id = enemy.ObjectId })
			end
			if weaponAIData.TeleportStartFx ~= nil then
				CreateAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.TeleportStartFx })
			end
			if weaponAIData.TeleportAnimation ~= nil then
				SetAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.TeleportAnimation })
			end
			Teleport({ Id = enemy.ObjectId, DestinationId = targetPointId })

			if weaponAIData.TeleportEndFx ~= nil then
				CreateAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.TeleportEndFx })
			end

			enemy.LastTeleportTime = _worldTime

			if weaponAIData.TeleportationIntervalMin ~= nil and weaponAIData.TeleportationIntervalMax ~= nil then
				weaponAIData.TeleportationInterval = RandomFloat( weaponAIData.TeleportationIntervalMin, weaponAIData.TeleportationIntervalMax )
			end
			wait( CalcEnemyWait( enemy, weaponAIData.PostTeleportWait ), enemy.AIThreadName )
		end
	end
end

function SelectWeapon( enemy )
	local nextWeapon = nil

	if enemy.ForcedWeaponInterrupt ~= nil then
		enemy.WeaponName = enemy.ForcedWeaponInterrupt
		enemy.ForcedWeaponInterrupt = nil
		return enemy.WeaponName
	end

	if enemy.ChainedWeapon ~= nil then
		enemy.WeaponName = enemy.ChainedWeapon
		enemy.ChainedWeapon = nil
		return enemy.WeaponName
	end

	if enemy.ActiveWeaponCombo ~= nil then
		enemy.ActiveWeaponComboIndex = enemy.ActiveWeaponComboIndex + 1
		local activeWeaponCombo = WeaponData[enemy.ActiveWeaponCombo].WeaponCombo
		if enemy.ActiveWeaponComboIndex <= TableLength(WeaponData[enemy.ActiveWeaponCombo].WeaponCombo) then
			enemy.WeaponName = activeWeaponCombo[enemy.ActiveWeaponComboIndex]
			return enemy.WeaponName
		else
			enemy.ActiveWeaponCombo = nil
		end
	end

	if nextWeapon == nil then
		local eligibleWeaponOptions = {}
		local forcedWeaponOptions = {}

		for k, weaponName in pairs(enemy.WeaponOptions) do
			if IsEnemyWeaponEligible( enemy, weaponName ) then
				if IsEnemyWeaponForced( enemy, weaponName ) then
					table.insert(forcedWeaponOptions, weaponName)
				else
					table.insert(eligibleWeaponOptions, weaponName)
				end
				--DebugPrint({ Text = "Option "..enemy.WeaponName })
			end
		end

		nextWeapon = GetRandomValue(forcedWeaponOptions) or GetRandomValue(eligibleWeaponOptions)
	end

	if nextWeapon == nil then
		if enemy.DisarmedWeapon ~= nil then
			--DebugPrint({ Text = "Equiping disarmed weapon" })
			nextWeapon = enemy.DisarmedWeapon
		end
	end

	if enemy.Enraged and WeaponData[nextWeapon] ~= nil and WeaponData[nextWeapon].AIData ~= nil and WeaponData[nextWeapon].AIData.EnragedWeaponSwap ~= nil then
		nextWeapon = WeaponData[nextWeapon].AIData.EnragedWeaponSwap
	end

	if enemy.GodUpgrade ~= nil and WeaponData[nextWeapon] ~= nil and WeaponData[nextWeapon].GodUpgradeWeaponSwap ~= nil and WeaponData[nextWeapon].GodUpgradeWeaponSwap[enemy.GodUpgrade] ~= nil then
		nextWeapon = WeaponData[nextWeapon].GodUpgradeWeaponSwap[enemy.GodUpgrade]
	end

	if WeaponData[nextWeapon] ~= nil and WeaponData[nextWeapon].SkipToChainedWeaponIfObstacleExists ~= nil and not IsEmpty(GetIdsByType({ Name = WeaponData[nextWeapon].SkipToChainedWeaponIfObstacleExists })) then
		nextWeapon = WeaponData[nextWeapon].AIData.ChainedWeapon
	end

	if WeaponData[nextWeapon] ~= nil and WeaponData[nextWeapon].WeaponCombo ~= nil then
		enemy.ActiveWeaponCombo = nextWeapon
		enemy.ActiveWeaponComboIndex = 0
		if WeaponData[nextWeapon].WeaponComboOnly then
			nextWeapon = SelectWeapon(enemy)
		end
	end

	enemy.WeaponName = nextWeapon or enemy.WeaponName
	--DebugPrint({ Text = "Selected Weapon: "..enemy.WeaponName })
	return enemy.WeaponName
end

function IsEnemyWeaponEligible( enemy, weaponName )
	if WeaponData[weaponName] == nil or WeaponData[weaponName].AIData == nil then
		return true
	end

	local weaponAIData = WeaponData[weaponName].AIData

	if weaponAIData.RequiresNotEnraged and enemy.Enraged then
		return false
	end

	if weaponAIData.BlockAsFirstWeapon and (enemy.WeaponHistory == nil or #enemy.WeaponHistory <= 0) then
		return false
	end

	if weaponAIData.MinAttacksBetweenUse ~= nil then
		local attacksSinceWeapon = NumAttacksSinceWeapon( enemy, weaponName )
		--DebugPrint({ Text = "Attacks Since Use: "..attacksSinceWeapon })
		if attacksSinceWeapon >= 0 and attacksSinceWeapon < weaponAIData.MinAttacksBetweenUse then
			return false
		end
	end

	if weaponAIData.MaxConsecutiveUses ~= nil then
		local consecutiveAttacks = NumConsecutiveUses( enemy, weaponName )
		--DebugPrint({ Text = consecutiveAttacks })
		if consecutiveAttacks >= weaponAIData.MaxConsecutiveUses then
			return false
		end
	end

	if weaponAIData.MaxUses ~= nil and enemy.WeaponHistory ~= nil then
		local numUses = 0
		for i = #enemy.WeaponHistory, 1, -1 do
			local prevWeapon = enemy.WeaponHistory[i]
			if prevWeapon == weaponName then
				numUses = numUses + 1
			end

			if numUses >= weaponAIData.MaxUses then
				return false
			end
		end
	end

	if weaponAIData.MaxPlayerDistance ~= nil then
		local distanceToPlayer = GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		if distanceToPlayer > weaponAIData.MaxPlayerDistance then
			return false
		end
	end

	if weaponAIData.MinPlayerDistance ~= nil then
		local distanceToPlayer = GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		if distanceToPlayer < weaponAIData.MinPlayerDistance then
			return false
		end
	end

	if weaponAIData.MaxActiveSpawns ~= nil then
		local spawnGroupName = weaponAIData.SpawnGroupName or "Spawner"..enemy.ObjectId
		local activeSpawns = GetIds({ Name = spawnGroupName })
		if activeSpawns ~= nil and TableLength(activeSpawns) >= weaponAIData.MaxActiveSpawns then
			return false
		end
	end

	if weaponAIData.RequireComboPartner and (enemy.ComboPartnerId == 0 or ActiveEnemies[enemy.ComboPartnerId] == nil or ActiveEnemies[enemy.ComboPartnerId].IsDead) then
		return false
	end

	if weaponAIData.MinDistanceFromComboPartner ~= nil and enemy.ComboPartnerId ~= 0 then
		local distanceToComboPartner = GetDistance({ Id = enemy.ObjectId, DestinationId = enemy.ComboPartnerId })
		if distanceToComboPartner < weaponAIData.MinDistanceFromComboPartner then
			return false
		end
	end

	if weaponAIData.MaxDistanceFromComboPartner ~= nil and enemy.ComboPartnerId ~= 0 then
		local distanceToComboPartner = GetDistance({ Id = enemy.ObjectId, DestinationId = enemy.ComboPartnerId })
		if distanceToComboPartner > weaponAIData.MaxDistanceFromComboPartner then
			return false
		end
	end

	if weaponAIData.RequireComboPartnerNotifyName ~= nil and enemy.ComboPartnerId ~= 0 then
		if ActiveEnemies[enemy.ComboPartnerId] ~= nil and not ActiveEnemies[enemy.ComboPartnerId].IsDead and ActiveEnemies[enemy.ComboPartnerId].AINotifyName ~= weaponAIData.RequireComboPartnerNotifyName then
			return false
		end
	end

	if weaponAIData.RequiredEquipment ~= nil then
		for k, requiredEquipment in pairs(weaponAIData.RequiredEquipment) do
			if not Contains(enemy.Equipment, requiredEquipment) then
				return false
			end
		end
	end

	if weaponAIData.RequireExistingIdsOfType ~= nil and #GetIdsByType({ Name = weaponAIData.RequireExistingIdsOfType }) <= 0 then
		return false
	end

	if WeaponData[weaponName].GameStateRequirements ~= nil and not IsGameStateEligible( CurrentRun, WeaponData[weaponName].GameStateRequirements ) then
		return false
	end

	return true
end

function IsEnemyWeaponForced( enemy, weaponName )
	if WeaponData[weaponName] == nil or WeaponData[weaponName].AIData == nil then
		return false
	end

	local weaponAIData = WeaponData[weaponName].AIData

	if WeaponData[weaponName].ForceFirst and enemy.WeaponName == nil then
		return true
	end

	if weaponAIData.ForceWithinPlayerDistance ~= nil then
		local distanceToPlayer = GetDistance({ Id = enemy.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
		if distanceToPlayer < weaponAIData.ForceWithinPlayerDistance then
			return true
		end
	end

	if weaponAIData.ForceIfComboPartnerNotifyName ~= nil then
		if ActiveEnemies[enemy.ComboPartnerId] ~= nil and not ActiveEnemies[enemy.ComboPartnerId].IsDead and ActiveEnemies[enemy.ComboPartnerId].AINotifyName == weaponAIData.ForceIfComboPartnerNotifyName then
			return true
		end
	end

	if weaponAIData.MaxAttacksBetweenUse ~= nil then
		local attacksSinceWeapon = NumAttacksSinceWeapon( enemy, weaponName )
		if attacksSinceWeapon >= weaponAIData.MaxAttacksBetweenUse then
			return true
		end
	end

	if weaponAIData.ForceUnderHealthPercent and enemy.Health / enemy.MaxHealth <= weaponAIData.ForceUnderHealthPercent then
		return true
	end

	if weaponAIData.ForceOverHealthPercent and enemy.Health / enemy.MaxHealth > weaponAIData.ForceUnderHealthPercent then
		return true
	end

	if weaponAIData.ForceIfTypeExists ~= nil and #GetIdsByType({ Name = weaponAIData.ForceIfTypeExists }) > 0 then
		return true
	end

	if weaponAIData.ForceUseIfReady then
		return true
	end

	return false
end

function MoveUntilEffectExpired( enemy, aiData, currentRun, args )
	if aiData.PostAttackAICanOnlyMoveForward then
		SetUnitProperty({ Property = "CanOnlyMoveForward", Value = true, DestinationId = enemy.ObjectId })
	end
	Move({ Id = enemy.ObjectId, DestinationId = args.TargetId, SuccessDistance = aiData.MoveSuccessDistance or 32 })
	enemy.AINotifyName = "EffectExpired"..enemy.ObjectId
	NotifyOnEffectExpired({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, EffectName = aiData.EffectExpiredName })
	waitUntil( enemy.AINotifyName, enemy.AIThreadName )
	if aiData.PostAttackAICanOnlyMoveForward then
		SetUnitProperty({ Property = "CanOnlyMoveForward", Value = false, DestinationId = enemy.ObjectId })
	end
	if HasEffect({ Id = enemy.ObjectId, EffectName = aiData.EffectExpiredName }) then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
	end
	Stop({ Id = enemy.ObjectId })
	if aiData.EndPartnerWaitPostAttackAI and enemy.ComboPartnerId ~= nil then
		if ActiveEnemies[enemy.ComboPartnerId] ~= nil and not ActiveEnemies[enemy.ComboPartnerId].IsDead then
			SetThreadWait( ActiveEnemies[enemy.ComboPartnerId].AIThreadName, 0.0 )
		end
	end
	if aiData.PostAttackAIDumbFireWeapons ~= nil then
		for k, weaponName in pairs( aiData.PostAttackAIDumbFireWeapons ) do
			local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
			weaponData.Name = weaponName
			thread( DumbFireAttack, enemy, currentRun, weaponData )
		end
	end
end

function AttackAllies(enemy, currentRun)
	while IsAIActive( enemy, currentRun ) do
		local enemyIds = GetAllKeys( RequiredKillEnemies )
		local nearestEnemyId = RemoveRandomValue(enemyIds)

		if nearestEnemyId == enemy.ObjectId then
			nearestEnemyId = RemoveRandomValue(enemyIds)
		end

		if nearestEnemyId ~= nil then
			AttackOnce( enemy, currentRun, nearestEnemyId )
		else
			wait( CalcEnemyWait( enemy, enemy.PostAttackCooldown), enemy.AIThreadName )
		end
	end
end

function MoveWithinRange( enemy, targetId, weaponAIData )
	if weaponAIData == nil then
		weaponAIData = enemy
	end

	local attackDistance = weaponAIData.AIAttackDistance or 900

	-- Pre Move
	if weaponAIData.PreMoveAngleTowardTarget then
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = targetId })
	end
	if weaponAIData.PreMoveAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.PreMoveAnimation })
	end
	wait( CalcEnemyWait( enemy, weaponAIData.PreMoveDuration ), enemy.AIThreadName )

	-- Dash
	if weaponAIData.DashIfOverDistance ~= nil then
		local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = targetId })
		if distanceToTarget > attackDistance and weaponAIData.DashIfOverDistance < distanceToTarget then
			enemy.WeaponName = weaponAIData.DashWeapon
			local dashWeaponAIData = GetWeaponAIData(enemy)

			AttackOnce( enemy, CurrentRun, targetId, dashWeaponAIData )
			enemy.WeaponName = weaponAIData.WeaponName
		end
	end

	-- Move to target
	Move({ Id = enemy.ObjectId, DestinationId = targetId, SuccessDistance = weaponAIData.MoveSuccessDistance or 32, LookAheadMultiplier = enemy.LookAheadMultiplier })

	-- Wait until within attack range
	enemy.AINotifyName = "WithinDistance"..enemy.ObjectId

	local timeout = weaponAIData.AIMoveWithinRangeTimeout
	if timeout == nil and weaponAIData.AIMoveWithinRangeTimeoutMin ~= nil and weaponAIData.AIMoveWithinRangeTimeoutMax ~= nil then
		timeout = RandomFloat(weaponAIData.AIMoveWithinRangeTimeoutMin, weaponAIData.AIMoveWithinRangeTimeoutMax)
	end
	if timeout ~= nil and enemy.SpeedMultiplier ~= nil then
		timeout = timeout / enemy.SpeedMultiplier
	end

	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = targetId, Distance = attackDistance,
		StopsUnits = weaponAIData.AIRequireUnitLineOfSight, StopsProjectiles = weaponAIData.AIRequireProjectileLineOfSight,
		LineOfSightBuffer = weaponAIData.AILineOfSightBuffer,
		LineOfSightEndBuffer = weaponAIData.AILineOfSighEndBuffer,
		Notify = enemy.AINotifyName, Timeout = timeout or 9.0 })

	waitUntil( enemy.AINotifyName, enemy.AIThreadName )

	local didTimeout = _eventTimeoutRecord[enemy.AINotifyName]
	if didTimeout then
		enemy.LookAheadMultiplier = math.min( (enemy.LookAheadMultiplier or 1.0) + 0.5, 3.0 )
		--DebugPrint({ Text = "enemy.LookAheadMultiplier = "..enemy.LookAheadMultiplier })
	else
		enemy.LookAheadMultiplier = 1.0
	end
	return didTimeout
end

function AttackOnce( enemy, currentRun, targetId, weaponAIData, animationObstacleId )
	local animationId = animationObstacleId or enemy.ObjectId
	if targetId == nil then
		targetId = currentRun.Hero.ObjectId
	end
	weaponAIData.LastTargetId = targetId

	if weaponAIData == nil then
		weaponAIData = enemy
	end

	-- PRE ATTACK START
	if weaponAIData.SkipStopBeforeAttack then
		--DebugPrint({ Text = "Skipping default Stop({  })" })
	else
		Stop({ Id = enemy.ObjectId })

		if weaponAIData.StopDuration ~= nil then
			wait( CalcEnemyWait( enemy, weaponAIData.StopDuration ), enemy.AIThreadName )
		end
	end
	if not CanAttack({ Id = enemy.ObjectId }) then
		return false
	end

	if weaponAIData.TrackKillSteal then
		currentRun.Hero.KillStolenFromId = enemy.ObjectId
		currentRun.Hero.KillStealVictimId = targetId
	end

	if weaponAIData.SkipAngleTowardTarget then
		--DebugPrint({ Text = "Skipping default AngleTowardTarget" })
	else
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = targetId })

		if not weaponAIData.SkipAngleTowardTargetWait then
			enemy.AINotifyName = "WaitForRotation"..enemy.ObjectId
			NotifyOnRotationComplete({ Id = enemy.ObjectId, Cosmetic = true, Notify = enemy.AINotifyName, Timeout = 9.0 })
			waitUntil( enemy.AINotifyName )
		end
	end

	local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = targetId })
	if enemy.MeleeWeapon ~= nil and distanceToTarget < enemy.MeleeWeapon.AttackDistance then
		weaponAIData = MergeTables( enemy, enemy.MeleeWeapon )
		if weaponAIData.PreAttackFx then
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.PreAttackFx })
		end
	end

	if weaponAIData.PreAttackSound ~= nil then
		PlaySound({ Name = weaponAIData.PreAttackSound, Id = enemy.ObjectId })
	end
	if weaponAIData.PreAttackLoopingSound ~= nil then
		if enemy.PreAttackLoopingSoundId ~= nil then
			StopSound({ Id = enemy.PreAttackLoopingSoundId, Duration = 0.2 })
			enemy.PreAttackLoopingSoundId = nil
		end
		enemy.PreAttackLoopingSoundId = PlaySound({ Name = weaponAIData.PreAttackLoopingSound, Id = enemy.ObjectId })
	end

	if weaponAIData.PreAttackVoiceLines ~= nil then
		thread( PlayVoiceLines, weaponAIData.PreAttackVoiceLines, nil, enemy )
	end

	if weaponAIData.PreAttackStopAnimations ~= nil then
		StopAnimation({ DestinationId = animationId, Names = weaponAIData.PreAttackStopAnimations, PreventChain = true, })
	end
	if weaponAIData.PreAttackAnimation then
		SetAnimation({ DestinationId = animationId, Name = weaponAIData.PreAttackAnimation })
	end
	if weaponAIData.PreAttackFx then
		CreateAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.PreAttackFx })
	end

	enemy.AttackWarningDestinationId = enemy.ObjectId
	if weaponAIData.AttackWarningAnimation ~= nil then
		if weaponAIData.AttackWarningAtTargetLocation then
			enemy.AttackWarningDestinationId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetId })
		end
		CreateAnimation({ Name = weaponAIData.AttackWarningAnimation, DestinationId = enemy.AttackWarningDestinationId, ScaleRadius = weaponAIData.AttackWarningAnimationRadius })
	end

	if enemy.TetherIds ~= nil then
		for k, tetherId in ipairs( enemy.TetherIds ) do
			if enemy.Tethers[k] ~= nil and enemy.Tethers[k].OwnerPreAttackVelocity ~= nil then
				local angleToTarget = GetAngleBetween({ Id = tetherId, DestinationIds = { enemy.ObjectId, targetId } })
				ApplyForce({ Id = tetherId, Speed = enemy.Tethers[k].OwnerPreAttackVelocity, Angle = angleToTarget })
			end
		end
	end

	local preAttackDuration = weaponAIData.PreAttackDuration or 0.5
	if weaponAIData.PreAttackDuration == nil and weaponAIData.PreAttackDurationMin ~= nil and weaponAIData.PreAttackDurationMax ~= nil then
		preAttackDuration = RandomFloat(weaponAIData.PreAttackDurationMin, weaponAIData.PreAttackDurationMax)
	end

	local preAttackEndDuration = weaponAIData.PreAttackEndDuration or math.min(0.5, preAttackDuration)
	local preAttackStartDuration = math.max(preAttackDuration - preAttackEndDuration, 0)

	if weaponAIData.PreAttackFunctionName ~= nil then
		local fireFunction = _G[weaponAIData.PreAttackFunctionName]
		fireFunction(enemy, weaponAIData, currentRun)
	end

	if weaponAIData.AIChargeTargetMarker then
		CreateTargetMarker( enemy, targetId, weaponAIData )
	end

	if weaponAIData.AITrackTargetDuringCharge then
		Track({ Ids = { enemy.ObjectId }, DestinationIds = { targetId } })
	end

	if weaponAIData.WaitDurationForComboPartnerMove ~= nil then
		if ActiveEnemies[enemy.ComboPartnerId] == nil or ActiveEnemies[enemy.ComboPartnerId].IsDead then
			weaponAIData.ForcedEarlyExit = true
			return false
		end

		enemy.WaitingForPartner = true
		wait( weaponAIData.WaitDurationForComboPartnerMove, enemy.AIThreadName )
		enemy.WaitingForPartner = false

		if ActiveEnemies[enemy.ComboPartnerId] == nil or ActiveEnemies[enemy.ComboPartnerId].IsDead then
			weaponAIData.ForcedEarlyExit = true
			return false
		end
	end

	if weaponAIData.PreAttackWaitForAnimation and weaponAIData.PreAttackAnimation ~= nil then
		enemy.AINotifyName = "PreAttackWaitForAnimation"..enemy.ObjectId
		NotifyOnAnimationTimeRemaining({ Id = animationId, Animation = weaponAIData.PreAttackAnimation, Remaining = preAttackEndDuration + 0.01, Notify = enemy.AINotifyName, Timeout = 9.0 })
		waitUntil( enemy.AINotifyName, enemy.AIThreadName )
	else
		wait( CalcEnemyWait( enemy, preAttackStartDuration, { MinWaitTime = weaponAIData.PreAttackStartMinWaitTime } ), enemy.AIThreadName )
	end

	if enemy.ForcedWeaponInterrupt ~= nil and (WeaponData[enemy.WeaponName] == nil or not WeaponData[enemy.WeaponName].BlockInterrupt)  then
		SetAnimation({ DestinationId = animationId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
		weaponAIData.ForcedEarlyExit = true
		if enemy.PreAttackLoopingSoundId ~= nil then
			StopSound({ Id = enemy.PreAttackLoopingSoundId, Duration = 0.2 })
			enemy.PreAttackLoopingSoundId = nil
		end
		return true
	end

	if ReachedAIStageEnd(enemy) or currentRun.CurrentRoom.InStageTransition then
		weaponAIData.ForcedEarlyExit = true
		return true
	end

	-- PRE ATTACK END
	if weaponAIData.SkipStopBeforePreAttackEnd then
		--DebugPrint({ Text = "Skipping default Stop({  })" })
	else
		Stop({ Id = enemy.ObjectId })
	end
	if not CanAttack({ Id = enemy.ObjectId }) then
		return false
	end

	if weaponAIData.PreAttackFlashSound ~= nil then
		PlaySound({ Name = weaponAIData.PreAttackFlashSound, Id = enemy.ObjectId })
	end
	if weaponAIData.PreAttackEndShake then
		Shake({ Id = enemy.ObjectId, Speed = 400, Distance = 3, Duration = preAttackEndDuration })
		Flash({ Id = enemy.ObjectId, Speed = 1, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = preAttackEndDuration })
	end
	if weaponAIData.PreAttackEndShakeSound ~= nil then
		PlaySound({ Name = weaponAIData.PreAttackEndShakeSound, Id = enemy.ObjectId })
	end

	if weaponAIData.PreAttackEndFunctionName ~= nil then
		local fireFunction = _G[weaponAIData.PreAttackEndFunctionName]
		fireFunction(enemy, weaponAIData, currentRun, weaponAIData.PreAttackEndFunctionArgs)
	end

	--DebugPrint({ Text=enemy.WeaponName.." preAttackEndDuration: "..CalcEnemyWait( enemy, preAttackEndDuration ) })
	wait( CalcEnemyWait( enemy, preAttackEndDuration, { MinWaitTime = weaponAIData.PreAttackEndMinWaitTime } ), enemy.AIThreadName )

	if weaponAIData.AttackWarningAnimation ~= nil then
		StopAnimation({ Name = weaponAIData.AttackWarningAnimation, DestinationId = enemy.AttackWarningDestinationId })
	end

	if not CanAttack({ Id = enemy.ObjectId }) then
		return false
	end

	if enemy.ForcedWeaponInterrupt ~= nil and (WeaponData[enemy.WeaponName] == nil or not WeaponData[enemy.WeaponName].BlockInterrupt) then
		SetAnimation({ DestinationId = animationId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
		return true
	end

	if ReachedAIStageEnd(enemy) or currentRun.CurrentRoom.InStageTransition then
		weaponAIData.ForcedEarlyExit = true
		return true
	end

	-- ATTACK
	if weaponAIData.ThreadFunctionName ~= nil then
		local fireFunction = _G[weaponAIData.ThreadFunctionName]
		thread(fireFunction, enemy, weaponAIData, currentRun)
	end

	if weaponAIData.RageDumbFireWeapons ~= nil and enemy.Enraged then
		for k, weaponName in pairs( weaponAIData.RageDumbFireWeapons ) do
			local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
			weaponData.Name = weaponName
			thread( DumbFireAttack, enemy, currentRun, weaponData )
		end
	end

	if weaponAIData.DumbFireWeapons ~= nil then
		for k, weaponName in pairs( weaponAIData.DumbFireWeapons ) do
			local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
			weaponData.Name = weaponName
			thread( DumbFireAttack, enemy, currentRun, weaponData )
		end
	end

	if not weaponAIData.SkipFireWeapon then
		if not AttackerFireWeapon( enemy, weaponAIData, currentRun, targetId, animationId ) then
			return false
		end
	end

	if weaponAIData.AIChargeTargetMarker then
		FinishTargetMarker( enemy )
	end

	if weaponAIData.FireFunctionName ~= nil then
		local fireFunction = _G[weaponAIData.FireFunctionName]
		fireFunction(enemy, weaponAIData, currentRun, weaponAIData.FireFunctionArgs )
	end

	if weaponAIData.PostAttackDumbFireWeapons ~= nil then
		for k, weaponName in pairs( weaponAIData.PostAttackDumbFireWeapons ) do
			local weaponData = WeaponData[weaponName].AIData or WeaponData[weaponName]
			weaponData.Name = weaponName
			thread( DumbFireAttack, enemy, currentRun, weaponData )
		end
	end

	if weaponAIData.SpawnEncounter ~= nil then
		local encounter = DeepCopyTable( EncounterData[weaponAIData.SpawnEncounter] )
		if encounter.Generated then
			GenerateEncounter(CurrentRun, CurrentRun.CurrentRoom, encounter)
		end
		enemy.SpawnedEncounter = encounter
		if encounter.StartGlobalVoiceLines ~= nil then
			thread( PlayVoiceLines, GlobalVoiceLines[encounter.StartGlobalVoiceLines] )
		end
		thread( StartEncounter, currentRun, currentRun.CurrentRoom, encounter )
	end

	if weaponAIData.UnequipWeaponAfterUse then
		RemoveValue(enemy.WeaponOptions, enemy.WeaponName)
		DebugPrint({ Text = "Remove weapon: "..enemy.WeaponName })
	end

	if weaponAIData.StopAnimationAfterUse then
		StopAnimation({ DestinationId = animationId, Name = weaponAIData.StopAnimationAfterUse })
	end

	if weaponAIData.LoseEquipmentOnUse ~= nil then
		for k, equipment in pairs(weaponAIData.LoseEquipmentOnUse) do
			RemoveValue(enemy.Equipment, equipment)
		end
	end

	if weaponAIData.RetreatLeapAfterUse then
		enemy.NeedsRetreatLeap = true
	end

	if weaponAIData.PreAttackLoopingSound ~= nil then
		StopSound({ Id = enemy.PreAttackLoopingSoundId, Duration = 0.2 })
		enemy.PreAttackLoopingSoundId = nil
	end
	if weaponAIData.PreAttackLoopingEndSound ~= nil then
		PlaySound({ Name = weaponAIData.PreAttackLoopingEndSound, Id = enemy.ObjectId })
	end

	if enemy.ForcedWeaponInterrupt ~= nil and (WeaponData[enemy.WeaponName] == nil or not WeaponData[enemy.WeaponName].BlockInterrupt)  then
		SetAnimation({ DestinationId = animationId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
		return true
	end

	if ReachedAIStageEnd(enemy) or currentRun.CurrentRoom.InStageTransition then
		weaponAIData.ForcedEarlyExit = true
		return true
	end

	-- POST ATTACK
	if weaponAIData.PostAttackFx then
		if weaponAIData.PostAttackFXOnPlayer then
			CreateAnimation({ Name = weaponAIData.PostAttackFx, DestinationId = CurrentRun.Hero.ObjectId })
		else
			CreateAnimation({ Name = weaponAIData.PostAttackFx, DestinationId = enemy.ObjectId })
		end
	end
	if weaponAIData.StopAnimationsOnEnd then
		for k, animationName in pairs(weaponAIData.StopAnimationsOnEnd) do
			StopAnimation({ DestinationId = enemy.ObjectId, Name = animationName })
		end
	end

	if weaponAIData.PostAttackSound ~= nil then
		PlaySound({ Name = weaponAIData.PostAttackSound, Id = enemy.ObjectId })
	end

	if weaponAIData.AttackVoiceLines ~= nil then
		thread( PlayVoiceLines, weaponAIData.AttackVoiceLines, nil, enemy )
	end

	local postAttackCooldown = weaponAIData.PostAttackCooldown
	if weaponAIData.PostAttackCooldown == nil and weaponAIData.PostAttackCooldownMin ~= nil and weaponAIData.PostAttackCooldownMax ~= nil then
		postAttackCooldown = RandomFloat(weaponAIData.PostAttackCooldownMin, weaponAIData.PostAttackCooldownMax)
	end

	wait( CalcEnemyWait( enemy, postAttackCooldown, { MinWaitTime = weaponAIData.PostAttackCooldownMinWaitTime } ), enemy.AIThreadName )

	if weaponAIData.IdleAnimation ~= nil then
		SetAnimation({ DestinationId = animationId, Name = weaponAIData.IdleAnimation })
	end

	return true

end

function CreateTargetMarker( enemy, targetId, weaponAIData )
	if enemy.TargetMarkerCreated then
		return
	end
	local targetMarker = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetId })
	Attach({ Id = targetMarker, DestinationId = targetId })
	CreateAnimation({ Name = weaponAIData.AIChargeTargetMarker, DestinationId = targetMarker })
	enemy.TargetMarkerCreated = { Anim = weaponAIData.AIChargeTargetMarker, Id = targetMarker }
end

function FinishTargetMarker( enemy )
	if enemy.TargetMarkerCreated then
		StopAnimation({ DestinationId = enemy.TargetMarkerCreated.Id, Name = enemy.TargetMarkerCreated.Anim, PreventChain = true })
		enemy.TargetMarkerCreated = nil
	end
end

-- Does nothing until attacked, then switches to AttackerAI permanently
function IdleUntilAggroAI( enemy, currentRun )

	if enemy.StartAggroed then
		AggroUnit(enemy)
	end
	enemy.IsAggroed = false


	if enemy.AggroMinimumDistance ~= nil then
		enemy.AINotifyName = "AggroMinimumDistance"..enemy.ObjectId

		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId, Distance = enemy.AggroMinimumDistance, Notify = enemy.AINotifyName })
		waitUntil( enemy.AINotifyName )
	end

	while IsAIActive( enemy, currentRun ) do

		-- Convert to AttackerAI permanently
		if enemy.IsAggroed then
			Flash({ Id = enemy.ObjectId, Speed = 0.5, MinFraction = 1.0, MaxFraction = 0.0, Color = Color.Red, ExpireAfterCycle = true })
			PlaySound({ Name = enemy.IsAggroedSound or "/Leftovers/SFX/ImpRef01_GoDown", Id = enemy.ObjectId, ManagerCap = 28 })
			thread( InCombatText, enemy.ObjectId, "Startled", 0.45 )
			local aiOption = GetRandomValue( enemy.AIOptions )
			return SetAI( aiOption, enemy, CurrentRun )
		end

		wait( CalcEnemyWait( enemy, 0.5), enemy.AIThreadName )

	end
end

-- Wanders until the player is within aggro range, then switches to AttackerAI permanently
function AggroAI( enemy, currentRun )
	enemy.CanBeAggroed = true

	if enemy.StartAggroed then
		AggroUnit( enemy )
		return
	end
	enemy.IsAggroed = false

	local aggroRange = enemy.AIAggroRange or 500

	-- Return to aggro tether
	if enemy.AggroTetherId ~= nil and IsAlive({ Id = enemy.AggroTetherId }) then
		Move({ Id = enemy.ObjectId, DestinationId = enemy.AggroTetherId, Mode = "Precise" })
		enemy.AINotifyName = "ReturnToTether"..enemy.ObjectId

		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = enemy.AggroTetherId, Distance = 100, Notify = enemy.AINotifyName})
		waitUntil( enemy.AINotifyName )
	end

	local wanderDistance = enemy.AIWanderDistance or 100
	local originalPosition = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, Group = "Standing" })

	while IsAIActive( enemy, currentRun ) and not enemy.IsAggroed do
		-- Move to a random location within tether
		local randomNewTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = originalPosition, OffsetX = RandomFloat(-wanderDistance, wanderDistance), OffsetY = RandomFloat(-wanderDistance, wanderDistance), Group = "Standing" })
		Move({ Id = enemy.ObjectId, DestinationId = randomNewTargetId, Mode = "Precise" })

		local aggroOriginId = enemy.ObjectId

		if enemy.AggroTetherId ~= nil and IsAlive({ Id = enemy.AggroTetherId }) then
			aggroOriginId = enemy.AggroTetherId
		end

		-- Within aggro range
		if not enemy.IsAggroed then
			enemy.AINotifyName = "WithinAggroRange"..enemy.ObjectId

			NotifyWithinDistance({ Id = aggroOriginId, DestinationId = currentRun.Hero.ObjectId, Distance = aggroRange, Notify = enemy.AINotifyName, Timeout = 1.5})
			waitUntil( enemy.AINotifyName )

			if not _eventTimeoutRecord[enemy.AINotifyName] then
				AggroUnit( enemy )
			end
		end

		if enemy.AggroIfLastAlive and TableLength( RequiredKillEnemies ) == 1 then
			AggroUnit( enemy )
		end

		wait( CalcEnemyWait( enemy, 0.5), enemy.AIThreadName )
		Destroy({ Id = randomNewTargetId })
	end
end

function AggroUnit( enemy )

	if enemy.IsAggroed then
		return
	end

	enemy.IsAggroed = true

	local reactionTime = enemy.AggroReactionTime or 0
	if enemy.AggroReactionTime == nil and enemy.AggroReactionTimeMin ~= nil and enemy.AggroReactionTimeMax ~= nil then
		reactionTime = RandomFloat(enemy.AggroReactionTimeMin, enemy.AggroReactionTimeMax)
	end
	wait( CalcEnemyWait( enemy, reactionTime ), enemy.AIThreadName)

	PlaySound({ Name = enemy.IsAggroedSound or "/Leftovers/SFX/ImpRef01_GoDown", Id = enemy.ObjectId, ManagerCap = 28 })
	Stop({ Id = enemy.ObjectId })
	if not enemy.SkipRotateOnAggro then
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = GetTargetId(enemy)})
	end

	thread( InCombatText, enemy.ObjectId, "Alerted", 0.45, { OffsetY = enemy.HealthBarOffsetY, SkipShadow = true }  )
	if enemy.AggroAnimation ~= nil then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.AggroAnimation })
	end
	wait( CalcEnemyWait( enemy, enemy.AggroDuration ), enemy.AIThreadName )

	thread( AggroNearbyUnits, enemy )

	local newAI = enemy.PostAggroAI or AttackerAI
	return SetAI( newAI, enemy, CurrentRun )
end

function AggroNearbyUnits( enemy )

	for otherEnemyId, otherEnemy in pairs( ActiveEnemies ) do
		if otherEnemy ~= nil and otherEnemy.CanBeAggroed and not otherEnemy.IsAggroed and enemy.ObjectId ~= otherEnemyId then
			local aggroRange = otherEnemy.AIAggroRange or 0
			if enemy.ChainAggroAllEnemies and GetDistance({ Id = enemy.ObjectId, DestinationId = otherEnemyId }) < aggroRange then
				thread( AggroUnit, otherEnemy )
			end
		end
	end

end

function CheckStun( enemy, aiData, targetId )
	if aiData.AttackFailWeapon ~= nil and not CanAttack({ Id = enemy.ObjectId }) then
		FireWeaponFromUnit({ Weapon = aiData.AttackFailWeapon, Id = enemy.ObjectId, DestinationId = targetId, AutoEquip = true })
	end
end

function HideAndPeekAI( enemy, currentRun )

	SurroundEnemiesAttacking = SurroundEnemiesAttacking or {}

	while IsAIActive( enemy, currentRun ) do

		if not CanAttack({ Id = enemy.ObjectId }) then
			enemy.AINotifyName = "CanAttack"..enemy.ObjectId
			NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
			waitUntil( enemy.AINotifyName )
		end

		-- Pick weapon
		enemy.WeaponName = SelectWeapon( enemy )
		--DebugAssert({ Condition = enemy.WeaponName ~= nil, Text = "Enemy has no weapon!" })
		table.insert( enemy.WeaponHistory, enemy.WeaponName )

		local weaponAIData = GetWeaponAIData(enemy)

		local targetId = GetTargetId(enemy, weaponAIData)

		if targetId ~= nil and targetId ~= 0 then

			-- Retreat if target is too close
			local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = targetId })
			if weaponAIData.AIRetreatDistance ~= nil and distanceToTarget < weaponAIData.AIRetreatDistance then
				Retreat(enemy, weaponAIData, targetId)
			end

			-- Hide behind cover if found
			local coverId = GetClosest({ Id = enemy.ObjectId, DestinationNames = { "Standing" }, StopsProjectiles = true })
			if coverId > 0 then
				Move({ Id = enemy.ObjectId, DestinationId = coverId, LiveOffsetFromId = targetId, LiveOffsetDistance = weaponAIData.CoverHugDistance, SuccessDistance = 50 })
			end
			wait( CalcEnemyWait( enemy, weaponAIData.TakeCoverDuration ), enemy.AIThreadName )
			CheckStun( enemy, weaponAIData, targetId )

			-- Wait to be re-aggroed
			Stop({ Id = enemy.ObjectId })
			local enemyId = enemy.ObjectId
			enemy.AINotifyName = "WaitingForAggro"..enemy.ObjectId

			NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId, Distance = enemy.AIAggroRange * enemy.PeekAggroMultiplier, Notify = enemy.AINotifyName })
			waitUntil( enemy.AINotifyName )
			wait( CalcEnemyWait( enemy, 0.1 ), enemy.AIThreadName )
			CheckStun( enemy, weaponAIData, targetId )

			-- Peek
			if weaponAIData.TeleportToSpawnPoints then
				HandleEnemyTeleportation(enemy, weaponAIData, currentRun, targetId)
			end
			if weaponAIData.PeekMoveSpeed ~= nil then
				SetUnitProperty({ Property = "Speed", Value = weaponAIData.PeekMoveSpeed, DestinationId = enemy.ObjectId })
			end
			MoveWithinRange( enemy, targetId, weaponAIData )
			if weaponAIData.PeekMoveSpeed ~= nil then
				SetUnitProperty({ Property = "Speed", Value = enemy.MoveSpeed, DestinationId = enemy.ObjectId })
			end

			-- Fire
			if weaponAIData.MaxAttackers == nil or TableLength( SurroundEnemiesAttacking ) < weaponAIData.MaxAttackers then
				SurroundEnemiesAttacking[enemy.ObjectId] = true
				AttackOnce( enemy, currentRun, targetId, weaponAIData )
				FinishTargetMarker( enemy )
				SurroundEnemiesAttacking[enemy.ObjectId] = nil
			end
			CheckStun( enemy, weaponAIData, targetId )

		else
			wait( CalcEnemyWait( enemy, 1.0 ), enemy.AIThreadName )
			CheckStun( enemy, weaponAIData, targetId )
		end
	end

end

function SurroundAI( enemy, currentRun )

	SurroundEnemiesAttacking = SurroundEnemiesAttacking or {}

	while IsAIActive( enemy, currentRun ) do

		if not CanAttack({ Id = enemy.ObjectId }) then
			enemy.AINotifyName = "CanAttack"..enemy.ObjectId
			NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
			waitUntil( enemy.AINotifyName )
		end

		-- Pick weapon
		enemy.WeaponName = SelectWeapon( enemy )
		--DebugAssert({ Condition = enemy.WeaponName ~= nil, Text = "Enemy has no weapon!" })
		table.insert( enemy.WeaponHistory, enemy.WeaponName )

		local weaponAIData = GetWeaponAIData(enemy)

		local targetId = GetTargetId( enemy, weaponAIData )

		if targetId ~= nil and target ~= 0 then

			if weaponAIData.TeleportToSpawnPoints then
				HandleEnemyTeleportation(enemy, weaponAIData, currentRun, targetId)
			end

			Move({ Id = enemy.ObjectId, DestinationId = targetId, LiveOffsetFromId = enemy.ObjectId, LiveOffsetDistance = weaponAIData.SurroundDistance, LiveOffsetAngle = 180, SuccessDistance = 50 })
			wait( CalcEnemyWait( enemy, weaponAIData.StandOffTime), enemy.AIThreadName )

			if GetDistance({ Id = enemy.ObjectId, DestinationId = targetId }) <= weaponAIData.AIAttackDistance and ( weaponAIData.MaxAttackers == nil or TableLength( SurroundEnemiesAttacking ) < weaponAIData.MaxAttackers ) then
				SurroundEnemiesAttacking[enemy.ObjectId] = true
				AttackOnce( enemy, currentRun, targetId, weaponAIData )
				SurroundEnemiesAttacking[enemy.ObjectId] = nil
			end

		else
			wait( CalcEnemyWait( enemy, 1.0), enemy.AIThreadName )
		end
	end

end

function LeapIntoRangeAI( enemy, currentRun )
	MapState.LeapPointsOccupied = MapState.LeapPointsOccupied or {}

	while IsAIActive( enemy, currentRun ) do
		-- Pick weapon
		enemy.WeaponName = SelectWeapon( enemy )
		--if enemy.WeaponName == nil then
			--DebugAssert({ Condition = enemy.WeaponName ~= nil, Text = "Enemy has no weapon!" })
		--end
		table.insert( enemy.WeaponHistory, enemy.WeaponName )

		local weaponAIData = GetWeaponAIData(enemy)

		local targetId = GetTargetId( enemy, weaponAIData )

		if not CanAttack({ Id = enemy.ObjectId }) then
			enemy.AINotifyName = "CanAttack"..enemy.ObjectId
			NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
			waitUntil( enemy.AINotifyName )
		end

		if weaponAIData.TeleportToSpawnPoints then
			HandleEnemyTeleportation(enemy, weaponAIData, currentRun, targetId)
		end

		if targetId ~= nil and targetId ~= 0 then
			-- Check if player is too far or has no path
			local needsLeap = false
			local distanceToPlayer = GetDistance({ Id = enemy.ObjectId, DestinationId = targetId })
			if weaponAIData.LeapWhenTargetBeyondDistance ~= nil and distanceToPlayer > weaponAIData.LeapWhenTargetBeyondDistance then
				needsLeap = true
			elseif weaponAIData.LeapWhenTargetWithinDistance ~= nil and distanceToPlayer < weaponAIData.LeapWhenTargetWithinDistance then
				needsLeap = true
			elseif weaponAIData.LeapWhenTargetOutOfSight then
				local hasLineOfSight = HasLineOfSight({ Id = enemy.ObjectId, DestinationId = targetId, StopsProjectiles = false, StopsUnits = true, PreferAvoidUnits = true })
				if not hasLineOfSight then
					needsLeap = true
				end
			end

			if needsLeap then
				-- Leap to close gap
				Leap(enemy, weaponAIData, targetId )
			end

			if enemy.NeedsRetreatLeap then
				Leap(enemy, weaponAIData, targetId, "Retreat" )
				enemy.NeedsRetreatLeap = false
				if weaponAIData.DeaggroAfterRetreat then
					SetAI(AggroAI, enemy, CurrentRun)
				end
			elseif enemy.NeedsFlankLeap then
				Leap(enemy, weaponAIData, targetId, "Flank" )
				enemy.NeedsFlankLeap = false
			end

			DoAttackerAILoop( enemy, currentRun, targetId, weaponAIData )

			if weaponAIData.RepositionLeap then
				Leap(enemy, weaponAIData, targetId )
			end
		else
			if enemy.NeedsRetreatLeap then
				Leap(enemy, weaponAIData, targetId, "Retreat" )
				enemy.NeedsRetreatLeap = false
				if weaponAIData.DeaggroAfterRetreat then
					SetAI(AggroAI, enemy, CurrentRun)
				end
			end

			wait( CalcEnemyWait( enemy, 1.0), enemy.AIThreadName )
		end
	end
end

function Leap( enemy, weaponAIData, targetId, leapType, forceLeapTargetId )
	if not CanMove({ Id = enemy.ObjectId }) then
		return
	end

	MapState.LeapPointsOccupied = MapState.LeapPointsOccupied or {}
	local leapTargetId = nil
	local validPoints = {}
	if leapType == "Flank" then
		-- Needs to pick a point on the other side of the player
		leapTargetId = targetId
	elseif leapType == "Retreat" then
		local nearbyPoints = GetClosestIds({ Id = targetId, DestinationName = "SpawnPoints", Distance = weaponAIData.RetreatLeapDistance })
		for k, pointId in pairs(nearbyPoints) do
			if MapState.LeapPointsOccupied[pointId] == nil then
				local distanceTargetToPoint = GetDistance({ Id = targetId, DestinationId = pointId })
				local minDistance = weaponAIData.RetreatLeapMinDistance or 0
				if distanceTargetToPoint > minDistance then
					table.insert(validPoints, pointId)
				end
			end
		end
	else
		local nearbyPoints = GetClosestIds({ Id = targetId, DestinationName = "SpawnPoints", Distance = weaponAIData.LeapOffsetRange })
		for k, pointId in pairs(nearbyPoints) do
			if MapState.LeapPointsOccupied[pointId] == nil then
				table.insert(validPoints, pointId)
			end
		end
	end
	leapTargetId = forceLeapTargetId or GetRandomValue(validPoints)

	if leapTargetId == nil then
		DebugPrint({ Text = "No valid leap target found!" })
		return
	end

	if enemy.LeapPointOccupied ~= nil then
		MapState.LeapPointsOccupied[enemy.LeapPointOccupied] = nil
	end

	MapState.LeapPointsOccupied[leapTargetId] = true
	enemy.LeapPointOccupied = leapTargetId

	local lockedTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = leapTargetId })
	if weaponAIData.LeapWarningAnimation ~= nil then
		CreateAnimation({ Name = weaponAIData.LeapWarningAnimation, DestinationId = lockedTargetId })
	end

	local immuneToForceReset = GetThingDataValue({ Id = enemy.ObjectId, Property = "ImmuneToForce" })
	--local immuneToStunReset = GetUnitDataValue({ Id = enemy.ObjectId, Property = "ImmuneToStun" })
	SetThingProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToForce", Value = true })
	--SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToStun", Value = true })

	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = lockedTargetId })
	SetAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.LeapChargeAnimation })
	if weaponAIData.LeapChargeSound ~= nil then
		PlaySound({ Name = weaponAIData.LeapChargeSound, Id = enemy.ObjectId })
	end
	wait( CalcEnemyWait( enemy, weaponAIData.LeapPrepareTime ), enemy.AIThreadName )

	SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithObstacles", Value = false })
	SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = false })
	Stop({ Id = enemy.ObjectId })
	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = lockedTargetId })
	ApplyForce({ Id = enemy.ObjectId, Angle = GetAngleBetween({ Id = enemy.ObjectId, DestinationId = lockedTargetId }), Speed = weaponAIData.LeapSpeed, SelfApplied = true })
	local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = lockedTargetId })
	local neededHangTime = (distanceToTarget / weaponAIData.LeapSpeed) + 0.05
	ApplyUpwardForce({ Id = enemy.ObjectId, HangTime = neededHangTime })
	PlaySound({ Name = weaponAIData.LeapSound or "/Leftovers/SFX/HarpDash", Id = enemy.ObjectId })
	wait( CalcEnemyWait( enemy, neededHangTime ), enemy.AIThreadName )
	-- Landed
	SetAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.LeapLandingAnimation })
	PlaySound({ Name = weaponAIData.LeapLandingSound, Id = enemy.ObjectId, ManagerCap = 28 })
	if weaponAIData.LeapWarningAnimation ~= nil then
		StopAnimation({ Name = weaponAIData.LeapWarningAnimation, DestinationId = lockedTargetId })
	end
	Destroy({ Id = lockedTargetId })
	SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithObstacles", Value = true })
	SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = true })

	SetThingProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToForce", Value = immuneToForceReset })
	--SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToStun", Value = immuneToStunReset })
	--SetVulnerable({ Id = enemy.ObjectId })
	wait( CalcEnemyWait( enemy, weaponAIData.LeapRecoveryTime), enemy.AIThreadName )
end

function RamAILoop( enemy, currentRun, aiData )
	if not CanAttack({ Id = enemy.ObjectId }) then
		enemy.AINotifyName = "CanAttack"..enemy.ObjectId
		NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
		waitUntil( enemy.AINotifyName )
	end

	local targetId = GetTargetId( enemy, aiData )
	if targetId ~= nil and targetId ~= 0 then
		-- Setup move
		aiData.AIAttackDistance = aiData.SetupDistance
		aiData.AIMoveWithinRangeTimeout = aiData.SetupTimeout
		MoveWithinRange( enemy, targetId, aiData )

		if not _eventTimeoutRecord[enemy.AINotifyName] then
			-- Teleportation
			if aiData.TeleportToSpawnPoints then
				HandleEnemyTeleportation(enemy, aiData, currentRun, targetId)
			end

			-- Prepare to ram
			if aiData.PreAttackStop then
				Stop({ Id = enemy.ObjectId })
			end
			if aiData.AITrackTargetDuringCharge then
				Track({ Ids = { enemy.ObjectId }, DestinationIds = { targetId } })
			end
			if aiData.PreAttackShake ~= nil then
				Shake({ Id = enemy.ObjectId, Speed = aiData.PreAttackShake, Distance = 3, Duration = aiData.PreAttackDuration })
			end
			if aiData.PreAttackFlash ~= nil then
				Flash({ Id = enemy.ObjectId, Speed = aiData.PreAttackFlash, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = aiData.PreAttackDuration })
			end
			if aiData.PreAttackSound ~= nil then
				PlaySound({ Name = aiData.PreAttackSound, Id = enemy.ObjectId })
			end
			if aiData.PreAttackAnimation ~= nil then
				SetAnimation({ Name = aiData.PreAttackAnimation, DestinationId = enemy.ObjectId })
			end
			if aiData.PreAttackFx ~= nil then
				CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreAttackFx })
			end
			wait( CalcEnemyWait( enemy, aiData.PreAttackDuration ), enemy.AIThreadName )

			if HasEffect({Id = enemy.ObjectId, EffectName = "ZeusAttackPenalty" }) then
				thread(FireWeaponWithinRange, { TargetId = enemy.ObjectId, WeaponName = "ZeusAttackBolt", InitialDelay = 0, Delay = 0.25, Count = 1, BonusChance = GetTotalHeroTraitValue("BonusBolts") })
				if not HeroHasTrait("JoltDurationTrait") then
					ClearEffect({ Id = enemy.ObjectId, Name = "ZeusAttackPenalty" })
				end
			end
			ApplyEffectFromWeapon({ Id = enemy.ObjectId, DestinationId = enemy.ObjectId, AutoEquip = true, WeaponName = aiData.RamWeaponName, EffectName = aiData.RamEffectName, Duration = aiData.RamTimeout })
			if aiData.FireSound ~= nil then
				PlaySound({ Name = aiData.FireSound, Id = enemy.ObjectId })
			end
			if aiData.FireAnimation ~= nil then
				SetAnimation({ Name = aiData.FireAnimation, DestinationId = enemy.ObjectId })
			end
			if aiData.FireFx ~= nil then
				CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.FireFx })
			end
			-- Ram move
			aiData.AIAttackDistance = aiData.RamDistance
			aiData.AIMoveWithinRangeTimeout = aiData.RamTimeout
			MoveWithinRange( enemy, targetId, aiData )
			Stop({ Id = enemy.ObjectId })
			if aiData.PostAttackAnimation ~= nil then
				SetAnimation({ Name = aiData.PostAttackAnimation, DestinationId = enemy.ObjectId })
			end
			wait( CalcEnemyWait( enemy, aiData.RamRecoverTime ), enemy.AIThreadName )
		end
	else
		MoveToRandomLocation( enemy, enemy.ObjectId, aiData.NoTargetWanderDistance or 100, aiData.NoTargetWanderDuration )
		wait( CalcEnemyWait( enemy, aiData.NoTargetWanderDuration or 0.5 ), enemy.AIThreadName )
	end

	if aiData.RetreatAfterRam then
		Retreat(enemy, aiData, targetId)
	end
end

function TheseusChariotAI( enemy, currentRun )

	while IsAIActive( enemy, currentRun ) do
		if not CanAttack({ Id = enemy.ObjectId }) then
			enemy.AINotifyName = "CanAttack"..enemy.ObjectId
			NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
			waitUntil( enemy.AINotifyName )
		end

		enemy.WeaponName = SelectWeapon( enemy )
		--DebugAssert({ Condition = enemy.WeaponName ~= nil, Text = "Enemy has no weapon!" })
		table.insert(enemy.WeaponHistory, enemy.WeaponName)

		local weaponAIData = GetWeaponAIData(enemy)

		if weaponAIData.ChainedWeapon ~= nil then
			enemy.ChainedWeapon = weaponAIData.ChainedWeapon
		end

		if weaponAIData.PathWeapon then
			thread( TheseusChariotAIMovement, enemy, currentRun, weaponAIData )
			enemy.FollowingPath = true

			local hasAttacked = false
			while enemy.FollowingPath do

				if weaponAIData.FireAfterPatrolIndex == nil or weaponAIData.ReachedAttackPatrolId then
					if not weaponAIData.FireOncePerPatrol or not hasAttacked then
						local targetId = GetTargetId( enemy, weaponAIData )
						if targetId ~= nil and targetId ~= 0 then
							local attackSuccess = AttackOnce( enemy, currentRun, targetId, weaponAIData )
							hasAttacked = attackSuccess
							if weaponAIData.ForcedEarlyExit then
								killWaitUntilThreads( enemy.AIThreadName )
								SetThreadWait( enemy.AIThreadName, 0.05 )
								break
							end
							if not attackSuccess and not CanAttack({ Id = enemy.ObjectId }) then
								enemy.AINotifyName = "CanAttack"..enemy.ObjectId
								NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 0.3 })
								waitUntil( enemy.AINotifyName )
							end
						else
							wait(0.1, enemy.AIThreadName)
						end
					else
						wait(0.1, enemy.AIThreadName)
					end
				else
					wait(0.1, enemy.AIThreadName)
				end
			end
		else
			AttackOnce( enemy, currentRun, targetId, weaponAIData )
		end

		if weaponAIData.MovementEffectName ~= nil then
			ClearEffect({ Id = enemy.ObjectId, Name = weaponAIData.MovementEffectName })
		end
	end
end

function TheseusChariotAIMovement( enemy, currentRun, weaponAIData )

	local pathIds = weaponAIData.PatrolPathIds

	if weaponAIData.PatrolPaths ~= nil then
		if weaponAIData.PatrolNearestStartId then
			local closestIndex = 1
			local closestDistance = 99999
			for i, pathIds in pairs(weaponAIData.PatrolPaths) do
				local distance = GetDistance({ Id = enemy.ObjectId, DestinationId = pathIds[1] })
				if distance < closestDistance then
					closestIndex = i
					closestDistance = distance
				end
			end
			pathIds = weaponAIData.PatrolPaths[closestIndex]
		else
			pathIds = GetRandomValue(weaponAIData.PatrolPaths)
		end
	end

	if pathIds == nil then
		return
	end

	local pathIndex = 1

	weaponAIData.ReachedAttackPatrolId = false
	enemy.FollowingPath = true
	while pathIndex <= #pathIds + 1 do

		local targetId = pathIds[pathIndex]
		if targetId ~= nil and targetId ~= 0 then
			
			MoveWithinRange( enemy, targetId, weaponAIData )

			if weaponAIData.FireAfterPatrolIndex and pathIndex == weaponAIData.FireAfterPatrolIndex then
				weaponAIData.ReachedAttackPatrolId = true
			end

			if enemy.ForcedWeaponInterrupt ~= nil or weaponAIData.ForcedEarlyExit then
				break
			end
		end

		pathIndex = pathIndex + 1
	end
	enemy.FollowingPath = false
end

function AttackerFireWeapon( enemy, weaponAIData, currentRun, targetId, animationId )
	animationId = animationId or enemy.ObjectId

	if weaponAIData.FireWeaponAtSelf then
		targetId = enemy.ObjectId
	end

	if weaponAIData.AttackSound ~= nil then
		PlaySound({ Name = weaponAIData.AttackSound, Id = enemy.ObjectId })
	end

	local defaultCollideWithUnits = nil
	local defaultStopsProjectiles = nil
	if weaponAIData.RemoveUnitCollisionDuringAttack then
		defaultCollideWithUnits = GetUnitDataValue({ Id = enemy.ObjectId, Property = "CollideWithUnits" })
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = false })
	end
	if weaponAIData.AddUnitCollisionDuringAttack then
		defaultCollideWithUnits = GetUnitDataValue({ Id = enemy.ObjectId, Property = "CollideWithUnits" })
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = true })
	end
	if weaponAIData.AddProjectileCollisionDuringAttack then
		defaultStopsProjectiles = GetThingDataValue({ Id = enemy.ObjectId, Property = "StopsProjectiles" })
		SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = true })
	end

	local fireTicks = weaponAIData.FireTicks or 1
	if weaponAIData.AIFireTicksMin ~= nil and weaponAIData.AIFireTicksMax ~= nil then
		fireTicks = RandomInt( weaponAIData.AIFireTicksMin, weaponAIData.AIFireTicksMax )
	end

	local fireCooldown = weaponAIData.FireCooldown or weaponAIData.AIFireTicksCooldown
	if weaponAIData.FireCooldownMin ~= nil and weaponAIData.FireCooldownMax ~= nil then
		fireCooldown = RandomFloat( weaponAIData.FireCooldownMin, weaponAIData.FireCooldownMax )
	end

	if HasEffect({Id = enemy.ObjectId, EffectName = "ZeusAttackPenalty" }) then
		thread(FireWeaponWithinRange, { TargetId = enemy.ObjectId, WeaponName = "ZeusAttackBolt", InitialDelay = 0, Delay = 0.25, Count = 1, BonusChance = GetTotalHeroTraitValue("BonusBolts") })
		if not HeroHasTrait("JoltDurationTrait") then
			ClearEffect({ Id = enemy.ObjectId, Name = "ZeusAttackPenalty" })
		end
	end

	for fireTick = 1, fireTicks, 1 do
		if ReachedAIStageEnd(enemy) or currentRun.CurrentRoom.InStageTransition then
			weaponAIData.ForcedEarlyExit = true
			return true
		end

		if not CanAttack({ Id = enemy.ObjectId }) then
			return false
		end

		if weaponAIData.ResetTargetPerTick then
			targetId = GetTargetId(enemy, weaponAIData)
		end

		if weaponAIData.AIChargeTargetMarker then
			FinishTargetMarker( enemy )
		end

		if weaponAIData.AIAngleTowardsPlayerWhileFiring then
			AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = targetId })
		end

		if weaponAIData.PreFireAnimation then
			SetAnimation({ DestinationId = animationId, Name = weaponAIData.PreFireAnimation })
		end

		if  weaponAIData.PreFireDuration then
			wait( CalcEnemyWait( enemy, weaponAIData.PreFireDuration, { MinWaitTime = weaponAIData.PreFireMinWaitTime }), enemy.AIThreadName )
		end

		if not CanAttack({ Id = enemy.ObjectId }) then
			return false
		end
		if weaponAIData.FireAnimation then
			SetAnimation({ DestinationId = animationId, Name = weaponAIData.FireAnimation })
		end
		if weaponAIData.FireFxOnSelf then
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.FireFxOnSelf })
		end
		if weaponAIData.FireFxAtTarget then
			CreateAnimation({ DestinationId = targetId, Name = weaponAIData.FireFxAtTarget })
		end

		if weaponAIData.AttackSlots ~= nil then
			ProcessAttackSlots( enemy, weaponAIData, currentRun, targetId )
		else
			FireWeaponFromUnit({ Weapon = weaponAIData.WeaponName, Id = enemy.ObjectId, DestinationId = targetId, AutoEquip = true })
		end

		wait( CalcEnemyWait( enemy, fireCooldown), enemy.AIThreadName )
	end

	if weaponAIData.WaitUntilProjectileDeath then
		enemy.AINotifyName = "ProjectilesDead"..enemy.ObjectId
		NotifyOnProjectilesDead({ Name = weaponAIData.WaitUntilProjectileDeath, Notify = enemy.AINotifyName })
		waitUntil( enemy.AINotifyName )
	else
		wait( CalcEnemyWait( enemy, weaponAIData.FireDuration, { MinWaitTime = weaponAIData.FireDurationMinWaitTime }), enemy.AIThreadName )
	end

	if weaponAIData.RemoveUnitCollisionDuringAttack or weaponAIData.AddUnitCollisionDuringAttack then
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = defaultCollideWithUnits })
	end
	if weaponAIData.AddProjectileCollisionDuringAttack then
		SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = defaultStopsProjectiles })
	end

	if enemy.ForcedWeaponInterrupt ~= nil and (WeaponData[enemy.WeaponName] == nil or not WeaponData[enemy.WeaponName].BlockInterrupt)  then
		SetAnimation({ DestinationId = animationId, Name = GetThingDataValue({ Id = enemy.ObjectId, Property = "Graphic" }) })
		return true
	end

	if ReachedAIStageEnd(enemy) or currentRun.CurrentRoom.InStageTransition then
		weaponAIData.ForcedEarlyExit = true
		return true
	end

	-- Post-attack recover window
	if weaponAIData.ReloadingLoopSound ~= nil then
		enemy.ReloadSoundId = PlaySound({ Name = weaponAIData.ReloadingLoopSound, Id = enemy.ObjectId })
	end
	if weaponAIData.PostAttackAnimation then
		SetAnimation({ DestinationId = animationId, Name = weaponAIData.PostAttackAnimation })
	end
	if weaponAIData.FireFxOnSelf then
		StopAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.FireFxOnSelf })
	end

	if weaponAIData.PostAttackDurationMin ~= nil and weaponAIData.PostAttackDurationMax ~= nil then
		local waitTime = RandomFloat(weaponAIData.PostAttackDurationMin, weaponAIData.PostAttackDurationMax)
		wait( CalcEnemyWait( enemy, waitTime), enemy.AIThreadName )
	else
		wait( CalcEnemyWait( enemy, weaponAIData.PostAttackDuration, { MinWaitTime = weaponAIData.PostAttackMinWaitTime }), enemy.AIThreadName )
	end
	StopSound({ Id = enemy.ReloadSoundId, Duration = 0.2 })

	return true

end

function ProcessAttackSlots( enemy, weaponAIData, currentRun, targetId )
	local enemyOriginalPosition = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, Group = "Scripting" })
	local targetOriginalPosition = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = targetId, Group = "Scripting" })
	local numAttacks = weaponAIData.AttackSlotsPerTick or RandomInt(weaponAIData.AttackSlotsPerTickMin, weaponAIData.AttackSlotsPerTickMax)

	local attackSlots = DeepCopyTable(weaponAIData.AttackSlots)
	local removeNum = TableLength(weaponAIData.AttackSlots) - numAttacks
	local skipIndexes = {}
	for k = 1, removeNum, 1 do
		table.insert(skipIndexes, RemoveRandomKey(attackSlots))
	end

	local randomAngle = nil
	if weaponAIData.UseRandomAngle then
		randomAngle = RandomFloat(0, 360)
	end

	for k, attackSlot in ipairs(weaponAIData.AttackSlots) do
		if not Contains(skipIndexes, k) then
			local angle = attackSlot.Angle or randomAngle or 0
			if attackSlot.UseAngleBetween then
				angle = GetAngleBetween({ Id = enemyOriginalPosition, DestinationId = targetOriginalPosition })
			end
			if attackSlot.UseAttackerAngle then
				angle = GetAngle({ Id = enemy.ObjectId })
			end
			angle = angle + (attackSlot.OffsetAngle or 0)
			local offset = CalcOffset(math.rad(angle), attackSlot.OffsetDistance or 0)
			if attackSlot.OffsetX ~= nil then
				offset.X = offset.X + attackSlot.OffsetX
			end
			if attackSlot.OffsetY ~= nil then
				offset.Y = offset.Y + attackSlot.OffsetY
			end

			local anchor = targetOriginalPosition
			if attackSlot.OffsetFromAttacker then
				anchor = enemy.ObjectId
			end
			if attackSlot.TeleportToId then
				Teleport({ Id = enemy.ObjectId, DestinationId = attackSlot.TeleportToId })
			end
			if attackSlot.UseMapObjectId then
				if type(attackSlot.UseMapObjectId) == "table" then
					anchor = attackSlot.UseMapObjectId[currentRun.CurrentRoom.Name]
				else
					anchor = attackSlot.UseMapObjectId
				end
			end
			if attackSlot.UseTargetPosition then
				anchor = targetId
			end
			if attackSlot.AnchorAngleOffset ~= nil then
				local anchorOffset = CalcOffset(math.rad(angle + 90), attackSlot.AnchorAngleOffset)
				offset.X = offset.X + anchorOffset.X
				offset.Y = offset.Y + anchorOffset.Y
			end
			if attackSlot.OffsetScaleY ~= nil then
				offset.Y = offset.Y * attackSlot.OffsetScaleY
			end
			local targetOffset = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = anchor, OffsetX = offset.X, OffsetY = offset.Y })

			if attackSlot.InstantAngleTowardsTarget then
				AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = targetOffset })
			end

			wait( CalcEnemyWait( enemy, weaponAIData.AttackSlotPreFireWait or 0.01), enemy.AIThreadName )
			FireWeaponFromUnit({ Weapon = weaponAIData.WeaponName, Id = enemy.ObjectId, DestinationId = targetOffset, AutoEquip = true })
			Destroy({ Id = targetOffset })
			if attackSlot.PauseDuration then
				wait( CalcEnemyWait( enemy, attackSlot.PauseDuration), enemy.AIThreadName )
			end
			wait( CalcEnemyWait( enemy, weaponAIData.AttackSlotInterval or 0.01), enemy.AIThreadName )

			if ReachedAIStageEnd(enemy) then
				weaponAIData.ForcedEarlyExit = true
				return true
			end
		end
	end
	Destroy({ Id = enemyOriginalPosition })
	Destroy({ Id = targetOriginalPosition })
end

function MoveToRandomLocation( enemy, originId, radius, radiusMin, timeout )
	-- Move to a random location
	local randomOffsetX = RandomFloat( radiusMin or 0, radius )
	local randomOffsetY = RandomFloat( radiusMin or 0, radius )
	if CoinFlip() then
		randomOffsetX = randomOffsetX * -1
	end
	if CoinFlip() then
		randomOffsetY = randomOffsetY * -1
	end
	local randomNewTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = originId, OffsetX = randomOffsetX, OffsetY = randomOffsetY, Group = "Standing" })
	Move({ Id = enemy.ObjectId, DestinationId = randomNewTargetId, Mode = "Precise" })

	-- Wait until within range of target positon
	enemy.AINotifyName = "WithinDistance"..enemy.ObjectId

	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = randomNewTargetId, Distance = 50, Notify = enemy.AINotifyName, Timeout = timeout or 3.0 })
	waitUntil( enemy.AINotifyName )

	Destroy({ Id = randomNewTargetId })
end

function DumbFireAttack( enemy, currentRun, weaponData )
	local weaponName = weaponData.Name

	local weaponAIData = ShallowCopyTable(enemy.DefaultAIData) or enemy
	if weaponData ~= nil then
		if weaponData.AIData ~= nil then
			OverwriteTableKeys( weaponAIData, weaponData.AIData)
		else
			OverwriteTableKeys( weaponAIData, weaponData)
		end
	end
	weaponAIData.WeaponName = weaponName

	if weaponAIData.CancelIfNoComboPartner and (enemy.ComboPartnerId == nil or ActiveEnemies[enemy.ComboPartnerId] == nil or ActiveEnemies[enemy.ComboPartnerId].IsDead ) then
		return
	end

	if weaponAIData.CancelOutsideDistanceFromComboPartner and GetDistance({ Id = enemy.ObjectId, DestinationId = enemy.ComboPartnerId }) > weaponAIData.CancelOutsideDistanceFromComboPartner then
		return

	end

	local preAttackDuration = weaponAIData.PreAttackDuration
	if weaponAIData.PreAttackDurationMin ~= nil and weaponAIData.PreAttackDurationMax ~= nil then
		preAttackDuration = RandomFloat(weaponAIData.PreAttackDurationMin, weaponAIData.PreAttackDurationMax)
	end
	wait( CalcEnemyWait( enemy, preAttackDuration ), enemy.AIThreadName )
	local timesFired = 0
	while IsAIActive( enemy, currentRun ) do
		local targetId = GetTargetId(enemy, weaponAIData)

		local fireTicks = weaponAIData.FireTicks or 1
		if weaponAIData.AIFireTicksMin ~= nil and weaponAIData.AIFireTicksMax ~= nil then
			fireTicks = RandomInt( weaponAIData.AIFireTicksMin, weaponAIData.AIFireTicksMax )
		end

		if targetId ~= nil then
			for fireTick = 1, fireTicks, 1 do
				if enemy[weaponAIData.EndOnFlagName] then
					break
				end
				if weaponAIData.ResetTargetPerTick then
					targetId = GetTargetId(enemy, weaponAIData)
				end
				if weaponAIData.AngleToHero then
					AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = targetId })
				end

				if weaponAIData.FireFxAtTarget ~= nil then
					CreateAnimation({ DestinationId = targetId, Name = weaponAIData.FireFxAtTarget })
				end

				if weaponAIData.FireFunctionName ~= nil then
					local fireFunction = _G[weaponAIData.FireFunctionName]
					fireFunction(enemy, weaponAIData, currentRun)
				end

				if weaponAIData.AttackSlots ~= nil then
					ProcessAttackSlots( enemy, weaponAIData, currentRun,  targetId)
				else
					FireWeaponFromUnit({ Weapon = weaponName, Id = enemy.ObjectId, DestinationId = targetId, AutoEquip = true })
				end
				wait( CalcEnemyWait( enemy, weaponAIData.FireCooldown), enemy.AIThreadName )
			end
		end

		timesFired = timesFired + 1
		if weaponAIData.EndDumbFireOnTimesFired ~= nil and timesFired >= weaponAIData.EndDumbFireOnTimesFired then
			break
		end


		local fireInterval = weaponAIData.FireInterval
		if weaponAIData.FireIntervalMin ~= nil and weaponAIData.FireIntervalMax ~= nil then
			fireInterval = RandomFloat( weaponAIData.FireIntervalMin, weaponAIData.FireIntervalMax )
		end

		wait( CalcEnemyWait( enemy, fireInterval), enemy.AIThreadName )

		if fireInterval == nil then
			break
		end

		if enemy[weaponAIData.EndOnFlagName] then
			break
		end

	end
end

function AttackRandomLocation( enemy, currentRun )
	local radius = enemy.AIAttackDistance or 500

	local randomNewTargetId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, OffsetX = RandomFloat(-radius, radius), OffsetY = RandomFloat(-radius, radius), Group = "Standing" })

	AttackOnce(enemy, currentRun, randomNewTargetId)

	Destroy({ Id = randomNewTargetId })
end

function AttackAndDie( enemy, currentRun )
	wait( CalcEnemyWait( enemy, 0.1), enemy.AIThreadName )

	local aiData = ShallowCopyTable(enemy.DefaultAIData) or enemy
	if WeaponData[enemy.WeaponName] ~= nil and WeaponData[enemy.WeaponName].AIData ~= nil then
		OverwriteTableKeys( aiData, WeaponData[enemy.WeaponName].AIData)
	end
	aiData.WeaponName = enemy.WeaponName

	if enemy.DisplayAttackTimer then
		local attackDuration = aiData.PreAttackDuration
		thread( HandleAttackTimer, enemy, attackDuration )
	end

	local targetId = GetTargetId( enemy, aiData )
	AttackOnce( enemy, currentRun, targetId, aiData )
	Kill( enemy )
end

function HandleAttackTimer( enemy, attackDuration )
	local offsetY = enemy.AttackTimerOffsetY or -150

	local textBoxAnchor = SpawnObstacle({ Name = "BlankObstacle", Group = "Combat_UI_World", DestinationId = enemy.ObjectId, OffsetY = offsetY })
	enemy.AttackTimerId = textBoxAnchor
	Attach({ Id = textBoxAnchor, DestinationId = enemy.ObjectId, OffsetY = offsetY - 20 })
	CreateTextBox({ Id = textBoxAnchor, Text = attackDuration, FontSize = 18, Font = "AlegreyaSansSCBold",
			ShadowOffset = {0, 2}, ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset = {0, 4}, OutlineThickness = 2, OutlineColor = {0.0, 0.0, 0.0,1}, AutoSetDataProperties = false })

	for i = 1, attackDuration do
		local timeRemaining = attackDuration - i + 1
		ModifyTextBox({ Id = textBoxAnchor, Text = timeRemaining, ScaleTarget = 1.5, ColorTarget = Color.Orange })
		ModifyTextBox({ Id = textBoxAnchor, ScaleTarget = 1.0, ScaleDuration = 0.35, ColorTarget = Color.White, ColorDuration = 0.35, Delay = 0.15 })
		PlaySound({ Name = "/Leftovers/Menu Sounds/MenuButtonOn2", Id = textBoxAnchor })
		if timeRemaining == enemy.AttackTimerEndThreshold then
			if enemy.AttackTimerEndSound ~= nil then
				PlaySound({ Name = enemy.AttackTimerEndSound, Id = enemy.ObjectId })
			end
			if enemy.AttackTimerEndShake then
				Shake({ Id = enemy.ObjectId, Speed = 350, Distance = 5, Duration = enemy.AttackTimerEndThreshold })
			end
		end
		wait( CalcEnemyWait( enemy, 1.0), enemy.AIThreadName )
	end

	Destroy({ Id = textBoxAnchor })
end

function SpawnerAI(enemy, currentRun)
	local spawnBurstDelay = enemy.SpawnBurstDelay or 5.0
	local spawnsPerBurst = enemy.SpawnsPerBurst or 3
	local spawnRate = enemy.SpawnRate or 0.5
	local spawnRadius = enemy.SpawnRadius or 300
	local spawnDelay = enemy.SpawnDelay or 0

	local enemyId = enemy.ObjectId
	local spawnGroupName = "Spawner"..enemyId

	while IsAIActive( enemy, currentRun ) do
		local originalColor = enemy.Color

		for i=1, spawnsPerBurst do
			if NumAlive({ Name = spawnGroupName }) < enemy.MaxActiveSpawns then

				if enemy.SpawnSound ~= nil then
					PlaySound({ Name = enemy.SpawnSound, Id = enemy.ObjectId })
				end
				if enemy.SpawnColor ~= nil then
					SetColor({ Color = enemy.SpawnColor, Id = enemy.ObjectId })
				end

				if enemy.CreateSpawnAnimation then
					SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.CreateSpawnAnimation })
				end

				wait( CalcEnemyWait( enemy, spawnDelay), enemy.AIThreadName )

				-- Spawn enemy
				local spawnName = GetRandomValue(enemy.SpawnerOptions)

				local enemyData = EnemyData[spawnName]
				local newEnemy = DeepCopyTable( enemyData )
				ClearLootDrops( newEnemy )
				newEnemy.SkipChallengeKillCounts = true

				local offsetX = RandomInt(-spawnRadius, spawnRadius)
				local offsetY = RandomInt(-spawnRadius, spawnRadius)
				newEnemy.ObjectId = SpawnUnit({ Name = spawnName, Group = "Standing", DestinationId = enemy.ObjectId, OffsetX = offsetX, OffsetY = offsetY, ForceToValidLocation = true, DoActivatePresentation = false })
				local charmDuration = GetCharmDuration({ Id = enemy.ObjectId })

				if enemy.SpawnedUnitAnimation ~= nil then
					CreateAnimation({ Name = enemy.SpawnedUnitAnimation, DestinationId = newEnemy.ObjectId, Scale = 1.0 })
					newEnemy.SpawnedUnitAnimation = enemy.SpawnedUnitAnimation
				end

				if enemy.SpawnedAggroTetherDistance ~= nil then
					newEnemy.AggroTetherId = enemyId
					newEnemy.AggroTetherDistance = enemy.SpawnedAggroTetherDistance
				end
				SetupEnemyObject( newEnemy, CurrentRun )
				AddToGroup({ Id = newEnemy.ObjectId, Name = spawnGroupName })
				newEnemy.SkipActiveCount = true
				if charmDuration > 0 then
					ApplyEffectFromWeapon({ Id = currentRun.Hero.ObjectId, DestinationId = newEnemy.ObjectId, AutoEquip = true, WeaponName = "AphroditeCharmWeapon", EffectName = "Charm", Duration = charmDuration })
				end
				wait( CalcEnemyWait( enemy, spawnRate - spawnDelay), enemy.AIThreadName )
			end
		end

		if enemy.PostCreateSpawnAnimation then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.PostCreateSpawnAnimation })
		end
		if enemy.SpawnColor ~= nil then
			SetColor({ Color = originalColor, Id = enemy.ObjectId, Duration = enemy.PostAttackCooldown })
		end

		wait( CalcEnemyWait( enemy, spawnBurstDelay), enemy.AIThreadName )
	end
end

function ClearLootDrops( enemyData )
	enemyData.MoneyDropOnDeath = nil
	enemyData.MoneyDropOnHit = nil
	enemyData.AmmoDropOnDeath = nil
end

function GardenerAI( enemy, currentRun ) -- Wanders around and plants stuff
	local wanderDistance = enemy.AIWanderDistance or 500

	local enemyId = enemy.ObjectId
	local spawnGroupName = "Spawner"..enemyId
	while IsAIActive( enemy, currentRun ) do
		if not enemy.IsLastEnemy then
			local numAlive = TableLength( RequiredKillEnemies )
			if numAlive == 1 and GetRemainingSpawns(currentRun, currentRun.CurrentRoom, currentRun.CurrentRoom.Encounter) == 0 then
				if enemy.LastEnemyDataOverrides ~= nil then
					OverwriteTableKeys(enemy, enemy.LastEnemyDataOverrides)
					enemy.IsLastEnemy = true
				end
			end
		end

		-- Retreat if player is too close
		local distanceToPlayer = GetDistance({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId })
		if distanceToPlayer < enemy.AIRetreatDistance then
			Retreat(enemy, enemy, currentRun.Hero.ObjectId)
		elseif distanceToPlayer > enemy.AIMaxDistanceFromPlayer then
			MoveWithinRange( enemy, currentRun.Hero.ObjectId )
		else
			MoveToRandomLocation(enemy, enemy.ObjectId, wanderDistance)
		end

		wait( CalcEnemyWait( enemy, 0.2), enemy.AIThreadName )

		-- Drop
		LayDrop( enemy, enemy, currentRun )

	end
end

function BlendInAI( enemy, currentRun )

	local aiData = enemy.DefaultAIData or enemy
	local firstLoop = true

	local weaponAIData = ShallowCopyTable(enemy.DefaultAIData) or enemy
	if WeaponData[enemy.WeaponName] ~= nil and WeaponData[enemy.WeaponName].AIData ~= nil then
		OverwriteTableKeys( weaponAIData, WeaponData[enemy.WeaponName].AIData)
	end
	weaponAIData.WeaponName = enemy.WeaponName

	while IsAIActive( enemy, currentRun ) do
		enemy.ForcedWeaponInterrupt = nil
		
		-- Teleportation
		if weaponAIData.TeleportToSpawnPoints then
			HandleEnemyTeleportation(enemy, weaponAIData, currentRun, targetId)
		end

		-- Find target to blend with
		local targetId = GetTargetId(enemy, weaponAIData)

		local blendWithId = 0
		if enemy.BlendWithRandom then
			blendWithId = GetRandomValue( GetIdsByType({ Name = aiData.BlendWithNames }) )
		else
			blendWithId = GetClosestUnitOfType({ Id = targetId, DestinationNames = aiData.BlendWithNames, MinDistance = aiData.BlendMinDistance, Distance = aiData.BlendMaxDistance })
		end
		if blendWithId > 0 then

			while true do
				-- Move to target
				Move({ Id = enemy.ObjectId, DestinationId = blendWithId, SuccessDistance = aiData.MoveSuccessDistance })

				-- Wait until within range
				enemy.AINotifyName = "WithinDistance"..enemy.ObjectId
				local timeout = aiData.AttackWhileMovingInterval
				if timeout == nil and aiData.AttackWhileMovingIntervalMin ~= nil and aiData.AttackWhileMovingIntervalMax ~= nil then
					timeout = RandomFloat(aiData.AttackWhileMovingIntervalMin, aiData.AttackWhileMovingIntervalMax)
				end
				NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = blendWithId, Distance = aiData.MoveSuccessDistance,
					StopsUnits = aiData.AIRequireUnitLineOfSight, StopsProjectiles = aiData.AIRequireProjectileLineOfSight,
					LineOfSightBuffer = aiData.AILineOfSightBuffer,
					LineOfSightEndBuffer = aiData.AILineOfSighEndBuffer,
					Notify = enemy.AINotifyName, Timeout = timeout })
				waitUntil( enemy.AINotifyName, enemy.AIThreadName )

				Stop({ Id = enemy.ObjectId })
				if _eventTimeoutRecord[enemy.AINotifyName] then
					if enemy.LayDrop then
						LayDrop( enemy, aiData, currentRun )
					else
						AttackOnce( enemy, currentRun, targetId, weaponAIData )
					end
				else
					-- Reached goal
					break
				end

				if not IsAlive({ Id = blendWithId }) then
					-- Target was killed
					blendWithId = GetClosestUnitOfType({ Id = enemy.ObjectId, DestinationNames = aiData.BlendWithNames, MinDistance = aiData.BlendMinDistance, Distance = aiData.BlendMaxDistance })
					if blendWithId == 0 then
						-- No other target to switch to
						break
					end
				end

			end

			wait( CalcEnemyWait( enemy, aiData.BlendInTime), enemy.AIThreadName )
		else
			-- No target found
			MoveToRandomLocation( enemy, enemy.ObjectId, aiData.AIWanderDistance, aiData.AIWanderDistanceMin )
			wait( CalcEnemyWait( enemy, 0.02), enemy.AIThreadName )
		end

		local blendTimeout = RandomFloat( aiData.BlendTimeoutMin, aiData.BlendTimeoutMax )
		if aiData.AttackWhileBlending then
			blendTimeout = RandomFloat( aiData.AttackWhileBlendingIntervalMin, aiData.AttackWhileBlendingIntervalMax )
		end

		-- Wait for player to come close as long as you're not the last alive
		local consecutiveAttacks = 0
		while TableLength( RequiredKillEnemies ) > 1 and (weaponAIData.MaxConsecutiveAttacks == nil or consecutiveAttacks < weaponAIData.MaxConsecutiveAttacks) do
			consecutiveAttacks = consecutiveAttacks + 1

			enemy.AINotifyName = "WithinDistance"..enemy.ObjectId
			NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = GetTargetId( enemy, aiData ), Distance = aiData.AIRetreatDistance, Notify = enemy.AINotifyName, Timeout = blendTimeout })
			waitUntil( enemy.AINotifyName )

			if _eventTimeoutRecord[enemy.AINotifyName] then
				if enemy.LayDrop then
					LayDrop( enemy, aiData, currentRun )
				else
					AttackOnce( enemy, currentRun, targetId, weaponAIData )
				end
			else
				-- Reached goal
				break
			end
		end

		-- Lay drop when you start moving again
		if weaponAIData.AttackOnMoveStart or TableLength( RequiredKillEnemies ) <= 1 then
			if enemy.LayDrop then
				LayDrop( enemy, aiData, currentRun )
			else
				AttackOnce( enemy, currentRun, targetId, weaponAIData )
			end
			wait( CalcEnemyWait( enemy, aiData.PostAttackOnMoveStartWait), enemy.AIThreadName )
		end

		firstLoop = false

	end

end

function LayDrop( enemy, aiData, currentRun )

	local spawnGroupName = "Spawner"..enemy.ObjectId
	enemy.Spawns = enemy.Spawns or {}

	if aiData.MaxActiveSpawns == nil or NumAlive({ Name = spawnGroupName }) < aiData.MaxActiveSpawns then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.PreLayDropAnimation })
		wait( CalcEnemyWait( enemy, aiData.PreAttackDuration), enemy.AIThreadName )

		local newEnemy = nil
		if aiData.SpawnDropAsUnit then
			newEnemy = DeepCopyTable( EnemyData[aiData.DropName] )
			newEnemy.ObjectId = SpawnUnit({ Name = aiData.DropName, Group = "Standing", DestinationId = enemy.ObjectId })
			SetupEnemyObject( newEnemy, CurrentRun )
		elseif aiData.SpawnDropAsConsumable then
			local consumableId = SpawnObstacle({ Name = aiData.DropName, DestinationId = enemy.ObjectId, Group = "Standing" })
			newEnemy = CreateConsumableItem( consumableId, aiData.DropName )
			ApplyUpwardForce({ Id = consumableId, Speed = RandomFloat( 500, 700 ) })
			ApplyForce({ Id = consumableId, Speed = RandomFloat( 75, 560 ), Angle = RandomFloat( 0, 360 ) })
		else
			newEnemy = DeepCopyTable( ObstacleData[aiData.DropName] )
			newEnemy.ObjectId = SpawnObstacle({ Name = aiData.DropName, Group = "Standing", DestinationId = enemy.ObjectId })
		end
		AddToGroup({ Id = newEnemy.ObjectId, Name = spawnGroupName })
		enemy.Spawns[newEnemy.ObjectId] = newEnemy
		SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.LayDropAnimation })

		if aiData.DropOffsetZ ~= nil then
			AdjustZLocation({ Id = newEnemy.ObjectId, Distance = aiData.DropOffsetZ })
		end
		if aiData.DropUpwardForce ~= nil then
			ApplyUpwardForce({ Id = newEnemy.ObjectId, Speed = aiData.DropUpwardForce })
		end
		if aiData.DropScaleInDuration ~= nil then
			SetScale({ Id = newEnemy.ObjectId, Fraction = 0.0, Duration = 0.0 })
			SetScale({ Id = newEnemy.ObjectId, Fraction = 1.0, Duration = aiData.DropScaleInDuration })
		end

	end
	wait( CalcEnemyWait( enemy, enemy.PostAttackDuration), enemy.AIThreadName )

end

function MineAI( enemy, currentRun )

	if enemy.TriggerDistance ~= nil then
		local enemyId = enemy.ObjectId
		enemy.AINotifyName = "WithinDistance"..enemyId
		NotifyWithinDistance({ Id = enemyId, DestinationId = currentRun.Hero.ObjectId, Distance = enemy.TriggerDistance, Notify = enemy.AINotifyName, Timeout = enemy.ExpirationDuration })
		waitUntil( enemy.AINotifyName )
	end

	if _eventTimeoutRecord[enemy.AINotifyName] then
		SetAnimation({ DestinationId = enemy.ObjectId, Name = "BloodMineDeactivated" })
		wait( CalcEnemyWait( enemy, 0.5), enemy.AIThreadName )
		SetAlpha({ Id = enemy.ObjectId, Fraction = 0.0, Duration = 1.0 })
		wait( CalcEnemyWait( enemy, 1.0), enemy.AIThreadName )
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "OnDeathWeapon", Value = nil })
		SetLifeProperty({ DestinationId = enemy.ObjectId, Property = "DeathSound", Value = nil })
		Kill( enemy )
	else
		ActivateFuse( enemy )
	end
end

function SkyAttackerAI( enemy, currentRun )

	if enemy.WakeUpDelay ~= nil or (enemy.WakeUpDelayMin ~= nil and enemy.WakeUpDelayMax ~= nil) then
		local wakeUpDelay = enemy.WakeUpDelay or RandomFloat(enemy.WakeUpDelayMin, enemy.WakeUpDelayMax)
		wait( CalcEnemyWait( enemy, wakeUpDelay ), enemy.AIThreadName )
	end

	while IsAIActive( enemy, currentRun ) do
		if not CanAttack({ Id = enemy.ObjectId }) then
			enemy.AINotifyName = "CanAttack"..enemy.ObjectId
			NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
			waitUntil( enemy.AINotifyName )
		end
		enemy.WeaponName = SelectWeapon( enemy )
		--DebugAssert({ Condition = enemy.WeaponName ~= nil, Text = "Enemy has no weapon!" })
		table.insert(enemy.WeaponHistory, enemy.WeaponName)

		local weaponAIData = GetWeaponAIData(enemy)

		local targetId = GetTargetId(enemy, weaponAIData)

		if targetId ~= nil and targetId ~= 0 then
			ClearEffect({ Id = enemy.ObjectId, Name = "HermesSlow" })
			if weaponAIData.ResetSkyAttackSound ~= nil then
				PlaySound({ Name = weaponAIData.ResetSkyAttackSound, Id = enemy.ObjectId })
			end
			if weaponAIData.LaunchAnimation ~= nil then
				SetAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.LaunchAnimation })
			end
			if weaponAIData.StopAnimationsOnLaunch ~= nil then
				StopAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.StopAnimationsOnLaunch })
			end
			if weaponAIData.ShadowAnimationGroundName ~= nil then
				StopAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.ShadowAnimationGroundName })
			end
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.ShadowAnimationFadeOutName })

			ApplyUpwardForce({ Id = enemy.ObjectId, Speed = 5000 })
			wait( 0.5, enemy.AIThreadName )
			enemy.BlockingLocation = false
			enemy.InSky = true
			IgnoreGravity({ Id = enemy.ObjectId })
			SetAlpha({ Id = enemy.ObjectId, Fraction = 0.0 })
			SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsUnits", Value = false })
			SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = false })

			-- Disapear
			local hideDuration = weaponAIData.PostLaunchHideDuration or RandomFloat(weaponAIData.PostLaunchHideDurationMin, weaponAIData.PostLaunchHideDurationMax)
			wait( CalcEnemyWait( enemy,weaponAIData.PostLaunchHideDuration, { IgnoreSpeedMultiplier = true }), enemy.AIThreadName )
			Teleport({ Id = enemy.ObjectId, DestinationId = targetId })
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = weaponAIData.ShadowAnimationFadeInName })
			wait( CalcEnemyWait( enemy,weaponAIData.PostLaunchHideFadeInDuration, { IgnoreSpeedMultiplier = true }), enemy.AIThreadName )


			-- Pre-Attack Movement
			if weaponAIData.RetreatBeforeAttack then
				Retreat(enemy, weaponAIData, targetId)
				wait( CalcEnemyWait( enemy, 0.05), enemy.AIThreadName )
			end

			-- Movement
			MoveWithinRange( enemy, weaponAIData.MoveToId or targetId, weaponAIData )

			while weaponAIData.WaitIfBlockedDistance ~= nil and IsLocationBlockedWithinDistance( enemy, weaponAIData.WaitIfBlockedDistance ) do
				Retreat( enemy, weaponAIData, targetId )
				wait( CalcEnemyWait( enemy, RandomFloat(weaponAIData.WaitIfBlockedDurationMin or 0.5, weaponAIData.WaitIfBlockedDurationMax or 5.0)), enemy.AIThreadName )
				MoveWithinRange( enemy, weaponAIData.MoveToId or targetId, weaponAIData )
			end

			if weaponAIData.PreAttackVoiceLines ~= nil then
				thread( PlayVoiceLines, weaponAIData.PreAttackVoiceLines, nil, enemy )
			end

			-- Attack
			local attackSuccess = false
			while not attackSuccess do
				enemy.BlockingLocation = true
				enemy.InSky = false
				ObeyGravity({ Id = enemy.ObjectId })
				SetAlpha({ Id = enemy.ObjectId, Fraction = 1.0 })
				SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsUnits", Value = true })
				SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = true })

				-- @experiment Snap isometric
				local currentAngle = GetAngle({ Id = enemy.ObjectId })
				if currentAngle > 90 and currentAngle < 270 then
					SetGoalAngle({ Id = enemy.ObjectId, Angle = 210, CompleteAngle = true })
				else
					SetGoalAngle({ Id = enemy.ObjectId, Angle = 330, CompleteAngle = true })
				end

				Stop({ Id = enemy.ObjectId })
				Halt({ Id = enemy.ObjectId })
				attackSuccess = AttackOnce( enemy, currentRun, targetId, weaponAIData )
				if not attackSuccess then
					enemy.AINotifyName = "CanAttack"..enemy.ObjectId
					NotifyOnCanAttack({ Id = enemy.ObjectId, Notify = enemy.AINotifyName, Timeout = 9.0 })
					waitUntil( enemy.AINotifyName )
				end
			end
		else
			if enemy.NoTargetMoveTowardsPlayer then
				MoveWithinRange( enemy, CurrentRun.Hero.ObjectId, weaponAIData )
			end
			wait( CalcEnemyWait( enemy, enemy.NoTargetWanderDuration or 0.5), enemy.AIThreadName )
		end
	end
end

function IsLocationBlockedWithinDistance( source, distance )
	for enemyId, enemy in pairs( ActiveEnemies ) do
		if enemy.BlockingLocation and enemy.ObjectId ~= source.ObjectId then
			if GetDistance({ Id = enemy.ObjectId, DestinationId = source.ObjectId }) < distance then
				return true
			end
		end
	end
	return false
end

function PickupAI( enemy, currentRun )

	wait(CalcEnemyWait(enemy, enemy.WakeDelay), enemy.AIThreadName)

	while IsAIActive( enemy, currentRun ) do
		if enemy.RetreatBeforePickup then
			Retreat(enemy, enemy, currentRun.Hero.ObjectId)
		end

		local pickupSuccess = DoPickup( enemy, enemy, currentRun )

		if pickupSuccess then
			return
		else
			local duration = enemy.PickupAttemptCooldown or 1
			wait(CalcEnemyWait(enemy, duration), enemy.AIThreadName)
		end
	end
end

function DoPickup( enemy, weaponAIData, currentRun )
	weaponAIData = weaponAIData or enemy
	local pickupTarget = nil
	local pickupRange = weaponAIData.AIPickupRange or 100
	enemy.Pickups = enemy.Pickups or 0

	local eligibleTargets = GetIdsByType({ Names = weaponAIData.AIPickupType })
	pickupTarget = GetRandomValue(eligibleTargets)
	enemy.PickupTarget = MapState.ActiveObstacles[pickupTarget]

	local forceFailTime = nil
	if weaponAIData.PickupTimeAllowance ~= nil then
		forceFailTime = _worldTime + weaponAIData.PickupTimeAllowance
	end

	while IsAlive({ Id = pickupTarget }) and pickupTarget ~= nil do
		-- Move to target
		Move({ Id = enemy.ObjectId, DestinationId = pickupTarget, Distance = 10, Mode = "Precise" })

		if weaponAIData.MoveToTargetSound ~= nil then
			PlaySound({ Name = weaponAIData.MoveToTargetSound, Id = enemy.ObjectId })
		end
		if weaponAIData.MoveToTargetText ~= nil then
			thread( InCombatText, enemy.ObjectId, enemy.MoveToTargetText, 1.5 )
		end

		-- Wait until within range
		enemy.AINotifyName = "WithinDistance"..enemy.ObjectId

		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = pickupTarget, Distance = pickupRange, Notify = enemy.AINotifyName, Timeout = weaponAIData.MoveToPickupTimeout or 5.0 })
		waitUntil( enemy.AINotifyName )
		if _eventTimeoutRecord[enemy.AINotifyName] then
			-- Remove collision for next attempt if timed out
			DebugPrint({ Text = "Pickup timeout" })
			SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithObstacles", Value = false })
			SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = false })
			enemy.PickupTarget = nil
			return false
		end

		-- Begin pick up
		SetThingProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToForce", Value = true })
		local endTime = _worldTime + weaponAIData.AIPickupTime
		if IsAlive({ Id = pickupTarget }) then
			Stop({ Id = enemy.ObjectId })
			Shake({ Id = enemy.ObjectId, Distance = 3, Speed = 500, Duration = weaponAIData.AIPickupTime })
			Flash({ Id = enemy.ObjectId, Speed = 1.0, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = weaponAIData.AIPickupTime, ExpireAfterCycle = true })
			thread( PlayVoiceLines, enemy.RespawningVoiceLines, true )
			if weaponAIData.BeginPickupSound ~= nil then
				PlaySound({ Name = weaponAIData.BeginPickupSound, Id = weaponAIData.ObjectId })
			end
			if weaponAIData.BeginPickupText ~= nil then
				thread( InCombatText, enemy.ObjectId, weaponAIData.PickupText, weaponAIData.AIPickupTime )
			end
			if weaponAIData.BeginPickupAnimation ~= nil then
				SetAnimation({ Name = weaponAIData.BeginPickupAnimation, DestinationId = enemy.ObjectId })
			end

			if enemy.PickupTarget ~= nil and enemy.PickupTarget.BeginPickupAnimation then
				SetAnimation({ Name = enemy.PickupTarget.BeginPickupAnimation, DestinationId = pickupTarget })
			end

			while _worldTime < endTime do
				if not IsAlive({ Id = pickupTarget }) or not CanAttack({ Id = enemy.ObjectId }) then
					StopFlashing({ Id = enemy.ObjectId })
					if weaponAIData.PickupFailedAnimation ~= nil then
						SetAnimation({ Name = weaponAIData.PickupFailedAnimation, DestinationId = enemy.ObjectId })
					end
					if enemy.PickupTarget ~= nil and enemy.PickupTarget.PickupFailedAnimation then
						SetAnimation({ Name = enemy.PickupTarget.PickupFailedAnimation, DestinationId = enemy.PickupTarget.ObjectId })
					end
					enemy.PickupTarget = nil
					return false
				end
				wait( CalcEnemyWait( enemy, 0.1 ), enemy.AIThreadName )
			end

			-- Pick up
			if IsAlive({ Id = pickupTarget }) then
				if weaponAIData.PickupSound ~= nil then
					PlaySound({ Name = weaponAIData.PickupSound, Id = enemy.ObjectId })
				end
				if weaponAIData.PickupText ~= nil then
					thread( InCombatText, enemy.ObjectId, weaponAIData.PickupText, 1.75 )
				end
				if weaponAIData.PickupFx ~= nil then
					CreateAnimation({ Name = weaponAIData.PickupFx, DestinationId = enemy.ObjectId })
				end
				Flash({ Id = enemy.ObjectId, Speed = 0.65, MinFraction = 1.0, MaxFraction = 0, Color = Color.Gold, ExpireAfterCycle = true })

				ProcessPickup( enemy, pickupTarget )
				Destroy({ Id = pickupTarget })
				enemy.Pickups = enemy.Pickups + 1
				enemy.PickupTarget = nil
				return true
			else
				SetThingProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToForce", Value = false })
			end
		end

		if forceFailTime ~= nil and _worldTime >= forceFailTime then
			enemy.PickupTarget = nil
			return false
		end
	end

	enemy.PickupTarget = nil
	return false
end

function ProcessPickup(enemy, pickupTarget)
	if MapState.ActiveObstacles[pickupTarget] == nil then
		return
	end

	local pickupType = MapState.ActiveObstacles[pickupTarget].Name
	local pickupData = ObstacleData[pickupType] or ConsumableData[pickupType]

	if pickupData == nil then
		DebugPrint({ Text = pickupType.." had no obstacle data" })
		return
	end

	if pickupData.SwapToUnitOnPickup ~= nil then
		local oldEnemy = enemy
		local newEnemyName = pickupData.SwapToUnitOnPickup
		if enemy.IsSuperElite and EnemyData[newEnemyName.."SuperElite"] ~= nil then
			newEnemyName = newEnemyName.."SuperElite"
		elseif enemy.IsElite and EnemyData[newEnemyName.."Elite"] ~= nil then
			newEnemyName = newEnemyName.."Elite"
		end
		local newEnemy =  DeepCopyTable( EnemyData[newEnemyName] )
		newEnemy.ObjectId = SpawnUnit({ Name = newEnemyName, InheritGroupNames = true, DestinationId = oldEnemy.ObjectId, DoActivatePresentation = false })
		SetupEnemyObject( newEnemy, CurrentRun )
		local charmDuration = GetCharmDuration({ Id = oldEnemy.ObjectId })
		if charmDuration > 0 then
			ApplyEffectFromWeapon({ Id = CurrentRun.Hero.ObjectId, DestinationId = newEnemy.ObjectId, AutoEquip = true, WeaponName = "AphroditeCharmWeapon", EffectName = "Charm", Duration = charmDuration })
		end
		thread( PlayVoiceLines, oldEnemy.RespawnedVoiceLines, true )
		RemoveOnDeathWeapons( oldEnemy )
		Kill( oldEnemy )
	end

	if pickupData.IsEnemyWeapon and CurrentRun.CurrentRoom.WeaponSpawnPointsUsed ~= nil then
		CurrentRun.CurrentRoom.WeaponSpawnPointsUsed[pickupTarget] = nil
	end

	if pickupData.AddWeaponOptionOnPickup ~= nil then
		table.insert(enemy.WeaponOptions, pickupData.AddWeaponOptionOnPickup)
	end
	if pickupData.AddEquipmentOnPickup ~= nil then
		table.insert(enemy.Equipment, pickupData.AddEquipmentOnPickup)
	end
	if pickupData.AddHealthBuffer ~= nil then
		if enemy.HealthBuffer == 0 then
			DoEnemyHealthBuffered( enemy )
			ArmorRestoredPresentation(enemy)
		end
		enemy.HealthBuffer = (enemy.HealthBuffer or 0) + pickupData.AddHealthBuffer
	end

	if pickupData.AttachAnimation ~= nil then
		CreateAnimation({ Name = pickupData.AttachAnimation, DestinationId = enemy.ObjectId })
	end
end

function IsPickupAvailable(CurrentRun, enemy, pickupName)
	local pickupIds = GetIdsByType({ Name = pickupName })
	if IsEmpty(pickupIds) then
		return false
	end

	pickupData = ObstacleData[pickupName]
	if pickupData == nil then
		return true -- No restrictions
	end

	if pickupData.RequireNoHealthBuffer ~= nil and enemy.HealthBuffer > 0 then
		return false
	end

	return true
end

function ReflectiveShieldUnitAI(enemy, currentRun)

	while not enemy.IsDead do
		MoveToRandomLocation( enemy, enemy.ObjectId, enemy.WanderDistanceMax, enemy.WanderDistanceMin, nil )

		Stop({ Id = enemy.ObjectId })
		Shake({ Id = enemy.ObjectId, Speed = 350, Distance = 2, Duration = enemy.PreReflectDuration })
		if enemy.PreAttackColor ~= nil then
			SetColor({ Color = enemy.PreAttackColor, Id = enemy.ObjectId, Duration = enemy.PreReflectDuration / 3 })
		end
		if enemy.PreAttackSound ~= nil then
			PlaySound({ Name = enemy.PreAttackSound, Id = enemy.ObjectId })
		end

		wait( CalcEnemyWait( enemy, enemy.PreReflectDuration), enemy.AIThreadName )

		SetLifeProperty({ DestinationId = enemy.ObjectId, Property = "Reflection", Value = 1.0, DataValue = false })
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.ReflectAnimation })
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId })

		wait( CalcEnemyWait( enemy, enemy.ReflectDuration), enemy.AIThreadName )

		SetLifeProperty({ DestinationId = enemy.ObjectId, Property = "Reflection", Value = 0.0, DataValue = false })
		SetAnimation({ DestinationId = enemy.ObjectId, Name = enemy.IdleAnimation })

		Shake({ Id = enemy.ObjectId, Speed = 350, Distance = 2, Duration = enemy.PostReflectDuration })
		wait( CalcEnemyWait( enemy, enemy.PostReflectDuration), enemy.AIThreadName )
	end
end

function IllusionistSplit( enemy, weaponAIData, currentRun )
	local spawnGroupName = "Spawner"..enemy.ObjectId

	RemoveEnemyUI( enemy )
	enemy.HasHealthBar = false

	local numAttacks = weaponAIData.AttackSlotsPerTick or RandomInt(weaponAIData.AttackSlotsPerTickMin, weaponAIData.AttackSlotsPerTickMax)
	local attackSlots = DeepCopyTable(weaponAIData.AttackSlots)
	local removeNum = TableLength(weaponAIData.AttackSlots) - numAttacks
	for k = 1, removeNum, 1 do
		local value = RemoveRandomValue(attackSlots)
	end
	local realSlot = RandomInt(1, numAttacks)
	for k, attackSlot in pairs(attackSlots) do
		local offset = CalcOffset(math.rad(attackSlot.Angle or 0), attackSlot.OffsetDistance or 0)
		if attackSlot.OffsetScaleY then
			offset.Y = offset.Y * attackSlot.OffsetScaleY
		end
		local targetOffset = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, OffsetX = offset.X, OffsetY = offset.Y })

		if k ~= realSlot then
			local enemyData = EnemyData.IllusionistClone
			local newEnemy = DeepCopyTable( enemyData )
			newEnemy.SkipChallengeKillCounts = true

			newEnemy.ObjectId = SpawnUnit({ Name = weaponAIData.SpawnedUnit, Group = "Standing", DestinationId = targetOffset, DoActivatePresentation = false, ForceToValidLocation = true })

			SetupEnemyObject( newEnemy, CurrentRun )
			AddToGroup({ Id = newEnemy.ObjectId, Name = spawnGroupName })
			newEnemy.SkipActiveCount = true

			if newEnemy.EliteIcon or ( newEnemy.HealthBuffer ~= nil and newEnemy.HealthBuffer > 0 ) then
				CreateHealthBar( newEnemy )
				UpdateHealthBar( newEnemy, 0, { Force = true })
				newEnemy.Outline.Id = newEnemy.ObjectId
				AddOutline( newEnemy.Outline )
			end
		else
			Teleport({ Id = enemy.ObjectId, DestinationId = targetOffset })
		end

		Destroy({ Id = targetOffset })
		wait( CalcEnemyWait( enemy, 0.01), enemy.AIThreadName )
	end
end

function HydraHeadSpawn( enemy )
	local encounter = CurrentRun.CurrentRoom.Encounter
	table.insert(encounter.HydraHeads, enemy.ObjectId)
	SetUnitInvulnerable( ActiveEnemies[GetClosestUnitOfType({ Id = enemy.ObjectId, DestinationName = "HydraHeadImmortal" }) ] )
end

function HydraHeadDeath( enemy )
	local encounter = CurrentRun.CurrentRoom.Encounter
	RemoveValue(encounter.HydraHeads, enemy.ObjectId)
	if IsEmpty(encounter.HydraHeads) then
		SetUnitVulnerable( ActiveEnemies[GetClosestUnitOfType({ Id = enemy.ObjectId, DestinationName = "HydraHeadImmortal" }) ] )
	end
end

function SetupHadesSpawnOptions( enemy )
	local enemySetPrefix = "EnemiesHades"
	if GetNumMetaUpgrades(enemy.ShrineMetaUpgradeName) >= 4 then
		enemySetPrefix = "EnemiesHadesEM"
	end
	enemy.SpawnOptions = {}

	local spawnOptionsLarge = EnemySets[enemySetPrefix.."Large"]
	local spawnOptionsSmall = EnemySets[enemySetPrefix.."Small"]

	table.insert(enemy.SpawnOptions, GetRandomValue(spawnOptionsLarge))
	table.insert(enemy.SpawnOptions, GetRandomValue(spawnOptionsSmall))
	table.insert(enemy.SpawnOptions, GetRandomValue(spawnOptionsSmall))
end

function RetreatThenDieAI(enemy, currentRun)
	Retreat(enemy, enemy, CurrentRun.Hero.ObjectId)
	if enemy.PostRetreatFlash then
		Flash({ Id = enemy.ObjectId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.White, Duration = enemy.PostRetreatDuration, ExpireAfterCycle = true })
	end
	wait( CalcEnemyWait( enemy, enemy.PostRetreatDuration ), RoomThreadName )
	Kill( enemy )
end

function Retreat( enemy, aiData, retreatFromId )
	local distanceBetween = GetDistance({ Id = enemy.ObjectId, DestinationId = retreatFromId })
	local retreatDistance = aiData.AIBufferDistance - distanceBetween
	local angleBetween = GetAngleBetween({ Id = retreatFromId, DestinationId = enemy.ObjectId})
	local retreatAngle = angleBetween + RandomFloat(-0.5, 0.5)
	local retreatOffset = CalcOffset( math.rad(retreatAngle), retreatDistance)

	local tempTarget = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = enemy.ObjectId, OffsetX = retreatOffset.X, OffsetY = retreatOffset.Y, Group = "Standing" })
	local moveToId = tempTarget
	if aiData.RetreatToSpawnPoints then
		local spawnNearId = tempTarget
		if aiData.RetreatToSpawnPointFromSelf then
			spawnNearId = enemy.ObjectId
		end
		moveToId = SelectSpawnPoint(CurrentRun.CurrentRoom, { Name = aiData.Name, RequiredSpawnPoint = aiData.RetreatToSpawnPointType }, { SpawnNearId = spawnNearId, SpawnRadius = aiData.RetreatToSpawnPointRadiusMax, SpawnRadiusMin = aiData.MoveToSpawnPointRadiusMin } )
		--moveToId = GetClosest({ Id = tempTarget, DestinationName = "SpawnPoints" })
	end
	Move({ Id = enemy.ObjectId, DestinationId = moveToId })

	-- Wait until within range
	local timeout = aiData.RetreatTimeout
	if timeout == nil and aiData.RetreatTimeoutMin ~= nil and aiData.RetreatTimeoutMax ~= nil then
		timeout = RandomFloat(aiData.RetreatTimeoutMin, aiData.RetreatTimeoutMax)
	end

	enemy.AINotifyName = "WithinDistance"..enemy.ObjectId
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = moveToId, Distance = 50, Notify = enemy.AINotifyName, Timeout = timeout or 5.0 })
	waitUntil( enemy.AINotifyName, enemy.AIThreadName )

	Destroy({ Id = tempTarget })
end

function ThanatosPostCombat( enemy, currentRun )
	enemy.PostCombatTravel = true
	local moveToId = SelectLootSpawnPoint(CurrentRun.CurrentRoom) or currentRun.Hero.ObjectId
	local distanceToTarget = GetDistance({ Id = enemy.ObjectId, DestinationId = moveToId })

	if distanceToTarget > enemy.PostCombatTeleportIfPastDistance then
		ThanatosTeleportToExit( enemy, moveToId )
	else
		Move({ Id = enemy.ObjectId, DestinationId = moveToId, Mode = "Precise" })
		enemy.AINotifyName = "WithinDistance"..enemy.ObjectId
		NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = moveToId, Distance = 100, Notify = enemy.AINotifyName, Timeout = 10.0 })
		waitUntil( enemy.AINotifyName, enemy.AIThreadName )
	end

	Stop({ Id = enemy.ObjectId })
	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId })

	-- Thanatos challenge bonus reward
	enemy.AINotifyName = "WithinDistance"..enemy.ObjectId
	NotifyWithinDistance({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId, Distance = 400, Notify = enemy.AINotifyName, Timeout = 10.0 })
	waitUntil( enemy.AINotifyName, enemy.AIThreadName )
	enemy.PostCombatTravel = false
	HandleThanatosEncounterReward(enemy)
end

function HandleBossSpawns( enemy, weaponAIData, currentRun )
	local enemyId = enemy.ObjectId
	local spawnGroupName = weaponAIData.SpawnGroupName or "Spawner"..enemyId
	local spawnRadius = weaponAIData.SpawnRadius or 100
	local spawnOptions = weaponAIData.SpawnOptions or enemy.SpawnOptions
	spawnOptions = ShallowCopyTable(spawnOptions)
	local spawnCount = weaponAIData.SpawnCount
	enemy.BossSpawnsUses = enemy.BossSpawnsUses or 0

	if weaponAIData.SpawnClones then
		spawnOptions = {}
		table.insert(spawnOptions, enemy.Name)
	end

	if GetActiveEnemyCount() >= currentRun.CurrentRoom.Encounter.ActiveEnemyCap then
		return
	end

	if weaponAIData.MaxActiveSpawns ~= nil and TableLength(GetIds({ Name = spawnGroupName })) >= weaponAIData.MaxActiveSpawns then
		return
	end

	local spawns = {}
	if spawnCount == nil and weaponAIData.DifficultyRating ~= nil then
		local difficultyRating = weaponAIData.DifficultyRating
		if weaponAIData.DifficultyRatingIncreasePerUse ~= nil then
			difficultyRating = difficultyRating + (weaponAIData.DifficultyRatingIncreasePerUse * enemy.BossSpawnsUses)
		end
		local totalDifficultyRating = 0
		while totalDifficultyRating < difficultyRating do
			local spawnName = GetRandomValue(spawnOptions)
			local enemyData = EnemyData[spawnName]
			local enemyDifficultyRating = enemyData.GeneratorData.DifficultyRating or 1

			if totalDifficultyRating + enemyDifficultyRating > difficultyRating then
				RemoveValue(spawnOptions, spawnName)
				if IsEmpty( spawnOptions ) then
					break
				end
			else
				totalDifficultyRating = totalDifficultyRating + enemyDifficultyRating
				table.insert( spawns, spawnName )
			end
		end
		spawnCount = #spawns
	end

	for i=1, spawnCount do
		local spawnName = spawns[i] or GetRandomValue(spawnOptions)

		local enemyData = EnemyData[spawnName]
		local newEnemy = DeepCopyTable( enemyData )
		newEnemy.SkipChallengeKillCounts = true
		newEnemy.PreferredSpawnPoint = nil

		local spawnPointId = 0
		if weaponAIData.SpawnOnSelf then
			spawnPointId = enemy.ObjectId
		else
			spawnPointId = SelectSpawnPoint(currentRun.CurrentRoom, newEnemy, {SpawnNearId = enemy.ObjectId, SpawnRadius = weaponAIData.SpawnRadius })
		end
		if spawnPointId == nil or spawnPointId == 0 then
			--DebugPrint({ Text="No eligible spawn points to continue spawning "..enemy.Name.."'s enemies!" })
			return
		end
		newEnemy.ObjectId = SpawnUnit({ Name = spawnName, Group = "Standing", DestinationId = spawnPointId, ForceToValidLocation = true, DoActivatePresentation = weaponAIData.DoSpawnsActivatePresentation })
		newEnemy.OccupyingSpawnPointId = spawnPointId
		newEnemy.AggroReactionTimeMin = weaponAIData.SpawnAggroReactionTimeMin or newEnemy.AggroReactionTimeMin
		currentRun.CurrentRoom.SpawnPointsUsed[spawnPointId] = newEnemy.ObjectId

		if weaponAIData.SpawnClones then
			newEnemy.IsClone = true
			SetAlpha({ Id = newEnemy.ObjectId, Fraction = weaponAIData.CloneAlphaFraction or 0.4 })
		end

		if weaponAIData.SpawnAggroed then
			newEnemy.StartAggroed = true
		end

		if weaponAIData.SpawnDefaultAIDataOverrides ~= nil then
			if weaponAIData.SpawnSkipOverridesForTypes == nil or not Contains(weaponAIData.SpawnSkipOverridesForTypes, newEnemy.Name) then
				OverwriteTableKeys(newEnemy.DefaultAIData, weaponAIData.SpawnDefaultAIDataOverrides)
			end
		end

		if weaponAIData.SpawnDataOverrides ~= nil then
			if weaponAIData.SpawnSkipOverridesForTypes == nil or not Contains(weaponAIData.SpawnSkipOverridesForTypes, newEnemy.Name) then
				OverwriteTableKeys(newEnemy, weaponAIData.SpawnDataOverrides)
			end
		end

		SetupEnemyObject( newEnemy, CurrentRun )
		AddToGroup({ Id = newEnemy.ObjectId, Name = spawnGroupName })
		--newEnemy.SkipActiveCount = true

		if weaponAIData.SpawnClones then
			newEnemy.MaxHealth = 1
			newEnemy.Health = 1
			newEnemy.HealthBuffer = 1
		end

		wait( CalcEnemyWait( enemy, weaponAIData.SpawnInterval ), RoomThreadName )
		if enemy.IsDead then
			return
		end

		if GetActiveEnemyCount() >= currentRun.CurrentRoom.Encounter.ActiveEnemyCap then
			return
		end
	end

	local spawnGroupIds = GetIds({ Name = spawnGroupName })
	if weaponAIData.HealInterval and weaponAIData.HealPerTick then
		while IsAlive({ Ids = spawnGroupIds }) do
			Heal( enemy, { HealAmount = weaponAIData.HealPerTick, SourceName = "BossSpawnHeal", Silent = true } )
			thread( UpdateHealthBar, enemy )
			wait( CalcEnemyWait( enemy, weaponAIData.HealInterval ), RoomThreadName )
		end
	end

	enemy.BossSpawnsUses = enemy.BossSpawnsUses + 1
end

function EnemyInvisibility( enemy, weaponAIData, currentRun, args )
	args = args or {}

	weaponAIData.InvisibilityInterval = weaponAIData.InvisibilityInterval or 0
	enemy.LastInvisibilityTime = enemy.LastInvisibilityTime or 0

	if _worldTime - enemy.LastInvisibilityTime >= weaponAIData.InvisibilityInterval then

		ClearEffect({ Id = enemy.ObjectId, All = true })
		SetLifeProperty({ DestinationId = enemy.ObjectId, Property = "InvulnerableFx", Value = nil })
		enemy.SkipInvulnerableOnHitPresentation = true

		local alpha = args.Alpha or 0.0
		local color = args.Color or { 0, 0, 0, 0 }

		SetAlpha({ Id = enemy.ObjectId, Fraction = alpha, Duration = weaponAIData.InvisibilityFadeOutDuration })
		SetColor({ Id = enemy.ObjectId, Color = color, Duration = weaponAIData.InvisibilityFadeOutDuration })

		if args.CreateAnimation then
			CreateAnimation({ Name = args.CreateAnimation, DestinationId = enemy.ObjectId })
		end
		if args.Animation then
			SetAnimation({ Name = args.Animation, DestinationId = enemy.ObjectId })
		end
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = false })
		SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = false })
		enemy.PreInvisibilityImmuneToStun = GetUnitDataValue({ Id = enemy.ObjectId, Property = "ImmuneToStun" })
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToStun", Value = true })
		SetUnitInvulnerable( enemy )
		wait( weaponAIData.InvisibilityFadeOutDuration, enemy.AIThreadName )
		if enemy.Phase2VFX ~= nil then
  			StopAnimation({ Name = enemy.Phase2VFX, DestinationId = enemy.ObjectId })
		end
		enemy.IsInvisible = true
		enemy.LastInvisibilityTime = _worldTime
		if not enemy.UseBossHealthBar then
			local enemyId = enemy.ObjectId
			if EnemyHealthDisplayAnchors[enemyId.."elitebadge"] then
				Destroy({ Id = EnemyHealthDisplayAnchors[enemyId.."elitebadge"]})
			end
			if enemy.EliteAttributes ~= nil then
				for k, attributeName in pairs(enemy.EliteAttributes) do
					if EnemyHealthDisplayAnchors[enemyId.."elitebadge"..attributeName] then
						Destroy({ Id = EnemyHealthDisplayAnchors[enemyId.."elitebadge"..attributeName]})
					end
				end
			end

			local toDestroy = {}
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."back"] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."health"] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."armorIcon"] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."vulnerabilityIndicator"] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."falloff"] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."freezestatus"] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."poisonstatus"] )
			table.insert( toDestroy, EnemyHealthDisplayAnchors[enemyId.."rupturestatus"] )
			if EnemyHealthDisplayAnchors[enemyId.."status"] ~= nil then
				for k, v in pairs( EnemyHealthDisplayAnchors[enemyId.."status"] ) do
					table.insert( toDestroy, v )
				end
			end
			EnemyHealthDisplayAnchors[enemyId.."status"] = nil
			EnemyHealthDisplayAnchors[enemyId.."freezestatus"] = nil
			EnemyHealthDisplayAnchors[enemyId.."poisonstatus"] = nil
			EnemyHealthDisplayAnchors[enemyId.."rupturestatus"] = nil

			if EnemyHealthDisplayAnchors[enemyId.."storedAmmo"] ~= nil then
				for k, v in pairs( EnemyHealthDisplayAnchors[enemyId.."storedAmmo"] ) do
					table.insert( toDestroy, v.Id )
				end
			end
			EnemyHealthDisplayAnchors[enemyId.."storedAmmo"] = nil

			if EnemyHealthDisplayAnchors[enemyId.."shieldIcons"] ~= nil then
				for k, v in pairs( EnemyHealthDisplayAnchors[enemyId.."shieldIcons"] ) do
					table.insert( toDestroy, v )
				end
			end
			EnemyHealthDisplayAnchors[enemyId.."shieldIcons"] = nil

			DestroyTextBox({ Ids = toDestroy })
			Destroy({ Ids = toDestroy })
			enemy.HasHealthBar = false
		end
		
		if weaponAIData.PostInvisibilityFunction ~= nil then
			local postInvisibilityFunction = _G[weaponAIData.PostInvisibilityFunction]
			postInvisibilityFunction( enemy, weaponAIData, currentRun, args )
		end
		AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = currentRun.Hero.ObjectId })
	end
end

function HadesTeleport( enemy, weaponAIData, currentRun )
	local teleportPoints = GetIds({ Name = weaponAIData.TeleportationPointsGroupName })
	local teleportPointId = GetRandomValue( teleportPoints )
	RemoveValue( teleportPoints, GetClosest({ Id = enemy.ObjectId, DestinationIds = teleportPoints }))

	Teleport({ Id = enemy.ObjectId , DestinationId = teleportPointId })
	local postTeleportWaitDuration = RandomFloat(weaponAIData.PostTeleportWaitDurationMin, weaponAIData.PostTeleportWaitDurationMax)
	wait( CalcEnemyWait( enemy, postTeleportWaitDuration ), enemy.AIThreadName )

end

function EnemyHandleInvisibleAttack( enemy, weaponAIData, currentRun, args )
	args = args or {}
	if enemy.IsInvisible and not weaponAIData.KeepInvisibility then
		if enemy.CurrentPhase ~= nil and enemy.CurrentPhase >= 2 and enemy.Phase2VFX ~= nil then
  			CreateAnimation({ Name = enemy.Phase2VFX, DestinationId = enemy.ObjectId })
		end
  	
		SetLifeProperty({ DestinationId = enemy.ObjectId, Property = "InvulnerableFx", Value = "Invincibubble_Hades" })
		enemy.IsInvisible = false
		CreateHealthBar( enemy )
		UpdateHealthBar( enemy, 0, { Force = true })

		if enemy.ActiveEffects and enemy.ActiveEffects.MarkRuptureTarget then
			UpdateRuptureEffectStacks({ TriggeredByTable = enemy, triggeredById = enemy.ObjectId })
		end
		if enemy.InvisibilityEndSound ~= nil then
			PlaySound({ Name = enemy.InvisibilityEndSound })
		end
		SetUnitVulnerable( enemy )
		SetAlpha({ Id = enemy.ObjectId, Fraction = 1.0, Duration = weaponAIData.InvisibilityFadeInDuration })
		SetColor({ Id = enemy.ObjectId, Color = { 255, 255, 255, 255 }, Duration = weaponAIData.InvisibilityFadeInDuration })
		if args.CreateAnimation then
			CreateAnimation({ Name = args.CreateAnimation, DestinationId = enemy.ObjectId })
		end
		if args.Animation then
			CreateAnimation({ Name = args.Animation, DestinationId = enemy.ObjectId })
		end
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "CollideWithUnits", Value = true })
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "ImmuneToStun", Value = enemy.PreInvisibilityImmuneToStun })
		SetThingProperty({ DestinationId = enemy.ObjectId, Property = "StopsProjectiles", Value = true })
		enemy.SkipInvulnerableOnHitPresentation = false
		wait( CalcEnemyWait( enemy, weaponAIData.InvisibilityFadeInDuration ), enemy.AIThreadName )
	end
end

function HandGrabOnHit( victim, victimId, triggerArgs )
	SetUnitProperty({ DestinationId = triggerArgs.AttackerId, Property = "CollideWithUnits", Value = false })
	Halt({ Id = triggerArgs.AttackerId })
	Teleport({ Id =triggerArgs.AttackerId , DestinationId = victimId, OffsetY = 10 })
end

function TeleportBehindTarget( enemy, weaponAIData, currentRun )
	local targetFacingAngle = GetAngle({ Id = weaponAIData.LastTargetId })
	local offset = CalcOffset( math.rad(targetFacingAngle), weaponAIData.TeleportBehindTargetDistance or -100 )
	local teleportPointId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = weaponAIData.LastTargetId, OffsetX = offset.X, OffsetY = offset.Y, ForceToValidLocation = true })
	Teleport({ Id = enemy.ObjectId , DestinationId = teleportPointId })
	wait(0.01)
	AngleTowardTarget({ Id = enemy.ObjectId, DestinationId = weaponAIData.LastTargetId })
	wait(0.01)
end

function HandleHarpyRage(enemy, currentRun)
	if ScreenAnchors.BossRageFill == nil then
		CreateBossRageMeter(enemy)
	end
	local screenId = ScreenAnchors.BossRageFill
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1.0, DestinationId = screenId })
	enemy.RageFraction = enemy.RageFraction or 0

	local rageDecayInterval = 1.0
	local rageDecayRate = enemy.RageDecayRate or 0.01

	while not enemy.IsDead and not enemy.PermanentEnraged do
		wait( rageDecayInterval )
		if enemy.RageFraction > 0 and _worldTime - enemy.LastRageGainTime > enemy.RageDecayStartDuration then
			enemy.RageFraction = enemy.RageFraction - rageDecayRate
			SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1 - enemy.RageFraction, DestinationId = screenId })
		end
	end
end

function EnrageUnit(enemy, currentRun, startDelay)
	wait( startDelay )
	if not IsAlive({ Id = enemy.ObjectId }) then
		return
	end

	DebugPrint({ Text = "Enraging: "..enemy.Name })
	if enemy.EnragedMoveSpeedBonus ~= nil then
		enemy.MoveSpeedReset = GetUnitDataValue({ Id = enemy.ObjectId, Property = "Speed" })
		local enragedMoveSpeed = enemy.EnragedMoveSpeedBonus + enemy.MoveSpeedReset
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "Speed", Value = enragedMoveSpeed })
	end

	enemy.Enraged = true
	if enemy.EnragedPresentation ~= nil then
		local enrageFunction = _G[enemy.EnragedPresentation]
		enrageFunction(enemy, currentRun)
	end

	wait( enemy.EnragedDuration )

	if enemy.PermanentEnraged then
		local notifyName = enemy.ObjectId.."PermanentEnraged"
		NotifyOnAllDead({ Ids = { enemy.ObjectId }, Notify = notifyName })
		waitUntil( notifyName )
		AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	else
		EndEnemyEnrage(enemy, currentRun)
	end
end

function EndEnemyEnrage(enemy, currentRun)
	local screenId = ScreenAnchors.BossRageFill
	enemy.Enraged = false
	StopFlashing({ Id = screenId })
	AdjustColorGrading({ Name = "Off", Duration = 0.45 })
	if enemy.RageExpiredSound ~= nil then
		PlaySound({ Name = enemy.RageExpiredSound })
	end
	if enemy.RageExpiredVoiceLines ~= nil then
		thread( PlayVoiceLines, enemy.RageExpiredVoiceLines, nil, enemy )
	end
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 1.0, DestinationId = screenId })
	if enemy.EnragedMoveSpeedBonus ~= nil then
		SetUnitProperty({ DestinationId = enemy.ObjectId, Property = "Speed", Value = enemy.MoveSpeedReset })
	end
end

function HarpyBuildRage( enemy, weaponAIData, currentRun )
	if enemy.Enraged or IsInvulnerable({ Id = enemy.ObjectId }) then
		return
	end

	ShakeScreen({ Speed = 300, Distance = 3, FalloffSpeed = 2000, Duration = 1.0 })
	Flash({ Id = ScreenAnchors.BossRageFill, Speed = 3.0, MinFraction = 0, MaxFraction = 0.8, Color = Color.Yellow })

	local hitsTaken = 0

	for tick = 1, weaponAIData.BuildRageTicks, 1 do
		if enemy.RageHit then
			enemy.RageHit = nil
			hitsTaken = hitsTaken + 1
		end

		if hitsTaken >= 3 then
			if weaponAIData.EarlyBreakAnimation ~= nil then
				SetAnimation({ Id = enemy.ObjectId, Name = weaponAIData.EarlyBreakAnimation })
			end
			StopFlashing({ Id = ScreenAnchors.BossRageFill })
			wait( CalcEnemyWait( enemy, weaponAIData.EarlyBreakStunDuration ), enemy.AIThreadName )
			return
		end

		local meterAmount = 0.01
		BuildRageMeter(currentRun, meterAmount, enemy)
		if enemy.Enraged or IsInvulnerable({ Id = enemy.ObjectId }) then
			if not enemy.Enraged then
				StopFlashing({ Id = ScreenAnchors.BossRageFill })
			end
			if weaponAIData.BuildRageEndAnimation ~= nil then
				SetAnimation({ Id = enemy.ObjectId, Name = weaponAIData.BuildRageEndAnimation })
			end
			wait( CalcEnemyWait( enemy, weaponAIData.BuildRageEndDuration ), enemy.AIThreadName )
			return
		end
		wait( CalcEnemyWait( enemy, weaponAIData.BuildRageTicksInterval ), enemy.AIThreadName )
	end
	if weaponAIData.BuildRageEndAnimation ~= nil then
		SetAnimation({ Id = enemy.ObjectId, Name = weaponAIData.BuildRageEndAnimation })
	end
	StopFlashing({ Id = ScreenAnchors.BossRageFill })
	wait( CalcEnemyWait( enemy, weaponAIData.BuildRageEndDuration ), enemy.AIThreadName )
end

function EnrageHarpyPermanent(enemy, currentRun)
	enemy.Enraged = true
	enemy.PermanentEnraged = true
	SetAnimationFrameTarget({ Name = "EnemyHealthBarFillBoss", Fraction = 0.0, DestinationId = ScreenAnchors.BossRageFill })
	EnrageUnit(enemy, currentRun)
end

function ShadeHunkerDown( enemy, weaponAIData, currentRun )
	wait(0.05)
	local enemyAngle = GetAngle({ Id = enemy.ObjectId })
	local offset = CalcOffset(math.rad(enemyAngle), 100)
	local shieldId = SpawnObstacle({ Name = "ShadeShieldBunker", DestinationId = enemy.ObjectId, OffsetX = offset.X, OffsetY = offset.Y, Group = "Standing" })
	SetAngle({ Id = shieldId, Angle = enemyAngle })
	wait(weaponAIData.FireDuration - 0.05)
	Destroy({ Id = shieldId })
end

function RetaliateAttack( enemy, attacker )
	if attacker == nil then
		return
	end

	if enemy.RetailiateOnce and enemy.Retaliating then
		return
	end
	enemy.Retaliating = true

	enemy.WeaponName = SelectWeapon( enemy )
	--DebugAssert({ Condition = enemy.WeaponName ~= nil, Text = "Enemy has no weapon!" })
	table.insert(enemy.WeaponHistory, enemy.WeaponName)

	local weaponAIData = GetWeaponAIData(enemy)

	AttackOnce(enemy, CurrentRun, attacker.ObjectId, weaponAIData)

	enemy.Retaliating = false
end

function UnstableGeneratorAI(enemy, currentRun)
	thread(HandleUnstableGeneratorEscalation, enemy, currentRun)

	-- Switch back to regular AI
	SetAI(AttackerAI, enemy, currentRun)
end

function HandleUnstableGeneratorEscalation( enemy, currentRun )
	local aiData = enemy.DefaultAIData

	while IsAIActive( enemy, currentRun ) and aiData.EscalationLevel < aiData.MaxEscalationLevel do
		wait( CalcEnemyWait( enemy, aiData.EscalationInterval), enemy.AIThreadName )

		aiData.EscalationLevel = aiData.EscalationLevel + 1

		OverwriteTableKeys( aiData, aiData.EscalationAIDataOverwrites[aiData.EscalationLevel] )

		if aiData.EscalateSound ~= nil then
			PlaySound({ Name = aiData.EscalateSound, Id = enemy.ObjectId })
		end
		if aiData.EscalateFx ~= nil then
			CreateAnimation({ DestinationId = enemy.ObjectId, Name = aiData.EscalateFx })
		end
		if aiData.EscalateAnimation ~= nil then
			SetAnimation({ DestinationId = enemy.ObjectId, Name = aiData.EscalateAnimation })
		end
	end
end

function SelectTheseusGod( enemy, run, args )
	enemy.TheseusGodName = GetUninteractedGodThisRun() or "ArtemisUpgrade" -- Default if managed to pickup every god
	LoadPackages({ Names = enemy.TheseusGodName })
end

function TheseusGodAI(enemy, currentRun)
	local theseusGodName = enemy.TheseusGodName
	enemy.WeaponName = "Theseus"..theseusGodName.."Wrath"
	enemy.GodUpgrade = theseusGodName

	-- Fire Wrath
	local weaponAIData = GetWeaponAIData(enemy)

	thread( DoTheseusSuperPresentation, enemy, weaponAIData )

	wait( 0.1 )
	AttackOnce( enemy, currentRun, GetTargetId(enemy, weaponAIData), weaponAIData)

	wait( 3.0 )
	-- Fire passive god weapon
	enemy.DumbFireWeapons = enemy.DumbFireWeapons or {}
	local dumbFireWeaponName = "Theseus"..theseusGodName.."Passive"
	table.insert(enemy.DumbFireWeapons, dumbFireWeaponName)
	ActivateDumbFireWeapons( currentRun, enemy )

	-- Switch back to regular AI
	SetAI(AttackerAI, enemy, currentRun)
end

function SelectHarpySupportAIs(enemy, currentRun)
	local shrineLevel = GetNumMetaUpgrades( enemy.ShrineMetaUpgradeName )

	enemy.SupportAINames = enemy.SupportAINames or {}

	if shrineLevel > 0 then
		local supportCount = RandomInt(1, 2)
		if TextLinesRecord.FurySistersUnion01 == nil then
			supportCount = 2
		end
		for i=1, supportCount, 1 do
			local supportAIName = RemoveRandomValue(enemy.SupportAIWeaponSetOptions)
			table.insert(enemy.SupportAINames, supportAIName)
			currentRun.SupportAINames[supportAIName] = true
		end
	end
end

function SpawnSupportAI( enemy, currentRun )
	if IsEmpty(enemy.SupportAINames) then
		return
	end

	local supportUnit = DeepCopyTable( EnemyData[enemy.SupportUnitName] )
	supportUnit.ObjectId = SpawnUnit({ Name = enemy.SupportUnitName, Group = "Standing", DestinationId = CurrentRun.Hero.ObjectId, DoActivatePresentation = false })
	supportUnit.SupportAINames = enemy.SupportAINames
	enemy.SupportAIUnitId = supportUnit.ObjectId
	SetupEnemyObject( supportUnit, CurrentRun )
end

function HarpySupportAI(enemy, currentRun)
	-- Wake up delay
	if enemy.WakeUpDelayMin ~= nil and enemy.WakeUpDelayMax ~= nil then
		enemy.WakeUpDelay = RandomFloat(enemy.WakeUpDelayMin, enemy.WakeUpDelayMax)
	end
	if enemy.WakeUpDelay then
		wait( CalcEnemyWait( enemy, enemy.WakeUpDelay), enemy.AIThreadName )
	end

	while ActiveEnemies[enemy.ObjectId] ~= nil do
		local supportAIWeaponSetName = GetRandomValue(enemy.SupportAINames)
		local weaponName = GetRandomValue(enemy.SupportAIWeaponOptions[supportAIWeaponSetName])
		if weaponName ~= nil then
			local weaponData = WeaponData[weaponName]
			local weaponAIData = ShallowCopyTable(enemy.DefaultAIData) or enemy
			if weaponData ~= nil then
				if weaponData.AIData ~= nil then
					OverwriteTableKeys( weaponAIData, weaponData.AIData)
				else
					OverwriteTableKeys( weaponAIData, weaponData)
				end
			end
			weaponAIData.WeaponName = weaponName

			local targetId = SpawnObstacle({ Name = "BlankObstacle", Group = "Scripting", DestinationId = GetTargetId(enemy, weaponAIData) })

			Teleport({ Id = enemy.ObjectId, DestinationId = targetId })
			AttackOnce( enemy, currentRun, targetId, weaponAIData )
			if weaponAIData.ForcedEarlyExit then
				SetAnimation({ DestinationId = enemy.ObjectId, Name = supportAIWeaponSetName.."MultiFurySkyDiveFadeOut" })
			end
			Destroy({ Id = targetId })
		end

		local attackRate = enemy.AttackRate or RandomFloat( enemy.AttackRateMin, enemy.AttackRateMax )
		wait( CalcEnemyWait( enemy, attackRate), enemy.AIThreadName )
	end
end

function ObstacleFollowTarget( args )
	local moveSpeed = args.MoveSpeed or 100
	local followDistance = args.FollowDistance or 300
	local bufferDistance = args.BufferDistance or 50
	while MapState.ActiveObstacles[args.ObstacleId] ~= nil do
		-- Move to player
		Move({ Id = args.ObstacleId, DestinationId = args.TargetId, Mode = "Precise", Speed = moveSpeed })

		-- Wait until within attack range
		local notifyName = "WithinDistance"..args.ObstacleId
		NotifyWithinDistance({ Id = args.ObstacleId, DestinationId = args.TargetId, Distance = followDistance, Notify = notifyName, Timeout = 5.0 })
		waitUntil( notifyName )

		Stop({ Id = args.ObstacleId })

		notifyName = "OutsideDistance"..args.ObstacleId
		NotifyOutsideDistance({ Id = args.ObstacleId, DestinationId = args.TargetId, Distance = followDistance + bufferDistance, Notify = notifyName, Timeout = 5.0 })
		waitUntil( notifyName )
	end
end

function DelayedAIDisable( enemy, delay )
	wait(delay)
	enemy.DisableAIWhenReady = true
end

-- Sets and runs an enemy's AIBehavior
function SetAI( newAI, enemy, currentRun )
	if enemy.DisableAIWhenReady then
		enemy.DisableAIWhenReady = false
		enemy.AIDisabled = true
		return
	end

	enemy.AIBehavior = newAI
	return newAI( enemy, currentRun )
end

function GetTargetId( enemy, aiData )
	aiData = aiData or enemy
	local targetId = CurrentRun.Hero.ObjectId
	if aiData.AnchorTargetIdOnPlayer and aiData.AnchorTargetId == nil then
		aiData.AnchorTargetId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = CurrentRun.Hero.ObjectId, Group = "Scripting" })
	end

	if aiData.TargetSelf then
		targetId = enemy.ObjectId

	elseif aiData.TargetId then
		targetId = aiData.TargetId

	elseif aiData.TargetComboPartner then
		targetId = enemy.ComboPartnerId

	elseif aiData.CreateOwnTarget then
		local offsetAngle = 0
		if aiData.RandomTargetAngle then
			offsetAngle = RandomFloat(0, 360)
		elseif aiData.TargetAngleOptions ~= nil then
			offsetAngle = GetRandomValue( aiData.TargetAngleOptions )
		end
		local offsetDistance = aiData.TargetOffsetDistance
		if aiData.TargetOffsetDistanceMin ~= nil and aiData.TargetOffsetDistanceMax ~= nil then
			offsetDistance = RandomFloat(aiData.TargetOffsetDistanceMin, aiData.TargetOffsetDistanceMax)
		end
		local offset = CalcOffset(math.rad(offsetAngle), offsetDistance)
		if aiData.OffsetDistanceScaleY ~= nil then
			offset.Y = offset.Y * aiData.OffsetDistanceScaleY
		end
		local newTargetId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = aiData.AnchorTargetId or enemy.ObjectId, Group = "Scripting", OffsetX = offset.X, OffsetY = offset.Y })
		targetId = newTargetId

	elseif aiData.TargetFriends or IsCharmed({ Id = enemy.ObjectId }) then
		targetId = nil
		local eligibleIds = {}
		for enemyId, requiredKillEnemy in pairs( RequiredKillEnemies ) do
			if requiredKillEnemy ~= enemy then
				if aiData.IgnoreSelfType and requiredKillEnemy.Name == enemy.Name then
					--DebugPrint({ Text = "INGORE" })
				elseif aiData.IgnoreTypes ~= nil and Contains(aiData.IgnoreTypes, requiredKillEnemy.Name) then
					--DebugPrint({ Text = "INGORE" })
				elseif aiData.IngoreCursedByThanatos and HasEffect({ Id = requiredKillEnemy.ObjectId, EffectName = "ThanatosCurse" }) then
					--DebugPrint({ Text = "INGORE" })
				elseif aiData.IgnoreInvulnerable and IsInvulnerable({ Id = requiredKillEnemy.ObjectId }) then
					--DebugPrint({ Text = "INGORE" })
				elseif requiredKillEnemy.InSky then
					--DebugPrint({ Text = "INGORE" })
				elseif not requiredKillEnemy.ActivationFinished then
					--DebugPrint({ Text = "INGORE" })
				elseif aiData.TargetWeak then
					if requiredKillEnemy.Health / requiredKillEnemy.MaxHealth < 1.0 then
						table.insert(eligibleIds, enemyId)
					end
				else
					table.insert(eligibleIds, enemyId)
				end
			end
		end
		if aiData.TargetClosest then
			targetId = GetClosest({ Id = enemy.ObjectId, DestinationIds = eligibleIds, Distance = 1500, IgnoreHomingIneligible = true, IgnoreSelf = true })
		elseif aiData.TargetClosestToPlayer then
			targetId = GetClosest({ Id = CurrentRun.Hero.ObjectId, DestinationIds = eligibleIds, Distance = 1500, IgnoreHomingIneligible = true, IgnoreSelf = true })
		elseif aiData.TargetName ~= nil then
			local ids = GetIdsByType({ Name = aiData.TargetName })
			targetId = GetRandomValue(ids)
		else
			targetId = GetRandomValue(eligibleIds)
		end

		if aiData.TargetPlayerIfNoFriends and targetId == nil then
			targetId = CurrentRun.Hero.ObjectId
		end

	elseif aiData.TargetSpawnPoints then
		targetId = SelectSpawnPoint(CurrentRun.CurrentRoom, { Name = enemy.Name }, { SpawnNearId = CurrentRun.Hero.ObjectId, SpawnRadius = aiData.TargetSpawnPointsPlayerRadius or 1000, SpawnRadiusMin = aiData.TargetSpawnPointsPlayerRadiusMin } )

	elseif aiData.TargetName ~= nil then
		local ids = GetIdsByType({ Name = aiData.TargetName })
		targetId = GetRandomValue(ids)
	elseif CurrentRun.CurrentRoom.TauntTargetId then
		targetId = CurrentRun.CurrentRoom.TauntTargetId
	elseif targetId == CurrentRun.Hero.ObjectId and CurrentRun.Hero.Invisible and CurrentRun.CurrentRoom.InvisTargetId then
		targetId = CurrentRun.CurrentRoom.InvisTargetId

		if aiData.CancelIfInvisTarget then
			targetId = nil
		end
	end

	if aiData.CreateOwnTargetFromOriginalTarget then
		local offsetAngle = 0
		if aiData.RandomTargetAngle then
			offsetAngle = RandomFloat(0, 360)
		elseif aiData.TargetAngleOptions ~= nil then
			offsetAngle = GetRandomValue( aiData.TargetAngleOptions )
		end
		local offsetDistance = aiData.TargetOffsetDistance
		if aiData.TargetOffsetDistanceMin ~= nil and aiData.TargetOffsetDistanceMax ~= nil then
			offsetDistance = RandomFloat(aiData.TargetOffsetDistanceMin, aiData.TargetOffsetDistanceMax)
		end
		local offset = CalcOffset(math.rad(offsetAngle), offsetDistance)
		local newTargetId = SpawnObstacle({ Name = "BlankObstacle", DestinationId = aiData.AnchorTargetId or targetId, Group = "Scripting", OffsetX = offset.X, OffsetY = offset.Y })
		targetId = newTargetId
	end

	if aiData.AnchorTargetIdAfterFirstTick and aiData.AnchorTargetId == nil then
		aiData.AnchorTargetId = targetId
	end

	return targetId
end

function StagedAI( enemy, currentRun )

	for k, aiStage in ipairs( enemy.AIStages ) do

		if currentRun.Hero.IsDead then
			-- Immediately cut on hero death
			return false
		end

		if aiStage.SelectRandomAIStage ~= nil then
			--DebugAssert({ Condition = TableLength(enemy[aiStage.SelectRandomAIStage]) > 0, Text = "No more AI stages to choose from" })
			local newAIStage = RemoveRandomValue(enemy[aiStage.SelectRandomAIStage])
			OverwriteTableKeys(aiStage, newAIStage)
		end

		if aiStage.SelectPactLevelAIStage ~= nil then
			local shrineLevel = GetNumMetaUpgrades( enemy.ShrineMetaUpgradeName )
			local newAIStage = enemy[aiStage.SelectPactLevelAIStage][shrineLevel] or enemy[aiStage.SelectPactLevelAIStage].Default
			if newAIStage ~= nil then
				OverwriteTableKeys(aiStage, newAIStage)
			end
		end

		if aiStage.AIData ~= nil then
			enemy.AIEndHealthThreshold = nil
			enemy.AIEndWithSpawnedEncounter = nil

			if aiStage.AIData.ThresholdOverrideIfInRoom ~= nil and currentRun.CurrentRoom.Name == aiStage.AIData.ThresholdOverrideIfInRoom.Room then
				aiStage.AIData.AIEndHealthThreshold = aiStage.AIData.ThresholdOverrideIfInRoom.Value
			end

			OverwriteTableKeys( enemy, aiStage.AIData )
		end

		if aiStage.DisableRoomTraps then
			DisableRoomTraps( )
		end

		enemy.ChainedWeapon = nil
		enemy.ForcedWeaponInterrupt = nil

		if aiStage.UnequipWeapons ~= nil then
			for k, weaponName in pairs(aiStage.UnequipWeapons) do
				RemoveValue(enemy.WeaponOptions, weaponName)
				UnequipWeapon({ Name = weaponName, DestinationId = enemy.ObjectId })
			end
		end

		if aiStage.EquipWeapons ~= nil then
			for k, weaponName in pairs(aiStage.EquipWeapons) do
				table.insert(enemy.WeaponOptions, weaponName)
				EquipWeapon({ Name = weaponName, DestinationId = enemy.ObjectId })
				--DebugPrint({ Text="EQUIPED: "..weaponName })
			end
		end

		if aiStage.EquipRandomWeapon ~= nil then
			for k, weaponName in pairs(aiStage.EquipRandomWeapon) do
				if Contains(enemy.WeaponOptions, weaponName) then
					table.remove(aiStage.EquipRandomWeapon, k)
				end
			end
			local weaponName = GetRandomValue( aiStage.EquipRandomWeapon )
			if weaponName ~= nil then
				table.insert(enemy.WeaponOptions, weaponName)
				EquipWeapon({ Name = weaponName, DestinationId = enemy.ObjectId })
			end
		end

		if aiStage.AddSupportAIWeaponOptions ~= nil then
			local supportAIUnit = ActiveEnemies[enemy.SupportAIUnitId]
			if supportAIUnit ~= nil then
				for supportAIName, addWeaponOptions in pairs(aiStage.AddSupportAIWeaponOptions) do
					ConcatTableValues( supportAIUnit.SupportAIWeaponOptions[supportAIName], aiStage.AddSupportAIWeaponOptions[supportAIName] )
				end
			end
		end

		if aiStage.SetRageWeapon ~= nil then
			enemy.RageWeapon = aiStage.SetRageWeapon
		end

		if aiStage.EnableRoomTraps then
			EnableRoomTraps()
		end

		if aiStage.NewVulnerability ~= nil then
			if aiStage.NewVulnerability then
				SetUnitVulnerable( enemy )
			else
				SetUnitInvulnerable( enemy )

			end
		end

		if aiStage.SpawnEncounter ~= nil or aiStage.SpawnEncounterByPactLevel ~= nil then
			local encounterName = aiStage.SpawnEncounter
			if aiStage.SpawnEncounterByPactLevel then
				local shrineLevel = GetNumMetaUpgrades( enemy.ShrineMetaUpgradeName )
				encounterName = aiStage.SpawnEncounterByPactLevel[shrineLevel]
			end
			local encounter = DeepCopyTable( EncounterData[encounterName] )
			if encounter.Generated then
				GenerateEncounter(CurrentRun, CurrentRun.CurrentRoom, encounter)
			end
			enemy.SpawnedEncounter = encounter
			if encounter.StartGlobalVoiceLines ~= nil then
				thread( PlayVoiceLines, GlobalVoiceLines[encounter.StartGlobalVoiceLines] )
			end
			thread( StartEncounter, currentRun, currentRun.CurrentRoom, encounter )
		end

		-- Transistion
		if aiStage.ThreadedFunctions ~= nil then
			for k, aiFunctionName in pairs(aiStage.ThreadedFunctions) do
				local aiFunction = _G[aiFunctionName]
				thread( aiFunction, enemy, currentRun )
			end
		end

		local transitionFunctionName = aiStage.TransitionFunction
		if transitionFunctionName ~= nil then
			local transitionFunction = _G[transitionFunctionName]
			transitionFunction( enemy, currentRun, aiStage )
		end

		if aiStage.PermanentlyEnrage then
			enemy.PermanentEnraged = true
			thread(EnrageUnit, enemy, currentRun)
		end

		if aiStage.ClearObstacleTypes then
			Destroy({ Ids = GetIdsByType({ Name = aiStage.ClearObstacleTypes }) })
		end

		-- Regular AI
		local aiFunctionName = GetRandomValue( aiStage.RandomAIFunctionNames )
		if aiFunctionName ~= nil then
			local aiFunction = _G[aiFunctionName]
			SetAI( aiFunction, enemy, currentRun )
		end

		if aiStage.EnableRoomTraps then
			DisableRoomTraps()
		end
	end

end

function IsAIActive( enemy, currentRun )

	if currentRun.Hero.IsDead then
		-- Immediately cut on hero death
		return false
	end

	if enemy.DisableAIWhenReady then
		enemy.AIDisabled = true
		enemy.DisableAIWhenReady = false
		return false
	end

	if enemy.IsDead then
		return false
	end

	if ReachedAIStageEnd(enemy) then
		return false
	end

	if enemy.AIDisabled then
		return false
	end

	return true

end

function ReachedAIStageEnd(enemy)
	if enemy.AIEndHealthThreshold ~= nil and enemy.Health / enemy.MaxHealth <= enemy.AIEndHealthThreshold then
		return true
	end
	if enemy.AIEndWithSpawnedEncounter ~= nil and enemy.SpawnedEncounter.Completed then
		return true
	end
	return false
end

function NumAttacksSinceWeapon( enemy, weaponName )

	if weaponName == nil or enemy == nil or enemy.WeaponHistory == nil then
		return -1
	end

	if enemy.WeaponName == weaponName then
		return 0
	end

	if WeaponData[weaponName].GenusName ~= nil then
		weaponName = WeaponData[weaponName].GenusName
	end

	local numAttacks = 1
	for i = #enemy.WeaponHistory, 1, -1 do
		local prevWeapon = enemy.WeaponHistory[i]
		local skipWeapon = false
		if WeaponData[prevWeapon] ~= nil then
			if WeaponData[prevWeapon].ChainedOnly then
				skipWeapon = true
			end
			if WeaponData[prevWeapon].GenusName ~= nil then
				prevWeapon = WeaponData[prevWeapon].GenusName
			end
		end
		if not skipWeapon then
			if prevWeapon == weaponName then
				return numAttacks
			end
			numAttacks = numAttacks + 1
		end
	end

	-- Never seen
	return -1
end

function NumConsecutiveUses( enemy, weaponName )
	if weaponName == nil or enemy == nil or enemy.WeaponHistory == nil then
		return -1
	end

	if WeaponData[weaponName].GenusName ~= nil then
		weaponName = WeaponData[weaponName].GenusName
	end

	local numAttacks = 0
	for i = #enemy.WeaponHistory, 1, -1 do
		local prevWeapon = enemy.WeaponHistory[i]
		local skipWeapon = false
		if WeaponData[prevWeapon] ~= nil then
			if WeaponData[prevWeapon].ChainedOnly then
				skipWeapon = true
			end
			if WeaponData[prevWeapon].GenusName ~= nil then
				prevWeapon = WeaponData[prevWeapon].GenusName
			end
		end
		if not skipWeapon then
			if prevWeapon == weaponName then
				numAttacks = numAttacks + 1
			else
				return numAttacks
			end
		end
	end
	return numAttacks
end

function CalcEnemyWait( enemy, duration, args )
	args = args or {}
	if duration == nil or duration <= 0 then
		return 0
	end
	if enemy.SpeedMultiplier ~= nil and not args.IgnoreSpeedMultiplier then
		duration = duration / enemy.SpeedMultiplier
	end
	if enemy.Enraged and enemy.EnragedWaitMultiplier ~= nil then
		duration = duration * enemy.EnragedWaitMultiplier
	end
	if args.MinWaitTime ~= nil and duration < args.MinWaitTime then
		--DebugPrint({ Text=enemy.WeaponName.." increased to MinWaitTime of "..args.MinWaitTime.." from "..duration })
		duration = args.MinWaitTime
	end
	return duration
end

function GetWeaponAIData(enemy)
	local weaponAIData = ShallowCopyTable(enemy.DefaultAIData) or enemy
	if WeaponData[enemy.WeaponName] ~= nil and WeaponData[enemy.WeaponName].AIData ~= nil then
		local weaponData = ShallowCopyTable(WeaponData[enemy.WeaponName].AIData)

		if WeaponData[enemy.WeaponName].ShrineAIDataOverwrites ~= nil and GetNumMetaUpgrades(WeaponData[enemy.WeaponName].ShrineMetaUpgradeName) >= WeaponData[enemy.WeaponName].ShrineMetaUpgradeRequiredLevel then
			OverwriteTableKeys( weaponData, WeaponData[enemy.WeaponName].ShrineAIDataOverwrites)
		end

		OverwriteTableKeys( weaponAIData, weaponData)
	end
	weaponAIData.WeaponName = enemy.WeaponName

	if enemy.SwapAnimations ~= nil then
		for k, v in pairs(weaponAIData) do
			if enemy.SwapAnimations[v] ~= nil then
				weaponAIData[k] = enemy.SwapAnimations[v]
			end
		end
	end

	return weaponAIData
end

function RandomizeCover( source, args )
	local coverOptions = args.CoverOptions
	local coverCount = RandomInt( args.CoverCountMin or 0, args.CoverCountMax or 0 )

	wait( args.StartWait, RoomThreadName )

	if args.ShakeScreen then
		ShakeScreen({ Speed = 300, Distance = 3, FalloffSpeed = 2000, Duration = 1.0 })
	end

	for i = 1, coverCount do
		local coverId = RemoveRandomValue(coverOptions)
		local obstacle = MapState.ActiveObstacles[coverId]
		if obstacle ~= nil and not obstacle.ToggledOn then
			if obstacle.ToggleOnAnimation ~= nil then
				SetAnimation({ DestinationId = coverId, Name = obstacle.ToggleOnAnimation })
			end
			SetThingProperty({ Property = "StopsProjectiles", Value = true, DestinationId = coverId })
			obstacle.ToggledOn = true
		end
	end
	for k, coverId in pairs(coverOptions) do
		local obstacle = MapState.ActiveObstacles[coverId]
		if obstacle ~= nil and obstacle.ToggledOn then
			if obstacle.ToggleOffAnimation ~= nil then
				SetAnimation({ DestinationId = coverId, Name = obstacle.ToggleOffAnimation })
			end
			SetThingProperty({ Property = "StopsProjectiles", Value = false, DestinationId = coverId })
			obstacle.ToggledOn = false
		end
	end

	wait( args.EndWait, RoomThreadName )
end

function CharonGhostCharge( enemy, weaponAIData, currentRun, args )

	for k, id in ipairs(args.FireFromIds) do
		thread(AttackOnce, ActiveEnemies[id], currentRun, id, ActiveEnemies[id] )
		wait( args.FireInterval, RoomThreadName )
	end
end

function PickHydraVariant( eventSource, args )
	local eligibleOptions = {}
	for k, variantName in pairs(args.Options) do
		if IsEnemyEligible(variantName, eventSource.Encounter) then
			table.insert(eligibleOptions, variantName)
		end
	end
	eventSource.HydraVariant = GetRandomValue(eligibleOptions)

	eventSource.Encounter.EnemySet = ShallowCopyTable(EnemySets.HydraHeads)
	for k, removeValue in pairs(eventSource.Encounter.BlockHeadsByHydraVariant[eventSource.HydraVariant]) do
		RemoveAllValues(eventSource.Encounter.EnemySet, removeValue)
	end
	while TableLength(eventSource.Encounter.EnemySet) > args.MaxSideHeadTypes do
		RemoveRandomValue(eventSource.Encounter.EnemySet)
	end
	CancelSpawnsOnKill = { eventSource.HydraVariant }
	eventSource.Encounter.WipeEnemiesOnKill = eventSource.HydraVariant

	for k, enemyName in pairs(eventSource.Encounter.EnemySet) do
		PreLoadBinks({ Names = EnemyData[enemyName].Binks })
	end
end

function HadesConsumeHeal(  enemy, weaponAIData, currentRun  )
	local urnsConsumed = 0
	while urnsConsumed < weaponAIData.MaxConsumptions and not IsInvulnerable({ Id = enemy.ObjectId }) do
		local urnId = GetRandomValue(GetIdsByType({ Name = "HadesTombstone" }))
		if urnId == nil or urnId == 0 then
			break
		end
		if weaponAIData.ConsumeFx ~= nil then
			CreateAnimation({ DestinationId = urnId, Name = weaponAIData.ConsumeFx })
		end
		for i=1, weaponAIData.HealTicksPerConsume do
			wait(CalcEnemyWait( enemy, weaponAIData.HealTickInterval ), enemy.AIThreadName)
			if ActiveEnemies[urnId] ~= nil and not IsInvulnerable({ Id = enemy.ObjectId }) then
				Heal( enemy, { HealAmount = weaponAIData.HealPerTick, triggeredById = enemy.ObjectId } )
				thread( UpdateHealthBar, enemy, { Force = true } )
			else
				StopAnimation({ DestinationId = urnId, Name = weaponAIData.ConsumeFx })
				break
			end
		end
		SetUnitProperty({ DestinationId = urnId, Property = "OnDeathWeapon", Value = "null" })
		StopAnimation({ DestinationId = urnId, Name = weaponAIData.ConsumeFx })
		Destroy({ Id = urnId })
		urnsConsumed = urnsConsumed + 1
		wait(CalcEnemyWait( enemy, weaponAIData.NextUrnWait ), enemy.AIThreadName)
	end
	if weaponAIData.StopAnimationsOnEnd then
		for k, animationName in pairs(weaponAIData.StopAnimationsOnEnd) do
			StopAnimation({ DestinationId = enemy.ObjectId, Name = animationName })
		end
	end
end

function EmptyAI()

end