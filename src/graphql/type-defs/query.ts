export default `
type Query {
    pets(sort: String, query: String, pageNumber: Int = 0, pageSize: Int = 10): Pets!
    pet(id: String!): Pet!
}
`;
