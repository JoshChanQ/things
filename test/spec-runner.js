require.config({
  baseUrl: '.',
  paths: {
    'mocha'         : '../bower_components/mocha/mocha',
    'chai'          : '../bower_components/chai/chai',
    '_'             : '../bower_components/lodash/dist/lodash.min',
  },
  shim: {
    mocha: {
      exports: 'mocha'
    }
  },
  urlArgs: 'bust=' + (new Date()).getTime()
});

require(['require', 'chai', 'mocha'], function(require, chai){

  this.assert = chai.assert;
  this.expect = chai.expect;
  var should = chai.should();

  mocha.setup('bdd');

  var specRoot = '../.tmp/test/spec/';

  require([
    'things-spec.js',
    // 'base/container-spec.js',
    // 'base/component-selector-spec.js',
    // 'base/event-pump-spec.js',
    // 'base/event-tracker-spec.js',
    // 'base/event-tracker-standalone-spec.js',
    // 'command/command-manager-spec.js'
  ].map(function(test) {
    return specRoot + test;
  }), function(require) {
    if (window.mochaPhantomJS) {
      mochaPhantomJS.run();
    } else {
      mocha.run();
    }
  });

});
