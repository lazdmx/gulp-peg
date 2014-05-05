var PEG, gutil, processFile, through, util;

PEG = require("pegjs");

util = require("util");

gutil = require("gulp-util");

through = require("through2");

processFile = function(file, opts) {
  var grammar, parser, source;
  grammar = file.contents.toString("utf8");
  parser = PEG.buildParser(grammar, opts);
  source = util.format("%s = %s;", opts.exportVar, parser);
  file.path = gutil.replaceExtension(file.path, ".js");
  file.contents = new Buffer(source);
  return file;
};

module.exports = function(opts) {
  if (opts == null) {
    opts = {};
  }
  if (opts.exportVar == null) {
    opts.exportVar = "module.exports";
  }
  if (opts.output == null) {
    opts.output = "source";
  }
  return through.obj(function(file, enc, cb) {
    var e;
    if (file.isStream()) {
      return this.emit("error", gutil.PluginError("gulp-peg", "Streams are not supported!"));
    } else if (file.isBuffer()) {
      try {
        this.push(processFile(file, opts));
        return cb();
      } catch (_error) {
        e = _error;
        this.emit("error", e);
        return cb();
      }
    } else if (file.isNull()) {
      this.push(file);
      return cb();
    }
  });
};
