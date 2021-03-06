import axios, {AxiosResponse} from "axios";
import {IXilutionAuthenticationResponse, IXilutionTokenResponse} from "../@types";

const SCOPE = "read write";
const SUB_DOMAIN = `zebra.basics.api.xilution.com`;

export const getTokenWithClientCredentials = async (
    env: string,
    subOrganizationId: string,
    clientId: string,
    clientSecret: string,
): Promise<AxiosResponse<IXilutionTokenResponse>> => await axios.post(
    `https://${env}.${SUB_DOMAIN}/organizations/${subOrganizationId}/oauth/token`,
    {
        client_id: clientId,
        client_secret: clientSecret,
        grant_type: "client_credentials",
        scope: SCOPE,
    },
    {
        validateStatus: () => true,
    },
);

export const authenticate = (
    env: string,
    subOrganizationId: string,
    accessToken: string,
): Promise<AxiosResponse<IXilutionAuthenticationResponse>> => axios.post(
    `https://${env}.${SUB_DOMAIN}/organizations/${subOrganizationId}/oauth/authenticate`, {
        access_token: accessToken,
    },
    {
        validateStatus: () => true,
    },
);
