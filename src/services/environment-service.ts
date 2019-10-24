export const getEnvironment = (): string => {
    const environment: string | undefined = process.env.XILUTION_ENVIRONMENT;

    if (environment) {
        return environment;
    }

    throw new Error("Unable to find XILUTION_ENVIRONMENT environment variable.");
};
