import {ServerRoute} from "@hapi/hapi";

const PATH = "/version";

export const get: ServerRoute = {
    handler: () => ({
        version: "1",
    }),
    method: "GET",
    options: {
        auth: false,
    },
    path: PATH,
};
