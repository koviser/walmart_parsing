const webpack = require('webpack')
const path = require('path')

const baseConfig = require('./base.config')

const devConfig = {}

module.exports = Object.assign(baseConfig, devConfig)
