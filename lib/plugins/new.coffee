ranchu = require '../ranchu'
fs     = require 'fs'

module.exports = (args)->
    project = args[0]
    ranchu.log "Creating new project #{project}.."

    fs.mkdirSync project
    process.chdir(project)

    ["src", "build"].forEach (dir) ->
        fs.mkdirSync dir

    fs.writeFileSync "config.json", JSON.stringify ranchu.config.init(project), null, 4

