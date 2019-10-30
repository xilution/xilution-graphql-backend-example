import {AxiosResponse} from "axios";
import {IXilutionAuthenticationResponse} from "../@types";
import {authenticate} from "../brokers/xilution-basics-zebra-broker";
import {getEnvironment} from "./environment-service";
import {ServiceError} from "./service-error";
import {getOrganizationId} from "./xilution-organization-service";

export const authenticateAccessToken = async (accessToken: string): Promise<IXilutionAuthenticationResponse> => {
    const environment: string = getEnvironment();
    const organizationId: string = getOrganizationId();
    const axiosResponse: AxiosResponse = await authenticate(environment, organizationId, accessToken);

    if (axiosResponse.status !== 200) {
        throw new ServiceError(
            axiosResponse.data.message,
            axiosResponse.status,
        );
    }

    return axiosResponse.data;
};
