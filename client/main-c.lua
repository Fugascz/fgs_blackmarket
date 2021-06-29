ESX = nil
local nearestCoords
local timeToWait = 500

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(1)
    end
end)

-- Thread to marker is from Squizer's documentation.
-- Thanks to Squizer for posting. ❤
-- https://docs.squizer.cz/snippets/optimalization
Citizen.CreateThread(function()
    while true do
        Wait(500)
        if nearestCoords then
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            if #(pedCoords - nearestCoords) > Config.DrawDistance then
                nearestCoords = nil
                timeToWait = 500
            else
                Wait(500)
            end
        else
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function ()
    while true do
        Wait(timeToWait)

        for k,v in pairs(Config.Zones) do
            local coords = GetEntityCoords(PlayerPedId())
            local dist = #(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z))
            if (v.Enable and dist < Config.DrawDistance) then
                if not nearestCoords then
                    timeToWait = 0
                    nearestCoords = vector3(v.Pos.x, v.Pos.y, v.Pos.z)
                end
                DrawMarker(v.Marker.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Marker.Size.x, v.Marker.Size.y, v.Marker.Size.z, v.Marker.Color.r, v.Marker.Color.g, v.Marker.Color.b, 100, false, false, 2, true, false, false, false)
                if dist < 1 then
                    DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z + 0.75, '[E] Blackmarket')
                    if IsControlJustPressed(0, 38) then
                        openBLMenu(v.BuyWeapons)
                    end
                else
                    if dist > 1 then
                        nearRental = false
                        ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'fgs_blackmarket')
                    end
                end
            end
        end
    end
end)

function DrawText3D(x,y,z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = #(vector3(p.x, p.y, p.z) - vector3(x, y, z))
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0135, 0.025+ factor, 0.03, 0, 0, 0, 150)
	end
end

function openBLMenu(Items)
    local elements = {}
    for i=1, #Items do
        local item = Items[i] 
        table.insert(elements, {label = string.format('<span style="color:red;">%s</span> - <span style="color:green;">%s$</span>', item.label, item.price), value = item.value, price = item.price, count = item.count})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fgs_blackmarket',
    {   
        align = 'right',
        elements = elements
    },
    function (data, menu)
        TriggerServerEvent('fgs-blackmarket:buy', data.current.label, data.current.value, data.current.price, data.current.count)
    end, function(data, menu)    
        menu.close()
    end)
end

AddEventHandler('onResourceStop', function(resName)
    if GetCurrentResourceName() == resName then
        ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'fgs_blackmarket')
    end
end)