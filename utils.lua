function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

function ShowHelp(text, bleep)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, bleep, -1)
end

function InputBox(DisplayText, bitLenght)
    AddTextEntry(DisplayText, DisplayText)
    DisplayOnscreenKeyboard(1, DisplayText, "", "", "", "", "", bitLenght)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        result = GetOnscreenKeyboardResult()
    end
    return result
end

function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

-- https://github.com/ModoSN/fivem-wiki/wiki/Advanced-Notifications || Visual.NewNotify("CHAR_CALL911", "Dispatch", "Emergency assistance", "Officer needs help!")
function NewNotify(image, title, subtitle, text)
	SetNotificationTextEntry("STRING");
	AddTextComponentString(text);
	SetNotificationMessage(image, image, false, 0, title, subtitle);
	DrawNotification(false, true);
end

function MugNotify(message, GainedRP, color)
    local handle = RegisterPedheadshot(PlayerPedId(-1))
    while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do
        Citizen.Wait(0)
    end
    local txd = GetPedheadshotTxdString(handle)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentString(message)
    EndTextCommandThefeedPostAward(txd, txd, GainedRP, color, "FM_GEN_UNLOCK")
    UnregisterPedheadshot(handle)
end

function ScreenFade(time)
    DoScreenFadeOut(1000)
    Citizen.Wait(time)
    DoScreenFadeIn(1000)
end

function AddMarker(x, y, z, markerType)
    DrawMarker(1, x, y, z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.5, 0, 191, 255, 200, false, true, 2, false,
        nil, nil, false)
end

function SpawnPed(ped, x, y, z, h, anim)
    local hash = GetHashKey(ped)
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Citizen.Wait(20)
    end
    ped = CreatePed(-1, ped, x, y, z - 1, h, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    return ped
end

function AddBlip(x, y, z, type, scale, colour, toggle, enableWaypoint, BlipLabel, shortRange)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, type)
    SetBlipScale(blip, scale)
    SetBlipColour(blip, colour)
    ShowTickOnBlip(blip, toggle)
    SetBlipAsShortRange(blip, shortRange)
    SetBlipRoute(blip, enableWaypoint)
    SetBlipRouteColour(blip, colour)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(BlipLabel)
    EndTextCommandSetBlipName(blip)
    return blip
end

function AddRadiusBlip(x, y, z, type, scale, colour, alpha, enableWaypoint, shortRange)
    local blip = AddBlipForRadius(x, y, z)
    SetBlipSprite(blip, type)
    SetBlipScale(blip, scale)
    SetBlipColour(blip, colour)
    SetBlipAlpha(blip, alpha)
    SetBlipAsShortRange(blip, shortRange)
    SetBlipRoute(blip, enableWaypoint)
    SetBlipRouteColour(blip, colour)
    return blip
end

function GetDistance(ped, targetCoords, distance)
    local coords = GetEntityCoords(ped)
    local dist = Vdist(coords, table.unpack(targetCoords))
    if dist <= distance then
        return true
    end
end

function PlayAnimation(animDict, animName, flag)
    local ped = GetPlayerPed(-1)
    ClearPedTasksImmediately(ped)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, -1, flag, 0, 0, 0, 0)
end