ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterNetEvent('popo_loca:vehicule')
AddEventHandler('popo_loca:vehicule', function(prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	local min = Config.time / 60
	xPlayer.removeMoney(prix)
	TriggerClientEvent('esx:showNotification', source, _U('ready'))
	TriggerClientEvent('esx:showNotification', source, _U('time') .. min.. _U('time_bis'))

end)