fx_version 'cerulean'
game 'gta5'

author 'V Scripts'
description 'Rent'
version '1.0.0'

client_scripts {
    'client.lua',
}

dependencies {
    'ox_lib'
}

server_scripts {
    'server.lua',
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua' 
}
