var gulp = require('gulp');
var config = require('../config').css;
var rev = require('gulp-rev');
gulp.task('css', function () {
    return gulp.src(config.src)
        .pipe(rev())  //set hash key
        .pipe(gulp.dest(config.dest))
        .pipe(rev.manifest()) //set hash key json
        .pipe(gulp.dest(config.dest))
})