ranchu = require '../ranchu'
fs     = require 'fs'

build = module.exports = (args)->

    config = ranchu.config.read()

    config.widgetFiles = []
    config.files       = []

    fs.writeFileSync "build/package.xml", ranchu.genxml(config).toString()

