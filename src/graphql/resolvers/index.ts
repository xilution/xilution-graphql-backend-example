import {fetchTodos} from "../../services/xilution-todo-service";

export default {
    Query: {
        todos: async (parent: any, args: any, context: any) =>
            await fetchTodos(context.environment, context.accessToken),
    },
};
