gulp-peg
========

[![Build Status](https://travis-ci.org/lazutkin/gulp-peg.svg?branch=develop)](https://travis-ci.org/lazutkin/gulp-peg)

Gulp plugin for [PEG](http://pegjs.majda.cz/) parsers compilation.

# Detailed documentation will be writen soon...

# Installation

Install plugin

```
npm install gulp-peg --save-dev
```

Add peg-compilation task into your gulp-file:

```coffeescript
paths =
  build: "build"
  scripts: peg: "src/**/*.peg"

gulp.task "peg:compile", ->
  gulp
    .src( paths.scripts.peg )
    .pipe( peg( {exportVar: ''} ) )
    .on( "error", gutil.log ) 
    .pipe( gulp.dest( paths.build ) )
```

Finish

## Options

Plugin redirects passed options directly to PEG, so read [its documentation](http://pegjs.majda.cz/documentation) for details.

#### exportVar option

This option is inspired by [grunt-peg](https://github.com/dvberkel/grunt-peg) plugin, and defines variable to which the generated parser will be assigned in the output file. Default value is `module.exports`.

`exportVar`          | Behavior
----------           | ---------
`null`               | **default** Will set variable to `module.exports`
function(filename){} | should return the desired variable name
`''` (empty string)  | convenience value to set variable to *filename*parser
