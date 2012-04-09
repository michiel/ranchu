ranchu = require '../ranchu'
fs     = require 'fs'

module.exports = (args)->
    project = args[0]

    if !project?
        ranchu.abort "This task requires a project name as a paramater"

    if fs.existsSync project
        ranchu.abort "#{project} already exists here"

    ranchu.log "Creating new project #{project}.."

    fs.mkdirSync project
    process.chdir(project)

    ["src", "build"].forEach (dir) ->
        fs.mkdirSync dir

    fs.writeFileSync "config.json", JSON.stringify ranchu.config.init(project), null, 4

    fs.writeFileSync "README", "This project was generated using a nodejs/npm package called ranchu, use 'npm install ranchu' to get it.\n"

