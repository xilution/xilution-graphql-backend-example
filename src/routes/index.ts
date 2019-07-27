import {get as getHealth} from "./root/health/routes";
import {get as getRoot} from "./root/routes";

const routes = [
    getHealth,
    getRoot,
];

export default routes;
