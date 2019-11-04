import {AxiosResponse} from "axios";
import {getTokenWithClientCredentials} from "../brokers/xilution-basics-zebra-broker";
import {getEnvironment} from "./environment-service";
import {ServiceError} from "./service-error";
import {getClientId, getClientSecret} from "./xilution-client-service";
import {getSubOrganizationId} from "./xilution-sub-organization-service";

export const getAccessToken = async (): Promise<string> => {
    const environment: string = getEnvironment();
    const subOrganizationId: string = getSubOrganizationId();
    const clientId: string = getClientId();
    const clientSecret: string = getClientSecret();
    const axiosResponse: AxiosResponse = await getTokenWithClientCredentials(environment, subOrganizationId, clientId, clientSecret);

    if (axiosResponse.status !== 200) {
        throw new ServiceError(
            axiosResponse.data.message,
            axiosResponse.status,
        );
    }

    return axiosResponse.data.access_token;
};
