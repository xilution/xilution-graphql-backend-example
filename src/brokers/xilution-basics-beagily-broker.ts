import axios, {AxiosResponse} from "axios";
import {stringify} from "query-string";
import {IXilutionThing} from "../@types";

const SUB_DOMAIN = `beagily.basics.api.xilution.com`;

export const fetchThings = async (
    accessToken: string,
    environment: string,
    type: string,
    sort: string,
    query: string,
    pageNumber: number,
    pageSize: number,
): Promise<AxiosResponse> => await axios.get(
    `https://${environment}.${SUB_DOMAIN}/things?${stringify({
        "page-number": pageNumber,
        "page-size": pageSize,
        "q": query,
        "sort": sort,
        "type": type,
    })}`, {
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
        validateStatus: () => true,
    });

export const postThing = async (
    accessToken: string,
    environment: string,
    type: string,
    thing: IXilutionThing,
): Promise<AxiosResponse> => await axios.post(
    `https://${environment}.${SUB_DOMAIN}/things?${stringify({type})}`, thing, {
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
        validateStatus: () => true,
    },
);

export const putThing = async (
    accessToken: string,
    environment: string,
    thingId: string,
    type: string,
    thing: IXilutionThing,
): Promise<AxiosResponse> => await axios.put(
    `https://${environment}.${SUB_DOMAIN}/things/${thingId}?${stringify({type})}`, thing, {
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
        validateStatus: () => true,
    },
);

export const getThing = async (
    accessToken: string,
    environment: string,
    thingId: string,
    type: string,
): Promise<AxiosResponse> => await axios.get(
    `https://${environment}.${SUB_DOMAIN}/things/${thingId}?${stringify({type})}`, {
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
        validateStatus: () => true,
    },
);

export const deleteThing = async (
    accessToken: string,
    environment: string,
    thingId: string,
    type: string,
): Promise<AxiosResponse> => await axios.delete(
    `https://${environment}.${SUB_DOMAIN}/things/${thingId}?${stringify({type})}`, {
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
        validateStatus: () => true,
    },
);
