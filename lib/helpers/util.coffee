fs = require 'fs'

#
# Recursive sync rmdir
#

util = module.exports = {
    rmdir : (path) ->

        for file in fs.readdirSync path
            currPath = "#{path}/#{file}"
            currFile = fs.statSync currPath

            if currFile.isDirectory()
                util.rmdir currPath
            else
                fs.unlinkSync currPath

        fs.rmdirSync path

    subDirs : (path) ->
        dirs = []

        for file in fs.readdirSync path
            currPath = "#{path}/#{file}"
            currFile = fs.statSync currPath

            if currFile.isDirectory()
                dirs.push currPath
                dirs.concat util.subDirs currPath
        dirs

}


