import {ServerRoute} from "@hapi/hapi";

const PATH = "/";

export const get: ServerRoute = {
    handler: () => "xilution-graphql-backend-example",
    method: "GET",
    options: {
        auth: false,
    },
    path: PATH,
};
