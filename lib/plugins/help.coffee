ranchu = require '../ranchu'

help = module.exports = (args)->
    ranchu.log "Help .."
    ranchu.log "Available commands are,"
    ranchu.plugins.forEach (plugin) ->
        ranchu.log "  #{plugin}"



