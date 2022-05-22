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

     wait(2)
     Move({ Ids = objId, Angle = 90, Distance = 200, Speed = 1000 })
     wait(0.2)
     Move({ Ids = objId, Angle = 180, Distance = 500, Speed = 1000 })
     wait(0.5)
     Move({ Ids = objId, Angle = 270, Distance = 200, Speed = 1000 })
     wait(0.2)
     Move({ Ids = objId, Angle = 0, Distance = 500, Speed = 1000 })

end}