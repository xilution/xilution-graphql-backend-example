export default `
type Pets {
    content: [Pet!]!
    pageSize: Int!
    pageNumber: Int!
    totalPages: Int!
    numberOfElements: Int!
    totalElements: Int!
    firstPage: Boolean!
    lastPage: Boolean!
}
`;
