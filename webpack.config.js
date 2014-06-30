var BannerPlugin = require('webpack/lib/BannerPlugin');
var version = require('./package.json').version;

module.exports = {
  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee" }
    ]
  },
  resolve: {
    extensions: ["", ".coffee", ".js"]
  },
  entry: './src/scripts/things',
  output: {
    path: __dirname + '/dist',
    filename: 'things.js',
    library: 'things',
    libraryTarget: 'umd',
    sourcePrefix: ''
  },
  plugins: [
    new BannerPlugin('Things v' + version + ' | (c) Hatio, Lab. | MIT License')
  ],
  externals: {
    "lodash": "lodash"
  }
};
