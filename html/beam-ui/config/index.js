'use strict';

const path = require('path');

module.exports = {
    dev: {
        assetsSubDirectory: 'static',
        assetsPublicPath: '/',
        proxyTable: {
            '/beam_admin': {
                target: 'http://localhost:8080',
                // target: 'https://www.wehuiyi.com',
                changeOrigin: true
            }
        },
        host: 'localhost',
        // host: 'www.wehuiyi.com',
        port: 8084,
        autoOpenBrowser: false,
        errorOverlay: true,
        notifyOnErrors: true,
        poll: false,
        devtool: 'eval-source-map',
        cacheBusting: true,
        cssSourceMap: false,
    },

    build: {
        index: path.resolve(__dirname, '../dist/index.html'),
        assetsRoot: path.resolve(__dirname, '../dist'),
        assetsSubDirectory: 'static',
        assetsPublicPath: './',
        productionSourceMap: false,
        devtool: '#source-map',
        productionGzip: false,
        productionGzipExtensions: ['js', 'css'],
        bundleAnalyzerReport: process.env.npm_config_report
    }
};
