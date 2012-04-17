path = require "path"
fs   = require "fs"

# console.log " *** Loading helpers"
config = require './helpers/config'

console.log " *** Loading plugins"

getUserHome = ()->
    process.env[ if process.platform is 'win32' then 'USERPROFILE' else 'HOME' ]

pluginDirs = [
    __dirname + '/plugins'
    getUserHome() + '/.ranchu/plugins'
]

plugins = pluginDirs.reduce((prev, curr) ->
    console.log " *** Checking #{curr}"
    if fs.existsSync curr
        prev.concat fs.readdirSync(curr).map (plugin)->
            [curr, plugin.replace(/\.\w*$/, '')]
    else
        prev

, [])


ranchu = module.exports =
    srcDir   : 'src'
    buildDir : 'build'
    logging  : true
    config   : config
    plugins  : plugins
    version  : '0.0.3'
    log      : (str) ->
        if @logging then console.log " *** #{str}"
    abort    : (str) ->
        console.log "ABORT #{str}"
        process.exit -1

plugins.forEach (tup) ->
    dir    = tup[0]
    plugin = tup[1]
    # ranchu.log "Adding plugin #{plugin}"
    if ranchu[plugin]?
        console.log "Won't add plugin #{plugin} - a property or plugin of that name already exists"
    else
        ranchu[plugin] = require "#{dir}/#{plugin}"

