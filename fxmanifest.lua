fx_version 'cerulean'
game 'gta5'

description 'qb-hud convert to esx'
version '2.1.0'

shared_scripts {
	'@es_extended/imports.lua',
    'config.lua'
}

client_script 'client.lua'
server_script 'server.lua'
lua54 'yes'

ui_page 'html/index.html'

files {
	'html/*',
	'html/index.html',
	'html/styles.css',
	'html/responsive.css',
	'html/app.js',
}
