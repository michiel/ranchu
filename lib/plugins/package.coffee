fs     = require 'fs'
file   = require 'file'
util   = require 'util'

ranchu = require '../ranchu'

srcDir   = ranchu.srcDir
buildDir = ranchu.buildDir

config = {}

package = module.exports = (args)->
    config = ranchu.config.read()
    ranchu.build()

