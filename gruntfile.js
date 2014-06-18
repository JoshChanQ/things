module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    clean: {
      temp: [".tmp"],
      dist: ["dist/*"]
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
        bare: false
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
    }
  });

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-autoprefixer');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-connect');

  // Default task(s).
  grunt.registerTask('default', ['clean', 'compass', 'coffee', 'connect', 'watch']);

};
