fs = require("fs-extra")
path = require('path')
CopyWebpackPlugin = require "copy-webpack-plugin"
HtmlWebpackPlugin = require('html-webpack-plugin')
MiniCssExtractPlugin = require("mini-css-extract-plugin")
ServiceWorkerWebpackPlugin = require('serviceworker-webpack-plugin')
TerserPlugin = require('terser-webpack-plugin')
webpack = require 'webpack'
{CleanWebpackPlugin} = require('clean-webpack-plugin')
{VueLoaderPlugin} = require('vue-loader')

production = "production"
development = "development"

IS_DEV = process.env.NODE_ENV == development

do =>
  for i in [
    './webpack/require'
    './webpack/urlbase64'
  ]
    require i

OUTPUT_PATH = path.join(__dirname, "dist")
SRC = path.join(__dirname, "src")+'/'

publicPath = require(SRC+'config/cdn.txt')

if IS_DEV
  NAME = '[hash:urlbase64:7]/[name].[ext]?[path]'
else
  NAME = '[hash:urlbase64:7].[ext]'

HTML = []
ENTRY = {}


ALIAS = {
  lodash: 'lodash-es'
  # '@vue': '@vue/composition-api'
  "@" : SRC[..-1]
}

fs.readdirSync(SRC+"pkg").map (name) =>
  pkg = SRC+"pkg/#{name}"
  ALIAS["@"+name] = pkg
  title = pkg+'/config/title.txt'
  if not fs.existsSync title
    return
  ENTRY[name] = pkg+"/coffee/index.coffee"
  HTML.push new HtmlWebpackPlugin({
    template: SRC+'pug/index.pug'
    filename:"index.html"
    chunks:[name]
    inject:'body'
    title:require(title)
    meta:
      viewport: 'width=device-width,initial-scale=1,shrink-to-fit=no'
    minify:
      collapseWhitespace: true
      removeComments: true
      removeRedundantAttributes: true
      removeAttributeQuotes: true
      removeScriptTypeAttributes: true
      removeStyleLinkTypeAttributes: true
      useShortDoctype: true
  })

module.exports = exports = {
target: 'web'
watchOptions:
  aggregateTimeout: 300
  poll: 1000
entry:ENTRY
performance:
  assetFilter: (assetFilename) =>
    if assetFilename.endsWith('.woff2')
      return false
    true
plugins:HTML.concat [
  # new ServiceWorkerWebpackPlugin({
  #   entry: SRC+'coffee/sw.coffee'
  # })
  new webpack.ProvidePlugin({
    process: 'process/browser'
  })
  new webpack.ProvidePlugin({
    Buffer: ['buffer', 'Buffer']
  })
  new VueLoaderPlugin()
  new CopyWebpackPlugin({
    patterns:[
      {
        from: path.resolve(__dirname, 'static')
        to: OUTPUT_PATH
        globOptions:
          ignore: [
            '**/.git/**/*'
          ]
      }
    ]
  })
  new CleanWebpackPlugin()
]
resolve:
  extensions: '.coffee .js .styl .css .vue .json .pug'.split(' ')
  alias:ALIAS
  fallback:
    fs:false
    path:require.resolve("path-browserify")
    stream: require.resolve("stream-browserify")
    assert: require.resolve("assert/")
module:
  rules: [
    {
      test: /\.txt$/i
      use: 'trim-raw-loader'
    }
    {
      test: /\.m?js$/
      use: [
        'babel-loader'
        {
          loader:'source-map-loader'
          options:
            filterSourceMappingUrl: (url, resourcePath) =>
              if /.*\/node_modules\/.*/.test(resourcePath)
                  return false
              return true
        }
      ]
    }
    {
      test: /\.pug$/
      oneOf: [
        {
          resourceQuery: /^\?vue/,
          use: ['pug-plain-loader']
        }
        {
          use: ['pug-loader']
        }
      ]
    }
    {
      test: /\.coffee$/
      use: [
        {
          loader:'coffee-loader'
          options:{
            transpile: {
                presets: [
                  [
                    "@babel/preset-env",
                    {
                      modules: false
                    }
                  ]
                ]
                plugins: [
                  # [
                  #   "import"
                  #   {
                  #     libraryName: "ant-design-vue"
                  #     libraryDirectory: "es"
                  #     style:true
                  #   }
                  # ]
                  # [
                  #   "component",
                  #   {
                  #     "libraryName": "element-ui",
                  #     "styleLibraryName": "~src/styl/element/theme"
                  #   }
                  # ]
                ]
              }
          }
        }
      ]
    }
    {
      test: /\.svg/
      use:
        loader: 'svg-url-loader'
        options:
          limit: 2048
    }
    {
      test:/\.(png|jpg|gif|webp)$/
      loader:'url-loader'
      options:{
        limit:10000
        name:NAME
      }
    }
    {
      test:/\.vue$/,
      loader:'vue-loader'
    }
    {
      test: /\.less$/i
      use:[
        {
          loader: "style-loader"
        }
        {
          loader: "css-loader"
        }
        {
          loader:'less-loader'
          options:
            lessOptions:
              modifyVars:require('./src/lib/antd.vars')
              javascriptEnabled: true
        }
      ]
    }
    {
      test:/\.(woff2?|eot|ttf|otf)$/
      loader:"url-loader"
      options:
        limit:10000
        name:NAME
    }
  ]
output: {
  publicPath
  path: OUTPUT_PATH
}
}

