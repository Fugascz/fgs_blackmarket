function openBlackmarketMenu(Items)
    local elements = {}

    for i=1, #Items do
        local item = Items[i] 

        table.insert(
            elements,
            {
                label = string.format('<span style="color:red;">%s</span> - <span style="color:green;">%s$</span>', item.label, item.price),
                name = item.value,
                price = item.price
            }
        )
    end

    isMenuOpen = true

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fgs_blackmarket',
        {   
            align = 'right',
            elements = elements
        },
        function (data, menu)
            TriggerServerEvent(
                'fgs-blackmarket:buy',
                {
                    label = data.current.label,
                    name = data.current.name,
                    price = data.current.price
                }
            )
        end, function(data, menu)    
            menu.close()
            isMenuOpen = false
        end
    )
end

function DrawText3D(x, y, z, text)
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
