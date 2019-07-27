import {IXilutionFetchThingsResponse} from "../@types";

import {AxiosResponse} from "axios";
import {fetchThings} from "../brokers/xilution-basics-beagily-broker";

export const fetchTodos = async (
    environment: string,
    accessToken: string,
): Promise<IXilutionFetchThingsResponse> => {
    const type = "todo";
    const pageNumber = 0;
    const pageSize = 10;

    const fetchThingsResponse: AxiosResponse = await fetchThings(accessToken, environment, type, pageNumber, pageSize);

    return fetchThingsResponse.data as IXilutionFetchThingsResponse;
};
