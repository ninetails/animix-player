gulp    = require('gulp')
plugins = require('gulp-load-plugins')()
server  = require('tiny-lr')()
path    = require('path')

gulp.task('style-assets-300-200-1', function(){
  return gulp.src('_src/300/200/assets/1/sass/**/*.sass')
    .pipe(plugins.compass({
      style: 'compressed',
      css: 'assets/css',
      sass: 'src/sass'
    }))
    .pipe(gulp.dest('300/200/assets/1/css'))
    .pipe(plugins.livereload(server));
});

gulp.task('scripts-app', function() {
  return gulp.src('_src/app/coffee/**/*.coffee')
    .pipe(plugins.coffee({bare: true}))
    .pipe(gulp.dest('js')) // removable
    .pipe(plugins.rename({suffix: '.min'}))
    .pipe(plugins.uglify({preserveComments: 'some'}))
    .pipe(gulp.dest('js'))
    .pipe(plugins.livereload(server));
});

gulp.task('clean', function() {
  return gulp.src(['js', '300/200/assets/1/css'], {read: false})
    .pipe(plugins.clean());
});

gulp.task('watch', function() {
  // Listen on port 35729
  server.listen(35729, function (err) {
    if (err) {
      return console.log(err)
    };
    // Watch .sass files
    gulp.watch('_src/300/200/assets/1/sass/**/*.sass', ['style-assets-300-200-1']);
    // Watch .js files
    gulp.watch('_src/app/coffee/**/*.coffee', ['scripts-app']);
  });
});