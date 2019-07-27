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
}
