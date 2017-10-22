const webpack = require('webpack')
const path = require('path')

const baseConfig = require('./base.config')

const prodConfig = { }

module.exports = Object.assign(baseConfig, prodConfig)
