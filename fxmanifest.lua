--[[ FX Information ]] --
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

--[[ Resource Information ]] --
name 'jerzys_management'
author 'JERZY'
version '0.0.1'
description 'Selfwritte, kekkos'



ui_page 'web/build/index.html'

dependencies {
	'/server:6116',
	'/onesync',
	'oxmysql',
}

shared_script {
  'client/cl_custom.lua',
  'client/cl_func.lua',
  'config.lua',
  'locales/de.lua',
	'locales/*.lua',
  "shared/**",
  '@ox_lib/init.lua',
}

client_script {
  'client/**.**',
}

server_script {
  "server/**",
  '@oxmysql/lib/MySQL.lua',
}


files {
  'web/build/**',
}
