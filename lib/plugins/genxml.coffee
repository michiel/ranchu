ltx = require 'ltx'

# <?xml version="1.0" encoding="utf-8" ?>
# <package xmlns="http://www.mendix.com/package/1.0/">
# 	<clientModule name="boolslide" version="0.1" xmlns="http://www.mendix.com/clientModule/1.0/">
# 		<widgetFiles>
# 			<widgetFile path="boolslide/Slider.xml"/>
# 		</widgetFiles>
# 		<files>
# 			<file path="boolslide/"/>
# 		</files>
# 	</clientModule>
# </package>

module.exports = (config)->
    el = new ltx.Element('package', {
        'xmlns' :'http://www.mendix.com/package/1.0/'
    }).c('clientModule', {
        'name'    : config.name
        'version' : config.version,
        'xmlns'   : 'http : //www.mendix.com/clientModule/1.0/'
    })
        
    el.c('widgetFiles')
    for path in config.widgetFiles
        el.c('widgetFile', {
            'path' : path
        }).up()

    el.c('file')
    for path in config.files
        el.c('file', {
            'path' : path
        }).up()

    el

# cfg = {
#     name    : 'ZorkName',
#     version : '1.0',
#     widgetFiles : [
#         'boolslider.xml'
#     ],
#     files : [
#         'boolslide'
#     ]
# }
# 
# console.log genpackage(cfg).toString()

    
