path = require "path"
fs   = require "fs"

logging = true

console.log " *** Loading helpers"
config = require './helpers/config'

console.log " *** Loading plugins"

pluginDirs = [
    __dirname + "/plugins",
    "~/.ranchu/plugins"
]

plugins = pluginDirs.reduce((prev, curr) ->
    console.log " *** Checking #{curr}"
    if fs.existsSync curr
        prev.concat fs.readdirSync(curr).map (plugin)->
            plugin.replace(/\.\w*$/, '')
    else
        prev

, [])


ranchu = module.exports = {
    config  : config,
    plugins : plugins,
    version : '0.0.1',
    log     : (str) ->
        if logging then console.log " *** #{str}"
}

plugins.forEach (plugin) ->
    ranchu.log "Adding plugin #{plugin}"
    ranchu[plugin] = require "./plugins/" + plugin

