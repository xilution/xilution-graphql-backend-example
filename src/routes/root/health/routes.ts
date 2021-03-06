import {ServerRoute} from "@hapi/hapi";

const PATH = "/health";

export const get: ServerRoute = {
    handler: () => ({
        status: "API_HEALTHY",
    }),
    method: "GET",
    options: {
        auth: false,
    },
    path: PATH,
};
