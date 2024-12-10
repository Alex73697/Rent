local pedModel = Config.Ped.model
local coords = Config.Ped.coords
local heading = Config.Ped.heading
local sultanRSModel = Config.Vehicles.sultanRS.model
local blistaModel = Config.Vehicles.blista.model
local sultanModel = Config.Vehicles.sultan.model
local rentedVehicles = {}

Citizen.CreateThread(function()
    RequestModel(pedModel)

    while not HasModelLoaded(pedModel) do
        Wait(500)
    end

    local ped = CreatePed(4, pedModel, coords.x, coords.y, coords.z, heading, false, true)
    SetEntityAsMissionEntity(ped, true, true)
    
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    
    exports.qtarget:AddTargetEntity(ped, {
        options = {
            {
                icon = "fas fa-car",
                event = "rent:open",
                label = "Rent",
            },
        },
        distance = 2.0
    })
end)

RegisterNetEvent('rent:open', function()
    local ox_lib = exports['ox_lib']
    ox_lib:registerContext({
        id = 'rent_menu',
        title = 'Rent',
        menu = 'rent_menu',
        options = {
            {
                title = 'Blista',
                event = 'rent:blista'
            },
            {
                title = 'Sultan',
                event = 'rent:sultan'
            },
            {
                title = 'SultanRS',
                event = 'rent:sultanRS'
            }
        }
    })

    ox_lib:showContext('rent_menu')
end)

local spawnBlocked = false

function isSpawnBlocked(vehicleCoords)
    for _, vehicle in ipairs(rentedVehicles) do
        local vehiclePos = GetEntityCoords(vehicle)
        local distance = Vdist(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, vehiclePos.x, vehiclePos.y, vehiclePos.z)
        if distance < 5.0 then
            return true
        end
    end
    return false
end

RegisterNetEvent('rent:sultanRS', function()
    local vehicleType = 'sultanRS'
    TriggerServerEvent('rent:pay', vehicleType)

    local vehicleCoords = Config.Vehicles.sultanRS.spawnCoords
    if isSpawnBlocked(vehicleCoords) then
        TriggerEvent('esx:showNotification', 'Spawn point is blocked!')
        return
    end

    RequestModel(sultanRSModel)
    while not HasModelLoaded(sultanRSModel) do
        Wait(500)
    end

    local vehicleHeading = Config.Vehicles.sultanRS.heading
    local vehicle = CreateVehicle(sultanRSModel, vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, vehicleHeading, true, false)

    local playerPed = PlayerPedId()
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

    table.insert(rentedVehicles, vehicle)
    SetVehicleAsNoLongerNeeded(vehicle)
end)

RegisterNetEvent('rent:sultan', function()
    local vehicleType = 'sultan'
    TriggerServerEvent('rent:pay', vehicleType)

    local vehicleCoords = Config.Vehicles.sultanRS.spawnCoords
    if isSpawnBlocked(vehicleCoords) then
        TriggerEvent('esx:showNotification', 'Spawn point is blocked!')
        return
    end

    RequestModel(sultanModel)
    while not HasModelLoaded(sultanModel) do
        Wait(500)
    end

    local vehicleHeading = Config.Vehicles.sultanRS.heading
    local vehicle = CreateVehicle(sultanModel, vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, vehicleHeading, true, false)

    local playerPed = PlayerPedId()
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

    table.insert(rentedVehicles, vehicle)
    SetVehicleAsNoLongerNeeded(vehicle)
end)

RegisterNetEvent('rent:blista', function()
    local vehicleType = 'blista'
    TriggerServerEvent('rent:pay', vehicleType)

    local vehicleCoords = Config.Vehicles.blista.spawnCoords
    if isSpawnBlocked(vehicleCoords) then
        TriggerEvent('esx:showNotification', 'Spawn point is blocked!')
        return
    end

    RequestModel(blistaModel)
    while not HasModelLoaded(blistaModel) do
        Wait(500)
    end

    local vehicleHeading = Config.Vehicles.blista.heading
    local vehicle = CreateVehicle(blistaModel, vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, vehicleHeading, true, false)

    local playerPed = PlayerPedId()
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

    table.insert(rentedVehicles, vehicle)
    SetVehicleAsNoLongerNeeded(vehicle)
end)
