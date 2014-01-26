module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    sass:
      all:
        src: 'app/stylesheets/application.scss'
        dest: 'public/stylesheets/application.css'
    concat:
      app:
        src: [
          'app/javascripts/message_box.coffee'
          'app/javascripts/candid.coffee'
          'app/javascripts/models/*.coffee'
          'app/javascripts/collections/*.coffee'
          'app/javascripts/views/*.coffee'
          'app/javascripts/routers/*.coffee'
        ]
        dest: 'tmp/application.coffee'

    watch:
      all:
        files: [
          "app/templates/*.jst",
          "app/app/javascripts/**",
          "app/app/stylesheets/*.scss"
        ]
        tasks: "default"
    coffee:
      all:
        src: ["tmp/application.coffee"]
        dest: "public/javascripts/application.js"
        options:
          bare: false
    jst:
      compile:
        options:
          processName: (filename) ->
            index = filename.lastIndexOf("/")
            filename.substring(index + 1, filename.length - 4)
        files:
          'public/javascripts/templates.js': ['app/templates/*.jst']

  grunt.loadNpmTasks 'grunt-contrib-jst'
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-concat"

  grunt.registerTask "default", ["jst", "concat", "coffee", "sass"]
