import {ServiceError} from "./service-error";

export const getOrganizationId = (): string => {
    const organizationId: string | undefined = process.env.XILUTION_SUB_ORGANIZATION_ID;

    if (organizationId) {
        return organizationId;
    }

    throw new ServiceError("Unable to find XILUTION_SUB_ORGANIZATION_ID environment variable.");
};
