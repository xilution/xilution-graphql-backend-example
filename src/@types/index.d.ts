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

export interface IXilutionOrganization extends IXilutionThing {
    name: string;
}

export interface IXilutionClient extends IXilutionThing {
    name: string;
}

export interface IXilutionUser extends IXilutionThing {
    firstName: string;
    lastName: string;
}

export interface IXilutionTokenResponse {
    access_token: string;
}

export interface IXilutionAuthenticationResponse {
    organization: IXilutionOrganization;
    client: IXilutionClient;
    user: IXilutionUser;
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
