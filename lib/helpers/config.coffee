fs = require 'fs'

configFile = 'config.json'

module.exports = {
    read : ()->
        try
            file = fs.readFileSync configFile, 'utf-8'
        catch e
            throw new Error "Not in a ranchu project!"

        config = JSON.parse file
        console.log "Project #{config.name} at version #{config.version}"
        config

    write : (config) ->
            fs.writeFileSync configFile, JSON.stringify config, null, 4

    init  : (name) ->
        {
            "name"     : name,
            "version"  : "0.0.1",
            "widgets"  : [
            ],
            "compress" : true,
            "coffee"   : true
        }
}
