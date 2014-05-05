File   = require "vinyl"
chai   = require "chai"
plugin = require "../lib"
expect = chai.expect


beforeEach ->
  @stream = do plugin
  @file   = new File path: "file.peg"

it "should compile file", ( done ) ->
  @file.contents = new Buffer "start = ('a' / 'b')+"

  @stream.on "data", ( file ) ->
    expect( file.path ).be.equal "file.js"
    do done

  @stream.write @file
  @stream.end( )

    
it "should throw error", ( done ) ->
  @file.contents = new Buffer "start = > ('a' / 'b')+"

  @stream.on "error", ( e ) ->
    expect( e.name ).be.equal "SyntaxError"
    do done

  @stream.write @file
  @stream.end( )
    
