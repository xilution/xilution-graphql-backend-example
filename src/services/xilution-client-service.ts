import {ServiceError} from "./service-error";

export const getClientId = (): string => {
    const clientId: string | undefined = process.env.XILUTION_API_CLIENT_ID;

    if (clientId) {
        return clientId;
    }

    throw new ServiceError("Unable to find XILUTION_API_CLIENT_ID environment variable.");
};

export const getClientSecret = (): string => {
    const clientSecret: string | undefined = process.env.XILUTION_API_CLIENT_SECRET;

    if (clientSecret) {
        return clientSecret;
    }

    throw new ServiceError("Unable to find XILUTION_API_CLIENT_SECRET environment variable.");
};
