const path    = require('path');
const webpack = require('webpack');
const ExtractTextPlugin = require("extract-text-webpack-plugin")

const extractCSS  = new ExtractTextPlugin('stylesheets/app.scss')
const extractSCSS = new ExtractTextPlugin('stylesheets/app-sass.scss')
const extractLESS = new ExtractTextPlugin('stylesheets/app-less.less')
const jquery      = new webpack.ProvidePlugin({$: 'jquery', jQuery: 'jquery'})

module.exports = {
  entry: [
    'babel-polyfill',
    './app-js/main',
  ],
  output: {
    path: path.join(__dirname, '..', 'app/assets'),
    filename: 'javascripts/app.js'
  },
  module: {
    loaders: [
    ],
    rules: [
      {
        test: /\.(eot|svg|ttf|woff|woff2)(.+|.?)$/,
        use: {
          loader: 'file-loader?name=fonts/[name].[ext]'
        }
      },
      {
        test: /\.js$/,
        exclude: /(node_modules|bower_components)/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['env'],
            plugins: ['transform-runtime']
          }
        }
      },
      {
        test: /\.css$/,
        use: extractCSS.extract({
          fallback: "style-loader",
          use: "css-loader"
        })
      },
      {
        test: /\.scss$/,
        use: extractSCSS.extract({
          fallback: "style-loader",
          use: "css-loader!sass-loader"
        })
      },
      {
        test: /\.less$/,
        use: extractLESS.extract({
          fallback: "style-loader",
          use: "css-loader!less-loader"
        })
      }

    ]
  },
  plugins: [
    extractCSS,
    extractSCSS,
    extractLESS,
    jquery
  ]
};
