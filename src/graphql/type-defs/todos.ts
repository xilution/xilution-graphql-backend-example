export default `
type Todos {
    content: [Todo]
    pageSize: Int
    pageNumber: Int
    totalPages: Int
    numberOfElements: Int
    totalElements: Int
    firstPage: Boolean
    lastPage: Boolean
}
`;
