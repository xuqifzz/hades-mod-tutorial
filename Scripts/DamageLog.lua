OnAnyLoad{ function()

    local objId = CreateScreenObstacle({ Name = "rectangle01", X = 1400, Y = 500})
    SetColor({ Id = objId, Color = {0, 0, 0, 0.5} })   

    SetScaleX({ Id = objId, Fraction = 300 / 480 })
    SetScaleY({ Id = objId, Fraction = 300 / 267 })

end}