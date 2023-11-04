if (GetResourceState("es_extended") == "started") then
    if (exports["es_extended"] and exports["es_extended"].getSharedObject) then
        ESX = exports["es_extended"]:getSharedObject()
    else
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
end

RegisterCommand(Config.PanicbuttonCommand, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    job = xPlayer.getJob().name

    if tablecontains(Config.AllowedJobs, job) then
        local xPlayers = ESX.GetExtendedPlayers('job', job)
        count = #xPlayers
        coords = GetEntityCoords(GetPlayerPed(source))
        TriggerClientEvent("chat:addMessage", source,
            { args = { "^1Panic Button", "You have triggered the panic button!" } })
        TriggerClientEvent("chat:addMessage", source,
            { args = { "^1Panic Button", "There are " .. count .. " " .. job .. "s online!" } })
        for k, v in pairs(xPlayers) do
            xPlayer.triggerEvent("panicbutton", source, coords, xPlayer.getName())
        end
    else
        TriggerClientEvent("chat:addMessage", source,
            { args = { "^1Panic Button", "You are not allowed to use the panic button!" } })
    end
end)

function tablecontains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end
