/* tslint:disable:max-line-length */
import {GraphQLResolveInfo} from "graphql";
import {IPet} from "../../@types";
import {createPet, deletePet, fetchPets, getPet, updatePet} from "../../services/xilution-pet-service";

interface IContext {
    environment: string;
    accessToken: string;
}

export default {
    Mutation: {
        createPet: async (obj: any, args: {pet: IPet}, context: IContext, info: GraphQLResolveInfo) =>
            await createPet(context.environment, context.accessToken, args.pet),
        deletePet: async (obj: any, args: {id: string}, context: IContext, info: GraphQLResolveInfo) =>
            await deletePet(context.environment, context.accessToken, args.id),
        updatePet: async (obj: any, args: {id: string, pet: IPet}, context: IContext, info: GraphQLResolveInfo) =>
            await updatePet(context.environment, context.accessToken, args.id, args.pet),
    },
    Query: {
        pet: async (obj: any, args: {id: string}, context: IContext, info: GraphQLResolveInfo) =>
            await getPet(context.environment, context.accessToken, args.id),
        pets: async (obj: any, args: {sort: string, query: string, pageSize: number, pageNumber: number}, context: IContext, info: GraphQLResolveInfo) =>
            await fetchPets(context.environment, context.accessToken, args.sort, args.query, args.pageNumber, args.pageSize),
    },
};
/* tslint:enable */
