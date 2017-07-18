var gulp = require('gulp');
var config = require('../config').rev2;
var rev = require('gulp-rev');
var revCollector = require("gulp-rev-collector");

gulp.task('rev2', function () {
    return gulp.src([config.revJson, config.src])
        .pipe( revCollector({
            replaceReved: true
        }))
        .pipe( gulp.dest(config.dest) );
});