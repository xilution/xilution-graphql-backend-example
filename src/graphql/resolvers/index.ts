/* tslint:disable:max-line-length */
import {IPet} from "../../@types";
import {createPet, deletePet, fetchPets, getPet, updatePet} from "../../services/xilution-pet-service";

interface IContext {
    environment: string;
    accessToken: string;
}

export default {
    Mutation: {
        createPet: async (parent: any, args: {pet: IPet}, context: IContext) =>
            await createPet(context.environment, context.accessToken, args.pet),
        deletePet: async (parent: any, args: {id: string}, context: IContext) =>
            await deletePet(context.environment, context.accessToken, args.id),
        updatePet: async (parent: any, args: {id: string, pet: IPet}, context: IContext) =>
            await updatePet(context.environment, context.accessToken, args.id, args.pet),
    },
    Query: {
        pet: async (parent: any, args: {id: string}, context: IContext) =>
            await getPet(context.environment, context.accessToken, args.id),
        pets: async (parent: any, args: {sort: string, query: string, pageSize: number, pageNumber: number}, context: IContext) =>
            await fetchPets(context.environment, context.accessToken, args.sort, args.query, args.pageNumber, args.pageSize),
    },
};
/* tslint:enable */
