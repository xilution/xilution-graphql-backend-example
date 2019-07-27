/* tslint:disable:max-line-length */
export const buildFetchThingsUri = (
    env: string,
    type: string,
    pageNumber: number,
    pageSize: number,
) => `https://${env}.beagily.basics.api.xilution.com/things?type=${type}&page-number=${pageNumber}&page-size=${pageSize}`;
