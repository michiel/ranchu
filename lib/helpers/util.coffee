fs = require 'fs'

util = module.exports = {

    #
    # Recursive sync rmdir
    #

    rmdir : (path) ->

        for file in fs.readdirSync path
            currPath = "#{path}/#{file}"
            currFile = fs.statSync currPath

            if currFile.isDirectory()
                util.rmdirSync currPath
            else
                fs.unlinkSync currPath

        fs.rmdirSync path

    #
    # Collect all sub directories
    #

    subDirs : (path) ->
        (fs.readdirSync path).filter(path) ->
            currPath = "#{path}/#{file}"
            currFile = fs.statSync currPath

            if currFile.isDirectory()
                dirs.push currPath
                dirs.concat util.subDirs currPath

            prev.concat


    fileWalk : (dir) ->


}


