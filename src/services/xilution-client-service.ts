export const getClientId = (): string => {
    const clientId: string | undefined = process.env.XILUTION_CLIENT_ID;

    if (clientId) {
        return clientId;
    }

    throw new Error("Unable to find XILUTION_CLIENT_ID environment variable.");
};

export const getClientSecret = (): string => {
    const clientSecret: string | undefined = process.env.XILUTION_CLIENT_SECRET;

    if (clientSecret) {
        return clientSecret;
    }

    throw new Error("Unable to find XILUTION_CLIENT_SECRET environment variable.");
};
