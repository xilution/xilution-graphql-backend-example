import {AxiosResponse} from "axios";
import {IXilutionThing} from "../@types";
import {del, get, post, put} from "./axios-adapters";
import {
    buildDeleteThingUri,
    buildFetchThingsUri,
    buildGetThingUri,
    buildPostThingUri,
    buildPutThingUri,
} from "./xilution-uri-builder";

export const fetchThings = async (
    accessToken: string,
    environment: string,
    type: string,
    sort: string,
    query: string,
    pageNumber: number,
    pageSize: number,
    // tslint:disable-next-line:max-line-length
): Promise<AxiosResponse> => await get(buildFetchThingsUri(environment, type, sort, query, pageNumber, pageSize), accessToken);

export const postThing = async (
    accessToken: string,
    environment: string,
    type: string,
    thing: IXilutionThing,
): Promise<AxiosResponse> => await post(buildPostThingUri(environment, type), thing, accessToken);

export const putThing = async (
    accessToken: string,
    environment: string,
    thingId: string,
    type: string,
    thing: IXilutionThing,
): Promise<AxiosResponse> => await put(buildPutThingUri(environment, thingId, type), thing, accessToken);

export const getThing = async (
    accessToken: string,
    environment: string,
    thingId: string,
    type: string,
): Promise<AxiosResponse> => await get(buildGetThingUri(environment, thingId, type), accessToken);

export const deleteThing = async (
    accessToken: string,
    environment: string,
    thingId: string,
    type: string,
): Promise<AxiosResponse> => await del(buildDeleteThingUri(environment, thingId, type), accessToken);
