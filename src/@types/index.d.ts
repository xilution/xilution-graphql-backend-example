export interface IXilutionToken {
    access_token: string;
}

export interface IXilutionLink {
    rel: string;
    href: string;
}

export interface IXilutionThing {
    "@type": string;
    id?: string;
    owningUserId: string;
    createdAt?: string;
    modifiedAt?: string;
    links?: IXilutionLink[];
}

export interface IXilutionFetchThingsResponse {
    content: IXilutionThing[];
    pageSize: number;
    pageNumber: number;
    totalPages: number;
    numberOfElements: number;
    totalElements: number;
    firstPage: boolean;
    lastPage: boolean;
}

export interface IPet extends IXilutionThing {
    name: string;
}
