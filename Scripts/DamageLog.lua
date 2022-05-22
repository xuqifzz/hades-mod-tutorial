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
        Justification = "Left",
        OffsetX = -50,
        OffsetY = -100,
     })

     local damageCount = 0;
     function OnDamage(victim,  triggerArgs)
        -- Move({ Ids = objId, Angle = 180, Distance = 50, Speed = 1000 })
        damageCount = damageCount + 1;
        ModifyTextBox({ Id = objId, Text = "造成了" .. damageCount .. "次伤害"})   
     end

end}