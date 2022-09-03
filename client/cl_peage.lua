ESX = nil



Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)


local wasInCar     = false


TypeVoiture = function(vehicle)
    local vehicleClass = GetVehicleClass(vehicle)
    return (vehicleClass >= 0 and vehicleClass <= 12) or (vehicleClass >= 17 and vehicleClass <= 20)
end 


Citizen.CreateThread(function()
    Wait(50)
    
    while true do
 
   Wait(0)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    local coordped = GetEntityCoords(ped)
    PlayerData = ESX.GetPlayerData()
    local vehicleClass = GetVehicleClass(vehicle)
    local attoll

    for k, v in pairs(Peage.coordpeage) do

        local dist = #(coordped-v)
        if dist <= 26.0 then
            attoll = true
        end
    end

    if IsPedInAnyVehicle(ped, false) then --dans un vehicule

            if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then  --conducteur

                if attoll then --au peage

                    if vehicle ~= 0 and (wasInCar or TypeVoiture(vehicle)) then
                        wasInCar = true
                        local vehicleClass = GetVehicleClass(vehicle)
                            if vehicleClass == 18 or vehicleClass == 13 then  -- vehicule urgence donc rien  ou Cycle = velo
                            --nothing
                            else 
                                TriggerServerEvent('Kotonier:toll', vehicleClass)
                                attoll = false  -- pas au m peage, valeur à 0
                                Wait(1000 * 20) --ne peux pas payer plus d'une fois toutes les 20 secondes
                            end
                    end
                else -- pas au peage wait 1.5s
                    Wait(1500)
                end
        else -- pas conducteur
           Wait(5000)
        end
    else -- pas dans un vehicle
        Wait(5000)
    end
    end
end)




Citizen.CreateThread(function()
    -- BLIPS

            local blip = AddBlipForCoord(Peage.BlipsCoords)
            SetBlipSprite(blip, Peage.BlipSprite)
            SetBlipScale(blip, Peage.BlipScale)
            SetBlipShrink(blip, Peage.BlipShrink)
            SetBlipColour(blip, Peage.BlipColour)
            SetBlipAsShortRange(blip, Peage.BlipAsShortRange)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(Peage.TextComponentString)
            EndTextCommandSetBlipName(blip)

    
    
    end)