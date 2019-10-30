import axios, {AxiosResponse} from "axios";
import {IPet, IXilutionFetchThingsResponse} from "../@types";
import {deleteThing, fetchThings, getThing, postThing, putThing} from "../brokers/xilution-basics-beagily-broker";
import {ServiceError} from "./service-error";

const TYPE = "pet";

export const fetchPets = async (
    environment: string,
    accessToken: string,
    sort: string,
    query: string,
    pageNumber: number,
    pageSize: number,
): Promise<IXilutionFetchThingsResponse> => {
    const fetchThingsResponse: AxiosResponse = await fetchThings(accessToken, environment, TYPE, sort, query, pageNumber, pageSize);

    if (fetchThingsResponse.status !== 200) {
        throw new ServiceError(
            fetchThingsResponse.data.message,
            fetchThingsResponse.status,
        );
    }

    return fetchThingsResponse.data as IXilutionFetchThingsResponse;
};

export const createPet = async (
    environment: string,
    accessToken: string,
    newPet: IPet,
): Promise<IPet> => {
    const postThingResponse: AxiosResponse = await postThing(
        accessToken, environment, TYPE, {"@type": TYPE, ...newPet});

    if (postThingResponse.status !== 201) {
        throw new ServiceError(
            postThingResponse.data.message,
            postThingResponse.status,
        );
    }

    // TODO - need to update Beagily to return a Location header with type included. This is a Beagily bug.
    const getThingResponse: AxiosResponse =
        await axios.get(`${postThingResponse.headers.location}?type=${TYPE}`, {
            headers: {
                Authorization: `Bearer ${accessToken}`,
            },
            validateStatus: () => true,
        });

    if (getThingResponse.status !== 200) {
        throw new ServiceError(
            getThingResponse.data.message,
            getThingResponse.status,
        );
    }

    return getThingResponse.data as IPet;
};

export const updatePet = async (
    environment: string,
    accessToken: string,
    petId: string,
    updatedPet: IPet,
): Promise<IPet> => {
    const getThingResponse: AxiosResponse = await getThing(accessToken, environment, petId, TYPE);

    if (getThingResponse.status !== 200) {
        throw new ServiceError(
            getThingResponse.data.message,
            getThingResponse.status,
        );
    }

    const updatedThing = {...getThingResponse.data, ...updatedPet};
    const putThingResponse: AxiosResponse = await putThing(
        accessToken, environment, petId, TYPE, updatedThing);

    if (putThingResponse.status !== 204) {
        throw new ServiceError(
            putThingResponse.data.message,
            putThingResponse.status,
        );
    }

    return updatedThing as IPet;
};

export const getPet = async (
    environment: string,
    accessToken: string,
    petId: string,
): Promise<IPet> => {
    const getThingResponse: AxiosResponse = await getThing(accessToken, environment, petId, TYPE);

    if (getThingResponse.status !== 200) {
        throw new ServiceError(
            getThingResponse.data.message,
            getThingResponse.status,
        );
    }

    return getThingResponse.data as IPet;
};

export const deletePet = async (
    environment: string,
    accessToken: string,
    petId: string,
): Promise<IPet> => {
    const getThingResponse: AxiosResponse = await getThing(accessToken, environment, petId, TYPE);

    if (getThingResponse.status !== 200) {
        throw new ServiceError(
            getThingResponse.data.message,
            getThingResponse.status,
        );
    }

    const deleteThingResponse: AxiosResponse = await deleteThing(accessToken, environment, petId, TYPE);

    if (deleteThingResponse.status !== 204) {
        throw new ServiceError(
            deleteThingResponse.data.message,
            deleteThingResponse.status,
        );
    }

    return getThingResponse.data as IPet;
};
