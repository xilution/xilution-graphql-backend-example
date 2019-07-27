import {ServerRoute} from "@hapi/hapi";

const PATH = "/";

export const get: ServerRoute = {
    handler: () => "Thank You Mario, But Our Princess is in Another Castle!",
    method: "GET",
    path: PATH,
};
