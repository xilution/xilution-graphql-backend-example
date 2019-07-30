export default `
type Pet {
    id: ID!
    owningUserId: String!
    createdAt: String!
    modifiedAt: String!
    name: String!
}
input NewPet {
    owningUserId: String!
    name: String!
}
input UpdatedPet {
    name: String!
}
`;
