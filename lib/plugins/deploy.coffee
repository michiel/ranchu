ranchu = require '../ranchu'

config = {}

deploy = module.exports = (args)->
    config = ranchu.config.read()
    ranchu.build()


