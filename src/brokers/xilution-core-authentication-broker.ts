import axios, {AxiosResponse} from "axios";

const SCOPE = "read write";

const buildOAuthTokenUrl = (env: string): string => `https://${env}.authentication.core.api.xilution.com/oauth/token`;

export const authenticate = async (
    env: string,
    clientId: string,
    clientSecret: string,
): Promise<AxiosResponse> => await axios.post(buildOAuthTokenUrl(env), {
    client_id: clientId,
    client_secret: clientSecret,
    grant_type: "client_credentials",
    scope: SCOPE,
});
