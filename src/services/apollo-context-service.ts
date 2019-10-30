import {boomify} from "@hapi/boom";
import {getEnvironment} from "./environment-service";

export const context = async ({request}) => {
    try {
        const environment: string = getEnvironment();
        const accessToken: string = await request.server.methods.getXilutionAccessToken();

        return ({
            accessToken,
            environment,
        });
    } catch (error) {
        return boomify(error, {
            statusCode: error.statusCode,
        });
    }
};
