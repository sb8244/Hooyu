var gulp = require('gulp'), 
    sass = require('gulp-sass') ,
    bower = require('gulp-bower'),
    es6ify = require('es6ify'),
    source = require('vinyl-source-stream'),
    browserify = require('browserify'),
    babelify = require('babelify'),
    rename = require('gulp-rename'),
    sourcemaps = require('gulp-sourcemaps'),
    bowerResolve = require('bower-resolve');

var config = {
  sassPath: './app/assets/stylesheets',
  bowerDir: './vendor/assets/components' ,
  requireFiles: ['./node_modules/react/react.js']
};

gulp.task('default', ['compile-scss', 'compile-js']);

gulp.task('compile-scss', function() { 
    return gulp.src(config.sassPath + '/application.scss')
        .pipe(sourcemaps.init())
         .pipe(sass({
            errLogToConsole: true,
            indentedSyntax: false,
            includePaths: [
              config.bowerDir + '/bootstrap-sass/assets/stylesheets'
            ]
           }) )
        .pipe(sourcemaps.write())
         .pipe(gulp.dest('./public/assets')); 
});

gulp.task('compile-js', function() {
  bowerResolve.init(function () {
    var entryFile = './app/assets/javascripts/application.js';
    var stream = browserify(entryFile, {debug: true})
      .require(config.requireFiles)
      .transform(babelify)
      .require(bowerResolve('jquery'), {expose: 'jquery'})
      .bundle()
      .on("error", function(err) {
        console.log("Error : " + err.message);
      });

    stream.pipe(source('application.js'))
      .pipe(gulp.dest('public/assets'));
  });
});
