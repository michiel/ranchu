fs     = require 'fs'
file   = require 'file'
util   = require 'util'

ranchu = require '../ranchu'

srcDir   = ranchu.srcDir
buildDir = ranchu.buildDir

config = {}

rmdir = (require '../helpers/util').rmdir

mangle = (data, name)->

    if name.match /\.coffee$/ # and config.coffee
        data = (require 'coffee-script').compile data
        name = name.replace /\.coffee$/, ".js"

    if name.match /\.js$/ # and config.compress
        data = ranchu.compress data

    [data, name]


copy = (src, dst)->
    # console.log "From #{src} to #{dst}"
    [data, dst] = mangle (fs.readFileSync src, 'utf-8'), src
    # console.log "From #{src} to #{dst}"
    try
        fs.writeFileSync dst, data
    catch e


walk = (dir) ->
    file.walk dir, (nil, dirPath, dirs, files) ->
        # console.log "Inside dir #{dirPath}"

        files.forEach (file) ->
            # console.log "File #{file}"
            copy file, file.replace(srcDir, buildDir)

        dirs.forEach (dir) ->
            # console.log "Dir : #{dir}"
            fs.mkdirSync dir.replace(srcDir, buildDir)
            walk dir

build = module.exports = (args)->

    config = ranchu.config.read()

    config.widgetFiles = []
    config.files       = []

    if fs.existsSync buildDir
        rmdir buildDir

    fs.mkdirSync buildDir

    fs.writeFileSync "#{buildDir}/package.xml",
        ranchu.genxml(config).toString()

    walk srcDir

    ranchu.log "Package completed"


