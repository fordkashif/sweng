helpText = """ 
******************************************
*                livewire         
*                ***********
*
* gulp watch -- watch while you code
* gulp build -- build out the app
*
*
*******************************************
"""

gulp = require 'gulp'
coffee = require 'gulp-coffee'
riot = require 'gulp-riot'
watch = require 'gulp-watch'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
csscat = require 'gulp-concat-css'
rename = require 'gulp-rename'


gulp.task 'html', ->
  gulp.src('src/livewire.html')
    .pipe rename('index.html')
    .pipe gulp.dest 'www'

gulp.task 'riot', ->
  riotopts = {compact: yes, type: 'coffeescript'}
  gulp.src 'tags/*.tag'
    .pipe riot(riotopts)
    .pipe concat('tags.js')
    .pipe gulp.dest 'www/js/'
  
gulp.task 'csslove', ->
  gulp.src [
    'node_modules/normalize.css/normalize.css',
    'make_modules/leaflet/leaflet.css',
    'node_modules/material-design-lite/material.min.css',
    'node_modules/riot-mui/build/styles/riot-mui.min.css'
    ]
    .pipe csscat('livewire.css')
    .pipe gulp.dest 'www/'
  
gulp.task 'coffee', ->
  gulp.src 'src/livewire.coffee'
    .pipe coffee({bare: yes})
    .pipe gulp.dest 'www/js/'

gulp.task 'iconography', ->
  gulp.src ['make_modules/leaflet/images/*.png','src/iconography/*.png']
    .pipe gulp.dest 'www/images/'

gulp.task 'joinup', ->
  gulp.src [
    'node_modules/underscore/underscore.js', 
    'node_modules/riot/riot.js',
    'node_modules/material-design-lite/material.js',
    'make_modules/leaflet/leaflet-src.js',
    'node_modules/proj4/dist/proj4-src.js',
    'make_modules/proj4leaflet/proj4leaflet.js',
    'make_modules/leafletHeat/HeatLayer.js'
    ]
    .pipe concat('tools.js')
    .pipe uglify()
    .pipe gulp.dest 'www/js/'
  
gulp.task 'watch', ->
  gulp.watch ['tags/*.tag','src/*.*'], ['riot','html','coffee','joinup','csslove','iconography']
  
gulp.task 'build', ['riot','html','coffee','joinup','csslove','iconography']
  
gulp.task 'info', ->
  console.log helpText

gulp.task 'default', ['info']


    
    
    
 