ranchu = require '../ranchu'
fs     = require 'fs'
file   = require 'file'
util   = require 'util'
extra  = require 'fs.extra'

srcPrefix   = "src"
buildPrefix = "build"

config = {}

#
# Recursive sync rmdir
#

rmdir = (path) ->

    for file in fs.readdirSync path
        currPath = "#{path}/#{file}"
        currFile = fs.statSync currPath

        if currFile.isDirectory()
            rmdir currPath
        else
            fs.unlinkSync currPath

    fs.rmdirSync path

mangle = (data, name)->

    if name.match /\.coffee$/ # and config.coffee
        data = (require 'coffee-script').compile data
        name = name.replace /\.coffee$/, ".js"

    if name.match /\.js$/ # and config.compress
        data = ranchu.compress data

    [data, name]


copy = (src, dst)->
    console.log "From #{src} to #{dst}"
    [data, dst] = mangle (fs.readFileSync src, 'utf-8'), src
    console.log "From #{src} to #{dst}"
    fs.writeFileSync dst, data

walk = (dir) ->
    file.walk dir, (nil, dirPath, dirs, files) ->
        # console.log "Inside dir #{dirPath}"

        files.forEach (file) ->
            # console.log "File #{file}"
            copy file, file.replace(srcPrefix, buildPrefix)

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


