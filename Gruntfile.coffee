# http://gruntjs.com/configuring-tasks
# install node in ubuntu, maybe, https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
# running the process as a daemon wiht https://github.com/nodejitsu/forever
module.exports = (grunt) ->

  # Project configuration.
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
      # Must specify the order in which angular files will be loaded
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

  # Load the coffeeCompiler task "coffee"
  # https://github.com/gruntjs/grunt-contrib-coffee
  grunt.loadNpmTasks('grunt-contrib-coffee')

  # watch will run certain commands whenever a pattern matching file changes
  # https://npmjs.org/package/grunt-contrib-watch
  grunt.loadNpmTasks('grunt-contrib-watch')

  # allows to run command line tasks
  # https://github.com/jharding/grunt-exec
  # grunt.loadNpmTasks('grunt-exec')

  # https://github.com/rma4ok/grunt-bg-shell
  grunt.loadNpmTasks('grunt-bg-shell')

  # https://github.com/gruntjs/grunt-contrib-less
  grunt.loadNpmTasks('grunt-contrib-less')

  # https://github.com/gruntjs/grunt-contrib-cssmin
  grunt.loadNpmTasks('grunt-contrib-cssmin')

  # https://github.com/bustardcelly/grunt-forever
  # grunt.loadNpmTasks('grunt-forever')
  # sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8888  #

  # Default task(s).
  grunt.registerTask('default', ['uglify'])

  grunt.registerTask('concatCss', ['concat'])

  grunt.registerTask('makeJs', ['coffee'])

  grunt.registerTask('server', ['concat','less','coffee','cssmin'])

  grunt.registerTask('startServer', ['less','coffee','concat','bgShell:setPath','bgShell:mongo','bgShell:redis','bgShell:gwatch','bgShell:tserver'])
  
  grunt.registerTask('nothing', ['less','coffee','concat','bgShell:gwatch','bgShell:nws'])



