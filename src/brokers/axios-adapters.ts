import axios from "axios";
import {IXilutionThing} from "../@types";

export const get = async (url: string, accessToken: string) =>
    await axios.get(url, {
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
        validateStatus: () => true,
    });

export const post = async (url: string, thing: IXilutionThing, accessToken: string) =>
    await axios.post(url, thing, {
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
        validateStatus: () => true,
    });

export const put = async (url: string, thing: IXilutionThing, accessToken: string) =>
    await axios.put(url, thing, {
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
        validateStatus: () => true,
    });

export const del = async (url: string, accessToken: string) =>
    await axios.delete(url, {
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
        validateStatus: () => true,
    });
