RegisterNetEvent('fgs-blackmarket:buy', function(itemData)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    if isNear(_src) then
        if (xPlayer.getMoney() - itemData.price) >= itemData.price then 
            xPlayer.addInventoryItem(itemData.name, 1)
            xPlayer.removeMoney(itemData.price)

            xPlayer.showNotification(string.format('Zakoupil/a jste %s.', itemData.label))    
            
            discordWebhook(
                string.format('**%s (%s)**', GetPlayerName(_src), xPlayer.getIdentifier()),
                string.format('Zakoupil: **%s**\n Za: **%s$**', itemData.item, itemData.price)
            )
        else
            xPlayer.showNotification('Nemáš dostatek peněz!')
        end
    end
end)
