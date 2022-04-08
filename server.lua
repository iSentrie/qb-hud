local ResetStress = false

ESX.RegisterCommand('cash', 'user', function(xPlayer, args, showError)
    local cashamount = xPlayer.getMoney()
    TriggerClientEvent('hud:client:ShowAccounts', xPlayer.source, 'cash', cashamount)
end, false, {help = 'Check Cash Balance'})

ESX.RegisterCommand('bank', 'user', function(xPlayer, args, showError)
    local bankamount = xPlayer.getAccount('bank').money
    TriggerClientEvent('hud:client:ShowAccounts', xPlayer.source, 'bank', bankamount)
end, false, {help = 'Check Bank Balance'})

-- ESX.RegisterCommand('dev', 'admin', function(xPlayer, args, showError)
--     TriggerClientEvent("qb-admin:client:ToggleDevmode", xPlayer.source)
-- end, false, {help = 'Enable/Disable developer Mode'})

RegisterNetEvent('hud:server:GainStress', function(amount)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local newStress
    if not Player or (Config.DisablePoliceStress and Player.PlayerData.job.name == 'police') then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] + amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    xPlayer.showNotification(_U("stress_gain"))
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local newStress
    if not Player then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] - amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    xPlayer.showNotification(_U("stress_removed"))
end)

ESX.RegisterServerCallback('hud:server:HasHarness', function(source, cb)
    local Ply = ESX.GetPlayerFromId(source)
    local Harness = xPlayer.getInventoryItem("harness")
    if Harness ~= nil then
        cb(true)
    else
        cb(false)
    end
end)
ESX.RegisterServerCallback('hud:server:getMenu', function(source, cb)
    cb(Config.Menu)
end)
