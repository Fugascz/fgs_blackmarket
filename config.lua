Config = {}
Config.DrawDistance = 10.0

Config.Webhook = {
    Link = '',
    Icon = '',
}

Config.Zones = {
    One = {
        Enable = true,
        Pos = vector3(1601.68, -1682.13, 87.75),
        Marker = {
            Type = 22,
            Size = {x = 1.0, y = 1.0, z = 1.0},
            Color = {r = 0, g = 100, b = 255},
        },
        BuyWeapons = {
            {label = 'Nuz', value = 'WEAPON_KNIFE', price = 500, count = 200},
            {label = 'Palka', value = 'WEAPON_BAT', price = 250, count = 200},
            {label = 'Pistole', value = 'WEAPON_PISTOL', price = 4500, count = 200},
            {label = 'Micro SMG', value = 'WEAPON_MICROSMG', price = 150000, count = 200},
            {label = 'Assault Rifle', value = 'WEAPON_ASSAULTRIFLE', price = 230000, count = 200},
            {label = 'Brokovnice', value = 'WEAPON_PUMPSHOTGUN', price = 50000, count = 200},
        },
    },
}

