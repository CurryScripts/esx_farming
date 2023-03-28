settings = {}

-- README LESEN!
-- Alle Items sind Platzhalter! 
-- Alle Coordinaten sind Platzhalter!

settings.farms = {
    {coords = vector3(2542.41015625, 4812.8344726563, 33.709293365479), zoneScale = 27.0, blipEnabled = true, blipLabel = "Kartoffel Farm", blipType = 66, blipScale = 0.4, colour = 0, hasRadius = true, name = "bread", label = "Brot", min = 0, max = 4},
    {coords = vector3(2489.2829589844, 4852.7700195313, 36.36116027832), zoneScale = 20.0, blipEnabled = true, blipLabel = "Mais Farm", blipType = 66, blipScale = 0.4, colour = 0, hasRadius = true, name = "water", label = "Wasser", min = 0, max = 4}
}

settings.factorys = {
    {coords = vector3(570.08294677734, 2796.8278808594, 42.015636444092), blipEnabled = true, blipLabel = "Kartoffel Verarbeiter", blipType = 467, blipScale = 0.7, colour = 0, name = "bread", label = "Brot",  count = 4, newItem = "water"},
    {coords = vector3(162.11457824707, 2286.041015625, 94.126617431641), blipEnabled = true, blipLabel = "Mais Verarbeiter", blipType = 467, blipScale = 0.7, colour = 0, name = "water", label = "Wasser",  count = 4, newItem = "gold"}
}

settings.seller = {
   {coords = vector4(1574.9894, 3262.4761, 41.4325, 345.5180), ped = "ig_car3guy2", blipEnabled = true, blipLabel = "Händler", blipType = 480, blipScale = 0.7, colour = 0}
}

settings.sellerItems = {
    {name = "gold", label = "Gold",  price = 100},
    {name = "water", label = "Wasser",  price = 2}
}