ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('fgs-blackmarket:buy')
AddEventHandler('fgs-blackmarket:buy', function(label, item, price, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() > price then 
        xPlayer.addWeapon(item, count)
        xPlayer.removeMoney(price)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = string.format('Zakoupil/a jste %s.', label) })
        blackmarkethook(string.format('**%s (%s)**', GetPlayerName(xPlayer.source), xPlayer.getIdentifier()), string.format('Zakoupil: **%s**\n Za: **%s$**', item, price))
    else 
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'Error', text = 'Nemáš dostatek peněz!' })
    end
end)

function blackmarkethook(title, msg)
    local connect = {
        {
            ["color"] = 9699539,
            ["title"] = title,
            ["description"] = msg,
            ["footer"] = {
                ["text"] = 'fgs_blackmarket | ' .. os.date('%H:%M - %d. %m. %Y', os.time()),
                ["icon_url"] = Config.Webhook.Icon,
            },
        }
    }
    PerformHttpRequest(Config.Webhook.Link, function(err, text, headers) end, 'POST', json.encode({username = "Blackmarket", embeds = connect}), { ['Content-Type'] = 'application/json' })
end
