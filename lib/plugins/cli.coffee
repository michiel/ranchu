ranchu = require '../ranchu'

cli = module.exports = ()->
    ranchu.log "Running cli.."
    argv = process.argv
    arg  = argv[2]

    if arg?
        ranchu.log "Found #{arg}"
        if ranchu[arg]
            ranchu.log "Running #{arg}"
            ranchu[arg](argv.splice(3, argv.length))
        else
            ranchu.log "No task #{arg} found"
    else
        ranchu.log "No parameters given, try help"


