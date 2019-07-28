import {stringify} from "query-string";

export const buildFetchThingsUri = (
    environment: string,
    type: string,
    sort: string,
    query: string,
    pageNumber: number,
    pageSize: number,
): string => `https://${environment}.beagily.basics.api.xilution.com/things?${stringify({
    "page-number": pageNumber,
    "page-size": pageSize,
    "q": query,
    "sort": sort,
    "type": type,
})}`;

export const buildPostThingUri = (
    environment: string,
    type: string,
): string => `https://${environment}.beagily.basics.api.xilution.com/things?${stringify({type})}`;

export const buildPutThingUri = (
    environment: string,
    thingId: string,
    type: string,
): string => `https://${environment}.beagily.basics.api.xilution.com/things/${thingId}?${stringify({type})}`;

export const buildGetThingUri = (
    environment: string,
    thingId: string,
    type: string,
): string => `https://${environment}.beagily.basics.api.xilution.com/things/${thingId}?${stringify({type})}`;

export const buildDeleteThingUri = (
    environment: string,
    thingId: string,
    type: string,
): string => `https://${environment}.beagily.basics.api.xilution.com/things/${thingId}?${stringify({type})}`;
