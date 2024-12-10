ESX = exports['es_extended']:getSharedObject()

local rentPrices = {
    sultanRS = 500,
    sultan = 300,
    blista = 200
}

RegisterServerEvent('rent:pay')
AddEventHandler('rent:pay', function(vehicleType)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    local price = rentPrices[vehicleType]
    
    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        
        TriggerClientEvent('esx:showNotification', _source, "You have rented a " .. vehicleType .. " for $" .. price)
    else
        TriggerClientEvent('esx:showNotification', _source, "You don't have enough money to rent a " .. vehicleType)
    end
end)

RegisterNetEvent('rent:sultanRS')
AddEventHandler('rent:sultanRS', function()
    local _source = source
    TriggerClientEvent('rent:sultanRS', _source)
end)

RegisterNetEvent('rent:sultan')
AddEventHandler('rent:sultan', function()
    local _source = source
    TriggerClientEvent('rent:sultan', _source)
end)

RegisterNetEvent('rent:blista')
AddEventHandler('rent:blista', function()
    local _source = source
    TriggerClientEvent('rent:blista', _source)
end)
