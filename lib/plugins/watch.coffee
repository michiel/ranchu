fs     = require 'fs'

ranchu = require '../ranchu'
util   = require '../helpers/util'

srcDir   = ranchu.srcDir
buildDir = ranchu.buildDir

watch = module.exports = (args)->

    config = ranchu.config.read()

    ranchu.log "Watching project #{config.name}"

    dirs = util.subDirs(srcDir).filter (dir) -> !dir.match /\/\./

    dirs.forEach (dir) ->
        ranchu.log "Watching #{dir}"

        fs.watch dir, {}, (event, file) ->
            ranchu.log "Change in #{file}"
            ranchu.deploy()


