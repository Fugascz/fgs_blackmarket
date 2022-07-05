isMenuOpen = false

CreateThread(function()
    while true do
        Wait(0)

        local letSleep = true
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _,zoneData in pairs(Zones) do
            local dist = #(coords - zoneData.Pos)

            if (zoneData.Enable and dist < 10) then
                letSleep = false
                DrawMarker(22, zoneData.Pos.x, zoneData.Pos.y, zoneData.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 100, 255, 100, false, false, 2, true, false, false, false)
                
                if dist < 1 then
                    DrawText3D(zoneData.Pos.x, zoneData.Pos.y, zoneData.Pos.z + 0.75, '[E] Blackmarket')

                    if IsControlJustPressed(0, 38) then
                        openBlackmarketMenu(zoneData.BuyWeapons)
                    end
                end

                if dist > 1 and isMenuOpen then
                    isMenuOpen = false
                    ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'fgs_blackmarket')
                end
            end
        end

        if letSleep then
            Wait(1000)
        end
    end
end)
