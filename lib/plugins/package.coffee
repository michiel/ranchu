fs     = require 'fs'
file   = require 'file'
util   = require 'util'

ranchu = require '../ranchu'

srcDir   = ranchu.srcDir
buildDir = ranchu.buildDir

config = ranchu.config.read()

package = module.exports = (args)->
    ranchu.build()

