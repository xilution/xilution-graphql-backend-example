// import {ApolloServer} from "apollo-server-hapi";
// import * as Boom from "boom";
import CatboxMemory from "@hapi/catbox-memory";
import {Server, ServerMethodCache, ServerMethodOptions, ServerOptionsCache} from "@hapi/hapi";
import hash from "object-hash";
import routes from "./routes";
// import {getEnvironment} from "./services/environment-service";
import {getAccessToken} from "./services/xilution-access-token-service";

// import resolvers from "./graphql/resolvers";
// import typeDefs from "./graphql/type-defs";

const PORT = 3000;
const HOST = "0.0.0.0";

const init = async () => {
    // const apollo = new ApolloServer({
    //     context: async ({request}) => {
    //         try {
    //             const environment: string = getEnvironment();
    //             const accessToken: string = await request.server.methods.getXilutionAccessToken();
    //
    //             return ({
    //                 accessToken,
    //                 environment,
    //             });
    //         } catch (error) {
    //             return Boom.boomify(error, {
    //                 statusCode: error.statusCode,
    //             });
    //         }
    //     },
    //     resolvers,
    //     typeDefs,
    // });

    const server = new Server({
        cache: [
            {
                name: "server_cache",
                provider: {
                    constructor: CatboxMemory,
                },
            } as ServerOptionsCache,
        ],
        debug: {
            request: ["error"],
        },
        host: HOST,
        port: PORT,
        routes: {
            cors: true,
        },
    });

    const serverMethodCacheConfig = {
        cache: {
            cache: "server_cache",
            expiresIn: 60 * 60 * 1000,
            generateTimeout: 10000,
        } as ServerMethodCache,
        generateKey: (...args) => hash(args),
    } as ServerMethodOptions;

    await server.method(
        "getXilutionAccessToken",
        getAccessToken,
        serverMethodCacheConfig,
    );

    await server.route(routes);

    // await apollo.applyMiddleware({
    //     app: server,
    // });
    //
    // await apollo.installSubscriptionHandlers(server.listener);

    await server.start();
    // tslint:disable-next-line:no-console
    console.log("Server running on %s", server.info.uri);
};

process.on("unhandledRejection", (err) => {
    // tslint:disable-next-line:no-console
    console.log(err);
    process.exit(1);
});

init();
