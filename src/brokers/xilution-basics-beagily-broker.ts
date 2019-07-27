import {AxiosResponse} from "axios";
import {resolveUri} from "./xilution-uri-broker";
import {buildFetchThingsUri} from "./xilution-uri-builder";

export const fetchThings = async (
    accessToken: string,
    env: string,
    type: string,
    pageNumber: number,
    pageSize: number,
): Promise<AxiosResponse> => await resolveUri(
    accessToken,
    buildFetchThingsUri(env, type, pageNumber, pageSize),
);
