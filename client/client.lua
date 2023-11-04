if (GetResourceState("es_extended") == "started") then
    if (exports["es_extended"] and exports["es_extended"].getSharedObject) then
        ESX = exports["es_extended"]:getSharedObject()
    else
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
end

RegisterNetEvent("panicbutton")
AddEventHandler("panicbutton", function(source, pos, playername)
    print(pos, playername)

    local blipBW = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(blipBW, 150)
    SetBlipDisplay(blipBW, 4)
    SetBlipScale(blipBW, 2.0)
    SetBlipColour(blipBW, 1)
    SetBlipAsShortRange(blipBW, false)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(playername)
    EndTextCommandSetBlipName(blipBW)

    --Nachricht
    ShowNotification("~b~" .. playername .. "~s~hat einen ~r~Panic~s~ abgegeben. Die Position findest du auf der Karte.")

    Citizen.Wait(300000)
    RemoveBlip(blipBW)
end)

function ShowNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, true)
end
