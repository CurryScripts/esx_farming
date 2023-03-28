ESX = nil 

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterServerEvent("checkAndFarm", function(v)
    xPlayer = ESX.GetPlayerFromId(source)
    _count = math.random(v.min, v.max) 

    if xPlayer.canCarryItem(v.name, _count) then
        xPlayer.addInventoryItem(v.name, _count)
        if _count == 0 then 
            xPlayer.showNotification("~y~Du hast nichts bekommen")
        else
            xPlayer.showNotification("Du hast ~y~".._count.."x ~b~"..v.label.."~w~ gesammelt")
        end
    else
        xPlayer.showNotification("~r~Du kannst nicht mehr tragen!")
    end
end)

RegisterServerEvent("checkAndfactor", function(v)
    xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer.getInventoryItem(v.name)["count"]) >= v.count then 
        xPlayer.removeInventoryItem(v.name, v.count)
        xPlayer.addInventoryItem(v.newItem, 1)
        xPlayer.showNotification("Du hast ~y~"..v.count.."x ~b~"..v.label.."~w~ verarbeitet")
    else
        xPlayer.showNotification("~r~Dir fehlt "..v.count - xPlayer.getInventoryItem(v.name)["count"].."x "..v.label.."!") 
    end 
end)

RegisterServerEvent("checkAndsell", function(v, input)
    xPlayer = ESX.GetPlayerFromId(source)
    
    _totalPrice = v.price * input

    if (xPlayer.getInventoryItem(v.name)["count"]) >= input then 
        xPlayer.removeInventoryItem(v.name, input)
       xPlayer.addMoney(_totalPrice)
        xPlayer.showNotification("Du hast ~y~"..input.."x ~b~"..v.label.."~w~ für ~g~".._totalPrice.."$ ~w~verkauft")
    else
        xPlayer.showNotification("~r~Dir fehlt "..v.label.."!") 
    end 
end)