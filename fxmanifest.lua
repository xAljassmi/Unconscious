fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Aljassmi'
description 'R6 Team - Advanced Unconscious System'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'unconscious.lua'
}

escrow_ignore {
    'config.lua',
    'unconscious.lua'
}