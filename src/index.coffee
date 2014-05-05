PEG     = require "pegjs"
util    = require "util"
gutil   = require "gulp-util"
through = require "through2"

# ---------------
processFile = ( file, opts ) ->
  grammar = file.contents.toString "utf8"
  parser  = PEG.buildParser grammar, opts
  source  = util.format "%s = %s;", opts.exportVar, parser

  file.path = gutil.replaceExtension file.path, ".js"
  file.contents = new Buffer source
  file


# ---------------
module.exports = ( opts = { } ) ->

  # Set default options to PEG compilator
  opts.exportVar ?= "module.exports"
  opts.output    ?= "source"

  # Construct stream
  through.obj ( file, enc, cb ) ->

    if file.isStream( )
      @emit "error", gutil.PluginError "gulp-peg", "Streams are not supported!"

    else if file.isBuffer( )
      try
        @push processFile file, opts
        do cb

      catch e
        @emit "error", e
        do cb

    else if file.isNull( )
      @push file
      do cb
