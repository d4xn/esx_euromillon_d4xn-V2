-- Resource Metadata
fx_version 'cerulean'
games { 'gta5' }

author 'd4xn' -- DanX in other platforms
description 'esx_euromillon_d4xn V2'
version '0.1.0'

-- What to run
client_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/es.lua',
    'config.lua',
    'client/client.lua'
}

server_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/es.lua',
    'config.lua',
    'server/server.lua'
}
