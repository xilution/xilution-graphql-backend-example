import axios, {AxiosResponse} from "axios";

export const resolveUri = async (
    accessToken: string,
    uri: string,
): Promise<AxiosResponse> => await axios.get(uri, {
    headers: {
        Authorization: `Bearer ${accessToken}`,
    },
    validateStatus: () => true,
});
