import {AxiosResponse} from "axios";
import {IXilutionToken} from "../@types";
import {authenticate} from "../brokers/xilution-core-authentication-broker";
import {getEnvironment} from "./environment-service";
import {getClientId, getClientSecret} from "./xilution-client-service";

export const getAccessToken = async (): Promise<string> => {
    const environment: string = getEnvironment();
    const clientId: string = getClientId();
    const clientSecret: string = getClientSecret();
    const authenticationResponse: AxiosResponse = await authenticate(environment, clientId, clientSecret);
    const token = authenticationResponse.data as IXilutionToken;

    return token.access_token;
};
