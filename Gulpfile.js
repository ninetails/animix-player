gulp    = require('gulp')
plugins = require('gulp-load-plugins')()
server  = require('tiny-lr')()
path    = require('path')

gulp.task('style-assets-300-200-1', ['clean-assets-300-200-1'], function(){
  return gulp.src('_src/300/200/assets/1/sass/**/*.sass')
    .pipe(plugins.compass({
      style: 'compressed',
      css: '300/200/assets/1/css',
      sass: '_src/300/200/assets/1/sass'
    }))
    .pipe(gulp.dest('300/200/assets/1/css'))
    .pipe(plugins.livereload(server));
});

gulp.task('clean-assets-300-200-1', function() {
  return gulp.src('300/200/assets/1/css/**/*.css', {read: false})
    .pipe(plugins.clean());
});

gulp.task('scripts-app', ['clean-app'], function() {
  return gulp.src('_src/app/coffee/**/*.coffee')
    .pipe(plugins.coffee({bare: true}))
    //.pipe(gulp.dest('js')) // removable
    .pipe(plugins.rename({suffix: '.min'}))
    .pipe(plugins.uglify({preserveComments: 'some'}))
    .pipe(gulp.dest('js'))
    .pipe(plugins.livereload(server));
});

gulp.task('clean-app', function() {
  return gulp.src('js/**/*.js', {read: false})
    .pipe(plugins.clean());
});

gulp.task('images', ['clean-images'], function() {
  return gulp.src('_src/300/200/assets/1/images/*.*')
    .pipe(plugins.imagemin())
    .pipe(gulp.dest('300/200/assets/1/images'))
    .pipe(plugins.livereload(server));
});

gulp.task('clean-images', function() {
  return gulp.src('300/200/assets/1/images/*.*', {read: false})
    .pipe(plugins.clean());
});

gulp.task('html', function() {
  return gulp.src('./**/*.html')
    .pipe(plugins.livereload(server));
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
    // Watch .html files
    gulp.watch('./**/*.html', ['html']);
  });
});