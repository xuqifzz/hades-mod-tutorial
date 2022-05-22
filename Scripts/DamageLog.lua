OnAnyLoad{ function()

    local objId = CreateScreenObstacle({ Name = "rectangle01", X = 1400, Y = 500})
    SetColor({ Id = objId, Color = {0, 0, 0, 0.5} })   

    SetScaleX({ Id = objId, Fraction = 300 / 480 })
    SetScaleY({ Id = objId, Fraction = 300 / 267 })

    CreateTextBox({ 
        Id = objId, 
        Text = "Hello World!", 
        FontSize = 20, 
        Color = {1,1,1,1}, 
        OffsetX = -500
     })

     
     function OnDamage(victim,  triggerArgs)
        local roundedAmount = round( triggerArgs.DamageAmount )
        local victimName = victim.Name
        local damageSourceName = triggerArgs.AttackerName
        local damageProjectileSourceName = triggerArgs.EffectName or triggerArgs.SourceProjectile
        if not triggerArgs.EffectName and triggerArgs.AttackerWeaponData then
            damageProjectileSourceName = GetGenusName(triggerArgs.AttackerWeaponData)
            if triggerArgs.AttackerWeaponData.DamageNumberGenusName then
                damageProjectileSourceName = triggerArgs.AttackerWeaponData.DamageNumberGenusName
            end
        end
        if(damageSourceName == nil) then
            damageSourceName = "未知单位"
        end
        if(damageProjectileSourceName == nil) then
            damageSourceName = "未知武器"
        end
    
        if(damageSourceName == "_PlayerUnit") then
            damageSourceName = "你"
        end
    
        if(victim == CurrentRun.Hero) then
            victimName = "你"
        end

        local LuaKey = "Data"
        local LuaValue = { 
            attackerName = damageSourceName,
            victimName = victimName,
            weaponName = damageProjectileSourceName,
            amount = roundedAmount
        }
        local text ="{$Data.attackerName} 的 {$Data.weaponName} 对 {$Data.victimName} 造成了 {$Data.amount} 点伤害"
       
        ModifyTextBox({ Id = objId, Text = text, LuaKey = LuaKey, LuaValue =LuaValue})

     end

end}