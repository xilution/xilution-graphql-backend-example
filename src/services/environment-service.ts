import {ServiceError} from "./service-error";

export const getEnvironment = (): string => {
    const environment: string | undefined = process.env.XILUTION_ENVIRONMENT;

    if (environment) {
        return environment;
    }

    throw new ServiceError("Unable to find XILUTION_ENVIRONMENT environment variable.");
};
