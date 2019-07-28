export default `
type Pet {
    owningUserId: String!
    id: ID!
    name: String!
    createdAt: String!
}
input NewPet {
    owningUserId: String!
    name: String!
}
input UpdatedPet {
    name: String!
}
`;
