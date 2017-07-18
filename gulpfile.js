var gulp = require('gulp');
var gulpsync = require('gulp-sync')(gulp);

var requireDir = require('require-dir');
requireDir('./gulp/tasks', { recurse: true});

gulp.task('default', gulpsync.sync(['clean', ['less', 'images', 'js', 'css', 'fonts'], 'rev', 'rev2', 'watch']));