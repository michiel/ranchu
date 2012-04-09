path = require "path"
fs   = require "fs"

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
    srcDir   : "src",
    buildDir : "build",
    logging  : true,
    config   : config,
    plugins  : plugins,
    version  : '0.0.2',
    log      : (str) ->
        if @logging then console.log " *** #{str}"
    abort    : (str) ->
        console.log "ABORT #{str}"
        process.exit -1
}

plugins.forEach (plugin) ->
    # ranchu.log "Adding plugin #{plugin}"
    if ranchu[plugin]?
        console.log "Won't add plugin #{plugin} - a property or plugin of that name already exists"
    else
        ranchu[plugin] = require "./plugins/" + plugin

