import {get as getHealth} from "./root/health/routes";
import {get as getRoot} from "./root/routes";
import {get as getVersion} from "./root/version/routes";

const routes = [
    getHealth,
    getRoot,
    getVersion,
];

export default routes;
