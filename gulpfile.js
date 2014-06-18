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
    mocha = require('gulp-mocha');

// Scripts
gulp.task('scripts', ['coffee'], function() {
  return gulp.src('.tmp/scripts/**/*.js')
    .pipe(concat('things.js'))
    .pipe(gulp.dest('dist/scripts'))
    .pipe(rename({ suffix: '.min' }))
    .pipe(uglify())
    .pipe(gulp.dest('dist/scripts'))
    .pipe(notify({ message: 'Scripts task complete' }));
});

// Clean
gulp.task('clean', function() {
  return gulp.src(['.tmp/scripts', '.tmp/test', 'dist/scripts'], {read: false})
    .pipe(clean());
});

gulp.task('coffee', function() {
  gulp.src('./src/scripts/**/*.coffee')
    // .pipe(coffeelint())
    // .pipe(coffeelint.reporter())
    .pipe(coffee({bare: false, sourceMap: true, sourceRoot: '../../src/scripts/'}).on('error', gutil.log))
    .pipe(gulp.dest('./.tmp/scripts'))
});

gulp.task('coffee-test', function() {
  gulp.src('./test/spec/**/*.coffee')
    // .pipe(coffeelint())
    // .pipe(coffeelint.reporter())
    .pipe(coffee({bare: true, sourceMap: true}).on('error', gutil.log))
    .pipe(gulp.dest('./.tmp/test/spec'))
});

gulp.task('test', function() {
  require('coffee-script/register');
  gulp.src('test/spec/**/*-spec.coffee')
    .pipe(mocha({reporter: 'nyan'}));
});

gulp.task('connect', function() {
  connect.server({
    root: '',
    livereload: true
  });
});

// Watch
gulp.task('watch', function() {

  // Watch .coffee files
  gulp.watch('src/scripts/**/*.coffee', ['coffee']);
  gulp.watch('test/spec/**/*.coffee', ['coffee-test']);

  // Watch any files in .tmp/, reload on change
  gulp.watch('.tmp/**/*.js', ['reload-js']);
  gulp.watch('test/*', ['reload-test']);
});

// Reload js files
gulp.task('reload-js', function () {
  gulp.src('.tmp/**/*.js')
    .pipe(connect.reload());
});

// Reload index.html & test setting files for test
gulp.task('reload-test', function() {
  gulp.src('test/*')
    .pipe(connect.reload());
});

gulp.task('dev', ['coffee', 'coffee-test', 'connect', 'watch'], function() {
});

// Default task
gulp.task('default', ['clean'], function() {
    gulp.start('scripts');
});

