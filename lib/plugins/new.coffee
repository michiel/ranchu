ranchu = require '../ranchu'
fs     = require 'fs'

module.exports = (args)->
    project = args[0]
    ranchu.log "Creating new project #{project}.."

    fs.mkdirSync project
    process.chdir(project)

    ["src", "build"].forEach (dir) ->
        fs.mkdirSync dir

    fs.writeFileSync "config.json", JSON.stringify({
        "name"     : project
        "version"  : "0.0.1",
        "widgets"  : [
        ],
        "compress" : true,
        "coffee"   : false
    }, null, 4)