if IS_DEV
  PORT = require(SRC+"config/dev_port") or 2171
  HOST = require(SRC+"config/host") or "127.0.0.1"
  console.log "http://#{HOST}:"+PORT
  exports = Object.assign exports, {
    mode:development
    devtool:'eval-cheap-module-source-map'
    devServer : {
      compress: true
      contentBase: OUTPUT_PATH
      disableHostCheck: true
      host: '0.0.0.0'
      port:PORT
      hot: true
      public : require(SRC+"config/http.txt")+"://"+HOST+":"+PORT
      historyApiFallback:
        disableDotRule: true
    }
  }
else
  Object.assign(
    exports.output
    {
      chunkFilename: "[contenthash].js"
      filename: "[contenthash].js"
      hashDigest: "urlbase64"
      hashDigestLength: 7
      hashFunction: "sha512"
    }
  )
  OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin")
  Object.assign(
    exports
    {
      mode:production
      # devtool:'cheap-module-source-map'
      optimization:
        # Tree Shaking 终极优化指南 https://t.cn/A6vibt7P
        usedExports: true
        splitChunks:
          cacheGroups:
            styles:
              name: 'style'
              test: /\.css$/
              chunks: 'all'
              enforce: true
        minimizer: [
          new OptimizeCSSAssetsPlugin({})
          new TerserPlugin(
            parallel: true
            cache: true
            sourceMap: false
            extractComments:false
            terserOptions:
              compress:
                # warnings:false,
                drop_debugger:true
                drop_console: true
              output:
                comments: false
          )
        ]
    }
  )

do =>
  if IS_DEV
    exports.watch = true
    filename = "name"
  else
    filename = "contenthash:8"
  exports.plugins.unshift new webpack.DefinePlugin({
    DEV:IS_DEV
    __VUE_OPTIONS_API__: true
    __VUE_PROD_DEVTOOLS__: false
  })
  filename = "[#{filename}].css"
  exports.plugins.unshift new MiniCssExtractPlugin({
    filename
    chunkFilename:filename
  })
  use = [
      {
        loader: MiniCssExtractPlugin.loader
        options: {
          # hmr: IS_DEV
          publicPath
        }
      }
      {
        loader: 'css-loader'
        options:
          sourceMap: IS_DEV
      }

  ]
  exports.module.rules.push {
    test: /\.css$/
    use
  }
  exports.module.rules.push {
    test: /\.styl(us)?$/
    use : use.concat [
      {
        loader: 'postcss-loader'
        options:
          sourceMap: IS_DEV
          # config:
          #   path: 'postcss.config.js'
      }
      {
        loader: 'stylus-loader'
        options: sourceMap: IS_DEV
      }
    ]
  }
