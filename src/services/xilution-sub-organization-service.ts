import {ServiceError} from "./service-error";

export const getSubOrganizationId = (): string => {
    const subOrganizationId: string | undefined = process.env.XILUTION_SUB_ORGANIZATION_ID;

    if (subOrganizationId) {
        return subOrganizationId;
    }

    throw new ServiceError("Unable to find XILUTION_SUB_ORGANIZATION_ID environment variable.");
};
