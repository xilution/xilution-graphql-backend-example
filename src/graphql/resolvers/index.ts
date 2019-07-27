import {fetchPets} from "../../services/xilution-pet-service";

export default {
    Query: {
        pets: async (parent: any, args: any, context: any) =>
            await fetchPets(context.environment, context.accessToken),
    },
};
