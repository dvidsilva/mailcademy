module.exports = (grunt) ->
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    bgShell: {
      _defaults: {
        bg: true
      }
      gwatch: {
        cmd: ' grunt concat && grunt less && grunt coffee && grunt watch '
      }
      nws: {
        cmd: ' nws '
        bg: false
      }
    }
    concat: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      }
      vendor: {
        src: 'vendor/*'
        dest: 'build/vendor.js'
      }
      lessie: {
        src: 'assets/stylesheets/*.less'
        dest: 'build/style.less'
      }
    }
    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      },
      app: {
        src: 'build/app.js'
        dest: 'build/app.js'
      }
      vendor: {
        src: 'build/vendor.js'
        dest: 'build/vendor.js'
      }
    }
    coffee : {
      'build/app.js' : ['ng/app.coffee','ng/config.coffee','ng/routes.coffee','ng/services/*.coffee','ng/controllers/*.coffee', 'ng/fuse/*.coffee']
      options :  {
        bare: true
      }
    }
    less: {
      development: {
        files: {
          'build/app.css' : 'build/style.less'
        }
      }
    }
    watch: {
      scripts: {
        files: ['**/*.coffee']
        tasks: ['coffee']
        options: {
          spawn: false
        }
      }
      css :  {
        files: ['**/*.less']
        tasks: ['concat','less']
        options: {
          spawn: false
        }
      }
    }
  cssmin: {
    add_banner: {
      options: {
        banner: '/* IDEAJOT */'
      },
      files: {
        'build/app.css': ['build/app.css']
      }
    }
  }
  })

  #load the plugin that provides the 'concat' task.
  grunt.loadNpmTasks('grunt-contrib-concat')

  # Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks('grunt-contrib-uglify')

  # https://github.com/gruntjs/grunt-contrib-coffee
  grunt.loadNpmTasks('grunt-contrib-coffee')

  # https://npmjs.org/package/grunt-contrib-watch
  grunt.loadNpmTasks('grunt-contrib-watch')

  # https://github.com/rma4ok/grunt-bg-shell
  grunt.loadNpmTasks('grunt-bg-shell')

  # https://github.com/gruntjs/grunt-contrib-less
  grunt.loadNpmTasks('grunt-contrib-less')

  # https://github.com/gruntjs/grunt-contrib-cssmin
  grunt.loadNpmTasks('grunt-contrib-cssmin')

  grunt.registerTask('nothing', ['less','coffee','concat','bgShell:gwatch','bgShell:nws'])



