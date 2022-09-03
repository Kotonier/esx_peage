ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
     ESX = obj 
end)



RegisterNetEvent('Kotonier:toll')
AddEventHandler('Kotonier:toll', function(vehicleClass)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)


local voiture = false
local camion = false

for k, v in pairs(Peage.peagevoiture) do
    if v == vehicleClass then
       voiture = true
    end
end

for k, v in pairs(Peage.peagecamion) do
    if v == vehicleClass then
       camion = true
    end
end

if voiture then 
    xPlayer.removeAccountMoney('bank', Peage.prixVoiture)
    TriggerClientEvent('esx:showNotification', _source, 'Vous avez payé le péage voiture de ~y~€ ' ..Peage.prixVoiture)
elseif camion then 
    xPlayer.removeAccountMoney('bank', Peage.prixCamion)
    TriggerClientEvent('esx:showNotification', _source, 'Vous avez payé le péage camion de ~y~€ ' ..Peage.prixCamion)
    
end
end)