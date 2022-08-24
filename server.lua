ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('popo_loca:vehicule')
AddEventHandler('popo_loca:vehicule', function(prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	xPlayer.removeMoney(prix)
	TriggerClientEvent('esx:showNotification', source, "~g~Véhicule de location sortie.~z~ ~r~Soit prudent sur la route !")
	TriggerClientEvent('esx:showNotification', source, "Il te reste ~r~1 heure~s~ avant de rendre la voiture de location !")

end)