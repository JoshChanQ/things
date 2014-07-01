module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    clean: {
      temp: [".tmp"],
      dist: ["dist/*"],
      rails: ["vendor/assets/javascripts/*"]
    },

    // Add vendor prefixed styles
    autoprefixer: {
      options: {
        browsers: ['last 1 version']
      },
      dist: {
        files: [{
          expand: true,
          cwd: '.tmp/styles/',
          src: '{,*/}*.css',
          dest: '.tmp/styles/'
        }]
      }
    },

    coffee: {
      options: {
        sourceMap: true,
        bare: true
      },
      server: {
        expand: true,
        flatten: false,
        cwd: 'src/scripts/',
        src: ['**/*.coffee'],
        dest: '.tmp/scripts/',
        ext: '.js'
      },
      test: {
        expand: true,
        flatten: false,
        cwd: 'test/spec/',
        src: ['**/*.coffee'],
        dest: '.tmp/test/spec/',
        ext: '.js'
      }
    },

    compass: {
      options: {
        sassDir: 'src/styles',
        cssDir: '.tmp/styles',
        generatedImagesDir: '.tmp/images/generated',
        imagesDir: 'src/images',
        javascriptsDir: 'src/scripts',
        fontsDir: 'src/styles/fonts',
        importPath: 'bower_components',
        httpImagesPath: '/images',
        httpGeneratedImagesPath: '/images/generated',
        httpFontsPath: '/styles/fonts',
        relativeAssets: false,
        assetCacheBuster: false,
        raw: 'Sass::Script::Number.precision = 10\n'
      },
      dist: {
        options: {
          generatedImagesDir: 'dist/images/generated'
        }
      },
      server: {
        options: {
          debugInfo: true
        }
      }
    },

    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      },
      build: {
        src: 'src/<%= pkg.name %>.js',
        dest: 'build/<%= pkg.name %>.min.js'
      }
    },

    watch: {
      js: {
        files: 'src/scripts/**/*.coffee',
        tasks: ['coffee:server'],
        options: {
          livereload: true
        }
      },
      compass: {
        files: ['src/styles/{,*/}*.{scss,sass}'],
        tasks: ['compass:server', 'autoprefixer']
      },
      test: {
        files: 'test/**/*',
        tasks: ['coffee:test'],
        options: {
          livereload: true
        }
      }
    },

    connect: {
      test: {
        options: {
          hostname: '*',
          port: 9000,
          base: '.',
          open: 'http://localhost:9000/test/index.html',
          livereload: 35729
        }
      }
    },

    bump: {
      options: {
        files: ['package.json', 'bower.json'],
        updateConfigs: ['pkg'],
        commit: true,
        commitMessage: 'Release v%VERSION%',
        commitFiles: ['-a'], //['package.json', 'bower.json'], // '-a' for all files
        createTag: true,
        tagName: 'v%VERSION%',
        tagMessage: 'Version %VERSION%',
        push: true,
        pushTo: 'upstream',
        gitDescribeOptions: '--tags --always --abbrev=1 --dirty=-d' // options to use with '$ git describe'
      }
    },

    replace: {
      'bump-gem': {
        src: ['lib/things/version.rb'],
        overwrite: true, // overwrite matched source files
        replacements: [{
          from: /VERSION = \"\S*\"/,
          to: "VERSION = \"<%= pkg.version %>\""
        }]
      }
    },

    copy: {
      rails: {
        files: [
          {
            expand: true,
            cwd: './dist',
            src: ['things.js', 'things.min.js'],
            dest: 'vendor/assets/javascripts/',
            filter: 'isFile'
          }
        ]
      }
    },

    exec: {
      webpack: {
        command: 'npm run webpack'
      },
      webpack_minified: {
        command: 'npm run webpack-minified'
      },
      build_gem: {
        command: "gem build things.gemspec"
      },
      push_gem: {
        command: "gem push things-rails-<%= pkg.version %>.gem"
      },
      publish_npm: {
        command: "npm publish"
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-autoprefixer');
  grunt.loadNpmTasks('grunt-exec');
  grunt.loadNpmTasks('grunt-bump');
  grunt.loadNpmTasks('grunt-text-replace');

  // Default task(s).
  grunt.registerTask('build', ['clean', 'compass', 'coffee', 'exec:webpack', 'exec:webpack_minified']);

  grunt.registerTask('bumpup', ['bump-only', 'replace:bump-gem'])

  grunt.registerTask('release', ['build', 'bumpup', 'exec:webpack', 'exec:webpack_minified', 'copy:rails']);

  grunt.registerTask('publish', ['release', 'exec:build_gem', 'exec:push_gem', 'exec:publish_npm']);

  grunt.registerTask('default', ['build', 'connect', 'watch']);

};
