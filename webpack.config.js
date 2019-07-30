const path = require("path");

module.exports = {
    entry: "./built/index.js",
    module: {
        rules: [
            {
                exclude: /node_modules/,
                test: /\.js$/,
            },
        ],
    },
    output: {
        filename: "server.js",
        libraryTarget: "commonjs2",
        path: path.resolve(__dirname, "dist"),
    },
    stats: {
        warnings: false
    },
    target: "node",
};
