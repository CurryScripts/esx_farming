-- Logs -- 

print("^1LOGS: ^0"..GetCurrentResourceName().." gestartet")

-- Code --

_menuPool = MenuPool.New()

farmClass = {
    ped = nil,
}

function farmClass:init()
    self.ped = GetPlayerPed(-1)
end

function farmClass:blip()
    for k, v in pairs(settings.farms) do
        if v.blipEnabled == true then 
            local x, y, z = table.unpack(v.coords) 
            if v.hasRadius == true then 
                AddRadiusBlip(x, y, z, 9, v.zoneScale, v.colour, 190, false, true)
            end     
            AddBlip(x, y, z, v.blipType, v.blipScale, v.colour, false, false, v.blipLabel, true)
        end
    end

    for k, v in pairs(settings.factorys) do
        if v.blipEnabled == true then 
            local x, y, z = table.unpack(v.coords) 
            AddBlip(x, y, z, v.blipType, v.blipScale, v.colour, false, false, v.blipLabel, true)
        end
    end

    for k, v in pairs(settings.seller) do
        if v.blipEnabled == true then 
            local x, y, z = table.unpack(v.coords) 
            AddBlip(x, y, z, v.blipType, v.blipScale, v.colour, false, false, v.blipLabel, true)
        end
    end
end

function npc()
    for k, v in pairs(settings.seller) do
        local x, y, z, h = table.unpack(v.coords) 
        SpawnPed(v.ped, x, y, z, h)
    end
end

function farmClass:inZone()
    for k, v in pairs(settings.farms) do
        local x, y, z = table.unpack(v.coords)
        if GetDistance(self.ped, v.coords, v.zoneScale) then
            x, y, z = table.unpack(v.coords)
            ShowHelp("Drücke ~INPUT_CONTEXT~, um zu sammeln")
            if IsControlJustPressed(0, 38) then 
                PlayAnimation("pickup_object", "pickup_low", 48)
                TriggerServerEvent("checkAndFarm", v)
                Citizen.Wait(700)
            end
        end
    end
end

function farmClass:factory()
    for k, v in pairs(settings.factorys) do
        local x, y, z = table.unpack(v.coords)
        if GetDistance(self.ped, v.coords, 5) then
            x, y, z = table.unpack(v.coords)
            ShowHelp("Drücke ~INPUT_CONTEXT~, um zu verarbeiten")
            if IsControlJustPressed(0, 38) then
                TriggerServerEvent("checkAndfactor", v)
            end 
        end
    end
end

function farmClass:seller()
    for k, v in pairs(settings.seller) do
        local x, y, z = table.unpack(v.coords)
        if GetDistance(self.ped, v.coords, 2) then
            x, y, z = table.unpack(v.coords)
            ShowHelp("Drücke ~INPUT_CONTEXT~, um zu verkaufen")
            if IsControlJustPressed(0, 38) then
                PlayAnimation("gestures@f@standing@casual", "gesture_nod_yes_soft", 48)
                openMenu(v)
            end 
        end
    end
end

function openMenu(v)

    desc = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(v.coords)))
    mainMenu = UIMenu.New("Verkäufer", "Straße: "..desc)
    _menuPool:Add(mainMenu)
    
    for k, v in pairs(settings.sellerItems) do  
        local items = NativeUI.CreateItem("Item: ~b~"..v.label, "~b~")
        mainMenu:AddItem(items) 
        items:RightLabel("Preis: ~g~"..v.price.."$")

        items.Activated = function(sender, index)
            input = tonumber(InputBox("Anzahl:", 11))
            if input ==  0 or input == nil then
                Notify("~r~Ungütliger Wert!") 
            else
                TriggerServerEvent("checkAndsell", v, input)
            end
        end
    end

    _menuPool:ControlDisablingEnabled(true)
    _menuPool:MouseControlsEnabled(false)
    mainMenu:Visible(not mainMenu:Visible()) 
end

Citizen.CreateThread(function()
    farmClass:blip()
    npc()
    while true do
        Citizen.Wait(0)
        farmClass:init()
        _menuPool:ProcessMenus()
        farmClass:inZone()
        farmClass:factory()
        farmClass:seller()
    end
end)