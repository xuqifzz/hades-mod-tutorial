OnAnyLoad{ function()

    local objId = CreateScreenObstacle({ Name = "BlankObstacle",  X = 1500, Y = 100})

    local damageItems = {}
    
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
       
        local itemId = CreateScreenObstacle({ Name = "rectangle01", X = 1500, Y = 100 + 25 * (#damageItems)})
        SetScaleX({Id = itemId, Fraction = 10/6})
        SetScaleY({Id = itemId, Fraction = 0.1})
        SetColor({Id = itemId, Color = {0.5, 0.5, 0.5,0.2} })

        CreateTextBox({ 
            Id = itemId, 
            Text = text, 
            FontSize = 13, 
            Color = {1,1,1,1}, 
            LuaKey = LuaKey,
            LuaValue = LuaValue
        })

        table.insert(damageItems,itemId)

     end

end}