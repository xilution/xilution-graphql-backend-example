import {boomify} from "@hapi/boom";
import {IXilutionAuthenticationResponse} from "../@types";

export const validate = async (request, accessToken) => {
    try {
        const authenticationResponse: IXilutionAuthenticationResponse =
            await request.server.methods.authenticateXilutionAccessToken(accessToken);
        const credentials = {token: accessToken};

        return {isValid: true, credentials, artifacts: authenticationResponse};
    } catch (error) {
        return boomify(error, {
            statusCode: error.statusCode,
        });
    }
};
