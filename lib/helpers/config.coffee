fs = require 'fs'

module.exports = ()->
    is_ranchu = yes

    try
        file = fs.readFileSync 'config.json', 'utf-8'
    catch e
        is_ranchu = no

    if is_ranchu
        config = JSON.parse file
        console.log "Project #{config.name} at version #{config.version}"
        config
    else
        {}



