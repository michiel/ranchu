ranchu = require '../ranchu'
fs     = require 'fs'
file   = require 'file'
util   = require 'util'
extra  = require 'fs.extra'

srcPrefix   = "src"
buildPrefix = "build"

config = {}

rmdir = (path) ->

    for file in fs.readdirSync path
        currPath = "#{path}/#{file}"
        currFile = fs.statSync currPath

        if currFile.isDirectory()
            rmdir currPath
        else
            fs.unlinkSync currPath

    fs.rmdirSync path


walk = (dir) ->
    file.walk dir, (nil, dirPath, dirs, files) ->
        # console.log "Inside dir #{dirPath}"

        files.forEach (file) ->
            # console.log "File #{file}"
            extra.copy file, file.replace(srcPrefix, buildPrefix), (msg) ->

                # console.log msg

        dirs.forEach (dir) ->
            # console.log "Dir : #{dir}"
            fs.mkdirSync dir.replace(srcPrefix, buildPrefix)
            walk dir

build = module.exports = (args)->

    config = ranchu.config.read()

    config.widgetFiles = []
    config.files       = []

    if fs.existsSync buildPrefix
        rmdir buildPrefix

    fs.mkdirSync buildPrefix

    fs.writeFileSync "#{buildPrefix}/package.xml", ranchu.genxml(config).toString()

    walk srcPrefix


