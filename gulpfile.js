/*!
 * gulp
 */

// Load plugins
var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    coffeelint = require('gulp-coffeelint'),
    uglify = require('gulp-uglify'),
    rename = require('gulp-rename'),
    clean = require('gulp-clean'),
    concat = require('gulp-concat'),
    notify = require('gulp-notify'),
    cache = require('gulp-cache'),
    livereload = require('gulp-livereload'),
    gutil = require('gulp-util'),
    connect = require('gulp-connect'),
    open = require('gulp-open'),
    webpack = require('gulp-webpack'),
    webpack_config = require('./webpack.config.js'),
    mocha = require('gulp-mocha');

// Scripts
gulp.task('package', ['coffee'], function() {
  return gulp.src('.tmp/scripts/**/*.js')
    .pipe(concat('things.js'))
    .pipe(webpack(webpack_config))
    .pipe(gulp.dest('dist'))
    .pipe(gulp.dest('vendor/assets/javascripts'))
    .pipe(rename({ suffix: '.min' }))
    .pipe(uglify())
    .pipe(gulp.dest('dist'))
    .pipe(gulp.dest('vendor/assets/javascripts'))
    .pipe(notify({ message: 'Scripts task complete' }));
});

// Clean
gulp.task('clean', function() {
  return gulp.src(['.tmp/scripts', '.tmp/test', 'dist', 'vendor/assets/javascripts'], {read: false})
    .pipe(clean());
});

gulp.task('coffee', function() {
  gulp.src('./src/scripts/**/*.coffee')
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())
    .pipe(coffee({bare: false, sourceMap: true, sourceRoot: '../../src/scripts/'}).on('error', gutil.log))
    .pipe(gulp.dest('./.tmp/scripts'))
    .pipe(connect.reload())
});

gulp.task('coffee-test', function() {
  gulp.src('./test/spec/**/*.coffee')
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())
    .pipe(coffee({bare: true, sourceMap: true}).on('error', gutil.log))
    .pipe(gulp.dest('./.tmp/test/spec'))
    .pipe(connect.reload())
});

gulp.task('test', function() {
  require('coffee-script/register');
  gulp.src('test/spec/**/*-spec.coffee')
    .pipe(mocha({reporter: 'nyan'}));
});

// Reload index.html & test setting files for test
gulp.task('test-resource', function() {
  gulp.src('test/*')
    .pipe(connect.reload());
});

gulp.task('connect-dev', function() {
  connect.server({
    hostname: '*',
    port: 9000,
    // root: '.',
    livereload: {
      port: 35729
    }
  });
});

gulp.task('open', function() {
  gulp.src('test/index.html')
    .pipe(open('', {
      url: 'http://localhost:9000/test/index.html',
      // app: 'chrome'
    }))
});

// Watch
gulp.task('watch', function() {

  // Watch .coffee files
  gulp.watch('src/scripts/**/*.coffee', ['coffee']);
  gulp.watch('test/spec/**/*.coffee', ['coffee-test']);

  // Watch resources in test/, reload on change
  gulp.watch('test/{,*/}*.{html,js}', ['test-resource']);
});

gulp.task('dev', ['coffee', 'coffee-test', 'connect-dev', 'open', 'watch'], function() {
});

// Default task
gulp.task('default', ['clean'], function() {
    gulp.start(['coffee', 'coffee-test', 'connect-dev', 'open', 'watch']);
});

