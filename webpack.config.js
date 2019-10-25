const path = require("path");

module.exports = {
    entry: "./src/index.ts",
    module: {
        rules: [
            {
                exclude: /node_modules/,
                test: /\.ts$/,
                loader: "ts-loader",
            },
        ],
    },
    output: {
        filename: "server.js",
        libraryTarget: "commonjs2",
        path: path.resolve(__dirname, "./dist"),
    },
    stats: {
        warnings: false
    },
    resolve: {
        extensions: [ ".mjs", ".tsx", ".ts", ".js" ],
    },
    target: "node",
};
