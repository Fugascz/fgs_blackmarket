function isNear(playerId)
    if not playerId then
        return
    end

    local playerPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)

    for _, zoneData in pairs(Zones) do
        if zoneData.Enable then
            local dist = #(playerCoords - zoneData.Pos)

            if dist < 10 then
                return true
            end
        end
    end

    return false
end

function discordWebhook(title, msg)
    local connect = {
        {
            ["color"] = Webhook.Color,
            ["title"] = title,
            ["description"] = msg,
            ["footer"] = {
                ["text"] = 'fgs_blackmarket | ' .. os.date('%H:%M - %d. %m. %Y', os.time()),
                ["icon_url"] = Webhook.Icon,
            },
        }
    }

    PerformHttpRequest(
        Webhook.Link,
        function(err, _, _)
            if err == 0 then
                print(
                    'Webhook not set up properly...'
                )
            else
                print(
                    'WEDBHOOK ERROR: ' .. err
                )
            end
        end,
        'POST',
        json.encode(
            {
                username = 'BLACKMARKET SYSTEM',
                embeds = connect
            }
        ),
        {
            ['Content-Type'] = 'application/json'
        }
    )
end