exports = module.exports = {
  context: __dirname + "/lib",
  entry: "./index.js",
  module: {
    loaders: [
      {
        test: /\.css$/,
        loader: 'style!css?modules',
      },
    ],
  },
  output: {
    path: __dirname,
    filename: "script.js",
  },
};
