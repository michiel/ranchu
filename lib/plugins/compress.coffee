ranchu = require '../ranchu'

jsp = require("uglify-js").parser
pro = require("uglify-js").uglify

module.exports = (code) ->
    ast = jsp.parse(code)
    ast = pro.ast_mangle(ast)
    ast = pro.ast_squeeze(ast)
    pro.gen_code(ast)
