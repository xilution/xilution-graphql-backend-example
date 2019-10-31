import {boomify} from "@hapi/boom";
import CatboxMemory from "@hapi/catbox-memory";
import {Server, ServerMethodCache, ServerMethodOptions, ServerOptionsCache} from "@hapi/hapi";
import {ApolloServer} from "apollo-server-hapi";
import AuthBearer from "hapi-auth-bearer-token";
import hash from "object-hash";
import routes from "./routes";
import {context} from "./services/apollo-context-service";
import {validate} from "./services/hapi-auth-service";
import {getAccessToken} from "./services/xilution-access-token-service";

import resolvers from "./graphql/resolvers";
import typeDefs from "./graphql/type-defs";
import {authenticateAccessToken} from "./services/xilution-authentication-service";

const PORT = 3123;
const HOST = "0.0.0.0";

const init = async () => {
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

    await server.register(AuthBearer);

    server.auth.strategy("token", "bearer-access-token", {validate});

    server.auth.default("token");

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

    await server.method(
        "authenticateXilutionAccessToken",
        authenticateAccessToken,
        serverMethodCacheConfig,
    );

    await server.route(routes);

    const apollo = new ApolloServer({
        context,
        introspection: true,
        resolvers,
        typeDefs,
    });

    await apollo.applyMiddleware({
        app: server,
    });

    await apollo.installSubscriptionHandlers(server.listener);

    await server.start();
    // tslint:disable-next-line:no-console
    console.log("Server running on %s", server.info.uri);
};

process.on("unhandledRejection", (err) => {
    // tslint:disable-next-line:no-console
    console.log(err);
    process.exit(1);
});

init().then();
